"""Run each TalkMsgNNNN_<words> routine in tools/sm83.py and check the message the game then looks up (E-0324).

From a field state (a recipe state replayed in memory), the emulator is run to the main loop's `halt`; the routine is
then called there (its bank mapped, the return address pushed), and frames run until LookupString returns. The
text the game looks up must begin with <words> ("0", the hero's name insert, is read as Hero). The lookup's source
label is not compared: a message in an overflow table (E-0243) has a String_ label, and messages sharing one string
carry the first one's number. An observation of our own emulator: it shows that each name quotes the message its
routine really starts, on the routine's flag-clear path (the story flags are cleared before each call).

    python -I tools/talk_check.py [RECIPE STATE] [--limit N]
"""
import pickle
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import boot_trace  # noqa: E402
import gb_text  # noqa: E402
import play  # noqa: E402

LOOKUP_STRING_RET = boot_trace.LOOKUP_STRING_RET
wStoryFlags = 0xCBD7
NAME = re.compile(r"TalkMsg([0-9A-F]{4})_([A-Za-z0-9]+)")


def words_of(raw: bytes) -> str:
    text = "".join(gb_text.BYTE_TO_TEXT.get(b, " ") for b in raw)
    text = re.sub(r"(?<![0-9A-Za-z])0(?![0-9])", "Hero", text.replace("*:", " "))  # the hero's name insert
    return re.sub(r"[^a-z0-9]", "", text.lower())


def check_one(base: bytes, bank: int, addr: int, frames: int = 240):
    """(bank, DE, category, index, raw bytes) of the first LookupString after calling bank:addr, or None."""
    gb = pickle.loads(base)
    for _ in range(200000):  # to the main loop's halt, outside an interrupt
        if gb.halted and gb.pc < 0x4000 and gb.ime:
            break
        gb.tick(gb.step() if not gb.halted else 456 - gb.line_cycles)
        gb.service()
    else:
        return None
    for i in range(0x6B):  # story flags cleared: the name quotes the flag-clear path's message
        gb.wb(wStoryFlags + i, 0)
    gb.halted = False
    gb.push(gb.pc)
    gb.rombank = bank
    gb.pc = addr
    end = gb.cycles + frames * play.FRAME
    while gb.cycles < end:
        if gb.pc == LOOKUP_STRING_RET:
            p, raw = gb.d << 8 | gb.e, []
            while len(raw) < 60 and gb.rb(p) != 0xF0:
                raw.append(gb.rb(p))
                p += 1
            return gb.rombank, gb.d << 8 | gb.e, gb.rb(boot_trace.wStringCategory), gb.rb(boot_trace.wStringIndex), \
                bytes(raw)
        if gb.halted:
            gb.tick(456 - gb.line_cycles if gb.io[0x40] & 0x80 else 456)
        else:
            gb.tick(gb.step())
        gb.service()
    return None


def run(recipe: str, state: str, limit: int | None = None):
    """Returns [(name, problem or None, the looked-up text's letters)] for every TalkMsg routine (or the first
    `limit`)."""
    kept, _ran = play.replay(recipe, {state}, stop_when_kept=True)
    base = pickle.dumps(kept[state])
    labels = boot_trace.load_labels()
    by_name = {v: k for k, v in labels.items()}
    out = []
    names = sorted(n for n in by_name if NAME.fullmatch(n))
    for name in names[:limit]:
        m = NAME.fullmatch(name)
        word, words = int(m.group(1), 16), m.group(2).lower()
        bank, addr = by_name[name]
        r = check_one(base, bank, addr)
        if r is None:
            out.append((name, "no lookup", ""))
            continue
        raw = r[4]
        if not words_of(raw).startswith(words):
            out.append((name, f"text {words_of(raw)[:len(words) + 8]!r}", words_of(raw)))
        else:
            out.append((name, None, words_of(raw)))
    return out


if __name__ == "__main__":
    argv = sys.argv[1:]
    limit = None
    if "--limit" in argv:
        i = argv.index("--limit")
        limit = int(argv[i + 1])
        argv = argv[:i] + argv[i + 2:]
    recipe, state = argv[:2] if len(argv) >= 2 else (str(ROOT / "tools/recipes/e0320_farm_battle.txt"), "s26")
    res = run(recipe, state, limit)
    bad = [(n, p) for n, p, _t in res if p]
    print(f"{len(res) - len(bad)} of {len(res)} TalkMsg routines look up the message their name quotes")
    for n, p in bad:
        print(f"  {n}: {p}")
