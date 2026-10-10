SECTION "Bank E1", ROMX[$4000], BANK[$E1]
    db $E1

; LZSS-compressed asset: 213 bytes expand to 304 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0E1_4001:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $384001, $D5

; LZSS-compressed asset: 37 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0E1_40D6:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    db $68, $01, $13, $13, $A0, $FF, $4D, $13, $41, $0F, $2E, $01, $02, $03, $04, $05
    db $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F, $10, $11, $12, $13, $41, $0F
    db $4D, $13, $12, $1F, $42

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0E1_40FB:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

Data_0E1_410E:: ; heuristic: argument of a bank-switching copy helper; C0
    db $B5, $56, $FF, $7F, $D7, $56, $00, $00

; LZSS-compressed asset: 1169 bytes expand to 1600 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0E1_4116:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $384116, $491

; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0E1_45A7:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $3845A7, $55

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0E1_45FC:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

Data_0E1_460F:: ; heuristic: argument of a bank-switching copy helper; C0
    db $60, $31, $B5, $56, $E8, $62, $00, $00

; LZSS-compressed asset: 815 bytes expand to 1552 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0E1_4617:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $384617, $32F

; LZSS-compressed asset: 120 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0E1_4946:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $384946, $78

; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0E1_49BE:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    db $68, $01, $00, $08, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

Data_0E1_49D2:: ; heuristic: argument of a bank-switching copy helper; C0
    db $0F, $3E, $BF, $73, $D7, $56, $00, $00

; LZSS-compressed asset: 1165 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0E1_49DA:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $3849DA, $48D

; LZSS-compressed asset: 1438 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0E1_4E67:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $384E67, $59E

; LZSS-compressed asset: 887 bytes expand to 1152 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0E1_5405:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $385405, $377

; LZSS-compressed asset: 175 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0E1_577C:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $38577C, $AF

; LZSS-compressed asset: 152 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0E1_582B:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $38582B, $98

; LZSS-compressed asset: 76 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0E1_58C3:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $3858C3, $4C

; LZSS-compressed asset: 101 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0E1_590F:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $38590F, $65

; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0E1_5974:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; LZSS-compressed asset: 112 bytes expand to 1024 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0E1_5987:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $385987, $70

; LZSS-compressed asset: 48 bytes expand to 1024 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_0E1_59F7:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    db $00, $04, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $20, $1F, $4D, $00, $80, $1F, $4D, $00, $E0, $1F, $4D, $00, $40, $2F, $4D
    db $00, $A0, $2F, $4D, $00, $00, $3F, $4D, $00, $60, $3F, $4D, $00, $A0, $3F, $2C

Data_0E1_5A27:: ; heuristic: argument of a bank-switching copy helper; C0
    db $0F, $54, $FF, $7F, $1F, $13, $AA, $04, $0F, $54, $FF, $7F, $1F, $13, $D5, $09
    db $33, $05, $FF, $03, $BD, $21, $AA, $04, $33, $05, $FF, $7F, $1F, $13, $AA, $04
    db $33, $05, $FF, $7F, $BD, $21, $AA, $04, $36, $04, $FF, $7F, $1F, $13, $AA, $04
    db $36, $04, $FF, $7F, $1F, $13, $D5, $09, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F

Data_0E1_5A67:: ; heuristic: argument of a bank-switching copy helper; C0
    db $0F, $54, $FF, $7F, $1F, $13, $AA, $04, $0F, $54, $FF, $7F, $1F, $13, $D5, $09
    db $33, $05, $FF, $03, $BD, $21, $AA, $04, $33, $05, $FF, $7F, $1F, $13, $AA, $04
    db $33, $05, $FF, $7F, $BD, $21, $AA, $04, $36, $04, $FF, $7F, $1F, $13, $AA, $04
    db $36, $04, $FF, $7F, $1F, $13, $D5, $09, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F

