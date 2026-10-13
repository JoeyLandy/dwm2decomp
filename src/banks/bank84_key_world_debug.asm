; ROM bank $84: key-world helpers and debug field code
; The annotated listing of this bank is build/listing/bank84.asm.

SECTION "Bank 84", ROMX[$4000], BANK[$84]
    db $84

DebugAutomap_Update_Sub01_Sub01_WriteKeyWorldGenRoomAndTemp8Etc::
    xor a
    ld [wKeyWorldGenRoom], a
    ld a, [wKeyWorldAreaCount]
    add a
    ld hl, KeyWorldAreaLayoutTable
    add_a_to_hl
    ld a, [hli]
    ldh [hTemp8], a
    ld a, [hl]
    ldh [hTemp9], a
    ldh a, [hTemp8]
    add $01
    ldh [hTemp8], a
    ldh a, [hTemp9]
    adc $00
    ldh [hTemp9], a
    ld hl, wKeyWorldFloorInfo + $3
    ld de, wKeyWorldFloorState

.skip:
    ld a, [hl]
    cp $ff
    ret z
    push hl
    push de
    dec hl
    dec hl
    ld a, [hl]
    ldh [hTemp0], a
    call RunDebugAutomapCaseTemp0
    ldh a, [hTemp8]
    ld l, a
    ldh a, [hTemp9]
    ld h, a
    ld a, $10
    add_a_to_hl
    ld a, l
    ldh [hTemp8], a
    ld a, h
    ldh [hTemp9], a
    pop de
    pop hl
    ld a, $04
    add_a_to_hl
    ld a, $10
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    jr .skip

; debug automap: runs the routine for hTemp0 (jump table of seven) (E-0122)
RunDebugAutomapCaseTemp0::
    ldh a, [hTemp0]
    jumptable
    dw RunDebugAutomapCaseTemp0_Return
    dw RunDebugAutomapCaseTemp0_ReadKeyWorldGoalKindAndTemp8Etc
    dw RunDebugAutomapCaseTemp0_NextRandomSeed
    dw RunDebugAutomapCaseTemp0_NextRandomSeed_Case03
    dw RunDebugAutomapCaseTemp0_NextRandomSeed_SetTemp0
    dw RunDebugAutomapCaseTemp0_NextRandomSeed_Case05_SetTemp0
    dw RunDebugAutomapCaseTemp0_ReturnAfterSetup

RunDebugAutomapCaseTemp0_Return::
    ret

RunDebugAutomapCaseTemp0_ReturnAfterSetup::
    ld a, $54
    ld [de], a
    ret

RunDebugAutomapCaseTemp0_ReadKeyWorldGoalKindAndTemp8Etc::
    ld hl, RunDebugAutomapCaseTemp0_ReadKeyWorldGoalKindAndTemp8Etc_Data
    ld a, [wKeyWorldGoalKind]
    add_a_to_hl
    ld a, [hl]
    ld [de], a
    inc de
    inc de
    ldh a, [hTemp8]
    ld l, a
    ldh a, [hTemp9]
    ld h, a
    inc hl
    ld b, $0e

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

RunDebugAutomapCaseTemp0_NextRandomSeed::
    ld hl, RunDebugAutomapCaseTemp0_NextRandomSeed_Data
    ld a, [wKeyWorldGoalKind]
    add_a_to_hl
    ld a, [hl]
    add $20
    ld [de], a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    srl a
    and $01
    jr z, .read_temp8
    ld a, [de]
    or $80
    ld [de], a

.read_temp8:
    inc de
    inc de
    ldh a, [hTemp8]
    ld l, a
    ldh a, [hTemp9]
    ld h, a
    inc hl
    ld b, $0e

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

RunDebugAutomapCaseTemp0_NextRandomSeed_Case03::
    ld hl, RunDebugAutomapCaseTemp0_NextRandomSeed_Data
    ld a, [wKeyWorldGoalKind]
    add_a_to_hl
    ld a, [hl]
    add $40
    ld [de], a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    srl a
    and $01
    jr z, .read_temp8
    ld a, [de]
    or $80
    ld [de], a

.read_temp8:
    inc de
    inc de
    ldh a, [hTemp8]
    ld l, a
    ldh a, [hTemp9]
    ld h, a
    inc hl
    ld b, $0e

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

RunDebugAutomapCaseTemp0_NextRandomSeed_SetTemp0::
    ldh a, [hTemp8]
    ld l, a
    ldh a, [hTemp9]
    ld h, a
    inc hl
    ld a, [hli]
    ld [de], a
    ldh [hTemp0], a
    push hl
    inc de
    ld a, [wKeyWorldGenRoom]
    ld [de], a
    inc de
    ld a, [wKeyWorldGoalKind]
    add a
    add a
    ld hl, RunDebugAutomapCaseTemp0_NextRandomSeed_Case04_Data
    add_a_to_hl
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $03
    add_a_to_hl
    ld a, [hl]
    ld [de], a
    pop hl
    inc de
    push de
    ld b, $0d

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    pop de
    inc de
    ld a, [de]
    cp $ff
    jr z, .call_run_debug_automap_case_temp0_random
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $07
    inc de
    inc de
    ld [de], a
    inc de
    inc de
    ld a, [de]
    cp $ff
    jr z, .call_run_debug_automap_case_temp0_random
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $07
    inc de
    inc de
    ld [de], a

.call_run_debug_automap_case_temp0_random:
    ld a, $01
    call RunDebugAutomapCaseTemp0_RandomBelowC
    ret

RunDebugAutomapCaseTemp0_NextRandomSeed_Case05_SetTemp0::
    ldh a, [hTemp8]
    ld l, a
    ldh a, [hTemp9]
    ld h, a
    inc hl
    ld a, [hli]
    ld [de], a
    ldh [hTemp0], a
    push hl
    inc de
    ld a, [wKeyWorldGenRoom]
    ld [de], a
    inc de
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $07
    ld hl, RunDebugAutomapCaseTemp0_NextRandomSeed_Case05_Data
    add_a_to_hl
    ld a, [hl]
    ld [de], a
    pop hl
    inc de
    push de
    ld b, $0d

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    pop de
    inc de
    ld a, [de]
    cp $ff
    jr z, .call_run_debug_automap_case_temp0_random
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $07
    inc de
    inc de
    ld [de], a
    inc de
    inc de
    ld a, [de]
    cp $ff
    jr z, .call_run_debug_automap_case_temp0_random
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $07
    inc de
    inc de
    ld [de], a

.call_run_debug_automap_case_temp0_random:
    xor a
    call RunDebugAutomapCaseTemp0_RandomBelowC
    ret

RunDebugAutomapCaseTemp0_ReadKeyWorldGoalKindAndTemp8Etc_Data::
    db $00, $00, $03, $01, $00, $00, $04, $05, $02, $00

RunDebugAutomapCaseTemp0_NextRandomSeed_Data::
    db $00, $06, $03, $01, $07, $08, $04, $05, $02, $09

RunDebugAutomapCaseTemp0_NextRandomSeed_Case05_Data::
    db $05, $06, $07, $08, $09, $05, $07, $09

RunDebugAutomapCaseTemp0_NextRandomSeed_Case04_Data::
    db $00, $0b, $00, $0b, $00, $02, $00, $02, $02, $03, $0b, $02, $02, $04, $02, $04
    db $01, $01, $01, $01, $01, $03, $01, $03, $00, $04, $00, $04, $01, $04, $01, $04
    db $01, $03, $0b, $01, $00, $0b, $00, $0b

RunDebugAutomapCaseTemp0_RandomBelowC::
    push af
    ld a, [wKeyWorldGenRoom]
    add a
    ld hl, wKeyWorldRoomTable
    add_a_to_hl
    pop af
    or a
    jr nz, .clear_temp2
    ld a, $a0
    ldh [hTemp2], a
    call NextRandomSeed
    and $03
    add a
    add a
    add a
    ld c, a
    ldh a, [hTemp2]
    add c
    ldh [hTemp2], a
    ld c, $05
    call RandomBelowC
    ld c, a
    ldh a, [hTemp2]
    add c
    ldh [hTemp2], a
    ld [hli], a
    ldh a, [hTemp2]
    ld e, a
    ld d, $00
    sla e
    rl d
    call RunDebugAutomapCaseTemp0_Shared01_ReadByteInBank
    ldh a, [hTemp4]
    swap a
    or $0f
    ld [hli], a
    ld a, $0f
    ldh [hTemp3], a
    ld a, [wKeyWorldGenRoom]
    inc a
    ld [wKeyWorldGenRoom], a
    jr .check_temp0

