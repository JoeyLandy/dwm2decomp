#!/usr/bin/env python3
"""Event scripts in other banks than $10, for mods (E-0421; timing-neutral since E-0423).

The script interpreter runs in bank $10 (FetchScriptCommand) and reads a script's bytes from the bank mapped at
$4000-$7FFF, its own. The game has a second way: `script_jump_data_bank` (opcode $E7) sets wScriptInDataBank = 1 and
reads on from the bank in wDataBank, which the talk routine set before starting the script (E-0420: banks $0C,
$0D, $0E, $15, $1D, $1F and $96 hold scripts read this way). Only FetchScriptCommand and some opcode handlers read
through wDataBank (the message, jump, skip, choice and two message forms); the others (walk, face, wait, set flag,
sound, the generic commands, ...) read their bytes from the mapped bank, so the game's data-bank scripts use only
the first kind and the opcodes that read no byte.

`patch` adds to the interpreter of a mod's copy of src/, and changes none of the game's own handlers, so every script
left in bank $10 or in a data bank runs with exactly the original instructions (E-0423):
- a far variant of each handler that reads from the mapped bank, in unused opcode slots: $A2-$AC for walk, walk fast,
  wait, hold pad, face, set flag, slide, hide, encounter, add gold and sound (the original handler's code, its reads
  done through ReadWordFromDataBank), $09 for a generic command (`script_command_far T`: the command type follows
  the opcode) and $10 for command $62; the macros are the originals' names plus `_far` (src/macros.inc);
- opcode $08, `script_jump_far address`: a bank byte and an address. The script goes on there in the game's data-bank
  mode (wScriptInDataBank = 1, wDataBank = that bank), or, for bank $10, in mode 0;
- StartScriptAtHL_B04 and StartScriptAtHL_B13, the two routines that start scripts, jump to a home-bank
  StartScriptAtHL that clears wScriptInDataBank first (none of the game's 440 starts sets it: a script starts in
  bank $10), so a moved script that a scene command ended without $FF leaves no data-bank mode behind. That costs
  36 cycles per script start; the fetch of every opcode costs what it did.

`move LABEL... --to BB` (or `move --all --to BB`) moves bank $10 scripts to the empty bank BB (patching first).
Scripts are moved as runs: from a label after a terminator (script_end, `db $ff`, a jump or a choice) to the next
such label, together with every run their relative jumps (script_skip_if_no, script_choice_jump) reach. In the
moved copy a label X becomes X_Far, the opcodes that read the mapped bank become their far variants, a `script_jump`
to a script left in bank $10 and every `script_jump_data_bank` become `script_jump_far` (the latter to its target's
bank, which E-0420 showed is the bank the talk routine puts in wDataBank). Each moved label that anything outside
the moved runs names (the 440 talk routines' `ld hl, Script_...`, tables, jumps of other scripts) keeps a 4-byte
stub in bank $10, `X:: script_jump_far X_Far`, so nothing that starts a script changes. Refused runs: raw bytes
other than `db $ff` (not read as script; since E-0422 the leftovers after scripts' ends are read as script,
config/script_entries.json, and every one of the 656 runs can move), and the commands whose menus save the script
position and restore it in data-bank mode 1 (SCRIPT_ARENA, SCRIPT_BREED, SCRIPT_NPC_BREED), and the six scripts
those menus start while their script waits (Script_BreedFade, Script_BreedChildSprite, Script_BreedChildScene,
Script_ArenaGridBattle, Script_ArenaRounds, Script_NpcBreedWarp, by their commands): the menus resume the waiting
script with the wDataBank it had, which a moved script would change (E-0423). No bank-$10 script uses the first
three; the arena and breeding scripts are data-bank scripts in banks $0C, $0E and $15, whose talk routines
name their bank with BANK(target) (E-0420), so they move with their section (tools/move_section.py, E-0422,
E-0423), with no patch at all.

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
# E-0423: the commands of the talk events those menus run while their data-bank script waits (FieldTalkEvents groups
# $15-$18, $1F, $20, dispatched by the seven routines that save wScriptPointer). The menus resume the waiting script
# in data-bank mode with wDataBank as it was; a moved script, read in data-bank mode, would have changed it.
NESTED = ("SCRIPT_BREED_FADE", "SCRIPT_BREED_CHILD_SPRITE", "SCRIPT_BREED_CHILD_SCENE", "SCRIPT_NPC_BREED_WARP",
          "SCRIPT_ARENA_GRID_BATTLE", "SCRIPT_ARENA_ROUNDS")
# E-0423: the opcodes whose handlers read their bytes from the mapped bank, and the unused slots of their far variants
FAR_OPS = {"script_walk": (0x01, 0xA2), "script_walk_fast": (0x02, 0xA3), "script_wait": (0x03, 0xA4),
           "script_hold_dpad": (0x04, 0xA5), "script_face": (0x05, 0xA6), "script_set_flag": (0x0A, 0xA7),
           "script_slide_y": (0x0B, 0xA8), "script_hide_object": (0x0C, 0xA9), "script_encounter": (0x0D, 0xAA),
           "script_add_gold": (0x0E, 0xAB), "script_sound": (0x0F, 0xAC)}
for _m in FAR_OPS:
    SIZE[_m + "_far"] = SIZE[_m]
FAR_GENERIC, FAR_62, JUMP_FAR_OP = 0x09, 0x10, 0x08
RE_READERS = ("ScriptFetchGeneric", "ScriptFetchGeneric2", "ScriptFetch62")  # re-read the opcode byte with [hli]

STARTERS = {"StartScriptAtHL_B04": "engine/bank04_field_events.asm", "StartScriptAtHL_B13": "engine/bank13_talk.asm"}
STARTER_OLD = ["ld a, l", "ld [wScriptPointerLo], a", "ld a, h", "ld [wScriptPointerHi], a", "ld a, $80",
               "ld [wScriptStartRequest], a", "ld a, $01", "ld [wModeState], a", "ret"]
HELPERS = [
    'SECTION "Bank 00 StartScriptAtHL", ROM0',
    "",
    "; tools/script_bank.py (not in the original game): StartScriptAtHL_B04 and StartScriptAtHL_B13 jump here. It",
    "; clears wScriptInDataBank (none of the game's starts sets it; a moved script that a scene command ended without",
    "; $FF leaves data-bank mode behind), then, as they did, stores HL in wScriptPointerLo/Hi, wScriptStartRequest =",
    "; $80 and wModeState = 1.",
    "StartScriptAtHL::",
    "    xor a",
    "    ld [wScriptInDataBank], a",
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
HELPER_BYTES = 23
FAR_HEAD = [
    'SECTION "Bank 10 ScriptFarHandlers", ROMX',
    "",
    "; tools/script_bank.py (not in the original game): what a moved script needs, read in the game's data-bank mode",
    "; (wScriptInDataBank = 1, wDataBank = the script's bank). The game's own handlers are unchanged.",
    "; A = the next script byte, HL + 1, read from the bank in wDataBank. BC and DE kept.",
    "ReadScriptByte::",
    "    push bc",
    "    call ReadWordFromDataBank",
    "    ld a, b",
    "    pop bc",
    "    inc hl",
    "    ret",
    "",
    "; opcode $08, script_jump_far address: a bank byte, then the address, read in the current mode. The script goes",
    "; on there: in bank $10, the interpreter's own, in mode 0; in any other bank in data-bank mode 1 with wDataBank =",
    "; that bank.",
    "ScriptFetchJumpFar::",
    "    pop hl",
    "    ld a, [wScriptInDataBank]",
    "    and a",
    "    jr nz, .data_bank",
    "    ld a, [hli]",
    "    ld c, a",
    "    ld a, [hli]",
    "    ld e, a",
    "    ld a, [hl]",
    "    ld d, a",
    "    jr .jump",
    "",
    ".data_bank:",
    "    call ReadScriptByte",
    "    ld c, a",
    "    call ReadScriptByte",
    "    ld e, a",
    "    call ReadScriptByte",
    "    ld d, a",
    "",
    ".jump:",
    "    ld a, c",
    "    cp BANK(ScriptFetchJumpFar)",
    "    jr z, .bank_10",
    "    ld [wDataBank], a",
    "    ld a, $01",
    "    jr .mode",
    "",
    ".bank_10:",
    "    xor a",
    "",
    ".mode:",
    "    ld [wScriptInDataBank], a",
    "    ld a, e",
    "    ld [wScriptPointerLo], a",
    "    ld a, d",
    "    ld [wScriptPointerHi], a",
    "    jp FetchScriptCommand_NextOpcode",
    "",
    "; opcode $09, script_command_far T: as ScriptFetchGeneric, with the command type in the byte after the opcode",
    "ScriptFetchCommandFar::",
    "    pop hl",
    "    call ReadScriptByte",
    "    ld [wScriptCommandType], a",
    "    call BeginScriptCommand",
    "    ret",
    "",
    "; opcode $10, script_command_far $62: as ScriptFetch62 (command $62, wScriptParam1 kept)",
    "ScriptFetch62Far::",
    "    pop hl",
    "    ld a, $62",
    "    ld [wScriptCommandType], a",
    "    ld a, [wScriptParam1]",
    "    push af",
    "    call BeginScriptCommand",
    "    pop af",
    "    ld [wScriptParam1], a",
    "    ret",
    "",
]


def insn_bytes(c: str) -> int:
    """The size of one SM83 instruction (or of this project's farcall and jumptable macros), as src/ writes it."""
    c = re.sub(r"\s+", " ", c.strip())
    op = c.split(" ")[0]
    args = c[len(op):].strip()
    if op == "farcall":
        return 6
    if op in ("jumptable", "ret", "reti", "nop", "halt", "di", "ei", "daa", "cpl", "scf", "ccf", "rlca", "rrca",
              "rla", "rra", "push", "pop"):
        return 1
    if op in ("call", "jp"):
        return 1 if args == "hl" else 3
    if op == "jr":
        return 2
    if op in ("bit", "set", "res", "swap", "rl", "rr", "rlc", "rrc", "sla", "sra", "srl", "stop"):
        return 2
    if op == "ldh":
        return 1 if "[c]" in args else 2
    if op in ("inc", "dec"):
        return 1
    if op in ("add", "adc", "sub", "sbc", "and", "xor", "or", "cp"):
        rhs = args.split(",")[-1].strip()
        if args.startswith("sp"):
            return 2
        return 1 if re.fullmatch(r"[abcdehl]|\[hl\]|hl|bc|de|sp", rhs) else 2
    if op == "ld":
        dst, src = (x.strip() for x in args.split(",", 1))
        regs8 = re.compile(r"[abcdehl]$|\[hl[id+-]?\]$")
        if regs8.match(dst) and regs8.match(src):
            return 1
        if dst in ("a",) and src in ("[bc]", "[de]") or src == "a" and dst in ("[bc]", "[de]"):
            return 1
        if dst in ("hl", "bc", "de", "sp") and src not in ("hl",):
            return 3 if not src.startswith("sp") else 2
        if dst == "sp":
            return 1
        if dst.startswith("[") or src.startswith("["):
            return 3
        return 2
    raise ValueError(f"`{c}`: no size known")


def code(ln: str) -> str:
    return ln.split(";")[0].strip()


def line_bytes(c: str) -> int:
    """Bytes of one script line (code only)."""
    op = c.split()[0]
    if op == "script_choice_jump":
        return 1 + len(c.split(None, 1)[1].split(","))
    if op == "db":
        return len(c[3:].split(","))
    if op == "script_command_far":
        return 1 if c.split()[1] in ("$62", "SCRIPT_PERSONALITY_MESSAGE") else 2
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


def opcode_table(S: list[str]) -> tuple[int, list[str]]:
    """(line of ScriptOpcodeHandlers, its 249 entries)."""
    t = next(k for k, ln in enumerate(S) if ln.startswith("ScriptOpcodeHandlers::"))
    out = []
    for ln in S[t + 1:]:
        if not ln.startswith("    dw "):
            break
        out.append(ln.split()[1])
    return t, out


def far_copy(S: list[str], handler: str, renamed: set[str]) -> list[str]:
    """The code of a handler (its section) for a far variant: its global labels get _Far, every `ld a, [hli]`
    becomes `call ReadScriptByte`; comments go."""
    a, b = section_body(S, handler)
    out = []
    for ln in S[a:b]:
        if ln.startswith(";") or not ln.strip() and out and not out[-1].strip():
            continue
        c = code(ln)
        if c == "ld a, [hli]":
            ln = "    call ReadScriptByte"
        elif re.search(r"\[hl[id]?\]", c) and not c.startswith("ld [hl"):
            raise ValueError(f"{handler}: `{c}` reads the script in a way this tool does not rewrite")
        ln = re.sub(r"\b(\w+)\b", lambda m: m.group(1) + "_Far" if m.group(1) in renamed else m.group(1), ln.split(";")[0])
        out.append(ln.rstrip())
    while out and not out[-1]:
        out.pop()
    return out + [""]


def patch_tree(tree: TS.Tree) -> int:
    """Patch the interpreter in tree (not saved). Returns the bytes bank $10 grows by."""
    S = tree.files[tree.src / SCRIPTS]
    if is_patched(tree):
        return 0
    t, tab = opcode_table(S)
    for slot in [JUMP_FAR_OP, FAR_GENERIC, FAR_62] + [far for _o, far in FAR_OPS.values()]:
        if tab[slot] != "$0000":
            raise ValueError(f"opcode ${slot:02X} of ScriptOpcodeHandlers is in use")
    for name, (orig, _far) in FAR_OPS.items():
        a, b = section_body(S, tab[orig])
        if any("wScriptInDataBank" in code(x) for x in S[a:b]):
            raise ValueError(f"{tab[orig]} reads through wDataBank already; it needs no far variant")
    # the handlers' code: each section of a handler, and the sections their jumps reach (Walk -> WalkFast's
    # ScriptFetch02_ReadOperands), copied once
    sections: list[str] = []
    for _n, (orig, _far) in FAR_OPS.items():
        h = tab[orig]
        if h not in sections:
            sections.append(h)
        a, b = section_body(S, h)
        for x in S[a:b]:
            if m := re.match(r"^\s+(?:jr|jp)(?: \w+,)? ([A-Z]\w+)", code(x) and "    " + code(x)):
                tgt = m.group(1)
                owner = next((y for y in tab if y != "$0000" and tgt != y and
                              any(z.startswith(tgt + "::") for z in S[slice(*section_body(S, y))])), None)
                if owner and owner not in sections:
                    sections.append(owner)
    renamed = {LABEL.match(x).group(1) for h in sections for x in S[slice(*section_body(S, h))] if LABEL.match(x)}
    body: list[str] = []
    for h in sections:
        body += far_copy(S, h, renamed)
    grow = sum(insn_bytes(code(x)) for x in FAR_HEAD + body if code(x) and not code(x).startswith(("SECTION",
                                                                                                    ".")) and not LABEL.match(x))
    for name, (orig, far) in FAR_OPS.items():
        S[t + 1 + far] = f"    dw {tab[orig]}_Far ; entry {far} (tools/script_bank.py: {name}_far)"
    S[t + 1 + JUMP_FAR_OP] = f"    dw ScriptFetchJumpFar ; entry {JUMP_FAR_OP} (tools/script_bank.py: script_jump_far)"
    S[t + 1 + FAR_GENERIC] = f"    dw ScriptFetchCommandFar ; entry {FAR_GENERIC} (tools/script_bank.py: script_command_far)"
    S[t + 1 + FAR_62] = f"    dw ScriptFetch62Far ; entry {FAR_62} (tools/script_bank.py: script_command_far $62)"
    s = next(k for k, ln in enumerate(S) if ln.startswith('SECTION "Bank 10 BeginScriptCommand"'))
    S[s:s] = FAR_HEAD + ["; the far variants: the handlers' own code, their reads through ReadScriptByte"] + body + [""]
    TS.fill_change(S, SCRIPTS, -grow)
    for name, rel in STARTERS.items():  # 19 bytes each become `jp StartScriptAtHL` (3)
        F = tree.files[tree.src / rel]
        a = next(k for k, ln in enumerate(F) if ln.startswith(name + "::"))
        b = TS.routine_end(F, a)
        if [code(x) for x in F[a + 1:b] if code(x)] != STARTER_OLD:
            raise ValueError(f"{name} is not the routine this tool rewrites")
        F[a + 1:b] = ["    jp StartScriptAtHL ; tools/script_bank.py: clears wScriptInDataBank first", ""]
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
    tree.other[macros] = text.rstrip("\n") + "\n" + "\n".join(far_macros(text)) + "\n"
    tree.dirty |= {tree.src / SCRIPTS, tree.src / HOME}
    return grow


def far_macros(text: str) -> list[str]:
    """The macros of the far opcodes: each `_far` one is its original with the far opcode byte."""
    out = ["", "; tools/script_bank.py (a mod's interpreter, not the original game): opcodes of moved scripts, read in",
           "; data-bank mode (E-0423). script_jump_far: the script goes on at \\1, in its bank.",
           "MACRO script_jump_far", "    db $08, BANK(\\1)", "    dw \\1", "ENDM",
           "; a generic command (ScriptFetchCommandFar), or command $62 (ScriptFetch62Far)",
           "MACRO script_command_far", "    IF (\\1) == $62", "        db $10", "    ELSE", "        db $09, \\1",
           "    ENDC", "ENDM"]
    for name, (orig, far) in FAR_OPS.items():
        m = re.search(rf"^MACRO {name}\n(.*?)^ENDM", text, re.M | re.S)
        if not m:
            raise ValueError(f"src/macros.inc has no MACRO {name}")
        lines = m.group(1).rstrip("\n").split("\n")
        first = re.sub(rf"\$0?{orig:X}\b", f"${far:02X}", lines[0], count=1, flags=re.I)
        if first == lines[0]:
            raise ValueError(f"MACRO {name} does not start with its opcode ${orig:02X}")
        out += [f"MACRO {name}_far", first] + lines[1:] + ["ENDM"]
    return out


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
            elif op == "script_command" and c.split()[1] in NESTED:
                r.why_not = r.why_not or (f"{c.split()[1]}: it runs while a data-bank script waits, whose menu resumes "
                                          f"it with the wDataBank this script would change")
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
    if int(to, 16) == 0x10:
        raise ValueError("the scripts are in bank $10 already")
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
    consts = {m.group(1): int(m.group(2), 16) for m in
              re.finditer(r"^DEF (SCRIPT_\w+) EQU \$([0-9A-Fa-f]+)", tree.text("macros.inc"), re.M)}
    _t, tab = opcode_table(S)
    quiet = set()  # handlers that read no byte after the opcode: their commands run unchanged in data-bank mode
    for h in set(tab) - {"$0000"} - set(RE_READERS):
        a, b = section_body(S, h)
        if not any(re.search(r"\[hl[id]?\]", code(x)) and not code(x).startswith("ld [hl") for x in S[a:b]):
            quiet.add(h)

    def far_line(ln: str) -> str:
        m = LABEL.match(ln)
        if m:
            return ln.replace(m.group(1) + "::", m.group(1) + "_Far::", 1)
        c = code(ln)
        if not c:
            return ln
        op = c.split()[0]
        if op in FAR_OPS:
            return ln.replace(op + " ", op + "_far ", 1)
        if op == "script_command":
            arg = c.split()[1]
            n = consts.get(arg, int(arg[1:], 16) if arg.startswith("$") else None)
            if n is None:
                raise ValueError(f"`{c}`: unknown command")
            if tab[n] in RE_READERS:
                return ln.replace("script_command ", "script_command_far ", 1)
            if tab[n] not in quiet:
                raise ValueError(f"`{c}`: its handler {tab[n]} reads bytes this tool does not rewrite")
            return ln
        if op == "script_jump_data_bank":  # E-0420: the bank the talk routine puts in wDataBank is the target's
            return ln.replace("script_jump_data_bank ", "script_jump_far ", 1)
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
    far_bytes = sum(line_bytes(code(x)) for x in out if code(x) and not LABEL.match(x))
    TS.fill_change(S, SCRIPTS, freed - stub_bytes)
    new = src / "scripts" / f"bank{to.lower()}_scripts_10_far.asm"
    TS.claim_empty_bank(tree, to, new)
    head = [f"; ROM bank ${to.upper()}: event scripts of bank $10 (moved here by tools/script_bank.py; not in the original",
            "; game). The interpreter reads them in data-bank mode with wDataBank = this bank (script_jump_far).", "",
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


def script_positions(src: Path) -> dict[str, list[int]]:
    """E-0423: for every Script_ label of a tree, the offsets of its instructions from the label up to the next label
    (any file). A moved script's far opcodes can be longer than the originals, so traces compare instruction indexes."""
    out: dict[str, list[int]] = {}
    for f in sorted(src.glob("*/bank*.asm")):
        cur, off = None, 0
        for ln in f.read_text(encoding="utf-8").split("\n"):
            if m := LABEL.match(ln):
                cur, off = (m.group(1), 0) if m.group(1).startswith("Script_") else (None, 0)
                if cur:
                    out[cur] = []
                continue
            c = code(ln)
            if cur is None or not c:
                continue
            try:
                n = line_bytes(c)
            except ValueError:
                cur = None
                continue
            out[cur].append(off)
            off += n
    return out


def fetch_trace(sym: dict, log: list, src: Path | None = None) -> dict:
    """E-0421: a pc hook (for mod_check.recipe_compare) that appends to `log` where each script opcode is read from:
    the label at or before that address in the bank read (`_Far` taken off) and the offset, or, with the tree the ROM
    was built from (E-0423), the instruction's index after the label. A stub's script_jump_far in bank $10 is not
    listed. The same scripts give the same trace from the original and from a mod whose scripts moved, whatever the
    timing."""
    import bisect
    by_bank: dict[int, list] = {}
    for n, (b, a) in sym.items():
        by_bank.setdefault(b, []).append((a, n))
    for v in by_bank.values():
        v.sort()
    b10, at = sym["FetchScriptCommand_NextOpcode"]
    pos = script_positions(src) if src else {}

    def hook(g):
        if g.rombank != b10:
            return
        p = g.rb(W_SCRIPT_POINTER) | g.rb(W_SCRIPT_POINTER + 1) << 8
        mode = g.rb(W_SCRIPT_IN_DATA_BANK)
        bank = b10 if mode == 0 else g.rb(W_DATA_BANK) if mode == 1 else mode
        if bank == b10 and g.rom[bank * 0x4000 + p - 0x4000] == JUMP_FAR_OP:  # a stub: the script is read on past it
            return
        v = by_bank.get(bank, [])
        k = bisect.bisect_right(v, (p, "~")) - 1
        if k < 0:
            log.append(f"{bank:02X}:{p:04X}")
            return
        lab, off = v[k][1], p - v[k][0]
        offs = pos.get(lab)
        where = f"#{offs.index(off)}" if offs and off in offs else f"+{off}"
        log.append(lab.removesuffix("_Far") + where)

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
