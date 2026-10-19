#!/usr/bin/env python3
"""Watch a test suite run from its log: how many tests are done, the outcomes so far, and the test running now.

    python -I tools/suite_progress.py [LOG] [--once] [--every SECONDS]

LOG is the `-v` log of a serial run, written as it goes:

    python -I -m unittest discover -s tests -v > build/logs/suite_N.log 2>&1

Without LOG, the newest build/logs/*.log is watched. Every 15 seconds (--every) it checks the log's size and
redraws only when the log grew, until the log's "Ran N tests" line; then the result stays (exit status 1 if a
test failed). --once prints one snapshot. The total
comes from loading the test files (unittest discovery; nothing is run), so a log of another tree can be off.
Failures are listed as soon as they happen. It only reads the log, so it can be started and stopped at any time
without touching the run. tools/run_tests.py (the parallel runner) prints its own progress as each file ends.
"""
from __future__ import annotations

import argparse
import io
import re
import sys
import time
import unittest
from contextlib import redirect_stderr
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
from run_tests import outcomes, ran  # noqa: E402

TEST_LINE = re.compile(r"^(\w+) \(([\w.]+)\)", re.M)
BAR = 20


def total_tests() -> int:
    """The number of tests in tests/, by loading them (none is run)."""
    sys.path.insert(0, str(ROOT / "tests"))
    with redirect_stderr(io.StringIO()):
        return unittest.TestLoader().discover(str(ROOT / "tests"), top_level_dir=str(ROOT / "tests")).countTestCases()


def newest_log() -> Path | None:
    logs = sorted((ROOT / "build/logs").glob("*.log"), key=lambda p: p.stat().st_mtime)
    return logs[-1] if logs else None


def snapshot(text: str, total: int) -> dict:
    """What a log says so far."""
    res = outcomes(text)
    counts = {k: sum(1 for v in res.values() if v == k) for k in ("ok", "skipped", "FAIL", "ERROR")}
    running = None
    last = None
    for m in TEST_LINE.finditer(text):
        last = m
    if last and last.group(2) not in res:
        running = last.group(2)
    n = ran(text)  # the "Ran N tests" lines: one at the end of a serial log, one per file in run_tests.py's
    results = re.findall(r"^(OK.*|FAILED.*)$", text, re.M)
    return {"done": len(res), "total": max(total, len(res)), "counts": counts, "running": running,
            "failed": [k for k, v in res.items() if v in ("FAIL", "ERROR")],
            "finished": n or None, "result": results[-1] if n and results else None}


def fmt_time(s: float) -> str:
    s = int(s)
    return f"{s // 3600}h{s // 60 % 60:02d}m{s % 60:02d}s" if s >= 3600 else f"{s // 60}m{s % 60:02d}s"


def render(name: str, snap: dict, watched: float) -> list[str]:
    done, total = snap["done"], snap["total"]
    fill = BAR * done // total if total else 0
    c = snap["counts"]
    lines = [f"{name}  [{'#' * fill}{'-' * (BAR - fill)}]  {done}/{total} ({100 * done // max(total, 1)}%)",
             f"ok {c['ok']}  skipped {c['skipped']}  failed {c['FAIL']}  errors {c['ERROR']}"]
    if snap["finished"] is not None:
        lines.append(f"finished: {snap['finished']} tests run; {snap['result'] or 'see the log'}")
    elif snap["running"]:
        lines.append(f"running: {snap['running']}")
    else:
        lines.append("waiting for output")
    lines.append(f"updated {time.strftime('%H:%M:%S')}, watching for {fmt_time(watched)}")
    lines += [f"  FAILED {k}" for k in snap["failed"]]
    return lines


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("log", nargs="?", type=Path)
    ap.add_argument("--once", action="store_true")
    ap.add_argument("--every", type=float, default=15.0)
    a = ap.parse_args(argv)
    log = a.log or newest_log()
    if not log or not log.exists():
        print("no log to watch: give LOG, or start a run that writes to build/logs/")
        return 1
    total = total_tests()
    start = time.time()
    size = -1
    while True:
        if log.stat().st_size == size:  # nothing new: no read, no redraw
            time.sleep(a.every)
            continue
        size = log.stat().st_size
        text = log.read_text(encoding="utf-8", errors="replace")
        snap = snapshot(text, total)
        lines = render(log.name, snap, time.time() - start)
        if sys.stdout.isatty() and not a.once:
            sys.stdout.write("\x1b[H\x1b[2J")  # clear the screen and draw from the top (a wrapped line can't break it)
        print("\n".join(lines), flush=True)
        if a.once or snap["finished"] is not None:
            return 1 if snap["failed"] else 0
        time.sleep(a.every)


if __name__ == "__main__":
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        sys.exit(130)
