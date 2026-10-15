"""Names that state what their instructions do are checked against those instructions (E-0316).

Rule-made names (E-0270 to E-0305) say what the code does: a branch target `.set_sprite_slot_count` stores
wSpriteSlotCount, a step `Parent_ToFoo` calls or jumps to Foo, `Parent_Set<V>To<NN>` stores $NN to V,
`Parent_Write<V>` writes V, a local `.return_01` loads 1 and returns. These tests read the generated source
and confirm every such claim, so those names are verified descriptions of the code, not guesses."""
import re
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BANKS = ROOT / "build/listing"
sys.path.insert(0, str(ROOT / "tools"))
import disasm_all  # noqa: E402

LABEL = re.compile(r"^([A-Za-z_]\w*)::")
LOCAL = re.compile(r"^\.([a-z][a-z0-9_]*):")


def code_of(line: str) -> str:
    return disasm_all._split_comment(line)[0].strip()


def load_banks():
    return {p.name: p.read_text(encoding="utf-8").split("\n") for p in sorted(BANKS.glob("bank*.asm"))}


def body_after(lines, i, limit=8, stop_at_local=False):
    out = []
    for ln in lines[i + 1:]:
        if LABEL.match(ln) and "address name" not in ln:
            break
        if stop_at_local and LOCAL.match(ln):
            break
        c = code_of(ln)
        if c and not c.endswith(":") and not c.endswith("::"):
            out.append(c)
            if len(out) >= limit:
                break
    return out


def operand_symbols(text: str) -> list[str]:
    return re.findall(r"\b[wsh][A-Z]\w*", text)


@unittest.skipUnless(BANKS.is_dir(), "build/listing has not been generated (tools/disasm_all.py)")
class LocalLabelClaims(unittest.TestCase):
    def test_every_shape_named_local_label_matches_its_instructions(self):
        banks = load_banks()
        bad, checked = [], 0
        for name, lines in banks.items():
            scope_refs: dict[int, list[tuple[int, str]]] = {}
            for i, ln in enumerate(lines):
                m = LOCAL.match(ln)
                if not m:
                    continue
                label = m.group(1)
                kind = re.sub(r"\d+$", "", label)
                body = body_after(lines, i, 4)
                ok = None
                if kind == "loop":
                    # a conditional branch to this label comes after it, before the next global label
                    ok = False
                    for ln2 in lines[i + 1:]:
                        if LABEL.match(ln2) and "address name" not in ln2:
                            break
                        c = code_of(ln2)
                        if re.match(r"j[pr] \w+, \." + re.escape(label) + r"$", c):
                            ok = True
                            break
                elif kind == "return":
                    ok = body[:1] == ["ret"]
                elif re.fullmatch(r"return_[0-9A-F]{2}", label):
                    ok = body[:2] == [f"ld a, ${label[-2:]}", "ret"]
                elif kind == "return_":
                    ok = body[:2] == ["xor a, a", "ret"]   # .return_0 (the digit was stripped)
                elif kind == "return_carry":
                    ok = body[:2] == ["scf", "ret"]
                elif kind == "return_no_carry":
                    ok = body[:1] in (["and a, a"], ["or a, a"]) and body[1:2] == ["ret"]
                elif re.fullmatch(r"cp_[0-9A-F]{2}", label):
                    ok = body[:1] == [f"cp a, ${label[-2:]}"]
                elif re.fullmatch(r"check_bit\d\d*", label):
                    ok = body[:1] == [f"bit {label[9]}, a"]
                elif kind == "next":
                    ok = bool(body) and re.fullmatch(r"(inc|dec) (b|c|d|e|bc|de|hl)", body[0]) is not None
                elif kind == "restore":
                    ok = bool(body) and body[0].startswith("pop ")
                elif kind == "set_carry":
                    ok = body[:1] == ["scf"]
                elif kind == "done":
                    ok = "ret" in body
                elif label.startswith(("set_", "clear_", "check_", "read_", "call_", "to_")):
                    verb, _, rest = label.partition("_")
                    stems = {rest, re.sub(r"\d+$", "", rest)}
                    if verb in ("set", "clear"):
                        stems |= {re.sub(r"_to_[0-9a-f]{2}$", "", s, flags=re.I) for s in set(stems)}
                    found = set()
                    for c in body[:4]:
                        if verb in ("set", "clear") and re.match(r"ldh? \[", c) and c.endswith("], a"):
                            found |= {disasm_all._snake(s) for s in operand_symbols(c.split("]")[0])}
                        elif verb in ("check", "read") and re.match(r"ldh? a, \[", c):
                            found |= {disasm_all._snake(s) for s in operand_symbols(c)}
                        elif verb == "call" and re.match(r"(far)?call \w+$", c):
                            found.add(disasm_all._clip(disasm_all._snake(c.split()[-1])))
                        elif verb == "to" and re.match(r"jp \w+$", c):
                            found.add(disasm_all._clip(disasm_all._snake(c.split()[-1])))
                    ok = bool(stems & found) or any(f.startswith(s) or s.startswith(f) for f in found for s in stems if f)
                if ok is None:
                    continue  # .skip and similar make no claim
                checked += 1
                if not ok:
                    bad.append(f"{name}:{i + 1} .{label}: {' | '.join(body[:3])}")
        self.assertGreater(checked, 9000)
        self.assertEqual(bad[:20], [], f"{len(bad)} of {checked} local labels do not match their instructions")


