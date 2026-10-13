SECTION "Bank 84", ROMX[$4000], BANK[$84]
    db $84

; only called from DebugAutomap_Update_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_DebugAutomap_Update_MergeKeyWorldAreas)
; reads: wKeyWorldAreaCount, hTemp8, hTemp9
; writes: wKeyWorldByte46, hTemp8, hTemp9, hTemp0
; points at: wKeyWorldFloorState
DebugAutomap_Update_Sub01_Sub01_WriteKeyWorldByte46AndTemp8Etc::
Func_084_4001:: ; address name
    xor a, a
    ld [wKeyWorldByte46], a
    ld a, [wKeyWorldAreaCount]
    add a, a
    ld hl, KeyWorldAreaLayoutTable
    add_a_to_hl
    ld a, [hl+]
    ldh [hTemp8], a
    ld a, [hl]
    ldh [hTemp9], a
    ldh a, [hTemp8]
    add a, $01
    ldh [hTemp8], a
    ldh a, [hTemp9]
    adc a, $00
    ldh [hTemp9], a
    ld hl, wKeyWorldFloorInfo + $3
    ld de, wKeyWorldFloorState

.skip:
    ld a, [hl]
    cp a, $FF
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
    add a, e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    jr .skip

; debug automap: runs the routine for hTemp0 (jump table of seven) (E-0122)
; 1 call site from 1 routine (e.g. DebugAutomap_Update_Sub01_Sub01_WriteKeyWorldByte46AndTemp8Etc)
; reads: hTemp0
RunDebugAutomapCaseTemp0::
Func_084_405C:: ; address name
    ldh a, [hTemp0]
    rst $00
    dw RunDebugAutomapCaseTemp0_Return
    dw RunDebugAutomapCaseTemp0_ReadKeyWorldGoalKindAndTemp8Etc
    dw RunDebugAutomapCaseTemp0_NextRandomSeed
    dw RunDebugAutomapCaseTemp0_NextRandomSeed_Case03
    dw RunDebugAutomapCaseTemp0_NextRandomSeed_Case04
    dw RunDebugAutomapCaseTemp0_NextRandomSeed_Case05
    dw RunDebugAutomapCaseTemp0_ReturnAfterSetup

; entry 0 of the `rst $00` table in RunDebugAutomapCaseTemp0
; no direct call (reached through a table, a jump or a vector)
RunDebugAutomapCaseTemp0_Return::
Jump_084_406D:: ; address name
    ret

; entry 6 of the `rst $00` table in RunDebugAutomapCaseTemp0
; no direct call (reached through a table, a jump or a vector)
RunDebugAutomapCaseTemp0_ReturnAfterSetup::
Jump_084_406E:: ; address name
    ld a, $54
    ld [de], a
    ret

; entry 1 of the `rst $00` table in RunDebugAutomapCaseTemp0
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldGoalKind, hTemp8, hTemp9
RunDebugAutomapCaseTemp0_ReadKeyWorldGoalKindAndTemp8Etc::
Jump_084_4072:: ; address name
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
    ld b, $0E

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

; entry 2 of the `rst $00` table in RunDebugAutomapCaseTemp0
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldGoalKind, wKeyRandomHi, hTemp8, hTemp9
RunDebugAutomapCaseTemp0_NextRandomSeed::
Jump_084_4091:: ; address name
    ld hl, RunDebugAutomapCaseTemp0_NextRandomSeed_Data
    ld a, [wKeyWorldGoalKind]
    add_a_to_hl
    ld a, [hl]
    add a, $20
    ld [de], a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    srl a
    and a, $01
    jr z, .read_temp8
    ld a, [de]
    or a, $80
    ld [de], a

.read_temp8:
    inc de
    inc de
    ldh a, [hTemp8]
    ld l, a
    ldh a, [hTemp9]
    ld h, a
    inc hl
    ld b, $0E

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

; entry 3 of the `rst $00` table in RunDebugAutomapCaseTemp0
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyWorldGoalKind, wKeyRandomHi, hTemp8, hTemp9
RunDebugAutomapCaseTemp0_NextRandomSeed_Case03::
Jump_084_40C2:: ; address name
    ld hl, RunDebugAutomapCaseTemp0_NextRandomSeed_Data
    ld a, [wKeyWorldGoalKind]
    add_a_to_hl
    ld a, [hl]
    add a, $40
    ld [de], a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    srl a
    and a, $01
    jr z, .read_temp8
    ld a, [de]
    or a, $80
    ld [de], a

.read_temp8:
    inc de
    inc de
    ldh a, [hTemp8]
    ld l, a
    ldh a, [hTemp9]
    ld h, a
    inc hl
    ld b, $0E

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

; entry 4 of the `rst $00` table in RunDebugAutomapCaseTemp0
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp8, hTemp9, wKeyWorldByte46, wKeyWorldGoalKind, wKeyRandomHi
; writes: hTemp0
RunDebugAutomapCaseTemp0_NextRandomSeed_Case04::
Jump_084_40F3:: ; address name
    ldh a, [hTemp8]
    ld l, a
    ldh a, [hTemp9]
    ld h, a
    inc hl
    ld a, [hl+]
    ld [de], a
    ldh [hTemp0], a
    push hl
    inc de
    ld a, [wKeyWorldByte46]
    ld [de], a
    inc de
    ld a, [wKeyWorldGoalKind]
    add a, a
    add a, a
    ld hl, RunDebugAutomapCaseTemp0_NextRandomSeed_Case04_Data
    add_a_to_hl
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $03
    add_a_to_hl
    ld a, [hl]
    ld [de], a
    pop hl
    inc de
    push de
    ld b, $0D

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    pop de
    inc de
    ld a, [de]
    cp a, $FF
    jr z, .call_run_debug_automap_case_temp0_random
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $07
    inc de
    inc de
    ld [de], a
    inc de
    inc de
    ld a, [de]
    cp a, $FF
    jr z, .call_run_debug_automap_case_temp0_random
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $07
    inc de
    inc de
    ld [de], a

.call_run_debug_automap_case_temp0_random:
    ld a, $01
    call RunDebugAutomapCaseTemp0_RandomBelowC
    ret

; entry 5 of the `rst $00` table in RunDebugAutomapCaseTemp0
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp8, hTemp9, wKeyWorldByte46, wKeyRandomHi
; writes: hTemp0
RunDebugAutomapCaseTemp0_NextRandomSeed_Case05::
Jump_084_4156:: ; address name
    ldh a, [hTemp8]
    ld l, a
    ldh a, [hTemp9]
    ld h, a
    inc hl
    ld a, [hl+]
    ld [de], a
    ldh [hTemp0], a
    push hl
    inc de
    ld a, [wKeyWorldByte46]
    ld [de], a
    inc de
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $07
    ld hl, RunDebugAutomapCaseTemp0_NextRandomSeed_Case05_Data
    add_a_to_hl
    ld a, [hl]
    ld [de], a
    pop hl
    inc de
    push de
    ld b, $0D

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    pop de
    inc de
    ld a, [de]
    cp a, $FF
    jr z, .call_run_debug_automap_case_temp0_random
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $07
    inc de
    inc de
    ld [de], a
    inc de
    inc de
    ld a, [de]
    cp a, $FF
    jr z, .call_run_debug_automap_case_temp0_random
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $07
    inc de
    inc de
    ld [de], a

.call_run_debug_automap_case_temp0_random:
    xor a, a
    call RunDebugAutomapCaseTemp0_RandomBelowC
    ret

; address loaded by RunDebugAutomapCaseTemp0_ReadKeyWorldGoalKindAndTemp8Etc
RunDebugAutomapCaseTemp0_ReadKeyWorldGoalKindAndTemp8Etc_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_084_41AE:: ; address name
    db $00, $00, $03, $01, $00, $00, $04, $05, $02, $00

; address loaded by RunDebugAutomapCaseTemp0_NextRandomSeed, RunDebugAutomapCaseTemp0_NextRandomSeed_Case03
RunDebugAutomapCaseTemp0_NextRandomSeed_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_084_41B8:: ; address name
    db $00, $06, $03, $01, $07, $08, $04, $05, $02, $09

; address loaded by RunDebugAutomapCaseTemp0_NextRandomSeed_Case05
RunDebugAutomapCaseTemp0_NextRandomSeed_Case05_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_084_41C2:: ; address name
    db $05, $06, $07, $08, $09, $05, $07, $09

; address loaded by RunDebugAutomapCaseTemp0_NextRandomSeed_Case04
RunDebugAutomapCaseTemp0_NextRandomSeed_Case04_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_084_41CA:: ; address name
    db $00, $0B, $00, $0B, $00, $02, $00, $02, $02, $03, $0B, $02, $02, $04, $02, $04
    db $01, $01, $01, $01, $01, $03, $01, $03, $00, $04, $00, $04, $01, $04, $01, $04
    db $01, $03, $0B, $01, $00, $0B, $00, $0B