.clear_temp2:
    xor a
    ldh [hTemp2], a
    ld c, $09
    call RandomBelowC
    sla a
    sla a
    sla a
    ld c, a
    ldh a, [hTemp2]
    add c
    ldh [hTemp2], a
    ld c, $08
    call RandomBelowC
    ld c, a
    ldh a, [hTemp2]
    add c
    ldh [hTemp2], a
    ld [hli], a
    ldh a, [hTemp2]
    ld e, a
    ld d, $00
    sla e
    rl d
    call RunDebugAutomapCaseTemp0_Shared01_ReadByteInBank
    ldh a, [hTemp4]
    swap a
    ld c, a
    ldh a, [hTemp3]
    or c
    ld [hli], a
    ld a, [wKeyWorldGenRoom]
    inc a
    ld [wKeyWorldGenRoom], a

.check_temp0:
    ldh a, [hTemp0]
    dec a
    dec a
    ld b, a

.loop:
    push bc
    ldh a, [hTemp4]
    and $0f
    swap a
    ld de, KeyWorldMonsterBaseRows
    add e
    ld e, a
    jr nc, .call_random_below_c
    inc d

.call_random_below_c:
    ld c, $0a
    call RandomBelowC
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld b, a
    ld c, $08
    call RandomBelowC
    add b
    ld [hli], a
    ld e, a
    ld d, $00
    sla e
    rl d
    ldh a, [hTemp4]
    ldh [hTemp3], a
    call RunDebugAutomapCaseTemp0_Shared01_ReadByteInBank_Sub01
    ldh a, [hTemp3]
    ld c, a
    ldh a, [hTemp4]
    swap a
    or c
    ld [hli], a
    ld a, [wKeyWorldGenRoom]
    inc a
    ld [wKeyWorldGenRoom], a
    pop bc
    dec b
    jr nz, .loop
    ret

; RunDebugAutomapCaseTemp0_RandomBelowC.loop reads the byte at $42C7 + 16 * (hTemp4 & $0F) + a
; random 0-9, adds a random 0-7, stores the sum and uses it doubled as an index for
; RunDebugAutomapCaseTemp0_Shared01_Sub01; 6 rows end at that routine (E-0193, C1)
; record: ten base values, then six zero bytes
KeyWorldMonsterBaseRows::
    db $00, $08, $10, $18, $20, $28, $30, $38, $40, $48, $00, $00, $00, $00, $00, $00 ; id 0
    db $00, $08, $10, $18, $50, $58, $60, $68, $70, $78, $00, $00, $00, $00, $00, $00 ; id 1
    db $00, $20, $28, $30, $50, $58, $60, $80, $88, $90, $00, $00, $00, $00, $00, $00 ; id 2
    db $08, $20, $38, $40, $50, $68, $70, $80, $88, $98, $00, $00, $00, $00, $00, $00 ; id 3
    db $10, $28, $38, $48, $58, $68, $78, $80, $90, $98, $00, $00, $00, $00, $00, $00 ; id 4
    db $18, $30, $40, $48, $60, $70, $78, $88, $90, $98, $00, $00, $00, $00, $00, $00 ; id 5

RunDebugAutomapCaseTemp0_Shared01_ReadByteInBank_Sub01::
    push hl
    ld a, e
    add $01
    ld e, a
    ld a, d
    adc $40
    ld d, a
    ld a, $72
    ld b, a
    call ReadByteInBank
    ld l, c
    inc de
    call ReadByteInBank
    ld h, c

.loop:
    call NextRandomSeed
    and $03
    jr z, .loop
    push hl
    dec a
    add_a_to_hl
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    call ReadByteInBank
    pop hl
    ldh a, [hTemp3]
    cp c
    jr z, .loop
    ld a, c
    ldh [hTemp4], a
    pop hl
    ret

RunDebugAutomapCaseTemp0_Shared01_ReadByteInBank::
    push hl
    ld a, e
    add $01
    ld e, a
    ld a, d
    adc $40
    ld d, a
    ld a, $72
    ld b, a
    call ReadByteInBank
    ld a, c
    ld l, a
    inc de
    call ReadByteInBank
    ld a, c
    ld h, a
    push hl

.loop:
    call NextRandomSeed
    and $03
    jr z, .loop
    dec a
    add_a_to_hl
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    call ReadByteInBank
    ld a, c
    ldh [hTemp3], a
    pop hl

.loop2:
    call NextRandomSeed
    and $03
    jr z, .loop2
    push hl
    dec a
    add_a_to_hl
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    call ReadByteInBank
    pop hl
    ldh a, [hTemp3]
    cp c
    jr z, .loop2
    ld a, c
    ldh [hTemp4], a
    pop hl
    ret

; repeats NextRandomSeed until wKeyRandomHi & $0F is below C (C must be 1-16); returns A = that
; value (E-0077)
RandomBelowC::
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $0f
    cp c
    jr nc, RandomBelowC
    ret

; for each 8-byte entry of MapScreenFlagTiles matching hMapId and the screen position, with its
; story flag set, runs ApplyMapScreenFlagEvents_WriteSVBK (hTemp0 = its value) (E-0125)
ApplyMapScreenFlagEvents::
    ld hl, MapScreenFlagTiles

.skip:
    push hl
    ld a, [hli]
    cp $ff
    jr nz, .check_map_id
    pop hl
    ret

.check_map_id:
    ld c, a
    ldh a, [hMapId]
    cp c
    jr nz, .restore
    ld a, [hli]
    ld c, a
    ldh a, [hMapScreenX]
    cp c
    jr nz, .restore
    ld a, [hli]
    ld c, a
    ldh a, [hMapScreenY]
    cp c
    jr nz, .restore
    ld a, [hli]
    ldh [hTemp0], a
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    call TestFlagBit
    jr nc, .restore
    pop hl
    push hl
    call ApplyMapScreenFlagEvents_WriteSVBK

.restore:
    pop hl
    ld a, $08
    add_a_to_hl
    jr .skip

ApplyMapScreenFlagEvents_WriteSVBK::
    ldh a, [hTemp0]
    cp $ff
    jr z, .skip
    ld a, $06
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, e
    add $98
    ld e, a
    ld a, d
    adc $c1
    ld d, a
    ldh a, [hTemp0]
    ld [de], a
    inc a
    inc de
    ld [de], a
    ret

.skip:
    ld a, $06
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    push de
    ld a, e
    add $98
    ld e, a
    ld a, d
    adc $c1
    ld d, a
    ld a, $40
    ld [de], a
    inc a
    inc de
    ld [de], a
    ld a, $13
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, $50
    ld [de], a
    inc a
    inc de
    ld [de], a
    pop de
    ld a, [wIsCGB]
    or a
    ret z
    ld a, $02
    ldh [rSVBK], a
    ld a, e
    add $00
    ld e, a
    ld a, d
    adc $d0
    ld d, a
    ld a, $05
    ld [de], a
    inc de
    ld [de], a
    ld a, $13
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, $05
    ld [de], a
    inc de
    ld [de], a
    ld a, $00
    ldh [rSVBK], a
    ret

