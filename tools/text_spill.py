#!/usr/bin/env python3
"""Make room in a full message bank: move its last messages to the bank's overflow table (for translations).

Thirteen message groups are split in two. In group 0, for example, BeginStringDisplay_Bank28 and
CopyStringToBuffer_Bank28 (bank $28) look up ids below $DA in StringList_Bank28_0, and send ids from $DA on to
BeginStringDisplay_Bank28_Overflow and CopyStringToBuffer_Bank28_Overflow (bank $97), which subtract $DA and use
StringList_Bank28_Overflow_0. In every group the split equals the length of the first list, there is one string
category, and no message body is named by two lists (checked by `spill` before it changes anything).

`spill BANK N` lowers a group's split by N: the last N pointers of the first list go to the front of the overflow
list, their message bodies go to the overflow bank, and the `cp` in the two routines of BANK and the `sub` in the
two overflow routines change from SPLIT to SPLIT - N. Message ids do not change, so nothing that shows a message
needs editing. BANK's fill grows by the bytes moved.

LookupString stores the bank mapped at $4000 (its first byte) in wStringBank, and the text printer reads the string
from that bank, so an overflow table, its strings and the two routines that pass it must share a bank. The overflow
banks $97 and $98 are full. With `--to BB` the whole overflow group (its three routines, its table and every body
it names) first moves to BB, which must be one of the empty banks (src/unused/bankBB_empty.asm); it becomes
src/text/bankBB_messages_GG_overflow.asm, with BB's number at $4000. Without --to the overflow bank must have room.

    python -I tools/text_spill.py groups [--src DIR]
    python -I tools/text_spill.py spill BANK N [--to BB] --src DIR
    python -I tools/text_spill.py spill-categories BANK FIRST --to BB --src DIR

A bank with no split, whose lookups take one category table (the battle text's bank $2F, and the string banks of
code banks such as $07 and $F0), can instead move whole categories: `spill-categories BANK FIRST --to BB` moves
categories FIRST and up, with their lists and strings, to the empty bank BB. BeginStringDisplay_BankBB and
CopyStringToBuffer_BankBB become `cp FIRST` on wStringCategory and far-call the new bank's copies for those
categories (bank $08's lookups already do this for categories from 9 on). They grow by 14 bytes each.

`spill` refuses src/ itself: it is for a mod's copy (tools/make_mod.py, mod.json "spill") because the matching
build must keep the original layout. The routine shapes it rewrites are checked line by line first; anything
unexpected is refused. Read from the routines, checked on tools/sm83.py by tests/test_text_spill.py (C2 on the
project's emulator, not hardware).
"""
from __future__ import annotations

import argparse
import re
import sys
from dataclasses import dataclass
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import gb_text as T  # noqa: E402
from datatables import FILL  # noqa: E402

LABEL = re.compile(r"^([A-Za-z_]\w*)::")
SECTION = re.compile(r'^SECTION "([^"]+)", ROMX')
DW = re.compile(r"^    dw (\w+)")
DB = re.compile(r"^    db (.*)$")
# the routine shapes, without comments; {} is the table, the split byte or the overflow routine
MAIN_SHAPE = ["ld a, [wStringIndex]", "cp ${s}", "jr c, .{local}", "farcall {target}", "ret", "",
              ".{local}:", "ld de, MessageStrings_Bank{b}", "call {call}", "ret"]
OVERFLOW_SHAPE = ["ld de, MessageStrings_Bank{b}_Overflow", "ld a, [wStringIndex]", "sub ${s}",
                  "ld [wStringIndex], a", "call {call}", "ret"]
SHOW_SHAPE = ["call {begin}_Bank{b}_Overflow", "call RunStringDisplayToEnd", "ret"]
ROUTINE_BYTES = {"begin": 15, "CopyStringToBuffer": 15, "ShowStringAtOnce": 7}  # the shapes above
# the display entry's name: bank $0E's is BeginMessageDisplay_Bank0E (and its overflow routine likewise)
BEGIN_NAMES = ("BeginStringDisplay", "BeginMessageDisplay")


