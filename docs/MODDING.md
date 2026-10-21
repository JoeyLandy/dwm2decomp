# Making a mod

Stage H7 of the modding and translation goal ([roadmap](ROADMAP.md)). This page is for people who want to change
the game: its numbers, its text, its pictures or its code. You need Python 3.12 and your own copy of the game:
Dragon Warrior Monsters 2: Cobi's Journey, US release. The project never includes the game itself.

## Set up once

```bash
python -I tools/setup.py --rom PATH/TO/YOUR.gbc
python -I tools/build.py --out build/run1
```

`setup.py` downloads the assembler (RGBDS) for your system and checks it. It also checks that your ROM is the
exact version this project rebuilds. The build should print `RESULT: PASS`: the source turned back into a ROM
identical to yours, byte for byte. That is how you know everything works before you change anything.

## Three ways to change the game

1. **Data and text, as files.** Export the tables (monster stats, skills, items, encounters, breeding, shops) or
   the text to JSON and CSV, edit them in a spreadsheet or a text editor, and keep only what you changed in a mod
   folder. [Editing data](EDITING_DATA.md) and [translating](TRANSLATING.md) explain the formats.
2. **Pictures.** Export the graphics to PNG, edit them, and build with `--mod`. See [editable assets](ASSETS.md).
3. **Code.** Edit the assembly in src/ directly. It is the source; nothing regenerates it. Start with the
   [reading guide](READING_GUIDE.md). Rename things with `tools/rename.py`, so every reference follows.

## A mod folder

A mod is a folder of edits, so it can be shared and combined. mods/example/ is one:

```text
mods/my_mod/
  mod.json        name, version, author, description; "spill" to make room in a full text bank
                  ([translating](TRANSLATING.md#moving-messages-out-of-a-full-bank)); "scripts" to read event
                  scripts from other banks (below)
  data/           edited tables (only the rows or lists you changed)
  text/           edited text (only the entries you changed)
  charmap.inc     extra letters, if your language needs them
  font.png        the font, if you drew new letters
  src/            replacement source files, for code changes
```

```bash
python -I tools/make_mod.py mods/my_mod
```

This builds your mod from a clean copy of the source, so your own checkout stays the original. The output goes to
build/mods/my_mod/:
- `my_mod.bps`, the patch to share;
- `my_mod.gbc`, the modded ROM, for you only;
- `report.json`.

## Event scripts in other banks

The event scripts (who says what, who walks where, which flag is set) are read by an interpreter in bank $10. It
reads a script from bank $10 itself or, after the opcode `script_jump_data_bank`, from the bank the talk routine
put in wDataBank; only a few opcodes work there. Bank $10 has 5,848 free bytes. For a mod that needs more, or wants
its scripts in a bank of their own, `tools/script_bank.py` changes a mod's copy of the source (never src/ itself):
- `patch` lets a script be in any bank and use every opcode. It adds `script_jump_far Label` (opcode $08, unused by
  the game): the script goes on at Label, in Label's bank. Write new scripts in an empty bank
  (src/unused/bankBB_empty.asm) and jump to them from a script in bank $10.
- `move --all --to BB` moves all 656 of bank $10's script runs (6,458 bytes) to the empty bank BB. Every label that
  something outside names keeps a 4-byte stub in bank $10 that jumps there, so nothing that starts a script
  changes, and bank $10 gains 4,685 bytes. `move Script_Label ...` moves only the runs that hold those labels.

```json
{"name": "my_mod", "scripts": {"move": "all", "to": "9F"}}
```

`{"patch": true}` gives the interpreter change alone. Checked on the project's emulator (tests/test_script_bank.py,
E-0421): with every bank-$10 script moved, all 17 recipe chains (279 runs) fetch the same script positions as the
original. The screens differ only where the patched interpreter's extra cycles move a frame: a few VBlanks, and in
one boss battle a button press that lands on another turn (it does the same with the interpreter patch alone).

The scripts of the arena, breeding, the priest and the other menus are in other banks already ($0C, $0D, $0E, $15,
$1D, $1F, $96), each in a section of its own whose bank the talk routine names, so they need no patch. Move one like
any section: `python -I tools/move_section.py --move "Bank 15 Script_Breed" --to 9F` writes the moved copy of src/
to build/move/moved/src, which `make_mod.py --base` builds from. Give `--move` once per section when sections jump
to each other, such as the arena's two; bank_check refuses them apart. Breeding, the priest and library, and an
arena battle play frame for frame as the original with their scripts moved (tests/test_script_sections.py,
E-0422).

## The smoke test

`make_mod.py` runs [the smoke test](../tools/mod_check.py) on every mod. It plays the start of the game on the
project's emulator, beside the original, and reports:
- **a crash** or **code running data**, which means a pointer leads somewhere wrong;
- **lost progress**: the game no longer reaches the field, for example;
- **a stall**: the screen freezes;
- **where the screens first differ**. A mod that changes what you see should differ, and the frame shows where.
  A difference you did not expect is worth a look.

It only covers what the scripted play reaches: the opening and the first steps of the game. For more, give it a
recipe chain from tools/recipes/ (shops, the inn, breeding, the library, key worlds, the late story):
`python -I tools/mod_check.py build/mods/my_mod/my_mod.gbc --sym build/mods/my_mod/build/dwm2.sym --recipe
tools/recipes/e0327_shop_inn.txt --compare` replays it on both ROMs and lists the runs whose screens differ. A
change elsewhere still has to be tried in an emulator.

## Sharing

Share only the `.bps` patch. Never share the ROM: it is the game itself. Players apply the patch to their own copy
with the [patcher page](../patcher/index.html), which runs in their browser and sends nothing anywhere, or with any
BPS patcher. The patch knows which ROM it was made from and refuses any other.

## What the notes in the source mean

Every routine and table in src/ has a note, and each note ends with how sure the project is about it:
- **C1**: a reading of the code. Probably right, not tested.
- **C2**: tested on the project's emulator, for example by running the routine and comparing what it did with the
  note. Still not tested on a real Game Boy.
- **C3**: tested and reviewed within a stated scope.
- **C0**: not understood.

The `E-` number after it points to the [evidence log](EVIDENCE_LOG.md), which says how it was found out. When you
change something whose note is C1, test your mod in play.

## Tutorials

1. [A monster's stats](tutorials/1_monster_stats.md): make wild Slimes tougher.
2. [A line of text](tutorials/2_text.md): reword the opening narration.
3. [A breeding recipe](tutorials/3_breeding.md): a new combination that gives a MetalKing.

tests/test_tutorials.py follows each one from a clean copy of the source and checks the result.