; ApplyMapScreenFlagEvents walks these 8-byte entries until $FF; when hMapId and hMapScreenX/Y match
; and the story flag is set, ApplyMapScreenFlagEvents_Sub01 writes the tile and tile + 1 at
; wScreenTileBuffer + offset (tile $FF takes another path); 108 entries (E-0151, C1)
; record: map number, screen X, screen Y, tile; story flag number (TestFlagBit); offset into
; wScreenTileBuffer
MapScreenFlagTiles::
    db $19, $00, $02, $3e ; id 0
    dw $011b
    dw $0088
    db $19, $00, $02, $3e ; id 1
    dw $011c
    dw $0100
    db $1b, $00, $02, $1a ; id 2
    dw $013e
    dw $00a6
    db $1b, $00, $02, $1a ; id 3
    dw $013f
    dw $00ac
    db $2b, $01, $02, $3c ; id 4
    dw $004f
    dw $0054
    db $2b, $02, $02, $3c ; id 5
    dw $0050
    dw $0084
    db $2b, $00, $03, $3c ; id 6
    dw $0051
    dw $011e
    db $2b, $00, $03, $3c ; id 7
    dw $0052
    dw $0122
    db $35, $00, $00, $16 ; id 8
    dw $0067
    dw $00d2
    db $35, $01, $00, $16 ; id 9
    dw $0068
    dw $00a8
    db $35, $03, $00, $16 ; id 10
    dw $0069
    dw $0086
    db $35, $03, $00, $16 ; id 11
    dw $006a
    dw $00d6
    db $35, $03, $00, $16 ; id 12
    dw $006b
    dw $0126
    db $35, $02, $03, $16 ; id 13
    dw $006c
    dw $0056
    db $42, $00, $00, $4c ; id 14
    dw $00eb
    dw $0030
    db $42, $00, $00, $4c ; id 15
    dw $00ec
    dw $0032
    db $42, $00, $00, $4c ; id 16
    dw $00ed
    dw $0034
    db $42, $01, $00, $4c ; id 17
    dw $00ee
    dw $00aa
    db $44, $00, $00, $4c ; id 18
    dw $0076
    dw $0034
    db $39, $03, $00, $06 ; id 19
    dw $00e0
    dw $00a4
    db $39, $03, $00, $06 ; id 20
    dw $00e1
    dw $00ae
    db $39, $03, $02, $06 ; id 21
    dw $00e2
    dw $00f6
    db $39, $03, $02, $06 ; id 22
    dw $00e3
    dw $00fa
    db $39, $03, $02, $06 ; id 23
    dw $00e4
    dw $00fe
    db $3a, $00, $00, $06 ; id 24
    dw $00e5
    dw $00d0
    db $3a, $00, $00, $06 ; id 25
    dw $00e6
    dw $00d2
    db $3e, $01, $01, $1c ; id 26
    dw $0079
    dw $0084
    db $55, $00, $00, $2c ; id 27
    dw $0084
    dw $00a6
    db $62, $01, $01, $2c ; id 28
    dw $01e0
    dw $005e
    db $73, $00, $01, $4c ; id 29
    dw $00a1
    dw $0060
    db $76, $00, $00, $4c ; id 30
    dw $00a2
    dw $00ce
    db $76, $00, $00, $4c ; id 31
    dw $00a3
    dw $0100
    db $7a, $00, $00, $2e ; id 32
    dw $00aa
    dw $0030
    db $82, $02, $02, $2c ; id 33
    dw $00ab
    dw $00aa
    db $84, $00, $00, $2c ; id 34
    dw $00ac
    dw $0034
    db $85, $01, $00, $3c ; id 35
    dw $00af
    dw $005a
    db $91, $00, $00, $2c ; id 36
    dw $00b5
    dw $0058
    db $94, $02, $00, $3e ; id 37
    dw $00bc
    dw $00a8
    db $96, $00, $00, $3e ; id 38
    dw $00bd
    dw $00a8
    db $98, $00, $00, $3e ; id 39
    dw $00be
    dw $00f2
    db $9a, $00, $00, $3e ; id 40
    dw $00bf
    dw $0128
    db $63, $01, $00, $2c ; id 41
    dw $01e9
    dw $011a
    db $63, $00, $01, $2c ; id 42
    dw $01ea
    dw $0038
    db $64, $00, $00, $2c ; id 43
    dw $01eb
    dw $00a2
    db $64, $00, $00, $2c ; id 44
    dw $01ec
    dw $00d0
    db $66, $00, $00, $2c ; id 45
    dw $01ed
    dw $00a2
    db $66, $00, $00, $2c ; id 46
    dw $01ee
    dw $00a6
    db $67, $00, $00, $2c ; id 47
    dw $01ef
    dw $011e
    db $67, $00, $00, $2c ; id 48
    dw $01f0
    dw $0124
    db $ad, $00, $00, $2e ; id 49
    dw $0156
    dw $00ac
    db $ae, $00, $02, $2e ; id 50
    dw $0157
    dw $00ac
    db $ae, $02, $03, $2e ; id 51
    dw $0158
    dw $0060
    db $be, $00, $00, $2e ; id 52
    dw $01cb
    dw $0082
    db $c0, $00, $01, $2e ; id 53
    dw $01cc
    dw $011a
    db $c2, $01, $01, $2e ; id 54
    dw $01cd
    dw $0080
    db $c4, $00, $00, $2e ; id 55
    dw $01ce
    dw $00f6
    db $c4, $00, $00, $ff ; id 56
    dw $01cf
    dw $007c
    db $c4, $00, $00, $ff ; id 57
    dw $01d0
    dw $00a8
    db $c4, $00, $00, $ff ; id 58
    dw $01d1
    dw $005a
    db $c4, $00, $00, $ff ; id 59
    dw $01d2
    dw $00d8
    db $ca, $00, $00, $3e ; id 60
    dw $01d5
    dw $0052
    db $ca, $00, $00, $3e ; id 61
    dw $01d6
    dw $002e
    db $ca, $00, $00, $3e ; id 62
    dw $01d8
    dw $0060
    db $cb, $00, $00, $3e ; id 63
    dw $01da
    dw $0052
    db $cb, $00, $00, $3e ; id 64
    dw $01db
    dw $002e
    db $cb, $00, $00, $3e ; id 65
    dw $01dc
    dw $0034
    db $cc, $00, $00, $3e ; id 66
    dw $01de
    dw $002e
    db $cc, $00, $00, $3e ; id 67
    dw $01df
    dw $0034
    db $cc, $00, $00, $3e ; id 68
    dw $0169
    dw $0060
    db $cd, $00, $00, $3e ; id 69
    dw $016b
    dw $0052
    db $cd, $00, $00, $3e ; id 70
    dw $016c
    dw $002e
    db $cd, $00, $00, $3e ; id 71
    dw $016d
    dw $0034
    db $ce, $00, $00, $3e ; id 72
    dw $016f
    dw $00a4
    db $ce, $00, $00, $3e ; id 73
    dw $0170
    dw $007e
    db $ce, $00, $00, $3e ; id 74
    dw $0171
    dw $0084
    db $ce, $00, $00, $3e ; id 75
    dw $0172
    dw $00ae
    db $d3, $00, $00, $3e ; id 76
    dw $0175
    dw $0052
    db $d3, $00, $00, $3e ; id 77
    dw $0176
    dw $002e
    db $d3, $00, $00, $3e ; id 78
    dw $0177
    dw $0034
    db $d4, $00, $00, $3e ; id 79
    dw $0179
    dw $002e
    db $d4, $00, $00, $3e ; id 80
    dw $017a
    dw $0034
    db $d4, $00, $00, $3e ; id 81
    dw $017b
    dw $0060
    db $d5, $00, $00, $3e ; id 82
    dw $017d
    dw $002e
    db $d5, $00, $00, $3e ; id 83
    dw $017e
    dw $0034
    db $d5, $00, $00, $3e ; id 84
    dw $017f
    dw $0060
    db $d6, $00, $00, $3e ; id 85
    dw $00d6
    dw $002e
    db $d6, $00, $00, $3e ; id 86
    dw $00d7
    dw $0034
    db $d6, $00, $00, $3e ; id 87
    dw $00d8
    dw $0060
    db $d7, $00, $00, $3e ; id 88
    dw $00da
    dw $00a4
    db $d7, $00, $00, $3e ; id 89
    dw $00db
    dw $007e
    db $d7, $00, $00, $3e ; id 90
    dw $00dc
    dw $0084
    db $d7, $00, $00, $3e ; id 91
    dw $00dd
    dw $00ae
    db $dc, $00, $00, $3e ; id 92
    dw $00f5
    dw $002e
    db $dc, $00, $00, $3e ; id 93
    dw $00f6
    dw $0034
    db $dc, $00, $00, $3e ; id 94
    dw $00f7
    dw $0060
    db $dd, $00, $00, $3e ; id 95
    dw $00f9
    dw $0052
    db $dd, $00, $00, $3e ; id 96
    dw $00fa
    dw $002e
    db $dd, $00, $00, $3e ; id 97
    dw $00fb
    dw $0034
    db $de, $00, $00, $3e ; id 98
    dw $00fd
    dw $002e
    db $de, $00, $00, $3e ; id 99
    dw $00fe
    dw $0034
    db $de, $00, $00, $3e ; id 100
    dw $00ff
    dw $0060
    db $df, $00, $00, $3e ; id 101
    dw $01f3
    dw $002e
    db $df, $00, $00, $3e ; id 102
    dw $01f4
    dw $0034
    db $df, $00, $00, $3e ; id 103
    dw $01f5
    dw $0060
    db $e0, $00, $00, $3e ; id 104
    dw $01f7
    dw $00a4
    db $e0, $00, $00, $3e ; id 105
    dw $01f8
    dw $007e
    db $e0, $00, $00, $3e ; id 106
    dw $01f9
    dw $0084
    db $e0, $00, $00, $3e ; id 107
    dw $01fa
    dw $00ae
    db $ff ; end

ItemUsable_LogTwig_WriteTempAAndSpriteSnapshotEtc::
    xor a
    ldh [hTempA], a
    ldh a, [hPlayerStateFlags]
    bit 3, a
    ret nz
    ld a, [wMapType]
    bit 7, a
    jp nz, ItemUsable_LogTwig_WriteTempAAndSpriteSnapshotEtc_Data_Cp80
    ldh a, [hMapId]
    cp $20
    ret c
    push af
    call ItemUsable_LogTwig_Sub01_ReadTriggerKindAndPlayerXEtc
    or a
    jr z, .restore
    pop af
    ret

