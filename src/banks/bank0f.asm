SECTION "Bank 0F", ROMX[$4000], BANK[$0F]
    db $0F

; 1 call site from 1 routine (e.g. Func_010_4F15)
; reads: wC923
Func_00F_4001::
    ld a, [wC923]
    rst $00
    dw Jump_00F_4077
    dw Jump_00F_404D
    dw Jump_00F_402D
    dw Jump_00F_400D

Jump_00F_400D::
    ldh a, [hPlayerY]
    call Func_00F_7ED8
    ldh a, [hPlayerY]
    call Func_00F_7ED8
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $1E
    ret nz
    ldh a, [hFF8C]
    and a, $FD
    ldh [hFF8C], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00F_402D::
    ldh a, [hPlayerY]
    call Func_00F_7ED8
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    ldh a, [hPlayerY]
    call Func_00F_7ED8
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp a, $80
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_404D::
    ld a, $01
    ld [wC929], a
    ld a, $80
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ldh a, [hFF8C]
    or a, $02
    ldh [hFF8C], a
    ld a, $63
    call QueueSoundEffect
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4077::
    ld a, [wC921]
    inc a
    ld [wC921], a
    and a, $01
    ret z
    ld a, [wCB9B]
    dec a
    ld [wCB9B], a
    cp a, $30
    ret nz
    ld hl, wCB9C
    call SetBit2AtHL_B0F
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4E12)
; reads: wC923
Func_00F_409A::
    ld a, [wC923]
    rst $00
    dw Jump_00F_40A2
    dw Jump_00F_7F93

Jump_00F_40A2::
    ld a, $0A
    ld [rRAMG], a
    ld hl, wC6FE
    ld a, [wC922]
    add_a_to_hl
    push hl
    ld a, [hl]
    ld c, $0D
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    and a, $0F
    ld hl, $40DE
    add_a_to_hl
    ld a, [hl]
    ld e, a
    pop hl
    ld a, [hl]
    push de
    call PersonalityIndexOfRecord
    pop de
    add a, e
    ld l, a
    ld h, $05
    call StoreHLInWC924_B0F
    xor a, a
    ld [rRAMG], a
    ld hl, wC923
    inc [hl]
    ret
    db $94, $AF, $CA, $AF, $94, $CA, $AF, $94, $CA, $CA, $E5

; 1 call site from 1 routine (e.g. Func_010_4DFD)
; reads: wC923
Func_00F_40E9::
    ld a, [wC923]
    rst $00
    dw Jump_00F_456A
    dw Jump_00F_4532
    dw Jump_00F_44F3
    dw Jump_00F_7F89
    dw Jump_00F_44D8
    dw Jump_00F_7F89
    dw Jump_00F_44C9
    dw Jump_00F_44B1
    dw Jump_00F_4493
    dw Jump_00F_448C
    dw Jump_00F_447A
    dw Jump_00F_447A
    dw Jump_00F_7F89
    dw Jump_00F_4468
    dw Jump_00F_4468
    dw Jump_00F_7F89
    dw Jump_00F_4456
    dw Jump_00F_7F89
    dw Jump_00F_4444
    dw Jump_00F_7F89
    dw Jump_00F_4419
    dw Jump_00F_7F89
    dw Jump_00F_43EF
    dw Jump_00F_439D
    dw Jump_00F_7F89
    dw Jump_00F_438B
    dw Jump_00F_7F89
    dw Jump_00F_435F
    dw Jump_00F_42E7
    dw Jump_00F_42D5
    dw Jump_00F_42CA
    dw Jump_00F_7F89
    dw Jump_00F_42B5
    dw Jump_00F_429F
    dw Jump_00F_7F89
    dw Jump_00F_42E7
    dw Jump_00F_42D5
    dw Jump_00F_42E7
    dw Jump_00F_427A
    dw Jump_00F_4270
    dw Jump_00F_4266
    dw Jump_00F_418E
    dw Jump_00F_4171
    dw Jump_00F_414D
    dw Jump_00F_4147

Jump_00F_4147::
    ld a, $80
    ld [wC919], a
    ret

Jump_00F_414D::
    ld a, $06
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $02
    ld [wGameMode], a
    ld a, $0B
    ld [wModeState], a
    xor a, a
    ld [wC5DD], a
    xor a, a
    ld [wC0A0], a
    xor a, a
    ld [wC0A1], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4171::
    ld a, [wC921]
    ld l, a
    ld a, [wC922]
    ld h, a
    dec hl
    ld a, l
    ld [wC921], a
    ld a, h
    ld [wC922], a
    ld a, l
    or a, h
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_418E::
    xor a, a
    ld [wSpriteSlotCount], a
    xor a, a
    ld [wCBCF], a
    ld a, $E0
    ldh [hPlayerX], a
    ld [wC8F0], a
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0801
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    xor a, a
    ld [wStringCategory], a
    ld a, $FB
    ld [wStringIndex], a
    farcall ShowString_Bank28
    ld hl, wScreenTileBuffer
    ld a, $C3
    ld bc, $0168
    call FillBytes
    ld hl, wC252
    ld b, $08
    ld a, $80

Jump_00F_41D4::
    ld [hl+], a
    inc a
    dec b
    jr nz, Jump_00F_41D4
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_00F_41F1
    ld a, $02
    ldh [rSVBK], a
    ld hl, wD000
    xor a, a
    ld bc, $0168
    call FillBytes
    ld a, $00
    ldh [rSVBK], a

Jump_00F_41F1::
    ld a, [wSGBActive]
    or a, a
    jr z, Jump_00F_423E
    xor a, a
    ldh [rBGP], a
    ldh [rOBP0], a
    ldh [rOBP1], a
    ld a, [wC51F]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    ld [wC577], a
    ld a, h
    ld [wC578], a
    inc hl
    ld a, l
    ld [wC579], a
    ld a, h
    ld [wC57A], a
    inc hl
    ld a, l
    ld [wC57B], a
    ld a, h
    ld [wC57C], a
    inc hl
    ld a, l
    ld [wC57D], a
    ld a, h
    ld [wC57E], a
    call SpinDelay
    farcall Func_017_421A
    ld hl, $425E
    ld de, wC4FF
    ld bc, $0008
    call CopyBytes

Jump_00F_423E::
    farcall Func_05F_6DDB
    ld a, $FE
    call StartPaletteFade
    ld hl, $0258
    ld a, l
    ld [wC921], a
    ld a, h
    ld [wC922], a
    ld a, $01
    ld [wC837], a
    ld hl, wC923
    inc [hl]
    ret
    db $DE, $67, $1F, $33, $3C, $12, $00, $00

Jump_00F_4266::
    ld a, [wFadeState]
    or a, a
    ret nz
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4270::
    ld a, $3F
    call StartPaletteFade
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_427A::
    ld de, wCBD4
    call Func_00F_7EE9
    ld hl, wCBAC
    call SetBit1AtHL_Bank0F
    ld a, [wCBAA]
    dec a
    dec a
    ld [wCBAA], a
    cp a, $40
    ret nz
    ld a, $E0
    ld [wCB8A], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_429F::
    ld de, wC8F1
    call Func_00F_7EE9
    ret nc
    ld a, $01
    add a, $B9
    ld l, a
    ld h, $0D
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_42B5::
    ld a, [wC8F0]
    dec a
    dec a
    ld [wC8F0], a
    cp a, $78
    ret nz
    ld a, $02
    ld [wC8EF], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_42CA::
    ld hl, $0DB8
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_42D5::
    ld a, [wC921]
    ld hl, $431F
    add_a_to_hl
    ld a, [hl]
    xor a, $FF
    inc a
    ld c, a
    jr Jump_00F_42F9

Jump_00F_42E7::
    ld a, $01
    ld [wCBA6], a
    ld a, [wC921]
    ld hl, $431F
    add_a_to_hl
    ld a, [hl]
    ld c, a

Jump_00F_42F9::
    ld a, [wCBAA]
    add a, c
    ld [wCBAA], a
    ldh a, [hPlayerX]
    add a, c
    ldh [hPlayerX], a
    ld a, [wCBD3]
    add a, c
    ld [wCBD3], a
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $40
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret
    db $01, $00, $01, $00, $01, $01, $00, $FF, $01, $00, $00, $FF, $00, $FF, $FF, $00
    db $01, $00, $00, $00, $01, $01, $FF, $00, $00, $FF, $00, $00, $00, $FF, $01, $00
    db $01, $00, $01, $00, $00, $01, $01, $01, $00, $00, $FF, $00, $00, $00, $FF, $01
    db $FF, $00, $00, $01, $FF, $FF, $FF, $00, $00, $00, $FF, $00, $00, $FF, $FF, $00

Jump_00F_435F::
    ld a, [wC921]
    or a, a
    jr nz, Jump_00F_4376
    ld a, $02
    ldh [hPlayerFacing], a
    ldh a, [hPlayerY]
    dec a
    ldh [hPlayerY], a
    cp a, $30
    ret nz
    ld hl, wC921
    inc [hl]
    ret

Jump_00F_4376::
    ld a, $03
    ldh [hPlayerFacing], a
    ldh a, [hPlayerX]
    dec a
    ldh [hPlayerX], a
    cp a, $78
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_438B::
    ld de, wCBAB
    call Func_00F_7EE9
    ret nc
    ld hl, $0DB7
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_439D::
    ld a, $01
    ld [wC929], a
    ld a, [wC921]
    or a, a
    jr nz, Jump_00F_43C2
    ld a, $80
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC921
    inc [hl]
    ret

Jump_00F_43C2::
    ld a, $83
    ld [wC92A], a
    ld a, $58
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $02
    ld [wCB96], a
    xor a, a
    ld [wCBA6], a
    ld hl, $0DB6
    call StoreHLInWC924_B0F
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_43EF::
    ld a, $01
    ld [wCB96], a
    ld [wCBA6], a
    ld de, wCBAB
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld de, wCB9B
    call Func_00F_7EE9
    ret nc
    ld a, $03
    ld [wCB96], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4419::
    ld hl, wCB9C
    call ClearBit2AtHL_Bank0F
    ld hl, wCBAC
    call ClearBit2AtHL_Bank0F
    ld a, $80
    ld [wC928], a
    farcall Func_05F_6B17
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $01
    add a, $B4
    ld l, a
    ld h, $0D
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4444::
    ld de, wCBAB
    call Func_00F_7EE9
    ret nc
    ld hl, $0DB3
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4456::
    ld de, wCB9B
    call Func_00F_7EE9
    ret nc
    ld hl, $0DB2
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4468::
    ld de, wCBAB
    call Func_00F_7EE9
    ret nc
    ld hl, $0DB1
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_447A::
    ld de, wCB9B
    call Func_00F_7EE9
    ret nc
    ld hl, $0DB0
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_448C::
    farcall Func_073_734D
    ret

Jump_00F_4493::
    ld a, $01
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $68
    ld [wCBD3], a
    ld a, $30
    ld [wCBD4], a
    ld a, $80
    ld [wCBCF], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_44B1::
    ld a, $10
    call StartPaletteFade
    ld a, $00
    ld [wGameMode], a
    ld a, $08
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_44C9::
    ld a, $01
    ldh [hPlayerFacing], a
    ld b, $78
    call StepWC921Counter_Bank0F
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_44D8::
    ld a, $80
    ld [wCBCF], a
    ld hl, wCBD4
    dec [hl]
    ld de, wCBD4
    call Func_00F_7EE9
    ret nc
    ld hl, $0549
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_44F3::
    ld a, $03
    ldh [hPlayerFacing], a
    ld de, hPlayerY
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld de, wCBAB
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $20
    ret nz
    ld hl, $0548
    call StoreHLInWC924_B0F
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4532::
    ld de, $0018
    ld a, [wC921]
    ld l, a
    ld a, [wC922]
    ld h, a
    add hl, de
    ld a, l
    ld [wC921], a
    ld a, h
    ld [wC922], a
    ld c, h
    ld a, [wCBBB]
    add a, c
    ld [wCBBB], a
    ld a, [wCBBA]
    inc a
    inc a
    ld [wCBBA], a
    cp a, $40
    ret nz
    ld a, $40
    ld [wCBBB], a
    xor a, a
    ld [wC921], a
    ld [wC922], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_456A::
    ld a, $13
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $40
    ld [wCBD3], a
    ld [wCBD4], a
    ld hl, $FE80
    ld a, l
    ld [wC921], a
    ld a, h
    ld [wC922], a
    ld a, $65
    call QueueSoundEffect
    ld a, $0E
    ldh [hFF8D], a
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4DF6)
; reads: wC923
Func_00F_4595::
    ld a, [wC923]
    rst $00
    dw Jump_00F_5175
    dw Jump_00F_516A
    dw Jump_00F_512E
    dw Jump_00F_5122
    dw Jump_00F_516A
    dw Jump_00F_516A
    dw Jump_00F_511E
    dw Jump_00F_5113
    dw Jump_00F_7F89
    dw Jump_00F_5108
    dw Jump_00F_7F89
    dw Jump_00F_50D9
    dw Jump_00F_50D2
    dw Jump_00F_50BE
    dw Jump_00F_516A
    dw Jump_00F_50B8
    dw Jump_00F_50A9
    dw Jump_00F_7F89
    dw Jump_00F_516A
    dw Jump_00F_5097
    dw Jump_00F_516A
    dw Jump_00F_516A
    dw Jump_00F_5087
    dw Jump_00F_7F89
    dw Jump_00F_507C
    dw Jump_00F_50A0
    dw Jump_00F_505D
    dw Jump_00F_503E
    dw Jump_00F_505D
    dw Jump_00F_503E
    dw Jump_00F_505D
    dw Jump_00F_503E
    dw Jump_00F_505D
    dw Jump_00F_5020
    dw Jump_00F_7F89
    dw Jump_00F_4FF1
    dw Jump_00F_516A
    dw Jump_00F_4FCF
    dw Jump_00F_7F89
    dw Jump_00F_516A
    dw Jump_00F_5217
    dw Jump_00F_4FBB
    dw Jump_00F_7F89
    dw Jump_00F_5217
    dw Jump_00F_4F93
    dw Jump_00F_4F72
    dw Jump_00F_4F54
    dw Jump_00F_4F2D
    dw Jump_00F_516A
    dw Jump_00F_4F06
    dw Jump_00F_516A
    dw Jump_00F_516A
    dw Jump_00F_4EF7
    dw Jump_00F_4EDA
    dw Jump_00F_4ECA
    dw Jump_00F_4EA6
    dw Jump_00F_4E91
    dw Jump_00F_4E70
    dw Jump_00F_4E3D
    dw Jump_00F_4E31
    dw Jump_00F_4E15
    dw Jump_00F_516A
    dw Jump_00F_4F06
    dw Jump_00F_516A
    dw Jump_00F_516A
    dw Jump_00F_4E08
    dw Jump_00F_4DE7
    dw Jump_00F_4D87
    dw Jump_00F_516A
    dw Jump_00F_4D7B
    dw Jump_00F_4D7B
    dw Jump_00F_516A
    dw Jump_00F_4D1B
    dw Jump_00F_516A
    dw Jump_00F_4C56
    dw Jump_00F_4C4A
    dw Jump_00F_516A
    dw Jump_00F_4F06
    dw Jump_00F_516A
    dw Jump_00F_516A
    dw Jump_00F_4C3D
    dw Jump_00F_4C20
    dw Jump_00F_516A
    dw Jump_00F_4BEE
    dw Jump_00F_4BB6
    dw Jump_00F_4B8F
    dw Jump_00F_4B45
    dw Jump_00F_516A
    dw Jump_00F_4F06
    dw Jump_00F_516A
    dw Jump_00F_516A
    dw Jump_00F_4B38
    dw Jump_00F_4B1B
    dw Jump_00F_516A
    dw Jump_00F_516A
    dw Jump_00F_4AE3
    dw Jump_00F_4AD7
    dw Jump_00F_516A
    dw Jump_00F_4AB3
    dw Jump_00F_4A74
    dw Jump_00F_516A
    dw Jump_00F_4A09
    dw Jump_00F_49D5
    dw Jump_00F_516A
    dw Jump_00F_499C
    dw Jump_00F_516A
    dw Jump_00F_4F06
    dw Jump_00F_516A
    dw Jump_00F_516A
    dw Jump_00F_4985
    dw Jump_00F_4968
    dw Jump_00F_516A
    dw Jump_00F_4949
    dw Jump_00F_490E
    dw Jump_00F_516A
    dw Jump_00F_48EA
    dw Jump_00F_516A
    dw Jump_00F_48DE
    dw Jump_00F_48B7
    dw Jump_00F_516A
    dw Jump_00F_487C
    dw Jump_00F_485D
    dw Jump_00F_516A
    dw Jump_00F_4F06
    dw Jump_00F_516A
    dw Jump_00F_516A
    dw Jump_00F_4846
    dw Jump_00F_4829
    db $6A, $51
    dw Func_00F_47F5
    dw Func_00F_47BC
    dw Func_00F_47A8
    dw Func_00F_4774
    INCBIN "dwm2-cobi-us.gbc", $03C6A3, $D1

; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC928, wC92A
; points at: wC923
Func_00F_4774:: ; heuristic: target of a pointer table; C0
    ld a, $02
    ld [wC929], a
    ld a, $B0
    ld [wC928], a
    ld a, $81
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, $03
    ld [wC929], a
    ld a, $C0
    ld [wC928], a
    ld a, $81
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC923
    inc [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wCBAB
; writes: wCBBB
; points at: wCBAB, wC923
Func_00F_47A8:: ; heuristic: target of a pointer table; C0
    ld de, wCBAB
    call Func_00F_7EE9
    push af
    ld a, [wCBAB]
    ld [wCBBB], a
    pop af
    ret nc
    ld hl, wC923
    inc [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC921
; writes: wCB9B
; points at: wC923
Func_00F_47BC:: ; heuristic: target of a pointer table; C0
    ld a, [wC921]
    cp a, $1E
    jr nc, Jump_00F_47C9
    bit 1, a
    jr z, Jump_00F_47D9
    jr Jump_00F_47E0

Jump_00F_47C9::
    cp a, $3C
    jr nc, Jump_00F_47D3
    bit 2, a
    jr z, Jump_00F_47D9
    jr Jump_00F_47E0

Jump_00F_47D3::
    bit 3, a
    jr z, Jump_00F_47D9
    jr Jump_00F_47E0

Jump_00F_47D9::
    ld a, $E0
    ld [wCB9B], a
    jr Jump_00F_47E5

Jump_00F_47E0::
    ld a, $40
    ld [wCB9B], a

Jump_00F_47E5::
    ld b, $78
    call StepWC921Counter_Bank0F
    ret nc
    ld a, $40
    ld [wCB9B], a
    ld hl, wC923
    inc [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC928, wC92A
; points at: wC923
Func_00F_47F5:: ; heuristic: target of a pointer table; C0
    ld a, $02
    ld [wC929], a
    ld a, $40
    ld [wC928], a
    ld a, $03
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, $03
    ld [wC929], a
    ld a, $50
    ld [wC928], a
    ld a, $03
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4829::
    ld a, $11
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $20
    ld [wCBD3], a
    ld a, $40
    ld [wCBD4], a
    xor a, a
    ld [wCBCF], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4846::
    ld a, $71
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wCBD3], a
    ld a, $30
    ld [wCBD4], a
    call Func_00F_4FA1
    ret

Jump_00F_485D::
    ld a, $00
    ld [wC929], a
    ld a, $60
    ld [wC928], a
    ld a, $00
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_487C::
    ld a, $01
    ld [wC929], a
    ld a, $30
    ld [wC928], a
    ld a, $03
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, $02
    ld [wC929], a
    ld a, $60
    ld [wC928], a
    ld a, $01
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wCB96], a
    ld [wCBA6], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_48B7::
    ld a, $00
    ld [wC929], a
    ld a, $50
    ld [wC928], a
    ld a, $00
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $02
    ld [wCB96], a
    ld [wCBA6], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_48DE::
    ld a, $40
    ld [wC928], a
    ld a, $03
    ld [wC92A], a
    jr Jump_00F_48F4

Jump_00F_48EA::
    ld a, $50
    ld [wC928], a
    ld a, $01
    ld [wC92A], a

Jump_00F_48F4::
    ld a, $04
    ld [wC929], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $02
    ld [wCBC6], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_490E::
    ld a, $01
    ld [wC929], a
    ld a, $40
    ld [wC928], a
    ld a, $81
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, $02
    ld [wC929], a
    ld a, $50
    ld [wC928], a
    ld a, $83
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wCB96], a
    ld [wCBA6], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4949::
    ld a, $04
    ld [wC929], a
    ld a, $70
    ld [wC928], a
    ld a, $02
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4968::
    ld a, $11
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $40
    ld [wCBD3], a
    ld a, $60
    ld [wCBD4], a
    xor a, a
    ld [wCBCF], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4985::
    ld a, $60
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wCBD3], a
    ld a, $30
    ld [wCBD4], a
    call Func_00F_4FA1
    ret

Jump_00F_499C::
    ld a, [wC921]
    cp a, $1E
    jr nc, Jump_00F_49A9
    bit 1, a
    jr z, Jump_00F_49B9
    jr Jump_00F_49C0

Jump_00F_49A9::
    cp a, $3C
    jr nc, Jump_00F_49B3
    bit 2, a
    jr z, Jump_00F_49B9
    jr Jump_00F_49C0

Jump_00F_49B3::
    bit 3, a
    jr z, Jump_00F_49B9
    jr Jump_00F_49C0

Jump_00F_49B9::
    ld a, $E0
    ld [wCB8B], a
    jr Jump_00F_49C5

Jump_00F_49C0::
    ld a, $30
    ld [wCB8B], a

Jump_00F_49C5::
    ld b, $78
    call StepWC921Counter_Bank0F
    ret nc
    ld a, $30
    ld [wCB8B], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_49D5::
    ld a, $03
    ld [wC929], a
    ld a, $B0
    ld [wC928], a
    ld a, $80
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, $04
    ld [wC929], a
    ld a, $B0
    ld [wC928], a
    ld a, $80
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4A09::
    ld a, [wC921]
    or a, a
    jr nz, Jump_00F_4A42
    ld a, $02
    ld [wC929], a
    ld a, $40
    ld [wC928], a
    ld a, $83
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wCBAA]
    ld [wCB9A], a
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wCB96], a
    ld a, $01
    ld [wCBB6], a
    ld a, $03
    ld [wCBC6], a
    ld hl, wC921
    inc [hl]
    ret

Jump_00F_4A42::
    ld a, $02
    ld [wC929], a
    ld a, $C0
    ld [wC928], a
    ld a, $80
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wCBAB]
    sub a, $08
    ld [wCB9B], a
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wCBB6], a
    ld [wCBC6], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4A74::
    ld a, [wC921]
    and a, $03
    jr nz, Jump_00F_4A7F
    ld hl, wCB9B
    dec [hl]

Jump_00F_4A7F::
    ld a, [wC921]
    and a, $01
    jr nz, Jump_00F_4A8A
    ld hl, wCB9A
    inc [hl]

Jump_00F_4A8A::
    ld de, wCB9B
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $20
    ret nz
    ld a, $03
    ld [wCB96], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4AB3::
    ld a, $01
    ld [wC929], a
    ld a, $70
    ld [wC928], a
    ld a, $00
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $01
    ld [wCB96], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4AD7::
    ld de, wCB9B
    call Func_00F_7EE9
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4AE3::
    ld a, $03
    ld [wC929], a
    ld a, $80
    ld [wC928], a
    ld a, $02
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, $04
    ld [wC929], a
    ld a, $80
    ld [wC928], a
    ld a, $02
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wCB96], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4B1B::
    ld a, $11
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $40
    ld [wCBD3], a
    ld a, $30
    ld [wCBD4], a
    xor a, a
    ld [wCBCF], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4B38::
    ld a, $49
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    call Func_00F_4FA1
    ret

Jump_00F_4B45::
    ld a, [wC921]
    and a, $03
    jr nz, Jump_00F_4B64
    ld a, [wCB86]
    inc a
    and a, $03
    ld [wCB86], a
    ld a, [wCB96]
    inc a
    and a, $03
    ld [wCB96], a
    ld [wCBA6], a
    ld [wCBB6], a

Jump_00F_4B64::
    ld de, wCB9B
    call Func_00F_7EE9
    push af
    ld a, [wCB9B]
    ld [wCBAB], a
    ld [wCBBB], a
    sub a, $30
    ld [wCB8B], a
    pop af
    ret nc
    ld a, $02
    ld [wCB96], a
    ld [wCBA6], a
    ld [wCBB6], a
    xor a, a
    ld [wCB86], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4B8F::
    ld a, [wC921]
    inc a
    ld [wC921], a
    and a, $03
    ret nz
    ld a, [wCB9A]
    inc a
    ld [wCB9A], a
    add a, $10
    ld [wCBAA], a
    add a, $10
    ld [wCBBA], a
    cp a, $60
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4BB6::
    ld a, [wC921]
    and a, $03
    jr nz, Jump_00F_4BCC
    ld a, [wCB96]
    inc a
    and a, $03
    ld [wCB96], a
    ld [wCBA6], a
    ld [wCBB6], a

Jump_00F_4BCC::
    ld de, wCB9B
    call Func_00F_7EE9
    push af
    ld a, [wCB9B]
    ld [wCBAB], a
    ld [wCBBB], a
    pop af
    ret nc
    ld a, $01
    ld [wCB96], a
    ld [wCBA6], a
    ld [wCBB6], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4BEE::
    ld a, $03
    ld [wCB96], a
    ld [wCBA6], a
    ld [wCBB6], a
    ld a, [wC921]
    inc a
    ld [wC921], a
    and a, $03
    ret nz
    ld a, [wCB9A]
    dec a
    ld [wCB9A], a
    add a, $10
    ld [wCBAA], a
    add a, $10
    ld [wCBBA], a
    cp a, $50
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4C20::
    ld a, $11
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $40
    ld [wCBD3], a
    ld a, $20
    ld [wCBD4], a
    xor a, a
    ld [wCBCF], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4C3D::
    ld a, $41
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    call Func_00F_4FA1
    ret

Jump_00F_4C4A::
    ld de, wCBBB
    call Func_00F_7EE9
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4C56::
    ld a, [wC921]
    or a, a
    jr nz, Jump_00F_4C90
    ld a, $60
    ld [wC928], a
    ld a, $02
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, $60
    ld [wC928], a
    ld a, $01
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC921
    inc [hl]
    ret

Jump_00F_4C90::
    dec a
    jr nz, Jump_00F_4CDA
    ld a, [wCBAB]
    cp a, $60
    jr z, Jump_00F_4CA6
    ld a, $60
    ld [wC928], a
    ld a, $02
    ld [wC92A], a
    jr Jump_00F_4CB0

Jump_00F_4CA6::
    ld a, $20
    ld [wC928], a
    ld a, $03
    ld [wC92A], a

Jump_00F_4CB0::
    ld a, $02
    ld [wC929], a
    farcall Func_05F_6B54
    ld a, $20
    ld [wC928], a
    ld a, $01
    ld [wC929], a
    ld a, $03
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC921
    inc [hl]
    ret

Jump_00F_4CDA::
    ld a, $20
    ld [wC928], a
    ld a, $02
    ld [wC929], a
    ld a, $03
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, $50
    ld [wC928], a
    ld a, $01
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wCBB6], a
    ld a, $02
    ld [wCBA6], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4D1B::
    ld a, $01
    ld [wC929], a
    ld a, [wC921]
    or a, a
    jr nz, Jump_00F_4D40
    ld a, $60
    ld [wC928], a
    ld a, $80
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC921
    inc [hl]
    ret

Jump_00F_4D40::
    dec a
    jr nz, Jump_00F_4D5D
    ld a, $40
    ld [wC928], a
    ld a, $81
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC921
    inc [hl]
    ret

Jump_00F_4D5D::
    ld a, $B0
    ld [wC928], a
    ld a, $80
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4D7B::
    ld de, wCB9B
    call Func_00F_7EE9
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4D87::
    ld a, $01
    ld [wC929], a
    ld a, [wC921]
    or a, a
    jr nz, Jump_00F_4DAC
    ld a, $60
    ld [wC928], a
    ld a, $02
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC921
    inc [hl]
    ret

Jump_00F_4DAC::
    dec a
    jr nz, Jump_00F_4DC9
    ld a, $20
    ld [wC928], a
    ld a, $03
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC921
    inc [hl]
    ret

Jump_00F_4DC9::
    ld a, $50
    ld [wC928], a
    ld a, $02
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4DE7::
    ld a, $11
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $20
    ld [wCBD3], a
    ld a, $40
    ld [wCBD4], a
    xor a, a
    ld [wCBCF], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4E08::
    ld a, $33
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    call Func_00F_4FA1
    ret

Jump_00F_4E15::
    ld a, $03
    ld [wCBA6], a
    ld a, [wCBAA]
    dec a
    ld [wCBAA], a
    ld de, wCBAB
    call Func_00F_7EE9
    ret nc
    xor a, a
    ld [wCBA6], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4E31::
    ld a, $02
    ld [wC929], a
    ld a, $60
    ld [wC928], a
    jr Jump_00F_4EB0

Jump_00F_4E3D::
    ld a, $00
    ld [wC929], a
    ld a, $E0
    ld [wC928], a
    ld a, $83
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, $01
    ld [wCB96], a
    ld hl, wCB9A
    inc [hl]
    ld de, wCB9B
    call Func_00F_7EE9
    ret nc
    xor a, a
    ld [wCB96], a
    ld a, $30
    ld [wCBAB], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4E70::
    ld a, $00
    ld [wC929], a
    ld a, $E0
    ld [wC928], a
    ld a, $83
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, $01
    ld [wC929], a
    ld a, $60
    ld [wC928], a
    jr Jump_00F_4EB0

Jump_00F_4E91::
    ld hl, wCB8A
    dec [hl]
    ld de, wCB8B
    call Func_00F_7EE9
    ret nc
    ld a, $30
    ld [wCB9B], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4EA6::
    ld a, $00
    ld [wC929], a
    ld a, $60
    ld [wC928], a

Jump_00F_4EB0::
    ld a, $80
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $03
    ld [wCB86], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4ECA::
    ld b, $5A
    call StepWC921Counter_Bank0F
    ret nc
    ld a, $30
    ld [wCB8B], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4EDA::
    ld a, $11
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $30
    ld [wCBD3], a
    ld a, $60
    ld [wCBD4], a
    xor a, a
    ld [wCBCF], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4EF7::
    ld a, $2F
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    call Func_00F_4FA1
    ret

Jump_00F_4F06::
    ld a, $80
    ld [wCBCF], a
    ld a, [wC921]
    inc a
    ld [wC921], a
    and a, $01
    jr z, Jump_00F_4F1A
    ld hl, wCBD4
    dec [hl]

Jump_00F_4F1A::
    ld a, [wC921]
    cp a, $40
    ret nz
    xor a, a
    ld [wCBCF], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4F2D::
    ld a, [wC921]
    and a, $07
    jr nz, Jump_00F_4F40
    ld a, [wCBB6]
    inc a
    and a, $03
    ld [wCBB6], a
    ld [wCBC6], a

Jump_00F_4F40::
    ld de, wCBAB
    call Func_00F_7EE9
    ret nc
    ld a, $02
    ld [wCBB6], a
    ld [wCBC6], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4F54::
    ld a, [wC921]
    and a, $03
    jr nz, Jump_00F_4F67
    ld a, [wCBB6]
    inc a
    and a, $03
    ld [wCBB6], a
    ld [wCBC6], a

Jump_00F_4F67::
    ld b, $96
    call StepWC921Counter_Bank0F
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4F72::
    ld a, $11
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $40
    ld [wCBD3], a
    ld a, $10
    ld [wCBD4], a
    xor a, a
    ld [wCBCF], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4F93::
    ld a, $01
    ld [wC90F], a
    ld a, $26
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a

; 6 call sites from 1 routine (e.g. Func_00F_47F5)
; reads: hPlayerY
; writes: wC8C8, wC8C9, wC8C6, wCBCF
Func_00F_4FA1::
    ld a, $E0
    ld [wC8C8], a
    ldh a, [hPlayerY]
    ld [wC8C9], a
    ld a, $04
    ld [wC8C6], a
    farcall Func_05F_6C5A
    xor a, a
    ld [wCBCF], a
    ret

Jump_00F_4FBB::
    ld a, $01
    ld [wC90F], a
    ld hl, $053A
    call StoreHLInWC924_B0F
    xor a, a
    ld [wCBCF], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4FCF::
    ld a, $01
    ld [wC90F], a
    ld hl, $0539
    call StoreHLInWC924_B0F
    ld a, $11
    ldh [hFFC6], a
    farcall Func_012_6B98
    xor a, a
    ld [wCBCF], a
    xor a, a
    ld [wC92D], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_4FF1::
    xor a, a
    ld [wC90F], a
    ldh a, [hPlayerY]
    cp a, $40
    jr z, Jump_00F_5007
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6A94
    ret

Jump_00F_5007::
    ld a, $80
    ld [wC928], a
    farcall Func_05F_6ABF
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $03
    ldh [hPlayerFacing], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5020::
    ld a, $01
    ld [wCB86], a
    ld hl, $0538
    call StoreHLInWC924_B0F
    ld a, $01
    ld [wC90F], a
    ld a, [wC933]
    ld [wC6FD], a
    xor a, a
    ldh [hFF8D], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_503E::
    ld a, $00
    ld [wC929], a
    ld a, $00
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_505D::
    ld a, $00
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    ld a, $20
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_507C::
    xor a, a
    ld [wC90F], a
    ld de, hPlayerY
    call Func_00F_7F0B
    ret

Jump_00F_5087::
    ld a, $01
    ld [wC90F], a
    ld hl, $0537
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5097::
    ld a, $0C
    ld [wC90D], a
    xor a, a
    ld [wC90E], a

Jump_00F_50A0::
    xor a, a
    ld [wC90F], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_50A9::
    xor a, a
    ld [wC90F], a
    ld hl, $0DF7
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_50B8::
    ld b, $0F
    call Func_00F_72A0
    ret

Jump_00F_50BE::
    ld a, $30
    ld [wCB9B], a
    xor a, a
    ld [wCBCF], a
    farcall Func_05F_6E09
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_50D2::
    farcall Func_05F_7363
    ret

Jump_00F_50D9::
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wC8C8], a
    ld a, $30
    ld [wC8C9], a
    ld a, $04
    ld [wC8C6], a
    xor a, a
    ld [wCCE9], a
    farcall Func_05F_6C5A
    ld hl, $0533
    call StoreHLInWC924_B0F
    xor a, a
    ld [wC92D], a
    ret

Jump_00F_5108::
    ld hl, $055B
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5113::
    ld hl, $055A
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_511E::
    ld hl, wCB8B
    inc [hl]

Jump_00F_5122::
    ld de, wCB8B
    call Func_00F_7EE9
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_512E::
    ldh a, [hPlayerX]
    cp a, $40
    jr z, Jump_00F_5140
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6B17
    ret

Jump_00F_5140::
    ld a, $20
    ld [wC928], a
    farcall Func_05F_6AEB
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $10
    ld [wCB8B], a
    ld a, $54
    ld [wC1C8], a
    ld a, $55
    ld [wC1C9], a
    farcall Func_05F_6DDB
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_516A::
    ld b, $3C
    call StepWC921Counter_Bank0F
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5175::
    ld a, $01
    ldh [hFFC6], a
    ld a, $30
    ldh [hFFC7], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    ld a, $01
    ld [wSpriteSlotCount], a
    ld de, $00D1
    call SetFlagBit
    ld a, [wCC3C]
    set 0, a
    ld [wCC3C], a
    ld hl, wC923
    inc [hl]
    ret
    INCBIN "dwm2-cobi-us.gbc", $03D19F, $78

Jump_00F_5217::
    xor a, a
    ld [wC90F], a
    ld a, $80
    ld [wCBCF], a
    ld a, [wC922]
    and a, $0F
    rst $00
    dw Jump_00F_522A
    dw Jump_00F_526C

Jump_00F_522A::
    ld a, [wC92D]
    bit 0, a
    jr z, Jump_00F_5236
    inc a
    ld [wC92D], a
    ret

Jump_00F_5236::
    and a, $FE
    ld de, $5284
    add a, e
    ld e, a
    jr nc, Jump_00F_5240
    inc d

