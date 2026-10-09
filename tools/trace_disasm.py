#!/usr/bin/env python3
"""SM83 (Game Boy CPU) instruction decoder producing RGBDS syntax. Library for disasm_all.py."""
from __future__ import annotations

INVALID = {0xD3, 0xDB, 0xDD, 0xE3, 0xE4, 0xEB, 0xEC, 0xED, 0xF4, 0xFC, 0xFD}
R8 = ["b", "c", "d", "e", "h", "l", "[hl]", "a"]
R16 = ["bc", "de", "hl", "sp"]
R16S = ["bc", "de", "hl", "af"]
CC = ["nz", "z", "nc", "c"]
ALU = ["add a,", "adc a,", "sub a,", "sbc a,", "and a,", "xor a,", "or a,", "cp a,"]
ROT = ["rlc", "rrc", "rl", "rr", "sla", "sra", "swap", "srl"]


def s8(v: int) -> int:
    return v - 256 if v & 0x80 else v


def decode(rom: bytes, off: int, pc: int):
    """Return (length, text, kind, target). kind: seq|jp|jr|call|ret|jphl|bad|rst.
    Branch text contains '{T}' where the label for `target` goes."""
    op = rom[off]
    b1 = rom[off + 1] if off + 1 < len(rom) else 0
    b2 = rom[off + 2] if off + 2 < len(rom) else 0
    w = b1 | (b2 << 8)
    hx = lambda v, n=2: f"${v:0{n}X}"
    if op in INVALID:
        return 1, None, "bad", None
    if op == 0x00: return 1, "nop", "seq", None
    if op == 0x10: return 2, "stop", "seq", None  # stop's operand byte kept as db below
    if op == 0x76: return 1, "halt", "seq", None
    if op == 0xF3: return 1, "di", "seq", None
    if op == 0xFB: return 1, "ei", "seq", None
    if op == 0x08: return 3, f"ld [{hx(w,4)}], sp", "seq", None
    if op == 0x18: return 2, "jr {T}", "jr", (pc + 2 + s8(b1)) & 0xFFFF
    if op in (0x20, 0x28, 0x30, 0x38):
        return 2, f"jr {CC[(op>>3)&3]}, {{T}}", "jrc", (pc + 2 + s8(b1)) & 0xFFFF
    if op & 0xCF == 0x01: return 3, f"ld {R16[op>>4]}, {hx(w,4)}", "seq", None
    if op & 0xCF == 0x09: return 1, f"add hl, {R16[op>>4]}", "seq", None
    if op in (0x02, 0x12): return 1, f"ld [{R16[op>>4]}], a", "seq", None
    if op in (0x0A, 0x1A): return 1, f"ld a, [{R16[op>>4]}]", "seq", None
    if op == 0x22: return 1, "ld [hl+], a", "seq", None
    if op == 0x2A: return 1, "ld a, [hl+]", "seq", None
    if op == 0x32: return 1, "ld [hl-], a", "seq", None
    if op == 0x3A: return 1, "ld a, [hl-]", "seq", None
    if op & 0xCF == 0x03: return 1, f"inc {R16[op>>4]}", "seq", None
    if op & 0xCF == 0x0B: return 1, f"dec {R16[op>>4]}", "seq", None
    if op & 0xC7 == 0x04: return 1, f"inc {R8[op>>3&7]}", "seq", None
    if op & 0xC7 == 0x05: return 1, f"dec {R8[op>>3&7]}", "seq", None
    if op & 0xC7 == 0x06: return 2, f"ld {R8[op>>3&7]}, {hx(b1)}", "seq", None
    simple = {0x07: "rlca", 0x0F: "rrca", 0x17: "rla", 0x1F: "rra", 0x27: "daa",
              0x2F: "cpl", 0x37: "scf", 0x3F: "ccf"}
    if op in simple: return 1, simple[op], "seq", None
    if 0x40 <= op <= 0x7F: return 1, f"ld {R8[op>>3&7]}, {R8[op&7]}", "seq", None
    if 0x80 <= op <= 0xBF: return 1, f"{ALU[op>>3&7]} {R8[op&7]}", "seq", None
    if op & 0xC7 == 0xC6: return 2, f"{ALU[op>>3&7]} {hx(b1)}", "seq", None
    if op & 0xE7 == 0xC0: return 1, f"ret {CC[op>>3&3]}", "retc", None
    if op == 0xC9: return 1, "ret", "ret", None
    if op == 0xD9: return 1, "reti", "ret", None
    if op & 0xCF == 0xC1: return 1, f"pop {R16S[op>>4&3]}", "seq", None
    if op & 0xCF == 0xC5: return 1, f"push {R16S[op>>4&3]}", "seq", None
    if op & 0xE7 == 0xC2: return 3, f"jp {CC[op>>3&3]}, {{T}}", "jpc", w
    if op == 0xC3: return 3, "jp {T}", "jp", w
    if op == 0xE9: return 1, "jp hl", "jphl", None
    if op & 0xE7 == 0xC4: return 3, f"call {CC[op>>3&3]}, {{T}}", "callc", w
    if op == 0xCD: return 3, "call {T}", "call", w
    if op & 0xC7 == 0xC7: return 1, f"rst {hx(op & 0x38)}", "rst", op & 0x38
    if op == 0xE0: return 2, f"ldh [{hx(0xFF00+b1,4)}], a", "seq", None
    if op == 0xF0: return 2, f"ldh a, [{hx(0xFF00+b1,4)}]", "seq", None
    if op == 0xE2: return 1, "ldh [c], a", "seq", None
    if op == 0xF2: return 1, "ldh a, [c]", "seq", None
    if op == 0xEA: return 3, f"ld [{hx(w,4)}], a", "seq", None
    if op == 0xFA: return 3, f"ld a, [{hx(w,4)}]", "seq", None
    if op == 0xE8: return 2, f"add sp, {s8(b1)}", "seq", None
    if op == 0xF8: return 2, f"ld hl, sp + {s8(b1)}", "seq", None
    if op == 0xF9: return 1, "ld sp, hl", "seq", None
    if op == 0xCB:
        c = b1
        if c < 0x40: return 2, f"{ROT[c>>3]} {R8[c&7]}", "seq", None
        return 2, f"{['bit','res','set'][(c>>6)-1]} {c>>3&7}, {R8[c&7]}", "seq", None
    raise AssertionError(f"unhandled opcode {op:02X}")  # pragma: no cover
