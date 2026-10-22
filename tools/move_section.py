#!/usr/bin/env python3
"""M2 section move (E-0393): move one section of src/ to another bank in a scratch copy and check the game.

src/layout.link places every section (tools/present.py). A section can move to another bank when nothing in its
old bank reaches into it, or out of it into the old bank, except through a bank-switching path (farcall, BANK(),
a literal `ld b` bank). `--list` names such sections. `--move NAME --to BB` copies src/ under build/, moves the
section's line in the copy's layout.link to bank BB (before BB's last section) and shortens BB's last `ds` fill by
the section's size, assembles and links the copy (never the matching target), runs tools/bank_check.py on it, and
compares its video state with the unchanged copy's frame by frame in tools/sm83.py (tools/shift_test.py). Moving
code does not change instruction timing, so a move that works shows the same frames.

Usage: move_section.py --list [--frames 3000]
       move_section.py --move "Bank 12 SomeRoutine" [--move ...] --to 3A [--frames 3000] [--out build/move]
"""
from __future__ import annotations

import argparse
import json
import re
import shutil
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import bank_check  # noqa: E402
import shift_test  # noqa: E402

SECTION = re.compile(r'^SECTION "([^"]+)", (ROM0|ROMX)')
GLOBAL = re.compile(r"^([A-Za-z_]\w*)::")
REF = re.compile(r"^\s+(?:call|jp|jr|ld (?:hl|de|bc),)(?: (?:z|nz|c|nc),)? ([A-Za-z_.][\w.]*)\s*(?:;.*)?$")


TOKEN = re.compile(r"(?<![\w$%])\.?[A-Za-z_][\w.]*")


def bank_check_code(ln: str) -> str:
    """The code part of a line: no comment, no string, no local-label definition."""
    if not ln.startswith("    "):
        return ""
    out, q = [], False
    for ch in ln:
        if ch == '"':
            q = not q
            continue
        if ch == ";" and not q:
            break
        if not q:
            out.append(ch)
    return "".join(out).strip()


def sections_of(src: Path) -> dict[str, dict]:
    """Section name -> {file, labels, refs: [(line index, label, text)], lines: [line texts]}."""
    out: dict[str, dict] = {}
    for p in sorted(src.glob("*/bank*.asm")):
        cur, glob_ = None, None
        lines = p.read_text(encoding="utf-8").split("\n")
        for i, ln in enumerate(lines):
            m = SECTION.match(ln)
            if m:
                cur = out.setdefault(m.group(1), {"file": p, "labels": set(), "refs": [], "lines": []})
                continue
            if cur is None:
                continue
            cur["lines"].append(ln)
            if (g := GLOBAL.match(ln)):
                glob_ = g.group(1)
                cur["labels"].add(glob_)
            code = bank_check_code(ln)
            if code and glob_ and not GLOBAL.match(ln):
                jump = re.match(r"(call|jp|jr)\b", code)  # a jump never switches banks
                far = "dfar" in code or re.match(r"farcall(_b)?\b", code)
                for tok in TOKEN.findall(code):  # every label a line names: operands, dw entries, LOW/HIGH, + offsets
                    name = glob_ + tok if tok.startswith(".") else tok
                    # E-0419: only BANK(label) of this label beside it, or in the code that runs on to the read
                    banked = bool(far) or (not jump and (
                        any(f"BANK({name})" in x for x in lines[max(0, i - 3):i + 4])
                        or bank_check.names_bank_later(lines, i, name)))
                    cur["refs"].append((i, name, banked))
    return out