.restore:
    pop af
    ld e, a
    ld hl, LogTwigSpotList
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or c
    ld c, a
    ldh a, [hPlayerX]
    and $f0
    ld b, a
    ldh a, [hPlayerY]
    and $f0
    swap a
    or b
    ld b, a

.skip:
    push hl
    ld a, [hli]
    cp $ff
    jr z, .read_map_id
    cp e
    jr nz, .restore2
    ld a, [hli]
    cp c
    jr nz, .restore2
    ld a, [hli]
    cp b
    jr z, .done
    ld a, [hl]
    cp $ff
    jr z, .restore2
    cp b
    jr z, .done

.restore2:
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr .skip

.done:
    pop hl
    ret

.read_map_id:
    pop hl
    ldh a, [hMapId]
    ld d, a
    ld e, $00
    ld hl, ItemUsable_LogTwig_WriteTempAAndSpriteSnapshotEtc_Data

.skip2:
    ld a, [hl]
    cp $ff
    jr z, .set_key_world_active_to_01
    cp d
    jr z, .read_key_world_active
    inc e
    inc hl
    inc hl
    inc hl
    jr .skip2

.read_key_world_active:
    ld a, [wKeyWorldActive]
    ld [wSpriteSnapshot], a
    or a
    jr z, .next
    ld a, [wKeyWorldGoal]
    ld [wLogTwigKeyWorldGoal], a
    ld a, [wKeyWorldGoalCell]
    ld [wLogTwigKeyWorldGoalCell], a
    ld a, [wKeyWorldKey]
    ld [wLogTwigKeyWorldKey], a
    ld a, [wKeyWorldKey]
    bit 7, a
    jr nz, .next
    cp e
    jr nz, .next
    ld a, [wKeyWorldGoal]
    cp b
    jr nz, .set_key_world_active_to_01
    ld a, [wKeyWorldGoalCell]
    cp c
    jr nz, .set_key_world_active_to_01
    ret

.next:
    inc hl
    ld a, [hl]
    cp b
    jr nz, .set_key_world_active_to_01
    inc hl
    cp c
    jr nz, .set_key_world_active_to_01
    ret

.set_key_world_active_to_01:
    ld a, $01
    ld [wKeyWorldActive], a
    ld a, b
    ld [wKeyWorldGoal], a
    ld a, c
    ld [wKeyWorldGoalCell], a
    ld a, e
    inc a
    ld [wKeyWorldKey], a
    ld a, $01
    ldh [hTempA], a
    ret

ItemUsable_LogTwig_WriteTempAAndSpriteSnapshotEtc_Data::
    db $20, $44, $00, $30, $44, $76, $48, $44, $b4, $70, $44, $b4, $a0, $44, $10, $a8
    db $44, $00, $b0, $44, $01, $b8, $44, $44, $c8, $44, $01, $d1, $44, $00, $da, $44
    db $00, $ff

ItemUsable_LogTwig_WriteTempAAndSpriteSnapshotEtc_Data_Cp80::
    cp $80
    ret nz
    call ItemUsable_LogTwig_Sub01_ReadTriggerKindAndPlayerXEtc
    or a
    ret nz
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or c
    ld c, a
    ldh a, [hPlayerX]
    cp $40
    jr nz, .check_player_y2
    ldh a, [hPlayerY]
    cp $40
    jr nz, .check_player_y2
    ld hl, wKeyWorldObjects

.skip:
    push hl
    ld a, [hl]
    cp $ff
    jr z, .check_player_y
    dec hl
    dec hl
    dec hl
    ld a, [hli]
    cp c
    jp z, .done
    ld a, [hl]
    cp c
    jp z, .done
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr .skip

.check_player_y:
    pop hl

.check_player_y2:
    ldh a, [hPlayerY]
    cp $40
    jr nz, .read_key_world_active2
    ld hl, wKeyWorldFloorInfo + $3

.skip2:
    push hl
    ld a, [hl]
    cp $ff
    jr z, .read_key_world_active
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    cp c
    jr nz, .restore
    ldh a, [hPlayerX]
    cp $40
    jp z, .done
    inc hl
    ld a, [hl]
    cp $04
    jr z, .restore
    cp $05
    jr z, .restore
    ldh a, [hPlayerX]
    cp $50
    jp z, .done

.restore:
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr .skip2

.read_key_world_active:
    pop hl

.read_key_world_active2:
    ld a, [wKeyWorldActive]
    ld [wSpriteSnapshot], a
    or a
    jr z, .check_key_world_goal_screen
    ld a, [wKeyWorldGoal]
    ld [wLogTwigKeyWorldGoal], a
    ld a, [wKeyWorldGoalCell]
    ld [wLogTwigKeyWorldGoalCell], a
    ld a, [wKeyWorldKey]
    ld [wLogTwigKeyWorldKey], a
    ld a, [wKeyWorldKey]
    bit 7, a
    jr z, .check_key_world_goal_screen
    and $7f
    ld b, a
    ld a, [wKeyWorldSlot]
    cp b
    jr nz, .check_key_world_goal_screen
    ldh a, [hPlayerX]
    and $f0
    ld b, a
    ldh a, [hPlayerY]
    and $f0
    swap a
    or b
    ld b, a
    ld a, [wKeyWorldGoal]
    cp b
    jr nz, .check_player_x
    ld a, [wKeyWorldGoalCell]
    cp c
    jr nz, .check_player_x
    ret

.check_key_world_goal_screen:
    ld a, [wKeyWorldGoalScreen]
    cp c
    jr nz, .check_player_x
    ld a, [wKeyWorldGoalPos]
    ld b, a
    ldh a, [hPlayerX]
    cp b
    jr nz, .check_player_x
    ld a, [wKeyWorldGoalPos2]
    ld b, a
    ldh a, [hPlayerY]
    cp b
    jr nz, .check_player_x
    ret

.check_player_x:
    ldh a, [hPlayerX]
    and $f0
    ld b, a
    ldh a, [hPlayerY]
    and $f0
    swap a
    or b
    ld b, a
    ld a, $01
    ld [wKeyWorldActive], a
    ld a, b
    ld [wKeyWorldGoal], a
    ld a, c
    ld [wKeyWorldGoalCell], a
    ld a, [wKeyWorldSlot]
    or $80
    ld [wKeyWorldKey], a
    ld a, $01
    ldh [hTempA], a
    ret

.done:
    pop hl
    ret

; ItemUsable_LogTwig_Sub01, on maps from $20, walks 4-byte records from $49A1 until $FF and returns
; at the first whose map id equals hMapId, whose screen byte equals hMapScreenX/Y and whose third or
; fourth byte equals the player's tile position; on no match it goes on to
; ItemUsable_LogTwig_WriteTempAAndSpriteSnapshotEtc_Data; 50 records then $FF (E-0193, C1)
; record: map id; screen XY; two tile positions ($FF = none)
LogTwigSpotList::
    db $20, $21, $44, $54 ; id 0
    db $20, $25, $44, $54 ; id 1
    db $20, $55, $44, $54 ; id 2
    db $30, $56, $44, $54 ; id 3
    db $30, $42, $44, $54 ; id 4
    db $30, $24, $44, $54 ; id 5
    db $30, $03, $44, $ff ; id 6
    db $30, $62, $44, $ff ; id 7
    db $30, $53, $44, $ff ; id 8
    db $48, $82, $44, $54 ; id 9
    db $48, $73, $44, $ff ; id 10
    db $48, $74, $44, $ff ; id 11
    db $48, $75, $44, $54 ; id 12
    db $48, $46, $44, $64 ; id 13
    db $48, $48, $44, $54 ; id 14
    db $48, $29, $44, $54 ; id 15
    db $48, $5a, $43, $53 ; id 16
    db $48, $99, $44, $54 ; id 17
    db $48, $a5, $44, $ff ; id 18
    db $48, $87, $44, $ff ; id 19
    db $48, $50, $44, $54 ; id 20
    db $48, $4a, $51, $61 ; id 21
    db $48, $79, $55, $65 ; id 22
    db $70, $b1, $44, $ff ; id 23
    db $70, $a4, $44, $ff ; id 24
    db $70, $94, $44, $ff ; id 25
    db $70, $56, $44, $54 ; id 26
    db $70, $04, $44, $ff ; id 27
    db $70, $36, $44, $ff ; id 28
    db $70, $37, $44, $ff ; id 29
    db $70, $59, $44, $54 ; id 30
    db $70, $89, $44, $ff ; id 31
    db $70, $99, $44, $ff ; id 32
    db $70, $5b, $44, $ff ; id 33
    db $70, $1b, $44, $ff ; id 34
    db $70, $ba, $44, $54 ; id 35
    db $70, $52, $44, $ff ; id 36
    db $70, $41, $44, $54 ; id 37
    db $a0, $12, $44, $ff ; id 38
    db $a8, $11, $44, $ff ; id 39
    db $a8, $24, $44, $54 ; id 40
    db $a8, $43, $44, $ff ; id 41
    db $a8, $51, $44, $ff ; id 42
    db $b0, $10, $44, $ff ; id 43
    db $b8, $43, $44, $54 ; id 44
    db $b8, $11, $35, $ff ; id 45
    db $b8, $40, $44, $ff ; id 46
    db $c8, $00, $44, $ff ; id 47
    db $d1, $01, $44, $ff ; id 48
    db $da, $10, $44, $ff ; id 49
    db $ff ; end

