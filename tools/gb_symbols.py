#!/usr/bin/env python3
"""Standard Game Boy / CGB hardware symbols used when rendering operands (HARDWARE facts).

Register names and addresses follow Pan Docs and the conventional hardware.inc names; they
are documented platform facts, not findings about this game. `write_hardware_inc` emits the
`DEF name EQU value` file that src/main.asm includes before the banks.
"""
from __future__ import annotations

# I/O registers, $FF00-$FF7F, and IE.
IO = {
    0xFF00: "rP1", 0xFF01: "rSB", 0xFF02: "rSC", 0xFF04: "rDIV", 0xFF05: "rTIMA", 0xFF06: "rTMA",
    0xFF07: "rTAC", 0xFF0F: "rIF",
    0xFF10: "rNR10", 0xFF11: "rNR11", 0xFF12: "rNR12", 0xFF13: "rNR13", 0xFF14: "rNR14",
    0xFF16: "rNR21", 0xFF17: "rNR22", 0xFF18: "rNR23", 0xFF19: "rNR24",
    0xFF1A: "rNR30", 0xFF1B: "rNR31", 0xFF1C: "rNR32", 0xFF1D: "rNR33", 0xFF1E: "rNR34",
    0xFF20: "rNR41", 0xFF21: "rNR42", 0xFF22: "rNR43", 0xFF23: "rNR44",
    0xFF24: "rNR50", 0xFF25: "rNR51", 0xFF26: "rNR52",
    0xFF40: "rLCDC", 0xFF41: "rSTAT", 0xFF42: "rSCY", 0xFF43: "rSCX", 0xFF44: "rLY", 0xFF45: "rLYC",
    0xFF46: "rDMA", 0xFF47: "rBGP", 0xFF48: "rOBP0", 0xFF49: "rOBP1", 0xFF4A: "rWY", 0xFF4B: "rWX",
    0xFF4D: "rKEY1", 0xFF4F: "rVBK",
    0xFF51: "rHDMA1", 0xFF52: "rHDMA2", 0xFF53: "rHDMA3", 0xFF54: "rHDMA4", 0xFF55: "rHDMA5",
    0xFF56: "rRP", 0xFF68: "rBGPI", 0xFF69: "rBGPD", 0xFF6A: "rOBPI", 0xFF6B: "rOBPD", 0xFF70: "rSVBK",
    0xFFFF: "rIE",
}
for _a in range(0xFF30, 0xFF40):
    IO[_a] = f"rWAVE{_a - 0xFF30:X}"  # wave pattern RAM

# MBC5 registers (write-only). A register decodes a whole address range, so the names below
# are the specific addresses THIS game writes (counted in the generated source): RAM enable
# ($0000-$1FFF) at $0100 and $1FFF, ROM bank low ($2000-$2FFF) at $2100, ROM bank bit 8
# ($3000-$3FFF) at $3100, RAM bank ($4000-$5FFF) at $4100.
MBC = {0x0100: "rRAMG", 0x1FFF: "rRAMG2", 0x2100: "rROMB0", 0x3100: "rROMB1", 0x4100: "rRAMB"}
# `ld a, [$4000]` reads (not writes) the first byte of the current switchable bank.
BANK_NUMBER_BYTE = ("BANK_NUMBER_BYTE", 0x4000)

# VRAM regions (base names, address).
VRAM = [(0x9C00, "vBGMap1"), (0x9800, "vBGMap0"), (0x9000, "vTiles2"), (0x8800, "vTiles1"),
        (0x8000, "vTiles0")]
HRAM_START, HRAM_END = 0xFF80, 0xFFFE

