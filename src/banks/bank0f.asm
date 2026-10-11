SECTION "Bank 0F", ROMX[$4000], BANK[$0F]
    db $0F

; implements script command type C7; reached through ScriptCommandC7 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandC7)
; reads: wScriptStep
ScriptCommandC7_Run::
Func_00F_4001:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommandC7_Run_Case00
    dw ScriptCommandC7_Run_Case01
    dw ScriptCommandC7_Run_Case02
    dw ScriptCommandC7_Run_Case03

; entry 3 of the `rst $00` table in ScriptCommandC7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wScriptParam0, hPlayerStateFlags
; writes: wScriptParam0, hPlayerStateFlags, wScriptStartRequest
ScriptCommandC7_Run_Case03::
Jump_00F_400D:: ; address name
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank0F
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank0F
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $1E
    ret nz
    ldh a, [hPlayerStateFlags]
    and a, $FD
    ldh [hPlayerStateFlags], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommandC7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: hPlayerY, wScriptParam0
; points at: wScriptStep
ScriptCommandC7_Run_Case02::
Jump_00F_402D:: ; address name
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank0F
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank0F
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp a, $80
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommandC7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived, hPlayerStateFlags
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, hPlayerStateFlags
; points at: wScriptStep
ScriptCommandC7_Run_Case01::
Jump_00F_404D:: ; address name
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $80
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ldh a, [hPlayerStateFlags]
    or a, $02
    ldh [hPlayerStateFlags], a
    ld a, $63
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommandC7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject1
; writes: wScriptParam0, wObject1
; points at: wScriptStep
ScriptCommandC7_Run_Case00::
Jump_00F_4077:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $01
    ret z
    ld a, [wObject1 + $C]
    dec a
    ld [wObject1 + $C], a
    cp a, $30
    ret nz
    ld hl, wObject1 + $D
    call SetBit2AtHL_B0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 62; reached through ScriptCommand62 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand62)
; reads: wScriptStep
ScriptCommand62_Run::
Func_00F_409A:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand62_Run_Case00
    dw ScriptCommand62_Run_Case01

; entry 0 of the `rst $00` table in ScriptCommand62_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, hTemp0
; writes: rRAMG
; points at: wPartyList, wScriptStep
ScriptCommand62_Run_Case00::
Jump_00F_40A2:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld hl, wPartyList
    ld a, [wScriptParam1]
    add_a_to_hl
    push hl
    ld a, [hl]
    ld c, $0D
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
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
    call StartMessageHL_B0F
    xor a, a
    ld [rRAMG], a
    ld hl, wScriptStep
    inc [hl]
    ret
    db $94, $AF, $CA, $AF, $94, $CA, $AF, $94, $CA, $CA, $E5

; implements script command type 5F; reached through ScriptCommand5F in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand5F)
; reads: wScriptStep
ScriptCommand5F_Run::
Func_00F_40E9:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand5F_Run_Case00
    dw ScriptCommand5F_Run_Case01
    dw ScriptCommand5F_Run_Case02
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand5F_Run_Case04
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand5F_Run_Case06
    dw ScriptCommand5F_Run_Case07
    dw ScriptCommand5F_Run_Case08
    dw ScriptCommand5F_Run_Case09
    dw ScriptCommand5F_Run_Case0A
    dw ScriptCommand5F_Run_Case0A
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand5F_Run_Case0D
    dw ScriptCommand5F_Run_Case0D
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand5F_Run_Case10
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand5F_Run_Case12
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand5F_Run_Case14
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand5F_Run_Case16
    dw ScriptCommand5F_Run_Case17
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand5F_Run_Case19
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand5F_Run_Case1B
    dw ScriptCommand5F_Run_Case1C
    dw ScriptCommand5F_Run_Case1D
    dw ScriptCommand5F_Run_Case1E
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand5F_Run_Case20
    dw ScriptCommand5F_Run_Case21
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand5F_Run_Case1C
    dw ScriptCommand5F_Run_Case1D
    dw ScriptCommand5F_Run_Case1C
    dw ScriptCommand5F_Run_Case26
    dw ScriptCommand5F_Run_Case27
    dw ScriptCommand5F_Run_Case28
    dw ScriptCommand5F_Run_Case29
    dw ScriptCommand5F_Run_Case2A
    dw ScriptCommand5F_Run_Case2B
    dw ScriptCommand5F_Run_Case2C

; entry 44 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
ScriptCommand5F_Run_Case2C::
Jump_00F_4147:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 43 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wGameMode, wModeState, wGameMode2State, wTemp0, wTemp1
; points at: wScriptStep
ScriptCommand5F_Run_Case2B::
Jump_00F_414D:: ; address name
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
    ld [wGameMode2State], a
    xor a, a
    ld [wTemp0], a
    xor a, a
    ld [wTemp1], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 42 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wScriptParam1
; writes: wScriptParam0, wScriptParam1
; points at: wScriptStep
ScriptCommand5F_Run_Case2A::
Jump_00F_4171:: ; address name
    ld a, [wScriptParam0]
    ld l, a
    ld a, [wScriptParam1]
    ld h, a
    dec hl
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ld a, l
    or a, h
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 41 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wSGBActive, wSGBPaletteSet
; writes: wSpriteSlotCount, wObject5, hPlayerX, wFollowerRecords, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, ...
; points at: wScreenTileBuffer, wScreenAttrBuffer, wScriptStep
ScriptCommand5F_Run_Case29::
Jump_00F_418E:: ; address name
    xor a, a
    ld [wSpriteSlotCount], a
    xor a, a
    ld [wObject5], a
    ld a, $E0
    ldh [hPlayerX], a
    ld [wFollowerRecords + $1], a
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0801
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a, a
    ld [wStringCategory], a
    ld a, $FB
    ld [wStringIndex], a
    farcall ShowString_Bank28
    ld hl, wScreenTileBuffer
    ld a, $C3
    ld bc, $0168
    call FillBytes
    ld hl, wScreenTileBuffer + $BA
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
    ld hl, wScreenAttrBuffer
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
    ld a, [wSGBPaletteSet]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    ld [wSGBPaletteNum0Lo], a
    ld a, h
    ld [wSGBPaletteNum0Hi], a
    inc hl
    ld a, l
    ld [wSGBPaletteNum1Lo], a
    ld a, h
    ld [wSGBPaletteNum1Hi], a
    inc hl
    ld a, l
    ld [wSGBPaletteNum2Lo], a
    ld a, h
    ld [wSGBPaletteNum2Hi], a
    inc hl
    ld a, l
    ld [wSGBPaletteNum3Lo], a
    ld a, h
    ld [wSGBPaletteNum3Hi], a
    call SpinDelay
    farcall LoadSGBObjectPalettesFromPointers
    ld hl, $425E
    ld de, wOBJPaletteBuffer + $20
    ld bc, $0008
    call CopyBytes

Jump_00F_423E::
    farcall DrawFullScreenBufferAtScroll
    ld a, $FE
    call StartPaletteFade
    ld hl, $0258
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ld a, $01
    ld [wArenaByte37], a
    ld hl, wScriptStep
    inc [hl]
    ret
    db $DE, $67, $1F, $33, $3C, $12, $00, $00

; entry 40 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; points at: wScriptStep
ScriptCommand5F_Run_Case28::
Jump_00F_4266:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 39 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand5F_Run_Case27::
Jump_00F_4270:: ; address name
    ld a, $3F
    call StartPaletteFade
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 38 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2
; writes: wObject2, wSpriteSlots, wScriptParam0
; points at: wScriptStep
ScriptCommand5F_Run_Case26::
Jump_00F_427A:: ; address name
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE
    ld hl, wObject2 + $D
    call SetBit1AtHL_Bank0F
    ld a, [wObject2 + $B]
    dec a
    dec a
    ld [wObject2 + $B], a
    cp a, $40
    ret nz
    ld a, $E0
    ld [wSpriteSlots + $B], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 33 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand5F_Run_Case21::
Jump_00F_429F:: ; address name
    ld de, wFollowerRecords + $2
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld a, $01
    add a, $B9
    ld l, a
    ld h, $0D
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 32 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerRecords
; writes: wFollowerRecords
; points at: wScriptStep
ScriptCommand5F_Run_Case20::
Jump_00F_42B5:: ; address name
    ld a, [wFollowerRecords + $1]
    dec a
    dec a
    ld [wFollowerRecords + $1], a
    cp a, $78
    ret nz
    ld a, $02
    ld [wFollowerRecords], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 30 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand5F_Run_Case1E::
Jump_00F_42CA:: ; address name
    ld hl, $0DB8
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 29 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject2, hPlayerX, wObject5
; writes: wObject2, hPlayerX, wObject5, wScriptParam0
; points at: wScriptStep
ScriptCommand5F_Run_Case1D::
Jump_00F_42D5:: ; address name
    ld a, [wScriptParam0]
    ld hl, $431F
    add_a_to_hl
    ld a, [hl]
    xor a, $FF
    inc a
    ld c, a
    jr Jump_00F_42F9

; entry 28 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject2, hPlayerX, wObject5
; writes: wObject2, hPlayerX, wObject5, wScriptParam0
; points at: wScriptStep
ScriptCommand5F_Run_Case1C::
Jump_00F_42E7:: ; address name
    ld a, $01
    ld [wObject2 + $7], a
    ld a, [wScriptParam0]
    ld hl, $431F
    add_a_to_hl
    ld a, [hl]
    ld c, a

Jump_00F_42F9::
    ld a, [wObject2 + $B]
    add a, c
    ld [wObject2 + $B], a
    ldh a, [hPlayerX]
    add a, c
    ldh [hPlayerX], a
    ld a, [wObject5 + $4]
    add a, c
    ld [wObject5 + $4], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $40
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret
    db $01, $00, $01, $00, $01, $01, $00, $FF, $01, $00, $00, $FF, $00, $FF, $FF, $00
    db $01, $00, $00, $00, $01, $01, $FF, $00, $00, $FF, $00, $00, $00, $FF, $01, $00
    db $01, $00, $01, $00, $00, $01, $01, $01, $00, $00, $FF, $00, $00, $00, $FF, $01
    db $FF, $00, $00, $01, $FF, $FF, $FF, $00, $00, $00, $FF, $00, $00, $FF, $FF, $00

; entry 27 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerY, hPlayerX
; writes: hPlayerFacing, hPlayerY, hPlayerX, wScriptParam0
; points at: wScriptParam0, wScriptStep
ScriptCommand5F_Run_Case1B::
Jump_00F_435F:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_4376
    ld a, $02
    ldh [hPlayerFacing], a
    ldh a, [hPlayerY]
    dec a
    ldh [hPlayerY], a
    cp a, $30
    ret nz
    ld hl, wScriptParam0
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
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 25 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand5F_Run_Case19::
Jump_00F_438B:: ; address name
    ld de, wObject2 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0DB7
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 23 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wObject1, wObject2, wScriptParam0
; points at: wScriptParam0, wScriptStep
ScriptCommand5F_Run_Case17::
Jump_00F_439D:: ; address name
    ld a, $01
    ld [wStepPtrHi], a
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_43C2
    ld a, $80
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_43C2::
    ld a, $83
    ld [wStepTarget], a
    ld a, $58
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $02
    ld [wObject1 + $7], a
    xor a, a
    ld [wObject2 + $7], a
    ld hl, $0DB6
    call StartMessageHL_B0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 22 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wObject1, wObject2, wStepPtrLo, wStepPtrHi
; points at: wScriptStep
ScriptCommand5F_Run_Case16::
Jump_00F_43EF:: ; address name
    ld a, $01
    ld [wObject1 + $7], a
    ld [wObject2 + $7], a
    ld de, wObject2 + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld de, wObject1 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld a, $03
    ld [wObject1 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 20 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrLo
; points at: wScriptStep
ScriptCommand5F_Run_Case14::
Jump_00F_4419:: ; address name
    ld hl, wObject1 + $D
    call ClearBit2AtHL_Bank0F
    ld hl, wObject2 + $D
    call ClearBit2AtHL_Bank0F
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $01
    add a, $B4
    ld l, a
    ld h, $0D
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 18 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand5F_Run_Case12::
Jump_00F_4444:: ; address name
    ld de, wObject2 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0DB3
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 16 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand5F_Run_Case10::
Jump_00F_4456:: ; address name
    ld de, wObject1 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0DB2
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand5F_Run_Case0D::
Jump_00F_4468:: ; address name
    ld de, wObject2 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0DB1
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand5F_Run_Case0A::
Jump_00F_447A:: ; address name
    ld de, wObject1 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0DB0
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand5F_Run_Case09::
Jump_00F_448C:: ; address name
    farcall ScriptStepSetObjectBit2AndWait
    ret

; entry 8 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wObject5
; points at: wScriptStep
ScriptCommand5F_Run_Case08::
Jump_00F_4493:: ; address name
    ld a, $01
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $68
    ld [wObject5 + $4], a
    ld a, $30
    ld [wObject5 + $5], a
    ld a, $80
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wGameMode, wModeState
; points at: wModeChangeRequest, wScriptStep
ScriptCommand5F_Run_Case07::
Jump_00F_44B1:: ; address name
    ld a, $10
    call StartPaletteFade
    ld a, $00
    ld [wGameMode], a
    ld a, $08
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hPlayerFacing
; points at: wScriptStep
ScriptCommand5F_Run_Case06::
Jump_00F_44C9:: ; address name
    ld a, $01
    ldh [hPlayerFacing], a
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
; points at: wScriptStep
ScriptCommand5F_Run_Case04::
Jump_00F_44D8:: ; address name
    ld a, $80
    ld [wObject5], a
    ld hl, wObject5 + $5
    dec [hl]
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $0549
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: hPlayerFacing, wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: hPlayerY, wScriptStep
ScriptCommand5F_Run_Case02::
Jump_00F_44F3:: ; address name
    ld a, $03
    ldh [hPlayerFacing], a
    ld de, hPlayerY
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld de, wObject2 + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    ld hl, $0548
    call StartMessageHL_B0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wScriptParam1, wObject3
; writes: wScriptParam0, wScriptParam1, wObject3
; points at: wScriptStep
ScriptCommand5F_Run_Case01::
Jump_00F_4532:: ; address name
    ld de, $0018
    ld a, [wScriptParam0]
    ld l, a
    ld a, [wScriptParam1]
    ld h, a
    add hl, de
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ld c, h
    ld a, [wObject3 + $C]
    add a, c
    ld [wObject3 + $C], a
    ld a, [wObject3 + $B]
    inc a
    inc a
    ld [wObject3 + $B], a
    cp a, $40
    ret nz
    ld a, $40
    ld [wObject3 + $C], a
    xor a, a
    ld [wScriptParam0], a
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wObject5, wScriptParam0, wScriptParam1, hFieldDrawFlags
; points at: wScriptStep
ScriptCommand5F_Run_Case00::
Jump_00F_456A:: ; address name
    ld a, $13
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + $4], a
    ld [wObject5 + $5], a
    ld hl, $FE80
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ld a, $65
    call QueueSoundEffect
    ld a, $0E
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 5E; reached through ScriptCommand5E in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand5E)
; reads: wScriptStep
ScriptCommand5E_Run::
Func_00F_4595:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand5E_Run_Case00
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case02
    dw ScriptCommand5E_Run_Case03
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case06
    dw ScriptCommand5E_Run_Case07
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand5E_Run_Case09
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand5E_Run_Case0B
    dw ScriptCommand5E_Run_Case0C
    dw ScriptCommand5E_Run_Case0D
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case0F
    dw ScriptCommand5E_Run_Case10
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case13
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case16
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand5E_Run_Case18
    dw ScriptCommand5E_Run_Case19
    dw ScriptCommand5E_Run_Case1A
    dw ScriptCommand5E_Run_Case1B
    dw ScriptCommand5E_Run_Case1A
    dw ScriptCommand5E_Run_Case1B
    dw ScriptCommand5E_Run_Case1A
    dw ScriptCommand5E_Run_Case1B
    dw ScriptCommand5E_Run_Case1A
    dw ScriptCommand5E_Run_Case21
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand5E_Run_Case23
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case25
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case28
    dw ScriptCommand5E_Run_Case29
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand5E_Run_Case28
    dw ScriptCommand5E_Run_Case2C
    dw ScriptCommand5E_Run_Case2D
    dw ScriptCommand5E_Run_Case2E
    dw ScriptCommand5E_Run_Case2F
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case31
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case34
    dw ScriptCommand5E_Run_Case35
    dw ScriptCommand5E_Run_Case36
    dw ScriptCommand5E_Run_Case37
    dw ScriptCommand5E_Run_Case38
    dw ScriptCommand5E_Run_Case39
    dw ScriptCommand5E_Run_Case3A
    dw ScriptCommand5E_Run_Case3B
    dw ScriptCommand5E_Run_Case3C
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case31
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case41
    dw ScriptCommand5E_Run_Case42
    dw ScriptCommand5E_Run_Case43
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case45
    dw ScriptCommand5E_Run_Case45
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case48
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case4A
    dw ScriptCommand5E_Run_Case4B
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case31
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case50
    dw ScriptCommand5E_Run_Case51
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case53
    dw ScriptCommand5E_Run_Case54
    dw ScriptCommand5E_Run_Case55
    dw ScriptCommand5E_Run_Case56
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case31
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case5B
    dw ScriptCommand5E_Run_Case5C
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case5F
    dw ScriptCommand5E_Run_Case60
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case62
    dw ScriptCommand5E_Run_Case63
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case65
    dw ScriptCommand5E_Run_Case66
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case68
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case31
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case6D
    dw ScriptCommand5E_Run_Case6E
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case70
    dw ScriptCommand5E_Run_Case71
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case73
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case75
    dw ScriptCommand5E_Run_Case76
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case78
    dw ScriptCommand5E_Run_Case79
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case31
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case7E
    dw ScriptCommand5E_Run_Case7F
    dw ScriptCommand5E_Run_Case01
    dw ScriptStepMoveObjects2And3To0340
    dw ScriptStepFlickerObjectCB9B
    dw ScriptStepDeltaWCBABThenCopy
    dw ScriptStepMoveObjects2And3To81B0
    dw ScriptCommand5E_Run_Case31
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case88
    dw ScriptCommand5E_Run_Case89
    dw ScriptCommand5E_Run_Case8A
    dw ScriptCommand5E_Run_Case8A
    dw ScriptCommand5E_Run_Case8C
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case01
    dw ScriptCommand5E_Run_Case8F
    dw ScriptCommand5E_Run_Case90
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand5E_Run_Case92
    dw ScriptCommand5E_Run_Case93
    dw ScriptCommand62_Run_Case01

; entry 147 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
; points at: wScriptStep
ScriptCommand5E_Run_Case93::
Jump_00F_46C3:: ; address name
    ld hl, $053C
    call StartMessageHL_B0F
    ld a, $06
    ldh [hTemp0], a
    farcall MarkKeyEntryKindTemp0Bit6
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 146 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0
; points at: wScriptStep
ScriptCommand5E_Run_Case92::
Jump_00F_46D8:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_46E8
    inc a
    ld [wScriptParam0], a
    ld a, $6D
    call QueueSoundEffect
    ret

Jump_00F_46E8::
    inc a
    ld [wScriptParam0], a
    cp a, $78
    ret nz
    farcall RestartMapMusic
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 144 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand5E_Run_Case90::
Jump_00F_46FE:: ; address name
    ld hl, $053B
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 143 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags
; writes: wFieldEventArg, wStoryFlags, hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
ScriptCommand5E_Run_Case8F::
Jump_00F_4709:: ; address name
    xor a, a
    ld [wFieldEventArg], a
    ld a, [wStoryFlags + $60]
    set 5, a
    ld [wStoryFlags + $60], a
    ld a, $19
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $3F
    call StartPaletteFade
    ret

; entry 140 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
; points at: wScriptStep
ScriptCommand5E_Run_Case8C::
Jump_00F_4737:: ; address name
    xor a, a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 137 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wObject5
; points at: wScriptStep
ScriptCommand5E_Run_Case89::
Jump_00F_4740:: ; address name
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $20
    ld [wObject5 + $4], a
    ld a, $50
    ld [wObject5 + $5], a
    xor a, a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 136 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wObject5
ScriptCommand5E_Run_Case88::
Jump_00F_475D:: ; address name
    ld a, $03
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wObject5 + $4], a
    ld a, $30
    ld [wObject5 + $5], a
    call ScriptCommand5E_Run_Shared01
    ret

; steps objects 2 and 3 toward ($81, $B0) and ($81, $C0) (StepObjectTowardCoord); advances wScriptStep once they arrive (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget
; points at: wScriptStep
ScriptStepMoveObjects2And3To81B0::
Jump_00F_4774:: ; address name
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $B0
    ld [wStepPtrLo], a
    ld a, $81
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, $03
    ld [wStepPtrHi], a
    ld a, $C0
    ld [wStepPtrLo], a
    ld a, $81
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; ScriptApplyStepDeltaAtDE on wCBAB, copies wCBAB to wCBBB, and when the move finishes (carry) wScriptStep += 1 (E-0119)
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2
; writes: wObject3
; points at: wScriptStep
ScriptStepDeltaWCBABThenCopy::
Jump_00F_47A8:: ; address name
    ld de, wObject2 + $C
    call ScriptApplyStepDeltaAtDE
    push af
    ld a, [wObject2 + $C]
    ld [wObject3 + $C], a
    pop af
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; alternates wCB9B between $E0 and $40 at a rate that slows with wScriptParam0; after $78 frames sets $40 and advances wScriptStep (E-0125)
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wObject1
; points at: wScriptStep
ScriptStepFlickerObjectCB9B::
Jump_00F_47BC:: ; address name
    ld a, [wScriptParam0]
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
    ld [wObject1 + $C], a
    jr Jump_00F_47E5

Jump_00F_47E0::
    ld a, $40
    ld [wObject1 + $C], a

Jump_00F_47E5::
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $40
    ld [wObject1 + $C], a
    ld hl, wScriptStep
    inc [hl]
    ret

; steps objects 2 and 3 toward ($03, $40) and ($03, $50); advances wScriptStep once they arrive (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget
; points at: wScriptStep
ScriptStepMoveObjects2And3To0340::
Jump_00F_47F5:: ; address name
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $40
    ld [wStepPtrLo], a
    ld a, $03
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, $03
    ld [wStepPtrHi], a
    ld a, $50
    ld [wStepPtrLo], a
    ld a, $03
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 127 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wObject5
; points at: wScriptStep
ScriptCommand5E_Run_Case7F::
Jump_00F_4829:: ; address name
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $20
    ld [wObject5 + $4], a
    ld a, $40
    ld [wObject5 + $5], a
    xor a, a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 126 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wObject5
ScriptCommand5E_Run_Case7E::
Jump_00F_4846:: ; address name
    ld a, $71
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wObject5 + $4], a
    ld a, $30
    ld [wObject5 + $5], a
    call ScriptCommand5E_Run_Shared01
    ret

; entry 121 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget
; points at: wScriptStep
ScriptCommand5E_Run_Case79::
Jump_00F_485D:: ; address name
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $60
    ld [wStepPtrLo], a
    ld a, $00
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 120 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget, wObject1, wObject2
; points at: wScriptStep
ScriptCommand5E_Run_Case78::
Jump_00F_487C:: ; address name
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $30
    ld [wStepPtrLo], a
    ld a, $03
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $60
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wObject1 + $7], a
    ld [wObject2 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 118 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget, wObject1, wObject2
; points at: wScriptStep
ScriptCommand5E_Run_Case76::
Jump_00F_48B7:: ; address name
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $50
    ld [wStepPtrLo], a
    ld a, $00
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $02
    ld [wObject1 + $7], a
    ld [wObject2 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 117 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrLo, wStepTarget, wStepPtrHi, wObject4
; points at: wScriptStep
ScriptCommand5E_Run_Case75::
Jump_00F_48DE:: ; address name
    ld a, $40
    ld [wStepPtrLo], a
    ld a, $03
    ld [wStepTarget], a
    jr Jump_00F_48F4

; entry 115 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrLo, wStepTarget, wStepPtrHi, wObject4
; points at: wScriptStep
ScriptCommand5E_Run_Case73::
Jump_00F_48EA:: ; address name
    ld a, $50
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepTarget], a

Jump_00F_48F4::
    ld a, $04
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $02
    ld [wObject4 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 113 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget, wObject1, wObject2
; points at: wScriptStep
ScriptCommand5E_Run_Case71::
Jump_00F_490E:: ; address name
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $40
    ld [wStepPtrLo], a
    ld a, $81
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $50
    ld [wStepPtrLo], a
    ld a, $83
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wObject1 + $7], a
    ld [wObject2 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 112 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget
; points at: wScriptStep
ScriptCommand5E_Run_Case70::
Jump_00F_4949:: ; address name
    ld a, $04
    ld [wStepPtrHi], a
    ld a, $70
    ld [wStepPtrLo], a
    ld a, $02
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 110 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wObject5
; points at: wScriptStep
ScriptCommand5E_Run_Case6E::
Jump_00F_4968:: ; address name
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + $4], a
    ld a, $60
    ld [wObject5 + $5], a
    xor a, a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 109 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wObject5
ScriptCommand5E_Run_Case6D::
Jump_00F_4985:: ; address name
    ld a, $60
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wObject5 + $4], a
    ld a, $30
    ld [wObject5 + $5], a
    call ScriptCommand5E_Run_Shared01
    ret

