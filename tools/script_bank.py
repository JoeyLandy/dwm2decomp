#!/usr/bin/env python3
"""Event scripts in other banks than $10, for mods (E-0421).

The script interpreter runs in bank $10 (FetchScriptCommand) and reads a script's bytes from the bank mapped at
$4000-$7FFF, its own. The game has a second way: `script_jump_data_bank` (opcode $E7) sets wScriptInDataBank = 1 and
reads on from the bank in wDataBank, which the talk routine set before starting the script (E-0420: banks $0C,
$0D, $0E, $15, $1D, $1F and $96 hold scripts read this way). Only some opcode handlers read through wDataBank
(the message, jump, skip, choice and two message forms); the others (walk, face, wait, set flag, sound, ...) read
their bytes from the mapped bank, so the game's data-bank scripts use those few only.

`patch` changes the interpreter of a mod's copy of src/, so a script can be in any bank and use every opcode:
- two home-bank helpers, ReadScriptWord and ReadScriptByte, read script bytes as wScriptInDataBank says: 0, the
  mapped bank (bank $10); 1, the bank in wDataBank, as the game does; 2 and up, that bank number;
- the handlers that read through wDataBank call ReadScriptWord instead of ReadWordFromDataBank, and the others read
  their bytes with ReadScriptByte instead of `ld a, [hli]`;
- the unused opcode $08 becomes `script_jump_far address` (src/macros.inc): the bank byte, then the address. The
  script goes on there with wScriptInDataBank = that bank, or 0 for bank $10. $FF ends a script and clears it, as
  before. Modes 0 and 1 work exactly as in the original;
- StartScriptAtHL_B04 and StartScriptAtHL_B13, the two routines that start scripts, jump to a home-bank
  StartScriptAtHL that first clears a far mode a moved script left when a scene command ended it without $FF (the
  game's scripts run in mode 0, so this never mattered there).

`move LABEL... --to BB` (or `move --all --to BB`) moves bank $10 scripts to the empty bank BB (patching first).
Scripts are moved as runs: from a label after a terminator (script_end, `db $ff`, a jump or a choice) to the next
such label, together with every run their relative jumps (script_skip_if_no, script_choice_jump) reach. In the
moved copy a label X becomes X_Far; a `script_jump` to a script left in bank $10 becomes `script_jump_far`. Each
moved label that anything outside the moved runs names (the 440 talk routines' `ld hl, Script_...`, tables, jumps
of other scripts) keeps a 4-byte stub in bank $10, `X:: script_jump_far X_Far`, so nothing that starts a script
changes. Refused runs: raw bytes other than `db $ff` (not read as script; since E-0422 the leftovers after
scripts' ends are read as script, config/script_entries.json, and every one of the 656 runs can move), and the
commands whose menus save the script position and restore it in data-bank mode 1 (SCRIPT_ARENA, SCRIPT_BREED,
SCRIPT_NPC_BREED: ArenaMenu, BreedMenu and NpcBreedMenu save wScriptPointer and set wScriptInDataBank = 1 when they
resume it). No bank-$10 script uses those three; the arena and breeding scripts are data-bank scripts in banks
$0C, $0E and $15, whose talk routines name their bank with BANK(target) (E-0420), so they move with their section
(tools/move_section.py; E-0422 moved the priest and library scripts of bank $1F).

Like tools/text_spill.py it refuses src/ itself (the matching build keeps the original layout); tools/make_mod.py
runs it from mod.json "scripts". A refusal changes nothing.

    python -I tools/script_bank.py patch --src DIR
    python -I tools/script_bank.py move LABEL... --to BB --src DIR
    python -I tools/script_bank.py move --all --to BB --src DIR
    python -I tools/script_bank.py runs [--src DIR]        how many runs can move, and why the others cannot

Checked on tools/sm83.py by tests/test_script_bank.py (C2 on the project's emulator, not hardware).
"""
from __future__ import annotations

import argparse
import re
import sys
from dataclasses import dataclass, field
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import text_spill as TS  # noqa: E402

