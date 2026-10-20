#!/usr/bin/env python3
"""The game's text for translators: export from src/, reinsert, check widths; the font as a PNG (H3).

Every labelled block of `db` text lines in src/text/ is one entry: its label is its id. `export` writes them to a
JSON file a translator edits; `import` puts changed entries back into src/ (or a copy), re-rendered exactly as
src/ writes text (tools/gb_text.py), and makes each bank's trailing `ds` fill take up the change in length.

  export [--out FILE] [--src DIR]        JSON: {"entries": [{id, file, bank, kind, used_by, max_width, text}]}
  import FILE [--src DIR]                apply the changed entries; stops on an unknown character, a line too
                                         wide or a bank without room
  check [--src DIR]                      every entry re-renders to its own lines, and an unchanged import
                                         rewrites nothing
  font-export [--out PNG] [--src DIR]    GlyphFont (bank $1F, 185 glyphs $00-$B8) as a 16-glyph-wide PNG
  font-import PNG [--src DIR]            write the PNG's glyphs back into GlyphFont's db lines
  free-glyphs [--src DIR]                glyph codes no text uses and the charmap does not name: room for new
                                         letters (add a CHARMAP line in src/charmap.inc and draw the glyph)

A message bank too full for its translation: tools/text_spill.py (or "spill" in a mod's mod.json) moves its last
messages to the bank's overflow table, in a mod's copy of src/.

The text form: printer commands as tokens (<LINE>, <NEXT>, <PROMPT>, <PLAYER>, ... see src/charmap.inc), `@` for
the end, and an argument byte after a command as {$7e}. A line's width is the characters between line breaks
(<LINE>, <NEXT>, <CLEAR>, <HOME>, <CURSOR>); a contraction glyph ('s, 'm, ...) and "*:" are one cell; names a
token inserts (<PLAYER>, <BUF0>-<BUF3>) count as nothing, so leave room for them. Limits: 18 cells in message
and battle-text banks (the longest line the game has; the text window is 20 tiles with a border tile each side;
C1), and for other strings the longest original entry of the same list (C1, inferred).
"""
from __future__ import annotations

import argparse
import json
import re
import struct
import sys
import zlib
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import gb_text as T  # noqa: E402
from datatables import FILL as FILL_LINE, take_from_fill  # noqa: E402

LABEL = re.compile(r"^([A-Za-z_]\w*)::")
DB = re.compile(r"^    db (.*)$")
BREAKS = re.compile(r"<(?:LINE|NEXT|CLEAR|HOME)>|<CURSOR>(?:\{\$[0-9A-Fa-f]{2}\}){2}")
MESSAGE_WIDTH = 18
FONT_GLYPHS = 185


# ---- the charmap -----------------------------------------------------------------------------------------------

def load_charmap(src: Path) -> list[str]:
    """Add the single characters src/charmap.inc defines and tools/gb_text.py does not know (a translation's new
    letters: `CHARMAP "ü", $49`), so text using them parses and renders. Returns the characters added."""
    added = []
    inc = src / "charmap.inc"
    if not inc.exists():
        return added
    for ch, val in re.findall(r'^CHARMAP "([^"<>@]{1,2})", \$([0-9A-Fa-f]{2})\s*(?:;.*)?$',
                              inc.read_text(encoding="utf-8"), re.M):
        code = int(val, 16)
        if ch not in T.CHARMAP:
            T.CHARMAP[ch] = code
            T.BYTE_TO_TEXT.setdefault(code, ch)
            added.append(ch)
    return added


# ---- entries ---------------------------------------------------------------------------------------------------

def text_files(src: Path) -> list[Path]:
    """Every bank file with text: src/text/, and the strings and messages kept in code and data banks (E-0417). The
    home bank is left out: its one quoted block is the cartridge header."""
    return sorted(f for f in src.glob("*/bank[0-9a-f][0-9a-f]_*.asm") if f.parent.name != "home")


def split_comment(ops: str) -> tuple[str, str]:
    """A db operand list -> (operands, comment), splitting at the first ; outside a string."""
    quoted = False
    for i, c in enumerate(ops):
        if c == '"':
            quoted = not quoted
        elif c == ";" and not quoted:
            return ops[:i].rstrip(), ops[i:]
    return ops.rstrip(), ""


