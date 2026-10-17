#!/usr/bin/env python3
"""Breeding routes from the wild monsters of chosen maps to a target species (E-0400).

Everything is read from the reference ROM; label addresses come from a build's .sym file (tools/mechanics.py).

  wild     [--maps LO-HI ...]                 the species each story map's random encounters can give
  route    TARGET --maps LO-HI [--maps ...]   the fewest farm breedings from those maps' wild species to TARGET
  check    [--maps LO-HI ...] [--target T]    the game-agreement checks (below) for those maps and that route

Wild species. RunBattleIntroKindCase_RandomEncounter picks an encounter entry by hMapId: a grid table indexed by
the screen (ReadMapCellWordForScreenXY, A cells per row) or one entry (FillEncounterFromEntry), on four maps by
hPlayerStateFlags bit 3. The dispatch is decoded from the routine's bytes. Only screens inside the map record's
width and height are read, and maps whose record has an encounter rate of 0 are left out (TickRandomEncounterCounter
starts no battle then). FillEncounterFromEntry draws r = wRandomLo & $7F until r <= the entry's cap and takes the
first slot whose threshold is r or more, so a slot counts only when some r in [0, cap] selects it. An encounter word
is a MonsterTable id; its record's first word is the species (E-0263).

Route. Every species reachable is bred from every pair already reachable with tools/mechanics.breed_species (farm
breeding, kind 0, both pluses 0), keeping the recipe with the fewest breedings in total; a route needs two parents
per breeding, so a species used twice is bred twice. Sex, level, plus-gated recipes and how hard a monster is to
recruit are not modelled.

RandomByteTable gives r only 94 of the 128 values 0-127 (34 never occur, 19 among them), so a slot whose whole range
is missing values is never drawn: the last slot of two Float entries (Metaly at 0A:5F83, Phoenix at 0A:5FB0).

Checks (on tools/sm83.py, the project's emulator; C2 for what they compare, not hardware):
  1. lists: for every map, screen and value of bit 3, CollectUniqueEncounterIdsToWorkBuf2_FindTable (the game's own
     listing of an entry's monsters, which ignores the cap) gives the species this tool reads for that entry;
  2. draws: FillEncounterFromEntry run from all 128 random states lands on exactly the slots counted as reachable;
  3. pairings: ComputeBreedingChild gives each breeding of the route its child.
"""
from __future__ import annotations

import argparse
import re
import sys
from collections import Counter
from pathlib import Path
from typing import Callable

sys.path.insert(0, str(Path(__file__).resolve().parent))
import mechanics as M  # noqa: E402
from gb_text import render  # noqa: E402

ROOT = Path(__file__).resolve().parents[1]
FAMILIES = ["Slime", "Dragon", "Beast", "Bird", "Plant", "Bug", "Devil", "Zombie", "Material", "Water", "Boss"]
H_PLAYER_STATE_FLAGS = 0xFF8C


# ---- reading the ROM -------------------------------------------------------------------------------------------

def monster_names() -> dict[int, str]:
    """Species id -> name from src/constants.inc (named from the ROM's name tables, D-007)."""
    out: dict[int, str] = {}
    for ln in (ROOT / "src/constants.inc").read_text(encoding="utf-8").split("\n"):
        if m := re.match(r"DEF MONSTER_(\w+) EQU \$([0-9A-Fa-f]+)", ln):
            out.setdefault(int(m.group(2), 16), m.group(1))
    return out


