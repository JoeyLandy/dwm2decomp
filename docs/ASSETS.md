# Editable assets

Stage M3 of the moddable-decomp goal ([roadmap](ROADMAP.md)), evidence E-0394 in the [evidence log](EVIDENCE_LOG.md).
Every compressed asset src/ includes (`INCBIN "gfx/....lz"`, `INCBIN "maps/....lz"`; the list is src/assets.txt) is
built from decoded data. You edit pictures as PNG files or any asset as raw bytes, and the build compresses them
again.

## How the build makes the asset files

The game's assets are LZSS streams (tools/lzss_gfx.py decodes them). tools/lzss_encode.py is an encoder that
reproduces all 3,546 streams in the ROM byte for byte. It is Haruhiko Okumura's LZSS.C binary-tree search with:

- a 4,096-byte ring starting at position 0, zero-filled;
- a lookahead of 96 bytes (no reference in the ROM is longer) and a minimum match of 4;
- the game's token format: a marker byte, the lowest byte value absent from the data, before each reference.

`python -I tools/build.py --out build/runN` decodes each stream from the reference ROM and encodes it again. No
compressed byte is copied from the ROM, and the build stops if a re-encoded stream differs from the reference.
Two kinds of slice keep raw bytes as they are:
- 3 slices hold bytes after their stream that the game never decodes;
- 4 streams end inside the next slice (the decoder's last read is that slice's first byte or two).

## Editing an asset

1. Export the decoded assets to an ignored directory. They come from the game, so they stay out of git, like the ROM:

   ```bash
   python -I tools/assets.py export --out local/assets
   ```

   This writes `<path>.bin` (raw decoded bytes) for every asset, and `<path>.png` for tile graphics: paths under
   gfx/ and map tilesets, 1,020 files. A PNG is as many tiles wide as the largest divisor of its tile count up
   to 16, so it has no padding, and it converts back exactly (rgbgfx). Screens and attribute maps are only `.bin`.
2. Edit a PNG (four grays, same size) or a `.bin`. Keep only the files you change in the directory you build
   from, or leave the rest as exported: a file that still holds the original data builds exactly like the
   reference.
3. Build a modded ROM:

   ```bash
   python -I tools/build.py --out build/mod --mod local/assets
   ```

   The build uses a scratch copy of src/. When an edited asset compresses to a different size, the trailing `ds`
   fill of its bank grows or shrinks by the difference, so the bank keeps its size and everything after the asset
   moves. Labels and `dfar` pointers follow it (M2, [shiftability](SHIFTABILITY.md)). If a bank has too little
   free space, the build says how many bytes are missing: move a section to another bank first
   (tools/move_section.py, src/layout.link). The result is reported as a MODDED BUILD with its byte difference from
   the reference; it is never the matching target.

Checked (E-0394):
- Building from a complete export changes nothing: all 3,546 assets, 1,020 of them through PNG and rgbgfx, give a
  byte-identical ROM.
- Inverting the colours of gfx/monster_pics/slime.png grows its stream by one byte, and bank $74's fill takes it
  (74 to 73 bytes). At its label the Slime decodes to the edited picture, and the 51 other pictures of the bank
  decode as before (42 of them moved). The modded ROM runs 3,000 frames on tools/sm83.py.

## Limits

- Decoded data must fit the format: at most 4,096 bytes, and at least one byte value must not occur in it (the marker).
- A PNG must keep the four gray levels; rgbgfx decides the colour order from them as it does on export.
- What a stream holds (tiles, a screen, an attribute map) and where the game copies it come from its notes in src/
  and are mostly C1; the build checks bytes, not what is shown.
- The shared tails of four streams hold only while both streams are unedited and stay in order.
