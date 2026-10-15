"""Routine probes (D-012): each probe in config/probes/*.json runs one routine of the reference ROM on tools/sm83.py
from a chosen state and checks the registers, flags and RAM its note describes. A passing probe is the emulator
observation that raises that note's mechanical claims to C2 (our emulator, not hardware). Skipped without the
reference ROM."""
import json
import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import probe  # noqa: E402

PROBES = sorted((ROOT / "config/probes").glob("*.json"))


@unittest.skipUnless(probe.ROM.is_file(), "reference ROM not present")
class Runner(unittest.TestCase):
    """The runner itself: a right expectation passes, a wrong one fails, a routine that does not return fails."""

    @classmethod
    def setUpClass(cls):
        cls.rom = probe.ROM.read_bytes()
        cls.mul = {"id": "t", "label": "Multiply8By16", "bank": "00", "address": "16AA", "regs": {"a": 3, "b": 1, "c": 2}}

    def test_a_true_claim_passes(self):
        self.assertEqual(probe.run(dict(self.mul, expect={"regs": {"e": 0, "h": 3, "l": 6}}), self.rom), [])

    def test_a_false_claim_fails(self):
        self.assertEqual(probe.run(dict(self.mul, expect={"regs": {"l": 7}}), self.rom), ["l = $06, expected $07"])

    def test_memory_and_flags_are_compared(self):
        bad = probe.run(dict(self.mul, mem={"C0A0": 9}, expect={"mem": {"C0A0": 8}, "flags": {"n": True}}), self.rom)  # rl b clears N
        self.assertEqual(len(bad), 2, bad)

    def test_a_routine_that_does_not_return_fails(self):
        self.assertEqual(probe.run(dict(self.mul, max_steps=3), self.rom), ["did not return"])


@unittest.skipUnless(probe.ROM.is_file() and PROBES, "reference ROM or probe files not present")
class Probes(unittest.TestCase):
    def test_every_probe_passes(self):
        rom = probe.ROM.read_bytes()
        probes = probe.load(PROBES)
        ids = [p["id"] for p in probes]
        self.assertEqual(len(ids), len(set(ids)), "probe ids are unique")
        failed = [f"{p['id']}: {'; '.join(bad)}" for p in probes if (bad := probe.run(p, rom))]
        self.assertEqual(failed[:20], [], f"{len(failed)} of {len(probes)} probes fail")


if __name__ == "__main__":
    unittest.main()
