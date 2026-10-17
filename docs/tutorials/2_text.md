# Tutorial 2: a line of text

Goal: reword the narration at the very start of a new game, "In the middle of the sea in the south floats the
island GreatLog." The finished mod is mods/tutorial_text/.

## 1. Find the text

```bash
python -I tools/text.py export --out build/text/en.json
```

Search build/text/en.json for "In the middle". The entry is `Message_00_00`:

```text
In the middle of<LINE>the sea in the<PROMPT><NEXT>south floats the<NEXT>island GreatLog.<PROMPT>...
```

`<LINE>` and `<NEXT>` start a new line, and `<PROMPT>` waits for a button with a blinking arrow. Lines hold at
most 18 characters (`max_width`). [Translating](../TRANSLATING.md) lists the other tokens.

## 2. Change it

Make a mod folder with a text file holding just this entry:

```text
mods/my_text/
  mod.json
  text/en.json     {"entries": [{"id": "Message_00_00", "max_width": 18, "text": "..."}]}
```

The tutorial's new text starts:

```text
Far out in the<LINE>southern sea lies<PROMPT><NEXT>the island of<NEXT>GreatLog.<PROMPT>...
```

The rest of the entry is unchanged. Keep every line within 18 characters. If one is too long, the tool says which
and changes nothing.

## 3. Build it

```bash
python -I tools/make_mod.py mods/my_text
```

The opening is in the smoke test's scripted play, so this time the report says the screens first differ where the
narration is drawn. That is the change you made, and the game still reaches the field as the original does.

## What changed, and how we know

tests/test_tutorials.py builds this mod and runs the smoke test: the game's progress (the opening, then the
field) is the original's, and the screens differ from the narration on. It also decodes the bytes now at
Message_00_00 in the modded ROM, and they are the new text.