ItemUsable_LogTwig_Sub01_ReadTriggerKindAndPlayerXEtc::
    ld a, [wTriggerKind]
    cp $ff
    jr z, .return_0
    ldh a, [hPlayerX]
    and $f0
    ld c, a
    ldh a, [hPlayerY]
    swap a
    and $0f
    or c
    ld c, a
    ld a, [wTriggerCell]
    cp c
    jr nz, .return_0
    ld a, $01
    ret

.return_0:
    xor a
    ret

RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc::
    xor a
    ldh [hSpriteWindowClipMode], a
    ld a, [wMapType]
    bit 7, a
    jr nz, RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc_Data_ReadMapScreenX
    ldh a, [hMapId]
    ld c, a
    ld hl, RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc_Data
    ld b, $00

.skip:
    ld a, [hl]
    cp c
    jr z, .set_temp0
    inc b
    inc hl
    inc hl
    inc hl
    jr .skip

.set_temp0:
    ld a, b
    ldh [hTemp0], a
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or c
    ld c, a
    ld a, [wSpriteSnapshot]
    or a
    jr z, .next
    ld a, [wLogTwigKeyWorldKey]
    dec a
    cp b
    jr nz, .next
    ld a, [wLogTwigKeyWorldGoalCell]
    cp c
    jp nz, RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc_Data_CheckKeyWorldGoal
    ld a, [wLogTwigKeyWorldGoal]
    ld c, a
    call RunFieldReturnPhase_Case01_Sub02_WriteSVBK
    jr RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc_Data_CheckKeyWorldGoal

.next:
    inc hl
    inc hl
    ld a, [hl]
    cp c
    jr nz, RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc_Data_CheckKeyWorldGoal
    dec hl
    ld a, [hl]
    ld c, a
    call RunFieldReturnPhase_Case01_Sub02_WriteSVBK
    jr RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc_Data_CheckKeyWorldGoal

RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc_Data::
    db $20, $44, $00, $30, $44, $76, $48, $44, $b4, $70, $44, $b4, $a0, $44, $10, $a8
    db $44, $00, $b0, $44, $01, $b8, $44, $44, $c8, $44, $01, $d1, $44, $00, $da, $44
    db $00, $ff

RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc_Data_ReadMapScreenX::
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or c
    ld c, a
    ld a, [wSpriteSnapshot]
    or a
    jr z, .check_key_world_goal_screen
    ld a, [wLogTwigKeyWorldKey]
    bit 7, a
    jr z, .check_key_world_goal_screen
    and $7f
    ld b, a
    ld a, [wKeyWorldSlot]
    cp b
    jr nz, .check_key_world_goal_screen
    ld a, [wLogTwigKeyWorldGoalCell]
    cp c
    jr nz, RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc_Data_CheckKeyWorldGoal
    ld a, [wLogTwigKeyWorldGoal]
    ld c, a
    call RunFieldReturnPhase_Case01_Sub02_WriteSVBK
    jr RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc_Data_CheckKeyWorldGoal

.check_key_world_goal_screen:
    ld a, [wKeyWorldGoalScreen]
    cp c
    jr nz, RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc_Data_CheckKeyWorldGoal
    ld a, [wKeyWorldGoalPos]
    and $f0
    ld c, a
    ld a, [wKeyWorldGoalPos2]
    and $f0
    swap a
    or c
    ld c, a
    call RunFieldReturnPhase_Case01_Sub02_WriteSVBK
    jr RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc_Data_CheckKeyWorldGoal

RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc_Data_CheckKeyWorldGoal::
    ld a, [wKeyWorldGoal]
    and $0f
    ld l, a
    ld e, a
    ld h, $00
    ld d, $00
    sla l
    rl h
    sla l
    rl h
    add hl, de
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    ld a, [wKeyWorldGoal]
    and $f0
    swap a
    add a
    add_a_to_hl
    push hl
    ld a, l
    add $98
    ld l, a
    ld a, h
    adc $c1
    ld h, a
    ld [hl], $46
    inc hl
    ld [hl], $47
    ld a, $13
    add_a_to_hl
    ld [hl], $56
    inc hl
    ld [hl], $57
    pop hl
    ld a, [wIsCGB]
    or a
    jr z, .check_scroll_y
    ld c, $05
    ld a, [wMapType]
    bit 7, a
    jr nz, .skip
    ld c, $03
    ldh a, [hTemp0]
    cp $04
    jr z, .skip
    cp $0a
    jr z, .skip
    ld c, $05
    cp $05
    jr z, .skip
    cp $06
    jr z, .skip
    cp $07
    jr z, .skip
    ld c, $01

.skip:
    ld a, $02
    ldh [rSVBK], a
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $d0
    ld h, a
    ld a, c
    ld [hli], a
    ld [hl], a
    ld a, $13
    add_a_to_hl
    ld a, c
    ld [hli], a
    ld [hl], a
    ld a, $00
    ldh [rSVBK], a

.check_scroll_y:
    ldh a, [hScrollY]
    and $f8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add $00
    ld e, a
    ld a, d
    adc $98
    ld d, a
    ld a, d
    and $9b
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add e
    ld e, a
    jr nc, .call_draw_full_screen_buffer_to_bg_map
    inc d

.call_draw_full_screen_buffer_to_bg_map:
    ld l, e
    ld h, d
    call DrawFullScreenBufferToBGMap
    ret

RunFieldReturnPhase_Case01_Sub02_WriteSVBK::
    ld a, c
    and $0f
    ld l, a
    ld e, a
    ld h, $00
    ld d, $00
    sla l
    rl h
    sla l
    rl h
    add hl, de
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    ld a, c
    and $f0
    swap a
    add a
    add_a_to_hl
    push hl
    ld a, l
    add $98
    ld l, a
    ld a, h
    adc $c1
    ld h, a
    ld [hl], $40
    inc hl
    ld [hl], $41
    ld a, $13
    add_a_to_hl
    ld [hl], $50
    inc hl
    ld [hl], $51
    pop hl
    ld a, [wIsCGB]
    or a
    ret z
    ld c, $01
    ld a, [wMapType]
    bit 7, a
    jr nz, .skip2
    ld a, b
    ld de, RunFieldReturnPhase_Case01_Sub02_WriteSVBK_Data
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld c, a

.skip2:
    ld a, $02
    ldh [rSVBK], a
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $d0
    ld h, a
    ld a, c
    ld [hli], a
    ld [hl], a
    ld a, $13
    add_a_to_hl
    ld a, c
    ld [hli], a
    ld [hl], a
    ld a, $00
    ldh [rSVBK], a
    ret

RunFieldReturnPhase_Case01_Sub02_WriteSVBK_Data::
    db $01, $01, $03, $02, $02

; when wKeyWorldActive is set and key entry hTemp0 matches wKeyWorldKey, clears wKeyWorldActive
; (E-0127)
ClearKeyWorldActiveForMatchingKeyEntry::
    ld a, [wKeyWorldActive]
    or a
    ret z
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add $0a
    ld l, a
    ld a, h
    adc $c7
    ld h, a
    ld a, [hl]
    dec hl
    dec hl
    dec hl
    bit 7, a
    jr z, .skip
    ld a, [hl]
    ld c, a
    ld a, [wKeyWorldKey]
    bit 7, a
    ret nz
    dec a
    cp c
    ret nz
    ld a, $00
    ld [wKeyWorldActive], a
    ret

.skip:
    ld a, [hl]
    cp $ff
    ret z
    bit 7, a
    ret z
    and $3f
    ld c, a
    ld a, [wKeyWorldKey]
    bit 7, a
    ret z
    and $7f
    cp c
    ret nz
    ld a, $00
    ld [wKeyWorldActive], a
    ret