def to_text(lines: list[str]) -> str:
    """db operand lists -> the translator's text."""
    out = []
    for ops in lines:
        i = 0
        while i < len(ops):
            if ops[i] == '"':
                j = ops.index('"', i + 1)
                out.append(ops[i + 1:j])
                i = j + 1
            elif ops[i] == "$":
                out.append("{$" + ops[i + 1:i + 3].lower() + "}")
                i += 3
            else:
                i += 1
    return "".join(out)


def to_bytes(text: str) -> bytes:
    """The translator's text -> bytes (raises ValueError on an unknown character or token)."""
    out = bytearray()
    for piece in re.split(r"(\{\$[0-9A-Fa-f]{2}\})", text):
        if piece.startswith("{$"):
            out.append(int(piece[2:4], 16))
        elif piece:
            if '"' in piece:
                raise ValueError('a text cannot hold a double quote')
            try:
                out += T.parse('"' + piece + '"')
            except (KeyError, ValueError) as e:
                raise ValueError(f"{e} in {piece!r}") from None
    return bytes(out)


def render(raw: bytes) -> list[str]:
    """Bytes -> db operand lists, as src/ writes text (tools/gb_text.py, hex in lower case)."""
    return [re.sub(r"\$([0-9A-F]{2})\b", lambda m: "$" + m.group(1).lower(), ln) for ln in T.render(raw)]


def render_like(raw: bytes, old: list[str]) -> list[str]:
    """Bytes of a fixed-length entry -> db operand lists cut where the old lines were: a line of bytes stays bytes, and
    a string line is text up to its end mark, then bytes (the $f0 padding of a record's name field)."""
    out, k = [], 0
    for op in old:
        n = len(T.parse(op))
        seg, k = raw[k:k + n], k + n
        if '"' not in op:
            out.append(", ".join(f"${x:02x}" for x in seg))
            continue
        end = seg.index(0xF0) + 1 if 0xF0 in seg else len(seg)
        parts = render(seg[:end]) + [f"${x:02x}" for x in seg[end:]]
        out.append(", ".join(parts))
    return out


def widths(text: str) -> list[int]:
    """The width in cells of each line of a text."""
    out = []
    for part in BREAKS.split(text):
        vis = re.sub(r"\{\$[0-9A-Fa-f]{2}\}", "", part)
        vis = re.sub(r"<[^>]*>", "", vis).replace("@", "")
        vis = re.sub(r"'[smrtvl]", "x", vis).replace("*:", "x")
        out.append(len(vis))
    return out


def blocks(src: Path):
    """(file, label, first db line index, last db line index + 1, operand lists) for each text entry."""
    for f in text_files(src):
        L = f.read_text(encoding="utf-8").split("\n")
        i = 0
        while i < len(L):
            m = LABEL.match(L[i])
            if not m:
                i += 1
                continue
            j = i + 1
            ops = []
            while j < len(L) and (d := DB.match(L[j])):
                ops.append(split_comment(d.group(1))[0])
                j += 1
            if ops and any('"' in o for o in ops):
                yield f, m.group(1), i + 1, j, ops
            i = max(j, i + 1)


def fixed_lengths(src: Path) -> dict[str, int]:
    """Entries outside src/text/ whose byte length must not change -> that length (E-0417). An entry may change
    length only when the game finds it by its own label (a pointer list or a load names it), it ends with the end
    mark, and nothing but a label, a blank line, a comment, a fill or a new section follows it. Anything else may
    be a field of a record the game reads by position (the 10-byte names in PresetMonsterRecords), so an edit must
    keep its bytes."""
    named: set[str] = set()
    for f in sorted(src.glob("*/bank[0-9a-f][0-9a-f]_*.asm")):
        for ln in f.read_text(encoding="utf-8").split("\n"):
            code = ln.split(";")[0]
            if LABEL.match(code):
                code = code.split("::", 1)[1]
            named.update(re.findall(r"\b[A-Za-z_]\w*\b", code))
    out = {}
    lines: dict[Path, list[str]] = {}
    for f, label, a, b, ops in blocks(src):
        if f.parent.name == "text":
            continue
        L = lines.setdefault(f, f.read_text(encoding="utf-8").split("\n"))
        raw = b"".join(T.parse(o) for o in ops)
        nxt = L[b] if b < len(L) else ""
        ends = nxt == "" or nxt.startswith((";", "SECTION")) or LABEL.match(nxt) or FILL_LINE.match(nxt)
        if not (label in named and raw.endswith(b"\xf0") and ends):
            out[label] = len(raw)
    return out


