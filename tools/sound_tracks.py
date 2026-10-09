#!/usr/bin/env python3
"""Decoder for the sound track streams read by Func_000_35CD (C2 where noted in E-0019).

A track is a sequence of 2-byte events starting at the pointer in a sound record. The
first two events are a 4-byte HEADER read by the channel-start code (Jump_000_3554) and
playback begins at event 2 ($FFD8 = 2). The engine keeps a position counted in events (HRAM
$FFD8/$FFD9) and fetches the event at base + 2*position.

Header: byte 0 low nibble -> $FFDF and $FFDE low nibble; byte 1 -> $FFDE bits 7-6 (bits 1-0 of
the byte; wave channel: $FFE6 = byte 1); byte 2 -> $FFE0 = swap(byte 2) (initial volume
nibble in the high half); byte 3 -> $FFE2. Names below describe the observable effect on engine state or hardware
registers; they claim nothing about the music beyond that.

First byte of an event:
  $00-$9F  note: high nibble = octave (period shifted right by it), low nibble = semitone
           ($0C-$0F = no pitch, the channel is silenced); operand = duration in ticks.
           The noise channel (index 3) takes a different, table-driven path.
  $A0-$AF  channel settings (see COMMANDS)
  $B0      operand with high nibble $F: jump to the label in its low nibble; else no effect
  $B1-$BF  repeat the section from label (operand & $0F) n more times
  $C0-$CF  sets $FFE5/$FFE6 (high nibble n << 4, operand); skipped on the wave channel
  $D0-$DF  / $E0-$EF  step +n / -n and an interval: sets $FFE8, $FFE9/$FFEA
  $F0-$FC, $FE  skipped by the engine (operand ignored)
  $FD      defines label (operand & $0F) at the next event
  $FF      ends the channel; the operand byte may be missing
`AC` consumes a second event: a little-endian BYTE OFFSET from the track base.

Usage: sound_tracks.py BANK ADDR [--events N]   (hex)  -> prints a decoded listing
"""
from __future__ import annotations

import sys
from pathlib import Path

NOTE_NAMES = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]

# first byte -> (mnemonic, effect). Ranges are expanded in describe().
COMMANDS = {
    0xA0: ("volume", "$FFE0 = swap(operand); writes the envelope register (NRx2) if the channel is audible"),
    0xA1: ("duty", "$FFE2 = operand (wave channel: loads wave pattern operand)"),
    0xA2: ("duty2", "pulse: $FFDE bits 7-6 = operand bits 3-2; wave: $FFE6 = operand"),
    0xA3: ("mod", "$FFEF = $FFF0 = 2*(operand & 15); high nibble of $FFDA from operand (FE clears it)"),
    0xA5: ("pan", "$FFEE = operand (operand 1 swaps its nibbles)"),
    0xA6: ("mastervol", "NR50 ($FF24) = operand"),
    0xA7: ("wait", "$FFE1 = operand ticks, then refreshes the channel-enable bits"),
    0xA8: ("instrument", "$FFF1 = operand"),
    0xA9: ("counter", "operand 00-7F: $FFE4 = operand; 80-FF: $DD18 = operand-80; F0/F1 inc/dec $FFE4; "
                      "F2/F3 inc/dec $DD18; FE/FF: jump through the word table that follows"),
    0xAA: ("slide", "operand high nibble 0: clear $FFF2/$FFED/$FFF3; else $FFF2, $FFF3, $FFED from operand"),
    0xAC: ("call", "repeat counter $FFF4 (operand); target = next event as a byte offset; AD returns"),
    0xAD: ("return", "position = saved $FFF5/$FFF6"),
    0xAE: ("tuning", "$FFDE bit 4 = operand bit 4 (selects the second period table)"),
    0xAF: ("param", "$FFDF = $FFDE low nibble = operand & 15"),
}
SKIPPED = {0xA4, 0xAB} | set(range(0xF0, 0xFD)) | {0xFE}  # engine falls through to "skip event"


def classify(b0: int):
    """Return (kind, mnemonic, description) for a first byte."""
    if b0 < 0xA0:
        return "note", "note" if (b0 & 0x0F) < 0x0C else "rest", ""
    if 0xA0 <= b0 <= 0xAF:
        if b0 in COMMANDS:
            m, d = COMMANDS[b0]
            return ("call" if b0 == 0xAC else "ret" if b0 == 0xAD else "set"), m, d
        return "skip", "skip", "unhandled by the engine; the event is skipped"
    if b0 == 0xB0:
        return "jump", "jump", "operand F?: jump to label ?; otherwise no effect"
    if 0xB1 <= b0 <= 0xBF:
        return "repeat", "repeat", f"repeat {b0 & 15} more time(s) from label (operand & 15)"
    if 0xC0 <= b0 <= 0xCF:
        return "set", "env", "$FFE6 = operand and $FFE5 = n << 4 (not on the wave channel)"
    if 0xD0 <= b0 <= 0xDF:
        return "set", "step+", f"$FFE8 = +{b0 & 15}; $FFE9 = $FFEA = operand"
    if 0xE0 <= b0 <= 0xEF:
        return "set", "step-", f"$FFE8 = -{b0 & 15}; $FFE9 = $FFEA = operand"
    if b0 == 0xFD:
        return "label", "label", "defines label (operand & 15) here"
    if b0 == 0xFF:
        return "end", "end", "ends the channel"
    return "skip", "skip", "unhandled by the engine; the event is skipped"


