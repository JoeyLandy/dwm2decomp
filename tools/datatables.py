#!/usr/bin/env python3
"""The game's data tables as editable files, exported from src/ and imported back into it (H2).

src/ is the source (D-015): the tables are `db`/`dw`/`dfar` lines there. This tool reads them as value tokens
(MONSTER_SWORDGON, $2d, 12, a label, ...) and maps the tokens onto each table's fields by byte width, using the
layouts of config/tables.json. `export` writes one JSON file per table group, and a CSV for each fixed-size
table. `import` puts edited values back into src/: only the tokens of changed fields are rewritten, in place, so
comments and layout stay; a list (breeding rules, shop items) may change length. The build then assembles the
edited source; tools/build.py's identity gate tells whether the result is still the original ROM.

  export [--out DIR] [--src DIR]          write DIR/<group>.json (and DIR/<table>.csv); default build/data
  import FILE... [--src DIR]              apply edited JSON or CSV files to src/ (or DIR)
  check [--src DIR]                       export, import unchanged into a scratch copy, compare: must be identical

Groups and tables (fixed-size records unless a list):
  species      SpeciesRecords (324 x 47 bytes)        monsters   MonsterTable, MonsterTableA2 (26 bytes)
  skills       SkillTable (17 bytes)                  items      ItemTable (13 bytes)
  encounters   EncounterGroup_* (one entry each), EncounterGrid_* (one group label per screen),
               ScriptedEncounterTable, ArenaEncounterList0-3
  breeding     the seven tables ComputeBreedingChild reads (pointer tables and their lists)
  shops        ShopItemListTable (lists of item numbers), ShopPercentTable
  ai           AIPersonalityWeightTable (212 rows of 27 signed words)

A token's meaning is the field's: a species constant, a skill constant, a number. The game reads the bytes; what
each field does is in its note in config/tables.json and src/ (most are C1).
"""
from __future__ import annotations

import argparse
import csv
import json
import re
import shutil
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import source_tree  # noqa: E402

WIDTH = {"db": 1, "dw": 2, "dfar": 3}
DATA = re.compile(r"^(\s+)(db|dw|dfar) (.*?)(\s*;.*)?$")
LABEL = re.compile(r"^([A-Za-z_]\w*)::")

# Short field names for the main tables, in layout order (byte sizes come from config/tables.json).
NAMES = {
    "SpeciesRecords": ["family", "sex_ratio", "cannot_trip", "metal_body", "join_class", "byte5", "level_cap",
                       "exp_curve", "natural_skills", "field_ability", "growth", "resistances", "base_exp"],
    "MonsterTable": ["species", "skill1", "skill2", "skill3", "skill4", "exp", "join_class", "level", "hp", "mp",
                     "atk", "def", "agl", "int", "byte22", "byte23", "byte24", "byte25"],
    "SkillTable": ["viewer_order", "family", "type", "usable_tactic", "target", "num5", "num6", "num7", "num8",
                   "word9", "word11", "word13", "word15"],
    "ItemTable": ["byte0", "amount", "byte3", "byte4", "byte5", "byte6", "byte7", "byte8", "byte9", "byte10",
                  "byte11", "byte12"],
    "ScriptedEncounterTable": ["kind_and_unread", "monsters"],
    "ShopPercentTable": ["percent"],
    "AIPersonalityWeightTable": ["weights"],
}
NAMES["MonsterTableA2"] = NAMES["MonsterTable"]
FIXED = {
    "species": ["SpeciesRecords"],
    "monsters": ["MonsterTable", "MonsterTableA2"],
    "skills": ["SkillTable"],
    "items": ["ItemTable"],
    "encounters": ["ScriptedEncounterTable", "EncounterGroup_*", "EncounterGrid_*", "ArenaEncounterList*"],
    "breeding": [],
    "shops": ["ShopPercentTable"],
    "ai": ["AIPersonalityWeightTable"],
}
LISTS = {  # pointer table -> group
    "BreedSpeciesRuleTable": "breeding", "BreedSpeciesResultTable": "breeding", "BreedFamilyRuleTable": "breeding",
    "BreedFamilyResultTable": "breeding", "FamilyBreedRuleTable": "breeding", "FamilyBreedResultTable": "breeding",
    "FamilyPairResultTable": "breeding", "ShopItemListTable": "shops",
}


# ---- reading src/ ------------------------------------------------------------------------------------------------

def split_operands(s: str) -> list[str]:
    out, depth, cur = [], 0, ""
    for ch in s:
        if ch == "(":
            depth += 1
        elif ch == ")":
            depth -= 1
        if ch == "," and depth == 0:
            out.append(cur.strip())
            cur = ""
        else:
            cur += ch
    if cur.strip():
        out.append(cur.strip())
    return out