LABEL = re.compile(r"^([A-Za-z_]\w*)::")
SCRIPTS = "scripts/bank10_scripts.asm"
HOME = "home/bank00_home.asm"
# bytes of each script line (src/macros.inc)
SIZE = {"script_end": 1, "script_message": 3, "script_skip_if_no": 2, "script_jump": 3, "script_set_flag": 3,
        "script_add_gold": 3, "script_sound": 2, "script_jump_data_bank": 3, "script_walk": 4, "script_walk_fast": 4,
        "script_wait": 3, "script_hold_dpad": 3, "script_face": 3, "script_slide_y": 2, "script_hide_object": 2,
        "script_encounter": 2, "script_message_unless_flag0": 3, "script_message_by_screen": 3, "script_command": 1,
        "script_jump_far": 4}
TERMINATORS = ("script_end", "script_jump", "script_jump_data_bank", "script_choice_jump", "script_jump_far")
# commands whose menus save wScriptPointer and resume it with wScriptInDataBank = 1 (E-0421)
RESUMING = ("SCRIPT_ARENA", "SCRIPT_BREED", "SCRIPT_NPC_BREED")

HELPERS = [
    'SECTION "Bank 00 ReadScriptWord", ROM0',
    "",
    "; tools/script_bank.py (not in the original game): B = [HL], C = [HL + 1] of the script, HL kept, from the bank",
    "; wScriptInDataBank names: 1, the bank in wDataBank (ReadWordFromDataBank, as the game's data-bank scripts);",
    "; 2 and up, that bank number. Maps the calling bank back. Called in data-bank mode only.",
    "ReadScriptWord::",
    "    ld a, [wScriptInDataBank]",
    "    cp $02",
    "    jp c, ReadWordFromDataBank",
    "    ld b, a",
    "    ld a, [BANK_NUMBER_BYTE]",
    "    push af",
    "    ld a, b",
    "    ld [rROMB0], a",
    "    ld a, [hli]",
    "    ld b, a",
    "    ld a, [hld]",
    "    ld c, a",
    "    pop af",
    "    ld [rROMB0], a",
    "    ret",
    "",
    "; tools/script_bank.py: A = the next script byte, HL + 1: `ld a, [hli]` in the mapped bank when",
    "; wScriptInDataBank is 0, else from the script's bank (ReadScriptWord). BC and DE kept.",
    "ReadScriptByte::",
    "    ld a, [wScriptInDataBank]",
    "    and a",
    "    jr nz, .script_bank",
    "    ld a, [hli]",
    "    ret",
    "",
    ".script_bank:",
    "    push bc",
    "    call ReadScriptWord",
    "    ld a, b",
    "    pop bc",
    "    inc hl",
    "    ret",
    "",
]
HELPERS += [
    "; tools/script_bank.py: StartScriptAtHL_B04 and StartScriptAtHL_B13 jump here. As they did, stores HL in",
    "; wScriptPointerLo/Hi, wScriptStartRequest = $80 and wModeState = 1; first it clears a far mode (2 and up) that a",
    "; moved script left when it ended without $FF (a scene command ends it), so the new script is read from bank $10.",
    "; Modes 0 and 1 are left as they are, as in the game.",
    "StartScriptAtHL::",
    "    ld a, [wScriptInDataBank]",
    "    cp $02",
    "    jr c, .start",
    "    xor a",
    "    ld [wScriptInDataBank], a",
    "",
    ".start:",
    "    ld a, l",
    "    ld [wScriptPointerLo], a",
    "    ld a, h",
    "    ld [wScriptPointerHi], a",
    "    ld a, $80",
    "    ld [wScriptStartRequest], a",
    "    ld a, $01",
    "    ld [wModeState], a",
    "    ret",
    "",
]
HELPER_BYTES = 26 + 16 + 30
STARTERS = {"StartScriptAtHL_B04": "engine/bank04_field_events.asm", "StartScriptAtHL_B13": "engine/bank13_talk.asm"}
STARTER_OLD = ["ld a, l", "ld [wScriptPointerLo], a", "ld a, h", "ld [wScriptPointerHi], a", "ld a, $80",
               "ld [wScriptStartRequest], a", "ld a, $01", "ld [wModeState], a", "ret"]