; only called from routines of RunDebugAutomapCaseTemp0 (E-0098)
; 2 call sites from 2 routines (e.g. RunDebugAutomapCaseTemp0_NextRandomSeed_Case05, RunDebugAutomapCaseTemp0_NextRandomSeed_Case04)
; reads: wKeyWorldByte46, hTemp2, hTemp4, hTemp0, hTemp3
; writes: hTemp2, hTemp3, wKeyWorldByte46
; points at: wKeyWorldRoomTable
RunDebugAutomapCaseTemp0_RandomBelowC::
Func_084_41F2:: ; address name
    push af
    ld a, [wKeyWorldByte46]
    add a, a
    ld hl, wKeyWorldRoomTable
    add_a_to_hl
    pop af
    or a, a
    jr nz, .clear_temp2
    ld a, $A0
    ldh [hTemp2], a
    call NextRandomSeed
    and a, $03
    add a, a
    add a, a
    add a, a
    ld c, a
    ldh a, [hTemp2]
    add a, c
    ldh [hTemp2], a
    ld c, $05
    call RandomBelowC
    ld c, a
    ldh a, [hTemp2]
    add a, c
    ldh [hTemp2], a
    ld [hl+], a
    ldh a, [hTemp2]
    ld e, a
    ld d, $00
    sla e
    rl d
    call RunDebugAutomapCaseTemp0_Shared01_ReadByteInBank
    ldh a, [hTemp4]
    swap a
    or a, $0F
    ld [hl+], a
    ld a, $0F
    ldh [hTemp3], a
    ld a, [wKeyWorldByte46]
    inc a
    ld [wKeyWorldByte46], a
    jr .check_temp0

.clear_temp2:
    xor a, a
    ldh [hTemp2], a
    ld c, $09
    call RandomBelowC
    sla a
    sla a
    sla a
    ld c, a
    ldh a, [hTemp2]
    add a, c
    ldh [hTemp2], a
    ld c, $08
    call RandomBelowC
    ld c, a
    ldh a, [hTemp2]
    add a, c
    ldh [hTemp2], a
    ld [hl+], a
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
    or a, c
    ld [hl+], a
    ld a, [wKeyWorldByte46]
    inc a
    ld [wKeyWorldByte46], a

.check_temp0:
    ldh a, [hTemp0]
    dec a
    dec a
    ld b, a

.loop:
    push bc
    ldh a, [hTemp4]
    and a, $0F
    swap a
    ld de, KeyWorldMonsterBaseRows
    add a, e
    ld e, a
    jr nc, .call_random_below_c
    inc d

.call_random_below_c:
    ld c, $0A
    call RandomBelowC
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld b, a
    ld c, $08
    call RandomBelowC
    add a, b
    ld [hl+], a
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
    or a, c
    ld [hl+], a
    ld a, [wKeyWorldByte46]
    inc a
    ld [wKeyWorldByte46], a
    pop bc
    dec b
    jr nz, .loop
    ret

; E-0193 (C1: RunDebugAutomapCaseTemp0_RandomBelowC.loop reads the byte at $42C7 + 16 * (hTemp4 & $0F) + a random 0-9, adds a random 0-7, stores the sum and uses it doubled as an index for RunDebugAutomapCaseTemp0_Shared01_Sub01; 6 rows end at that routine).
; record: ten base values, then six zero bytes
KeyWorldMonsterBaseRows::
Data_084_42C7:: ; address name
    db $00, $08, $10, $18, $20, $28, $30, $38, $40, $48, $00, $00, $00, $00, $00, $00 ; id 0
    db $00, $08, $10, $18, $50, $58, $60, $68, $70, $78, $00, $00, $00, $00, $00, $00 ; id 1
    db $00, $20, $28, $30, $50, $58, $60, $80, $88, $90, $00, $00, $00, $00, $00, $00 ; id 2
    db $08, $20, $38, $40, $50, $68, $70, $80, $88, $98, $00, $00, $00, $00, $00, $00 ; id 3
    db $10, $28, $38, $48, $58, $68, $78, $80, $90, $98, $00, $00, $00, $00, $00, $00 ; id 4
    db $18, $30, $40, $48, $60, $70, $78, $88, $90, $98, $00, $00, $00, $00, $00, $00 ; id 5

; only called from RunDebugAutomapCaseTemp0_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. RunDebugAutomapCaseTemp0_RandomBelowC)
; reads: hTemp3
; writes: hTemp4
RunDebugAutomapCaseTemp0_Shared01_ReadByteInBank_Sub01::
Func_084_4327:: ; address name
    push hl
    ld a, e
    add a, $01
    ld e, a
    ld a, d
    adc a, $40
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
    and a, $03
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
    cp a, c
    jr z, .loop
    ld a, c
    ldh [hTemp4], a
    pop hl
    ret

; only called from RunDebugAutomapCaseTemp0_Shared01 (E-0047)
; 2 call sites from 1 routine (e.g. RunDebugAutomapCaseTemp0_RandomBelowC)
; reads: hTemp3
; writes: hTemp3, hTemp4
RunDebugAutomapCaseTemp0_Shared01_ReadByteInBank::
Func_084_435C:: ; address name
    push hl
    ld a, e
    add a, $01
    ld e, a
    ld a, d
    adc a, $40
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
    and a, $03
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
    and a, $03
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
    cp a, c
    jr z, .loop2
    ld a, c
    ldh [hTemp4], a
    pop hl
    ret

; repeats NextRandomSeed until wKeyRandomHi & $0F is below C (C must be 1-16); returns A = that value (E-0077)
; 5 call sites from 1 routine (e.g. RunDebugAutomapCaseTemp0_RandomBelowC)
; reads: wKeyRandomHi
RandomBelowC::
Func_084_43AC:: ; address name
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $0F
    cp a, c
    jr nc, RandomBelowC
    ret

; for each 8-byte entry of Data_084_4461 matching hMapId and the screen position, with its story flag set, runs Func_084_43F2 (hTemp0 = its value) (E-0125)
; 3 call sites from 3 routines (e.g. LoadMapScreen, RunOneTimeTreasure_ApplyMapScreenFlagEvents, SetFlagRedraw)
; reads: hMapId, hMapScreenX, hMapScreenY
; writes: hTemp0
ApplyMapScreenFlagEvents::
Func_084_43B8:: ; address name
    ld hl, MapScreenFlagTiles

.skip:
    push hl
    ld a, [hl+]
    cp a, $FF
    jr nz, .check_map_id
    pop hl
    ret

.check_map_id:
    ld c, a
    ldh a, [hMapId]
    cp a, c
    jr nz, .restore
    ld a, [hl+]
    ld c, a
    ldh a, [hMapScreenX]
    cp a, c
    jr nz, .restore
    ld a, [hl+]
    ld c, a
    ldh a, [hMapScreenY]
    cp a, c
    jr nz, .restore
    ld a, [hl+]
    ldh [hTemp0], a
    ld a, [hl+]
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

; only called from ApplyMapScreenFlagEvents (E-0047)
; 1 call site from 1 routine (e.g. ApplyMapScreenFlagEvents)
; reads: hTemp0, wIsCGB
; writes: rSVBK
ApplyMapScreenFlagEvents_WriteSVBK::
Func_084_43F2:: ; address name
    ldh a, [hTemp0]
    cp a, $FF
    jr z, .skip
    ld a, $06
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, e
    add a, $98
    ld e, a
    ld a, d
    adc a, $C1
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
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    push de
    ld a, e
    add a, $98
    ld e, a
    ld a, d
    adc a, $C1
    ld d, a
    ld a, $40
    ld [de], a
    inc a
    inc de
    ld [de], a
    ld a, $13
    add a, e
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
    or a, a
    ret z
    ld a, $02
    ldh [rSVBK], a
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $D0
    ld d, a
    ld a, $05
    ld [de], a
    inc de
    ld [de], a
    ld a, $13
    add a, e
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