class Source:
    """The bank files of a src/ tree, with each global label's file and line."""

    def __init__(self, src: Path):
        self.src = src
        self.files = {f: f.read_text(encoding="utf-8").split("\n") for f in source_tree.bank_files(src)}
        self.where: dict[str, tuple[Path, int]] = {}
        for f, lines in self.files.items():
            for i, ln in enumerate(lines):
                if m := LABEL.match(ln):
                    self.where[m.group(1)] = (f, i)

    def tokens_from(self, label: str, nbytes: int | None = None):
        """Data tokens from the label on, as (file, line, index in line, token, width): up to nbytes bytes, or up
        to the next global label when nbytes is None."""
        f, i = self.where[label]
        lines, out, got = self.files[f], [], 0
        for k in range(i + 1, len(lines)):
            ln = lines[k]
            if nbytes is None and LABEL.match(ln):
                break
            m = DATA.match(ln)
            if not m:
                if ln.strip().startswith(("INCBIN", "ds ")) or (ln.startswith("    ") and ln.strip()
                                                                 and not ln.strip().startswith(("ASSERT", ";"))):
                    if nbytes is not None and got < nbytes:
                        raise ValueError(f"{label}: {f.name}:{k + 1} is not a data line: {ln.strip()}")
                    break
                continue
            for j, tok in enumerate(split_operands(m.group(3))):
                if tok.startswith('"'):
                    raise ValueError(f"{label}: {f.name}:{k + 1} holds a string")
                w = WIDTH[m.group(2)]
                out.append((f, k, j, tok, w))
                got += w
                if nbytes is not None and got >= nbytes:
                    if got != nbytes:
                        raise ValueError(f"{label}: a token crosses the end of the table at {f.name}:{k + 1}")
                    return out
        if nbytes is not None and got < nbytes:
            raise ValueError(f"{label}: only {got} of {nbytes} bytes found")
        return out


def layouts() -> dict[str, dict]:
    return {x["label"]: x for x in json.loads((ROOT / "config/tables.json").read_text(encoding="utf-8"))["tables"]}


def field_sizes(layout: dict) -> list[int]:
    return [f.get("size", 2 if f["type"] == "ptr" else 1) for f in layout["fields"]]


def fixed_tables(group: str, lay: dict, src: Source) -> list[str]:
    out = []
    for pat in FIXED[group]:
        if pat.endswith("*"):
            out += sorted((l for l in lay if l.startswith(pat[:-1]) and l in src.where and "lists" not in lay[l]),
                          key=lambda l: (len(l), l))
        elif pat in src.where:
            out.append(pat)
    return out


def read_fixed(label: str, lay: dict, src: Source) -> dict:
    """{label, records: [{id, label, fields: {name: [tokens]}}]} for a fixed-size table."""
    x = lay[label]
    sizes = field_sizes(x)
    names = NAMES.get(label) or [f"f{i}" for i in range(len(sizes))]
    if len(names) != len(sizes):
        names = [f"f{i}" for i in range(len(sizes))]
    stride = sum(sizes)
    toks = src.tokens_from(label, stride * x["count"])
    f0 = toks[0][0]
    rec_labels = {}
    for k, ln in enumerate(src.files[f0]):
        if m := LABEL.match(ln):
            rec_labels[k] = m.group(1)
    records, p = [], 0
    for r in range(x["count"]):
        rec, lab = {}, None
        for name, size in zip(names, sizes):
            got, vals = 0, []
            while got < size:
                f, k, j, tok, w = toks[p]
                if got + w > size:
                    raise ValueError(f"{label} record {r}: field {name} is split inside the token {tok}")
                if lab is None and f == f0:
                    lab = next((rec_labels[q] for q in range(k, max(-1, k - 4), -1) if q in rec_labels), None)
                vals.append(tok)
                got += w
                p += 1
            rec[name] = vals
        records.append({"id": x.get("id_base", 0) + r, "label": lab if lab != label else None, "fields": rec})
    return {"label": label, "records": records}


def read_lists(table: str, lay: dict, src: Source) -> dict:
    """{label, pointers: [list label per id], lists: {label: [tokens]}} for a pointer table and its lists."""
    x = lay[table]
    ptrs = [t[3] for t in src.tokens_from(table, 2 * x["count"])]
    lists = {lab: [t[3] for t in src.tokens_from(lab)] for lab in dict.fromkeys(ptrs)}
    return {"label": table, "pointers": ptrs, "lists": lists}


def export(src_dir: Path) -> dict[str, dict]:
    lay, src = layouts(), Source(src_dir)
    out: dict[str, dict] = {g: {"group": g, "tables": []} for g in FIXED}
    for g in FIXED:
        for label in fixed_tables(g, lay, src):
            out[g]["tables"].append(read_fixed(label, lay, src))
    for table, g in LISTS.items():
        out[g]["tables"].append(read_lists(table, lay, src))
    return out