; entry 104 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wSpriteSlots
; points at: wScriptStep
ScriptCommand5E_Run_Case68::
Jump_00F_499C:: ; address name
    ld a, [wScriptParam0]
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
    ld [wSpriteSlots + $C], a
    jr Jump_00F_49C5

Jump_00F_49C0::
    ld a, $30
    ld [wSpriteSlots + $C], a

Jump_00F_49C5::
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $30
    ld [wSpriteSlots + $C], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 102 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget
; points at: wScriptStep
ScriptCommand5E_Run_Case66::
Jump_00F_49D5:: ; address name
    ld a, $03
    ld [wStepPtrHi], a
    ld a, $B0
    ld [wStepPtrLo], a
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, $04
    ld [wStepPtrHi], a
    ld a, $B0
    ld [wStepPtrLo], a
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 101 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject2, wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget, wObject1, wObject3, wObject4, wScriptParam0
; points at: wScriptParam0, wScriptStep
ScriptCommand5E_Run_Case65::
Jump_00F_4A09:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_4A42
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $40
    ld [wStepPtrLo], a
    ld a, $83
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wObject2 + $B]
    ld [wObject1 + $B], a
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wObject1 + $7], a
    ld a, $01
    ld [wObject3 + $7], a
    ld a, $03
    ld [wObject4 + $7], a
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_4A42::
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $C0
    ld [wStepPtrLo], a
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wObject2 + $C]
    sub a, $08
    ld [wObject1 + $C], a
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wObject3 + $7], a
    ld [wObject4 + $7], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 99 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0, wObject1
; points at: wScriptStep
ScriptCommand5E_Run_Case63::
Jump_00F_4A74:: ; address name
    ld a, [wScriptParam0]
    and a, $03
    jr nz, Jump_00F_4A7F
    ld hl, wObject1 + $C
    dec [hl]

Jump_00F_4A7F::
    ld a, [wScriptParam0]
    and a, $01
    jr nz, Jump_00F_4A8A
    ld hl, wObject1 + $B
    inc [hl]

Jump_00F_4A8A::
    ld de, wObject1 + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    ld a, $03
    ld [wObject1 + $7], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 98 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget, wObject1
; points at: wScriptStep
ScriptCommand5E_Run_Case62::
Jump_00F_4AB3:: ; address name
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $70
    ld [wStepPtrLo], a
    ld a, $00
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $01
    ld [wObject1 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 96 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand5E_Run_Case60::
Jump_00F_4AD7:: ; address name
    ld de, wObject1 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 95 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget, wObject1
; points at: wScriptStep
ScriptCommand5E_Run_Case5F::
Jump_00F_4AE3:: ; address name
    ld a, $03
    ld [wStepPtrHi], a
    ld a, $80
    ld [wStepPtrLo], a
    ld a, $02
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, $04
    ld [wStepPtrHi], a
    ld a, $80
    ld [wStepPtrLo], a
    ld a, $02
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wObject1 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 92 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wObject5
; points at: wScriptStep
ScriptCommand5E_Run_Case5C::
Jump_00F_4B1B:: ; address name
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + $4], a
    ld a, $30
    ld [wObject5 + $5], a
    xor a, a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 91 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY
ScriptCommand5E_Run_Case5B::
Jump_00F_4B38:: ; address name
    ld a, $49
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    call ScriptCommand5E_Run_Shared01
    ret

; entry 86 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wSpriteSlots, wObject1
; writes: wSpriteSlots, wObject1, wObject2, wObject3
; points at: wScriptStep
ScriptCommand5E_Run_Case56::
Jump_00F_4B45:: ; address name
    ld a, [wScriptParam0]
    and a, $03
    jr nz, Jump_00F_4B64
    ld a, [wSpriteSlots + $7]
    inc a
    and a, $03
    ld [wSpriteSlots + $7], a
    ld a, [wObject1 + $7]
    inc a
    and a, $03
    ld [wObject1 + $7], a
    ld [wObject2 + $7], a
    ld [wObject3 + $7], a

Jump_00F_4B64::
    ld de, wObject1 + $C
    call ScriptApplyStepDeltaAtDE
    push af
    ld a, [wObject1 + $C]
    ld [wObject2 + $C], a
    ld [wObject3 + $C], a
    sub a, $30
    ld [wSpriteSlots + $C], a
    pop af
    ret nc
    ld a, $02
    ld [wObject1 + $7], a
    ld [wObject2 + $7], a
    ld [wObject3 + $7], a
    xor a, a
    ld [wSpriteSlots + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 85 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject1
; writes: wScriptParam0, wObject1, wObject2, wObject3
; points at: wScriptStep
ScriptCommand5E_Run_Case55::
Jump_00F_4B8F:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    ret nz
    ld a, [wObject1 + $B]
    inc a
    ld [wObject1 + $B], a
    add a, $10
    ld [wObject2 + $B], a
    add a, $10
    ld [wObject3 + $B], a
    cp a, $60
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 84 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject1
; writes: wObject1, wObject2, wObject3
; points at: wScriptStep
ScriptCommand5E_Run_Case54::
Jump_00F_4BB6:: ; address name
    ld a, [wScriptParam0]
    and a, $03
    jr nz, Jump_00F_4BCC
    ld a, [wObject1 + $7]
    inc a
    and a, $03
    ld [wObject1 + $7], a
    ld [wObject2 + $7], a
    ld [wObject3 + $7], a

Jump_00F_4BCC::
    ld de, wObject1 + $C
    call ScriptApplyStepDeltaAtDE
    push af
    ld a, [wObject1 + $C]
    ld [wObject2 + $C], a
    ld [wObject3 + $C], a
    pop af
    ret nc
    ld a, $01
    ld [wObject1 + $7], a
    ld [wObject2 + $7], a
    ld [wObject3 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 83 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject1
; writes: wObject1, wObject2, wObject3, wScriptParam0
; points at: wScriptStep
ScriptCommand5E_Run_Case53::
Jump_00F_4BEE:: ; address name
    ld a, $03
    ld [wObject1 + $7], a
    ld [wObject2 + $7], a
    ld [wObject3 + $7], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    ret nz
    ld a, [wObject1 + $B]
    dec a
    ld [wObject1 + $B], a
    add a, $10
    ld [wObject2 + $B], a
    add a, $10
    ld [wObject3 + $B], a
    cp a, $50
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 81 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wObject5
; points at: wScriptStep
ScriptCommand5E_Run_Case51::
Jump_00F_4C20:: ; address name
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + $4], a
    ld a, $20
    ld [wObject5 + $5], a
    xor a, a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 80 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY
ScriptCommand5E_Run_Case50::
Jump_00F_4C3D:: ; address name
    ld a, $41
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    call ScriptCommand5E_Run_Shared01
    ret

; entry 75 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand5E_Run_Case4B::
Jump_00F_4C4A:: ; address name
    ld de, wObject3 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 74 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wStepArrived, wObject2
; writes: wStepPtrLo, wStepPtrHi, wStepTarget, wObject3, wObject2, wScriptParam0
; points at: wScriptParam0, wScriptStep
ScriptCommand5E_Run_Case4A::
Jump_00F_4C56:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_4C90
    ld a, $60
    ld [wStepPtrLo], a
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, $60
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_4C90::
    dec a
    jr nz, Jump_00F_4CDA
    ld a, [wObject2 + $C]
    cp a, $60
    jr z, Jump_00F_4CA6
    ld a, $60
    ld [wStepPtrLo], a
    ld a, $02
    ld [wStepTarget], a
    jr Jump_00F_4CB0

Jump_00F_4CA6::
    ld a, $20
    ld [wStepPtrLo], a
    ld a, $03
    ld [wStepTarget], a

Jump_00F_4CB0::
    ld a, $02
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, $20
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_4CDA::
    ld a, $20
    ld [wStepPtrLo], a
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, $50
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wObject3 + $7], a
    ld a, $02
    ld [wObject2 + $7], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 72 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget, wScriptParam0
; points at: wScriptParam0, wScriptStep
ScriptCommand5E_Run_Case48::
Jump_00F_4D1B:: ; address name
    ld a, $01
    ld [wStepPtrHi], a
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_4D40
    ld a, $60
    ld [wStepPtrLo], a
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_4D40::
    dec a
    jr nz, Jump_00F_4D5D
    ld a, $40
    ld [wStepPtrLo], a
    ld a, $81
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_4D5D::
    ld a, $B0
    ld [wStepPtrLo], a
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 69 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand5E_Run_Case45::
Jump_00F_4D7B:: ; address name
    ld de, wObject1 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 67 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget, wScriptParam0
; points at: wScriptParam0, wScriptStep
ScriptCommand5E_Run_Case43::
Jump_00F_4D87:: ; address name
    ld a, $01
    ld [wStepPtrHi], a
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_4DAC
    ld a, $60
    ld [wStepPtrLo], a
    ld a, $02
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_4DAC::
    dec a
    jr nz, Jump_00F_4DC9
    ld a, $20
    ld [wStepPtrLo], a
    ld a, $03
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_4DC9::
    ld a, $50
    ld [wStepPtrLo], a
    ld a, $02
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 66 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wObject5, wScriptParam0
; points at: wScriptStep
ScriptCommand5E_Run_Case42::
Jump_00F_4DE7:: ; address name
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $20
    ld [wObject5 + $4], a
    ld a, $40
    ld [wObject5 + $5], a
    xor a, a
    ld [wObject5], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 65 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY
ScriptCommand5E_Run_Case41::
Jump_00F_4E08:: ; address name
    ld a, $33
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    call ScriptCommand5E_Run_Shared01
    ret

; entry 60 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2
; writes: wObject2
; points at: wScriptStep
ScriptCommand5E_Run_Case3C::
Jump_00F_4E15:: ; address name
    ld a, $03
    ld [wObject2 + $7], a
    ld a, [wObject2 + $B]
    dec a
    ld [wObject2 + $B], a
    ld de, wObject2 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    xor a, a
    ld [wObject2 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 59 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget, wSpriteSlots
; points at: wScriptStep
ScriptCommand5E_Run_Case3B::
Jump_00F_4E31:: ; address name
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $60
    ld [wStepPtrLo], a
    jr Jump_00F_4EB0

; entry 58 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wStepPtrHi, wStepPtrLo, wStepTarget, wObject1, wObject2
; points at: wScriptStep
ScriptCommand5E_Run_Case3A::
Jump_00F_4E3D:: ; address name
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $E0
    ld [wStepPtrLo], a
    ld a, $83
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wObject1 + $7], a
    ld hl, wObject1 + $B
    inc [hl]
    ld de, wObject1 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    xor a, a
    ld [wObject1 + $7], a
    ld a, $30
    ld [wObject2 + $C], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 57 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget, wSpriteSlots
; points at: wScriptStep
ScriptCommand5E_Run_Case39::
Jump_00F_4E70:: ; address name
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $E0
    ld [wStepPtrLo], a
    ld a, $83
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $60
    ld [wStepPtrLo], a
    jr Jump_00F_4EB0

; entry 56 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wObject1
; points at: wScriptStep
ScriptCommand5E_Run_Case38::
Jump_00F_4E91:: ; address name
    ld hl, wSpriteSlots + $B
    dec [hl]
    ld de, wSpriteSlots + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld a, $30
    ld [wObject1 + $C], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 55 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepPtrLo, wStepTarget, wSpriteSlots
; points at: wScriptStep
ScriptCommand5E_Run_Case37::
Jump_00F_4EA6:: ; address name
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $60
    ld [wStepPtrLo], a

Jump_00F_4EB0::
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 54 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlots
; points at: wScriptStep
ScriptCommand5E_Run_Case36::
Jump_00F_4ECA:: ; address name
    ld b, $5A
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $30
    ld [wSpriteSlots + $C], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 53 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wObject5
; points at: wScriptStep
ScriptCommand5E_Run_Case35::
Jump_00F_4EDA:: ; address name
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $30
    ld [wObject5 + $4], a
    ld a, $60
    ld [wObject5 + $5], a
    xor a, a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 52 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY
ScriptCommand5E_Run_Case34::
Jump_00F_4EF7:: ; address name
    ld a, $2F
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    call ScriptCommand5E_Run_Shared01
    ret

; entry 49 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wObject5, wScriptParam0
; points at: wScriptStep
ScriptCommand5E_Run_Case31::
Jump_00F_4F06:: ; address name
    ld a, $80
    ld [wObject5], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $01
    jr z, Jump_00F_4F1A
    ld hl, wObject5 + $5
    dec [hl]

Jump_00F_4F1A::
    ld a, [wScriptParam0]
    cp a, $40
    ret nz
    xor a, a
    ld [wObject5], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 47 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject3
; writes: wObject3, wObject4
; points at: wScriptStep
ScriptCommand5E_Run_Case2F::
Jump_00F_4F2D:: ; address name
    ld a, [wScriptParam0]
    and a, $07
    jr nz, Jump_00F_4F40
    ld a, [wObject3 + $7]
    inc a
    and a, $03
    ld [wObject3 + $7], a
    ld [wObject4 + $7], a

Jump_00F_4F40::
    ld de, wObject2 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld a, $02
    ld [wObject3 + $7], a
    ld [wObject4 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 46 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject3
; writes: wObject3, wObject4
; points at: wScriptStep
ScriptCommand5E_Run_Case2E::
Jump_00F_4F54:: ; address name
    ld a, [wScriptParam0]
    and a, $03
    jr nz, Jump_00F_4F67
    ld a, [wObject3 + $7]
    inc a
    and a, $03
    ld [wObject3 + $7], a
    ld [wObject4 + $7], a

Jump_00F_4F67::
    ld b, $96
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 45 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wObject5, wScriptParam0
; points at: wScriptStep
ScriptCommand5E_Run_Case2D::
Jump_00F_4F72:: ; address name
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + $4], a
    ld a, $10
    ld [wObject5 + $5], a
    xor a, a
    ld [wObject5], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 44 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: wFieldEventArg, hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind, wObject5
ScriptCommand5E_Run_Case2C::
Jump_00F_4F93:: ; address name
    ld a, $01
    ld [wFieldEventArg], a
    ld a, $26
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a

; only called from routines of ScriptCommand5E_Run (E-0098)
; 7 call sites from 7 routines (e.g. ScriptCommand5E_Run_Case88, ScriptCommand5E_Run_Case7E, ScriptCommand5E_Run_Case6D, ScriptCommand5E_Run_Case5B, ...)
; reads: hPlayerY
; writes: wWarpDestX, wWarpDestY, wFieldTransitionKind, wObject5
ScriptCommand5E_Run_Shared01::
Func_00F_4FA1:: ; address name
    ld a, $E0
    ld [wWarpDestX], a
    ldh a, [hPlayerY]
    ld [wWarpDestY], a
    ld a, $04
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    xor a, a
    ld [wObject5], a
    ret

; entry 41 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wFieldEventArg, wObject5
; points at: wScriptStep
ScriptCommand5E_Run_Case29::
Jump_00F_4FBB:: ; address name
    ld a, $01
    ld [wFieldEventArg], a
    ld hl, $053A
    call StartMessageHL_B0F
    xor a, a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 37 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wFieldEventArg, hTemp0, wObject5, wScriptSubStep
; points at: wScriptStep
ScriptCommand5E_Run_Case25::
Jump_00F_4FCF:: ; address name
    ld a, $01
    ld [wFieldEventArg], a
    ld hl, $0539
    call StartMessageHL_B0F
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    xor a, a
    ld [wObject5], a
    xor a, a
    ld [wScriptSubStep], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 35 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wStepArrived
; writes: wFieldEventArg, wStepPtrLo, hPlayerFacing
; points at: wScriptStep
ScriptCommand5E_Run_Case23::
Jump_00F_4FF1:: ; address name
    xor a, a
    ld [wFieldEventArg], a
    ldh a, [hPlayerY]
    cp a, $40
    jr z, Jump_00F_5007
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
    ret

Jump_00F_5007::
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerRightTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $03
    ldh [hPlayerFacing], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 33 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptTemp4
; writes: wSpriteSlots, wFieldEventArg, wPartyCount, hFieldDrawFlags
; points at: wScriptStep
ScriptCommand5E_Run_Case21::
Jump_00F_5020:: ; address name
    ld a, $01
    ld [wSpriteSlots + $7], a
    ld hl, $0538
    call StartMessageHL_B0F
    ld a, $01
    ld [wFieldEventArg], a
    ld a, [wScriptTemp4]
    ld [wPartyCount], a
    xor a, a
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 27 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo
; points at: wScriptStep
ScriptCommand5E_Run_Case1B::
Jump_00F_503E:: ; address name
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $00
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 26 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo
; points at: wScriptStep
ScriptCommand5E_Run_Case1A::
Jump_00F_505D:: ; address name
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 24 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wFieldEventArg
; points at: hPlayerY
ScriptCommand5E_Run_Case18::
Jump_00F_507C:: ; address name
    xor a, a
    ld [wFieldEventArg], a
    ld de, hPlayerY
    call ScriptStepDeltaThenNextStep
    ret

; entry 22 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wFieldEventArg
; points at: wScriptStep
ScriptCommand5E_Run_Case16::
Jump_00F_5087:: ; address name
    ld a, $01
    ld [wFieldEventArg], a
    ld hl, $0537
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 19 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wFieldEventKind, wFieldEventTimer, wFieldEventArg
; points at: wScriptStep
ScriptCommand5E_Run_Case13::
Jump_00F_5097:: ; address name
    ld a, $0C
    ld [wFieldEventKind], a
    xor a, a
    ld [wFieldEventTimer], a

; entry 25 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wFieldEventArg
; points at: wScriptStep
ScriptCommand5E_Run_Case19::
Jump_00F_50A0:: ; address name
    xor a, a
    ld [wFieldEventArg], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 16 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wFieldEventArg
; points at: wScriptStep
ScriptCommand5E_Run_Case10::
Jump_00F_50A9:: ; address name
    xor a, a
    ld [wFieldEventArg], a
    ld hl, $0DF7
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 15 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand5E_Run_Case0F::
Jump_00F_50B8:: ; address name
    ld b, $0F
    call ScriptStepShakeScreen
    ret

; entry 13 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wObject1, wObject5
; points at: wScriptStep
ScriptCommand5E_Run_Case0D::
Jump_00F_50BE:: ; address name
    ld a, $30
    ld [wObject1 + $C], a
    xor a, a
    ld [wObject5], a
    farcall RedrawColumnsBesideScreen
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand5E_Run_Case0C::
Jump_00F_50D2:: ; address name
    farcall RunScriptSubStep_7363
    ret

; entry 11 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind, wScreenTriggerCount, wScriptSubStep
ScriptCommand5E_Run_Case0B::
Jump_00F_50D9:: ; address name
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wWarpDestX], a
    ld a, $30
    ld [wWarpDestY], a
    ld a, $04
    ld [wFieldTransitionKind], a
    xor a, a
    ld [wScreenTriggerCount], a
    farcall ScriptStartFadeAndAdvanceStep
    ld hl, $0533
    call StartMessageHL_B0F
    xor a, a
    ld [wScriptSubStep], a
    ret

; entry 9 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand5E_Run_Case09::
Jump_00F_5108:: ; address name
    ld hl, $055B
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand5E_Run_Case07::
Jump_00F_5113:: ; address name
    ld hl, $055A
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand5E_Run_Case06::
Jump_00F_511E:: ; address name
    ld hl, wSpriteSlots + $C
    inc [hl]

; entry 3 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand5E_Run_Case03::
Jump_00F_5122:: ; address name
    ld de, wSpriteSlots + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, wStepArrived
; writes: wStepPtrLo, wSpriteSlots, wScreenTileBuffer
; points at: wScriptStep
ScriptCommand5E_Run_Case02::
Jump_00F_512E:: ; address name
    ldh a, [hPlayerX]
    cp a, $40
    jr z, Jump_00F_5140
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    ret

Jump_00F_5140::
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $10
    ld [wSpriteSlots + $C], a
    ld a, $54
    ld [wScreenTileBuffer + $30], a
    ld a, $55
    ld [wScreenTileBuffer + $31], a
    farcall DrawFullScreenBufferAtScroll
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand5E_Run_Case01::
Jump_00F_516A:: ; address name
    ld b, $3C
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, wStoryFlags
; writes: hTemp0, hTemp1, wSpriteSlotCount, wStoryFlags
; points at: wScriptStep
ScriptCommand5E_Run_Case00::
Jump_00F_5175:: ; address name
    ld a, $01
    ldh [hTemp0], a
    ld a, $30
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a, a
    ret z
    ld a, $01
    ld [wSpriteSlotCount], a
    ld de, $00D1
    call SetFlagBit
    ld a, [wStoryFlags + $65]
    set 0, a
    ld [wStoryFlags + $65], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 138 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1
; writes: wFieldEventArg, wObject5
ScriptCommand5E_Run_Case8A::
Jump_00F_519F:: ; address name
    xor a, a
    ld [wFieldEventArg], a
    ld a, $80
    ld [wObject5], a
    ld a, [wScriptParam1]
    and a, $0F
    rst $00
    dw ScriptCommand5E_Run_Case8A_Case00
    dw ScriptCommand5E_Run_Case8A_Case01