class Tree:
    """src/'s bank files as line lists, written back with save()."""

    def __init__(self, src: Path):
        self.src = src
        self.files = {f: f.read_text(encoding="utf-8").split("\n") for f in sorted(src.glob("*/bank[0-9a-f][0-9a-f]_*.asm"))}
        self.dirty: set[Path] = set()
        self.other: dict[Path, str] = {}  # main.asm and layout.link, written by save() too
        self.gone: list[Path] = []

    def where(self, label: str) -> tuple[Path, int]:
        for f, L in self.files.items():
            for i, ln in enumerate(L):
                if ln.startswith(label + "::"):
                    return f, i
        raise ValueError(f"{label} is not in {self.src}")

    def line(self, f: Path, label: str) -> int:
        """The line of a label in one file."""
        for i, ln in enumerate(self.files[f]):
            if ln.startswith(label + "::"):
                return i
        raise ValueError(f"{label} is not in {f.name}")

    def text(self, rel: str) -> str:
        p = self.src / rel
        return self.other.get(p) or p.read_text(encoding="utf-8")

    def save(self) -> None:
        """Write every change at once, so a refusal leaves the tree as it was."""
        for f in self.dirty:
            f.write_text("\n".join(self.files[f]), encoding="utf-8", newline="\n")
        for p, t in self.other.items():
            p.write_text(t, encoding="utf-8", newline="\n")
        for p in self.gone:
            p.unlink()


def code(ln: str) -> str:
    return ln.split(";")[0].strip()


def dw_list(L: list[str], i: int) -> list[tuple[int, str]]:
    """(line, name) of the dw lines right after the label on line i."""
    out = []
    for k in range(i + 1, len(L)):
        m = DW.match(L[k])
        if not m:
            break
        out.append((k, m.group(1)))
    return out


def comment_start(L: list[str], i: int) -> int:
    """The first line of the comment block right above line i (i itself when there is none)."""
    while i > 0 and L[i - 1].startswith(";"):
        i -= 1
    return i


def routine_end(L: list[str], i: int) -> int:
    """The line after a routine starting at label line i: its code, local labels and blank lines up to the next
    global label, comment or SECTION."""
    k = i + 1
    while k < len(L) and not LABEL.match(L[k]) and not L[k].startswith((";", "SECTION")):
        k += 1
    return k


def body(L: list[str], i: int) -> tuple[int, int, int]:
    """(first line, end line, bytes) of the message body whose label is on line i: the comment above it, the label,
    its db lines and one blank line after them."""
    k = i + 1
    raw = b""
    while k < len(L) and (m := DB.match(L[k])):
        raw += T.parse(m.group(1))
        k += 1
    if k == i + 1:
        raise ValueError(f"{LABEL.match(L[i]).group(1)}: no db lines")
    if k < len(L) and L[k] == "":
        k += 1
    return comment_start(L, i), k, len(raw)


def fill_change(L: list[str], name: str, grow: int) -> None:
    """Make a bank file's trailing fill `grow` bytes larger (smaller when negative); a file without one gets one."""
    k = max((i for i, ln in enumerate(L) if FILL.match(ln)), default=None)
    if k is None:
        if grow < 0:
            raise ValueError(f"{name} is full: it has no fill to give {-grow} bytes; spill with --to an empty bank")
        while L and L[-1] == "":
            L.pop()
        L += [f"    ds ${grow:x}, $00", ""]
        return
    m = FILL.match(L[k])
    free = int(m.group(3)[1:], 16) if m.group(3).startswith("$") else int(m.group(3))
    if free + grow < 0:
        raise ValueError(f"{name} needs {-grow - free} more bytes than its {free}-byte fill; spill with --to an "
                         f"empty bank")
    L[k] = f"{m.group(1)}{m.group(2)} ${free + grow:x}{m.group(4) or ''}{m.group(5) or ''}"


@dataclass
class Group:
    bank: str          # "28"
    begin: str         # "BeginStringDisplay", or "BeginMessageDisplay" for bank $0E
    split: int
    main_file: Path
    over_file: Path
    main_list: list[str]
    over_list: list[str]


def matches(L: list[str], i: int, shape: list[str], **kw) -> bool:
    """The routine on label line i is exactly this shape (comments and blank lines aside, one blank line kept where
    the shape has one)."""
    got = [code(ln) for ln in L[i + 1:routine_end(L, i)]]
    while got and got[-1] == "":
        got.pop()
    want = [s.format(**kw) for s in shape]
    if "" not in want:
        got = [g for g in got if g]
    return got == want


