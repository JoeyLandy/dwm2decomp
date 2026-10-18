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
# E-0354: a written note that only names how its routine dispatches says nothing about what it is for
THIN_NOTE = re.compile(r"^(?:unless .{0,40}?, )?runs the (?:routine|field command|effect routine) for |^per-frame routine for "
                       r"|^as \w+$|^implements script command type \w+(?: \(also \w+\))?$|^wBattlePhase \d|"
                       r"^handler \w+ \(entry|^step \d+ of |^by \w+(?: & \$\w+)?$")
GAP_NOTE = re.compile(r"not read|not interpreted|\bunknown\b|not decoded|purpose unclear")
# E-0365: a hand-written reading of the whole routine (config/annotations.json) answers such a gap itself;
# E-0368: the readability batches from E-0369 on write such readings too (tools/apply_drafts.py)
HAND_EVIDENCE = ("E-0357", "E-0358", "E-0359", "E-0360", "E-0361", "E-0362", "E-0369", "E-0370", "E-0371", "E-0372", "E-0373", "E-0374", "E-0375", "E-0376", "E-0377", "E-0378", "E-0379", "E-0380", "E-0381", "E-0382", "E-0383", "E-0384", "E-0385", "E-0386", "E-0387", "E-0388", "E-0389", "E-0390", "E-0395", "E-0401")
# D-012: "(C2, E-0357; probed E-0374)"; a wrapped comment may break the line at any of its spaces (" ;")
HAND_NOTE = re.compile(r"\(C\d,(?: ;)? (?:" + "|".join(HAND_EVIDENCE) + r")(?:;(?: ;)? probed(?: ;)? E-\d{4})?\)")
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


def config_json(name: str) -> dict:
    """A config/ file the generator reads, or {} once it is retired (D-015, H1c): src/ holds the names and notes."""
    p = ROOT / "config" / name
    return json.loads(p.read_text(encoding="utf-8")) if p.exists() else {}


