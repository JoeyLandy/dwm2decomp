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
; reads: hPlayerY, wScriptParam0, hFF8C
; writes: wScriptParam0, hFF8C, wScriptStartRequest
ScriptCommandC7_Run_Case03::
Jump_00F_400D:: ; address name
    ldh a, [hPlayerY]
    call Func_00F_7ED8
    ldh a, [hPlayerY]
    call Func_00F_7ED8
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $1E
    ret nz
    ldh a, [hFF8C]
    and a, $FD
    ldh [hFF8C], a
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
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommandC7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C, hFF8C
; writes: wC929, wC92A, wC928, hFF8C
; points at: wScriptStep
ScriptCommandC7_Run_Case01::
Jump_00F_404D:: ; address name
    ld a, $01
    ld [wC929], a
    ld a, $80
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ldh a, [hFF8C]
    or a, $02
    ldh [hFF8C], a
    ld a, $63
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommandC7_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wCB9B
; writes: wScriptParam0, wCB9B
; points at: wCB9C, wScriptStep
ScriptCommandC7_Run_Case00::
Jump_00F_4077:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
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
; reads: wScriptParam1, hFFC6
; writes: rRAMG
; points at: wC6FE, wScriptStep
ScriptCommand62_Run_Case00::
Jump_00F_40A2:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld hl, wC6FE
    ld a, [wScriptParam1]
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
; writes: hMapId, hMapScreenX, hMapScreenY, wGameMode, wModeState, wC5DD, wC0A0, wC0A1
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
    ld [wC5DD], a
    xor a, a
    ld [wC0A0], a
    xor a, a
    ld [wC0A1], a
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
; reads: wIsCGB, wSGBActive, wC51F
; writes: wSpriteSlotCount, wCBCF, hPlayerX, wC8F0, wC52D, wC52E, wC52F, wC530, ...
; points at: wScreenTileBuffer, wC252, wD000, wC4FF, wScriptStep
ScriptCommand5F_Run_Case29::
Jump_00F_418E:: ; address name
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
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ld a, $01
    ld [wC837], a
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
; reads: wCBAA
; writes: wCBAA, wCB8A, wScriptParam0
; points at: wCBD4, wCBAC, wScriptStep
ScriptCommand5F_Run_Case26::
Jump_00F_427A:: ; address name
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
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 33 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wC8F1, wScriptStep
ScriptCommand5F_Run_Case21::
Jump_00F_429F:: ; address name
    ld de, wC8F1
    call Func_00F_7EE9
    ret nc
    ld a, $01
    add a, $B9
    ld l, a
    ld h, $0D
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 32 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC8F0
; writes: wC8F0, wC8EF
; points at: wScriptStep
ScriptCommand5F_Run_Case20::
Jump_00F_42B5:: ; address name
    ld a, [wC8F0]
    dec a
    dec a
    ld [wC8F0], a
    cp a, $78
    ret nz
    ld a, $02
    ld [wC8EF], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 30 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand5F_Run_Case1E::
Jump_00F_42CA:: ; address name
    ld hl, $0DB8
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 29 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wCBAA, hPlayerX, wCBD3
; writes: wCBAA, hPlayerX, wCBD3, wScriptParam0
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
; reads: wScriptParam0, wCBAA, hPlayerX, wCBD3
; writes: wCBA6, wCBAA, hPlayerX, wCBD3, wScriptParam0
; points at: wScriptStep
ScriptCommand5F_Run_Case1C::
Jump_00F_42E7:: ; address name
    ld a, $01
    ld [wCBA6], a
    ld a, [wScriptParam0]
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
; points at: wCBAB, wScriptStep
ScriptCommand5F_Run_Case19::
Jump_00F_438B:: ; address name
    ld de, wCBAB
    call Func_00F_7EE9
    ret nc
    ld hl, $0DB7
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 23 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wC92C
; writes: wC929, wC92A, wC928, wCB96, wCBA6, wScriptParam0
; points at: wScriptParam0, wScriptStep
ScriptCommand5F_Run_Case17::
Jump_00F_439D:: ; address name
    ld a, $01
    ld [wC929], a
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_43C2
    ld a, $80
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_43C2::
    ld a, $83
    ld [wC92A], a
    ld a, $58
    ld [wC928], a
    farcall StepObjectTowardCoord
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
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 22 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCB96, wCBA6, wC928, wC929
; points at: wCBAB, wCB9B, wScriptStep
ScriptCommand5F_Run_Case16::
Jump_00F_43EF:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 20 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC928
; points at: wCB9C, wCBAC, wScriptStep
ScriptCommand5F_Run_Case14::
Jump_00F_4419:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 18 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCBAB, wScriptStep
ScriptCommand5F_Run_Case12::
Jump_00F_4444:: ; address name
    ld de, wCBAB
    call Func_00F_7EE9
    ret nc
    ld hl, $0DB3
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 16 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCB9B, wScriptStep
ScriptCommand5F_Run_Case10::
Jump_00F_4456:: ; address name
    ld de, wCB9B
    call Func_00F_7EE9
    ret nc
    ld hl, $0DB2
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCBAB, wScriptStep
ScriptCommand5F_Run_Case0D::
Jump_00F_4468:: ; address name
    ld de, wCBAB
    call Func_00F_7EE9
    ret nc
    ld hl, $0DB1
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCB9B, wScriptStep
ScriptCommand5F_Run_Case0A::
Jump_00F_447A:: ; address name
    ld de, wCB9B
    call Func_00F_7EE9
    ret nc
    ld hl, $0DB0
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand5F_Run_Case09::
Jump_00F_448C:: ; address name
    farcall Func_073_734D
    ret

; entry 8 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6, wCBD3, wCBD4, wCBCF
; points at: wScriptStep
ScriptCommand5F_Run_Case08::
Jump_00F_4493:: ; address name
    ld a, $01
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $68
    ld [wCBD3], a
    ld a, $30
    ld [wCBD4], a
    ld a, $80
    ld [wCBCF], a
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
    call StepWC921Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF
; points at: wCBD4, wScriptStep
ScriptCommand5F_Run_Case04::
Jump_00F_44D8:: ; address name
    ld a, $80
    ld [wCBCF], a
    ld hl, wCBD4
    dec [hl]
    ld de, wCBD4
    call Func_00F_7EE9
    ret nc
    ld hl, $0549
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: hPlayerFacing, wC928, wC929, wScriptParam0
; points at: hPlayerY, wCBAB, wScriptStep
ScriptCommand5F_Run_Case02::
Jump_00F_44F3:: ; address name
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
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    ld hl, $0548
    call StoreHLInWC924_B0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wScriptParam1, wCBBB, wCBBA
; writes: wScriptParam0, wScriptParam1, wCBBB, wCBBA
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
    ld [wScriptParam0], a
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6, wCBD3, wCBD4, wScriptParam0, wScriptParam1, hFF8D
; points at: wScriptStep
ScriptCommand5F_Run_Case00::
Jump_00F_456A:: ; address name
    ld a, $13
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $40
    ld [wCBD3], a
    ld [wCBD4], a
    ld hl, $FE80
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ld a, $65
    call QueueSoundEffect
    ld a, $0E
    ldh [hFF8D], a
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
    db $6A, $51
    dw Func_00F_47F5
    dw Func_00F_47BC
    dw Func_00F_47A8
    dw Func_00F_4774
    INCBIN "dwm2-cobi-us.gbc", $03C6A3, $D1

; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC928, wC92A
; points at: wScriptStep
Func_00F_4774:: ; heuristic: target of a pointer table; C0
    ld a, $02
    ld [wC929], a
    ld a, $B0
    ld [wC928], a
    ld a, $81
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, $03
    ld [wC929], a
    ld a, $C0
    ld [wC928], a
    ld a, $81
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wCBAB
; writes: wCBBB
; points at: wCBAB, wScriptStep
Func_00F_47A8:: ; heuristic: target of a pointer table; C0
    ld de, wCBAB
    call Func_00F_7EE9
    push af
    ld a, [wCBAB]
    ld [wCBBB], a
    pop af
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wCB9B
; points at: wScriptStep
Func_00F_47BC:: ; heuristic: target of a pointer table; C0
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
    ld hl, wScriptStep
    inc [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC928, wC92A
; points at: wScriptStep
Func_00F_47F5:: ; heuristic: target of a pointer table; C0
    ld a, $02
    ld [wC929], a
    ld a, $40
    ld [wC928], a
    ld a, $03
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, $03
    ld [wC929], a
    ld a, $50
    ld [wC928], a
    ld a, $03
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 127 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6, wCBD3, wCBD4, wCBCF
; points at: wScriptStep
ScriptCommand5E_Run_Case7F::
Jump_00F_4829:: ; address name
    ld a, $11
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $20
    ld [wCBD3], a
    ld a, $40
    ld [wCBD4], a
    xor a, a
    ld [wCBCF], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 126 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wCBD3, wCBD4
ScriptCommand5E_Run_Case7E::
Jump_00F_4846:: ; address name
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

; entry 121 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC928, wC92A
; points at: wScriptStep
ScriptCommand5E_Run_Case79::
Jump_00F_485D:: ; address name
    ld a, $00
    ld [wC929], a
    ld a, $60
    ld [wC928], a
    ld a, $00
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 120 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC928, wC92A, wCB96, wCBA6
; points at: wScriptStep
ScriptCommand5E_Run_Case78::
Jump_00F_487C:: ; address name
    ld a, $01
    ld [wC929], a
    ld a, $30
    ld [wC928], a
    ld a, $03
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wC929], a
    ld a, $60
    ld [wC928], a
    ld a, $01
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wCB96], a
    ld [wCBA6], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 118 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC928, wC92A, wCB96, wCBA6
; points at: wScriptStep
ScriptCommand5E_Run_Case76::
Jump_00F_48B7:: ; address name
    ld a, $00
    ld [wC929], a
    ld a, $50
    ld [wC928], a
    ld a, $00
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $02
    ld [wCB96], a
    ld [wCBA6], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 117 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC928, wC92A, wC929, wCBC6
; points at: wScriptStep
ScriptCommand5E_Run_Case75::
Jump_00F_48DE:: ; address name
    ld a, $40
    ld [wC928], a
    ld a, $03
    ld [wC92A], a
    jr Jump_00F_48F4

; entry 115 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC928, wC92A, wC929, wCBC6
; points at: wScriptStep
ScriptCommand5E_Run_Case73::
Jump_00F_48EA:: ; address name
    ld a, $50
    ld [wC928], a
    ld a, $01
    ld [wC92A], a

Jump_00F_48F4::
    ld a, $04
    ld [wC929], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $02
    ld [wCBC6], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 113 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC928, wC92A, wCB96, wCBA6
; points at: wScriptStep
ScriptCommand5E_Run_Case71::
Jump_00F_490E:: ; address name
    ld a, $01
    ld [wC929], a
    ld a, $40
    ld [wC928], a
    ld a, $81
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wC929], a
    ld a, $50
    ld [wC928], a
    ld a, $83
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wCB96], a
    ld [wCBA6], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 112 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC928, wC92A
; points at: wScriptStep
ScriptCommand5E_Run_Case70::
Jump_00F_4949:: ; address name
    ld a, $04
    ld [wC929], a
    ld a, $70
    ld [wC928], a
    ld a, $02
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 110 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6, wCBD3, wCBD4, wCBCF
; points at: wScriptStep
ScriptCommand5E_Run_Case6E::
Jump_00F_4968:: ; address name
    ld a, $11
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $40
    ld [wCBD3], a
    ld a, $60
    ld [wCBD4], a
    xor a, a
    ld [wCBCF], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 109 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wCBD3, wCBD4
ScriptCommand5E_Run_Case6D::
Jump_00F_4985:: ; address name
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

; entry 104 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wCB8B
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 102 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC928, wC92A
; points at: wScriptStep
ScriptCommand5E_Run_Case66::
Jump_00F_49D5:: ; address name
    ld a, $03
    ld [wC929], a
    ld a, $B0
    ld [wC928], a
    ld a, $80
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, $04
    ld [wC929], a
    ld a, $B0
    ld [wC928], a
    ld a, $80
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 101 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wCBAA, wC92C, wCBAB
; writes: wC929, wC928, wC92A, wCB9A, wCB96, wCBB6, wCBC6, wCB9B, ...
; points at: wScriptParam0, wScriptStep
ScriptCommand5E_Run_Case65::
Jump_00F_4A09:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_4A42
    ld a, $02
    ld [wC929], a
    ld a, $40
    ld [wC928], a
    ld a, $83
    ld [wC92A], a
    farcall StepObjectTowardCoord
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
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_4A42::
    ld a, $02
    ld [wC929], a
    ld a, $C0
    ld [wC928], a
    ld a, $80
    ld [wC92A], a
    farcall StepObjectTowardCoord
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
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 99 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wC928, wC929, wScriptParam0, wCB96
; points at: wCB9B, wCB9A, wScriptStep
ScriptCommand5E_Run_Case63::
Jump_00F_4A74:: ; address name
    ld a, [wScriptParam0]
    and a, $03
    jr nz, Jump_00F_4A7F
    ld hl, wCB9B
    dec [hl]