def group(tree: Tree, bank: str) -> Group:
    bank = bank.upper()
    for begin in BEGIN_NAMES:  # bank $0E has a plain BeginStringDisplay_Bank0E too; the split one is wanted
        try:
            f, i = tree.where(f"{begin}_Bank{bank}")
        except ValueError:
            continue
        L = tree.files[f]
        m = re.search(r"cp \$([0-9a-f]{2})", "\n".join(code(x) for x in L[i:i + 4]))
        if m and f.parent.name in ("text", "data"):
            break
    else:
        raise ValueError(f"bank ${bank} has no split message group")
    s = int(m.group(1), 16)
    for name, call in ((begin, "BeginStringDisplay"), ("CopyStringToBuffer", "CopyStringToBuffer")):
        fi, ii = tree.where(f"{name}_Bank{bank}")
        head = "\n".join(tree.files[fi][ii:ii + 5])
        local = re.search(r"jr c, \.(\w+)", head).group(1)
        # CopyStringToBuffer_Bank82 far-calls the display overflow routine, not the copy one (E-0080, a likely
        # game bug kept as it is), so either target is accepted
        target = re.search(rf"farcall ((?:{begin}|CopyStringToBuffer)_Bank{bank}_Overflow)\b", head)
        if fi != f or not target or not matches(tree.files[fi], ii, MAIN_SHAPE, s=f"{s:02x}", local=local, b=bank,
                                                target=target.group(1), call=call):
            raise ValueError(f"{name}_Bank{bank} is not the split routine this tool rewrites")
    fo, io = tree.where(f"{begin}_Bank{bank}_Overflow")
    for name, shape, call in ((begin, OVERFLOW_SHAPE, "BeginStringDisplay"),
                              ("CopyStringToBuffer", OVERFLOW_SHAPE, "CopyStringToBuffer"),
                              ("ShowStringAtOnce", SHOW_SHAPE, None)):
        fr, ir = tree.where(f"{name}_Bank{bank}_Overflow")
        if fr != fo or not matches(tree.files[fr], ir, shape, b=bank, s=f"{s:02x}", call=call, begin=begin):
            raise ValueError(f"{name}_Bank{bank}_Overflow is not the overflow routine this tool rewrites")
    lists = []
    for table in (f"MessageStrings_Bank{bank}", f"MessageStrings_Bank{bank}_Overflow"):
        ft, it = tree.where(table)
        cats = dw_list(tree.files[ft], it)
        if len(cats) != 1 or ft != (f if table.endswith(bank) else fo):
            raise ValueError(f"{table}: expected one category in its bank's file")
        fl, il = tree.where(cats[0][1])
        lists.append([n for _, n in dw_list(tree.files[fl], il)])
    if len(lists[0]) != s:
        raise ValueError(f"bank ${bank}: the split ${s:02X} is not the length of its first list ({len(lists[0])})")
    return Group(bank, begin, s, f, fo, lists[0], lists[1])


def groups(tree: Tree) -> list[Group]:
    out = []
    for f in tree.files:
        if f.parent.name == "text" and "_messages_" in f.name:
            try:
                out.append(group(tree, f.name[4:6]))
            except ValueError:
                pass
    for f in tree.files:  # bank $83's group is in a strings file, bank $0E's in a data file
        if (f.parent.name == "text" and "_strings_" in f.name or f.parent.name == "data") and any(
                ln.startswith(tuple(f"{b}_Bank{f.name[4:6].upper()}::" for b in BEGIN_NAMES)) for ln in tree.files[f]):
            try:
                out.append(group(tree, f.name[4:6]))
            except ValueError:
                pass
    return sorted(out, key=lambda g: g.bank)


def free_bytes(L: list[str]) -> int:
    k = max((i for i, ln in enumerate(L) if FILL.match(ln)), default=None)
    if k is None:
        return 0
    v = FILL.match(L[k]).group(3)
    return int(v[1:], 16) if v.startswith("$") else int(v)


# ---- moving the overflow group to an empty bank -----------------------------------------------------------------

def cut(L: list[str], a: int, b: int) -> list[str]:
    out = L[a:b]
    del L[a:b]
    return out


