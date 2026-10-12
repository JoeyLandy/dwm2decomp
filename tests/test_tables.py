"""Checks config/tables.json against the reference ROM and the generated source."""
import json
import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
REF = ROOT / "local" / "roms" / "dwm2-cobi-us.gbc"
CFG = json.loads((ROOT / "config" / "tables.json").read_text(encoding="utf-8"))["tables"]
BANK = 0x4000


def off(bank: int, addr: int) -> int:
    return addr if addr < 0x4000 else bank * BANK + addr - 0x4000


@unittest.skipUnless(REF.exists(), "reference ROM not present")
class SoundTables(unittest.TestCase):
    def setUp(self):
        self.rom = REF.read_bytes()
        self.by_label = {t["label"]: t for t in CFG}

    def test_bank_table_names_the_record_arrays(self):
        t = self.by_label["SoundBankTable"]
        base = int(t["addr"], 16)
        entries = [self.rom[base + 4 * i:base + 4 * i + 4] for i in range(t["count"])]
        got = [(e[0], e[1] | (e[2] << 8), e[3]) for e in entries]
        want = []
        for rec in CFG:
            if rec["label"].startswith("SoundRecords_"):
                want.append((rec["id_base"], int(rec["addr"], 16), int(rec["bank"], 16)))
        self.assertEqual(got, want)
        self.assertEqual(self.rom[base + 16], 0xFF, "the table ends with a first byte of $FF")

    def test_id_ranges_are_contiguous(self):
        recs = [t for t in CFG if t["label"].startswith("SoundRecords_")]
        for a, b in zip(recs, recs[1:]):
            self.assertEqual(a["id_base"] + a["count"], b["id_base"], f"{a['label']} -> {b['label']}")

    def test_every_record_is_regular_and_streams_follow_the_array(self):
        for t in CFG:
            if not t["label"].startswith("SoundRecords_"):
                continue
            bank, addr, n = int(t["bank"], 16), int(t["addr"], 16), t["count"]
            end = addr + 4 * n
            self.assertEqual(self.rom[off(bank, 0x4000)], bank, "byte 0 of a bank is its own number")
            for i in range(n):
                r = self.rom[off(bank, addr) + 4 * i:off(bank, addr) + 4 * i + 4]
                ptr = r[2] | (r[3] << 8)
                self.assertTrue(r[0] % 0x20 == 0 and r[0] < 0xC0, f"{t['label']}[{i}] slot offset {r[0]:02X}")
                self.assertTrue(end <= ptr < 0x8000, f"{t['label']}[{i}] pointer {ptr:04X}")

    def test_bank_43_record_array_ends_where_the_layout_says(self):
        # the record after the last one in the layout is not a regular record
        t = self.by_label["SoundRecords_Bank43"]
        bank, addr, n = int(t["bank"], 16), int(t["addr"], 16), t["count"]
        r = self.rom[off(bank, addr) + 4 * n:off(bank, addr) + 4 * n + 4]
        self.assertFalse(r[0] % 0x20 == 0 and r[0] < 0xC0 and 0x4000 <= (r[2] | (r[3] << 8)) < 0x8000)


SRC = ROOT / "src" / "banks"


@unittest.skipUnless(SRC.is_dir(), "src/banks has not been generated")
class GeneratedTables(unittest.TestCase):
    def test_source_carries_every_layout(self):
        text = {f.name: f.read_text(encoding="utf-8") for f in SRC.glob("bank*.asm")}
        for t in CFG:
            f = f"bank{int(t['bank'], 16):02x}.asm"
            self.assertIn(f"{t['label']}::", text[f], t["label"])
        ids = sum(len(re.findall(r"; id \d+(:|$)", text[f"bank{b:02x}.asm"], re.M)) for b in (0x40, 0x41, 0x42, 0x43))
        self.assertEqual(ids, sum(t["count"] for t in CFG if t["label"].startswith("SoundRecords_")))

    def test_sound_tracks_are_emitted_as_events(self):
        headers = events = 0
        for b in (0x40, 0x41, 0x42, 0x43):
            lines = (SRC / f"bank{b:02x}.asm").read_text(encoding="utf-8").splitlines()
            for i, line in enumerate(lines):
                if "; header: param=" in line:
                    headers += 1
                    self.assertTrue(any(l.startswith("; sound track,") for l in lines[max(0, i - 3):i]), line)
                if re.match(r"\s+db \$[0-9A-F]{2}(, \$[0-9A-F]{2})? ; (note|rest-note|set|label|end|jump|repeat|call|env|step|volume|duty|mod|pan|wait|param|counter|slide|tuning|instrument|mastervol|duty2|skip|return)", line):
                    events += 1
        self.assertGreaterEqual(headers, 200)
        self.assertGreater(events, 25000)


if __name__ == "__main__":
    unittest.main()
