SECTION "Bank A2", ROMX[$4000], BANK[$A2]
    db $A2

; 1 call site from 1 routine (e.g. Func_034_4008)
; reads: wMonsterId, wCFE7, hFFC6
Func_0A2_4001::
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
; 1 call site from 1 routine (e.g. Func_0A2_4001)
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
    db $FC, $49
    dw Func_0A2_4A3E
    dw Func_0A2_4A40
    dw Func_0A2_4A4F
    dw Func_0A2_4A88
    db $99, $4A, $AB, $4A, $DF, $4A, $E0, $4A, $F2, $4A, $03, $4B, $14, $4B, $4A, $4B
    db $AB, $4B, $BB, $4B, $CD, $4B
    dw Func_0A2_4BDC
    dw $4BED
    dw Func_0A2_4BEE
    dw Func_0A2_4C10
    dw Func_0A2_4C55
    dw Func_0A2_4C77
    dw Func_0A2_4CCF
    dw Func_0A2_4D23
    dw Func_0A2_4D71
    dw Func_0A2_4DC7
    dw Func_0A2_4E1F
    dw Func_0A2_4E74
    dw Func_0A2_4ECA
    dw Func_0A2_4F1F
    dw Func_0A2_4F42
    dw Func_0A2_4F53
    dw Func_0A2_4F75
    dw Func_0A2_4F85
    db $CA, $4F

; no direct call (reached through a table, a jump or a vector)
Func_0A2_4A3E:: ; heuristic: target of a pointer table; C0
    bit 1, a

; no direct call (reached through a table, a jump or a vector)
Func_0A2_4A40:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    ld [hl+], a
    ld e, $13
    ld [de], a
    sub a, b
    ld de, $1B18
    ld [de], a
    ld [de], a
    db $F0

; no direct call (reached through a table, a jump or a vector)
; reads: hFFF0, hMapId
Func_0A2_4A4F:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    ld [hl+], a
    ld e, $13
    ld [de], a
    sub a, b
    ld de, $1B18
    ld [de], a
    ld [de], a
    pop af
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    ld c, $17
    ld [de], a
    ld hl, vTiles2 + $F1
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    dec e
    jr Jump_0A2_4A90
    db $0E, $F1, $0F, $1E, $16, $12, $17, $18, $1B, $12, $90, $12, $1C, $11, $12, $14
    db $0A, $20, $0A, $F0

; no direct call (reached through a table, a jump or a vector)
; reads: hFFF0, hMapId
Func_0A2_4A88:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    ld a, [bc]
    inc d
    ld [de], a
    dec de
    ld a, [bc]
    sub a, b

Jump_0A2_4A90::
    dec e
    jr Jump_0A2_4AAE
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "IYAMA", $F0, "  KOICHI SUGIYAMA", $F0, "  "

Jump_0A2_4AAD::
    sub a, b

Jump_0A2_4AAE::
    rla
    jr Jump_0A2_4ABC
    db $90, $18, $10, $0A, $1C, $0A, $20, $0A, $1B, $0A, $F1

Jump_0A2_4ABC::
    sub a, b
    sub a, b
    sub a, b
    dec d

Jump_0A2_4AC0::
    ld [hl+], a
    rla
    rla
    sub a, b
    jr Jump_0A2_4AD6
    db $0A, $1C, $0A, $20, $0A, $1B, $0A, $F1, $90, $90, $90, $14, $0A, $12, $90, $18

Jump_0A2_4AD6::
    db $10, $0A ; stop
    inc e
    ld a, [bc]
    jr nz, Jump_0A2_4AE6
    dec de
    ld a, [bc]
    ldh a, [hFFF0]
    sub a, b
    sub a, b
    ld d, $12
    dec e
    inc e

Jump_0A2_4AE6::
    ld e, $1B
    ld e, $90
    db $10, $90 ; stop
    dec e
    jr Jump_0A2_4B0A
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "II", $F0, "   JOHN LAURENCE", $F0, "  JON W"

Jump_0A2_4B0A::
    ld c, $12
    inc e
    rla
    ld c, $20
    inc e
    inc d
    ld [de], a
    ldh a, [hMapId]
    sub a, b
    ld d, $0A
    inc e
    ld a, [bc]
    inc d
    jr Jump_0A2_4AAD

; no direct call (reached through a table, a jump or a vector)
; reads: hMapId
Func_0A2_4B1D:: ; heuristic: follows a terminator; C0
    inc d
    jr Jump_0A2_4B36

