#!/usr/bin/env python3
"""Binary identity gate: compare a built ROM against the immutable reference.

Passes only if the reference matches the approved manifest AND the built output
has equal length, equal SHA-256 and zero differing bytes. Anything missing,
unreadable or mismatched is a failure (exit 1), never a pass.

Usage: verify_rom.py --manifest M.json --reference REF --output OUT [--report R.json]
"""
from __future__ import annotations

import argparse
import hashlib
import json
import os
import sys
from pathlib import Path

BANK = 0x4000


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def diff_ranges(ref: bytes, out: bytes, max_ranges: int = 32) -> tuple[int, list[list[int]]]:
    """Return (total differing bytes over the common length, first half-open ranges)."""
    n = min(len(ref), len(out))
    total = 0
    ranges: list[list[int]] = []
    start = None
    for i in range(n):
        if ref[i] != out[i]:
            total += 1
            if start is None:
                start = i
        elif start is not None:
            if len(ranges) < max_ranges:
                ranges.append([start, i])
            start = None
    if start is not None and len(ranges) < max_ranges:
        ranges.append([start, n])
    return total, ranges


def verify(manifest_path: Path, reference: Path, output: Path) -> dict:
    report: dict = {"target": None, "pass": False, "errors": []}
    err = report["errors"]
    try:
        manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
        report["target"] = manifest["id"]
        want_size, want_hash = manifest["size_bytes"], manifest["sha256"]
    except (OSError, ValueError, KeyError) as e:
        err.append(f"manifest unusable: {e}")
        return report

    try:
        if reference.resolve() == output.resolve():
            err.append("reference and output are the same path")
            return report
    except OSError as e:
        err.append(f"cannot resolve paths: {e}")
        return report

    try:
        ref = reference.read_bytes()
    except OSError as e:
        err.append(f"reference unreadable: {e}")
        return report
    report["reference"] = {"size": len(ref), "sha256": sha256(ref)}
    if len(ref) != want_size or sha256(ref) != want_hash:
        err.append("reference does not match the approved manifest")
        return report

    try:
        out = output.read_bytes()
    except OSError as e:
        err.append(f"output unreadable: {e}")
        return report
    report["output"] = {"size": len(out), "sha256": sha256(out)}

    total, ranges = diff_ranges(ref, out)
    # Length difference counts as differing bytes too.
    total += abs(len(ref) - len(out))
    report["differing_bytes"] = total
    report["first_diff_ranges"] = ranges
    report["first_diff_offset"] = ranges[0][0] if ranges else None
    if len(out) != len(ref):
        err.append(f"length mismatch: reference {len(ref)}, output {len(out)}")
    if sha256(out) != want_hash:
        err.append("output SHA-256 differs from the approved hash")
    if total:
        err.append(f"{total} differing bytes")
    report["pass"] = not err
    return report


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--manifest", type=Path, required=True)
    ap.add_argument("--reference", type=Path, required=True)
    ap.add_argument("--output", type=Path, required=True)
    ap.add_argument("--report", type=Path)
    a = ap.parse_args(argv)
    r = verify(a.manifest, a.reference, a.output)
    text = json.dumps(r, indent=2)
    if a.report:
        a.report.parent.mkdir(parents=True, exist_ok=True)
        a.report.write_text(text + "\n", encoding="utf-8")
    print(text)
    print("RESULT:", "PASS" if r["pass"] else "FAIL", file=sys.stderr)
    return 0 if r["pass"] else 1


if __name__ == "__main__":
    sys.exit(main())