; E-0151 (C1: ApplyMapScreenFlagEvents walks these 8-byte entries until $FF; when hMapId and hMapScreenX/Y match and the story flag is set, ApplyMapScreenFlagEvents_Sub01 writes the tile and tile + 1 at wScreenTileBuffer + offset (tile $FF takes another path); 108 entries).
; record: map number, screen X, screen Y, tile; story flag number (TestFlagBit); offset into wScreenTileBuffer
MapScreenFlagTiles::
Data_084_4461:: ; address name
    db $19, $00, $02, $3E ; id 0
    dw $011B
    dw $0088
    db $19, $00, $02, $3E ; id 1
    dw $011C
    dw $0100
    db $1B, $00, $02, $1A ; id 2
    dw $013E
    dw $00A6
    db $1B, $00, $02, $1A ; id 3
    dw $013F
    dw $00AC
    db $2B, $01, $02, $3C ; id 4
    dw $004F
    dw $0054
    db $2B, $02, $02, $3C ; id 5
    dw $0050
    dw $0084
    db $2B, $00, $03, $3C ; id 6
    dw $0051
    dw $011E
    db $2B, $00, $03, $3C ; id 7
    dw $0052
    dw $0122
    db $35, $00, $00, $16 ; id 8
    dw $0067
    dw $00D2
    db $35, $01, $00, $16 ; id 9
    dw $0068
    dw $00A8
    db $35, $03, $00, $16 ; id 10
    dw $0069
    dw $0086
    db $35, $03, $00, $16 ; id 11
    dw $006A
    dw $00D6
    db $35, $03, $00, $16 ; id 12
    dw $006B
    dw $0126
    db $35, $02, $03, $16 ; id 13
    dw $006C
    dw $0056
    db $42, $00, $00, $4C ; id 14
    dw $00EB
    dw $0030
    db $42, $00, $00, $4C ; id 15
    dw $00EC
    dw $0032
    db $42, $00, $00, $4C ; id 16
    dw $00ED
    dw $0034
    db $42, $01, $00, $4C ; id 17
    dw $00EE
    dw $00AA
    db $44, $00, $00, $4C ; id 18
    dw $0076
    dw $0034
    db $39, $03, $00, $06 ; id 19
    dw $00E0
    dw $00A4
    db $39, $03, $00, $06 ; id 20
    dw $00E1
    dw $00AE
    db $39, $03, $02, $06 ; id 21
    dw $00E2
    dw $00F6
    db $39, $03, $02, $06 ; id 22
    dw $00E3
    dw $00FA
    db $39, $03, $02, $06 ; id 23
    dw $00E4
    dw $00FE
    db $3A, $00, $00, $06 ; id 24
    dw $00E5
    dw $00D0
    db $3A, $00, $00, $06 ; id 25
    dw $00E6
    dw $00D2
    db $3E, $01, $01, $1C ; id 26
    dw $0079
    dw $0084
    db $55, $00, $00, $2C ; id 27
    dw $0084
    dw $00A6
    db $62, $01, $01, $2C ; id 28
    dw $01E0
    dw $005E
    db $73, $00, $01, $4C ; id 29
    dw $00A1
    dw $0060
    db $76, $00, $00, $4C ; id 30
    dw $00A2
    dw $00CE
    db $76, $00, $00, $4C ; id 31
    dw $00A3
    dw $0100
    db $7A, $00, $00, $2E ; id 32
    dw $00AA
    dw $0030
    db $82, $02, $02, $2C ; id 33
    dw $00AB
    dw $00AA
    db $84, $00, $00, $2C ; id 34
    dw $00AC
    dw $0034
    db $85, $01, $00, $3C ; id 35
    dw $00AF
    dw $005A
    db $91, $00, $00, $2C ; id 36
    dw $00B5
    dw $0058
    db $94, $02, $00, $3E ; id 37
    dw $00BC
    dw $00A8
    db $96, $00, $00, $3E ; id 38
    dw $00BD
    dw $00A8
    db $98, $00, $00, $3E ; id 39
    dw $00BE
    dw $00F2
    db $9A, $00, $00, $3E ; id 40
    dw $00BF
    dw $0128
    db $63, $01, $00, $2C ; id 41
    dw $01E9
    dw $011A
    db $63, $00, $01, $2C ; id 42
    dw $01EA
    dw $0038
    db $64, $00, $00, $2C ; id 43
    dw $01EB
    dw $00A2
    db $64, $00, $00, $2C ; id 44
    dw $01EC
    dw $00D0
    db $66, $00, $00, $2C ; id 45
    dw $01ED
    dw $00A2
    db $66, $00, $00, $2C ; id 46
    dw $01EE
    dw $00A6
    db $67, $00, $00, $2C ; id 47
    dw $01EF
    dw $011E
    db $67, $00, $00, $2C ; id 48
    dw $01F0
    dw $0124
    db $AD, $00, $00, $2E ; id 49
    dw $0156
    dw $00AC
    db $AE, $00, $02, $2E ; id 50
    dw $0157
    dw $00AC
    db $AE, $02, $03, $2E ; id 51
    dw $0158
    dw $0060
    db $BE, $00, $00, $2E ; id 52
    dw $01CB
    dw $0082
    db $C0, $00, $01, $2E ; id 53
    dw $01CC
    dw $011A
    db $C2, $01, $01, $2E ; id 54
    dw $01CD
    dw $0080
    db $C4, $00, $00, $2E ; id 55
    dw $01CE
    dw $00F6
    db $C4, $00, $00, $FF ; id 56
    dw $01CF
    dw $007C
    db $C4, $00, $00, $FF ; id 57
    dw $01D0
    dw $00A8
    db $C4, $00, $00, $FF ; id 58
    dw $01D1
    dw $005A
    db $C4, $00, $00, $FF ; id 59
    dw $01D2
    dw $00D8
    db $CA, $00, $00, $3E ; id 60
    dw $01D5
    dw $0052
    db $CA, $00, $00, $3E ; id 61
    dw $01D6
    dw $002E
    db $CA, $00, $00, $3E ; id 62
    dw $01D8
    dw $0060
    db $CB, $00, $00, $3E ; id 63
    dw $01DA
    dw $0052
    db $CB, $00, $00, $3E ; id 64
    dw $01DB
    dw $002E
    db $CB, $00, $00, $3E ; id 65
    dw $01DC
    dw $0034
    db $CC, $00, $00, $3E ; id 66
    dw $01DE
    dw $002E
    db $CC, $00, $00, $3E ; id 67
    dw $01DF
    dw $0034
    db $CC, $00, $00, $3E ; id 68
    dw $0169
    dw $0060
    db $CD, $00, $00, $3E ; id 69
    dw $016B
    dw $0052
    db $CD, $00, $00, $3E ; id 70
    dw $016C
    dw $002E
    db $CD, $00, $00, $3E ; id 71
    dw $016D
    dw $0034
    db $CE, $00, $00, $3E ; id 72
    dw $016F
    dw $00A4
    db $CE, $00, $00, $3E ; id 73
    dw $0170
    dw $007E
    db $CE, $00, $00, $3E ; id 74
    dw $0171
    dw $0084
    db $CE, $00, $00, $3E ; id 75
    dw $0172
    dw $00AE
    db $D3, $00, $00, $3E ; id 76
    dw $0175
    dw $0052
    db $D3, $00, $00, $3E ; id 77
    dw $0176
    dw $002E
    db $D3, $00, $00, $3E ; id 78
    dw $0177
    dw $0034
    db $D4, $00, $00, $3E ; id 79
    dw $0179
    dw $002E
    db $D4, $00, $00, $3E ; id 80
    dw $017A
    dw $0034
    db $D4, $00, $00, $3E ; id 81
    dw $017B
    dw $0060
    db $D5, $00, $00, $3E ; id 82
    dw $017D
    dw $002E
    db $D5, $00, $00, $3E ; id 83
    dw $017E
    dw $0034
    db $D5, $00, $00, $3E ; id 84
    dw $017F
    dw $0060
    db $D6, $00, $00, $3E ; id 85
    dw $00D6
    dw $002E
    db $D6, $00, $00, $3E ; id 86
    dw $00D7
    dw $0034
    db $D6, $00, $00, $3E ; id 87
    dw $00D8
    dw $0060
    db $D7, $00, $00, $3E ; id 88
    dw $00DA
    dw $00A4
    db $D7, $00, $00, $3E ; id 89
    dw $00DB
    dw $007E
    db $D7, $00, $00, $3E ; id 90
    dw $00DC
    dw $0084
    db $D7, $00, $00, $3E ; id 91
    dw $00DD
    dw $00AE
    db $DC, $00, $00, $3E ; id 92
    dw $00F5
    dw $002E
    db $DC, $00, $00, $3E ; id 93
    dw $00F6
    dw $0034
    db $DC, $00, $00, $3E ; id 94
    dw $00F7
    dw $0060
    db $DD, $00, $00, $3E ; id 95
    dw $00F9
    dw $0052
    db $DD, $00, $00, $3E ; id 96
    dw $00FA
    dw $002E
    db $DD, $00, $00, $3E ; id 97
    dw $00FB
    dw $0034
    db $DE, $00, $00, $3E ; id 98
    dw $00FD
    dw $002E
    db $DE, $00, $00, $3E ; id 99
    dw $00FE
    dw $0034
    db $DE, $00, $00, $3E ; id 100
    dw $00FF
    dw $0060
    db $DF, $00, $00, $3E ; id 101
    dw $01F3
    dw $002E
    db $DF, $00, $00, $3E ; id 102
    dw $01F4
    dw $0034
    db $DF, $00, $00, $3E ; id 103
    dw $01F5
    dw $0060
    db $E0, $00, $00, $3E ; id 104
    dw $01F7
    dw $00A4
    db $E0, $00, $00, $3E ; id 105
    dw $01F8
    dw $007E
    db $E0, $00, $00, $3E ; id 106
    dw $01F9
    dw $0084
    db $E0, $00, $00, $3E ; id 107
    dw $01FA
    dw $00AE
    db $FF ; end

