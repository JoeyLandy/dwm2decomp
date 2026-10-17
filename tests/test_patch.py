"""tools/patch.py, patcher/index.html and tools/make_mod.py: a mod shared as a patch (H6, E-0412).

The H6 gate's checks that can run here: the example mod (mods/example) is built from a clean copy of src/ by
tools/make_mod.py, its BPS patch applied to the reference gives the mod build byte for byte (with tools/patch.py,
and with the browser patcher's own code under Node.js), and a wrong ROM or a damaged patch is refused.
"""
import json
import shutil
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import patch as P  # noqa: E402

REF = ROOT / "local/roms/dwm2-cobi-us.gbc"
NODE = shutil.which("node")
RUN_JS = """
const fs = require("fs"), vm = require("vm");
const html = fs.readFileSync(process.argv[2], "utf8");
const js = html.split("<script>")[1].split("</script>")[0];
const ctx = { module: { exports: {} }, TextDecoder, Uint8Array, Uint32Array, Error, String, Math };
vm.createContext(ctx); vm.runInContext(js, ctx);
const { applyBps } = ctx.module.exports;
const src = new Uint8Array(fs.readFileSync(process.argv[3])), patch = new Uint8Array(fs.readFileSync(process.argv[4]));
try { fs.writeFileSync(process.argv[5], Buffer.from(applyBps(src, patch))); console.log("ok"); }
catch (e) { console.log("refused: " + e.message); }
"""


class Format(unittest.TestCase):
    def test_numbers_round_trip(self):
        for n in (0, 1, 127, 128, 129, 16511, 16512, 1 << 22, 4194304):
            enc = P.encode_number(n)
            self.assertEqual(P.decode_number(enc, 0), (n, len(enc)))

    def test_make_and_apply_with_moved_data(self):
        src = bytes(range(256)) * 64
        tgt = bytearray(src)
        tgt[100:104] = b"ABCD"
        tgt[5000:9000] = b"\x01\x02\x03" + src[5000:8997]  # three bytes inserted: the rest moves
        tgt = bytes(tgt) + b"tail"
        p = P.make(src, tgt, "test")
        self.assertEqual(P.apply(src, p), tgt)
        self.assertLess(len(p), 200)
        self.assertEqual(P.parse_header(p)["metadata"], "test")

    def test_refusals(self):
        src, tgt = b"original data " * 50, b"modified data " * 50
        p = P.make(src, tgt)
        with self.assertRaises(ValueError):
            P.apply(tgt, p)  # not the ROM the patch was made for
        bad = bytearray(p)
        bad[10] ^= 0x40
        with self.assertRaises(ValueError):
            P.apply(src, bytes(bad))  # damaged
        with self.assertRaises(ValueError):
            P.apply(src, b"IPS1" + p[4:])


@unittest.skipUnless(REF.exists() and __import__("toolchain").installed(), "needs the reference ROM and RGBDS")
class ExampleMod(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.tmp = tempfile.TemporaryDirectory(dir=ROOT / "build")
        cls.out = Path(cls.tmp.name) / "example"
        cls.proc = subprocess.run([sys.executable, "-I", str(ROOT / "tools/make_mod.py"), str(ROOT / "mods/example"),
                                   "--out", str(cls.out), "--frames", "600"], cwd=ROOT, capture_output=True, text=True)

    @classmethod
    def tearDownClass(cls):
        cls.tmp.cleanup()

    def test_it_builds_and_passes_the_smoke_test(self):
        self.assertEqual(self.proc.returncode, 0, self.proc.stdout + self.proc.stderr)
        rep = json.loads((self.out / "report.json").read_text(encoding="utf-8"))
        self.assertEqual(rep["done"], ["data: 1 lines and 0 lists", "text en.json: 1 entries, +1 bytes"])
        self.assertIsNone(rep["smoke_test"]["crash"])
        self.assertIsNone(rep["smoke_test"]["progress"])

    def test_the_patch_gives_the_mod_byte_for_byte(self):
        ref, mod = REF.read_bytes(), (self.out / "example.gbc").read_bytes()
        self.assertNotEqual(ref, mod)
        self.assertEqual(P.apply(ref, (self.out / "example.bps").read_bytes()), mod)
        self.assertEqual(mod, (self.out / "build/dwm2.gbc").read_bytes())

    @unittest.skipUnless(NODE, "Node.js not installed")
    def test_the_browser_patcher_gives_the_same_rom(self):
        js = self.out / "run.js"
        js.write_text(RUN_JS, encoding="utf-8")
        got = self.out / "from_browser_code.gbc"
        r = subprocess.run([NODE, str(js), str(ROOT / "patcher/index.html"), str(REF), str(self.out / "example.bps"),
                            str(got)], capture_output=True, text=True)
        self.assertEqual(r.stdout.strip(), "ok", r.stderr)
        self.assertEqual(got.read_bytes(), (self.out / "example.gbc").read_bytes())
        r = subprocess.run([NODE, str(js), str(ROOT / "patcher/index.html"), str(self.out / "example.gbc"),
                            str(self.out / "example.bps"), str(self.out / "twice.gbc")], capture_output=True, text=True)
        self.assertTrue(r.stdout.startswith("refused"), r.stdout)  # a patched ROM is not the original


if __name__ == "__main__":
    unittest.main()