; no direct call (reached through a table, a jump or a vector)
; reads: hFFF0, hMapId
Func_0A2_4B20:: ; heuristic: follows a terminator; C0
    ld [de], a
    ld [hl+], a
    ld a, [bc]
    ld d, $0A
    pop af
    sub a, b
    sub a, b
    sub a, b
    ld [hl+], a
    ld e, $1B
    ld [de], a
    inc d
    jr Jump_0A2_4AC0
    db $16, $12, $23, $1E, $1D, $0A

Jump_0A2_4B36::
    pop af
    sub a, b
    sub a, b
    ld d, $0A
    inc e
    ld a, [bc]
    rla
    jr Jump_0A2_4B4B
    db $1E, $90, $22, $18, $1C, $11, $12, $0D, $0A, $F0, $90

Jump_0A2_4B4B::
    sub a, b
    sub a, b
    inc c
    ld de, $121B
    inc e
    sub a, b
    inc c
    ld de, $1622
    ld [de], a
    ld [hl+], a
    pop af
    sub a, b
    sub a, b
    sub a, b
    inc e
    ld de, $200A
    rla
    sub a, b
    inc c
    jr Jump_0A2_4B7D

; no direct call (reached through a table, a jump or a vector)
; reads: hMapId
Func_0A2_4B66:: ; heuristic: follows a terminator; C0
    ld a, [bc]
    dec de
    dec c
    pop af
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    dec e
    inc de
    sub a, b
    inc c
    jr Jump_0A2_4B94
    db $10, $12, $15, $15, $F1, $90, $90, $90, $90

Jump_0A2_4B7D::
    inc de
    jr Jump_0A2_4B91
    db $17, $90, $11, $18, $15, $0E, $1C, $F1, $90, $90, $13, $0E, $1B, $1B, $22, $90
    db $19

Jump_0A2_4B91::
    dec de
    ld [de], a
    dec e

Jump_0A2_4B94::
    inc c
    ld de, $1B0A
    dec c
    pop af
    sub a, b
    sub a, b
    sub a, b
    ld a, [bc]
    ld a, [bc]
    dec de
    jr Jump_0A2_4BB9
    db $90, $1C, $0C, $11, $16, $12, $1D, $1D, $F0

Jump_0A2_4BAB::
    sub a, b
    sub a, b
    sub a, b
    ld a, [bc]
    rla
    dec c
    dec de
    ld c, $20
    sub a, b
    inc e
    dec e
    ld c, $12

Jump_0A2_4BB9::
    rla
    ldh a, [hMapId]
    sub a, b
    ld d, $12
    inc e
    ld e, $23
    ld e, $90
    ld d, $0C
    ld d, $12
    dec d
    dec d
    ld a, [bc]
    rla

Jump_0A2_4BCC::
    ldh a, [hMapId]
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    ld [hl+], a
    ld e, $1B
    ld [de], a
    sub a, b
    inc d
    ld a, [bc]
    dec e
    jr Jump_0A2_4BCC

; no direct call (reached through a table, a jump or a vector)
; reads: hFFF0
Func_0A2_4BDC:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    add hl, de
    ld a, [bc]
    ld e, $15
    sub a, b
    ld de, $170A
    dec c
    ld c, $15
    ld d, $0A
    rla
    ldh a, [hFFF0]

; no direct call (reached through a table, a jump or a vector)
Func_0A2_4BEE:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    rla
    ld a, [bc]
    jr Jump_0A2_4C0A
    db $12, $90, $18, $12, $1C, $11, $12, $F1, $90, $1D, $0A, $14, $0A, $1C, $11, $12
    db $90, $14, $0A, $16

Jump_0A2_4C0A::
    ld [de], a
    ld d, $1E
    dec de
    ld a, [bc]
    db $F0

; no direct call (reached through a table, a jump or a vector)
; reads: hMapId
Func_0A2_4C10:: ; heuristic: target of a pointer table; C0
    sub a, b

Jump_0A2_4C11::
    sub a, b
    sub a, b
    inc d
    ld c, $17
    inc de
    ld [de], a
    dec de
    jr Jump_0A2_4BAB

; no direct call (reached through a table, a jump or a vector)
; reads: hMapId
Func_0A2_4C1B:: ; heuristic: follows a terminator; C0
    inc d
    ld a, [bc]
    rla
    jr Jump_0A2_4C11