def movable(secs: dict[str, dict], sym: dict[str, tuple[int, int]]) -> list[tuple[str, int]]:
    """Sections of a switchable bank with no unbanked reference between them and the rest of their bank or bank
    $00 code: (name, bank)."""
    owner = {lab: n for n, s in secs.items() for lab in s["labels"]}
    out = []
    for n, s in secs.items():
        labs = [x for x in s["labels"] if x in sym]
        if not labs or not n.startswith("Bank ") or n.split()[1] == "00" or len(n.split()) < 3:
            continue
        bank = sym[labs[0]][0]
        ok = True
        for _i, name, banked in s["refs"]:  # out of the section into its own bank
            if banked or name.split(".")[0] in s["labels"] or name not in sym:
                continue
            if sym[name][0] == bank and sym[name][1] >= 0x4000:
                ok = False
                break
        if not ok:
            continue
        for m, t in secs.items():  # into the section from its bank or from bank $00
            if m == n:
                continue
            for _i, name, banked in t["refs"]:
                if not banked and name.split(".")[0] in s["labels"] and owner.get(name.split(".")[0]) == n:
                    tl = [x for x in t["labels"] if x in sym]
                    if tl and sym[tl[0]][0] in (0, bank):
                        ok = False
                        break
            if not ok:
                break
        if ok:
            out.append((n, bank))
    return out


def move(layout: str, name: str, to: int) -> str:
    """layout.link text with section `name` moved before the last section of bank `to`."""
    lines = [ln for ln in layout.split("\n") if ln.strip() != f'"{name}"']
    if len(lines) == len(layout.split("\n")):
        raise ValueError(f"no section {name!r} in the layout")
    head = f"ROMX ${to:02X}"
    if head not in lines:
        raise ValueError(f"no bank ${to:02X} in the layout")
    i = lines.index(head) + 1
    j = i
    while j < len(lines) and lines[j].startswith("\t"):
        j += 1
    last = max(k for k in range(i, j) if lines[k].strip().startswith('"'))
    lines.insert(last, f'\t"{name}"')
    return "\n".join(lines)


EMPTY = re.compile(r"^\s*DS \$4000, \$(00|FF)\s*$", re.I)


def claim_empty(path: Path, to: int, layout: str) -> str:
    """E-0423: an empty bank (src/unused/bankBB_empty.asm, one `DS $4000` fill) has no bank number at $4000, where every
    other bank keeps it (BANK_NUMBER_BYTE): the VBlank handler and ReadWordFromDataBank read it to map the caller's
    bank back. A section moved there first would put its own first byte at $4000, so an interrupt while the bank is
    mapped returns into the wrong bank. The bank gets its number in section "Bank BB" and its fill in a last section
    "Bank BB Fill", which moved sections go before. Returns the layout; other banks are left as they are."""
    lines = path.read_text(encoding="utf-8").split("\n")
    fills = [k for k, ln in enumerate(lines) if EMPTY.match(ln)]
    if len(fills) != 1 or any(ln.strip().startswith(("db", "dw", "INCBIN")) for ln in lines):
        return layout
    k = fills[0]
    fill = lines[k].strip().split(",")[1].strip()
    lines[k:k + 1] = [f"    db ${to:02x} ; the bank number at $4000 (tools/move_section.py, E-0423)", "",
                      f'SECTION "Bank {to:02X} Fill", ROMX', f"    ds $3fff, {fill}"]
    path.write_text("\n".join(lines), encoding="utf-8", newline="\n")
    return layout.replace(f'\t"Bank {to:02X}"\n', f'\t"Bank {to:02X}"\n\t"Bank {to:02X} Fill"\n', 1)