class Names:
    """Address names and addresses of the listing, mapped to the labels src/ keeps; and, for comments written
    before later renames (E-0347), former names mapped to the current label: names config/names.json records as
    "was X", step names `Parent_CaseNN` / `_SubNN` / `_TableK_CaseNN` resolved through the parent's jumptables,
    and the generic name of a per-bank copy (StartScriptAtHL in bank $13 is StartScriptAtHL_B13)."""

    WORD = re.compile(r"\b[A-Z][A-Za-z0-9]*(?:_[A-Za-z0-9]+)*\b")

    def __init__(self, texts: dict[str, str], listing: Path | None = None, ram: Path | None = None) -> None:
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
        # E-0352: what each label is part of, for the purpose line of a generated comment
        self.note_of: dict[str, str] = {}      # label -> its written note (the comments present keeps)
        self.parent_of: dict[str, tuple[str, int | None]] = {}  # label -> (jumptable owner, entry) or (only caller, None)
        self.callers_of: dict[str, list[str]] = {}
        self.dispatch_var: dict[str, str] = {}  # jumptable owner -> the RAM byte it dispatches on
        for t in texts.values():
            block: list[str] = []
            cur, last_ld = None, None
            for ln in t.split("\n"):
                st = ln.strip()
                if ln.startswith(";"):
                    block.append(st)
                    continue
                m = LABEL.match(ln)
                if m and "::" in ln and "address name" not in ln:
                    cur, last_ld = m.group(1), None
                    kept = [c[1:].strip() for c in block if not DROP_COMMENT.match(c)]
                    if kept:
                        self.note_of[cur] = " ".join(kept)
                    for c in block:
                        mm = re.search(r"entry (\d+) of the `rst \$00` table in (\w+)", c)
                        if mm:
                            self.parent_of.setdefault(cur, (mm.group(2), int(mm.group(1))))
                        mm = re.search(r"only called from (\w+)", c)
                        if mm and mm.group(1) not in ("routine", "routines"):
                            self.parent_of.setdefault(cur, (mm.group(1), None))
                        mm = re.search(r"call sites? from \d+ routines? \(e\.g\. ([^)]*)\)", c)
                        if mm:
                            self.callers_of[cur] = [x.strip() for x in mm.group(1).split(",") if x.strip() != "..."]
                    block = []
                    continue
                if st and not ALIAS.match(ln):
                    block = []
                code = split_code(ln)[0].strip()
                ml = re.match(r"ld a, \[(\w+(?: \+ \$\w+)?)\]$", code)
                if ml:
                    last_ld = ml.group(1)
                elif code == "rst $00" and cur and last_ld and cur not in self.dispatch_var:
                    self.dispatch_var[cur] = last_ld
                elif code and last_ld:
                    mk = re.match(r"and a, \$([0-9A-F]{2})$", code)
                    if mk:  # the entry is picked by a masked value: say so (wMapType & $07 = 3)
                        last_ld = f"{last_ld} & ${mk.group(1)}"
                    elif re.match(r"(?:dec a|sub a, \$01)$", code):
                        last_ld = f"{last_ld} - 1"
                    elif not code.startswith(("add ", "cp ")):
                        last_ld = None
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
        self.hram: dict[int, str] = {}  # high-RAM symbols of src/ram.asm, for calls into HRAM
        self.ram_at: list[tuple[int, str]] = []  # every RAM symbol by address, for address names in comments
        ram = ram or ROOT / "src/ram.asm"  # the presented tree's own when present.main writes one
        if ram.exists():
            for name, val in re.findall(r"^DEF ([wsh]\w+) EQU \$([0-9A-F]{4})", ram.read_text(encoding="utf-8"), re.M):
                if name.startswith("h"):
                    self.hram.setdefault(int(val, 16), name)
                self.ram_at.append((int(val, 16), name))
        self.ram_at.sort()
        # E-0350: the evidence ids config records for each label (names.json by address, name_families.json for
        # library copies), cited when a written note leaves them out
        self.evidence: dict[str, str] = {}
        cfg_names = config_json("names.json")
        for k, v in cfg_names.items():
            if k.startswith("_") or not isinstance(v, dict):
                continue
            ids = re.findall(r"[ED]-\d{3,4}", str(v.get("evidence", "")))
            lab = self.at.get(k.upper())
            if lab and not ids and str(v.get("evidence", "")).startswith("reading"):
                ids = ["E-0351"]  # a reading recorded before names cited evidence entries
            if ids and lab:
                self.evidence.setdefault(lab, ", ".join(dict.fromkeys(ids)))
        fams = config_json("name_families.json")
        fam_ids = {f["name"]: ", ".join(dict.fromkeys(re.findall(r"[ED]-\d{3,4}", f.get("evidence", "") + " " +
                                                                    f.get("note", ""))) or ["E-0351"])
                   for f in fams.get("families", [])}
        for lab in self.labels:
            base = re.sub(r"_Bank[0-9A-F]{2}(?:_\d+)?$", "", lab)
            if lab not in self.evidence and fam_ids.get(base):
                self.evidence[lab] = fam_ids[base]
        self.former: dict[str, str] = {}  # shortened step name -> its name before E-0356: it names every level
        short = (listing / "short_names.json") if listing else None
        if short and short.exists():
            self.former = json.loads(short.read_text(encoding="utf-8"))
        self.history: dict[str, str] = {}
        cfg = cfg_names
        for k, v in cfg.items():
            if not k.startswith("_") and isinstance(v, dict):
                for old in re.findall(r"\bwas (\w+)", v.get("note", "")):
                    self.history.setdefault(old, v["name"])

    def _clause(self, note: str) -> str:
        """The first clause of a written note, without its evidence, for a purpose line; names in it are the
        current labels (the listing's notes can still use address names or earlier names)."""
        note = self.sub(note)
        note = re.sub(r"\s*\((?:[ED]-\d{4}[^)]*|C\d[^)]*)\)", "", note)
        note = note.split("; ")[0].strip().rstrip(".")
        if len(note) > 140:
            note = note[:140].rsplit(" ", 1)[0] + " ..."
        return note

    def purpose(self, label: str) -> str:
        """E-0352: why a routine with no written note exists, from what it is part of: the step of a jumptable
        (and the RAM byte that picks it), the routine that alone calls it, or its callers, up to the first one
        whose note was written by reading. Empty when nothing documented is found."""
        chain, cur, seen, fallback = [], label, set(), ""
        while cur not in seen and len(chain) < 8:
            seen.add(cur)
            par, n = self.parent_of.get(cur, (None, None))
            par = (self.resolve(par) or par) if par else None
            if par not in self.labels:  # no recorded parent, or one under a name that no longer exists
                par = None
            if par is None:  # a label inside a routine, named after it (Parent_Skip): part of that routine
                parts = self.former.get(cur, cur).split("_")
                par = next(("_".join(parts[:k]) for k in range(len(parts) - 1, 0, -1)
                            if "_".join(parts[:k]) in self.labels), None)
                if not par:
                    break
                n = -1
            if n is None:
                chain.append(f"a helper of {par}")
            elif n == -1:
                chain.append(f"part of {par}")
            else:
                var = self.dispatch_var.get(par)
                chain.append(f"step {n} of {par}" + (f" (when {var} = {n})" if var else ""))
            note = self.note_of.get(par, "")
            if note and not note.rstrip().endswith("(E-0347)") and "; code:" not in note:
                ids = list(dict.fromkeys(re.findall(r"[ED]-\d{4}", note)))[:2]
                found = (f"{', in '.join(chain)}; {par}: {self._clause(note)}"
                         + (f" ({', '.join(['E-0352'] + ids)})"))
                if not THIN_NOTE.search(self._clause(note)):
                    return found
                fallback = fallback or found  # a note that only names its dispatch: look further up first
            cur = par
        if fallback:
            return fallback
        callers = [self.resolve(c) or c for c in self.callers_of.get(label, [])]
        known = [(c, self.note_of[c]) for c in callers if c in self.note_of and
                 not self.note_of[c].rstrip().endswith("(E-0347)")][:2]
        if known:
            parts = [f"{c} ({self._clause(n)})" for c, n in known]
            ids = list(dict.fromkeys(i for _, n in known for i in re.findall(r"[ED]-\d{4}", n)))[:2]
            return f"used by {' and '.join(parts)}" + f" ({', '.join(['E-0352'] + ids)})"
        base = re.sub(r"_Bank[0-9A-F]{2}(?:_\d+)?$", "", label)
        if base != label:  # a per-bank copy: a documented copy says what they all do
            sib = next((x for x in sorted(self.note_of) if x != label and re.sub(r"_Bank[0-9A-F]{2}(?:_\d+)?$", "", x)
                        == base and not self.note_of[x].rstrip().endswith("(E-0347)")), None)
            if sib:
                ids = list(dict.fromkeys(re.findall(r"[ED]-\d{4}", self.note_of[sib])))[:2]
                return f"a copy of {sib}; {sib}: {self._clause(self.note_of[sib])} ({', '.join(['E-0352'] + ids)})"
        return ""

    @staticmethod
    def _lower(text: str) -> str:
        return text[:1].lower() + text[1:] if text[:2].isalpha() and not text[:2].isupper() else text

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

    def ram_name(self, prefix: str, addr: int) -> str | None:
        """E-0353: the RAM symbol for an address name in a comment (wC5E8 -> wRandomHi): the symbol there, or the
        symbol just below it as `symbol + $N` when the address is at most $3F past it and before the next one."""
        import bisect
        k = bisect.bisect_right(self.ram_at, (addr, "\uffff")) - 1
        if k < 0:
            return None
        base, name = self.ram_at[k]
        nxt = self.ram_at[k + 1][0] if k + 1 < len(self.ram_at) else 0x10000
        region = {"s": (0xA000, 0xC000), "w": (0xC000, 0xE000), "h": (0xFF80, 0xFFFF)}[prefix]
        if not (region[0] <= base <= addr < region[1]) or addr - base > 0x3F or addr >= nxt:
            return None
        return name if addr == base else f"{name} + ${addr - base:X}"

    def sub(self, comment: str, bank: int | None = None) -> str:
        def one(m: re.Match) -> str:
            w = m.group(0)
            return self.alias.get(w) or self.at.get(w) or w
        comment = MENTION.sub(one, comment)
        comment = re.sub(r"(?<![\w$])([wshW])([0-9A-F]{4})\b",  # W: a capitalised form some notes kept
                         lambda m: self.ram_name(m.group(1).lower(), int(m.group(2), 16)) or m.group(0), comment)
        # a home-bank address after "at" or "table" is the label there (the byte at $0973 -> RandomByteTable)
        comment = re.sub(r"\b(at|table) \$([0-3][0-9A-F]{3})\b",
                         lambda m: f"{m.group(1)} {self.at[f'00:{m.group(2)}']}"
                         if f"00:{m.group(2)}" in self.at and not ADDR_NAME.match(self.at[f"00:{m.group(2)}"])
                         and int(m.group(2), 16) >= 0x150 else m.group(0), comment)

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
    return "\n".join(document(operand_forms(out, names, bank), dropped_at, names))


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
            first = next((b for b in body if b.strip() and not b.startswith(";") and not re.match(r"^\.?\w+:", b)
                          and not b.strip().startswith("ASSERT")), "")  # E-0389: a link-time check is not code
            op = first.split(None, 1)[0] if first.strip() else ""
            label = ln.split("::")[0]
            is_data = op in DATA_OPS or op.startswith(("script_", "objsel_"))
            if documented and label in names.evidence:  # cite the recorded evidence a written note leaves out
                k = len(out)
                while k > 0 and out[k - 1].startswith(";"):
                    k -= 1
                if not re.search(r"[ED]-\d{3,4}", " ".join(out[k:])):
                    last = out.pop()
                    out.extend(wrap("", last + f" ({names.evidence[label]})"))
            if not first.startswith("    "):
                pass
            elif not is_data:
                header = False
                if not documented:
                    out.extend(wrap("", "; " + describe.summarize(label, body, dropped_at.get(label, []), labels)
                                    + " (E-0347)"))
                    why = names.purpose(label)
                    if why:
                        out.extend(wrap("", "; why: " + why))
                else:  # a note that says the body was not read gets the restatement too
                    k = len(out)
                    while k > 0 and out[k - 1].startswith(";"):
                        k -= 1
                    block = " ".join(out[k:])
                    if GAP_NOTE.search(block) and not HAND_NOTE.search(block):
                        text = describe.summarize(label, body, [], labels)
                        out.extend(wrap("", "; code: " + text[:1].lower() + text[1:] + " (E-0347)"))
            elif documented or re.match(r'^\s+db "', first):
                header = header or documented
            elif out and re.match(r"^[A-Za-z_]\w*::", out[-1]):  # E-0381: a second name for the same bytes; since
                # E-0387 only entry 0 of a record series keeps one (the generator folds the others into one name)
                out.append(f"; entry 0 of {out[-1].split('::')[0]}, whose note is above (E-0381, E-0387)")
                header = True
            elif not header:
                out.extend(wrap("", "; " + describe.data_note(label, body, labels, names.referrer.get(label))
                                + " (E-0347)"))
                header = True
        out.append(ln)
    return out