; no direct call (reached through a table, a jump or a vector)
Func_0A2_4C20:: ; heuristic: follows a terminator; C0
    sub a, b
    sub a, b
    sub a, b
    dec e
    jr Jump_0A2_4C3C
    db $18, $22, $1E, $14, $12, $90, $12, $20, $0A, $12, $F1, $90, $90, $17, $18, $1B
    db $12, $14, $18, $90, $17, $0A

Jump_0A2_4C3C::
    inc d
    ld a, [bc]
    rla
    jr Jump_0A2_4C58
    db $0E, $F1, $90, $90, $14, $0A, $23, $1E, $17, $18, $1B, $12, $90, $18, $11, $20
    db $0A, $0D, $0A, $F0

; no direct call (reached through a table, a jump or a vector)
Func_0A2_4C55:: ; heuristic: target of a pointer table; C0
    sub a, b

Jump_0A2_4C56::
    sub a, b
    sub a, b

Jump_0A2_4C58::
    ld de, $1B12
    jr Jump_0A2_4C79

; no direct call (reached through a table, a jump or a vector)
Func_0A2_4C5D:: ; heuristic: follows a terminator; C0
    ld de, vTiles2 + $12
    inc e
    ld a, [bc]
    dec e
    jr Jump_0A2_4C56
    db $90, $90, $11, $12, $0D, $0E, $14, $12, $90, $22, $18, $17, $0E, $22, $0A, $16
    db $0A, $F0

; no direct call (reached through a table, a jump or a vector)
Func_0A2_4C77:: ; heuristic: target of a pointer table; C0
    sub a, b
    dec e

Jump_0A2_4C79::
    ld a, [bc]
    inc d
    ld a, [bc]
    dec e
    jr Jump_0A2_4C9B
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "HI AKIYAMA", $F1
    db " SEIICHI MORIUCHI"

Jump_0A2_4C9B::
    pop af

Jump_0A2_4C9C::
    sub a, b
    sub a, b
    inc e
    ld de, $1712
    jr Jump_0A2_4CAF

; no direct call (reached through a table, a jump or a vector)
Func_0A2_4CA4:: ; heuristic: follows a terminator; C0
    ld e, $90
    rla
    jr Jump_0A2_4CC0
    db $0A, $14, $0A, $F1, $90, $1C

Jump_0A2_4CAF::
    ld a, [bc]
    dec e
    jr Func_0A2_4CCF

; no direct call (reached through a table, a jump or a vector)
Func_0A2_4CB3:: ; heuristic: follows a terminator; C0
    ld de, vTiles2 + $12
    rrca
    ld e, $14
    ld e, $1C
    ld de, $1612
    ld a, [bc]
    pop af

Jump_0A2_4CC0::
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    ld [hl+], a
    ld e, $16
    ld [de], a
    sub a, b
    dec e
    jr Jump_0A2_4CDD
    db $18, $F0

; no direct call (reached through a table, a jump or a vector)
Func_0A2_4CCF:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    ld de, $0D12
    ld c, $22
    ld e, $14
    ld [de], a
    sub a, b
    rla
    ld e, $14

Jump_0A2_4CDD::
    ld e, $12
    pop af
    sub a, b
    sub a, b
    ld de, $1B12
    jr Jump_0A2_4D03
    db $11, $12, $90, $14, $18, $17, $0D, $18, $1E, $F1, $90, $90, $90, $0B, $12, $17
    db $90, $14, $0A, $17

Jump_0A2_4CFB::
    ld a, [bc]
    inc hl
    ld a, [bc]
    jr nz, Jump_0A2_4D0A
    pop af
    sub a, b
    sub a, b

Jump_0A2_4D03::
    inc d
    ld a, [bc]
    inc hl
    ld e, $11
    ld [de], a
    dec de

Jump_0A2_4D0A::
    jr Jump_0A2_4C9C
    db $17, $18, $16, $1E, $1B, $0A, $F1, $90, $90, $90, $1D, $18, $16, $18, $0E, $90
    db $1C, $1E, $23, $1E, $14, $12, $F0

; no direct call (reached through a table, a jump or a vector)
Func_0A2_4D23:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    inc d
    ld a, [bc]
    rla
    sub a, b
    ld [de], a
    inc d
    ld c, $0D
    ld a, [bc]
    pop af
    sub a, b
    sub a, b
    sub a, b
    ld [hl+], a
    jr Jump_0A2_4D56
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "KO KAGAYA", $F1
    db "   EMI NARIKIYO", $F1