def write_export(data: dict[str, dict], dest: Path) -> list[Path]:
    dest.mkdir(parents=True, exist_ok=True)
    written = []
    for g, d in data.items():
        p = dest / f"{g}.json"
        p.write_text(json.dumps(d, indent=1) + "\n", encoding="utf-8", newline="\n")
        written.append(p)
        for t in d["tables"]:
            if "records" in t and len(t["records"]) > 1:
                p = dest / f"{t['label']}.csv"
                names = list(t["records"][0]["fields"])
                with p.open("w", encoding="utf-8", newline="") as fh:
                    w = csv.writer(fh, lineterminator="\n")
                    w.writerow(["id", "label"] + names)
                    for r in t["records"]:
                        w.writerow([r["id"], r["label"] or ""] + [" ".join(r["fields"][n]) for n in names])
                written.append(p)
    return written


# ---- writing src/ ------------------------------------------------------------------------------------------------

def set_tokens(src: Source, changes: dict[tuple[Path, int, int], str]) -> int:
    """Rewrite tokens in place: {(file, line, index): new token}. Returns the number of lines changed."""
    by_line: dict[tuple[Path, int], dict[int, str]] = {}
    for (f, k, j), tok in changes.items():
        by_line.setdefault((f, k), {})[j] = tok
    for (f, k), new in by_line.items():
        m = DATA.match(src.files[f][k])
        toks = split_operands(m.group(3))
        for j, tok in new.items():
            toks[j] = tok
        src.files[f][k] = f"{m.group(1)}{m.group(2)} {', '.join(toks)}{m.group(4) or ''}"
    return len(by_line)


FILL = re.compile(r"^(\s*)(ds|DS) (\$[0-9A-Fa-f]+|\d+)(\s*,\s*[^;]*)?(\s*;.*)?$")


def take_from_fill(lines: list[str], delta: int, name: str) -> None:
    """Shrink (or grow, for a negative delta) the last `ds` fill of a bank file by delta bytes, so the bank keeps its
    size when a list in it changes length (as tools/assets.py does for an edited asset)."""
    if not delta:
        return
    k = max((i for i, ln in enumerate(lines) if FILL.match(ln)), default=None)
    if k is None:
        raise ValueError(f"{name}: no trailing fill to take {delta} bytes from; move a section to another bank")
    m = FILL.match(lines[k])
    free = int(m.group(3)[1:], 16) if m.group(3).startswith("$") else int(m.group(3))
    if free < delta:
        raise ValueError(f"{name}: needs {delta - free} more bytes than its {free}-byte fill; move a section to "
                         f"another bank first (tools/move_section.py)")
    lines[k] = f"{m.group(1)}{m.group(2)} ${free - delta:x}{m.group(4) or ''}{m.group(5) or ''}"


def replace_list(src: Source, label: str, tokens: list[str], directive: str, one_line: bool) -> int:
    """Replace the data lines of a list (from its label to the next label) with the given tokens. Returns the
    change in bytes."""
    f, i = src.where[label]
    lines = src.files[f]
    data = []
    for k in range(i + 1, len(lines)):
        if LABEL.match(lines[k]):
            break
        if DATA.match(lines[k]):
            data.append(k)
    if not data:
        raise ValueError(f"{label}: no data lines")
    if data != list(range(data[0], data[-1] + 1)):
        raise ValueError(f"{label}: its data lines are not contiguous; edit it in src/ directly")
    old = sum(len(split_operands(DATA.match(lines[k]).group(3))) for k in data)
    indent = DATA.match(lines[data[0]]).group(1)
    if one_line:
        new = [f"{indent}{directive} {', '.join(tokens)}"]
    else:
        new = [f"{indent}{directive} {t} ; id {n}" for n, t in enumerate(tokens)]
    lines[data[0]:data[-1] + 1] = new
    src.where = {k2: (f2, i2 + (len(new) - len(data) if f2 == f and i2 > data[-1] else 0))
                 for k2, (f2, i2) in src.where.items()}
    return (len(tokens) - old) * WIDTH[directive]