Jump_00F_4A7F::
    ld a, [wScriptParam0]
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
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    ld a, $03
    ld [wCB96], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 98 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC928, wC92A, wCB96
; points at: wScriptStep
ScriptCommand5E_Run_Case62::
Jump_00F_4AB3:: ; address name
    ld a, $01
    ld [wC929], a
    ld a, $70
    ld [wC928], a
    ld a, $00
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $01
    ld [wCB96], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 96 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCB9B, wScriptStep
ScriptCommand5E_Run_Case60::
Jump_00F_4AD7:: ; address name
    ld de, wCB9B
    call Func_00F_7EE9
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 95 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC928, wC92A, wCB96
; points at: wScriptStep
ScriptCommand5E_Run_Case5F::
Jump_00F_4AE3:: ; address name
    ld a, $03
    ld [wC929], a
    ld a, $80
    ld [wC928], a
    ld a, $02
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, $04
    ld [wC929], a
    ld a, $80
    ld [wC928], a
    ld a, $02
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wCB96], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 92 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6, wCBD3, wCBD4, wCBCF
; points at: wScriptStep
ScriptCommand5E_Run_Case5C::
Jump_00F_4B1B:: ; address name
    ld a, $11
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $40
    ld [wCBD3], a
    ld a, $30
    ld [wCBD4], a
    xor a, a
    ld [wCBCF], a
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
    call Func_00F_4FA1
    ret

; entry 86 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wCB86, wCB96, wCB9B
; writes: wCB86, wCB96, wCBA6, wCBB6, wCBAB, wCBBB, wCB8B
; points at: wCB9B, wScriptStep
ScriptCommand5E_Run_Case56::
Jump_00F_4B45:: ; address name
    ld a, [wScriptParam0]
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 85 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wCB9A
; writes: wScriptParam0, wCB9A, wCBAA, wCBBA
; points at: wScriptStep
ScriptCommand5E_Run_Case55::
Jump_00F_4B8F:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
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
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 84 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wCB96, wCB9B
; writes: wCB96, wCBA6, wCBB6, wCBAB, wCBBB
; points at: wCB9B, wScriptStep
ScriptCommand5E_Run_Case54::
Jump_00F_4BB6:: ; address name
    ld a, [wScriptParam0]
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 83 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wCB9A
; writes: wCB96, wCBA6, wCBB6, wScriptParam0, wCB9A, wCBAA, wCBBA
; points at: wScriptStep
ScriptCommand5E_Run_Case53::
Jump_00F_4BEE:: ; address name
    ld a, $03
    ld [wCB96], a
    ld [wCBA6], a
    ld [wCBB6], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
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
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 81 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6, wCBD3, wCBD4, wCBCF
; points at: wScriptStep
ScriptCommand5E_Run_Case51::
Jump_00F_4C20:: ; address name
    ld a, $11
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $40
    ld [wCBD3], a
    ld a, $20
    ld [wCBD4], a
    xor a, a
    ld [wCBCF], a
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
    call Func_00F_4FA1
    ret

; entry 75 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCBBB, wScriptStep
ScriptCommand5E_Run_Case4B::
Jump_00F_4C4A:: ; address name
    ld de, wCBBB
    call Func_00F_7EE9
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 74 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wC92C, wCBAB
; writes: wC928, wC929, wC92A, wCBB6, wCBA6, wScriptParam0
; points at: wScriptParam0, wScriptStep
ScriptCommand5E_Run_Case4A::
Jump_00F_4C56:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_4C90
    ld a, $60
    ld [wC928], a
    ld a, $02
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, $60
    ld [wC928], a
    ld a, $01
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wScriptParam0
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
    farcall StepObjectTowardCoord
    ld a, $20
    ld [wC928], a
    ld a, $01
    ld [wC929], a
    ld a, $03
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_4CDA::
    ld a, $20
    ld [wC928], a
    ld a, $02
    ld [wC929], a
    ld a, $03
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, $50
    ld [wC928], a
    ld a, $01
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wCBB6], a
    ld a, $02
    ld [wCBA6], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 72 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wC92C
; writes: wC929, wC928, wC92A, wScriptParam0
; points at: wScriptParam0, wScriptStep
ScriptCommand5E_Run_Case48::
Jump_00F_4D1B:: ; address name
    ld a, $01
    ld [wC929], a
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_4D40
    ld a, $60
    ld [wC928], a
    ld a, $80
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_4D40::
    dec a
    jr nz, Jump_00F_4D5D
    ld a, $40
    ld [wC928], a
    ld a, $81
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_4D5D::
    ld a, $B0
    ld [wC928], a
    ld a, $80
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 69 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCB9B, wScriptStep
ScriptCommand5E_Run_Case45::
Jump_00F_4D7B:: ; address name
    ld de, wCB9B
    call Func_00F_7EE9
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 67 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wC92C
; writes: wC929, wC928, wC92A, wScriptParam0
; points at: wScriptParam0, wScriptStep
ScriptCommand5E_Run_Case43::
Jump_00F_4D87:: ; address name
    ld a, $01
    ld [wC929], a
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_4DAC
    ld a, $60
    ld [wC928], a
    ld a, $02
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_4DAC::
    dec a
    jr nz, Jump_00F_4DC9
    ld a, $20
    ld [wC928], a
    ld a, $03
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_4DC9::
    ld a, $50
    ld [wC928], a
    ld a, $02
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 66 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6, wCBD3, wCBD4, wCBCF, wScriptParam0
; points at: wScriptStep
ScriptCommand5E_Run_Case42::
Jump_00F_4DE7:: ; address name
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
    call Func_00F_4FA1
    ret

; entry 60 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCBAA
; writes: wCBA6, wCBAA
; points at: wCBAB, wScriptStep
ScriptCommand5E_Run_Case3C::
Jump_00F_4E15:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 59 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC928, wC92A, wCB86
; points at: wScriptStep
ScriptCommand5E_Run_Case3B::
Jump_00F_4E31:: ; address name
    ld a, $02
    ld [wC929], a
    ld a, $60
    ld [wC928], a
    jr Jump_00F_4EB0

; entry 58 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC929, wC928, wC92A, wCB96, wCBAB
; points at: wCB9A, wCB9B, wScriptStep
ScriptCommand5E_Run_Case3A::
Jump_00F_4E3D:: ; address name
    ld a, $00
    ld [wC929], a
    ld a, $E0
    ld [wC928], a
    ld a, $83
    ld [wC92A], a
    farcall StepObjectTowardCoord
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 57 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC928, wC92A, wCB86
; points at: wScriptStep
ScriptCommand5E_Run_Case39::
Jump_00F_4E70:: ; address name
    ld a, $00
    ld [wC929], a
    ld a, $E0
    ld [wC928], a
    ld a, $83
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wC929], a
    ld a, $60
    ld [wC928], a
    jr Jump_00F_4EB0

; entry 56 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCB9B
; points at: wCB8A, wCB8B, wScriptStep
ScriptCommand5E_Run_Case38::
Jump_00F_4E91:: ; address name
    ld hl, wCB8A
    dec [hl]
    ld de, wCB8B
    call Func_00F_7EE9
    ret nc
    ld a, $30
    ld [wCB9B], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 55 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC928, wC92A, wCB86
; points at: wScriptStep
ScriptCommand5E_Run_Case37::
Jump_00F_4EA6:: ; address name
    ld a, $00
    ld [wC929], a
    ld a, $60
    ld [wC928], a

Jump_00F_4EB0::
    ld a, $80
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $03
    ld [wCB86], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 54 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCB8B
; points at: wScriptStep
ScriptCommand5E_Run_Case36::
Jump_00F_4ECA:: ; address name
    ld b, $5A
    call StepWC921Counter_Bank0F
    ret nc
    ld a, $30
    ld [wCB8B], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 53 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6, wCBD3, wCBD4, wCBCF
; points at: wScriptStep
ScriptCommand5E_Run_Case35::
Jump_00F_4EDA:: ; address name
    ld a, $11
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $30
    ld [wCBD3], a
    ld a, $60
    ld [wCBD4], a
    xor a, a
    ld [wCBCF], a
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
    call Func_00F_4FA1
    ret

; entry 49 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wCBCF, wScriptParam0
; points at: wCBD4, wScriptStep
ScriptCommand5E_Run_Case31::
Jump_00F_4F06:: ; address name
    ld a, $80
    ld [wCBCF], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $01
    jr z, Jump_00F_4F1A
    ld hl, wCBD4
    dec [hl]

Jump_00F_4F1A::
    ld a, [wScriptParam0]
    cp a, $40
    ret nz
    xor a, a
    ld [wCBCF], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 47 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wCBB6
; writes: wCBB6, wCBC6
; points at: wCBAB, wScriptStep
ScriptCommand5E_Run_Case2F::
Jump_00F_4F2D:: ; address name
    ld a, [wScriptParam0]
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 46 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wCBB6
; writes: wCBB6, wCBC6
; points at: wScriptStep
ScriptCommand5E_Run_Case2E::
Jump_00F_4F54:: ; address name
    ld a, [wScriptParam0]
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 45 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6, wCBD3, wCBD4, wCBCF, wScriptParam0
; points at: wScriptStep
ScriptCommand5E_Run_Case2D::
Jump_00F_4F72:: ; address name
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
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 44 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: wC90F, hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6, wCBCF
ScriptCommand5E_Run_Case2C::
Jump_00F_4F93:: ; address name
    ld a, $01
    ld [wC90F], a
    ld a, $26
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a

; 6 call sites from 6 routines (e.g. ScriptCommand5E_Run_Case7E, ScriptCommand5E_Run_Case6D, ScriptCommand5E_Run_Case5B, ScriptCommand5E_Run_Case50, ...)
; reads: hPlayerY
; writes: wC8C8, wC8C9, wC8C6, wCBCF
Func_00F_4FA1::
    ld a, $E0
    ld [wC8C8], a
    ldh a, [hPlayerY]
    ld [wC8C9], a
    ld a, $04
    ld [wC8C6], a
    farcall ScriptStartFadeAndAdvanceStep
    xor a, a
    ld [wCBCF], a
    ret

; entry 41 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC90F, wCBCF
; points at: wScriptStep
ScriptCommand5E_Run_Case29::
Jump_00F_4FBB:: ; address name
    ld a, $01
    ld [wC90F], a
    ld hl, $053A
    call StoreHLInWC924_B0F
    xor a, a
    ld [wCBCF], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 37 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC90F, hFFC6, wCBCF, wC92D
; points at: wScriptStep
ScriptCommand5E_Run_Case25::
Jump_00F_4FCF:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 35 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wC92C
; writes: wC90F, wC928, hPlayerFacing
; points at: wScriptStep
ScriptCommand5E_Run_Case23::
Jump_00F_4FF1:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 33 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC933
; writes: wCB86, wC90F, wC6FD, hFF8D
; points at: wScriptStep
ScriptCommand5E_Run_Case21::
Jump_00F_5020:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 27 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC92A, wC928
; points at: wScriptStep
ScriptCommand5E_Run_Case1B::
Jump_00F_503E:: ; address name
    ld a, $00
    ld [wC929], a
    ld a, $00
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 26 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC92A, wC928
; points at: wScriptStep
ScriptCommand5E_Run_Case1A::
Jump_00F_505D:: ; address name
    ld a, $00
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    ld a, $20
    ld [wC928], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 24 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC90F
; points at: hPlayerY
ScriptCommand5E_Run_Case18::
Jump_00F_507C:: ; address name
    xor a, a
    ld [wC90F], a
    ld de, hPlayerY
    call Func_00F_7F0B
    ret

; entry 22 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC90F
; points at: wScriptStep
ScriptCommand5E_Run_Case16::
Jump_00F_5087:: ; address name
    ld a, $01
    ld [wC90F], a
    ld hl, $0537
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 19 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC90D, wC90E, wC90F
; points at: wScriptStep
ScriptCommand5E_Run_Case13::
Jump_00F_5097:: ; address name
    ld a, $0C
    ld [wC90D], a
    xor a, a
    ld [wC90E], a

; entry 25 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC90F
; points at: wScriptStep
ScriptCommand5E_Run_Case19::
Jump_00F_50A0:: ; address name
    xor a, a
    ld [wC90F], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 16 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC90F
; points at: wScriptStep
ScriptCommand5E_Run_Case10::
Jump_00F_50A9:: ; address name
    xor a, a
    ld [wC90F], a
    ld hl, $0DF7
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 15 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand5E_Run_Case0F::
Jump_00F_50B8:: ; address name
    ld b, $0F
    call Func_00F_72A0
    ret

