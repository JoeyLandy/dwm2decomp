"""Measure how much of the bank files in src/ is documented (the pokered baseline: every routine and table has a comment).

A code label is documented when a `;` comment block sits directly above it. A data label is documented
when it has its own comment, when its body is text (`db "..."`: the text is its documentation, as in pokered),
or when an earlier label of the same unbroken run of data labels carries a comment (one header comment per
table, as in pokered). Labels are code when the first line under them is an instruction, data when it is
db/dw/INCBIN or a data macro (script_*, objsel_*, ...). Comments that admit a gap ("not read",
"not interpreted", "unknown") are counted separately.

    python -I tools/doc_coverage.py [--list code|data|gaps] [--bank NN]
"""
import argparse
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import present  # noqa: E402
DATA_FIRST = re.compile(r"^\s+(?:(?:db|dw|dl|dfar|ds|INCBIN|dbw|dwb|bigdw|dn|d24)\b|(?:script|objsel|text|sound|snd)_\w+)")
HAND_EVIDENCE = present.HAND_EVIDENCE  # whole-routine readings in config/annotations.json
HAND_NOTE = present.HAND_NOTE
RESTATED = "(E-0347)"  # the generated list of a routine's effects (tools/describe.py)
GAP = re.compile(r"not read|not interpreted|\bunknown\b|not decoded|purpose unclear")  # in code notes


def scan(path: Path):
    lines = path.read_text(encoding="utf-8").split("\n")
    for i, ln in enumerate(lines):
        m = re.match(r"^([A-Za-z_]\w*)::", ln)
        if not m:
            continue
        j = i - 1
        comment = []
        while j >= 0 and lines[j].startswith(";"):
            comment.insert(0, lines[j])
            j -= 1
        first = next((x for x in lines[i + 1:i + 6] if x.strip() and not x.startswith(";")
                      and not re.match(r"^\.?\w+:", x) and not x.strip().startswith("ASSERT")), "")  # E-0389
        kind = "data" if DATA_FIRST.match(first) else "code"
        text_body = kind == "data" and re.match(r'^\s+db "', first) is not None
        yield m.group(1), kind, " ".join(comment), i + 1, text_body


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--list", choices=("code", "data", "gaps", "stale"))
    ap.add_argument("--bank")
    args = ap.parse_args()
    files = present.bank_files()
    if args.bank:
        files = [f for f in files if f.name.startswith(f"bank{args.bank.lower()}")]
    tot = {"code": [0, 0], "data": [0, 0]}
    gaps = hand = restated = 0
    for f in files:
        header = False  # a commented label earlier in the current run of data labels
        for name, kind, comment, line, text_body in scan(f):
            tot[kind][0] += 1
            if kind == "code":
                header = False
                hand += HAND_NOTE.search(comment.split("; why: ")[0]) is not None
                restated += RESTATED in comment.split("; why: ")[0]
            elif comment:
                header = True
            covered = bool(comment) or (kind == "data" and (text_body or header))
            if covered:
                tot[kind][1] += 1
                if (kind == "code" and GAP.search(comment.split("; why: ")[0]) and "; code:" not in comment  # E-0347: restated
                        and not HAND_NOTE.search(comment)):  # E-0365: or read by hand
                    gaps += 1
                    if args.list == "gaps":
                        print(f"{f.name}:{line} {name}: {comment[:140]}")
            elif args.list == kind:
                print(f"{f.name}:{line} {name}")
    for k, (n, d) in tot.items():
        print(f"{k}: {n} labels, {d} documented ({100 * d / max(n, 1):.1f}%), {n - d} without a comment")
    print(f"documented labels whose comment admits a gap with no restatement of the code: {gaps}")
    print(f"code labels described by a hand-written note ({', '.join(HAND_EVIDENCE)}): {hand}; "
          f"only by a generated restatement of their instructions (E-0347): {restated}")
    stale = stale_names(files)
    print(f"names in comments that are no label, RAM symbol or constant: {len(stale)} ({sum(stale.values())} uses)")
    if args.list == "stale":
        for w, n in stale.most_common():
            print(n, w)


def note_counts(files) -> tuple[int, int]:
    """(code labels with a whole-routine reading, labels described only by a generated restatement)."""
    hand = restated = 0
    for f in files:
        for _, kind, comment, _, _ in scan(f):
            if kind == "code":
                note = comment.split("; why: ")[0]
                hand += HAND_NOTE.search(note) is not None
                restated += RESTATED in note
    return hand, restated


def stale_names(files) -> "collections.Counter":
    """Label-like words in comments (CamelCase with an underscore, or three humps) that name nothing in src/."""
    import collections
    known: set[str] = set()
    for f in present.bank_files():
        known |= set(re.findall(r"^([A-Za-z_]\w*)::", f.read_text(encoding="utf-8"), re.M))
    for f in ("ram.asm", "constants.inc", "hardware.inc", "macros.inc", "charmap.inc"):
        q = ROOT / "src" / f
        if q.exists():
            t = q.read_text(encoding="utf-8")
            known |= set(re.findall(r"^(?:DEF|MACRO) (\w+)", t, re.M)) | set(re.findall(r"^(\w+)::?", t, re.M))
    # game words (skill, item and monster names, menu text) are not labels: those that appear in the text
    # data or in the id constants' comments
    for f in present.bank_files():
        for q in re.findall(r'db "([^"]*)"', f.read_text(encoding="utf-8")):
            known |= set(re.findall(r"[A-Za-z0-9]+", q))
    known |= set(re.findall(r"; (\w+)$", (ROOT / "src/constants.inc").read_text(encoding="utf-8"), re.M))
    known |= {"MaxHP", "MaxMP"}  # stat names as the game's status screen prints them
    # a library family's name stands for its per-bank copies (config/name_families.json); tests are cited by class
    known |= set(re.findall(r'"name": "(\w+)"', (ROOT / "config/name_families.json").read_text(encoding="utf-8")))
    for f in (ROOT / "tests").glob("test_*.py"):
        known |= set(re.findall(r"^class (\w+)", f.read_text(encoding="utf-8"), re.M))
    word = re.compile(r"\b([A-Z][a-z]+[A-Za-z0-9]*(?:_[A-Za-z0-9]+)+|[A-Z][a-z]+(?:[A-Z][a-z0-9]*){2,})\b")
    history = re.compile(r"(?:\bwas|\bfrom|\bformerly|\bnot)\s+$")  # a former name, cited as such
    out = collections.Counter()
    for f in files:
        blocks, cur = [], []
        for ln in f.read_text(encoding="utf-8").split("\n"):  # a wrapped comment is read as one block
            if ln.startswith(";"):
                cur.append(ln[1:].strip())
                continue
            if cur:
                blocks.append(" ".join(cur))
                cur = []
            if ";" in ln:
                blocks.append(ln[ln.index(";") + 1:])
        for com in blocks:
            com = re.sub(r"'[^']*'", " ", com)  # quoted game text
            if True:
                for m in word.finditer(com):
                    w = m.group(1)
                    if w not in known and not history.search(com[:m.start()]):
                        out[w] += 1
    return out


if __name__ == "__main__":
    main()