LD_BC = re.compile(r"^(\s+)ld (bc|de|hl), \$([0-9a-f]{2})([0-9a-f]{2})(\s*;.*)?$")
# routines that take two separate bytes in a register pair: rectangles (B = width, C = rows), resolve messages
# (B = argument, C = flags, H = target, L = actor; E-0073), and sprite steps toward a point (D = X, E = Y, E-0127)
# E-0371: the resolve-message stores were renamed Store<Kind>Message_BankNN / StoreMessageFlags_BankNN
PAIR_CALLEE = {"bc": re.compile(r"Rect|ResolveMsg|^Store\w*Message|^StoreMessageFlags"), "de": re.compile(r"Toward"),
               "hl": re.compile(r"ResolveMsg|^Store\w*Message|^StoreMessageFlags")}
CALL_TO = re.compile(r"^\s+(?:call|farcall|farcall_b|jp|jr)(?: \w+,)? ([A-Za-z_]\w*)$")
LD_RAW = re.compile(r"^(\s+)ld (bc|de|hl), \$([0-9a-f]{4})(\s*;.*)?$")
# a jump table or table index right after the load: the register is a pointer into this bank
POINTER_USE = re.compile(r"^\s+(?:add hl, (?:bc|de)|add_a_to_hl|ld (?:a|e|d), \[hli?\]|call (?:JumpToWordAtHL|"
                         r"ReadWordTableEntry\w*|ReadWordFromDataBank))")


