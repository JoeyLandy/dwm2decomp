"""Turn the annotated analysis listing into the reader-facing source in src/.

tools/disasm_all.py writes an annotated listing, one file per ROM bank, to build/listing/. That listing keeps
everything the analysis tools and tests check: address-name aliases, the heuristic that found each label, call
sites, and the RAM each routine reads and writes. This pass keeps the same instructions and data, so the ROM is
identical, but writes them in the style of the pret disassemblies (pokered is the model):

- labels without their bookkeeping: no `Func_BBB_AAAA` alias and no `; heuristic: ...` tag;
- comments are the notes a reader needs, from config/names.json and the table layouts; machine-made lists
  (call sites, reads/writes, "only called from", "entry N of the table") stay in the listing. A comment that
  repeats on every record of a table is written once. Address names and `BB:AAAA` addresses in comments become
  the label at that address, evidence ids move to the end, and long comments are wrapped;
- instructions as pret writes them: `xor a`, `cp $10`, `ld a, [hli]`, lowercase hex, `jumptable` for `rst $00`;
- each bank file is named and headed by what it holds (config/banks.json, D-006): bank36_battle_effects.asm;
- graphics and maps are INCBINs of named asset files listed in src/assets.txt (D-008), and lb bc, W, R gives
  the width and rows a rectangle routine takes in B and C.

The confidence and evidence of every name stay in config/ (names.json, symbols.json, tables.json) and in the
listing. Run after disasm_all, or alone to re-present an existing listing:

    python -I tools/present.py [LISTING_DIR]
"""
import json
import re
import sys
import textwrap
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import describe  # noqa: E402

ROOT = Path(__file__).resolve().parents[1]
WIDTH = 100

# full-line comments made by the generator from cross-references; the listing keeps them
DROP_COMMENT = re.compile(
    r"; (?:no direct call|\d+ call sites? from |only called from |reads: |writes: |points at: |"
    r"text \(E-0024\)|address loaded by |entry \d+ of the `rst \$00` table|heuristic: )")
ALIAS = re.compile(r"^([A-Za-z_]\w*):: ; address name$")
GAP_NOTE = re.compile(r"not read|not interpreted|\bunknown\b|not decoded|purpose unclear")
LABEL = re.compile(r"^([A-Za-z_]\w*)::?")
ADDR_NAME = re.compile(r"^(?:Func|Jump|Data)_([0-9A-F]{3})_([0-9A-F]{4})$")
LABEL_TAG = re.compile(r"^([A-Za-z_][\w.]*::?) ; (?:heuristic: .*|code pointer of the table .*)$")
ALU = re.compile(r"^(\s+(?:add|adc|sub|sbc|and|or|xor|cp)) a, (?!a?\s*$)")
ALU_A = re.compile(r"^(\s+(?:add|adc|sub|sbc|and|or|xor|cp)) a, a\b")
HEX = re.compile(r"\$[0-9A-F]+\b")
DERIVED = re.compile(r"^; ((?:E-\d{4}(?:, )?)+) \((derived|C[0-3]): (.*)\)\.?$")
LZSS = re.compile(r"^; LZSS-compressed asset: (\d+) bytes expand to (\d+) \(tools/lzss_gfx\.py, E-0016/E-0017; C1\)$")
DATA_OPS = {"db", "dw", "dfar", "ds", "DS", "d24", "INCBIN"}
MENTION = re.compile(r"\b(?:(?:Func|Jump|Data)_[0-9A-F]{3}_[0-9A-F]{4}|[0-9A-F]{2}:[0-9A-F]{4})\b")


