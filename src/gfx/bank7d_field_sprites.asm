; ROM bank $7D: field sprites
; The annotated listing of this bank is build/listing/bank7d.asm.

SECTION "Bank 7D", ROMX[$4000], BANK[$7D]
    db $7d

; compressed sprite graphics number $00 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 249 bytes that expand to 256 (E-0016, E-0017)
FieldSpriteGfx00::
    INCBIN "gfx/field_sprites/00.lz"

; compressed sprite graphics number $01 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 231 bytes that expand to 256 (E-0016, E-0017)
FieldSpriteGfx01::
    INCBIN "gfx/field_sprites/01.lz"

; compressed sprite graphics number $02 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 220 bytes that expand to 256 (E-0016, E-0017)
FieldSpriteGfx02::
    INCBIN "gfx/field_sprites/02.lz"

; compressed sprite graphics number $03 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 209 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx03::
    INCBIN "gfx/field_sprites/03.lz"

; compressed sprite graphics number $04 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 202 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx04::
    INCBIN "gfx/field_sprites/04.lz"

; compressed sprite graphics number $05 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 198 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx05::
    INCBIN "gfx/field_sprites/05.lz"

; compressed sprite graphics number $06 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 164 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx06::
    INCBIN "gfx/field_sprites/06.lz"

; compressed sprite graphics number $07 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 186 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx07::
    INCBIN "gfx/field_sprites/07.lz"

; compressed sprite graphics number $08 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 191 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx08::
    INCBIN "gfx/field_sprites/08.lz"

; compressed sprite graphics number $09 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 188 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx09::
    INCBIN "gfx/field_sprites/09.lz"

; compressed sprite graphics number $0A of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 198 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx0A::
    INCBIN "gfx/field_sprites/0_a.lz"

; compressed sprite graphics number $0B of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 215 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx0B::
    INCBIN "gfx/field_sprites/0_b.lz"

; compressed sprite graphics number $0C of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 235 bytes that expand to 256 (E-0016, E-0017)
FieldSpriteGfx0C::
    INCBIN "gfx/field_sprites/0_c.lz"

; compressed sprite graphics number $0D of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 203 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx0D::
    INCBIN "gfx/field_sprites/0_d.lz"

; compressed sprite graphics number $0E of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 215 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx0E::
    INCBIN "gfx/field_sprites/0_e.lz"

; compressed sprite graphics number $0F of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 225 bytes that expand to 240 (E-0016, E-0017)
FieldSpriteGfx0F::
    INCBIN "gfx/field_sprites/0_f.lz"

; compressed sprite graphics number $10 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 213 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx10::
    INCBIN "gfx/field_sprites/10.lz"

; compressed sprite graphics number $11 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 223 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx11::
    INCBIN "gfx/field_sprites/11.lz"

; compressed sprite graphics number $12 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 202 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx12::
    INCBIN "gfx/field_sprites/12.lz"

; compressed sprite graphics number $13 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 227 bytes that expand to 240 (E-0016, E-0017)
FieldSpriteGfx13::
    INCBIN "gfx/field_sprites/13.lz"

; compressed sprite graphics number $14 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 218 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx14::
    INCBIN "gfx/field_sprites/14.lz"

; compressed sprite graphics number $15 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 194 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx15::
    INCBIN "gfx/field_sprites/15.lz"

; compressed sprite graphics number $16 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 211 bytes that expand to 256 (E-0016, E-0017)
FieldSpriteGfx16::
    INCBIN "gfx/field_sprites/16.lz"

; compressed sprite graphics number $17 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 204 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx17::
    INCBIN "gfx/field_sprites/17.lz"

; compressed sprite graphics number $18 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 160 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx18::
    INCBIN "gfx/field_sprites/18.lz"

; compressed sprite graphics number $19 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 175 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx19::
    INCBIN "gfx/field_sprites/19.lz"

; compressed sprite graphics number $1A of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 191 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx1A::
    INCBIN "gfx/field_sprites/1_a.lz"

; compressed sprite graphics number $1B of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 200 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx1B::
    INCBIN "gfx/field_sprites/1_b.lz"

; compressed sprite graphics number $1C of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 205 bytes that expand to 256 (E-0016, E-0017)
FieldSpriteGfx1C::
    INCBIN "gfx/field_sprites/1_c.lz"

