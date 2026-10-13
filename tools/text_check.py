"""Watch the text printer (PrintTextStep) in tools/sm83.py while a conversation plays (E-0336).

Every glyph the printer draws (DrawTextGlyph, 00:$287E) and every command byte it hands to the code table
(RunTextCommand, 00:$2950: bytes $E0-$FF) is logged with its frame and the string position wTextPos holds then.
`run` plays a recipe from a saved machine (`base`, pickled) with a chosen text speed (wTextSpeed) and returns the
log. An observation of our own emulator; the states come from the recipe chain of E-0320.

    python -I tools/text_check.py
"""
import pickle
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import boot_trace  # noqa: E402
import play  # noqa: E402

GLYPH = 0x287E  # DrawTextGlyph: A = the glyph
CODE = 0x2950  # RunTextCommand: A = the command byte
wTextPosLo = 0xC533
wTextSpeed = 0xC964
wTextBuf0 = 0xC130
RECIPE = str(ROOT / "tools/recipes/e0320_farm_battle.txt")
TALK = "U2 W10 A W4"  # from s13: step up to the farmhand and talk


def base(state: str, then: str = "") -> bytes:
    """The pickled machine at `state` of the E-0320 chain, after the steps `then`."""
    kept, _ = play.replay(RECIPE, {state}, stop_when_kept=True)
    gb = kept[state]
    if then:
        play.run(gb, play.parse(then), boot_trace.load_labels(), {})
    return pickle.dumps(gb)


def run(start: bytes, recipe: str, speed: int | None = None):
    """(log, machine): log is [(frame, "glyph" or "code", value, wTextPos)] while `recipe` plays."""
    gb = pickle.loads(start)
    log: list[tuple[int, str, int, int]] = []
    snaps: list = []  # <BUF>: (log index, offset, the text there then, the text at offset ^ $10 then)
    run.snaps = snaps

    def on(kind):
        def hook(g):
            if g.pc < 0x4000:
                pos = g.rb(wTextPosLo) | g.rb(wTextPosLo + 1) << 8
                log.append((g.cycles // play.FRAME, kind, g.a, pos))
                if kind == "code" and g.a == 0xF9:  # wTextPos holds the argument's address here
                    off = g.rb(pos)
                    snaps.append((len(log) - 1, off, buf_text(g, off), buf_text(g, off ^ 0x10)))
        return hook

    gb.pc_hooks[GLYPH] = on("glyph")
    gb.pc_hooks[CODE] = on("code")
    if speed is not None:
        gb.wb(wTextSpeed, speed)
    play.run(gb, play.parse(recipe), boot_trace.load_labels(), {})
    return log, gb


def glyph_gaps(log) -> list[int]:
    """Frames between glyphs drawn back to back (no command between them)."""
    out, prev = [], None
    for f, kind, _v, _p in log:
        if kind == "glyph" and prev is not None and prev[1] == "glyph":
            out.append(f - prev[0])
        prev = (f, kind)
    return out


def buf_text(g, off: int) -> list[int]:
    """The $F0-terminated text at wTextBuf0 + off (at most 16 bytes)."""
    text, q = [], wTextBuf0 + off
    while g.rb(q) != 0xF0 and len(text) < 16:
        text.append(g.rb(q))
        q += 1
    return text


def inserts(log, snaps):
    """For each <BUF>: (offset, the text at wTextBuf0 + offset then, the glyphs printed right after it, and the text
    of the other first slot, at offset ^ $10, for a control)."""
    out = []
    for i, off, text, other in snaps:
        glyphs = []
        for _f, kind, v, _p in log[i + 1:]:
            if kind != "glyph":
                break
            glyphs.append(v)
        out.append((off, text, glyphs, other))
    return out


if __name__ == "__main__":
    start = base("s13", TALK)
    for s in (1, 4):
        lg, _ = run(start, "W200", s)
        gaps = glyph_gaps(lg)
        print(f"speed {s}: {len(gaps)} gaps, most common {max(set(gaps), key=gaps.count) if gaps else None}; "
              f"commands {[hex(v) for f, k, v, p in lg if k == 'code'][:12]}")