; DebugAutomap_Update_Sub01_Sub01_Sub0C reads the word at $4CCB + 2 * wKeyWorldAreaCount, skips the
; layout's first byte, and passes one 16-byte block per wKeyWorldFloorInfo entry (until $FF) to
; RunDebugAutomapCaseTemp0 with DE stepping through wKeyWorldFloorState by 16 (E-0193, C1)
; record: area layout
KeyWorldAreaLayoutTable::
    dw KeyWorldAreaLayout00 ; id 0
    dw KeyWorldAreaLayout01 ; id 1
    dw KeyWorldAreaLayout02 ; id 2
    dw KeyWorldAreaLayout03 ; id 3
    dw KeyWorldAreaLayout04 ; id 4
    dw KeyWorldAreaLayout05 ; id 5
    dw KeyWorldAreaLayout06 ; id 6
    dw KeyWorldAreaLayout07 ; id 7
    dw KeyWorldAreaLayout08 ; id 8
    dw KeyWorldAreaLayout09 ; id 9
    dw KeyWorldAreaLayout10 ; id 10
    dw KeyWorldAreaLayout11 ; id 11
    dw KeyWorldAreaLayout12 ; id 12
    dw KeyWorldAreaLayout13 ; id 13
    dw KeyWorldAreaLayout14 ; id 14
    dw KeyWorldAreaLayout15 ; id 15
    dw KeyWorldAreaLayout16 ; id 16
    dw KeyWorldAreaLayout17 ; id 17
    dw KeyWorldAreaLayout18 ; id 18
    dw KeyWorldAreaLayout19 ; id 19
    dw KeyWorldAreaLayout20 ; id 20
    dw KeyWorldAreaLayout21 ; id 21
    dw KeyWorldAreaLayout22 ; id 22
    dw KeyWorldAreaLayout23 ; id 23
    dw KeyWorldAreaLayout24 ; id 24
    dw KeyWorldAreaLayout25 ; id 25
    dw KeyWorldAreaLayout26 ; id 26
    dw KeyWorldAreaLayout27 ; id 27
    dw KeyWorldAreaLayout28 ; id 28
    dw KeyWorldAreaLayout29 ; id 29
    dw KeyWorldAreaLayout30 ; id 30
    dw KeyWorldAreaLayout31 ; id 31
    dw KeyWorldAreaLayout32 ; id 32
    dw KeyWorldAreaLayout33 ; id 33
    dw KeyWorldAreaLayout34 ; id 34
    dw KeyWorldAreaLayout35 ; id 35
    dw KeyWorldAreaLayout36 ; id 36
    dw KeyWorldAreaLayout37 ; id 37
    dw KeyWorldAreaLayout38 ; id 38
    dw KeyWorldAreaLayout39 ; id 39
    dw KeyWorldAreaLayout40 ; id 40
    dw KeyWorldAreaLayout41 ; id 41
    dw KeyWorldAreaLayout42 ; id 42
    dw KeyWorldAreaLayout43 ; id 43
    dw KeyWorldAreaLayout44 ; id 44
    dw KeyWorldAreaLayout45 ; id 45
    dw KeyWorldAreaLayout46 ; id 46
    dw KeyWorldAreaLayout47 ; id 47

; entry 0 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
; record: block count 3, then 3 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout00::
    db $03 ; entry 0: block count
    db $03, $0a, $9e, $e0, $c2, $00, $00, $00, $00, $0a, $9e, $e0, $c2, $00, $00, $00 ; block 0
    db $05, $03, $03, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $ff ; end

; entry 1 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout01::
    db $03 ; entry 0: block count
    db $03, $a6, $09, $6a, $c8, $00, $00, $00, $00, $a6, $09, $6a, $c8, $00, $00, $00 ; block 0
    db $04, $03, $03, $01, $2c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $ff ; end

; entry 2 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout02::
    db $03 ; entry 0: block count
    db $03, $b1, $8e, $08, $c6, $00, $00, $00, $00, $00, $8e, $08, $c6, $00, $00, $00 ; block 0
    db $04, $03, $03, $01, $2c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $ff ; end

; entry 3 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout03::
    db $03 ; entry 0: block count
    db $02, $69, $e5, $0a, $00, $bb, $92, $c9, $7b, $00, $00, $00, $00, $00, $00, $00 ; block 0
    db $05, $03, $03, $00, $2c, $00, $00, $01, $2a, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $ff ; end

; entry 4 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
; record: block count 4, then 4 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout04::
    db $04 ; entry 0: block count
    db $03, $af, $09, $72, $c0, $00, $00, $00, $00, $af, $09, $72, $c0, $00, $00, $00 ; block 0
    db $05, $04, $03, $01, $03, $00, $00, $02, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $02, $6c, $e5, $b4, $de, $bf, $97, $d4, $66, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $ff ; end

; entry 5 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout05::
    db $04 ; entry 0: block count
    db $03, $a2, $93, $08, $c3, $00, $00, $00, $00, $a2, $93, $08, $c3, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $2c, $00, $00, $02, $03, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $02, $73, $89, $b1, $d9, $ba, $84, $d5, $69, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $ff ; end

; entry 6 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout06::
    db $04 ; entry 0: block count
    db $03, $0a, $85, $6d, $ca, $00, $00, $00, $00, $0a, $85, $6d, $ca, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $03, $00, $00, $02, $12, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $02, $7c, $97, $a3, $c4, $b9, $9e, $da, $77, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $ff ; end

; entry 7 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout07::
    db $04 ; entry 0: block count
    db $03, $a1, $09, $66, $cb, $00, $00, $00, $00, $a1, $09, $66, $cb, $00, $00, $00 ; block 0
    db $05, $04, $03, $01, $0d, $00, $00, $02, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $02, $76, $94, $ad, $cf, $b6, $96, $d7, $68, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $ff ; end

; entry 8 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
; record: block count 4, then 4 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout08::
    db $04 ; entry 0: block count
    db $03, $b7, $90, $08, $db, $00, $00, $00, $00, $b7, $90, $08, $db, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $03, $00, $00, $02, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $05, $04, $03, $01, $0c, $00, $00, $02, $11, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $ff ; end

; entry 9 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout09::
    db $04 ; entry 0: block count
    db $03, $0a, $95, $6b, $ce, $00, $00, $00, $00, $0a, $95, $6b, $ce, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $2c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $04, $04, $03, $01, $0c, $00, $00, $02, $12, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $ff ; end

; entry 10 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout10::
    db $04 ; entry 0: block count
    db $01, $10, $31, $49, $08, $00, $00, $00, $00, $10, $31, $49, $08, $00, $00, $00 ; block 0
    db $04, $03, $03, $01, $0e, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $05, $04, $03, $01, $0f, $00, $00, $02, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $ff ; end

; entry 11 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout11::
    db $04 ; entry 0: block count
    db $01, $16, $37, $08, $e1, $00, $00, $00, $00, $16, $37, $08, $e1, $00, $00, $00 ; block 0
    db $05, $04, $03, $01, $03, $00, $00, $02, $10, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $04, $03, $03, $01, $11, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $ff ; end

; entry 12 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
; record: block count 4, then 4 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout12::
    db $04 ; entry 0: block count
    db $02, $7d, $09, $a5, $d1, $b3, $99, $d8, $62, $00, $00, $00, $00, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $05, $00, $00, $02, $0c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $03, $bc, $9d, $78, $c7, $00, $00, $00, $00, $bc, $9d, $78, $c7, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $ff ; end

; entry 13 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout13::
    db $04 ; entry 0: block count
    db $01, $2c, $08, $34, $3c, $00, $00, $00, $00, $2c, $08, $34, $3c, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $2c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $03, $b0, $e6, $ea, $cc, $00, $00, $00, $00, $b0, $e6, $ea, $cc, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $ff ; end

; entry 14 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout14::
    db $04 ; entry 0: block count
    db $01, $14, $42, $51, $08, $00, $00, $00, $00, $14, $42, $51, $08, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $2c, $00, $00, $02, $0c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $03, $bd, $8d, $6e, $cd, $00, $00, $00, $00, $bd, $8d, $6e, $cd, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $ff ; end

; entry 15 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout15::
    db $04 ; entry 0: block count
    db $02, $08, $8a, $e4, $d2, $ac, $98, $d6, $65, $00, $00, $00, $00, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $0c, $00, $00, $02, $0d, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $01, $1c, $32, $3a, $3b, $00, $00, $00, $00, $1c, $32, $3a, $3b, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $ff ; end

; entry 16 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
; record: block count 5, then 5 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout16::
    db $05 ; entry 0: block count
    db $02, $7e, $9b, $0a, $d0, $a9, $8f, $d3, $6f, $00, $00, $00, $00, $00, $00, $00 ; block 0
    db $04, $03, $03, $01, $05, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $03, $b2, $88, $71, $df, $00, $00, $00, $00, $b2, $88, $71, $df, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $05, $03, $02, $2c, $00, $00, $03, $12, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $ff ; end

