SECTION "Bank 61", ROMX[$4000], BANK[$61]
    db $61

; 2 call sites from 2 routines (e.g. Func_00A_465D_Case05, ScriptCommand84_Run_Case04_Sub01)
; reads: wC6FD, hFFC6, hFFC7, hFFCA, hFFCB
; writes: wCD05, hFFCA, hFFCB, rRAMG
; points at: wC6FE
Func_061_4001::
    ld a, [wC6FD]
    or a, a
    jr nz, Jump_061_400C
    xor a, a
    ld [wCD05], a
    ret

Jump_061_400C::
    ld b, a
    ld hl, $0000
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    ld hl, wC6FE
    ld a, $0A
    ld [rRAMG], a

Jump_061_401E::
    push bc
    push hl
    ld a, [hl]
    push af
    ld c, $67
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    pop af
    push af
    ld c, $69
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    add hl, de
    sra h
    rr l
    pop af
    push af
    ld c, $63
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    add hl, de
    pop af
    push af
    ld c, $65
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    add hl, de
    pop af
    push af
    ld c, $5D
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    add hl, de
    pop af
    push af
    ld c, $61
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    add hl, de
    pop af
    ld a, $19
    call DivideHLByA
    ldh a, [hFFCA]
    ld e, a
    ldh a, [hFFCB]
    ld d, a
    add hl, de
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    pop hl
    inc hl
    pop bc
    dec b
    jp nz, Jump_061_401E
    xor a, a
    ld [rRAMG], a
    ldh a, [hFFCA]
    ld l, a
    ldh a, [hFFCB]
    ld h, a
    ld a, [wC6FD]
    call DivideHLByA
    ld a, h
    or a, a
    jr nz, Jump_061_40AA
    ld a, l
    cp a, $63
    jr c, Jump_061_40B0

Jump_061_40AA::
    ld a, $63
    ld [wCD05], a
    ret

Jump_061_40B0::
    ld [wCD05], a
    ret

; 2 call sites from 2 routines (e.g. Func_00A_465D_Case06, Func_012_6955)
; reads: wC6FD, hFFC6, hFFC7, hFFC8, hFFC9, hFFCA, hFFCB, hFFCC, ...
; writes: wCD05, hFFCA, hFFCB, hFFCC, hFFCD, rRAMG, hFFC8, hFFC9
; points at: wC6FE
Func_061_40B4::
    ld a, [wC6FD]
    or a, a
    jr nz, Jump_061_40BF
    xor a, a
    ld [wCD05], a
    ret

Jump_061_40BF::
    ld b, a
    ld hl, $0000
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    ld a, l
    ldh [hFFCC], a
    ld a, h
    ldh [hFFCD], a
    ld hl, wC6FE
    ld a, $0A
    ld [rRAMG], a

Jump_061_40D7::
    push bc
    push hl
    ld a, [hl]
    push af
    ld c, $67
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    pop af
    push af
    ld c, $69
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    add hl, de
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    sra h
    rr l
    pop af
    push af
    ld c, $63
    call LoadSRAMRecordWord
    push hl
    ldh a, [hFFC8]
    ld l, a
    ldh a, [hFFC9]
    ld h, a
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    add hl, de
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    pop hl
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    add hl, de
    pop af
    push af
    ld c, $65
    call LoadSRAMRecordWord
    push hl
    ldh a, [hFFC8]
    ld l, a
    ldh a, [hFFC9]
    ld h, a
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    add hl, de
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    pop hl
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    add hl, de
    pop af
    push af
    ld c, $5D
    call LoadSRAMRecordWord
    push hl
    ldh a, [hFFC8]
    ld l, a
    ldh a, [hFFC9]
    ld h, a
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    add hl, de
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    pop hl
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    add hl, de
    pop af
    push af
    ld c, $61
    call LoadSRAMRecordWord
    push hl
    ldh a, [hFFC8]
    ld l, a
    ldh a, [hFFC9]
    ld h, a
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    add hl, de
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    pop hl
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    add hl, de
    ld a, $32
    call DivideHLByA
    ldh a, [hFFCA]
    ld e, a
    ldh a, [hFFCB]
    ld d, a
    add hl, de
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    pop af
    push af
    ld c, $56
    call LoadSRAMRecordByte
    push bc
    ldh a, [hFFC6]
    ld c, $18
    call Multiply8
    ld e, l
    ld d, h
    pop bc
    ldh a, [hFFC8]
    ld l, a
    ldh a, [hFFC9]
    ld h, a
    ld a, l
    sub a, e
    ld l, a
    ld a, h
    sbc a, d
    ld h, a
    ld a, h
    bit 7, a
    jr z, Jump_061_41C4
    ld hl, $0000
    jr Jump_061_41C9

Jump_061_41C4::
    ld a, $32
    call DivideHLByA

Jump_061_41C9::
    ldh a, [hFFCC]
    ld e, a
    ldh a, [hFFCD]
    ld d, a
    add hl, de
    ld a, l
    ldh [hFFCC], a
    ld a, h
    ldh [hFFCD], a
    pop af
    pop hl
    inc hl
    pop bc
    dec b
    jp nz, Jump_061_40D7
    xor a, a
    ld [rRAMG], a
    ldh a, [hFFCA]
    ld l, a
    ldh a, [hFFCB]
    ld h, a
    ldh a, [hFFCC]
    ld e, a
    ldh a, [hFFCD]
    ld d, a
    add hl, de
    bit 7, h
    jr z, Jump_061_41F8
    xor a, a
    ld [wCD05], a
    ret

Jump_061_41F8::
    ld a, [wC6FD]
    call DivideHLByA
    ld a, l
    cp a, $63
    jr c, Jump_061_4209
    ld a, $63
    ld [wCD05], a
    ret

Jump_061_4209::
    ld [wCD05], a
    ret

; 1 call site from 1 routine (e.g. Func_000_1C0C)
; reads: wCC44
Func_061_420D::
    ld a, [wCC44]
    and a, $07
    rst $00
    dw Func_061_420D_Case00
    dw Func_061_420D_Case01
    dw Func_061_420D_Case02
    dw Func_061_420D_Case03
    dw Func_061_420D_Case03
    dw Func_061_420D_Case05
    dw Func_061_420D_Case06
    dw Func_061_420D_Case07

; entry 7 of the `rst $00` table in Func_061_420D
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6
Func_061_420D_Case07::
Jump_061_4223:: ; address name
    ld a, $66
    ldh [hFFC6], a
    call LoadSpecialMapHeader
    ret

; entry 6 of the `rst $00` table in Func_061_420D
; no direct call (reached through a table, a jump or a vector)
; reads: wCC45, hFFC6
; writes: hFFC6
; points at: wCD89, wCDAF
Func_061_420D_Case06::
Jump_061_422B:: ; address name
    ld a, [wCC45]
    sla a
    sla a
    push af
    ld hl, wCD89
    add_a_to_hl
    ld a, [hl]
    dec a
    dec a
    dec a
    inc a
    and a, $01
    ldh [hFFC6], a
    pop af
    ld hl, wCDAF
    ld a, [wCC45]
    swap a
    add_a_to_hl
    ld a, [hl]
    and a, $01
    add a, a
    ld c, a
    ldh a, [hFFC6]
    add a, $50
    ldh [hFFC6], a
    call LoadSpecialMapHeader
    ret

; entry 5 of the `rst $00` table in Func_061_420D
; no direct call (reached through a table, a jump or a vector)
; reads: wCC45, wIsCGB
; writes: wC526, wMapWidthScreens, wMapHeightScreens, wMaxBlockingTile, wC90D, wC195, wC197, wC196, ...
; points at: wCDAE, wBGPaletteBuffer
Func_061_420D_Case05::
Jump_061_4261:: ; address name
    ld a, [wCC45]
    swap a
    ld hl, wCDAE
    add_a_to_hl
    ld a, [hl]
    push af
    ld c, a
    sla a
    add a, c
    sla a
    ld hl, Data_061_42DD
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld b, a
    push hl
    ld hl, vTiles2
    call DecompressToVRAM
    pop hl
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_061_42A5
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld b, a
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBank
    ld a, $7F
    ld [wC526], a

Jump_061_42A5::
    ld a, $04
    ld [wMapWidthScreens], a
    ld [wMapHeightScreens], a
    ld a, $3F
    ld [wMaxBlockingTile], a
    xor a, a
    ld [wC90D], a
    ld a, $10
    ld [wC195], a
    ld a, $2A
    ld [wC197], a
    xor a, a
    ld [wC196], a
    ld a, $A3
    ld [wC901], a
    pop af
    cp a, $07
    jr z, Jump_061_42D7
    cp a, $09
    jr z, Jump_061_42D7
    xor a, a
    ld [wC194], a
    ret

Jump_061_42D7::
    ld a, $05
    ld [wC194], a
    ret

Data_061_42DD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01
    dw Data_061_6D40
    db $AB
    dw Data_061_6D43
    db $69
    dw Data_061_6D56
    db $F6
    dw Data_061_6D59
    db $A8
    dw Data_061_6D6C
    db $39
    dw Data_061_6D70
    db $71
    dw Data_061_6E48
    db $05
    dw Data_061_6E4C
    db $65
    dw Data_061_6E5E
    db $94
    dw Data_061_6E62
    db $E4
    dw Data_061_6E74
    db $E0
    dw Data_061_6E77
    db $1E
    dw Data_061_6F50
    db $FE
    dw Data_061_6F52
    db $97
    dw Data_061_6F63
    db $50
    dw Data_061_6F66
    db $01
    dw Data_061_7040
    db $CD
    dw Data_061_7042
    db $D9
    dw Data_061_7053
    db $66
    dw Data_061_7056
    db $F0
    dw Data_061_7067
    db $84
    dw Data_061_706A
    db $9D
    dw Data_061_707A
    db $BA
    dw Data_061_707E

; entry 1 of the `rst $00` table in Func_061_420D
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wCC45
; writes: wC526, wMaxBlockingTile, wC90D, wC195, wC196, wMapWidthScreens, wMapHeightScreens, wC901, ...
; points at: wBGPaletteBuffer, wCD7B
Func_061_420D_Case01::
Jump_061_4325:: ; address name
    ld de, Data_06E_74E4
    ld b, $6E
    ld hl, vTiles2
    call DecompressToVRAM
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_061_4348
    ld de, Data_06E_77E0
    ld b, $6E
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBank
    ld a, $7F
    ld [wC526], a

Jump_061_4348::
    ld a, $3F
    ld [wMaxBlockingTile], a
    xor a, a
    ld [wC90D], a
    ld [wC195], a
    ld [wC196], a
    ld hl, wCD7B
    ld a, [wCC45]
    sla a
    sla a
    add_a_to_hl
    ld a, [hl]
    and a, $0F
    dec a
    sla a
    sla a
    sla a
    ld e, a
    ld d, $00
    ld a, [hl]
    swap a
    and a, $0F
    dec a
    sla a
    add a, e
    ld e, a
    jr nc, Jump_061_4380
    inc d

Jump_061_4380::
    ld a, e
    add a, $05
    ld e, a
    ld a, d
    adc a, $67
    ld d, a
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [hl+]
    ld [wMapWidthScreens], a
    ld a, [hl]
    ld [wMapHeightScreens], a
    ld a, $A3
    ld [wC901], a
    xor a, a
    ld [wC194], a
    ret

; entry 2 of the `rst $00` table in Func_061_420D
; no direct call (reached through a table, a jump or a vector)
; reads: wCC45, hFFC6
; writes: hFFC6, wCD06
; points at: hFFC6
Func_061_420D_Case02::
Jump_061_439F:: ; address name
    ld a, $61
    ldh [hFFC6], a
    ld a, [wCC45]
    bit 7, a
    jr z, Jump_061_43AE
    ld hl, hFFC6
    inc [hl]