def _code_after(lines: list[str], i: int, n: int) -> list[str]:
    return [split_code(nx)[0].rstrip() for nx in lines[i + 1:i + 1 + 4 * n]
            if nx.strip() and not nx.lstrip().startswith(";")][:n]


def rect_sizes(lines: list[str]) -> list[str]:
    """The operand rewrites that need no names (see operand_forms)."""
    return operand_forms(lines)


def operand_forms(lines: list[str], names: "Names | None" = None, bank: int | None = None) -> list[str]:
    """Write a 16-bit operand as what it is, never changing its value (E-0348, E-0350):

    - a register pair holding two separate bytes for its callee is `lb rr, $HI, $LO`: before a rectangle routine
      (B = width, C = rows), a resolve-message routine (B = argument, C = flags, H = target, L = actor, reached by
      call, jump or falling into it) and a sprite step toward a point (D = X, E = Y);
    - a negative constant is written signed: a value from $FF00 used without reading through the register (step
      deltas, -1 counters), or from $F000 when the next instruction adds it to HL (`ld hl, -999`);
    - `call $FFxx` into high RAM uses the HRAM symbol there (`call hOAMDMARoutine`);
    - a message word with flag bits, given to a message routine, is `MSG_KEEP_OPEN | $0487` (constants.inc);
    - with the listing's names: a same-bank load that the next instructions index or dispatch through is the label
      the listing has at that address (`ld hl, ActionEffectTable`).
    """
    out = list(lines)
    for i, ln in enumerate(lines):
        m = LD_BC.match(ln)
        if m:
            pair = m.group(2)
            for nx in lines[i + 1:i + 14]:
                if not nx.strip() or nx.lstrip().startswith(";") or re.match(r"^\.\w+:", nx):
                    continue  # comments, and local labels other paths join at, do not end the search
                c = CALL_TO.match(split_code(nx)[0].rstrip())
                g = re.match(r"^([A-Za-z_]\w*)::", nx)  # falling into the routine
                callee = c.group(1) if c else (g.group(1) if g else None)
                if callee:
                    if PAIR_CALLEE[pair].search(callee):
                        out[i] = f"{m.group(1)}lb {pair}, ${m.group(3)}, ${m.group(4)}{m.group(5) or ''}"
                    break
                code = split_code(nx)[0]
                regs = re.findall(r"\b[a-z]{1,2}\b", code)
                if not nx.startswith("    ") or pair in regs or pair[0] in regs or pair[1] in regs or \
                        code.lstrip().startswith(("ret", "jr", "jp")):
                    break
            if out[i] != ln:
                continue
        m = LD_RAW.match(out[i])
        if m:
            v = int(m.group(3), 16)
            nxt = _code_after(out, i, 4)
            if v & 0xC000 and m.group(4) and "'" in m.group(4) and nxt and \
                    re.match(r"^\s+(?:call|farcall|jp) \w*Message", nxt[0]):  # a message word (E-0350)
                flags = " | ".join(f for f, bit in (("MSG_KEEP_OPEN", 0x4000), ("MSG_ALREADY_OPEN", 0x8000)) if v & bit)
                out[i] = f"{m.group(1)}ld {m.group(2)}, {flags} | ${v & 0x3FFF:04x}{m.group(4)}"
                continue
            deref = any(re.search(rf"\[{m.group(2)}|\[hl[id+-]?\]", x) for x in nxt[:2]) and m.group(2) in ("hl", "de", "bc")
            add_next = bool(nxt) and re.match(r"^\s+add hl, (?:bc|de|hl)$" if m.group(2) == "hl" else rf"^\s+add hl, {m.group(2)}$", nxt[0]) is not None
            if (v >= 0xFF00 and not deref) or (v >= 0xF000 and add_next):
                out[i] = f"{m.group(1)}ld {m.group(2)}, {v - 0x10000}{m.group(4) or ''}"
                continue
            if names is not None and bank is not None and 0x4000 <= v < 0x8000 and bank != 0 and nxt and \
                    POINTER_USE.match(nxt[0] if not nxt[0].strip().startswith("ld a, l") else ""):
                lab = names.at.get(f"{bank:02X}:{v:04X}")
                if lab and not ADDR_NAME.match(lab):
                    out[i] = f"{m.group(1)}ld {m.group(2)}, {names.alias.get(lab, lab)}{m.group(4) or ''}"
                    continue
        m = re.match(r"^(\s+call )\$(ff[89a-f][0-9a-f])(\s*;.*)?$", out[i])
        if m and names is not None:
            sym = names.hram.get(int(m.group(2), 16))
            if sym:
                out[i] = f"{m.group(1)}{sym}{m.group(3) or ''}"
    return out


