"""Validate reading drafts and write the accepted ones into config/ (E-0368).

A draft is a JSON list of entries, one per label, written by a reader who only read the source:

    {"label": "Inn_Skip", "bank": "05", "address": "4002", "kind": "code",
     "proposed_name": "Inn_CloseWindow" or null (keep the name),
     "note": "what the routine does, its inputs and outputs" or null (keep the note),
     "confidence": "C1", "evidence_read": [...], "open_questions": [...], "collisions": [...]}

`validate` checks every entry against the current listing (build/listing) and prints one problem per line.
`apply` writes the entries of drafts that validate: a new name goes into config/names.json (a data label with
"data": true, or the label of its config/tables.json layout), with evidence "<E> (named from its reading; was
<old>)"; a note goes into config/annotations.json for code (ending "(<confidence>, <E>)", which tools/present.py
and tools/doc_coverage.py count as a hand-written reading) and into the names.json or tables.json note for data.

    python -I tools/apply_drafts.py validate SNAPSHOT.json DRAFT.json...
    python -I tools/apply_drafts.py apply --evidence E-0369 SNAPSHOT.json DRAFT.json...

SNAPSHOT.json is `tools/label_map.py snapshot` of the listing the drafts were read from.
"""
import argparse
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import readability  # noqa: E402
import readability_queue  # noqa: E402

NAME = re.compile(r"^[A-Z][A-Za-z0-9]*(?:_[A-Za-z0-9]+)*$")
WORD = re.compile(r"\b([A-Z][a-z]+[A-Za-z0-9]*(?:_[A-Za-z0-9]+)+|[A-Z][a-z]+(?:[A-Z][a-z0-9]*){2,})\b")
MAX_NAME = 50
CONF = {"C1", "C2", "C3"}


def known_symbols(root: Path = ROOT) -> set[str]:
    known: set[str] = set()
    for f in ("ram.asm", "constants.inc", "hardware.inc", "macros.inc", "charmap.inc", "records.inc"):
        p = root / "src" / f
        if p.exists():
            t = p.read_text(encoding="utf-8")
            known |= set(re.findall(r"^(?:DEF|MACRO) (\w+)", t, re.M))
    for p in root.glob("src/*/bank[0-9a-f][0-9a-f]_*.asm"):  # labels the listing gives no address alias (scripts)
        known |= set(re.findall(r"^([A-Za-z_]\w*)::", p.read_text(encoding="utf-8"), re.M))
    return known


def key(e: dict) -> str:
    return f"{int(str(e['bank']), 16):02X}:{int(str(e['address']).lstrip('$'), 16):04X}"


def load(paths) -> list[dict]:
    out = []
    for p in paths:
        data = json.loads(Path(p).read_text(encoding="utf-8"))
        entries = data["entries"] if isinstance(data, dict) else data
        for e in entries:
            e["_draft"] = str(p)
            out.append(e)
    return out


def validate(entries: list[dict], snap: dict[str, str], root: Path = ROOT) -> list[str]:
    problems = []
    labels = set(snap.values())
    by_label = {v: k for k, v in snap.items()}
    given = readability_queue.given_names(root)
    known = labels | known_symbols(root)
    renamed = {e["label"] for e in entries if e.get("proposed_name") and e["proposed_name"] != e.get("label")}
    proposals: dict[str, str] = {}
    all_new = {e["proposed_name"] for e in entries if e.get("proposed_name")}
    seen: set[str] = set()
    for e in entries:
        where = f"{Path(e['_draft']).name} {e.get('label')}"
        try:
            k = key(e)
        except (KeyError, ValueError):
            problems.append(f"{where}: no bank/address")
            continue
        if k in seen:
            problems.append(f"{where}: {k} drafted twice")
        seen.add(k)
        if snap.get(k) != e.get("label"):
            problems.append(f"{where}: the label at {k} is {snap.get(k)}, not {e.get('label')}")
        if e.get("kind") not in ("code", "data"):
            problems.append(f"{where}: kind must be code or data")
        if e.get("confidence") not in CONF:
            problems.append(f"{where}: confidence {e.get('confidence')!r}")
        if not e.get("evidence_read"):
            problems.append(f"{where}: no evidence_read")
        new = e.get("proposed_name")
        if new and new != e.get("label"):
            if not NAME.match(new):
                problems.append(f"{where}: name {new} is not a CamelCase label")
            if len(new) > MAX_NAME:
                problems.append(f"{where}: name {new} is longer than {MAX_NAME}")
            if new in labels and new not in renamed:
                problems.append(f"{where}: name {new} is already the label at {by_label.get(new)}")
            if new in proposals:
                problems.append(f"{where}: name {new} also proposed for {proposals[new]}")
            proposals[new] = e["label"]
            if readability.STRUCT.search(new) or re.search(r"Etc(?:_|$)|_\d+$", new):
                problems.append(f"{where}: name {new} is mechanical (address, structural part, Etc or _N)")
        note = e.get("note")
        if note is not None:
            if not isinstance(note, str) or len(note) < 20:
                problems.append(f"{where}: note too short")
                continue
            if not note.isascii():
                problems.append(f"{where}: note is not ASCII")
            if re.search(r"\((?:C\d, )?E-\d{4}\)\s*$", note):
                problems.append(f"{where}: note ends in an evidence id (the tool adds it)")
            for m in WORD.finditer(re.sub(r"'[^']*'", " ", note)):
                w = m.group(1)
                if w not in known and w not in all_new and w not in given:
                    problems.append(f"{where}: note names {w}, which is no label or symbol")
        elif not new or new == e.get("label"):
            problems.append(f"{where}: neither a name nor a note")
    return problems