Data_0E1_5AA7:: ; heuristic: argument of a bank-switching copy helper; C0
    db $20, $7C, $FF, $7F, $A8, $14, $00, $00, $20, $7C, $FF, $7F, $35, $04, $00, $00

; 1 call site from 1 routine (e.g. Func_007_5FE8)
Func_0E1_5AB7::
    ld de, Data_0E1_5ABE
    call Func_0E1_5AC0
    ret

Data_0E1_5ABE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $3C, $5D

; 1 call site from 1 routine (e.g. Func_0E1_5AB7)
; reads: hOamNextEntry, hSpriteScrollYLo, hSpriteScrollYHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteScrollXLo, hSpriteScrollXHi, hSpriteOriginX, ...
; writes: hFFB3, hFFB4, hOamNextEntry
; points at: hFFB5
Func_0E1_5AC0::
    ldh a, [hOamNextEntry]
    cp a, $27
    ret nc
    ldh a, [hSpriteScrollYLo]
    ld c, a
    ldh a, [hSpriteScrollYHi]
    ld b, a
    ldh a, [hSpriteOriginY]
    add a, c
    ldh [hFFB3], a
    ldh a, [hSpriteOriginYHi]
    adc a, b
    ldh [hFFB4], a
    ldh a, [hSpriteScrollXLo]
    ld c, a
    ldh a, [hSpriteScrollXHi]
    ld b, a
    ld hl, hFFB5
    ldh a, [hSpriteOriginX]
    add a, c
    ld c, a
    ld [hl+], a
    ldh a, [hSpriteOriginXHi]
    adc a, b
    ld b, a
    ld [hl+], a
    ld a, c
    sub a, $08
    ld [hl+], a
    ld a, b
    sbc a, $00
    ld [hl], a
    ldh a, [hSpriteSetIndex]
    add a, a
    add a, e
    ld l, a
    ld a, $00
    adc a, d
    ld h, a
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ldh a, [hSpriteSubIndex]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, de
    deref_hl
    ldh a, [hOamNextEntry]
    add a, a
    add a, a
    ld e, a
    ld d, $C0
    ldh a, [hFFB9]
    or a, a
    jp nz, Jump_0E1_5C0A
    ldh a, [hSpriteTileOffset]
    ld c, a
    ldh a, [hSpriteAttrXor]
    and a, $20
    jr nz, Jump_0E1_5B92

Jump_0E1_5B1C::
    ld a, [hl+]
    cp a, $80
    ret z
    ld b, a
    jr nc, Jump_0E1_5B34
    ldh a, [hFFB3]
    add a, b
    ld b, a
    ldh a, [hFFB4]
    adc a, $00
    jr nz, Jump_0E1_5B43
    ld a, b
    cp a, $A8
    jr c, Jump_0E1_5B48
    jr Jump_0E1_5B43

Jump_0E1_5B34::
    ldh a, [hFFB3]
    add a, b
    ld b, a
    ldh a, [hFFB4]
    adc a, $FF
    jr nz, Jump_0E1_5B43
    ld a, b
    cp a, $A8
    jr c, Jump_0E1_5B48

Jump_0E1_5B43::
    inc hl
    inc hl
    inc hl
    jr Jump_0E1_5B1C

Jump_0E1_5B48::
    ld a, b
    ld [de], a
    inc e
    ld a, [hl+]
    ld b, a
    rlca
    jr c, Jump_0E1_5B61
    ldh a, [hFFB5]
    add a, b
    ld b, a
    ldh a, [hFFB6]
    adc a, $00
    jr nz, Jump_0E1_5B70
    ld a, b
    cp a, $B8
    jr c, Jump_0E1_5B77
    jr Jump_0E1_5B70

Jump_0E1_5B61::
    ldh a, [hFFB5]
    add a, b
    ld b, a
    ldh a, [hFFB6]
    adc a, $FF
    jr nz, Jump_0E1_5B70
    ld a, b
    cp a, $B8
    jr c, Jump_0E1_5B77

Jump_0E1_5B70::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_0E1_5B1C

