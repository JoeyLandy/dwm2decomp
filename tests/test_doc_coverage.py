"""Every label in src/ is documented, pokered-style, and comments name only things that exist (E-0347)."""
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import describe  # noqa: E402
import doc_coverage  # noqa: E402

import present  # noqa: E402

FILES = present.bank_files()


@unittest.skipUnless(FILES, "src/ has not been presented (tools/disasm_all.py)")
class Coverage(unittest.TestCase):
    def test_every_label_is_documented(self):
        missing = []
        for f in FILES:
            header = False
            for name, kind, comment, line, text_body in doc_coverage.scan(f):
                if kind == "code":
                    header = False
                    if not comment:
                        missing.append(f"{f.name}:{line} {name}")
                elif comment:
                    header = True
                elif not (text_body or header):
                    missing.append(f"{f.name}:{line} {name}")
        self.assertEqual(missing[:10], [], f"{len(missing)} labels without a comment")

    def test_notes_that_admit_a_gap_restate_the_code(self):
        gaps = [f"{f.name}:{line} {name}" for f in FILES for name, kind, comment, line, _ in doc_coverage.scan(f)
                if kind == "code" and doc_coverage.GAP.search(comment) and "; code:" not in comment]
        self.assertEqual(gaps[:10], [])

    def test_comments_name_only_labels_symbols_and_constants(self):
        self.assertEqual(dict(doc_coverage.stale_names(FILES).most_common(10)), {})


class Summaries(unittest.TestCase):
    """tools/describe.py restates instructions; these pin its reading of common shapes."""

    def body(self, text):
        return ["    " + ln for ln in text.strip().split("\n")]

    def test_increment_through_a_and_a_step_advance(self):
        s = describe.summarize("X", self.body("""
ld a, [wObject1 + OBJ_X]
inc a
ld [wObject1 + OBJ_X], a
ld hl, wScriptStep
inc [hl]
ret"""), ["; entry 1 of the `rst $00` table in SceneRoltElder"])
        self.assertEqual(s, "step 1 of SceneRoltElder: increments wObject1 + OBJ_X; advances wScriptStep")

    def test_conditional_return_and_constant_store(self):
        s = describe.summarize("X", self.body("""
ld a, [wObject2 + OBJ_Y]
dec a
ld [wObject2 + OBJ_Y], a
cp $60
ret nz
ld a, $01
ld [wObject2 + OBJ_STATE], a
ret"""), [])
        self.assertEqual(s, "Decrements wObject2 + OBJ_Y; returns unless wObject2 + OBJ_Y is $60; "
                            "sets wObject2 + OBJ_STATE to 1")

    def test_flags_messages_scripts_and_sounds(self):
        s = describe.summarize("X", self.body("""
ld de, EVENT_NEVER_SET
call TestFlagBit
ret c
ld hl, $0413 ; '0 checked the treasure chest. The'
call StartMessageCommand09HL_B13
ld hl, Script_HowMayWeServe ; script '*: How may we serve your'
call StartScriptAtHL_B13
ld a, $69
call QueueSoundEffect
ret"""), [])
        self.assertEqual(s, "Checks EVENT_NEVER_SET; may return early; shows '0 checked the treasure chest. The'; "
                            "starts Script_HowMayWeServe; plays sound $69")

    def test_high_ram_and_masked_values(self):
        s = describe.summarize("X", self.body("""
ldh a, [hJoyPressed]
and $0f
cp $03
ret nz
ldh [hTemp0], a
ld a, [wX]
add $02
cp $05
ret c
ret"""), [])
        self.assertEqual(s, "Returns unless hJoyPressed & $0f is $03; copies hJoyPressed & $0f to hTemp0; "
                            "may return early")

    def test_registers_are_not_ram(self):
        s = describe.summarize("X", self.body("ld [de], a\nld [hl], a\nret"), [])
        self.assertEqual(s, "Takes HL, DE and A")  # pointers and a value, but no RAM symbol

    def test_a_stale_caller_is_not_cited(self):
        s = describe.summarize("X", self.body("ret"), ["; only called from GoneRoutine (E-0047)"], {"Other"})
        self.assertEqual(s, "Returns at once")

    def test_data_note_names_its_reader_and_size(self):
        n = describe.data_note("Foo_Data", ["    db $01, $02", "    dw Bar"], {"Foo"})
        self.assertEqual(n, "data read by Foo (2 bytes, 1 word)")
        self.assertEqual(describe.data_note("Lonely", ["    db $00"], set()), "data block (1 byte)")


if __name__ == "__main__":
    unittest.main()