JUMP_DATA_BANK_OLD = ["pop hl", "ld a, $01", "ld [wScriptInDataBank], a", "ld a, [hli]", "ld c, a", "ld a, [hl]",
                      "ld h, a", "ld l, c", "ld a, l", "ld [wScriptPointerLo], a", "ld a, h", "ld [wScriptPointerHi], a",
                      "jp FetchScriptCommand_NextOpcode"]
JUMP_DATA_BANK_NEW = [  # its address read in the current mode first (a far script may use it), then mode 1
    "    pop hl",
    "    call ReadScriptByte",
    "    ld c, a",
    "    call ReadScriptByte",
    "    ld h, a",
    "    ld l, c",
    "    ld a, $01",
    "    ld [wScriptInDataBank], a",
    "    ld a, l",
    "    ld [wScriptPointerLo], a",
    "    ld a, h",
    "    ld [wScriptPointerHi], a",
    "    jp FetchScriptCommand_NextOpcode",
]
JUMP_FAR = [
    'SECTION "Bank 10 ScriptFetchJumpFar", ROMX',
    "",
    "; tools/script_bank.py (not in the original game): fetch handler of opcode $08, script_jump_far address: the",
    "; bank byte, then the address. The script goes on at that address in that bank (wScriptInDataBank = the bank),",
    "; or, for bank $10, the interpreter's own, in the mapped bank (wScriptInDataBank = 0).",
    "ScriptFetchJumpFar::",
    "    pop hl",
    "    call ReadScriptByte",
    "    ld c, a",
    "    call ReadScriptByte",
    "    ld e, a",
    "    call ReadScriptByte",
    "    ld d, a",
    "    ld a, c",
    "    cp BANK(ScriptFetchJumpFar)",
    "    jr nz, .far",
    "    xor a",
    "",
    ".far:",
    "    ld [wScriptInDataBank], a",
    "    ld a, e",
    "    ld [wScriptPointerLo], a",
    "    ld a, d",
    "    ld [wScriptPointerHi], a",
    "    jp FetchScriptCommand_NextOpcode",
    "",
]
JUMP_FAR_BYTES = 33
MACRO = [
    "",
    "; tools/script_bank.py (a mod's interpreter, not the original game): opcode $08, the script goes on at",
    "; address \\1 in its own bank (ScriptFetchJumpFar)",
    "MACRO script_jump_far",
    "    db $08, BANK(\\1)",
    "    dw \\1",
    "ENDM",
]


def code(ln: str) -> str:
    return ln.split(";")[0].strip()


def line_bytes(c: str) -> int:
    """Bytes of one script line (code only)."""
    op = c.split()[0]
    if op == "script_choice_jump":
        return 1 + len(c.split(None, 1)[1].split(","))
    if op == "db":
        return len(c[3:].split(","))
    if op not in SIZE:
        raise ValueError(f"`{c}` is not a script line this tool knows")
    return SIZE[op]


def handlers(L: list[str]) -> list[str]:
    """The distinct fetch handlers of ScriptOpcodeHandlers, in table order."""
    i = next(k for k, ln in enumerate(L) if ln.startswith("ScriptOpcodeHandlers::"))
    out = []
    for ln in L[i + 1:]:
        if not ln.startswith("    dw "):
            break
        n = ln.split()[1]
        if n != "$0000" and n not in out:
            out.append(n)
    return out


def section_body(L: list[str], label: str) -> tuple[int, int]:
    """(label line, next SECTION line) of a routine."""
    a = next(k for k, ln in enumerate(L) if ln.startswith(label + "::"))
    b = a + 1
    while b < len(L) and not L[b].startswith("SECTION"):
        b += 1
    return a, b


def is_patched(tree: TS.Tree) -> bool:
    return any(ln.startswith("ScriptFetchJumpFar::") for ln in tree.files[tree.src / SCRIPTS])


