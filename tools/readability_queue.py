"""The readability work queue, recomputed from the presented source (src/) and config/ (E-0368).

Five queues, in the order the readability goal works them (docs/PROJECT_STATUS.md, D-011):

1. instruction: code labels the generator named from their instructions or a callee (`Parent_WriteXAndY`,
   `Parent_ReadByteAtHLPlusA`, `Parent_ToFoo`, `Parent_Skip`): every global code label whose name is not given by
   config/names.json, except per-bank copies of a given name (`Foo_Bank05`), names made from the message a step
   shows (`Parent_Show...`, `TalkMsg...`), table-index names (`ScriptCommandEE`, `BattleTextPrep01`) and the cases
   config/indexed_dispatch.json names from id constants (`RemoveEquipmentBonus_VITbelt`);
2. long: global labels longer than 50 characters;
3. unread: code labels without a hand-written whole-routine note (doc_coverage.HAND_NOTE);
4. data: data labels described only by their reader and size (`; data read by Foo (8 bytes)`), by their own
   comment or by the header of their run;
5. asset: INCBIN asset files that only the catch-all rule placed (gfx/misc/) and whose label has no hand-written
   note (E-0382: the note identifies the content, or says what was tried when it stays unidentified).

    python -I tools/readability_queue.py [--list QUEUE] [--json OUT]
"""
import argparse
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import doc_coverage  # noqa: E402
import present  # noqa: E402

COPY = re.compile(r"^(\w+?)_(?:Bank|B)[0-9A-F]{2}(?:_\d+)?$")
MESSAGE = re.compile(r"(?:^|_)(?:Show|Msg[0-9A-F]{4}_|TalkMsg[0-9A-F]{4})")
INDEX = re.compile(r"^(?:[A-Z][a-z0-9]*)+(?:_(?:[A-Z][a-z0-9]*)+)?[0-9A-F]{2}$")
READER_ONLY = re.compile(r"^; (?:data read by [^;]*?|data block)(?: \([^)]*\))?(?: \(E-\d{4}\))?$")
LONG = 50


def given_names(root: Path = ROOT) -> set[str]:
    """Names chosen by reading: config/names.json and name_families.json while the generator's config is present,
    else the list frozen at graduation (tests/data/given_names.txt, D-015 H1b)."""
    if not (root / "config/names.json").exists():
        frozen = root / "tests/data/given_names.txt"
        return {ln.strip() for ln in frozen.read_text(encoding="utf-8").splitlines() if ln.strip() and ln[0] != "#"}
    names = json.loads((root / "config/names.json").read_text(encoding="utf-8"))
    given = {v if isinstance(v, str) else v["name"] for k, v in names.items()
             if not k.startswith("_") and (isinstance(v, str) or "name" in v)}
    fam = root / "config/name_families.json"  # a per-bank helper family's chosen name
    if fam.exists():
        given |= {f["name"] for f in json.loads(fam.read_text(encoding="utf-8")).get("families", [])}
    return given


def indexed_prefixes(root: Path = ROOT) -> tuple[str, ...]:
    """Case-name prefixes of config/indexed_dispatch.json: its cases are named <name>_<Id> from the id constants."""
    p = root / "config/indexed_dispatch.json"
    if not p.exists():
        return ()
    return tuple(t["name"] + "_" for t in json.loads(p.read_text(encoding="utf-8")).get("tables", []))


def instruction_named(name: str, given: set[str], indexed: tuple[str, ...] = ()) -> bool:
    if name in given or MESSAGE.search(name) or INDEX.match(name) or (indexed and name.startswith(indexed)):
        return False
    m = COPY.match(name)
    return not (m and (m.group(1) in given or not instruction_named(m.group(1), given, indexed)))