def decode_dispatch(r: M.Rom, L: dict, routine: str) -> dict[int, list[dict]]:
    """map id -> the entries the routine can pick: {kind: grid|direct, table, per_row, bit3: None|False|True}.

    Decodes `ldh a,[hMapId]` then `cp n / jp z,target` pairs up to `ret`, and each target's straight-line code
    (ldh a,[hPlayerStateFlags] / bit 3,a / jr nz / ld de,nn / ld a,n / call / ret). Any other byte is an error."""
    bank, pc = L[routine]
    grid_calls = {L["ReadMapCellWordForScreenXY"][1], L["LoadEncounterIdsForScreenCell"][1]}
    if (r.b(bank, pc), r.b(bank, pc + 1)) != (0xF0, 0x90):
        raise ValueError(f"{routine}: does not start with ldh a, [hMapId]")
    pc += 2
    targets: dict[int, int] = {}
    while r.b(bank, pc) == 0xFE:
        if r.b(bank, pc + 2) != 0xCA:
            raise ValueError(f"{routine}: cp at {pc:04X} not followed by jp z")
        targets[r.b(bank, pc + 1)] = r.w(bank, pc + 3)
        pc += 5
    if r.b(bank, pc) != 0xC9:
        raise ValueError(f"{routine}: dispatch ends at {pc:04X} without ret")

    def branch(pc: int, bit3: bool | None) -> list[dict]:
        out, de, per_row = [], None, None
        while True:
            op = r.b(bank, pc)
            if op == 0xF0 and r.b(bank, pc + 1) == 0x8C:
                pc += 2
            elif op == 0xCB and r.b(bank, pc + 1) == 0x5F:
                pc += 2
            elif op == 0x20:  # jr nz: bit 3 set goes to the target, clear falls through
                rel = r.b(bank, pc + 1)
                out += branch(pc + 2 + (rel - 256 if rel > 127 else rel), True)
                bit3, pc = False, pc + 2
            elif op == 0x11:
                de, pc = r.w(bank, pc + 1), pc + 3
            elif op == 0x3E:
                per_row, pc = r.b(bank, pc + 1), pc + 2
            elif op == 0xCD:
                grid = r.w(bank, pc + 1) in grid_calls
                out.append({"kind": "grid" if grid else "direct", "table": de, "per_row": per_row if grid else None,
                            "bit3": bit3})
                pc += 3
            elif op == 0xC9:
                return out
            else:
                raise ValueError(f"{routine}: unexpected opcode {op:02X} at {bank:02X}:{pc:04X}")

    return {m: branch(t, None) for m, t in targets.items()}


def map_header(r: M.Rom, L: dict, map_id: int) -> dict:
    """Width and height in screens and the encounter rate (& $7F) of a MapTable record (E-0142)."""
    rec = r.w(0x11, L["MapTable"][1] + 2 * map_id)
    return {"width": r.b(0x11, rec + 6), "height": r.b(0x11, rec + 7), "rate": r.b(0x11, rec + 0x0B) & 0x7F}


def map_name(r: M.Rom, L: dict, map_id: int) -> str:
    """The system string at index 10 + map id (bank $08), as text."""
    p = r.w(0x08, L["StringTable_System"][1] + 2 * (10 + map_id))
    raw = bytes(r.b(0x08, p + k) for k in range(24))
    text = "".join(re.findall(r'"([^"]*)"', " ".join(render(raw, 200))))
    return text.split("@")[0].split("<")[0].strip()


def roll_values(r: M.Rom, L: dict) -> set[int]:
    """The values r = wRandomLo & $7F can take: NextTableByte sets wRandomLo from RandomByteTable[0-127]."""
    bank, addr = L["RandomByteTable"]
    return {r.b(bank, addr + k) & 0x7F for k in range(128)}


def entry_slots(r: M.Rom, bank: int, addr: int, values: set[int] | None = None) -> list[dict]:
    """The slots of a 17-byte encounter entry: monster word, threshold, and whether some draw picks it.

    Slot k is picked by a draw r with (largest earlier threshold) < r <= its threshold and r <= the cap; `values`
    are the r that can occur (roll_values; every 0-127 when None)."""
    values = set(range(128)) if values is None else values
    cap = r.b(bank, addr + 1)
    out, prev = [], -1
    for k in range(5):
        t = r.b(bank, addr + 2 + k)
        if t == 0:
            break
        hit = any(prev < v <= min(t, cap) for v in values)
        out.append({"monster": r.w(bank, addr + 7 + 2 * k), "threshold": t, "reachable": hit})
        prev = max(prev, t)
    return out


def species_of(r: M.Rom, L: dict, monster_id: int) -> int:
    """A MonsterTable id's species: the first word of its 26-byte record (ids from $250 in MonsterTableA2)."""
    if monster_id >= 0x250:
        bank, addr = L["MonsterTableA2"]
        monster_id -= 0x250
    else:
        bank, addr = L["MonsterTable"]
    return r.w(bank, addr + 26 * monster_id)