class Names:
    """Address names and addresses of the listing, mapped to the labels src/ keeps; and, for comments written
    before later renames (E-0347), former names mapped to the current label: names config/names.json records as
    "was X", step names `Parent_CaseNN` / `_SubNN` / `_TableK_CaseNN` resolved through the parent's jumptables,
    and the generic name of a per-bank copy (StartScriptAtHL in bank $13 is StartScriptAtHL_B13)."""

    WORD = re.compile(r"\b[A-Z][A-Za-z0-9]*(?:_[A-Za-z0-9]+)*\b")

    def __init__(self, texts: dict[str, str]) -> None:
        self.alias: dict[str, str] = {}
        self.at: dict[str, str] = {}  # "BB:AAAA" -> label
        self.labels: set[str] = set()
        self.tables: dict[str, list[list[str]]] = {}  # routine -> its jumptables' entries
        self.bank_labels: dict[int, set[str]] = {}
        for name, t in texts.items():
            mb = re.match(r"bank([0-9a-f]{2})", name)
            bank = int(mb.group(1), 16) if mb else -1
            prev, cur, ls = None, None, t.split("\n")
            for i, ln in enumerate(ls):
                m = ALIAS.match(ln)
                if m and prev:
                    self.alias[m.group(1)] = prev
                    a = ADDR_NAME.match(m.group(1))
                    if a:
                        self.at.setdefault(f"{int(a.group(1), 16):02X}:{a.group(2)}", prev)
                    continue
                m = LABEL.match(ln)
                if m and "::" in ln:
                    prev = cur = m.group(1)
                    self.labels.add(prev)
                    self.bank_labels.setdefault(bank, set()).add(prev)
                    a = ADDR_NAME.match(prev)
                    if a:
                        self.at.setdefault(f"{int(a.group(1), 16):02X}:{a.group(2)}", prev)
                elif cur and split_code(ln)[0].strip() == "rst $00":
                    entries = []
                    for nx in ls[i + 1:]:
                        mm = re.match(r"^\s+dw (\w+)", nx)
                        if not mm:
                            break
                        entries.append(mm.group(1))
                    self.tables.setdefault(cur, []).append(entries)
        self.referrer: dict[str, str] = {}  # label -> the first label whose code or data names it
        for t in texts.values():
            cur = None
            for ln in t.split("\n"):
                m = LABEL.match(ln)
                if m and "::" in ln and "address name" not in ln:
                    cur = m.group(1)
                elif cur and ln.startswith("    "):
                    for w in re.findall(r"\b[A-Za-z_]\w*\b", split_code(ln)[0]):
                        if w != cur and w in self.labels:
                            self.referrer.setdefault(w, cur)
        self.history: dict[str, str] = {}
        cfg = json.loads((ROOT / "config/names.json").read_text(encoding="utf-8"))
        for k, v in cfg.items():
            if not k.startswith("_") and isinstance(v, dict):
                for old in re.findall(r"\bwas (\w+)", v.get("note", "")):
                    self.history.setdefault(old, v["name"])

    def resolve(self, w: str, bank: int | None = None, depth: int = 0) -> str | None:
        if w in self.labels:
            return w
        if depth > 6:
            return None
        r = self.alias.get(w) or self.history.get(w)
        if r:
            return self.resolve(r, bank, depth + 1) or r
        m = re.fullmatch(r"(\w+?)(?:_Table(\d))?_(?:Case|Sub)([0-9A-F]{2})", w)
        if m:
            parent = self.resolve(m.group(1), bank, depth + 1)
            tabs = self.tables.get(parent or "", [])
            k = int(m.group(2)) - 1 if m.group(2) else 0
            if 0 <= k < len(tabs) and int(m.group(3), 16) < len(tabs[k]):
                e = tabs[k][int(m.group(3), 16)]
                return self.alias.get(e, e)
        if bank is not None:  # the copy of a library routine in this bank
            for suf in (f"_B{bank:02X}", f"_Bank{bank:02X}", f"_B{bank:02X}b"):
                if w + suf in self.bank_labels.get(bank, ()):
                    return w + suf
        return None

    def sub(self, comment: str, bank: int | None = None) -> str:
        def one(m: re.Match) -> str:
            w = m.group(0)
            return self.alias.get(w) or self.at.get(w) or w
        comment = MENTION.sub(one, comment)

        def word(m: re.Match) -> str:
            w = m.group(0)
            if w in self.labels or "_" not in w and not re.search(r"[a-z][A-Z]", w):
                return w
            return self.resolve(w, bank) or w
        return self.WORD.sub(word, comment)