def patch_tree(tree: TS.Tree) -> int:
    """Patch the interpreter in tree (not saved). Returns the bytes bank $10 grows by."""
    S = tree.files[tree.src / SCRIPTS]
    if is_patched(tree):
        return 0
    grow = JUMP_FAR_BYTES
    # the opcode handlers that read through wDataBank, and FetchScriptCommand's own opcode read
    aware = ["FetchScriptCommand_NextOpcode"]
    plain = []
    for h in handlers(S):
        a, b = section_body(S, h)
        (aware if any("wScriptInDataBank" in code(x) for x in S[a:b]) else plain).append(h)
    for h in aware:
        a, b = section_body(S, h)
        for k in range(a, b):
            if code(S[k]) == "call ReadWordFromDataBank":
                S[k] = S[k].replace("call ReadWordFromDataBank", "call ReadScriptWord")
    for h in plain:
        a, b = section_body(S, h)
        for k in range(a, b):
            c = code(S[k])
            if c == "ld a, [hli]":
                S[k] = S[k].replace("ld a, [hli]", "call ReadScriptByte")
                grow += 2
            elif re.search(r"\[hl[id]?\]", c) and not c.startswith("ld [hl"):
                raise ValueError(f"{h}: `{c}` reads the script in a way this tool does not rewrite")
    a, b = section_body(S, "ScriptFetchJumpDataBank")
    body = [code(x) for x in S[a + 1:b] if code(x)]
    if body != JUMP_DATA_BANK_OLD:
        raise ValueError("ScriptFetchJumpDataBank is not the routine this tool rewrites")
    first = next(k for k in range(a + 1, b) if code(S[k]))
    last = max(k for k in range(a + 1, b) if code(S[k]))
    S[first:last + 1] = JUMP_DATA_BANK_NEW
    grow += 4
    # opcode $08
    t = next(k for k, ln in enumerate(S) if ln.startswith("ScriptOpcodeHandlers::"))
    if code(S[t + 9]) != "dw $0000":
        raise ValueError("opcode $08 of ScriptOpcodeHandlers is in use")
    S[t + 9] = "    dw ScriptFetchJumpFar ; entry 8 (tools/script_bank.py: script_jump_far)"
    s = next(k for k, ln in enumerate(S) if ln.startswith('SECTION "Bank 10 BeginScriptCommand"'))
    S[s:s] = JUMP_FAR
    TS.fill_change(S, SCRIPTS, -grow)
    for name, rel in STARTERS.items():  # 19 bytes each become `jp StartScriptAtHL` (3)
        F = tree.files[tree.src / rel]
        a = next(k for k, ln in enumerate(F) if ln.startswith(name + "::"))
        b = TS.routine_end(F, a)
        if [code(x) for x in F[a + 1:b] if code(x)] != STARTER_OLD:
            raise ValueError(f"{name} is not the routine this tool rewrites")
        F[a + 1:b] = ["    jp StartScriptAtHL ; tools/script_bank.py: clears a far mode first", ""]
        TS.fill_change(F, rel, 16)
        tree.dirty.add(tree.src / rel)
    H = tree.files[tree.src / HOME]
    while H and H[-1] == "":
        H.pop()
    fill = max(k for k, ln in enumerate(H) if TS.FILL.match(ln))
    TS.fill_change(H, HOME, -HELPER_BYTES)
    H[fill + 1:fill + 1] = [""] + HELPERS
    macros = tree.src / "macros.inc"
    text = tree.text("macros.inc")
    tree.other[macros] = text.rstrip("\n") + "\n" + "\n".join(MACRO) + "\n"
    tree.dirty |= {tree.src / SCRIPTS, tree.src / HOME}
    return grow


def patch(src: Path) -> dict:
    if src.resolve() == (ROOT / "src").resolve():
        raise ValueError("this changes the interpreter; run it on a mod's copy of src/, never on src/ itself")
    tree = TS.Tree(src)
    grow = patch_tree(tree)
    tree.save()
    return {"patched": grow > 0, "bank_10_bytes": grow}


# ---- runs of scripts --------------------------------------------------------------------------------------------

