#!/usr/bin/env python3
"""Set up a clean checkout to build: the pinned RGBDS for this platform, and a check of your ROM (H6).

    python -I tools/setup.py [--rom PATH]

1. Downloads the RGBDS release asset config/toolchain.lock.json names for this platform (Windows, Linux x86-64 or
   macOS) from github.com/gbdev/rgbds, checks its SHA-256 against the lock, and unpacks it into tools/rgbds/. An
   archive already there with the right hash is not downloaded again.
2. With --rom, copies your ROM to local/roms/dwm2-cobi-us.gbc after checking its SHA-256 against the target manifest
   (config/targets/dwm2-cobi-us-rev0.json). The ROM never leaves your computer and is ignored by git.
3. Says what to run next.

Nothing here is needed for reading the source; it is needed to build a ROM or a mod.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import os
import shutil
import stat
import sys
import tarfile
import urllib.request
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import toolchain  # noqa: E402

MANIFEST = ROOT / "config/targets/dwm2-cobi-us-rev0.json"
ROM = ROOT / "local/roms/dwm2-cobi-us.gbc"
PROGRAMS = ("rgbasm", "rgblink", "rgbfix", "rgbgfx")
WANTED = set(PROGRAMS) | {p + ".exe" for p in PROGRAMS}  # not the manual pages beside them


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def unpack(archive: Path, dest: Path) -> list[str]:
    """Unpack the programs from a release archive into dest (flattening any folder); returns their names."""
    got = []
    if archive.suffix == ".zip":
        with zipfile.ZipFile(archive) as z:
            for info in z.infolist():
                name = Path(info.filename).name
                if name in WANTED and not info.is_dir():
                    (dest / name).write_bytes(z.read(info))
                    got.append(name)
    else:
        with tarfile.open(archive, "r:*") as t:
            for m in t.getmembers():
                name = Path(m.name).name
                if name in WANTED and m.isfile():
                    (dest / name).write_bytes(t.extractfile(m).read())
                    got.append(name)
    for name in got:
        p = dest / name
        p.chmod(p.stat().st_mode | stat.S_IXUSR | stat.S_IXGRP | stat.S_IXOTH)
    return sorted(got)


def install_rgbds(download=urllib.request.urlretrieve) -> str:
    entry = toolchain.asset()
    toolchain.RGBDS.mkdir(parents=True, exist_ok=True)
    archive = toolchain.archive()
    if not archive.exists() or sha256(archive) != entry["sha256"]:
        tmp = archive.with_suffix(archive.suffix + ".part")
        download(entry["source"], tmp)
        if sha256(tmp) != entry["sha256"]:
            tmp.unlink()
            raise SystemExit(f"FAIL: {entry['asset']} does not have the SHA-256 the lock records; nothing installed")
        os.replace(tmp, archive)
    got = unpack(archive, toolchain.RGBDS)
    if not toolchain.installed():
        raise SystemExit(f"FAIL: {entry['asset']} did not hold rgbasm and rgblink (found {got})")
    return f"RGBDS installed in tools/rgbds/ ({', '.join(got)}) from {entry['asset']}, SHA-256 checked"


def install_rom(path: Path) -> str:
    want = json.loads(MANIFEST.read_text(encoding="utf-8"))["sha256"].lower()
    got = sha256(path)
    if got != want:
        raise SystemExit(f"FAIL: {path} is not the US Cobi's Journey this project builds (SHA-256 {got}); not copied")
    ROM.parent.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(path, ROM)
    return f"ROM checked and copied to {ROM.relative_to(ROOT).as_posix()}"


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--rom", type=Path, help="your ROM of Dragon Warrior Monsters 2: Cobi's Journey (US)")
    a = ap.parse_args(argv)
    print(f"platform: {toolchain.describe()}")
    print(install_rgbds())
    if a.rom:
        print(install_rom(a.rom))
    if not ROM.exists():
        print("next: python -I tools/setup.py --rom PATH/TO/YOUR.gbc (a US Cobi's Journey ROM you own)")
    else:
        print("next: python -I tools/build.py --out build/run1   (builds the original; expect RESULT: PASS)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