; only called from ItemUsable_LogTwig (E-0047)
; 1 call site from 1 routine (e.g. ItemUsable_LogTwig)
; reads: hPlayerStateFlags, wMapType, hMapId, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY, wKeyWorldActive, ...
; writes: hTempA, wSpriteSnapshot, wSnapshotByte3C, wSnapshotByte3D, wSnapshotByte3E, wKeyWorldActive, wKeyWorldGoal, wKeyWorldGoalCell, ...
; points at: wKeyWorldObjects
ItemUsable_LogTwig_WriteTempAAndSpriteSnapshotEtc::
Func_084_47C2:: ; address name
    xor a, a
    ldh [hTempA], a
    ldh a, [hPlayerStateFlags]
    bit 3, a
    ret nz
    ld a, [wMapType]
    bit 7, a
    jp nz, ItemUsable_LogTwig_WriteTempAAndSpriteSnapshotEtc_Data_Cp80
    ldh a, [hMapId]
    cp a, $20
    ret c
    push af
    call ItemUsable_LogTwig_Sub01_ReadTriggerKindAndPlayerXEtc
    or a, a
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
    or a, c
    ld c, a
    ldh a, [hPlayerX]
    and a, $F0
    ld b, a
    ldh a, [hPlayerY]
    and a, $F0
    swap a
    or a, b
    ld b, a

.skip:
    push hl
    ld a, [hl+]
    cp a, $FF
    jr z, .read_map_id
    cp a, e
    jr nz, .restore2
    ld a, [hl+]
    cp a, c
    jr nz, .restore2
    ld a, [hl+]
    cp a, b
    jr z, .done
    ld a, [hl]
    cp a, $FF
    jr z, .restore2
    cp a, b
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
    cp a, $FF
    jr z, .set_key_world_active_to_01
    cp a, d
    jr z, .read_key_world_active
    inc e
    inc hl
    inc hl
    inc hl
    jr .skip2

.read_key_world_active:
    ld a, [wKeyWorldActive]
    ld [wSpriteSnapshot], a
    or a, a
    jr z, .next
    ld a, [wKeyWorldGoal]
    ld [wSnapshotByte3C], a
    ld a, [wKeyWorldGoalCell]
    ld [wSnapshotByte3D], a
    ld a, [wKeyWorldKey]
    ld [wSnapshotByte3E], a
    ld a, [wKeyWorldKey]
    bit 7, a
    jr nz, .next
    cp a, e
    jr nz, .next
    ld a, [wKeyWorldGoal]
    cp a, b
    jr nz, .set_key_world_active_to_01
    ld a, [wKeyWorldGoalCell]
    cp a, c
    jr nz, .set_key_world_active_to_01
    ret

.next:
    inc hl
    ld a, [hl]
    cp a, b
    jr nz, .set_key_world_active_to_01
    inc hl
    cp a, c
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

; address loaded by ItemUsable_LogTwig_WriteTempAAndSpriteSnapshotEtc
ItemUsable_LogTwig_WriteTempAAndSpriteSnapshotEtc_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_084_4887:: ; address name
    db $20, $44, $00, $30, $44, $76, $48, $44, $B4, $70, $44, $B4, $A0, $44, $10, $A8
    db $44, $00, $B0, $44, $01, $B8, $44, $44, $C8, $44, $01, $D1, $44, $00, $DA, $44
    db $00, $FF

ItemUsable_LogTwig_WriteTempAAndSpriteSnapshotEtc_Data_Cp80::
Jump_084_48A9:: ; address name
    cp a, $80
    ret nz
    call ItemUsable_LogTwig_Sub01_ReadTriggerKindAndPlayerXEtc
    or a, a
    ret nz
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or a, c
    ld c, a
    ldh a, [hPlayerX]
    cp a, $40
    jr nz, .check_player_y2
    ldh a, [hPlayerY]
    cp a, $40
    jr nz, .check_player_y2
    ld hl, wKeyWorldObjects

.skip:
    push hl
    ld a, [hl]
    cp a, $FF
    jr z, .check_player_y
    dec hl
    dec hl
    dec hl
    ld a, [hl+]
    cp a, c
    jp z, .done
    ld a, [hl]
    cp a, c
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
    cp a, $40
    jr nz, .read_key_world_active2
    ld hl, wKeyWorldFloorInfo + $3

.skip2:
    push hl
    ld a, [hl]
    cp a, $FF
    jr z, .read_key_world_active
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    cp a, c
    jr nz, .restore
    ldh a, [hPlayerX]
    cp a, $40
    jp z, .done
    inc hl
    ld a, [hl]
    cp a, $04
    jr z, .restore
    cp a, $05
    jr z, .restore
    ldh a, [hPlayerX]
    cp a, $50
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
    or a, a
    jr z, .check_key_world_goal_screen
    ld a, [wKeyWorldGoal]
    ld [wSnapshotByte3C], a
    ld a, [wKeyWorldGoalCell]
    ld [wSnapshotByte3D], a
    ld a, [wKeyWorldKey]
    ld [wSnapshotByte3E], a
    ld a, [wKeyWorldKey]
    bit 7, a
    jr z, .check_key_world_goal_screen
    and a, $7F
    ld b, a
    ld a, [wKeyWorldSlot]
    cp a, b
    jr nz, .check_key_world_goal_screen
    ldh a, [hPlayerX]
    and a, $F0
    ld b, a
    ldh a, [hPlayerY]
    and a, $F0
    swap a
    or a, b
    ld b, a
    ld a, [wKeyWorldGoal]
    cp a, b
    jr nz, .check_player_x
    ld a, [wKeyWorldGoalCell]
    cp a, c
    jr nz, .check_player_x
    ret

.check_key_world_goal_screen:
    ld a, [wKeyWorldGoalScreen]
    cp a, c
    jr nz, .check_player_x
    ld a, [wKeyWorldGoalPos]
    ld b, a
    ldh a, [hPlayerX]
    cp a, b
    jr nz, .check_player_x
    ld a, [wKeyWorldGoalPos2]
    ld b, a
    ldh a, [hPlayerY]
    cp a, b
    jr nz, .check_player_x
    ret

.check_player_x:
    ldh a, [hPlayerX]
    and a, $F0
    ld b, a
    ldh a, [hPlayerY]
    and a, $F0
    swap a
    or a, b
    ld b, a
    ld a, $01
    ld [wKeyWorldActive], a
    ld a, b
    ld [wKeyWorldGoal], a
    ld a, c
    ld [wKeyWorldGoalCell], a
    ld a, [wKeyWorldSlot]
    or a, $80
    ld [wKeyWorldKey], a
    ld a, $01
    ldh [hTempA], a
    ret

.done:
    pop hl
    ret

; E-0193 (C1: ItemUsable_LogTwig_Sub01, on maps from $20, walks 4-byte records from $49A1 until $FF and returns at the first whose map id equals hMapId, whose screen byte equals hMapScreenX/Y and whose third or fourth byte equals the player's tile position; on no match it goes on to Data_084_4887; 50 records then $FF).
; record: map id; screen XY; two tile positions ($FF = none)
LogTwigSpotList::
Data_084_49A1:: ; address name
    db $20, $21, $44, $54 ; id 0
    db $20, $25, $44, $54 ; id 1
    db $20, $55, $44, $54 ; id 2
    db $30, $56, $44, $54 ; id 3
    db $30, $42, $44, $54 ; id 4
    db $30, $24, $44, $54 ; id 5
    db $30, $03, $44, $FF ; id 6
    db $30, $62, $44, $FF ; id 7
    db $30, $53, $44, $FF ; id 8
    db $48, $82, $44, $54 ; id 9
    db $48, $73, $44, $FF ; id 10
    db $48, $74, $44, $FF ; id 11
    db $48, $75, $44, $54 ; id 12
    db $48, $46, $44, $64 ; id 13
    db $48, $48, $44, $54 ; id 14
    db $48, $29, $44, $54 ; id 15
    db $48, $5A, $43, $53 ; id 16
    db $48, $99, $44, $54 ; id 17
    db $48, $A5, $44, $FF ; id 18
    db $48, $87, $44, $FF ; id 19
    db $48, $50, $44, $54 ; id 20
    db $48, $4A, $51, $61 ; id 21
    db $48, $79, $55, $65 ; id 22
    db $70, $B1, $44, $FF ; id 23
    db $70, $A4, $44, $FF ; id 24
    db $70, $94, $44, $FF ; id 25
    db $70, $56, $44, $54 ; id 26
    db $70, $04, $44, $FF ; id 27
    db $70, $36, $44, $FF ; id 28
    db $70, $37, $44, $FF ; id 29
    db $70, $59, $44, $54 ; id 30
    db $70, $89, $44, $FF ; id 31
    db $70, $99, $44, $FF ; id 32
    db $70, $5B, $44, $FF ; id 33
    db $70, $1B, $44, $FF ; id 34
    db $70, $BA, $44, $54 ; id 35
    db $70, $52, $44, $FF ; id 36
    db $70, $41, $44, $54 ; id 37
    db $A0, $12, $44, $FF ; id 38
    db $A8, $11, $44, $FF ; id 39
    db $A8, $24, $44, $54 ; id 40
    db $A8, $43, $44, $FF ; id 41
    db $A8, $51, $44, $FF ; id 42
    db $B0, $10, $44, $FF ; id 43
    db $B8, $43, $44, $54 ; id 44
    db $B8, $11, $35, $FF ; id 45
    db $B8, $40, $44, $FF ; id 46
    db $C8, $00, $44, $FF ; id 47
    db $D1, $01, $44, $FF ; id 48
    db $DA, $10, $44, $FF ; id 49
    db $FF ; end

; only called from ItemUsable_LogTwig_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. ItemUsable_LogTwig_WriteTempAAndSpriteSnapshotEtc)
; reads: wTriggerKind, hPlayerX, hPlayerY, wTriggerCell
ItemUsable_LogTwig_Sub01_ReadTriggerKindAndPlayerXEtc::
Func_084_4A6A:: ; address name
    ld a, [wTriggerKind]
    cp a, $FF
    jr z, .return_0
    ldh a, [hPlayerX]
    and a, $F0
    ld c, a
    ldh a, [hPlayerY]
    swap a
    and a, $0F
    or a, c
    ld c, a
    ld a, [wTriggerCell]
    cp a, c
    jr nz, .return_0
    ld a, $01
    ret

