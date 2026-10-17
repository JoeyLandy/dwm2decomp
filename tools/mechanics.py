#!/usr/bin/env python3
"""M5 (E-0396): game mechanics as Python models, checked against the game's own routines on tools/sm83.py.

Each mechanic has a model written from the routine's code (docs/MECHANICS.md gives it as a specification) and a
check that runs the real routine from many generated states and compares every output the model predicts. The
models read the game's tables from the reference ROM; nothing is copied into the repository. A model that agrees
on every generated state supports the specification on the project's emulator (C2), not on hardware.

  join      BattleEnd_OfferJoin_DecideJoinOffer: does a defeated foe offer to join?
  growth    ComputeLevelUpStatGainsForBattleArg1: the six stat gains of a level-up
  breeding  ComputeBreedingChild: the child's species, plus and level cap

Usage: mechanics.py [join|growth|breeding|all] [--n 2000] [--seed 1]
Exit 1 when a model and the game disagree.
"""
from __future__ import annotations

import argparse
import json
import random
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
from sm83 import GameBoy  # noqa: E402

ROM_PATH = ROOT / "local/roms/dwm2-cobi-us.gbc"
RETURN = 0xC800


class Returned(Exception):
    pass


def ram() -> dict[str, int]:
    """RAM symbol -> address (config/symbols.json)."""
    return {v["name"]: int(k, 16) for k, v in json.loads((ROOT / "config/symbols.json").read_text(encoding="utf-8"))
            .items() if isinstance(v, dict) and "name" in v}


def constants() -> dict[str, int]:
    out = {}
    for f in ("src/records.inc", "src/constants.inc"):
        for m in re.finditer(r"^DEF (\w+) EQU \$([0-9A-Fa-f]+)", (ROOT / f).read_text(encoding="utf-8"), re.M):
            out[m.group(1)] = int(m.group(2), 16)
    return out


def rom_labels(sym: Path | None = None) -> dict[str, tuple[int, int]]:
    """ROM label -> (bank, address) from a build's .sym file (the newest build/run*/dwm2.sym by default)."""
    if sym is None:
        sym = sorted(ROOT.glob("build/run*/dwm2.sym"), key=lambda p: p.stat().st_mtime)[-1]
    out = {}
    for ln in sym.read_text(encoding="utf-8").split("\n"):
        m = re.match(r"([0-9a-fA-F]{2,3}):([0-9a-fA-F]{4}) (\S+)$", ln)
        if m:
            out[m.group(3)] = (int(m.group(1), 16), int(m.group(2), 16))
    return out


class Rom:
    def __init__(self, data: bytes):
        self.data = data

    def b(self, bank: int, addr: int) -> int:
        return self.data[addr] if addr < 0x4000 else self.data[bank * 0x4000 + addr - 0x4000]

    def w(self, bank: int, addr: int) -> int:
        return self.b(bank, addr) | self.b(bank, addr + 1) << 8


def call(rom: bytes, bank: int, addr: int, mem: dict[int, int] | None = None, regs: dict[str, int] | None = None,
         sram: dict[int, int] | None = None, steps: int = 3_000_000) -> GameBoy:
    """Run the routine at bank:addr from the given state until it returns; the machine afterwards."""
    gb = GameBoy(rom)
    gb.rombank = bank if bank else 1
    if sram:
        gb.ramen = True
        for k, v in sram.items():
            gb.sram[k] = v
    for k, v in (mem or {}).items():
        gb.wb(k, v)
    for r, v in (regs or {}).items():
        setattr(gb, r, v)
    gb.sp = 0xDFF0
    gb.wb(gb.sp, RETURN & 0xFF)
    gb.wb(gb.sp + 1, RETURN >> 8)
    gb.pc = addr

    def stop(_):
        raise Returned

    gb.pc_hooks[RETURN] = stop
    try:
        gb.run(steps)
    except Returned:
        return gb
    raise RuntimeError(f"{bank:02X}:{addr:04X} did not return")


class Random:
    """NextTableByte: wRandomHi = (wRandomHi + 1) & $7F, wRandomLo = RandomByteTable[wRandomHi]."""

    def __init__(self, rom: Rom, table: int, hi: int, lo: int):
        self.rom, self.table, self.hi, self.lo = rom, table, hi, lo

    def next(self) -> int:
        self.hi = (self.hi + 1) & 0x7F
        self.lo = self.rom.b(0, self.table + self.hi)
        return self.hi << 8 | self.lo


# ---- join -------------------------------------------------------------------------------------------------------