Jump_00F_5240::
    push de
    ld a, [wC922]
    and a, $70
    swap a
    ld c, $30
    call Multiply8
    pop de
    add hl, de
    ld a, [hl+]
    ld [wCBD4], a
    ld a, [hl]
    ld [wCBD3], a
    ld a, [wC92D]
    inc a
    ld [wC92D], a
    srl a
    cp a, $17
    ret nz
    xor a, a
    ld [wC92D], a
    ld hl, wC922
    inc [hl]
    ret

Jump_00F_526C::
    ld a, [wC922]
    add a, $10
    and a, $F0
    cp a, $80
    jr nz, Jump_00F_5280
    xor a, a
    ld [wC92D], a
    ld hl, wC923
    inc [hl]
    xor a, a

Jump_00F_5280::
    ld [wC922], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $03D284, $180

; 1 call site from 1 routine (e.g. Func_010_4DCC)
; reads: wC923
Func_00F_5404::
    ld a, [wC923]
    rst $00
    dw Jump_00F_56C2
    dw Jump_00F_56BC
    dw Jump_00F_56B1
    dw Jump_00F_7F89
    dw Jump_00F_5662
    dw Jump_00F_7F89
    dw Jump_00F_5657
    dw Jump_00F_7F89
    dw Jump_00F_564D
    dw Jump_00F_7F89
    dw Jump_00F_5642
    dw Jump_00F_7F89
    dw Jump_00F_5612
    dw Jump_00F_7F89
    dw Jump_00F_55E5
    dw Jump_00F_7F89
    dw Jump_00F_55DA
    dw Jump_00F_7F89
    dw Jump_00F_55CF
    dw Jump_00F_7F89
    dw Jump_00F_55B8
    dw Jump_00F_55A7
    dw Jump_00F_5577
    dw Jump_00F_5558
    dw Jump_00F_554E
    dw Jump_00F_7F89
    dw Jump_00F_5543
    dw Jump_00F_7F89
    dw Jump_00F_5538
    dw Jump_00F_7F89
    dw Jump_00F_550B
    dw Jump_00F_7F89
    dw Jump_00F_55B3
    dw Jump_00F_55AC
    dw Jump_00F_54E0
    dw Jump_00F_7F89
    dw Jump_00F_56C2
    dw Jump_00F_56BC
    dw Jump_00F_54D5
    dw Jump_00F_7F89
    dw Jump_00F_549F
    dw Jump_00F_7F89
    dw Jump_00F_5495
    dw Jump_00F_5460

Jump_00F_5460::
    xor a, a
    call Func_00F_7F75
    ret nc
    ld a, $05
    ldh [hFFC6], a
    farcall Func_05F_6DAC
    ld a, [wCC37]
    set 4, a
    ld [wCC37], a
    farcall Func_012_6990
    ld a, $06
    ldh [hFFC7], a
    farcall Func_012_6955
    ld a, [wC836]
    set 7, a
    ld [wC836], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00F_5495::
    ld de, hPlayerY
    ld hl, $0A7E
    call Func_00F_7F24
    ret

Jump_00F_549F::
    ld a, $01
    ld [wC929], a
    ld a, $81
    ld [wC92A], a
    ld a, $B0
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld de, $00C3
    call SetFlagBit
    farcall Func_002_6050
    ld a, $01
    ld [wSpriteSlotCount], a
    ld hl, $0A7D
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_54D5::
    ld hl, $0A7C
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_54E0::
    farcall Func_012_64F8
    farcall Func_002_5E85
    farcall Func_002_5E85
    call Func_000_222B
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    ld hl, $0A7B
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_550B::
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wC8C8], a
    ld a, $30
    ld [wC8C9], a
    ld de, $0024
    call SetFlagBit
    ld a, $04
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ld hl, $0A7A
    call StoreHLInWC924_B0F
    ret

Jump_00F_5538::
    ld hl, $0491
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5543::
    ld hl, $0490
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_554E::
    ld de, wCBAB
    ld hl, $048F
    call Func_00F_7F24
    ret

Jump_00F_5558::
    ld a, [wC921]
    swap a
    srl a
    srl a
    and a, $01
    add a, a
    inc a
    ld [wCB86], a
    ld b, $B4
    call StepWC921Counter_Bank0F
    ret nc
    xor a, a
    ld [wCB86], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5577::
    ld a, [wCC3B]
    set 3, a
    ld [wCC3B], a
    ld de, $00C2
    call SetFlagBit
    ldh a, [hPlayerX]
    ld [wC8C8], a
    ldh a, [hPlayerY]
    ld [wC8C9], a
    ld a, $01
    call StartPaletteFade
    ld a, $03
    ld [wC8C6], a
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wC8C5], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_55A7::
    ld a, $01
    ld [wSpriteSlotCount], a

Jump_00F_55AC::
    farcall Func_012_653F
    ret

Jump_00F_55B3::
    ld a, $7A
    call QueueSoundEffect

Jump_00F_55B8::
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_00F_55CA
    ld hl, wC49F
    ld de, wC0F0
    ld bc, $0040
    call CopyBytes

Jump_00F_55CA::
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_55CF::
    ld hl, $048E
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_55DA::
    ld hl, $048D
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_55E5::
    ld a, [wFrameCounterLo]
    bit 2, a
    jr z, Jump_00F_55F2
    xor a, a
    ld [wCBCF], a
    jr Jump_00F_55F7

Jump_00F_55F2::
    ld a, $80
    ld [wCBCF], a

Jump_00F_55F7::
    ldh a, [hPlayerY]
    ld c, a
    ld a, [wCBD4]
    inc a
    ld [wCBD4], a
    cp a, c
    ret nz
    xor a, a
    ld [wCBCF], a
    ld hl, $048C
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5612::
    ld a, [wC552]
    or a, a
    jr z, Jump_00F_5623
    ld hl, wC48A
    call StoreHLInWC924_B0F
    ld hl, wC923
    dec [hl]
    ret

Jump_00F_5623::
    ld hl, vTiles0 + $48B
    call StoreHLInWC924_B0F
    ld a, $04
    ldh [hFFC6], a
    farcall Func_012_6B98
    ldh a, [hPlayerX]
    ld [wCBD3], a
    ld a, $E0
    ld [wCBD4], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5642::
    ld hl, $4487
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_564D::
    ld de, wCB8B
    ld hl, $0486
    call Func_00F_7F24
    ret

Jump_00F_5657::
    ld hl, $0485
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5662::
    ld a, [wC921]
    or a, a
    jr nz, Jump_00F_566D
    ld a, $1F
    call QueueMusic

Jump_00F_566D::
    ld a, $18
    ld [wCBBB], a
    ld a, [wC921]
    cp a, $1E
    jr nc, Jump_00F_567F
    bit 1, a
    jr z, Jump_00F_568F
    jr Jump_00F_5696

Jump_00F_567F::
    cp a, $3C
    jr nc, Jump_00F_5689
    bit 2, a
    jr z, Jump_00F_568F
    jr Jump_00F_5696

Jump_00F_5689::
    bit 3, a
    jr z, Jump_00F_568F
    jr Jump_00F_5696

Jump_00F_568F::
    ld a, $10
    ld [wCB9B], a
    jr Jump_00F_569B

Jump_00F_5696::
    ld a, $C0
    ld [wCB9B], a

Jump_00F_569B::
    ld b, $78
    call StepWC921Counter_Bank0F
    ret nc
    ld a, $02
    ld [wCB86], a
    ld hl, $0484
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_56B1::
    ld hl, $0483
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_56BC::
    ld b, $78
    call Func_00F_72A0
    ret

Jump_00F_56C2::
    farcall Func_05F_6E09
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4D86)
; reads: wC923
Func_00F_56CD::
    ld a, [wC923]
    rst $00
    dw Jump_00F_5717
    dw Jump_00F_7F89
    dw Jump_00F_56F3
    dw Jump_00F_7F89
    dw Jump_00F_56DB

Jump_00F_56DB::
    ld a, $40
    ldh [hFFC7], a
    ld a, $01
    ldh [hFFC6], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    ld a, $80
    ld [wC919], a
    ret

Jump_00F_56F3::
    ld hl, wC923
    inc [hl]
    ld a, [wC552]
    or a, a
    jr nz, Jump_00F_570A
    ld hl, vTiles0 + $416
    call StoreHLInWC924_B0F
    ld de, $00A6
    call SetFlagBit
    ret

Jump_00F_570A::
    ld hl, vTiles0 + $417
    call StoreHLInWC924_B0F
    ld de, $00A5
    call SetFlagBit
    ret

Jump_00F_5717::
    ld a, $40
    ld [wCB9B], a
    ld a, [wC921]
    cp a, $1E
    jr nc, Jump_00F_5729
    bit 1, a
    jr z, Jump_00F_5739
    jr Jump_00F_5740

Jump_00F_5729::
    cp a, $3C
    jr nc, Jump_00F_5733
    bit 2, a
    jr z, Jump_00F_5739
    jr Jump_00F_5740

Jump_00F_5733::
    bit 3, a
    jr z, Jump_00F_5739
    jr Jump_00F_5740

Jump_00F_5739::
    ld a, $02
    ld [wSpriteSlotCount], a
    jr Jump_00F_5745

Jump_00F_5740::
    ld a, $01
    ld [wSpriteSlotCount], a

Jump_00F_5745::
    ld b, $78
    call StepWC921Counter_Bank0F
    ret nc
    ld a, $02
    ld [wSpriteSlotCount], a
    xor a, a
    ld [wC921], a
    ld de, $00C2
    call TestFlagBit
    jp c, Jump_00F_57DE
    ld de, $00A7
    call TestFlagBit
    jr c, Jump_00F_57D2
    ld de, $00A6
    call TestFlagBit
    jr c, Jump_00F_57C6
    ld de, $00A5
    call TestFlagBit
    jr c, Jump_00F_57BB
    ld de, $00A4
    call TestFlagBit
    jr c, Jump_00F_579D
    ld de, $00A0
    call TestFlagBit
    jr c, Jump_00F_5791
    ld hl, $040C
    call StoreHLInWC924_B0F
    ld a, $03
    ld [wC923], a
    ret

Jump_00F_5791::
    ld hl, $040D
    call StoreHLInWC924_B0F
    ld a, $03
    ld [wC923], a
    ret

Jump_00F_579D::
    ld de, $00A0
    call TestFlagBit
    jr c, Jump_00F_57B0
    ld hl, $4415
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_57B0::
    ld hl, $4418
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_57BB::
    ld hl, $4419
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_57C6::
    ld hl, $0416
    call StoreHLInWC924_B0F
    ld a, $03
    ld [wC923], a
    ret

Jump_00F_57D2::
    ld hl, $0452
    call StoreHLInWC924_B0F
    ld a, $03
    ld [wC923], a
    ret

Jump_00F_57DE::
    ld hl, $0493
    call StoreHLInWC924_B0F
    ld a, $03
    ld [wC923], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4D71)
; reads: wC923
Func_00F_57EA::
    ld a, [wC923]
    rst $00
    dw Jump_00F_59C8
    dw Jump_00F_59B8
    dw Jump_00F_59AD
    dw Jump_00F_5993
    dw Jump_00F_7F89
    dw Jump_00F_59AD
    dw Jump_00F_5971
    dw Jump_00F_59AD
    dw Jump_00F_5962
    dw Jump_00F_59AD
    dw Jump_00F_594A
    dw Jump_00F_5906
    dw Jump_00F_7F89
    dw Jump_00F_58E5
    dw Jump_00F_58D5
    dw Jump_00F_58C5
    dw Jump_00F_7F89
    dw Jump_00F_5890
    dw Jump_00F_5889
    dw Jump_00F_585B
    dw Jump_00F_583A
    dw Jump_00F_7F89
    dw Jump_00F_581C

Jump_00F_581C::
    ld de, $0023
    call SetFlagBit
    ld a, $04
    ldh [hFFC6], a
    farcall Func_05F_6DAC
    ld a, [wCC37]
    set 3, a
    ld [wCC37], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00F_583A::
    ldh a, [hPlayerY]
    ld c, a
    ld a, [wCBD4]
    inc a
    ld [wCBD4], a
    cp a, c
    ret nz
    xor a, a
    ld [wCBCF], a
    ld hl, $0DCB
    call StoreHLInWC924_B0F
    ld de, $001E
    call SetFlagBit
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_585B::
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ld [wCB86], a
    ld a, $11
    ldh [hFFC6], a
    farcall Func_012_6B98
    ldh a, [hPlayerX]
    ld [wCBD3], a
    ldh a, [hPlayerY]
    sub a, $20
    ld [wCBD4], a
    ld a, $80
    ld [wCBCF], a
    ld a, $85
    call QueueSoundEffect
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5889::
    farcall Func_05F_7363
    ret

Jump_00F_5890::
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wC8C8], a
    ld a, $30
    ld [wC8C9], a
    ld a, $01
    ld [wC8C6], a
    xor a, a
    ld [wCCE9], a
    farcall Func_05F_6C5A
    ld hl, $02A7
    call StoreHLInWC924_B0F
    xor a, a
    ld [wC92D], a
    ld hl, hFF8C
    call ClearBit2AtHL_Bank0F
    ret

Jump_00F_58C5::
    xor a, a
    call Func_00F_7F75
    ret nc
    ld hl, $0A0A
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_58D5::
    xor a, a
    call Func_00F_7F75
    ret nc
    ld hl, $0A09
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_58E5::
    ld hl, wCB8B
    inc [hl]
    ld de, wCB8B
    call Func_00F_7EE9
    ret nc
    ld a, $E0
    ld [wCB8B], a
    ld hl, $0A08
    call StoreHLInWC924_B0F
    ld de, $01E5
    call SetFlagBit
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5906::
    ld a, $18
    ld [wCBAB], a
    ld a, [wC921]
    cp a, $1E
    jr nc, Jump_00F_5918
    bit 1, a
    jr z, Jump_00F_5928
    jr Jump_00F_592F

Jump_00F_5918::
    cp a, $3C
    jr nc, Jump_00F_5922
    bit 2, a
    jr z, Jump_00F_5928
    jr Jump_00F_592F

Jump_00F_5922::
    bit 3, a
    jr z, Jump_00F_5928
    jr Jump_00F_592F

Jump_00F_5928::
    ld a, $03
    ld [wSpriteSlotCount], a
    jr Jump_00F_5934

Jump_00F_592F::
    ld a, $02
    ld [wSpriteSlotCount], a

Jump_00F_5934::
    ld b, $78
    call StepWC921Counter_Bank0F
    ret nc
    ld a, $03
    ld [wSpriteSlotCount], a
    ld hl, $0A07
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_594A::
    ld a, $49
    ldh [hMapId], a
    ld a, $00
    ldh [hMapScreenX], a
    ld a, $00
    ldh [hMapScreenY], a
    ld a, $40
    ld [wC8C9], a
    farcall Func_05F_6C5A
    ret

Jump_00F_5962::
    ld a, [wCC3A]
    set 1, a
    ld [wCC3A], a
    farcall Func_05F_6C5A
    ret

Jump_00F_5971::
    ld a, $48
    ldh [hMapId], a
    ld a, $07
    ldh [hMapScreenX], a
    ld a, $05
    ldh [hMapScreenY], a
    ldh a, [hPlayerX]
    ld [wC8C8], a
    ld a, $E0
    ld [wC8C9], a
    ld a, $03
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

Jump_00F_5993::
    ld hl, wCBD4
    dec [hl]
    ld de, wCBD4
    call Func_00F_7EE9
    ret nc
    xor a, a
    ld [wCBCF], a
    ld hl, $0DCA
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_59AD::
    ld b, $3C
    call StepWC921Counter_Bank0F
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_59B8::
    ld hl, wCBD4
    dec [hl]
    ld de, wCBD4
    call Func_00F_7EE9
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_59C8::
    ld a, $10
    ldh [hFFC6], a
    farcall Func_012_6B98
    ldh a, [hPlayerX]
    ld [wCBD3], a
    ldh a, [hPlayerY]
    ld [wCBD4], a
    ld a, $80
    ld [wCBCF], a
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4D6A)
; reads: wC923
Func_00F_59E6::
    ld a, [wC923]
    rst $00
    dw Jump_00F_5AB9
    dw Jump_00F_5AB2
    dw Jump_00F_5A73
    dw Jump_00F_7F89
    dw Jump_00F_5A56
    dw Jump_00F_5A42
    dw Jump_00F_5A31
    dw Jump_00F_7F89
    dw Jump_00F_5A13
    dw Jump_00F_7F89
    dw Jump_00F_5A02
    dw Jump_00F_7F93

Jump_00F_5A02::
    ld hl, $0A05
    call StoreHLInWC924_B0F
    ld de, $01E4
    call SetFlagBit
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5A13::
    ld a, [wC922]
    ldh [hFFC7], a
    ld a, $01
    ldh [hFFC6], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    ld hl, $0DDF
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5A31::
    ld hl, $0A04
    call StoreHLInWC924_B0F
    ld a, [wCB9B]
    ld [wC922], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5A42::
    xor a, a
    call Func_00F_7F75
    ret nc
    ld a, $19
    ldh [hFFC6], a
    farcall Func_00A_47A4
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5A56::
    ld a, [wC552]
    or a, a
    jr nz, Jump_00F_5A67
    ld hl, vTiles1 + $5D0
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5A67::
    ld hl, vTiles1 + $5D1
    call StoreHLInWC924_B0F
    ld a, $0B
    ld [wC923], a
    ret

Jump_00F_5A73::
    ld a, [wC921]
    cp a, $1E
    jr nc, Jump_00F_5A80
    bit 1, a
    jr z, Jump_00F_5A90
    jr Jump_00F_5A97

Jump_00F_5A80::
    cp a, $3C
    jr nc, Jump_00F_5A8A
    bit 2, a
    jr z, Jump_00F_5A90
    jr Jump_00F_5A97

Jump_00F_5A8A::
    bit 3, a
    jr z, Jump_00F_5A90
    jr Jump_00F_5A97

Jump_00F_5A90::
    ld a, $20
    ld [wCB9B], a
    jr Jump_00F_5A9C

Jump_00F_5A97::
    ld a, $E0
    ld [wCB9B], a

Jump_00F_5A9C::
    ld b, $78
    call StepWC921Counter_Bank0F
    ret nc
    ld a, $20
    ld [wCB9B], a
    ld hl, $4A02
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5AB2::
    farcall Func_012_653F
    ret

