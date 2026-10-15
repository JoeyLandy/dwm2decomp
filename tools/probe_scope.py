"""Which routine readings a probe can check (D-012, E-0370).

A probe (tests/test_probes.py, config/probes.json) runs one routine of the reference ROM on tools/sm83.py from a
chosen register and RAM state until it returns, and compares registers, flags and RAM with what the routine's note
says. This tool sorts every global code label of the listing (build/listing/bankNN.asm) by whether its effect can
be observed that way:

- probe: the routine and everything it calls (transitively, through call, jp, farcall and fall-through into the
  next label) touch only CPU registers, work RAM, high RAM, save RAM and the memory-bank registers (rSVBK, rRAMG,
  rRAMB, rROMB0/1), with no halt, stop or interrupt switching; its effect is a function of its inputs;
- hardware: it (or a callee) reads or writes a display, sound, serial, joypad or timer register, or video RAM: what
  it does is seen on screen, in sound or on the link, which a register-and-RAM probe does not observe;
- interrupts: it (or a callee) runs halt/stop/ei/di, so its timing depends on interrupts;
- unresolved: it jumps through a computed address other than a `jumptable` (jp hl), so its callees are not known.

    python -I tools/probe_scope.py [--list probe|hardware|interrupts|unresolved] [--json OUT]
"""
import argparse
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
LABEL = re.compile(r"^([A-Za-z_]\w*)::")
BANK_REGS = {"rSVBK", "rRAMG", "rRAMG2", "rRAMB", "rROMB0", "rROMB1"}  # rRAMG2 ($1FFF): the RAM enable too (E-0382)
CALL = re.compile(r"^\s+(?:call|jp|jr|farcall|farcall_b|farjp)(?: (?:n?z|n?c),)? ([A-Za-z_][\w]*)\s*$")
DW = re.compile(r"^\s+dw ([A-Za-z_]\w*)")


def routines(listing: Path = ROOT / "build/listing") -> dict[str, dict]:
    out: dict[str, dict] = {}
    for p in sorted(listing.glob("bank[0-9a-f][0-9a-f].asm")):
        cur = None
        order = []
        for ln in p.read_text(encoding="utf-8").split("\n"):
            m = LABEL.match(ln)
            if m:
                if "; address name" in ln:
                    continue
                if cur is not None and cur["insns"] and not cur["ended"]:
                    cur["calls"].add(m.group(1))  # it runs on into this label
                cur = {"file": p.name, "calls": set(), "hw": set(), "int": False, "jphl": False, "data": False,
                       "insns": 0, "ended": False, "dispatch": False}
                out[m.group(1)] = cur
                order.append(m.group(1))
                continue
            if cur is None or not ln.startswith("    "):
                continue
            code = ln.split(";")[0].rstrip()
            if not code.strip():
                continue
            op = code.split()[0]
            if op in ("db", "dw", "INCBIN", "ds", "DS", "dfar") and cur["insns"] == 0:
                cur["data"] = True
            if cur["data"]:
                continue
            if op == "dw" and cur["dispatch"]:
                if (d := DW.match(code)):
                    cur["calls"].add(d.group(1))
                continue
            if op in ("db", "dw", "ds", "DS", "INCBIN", "dfar"):
                continue  # padding or a table after the code: not an instruction, and it does not run on
            cur["insns"] += 1
            # the last instruction decides whether the code runs on into the next label
            cur["ended"] = (code.strip() in ("ret", "reti", "rst $00", "jumptable")
                            or op in ("jp", "jr") and "," not in code)  # `ret z` and `jr nz, x` run on
            if code.strip() in ("rst $00", "jumptable"):
                cur["dispatch"] = True
            if code.strip() == "jp hl" and not cur["dispatch"]:
                cur["jphl"] = True
            if op in ("halt", "stop", "ei", "di", "reti"):
                cur["int"] = True
            for m2 in re.finditer(r"\[(r[A-Z][A-Z0-9]+)\]|\b(v(?:Tiles|BGMap|Chars)\d)\b|\[\$(?:ff|FF)([0-7][0-9A-Fa-f])\]", code):
                reg = m2.group(1) or m2.group(2) or ("$FF" + m2.group(3).upper())
                if reg not in BANK_REGS:
                    cur["hw"].add(reg)
            if (c := CALL.match(code)) and c.group(1) != "hl":
                cur["calls"].add(c.group(1))
    return out