def family(r: M.Rom, L: dict, species: int) -> int:
    return r.b(0x35, r.w(0x35, L["SpeciesRecordPointers"][1] + 2 * species)) & 0x0F


def map_entries(r: M.Rom, L: dict, map_id: int, picks: list[dict]) -> list[tuple[int, int, bool | None, int]]:
    """(screen x, screen y, bit 3, entry address) for every in-bounds screen of the map; x, y are None for direct."""
    h = map_header(r, L, map_id)
    out = []
    for p in picks:
        bank = L["RunBattleIntroKindCase_RandomEncounter"][0]
        if p["kind"] == "direct":
            out.append((None, None, p["bit3"], p["table"]))
            continue
        for y in range(min(h["height"], 16)):
            for x in range(min(h["width"], p["per_row"], 16)):
                out.append((x, y, p["bit3"], r.w(bank, p["table"] + 2 * (p["per_row"] * y + x))))
    return out


def wild(r: M.Rom, L: dict, maps: list[tuple[int, int]] | None = None) -> dict[int, dict]:
    """map id -> {name, rate, species: {species id: set of entry addresses}} for the maps in the ranges."""
    bank, values = L["RunBattleIntroKindCase_RandomEncounter"][0], roll_values(r, L)
    out = {}
    for m, picks in sorted(decode_dispatch(r, L, "RunBattleIntroKindCase_RandomEncounter").items()):
        if maps and not any(lo <= m <= hi for lo, hi in maps):
            continue
        sp: dict[int, set] = {}
        for *_, addr in map_entries(r, L, m, picks):
            for s in entry_slots(r, bank, addr, values):
                if s["reachable"]:
                    sp.setdefault(species_of(r, L, s["monster"]), set()).add(addr)
        out[m] = {"name": map_name(r, L, m), "rate": map_header(r, L, m)["rate"], "species": sp}
    return out


def pool(w: dict[int, dict]) -> dict[int, set[str]]:
    """species -> names of the maps (with a non-zero encounter rate) where it can be met."""
    out: dict[int, set[str]] = {}
    for m in w.values():
        if m["rate"]:
            for sp in m["species"]:
                out.setdefault(sp, set()).add(m["name"])
    return out


# ---- the route -------------------------------------------------------------------------------------------------

def search(start: set[int], child: Callable[[int, int], int | None]) -> tuple[dict, dict]:
    """Fewest breedings for every species reachable from `start`: (cost, recipe), recipe[c] = (parent A, parent B).

    Repeats over all ordered pairs, in id order, until no cost falls; ties keep the first recipe found."""
    cost = {sp: 0 for sp in sorted(start)}
    how: dict[int, tuple[int, int]] = {}
    changed = True
    while changed:
        changed = False
        have = sorted(cost)
        for a in have:
            for b in have:
                c = child(a, b)
                if c is None:
                    continue
                k = cost[a] + cost[b] + 1
                if k < cost.get(c, 1 << 30):
                    cost[c], how[c] = k, (a, b)
                    changed = True
    return cost, how


def needs(how: dict, target: int) -> Counter:
    """How many of each species the route to target uses (target counted once)."""
    need: Counter = Counter()
    stack = [target]
    while stack:
        sp = stack.pop()
        need[sp] += 1
        if sp in how:
            stack += how[sp]
    return need


def farm_child(r: M.Rom, L: dict) -> Callable[[int, int], int | None]:
    memo: dict = {}

    def child(a: int, b: int) -> int | None:
        if (a, b) not in memo:
            memo[(a, b)] = M.breed_species(r, L, {"species": a, "family": family(r, L, a), "plus": 0},
                                           {"species": b, "family": family(r, L, b), "plus": 0}, 0)
        return memo[(a, b)]
    return child


# ---- checks against the game's routines --------------------------------------------------------------------------