Jump_00F_5AB9::
    ld de, $01E3
    call TestFlagBit
    jr nc, Jump_00F_5AD2
    ld hl, $0A03
    call StoreHLInWC924_B0F
    ld a, $01
    ld [wC922], a
    ld a, $05
    ld [wC923], a
    ret

Jump_00F_5AD2::
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_00F_5AE4
    ld hl, wC49F
    ld de, wC0F0
    ld bc, $0040
    call CopyBytes

Jump_00F_5AE4::
    ld de, $01E3
    call SetFlagBit
    xor a, a
    ld [wC922], a
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4E2E)
; reads: wC923
Func_00F_5AF3::
    ld a, [wC923]
    rst $00
    dw Jump_00F_5C06
    dw Jump_00F_7F89
    dw Jump_00F_5BC2
    dw Jump_00F_7F89
    dw Jump_00F_5BA5
    dw Jump_00F_5B91
    dw Jump_00F_5B86
    dw Jump_00F_7F89
    dw Jump_00F_5B5F
    dw Jump_00F_7F89
    dw Jump_00F_5B3B
    dw Jump_00F_7F89
    dw Jump_00F_5B2C
    dw Jump_00F_7F89
    dw Jump_00F_5B17
    dw Jump_00F_7F93

Jump_00F_5B17::
    xor a, a
    ld [wCB86], a
    ld hl, $0AF5
    call StoreHLInWC924_B0F
    ld de, $01E2
    call SetFlagBit
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5B2C::
    ld a, $02
    ld [wCB96], a
    ld de, wCB9B
    ld hl, $0AF4
    call Func_00F_7F24
    ret

Jump_00F_5B3B::
    ld de, Data_07D_4C21
    ld b, $7D
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    xor a, a
    ld [wCB86], a
    ld a, $0F
    ld [wCB81], a
    ld a, $01
    ld [wCB86], a
    ld hl, $0AF3
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5B5F::
    ld a, $02
    ldh [hFFC6], a
    ld a, $20
    ldh [hFFC7], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    ld a, $02
    ld [wSpriteSlotCount], a
    ld a, $03
    ld [wCB96], a
    ld hl, $0AF2
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5B86::
    ld hl, $0AF0
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5B91::
    xor a, a
    call Func_00F_7F75
    ret nc
    ld a, $04
    ldh [hFFC6], a
    farcall Func_00A_47A4
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5BA5::
    ld a, [wC552]
    or a, a
    jr nz, Jump_00F_5BB6
    ld hl, vTiles1 + $5CE
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5BB6::
    ld hl, vTiles1 + $5CF
    call StoreHLInWC924_B0F
    ld a, $0F
    ld [wC923], a
    ret

Jump_00F_5BC2::
    ld a, $20
    ld [wCBAB], a
    ld a, [wC921]
    cp a, $1E
    jr nc, Jump_00F_5BD4
    bit 1, a
    jr z, Jump_00F_5BE4
    jr Jump_00F_5BEB

Jump_00F_5BD4::
    cp a, $3C
    jr nc, Jump_00F_5BDE
    bit 2, a
    jr z, Jump_00F_5BE4
    jr Jump_00F_5BEB

Jump_00F_5BDE::
    bit 3, a
    jr z, Jump_00F_5BE4
    jr Jump_00F_5BEB

Jump_00F_5BE4::
    ld a, $03
    ld [wSpriteSlotCount], a
    jr Jump_00F_5BF0

Jump_00F_5BEB::
    ld a, $02
    ld [wSpriteSlotCount], a

Jump_00F_5BF0::
    ld b, $78
    call StepWC921Counter_Bank0F
    ret nc
    ld a, $03
    ld [wSpriteSlotCount], a
    ld hl, $4AEE
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5C06::
    ld de, $01E1
    call TestFlagBit
    jr c, Jump_00F_5C2F
    ld hl, $0AED
    call StoreHLInWC924_B0F
    ld a, $34
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    farcall Func_012_7DF1
    ld de, $01E1
    call SetFlagBit
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5C2F::
    ld hl, $0AEF
    call StoreHLInWC924_B0F
    ld a, $05
    ld [wC923], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4D63)
; reads: wC923
Func_00F_5C3B::
    ld a, [wC923]
    rst $00
    dw Jump_00F_5D1A
    dw Jump_00F_5D03
    dw Jump_00F_5CA9
    dw Jump_00F_5C47

Jump_00F_5C47::
    ld a, [wCB9B]
    cp a, $40
    jr z, Jump_00F_5C65
    ld a, $01
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6B54
    jr Jump_00F_5C7A

Jump_00F_5C65::
    ld a, $01
    ld [wC929], a
    ld a, $01
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    farcall Func_05F_6B54

Jump_00F_5C7A::
    ldh a, [hPlayerY]
    cp a, $40
    jr z, Jump_00F_5C8C
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6AEB
    ret

Jump_00F_5C8C::
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6ABF
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $02
    ldh [hPlayerFacing], a
    ld [wCB96], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00F_5CA9::
    ld a, [wCB9A]
    cp a, $30
    jr z, Jump_00F_5CC7
    ld a, $01
    ld [wC929], a
    ld a, $03
    ld [wC92A], a
    ld a, $30
    ld [wC928], a
    farcall Func_05F_6B54
    jr Jump_00F_5CDC

Jump_00F_5CC7::
    ld a, $01
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6B54

Jump_00F_5CDC::
    ldh a, [hPlayerY]
    cp a, $70
    jr z, Jump_00F_5CEE
    ld a, $70
    ld [wC928], a
    farcall Func_05F_6AEB
    ret

Jump_00F_5CEE::
    ld a, $30
    ld [wC928], a
    farcall Func_05F_6B17
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5D03::
    farcall UpdatePlayerMovement
    farcall Func_002_5BD7
    ld a, [wC468]
    bit 7, a
    ret nz
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5D1A::
    ld a, [wCB8A]
    cp a, $50
    jr z, Jump_00F_5D38
    ld a, $00
    ld [wC929], a
    ld a, $03
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    farcall Func_05F_6B54
    jr Jump_00F_5D4D

Jump_00F_5D38::
    ld a, $00
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    ld a, $E0
    ld [wC928], a
    farcall Func_05F_6B54

Jump_00F_5D4D::
    ldh a, [hPlayerX]
    cp a, $50
    jr z, Jump_00F_5D5F
    ld a, $30
    ld [wC928], a
    farcall Func_05F_6B17
    ret

Jump_00F_5D5F::
    ld a, $00
    ld [wC928], a
    farcall Func_05F_6AEB
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $80
    ld [wC468], a
    ld a, $04
    ld [wC46A], a
    ld hl, hMapScreenY
    dec [hl]
    ldh a, [hFF8C]
    or a, $01
    ldh [hFF8C], a
    ld hl, hFF80
    ld a, l
    ldh [hFF9D], a
    ld a, h
    ldh [hFF9E], a
    farcall UpdatePlayerMovement
    farcall Func_002_5BD7
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4D5C)
; reads: wC923
Func_00F_5D9D::
    ld a, [wC923]
    rst $00
    dw Jump_00F_5EE8
    dw Jump_00F_5E70
    dw Jump_00F_5E3A
    dw Jump_00F_7F89
    dw Jump_00F_5E07
    dw Jump_00F_7F89
    dw Jump_00F_5DF8
    dw Jump_00F_5DED
    dw Jump_00F_7F89
    dw Jump_00F_5DCC
    dw Jump_00F_7F89
    dw Jump_00F_5DBB
    dw Jump_00F_7F93

Jump_00F_5DBB::
    ld hl, $0AD5
    call StoreHLInWC924_B0F
    ld de, $009D
    call SetFlagBit
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5DCC::
    ld a, $02
    ldh [hFFC6], a
    ld a, $30
    ldh [hFFC7], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    ld hl, wSpriteSlotCount
    dec [hl]
    ld hl, $0AD0
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5DED::
    ld hl, $0AD4
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5DF8::
    ld a, $18
    ldh [hFFC6], a
    farcall Func_00A_47A4
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5E07::
    ld a, $33
    ldh [hFFC6], a
    farcall FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_00F_5E1D
    farcall Func_012_7DF1

Jump_00F_5E1D::
    ld a, [wC552]
    or a, a
    jr nz, Jump_00F_5E2E
    ld hl, vTiles1 + $5CC
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5E2E::
    ld hl, vTiles1 + $5CD
    call StoreHLInWC924_B0F
    ld a, $0C
    ld [wC923], a
    ret

Jump_00F_5E3A::
    ld a, [wC922]
    or a, a
    jr nz, Jump_00F_5E46
    ld hl, wCB8B
    dec [hl]
    jr Jump_00F_5E4A

Jump_00F_5E46::
    ld hl, wCB8B
    inc [hl]

Jump_00F_5E4A::
    ld de, wCB8B
    call Func_00F_7EE9
    ret nc
    ld hl, wC923
    inc [hl]
    ld de, $009C
    call TestFlagBit
    jr c, Jump_00F_5E6A
    ld hl, $4AD2
    call StoreHLInWC924_B0F
    ld de, $009C
    call SetFlagBit
    ret

Jump_00F_5E6A::
    ld a, $06
    ld [wC923], a
    ret

Jump_00F_5E70::
    ld hl, wCB9A
    dec [hl]
    ld hl, wCB9B
    inc [hl]
    ld de, wCB9B
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld a, [wC921]
    inc a
    ld [wC921], a
    and a, $03
    jr nz, Jump_00F_5E9D
    ld a, [wCB96]
    inc a
    and a, $03
    ld [wCB96], a

Jump_00F_5E9D::
    ld a, [wC921]
    cp a, $20
    ret nz
    ld a, [wCB86]
    ld [wCB96], a
    ld [wCBA6], a
    ld a, [wCB9A]
    ld [wCBAA], a
    ld a, [wCB9B]
    ld [wCBAB], a
    ld a, $E0
    ld [wCB9A], a
    ld a, $63
    call QueueSoundEffect
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    xor a, a
    ld [wC922], a
    ldh a, [hPlayerY]
    cp a, $20
    jr z, Jump_00F_5EE2
    cp a, $40
    ret z
    ld a, [wC6FD]
    dec a
    ret z
    ld a, [wC8F6]
    cp a, $20
    ret nz

Jump_00F_5EE2::
    ld a, $01
    ld [wC922], a
    ret

Jump_00F_5EE8::
    ld a, [wCB9A]
    cp a, $80
    jr nz, Jump_00F_5F00
    ld a, [wCB9B]
    cp a, $10
    jr nz, Jump_00F_5F00
    ld a, $65
    call QueueSoundEffect
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5F00::
    ld a, $06
    ld [wC923], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4D4E)
; reads: wC923
Func_00F_5F06::
    ld a, [wC923]
    rst $00
    dw Jump_00F_6066
    dw Jump_00F_6019
    dw Jump_00F_6003
    dw Jump_00F_5FEC
    dw Jump_00F_5FD6
    dw Jump_00F_5FEC
    dw Jump_00F_5FD6
    dw Jump_00F_5FC0
    dw Jump_00F_7F89
    dw Jump_00F_5FB9
    dw Jump_00F_5F8E
    dw Jump_00F_5F65
    dw Jump_00F_5F4A
    dw Jump_00F_7F89
    dw Jump_00F_5F3D
    dw Jump_00F_5F36
    dw Jump_00F_5F2C

Jump_00F_5F2C::
    ld a, $02
    ldh [hPlayerFacing], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00F_5F36::
    farcall Func_05F_70D2
    ret

Jump_00F_5F3D::
    xor a, a
    ld [wC92D], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5F4A::
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6AEB
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, $03A1
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5F65::
    ldh a, [hPlayerX]
    cp a, $40
    jr nz, Jump_00F_5F70
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5F70::
    jr nc, Jump_00F_5F80
    ldh a, [hPlayerX]
    call Func_00F_7ED8
    ld a, $01
    ldh [hPlayerFacing], a
    ld hl, hPlayerX
    inc [hl]
    ret

Jump_00F_5F80::
    ldh a, [hPlayerX]
    call Func_00F_7ED8
    ld a, $03
    ldh [hPlayerFacing], a
    ld hl, hPlayerX
    dec [hl]
    ret

Jump_00F_5F8E::
    ld a, $02
    ld [wC929], a
    ld a, $00
    ld [wC92A], a
    ld a, $A0
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, hFF8C
    call SetBit2AtHL_B0F
    farcall Func_002_6050
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5FB9::
    ld de, wCBAB
    call Func_00F_7F0B
    ret

Jump_00F_5FC0::
    ld a, $02
    ld [wCBA6], a
    ld hl, wCBAC
    call ClearBit2AtHL_Bank0F
    ld hl, $03A0
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5FD6::
    ld b, $4B
    call StepWC921Counter_Bank0F
    ret nc
    ld a, $01
    ld [wCBA6], a
    ld hl, wCBAC
    call ClearBit1AtHL_Bank0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_5FEC::
    ld hl, wCBAC
    call SetBit2AtHL_B0F
    ld b, $1E
    call StepWC921Counter_Bank0F
    ret nc
    ld hl, wCBAC
    call SetBit1AtHL_Bank0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6003::
    ld b, $4B
    call StepWC921Counter_Bank0F
    ret nc
    ld a, $03
    ld [wCBA6], a
    ld hl, wCBAC
    call ClearBit1AtHL_Bank0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6019::
    ld hl, wCBAC
    call SetBit2AtHL_B0F
    ld a, [wFrameCounterLo]
    srl a
    srl a
    srl a
    and a, $03
    ld [wCBA6], a
    ld de, wCBAB
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld a, [wC921]
    and a, $01
    jr nz, Jump_00F_6049
    ld hl, wCBAA
    inc [hl]

Jump_00F_6049::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $20
    ret nz
    xor a, a
    ld [wCBA6], a
    ld hl, wCBAC
    call SetBit1AtHL_Bank0F
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6066::
    ld a, [wC921]
    or a, a
    jr nz, Jump_00F_608E
    ld a, $02
    ld [wC929], a
    ld a, $01
    ld [wC92A], a
    ld a, $70
    ld [wC928], a
    farcall Func_05F_6B54
    call Func_00F_60D9
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC921
    inc [hl]
    ret

Jump_00F_608E::
    dec a
    jr nz, Jump_00F_60B3
    ld a, $02
    ld [wC929], a
    ld a, $03
    ld [wC92A], a
    ld a, $20
    ld [wC928], a
    farcall Func_05F_6B54
    call Func_00F_60D9
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC921
    inc [hl]
    ret

Jump_00F_60B3::
    ld a, $02
    ld [wC929], a
    ld a, $01
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6B54
    call Func_00F_60D9
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

; 3 call sites from 1 routine (e.g. Func_00F_5F06)
; reads: wFrameCounterLo
; writes: wCBA6
Func_00F_60D9::
    ld a, [wFrameCounterLo]
    srl a
    srl a
    and a, $03
    ld [wCBA6], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4D2B)
; reads: wC923
Func_00F_60E6::
    ld a, [wC923]
    rst $00
    dw Jump_00F_6252
    dw Jump_00F_622E
    dw Jump_00F_61BC
    dw Jump_00F_61A8
    dw Jump_00F_619D
    dw Jump_00F_7F89
    dw Jump_00F_614C
    dw Jump_00F_6140
    dw Jump_00F_613A
    dw Jump_00F_60FE

Jump_00F_60FE::
    ld a, [wCBD4]
    inc a
    inc a
    ld [wCBD4], a
    cp a, $10
    ret nz
    ld a, $72
    call QueueSoundEffect
    ld a, $52
    ld [wCBA1], a
    ldh [hFFC6], a
    xor a, a
    ldh [hFFC7], a
    ld a, $01
    ldh [hFFC8], a
    ld a, $07
    ldh [hFFC9], a
    ld hl, vTiles0 + $700
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    farcall Func_004_431F
    ld a, $7F
    ld [wC527], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00F_613A::
    ld b, $0F
    call Func_00F_72A0
    ret

Jump_00F_6140::
    ld a, $E0
    ld [wCB8A], a
    farcall Func_012_653F
    ret

Jump_00F_614C::
    ld hl, hFF8C
    call SetBit2AtHL_B0F
    ld a, [wC921]
    inc a
    ld [wC921], a
    and a, $03
    ret nz
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    ld [wC8F1], a
    ld [wC8F6], a
    ld [wC8FB], a
    cp a, $40
    ret nz
    ld a, $09
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_00F_6189
    ld hl, wC49F
    ld de, wC0F0
    ld bc, $0040
    call CopyBytes

Jump_00F_6189::
    ld a, $7A
    call QueueSoundEffect
    ld hl, hFF8C
    call ClearBit2AtHL_Bank0F
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_619D::
    ld hl, $0348
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_61A8::
    xor a, a
    call Func_00F_7F75
    ret nc
    ld a, $03
    ldh [hFFC6], a
    farcall Func_00A_47A4
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_61BC::
    ld b, $3C
    call Func_00F_72A0
    ld hl, hPlayerY
    inc [hl]
    ld de, hPlayerY
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld hl, wC8F1
    inc [hl]
    ld de, wC8F1
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld hl, wC8F6
    inc [hl]
    ld de, wC8F6
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld hl, wC8FB
    inc [hl]
    ld de, wC8FB
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $20
    ret nz
    ld hl, $0346
    call StoreHLInWC924_B0F
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_622E::
    ld a, $20
    ld [wC928], a
    ld a, $00
    ld [wC929], a
    ld a, $80
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $66
    call QueueSoundEffect
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6252::
    ld de, $0085
    call TestFlagBit
    jr c, Jump_00F_626B
    farcall Func_05F_6E09
    ld de, $0085
    call SetFlagBit
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_626B::
    ld hl, $0347
    call StoreHLInWC924_B0F
    ld a, $03
    ld [wC923], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4D47)
; reads: wC923
Func_00F_6277::
    ld a, [wC923]
    rst $00
    dw Jump_00F_62C0
    dw Jump_00F_62AF
    dw Jump_00F_62A0
    dw Jump_00F_6283