; entry 0 of the `rst $00` table in ScriptCommand5E_Run_Case8A
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptSubStep, wScriptParam1
; writes: wScriptSubStep, wObject5
; points at: wScriptParam1
ScriptCommand5E_Run_Case8A_Case00::
Jump_00F_51B2:: ; address name
    ld a, [wScriptSubStep]
    bit 0, a
    jr z, Jump_00F_51BE
    inc a
    ld [wScriptSubStep], a
    ret

Jump_00F_51BE::
    srl a
    ld c, a
    ld a, $17
    sub a, c
    add a, a
    ld de, ObjectPathTable_5284
    add a, e
    ld e, a
    jr nc, Jump_00F_51CD
    inc d

Jump_00F_51CD::
    push de
    ld a, [wScriptParam1]
    and a, $70
    swap a
    ld c, $30
    call Multiply8
    pop de
    add hl, de
    ld a, [hl+]
    ld [wObject5 + $5], a
    ld a, [hl]
    add a, $10
    ld [wObject5 + $4], a
    ld a, [wScriptSubStep]
    inc a
    ld [wScriptSubStep], a
    srl a
    cp a, $17
    ret nz
    xor a, a
    ld [wScriptSubStep], a
    ld hl, wScriptParam1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand5E_Run_Case8A
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1
; writes: wObject5, wScriptSubStep, wScriptParam1
; points at: wScriptStep
ScriptCommand5E_Run_Case8A_Case01::
Jump_00F_51FB:: ; address name
    xor a, a
    ld [wObject5], a
    ld a, [wScriptParam1]
    add a, $10
    and a, $F0
    cp a, $80
    jr nz, Jump_00F_5213
    xor a, a
    ld [wScriptSubStep], a
    ld hl, wScriptStep
    inc [hl]
    xor a, a

Jump_00F_5213::
    ld [wScriptParam1], a
    ret

; entry 40 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1
; writes: wFieldEventArg, wObject5
ScriptCommand5E_Run_Case28::
Jump_00F_5217:: ; address name
    xor a, a
    ld [wFieldEventArg], a
    ld a, $80
    ld [wObject5], a
    ld a, [wScriptParam1]
    and a, $0F
    rst $00
    dw ScriptCommand5E_Run_Case28_Case00
    dw ScriptCommand5E_Run_Case28_Case01

; entry 0 of the `rst $00` table in ScriptCommand5E_Run_Case28
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptSubStep, wScriptParam1
; writes: wScriptSubStep, wObject5
; points at: wScriptParam1
ScriptCommand5E_Run_Case28_Case00::
Jump_00F_522A:: ; address name
    ld a, [wScriptSubStep]
    bit 0, a
    jr z, Jump_00F_5236
    inc a
    ld [wScriptSubStep], a
    ret

Jump_00F_5236::
    and a, $FE
    ld de, ObjectPathTable_5284
    add a, e
    ld e, a
    jr nc, Jump_00F_5240
    inc d

Jump_00F_5240::
    push de
    ld a, [wScriptParam1]
    and a, $70
    swap a
    ld c, $30
    call Multiply8
    pop de
    add hl, de
    ld a, [hl+]
    ld [wObject5 + $5], a
    ld a, [hl]
    ld [wObject5 + $4], a
    ld a, [wScriptSubStep]
    inc a
    ld [wScriptSubStep], a
    srl a
    cp a, $17
    ret nz
    xor a, a
    ld [wScriptSubStep], a
    ld hl, wScriptParam1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand5E_Run_Case28
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1
; writes: wScriptSubStep, wScriptParam1
; points at: wScriptStep
ScriptCommand5E_Run_Case28_Case01::
Jump_00F_526C:: ; address name
    ld a, [wScriptParam1]
    add a, $10
    and a, $F0
    cp a, $80
    jr nz, Jump_00F_5280
    xor a, a
    ld [wScriptSubStep], a
    ld hl, wScriptStep
    inc [hl]
    xor a, a

Jump_00F_5280::
    ld [wScriptParam1], a
    ret

; E-0206 (C1: ScriptCommand5E_Run_Case28_Case00 reads, every other frame, the pair at $5284 + $30 * ((wScriptParam1 & $70) >> 4) + 2 * step into wObject5 + 5 and + 4, for 23 steps per path; 8 paths end at ScriptCommand58_Run).
; record: 24 steps of two bytes (wObject5 + 5, wObject5 + 4), 12 per line
ObjectPathTable_5284::
Data_00F_5284:: ; address name
    db $FE, $06, $00, $09, $02, $0C, $04, $0F, $06, $12, $08, $15, $0A, $18, $0C, $1B, $0E, $1E, $10, $21, $12, $23, $14, $26 ; id 0
    db $16, $28, $18, $2B, $1A, $2D, $1C, $30, $1E, $32, $20, $34, $22, $36, $24, $38, $26, $3A, $28, $3C, $2A, $3E, $2C, $40
    db $FE, $63, $00, $61, $02, $5F, $04, $5D, $06, $5B, $08, $59, $0A, $57, $0C, $55, $0E, $53, $10, $52, $12, $50, $14, $4F ; id 1
    db $16, $4D, $18, $4B, $1A, $4A, $1C, $48, $1E, $47, $20, $46, $22, $45, $24, $44, $26, $43, $28, $42, $2A, $41, $2C, $40
    db $FE, $1D, $00, $1F, $02, $21, $04, $23, $06, $25, $08, $27, $0A, $29, $0C, $2B, $0E, $2D, $10, $2F, $12, $30, $14, $32 ; id 2
    db $16, $33, $18, $35, $1A, $36, $1C, $38, $1E, $39, $20, $3A, $22, $3B, $24, $3C, $26, $3D, $28, $3E, $2A, $3F, $2C, $40
    db $FE, $76, $00, $74, $02, $71, $04, $6E, $06, $6C, $08, $69, $0A, $67, $0C, $64, $0E, $62, $10, $5F, $12, $5D, $14, $5A ; id 3
    db $16, $58, $18, $55, $1A, $53, $1C, $50, $1E, $4E, $20, $4C, $22, $4A, $24, $48, $26, $46, $28, $44, $2A, $42, $2C, $40
    db $0C, $FC, $0C, $FF, $0C, $03, $0D, $07, $0D, $0B, $0E, $0F, $0F, $13, $10, $17, $11, $1C, $13, $20, $14, $23, $16, $26 ; id 4
    db $17, $28, $19, $2B, $1A, $2D, $1C, $30, $1E, $32, $20, $34, $22, $36, $24, $38, $26, $3A, $28, $3C, $2A, $3E, $2C, $40
    db $FE, $63, $00, $61, $02, $5F, $04, $5D, $06, $5B, $08, $59, $0A, $57, $0C, $55, $0E, $53, $10, $52, $12, $50, $14, $4F ; id 5
    db $16, $4D, $18, $4B, $1A, $4A, $1C, $48, $1E, $47, $20, $46, $22, $45, $24, $44, $26, $43, $28, $42, $2A, $41, $2C, $40
    db $0C, $89, $0C, $85, $0C, $81, $0D, $7D, $0D, $79, $0E, $75, $0F, $71, $10, $6D, $11, $69, $13, $65, $14, $61, $16, $5E ; id 6
    db $17, $5A, $19, $57, $1A, $54, $1C, $51, $1E, $4E, $20, $4C, $22, $4A, $24, $48, $26, $46, $28, $44, $2A, $42, $2C, $40
    db $FE, $76, $00, $74, $02, $71, $04, $6E, $06, $6C, $08, $69, $0A, $67, $0C, $64, $0E, $62, $10, $5F, $12, $5D, $14, $5A ; id 7
    db $16, $58, $18, $55, $1A, $53, $1C, $50, $1E, $4E, $20, $4C, $22, $4A, $24, $48, $26, $46, $28, $44, $2A, $42, $2C, $40

; implements script command type 58; reached through ScriptCommand58 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand58)
; reads: wScriptStep
ScriptCommand58_Run::
Func_00F_5404:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand58_Run_Case00
    dw ScriptCommand58_Run_Case01
    dw ScriptCommand58_Run_Case02
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand58_Run_Case04
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand58_Run_Case06
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand58_Run_Case08
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand58_Run_Case0A
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand58_Run_Case0C
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand58_Run_Case0E
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand58_Run_Case10
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand58_Run_Case12
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand58_Run_Case14
    dw ScriptCommand58_Run_Case15
    dw ScriptCommand58_Run_Case16
    dw ScriptCommand58_Run_Case17
    dw ScriptCommand58_Run_Case18
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand58_Run_Case1A
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand58_Run_Case1C
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand58_Run_Case1E
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand58_Run_Case20
    dw ScriptCommand58_Run_Case21
    dw ScriptCommand58_Run_Case22
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand58_Run_Case00
    dw ScriptCommand58_Run_Case01
    dw ScriptCommand58_Run_Case26
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand58_Run_Case28
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand58_Run_Case2A
    dw ScriptCommand58_Run_Case2B

; entry 43 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags, wGameFlags836
; writes: hTemp0, wStoryFlags, hTemp1, wGameFlags836, wScriptStartRequest
ScriptCommand58_Run_Case2B::
Jump_00F_5460:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $05
    ldh [hTemp0], a
    farcall MarkKeyEntryKindTemp0Bit6
    ld a, [wStoryFlags + $60]
    set 4, a
    ld [wStoryFlags + $60], a
    farcall CountKeysOrFull
    ld a, $06
    ldh [hTemp1], a
    farcall WriteKeyEntryTemp0
    ld a, [wGameFlags836]
    set 7, a
    ld [wGameFlags836], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 42 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; points at: hPlayerY
ScriptCommand58_Run_Case2A::
Jump_00F_5495:: ; address name
    ld de, hPlayerY
    ld hl, $0A7E
    call ScriptStepDeltaThenMessage
    ret

; entry 40 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wSpriteSlotCount
; points at: wScriptStep
ScriptCommand58_Run_Case28::
Jump_00F_549F:: ; address name
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $81
    ld [wStepTarget], a
    ld a, $B0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld de, $00C3
    call SetFlagBit
    farcall PlayMapMusic
    ld a, $01
    ld [wSpriteSlotCount], a
    ld hl, $0A7D
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 38 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand58_Run_Case26::
Jump_00F_54D5:: ; address name
    ld hl, $0A7C
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 34 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wOBJPaletteUploadRequest
; points at: wScriptStep
ScriptCommand58_Run_Case22::
Jump_00F_54E0:: ; address name
    farcall FullyHealParty
    farcall MoveIncapacitatedPartyMembersBack
    farcall MoveIncapacitatedPartyMembersBack
    call LoadRecordListNameTiles
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld hl, $0A7B
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 30 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
ScriptCommand58_Run_Case1E::
Jump_00F_550B:: ; address name
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wWarpDestX], a
    ld a, $30
    ld [wWarpDestY], a
    ld de, $0024
    call SetFlagBit
    ld a, $04
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld hl, $0A7A
    call StartMessageHL_B0F
    ret

; entry 28 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand58_Run_Case1C::
Jump_00F_5538:: ; address name
    ld hl, $0491
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 26 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand58_Run_Case1A::
Jump_00F_5543:: ; address name
    ld hl, $0490
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 24 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand58_Run_Case18::
Jump_00F_554E:: ; address name
    ld de, wObject2 + $C
    ld hl, $048F
    call ScriptStepDeltaThenMessage
    ret

; entry 23 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wSpriteSlots
; points at: wScriptStep
ScriptCommand58_Run_Case17::
Jump_00F_5558:: ; address name
    ld a, [wScriptParam0]
    swap a
    srl a
    srl a
    and a, $01
    add a, a
    inc a
    ld [wSpriteSlots + $7], a
    ld b, $B4
    call StepScriptParam0Counter_Bank0F
    ret nc
    xor a, a
    ld [wSpriteSlots + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 22 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags, hPlayerX, hPlayerY
; writes: wStoryFlags, wWarpDestX, wWarpDestY, wFieldTransitionKind, wModeState, wFieldTransitionStep
; points at: wScriptStep
ScriptCommand58_Run_Case16::
Jump_00F_5577:: ; address name
    ld a, [wStoryFlags + $64]
    set 3, a
    ld [wStoryFlags + $64], a
    ld de, $00C2
    call SetFlagBit
    ldh a, [hPlayerX]
    ld [wWarpDestX], a
    ldh a, [hPlayerY]
    ld [wWarpDestY], a
    ld a, $01
    call StartPaletteFade
    ld a, $03
    ld [wFieldTransitionKind], a
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wFieldTransitionStep], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 21 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlotCount
ScriptCommand58_Run_Case15::
Jump_00F_55A7:: ; address name
    ld a, $01
    ld [wSpriteSlotCount], a

; entry 33 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand58_Run_Case21::
Jump_00F_55AC:: ; address name
    farcall ScriptStepFlashScreenNegative
    ret

; entry 32 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; points at: wBGPaletteBuffer, wBGPaletteCopy, wScriptStep
ScriptCommand58_Run_Case20::
Jump_00F_55B3:: ; address name
    ld a, $7A
    call QueueSoundEffect

; entry 20 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; points at: wBGPaletteBuffer, wBGPaletteCopy, wScriptStep
ScriptCommand58_Run_Case14::
Jump_00F_55B8:: ; address name
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_00F_55CA
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes

Jump_00F_55CA::
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 18 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand58_Run_Case12::
Jump_00F_55CF:: ; address name
    ld hl, $048E
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 16 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand58_Run_Case10::
Jump_00F_55DA:: ; address name
    ld hl, $048D
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 14 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo, hPlayerY, wObject5
; writes: wObject5
; points at: wScriptStep
ScriptCommand58_Run_Case0E::
Jump_00F_55E5:: ; address name
    ld a, [wFrameCounterLo]
    bit 2, a
    jr z, Jump_00F_55F2
    xor a, a
    ld [wObject5], a
    jr Jump_00F_55F7

Jump_00F_55F2::
    ld a, $80
    ld [wObject5], a

Jump_00F_55F7::
    ldh a, [hPlayerY]
    ld c, a
    ld a, [wObject5 + $5]
    inc a
    ld [wObject5 + $5], a
    cp a, c
    ret nz
    xor a, a
    ld [wObject5], a
    ld hl, $048C
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult, hPlayerX
; writes: hTemp0, wObject5
; points at: wScriptStep
ScriptCommand58_Run_Case0C::
Jump_00F_5612:: ; address name
    ld a, [wTextYesNoResult]
    or a, a
    jr z, Jump_00F_5623
    ld hl, wSGBPacketBuffer + $B
    call StartMessageHL_B0F
    ld hl, wScriptStep
    dec [hl]
    ret

Jump_00F_5623::
    ld hl, vTiles0 + $48B
    call StartMessageHL_B0F
    ld a, $04
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ldh a, [hPlayerX]
    ld [wObject5 + $4], a
    ld a, $E0
    ld [wObject5 + $5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand58_Run_Case0A::
Jump_00F_5642:: ; address name
    ld hl, $4487
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 8 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand58_Run_Case08::
Jump_00F_564D:: ; address name
    ld de, wSpriteSlots + $C
    ld hl, $0486
    call ScriptStepDeltaThenMessage
    ret

; entry 6 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand58_Run_Case06::
Jump_00F_5657:: ; address name
    ld hl, $0485
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wObject3, wObject1, wSpriteSlots
; points at: wScriptStep
ScriptCommand58_Run_Case04::
Jump_00F_5662:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_566D
    ld a, $1F
    call QueueMusic

Jump_00F_566D::
    ld a, $18
    ld [wObject3 + $C], a
    ld a, [wScriptParam0]
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
    ld [wObject1 + $C], a
    jr Jump_00F_569B

Jump_00F_5696::
    ld a, $C0
    ld [wObject1 + $C], a

Jump_00F_569B::
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $02
    ld [wSpriteSlots + $7], a
    ld hl, $0484
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand58_Run_Case02::
Jump_00F_56B1:: ; address name
    ld hl, $0483
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand58_Run_Case01::
Jump_00F_56BC:: ; address name
    ld b, $78
    call ScriptStepShakeScreen
    ret

; entry 0 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand58_Run_Case00::
Jump_00F_56C2:: ; address name
    farcall RedrawColumnsBesideScreen
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 4E; reached through ScriptCommand4E in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand4E)
; reads: wScriptStep
ScriptCommand4E_Run::
Func_00F_56CD:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand4E_Run_Case00
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand4E_Run_Case02
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand4E_Run_Case04

; entry 4 of the `rst $00` table in ScriptCommand4E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp1, hTemp0, wScriptStartRequest
ScriptCommand4E_Run_Case04::
Jump_00F_56DB:: ; address name
    ld a, $40
    ldh [hTemp1], a
    ld a, $01
    ldh [hTemp0], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a, a
    ret z
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommand4E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult
; points at: wScriptStep
ScriptCommand4E_Run_Case02::
Jump_00F_56F3:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, Jump_00F_570A
    ld hl, vTiles0 + $416
    call StartMessageHL_B0F
    ld de, $00A6
    call SetFlagBit
    ret

Jump_00F_570A::
    ld hl, vTiles0 + $417
    call StartMessageHL_B0F
    ld de, $00A5
    call SetFlagBit
    ret

; entry 0 of the `rst $00` table in ScriptCommand4E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wObject1, wSpriteSlotCount, wScriptParam0, wScriptStep
; points at: wScriptStep
ScriptCommand4E_Run_Case00::
Jump_00F_5717:: ; address name
    ld a, $40
    ld [wObject1 + $C], a
    ld a, [wScriptParam0]
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
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $02
    ld [wSpriteSlotCount], a
    xor a, a
    ld [wScriptParam0], a
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
    call StartMessageHL_B0F
    ld a, $03
    ld [wScriptStep], a
    ret

Jump_00F_5791::
    ld hl, $040D
    call StartMessageHL_B0F
    ld a, $03
    ld [wScriptStep], a
    ret

Jump_00F_579D::
    ld de, $00A0
    call TestFlagBit
    jr c, Jump_00F_57B0
    ld hl, $4415
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_57B0::
    ld hl, $4418
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_57BB::
    ld hl, $4419
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_57C6::
    ld hl, $0416
    call StartMessageHL_B0F
    ld a, $03
    ld [wScriptStep], a
    ret

Jump_00F_57D2::
    ld hl, $0452
    call StartMessageHL_B0F
    ld a, $03
    ld [wScriptStep], a
    ret

Jump_00F_57DE::
    ld hl, $0493
    call StartMessageHL_B0F
    ld a, $03
    ld [wScriptStep], a
    ret

; implements script command type 4B; reached through ScriptCommand4B in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand4B)
; reads: wScriptStep
ScriptCommand4B_Run::
Func_00F_57EA:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand4B_Run_Case00
    dw ScriptCommand4B_Run_Case01
    dw ScriptCommand4B_Run_Case02
    dw ScriptCommand4B_Run_Case03
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand4B_Run_Case02
    dw ScriptCommand4B_Run_Case06
    dw ScriptCommand4B_Run_Case02
    dw ScriptCommand4B_Run_Case08
    dw ScriptCommand4B_Run_Case02
    dw ScriptCommand4B_Run_Case0A
    dw ScriptCommand4B_Run_Case0B
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand4B_Run_Case0D
    dw ScriptCommand4B_Run_Case0E
    dw ScriptCommand4B_Run_Case0F
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand4B_Run_Case11
    dw ScriptCommand4B_Run_Case12
    dw ScriptCommand4B_Run_Case13
    dw ScriptCommand4B_Run_Case14
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand4B_Run_Case16

; entry 22 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags
; writes: hTemp0, wStoryFlags, wScriptStartRequest
ScriptCommand4B_Run_Case16::
Jump_00F_581C:: ; address name
    ld de, $0023
    call SetFlagBit
    ld a, $04
    ldh [hTemp0], a
    farcall MarkKeyEntryKindTemp0Bit6
    ld a, [wStoryFlags + $60]
    set 3, a
    ld [wStoryFlags + $60], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 20 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wObject5
; writes: wObject5
; points at: wScriptStep
ScriptCommand4B_Run_Case14::
Jump_00F_583A:: ; address name
    ldh a, [hPlayerY]
    ld c, a
    ld a, [wObject5 + $5]
    inc a
    ld [wObject5 + $5], a
    cp a, c
    ret nz
    xor a, a
    ld [wObject5], a
    ld hl, $0DCB
    call StartMessageHL_B0F
    ld de, $001E
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 19 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerFacing, hPlayerX, hPlayerY
; writes: wSpriteSlots, hTemp0, wObject5
; points at: wScriptStep
ScriptCommand4B_Run_Case13::
Jump_00F_585B:: ; address name
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ld [wSpriteSlots + $7], a
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ldh a, [hPlayerX]
    ld [wObject5 + $4], a
    ldh a, [hPlayerY]
    sub a, $20
    ld [wObject5 + $5], a
    ld a, $80
    ld [wObject5], a
    ld a, $85
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 18 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand4B_Run_Case12::
Jump_00F_5889:: ; address name
    farcall RunScriptSubStep_7363
    ret

; entry 17 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind, wScreenTriggerCount, wScriptSubStep
; points at: hPlayerStateFlags
ScriptCommand4B_Run_Case11::
Jump_00F_5890:: ; address name
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wWarpDestX], a
    ld a, $30
    ld [wWarpDestY], a
    ld a, $01
    ld [wFieldTransitionKind], a
    xor a, a
    ld [wScreenTriggerCount], a
    farcall ScriptStartFadeAndAdvanceStep
    ld hl, $02A7
    call StartMessageHL_B0F
    xor a, a
    ld [wScriptSubStep], a
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank0F
    ret

; entry 15 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand4B_Run_Case0F::
Jump_00F_58C5:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld hl, $0A0A
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 14 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand4B_Run_Case0E::
Jump_00F_58D5:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld hl, $0A09
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlots
; points at: wScriptStep
ScriptCommand4B_Run_Case0D::
Jump_00F_58E5:: ; address name
    ld hl, wSpriteSlots + $C
    inc [hl]
    ld de, wSpriteSlots + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld a, $E0
    ld [wSpriteSlots + $C], a
    ld hl, $0A08
    call StartMessageHL_B0F
    ld de, $01E5
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 11 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wObject2, wSpriteSlotCount
; points at: wScriptStep
ScriptCommand4B_Run_Case0B::
Jump_00F_5906:: ; address name
    ld a, $18
    ld [wObject2 + $C], a
    ld a, [wScriptParam0]
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
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $03
    ld [wSpriteSlotCount], a
    ld hl, $0A07
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestY
ScriptCommand4B_Run_Case0A::
Jump_00F_594A:: ; address name
    ld a, $49
    ldh [hMapId], a
    ld a, $00
    ldh [hMapScreenX], a
    ld a, $00
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestY], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; entry 8 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags
; writes: wStoryFlags
ScriptCommand4B_Run_Case08::
Jump_00F_5962:: ; address name
    ld a, [wStoryFlags + $63]
    set 1, a
    ld [wStoryFlags + $63], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; entry 6 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
