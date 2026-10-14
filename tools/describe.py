"""Describe a routine from its instructions, for labels that reach src/ without a written note (E-0347).

pokered documents every routine with a comment. Notes written by reading live in config/names.json; for the
rest, tools/present.py asks this module for a one-paragraph restatement of what the instructions do:

    ; step 1 of SceneRoltElder: increments wObject1 + OBJ_X; decrements wObject2 + OBJ_Y; returns unless
    ; it is $60; sets wObject2 + OBJ_STATE to 1; advances wScriptStep

It reads the presented instructions (pret spelling) and the bookkeeping the listing had above the label
(`entry N of the rst $00 table in P`, `only called from X`). It restates instructions, it does not interpret
them: a comment from here says what the code does, not why, and carries no evidence id. Branches inside the
routine are summarised as "depending on X"; only the first clauses are kept.
"""
import re

# helpers whose call says nothing a reader needs in a summary (address arithmetic, waits)
QUIET = re.compile(r"^(?:AddAx9ToHL|AddDoubleAToHL\w*|AddAToHL\w*|WaitForVRAMAccess\w*|DelayFrame\w*|"
                   r"ReadWordTableEntry\w*|CompareHLToBC\w*|ShiftHLRight\d\w*|Multiply\w*|Divide\w*)$")
MESSAGE_CALL = re.compile(r"(?:Message|ShowString|BeginString|PrintText)")
SCRIPT_CALL = re.compile(r"StartScript")
SOUND_CALL = re.compile(r"(?:QueueSoundEffect|PlaySound|PlayMusic|QueueMusic)")
FLAG_CALL = re.compile(r"^(Set|Clear|Test)FlagBit")
MAX_CLAUSES = 7


def _code(line: str) -> str:
    q, out = False, []
    for ch in line:
        if ch == '"':
            q = not q
        elif ch == ";" and not q:
            break
        out.append(ch)
    return "".join(out).strip()


def _note(line: str) -> str:
    m = re.search(r";\s*(?:script |battle text )?'(.+)'\s*$", line)
    return m.group(1) if m else ""


def _quote(text: str, words: int = 6) -> str:
    ws = text.replace("*: ", "").split()
    return "'" + " ".join(ws[:words]) + ("...'" if len(ws) > words else "'")


REGS = {"a", "b", "c", "d", "e", "h", "l", "af", "bc", "de", "hl", "sp", "hli", "hld", "hl+", "hl-"}


def _num(v: int) -> str:
    return str(v) if v < 10 else f"${v:02x}"