def game_child(rom: bytes, L: dict, R: dict, a: int, b: int, fam: Callable[[int], int]) -> int:
    """ComputeBreedingChild for parent records A and B (farm breeding, plus 0, level 10, A male and B female)."""
    mem = {R["wArg1"]: 0, R["wArg5"]: 0, R["wNameEntryState"]: 0}
    for buf, sp, sex in ((R["wRecordBufA"], a, 0), (R["wRecordBufB"], b, 1)):
        rec = bytearray(M.REC)
        rec[0x0B], rec[0x0C], rec[0x0D], rec[0x0E], rec[0x56] = sp & 0xFF, sp >> 8, fam(sp), sex, 10
        for k, v in enumerate(rec):
            mem[buf + k] = v
    gb = M.call(rom, *L["ComputeBreedingChild"], mem)
    return gb.rb(R["wArg6"]) | gb.rb(R["wArg7"]) << 8


def game_list(rom: bytes, L: dict, R: dict, map_id: int, x: int, y: int, bit3: bool) -> list[int]:
    """The species CollectUniqueEncounterIdsToWorkBuf2_FindTable lists for that map, screen and bit 3."""
    mem = {0xFF90: map_id, 0xFF8F: x, 0xFF92: y, H_PLAYER_STATE_FLAGS: 8 if bit3 else 0, R["wWorkBuf"]: 0xEE}
    gb = M.call(rom, *L["CollectUniqueEncounterIdsToWorkBuf2_FindTable"], mem)
    n = gb.rb(R["wWorkBuf"])
    return [gb.rb(R["wWorkBuf"] + 2 + 2 * k) | gb.rb(R["wWorkBuf"] + 3 + 2 * k) << 8 for k in range(n)]


def game_draws(rom: bytes, L: dict, R: dict, entry: int) -> set[int]:
    """Monster words FillEncounterFromEntry stores, over all 128 random states (wRandomHi 0-127)."""
    got = set()
    for hi in range(128):
        mem = {R["wRandomHi"]: hi, R["wEncounterMonsters"]: 0xEE, R["wEncounterMonsters"] + 1: 0xEE}
        for k in range(2, 6):
            mem[R["wEncounterMonsters"] + k] = 0xEE
        gb = M.call(rom, L["FillEncounterFromEntry"][0], L["FillEncounterFromEntry"][1], mem,
                    regs={"d": entry >> 8, "e": entry & 0xFF})
        for k in range(3):
            got.add(gb.rb(R["wEncounterMonsters"] + 2 * k) | gb.rb(R["wEncounterMonsters"] + 2 * k + 1) << 8)
    return got - {0xEEEE}


def check_lists(rom: bytes, r: M.Rom, L: dict, R: dict, maps=None) -> list[str]:
    """Check 1 for every in-bounds screen of the maps (map $B8's listing ignores bit 3, so only bit 3 clear there)."""
    bad, bank = [], L["RunBattleIntroKindCase_RandomEncounter"][0]
    for m, picks in sorted(decode_dispatch(r, L, "RunBattleIntroKindCase_RandomEncounter").items()):
        if maps and not any(lo <= m <= hi for lo, hi in maps):
            continue
        for x, y, bit3, addr in map_entries(r, L, m, picks):
            for b3 in ([False, True] if bit3 is None else [bit3]):
                if m == 0xB8 and b3:
                    continue
                want = [species_of(r, L, s["monster"]) for s in entry_slots(r, bank, addr)]
                got = game_list(rom, L, R, m, x or 0, y or 0, b3)
                if got != want:
                    bad.append(f"map {m:02X} screen {x},{y} bit3 {b3}: game {got}, tool {want}")
    return bad


def check_draws(rom: bytes, r: M.Rom, L: dict, R: dict, maps=None) -> tuple[list[str], int]:
    """Check 2 for every distinct entry of the maps; returns (problems, entries checked)."""
    bad, bank, seen = [], L["RunBattleIntroKindCase_RandomEncounter"][0], set()
    values = roll_values(r, L)
    for m, picks in sorted(decode_dispatch(r, L, "RunBattleIntroKindCase_RandomEncounter").items()):
        if maps and not any(lo <= m <= hi for lo, hi in maps):
            continue
        for *_, addr in map_entries(r, L, m, picks):
            if addr in seen:
                continue
            seen.add(addr)
            want = {s["monster"] for s in entry_slots(r, bank, addr, values) if s["reachable"]}
            got = game_draws(rom, L, R, addr)
            if got != want:
                bad.append(f"entry {bank:02X}:{addr:04X}: game draws {sorted(got)}, tool {sorted(want)}")
    return bad, len(seen)


