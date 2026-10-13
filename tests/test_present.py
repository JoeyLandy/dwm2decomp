"""tools/present.py: src/banks is the annotated listing written for readers, with the same code and data."""
import re
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import present  # noqa: E402

LISTING = ROOT / "build" / "listing"
SRC = ROOT / "src" / "banks"


def _p(text: str) -> str:
    return present.present(text, present.Names({"x": text}))


class PresentLineTest(unittest.TestCase):
    def test_instruction_syntax(self):
        text = ("    xor a, a\n    cp a, $FF\n    add a, a\n    add hl, de\n    sub a, b\n    ld a, [hl+]\n"
                "    ld [hl-], a\n    rst $00\n    rst $10\n    ld a, [wX + $1F] ; keeps $AB in comments\n"
                '    db "ABC", $F0\n')
        self.assertEqual(_p(text), "    xor a\n    cp $ff\n    add a\n    add hl, de\n    sub b\n    ld a, [hli]\n"
                                   "    ld [hld], a\n    jumptable\n    rst $10\n    ld a, [wX + $1f] ; keeps $AB in comments\n"
                                   '    db "ABC", $f0\n')

    def test_bookkeeping_is_left_out(self):
        text = ("; does a thing (E-0001)\n; 2 call sites from 2 routines (e.g. A, B)\n; reads: wX\n; writes: wY\n"
                "; no direct call (reached through a table, a jump or a vector)\n"
                "DoThing:: ; heuristic: follows a terminator; C0\nFunc_001_4000:: ; address name\n    ret\n")
        self.assertEqual(_p(text), "; does a thing (E-0001)\nDoThing::\n    ret\n")

    def test_address_mentions_become_labels(self):
        text = ("Other::\nFunc_001_4100:: ; address name\n    ret\n\n"
                "; jumps to Func_001_4100, the same as 01:4100\nThing::\n    jp Other\n")
        self.assertIn("; jumps to Other, the same as Other\n", _p(text))

    def test_table_comment_written_once(self):
        text = "".join(f"; record: sprite: Y offset, X offset, tile, attribute\nT{i}::\n    db 1, 2, 3, 4\n"
                       for i in range(3))
        self.assertEqual(_p(text).count("; record: sprite"), 1)
        # instructions between the repeats start a new table: the comment is written again
        text2 = "; a note\nA::\n    ret\n; a note\nB::\n    ret\n"
        self.assertEqual(_p(text2).count("; a note"), 2)

    def test_evidence_moves_to_the_end_and_long_comments_wrap(self):
        self.assertEqual(_p("; E-0147 (derived: frame 0 of Set00; ends with $80)\n"),
                         "; frame 0 of Set00; ends with $80 (E-0147)\n")
        self.assertEqual(_p("; E-0256 (C1: row 0 (Slime), band 0 of T).\n"), "; row 0 (Slime), band 0 of T (E-0256, C1)\n")
        long = "; " + " ".join(["word"] * 60) + "\n"
        lines = _p(long).rstrip("\n").split("\n")
        self.assertGreater(len(lines), 1)
        self.assertTrue(all(len(ln) <= present.WIDTH and ln.startswith("; ") for ln in lines))


def _code(text: str) -> list[str]:
    """The code and data lines, without comments, aliases or label tags, in the presented spelling."""
    out = []
    for ln in text.split("\n"):
        if present.ALIAS.match(ln) or ln.lstrip().startswith(";") or not ln.strip():
            continue
        m = present.LABEL_TAG.match(ln)
        ln = m.group(1) if m else ln
        code = present.split_code(ln)[0].rstrip()
        out.append(present.code_line(code) if not present.LABEL.match(code) else code)
    return out


@unittest.skipUnless(LISTING.is_dir(), "build/listing has not been generated (tools/disasm_all.py)")
class PresentedTreeTest(unittest.TestCase):
    def test_src_is_the_presented_listing(self):
        texts = {p.name: p.read_text(encoding="utf-8") for p in sorted(LISTING.glob("bank*.asm"))}
        names = present.Names(texts)
        titles = present.bank_titles()
        stale = [n for n, t in texts.items() if (SRC / present.src_name(n, titles)).read_text(encoding="utf-8")
                 != present.header(n, titles) + present.present(t, names)]
        self.assertEqual(stale, [], "src/banks is not tools/present.py's output for build/listing")

    def test_no_code_or_data_line_is_lost(self):
        titles = present.bank_titles()
        for p in sorted(LISTING.glob("bank*.asm")):
            want = _code(p.read_text(encoding="utf-8"))
            got = [present.split_code(ln)[0].rstrip()
                   for ln in (SRC / present.src_name(p.name, titles)).read_text(encoding="utf-8").split("\n")
                   if ln.strip() and not ln.lstrip().startswith(";")]
            self.assertEqual(got, want, p.name)

    def test_every_bank_file_is_named_and_included_once(self):
        titles = present.bank_titles()
        self.assertEqual(len(titles), 256)
        files = sorted(p.name for p in SRC.glob("bank*.asm"))
        self.assertEqual(files, sorted(present.src_name(f"bank{b:02x}.asm", titles) for b in range(256)))
        main = (ROOT / "src" / "main.asm").read_text(encoding="utf-8")
        self.assertEqual(re.findall(r'^INCLUDE "banks/(bank\w+\.asm)"$', main, re.M), files)
        self.assertTrue((SRC / files[0x36]).read_text(encoding="utf-8").startswith("; ROM bank $36: "))

    def test_no_address_name_left(self):
        text = "\n".join(p.read_text(encoding="utf-8") for p in SRC.glob("bank*.asm"))
        self.assertIsNone(re.search(r"^(?:Func|Jump|Data)_[0-9A-F]{3}_[0-9A-F]{4}::", text, re.M))
        self.assertNotIn("; heuristic:", text)
        self.assertNotIn("; address name", text)


if __name__ == "__main__":
    unittest.main()
