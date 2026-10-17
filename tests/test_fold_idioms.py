"""Idiom folding in tools/disasm_all.py: macros replace instruction sequences, never change them."""
import re
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import disasm_all  # noqa: E402

ADD = ("    add a, l\n    ld l, a\n    jr nc, {0}\n    inc h\n\n{0}::\n")


class FoldIdioms(unittest.TestCase):
    def test_add_a_to_hl_folds_when_label_is_private(self):
        out, n = disasm_all.fold_idioms(["    ld hl, $1234\n" + ADD.format("Jump_001_4000") + "    ret\n"])
        self.assertEqual(out[0], "    ld hl, $1234\n    add_a_to_hl\n    ret\n")
        self.assertEqual(n["add_a_to_hl"], 1)

    def test_add_a_to_hl_kept_when_label_is_a_jump_target_elsewhere(self):
        text = ADD.format("Jump_001_4000") + "    jp Jump_001_4000\n"
        out, n = disasm_all.fold_idioms([text])
        self.assertEqual(out[0], text)
        self.assertEqual(n["add_a_to_hl"], 0)

    def test_label_use_in_another_bank_blocks_folding(self):
        text = ADD.format("Jump_001_4000")
        out, n = disasm_all.fold_idioms([text, "    jr nz, Jump_001_4000\n"])
        self.assertEqual(out[0], text)

    def test_other_branch_shape_is_untouched(self):
        text = "    add a, l\n    ld l, a\n    jr c, Jump_001_4000\n    inc h\n\nJump_001_4000::\n"
        self.assertEqual(disasm_all.fold_idioms([text])[0][0], text)

    def test_deref_hl_folds_exact_sequence_only(self):
        out, n = disasm_all.fold_idioms(
            ["    ld a, [hl+]\n    ld h, [hl]\n    ld l, a\n    ld a, [hl+]\n    ld h, [hl]\n    ld e, a\n"])
        self.assertEqual(out[0], "    deref_hl\n    ld a, [hl+]\n    ld h, [hl]\n    ld e, a\n")
        self.assertEqual(n["deref_hl"], 1)

    def test_macros_expand_to_the_removed_instructions(self):
        inc = disasm_all.MACROS_INC
        self.assertIn("MACRO add_a_to_hl\n    add a, l\n    ld l, a\n    jr nc, .skip\\@\n    inc h\n.skip\\@:\nENDM", inc)
        self.assertIn("MACRO deref_hl\n    ld a, [hl+]\n    ld h, [hl]\n    ld l, a\nENDM", inc)


class GeneratedSourceHasNoFoldableIdiom(unittest.TestCase):
    """Audit of the committed src/: every foldable sequence was folded."""

    def test_no_unfolded_deref(self):
        """D-015 (H1b): in src/, either spelling of the post-increment load."""
        files = sorted((ROOT / "src").glob("*/bank*.asm"))
        self.assertGreater(len(files), 200)
        for f in files:
            self.assertNotRegex(f.read_text(encoding="utf-8"),
                                r"    ld a, \[(hl\+|hli)\]\n    ld h, \[hl\]\n    ld l, a\n", f.name)

    def test_src_macros_expand_to_the_removed_instructions(self):
        """The macros as src/macros.inc defines them (the source), not only as the generator writes them."""
        inc = (ROOT / "src/macros.inc").read_text(encoding="utf-8")
        self.assertIn("MACRO add_a_to_hl\n    add a, l\n    ld l, a\n    jr nc, .skip\\@\n    inc h\n.skip\\@:\nENDM", inc)
        self.assertIn("MACRO deref_hl\n    ld a, [hl+]\n    ld h, [hl]\n    ld l, a\nENDM", inc)

    def test_macros_are_used(self):
        """D-015 (H1b): counted in src/, the source (1,834 and 225 on 2026-10-17)."""
        text = "".join(f.read_text(encoding="utf-8") for f in (ROOT / "src").glob("*/bank*.asm"))
        self.assertGreater(len(re.findall(r"^    add_a_to_hl$", text, re.M)), 1000)
        self.assertGreater(len(re.findall(r"^    deref_hl$", text, re.M)), 200)


if __name__ == "__main__":
    unittest.main()