def bank_titles() -> dict[int, dict]:
    """config/banks.json: bank -> {"file": short name, "title": what the bank holds} (D-006)."""
    cfg = json.loads((ROOT / "config/banks.json").read_text(encoding="utf-8"))
    return {int(k, 16): v for k, v in cfg.items() if not k.startswith("_")}


def src_name(listing_name: str, titles: dict[int, dict]) -> str:
    """bank36.asm -> engine/bank36_battle_effects.asm: the file under src/, in its directory (D-006, D-010)."""
    b = int(listing_name[4:6], 16)
    if b not in titles:
        return listing_name
    return f"{titles[b].get('dir', 'banks')}/bank{b:02x}_{titles[b]['file']}.asm"


def bank_files(root: Path = ROOT) -> list[Path]:
    """The presented bank files, wherever their directory puts them (D-010)."""
    return sorted(root.glob("src/*/bank[0-9a-f][0-9a-f]_*.asm"), key=lambda p: p.name)


END_OF_FLOW = re.compile(r"^\s+(?:ret|reti|jp hl|jp [A-Za-z_][\w.]*|jr [A-Za-z_.][\w.]*)\s*(?:;.*)?$")


SECTION_STARTS = {"ScreenNumberListTable"}  # E-0414 (H4): data that starts a section of its own, so it can move


