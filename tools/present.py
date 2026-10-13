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
- each bank file is named and headed by what it holds (config/banks.json, D-006): bank36_battle_effects.asm.

The confidence and evidence of every name stay in config/ (names.json, symbols.json, tables.json) and in the
listing. Run after disasm_all, or alone to re-present an existing listing:

    python -I tools/present.py [LISTING_DIR]
"""
import json
import re
import sys
import textwrap
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
WIDTH = 100

# full-line comments made by the generator from cross-references; the listing keeps them
DROP_COMMENT = re.compile(
    r"; (?:no direct call|\d+ call sites? from |only called from |reads: |writes: |points at: |"
    r"text \(E-0024\)|address loaded by |entry \d+ of the `rst \$00` table|heuristic: )")
ALIAS = re.compile(r"^([A-Za-z_]\w*):: ; address name$")
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
    """Address names and addresses of the listing, mapped to the labels src/ keeps."""

    def __init__(self, texts: dict[str, str]) -> None:
        self.alias: dict[str, str] = {}
        self.at: dict[str, str] = {}  # "BB:AAAA" -> label
        for t in texts.values():
            prev = None
            for ln in t.split("\n"):
                m = ALIAS.match(ln)
                if m and prev:
                    self.alias[m.group(1)] = prev
                    a = ADDR_NAME.match(m.group(1))
                    if a:
                        self.at.setdefault(f"{int(a.group(1), 16):02X}:{a.group(2)}", prev)
                    continue
                m = LABEL.match(ln)
                if m:
                    prev = m.group(1)
                    a = ADDR_NAME.match(prev)
                    if a:
                        self.at.setdefault(f"{int(a.group(1), 16):02X}:{a.group(2)}", prev)

    def sub(self, comment: str) -> str:
        def one(m: re.Match) -> str:
            w = m.group(0)
            return self.alias.get(w) or self.at.get(w) or w
        return MENTION.sub(one, comment)


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


def present(text: str, names: Names) -> str:
    out: list[str] = []
    recent: list[str] = []  # the last distinct full-line comments, to write a table's repeated comment once
    for ln in text.split("\n"):
        if ALIAS.match(ln):
            continue
        s = ln.lstrip()
        if s.startswith(";"):
            if DROP_COMMENT.match(s):
                continue
            c = reword(names.sub(s))
            if c in recent:
                continue
            recent = (recent + [c])[-4:]
            out.extend(wrap(ln[:len(ln) - len(s)], c))
            continue
        m = LABEL_TAG.match(ln)
        if m:
            ln = m.group(1)
        elif not LABEL.match(ln):
            code, comment = split_code(ln)
            if comment:
                ln = code + names.sub(comment)
            ln = code_line(ln)
            op = code.split(None, 1)[0] if code.strip() else ""
            if op and op not in DATA_OPS and not op.startswith(("script_", "objsel_")):
                recent = []  # instructions end a table: a later repeat is a new comment
        if ln == "" and out and out[-1] == "":
            continue  # a dropped block can leave two blank lines
        out.append(ln)
    return "\n".join(out)


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
    for name, text in texts.items():
        out = src_name(name, titles)
        (dest / out).write_text(header(name, titles) + present(text, names), encoding="utf-8", newline="\n")
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
    print(f"presented {len(texts)} bank files from {src} into {dest}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