Jump_00F_6283::
    ld a, $00
    ldh [hFFC6], a
    ld a, $40
    ldh [hFFC7], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    ld a, $E0
    ld [wCB8B], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00F_62A0::
    ld a, $0C
    ldh [hFFC6], a
    farcall Func_00A_47A4
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_62AF::
    ld b, $1E
    call StepWC921Counter_Bank0F
    ret nc
    ld de, $0093
    call SetFlagBit
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_62C0::
    ld de, $0093
    call TestFlagBit
    jr nc, Jump_00F_62D1
    ld hl, wC923
    inc [hl]
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_62D1::
    ld a, [wCBA6]
    ld [wCB86], a
    ld a, [wC921]
    cp a, $1E
    jr nc, Jump_00F_62E4
    bit 1, a
    jr z, Jump_00F_62F4
    jr Jump_00F_6300

Jump_00F_62E4::
    cp a, $3C
    jr nc, Jump_00F_62EE
    bit 2, a
    jr z, Jump_00F_62F4
    jr Jump_00F_6300

Jump_00F_62EE::
    bit 3, a
    jr z, Jump_00F_62F4
    jr Jump_00F_6300

Jump_00F_62F4::
    ld a, $40
    ld [wCB8B], a
    ld a, $E0
    ld [wCBAB], a
    jr Jump_00F_630A

Jump_00F_6300::
    ld a, $E0
    ld [wCB8B], a
    ld a, $40
    ld [wCBAB], a

Jump_00F_630A::
    ld b, $78
    call StepWC921Counter_Bank0F
    ret nc
    ld a, $40
    ld [wCB8B], a
    ld a, $E0
    ld [wCBAB], a
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4D39)
; reads: wC923
Func_00F_631F::
    ld a, [wC923]
    rst $00
    dw Jump_00F_64D4
    dw Jump_00F_64BA
    dw Jump_00F_7F89
    dw Jump_00F_6473
    dw Jump_00F_6D00
    dw Jump_00F_6D00
    dw Jump_00F_6D00
    dw Jump_00F_6433
    dw Jump_00F_6416
    dw Jump_00F_63E5
    dw Jump_00F_6383
    dw Jump_00F_7F89
    dw Jump_00F_633D

Jump_00F_633D::
    ld a, [wCB9B]
    cp a, $50
    jr z, Jump_00F_635A
    ld a, $50
    ld [wC928], a
    ld a, $01
    ld [wC929], a
    ld a, $80
    ld [wC92A], a
    farcall Func_05F_6B54
    ret

Jump_00F_635A::
    ld a, [wCB9A]
    cp a, $30
    jr z, Jump_00F_6372
    dec a
    dec a
    ld [wCB9A], a
    ld hl, wCB9C
    call SetBit2AtHL_B0F
    ld a, $03
    ld [wCB96], a
    ret

Jump_00F_6372::
    ld a, $01
    ld [wCB96], a
    ld hl, wCB9C
    call ClearBit2AtHL_Bank0F
    ld a, $80
    ld [wC919], a
    ret

Jump_00F_6383::
    ld hl, wCB9B
    inc [hl]
    ld de, wCB9B
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld b, $3C
    call Func_00F_72A0
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $20
    ret nz
    ld a, [wC922]
    cp a, $30
    jr z, Jump_00F_63BD
    ld hl, $0362
    call StoreHLInWC924_B0F
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_63BD::
    ld a, [wCC3A]
    set 0, a
    ld [wCC3A], a
    ld a, $38
    ld [wC19E], a
    ld a, $39
    ld [wC19F], a
    ld a, $3A
    ld [wC1B2], a
    ld a, $3B
    ld [wC1B3], a
    farcall Func_05F_6DDB
    ld a, $80
    ld [wC919], a
    ret

Jump_00F_63E5::
    ld a, $00
    ld [wC928], a
    ld a, $01
    ld [wC929], a
    ld a, $82
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC923
    inc [hl]
    ld a, [wC922]
    cp a, $30
    jr z, Jump_00F_6410
    ld a, $63
    call QueueSoundEffect
    ret

Jump_00F_6410::
    ld a, $66
    call QueueSoundEffect
    ret

Jump_00F_6416::
    ld a, [wC921]
    inc a
    ld [wC921], a
    and a, $07
    ret nz
    ld a, [wCB9B]
    inc a
    ld [wCB9B], a
    cp a, $30
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6433::
    ld hl, wCB9C
    call SetBit2AtHL_B0F
    ld a, [wC922]
    ld c, a
    ld a, [wCB9A]
    cp a, c
    jr z, Jump_00F_644E
    inc a
    inc a
    ld [wCB9A], a
    ld a, $01
    ld [wCB96], a
    ret

Jump_00F_644E::
    ld a, $20
    ld [wC928], a
    ld a, $01
    ld [wC929], a
    ld a, $82
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wCB9C
    call ClearBit2AtHL_Bank0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6473::
    ld hl, hFF8C
    call SetBit2AtHL_B0F
    ldh a, [hPlayerX]
    call Func_00F_7ED8
    ld a, [wC922]
    cp a, $40
    jr nc, Jump_00F_6490
    ldh a, [hPlayerX]
    inc a
    ldh [hPlayerX], a
    ld a, $01
    ldh [hPlayerFacing], a
    jr Jump_00F_6499

Jump_00F_6490::
    ldh a, [hPlayerX]
    dec a
    ldh [hPlayerX], a
    ld a, $03
    ldh [hPlayerFacing], a

Jump_00F_6499::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $10
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ldh [hPlayerFacing], a
    ld hl, hFF8C
    call ClearBit2AtHL_Bank0F
    ret

Jump_00F_64BA::
    ld b, $3C
    call StepWC921Counter_Bank0F
    ret nc
    xor a, a
    ld [wCBCF], a
    ld hl, wC923
    inc [hl]
    ldh a, [hPlayerX]
    ld [wC922], a
    ld hl, $0361
    call StoreHLInWC924_B0F
    ret

Jump_00F_64D4::
    farcall Func_05F_6E09
    ld a, $05
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $30
    ld [wCBD3], a
    ld a, $40
    ld [wCBD4], a
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4D32)
; reads: wC923
Func_00F_64F3::
    ld a, [wC923]
    rst $00
    dw Jump_00F_6767
    dw Jump_00F_6750
    dw Jump_00F_66F4
    dw Jump_00F_6676
    dw Jump_00F_7F89
    dw Jump_00F_666A
    dw Jump_00F_6628
    dw Jump_00F_7F89
    dw Jump_00F_6606
    dw Jump_00F_6D00
    dw Jump_00F_65F3
    dw Jump_00F_6D00
    dw Jump_00F_65DF
    dw Jump_00F_6D00
    dw Jump_00F_65D6
    dw Jump_00F_65A5
    dw Jump_00F_6586
    dw Jump_00F_651B

Jump_00F_651B::
    ld a, [wC922]
    or a, a
    jr nz, Jump_00F_652D
    ldh a, [hPlayerY]
    cp a, $40
    jr nz, Jump_00F_654D
    ld hl, wC922
    inc [hl]
    jr Jump_00F_654D

Jump_00F_652D::
    dec a
    jr nz, Jump_00F_654D
    ld de, wCB8B
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld de, wCB9B
    call Func_00F_7EE9
    jr nc, Jump_00F_654D
    ld hl, wC922
    inc [hl]

Jump_00F_654D::
    ldh a, [hPlayerY]
    cp a, $40
    jr z, Jump_00F_6557
    inc a
    inc a
    ldh [hPlayerY], a

Jump_00F_6557::
    ld a, [wC8F1]
    cp a, $40
    jr z, Jump_00F_6563
    inc a
    inc a
    ld [wC8F1], a

Jump_00F_6563::
    ld a, [wC8F6]
    cp a, $40
    jr z, Jump_00F_656F
    inc a
    inc a
    ld [wC8F6], a

Jump_00F_656F::
    ld a, [wC8FB]
    inc a
    inc a
    ld [wC8FB], a
    cp a, $40
    ret nz
    ld hl, hFF8C
    call ClearBit1AtHL_Bank0F
    ld a, $80
    ld [wC919], a
    ret

Jump_00F_6586::
    ld hl, hFF8C
    call SetBit1AtHL_Bank0F
    ld a, $D0
    ld [wC8F1], a
    ld a, $C0
    ld [wC8F6], a
    ld a, $B0
    ld [wC8FB], a
    ld a, $65
    call QueueSoundEffect
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_65A5::
    ld a, $E0
    ldh [hPlayerX], a
    ld [wC8F0], a
    ld [wC8F5], a
    ld [wC8FA], a
    xor a, a
    ldh [hFF8D], a
    ld a, $4D
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ld a, $01
    ldh [hMapScreenY], a
    ld a, $40
    ld [wC8C8], a
    ld a, $E0
    ld [wC8C9], a
    ld a, $01
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

Jump_00F_65D6::
    ld a, $0F
    ldh [hFF8D], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_65DF::
    ld hl, wC923
    inc [hl]
    ld a, $07
    ldh [hFF8D], a
    ld a, [wC6FD]
    dec a
    dec a
    ret nz
    ld a, $0F
    ld [wC923], a
    ret

Jump_00F_65F3::
    ld hl, wC923
    inc [hl]
    ld a, $03
    ldh [hFF8D], a
    ld a, [wC6FD]
    dec a
    ret nz
    ld a, $0F
    ld [wC923], a
    ret

Jump_00F_6606::
    ld a, $6A
    ld [wC240], a
    ld [wC241], a
    ld [wC254], a
    ld [wC255], a
    farcall Func_05F_6DDB
    ld a, $01
    ldh [hFF8D], a
    ld a, $65
    call QueueSoundEffect
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6628::
    ld a, [wCB9A]
    cp a, $40
    jr z, Jump_00F_6645
    ld a, $60
    ld [wC928], a
    ld a, $01
    ld [wC929], a
    ld a, $81
    ld [wC92A], a
    farcall Func_05F_6B54
    ret

Jump_00F_6645::
    ld a, $A0
    ld [wC928], a
    ld a, $01
    ld [wC929], a
    ld a, $80
    ld [wC92A], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, $035B
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_666A::
    ld a, $02
    ld [wCB96], a
    ld de, wCB9B
    call Func_00F_7F0B
    ret

Jump_00F_6676::
    ld hl, $035A
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4D24)
; reads: wC923
Func_00F_6681::
    ld a, [wC923]
    rst $00
    dw Jump_00F_6767
    dw Jump_00F_6750
    dw Jump_00F_66F4
    dw Jump_00F_7F89
    dw Jump_00F_66B6
    dw Jump_00F_6750
    dw Jump_00F_66A1
    dw Jump_00F_6D00
    dw Jump_00F_6D00
    dw Jump_00F_6D00
    dw Jump_00F_669B

Jump_00F_669B::
    ld a, $80
    ld [wC919], a
    ret

Jump_00F_66A1::
    ld a, $10
    ld [wC928], a
    farcall Func_05F_6A94
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_66B6::
    ld a, $80
    ld [wC928], a
    farcall Func_05F_6A94
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $80
    ld [wC468], a
    ld a, $08
    ld [wC46A], a
    ld hl, hMapScreenY
    inc [hl]
    ldh a, [hFF8C]
    or a, $01
    ldh [hFF8C], a
    ld hl, hFF80
    ld a, l
    ldh [hFF9D], a
    ld a, h
    ldh [hFF9E], a
    farcall UpdatePlayerMovement
    farcall Func_002_5BD7
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_66F4::
    ld a, [wCB9B]
    cp a, $60
    jr z, Jump_00F_6712
    ld a, $60
    ld [wC928], a
    ld a, $01
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    farcall Func_05F_6B54
    jr Jump_00F_6735

Jump_00F_6712::
    ld a, [wCB9A]
    cp a, $30
    jr z, Jump_00F_6730
    ld a, $30
    ld [wC928], a
    ld a, $01
    ld [wC929], a
    ld a, $03
    ld [wC92A], a
    farcall Func_05F_6B54
    jr Jump_00F_6735

Jump_00F_6730::
    ld a, $01
    ld [wCB96], a

Jump_00F_6735::
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6AEB
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, $0322
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6750::
    farcall UpdatePlayerMovement
    farcall Func_002_5BD7
    ld a, [wC468]
    bit 7, a
    ret nz
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6767::
    ld a, $01
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    ld a, $E0
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, $00
    ld [wC928], a
    farcall Func_05F_6AEB
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $80
    ld [wC468], a
    ld a, $04
    ld [wC46A], a
    ld hl, hMapScreenY
    dec [hl]
    ldh a, [hFF8C]
    or a, $01
    ldh [hFF8C], a
    ld hl, $0080
    ld a, l
    ldh [hFF9D], a
    ld a, h
    ldh [hFF9E], a
    farcall UpdatePlayerMovement
    farcall Func_002_5BD7
    ld hl, wC923
    inc [hl]
    ret

; 2 call sites from 2 routines (e.g. Func_010_4CF3, Func_010_4D01)
; reads: wC923
Func_00F_67BA::
    ld a, [wC923]
    rst $00
    dw Jump_00F_6D07
    dw Jump_00F_6D00
    dw Jump_00F_6D00
    dw Jump_00F_6D00
    dw Jump_00F_6CAB
    dw Jump_00F_7F89
    dw Jump_00F_6BF6
    dw Jump_00F_6BBA
    dw Jump_00F_6BA3
    dw Jump_00F_6B99
    dw Jump_00F_7F89
    dw Jump_00F_6B4B
    dw Jump_00F_6B31
    dw Jump_00F_7F89
    dw Jump_00F_6ADD
    dw Jump_00F_6AD3
    dw Jump_00F_7F89
    dw Jump_00F_6ABC
    dw Jump_00F_6AB2
    dw Jump_00F_7F89
    dw Jump_00F_6AA1
    dw Jump_00F_6A9B
    dw Jump_00F_6AA1
    dw Jump_00F_6A9B
    dw Jump_00F_6AA1
    dw Jump_00F_6A9B
    dw Jump_00F_6AA1
    dw Jump_00F_6A9B
    dw Jump_00F_6AA1
    dw Jump_00F_6A9B
    dw Jump_00F_6A77
    dw Jump_00F_6A3F
    dw Jump_00F_6A21
    dw Jump_00F_69D5
    dw Jump_00F_69A6
    dw Jump_00F_7F89
    dw Jump_00F_693F
    dw Jump_00F_6924
    dw Jump_00F_6910
    dw Jump_00F_6905
    dw Jump_00F_68EB
    dw Jump_00F_7F89
    dw Jump_00F_68E0
    dw Jump_00F_7F89
    dw Jump_00F_689B
    dw Jump_00F_6894
    dw Jump_00F_6866
    dw Jump_00F_6845
    dw Jump_00F_7F89
    dw Jump_00F_6822

Jump_00F_6822::
    ld de, $0022
    call SetFlagBit
    ld a, $03
    ldh [hFFC6], a
    farcall Func_05F_6DAC
    ld a, [wCC37]
    set 2, a
    ld [wCC37], a
    ld a, $02
    ld [wC7C7], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00F_6845::
    ldh a, [hPlayerY]
    ld c, a
    ld a, [wCBD4]
    inc a
    ld [wCBD4], a
    cp a, c
    ret nz
    xor a, a
    ld [wCBCF], a
    ld hl, $0DC1
    call StoreHLInWC924_B0F
    ld de, $001F
    call SetFlagBit
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6866::
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ld [wCB86], a
    ld a, $11
    ldh [hFFC6], a
    farcall Func_012_6B98
    ldh a, [hPlayerX]
    ld [wCBD3], a
    ldh a, [hPlayerY]
    sub a, $20
    ld [wCBD4], a
    ld a, $80
    ld [wCBCF], a
    ld a, $85
    call QueueSoundEffect
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6894::
    farcall Func_05F_7363
    ret

Jump_00F_689B::
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wC8C8], a
    ld a, $30
    ld [wC8C9], a
    ld a, $01
    ld [wC8C6], a
    xor a, a
    ld [wCCE9], a
    farcall Func_05F_6C5A
    ld a, $50
    ld [wCBD3], a
    ld a, $30
    ld [wCBD4], a
    ld hl, $02A7
    call StoreHLInWC924_B0F
    xor a, a
    ld [wC92D], a
    ld hl, hFF8C
    call ClearBit2AtHL_Bank0F
    ldh a, [hFF8C]
    and a, $BF
    ldh [hFF8C], a
    ret

Jump_00F_68E0::
    ld hl, $0873
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_68EB::
    ld hl, wCBD4
    inc [hl]
    ld de, wCBD4
    call Func_00F_7EE9
    ret nc
    xor a, a
    ld [wCBCF], a
    ld hl, $0872
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6905::
    ld b, $1E
    call StepWC921Counter_Bank0F
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6910::
    ld hl, wCBD3
    inc [hl]
    ld hl, wCBD4
    dec [hl]
    ld de, wCBD4
    call Func_00F_7EE9
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6924::
    ld a, $50
    ld [wC928], a
    farcall Func_05F_6B17
    ld a, [wC92C]
    or a, a
    ret z
    ld de, $005F
    call SetFlagBit
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_693F::
    ld a, [wC921]
    or a, a
    jr nz, Jump_00F_6951
    ld a, $83
    ld [wC92A], a
    ld a, $70
    ld [wC928], a
    jr Jump_00F_6979

Jump_00F_6951::
    dec a
    jr nz, Jump_00F_6960
    ld a, $82
    ld [wC92A], a
    ld a, $30
    ld [wC928], a
    jr Jump_00F_6979

Jump_00F_6960::
    dec a
    jr nz, Jump_00F_696F
    ld a, $83
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    jr Jump_00F_6979

Jump_00F_696F::
    ld a, $82
    ld [wC92A], a
    ld a, $00
    ld [wC928], a

Jump_00F_6979::
    ld a, $00
    ld [wC929], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $04
    ret nz
    xor a, a
    ld [wSpriteSlotCount], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    farcall Func_002_6050
    ret

Jump_00F_69A6::
    ld a, [wC921]
    srl a
    srl a
    srl a
    and a, $03
    ld [wCB86], a
    ld b, $38
    call StepWC921Counter_Bank0F
    ret nc
    ld de, Data_07D_42BD
    ld b, $7D
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $03
    ld [wCB81], a
    ld hl, $0871
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_69D5::
    ld a, [wC921]
    or a, a
    jr nz, Jump_00F_69F0
    ld a, $10
    ld [wC928], a
    farcall Func_05F_6A94
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC921
    inc [hl]
    ret