Jump_061_43AE::
    ldh a, [hFFC6]
    sub a, $61
    ld [wCD06], a
    call LoadSpecialMapHeader
    ret

; entry 3 of the `rst $00` table in Func_061_420D
; no direct call (reached through a table, a jump or a vector)
; reads: wCC45
; writes: hFFC6
; points at: wCDAC
Func_061_420D_Case03::
Jump_061_43B9:: ; address name
    ld hl, wCDAC
    ld a, [wCC45]
    swap a
    add_a_to_hl
    ld a, [hl]
    and a, $7F
    ldh [hFFC6], a
    call LoadSpecialMapHeader
    ret

; entry 0 of the `rst $00` table in Func_061_420D
; no direct call (reached through a table, a jump or a vector)
; reads: wCD0B, wIsCGB, wC195
; writes: wC526, wMaxBlockingTile, wC90D, wC901, wC194, wC196, wC197, wC195
; points at: wBGPaletteBuffer
Func_061_420D_Case00::
Jump_061_43CF:: ; address name
    ld a, [wCD0B]
    ld c, a
    sla a
    add a, c
    sla a
    ld l, a
    ld h, $00
    ld a, l
    add a, $28
    ld l, a
    ld a, h
    adc a, $57
    ld h, a
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld b, a
    push hl
    ld hl, vTiles2
    call DecompressToVRAM
    pop hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld b, a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_061_440A
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBank
    ld a, $7F
    ld [wC526], a

Jump_061_440A::
    ld a, $3D
    ld [wMaxBlockingTile], a
    ld a, [wCD0B]
    cp a, $04
    jr z, Jump_061_441D
    ld a, $02
    ld [wC90D], a
    jr Jump_061_4421

Jump_061_441D::
    xor a, a
    ld [wC90D], a

Jump_061_4421::
    ld a, $A2
    ld [wC901], a
    ld a, [wCD0B]
    cp a, $01
    jr z, Jump_061_4437
    cp a, $07
    jr z, Jump_061_4437
    xor a, a
    ld [wC194], a
    jr Jump_061_443C

Jump_061_4437::
    ld a, $04
    ld [wC194], a

Jump_061_443C::
    xor a, a
    ld [wC196], a
    ld [wC197], a
    ld a, [wCD0B]
    ld hl, Data_061_4468
    add_a_to_hl
    ld a, [hl]
    ld [wC195], a
    and a, $0F
    jr z, Jump_061_445B
    ld a, $29
    ld [wC196], a

Jump_061_445B::
    ld a, [wC195]
    and a, $F0
    jr z, Jump_061_4467
    ld a, $2C
    ld [wC197], a

Jump_061_4467::
    ret

Data_061_4468:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $11, $11, $21, $11, $12, $12, $11, $11, $11, $31

; only called from LoadMapScreen (E-0047)
; 1 call site from 1 routine (e.g. LoadMapScreen)
; reads: wCC44
LoadMapScreen_Sub03::
Func_061_4472:: ; address name
    ld a, [wCC44]
    and a, $07
    rst $00
    dw Func_061_4472_Case00
    dw Func_061_4472_Case01
    dw Func_061_4472_Case02
    dw Func_061_4472_Case03
    dw Func_061_4472_Case03
    dw Func_061_4472_Case05
    dw Func_061_4472_Case06
    dw Func_061_4472_Case07

; entry 7 of the `rst $00` table in Func_061_4472
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6
Func_061_4472_Case07::
Jump_061_4488:: ; address name
    ld a, $66
    ldh [hFFC6], a
    call Func_000_1906
    ret

; entry 6 of the `rst $00` table in Func_061_4472
; no direct call (reached through a table, a jump or a vector)
; reads: wCC45, hFFC6
; writes: hFFC6
; points at: wCD89, wCDAF
Func_061_4472_Case06::
Jump_061_4490:: ; address name
    ld a, [wCC45]
    sla a
    sla a
    push af
    ld hl, wCD89
    add_a_to_hl
    ld a, [hl]
    dec a
    dec a
    dec a
    dec a
    and a, $01
    ldh [hFFC6], a
    pop af
    ld hl, wCDAF
    ld a, [wCC45]
    swap a
    add_a_to_hl
    ld a, [hl]
    push hl
    cp a, $FF
    jr nz, Jump_061_44BF
    ld a, $00

Jump_061_44BF::
    dec a
    and a, $01
    sla a
    ld c, a
    ldh a, [hFFC6]
    add a, $50
    ldh [hFFC6], a
    call Func_000_1906
    pop hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_061_44D7
    and a, $01
    ret z

Jump_061_44D7::
    call Func_061_44DB
    ret

; 3 call sites from 3 routines (e.g. Func_061_4472_Case06, ScriptCommand86_Run_Case04, ScriptCommand86_Run_Case02)
; reads: wCC45, wIsCGB
; writes: rSVBK
; points at: wCDAF, wC244
Func_061_44DB::
    ld a, [wCC45]
    swap a
    ld de, wCDAF
    add a, e
    ld e, a
    jr nc, Jump_061_44E8
    inc d

Jump_061_44E8::
    ld c, $1A
    ld a, [de]
    cp a, $FF
    jr nz, Jump_061_44F1
    ld c, $1C

Jump_061_44F1::
    ld hl, wC244
    push hl
    ld a, c
    ld [hl+], a
    inc a
    ld [hl-], a
    ld a, $14
    add_a_to_hl
    ld a, $1E
    ld [hl+], a
    inc a
    ld [hl], a
    pop hl
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $02
    ldh [rSVBK], a
    ld a, l
    sub a, $98
    ld l, a
    ld a, h
    sbc a, $C1
    ld h, a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld a, $05
    ld [hl+], a
    ld [hl-], a
    ld a, $14
    add_a_to_hl
    ld a, $05
    ld [hl+], a
    ld [hl], a
    ld a, $00
    ldh [rSVBK], a
    ret

; entry 5 of the `rst $00` table in Func_061_4472
; no direct call (reached through a table, a jump or a vector)
; reads: wCC45, wCC43, hMapScreenY, hMapScreenX, wIsCGB
; writes: hFFC6, rSVBK
; points at: wCDAD, wScreenTileBuffer, wD000
Func_061_4472_Case05::
Jump_061_4533:: ; address name
    ld a, [wCC45]
    swap a
    ld hl, wCDAD
    add_a_to_hl
    ld a, [hl]
    add a, a
    ld e, a
    ld d, $00
    ld a, [wCC43]
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_061_454E
    inc d

Jump_061_454E::
    ld a, e
    add a, $2C
    ld e, a
    ld a, d
    adc a, $CE
    ld d, a
    ld a, [de]
    ldh [hFFC6], a
    ld e, a
    ld d, $00
    sla e
    rl d
    ld a, e
    add a, $01
    ld e, a
    ld a, d
    adc a, $40
    ld d, a
    ld b, $72
    call ReadByteInBank
    ld l, c
    inc de
    call ReadByteInBank
    ld h, c
    inc hl
    inc hl
    inc hl
    ldh a, [hMapScreenY]
    ld c, a
    sla a
    add a, c
    sla a
    sla a
    add_a_to_hl
    ldh a, [hMapScreenX]
    ld c, a
    sla a
    add a, c
    add_a_to_hl
    push hl
    push bc
    ld e, l
    ld d, h
    call ReadByteInBank
    ld l, c
    inc de
    call ReadByteInBank
    ld h, c
    inc de
    call ReadByteInBank
    ld b, c
    ld e, l
    ld d, h
    ld hl, wScreenTileBuffer
    call DecompressToVRAM
    pop bc
    pop hl
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_061_45E1
    ld a, l
    add a, $30
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    call ReadByteInBank
    ld a, c
    ld l, a
    inc de
    call ReadByteInBank
    ld a, c
    ld h, a
    inc de
    call ReadByteInBank
    ld a, c
    ld b, a
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    ld a, $02
    ldh [rSVBK], a
    ld hl, wD000
    call DecompressToVRAM
    ld a, $00
    ldh [rSVBK], a

Jump_061_45E1::
    call Func_061_474C
    call Func_061_45E8
    ret

; 2 call sites from 2 routines (e.g. Func_061_4472_Case05, ScriptCommand81_Run_Case02)
; reads: wCC45, wCC43, hMapScreenX, hMapScreenY, wIsCGB
; writes: rSVBK
; points at: wCDB0, wCDAD
Func_061_45E8::
    ld a, [wCC45]
    swap a
    ld hl, wCDB0
    add_a_to_hl
    push hl
    ld a, [hl]
    ld b, a
    ld a, [wCC43]
    cp a, b
    jr nz, Jump_061_4613
    inc hl
    inc hl
    ld a, [hl+]
    ld b, a
    ld a, [hl]
    or a, a
    jr z, Jump_061_460A
    ld c, $80
    jr Jump_061_460E

Jump_061_460A::
    dec hl
    dec hl
    ld a, [hl]
    ld c, a

Jump_061_460E::
    push hl
    call Func_061_462F
    pop hl

Jump_061_4613::
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    ld b, a
    ld a, [wCC43]
    cp a, b
    ret nz
    inc hl
    inc hl
    ld a, [hl+]
    ld b, a
    ld a, [hl]
    or a, a
    jr z, Jump_061_462B
    ld c, $80
    jr Func_061_462F

Jump_061_462B::
    dec hl
    dec hl
    ld a, [hl]
    ld c, a

; 1 call site from 1 routine (e.g. Func_061_45E8)
; reads: hMapScreenX, hMapScreenY, wCC45, wCC43, wIsCGB
; writes: rSVBK
; points at: wCDAD
Func_061_462F::
    ld a, b
    ld hl, Data_061_4810
    add_a_to_hl
    ld a, [hl]
    ld e, a
    ldh a, [hMapScreenX]
    swap a
    ld d, a
    ldh a, [hMapScreenY]
    or a, d
    cp a, e
    ret nz
    bit 7, c
    jr nz, Jump_061_464C
    ld a, $2C
    jr Jump_061_464E

Jump_061_464C::
    ld a, $2E

Jump_061_464E::
    push af
    ld a, [wCC45]
    swap a
    ld de, wCDAD
    add a, e
    ld e, a
    jr nc, Jump_061_465C
    inc d

Jump_061_465C::
    ld a, [de]
    add a, a
    ld e, a
    ld d, $00
    ld a, [wCC43]
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_061_466A
    inc d

Jump_061_466A::
    ld a, e
    add a, $2C
    ld e, a
    ld a, d
    adc a, $CE
    ld d, a
    ld a, [de]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld a, b
    sla a
    add a, e
    ld e, a
    jr nc, Jump_061_468E
    inc d

Jump_061_468E::
    ld a, e
    add a, $19
    ld e, a
    ld a, d
    adc a, $48
    ld d, a
    ld a, [de]
    push de
    ld l, a
    ld h, $00
    ld e, l
    ld d, h
    add hl, hl
    add hl, hl
    add hl, de
    add hl, hl
    add hl, hl
    add hl, hl
    pop de
    dec de
    ld a, [de]
    sla a
    add_a_to_hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    pop af
    push hl
    ld [hl+], a
    inc a
    ld [hl-], a
    push af
    ld a, $14
    add_a_to_hl
    pop af
    add a, $0F
    ld [hl+], a
    inc a
    ld [hl], a
    pop hl
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $02
    ldh [rSVBK], a
    ld a, l
    sub a, $98
    ld l, a
    ld a, h
    sbc a, $C1
    ld h, a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld a, [hl]
    and a, $F8
    or a, $06
    ld [hl+], a
    ld a, [hl]
    and a, $F8
    or a, $06
    ld [hl-], a
    ld a, $14
    add_a_to_hl
    ld a, [hl]
    and a, $F8
    or a, $06
    ld [hl+], a
    ld a, [hl]
    and a, $F8
    or a, $06
    ld [hl-], a
    ld a, $00
    ldh [rSVBK], a
    ret