; entry 13 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCB9B, wCBCF
; points at: wScriptStep
ScriptCommand5E_Run_Case0D::
Jump_00F_50BE:: ; address name
    ld a, $30
    ld [wCB9B], a
    xor a, a
    ld [wCBCF], a
    farcall Func_05F_6E09
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand5E_Run_Case0C::
Jump_00F_50D2:: ; address name
    farcall Func_05F_7363
    ret

; entry 11 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6, wCCE9, wC92D
ScriptCommand5E_Run_Case0B::
Jump_00F_50D9:: ; address name
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
    farcall ScriptStartFadeAndAdvanceStep
    ld hl, $0533
    call StoreHLInWC924_B0F
    xor a, a
    ld [wC92D], a
    ret

; entry 9 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand5E_Run_Case09::
Jump_00F_5108:: ; address name
    ld hl, $055B
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand5E_Run_Case07::
Jump_00F_5113:: ; address name
    ld hl, $055A
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCB8B, wScriptStep
ScriptCommand5E_Run_Case06::
Jump_00F_511E:: ; address name
    ld hl, wCB8B
    inc [hl]

; entry 3 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCB8B, wScriptStep
ScriptCommand5E_Run_Case03::
Jump_00F_5122:: ; address name
    ld de, wCB8B
    call Func_00F_7EE9
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, wC92C
; writes: wC928, wCB8B, wC1C8, wC1C9
; points at: wScriptStep
ScriptCommand5E_Run_Case02::
Jump_00F_512E:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand5E_Run_Case01::
Jump_00F_516A:: ; address name
    ld b, $3C
    call StepWC921Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6, wCC3C
; writes: hFFC6, hFFC7, wSpriteSlotCount, wCC3C
; points at: wScriptStep
ScriptCommand5E_Run_Case00::
Jump_00F_5175:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret
    INCBIN "dwm2-cobi-us.gbc", $03D19F, $78

; entry 40 of the `rst $00` table in ScriptCommand5E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1
; writes: wC90F, wCBCF
ScriptCommand5E_Run_Case28::
Jump_00F_5217:: ; address name
    xor a, a
    ld [wC90F], a
    ld a, $80
    ld [wCBCF], a
    ld a, [wScriptParam1]
    and a, $0F
    rst $00
    dw Func_00F_4FA1_Case00
    dw Func_00F_4FA1_Case01

; entry 0 of the `rst $00` table in Func_00F_4FA1
; no direct call (reached through a table, a jump or a vector)
; reads: wC92D, wScriptParam1
; writes: wC92D, wCBD4, wCBD3
; points at: wScriptParam1
Func_00F_4FA1_Case00::
Jump_00F_522A:: ; address name
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
    ld a, [wScriptParam1]
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
    ld hl, wScriptParam1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_00F_4FA1
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1
; writes: wC92D, wScriptParam1
; points at: wScriptStep
Func_00F_4FA1_Case01::
Jump_00F_526C:: ; address name
    ld a, [wScriptParam1]
    add a, $10
    and a, $F0
    cp a, $80
    jr nz, Jump_00F_5280
    xor a, a
    ld [wC92D], a
    ld hl, wScriptStep
    inc [hl]
    xor a, a

Jump_00F_5280::
    ld [wScriptParam1], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $03D284, $180

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
; reads: wCC37, wC836
; writes: hFFC6, wCC37, hFFC7, wC836, wScriptStartRequest
ScriptCommand58_Run_Case2B::
Jump_00F_5460:: ; address name
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
    ld [wScriptStartRequest], a
    ret

; entry 42 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; points at: hPlayerY
ScriptCommand58_Run_Case2A::
Jump_00F_5495:: ; address name
    ld de, hPlayerY
    ld hl, $0A7E
    call Func_00F_7F24
    ret

; entry 40 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC92A, wC928, wSpriteSlotCount
; points at: wScriptStep
ScriptCommand58_Run_Case28::
Jump_00F_549F:: ; address name
    ld a, $01
    ld [wC929], a
    ld a, $81
    ld [wC92A], a
    ld a, $B0
    ld [wC928], a
    farcall StepObjectTowardCoord
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 38 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand58_Run_Case26::
Jump_00F_54D5:: ; address name
    ld hl, $0A7C
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 34 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC527
; points at: wScriptStep
ScriptCommand58_Run_Case22::
Jump_00F_54E0:: ; address name
    farcall Func_012_64F8
    farcall Func_002_5E85
    farcall Func_002_5E85
    call LoadRecordListNameTiles
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    ld hl, $0A7B
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 30 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6
ScriptCommand58_Run_Case1E::
Jump_00F_550B:: ; address name
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
    farcall ScriptStartFadeAndAdvanceStep
    ld hl, $0A7A
    call StoreHLInWC924_B0F
    ret

; entry 28 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand58_Run_Case1C::
Jump_00F_5538:: ; address name
    ld hl, $0491
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 26 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand58_Run_Case1A::
Jump_00F_5543:: ; address name
    ld hl, $0490
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 24 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCBAB
ScriptCommand58_Run_Case18::
Jump_00F_554E:: ; address name
    ld de, wCBAB
    ld hl, $048F
    call Func_00F_7F24
    ret

; entry 23 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wCB86
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
    ld [wCB86], a
    ld b, $B4
    call StepWC921Counter_Bank0F
    ret nc
    xor a, a
    ld [wCB86], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 22 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCC3B, hPlayerX, hPlayerY
; writes: wCC3B, wC8C8, wC8C9, wC8C6, wModeState, wC8C5
; points at: wScriptStep
ScriptCommand58_Run_Case16::
Jump_00F_5577:: ; address name
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
    farcall Func_012_653F
    ret

; entry 32 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; points at: wC49F, wC0F0, wScriptStep
ScriptCommand58_Run_Case20::
Jump_00F_55B3:: ; address name
    ld a, $7A
    call QueueSoundEffect

; entry 20 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; points at: wC49F, wC0F0, wScriptStep
ScriptCommand58_Run_Case14::
Jump_00F_55B8:: ; address name
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_00F_55CA
    ld hl, wC49F
    ld de, wC0F0
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
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 16 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand58_Run_Case10::
Jump_00F_55DA:: ; address name
    ld hl, $048D
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 14 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo, hPlayerY, wCBD4
; writes: wCBCF, wCBD4
; points at: wScriptStep
ScriptCommand58_Run_Case0E::
Jump_00F_55E5:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC552, hPlayerX
; writes: hFFC6, wCBD3, wCBD4
; points at: wC48A, wScriptStep
ScriptCommand58_Run_Case0C::
Jump_00F_5612:: ; address name
    ld a, [wC552]
    or a, a
    jr z, Jump_00F_5623
    ld hl, wC48A
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand58_Run_Case0A::
Jump_00F_5642:: ; address name
    ld hl, $4487
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 8 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCB8B
ScriptCommand58_Run_Case08::
Jump_00F_564D:: ; address name
    ld de, wCB8B
    ld hl, $0486
    call Func_00F_7F24
    ret

; entry 6 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand58_Run_Case06::
Jump_00F_5657:: ; address name
    ld hl, $0485
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wCBBB, wCB9B, wCB86
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
    ld [wCBBB], a
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand58_Run_Case02::
Jump_00F_56B1:: ; address name
    ld hl, $0483
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand58_Run_Case01::
Jump_00F_56BC:: ; address name
    ld b, $78
    call Func_00F_72A0
    ret

; entry 0 of the `rst $00` table in ScriptCommand58_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand58_Run_Case00::
Jump_00F_56C2:: ; address name
    farcall Func_05F_6E09
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
; reads: hFFC6
; writes: hFFC7, hFFC6, wScriptStartRequest
ScriptCommand4E_Run_Case04::
Jump_00F_56DB:: ; address name
    ld a, $40
    ldh [hFFC7], a
    ld a, $01
    ldh [hFFC6], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommand4E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC552
; points at: wScriptStep
ScriptCommand4E_Run_Case02::
Jump_00F_56F3:: ; address name
    ld hl, wScriptStep
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

; entry 0 of the `rst $00` table in ScriptCommand4E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wCB9B, wSpriteSlotCount, wScriptParam0, wScriptStep
; points at: wScriptStep
ScriptCommand4E_Run_Case00::
Jump_00F_5717:: ; address name
    ld a, $40
    ld [wCB9B], a
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
    call StepWC921Counter_Bank0F
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
    call StoreHLInWC924_B0F
    ld a, $03
    ld [wScriptStep], a
    ret

Jump_00F_5791::
    ld hl, $040D
    call StoreHLInWC924_B0F
    ld a, $03
    ld [wScriptStep], a
    ret

Jump_00F_579D::
    ld de, $00A0
    call TestFlagBit
    jr c, Jump_00F_57B0
    ld hl, $4415
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_57B0::
    ld hl, $4418
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_57BB::
    ld hl, $4419
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_57C6::
    ld hl, $0416
    call StoreHLInWC924_B0F
    ld a, $03
    ld [wScriptStep], a
    ret

Jump_00F_57D2::
    ld hl, $0452
    call StoreHLInWC924_B0F
    ld a, $03
    ld [wScriptStep], a
    ret

Jump_00F_57DE::
    ld hl, $0493
    call StoreHLInWC924_B0F
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
; reads: wCC37
; writes: hFFC6, wCC37, wScriptStartRequest
ScriptCommand4B_Run_Case16::
Jump_00F_581C:: ; address name
    ld de, $0023
    call SetFlagBit
    ld a, $04
    ldh [hFFC6], a
    farcall Func_05F_6DAC
    ld a, [wCC37]
    set 3, a
    ld [wCC37], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 20 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wCBD4
; writes: wCBD4, wCBCF
; points at: wScriptStep
ScriptCommand4B_Run_Case14::
Jump_00F_583A:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 19 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerFacing, hPlayerX, hPlayerY
; writes: wCB86, hFFC6, wCBD3, wCBD4, wCBCF
; points at: wScriptStep
ScriptCommand4B_Run_Case13::
Jump_00F_585B:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 18 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand4B_Run_Case12::
Jump_00F_5889:: ; address name
    farcall Func_05F_7363
    ret

; entry 17 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6, wCCE9, wC92D
; points at: hFF8C
ScriptCommand4B_Run_Case11::
Jump_00F_5890:: ; address name
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
    farcall ScriptStartFadeAndAdvanceStep
    ld hl, $02A7
    call StoreHLInWC924_B0F
    xor a, a
    ld [wC92D], a
    ld hl, hFF8C
    call ClearBit2AtHL_Bank0F
    ret

; entry 15 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand4B_Run_Case0F::
Jump_00F_58C5:: ; address name
    xor a, a
    call Func_00F_7F75
    ret nc
    ld hl, $0A0A
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 14 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand4B_Run_Case0E::
Jump_00F_58D5:: ; address name
    xor a, a
    call Func_00F_7F75
    ret nc
    ld hl, $0A09
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCB8B
; points at: wCB8B, wScriptStep
ScriptCommand4B_Run_Case0D::
Jump_00F_58E5:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 11 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wCBAB, wSpriteSlotCount
; points at: wScriptStep
ScriptCommand4B_Run_Case0B::
Jump_00F_5906:: ; address name
    ld a, $18
    ld [wCBAB], a
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
    call StepWC921Counter_Bank0F
    ret nc
    ld a, $03
    ld [wSpriteSlotCount], a
    ld hl, $0A07
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C9
ScriptCommand4B_Run_Case0A::
Jump_00F_594A:: ; address name
    ld a, $49
    ldh [hMapId], a
    ld a, $00
    ldh [hMapScreenX], a
    ld a, $00
    ldh [hMapScreenY], a
    ld a, $40
    ld [wC8C9], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; entry 8 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCC3A
; writes: wCC3A
ScriptCommand4B_Run_Case08::
Jump_00F_5962:: ; address name
    ld a, [wCC3A]
    set 1, a
    ld [wCC3A], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; entry 6 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6
ScriptCommand4B_Run_Case06::
Jump_00F_5971:: ; address name
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
    farcall ScriptStartFadeAndAdvanceStep
    ret

; entry 3 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF
; points at: wCBD4, wScriptStep
ScriptCommand4B_Run_Case03::
Jump_00F_5993:: ; address name
    ld hl, wCBD4
    dec [hl]
    ld de, wCBD4
    call Func_00F_7EE9
    ret nc
    xor a, a
    ld [wCBCF], a
    ld hl, $0DCA
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand4B_Run_Case02::
Jump_00F_59AD:: ; address name
    ld b, $3C
    call StepWC921Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCBD4, wScriptStep