def join_model(r: Rom, L: dict, s: dict) -> dict:
    """BattleEnd_OfferJoin_DecideJoinOffer. s: the state; returns the outputs."""
    rnd = Random(r, L["RandomByteTable"][1], s["random_hi"], s["random_lo"])
    no = {"display_slot": 0xFF}
    out = {"display_slot": s["display_slot"]}

    def result(o):
        return dict(o, foe_count=1, random_hi=rnd.hi, random_lo=rnd.lo)

    if s["link_mode"] or s["battle_kind"] in (3, 4, 5) or s["battle_kind"] >= 8:
        return result(no)
    slot = s["display_slot"]
    if slot == 0xFF or slot < 4 or slot >= 7:
        return result(no)
    jc = s["join_class"][slot & 3]
    if jc == 7:
        return result(no)
    species = s["monster_id"][slot]
    seen = bool(s["species_flags"][species >> 3] >> (species & 7) & 1)
    table = L["BattleEnd_OfferJoin_DecideJoinOffer_Data2"][1]
    if not seen:
        roll = rnd.next() % 200
        rec = r.w(0x35, L["SpeciesRecordPointers"][1] + 2 * species)
        cls = r.b(0x35, rec + 4)  # SPECIES_JOIN_CLASS
        if cls == 7:
            return result(no)
        if r.b(0x16, L["JoinChanceByClass"][1] + cls) >= roll:
            return result(out)
        if s["battle_end_flag"]:
            return result(out)
        table = L["BattleEnd_OfferJoin_DecideJoinOffer_Data1"][1]
    m = r.b(0x16, table + jc)
    meter = s["battle_meter"]
    if m == 0:
        return result(out)
    if m == 7:
        return result(no)
    if s["battle_end_flag"]:
        return result(out)
    scale = {1: lambda v: (v * 5) & 0xFFFF, 2: lambda v: (v * 2) & 0xFFFF, 3: lambda v: v, 4: lambda v: v >> 1,
             5: lambda v: v // 5, 6: lambda v: v >> 4, 0x11: lambda v: v, 0x12: lambda v: v >> 2, 0x13: lambda v: v >> 3,
             0x14: lambda v: v >> 3, 0x15: lambda v: v >> 3, 0x16: lambda v: v // 20}
    if m not in scale:
        return result(no)
    hl = scale[m](meter)
    c = rnd.next() % 91 + 10
    hl = (hl - c) & 0xFFFF
    if hl & 0x8000:
        return result(no)
    if rnd.next() % 100 + 1 < 91:
        return result(out)
    return result(no)


def join_check(rom: bytes, n: int, seed: int) -> list[str]:
    R, L, r = ram(), rom_labels(), Rom(rom)
    rng = random.Random(seed)
    bank, addr = L["BattleEnd_OfferJoin_DecideJoinOffer"]
    bad = []
    for i in range(n):
        s = {"link_mode": rng.choice([0] * 9 + [1]), "battle_kind": rng.choice([0, 0, 1, 2, 3, 6, 7, 8]),
             "display_slot": rng.choice([4, 5, 6, 4, 5, 6, 3, 7, 0xFF]),
             "join_class": [rng.choice([0, 1, 2, 3, 4, 5, 6, 7]) for _ in range(4)],
             "monster_id": [rng.randrange(1, 300) for _ in range(8)],
             "species_flags": [rng.randrange(256) for _ in range(48)], "battle_end_flag": rng.choice([0] * 5 + [1]),
             "battle_meter": rng.choice([rng.randrange(0, 200), rng.randrange(0, 2000), rng.randrange(0, 0x10000)]),
             "random_hi": rng.randrange(128), "random_lo": rng.randrange(256)}
        mem = {R["wLinkMode"]: s["link_mode"], R["wBattleKind"]: s["battle_kind"], R["wDisplaySlot"]: s["display_slot"],
               R["wBattleEndFlag"]: s["battle_end_flag"], R["wBattleMeter"]: s["battle_meter"] & 0xFF,
               R["wBattleMeter"] + 1: s["battle_meter"] >> 8, R["wRandomHi"]: s["random_hi"],
               R["wRandomLo"]: s["random_lo"], R["wBattleFoeCount"]: 9}
        for k in range(4):
            mem[R["wFoeJoinClass1"] + k] = s["join_class"][k]
        for k in range(8):
            mem[R["wBattleMonsterId"] + 2 * k] = s["monster_id"][k] & 0xFF
            mem[R["wBattleMonsterId"] + 2 * k + 1] = s["monster_id"][k] >> 8
        for k, v in enumerate(s["species_flags"]):
            mem[R["wSpeciesFlags"] + k] = v
        want = join_model(r, L, s)
        gb = call(rom, bank, addr, mem)
        got = {"display_slot": gb.rb(R["wDisplaySlot"]), "foe_count": gb.rb(R["wBattleFoeCount"]),
               "random_hi": gb.rb(R["wRandomHi"]), "random_lo": gb.rb(R["wRandomLo"])}
        if got != want:
            bad.append(f"join #{i}: state {s}: game {got}, model {want}")
    return bad


# ---- growth -----------------------------------------------------------------------------------------------------

REC = 0xA5  # SRAM monster record size (SRAMRecordAddress)
STAT_WORDS = (0x5D, 0x61, 0x63, 0x65, 0x67, 0x69)  # MON_MAX_HP, MON_MAX_MP, MON_ATK, MON_DEF, MON_AGL, MON_INT


def clamp_delta_999(word: int, gain: int) -> int:
    """ClampDeltaTo999 (its 16-bit arithmetic, including the meaningless result for a word above 999)."""
    t = (word - 999) & 0xFFFF
    if t == 0:
        return 0
    u = (t + gain) & 0xFFFF
    if u == 0 or u & 0x8000:
        return gain
    return (-(t & 0xFF)) & 0xFF


def growth_model(r: Rom, L: dict, rec: bytes) -> list[int]:
    """ComputeLevelUpStatGainsForBattleArg1 for one SRAM record: the 8 bytes of wLevelUpGains afterwards."""
    gains = [0] * 8
    species = rec[0x0B] | rec[0x0C] << 8
    srec = r.w(0x35, L["SpeciesRecordPointers"][1] + 2 * species)
    level, cap = rec[0x56], rec[0x57]
    if level >= cap:
        return gains
    item, plus = rec[0xA4], rec[0x6D]
    if not 0x1D <= item < 0x23:
        temp0, temp1 = 0xFF, 0
    else:
        temp0 = item - 0x1D
        vals = [rec[0x56]] + [rec[w] for w in (0x5D, 0x61, 0x63, 0x65, 0x67, 0x69, 0x6B)]
        name_len = 0
        for k in range(10):
            ch = rec[0x01 + k]
            if ch == 0xF0:
                break
            if ch not in (0x8D, 0x8E):
                name_len += 1
        count = sum(1 for v in vals + [name_len] if (v & 1) == (plus & 1))
        temp1 = (gains[temp0] + (count >> 1)) & 0xFF
    gains[6], gains[7] = temp0, temp1
    growth_table = L["StatGrowthTable"][1]
    for i in range(6):
        row = r.b(0x35, srec + 0x0C + i)
        g = r.b(0x1A, (growth_table + row * 0x63 + level) & 0xFFFF)
        gains[i] = (g + temp1) & 0xFF if temp0 == i else g
    for i, w in enumerate(STAT_WORDS):
        gains[i] = clamp_delta_999(rec[w] | rec[w + 1] << 8, gains[i])
    return gains


def growth_check(rom: bytes, n: int, seed: int) -> list[str]:
    R, L, r = ram(), rom_labels(), Rom(rom)
    rng = random.Random(seed)
    bank, addr = L["ComputeLevelUpStatGainsForBattleArg1"]
    bad = []
    for i in range(n):
        num = rng.randrange(0, 40)
        rec = bytearray(rng.randrange(256) for _ in range(REC))
        species = rng.randrange(1, 300)
        rec[0x0B], rec[0x0C] = species & 0xFF, species >> 8
        rec[0x56] = rng.randrange(1, 99)
        rec[0x57] = rng.choice([rng.randrange(rec[0x56] + 1, 100)] * 4 + [rec[0x56], rng.randrange(1, 100)])
        rec[0xA4] = rng.choice([0, 0x1D, 0x1E, 0x1F, 0x20, 0x21, 0x22, 0x23, 0x1C, rng.randrange(256)])
        rec[0x6D] = rng.randrange(100)
        for w in STAT_WORDS + (0x6B,):
            v = rng.choice([rng.randrange(0, 999), rng.randrange(900, 1000), 999, rng.randrange(1000, 1200)])
            rec[w], rec[w + 1] = v & 0xFF, v >> 8
        name = [rng.choice([0x8D, 0x8E, rng.randrange(0x80, 0xF0)]) for _ in range(rng.randrange(0, 11))]
        rec[0x01:0x0B] = bytes((name + [0xF0] * 10)[:10])
        want = growth_model(r, L, bytes(rec))
        base = R["sRecords"] - 0xA000 + num * REC
        sram = {base + k: v for k, v in enumerate(rec)}
        gb = call(rom, bank, addr, {R["wBattleArg1"]: num}, sram=sram)
        got = [gb.rb(R["wLevelUpGains"] + k) for k in range(8)]
        if got != want:
            bad.append(f"growth #{i}: record {num} species {species} level {rec[0x56]}/{rec[0x57]} item {rec[0xA4]:02X} "
                       f"plus {rec[0x6D]}: game {got}, model {want}")
    return bad


# ---- breeding ---------------------------------------------------------------------------------------------------

def breed_species(r: Rom, L: dict, a: dict, b: dict, kind: int) -> int | None:
    """The child species of ComputeBreedingChild, or None when the pair cannot breed ($FExx in the last table).
    a, b: parent records as dicts with species, family (MON_FAMILY & $0F) and plus."""
    B = 0x0E
    # 1. BreedSpeciesRuleTable[A species]: species words of the mate, $FD = next result, $FE/$FC = a plus
    #    threshold on B / A when both parents are the same species, $FB = next result in link breeding (kind 2)
    #    and the end otherwise, $FFxx = the end; a match gives BreedSpeciesResultTable[A species][result].
    p, c = r.w(B, L["BreedSpeciesRuleTable"][1] + 2 * a["species"]), 0
    while True:
        lo, hi = r.b(B, p), r.b(B, p + 1)
        if hi == 0xFF:
            break
        if hi == 0xFD or (hi == 0xFB and kind == 2):
            c += 1
        elif hi == 0xFB:
            break
        elif hi in (0xFE, 0xFC):
            plus = b["plus"] if hi == 0xFE else a["plus"]
            if plus >= lo and a["species"] == b["species"]:
                return r.w(B, r.w(B, L["BreedSpeciesResultTable"][1] + 2 * a["species"]) + 2 * c)
        elif (lo | hi << 8) == b["species"]:
            return r.w(B, r.w(B, L["BreedSpeciesResultTable"][1] + 2 * a["species"]) + 2 * c)
        p += 2
    # 2. BreedFamilyRuleTable[A species]: one mate family per byte (each entry its own result), $FE = skip in
    #    link breeding and the end otherwise, $FF = the end; BreedFamilyResultTable[A species][result].
    p, c = r.w(B, L["BreedFamilyRuleTable"][1] + 2 * a["species"]), 0
    while True:
        v = r.b(B, p)
        if v == 0xFF or (v == 0xFE and kind != 2):
            break
        if v != 0xFE and v == b["family"]:
            return r.w(B, r.w(B, L["BreedFamilyResultTable"][1] + 2 * a["species"]) + 2 * c)
        p += 1
        c += 1
    # 3. FamilyBreedRuleTable[A family]: mate species words, $FD = next result, $FFxx = the end;
    #    FamilyBreedResultTable[A family][result].
    p, c = r.w(B, L["FamilyBreedRuleTable"][1] + 2 * a["family"]), 0
    while True:
        lo, hi = r.b(B, p), r.b(B, p + 1)
        if hi == 0xFF:
            break
        if hi == 0xFD:
            c += 1
        elif (lo | hi << 8) == b["species"]:
            return r.w(B, r.w(B, L["FamilyBreedResultTable"][1] + 2 * a["family"]) + 2 * c)
        p += 2
    # 4. FamilyPairResultTable[A family][B family]: a species, $FFxx = parent A's species, $FExx = no child.
    w = r.w(B, r.w(B, L["FamilyPairResultTable"][1] + 2 * a["family"]) + 2 * b["family"])
    if w >> 8 == 0xFF:
        return a["species"]
    if w >> 8 == 0xFE:
        return None
    return w


def breed_model(r: Rom, L: dict, a: dict, b: dict, kind: int) -> dict:
    sp = breed_species(r, L, a, b, kind)
    if sp is None:
        return {"arg67": 0xFFFF, "name_state": 6, "arg5": 0xFF}
    base = a["plus"] if kind else max(a["plus"], b["plus"])
    s = (a["level"] + b["level"]) & 0xFF
    bonus = 5 if s >= 100 else 4 if s >= 76 else 3 if s >= 60 else 2 if s >= 40 else 1
    plus = min(base + bonus, 99)
    cap = r.b(0x35, r.w(0x35, L["SpeciesRecordPointers"][1] + 2 * sp) + 6) + 3 * plus  # SPECIES_MAX_LEVEL
    return {"arg67": sp, "species": sp, "plus": plus, "max_level": min(cap, 99), "level": 1, "egg": 1, "state": 1,
            "personality": [((x + y) & 0xFF) >> 1 for x, y in zip(a["personality"], b["personality"])],
            "arg5": 0xFF}


def breed_check(rom: bytes, n: int, seed: int) -> list[str]:
    R, L, r = ram(), rom_labels(), Rom(rom)
    rng = random.Random(seed)
    bank, addr = L["ComputeBreedingChild"]
    bad = []

    def species_family(sp):
        return r.b(0x35, r.w(0x35, L["SpeciesRecordPointers"][1] + 2 * sp))

    def mates(sp):
        p, out = r.w(0x0E, L["BreedSpeciesRuleTable"][1] + 2 * sp), []
        while r.b(0x0E, p + 1) != 0xFF and len(out) < 64:
            if r.b(0x0E, p + 1) < 0xFB:
                out.append(r.w(0x0E, p))
            p += 2
        return out

    real = [sp for sp in range(1, 300) if species_family(sp) <= 10]  # the 11 families; other ids are unused
    for i in range(n):
        kind = rng.choice([0, 0, 1, 2])
        sa = rng.choice(real)
        ms = [m for m in mates(sa) if m in set(real)]
        sb = rng.choice(ms) if ms and rng.random() < 0.5 else (sa if rng.random() < 0.1 else rng.choice(real))
        par = []
        for sp in (sa, sb):
            par.append({"species": sp, "family": species_family(sp) & 0x0F, "plus": rng.choice([0, 0, 2, 4, 5, 8, 10, rng.randrange(100)]),
                        "level": rng.randrange(1, 100), "sex": rng.randrange(2),
                        "personality": [rng.randrange(256) for _ in range(4)]})
        mem = {R["wArg1"]: kind, R["wArg5"]: 0, R["wNameEntryState"]: 0}
        for buf, p in ((R["wRecordBufA"], par[0]), (R["wRecordBufB"], par[1])):
            rec = bytearray(REC)
            rec[0x0B], rec[0x0C] = p["species"] & 0xFF, p["species"] >> 8
            rec[0x0D], rec[0x0E], rec[0x6D], rec[0x56] = p["family"], p["sex"], p["plus"], p["level"]
            rec[0x6F:0x73] = bytes(p["personality"])
            rec[0x01:0x0B] = bytes([0x80, 0x81, 0xF0] + [0xF0] * 7)
            rec[0x0F:0x19] = bytes([0x82, 0xF0] + [0xF0] * 8)
            for w in STAT_WORDS:
                rec[w] = rng.randrange(1, 200)
            for k, v in enumerate(rec):
                mem[buf + k] = v
        want = breed_model(r, L, par[0], par[1], kind)
        gb = call(rom, bank, addr, mem)
        ch = R["wChildRecord"]
        got = {"arg67": gb.rb(R["wArg6"]) | gb.rb(R["wArg7"]) << 8, "arg5": gb.rb(R["wArg5"])}
        if want["arg67"] == 0xFFFF:
            got["name_state"] = gb.rb(R["wNameEntryState"])
        else:
            got.update(species=gb.rb(ch + 0x0B) | gb.rb(ch + 0x0C) << 8, plus=gb.rb(ch + 0x6D),
                       max_level=gb.rb(ch + 0x57), level=gb.rb(ch + 0x56), egg=gb.rb(ch + 0x6E), state=gb.rb(ch),
                       personality=[gb.rb(ch + 0x6F + k) for k in range(4)])
        if got != want:
            bad.append(f"breeding #{i}: kind {kind} A {par[0]} B {par[1]}: game {got}, model {want}")
    return bad


CHECKS = {"join": join_check, "growth": growth_check, "breeding": breed_check}


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("which", nargs="?", default="all")
    ap.add_argument("--n", type=int, default=2000)
    ap.add_argument("--seed", type=int, default=1)
    args = ap.parse_args(argv)
    rom = ROM_PATH.read_bytes()
    names = list(CHECKS) if args.which == "all" else [args.which]
    fails = 0
    for name in names:
        bad = CHECKS[name](rom, args.n, args.seed)
        print(f"{name}: {args.n - len(bad)} of {args.n} generated states agree")
        for b in bad[:5]:
            print("   ", b[:400])
        fails += len(bad)
    return 1 if fails else 0


if __name__ == "__main__":
    sys.exit(main())