ScriptCommand4B_Run_Case06::
Jump_00F_5971:: ; address name
    ld a, $48
    ldh [hMapId], a
    ld a, $07
    ldh [hMapScreenX], a
    ld a, $05
    ldh [hMapScreenY], a
    ldh a, [hPlayerX]
    ld [wWarpDestX], a
    ld a, $E0
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; entry 3 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
; points at: wScriptStep
ScriptCommand4B_Run_Case03::
Jump_00F_5993:: ; address name
    ld hl, wObject5 + $5
    dec [hl]
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE
    ret nc
    xor a, a
    ld [wObject5], a
    ld hl, $0DCA
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand4B_Run_Case02::
Jump_00F_59AD:: ; address name
    ld b, $3C
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand4B_Run_Case01::
Jump_00F_59B8:: ; address name
    ld hl, wObject5 + $5
    dec [hl]
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, hPlayerY
; writes: hTemp0, wObject5
; points at: wScriptStep
ScriptCommand4B_Run_Case00::
Jump_00F_59C8:: ; address name
    ld a, $10
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ldh a, [hPlayerX]
    ld [wObject5 + $4], a
    ldh a, [hPlayerY]
    ld [wObject5 + $5], a
    ld a, $80
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 4A; reached through ScriptCommand4A in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand4A)
; reads: wScriptStep
ScriptCommand4A_Run::
Func_00F_59E6:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand4A_Run_Case00
    dw ScriptCommand4A_Run_Case01
    dw ScriptCommand4A_Run_Case02
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand4A_Run_Case04
    dw ScriptCommand4A_Run_Case05
    dw ScriptCommand4A_Run_Case06
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand4A_Run_Case08
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand4A_Run_Case0A
    dw ScriptCommand62_Run_Case01

; entry 10 of the `rst $00` table in ScriptCommand4A_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand4A_Run_Case0A::
Jump_00F_5A02:: ; address name
    ld hl, $0A05
    call StartMessageHL_B0F
    ld de, $01E4
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 8 of the `rst $00` table in ScriptCommand4A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, hTemp0
; writes: hTemp1, hTemp0
; points at: wScriptStep
ScriptCommand4A_Run_Case08::
Jump_00F_5A13:: ; address name
    ld a, [wScriptParam1]
    ldh [hTemp1], a
    ld a, $01
    ldh [hTemp0], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a, a
    ret z
    ld hl, $0DDF
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommand4A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1
; writes: wScriptParam1
; points at: wScriptStep
ScriptCommand4A_Run_Case06::
Jump_00F_5A31:: ; address name
    ld hl, $0A04
    call StartMessageHL_B0F
    ld a, [wObject1 + $C]
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in ScriptCommand4A_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
; points at: wScriptStep
ScriptCommand4A_Run_Case05::
Jump_00F_5A42:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $19
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand4A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult
; writes: wScriptStep
; points at: wScriptStep
ScriptCommand4A_Run_Case04::
Jump_00F_5A56:: ; address name
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, Jump_00F_5A67
    ld hl, vTiles1 + $5D0
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_5A67::
    ld hl, vTiles1 + $5D1
    call StartMessageHL_B0F
    ld a, $0B
    ld [wScriptStep], a
    ret

; entry 2 of the `rst $00` table in ScriptCommand4A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wObject1
; points at: wScriptStep
ScriptCommand4A_Run_Case02::
Jump_00F_5A73:: ; address name
    ld a, [wScriptParam0]
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
    ld [wObject1 + $C], a
    jr Jump_00F_5A9C

Jump_00F_5A97::
    ld a, $E0
    ld [wObject1 + $C], a

Jump_00F_5A9C::
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $20
    ld [wObject1 + $C], a
    ld hl, $4A02
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand4A_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand4A_Run_Case01::
Jump_00F_5AB2:: ; address name
    farcall ScriptStepFlashScreenNegative
    ret

; entry 0 of the `rst $00` table in ScriptCommand4A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wScriptParam1, wScriptStep
; points at: wBGPaletteBuffer, wBGPaletteCopy, wScriptStep
ScriptCommand4A_Run_Case00::
Jump_00F_5AB9:: ; address name
    ld de, $01E3
    call TestFlagBit
    jr nc, Jump_00F_5AD2
    ld hl, $0A03
    call StartMessageHL_B0F
    ld a, $01
    ld [wScriptParam1], a
    ld a, $05
    ld [wScriptStep], a
    ret

Jump_00F_5AD2::
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_00F_5AE4
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes

Jump_00F_5AE4::
    ld de, $01E3
    call SetFlagBit
    xor a, a
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 66; reached through ScriptCommand66 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand66)
; reads: wScriptStep
ScriptCommand66_Run::
Func_00F_5AF3:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand66_Run_Case00
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand66_Run_Case02
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand66_Run_Case04
    dw ScriptCommand66_Run_Case05
    dw ScriptCommand66_Run_Case06
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand66_Run_Case08
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand66_Run_Case0A
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand66_Run_Case0C
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand66_Run_Case0E
    dw ScriptCommand62_Run_Case01

; entry 14 of the `rst $00` table in ScriptCommand66_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlots
; points at: wScriptStep
ScriptCommand66_Run_Case0E::
Jump_00F_5B17:: ; address name
    xor a, a
    ld [wSpriteSlots + $7], a
    ld hl, $0AF5
    call StartMessageHL_B0F
    ld de, $01E2
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in ScriptCommand66_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wObject1
ScriptCommand66_Run_Case0C::
Jump_00F_5B2C:: ; address name
    ld a, $02
    ld [wObject1 + $7], a
    ld de, wObject1 + $C
    ld hl, $0AF4
    call ScriptStepDeltaThenMessage
    ret

; entry 10 of the `rst $00` table in ScriptCommand66_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlots
; points at: wScriptStep
ScriptCommand66_Run_Case0A::
Jump_00F_5B3B:: ; address name
    ld de, FieldSpriteGfx0F
    ld b, $7D
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    xor a, a
    ld [wSpriteSlots + $7], a
    ld a, $0F
    ld [wSpriteSlots + $2], a
    ld a, $01
    ld [wSpriteSlots + $7], a
    ld hl, $0AF3
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 8 of the `rst $00` table in ScriptCommand66_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0, hTemp1, wSpriteSlotCount, wObject1
; points at: wScriptStep
ScriptCommand66_Run_Case08::
Jump_00F_5B5F:: ; address name
    ld a, $02
    ldh [hTemp0], a
    ld a, $20
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a, a
    ret z
    ld a, $02
    ld [wSpriteSlotCount], a
    ld a, $03
    ld [wObject1 + $7], a
    ld hl, $0AF2
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommand66_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand66_Run_Case06::
Jump_00F_5B86:: ; address name
    ld hl, $0AF0
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in ScriptCommand66_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
; points at: wScriptStep
ScriptCommand66_Run_Case05::
Jump_00F_5B91:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $04
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand66_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult
; writes: wScriptStep
; points at: wScriptStep
ScriptCommand66_Run_Case04::
Jump_00F_5BA5:: ; address name
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, Jump_00F_5BB6
    ld hl, vTiles1 + $5CE
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_5BB6::
    ld hl, vTiles1 + $5CF
    call StartMessageHL_B0F
    ld a, $0F
    ld [wScriptStep], a
    ret

; entry 2 of the `rst $00` table in ScriptCommand66_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wObject2, wSpriteSlotCount
; points at: wScriptStep
ScriptCommand66_Run_Case02::
Jump_00F_5BC2:: ; address name
    ld a, $20
    ld [wObject2 + $C], a
    ld a, [wScriptParam0]
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
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $03
    ld [wSpriteSlotCount], a
    ld hl, $4AEE
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand66_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wScriptStep
; points at: wScriptStep
ScriptCommand66_Run_Case00::
Jump_00F_5C06:: ; address name
    ld de, $01E1
    call TestFlagBit
    jr c, Jump_00F_5C2F
    ld hl, $0AED
    call StartMessageHL_B0F
    ld a, $34
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    farcall RemoveInventorySlotShiftDown
    ld de, $01E1
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_5C2F::
    ld hl, $0AEF
    call StartMessageHL_B0F
    ld a, $05
    ld [wScriptStep], a
    ret

; implements script command type 49; reached through ScriptCommand49 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand49)
; reads: wScriptStep
ScriptCommand49_Run::
Func_00F_5C3B:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand49_Run_Case00
    dw ScriptCommand49_Run_Case01
    dw ScriptCommand49_Run_Case02
    dw ScriptCommand49_Run_Case03

; entry 3 of the `rst $00` table in ScriptCommand49_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, hPlayerY, wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, hPlayerFacing, wObject1, wScriptStartRequest
ScriptCommand49_Run_Case03::
Jump_00F_5C47:: ; address name
    ld a, [wObject1 + $C]
    cp a, $40
    jr z, Jump_00F_5C65
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    jr Jump_00F_5C7A

Jump_00F_5C65::
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $01
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord

Jump_00F_5C7A::
    ldh a, [hPlayerY]
    cp a, $40
    jr z, Jump_00F_5C8C
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    ret

Jump_00F_5C8C::
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerRightTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $02
    ldh [hPlayerFacing], a
    ld [wObject1 + $7], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommand49_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, hPlayerY, wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo
; points at: wScriptStep
ScriptCommand49_Run_Case02::
Jump_00F_5CA9:: ; address name
    ld a, [wObject1 + $B]
    cp a, $30
    jr z, Jump_00F_5CC7
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    jr Jump_00F_5CDC

Jump_00F_5CC7::
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord

Jump_00F_5CDC::
    ldh a, [hPlayerY]
    cp a, $70
    jr z, Jump_00F_5CEE
    ld a, $70
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    ret

Jump_00F_5CEE::
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand49_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wFieldActionRequest
; points at: wScriptStep
ScriptCommand49_Run_Case01::
Jump_00F_5D03:: ; address name
    farcall UpdatePlayerMovement
    farcall RunFieldActionRequestActionIfBit7
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand49_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, hPlayerX, wStepArrived, hPlayerStateFlags
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wFieldActionRequest, wScreenScrollDir, hPlayerStateFlags, hPlayerStepDYLo, hPlayerStepDYHi
; points at: hMapScreenY, hFF80, wScriptStep
ScriptCommand49_Run_Case00::
Jump_00F_5D1A:: ; address name
    ld a, [wSpriteSlots + $B]
    cp a, $50
    jr z, Jump_00F_5D38
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    jr Jump_00F_5D4D

Jump_00F_5D38::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $E0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord

Jump_00F_5D4D::
    ldh a, [hPlayerX]
    cp a, $50
    jr z, Jump_00F_5D5F
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    ret

Jump_00F_5D5F::
    ld a, $00
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $80
    ld [wFieldActionRequest], a
    ld a, $04
    ld [wScreenScrollDir], a
    ld hl, hMapScreenY
    dec [hl]
    ldh a, [hPlayerStateFlags]
    or a, $01
    ldh [hPlayerStateFlags], a
    ld hl, $FF80
    ld a, l
    ldh [hPlayerStepDYLo], a
    ld a, h
    ldh [hPlayerStepDYHi], a
    farcall UpdatePlayerMovement
    farcall RunFieldActionRequestActionIfBit7
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 48; reached through ScriptCommand48 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand48)
; reads: wScriptStep
ScriptCommand48_Run::
Func_00F_5D9D:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand48_Run_Case00
    dw ScriptCommand48_Run_Case01
    dw ScriptCommand48_Run_Case02
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand48_Run_Case04
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand48_Run_Case06
    dw ScriptCommand48_Run_Case07
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand48_Run_Case09
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand48_Run_Case0B
    dw ScriptCommand62_Run_Case01

; entry 11 of the `rst $00` table in ScriptCommand48_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand48_Run_Case0B::
Jump_00F_5DBB:: ; address name
    ld hl, $0AD5
    call StartMessageHL_B0F
    ld de, $009D
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in ScriptCommand48_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0, hTemp1
; points at: wSpriteSlotCount, wScriptStep
ScriptCommand48_Run_Case09::
Jump_00F_5DCC:: ; address name
    ld a, $02
    ldh [hTemp0], a
    ld a, $30
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a, a
    ret z
    ld hl, wSpriteSlotCount
    dec [hl]
    ld hl, $0AD0
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in ScriptCommand48_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand48_Run_Case07::
Jump_00F_5DED:: ; address name
    ld hl, $0AD4
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommand48_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
; points at: wScriptStep
ScriptCommand48_Run_Case06::
Jump_00F_5DF8:: ; address name
    ld a, $18
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand48_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, wTextYesNoResult
; writes: hTemp0, wScriptStep
; points at: wScriptStep
ScriptCommand48_Run_Case04::
Jump_00F_5E07:: ; address name
    ld a, $33
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_00F_5E1D
    farcall RemoveInventorySlotShiftDown

Jump_00F_5E1D::
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, Jump_00F_5E2E
    ld hl, vTiles1 + $5CC
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_5E2E::
    ld hl, vTiles1 + $5CD
    call StartMessageHL_B0F
    ld a, $0C
    ld [wScriptStep], a
    ret

; entry 2 of the `rst $00` table in ScriptCommand48_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1
; writes: wScriptStep
; points at: wScriptStep
ScriptCommand48_Run_Case02::
Jump_00F_5E3A:: ; address name
    ld a, [wScriptParam1]
    or a, a
    jr nz, Jump_00F_5E46
    ld hl, wSpriteSlots + $C
    dec [hl]
    jr Jump_00F_5E4A

Jump_00F_5E46::
    ld hl, wSpriteSlots + $C
    inc [hl]

Jump_00F_5E4A::
    ld de, wSpriteSlots + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ld de, $009C
    call TestFlagBit
    jr c, Jump_00F_5E6A
    ld hl, $4AD2
    call StartMessageHL_B0F
    ld de, $009C
    call SetFlagBit
    ret

Jump_00F_5E6A::
    ld a, $06
    ld [wScriptStep], a
    ret

; entry 1 of the `rst $00` table in ScriptCommand48_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject1, wSpriteSlots, hPlayerY, wPartyCount, wFollowerRecords
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0, wObject1, wObject2, wScriptParam1
; points at: wScriptStep
ScriptCommand48_Run_Case01::
Jump_00F_5E70:: ; address name
    ld hl, wObject1 + $B
    dec [hl]
    ld hl, wObject1 + $C
    inc [hl]
    ld de, wObject1 + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    jr nz, Jump_00F_5E9D
    ld a, [wObject1 + $7]
    inc a
    and a, $03
    ld [wObject1 + $7], a

Jump_00F_5E9D::
    ld a, [wScriptParam0]
    cp a, $20
    ret nz
    ld a, [wSpriteSlots + $7]
    ld [wObject1 + $7], a
    ld [wObject2 + $7], a
    ld a, [wObject1 + $B]
    ld [wObject2 + $B], a
    ld a, [wObject1 + $C]
    ld [wObject2 + $C], a
    ld a, $E0
    ld [wObject1 + $B], a
    ld a, $63
    call QueueSoundEffect
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    xor a, a
    ld [wScriptParam1], a
    ldh a, [hPlayerY]
    cp a, $20
    jr z, Jump_00F_5EE2
    cp a, $40
    ret z
    ld a, [wPartyCount]
    dec a
    ret z
    ld a, [wFollowerRecords + $7]
    cp a, $20
    ret nz

Jump_00F_5EE2::
    ld a, $01
    ld [wScriptParam1], a
    ret

; entry 0 of the `rst $00` table in ScriptCommand48_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1
; writes: wScriptStep
; points at: wScriptStep
ScriptCommand48_Run_Case00::
Jump_00F_5EE8:: ; address name
    ld a, [wObject1 + $B]
    cp a, $80
    jr nz, Jump_00F_5F00
    ld a, [wObject1 + $C]
    cp a, $10
    jr nz, Jump_00F_5F00
    ld a, $65
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_5F00::
    ld a, $06
    ld [wScriptStep], a
    ret

; implements script command type 46; reached through ScriptCommand46 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand46)
; reads: wScriptStep
ScriptCommand46_Run::
Func_00F_5F06:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand46_Run_Case00
    dw ScriptCommand46_Run_Case01
    dw ScriptCommand46_Run_Case02
    dw ScriptCommand46_Run_Case03
    dw ScriptCommand46_Run_Case04
    dw ScriptCommand46_Run_Case03
    dw ScriptCommand46_Run_Case04
    dw ScriptCommand46_Run_Case07
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand46_Run_Case09
    dw ScriptCommand46_Run_Case0A
    dw ScriptCommand46_Run_Case0B
    dw ScriptCommand46_Run_Case0C
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand46_Run_Case0E
    dw ScriptCommand46_Run_Case0F
    dw ScriptCommand46_Run_Case10

; entry 16 of the `rst $00` table in ScriptCommand46_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hPlayerFacing, wScriptStartRequest
ScriptCommand46_Run_Case10::
Jump_00F_5F2C:: ; address name
    ld a, $02
    ldh [hPlayerFacing], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 15 of the `rst $00` table in ScriptCommand46_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand46_Run_Case0F::
Jump_00F_5F36:: ; address name
    farcall RunScriptSubStep
    ret

; entry 14 of the `rst $00` table in ScriptCommand46_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptSubStep, wScriptParam0
; points at: wScriptStep
ScriptCommand46_Run_Case0E::
Jump_00F_5F3D:: ; address name
    xor a, a
    ld [wScriptSubStep], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in ScriptCommand46_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrLo
; points at: wScriptStep
ScriptCommand46_Run_Case0C::
Jump_00F_5F4A:: ; address name
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, $03A1
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 11 of the `rst $00` table in ScriptCommand46_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: hPlayerFacing
; points at: wScriptStep, hPlayerX
ScriptCommand46_Run_Case0B::
Jump_00F_5F65:: ; address name
    ldh a, [hPlayerX]
    cp a, $40
    jr nz, Jump_00F_5F70
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_5F70::
    jr nc, Jump_00F_5F80
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank0F
    ld a, $01
    ldh [hPlayerFacing], a
    ld hl, hPlayerX
    inc [hl]
    ret

Jump_00F_5F80::
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank0F
    ld a, $03
    ldh [hPlayerFacing], a
    ld hl, hPlayerX
    dec [hl]
    ret

; entry 10 of the `rst $00` table in ScriptCommand46_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo
; points at: hPlayerStateFlags, wScriptStep
ScriptCommand46_Run_Case0A::
Jump_00F_5F8E:: ; address name
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $00
    ld [wStepTarget], a
    ld a, $A0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B0F
    farcall PlayMapMusic
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in ScriptCommand46_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand46_Run_Case09::
Jump_00F_5FB9:: ; address name
    ld de, wObject2 + $C
    call ScriptStepDeltaThenNextStep
    ret

; entry 7 of the `rst $00` table in ScriptCommand46_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wObject2
; points at: wScriptStep
ScriptCommand46_Run_Case07::
Jump_00F_5FC0:: ; address name
    ld a, $02
    ld [wObject2 + $7], a
    ld hl, wObject2 + $D
    call ClearBit2AtHL_Bank0F
    ld hl, $03A0
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand46_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wObject2
; points at: wScriptStep
ScriptCommand46_Run_Case04::
Jump_00F_5FD6:: ; address name
    ld b, $4B
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $01
    ld [wObject2 + $7], a
    ld hl, wObject2 + $D
    call ClearBit1AtHL_Bank0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in ScriptCommand46_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand46_Run_Case03::
Jump_00F_5FEC:: ; address name
    ld hl, wObject2 + $D
    call SetBit2AtHL_B0F
    ld b, $1E
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wObject2 + $D
    call SetBit1AtHL_Bank0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand46_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wObject2
; points at: wScriptStep
ScriptCommand46_Run_Case02::
Jump_00F_6003:: ; address name
    ld b, $4B
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $03
    ld [wObject2 + $7], a
    ld hl, wObject2 + $D
    call ClearBit1AtHL_Bank0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand46_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo, wScriptParam0
; writes: wObject2, wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: wScriptStep
ScriptCommand46_Run_Case01::
Jump_00F_6019:: ; address name
    ld hl, wObject2 + $D
    call SetBit2AtHL_B0F
    ld a, [wFrameCounterLo]
    srl a
    srl a
    srl a
    and a, $03
    ld [wObject2 + $7], a
    ld de, wObject2 + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and a, $01
    jr nz, Jump_00F_6049
    ld hl, wObject2 + $B
    inc [hl]

Jump_00F_6049::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    xor a, a
    ld [wObject2 + $7], a
    ld hl, wObject2 + $D
    call SetBit1AtHL_Bank0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand46_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wScriptParam0
; points at: wScriptParam0, wScriptStep
ScriptCommand46_Run_Case00::
Jump_00F_6066:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_608E
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $01
    ld [wStepTarget], a
    ld a, $70
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    call ScriptCommand46_Run_Case00_Sub01
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_608E::
    dec a
    jr nz, Jump_00F_60B3
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    call ScriptCommand46_Run_Case00_Sub01
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_60B3::
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $01
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    call ScriptCommand46_Run_Case00_Sub01
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; only called from ScriptCommand46_Run_Case00 (E-0047)
; 3 call sites from 1 routine (e.g. ScriptCommand46_Run_Case00)
; reads: wFrameCounterLo
; writes: wObject2
ScriptCommand46_Run_Case00_Sub01::
Func_00F_60D9:: ; address name
    ld a, [wFrameCounterLo]
    srl a
    srl a
    and a, $03
    ld [wObject2 + $7], a
    ret

; implements script command type 41; reached through ScriptCommand41 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand41)
; reads: wScriptStep
ScriptCommand41_Run::
Func_00F_60E6:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand41_Run_Case00
    dw ScriptCommand41_Run_Case01
    dw ScriptCommand41_Run_Case02
    dw ScriptCommand41_Run_Case03
    dw ScriptCommand41_Run_Case04
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand41_Run_Case06
    dw ScriptCommand41_Run_Case07
    dw ScriptCommand41_Run_Case08
    dw ScriptCommand41_Run_Case09

; entry 9 of the `rst $00` table in ScriptCommand41_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wObject5
; writes: wObject5, wObject2, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, hTemp5, ...
ScriptCommand41_Run_Case09::
Jump_00F_60FE:: ; address name
    ld a, [wObject5 + $5]
    inc a
    inc a
    ld [wObject5 + $5], a
    cp a, $10
    ret nz
    ld a, $72
    call QueueSoundEffect
    ld a, $52
    ld [wObject2 + $2], a
    ldh [hTemp0], a
    xor a, a
    ldh [hTemp1], a
    ld a, $01
    ldh [hTemp2], a
    ld a, $07
    ldh [hTemp3], a
    ld hl, vTiles0 + $700
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 8 of the `rst $00` table in ScriptCommand41_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand41_Run_Case08::
Jump_00F_613A:: ; address name
    ld b, $0F
    call ScriptStepShakeScreen
    ret

; entry 7 of the `rst $00` table in ScriptCommand41_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlots
ScriptCommand41_Run_Case07::
Jump_00F_6140:: ; address name
    ld a, $E0
    ld [wSpriteSlots + $B], a
    farcall ScriptStepFlashScreenNegative
    ret

