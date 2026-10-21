#!/usr/bin/env python3
"""Build a mod from a folder of edits: a copy of src/ edited, built, smoke-tested and turned into a patch (H6).

A mod folder holds any of these (see mods/example/):
  mod.json        {"name": ..., "version": ..., "author": ..., "description": ...}; optionally "spill":
                  [{"bank": "28", "count": 9, "to": "9A"}, {"bank": "2F", "categories_from": 1, "to": "9D"},
                  {"bank": "0D", "strings": 37, "to": "9E"}] to make room in full text banks first
                  (tools/text_spill.py spill, spill-categories, spill-strings; "to" is optional for "count");
                  optionally "scripts": {"patch": true} for an interpreter that reads scripts from any bank
                  (script_jump_far), or {"move": "all" or ["Script_..."], "to": "9F"} to move bank $10's scripts
                  (tools/script_bank.py)
  data/           edited tables, as tools/datatables.py exports them (JSON or CSV)
  text/           edited text, as tools/text.py exports it (JSON; only the entries you changed are needed)
  charmap.inc     extra CHARMAP lines for new letters, added to src/charmap.inc
  font.png        the font, as tools/text.py font-export writes it
  src/            files that replace src/'s own (relative paths: src/engine/bank0a_encounters.asm), for code edits
Code changes can also be made in a fork's src/ directly; then build that tree with `--base DIR`.

    python -I tools/make_mod.py MODDIR [--base src] [--out build/mods/NAME] [--frames 6000] [--no-check]

The output folder gets NAME.bps (the patch to share), NAME.gbc (the modded ROM, not to share) and report.json
(what the smoke test found). Exit 0 when the mod builds and the smoke test finds no crash, data run, lost progress
or stall.
"""
from __future__ import annotations

import argparse
import json
import shutil
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import datatables  # noqa: E402
import text as text_tool  # noqa: E402
import script_bank  # noqa: E402
import text_spill  # noqa: E402