.return_0:
    xor a, a
    ret

; only called from RunFieldReturnPhase_Case01 (E-0047)
; 1 call site from 1 routine (e.g. RunFieldReturnPhase_OpenFieldMenuOnA)
; reads: wMapType, hMapId, hMapScreenX, hMapScreenY, wSpriteSnapshot, wSnapshotByte3E, wSnapshotByte3D, wSnapshotByte3C, ...
; writes: hSpriteWindowClipMode, hTemp0, rSVBK
RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc::
Func_084_4A89:: ; address name
    xor a, a
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
    cp a, c
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
    or a, c
    ld c, a
    ld a, [wSpriteSnapshot]
    or a, a
    jr z, .next
    ld a, [wSnapshotByte3E]
    dec a
    cp a, b
    jr nz, .next
    ld a, [wSnapshotByte3D]
    cp a, c
    jp nz, RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc_Data_CheckKeyWorldGoal
    ld a, [wSnapshotByte3C]
    ld c, a
    call RunFieldReturnPhase_Case01_Sub02_WriteSVBK
    jr RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc_Data_CheckKeyWorldGoal

.next:
    inc hl
    inc hl
    ld a, [hl]
    cp a, c
    jr nz, RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc_Data_CheckKeyWorldGoal
    dec hl
    ld a, [hl]
    ld c, a
    call RunFieldReturnPhase_Case01_Sub02_WriteSVBK
    jr RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc_Data_CheckKeyWorldGoal

; address loaded by RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc
RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_084_4ADC:: ; address name
    db $20, $44, $00, $30, $44, $76, $48, $44, $B4, $70, $44, $B4, $A0, $44, $10, $A8
    db $44, $00, $B0, $44, $01, $B8, $44, $44, $C8, $44, $01, $D1, $44, $00, $DA, $44
    db $00, $FF

RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc_Data_ReadMapScreenX::
Jump_084_4AFE:: ; address name
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or a, c
    ld c, a
    ld a, [wSpriteSnapshot]
    or a, a
    jr z, .check_key_world_goal_screen
    ld a, [wSnapshotByte3E]
    bit 7, a
    jr z, .check_key_world_goal_screen
    and a, $7F
    ld b, a
    ld a, [wKeyWorldSlot]
    cp a, b
    jr nz, .check_key_world_goal_screen
    ld a, [wSnapshotByte3D]
    cp a, c
    jr nz, RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc_Data_CheckKeyWorldGoal
    ld a, [wSnapshotByte3C]
    ld c, a
    call RunFieldReturnPhase_Case01_Sub02_WriteSVBK
    jr RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc_Data_CheckKeyWorldGoal

.check_key_world_goal_screen:
    ld a, [wKeyWorldGoalScreen]
    cp a, c
    jr nz, RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc_Data_CheckKeyWorldGoal
    ld a, [wKeyWorldGoalPos]
    and a, $F0
    ld c, a
    ld a, [wKeyWorldGoalPos2]
    and a, $F0
    swap a
    or a, c
    ld c, a
    call RunFieldReturnPhase_Case01_Sub02_WriteSVBK
    jr RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc_Data_CheckKeyWorldGoal

RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc_Data_CheckKeyWorldGoal::
Jump_084_4B46:: ; address name
    ld a, [wKeyWorldGoal]
    and a, $0F
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
    and a, $F0
    swap a
    add a, a
    add_a_to_hl
    push hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
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
    or a, a
    jr z, .check_scroll_y
    ld c, $05
    ld a, [wMapType]
    bit 7, a
    jr nz, .skip
    ld c, $03
    ldh a, [hTemp0]
    cp a, $04
    jr z, .skip
    cp a, $0A
    jr z, .skip
    ld c, $05
    cp a, $05
    jr z, .skip
    cp a, $06
    jr z, .skip
    cp a, $07
    jr z, .skip
    ld c, $01

.skip:
    ld a, $02
    ldh [rSVBK], a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld a, c
    ld [hl+], a
    ld [hl], a
    ld a, $13
    add_a_to_hl
    ld a, c
    ld [hl+], a
    ld [hl], a
    ld a, $00
    ldh [rSVBK], a

.check_scroll_y:
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
    ld a, d
    and a, $9B
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add a, e
    ld e, a
    jr nc, .call_draw_full_screen_buffer_to_bg_map
    inc d

.call_draw_full_screen_buffer_to_bg_map:
    ld l, e
    ld h, d
    call DrawFullScreenBufferToBGMap
    ret

; only called from RunFieldReturnPhase_Case01_Sub02 (E-0047)
; 4 call sites from 1 routine (e.g. RunFieldReturnPhase_Case01_WriteSpriteWindowClipModeAndTemp0Etc)
; reads: wIsCGB, wMapType
; writes: rSVBK
RunFieldReturnPhase_Case01_Sub02_WriteSVBK::
Func_084_4C04:: ; address name
    ld a, c
    and a, $0F
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
    and a, $F0
    swap a
    add a, a
    add_a_to_hl
    push hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
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
    or a, a
    ret z
    ld c, $01
    ld a, [wMapType]
    bit 7, a
    jr nz, .skip2
    ld a, b
    ld de, RunFieldReturnPhase_Case01_Sub02_WriteSVBK_Data
    add a, e
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
    add a, $00
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    ld a, c
    ld [hl+], a
    ld [hl], a
    ld a, $13
    add_a_to_hl
    ld a, c
    ld [hl+], a
    ld [hl], a
    ld a, $00
    ldh [rSVBK], a
    ret

; address loaded by RunFieldReturnPhase_Case01_Sub02_WriteSVBK
RunFieldReturnPhase_Case01_Sub02_WriteSVBK_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_084_4C7F:: ; address name
    db $01, $01, $03, $02, $02

; when wKeyWorldActive is set and key entry hTemp0 matches wKeyWorldKey, clears wKeyWorldActive (E-0127)
; 1 call site from 1 routine (e.g. DeleteKeyEntryTemp0)
; reads: wKeyWorldActive, hTemp0, wKeyWorldKey
; writes: wKeyWorldActive
ClearKeyWorldActiveForMatchingKeyEntry::
Func_084_4C84:: ; address name
    ld a, [wKeyWorldActive]
    or a, a
    ret z
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $C7
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
    cp a, c
    ret nz
    ld a, $00
    ld [wKeyWorldActive], a
    ret

.skip:
    ld a, [hl]
    cp a, $FF
    ret z
    bit 7, a
    ret z
    and a, $3F
    ld c, a
    ld a, [wKeyWorldKey]
    bit 7, a
    ret z
    and a, $7F
    cp a, c
    ret nz
    ld a, $00
    ld [wKeyWorldActive], a
    ret