; 1 call site from 1 routine (e.g. Func_060_68EB)
; reads: wCC45, wCC43, hFFC6
; writes: hFFC6
; points at: wCDAD
Func_061_4706::
    push hl
    ld a, [wCC45]
    swap a
    ld hl, wCDAD
    add_a_to_hl
    ld a, [hl]
    add a, a
    ld l, a
    ld h, $00
    ld a, [wCC43]
    add a, a
    add_a_to_hl
    ld a, l
    add a, $2C
    ld l, a
    ld a, h
    adc a, $CE
    ld h, a
    ld a, [hl]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ldh a, [hFFC6]
    add a, a
    add_a_to_hl
    ld a, l
    add a, $18
    ld l, a
    ld a, h
    adc a, $48
    ld h, a
    ld a, [hl+]
    swap a
    ld c, a
    ld a, [hl]
    or a, c
    ldh [hFFC6], a
    pop hl
    ret

; 1 call site from 1 routine (e.g. Func_061_4472_Case05)
; reads: wCC45, wCC43, hMapScreenX, hMapScreenY, hFFC6, wIsCGB
; writes: hFFC6, rSVBK
; points at: wCD89, wCDAD, wCE2D, wC240, wD0A8
Func_061_474C::
    ld a, [wCC45]
    add a, a
    add a, a
    push af
    ld hl, wCD89
    add_a_to_hl
    ld a, [hl]
    ldh [hFFC6], a
    pop af
    add a, a
    add a, a
    ld hl, wCDAD
    add_a_to_hl
    ld a, [hl]
    add a, a
    ld hl, wCE2D
    add_a_to_hl
    ld a, [wCC43]
    add a, a
    add_a_to_hl
    ldh a, [hMapScreenX]
    and a, $0F
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    and a, $0F
    or a, c
    ld c, a
    ld a, [hl]
    and a, $0F
    cp a, $0F
    jr z, Jump_061_479B
    ld de, Data_061_480A
    add a, e
    ld e, a
    jr nc, Jump_061_4797
    inc d

Jump_061_4797::
    ld a, [de]
    cp a, c
    jr z, Jump_061_47AD

Jump_061_479B::
    ld a, [hl]
    swap a
    and a, $0F
    ld de, Data_061_480A
    add a, e
    ld e, a
    jr nc, Jump_061_47A8
    inc d

Jump_061_47A8::
    ld a, [de]
    cp a, c
    jr z, Jump_061_47B9
    ret

Jump_061_47AD::
    ldh a, [hFFC6]
    dec a
    dec a
    dec a
    dec a
    sla a
    add a, $46
    jr Jump_061_47C5

Jump_061_47B9::
    ldh a, [hFFC6]
    dec a
    dec a
    dec a
    dec a
    sla a
    ld c, a
    ld a, $48
    sub a, c

Jump_061_47C5::
    ld hl, wC240
    ld [hl+], a
    inc a
    ld [hl-], a
    push af
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    pop af
    add a, $0F
    ld [hl+], a
    inc a
    ld [hl-], a
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $02
    ldh [rSVBK], a
    ld hl, wD0A8
    ld a, [hl]
    and a, $F8
    or a, $04
    ld [hl+], a
    ld a, [hl]
    and a, $F8
    or a, $04
    ld [hl-], a
    ld a, $14
    add_a_to_hl
    ld a, [hl]
    and a, $F8
    or a, $04
    ld [hl+], a
    ld a, [hl]
    and a, $F8
    or a, $04
    ld [hl-], a
    ld a, $00
    ldh [rSVBK], a
    ret

Data_061_480A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $30, $11, $22, $03, $33

Data_061_4810:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $184810, $98
    ds $40, $04
    db $03, $03, $03, $02, $02, $06, $07, $02, $03, $02, $02, $03, $06, $06, $05, $05
    db $01, $04, $04, $04, $04, $04, $04, $07, $04, $04, $07, $03
    ds $14, $04
    INCBIN "dwm2-cobi-us.gbc", $184918, $EC
    ds $12, $04
    db $07, $05, $05, $07, $04, $03, $03, $03, $04, $04, $06, $02, $04, $03, $06, $04
    db $01, $03
    ds $40, $04
    db $07, $06, $05, $02, $06, $03, $04, $02, $08, $02, $03, $03, $01, $02, $07, $04
    db $04, $04, $04, $04, $08, $02, $04, $04, $04, $04, $02, $07
    ds $14, $04
    INCBIN "dwm2-cobi-us.gbc", $184A98, $72
    ds $3E, $04
    db $01, $06, $07, $06, $07, $02, $01, $05, $05, $06, $01, $07, $01, $03, $07, $06
    ds $10, $04
    db $05, $01, $03, $03, $04, $02, $08, $03, $06, $02, $05, $07, $03, $05, $03, $03
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $06, $06
    ds $54, $04
    db $07, $03, $07, $02, $03, $05, $04, $04, $05, $04, $05, $05, $04, $03, $01, $06
    db $07, $06, $02, $04, $05, $06, $07, $02, $01, $02, $07, $03, $08, $03, $05, $03
    db $04, $04, $04, $04, $04, $04, $04, $04, $02, $04, $04, $04, $04, $04, $03, $03
    ds $10, $04
    INCBIN "dwm2-cobi-us.gbc", $184C18, $6E
    ds $10, $04
    INCBIN "dwm2-cobi-us.gbc", $184C96, $17E
    ds $34, $04
    db $07, $05, $02, $05, $05, $06, $05, $02, $07, $06, $01, $05, $05, $03, $02, $03
    ds $10, $04
    db $06, $03, $06, $03, $06, $03, $02, $06, $02, $05, $01, $07, $02, $02, $04, $06
    db $04, $04, $05, $03, $04, $04, $01, $06, $04, $04, $06, $02, $04, $04, $08, $06
    ds $50, $04
    db $07, $06, $02, $02, $07, $03, $04, $02, $06, $06, $03, $04, $07, $04, $04, $06
    db $03, $03, $01, $06, $07, $05, $01, $03, $04, $02, $01, $02, $07, $03, $03, $05
    db $03, $02, $04, $04, $06, $05, $04, $04, $02, $06, $06, $03, $07, $02
    ds $1C, $04
    INCBIN "dwm2-cobi-us.gbc", $184F22, $F4
    ds $42, $04
    db $05, $04, $03, $07, $01, $02, $05, $06, $02, $02, $02, $06, $01, $04, $01, $07
    db $04, $07, $03, $06, $07, $07, $06, $04, $07, $04, $02, $05, $01, $03, $07, $05
    db $01, $04, $06, $02, $05, $05, $04, $04, $08, $05
    ds $46, $04
    db $05, $02, $05, $04, $01, $02, $08, $02, $05, $02, $05, $06, $07, $02, $07, $03
    ds $12, $04
    db $03, $04, $01, $03, $02, $05, $03, $04, $04, $04, $04, $04, $05, $01, $04, $04
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $08, $03, $04, $06
    ds $11, $04
    INCBIN "dwm2-cobi-us.gbc", $185119, $FE
    ds $51, $04
    ds $30, $00
    ds $50, $04
    ds $30, $00
    ds $50, $04
    ds $30, $00
    ds $50, $04
    ds $30, $00

; entry 1 of the `rst $00` table in Func_061_4472
; no direct call (reached through a table, a jump or a vector)
Func_061_4472_Case01::
Jump_061_5418:: ; address name
    ret
    db $C9

; entry 2 of the `rst $00` table in Func_061_4472
; no direct call (reached through a table, a jump or a vector)
; reads: wCC45
; writes: hFFC6
; points at: hFFC6
Func_061_4472_Case02::
Jump_061_541A:: ; address name
    ld a, $61
    ldh [hFFC6], a
    ld a, [wCC45]
    bit 7, a
    jr z, Jump_061_5429
    ld hl, hFFC6
    inc [hl]

Jump_061_5429::
    call Func_000_1906
    ret

; entry 3 of the `rst $00` table in Func_061_4472
; no direct call (reached through a table, a jump or a vector)
; reads: wCC45
; writes: hFFC6
; points at: wCDAC
Func_061_4472_Case03::
Jump_061_542D:: ; address name
    ld hl, wCDAC
    ld a, [wCC45]
    swap a
    add_a_to_hl
    ld a, [hl]
    and a, $7F
    ldh [hFFC6], a
    call Func_000_1906
    ret

; entry 0 of the `rst $00` table in Func_061_4472
; no direct call (reached through a table, a jump or a vector)
; reads: hMapScreenY, hMapScreenX, wIsCGB
; writes: rSVBK
; points at: wScreenTileBuffer, wD000
Func_061_4472_Case00::
Jump_061_5443:: ; address name
    ldh a, [hMapScreenY]
    and a, $FC
    add a, a
    ld l, a
    ld h, $00
    ldh a, [hMapScreenX]
    and a, $FC
    add_a_to_hl
    ld a, l
    add a, $60
    ld l, a
    ld a, h
    adc a, $CD
    ld h, a
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld b, a
    push bc
    ld a, [hl]
    ld c, $60
    call Multiply8
    add hl, de
    pop bc
    ldh a, [hMapScreenY]
    and a, $03
    ld c, a
    sla a
    add a, c
    sla a
    sla a
    add_a_to_hl
    ldh a, [hMapScreenX]
    and a, $03
    ld c, a
    sla a
    add a, c
    add_a_to_hl
    push hl
    ld e, l
    ld d, h
    call ReadByteInBank
    ld l, c
    inc de
    call ReadByteInBank
    ld h, c
    push bc
    inc de
    call ReadByteInBank
    ld b, c
    ld e, l
    ld d, h
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    ld hl, wScreenTileBuffer
    call DecompressToVRAM
    pop bc
    pop hl
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_061_54E2
    ld a, l
    add a, $30
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    call ReadByteInBank
    ld a, c
    ld l, a
    inc de
    call ReadByteInBank
    ld a, c
    ld h, a
    inc de
    call ReadByteInBank
    ld a, c
    ld b, a
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    ld a, $02
    ldh [rSVBK], a
    ld hl, wD000
    call DecompressToVRAM
    ld a, $00
    ldh [rSVBK], a

Jump_061_54E2::
    call Func_061_55AF
    call Func_061_562F
    call Func_061_54EC
    ret

; 1 call site from 1 routine (e.g. Func_061_4472_Case00)
; reads: wCC44, wC88E, wC891, wCC42, hMapScreenX, hMapScreenY, wC890, wC88F, ...
; writes: rSVBK
Func_061_54EC::
    ld a, [wCC44]
    cp a, $80
    ret nz
    ld a, [wC88E]
    or a, a
    jr z, Jump_061_5548
    ld a, [wC891]
    bit 7, a
    jr z, Jump_061_5548
    and a, $7F
    ld c, a
    ld a, [wCC42]
    cp a, c
    jr nz, Jump_061_5548
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or a, c
    ld c, a
    ld a, [wC890]
    cp a, c
    ret nz
    ld a, [wC88F]
    and a, $0F
    ld c, a
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_061_552D
    inc d

Jump_061_552D::
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld a, [wC88F]
    swap a
    and a, $0F
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_061_5546
    inc d

Jump_061_5546::
    jr Jump_061_5585

Jump_061_5548::
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or a, c
    ld c, a
    ld a, [wCD08]
    cp a, c
    ret nz
    ld a, [wCD0A]
    swap a
    ld c, a
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_061_556D
    inc d