Jump_0E1_5B77::
    ld a, b
    ld [de], a
    inc e
    ldh a, [hSpriteTileOffset]
    ld c, a
    ld a, [hl+]
    add a, c
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp a, $28
    jr nz, Jump_0E1_5B1C
    ret

Jump_0E1_5B92::
    ld a, [hl+]
    cp a, $80
    ret z
    ld b, a
    jr nc, Jump_0E1_5BAA
    ldh a, [hFFB3]
    add a, b
    ld b, a
    ldh a, [hFFB4]
    adc a, $00
    jr nz, Jump_0E1_5BB9
    ld a, b
    cp a, $A8
    jr c, Jump_0E1_5BBE
    jr Jump_0E1_5BB9

Jump_0E1_5BAA::
    ldh a, [hFFB3]
    add a, b
    ld b, a
    ldh a, [hFFB4]
    adc a, $FF
    jr nz, Jump_0E1_5BB9
    ld a, b
    cp a, $A8
    jr c, Jump_0E1_5BBE

Jump_0E1_5BB9::
    inc hl
    inc hl
    inc hl
    jr Jump_0E1_5B92

Jump_0E1_5BBE::
    ld a, b
    ld [de], a
    inc e
    ld a, [hl+]
    ld b, a
    rlca
    jr c, Jump_0E1_5BD9
    ldh a, [hFFB7]
    sub a, b
    ld b, a
    ldh a, [hFFB8]
    sbc a, $00
    jr z, Jump_0E1_5BEF
    jr nz, Jump_0E1_5BE8
    ld a, b
    cp a, $B8
    jr c, Jump_0E1_5BEF
    jr Jump_0E1_5BE8

Jump_0E1_5BD9::
    ldh a, [hFFB7]
    sub a, b
    ld b, a
    ldh a, [hFFB8]
    sbc a, $FF
    jr nz, Jump_0E1_5BE8
    ld a, b
    cp a, $B8
    jr c, Jump_0E1_5BEF

Jump_0E1_5BE8::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_0E1_5B92

Jump_0E1_5BEF::
    ld a, b
    ld [de], a
    inc e
    ldh a, [hSpriteTileOffset]
    ld c, a
    ld a, [hl+]
    add a, c
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp a, $28
    jr nz, Jump_0E1_5B92
    ret

Jump_0E1_5C0A::
    ldh a, [hSpriteAttrXor]
    and a, $20
    jr nz, Jump_0E1_5C8B

Jump_0E1_5C10::
    ld a, [hl+]
    cp a, $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_0E1_5C1B
    dec b

Jump_0E1_5C1B::
    ldh a, [hFFB3]
    add a, c
    ld c, a
    ldh a, [hFFB4]
    adc a, b
    jr nz, Jump_0E1_5C46
    ld a, c
    cp a, $B8
    jr nc, Jump_0E1_5C46
    ldh a, [hFFB9]
    or a, a
    jr z, Jump_0E1_5C4B
    cp a, $01
    jr nz, Jump_0E1_5C39
    ld a, c
    cp a, $34
    jr c, Jump_0E1_5C46
    jr Jump_0E1_5C4B

Jump_0E1_5C39::
    cp a, $02
    jr nz, Jump_0E1_5C44
    ld a, c
    cp a, $71
    jr c, Jump_0E1_5C4B
    jr Jump_0E1_5C46

Jump_0E1_5C44::
    jr Jump_0E1_5C4B

Jump_0E1_5C46::
    inc hl
    inc hl
    inc hl
    jr Jump_0E1_5C10

Jump_0E1_5C4B::
    ld a, c
    ld [de], a
    inc e
    ld a, [hl+]
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_0E1_5C56
    dec b

Jump_0E1_5C56::
    ldh a, [hFFB5]
    add a, c
    ld c, a
    ldh a, [hFFB6]
    adc a, b
    jr nz, Jump_0E1_5C64
    ld a, c
    cp a, $B8
    jr c, Jump_0E1_5C6B