def split_code(line: str) -> tuple[str, str]:
    """(code, comment) with the comment starting at the first `;` outside a string."""
    q = False
    for i, ch in enumerate(line):
        if ch == '"':
            q = not q
        elif ch == ";" and not q:
            return line[:i], line[i:]
    return line, ""


def lower_hex(code: str) -> str:
    """Lowercase hex numbers outside strings."""
    parts = code.split('"')
    for i in range(0, len(parts), 2):
        parts[i] = HEX.sub(lambda m: m.group(0).lower(), parts[i])
    return '"'.join(parts)


def reword(comment: str) -> str:
    """A full-line comment with its evidence id moved to the end."""
    m = DERIVED.match(comment)
    if m:
        ids, kind, body = m.group(1).rstrip(", "), m.group(2), m.group(3)
        return f"; {body} ({ids}{'' if kind == 'derived' else ', ' + kind})"
    m = LZSS.match(comment)
    if m:
        return f"; LZSS-compressed: {m.group(1)} bytes that expand to {m.group(2)} (E-0016, E-0017)"
    return comment


def wrap(indent: str, comment: str) -> list[str]:
    body = comment[1:].strip()
    if len(indent) + len(comment) <= WIDTH or not body:
        return [indent + comment]
    return [f"{indent}; {ln}" for ln in textwrap.wrap(body, WIDTH - len(indent) - 2, break_long_words=False,
                                                       break_on_hyphens=False)]


INCBIN_ROM = re.compile(r'^(\s+)INCBIN "dwm2-cobi-us\.gbc", \$([0-9A-Fa-f]+), \$([0-9A-Fa-f]+)(.*)$')
# D-008: an INCBIN slice of the reference becomes a named asset file: directory by label, name from the label
ASSET_DIRS = [
    (r"MonsterSprite_(\w+)", "gfx/monster_sprites/{}"), (r"MonsterPic_(\w+)", "gfx/monster_pics/{}"),
    (r"FieldSpriteGfx(\w+)", "gfx/field_sprites/{}"), (r"BattleEffectGfx(\w+)", "gfx/battle_effects/{}"),
    (r"SGBBorder(\w+)", "gfx/sgb_border/{}"), (r"MapType(\w+)", "gfx/map_types/{}"),
    (r"AreaTileset(\w+)", "gfx/area_tilesets/{}"), (r"SpecialMap(\d+)(\w+)", "maps/special_map{}/{}"),
    (r"Map([0-9A-F]{2})(\w+)", "maps/map{}/{}"), (r"KeyWorld(\w+)", "maps/key_worlds/{}"),
    (r"ScreenMap_(\w+)", "maps/screen_maps/{}"), (r"(\w+)", "gfx/misc/{}"),
]


def snake(name: str) -> str:
    """DrakSlime -> drak_slime, Screens0_Y1X1 -> screens0_y1x1."""
    s = re.sub(r"(?<=[a-z0-9])(?=[A-Z])", "_", name).lower()
    return re.sub(r"_+", "_", s).strip("_")


def asset_path(label: str, compressed: bool) -> str:
    for rx, fmt in ASSET_DIRS:
        m = re.fullmatch(rx, label)
        if m:
            return fmt.format(*[snake(g).lower() for g in m.groups()]) + (".lz" if compressed else ".bin")
    raise ValueError(label)


def code_line(line: str) -> str:
    code, comment = split_code(line)
    if not code.strip() or code.startswith("SECTION") or code.lstrip().startswith(("INCBIN", "INCLUDE")):
        return line
    code = ALU_A.sub(r"\1 a", code)
    code = ALU.sub(r"\1 ", code)
    code = code.replace("[hl+]", "[hli]").replace("[hl-]", "[hld]")
    if code.strip() == "rst $00":
        code = code.replace("rst $00", "jumptable")
    return lower_hex(code) + comment


ASSETS: dict[str, tuple[int, int]] = {}  # asset path -> (ROM offset, length), filled by present()