Jump_00F_69F0::
    dec a
    jr nz, Jump_00F_6A08
    ld a, $80
    ld [wC928], a
    farcall Func_05F_6ABF
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC921
    inc [hl]
    ret

Jump_00F_6A08::
    ld a, $30
    ld [wC928], a
    farcall Func_05F_6A94
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6A21::
    ld a, [wCBD4]
    dec a
    dec a
    ld [wCBD4], a
    ld de, wCBD4
    call Func_00F_7EE9
    ret nc
    ld a, $65
    call QueueSoundEffect
    ld a, $01
    ld [wSpriteSlotCount], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6A3F::
    ld a, [wC921]
    inc a
    ld [wC921], a
    push af
    bit 4, a
    jr z, Jump_00F_6A4F
    ld a, $01
    jr Jump_00F_6A51

Jump_00F_6A4F::
    ld a, $03

Jump_00F_6A51::
    ld [wCB96], a
    inc a
    inc a
    and a, $03
    ld [wCBA6], a
    pop af
    cp a, $78
    ret nz
    ld a, $80
    ld [wCBCF], a
    ld a, $65
    call QueueSoundEffect
    ld a, $E0
    ld [wCB9A], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6A77::
    ld a, [wCC39]
    set 3, a
    ld [wCC39], a
    ld de, $007F
    call SetFlagBit
    ldh a, [hPlayerX]
    ld [wC8C8], a
    ldh a, [hPlayerY]
    ld [wC8C9], a
    ld a, $00
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

Jump_00F_6A9B::
    ld b, $0F
    call Func_00F_72A0
    ret

Jump_00F_6AA1::
    ld de, wCBAB
    call Func_00F_7EE9
    ret nc
    ld a, $63
    call QueueSoundEffect
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6AB2::
    ld de, wCBAB
    ld hl, $0870
    call Func_00F_7F24
    ret

Jump_00F_6ABC::
    ld a, [wCBD4]
    inc a
    ld [wCBD4], a
    ld de, wCBD4
    call Func_00F_7EE9
    ret nc
    xor a, a
    ld [wCBCF], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6AD3::
    ld de, wCB8B
    ld hl, $086F
    call Func_00F_7F24
    ret

Jump_00F_6ADD::
    xor a, a
    ld [wCB80], a
    ld a, $E3
    ld [wCB81], a
    ldh [hFFC6], a
    xor a, a
    ldh [hFFC7], a
    ld a, $00
    ldh [hFFC8], a
    ld a, $05
    ldh [hFFC9], a
    ld hl, vTiles0 + $500
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    farcall Func_004_431F
    xor a, a
    ld [wCB90], a
    ld a, $D6
    ld [wCB91], a
    ldh [hFFC6], a
    xor a, a
    ldh [hFFC7], a
    ld a, $00
    ldh [hFFC8], a
    ld a, $06
    ldh [hFFC9], a
    ld hl, vTiles0 + $600
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    farcall Func_004_431F
    ld a, $7F
    ld [wC527], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6B31::
    ld a, [wCBD4]
    dec a
    dec a
    ld [wCBD4], a
    ld de, wCBD4
    call Func_00F_7EE9
    ret nc
    ld hl, $086E
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6B4B::
    ld a, $00
    ld [wC929], a
    ld a, $00
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, $01
    ld [wC929], a
    ld a, $00
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $08
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $40
    ld [wCBD3], a
    ld a, $60
    ld a, a
    ld [wCBD4], a
    ld a, $80
    ld [wCBCF], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6B99::
    ld de, wCBAB
    ld hl, $086D
    call Func_00F_7F24
    ret

Jump_00F_6BA3::
    ld a, [wCBAA]
    cp a, $80
    jr z, Jump_00F_6BAF
    inc a
    inc a
    ld [wCBAA], a

Jump_00F_6BAF::
    ld b, $3C
    call StepWC921Counter_Bank0F
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6BBA::
    ld a, [wC922]
    or a, a
    jr nz, Jump_00F_6BDA
    ld a, [wC921]
    inc a
    ld [wC921], a
    and a, $03
    ret nz
    ld a, [wCB9A]
    dec a
    ld [wCB9A], a
    cp a, $30
    ret nz
    ld a, $01
    ld [wC922], a
    ret

Jump_00F_6BDA::
    ld a, [wCB9A]
    inc a
    inc a
    ld [wCB9A], a
    cp a, $40
    ret nz
    ld a, $63
    call QueueSoundEffect
    xor a, a
    ld [wC921], a
    ld [wC922], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6BF6::
    ld hl, wCB9C
    call SetBit2AtHL_B0F
    ld a, [wC921]
    or a, a
    jr nz, Jump_00F_6C17
    ld a, $03
    ld [wCB96], a
    ld a, [wCB9A]
    dec a
    dec a
    ld [wCB9A], a
    cp a, $40
    ret nz
    ld hl, wC921
    inc [hl]
    ret

Jump_00F_6C17::
    dec a
    jr nz, Jump_00F_6C2F
    ld a, $00
    ld [wCB96], a
    ld a, [wCB9B]
    inc a
    inc a
    ld [wCB9B], a
    cp a, $50
    ret nz
    ld hl, wC921
    inc [hl]
    ret

Jump_00F_6C2F::
    dec a
    jr nz, Jump_00F_6C47
    ld a, $01
    ld [wCB96], a
    ld a, [wCB9A]
    inc a
    inc a
    ld [wCB9A], a
    cp a, $60
    ret nz
    ld hl, wC921
    inc [hl]
    ret

Jump_00F_6C47::
    dec a
    jr nz, Jump_00F_6C5F
    ld a, $02
    ld [wCB96], a
    ld a, [wCB9B]
    dec a
    dec a
    ld [wCB9B], a
    cp a, $30
    ret nz
    ld hl, wC921
    inc [hl]
    ret

Jump_00F_6C5F::
    dec a
    jr nz, Jump_00F_6C77
    ld a, $03
    ld [wCB96], a
    ld a, [wCB9A]
    dec a
    dec a
    ld [wCB9A], a
    cp a, $40
    ret nz
    ld hl, wC921
    inc [hl]
    ret

Jump_00F_6C77::
    ld a, $00
    ld [wCB96], a
    ld a, [wCB9B]
    inc a
    inc a
    ld [wCB9B], a
    cp a, $40
    ret nz
    ld a, $01
    ld [wCB96], a
    ld hl, wCB9C
    call ClearBit2AtHL_Bank0F
    ld de, Data_07D_7705
    ld b, $7D
    ld hl, vTiles0 + $700
    call DecompressToVRAM
    ld a, $45
    ld [wCBA1], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6CAB::
    ld a, $00
    ld [wC929], a
    ld a, $80
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, $01
    ld [wC929], a
    ld a, $80
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, $02
    ld [wC929], a
    ld a, $80
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    farcall Func_05F_6E09
    ld hl, $086C
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6D00::
    farcall Func_012_61EF
    ret

Jump_00F_6D07::
    ldh a, [hPlayerX]
    cp a, $40
    jr nz, Jump_00F_6D13
    ld a, $04
    ld [wC923], a
    ret

Jump_00F_6D13::
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6B17
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ldh [hPlayerFacing], a
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4CEC)
; reads: wC923
Func_00F_6D2B::
    ld a, [wC923]
    rst $00
    dw Jump_00F_6F4C
    dw Jump_00F_6F4C
    dw Jump_00F_6F4C
    dw Jump_00F_6EB0
    dw Jump_00F_6F0C
    dw Jump_00F_6EF0
    dw Jump_00F_6ECD
    dw Jump_00F_6EB0
    dw Jump_00F_6E54
    dw Jump_00F_6E31
    dw Jump_00F_6DD1
    dw Jump_00F_6D80
    dw Jump_00F_6D49

Jump_00F_6D49::
    call Func_00F_6D4D
    ret

; 2 call sites from 2 routines (e.g. Func_00F_6D2B, Func_00F_6D4D)
; reads: wC921, wCBD3
; writes: wC921, wCBD4, wC919
; points at: wCBD3
Func_00F_6D4D::
    ld hl, wCBD3
    inc [hl]
    ld a, [wC921]
    inc a
    and a, $07
    ld [wC921], a
    ld hl, $6D78
    add_a_to_hl
    ld a, [hl]
    ld [wCBD4], a
    ld a, [wCBD3]
    cp a, $A0
    ret nz
    ld de, $007E
    call SetFlagBit
    ld a, $80
    ld [wC919], a
    ret
    db $40, $3F, $40, $3F, $40, $3E, $40, $41

Jump_00F_6D80::
    call Func_00F_6D4D
    ld a, $00
    ld [wC929], a
    ld a, $81
    ld [wC92A], a
    ld a, $A0
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, $01
    ld [wC929], a
    ld a, $81
    ld [wC92A], a
    ld a, $A0
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, $02
    ld [wC929], a
    ld a, $81
    ld [wC92A], a
    ld a, $A0
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wCBAA]
    cp a, $A0
    ret nz
    xor a, a
    ld [wSpriteSlotCount], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6DD1::
    ld de, wCB8B
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld de, wCB9B
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld de, wCBAB
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld a, [wFrameCounterLo]
    and a, $03
    bit 0, a
    jr nz, Jump_00F_6E16
    dec a
    sla a
    ld c, a
    ldh a, [hScrollX]
    add a, c
    ldh [hScrollX], a

Jump_00F_6E16::
    ld b, $20
    call StepWC921Counter_Bank0F
    ret nc
    ldh a, [hScrollX]
    add a, $07
    and a, $F8
    ldh [hScrollX], a
    ld a, $7D
    call QueueSoundEffect
    ld hl, wC923
    inc [hl]
    xor a, a
    ldh [hFF8D], a
    ret

Jump_00F_6E31::
    ld a, [wCBD4]
    inc a
    inc a
    ld [wCBD4], a
    cp a, $40
    ret nz
    farcall Func_05F_6E09
    ld a, $66
    call QueueSoundEffect
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ld a, $0E
    ldh [hFF8D], a
    ret

Jump_00F_6E54::
    ld b, $03
    ld hl, wCB8B

Jump_00F_6E59::
    push hl
    ld a, [hl]
    cp a, $40
    jr z, Jump_00F_6E64
    dec a
    dec a
    ld [hl], a
    jr Jump_00F_6E6F

Jump_00F_6E64::
    dec hl
    ld a, [hl]
    dec a
    dec a
    ld [hl], a
    dec hl
    dec hl
    dec hl
    dec hl
    ld [hl], $03

Jump_00F_6E6F::
    pop hl
    ld a, $10
    add_a_to_hl
    dec b
    jr nz, Jump_00F_6E59
    ld a, [wCB8A]
    cp a, $40
    ret nz
    ld a, $03
    ld [wCBA6], a
    ld hl, wCB8C
    call ClearBit2AtHL_Bank0F
    ld hl, wCB9C
    call ClearBit2AtHL_Bank0F
    ld hl, wCBAC
    call ClearBit2AtHL_Bank0F
    ld a, $07
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $80
    ld [wCBCF], a
    ld a, $65
    call QueueSoundEffect
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6EB0::
    ld b, $3C
    call StepWC921Counter_Bank0F
    ret nc
    ld hl, wCB8C
    call SetBit2AtHL_B0F
    ld hl, wCB9C
    call SetBit2AtHL_B0F
    ld hl, wCBAC
    call SetBit2AtHL_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6ECD::
    ldh a, [hPlayerY]
    call Func_00F_7ED8
    ldh a, [hPlayerY]
    call Func_00F_7ED8
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $1E
    ret nz
    ld hl, hFF8C
    call ClearBit1AtHL_Bank0F
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6EF0::
    ldh a, [hPlayerY]
    call Func_00F_7ED8
    ldh a, [hPlayerY]
    dec a
    ldh [hPlayerY], a
    ldh a, [hPlayerY]
    call Func_00F_7ED8
    ldh a, [hPlayerY]
    dec a
    ldh [hPlayerY], a
    cp a, $30
    ret nz
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6F0C::
    xor a, a
    ldh [hPlayerFacing], a
    ld a, [wCBAB]
    dec a
    dec a
    ld [wCBAB], a
    ld a, [wCB9B]
    dec a
    dec a
    ld [wCB9B], a
    ld a, [wCB8B]
    dec a
    dec a
    ld [wCB8B], a
    cp a, $70
    ret nz
    ld hl, wCB8C
    call ClearBit2AtHL_Bank0F
    ld hl, wCB9C
    call ClearBit2AtHL_Bank0F
    ld hl, wCBAC
    call ClearBit2AtHL_Bank0F
    ld hl, hFF8C
    call SetBit1AtHL_Bank0F
    ld a, $63
    call QueueSoundEffect
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6F4C::
    farcall Func_012_61EF
    ld hl, wCB8C
    call SetBit2AtHL_B0F
    ld hl, wCB9C
    call SetBit2AtHL_B0F
    ld hl, wCBAC
    call SetBit2AtHL_B0F
    ret

; 1 call site from 1 routine (e.g. Func_010_4CE5)
; reads: wC923
Func_00F_6F65::
    ld a, [wC923]
    rst $00
    dw Jump_00F_7002
    dw Jump_00F_6FB5
    dw Jump_00F_6F9A
    dw Jump_00F_6F71

Jump_00F_6F71::
    ld a, [wC921]
    inc a
    ld [wC921], a
    push af
    bit 4, a
    jr z, Jump_00F_6F81
    ld a, $01
    jr Jump_00F_6F83

Jump_00F_6F81::
    ld a, $03

Jump_00F_6F83::
    ld [wCB86], a
    ld [wCBA6], a
    inc a
    inc a
    and a, $03
    ld [wCB96], a
    pop af
    cp a, $78
    ret nz
    ld a, $80
    ld [wC919], a
    ret

Jump_00F_6F9A::
    ld hl, wCB8C
    call SetBit2AtHL_B0F
    ld hl, wCB9C
    call SetBit2AtHL_B0F
    ld hl, wCBAC
    call SetBit2AtHL_B0F
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_6FB5::
    ld a, [wFrameCounterLo]
    and a, $03
    bit 0, a
    jr nz, Jump_00F_6FC7
    dec a
    sla a
    ld c, a
    ldh a, [hScrollX]
    add a, c
    ldh [hScrollX], a

Jump_00F_6FC7::
    ld b, $78
    call StepWC921Counter_Bank0F
    ret nc
    ldh a, [hScrollX]
    add a, $07
    and a, $F8
    ldh [hScrollX], a
    ld de, $007D
    call SetFlagBit
    ld a, [wCC39]
    set 2, a
    ld [wCC39], a
    ldh a, [hPlayerX]
    ld [wC8C8], a
    ldh a, [hPlayerY]
    ld [wC8C9], a
    ld a, $00
    ld [wC8C6], a
    xor a, a
    ld [wC8C7], a
    farcall Func_05F_6C5A
    ld a, $00
    call QueueSoundEffect
    ret

Jump_00F_7002::
    ld hl, wCB8C
    call SetBit2AtHL_B0F
    ld hl, wCB9C
    call SetBit2AtHL_B0F
    ld hl, wCBAC
    call SetBit2AtHL_B0F
    ld b, $03
    ld hl, wCB8A

Jump_00F_7019::
    ld a, [hl]
    inc a
    inc a
    ld [hl], a
    ld a, $10
    add_a_to_hl
    dec b
    jr nz, Jump_00F_7019
    ld a, [wCB8A]
    cp a, $60
    ret nz
    ld hl, wCB8C
    call ClearBit2AtHL_Bank0F
    ld hl, wCB9C
    call ClearBit2AtHL_Bank0F
    ld hl, wCBAC
    call ClearBit2AtHL_Bank0F
    ld a, $7D
    call QueueSoundEffect
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4CDE)
; reads: wC923
Func_00F_7049::
    ld a, [wC923]
    rst $00
    dw Jump_00F_7051
    dw Jump_00F_706C

Jump_00F_7051::
    ld hl, wCB8C
    call SetBit2AtHL_B0F
    ld hl, wCB9C
    call SetBit2AtHL_B0F
    ld hl, wCBAC
    call SetBit2AtHL_B0F
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_706C::
    ld b, $03
    ld hl, wCB8B

Jump_00F_7071::
    ld a, [hl]
    cp a, $E0
    jr z, Jump_00F_7079
    dec a
    dec a
    ld [hl], a

Jump_00F_7079::
    ld a, $10
    add_a_to_hl
    dec b
    jr nz, Jump_00F_7071
    ld a, [wCBAB]
    cp a, $E0
    ret nz
    xor a, a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4CC2)
; reads: wC923
Func_00F_7093::
    ld a, [wC923]
    rst $00
    dw Jump_00F_7099

Jump_00F_7099::
    ld de, $0075
    call TestFlagBit
    jr c, Jump_00F_70BD
    ld a, $00
    ldh [hFFC6], a
    ld a, $20
    ldh [hFFC7], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    xor a, a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00F_70BD::
    ld a, $00
    ldh [hFFC6], a
    ld a, $40
    ldh [hFFC7], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    ld de, $009B
    call TestFlagBit
    jr nc, Jump_00F_70E2
    ld a, $33
    ld [wC928], a
    farcall Func_05F_6C8C

Jump_00F_70E2::
    xor a, a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4C83)
; reads: wC923
Func_00F_70EC::
    ld a, [wC923]
    rst $00
    dw Jump_00F_7225
    dw Jump_00F_7210
    dw Jump_00F_7F89
    dw Jump_00F_7209
    dw Jump_00F_71DD
    dw Jump_00F_7F89
    dw Jump_00F_7198
    dw Jump_00F_714A
    dw Jump_00F_712A
    dw Jump_00F_7104

Jump_00F_7104::
    ldh a, [hPlayerX]
    call Func_00F_7ED8
    ldh a, [hPlayerX]
    call Func_00F_7ED8
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $1E
    ret nz
    ldh a, [hFF8C]
    and a, $FD
    ldh [hFF8C], a
    ld de, $0064
    call SetFlagBit
    ld a, $80
    ld [wC919], a
    ret

