#!/usr/bin/env python3
"""Minimal Game Boy Color emulator for dynamic analysis (own implementation, NOT verified
against hardware or a reference emulator).

Purpose: run the reference ROM far enough to observe which code moves data into VRAM and
WRAM. It models the SM83 CPU, MBC5 banking, CGB VRAM/WRAM banks, a coarse LCD/STAT clock,
OAM DMA, HDMA and (E-0406) the serial port between two linked instances (`link`). It does not model audio,
accurate timing, or most PPU behavior.
Anything learned from it is an OBSERVATION of this emulator and must be cross-checked
before being promoted past C1.
"""
from __future__ import annotations

R = "BCDEHL.A"


class GameBoy:
    link = None  # E-0406: class defaults, so states pickled before the serial model load
    serial_left = None

    def __init__(self, rom: bytes):
        self.rom = rom
        self.nrom = len(rom) // 0x4000
        self.vram = [bytearray(0x2000), bytearray(0x2000)]
        self.wram = [bytearray(0x1000) for _ in range(8)]
        self.sram = bytearray(0x8000)
        self.oam = bytearray(0xA0)
        self.hram = bytearray(0x80)
        self.io = bytearray(0x80)
        self.ie = 0
        self.rombank = 1
        self.rambank = 0
        self.ramen = False
        self.a, self.f, self.b, self.c, self.d, self.e, self.h, self.l = 0x11, 0x80, 0, 0, 0, 0xFF, 0, 0x0D
        self.sp, self.pc = 0xFFFE, 0x0100
        self.ime = False
        self.ime_pending = 0
        self.halted = False
        self.cycles = 0
        self.line_cycles = 0
        self.ly = 0
        self.joy = 0xFF  # bit clear = pressed: 0-3 right,left,up,down; 4-7 a,b,select,start
        self.io[0x40] = 0x91
        self.io[0x4D] = 0x00
        self.io[0x70] = 0x01
        self.hdma = None
        self.bgpal = bytearray(64)  # CGB palette RAM written through rBGPD / rOBPD
        self.objpal = bytearray(64)
        # observation hooks: callable(pc, kind, addr, value)
        self.on_write = None
        self.cur_pc = 0
        self.pc_hooks = {}  # address -> callable(gb), called before the instruction there runs
        self.on_rom_read = None  # callable(pc, bank, addr) for reads in the switchable window
        self.link = None  # E-0406: the other GameBoy on the cable, or None (nothing connected)
        self.serial_left = None  # cycles until a transfer this side clocks ends

    # ---- memory -------------------------------------------------------------
    def rb(self, a: int) -> int:
        if a < 0x4000:
            return self.rom[a]
        if a < 0x8000:
            if self.on_rom_read:
                self.on_rom_read(self.cur_pc, self.rombank, a)
            return self.rom[(self.rombank % self.nrom) * 0x4000 + a - 0x4000]
        if a < 0xA000:
            return self.vram[self.io[0x4F] & 1][a - 0x8000]
        if a < 0xC000:
            return self.sram[self.rambank * 0x2000 + a - 0xA000] if self.ramen else 0xFF
        if a < 0xD000:
            return self.wram[0][a - 0xC000]
        if a < 0xE000:
            return self.wram[max(1, self.io[0x70] & 7)][a - 0xD000]
        if a < 0xF000:
            return self.wram[0][a - 0xE000]
        if a < 0xFE00:
            return self.wram[max(1, self.io[0x70] & 7)][a - 0xF000]
        if a < 0xFEA0:
            return self.oam[a - 0xFE00]
        if a < 0xFF00:
            return 0xFF
        if a < 0xFF80:
            return self.rio(a - 0xFF00)
        if a < 0xFFFF:
            return self.hram[a - 0xFF80]
        return self.ie

    def rio(self, r: int) -> int:
        if r == 0x00:
            sel = self.io[0x00]
            v = 0xCF
            if not sel & 0x10:
                v &= 0xF0 | (self.joy & 0x0F)
            if not sel & 0x20:
                v &= 0xF0 | (self.joy >> 4)
            return v
        if r == 0x41:
            lcd_on = self.io[0x40] & 0x80
            if not lcd_on:
                mode = 0
            elif self.ly >= 144:
                mode = 1
            elif self.line_cycles < 80:
                mode = 2
            elif self.line_cycles < 252:
                mode = 3
            else:
                mode = 0
            return (self.io[0x41] & 0xF8) | (4 if self.ly == self.io[0x45] else 0) | mode | 0x80
        if r == 0x44:
            return self.ly
        if r == 0x4D:
            return self.io[0x4D] | 0x7E
        if r == 0x55:
            return 0xFF if self.hdma is None else (self.hdma[2] & 0x7F)
        if r == 0x69:
            return self.bgpal[self.io[0x68] & 0x3F]
        if r == 0x6B:
            return self.objpal[self.io[0x6A] & 0x3F]
        return self.io[r]

    def wb(self, a: int, v: int) -> None:
        v &= 0xFF
        if self.on_write:
            self.on_write(self.cur_pc, a, v)
        if a < 0x2000:
            self.ramen = (v & 0x0F) == 0x0A
        elif a < 0x3000:
            self.rombank = (self.rombank & 0x100) | v
        elif a < 0x4000:
            self.rombank = (self.rombank & 0xFF) | ((v & 1) << 8)
        elif a < 0x6000:
            self.rambank = v & 3
        elif a < 0x8000:
            pass
        elif a < 0xA000:
            self.vram[self.io[0x4F] & 1][a - 0x8000] = v
        elif a < 0xC000:
            if self.ramen:
                self.sram[self.rambank * 0x2000 + a - 0xA000] = v
        elif a < 0xD000:
            self.wram[0][a - 0xC000] = v
        elif a < 0xE000:
            self.wram[max(1, self.io[0x70] & 7)][a - 0xD000] = v
        elif a < 0xF000:
            self.wram[0][a - 0xE000] = v
        elif a < 0xFE00:
            self.wram[max(1, self.io[0x70] & 7)][a - 0xF000] = v
        elif a < 0xFEA0:
            self.oam[a - 0xFE00] = v
        elif a < 0xFF00:
            pass
        elif a < 0xFF80:
            self.wio(a - 0xFF00, v)
        elif a < 0xFFFF:
            self.hram[a - 0xFF80] = v
        else:
            self.ie = v

    def wio(self, r: int, v: int) -> None:
        if r == 0x46:  # OAM DMA, instantaneous
            for i in range(0xA0):
                self.oam[i] = self.rb((v << 8) + i)
        elif r == 0x44:
            self.ly = 0
            return
        elif r == 0x55:
            src = ((self.io[0x51] << 8) | self.io[0x52]) & 0xFFF0
            dst = (((self.io[0x53] << 8) | self.io[0x54]) & 0x1FF0) | 0x8000
            n = ((v & 0x7F) + 1) * 16
            if v & 0x80 and self.hdma is not None or v & 0x80:
                self.hdma = (src, dst, v & 0x7F, n)
                self.io[r] = v
                return
            if self.hdma is not None and not v & 0x80:
                self.hdma = None  # cancel a running HDMA
                return
            for i in range(n):  # general-purpose DMA
                self.vram[self.io[0x4F] & 1][(dst + i - 0x8000) & 0x1FFF] = self.rb((src + i) & 0xFFFF)
            if self.on_write:
                self.on_write(self.cur_pc, -1, n)  # -1 marks a bulk DMA of n bytes
            self.dma_log = getattr(self, "dma_log", [])
            self.dma_log.append((self.cur_pc, src, dst, n, self.io[0x4F] & 1))
            return
        elif r == 0x4D:
            self.io[r] = v & 1 | (self.io[r] & 0x80)
            return
        elif r in (0x69, 0x6B):
            idx_reg, ram = (0x68, self.bgpal) if r == 0x69 else (0x6A, self.objpal)
            idx = self.io[idx_reg]
            ram[idx & 0x3F] = v
            if idx & 0x80:  # auto-increment
                self.io[idx_reg] = 0x80 | ((idx + 1) & 0x3F)
            return
        elif r == 0x0F:
            self.io[r] = v & 0x1F
            return
        elif r == 0x02:  # E-0406: SC. Bit 7 starts a transfer; with bit 0 (internal clock) this side clocks it
            self.io[r] = v
            self.serial_left = ((128 if v & 0x02 else 4096) if v & 0x81 == 0x81 and self.link is not None else None)
            return
        self.io[r] = v

    # ---- helpers ------------------------------------------------------------
    def r8(self, i):
        if i == 0: return self.b
        if i == 1: return self.c
        if i == 2: return self.d
        if i == 3: return self.e
        if i == 4: return self.h
        if i == 5: return self.l
        if i == 6: return self.rb((self.h << 8) | self.l)
        return self.a

    def s8(self, i, v):
        v &= 0xFF
        if i == 0: self.b = v
        elif i == 1: self.c = v
        elif i == 2: self.d = v
        elif i == 3: self.e = v
        elif i == 4: self.h = v
        elif i == 5: self.l = v
        elif i == 6: self.wb((self.h << 8) | self.l, v)
        else: self.a = v

    def fetch(self):
        v = self.rb(self.pc)
        self.pc = (self.pc + 1) & 0xFFFF
        return v

    def fetch16(self):
        lo = self.fetch()
        return lo | (self.fetch() << 8)

    def push(self, v):
        self.sp = (self.sp - 1) & 0xFFFF
        self.wb(self.sp, v >> 8)
        self.sp = (self.sp - 1) & 0xFFFF
        self.wb(self.sp, v & 0xFF)

    def pop(self):
        lo = self.rb(self.sp)
        self.sp = (self.sp + 1) & 0xFFFF
        hi = self.rb(self.sp)
        self.sp = (self.sp + 1) & 0xFFFF
        return lo | (hi << 8)

    def rr16(self, i):
        if i == 0: return (self.b << 8) | self.c
        if i == 1: return (self.d << 8) | self.e
        if i == 2: return (self.h << 8) | self.l
        return self.sp

    def sr16(self, i, v):
        v &= 0xFFFF
        if i == 0: self.b, self.c = v >> 8, v & 0xFF
        elif i == 1: self.d, self.e = v >> 8, v & 0xFF
        elif i == 2: self.h, self.l = v >> 8, v & 0xFF
        else: self.sp = v

    def cond(self, i):
        if i == 0: return not self.f & 0x80
        if i == 1: return bool(self.f & 0x80)
        if i == 2: return not self.f & 0x10
        return bool(self.f & 0x10)

    def alu(self, op, v):
        a = self.a
        if op == 0 or op == 1:  # add / adc
            c = 1 if op == 1 and self.f & 0x10 else 0
            r = a + v + c
            self.f = (0x80 if r & 0xFF == 0 else 0) | (0x20 if (a & 0xF) + (v & 0xF) + c > 0xF else 0) | (0x10 if r > 0xFF else 0)
            self.a = r & 0xFF
        elif op in (2, 3, 7):  # sub / sbc / cp
            c = 1 if op == 3 and self.f & 0x10 else 0
            r = a - v - c
            self.f = 0x40 | (0x80 if r & 0xFF == 0 else 0) | (0x20 if (a & 0xF) - (v & 0xF) - c < 0 else 0) | (0x10 if r < 0 else 0)
            if op != 7:
                self.a = r & 0xFF
        elif op == 4:
            self.a = a & v
            self.f = 0x20 | (0x80 if self.a == 0 else 0)
        elif op == 5:
            self.a = a ^ v
            self.f = 0x80 if self.a == 0 else 0
        else:
            self.a = a | v
            self.f = 0x80 if self.a == 0 else 0

    def cb(self):
        op = self.fetch()
        r, y = op & 7, (op >> 3) & 7
        v = self.r8(r)
        if op < 0x40:
            c = 1 if self.f & 0x10 else 0
            if y == 0: res = ((v << 1) | (v >> 7)) & 0xFF; co = v >> 7
            elif y == 1: res = ((v >> 1) | (v << 7)) & 0xFF; co = v & 1
            elif y == 2: res = ((v << 1) | c) & 0xFF; co = v >> 7
            elif y == 3: res = (v >> 1) | (c << 7); co = v & 1
            elif y == 4: res = (v << 1) & 0xFF; co = v >> 7
            elif y == 5: res = (v >> 1) | (v & 0x80); co = v & 1
            elif y == 6: res = ((v << 4) | (v >> 4)) & 0xFF; co = 0
            else: res = v >> 1; co = v & 1
            self.f = (0x80 if res == 0 else 0) | (0x10 if co else 0)
            self.s8(r, res)
        elif op < 0x80:
            self.f = (self.f & 0x10) | 0x20 | (0x80 if not v & (1 << y) else 0)
        elif op < 0xC0:
            self.s8(r, v & ~(1 << y))
        else:
            self.s8(r, v | (1 << y))
        return 16 if r == 6 else 8

    # ---- one instruction ----------------------------------------------------
    def step(self) -> int:
        if self.halted:
            return 4
        hook = self.pc_hooks.get(self.pc)
        if hook:
            hook(self)
        self.cur_pc = self.pc
        op = self.fetch()
        cyc = 4
        if op == 0x00: pass
        elif op == 0x10:
            self.fetch()
            if self.io[0x4D] & 1:
                self.io[0x4D] = (self.io[0x4D] ^ 0x80) & 0xFE
        elif op == 0x76: self.halted = True
        elif op == 0xF3: self.ime = False; self.ime_pending = 0
        elif op == 0xFB: self.ime_pending = 2
        elif op == 0xCB: cyc = self.cb()
        elif op & 0xC0 == 0x40:
            self.s8((op >> 3) & 7, self.r8(op & 7)); cyc = 8 if (op & 7 == 6 or (op >> 3) & 7 == 6) else 4
        elif op & 0xC0 == 0x80:
            self.alu((op >> 3) & 7, self.r8(op & 7)); cyc = 8 if op & 7 == 6 else 4
        elif op & 0xC7 == 0xC6:
            self.alu((op >> 3) & 7, self.fetch()); cyc = 8
        elif op & 0xC7 == 0x06:
            self.s8((op >> 3) & 7, self.fetch()); cyc = 12 if (op >> 3) & 7 == 6 else 8
        elif op & 0xC7 == 0x04:
            r = (op >> 3) & 7; v = (self.r8(r) + 1) & 0xFF
            self.f = (self.f & 0x10) | (0x80 if v == 0 else 0) | (0x20 if v & 0xF == 0 else 0); self.s8(r, v); cyc = 12 if r == 6 else 4
        elif op & 0xC7 == 0x05:
            r = (op >> 3) & 7; v = (self.r8(r) - 1) & 0xFF
            self.f = (self.f & 0x10) | 0x40 | (0x80 if v == 0 else 0) | (0x20 if v & 0xF == 0xF else 0); self.s8(r, v); cyc = 12 if r == 6 else 4
        elif op & 0xCF == 0x01: self.sr16((op >> 4) & 3, self.fetch16()); cyc = 12
        elif op & 0xCF == 0x03: self.sr16((op >> 4) & 3, self.rr16((op >> 4) & 3) + 1); cyc = 8
        elif op & 0xCF == 0x0B: self.sr16((op >> 4) & 3, self.rr16((op >> 4) & 3) - 1); cyc = 8
        elif op & 0xCF == 0x09:
            hl = self.rr16(2); v = self.rr16((op >> 4) & 3); r = hl + v
            self.f = (self.f & 0x80) | (0x20 if (hl & 0xFFF) + (v & 0xFFF) > 0xFFF else 0) | (0x10 if r > 0xFFFF else 0)
            self.sr16(2, r); cyc = 8
        elif op == 0x02: self.wb(self.rr16(0), self.a); cyc = 8
        elif op == 0x12: self.wb(self.rr16(1), self.a); cyc = 8
        elif op == 0x0A: self.a = self.rb(self.rr16(0)); cyc = 8
        elif op == 0x1A: self.a = self.rb(self.rr16(1)); cyc = 8
        elif op == 0x22: hl = self.rr16(2); self.wb(hl, self.a); self.sr16(2, hl + 1); cyc = 8
        elif op == 0x2A: hl = self.rr16(2); self.a = self.rb(hl); self.sr16(2, hl + 1); cyc = 8
        elif op == 0x32: hl = self.rr16(2); self.wb(hl, self.a); self.sr16(2, hl - 1); cyc = 8
        elif op == 0x3A: hl = self.rr16(2); self.a = self.rb(hl); self.sr16(2, hl - 1); cyc = 8
        elif op == 0x07: c = self.a >> 7; self.a = ((self.a << 1) | c) & 0xFF; self.f = 0x10 if c else 0
        elif op == 0x0F: c = self.a & 1; self.a = (self.a >> 1) | (c << 7); self.f = 0x10 if c else 0
        elif op == 0x17: c = self.a >> 7; self.a = ((self.a << 1) | (1 if self.f & 0x10 else 0)) & 0xFF; self.f = 0x10 if c else 0
        elif op == 0x1F: c = self.a & 1; self.a = (self.a >> 1) | (0x80 if self.f & 0x10 else 0); self.f = 0x10 if c else 0
        elif op == 0x27:
            a = self.a
            if not self.f & 0x40:
                if self.f & 0x10 or a > 0x99: a += 0x60; self.f |= 0x10
                if self.f & 0x20 or (a & 0xF) > 9: a += 6
            else:
                if self.f & 0x10: a -= 0x60
                if self.f & 0x20: a -= 6
            self.a = a & 0xFF
            self.f = (self.f & 0x50) | (0x80 if self.a == 0 else 0)
        elif op == 0x2F: self.a ^= 0xFF; self.f |= 0x60
        elif op == 0x37: self.f = (self.f & 0x80) | 0x10
        elif op == 0x3F: self.f = (self.f & 0x80) | (0 if self.f & 0x10 else 0x10)
        elif op == 0x08: a = self.fetch16(); self.wb(a, self.sp & 0xFF); self.wb(a + 1, self.sp >> 8); cyc = 20
        elif op == 0x18: o = self.fetch(); self.pc = (self.pc + (o - 256 if o & 0x80 else o)) & 0xFFFF; cyc = 12
        elif op & 0xE7 == 0x20:
            o = self.fetch()
            if self.cond((op >> 3) & 3): self.pc = (self.pc + (o - 256 if o & 0x80 else o)) & 0xFFFF; cyc = 12
            else: cyc = 8
        elif op == 0xC3: self.pc = self.fetch16(); cyc = 16
        elif op == 0xE9: self.pc = self.rr16(2)
        elif op & 0xE7 == 0xC2:
            a = self.fetch16()
            if self.cond((op >> 3) & 3): self.pc = a; cyc = 16
            else: cyc = 12
        elif op == 0xCD: a = self.fetch16(); self.push(self.pc); self.pc = a; cyc = 24
        elif op & 0xE7 == 0xC4:
            a = self.fetch16()
            if self.cond((op >> 3) & 3): self.push(self.pc); self.pc = a; cyc = 24
            else: cyc = 12
        elif op == 0xC9: self.pc = self.pop(); cyc = 16
        elif op == 0xD9: self.pc = self.pop(); self.ime = True; cyc = 16
        elif op & 0xE7 == 0xC0:
            if self.cond((op >> 3) & 3): self.pc = self.pop(); cyc = 20
            else: cyc = 8
        elif op & 0xC7 == 0xC7: self.push(self.pc); self.pc = op & 0x38; cyc = 16
        elif op & 0xCF == 0xC1:
            v = self.pop(); i = (op >> 4) & 3
            if i == 3: self.a, self.f = v >> 8, v & 0xF0
            else: self.sr16(i, v)
            cyc = 12
        elif op & 0xCF == 0xC5:
            i = (op >> 4) & 3
            self.push(((self.a << 8) | self.f) if i == 3 else self.rr16(i)); cyc = 16
        elif op == 0xE0: self.wb(0xFF00 | self.fetch(), self.a); cyc = 12
        elif op == 0xF0: self.a = self.rb(0xFF00 | self.fetch()); cyc = 12
        elif op == 0xE2: self.wb(0xFF00 | self.c, self.a); cyc = 8
        elif op == 0xF2: self.a = self.rb(0xFF00 | self.c); cyc = 8
        elif op == 0xEA: self.wb(self.fetch16(), self.a); cyc = 16
        elif op == 0xFA: self.a = self.rb(self.fetch16()); cyc = 16
        elif op == 0xE8 or op == 0xF8:
            o = self.fetch(); s = o - 256 if o & 0x80 else o
            r = self.sp + s
            self.f = (0x20 if (self.sp & 0xF) + (o & 0xF) > 0xF else 0) | (0x10 if (self.sp & 0xFF) + o > 0xFF else 0)
            if op == 0xE8: self.sp = r & 0xFFFF; cyc = 16
            else: self.sr16(2, r); cyc = 12
        elif op == 0xF9: self.sp = self.rr16(2); cyc = 8
        else:
            raise RuntimeError(f"invalid opcode {op:02X} at {self.cur_pc:04X}")
        return cyc

    # ---- clock and interrupts ----------------------------------------------
    def serial_done(self) -> None:
        """E-0406: the end of a transfer this side clocked (8 bits). When the other side has a transfer started (SC
        bit 7; waiting on the external clock, or clocking too, as the game's per-frame exchange does on both
        consoles) the two SB bytes are swapped and both transfers end with the serial interrupt; otherwise $FF
        comes in (the line idles high). A model, not checked against hardware. Without a cable (`link` None) no
        transfer ends at all, as before this model: the observations made so far assumed that, though real hardware
        would end it with $FF."""
        peer = self.link
        if peer is not None and peer.io[0x02] & 0x80:  # the partner has a transfer started (either clock)
            self.io[0x01], peer.io[0x01] = peer.io[0x01], self.io[0x01]
            peer.io[0x02] &= 0x7F
            peer.io[0x0F] |= 0x08
            peer.serial_left = None  # two clocking sides: one exchange ends both
        else:
            self.io[0x01] = 0xFF
        self.io[0x02] &= 0x7F
        self.io[0x0F] |= 0x08
        self.serial_left = None

    def tick(self, cyc: int) -> None:
        self.cycles += cyc
        if self.serial_left is not None:
            self.serial_left -= cyc
            if self.serial_left <= 0:
                self.serial_done()
        self.io[0x04] = (self.io[0x04] + (cyc >> 6)) & 0xFF
        if not self.io[0x40] & 0x80:
            self.line_cycles = (self.line_cycles + cyc) % 456
            self.ly = 0
            return
        self.line_cycles += cyc
        while self.line_cycles >= 456:
            self.line_cycles -= 456
            self.ly = (self.ly + 1) % 154
            if self.ly == 144:
                self.io[0x0F] |= 0x01
            if self.hdma is not None and self.ly < 144:
                src, dst, left, n = self.hdma
                for i in range(16):
                    self.vram[self.io[0x4F] & 1][(dst + i - 0x8000) & 0x1FFF] = self.rb((src + i) & 0xFFFF)
                dl = getattr(self, "dma_log", [])
                dl.append((self.cur_pc, src, dst, 16, self.io[0x4F] & 1))
                self.dma_log = dl
                self.hdma = None if left == 0 else (src + 16, dst + 16, left - 1, n)
                if left == 0:
                    self.io[0x55] = 0xFF
            if self.ly == self.io[0x45] and self.io[0x41] & 0x40:
                self.io[0x0F] |= 0x02

    def service(self) -> None:
        if self.ime_pending:
            self.ime_pending -= 1
            if self.ime_pending == 0:
                self.ime = True
        pend = self.io[0x0F] & self.ie & 0x1F
        if pend:
            self.halted = False
            if self.ime:
                for bit in range(5):
                    if pend & (1 << bit):
                        self.ime = False
                        self.io[0x0F] &= ~(1 << bit)
                        self.push(self.pc)
                        self.pc = 0x40 + 8 * bit
                        self.tick(20)
                        return

    def run(self, max_instructions: int) -> int:
        n = 0
        while n < max_instructions:
            if self.halted:
                self.tick(456 - self.line_cycles if self.io[0x40] & 0x80 else 456)
            else:
                self.tick(self.step())
            self.service()
            n += 1
        return n