def layout_remove(tree: Tree, sections: list[str]) -> None:
    L = tree.text("layout.link").split("\n")
    L = [ln for ln in L if ln.strip().strip('"') not in sections or not ln.startswith("\t")]
    tree.other[tree.src / "layout.link"] = "\n".join(L)


def move_group(tree: Tree, g: Group, to: str) -> Path:
    """Move g's overflow routines, table, list and bodies from its overflow bank to the empty bank `to`."""
    src = tree.src
    new = src / "text" / f"bank{to.lower()}_messages_{g.bank.lower()}_overflow.asm"
    claim_empty_bank(tree, to, new)
    L = tree.files[g.over_file]
    moved: list[str] = []
    gone_sections = []
    size = 0
    for name in (g.begin, "CopyStringToBuffer", "ShowStringAtOnce"):
        i = tree.line(g.over_file, f"{name}_Bank{g.bank}_Overflow")
        a, b = comment_start(L, i), routine_end(L, i)
        sec = None
        if a >= 2 and L[a - 1] == "" and (m := SECTION.match(L[a - 2])) and (b >= len(L) or L[b].startswith("SECTION")):
            sec, a = m.group(1), a - 2  # a section holding only this routine
        block = cut(L, a, b)
        if sec:
            gone_sections.append(sec)
            block = block[2:]
        while block and block[-1] == "":
            block.pop()
        moved += block + [""]
        size += ROUTINE_BYTES["begin" if name == g.begin else name]
    i = tree.line(g.over_file, f"MessageStrings_Bank{g.bank}_Overflow")
    if not (L[i + 2] == "" or LABEL.match(L[i + 2])):
        raise ValueError(f"MessageStrings_Bank{g.bank}_Overflow: expected one pointer")
    a = comment_start(L, i)
    b = i + 2 + (L[i + 2] == "")
    moved += cut(L, a, b)
    i = tree.line(g.over_file, f"StringList_Bank{g.bank}_Overflow_0")
    a = comment_start(L, i)
    b = i + 1 + len(g.over_list)
    b += b < len(L) and L[b] == ""
    moved += cut(L, a, b)
    size += 2 + 2 * len(g.over_list)
    for name in dict.fromkeys(g.over_list):
        a, b, n = body(L, tree.line(g.over_file, name))
        moved += cut(L, a, b)
        size += n
    fill_change(L, g.over_file.name, size)
    tree.dirty.add(g.over_file)
    if gone_sections:
        layout_remove(tree, gone_sections)
    head = [f"; ROM bank ${to.upper()}: the overflow messages of message bank ${g.bank} (moved here by "
            f"tools/text_spill.py; not in the original game)", "",
            f'SECTION "Bank {to.upper()}", ROMX', f"    db ${to.lower()} ; the bank number LookupString reads at $4000", ""]
    while moved and moved[-1] == "":
        moved.pop()
    tree.files[new] = head + moved + ["", f"    ds ${0x4000 - 1 - size:x}, $00", ""]
    tree.dirty.add(new)
    g.over_file = new
    return new


def claim_empty_bank(tree: Tree, to: str, new: Path) -> None:
    """Check that bank `to` is one of the empty banks, and arrange for src/unused/bankBB_empty.asm to give way to
    the file `new` (main.asm includes it instead). Written by tree.save()."""
    src = tree.src
    empty = src / "unused" / f"bank{to.lower()}_empty.asm"
    if empty not in tree.files:
        raise ValueError(f"bank ${to.upper()} is not one of the empty banks (src/unused/bank{to.lower()}_empty.asm)")
    if [code(x) for x in tree.files[empty] if code(x)][1:] not in (["DS $4000, $00"], ["DS $4000, $ff"],
                                                                   ["DS $4000, $FF"]):
        raise ValueError(f"bank ${to.upper()}: {empty.name} is not a single $4000-byte fill")
    text = tree.text("main.asm")
    old_inc = f'INCLUDE "unused/{empty.name}"'
    if old_inc not in text:
        raise ValueError(f"main.asm does not include unused/{empty.name}")
    tree.other[src / "main.asm"] = text.replace(old_inc, f'INCLUDE "text/{new.name}"')
    del tree.files[empty]
    tree.gone.append(empty)


# ---- the spill ---------------------------------------------------------------------------------------------------

