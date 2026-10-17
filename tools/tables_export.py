#!/usr/bin/env python3
"""M5 (E-0396): the species, skill and item tables as editable data, checked byte for byte and against their readers.

Layouts come from config/tables.json and src/records.inc; the bytes come from the reference ROM, so exports stay in
an ignored directory (local/ or build/), as the ROM does.

  export   writes species.json (one entry per monster id: its record index and named fields), skills.json and
           items.json (one entry per record, its bytes by field) under --out
  check    1. bounds: every SpeciesRecordPointers word lands on a record boundary inside SpeciesRecords;
           2. bytes: each table packed again from its export equals the ROM bytes;
           3. readers: LoadSpeciesRecord, LoadSkillRecord and LoadItemRecord, run on tools/sm83.py for every id,
              copy exactly the exported record (C2 on the project's emulator)
  --doc    writes docs/DATA_TABLES.md (layout, results of the check, fields with their notes)

Usage: tables_export.py export [--out local/tables] | check [--doc docs/DATA_TABLES.md]
"""
from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import mechanics  # noqa: E402

BANK = 0x4000


def layouts() -> dict[str, dict]:
    t = {x["label"]: x for x in json.loads((ROOT / "config/tables.json").read_text(encoding="utf-8"))["tables"]}
    out = {}
    for name in ("SpeciesRecords", "SpeciesRecordPointers", "SkillTable", "ItemTable"):
        x = t[name]
        sizes = [f.get("size", 2 if f["type"] == "ptr" else 1) for f in x["fields"]]
        out[name] = {"bank": int(x["bank"], 16), "addr": int(x["addr"], 16), "count": x["count"],
                     "stride": sum(sizes), "fields": [(f["name"], s) for f, s in zip(x["fields"], sizes)],
                     "note": x.get("note", "")}
    return out


def species_fields() -> list[tuple[str, int, int, str]]:
    """(constant, offset, size, comment) of the SPECIES_* fields of src/records.inc."""
    rows = [(m.group(1), int(m.group(2), 16), m.group(3).strip()) for m in re.finditer(
        r"^DEF (SPECIES_\w+) EQU \$([0-9A-Fa-f]+)\s*;\s*(.*)$", (ROOT / "src/records.inc").read_text(encoding="utf-8"),
        re.M)]
    rows.sort(key=lambda r: r[1])
    out = []
    for k, (name, off, note) in enumerate(rows):
        end = rows[k + 1][1] if k + 1 < len(rows) else 47
        out.append((name, off, end - off, note))
    return out


def raw(rom: bytes, bank: int, addr: int, n: int) -> bytes:
    o = bank * BANK + addr - (0 if bank == 0 else BANK)
    return rom[o:o + n]


def export_data(rom: bytes) -> dict[str, list]:
    L = layouts()
    sp, ptrs = L["SpeciesRecords"], L["SpeciesRecordPointers"]
    fields = species_fields()
    species = []
    for i in range(ptrs["count"]):
        p = int.from_bytes(raw(rom, ptrs["bank"], ptrs["addr"] + 2 * i, 2), "little")
        idx = (p - sp["addr"]) // sp["stride"]
        rec = raw(rom, sp["bank"], p, sp["stride"])
        species.append({"id": i, "record": idx, "fields": {
            name: (list(rec[off:off + size]) if size > 1 else rec[off]) for name, off, size, _n in fields}})
    tables = {"species": species}
    for key, name in (("skills", "SkillTable"), ("items", "ItemTable")):
        t = L[name]
        rows = []
        for i in range(t["count"]):
            rec = raw(rom, t["bank"], t["addr"] + i * t["stride"], t["stride"])
            k, vals = 0, []
            for _fname, size in t["fields"]:
                vals.append(list(rec[k:k + size]) if size > 1 else rec[k])
                k += size
            rows.append({"id": i, "fields": vals})
        tables[key] = rows
    return tables


def pack(tables: dict[str, list]) -> dict[str, bytes]:
    """The tables' bytes from an export (species: each record once, in record order)."""
    L = layouts()
    fields = species_fields()
    recs: dict[int, bytes] = {}
    for e in tables["species"]:
        b = bytearray(L["SpeciesRecords"]["stride"])
        for name, off, size, _n in fields:
            v = e["fields"][name]
            b[off:off + size] = bytes(v if isinstance(v, list) else [v])
        if e["record"] in recs and recs[e["record"]] != bytes(b):
            raise ValueError(f"ids sharing record {e['record']} disagree")
        recs[e["record"]] = bytes(b)
    out = {"SpeciesRecords": b"".join(recs[k] for k in sorted(recs))}
    for key, name in (("skills", "SkillTable"), ("items", "ItemTable")):
        out[name] = b"".join(bytes(sum(([v] if isinstance(v, int) else v for v in e["fields"]), [])) for e in tables[key])
    return out