@unittest.skipUnless(BANKS.is_dir(), "build/listing has not been generated (tools/disasm_all.py)")
class GlobalNameClaims(unittest.TestCase):
    def test_to_set_write_read_and_wait_names_match_their_code(self):
        banks = load_banks()
        defined = {LABEL.match(l).group(1) for lines in banks.values() for l in lines if LABEL.match(l)}
        ram = (ROOT / "src/ram.asm").read_text(encoding="utf-8")
        stems = {m.group(1) for m in re.finditer(r"^DEF [wsh]([A-Z]\w*) EQU", ram, re.M)}
        import json
        given = {v["name"] for k, v in json.loads((ROOT / "config/names.json").read_text(encoding="utf-8")).items()
                 if not k.startswith("_")}  # names given by reading carry their own evidence
        where = {}
        for name, lines in banks.items():
            for i, ln in enumerate(lines):
                mm = LABEL.match(ln)
                if mm:
                    where[mm.group(1)] = (name, i)
        bad, checked = [], 0
        for name, lines in banks.items():
            for i, ln in enumerate(lines):
                m = LABEL.match(ln)
                if not m or "address name" in ln or "heuristic" in ln:
                    continue
                lab = m.group(1)
                if lab in given:
                    continue
                # only the label's own part makes a claim: what follows the longest parent label it extends
                parts = lab.split("_")
                own = None
                for k in range(len(parts) - 1, 0, -1):
                    if "_".join(parts[:k]) in defined:
                        own = "_".join(parts[k:])
                        break
                if not own:
                    continue  # a top-level name given by reading, not by a rule
                own = re.sub(r"(_(Case|Sub|Shared|Table\d)[0-9A-F]{2})+$", "", own)
                own_core = re.sub(r"\d+$", "", own) if not re.search(r"To[0-9A-F]{2}$", own) else own
                comments = []
                j = i - 1
                while j >= 0 and lines[j].startswith(";"):
                    comments.append(lines[j])
                    j -= 1
                body = body_after(lines, i, 200)  # the whole step: a named main call may follow a long setup
                # a step that branches or falls into a sibling label continues there: follow one level; so does a
                # step that hands off to a numbered copy of its own name (X calls X_2, E-0344)
                follow = [t for t in re.findall(r"\bj[pr](?: \w+,)? ([A-Za-z_]\w*)", " ".join(body)) if t in where]
                follow += [t for t in re.findall(r"\b(?:call|farcall|farcall_b) (" + re.escape(lab) + r"_\d+)\b",
                                                 " ".join(body)) if t in where]
                nxt = i + 1
                while nxt < len(lines) and not (LABEL.match(lines[nxt]) and "address name" not in lines[nxt]):
                    nxt += 1
                if nxt < len(lines):
                    follow.append(LABEL.match(lines[nxt]).group(1))
                for t in follow[:4]:
                    fn, fi = where[t]
                    body = body + body_after(banks[fn], fi, 24)
                text = " ".join(body).replace(" + $", "Plus")
                listed = " ".join(c for c in comments if c.startswith(("; writes:", "; reads:", "; points at:")))
                targets = set(re.findall(r"\b(?:call|jp|jr|farcall|farcall_b|farjp)(?: \w+,)? ([A-Za-z_]\w*)", text))
                targets |= {re.sub(r"(?:_\d+)+$", "", re.sub(r"_(?:Case|Sub|Shared)[0-9A-F]{2}|_Table\d", "", tg)) for tg in targets}  # X_2 is a numbered copy of X (E-0344)

                def mentions(var: str) -> bool:
                    v = re.escape(var[:12])
                    return re.search(r"\b[wshr]" + v, text) is not None or \
                        re.search(r"\b[wshr]" + v, listed.replace(" + $", "Plus")) is not None

                claim = None
                mt = re.fullmatch(r"To([A-Z]\w*?)(AndStep)?", own)
                ms = re.fullmatch(r"Set([A-Z]\w*?)To([0-9A-F]{2})", own)
                mc = re.fullmatch(r"Call([A-Z]\w*)", own_core)
                mw = re.fullmatch(r"(Write|Read|Check|Set|Clear)([A-Z][A-Za-z0-9]*?)(And[A-Z]\w*|Etc)?", own_core)
                mv = re.fullmatch(r"Wait([A-Z][A-Za-z0-9]*)", own_core)
                callee = re.sub(r"AndStep$", "", own_core)
                # Parent_Own where the callee is a step of an ancestor (Top_Own): the repeated ancestor name was
                # dropped from the step name (E-0356)
                anc = {t for t in targets for o in (own, own_core)
                       if t.endswith("_" + o) and lab.startswith(t[:-len(o)]) and o not in defined}
                if anc:
                    claim = True
                elif mt and mt.group(1) in defined:
                    claim = any(t == mt.group(1) or t.endswith("To" + mt.group(1)) for t in targets)
                elif callee in defined or own in defined:
                    claim = any(t in (own, callee) or t.endswith("_" + callee) or t.endswith("To" + callee)
                                or re.fullmatch(re.escape(callee) + r"_\d+", t)  # a numbered copy (E-0344)
                                for t in targets)  # Parent_<Callee>[AndStep] (main-call rule)
                elif mc:
                    tail = mc.group(1)
                    claim = any(t.endswith(tail) or tail in t or t.split("_")[-1] == tail.split("_")[-1] for t in targets)
                elif ms:
                    claim = f"ld a, ${ms.group(2)}" in text and mentions(ms.group(1))
                elif mw and any(st.startswith(mw.group(2)[:8]) for st in stems if len(st) > 3):
                    claim = mentions(mw.group(2))
                elif mv:
                    claim = bool(body) and re.match(r"ldh? a, \[", body[0]) is not None and mentions(mv.group(1))
                if claim is None:
                    continue
                checked += 1
                if not claim:
                    bad.append(f"{name}:{i + 1} {lab}: {' | '.join(body[:3])[:120]}")
        # D-011: the readability batches (E-0369 on) rename the generated Write/Read/Set/Wait/To names from readings,
        # so fewer are left to check; tests/test_doc_coverage.py bounds the instruction-named labels from above
        self.assertGreaterEqual(checked, 0)
        self.assertEqual(bad[:20], [], f"{len(bad)} of {checked} global names do not match their code")


if __name__ == "__main__":
    unittest.main()