Jump_00F_712A::
    ldh a, [hPlayerX]
    call Func_00F_7ED8
    ldh a, [hPlayerX]
    inc a
    ldh [hPlayerX], a
    ldh a, [hPlayerX]
    call Func_00F_7ED8
    ldh a, [hPlayerX]
    inc a
    ldh [hPlayerX], a
    cp a, $70
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_714A::
    ld a, [wC922]
    or a, a
    jr nz, Jump_00F_716A
    ld a, [wC921]
    inc a
    ld [wC921], a
    and a, $03
    ret nz
    ld a, [wCB8A]
    dec a
    ld [wCB8A], a
    cp a, $20
    ret nz
    ld a, $01
    ld [wC922], a
    ret

Jump_00F_716A::
    ld a, $00
    ld [wC929], a
    ld a, $81
    ld [wC92A], a
    ld a, $30
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ldh a, [hFF8C]
    or a, $02
    ldh [hFF8C], a
    ld a, $63
    call QueueSoundEffect
    xor a, a
    ld [wC922], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_7198::
    ld a, [wCB8A]
    cp a, $30
    jr z, Jump_00F_71B5
    ld a, $00
    ld [wC929], a
    ld a, $03
    ld [wC92A], a
    ld a, $30
    ld [wC928], a
    farcall Func_05F_6B54
    ret

Jump_00F_71B5::
    ld a, $00
    ld [wC929], a
    ld a, $00
    ld [wC92A], a
    ld a, $70
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $01
    ld [wCB86], a
    ld a, $03
    ldh [hPlayerFacing], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_71DD::
    xor a, a
    ld [wCB96], a
    ld [wCBA6], a
    ld a, $00
    ld [wC929], a
    ld a, $00
    ld [wC92A], a
    ld a, $60
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, $0833
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_7209::
    ld de, wCB8B
    call Func_00F_7F0B
    ret

Jump_00F_7210::
    xor a, a
    call Func_00F_7F75
    ret nc
    ld a, $01
    ld [wCB96], a
    ld hl, $0832
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_7225::
    ld hl, wCB8C
    call SetBit2AtHL_B0F
    ld hl, wCB9C
    call SetBit2AtHL_B0F
    ld hl, wCBAC
    call SetBit2AtHL_B0F
    ld hl, wCB8B
    ld b, $03

Jump_00F_723C::
    ld a, [hl]
    inc a
    ld [hl], a
    ld a, $10
    add_a_to_hl
    dec b
    jr nz, Jump_00F_723C
    ld a, [wCB8B]
    cp a, $40
    ret nz
    ld hl, wCB8C
    call ClearBit2AtHL_Bank0F
    ld hl, wCB9C
    call ClearBit2AtHL_Bank0F
    ld hl, wCBAC
    call ClearBit2AtHL_Bank0F
    ld a, $03
    ld [wCBA6], a
    ld hl, $0831
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4C7C)
; reads: wC923
Func_00F_7271::
    ld a, [wC923]
    rst $00
    dw Jump_00F_727B
    dw Jump_00F_728B
    dw Jump_00F_7291

Jump_00F_727B::
    farcall Func_05F_6E09
    ld a, $7D
    call QueueSoundEffect
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_728B::
    ld b, $78
    call Func_00F_72A0
    ret

Jump_00F_7291::
    ld a, $00
    call QueueSoundEffect
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_073_6882)
; reads: wC928, wFrameCounterLo, hScrollX, hScrollXHi
; writes: hScrollX, hScrollXHi
; points at: wC923
Func_00F_729C::
    ld a, [wC928]
    ld b, a

; 7 call sites from 6 routines (e.g. Func_00F_7271, Func_00F_67BA, Func_00F_60E6, Func_00F_631F, ...)
; reads: wFrameCounterLo, hScrollX, hScrollXHi
; writes: hScrollX, hScrollXHi
; points at: wC923
Func_00F_72A0::
    ld a, [wFrameCounterLo]
    and a, $03
    bit 0, a
    jr nz, Jump_00F_72CB
    dec a
    add a, a
    ld c, a
    bit 7, a
    jr z, Jump_00F_72C0
    cpl
    inc a
    ld c, a
    ldh a, [hScrollX]
    sub a, c
    ldh [hScrollX], a
    ldh a, [hScrollXHi]
    sbc a, $00
    ldh [hScrollXHi], a
    jr Jump_00F_72CB

Jump_00F_72C0::
    ldh a, [hScrollX]
    add a, c
    ldh [hScrollX], a
    ldh a, [hScrollXHi]
    adc a, $00
    ldh [hScrollXHi], a

Jump_00F_72CB::
    call StepWC921Counter_Bank0F
    ret nc
    xor a, a
    ldh [hScrollX], a
    ldh [hScrollXHi], a
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4C75)
; reads: wC923
Func_00F_72D9::
    ld a, [wC923]
    rst $00
    dw Jump_00F_7601
    dw Jump_00F_75C3
    dw Jump_00F_7F89
    dw Jump_00F_75AA
    dw Jump_00F_6F4C
    dw Jump_00F_6F4C
    dw Jump_00F_6F4C
    dw Jump_00F_756F
    dw Jump_00F_7F89
    dw Jump_00F_7546
    dw Jump_00F_753B
    dw Jump_00F_7F89
    dw Jump_00F_7546
    dw Jump_00F_7530
    dw Jump_00F_7F89
    dw Jump_00F_74F7
    dw Jump_00F_749D
    dw Jump_00F_7473
    dw Jump_00F_7F89
    dw Jump_00F_7450
    dw Jump_00F_743A
    dw Jump_00F_7F89
    dw Jump_00F_740C
    dw Jump_00F_7F89
    dw Jump_00F_7401
    dw Jump_00F_7F89
    dw Jump_00F_73D8
    dw Jump_00F_7F89
    dw Jump_00F_73CD
    dw Jump_00F_7F89
    dw Jump_00F_739E
    dw Jump_00F_7397
    dw Jump_00F_7369
    dw Jump_00F_7348
    dw Jump_00F_7F89
    dw Jump_00F_7325

Jump_00F_7325::
    ld de, $0021
    call SetFlagBit
    ld a, $02
    ldh [hFFC6], a
    farcall Func_05F_6DAC
    ld a, [wCC37]
    set 1, a
    ld [wCC37], a
    ld a, $01
    ld [wC7C7], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00F_7348::
    ldh a, [hPlayerY]
    ld c, a
    ld a, [wCBD4]
    inc a
    ld [wCBD4], a
    cp a, c
    ret nz
    xor a, a
    ld [wCBCF], a
    ld hl, $0DC0
    call StoreHLInWC924_B0F
    ld de, $001D
    call SetFlagBit
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_7369::
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ld [wCB86], a
    ld a, $11
    ldh [hFFC6], a
    farcall Func_012_6B98
    ldh a, [hPlayerX]
    ld [wCBD3], a
    ldh a, [hPlayerY]
    sub a, $20
    ld [wCBD4], a
    ld a, $80
    ld [wCBCF], a
    ld a, $85
    call QueueSoundEffect
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_7397::
    farcall Func_05F_7363
    ret

Jump_00F_739E::
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wC8C8], a
    ld a, $30
    ld [wC8C9], a
    ld a, $01
    ld [wC8C6], a
    xor a, a
    ld [wCCE9], a
    farcall Func_05F_6C5A
    ld hl, $0125
    call StoreHLInWC924_B0F
    xor a, a
    ld [wC92D], a
    ret

Jump_00F_73CD::
    ld hl, $01A2
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_73D8::
    ld a, $00
    ld [wC929], a
    ld a, $00
    ld [wC92A], a
    ld a, $A0
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wSpriteSlotCount], a
    ld hl, $01A1
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_7401::
    ld hl, $01A0
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_740C::
    ld hl, wCBD3
    dec [hl]
    ld hl, wCBD4
    inc [hl]
    ld de, wCBD4
    call Func_00F_7EE9
    ret nc
    ld hl, $019F
    call StoreHLInWC924_B0F
    xor a, a
    ld [wCBCF], a
    ld a, [wC933]
    ld [wC6FD], a
    ld a, $50
    ld [wCBD3], a
    ld a, $30
    ld [wCBD4], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_743A::
    ld hl, wCBD4
    dec [hl]
    ld de, wCBD4
    call Func_00F_7EE9
    ret nc
    ld hl, $019E
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_7450::
    ld a, $40
    ld [wCBD3], a
    ld a, $20
    ld [wCBD4], a
    ld a, $80
    ld [wCBCF], a
    ld a, [wC6FD]
    ld [wC933], a
    cp a, $03
    jr nz, Jump_00F_746E
    ld a, $02
    ld [wC6FD], a

Jump_00F_746E::
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_7473::
    ld a, $00
    ld [wC929], a
    ld a, $00
    ld [wC92A], a
    ld a, $20
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, $019D
    call StoreHLInWC924_B0F
    ld a, $03
    ld [wCB86], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_749D::
    ld a, $00
    ld [wC92A], a
    ld a, $A0
    ld [wC928], a
    ld a, $00
    ld [wC929], a
    farcall Func_05F_6B54
    ld a, $01
    ld [wC929], a
    farcall Func_05F_6B54
    ld a, $02
    ld [wC929], a
    farcall Func_05F_6B54
    ld a, $03
    ld [wC929], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $01
    ld [wSpriteSlotCount], a
    ld de, Data_07D_5B5F
    ld b, $7D
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $22
    ld [wCB81], a
    ld a, $E0
    ld [wCB8B], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_74F7::
    ld a, $E0
    ld [wCBAB], a
    ld a, $B0
    ld [wCBBB], a
    ld a, $D0
    ld [wCB8B], a
    ld a, $C0
    ld [wCB9B], a
    ld de, Data_07D_5F6E
    ld b, $7D
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $27
    ld [wCB81], a
    ld de, Data_07D_5F6E
    ld b, $7D
    ld hl, vTiles0 + $600
    call DecompressToVRAM
    ld a, $27
    ld [wCB91], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_7530::
    ld hl, $019C
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_753B::
    ld hl, $019B
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_7546::
    ld a, [wC921]
    or a, a
    jr nz, Jump_00F_7553
    ld a, $7C
    call QueueSoundEffect
    jr Jump_00F_755C

Jump_00F_7553::
    cp a, $3C
    jr nz, Jump_00F_755C
    ld a, $81
    call QueueSoundEffect

Jump_00F_755C::
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $78
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_756F::
    ld a, $02
    ld [wC92A], a
    ld a, $E0
    ld [wC928], a
    ld a, $01
    ld [wC929], a
    farcall Func_05F_6B54
    ld a, $02
    ld [wC929], a
    farcall Func_05F_6B54
    ld a, $03
    ld [wC929], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, $019A
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_75AA::
    ld a, $30
    ld [wC928], a
    farcall Func_05F_6B17
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $01
    ldh [hPlayerFacing], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_75C3::
    ld a, $02
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    ld a, $03
    ld [wC929], a
    farcall Func_05F_6B54
    ld a, $02
    ld [wC929], a
    farcall Func_05F_6B54
    ld a, $01
    ld [wC929], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ldh [hPlayerFacing], a
    ld hl, $0199
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_7601::
    xor a, a
    ldh [hFFC6], a
    ld a, $10
    ldh [hFFC7], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    ld a, [wCC38]
    set 5, a
    ld [wCC38], a
    ld de, $005A
    call SetFlagBit
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4C59)
; reads: wC923
Func_00F_7625::
    ld a, [wC923]
    rst $00
    dw Jump_00F_7707
    dw Jump_00F_76E3
    dw Jump_00F_766D
    dw Jump_00F_7639
    dw Jump_00F_7633

Jump_00F_7633::
    ld a, $80
    ld [wC919], a
    ret

Jump_00F_7639::
    ld a, $20
    ld [wC928], a
    farcall Func_05F_6B17
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $2E
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $20
    ld [wC8C8], a
    ld a, $60
    ld [wC8C9], a
    ld a, $01
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ld a, $60
    call QueueSoundEffect
    ret

Jump_00F_766D::
    ld a, [wC921]
    and a, $0F
    jr nz, Jump_00F_768B
    ld a, $60
    ld [wC928], a
    farcall Func_05F_6A94
    ld a, [wC92C]
    or a, a
    jr z, Jump_00F_7696
    ld hl, wC921
    inc [hl]
    jr Jump_00F_7696

Jump_00F_768B::
    ld a, $30
    ld [wC928], a
    farcall Func_05F_6B17

Jump_00F_7696::
    ld a, $00
    ld [wC929], a
    ld a, [wC921]
    and a, $F0
    jr nz, Jump_00F_76C0
    ld a, $00
    ld [wC92A], a
    ld a, $60
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, [wC921]
    or a, $10
    ld [wC921], a
    ret

Jump_00F_76C0::
    ld a, $03
    ld [wC92A], a
    ld a, $20
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $E0
    ld [wCB8A], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_76E3::
    ld a, $25
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wC8C8], a
    ld a, $08
    ld [wC8C9], a
    ld a, $01
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ld a, $60
    call QueueSoundEffect
    ret

Jump_00F_7707::
    ldh a, [hPlayerX]
    cp a, $40
    jr z, Jump_00F_7719
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6B17
    ret

Jump_00F_7719::
    ld a, $80
    ld [wC928], a
    farcall Func_05F_6A94
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4C3D)
; reads: wC923
Func_00F_772E::
    ld a, [wC923]
    rst $00
    dw Jump_00F_7746
    dw Jump_00F_776B
    dw Jump_00F_777E
    dw Jump_00F_7F89
    dw Jump_00F_7795
    dw Jump_00F_77C9
    dw Jump_00F_77F1
    dw Jump_00F_7806
    dw Jump_00F_780D
    dw Jump_00F_785B

Jump_00F_7746::
    ld a, $25
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wC8C8], a
    ld a, $30
    ld [wC8C9], a
    ld a, $03
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ld hl, $0151
    call StoreHLInWC924_B0F
    ret

Jump_00F_776B::
    xor a, a
    call Func_00F_7F75
    ret nc
    ld a, $6D
    call QueueSoundEffect
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_777E::
    ld b, $B4
    call StepWC921Counter_Bank0F
    ret nc
    farcall Func_002_604B
    ld hl, $0152
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_7795::
    ld a, $00
    ld [wC928], a
    farcall Func_05F_6AEB
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $26
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wC8C8], a
    ld a, $80
    ld [wC8C9], a
    ld a, $03
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ld a, $60
    call QueueSoundEffect
    ret

Jump_00F_77C9::
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6AEB
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, hFF8C
    call ClearBit2AtHL_Bank0F
    ld a, $02
    ldh [hPlayerFacing], a
    ld a, $6D
    call QueueSoundEffect
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_77F1::
    ld b, $B4
    call StepWC921Counter_Bank0F
    ret nc
    farcall Func_002_604B
    xor a, a
    ld [wC92D], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_7806::
    farcall Func_05F_70D2
    ret

Jump_00F_780D::
    ld a, [wC921]
    or a, a
    jr nz, Jump_00F_781C
    inc a
    ld [wC921], a
    ld a, $6D
    call QueueSoundEffect

Jump_00F_781C::
    ld a, $80
    ld [wC928], a
    farcall Func_05F_6A94
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $25
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $30
    ld [wC8C8], a
    ld a, $40
    ld [wC8C9], a
    ld a, $01
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ld a, $02
    call QueueMusic
    ld a, $60
    call QueueSoundEffect
    xor a, a
    ld [wC921], a
    ret

Jump_00F_785B::
    farcall Func_002_6050
    ld a, [wCC38]
    or a, $01
    ld [wCC38], a
    ld a, $80
    ld [wC919], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4C2F)
; reads: wC923
Func_00F_786F::
    ld a, [wC923]
    rst $00
    dw Jump_00F_7F89
    dw Jump_00F_79EC
    dw Jump_00F_79D1
    dw Jump_00F_7F89
    dw Jump_00F_7968
    dw Jump_00F_7937
    dw Jump_00F_7F89
    dw Jump_00F_790A
    dw Jump_00F_78E7
    dw Jump_00F_78CB
    dw Jump_00F_78B7
    dw Jump_00F_789B
    dw Jump_00F_788D

Jump_00F_788D::
    ld a, [wCC37]
    set 0, a
    ld [wCC37], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00F_789B::
    xor a, a
    call Func_00F_7F75
    ret nc
    ld a, $01
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ld a, $01
    ld [wC6FD], a
    ld de, $0002
    call SetFlagBit
    ret

Jump_00F_78B7::
    xor a, a
    call Func_00F_7F75
    ret nc
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ld hl, $0093
    call StoreHLInWC924_B0F
    ret

Jump_00F_78CB::
    ld de, hPlayerY
    call Func_00F_7EE9
    push af
    ldh a, [hPlayerY]
    ld [wC8F1], a
    pop af
    ret nc
    ld a, $01
    ldh [hPlayerFacing], a
    ld a, $03
    ld [wC8EF], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_78E7::
    xor a, a
    call Func_00F_7F75
    ret nc
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ld de, $0000
    call TestFlagBit
    jr c, Jump_00F_7903
    ld hl, $009A
    call StoreHLInWC924_B0F
    ret

Jump_00F_7903::
    ld hl, $0092
    call StoreHLInWC924_B0F
    ret

Jump_00F_790A::
    ld a, $00
    ld [wC929], a
    ld a, $03
    ld [wC92A], a
    ld a, $70
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wCB86], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ld hl, $0091
    call StoreHLInWC924_B0F
    ret

Jump_00F_7937::
    ld de, wCB8B
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, $20
    ret nz
    ld a, $02
    ldh [hPlayerFacing], a
    ld [wC8EF], a
    ld hl, $0090
    call StoreHLInWC924_B0F
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_7968::
    ld a, [wC921]
    or a, a
    jr nz, Jump_00F_798D
    ld a, $00
    ld [wC929], a
    ld a, $03
    ld [wC92A], a
    ld a, $60
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wC921
    inc [hl]
    ret

Jump_00F_798D::
    ld a, [wCB8B]
    cp a, $40
    jr z, Jump_00F_79AA
    ld a, $00
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6B54
    ret

Jump_00F_79AA::
    ld a, $00
    ld [wC929], a
    ld a, $01
    ld [wC92A], a
    ld a, $78
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wCB86], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_79D1::
    xor a, a
    call Func_00F_7F75
    ret nc
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    dec hl
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    ld hl, wC923
    dec [hl]
    ret