# What each register does (Pan Docs; HARDWARE facts), written as the comment of its DEF line.
DESCRIPTION = {
    "rP1": "joypad: write bit 4 or 5 low to select the d-pad or the buttons, read bits 0-3 (0 = pressed)",
    "rSB": "serial transfer data byte",
    "rSC": "serial control: bit 7 starts a transfer, bit 0 picks the internal clock (CGB bit 1: fast clock)",
    "rDIV": "divider: counts up at 16384 Hz; any write resets it",
    "rTIMA": "timer counter: counts at the rTAC rate and requests the timer interrupt when it overflows",
    "rTMA": "timer modulo: loaded into rTIMA when it overflows",
    "rTAC": "timer control: bit 2 enables the timer, bits 0-1 pick 4096/262144/65536/16384 Hz",
    "rIF": "interrupt flags: bit 0 VBlank, 1 LCD STAT, 2 timer, 3 serial, 4 joypad requested",
    "rNR10": "sound channel 1 sweep: time, direction and shift",
    "rNR11": "sound channel 1 duty (bits 6-7) and length",
    "rNR12": "sound channel 1 volume envelope: initial volume, direction, period",
    "rNR13": "sound channel 1 frequency, low 8 bits",
    "rNR14": "sound channel 1 frequency high 3 bits, length enable (bit 6) and trigger (bit 7)",
    "rNR21": "sound channel 2 duty (bits 6-7) and length",
    "rNR22": "sound channel 2 volume envelope",
    "rNR23": "sound channel 2 frequency, low 8 bits",
    "rNR24": "sound channel 2 frequency high 3 bits, length enable and trigger",
    "rNR30": "sound channel 3 (wave) on/off: bit 7",
    "rNR31": "sound channel 3 length",
    "rNR32": "sound channel 3 output level: bits 5-6 (mute, 100%, 50%, 25%)",
    "rNR33": "sound channel 3 frequency, low 8 bits",
    "rNR34": "sound channel 3 frequency high 3 bits, length enable and trigger",
    "rNR41": "sound channel 4 (noise) length",
    "rNR42": "sound channel 4 volume envelope",
    "rNR43": "sound channel 4 polynomial counter: clock shift, width, divisor",
    "rNR44": "sound channel 4 length enable and trigger",
    "rNR50": "master volume: left (bits 4-6) and right (bits 0-2)",
    "rNR51": "sound panning: which channels go to the left (bits 4-7) and right (bits 0-3) outputs",
    "rNR52": "sound on/off (bit 7, write) and channel status (bits 0-3, read)",
    "rLCDC": "LCD control: bit 7 LCD on, 6 window map, 5 window on, 4 BG/window tiles, 3 BG map, 2 sprite size, "
             "1 sprites on, 0 BG on (CGB: BG priority)",
    "rSTAT": "LCD status: mode (bits 0-1), LY = LYC (bit 2) and the STAT interrupt sources (bits 3-6)",
    "rSCY": "background scroll Y",
    "rSCX": "background scroll X",
    "rLY": "the line being drawn, 0-153 (144-153 is VBlank)",
    "rLYC": "line compare: rSTAT bit 2 and the STAT interrupt fire when rLY equals it",
    "rDMA": "OAM DMA: writing $XX copies $XX00-$XX9F to OAM (run from HRAM)",
    "rBGP": "DMG background palette: two bits per shade",
    "rOBP0": "DMG sprite palette 0",
    "rOBP1": "DMG sprite palette 1",
    "rWY": "window Y position",
    "rWX": "window X position + 7",
    "rKEY1": "CGB speed switch: bit 0 arms a switch done by stop, bit 7 is the current speed",
    "rVBK": "CGB VRAM bank: bit 0 (bank 1 holds the BG attributes)",
    "rHDMA1": "CGB VRAM DMA source, high byte",
    "rHDMA2": "CGB VRAM DMA source, low byte (low 4 bits ignored)",
    "rHDMA3": "CGB VRAM DMA destination, high byte (in VRAM)",
    "rHDMA4": "CGB VRAM DMA destination, low byte",
    "rHDMA5": "CGB VRAM DMA start: length / $10 - 1 in bits 0-6; bit 7 picks HBlank DMA",
    "rRP": "CGB infrared port",
    "rBGPI": "CGB background palette index: bits 0-5 the byte, bit 7 auto-increment",
    "rBGPD": "CGB background palette data at rBGPI",
    "rOBPI": "CGB sprite palette index",
    "rOBPD": "CGB sprite palette data at rOBPI",
    "rSVBK": "CGB WRAM bank at $D000-$DFFF: bits 0-2 (0 selects 1)",
    "rIE": "interrupt enable: the same bits as rIF",
    "rRAMG": "MBC5 RAM enable: write $0A to enable cartridge RAM, anything else to disable",
    "rRAMG2": "MBC5 RAM enable, written at the top of its $0000-$1FFF range",
    "rROMB0": "MBC5 ROM bank, low 8 bits, for $4000-$7FFF",
    "rROMB1": "MBC5 ROM bank, bit 8",
    "rRAMB": "MBC5 cartridge RAM bank, bits 0-3",
    "vTiles0": "VRAM tiles $00-$7F of the $8000 sprite/BG area",
    "vTiles1": "VRAM tiles $80-$FF (shared by both addressing modes)",
    "vTiles2": "VRAM tiles $00-$7F of the $8800 (signed) BG area",
    "vBGMap0": "the first 32 x 32 background tile map",
    "vBGMap1": "the second 32 x 32 background tile map",
}


def vram_expr(addr: int) -> str:
    for base, name in VRAM:
        if addr >= base:
            return name if addr == base else f"{name} + ${addr - base:X}"
    return f"${addr:04X}"


def write_hardware_inc(path) -> None:
    lines = ["; Hardware symbols (Pan Docs / hardware.inc names). Generated by tools/disasm_all.py.", ""]
    for addr in sorted(IO):
        if 0xFF30 <= addr < 0xFF40:
            continue
        lines.append(f"DEF {IO[addr]} EQU ${addr:04X} ; {DESCRIPTION[IO[addr]]}")
    lines.append("DEF rWAVE EQU $FF30 ; 16 bytes of wave pattern RAM")
    lines.append("")
    for addr, name in sorted(MBC.items()):
        lines.append(f"DEF {name} EQU ${addr:04X} ; {DESCRIPTION[name]}")
    lines.append(f"DEF {BANK_NUMBER_BYTE[0]} EQU ${BANK_NUMBER_BYTE[1]:04X} ; byte 0 of every non-empty bank is its own number")
    lines.append("")
    for base, name in sorted(VRAM):
        lines.append(f"DEF {name} EQU ${base:04X} ; {DESCRIPTION[name]}")
    lines.append("")
    path.write_text("\n".join(lines) + "\n", encoding="utf-8", newline="\n")