def present(text: str, names: Names, bank: int | None = None) -> str:
    out: list[str] = []
    recent: list[str] = []  # the last distinct full-line comments, to write a table's repeated comment once
    label, compressed, pending = "", False, False  # pending: an LZSS comment above the next label
    dropped: list[str] = []  # bookkeeping comments above the next label (entry N of a table, callers)
    dropped_at: dict[str, list[str]] = {}
    for ln in text.split("\n"):
        if ALIAS.match(ln):
            continue
        s = ln.lstrip()
        if s.startswith(";"):
            pending = pending or "LZSS-compressed" in s
            if DROP_COMMENT.match(s):
                dropped.append(names.sub(s, bank))
                continue
            c = reword(names.sub(s, bank))
            if c in recent:
                continue
            recent = (recent + [c])[-4:]
            out.extend(wrap(ln[:len(ln) - len(s)], c))
            continue
        m = INCBIN_ROM.match(ln)
        if m and label:
            path = asset_path(label, compressed)
            ASSETS[path] = (int(m.group(2), 16), int(m.group(3), 16))
            out.append(f'{m.group(1)}INCBIN "{path}"{m.group(4)}')
            continue
        m = LABEL.match(ln)
        if m and "::" in ln:
            label, compressed, pending = m.group(1), pending, False
            dropped_at[label], dropped = dropped, []
        elif ln.strip():
            pending = False
        m = LABEL_TAG.match(ln)
        if m:
            ln = m.group(1)
        elif not LABEL.match(ln):
            code, comment = split_code(ln)
            if comment:
                ln = code + names.sub(comment, bank)
            ln = code_line(ln)
            op = code.split(None, 1)[0] if code.strip() else ""
            if op and op not in DATA_OPS and not op.startswith(("script_", "objsel_")):
                recent = []  # instructions end a table: a later repeat is a new comment
        if ln == "" and out and out[-1] == "":
            continue  # a dropped block can leave two blank lines
        out.append(ln)
    return "\n".join(document(rect_sizes(out), dropped_at, names))


def document(lines: list[str], dropped_at: dict[str, list[str]], names: "Names") -> list[str]:
    """E-0347: a code label with no comment above it gets one restating its instructions (tools/describe.py)."""
    out: list[str] = []
    heads = [i for i, ln in enumerate(lines) if re.match(r"^[A-Za-z_]\w*::", ln)]
    labels = {lines[h].split("::")[0] for h in heads} | names.labels
    nxt = {h: (heads[k + 1] if k + 1 < len(heads) else len(lines)) for k, h in enumerate(heads)}
    header = False  # a commented data label earlier in this run of data labels (one comment per table)
    for i, ln in enumerate(lines):
        if i in nxt:
            documented = bool(out) and out[-1].startswith(";")
            body = lines[i + 1:nxt[i]]
            first = next((b for b in body if b.strip() and not b.startswith(";") and not re.match(r"^\.?\w+:", b)), "")
            op = first.split(None, 1)[0] if first.strip() else ""
            label = ln.split("::")[0]
            is_data = op in DATA_OPS or op.startswith(("script_", "objsel_"))
            if not first.startswith("    "):
                pass
            elif not is_data:
                header = False
                if not documented:
                    out.extend(wrap("", "; " + describe.summarize(label, body, dropped_at.get(label, []), labels)))
                else:  # a note that says the body was not read gets the restatement too
                    k = len(out)
                    while k > 0 and out[k - 1].startswith(";"):
                        k -= 1
                    if GAP_NOTE.search(" ".join(out[k:])):
                        text = describe.summarize(label, body, [], labels)
                        out.extend(wrap("", "; code: " + text[:1].lower() + text[1:]))
            elif documented or re.match(r'^\s+db "', first):
                header = header or documented
            elif not header:
                out.extend(wrap("", "; " + describe.data_note(label, body, labels, names.referrer.get(label))))
                header = True
        out.append(ln)
    return out


LD_BC = re.compile(r"^(\s+)ld (bc|de), \$([0-9a-f]{2})([0-9a-f]{2})(\s*;.*)?$")
# routines that take two separate bytes in a register pair: rectangles (B = width, C = rows), resolve messages
# (B = argument, C = flags, E-0073), and sprite steps toward a point (D = X, E = Y, E-0127)
PAIR_CALLEE = {"bc": re.compile(r"Rect|ResolveMsg"), "de": re.compile(r"Toward")}
CALL_TO = re.compile(r"^\s+(?:call|farcall|farcall_b|jp)(?: \w+,)? (\w+)")


