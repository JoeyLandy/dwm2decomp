"""Named constants for the game's ids, made from the ROM's own name tables (D-007).

- MONSTER_*: monster ids, named from StringTable_MonsterNames (ids $00-$FF) and StringTable_MonsterNames2
  (ids $100-$17F) in bank $08 (E-0026, E-0138).
- SKILL_*: skill ids, which are also battle action ids (E-0333), named from StringTable_SkillNames; action 0, which
  no skill name precedes, is ACTION_FIGHT (E-0333); action ids without a name are ACTION_<hex>.
- ITEM_*: item ids, named from StringTable_ItemNames.

A name is the string upper-cased with everything but letters and digits removed. A blank or "?" name gives
<PREFIX>_<hex id>; a name already used gives <NAME>_<hex id>. The value of each constant is the index of its string,
so the names are as certain as the tables (C2: the tables are read by the game's own lookups, E-0319).
"""
from __future__ import annotations

import re

import gb_text

BANK = 0x4000
TABLES = {"MONSTER": [(0x4258, 0x100, 0), (0x4458, 0x80, 0x100)], "SKILL": [(0x4558, 0xDF, 0)],
          "ITEM": [(0x4716, 0x70, 0)]}


def _string(rom: bytes, table: int, i: int) -> str:
    o = 8 * BANK + table + 2 * i - BANK
    q = 8 * BANK + (rom[o] | rom[o + 1] << 8) - BANK
    chars = []
    while rom[q] != 0xF0 and len(chars) < 16:
        chars.append(gb_text.BYTE_TO_TEXT.get(rom[q], ""))
        q += 1
    return "".join(chars)


def build(rom: bytes) -> dict[str, dict[int, tuple[str, str]]]:
    """{"MONSTER"/"SKILL"/"ITEM": {id: (constant, the name string)}}"""
    out: dict[str, dict[int, tuple[str, str]]] = {}
    for prefix, parts in TABLES.items():
        used: set[str] = set()
        consts: dict[int, tuple[str, str]] = {}
        for table, count, base in parts:
            for i in range(count):
                v = base + i
                text = _string(rom, table, i)
                stem = re.sub(r"[^A-Za-z0-9]", "", text).upper()
                if prefix == "SKILL" and v == 0:
                    name = "ACTION_FIGHT"
                elif not stem:
                    name = f"{'ACTION' if prefix == 'SKILL' else prefix}_{v:02X}"
                elif f"{prefix}_{stem}" in used:
                    name = f"{prefix}_{stem}_{v:02X}"
                else:
                    name = f"{prefix}_{stem}"
                used.add(name)
                consts[v] = (name, text)
        out[prefix] = consts
    return out


def write_constants_inc(path, consts: dict, events: dict | None = None, status: list | None = None) -> None:
    head = {"MONSTER": "Monster ids: StringTable_MonsterNames (ids $00-$FF) and StringTable_MonsterNames2 ($100-$17F)",
            "SKILL": "Skill and battle action ids: StringTable_SkillNames; ACTION_FIGHT is the plain attack (E-0333)",
            "ITEM": "Item ids: StringTable_ItemNames"}
    lines = ["; Named ids, made from the ROM's own name tables by tools/gb_constants.py (D-007). A constant's value is",
             "; the index of its name string; a blank or \"?\" name is numbered, a repeated one gets its id appended.", ""]
    for prefix, table in consts.items():
        lines.append(f"; {head[prefix]}")
        for v, (name, text) in sorted(table.items()):
            lines.append(f"DEF {name} EQU ${v:02X}" + (f" ; {text}" if text and not name.endswith(text.upper()) else ""))
        lines.append("")
    if events:
        lines += ["; Story flags (wStoryFlags; TestFlagBit, SetFlagBit, script_set_flag, object selectors), named after",
                  "; what their first setter says: a talk routine's message, a scene, a script's last scene command or",
                  "; message before the flag is set (D-009). Flags only tested, or set by routines whose names say",
                  "; nothing, keep their numbers."]
        for flag, (name, setters) in sorted(events.items()):
            more = f" and {len(setters) - 2} more" if len(setters) > 2 else ""
            lines.append(f"DEF {name} EQU ${flag:03X} ; set by {', '.join(setters[:2])}{more}")
        lines.append("")
    if status:
        lines += ["; Bits of a battle slot's status bytes wBattleStatus ... wBattleStatus8 (config/battle_status.json, D-009):",
                  "; 'forced' = tools/status_check.py set the bit in a debug battle and the texts appeared (E-0339);",
                  "; 'set by' = that skill's effect routine sets it (E-0333, E-0339)."]
        for b in status:
            lines.append(f"DEF BSTAT{b['byte']}_{b['name']} EQU {b['bit']} ; {b['note']}")
        lines.append("")
    path.write_text("\n".join(lines), encoding="utf-8", newline="\n")
