#!/usr/bin/env python3
"""The game's text encoding: character table, text-run detection and rendering (E-0024).

Observed table (C2; decoded passages read as ordinary sentences):
    $00-$09 digits   $0A-$23 'A'-'Z'   $24-$3D 'a'-'z'   $90 space
    $B5 '.'  $AB ','  $99 '!'  $98 '?'  $9C '-'
    $3E "'s"  $3F "'m"  $40 "'r"  $41 "'t"  $43 "'l"     (single contraction glyphs)
Other bytes between words ($EA-$EF, $F0-$FA, $A3, $A4, $95, ...) are control or glyph codes
whose meaning is NOT established; they are kept as raw bytes. `render` therefore never changes
a byte: every string character maps back to the byte it came from.
"""
from __future__ import annotations

CHARMAP: dict[str, int] = {}
for _i in range(10):
    CHARMAP[str(_i)] = _i
for _i in range(26):
    CHARMAP[chr(ord("A") + _i)] = 0x0A + _i
    CHARMAP[chr(ord("a") + _i)] = 0x24 + _i
CHARMAP.update({" ": 0x90, ".": 0xB5, ",": 0xAB, "!": 0x99, "?": 0x98, "-": 0x9C,
                "'s": 0x3E, "'m": 0x3F, "'r": 0x40, "'t": 0x41, "'l": 0x43})
BYTE_TO_TEXT = {v: k for k, v in CHARMAP.items()}

LETTERS = set(range(0x0A, 0x3E)) | {0x90}
PUNCT = {0x3E, 0x3F, 0x40, 0x41, 0x42, 0x43, 0x95, 0x98, 0x99, 0x9C, 0xA3, 0xA4, 0xAB, 0xB5}
CONTROL = {0xEA, 0xEB, 0xEC, 0xED, 0xEE, 0xEF, 0xF0, 0xF1, 0xF2, 0xF7, 0xF9, 0xFA}
BREAK_AFTER = {0xF7, 0xF1}  # a rendered line ends after these (layout only)


def _score(b: int) -> float:
    if b in LETTERS:
        return 1.0
    if b in PUNCT or b in CONTROL:
        return 0.8
    if b < 10:
        return 0.5
    return 0.0


def find_text_runs(raw: bytes, window: int = 24, min_len: int = 24):
    """Return [(start, end)] offsets of prose-like runs in `raw`.

    A window is prose when its average score is >= 0.72 and it holds at least two spaces
    (tile and map data in the letter range has none). Runs grow while bytes stay text-like,
    are trimmed to start and end on a letter, punctuation or control byte, and must be at
    least `min_len` long."""
    n = len(raw)
    if n < min_len:
        return []
    marks = bytearray(n)
    sc = [_score(b) for b in raw]
    total = sum(sc[:window])
    spaces = sum(1 for b in raw[:window] if b == 0x90)
    for p in range(0, n - window + 1):
        if total / window >= 0.72 and spaces >= 2:
            for k in range(p, p + window):
                marks[k] = 1
        if p + window < n:
            total += sc[p + window] - sc[p]
            spaces += (raw[p + window] == 0x90) - (raw[p] == 0x90)
    runs, i = [], 0
    while i < n:
        if not marks[i]:
            i += 1
            continue
        j = i
        while j < n and sc[j] >= 0.5:
            j += 1
        s, e = i, j
        while s > 0 and sc[s - 1] >= 0.5 and marks[s - 1] == 0:
            s -= 1
        while s < e and sc[s] < 0.8:
            s += 1
        while e > s and sc[e - 1] < 0.8:
            e -= 1
        if e - s >= min_len:
            runs.append((s, e))
        i = max(j, i + 1)
    merged = []
    for s, e in runs:
        if merged and s <= merged[-1][1]:
            merged[-1] = (merged[-1][0], max(e, merged[-1][1]))
        else:
            merged.append((s, e))
    # Prose has spaces; drop letter-range runs that do not (tile and map data).
    return [(s, e) for s, e in merged if sum(1 for b in raw[s:e] if b == 0x90) >= 0.06 * (e - s)]


def render(raw: bytes, max_chars: int = 60) -> list[str]:
    """Render bytes as `db` operand lists: string literals for mapped characters and `$XX`
    for everything else, breaking lines after $F7 / $F1 and every ~`max_chars` characters."""
    lines: list[str] = []
    parts: list[str] = []
    cur: list[str] = []
    width = 0

    def flush_str():
        nonlocal cur
        if cur:
            parts.append('"' + "".join(cur) + '"')
            cur = []

    def flush_line():
        nonlocal parts, width
        flush_str()
        if parts:
            lines.append(", ".join(parts))
        parts, width = [], 0

    for b in raw:
        if b in BYTE_TO_TEXT:
            cur.append(BYTE_TO_TEXT[b])
            width += len(BYTE_TO_TEXT[b])
            if width >= max_chars:
                flush_line()
        else:
            flush_str()
            parts.append(f"${b:02X}")
            width += 3
            if b in BREAK_AFTER or width >= max_chars:
                flush_line()
    flush_line()
    return lines


def parse(operands: str) -> bytes:
    """Inverse of `render` for one line (used by tests): parse a `db` operand list."""
    out = bytearray()
    i = 0
    while i < len(operands):
        c = operands[i]
        if c == '"':
            j = operands.index('"', i + 1)
            s = operands[i + 1:j]
            k = 0
            while k < len(s):
                for L in (2, 1):  # longest match first: "'s" before a single character
                    if s[k:k + L] in CHARMAP:
                        out.append(CHARMAP[s[k:k + L]])
                        k += L
                        break
                else:
                    raise ValueError(f"unmapped character {s[k]!r}")
            i = j + 1
        elif c == "$":
            out.append(int(operands[i + 1:i + 3], 16))
            i += 3
        else:
            i += 1  # ", " separators
    return bytes(out)


def write_charmap_inc(path) -> None:
    lines = ["; Text encoding (E-0024). Letters, digits, space and the punctuation and contraction",
             "; glyphs below are the only characters used in db strings; every other byte stays $XX.", ""]
    for text, code in sorted(CHARMAP.items(), key=lambda kv: kv[1]):
        lines.append(f'CHARMAP "{text}", ${code:02X}')
    path.write_text("\n".join(lines) + "\n", encoding="utf-8", newline="\n")