def classify(rs: dict[str, dict]) -> dict[str, str]:
    """name -> probe | hardware | interrupts | unresolved, for code labels (transitive over callees)."""
    memo: dict[str, str] = {}
    rank = {"probe": 0, "unresolved": 1, "interrupts": 2, "hardware": 3}

    def own(r):
        return "hardware" if r["hw"] else "interrupts" if r["int"] else "unresolved" if r["jphl"] else "probe"

    # iterate to a fixed point: a routine is as bad as its worst callee
    for name, r in rs.items():
        if not r["data"]:
            memo[name] = own(r)
    changed = True
    while changed:
        changed = False
        for name, r in rs.items():
            if r["data"]:
                continue
            worst = memo[name]
            for c in r["calls"]:
                if c in memo and rank[memo[c]] > rank[worst]:
                    worst = memo[c]
            if worst != memo[name]:
                memo[name] = worst
                changed = True
    return memo


def reason(name: str, rs: dict[str, dict], cls: dict[str, str]) -> str:
    """Why a routine is out of probe scope: what it touches itself, or the first callee that is out of scope."""
    r = rs[name]
    if r["hw"]:
        return "touches " + ", ".join(sorted(r["hw"])[:4]) + (" ..." if len(r["hw"]) > 4 else "")
    if r["int"]:
        return "halt/stop/ei/di"
    if r["jphl"]:
        return "jumps through a computed address (jp hl)"
    bad = sorted(c for c in r["calls"] if cls.get(c) not in (None, "probe"))
    return f"reaches {bad[0]} ({cls[bad[0]]})" if bad else ""


def document(cls: dict[str, str], rs: dict[str, dict], code_order: list[str], probed: set[str],
             excluded: dict[str, dict], at: dict[str, str]) -> str:
    """docs/PROBE_SCOPE.md: every code label with its probe status (D-012)."""
    rows = {"probe": [], "hardware": [], "interrupts": [], "unresolved": []}
    for name in code_order:
        c = cls.get(name)
        if c is None:
            continue
        k = at.get(name, "")
        if c == "probe":
            status = "probed" if k in probed else ("not probed: " + excluded[k]["reason"]) if k in excluded else "pending"
            rows[c].append(f"| `{name}` | {k} | {status} |")
        else:
            rows[c].append(f"| `{name}` | {k} | {reason(name, rs, cls)} |")
    out = ["# Probe scope", "",
           "Which routine readings an emulator probe can check (D-012; generated by `python -I tools/probe_scope.py "
           "--doc docs/PROBE_SCOPE.md`). A probe runs one routine on tools/sm83.py from a chosen register and RAM "
           "state and compares registers, flags and RAM with its note (config/probes/, tests/test_probes.py). A "
           "routine is in scope when it and everything it reaches touch only CPU registers, WRAM, HRAM, SRAM and the "
           "memory-bank registers. The others are listed with the reason: what they do shows on the display, in "
           "sound, on the serial link or the joypad (registers or video RAM), or depends on interrupt timing, or "
           "jumps through a computed address.", ""]
    titles = {"probe": "In scope", "hardware": "Out of scope: display, sound, serial or joypad hardware",
              "interrupts": "Out of scope: interrupt timing", "unresolved": "Out of scope: computed jumps"}
    for c, rs_ in rows.items():
        out += [f"## {titles[c]} ({len(rs_)})", "", "| Routine | Address | " + ("Status |" if c == "probe" else "Why |"),
                "| --- | --- | --- |"] + rs_ + [""]
    return "\n".join(out)


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--list", choices=("probe", "hardware", "interrupts", "unresolved"))
    ap.add_argument("--json", type=Path)
    ap.add_argument("--doc", type=Path, help="write the full listing (docs/PROBE_SCOPE.md)")
    args = ap.parse_args()
    sys.path.insert(0, str(ROOT / "tools"))
    import doc_coverage
    import present
    order = [n for f in present.bank_files() for n, kind, *_ in doc_coverage.scan(f) if kind == "code"]
    code = set(order)
    rs = routines()
    cls = {k: v for k, v in classify(rs).items() if k in code}
    if args.doc:
        import json as _json
        import label_map
        import probe
        at = {v: k for k, v in label_map.snapshot(ROOT / "build/listing").items()}
        probed = {probe.checks(p) for p in probe.load(sorted((ROOT / "config/probes").glob("*.json")))}
        exp = ROOT / "config/probe_exclusions.json"
        excluded = {k: v for k, v in _json.loads(exp.read_text(encoding="utf-8")).items()
                    if not k.startswith("_")} if exp.exists() else {}
        args.doc.write_text(document(cls, rs, order, probed, excluded, at) + "\n", encoding="utf-8", newline="\n")
    counts: dict[str, int] = {}
    for v in cls.values():
        counts[v] = counts.get(v, 0) + 1
    print(", ".join(f"{k}: {v}" for k, v in sorted(counts.items())))
    if args.list:
        print("\n".join(sorted(k for k, v in cls.items() if v == args.list)))
    if args.json:
        args.json.write_text(json.dumps(cls, indent=0, sort_keys=True), encoding="utf-8")
    return 0


if __name__ == "__main__":
    sys.exit(main())
