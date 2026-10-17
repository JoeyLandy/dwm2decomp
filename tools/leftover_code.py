#!/usr/bin/env python3
"""M4 (E-0395): uncovered bytes right after a routine's end that decode as code no traced path reaches.

Reads the gaps `tools/disasm_all.py --leftover build/leftover.json` records (bytes the generator could place in
no instruction, table, stream or string, written as `db`), and trial-decodes those that start right after an
unconditional ret, reti, jp or jr in a bank with code: a routine may follow there that nothing in the traced
code calls. Each gap gets one verdict:

  code     every byte up to an unconditional end decodes, and every call/jp/jr target is a known label, an
           instruction of the gap itself, or bank $00 code (C1 by itself: unreached code is not proof of use)
  code?    it decodes to an end, but a target is unknown (inside data, or a number nothing else uses)
  open     it decodes but runs to the end of the gap without an unconditional end
  not code an invalid opcode, or an instruction that would run past the gap
  fill     one byte value repeated (padding)

Usage: leftover_code.py [--gaps build/leftover.json] [--sym build/runN/dwm2.sym] [--json out.json]
"""
from __future__ import annotations

import argparse
import collections
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import bank_check  # noqa: E402
from trace_disasm import decode  # noqa: E402

ENDS = ("ret", "reti", "jp hl")


def is_end(text: str, kind: str) -> bool:
    return text in ENDS or kind in ("jp", "jr")  # jp/jr kinds are unconditional; jpc/jrc are conditional


def trial(rom: bytes, bank: int, lo: int, hi: int, labels: set[tuple[int, int]]) -> dict:
    base = 0 if bank == 0 else 0x4000
    raw = rom[bank * 0x4000 + lo - base:bank * 0x4000 + hi - base]
    if len(set(raw)) == 1:
        return {"verdict": "fill", "insns": []}
    pc, insns, targets = lo, [], []
    while pc < hi:
        n, text, kind, tgt = decode(rom, bank * 0x4000 + pc - base, pc)
        if kind == "bad" or pc + n > hi:
            return {"verdict": "not code", "insns": insns, "at": pc}
        insns.append((pc, text.replace("{T}", f"${tgt:04X}") if tgt is not None and text else text))
        if tgt is not None and kind not in ("rst",):
            targets.append(tgt)
        pc += n
        if is_end(text, kind):
            starts = {a for a, _ in insns}
            unknown = [t for t in targets if not (t in starts or (0 if t < 0x4000 else bank, t) in labels)]
            return {"verdict": "code" if not unknown else "code?", "insns": insns, "end": pc,
                    "unknown_targets": [f"${t:04X}" for t in unknown], "rest": hi - pc}
    return {"verdict": "open", "insns": insns}


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--gaps", type=Path, default=ROOT / "build/leftover.json")
    ap.add_argument("--sym", type=Path)
    ap.add_argument("--json", type=Path)
    ap.add_argument("--examples", type=int, default=0)
    ap.add_argument("--doc", type=Path, help="write the list (docs/LEFTOVER_CODE.md)")
    args = ap.parse_args(argv)
    rom = (ROOT / "local/roms/dwm2-cobi-us.gbc").read_bytes()
    sym = bank_check.load_sym(args.sym or bank_check.newest_sym())
    labels = set(sym.values())
    by_addr = {v: k for k, v in sym.items() if "." not in k}
    gaps = json.loads(args.gaps.read_text(encoding="utf-8"))
    seen, out = set(), []
    for g in gaps:
        key = (g["bank"], g["lo"], g["hi"])
        if key in seen or not g["code_bank"] or not g["after"]:
            continue
        seen.add(key)
        a, text, kind = g["after"]
        if not is_end(text, kind):
            continue
        r = trial(rom, g["bank"], g["lo"], g["hi"], labels)
        owner = max((ad for (b, ad) in by_addr if b == g["bank"] and ad <= g["lo"]), default=None)
        r.update(bank=f"{g['bank']:02X}", lo=f"{g['lo']:04X}", hi=f"{g['hi']:04X}", size=g["hi"] - g["lo"],
                 after=by_addr.get((g["bank"], owner)) if owner is not None else None)
        out.append(r)
    c = collections.Counter(r["verdict"] for r in out)
    print(f"{len(out)} gaps right after an unconditional end in code banks: " +
          ", ".join(f"{k} {v}" for k, v in sorted(c.items())))
    for r in [r for r in out if r["verdict"] in ("code", "code?")][:args.examples]:
        print(f"  {r['bank']}:{r['lo']} ({r['size']} bytes, after {r['after']}) {r['verdict']}: " +
              "; ".join(t for _a, t in r["insns"][:8]))
    if args.json:
        args.json.write_text(json.dumps(out, indent=0), encoding="utf-8")
    if args.doc:
        args.doc.write_text(doc_text(out, c), encoding="utf-8", newline="\n")
    return 0


WHY = {
    "fill": "one byte value repeated: padding",
    "not code": "an invalid opcode, or an instruction running past the gap: data",
    "open": "no unconditional end inside the gap: data, or code that runs on into data",
    "code?": "decodes to an end, but a jump or call goes to no known instruction or label: left as data",
    "code": "decodes to an end with no call or jump into known code (too little to tell code from data): left as data",
}


def doc_text(out: list[dict], c: collections.Counter) -> str:
    lines = ["# Leftover code bytes", "",
             "Stage M4 of the moddable-decomp goal ([roadmap](ROADMAP.md)), evidence E-0395 in the",
             "[evidence log](EVIDENCE_LOG.md). Generated by `tools/leftover_code.py --doc` from",
             "`tools/disasm_all.py --leftover build/leftover.json`; do not edit by hand.", "",
             "Bytes the generator places in no instruction, table, stream or string are written as `db`. Those that",
             "start right after an unconditional ret, reti, jp or jr in a bank with code are where an unreached routine",
             "would sit, so each is trial-decoded. A gap that decodes to an end and calls or jumps into known code",
             "(a label or an instruction start) became code through config/code_entries.json: 80 did, and tracing them found 22 more routines right after them, 102 in all (E-0395).",
             "These are the gaps left after a routine's end, with what the trial decode found:", ""]
    lines += [f"- {k}: {v} ({WHY[k]})" for k, v in sorted(c.items())]
    lines += ["", "| Gap | Bytes | After | Verdict | Decodes as |", "| --- | --- | --- | --- | --- |"]
    for r in sorted(out, key=lambda r: (r["bank"], r["lo"])):
        dec = "; ".join(t for _a, t in r["insns"][:6]) if r["verdict"] not in ("fill",) else ""
        lines.append(f"| {r['bank']}:{r['lo']} | {r['size']} | {r['after'] or ''} | {r['verdict']} | "
                     f"{dec.replace('|', '/')} |")
    return "\n".join(lines) + "\n"


if __name__ == "__main__":
    sys.exit(main())
