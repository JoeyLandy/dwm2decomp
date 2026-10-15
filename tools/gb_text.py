#!/usr/bin/env python3
"""The game's text encoding: character table, text-run detection and rendering (E-0024).

Observed table (C2; decoded passages read as ordinary sentences):
    $00-$09 digits   $0A-$23 'A'-'Z'   $24-$3D 'a'-'z'   $90 space
    $B5 '.'  $AB ','  $99 '!'  $98 '?'  $9C '-'
    $3E "'s"  $3F "'m"  $40 "'r"  $41 "'t"  $42 "'v"  $43 "'l"     (single contraction glyphs;
    $42 C2 from E-0319: tools/screen.py pictures "We've" where the bytes are "We", $42, "e")
    $95 "'"  (C2 from E-0319: the name-entry keyboard pictures it as an apostrophe, and text reads
             "oasis' water", "Girls' clothes"; before s/m/r/t/v/l it stays $95, which would
             otherwise re-encode as a contraction glyph)
    $A3 ":"  $45 "*:"  (C2 from E-0320: the debug menu pictures "1:GOTO PROGRAM" for "1", $A3, "GOTO PROGRAM";
             $45 is one character cell holding an asterisk and a colon, the mark before an unnamed
             speaker's words: $EA, $45, " GreatLog's King" is drawn "*: GreatLog's King")
Bytes $E0-$FF are the text printer's commands (E-0336): PrintTextStep hands each to
the 32-entry code table of RunTextCommand. TOKENS names them;
`render` writes them as charmap tokens (`<LINE>`, `<PROMPT>`, `@` for the $F0 terminator, ...) and
an argument byte after its code as `$XX`. Other bytes ($A4, $8D, $8E, ...) stay raw. `render` never
changes a byte: every string character and token maps back to the bytes it came from.
"""
from __future__ import annotations

CHARMAP: dict[str, int] = {}
for _i in range(10):
    CHARMAP[str(_i)] = _i
for _i in range(26):
    CHARMAP[chr(ord("A") + _i)] = 0x0A + _i
    CHARMAP[chr(ord("a") + _i)] = 0x24 + _i
CHARMAP.update({" ": 0x90, ".": 0xB5, ",": 0xAB, "!": 0x99, "?": 0x98, "-": 0x9C,
                "'s": 0x3E, "'m": 0x3F, "'r": 0x40, "'t": 0x41, "'v": 0x42, "'l": 0x43, "'": 0x95,
                ":": 0xA3, "*:": 0x45})
# E-0336 (C2): read from the font itself (bank $1F, 8 one-bit rows per glyph at $4010 + 16 * glyph, the odd bytes)
CHARMAP.update({"…": 0xA4, "(": 0xA0, ")": 0xA1, "+": 0xA2, "~": 0x9D, "/": 0x9E, "★": 0xAC, "©": 0xB8})
BYTE_TO_TEXT = {v: k for k, v in CHARMAP.items()}

# Text printer commands (E-0336): (bytes, token, argument bytes after them, what the handler does). C2 where
# tools/text_check.py observed it (the glyph timing of the text speed, <WAIT> holding until a button, <NEXT>,
# <LINE>, <BUF0>-<BUF3>, @); the rest is a reading of the handler (C1). Pairs come first: render prefers them.
TOKENS: list[tuple[bytes, str, int, str]] = [
    (b"\xEF\xEE", "<NEXT>", 0, "next line: on the first line moves to the second; on the second scrolls it up, "
                                "waits 4 frames and clears it (C2)"),
    (b"\xFA\xF7", "<PROMPT>", 0, "blinking arrow, then wait for a button (C2)"),
    (b"\xF9\x00", "<BUF0>", 0, "the text in wTextBuf0 (a name; C2)"),
    (b"\xF9\x10", "<BUF1>", 0, "the text in wTextBuf1 (C2)"),
    (b"\xF9\x20", "<BUF2>", 0, "the text in wTextBuf2 (C2)"),
    (b"\xF9\x30", "<BUF3>", 0, "the text in wTextBuf3 (C2)"),
    (b"\xE9\xFF", "<MAP_MUSIC>", 0, "restart the map's music (RestartMapMusic)"),
    (b"\xE0", "<SFX_WAIT_E0>", 1, "play sound effect $XX and wait until every sound channel is idle"),
    (b"\xE1", "<SFX_WAIT_E1>", 1, "the same as $E0"),
    (b"\xE2", "<SFX_WAIT_E2>", 1, "the same as $E0"),
    (b"\xE3", "<SFX_WAIT_E3>", 1, "the same as $E0"),
    (b"\xE4", "<SFX_WAIT>", 1, "the same as $E0 (the one the text uses)"),
    (b"\xE5", "<MUSIC_WAIT>", 1, "play music $XX and wait until every sound channel is idle"),
    (b"\xE6", "<CHOICE_E6>", 0, "yes/no choice (TextCmd_ChoiceE6), no sound on confirming yes; the answer is "
                                "wTextYesNoResult (0 yes, 1 no)"),
    (b"\xE7", "<CHOICE_NO>", 0, "yes/no choice with the cursor starting on no"),
    (b"\xE8", "<CURSOR>", 2, "move the glyph cursor to column $XX, row $YY of the text window"),
    (b"\xE9", "<SOUND>", 1, "play sound $XX (music for ids below $60 and $CC, $CF, $D6), without waiting"),
    (b"\xEA", "<VOICE1>", 0, "speech beep on, with sound $6B (before a speaker's words)"),
    (b"\xEB", "<VOICE2>", 0, "speech beep on, with sound $6A"),
    (b"\xEC", "<PAUSE>", 0, "pause for a time set by the text speed; at speed 7 wait for a button instead"),
    (b"\xED", "<INSTANT>", 0, "print the following text at once (wTextControl bit 7) until the next wait"),
    (b"\xEE", "<CLEAR_LINE>", 0, "clear the second line and go back to the start of the current line"),
    (b"\xEF", "<NEXT_LINE>", 0, "the first half of <NEXT>: on the first line it skips the byte after it"),
    (b"\xF0", "@", 0, "end of the text, or of an inserted text (<BUF0>, <PLAYER>): back to the caller's text (C2)"),
    (b"\xF1", "<LINE>", 0, "start the next line, without scrolling (C2)"),
    (b"\xF2", "<CLEAR>", 0, "clear the window (FillTilesFromRequest) and go back to its first line"),
    (b"\xF3", "<HOME>", 0, "go back to the window's first line"),
    (b"\xF4", "<NORMAL>", 0, "end <INSTANT> and <FAST> (ClearStringDisplayFlags)"),
    (b"\xF5", "<FAST>", 0, "print without the per-glyph wait (wTextFlags bit 1)"),
    (b"\xF6", "<PLAYER>", 0, "the player's name (wPlayerName, copied to wPlayerNameText)"),
    (b"\xF7", "<WAIT>", 0, "wait for a button (C2)"),
    (b"\xF8", "<SPEED>", 1, "frames per glyph from here on: $XX instead of the text speed"),
    (b"\xF9", "<BUF>", 1, "the text at wTextBuf0 + $XX (C2 for $00, $10, $20, $30)"),
    (b"\xFA", "<ARROW>", 0, "show the blinking arrow while waiting (C2 with <WAIT>)"),
    (b"\xFB", "<WAIT_OR_BUTTON>", 1, "wait $XX frames or until a button"),
    (b"\xFC", "<DELAY>", 1, "wait $XX frames"),
    (b"\xFD", "<BEEP_ON>", 0, "speech beep on, with the current sound"),
    (b"\xFE", "<BEEP_OFF>", 0, "speech beep off"),
    (b"\xFF", "<CHOICE>", 0, "yes/no choice with the cursor starting on yes"),
]
TOKEN_BYTES = {tok: seq for seq, tok, _n, _d in TOKENS}

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