def check(rom: bytes) -> dict:
    L = layouts()
    R, labels = mechanics.ram(), mechanics.rom_labels()
    sp, ptrs = L["SpeciesRecords"], L["SpeciesRecordPointers"]
    res: dict = {}
    end = sp["addr"] + sp["count"] * sp["stride"]
    targets = [int.from_bytes(raw(rom, ptrs["bank"], ptrs["addr"] + 2 * i, 2), "little") for i in range(ptrs["count"])]
    res["pointers"] = {"ids": len(targets), "records": len(set(targets)),
                       "outside_or_misaligned": [i for i, p in enumerate(targets)
                                                 if not (sp["addr"] <= p < end and (p - sp["addr"]) % sp["stride"] == 0)],
                       "unreferenced_records": sorted(set(range(sp["count"])) -
                                                      {(p - sp["addr"]) // sp["stride"] for p in targets})}
    tables = export_data(rom)
    packed = pack(tables)
    res["round_trip"] = {name: packed[name] == raw(rom, L[name]["bank"], L[name]["addr"], L[name]["count"] * L[name]["stride"])
                         for name in ("SpeciesRecords", "SkillTable", "ItemTable")}
    readers = {}
    b, a = labels["LoadSpeciesRecord"]
    bad = []
    for e in tables["species"]:
        gb = mechanics.call(rom, b, a, {R["wSpeciesIdLo"]: e["id"] & 0xFF, R["wSpeciesIdHi"]: e["id"] >> 8})
        got = bytes(gb.rb(R["wSpeciesRecord"] + k) for k in range(sp["stride"]))
        if got != raw(rom, sp["bank"], targets[e["id"]], sp["stride"]):
            bad.append(e["id"])
    readers["LoadSpeciesRecord"] = {"ids": len(tables["species"]), "differ": bad}
    for fn, key, name, setup, dest in (
            ("LoadSkillRecord", "skills", "SkillTable", lambda i: {R["wRecordBuffer"]: i & 0xFF, R["wRecordBuffer"] + 1: i >> 8},
             R["wRecordBufferData"]),
            ("LoadItemRecord", "items", "ItemTable", lambda i: {R["wItemId"]: i}, R["wItemRecord"])):
        b, a = labels[fn]
        t, bad = L[name], []
        for e in tables[key]:
            gb = mechanics.call(rom, b, a, setup(e["id"]))
            got = bytes(gb.rb(dest + k) for k in range(t["stride"]))
            if got != raw(rom, t["bank"], t["addr"] + e["id"] * t["stride"], t["stride"]):
                bad.append(e["id"])
        readers[fn] = {"ids": len(tables[key]), "differ": bad}
    res["readers"] = readers
    res["ok"] = (not res["pointers"]["outside_or_misaligned"] and all(res["round_trip"].values())
                 and not any(v["differ"] for v in readers.values()))
    return res


def doc_text(res: dict) -> str:
    L = layouts()
    p = res["pointers"]
    out = ["# Data tables", "",
           "Stage M5 of the moddable-decomp goal ([roadmap](ROADMAP.md)), evidence E-0396 in the [evidence log](EVIDENCE_LOG.md).",
           "Generated by `tools/tables_export.py check --doc docs/DATA_TABLES.md`; do not edit by hand. The fields' notes",
           "come from src/records.inc and config/tables.json, where their evidence is.", "",
           "`python -I tools/tables_export.py export --out local/tables` writes the three tables as JSON from the",
           "reference ROM (into an ignored directory); the check packs them again and runs the game's readers.", "",
           "## Checks", ""]
    out.append(f"- SpeciesRecordPointers: {p['ids']} monster ids point at {p['records']} distinct records; "
               f"{len(p['outside_or_misaligned'])} land outside SpeciesRecords or between records; "
               f"{len(p['unreferenced_records'])} records are not pointed at"
               + (f" ({', '.join(map(str, p['unreferenced_records'][:20]))})" if p['unreferenced_records'] else "") + ".")
    for name, ok in res["round_trip"].items():
        out.append(f"- {name}: packed again from the export, {'equal to' if ok else 'DIFFERENT from'} the ROM's "
                   f"{L[name]['count'] * L[name]['stride']} bytes.")
    for fn, v in res["readers"].items():
        out.append(f"- {fn} on tools/sm83.py, for every one of {v['ids']} ids: "
                   + ("copies exactly the exported record." if not v["differ"] else f"differs for ids {v['differ'][:20]}."))
    out += ["", "## Layouts", ""]
    for name in ("SpeciesRecords", "SkillTable", "ItemTable"):
        t = L[name]
        out += [f"### {name}", "",
                f"Bank ${t['bank']:02X}, ${t['addr']:04X}, {t['count']} records of {t['stride']} bytes. {t['note']}", "",
                "| Offset | Bytes | Field |", "| --- | --- | --- |"]
        if name == "SpeciesRecords":
            for const, off, size, note in species_fields():
                out.append(f"| ${off:02X} | {size} | {const}: {note.replace('|', '/')} |")
        else:
            k = 0
            for fname, size in t["fields"]:
                out.append(f"| ${k:02X} | {size} | {fname.replace('|', '/')} |")
                k += size
        out.append("")
    return "\n".join(out)


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    sub = ap.add_subparsers(dest="cmd", required=True)
    e = sub.add_parser("export")
    e.add_argument("--out", type=Path, default=ROOT / "local/tables")
    c = sub.add_parser("check")
    c.add_argument("--doc", type=Path)
    args = ap.parse_args(argv)
    rom = mechanics.ROM_PATH.read_bytes()
    if args.cmd == "export":
        out = args.out.resolve()
        if not any(p in out.parents for p in ((ROOT / "local").resolve(), (ROOT / "build").resolve())):
            sys.exit("exported tables come from the game: give a path under local/ or build/")
        out.mkdir(parents=True, exist_ok=True)
        for key, rows in export_data(rom).items():
            (out / f"{key}.json").write_text(json.dumps(rows, indent=0), encoding="utf-8", newline="\n")
        print(f"wrote species.json, skills.json and items.json under {out}")
        return 0
    res = check(rom)
    print(json.dumps({k: v for k, v in res.items() if k != "pointers"}, indent=1))
    print(f"pointers: {res['pointers']['ids']} ids, {res['pointers']['records']} records, "
          f"{len(res['pointers']['outside_or_misaligned'])} bad, {len(res['pointers']['unreferenced_records'])} unreferenced")
    if args.doc:
        args.doc.write_text(doc_text(res), encoding="utf-8", newline="\n")
    return 0 if res["ok"] else 1


if __name__ == "__main__":
    sys.exit(main())