def queues(files=None, root: Path = ROOT) -> dict[str, list[str]]:
    files = files if files is not None else present.bank_files(root)
    given = given_names(root)
    indexed = indexed_prefixes(root)
    q: dict[str, list[str]] = {"instruction": [], "long": [], "unread": [], "data": [], "asset": []}
    for f in files:
        header = ""
        noted: dict[int, bool] = {}  # label line -> the label has a hand-written note
        for name, kind, comment, line, text_body in doc_coverage.scan(f):
            noted[line] = bool(doc_coverage.HAND_NOTE.search(comment.split("; why: ")[0]))
            where = f"{f.name}:{line} {name}"
            if len(name) > LONG:
                q["long"].append(where)
            if kind == "code":
                header = ""
                if instruction_named(name, given, indexed):
                    q["instruction"].append(where)
                if not doc_coverage.HAND_NOTE.search(comment.split("; why: ")[0]):
                    q["unread"].append(where)
                continue
            if comment:
                header = comment
            if not text_body and READER_ONLY.match(comment or header):
                q["data"].append(where)
        for n, ln in enumerate(f.read_text(encoding="utf-8").split("\n"), 1):
            if 'INCBIN "gfx/misc/' in ln:
                owner = max((k for k in noted if k < n), default=None)
                if owner is None or not noted[owner]:  # a hand note identifies it, or says what was tried
                    q["asset"].append(f"{f.name}:{n} {ln.split(chr(34))[1]}")
    return q


def slices(q: dict[str, list[str]], order: list[str], snap: dict[str, str], size: int, count: int,
           skip: set[str] = frozenset()) -> list[list[dict]]:
    """The next `count` slices of about `size` labels: the labels of the first queue in `order` that still has
    any, in source order, each with every queue it is in; a slice ends where the next label starts a new
    routine family (its first name part differs), so a routine stays with its steps."""
    at = {v: k for k, v in snap.items()}
    member: dict[str, list[str]] = {}
    where: dict[str, str] = {}
    for name in order:
        for w in q[name]:
            label = w.split()[-1]
            member.setdefault(label, []).append(name)
            where[label] = w.split()[0]
    first = next((name for name in order if any(w.split()[-1] not in skip and w.split()[-1] in at for w in q[name])),
                 None)
    if first is None:
        return []
    picked = [w.split()[-1] for w in q[first] if w.split()[-1] not in skip and w.split()[-1] in at]
    out: list[list[dict]] = []
    cur: list[dict] = []
    for label in picked:
        if len(cur) >= size and label.split("_")[0] != cur[-1]["label"].split("_")[0] or len(cur) >= 2 * size:
            out.append(cur)
            cur = []
            if len(out) == count:
                return out
        bank, addr = at[label].split(":")
        cur.append({"label": label, "bank": bank, "address": addr, "where": where[label], "queues": member[label]})
    if cur:
        out.append(cur)
    return out[:count]


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--list", choices=("instruction", "long", "unread", "data", "asset"))
    ap.add_argument("--json", type=Path)
    ap.add_argument("--slices", type=Path, help="write the next slices here (needs --snapshot)")
    ap.add_argument("--snapshot", type=Path, help="tools/label_map.py snapshot of the current listing")
    ap.add_argument("--size", type=int, default=80)
    ap.add_argument("--count", type=int, default=5)
    ap.add_argument("--order", default="instruction,long,unread,data")
    ap.add_argument("--skip", type=Path, help="a JSON list of labels to leave out (re-queued elsewhere)")
    args = ap.parse_args()
    q = queues()
    if args.slices:
        snap = json.loads(args.snapshot.read_text(encoding="utf-8"))
        skip = set(json.loads(args.skip.read_text(encoding="utf-8"))) if args.skip else set()
        sl = slices(q, args.order.split(","), snap, args.size, args.count, skip)
        args.slices.write_text(json.dumps(sl, indent=1), encoding="utf-8")
        print(f"{len(sl)} slices: " + ", ".join(str(len(s)) for s in sl))
    for k, v in q.items():
        print(f"{k}: {len(v)}")
    files = present.bank_files()
    labels = [n for f in files for n, *_ in doc_coverage.scan(f)]
    print(f"labels over 60 characters: {sum(len(n) > 60 for n in labels)}; "
          f"`Etc` names: {sum(bool(re.search(r'Etc(?:_|$)', n)) for n in labels)}")
    if args.list:
        print("\n".join(q[args.list]))
    if args.json:
        args.json.write_text(json.dumps(q, indent=1), encoding="utf-8")
    return 0


if __name__ == "__main__":
    sys.exit(main())