def used_by(src: Path) -> dict[str, list[str]]:
    """label -> ["List[index]", ...] for every pointer-table entry that names it."""
    out: dict[str, list[str]] = {}
    for f in sorted(src.glob("*/bank[0-9a-f][0-9a-f]_*.asm")):
        cur = None
        for ln in f.read_text(encoding="utf-8").split("\n"):
            if m := LABEL.match(ln):
                cur, k = m.group(1), 0
                continue
            if cur and (m := re.match(r"^    dw (\w+)", ln)):
                out.setdefault(m.group(1), []).append(f"{cur}[{k}]")
                k += 1
    return out


def export(src: Path) -> dict:
    uses = used_by(src)
    fixed = fixed_lengths(src)
    entries = []
    for f, label, a, b, ops in blocks(src):
        text = to_text(ops)
        if f.parent.name == "text":
            kind = "message" if re.search(r"_(messages|battle_text)_?", f.name) else "string"
        else:  # a code or data bank: a message when it is dialogue (it waits for a button or speaks)
            kind = "message" if re.search(r"<(?:PROMPT|WAIT|VOICE\d)>", text) else "string"
        entries.append({"id": label, "file": f.relative_to(src).as_posix(), "bank": f"{int(f.name[4:6], 16):02X}",
                        "kind": kind, "used_by": uses.get(label, []), "text": text})
        if label in fixed:
            entries[-1]["fixed_bytes"] = fixed[label]
    # limits: 18 cells for messages; for a string, the longest original line of its list
    longest: dict[str, int] = {}
    for e in entries:
        for u in e["used_by"]:
            lst = u.split("[")[0]
            longest[lst] = max(longest.get(lst, 0), max(widths(e["text"])))
    for e in entries:
        if e["kind"] == "message":
            e["max_width"] = MESSAGE_WIDTH
        else:
            e["max_width"] = max([longest[u.split("[")[0]] for u in e["used_by"]] or [max(widths(e["text"]))])
    return {"format": "dwm2decomp text 1", "entries": entries}


def apply(src: Path, data: dict) -> dict[str, int]:
    """Write changed entries into the tree. Returns {"entries": n, "bytes": growth}."""
    want = {e["id"]: e for e in data["entries"]}
    by_file: dict[Path, list] = {}
    fixed = None
    for f, label, a, b, ops in blocks(src):
        e = want.get(label)
        if e is None or e["text"] == to_text(ops):
            continue
        raw = to_bytes(e["text"])
        wide = [w for w in widths(e["text"]) if w > e.get("max_width", MESSAGE_WIDTH)]
        if wide:
            raise ValueError(f"{label}: a line of {max(wide)} cells is wider than {e.get('max_width')}")
        old = b"".join(T.parse(o) for o in ops)
        if f.parent.name != "text":
            fixed = fixed_lengths(src) if fixed is None else fixed  # from the tree, not the translator's file
            if label in fixed and len(raw) != fixed[label]:
                raise ValueError(f"{label}: must stay {fixed[label]} bytes (it is {len(raw)}); it may be a field of a "
                                 f"record read by position, so pad it with end marks or shorten it")
            if label in fixed:
                by_file.setdefault(f, []).append((a, b, render_like(raw, ops), 0))
                continue
        by_file.setdefault(f, []).append((a, b, render(raw), len(raw) - len(old)))
    n = grew = 0
    for f, edits in by_file.items():
        L = f.read_text(encoding="utf-8").split("\n")
        delta = 0
        for a, b, new, d in sorted(edits, reverse=True):  # from the end, so earlier line numbers stay valid
            notes = [split_comment(DB.match(x).group(1))[1] for x in L[a:b]]
            lines = ["    db " + x for x in new]
            if len(notes) == len(lines):  # keep each line's comment
                lines = [x + (" " + c if c else "") for x, c in zip(lines, notes)]
            elif any(notes):
                lines[0] += " ; " + " / ".join(c.lstrip("; ") for c in notes if c)
            L[a:b] = lines
            delta += d
            n += 1
        try:
            take_from_fill(L, delta, f.name)
        except ValueError as e:
            raise ValueError(f"{e}; for a message bank, tools/text_spill.py moves its last messages to its overflow "
                             f"bank") from None
        f.write_text("\n".join(L), encoding="utf-8", newline="\n")
        grew += delta
    return {"entries": n, "bytes": grew}


def relayout(src: Path) -> list[str]:
    """Entries whose bytes re-render to other lines (same bytes): on 2026-10-17 two, Message_0B_8F and
    String_88_02_AD, whose blocks end in raw bytes after their end mark that read as text. An edit re-renders them."""
    return [label for _f, label, _a, _b, ops in blocks(src) if render(b"".join(T.parse(o) for o in ops)) != ops]


