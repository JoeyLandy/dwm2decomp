#!/usr/bin/env python3
"""M5 (E-0396): game mechanics as Python models, checked against the game's own routines on tools/sm83.py.

Each mechanic has a model written from the routine's code (docs/MECHANICS.md gives it as a specification) and a
check that runs the real routine from many generated states and compares every output the model predicts. The
models read the game's tables from the reference ROM; nothing is copied into the repository. A model that agrees
on every generated state supports the specification on the project's emulator (C2), not on hardware.

  join      BattleEnd_OfferJoin_DecideJoinOffer: does a defeated foe offer to join?
  growth    ComputeLevelUpStatGainsForBattleArg1: the six stat gains of a level-up
  breeding  ComputeBreedingChild: the child's species, plus and level cap
  attack      ComputeAttackDamage: the plain attack's damage from ATK and DEF (E-0397)
  resistance  the 16 bank-$36 routines that roll damage and scale it by a resistance level (E-0397)
  step7       ResolveStepComputeDamage: the damage modifiers of resolve step 7 (E-0397)
  learn       FindNewlyLearnableSkills: the skill a monster learns, upgrades or devises on a level-up (E-0398)

Usage: mechanics.py [join|growth|breeding|attack|resistance|step7|learn|all] [--n 2000] [--seed 1]
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


# ---- damage (E-0397) --------------------------------------------------------------------------------------------

BATTLE_SRC = ROOT / "src/engine/bank36_battle_effects.asm"


class LinkedRandom(Random):
    """AdvanceRandom: NextTableByte on wRandomHi:wRandomLo, or in link play (wLinkMode not 0) on the copy in
    wRandomSeed2Lo/Hi, the result going to both places (NextTableByteSecondStream)."""

    def __init__(self, rom: Rom, table: int, s: dict):
        self.link, self.steps = s["link_mode"] != 0, 0
        hi, lo = (s["seed2_hi"], s["seed2_lo"]) if self.link else (s["random_hi"], s["random_lo"])
        super().__init__(rom, table, hi, lo)

    def next(self) -> int:
        self.steps += 1
        return super().next()

    def after(self, s: dict) -> dict:
        if self.link and self.steps:
            return {"random": (self.hi, self.lo), "seed2": (self.hi, self.lo)}
        if self.link:
            return {"random": (s["random_hi"], s["random_lo"]), "seed2": (s["seed2_hi"], s["seed2_lo"])}
        return {"random": (self.hi, self.lo), "seed2": (s["seed2_hi"], s["seed2_lo"])}


def random_in_range(rnd: Random, lo: int, hi: int) -> int:
    """RandomInRange(lo, hi), 16-bit: lo when the two are equal (no random step), else lo + R mod (hi - lo + 1)."""
    lo, hi = lo & 0xFFFF, hi & 0xFFFF
    if lo == hi:
        return lo
    span = (hi - lo + 1) & 0xFFFF
    if span == 0:
        raise ValueError("RandomInRange over all 65,536 values divides by zero")
    return (lo + rnd.next() % span) & 0xFFFF


def basic_damage(rnd: Random, atk: int, d: int) -> int:
    """ComputeBasicDamage: ATK against the defence value d the caller passes."""
    if atk <= d:
        return random_in_range(rnd, 0, 1)
    half = (atk - d) >> 1
    if atk >> 4 >= half:
        return random_in_range(rnd, 0, atk >> 4)
    q = half >> 4
    v = (half + random_in_range(rnd, -q, q)) & 0xFFFF
    return (v + random_in_range(rnd, -1, 1)) & 0xFFFF


def attack_damage(rnd: Random, atk: int, def_: int) -> int:
    """ComputeAttackDamage: one random step, then ComputeBasicDamage against DEF / 2."""
    rnd.next()
    return basic_damage(rnd, atk, def_ >> 1)


# The four level tables: damage for resistance level 0, 1, 2, 3 (16-bit, every shift and division rounding down)
SCALE_LEVELS = {
    "1_085_05_0": (lambda d: d, lambda d: d * 85 // 100, lambda d: d >> 1, lambda d: 0),
    "1_075_04_0": (lambda d: d, lambda d: (d >> 1) + (d >> 2), lambda d: (d * 8 // 10) >> 1, lambda d: 0),
    "131_116_075_03": (lambda d: (d + (d >> 2) + (d >> 4)) & 0xFFFF, lambda d: (d + (d >> 3) + (d >> 5)) & 0xFFFF,
                       lambda d: (d >> 1) + (d >> 2), lambda d: (d * 6 // 10) >> 1),
    "075_05_025_0": (lambda d: (d >> 1) + (d >> 2), lambda d: d >> 1, lambda d: d >> 2, lambda d: 0),
}
# Which table the target's wBattleStatus8 byte picks: (bit 6 set, else bit 7 set, else neither)
SCALE_PICKERS = {
    "ScaleDamageByFlagsAtHL": ("1_075_04_0", "131_116_075_03", "1_085_05_0"),
    "ScaleDamageByFlagsAtHLAlt": ("075_05_025_0", "131_116_075_03", "1_075_04_0"),
    "ScaleDamageByFlagsAtHLBit6": ("1_085_05_0", "131_116_075_03", "131_116_075_03"),
}


def scale_by_resistance(picker: str, status8: int, level: int, d: int) -> int:
    t = SCALE_PICKERS[picker]
    table = t[0] if status8 & 0x40 else t[1] if status8 & 0x80 else t[2]
    return SCALE_LEVELS[table][level](d)


def skill_roll(rnd: Random, s: dict) -> tuple[int, int]:
    """RollSkillDamageFromRecord: (damage, spread). Base word and spread byte at record +$D/+$E/+$F for an actor in
    slots 4-7 unless wLinkMode is 1, otherwise at +$9/+$A/+$B; damage = RandomInRange(base, base + spread)."""
    rec = s["record"]
    k = 0x0D if s["link_mode"] != 1 and s["actor"] & 4 else 0x09
    base, spread = rec[k] | rec[k + 1] << 8, rec[k + 2]
    return random_in_range(rnd, base, base + spread), spread


def resistance_routines() -> dict[str, dict]:
    """The damage routines of bank $36 made of a roll and a resistance scaling, read from src/: each one's source
    (the skill record roll or the plain attack), resistance byte, the bit field (by its rotations) and table picker.
    A routine that does not end in ret runs into the next label, as the code does."""
    bodies: dict[str, list[str]] = {}
    order, cur = [], None
    for ln in BATTLE_SRC.read_text(encoding="utf-8").split("\n"):
        m = re.match(r"^([A-Za-z_]\w*)::", ln)
        if m:
            cur = m.group(1)
            bodies[cur] = []
            order.append(cur)
            continue
        op = re.sub(r";.*", "", ln).strip()
        if cur and op and not ln.startswith("SECTION"):
            bodies[cur].append(op)
    out = {}
    for i, name in enumerate(order):
        ops, j = list(bodies[name]), i
        while ops and ops[-1] not in ("ret",) and not ops[-1].startswith("jp ") and j + 1 < len(order):
            j += 1
            ops += bodies[order[j]]
        if ops[:1] == ["call RollSkillDamageFromRecord"]:
            src, rest = "skill", ops[1:]
        elif ops[:2] == ["call ComputeAttackDamage", "call HLToBattleStatus8EntryOfBattleTarget_Bank36"]:
            src, rest = "attack", ops[2:]
        else:
            continue
        if rest[:1] == ["ld a, $00"] and len(rest) == 3 and rest[2] == "ret":
            m = re.fullmatch(r"call (ScaleDamageByFlagsAtHL\w*)", rest[1])
            if m and m.group(1) in SCALE_PICKERS:
                out[name] = {"source": src, "byte": None, "rot": [], "picker": m.group(1)}
            continue
        m = re.fullmatch(r"call GetTargetSlotResistancesByte(\d)", rest[0]) if rest else None
        if not m or rest[-1] != "ret" or rest[-3] != "and $03":
            continue
        rot = rest[1:-3]
        pm = re.fullmatch(r"call (ScaleDamageByFlagsAtHL\w*)", rest[-2])
        if not pm or pm.group(1) not in SCALE_PICKERS or any(r not in ("swap a", "rrca", "rlca") for r in rot):
            continue
        out[name] = {"source": src, "byte": int(m.group(1)), "rot": rot, "picker": pm.group(1)}
    return out


def resistance_level(byte: int, rot: list[str]) -> int:
    """The 2-bit resistance level the routine takes from a resistance byte by its rotations, then and $03."""
    for r in rot:
        byte = ((byte << 4 | byte >> 4) if r == "swap a" else (byte >> 1 | byte << 7) if r == "rrca"
                else (byte << 1 | byte >> 7)) & 0xFF
    return byte & 3


def resist_model(r: Rom, L: dict, shape: dict, s: dict) -> dict:
    rnd = LinkedRandom(r, L["RandomByteTable"][1], s)
    out = {}
    if shape["source"] == "skill":
        d, out["arg2"] = skill_roll(rnd, s)
    else:
        d = attack_damage(rnd, s["atk"][s["actor"]], s["def"][s["target"]])
    level = 0 if shape["byte"] is None else resistance_level(s["resist"][s["target"]][shape["byte"]], shape["rot"])
    out["damage"] = scale_by_resistance(shape["picker"], s["status"][s["target"]][8], level, d)
    return dict(out, **rnd.after(s))


def step7_model(r: Rom, L: dict, C: dict, s: dict) -> dict:
    """ResolveStepComputeDamage: the modifiers of resolve step 7 on the damage word."""
    rnd = LinkedRandom(r, L["RandomByteTable"][1], s)
    a, t = s["actor"], s["target"]
    st = [list(x) for x in s["status"]]
    rec5, rec6 = s["record"][5], s["record"][6]
    d, msg = s["damage"], s["msg"]
    out = lambda step: dict(step=step, damage=d, status2=st[a][2], msg=msg, **rnd.after(s))  # noqa: E731
    if st[a][2] & 0x80 and s["sound_slots"] & s["sound_ch1"] != 0xFF:
        return out(s["step"])  # waits for the critical-hit sound
    step = (s["step"] + 1) & 0xFF
    personality = True
    if rec6 & 0x10 and st[a][1] & 0x04:  # BSTAT1_ATK_DOUBLED
        d = d * 2 & 0xFFFF
    elif rec6 & 0x08 and st[a][2] & 0x80:  # BSTAT2_CRITICAL_ROLLED: ATK within 5 percent
        st[a][2] &= 0x7F
        msg = (0x35, 0xD0, 0xA8, 0x88)  # StoreHitMessage_Bank36: actor, target, flags, argument
        atk = s["atk"][a]
        q = atk // 20
        d = random_in_range(rnd, atk - q, atk + q)
        personality = False
    elif rec6 & 0x20 and st[a][4] & 0x01:  # BSTAT4_CHARGE_UP
        d = d * 2 & 0xFFFF
    elif rec5 & 0x02 and st[a][4] & 0x10:  # BSTAT4_SUCK_AIR: 2 to 2.5 times
        d = random_in_range(rnd, d * 2, d * 2 + (d >> 1))
    if personality and s["personality"][2 * a & 0xFF] & 0x40:
        d = (d + (d >> 1)) & 0xFFFF
    t7 = st[t][7] & 7
    if t7:
        changed = False
        if t7 & 3 == 0:  # only bit 2
            if rec5 & 0x80:
                d, changed = d >> 1, True
        elif rec6 & 0x80:
            d, changed = (d >> 1 if t7 & 1 else d // 10), True
        if changed and s["personality"][2 * t & 0xFF] & 0x02:
            d >>= 1
    if st[t][6] & 0x04 and rec5 & 0x80 and s["action"] not in (C["SKILL_RAMMING"], C["SKILL_KAMIKAZE"]):
        d = d << 1 & 0xFFFF  # BSTAT6_BERSERK on the target
    return out(step)


def battle_state(rng: random.Random, R: dict) -> tuple[dict, dict]:
    """A generated battle state and the RAM that holds it."""
    s = {"actor": rng.randrange(8), "target": rng.randrange(8), "link_mode": rng.choice([0, 0, 0, 1, 2]),
         "random_hi": rng.randrange(128), "random_lo": rng.randrange(256),
         "seed2_hi": rng.randrange(128), "seed2_lo": rng.randrange(256),
         "atk": [rng.choice([rng.randrange(0, 40), rng.randrange(0, 1000), rng.randrange(0, 1000)]) for _ in range(8)],
         "def": [rng.choice([rng.randrange(0, 40), rng.randrange(0, 1000), rng.randrange(0, 2000)]) for _ in range(8)],
         "status": [[rng.choice([0, 0, rng.randrange(256)]) for _ in range(9)] for _ in range(8)],
         "resist": [[rng.randrange(256) for _ in range(7)] for _ in range(8)],
         "personality": [rng.randrange(256) for _ in range(16)],
         "record": [rng.randrange(256) for _ in range(16)]}
    if rng.random() < 0.5:  # realistic skill bases and spreads
        for k in (0x09, 0x0D):
            v = rng.choice([rng.randrange(0, 300), rng.randrange(0, 0xFF00)])
            s["record"][k], s["record"][k + 1], s["record"][k + 2] = v & 0xFF, v >> 8, rng.choice([0, rng.randrange(256)])
    mem = {R["wBattleActor"]: s["actor"], R["wBattleTarget"]: s["target"], R["wLinkMode"]: s["link_mode"],
           R["wRandomHi"]: s["random_hi"], R["wRandomLo"]: s["random_lo"],
           R["wRandomSeed2Hi"]: s["seed2_hi"], R["wRandomSeed2Lo"]: s["seed2_lo"]}
    for k in range(8):
        for arr, key in ((R["wBattleATK"], "atk"), (R["wBattleDEF"], "def")):
            mem[arr + 2 * k], mem[arr + 2 * k + 1] = s[key][k] & 0xFF, s[key][k] >> 8
        for n in range(1, 9):
            mem[R[f"wBattleStatus{n}"] + 9 * k] = s["status"][k][n]
        for n in range(7):
            mem[R["wSlotResistances"] + 7 * k + n] = s["resist"][k][n]
    for k in range(16):
        mem[R["wPersonalityActs"] + k] = s["personality"][k]
        mem[R["wRecordBufferData"] + k] = s["record"][k]
    return s, mem


def read_random(gb: GameBoy, R: dict) -> dict:
    return {"random": (gb.rb(R["wRandomHi"]), gb.rb(R["wRandomLo"])),
            "seed2": (gb.rb(R["wRandomSeed2Hi"]), gb.rb(R["wRandomSeed2Lo"]))}


def read_damage(gb: GameBoy, R: dict) -> int:
    return gb.rb(R["wBattleDamageLo"]) | gb.rb(R["wBattleDamageHi"]) << 8


def resist_check(rom: bytes, n: int, seed: int) -> list[str]:
    """The roll-and-resistance damage routines of bank $36 in turn, n generated states in all."""
    R, L, r = ram(), rom_labels(), Rom(rom)
    rng = random.Random(seed)
    bad = []
    shapes = list(resistance_routines().items())
    for i in range(n):
        name, shape = shapes[i % len(shapes)]
        bank, addr = L[name]
        s, mem = battle_state(rng, R)
        want = resist_model(r, L, shape, s)
        gb = call(rom, bank, addr, mem)
        got = dict(damage=read_damage(gb, R), **read_random(gb, R))
        if "arg2" in want:
            got["arg2"] = gb.rb(R["wBattleArg2"])
        if got != want:
            bad.append(f"{name} #{i}: state {s}: game {got}, model {want}")
    return bad


def attack_check(rom: bytes, n: int, seed: int) -> list[str]:
    R, L, r = ram(), rom_labels(), Rom(rom)
    rng = random.Random(seed)
    bank, addr = L["ComputeAttackDamage"]
    bad = []
    for i in range(n):
        s, mem = battle_state(rng, R)
        rnd = LinkedRandom(r, L["RandomByteTable"][1], s)
        want = dict(damage=attack_damage(rnd, s["atk"][s["actor"]], s["def"][s["target"]]), **rnd.after(s))
        gb = call(rom, bank, addr, mem)
        got = dict(damage=read_damage(gb, R), **read_random(gb, R))
        if got != want:
            bad.append(f"attack #{i}: actor {s['actor']} ATK {s['atk'][s['actor']]} target {s['target']} "
                       f"DEF {s['def'][s['target']]}: game {got}, model {want}")
    return bad


def step7_check(rom: bytes, n: int, seed: int) -> list[str]:
    R, L, r, C = ram(), rom_labels(), Rom(rom), constants()
    rng = random.Random(seed)
    bank, addr = L["ResolveStepComputeDamage"]
    bad = []
    for i in range(n):
        s, mem = battle_state(rng, R)
        a = s["actor"]
        for k, bit in ((1, 0x04), (2, 0x80), (4, 0x01), (4, 0x10)):  # make each modifier's condition common
            if rng.random() < 0.3:
                s["status"][a][k] |= bit
        s["record"][5] |= rng.choice([0, 0x02, 0x80, 0x82])
        s["record"][6] &= rng.choice([0xFF, 0x0F, 0xC7, 0x80])
        s.update(damage=rng.choice([rng.randrange(0, 300), rng.randrange(0, 0x10000)]), step=7,
                 action=rng.choice([C["SKILL_RAMMING"], C["SKILL_KAMIKAZE"], rng.randrange(256)]),
                 sound_slots=rng.choice([0xFF, 0xFF, rng.randrange(256)]), sound_ch1=rng.choice([0xFF, 0xFF, 0x0F]),
                 msg=tuple(rng.randrange(256) for _ in range(4)))
        mem.update({R["wBattleStatus2"] + 9 * a: s["status"][a][2], R["wBattleStatus1"] + 9 * a: s["status"][a][1],
                    R["wBattleStatus4"] + 9 * a: s["status"][a][4],
                    R["wRecordBufferData"] + 5: s["record"][5], R["wRecordBufferData"] + 6: s["record"][6],
                    R["wBattleDamageLo"]: s["damage"] & 0xFF, R["wBattleDamageHi"]: s["damage"] >> 8,
                    R["wBattleResolveStep"]: s["step"], R["wBattleActionId"]: s["action"],
                    R["wSoundChannelSlots"]: s["sound_slots"], R["wSoundChannel1"]: s["sound_ch1"],
                    R["wResolveMsgActor"]: s["msg"][0], R["wResolveMsgTarget"]: s["msg"][1],
                    R["wResolveMsgFlags"]: s["msg"][2], R["wResolveMsgArg"]: s["msg"][3]})
        want = step7_model(r, L, C, s)
        gb = call(rom, bank, addr, mem)
        got = dict(step=gb.rb(R["wBattleResolveStep"]), damage=read_damage(gb, R),
                   status2=gb.rb(R["wBattleStatus2"] + 9 * a),
                   msg=tuple(gb.rb(R[k]) for k in ("wResolveMsgActor", "wResolveMsgTarget", "wResolveMsgFlags",
                                                     "wResolveMsgArg")), **read_random(gb, R))
        if got != want:
            bad.append(f"step7 #{i}: state {s}: game {got}, model {want}")
    return bad


# ---- skill learning (E-0398) ------------------------------------------------------------------------------------

SKILL_ROW = 18  # SkillRequirementTable: level byte, six required words, five prerequisite bytes
SKILL_ROWS = 0xAA
MON_STAT_WORDS = (0x5D, 0x61, 0x63, 0x65, 0x67, 0x69)  # MON_MAX_HP, MON_MAX_MP, MON_ATK, MON_DEF, MON_AGL, MON_INT


def skill_rows(r: Rom, L: dict) -> list[list[int]]:
    bank, addr = L["SkillRequirementTable"]
    return [[r.b(bank, addr + c * SKILL_ROW + k) for k in range(SKILL_ROW)] for c in range(SKILL_ROWS)]


def learn_model(rows: list[list[int]], rec: bytes, work: bytes, temp5: int, temp6: int) -> dict:
    """FindNewlyLearnableSkills for one SRAM record and the caller's working list wWorkBuf ($38 bytes).
    Returns hTemp3 (the skill), hTemp4 (0 from the skill list, 1 an upgrade, 2 devised, $FF none), hTemp5,
    hTemp6 and the record's 25-byte skill list afterwards."""
    rec = bytearray(rec)
    level = rec[0x56]
    stats = [rec[o] | rec[o + 1] << 8 for o in MON_STAT_WORDS]
    known = rec[0x34:0x3C]  # MON_SKILLS

    def result(skill, kind):
        return {"skill": skill, "kind": kind, "temp5": temp5, "temp6": temp6, "skill_list": list(rec[0x3C:0x3C + 25])}

    for c, row in enumerate(rows):
        if c in work:
            continue
        if (level + 1) & 0xFF < row[0]:
            continue
        if any(st < (row[1 + 2 * i] | row[2 + 2 * i] << 8) for i, st in enumerate(stats)):
            continue
        lst = rec[0x3C:0x3C + 25]  # MON_SKILL_LIST
        if c in lst:
            rec[0x3C + lst.index(c)] = 0xFF
            return result(c, 0)
        p = row[13:18]
        if p[0] != 0xFF:
            temp6 = p[0]
            if c != 0x3D:
                if p[0] in known:
                    temp5 = p[0]
                    return result(c, 1)
                continue
            if p[0] not in known:
                continue
        if p[1] == 0xFF:
            continue
        for q in p[1:]:
            if q == 0xFF:
                return result(c, 2)
            if q not in known:
                break
        else:
            return result(c, 2)
    return result(0xFF, 0xFF)


