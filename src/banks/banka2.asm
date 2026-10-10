SECTION "Bank A2", ROMX[$4000], BANK[$A2]
    db $A2

; HL = $4056 + 26 * (monster id - $250 + 1) + C; copies hFFC6 bytes from HL to DE (E-0121)
; 1 call site from 1 routine (e.g. Func_034_4008)
; reads: wMonsterId, wCFE7, hFFC6
CopyMonsterTableBytesFrom4056::
Func_0A2_4001:: ; address name
    push de
    push bc
    ld a, [wMonsterId]
    ld c, a
    ld a, [wCFE7]
    ld b, a
    ld a, c
    sub a, $50
    ld c, a
    ld a, b
    sbc a, $02
    ld b, a
    inc bc
    ld a, $1A
    call Multiply8By16
    ld a, l
    add a, $56
    ld l, a
    ld a, h
    adc a, $40
    ld h, a
    pop bc
    ld b, $00
    add hl, bc
    ldh a, [hFFC6]
    ld b, a
    pop de
    call CopyBytesDEFromHL_BankA2
    ret

; only called from LoadMonsterRecordTo (E-0047)
; 1 call site from 1 routine (e.g. LoadMonsterRecordTo)
; reads: wMonsterId, wCFE7
LoadMonsterRecordTo_Sub01::
Func_0A2_402D:: ; address name
    push de
    ld a, [wMonsterId]
    ld c, a
    ld a, [wCFE7]
    ld b, a
    ld a, c
    sub a, $50
    ld c, a
    ld a, b
    sbc a, $02
    ld b, a
    inc bc
    ld a, $1A
    call Multiply8By16
    ld a, l
    add a, $56
    ld l, a
    ld a, h
    adc a, $40
    ld h, a
    pop de
    ld b, $1A

; the same 7 bytes as CopyBytesDEFromHL (34:406E)
; 1 call site from 1 routine (e.g. CopyMonsterTableBytesFrom4056)
CopyBytesDEFromHL_BankA2::
Func_0A2_404F:: ; address name
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, CopyBytesDEFromHL_BankA2
    ret
    db $00, $00, $FF, $FF, $FF, $FF
    ds $14, $00
    db $18, $00, $3C, $7C, $83, $95, $EE, $D9, $06, $55, $E8, $01, $9D, $00, $11, $02

; LZSS-compressed asset: 988 bytes expand to 999 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0A2_4080:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $288080, $3DC

; LZSS-compressed asset: 478 bytes expand to 475 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0A2_445C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $28845C, $1DE

; LZSS-compressed asset: 32 bytes expand to 365 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0A2_463A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $6D, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00
    db $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8, $6E, $01, $FF, $FF, $FF, $FF

; LZSS-compressed asset: 72 bytes expand to 100 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0A2_465A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $28865A, $48

; LZSS-compressed asset: 32 bytes expand to 369 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0A2_46A2:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $71, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00
    db $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8, $72, $01, $FF, $FF, $FF, $FF

; LZSS-compressed asset: 72 bytes expand to 100 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0A2_46C2:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $2886C2, $1E8

; LZSS-compressed asset: 32 bytes expand to 239 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0A2_48AA:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $EF, $00, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00
    db $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8, $F0, $00, $FF, $FF, $FF, $FF

; LZSS-compressed asset: 72 bytes expand to 100 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0A2_48CA:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $2888CA, $48

; LZSS-compressed asset: 32 bytes expand to 268 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0A2_4912:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $0C, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00
    db $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8, $35, $01, $FF, $FF, $FF, $FF

; LZSS-compressed asset: 72 bytes expand to 100 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0A2_4932:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $288932, $48

; LZSS-compressed asset: 32 bytes expand to 343 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0A2_497A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $57, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00
    db $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8, $58, $01, $FF, $FF, $FF, $FF

; LZSS-compressed asset: 51 bytes expand to 100 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0A2_499A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $28899A, $48

; only called from BeginStringDisplay_BankE0 (E-0047)
; 1 call site from 1 routine (e.g. BeginStringDisplay_BankE0)
; reads: wStringCategory
; writes: wStringCategory
BeginStringDisplay_BankE0_Sub01::
Func_0A2_49E2:: ; address name
    ld de, Data_0A2_49F8
    ld a, [wStringCategory]
    sub a, $01
    ld [wStringCategory], a
    call BeginStringDisplay
    ret
    db $CD, $E2, $49, $CD, $11, $26, $C9

Data_0A2_49F8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_0A2_49FC
    dw Data_0A2_4A3E

Data_0A2_49FC:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0A2_4A40
    dw Data_0A2_4A4F
    dw Data_0A2_4A88
    dw Data_0A2_4A99
    dw Data_0A2_4AAB
    dw Data_0A2_4ADF
    dw Data_0A2_4AE0
    dw Data_0A2_4AF2
    dw Data_0A2_4B03
    dw Data_0A2_4B14
    dw Data_0A2_4B4A
    dw Data_0A2_4BAB
    dw Data_0A2_4BBB
    dw Data_0A2_4BCD
    dw Data_0A2_4BDC
    dw Data_0A2_4BED
    dw Data_0A2_4BEE
    dw Data_0A2_4C10
    dw Data_0A2_4C55
    dw Data_0A2_4C77
    dw Data_0A2_4CCF
    dw Data_0A2_4D23
    dw Data_0A2_4D71
    dw Data_0A2_4DC7
    dw Data_0A2_4E1F
    dw Data_0A2_4E74
    dw Data_0A2_4ECA
    dw Data_0A2_4F1F
    dw Data_0A2_4F42
    dw Data_0A2_4F53
    dw Data_0A2_4F75
    dw Data_0A2_4F85
    dw Data_0A2_4FCA