; entry 6 of the `rst $00` table in ScriptCommand41_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerY, wIsCGB
; writes: wScriptParam0, hPlayerY, wFollowerRecords, hTemp0
; points at: hPlayerStateFlags, wBGPaletteBuffer, wBGPaletteCopy, wScriptStep
ScriptCommand41_Run_Case06::
Jump_00F_614C:: ; address name
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B0F
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    ret nz
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $C], a
    cp a, $40
    ret nz
    ld a, $09
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_00F_6189
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes

Jump_00F_6189::
    ld a, $7A
    call QueueSoundEffect
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand41_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand41_Run_Case04::
Jump_00F_619D:: ; address name
    ld hl, $0348
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in ScriptCommand41_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
; points at: wScriptStep
ScriptCommand41_Run_Case03::
Jump_00F_61A8:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $03
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand41_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: hPlayerY, wScriptStep
ScriptCommand41_Run_Case02::
Jump_00F_61BC:: ; address name
    ld b, $3C
    call ScriptStepShakeScreen
    ld hl, hPlayerY
    inc [hl]
    ld de, hPlayerY
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld hl, wFollowerRecords + $2
    inc [hl]
    ld de, wFollowerRecords + $2
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld hl, wFollowerRecords + $7
    inc [hl]
    ld de, wFollowerRecords + $7
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld hl, wFollowerRecords + $C
    inc [hl]
    ld de, wFollowerRecords + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    ld hl, $0346
    call StartMessageHL_B0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand41_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrLo, wStepPtrHi, wStepTarget
; points at: wScriptStep
ScriptCommand41_Run_Case01::
Jump_00F_622E:: ; address name
    ld a, $20
    ld [wStepPtrLo], a
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $66
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand41_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStep
; points at: wScriptStep
ScriptCommand41_Run_Case00::
Jump_00F_6252:: ; address name
    ld de, $0085
    call TestFlagBit
    jr c, Jump_00F_626B
    farcall RedrawColumnsBesideScreen
    ld de, $0085
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_626B::
    ld hl, $0347
    call StartMessageHL_B0F
    ld a, $03
    ld [wScriptStep], a
    ret

; implements script command type 45; reached through ScriptCommand45 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand45)
; reads: wScriptStep
ScriptCommand45_Run::
Func_00F_6277:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand45_Run_Case00
    dw ScriptCommand45_Run_Case01
    dw ScriptCommand45_Run_Case02
    dw ScriptCommand45_Run_Case03

; entry 3 of the `rst $00` table in ScriptCommand45_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0, hTemp1, wSpriteSlots, wScriptStartRequest
ScriptCommand45_Run_Case03::
Jump_00F_6283:: ; address name
    ld a, $00
    ldh [hTemp0], a
    ld a, $40
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a, a
    ret z
    ld a, $E0
    ld [wSpriteSlots + $C], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommand45_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
; points at: wScriptStep
ScriptCommand45_Run_Case02::
Jump_00F_62A0:: ; address name
    ld a, $0C
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand45_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand45_Run_Case01::
Jump_00F_62AF:: ; address name
    ld b, $1E
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld de, $0093
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand45_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2, wScriptParam0
; writes: wSpriteSlots, wObject2
; points at: wScriptStep
ScriptCommand45_Run_Case00::
Jump_00F_62C0:: ; address name
    ld de, $0093
    call TestFlagBit
    jr nc, Jump_00F_62D1
    ld hl, wScriptStep
    inc [hl]
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_62D1::
    ld a, [wObject2 + $7]
    ld [wSpriteSlots + $7], a
    ld a, [wScriptParam0]
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
    ld [wSpriteSlots + $C], a
    ld a, $E0
    ld [wObject2 + $C], a
    jr Jump_00F_630A

Jump_00F_6300::
    ld a, $E0
    ld [wSpriteSlots + $C], a
    ld a, $40
    ld [wObject2 + $C], a

Jump_00F_630A::
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $40
    ld [wSpriteSlots + $C], a
    ld a, $E0
    ld [wObject2 + $C], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 43; reached through ScriptCommand43 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand43)
; reads: wScriptStep
ScriptCommand43_Run::
Func_00F_631F:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand43_Run_Case00
    dw ScriptCommand43_Run_Case01
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand43_Run_Case03
    dw ScriptCommand43_Run_Case04
    dw ScriptCommand43_Run_Case04
    dw ScriptCommand43_Run_Case04
    dw ScriptCommand43_Run_Case07
    dw ScriptCommand43_Run_Case08
    dw ScriptCommand43_Run_Case09
    dw ScriptCommand43_Run_Case0A
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand43_Run_Case0C

; entry 12 of the `rst $00` table in ScriptCommand43_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1
; writes: wStepPtrLo, wStepPtrHi, wStepTarget, wObject1, wScriptStartRequest
ScriptCommand43_Run_Case0C::
Jump_00F_633D:: ; address name
    ld a, [wObject1 + $C]
    cp a, $50
    jr z, Jump_00F_635A
    ld a, $50
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ret

Jump_00F_635A::
    ld a, [wObject1 + $B]
    cp a, $30
    jr z, Jump_00F_6372
    dec a
    dec a
    ld [wObject1 + $B], a
    ld hl, wObject1 + $D
    call SetBit2AtHL_B0F
    ld a, $03
    ld [wObject1 + $7], a
    ret

Jump_00F_6372::
    ld a, $01
    ld [wObject1 + $7], a
    ld hl, wObject1 + $D
    call ClearBit2AtHL_Bank0F
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 10 of the `rst $00` table in ScriptCommand43_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wScriptParam1, wStoryFlags
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0, wStoryFlags, wScreenTileBuffer, wScriptStartRequest
; points at: wScriptStep
ScriptCommand43_Run_Case0A::
Jump_00F_6383:: ; address name
    ld hl, wObject1 + $C
    inc [hl]
    ld de, wObject1 + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld b, $3C
    call ScriptStepShakeScreen
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    ld a, [wScriptParam1]
    cp a, $30
    jr z, Jump_00F_63BD
    ld hl, $0362
    call StartMessageHL_B0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_63BD::
    ld a, [wStoryFlags + $63]
    set 0, a
    ld [wStoryFlags + $63], a
    ld a, $38
    ld [wScreenTileBuffer + $6], a
    ld a, $39
    ld [wScreenTileBuffer + $7], a
    ld a, $3A
    ld [wScreenTileBuffer + $1A], a
    ld a, $3B
    ld [wScreenTileBuffer + $1B], a
    farcall DrawFullScreenBufferAtScroll
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 9 of the `rst $00` table in ScriptCommand43_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived, wScriptParam1
; writes: wStepPtrLo, wStepPtrHi, wStepTarget
; points at: wScriptStep
ScriptCommand43_Run_Case09::
Jump_00F_63E5:: ; address name
    ld a, $00
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $82
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ld a, [wScriptParam1]
    cp a, $30
    jr z, Jump_00F_6410
    ld a, $63
    call QueueSoundEffect
    ret

Jump_00F_6410::
    ld a, $66
    call QueueSoundEffect
    ret

; entry 8 of the `rst $00` table in ScriptCommand43_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject1
; writes: wScriptParam0, wObject1
; points at: wScriptStep
ScriptCommand43_Run_Case08::
Jump_00F_6416:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $07
    ret nz
    ld a, [wObject1 + $C]
    inc a
    ld [wObject1 + $C], a
    cp a, $30
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in ScriptCommand43_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, wObject1, wStepArrived
; writes: wObject1, wStepPtrLo, wStepPtrHi, wStepTarget
; points at: wScriptStep
ScriptCommand43_Run_Case07::
Jump_00F_6433:: ; address name
    ld hl, wObject1 + $D
    call SetBit2AtHL_B0F
    ld a, [wScriptParam1]
    ld c, a
    ld a, [wObject1 + $B]
    cp a, c
    jr z, Jump_00F_644E
    inc a
    inc a
    ld [wObject1 + $B], a
    ld a, $01
    ld [wObject1 + $7], a
    ret

Jump_00F_644E::
    ld a, $20
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $82
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wObject1 + $D
    call ClearBit2AtHL_Bank0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in ScriptCommand43_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, wScriptParam1, wScriptParam0, hPlayerFacing
; writes: hPlayerX, hPlayerFacing, wScriptParam0
; points at: hPlayerStateFlags, wScriptStep
ScriptCommand43_Run_Case03::
Jump_00F_6473:: ; address name
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B0F
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank0F
    ld a, [wScriptParam1]
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
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $10
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ldh [hPlayerFacing], a
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank0F
    ret

; entry 1 of the `rst $00` table in ScriptCommand43_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: wObject5, wScriptParam1
; points at: wScriptStep
ScriptCommand43_Run_Case01::
Jump_00F_64BA:: ; address name
    ld b, $3C
    call StepScriptParam0Counter_Bank0F
    ret nc
    xor a, a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ldh a, [hPlayerX]
    ld [wScriptParam1], a
    ld hl, $0361
    call StartMessageHL_B0F
    ret

; entry 0 of the `rst $00` table in ScriptCommand43_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wObject5
; points at: wScriptStep
ScriptCommand43_Run_Case00::
Jump_00F_64D4:: ; address name
    farcall RedrawColumnsBesideScreen
    ld a, $05
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $30
    ld [wObject5 + $4], a
    ld a, $40
    ld [wObject5 + $5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 42; reached through ScriptCommand42 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand42)
; reads: wScriptStep
ScriptCommand42_Run::
Func_00F_64F3:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand42_Run_Case00
    dw ScriptCommand42_Run_Case01
    dw ScriptCommand42_Run_Case02
    dw ScriptCommand42_Run_Case03
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand42_Run_Case05
    dw ScriptCommand42_Run_Case06
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand42_Run_Case08
    dw ScriptCommand43_Run_Case04
    dw ScriptCommand42_Run_Case0A
    dw ScriptCommand43_Run_Case04
    dw ScriptCommand42_Run_Case0C
    dw ScriptCommand43_Run_Case04
    dw ScriptCommand42_Run_Case0E
    dw ScriptCommand42_Run_Case0F
    dw ScriptCommand42_Run_Case10
    dw ScriptCommand42_Run_Case11

; entry 17 of the `rst $00` table in ScriptCommand42_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, hPlayerY, wFollowerRecords
; writes: hPlayerY, wFollowerRecords, wScriptStartRequest, wStepPtrLo, wStepPtrHi
; points at: wScriptParam1, hPlayerStateFlags
ScriptCommand42_Run_Case11::
Jump_00F_651B:: ; address name
    ld a, [wScriptParam1]
    or a, a
    jr nz, Jump_00F_652D
    ldh a, [hPlayerY]
    cp a, $40
    jr nz, Jump_00F_654D
    ld hl, wScriptParam1
    inc [hl]
    jr Jump_00F_654D

Jump_00F_652D::
    dec a
    jr nz, Jump_00F_654D
    ld de, wSpriteSlots + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld de, wObject1 + $C
    call ScriptApplyStepDeltaAtDE
    jr nc, Jump_00F_654D
    ld hl, wScriptParam1
    inc [hl]

Jump_00F_654D::
    ldh a, [hPlayerY]
    cp a, $40
    jr z, Jump_00F_6557
    inc a
    inc a
    ldh [hPlayerY], a

Jump_00F_6557::
    ld a, [wFollowerRecords + $2]
    cp a, $40
    jr z, Jump_00F_6563
    inc a
    inc a
    ld [wFollowerRecords + $2], a

Jump_00F_6563::
    ld a, [wFollowerRecords + $7]
    cp a, $40
    jr z, Jump_00F_656F
    inc a
    inc a
    ld [wFollowerRecords + $7], a

Jump_00F_656F::
    ld a, [wFollowerRecords + $C]
    inc a
    inc a
    ld [wFollowerRecords + $C], a
    cp a, $40
    ret nz
    ld hl, hPlayerStateFlags
    call ClearBit1AtHL_Bank0F
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 16 of the `rst $00` table in ScriptCommand42_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wFollowerRecords
; points at: hPlayerStateFlags, wScriptStep
ScriptCommand42_Run_Case10::
Jump_00F_6586:: ; address name
    ld hl, hPlayerStateFlags
    call SetBit1AtHL_Bank0F
    ld a, $D0
    ld [wFollowerRecords + $2], a
    ld a, $C0
    ld [wFollowerRecords + $7], a
    ld a, $B0
    ld [wFollowerRecords + $C], a
    ld a, $65
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 15 of the `rst $00` table in ScriptCommand42_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hPlayerX, wFollowerRecords, hFieldDrawFlags, hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, ...
ScriptCommand42_Run_Case0F::
Jump_00F_65A5:: ; address name
    ld a, $E0
    ldh [hPlayerX], a
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $B], a
    xor a, a
    ldh [hFieldDrawFlags], a
    ld a, $4D
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ld a, $01
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $E0
    ld [wWarpDestY], a
    ld a, $01
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; entry 14 of the `rst $00` table in ScriptCommand42_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFieldDrawFlags
; points at: wScriptStep
ScriptCommand42_Run_Case0E::
Jump_00F_65D6:: ; address name
    ld a, $0F
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in ScriptCommand42_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount
; writes: hFieldDrawFlags, wScriptStep
; points at: wScriptStep
ScriptCommand42_Run_Case0C::
Jump_00F_65DF:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, $07
    ldh [hFieldDrawFlags], a
    ld a, [wPartyCount]
    dec a
    dec a
    ret nz
    ld a, $0F
    ld [wScriptStep], a
    ret

; entry 10 of the `rst $00` table in ScriptCommand42_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount
; writes: hFieldDrawFlags, wScriptStep
; points at: wScriptStep
ScriptCommand42_Run_Case0A::
Jump_00F_65F3:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, $03
    ldh [hFieldDrawFlags], a
    ld a, [wPartyCount]
    dec a
    ret nz
    ld a, $0F
    ld [wScriptStep], a
    ret

; entry 8 of the `rst $00` table in ScriptCommand42_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenTileBuffer, hFieldDrawFlags
; points at: wScriptStep
ScriptCommand42_Run_Case08::
Jump_00F_6606:: ; address name
    ld a, $6A
    ld [wScreenTileBuffer + $A8], a
    ld [wScreenTileBuffer + $A9], a
    ld [wScreenTileBuffer + $BC], a
    ld [wScreenTileBuffer + $BD], a
    farcall DrawFullScreenBufferAtScroll
    ld a, $01
    ldh [hFieldDrawFlags], a
    ld a, $65
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommand42_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, wStepArrived
; writes: wStepPtrLo, wStepPtrHi, wStepTarget
; points at: wScriptStep
ScriptCommand42_Run_Case06::
Jump_00F_6628:: ; address name
    ld a, [wObject1 + $B]
    cp a, $40
    jr z, Jump_00F_6645
    ld a, $60
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $81
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ret

Jump_00F_6645::
    ld a, $A0
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $80
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, $035B
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in ScriptCommand42_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wObject1
ScriptCommand42_Run_Case05::
Jump_00F_666A:: ; address name
    ld a, $02
    ld [wObject1 + $7], a
    ld de, wObject1 + $C
    call ScriptStepDeltaThenNextStep
    ret

; entry 3 of the `rst $00` table in ScriptCommand42_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand42_Run_Case03::
Jump_00F_6676:: ; address name
    ld hl, $035A
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 40; reached through ScriptCommand40 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand40)
; reads: wScriptStep
ScriptCommand40_Run::
Func_00F_6681:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand42_Run_Case00
    dw ScriptCommand42_Run_Case01
    dw ScriptCommand42_Run_Case02
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand40_Run_Case04
    dw ScriptCommand42_Run_Case01
    dw ScriptCommand40_Run_Case06
    dw ScriptCommand43_Run_Case04
    dw ScriptCommand43_Run_Case04
    dw ScriptCommand43_Run_Case04
    dw ScriptCommand40_Run_Case0A

; entry 10 of the `rst $00` table in ScriptCommand40_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
ScriptCommand40_Run_Case0A::
Jump_00F_669B:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 6 of the `rst $00` table in ScriptCommand40_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrLo
; points at: wScriptStep
ScriptCommand40_Run_Case06::
Jump_00F_66A1:: ; address name
    ld a, $10
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand40_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived, hPlayerStateFlags
; writes: wStepPtrLo, wFieldActionRequest, wScreenScrollDir, hPlayerStateFlags, hPlayerStepDYLo, hPlayerStepDYHi
; points at: hMapScreenY, hFF80, wScriptStep
ScriptCommand40_Run_Case04::
Jump_00F_66B6:: ; address name
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $80
    ld [wFieldActionRequest], a
    ld a, $08
    ld [wScreenScrollDir], a
    ld hl, hMapScreenY
    inc [hl]
    ldh a, [hPlayerStateFlags]
    or a, $01
    ldh [hPlayerStateFlags], a
    ld hl, $FF80
    ld a, l
    ldh [hPlayerStepDYLo], a
    ld a, h
    ldh [hPlayerStepDYHi], a
    farcall UpdatePlayerMovement
    farcall RunFieldActionRequestActionIfBit7
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand42_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, wStepArrived
; writes: wStepPtrLo, wStepPtrHi, wStepTarget, wObject1
; points at: wScriptStep
ScriptCommand42_Run_Case02::
Jump_00F_66F4:: ; address name
    ld a, [wObject1 + $C]
    cp a, $60
    jr z, Jump_00F_6712
    ld a, $60
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    jr Jump_00F_6735

Jump_00F_6712::
    ld a, [wObject1 + $B]
    cp a, $30
    jr z, Jump_00F_6730
    ld a, $30
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    farcall StepObjectTowardCoord
    jr Jump_00F_6735

Jump_00F_6730::
    ld a, $01
    ld [wObject1 + $7], a

Jump_00F_6735::
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, $0322
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand42_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wFieldActionRequest
; points at: wScriptStep
ScriptCommand42_Run_Case01::
Jump_00F_6750:: ; address name
    farcall UpdatePlayerMovement
    farcall RunFieldActionRequestActionIfBit7
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand42_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived, hPlayerStateFlags
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wFieldActionRequest, wScreenScrollDir, hPlayerStateFlags, hPlayerStepDYLo, hPlayerStepDYHi
; points at: hMapScreenY, wScriptStep
ScriptCommand42_Run_Case00::
Jump_00F_6767:: ; address name
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $E0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $00
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $80
    ld [wFieldActionRequest], a
    ld a, $04
    ld [wScreenScrollDir], a
    ld hl, hMapScreenY
    dec [hl]
    ldh a, [hPlayerStateFlags]
    or a, $01
    ldh [hPlayerStateFlags], a
    ld hl, $0080
    ld a, l
    ldh [hPlayerStepDYLo], a
    ld a, h
    ldh [hPlayerStepDYHi], a
    farcall UpdatePlayerMovement
    farcall RunFieldActionRequestActionIfBit7
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 39 (also 3B); reached through ScriptCommand39 in bank $10 (E-0038)
; 2 call sites from 2 routines (e.g. ScriptCommand39, ScriptCommand3B)
; reads: wScriptStep
ScriptCommand39_Run::
Func_00F_67BA:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand39_Run_Case00
    dw ScriptCommand43_Run_Case04
    dw ScriptCommand43_Run_Case04
    dw ScriptCommand43_Run_Case04
    dw ScriptCommand39_Run_Case04
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand39_Run_Case06
    dw ScriptCommand39_Run_Case07
    dw ScriptCommand39_Run_Case08
    dw ScriptCommand39_Run_Case09
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand39_Run_Case0B
    dw ScriptCommand39_Run_Case0C
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand39_Run_Case0E
    dw ScriptCommand39_Run_Case0F
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand39_Run_Case11
    dw ScriptCommand39_Run_Case12
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand39_Run_Case14
    dw ScriptCommand39_Run_Case15
    dw ScriptCommand39_Run_Case14
    dw ScriptCommand39_Run_Case15
    dw ScriptCommand39_Run_Case14
    dw ScriptCommand39_Run_Case15
    dw ScriptCommand39_Run_Case14
    dw ScriptCommand39_Run_Case15
    dw ScriptCommand39_Run_Case14
    dw ScriptCommand39_Run_Case15
    dw ScriptCommand39_Run_Case1E
    dw ScriptCommand39_Run_Case1F
    dw ScriptCommand39_Run_Case20
    dw ScriptCommand39_Run_Case21
    dw ScriptCommand39_Run_Case22
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand39_Run_Case24
    dw ScriptCommand39_Run_Case25
    dw ScriptCommand39_Run_Case26
    dw ScriptCommand39_Run_Case27
    dw ScriptCommand39_Run_Case28
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand39_Run_Case2A
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand39_Run_Case2C
    dw ScriptCommand39_Run_Case2D
    dw ScriptCommand39_Run_Case2E
    dw ScriptCommand39_Run_Case2F
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand39_Run_Case31

; entry 49 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags
; writes: hTemp0, wStoryFlags, wFarmLevel, wScriptStartRequest
ScriptCommand39_Run_Case31::
Jump_00F_6822:: ; address name
    ld de, $0022
    call SetFlagBit
    ld a, $03
    ldh [hTemp0], a
    farcall MarkKeyEntryKindTemp0Bit6
    ld a, [wStoryFlags + $60]
    set 2, a
    ld [wStoryFlags + $60], a
    ld a, $02
    ld [wFarmLevel], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 47 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wObject5
; writes: wObject5
; points at: wScriptStep
ScriptCommand39_Run_Case2F::
Jump_00F_6845:: ; address name
    ldh a, [hPlayerY]
    ld c, a
    ld a, [wObject5 + $5]
    inc a
    ld [wObject5 + $5], a
    cp a, c
    ret nz
    xor a, a
    ld [wObject5], a
    ld hl, $0DC1
    call StartMessageHL_B0F
    ld de, $001F
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 46 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerFacing, hPlayerX, hPlayerY
; writes: wSpriteSlots, hTemp0, wObject5
; points at: wScriptStep
ScriptCommand39_Run_Case2E::
Jump_00F_6866:: ; address name
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ld [wSpriteSlots + $7], a
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ldh a, [hPlayerX]
    ld [wObject5 + $4], a
    ldh a, [hPlayerY]
    sub a, $20
    ld [wObject5 + $5], a
    ld a, $80
    ld [wObject5], a
    ld a, $85
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 45 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand39_Run_Case2D::
Jump_00F_6894:: ; address name
    farcall RunScriptSubStep_7363
    ret

; entry 44 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerStateFlags
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind, wScreenTriggerCount, wObject5, ...
; points at: hPlayerStateFlags
ScriptCommand39_Run_Case2C::
Jump_00F_689B:: ; address name
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wWarpDestX], a
    ld a, $30
    ld [wWarpDestY], a
    ld a, $01
    ld [wFieldTransitionKind], a
    xor a, a
    ld [wScreenTriggerCount], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $50
    ld [wObject5 + $4], a
    ld a, $30
    ld [wObject5 + $5], a
    ld hl, $02A7
    call StartMessageHL_B0F
    xor a, a
    ld [wScriptSubStep], a
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank0F
    ldh a, [hPlayerStateFlags]
    and a, $BF
    ldh [hPlayerStateFlags], a
    ret