def apply(entries: list[dict], snap: dict[str, str], evidence: str, root: Path = ROOT) -> dict[str, int]:
    names_p, ann_p, tab_p = (root / "config" / f for f in ("names.json", "annotations.json", "tables.json"))
    names = json.loads(names_p.read_text(encoding="utf-8"))
    ann = json.loads(ann_p.read_text(encoding="utf-8"))
    tables = json.loads(tab_p.read_text(encoding="utf-8"))
    tab_at = {f"{int(t['bank'], 16):02X}:{int(t['addr'], 16):04X}": t for t in tables["tables"]}
    counts = {"renamed": 0, "code_notes": 0, "data_notes": 0}
    changed_names: list[str] = []
    for e in entries:
        k, old = key(e), e["label"]
        new = e.get("proposed_name") if e.get("proposed_name") not in (None, "", old) else None
        note = e.get("note")
        conf = e.get("confidence", "C1")
        if e["kind"] == "data" and k in tab_at:
            t = tab_at[k]
            if new:
                t["label"] = new
                t["note"] = t.get("note", "") + f" (named from its reading, {evidence}; was {old})"
            if note:
                t["note"] = f"{note} ({conf}, {evidence}); " + t.get("note", "")
            counts["renamed"] += bool(new)
            counts["data_notes"] += bool(note)
            continue
        ent = names.get(k)
        if new or e["kind"] == "data":
            changed_names.append(k)
        if new:
            if isinstance(ent, dict):
                ent["name"] = new
                ent["evidence"] = ent.get("evidence", "") + f"; renamed from {old} ({evidence})"
            else:
                ent = names[k] = {"name": new, "evidence": f"{evidence} (named from its reading; was {old})"}
            counts["renamed"] += 1
        if e["kind"] == "data":
            if note:
                if not isinstance(ent, dict):
                    ent = names[k] = {"name": old, "evidence": evidence}
                ent["note"] = f"{note} ({conf}, {evidence})"
                counts["data_notes"] += 1
            if isinstance(ent, dict):
                ent["data"] = True
        elif note:
            ann[k] = f"{note} ({conf}, {evidence})"
            counts["code_notes"] += 1
    write_entries(names_p, {k: names[k] for k in dict.fromkeys(changed_names) if k in names})
    for p, obj in ((ann_p, ann), (tab_p, tables)):  # both files are plain indent-2 dumps
        p.write_text(json.dumps(obj, indent=2) + "\n", encoding="utf-8", newline="\n")
    return counts


def write_entries(path: Path, changes: dict) -> None:
    """Rewrite only the changed top-level entries of a JSON object file, each on one line (config/names.json
    mixes multi-line and one-line entries; the others keep their text). New keys go at the end."""
    text = path.read_text(encoding="utf-8")
    dec = json.JSONDecoder()
    for k, v in changes.items():
        m = re.search(r'\n  "' + re.escape(k) + r'": ', text)
        line = json.dumps(v, ensure_ascii=False)
        if m:
            _, end = dec.raw_decode(text, m.end())
            text = text[:m.end()] + line + text[end:]
        else:
            close = text.rstrip().rfind("}")
            text = text[:close].rstrip() + f',\n  "{k}": {line}\n' + "}\n"
    json.loads(text)
    path.write_text(text, encoding="utf-8", newline="\n")


def main() -> int:
    ap = argparse.ArgumentParser()
    sub = ap.add_subparsers(dest="cmd", required=True)
    v = sub.add_parser("validate")
    v.add_argument("snapshot", type=Path)
    v.add_argument("drafts", nargs="+", type=Path)
    a = sub.add_parser("apply")
    a.add_argument("--evidence", required=True)
    a.add_argument("snapshot", type=Path)
    a.add_argument("drafts", nargs="+", type=Path)
    args = ap.parse_args()
    snap = json.loads(args.snapshot.read_text(encoding="utf-8"))
    entries = load(args.drafts)
    problems = validate(entries, snap)
    print("\n".join(problems) if problems else f"{len(entries)} entries valid")
    if args.cmd == "validate" or problems:
        return 1 if problems else 0
    print(apply(entries, snap, args.evidence))
    return 0


if __name__ == "__main__":
    sys.exit(main())