Data_0A2_4A3E:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0A2_4FCB

Data_0A2_4A40:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "    YUJI HORII", $F0

Data_0A2_4A4F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "    YUJI HORII", $F1
    db "       ENIX", $F1
    db "       TOSE", $F1
    db "FUMINORI ISHIKAWA", $F0

Data_0A2_4A88:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  AKIRA TORIYAMA", $F0

Data_0A2_4A99:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  KOICHI SUGIYAMA", $F0

Data_0A2_4AAB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "   NOB OGASAWARA", $F1
    db "   LYNN OGASAWARA", $F1
    db "   KAI OGASAWARA", $F0

Data_0A2_4ADF:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_0A2_4AE0:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  MITSURU G TORII", $F0

Data_0A2_4AF2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "   JOHN LAURENCE", $F0

Data_0A2_4B03:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  JON WEISNEWSKI", $F0

Data_0A2_4B14:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  MASAKO KOMIYAMA", $F1
    db "   YURIKO MIZUTA", $F1
    db "  MASANOBU YOSHIDA", $F0

Data_0A2_4B4A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "   CHRIS CHYMIY", $F1
    db "   SHAWN CONARD", $F1
    db "    TJ COWGILL", $F1
    db "    JOHN HOLES", $F1
    db "  JERRY PRITCHARD", $F1
    db "   AARON SCHMITT", $F0

Data_0A2_4BAB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "   ANDREW STEIN", $F0

Data_0A2_4BBB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  MISUZU MCMILLAN", $F0

Data_0A2_4BCD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "     YURI KATO", $F0

Data_0A2_4BDC:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  PAUL HANDELMAN", $F0

Data_0A2_4BED:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_0A2_4BEE:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "    NAOKI OISHI", $F1
    db " TAKASHI KAMIMURA", $F0

Data_0A2_4C10:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "   KENJIRO KANO", $F1
    db "   TOMOYUKI IWAI", $F1
    db "  NORIKO NAKANONE", $F1
    db "  KAZUNORI OHWADA", $F0

Data_0A2_4C55:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "   HIROSHI SATO", $F1
    db "  HIDEKI YONEYAMA", $F0

Data_0A2_4C77:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " TAKATOSHI AKIYAMA", $F1
    db " SEIICHI MORIUCHI", $F1
    db "  SHINOBU NONAKA", $F1
    db " SATOSHI FUKUSHIMA", $F1
    db "     YUMI TOGO", $F0

Data_0A2_4CCF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  HIDEYUKI NUKUI", $F1
    db "  HIROSHI KONDOU", $F1
    db "   BIN KANAZAWA", $F1
    db "  KAZUHIRO NOMURA", $F1
    db "   TOMOE SUZUKI", $F0

Data_0A2_4D23:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "     KAN IKEDA", $F1
    db "   YOUKO KAGAYA", $F1
    db "   EMI NARIKIYO", $F1
    db "     MIKA ENDO", $F1
    db "   SAKIKO IKEDA", $F0

Data_0A2_4D71:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  TETUYA FUJIMOTO", $F1
    db "  MINORU KAKIZAWA", $F1
    db "  YASUHITO SUZUKI", $F1
    db "    NAOMI OZAWA", $F1
    db "    KOJI NUMATA", $F0

Data_0A2_4DC7:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  ATUSHI TAKEUCHI", $F1
    db "   TOMOHIRO ASO", $F1
    db " KENSUKE YOKOYAMA", $F1
    db " KENICHI YAMAMOTO", $F1
    db " TEPPEI KOBAYASHI", $F0

Data_0A2_4E1F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "    JIRO KIMURA", $F1
    db "  YASUNORI HOSONO", $F1
    db " KENTAKA NAKASHIMA", $F1
    db "    RYO YONAGA", $F1
    db "   SHINGO NOGUKI", $F0

Data_0A2_4E74:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  YUJIRO KUMAKURA", $F1
    db "    NAOKI SIRAI", $F1
    db "     RIE IWAO", $F1
    db " KATUHIKO YOKOYAMA", $F1
    db " RYUICHI NAKASHIMA", $F0

Data_0A2_4ECA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "   MASASHI KONNO", $F1
    db " MIKIHIRO HAYASHI", $F1
    db "  MIHO SHIBASAKI", $F1
    db "   MASAYUKI TADA", $F1
    db "    KAYO NAKATA", $F0

Data_0A2_4F1F:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "   NAOYA MATSUDA", $F1
    db " YOSHITO TANIUCHI", $F0

Data_0A2_4F42:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  TAICHI INUZUKA", $F0

Data_0A2_4F53:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  YUKINOBU CHIDA", $F1
    db "   KOUJI TAGUCHI", $F0

Data_0A2_4F75:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "    KEIJI HONDA", $F0

Data_0A2_4F85:: ; heuristic: target of a monotone pointer table; C0
    db $90, $B8, $02, $00, $00, $01, $F1, $90, $90, $0A, $1B, $16, $18, $1B, $90, $19
    db $1B, $18, $13, $0E, $0C, $1D, $F1, $90, $B8, $02, $00, $00, $01, $F1, $90, $90
    db $0B, $12, $1B, $0D, $90, $1C, $1D, $1E, $0D, $12, $18, $F1, $90, $B8, $02, $00
    db $00, $01
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F1
    db "  KOICHI SUGIYAMA", $F1

Data_0A2_4FCA:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_0A2_4FCB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DRAGON WARRIOR", $F1
    db "  MONSTERS 2", $F0
    ds $3019, $00