def decode_event(data: bytes, off: int):
    """Decode the event at `off`; return (event dict, bytes consumed)."""
    b0 = data[off]
    b1 = data[off + 1] if off + 1 < len(data) else None
    kind, mn, desc = classify(b0)
    ev = {"off": off, "b0": b0, "b1": b1, "kind": kind, "mnemonic": mn, "desc": desc}
    used = 2
    if kind == "note":
        octave, semi = b0 >> 4, b0 & 0x0F
        ev["text"] = (f"note {NOTE_NAMES[semi]}{octave} dur {b1}" if semi < 12
                      else f"rest-note ${b0:02X} dur {b1}")
    elif kind == "label":
        ev["text"] = f"label {b1 & 15}" if b1 is not None else "label ?"
    elif kind == "call" and off + 3 < len(data):
        ev["target"] = data[off + 2] | (data[off + 3] << 8)
        ev["text"] = f"call x{b1} -> offset ${ev['target']:04X}"
        used = 4
    elif kind == "end":
        ev["text"] = "end"
        used = 2 if b1 is not None else 1
    else:
        ev["text"] = f"{mn} ${b1:02X}" if b1 is not None else mn
    return ev, used


def decode_header(data: bytes, start: int):
    """The 4-byte header at the start of a track."""
    b = data[start:start + 4]
    return {"off": start, "bytes": b, "param": b[0] & 15, "duty_bits": b[1] & 3, "byte1": b[1],
            "volume_nibble": b[2] & 15, "volume_swapped": ((b[2] << 4) | (b[2] >> 4)) & 0xFF, "byte3": b[3],
            "text": f"header param={b[0] & 15} byte1=${b[1]:02X} volume=${b[2]:02X} byte3=${b[3]:02X}"}


def decode_track(data: bytes, start: int, limit: int):
    """Decode events linearly from `start` (the track base) until the first `end` event or
    `limit`, skipping the 4-byte header. Returns (events, end_offset); end_offset is just
    past the terminator. Event offsets are absolute within `data`."""
    events, off = [], start + 4
    while off + 1 <= limit:
        ev, used = decode_event(data, off)
        events.append(ev)
        off += used
        if ev["kind"] == "end":
            break
    return events, off


def decode_region(data: bytes, start: int, end: int):
    """Decode a whole track region [start, end) including sections that follow a mid-track
    `end` event (reached by jumps). Returns the events, or None if the region does not
    decode in alignment. A final `FF` whose operand byte is missing (the next track begins
    right after it) is accepted and marked with b1 = None."""
    events, off = [], start + 4
    if end - start < 4:
        return None
    while off < end:
        ev, used = decode_event(data, off)
        if off + used > end:
            if ev["kind"] == "end" and off + 1 == end:  # lone FF closes the region
                ev["b1"], ev["text"], used = None, "end", 1
            else:
                return None
        events.append(ev)
        off += used
    return events if off == end else None


def main() -> int:
    rom = (Path(__file__).resolve().parents[1] / "local/roms/dwm2-cobi-us.gbc").read_bytes()
    bank, addr = int(sys.argv[1], 16), int(sys.argv[2], 16)
    n = int(sys.argv[sys.argv.index("--events") + 1]) if "--events" in sys.argv else 40
    base = bank * 0x4000
    bankdata = rom[base:base + 0x4000]
    events, end = decode_track(bankdata, addr - 0x4000, 0x4000)
    print(f"{addr:04X}  header          {bankdata[addr - 0x4000:addr - 0x4000 + 4].hex(' ')}  "
          f"{decode_header(bankdata, addr - 0x4000)['text']}")
    for ev in events[:n]:
        pos = (ev["off"] - (addr - 0x4000)) // 2
        raw = f"{ev['b0']:02X} {ev['b1']:02X}" if ev["b1"] is not None else f"{ev['b0']:02X}"
        print(f"{0x4000 + ev['off']:04X}  event {pos:4d}  {raw:<6}  {ev['text']}")
    print(f"... {len(events)} events, first terminator ends at ${0x4000 + end:04X}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