ScriptCommand4B_Run_Case01::
Jump_00F_59B8:: ; address name
    ld hl, wCBD4
    dec [hl]
    ld de, wCBD4
    call Func_00F_7EE9
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand4B_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, hPlayerY
; writes: hFFC6, wCBD3, wCBD4, wCBCF
; points at: wScriptStep
ScriptCommand4B_Run_Case00::
Jump_00F_59C8:: ; address name
    ld a, $10
    ldh [hFFC6], a
    farcall Func_012_6B98
    ldh a, [hPlayerX]
    ld [wCBD3], a
    ldh a, [hPlayerY]
    ld [wCBD4], a
    ld a, $80
    ld [wCBCF], a
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
    call StoreHLInWC924_B0F
    ld de, $01E4
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 8 of the `rst $00` table in ScriptCommand4A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, hFFC6
; writes: hFFC7, hFFC6
; points at: wScriptStep
ScriptCommand4A_Run_Case08::
Jump_00F_5A13:: ; address name
    ld a, [wScriptParam1]
    ldh [hFFC7], a
    ld a, $01
    ldh [hFFC6], a
    farcall Func_05F_6BF8
    ldh a, [hFFC6]
    or a, a
    ret z
    ld hl, $0DDF
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommand4A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCB9B
; writes: wScriptParam1
; points at: wScriptStep
ScriptCommand4A_Run_Case06::
Jump_00F_5A31:: ; address name
    ld hl, $0A04
    call StoreHLInWC924_B0F
    ld a, [wCB9B]
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in ScriptCommand4A_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6
; points at: wScriptStep
ScriptCommand4A_Run_Case05::
Jump_00F_5A42:: ; address name
    xor a, a
    call Func_00F_7F75
    ret nc
    ld a, $19
    ldh [hFFC6], a
    farcall Func_00A_47A4
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand4A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC552
; writes: wScriptStep
; points at: wScriptStep
ScriptCommand4A_Run_Case04::
Jump_00F_5A56:: ; address name
    ld a, [wC552]
    or a, a
    jr nz, Jump_00F_5A67
    ld hl, vTiles1 + $5D0
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_5A67::
    ld hl, vTiles1 + $5D1
    call StoreHLInWC924_B0F
    ld a, $0B
    ld [wScriptStep], a
    ret

; entry 2 of the `rst $00` table in ScriptCommand4A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wCB9B
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand4A_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand4A_Run_Case01::
Jump_00F_5AB2:: ; address name
    farcall Func_012_653F
    ret

; entry 0 of the `rst $00` table in ScriptCommand4A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wScriptParam1, wScriptStep
; points at: wC49F, wC0F0, wScriptStep
ScriptCommand4A_Run_Case00::
Jump_00F_5AB9:: ; address name
    ld de, $01E3
    call TestFlagBit
    jr nc, Jump_00F_5AD2
    ld hl, $0A03
    call StoreHLInWC924_B0F
    ld a, $01
    ld [wScriptParam1], a
    ld a, $05
    ld [wScriptStep], a
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
; writes: wCB86
; points at: wScriptStep
ScriptCommand66_Run_Case0E::
Jump_00F_5B17:: ; address name
    xor a, a
    ld [wCB86], a
    ld hl, $0AF5
    call StoreHLInWC924_B0F
    ld de, $01E2
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in ScriptCommand66_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCB96
; points at: wCB9B
ScriptCommand66_Run_Case0C::
Jump_00F_5B2C:: ; address name
    ld a, $02
    ld [wCB96], a
    ld de, wCB9B
    ld hl, $0AF4
    call Func_00F_7F24
    ret

; entry 10 of the `rst $00` table in ScriptCommand66_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCB86, wCB81
; points at: wScriptStep
ScriptCommand66_Run_Case0A::
Jump_00F_5B3B:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 8 of the `rst $00` table in ScriptCommand66_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6
; writes: hFFC6, hFFC7, wSpriteSlotCount, wCB96
; points at: wScriptStep
ScriptCommand66_Run_Case08::
Jump_00F_5B5F:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommand66_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand66_Run_Case06::
Jump_00F_5B86:: ; address name
    ld hl, $0AF0
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in ScriptCommand66_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6
; points at: wScriptStep
ScriptCommand66_Run_Case05::
Jump_00F_5B91:: ; address name
    xor a, a
    call Func_00F_7F75
    ret nc
    ld a, $04
    ldh [hFFC6], a
    farcall Func_00A_47A4
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand66_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC552
; writes: wScriptStep
; points at: wScriptStep
ScriptCommand66_Run_Case04::
Jump_00F_5BA5:: ; address name
    ld a, [wC552]
    or a, a
    jr nz, Jump_00F_5BB6
    ld hl, vTiles1 + $5CE
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_5BB6::
    ld hl, vTiles1 + $5CF
    call StoreHLInWC924_B0F
    ld a, $0F
    ld [wScriptStep], a
    ret

; entry 2 of the `rst $00` table in ScriptCommand66_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wCBAB, wSpriteSlotCount
; points at: wScriptStep
ScriptCommand66_Run_Case02::
Jump_00F_5BC2:: ; address name
    ld a, $20
    ld [wCBAB], a
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
    call StepWC921Counter_Bank0F
    ret nc
    ld a, $03
    ld [wSpriteSlotCount], a
    ld hl, $4AEE
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand66_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6, wScriptStep
; points at: wScriptStep
ScriptCommand66_Run_Case00::
Jump_00F_5C06:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_5C2F::
    ld hl, $0AEF
    call StoreHLInWC924_B0F
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
; reads: wCB9B, hPlayerY, wC92C
; writes: wC929, wC92A, wC928, hPlayerFacing, wCB96, wScriptStartRequest
ScriptCommand49_Run_Case03::
Jump_00F_5C47:: ; address name
    ld a, [wCB9B]
    cp a, $40
    jr z, Jump_00F_5C65
    ld a, $01
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall StepObjectTowardCoord
    jr Jump_00F_5C7A

Jump_00F_5C65::
    ld a, $01
    ld [wC929], a
    ld a, $01
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    farcall StepObjectTowardCoord

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
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommand49_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCB9A, hPlayerY, wC92C
; writes: wC929, wC92A, wC928
; points at: wScriptStep
ScriptCommand49_Run_Case02::
Jump_00F_5CA9:: ; address name
    ld a, [wCB9A]
    cp a, $30
    jr z, Jump_00F_5CC7
    ld a, $01
    ld [wC929], a
    ld a, $03
    ld [wC92A], a
    ld a, $30
    ld [wC928], a
    farcall StepObjectTowardCoord
    jr Jump_00F_5CDC

Jump_00F_5CC7::
    ld a, $01
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall StepObjectTowardCoord

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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand49_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC468
; points at: wScriptStep
ScriptCommand49_Run_Case01::
Jump_00F_5D03:: ; address name
    farcall UpdatePlayerMovement
    farcall Func_002_5BD7
    ld a, [wC468]
    bit 7, a
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand49_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCB8A, hPlayerX, wC92C, hFF8C
; writes: wC929, wC92A, wC928, wC468, wC46A, hFF8C, hFF9D, hFF9E
; points at: hMapScreenY, hFF80, wScriptStep
ScriptCommand49_Run_Case00::
Jump_00F_5D1A:: ; address name
    ld a, [wCB8A]
    cp a, $50
    jr z, Jump_00F_5D38
    ld a, $00
    ld [wC929], a
    ld a, $03
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    farcall StepObjectTowardCoord
    jr Jump_00F_5D4D

Jump_00F_5D38::
    ld a, $00
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    ld a, $E0
    ld [wC928], a
    farcall StepObjectTowardCoord

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
    call StoreHLInWC924_B0F
    ld de, $009D
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in ScriptCommand48_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6
; writes: hFFC6, hFFC7
; points at: wSpriteSlotCount, wScriptStep
ScriptCommand48_Run_Case09::
Jump_00F_5DCC:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in ScriptCommand48_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand48_Run_Case07::
Jump_00F_5DED:: ; address name
    ld hl, $0AD4
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommand48_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6
; points at: wScriptStep
ScriptCommand48_Run_Case06::
Jump_00F_5DF8:: ; address name
    ld a, $18
    ldh [hFFC6], a
    farcall Func_00A_47A4
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand48_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6, wC552
; writes: hFFC6, wScriptStep
; points at: wScriptStep
ScriptCommand48_Run_Case04::
Jump_00F_5E07:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_5E2E::
    ld hl, vTiles1 + $5CD
    call StoreHLInWC924_B0F
    ld a, $0C
    ld [wScriptStep], a
    ret

; entry 2 of the `rst $00` table in ScriptCommand48_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1
; writes: wScriptStep
; points at: wCB8B, wScriptStep
ScriptCommand48_Run_Case02::
Jump_00F_5E3A:: ; address name
    ld a, [wScriptParam1]
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
    ld hl, wScriptStep
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
    ld [wScriptStep], a
    ret

; entry 1 of the `rst $00` table in ScriptCommand48_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wCB96, wCB86, wCB9A, wCB9B, hPlayerY, wC6FD, wC8F6
; writes: wC928, wC929, wScriptParam0, wCB96, wCBA6, wCBAA, wCBAB, wCB9A, ...
; points at: wCB9A, wCB9B, wScriptStep
ScriptCommand48_Run_Case01::
Jump_00F_5E70:: ; address name
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
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    jr nz, Jump_00F_5E9D
    ld a, [wCB96]
    inc a
    and a, $03
    ld [wCB96], a

Jump_00F_5E9D::
    ld a, [wScriptParam0]
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
    ld a, [wC6FD]
    dec a
    ret z
    ld a, [wC8F6]
    cp a, $20
    ret nz

Jump_00F_5EE2::
    ld a, $01
    ld [wScriptParam1], a
    ret

; entry 0 of the `rst $00` table in ScriptCommand48_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCB9A, wCB9B
; writes: wScriptStep
; points at: wScriptStep
ScriptCommand48_Run_Case00::
Jump_00F_5EE8:: ; address name
    ld a, [wCB9A]
    cp a, $80
    jr nz, Jump_00F_5F00
    ld a, [wCB9B]
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
    farcall Func_05F_70D2
    ret

; entry 14 of the `rst $00` table in ScriptCommand46_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC92D, wScriptParam0
; points at: wScriptStep
ScriptCommand46_Run_Case0E::
Jump_00F_5F3D:: ; address name
    xor a, a
    ld [wC92D], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in ScriptCommand46_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC928
; points at: wScriptStep
ScriptCommand46_Run_Case0C::
Jump_00F_5F4A:: ; address name
    ld a, $40
    ld [wC928], a
    farcall Func_05F_6AEB
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, $03A1
    call StoreHLInWC924_B0F
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

; entry 10 of the `rst $00` table in ScriptCommand46_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC92A, wC928
; points at: hFF8C, wScriptStep
ScriptCommand46_Run_Case0A::
Jump_00F_5F8E:: ; address name
    ld a, $02
    ld [wC929], a
    ld a, $00
    ld [wC92A], a
    ld a, $A0
    ld [wC928], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, hFF8C
    call SetBit2AtHL_B0F
    farcall Func_002_6050
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in ScriptCommand46_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCBAB
ScriptCommand46_Run_Case09::
Jump_00F_5FB9:: ; address name
    ld de, wCBAB
    call Func_00F_7F0B
    ret

; entry 7 of the `rst $00` table in ScriptCommand46_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCBA6
; points at: wCBAC, wScriptStep
ScriptCommand46_Run_Case07::
Jump_00F_5FC0:: ; address name
    ld a, $02
    ld [wCBA6], a
    ld hl, wCBAC
    call ClearBit2AtHL_Bank0F
    ld hl, $03A0
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand46_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCBA6
; points at: wCBAC, wScriptStep
ScriptCommand46_Run_Case04::
Jump_00F_5FD6:: ; address name
    ld b, $4B
    call StepWC921Counter_Bank0F
    ret nc
    ld a, $01
    ld [wCBA6], a
    ld hl, wCBAC
    call ClearBit1AtHL_Bank0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in ScriptCommand46_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCBAC, wScriptStep
ScriptCommand46_Run_Case03::
Jump_00F_5FEC:: ; address name
    ld hl, wCBAC
    call SetBit2AtHL_B0F
    ld b, $1E
    call StepWC921Counter_Bank0F
    ret nc
    ld hl, wCBAC
    call SetBit1AtHL_Bank0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand46_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCBA6
; points at: wCBAC, wScriptStep
ScriptCommand46_Run_Case02::
Jump_00F_6003:: ; address name
    ld b, $4B
    call StepWC921Counter_Bank0F
    ret nc
    ld a, $03
    ld [wCBA6], a
    ld hl, wCBAC
    call ClearBit1AtHL_Bank0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand46_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo, wScriptParam0
