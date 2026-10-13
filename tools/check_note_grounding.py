"""Grounding check of config/names.json code notes (E-0317).

Every RAM symbol and routine name a note mentions must be connected to the named routine in the generated code:
in its body or its own sub-labels, its xref comment lines, its callers (direct, or through a `dw`/`dfar` table and
the routine that owns that table), its callees up to three levels, or mentioned only as a comparison ("like X",
"as X", "see X"). Address-form RAM mentions (wC5E8) are read as the symbol at that address, as the generated comments
show them (E-0320). A negative control (`check(control=...)`) replaces each note's mentions by random symbols to
show the check rejects unrelated names."""
import bisect
import json
import re
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
LAB = re.compile(r'^([A-Za-z_]\w*)::')
REF = re.compile(r'\b(?:call|jp|jr|farcall|farcall_b|farjp|dw|dfar)(?: \w+,)? ([A-Za-z_]\w*)')


class Source:
    def __init__(self) -> None:
        self.names = json.loads((ROOT / 'config/names.json').read_text(encoding='utf-8'))
        ram = (ROOT / 'src/ram.asm').read_text(encoding='utf-8')
        self.ramsyms = set(re.findall(r'^DEF ([wsh][A-Z]\w*) EQU', ram, re.M))
        self.ram_at = {a: n for n, a in re.findall(r'^DEF ([wsh]\w+) EQU \$([0-9A-F]{4})', ram, re.M)}
        self.banks = {p.name: p.read_text(encoding='utf-8').split('\n')
                      for p in sorted((ROOT / 'build/listing').glob('bank*.asm'))}
        self.regions: dict[str, tuple[str, int, int]] = {}
        self.alias_of: dict[str, str] = {}
        for p, lines in self.banks.items():
            cur, start = None, 0
            for i, ln in enumerate(lines):
                m = LAB.match(ln)
                if not m:
                    continue
                if 'address name' in ln:
                    if cur:
                        self.alias_of[m.group(1)] = cur
                    continue
                if cur:
                    self.regions[cur] = (p, start, i)
                cur, start = m.group(1), i
            if cur:
                self.regions[cur] = (p, start, len(lines))
        self.refs: dict[str, set[str]] = defaultdict(set)
        for name in self.regions:
            for ln in self.body(name):
                for t in REF.findall(ln.split(';')[0]):
                    self.refs[name].add(self.alias_of.get(t, t))
        self.callers: dict[str, set[str]] = defaultdict(set)
        for a, ts in self.refs.items():
            for t in ts:
                self.callers[t].add(a)
        self.sorted = sorted(self.regions)
        self._fam: dict[str, list[str]] = {}

    def body(self, name: str) -> list[str]:
        p, s, e = self.regions[name]
        return self.banks[p][s + 1:e]

    def head(self, name: str) -> list[str]:
        p, s, _e = self.regions[name]
        lines, out, j = self.banks[p], [], s - 1
        while j >= 0 and lines[j].startswith(';'):
            out.append(lines[j])
            j -= 1
        return out

    def family(self, name: str) -> list[str]:
        if name not in self._fam:
            out = [name] if name in self.regions else []
            i = bisect.bisect_left(self.sorted, name + '_')
            while i < len(self.sorted) and self.sorted[i].startswith(name + '_') and len(out) < 200:
                out.append(self.sorted[i])
                i += 1
            self._fam[name] = out
        return self._fam[name]

    def closure(self, name: str, depth: int = 3) -> set[str]:
        seen, front = set(self.family(name)), set(self.family(name))
        for _ in range(depth):
            nxt: set[str] = set()
            for n in front:
                for t in self.refs.get(n, ()):
                    if t in self.regions and t not in seen:
                        seen.add(t)
                        nxt.add(t)
                        nxt |= set(self.family(t)[:20])
            front = nxt
        return seen


def check(control=None, src: Source | None = None):
    """Returns (grounded, total, [(routine, mention), ...] not grounded). `control(name, note)` returns the
    mentions to test instead of the note's own (the negative control)."""
    src = src or Source()
    total = grounded = 0
    bad = []
    for key, v in src.names.items():
        if key.startswith('_') or v.get('data'):
            continue
        nm = v['name']
        if nm not in src.regions:
            continue
        note = re.sub(r'\b[wsh]([0-9A-F]{4})\b', lambda m: src.ram_at.get(m.group(1), m.group(0)), v.get('note', ''))
        near = src.closure(nm)
        cl: set[str] = set()
        for n in src.family(nm):
            cl |= src.callers.get(n, set())
        cl2: set[str] = set()
        for c in cl:
            cl2 |= src.callers.get(c, set())
        hay_names = near | cl | cl2
        hay = '\n'.join('\n'.join(src.body(n)) for n in near) + '\n' + \
            '\n'.join('\n'.join(src.head(n)) for n in src.family(nm))
        comparisons = set(re.findall(
            r'\b(?:like|as|as in|see|cf\.|same as|than|copy of|copies of|unlike|with)\s+([A-Za-z_]\w*)', note))
        if control:
            mentions = control(nm, note)
        else:
            mentions = set(re.findall(r'\b([wsh][A-Z]\w+)\b', note)) & src.ramsyms
            mentions |= {t for t in re.findall(r'\b([A-Z][A-Za-z0-9_]{5,})\b', note) if t in src.regions and t != nm}
        for t in sorted(mentions):
            total += 1
            tt = src.alias_of.get(t, t)
            if t in comparisons or tt in hay_names or t in hay_names or re.search(r'\b' + re.escape(t) + r'\b', hay):
                grounded += 1
            else:
                bad.append((nm, t))
    return grounded, total, bad


if __name__ == '__main__':
    g, t, bad = check()
    print(f'{g} of {t} mentions grounded; {len(bad)} not')
    for nm, x in bad[:60]:
        print(f'  {nm}: {x}')