; compressed sprite graphics number $1D of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 206 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx1D::
    INCBIN "gfx/field_sprites/1_d.lz"

; compressed sprite graphics number $1E of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 218 bytes that expand to 256 (E-0016, E-0017)
FieldSpriteGfx1E::
    INCBIN "gfx/field_sprites/1_e.lz"

; compressed sprite graphics number $1F of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 197 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx1F::
    INCBIN "gfx/field_sprites/1_f.lz"

; compressed sprite graphics number $20 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 215 bytes that expand to 256 (E-0016, E-0017)
FieldSpriteGfx20::
    INCBIN "gfx/field_sprites/20.lz"

; compressed sprite graphics number $21 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 218 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx21::
    INCBIN "gfx/field_sprites/21.lz"

; compressed sprite graphics number $22 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 221 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx22::
    INCBIN "gfx/field_sprites/22.lz"

; compressed sprite graphics number $23 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 203 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx23::
    INCBIN "gfx/field_sprites/23.lz"

; compressed sprite graphics number $24 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 208 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx24::
    INCBIN "gfx/field_sprites/24.lz"

; compressed sprite graphics number $25 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 204 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx25::
    INCBIN "gfx/field_sprites/25.lz"

; compressed sprite graphics number $26 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 203 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx26::
    INCBIN "gfx/field_sprites/26.lz"

; compressed sprite graphics number $27 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 217 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx27::
    INCBIN "gfx/field_sprites/27.lz"

; compressed sprite graphics number $28 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 225 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx28::
    INCBIN "gfx/field_sprites/28.lz"

; compressed sprite graphics number $29 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
FieldSpriteGfx29::
    INCBIN "gfx/field_sprites/29.lz"

; compressed sprite graphics number $2A of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 194 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx2A::
    INCBIN "gfx/field_sprites/2_a.lz"

; compressed sprite graphics number $2B of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 218 bytes that expand to 240 (E-0016, E-0017)
FieldSpriteGfx2B::
    INCBIN "gfx/field_sprites/2_b.lz"

; compressed sprite graphics number $2C of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 236 bytes that expand to 256 (E-0016, E-0017)
FieldSpriteGfx2C::
    INCBIN "gfx/field_sprites/2_c.lz"

; compressed sprite graphics number $2D of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 199 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx2D::
    INCBIN "gfx/field_sprites/2_d.lz"

; compressed sprite graphics number $2E of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 206 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx2E::
    INCBIN "gfx/field_sprites/2_e.lz"

; compressed sprite graphics number $2F of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 208 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx2F::
    INCBIN "gfx/field_sprites/2_f.lz"

; compressed sprite graphics number $30 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 194 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx30::
    INCBIN "gfx/field_sprites/30.lz"

; compressed sprite graphics number $31 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 164 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx31::
    INCBIN "gfx/field_sprites/31.lz"

; compressed sprite graphics number $32 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 180 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx32::
    INCBIN "gfx/field_sprites/32.lz"

; compressed sprite graphics number $33 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 191 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx33::
    INCBIN "gfx/field_sprites/33.lz"

; compressed sprite graphics number $34 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 212 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx34::
    INCBIN "gfx/field_sprites/34.lz"

; compressed sprite graphics number $35 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 192 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx35::
    INCBIN "gfx/field_sprites/35.lz"

; compressed sprite graphics number $36 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 185 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx36::
    INCBIN "gfx/field_sprites/36.lz"

; compressed sprite graphics number $37 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
FieldSpriteGfx37::
    INCBIN "gfx/field_sprites/37.lz"

; compressed sprite graphics number $38 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 207 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx38::
    INCBIN "gfx/field_sprites/38.lz"

; compressed sprite graphics number $39 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 224 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx39::
    INCBIN "gfx/field_sprites/39.lz"

; compressed sprite graphics number $3A of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 222 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx3A::
    INCBIN "gfx/field_sprites/3_a.lz"

; compressed sprite graphics number $3B of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 184 bytes that expand to 192 (E-0016, E-0017)
FieldSpriteGfx3B::
    INCBIN "gfx/field_sprites/3_b.lz"

; compressed sprite graphics number $3C of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 171 bytes that expand to 192 (E-0016, E-0017)
FieldSpriteGfx3C::
    INCBIN "gfx/field_sprites/3_c.lz"

