"""Run each TalkMsgNNNN_<words> routine in tools/sm83.py and check the message the game then looks up (E-0324).

From a field state (a recipe state replayed in memory), the emulator is run to the main loop's `halt`; the routine is
then called there (its bank mapped, the return address pushed), and frames run until LookupString returns. The
text the game looks up must begin with <words> ("0", the hero's name insert, is read as Hero). The lookup's source
label is not compared: a message in an overflow table (E-0243) has a String_ label, and messages sharing one string
carry the first one's number. An observation of our own emulator: it shows that each name quotes the message its
routine really starts, on the routine's flag-clear path (the story flags are cleared before each call).

    python -I tools/talk_check.py [RECIPE STATE] [--limit N] [--quoted]

`--quoted` checks the other labels named from a string quote instead (see quoted_labels).
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


QUOTED_TAIL = re.compile(r"(?:Show|Msg[0-9A-F]{4}_|TalkScript[0-9A-F]{4}_)([A-Z][A-Za-z0-9]+)$")
LABEL = re.compile(r"^([A-Za-z_]\w*)::(?! ; address name)")
QUOTE = re.compile(r"; '(.+?)'$")


def quoted_labels() -> list[tuple[str, str]]:
    """Labels other than TalkMsg* whose name ends in words taken from a string quote (…Show<Words>,
    …MsgNNNN_<Words>, TalkScriptNNNN_<Words>): the quote comment within the label's first 12 lines must begin with
    those words. Returns [(name, words in lower case)]."""
    out = []
    for p in sorted((ROOT / "src/banks").glob("bank*.asm")):
        lines = p.read_text(encoding="utf-8").split("\n")
        for i, ln in enumerate(lines):
            m = LABEL.match(ln)
            if not m or m.group(1).startswith("TalkMsg"):
                continue
            t = QUOTED_TAIL.search(m.group(1))
            if not t:
                continue
            words = t.group(1).lower()
            for later in lines[i + 1:i + 13]:
                q = QUOTE.search(later)
                if q:
                    text = re.sub(r"(?<![0-9A-Za-z])0(?![0-9])", "Hero", q.group(1).replace("*:", " "))
                    if re.sub(r"[^a-z0-9]", "", text.lower()).startswith(words):
                        out.append((m.group(1), words))
                    break
    return out


def run_quoted(recipe: str, state: str, limit: int | None = None):
    """As run(), for quoted_labels(): calls each label and compares the first text the game looks up."""
    kept, _ran = play.replay(recipe, {state}, stop_when_kept=True)
    base = pickle.dumps(kept[state])
    by_name = {v: k for k, v in boot_trace.load_labels().items()}
    out = []
    for name, words in quoted_labels()[:limit]:
        if name not in by_name:
            out.append((name, "not in the .sym file", ""))
            continue
        try:
            r = check_one(base, *by_name[name])
        except RuntimeError as e:  # a label entered out of its context can run into data
            out.append((name, f"stopped before a lookup ({e})", ""))
            continue
        if r is None:
            out.append((name, "no lookup", ""))
        elif not words_of(r[4]).startswith(words):
            out.append((name, f"text {words_of(r[4])[:len(words) + 8]!r}", words_of(r[4])))
        else:
            out.append((name, None, words_of(r[4])))
    return out


if __name__ == "__main__":
    argv = sys.argv[1:]
    quoted = "--quoted" in argv
    argv = [a for a in argv if a != "--quoted"]
    limit = None
    if "--limit" in argv:
        i = argv.index("--limit")
        limit = int(argv[i + 1])
        argv = argv[:i] + argv[i + 2:]
    recipe, state = argv[:2] if len(argv) >= 2 else (str(ROOT / "tools/recipes/e0320_farm_battle.txt"), "s26")
    res = (run_quoted if quoted else run)(recipe, state, limit)
    bad = [(n, p) for n, p, _t in res if p]
    what = "quote-named labels" if quoted else "TalkMsg routines"
    print(f"{len(res) - len(bad)} of {len(res)} {what} look up the text their name quotes")
    for n, p in bad:
        print(f"  {n}: {p}")