Jump_061_556D::
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld a, [wCD09]
    swap a
    sla a
    add a, e
    ld e, a
    jr nc, Jump_061_5585
    inc d

Jump_061_5585::
    push de
    ld a, e
    add a, $98
    ld e, a
    ld a, d
    adc a, $C1
    ld d, a
    ld a, $46
    call Func_061_56E3
    pop de
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $D0
    ld d, a
    ld a, $02
    ldh [rSVBK], a
    ld a, $05
    call Func_061_5718
    ld a, $00
    ldh [rSVBK], a
    ret

; 1 call site from 1 routine (e.g. Func_061_4472_Case00)
; reads: hMapScreenX, hMapScreenY, wIsCGB
; writes: rSVBK
; points at: wCD7B, wC240, wD0A8
Func_061_55AF::
    ld hl, wCD7B

Jump_061_55B2::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_061_562E
    push hl
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    swap a
    and a, $0F
    ld b, a
    ld a, [hl]
    and a, $0F
    ld c, a
    ldh a, [hMapScreenX]
    cp a, b
    jr nz, Jump_061_560E
    ldh a, [hMapScreenY]
    cp a, c
    jr nz, Jump_061_560E
    ldh a, [hMapScreenY]

Jump_061_55D1::
    pop hl
    ld de, wC240
    dec hl
    ld a, [hl]
    or a, a
    jr nz, Jump_061_55E1
    ld a, $46
    call Func_061_56E3
    jr Jump_061_55F6

Jump_061_55E1::
    ld a, $70
    ld [de], a
    inc de
    inc a
    ld [de], a
    inc a
    push af
    ld a, e
    add a, $13
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop af
    ld [de], a
    inc de
    inc a
    ld [de], a

Jump_061_55F6::
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_061_562E
    ld de, wD0A8
    ld a, $02
    ldh [rSVBK], a
    ld a, $05
    call Func_061_5718
    ld a, $00
    ldh [rSVBK], a
    jr Jump_061_562E

Jump_061_560E::
    inc hl
    ld a, [hl]
    swap a
    and a, $0F
    ld b, a
    ld a, [hl]
    and a, $0F
    ld c, a
    ldh a, [hMapScreenX]
    cp a, b
    jr nz, Jump_061_5627
    ldh a, [hMapScreenY]
    cp a, c
    jr nz, Jump_061_5627
    ldh a, [hMapScreenY]
    jr Jump_061_55D1

Jump_061_5627::
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_061_55B2

Jump_061_562E::
    ret

; 1 call site from 1 routine (e.g. Func_061_4472_Case00)
; reads: hMapScreenX, hMapScreenY, wIsCGB
; writes: rSVBK
; points at: wCD8B, wC240, wD0A8
Func_061_562F::
    ld hl, wCD8B

Jump_061_5632::
    ld a, [hl]
    cp a, $FF
    ret z
    push hl
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    swap a
    and a, $0F
    ld b, a
    ld a, [hl]
    and a, $0F
    ld c, a
    ldh a, [hMapScreenX]
    cp a, b
    jp nz, Jump_061_56DA
    ldh a, [hMapScreenY]
    cp a, c
    jp nz, Jump_061_56DA
    pop hl
    ld de, wC240
    dec hl
    dec hl
    ld a, [hl]
    or a, a
    jr nz, Jump_061_565B
    ret

Jump_061_565B::
    dec a
    jr nz, Jump_061_5667

Jump_061_565E::
    ld a, $68
    call Func_061_56F8
    ld c, $01
    jr Jump_061_56A6

Jump_061_5667::
    dec a
    jr nz, Jump_061_5680
    ld a, $4C
    call Func_061_56E3
    ld a, e
    sub a, $13
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    ld a, $4E
    call Func_061_56E3
    ld c, $01
    jr Jump_061_56A6

Jump_061_5680::
    dec a
    jr nz, Jump_061_568C
    ld a, $60
    call Func_061_56F8
    ld c, $01
    jr Jump_061_56A6

Jump_061_568C::
    dec a
    jr nz, Jump_061_5698
    ld a, $4A
    call Func_061_56E3
    ld c, $00
    jr Jump_061_56A6

Jump_061_5698::
    dec a
    jr nz, Jump_061_56A4
    ld a, $48
    call Func_061_56E3
    ld c, $00
    jr Jump_061_56A6

Jump_061_56A4::
    jr Jump_061_565E

Jump_061_56A6::
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_061_56E2
    ld de, wD0A8
    ld a, $02
    ldh [rSVBK], a
    bit 0, c
    jr nz, Jump_061_56C2
    ld a, $05
    call Func_061_5718
    ld a, $00
    ldh [rSVBK], a
    jr Jump_061_56E2

Jump_061_56C2::
    ld a, $06
    call Func_061_5718
    ld a, e
    sub a, $13
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    ld a, $06
    call Func_061_5718
    ld a, $00
    ldh [rSVBK], a
    jr Jump_061_56E2

Jump_061_56DA::
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jp Jump_061_5632

Jump_061_56E2::
    ret

; 6 call sites from 3 routines (e.g. Func_061_54EC, Func_061_562F, Func_061_55AF)
Func_061_56E3::
    ld [de], a
    inc de
    inc a
    ld [de], a
    add a, $0F
    push af
    ld a, e
    add a, $13
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop af
    ld [de], a
    inc de
    inc a
    ld [de], a
    ret

; 2 call sites from 1 routine (e.g. Func_061_562F)
Func_061_56F8::
    ld [de], a
    inc a
    inc de
    ld [de], a
    inc a
    inc de
    ld [de], a
    inc a
    inc de
    ld [de], a
    inc a
    push af
    ld a, e
    add a, $11
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop af
    ld [de], a
    inc de
    inc a
    ld [de], a
    inc de
    inc a
    ld [de], a
    inc de
    inc a
    ld [de], a
    ret

; 5 call sites from 3 routines (e.g. Func_061_54EC, Func_061_562F, Func_061_55AF)
Func_061_5718::
    ld [de], a
    inc de
    ld [de], a
    push af
    ld a, $13
    add a, e
    ld e, a
    jr nc, Jump_061_5723
    inc d

Jump_061_5723::
    pop af
    ld [de], a
    inc de
    ld [de], a
    ret
    db $01, $40, $90, $8F, $44, $90, $01, $40, $63, $68, $44, $63, $01, $40, $64, $CF
    db $44, $90, $01, $40, $66, $01, $40, $65, $38
    dw Data_061_624B
    db $8E
    dw Data_061_6250
    db $6B
    dw Data_061_634C
    db $70
    dw Data_061_6351
    db $61
    dw Data_061_644C
    db $E8
    dw Data_061_6450
    db $D8
    dw Data_061_6547
    db $79
    dw Data_061_654C
    db $52, $58, $62, $2D, $5D, $62, $07, $59, $63, $AD, $5D, $63

; only called from CheckWarpAtPlayer (E-0047)
; 1 call site from 1 routine (e.g. CheckWarpAtPlayer)
; reads: wCC44
CheckWarpAtPlayer_Sub01::
Func_061_5764:: ; address name
    ld a, [wCC44]
    and a, $07
    rst $00
    dw Func_061_5764_Case00
    dw Func_061_5764_Case01
    dw Func_061_5764_Case02
    dw Func_061_5764_Case03
    dw Func_061_5764_Case04
    dw Func_061_5764_Case05
    dw Func_061_5764_Case00
    dw Func_061_5764_Case07

; entry 0 of the `rst $00` table in Func_061_5764
; no direct call (reached through a table, a jump or a vector)
Func_061_5764_Case00::
Jump_061_577A:: ; address name
    ld c, $00
    ret

; entry 1 of the `rst $00` table in Func_061_5764
; no direct call (reached through a table, a jump or a vector)
Func_061_5764_Case01::
Jump_061_577D:: ; address name
    ld c, $00
    ret

; entry 2 of the `rst $00` table in Func_061_5764
; no direct call (reached through a table, a jump or a vector)
Func_061_5764_Case02::
Jump_061_5780:: ; address name
    call Func_061_585A
    ret

; entry 3 of the `rst $00` table in Func_061_5764
; no direct call (reached through a table, a jump or a vector)
Func_061_5764_Case03::
Jump_061_5784:: ; address name
    call Func_061_58BC
    ret

; entry 4 of the `rst $00` table in Func_061_5764
; no direct call (reached through a table, a jump or a vector)
Func_061_5764_Case04::
Jump_061_5788:: ; address name
    call Func_061_5807
    ret

; entry 5 of the `rst $00` table in Func_061_5764
; no direct call (reached through a table, a jump or a vector)
Func_061_5764_Case05::
Jump_061_578C:: ; address name
    call Func_061_57A4
    ret

; entry 7 of the `rst $00` table in Func_061_5764
; no direct call (reached through a table, a jump or a vector)
Func_061_5764_Case07::
Jump_061_5790:: ; address name
    call Func_061_5794
    ret

; 1 call site from 1 routine (e.g. Func_061_5764_Case07)
; reads: hMapScreenY
Func_061_5794::
    ldh a, [hMapScreenY]
    cp a, $01
    jr z, Jump_061_579D
    ld c, $00
    ret

Jump_061_579D::
    farcall Func_011_4268
    ret

; 1 call site from 1 routine (e.g. Func_061_5764_Case05)
; reads: wCC43, wCC45, hMapScreenX, hMapScreenY, hFF8C
; writes: hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8CA, wModeState, wC8C5, hFF8C, ...
; points at: wCD89
Func_061_57A4::
    ld a, [wCC43]
    or a, a
    jr z, Jump_061_57AD

Jump_061_57AA::
    ld c, $00
    ret

Jump_061_57AD::
    ld a, [wCC45]
    sla a
    sla a
    ld hl, wCD89
    add_a_to_hl
    ld a, [hl]
    cp a, $05
    jr nz, Jump_061_57AA
    ldh a, [hMapScreenX]
    dec a
    jr nz, Jump_061_57AA
    ldh a, [hMapScreenY]
    cp a, $04
    jr nz, Jump_061_57AA
    dec hl
    ld a, [hl]
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [hl]
    and a, $0F
    ldh [hMapScreenY], a
    ld a, $40
    ld [wC8C8], a
    ld [wC8C9], a
    ld a, $F0
    ld [wC8CA], a
    ld a, $60
    call QueueSoundEffect
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wC8C5], a
    ldh a, [hFF8C]
    or a, $80
    ldh [hFF8C], a
    ld a, $01
    ld [wC8C6], a
    ld c, $01
    ret

; 1 call site from 1 routine (e.g. Func_061_5764_Case04)
; reads: hMapScreenY, wCC45, hFF8C
; writes: hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8CA, wCC44, wModeState, wC8C5, ...
; points at: wCDAD
Func_061_5807::
    ldh a, [hMapScreenY]
    cp a, $01
    jr z, Jump_061_5810
    ld c, $00
    ret

Jump_061_5810::
    xor a, a
    ldh [hMapScreenX], a
    inc a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wC8C8], a
    ld a, $38
    ld [wC8C9], a
    ld a, $FF
    ld [wC8CA], a
    ld a, [wCC45]
    swap a
    ld hl, wCDAD
    add_a_to_hl
    ld a, [hl-]
    ld [hl], a
    ld a, $60
    call QueueSoundEffect
    ld a, $83
    ld [wCC44], a
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wC8C5], a
    ldh a, [hFF8C]
    or a, $40
    ldh [hFF8C], a
    ld a, $01
    ld [wC8C6], a
    ld c, $01
    ret