# ---- command line ----------------------------------------------------------------------------------------------

def parse_range(s: str) -> tuple[int, int]:
    lo, _, hi = s.partition("-")
    return int(lo, 16), int(hi or lo, 16)


def load(sym: str | None):
    rom = M.ROM_PATH.read_bytes()
    return rom, M.Rom(rom), M.rom_labels(Path(sym) if sym else None), M.ram()


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("command", choices=["wild", "route", "check"])
    ap.add_argument("target", nargs="?", help="species name as in src/constants.inc (MONSTER_ dropped)")
    ap.add_argument("--maps", action="append", type=parse_range, help="hex map id range, e.g. 30-45 (repeatable)")
    ap.add_argument("--target", dest="target2", help="route to check with `check`")
    ap.add_argument("--sym", help="a build's dwm2.sym (default: the newest build/run*/dwm2.sym)")
    a = ap.parse_args(argv)
    rom, r, L, R = load(a.sym)
    names = monster_names()
    by_name = {v: k for k, v in names.items()}

    if a.command == "wild":
        for m, v in wild(r, L, a.maps).items():
            note = "" if v["rate"] else "  (encounter rate 0: not counted)"
            print(f"{m:02X} {v['name']:<12} {', '.join(names.get(s, hex(s)) for s in sorted(v['species']))}{note}")
        return 0

    target = (a.target or a.target2 or "").upper()
    if target and target not in by_name:
        ap.error(f"unknown species {target}")
    if a.command == "route":
        if not a.maps or not target:
            ap.error("route needs TARGET and --maps")
        p = pool(wild(r, L, a.maps))
        cost, how = search(set(p), farm_child(r, L))
        t = by_name[target]
        print(f"wild species: {len(p)}; reachable by breeding: {len(cost) - len(p)} more")
        if t not in cost:
            print(f"{target}: not reachable from these maps")
            return 1
        need = needs(how, t)
        print(f"{target}: {cost[t]} breedings from {sum(n for s, n in need.items() if s not in how)} wild monsters\n")
        print("breed (copies needed) = parent A x parent B, shallowest first")
        for sp in sorted((s for s in need if s in how), key=lambda s: (cost[s], names[s])):
            pa, pb = how[sp]
            print(f"  {names[sp]:<14} x{need[sp]:<3} = {names[pa]} ({FAMILIES[family(r, L, pa)]}) x "
                  f"{names[pb]} ({FAMILIES[family(r, L, pb)]})")
        print("\ncatch:")
        for sp in sorted((s for s in need if s not in how), key=lambda s: (-need[s], names[s])):
            print(f"  {names[sp]:<14} x{need[sp]:<3} {', '.join(sorted(p[sp]))}")
        return 0

    bad = check_lists(rom, r, L, R, a.maps)
    print(f"lists: {'OK' if not bad else f'{len(bad)} differ'}")
    draws, n = check_draws(rom, r, L, R, a.maps)
    print(f"draws: {n} entries x 128 random states, {'OK' if not draws else f'{len(draws)} differ'}")
    bad += draws
    if target and a.maps:
        cost, how = search(set(pool(wild(r, L, a.maps))), farm_child(r, L))
        t = by_name[target]
        steps = needs(how, t) if t in cost else {}
        wrong = [f"{names[c]} = {names[x]} x {names[y]}: game {names.get(g, hex(g))}"
                 for c in steps if c in how for x, y in [how[c]]
                 if (g := game_child(rom, L, R, x, y, lambda s: family(r, L, s))) != c]
        print(f"pairings: {len(wrong)} of {sum(1 for c in steps if c in how)} differ")
        bad += wrong
    for b in bad[:20]:
        print("  " + b)
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