def section_sizes(map_path: Path) -> dict[str, int]:
    out = {}
    for ln in map_path.read_text(encoding="utf-8").split("\n"):
        m = re.search(r'SECTION: \$[0-9a-f]+-\$[0-9a-f]+ \(\$([0-9a-f]+) bytes?\) \["([^"]+)"\]', ln)
        if m:
            out[m.group(2)] = int(m.group(1), 16)
    return out


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--list", action="store_true")
    ap.add_argument("--move", action="append", help="a section name; repeat it to move several to the same bank "
                    "(E-0422: script sections that jump to each other move together)")
    ap.add_argument("--to")
    ap.add_argument("--frames", type=int, default=3000)
    ap.add_argument("--out", default="build/move")
    args = ap.parse_args(argv)
    out = (ROOT / args.out).resolve()
    if (ROOT / "build").resolve() not in out.parents:
        sys.exit("output dir must be beneath build/")
    shutil.rmtree(out, ignore_errors=True)
    base_src = out / "base/src"
    shutil.copytree(ROOT / "src", base_src)
    base, log = shift_test.assemble(base_src, out / "base")
    if base is None:
        print(log)
        sys.exit("FAIL: the copy of src/ does not assemble")
    sym = bank_check.load_sym(out / "base/dwm2.sym")
    if args.list:
        secs = sections_of(base_src)
        found = movable(secs, sym)
        print(f"{len(found)} of {len(secs)} sections can move without an unbanked reference to their bank")
        for n, b in found[:40]:
            print(f"  {n}")
        return 0
    if not (args.move and args.to):
        sys.exit("give --list, or --move NAME --to BB")
    to = int(args.to, 16)
    # the map file of the base build gives the section's size
    import subprocess
    import toolchain
    subprocess.run([str(toolchain.exe("rgblink")), "-l", base_src / "layout.link", "-m", out / "base/dwm2.map",
                    "-o", out / "base/map.gbc", out / "base/main.o"], check=True, capture_output=True)
    sizes = section_sizes(out / "base/dwm2.map")
    size = sum(sizes[name] for name in args.move)
    src = out / "moved/src"
    shutil.copytree(base_src, src)
    layout = (src / "layout.link").read_text(encoding="utf-8")
    files = shift_test.bank_files(src)
    layout = claim_empty(files[to], to, layout)
    for name in args.move:
        layout = move(layout, name, to)
    (src / "layout.link").write_text(layout, encoding="utf-8", newline="\n")
    text = files[to].read_text(encoding="utf-8").split("\n")
    for k in range(len(text) - 1, -1, -1):  # the target bank gives up `size` bytes of its last fill
        m = shift_test.DS.match(text[k])
        if m:
            n = int(m.group(3)[1:], 16) if m.group(3).startswith("$") else int(m.group(3))
            if n < size:
                sys.exit(f"FAIL: bank ${to:02X}'s last fill has {n} bytes, the section needs {size}")
            text[k] = f"{m.group(1)}{m.group(2)} ${n - size:X}{m.group(4) or ''}{m.group(5) or ''}" if n > size \
                else f"{m.group(1)}; ds used by move_section"
            break
    files[to].write_text("\n".join(text), encoding="utf-8", newline="\n")
    rom, log = shift_test.assemble(src, out / "moved")
    report = {"section": args.move[0] if len(args.move) == 1 else args.move, "size": size, "to": f"{to:02X}",
              "assembled": rom is not None}
    if rom is None:
        report["assembler_log"] = log[-3000:]
    else:
        msym = bank_check.load_sym(out / "moved/dwm2.sym")
        errors, warnings = bank_check.check(src, msym)
        report["bank_check_errors"] = errors[:20]
        secs = sections_of(src)
        moved_labels = {lab for name in args.move for lab in secs[name]["labels"]}
        report["labels_now_in_bank"] = sorted({f"{b:02X}" for k, (b, _a) in msym.items() if k in moved_labels})
        report["frames"] = args.frames
        report["first_differing_frame"] = shift_test.first_difference(
            shift_test.frame_hashes(base, args.frames), shift_test.frame_hashes(rom, args.frames), shift_test.PERSIST)
    (out / "report.json").write_text(json.dumps(report, indent=1), encoding="utf-8")
    ok = rom is not None and not report.get("bank_check_errors") and report.get("first_differing_frame") is None
    print(json.dumps({k: v for k, v in report.items() if k != "assembler_log"}, indent=1))
    print(f"{'PASS' if ok else 'FAIL'}: {', '.join(args.move)} ({size} bytes) moved to bank ${to:02X}")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