def set_split(L: list[str], i: int, op: str, old: int, new: int) -> None:
    """Rewrite `op $old` in the routine on label line i, and $OLD in the comment block above it."""
    a, b = comment_start(L, i), routine_end(L, i)
    hits = 0
    for k in range(a, b):
        if k < i:
            L[k] = re.sub(rf"\${old:02X}\b", f"${new:02X}", L[k], flags=re.I)
        elif code(L[k]) == f"{op} ${old:02x}":
            L[k] = L[k].replace(f"{op} ${old:02x}", f"{op} ${new:02x}")
            hits += 1
    if hits != 1:
        raise ValueError(f"line {i + 1}: expected one `{op} ${old:02x}`")


def spill(src: Path, bank: str, n: int, to: str | None = None) -> dict:
    """Move the last n messages of bank's first list to its overflow list. Returns what moved."""
    if src.resolve() == (ROOT / "src").resolve():
        raise ValueError("spill changes the layout; run it on a mod's copy of src/, never on src/ itself")
    tree = Tree(src)
    g = group(tree, bank)
    if not 0 < n < g.split:
        raise ValueError(f"bank ${g.bank}: N must be from 1 to {g.split - 1} (its first list has {g.split})")
    kept, gone = g.main_list[:g.split - n], g.main_list[g.split - n:]
    shared = sorted(set(kept) & set(gone))
    if shared:
        ok = [k for k in range(1, g.split) if not set(g.main_list[:g.split - k]) & set(g.main_list[g.split - k:])]
        near = sorted(ok, key=lambda k: abs(k - n))[:2]
        raise ValueError(f"{shared[0]} is shown for ids on both sides of the new split; spill "
                         f"{' or '.join(map(str, sorted(near)))} instead")
    if to:
        move_group(tree, g, to)
    F, O = tree.files[g.main_file], tree.files[g.over_file]
    new_split = g.split - n
    # the first list loses its last n pointers, and the bank its moved bodies
    i = tree.line(g.main_file, f"StringList_Bank{g.bank}_0")
    rows = dw_list(F, i)
    del F[rows[-n][0]:rows[-1][0] + 1]
    bodies, size = [], 0
    for name in dict.fromkeys(gone):
        a, b, nb = body(F, tree.line(g.main_file, name))
        bodies += cut(F, a, b)
        size += nb
    for name in (g.begin, "CopyStringToBuffer"):
        set_split(F, tree.line(g.main_file, f"{name}_Bank{g.bank}"), "cp", g.split, new_split)
    fill_change(F, g.main_file.name, size + 2 * n)
    # the overflow list gains them at its front, and its bank the bodies
    for name in (g.begin, "CopyStringToBuffer"):
        set_split(O, tree.line(g.over_file, f"{name}_Bank{g.bank}_Overflow"), "sub", g.split, new_split)
    i = tree.line(g.over_file, f"StringList_Bank{g.bank}_Overflow_0")
    names = gone + g.over_list
    end = i + 1 + len(g.over_list)
    O[i + 1:end] = [f"    dw {x} ; id {k}" for k, x in enumerate(names)]
    end = i + 1 + len(names)
    while bodies and bodies[-1] == "":
        bodies.pop()
    if O[end] == "":
        O[end + 1:end + 1] = bodies + [""]
    else:
        O[end:end] = [""] + bodies + [""]
    fill_change(O, g.over_file.name, -(size + 2 * n))
    tree.dirty |= {g.main_file, g.over_file}
    tree.save()
    return {"bank": g.bank, "moved": n, "split": f"${g.split:02X} -> ${new_split:02X}", "bytes": size + 2 * n,
            "overflow_bank": g.over_file.name[4:6].upper(), "ids": [f"${k:02X}" for k in range(new_split, g.split)]}


# ---- moving whole string categories (a bank with one plain category table) ---------------------------------------

PLAIN_SHAPE = ["ld de, BeginStringDisplay_Bank{b}_StringCategories", "call {call}", "ret"]
CATEGORY_ROUTINE = [  # written in place of a plain lookup's three instructions: 21 bytes instead of 7
    "    ld a, [wStringCategory]",
    "    cp ${k:02x}",
    "    jr c, .this_bank",
    "    farcall {name}_Bank{b}_Spill",
    "    ret",
    "",
    ".this_bank:",
    "    ld de, BeginStringDisplay_Bank{b}_StringCategories",
    "    call {call}",
    "    ret",
]