; entry 42 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand39_Run_Case2A::
Jump_00F_68E0:: ; address name
    ld hl, $0873
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 40 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
; points at: wScriptStep
ScriptCommand39_Run_Case28::
Jump_00F_68EB:: ; address name
    ld hl, wObject5 + $5
    inc [hl]
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE
    ret nc
    xor a, a
    ld [wObject5], a
    ld hl, $0872
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 39 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand39_Run_Case27::
Jump_00F_6905:: ; address name
    ld b, $1E
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 38 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand39_Run_Case26::
Jump_00F_6910:: ; address name
    ld hl, wObject5 + $4
    inc [hl]
    ld hl, wObject5 + $5
    dec [hl]
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 37 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrLo
; points at: wScriptStep
ScriptCommand39_Run_Case25::
Jump_00F_6924:: ; address name
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld de, $005F
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 36 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wStepArrived
; writes: wStepTarget, wStepPtrLo, wStepPtrHi, wScriptParam0, wSpriteSlotCount
; points at: wScriptStep
ScriptCommand39_Run_Case24::
Jump_00F_693F:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_6951
    ld a, $83
    ld [wStepTarget], a
    ld a, $70
    ld [wStepPtrLo], a
    jr Jump_00F_6979

Jump_00F_6951::
    dec a
    jr nz, Jump_00F_6960
    ld a, $82
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a
    jr Jump_00F_6979

Jump_00F_6960::
    dec a
    jr nz, Jump_00F_696F
    ld a, $83
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    jr Jump_00F_6979

Jump_00F_696F::
    ld a, $82
    ld [wStepTarget], a
    ld a, $00
    ld [wStepPtrLo], a

Jump_00F_6979::
    ld a, $00
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $04
    ret nz
    xor a, a
    ld [wSpriteSlotCount], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    farcall PlayMapMusic
    ret

; entry 34 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wSpriteSlots
; points at: wScriptStep
ScriptCommand39_Run_Case22::
Jump_00F_69A6:: ; address name
    ld a, [wScriptParam0]
    srl a
    srl a
    srl a
    and a, $03
    ld [wSpriteSlots + $7], a
    ld b, $38
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld de, FieldSpriteGfx03
    ld b, $7D
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $03
    ld [wSpriteSlots + $2], a
    ld hl, $0871
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 33 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wStepArrived
; writes: wStepPtrLo, wScriptParam0
; points at: wScriptParam0, wScriptStep
ScriptCommand39_Run_Case21::
Jump_00F_69D5:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_69F0
    ld a, $10
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_69F0::
    dec a
    jr nz, Jump_00F_6A08
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerRightTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_6A08::
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 32 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wObject5
; writes: wObject5, wSpriteSlotCount
; points at: wScriptStep
ScriptCommand39_Run_Case20::
Jump_00F_6A21:: ; address name
    ld a, [wObject5 + $5]
    dec a
    dec a
    ld [wObject5 + $5], a
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld a, $65
    call QueueSoundEffect
    ld a, $01
    ld [wSpriteSlotCount], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 31 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0, wObject1, wObject2, wObject5
; points at: wScriptStep
ScriptCommand39_Run_Case1F::
Jump_00F_6A3F:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    push af
    bit 4, a
    jr z, Jump_00F_6A4F
    ld a, $01
    jr Jump_00F_6A51

Jump_00F_6A4F::
    ld a, $03

Jump_00F_6A51::
    ld [wObject1 + $7], a
    inc a
    inc a
    and a, $03
    ld [wObject2 + $7], a
    pop af
    cp a, $78
    ret nz
    ld a, $80
    ld [wObject5], a
    ld a, $65
    call QueueSoundEffect
    ld a, $E0
    ld [wObject1 + $B], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 30 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags, hPlayerX, hPlayerY
; writes: wStoryFlags, wWarpDestX, wWarpDestY, wFieldTransitionKind
ScriptCommand39_Run_Case1E::
Jump_00F_6A77:: ; address name
    ld a, [wStoryFlags + $62]
    set 3, a
    ld [wStoryFlags + $62], a
    ld de, $007F
    call SetFlagBit
    ldh a, [hPlayerX]
    ld [wWarpDestX], a
    ldh a, [hPlayerY]
    ld [wWarpDestY], a
    ld a, $00
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; entry 21 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand39_Run_Case15::
Jump_00F_6A9B:: ; address name
    ld b, $0F
    call ScriptStepShakeScreen
    ret

; entry 20 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand39_Run_Case14::
Jump_00F_6AA1:: ; address name
    ld de, wObject2 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld a, $63
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 18 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand39_Run_Case12::
Jump_00F_6AB2:: ; address name
    ld de, wObject2 + $C
    ld hl, $0870
    call ScriptStepDeltaThenMessage
    ret

; entry 17 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wObject5
; writes: wObject5
; points at: wScriptStep
ScriptCommand39_Run_Case11::
Jump_00F_6ABC:: ; address name
    ld a, [wObject5 + $5]
    inc a
    ld [wObject5 + $5], a
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE
    ret nc
    xor a, a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 15 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand39_Run_Case0F::
Jump_00F_6AD3:: ; address name
    ld de, wSpriteSlots + $C
    ld hl, $086F
    call ScriptStepDeltaThenMessage
    ret

; entry 14 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlots, hTemp0, hTemp1, hTemp2, hTemp3, hTemp4, hTemp5, wObject1, ...
; points at: wScriptStep
ScriptCommand39_Run_Case0E::
Jump_00F_6ADD:: ; address name
    xor a, a
    ld [wSpriteSlots + $1], a
    ld a, $E3
    ld [wSpriteSlots + $2], a
    ldh [hTemp0], a
    xor a, a
    ldh [hTemp1], a
    ld a, $00
    ldh [hTemp2], a
    ld a, $05
    ldh [hTemp3], a
    ld hl, vTiles0 + $500
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    farcall DecompressGraphicsTemp0ToTemp4
    xor a, a
    ld [wObject1 + $1], a
    ld a, $D6
    ld [wObject1 + $2], a
    ldh [hTemp0], a
    xor a, a
    ldh [hTemp1], a
    ld a, $00
    ldh [hTemp2], a
    ld a, $06
    ldh [hTemp3], a
    ld hl, vTiles0 + $600
    ld a, l
    ldh [hTemp4], a
    ld a, h
    ldh [hTemp5], a
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wObject5
; writes: wObject5
; points at: wScriptStep
ScriptCommand39_Run_Case0C::
Jump_00F_6B31:: ; address name
    ld a, [wObject5 + $5]
    dec a
    dec a
    ld [wObject5 + $5], a
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $086E
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 11 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, hTemp0, wObject5
; points at: wScriptStep
ScriptCommand39_Run_Case0B::
Jump_00F_6B4B:: ; address name
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $00
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $00
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $08
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + $4], a
    ld a, $60
    ld a, a
    ld [wObject5 + $5], a
    ld a, $80
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand39_Run_Case09::
Jump_00F_6B99:: ; address name
    ld de, wObject2 + $C
    ld hl, $086D
    call ScriptStepDeltaThenMessage
    ret

; entry 8 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2
; writes: wObject2
; points at: wScriptStep
ScriptCommand39_Run_Case08::
Jump_00F_6BA3:: ; address name
    ld a, [wObject2 + $B]
    cp a, $80
    jr z, Jump_00F_6BAF
    inc a
    inc a
    ld [wObject2 + $B], a

Jump_00F_6BAF::
    ld b, $3C
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, wScriptParam0, wObject1
; writes: wScriptParam0, wObject1, wScriptParam1
; points at: wScriptStep
ScriptCommand39_Run_Case07::
Jump_00F_6BBA:: ; address name
    ld a, [wScriptParam1]
    or a, a
    jr nz, Jump_00F_6BDA
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    ret nz
    ld a, [wObject1 + $B]
    dec a
    ld [wObject1 + $B], a
    cp a, $30
    ret nz
    ld a, $01
    ld [wScriptParam1], a
    ret

Jump_00F_6BDA::
    ld a, [wObject1 + $B]
    inc a
    inc a
    ld [wObject1 + $B], a
    cp a, $40
    ret nz
    ld a, $63
    call QueueSoundEffect
    xor a, a
    ld [wScriptParam0], a
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject1
; writes: wObject1, wObject2, wScriptParam0
; points at: wScriptParam0, wScriptStep
ScriptCommand39_Run_Case06::
Jump_00F_6BF6:: ; address name
    ld hl, wObject1 + $D
    call SetBit2AtHL_B0F
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_6C17
    ld a, $03
    ld [wObject1 + $7], a
    ld a, [wObject1 + $B]
    dec a
    dec a
    ld [wObject1 + $B], a
    cp a, $40
    ret nz
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_6C17::
    dec a
    jr nz, Jump_00F_6C2F
    ld a, $00
    ld [wObject1 + $7], a
    ld a, [wObject1 + $C]
    inc a
    inc a
    ld [wObject1 + $C], a
    cp a, $50
    ret nz
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_6C2F::
    dec a
    jr nz, Jump_00F_6C47
    ld a, $01
    ld [wObject1 + $7], a
    ld a, [wObject1 + $B]
    inc a
    inc a
    ld [wObject1 + $B], a
    cp a, $60
    ret nz
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_6C47::
    dec a
    jr nz, Jump_00F_6C5F
    ld a, $02
    ld [wObject1 + $7], a
    ld a, [wObject1 + $C]
    dec a
    dec a
    ld [wObject1 + $C], a
    cp a, $30
    ret nz
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_6C5F::
    dec a
    jr nz, Jump_00F_6C77
    ld a, $03
    ld [wObject1 + $7], a
    ld a, [wObject1 + $B]
    dec a
    dec a
    ld [wObject1 + $B], a
    cp a, $40
    ret nz
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_6C77::
    ld a, $00
    ld [wObject1 + $7], a
    ld a, [wObject1 + $C]
    inc a
    inc a
    ld [wObject1 + $C], a
    cp a, $40
    ret nz
    ld a, $01
    ld [wObject1 + $7], a
    ld hl, wObject1 + $D
    call ClearBit2AtHL_Bank0F
    ld de, FieldSpriteGfx45
    ld b, $7D
    ld hl, vTiles0 + $700
    call DecompressToVRAM
    ld a, $45
    ld [wObject2 + $2], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo
; points at: wScriptStep
ScriptCommand39_Run_Case04::
Jump_00F_6CAB:: ; address name
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $80
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $80
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $80
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    farcall RedrawColumnsBesideScreen
    ld hl, $086C
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand43_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand43_Run_Case04::
Jump_00F_6D00:: ; address name
    farcall ScriptStepMoveFollowersToLeader
    ret

; entry 0 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, wStepArrived
; writes: wScriptStep, wStepPtrLo, hPlayerFacing
; points at: wScriptStep
ScriptCommand39_Run_Case00::
Jump_00F_6D07:: ; address name
    ldh a, [hPlayerX]
    cp a, $40
    jr nz, Jump_00F_6D13
    ld a, $04
    ld [wScriptStep], a
    ret

Jump_00F_6D13::
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ldh [hPlayerFacing], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 38; reached through ScriptCommand38 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand38)
; reads: wScriptStep
ScriptCommand38_Run::
Func_00F_6D2B:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand38_Run_Case00
    dw ScriptCommand38_Run_Case00
    dw ScriptCommand38_Run_Case00
    dw ScriptCommand38_Run_Case03
    dw ScriptCommand38_Run_Case04
    dw ScriptCommand38_Run_Case05
    dw ScriptCommand38_Run_Case06
    dw ScriptCommand38_Run_Case03
    dw ScriptCommand38_Run_Case08
    dw ScriptCommand38_Run_Case09
    dw ScriptCommand38_Run_Case0A
    dw ScriptCommand38_Run_Case0B
    dw ScriptCommand38_Run_Case0C

; entry 12 of the `rst $00` table in ScriptCommand38_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand38_Run_Case0C::
Jump_00F_6D49:: ; address name
    call ScriptCommand38_Run_Shared01
    ret

; only called from routines of ScriptCommand38_Run (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommand38_Run_Case0C, ScriptCommand38_Run_Case0B)
; reads: wScriptParam0, wObject5
; writes: wScriptParam0, wObject5, wScriptStartRequest
ScriptCommand38_Run_Shared01::
Func_00F_6D4D:: ; address name
    ld hl, wObject5 + $4
    inc [hl]
    ld a, [wScriptParam0]
    inc a
    and a, $07
    ld [wScriptParam0], a
    ld hl, $6D78
    add_a_to_hl
    ld a, [hl]
    ld [wObject5 + $5], a
    ld a, [wObject5 + $4]
    cp a, $A0
    ret nz
    ld de, $007E
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret
    db $40, $3F, $40, $3F, $40, $3E, $40, $41

; entry 11 of the `rst $00` table in ScriptCommand38_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wSpriteSlotCount
; points at: wScriptStep
ScriptCommand38_Run_Case0B::
Jump_00F_6D80:: ; address name
    call ScriptCommand38_Run_Shared01
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $81
    ld [wStepTarget], a
    ld a, $A0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $81
    ld [wStepTarget], a
    ld a, $A0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $81
    ld [wStepTarget], a
    ld a, $A0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wObject2 + $B]
    cp a, $A0
    ret nz
    xor a, a
    ld [wSpriteSlotCount], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in ScriptCommand38_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo, hScrollX
; writes: wStepPtrLo, wStepPtrHi, hScrollX, hFieldDrawFlags
; points at: wScriptStep
ScriptCommand38_Run_Case0A::
Jump_00F_6DD1:: ; address name
    ld de, wSpriteSlots + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld de, wObject1 + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld de, wObject2 + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
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
    call StepScriptParam0Counter_Bank0F
    ret nc
    ldh a, [hScrollX]
    add a, $07
    and a, $F8
    ldh [hScrollX], a
    ld a, $7D
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    xor a, a
    ldh [hFieldDrawFlags], a
    ret

; entry 9 of the `rst $00` table in ScriptCommand38_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wObject5
; writes: wObject5, wScriptParam0, hFieldDrawFlags
; points at: wScriptStep
ScriptCommand38_Run_Case09::
Jump_00F_6E31:: ; address name
    ld a, [wObject5 + $5]
    inc a
    inc a
    ld [wObject5 + $5], a
    cp a, $40
    ret nz
    farcall RedrawColumnsBesideScreen
    ld a, $66
    call QueueSoundEffect
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld a, $0E
    ldh [hFieldDrawFlags], a
    ret

; entry 8 of the `rst $00` table in ScriptCommand38_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots
; writes: wObject2, hTemp0, wObject5
; points at: wScriptStep
ScriptCommand38_Run_Case08::
Jump_00F_6E54:: ; address name
    ld b, $03
    ld hl, wSpriteSlots + $C

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
    ld a, [wSpriteSlots + $B]
    cp a, $40
    ret nz
    ld a, $03
    ld [wObject2 + $7], a
    ld hl, wSpriteSlots + $D
    call ClearBit2AtHL_Bank0F
    ld hl, wObject1 + $D
    call ClearBit2AtHL_Bank0F
    ld hl, wObject2 + $D
    call ClearBit2AtHL_Bank0F
    ld a, $07
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $80
    ld [wObject5], a
    ld a, $65
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in ScriptCommand38_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand38_Run_Case03::
Jump_00F_6EB0:: ; address name
    ld b, $3C
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wSpriteSlots + $D
    call SetBit2AtHL_B0F
    ld hl, wObject1 + $D
    call SetBit2AtHL_B0F
    ld hl, wObject2 + $D
    call SetBit2AtHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommand38_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wScriptParam0
; writes: wScriptParam0
; points at: hPlayerStateFlags, wScriptStep
ScriptCommand38_Run_Case06::
Jump_00F_6ECD:: ; address name
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank0F
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank0F
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $1E
    ret nz
    ld hl, hPlayerStateFlags
    call ClearBit1AtHL_Bank0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in ScriptCommand38_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: hPlayerY
; points at: wScriptStep
ScriptCommand38_Run_Case05::
Jump_00F_6EF0:: ; address name
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank0F
    ldh a, [hPlayerY]
    dec a
    ldh [hPlayerY], a
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank0F
    ldh a, [hPlayerY]
    dec a
    ldh [hPlayerY], a
    cp a, $30
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand38_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2, wObject1, wSpriteSlots
; writes: hPlayerFacing, wObject2, wObject1, wSpriteSlots
; points at: hPlayerStateFlags, wScriptStep
ScriptCommand38_Run_Case04::
Jump_00F_6F0C:: ; address name
    xor a, a
    ldh [hPlayerFacing], a
    ld a, [wObject2 + $C]
    dec a
    dec a
    ld [wObject2 + $C], a
    ld a, [wObject1 + $C]
    dec a
    dec a
    ld [wObject1 + $C], a
    ld a, [wSpriteSlots + $C]
    dec a
    dec a
    ld [wSpriteSlots + $C], a
    cp a, $70
    ret nz
    ld hl, wSpriteSlots + $D
    call ClearBit2AtHL_Bank0F
    ld hl, wObject1 + $D
    call ClearBit2AtHL_Bank0F
    ld hl, wObject2 + $D
    call ClearBit2AtHL_Bank0F
    ld hl, hPlayerStateFlags
    call SetBit1AtHL_Bank0F
    ld a, $63
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand38_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand38_Run_Case00::
Jump_00F_6F4C:: ; address name
    farcall ScriptStepMoveFollowersToLeader
    ld hl, wSpriteSlots + $D
    call SetBit2AtHL_B0F
    ld hl, wObject1 + $D
    call SetBit2AtHL_B0F
    ld hl, wObject2 + $D
    call SetBit2AtHL_B0F
    ret

; implements script command type 37; reached through ScriptCommand37 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand37)
; reads: wScriptStep
ScriptCommand37_Run::
Func_00F_6F65:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand37_Run_Case00
    dw ScriptCommand37_Run_Case01
    dw ScriptCommand37_Run_Case02
    dw ScriptCommand37_Run_Case03

; entry 3 of the `rst $00` table in ScriptCommand37_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0, wSpriteSlots, wObject2, wObject1, wScriptStartRequest
ScriptCommand37_Run_Case03::
Jump_00F_6F71:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    push af
    bit 4, a
    jr z, Jump_00F_6F81
    ld a, $01
    jr Jump_00F_6F83

Jump_00F_6F81::
    ld a, $03

Jump_00F_6F83::
    ld [wSpriteSlots + $7], a
    ld [wObject2 + $7], a
    inc a
    inc a
    and a, $03
    ld [wObject1 + $7], a
    pop af
    cp a, $78
    ret nz
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommand37_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0
; points at: wScriptStep
ScriptCommand37_Run_Case02::
Jump_00F_6F9A:: ; address name
    ld hl, wSpriteSlots + $D
    call SetBit2AtHL_B0F
    ld hl, wObject1 + $D
    call SetBit2AtHL_B0F
    ld hl, wObject2 + $D
    call SetBit2AtHL_B0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand37_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo, hScrollX, wStoryFlags, hPlayerX, hPlayerY
; writes: hScrollX, wStoryFlags, wWarpDestX, wWarpDestY, wFieldTransitionKind, wFieldReturnPhase
ScriptCommand37_Run_Case01::
Jump_00F_6FB5:: ; address name
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
    call StepScriptParam0Counter_Bank0F
    ret nc
    ldh a, [hScrollX]
    add a, $07
    and a, $F8
    ldh [hScrollX], a
    ld de, $007D
    call SetFlagBit
    ld a, [wStoryFlags + $62]
    set 2, a
    ld [wStoryFlags + $62], a
    ldh a, [hPlayerX]
    ld [wWarpDestX], a
    ldh a, [hPlayerY]
    ld [wWarpDestY], a
    ld a, $00
    ld [wFieldTransitionKind], a
    xor a, a
    ld [wFieldReturnPhase], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $00
    call QueueSoundEffect
    ret

; entry 0 of the `rst $00` table in ScriptCommand37_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots
; points at: wScriptStep
ScriptCommand37_Run_Case00::
Jump_00F_7002:: ; address name
    ld hl, wSpriteSlots + $D
    call SetBit2AtHL_B0F
    ld hl, wObject1 + $D
    call SetBit2AtHL_B0F
    ld hl, wObject2 + $D
    call SetBit2AtHL_B0F
    ld b, $03
    ld hl, wSpriteSlots + $B

Jump_00F_7019::
    ld a, [hl]
    inc a
    inc a
    ld [hl], a
    ld a, $10
    add_a_to_hl
    dec b
    jr nz, Jump_00F_7019
    ld a, [wSpriteSlots + $B]
    cp a, $60
    ret nz
    ld hl, wSpriteSlots + $D
    call ClearBit2AtHL_Bank0F
    ld hl, wObject1 + $D
    call ClearBit2AtHL_Bank0F
    ld hl, wObject2 + $D
    call ClearBit2AtHL_Bank0F
    ld a, $7D
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 36; reached through ScriptCommand36 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand36)
; reads: wScriptStep
ScriptCommand36_Run::
Func_00F_7049:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand36_Run_Case00
    dw ScriptCommand36_Run_Case01

; entry 0 of the `rst $00` table in ScriptCommand36_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0
; points at: wScriptStep
ScriptCommand36_Run_Case00::
Jump_00F_7051:: ; address name
    ld hl, wSpriteSlots + $D
    call SetBit2AtHL_B0F
    ld hl, wObject1 + $D
    call SetBit2AtHL_B0F
    ld hl, wObject2 + $D
    call SetBit2AtHL_B0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand36_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2
; writes: wSpriteSlotCount, wScriptStartRequest
ScriptCommand36_Run_Case01::
Jump_00F_706C:: ; address name
    ld b, $03
    ld hl, wSpriteSlots + $C

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
    ld a, [wObject2 + $C]
    cp a, $E0
    ret nz
    xor a, a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 32; reached through ScriptCommand32 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand32)
; reads: wScriptStep
ScriptCommand32_Run::
Func_00F_7093:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand32_Run_Case00

; entry 0 of the `rst $00` table in ScriptCommand32_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0, hTemp1, wSpriteSlotCount, wScriptStartRequest, wStepPtrLo
ScriptCommand32_Run_Case00::
Jump_00F_7099:: ; address name
    ld de, $0075
    call TestFlagBit
    jr c, Jump_00F_70BD
    ld a, $00
    ldh [hTemp0], a
    ld a, $20
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a, a
    ret z
    xor a, a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_00F_70BD::
    ld a, $00
    ldh [hTemp0], a
    ld a, $40
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a, a
    ret z
    ld de, $009B
    call TestFlagBit
    jr nc, Jump_00F_70E2
    ld a, $33
    ld [wStepPtrLo], a
    farcall AppendItemWC928ToInventory

Jump_00F_70E2::
    xor a, a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 29; reached through ScriptCommand29 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand29)
; reads: wScriptStep
ScriptCommand29_Run::
Func_00F_70EC:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand29_Run_Case00
    dw ScriptCommand29_Run_Case01
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand29_Run_Case03
    dw ScriptCommand29_Run_Case04
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand29_Run_Case06
    dw ScriptCommand29_Run_Case07
    dw ScriptCommand29_Run_Case08
    dw ScriptCommand29_Run_Case09