def split_sections(text: str, bank: int) -> tuple[str, list[str]]:
    """E-0393 (M2): a bank file as floating sections, placed by src/layout.link in their original order, so the
    build is unchanged and a section can be moved to another bank by moving its line in the layout. A new section
    starts at a top-level label whose code above it ends in an unconditional ret, reti, jp or jr, so no code runs
    from one section into the next; it starts right after that instruction, so the comments above the label stay
    with it. A label in SECTION_STARTS starts one whatever is above it (E-0414). Returns the text and the section
    names in order."""
    kind = "ROM0" if bank == 0 else "ROMX"
    out: list[str] = []
    names: list[str] = []
    last_code = ""
    for ln in text.split("\n"):
        if ln.startswith("SECTION "):
            names.append(f"Bank {bank:02X}")
            out.append(f'SECTION "Bank {bank:02X}", {kind}')
            last_code = ""
            continue
        m = re.match(r"^([A-Za-z_]\w*)::", ln)
        if m and names and (END_OF_FLOW.match(last_code) or m.group(1) in SECTION_STARTS):
            k = len(out)
            while k > 0 and (not out[k - 1].strip() or out[k - 1].startswith(";")):
                k -= 1
            names.append(f"Bank {bank:02X} {m.group(1)}")
            out.insert(k, f'\nSECTION "Bank {bank:02X} {m.group(1)}", {kind}')
            last_code = ""
        out.append(ln)
        if ln.startswith("    ") and ln.strip():
            last_code = ln
    return "\n".join(out), names