BREAK_BEFORE_TOKENS = {"<NEXT>", "<CLEAR>", "<HOME>"}
BREAK_AFTER_TOKENS = {"<LINE>", "<WAIT>", "<PROMPT>", "@", "<CHOICE>", "<CHOICE_NO>", "<CHOICE_E6>"}


def render(raw: bytes, max_chars: int = 60) -> list[str]:
    """Render bytes as `db` operand lists: string literals for mapped characters and printer commands
    (TOKENS), `$XX` for argument bytes and everything else. A line starts before <NEXT>, <CLEAR> and <HOME>,
    ends after <LINE>, <WAIT>, <PROMPT>, @ and a choice, and is cut after about `max_chars` characters."""
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

    k = 0
    while k < len(raw):
        b = raw[k]
        tok = next(((seq, t, n) for seq, t, n, _d in TOKENS if raw.startswith(seq, k)), None)
        if tok:
            seq, t, n = tok
            if t in BREAK_BEFORE_TOKENS and (cur or parts):
                flush_line()
            cur.append(t)
            width += len(t)
            k += len(seq)
            if n:
                flush_str()
                for v in raw[k:k + n]:
                    parts.append(f"${v:02X}")
                    width += 3
                k += n
            if t in BREAK_AFTER_TOKENS or width >= max_chars:
                flush_line()
            continue
        if b in BYTE_TO_TEXT and not (b == 0x95 and k + 1 < len(raw)
                                      and "'" + BYTE_TO_TEXT.get(raw[k + 1], "") in CHARMAP):
            cur.append(BYTE_TO_TEXT[b])
            width += len(BYTE_TO_TEXT[b])
            if width >= max_chars:
                flush_line()
        else:
            flush_str()
            parts.append(f"${b:02X}")
            width += 3
            if width >= max_chars:
                flush_line()
        k += 1
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
                if s[k] == "<" and ">" in s[k:]:  # a printer command token
                    t = s[k:s.index(">", k) + 1]
                    out += TOKEN_BYTES[t]
                    k += len(t)
                    continue
                if s[k] == "@":
                    out += TOKEN_BYTES["@"]
                    k += 1
                    continue
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
             "; glyphs below are the characters used in db strings. The font glyphs …()+~/★© are read from",
             "; the font in bank $1F (E-0336); icon glyphs such as the house ($57) and globe ($5C) stay $XX.", ""]
    for text, code in sorted(CHARMAP.items(), key=lambda kv: kv[1]):
        lines.append(f'CHARMAP "{text}", ${code:02X}')
    lines += ["", "; Text printer commands, bytes $E0-$FF (E-0336): PrintTextStep runs entry",
              "; byte - $E0 of the table in RunTextCommand. A command",
              "; with an argument takes the byte(s) after it, written as $XX after the string. (C2) marks",
              "; what tools/text_check.py observed; the rest is a reading of the handler (C1).", ""]
    for seq, tok, n, desc in TOKENS:
        lines.append(f'CHARMAP "{tok}", ' + ", ".join(f"${v:02X}" for v in seq) + f" ; {desc}")
    path.write_text("\n".join(lines) + "\n", encoding="utf-8", newline="\n")
