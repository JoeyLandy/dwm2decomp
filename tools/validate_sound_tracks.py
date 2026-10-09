#!/usr/bin/env python3
"""Runtime validation of the sound-track grammar and pitch formula against the emulator.

Runs the reference ROM on tools/sm83.py with varied scripted input and hooks the engine's
event fetch (Func_000_35CD, $35E7) and its frequency computation ($3938). Checks:
  * the fetch address equals base + 2*(position-1) (the 2-byte event grid);
  * the next fetch on a channel follows the model of tools/sound_tracks.py (plain events
    advance by one; FD defines labels, B0/B1-BF jump or repeat, AC/AD call and return);
    a fetch of event 2 is a restart of the track, counted separately;
  * the frequency the engine computes for each note equals (0x800 - (period >> octave)).
Commands that never run (see the printed "executed" list) are NOT validated by this run.

Usage: validate_sound_tracks.py INSTRUCTIONS   (e.g. 240000000, about 4-5 minutes)
"""
import sys,time,collections,random
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parent))
from sm83 import GameBoy
rom=(Path(__file__).resolve().parents[1]/'local/roms/dwm2-cobi-us.gbc').read_bytes()
g=GameBoy(rom)
H=lambda a: g.hram[a-0xFF80]
period=[[rom[0x3B5C+2*i]|(rom[0x3B5D+2*i]<<8) for i in range(12)],[rom[0x3B74+2*i]|(rom[0x3B75+2*i]<<8) for i in range(12)]]
st=collections.defaultdict(lambda: {'last':None,'labels':{},'counters':collections.defaultdict(int),'f4':0,'ret':None})
verified=collections.Counter(); stats=collections.Counter(); viol=[]; cmdcount=collections.Counter(); pend={}
def fetch(gb):
    ch=gb.rb(0xDD0F); base=H(0xFFDB)|(H(0xFFDC)<<8); pos=H(0xFFD8)|(H(0xFFD9)<<8)
    hl=(gb.h<<8)|gb.l; idx=pos-1
    s=st[(ch,base)]
    stats['fetches']+=1
    if hl!=base+2*idx: stats['ADDR_MISMATCH']+=1; viol.append(('addr',ch,hex(base),idx,hex(hl))); return
    stats['addr_ok']+=1
    b0=gb.rb(hl); b1=gb.rb(hl+1); cmdcount[b0 if b0>=0xA0 else 'note']+=1
    # check previous event's prediction against this fetch
    if s['last'] is not None:
        pidx,pb0,pb1,pred=s['last']
        if pred is not None:
            ok = (idx==pred)
            if not ok and idx==2:
                stats['restart_at_event_2']+=1; s['labels'].clear(); s['f4']=0; s['ret']=None
                ok=None
            else:
                stats['next_ok' if ok else 'NEXT_MISMATCH']+=1
                if ok: verified[pb0 if pb0>=0xA0 else 'note']+=1
            if ok is False and len(viol)<30: viol.append(('next',ch,hex(base),f'prev idx {pidx} {pb0:02X} {pb1:02X}',f'expected {pred}',f'got {idx}'))
    # model what happens after this event
    pred=idx+1
    if b0==0xFF: pred=None
    elif b0==0xFD: s['labels'][b1&15]=idx+1; s['counters'][b1&15]=0
    elif b0==0xB0:
        if b1&0xF0==0xF0:
            L=b1&15
            pred=s['labels'].get(L)
    elif 0xB1<=b0<=0xBF:
        L=b1&15; n=b0&15
        s['counters'][L]+=1
        if s['counters'][L] < n+1: pred=s['labels'].get(L)
    elif b0==0xAC:
        n=b1; f4=s['f4']
        if f4==1: s['f4']=0; pred=idx+2
        else:
            s['f4']= (f4-1) if f4>=1 else n
            tgt=gb.rb(hl+2)|(gb.rb(hl+3)<<8); pred=tgt//2; s['ret']=idx
    elif b0==0xAD: pred=s['ret']
    elif b0==0xA9 and b1 in (0xFE,0xFF): pred=None
    s['last']=(idx,b0,b1,pred)
    # note pitch check
    if b0<0xA0 and (b0&15)<12 and gb.rb(0xDD0A)!=3:
        tune=1 if H(0xFFDE)&0x10 else 0
        pend['note']=(b0, (0x800-(period[tune][b0&15]>>(b0>>4)))&0xFFFF)
g.pc_hooks[0x35E7]=fetch
def freq(gb):
    n=pend.pop('note',None)
    if n is None: return
    got=(gb.h<<8)|gb.l
    stats['pitch_ok' if got==n[1] else 'PITCH_MISMATCH']+=1
    if got!=n[1] and len(viol)<40: viol.append(('pitch',f'note {n[0]:02X}',f'want {n[1]:04X}',f'got {got:04X}'))
g.pc_hooks[0x3938]=freq
N=int(sys.argv[1]); done=0; t=time.time()
while done<N:
    r=random.Random(done); g.joy=0xFF if r.random()<0.35 else (0xFF^(1<<r.randrange(8))); g.run(60_000); done+=60_000
print(f'{done} instr, {time.time()-t:.0f}s'); print(dict(stats))
print('events whose successor matched the model, by command:',sorted((f'{k:02X}' if k!='note' else 'note',v) for k,v in verified.items()))
print('commands executed (first byte):',sorted((f'{k:02X}' if k!='note' else 'note',v) for k,v in cmdcount.items())[:40])
for v in viol[:12]: print('VIOLATION',v)