; entry 9 of the `rst $00` table in ScriptCommand29_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, wScriptParam0, hPlayerStateFlags
; writes: wScriptParam0, hPlayerStateFlags, wScriptStartRequest
ScriptCommand29_Run_Case09::
Jump_00F_7104:: ; address name
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank0F
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank0F
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $1E
    ret nz
    ldh a, [hPlayerStateFlags]
    and a, $FD
    ldh [hPlayerStateFlags], a
    ld de, $0064
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 8 of the `rst $00` table in ScriptCommand29_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: hPlayerX, wScriptParam0
; points at: wScriptStep
ScriptCommand29_Run_Case08::
Jump_00F_712A:: ; address name
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank0F
    ldh a, [hPlayerX]
    inc a
    ldh [hPlayerX], a
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank0F
    ldh a, [hPlayerX]
    inc a
    ldh [hPlayerX], a
    cp a, $70
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in ScriptCommand29_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, wScriptParam0, wSpriteSlots, wStepArrived, hPlayerStateFlags
; writes: wScriptParam0, wSpriteSlots, wScriptParam1, wStepPtrHi, wStepTarget, wStepPtrLo, hPlayerStateFlags
; points at: wScriptStep
ScriptCommand29_Run_Case07::
Jump_00F_714A:: ; address name
    ld a, [wScriptParam1]
    or a, a
    jr nz, Jump_00F_716A
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    ret nz
    ld a, [wSpriteSlots + $B]
    dec a
    ld [wSpriteSlots + $B], a
    cp a, $20
    ret nz
    ld a, $01
    ld [wScriptParam1], a
    ret

Jump_00F_716A::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $81
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ldh a, [hPlayerStateFlags]
    or a, $02
    ldh [hPlayerStateFlags], a
    ld a, $63
    call QueueSoundEffect
    xor a, a
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommand29_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wSpriteSlots, hPlayerFacing
; points at: wScriptStep
ScriptCommand29_Run_Case06::
Jump_00F_7198:: ; address name
    ld a, [wSpriteSlots + $B]
    cp a, $30
    jr z, Jump_00F_71B5
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ret

Jump_00F_71B5::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $00
    ld [wStepTarget], a
    ld a, $70
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $01
    ld [wSpriteSlots + $7], a
    ld a, $03
    ldh [hPlayerFacing], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand29_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wObject1, wObject2, wStepPtrHi, wStepTarget, wStepPtrLo
; points at: wScriptStep
ScriptCommand29_Run_Case04::
Jump_00F_71DD:: ; address name
    xor a, a
    ld [wObject1 + $7], a
    ld [wObject2 + $7], a
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $00
    ld [wStepTarget], a
    ld a, $60
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, $0833
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in ScriptCommand29_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand29_Run_Case03::
Jump_00F_7209:: ; address name
    ld de, wSpriteSlots + $C
    call ScriptStepDeltaThenNextStep
    ret

; entry 1 of the `rst $00` table in ScriptCommand29_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wObject1
; points at: wScriptStep
ScriptCommand29_Run_Case01::
Jump_00F_7210:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $01
    ld [wObject1 + $7], a
    ld hl, $0832
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand29_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots
; writes: wObject2
; points at: wScriptStep
ScriptCommand29_Run_Case00::
Jump_00F_7225:: ; address name
    ld hl, wSpriteSlots + $D
    call SetBit2AtHL_B0F
    ld hl, wObject1 + $D
    call SetBit2AtHL_B0F
    ld hl, wObject2 + $D
    call SetBit2AtHL_B0F
    ld hl, wSpriteSlots + $C
    ld b, $03

Jump_00F_723C::
    ld a, [hl]
    inc a
    ld [hl], a
    ld a, $10
    add_a_to_hl
    dec b
    jr nz, Jump_00F_723C
    ld a, [wSpriteSlots + $C]
    cp a, $40
    ret nz
    ld hl, wSpriteSlots + $D
    call ClearBit2AtHL_Bank0F
    ld hl, wObject1 + $D
    call ClearBit2AtHL_Bank0F
    ld hl, wObject2 + $D
    call ClearBit2AtHL_Bank0F
    ld a, $03
    ld [wObject2 + $7], a
    ld hl, $0831
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 28; reached through ScriptCommand28 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand28)
; reads: wScriptStep
ScriptCommand28_Run::
Func_00F_7271:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand28_Run_Case00
    dw ScriptCommand28_Run_Case01
    dw ScriptCommand28_Run_Case02

; entry 0 of the `rst $00` table in ScriptCommand28_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand28_Run_Case00::
Jump_00F_727B:: ; address name
    farcall RedrawColumnsBesideScreen
    ld a, $7D
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand28_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand28_Run_Case01::
Jump_00F_728B:: ; address name
    ld b, $78
    call ScriptStepShakeScreen
    ret

; entry 2 of the `rst $00` table in ScriptCommand28_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
ScriptCommand28_Run_Case02::
Jump_00F_7291:: ; address name
    ld a, $00
    call QueueSoundEffect
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from ScriptCommand35_Run_Case02 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommand35_Run_Case02)
; reads: wStepPtrLo, wFrameCounterLo, hScrollX, hScrollXHi
; writes: hScrollX, hScrollXHi
; points at: wScriptStep
ScriptCommand35_Run_Case02_Sub01::
Func_00F_729C:: ; address name
    ld a, [wStepPtrLo]
    ld b, a

; shakes hScrollX left and right with the frame counter until the wC921 counter expires, then resets the scroll and advances wScriptStep (E-0125)
; 7 call sites from 7 routines (e.g. ScriptCommand5E_Run_Case0F, ScriptCommand58_Run_Case01, ScriptCommand43_Run_Case0A, ScriptCommand41_Run_Case08, ...)
; reads: wFrameCounterLo, hScrollX, hScrollXHi
; writes: hScrollX, hScrollXHi
; points at: wScriptStep
ScriptStepShakeScreen::
Func_00F_72A0:: ; address name
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
    call StepScriptParam0Counter_Bank0F
    ret nc
    xor a, a
    ldh [hScrollX], a
    ldh [hScrollXHi], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 27; reached through ScriptCommand27 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand27)
; reads: wScriptStep
ScriptCommand27_Run::
Func_00F_72D9:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand27_Run_Case00
    dw ScriptCommand27_Run_Case01
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand27_Run_Case03
    dw ScriptCommand38_Run_Case00
    dw ScriptCommand38_Run_Case00
    dw ScriptCommand38_Run_Case00
    dw ScriptCommand27_Run_Case07
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand27_Run_Case09
    dw ScriptCommand27_Run_Case0A
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand27_Run_Case09
    dw ScriptCommand27_Run_Case0D
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand27_Run_Case0F
    dw ScriptCommand27_Run_Case10
    dw ScriptCommand27_Run_Case11
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand27_Run_Case13
    dw ScriptCommand27_Run_Case14
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand27_Run_Case16
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand27_Run_Case18
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand27_Run_Case1A
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand27_Run_Case1C
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand27_Run_Case1E
    dw ScriptCommand27_Run_Case1F
    dw ScriptCommand27_Run_Case20
    dw ScriptCommand27_Run_Case21
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand27_Run_Case23

; entry 35 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags
; writes: hTemp0, wStoryFlags, wFarmLevel, wScriptStartRequest
ScriptCommand27_Run_Case23::
Jump_00F_7325:: ; address name
    ld de, $0021
    call SetFlagBit
    ld a, $02
    ldh [hTemp0], a
    farcall MarkKeyEntryKindTemp0Bit6
    ld a, [wStoryFlags + $60]
    set 1, a
    ld [wStoryFlags + $60], a
    ld a, $01
    ld [wFarmLevel], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 33 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wObject5
; writes: wObject5
; points at: wScriptStep
ScriptCommand27_Run_Case21::
Jump_00F_7348:: ; address name
    ldh a, [hPlayerY]
    ld c, a
    ld a, [wObject5 + $5]
    inc a
    ld [wObject5 + $5], a
    cp a, c
    ret nz
    xor a, a
    ld [wObject5], a
    ld hl, $0DC0
    call StartMessageHL_B0F
    ld de, $001D
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 32 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerFacing, hPlayerX, hPlayerY
; writes: wSpriteSlots, hTemp0, wObject5
; points at: wScriptStep
ScriptCommand27_Run_Case20::
Jump_00F_7369:: ; address name
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ld [wSpriteSlots + $7], a
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ldh a, [hPlayerX]
    ld [wObject5 + $4], a
    ldh a, [hPlayerY]
    sub a, $20
    ld [wObject5 + $5], a
    ld a, $80
    ld [wObject5], a
    ld a, $85
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 31 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand27_Run_Case1F::
Jump_00F_7397:: ; address name
    farcall RunScriptSubStep_7363
    ret

; entry 30 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind, wScreenTriggerCount, wScriptSubStep
ScriptCommand27_Run_Case1E::
Jump_00F_739E:: ; address name
    ld a, $05
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wWarpDestX], a
    ld a, $30
    ld [wWarpDestY], a
    ld a, $01
    ld [wFieldTransitionKind], a
    xor a, a
    ld [wScreenTriggerCount], a
    farcall ScriptStartFadeAndAdvanceStep
    ld hl, $0125
    call StartMessageHL_B0F
    xor a, a
    ld [wScriptSubStep], a
    ret

; entry 28 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand27_Run_Case1C::
Jump_00F_73CD:: ; address name
    ld hl, $01A2
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 26 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wSpriteSlotCount
; points at: wScriptStep
ScriptCommand27_Run_Case1A::
Jump_00F_73D8:: ; address name
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $00
    ld [wStepTarget], a
    ld a, $A0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wSpriteSlotCount], a
    ld hl, $01A1
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 24 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand27_Run_Case18::
Jump_00F_7401:: ; address name
    ld hl, $01A0
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 22 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptTemp4
; writes: wObject5, wPartyCount
; points at: wScriptStep
ScriptCommand27_Run_Case16::
Jump_00F_740C:: ; address name
    ld hl, wObject5 + $4
    dec [hl]
    ld hl, wObject5 + $5
    inc [hl]
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $019F
    call StartMessageHL_B0F
    xor a, a
    ld [wObject5], a
    ld a, [wScriptTemp4]
    ld [wPartyCount], a
    ld a, $50
    ld [wObject5 + $4], a
    ld a, $30
    ld [wObject5 + $5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 20 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand27_Run_Case14::
Jump_00F_743A:: ; address name
    ld hl, wObject5 + $5
    dec [hl]
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, $019E
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 19 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount
; writes: wObject5, wScriptTemp4, wPartyCount
; points at: wScriptStep
ScriptCommand27_Run_Case13::
Jump_00F_7450:: ; address name
    ld a, $40
    ld [wObject5 + $4], a
    ld a, $20
    ld [wObject5 + $5], a
    ld a, $80
    ld [wObject5], a
    ld a, [wPartyCount]
    ld [wScriptTemp4], a
    cp a, $03
    jr nz, Jump_00F_746E
    ld a, $02
    ld [wPartyCount], a

Jump_00F_746E::
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 17 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wSpriteSlots
; points at: wScriptStep
ScriptCommand27_Run_Case11::
Jump_00F_7473:: ; address name
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $00
    ld [wStepTarget], a
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, $019D
    call StartMessageHL_B0F
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 16 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepTarget, wStepPtrLo, wStepPtrHi, wSpriteSlotCount, wSpriteSlots
; points at: wScriptStep
ScriptCommand27_Run_Case10::
Jump_00F_749D:: ; address name
    ld a, $00
    ld [wStepTarget], a
    ld a, $A0
    ld [wStepPtrLo], a
    ld a, $00
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, $03
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $01
    ld [wSpriteSlotCount], a
    ld de, FieldSpriteGfx22
    ld b, $7D
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $22
    ld [wSpriteSlots + $2], a
    ld a, $E0
    ld [wSpriteSlots + $C], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 15 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wObject2, wObject3, wSpriteSlots, wObject1
; points at: wScriptStep
ScriptCommand27_Run_Case0F::
Jump_00F_74F7:: ; address name
    ld a, $E0
    ld [wObject2 + $C], a
    ld a, $B0
    ld [wObject3 + $C], a
    ld a, $D0
    ld [wSpriteSlots + $C], a
    ld a, $C0
    ld [wObject1 + $C], a
    ld de, FieldSpriteGfx27
    ld b, $7D
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $27
    ld [wSpriteSlots + $2], a
    ld de, FieldSpriteGfx27
    ld b, $7D
    ld hl, vTiles0 + $600
    call DecompressToVRAM
    ld a, $27
    ld [wObject1 + $2], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand27_Run_Case0D::
Jump_00F_7530:: ; address name
    ld hl, $019C
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand27_Run_Case0A::
Jump_00F_753B:: ; address name
    ld hl, $019B
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0
; points at: wScriptStep
ScriptCommand27_Run_Case09::
Jump_00F_7546:: ; address name
    ld a, [wScriptParam0]
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
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $78
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepTarget, wStepPtrLo, wStepPtrHi
; points at: wScriptStep
ScriptCommand27_Run_Case07::
Jump_00F_756F:: ; address name
    ld a, $02
    ld [wStepTarget], a
    ld a, $E0
    ld [wStepPtrLo], a
    ld a, $01
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, $03
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, $019A
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrLo, hPlayerFacing
; points at: wScriptStep
ScriptCommand27_Run_Case03::
Jump_00F_75AA:: ; address name
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $01
    ldh [hPlayerFacing], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepTarget, wStepPtrLo, wStepPtrHi, hPlayerFacing
; points at: wScriptStep
ScriptCommand27_Run_Case01::
Jump_00F_75C3:: ; address name
    ld a, $02
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    ld a, $03
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ldh [hPlayerFacing], a
    ld hl, $0199
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, wStoryFlags
; writes: hTemp0, hTemp1, wStoryFlags
; points at: wScriptStep
ScriptCommand27_Run_Case00::
Jump_00F_7601:: ; address name
    xor a, a
    ldh [hTemp0], a
    ld a, $10
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a, a
    ret z
    ld a, [wStoryFlags + $61]
    set 5, a
    ld [wStoryFlags + $61], a
    ld de, $005A
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 23; reached through ScriptCommand23 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand23)
; reads: wScriptStep
ScriptCommand23_Run::
Func_00F_7625:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand23_Run_Case00
    dw ScriptCommand23_Run_Case01
    dw ScriptCommand23_Run_Case02
    dw ScriptCommand23_Run_Case03
    dw ScriptCommand23_Run_Case04

; entry 4 of the `rst $00` table in ScriptCommand23_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
ScriptCommand23_Run_Case04::
Jump_00F_7633:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 3 of the `rst $00` table in ScriptCommand23_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrLo, hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
ScriptCommand23_Run_Case03::
Jump_00F_7639:: ; address name
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $2E
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $20
    ld [wWarpDestX], a
    ld a, $60
    ld [wWarpDestY], a
    ld a, $01
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $60
    call QueueSoundEffect
    ret

; entry 2 of the `rst $00` table in ScriptCommand23_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wStepArrived
; writes: wStepPtrLo, wStepPtrHi, wStepTarget, wScriptParam0, wSpriteSlots
; points at: wScriptParam0, wScriptStep
ScriptCommand23_Run_Case02::
Jump_00F_766D:: ; address name
    ld a, [wScriptParam0]
    and a, $0F
    jr nz, Jump_00F_768B
    ld a, $60
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
    ld a, [wStepArrived]
    or a, a
    jr z, Jump_00F_7696
    ld hl, wScriptParam0
    inc [hl]
    jr Jump_00F_7696

Jump_00F_768B::
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928

Jump_00F_7696::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, [wScriptParam0]
    and a, $F0
    jr nz, Jump_00F_76C0
    ld a, $00
    ld [wStepTarget], a
    ld a, $60
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, [wScriptParam0]
    or a, $10
    ld [wScriptParam0], a
    ret

Jump_00F_76C0::
    ld a, $03
    ld [wStepTarget], a
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $E0
    ld [wSpriteSlots + $B], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand23_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
ScriptCommand23_Run_Case01::
Jump_00F_76E3:: ; address name
    ld a, $25
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $08
    ld [wWarpDestY], a
    ld a, $01
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $60
    call QueueSoundEffect
    ret

; entry 0 of the `rst $00` table in ScriptCommand23_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, wStepArrived
; writes: wStepPtrLo
; points at: wScriptStep
ScriptCommand23_Run_Case00::
Jump_00F_7707:: ; address name
    ldh a, [hPlayerX]
    cp a, $40
    jr z, Jump_00F_7719
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    ret

Jump_00F_7719::
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 1F; reached through ScriptCommand1F in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand1F)
; reads: wScriptStep
ScriptCommand1F_Run::
Func_00F_772E:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand1F_Run_Case00
    dw ScriptCommand1F_Run_Case01
    dw ScriptCommand1F_Run_Case02
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand1F_Run_Case04
    dw ScriptCommand1F_Run_Case05
    dw ScriptCommand1F_Run_Case06
    dw ScriptCommand1F_Run_Case07
    dw ScriptCommand1F_Run_Case08
    dw ScriptCommand1F_Run_Case09

; entry 0 of the `rst $00` table in ScriptCommand1F_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
ScriptCommand1F_Run_Case00::
Jump_00F_7746:: ; address name
    ld a, $25
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wWarpDestX], a
    ld a, $30
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld hl, $0151
    call StartMessageHL_B0F
    ret

; entry 1 of the `rst $00` table in ScriptCommand1F_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0
; points at: wScriptStep
ScriptCommand1F_Run_Case01::
Jump_00F_776B:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $6D
    call QueueSoundEffect
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand1F_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand1F_Run_Case02::
Jump_00F_777E:: ; address name
    ld b, $B4
    call StepScriptParam0Counter_Bank0F
    ret nc
    farcall RestartMapMusic
    ld hl, $0152
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand1F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrLo, hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
ScriptCommand1F_Run_Case04::
Jump_00F_7795:: ; address name
    ld a, $00
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $26
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wWarpDestX], a
    ld a, $80
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $60
    call QueueSoundEffect
    ret

; entry 5 of the `rst $00` table in ScriptCommand1F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrLo, hPlayerFacing, wScriptParam0
; points at: hPlayerStateFlags, wScriptStep
ScriptCommand1F_Run_Case05::
Jump_00F_77C9:: ; address name
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank0F
    ld a, $02
    ldh [hPlayerFacing], a
    ld a, $6D
    call QueueSoundEffect
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommand1F_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptSubStep
; points at: wScriptStep
ScriptCommand1F_Run_Case06::
Jump_00F_77F1:: ; address name
    ld b, $B4
    call StepScriptParam0Counter_Bank0F
    ret nc
    farcall RestartMapMusic
    xor a, a
    ld [wScriptSubStep], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in ScriptCommand1F_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand1F_Run_Case07::
Jump_00F_7806:: ; address name
    farcall RunScriptSubStep
    ret

; entry 8 of the `rst $00` table in ScriptCommand1F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wStepArrived
; writes: wScriptParam0, wStepPtrLo, hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
ScriptCommand1F_Run_Case08::
Jump_00F_780D:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_781C
    inc a
    ld [wScriptParam0], a
    ld a, $6D
    call QueueSoundEffect

Jump_00F_781C::
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $25
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $30
    ld [wWarpDestX], a
    ld a, $40
    ld [wWarpDestY], a
    ld a, $01
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $02
    call QueueMusic
    ld a, $60
    call QueueSoundEffect
    xor a, a
    ld [wScriptParam0], a
    ret

; entry 9 of the `rst $00` table in ScriptCommand1F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags
; writes: wStoryFlags, wScriptStartRequest
ScriptCommand1F_Run_Case09::
Jump_00F_785B:: ; address name
    farcall PlayMapMusic
    ld a, [wStoryFlags + $61]
    or a, $01
    ld [wStoryFlags + $61], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 1D; reached through ScriptCommand1D in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand1D)
; reads: wScriptStep
ScriptCommand1D_Run::
Func_00F_786F:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand1D_Run_Case01
    dw ScriptCommand1D_Run_Case02
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand1D_Run_Case04
    dw ScriptCommand1D_Run_Case05
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand1D_Run_Case07
    dw ScriptCommand1D_Run_Case08
    dw ScriptCommand1D_Run_Case09
    dw ScriptCommand1D_Run_Case0A
    dw ScriptCommand1D_Run_Case0B
    dw ScriptCommand1D_Run_Case0C

; entry 12 of the `rst $00` table in ScriptCommand1D_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags
; writes: wStoryFlags, wScriptStartRequest
ScriptCommand1D_Run_Case0C::
Jump_00F_788D:: ; address name
    ld a, [wStoryFlags + $60]
    set 0, a
    ld [wStoryFlags + $60], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 11 of the `rst $00` table in ScriptCommand1D_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wFieldTransitionKind, wPartyCount
ScriptCommand1D_Run_Case0B::
Jump_00F_789B:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $01
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $01
    ld [wPartyCount], a
    ld de, $0002
    call SetFlagBit
    ret

; entry 10 of the `rst $00` table in ScriptCommand1D_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0
; points at: wScriptStep
ScriptCommand1D_Run_Case0A::
Jump_00F_78B7:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld hl, $0093
    call StartMessageHL_B0F
    ret

; entry 9 of the `rst $00` table in ScriptCommand1D_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: wFollowerRecords, hPlayerFacing
; points at: hPlayerY, wScriptStep
ScriptCommand1D_Run_Case09::
Jump_00F_78CB:: ; address name
    ld de, hPlayerY
    call ScriptApplyStepDeltaAtDE
    push af
    ldh a, [hPlayerY]
    ld [wFollowerRecords + $2], a
    pop af
    ret nc
    ld a, $01
    ldh [hPlayerFacing], a
    ld a, $03
    ld [wFollowerRecords], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 8 of the `rst $00` table in ScriptCommand1D_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0
; points at: wScriptStep
ScriptCommand1D_Run_Case08::
Jump_00F_78E7:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld de, $0000
    call TestFlagBit
    jr c, Jump_00F_7903
    ld hl, $009A
    call StartMessageHL_B0F
    ret

Jump_00F_7903::
    ld hl, $0092
    call StartMessageHL_B0F
    ret

; entry 7 of the `rst $00` table in ScriptCommand1D_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wSpriteSlots, wScriptParam0
; points at: wScriptStep
ScriptCommand1D_Run_Case07::
Jump_00F_790A:: ; address name
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $70
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wSpriteSlots + $7], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld hl, $0091
    call StartMessageHL_B0F
    ret

; entry 5 of the `rst $00` table in ScriptCommand1D_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0, hPlayerFacing, wFollowerRecords
; points at: wScriptStep
ScriptCommand1D_Run_Case05::
Jump_00F_7937:: ; address name
    ld de, wSpriteSlots + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    ld a, $02
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld hl, $0090
    call StartMessageHL_B0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand1D_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wStepArrived, wSpriteSlots
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wSpriteSlots, wScriptParam0
; points at: wScriptParam0, wScriptStep
ScriptCommand1D_Run_Case04::
Jump_00F_7968:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_798D
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $60
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_798D::
    ld a, [wSpriteSlots + $C]
    cp a, $40
    jr z, Jump_00F_79AA
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ret

