; ROM bank $3C: battle effect graphics
; The annotated listing of this bank is build/listing/bank3c.asm.

SECTION "Bank 3C", ROMX[$4000], BANK[$3C]
    db $3c

; compressed battle effect graphics, entry 0 of BattleEffectGraphicsTable
; LZSS-compressed: 355 bytes that expand to 416 (E-0016, E-0017)
BattleEffectGfx00::
    INCBIN "gfx/battle_effects/00.lz"

; compressed battle effect graphics, entry 1 of BattleEffectGraphicsTable
; LZSS-compressed: 586 bytes that expand to 608 (E-0016, E-0017)
BattleEffectGfx01::
    INCBIN "gfx/battle_effects/01.lz"

; compressed battle effect graphics, entry 2 of BattleEffectGraphicsTable
; LZSS-compressed: 733 bytes that expand to 768 (E-0016, E-0017)
BattleEffectGfx02::
    INCBIN "gfx/battle_effects/02.lz"

; compressed battle effect graphics, entry 3 of BattleEffectGraphicsTable
; LZSS-compressed: 534 bytes that expand to 704 (E-0016, E-0017)
BattleEffectGfx03::
    INCBIN "gfx/battle_effects/03.lz"

; compressed battle effect graphics, entry 4 of BattleEffectGraphicsTable
; LZSS-compressed: 654 bytes that expand to 752 (E-0016, E-0017)
BattleEffectGfx04::
    INCBIN "gfx/battle_effects/04.lz"

; compressed battle effect graphics, entry 5 of BattleEffectGraphicsTable
; LZSS-compressed: 683 bytes that expand to 736 (E-0016, E-0017)
BattleEffectGfx05::
    INCBIN "gfx/battle_effects/05.lz"

; compressed battle effect graphics, entry 6 of BattleEffectGraphicsTable
; LZSS-compressed: 230 bytes that expand to 272 (E-0016, E-0017)
BattleEffectGfx06::
    INCBIN "gfx/battle_effects/06.lz"

; compressed battle effect graphics, entry 7 of BattleEffectGraphicsTable
; LZSS-compressed: 426 bytes that expand to 496 (E-0016, E-0017)
BattleEffectGfx07::
    INCBIN "gfx/battle_effects/07.lz"

; compressed battle effect graphics, entry 8 of BattleEffectGraphicsTable
; LZSS-compressed: 654 bytes that expand to 768 (E-0016, E-0017)
BattleEffectGfx08::
    INCBIN "gfx/battle_effects/08.lz"

; compressed battle effect graphics, entry 9 of BattleEffectGraphicsTable
; LZSS-compressed: 166 bytes that expand to 240 (E-0016, E-0017)
BattleEffectGfx09::
    INCBIN "gfx/battle_effects/09.lz"

; compressed battle effect graphics, entry 10 of BattleEffectGraphicsTable
; LZSS-compressed: 452 bytes that expand to 512 (E-0016, E-0017)
BattleEffectGfx0A::
    INCBIN "gfx/battle_effects/0_a.lz"

; compressed battle effect graphics, entry 11 of BattleEffectGraphicsTable
; LZSS-compressed: 462 bytes that expand to 544 (E-0016, E-0017)
BattleEffectGfx0B::
    INCBIN "gfx/battle_effects/0_b.lz"

; compressed battle effect graphics, entry 12 of BattleEffectGraphicsTable
; LZSS-compressed: 529 bytes that expand to 608 (E-0016, E-0017)
BattleEffectGfx0C::
    INCBIN "gfx/battle_effects/0_c.lz"

; compressed battle effect graphics, entry 13 of BattleEffectGraphicsTable
; LZSS-compressed: 519 bytes that expand to 576 (E-0016, E-0017)
BattleEffectGfx0D::
    INCBIN "gfx/battle_effects/0_d.lz"

; compressed battle effect graphics, entry 14 of BattleEffectGraphicsTable
; LZSS-compressed: 300 bytes that expand to 320 (E-0016, E-0017)
BattleEffectGfx0E::
    INCBIN "gfx/battle_effects/0_e.lz"

; compressed battle effect graphics, entry 15 of BattleEffectGraphicsTable
; LZSS-compressed: 447 bytes that expand to 496 (E-0016, E-0017)
BattleEffectGfx0F::
    INCBIN "gfx/battle_effects/0_f.lz"

; compressed battle effect graphics, entry 16 of BattleEffectGraphicsTable
; LZSS-compressed: 510 bytes that expand to 560 (E-0016, E-0017)
BattleEffectGfx10::
    INCBIN "gfx/battle_effects/10.lz"

; compressed battle effect graphics, entry 17 of BattleEffectGraphicsTable
; LZSS-compressed: 683 bytes that expand to 768 (E-0016, E-0017)
BattleEffectGfx11::
    INCBIN "gfx/battle_effects/11.lz"

; compressed battle effect graphics, entry 18 of BattleEffectGraphicsTable
; LZSS-compressed: 252 bytes that expand to 288 (E-0016, E-0017)
BattleEffectGfx12::
    INCBIN "gfx/battle_effects/12.lz"

; compressed battle effect graphics, entry 19 of BattleEffectGraphicsTable
; LZSS-compressed: 161 bytes that expand to 224 (E-0016, E-0017)
BattleEffectGfx13::
    INCBIN "gfx/battle_effects/13.lz"

