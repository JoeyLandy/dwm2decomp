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
                if kind == "code" and doc_coverage.GAP.search(comment.split("; why: ")[0]) and "; code:" not in comment]
        self.assertEqual(gaps[:10], [])

    def test_comments_name_only_labels_symbols_and_constants(self):
        self.assertEqual(dict(doc_coverage.stale_names(FILES).most_common(10)), {})

    def test_every_routine_comment_and_table_header_cites_evidence(self):
        """E-0350: a routine's comment and the header comment of each table cite an evidence or decision id."""
        import re
        missing = []
        for f in FILES:
            header = False
            for name, kind, comment, line, _ in doc_coverage.scan(f):
                if kind == "code":
                    header = False
                    if comment and not re.search(r"[ED]-\d{3,4}", comment):
                        missing.append(f"{f.name}:{line} {name}")
                elif comment and not header:
                    header = True
                    if not re.search(r"[ED]-\d{3,4}", comment):
                        missing.append(f"{f.name}:{line} {name}")
        self.assertEqual(missing[:10], [], f"{len(missing)} comments cite no evidence")

    def test_every_restated_routine_says_what_it_is_for(self):
        """E-0352: a routine documented by a restatement (E-0347) also has a `why:` line: the jumptable step, helper,
        part or copy it is, and what the documented routine it serves does."""
        missing = [f"{f.name}:{line} {name}" for f in FILES for name, kind, comment, line, _ in doc_coverage.scan(f)
                   if kind == "code" and comment.rstrip().endswith("(E-0347)") and "; code:" not in comment
                   and "; why: " not in comment]
        self.assertEqual(missing[:10], [], f"{len(missing)} restated routines without a purpose")

    def test_hand_written_notes_replace_restatements(self):
        """E-0357 through E-0361: a routine read by hand carries its note from config/annotations.json instead of
        the generated restatement, and the number of routines described only by a restatement never grows. Lower
        RESTATED_AT_MOST as notes are added."""
        RESTATED_AT_MOST = 569
        hand, restated = doc_coverage.note_counts(FILES)
        self.assertLessEqual(restated, RESTATED_AT_MOST, f"{restated} restated routines (was at most {RESTATED_AT_MOST})")
        self.assertGreaterEqual(hand, 4588)
        import json
        ann = json.loads((ROOT / "config/annotations.json").read_text(encoding="utf-8"))
        hand_keys = [k for k, v in ann.items() if not k.startswith("_") and doc_coverage.HAND_NOTE.search(v)]
        self.assertEqual(len(hand_keys), hand, "every hand-written note sits above exactly one code label")

    def test_purpose_lines_quote_notes_that_say_what_a_routine_is_for(self):
        """E-0354: no purpose line quotes a note that only names its routine's dispatch ("runs the routine for X")."""
        import re
        import present
        thin = []
        for f in FILES:
            for name, kind, comment, line, _ in doc_coverage.scan(f):
                if "; why: " in comment:
                    m = re.search(r"(\w+): (.*?) \(E-0352", comment.split("; why: ")[1].replace("; ", " "))
                    if m and present.THIN_NOTE.search(m.group(2)):
                        thin.append(f"{f.name}:{line} {name} quotes {m.group(1)}")
        self.assertEqual(thin[:10], [], f"{len(thin)} purpose lines quote a thin note")

    def test_no_operand_is_a_bare_address(self):
        """E-0350: no `ld rr, $XXXX`, `call $XXXX` or `jp $XXXX` with an address-like number is left: pointers name
        their label, values are written as what they are (lb pairs, signed or decimal numbers, named constants)."""
        import readability
        self.assertEqual(readability.measure()["raw_pointer_operands"], 0)


class Purposes(unittest.TestCase):
    """tools/present.py Names.purpose: why a routine without a written note exists (E-0352)."""

    TEXT = ("; runs the inn (E-0001)\nInn::\n    ld a, [wScreenState]\n    rst $00\n    dw Inn_Step\n\n"
            "; entry 0 of the `rst $00` table in Inn\nInn_Step::\n    call Inn_Step_Helper\n    ret\n\n"
            "; only called from Inn_Step (E-0047)\nInn_Step_Helper::\n    ret\n\nInn_Step_Skip::\n    ret\n")

    def setUp(self):
        import present
        self.names = present.Names({"bank01.asm": self.TEXT})

    def test_a_step_names_its_dispatch_byte_and_its_documented_owner(self):
        self.assertEqual(self.names.purpose("Inn_Step"),
                         "step 0 of Inn (when wScreenState = 0); Inn: runs the inn (E-0352, E-0001)")

    def test_helpers_and_parts_follow_the_chain_to_a_written_note(self):
        self.assertEqual(self.names.purpose("Inn_Step_Helper"),
                         "a helper of Inn_Step, in step 0 of Inn (when wScreenState = 0); Inn: runs the inn "
                         "(E-0352, E-0001)")
        self.assertTrue(self.names.purpose("Inn_Step_Skip").startswith("part of Inn_Step, in step 0 of Inn"))

    def test_nothing_documented_means_no_purpose(self):
        self.assertEqual(self.names.purpose("Unrelated"), "")


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
