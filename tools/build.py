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
    run([RGBDS / "rgbasm.exe", "-I", "src", "-I", "local/roms", "-o", obj, "src/main.asm"], log)
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
                   p.read_bytes() for p in sorted((ROOT / "src").rglob("*.asm")))).hexdigest())
    (out / "report.json").write_text(json.dumps(rep, indent=2))
    print("RESULT:", "PASS" if rep["pass"] else "FAIL", "| differing bytes:", rep.get("differing_bytes"))
    return v.returncode


if __name__ == "__main__":
    sys.exit(main())