@dataclass
class Run:
    start: int                 # first line (its comment)
    end: int                   # line after it
    labels: list[str]
    lines: list[str]
    bytes: int = 0
    why_not: str = ""          # empty when it can move
    relative: set[str] = field(default_factory=set)   # targets of skip and choice jumps
    absolute: set[str] = field(default_factory=set)   # targets of script_jump


def script_areas(S: list[str]) -> list[tuple[int, int]]:
    """(first, end) line ranges of the sections that hold scripts: those named after a Script_ label."""
    out = []
    for k, ln in enumerate(S):
        if ln.startswith('SECTION "Bank 10 Script_'):
            e = k + 1
            while e < len(S) and not S[e].startswith("SECTION"):
                if (m := LABEL.match(S[e])) and not m.group(1).startswith("Script_"):  # code after the scripts
                    e = TS.comment_start(S, e)
                    break
                e += 1
            while e > k and (TS.FILL.match(S[e - 1]) or not S[e - 1].strip()):
                e -= 1
            out.append((k + 1, e))
    return out


def runs(S: list[str]) -> list[Run]:
    out: list[Run] = []
    for a, e in script_areas(S):
        k = a
        while k < e and not LABEL.match(S[k]):
            k += 1
        cur = None
        last = ""
        for i in range(k, e):
            ln = S[i]
            m = LABEL.match(ln)
            if m and (cur is None or last.split(" ")[0] in TERMINATORS or last.startswith("db ")):
                start = TS.comment_start(S, i) if cur is None else max(TS.comment_start(S, i), cur.start + 1)
                if cur is not None:
                    cur.end = start
                cur = Run(start, e, [], [])
                out.append(cur)
            if m:
                cur.labels.append(m.group(1))
            c = code(ln)
            if c and not m:
                last = c
    for r in out:
        r.lines = S[r.start:r.end]
        for ln in r.lines:
            c = code(ln)
            if not c or LABEL.match(c):
                continue
            op = c.split()[0]
            if op == "db" and re.fullmatch(r"db \$ff(, \$ff)*", c, re.I) is None:
                r.why_not = r.why_not or f"raw bytes `{c}`"
            elif op == "script_command" and c.split()[1] in RESUMING:
                r.why_not = r.why_not or f"{c.split()[1]} resumes the script in data-bank mode 1"
            try:
                r.bytes += line_bytes(c)
            except ValueError as err:
                r.why_not = r.why_not or str(err)
            if op in ("script_skip_if_no", "script_choice_jump"):
                r.relative |= {t.strip() for t in c.split(None, 1)[1].split(",")}
            elif op == "script_jump":
                r.absolute.add(c.split()[1])
    return out


def components(rs: list[Run]) -> list[list[Run]]:
    """Runs joined by relative jumps, which must stay in one bank."""
    owner = {lab: k for k, r in enumerate(rs) for lab in r.labels}
    parent = list(range(len(rs)))

    def find(x):
        while parent[x] != x:
            parent[x] = parent[parent[x]]
            x = parent[x]
        return x

    for k, r in enumerate(rs):
        for t in r.relative:
            if t not in owner:
                r.why_not = r.why_not or f"a relative jump to {t}, outside bank $10's scripts"
                continue
            parent[find(k)] = find(owner[t])
    groups: dict[int, list[Run]] = {}
    for k, r in enumerate(rs):
        groups.setdefault(find(k), []).append(r)
    return list(groups.values())


def movable(group: list[Run]) -> str:
    return next((r.why_not for r in group if r.why_not), "")


def uses(tree: TS.Tree) -> dict[str, int]:
    """How often each name appears in code outside its own definition (comments, SECTION names aside)."""
    named: dict[str, int] = {}
    for L in tree.files.values():
        for ln in L:
            c = code(ln)
            if c.startswith("SECTION"):
                continue
            if LABEL.match(c):
                c = c.split("::", 1)[1]
            for w in re.findall(r"\b[A-Za-z_]\w*\b", c):
                named[w] = named.get(w, 0) + 1
    return named