Jump_00F_79AA::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $01
    ld [wStepTarget], a
    ld a, $78
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wSpriteSlots + $7], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand1D_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wMessageGroup
; writes: wMessageIndex, wMessageGroup
; points at: wScriptStep
ScriptCommand1D_Run_Case02::
Jump_00F_79D1:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    dec hl
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    ld hl, wScriptStep
    dec [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand1D_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult, wMessageIndex, wMessageGroup
; writes: wMessageIndex, wMessageGroup
; points at: wScriptStep
ScriptCommand1D_Run_Case01::
Jump_00F_79EC:: ; address name
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, Jump_00F_7A12
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    ld h, $80
    inc hl
    inc hl
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_7A12::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    ld h, $C0
    inc hl
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 1C; reached through ScriptCommand1C in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand1C)
; reads: wScriptStep
ScriptCommand1C_Run::
Func_00F_7A2D:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand1C_Run_Case00
    dw ScriptCommand1C_Run_Case01
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand1C_Run_Case03
    dw ScriptCommand62_Run_Case01

; entry 3 of the `rst $00` table in ScriptCommand1C_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult, wMessageIndex, wMessageGroup
; points at: wScriptStep
ScriptCommand1C_Run_Case03::
Jump_00F_7A3B:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, Jump_00F_7A5A
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $40
    ld h, a
    inc hl
    call StartMessageHL_B0F
    ret

Jump_00F_7A5A::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $40
    ld h, a
    inc hl
    inc hl
    call StartMessageHL_B0F
    ret

; entry 1 of the `rst $00` table in ScriptCommand1C_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerRecords
; writes: wFollowerRecords, hPlayerFacing
; points at: wScriptStep
ScriptCommand1C_Run_Case01::
Jump_00F_7A70:: ; address name
    ld a, $01
    ld [wFollowerRecords], a
    ld a, [wFollowerRecords + $1]
    inc a
    ld [wFollowerRecords + $1], a
    cp a, $80
    ret nz
    ld a, $01
    ldh [hPlayerFacing], a
    ld a, $03
    ld [wFollowerRecords], a
    ld hl, wScriptStep
    inc [hl]
    ld de, $0000
    call TestFlagBit
    jr c, Jump_00F_7A9B
    ld hl, $4094
    call StartMessageHL_B0F
    ret

Jump_00F_7A9B::
    ld hl, $4089
    call StartMessageHL_B0F
    ret

; entry 0 of the `rst $00` table in ScriptCommand1C_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
ScriptCommand1C_Run_Case00::
Jump_00F_7AA2:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $06
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $70
    ld [wWarpDestX], a
    ld a, $50
    ld [wWarpDestY], a
    ld a, $02
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; implements script command type 77; reached through ScriptCommand77 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand77)
; reads: wScriptStep
ScriptCommand77_Run::
Func_00F_7AC6:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand77_Run_Case00
    dw ScriptCommand77_Run_Case01
    dw ScriptCommand77_Run_Case02
    dw ScriptCommand77_Run_Case03
    dw ScriptCommand77_Run_Case03
    dw ScriptCommand77_Run_Case03
    dw ScriptCommand77_Run_Case03
    dw ScriptCommand77_Run_Case03
    dw ScriptCommand77_Run_Case03
    dw ScriptCommand77_Run_Case09
    dw ScriptCommand77_Run_Case0A
    dw ScriptCommand77_Run_Case0B
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand77_Run_Case0D
    dw ScriptCommand77_Run_Case0E

; entry 14 of the `rst $00` table in ScriptCommand77_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wTalkEventIndex, wTalkEventGroup
ScriptCommand77_Run_Case0E::
Jump_00F_7AE8:: ; address name
    ld a, $0A
    ld [wTalkEventIndex], a
    ld a, $02
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    ret

; entry 13 of the `rst $00` table in ScriptCommand77_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind, hPlayerSpriteMode, wMessageIndex, ...
ScriptCommand77_Run_Case0D::
Jump_00F_7AF9:: ; address name
    ld a, $00
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    ld a, $02
    ldh [hMapScreenY], a
    ld a, $50
    ld [wWarpDestX], a
    ld [wWarpDestY], a
    ld a, $01
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld de, $001B
    call SetFlagBit
    ld a, $01
    ldh [hPlayerSpriteMode], a
    xor a, a
    ld [wMessageIndex], a
    ld [wMessageGroup], a
    ret

; entry 11 of the `rst $00` table in ScriptCommand77_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand77_Run_Case0B::
Jump_00F_7B2A:: ; address name
    ld b, $78
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, $0014
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in ScriptCommand77_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hScrollY, hScrollX, wFieldActionStep
; writes: wScriptParam0, hScrollY
; points at: wFieldActionStep, wScriptStep
ScriptCommand77_Run_Case0A::
Jump_00F_7B3B:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
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
    ld a, [wFieldActionStep]
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
    call ScriptCommand77_Run_Case0A_Sub01
    ldh a, [hScrollY]
    sub a, $01
    ldh [hScrollY], a
    ld hl, wFieldActionStep
    inc [hl]
    ld a, [wFieldActionStep]
    cp a, $90
    jr nc, Jump_00F_7BB4
    ret

Jump_00F_7BB4::
    ldh a, [hScrollY]
    and a, $F8
    ldh [hScrollY], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; only called from ScriptCommand77_Run_Case0A (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommand77_Run_Case0A)
; reads: wIsCGB, hTemp0
; writes: wBGWriteDestLo, wBGWriteDestHi, wBGWriteVertical, wBGWriteCount, wAttrWriteDestLo, wAttrWriteDestHi, wAttrWriteVertical, wAttrWriteCount, ...
; points at: wBGWriteData, wAttrWriteData
ScriptCommand77_Run_Case0A_Sub01::
Func_00F_7BC3:: ; address name
    ld a, e
    ld [wBGWriteDestLo], a
    ld a, d
    ld [wBGWriteDestHi], a
    xor a, a
    ld [wBGWriteVertical], a
    ld a, $14
    ld [wBGWriteCount], a
    push hl
    push de
    ld b, $14
    ld de, wBGWriteData

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
    ld [wAttrWriteDestLo], a
    ld a, d
    ld [wAttrWriteDestHi], a
    ld a, $00
    ld [wAttrWriteVertical], a
    ld a, $14
    ld [wAttrWriteCount], a
    ld de, $0E68
    add hl, de
    ld b, $14
    ld de, wAttrWriteData

Jump_00F_7C03::
    ld a, $02
    ldh [rSVBK], a
    ld a, [hl+]
    ldh [hTemp0], a
    ld a, $00
    ldh [rSVBK], a
    ldh a, [hTemp0]
    and a, $07
    ld [de], a
    ld [de], a
    inc de
    dec b
    jr nz, Jump_00F_7C03
    ret

; entry 9 of the `rst $00` table in ScriptCommand77_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wFieldActionStep
; points at: wScriptStep
ScriptCommand77_Run_Case09::
Jump_00F_7C19:: ; address name
    xor a, a
    ld [wFieldActionStep], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in ScriptCommand77_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0, hScrollY, hScrollYHi
; points at: hScrollY, wScriptStep
ScriptCommand77_Run_Case03::
Jump_00F_7C22:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    ret nz
    ld a, [wScriptParam0]
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
    ld [wScriptParam0], a
    ldh [hScrollY], a
    ldh [hScrollYHi], a
    call ComputeSpriteScrollOffsets
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand77_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wSpriteSlots
; writes: wScriptParam0, wSpriteSlots
; points at: wScriptStep
ScriptCommand77_Run_Case02::
Jump_00F_7C4F:: ; address name
    ld hl, wSpriteSlots + $D
    call SetBit2AtHL_B0F
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    ret nz
    ld a, [wSpriteSlots + $C]
    dec a
    ld [wSpriteSlots + $C], a
    cp a, $50
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand77_Run
; no direct call (reached through a table, a jump or a vector)
; points at: hMapScreenY, wScriptStep
ScriptCommand77_Run_Case01::
Jump_00F_7C72:: ; address name
    ld b, $3C
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, hMapScreenY
    dec [hl]
    call LoadMapScreen
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand77_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
ScriptCommand77_Run_Case00::
Jump_00F_7C84:: ; address name
    ld a, $1C
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ld a, $01
    ldh [hMapScreenY], a
    ld a, $E0
    ld [wWarpDestX], a
    ld a, $00
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; implements script command type 76; reached through ScriptCommand76 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand76)
; reads: wScriptStep
ScriptCommand76_Run::
Func_00F_7CA5:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand76_Run_Case00
    dw ScriptCommand76_Run_Case00
    dw ScriptCommand5F_Run_Case03
    dw ScriptCommand76_Run_Case03

; entry 3 of the `rst $00` table in ScriptCommand76_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wFollowerRecords, wObject3, wScriptStartRequest
ScriptCommand76_Run_Case03::
Jump_00F_7CB1:: ; address name
    ld a, $76
    call QueueSoundEffect
    ld de, $001B
    call SetFlagBit
    ld a, $03
    ld [wFollowerRecords], a
    ld a, $60
    ld [wFollowerRecords + $1], a
    ld a, $50
    ld [wFollowerRecords + $2], a
    ld a, $E0
    ld [wObject3 + $C], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 0 of the `rst $00` table in ScriptCommand76_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0
; points at: wScriptStep
ScriptCommand76_Run_Case00::
Jump_00F_7CD6:: ; address name
    ld de, wObject3 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld de, $0001
    call TestFlagBit
    jr nc, Jump_00F_7CF4
    ld hl, $0076
    call StartMessageHL_B0F
    ret

Jump_00F_7CF4::
    ld hl, $0078
    call StartMessageHL_B0F
    ret

; implements script command type 75; reached through ScriptCommand75 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand75)
; reads: wScriptStep
ScriptCommand75_Run::
Func_00F_7CFB:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand75_Run_Case00
    dw ScriptCommand75_Run_Case01
    dw ScriptCommand75_Run_Case02
    dw ScriptCommand75_Run_Case03

; entry 3 of the `rst $00` table in ScriptCommand75_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
ScriptCommand75_Run_Case03::
Jump_00F_7D07:: ; address name
    ld hl, wObject3 + $B
    dec [hl]
    ld hl, wObject3 + $C
    inc [hl]
    ld de, wObject3 + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommand75_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wObject3
; writes: wObject3
; points at: wScriptStep
ScriptCommand75_Run_Case02::
Jump_00F_7D1C:: ; address name
    ld a, [wObject3 + $C]
    inc a
    inc a
    ld [wObject3 + $C], a
    cp a, $30
    ret nz
    ld a, $03
    ld [wObject3 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand75_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand75_Run_Case01::
Jump_00F_7D31:: ; address name
    ld b, $5A
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand75_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind, hPlayerSpriteMode
ScriptCommand75_Run_Case00::
Jump_00F_7D3C:: ; address name
    ld a, $1D
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    ld a, $00
    ldh [hMapScreenY], a
    ld a, $50
    ld [wWarpDestX], a
    ld a, $40
    ld [wWarpDestY], a
    ld a, $02
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $01
    ldh [hPlayerSpriteMode], a
    ret

; implements script command type 6B; reached through ScriptCommand6B in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand6B)
; reads: wScriptStep
ScriptCommand6B_Run::
Func_00F_7D62:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand6B_Run_Case00
    dw ScriptCommand6B_Run_Case01
    dw ScriptCommand62_Run_Case01

; entry 1 of the `rst $00` table in ScriptCommand6B_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand6B_Run_Case01::
Jump_00F_7D6C:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld de, $0000
    call TestFlagBit
    jr c, Jump_00F_7D7F
    ld hl, $0021
    call StartMessageHL_B0F
    ret

Jump_00F_7D7F::
    ld hl, $001F
    call StartMessageHL_B0F
    ret

; entry 0 of the `rst $00` table in ScriptCommand6B_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerFacing
; writes: wFollowerRecords
; points at: wScriptStep
ScriptCommand6B_Run_Case00::
Jump_00F_7D86:: ; address name
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld de, wFollowerRecords + $2
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 6A; reached through ScriptCommand6A in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand6A)
; reads: wScriptStep
ScriptCommand6A_Run::
Func_00F_7D97:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand6A_Run_Case00
    dw ScriptCommand6A_Run_Case01
    dw ScriptCommand6A_Run_Case02
    dw ScriptCommand6A_Run_Case03

; entry 3 of the `rst $00` table in ScriptCommand6A_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
; points at: hPlayerStateFlags
ScriptCommand6A_Run_Case03::
Jump_00F_7DA3:: ; address name
    call ScriptCommand6A_Run_Shared01
    ld de, wSpriteSlots + $C
    call ScriptApplyStepDeltaAtDE
    ret nc
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank0F
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommand6A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex
; writes: wMessageIndex
; points at: wScriptStep
ScriptCommand6A_Run_Case02::
Jump_00F_7DB9:: ; address name
    call ScriptCommand6A_Run_Shared01
    ld a, [wMessageIndex]
    inc a
    ld [wMessageIndex], a
    cp a, $20
    ret nz
    xor a, a
    ld [wMessageIndex], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand6A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepTarget, wStepPtrHi, wStepPtrLo, wSpriteSlots
; points at: wScriptStep
ScriptCommand6A_Run_Case01::
Jump_00F_7DCF:: ; address name
    call ScriptCommand6A_Run_Shared01
    ld a, $00
    ld [wStepTarget], a
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $01
    ld [wSpriteSlots + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand6A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wMessageGroup
; writes: wMessageIndex, wMessageGroup
; points at: wScriptStep
ScriptCommand6A_Run_Case00::
Jump_00F_7DF6:: ; address name
    call ScriptCommand6A_Run_Shared01
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    ld a, h
    cp a, $01
    ret nz
    ld a, l
    cp a, $40
    ret nz
    xor a, a
    ld [wMessageIndex], a
    ld [wMessageGroup], a
    ld hl, wScriptStep
    inc [hl]
    ret

; only called from routines of ScriptCommand6A_Run (E-0098)
; 4 call sites from 4 routines (e.g. ScriptCommand6A_Run_Case03, ScriptCommand6A_Run_Case02, ScriptCommand6A_Run_Case01, ScriptCommand6A_Run_Case00)
; reads: wScriptParam1, wStepArrived
; writes: wStepPtrLo, wScriptParam1
ScriptCommand6A_Run_Shared01::
Func_00F_7E1E:: ; address name
    ld a, [wScriptParam1]
    or a, a
    jr nz, Jump_00F_7E37
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    farcall StepPlayerLeftTowardWC928
    jr Jump_00F_7EA0

Jump_00F_7E37::
    dec a
    jr nz, Jump_00F_7E4D
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
    farcall StepPlayerDownTowardWC928
    jr Jump_00F_7EA0

Jump_00F_7E4D::
    dec a
    jr nz, Jump_00F_7E63
    ld a, $80
    ld [wStepPtrLo], a
    farcall StepPlayerRightTowardWC928
    farcall StepPlayerRightTowardWC928
    jr Jump_00F_7EA0

Jump_00F_7E63::
    dec a
    jr nz, Jump_00F_7E79
    ld a, $60
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    farcall StepPlayerUpTowardWC928
    jr Jump_00F_7EA0

Jump_00F_7E79::
    dec a
    jr nz, Jump_00F_7E8F
    ld a, $70
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    farcall StepPlayerLeftTowardWC928
    jr Jump_00F_7EA0

Jump_00F_7E8F::
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    farcall StepPlayerUpTowardWC928

Jump_00F_7EA0::
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, [wScriptParam1]
    inc a
    cp a, $06
    jr nz, Jump_00F_7EAE
    xor a, a

Jump_00F_7EAE::
    ld [wScriptParam1], a
    ret

; wC921 += 1; if it now equals B it is reset to 0 and carry is set, else carry is clear; returns A = 0 either way (the same 18 bytes appear in 3 banks)
; 34 call sites from 34 routines (e.g. ScriptCommand77_Run_Case0B, ScriptCommand77_Run_Case01, ScriptCommand75_Run_Case01, ScriptStepDeltaThenMessage, ...)
; reads: wScriptParam0
; writes: wScriptParam0
StepScriptParam0Counter_Bank0F::
Func_00F_7EB2:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, b
    jr z, Jump_00F_7EBE
    sub a, a
    ret

Jump_00F_7EBE::
    xor a, a
    ld [wScriptParam0], a
    scf
    ret

; [HL] |= $02; clobbers A (the same 5 bytes appear in 4 banks)
; 5 call sites from 5 routines (e.g. ScriptCommand5F_Run_Case26, ScriptCommand46_Run_Case03, ScriptCommand46_Run_Case01, ScriptCommand42_Run_Case10, ...)
SetBit1AtHL_Bank0F::
Func_00F_7EC4:: ; address name
    ld a, [hl]
    or a, $02
    ld [hl], a
    ret

; [HL] &= $FD; clobbers A (the same 5 bytes appear in 4 banks)
; 4 call sites from 4 routines (e.g. ScriptCommand46_Run_Case04, ScriptCommand46_Run_Case02, ScriptCommand42_Run_Case11, ScriptCommand38_Run_Case06)
ClearBit1AtHL_Bank0F::
Func_00F_7EC9:: ; address name
    ld a, [hl]
    and a, $FD
    ld [hl], a
    ret

; sets bit 2 of the byte at [HL]; only A is clobbered
; 28 call sites from 16 routines (e.g. ScriptCommandC7_Run_Case00, ScriptCommand77_Run_Case02, ScriptCommand46_Run_Case0A, ScriptCommand46_Run_Case03, ...)
SetBit2AtHL_B0F::
Func_00F_7ECE:: ; address name
    ld a, [hl]
    or a, $04
    ld [hl], a
    ret

; [HL] &= $FB; clobbers A (the same 5 bytes appear in 4 banks)
; 24 call sites from 15 routines (e.g. ScriptCommand6A_Run_Case03, ScriptCommand5F_Run_Case14, ScriptCommand4B_Run_Case11, ScriptCommand46_Run_Case07, ...)
ClearBit2AtHL_Bank0F::
Func_00F_7ED3:: ; address name
    ld a, [hl]
    and a, $FB
    ld [hl], a
    ret

; A = the player's moving coordinate: when A & $0F = 0 (a 16-pixel tile boundary) far-calls SetFollowerTargetsFromLeader; then always far-calls StepFollowersTowardTargets (E-0093) (the same 17 bytes appear in 3 banks)
; 15 call sites from 8 routines (e.g. ScriptCommandC7_Run_Case03, ScriptCommandC7_Run_Case02, ScriptCommand46_Run_Case0B, ScriptCommand43_Run_Case03, ...)
UpdateFollowersOnStep_Bank0F::
Func_00F_7ED8:: ; address name
    and a, $0F
    jr nz, Jump_00F_7EE2
    farcall SetFollowerTargetsFromLeader

Jump_00F_7EE2::
    farcall StepFollowersTowardTargets
    ret

; DE = address of a byte: adds the step delta for wScriptParam0 (AddStepDeltaToPointedByte), then wScriptParam0 += 2; when it reaches $20 it is reset to 0 and carry is set, otherwise A = 0 and carry is clear (16 calls per move) (E-0062)
; 38 call sites from 38 routines (e.g. ScriptCommand76_Run_Case00, ScriptCommand75_Run_Case03, ScriptCommand6B_Run_Case00, ScriptCommand6A_Run_Case03, ...)
; reads: wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0
ScriptApplyStepDeltaAtDE::
Func_00F_7EE9:: ; address name
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    cp a, $20
    jr z, Jump_00F_7F05
    sub a, a
    ret

Jump_00F_7F05::
    xor a, a
    ld [wScriptParam0], a
    scf
    ret

; DE = address of a byte: adds the step delta (AddStepDeltaToPointedByte via wC928/wC929) and counts wC921 up (StepWC921Counter_Bank0F with B = $20); when the counter wraps, wScriptStep += 1 (E-0117)
; 4 call sites from 4 routines (e.g. ScriptCommand5E_Run_Case18, ScriptCommand46_Run_Case09, ScriptCommand42_Run_Case05, ScriptCommand29_Run_Case03)
; writes: wStepPtrLo, wStepPtrHi
; points at: wScriptStep
ScriptStepDeltaThenNextStep::
Func_00F_7F0B:: ; address name
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld b, $20
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; DE = address of a byte: adds the step delta (AddStepDeltaToPointedByte via wC928/wC929) and counts wC921 up (StepWC921Counter_Bank0F with B = $20); when the counter wraps, StartMessageHL_B0F with the caller's HL and wScriptStep += 1 (E-0117)
; 7 call sites from 7 routines (e.g. ScriptCommand66_Run_Case0C, ScriptCommand58_Run_Case2A, ScriptCommand58_Run_Case18, ScriptCommand58_Run_Case08, ...)
; writes: wStepPtrLo, wStepPtrHi
; points at: wScriptStep
ScriptStepDeltaThenMessage::
Func_00F_7F24:: ; address name
    push hl
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld b, $20
    call StepScriptParam0Counter_Bank0F
    pop hl
    ret nc
    call StartMessageHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; DE = address of a byte: adds the step delta (AddStepDeltaToPointedByte via wC928/wC929) and counts wC921 up (StepWC921Counter_Bank0F with B = $20); when the counter wraps, wScriptStartRequest = $80 (E-0117)
; no direct call (reached through a table, a jump or a vector)
; writes: wStepPtrLo, wStepPtrHi, wScriptStartRequest
ScriptStepDeltaThenRequestFetch:: ; heuristic: follows a terminator; C0
Func_00F_7F42:: ; address name
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld b, $20
    call StepScriptParam0Counter_Bank0F
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; when wScriptParam0 & $1F = 0: [DE] = ([DE] + 1) & 3, the next of four directions; otherwise returns with A = wScriptParam0 & $1F (E-0064) (the same 12 bytes appear in 3 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
RotateDirectionAtDEEvery32_Bank0F:: ; heuristic: follows a terminator; C0
Func_00F_7F5C:: ; address name
    ld a, [wScriptParam0]
    and a, $1F
    ret nz
    ld a, [de]
    inc a
    and a, $03
    ld [de], a
    ret

; HL is stored in wC924 (low) and wC925 (high); then wC926 = 0
; 127 call sites from 108 routines (e.g. ScriptCommand77_Run_Case0B, ScriptCommand76_Run_Case00, ScriptCommand6B_Run_Case01, ScriptCommand66_Run_Case0E, ...)
; writes: wMessageIndex, wMessageGroup, wMessageState
StartMessageHL_B0F::
Func_00F_7F68:: ; address name
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a, a
    ld [wMessageState], a
    ret

; wC928 = A, far-calls RunMessageBox, then carry set when wMessageState = $FF (idle), else A = 0 and carry clear (E-0079) (the same 20 bytes appear in 4 banks)
; 15 call sites from 15 routines (e.g. ScriptCommand66_Run_Case05, ScriptCommand58_Run_Case2B, ScriptCommand4B_Run_Case0F, ScriptCommand4B_Run_Case0E, ...)
; reads: wMessageState
; writes: wStepPtrLo
RunMessageBoxFar_Bank0F::
Func_00F_7F75:: ; address name
    ld [wStepPtrLo], a
    farcall RunMessageBox
    ld a, [wMessageState]
    cp a, $FF
    jr z, Jump_00F_7F87
    sub a, a
    ret

Jump_00F_7F87::
    scf
    ret

; entry 3 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand5F_Run_Case03::
Jump_00F_7F89:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand62_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
ScriptCommand62_Run_Case01::
Jump_00F_7F93:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank0F
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret
    ds $62, $00