def apply(src_dir: Path, edits: list[dict]) -> dict[str, int]:
    """Apply exported-format edits to the tree; only differences are written. Returns counts."""
    lay = layouts()
    src = Source(src_dir)
    changes: dict[tuple[Path, int, int], str] = {}
    grew: dict[Path, int] = {}  # bytes each bank file's lists grew by, taken from its trailing fill
    n_lists = flushed = 0
    for d in edits:
        for t in d.get("tables", []):
            label = t["label"]
            if "records" in t:
                cur = read_fixed(label, lay, src)
                x = lay[label]
                stride = sum(field_sizes(x))
                toks = src.tokens_from(label, stride * x["count"])
                pos = {}
                p = 0
                for r in cur["records"]:
                    for name, vals in r["fields"].items():
                        pos[(r["id"], name)] = list(range(p, p + len(vals)))
                        p += len(vals)
                for r in t["records"]:
                    for name, vals in r["fields"].items():
                        idx = pos.get((r["id"], name))
                        if idx is None:
                            raise ValueError(f"{label}: no field {name} in record {r['id']}")
                        if len(vals) != len(idx):
                            raise ValueError(f"{label} record {r['id']} {name}: {len(vals)} values for "
                                             f"{len(idx)} tokens; keep the source's token count")
                        for q, v in zip(idx, vals):
                            f, k, j, tok, w = toks[q]
                            if str(v) != tok:
                                changes[(f, k, j)] = str(v)
            else:
                cur = read_lists(label, lay, src)
                spec = lay[label]["lists"]
                directive = "db" if spec.get("size") == 1 or spec["fields"][0]["type"] == "db" else "dw"
                ptoks = src.tokens_from(label, 2 * lay[label]["count"])
                for q, (old, new) in enumerate(zip(cur["pointers"], t["pointers"])):
                    if old != new:
                        if new not in src.where and new not in t["lists"]:
                            raise ValueError(f"{label} entry {q}: {new} is not a list")
                        f, k, j, tok, w = ptoks[q]
                        changes[(f, k, j)] = new
                for lab, vals in t["lists"].items():
                    if lab not in src.where:
                        raise ValueError(f"{label}: new list {lab}: add its label in src/ first")
                    if [str(v) for v in vals] != cur["lists"].get(lab, [t2[3] for t2 in src.tokens_from(lab)]):
                        flushed += set_tokens(src, {k2: v2 for k2, v2 in changes.items() if k2[0] == src.where[lab][0]})
                        changes = {k2: v2 for k2, v2 in changes.items() if k2[0] != src.where[lab][0]}
                        f_lab = src.where[lab][0]
                        grew[f_lab] = grew.get(f_lab, 0) + replace_list(
                            src, lab, [str(v) for v in vals], directive, spec.get("one_line", False))
                        n_lists += 1
    n_lines = flushed + set_tokens(src, changes)
    for f, delta in grew.items():
        take_from_fill(src.files[f], delta, f.name)
    for f, lines in src.files.items():
        text = "\n".join(lines)
        if f.read_text(encoding="utf-8") != text:
            f.write_text(text, encoding="utf-8", newline="\n")
    return {"lines": n_lines, "lists": n_lists}


def read_edits(paths: list[Path]) -> list[dict]:
    """JSON files as exported, or CSV files (one fixed table each, named after it)."""
    out = []
    for p in paths:
        if p.suffix == ".json":
            out.append(json.loads(p.read_text(encoding="utf-8")))
            continue
        with p.open(encoding="utf-8", newline="") as fh:
            rows = list(csv.DictReader(fh))
        recs = [{"id": int(r["id"]), "label": r["label"] or None,
                 "fields": {k: v.split() for k, v in r.items() if k not in ("id", "label")}} for r in rows]
        out.append({"tables": [{"label": p.stem, "records": recs}]})
    return out


def check(src_dir: Path) -> list[str]:
    """Export, then import the unchanged export into a scratch copy: every file must stay identical."""
    data = export(src_dir)
    problems = []
    with tempfile.TemporaryDirectory() as t:
        copy = Path(t) / "src"
        shutil.copytree(src_dir, copy)
        res = apply(copy, list(data.values()))
        if res["lines"] or res["lists"]:
            problems.append(f"an unchanged import rewrote {res['lines']} lines and {res['lists']} lists")
        for f in source_tree.bank_files(src_dir):
            if (copy / f.relative_to(src_dir)).read_bytes() != f.read_bytes():
                problems.append(f"{f.relative_to(src_dir).as_posix()} changed")
    return problems


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("command", choices=["export", "import", "check"])
    ap.add_argument("files", nargs="*", type=Path)
    ap.add_argument("--out", type=Path, default=ROOT / "build/data")
    ap.add_argument("--src", type=Path, default=ROOT / "src")
    a = ap.parse_args(argv)
    if a.command == "export":
        data = export(a.src)
        for p in write_export(data, a.out):
            print(p)
        n = sum(len(t.get("records", t.get("pointers", []))) for d in data.values() for t in d["tables"])
        print(f"{sum(len(d['tables']) for d in data.values())} tables, {n} records or entries")
        return 0
    if a.command == "import":
        if not a.files:
            ap.error("import needs edited files")
        res = apply(a.src, read_edits(a.files))
        print(f"{res['lines']} lines and {res['lists']} lists rewritten in {a.src}")
        return 0
    problems = check(a.src)
    print("round trip: " + ("identical" if not problems else "; ".join(problems)))
    return 1 if problems else 0


if __name__ == "__main__":
    sys.exit(main())