def move(src: Path, labels: list[str] | None, to: str) -> dict:
    """Move the runs holding `labels` (all movable runs when None) to the empty bank `to`."""
    if src.resolve() == (ROOT / "src").resolve():
        raise ValueError("this changes the layout; run it on a mod's copy of src/, never on src/ itself")
    if int(to, 16) < 2:
        raise ValueError("the bank must be 2 or more (wScriptInDataBank 0 and 1 are the game's own modes)")
    tree = TS.Tree(src)
    grow = patch_tree(tree)
    S = tree.files[src / SCRIPTS]
    rs = runs(S)
    groups = components(rs)
    if labels is None:
        chosen = [g for g in groups if not movable(g)]
    else:
        by_label = {lab: g for g in groups for r in g for lab in r.labels}
        chosen = []
        for lab in labels:
            if lab not in by_label:
                raise ValueError(f"{lab} is not a script label of bank $10")
            g = by_label[lab]
            if why := movable(g):
                raise ValueError(f"{lab} cannot move: its run (with the runs its relative jumps reach) has {why}")
            if g not in chosen:
                chosen.append(g)
    moved = sorted((r for g in chosen for r in g), key=lambda r: r.start)
    if not moved:
        raise ValueError("no script run to move")
    inside = {lab for r in moved for lab in r.labels}
    named = uses(tree)
    for lab in inside:
        if f"{lab}_Far" in named:
            raise ValueError(f"{lab}_Far is already a label")
    inner: dict[str, int] = {}  # uses of each moved label inside the moved runs
    for r in moved:
        for ln in r.lines:
            c = code(ln)
            if LABEL.match(c):
                c = c.split("::", 1)[1]
            for w in re.findall(r"\b[A-Za-z_]\w*\b", c):
                if w in inside:
                    inner[w] = inner.get(w, 0) + 1
    for L in tree.files.values():
        for ln in L:
            if (m := re.search(r"\b(\w+)\s*[-+]", code(ln))) and m.group(1) in inside:
                raise ValueError(f"{m.group(1)} is used with an offset (`{code(ln)}`); it cannot move")
    stubbed = [lab for r in moved for lab in r.labels if named.get(lab, 0) > inner.get(lab, 0)]

    def far_line(ln: str) -> str:
        m = LABEL.match(ln)
        if m:
            return ln.replace(m.group(1) + "::", m.group(1) + "_Far::", 1)
        c = code(ln)
        if not c:
            return ln
        op = c.split()[0]
        if op == "script_jump" and c.split()[1] not in inside:
            return ln.replace("script_jump ", "script_jump_far ", 1)
        if op in ("script_jump", "script_skip_if_no", "script_choice_jump"):
            head, args = ln.split(op, 1)
            body, sep, comment = args.partition(";")
            body = re.sub(r"\b(\w+)\b", lambda m: m.group(1) + "_Far" if m.group(1) in inside else m.group(1), body)
            return head + op + body + sep + comment
        return ln

    out: list[str] = []
    stub_bytes = 0
    freed = 0
    for r in reversed(moved):
        stub = []
        for lab in r.labels:
            if lab in stubbed:
                stub += [f"{lab}::", f"    script_jump_far {lab}_Far"]
                stub_bytes += 4
        if stub:
            stub = [f"; moved to bank ${to.upper()} by tools/script_bank.py"] + stub
        S[r.start:r.end] = stub
        freed += r.bytes
    for r in moved:
        out += [far_line(ln) for ln in r.lines]
        while out and out[-1] == "":
            out.pop()
        out.append("")
    far_bytes = sum(r.bytes for r in moved) + sum(  # script_jump -> script_jump_far: one byte more each
        1 for r in moved for ln in r.lines if code(ln).split(" ")[0] == "script_jump" and code(ln).split()[1] not in inside)
    TS.fill_change(S, SCRIPTS, freed - stub_bytes)
    new = src / "scripts" / f"bank{to.lower()}_scripts_10_far.asm"
    TS.claim_empty_bank(tree, to, new)
    head = [f"; ROM bank ${to.upper()}: event scripts of bank $10 (moved here by tools/script_bank.py; not in the original",
            "; game). The interpreter reads them with wScriptInDataBank = this bank (script_jump_far).", "",
            f'SECTION "Bank {to.upper()}", ROMX', f"    db ${to.lower()} ; the bank number at $4000, as in every bank", ""]
    size = 1 + far_bytes
    if size > 0x4000:
        raise ValueError(f"the moved scripts need {size} bytes, more than a bank")
    tree.files[new] = head + out + [f"    ds ${0x4000 - size:x}, $00", ""]
    tree.dirty |= {src / SCRIPTS, new}
    tree.save()
    return {"to": to.upper(), "runs": len(moved), "labels": len(inside), "stubs": len(stubbed), "bytes": freed,
            "bank_10_gain": freed - stub_bytes - grow, "patched": grow > 0,
            "left": sum(len(g) for g in groups if movable(g))}