def spill_categories(src: Path, bank: str, first: int, to: str) -> dict:
    """Move string categories `first` and up of a bank with one plain category table (BeginStringDisplay_BankBB and
    CopyStringToBuffer_BankBB: `ld de, table / call ... / ret`, like the battle text's bank $2F) to the empty bank
    `to`. The two lookups then send those categories there (`cp first`, as bank $08's lookups already do for its
    categories from 9 on); category and string numbers do not change. Returns what moved."""
    if src.resolve() == (ROOT / "src").resolve():
        raise ValueError("spill changes the layout; run it on a mod's copy of src/, never on src/ itself")
    tree = Tree(src)
    bank = bank.upper()
    table = f"BeginStringDisplay_Bank{bank}_StringCategories"
    f, ti = tree.where(table)
    F = tree.files[f]
    for name in ("BeginStringDisplay", "CopyStringToBuffer"):
        fi, ii = tree.where(f"{name}_Bank{bank}")
        if fi != f or not matches(F, ii, PLAIN_SHAPE, b=bank, call=name):
            raise ValueError(f"{name}_Bank{bank} is not the plain lookup (ld de, {table} / call / ret) this tool rewrites")
    named: dict[str, int] = {}
    for L in tree.files.values():
        for ln in L:
            c = code(ln)
            if c.startswith("SECTION"):  # a section's name is not a use
                continue
            if LABEL.match(c):
                c = c.split("::", 1)[1]
            for w in re.findall(r"\b[A-Za-z_]\w*\b", c):
                named[w] = named.get(w, 0) + 1
    if named.get(table) != 2:
        raise ValueError(f"{table} is named {named.get(table, 0)} times; only its two lookups may name it")
    cats = [n for _, n in dw_list(F, ti)]
    if not 0 < first < len(cats):
        raise ValueError(f"bank ${bank}: FIRST must be from 1 to {len(cats) - 1} (it has {len(cats)} categories)")
    if len(set(cats)) != len(cats):
        raise ValueError(f"{table}: two categories share a list")
    lists = {n: [x for _, x in dw_list(F, tree.line(f, n))] for n in cats}
    kept = {x for n in cats[:first] for x in lists[n]}
    gone = [x for n in cats[first:] for x in lists[n]]
    for x in dict.fromkeys(gone):
        if x in kept or named.get(x, 0) != gone.count(x):
            raise ValueError(f"{x} is named outside the categories that would move; choose another FIRST")
    word = "battle_text" if "_battle_text" in f.name else "messages" if "_messages_" in f.name else "strings"
    new = src / "text" / f"bank{to.lower()}_{word}_{bank.lower()}_spill.asm"
    claim_empty_bank(tree, to, new)
    # the two lookups
    for name in ("BeginStringDisplay", "CopyStringToBuffer"):
        i = tree.line(f, f"{name}_Bank{bank}")
        F[i + 1:routine_end(F, i)] = [x.format(k=first, name=name, b=bank, call=name) for x in CATEGORY_ROUTINE] + [""]
        F.insert(i, f"; tools/text_spill.py: categories from ${first:02X} on are read in bank ${to.upper()} "
                    f"({name}_Bank{bank}_Spill)")
    # the table keeps its first categories; their lists and strings stay, the rest move
    ti = tree.line(f, table)
    rows = dw_list(F, ti)
    del F[rows[first][0]:rows[-1][0] + 1]
    moved: list[str] = []
    size = 0
    for n in cats[first:]:
        i = tree.line(f, n)
        b = i + 1 + len(lists[n])
        b += b < len(F) and F[b] == ""
        moved += cut(F, comment_start(F, i), b)
        size += 2 * len(lists[n])
    for x in dict.fromkeys(gone):
        a, b, nb = body(F, tree.line(f, x))
        moved += cut(F, a, b)
        size += nb
    fill_change(F, f.name, size + 2 * (len(cats) - first) - 2 * 14)
    head = [f"; ROM bank ${to.upper()}: string categories ${first:02X}-${len(cats) - 1:02X} of bank ${bank} (moved here by "
            f"tools/text_spill.py; not in the original game)", "",
            f'SECTION "Bank {to.upper()}", ROMX', f"    db ${to.lower()} ; the bank number LookupString reads at $4000", ""]
    for name in ("BeginStringDisplay", "CopyStringToBuffer"):
        head += [f"; {name} with this bank's category table (far-called by {name}_Bank{bank} for categories from "
                 f"${first:02X} on)",
                 f"{name}_Bank{bank}_Spill::", f"    ld de, StringCategories_Bank{bank}_Spill", f"    call {name}",
                 "    ret", ""]
    head += [f"; one list per string category; categories below ${first:02X} are read in bank ${bank}",
             f"StringCategories_Bank{bank}_Spill::"]
    head += [f"    dw $0000 ; id {k} (in bank ${bank})" for k in range(first)]
    head += [f"    dw {n} ; id {k}" for k, n in enumerate(cats) if k >= first] + [""]
    while moved and moved[-1] == "":
        moved.pop()
    size_new = 1 + 2 * 7 + 2 * len(cats) + size
    tree.files[new] = head + moved + ["", f"    ds ${0x4000 - size_new:x}, $00", ""]
    tree.dirty |= {f, new}
    tree.save()
    return {"bank": bank, "categories": f"${first:02X}-${len(cats) - 1:02X}", "to": to.upper(), "bytes": size,
            "lists": {k: len(lists[n]) for k, n in enumerate(cats)}}