; compressed battle effect graphics, entry 20 of BattleEffectGraphicsTable
; LZSS-compressed: 61 bytes that expand to 96 (E-0016, E-0017)
BattleEffectGfx14::
    db $60, $00, $05, $00, $20, $20, $50, $70, $88, $20, $50, $00, $20, $05, $fc, $f1
    db $01, $05, $f8, $f5, $10, $10, $28, $00, $10, $00, $00, $01, $02, $03, $04, $01
    db $02, $00, $01, $05, $18, $04, $00, $80, $80, $40, $00, $80, $05, $18, $00, $38
    db $44, $05, $1a, $01, $05, $01, $09, $05, $0f, $06, $05, $28, $04

; compressed battle effect graphics, entry 21 of BattleEffectGraphicsTable
; LZSS-compressed: 62 bytes that expand to 80 (E-0016, E-0017)
BattleEffectGfx15::
    db $50, $00, $01, $01, $ff, $f5, $0e, $04, $0e, $00, $0e, $01, $ff, $f2, $20, $70
    db $70, $50, $20, $70, $01, $ff, $f6, $18, $18, $34, $2c, $24, $3c, $18, $18, $01
    db $ff, $f2, $38, $38, $74, $4c, $74, $4c, $44, $7c, $38, $38, $01, $ff, $f0, $3c
    db $3c, $42, $7e, $b9, $c7, $01, $44, $00, $81, $ff, $42, $7e, $3c, $3c

; compressed battle effect graphics, entry 22 of BattleEffectGraphicsTable
; LZSS-compressed: 115 bytes that expand to 144 (E-0016, E-0017)
BattleEffectGfx16::
    INCBIN "gfx/battle_effects/16.lz"

; compressed battle effect graphics, entry 23 of BattleEffectGraphicsTable
; LZSS-compressed: 187 bytes that expand to 416 (E-0016, E-0017)
BattleEffectGfx17::
    INCBIN "gfx/battle_effects/17.lz"

; compressed battle effect graphics, entry 24 of BattleEffectGraphicsTable
; LZSS-compressed: 446 bytes that expand to 576 (E-0016, E-0017)
BattleEffectGfx18::
    INCBIN "gfx/battle_effects/18.lz"

; compressed battle effect graphics, entry 25 of BattleEffectGraphicsTable
; LZSS-compressed: 218 bytes that expand to 288 (E-0016, E-0017)
BattleEffectGfx19::
    INCBIN "gfx/battle_effects/19.lz"

; compressed battle effect graphics, entry 26 of BattleEffectGraphicsTable
; LZSS-compressed: 670 bytes that expand to 768 (E-0016, E-0017)
BattleEffectGfx1A::
    INCBIN "gfx/battle_effects/1_a.lz"

; compressed battle effect graphics, entry 27 of BattleEffectGraphicsTable
; LZSS-compressed: 378 bytes that expand to 432 (E-0016, E-0017)
BattleEffectGfx1B::
    INCBIN "gfx/battle_effects/1_b.lz"

; compressed battle effect graphics, entry 28 of BattleEffectGraphicsTable
; LZSS-compressed: 651 bytes that expand to 768 (E-0016, E-0017)
BattleEffectGfx1C::
    INCBIN "gfx/battle_effects/1_c.lz"

; compressed battle effect graphics, entry 29 of BattleEffectGraphicsTable
; LZSS-compressed: 247 bytes that expand to 304 (E-0016, E-0017)
BattleEffectGfx1D::
    INCBIN "gfx/battle_effects/1_d.lz"

; compressed battle effect graphics, entry 30 of BattleEffectGraphicsTable
; LZSS-compressed: 691 bytes that expand to 736 (E-0016, E-0017)
BattleEffectGfx1E::
    INCBIN "gfx/battle_effects/1_e.lz"

; compressed battle effect graphics, entry 31 of BattleEffectGraphicsTable
; LZSS-compressed: 686 bytes that expand to 768 (E-0016, E-0017)
BattleEffectGfx1F::
    INCBIN "gfx/battle_effects/1_f.lz"

; compressed battle effect graphics, entry 32 of BattleEffectGraphicsTable
; LZSS-compressed: 535 bytes that expand to 768 (E-0016, E-0017)
BattleEffectGfx20::
    INCBIN "gfx/battle_effects/20.lz"

; compressed battle effect graphics, entry 33 of BattleEffectGraphicsTable
; LZSS-compressed: 714 bytes that expand to 768 (E-0016, E-0017)
BattleEffectGfx21::
    INCBIN "gfx/battle_effects/21.lz"

; compressed battle effect graphics, entry 34 of BattleEffectGraphicsTable
; LZSS-compressed: 302 bytes that expand to 384 (E-0016, E-0017)
BattleEffectGfx22::
    INCBIN "gfx/battle_effects/22.lz"

; compressed battle effect graphics, entry 35 of BattleEffectGraphicsTable
; LZSS-compressed: 406 bytes that expand to 688 (E-0016, E-0017)
BattleEffectGfx23::
    INCBIN "gfx/battle_effects/23.lz"

; compressed battle effect graphics, entry 36 of BattleEffectGraphicsTable
; LZSS-compressed: 176 bytes that expand to 256 (E-0016, E-0017)
BattleEffectGfx24::
    INCBIN "gfx/battle_effects/24.lz"

; compressed battle effect graphics, entry 37 of BattleEffectGraphicsTable
; LZSS-compressed: 212 bytes that expand to 288 (E-0016, E-0017)
BattleEffectGfx25::
    INCBIN "gfx/battle_effects/25.lz"
    ds $122, $00