def learn_check(rom: bytes, n: int, seed: int) -> list[str]:
    R, L, r = ram(), rom_labels(), Rom(rom)
    rng = random.Random(seed)
    bank, addr = L["FindNewlyLearnableSkills"]
    rows = skill_rows(r, L)
    devisable = [c for c, row in enumerate(rows) if row[14] != 0xFF and (row[13] == 0xFF or c == 0x3D)]
    bad = []
    for i in range(n):
        # the row the state is built around; a quarter of them rows that can be devised from known skills
        focus = rng.random() < 0.25
        k = (0x3D if rng.random() < 0.2 else rng.choice(devisable)) if focus else rng.randrange(SKILL_ROWS)  # $3D: its own rule
        row = rows[k]
        rec = bytearray(rng.randrange(256) for _ in range(REC))
        rec[0x56] = max(0, min(255, row[0] - 1 + rng.choice([0, 0, 1, 5, -1, -3])))
        for j, o in enumerate(MON_STAT_WORDS):
            need = row[1 + 2 * j] | row[2 + 2 * j] << 8
            v = max(0, min(0xFFFF, need + rng.choice([0, 0, 0, 3, 50, -1, rng.randrange(-200, 400)])))
            rec[o], rec[o + 1] = v & 0xFF, v >> 8
        pre = [p for p in row[13:18] if p != 0xFF]
        known = [p for p in pre if rng.random() < (0.95 if focus else 0.8)]
        known = (known + [rng.choice([0xFF, rng.randrange(SKILL_ROWS)]) for _ in range(8)])[:8]
        rng.shuffle(known)
        rec[0x34:0x3C] = bytes(known)
        lst = [rng.choice([0xFF] * (12 if focus else 1) + [rng.randrange(SKILL_ROWS)]) for _ in range(25)]
        if rng.random() < 0.3:
            lst[rng.randrange(25)] = k
        rec[0x3C:0x3C + 25] = bytes(lst)
        work = [0xFF] * 0x38
        if focus:  # the working list holds every earlier row whose level and stats the record meets
            stats = [rec[o] | rec[o + 1] << 8 for o in MON_STAT_WORDS]
            skip = [c for c in range(k) if (rec[0x56] + 1) & 0xFF >= rows[c][0] and all(
                st >= (rows[c][1 + 2 * j] | rows[c][2 + 2 * j] << 8) for j, st in enumerate(stats))]
        else:
            skip = [c for c in range(k) if rng.random() < 0.97] + rng.sample(range(SKILL_ROWS), rng.randrange(0, 10))
        for j, c in enumerate(skip[:0x38]):
            work[j] = c
        rng.shuffle(work)
        link, mode = rng.choice([(0, 4), (0, 1), (2, 4)])
        slot = rng.randrange(6)
        num = slot if link and mode == 4 else rng.randrange(0, 40)
        temp5, temp6 = rng.randrange(256), rng.randrange(256)
        mem = {R["wBattleArg0"]: slot | rng.choice([0, 0x80]) * (not link), R["wLinkMode"]: link, R["wGameMode"]: mode,
               R["hTemp5"]: temp5, R["hTemp6"]: temp6, R["hTemp3"]: 0x5A, R["hTemp4"]: 0x5A}
        for j in range(6):
            mem[R["wPartyList"] + j] = rng.randrange(40)
        mem[R["wPartyList"] + slot] = num
        for j, v in enumerate(work):
            mem[R["wWorkBuf"] + j] = v
        base = R["sRecords"] - 0xA000 + num * REC
        want = learn_model(rows, bytes(rec), bytes(work), temp5, temp6)
        gb = call(rom, bank, addr, mem, sram={base + j: v for j, v in enumerate(rec)})
        got = {"skill": gb.rb(R["hTemp3"]), "kind": gb.rb(R["hTemp4"]), "temp5": gb.rb(R["hTemp5"]),
               "temp6": gb.rb(R["hTemp6"]), "skill_list": [gb.sram[base + 0x3C + j] for j in range(25)]}
        if got != want:
            bad.append(f"learn #{i}: row {k} level {rec[0x56]} skills {list(rec[0x34:0x3C])}: game {got}, model {want}")
    return bad


CHECKS = {"join": join_check, "growth": growth_check, "breeding": breed_check,
          "attack": attack_check, "resistance": resist_check, "step7": step7_check, "learn": learn_check}


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