; entry 17 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout17::
    db $05 ; entry 0: block count
    db $02, $71, $09, $aa, $d1, $ae, $91, $dc, $62, $00, $00, $00, $00, $00, $00, $00 ; block 0
    db $04, $05, $03, $01, $05, $00, $00, $03, $0c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $03, $b5, $9c, $7a, $dd, $00, $00, $00, $00, $b5, $9c, $7a, $dd, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $05, $03, $02, $10, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $ff ; end

; entry 18 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout18::
    db $05 ; entry 0: block count
    db $03, $be, $9a, $08, $d9, $00, $00, $00, $00, $be, $9a, $64, $d9, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $11, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $02, $6a, $95, $b9, $d3, $b3, $85, $c8, $01, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $05, $03, $02, $05, $00, $00, $03, $0f, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $ff ; end

; entry 19 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout19::
    db $05 ; entry 0: block count
    db $03, $0a, $e6, $eb, $cc, $00, $00, $00, $00, $0a, $e6, $eb, $cc, $00, $00, $00 ; block 0
    db $04, $05, $03, $01, $11, $00, $00, $03, $03, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $02, $69, $84, $ab, $d8, $a4, $8c, $dd, $6d, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $05, $03, $02, $2c, $00, $00, $03, $0c, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $ff ; end

; entry 20 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
; record: block count 5, then 5 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout20::
    db $05 ; entry 0: block count
    db $03, $a1, $09, $67, $cb, $00, $00, $00, $00, $a1, $09, $67, $cb, $00, $00, $00 ; block 0
    db $04, $03, $03, $01, $03, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $01, $13, $35, $e1, $47, $00, $00, $00, $00, $13, $35, $e1, $47, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $05, $03, $01, $2c, $00, $00, $03, $0e, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $ff ; end

; entry 21 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout21::
    db $05 ; entry 0: block count
    db $03, $a1, $89, $08, $cb, $00, $00, $00, $00, $a1, $89, $08, $cb, $00, $00, $00 ; block 0
    db $05, $05, $03, $01, $05, $00, $00, $03, $03, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $01, $28, $38, $56, $e3, $00, $00, $00, $00, $28, $38, $56, $e3, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $05, $03, $02, $2c, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $ff ; end

; entry 22 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout22::
    db $05 ; entry 0: block count
    db $03, $0a, $8b, $ea, $cd, $00, $00, $00, $00, $0a, $8b, $ea, $cd, $00, $00, $00 ; block 0
    db $02, $75, $e5, $ad, $db, $ba, $8c, $de, $6c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $04, $04, $03, $01, $0f, $00, $00, $02, $0d, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $05, $03, $02, $12, $00, $00, $03, $10, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $ff ; end

; entry 23 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout23::
    db $05 ; entry 0: block count
    db $03, $a0, $09, $7e, $ca, $00, $00, $00, $00, $a0, $09, $7e, $ca, $00, $00, $00 ; block 0
    db $02, $63, $94, $bb, $da, $b3, $9b, $df, $72, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $05, $03, $03, $01, $0f, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $06, $03, $02, $2c, $00, $00, $04, $05, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $ff ; end

; entry 24 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
; record: block count 5, then 5 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout24::
    db $05 ; entry 0: block count
    db $03, $a5, $83, $08, $d7, $00, $00, $00, $00, $a5, $83, $08, $d7, $00, $00, $00 ; block 0
    db $02, $ef, $93, $b4, $c3, $be, $99, $dc, $74, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $01, $15, $5f, $50, $45, $00, $00, $00, $00, $15, $5f, $50, $45, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $07, $03, $02, $0c, $00, $00, $04, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $ff ; end

; entry 25 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout25::
    db $05 ; entry 0: block count
    db $03, $0a, $8a, $6b, $c2, $00, $00, $00, $00, $0a, $8a, $6b, $c2, $00, $00, $00 ; block 0
    db $02, $71, $91, $ac, $d2, $b2, $98, $d5, $79, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $01, $23, $30, $39, $4a, $00, $00, $00, $00, $23, $30, $39, $4a, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $06, $03, $02, $11, $00, $00, $04, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $ff ; end

; entry 26 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout26::
    db $05 ; entry 0: block count
    db $01, $1d, $3f, $e2, $08, $00, $00, $00, $00, $1d, $3f, $e2, $08, $00, $00, $00 ; block 0
    db $04, $05, $03, $01, $0e, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $05, $03, $03, $01, $0d, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $08, $03, $02, $2c, $00, $00, $05, $05, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $ff ; end

; entry 27 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout27::
    db $05 ; entry 0: block count
    db $01, $19, $58, $08, $4b, $00, $00, $00, $00, $19, $58, $08, $4b, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $10, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $04, $04, $03, $01, $0d, $00, $00, $02, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $08, $03, $02, $03, $00, $00, $05, $0f, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $ff ; end

; entry 28 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
; record: block count 6, then 6 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout28::
    db $06 ; entry 0: block count
    db $01, $2d, $08, $e3, $3e, $00, $00, $00, $00, $2d, $08, $e3, $3e, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $0e, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $03, $b0, $96, $7b, $cf, $00, $00, $00, $00, $b0, $96, $7b, $cf, $00, $00, $00 ; block 2
    db $04, $04, $03, $01, $0d, $00, $00, $02, $0c, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $05, $08, $03, $02, $11, $00, $00, $05, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $ff ; end

; entry 29 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout29::
    db $06 ; entry 0: block count
    db $01, $1b, $59, $4c, $08, $00, $00, $00, $00, $1b, $59, $4c, $08, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $0e, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $03, $af, $e7, $78, $ce, $00, $00, $00, $00, $af, $e7, $78, $ce, $00, $00, $00 ; block 2
    db $04, $04, $03, $01, $0d, $00, $00, $02, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $04, $05, $03, $02, $2c, $00, $00, $03, $11, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $ff ; end

; entry 30 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout30::
    db $06 ; entry 0: block count
    db $01, $20, $5d, $08, $5a, $00, $00, $00, $00, $20, $5d, $08, $5a, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $12, $00, $00, $02, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $05, $03, $03, $01, $0c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 2
    db $03, $b1, $9e, $73, $ee, $00, $00, $00, $00, $b1, $9e, $73, $ee, $00, $00, $00 ; block 3
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $04, $06, $03, $02, $05, $00, $00, $04, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $ff ; end

; entry 31 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout31::
    db $06 ; entry 0: block count
    db $01, $22, $08, $53, $54, $00, $00, $00, $00, $22, $08, $53, $54, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $2c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $05, $03, $03, $01, $05, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 2
    db $03, $b8, $e7, $68, $d0, $00, $00, $00, $00, $b8, $e7, $68, $d0, $00, $00, $00 ; block 3
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $04, $09, $03, $02, $2c, $00, $00, $05, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $ff ; end

; entry 32 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
; record: block count 7, then 7 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout32::
    db $07 ; entry 0: block count
    db $03, $0a, $9d, $7f, $cf, $00, $00, $00, $00, $0a, $9d, $7f, $cf, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $0c, $00, $00, $02, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $04, $03, $03, $01, $11, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 2
    db $02, $75, $82, $e4, $c1, $03, $88, $c4, $6e, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $04, $03, $01, $05, $00, $00, $02, $12, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $05, $07, $03, $01, $0f, $00, $00, $04, $10, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $ff ; end

; entry 33 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout33::
    db $07 ; entry 0: block count
    db $03, $bc, $09, $7d, $c9, $00, $00, $00, $00, $bc, $09, $7d, $c9, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $0c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $05, $03, $03, $01, $11, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 2
    db $02, $70, $e6, $a9, $c0, $b7, $8f, $c6, $77, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $03, $03, $01, $05, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 4
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $04, $06, $03, $02, $2c, $00, $00, $03, $0f, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $ff ; end

; entry 34 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout34::
    db $07 ; entry 0: block count
    db $03, $b5, $95, $08, $c1, $00, $00, $00, $00, $b5, $95, $08, $c1, $00, $00, $00 ; block 0
    db $04, $03, $03, $01, $0d, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $04, $04, $03, $01, $0e, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 2
    db $04, $05, $03, $01, $0f, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $02, $76, $87, $a7, $c7, $ae, $8e, $d3, $7c, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $04, $04, $03, $01, $11, $00, $00, $02, $0c, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $ff ; end