; writes: wCBA6, wC928, wC929, wScriptParam0
; points at: wCBAC, wCBAB, wCBAA, wScriptStep
ScriptCommand46_Run_Case01::
Jump_00F_6019:: ; address name
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
    ld a, [wScriptParam0]
    and a, $01
    jr nz, Jump_00F_6049
    ld hl, wCBAA
    inc [hl]

Jump_00F_6049::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    xor a, a
    ld [wCBA6], a
    ld hl, wCBAC
    call SetBit1AtHL_Bank0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand46_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wC92C
; writes: wC929, wC92A, wC928, wScriptParam0
; points at: wScriptParam0, wScriptStep
ScriptCommand46_Run_Case00::
Jump_00F_6066:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_608E
    ld a, $02
    ld [wC929], a
    ld a, $01
    ld [wC92A], a
    ld a, $70
    ld [wC928], a
    farcall StepObjectTowardCoord
    call ScriptCommand46_Run_Case00_Sub01
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wScriptParam0
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
    farcall StepObjectTowardCoord
    call ScriptCommand46_Run_Case00_Sub01
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_00F_60B3::
    ld a, $02
    ld [wC929], a
    ld a, $01
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall StepObjectTowardCoord
    call ScriptCommand46_Run_Case00_Sub01
    ld a, [wC92C]
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
; writes: wCBA6
ScriptCommand46_Run_Case00_Sub01::
Func_00F_60D9:: ; address name
    ld a, [wFrameCounterLo]
    srl a
    srl a
    and a, $03
    ld [wCBA6], a
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
; reads: wCBD4
; writes: wCBD4, wCBA1, hFFC6, hFFC7, hFFC8, hFFC9, hFFCA, hFFCB, ...
ScriptCommand41_Run_Case09::
Jump_00F_60FE:: ; address name
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
    ld [wScriptStartRequest], a
    ret

; entry 8 of the `rst $00` table in ScriptCommand41_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand41_Run_Case08::
Jump_00F_613A:: ; address name
    ld b, $0F
    call Func_00F_72A0
    ret

; entry 7 of the `rst $00` table in ScriptCommand41_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCB8A
ScriptCommand41_Run_Case07::
Jump_00F_6140:: ; address name
    ld a, $E0
    ld [wCB8A], a
    farcall Func_012_653F
    ret

; entry 6 of the `rst $00` table in ScriptCommand41_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerY, wIsCGB
; writes: wScriptParam0, hPlayerY, wC8F1, wC8F6, wC8FB, hFFC6
; points at: hFF8C, wC49F, wC0F0, wScriptStep
ScriptCommand41_Run_Case06::
Jump_00F_614C:: ; address name
    ld hl, hFF8C
    call SetBit2AtHL_B0F
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
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
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in ScriptCommand41_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6
; points at: wScriptStep
ScriptCommand41_Run_Case03::
Jump_00F_61A8:: ; address name
    xor a, a
    call Func_00F_7F75
    ret nc
    ld a, $03
    ldh [hFFC6], a
    farcall Func_00A_47A4
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand41_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wC928, wC929, wScriptParam0
; points at: hPlayerY, wC8F1, wC8F6, wC8FB, wScriptStep
ScriptCommand41_Run_Case02::
Jump_00F_61BC:: ; address name
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
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    ld hl, $0346
    call StoreHLInWC924_B0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand41_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC928, wC929, wC92A
; points at: wScriptStep
ScriptCommand41_Run_Case01::
Jump_00F_622E:: ; address name
    ld a, $20
    ld [wC928], a
    ld a, $00
    ld [wC929], a
    ld a, $80
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
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
    farcall Func_05F_6E09
    ld de, $0085
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_00F_626B::
    ld hl, $0347
    call StoreHLInWC924_B0F
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
; reads: hFFC6
; writes: hFFC6, hFFC7, wCB8B, wScriptStartRequest
ScriptCommand45_Run_Case03::
Jump_00F_6283:: ; address name
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
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommand45_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6
; points at: wScriptStep
ScriptCommand45_Run_Case02::
Jump_00F_62A0:: ; address name
    ld a, $0C
    ldh [hFFC6], a
    farcall Func_00A_47A4
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand45_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand45_Run_Case01::
Jump_00F_62AF:: ; address name
    ld b, $1E
    call StepWC921Counter_Bank0F
    ret nc
    ld de, $0093
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand45_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCBA6, wScriptParam0
; writes: wCB86, wCB8B, wCBAB
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
    ld a, [wCBA6]
    ld [wCB86], a
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
; reads: wCB9B, wCB9A
; writes: wC928, wC929, wC92A, wCB9A, wCB96, wScriptStartRequest
; points at: wCB9C
ScriptCommand43_Run_Case0C::
Jump_00F_633D:: ; address name
    ld a, [wCB9B]
    cp a, $50
    jr z, Jump_00F_635A
    ld a, $50
    ld [wC928], a
    ld a, $01
    ld [wC929], a
    ld a, $80
    ld [wC92A], a
    farcall StepObjectTowardCoord
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
    ld [wScriptStartRequest], a
    ret

; entry 10 of the `rst $00` table in ScriptCommand43_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wScriptParam1, wCC3A
; writes: wC928, wC929, wScriptParam0, wCC3A, wC19E, wC19F, wC1B2, wC1B3, ...
; points at: wCB9B, wScriptStep
ScriptCommand43_Run_Case0A::
Jump_00F_6383:: ; address name
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
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    ld a, [wScriptParam1]
    cp a, $30
    jr z, Jump_00F_63BD
    ld hl, $0362
    call StoreHLInWC924_B0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
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
    ld [wScriptStartRequest], a
    ret

; entry 9 of the `rst $00` table in ScriptCommand43_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C, wScriptParam1
; writes: wC928, wC929, wC92A
; points at: wScriptStep
ScriptCommand43_Run_Case09::
Jump_00F_63E5:: ; address name
    ld a, $00
    ld [wC928], a
    ld a, $01
    ld [wC929], a
    ld a, $82
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
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
; reads: wScriptParam0, wCB9B
; writes: wScriptParam0, wCB9B
; points at: wScriptStep
ScriptCommand43_Run_Case08::
Jump_00F_6416:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $07
    ret nz
    ld a, [wCB9B]
    inc a
    ld [wCB9B], a
    cp a, $30
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in ScriptCommand43_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, wCB9A, wC92C
; writes: wCB9A, wCB96, wC928, wC929, wC92A
; points at: wCB9C, wScriptStep
ScriptCommand43_Run_Case07::
Jump_00F_6433:: ; address name
    ld hl, wCB9C
    call SetBit2AtHL_B0F
    ld a, [wScriptParam1]
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
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wCB9C
    call ClearBit2AtHL_Bank0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in ScriptCommand43_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, wScriptParam1, wScriptParam0, hPlayerFacing
; writes: hPlayerX, hPlayerFacing, wScriptParam0
; points at: hFF8C, wScriptStep
ScriptCommand43_Run_Case03::
Jump_00F_6473:: ; address name
    ld hl, hFF8C
    call SetBit2AtHL_B0F
    ldh a, [hPlayerX]
    call Func_00F_7ED8
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
    ld hl, hFF8C
    call ClearBit2AtHL_Bank0F
    ret

; entry 1 of the `rst $00` table in ScriptCommand43_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: wCBCF, wScriptParam1
; points at: wScriptStep
ScriptCommand43_Run_Case01::
Jump_00F_64BA:: ; address name
    ld b, $3C
    call StepWC921Counter_Bank0F
    ret nc
    xor a, a
    ld [wCBCF], a
    ld hl, wScriptStep
    inc [hl]
    ldh a, [hPlayerX]
    ld [wScriptParam1], a
    ld hl, $0361
    call StoreHLInWC924_B0F
    ret

; entry 0 of the `rst $00` table in ScriptCommand43_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6, wCBD3, wCBD4
; points at: wScriptStep
ScriptCommand43_Run_Case00::
Jump_00F_64D4:: ; address name
    farcall Func_05F_6E09
    ld a, $05
    ldh [hFFC6], a
    farcall Func_012_6B98
    ld a, $30
    ld [wCBD3], a
    ld a, $40
    ld [wCBD4], a
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
; reads: wScriptParam1, hPlayerY, wC8F1, wC8F6, wC8FB
; writes: hPlayerY, wC8F1, wC8F6, wC8FB, wScriptStartRequest, wC928, wC929
; points at: wScriptParam1, hFF8C, wCB8B, wCB9B
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
    ld de, wCB8B
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld de, wCB9B
    call Func_00F_7EE9
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
    ld [wScriptStartRequest], a
    ret

; entry 16 of the `rst $00` table in ScriptCommand42_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC8F1, wC8F6, wC8FB
; points at: hFF8C, wScriptStep
ScriptCommand42_Run_Case10::
Jump_00F_6586:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 15 of the `rst $00` table in ScriptCommand42_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hPlayerX, wC8F0, wC8F5, wC8FA, hFF8D, hMapId, hMapScreenX, hMapScreenY, ...
ScriptCommand42_Run_Case0F::
Jump_00F_65A5:: ; address name
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
    farcall ScriptStartFadeAndAdvanceStep
    ret

; entry 14 of the `rst $00` table in ScriptCommand42_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFF8D
; points at: wScriptStep
ScriptCommand42_Run_Case0E::
Jump_00F_65D6:: ; address name
    ld a, $0F
    ldh [hFF8D], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in ScriptCommand42_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC6FD
; writes: hFF8D, wScriptStep
; points at: wScriptStep
ScriptCommand42_Run_Case0C::
Jump_00F_65DF:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, $07
    ldh [hFF8D], a
    ld a, [wC6FD]
    dec a
    dec a
    ret nz
    ld a, $0F
    ld [wScriptStep], a
    ret

; entry 10 of the `rst $00` table in ScriptCommand42_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC6FD
; writes: hFF8D, wScriptStep
; points at: wScriptStep
ScriptCommand42_Run_Case0A::
Jump_00F_65F3:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, $03
    ldh [hFF8D], a
    ld a, [wC6FD]
    dec a
    ret nz
    ld a, $0F
    ld [wScriptStep], a
    ret

; entry 8 of the `rst $00` table in ScriptCommand42_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC240, wC241, wC254, wC255, hFF8D
; points at: wScriptStep
ScriptCommand42_Run_Case08::
Jump_00F_6606:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommand42_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCB9A, wC92C
; writes: wC928, wC929, wC92A
; points at: wScriptStep
ScriptCommand42_Run_Case06::
Jump_00F_6628:: ; address name
    ld a, [wCB9A]
    cp a, $40
    jr z, Jump_00F_6645
    ld a, $60
    ld [wC928], a
    ld a, $01
    ld [wC929], a
    ld a, $81
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ret

Jump_00F_6645::
    ld a, $A0
    ld [wC928], a
    ld a, $01
    ld [wC929], a
    ld a, $80
    ld [wC92A], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, $035B
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in ScriptCommand42_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCB96
; points at: wCB9B
ScriptCommand42_Run_Case05::
Jump_00F_666A:: ; address name
    ld a, $02
    ld [wCB96], a
    ld de, wCB9B
    call Func_00F_7F0B
    ret

; entry 3 of the `rst $00` table in ScriptCommand42_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand42_Run_Case03::
Jump_00F_6676:: ; address name
    ld hl, $035A
    call StoreHLInWC924_B0F
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
; reads: wC92C
; writes: wC928
; points at: wScriptStep
ScriptCommand40_Run_Case06::
Jump_00F_66A1:: ; address name
    ld a, $10
    ld [wC928], a
    farcall Func_05F_6A94
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand40_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C, hFF8C
; writes: wC928, wC468, wC46A, hFF8C, hFF9D, hFF9E
; points at: hMapScreenY, hFF80, wScriptStep
ScriptCommand40_Run_Case04::
Jump_00F_66B6:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand42_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCB9B, wC92C, wCB9A
; writes: wC928, wC929, wC92A, wCB96
; points at: wScriptStep
ScriptCommand42_Run_Case02::
Jump_00F_66F4:: ; address name
    ld a, [wCB9B]
    cp a, $60
    jr z, Jump_00F_6712
    ld a, $60
    ld [wC928], a
    ld a, $01
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    farcall StepObjectTowardCoord
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
    farcall StepObjectTowardCoord
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand42_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC468
; points at: wScriptStep
ScriptCommand42_Run_Case01::
Jump_00F_6750:: ; address name
    farcall UpdatePlayerMovement
    farcall Func_002_5BD7
    ld a, [wC468]
    bit 7, a
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand42_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C, hFF8C
; writes: wC929, wC92A, wC928, wC468, wC46A, hFF8C, hFF9D, hFF9E
; points at: hMapScreenY, wScriptStep
ScriptCommand42_Run_Case00::
Jump_00F_6767:: ; address name
    ld a, $01
    ld [wC929], a
    ld a, $02
    ld [wC92A], a
    ld a, $E0
    ld [wC928], a
    farcall StepObjectTowardCoord
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
; reads: wCC37
; writes: hFFC6, wCC37, wC7C7, wScriptStartRequest
ScriptCommand39_Run_Case31::
Jump_00F_6822:: ; address name
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
    ld [wScriptStartRequest], a
    ret