def check(src: Path) -> list[str]:
    """Problems: an entry whose text form does not give back its bytes, or an unchanged import that rewrites."""
    problems = []
    for f, label, a, b, ops in blocks(src):
        raw = b"".join(T.parse(o) for o in ops)
        if to_bytes(to_text(ops)) != raw or b"".join(T.parse(o) for o in render(raw)) != raw:
            problems.append(f"{label}: its text form does not give back its bytes")
    import shutil
    import tempfile
    with tempfile.TemporaryDirectory() as t:
        copy = Path(t) / "src"
        shutil.copytree(src, copy)
        res = apply(copy, export(copy))
        if res["entries"]:
            problems.append(f"an unchanged import rewrote {res['entries']} entries")
        for f in text_files(src):
            if (copy / f.relative_to(src)).read_bytes() != f.read_bytes():
                problems.append(f"{f.name} changed")
    return problems


# ---- the font --------------------------------------------------------------------------------------------------

def font_lines(src: Path) -> tuple[Path, list[str], list[int]]:
    """GlyphFont's file, lines, and the line index of each of its 185 glyphs (16-byte rows, even bytes $ff)."""
    f = next(src.glob("*/bank1f_*.asm"))
    L = f.read_text(encoding="utf-8").split("\n")
    i = L.index("GlyphFont::")
    rows = []
    for k in range(i + 1, len(L)):
        if len(rows) == FONT_GLYPHS:
            break
        if L[k].startswith("    db $ff,") and L[k].split(";")[0].count("$") == 16:
            rows.append(k)
        elif L[k].startswith("    ") and not L[k].strip().startswith(("ASSERT", ";")):
            raise ValueError(f"GlyphFont: unexpected line {k + 1}: {L[k].strip()}")
    return f, L, rows


def glyph_rows(line: str) -> list[int]:
    vals = [int(v.strip()[1:], 16) for v in line.split(";")[0].split("db", 1)[1].split(",")]
    return vals[1::2]  # the odd bytes hold the pixels; the even ones are $ff


def write_png(path: Path, width: int, height: int, gray: bytes) -> None:
    def chunk(t, d):
        return struct.pack(">I", len(d)) + t + d + struct.pack(">I", zlib.crc32(t + d) & 0xFFFFFFFF)
    raw = b"".join(b"\x00" + gray[y * width:(y + 1) * width] for y in range(height))
    path.write_bytes(b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", struct.pack(">IIBBBBB", width, height, 8, 0, 0, 0, 0))
                     + chunk(b"IDAT", zlib.compress(raw, 9)) + chunk(b"IEND", b""))


