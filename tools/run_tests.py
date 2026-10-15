"""Run the test suite with one process per test file, in parallel, and compare runs.

The serial suite (`python -I -m unittest discover -s tests`) stays the reference. This runner starts
`python -I -m unittest discover -s tests -p <file> -v` for each test file, so every file is loaded and run
exactly as the serial discovery would load it, and prints each test's outcome, the totals and each file's time.

    python -I tools/run_tests.py [--jobs N] [--out LOG]       run in parallel; exit status 1 on any failure
    python -I tools/run_tests.py --compare SERIAL.log PAR.log  compare two `-v` logs test by test

A serial log for --compare is made with `python -I -m unittest discover -s tests -v`. Two logs agree when they
ran the same tests with the same outcome each (ok, skipped, FAIL, ERROR, expected failure, unexpected success).
"""
import argparse
import os
import re
import subprocess
import sys
import time
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
# `test_x (module.Class.test_x) ... ok`; a docstring line may sit between the id and the outcome
RESULT = re.compile(r"^(\w+) \(([\w.]+)\)(?:\n.*?)?? \.\.\. (ok|skipped.*|FAIL|ERROR|expected failure|unexpected success)$",
                    re.M)
RAN = re.compile(r"^Ran (\d+) tests? in ", re.M)


def outcomes(log: str) -> dict[str, str]:
    """test id -> outcome word, from a unittest -v log."""
    out = {}
    for m in RESULT.finditer(log):
        word = m.group(3)
        out[f"{m.group(2)}"] = "skipped" if word.startswith("skipped") else word
    return out


def ran(log: str) -> int:
    return sum(int(n) for n in RAN.findall(log))


def run_file(path: Path) -> tuple[str, float, int, str]:
    t = time.perf_counter()
    p = subprocess.run([sys.executable, "-I", "-m", "unittest", "discover", "-s", "tests", "-p", path.name, "-v"],
                       cwd=ROOT, capture_output=True, text=True, encoding="utf-8", errors="replace")
    return path.name, time.perf_counter() - t, p.returncode, p.stdout + p.stderr


def compare(a: str, b: str) -> list[str]:
    oa, ob = outcomes(a), outcomes(b)
    diffs = [f"{k}: {oa.get(k, 'not run')} vs {ob.get(k, 'not run')}" for k in sorted(set(oa) | set(ob))
             if oa.get(k) != ob.get(k)]
    if ran(a) != ran(b):
        diffs.append(f"tests run: {ran(a)} vs {ran(b)}")
    if len(oa) != ran(a) or len(ob) != ran(b):
        diffs.append(f"outcomes parsed: {len(oa)} of {ran(a)} vs {len(ob)} of {ran(b)}")
    return diffs


def summary(res: dict[str, str]) -> str:
    counts: dict[str, int] = {}
    for v in res.values():
        counts[v] = counts.get(v, 0) + 1
    return ", ".join(f"{k}={v}" for k, v in sorted(counts.items()))


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--jobs", type=int, default=os.cpu_count() or 4)
    ap.add_argument("--out", type=Path, help="write the combined -v log here")
    ap.add_argument("--compare", nargs=2, type=Path, metavar=("SERIAL", "PARALLEL"))
    args = ap.parse_args()
    if args.compare:
        a, b = (p.read_text(encoding="utf-8", errors="replace") for p in args.compare)
        diffs = compare(a, b)
        print(f"{args.compare[0]}: {ran(a)} run, {summary(outcomes(a))}")
        print(f"{args.compare[1]}: {ran(b)} run, {summary(outcomes(b))}")
        print("\n".join(diffs) if diffs else "identical: same tests, same outcome each")
        return 1 if diffs else 0
    files = sorted((ROOT / "tests").glob("test_*.py"))
    if not files:
        print("no test files")
        return 1
    t0 = time.perf_counter()
    with ThreadPoolExecutor(max_workers=max(1, args.jobs)) as ex:
        results = list(ex.map(run_file, files))
    wall = time.perf_counter() - t0
    log = "".join(f"===== {name} ({secs:.1f}s, exit {rc})\n{text}\n" for name, secs, rc, text in results)
    res = outcomes(log)
    failed = [name for name, _, rc, _ in results if rc != 0]
    total = ran(log)
    tail = (f"\nparallel: {len(files)} files, {total} tests in {wall:.1f}s wall; {summary(res)}\n"
            f"slowest files: " + ", ".join(f"{n} {s:.0f}s" for n, s, _, _ in sorted(results, key=lambda r: -r[1])[:10]) +
            ("\nFAILED files: " + ", ".join(failed) if failed else "\nOK") + "\n")
    if args.out:
        args.out.parent.mkdir(parents=True, exist_ok=True)
        args.out.write_text(log + tail, encoding="utf-8")
    print(tail.strip())
    for name, _, rc, text in results:
        if rc != 0:
            print(f"===== {name}\n{text[-3000:]}")
    if len(res) != total:
        print(f"warning: {len(res)} outcomes parsed for {total} tests run")
        return 1
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