; compressed sprite graphics number $3D of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 212 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx3D::
    INCBIN "gfx/field_sprites/3_d.lz"

; compressed sprite graphics number $3E of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 182 bytes that expand to 192 (E-0016, E-0017)
FieldSpriteGfx3E::
    INCBIN "gfx/field_sprites/3_e.lz"

; compressed sprite graphics number $3F of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 187 bytes that expand to 208 (E-0016, E-0017)
FieldSpriteGfx3F::
    INCBIN "gfx/field_sprites/3_f.lz"

; compressed sprite graphics number $40 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 229 bytes that expand to 240 (E-0016, E-0017)
FieldSpriteGfx40::
    INCBIN "gfx/field_sprites/40.lz"

; compressed sprite graphics number $41 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 202 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx41::
    INCBIN "gfx/field_sprites/41.lz"

; compressed sprite graphics number $42 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 220 bytes that expand to 240 (E-0016, E-0017)
FieldSpriteGfx42::
    INCBIN "gfx/field_sprites/42.lz"

; compressed sprite graphics number $43 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 187 bytes that expand to 192 (E-0016, E-0017)
FieldSpriteGfx43::
    INCBIN "gfx/field_sprites/43.lz"

; compressed sprite graphics number $44 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 182 bytes that expand to 192 (E-0016, E-0017)
FieldSpriteGfx44::
    INCBIN "gfx/field_sprites/44.lz"

; compressed sprite graphics number $45 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 186 bytes that expand to 224 (E-0016, E-0017)
FieldSpriteGfx45::
    INCBIN "gfx/field_sprites/45.lz"

; compressed sprite graphics number $46 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 61 bytes that expand to 64 (E-0016, E-0017)
FieldSpriteGfx46::
    db $40, $00, $01, $1f, $1f, $7f, $77, $ff, $9a, $ff, $98, $7f, $7a, $ff, $da, $df
    db $b4, $ff, $d2, $1f, $1f, $e0, $ff, $df, $60, $01, $14, $04, $cf, $f0, $ff, $f1
    db $ff, $90, $7f, $7c, $07, $06, $03, $03, $00, $01, $29, $00, $00, $c3, $fc, $c0
    db $ff, $c0, $7f, $c0, $ef, $c0, $ef, $40, $e6, $40, $e6, $40, $66

; compressed sprite graphics number $47 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 377 bytes that expand to 432 (E-0016, E-0017)
FieldSpriteGfx47::
    INCBIN "gfx/field_sprites/47.lz"

; compressed sprite graphics number $48 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 351 bytes that expand to 464 (E-0016, E-0017)
FieldSpriteGfx48::
    INCBIN "gfx/field_sprites/48.lz"

; compressed sprite graphics number $49 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 185 bytes that expand to 256 (E-0016, E-0017)
FieldSpriteGfx49::
    INCBIN "gfx/field_sprites/49.lz"

; compressed sprite graphics number $4A of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 67 bytes that expand to 64 (E-0016, E-0017)
FieldSpriteGfx4A::
    INCBIN "gfx/field_sprites/4_a.lz"

; compressed sprite graphics number $4B of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 180 bytes that expand to 192 (E-0016, E-0017)
FieldSpriteGfx4B::
    INCBIN "gfx/field_sprites/4_b.lz"

; compressed sprite graphics number $4C of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 241 bytes that expand to 256 (E-0016, E-0017)
FieldSpriteGfx4C::
    INCBIN "gfx/field_sprites/4_c.lz"

; compressed sprite graphics number $4D of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 184 bytes that expand to 192 (E-0016, E-0017)
FieldSpriteGfx4D::
    INCBIN "gfx/field_sprites/4_d.lz"

; compressed sprite graphics number $4E of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 218 bytes that expand to 240 (E-0016, E-0017)
FieldSpriteGfx4E::
    INCBIN "gfx/field_sprites/4_e.lz"

; compressed sprite graphics number $4F of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4
; with hTemp2 non-zero)
; LZSS-compressed: 233 bytes that expand to 240 (E-0016, E-0017)
FieldSpriteGfx4F::
    INCBIN "gfx/field_sprites/4_f.lz"
    ds $10, $00