# ---- checking a spilled build on tools/sm83.py -------------------------------------------------------------------

W_STRING_CATEGORY, W_STRING_INDEX, W_STRING_BANK = 0xC528, 0xC529, 0xC52A
W_TEXT_POS, W_STRING_DEST = 0xC533, 0xC53D
BUFFER, RETURN = 0xD000, 0xC800


def call(rom: bytes, bank: int, address: int, string_id: int, category: int = 0):
    """Run one routine of a ROM on tools/sm83.py with wStringCategory category, wStringIndex string_id and the copy
    destination BUFFER, until it returns. Returns the emulator."""
    from sm83 import GameBoy

    class Returned(Exception):
        pass

    gb = GameBoy(rom)
    gb.rombank = bank
    for a, v in ((W_STRING_CATEGORY, category), (W_STRING_INDEX, string_id), (W_STRING_DEST, BUFFER & 0xFF),
                 (W_STRING_DEST + 1, BUFFER >> 8)):
        gb.wb(a, v)
    gb.sp = 0xDFF0
    gb.wb(gb.sp, RETURN & 0xFF)
    gb.wb(gb.sp + 1, RETURN >> 8)
    gb.pc = address

    def stop(_):
        raise Returned

    gb.pc_hooks[RETURN] = stop
    try:
        gb.run(200_000)
    except Returned:
        return gb
    raise RuntimeError(f"{bank:02X}:{address:04X} did not return for id {string_id}")


def string_at(rom: bytes, bank: int, address: int) -> bytes:
    """The bytes of a string in a ROM bank up to and with its $F0 end."""
    off = bank * 0x4000 + address - 0x4000
    end = rom.index(0xF0, off, (bank + 1) * 0x4000)  # ValueError when the bank ends first
    return rom[off:end + 1]


def shown(rom: bytes, sym: dict, bank: str, string_id: int, category: int = 0) -> bytes:
    """The string BeginStringDisplay_BankBB (BeginMessageDisplay_Bank0E) points the text printer at for an id:
    (wStringBank, wTextPos)."""
    b, a = sym.get(f"BeginMessageDisplay_Bank{bank}") or sym[f"BeginStringDisplay_Bank{bank}"]
    gb = call(rom, b, a, string_id, category)
    return string_at(rom, gb.rb(W_STRING_BANK), gb.rb(W_TEXT_POS) | gb.rb(W_TEXT_POS + 1) << 8)


def copied(rom: bytes, sym: dict, bank: str, string_id: int, category: int = 0) -> bytes:
    """What CopyStringToBuffer_BankBB writes at BUFFER for an id (up to and with $F0; empty when nothing)."""
    b, a = sym[f"CopyStringToBuffer_Bank{bank}"]
    gb = call(rom, b, a, string_id, category)
    out = bytearray()
    for k in range(0x800):
        out.append(gb.rb(BUFFER + k))
        if out[-1] == 0xF0:
            return bytes(out)
    return b"" if not any(out) else bytes(out)