PINNED = {"Bank 00 CartridgeHeader": 0x0104}  # the logo and header after the entry point at $0100 (E-0393)


def layout_text(sections: dict[int, list[str]]) -> str:
    """src/layout.link: every section in its bank and order (rgblink -l). E-0393."""
    out = ["; Generated by tools/present.py (E-0393): the place of every section of src/. Each bank lists its",
           "; sections in ROM order; moving a section's line to another bank's list moves its code (the matching",
           "; build keeps this order). Sections follow one another with no gaps; trailing `ds` fills pad each bank."]
    for b in sorted(sections):
        out.append("ROM0" if b == 0 else f"ROMX ${b:02X}")
        for n in sections[b]:
            if n in PINNED:  # a hardware-fixed place: anything that grows into it fails the link instead
                out.append(f"\tORG ${PINNED[n]:04X}")
            out.append(f'\t"{n}"')
    return "\n".join(out) + "\n"


def header(listing_name: str, titles: dict[int, dict]) -> str:
    b = int(listing_name[4:6], 16)
    title = titles[b]["title"] if b in titles else "(untitled)"
    return f"; ROM bank ${b:02X}: {title}\n; The annotated listing of this bank is build/listing/{listing_name}.\n\n"


def write_text(path: Path, text: str) -> None:
    """E-0369: write a source file, retrying while Windows briefly refuses it (a file watcher holding it open
    raised OSError 22 twice during regeneration); the text written is unchanged."""
    import time
    for attempt in range(20):
        try:
            path.write_text(text, encoding="utf-8", newline="\n")
            return
        except OSError:
            if attempt == 19:
                raise
            time.sleep(0.25)


REGEN = Path("build/regen/src")  # D-015 (H1a): where the presented tree goes unless src/ is asked for


FIXED_LOAD = re.compile(r"^(\s+)ld (?:hl|de|bc), ([A-Za-z_][\w.]*)\s*(?:;.*)?$")
LOAD_BANKED = re.compile(r"BANK\(|^\s+farcall|^\s+ld b, \$")


def _bank_loaded_after(lines: list[str], i: int, name: str) -> bool:
    """E-0410: within the 7 lines after line i, before any label (another path could join there), a line names
    BANK(name), so the bank goes with the label and an ASSERT would add nothing (E-0414's `ld b, BANK(Table)`)."""
    for x in lines[i + 1:i + 8]:
        if re.match(r"^\.?[A-Za-z_][\w.]*:", x):
            return False
        if f"BANK({name})" in x:
            return True
    return False