; 1 call site from 1 routine (e.g. Func_061_5764_Case02)
; reads: hMapScreenY, wCC45, hFF8C
; writes: hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8CA, wModeState, wC8C5, hFF8C, ...
; points at: wCD78
Func_061_585A::
    ldh a, [hMapScreenY]
    cp a, $01
    jr z, Jump_061_5863
    ld c, $00
    ret

Jump_061_5863::
    ld a, [wCC45]
    and a, $7F
    sla a
    sla a
    ld hl, wCD78
    add_a_to_hl
    ld a, [wCC45]
    bit 7, a
    jr z, Jump_061_587C
    inc hl

Jump_061_587C::
    ld a, [hl]
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [hl]
    and a, $0F
    ldh [hMapScreenY], a
    ld a, $40
    ld [wC8C8], a
    ld [wC8C9], a
    ld a, $F0
    ld [wC8CA], a
    ld a, $60
    call QueueSoundEffect
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wC8C5], a
    ldh a, [hFF8C]
    or a, $80
    ldh [hFF8C], a
    ldh a, [hFF8C]
    and a, $FE
    ldh [hFF8C], a
    ld a, $01
    ld [wC8C6], a
    ld c, $01
    ret

; 1 call site from 1 routine (e.g. Func_061_5764_Case03)
; reads: wCC45, hMapScreenX, hMapScreenY, hFF8C
; writes: wC8CA, wC8C8, wC8C9, hMapScreenX, hMapScreenY, wModeState, wC8C5, hFF8C, ...
; points at: wCDAC, wCD88
Func_061_58BC::
    ld a, [wCC45]
    swap a
    ld hl, wCDAC
    add_a_to_hl
    ld a, [hl]
    and a, $7F
    ld l, a
    ld h, $00
    sla l
    rl h
    ld de, Data_061_6566
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a

Jump_061_58DB::
    push de
    ld a, [de]
    inc de
    cp a, $80
    jr nz, Jump_061_58E6
    pop de
    ld c, $00
    ret

Jump_061_58E6::
    cp a, $FD
    jr z, Jump_061_590B
    cp a, $FE
    jr z, Jump_061_58F4
    cp a, $FF
    jr z, Jump_061_58F4
    jr Jump_061_590B

Jump_061_58F4::
    ld [wC8CA], a
    inc de
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hMapScreenX]
    cp a, c
    jr nz, Jump_061_590B
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hMapScreenY]
    cp a, c
    jr nz, Jump_061_590B
    jr Jump_061_5916
    db $F1

Jump_061_590B::
    pop de
    ld a, e
    add a, $09
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    jr Jump_061_58DB

Jump_061_5916::
    ld a, [de]
    cp a, $FF
    jr nz, Jump_061_5949
    inc de
    inc de
    inc de
    ld a, [de]
    ld [wC8C8], a
    inc de
    ld a, [de]
    ld [wC8C9], a
    ld a, [wCC45]
    sla a
    sla a
    ld hl, wCD88
    add_a_to_hl
    ld a, [hl]
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [hl]
    and a, $0F
    ldh [hMapScreenY], a
    ld a, $F0
    ld [wC8CA], a
    jr Jump_061_594D

Jump_061_5949::
    pop de
    ld c, $00
    ret

Jump_061_594D::
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wC8C5], a
    ldh a, [hFF8C]
    or a, $80
    ldh [hFF8C], a
    ld a, $01
    ld [wC8C6], a
    pop de
    ld a, $60
    call QueueSoundEffect
    ld c, $01
    ret

; 1 call site from 1 routine (e.g. Func_011_4130)
; reads: wCC44
Func_061_596F::
    ld a, [wCC44]
    and a, $07
    rst $00
    dw Func_061_596F_Case00
    dw Func_061_596F_Case01
    dw Func_061_596F_Case02
    dw Func_061_596F_Case03
    dw Func_061_596F_Case04
    dw Func_061_596F_Case05
    dw Func_061_596F_Case06
    dw Func_061_596F_Case04

; entry 4 of the `rst $00` table in Func_061_596F
; no direct call (reached through a table, a jump or a vector)
Func_061_596F_Case04::
Jump_061_5985:: ; address name
    ret

; entry 0 of the `rst $00` table in Func_061_596F
; no direct call (reached through a table, a jump or a vector)
Func_061_596F_Case00::
Jump_061_5986:: ; address name
    call Func_061_5E8D
    or a, a
    ret nz
    call Func_061_5F39
    or a, a
    ret nz
    call Func_061_5CD0
    or a, a
    ret nz
    ret

; entry 1 of the `rst $00` table in Func_061_596F
; no direct call (reached through a table, a jump or a vector)
Func_061_596F_Case01::
Jump_061_5996:: ; address name
    call ReturnStub_5CCF
    ret

; entry 2 of the `rst $00` table in Func_061_596F
; no direct call (reached through a table, a jump or a vector)
Func_061_596F_Case02::
Jump_061_599A:: ; address name
    call Func_061_5BBB
    ret

; entry 3 of the `rst $00` table in Func_061_596F
; no direct call (reached through a table, a jump or a vector)
Func_061_596F_Case03::
Jump_061_599E:: ; address name
    call Func_061_5C07
    ret

; entry 5 of the `rst $00` table in Func_061_596F
; no direct call (reached through a table, a jump or a vector)
Func_061_596F_Case05::
Jump_061_59A2:: ; address name
    call Func_061_5A33
    ret

; entry 6 of the `rst $00` table in Func_061_596F
; no direct call (reached through a table, a jump or a vector)
Func_061_596F_Case06::
Jump_061_59A6:: ; address name
    call Func_061_59AA
    ret

; 1 call site from 1 routine (e.g. Func_061_596F_Case06)
; reads: hPlayerX, hPlayerY, wCC45, wCC43, hFF8C
; writes: wCC43, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8CA, wCC44, wCCEA, ...
; points at: wCDAD, wCE2D
Func_061_59AA::
    ldh a, [hPlayerX]
    cp a, $40
    jr z, Jump_061_59B3

Jump_061_59B0::
    ld c, $00
    ret

Jump_061_59B3::
    ldh a, [hPlayerY]
    cp a, $40
    jr nz, Jump_061_59B0
    ld a, [wCC45]
    swap a
    ld hl, wCDAD
    add_a_to_hl
    ld a, [hl]
    add a, a
    ld de, wCE2D
    add a, e
    ld e, a
    jr nc, Jump_061_59D0
    inc d

Jump_061_59D0::
    ld a, [wCC43]
    dec a
    ld [wCC43], a
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_061_59DD
    inc d

Jump_061_59DD::
    ld a, [de]
    swap a
    and a, $0F
    ld hl, Data_061_5A2D
    add_a_to_hl
    ld a, [hl]
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [hl]
    and a, $0F
    ldh [hMapScreenY], a
    ld a, $40
    ld [wC8C8], a
    ld [wC8C9], a
    xor a, a
    ld [wC8CA], a
    ld a, $85
    ld [wCC44], a
    ld a, $01
    ld [wCCEA], a
    ld a, $60
    call QueueSoundEffect
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wC8C5], a
    ldh a, [hFF8C]
    or a, $80
    ldh [hFF8C], a
    ld a, $01
    ld [wC8C6], a
    ld c, $01
    ret

Data_061_5A2D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $30, $11, $22, $03, $33

; 1 call site from 1 routine (e.g. Func_061_596F_Case05)
; reads: hPlayerX, hFF8C, hPlayerY, wCC45, wCC43, hMapScreenX, hMapScreenY, hFFC7, ...
; writes: hFF8C, hFFC6, hFFC7, wCC43, wCC44, hMapScreenX, hMapScreenY, wC8C8, ...
; points at: wCD89, wCDAC, wCE2D, wCD88
Func_061_5A33::
    ldh a, [hPlayerX]
    cp a, $40
    jr z, Jump_061_5A42

Jump_061_5A39::
    ldh a, [hFF8C]
    and a, $7F
    ldh [hFF8C], a
    ld c, $00
    ret

Jump_061_5A42::
    ldh a, [hPlayerY]
    cp a, $40
    jr nz, Jump_061_5A39
    ld a, [wCC45]
    add a, a
    add a, a
    push af
    ld hl, wCD89
    add_a_to_hl
    ld a, [hl]
    ldh [hFFC6], a
    pop af
    add a, a
    add a, a
    ld hl, wCDAC
    add_a_to_hl
    ld a, [hl+]
    ldh [hFFC7], a
    ld a, [hl]
    add a, a
    ld de, wCE2D
    add a, e
    ld e, a
    jr nc, Jump_061_5A71
    inc d

Jump_061_5A71::
    ld a, [wCC43]
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_061_5A7A
    inc d

Jump_061_5A7A::
    ldh a, [hMapScreenX]
    and a, $0F
    swap a
    ld b, a
    ldh a, [hMapScreenY]
    and a, $0F
    or a, b
    ld b, a
    ld a, [de]
    and a, $0F
    cp a, $0F
    jp z, Jump_061_5A9B
    ld hl, Data_061_5BB5
    add_a_to_hl
    ld a, [hl]
    cp a, b
    jr z, Jump_061_5AB5

Jump_061_5A9B::
    ld a, [de]
    swap a
    and a, $0F
    ld hl, Data_061_5BB5
    add_a_to_hl
    ld a, [hl]
    cp a, b
    jr z, Jump_061_5B18
    ldh a, [hFF8C]
    and a, $7F
    ldh [hFF8C], a
    ld c, $00
    ret

Jump_061_5AB5::
    ld a, [wCC43]
    or a, a
    jr nz, Jump_061_5B08
    ldh a, [hFFC6]
    cp a, $04
    jr nz, Jump_061_5B08
    ld a, [wCC45]
    add a, a
    add a, a
    ld hl, wCD88
    add_a_to_hl
    ld a, [hl]
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [hl]
    and a, $0F
    ldh [hMapScreenY], a
    ld a, $40
    ld [wC8C8], a
    ld [wC8C9], a
    ld a, $F0
    ld [wC8CA], a
    ld a, $60
    call QueueSoundEffect
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wC8C5], a
    ldh a, [hFF8C]
    or a, $80
    ldh [hFF8C], a
    ld a, $01
    ld [wC8C6], a
    ld c, $01
    ret

Jump_061_5B08::
    ld a, [wCC43]
    dec a
    ld [wCC43], a
    dec de
    dec de
    ld a, [de]
    swap a
    and a, $0F
    jr Jump_061_5B6B

Jump_061_5B18::
    ld a, [wCC43]
    inc a
    ld [wCC43], a
    inc a
    ld c, a
    ldh a, [hFFC7]
    cp a, c
    jr nz, Jump_061_5B66
    ld a, $86
    ld [wCC44], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wC8C8], a
    ld [wC8C9], a
    xor a, a
    ld [wC8CA], a
    ld a, $60
    call QueueSoundEffect
    ld a, $01
    ld [wCCEA], a
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wC8C5], a
    xor a, a
    ld [wC8C7], a
    ldh a, [hFF8C]
    or a, $80
    ldh [hFF8C], a
    ld a, $01
    ld [wC8C6], a
    ld c, $01
    ret

Jump_061_5B66::
    inc de
    inc de
    ld a, [de]
    and a, $0F

Jump_061_5B6B::
    ld hl, Data_061_5BB5
    add_a_to_hl
    ld a, [hl]
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [hl]
    and a, $0F
    ldh [hMapScreenY], a
    ld a, $40
    ld [wC8C8], a
    ld [wC8C9], a
    xor a, a
    ld [wC8CA], a
    ld a, $60
    call QueueSoundEffect
    ld a, $01
    ld [wCCEA], a
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wC8C5], a
    ldh a, [hFF8C]
    or a, $80
    ldh [hFF8C], a
    ld a, $01
    ld [wC8C6], a
    xor a, a
    ld [wC8C7], a
    ld c, $01
    ret