def summary(src: Path) -> dict:
    tree = TS.Tree(src)
    rs = runs(tree.files[src / SCRIPTS])
    groups = components(rs)
    why: dict[str, int] = {}
    for g in groups:
        if w := movable(g):
            key = re.sub(r"`.*`", "`...`", w)
            why[key] = why.get(key, 0) + len(g)
    return {"runs": len(rs), "movable": sum(len(g) for g in groups if not movable(g)),
            "bytes": sum(r.bytes for g in groups if not movable(g) for r in g), "not": why}


def fetch_trace(sym: dict, log: list) -> dict:
    """E-0421: a pc hook (for mod_check.recipe_compare) that appends to `log` where each script opcode is read from:
    the label at or before that address in the bank read (`_Far` taken off) and the offset; a script_jump_far (a
    stub) is not listed. The same scripts give the same trace from the original and from a mod whose scripts moved,
    whatever the timing."""
    import bisect
    by_bank: dict[int, list] = {}
    for n, (b, a) in sym.items():
        by_bank.setdefault(b, []).append((a, n))
    for v in by_bank.values():
        v.sort()
    b10, at = sym["FetchScriptCommand_NextOpcode"]

    def hook(g):
        if g.rombank != b10:
            return
        p = g.rb(W_SCRIPT_POINTER) | g.rb(W_SCRIPT_POINTER + 1) << 8
        mode = g.rb(W_SCRIPT_IN_DATA_BANK)
        bank = b10 if mode == 0 else g.rb(W_DATA_BANK) if mode == 1 else mode
        if g.rom[bank * 0x4000 + p - 0x4000] == 0x08:  # a stub's script_jump_far: the script is read on past it
            return
        v = by_bank.get(bank, [])
        k = bisect.bisect_right(v, (p, "~")) - 1
        log.append(f"{v[k][1].removesuffix('_Far')}+{p - v[k][0]}" if k >= 0 else f"{bank:02X}:{p:04X}")

    return {at: hook}


W_SCRIPT_POINTER, W_SCRIPT_IN_DATA_BANK, W_DATA_BANK = 0xC91A, 0xD7FD, 0xD7FE


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("command", choices=["patch", "move", "runs"])
    ap.add_argument("labels", nargs="*")
    ap.add_argument("--all", action="store_true")
    ap.add_argument("--to")
    ap.add_argument("--src", type=Path, default=ROOT / "src")
    a = ap.parse_args(argv)
    try:
        if a.command == "runs":
            s = summary(a.src)
            print(f"{s['runs']} script runs in bank $10; {s['movable']} can move ({s['bytes']} bytes)")
            for w, n in sorted(s["not"].items(), key=lambda x: -x[1]):
                print(f"  {n:4} not: {w}")
            return 0
        if a.command == "patch":
            res = patch(a.src)
            print("patched the interpreter" if res["patched"] else "already patched")
            return 0
        if not a.to or (not a.labels and not a.all):
            ap.error("move needs labels or --all, and --to BB (an empty bank)")
        res = move(a.src, None if a.all else a.labels, a.to)
    except ValueError as e:
        print(f"refused: {e}")
        return 1
    print(f"moved {res['runs']} runs ({res['bytes']} bytes, {res['labels']} labels, {res['stubs']} stubs) to bank "
          f"${res['to']}; bank $10 gains {res['bank_10_gain']} bytes; {res['left']} runs stay")
    return 0


if __name__ == "__main__":
    sys.exit(main())