Jump_0E1_5C64::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_0E1_5C10

Jump_0E1_5C6B::
    ld a, c
    ld [de], a
    call BGTileUnderPointIsHFFBA_BankE1
    jr nc, Jump_0E1_5C64
    inc e
    ldh a, [hSpriteTileOffset]
    ld b, a
    ld a, [hl+]
    add a, b
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp a, $28
    jr nz, Jump_0E1_5C10
    ret

Jump_0E1_5C8B::
    ld a, [hl+]
    cp a, $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_0E1_5C96
    dec b

Jump_0E1_5C96::
    ldh a, [hFFB3]
    add a, c
    ld c, a
    ldh a, [hFFB4]
    adc a, b
    jr nz, Jump_0E1_5CC1
    ld a, c
    cp a, $B8
    jr nc, Jump_0E1_5CC1
    ldh a, [hFFB9]
    or a, a
    jr z, Jump_0E1_5CC6
    cp a, $01
    jr nz, Jump_0E1_5CB4
    ld a, c
    cp a, $34
    jr c, Jump_0E1_5CC1
    jr Jump_0E1_5CC6

Jump_0E1_5CB4::
    cp a, $02
    jr nz, Jump_0E1_5CBF
    ld a, c
    cp a, $71
    jr c, Jump_0E1_5CC6
    jr Jump_0E1_5CC1

Jump_0E1_5CBF::
    jr Jump_0E1_5CC6

Jump_0E1_5CC1::
    inc hl
    inc hl
    inc hl
    jr Jump_0E1_5C8B

Jump_0E1_5CC6::
    ld a, c
    ld [de], a
    inc e
    ld a, [hl+]
    ld c, a
    ld b, $00
    rlca
    jr nc, Jump_0E1_5CD1
    dec b

Jump_0E1_5CD1::
    ldh a, [hFFB7]
    sub a, c
    ld c, a
    ldh a, [hFFB8]
    sbc a, b
    jr nz, Jump_0E1_5CDF
    ld a, c
    cp a, $B8
    jr c, Jump_0E1_5CE6

Jump_0E1_5CDF::
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr Jump_0E1_5C8B

Jump_0E1_5CE6::
    ld a, c
    ld [de], a
    call BGTileUnderPointIsHFFBA_BankE1
    jr nc, Jump_0E1_5CDF
    inc e
    ldh a, [hSpriteTileOffset]
    ld b, a
    ld a, [hl+]
    add a, b
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp a, $28
    jr nz, Jump_0E1_5C8B
    ret

; DE = address of an X byte with its Y byte at DE - 1 (screen coordinates): HL = the $9800 BG map entry under (X + hScrollX - 4, Y + hScrollY - 12), rows wrapping inside the map; reads it after rSTAT bit 1 clears (interrupts off) and compares with hFFBA: Z set when equal, A = the tile; BC, HL kept (E-0065) (the same 54 bytes appear in 6 banks)
; 2 call sites from 1 routine (e.g. Func_0E1_5AC0)
; reads: hScrollY, hScrollX, hFFBA, rSTAT
BGTileUnderPointIsHFFBA_BankE1::
Func_0E1_5D06:: ; address name
    push hl
    push bc
    ldh a, [hScrollY]
    ld b, a
    dec e
    ld a, [de]
    inc e
    add a, b
    sub a, $0C
    and a, $F8
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ldh a, [hScrollX]
    ld b, a
    ld a, [de]
    add a, b
    sub a, $04
    and a, $F8
    rrca
    rrca
    rrca
    add a, l
    ld l, a
    ld a, h
    and a, $03
    adc a, $98
    ld h, a
    ldh a, [hFFBA]
    ld b, a
    di

Jump_0E1_5D30::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_0E1_5D30
    ld a, [hl]
    ei
    cp a, b
    pop bc
    pop hl
    ret
    INCBIN "dwm2-cobi-us.gbc", $385D3C, $1E1B
    ds $4A9, $00