def read_png(path: Path) -> tuple[int, int, list[list[int]]]:
    """8-bit gray, gray+alpha, RGB, RGBA or palette PNG -> rows of brightness 0-255 (non-interlaced)."""
    data = path.read_bytes()
    if data[:8] != b"\x89PNG\r\n\x1a\n":
        raise ValueError(f"{path}: not a PNG")
    p, idat, plte = 8, b"", b""
    while p < len(data):
        n = struct.unpack(">I", data[p:p + 4])[0]
        t, body = data[p + 4:p + 8], data[p + 8:p + 8 + n]
        if t == b"IHDR":
            w, h, depth, ctype, _c, _f, inter = struct.unpack(">IIBBBBB", body)
        elif t == b"PLTE":
            plte = body
        elif t == b"IDAT":
            idat += body
        p += 12 + n
    if depth != 8 or inter:
        raise ValueError(f"{path}: use an 8-bit, non-interlaced PNG")
    bpp = {0: 1, 2: 3, 3: 1, 4: 2, 6: 4}[ctype]
    raw = zlib.decompress(idat)
    stride = w * bpp
    rows, prev, k = [], bytearray(stride), 0
    for _y in range(h):
        ft, line = raw[k], bytearray(raw[k + 1:k + 1 + stride])
        k += 1 + stride
        for x in range(stride):
            a = line[x - bpp] if x >= bpp else 0
            b, c = prev[x], prev[x - bpp] if x >= bpp else 0
            if ft == 1:
                line[x] = (line[x] + a) & 0xFF
            elif ft == 2:
                line[x] = (line[x] + b) & 0xFF
            elif ft == 3:
                line[x] = (line[x] + (a + b) // 2) & 0xFF
            elif ft == 4:
                pa, pb, pc = abs(b - c), abs(a - c), abs(a + b - 2 * c)
                line[x] = (line[x] + (a if pa <= pb and pa <= pc else b if pb <= pc else c)) & 0xFF
        prev = line
        px = []
        for x in range(w):
            q = line[x * bpp:(x + 1) * bpp]
            if ctype == 3:
                q = plte[3 * q[0]:3 * q[0] + 3]
            px.append(sum(q[:3]) // len(q[:3]) if ctype in (2, 3, 6) else q[0])
        rows.append(px)
    return w, h, rows


def font_export(src: Path, out: Path) -> None:
    _f, L, rows = font_lines(src)
    cols, nrows = 16, (FONT_GLYPHS + 15) // 16
    w, h = cols * 8, nrows * 8
    img = bytearray([0x80] * (w * h))  # grey where no glyph is
    for g, k in enumerate(rows):
        gx, gy = g % cols * 8, g // cols * 8
        for y, bits in enumerate(glyph_rows(L[k])):
            for x in range(8):
                img[(gy + y) * w + gx + x] = 0x00 if bits & (0x80 >> x) else 0xFF
    write_png(out, w, h, bytes(img))


def font_import(src: Path, png: Path) -> int:
    """Write the glyphs of the PNG (dark pixels set) into GlyphFont. Returns the number of glyphs changed."""
    f, L, rows = font_lines(src)
    w, h, px = read_png(png)
    if (w, h) != (128, 96):
        raise ValueError(f"{png}: expected 128 x 96 (16 x 12 glyphs of 8 x 8), got {w} x {h}")
    changed = 0
    for g, k in enumerate(rows):
        gx, gy = g % 16 * 8, g // 16 * 8
        bits = [sum(0x80 >> x for x in range(8) if px[gy + y][gx + x] < 0x80) for y in range(8)]
        if bits == glyph_rows(L[k]):
            continue
        comment = L[k][L[k].index(";"):] if ";" in L[k] else ""
        L[k] = "    db " + ", ".join(f"$ff, ${b:02x}" for b in bits) + (" " + comment if comment else "")
        changed += 1
    if changed:
        f.write_text("\n".join(L), encoding="utf-8", newline="\n")
    return changed


def free_glyphs(src: Path) -> list[tuple[int, bool]]:
    """(code, blank) for glyph codes $00-$B8 that no text uses and the charmap does not name."""
    used = set()
    for _f, _label, _a, _b, ops in blocks(src):
        used |= set(b"".join(T.parse(o) for o in ops))
    _f, L, rows = font_lines(src)
    named = set(T.CHARMAP.values())
    return [(g, not any(glyph_rows(L[k]))) for g, k in enumerate(rows) if g not in used and g not in named]


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("command", choices=["export", "import", "check", "font-export", "font-import", "free-glyphs"])
    ap.add_argument("file", nargs="?", type=Path)
    ap.add_argument("--out", type=Path)
    ap.add_argument("--src", type=Path, default=ROOT / "src")
    a = ap.parse_args(argv)
    load_charmap(a.src)
    if a.command == "export":
        out = a.out or ROOT / "build/text/en.json"
        out.parent.mkdir(parents=True, exist_ok=True)
        data = export(a.src)
        out.write_text(json.dumps(data, indent=1, ensure_ascii=False) + "\n", encoding="utf-8", newline="\n")
        print(f"{len(data['entries'])} entries to {out}")
    elif a.command == "import":
        res = apply(a.src, json.loads(a.file.read_text(encoding="utf-8")))
        print(f"{res['entries']} entries rewritten; text grew by {res['bytes']} bytes")
    elif a.command == "check":
        problems = check(a.src)
        print("text round trip: " + ("identical" if not problems else f"{len(problems)} problems"))
        for p in problems[:20]:
            print("  " + p)
        return 1 if problems else 0
    elif a.command == "font-export":
        out = a.out or ROOT / "build/text/font.png"
        out.parent.mkdir(parents=True, exist_ok=True)
        font_export(a.src, out)
        print(out)
    elif a.command == "font-import":
        print(f"{font_import(a.src, a.file)} glyphs changed")
    else:
        free = free_glyphs(a.src)
        print(f"{len(free)} free glyph codes: " + ", ".join(f"${g:02X}{' (blank)' if blank else ''}" for g, blank in free))
    return 0


if __name__ == "__main__":
    sys.exit(main())
