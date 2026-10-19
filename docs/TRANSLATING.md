# Translating the game

Stage H3 of the modding and translation goal ([roadmap](ROADMAP.md)), evidence E-0409 in the
[evidence log](EVIDENCE_LOG.md). All the game's text is in src/text/, the source (D-015). `tools/text.py` exports it
for translators and puts translations back.

```bash
python -I tools/text.py export --out build/text/en.json
python -I tools/text.py import build/text/de.json
python -I tools/build.py --out build/run1
```

## The text file

`export` writes one JSON file with every text entry of src/text/: 5,407 on 2026-10-17. Each entry has:
- `id`: its label in src/ (Message_00_0A);
- `file` and `bank`: where it is;
- `kind`: `message` (dialogue and battle text) or `string` (names, menu words);
- `used_by`: the pointer tables that name it (StringList_Bank28_0[10]): where the game takes it from;
- `max_width`: the most cells one line may hold;
- `text`: what to translate.

Translate `text` and leave the rest. In `text`:
- `<LINE>`, `<NEXT>`, `<PROMPT>`, `<WAIT>`, `<CLEAR>` and the other tokens in angle brackets are printer commands:
  keep them, and move the line breaks to fit your words. src/charmap.inc says what each does.
- `<PLAYER>` and `<BUF0>`-`<BUF3>` insert a name. Keep them, and leave room for the name on that line.
- `{$7e}` is an argument byte of the command before it (a sound number, a cursor position): keep it.
- `@` ends the text.
- `'s`, `'m`, `'r`, `'t`, `'v`, `'l` are single glyphs in English; in another language just write letters.

`import` rewrites only the entries whose text changed. It stops, and writes nothing, on any of these:
- a character the charmap does not have;
- a line wider than `max_width`;
- a bank without room for the longer text.

An unchanged import rewrites nothing (`python -I tools/text.py check`).

## Width

A line's width is the number of cells between line breaks: `<LINE>`, `<NEXT>`, `<CLEAR>`, `<HOME>` and
`<CURSOR>`. Every character is one cell, and so are the contraction glyphs and "*:".
- **Dialogue and battle text:** 18 cells. That is the longest line the game has, and the text window is 20 tiles
  with a border tile on each side (C1).
- **Strings:** the longest original entry in the same list (C1, inferred). A monster name longer than the longest
  English one may not fit where the game draws it.
- **Names inserted by tokens:** count as nothing, so leave room.

## New letters

The font is in src/ (GlyphFont, bank $1F): 185 glyphs of 8 x 8 pixels, codes $00-$B8.
1. `python -I tools/text.py free-glyphs` lists the codes no text uses and the charmap does not name. On 2026-10-17
   there were 75, 49 of them blank.
2. Add a line for your letter to src/charmap.inc: `CHARMAP "ü", $49`.
3. `python -I tools/text.py font-export --out build/text/font.png` writes the font as a 128 x 96 PNG, 16 glyphs a
   row: glyph $49 is column 9, row 4. Draw the letter in black on white, and
   `python -I tools/text.py font-import build/text/font.png` writes it back into src/.
4. Use the letter in your text.

## Room in the banks

A longer translation needs room in the bank its text lives in. Free bytes at the end of each text bank on
2026-10-17:

| Banks | Free bytes |
| --- | --- |
| $28 | 47 |
| $29, $2A, $2B, $2C, $2E, $7C, $82, $83, $99 | 167-387 |
| $2D, $80, $89 | 69-142 |
| $2F (battle text) | 725 |
| $08, $09, $0B, $86, $88, $8A, $95, $96, $A2 (strings and some messages) | 3,095-12,313 |
| $97, $98 (overflow tables) | 0 |

The message banks are nearly full, so a full translation into a longer language will run out of room in banks
like $28. The game already splits large groups. In message group 0, `BeginStringDisplay_Bank28` and
`CopyStringToBuffer_Bank28` send indexes from $DA on to bank $97 (`..._Overflow`, which subtracts $DA and uses
`MessageStrings_Bank28_Overflow`). Twelve message banks are split this way; `python -I tools/text_spill.py groups`
lists them with their splits and free bytes.

### Moving messages out of a full bank

`tools/text_spill.py spill BANK N` moves the last N messages of a split bank to its overflow table, so the bank
gains their bytes. Message ids stay the same, so nothing that shows a message changes. It:
- lowers the split by N (the `cp` in the bank's two routines and the `sub` in the two overflow routines);
- moves the last N pointers to the front of the overflow list;
- moves their messages to the overflow bank.

The overflow table, its messages and its routines must share one bank. LookupString records the bank the table is
in, and the text printer reads the message from that bank. The overflow banks $97 and $98 are full, so add
`--to BB` with one of the 99 empty banks (src/unused/bankBB_empty.asm): the whole overflow group moves there
first, as src/text/bankBB_messages_GG_overflow.asm.

It works only on a mod's copy of src/, never on src/ itself, because the matching build must keep the original
layout. In a mod folder, list the spills in mod.json; tools/make_mod.py applies them before your text:

```json
{"name": "my_translation", "spill": [{"bank": "28", "count": 9, "to": "9A"}]}
```

It refuses an N that would split a message two ids share (Message_00_AC is shown by an id on each side of
a split lowered by 10). It then suggests the nearest N that works. It also refuses an overflow bank without room. A
refusal changes nothing. tools/text.py's "no room" refusal names this tool.

Checked on tools/sm83.py (C2, the project's emulator; tests/test_text_spill.py, E-0416). All twelve groups
spilled in one copy build, and every id shows and copies the same message as the original: 3,046 ids, with 21
skipped that have no end mark in the original. Bank $83's ids from $F2 point at the zero tail of bank $97. After
a spill, 30 bank-$28 messages that did not fit before fit, and the opening draws the longer narration. One
difference: `CopyStringToBuffer_Bank82` far-calls the display overflow routine instead of the copy one (E-0080, a
likely game bug kept as it is). After a spill it therefore copies nothing for the moved ids either. Nothing in the
game calls it.

## How it is checked

tests/test_text_pipeline.py (on the project's emulator, C2, not hardware):
- **Round trip:** every entry's text gives back its bytes, and an unchanged import rewrites nothing. Two entries,
  Message_0B_8F and String_88_02_AD, end in raw bytes after their end mark that read as text, so an edit
  re-renders them as text with the same bytes.
- **A German test translation:** a copy of src/ gets "ü" (`CHARMAP "ü", $49` and its glyph drawn through the font
  PNG), and the farmhand's first message on the opening ship, Message_00_0A, becomes "Gleich sind wir über
  GreatLog da." plus a new line "Ich bin gespannt!". The text is longer than the English, and bank $28's fill
  takes up the difference. The copy builds as a mod. The E-0320 recipe is replayed on the reference to just
  before the conversation, the modded ROM is put in, and the game talks: the text printer draws the German
  glyphs, ü among them, and the font rows at GlyphFont + 16 x $49 in the modded ROM are the new letter.
- **Refusals:** an unknown character, a line too wide and a bank without room (30 longer entries in bank $28)
  are each refused.

## Limits

- Only src/text/ is exported. Text written another way (tile maps of title screens, graphics with words in them)
  is graphics: edit its PNG (docs/ASSETS.md).
- Name widths and the room the windows have are inferred from the game's own text (C1).
- Moving messages works for the twelve split message groups (above). Text in other banks (strings, battle text,
  bank $0E's group) still has only its bank's fill.