Jump_00F_79EC::
    ld a, [wC552]
    or a, a
    jr nz, Jump_00F_7A12
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    ld h, $80
    inc hl
    inc hl
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_7A12::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    ld h, $C0
    inc hl
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4C28)
; reads: wC923
Func_00F_7A2D::
    ld a, [wC923]
    rst $00
    dw Jump_00F_7AA2
    dw Jump_00F_7A70
    dw Jump_00F_7F89
    dw Jump_00F_7A3B
    dw Jump_00F_7F93

Jump_00F_7A3B::
    ld hl, wC923
    inc [hl]
    ld a, [wC552]
    or a, a
    jr nz, Jump_00F_7A5A
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $40
    ld h, a
    inc hl
    call StoreHLInWC924_B0F
    ret

Jump_00F_7A5A::
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $40
    ld h, a
    inc hl
    inc hl
    call StoreHLInWC924_B0F
    ret

Jump_00F_7A70::
    ld a, $01
    ld [wC8EF], a
    ld a, [wC8F0]
    inc a
    ld [wC8F0], a
    cp a, $80
    ret nz
    ld a, $01
    ldh [hPlayerFacing], a
    ld a, $03
    ld [wC8EF], a
    ld hl, wC923
    inc [hl]
    ld de, $0000
    call TestFlagBit
    jr c, Jump_00F_7A9B
    ld hl, $4094
    call StoreHLInWC924_B0F
    ret

Jump_00F_7A9B::
    ld hl, $4089
    call StoreHLInWC924_B0F
    ret

Jump_00F_7AA2::
    xor a, a
    call Func_00F_7F75
    ret nc
    ld a, $06
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $70
    ld [wC8C8], a
    ld a, $50
    ld [wC8C9], a
    ld a, $02
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

; 1 call site from 1 routine (e.g. Func_010_4EA5)
; reads: wC923
Func_00F_7AC6::
    ld a, [wC923]
    rst $00
    dw Jump_00F_7C84
    dw Jump_00F_7C72
    dw Jump_00F_7C4F
    dw Jump_00F_7C22
    dw Jump_00F_7C22
    dw Jump_00F_7C22
    dw Jump_00F_7C22
    dw Jump_00F_7C22
    dw Jump_00F_7C22
    dw Jump_00F_7C19
    dw Jump_00F_7B3B
    dw Jump_00F_7B2A
    dw Jump_00F_7F89
    dw Jump_00F_7AF9
    dw Jump_00F_7AE8

Jump_00F_7AE8::
    ld a, $0A
    ld [wC917], a
    ld a, $02
    ld [wC916], a
    farcall Func_013_405C
    ret

Jump_00F_7AF9::
    ld a, $00
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    ld a, $02
    ldh [hMapScreenY], a
    ld a, $50
    ld [wC8C8], a
    ld [wC8C9], a
    ld a, $01
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ld de, $001B
    call SetFlagBit
    ld a, $01
    ldh [hFF8B], a
    xor a, a
    ld [wC924], a
    ld [wC925], a
    ret

Jump_00F_7B2A::
    ld b, $78
    call StepWC921Counter_Bank0F
    ret nc
    ld hl, $0014
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_7B3B::
    ld a, [wC921]
    inc a
    ld [wC921], a
    and a, $03
    ret nz
    ldh a, [hScrollY]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $98
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add a, e
    ld e, a
    jr nc, Jump_00F_7B69
    inc d

Jump_00F_7B69::
    ld a, e
    sub a, $20
    ld e, a
    ld a, d
    sbc a, $00
    ld d, a
    ld a, d
    cp a, $97
    jr nz, Jump_00F_7B7E
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $04
    ld d, a

Jump_00F_7B7E::
    ld a, [wC469]
    srl a
    srl a
    srl a
    ld c, a
    ld a, $11
    sub a, c
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add_a_to_hl
    add hl, hl
    add hl, hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    call Func_00F_7BC3
    ldh a, [hScrollY]
    sub a, $01
    ldh [hScrollY], a
    ld hl, wC469
    inc [hl]
    ld a, [wC469]
    cp a, $90
    jr nc, Jump_00F_7BB4
    ret

Jump_00F_7BB4::
    ldh a, [hScrollY]
    and a, $F8
    ldh [hScrollY], a
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_00F_7AC6)
; reads: wIsCGB, hFFC6
; writes: wC0C0, wC0C1, wC0C2, wC0C3, wC0D8, wC0D9, wC0DA, wC0DB, ...
; points at: wC0C4, wC0DC
Func_00F_7BC3::
    ld a, e
    ld [wC0C0], a
    ld a, d
    ld [wC0C1], a
    xor a, a
    ld [wC0C2], a
    ld a, $14
    ld [wC0C3], a
    push hl
    push de
    ld b, $14
    ld de, wC0C4

Jump_00F_7BDB::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00F_7BDB
    pop de
    pop hl
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, e
    ld [wC0D8], a
    ld a, d
    ld [wC0D9], a
    ld a, $00
    ld [wC0DA], a
    ld a, $14
    ld [wC0DB], a
    ld de, $0E68
    add hl, de
    ld b, $14
    ld de, wC0DC

Jump_00F_7C03::
    ld a, $02
    ldh [rSVBK], a
    ld a, [hl+]
    ldh [hFFC6], a
    ld a, $00
    ldh [rSVBK], a
    ldh a, [hFFC6]
    and a, $07
    ld [de], a
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00F_7C03
    ret

Jump_00F_7C19::
    xor a, a
    ld [wC469], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_7C22::
    ld a, [wC921]
    inc a
    ld [wC921], a
    and a, $03
    ret nz
    ld a, [wC921]
    srl a
    srl a
    cp a, $10
    jr z, Jump_00F_7C3F
    ld hl, hScrollY
    dec [hl]
    call ComputeSpriteScrollOffsets
    ret

Jump_00F_7C3F::
    xor a, a
    ld [wC921], a
    ldh [hScrollY], a
    ldh [hScrollYHi], a
    call ComputeSpriteScrollOffsets
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_7C4F::
    ld hl, wCB8C
    call SetBit2AtHL_B0F
    ld a, [wC921]
    inc a
    ld [wC921], a
    and a, $03
    ret nz
    ld a, [wCB8B]
    dec a
    ld [wCB8B], a
    cp a, $50
    ret nz
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_7C72::
    ld b, $3C
    call StepWC921Counter_Bank0F
    ret nc
    ld hl, hMapScreenY
    dec [hl]
    call LoadMapScreen
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_7C84::
    ld a, $1C
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ld a, $01
    ldh [hMapScreenY], a
    ld a, $E0
    ld [wC8C8], a
    ld a, $00
    ld [wC8C9], a
    ld a, $03
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ret

; 1 call site from 1 routine (e.g. Func_010_4E9E)
; reads: wC923
Func_00F_7CA5::
    ld a, [wC923]
    rst $00
    dw Jump_00F_7CD6
    dw Jump_00F_7CD6
    dw Jump_00F_7F89
    dw Jump_00F_7CB1

Jump_00F_7CB1::
    ld a, $76
    call QueueSoundEffect
    ld de, $001B
    call SetFlagBit
    ld a, $03
    ld [wC8EF], a
    ld a, $60
    ld [wC8F0], a
    ld a, $50
    ld [wC8F1], a
    ld a, $E0
    ld [wCBBB], a
    ld a, $80
    ld [wC919], a
    ret

Jump_00F_7CD6::
    ld de, wCBBB
    call Func_00F_7EE9
    ret nc
    xor a, a
    ld [wC921], a
    ld hl, wC923
    inc [hl]
    ld de, $0001
    call TestFlagBit
    jr nc, Jump_00F_7CF4
    ld hl, $0076
    call StoreHLInWC924_B0F
    ret

Jump_00F_7CF4::
    ld hl, $0078
    call StoreHLInWC924_B0F
    ret

; 1 call site from 1 routine (e.g. Func_010_4E97)
; reads: wC923
Func_00F_7CFB::
    ld a, [wC923]
    rst $00
    dw Jump_00F_7D3C
    dw Jump_00F_7D31
    dw Jump_00F_7D1C
    dw Jump_00F_7D07

Jump_00F_7D07::
    ld hl, wCBBA
    dec [hl]
    ld hl, wCBBB
    inc [hl]
    ld de, wCBBB
    call Func_00F_7EE9
    ret nc
    ld a, $80
    ld [wC919], a
    ret

Jump_00F_7D1C::
    ld a, [wCBBB]
    inc a
    inc a
    ld [wCBBB], a
    cp a, $30
    ret nz
    ld a, $03
    ld [wCBB6], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_7D31::
    ld b, $5A
    call StepWC921Counter_Bank0F
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_7D3C::
    ld a, $1D
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    ld a, $00
    ldh [hMapScreenY], a
    ld a, $50
    ld [wC8C8], a
    ld a, $40
    ld [wC8C9], a
    ld a, $02
    ld [wC8C6], a
    farcall Func_05F_6C5A
    ld a, $01
    ldh [hFF8B], a
    ret

; 1 call site from 1 routine (e.g. Func_010_4E51)
; reads: wC923
Func_00F_7D62::
    ld a, [wC923]
    rst $00
    dw Jump_00F_7D86
    dw Jump_00F_7D6C
    dw Jump_00F_7F93

Jump_00F_7D6C::
    ld hl, wC923
    inc [hl]
    ld de, $0000
    call TestFlagBit
    jr c, Jump_00F_7D7F
    ld hl, $0021
    call StoreHLInWC924_B0F
    ret

Jump_00F_7D7F::
    ld hl, $001F
    call StoreHLInWC924_B0F
    ret

Jump_00F_7D86::
    ldh a, [hPlayerFacing]
    ld [wC8EF], a
    ld de, wC8F1
    call Func_00F_7EE9
    ret nc
    ld hl, wC923
    inc [hl]
    ret

; 1 call site from 1 routine (e.g. Func_010_4E4A)
; reads: wC923
Func_00F_7D97::
    ld a, [wC923]
    rst $00
    dw Jump_00F_7DF6
    dw Jump_00F_7DCF
    dw Jump_00F_7DB9
    dw Jump_00F_7DA3

Jump_00F_7DA3::
    call Func_00F_7E1E
    ld de, wCB8B
    call Func_00F_7EE9
    ret nc
    ld hl, hFF8C
    call ClearBit2AtHL_Bank0F
    ld a, $80
    ld [wC919], a
    ret

Jump_00F_7DB9::
    call Func_00F_7E1E
    ld a, [wC924]
    inc a
    ld [wC924], a
    cp a, $20
    ret nz
    xor a, a
    ld [wC924], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_7DCF::
    call Func_00F_7E1E
    ld a, $00
    ld [wC92A], a
    ld a, $00
    ld [wC929], a
    ld a, $50
    ld [wC928], a
    farcall Func_05F_6B54
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $01
    ld [wCB86], a
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_7DF6::
    call Func_00F_7E1E
    ld a, [wC924]
    ld l, a
    ld a, [wC925]
    ld h, a
    inc hl
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    ld a, h
    cp a, $01
    ret nz
    ld a, l
    cp a, $40
    ret nz
    xor a, a
    ld [wC924], a
    ld [wC925], a
    ld hl, wC923
    inc [hl]
    ret

; 4 call sites from 1 routine (e.g. Func_00F_7D97)
; reads: wC922, wC92C
; writes: wC928, wC922
Func_00F_7E1E::
    ld a, [wC922]
    or a, a
    jr nz, Jump_00F_7E37
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6B17
    farcall Func_05F_6B17
    jr Jump_00F_7EA0

Jump_00F_7E37::
    dec a
    jr nz, Jump_00F_7E4D
    ld a, $80
    ld [wC928], a
    farcall Func_05F_6A94
    farcall Func_05F_6A94
    jr Jump_00F_7EA0

Jump_00F_7E4D::
    dec a
    jr nz, Jump_00F_7E63
    ld a, $80
    ld [wC928], a
    farcall Func_05F_6ABF
    farcall Func_05F_6ABF
    jr Jump_00F_7EA0

Jump_00F_7E63::
    dec a
    jr nz, Jump_00F_7E79
    ld a, $60
    ld [wC928], a
    farcall Func_05F_6AEB
    farcall Func_05F_6AEB
    jr Jump_00F_7EA0

Jump_00F_7E79::
    dec a
    jr nz, Jump_00F_7E8F
    ld a, $70
    ld [wC928], a
    farcall Func_05F_6B17
    farcall Func_05F_6B17
    jr Jump_00F_7EA0

Jump_00F_7E8F::
    ld a, $50
    ld [wC928], a
    farcall Func_05F_6AEB
    farcall Func_05F_6AEB

Jump_00F_7EA0::
    ld a, [wC92C]
    or a, a
    ret z
    ld a, [wC922]
    inc a
    cp a, $06
    jr nz, Jump_00F_7EAE
    xor a, a

Jump_00F_7EAE::
    ld [wC922], a
    ret

; wC921 += 1; if it now equals B it is reset to 0 and carry is set, else carry is clear; returns A = 0 either way (the same 18 bytes appear in 3 banks)
; 34 call sites from 23 routines (e.g. Func_00F_7F0B, Func_00F_7F24, Func_00F_772E, Func_00F_7F42, ...)
; reads: wC921
; writes: wC921
StepWC921Counter_Bank0F::
Func_00F_7EB2:: ; address name
    ld a, [wC921]
    inc a
    ld [wC921], a
    cp a, b
    jr z, Jump_00F_7EBE
    sub a, a
    ret

Jump_00F_7EBE::
    xor a, a
    ld [wC921], a
    scf
    ret

; [HL] |= $02; clobbers A (the same 5 bytes appear in 4 banks)
; 5 call sites from 4 routines (e.g. Func_00F_6D4D, Func_00F_64F3, Func_00F_5F06, Func_00F_40E9)
SetBit1AtHL_Bank0F:: ; heuristic: follows a terminator; C0
Func_00F_7EC4:: ; address name
    ld a, [hl]
    or a, $02
    ld [hl], a
    ret

; [HL] &= $FD; clobbers A (the same 5 bytes appear in 4 banks)
; 4 call sites from 3 routines (e.g. Func_00F_6D4D, Func_00F_64F3, Func_00F_5F06)
ClearBit1AtHL_Bank0F:: ; heuristic: follows a terminator; C0
Func_00F_7EC9:: ; address name
    ld a, [hl]
    and a, $FD
    ld [hl], a
    ret

; sets bit 2 of the byte at [HL]; only A is clobbered
; 28 call sites from 10 routines (e.g. Func_00F_6D4D, Func_00F_70EC, Func_00F_7049, Func_00F_6F65, ...)
SetBit2AtHL_B0F:: ; heuristic: follows a terminator; C0
Func_00F_7ECE:: ; address name
    ld a, [hl]
    or a, $04
    ld [hl], a
    ret

; [HL] &= $FB; clobbers A (the same 5 bytes appear in 4 banks)
; 24 call sites from 11 routines (e.g. Func_00F_772E, Func_00F_70EC, Func_00F_6F65, Func_00F_6D4D, ...)
ClearBit2AtHL_Bank0F::
Func_00F_7ED3:: ; address name
    ld a, [hl]
    and a, $FB
    ld [hl], a
    ret

; 15 call sites from 5 routines (e.g. Func_00F_70EC, Func_00F_6D4D, Func_00F_631F, Func_00F_5F06, ...)
Func_00F_7ED8:: ; heuristic: follows a terminator; C0
    and a, $0F
    jr nz, Jump_00F_7EE2
    farcall Func_002_5923

Jump_00F_7EE2::
    farcall Func_002_5946
    ret

; 38 call sites from 14 routines (e.g. Func_00F_786F, Func_00F_72D9, Func_00F_67BA, Func_00F_64F3, ...)
; reads: wC921
; writes: wC928, wC929, wC921
Func_00F_7EE9::
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld a, [wC921]
    inc a
    inc a
    ld [wC921], a
    cp a, $20
    jr z, Jump_00F_7F05
    sub a, a
    ret

Jump_00F_7F05::
    xor a, a
    ld [wC921], a
    scf
    ret

; 4 call sites from 4 routines (e.g. Func_00F_70EC, Func_00F_64F3, Func_00F_5F06, Func_00F_4FA1)
; writes: wC928, wC929
; points at: wC923
Func_00F_7F0B:: ; heuristic: follows a terminator; C0
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld b, $20
    call StepWC921Counter_Bank0F
    ret nc
    ld hl, wC923
    inc [hl]
    ret

; 7 call sites from 3 routines (e.g. Func_00F_67BA, Func_00F_5404, Func_00F_5AF3)
; writes: wC928, wC929
; points at: wC923
Func_00F_7F24:: ; heuristic: follows a terminator; C0
    push hl
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld b, $20
    call StepWC921Counter_Bank0F
    pop hl
    ret nc
    call StoreHLInWC924_B0F
    ld hl, wC923
    inc [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC928, wC929, wC919
Func_00F_7F42:: ; heuristic: follows a terminator; C0
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld b, $20
    call StepWC921Counter_Bank0F
    ret nc
    ld a, $80
    ld [wC919], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC921
Func_00F_7F5C:: ; heuristic: follows a terminator; C0
    ld a, [wC921]
    and a, $1F
    ret nz
    ld a, [de]
    inc a
    and a, $03
    ld [de], a
    ret

; HL is stored in wC924 (low) and wC925 (high); then wC926 = 0
; 125 call sites from 24 routines (e.g. Func_00F_7A2D, Func_00F_786F, Func_00F_7F24, Func_00F_772E, ...)
; writes: wC924, wC925, wC926
StoreHLInWC924_B0F::
Func_00F_7F68:: ; address name
    ld a, l
    ld [wC924], a
    ld a, h
    ld [wC925], a
    xor a, a
    ld [wC926], a
    ret

; 15 call sites from 10 routines (e.g. Func_00F_7F75, Func_00F_7A2D, Func_00F_786F, Func_00F_772E, ...)
; reads: wC926
; writes: wC928
Func_00F_7F75::
    ld [wC928], a
    farcall Func_05F_6936
    ld a, [wC926]
    cp a, $FF
    jr z, Jump_00F_7F87
    sub a, a
    ret

Jump_00F_7F87::
    scf
    ret

Jump_00F_7F89::
    xor a, a
    call Func_00F_7F75
    ret nc
    ld hl, wC923
    inc [hl]
    ret

Jump_00F_7F93::
    xor a, a
    call Func_00F_7F75
    ret nc
    ld a, $80
    ld [wC919], a
    ret
    ds $62, $00