Data_061_5BB5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $30, $11, $22, $03, $33

; 1 call site from 1 routine (e.g. Func_061_596F_Case02)
; reads: hPlayerX, hPlayerY, wC955, wCC45, hFF8C
; writes: wC955, wCC45, wC8C8, wC8C9, wC8CA, wC914, wModeState, wC46B, ...
Func_061_5BBB::
    ldh a, [hPlayerX]
    cp a, $40
    jr z, Jump_061_5BC4

Jump_061_5BC1::
    ld c, $00
    ret

Jump_061_5BC4::
    ldh a, [hPlayerY]
    cp a, $30
    jr nz, Jump_061_5BC1
    ld a, [wC955]
    or a, a
    jr z, Jump_061_5BC1
    xor a, a
    ld [wC955], a
    ld a, [wCC45]
    add a, $80
    ld [wCC45], a
    ld a, $40
    ld [wC8C8], a
    ld a, $30
    ld [wC8C9], a
    ld a, $FF
    ld [wC8CA], a
    xor a, a
    ld [wC914], a
    ld a, $06
    ld [wModeState], a
    xor a, a
    ld [wC46B], a
    ld [wC46C], a
    ldh a, [hFF8C]
    or a, $80
    ldh [hFF8C], a
    ld a, $01
    ld [wC8C6], a
    ret

; 1 call site from 1 routine (e.g. Func_061_596F_Case03)
; reads: wCC45, hFF8C, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY
; writes: hFF8C, wC8CA, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wCC44, wModeState, ...
; points at: wCDAC
Func_061_5C07::
    ld a, [wCC45]
    swap a
    ld hl, wCDAC
    add_a_to_hl
    ld a, [hl]
    and a, $7F
    ld l, a
    ld h, $00
    sla l
    rl h
    ld de, Data_061_6566
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a

Jump_061_5C26::
    push de
    ld a, [de]
    inc de
    cp a, $80
    jr nz, Jump_061_5C37
    pop de
    ldh a, [hFF8C]
    and a, $7F
    ldh [hFF8C], a
    ld c, $00
    ret

Jump_061_5C37::
    cp a, $FD
    jr z, Jump_061_5C3D
    jr Jump_061_5C73

Jump_061_5C3D::
    ld a, [de]
    inc de
    ld [wC8CA], a
    push af
    swap a
    and a, $0F
    ld c, a
    ldh a, [hMapScreenX]
    cp a, c
    jr nz, Jump_061_5C72
    pop af
    and a, $0F
    ld c, a
    ldh a, [hMapScreenY]
    cp a, c
    jr nz, Jump_061_5C73
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hPlayerX]
    cp a, c
    jr nz, Jump_061_5C73
    ld a, [de]
    inc de
    ld c, a
    ldh a, [hPlayerY]
    cp a, c
    jr nz, Jump_061_5C73
    ldh a, [hFF8C]
    bit 7, a
    jr z, Jump_061_5C70
    pop de
    ld c, $00
    ret

Jump_061_5C70::
    jr Jump_061_5C7E

Jump_061_5C72::
    pop af

Jump_061_5C73::
    pop de
    ld a, e
    add a, $09
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    jr Jump_061_5C26

Jump_061_5C7E::
    ld a, [de]
    cp a, $F2
    jr nz, Jump_061_5CCB
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wC8C8], a
    ld a, $80
    ld [wC8C9], a
    ld a, [wCC45]
    swap a
    ld hl, wCDAC
    add_a_to_hl
    ld a, [hl+]
    ld [hl-], a
    ld a, $63
    ld [hl], a
    ld a, $84
    ld [wCC44], a
    ld a, $60
    call QueueSoundEffect
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wC8C5], a
    ldh a, [hFF8C]
    or a, $80
    ldh [hFF8C], a
    ld a, $03
    ld [wC8C6], a
    pop de
    ld c, $01
    ret

Jump_061_5CCB::
    pop de
    ld c, $00
    ret

; a bare ret (E-0116)
; 1 call site from 1 routine (e.g. Func_061_596F_Case01)
ReturnStub_5CCF::
Func_061_5CCF:: ; address name
    ret

; 1 call site from 1 routine (e.g. Func_061_596F_Case00)
; reads: hFF8C, hPlayerX, hPlayerY, hMapScreenX, hMapScreenY, hFFC8, hFFC7
; writes: hFFC7, hFF8C, hFFC8, wCC45, wCC44, hMapScreenX, hMapScreenY, wC8C8, ...
; points at: wCD8B, wCDAC, wCDAD, wCE2D
Func_061_5CD0::
    ld hl, wCD8B
    xor a, a
    ldh [hFFC7], a

Jump_061_5CD6::
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_061_5CE6
    ldh a, [hFF8C]
    and a, $5F
    ldh [hFF8C], a
    xor a, a
    ret

Jump_061_5CE3::
    pop hl
    xor a, a
    ret

Jump_061_5CE6::
    push hl
    dec hl
    dec hl
    ld a, [hl]
    ldh [hFFC8], a
    cp a, $04
    jr z, Jump_061_5D11
    cp a, $05
    jr z, Jump_061_5D11
    ldh a, [hPlayerX]
    swap a
    and a, $0F
    cp a, $04
    jr z, Jump_061_5D02
    cp a, $05
    jr nz, Jump_061_5D0E

Jump_061_5D02::
    ldh a, [hPlayerY]
    swap a
    and a, $0F
    cp a, $04
    jr nz, Jump_061_5D0E
    jr Jump_061_5D25

Jump_061_5D0E::
    jp Jump_061_5E7A

Jump_061_5D11::
    ldh a, [hPlayerX]
    swap a
    and a, $0F
    cp a, $04
    jr nz, Jump_061_5D0E
    ldh a, [hPlayerY]
    swap a
    and a, $0F
    cp a, $04
    jr nz, Jump_061_5D0E

Jump_061_5D25::
    dec hl
    ld a, [hl]
    swap a
    and a, $0F
    ld b, a
    ld a, [hl]
    and a, $0F
    ld c, a
    ldh a, [hMapScreenX]
    cp a, b
    jp nz, Jump_061_5E7A
    ldh a, [hMapScreenY]
    cp a, c
    jp nz, Jump_061_5E7A
    ldh a, [hFF8C]
    bit 7, a
    jr nz, Jump_061_5CE3
    ldh a, [hFFC8]
    cp a, $04
    jp z, Jump_061_5E02
    cp a, $05
    jp z, Jump_061_5DE1
    ldh a, [hFFC7]
    ld [wCC45], a
    ld a, $83
    ld [wCC44], a
    ldh a, [hFFC7]
    swap a
    ld hl, wCDAC
    add_a_to_hl
    ld a, [hl]
    and a, $7F
    ld e, a
    ld d, $00
    sla e
    rl d
    ld a, e
    add a, $D8
    ld e, a
    ld a, d
    adc a, $60
    ld d, a
    ld b, $61
    call ReadByteInBank
    ld l, c
    inc de
    call ReadByteInBank
    ld h, c
    ld a, $0C
    add_a_to_hl
    ldh a, [hPlayerX]
    cp a, $40
    jr z, Jump_061_5D92
    inc hl
    inc hl
    inc hl
    inc hl

Jump_061_5D92::
    ld e, l
    ld d, h
    call ReadByteInBank
    ld a, c
    ldh [hMapScreenX], a
    inc de
    call ReadByteInBank
    ld a, c
    ldh [hMapScreenY], a
    inc de
    call ReadByteInBank
    ld a, c
    ld [wC8C8], a
    inc de
    call ReadByteInBank
    ld a, c
    ld [wC8C9], a
    xor a, a
    ld [wC8CA], a
    ld a, $60
    call QueueSoundEffect
    xor a, a
    ld [wC8C7], a
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wC8C5], a
    ldh a, [hFF8C]
    or a, $80
    ldh [hFF8C], a
    ld a, $03
    ld [wC8C6], a
    farcall Func_012_7B9F
    pop hl
    ld a, $01
    ret

Jump_061_5DE1::
    xor a, a
    ld [wCC43], a
    ld a, $01
    ldh [hMapScreenX], a
    ld a, $03
    ldh [hMapScreenY], a
    ld a, $40
    ld [wC8C8], a
    ld a, $80
    ld [wC8C9], a
    xor a, a
    ld [wC8CA], a
    ld a, $03
    ld [wC8C6], a
    jr Jump_061_5E44

Jump_061_5E02::
    xor a, a
    ld [wCC43], a
    ldh a, [hFFC7]
    swap a
    ld hl, wCDAD
    add_a_to_hl
    ld a, [hl]
    add a, a
    ld hl, wCE2D
    add_a_to_hl
    ld a, [hl]
    and a, $0F
    ld hl, Data_061_5E87
    add_a_to_hl
    ld a, [hl]
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [hl]
    and a, $0F
    ldh [hMapScreenY], a
    ld a, $40
    ld [wC8C8], a
    ld [wC8C9], a
    xor a, a
    ld [wC8CA], a
    ld a, $01
    ld [wC8C6], a

Jump_061_5E44::
    ldh a, [hFFC7]
    ld [wCC45], a
    ld a, $85
    ld [wCC44], a
    ld a, $01
    ld [wCCEA], a
    ld a, $60
    call QueueSoundEffect
    xor a, a
    ld [wC8C7], a
    ld a, $04
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wC8C5], a
    ldh a, [hFF8C]
    or a, $80
    ldh [hFF8C], a
    farcall Func_012_7B9F
    pop hl
    ld a, $01
    ret

Jump_061_5E7A::
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    ldh a, [hFFC7]
    inc a
    ldh [hFFC7], a
    jp Jump_061_5CD6

Data_061_5E87:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $30, $11, $22, $03, $33

; 1 call site from 1 routine (e.g. Func_061_596F_Case00)
; reads: wC88E, wC891, wCC42, hMapScreenX, hMapScreenY, wC890, hPlayerX, hPlayerY, ...
; writes: wC8C7, wC8C5, wModeState, hFF8C, wCC44, hMapScreenX, hMapScreenY, wC8C8, ...
Func_061_5E8D::
    ld a, [wC88E]
    or a, a
    jr z, Jump_061_5ECF
    ld a, [wC891]
    bit 7, a
    jr z, Jump_061_5ECF
    and a, $7F
    ld c, a
    ld a, [wCC42]
    cp a, c
    jr nz, Jump_061_5ECF
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or a, c
    ld c, a
    ld a, [wC890]
    cp a, c
    jr nz, Jump_061_5EC7
    ldh a, [hPlayerX]
    and a, $F0
    ld c, a
    ldh a, [hPlayerY]
    and a, $F0
    swap a
    or a, c
    ld c, a
    ld a, [wC88F]
    cp a, c
    jr nz, Jump_061_5EC7
    jr Jump_061_5EF0

Jump_061_5EC7::
    ldh a, [hFF8C]
    and a, $DF
    ldh [hFF8C], a

Jump_061_5ECD::
    xor a, a
    ret

Jump_061_5ECF::
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or a, c
    ld c, a
    ld a, [wCD08]
    cp a, c
    jr nz, Jump_061_5EC7
    ld a, [wCD09]
    ld c, a
    ldh a, [hPlayerX]
    cp a, c
    jr nz, Jump_061_5EC7
    ld a, [wCD0A]
    ld c, a
    ldh a, [hPlayerY]
    cp a, c
    jr nz, Jump_061_5EC7

