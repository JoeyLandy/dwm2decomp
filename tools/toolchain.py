"""Where the pinned RGBDS is, on this platform (H6).

config/toolchain.lock.json names RGBDS v1.0.4 and, for each platform, the release asset and its SHA-256 (from the
release's published metadata). tools/setup.py installs it into tools/rgbds/; the build and the tools find the
programs here, so the same commands work on Windows, Linux and macOS.
"""
from __future__ import annotations

import json
import platform
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
RGBDS = ROOT / "tools/rgbds"
LOCK = ROOT / "config/toolchain.lock.json"


def platform_key() -> str:
    """windows, linux or macos (x86-64 Linux is what RGBDS publishes; other Linux builds RGBDS from source)."""
    if sys.platform.startswith("win"):
        return "windows"
    if sys.platform == "darwin":
        return "macos"
    return "linux"


def exe(name: str) -> Path:
    """An RGBDS program (rgbasm, rgblink, rgbfix, rgbgfx) in tools/rgbds/."""
    return RGBDS / (name + (".exe" if platform_key() == "windows" else ""))


def installed() -> bool:
    return exe("rgbasm").exists() and exe("rgblink").exists()


def asset() -> dict:
    """The lock's entry for this platform: {"asset", "source", "sha256"}."""
    lock = json.loads(LOCK.read_text(encoding="utf-8"))["rgbds"]
    return lock["platforms"][platform_key()]


def archive() -> Path:
    """The release archive setup.py downloaded (kept beside the programs, for the build report's hash)."""
    return RGBDS / asset()["asset"]


def describe() -> str:
    return f"{platform_key()} ({platform.machine()}), RGBDS from {asset()['asset']}"
