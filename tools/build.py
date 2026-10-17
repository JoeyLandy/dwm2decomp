#!/usr/bin/env python3
"""Clean build of the ROM into an empty output dir, then run the identity gate.

Usage: build.py [--out build/run1] [--mod DIR] [--src DIR]
Deletes the output dir first (must be under build/), so a stale ROM never counts.
--src builds another source tree (a copy of src/ with edits, H2): its result is reported as a modded build unless
it is the reference byte for byte.
"""
from __future__ import annotations
import argparse, hashlib, json, shutil, subprocess, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
RGBDS = ROOT / "tools/rgbds"
sys.path.insert(0, str(ROOT / "tools"))  # python -I leaves the script's directory off the path
import source_tree  # noqa: E402
MANIFEST = ROOT / "config/targets/dwm2-cobi-us-rev0.json"
REF = ROOT / "local/roms/dwm2-cobi-us.gbc"


def run(cmd, log):
    p = subprocess.run([str(c) for c in cmd], cwd=ROOT, capture_output=True, text=True)
    log.append({"cmd": [str(c) for c in cmd], "exit": p.returncode,
                "stdout": p.stdout, "stderr": p.stderr})
    if p.returncode:
        print(p.stdout + p.stderr, file=sys.stderr)
        sys.exit(f"FAIL: {cmd[0]} exited {p.returncode}")


DELTAS: dict[str, int] = {}  # edited assets whose files changed size (E-0394)


def extract_assets(dest: Path, mod: Path | None = None) -> int:
    """D-008: write the asset files listed in src/assets.txt, after checking the reference's SHA-256 against the
    target manifest, so src/ includes them by name. E-0394: each LZSS stream is decoded from the reference and
    encoded again with tools/lzss_encode.py (the result is checked against the reference's bytes); with `mod`,
    edited files (.png tiles or .bin data) replace the decoded data (tools/assets.py)."""
    listing = ROOT / "src/assets.txt"
    if not listing.exists():
        return 0
    want = json.loads(MANIFEST.read_text())["sha256"].lower()
    data = REF.read_bytes()
    if hashlib.sha256(data).hexdigest() != want:
        sys.exit("FAIL: the reference ROM does not match the target manifest; assets not extracted")
    sys.path.insert(0, str(ROOT / "tools"))  # python -I leaves the script's directory off the path
    import assets
    counts = assets.build_assets(dest, mod, data)
    DELTAS.clear()
    DELTAS.update(counts["deltas"])
    if mod is not None:
        print(f"assets: {counts['png']} from PNG and {counts['bin']} from .bin changed; {counts['unchanged']} edited "
              f"files hold the original data; {counts['rom'] - counts['unchanged']} from the reference")
    return counts["rom"] + counts["png"] + counts["bin"]


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--out", default="build/run1")
    ap.add_argument("--mod", type=Path, help="edited assets (tools/assets.py): a modded ROM, not the matching target")
    ap.add_argument("--src", type=Path, help="build this source tree instead of src/ (a modded ROM unless identical)")
    args = ap.parse_args()
    out = (ROOT / args.out).resolve()
    mod = args.mod.resolve() if args.mod else None
    if (ROOT / "build").resolve() not in out.parents:
        sys.exit("output dir must be beneath build/")
    shutil.rmtree(out, ignore_errors=True)
    out.mkdir(parents=True)
    log: list = []
    obj, rom = out / "main.o", out / "dwm2.gbc"
    src = ROOT / "src"
    tree = args.src.resolve() if args.src else ROOT / "src"
    if mod or args.src:  # E-0394: a scratch copy of the tree, whose bank fills take up edited assets' size changes
        src = out / "src"
        shutil.copytree(tree, src)
    assets = extract_assets(out / "assets", mod)
    if mod and DELTAS:
        import assets as asset_tools
        for note in asset_tools.absorb_size_changes(src, DELTAS):
            print("size change:", note)
    run([RGBDS / "rgbasm.exe", "-I", src, "-I", out / "assets", "-I", "local/roms", "-o", obj, src / "main.asm"], log)
    layout = ["-l", src / "layout.link"] if (src / "layout.link").exists() else []  # E-0393
    run([RGBDS / "rgblink.exe", *layout, "-m", out / "dwm2.map", "-n", out / "dwm2.sym", "-o", rom, obj], log)
    tools = {n: subprocess.run([str(RGBDS / f"{n}.exe"), "--version"], capture_output=True, text=True).stdout.strip()
             for n in ("rgbasm", "rgblink")}
    v = subprocess.run([sys.executable, "-I", ROOT / "tools/verify_rom.py", "--manifest", MANIFEST,
                        "--reference", REF, "--output", rom, "--report", out / "report.json"],
                       capture_output=True, text=True)
    rep = json.loads((out / "report.json").read_text())
    rep.update(toolchain=tools, commands=log,
               rgbds_zip_sha256=hashlib.sha256((RGBDS / "rgbds-win64.zip").read_bytes()).hexdigest(),
               source_tree_sha256=hashlib.sha256(b"".join(
                   p.read_bytes() for p in sorted(tree.rglob("*.asm")) + [tree / "assets.txt", tree / "layout.link"]
                   if p.exists())).hexdigest(),
               source_digest=source_tree.digest(tree),  # D-015 (H1b): every src/ file, for source_tree.fresh_build
               assets_extracted=assets, mod=str(mod) if mod else None, src=str(tree) if args.src else None)
    (out / "report.json").write_text(json.dumps(rep, indent=2))
    if mod or (args.src and not rep["pass"]):  # E-0394: a modded ROM is not the matching target; reported, not judged
        print("MODDED BUILD (not the matching target) | bytes differing from the reference:",
              rep.get("differing_bytes"), "|", rom)
        return 0
    print("RESULT:", "PASS" if rep["pass"] else "FAIL", "| differing bytes:", rep.get("differing_bytes"))
    return v.returncode


if __name__ == "__main__":
    sys.exit(main())