Jump_0A2_4D52::
    sub a, b
    sub a, b
    sub a, b
    sub a, b

Jump_0A2_4D56::
    sub a, b
    ld d, $12
    inc d
    ld a, [bc]
    sub a, b
    ld c, $17
    dec c
    jr Jump_0A2_4D52

; no direct call (reached through a table, a jump or a vector)
Func_0A2_4D61:: ; heuristic: follows a terminator; C0
    sub a, b
    sub a, b
    sub a, b
    inc e
    ld a, [bc]
    inc d
    ld [de], a
    inc d
    jr Jump_0A2_4CFB
    db $12, $14, $0E, $0D, $0A, $F0

; no direct call (reached through a table, a jump or a vector)
Func_0A2_4D71:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    dec e

Jump_0A2_4D74::
    ld c, $1D
    ld e, $22
    ld a, [bc]
    sub a, b
    rrca
    ld e, $13
    ld [de], a
    ld d, $18
    dec e
    jr Jump_0A2_4D74
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  MINORU KAKIZAWA", $F1
    db "  YASUHITO SUZUKI", $F1
    db "    NAOMI OZAWA", $F1
    db " "

Jump_0A2_4DB8::
    sub a, b
    sub a, b
    sub a, b
    inc d
    jr Jump_0A2_4DD1
    db $12, $90, $17, $1E, $16, $0A, $1D, $0A, $F0

; no direct call (reached through a table, a jump or a vector)
Func_0A2_4DC7:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    ld a, [bc]
    dec e
    ld e, $1C
    ld de, vTiles2 + $12
    dec e

Jump_0A2_4DD1::
    ld a, [bc]
    inc d
    ld c, $1E
    inc c
    ld de, $F112
    sub a, b
    sub a, b
    sub a, b
    dec e
    jr Jump_0A2_4DF5
    db $18, $11, $12, $1B, $18, $90, $0A, $1C, $18, $F1, $90, $14, $0E

Jump_0A2_4DEC::
    rla
    inc e
    ld e, $14
    ld c, $90
    ld [hl+], a
    jr Jump_0A2_4E09

Jump_0A2_4DF5::
    jr Jump_0A2_4E19
    db $0A, $16, $0A, $F1, $90, $14, $0E, $17, $12, $0C, $11, $12, $90, $22, $0A, $16
    db $0A, $16

Jump_0A2_4E09::
    jr Jump_0A2_4E28
    db $18, $F1

Jump_0A2_4E0D::
    sub a, b
    dec e
    ld c, $19
    add hl, de
    ld c, $12
    sub a, b
    inc d
    jr Jump_0A2_4E23
    db $0A

Jump_0A2_4E19::
    ld [hl+], a
    ld a, [bc]
    inc e
    ld de, $F012

; no direct call (reached through a table, a jump or a vector)
Func_0A2_4E1F:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    sub a, b

Jump_0A2_4E23::
    inc de
    ld [de], a
    dec de
    jr Jump_0A2_4DB8

Jump_0A2_4E28::
    inc d
    ld [de], a
    ld d, $1E
    dec de
    ld a, [bc]
    pop af
    sub a, b
    sub a, b
    ld [hl+], a

Jump_0A2_4E32::
    ld a, [bc]
    inc e
    ld e, $17
    jr Jump_0A2_4E53
    db $12, $90, $11, $18, $1C, $18

Jump_0A2_4E3E::
    rla
    jr Jump_0A2_4E32
    db $90, $14, $0E, $17, $1D, $0A, $14, $0A, $90, $17, $0A, $14, $0A, $1C, $11, $12
    db $16, $0A

Jump_0A2_4E53::
    pop af
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    dec de
    ld [hl+], a
    jr Jump_0A2_4DEC
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "YONAGA", $F1
    db "   SHINGO NOGUKI", $F0

; no direct call (reached through a table, a jump or a vector)
Func_0A2_4E74:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    ld [hl+], a
    ld e, $13
    ld [de], a
    dec de
    jr Jump_0A2_4E0D

; no direct call (reached through a table, a jump or a vector)
Func_0A2_4E7D:: ; heuristic: follows a terminator; C0
    inc d
    ld e, $16
    ld a, [bc]
    inc d
    ld e, $1B
    ld a, [bc]
    pop af
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    rla
    ld a, [bc]
    jr Jump_0A2_4EA2
    db $12, $90, $1C, $12, $1B, $0A, $12