Jump_061_5EF0::
    ldh a, [hFF8C]
    bit 5, a
    jr nz, Jump_061_5ECD
    ld a, $60
    call QueueSoundEffect
    xor a, a
    ld [wC8C7], a
    ld a, $04
    call StartPaletteFade
    xor a, a
    ld [wC8C5], a
    ld a, $04
    ld [wModeState], a
    ldh a, [hFF8C]
    or a, $20
    ldh [hFF8C], a
    ld a, $87
    ld [wCC44], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wC8C8], a
    ld a, $80
    ld [wC8C9], a
    xor a, a
    ld [wC8CA], a
    ld a, $03
    ld [wC8C6], a
    farcall Func_012_7B9F
    ld a, $01
    ret

; 1 call site from 1 routine (e.g. Func_061_596F_Case00)
; reads: hPlayerX, hPlayerY, hMapScreenX, hMapScreenY, hFF8C
; writes: wC8C8, wC8C9, wC8CA, wC8C7, wC8C5, wModeState, hFF8C, wCC45, ...
; points at: wCD7B
Func_061_5F39::
    ldh a, [hPlayerX]
    ld c, a
    ldh a, [hPlayerY]
    cp a, c
    jr nz, Jump_061_5F51
    swap a
    and a, $0F
    cp a, $04
    jr nz, Jump_061_5F51
    ld hl, wCD7B

Jump_061_5F4C::
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_061_5F56

Jump_061_5F51::
    xor a, a
    ret

Jump_061_5F53::
    pop hl
    xor a, a
    ret

Jump_061_5F56::
    push hl
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    swap a
    and a, $0F
    ld b, a
    ld a, [hl]
    and a, $0F
    ld c, a
    ldh a, [hMapScreenX]
    cp a, b
    jp nz, Jump_061_5FE0
    ldh a, [hMapScreenY]
    cp a, c
    jp nz, Jump_061_5FE0
    ldh a, [hFF8C]
    bit 7, a
    jr nz, Jump_061_5F53
    ld a, $40
    ld [wC8C8], a
    ld [wC8C9], a
    xor a, a
    ld [wC8CA], a
    ld a, $60
    call QueueSoundEffect
    xor a, a
    ld [wC8C7], a
    push hl
    ld a, $04
    call StartPaletteFade
    pop hl
    xor a, a
    ld [wC8C5], a
    ld a, $04
    ld [wModeState], a
    ldh a, [hFF8C]
    or a, $80
    ldh [hFF8C], a
    inc hl
    inc hl
    ld a, [hl]
    or a, a
    jr nz, Jump_061_5FDF
    inc hl
    ld a, l
    sub a, $7B
    ld l, a
    ld a, h
    sbc a, $CD
    ld h, a
    sra h
    rr l
    sra h
    rr l
    ld a, l
    ld [wCC45], a
    ld a, $82
    ld [wCC44], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wC8C8], a
    ld a, $80
    ld [wC8C9], a
    ld a, $03
    ld [wC8C6], a
    farcall Func_012_7B9F
    pop hl
    ld a, $01
    ret

Jump_061_5FDF::
    ret

Jump_061_5FE0::
    inc hl
    ld a, [hl]
    swap a
    and a, $0F
    ld b, a
    ld a, [hl]
    and a, $0F
    ld c, a
    ldh a, [hMapScreenX]
    cp a, b
    jp nz, Jump_061_6065
    ldh a, [hMapScreenY]
    cp a, c
    jp nz, Jump_061_6065
    ldh a, [hFF8C]
    bit 7, a
    jp nz, Jump_061_5F53
    ld a, $40
    ld [wC8C8], a
    ld [wC8C9], a
    xor a, a
    ld [wC8CA], a
    ld a, $60
    call QueueSoundEffect
    push hl
    ld a, $04
    call StartPaletteFade
    pop hl
    xor a, a
    ld [wC8C5], a
    ld a, $04
    ld [wModeState], a
    ldh a, [hFF8C]
    or a, $80
    ldh [hFF8C], a
    inc hl
    ld a, [hl]
    or a, a
    jr nz, Jump_061_6064
    inc hl
    ld a, l
    sub a, $7B
    ld l, a
    ld a, h
    sbc a, $CD
    ld h, a
    sra h
    rr l
    sra h
    rr l
    ld a, l
    or a, $80
    ld [wCC45], a
    ld a, $82
    ld [wCC44], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wC8C8], a
    ld a, $80
    ld [wC8C9], a
    ld a, $03
    ld [wC8C6], a
    farcall Func_012_7B9F
    pop hl
    ld a, $01
    ret

Jump_061_6064::
    ret

Jump_061_6065::
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jp Jump_061_5F4C

; 1 call site from 1 routine (e.g. Func_016_5D13_Case00)
; reads: wCD07, wCC44, wCC45, hMapScreenY, hMapScreenX
; writes: hFFC6
; points at: wCD88, wCD74, wCE7E
Func_061_606D::
    ld a, [wCD07]
    bit 7, a
    jr z, Jump_061_6079
    ld a, $01
    ldh [hFFC6], a
    ret

Jump_061_6079::
    push hl
    push de
    ld a, [wCC44]
    cp a, $80
    jr z, Jump_061_60AC
    cp a, $85
    jr z, Jump_061_608A
    xor a, a
    ldh [hFFC6], a
    ret

Jump_061_608A::
    ld a, [wCC45]
    add a, a
    add a, a
    ld de, wCD88
    add a, e
    ld e, a
    jr nc, Jump_061_6097
    inc d

Jump_061_6097::
    ld a, [de]
    and a, $0F
    srl a
    srl a
    add a, a
    ld l, a
    ld a, [de]
    swap a
    and a, $0F
    srl a
    srl a
    add a, l
    jr Jump_061_60BB

Jump_061_60AC::
    ldh a, [hMapScreenY]
    srl a
    srl a
    add a, a
    ld l, a
    ldh a, [hMapScreenX]
    srl a
    srl a
    add a, l

Jump_061_60BB::
    ld hl, wCD74
    add_a_to_hl
    ld a, [hl]
    and a, $F0
    swap a
    add a, a
    add a, a
    ld hl, wCE7E
    add_a_to_hl
    ld a, [hl]
    ldh [hFFC6], a
    pop de
    pop hl
    ret
    db $D8, $61, $F2, $61, $0C, $62, $26, $62, $40, $62, $5A, $62
    ds $34, $00
    dw Data_061_6274
    dw Data_061_628E
    dw Data_061_62A8
    dw Data_061_62C2
    dw Data_061_62DC
    dw Data_061_62F6
    dw Data_061_6310
    dw Data_061_632A
    dw Data_061_6344
    dw Data_061_635E
    ds $2C, $00
    dw Data_061_6378
    dw Data_061_6392
    dw Data_061_63AC
    dw Data_061_63C6
    dw Data_061_63E0
    dw Data_061_63FA
    dw Data_061_6414
    dw Data_061_642E
    dw Data_061_6448
    dw Data_061_6462
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $7C, $64, $96, $64
    db $B0, $64, $CA, $64, $E4, $64
    ds $18, $00
    db $FE, $64, $18, $65, $32, $65, $4C, $65, $4C, $65, $4C, $65
    ds $32, $00
    INCBIN "dwm2-cobi-us.gbc", $1861D8, $73

Data_061_624B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $01, $40, $80

Data_061_6250:: ; heuristic: target of a monotone pointer table; C0
    db $00, $01, $40, $80, $80, $63, $6A, $86, $63, $6A, $40, $66, $6A, $B2, $6A, $6A
    db $01, $02, $4F, $4C, $00, $00, $00, $01, $40, $80, $00, $01, $40, $80, $F2, $6A
    db $6A, $F8, $6A, $6A

Data_061_6274:: ; heuristic: target of a monotone pointer table; C0
    db $01, $40, $6B, $4B, $43, $6B, $02, $02, $4F, $00, $00, $00, $00, $01, $40, $80
    db $00, $01, $40, $80, $8B, $43, $6B, $97, $43, $6B

Data_061_628E:: ; heuristic: target of a monotone pointer table; C0
    db $67, $48, $6B, $36, $4D, $6B, $02, $02, $4F, $00, $00, $00, $00, $01, $40, $80
    db $00, $01, $40, $80, $76, $4D, $6B, $82, $4D, $6B

Data_061_62A8:: ; heuristic: target of a monotone pointer table; C0
    db $83, $52, $6B, $40, $57, $6B, $02, $02, $4F, $00, $01, $00, $00, $01, $40, $80
    db $00, $01, $40, $80, $80, $57, $6B, $8C, $57, $6B

Data_061_62C2:: ; heuristic: target of a monotone pointer table; C0
    db $75, $5C, $6B, $CF, $60, $6B, $02, $02, $4F, $00, $00, $00, $00, $01, $40, $80
    db $00, $01, $40, $80, $0F, $61, $6B, $1B, $61, $6B

Data_061_62DC:: ; heuristic: target of a monotone pointer table; C0
    db $24, $66, $6B, $02, $6A, $6B, $02, $02, $4F, $00, $00, $00, $00, $01, $40, $80
    db $00, $01, $40, $80, $42, $6A, $6B, $4E, $6A, $6B

Data_061_62F6:: ; heuristic: target of a monotone pointer table; C0
    db $67, $6F, $6B, $DE, $73, $6B, $02, $02, $4F, $00, $00, $00, $00, $01, $40, $80
    db $00, $01, $40, $80, $1E, $74, $6B, $2A, $74, $6B

Data_061_6310:: ; heuristic: target of a monotone pointer table; C0
    db $12, $4A, $94, $F4, $4E, $94, $02, $02, $4F, $00, $00, $00, $00, $01, $40, $80
    db $00, $01, $40, $80, $44, $7A, $6B, $50, $7A, $6B

Data_061_632A:: ; heuristic: target of a monotone pointer table; C0
    db $34, $4F, $94, $89, $54, $94, $02, $02, $4F, $00, $00, $00, $00, $01, $40, $80
    db $00, $01, $40, $80, $C9, $54, $94, $D5, $54, $94

Data_061_6344:: ; heuristic: target of a monotone pointer table; C0
    db $90, $5A, $94, $2F, $5F, $94, $02, $02

Data_061_634C:: ; heuristic: target of a monotone pointer table; C0
    db $4F, $00, $00, $00, $00

Data_061_6351:: ; heuristic: target of a monotone pointer table; C0
    db $01, $40, $80, $00, $01, $40, $80, $6F, $5F, $94, $7B, $5F, $94

Data_061_635E:: ; heuristic: target of a monotone pointer table; C0
    db $98, $64, $94, $74, $69, $94, $02, $02, $4F, $00, $00, $00, $00, $01, $40, $80
    db $00, $01, $40, $80, $B4, $69, $94, $C0, $69, $94

Data_061_6378:: ; heuristic: target of a monotone pointer table; C0
    db $01, $40, $6C, $89, $42, $6C, $02, $01, $3F, $00, $00, $00, $00, $00, $40, $80
    db $00, $00, $40, $80, $C9, $42, $6C, $CF, $42, $6C

Data_061_6392:: ; heuristic: target of a monotone pointer table; C0
    db $3C, $45, $6C, $ED, $47, $6C, $02, $01, $3F, $00, $00, $00, $00, $00, $40, $80
    db $00, $00, $40, $80, $2D, $48, $6C, $33, $48, $6C

Data_061_63AC:: ; heuristic: target of a monotone pointer table; C0
    db $F6, $4A, $6C, $6C, $4E, $6C, $02, $01, $3F, $00, $00, $00, $00, $00, $40, $80
    db $00, $00, $40, $80, $AC, $4E, $6C, $B2, $4E, $6C

Data_061_63C6:: ; heuristic: target of a monotone pointer table; C0
    db $94, $51, $6C, $81, $54, $6C, $02, $01, $3F, $00, $00, $00, $00, $00, $40, $80
    db $00, $00, $40, $80, $C1, $54, $6C, $C7, $54, $6C