def rect_sizes(lines: list[str]) -> list[str]:
    """`ld bc, $WWRR` before a call to a routine that takes B and C as two bytes (a rectangle: B = width, C = rows;
    a resolve message: B = argument, C = flags) is written `lb bc, $WW, $RR`, and `ld de, $XXYY` before a sprite
    step toward a point (D = X, E = Y) `lb de, $XX, $YY`, when no label or other use of the pair comes between."""
    out = list(lines)
    for i, ln in enumerate(lines):
        m = LD_BC.match(ln)
        if not m:
            continue
        pair = m.group(2)
        code = [nx for nx in lines[i + 1:i + 12] if nx.strip() and not nx.lstrip().startswith(";")][:3]
        for nx in code:
            c = CALL_TO.match(nx)
            if c:
                if PAIR_CALLEE[pair].search(c.group(1)):
                    out[i] = f"{m.group(1)}lb {pair}, ${m.group(3)}, ${m.group(4)}{m.group(5) or ''}"
                break
            if not nx.startswith("    ") or pair in nx or pair[0] in re.findall(r"\b[a-z]\b", nx) or \
                    pair[1] in re.findall(r"\b[a-z]\b", nx) or nx.lstrip().startswith(("ret", "jr", "jp")):
                break
    return out


def bank_titles() -> dict[int, dict]:
    """config/banks.json: bank -> {"file": short name, "title": what the bank holds} (D-006)."""
    cfg = json.loads((ROOT / "config/banks.json").read_text(encoding="utf-8"))
    return {int(k, 16): v for k, v in cfg.items() if not k.startswith("_")}


def src_name(listing_name: str, titles: dict[int, dict]) -> str:
    """bank36.asm -> bank36_battle_effects.asm"""
    b = int(listing_name[4:6], 16)
    return f"bank{b:02x}_{titles[b]['file']}.asm" if b in titles else listing_name


def header(listing_name: str, titles: dict[int, dict]) -> str:
    b = int(listing_name[4:6], 16)
    title = titles[b]["title"] if b in titles else "(untitled)"
    return f"; ROM bank ${b:02X}: {title}\n; The annotated listing of this bank is build/listing/{listing_name}.\n\n"


def main(argv: list[str]) -> int:
    src = Path(argv[0]) if argv else ROOT / "build/listing"
    dest = ROOT / "src/banks"
    dest.mkdir(parents=True, exist_ok=True)
    texts = {p.name: p.read_text(encoding="utf-8") for p in sorted(src.glob("bank*.asm"))}
    names = Names(texts)
    titles = bank_titles()
    written = []
    ASSETS.clear()
    for name, text in texts.items():
        out = src_name(name, titles)
        (dest / out).write_text(header(name, titles) + present(text, names, int(name[4:6], 16)), encoding="utf-8", newline="\n")
        written.append(out)
    for stale in set(p.name for p in dest.glob("bank*.asm")) - set(written):
        (dest / stale).unlink()  # a bank file under an earlier name
    main_asm = ROOT / "src/main.asm"
    lines = main_asm.read_text(encoding="utf-8").split("\n")
    out_lines = []
    for ln in lines:
        m = re.match(r'INCLUDE "banks/(bank[0-9a-f]{2})(?:_\w+)?\.asm"', ln)
        out_lines.append(f'INCLUDE "banks/{src_name(m.group(1) + ".asm", titles)}"' if m else ln)
    main_asm.write_text("\n".join(out_lines), encoding="utf-8", newline="\n")
    (ROOT / "src/assets.txt").write_text(
        "# D-008: the asset files src/ includes, as slices of the reference ROM: path, file offset, length.\n"
        "# tools/build.py extracts them from local/roms/ into the build directory; they are never tracked.\n"
        + "".join(f"{p}\t${o:06X}\t${n:X}\n" for p, (o, n) in sorted(ASSETS.items())), encoding="utf-8", newline="\n")
    print(f"presented {len(texts)} bank files from {src} into {dest}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