def assert_fixed_banks(bodies: dict[int, str]) -> tuple[dict[int, str], int]:
    """E-0401 (M2): a pointer load in a switchable bank into another switchable bank, with no bank named beside it
    (tools/bank_check.py's warning), works because the code that reads it maps that bank itself (a script or
    message bank, a table bank). Each gets `ASSERT BANK(Label) == $BB` after it: no bytes, but a section moved away
    from the bank its reader assumes now fails the link instead of reading another bank's bytes."""
    where: dict[str, int] = {}
    for bank, body in bodies.items():
        cur = None
        for ln in body.split("\n"):
            m = re.match(r"^([A-Za-z_]\w*)::", ln)
            if m:
                cur = m.group(1)
                where[cur] = bank
            elif cur and (m := re.match(r"^(\.[A-Za-z_]\w*):", ln)):
                where[cur + m.group(1)] = bank
    n = 0
    out = {}
    for bank, body in bodies.items():
        lines = body.split("\n")
        if bank == 0:
            out[bank] = body
            continue
        res, cur = [], None
        for i, ln in enumerate(lines):
            res.append(ln)
            m = re.match(r"^([A-Za-z_]\w*)::", ln)
            if m:
                cur = m.group(1)
                continue
            m = FIXED_LOAD.match(ln)
            if not m or cur is None:
                continue
            name = cur + m.group(2) if m.group(2).startswith(".") else m.group(2)
            tb = where.get(name)
            if tb in (None, 0, bank) or any(LOAD_BANKED.search(x) for x in lines[max(0, i - 3):i + 4]):
                continue
            if _bank_loaded_after(lines, i, name):  # E-0414: the same block loads the bank as BANK(name)
                continue
            res.append(f'{m.group(1)}ASSERT BANK({name}) == ${tb:02X}, "{name} is read with bank ${tb:02X} mapped"')
            n += 1
        out[bank] = "\n".join(res)
    return out, n


def main(argv: list[str]) -> int:
    """present.py [LISTING [DEST]] [--write-src]: present LISTING (build/listing) into DEST, by default
    build/regen/src/; --write-src writes src/ itself (D-015). src/ is the hand-edited source after H1a."""
    args = [a for a in argv if not a.startswith("--")]
    src = Path(args[0]) if args else ROOT / "build/listing"
    dest = Path(args[1]) if len(args) > 1 else ROOT / ("src" if "--write-src" in argv else REGEN)
    dest.mkdir(parents=True, exist_ok=True)
    texts = {p.name: p.read_text(encoding="utf-8") for p in sorted(src.glob("bank*.asm"))}
    names = Names(texts, src, dest / "ram.asm")
    titles = bank_titles()
    written = []
    sections: dict[int, list[str]] = {}
    ASSETS.clear()
    presented = {int(name[4:6], 16): present(text, names, int(name[4:6], 16)) for name, text in texts.items()}
    presented, asserted = assert_fixed_banks(presented)
    for name, text in texts.items():
        out = src_name(name, titles)
        (dest / out).parent.mkdir(parents=True, exist_ok=True)
        body, secs = split_sections(presented[int(name[4:6], 16)], int(name[4:6], 16))
        sections[int(name[4:6], 16)] = secs
        write_text(dest / out, header(name, titles) + body)
        written.append(out)
    for stale in {p.relative_to(dest).as_posix() for p in dest.glob("*/bank[0-9a-f][0-9a-f]_*.asm")} - set(written):
        (dest / stale).unlink()  # a bank file under an earlier name or directory
    old = dest / "banks"  # before D-010 every bank file lived here
    if old.is_dir():
        for p in old.glob("bank*.asm"):
            p.unlink()
        if not any(old.iterdir()):
            old.rmdir()
    write_text(dest / "layout.link", layout_text(sections))
    main_asm = dest / "main.asm"
    lines = (main_asm if main_asm.exists() else ROOT / "src/main.asm").read_text(encoding="utf-8").split("\n")
    out_lines = []
    for ln in lines:
        m = re.match(r'INCLUDE "(?:\w+/)?(bank[0-9a-f]{2})(?:_\w+)?\.asm"', ln)
        out_lines.append(f'INCLUDE "{src_name(m.group(1) + ".asm", titles)}"' if m else ln)
    write_text(main_asm, "\n".join(out_lines))
    write_text(dest / "assets.txt",
        "# D-008: the asset files src/ includes, as slices of the reference ROM: path, file offset, length.\n"
        "# tools/build.py extracts them from local/roms/ into the build directory; they are never tracked.\n"
        + "".join(f"{p}\t${o:06X}\t${n:X}\n" for p, (o, n) in sorted(ASSETS.items())))
    print(f"presented {len(texts)} bank files from {src} into {dest}/<dir>/; {asserted} fixed-bank pointer loads asserted")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