Jump_0A2_4E95::
    pop af
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    dec de
    ld [de], a
    ld c, $90
    ld [de], a
    jr nz, Jump_0A2_4EAC

Jump_0A2_4EA2::
    jr Jump_0A2_4E95
    db $90, $14, $0A, $1D

Jump_0A2_4EA8::
    ld e, $11
    ld [de], a
    inc d

Jump_0A2_4EAC::
    jr Jump_0A2_4E3E
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "YOKOYAMA", $F1
    db " RYUICHI NAKASHIMA", $F0

; no direct call (reached through a table, a jump or a vector)
Func_0A2_4ECA:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    ld d, $0A
    inc e
    ld a, [bc]
    inc e
    ld de, vTiles2 + $12
    inc d
    jr Jump_0A2_4EEF
    db $17, $18, $F1, $90, $16, $12, $14, $12, $11, $12, $1B, $18, $90, $11, $0A, $22
    db $0A, $1C, $11, $12, $F1, $90, $90

Jump_0A2_4EEF::
    ld d, $12
    ld de, vTiles2 + $18
    inc e
    ld de, $0B12
    ld a, [bc]
    inc e
    ld a, [bc]
    inc d
    ld [de], a
    pop af
    sub a, b
    sub a, b
    sub a, b
    ld d, $0A
    inc e
    ld a, [bc]
    ld [hl+], a
    ld e, $14
    ld [de], a
    sub a, b
    dec e
    ld a, [bc]
    dec c
    ld a, [bc]
    pop af
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    inc d
    ld a, [bc]
    ld [hl+], a
    jr Jump_0A2_4EA8
    db $17, $0A, $14, $0A, $1D, $0A, $F0

; no direct call (reached through a table, a jump or a vector)
Func_0A2_4F1F:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    rla
    ld a, [bc]
    jr Jump_0A2_4F48
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A MATSUDA", $F1
    db " YOSHITO TANIUCHI", $F0

; no direct call (reached through a table, a jump or a vector)
Func_0A2_4F42:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    dec e
    ld a, [bc]
    ld [de], a
    inc c

Jump_0A2_4F48::
    ld de, vTiles2 + $12
    ld [de], a
    rla
    ld e, $23
    ld e, $14
    ld a, [bc]
    db $F0

; no direct call (reached through a table, a jump or a vector)
Func_0A2_4F53:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    ld [hl+], a
    ld e, $14
    ld [de], a
    rla
    jr Jump_0A2_4F67
    db $1E, $90, $0C, $11, $12, $0D, $0A, $F1, $90, $90, $90

Jump_0A2_4F67::
    inc d
    jr Jump_0A2_4F88
    db $13, $12, $90, $1D, $0A, $10, $1E, $0C, $11, $12, $F0

; no direct call (reached through a table, a jump or a vector)
Func_0A2_4F75:: ; heuristic: target of a pointer table; C0
    sub a, b
    sub a, b
    sub a, b
    sub a, b
    inc d
    ld c, $12
    inc de
    ld [de], a
    sub a, b
    ld de, $1718
    dec c
    ld a, [bc]
    db $F0

; no direct call (reached through a table, a jump or a vector)
Func_0A2_4F85:: ; heuristic: target of a pointer table; C0
    sub a, b
    cp a, b
    ld [bc], a

Jump_0A2_4F88::
    nop
    nop
    ld bc, vTiles2 + $F1
    sub a, b
    ld a, [bc]
    dec de
    ld d, $18
    dec de
    sub a, b
    add hl, de
    dec de
    jr Jump_0A2_4FAB
    db $0E, $0C, $1D, $F1, $90, $B8, $02, $00, $00, $01

Jump_0A2_4FA2::
    pop af
    sub a, b
    sub a, b
    dec bc
    ld [de], a
    dec de
    dec c
    sub a, b
    inc e

Jump_0A2_4FAB::
    dec e
    ld e, $0D
    ld [de], a
    jr Jump_0A2_4FA2
    db $90, $B8, $02, $00, $00, $01
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F1
    db "  KOICHI SUGIYAMA", $F1
    db $F0, "DRAGON WARRIOR", $F1
    db "  MONSTERS 2", $F0
    ds $3019, $00