def verify(ref: bytes, ref_sym: dict, mod: bytes, mod_sym: dict, counts: dict[str, int]) -> list[str]:
    """Differences between two ROMs in the string every id of each group shows and copies (counts: bank -> its
    number of ids, the two lists' lengths; ids past them read past the overflow list). Bank $82's copy entry
    far-calls the display overflow routine (E-0080), so it copies nothing from its split on; that split moves, so
    its copies are compared only below the lower of the two splits. An id whose original string has no $F0 end
    in its bank (bank $83's ids from $F2 point at bank $97's zero tail, Text_HeroHeroHeroHero) is listed as
    "skipped", not run: the printer and the copy would read on past the bank."""
    def split(rom: bytes, sym: dict, bank: str) -> int:  # the operand of `cp`, after `ld a, [wStringIndex]`
        b, a = sym.get(f"BeginMessageDisplay_Bank{bank}") or sym[f"BeginStringDisplay_Bank{bank}"]
        return rom[b * 0x4000 + a - 0x4000 + 4]

    bad = []
    for bank, count in counts.items():
        low = min(split(ref, ref_sym, bank), split(mod, mod_sym, bank))
        for i in range(count):
            try:
                want = shown(ref, ref_sym, bank, i)
            except ValueError:
                bad.append(f"skipped: bank ${bank} id ${i:02X} (no end mark in the original)")
                continue
            if want != shown(mod, mod_sym, bank, i):
                bad.append(f"bank ${bank} id ${i:02X}: shows another string")
            if (bank != "82" or i < low) and copied(ref, ref_sym, bank, i) != copied(mod, mod_sym, bank, i):
                bad.append(f"bank ${bank} id ${i:02X}: copies another string")
    return bad


def verify_categories(ref: bytes, ref_sym: dict, mod: bytes, mod_sym: dict, bank: str,
                      lengths: dict[int, int]) -> list[str]:
    """Differences between two ROMs in the string each (category, id) of a bank shows and copies (lengths: category
    -> its list's length). Ids whose original string has no end mark in its bank are listed as skipped."""
    bad = []
    for c, n in lengths.items():
        for i in range(n):
            try:
                want = shown(ref, ref_sym, bank, i, c)
            except ValueError:
                bad.append(f"skipped: bank ${bank} category {c} id ${i:02X} (no end mark in the original)")
                continue
            if want != shown(mod, mod_sym, bank, i, c):
                bad.append(f"bank ${bank} category {c} id ${i:02X}: shows another string")
            if copied(ref, ref_sym, bank, i, c) != copied(mod, mod_sym, bank, i, c):
                bad.append(f"bank ${bank} category {c} id ${i:02X}: copies another string")
    return bad


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("command", choices=["groups", "spill", "spill-categories"])
    ap.add_argument("bank", nargs="?")
    ap.add_argument("n", nargs="?", type=int)
    ap.add_argument("--to")
    ap.add_argument("--src", type=Path, default=ROOT / "src")
    a = ap.parse_args(argv)
    if a.command == "groups":
        tree = Tree(a.src)
        print("bank  split  overflow bank  first list  overflow list  free bytes (bank, overflow bank)")
        for g in groups(tree):
            print(f"${g.bank}   ${g.split:02X}    ${g.over_file.name[4:6].upper()}            {len(g.main_list):3}         "
                  f"{len(g.over_list):3}            {free_bytes(tree.files[g.main_file])}, {free_bytes(tree.files[g.over_file])}")
        return 0
    if a.bank is None or a.n is None:
        ap.error(f"{a.command} needs BANK and N")
    try:
        if a.command == "spill-categories":
            if not a.to:
                ap.error("spill-categories needs --to BB (an empty bank)")
            res = spill_categories(a.src, a.bank, a.n, a.to)
            print(f"bank ${res['bank']}: categories {res['categories']} ({res['bytes']} bytes) to bank ${res['to']}")
            return 0
        res = spill(a.src, a.bank, a.n, a.to)
    except ValueError as e:
        print(f"refused: {e}")
        return 1
    print(f"bank ${res['bank']}: {res['moved']} messages ({res['bytes']} bytes) to bank ${res['overflow_bank']}; "
          f"split {res['split']}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