; entry 47 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wCBD4
; writes: wCBD4, wCBCF
; points at: wScriptStep
ScriptCommand39_Run_Case2F::
Jump_00F_6845:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 46 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerFacing, hPlayerX, hPlayerY
; writes: wCB86, hFFC6, wCBD3, wCBD4, wCBCF
; points at: wScriptStep
ScriptCommand39_Run_Case2E::
Jump_00F_6866:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 45 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand39_Run_Case2D::
Jump_00F_6894:: ; address name
    farcall Func_05F_7363
    ret

; entry 44 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hFF8C
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6, wCCE9, wCBD3, ...
; points at: hFF8C
ScriptCommand39_Run_Case2C::
Jump_00F_689B:: ; address name
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
    farcall ScriptStartFadeAndAdvanceStep
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

; entry 42 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand39_Run_Case2A::
Jump_00F_68E0:: ; address name
    ld hl, $0873
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 40 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF
; points at: wCBD4, wScriptStep
ScriptCommand39_Run_Case28::
Jump_00F_68EB:: ; address name
    ld hl, wCBD4
    inc [hl]
    ld de, wCBD4
    call Func_00F_7EE9
    ret nc
    xor a, a
    ld [wCBCF], a
    ld hl, $0872
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 39 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand39_Run_Case27::
Jump_00F_6905:: ; address name
    ld b, $1E
    call StepWC921Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 38 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCBD3, wCBD4, wScriptStep
ScriptCommand39_Run_Case26::
Jump_00F_6910:: ; address name
    ld hl, wCBD3
    inc [hl]
    ld hl, wCBD4
    dec [hl]
    ld de, wCBD4
    call Func_00F_7EE9
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 37 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC928
; points at: wScriptStep
ScriptCommand39_Run_Case25::
Jump_00F_6924:: ; address name
    ld a, $50
    ld [wC928], a
    farcall Func_05F_6B17
    ld a, [wC92C]
    or a, a
    ret z
    ld de, $005F
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 36 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wC92C
; writes: wC92A, wC928, wC929, wScriptParam0, wSpriteSlotCount
; points at: wScriptStep
ScriptCommand39_Run_Case24::
Jump_00F_693F:: ; address name
    ld a, [wScriptParam0]
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
    farcall StepObjectTowardCoord
    ld a, [wC92C]
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
    farcall Func_002_6050
    ret

; entry 34 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wCB86, wCB81
; points at: wScriptStep
ScriptCommand39_Run_Case22::
Jump_00F_69A6:: ; address name
    ld a, [wScriptParam0]
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 33 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wC92C
; writes: wC928, wScriptParam0
; points at: wScriptParam0, wScriptStep
ScriptCommand39_Run_Case21::
Jump_00F_69D5:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_69F0
    ld a, $10
    ld [wC928], a
    farcall Func_05F_6A94
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wScriptParam0
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
    ld hl, wScriptParam0
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
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 32 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCBD4
; writes: wCBD4, wSpriteSlotCount
; points at: wCBD4, wScriptStep
ScriptCommand39_Run_Case20::
Jump_00F_6A21:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 31 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0, wCB96, wCBA6, wCBCF, wCB9A
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
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 30 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCC39, hPlayerX, hPlayerY
; writes: wCC39, wC8C8, wC8C9, wC8C6
ScriptCommand39_Run_Case1E::
Jump_00F_6A77:: ; address name
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
    farcall ScriptStartFadeAndAdvanceStep
    ret

; entry 21 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand39_Run_Case15::
Jump_00F_6A9B:: ; address name
    ld b, $0F
    call Func_00F_72A0
    ret

; entry 20 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCBAB, wScriptStep
ScriptCommand39_Run_Case14::
Jump_00F_6AA1:: ; address name
    ld de, wCBAB
    call Func_00F_7EE9
    ret nc
    ld a, $63
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 18 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCBAB
ScriptCommand39_Run_Case12::
Jump_00F_6AB2:: ; address name
    ld de, wCBAB
    ld hl, $0870
    call Func_00F_7F24
    ret

; entry 17 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCBD4
; writes: wCBD4, wCBCF
; points at: wCBD4, wScriptStep
ScriptCommand39_Run_Case11::
Jump_00F_6ABC:: ; address name
    ld a, [wCBD4]
    inc a
    ld [wCBD4], a
    ld de, wCBD4
    call Func_00F_7EE9
    ret nc
    xor a, a
    ld [wCBCF], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 15 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCB8B
ScriptCommand39_Run_Case0F::
Jump_00F_6AD3:: ; address name
    ld de, wCB8B
    ld hl, $086F
    call Func_00F_7F24
    ret

; entry 14 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCB80, wCB81, hFFC6, hFFC7, hFFC8, hFFC9, hFFCA, hFFCB, ...
; points at: wScriptStep
ScriptCommand39_Run_Case0E::
Jump_00F_6ADD:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCBD4
; writes: wCBD4
; points at: wCBD4, wScriptStep
ScriptCommand39_Run_Case0C::
Jump_00F_6B31:: ; address name
    ld a, [wCBD4]
    dec a
    dec a
    ld [wCBD4], a
    ld de, wCBD4
    call Func_00F_7EE9
    ret nc
    ld hl, $086E
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 11 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC92A, wC928, hFFC6, wCBD3, wCBD4, wCBCF
; points at: wScriptStep
ScriptCommand39_Run_Case0B::
Jump_00F_6B4B:: ; address name
    ld a, $00
    ld [wC929], a
    ld a, $00
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wC929], a
    ld a, $00
    ld [wC92A], a
    ld a, $50
    ld [wC928], a
    farcall StepObjectTowardCoord
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCBAB
ScriptCommand39_Run_Case09::
Jump_00F_6B99:: ; address name
    ld de, wCBAB
    ld hl, $086D
    call Func_00F_7F24
    ret

; entry 8 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCBAA
; writes: wCBAA
; points at: wScriptStep
ScriptCommand39_Run_Case08::
Jump_00F_6BA3:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, wScriptParam0, wCB9A
; writes: wScriptParam0, wCB9A, wScriptParam1
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
    ld a, [wCB9A]
    dec a
    ld [wCB9A], a
    cp a, $30
    ret nz
    ld a, $01
    ld [wScriptParam1], a
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
    ld [wScriptParam0], a
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wCB9A, wCB9B
; writes: wCB96, wCB9A, wCB9B, wCBA1, wScriptParam0
; points at: wCB9C, wScriptParam0, wScriptStep
ScriptCommand39_Run_Case06::
Jump_00F_6BF6:: ; address name
    ld hl, wCB9C
    call SetBit2AtHL_B0F
    ld a, [wScriptParam0]
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
    ld hl, wScriptParam0
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
    ld hl, wScriptParam0
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
    ld hl, wScriptParam0
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
    ld hl, wScriptParam0
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
    ld hl, wScriptParam0
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
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC92A, wC928
; points at: wScriptStep
ScriptCommand39_Run_Case04::
Jump_00F_6CAB:: ; address name
    ld a, $00
    ld [wC929], a
    ld a, $80
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wC929], a
    ld a, $80
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wC929], a
    ld a, $80
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    farcall Func_05F_6E09
    ld hl, $086C
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand43_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand43_Run_Case04::
Jump_00F_6D00:: ; address name
    farcall Func_012_61EF
    ret

; entry 0 of the `rst $00` table in ScriptCommand39_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, wC92C
; writes: wScriptStep, wC928, hPlayerFacing
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
    ld [wC928], a
    farcall Func_05F_6B17
    ld a, [wC92C]
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
    call Func_00F_6D4D
    ret

; 2 call sites from 2 routines (e.g. ScriptCommand38_Run_Case0C, ScriptCommand38_Run_Case0B)
; reads: wScriptParam0, wCBD3
; writes: wScriptParam0, wCBD4, wScriptStartRequest
; points at: wCBD3
Func_00F_6D4D::
    ld hl, wCBD3
    inc [hl]
    ld a, [wScriptParam0]
    inc a
    and a, $07
    ld [wScriptParam0], a
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
    ld [wScriptStartRequest], a
    ret
    db $40, $3F, $40, $3F, $40, $3E, $40, $41

; entry 11 of the `rst $00` table in ScriptCommand38_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCBAA
; writes: wC929, wC92A, wC928, wSpriteSlotCount
; points at: wScriptStep
ScriptCommand38_Run_Case0B::
Jump_00F_6D80:: ; address name
    call Func_00F_6D4D
    ld a, $00
    ld [wC929], a
    ld a, $81
    ld [wC92A], a
    ld a, $A0
    ld [wC928], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wC929], a
    ld a, $81
    ld [wC92A], a
    ld a, $A0
    ld [wC928], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wC929], a
    ld a, $81
    ld [wC92A], a
    ld a, $A0
    ld [wC928], a
    farcall StepObjectTowardCoord
    ld a, [wCBAA]
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
; writes: wC928, wC929, hScrollX, hFF8D
; points at: wCB8B, wCB9B, wCBAB, wScriptStep
ScriptCommand38_Run_Case0A::
Jump_00F_6DD1:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    xor a, a
    ldh [hFF8D], a
    ret

; entry 9 of the `rst $00` table in ScriptCommand38_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCBD4
; writes: wCBD4, wScriptParam0, hFF8D
; points at: wScriptStep
ScriptCommand38_Run_Case09::
Jump_00F_6E31:: ; address name
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
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld a, $0E
    ldh [hFF8D], a
    ret

; entry 8 of the `rst $00` table in ScriptCommand38_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCB8A
; writes: wCBA6, hFFC6, wCBCF
; points at: wCB8B, wCB8C, wCB9C, wCBAC, wScriptStep
ScriptCommand38_Run_Case08::
Jump_00F_6E54:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in ScriptCommand38_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCB8C, wCB9C, wCBAC, wScriptStep
ScriptCommand38_Run_Case03::
Jump_00F_6EB0:: ; address name
    ld b, $3C
    call StepWC921Counter_Bank0F
    ret nc
    ld hl, wCB8C
    call SetBit2AtHL_B0F
    ld hl, wCB9C
    call SetBit2AtHL_B0F
    ld hl, wCBAC
    call SetBit2AtHL_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommand38_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wScriptParam0
; writes: wScriptParam0
; points at: hFF8C, wScriptStep
ScriptCommand38_Run_Case06::
Jump_00F_6ECD:: ; address name
    ldh a, [hPlayerY]
    call Func_00F_7ED8
    ldh a, [hPlayerY]
    call Func_00F_7ED8
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $1E
    ret nz
    ld hl, hFF8C
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand38_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCBAB, wCB9B, wCB8B
; writes: hPlayerFacing, wCBAB, wCB9B, wCB8B
; points at: wCB8C, wCB9C, wCBAC, hFF8C, wScriptStep
ScriptCommand38_Run_Case04::
Jump_00F_6F0C:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand38_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCB8C, wCB9C, wCBAC
ScriptCommand38_Run_Case00::
Jump_00F_6F4C:: ; address name
    farcall Func_012_61EF
    ld hl, wCB8C
    call SetBit2AtHL_B0F
    ld hl, wCB9C
    call SetBit2AtHL_B0F
    ld hl, wCBAC
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
; writes: wScriptParam0, wCB86, wCBA6, wCB96, wScriptStartRequest
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
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommand37_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0
; points at: wCB8C, wCB9C, wCBAC, wScriptStep
ScriptCommand37_Run_Case02::
Jump_00F_6F9A:: ; address name
    ld hl, wCB8C
    call SetBit2AtHL_B0F
    ld hl, wCB9C
    call SetBit2AtHL_B0F
    ld hl, wCBAC
    call SetBit2AtHL_B0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand37_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo, hScrollX, wCC39, hPlayerX, hPlayerY
; writes: hScrollX, wCC39, wC8C8, wC8C9, wC8C6, wC8C7
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
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $00
    call QueueSoundEffect
    ret

; entry 0 of the `rst $00` table in ScriptCommand37_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCB8A
; points at: wCB8C, wCB9C, wCBAC, wCB8A, wScriptStep
ScriptCommand37_Run_Case00::
Jump_00F_7002:: ; address name
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
; points at: wCB8C, wCB9C, wCBAC, wScriptStep
ScriptCommand36_Run_Case00::
Jump_00F_7051:: ; address name
    ld hl, wCB8C
    call SetBit2AtHL_B0F
    ld hl, wCB9C
    call SetBit2AtHL_B0F
    ld hl, wCBAC
    call SetBit2AtHL_B0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand36_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCBAB
; writes: wSpriteSlotCount, wScriptStartRequest
; points at: wCB8B
ScriptCommand36_Run_Case01::
Jump_00F_706C:: ; address name
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
; reads: hFFC6
; writes: hFFC6, hFFC7, wSpriteSlotCount, wScriptStartRequest, wC928
ScriptCommand32_Run_Case00::
Jump_00F_7099:: ; address name
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
    ld [wScriptStartRequest], a
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
; reads: hPlayerX, wScriptParam0, hFF8C
; writes: wScriptParam0, hFF8C, wScriptStartRequest
ScriptCommand29_Run_Case09::
Jump_00F_7104:: ; address name
    ldh a, [hPlayerX]
    call Func_00F_7ED8
    ldh a, [hPlayerX]
    call Func_00F_7ED8
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $1E
    ret nz
    ldh a, [hFF8C]
    and a, $FD
    ldh [hFF8C], a
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
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in ScriptCommand29_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, wScriptParam0, wCB8A, wC92C, hFF8C
; writes: wScriptParam0, wCB8A, wScriptParam1, wC929, wC92A, wC928, hFF8C
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
    ld a, [wCB8A]
    dec a
    ld [wCB8A], a
    cp a, $20
    ret nz
    ld a, $01
    ld [wScriptParam1], a
    ret

Jump_00F_716A::
    ld a, $00
    ld [wC929], a
    ld a, $81
    ld [wC92A], a
    ld a, $30
    ld [wC928], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ldh a, [hFF8C]
    or a, $02
    ldh [hFF8C], a
    ld a, $63
    call QueueSoundEffect
    xor a, a
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommand29_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCB8A, wC92C
; writes: wC929, wC92A, wC928, wCB86, hPlayerFacing
; points at: wScriptStep
ScriptCommand29_Run_Case06::
Jump_00F_7198:: ; address name
    ld a, [wCB8A]
    cp a, $30
    jr z, Jump_00F_71B5
    ld a, $00
    ld [wC929], a
    ld a, $03
    ld [wC92A], a
    ld a, $30
    ld [wC928], a
    farcall StepObjectTowardCoord
    ret

Jump_00F_71B5::
    ld a, $00
    ld [wC929], a
    ld a, $00
    ld [wC92A], a
    ld a, $70
    ld [wC928], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $01
    ld [wCB86], a
    ld a, $03
    ldh [hPlayerFacing], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand29_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wCB96, wCBA6, wC929, wC92A, wC928
; points at: wScriptStep
ScriptCommand29_Run_Case04::
Jump_00F_71DD:: ; address name
    xor a, a
    ld [wCB96], a
    ld [wCBA6], a
    ld a, $00
    ld [wC929], a
    ld a, $00
    ld [wC92A], a
    ld a, $60
    ld [wC928], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, $0833
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in ScriptCommand29_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCB8B
ScriptCommand29_Run_Case03::
Jump_00F_7209:: ; address name
    ld de, wCB8B
    call Func_00F_7F0B
    ret

; entry 1 of the `rst $00` table in ScriptCommand29_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCB96
; points at: wScriptStep
ScriptCommand29_Run_Case01::
Jump_00F_7210:: ; address name
    xor a, a
    call Func_00F_7F75
    ret nc
    ld a, $01
    ld [wCB96], a
    ld hl, $0832
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand29_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCB8B
; writes: wCBA6
; points at: wCB8C, wCB9C, wCBAC, wCB8B, wScriptStep
ScriptCommand29_Run_Case00::
Jump_00F_7225:: ; address name
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
    farcall Func_05F_6E09
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
    call Func_00F_72A0
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
; reads: wC928, wFrameCounterLo, hScrollX, hScrollXHi
; writes: hScrollX, hScrollXHi
; points at: wScriptStep
ScriptCommand35_Run_Case02_Sub01::
Func_00F_729C:: ; address name
    ld a, [wC928]
    ld b, a

; 7 call sites from 7 routines (e.g. ScriptCommand5E_Run_Case0F, ScriptCommand58_Run_Case01, ScriptCommand43_Run_Case0A, ScriptCommand41_Run_Case08, ...)
; reads: wFrameCounterLo, hScrollX, hScrollXHi
; writes: hScrollX, hScrollXHi
; points at: wScriptStep
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
; reads: wCC37
; writes: hFFC6, wCC37, wC7C7, wScriptStartRequest
ScriptCommand27_Run_Case23::
Jump_00F_7325:: ; address name
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
    ld [wScriptStartRequest], a
    ret

; entry 33 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wCBD4
; writes: wCBD4, wCBCF
; points at: wScriptStep
ScriptCommand27_Run_Case21::
Jump_00F_7348:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 32 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerFacing, hPlayerX, hPlayerY
; writes: wCB86, hFFC6, wCBD3, wCBD4, wCBCF
; points at: wScriptStep
ScriptCommand27_Run_Case20::
Jump_00F_7369:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 31 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand27_Run_Case1F::
Jump_00F_7397:: ; address name
    farcall Func_05F_7363
    ret

; entry 30 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6, wCCE9, wC92D
ScriptCommand27_Run_Case1E::
Jump_00F_739E:: ; address name
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
    farcall ScriptStartFadeAndAdvanceStep
    ld hl, $0125
    call StoreHLInWC924_B0F
    xor a, a
    ld [wC92D], a
    ret

; entry 28 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand27_Run_Case1C::
Jump_00F_73CD:: ; address name
    ld hl, $01A2
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 26 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC92A, wC928, wSpriteSlotCount
; points at: wScriptStep
ScriptCommand27_Run_Case1A::
Jump_00F_73D8:: ; address name
    ld a, $00
    ld [wC929], a
    ld a, $00
    ld [wC92A], a
    ld a, $A0
    ld [wC928], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wSpriteSlotCount], a
    ld hl, $01A1
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 24 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand27_Run_Case18::
Jump_00F_7401:: ; address name
    ld hl, $01A0
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 22 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC933
; writes: wCBCF, wC6FD, wCBD3, wCBD4
; points at: wCBD3, wCBD4, wScriptStep
ScriptCommand27_Run_Case16::
Jump_00F_740C:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 20 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wCBD4, wScriptStep
ScriptCommand27_Run_Case14::
Jump_00F_743A:: ; address name
    ld hl, wCBD4
    dec [hl]
    ld de, wCBD4
    call Func_00F_7EE9
    ret nc
    ld hl, $019E
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 19 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC6FD
; writes: wCBD3, wCBD4, wCBCF, wC933, wC6FD
; points at: wScriptStep
ScriptCommand27_Run_Case13::
Jump_00F_7450:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 17 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC92A, wC928, wCB86
; points at: wScriptStep
ScriptCommand27_Run_Case11::
Jump_00F_7473:: ; address name
    ld a, $00
    ld [wC929], a
    ld a, $00
    ld [wC92A], a
    ld a, $20
    ld [wC928], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, $019D
    call StoreHLInWC924_B0F
    ld a, $03
    ld [wCB86], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 16 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC92A, wC928, wC929, wSpriteSlotCount, wCB81, wCB8B
; points at: wScriptStep
ScriptCommand27_Run_Case10::
Jump_00F_749D:: ; address name
    ld a, $00
    ld [wC92A], a
    ld a, $A0
    ld [wC928], a
    ld a, $00
    ld [wC929], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wC929], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wC929], a
    farcall StepObjectTowardCoord
    ld a, $03
    ld [wC929], a
    farcall StepObjectTowardCoord
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 15 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCBAB, wCBBB, wCB8B, wCB9B, wCB81, wCB91
; points at: wScriptStep
ScriptCommand27_Run_Case0F::
Jump_00F_74F7:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand27_Run_Case0D::
Jump_00F_7530:: ; address name
    ld hl, $019C
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand27_Run_Case0A::
Jump_00F_753B:: ; address name
    ld hl, $019B
    call StoreHLInWC924_B0F
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
; reads: wC92C
; writes: wC92A, wC928, wC929
; points at: wScriptStep
ScriptCommand27_Run_Case07::
Jump_00F_756F:: ; address name
    ld a, $02
    ld [wC92A], a
    ld a, $E0
    ld [wC928], a
    ld a, $01
    ld [wC929], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wC929], a
    farcall StepObjectTowardCoord
    ld a, $03
    ld [wC929], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, $019A
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC928, hPlayerFacing
; points at: wScriptStep
ScriptCommand27_Run_Case03::
Jump_00F_75AA:: ; address name
    ld a, $30
    ld [wC928], a
    farcall Func_05F_6B17
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $01
    ldh [hPlayerFacing], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC92A, wC928, wC929, hPlayerFacing
; points at: wScriptStep
ScriptCommand27_Run_Case01::
Jump_00F_75C3:: ; address name
    ld a, $02
    ld [wC92A], a
    ld a, $40
    ld [wC928], a
    ld a, $03
    ld [wC929], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wC929], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wC929], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ldh [hPlayerFacing], a
    ld hl, $0199
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand27_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6, wCC38
; writes: hFFC6, hFFC7, wCC38
; points at: wScriptStep
ScriptCommand27_Run_Case00::
Jump_00F_7601:: ; address name
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
; reads: wC92C
; writes: wC928, hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6
ScriptCommand23_Run_Case03::
Jump_00F_7639:: ; address name
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
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $60
    call QueueSoundEffect
    ret

; entry 2 of the `rst $00` table in ScriptCommand23_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wC92C
; writes: wC928, wC929, wC92A, wScriptParam0, wCB8A
; points at: wScriptParam0, wScriptStep
ScriptCommand23_Run_Case02::
Jump_00F_766D:: ; address name
    ld a, [wScriptParam0]
    and a, $0F
    jr nz, Jump_00F_768B
    ld a, $60
    ld [wC928], a
    farcall Func_05F_6A94
    ld a, [wC92C]
    or a, a
    jr z, Jump_00F_7696
    ld hl, wScriptParam0
    inc [hl]
    jr Jump_00F_7696

Jump_00F_768B::
    ld a, $30
    ld [wC928], a
    farcall Func_05F_6B17

Jump_00F_7696::
    ld a, $00
    ld [wC929], a
    ld a, [wScriptParam0]
    and a, $F0
    jr nz, Jump_00F_76C0
    ld a, $00
    ld [wC92A], a
    ld a, $60
    ld [wC928], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld a, [wScriptParam0]
    or a, $10
    ld [wScriptParam0], a
    ret

Jump_00F_76C0::
    ld a, $03
    ld [wC92A], a
    ld a, $20
    ld [wC928], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $E0
    ld [wCB8A], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand23_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6
ScriptCommand23_Run_Case01::
Jump_00F_76E3:: ; address name
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
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $60
    call QueueSoundEffect
    ret

; entry 0 of the `rst $00` table in ScriptCommand23_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, wC92C
; writes: wC928
; points at: wScriptStep
ScriptCommand23_Run_Case00::
Jump_00F_7707:: ; address name
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
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6
ScriptCommand1F_Run_Case00::
Jump_00F_7746:: ; address name
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
    farcall ScriptStartFadeAndAdvanceStep
    ld hl, $0151
    call StoreHLInWC924_B0F
    ret

; entry 1 of the `rst $00` table in ScriptCommand1F_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0
; points at: wScriptStep
ScriptCommand1F_Run_Case01::
Jump_00F_776B:: ; address name
    xor a, a
    call Func_00F_7F75
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
    call StepWC921Counter_Bank0F
    ret nc
    farcall Func_002_604B
    ld hl, $0152
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand1F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC928, hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6
ScriptCommand1F_Run_Case04::
Jump_00F_7795:: ; address name
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
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $60
    call QueueSoundEffect
    ret

; entry 5 of the `rst $00` table in ScriptCommand1F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC928, hPlayerFacing, wScriptParam0
; points at: hFF8C, wScriptStep
ScriptCommand1F_Run_Case05::
Jump_00F_77C9:: ; address name
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
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommand1F_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC92D
; points at: wScriptStep
ScriptCommand1F_Run_Case06::
Jump_00F_77F1:: ; address name
    ld b, $B4
    call StepWC921Counter_Bank0F
    ret nc
    farcall Func_002_604B
    xor a, a
    ld [wC92D], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in ScriptCommand1F_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand1F_Run_Case07::
Jump_00F_7806:: ; address name
    farcall Func_05F_70D2
    ret

; entry 8 of the `rst $00` table in ScriptCommand1F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wC92C
; writes: wScriptParam0, wC928, hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6
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
; reads: wCC38
; writes: wCC38, wScriptStartRequest
ScriptCommand1F_Run_Case09::
Jump_00F_785B:: ; address name
    farcall Func_002_6050
    ld a, [wCC38]
    or a, $01
    ld [wCC38], a
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
; reads: wCC37
; writes: wCC37, wScriptStartRequest
ScriptCommand1D_Run_Case0C::
Jump_00F_788D:: ; address name
    ld a, [wCC37]
    set 0, a
    ld [wCC37], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 11 of the `rst $00` table in ScriptCommand1D_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC8C6, wC6FD