Data_061_63E0:: ; heuristic: target of a monotone pointer table; C0
    db $95, $57, $6C, $83, $5A, $6C, $02, $01, $3F, $00, $00, $00, $00, $00, $40, $80
    db $00, $00, $40, $80, $C3, $5A, $6C, $C9, $5A, $6C

Data_061_63FA:: ; heuristic: target of a monotone pointer table; C0
    db $73, $5D, $6C, $AF, $60, $6C, $02, $01, $3F, $00, $00, $00, $00, $00, $40, $80
    db $00, $00, $40, $80, $EF, $60, $6C, $F5, $60, $6C

Data_061_6414:: ; heuristic: target of a monotone pointer table; C0
    db $E4, $63, $6C, $59, $67, $6C, $02, $01, $3F, $00, $00, $00, $00, $00, $40, $80
    db $00, $00, $40, $80, $99, $67, $6C, $9F, $67, $6C

Data_061_642E:: ; heuristic: target of a monotone pointer table; C0
    db $E8, $6E, $94, $CF, $71, $94, $02, $01, $3F, $00, $00, $00, $00, $00, $40, $80
    db $00, $00, $40, $80, $22, $6A, $6C, $28, $6A, $6C

Data_061_6448:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $72, $94, $7D

Data_061_644C:: ; heuristic: target of a monotone pointer table; C0
    db $74, $94, $02, $01

Data_061_6450:: ; heuristic: target of a monotone pointer table; C0
    db $3F, $00, $01, $00, $00, $00, $40, $80, $00, $00, $40, $80, $BD, $74, $94, $C3
    db $74, $94

Data_061_6462:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $186462, $E5

Data_061_6547:: ; heuristic: target of a monotone pointer table; C0
    db $78, $6A, $BE, $78, $6A

Data_061_654C:: ; heuristic: target of a monotone pointer table; C0
    db $08, $4B, $90, $FE, $4E, $90, $01, $01, $32, $2C, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $3E, $4F, $90, $41, $4F, $90

Data_061_6566:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $67, $66, $67, $66, $67, $66, $67, $66, $67, $66, $67
    ds $35, $66
    db $71, $66, $71, $66, $71, $66, $71, $66, $71, $66, $71, $66, $71, $66, $71, $66
    db $71, $66, $71
    ds $2D, $66
    db $C3, $66, $C3, $66, $C3, $66, $C3, $66, $C3, $66, $C3, $66, $C3, $66, $C3, $66
    db $C3, $66, $C3
    ds $15, $66
    db $FA
    ds $1D, $66
    db $04, $67
    ds $38, $66
    INCBIN "dwm2-cobi-us.gbc", $186666, $AA

; LZSS-compressed asset: 607 bytes expand to 1543 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_061_6710:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $186710, $1B5
    ds $10, $FE
    INCBIN "dwm2-cobi-us.gbc", $1868D5, $9A

; LZSS-compressed asset: 166 bytes expand to 771 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_061_696F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $03, $03, $07, $02, $08, $06, $01, $06, $03, $03, $04, $07, $07, $02
    ds $10, $FE
    INCBIN "dwm2-cobi-us.gbc", $18698D, $88

; LZSS-compressed asset: 1089 bytes expand to 1795 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_061_6A15:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $186A15, $58
    ds $10, $FE
    INCBIN "dwm2-cobi-us.gbc", $186A7D, $48
    ds $10, $FE
    db $04, $02, $07, $01, $04, $02, $07, $01, $03, $02, $07, $01, $03, $02, $07, $01
    db $02, $06, $04, $04, $05, $05, $08, $03, $02, $03, $04, $01, $07, $02, $FF, $FF
    db $01, $04, $03, $03, $05, $02, $FF, $FF
    ds $28, $FE
    db $06, $07, $07, $06, $06, $07, $07, $06, $02, $03, $03, $06, $05, $01, $07, $05
    ds $50, $FE
    db $04, $04, $05, $06, $06, $02, $07, $05, $02, $02, $02, $06, $04, $04, $08, $03
    db $02, $03, $03, $07, $05, $04, $07, $06, $02, $04, $04, $03, $05, $05, $07, $06
    ds $40, $FE
    db $05, $04, $06, $03, $07, $02, $07, $06, $02, $06, $04, $03, $07, $02, $07, $05
    db $02, $05, $03, $02, $06, $06, $07, $01, $02, $05, $03, $06, $05, $03, $07, $02
    db $02, $05, $03, $02, $07, $01, $07, $06, $01, $02, $03, $06, $05, $04, $07, $03
    db $02, $05, $04, $03, $05, $02, $07, $06
    ds $30, $FE
    db $02, $06, $03, $03, $03, $07, $07, $04, $03, $05, $05, $02, $06, $03, $07, $06
    db $02, $03, $07, $02, $07, $05, $FF, $FF, $01, $07, $03, $04, $05, $01, $07, $03
    db $02, $03, $04, $04, $06, $05, $07, $02, $02, $03, $03, $06, $05, $05, $07, $02
    db $02, $05, $02, $07, $03, $03, $05, $06
    ds $28, $FE
    db $03, $06, $06, $04, $06, $07, $07, $05, $02, $01, $02, $04, $04, $03, $FF, $FF
    db $02, $06, $06, $04, $07, $05, $FF, $FF, $02, $03, $06, $06, $07, $04, $08, $02
    db $02, $07, $03, $02, $04, $05, $06, $03, $04, $02, $05, $06, $07, $03, $07, $05
    db $02, $02, $02, $05, $07, $03, $07, $06
    ds $20, $FE
    db $02, $03, $03, $02, $04, $05, $07, $04, $02, $02, $03, $01, $06, $03, $07, $05
    db $02, $03, $02, $06, $06, $02, $FF, $FF, $02, $01, $02, $05, $07, $02, $FF, $FF
    db $06, $03, $07, $02, $06, $03, $07, $02, $01, $02, $02, $01, $01, $02, $02, $01
    db $03, $06, $06, $01, $06, $07, $07, $02, $02, $01, $04

Data_061_6D40:: ; heuristic: target of a monotone pointer table; C0
    db $02, $02, $01

Data_061_6D43:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $04, $05, $06, $06, $07, $04
    db $FF, $FF, $02

Data_061_6D56:: ; heuristic: target of a monotone pointer table; C0
    db $03, $03, $06

Data_061_6D59:: ; heuristic: target of a monotone pointer table; C0
    db $05, $05, $07, $04, $02, $05, $04, $06, $06, $03, $07, $04, $02, $03, $04, $06
    db $07, $02, $08

Data_061_6D6C:: ; heuristic: target of a monotone pointer table; C0
    db $05, $02, $05, $03

Data_061_6D70:: ; heuristic: target of a monotone pointer table; C0
    db $02, $06, $03, $06, $06, $01, $02, $02, $04, $03, $06, $FF, $FF
    ds $10, $FE
    INCBIN "dwm2-cobi-us.gbc", $186D8D, $70
    ds $18, $FE
    db $05, $02, $06, $06, $07, $04, $08, $01, $02, $03, $04, $06, $05, $02, $07, $04
    db $02, $03, $02, $05, $03, $02, $03, $06
    ds $10, $FE
    db $07, $07, $08, $06, $07, $07, $08, $06, $01, $06, $02

Data_061_6E48:: ; heuristic: target of a monotone pointer table; C0
    db $07, $01, $06, $02

Data_061_6E4C:: ; heuristic: target of a monotone pointer table; C0
    db $07, $05, $06, $06, $02, $08, $05, $FF, $FF, $02

; LZSS-compressed asset: 341 bytes expand to 774 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_061_6E56:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $06, $03, $03, $04, $05, $FF, $FF, $FE

Data_061_6E5E:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $FE, $FE, $FE

Data_061_6E62:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $03, $07, $05, $06, $07
    db $05, $FF

Data_061_6E74:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $02, $05

Data_061_6E77:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $186E77, $C6
    ds $13, $FE

Data_061_6F50:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $FE

Data_061_6F52:: ; heuristic: target of a monotone pointer table; C0
    ds $11, $FE

Data_061_6F63:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $FE, $FE

Data_061_6F66:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $186F66, $45

; LZSS-compressed asset: 1130 bytes expand to 1287 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_061_6FAB:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $07, $05, $01, $05, $02, $06, $06, $07, $FF, $FF
    ds $38, $FE
    db $03, $02, $03, $05, $05, $06, $07, $04, $02, $04, $03, $02, $05, $03, $FF, $FF
    db $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $02, $04, $04, $02, $04, $07, $07, $06
    db $02, $02, $02, $06, $04, $05, $06, $04, $02, $04, $02, $06, $04, $05, $FF, $FF
    ds $18, $FE
    db $05, $06, $06, $01, $07, $05, $FF, $FF, $02, $04, $02

Data_061_7040:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02

Data_061_7042:: ; heuristic: target of a monotone pointer table; C0
    db $04, $02, $06, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $04, $04, $06, $05, $04
    db $04

Data_061_7053:: ; heuristic: target of a monotone pointer table; C0
    db $06, $05, $FE

Data_061_7056:: ; heuristic: target of a monotone pointer table; C0
    db $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $05
    db $04

Data_061_7067:: ; heuristic: target of a monotone pointer table; C0
    db $06, $02, $08

Data_061_706A:: ; heuristic: target of a monotone pointer table; C0
    db $03, $FF, $FF, $02, $02, $05, $07, $06, $01, $07, $04, $02, $02, $03, $05, $07

Data_061_707A:: ; heuristic: target of a monotone pointer table; C0
    db $01, $07, $04, $02

Data_061_707E:: ; heuristic: target of a monotone pointer table; C0
    db $03, $04, $04, $05, $02, $FF, $FF
    ds $10, $FE
    db $05, $02, $06, $05, $07, $03, $FF, $FF, $02, $03, $03, $06, $05, $05, $06, $02
    ds $10, $FE
    db $03, $05, $06, $04, $07, $06, $FF, $FF, $01, $06, $03, $03, $05, $05, $06, $02
    ds $10, $FE
    INCBIN "dwm2-cobi-us.gbc", $1870D5, $E0
    ds $18, $FE
    INCBIN "dwm2-cobi-us.gbc", $1871CD, $48
    ds $20, $FE
    db $03, $03, $05, $05, $07, $07, $08, $02, $02, $03, $06, $04, $07, $06, $FF, $FF
    db $03, $05, $06, $02, $06, $06, $07, $03, $02, $04, $04, $05, $05, $02, $06, $07
    db $02, $04, $03, $05, $04, $02, $06, $02, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $FE
    db $03, $03, $05, $06, $06, $01, $06, $04, $02, $04, $03, $03, $04, $06, $FF, $FF
    ds $10, $FE
    INCBIN "dwm2-cobi-us.gbc", $187285, $50
    ds $10, $FE
    db $04, $03, $04, $07, $05, $05, $07, $02, $02, $04, $03, $02, $03, $06, $FF, $FF
    ds $10, $FE
    INCBIN "dwm2-cobi-us.gbc", $187305, $78
    ds $10, $FE
    INCBIN "dwm2-cobi-us.gbc", $18738D, $50
    ds $18, $FE
    db $05, $05, $06, $01, $07, $04, $08, $02, $02, $04, $03, $02, $04, $05, $06, $03
    db $02, $04, $03, $07, $06, $06, $07, $02, $02, $03, $05, $05, $07, $01, $08, $07
    db $02, $06, $08, $03, $02, $06, $08, $03, $02, $04, $02, $04, $02, $04, $02, $04
    ds $10, $FE
    INCBIN "dwm2-cobi-us.gbc", $187435, $C0
    ds $20, $FE
    INCBIN "dwm2-cobi-us.gbc", $187515, $108
    ds $9E3, $00