; entry 35 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout35::
    db $07 ; entry 0: block count
    db $03, $0a, $e8, $7e, $f1, $00, $00, $00, $00, $0a, $e8, $7e, $f1, $00, $00, $00 ; block 0
    db $05, $04, $03, $01, $0d, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $05, $03, $03, $01, $2c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 2
    db $05, $04, $03, $01, $0f, $00, $00, $02, $12, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $02, $65, $8c, $a8, $c5, $b9, $92, $d2, $73, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $05, $07, $03, $02, $2c, $00, $00, $04, $0c, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $ff ; end

; entry 36 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
; record: block count 7, then 7 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout36::
    db $07 ; entry 0: block count
    db $03, $b7, $09, $7b, $f0, $00, $00, $00, $00, $b7, $09, $7b, $f0, $00, $00, $00 ; block 0
    db $04, $05, $03, $01, $11, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $02, $6e, $e8, $aa, $ee, $b3, $93, $db, $79, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $04, $04, $03, $01, $12, $00, $00, $02, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $01, $2b, $4e, $55, $35, $00, $00, $00, $00, $2b, $4e, $55, $35, $00, $00, $00 ; block 4
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $05, $06, $03, $02, $2c, $00, $00, $04, $0d, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $ff ; end

; entry 37 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout37::
    db $07 ; entry 0: block count
    db $03, $b5, $99, $08, $da, $00, $00, $00, $00, $b5, $99, $08, $da, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $11, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $02, $64, $82, $a4, $c3, $ab, $8a, $d0, $6c, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $05, $04, $03, $01, $12, $00, $00, $02, $0f, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $01, $2f, $33, $4a, $04, $00, $00, $00, $00, $2f, $33, $4a, $04, $00, $00, $00 ; block 4
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $04, $07, $03, $02, $2c, $00, $00, $05, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $ff ; end

; entry 38 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout38::
    db $07 ; entry 0: block count
    db $03, $0a, $e7, $ec, $cf, $00, $00, $00, $00, $0a, $e7, $ec, $cf, $00, $00, $00 ; block 0
    db $04, $03, $03, $01, $2c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $04, $05, $03, $01, $0e, $00, $00, $03, $11, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $04, $06, $03, $01, $03, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $07, $03, $01, $0c, $00, $00, $03, $05, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $05, $04, $03, $01, $12, $00, $00, $02, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $ff ; end

; entry 39 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout39::
    db $07 ; entry 0: block count
    db $03, $ad, $09, $71, $f0, $00, $00, $00, $00, $ad, $09, $71, $f0, $00, $00, $00 ; block 0
    db $05, $04, $03, $01, $0d, $00, $00, $02, $03, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $05, $04, $03, $01, $0e, $00, $00, $02, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $05, $03, $03, $01, $2c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 3
    db $05, $03, $03, $01, $0c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 4
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $04, $07, $03, $02, $2c, $00, $00, $05, $11, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $ff ; end

; entry 40 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
; record: block count 8, then 8 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout40::
    db $08 ; entry 0: block count
    db $03, $b8, $91, $08, $f1, $00, $00, $00, $00, $b8, $91, $08, $f1, $00, $00, $00 ; block 0
    db $04, $06, $03, $01, $0d, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $04, $05, $03, $01, $0e, $00, $00, $03, $03, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $02, $62, $e9, $a5, $c2, $b1, $8b, $d1, $6b, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $03, $03, $01, $12, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 4
    db $01, $2e, $3b, $44, $3d, $00, $00, $00, $00, $2e, $3b, $44, $3d, $00, $00, $00 ; block 5
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $04, $07, $03, $02, $05, $00, $00, $05, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 7
    db $ff ; end

; entry 41 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout41::
    db $08 ; entry 0: block count
    db $03, $0a, $98, $74, $d8, $00, $00, $00, $00, $0a, $98, $74, $d8, $00, $00, $00 ; block 0
    db $05, $07, $03, $01, $0d, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $05, $03, $03, $01, $0c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 2
    db $02, $69, $96, $a2, $ca, $ac, $8f, $d4, $6d, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $03, $03, $01, $11, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 4
    db $01, $2a, $43, $49, $57, $00, $00, $00, $00, $2a, $43, $49, $57, $00, $00, $00 ; block 5
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $05, $06, $03, $02, $2c, $00, $00, $04, $05, $00, $00, $00, $00, $00, $00, $00 ; block 7
    db $ff ; end

; entry 42 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout42::
    db $08 ; entry 0: block count
    db $01, $2d, $5a, $5e, $08, $00, $00, $00, $00, $2d, $5a, $5e, $08, $00, $00, $00 ; block 0
    db $04, $03, $03, $01, $11, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 1
    db $03, $a7, $e9, $ed, $c4, $00, $00, $00, $00, $a7, $e9, $ed, $c4, $00, $00, $00 ; block 2
    db $01, $24, $45, $47, $53, $00, $00, $00, $00, $24, $45, $47, $53, $00, $00, $00 ; block 3
    db $04, $04, $03, $01, $0d, $00, $00, $02, $10, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $05, $03, $03, $01, $03, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 5
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $04, $07, $03, $02, $2c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 7
    db $ff ; end

; entry 43 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout43::
    db $08 ; entry 0: block count
    db $01, $29, $3a, $08, $42, $00, $00, $00, $00, $29, $3a, $08, $42, $00, $00, $00 ; block 0
    db $05, $06, $03, $01, $11, $00, $00, $03, $12, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $03, $b4, $8d, $75, $cd, $00, $00, $00, $00, $b4, $8d, $75, $cd, $00, $00, $00 ; block 2
    db $01, $26, $4c, $34, $58, $00, $00, $00, $00, $26, $4c, $34, $58, $00, $00, $00 ; block 3
    db $05, $06, $03, $01, $0e, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $04, $03, $03, $01, $03, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 5
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $05, $07, $03, $04, $2c, $00, $00, $05, $0f, $00, $00, $00, $00, $00, $00, $00 ; block 7
    db $ff ; end

; entry 44 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
; record: block count 8, then 8 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout44::
    db $08 ; entry 0: block count
    db $01, $2c, $08, $52, $4d, $00, $00, $00, $00, $2c, $08, $52, $4d, $00, $00, $00 ; block 0
    db $04, $09, $03, $01, $2c, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $03, $af, $9d, $7a, $c7, $00, $00, $00, $00, $af, $9d, $7a, $c7, $00, $00, $00 ; block 2
    db $04, $09, $03, $01, $2c, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $01, $2b, $40, $3c, $54, $00, $00, $00, $00, $2b, $40, $3c, $54, $00, $00, $00 ; block 4
    db $04, $09, $03, $01, $2c, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $04, $09, $03, $02, $2c, $00, $00, $05, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 7
    db $ff ; end

; entry 45 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout45::
    db $08 ; entry 0: block count
    db $01, $17, $39, $5f, $08, $00, $00, $00, $00, $17, $39, $5f, $08, $00, $00, $00 ; block 0
    db $05, $09, $03, $01, $0d, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $02, $63, $88, $a3, $c8, $ba, $9f, $dc, $6f, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $05, $09, $03, $01, $2c, $00, $00, $03, $10, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $01, $18, $50, $3e, $5d, $00, $00, $00, $00, $18, $50, $3e, $5d, $00, $00, $00 ; block 4
    db $05, $09, $03, $01, $12, $00, $00, $03, $05, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $05, $09, $03, $02, $11, $00, $00, $05, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 7
    db $ff ; end

; entry 46 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout46::
    db $08 ; entry 0: block count
    db $01, $1f, $31, $08, $56, $00, $00, $00, $00, $1f, $31, $08, $56, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $2c, $00, $00, $02, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $04, $04, $03, $01, $0f, $00, $00, $02, $12, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $04, $04, $03, $01, $05, $00, $00, $02, $11, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $04, $03, $01, $03, $00, $00, $02, $10, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $04, $03, $03, $01, $0c, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00 ; block 5
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $05, $09, $03, $03, $0e, $00, $00, $05, $0d, $00, $00, $00, $00, $00, $00, $00 ; block 7
    db $ff ; end

; entry 47 of KeyWorldAreaLayoutTable; size 2 + 16 * count (E-0193, C1)
KeyWorldAreaLayout47::
    db $08 ; entry 0: block count
    db $01, $1e, $08, $4e, $55, $00, $00, $00, $00, $1e, $08, $4e, $55, $00, $00, $00 ; block 0
    db $05, $04, $03, $01, $0e, $00, $00, $03, $03, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $05, $06, $03, $01, $2c, $00, $00, $03, $10, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $05, $04, $03, $01, $0d, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $06, $03, $01, $11, $00, $00, $03, $12, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $05, $05, $03, $01, $0c, $00, $00, $03, $2c, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $04, $09, $03, $02, $2c, $00, $00, $05, $11, $00, $00, $00, $00, $00, $00, $00 ; block 7
    db $ff ; end
    ds $21f5, $00
