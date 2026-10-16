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
       move_section.py --move "Bank 12 SomeRoutine" --to 3A [--frames 3000] [--out build/move]
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
                banked = "dfar" in code or (not re.match(r"(call|jp|jr)\b", code) and  # a jump never switches banks
                                            any(bank_check.BANKED.search(x) for x in lines[max(0, i - 3):i + 4]))
                for tok in TOKEN.findall(code):  # every label a line names: operands, dw entries, LOW/HIGH, + offsets
                    cur["refs"].append((i, glob_ + tok if tok.startswith(".") else tok, banked))
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
    ap.add_argument("--move")
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
    subprocess.run([str(shift_test.RGBDS / "rgblink.exe"), "-l", base_src / "layout.link", "-m", out / "base/dwm2.map",
                    "-o", out / "base/map.gbc", out / "base/main.o"], check=True, capture_output=True)
    size = section_sizes(out / "base/dwm2.map")[args.move]
    src = out / "moved/src"
    shutil.copytree(base_src, src)
    (src / "layout.link").write_text(move((src / "layout.link").read_text(encoding="utf-8"), args.move, to),
                                     encoding="utf-8", newline="\n")
    files = shift_test.bank_files(src)
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
    report = {"section": args.move, "size": size, "to": f"{to:02X}", "assembled": rom is not None}
    if rom is None:
        report["assembler_log"] = log[-3000:]
    else:
        msym = bank_check.load_sym(out / "moved/dwm2.sym")
        errors, warnings = bank_check.check(src, msym)
        report["bank_check_errors"] = errors[:20]
        moved_labels = sections_of(src)[args.move]["labels"]
        report["labels_now_in_bank"] = sorted({f"{b:02X}" for k, (b, _a) in msym.items() if k in moved_labels})
        report["frames"] = args.frames
        report["first_differing_frame"] = shift_test.first_difference(
            shift_test.frame_hashes(base, args.frames), shift_test.frame_hashes(rom, args.frames), shift_test.PERSIST)
    (out / "report.json").write_text(json.dumps(report, indent=1), encoding="utf-8")
    ok = rom is not None and not report.get("bank_check_errors") and report.get("first_differing_frame") is None
    print(json.dumps({k: v for k, v in report.items() if k != "assembler_log"}, indent=1))
    print(f"{'PASS' if ok else 'FAIL'}: {args.move} ({size} bytes) moved to bank ${to:02X}")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
