#!/usr/bin/env python3
"""Clean build of the ROM into an empty output dir, then run the identity gate.

Usage: build.py [--out build/run1] 
Deletes the output dir first (must be under build/), so a stale ROM never counts.
"""
from __future__ import annotations
import argparse, hashlib, json, shutil, subprocess, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
RGBDS = ROOT / "tools/rgbds"
MANIFEST = ROOT / "config/targets/dwm2-cobi-us-rev0.json"
REF = ROOT / "local/roms/dwm2-cobi-us.gbc"


def run(cmd, log):
    p = subprocess.run([str(c) for c in cmd], cwd=ROOT, capture_output=True, text=True)
    log.append({"cmd": [str(c) for c in cmd], "exit": p.returncode,
                "stdout": p.stdout, "stderr": p.stderr})
    if p.returncode:
        print(p.stdout + p.stderr, file=sys.stderr)
        sys.exit(f"FAIL: {cmd[0]} exited {p.returncode}")


def extract_assets(dest: Path) -> int:
    """D-008: write the asset files listed in src/assets.txt (path, file offset, length) from the reference ROM,
    after checking the reference's SHA-256 against the target manifest, so src/ includes them by name."""
    listing = ROOT / "src/assets.txt"
    if not listing.exists():
        return 0
    want = json.loads(MANIFEST.read_text())["sha256"].lower()
    data = REF.read_bytes()
    if hashlib.sha256(data).hexdigest() != want:
        sys.exit("FAIL: the reference ROM does not match the target manifest; assets not extracted")
    n = 0
    for line in listing.read_text(encoding="utf-8").splitlines():
        if not line.strip() or line.startswith("#"):
            continue
        path, off, size = line.split("\t")
        o, s = int(off.lstrip("$"), 16), int(size.lstrip("$"), 16)
        target = dest / path
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_bytes(data[o:o + s])
        n += 1
    return n


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--out", default="build/run1")
    out = (ROOT / ap.parse_args().out).resolve()
    if (ROOT / "build").resolve() not in out.parents:
        sys.exit("output dir must be beneath build/")
    shutil.rmtree(out, ignore_errors=True)
    out.mkdir(parents=True)
    log: list = []
    obj, rom = out / "main.o", out / "dwm2.gbc"
    assets = extract_assets(out / "assets")
    run([RGBDS / "rgbasm.exe", "-I", "src", "-I", out / "assets", "-I", "local/roms", "-o", obj, "src/main.asm"], log)
    run([RGBDS / "rgblink.exe", "-m", out / "dwm2.map", "-n", out / "dwm2.sym", "-o", rom, obj], log)
    tools = {n: subprocess.run([str(RGBDS / f"{n}.exe"), "--version"], capture_output=True, text=True).stdout.strip()
             for n in ("rgbasm", "rgblink")}
    v = subprocess.run([sys.executable, "-I", ROOT / "tools/verify_rom.py", "--manifest", MANIFEST,
                        "--reference", REF, "--output", rom, "--report", out / "report.json"],
                       capture_output=True, text=True)
    rep = json.loads((out / "report.json").read_text())
    rep.update(toolchain=tools, commands=log,
               rgbds_zip_sha256=hashlib.sha256((RGBDS / "rgbds-win64.zip").read_bytes()).hexdigest(),
               source_tree_sha256=hashlib.sha256(b"".join(
                   p.read_bytes() for p in sorted((ROOT / "src").rglob("*.asm")) + [ROOT / "src/assets.txt"]
                   if p.exists())).hexdigest(),
               assets_extracted=assets)
    (out / "report.json").write_text(json.dumps(rep, indent=2))
    print("RESULT:", "PASS" if rep["pass"] else "FAIL", "| differing bytes:", rep.get("differing_bytes"))
    return v.returncode


if __name__ == "__main__":
    sys.exit(main())