def apply_mod(mod: Path, src: Path) -> list[str]:
    """Apply a mod folder's edits to the tree src (a copy). Returns what was done."""
    done = []
    meta = json.loads((mod / "mod.json").read_text(encoding="utf-8")) if (mod / "mod.json").exists() else {}
    for sp in meta.get("spill", []):  # before the text, which then has room
        if "categories_from" in sp:
            res = text_spill.spill_categories(src, str(sp["bank"]), int(sp["categories_from"]), sp["to"])
            done.append(f"spill: categories {res['categories']} of bank ${res['bank']} to bank ${res['to']}")
            continue
        if "strings" in sp:
            res = text_spill.spill_strings(src, str(sp["bank"]), int(sp["strings"]), sp["to"])
            done.append(f"spill: strings {res['ids']} of bank ${res['bank']} to bank ${res['to']}")
            continue
        res = text_spill.spill(src, str(sp["bank"]), int(sp["count"]), sp.get("to"))
        done.append(f"spill: {res['moved']} messages of bank ${res['bank']} to bank ${res['overflow_bank']}, "
                    f"split {res['split']}")
    replaced = mod / "src"
    if replaced.is_dir():
        for f in sorted(p for p in replaced.rglob("*") if p.is_file()):
            dest = src / f.relative_to(replaced)
            dest.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(f, dest)
            done.append(f"replaced src/{f.relative_to(replaced).as_posix()}")
    sc = meta.get("scripts")
    if sc:
        if "move" in sc:
            res = script_bank.move(src, None if sc["move"] == "all" else list(sc["move"]), sc["to"])
            done.append(f"scripts: {res['runs']} runs of bank $10 to bank ${res['to']} ({res['stubs']} stubs; bank $10 "
                        f"gains {res['bank_10_gain']} bytes)")
        elif sc.get("patch"):
            script_bank.patch(src)
            done.append("scripts: interpreter patched (script_jump_far)")
    if (mod / "charmap.inc").exists():
        inc = src / "charmap.inc"
        inc.write_text(inc.read_text(encoding="utf-8").rstrip("\n") + "\n" + (mod / "charmap.inc").read_text(encoding="utf-8"),
                       encoding="utf-8", newline="\n")
        done.append("charmap lines added")
    text_tool.load_charmap(src)
    if (mod / "font.png").exists():
        done.append(f"font: {text_tool.font_import(src, mod / 'font.png')} glyphs changed")
    data_files = sorted(p for p in (mod / "data").glob("*") if p.suffix in (".json", ".csv")) if (mod / "data").is_dir() else []
    if data_files:
        res = datatables.apply(src, datatables.read_edits(data_files))
        done.append(f"data: {res['lines']} lines and {res['lists']} lists")
    for f in sorted((mod / "text").glob("*.json")) if (mod / "text").is_dir() else []:
        res = text_tool.apply(src, json.loads(f.read_text(encoding="utf-8")))
        done.append(f"text {f.name}: {res['entries']} entries, {res['bytes']:+d} bytes")
    return done


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("mod", type=Path)
    ap.add_argument("--base", type=Path, default=ROOT / "src")
    ap.add_argument("--out", type=Path)
    ap.add_argument("--frames", type=int, default=6000)
    ap.add_argument("--no-check", action="store_true")
    a = ap.parse_args(argv)
    meta = json.loads((a.mod / "mod.json").read_text(encoding="utf-8")) if (a.mod / "mod.json").exists() else {}
    name = meta.get("name", a.mod.name).replace(" ", "_")
    out = (a.out or ROOT / "build/mods" / name).resolve()
    if (ROOT / "build").resolve() not in out.parents:
        sys.exit("the output folder must be under build/")
    shutil.rmtree(out, ignore_errors=True)
    src = out / "src"
    shutil.copytree(a.base, src)
    try:
        done = apply_mod(a.mod, src)
    except ValueError as e:
        print(f"the mod's edits do not apply: {e}")
        return 1
    for d in done:
        print(d)
    rel = (out / "build").relative_to(ROOT).as_posix()
    p = subprocess.run([sys.executable, "-I", str(ROOT / "tools/build.py"), "--out", rel, "--src", str(src)],
                       cwd=ROOT, capture_output=True, text=True)
    print(p.stdout.strip().splitlines()[-1] if p.stdout.strip() else "")
    if p.returncode:
        print(p.stderr[-2000:])
        print("the mod does not build")
        return 1
    import patch
    rom = (out / "build/dwm2.gbc").read_bytes()
    ref = (ROOT / "local/roms/dwm2-cobi-us.gbc").read_bytes()
    label = " ".join(x for x in (meta.get("name"), meta.get("version")) if x)
    (out / f"{name}.bps").write_bytes(patch.make(ref, rom, label))
    shutil.copyfile(out / "build/dwm2.gbc", out / f"{name}.gbc")
    report = {"name": name, "done": done, "patch_bytes": (out / f"{name}.bps").stat().st_size}
    status = 0
    if not a.no_check:
        import mod_check
        import shift_test
        sym = shift_test.read_sym(out / "build/dwm2.sym")
        res = mod_check.check(rom, sym, a.frames, data=mod_check.data_map(src, sym, len(rom)), ref=ref)
        res.pop("identical", None)
        report["smoke_test"] = res
        status = 1 if res["crash"] or res["ran_data"] or res["progress"] or res["stall"] is not None else 0
        if status:
            print("smoke test: problems found, see report.json")
        elif res["first_difference"] is None:
            print(f"smoke test: runs, with the original's screens for all {res['frames']} scripted frames")
        else:
            print(f"smoke test: runs; screens first differ at frame {res['first_difference']}")
    (out / "report.json").write_text(json.dumps(report, indent=1), encoding="utf-8")
    print(f"{out / (name + '.bps')}")
    return status


if __name__ == "__main__":
    sys.exit(main())