; E-0193 (C1: DebugAutomap_Update_Sub01_Sub01_Sub0C reads the word at $4CCB + 2 * wKeyWorldAreaCount, skips the layout's first byte, and passes one 16-byte block per wKeyWorldFloorInfo entry (until $FF) to RunDebugAutomapCaseTemp0 with DE stepping through wKeyWorldFloorState by 16).
; record: area layout
KeyWorldAreaLayoutTable::
Data_084_4CCB:: ; address name
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

; E-0193 (C1: entry 0 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 3, then 3 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout00::
Data_084_4D2B:: ; address name
    db $03 ; entry 0: block count
    db $03, $0A, $9E, $E0, $C2, $00, $00, $00, $00, $0A, $9E, $E0, $C2, $00, $00, $00 ; block 0
    db $05, $03, $03, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 1
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $FF ; end

; E-0193 (C1: entry 1 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 3, then 3 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout01::
Data_084_4D5D:: ; address name
    db $03 ; entry 0: block count
    db $03, $A6, $09, $6A, $C8, $00, $00, $00, $00, $A6, $09, $6A, $C8, $00, $00, $00 ; block 0
    db $04, $03, $03, $01, $2C, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 1
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $FF ; end

; E-0193 (C1: entry 2 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 3, then 3 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout02::
Data_084_4D8F:: ; address name
    db $03 ; entry 0: block count
    db $03, $B1, $8E, $08, $C6, $00, $00, $00, $00, $00, $8E, $08, $C6, $00, $00, $00 ; block 0
    db $04, $03, $03, $01, $2C, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 1
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $FF ; end

; E-0193 (C1: entry 3 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 3, then 3 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout03::
Data_084_4DC1:: ; address name
    db $03 ; entry 0: block count
    db $02, $69, $E5, $0A, $00, $BB, $92, $C9, $7B, $00, $00, $00, $00, $00, $00, $00 ; block 0
    db $05, $03, $03, $00, $2C, $00, $00, $01, $2A, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $FF ; end

; E-0193 (C1: entry 4 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 4, then 4 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout04::
Data_084_4DF3:: ; address name
    db $04 ; entry 0: block count
    db $03, $AF, $09, $72, $C0, $00, $00, $00, $00, $AF, $09, $72, $C0, $00, $00, $00 ; block 0
    db $05, $04, $03, $01, $03, $00, $00, $02, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $02, $6C, $E5, $B4, $DE, $BF, $97, $D4, $66, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $FF ; end

; E-0193 (C1: entry 5 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 4, then 4 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout05::
Data_084_4E35:: ; address name
    db $04 ; entry 0: block count
    db $03, $A2, $93, $08, $C3, $00, $00, $00, $00, $A2, $93, $08, $C3, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $2C, $00, $00, $02, $03, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $02, $73, $89, $B1, $D9, $BA, $84, $D5, $69, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $FF ; end

; E-0193 (C1: entry 6 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 4, then 4 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout06::
Data_084_4E77:: ; address name
    db $04 ; entry 0: block count
    db $03, $0A, $85, $6D, $CA, $00, $00, $00, $00, $0A, $85, $6D, $CA, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $03, $00, $00, $02, $12, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $02, $7C, $97, $A3, $C4, $B9, $9E, $DA, $77, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $FF ; end

; E-0193 (C1: entry 7 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 4, then 4 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout07::
Data_084_4EB9:: ; address name
    db $04 ; entry 0: block count
    db $03, $A1, $09, $66, $CB, $00, $00, $00, $00, $A1, $09, $66, $CB, $00, $00, $00 ; block 0
    db $05, $04, $03, $01, $0D, $00, $00, $02, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $02, $76, $94, $AD, $CF, $B6, $96, $D7, $68, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $FF ; end

; E-0193 (C1: entry 8 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 4, then 4 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout08::
Data_084_4EFB:: ; address name
    db $04 ; entry 0: block count
    db $03, $B7, $90, $08, $DB, $00, $00, $00, $00, $B7, $90, $08, $DB, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $03, $00, $00, $02, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $05, $04, $03, $01, $0C, $00, $00, $02, $11, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $FF ; end

; E-0193 (C1: entry 9 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 4, then 4 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout09::
Data_084_4F3D:: ; address name
    db $04 ; entry 0: block count
    db $03, $0A, $95, $6B, $CE, $00, $00, $00, $00, $0A, $95, $6B, $CE, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $2C, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 1
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $04, $04, $03, $01, $0C, $00, $00, $02, $12, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $FF ; end

; E-0193 (C1: entry 10 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 4, then 4 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout10::
Data_084_4F7F:: ; address name
    db $04 ; entry 0: block count
    db $01, $10, $31, $49, $08, $00, $00, $00, $00, $10, $31, $49, $08, $00, $00, $00 ; block 0
    db $04, $03, $03, $01, $0E, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 1
    db $05, $04, $03, $01, $0F, $00, $00, $02, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $FF ; end

; E-0193 (C1: entry 11 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 4, then 4 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout11::
Data_084_4FC1:: ; address name
    db $04 ; entry 0: block count
    db $01, $16, $37, $08, $E1, $00, $00, $00, $00, $16, $37, $08, $E1, $00, $00, $00 ; block 0
    db $05, $04, $03, $01, $03, $00, $00, $02, $10, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $04, $03, $03, $01, $11, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $FF ; end

; E-0193 (C1: entry 12 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 4, then 4 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout12::
Data_084_5003:: ; address name
    db $04 ; entry 0: block count
    db $02, $7D, $09, $A5, $D1, $B3, $99, $D8, $62, $00, $00, $00, $00, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $05, $00, $00, $02, $0C, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $03, $BC, $9D, $78, $C7, $00, $00, $00, $00, $BC, $9D, $78, $C7, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $FF ; end

; E-0193 (C1: entry 13 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 4, then 4 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout13::
Data_084_5045:: ; address name
    db $04 ; entry 0: block count
    db $01, $2C, $08, $34, $3C, $00, $00, $00, $00, $2C, $08, $34, $3C, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $2C, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 1
    db $03, $B0, $E6, $EA, $CC, $00, $00, $00, $00, $B0, $E6, $EA, $CC, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $FF ; end

; E-0193 (C1: entry 14 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 4, then 4 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout14::
Data_084_5087:: ; address name
    db $04 ; entry 0: block count
    db $01, $14, $42, $51, $08, $00, $00, $00, $00, $14, $42, $51, $08, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $2C, $00, $00, $02, $0C, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $03, $BD, $8D, $6E, $CD, $00, $00, $00, $00, $BD, $8D, $6E, $CD, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $FF ; end

; E-0193 (C1: entry 15 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 4, then 4 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout15::
Data_084_50C9:: ; address name
    db $04 ; entry 0: block count
    db $02, $08, $8A, $E4, $D2, $AC, $98, $D6, $65, $00, $00, $00, $00, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $0C, $00, $00, $02, $0D, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $01, $1C, $32, $3A, $3B, $00, $00, $00, $00, $1C, $32, $3A, $3B, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $FF ; end

; E-0193 (C1: entry 16 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 5, then 5 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout16::
Data_084_510B:: ; address name
    db $05 ; entry 0: block count
    db $02, $7E, $9B, $0A, $D0, $A9, $8F, $D3, $6F, $00, $00, $00, $00, $00, $00, $00 ; block 0
    db $04, $03, $03, $01, $05, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 1
    db $03, $B2, $88, $71, $DF, $00, $00, $00, $00, $B2, $88, $71, $DF, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $05, $03, $02, $2C, $00, $00, $03, $12, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $FF ; end

; E-0193 (C1: entry 17 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 5, then 5 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout17::
Data_084_515D:: ; address name
    db $05 ; entry 0: block count
    db $02, $71, $09, $AA, $D1, $AE, $91, $DC, $62, $00, $00, $00, $00, $00, $00, $00 ; block 0
    db $04, $05, $03, $01, $05, $00, $00, $03, $0C, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $03, $B5, $9C, $7A, $DD, $00, $00, $00, $00, $B5, $9C, $7A, $DD, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $05, $03, $02, $10, $00, $00, $03, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $FF ; end

; E-0193 (C1: entry 18 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 5, then 5 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout18::
Data_084_51AF:: ; address name
    db $05 ; entry 0: block count
    db $03, $BE, $9A, $08, $D9, $00, $00, $00, $00, $BE, $9A, $64, $D9, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $11, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 1
    db $02, $6A, $95, $B9, $D3, $B3, $85, $C8, $01, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $05, $03, $02, $05, $00, $00, $03, $0F, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $FF ; end

; E-0193 (C1: entry 19 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 5, then 5 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout19::
Data_084_5201:: ; address name
    db $05 ; entry 0: block count
    db $03, $0A, $E6, $EB, $CC, $00, $00, $00, $00, $0A, $E6, $EB, $CC, $00, $00, $00 ; block 0
    db $04, $05, $03, $01, $11, $00, $00, $03, $03, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $02, $69, $84, $AB, $D8, $A4, $8C, $DD, $6D, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $05, $03, $02, $2C, $00, $00, $03, $0C, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $FF ; end

; E-0193 (C1: entry 20 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 5, then 5 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout20::
Data_084_5253:: ; address name
    db $05 ; entry 0: block count
    db $03, $A1, $09, $67, $CB, $00, $00, $00, $00, $A1, $09, $67, $CB, $00, $00, $00 ; block 0
    db $04, $03, $03, $01, $03, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 1
    db $01, $13, $35, $E1, $47, $00, $00, $00, $00, $13, $35, $E1, $47, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $05, $03, $01, $2C, $00, $00, $03, $0E, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $FF ; end

; E-0193 (C1: entry 21 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 5, then 5 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout21::
Data_084_52A5:: ; address name
    db $05 ; entry 0: block count
    db $03, $A1, $89, $08, $CB, $00, $00, $00, $00, $A1, $89, $08, $CB, $00, $00, $00 ; block 0
    db $05, $05, $03, $01, $05, $00, $00, $03, $03, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $01, $28, $38, $56, $E3, $00, $00, $00, $00, $28, $38, $56, $E3, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $05, $03, $02, $2C, $00, $00, $03, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $FF ; end

; E-0193 (C1: entry 22 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 5, then 5 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout22::
Data_084_52F7:: ; address name
    db $05 ; entry 0: block count
    db $03, $0A, $8B, $EA, $CD, $00, $00, $00, $00, $0A, $8B, $EA, $CD, $00, $00, $00 ; block 0
    db $02, $75, $E5, $AD, $DB, $BA, $8C, $DE, $6C, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $04, $04, $03, $01, $0F, $00, $00, $02, $0D, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $05, $03, $02, $12, $00, $00, $03, $10, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $FF ; end

; E-0193 (C1: entry 23 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 5, then 5 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout23::
Data_084_5349:: ; address name
    db $05 ; entry 0: block count
    db $03, $A0, $09, $7E, $CA, $00, $00, $00, $00, $A0, $09, $7E, $CA, $00, $00, $00 ; block 0
    db $02, $63, $94, $BB, $DA, $B3, $9B, $DF, $72, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $05, $03, $03, $01, $0F, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $06, $03, $02, $2C, $00, $00, $04, $05, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $FF ; end

; E-0193 (C1: entry 24 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 5, then 5 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout24::
Data_084_539B:: ; address name
    db $05 ; entry 0: block count
    db $03, $A5, $83, $08, $D7, $00, $00, $00, $00, $A5, $83, $08, $D7, $00, $00, $00 ; block 0
    db $02, $EF, $93, $B4, $C3, $BE, $99, $DC, $74, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $01, $15, $5F, $50, $45, $00, $00, $00, $00, $15, $5F, $50, $45, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $07, $03, $02, $0C, $00, $00, $04, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $FF ; end

; E-0193 (C1: entry 25 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 5, then 5 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout25::
Data_084_53ED:: ; address name
    db $05 ; entry 0: block count
    db $03, $0A, $8A, $6B, $C2, $00, $00, $00, $00, $0A, $8A, $6B, $C2, $00, $00, $00 ; block 0
    db $02, $71, $91, $AC, $D2, $B2, $98, $D5, $79, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $01, $23, $30, $39, $4A, $00, $00, $00, $00, $23, $30, $39, $4A, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $06, $03, $02, $11, $00, $00, $04, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $FF ; end

; E-0193 (C1: entry 26 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 5, then 5 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout26::
Data_084_543F:: ; address name
    db $05 ; entry 0: block count
    db $01, $1D, $3F, $E2, $08, $00, $00, $00, $00, $1D, $3F, $E2, $08, $00, $00, $00 ; block 0
    db $04, $05, $03, $01, $0E, $00, $00, $03, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $05, $03, $03, $01, $0D, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $08, $03, $02, $2C, $00, $00, $05, $05, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $FF ; end

; E-0193 (C1: entry 27 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 5, then 5 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout27::
Data_084_5491:: ; address name
    db $05 ; entry 0: block count
    db $01, $19, $58, $08, $4B, $00, $00, $00, $00, $19, $58, $08, $4B, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $10, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 1
    db $04, $04, $03, $01, $0D, $00, $00, $02, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $08, $03, $02, $03, $00, $00, $05, $0F, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $FF ; end

; E-0193 (C1: entry 28 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 6, then 6 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout28::
Data_084_54E3:: ; address name
    db $06 ; entry 0: block count
    db $01, $2D, $08, $E3, $3E, $00, $00, $00, $00, $2D, $08, $E3, $3E, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $0E, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 1
    db $03, $B0, $96, $7B, $CF, $00, $00, $00, $00, $B0, $96, $7B, $CF, $00, $00, $00 ; block 2
    db $04, $04, $03, $01, $0D, $00, $00, $02, $0C, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $05, $08, $03, $02, $11, $00, $00, $05, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $FF ; end

; E-0193 (C1: entry 29 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 6, then 6 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout29::
Data_084_5545:: ; address name
    db $06 ; entry 0: block count
    db $01, $1B, $59, $4C, $08, $00, $00, $00, $00, $1B, $59, $4C, $08, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $0E, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 1
    db $03, $AF, $E7, $78, $CE, $00, $00, $00, $00, $AF, $E7, $78, $CE, $00, $00, $00 ; block 2
    db $04, $04, $03, $01, $0D, $00, $00, $02, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $04, $05, $03, $02, $2C, $00, $00, $03, $11, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $FF ; end

; E-0193 (C1: entry 30 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 6, then 6 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout30::
Data_084_55A7:: ; address name
    db $06 ; entry 0: block count
    db $01, $20, $5D, $08, $5A, $00, $00, $00, $00, $20, $5D, $08, $5A, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $12, $00, $00, $02, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $05, $03, $03, $01, $0C, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 2
    db $03, $B1, $9E, $73, $EE, $00, $00, $00, $00, $B1, $9E, $73, $EE, $00, $00, $00 ; block 3
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $04, $06, $03, $02, $05, $00, $00, $04, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $FF ; end

; E-0193 (C1: entry 31 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 6, then 6 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout31::
Data_084_5609:: ; address name
    db $06 ; entry 0: block count
    db $01, $22, $08, $53, $54, $00, $00, $00, $00, $22, $08, $53, $54, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $2C, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 1
    db $05, $03, $03, $01, $05, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 2
    db $03, $B8, $E7, $68, $D0, $00, $00, $00, $00, $B8, $E7, $68, $D0, $00, $00, $00 ; block 3
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $04, $09, $03, $02, $2C, $00, $00, $05, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $FF ; end

; E-0193 (C1: entry 32 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 7, then 7 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout32::
Data_084_566B:: ; address name
    db $07 ; entry 0: block count
    db $03, $0A, $9D, $7F, $CF, $00, $00, $00, $00, $0A, $9D, $7F, $CF, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $0C, $00, $00, $02, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $04, $03, $03, $01, $11, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 2
    db $02, $75, $82, $E4, $C1, $03, $88, $C4, $6E, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $04, $03, $01, $05, $00, $00, $02, $12, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $05, $07, $03, $01, $0F, $00, $00, $04, $10, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $FF ; end

; E-0193 (C1: entry 33 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 7, then 7 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout33::
Data_084_56DD:: ; address name
    db $07 ; entry 0: block count
    db $03, $BC, $09, $7D, $C9, $00, $00, $00, $00, $BC, $09, $7D, $C9, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $0C, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 1
    db $05, $03, $03, $01, $11, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 2
    db $02, $70, $E6, $A9, $C0, $B7, $8F, $C6, $77, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $03, $03, $01, $05, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 4
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $04, $06, $03, $02, $2C, $00, $00, $03, $0F, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $FF ; end

; E-0193 (C1: entry 34 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 7, then 7 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout34::
Data_084_574F:: ; address name
    db $07 ; entry 0: block count
    db $03, $B5, $95, $08, $C1, $00, $00, $00, $00, $B5, $95, $08, $C1, $00, $00, $00 ; block 0
    db $04, $03, $03, $01, $0D, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 1
    db $04, $04, $03, $01, $0E, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 2
    db $04, $05, $03, $01, $0F, $00, $00, $03, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $02, $76, $87, $A7, $C7, $AE, $8E, $D3, $7C, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $04, $04, $03, $01, $11, $00, $00, $02, $0C, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $FF ; end

; E-0193 (C1: entry 35 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 7, then 7 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout35::
Data_084_57C1:: ; address name
    db $07 ; entry 0: block count
    db $03, $0A, $E8, $7E, $F1, $00, $00, $00, $00, $0A, $E8, $7E, $F1, $00, $00, $00 ; block 0
    db $05, $04, $03, $01, $0D, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 1
    db $05, $03, $03, $01, $2C, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 2
    db $05, $04, $03, $01, $0F, $00, $00, $02, $12, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $02, $65, $8C, $A8, $C5, $B9, $92, $D2, $73, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $05, $07, $03, $02, $2C, $00, $00, $04, $0C, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $FF ; end

; E-0193 (C1: entry 36 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 7, then 7 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout36::
Data_084_5833:: ; address name
    db $07 ; entry 0: block count
    db $03, $B7, $09, $7B, $F0, $00, $00, $00, $00, $B7, $09, $7B, $F0, $00, $00, $00 ; block 0
    db $04, $05, $03, $01, $11, $00, $00, $03, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $02, $6E, $E8, $AA, $EE, $B3, $93, $DB, $79, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $04, $04, $03, $01, $12, $00, $00, $02, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $01, $2B, $4E, $55, $35, $00, $00, $00, $00, $2B, $4E, $55, $35, $00, $00, $00 ; block 4
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $05, $06, $03, $02, $2C, $00, $00, $04, $0D, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $FF ; end

; E-0193 (C1: entry 37 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 7, then 7 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout37::
Data_084_58A5:: ; address name
    db $07 ; entry 0: block count
    db $03, $B5, $99, $08, $DA, $00, $00, $00, $00, $B5, $99, $08, $DA, $00, $00, $00 ; block 0
    db $05, $03, $03, $01, $11, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 1
    db $02, $64, $82, $A4, $C3, $AB, $8A, $D0, $6C, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $05, $04, $03, $01, $12, $00, $00, $02, $0F, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $01, $2F, $33, $4A, $04, $00, $00, $00, $00, $2F, $33, $4A, $04, $00, $00, $00 ; block 4
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $04, $07, $03, $02, $2C, $00, $00, $05, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $FF ; end

; E-0193 (C1: entry 38 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 7, then 7 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout38::
Data_084_5917:: ; address name
    db $07 ; entry 0: block count
    db $03, $0A, $E7, $EC, $CF, $00, $00, $00, $00, $0A, $E7, $EC, $CF, $00, $00, $00 ; block 0
    db $04, $03, $03, $01, $2C, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 1
    db $04, $05, $03, $01, $0E, $00, $00, $03, $11, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $04, $06, $03, $01, $03, $00, $00, $03, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $07, $03, $01, $0C, $00, $00, $03, $05, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $05, $04, $03, $01, $12, $00, $00, $02, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $FF ; end

; E-0193 (C1: entry 39 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 7, then 7 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout39::
Data_084_5989:: ; address name
    db $07 ; entry 0: block count
    db $03, $AD, $09, $71, $F0, $00, $00, $00, $00, $AD, $09, $71, $F0, $00, $00, $00 ; block 0
    db $05, $04, $03, $01, $0D, $00, $00, $02, $03, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $05, $04, $03, $01, $0E, $00, $00, $02, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $05, $03, $03, $01, $2C, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 3
    db $05, $03, $03, $01, $0C, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 4
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $04, $07, $03, $02, $2C, $00, $00, $05, $11, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $FF ; end

; E-0193 (C1: entry 40 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 8, then 8 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout40::
Data_084_59FB:: ; address name
    db $08 ; entry 0: block count
    db $03, $B8, $91, $08, $F1, $00, $00, $00, $00, $B8, $91, $08, $F1, $00, $00, $00 ; block 0
    db $04, $06, $03, $01, $0D, $00, $00, $03, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $04, $05, $03, $01, $0E, $00, $00, $03, $03, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $02, $62, $E9, $A5, $C2, $B1, $8B, $D1, $6B, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $03, $03, $01, $12, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 4
    db $01, $2E, $3B, $44, $3D, $00, $00, $00, $00, $2E, $3B, $44, $3D, $00, $00, $00 ; block 5
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $04, $07, $03, $02, $05, $00, $00, $05, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 7
    db $FF ; end

; E-0193 (C1: entry 41 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 8, then 8 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout41::
Data_084_5A7D:: ; address name
    db $08 ; entry 0: block count
    db $03, $0A, $98, $74, $D8, $00, $00, $00, $00, $0A, $98, $74, $D8, $00, $00, $00 ; block 0
    db $05, $07, $03, $01, $0D, $00, $00, $03, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $05, $03, $03, $01, $0C, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 2
    db $02, $69, $96, $A2, $CA, $AC, $8F, $D4, $6D, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $03, $03, $01, $11, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 4
    db $01, $2A, $43, $49, $57, $00, $00, $00, $00, $2A, $43, $49, $57, $00, $00, $00 ; block 5
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $05, $06, $03, $02, $2C, $00, $00, $04, $05, $00, $00, $00, $00, $00, $00, $00 ; block 7
    db $FF ; end

; E-0193 (C1: entry 42 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 8, then 8 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout42::
Data_084_5AFF:: ; address name
    db $08 ; entry 0: block count
    db $01, $2D, $5A, $5E, $08, $00, $00, $00, $00, $2D, $5A, $5E, $08, $00, $00, $00 ; block 0
    db $04, $03, $03, $01, $11, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 1
    db $03, $A7, $E9, $ED, $C4, $00, $00, $00, $00, $A7, $E9, $ED, $C4, $00, $00, $00 ; block 2
    db $01, $24, $45, $47, $53, $00, $00, $00, $00, $24, $45, $47, $53, $00, $00, $00 ; block 3
    db $04, $04, $03, $01, $0D, $00, $00, $02, $10, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $05, $03, $03, $01, $03, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 5
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $04, $07, $03, $02, $2C, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 7
    db $FF ; end

; E-0193 (C1: entry 43 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 8, then 8 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout43::
Data_084_5B81:: ; address name
    db $08 ; entry 0: block count
    db $01, $29, $3A, $08, $42, $00, $00, $00, $00, $29, $3A, $08, $42, $00, $00, $00 ; block 0
    db $05, $06, $03, $01, $11, $00, $00, $03, $12, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $03, $B4, $8D, $75, $CD, $00, $00, $00, $00, $B4, $8D, $75, $CD, $00, $00, $00 ; block 2
    db $01, $26, $4C, $34, $58, $00, $00, $00, $00, $26, $4C, $34, $58, $00, $00, $00 ; block 3
    db $05, $06, $03, $01, $0E, $00, $00, $03, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $04, $03, $03, $01, $03, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 5
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $05, $07, $03, $04, $2C, $00, $00, $05, $0F, $00, $00, $00, $00, $00, $00, $00 ; block 7
    db $FF ; end

; E-0193 (C1: entry 44 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 8, then 8 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout44::
Data_084_5C03:: ; address name
    db $08 ; entry 0: block count
    db $01, $2C, $08, $52, $4D, $00, $00, $00, $00, $2C, $08, $52, $4D, $00, $00, $00 ; block 0
    db $04, $09, $03, $01, $2C, $00, $00, $03, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $03, $AF, $9D, $7A, $C7, $00, $00, $00, $00, $AF, $9D, $7A, $C7, $00, $00, $00 ; block 2
    db $04, $09, $03, $01, $2C, $00, $00, $03, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $01, $2B, $40, $3C, $54, $00, $00, $00, $00, $2B, $40, $3C, $54, $00, $00, $00 ; block 4
    db $04, $09, $03, $01, $2C, $00, $00, $03, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $04, $09, $03, $02, $2C, $00, $00, $05, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 7
    db $FF ; end

; E-0193 (C1: entry 45 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 8, then 8 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout45::
Data_084_5C85:: ; address name
    db $08 ; entry 0: block count
    db $01, $17, $39, $5F, $08, $00, $00, $00, $00, $17, $39, $5F, $08, $00, $00, $00 ; block 0
    db $05, $09, $03, $01, $0D, $00, $00, $03, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $02, $63, $88, $A3, $C8, $BA, $9F, $DC, $6F, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $05, $09, $03, $01, $2C, $00, $00, $03, $10, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $01, $18, $50, $3E, $5D, $00, $00, $00, $00, $18, $50, $3E, $5D, $00, $00, $00 ; block 4
    db $05, $09, $03, $01, $12, $00, $00, $03, $05, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $05, $09, $03, $02, $11, $00, $00, $05, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 7
    db $FF ; end

; E-0193 (C1: entry 46 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 8, then 8 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout46::
Data_084_5D07:: ; address name
    db $08 ; entry 0: block count
    db $01, $1F, $31, $08, $56, $00, $00, $00, $00, $1F, $31, $08, $56, $00, $00, $00 ; block 0
    db $04, $04, $03, $01, $2C, $00, $00, $02, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $04, $04, $03, $01, $0F, $00, $00, $02, $12, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $04, $04, $03, $01, $05, $00, $00, $02, $11, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $04, $04, $03, $01, $03, $00, $00, $02, $10, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $04, $03, $03, $01, $0C, $00, $00, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00 ; block 5
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $05, $09, $03, $03, $0E, $00, $00, $05, $0D, $00, $00, $00, $00, $00, $00, $00 ; block 7
    db $FF ; end

; E-0193 (C1: entry 47 of KeyWorldAreaLayoutTable; size 2 + 16 * count).
; record: block count 8, then 8 blocks of 16 bytes; $FF ends the layout
KeyWorldAreaLayout47::
Data_084_5D89:: ; address name
    db $08 ; entry 0: block count
    db $01, $1E, $08, $4E, $55, $00, $00, $00, $00, $1E, $08, $4E, $55, $00, $00, $00 ; block 0
    db $05, $04, $03, $01, $0E, $00, $00, $03, $03, $00, $00, $00, $00, $00, $00, $00 ; block 1
    db $05, $06, $03, $01, $2C, $00, $00, $03, $10, $00, $00, $00, $00, $00, $00, $00 ; block 2
    db $05, $04, $03, $01, $0D, $00, $00, $03, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 3
    db $05, $06, $03, $01, $11, $00, $00, $03, $12, $00, $00, $00, $00, $00, $00, $00 ; block 4
    db $05, $05, $03, $01, $0C, $00, $00, $03, $2C, $00, $00, $00, $00, $00, $00, $00 ; block 5
    db $06, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; block 6
    db $04, $09, $03, $02, $2C, $00, $00, $05, $11, $00, $00, $00, $00, $00, $00, $00 ; block 7
    db $FF ; end
    ds $21F5, $00