def summarize(label: str, body: list[str], dropped: list[str], labels: set[str] | frozenset = frozenset()) -> str:
    role = ""
    for d in dropped:
        m = re.search(r"entry (\d+) of the `rst \$00` table in (\w+)", d)
        if m:
            role = f"step {m.group(1)} of {m.group(2)}"
            break
        m = re.search(r"only called from (\w+)", d)
        if m and not role and m.group(1) in labels:
            role = f"called from {m.group(1)}"
    clauses: list[str] = []
    a_src = None        # what A holds: "$NN", "0", a RAM name, or None
    a_const = None
    hl = de = None      # symbols HL / DE were loaded with
    pend_hl_note = pend_d_note = ""
    cmp = None          # (subject, value) of the last cp / and / bit
    for ln in body:
        c = _code(ln)
        if not c or c.endswith(":"):
            continue
        op, _, rest = c.partition(" ")
        args = [x.strip() for x in rest.split(",")] if rest else []

        def add(cl: str) -> None:
            if cl and (not clauses or clauses[-1] != cl):
                clauses.append(cl)

        if op == "xor" and args == ["a"]:
            a_src, a_const = "0", 0
        elif op == "ld" and len(args) == 2:
            dst, src = args
            if dst == "a":
                m = re.fullmatch(r"\$([0-9a-f]{2})", src)
                if m:
                    a_src, a_const = f"${m.group(1)}", int(m.group(1), 16)
                elif src in ("[de]", "[bc]"):
                    a_src, a_const = (f"the byte at {de}" if src == "[de]" and de else None), None
                elif re.fullmatch(r"\[(?:\w+(?: \+ \w+)?)\]", src) and not src.startswith("[hl"):
                    a_src, a_const = src[1:-1], None
                elif src.startswith("[hl"):
                    a_src, a_const = (f"the byte at {hl}" if hl else None), None
                else:
                    a_src, a_const = None, None
            elif dst == "hl":
                hl, pend_hl_note = (src if not re.fullmatch(r"\$[0-9a-f]+", src) else None), _note(ln)
            elif dst == "de":
                de = src
            elif dst == "d":
                pend_d_note = _note(ln)
            elif re.fullmatch(r"\[(\w+(?: \+ \w+)?)\]", dst) and src == "a" and dst[1:-1] not in REGS:
                var = dst[1:-1]
                if a_src == var + "+1":
                    add(f"increments {var}")
                elif a_src == var + "-1":
                    add(f"decrements {var}")
                elif a_const is not None:
                    add(f"sets {var} to {_num(a_const)}")
                elif a_src and a_src != var:
                    add(f"copies {a_src} to {var}")
                else:
                    add(f"sets {var}")
            elif dst == "[hl]" and hl and re.fullmatch(r"\$[0-9a-f]{2}", src):
                add(f"sets {hl} to {_num(int(src[1:], 16))}")
        elif op in ("inc", "dec") and args == ["a"] and a_src and re.fullmatch(r"\w+(?: \+ \w+)?", a_src):
            a_src = a_src + ("+1" if op == "inc" else "-1")
        elif op in ("inc", "dec") and args == ["[hl]"] and hl:
            add(("advances " if op == "inc" and re.search(r"Step|State|Phase", hl) else
                 "increments " if op == "inc" else "decrements ") + hl)
        elif op in ("set", "res") and len(args) == 2 and args[1] == "[hl]" and hl:
            add(f"{'sets' if op == 'set' else 'clears'} {args[0]} of {hl}" if not args[0].isdigit()
                else f"{'sets' if op == 'set' else 'clears'} bit {args[0]} of {hl}")
        elif op == "cp" and args:
            subj = re.sub(r"[+-]1$", "", a_src) if a_src else None
            cmp = (subj, args[0])
        elif op in ("and", "or") and args == ["a"]:
            cmp = (a_src, "0")
        elif op == "bit" and len(args) == 2:
            subj = a_src if args[1] == "a" else (hl if args[1] == "[hl]" else args[1])
            cmp = (subj, f"bit {args[0]}")
        elif op == "ret" and args:
            cond = args[0]
            if cmp and cmp[0]:
                subj, val = cmp
                if val.startswith("bit "):
                    test = f"{val} of {subj} is set"
                    add(f"returns {'if' if cond == 'nz' else 'unless'} {test}" if cond in ("z", "nz") else
                        "may return early")
                elif val == "0":
                    add(f"returns {'if' if cond == 'z' else 'unless'} {subj} is 0" if cond in ("z", "nz") else
                        "may return early")
                elif cond in ("z", "nz"):
                    add(f"returns {'if' if cond == 'z' else 'unless'} {subj} is {val}")
                else:
                    add(f"returns if {subj} is {'below' if cond == 'c' else 'at least'} {val}")
            else:
                add("may return early")
        elif op in ("call", "farcall", "farcall_b") and args:
            f = args[-1]
            fm = FLAG_CALL.match(f)
            if fm and de and de.startswith(("EVENT_", "$")):
                add({"Set": "sets", "Clear": "clears", "Test": "checks"}[fm.group(1)] + f" {de}")
            elif MESSAGE_CALL.search(f) and pend_hl_note:
                add(f"shows {_quote(pend_hl_note)}")
                pend_hl_note = ""
            elif "BattleText" in f and pend_d_note:
                add(f"shows battle text {_quote(pend_d_note)}")
                pend_d_note = ""
            elif SCRIPT_CALL.search(f) and hl and hl.startswith("Script_"):
                add(f"starts {hl}")
            elif SOUND_CALL.search(f) and a_const is not None:
                add(f"plays {'music' if 'Music' in f else 'sound'} ${a_const:02x}")
            elif not QUIET.match(f):
                add(f"calls {f}")
            a_src = a_const = None
            cmp = None
        elif op in ("jp", "jr") and len(args) == 1 and args[0] and not args[0].startswith(".") and args[0] != "hl":
            add(f"continues in {args[0]}")
        elif op in ("jp", "jr") and len(args) == 2 and not args[1].startswith("."):
            add(f"may continue in {args[1]}")
        elif op in ("jr", "jp") and len(args) == 2 and cmp and cmp[0]:
            subj = cmp[0]
            add(f"branches on {subj}")
        elif op == "jumptable":
            add(f"dispatches on {a_src}" if a_src else "dispatches through the table that follows")
        elif op in ("ret", "reti") and not args:
            pass
    if not clauses:
        tail = [_code(x) for x in body if _code(x) and not _code(x).endswith(":")]
        if tail[:1] == ["ret"]:
            clauses = ["returns at once"]
        elif not tail:
            clauses = ["falls through into the next routine"]
        else:
            clauses = ["works on registers only"]
    more = len(clauses) > MAX_CLAUSES
    text = "; ".join(clauses[:MAX_CLAUSES]) + ("; ..." if more else "")
    return f"{role}: {text}" if role else text[:1].upper() + text[1:]


def data_note(label: str, body: list[str], labels: set[str] | frozenset = frozenset(),
              referrer: str | None = None) -> str:
    """A header for a data block with no note: its reader (the label it extends) and its size."""
    nbytes = nwords = 0
    for ln in body:
        c = _code(ln)
        op, _, rest = c.partition(" ")
        if op == "db":
            nbytes += len([x for x in rest.split(",") if x.strip()])
        elif op == "dw":
            nwords += len([x for x in rest.split(",") if x.strip()])
    size = ", ".join(x for x in (f"{nbytes} byte{'s' * (nbytes != 1)}" if nbytes else "",
                                 f"{nwords} word{'s' * (nwords != 1)}" if nwords else "") if x)
    reader = None
    m = re.match(r"^(\w+?)_(?:Data\d*|TileRect|Tiles|Table|Palette\w*|\w*Data)$", label)
    if m and m.group(1) in labels:
        reader = m.group(1)
    reader = reader or referrer
    if reader:
        return f"data read by {reader}" + (f" ({size})" if size else "")
    return f"data block ({size})" if size else "data block"