ScriptCommand1D_Run_Case0B::
Jump_00F_789B:: ; address name
    xor a, a
    call Func_00F_7F75
    ret nc
    ld a, $01
    ld [wC8C6], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $01
    ld [wC6FD], a
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
    call Func_00F_7F75
    ret nc
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld hl, $0093
    call StoreHLInWC924_B0F
    ret

; entry 9 of the `rst $00` table in ScriptCommand1D_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: wC8F1, hPlayerFacing, wC8EF
; points at: hPlayerY, wScriptStep
ScriptCommand1D_Run_Case09::
Jump_00F_78CB:: ; address name
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
    call Func_00F_7F75
    ret nc
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
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

; entry 7 of the `rst $00` table in ScriptCommand1D_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC929, wC92A, wC928, wCB86, wScriptParam0
; points at: wScriptStep
ScriptCommand1D_Run_Case07::
Jump_00F_790A:: ; address name
    ld a, $00
    ld [wC929], a
    ld a, $03
    ld [wC92A], a
    ld a, $70
    ld [wC928], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wCB86], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld hl, $0091
    call StoreHLInWC924_B0F
    ret

; entry 5 of the `rst $00` table in ScriptCommand1D_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wC928, wC929, wScriptParam0, hPlayerFacing, wC8EF
; points at: wCB8B, wScriptStep
ScriptCommand1D_Run_Case05::
Jump_00F_7937:: ; address name
    ld de, wCB8B
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    ld a, $02
    ldh [hPlayerFacing], a
    ld [wC8EF], a
    ld hl, $0090
    call StoreHLInWC924_B0F
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand1D_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wC92C, wCB8B
; writes: wC929, wC92A, wC928, wCB86, wScriptParam0
; points at: wScriptParam0, wScriptStep
ScriptCommand1D_Run_Case04::
Jump_00F_7968:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_00F_798D
    ld a, $00
    ld [wC929], a
    ld a, $03
    ld [wC92A], a
    ld a, $60
    ld [wC928], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld hl, wScriptParam0
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
    farcall StepObjectTowardCoord
    ret

Jump_00F_79AA::
    ld a, $00
    ld [wC929], a
    ld a, $01
    ld [wC92A], a
    ld a, $78
    ld [wC928], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    xor a, a
    ld [wCB86], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand1D_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC924, wC925
; writes: wC924, wC925
; points at: wScriptStep
ScriptCommand1D_Run_Case02::
Jump_00F_79D1:: ; address name
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
    ld hl, wScriptStep
    dec [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand1D_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC552, wC924, wC925
; writes: wC924, wC925
; points at: wScriptStep
ScriptCommand1D_Run_Case01::
Jump_00F_79EC:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ld hl, wScriptStep
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
; reads: wC552, wC924, wC925
; points at: wScriptStep
ScriptCommand1C_Run_Case03::
Jump_00F_7A3B:: ; address name
    ld hl, wScriptStep
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

; entry 1 of the `rst $00` table in ScriptCommand1C_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC8F0
; writes: wC8EF, wC8F0, hPlayerFacing
; points at: wScriptStep
ScriptCommand1C_Run_Case01::
Jump_00F_7A70:: ; address name
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
    ld hl, wScriptStep
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

; entry 0 of the `rst $00` table in ScriptCommand1C_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6
ScriptCommand1C_Run_Case00::
Jump_00F_7AA2:: ; address name
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
; writes: wC917, wC916
ScriptCommand77_Run_Case0E::
Jump_00F_7AE8:: ; address name
    ld a, $0A
    ld [wC917], a
    ld a, $02
    ld [wC916], a
    farcall Func_013_405C
    ret

; entry 13 of the `rst $00` table in ScriptCommand77_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6, hFF8B, wC924, ...
ScriptCommand77_Run_Case0D::
Jump_00F_7AF9:: ; address name
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
    farcall ScriptStartFadeAndAdvanceStep
    ld de, $001B
    call SetFlagBit
    ld a, $01
    ldh [hFF8B], a
    xor a, a
    ld [wC924], a
    ld [wC925], a
    ret

; entry 11 of the `rst $00` table in ScriptCommand77_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand77_Run_Case0B::
Jump_00F_7B2A:: ; address name
    ld b, $78
    call StepWC921Counter_Bank0F
    ret nc
    ld hl, $0014
    call StoreHLInWC924_B0F
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in ScriptCommand77_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hScrollY, hScrollX, wC469
; writes: wScriptParam0, hScrollY
; points at: wC469, wScriptStep
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
    call ScriptCommand77_Run_Case0A_Sub01
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
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; only called from ScriptCommand77_Run_Case0A (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommand77_Run_Case0A)
; reads: wIsCGB, hFFC6
; writes: wC0C0, wC0C1, wC0C2, wC0C3, wC0D8, wC0D9, wC0DA, wC0DB, ...
; points at: wC0C4, wC0DC
ScriptCommand77_Run_Case0A_Sub01::
Func_00F_7BC3:: ; address name
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

; entry 9 of the `rst $00` table in ScriptCommand77_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC469
; points at: wScriptStep
ScriptCommand77_Run_Case09::
Jump_00F_7C19:: ; address name
    xor a, a
    ld [wC469], a
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
; reads: wScriptParam0, wCB8B
; writes: wScriptParam0, wCB8B
; points at: wCB8C, wScriptStep
ScriptCommand77_Run_Case02::
Jump_00F_7C4F:: ; address name
    ld hl, wCB8C
    call SetBit2AtHL_B0F
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    ret nz
    ld a, [wCB8B]
    dec a
    ld [wCB8B], a
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
    call StepWC921Counter_Bank0F
    ret nc
    ld hl, hMapScreenY
    dec [hl]
    call LoadMapScreen
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand77_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6
ScriptCommand77_Run_Case00::
Jump_00F_7C84:: ; address name
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
; writes: wC8EF, wC8F0, wC8F1, wCBBB, wScriptStartRequest
ScriptCommand76_Run_Case03::
Jump_00F_7CB1:: ; address name
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
    ld [wScriptStartRequest], a
    ret

; entry 0 of the `rst $00` table in ScriptCommand76_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0
; points at: wCBBB, wScriptStep
ScriptCommand76_Run_Case00::
Jump_00F_7CD6:: ; address name
    ld de, wCBBB
    call Func_00F_7EE9
    ret nc
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
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
; points at: wCBBA, wCBBB
ScriptCommand75_Run_Case03::
Jump_00F_7D07:: ; address name
    ld hl, wCBBA
    dec [hl]
    ld hl, wCBBB
    inc [hl]
    ld de, wCBBB
    call Func_00F_7EE9
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommand75_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCBBB
; writes: wCBBB, wCBB6
; points at: wScriptStep
ScriptCommand75_Run_Case02::
Jump_00F_7D1C:: ; address name
    ld a, [wCBBB]
    inc a
    inc a
    ld [wCBBB], a
    cp a, $30
    ret nz
    ld a, $03
    ld [wCBB6], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand75_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand75_Run_Case01::
Jump_00F_7D31:: ; address name
    ld b, $5A
    call StepWC921Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand75_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6, hFF8B
ScriptCommand75_Run_Case00::
Jump_00F_7D3C:: ; address name
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
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $01
    ldh [hFF8B], a
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
    call StoreHLInWC924_B0F
    ret

Jump_00F_7D7F::
    ld hl, $001F
    call StoreHLInWC924_B0F
    ret

; entry 0 of the `rst $00` table in ScriptCommand6B_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerFacing
; writes: wC8EF
; points at: wC8F1, wScriptStep
ScriptCommand6B_Run_Case00::
Jump_00F_7D86:: ; address name
    ldh a, [hPlayerFacing]
    ld [wC8EF], a
    ld de, wC8F1
    call Func_00F_7EE9
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
; points at: wCB8B, hFF8C
ScriptCommand6A_Run_Case03::
Jump_00F_7DA3:: ; address name
    call Func_00F_7E1E
    ld de, wCB8B
    call Func_00F_7EE9
    ret nc
    ld hl, hFF8C
    call ClearBit2AtHL_Bank0F
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommand6A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC924
; writes: wC924
; points at: wScriptStep
ScriptCommand6A_Run_Case02::
Jump_00F_7DB9:: ; address name
    call Func_00F_7E1E
    ld a, [wC924]
    inc a
    ld [wC924], a
    cp a, $20
    ret nz
    xor a, a
    ld [wC924], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand6A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC92C
; writes: wC92A, wC929, wC928, wCB86
; points at: wScriptStep
ScriptCommand6A_Run_Case01::
Jump_00F_7DCF:: ; address name
    call Func_00F_7E1E
    ld a, $00
    ld [wC92A], a
    ld a, $00
    ld [wC929], a
    ld a, $50
    ld [wC928], a
    farcall StepObjectTowardCoord
    ld a, [wC92C]
    or a, a
    ret z
    ld a, $01
    ld [wCB86], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand6A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC924, wC925
; writes: wC924, wC925
; points at: wScriptStep
ScriptCommand6A_Run_Case00::
Jump_00F_7DF6:: ; address name
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
    ld hl, wScriptStep
    inc [hl]
    ret

; 4 call sites from 4 routines (e.g. ScriptCommand6A_Run_Case03, ScriptCommand6A_Run_Case02, ScriptCommand6A_Run_Case01, ScriptCommand6A_Run_Case00)
; reads: wScriptParam1, wC92C
; writes: wC928, wScriptParam1
Func_00F_7E1E::
    ld a, [wScriptParam1]
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
    ld a, [wScriptParam1]
    inc a
    cp a, $06
    jr nz, Jump_00F_7EAE
    xor a, a

Jump_00F_7EAE::
    ld [wScriptParam1], a
    ret

; wC921 += 1; if it now equals B it is reset to 0 and carry is set, else carry is clear; returns A = 0 either way (the same 18 bytes appear in 3 banks)
; 34 call sites from 34 routines (e.g. ScriptCommand77_Run_Case0B, ScriptCommand77_Run_Case01, ScriptCommand75_Run_Case01, Func_00F_7F24, ...)
; reads: wScriptParam0
; writes: wScriptParam0
StepWC921Counter_Bank0F::
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

; 15 call sites from 8 routines (e.g. ScriptCommandC7_Run_Case03, ScriptCommandC7_Run_Case02, ScriptCommand46_Run_Case0B, ScriptCommand43_Run_Case03, ...)
Func_00F_7ED8::
    and a, $0F
    jr nz, Jump_00F_7EE2
    farcall Func_002_5923

Jump_00F_7EE2::
    farcall Func_002_5946
    ret

; 38 call sites from 38 routines (e.g. ScriptCommand76_Run_Case00, ScriptCommand75_Run_Case03, ScriptCommand6B_Run_Case00, ScriptCommand6A_Run_Case03, ...)
; reads: wScriptParam0
; writes: wC928, wC929, wScriptParam0
Func_00F_7EE9::
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
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

; 4 call sites from 4 routines (e.g. ScriptCommand5E_Run_Case18, ScriptCommand46_Run_Case09, ScriptCommand42_Run_Case05, ScriptCommand29_Run_Case03)
; writes: wC928, wC929
; points at: wScriptStep
Func_00F_7F0B::
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld b, $20
    call StepWC921Counter_Bank0F
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; 7 call sites from 7 routines (e.g. ScriptCommand66_Run_Case0C, ScriptCommand58_Run_Case2A, ScriptCommand58_Run_Case18, ScriptCommand58_Run_Case08, ...)
; writes: wC928, wC929
; points at: wScriptStep
Func_00F_7F24::
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
    ld hl, wScriptStep
    inc [hl]
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wC928, wC929, wScriptStartRequest
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
    ld [wScriptStartRequest], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
Func_00F_7F5C:: ; heuristic: follows a terminator; C0
    ld a, [wScriptParam0]
    and a, $1F
    ret nz
    ld a, [de]
    inc a
    and a, $03
    ld [de], a
    ret

; HL is stored in wC924 (low) and wC925 (high); then wC926 = 0
; 125 call sites from 106 routines (e.g. ScriptCommand77_Run_Case0B, ScriptCommand76_Run_Case00, ScriptCommand6B_Run_Case01, ScriptCommand66_Run_Case0E, ...)
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

; 15 call sites from 15 routines (e.g. ScriptCommand66_Run_Case05, ScriptCommand58_Run_Case2B, ScriptCommand4B_Run_Case0F, ScriptCommand4B_Run_Case0E, ...)
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

; entry 3 of the `rst $00` table in ScriptCommand5F_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand5F_Run_Case03::
Jump_00F_7F89:: ; address name
    xor a, a
    call Func_00F_7F75
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
    call Func_00F_7F75
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret
    ds $62, $00
