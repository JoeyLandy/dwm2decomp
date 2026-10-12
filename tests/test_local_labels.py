"""Branch targets as local labels (tools/disasm_all.py localize_jump_labels, E-0287): names change, code does not."""
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import disasm_all  # noqa: E402


def run(*texts):
    return disasm_all.localize_jump_labels(list(texts))


class LocalLabels(unittest.TestCase):
    def test_backward_target_in_one_scope_is_a_local_loop(self):
        (out,), n = run("Count::\n    ld b, $04\n\nJump_001_4002::\n    dec b\n    jr nz, Jump_001_4002\n    ret\n")
        self.assertEqual(n, 1)
        self.assertIn("\n.loop:\n    dec b\n    jr nz, .loop\n", out)
        self.assertNotIn("Jump_001_4002", out)

    def test_forward_targets_are_named_by_their_first_effect(self):
        text = ("Step::\n    jr z, Jump_001_4010\n    jr c, Jump_001_4020\n    jr Jump_001_4030\n"
                "Jump_001_4010::\n    xor a, a\n    ld [wSpriteSlotCount], a\n    ret\n"
                "Jump_001_4020::\n    ld a, $01\n    ret\n"
                "Jump_001_4030::\n    call QueueMusic\n    ret\n")
        (out,), _ = run(text)
        self.assertIn("jr z, .clear_sprite_slot_count", out)
        self.assertIn("jr c, .return_01", out)
        self.assertIn("jr .call_queue_music", out)

    def test_repeated_shape_in_one_scope_is_numbered(self):
        tail = "    ld b, b\n" * 4
        text = f"A::\n    jr z, Jump_001_4004\n    jr Jump_001_4006\nJump_001_4004::\n{tail}Jump_001_4006::\n{tail}    ret\n"
        (out,), _ = run(text)
        self.assertIn(".skip:", out)
        self.assertIn(".skip2:", out)

    def test_target_used_from_another_scope_stays_global_with_its_alias(self):
        text = ("First::\n    jr z, Jump_001_4004\n    ret\nJump_001_4004::\n    ld [wSpriteSlotCount], a\n    ret\n"
                "Second::\n    jp Jump_001_4004\n")
        (out,), _ = run(text)
        self.assertIn("First_SetSpriteSlotCount::\nJump_001_4004:: ; address name\n", out)
        self.assertIn("jp First_SetSpriteSlotCount", out)
        self.assertIn("jr z, First_SetSpriteSlotCount", out)

    def test_reference_from_another_file_keeps_the_target_global(self):
        a, b = "Here::\nJump_001_4000::\n    ret\n", "There::\n    jp Jump_001_4000\n"
        (oa, ob), _ = run(a, b)
        self.assertNotIn(".return:", oa)
        self.assertIn("jp Here_Return", ob)

    def test_a_global_target_splits_the_scope_of_later_locals(self):
        # Jump_001_4006 stays global (Other jumps to it), so Jump_001_4008 now sits in its scope; the
        # branch at the top of Start, in the old scope, must keep reaching it, so it becomes global too.
        text = ("Start::\n    jr z, Jump_001_4008\nJump_001_4006::\n    ld b, b\nJump_001_4008::\n    ret\n"
                "Other::\n    jp Jump_001_4006\n")
        (out,), _ = run(text)
        self.assertIn("jr z, Start_Return", out)
        self.assertNotIn("Jump_001_4008::\n", out.replace(":: ; address name", ""))

    def test_comments_name_a_local_by_its_routine(self):
        text = "R::\n    jr nz, Jump_001_4004 ; to Jump_001_4004\nJump_001_4004::\n    ret\n; see Jump_001_4004\n"
        (out,), _ = run(text)
        self.assertIn("jr nz, .return ; to R.return", out)
        self.assertIn("; see R.return", out)

    def test_aliases_and_named_labels_are_untouched(self):
        text = "Name::\nJump_001_4000:: ; address name\n    ret\n"
        (out,), n = run(text)
        self.assertEqual((out, n), (text, 0))


if __name__ == "__main__":
    unittest.main()
