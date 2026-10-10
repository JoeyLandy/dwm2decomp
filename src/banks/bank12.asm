SECTION "Bank 12", ROMX[$4000], BANK[$12]
    db $12

; implements script command type 9D; reached through ScriptCommand9D in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand9D)
; reads: wScriptStep
ScriptCommand9D_Run::
Func_012_4001:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand9D_Run_Case00
    dw ScriptCommand9D_Run_Case01

; entry 0 of the `rst $00` table in ScriptCommand9D_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand9D_Run_Case00::
Jump_012_4009:: ; address name
    ld a, $10
    call StartMessageA
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 9C; reached through ScriptCommand9C in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand9C)
; reads: wScriptStep
ScriptCommand9C_Run::
Func_012_4013:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand9C_Run_Case00
    dw ScriptCommand9D_Run_Case01

; entry 1 of the `rst $00` table in ScriptCommand9D_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
ScriptCommand9D_Run_Case01::
Jump_012_401B:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 0 of the `rst $00` table in ScriptCommand9C_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand9C_Run_Case00::
Jump_012_4026:: ; address name
    ld a, $0F
    call StartMessageA
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 9A; reached through ScriptCommand9A in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand9A)
; reads: wScriptStep, wCC44, wCD03
; writes: wScriptStartRequest, wC903, wC905
; points at: wScriptStep
ScriptCommand9A_Run::
Func_012_4030:: ; address name
    ld a, [wScriptStep]
    or a, a
    jr z, Jump_012_403C
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_012_403C::
    xor a, a
    ld [wC903], a
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_012_404C
    ld a, $01
    ld [wC903], a

Jump_012_404C::
    call NextRandomSeed
    ld a, [wCD03]
    and a, $01
    sla a
    ld [wC905], a
    farcall SetModeState3AndSaveScreen
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 99; reached through ScriptCommand99 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand99)
; reads: wScriptStep
ScriptCommand99_Run::
Func_012_4064:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand99_Run_Case00
    dw ScriptCommand99_Run_Case01
    dw ScriptCommand99_Run_Case02
    dw ScriptCommand99_Run_Case03
    dw ScriptCommand99_Run_Case04
    dw ScriptCommand99_Run_Case05
    dw ScriptCommand99_Run_Case06
    dw ScriptCommand99_Run_Case07
    dw ScriptCommand99_Run_Case08
    dw ScriptCommand99_Run_Case09
    dw ScriptCommand99_Run_Case0A
    dw ScriptCommand99_Run_Case0B

; entry 10 of the `rst $00` table in ScriptCommand99_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC8FB
; writes: wC8F9, wC8FB
; points at: wC8FB
ScriptCommand99_Run_Case0A::
Jump_012_4080:: ; address name
    xor a, a
    ld [wC8F9], a
    ld a, [wC8FB]
    inc a
    ld [wC8FB], a
    ld de, wC8FB
    call ScriptApplyStepDeltaAtDE_Bank12
    ret

; entry 9 of the `rst $00` table in ScriptCommand99_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC8F6, wScriptParam0, wC6FD
; writes: wC8F4, wC8F6, wScriptStep
; points at: wC8F6, wC8FB
ScriptCommand99_Run_Case09::
Jump_012_4092:: ; address name
    xor a, a
    ld [wC8F4], a
    ld de, wC8F6
    call ScriptApplyStepDeltaAtDE_Bank12
    ld a, [wC8F6]
    inc a
    ld [wC8F6], a
    ld hl, wC8FB
    inc [hl]
    ld a, [wScriptParam0]
    or a, a
    ret nz
    ld a, [wC6FD]
    dec a
    dec a
    ret nz
    ld a, $0B
    ld [wScriptStep], a
    ret

; entry 8 of the `rst $00` table in ScriptCommand99_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC8F1, wScriptParam0, wC6FD
; writes: wFollowerRecords, wC8F1, wScriptStep
; points at: wC8F1, wC8F6, wC8FB
ScriptCommand99_Run_Case08::
Jump_012_40B8:: ; address name
    xor a, a
    ld [wFollowerRecords], a
    ld de, wC8F1
    call ScriptApplyStepDeltaAtDE_Bank12
    ld a, [wC8F1]
    inc a
    ld [wC8F1], a
    ld hl, wC8F6
    inc [hl]
    ld hl, wC8FB
    inc [hl]
    ld a, [wScriptParam0]
    or a, a
    ret nz
    ld a, [wC6FD]
    dec a
    ret nz
    ld a, $0B
    ld [wScriptStep], a
    ret

; entry 7 of the `rst $00` table in ScriptCommand99_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: hPlayerFacing, hPlayerY
; points at: hPlayerY, wC8F1, wC8F6, wC8FB
ScriptCommand99_Run_Case07::
Jump_012_40E1:: ; address name
    xor a, a
    ldh [hPlayerFacing], a
    ld de, hPlayerY
    call ScriptApplyStepDeltaAtDE_Bank12
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    ld hl, wC8F1
    inc [hl]
    ld hl, wC8F6
    inc [hl]
    ld hl, wC8FB
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommand99_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: hPlayerY
; points at: wC8FB, wC8F6, wC8F1, wScriptStep
ScriptCommand99_Run_Case06::
Jump_012_40FC:: ; address name
    ld hl, wC8FB
    inc [hl]
    ld hl, wC8F6
    inc [hl]
    ld hl, wC8F1
    inc [hl]
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp a, $20
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in ScriptCommand99_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hPlayerFacing, wFollowerRecords, wC8F4, wC8F9, wC8F1, wC8F6, wC8FB
; points at: hFF8C, wScriptStep
ScriptCommand99_Run_Case05::
Jump_012_4115:: ; address name
    ld a, $02
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld a, $E0
    ld [wC8F1], a
    ld a, $D0
    ld [wC8F6], a
    ld a, $C0
    ld [wC8FB], a
    ld hl, hFF8C
    call SetBit2AtHL_B12
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand99_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC8FB
; writes: wC8F9, wC8FB, hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6
; points at: hPlayerY, wC8F1, wC8F6
ScriptCommand99_Run_Case04::
Jump_012_413C:: ; address name
    ld a, $02
    ld [wC8F9], a
    ld hl, hPlayerY
    inc [hl]
    ld hl, wC8F1
    inc [hl]
    ld hl, wC8F6
    inc [hl]
    ld a, [wC8FB]
    inc a
    ld [wC8FB], a
    cp a, $B0
    ret nz
    ld a, $00
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ld a, $02
    ldh [hMapScreenY], a
    ld a, $70
    ld [wC8C8], a
    ld a, $F0
    ld [wC8C9], a
    xor a, a
    ld [wC8C6], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; entry 3 of the `rst $00` table in ScriptCommand99_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wC8F9, wFollowerRecords, wC8F4, wC928, wC929, wScriptParam0
; points at: hPlayerY, wC8F1, wC8F6, wC8FA, wC8FB, wScriptStep
ScriptCommand99_Run_Case03::
Jump_012_4177:: ; address name
    ld a, $01
    ld [wC8F9], a
    ld hl, hPlayerY
    inc [hl]
    ld hl, wC8F1
    inc [hl]
    ld hl, wC8F6
    inc [hl]
    ld a, $02
    ld [wFollowerRecords], a
    ld a, $02
    ld [wC8F4], a
    ld hl, wC8FA
    inc [hl]
    ld de, wC8FB
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    jp Jump_012_43C6

; entry 2 of the `rst $00` table in ScriptCommand99_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wScriptParam0
; writes: wFollowerRecords, wC928, wC929, wScriptParam0
; points at: hPlayerY, wC8F6, wScriptStep
ScriptCommand99_Run_Case02::
Jump_012_41AA:: ; address name
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ld a, $02
    ld [wFollowerRecords], a
    ld hl, hPlayerY
    inc [hl]
    ld de, wC8F6
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    jp Jump_012_43C6

; entry 1 of the `rst $00` table in ScriptCommand99_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wScriptParam0
; writes: hPlayerFacing, wC928, wC929, wScriptParam0
; points at: hPlayerY, wC8F1, wScriptStep
ScriptCommand99_Run_Case01::
Jump_012_41CC:: ; address name
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ld a, $02
    ldh [hPlayerFacing], a
    ld hl, hPlayerY
    inc [hl]
    ld de, wC8F1
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    jp Jump_012_43C6

; entry 0 of the `rst $00` table in ScriptCommand99_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, wScriptParam0
; writes: wC928, wC929, wScriptParam0
; points at: hFF8C, hPlayerY, hPlayerX, wScriptStep
ScriptCommand99_Run_Case00::
Jump_012_41ED:: ; address name
    ld hl, hFF8C
    call SetBit2AtHL_B12
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank12
    ld de, hPlayerY
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld hl, hPlayerX
    inc [hl]
    jp Jump_012_43C6

; implements script command type 98; reached through ScriptCommand98 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand98)
; reads: wScriptStep
ScriptCommand98_Run::
Func_012_4210:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand98_Run_Case00
    dw ScriptCommand98_Run_Case01
    dw ScriptCommand98_Run_Case02
    dw ScriptCommand98_Run_Case03
    dw ScriptCommand98_Run_Case04
    dw ScriptCommand98_Run_Case05
    dw ScriptCommand98_Run_Case06
    dw ScriptCommand98_Run_Case07
    dw ScriptCommand98_Run_Case08
    dw ScriptCommand98_Run_Case09
    dw ScriptCommand98_Run_Case0A
    dw ScriptCommand99_Run_Case0B

; entry 11 of the `rst $00` table in ScriptCommand99_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
; points at: hFF8C
ScriptCommand99_Run_Case0B::
Jump_012_422C:: ; address name
    ld hl, hFF8C
    call ClearBit2AtHL_Bank12
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 10 of the `rst $00` table in ScriptCommand98_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC8FA
; writes: wC8F9, wC8FA
; points at: wC8FB
ScriptCommand98_Run_Case0A::
Jump_012_4238:: ; address name
    ld a, $03
    ld [wC8F9], a
    ld a, [wC8FA]
    dec a
    ld [wC8FA], a
    ld de, wC8FB
    call ScriptApplyStepDeltaAtDE_Bank12
    ret

; entry 9 of the `rst $00` table in ScriptCommand98_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wC6FD
; writes: wC8F4, wScriptStep
; points at: wC8F6, wC8F5, wC8FB
ScriptCommand98_Run_Case09::
Jump_012_424B:: ; address name
    ld a, $03
    ld [wC8F4], a
    ld de, wC8F6
    call ScriptApplyStepDeltaAtDE_Bank12
    ld hl, wC8F5
    dec [hl]
    ld hl, wC8FB
    dec [hl]
    ld a, [wScriptParam0]
    or a, a
    ret nz
    ld a, [wC6FD]
    dec a
    dec a
    ret nz
    ld a, $0B
    ld [wScriptStep], a
    ret

; entry 8 of the `rst $00` table in ScriptCommand98_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC8F0, wScriptParam0, wC6FD
; writes: wFollowerRecords, wC8F0, wScriptStep
; points at: wC8F1, wC8F6, wC8FB
ScriptCommand98_Run_Case08::
Jump_012_426F:: ; address name
    ld a, $03
    ld [wFollowerRecords], a
    ld de, wC8F1
    call ScriptApplyStepDeltaAtDE_Bank12
    ld a, [wC8F0]
    dec a
    ld [wC8F0], a
    ld hl, wC8F6
    dec [hl]
    ld hl, wC8FB
    dec [hl]
    ld a, [wScriptParam0]
    or a, a
    ret nz
    ld a, [wC6FD]
    dec a
    ret nz
    ld a, $0B
    ld [wScriptStep], a
    ret

; entry 7 of the `rst $00` table in ScriptCommand98_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: hPlayerFacing, hPlayerX
; points at: hPlayerY, wC8F1, wC8F6, wC8FB
ScriptCommand98_Run_Case07::
Jump_012_4299:: ; address name
    ld a, $03
    ldh [hPlayerFacing], a
    ld de, hPlayerY
    call ScriptApplyStepDeltaAtDE_Bank12
    ldh a, [hPlayerX]
    dec a
    ldh [hPlayerX], a
    ld hl, wC8F1
    dec [hl]
    ld hl, wC8F6
    dec [hl]
    ld hl, wC8FB
    dec [hl]
    ret

; DE = address of a byte: adds the step delta for wScriptParam0, then wScriptParam0 += 2; at $20 it is reset and wScriptStep += 1 (the bank-$12 form of ScriptApplyStepDeltaAtDE) (E-0117)
; 8 call sites from 8 routines (e.g. ScriptCommand99_Run_Case0A, ScriptCommand99_Run_Case09, ScriptCommand99_Run_Case08, ScriptCommand99_Run_Case07, ...)
; reads: wScriptParam0
; writes: wC928, wC929, wScriptParam0
; points at: wScriptStep
ScriptApplyStepDeltaAtDE_Bank12::
Func_012_42B5:: ; address name
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
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommand98_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: hPlayerY
; points at: wScriptStep
ScriptCommand98_Run_Case06::
Jump_012_42D7:: ; address name
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ldh a, [hPlayerY]
    dec a
    ldh [hPlayerY], a
    cp a, $50
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in ScriptCommand98_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hPlayerFacing, wFollowerRecords, wC8F4, wC8F9, wC8F1, wC8F6, wC8FB
; points at: hFF8C, wScriptStep
ScriptCommand98_Run_Case05::
Jump_012_42E9:: ; address name
    ld a, $02
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld a, $C0
    ld [wC8F1], a
    ld a, $D0
    ld [wC8F6], a
    ld a, $E0
    ld [wC8FB], a
    ld hl, hFF8C
    call SetBit2AtHL_B12
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand98_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC8FB
; writes: wC8FB, hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6
; points at: hPlayerY, wC8F1, wC8F6
ScriptCommand98_Run_Case04::
Jump_012_4310:: ; address name
    ld hl, hPlayerY
    dec [hl]
    ld hl, wC8F1
    dec [hl]
    ld hl, wC8F6
    dec [hl]
    ld a, [wC8FB]
    dec a
    ld [wC8FB], a
    cp a, $F0
    ret nz
    ld a, $1A
    ldh [hMapId], a
    ld a, $02
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $60
    ld [wC8C8], a
    ld a, $B0
    ld [wC8C9], a
    xor a, a
    ld [wC8C6], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; entry 3 of the `rst $00` table in ScriptCommand98_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wC8F9, wC928, wC929, wScriptParam0
; points at: hPlayerY, wC8F1, wC8F6, wC8FB, wScriptStep
ScriptCommand98_Run_Case03::
Jump_012_4346:: ; address name
    ld a, $02
    ld [wC8F9], a
    ld hl, hPlayerY
    dec [hl]
    ld hl, wC8F1
    dec [hl]
    ld hl, wC8F6
    dec [hl]
    ld hl, wC8FB
    dec [hl]
    ld de, wC8FB
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    jr Jump_012_43C6

; entry 2 of the `rst $00` table in ScriptCommand98_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wScriptParam0
; writes: wC928, wC929, wScriptParam0
; points at: hPlayerY, wC8F6, wScriptStep
ScriptCommand98_Run_Case02::
Jump_012_436E:: ; address name
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ld hl, hPlayerY
    dec [hl]
    ld de, wC8F6
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    jr Jump_012_43C6

; entry 1 of the `rst $00` table in ScriptCommand98_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wScriptParam0
; writes: wC928, wC929, wScriptParam0
; points at: hPlayerY, wC8F1, wScriptStep
ScriptCommand98_Run_Case01::
Jump_012_438A:: ; address name
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ld hl, hPlayerY
    dec [hl]
    ld de, wC8F1
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    jr Jump_012_43C6

; entry 0 of the `rst $00` table in ScriptCommand98_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wScriptParam0
; writes: wC928, wC929, wScriptParam0
; points at: hFF8C, hPlayerY, wScriptStep
ScriptCommand98_Run_Case00::
Jump_012_43A6:: ; address name
    ld hl, hFF8C
    call SetBit2AtHL_B12
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ld de, hPlayerY
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld hl, hPlayerY
    dec [hl]

Jump_012_43C6::
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 96; reached through ScriptCommand96 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand96)
; reads: wScriptStep
ScriptCommand96_Run::
Func_012_43DA:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand96_Run_Case00
    dw ScriptCommand96_Run_Case01
    dw ScriptCommand96_Run_Case02
    dw ScriptCommand96_Run_Case03
    dw ScriptCommand96_Run_Case04
    dw ScriptCommand96_Run_Case05
    dw ScriptCommand96_Run_Case03
    dw ScriptCommand96_Run_Case07
    dw ScriptCommand96_Run_Case08
    dw ScriptCommand96_Run_Case09
    dw ScriptCommand96_Run_Case0A
    dw ScriptCommand96_Run_Case03
    dw ScriptCommand96_Run_Case04
    dw ScriptCommand96_Run_Case0D
    dw ScriptCommand96_Run_Case03
    dw ScriptCommand96_Run_Case07
    dw ScriptCommand96_Run_Case08
    dw ScriptCommand96_Run_Case09
    dw ScriptCommand96_Run_Case12
    dw ScriptCommand96_Run_Case03
    dw ScriptCommand96_Run_Case04
    dw ScriptCommand96_Run_Case15
    dw ScriptCommand96_Run_Case03
    dw ScriptCommand96_Run_Case17
    dw ScriptCommand96_Run_Case18
    dw ScriptCommand96_Run_Case19

; entry 21 of the `rst $00` table in ScriptCommand96_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep, wD7FF
ScriptCommand96_Run_Case15::
Jump_012_4412:: ; address name
    ld a, $07
    call StartMessageFromTable48B9ByWC82C
    ld hl, wScriptStep
    inc [hl]
    ld hl, wD7FF
    dec [hl]
    ret

; entry 13 of the `rst $00` table in ScriptCommand96_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD7FF
; writes: wScriptStep
; points at: wD7FF, wScriptStep
ScriptCommand96_Run_Case0D::
Jump_012_4420:: ; address name
    ld hl, wD7FF
    dec [hl]
    ld a, [wD7FF]
    cp a, $02
    jr nz, Jump_012_4437
    ld a, $07
    call StartMessageFromTable48B9ByWC82C
    ld a, $16
    ld [wScriptStep], a
    jr Jump_012_4440

Jump_012_4437::
    ld a, $05
    call StartMessageFromTable48B9ByWC82C
    ld hl, wScriptStep
    inc [hl]

Jump_012_4440::
    farcall IncWD588AndCopyWD7FCToWD78C
    farcall ScriptCommand96_Run_Shared01
    ret

; entry 5 of the `rst $00` table in ScriptCommand96_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD7FF
; writes: wScriptStep
; points at: wD7FF, wScriptStep
ScriptCommand96_Run_Case05::
Jump_012_444D:: ; address name
    ld hl, wD7FF
    dec [hl]
    ld a, [wD7FF]
    cp a, $02
    jr nz, Jump_012_4464
    ld a, $07
    call StartMessageFromTable48B9ByWC82C
    ld a, $16
    ld [wScriptStep], a
    jr Jump_012_446D

Jump_012_4464::
    ld a, $03
    call StartMessageFromTable48B9ByWC82C
    ld hl, wScriptStep
    inc [hl]

Jump_012_446D::
    farcall IncWD588AndCopyWD7FCToWD78C
    farcall ScriptCommand96_Run_Shared01
    ret

; entry 1 of the `rst $00` table in ScriptCommand96_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFF8D, hPlayerFacing, wC8F1, wC8F4, wC8F9, hPlayerX, wC8F0, wC8F5, ...
; points at: hFF8C, wC94A, wScriptStep
ScriptCommand96_Run_Case01::
Jump_012_447A:: ; address name
    ld a, $0E
    ldh [hFF8D], a
    xor a, a
    call RunMessageBoxThenContinue_684A
    ret nc
    ld hl, hFF8C
    call SetBit2AtHL_B12
    xor a, a
    ldh [hPlayerFacing], a
    ld [wC8F1], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld a, $40
    ldh [hPlayerX], a
    ld [wC8F0], a
    ld [wC8F5], a
    ld [wC8FA], a
    ld hl, wC94A
    inc [hl]
    xor a, a
    ld [wMessageIndex], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand96_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD7FC
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6, wC94A
ScriptCommand96_Run_Case00::
Jump_012_44AF:: ; address name
    ld a, $0B
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $E0
    ld [wC8C8], a
    ld a, $00
    ld [wC8C9], a
    ld a, $00
    ld [wC8C6], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, [wD7FC]
    add a, $05
    call StartMessageA
    ld a, $80
    ld [wC94A], a
    ret

; implements script command type 95; reached through ScriptCommand95 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand95)
; reads: wScriptStep
ScriptCommand95_Run::
Func_012_44DB:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand95_Run_Case00
    dw ScriptCommand95_Run_Case01
    dw ScriptCommand95_Run_Case02
    dw ScriptCommand96_Run_Case02
    dw ScriptCommand96_Run_Case03
    dw ScriptCommand96_Run_Case04
    dw ScriptCommand95_Run_Case06
    dw ScriptCommand96_Run_Case03
    dw ScriptCommand96_Run_Case07
    dw ScriptCommand96_Run_Case08
    dw ScriptCommand96_Run_Case09
    dw ScriptCommand96_Run_Case0A
    dw ScriptCommand96_Run_Case03
    dw ScriptCommand96_Run_Case04
    dw ScriptCommand95_Run_Case0E
    dw ScriptCommand96_Run_Case03
    dw ScriptCommand96_Run_Case07
    dw ScriptCommand96_Run_Case08
    dw ScriptCommand96_Run_Case09
    dw ScriptCommand96_Run_Case12
    dw ScriptCommand96_Run_Case03
    dw ScriptCommand96_Run_Case04
    dw ScriptCommand95_Run_Case16
    dw ScriptCommand96_Run_Case03
    dw ScriptCommand96_Run_Case17
    dw ScriptCommand96_Run_Case18
    dw ScriptCommand96_Run_Case19

; entry 25 of the `rst $00` table in ScriptCommand96_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC91C, wC91D, wC91E
; writes: wC917, wC916, wScriptStartRequest, wScriptPointerLo, wScriptPointerHi, hFFB9, wScriptCommandType, wScriptInDataBank
ScriptCommand96_Run_Case19::
Jump_012_4515:: ; address name
    farcall RestartMapMusic
    ld a, $01
    ld [wC917], a
    ld a, $65
    ld [wC916], a
    ld a, [wC91C]
    ld [wScriptStartRequest], a
    ld a, [wC91D]
    ld [wScriptPointerLo], a
    ld a, [wC91E]
    ld [wScriptPointerHi], a
    ld a, $02
    ldh [hFFB9], a
    ld a, $F7
    ld [wScriptCommandType], a
    ld a, $01
    ld [wScriptInDataBank], a
    ret

; entry 24 of the `rst $00` table in ScriptCommand96_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6
ScriptCommand96_Run_Case18::
Jump_012_4546:: ; address name
    call FullyHealParty
    ld a, $04
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wC8C8], a
    ld a, $30
    ld [wC8C9], a
    ld a, $03
    ld [wC8C6], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; entry 23 of the `rst $00` table in ScriptCommand96_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0
; points at: wScriptStep
ScriptCommand96_Run_Case17::
Jump_012_456A:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $01
    jr nz, Jump_012_457B
    ld a, $6D
    call QueueSoundEffect
    ret

Jump_012_457B::
    cp a, $3C
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 22 of the `rst $00` table in ScriptCommand95_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep, wD7FF
ScriptCommand95_Run_Case16::
Jump_012_4587:: ; address name
    ld a, $07
    call StartMessageFromTable48B9ByWC82C
    ld hl, wScriptStep
    inc [hl]
    ld hl, wD7FF
    dec [hl]
    ret

; entry 18 of the `rst $00` table in ScriptCommand96_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand96_Run_Case12::
Jump_012_4595:: ; address name
    ld a, $06
    call StartMessageFromTable48B9ByWC82C
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 14 of the `rst $00` table in ScriptCommand95_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC82C
; points at: wScriptStep, wD7FF
ScriptCommand95_Run_Case0E::
Jump_012_459F:: ; address name
    ld a, $05
    call StartMessageFromTable48B9ByWC82C
    ld hl, wScriptStep
    inc [hl]
    ld hl, wD7FF
    dec [hl]
    ld a, [wC82C]
    or a, a
    jr nz, Jump_012_45BF
    farcall SetupWD78EFromWD7FF
    farcall ScriptCommand95_Run_Shared01
    ret

Jump_012_45BF::
    farcall SetupWD78EFromWD7FF
    farcall ScriptCommand95_Run_Shared02
    ret

; entry 10 of the `rst $00` table in ScriptCommand96_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand96_Run_Case0A::
Jump_012_45CC:: ; address name
    ld a, $04
    call StartMessageFromTable48B9ByWC82C
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in ScriptCommand96_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCB8B
; writes: wCB86, wCB8B, wC90D, wCB96, wCBA6, wCBB6
; points at: wCB8C, wCB9C, wCBAC, wCBBC, wScriptStep
ScriptCommand96_Run_Case09::
Jump_012_45D6:: ; address name
    ld a, $02
    ld [wCB86], a
    ld a, [wCB8B]
    dec a
    ld [wCB8B], a
    cp a, $30
    ret nz
    ld a, $07
    ld [wC90D], a
    ld a, $03
    ld [wCB86], a
    ld [wCB96], a
    ld [wCBA6], a
    ld [wCBB6], a
    ld hl, wCB8C
    call ClearBit2AtHL_Bank12
    ld hl, wCB9C
    call ClearBit2AtHL_Bank12
    ld hl, wCBAC
    call ClearBit2AtHL_Bank12
    ld hl, wCBBC
    call ClearBit2AtHL_Bank12
    ld a, $00
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 8 of the `rst $00` table in ScriptCommand96_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex
; writes: wMessageIndex, wSpriteSlotCount
; points at: wCB8B, wScriptStep
ScriptCommand96_Run_Case08::
Jump_012_461A:: ; address name
    ld a, [wMessageIndex]
    cp a, $60
    jr z, Jump_012_4644
    inc a
    ld [wMessageIndex], a
    cp a, $10
    jr nz, Jump_012_4630
    ld a, $02
    ld [wSpriteSlotCount], a
    jr Jump_012_4644

Jump_012_4630::
    cp a, $20
    jr nz, Jump_012_463B
    ld a, $03
    ld [wSpriteSlotCount], a
    jr Jump_012_4644

Jump_012_463B::
    cp a, $30
    jr nz, Jump_012_4644
    ld a, $04
    ld [wSpriteSlotCount], a

Jump_012_4644::
    ld hl, wCB8B
    ld b, $04

Jump_012_4649::
    push hl
    ld a, [hl]
    bit 7, a
    jr nz, Jump_012_4653
    cp a, $20
    jr nc, Jump_012_4659

Jump_012_4653::
    ld a, [hl]
    inc a
    ld [hl], a
    jp Jump_012_4692

Jump_012_4659::
    dec hl
    ld a, [hl]
    cp a, $60
    jr nc, Jump_012_466B
    ld a, [hl]
    inc a
    ld [hl], a
    dec hl
    dec hl
    dec hl
    dec hl
    ld [hl], $01
    jp Jump_012_4692

Jump_012_466B::
    inc hl
    ld a, [hl]
    cp a, $40
    jr nc, Jump_012_467E
    ld a, [hl]
    inc a
    ld [hl], a
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    ld [hl], $00
    jp Jump_012_4692

Jump_012_467E::
    dec hl
    ld a, [hl]
    inc a
    ld [hl], a
    push af
    dec hl
    dec hl
    dec hl
    dec hl
    ld [hl], $01
    pop af
    cp a, $70
    jr nz, Jump_012_4692
    ld hl, wScriptStep
    inc [hl]

Jump_012_4692::
    pop hl
    ld a, $10
    add_a_to_hl
    dec b
    jr nz, Jump_012_4649
    ret

; entry 7 of the `rst $00` table in ScriptCommand96_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC527, wSpriteSlotCount, wC90D, wMessageIndex
; points at: wCB8C, wCB9C, wCBAC, wCBBC, wScriptStep
ScriptCommand96_Run_Case07::
Jump_012_469E:: ; address name
    farcall Func_085_5B53
    ld a, $7F
    ld [wC527], a
    ld a, $01
    ld [wSpriteSlotCount], a
    ld hl, wCB8C
    call SetBit2AtHL_B12
    ld hl, wCB9C
    call SetBit2AtHL_B12
    ld hl, wCBAC
    call SetBit2AtHL_B12
    ld hl, wCBBC
    call SetBit2AtHL_B12
    xor a, a
    ld [wC90D], a
    ld a, $6D
    call QueueSoundEffect
    xor a, a
    ld [wMessageIndex], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommand95_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC82C
; points at: wScriptStep, wD7FF
ScriptCommand95_Run_Case06::
Jump_012_46D8:: ; address name
    ld a, $03
    call StartMessageFromTable48B9ByWC82C
    ld hl, wScriptStep
    inc [hl]
    ld hl, wD7FF
    dec [hl]
    ld a, [wC82C]
    or a, a
    jr nz, Jump_012_46F8
    farcall SetupWD78EFromWD7FF
    farcall ScriptCommand95_Run_Shared01
    ret

Jump_012_46F8::
    farcall SetupWD78EFromWD7FF
    farcall ScriptCommand95_Run_Shared02
    ret

; entry 4 of the `rst $00` table in ScriptCommand96_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC903, wC905
; points at: wC8F0, wC8F5, wC8FA, wCB9A, wCBAA, wCBBA, wScriptStep, wD7FF
ScriptCommand96_Run_Case04::
Jump_012_4705:: ; address name
    ld hl, wC8F0
    inc [hl]
    ld hl, wC8F5
    inc [hl]
    ld hl, wC8FA
    inc [hl]
    ld hl, wCB9A
    dec [hl]
    ld hl, wCBAA
    dec [hl]
    ld hl, wCBBA
    dec [hl]
    ld b, $10
    call StepWC921Counter_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ld hl, wD7FF
    inc [hl]
    ld a, $04
    ld [wC903], a
    ld a, $01
    ld [wC905], a
    farcall SetModeState3AndSaveScreen
    ret

; entry 3 of the `rst $00` table in ScriptCommand96_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wMessageIndex
; points at: wScriptStep
ScriptCommand96_Run_Case03::
Jump_012_473C:: ; address name
    xor a, a
    call RunMessageBoxThenContinue_684A
    ret nc
    xor a, a
    ld [wMessageIndex], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand96_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wScriptParam0, hPlayerY, hPlayerX, wScriptParam1
; writes: wMessageIndex, hFF8D, hPlayerY, hPlayerFacing, hPlayerX, wFollowerRecords, wC8F4, wC8F9, ...
; points at: hFF8C, wScriptParam0, wScriptStep
ScriptCommand96_Run_Case02::
Jump_012_474A:: ; address name
    ld hl, hFF8C
    call SetBit2AtHL_B12
    ld a, [wMessageIndex]
    cp a, $60
    jr z, Jump_012_4776
    inc a
    ld [wMessageIndex], a
    cp a, $10
    jr nz, Jump_012_4765
    ld a, $0C
    ldh [hFF8D], a
    jr Jump_012_4776

Jump_012_4765::
    cp a, $20
    jr nz, Jump_012_476F
    ld a, $08
    ldh [hFF8D], a
    jr Jump_012_4776

Jump_012_476F::
    cp a, $30
    jr nz, Jump_012_4776
    xor a, a
    ldh [hFF8D], a

Jump_012_4776::
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_012_478E
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp a, $20
    ret nz
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_012_478E::
    dec a
    jr nz, Jump_012_47A7
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank12
    ld a, $03
    ldh [hPlayerFacing], a
    ldh a, [hPlayerX]
    dec a
    ldh [hPlayerX], a
    cp a, $30
    ret nz
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_012_47A7::
    dec a
    jr nz, Jump_012_47BF
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    xor a, a
    ldh [hPlayerFacing], a
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp a, $40
    ret nz
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_012_47BF::
    dec a
    jr nz, Jump_012_47D8
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank12
    ld a, $03
    ldh [hPlayerFacing], a
    ldh a, [hPlayerX]
    dec a
    ldh [hPlayerX], a
    cp a, $20
    ret nz
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_012_47D8::
    ld a, $02
    ldh [hPlayerFacing], a
    ldh a, [hPlayerY]
    dec a
    ldh [hPlayerY], a
    cp a, $30
    ret nz
    ld hl, hFF8C
    call ClearBit2AtHL_Bank12
    ld a, $01
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld a, $02
    call StartMessageFromTable48B9ByWC82C
    ld a, [wScriptParam1]
    ld [wC90D], a
    ld a, $00
    call QueueSoundEffect
    xor a, a
    ld [wScriptParam0], a
    xor a, a
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand95_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC90D
; writes: hPlayerFacing, wC8F1, wC8F4, wC8F9, hPlayerX, wC8F0, wC8F5, wC8FA, ...
; points at: hFF8C, wScriptStep
ScriptCommand95_Run_Case02::
Jump_012_4814:: ; address name
    xor a, a
    call RunMessageBoxThenContinue_684A
    ret nc
    ld hl, hFF8C
    call SetBit2AtHL_B12
    xor a, a
    ldh [hPlayerFacing], a
    ld [wC8F1], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld a, $40
    ldh [hPlayerX], a
    ld [wC8F0], a
    ld [wC8F5], a
    ld [wC8FA], a
    ld a, $6D
    call QueueSoundEffect
    ld a, [wC90D]
    ld [wScriptParam1], a
    xor a, a
    ld [wC90D], a
    xor a, a
    ld [wMessageIndex], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand95_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFF8D
; points at: wScriptStep
ScriptCommand95_Run_Case01::
Jump_012_4850:: ; address name
    xor a, a
    call RunMessageBoxThenContinue_684A
    ret nc
    ld a, $01
    call StartMessageFromTable48B9ByWC82C
    ld a, $0E
    ldh [hFF8D], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand95_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6, wC94A
ScriptCommand95_Run_Case00::
Jump_012_4863:: ; address name
    ld a, $0B
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $E0
    ld [wC8C8], a
    ld a, $00
    ld [wC8C9], a
    ld a, $00
    ld [wC8C6], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $00
    call StartMessageFromTable48B9ByWC82C
    xor a, a
    ld [wC94A], a
    ret

; starts the message at Data_012_48B9 + 2 * A + 16 * wC82C (16 * 5 when bit 7 of wC94A is set) (E-0125)
; 13 call sites from 11 routines (e.g. ScriptCommand96_Run_Case15, ScriptCommand96_Run_Case0D, ScriptCommand96_Run_Case05, ScriptCommand95_Run_Case16, ...)
; reads: wC94A, wC82C
StartMessageFromTable48B9ByWC82C::
Func_012_488B:: ; address name
    ld de, Data_012_48B9
    sla a
    add a, e
    ld e, a
    jr nc, Jump_012_4895
    inc d

Jump_012_4895::
    ld a, [wC94A]
    bit 7, a
    jr nz, Jump_012_48AB
    ld a, [wC82C]
    swap a
    add a, e
    ld e, a
    jr nc, Jump_012_48A6
    inc d

Jump_012_48A6::
    ld a, [de]
    call StartMessageA
    ret

Jump_012_48AB::
    ld a, $05
    swap a
    add a, e
    ld e, a
    jr nc, Jump_012_48B4
    inc d

Jump_012_48B4::
    ld a, [de]
    call StartMessageA
    ret

Data_012_48B9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0488B9, $60

; implements script command type 9F; reached through ScriptCommand9F in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand9F)
; reads: wScriptStep
ScriptCommand9F_Run::
Func_012_4919:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand9F_Run_Case00
    dw ScriptCommand9F_Run_Case01
    dw ScriptCommand9F_Run_Case02
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case04
    dw ScriptCommand9F_Run_Case05
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case07
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case0A
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case0D
    dw ScriptCommand9F_Run_Case0E
    dw ScriptCommand9F_Run_Case0F
    dw ScriptCommand9F_Run_Case01
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case12
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case0A
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case16

; entry 22 of the `rst $00` table in ScriptCommand9F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC965
; writes: wC88D, wGameMode, wModeState, wModeChangeRequest, wScriptRunning
ScriptCommand9F_Run_Case16::
Jump_012_494B:: ; address name
    ld a, [wC965]
    ld [wC88D], a
    ld a, $08
    ld [wGameMode], a
    ld a, $00
    ld [wModeState], a
    ld a, $01
    ld [wModeChangeRequest], a
    xor a, a
    ld [wScriptRunning], a
    ret

; implements script command type 8F; reached through ScriptCommand8F in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand8F)
; reads: wScriptStep
ScriptCommand8F_Run::
Func_012_4965:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand8F_Run_Case00
    dw ScriptCommand9F_Run_Case00
    dw ScriptCommand9F_Run_Case01
    dw ScriptCommand9F_Run_Case02
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case04
    dw ScriptCommand9F_Run_Case05
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case07
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case0A
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case0D
    dw ScriptCommand9F_Run_Case0E
    dw ScriptCommand9F_Run_Case0F
    dw ScriptCommand9F_Run_Case01
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case12
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case0A
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand8F_Run_Case17
    dw ScriptCommand8F_Run_Case18

; entry 24 of the `rst $00` table in ScriptCommand8F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC937, wC91C, wC91D, wC91E
; writes: wCB86, wC917, wC916, wScriptStartRequest, wScriptPointerLo, wScriptPointerHi, wScriptCommandType, wScriptInDataBank
ScriptCommand8F_Run_Case18::
Jump_012_499B:: ; address name
    ld a, [wC937]
    ld [wCB86], a
    ld a, $01
    ld [wC917], a
    ld a, $89
    ld [wC916], a
    ld a, [wC91C]
    ld [wScriptStartRequest], a
    ld a, [wC91D]
    ld [wScriptPointerLo], a
    ld a, [wC91E]
    ld [wScriptPointerHi], a
    ld a, $F4
    ld [wScriptCommandType], a
    ld a, $01
    ld [wScriptInDataBank], a
    ret

; entry 23 of the `rst $00` table in ScriptCommand8F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD7FB
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, hFF8D, wC8C6, wC936
ScriptCommand8F_Run_Case17::
Jump_012_49C8:: ; address name
    ld a, [wD7FB]
    ld hl, Data_012_4A14
    add_a_to_hl
    ld a, [hl]
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, [wD7FB]
    cp a, $01
    jr z, Jump_012_49F6
    cp a, $03
    jr z, Jump_012_49F6
    cp a, $05
    jr z, Jump_012_49F6
    cp a, $06
    jr z, Jump_012_49F6
    cp a, $07
    jr z, Jump_012_49F6
    ld a, $02
    ldh [hMapScreenX], a

Jump_012_49F6::
    ld a, $40
    ld [wC8C8], a
    ld a, $40
    ld [wC8C9], a
    xor a, a
    ldh [hFF8D], a
    ld a, $00
    ld [wC8C6], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $01
    ld [wC936], a
    ret

Data_012_4A14:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $04, $17, $04, $17, $04, $17, $17, $17, $04, $04

; implements script command type 8D; reached through ScriptCommand8D in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand8D)
; reads: wScriptStep
ScriptCommand8D_Run::
Func_012_4A1E:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand8F_Run_Case00
    dw ScriptCommand9F_Run_Case00
    dw ScriptCommand9F_Run_Case01
    dw ScriptCommand9F_Run_Case02
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case04
    dw ScriptCommand9F_Run_Case05
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case07
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case0A
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case0D
    dw ScriptCommand9F_Run_Case0E
    dw ScriptCommand9F_Run_Case0F
    dw ScriptCommand8D_Run_Case11
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand8D_Run_Case14
    dw ScriptCommand8D_Run_Case15
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand8D_Run_Case19
    dw ScriptCommand8D_Run_Case1A
    dw ScriptCommand8D_Run_Case1B

; entry 17 of the `rst $00` table in ScriptCommand8D_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCB91, hFFC6, wCB92, hFFC7, hFFC8, hFFC9, hFFCA, hFFCB, ...
; points at: wCAD0, wScriptStep
ScriptCommand8D_Run_Case11::
Jump_012_4A5A:: ; address name
    ld a, $0B
    ld hl, wCAD0
    add_a_to_hl
    ld a, [hl+]
    ld [wCB91], a
    ldh [hFFC6], a
    ld a, [hl]
    ld [wCB92], a
    ldh [hFFC7], a
    xor a, a
    ldh [hFFC8], a
    ld a, $06
    ldh [hFFC9], a
    ld hl, vTiles0 + $600
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    farcall DecompressGraphicsHFFC6ToHFFCA
    ld a, $0D
    ldh [hFFC6], a
    farcall RunFieldCommandHFFC6
    ld a, $7F
    ld [wC527], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 8C; reached through ScriptCommand8C in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand8C)
; reads: wScriptStep
ScriptCommand8C_Run::
Func_012_4A9A:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand8F_Run_Case00
    dw ScriptCommand8C_Run_Case01
    dw ScriptCommand9F_Run_Case01
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand8C_Run_Case04
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case0A
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand8D_Run_Case14
    dw ScriptCommand8D_Run_Case15
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand8D_Run_Case19
    dw ScriptCommand8D_Run_Case1A
    dw ScriptCommand8D_Run_Case1B

; entry 27 of the `rst $00` table in ScriptCommand8D_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC91C, wC91D, wC91E
; writes: hMapId, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY, wCBCF, wSpriteSlotCount, wC90D, ...
ScriptCommand8D_Run_Case1B::
Jump_012_4AC0:: ; address name
    ld a, $0D
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $40
    ldh [hPlayerX], a
    ld a, $40
    ldh [hPlayerY], a
    xor a, a
    ld [wCBCF], a
    xor a, a
    ld [wSpriteSlotCount], a
    xor a, a
    ld [wC90D], a
    ld a, $01
    ld [wC917], a
    ld a, $6A
    ld [wC916], a
    ld a, [wC91C]
    ld [wScriptStartRequest], a
    ld a, [wC91D]
    ld [wScriptPointerLo], a
    ld a, [wC91E]
    ld [wScriptPointerHi], a
    ld a, $02
    ldh [hFFB9], a
    ld a, $ED
    ld [wScriptCommandType], a
    ld a, $01
    ld [wScriptInDataBank], a
    ret

; entry 26 of the `rst $00` table in ScriptCommand8D_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: hFFB9
; points at: wScriptStep
ScriptCommand8D_Run_Case1A::
Jump_012_4B0A:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ld a, [wScriptParam0]
    ldh [hFFB9], a
    ret

; entry 25 of the `rst $00` table in ScriptCommand8D_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hFFB9
; writes: wStringIndex, wStringCategory, wStringDestLo, wStringDestHi, wScriptParam0, hFFB9
; points at: wScriptStep, wCAD0, wC151, wC17E
ScriptCommand8D_Run_Case19::
Jump_012_4B19:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, wCAD0
    ld a, $0B
    add_a_to_hl
    ld a, [hl+]
    ld [wStringIndex], a
    ld a, [hl]
    inc a
    inc a
    ld [wStringCategory], a
    ld de, wC151
    ld a, e
    ld [wStringDestLo], a
    ld a, d
    ld [wStringDestHi], a
    farcall CopyStringToBuffer_Bank08
    ld hl, wCAD0
    ld a, $6D
    add_a_to_hl
    ld a, [hl]
    or a, a
    jr nz, Jump_012_4B56
    ld a, $17
    call StartMessageA
    ret

Jump_012_4B56::
    ld b, a
    ld a, $0A
    call DivideBByA
    ld hl, wC17E
    push af
    ld a, b
    or a, a
    jr z, Jump_012_4B65
    ld [hl+], a

Jump_012_4B65::
    pop af
    ld [hl+], a
    ld [hl], $F0
    ld a, $18
    call StartMessageA
    ldh a, [hFFB9]
    ld [wScriptParam0], a
    xor a, a
    ldh [hFFB9], a
    ret

; entry 21 of the `rst $00` table in ScriptCommand8D_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wCBCF, wCB96, wCB9B
; points at: wScriptStep
ScriptCommand8D_Run_Case15::
Jump_012_4B77:: ; address name
    ld a, [wScriptParam0]
    cp a, $C2
    jr nz, Jump_012_4B83
    ld a, $74
    call QueueSoundEffect

Jump_012_4B83::
    ld b, $E0
    call StepWC921Counter_Bank12
    ret nc
    xor a, a
    ld [wCBCF], a
    xor a, a
    ld [wCB96], a
    ld a, $3C
    ld [wCB9B], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 20 of the `rst $00` table in ScriptCommand8D_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6
; points at: wScriptStep
ScriptCommand8D_Run_Case14::
Jump_012_4B9B:: ; address name
    ld a, $0E
    ldh [hFFC6], a
    farcall RunFieldCommandHFFC6
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand8C_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF
; points at: wScriptStep
ScriptCommand8C_Run_Case04::
Jump_012_4BAA:: ; address name
    ld a, $80
    ld [wCBCF], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand8C_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hFF8D
; writes: hFFB9, hFF8D, wCB91, hFFC6, wCB92, hFFC7, hFFC8, hFFC9, ...
; points at: wCAD0, wCB8C, wScriptStep
ScriptCommand8C_Run_Case01::
Jump_012_4BB4:: ; address name
    xor a, a
    ldh [hFFB9], a
    ldh a, [hFF8D]
    or a, $0F
    ldh [hFF8D], a
    ld a, $0B
    ld hl, wCAD0
    add_a_to_hl
    ld a, [hl+]
    ld [wCB91], a
    ldh [hFFC6], a
    ld a, [hl]
    ld [wCB92], a
    ldh [hFFC7], a
    xor a, a
    ldh [hFFC8], a
    ld a, $06
    ldh [hFFC9], a
    ld hl, vTiles0 + $600
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    farcall DecompressGraphicsHFFC6ToHFFCA
    ld a, $0D
    ldh [hFFC6], a
    farcall RunFieldCommandHFFC6
    xor a, a
    ld [wCBCF], a
    ld a, $7F
    ld [wC527], a
    ld hl, wCB8C
    call SetBit2AtHL_B12
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 8B; reached through ScriptCommand8B in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand8B)
; reads: wScriptStep
ScriptCommand8B_Run::
Func_012_4C07:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand8F_Run_Case00
    dw ScriptCommand9F_Run_Case00
    dw ScriptCommand9F_Run_Case01
    dw ScriptCommand9F_Run_Case02
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case04
    dw ScriptCommand9F_Run_Case05
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case07
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case0A
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case0D
    dw ScriptCommand9F_Run_Case0E
    dw ScriptCommand9F_Run_Case0F
    dw ScriptCommand9F_Run_Case01
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case12
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand9F_Run_Case0A
    dw ScriptCommand9F_Run_Case03
    dw ScriptCommand8B_Run_Case17
    dw ScriptCommand8B_Run_Case18

; entry 24 of the `rst $00` table in ScriptCommand8B_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wC91C, wC91D, wC91E
; writes: wC917, wC916, wScriptStartRequest, wScriptPointerLo, wScriptPointerHi, wScriptCommandType, wScriptInDataBank
ScriptCommand8B_Run_Case18::
Jump_012_4C3D:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld a, $01
    ld [wC917], a
    ld a, $6A
    ld [wC916], a
    ld a, [wC91C]
    ld [wScriptStartRequest], a
    ld a, [wC91D]
    ld [wScriptPointerLo], a
    ld a, [wC91E]
    ld [wScriptPointerHi], a
    ld a, $ED
    ld [wScriptCommandType], a
    ld a, $01
    ld [wScriptInDataBank], a
    ret

; entry 23 of the `rst $00` table in ScriptCommand8B_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, hFF8D, wC8C6, wC936
; points at: wScriptStep
ScriptCommand8B_Run_Case17::
Jump_012_4C69:: ; address name
    ld a, $0D
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wC8C8], a
    ld a, $40
    ld [wC8C9], a
    xor a, a
    ldh [hFF8D], a
    ld a, $00
    ld [wC8C6], a
    ld a, $0F
    call StartPaletteFade
    ld a, $01
    ld [wC936], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 18 of the `rst $00` table in ScriptCommand9F_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF
; points at: wScriptStep
ScriptCommand9F_Run_Case12::
Jump_012_4C97:: ; address name
    xor a, a
    ld [wCBCF], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 15 of the `rst $00` table in ScriptCommand9F_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand9F_Run_Case0F::
Jump_012_4CA0:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 14 of the `rst $00` table in ScriptCommand9F_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand9F_Run_Case0E::
Jump_012_4CAA:: ; address name
    ld a, $0E
    call StartMessageA
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in ScriptCommand9F_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC927, hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6
ScriptCommand9F_Run_Case0D::
Jump_012_4CB4:: ; address name
    ld a, $8D
    ld [wC927], a
    jp ScriptCommand8F_Run_Case00

; entry 10 of the `rst $00` table in ScriptCommand9F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCB8B
; writes: wCB86, wCB8B, wCB96, wCBA6
; points at: wCB8C, wScriptStep
ScriptCommand9F_Run_Case0A::
Jump_012_4CBC:: ; address name
    xor a, a
    ld [wCB86], a
    ld hl, wCB8C
    call SetBit2AtHL_B12
    ld a, [wCB8B]
    inc a
    ld [wCB8B], a
    cp a, $C8
    ret nz
    ld a, $01
    ld [wCB96], a
    ld a, $03
    ld [wCBA6], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in ScriptCommand9F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wCBAA
; writes: wCBA6, wScriptParam0, wCBAA
; points at: wScriptStep
ScriptCommand9F_Run_Case07::
Jump_012_4CDF:: ; address name
    ld a, $01
    ld [wCBA6], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    ret nz
    ld a, [wCBAA]
    inc a
    ld [wCBAA], a
    cp a, $58
    ret nz
    xor a, a
    ld [wCBA6], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in ScriptCommand9F_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCBAB
; points at: wScriptStep
ScriptCommand9F_Run_Case05::
Jump_012_4D05:: ; address name
    ld b, $3C
    call StepWC921Counter_Bank12
    ret nc
    ld a, $40
    ld [wCBAB], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand9F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wCB9A
; writes: wCB96, wScriptParam0, wCB9A
; points at: wScriptStep
ScriptCommand9F_Run_Case04::
Jump_012_4D15:: ; address name
    ld a, $03
    ld [wCB96], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    ret nz
    ld a, [wCB9A]
    dec a
    ld [wCB9A], a
    cp a, $48
    ret nz
    xor a, a
    ld [wCB96], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in ScriptCommand9F_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand9F_Run_Case03::
Jump_012_4D3B:: ; address name
    ld b, $1E
    call StepWC921Counter_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand9F_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCB9B
; points at: wScriptStep
ScriptCommand9F_Run_Case02::
Jump_012_4D46:: ; address name
    ld b, $3C
    call StepWC921Counter_Bank12
    ret nc
    ld a, $40
    ld [wCB9B], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand9F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCB8B
; writes: wCB8B
; points at: wCB8C, wScriptStep
ScriptCommand9F_Run_Case01::
Jump_012_4D56:: ; address name
    ld a, [wCB8B]
    dec a
    ld [wCB8B], a
    cp a, $58
    ret nz
    ld hl, wCB8C
    call ClearBit2AtHL_Bank12
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand9F_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hFF8D
; writes: hFFB9, hFF8D, wCB91, hFFC6, wCB92, hFFC7, hFFC8, hFFC9, ...
; points at: wC986, wCA2B, wCB8C, wScriptStep
ScriptCommand9F_Run_Case00::
Jump_012_4D6B:: ; address name
    xor a, a
    ldh [hFFB9], a
    ldh a, [hFF8D]
    or a, $0F
    ldh [hFF8D], a
    ld a, $0B
    ld hl, wC986
    add_a_to_hl
    ld a, [hl+]
    ld [wCB91], a
    ldh [hFFC6], a
    ld a, [hl]
    ld [wCB92], a
    ldh [hFFC7], a
    xor a, a
    ldh [hFFC8], a
    ld a, $06
    ldh [hFFC9], a
    ld hl, vTiles0 + $600
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    farcall DecompressGraphicsHFFC6ToHFFCA
    ld a, $0B
    ld hl, wCA2B
    add_a_to_hl
    ld a, [hl+]
    ld [wCBA1], a
    ldh [hFFC6], a
    ld a, [hl]
    ld [wCBA2], a
    ldh [hFFC7], a
    xor a, a
    ldh [hFFC8], a
    ld a, $07
    ldh [hFFC9], a
    ld hl, vTiles0 + $700
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    farcall DecompressGraphicsHFFC6ToHFFCA
    ld a, $7F
    ld [wC527], a
    ld hl, wCB8C
    call SetBit2AtHL_B12
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand8F_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6
ScriptCommand8F_Run_Case00::
Jump_012_4DDC:: ; address name
    ld a, $14
    ldh [hMapId], a
    xor a, a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $E0
    ld [wC8C8], a
    ld a, $00
    ld [wC8C9], a
    ld a, $00
    ld [wC8C6], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; copies wCB86, the player position and facing, wFollowerRecords and wC8F0-wC8FB fields into wC937-wC943, then advances wScriptStep (E-0121)
; no direct call (reached through a table, a jump or a vector)
; reads: wCB86, hPlayerX, hPlayerY, hPlayerFacing, wFollowerRecords, wC8F0, wC8F1, wC8F4, ...
; writes: wC937, wC938, wC939, wC93A, wC93B, wC93C, wC93D, wC93E, ...
; points at: wScriptStep
SavePlayerPositionStateAndStep:: ; heuristic: follows a terminator; C0
Func_012_4DFB:: ; address name
    ld a, [wCB86]
    ld [wC937], a
    ldh a, [hPlayerX]
    ld [wC938], a
    ldh a, [hPlayerY]
    ld [wC939], a
    ldh a, [hPlayerFacing]
    ld [wC93A], a
    ld a, [wFollowerRecords]
    ld [wC93B], a
    ld a, [wC8F0]
    ld [wC93C], a
    ld a, [wC8F1]
    ld [wC93D], a
    ld a, [wC8F4]
    ld [wC93E], a
    ld a, [wC8F5]
    ld [wC93F], a
    ld a, [wC8F6]
    ld [wC940], a
    ld a, [wC8F9]
    ld [wC941], a
    ld a, [wC8FA]
    ld [wC942], a
    ld a, [wC8FB]
    ld [wC943], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 94; reached through ScriptCommand94 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand94)
; reads: wScriptStep
ScriptCommand94_Run::
Func_012_4E4B:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand94_Run_Case00
    dw ScriptCommand94_Run_Case01
    dw ScriptCommand94_Run_Case02

; implements script command type 93; reached through ScriptCommand93 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand93)
; reads: wScriptStep
ScriptCommand93_Run::
Func_012_4E55:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand94_Run_Case00
    dw ScriptCommand94_Run_Case01
    dw ScriptCommand93_Run_Case02
    dw ScriptCommand93_Run_Case03
    dw ScriptCommand94_Run_Case02

; entry 3 of the `rst $00` table in ScriptCommand93_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC8F6, wC8FB, wC8F1, hPlayerY
; writes: wFollowerRecords, wC8F4, wC8F9, wC8FB, wC8F6, wC8F1, hPlayerY
; points at: hFF8C, wScriptStep
ScriptCommand93_Run_Case03::
Jump_012_4E63:: ; address name
    ld hl, hFF8C
    call SetBit1AtHL_Bank12
    xor a, a
    ld [wFollowerRecords], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld a, [wC8F6]
    cp a, $E0
    jr nc, Jump_012_4E82
    ld a, [wC8FB]
    inc a
    inc a
    ld [wC8FB], a

Jump_012_4E82::
    ld a, [wC8F1]
    cp a, $E0
    jr nc, Jump_012_4E91
    ld a, [wC8F6]
    inc a
    inc a
    ld [wC8F6], a

Jump_012_4E91::
    ldh a, [hPlayerY]
    cp a, $E0
    jr nc, Jump_012_4E9F
    ld a, [wC8F1]
    inc a
    inc a
    ld [wC8F1], a

Jump_012_4E9F::
    ldh a, [hPlayerY]
    inc a
    inc a
    ldh [hPlayerY], a
    cp a, $50
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand93_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: hMapId, hMapScreenX, hMapScreenY, wC8C8, wC8C9, wC8C6
ScriptCommand93_Run_Case02::
Jump_012_4EAD:: ; address name
    ld a, $01
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
    ldh [hMapScreenY], a
    ldh a, [hPlayerX]
    ld [wC8C8], a
    ld a, $F0
    ld [wC8C9], a
    ld a, $00
    ld [wC8C6], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; implements script command type 92; reached through ScriptCommand92 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand92)
; reads: wScriptStep
ScriptCommand92_Run::
Func_012_4ECE:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand94_Run_Case00
    dw ScriptCommand94_Run_Case01
    dw ScriptCommand92_Run_Case02
    dw ScriptCommand92_Run_Case03
    dw ScriptCommand92_Run_Case04
    dw ScriptCommand94_Run_Case02

; entry 4 of the `rst $00` table in ScriptCommand92_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: hPlayerY
; points at: hPlayerY, wScriptStep
ScriptCommand92_Run_Case04::
Jump_012_4EDE:: ; address name
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ld hl, hPlayerY
    inc [hl]
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp a, $20
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 91; reached through ScriptCommand91 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand91)
; reads: wScriptStep
ScriptCommand91_Run::
Func_012_4EF9:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand94_Run_Case00
    dw ScriptCommand91_Run_Case01
    dw ScriptCommand94_Run_Case02

; entry 1 of the `rst $00` table in ScriptCommand91_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: hPlayerY
; points at: hPlayerY, wScriptStep
ScriptCommand91_Run_Case01::
Jump_012_4F03:: ; address name
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ld hl, hPlayerY
    inc [hl]
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp a, $60
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 90; reached through ScriptCommand90 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand90)
; reads: wScriptStep
ScriptCommand90_Run::
Func_012_4F1E:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand94_Run_Case00
    dw ScriptCommand94_Run_Case01
    dw ScriptCommand92_Run_Case02
    dw ScriptCommand92_Run_Case03
    dw ScriptCommand90_Run_Case04
    dw ScriptCommand94_Run_Case02

; entry 2 of the `rst $00` table in ScriptCommand94_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wC6FD
; writes: wScriptStartRequest
; points at: wC8F1, hFF8C
ScriptCommand94_Run_Case02::
Jump_012_4F2E:: ; address name
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ld a, [wC6FD]
    dec a
    ld c, a
    sla a
    sla a
    add a, c
    ld hl, wC8F1
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ldh a, [hPlayerY]
    cp a, c
    ret nz
    ld hl, hFF8C
    call ClearBit1AtHL_Bank12
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 4 of the `rst $00` table in ScriptCommand90_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: hPlayerY
; points at: hPlayerY, wScriptStep
ScriptCommand90_Run_Case04::
Jump_012_4F5C:: ; address name
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ld hl, hPlayerY
    inc [hl]
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp a, $50
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in ScriptCommand92_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC468
; points at: wScriptStep
ScriptCommand92_Run_Case03::
Jump_012_4F77:: ; address name
    farcall UpdatePlayerMovement
    farcall RunWC468ActionIfBit7
    ld a, [wC468]
    bit 7, a
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand92_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hFF8C
; writes: wC468, wC46A, hFF8C, hFF9D, hFF9E
; points at: hMapScreenY, hFF80, wScriptStep
ScriptCommand92_Run_Case02::
Jump_012_4F8E:: ; address name
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
    farcall RunWC468ActionIfBit7
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand94_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: hPlayerY
; points at: hPlayerY, wScriptStep
ScriptCommand94_Run_Case01::
Jump_012_4FBC:: ; address name
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ld hl, hPlayerY
    inc [hl]
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank12
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp a, $80
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand94_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hPlayerFacing
; points at: hFF8C, wScriptStep
ScriptCommand94_Run_Case00::
Jump_012_4FD7:: ; address name
    xor a, a
    ldh [hPlayerFacing], a
    ld hl, hFF8C
    call SetBit1AtHL_Bank12
    ld a, $65
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type A0; reached through ScriptCommandA0 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandA0)
; reads: wScriptStep
ScriptCommandA0_Run::
Func_012_4FEA:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommandA0_Run_Case00
    dw ScriptCommandA0_Run_Case01
    dw ScriptCommandA0_Run_Case02
    dw ScriptCommandA0_Run_Case03
    dw ScriptCommandA0_Run_Case04
    dw ScriptCommandA0_Run_Case03
    dw ScriptCommandA0_Run_Case03
    dw ScriptCommandA0_Run_Case07

; entry 7 of the `rst $00` table in ScriptCommandA0_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFFB9, wScriptStartRequest
ScriptCommandA0_Run_Case07::
Jump_012_4FFE:: ; address name
    xor a, a
    ldh [hFFB9], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 4 of the `rst $00` table in ScriptCommandA0_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hFF93, hPlayerFacing
; writes: hFF93, wC527, wScriptParam0, hPlayerFacing
; points at: wScriptStep
ScriptCommandA0_Run_Case04::
Jump_012_5007:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, ScriptCommandA0_Run_Case03
    ldh a, [hFF93]
    or a, $80
    ldh [hFF93], a
    farcall LoadPlayerSpriteGraphics
    ld a, $7F
    ld [wC527], a

; entry 3 of the `rst $00` table in ScriptCommandA0_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerFacing
; writes: wScriptParam0, hPlayerFacing
; points at: wScriptStep
ScriptCommandA0_Run_Case03::
Jump_012_501E:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $03
    ret nz
    ldh a, [hPlayerFacing]
    inc a
    and a, $03
    ldh [hPlayerFacing], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommandA0_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlotCount, wCD04, hFF93, hFF94, hFF95
; writes: hPlayerFacing, hFF93, hFF94, hFF95, hFF96, hFF97, wScriptParam0
; points at: wCB8A, wScriptStep
ScriptCommandA0_Run_Case02::
Jump_012_5038:: ; address name
    xor a, a
    ldh [hPlayerFacing], a
    ld a, [wSpriteSlotCount]
    ld c, a

Jump_012_503F::
    call NextRandomSeed
    ld a, [wCD04]
    and a, $07
    cp a, c
    jr nc, Jump_012_503F
    swap a
    ld hl, wCB8A
    add_a_to_hl
    ld a, [hl+]
    cp a, $A0
    jr nc, Jump_012_503F
    ld a, [hl]
    cp a, $90
    jr nc, Jump_012_503F
    ld a, l
    sub a, $0B
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, [hl+]
    ldh [hFF93], a
    ld a, [hl+]
    ldh [hFF94], a
    ld a, [hl]
    ldh [hFF95], a
    ldh a, [hFF93]
    cp a, $01
    jr nz, Jump_012_5080
    ldh a, [hFF94]
    cp a, $5E
    jr nz, Jump_012_5080
    ldh a, [hFF95]
    or a, a
    jr z, Jump_012_503F

Jump_012_5080::
    ld a, $64
    ldh [hFF96], a
    xor a, a
    ldh [hFF97], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommandA0_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommandA0_Run_Case01::
Jump_012_5090:: ; address name
    farcall ScriptStepFlashScreenNegative
    ret

; entry 0 of the `rst $00` table in ScriptCommandA0_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; points at: wBGPaletteBuffer, wC0F0, wScriptStep
ScriptCommandA0_Run_Case00::
Jump_012_5097:: ; address name
    ld a, $7A
    call QueueSoundEffect
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_012_50AE
    ld hl, wBGPaletteBuffer
    ld de, wC0F0
    ld bc, $0040
    call CopyBytes

Jump_012_50AE::
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type A1; reached through ScriptCommandA1 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommandA1)
; reads: wScriptStep
ScriptCommandA1_Run::
Func_012_50B3:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommandA1_Run_Case00
    dw ScriptCommandA1_Run_Case01
    dw ScriptCommandA1_Run_Case02

; entry 2 of the `rst $00` table in ScriptCommandA1_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFF93, wC527, wScriptStartRequest
ScriptCommandA1_Run_Case02::
Jump_012_50BD:: ; address name
    xor a, a
    ldh [hFF93], a
    farcall LoadPlayerSpriteGraphics
    ld a, $7F
    ld [wC527], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in ScriptCommandA1_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommandA1_Run_Case01::
Jump_012_50D1:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommandA1_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommandA1_Run_Case00::
Jump_012_50DB:: ; address name
    ld a, $12
    call StartMessageA
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 8E; reached through ScriptCommand8E in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand8E)
; reads: wScriptStep
ScriptCommand8E_Run::
Func_012_50E5:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand8E_Run_Case00
    dw ScriptCommand8E_Run_Case01

; entry 1 of the `rst $00` table in ScriptCommand8E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCC44, hMapId, wC88E, wC891, wCC42, wCD09, wCD0A
; writes: wScriptStartRequest, hMapId, wC8C8, wC8C9
; points at: wC88F, wCD08
ScriptCommand8E_Run_Case01::
Jump_012_50ED:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, [wCC44]
    bit 7, a
    jp nz, Jump_012_5181
    ldh a, [hMapId]
    ld c, a
    ld hl, Data_012_5130

Jump_012_5100::
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_012_5108
    ld c, $00
    ret

Jump_012_5108::
    cp a, c
    jr z, Jump_012_5112
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr Jump_012_5100

Jump_012_5112::
    ld e, l
    ld d, h
    inc de
    ld a, [de]
    inc de
    ldh [hMapId], a
    ld a, [de]
    inc de
    ld b, a
    ld a, [wC88E]
    or a, a
    jr z, Jump_012_512C
    ld a, [wC891]
    dec a
    cp a, b
    jr nz, Jump_012_512C
    ld de, wC88F

Jump_012_512C::
    call ScriptCommand8E_Run_Case01_Sub01
    ret

Data_012_5130:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $049130, $51

Jump_012_5181::
    ld a, [wC88E]
    or a, a
    jr z, Jump_012_519E
    ld a, [wC891]
    bit 7, a
    jr z, Jump_012_519E
    and a, $7F
    ld c, a
    ld a, [wCC42]
    cp a, c
    jr nz, Jump_012_519E
    ld de, wC88F
    call ScriptCommand8E_Run_Case01_Sub01
    ret

Jump_012_519E::
    ld a, [wCD09]
    ld [wC8C8], a
    ld a, [wCD0A]
    ld [wC8C9], a
    ld de, wCD08
    call ScriptCommand8E_Run_Case01_Sub02
    ret

; only called from ScriptCommand8E_Run_Case01 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommand8E_Run_Case01)
; reads: hFF8C
; writes: wC8C8, wC8C9, hMapScreenX, hMapScreenY, wC8C5, wC8C6, wModeState, hFF8C
; points at: wC5E0
ScriptCommand8E_Run_Case01_Sub01::
Func_012_51B1:: ; address name
    ld a, [de]
    and a, $F0
    ld [wC8C8], a
    ld a, [de]
    swap a
    and a, $F0
    ld [wC8C9], a
    inc de

; only called from ScriptCommand8E_Run_Case01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommand8E_Run_Case01)
; reads: hFF8C
; writes: hMapScreenX, hMapScreenY, wC8C5, wC8C6, wModeState, hFF8C
; points at: wC5E0
ScriptCommand8E_Run_Case01_Sub02::
Func_012_51C0:: ; address name
    ld a, [de]
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [de]
    and a, $0F
    inc de
    ldh [hMapScreenY], a
    ld a, $80
    ld [wC8C5], a
    ld a, $01
    ld [wC8C6], a
    ld a, $04
    call StartPaletteFade
    ld hl, wC5E0
    inc [hl]
    ld a, $04
    ld [wModeState], a
    ldh a, [hFF8C]
    and a, $F7
    ldh [hFF8C], a
    ldh a, [hFF8C]
    or a, $20
    and a, $7F
    ldh [hFF8C], a
    ret

; implements script command type 8A; reached through ScriptCommand8A in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand8A)
; reads: wScriptStep
ScriptCommand8A_Run::
Func_012_51F4:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand8E_Run_Case00
    dw ScriptCommand8A_Run_Case01

; entry 1 of the `rst $00` table in ScriptCommand8A_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hFF8C, wCC44, wCC45, wCD0D, wCD0E, hMapId, wC88B
; writes: wScriptStartRequest, hFF8C, wC8C6, wC8C5, hMapScreenX, hMapScreenY, wC8C8, wC8C9, ...
; points at: wCD88
ScriptCommand8A_Run_Case01::
Jump_012_51FC:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ldh a, [hFF8C]
    or a, $80
    and a, $DF
    ldh [hFF8C], a
    ld a, $01
    ld [wC8C6], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $80
    ld [wC8C5], a
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_012_5258
    ld a, [wCC45]
    add a, a
    add a, a
    ld hl, wCD88
    add_a_to_hl
    ld a, [hl]
    push af
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    pop af
    and a, $0F
    ldh [hMapScreenY], a
    ld a, $40
    ld [wC8C8], a
    ld [wC8C9], a
    xor a, a
    ld [wC8CA], a
    ld a, [wCD0D]
    ld [wMapWidthScreens], a
    ld a, [wCD0E]
    ld [wMapHeightScreens], a
    ld a, $80
    ld [wCC44], a
    ret

Jump_012_5258::
    ldh a, [hMapId]
    ld c, a
    ld hl, Data_012_52AD

Jump_012_525E::
    ld a, [hl]
    cp a, c
    jr z, Jump_012_526B
    ld a, $07
    add_a_to_hl
    jr Jump_012_525E

Jump_012_526B::
    ld a, [wC88B]
    dec a
    dec a
    jr nz, Jump_012_5275
    inc hl
    inc hl
    inc hl

Jump_012_5275::
    inc hl
    ld a, [hl+]
    ldh [hMapId], a
    ld a, [hl]
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [hl+]
    and a, $0F
    ldh [hMapScreenY], a
    ld a, [hl]
    and a, $F0
    ld [wC8C8], a
    ld a, [hl]
    and a, $0F
    swap a
    ld [wC8C9], a
    xor a, a
    ld [wC8CA], a
    ldh a, [hMapId]
    cp a, $52
    jr z, Jump_012_52A6
    cp a, $89
    jr z, Jump_012_52A6
    cp a, $BB
    jr z, Jump_012_52A6
    ret

Jump_012_52A6::
    ldh a, [hFF8C]
    and a, $7F
    ldh [hFF8C], a
    ret

Data_012_52AD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0492AD, $261

; implements script command type 9B; reached through ScriptCommand9B in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand9B)
; reads: wScriptStep
ScriptCommand9B_Run::
Func_012_550E:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand9B_Run_Case00
    dw ScriptCommand9B_Run_Case01
    dw ScriptCommand9B_Run_Case02
    dw ScriptStepFlashScreenNegative
    dw ScriptCommand9B_Run_Case04
    dw ScriptCommand9B_Run_Case05
    dw ScriptCommand9B_Run_Case06

; entry 0 of the `rst $00` table in ScriptCommand9B_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hPlayerFacing
; points at: wScriptStep
ScriptCommand9B_Run_Case00::
Jump_012_5520:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, $03
    ldh [hPlayerFacing], a
    ld de, $0025
    call TestFlagBit
    ret nc
    ld a, $02
    ldh [hPlayerFacing], a
    ret

; implements script command type 89; reached through ScriptCommand89 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand89)
; reads: wScriptStep
ScriptCommand89_Run::
Func_012_5534:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand8E_Run_Case00
    dw ScriptCommand89_Run_Case01
    dw ScriptCommand9B_Run_Case01
    dw ScriptCommand9B_Run_Case02
    dw ScriptStepFlashScreenNegative
    dw ScriptCommand9B_Run_Case04
    dw ScriptCommand9B_Run_Case05
    dw ScriptCommand9B_Run_Case06

; entry 1 of the `rst $00` table in ScriptCommand9B_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCB86, wCB96
; points at: wScriptStep
ScriptCommand9B_Run_Case01::
Jump_012_5548:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld de, $002B
    call TestFlagBit
    jr c, Jump_012_555B
    ld a, $0D
    call StartMessageA
    jr Jump_012_5560

Jump_012_555B::
    ld a, $15
    call StartMessageA

Jump_012_5560::
    ld de, $0025
    call TestFlagBit
    jr c, Jump_012_556E
    ld a, $01
    ld [wCB86], a
    ret

Jump_012_556E::
    xor a, a
    ld [wCB96], a
    ret

; entry 1 of the `rst $00` table in ScriptCommand89_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC8C5
ScriptCommand89_Run_Case01::
Jump_012_5573:: ; address name
    call StartReturnWarpByFlag25
    ld a, $80
    ld [wC8C5], a
    ret

; entry 0 of the `rst $00` table in ScriptCommand8E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, wScriptParam0, wC8F1, hPlayerFacing, wC8F6, wC8FB, hFF8C
; writes: hPlayerY, hPlayerFacing, wC8F1, wFollowerRecords, wC8F6, wC8F4, wC8FB, wC8F9, ...
; points at: wScriptStep
ScriptCommand8E_Run_Case00::
Jump_012_557C:: ; address name
    ldh a, [hPlayerY]
    cp a, $E0
    jr z, Jump_012_558F
    sub a, $04
    ldh [hPlayerY], a
    ld a, [wScriptParam0]
    srl a
    and a, $03
    ldh [hPlayerFacing], a

Jump_012_558F::
    ld a, [wScriptParam0]
    cp a, $08
    jr c, Jump_012_55A7
    ld a, [wC8F1]
    cp a, $E0
    jr z, Jump_012_55A7
    sub a, $04
    ld [wC8F1], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a

Jump_012_55A7::
    ld a, [wScriptParam0]
    cp a, $10
    jr c, Jump_012_55BF
    ld a, [wC8F6]
    cp a, $E0
    jr z, Jump_012_55BF
    sub a, $04
    ld [wC8F6], a
    ldh a, [hPlayerFacing]
    ld [wC8F4], a

Jump_012_55BF::
    ld a, [wScriptParam0]
    cp a, $18
    jr c, Jump_012_55D7
    ld a, [wC8FB]
    cp a, $E0
    jr z, Jump_012_55D7
    sub a, $04
    ld [wC8FB], a
    ldh a, [hPlayerFacing]
    ld [wC8F9], a

Jump_012_55D7::
    ld b, $5A
    call StepWC921Counter_Bank12
    ret nc
    ldh a, [hFF8C]
    and a, $B7
    ldh [hFF8C], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 88; reached through ScriptCommand88 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand88)
; reads: wScriptStep
ScriptCommand88_Run::
Func_012_55E8:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand88_Run_Case00
    dw ScriptCommand9B_Run_Case02
    dw ScriptStepFlashScreenNegative
    dw ScriptCommand9B_Run_Case04
    dw ScriptCommand9B_Run_Case05
    dw ScriptCommand9B_Run_Case06

; with bit 7 of wCC44 saves the wCD07 record; sets the position ($50, $30), wC8C6 = 3 (story flag $25) or 4, wC957 = 1 and starts the fade (E-0126)
; 2 call sites from 2 routines (e.g. ScriptCommand89_Run_Case01, ScriptCommand87_Run_Case07)
; reads: wCC44
; writes: wC8C8, wC8C9, wC8CA, wC8C6, wC957
StartReturnWarpByFlag25::
Func_012_55F8:: ; address name
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_012_5605
    farcall SaveWCD07RecordToSRAMSlotWCC42

Jump_012_5605::
    ld a, $50
    ld [wC8C8], a
    ld a, $30
    ld [wC8C9], a
    xor a, a
    ld [wC8CA], a
    ld de, $0025
    call TestFlagBit
    jr c, Jump_012_5622
    ld a, $04
    ld [wC8C6], a
    jr Jump_012_5627

Jump_012_5622::
    ld a, $03
    ld [wC8C6], a

Jump_012_5627::
    ld a, $01
    ld [wC957], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; entry 0 of the `rst $00` table in ScriptCommand88_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wCB86, wCB96
; points at: wScriptStep
ScriptCommand88_Run_Case00::
Jump_012_5633:: ; address name
    ld hl, wScriptStep
    inc [hl]
    farcall ScriptCommand88_Run_Case00_Sub01
    ld de, $0025
    call TestFlagBit
    jr c, Jump_012_5650
    ld a, $0C
    call StartMessageA
    ld a, $01
    ld [wCB86], a
    ret

Jump_012_5650::
    xor a, a
    ld [wCB96], a
    ld de, $002B
    call TestFlagBit
    jr c, Jump_012_5662
    ld a, $13
    call StartMessageA
    ret

Jump_012_5662::
    ld a, $14
    call StartMessageA
    ret

; entry 2 of the `rst $00` table in ScriptCommand9B_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; points at: wBGPaletteBuffer, wC0F0, wScriptStep
ScriptCommand9B_Run_Case02::
Jump_012_5668:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_012_567F
    ld hl, wBGPaletteBuffer
    ld de, wC0F0
    ld bc, $0040
    call CopyBytes

Jump_012_567F::
    ld hl, wScriptStep
    inc [hl]
    ld a, $7A
    call QueueSoundEffect
    ret

; entry 4 of the `rst $00` table in ScriptCommand9B_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC6FD, wScriptParam0, wScriptStep
; writes: rRAMG, wScriptParam0, wScriptStep, hFF8D
; points at: wC6FE, wScriptStep
ScriptCommand9B_Run_Case04::
Jump_012_5689:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE

Jump_012_5695::
    ld a, [hl+]
    ld c, $55
    call LoadSRAMRecordByte
    bit 7, a
    jr nz, Jump_012_56A8
    dec b
    jr nz, Jump_012_5695
    xor a, a
    ld [wScriptParam0], a
    jr Jump_012_56AD

Jump_012_56A8::
    ld a, $01
    ld [wScriptParam0], a

Jump_012_56AD::
    xor a, a
    ld [rRAMG], a
    call FullyHealParty
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_012_56DB
    ld de, $002B
    call TestFlagBit
    jr c, Jump_012_56C9
    ld a, $11
    call StartMessageA
    jr Jump_012_56CE

Jump_012_56C9::
    ld a, $16
    call StartMessageA

Jump_012_56CE::
    xor a, a
    ld [wScriptParam0], a
    ld a, [wScriptStep]
    inc a
    inc a
    ld [wScriptStep], a
    ret

Jump_012_56DB::
    ld a, $0E
    ldh [hFF8D], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in ScriptCommand9B_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC527, hFF8D
; points at: wScriptStep
ScriptCommand9B_Run_Case05::
Jump_012_56E8:: ; address name
    farcall MoveIncapacitatedPartyMembersBack
    farcall MoveIncapacitatedPartyMembersBack
    call LoadRecordListNameTiles
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    xor a, a
    ldh [hFF8D], a
    ld hl, wScriptStep
    inc [hl]
    ld de, $002B
    call TestFlagBit
    jr c, Jump_012_5717
    ld a, $11
    call StartMessageA
    ret

Jump_012_5717::
    ld a, $16
    call StartMessageA
    ret

; entry 6 of the `rst $00` table in ScriptCommand9B_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
ScriptCommand9B_Run_Case06::
Jump_012_571D:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 87; reached through ScriptCommand87 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand87)
; reads: wScriptStep
ScriptCommand87_Run::
Func_012_5728:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand87_Run_Case00
    dw ScriptCommand87_Run_Case01
    dw ScriptCommand87_Run_Case02
    dw ScriptCommand87_Run_Case03
    dw ScriptCommand87_Run_Case04
    dw ScriptCommand87_Run_Case05
    dw ScriptCommand87_Run_Case06
    dw ScriptCommand87_Run_Case07
    dw ScriptCommand87_Run_Case08

; entry 8 of the `rst $00` table in ScriptCommand87_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC916, wC917
ScriptCommand87_Run_Case08::
Jump_012_573E:: ; address name
    ld a, $05
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall DispatchTalkEvent
    ret

; entry 7 of the `rst $00` table in ScriptCommand87_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC8C7, wC8C5
ScriptCommand87_Run_Case07::
Jump_012_574E:: ; address name
    call StartReturnWarpByFlag25
    xor a, a
    ld [wC8C7], a
    ld a, $80
    ld [wC8C5], a
    ret

; entry 6 of the `rst $00` table in ScriptCommand87_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand87_Run_Case06::
Jump_012_575B:: ; address name
    ld b, $B4
    call StepWC921Counter_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in ScriptCommand87_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC6FD
; writes: rRAMG, wScriptStartRequest
; points at: wC6FE, wScriptStep
ScriptCommand87_Run_Case05::
Jump_012_5766:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE

Jump_012_5772::
    ld a, [hl+]
    ld c, $55
    call LoadSRAMRecordByte
    bit 7, a
    jr z, Jump_012_578D
    dec b
    jr nz, Jump_012_5772
    xor a, a
    ld [rRAMG], a
    ld a, $42
    call QueueMusic
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_012_578D::
    xor a, a
    ld [rRAMG], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 3 of the `rst $00` table in ScriptCommand87_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wScriptParam1, wC6FE, wC6FF, wC700
; writes: wScriptParam0, wMessageIndex, wMessageGroup, wMessageState, wScriptParam1, rRAMG
; points at: wScriptStep, wC00B, wC8CF, wC147
ScriptCommand87_Run_Case03::
Jump_012_5797:: ; address name
    ld hl, wScriptStep
    dec [hl]
    ld de, wC00B
    ld a, [wScriptParam0]
    dec a
    ld [wScriptParam0], a
    or a, a
    jr nz, Jump_012_57DB
    ld de, vTiles0 + $B
    jr Jump_012_57DB

; entry 2 of the `rst $00` table in ScriptCommand87_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0, wScriptStep
; points at: wScriptStep
ScriptCommand87_Run_Case02::
Jump_012_57AD:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_012_57C2
    xor a, a
    ld [wScriptParam0], a
    ld a, $04
    ld [wScriptStep], a
    ret

Jump_012_57C2::
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand87_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wScriptParam1, wC6FE, wC6FF, wC700
; writes: wScriptParam0, wMessageIndex, wMessageGroup, wMessageState, wScriptParam1, rRAMG
; points at: wScriptStep, wC8CF, wC147
ScriptCommand87_Run_Case01::
Jump_012_57C7:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld de, $400A
    ld a, [wScriptParam0]
    dec a
    ld [wScriptParam0], a
    or a, a
    jr nz, Jump_012_57DB
    ld de, $000A

Jump_012_57DB::
    ld a, e
    ld [wMessageIndex], a
    ld a, d
    ld [wMessageGroup], a
    xor a, a
    ld [wMessageState], a
    ld a, [wScriptParam1]
    sra a
    jr nc, Jump_012_57FB
    ld a, [wScriptParam1]
    and a, $FE
    ld [wScriptParam1], a
    ld a, [wC6FE]
    jr Jump_012_5817

Jump_012_57FB::
    sra a
    jr nc, Jump_012_580C
    ld a, [wScriptParam1]
    and a, $FC
    ld [wScriptParam1], a
    ld a, [wC6FF]
    jr Jump_012_5817

Jump_012_580C::
    ld a, [wScriptParam1]
    and a, $F7
    ld [wScriptParam1], a
    ld a, [wC700]

Jump_012_5817::
    ld c, $01
    push af
    ld a, $0A
    ld [rRAMG], a
    pop af
    call CopyRecordNameToWC8CF
    xor a, a
    ld [rRAMG], a
    ld hl, wC8CF
    ld de, wC147
    ld bc, $000B
    call CopyBytes
    ret

; entry 0 of the `rst $00` table in ScriptCommand87_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC6FD, wC915
; writes: wScriptParam0, wScriptParam1
; points at: wScriptStep
ScriptCommand87_Run_Case00::
Jump_012_5834:: ; address name
    ld a, [wC6FD]
    ld b, a
    ld c, $00
    ld a, [wC915]

Jump_012_583D::
    sra a
    jr nc, Jump_012_5842
    inc c

Jump_012_5842::
    dec b
    jr nz, Jump_012_583D
    ld a, c
    ld [wScriptParam0], a
    ld a, [wC915]
    ld [wScriptParam1], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 85; reached through ScriptCommand85 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand85)
; reads: wScriptStep
ScriptCommand85_Run::
Func_012_5854:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand85_Run_Case00
    dw ScriptCommand85_Run_Case01
    dw ScriptCommand85_Run_Case02
    dw ScriptCommand85_Run_Case03
    dw ScriptCommand85_Run_Case04
    dw ScriptCommand85_Run_Case05
    dw ScriptCommand85_Run_Case06
    dw ScriptCommand85_Run_Case07

; entry 7 of the `rst $00` table in ScriptCommand85_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCD07, wC833
; writes: wCD07, wScriptStartRequest
; points at: wCE7E
ScriptCommand85_Run_Case07::
Jump_012_5868:: ; address name
    ld a, [wCD07]
    or a, $80
    ld [wCD07], a
    ld hl, wCE7E
    ld b, $04

Jump_012_5875::
    ld [hl], $01
    ld a, $04
    add_a_to_hl
    dec b
    jr nz, Jump_012_5875
    ld a, [wC833]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    set 6, a
    ld [hl], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 6 of the `rst $00` table in ScriptCommand85_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wSpriteSlotCount, wScriptParam0
; points at: wScriptStep
ScriptCommand85_Run_Case06::
Jump_012_589B:: ; address name
    ld a, [wScriptParam0]
    cp a, $1E
    jr nc, Jump_012_58A8
    bit 3, a
    jr z, Jump_012_58B8
    jr Jump_012_58BF

Jump_012_58A8::
    cp a, $3C
    jr nc, Jump_012_58B2
    bit 2, a
    jr z, Jump_012_58B8
    jr Jump_012_58BF

Jump_012_58B2::
    bit 1, a
    jr z, Jump_012_58B8
    jr Jump_012_58BF

Jump_012_58B8::
    ld a, $01
    ld [wSpriteSlotCount], a
    jr Jump_012_58C3

Jump_012_58BF::
    xor a, a
    ld [wSpriteSlotCount], a

Jump_012_58C3::
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

; entry 5 of the `rst $00` table in ScriptCommand85_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0
; points at: wScriptStep
ScriptCommand85_Run_Case05::
Jump_012_58D6:: ; address name
    xor a, a
    call ScriptCommand85_Run_Case05_Sub01
    ret nc
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand85_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand85_Run_Case04::
Jump_012_58E4:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, $0129
    call StartMessageHL_B0F_Bank12
    ret

; entry 3 of the `rst $00` table in ScriptCommand85_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand85_Run_Case03::
Jump_012_58EF:: ; address name
    farcall ScriptStepFlashScreenNegative
    ret

; entry 2 of the `rst $00` table in ScriptCommand85_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; points at: wBGPaletteBuffer, wC0F0, wScriptStep
ScriptCommand85_Run_Case02::
Jump_012_58F6:: ; address name
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_012_5908
    ld hl, wBGPaletteBuffer
    ld de, wC0F0
    ld bc, $0040
    call CopyBytes

Jump_012_5908::
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand85_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCE75, wCE76, wCE72, wCE73, wCE74, wCE77, wCE78, wCE79, ...
; writes: wC903, wCFDD, wCFDE, wCFE3, wCFDC, wC905, wCFDF, wCFE0, ...
; points at: wScriptStep
ScriptCommand85_Run_Case01::
Jump_012_590D:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ld a, $03
    ld [wC903], a
    ld a, [wCE75]
    ld c, a
    ld a, [wCE76]
    or a, c
    jr nz, Jump_012_5941
    ld a, [wCE72]
    ld l, a
    ld a, [wCE73]
    ld h, a
    ld a, l
    ld [wCFDD], a
    ld a, h
    ld [wCFDE], a
    ld a, [wCE74]
    ld [wCFE3], a
    xor a, a
    ld [wCFDC], a
    jr Jump_012_5988

Jump_012_5941::
    ld a, [wCE75]
    ld l, a
    ld a, [wCE76]
    ld h, a
    ld a, l
    ld [wCFDD], a
    ld a, h
    ld [wCFDE], a
    ld a, [wCE77]
    ld [wCFE3], a
    ld a, [wCE72]
    ld l, a
    ld a, [wCE73]
    ld h, a
    ld a, l
    ld [wCFDF], a
    ld a, h
    ld [wCFE0], a
    ld a, [wCE74]
    ld [wCFE4], a
    ld a, [wCE78]
    ld l, a
    ld a, [wCE79]
    ld h, a
    ld a, l
    ld [wCFE1], a
    ld a, h
    ld [wCFE2], a
    ld a, [wCE7A]
    ld [wCFE5], a
    ld a, $02
    ld [wCFDC], a

Jump_012_5988::
    ld a, $01
    ld [wC905], a
    farcall SetModeState3AndSaveScreen
    ret

; entry 0 of the `rst $00` table in ScriptCommand85_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCD04
; points at: wScriptStep
ScriptCommand85_Run_Case00::
Jump_012_5994:: ; address name
    call NextRandomSeed
    ld a, [wCD04]
    and a, $0F
    ld hl, $00D0
    add_a_to_hl
    call StartMessageHL_B0F_Bank12
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 9E; reached through ScriptCommand9E in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand9E)
; reads: wScriptStep
ScriptCommand9E_Run::
Func_012_59AC:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand9E_Run_Case00
    dw ScriptCommand9E_Run_Case01
    dw ScriptCommand9E_Run_Case02
    dw ScriptCommand85_Run_Case05
    dw ScriptCommand85_Run_Case06
    dw ScriptCommand9E_Run_Case05

; entry 5 of the `rst $00` table in ScriptCommand9E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCC45
; writes: wScriptStartRequest
; points at: wCE7E
ScriptCommand9E_Run_Case05::
Jump_012_59BC:: ; address name
    ld a, [wCC45]
    and a, $7F
    add a, a
    add a, a
    ld hl, wCE7E
    add_a_to_hl
    ld [hl], $01
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommand9E_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand9E_Run_Case02::
Jump_012_59D3:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, $012A
    call StartMessageHL_B0F_Bank12
    ret

; entry 1 of the `rst $00` table in ScriptCommand9E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCC45
; writes: wC903, wCFDD, wCFDE, wCFE3, wCFDC, wC905
; points at: wScriptStep, wCE7B
ScriptCommand9E_Run_Case01::
Jump_012_59DE:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ld a, $03
    ld [wC903], a
    ld a, [wCC45]
    and a, $7F
    add a, a
    add a, a
    ld hl, wCE7B
    add_a_to_hl
    ld a, [hl+]
    ld [wCFDD], a
    ld a, [hl+]
    ld [wCFDE], a
    ld a, [hl]
    ld [wCFE3], a
    xor a, a
    ld [wCFDC], a
    ld a, $01
    ld [wC905], a
    farcall SetModeState3AndSaveScreen
    ret

; entry 0 of the `rst $00` table in ScriptCommand9E_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCD04
; points at: wScriptStep
ScriptCommand9E_Run_Case00::
Jump_012_5A17:: ; address name
    call NextRandomSeed
    ld a, [wCD04]
    and a, $0F
    ld hl, $00E0
    add_a_to_hl
    call StartMessageHL_B0F_Bank12
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 84; reached through ScriptCommand84 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand84)
; reads: wScriptStep
; writes: wJoypadHeld, wJoypadPressed
ScriptCommand84_Run::
Func_012_5A2F:: ; address name
    ld a, [wScriptStep]
    cp a, $07
    jr z, Jump_012_5A3D
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a

Jump_012_5A3D::
    ld a, [wScriptStep]
    rst $00
    dw SetupScriptSpriteFromWC195
    dw PlaySound83AndAdvanceScriptStep
    dw ScriptStepAnimateSpriteBySteps
    dw ScriptCommand84_Run_Case03
    dw ScriptCommand84_Run_Case04
    dw ScriptCommand84_Run_Case05
    dw ScriptCommand84_Run_Case06
    dw ScriptCommand84_Run_Case07
    dw ScriptCommand84_Run_Case08

; entry 8 of the `rst $00` table in ScriptCommand84_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC956, wScriptParam1
; writes: hFFC6, hFFC7, wC956, wScriptStartRequest, wC928
ScriptCommand84_Run_Case08::
Jump_012_5A53:: ; address name
    ld a, [wC956]
    and a, $7F
    jr z, Jump_012_5A64
    ldh [hFFC6], a
    xor a, a
    ldh [hFFC7], a
    call AddGoldCapped
    jr Jump_012_5A70

Jump_012_5A64::
    ld a, [wScriptParam1]
    ld [wC928], a
    farcall AppendItemWC928ToInventory

Jump_012_5A70::
    xor a, a
    ld [wC956], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 7 of the `rst $00` table in ScriptCommand84_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC8FE
; points at: wScriptStep
ScriptCommand84_Run_Case07::
Jump_012_5A7A:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld a, $FF
    ld [wC8FE], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommand84_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC956, wScriptParam1
; writes: wC8C0, wC8C1, wC8C2, wMessageGroup
; points at: wScriptStep, wC17E, wC152
ScriptCommand84_Run_Case06::
Jump_012_5A89:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wC956]
    and a, $7F
    jr z, Jump_012_5AB1
    ld [wC8C0], a
    xor a, a
    ld [wC8C1], a
    ld [wC8C2], a
    call Number24ToPackedBCD
    ld de, wC17E
    call WritePackedBCDNoLeadingZeros
    ld a, $05
    call StartMessageA
    xor a, a
    ld [wMessageGroup], a
    ret

Jump_012_5AB1::
    ld a, [wScriptParam1]
    ld de, wC152
    call CopyItemNameToDE
    ld a, $06
    call StartMessageA
    xor a, a
    ld [wMessageGroup], a
    ret

; entry 5 of the `rst $00` table in ScriptCommand84_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wC928, wC929, wScriptParam0
; points at: wC900, wScriptStep
ScriptCommand84_Run_Case05::
Jump_012_5AC4:: ; address name
    ld de, wC900
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
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in ScriptCommand84_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand84_Run_Case04::
Jump_012_5AE9:: ; address name
    farcall ScriptCommand84_Run_Case04_Sub01
    ret

; entry 3 of the `rst $00` table in ScriptCommand84_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageGroup, wMessageIndex, wIsCGB, wCC44, hMapId
; writes: rSVBK, hFF8D
; points at: wScriptStep
ScriptCommand84_Run_Case03::
Jump_012_5AF0:: ; address name
    ld a, [wMessageGroup]
    swap a
    and a, $0F
    add a, a
    ld l, a
    ld e, a
    ld h, $00
    ld d, $00
    add hl, hl
    add hl, hl
    add hl, de
    add hl, hl
    add hl, hl
    ld a, [wMessageIndex]
    swap a
    and a, $0F
    sla a
    add_a_to_hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    push hl
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
    jr z, Jump_012_5B8C
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
    ld c, $01
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_012_5B77
    ldh a, [hMapId]
    cp a, $63
    jr z, Jump_012_5B6D
    cp a, $64
    jr z, Jump_012_5B6D
    cp a, $65
    jr z, Jump_012_5B6D
    cp a, $66
    jr z, Jump_012_5B6D
    cp a, $53
    jr z, Jump_012_5B6D
    cp a, $54
    jr z, Jump_012_5B6D
    cp a, $55
    jr z, Jump_012_5B6D
    cp a, $56
    jr nz, Jump_012_5B71

Jump_012_5B6D::
    ld c, $03
    jr Jump_012_5B77

Jump_012_5B71::
    cp a, $57
    jr nz, Jump_012_5B77
    ld c, $03

Jump_012_5B77::
    ld a, $02
    ldh [rSVBK], a
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

Jump_012_5B8C::
    farcall DrawFullScreenBufferAtScroll
    xor a, a
    ldh [hFF8D], a
    ld hl, wScriptStep
    inc [hl]
    ret

; wScriptParam1 = wScriptParam0 / 6 (capped at 4), draws the script sprite, and advances wScriptStep after $1E frames (E-0125)
; 1 call site from 1 routine (e.g. ScriptCommand3E_Run_Case02)
; reads: wScriptParam0
; writes: wScriptParam1
; points at: wScriptStep
ScriptStepAnimateSpriteBySteps::
Func_012_5B9A:: ; address name
    ld a, [wScriptParam0]
    cp a, $06
    jr nc, Jump_012_5BA7
    xor a, a
    ld [wScriptParam1], a
    jr Jump_012_5BCB

Jump_012_5BA7::
    cp a, $0C
    jr nc, Jump_012_5BB2
    ld a, $01
    ld [wScriptParam1], a
    jr Jump_012_5BCB

Jump_012_5BB2::
    cp a, $12
    jr nc, Jump_012_5BBB
    ld a, $02
    ld [wScriptParam1], a

Jump_012_5BBB::
    cp a, $18
    jr nc, Jump_012_5BC6
    ld a, $03
    ld [wScriptParam1], a
    jr Jump_012_5BCB

Jump_012_5BC6::
    ld a, $04
    ld [wScriptParam1], a

Jump_012_5BCB::
    call DrawScriptMetaSpriteAtScrollOffset
    ld b, $1E
    call StepWC921Counter_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; draws metasprite set $23 + ($10 >> 4) - 1, sub-index wScriptParam1, at the scroll position plus (wMessageIndex + 8, wMessageGroup + $10), used here as coordinates (E-0121)
; 1 call site from 1 routine (e.g. ScriptStepAnimateSpriteBySteps)
; reads: wC195, wScriptParam1, hScrollX, hScrollXHi, wMessageIndex, hScrollY, hScrollYHi, wMessageGroup
; writes: hSpriteSetIndex, hSpriteSubIndex, hSpriteAttrXor, hSpriteTileOffset, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, hSpriteOriginYHi
DrawScriptMetaSpriteAtScrollOffset::
Func_012_5BD9:: ; address name
    ld a, [wC195]
    ld a, $10
    swap a
    and a, $0F
    dec a
    add a, $23
    ldh [hSpriteSetIndex], a
    ld a, [wScriptParam1]
    ldh [hSpriteSubIndex], a
    ld a, $07
    ldh [hSpriteAttrXor], a
    ld a, $70
    ldh [hSpriteTileOffset], a
    ldh a, [hScrollX]
    ld l, a
    ldh a, [hScrollXHi]
    ld h, a
    ld a, [wMessageIndex]
    add a, $08
    add_a_to_hl
    ld a, l
    ldh [hSpriteOriginX], a
    ld a, h
    ldh [hSpriteOriginXHi], a
    ldh a, [hScrollY]
    ld l, a
    ldh a, [hScrollYHi]
    ld h, a
    ld a, [wMessageGroup]
    add a, $10
    add_a_to_hl
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, h
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

; QueueSoundEffect $83, then wScriptStep += 1 (E-0114)
; 1 call site from 1 routine (e.g. ScriptCommand3E_Run_Case01)
; points at: wScriptStep
PlaySound83AndAdvanceScriptStep::
Func_012_5C27:: ; address name
    ld a, $83
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; A = wC195 >> 4, DE = ScriptCommand85_Run_Case00, B = $7E, then continues at Jump_012_5C4E (E-0126)
; 1 call site from 1 routine (e.g. ScriptCommand3E_Run_Case00)
; reads: wC195, wIsCGB, hPlayerX, hPlayerY, hPlayerFacing
; writes: wC527, wMessageIndex, wMessageGroup, wFollowerRecords, wC8F4, wC8F9, wScriptParam0
; points at: wOBJPaletteBuffer, wScriptStep
SetupScriptSpriteFromWC195::
Func_012_5C31:: ; address name
    ld a, [wC195]
    swap a
    and a, $0F
    ld de, ScriptCommand85_Run_Case00
    ld b, $7E
    jr Jump_012_5C4E

; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wC195, hPlayerX, hPlayerY, hPlayerFacing
; writes: wC527, wMessageIndex, wMessageGroup, wFollowerRecords, wC8F4, wC8F9, wScriptParam0
; points at: wOBJPaletteBuffer, wScriptStep
Func_012_5C3F:: ; heuristic: follows a terminator; C0
    dec a
    jr nz, Jump_012_5C49
    ld de, $5A15
    ld b, $7E
    jr Jump_012_5C4E

Jump_012_5C49::
    ld de, Data_07E_5A9A
    ld b, $7E

Jump_012_5C4E::
    ld hl, vTiles0 + $700
    call DecompressToVRAM
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_012_5C92
    ld a, [wC195]
    ld a, $10
    swap a
    and a, $0F
    add a, $22
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $BD
    ld e, a
    ld a, d
    adc a, $4B
    ld d, a
    ld b, $7E
    ld a, $38
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld c, $08
    call CopyFromBank
    ld a, $7F
    ld [wC527], a

Jump_012_5C92::
    ldh a, [hPlayerX]
    ld d, a
    ldh a, [hPlayerY]
    ld e, a
    ldh a, [hPlayerFacing]
    or a, a
    jr z, Jump_012_5CAF
    dec a
    jr z, Jump_012_5CBB
    dec a
    jr z, Jump_012_5CC7
    ld a, d
    sub a, $10
    ld [wMessageIndex], a
    ld a, e
    ld [wMessageGroup], a
    jr Jump_012_5CD1

Jump_012_5CAF::
    ld a, d
    ld [wMessageIndex], a
    ld a, e
    add a, $10
    ld [wMessageGroup], a
    jr Jump_012_5CD1

Jump_012_5CBB::
    ld a, d
    add a, $10
    ld [wMessageIndex], a
    ld a, e
    ld [wMessageGroup], a
    jr Jump_012_5CD1

Jump_012_5CC7::
    ld a, d
    ld [wMessageIndex], a
    ld a, e
    sub a, $10
    ld [wMessageGroup], a

Jump_012_5CD1::
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wC8F4], a
    ld [wC8F9], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 83; reached through ScriptCommand83 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand83)
; reads: wScriptParam1
ScriptCommand83_Run::
Func_012_5CE5:: ; address name
    ld a, [wScriptParam1]
    dec a
    jr nz, Jump_012_5CEF
    call ScriptCommand83_Run_Sub02
    ret

Jump_012_5CEF::
    dec a
    jr nz, Jump_012_5CF6
    call ScriptCommand83_Run_Sub03
    ret

Jump_012_5CF6::
    call ScriptCommand83_Run_Sub01
    ret

; only called from ScriptCommand83_Run (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommand83_Run)
; reads: wScriptStep
; writes: wJoypadHeld, wJoypadPressed
ScriptCommand83_Run_Sub01::
Func_012_5CFA:: ; address name
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wScriptStep]
    rst $00
    dw Func_012_5CFA_Case00
    dw Func_012_5CFA_Case01

; entry 0 of the `rst $00` table in Func_012_5CFA
; no direct call (reached through a table, a jump or a vector)
; reads: hFF8C, hPlayerY
; writes: hFF8C, hFF8D, hFF8B, hPlayerY, wScriptParam0
; points at: wScriptStep
Func_012_5CFA_Case00::
Jump_012_5D09:: ; address name
    ldh a, [hFF8C]
    and a, $F7
    ldh [hFF8C], a
    ld a, $0E
    ldh [hFF8D], a
    xor a, a
    ldh [hFF8B], a
    ldh a, [hPlayerY]
    sub a, $08
    ldh [hPlayerY], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_012_5CFA
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerX, hPlayerY, hPlayerFacing, hFF8C
; writes: wC928, wC929, wScriptParam0, wC8F0, wC8F5, wC8FA, wC8F1, wC8F6, ...
; points at: hPlayerY, hPlayerX
Func_012_5CFA_Case01::
Jump_012_5D25:: ; address name
    ld de, hPlayerY
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and a, $03
    jr nz, Jump_012_5D41
    ld hl, hPlayerY
    inc [hl]

Jump_012_5D41::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    jr nz, Jump_012_5D91
    ldh a, [hPlayerX]
    ld [wC8F0], a
    ld [wC8F5], a
    ld [wC8FA], a
    ldh a, [hPlayerY]
    ld [wC8F1], a
    ld [wC8F6], a
    ld [wC8FB], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wC8F4], a
    ld [wC8F9], a
    xor a, a
    ldh [hFF8D], a
    ld a, $80
    ld [wScriptStartRequest], a
    ldh a, [hFF8C]
    or a, $01
    ldh [hFF8C], a
    ld hl, $0000
    ld a, l
    ldh [hFF9B], a
    ld a, h
    ldh [hFF9C], a
    ld a, l
    ldh [hFF9D], a
    ld a, h
    ldh [hFF9E], a
    farcall PlayMapMusic
    ret

Jump_012_5D91::
    ld a, [wScriptParam0]
    and a, $01
    ret z
    ldh a, [hPlayerFacing]
    or a, a
    jr z, Jump_012_5DA7
    dec a
    jr z, Jump_012_5DAC
    dec a
    jr z, Jump_012_5DB1
    ld hl, hPlayerX
    dec [hl]
    ret

Jump_012_5DA7::
    ld hl, hPlayerY
    inc [hl]
    ret

Jump_012_5DAC::
    ld hl, hPlayerX
    inc [hl]
    ret

Jump_012_5DB1::
    ld hl, hPlayerY
    dec [hl]
    ret

; only called from ScriptCommand83_Run (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommand83_Run)
; reads: wScriptStep
; writes: wJoypadHeld, wJoypadPressed
ScriptCommand83_Run_Sub02::
Func_012_5DB6:: ; address name
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wScriptStep]
    rst $00
    dw ScriptStepMoveFollowersToLeader
    dw ScriptStepMoveFollowersToLeader
    dw ScriptStepMoveFollowersToLeader
    dw Func_012_5DB6_Case03
    dw Func_012_5DB6_Case04
    dw Func_012_5DB6_Case05
    dw Func_012_5DB6_Case06
    dw Func_012_5DB6_Case07
    dw Func_012_5DB6_Case08

; entry 8 of the `rst $00` table in Func_012_5DB6
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerY, hFF8C, hPlayerFacing
; writes: wC928, wC929, wScriptParam0, hPlayerY, hFF8C, hFF8B, wScriptStartRequest
; points at: hPlayerY, hPlayerX
Func_012_5DB6_Case08::
Jump_012_5DD3:: ; address name
    ld de, hPlayerY
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and a, $03
    jr nz, Jump_012_5DEF
    ld hl, hPlayerY
    dec [hl]

Jump_012_5DEF::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    jr nz, Jump_012_5E14
    ldh a, [hPlayerY]
    add a, $08
    and a, $F0
    ldh [hPlayerY], a
    ldh a, [hFF8C]
    or a, $08
    and a, $5F
    ldh [hFF8C], a
    ld a, $02
    ldh [hFF8B], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_012_5E14::
    call DrawScriptMetaSprite21AtScrollOffset
    ld a, [wScriptParam0]
    and a, $01
    ret z
    ldh a, [hPlayerFacing]
    or a, a
    jr z, Jump_012_5E2D
    dec a
    jr z, Jump_012_5E32
    dec a
    jr z, Jump_012_5E37
    ld hl, hPlayerX
    dec [hl]
    ret

Jump_012_5E2D::
    ld hl, hPlayerY
    inc [hl]
    ret

Jump_012_5E32::
    ld hl, hPlayerX
    inc [hl]
    ret

Jump_012_5E37::
    ld hl, hPlayerY
    dec [hl]
    ret

; entry 7 of the `rst $00` table in Func_012_5DB6
; no direct call (reached through a table, a jump or a vector)
; reads: wCC44, hMapId
; points at: wScriptStep
Func_012_5DB6_Case07::
Jump_012_5E3C:: ; address name
    call DrawScriptMetaSprite21AtScrollOffset
    ld hl, wScriptStep
    inc [hl]
    ld a, [wCC44]
    bit 7, a
    jr z, Jump_012_5E4F
    cp a, $80
    jr z, Jump_012_5E5C
    ret

Jump_012_5E4F::
    ldh a, [hMapId]
    ld c, a
    ld hl, Data_012_5E62

Jump_012_5E55::
    ld a, [hl+]
    cp a, $FF
    ret z
    cp a, c
    jr nz, Jump_012_5E55

Jump_012_5E5C::
    ld a, $2B
    call QueueMusic
    ret

Data_012_5E62:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $30, $FF

; entry 3 of the `rst $00` table in Func_012_5DB6
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, hPlayerY, hPlayerFacing
; writes: wC527, wMessageIndex, wMessageGroup, hFF8D, wFollowerRecords, wC8F4, wC8F9, wScriptParam0
; points at: wOBJPaletteBuffer, wScriptStep
Func_012_5DB6_Case03::
Jump_012_5E64:: ; address name
    ld de, Data_07E_58FF
    ld b, $7E
    ld hl, vTiles0 + $700
    call DecompressToVRAM
    ld de, $0108
    ld a, e
    add a, $BD
    ld e, a
    ld a, d
    adc a, $4B
    ld d, a
    ld b, $7E
    ld a, $38
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld c, $08
    call CopyFromBank
    ld a, $7F
    ld [wC527], a
    ldh a, [hPlayerX]
    ld d, a
    ldh a, [hPlayerY]
    ld e, a
    ldh a, [hPlayerFacing]
    or a, a
    jr z, Jump_012_5EAD
    dec a
    jr z, Jump_012_5EB9
    dec a
    jr z, Jump_012_5EC5
    ld a, d
    sub a, $10
    ld [wMessageIndex], a
    ld a, e
    ld [wMessageGroup], a
    jr Jump_012_5ECF

Jump_012_5EAD::
    ld a, d
    ld [wMessageIndex], a
    ld a, e
    add a, $10
    ld [wMessageGroup], a
    jr Jump_012_5ECF

Jump_012_5EB9::
    ld a, d
    add a, $10
    ld [wMessageIndex], a
    ld a, e
    ld [wMessageGroup], a
    jr Jump_012_5ECF

Jump_012_5EC5::
    ld a, d
    ld [wMessageIndex], a
    ld a, e
    sub a, $10
    ld [wMessageGroup], a

Jump_012_5ECF::
    ld a, $0E
    ldh [hFF8D], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wC8F4], a
    ld [wC8F9], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; only called from ScriptCommand83_Run (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommand83_Run)
; reads: wScriptStep
; writes: wJoypadHeld, wJoypadPressed
ScriptCommand83_Run_Sub03::
Func_012_5EE7:: ; address name
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wScriptStep]
    rst $00
    dw ScriptStepMoveFollowersToLeader
    dw ScriptStepMoveFollowersToLeader
    dw ScriptStepMoveFollowersToLeader
    dw Func_012_5EE7_Case03
    dw Func_012_5DB6_Case04
    dw Func_012_5DB6_Case05
    dw Func_012_5DB6_Case06
    dw Func_012_5EE7_Case07
    dw Func_012_5EE7_Case08
    dw Func_012_5EE7_Case09

; entry 4 of the `rst $00` table in Func_012_5DB6
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
Func_012_5DB6_Case04::
Jump_012_5F06:: ; address name
    ld b, $1E
    call StepWC921Counter_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in Func_012_5DB6
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerFacing, wFollowerRecords
; writes: wC928, wC929, hPlayerFacing, wScriptParam0
; points at: hPlayerY, wScriptStep
Func_012_5DB6_Case05::
Jump_012_5F11:: ; address name
    ld de, hPlayerY
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and a, $01
    jr nz, Jump_012_5F30
    ldh a, [hPlayerFacing]
    inc a
    and a, $03
    ldh [hPlayerFacing], a

Jump_012_5F30::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    ld a, [wFollowerRecords]
    ldh [hPlayerFacing], a
    ld a, $7A
    call QueueSoundEffect
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in Func_012_5EE7
; no direct call (reached through a table, a jump or a vector)
; reads: hFF8C, wScriptParam0, hPlayerX, hPlayerY, hPlayerFacing
; writes: wC951, hFF8C, wC928, wC929, wScriptParam0, wC8F0, wC8F5, wC8FA, ...
; points at: hPlayerY
Func_012_5EE7_Case09::
Jump_012_5F4D:: ; address name
    ld a, $01
    ld [wC951], a
    ldh a, [hFF8C]
    or a, $A0
    ldh [hFF8C], a
    ld de, hPlayerY
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and a, $03
    jr nz, Jump_012_5F74
    ld hl, hPlayerY
    inc [hl]

Jump_012_5F74::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    jr nz, Jump_012_5FC8
    ldh a, [hFF8C]
    and a, $5F
    ldh [hFF8C], a
    ldh a, [hPlayerX]
    ld [wC8F0], a
    ld [wC8F5], a
    ld [wC8FA], a
    ldh a, [hPlayerY]
    ld [wC8F1], a
    ld [wC8F6], a
    ld [wC8FB], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wC8F4], a
    ld [wC8F9], a
    xor a, a
    ldh [hFF8D], a
    ld a, $80
    ld [wScriptStartRequest], a
    ldh a, [hFF8C]
    or a, $01
    ldh [hFF8C], a
    ld hl, $0000
    ld a, l
    ldh [hFF9B], a
    ld a, h
    ldh [hFF9C], a
    ld a, l
    ldh [hFF9D], a
    ld a, h
    ldh [hFF9E], a
    xor a, a
    ld [wC951], a
    ret

Jump_012_5FC8::
    ret

; entry 8 of the `rst $00` table in Func_012_5EE7
; no direct call (reached through a table, a jump or a vector)
; reads: wC468, hFF8C, hPlayerX, hPlayerY, hPlayerFacing, wJoypadHeld, wSpriteSlotCount, wCB8A, ...
; writes: wJoypadHeld, hFF8B, hPlayerY, wScriptParam0, hPlayerFacing
; points at: wC910, wScriptStep
Func_012_5EE7_Case08::
Jump_012_5FC9:: ; address name
    ld a, [wC468]
    bit 7, a
    ret nz
    ldh a, [hFF8C]
    bit 0, a
    ret nz
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    ldh a, [hPlayerFacing]
    or a, a
    jr z, Jump_012_5FF5
    dec a
    jr z, Jump_012_6006
    dec a
    jr z, Jump_012_6017
    ld a, [wJoypadHeld]
    set 5, a
    ld [wJoypadHeld], a
    ld a, b
    or a, a
    ret z
    sub a, $10
    ld b, a
    jr Jump_012_6025

Jump_012_5FF5::
    ld a, [wJoypadHeld]
    set 7, a
    ld [wJoypadHeld], a
    ld a, c
    cp a, $80
    ret z
    add a, $10
    ld c, a
    jr Jump_012_6025

Jump_012_6006::
    ld a, [wJoypadHeld]
    set 4, a
    ld [wJoypadHeld], a
    ld a, b
    cp a, $90
    ret z
    add a, $10
    ld b, a
    jr Jump_012_6025

Jump_012_6017::
    ld a, [wJoypadHeld]
    set 6, a
    ld [wJoypadHeld], a
    ld a, c
    or a, a
    ret z
    sub a, $10
    ld c, a

Jump_012_6025::
    ld a, [wSpriteSlotCount]
    or a, a
    jr z, Jump_012_6037
    ld a, [wCB8A]
    cp a, b
    jr nz, Jump_012_6037
    ld a, [wCB8B]
    cp a, c
    jr z, Jump_012_606A

Jump_012_6037::
    call ReadTileBuffer2x2AtPixel_Bank12_6854
    ld b, $04
    ld hl, wC910
    ld b, $02
    ld a, [wMaxBlockingTile]
    ld e, a
    ld a, [wC196]
    ld d, a

Jump_012_6049::
    ld a, [hl+]
    cp a, d
    jr z, Jump_012_6066
    jr c, Jump_012_6066
    cp a, e
    jr z, Jump_012_606A
    jr c, Jump_012_606A
    xor a, a
    ldh [hFF8B], a
    ldh a, [hPlayerY]
    sub a, $08
    ldh [hPlayerY], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_012_6066::
    dec b
    jr nz, Jump_012_6049
    ret

Jump_012_606A::
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ldh [hPlayerFacing], a
    xor a, a
    ld [wJoypadHeld], a
    ret

; entry 7 of the `rst $00` table in Func_012_5EE7
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerY, hPlayerFacing
; writes: wC928, wC929, wScriptParam0, hPlayerY, hFF8B
; points at: hPlayerY, wScriptStep, hPlayerX
Func_012_5EE7_Case07::
Jump_012_6077:: ; address name
    ld de, hPlayerY
    ld a, e
    ld [wC928], a
    ld a, d
    ld [wC929], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and a, $03
    jr nz, Jump_012_6093
    ld hl, hPlayerY
    dec [hl]

Jump_012_6093::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    jr nz, Jump_012_60B3
    ldh a, [hPlayerY]
    add a, $08
    and a, $F0
    ldh [hPlayerY], a
    ld a, $02
    ldh [hFF8B], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

Jump_012_60B3::
    call DrawScriptMetaSprite21AtScrollOffset
    ld a, [wScriptParam0]
    and a, $01
    ret z
    ldh a, [hPlayerFacing]
    or a, a
    jr z, Jump_012_60CC
    dec a
    jr z, Jump_012_60D1
    dec a
    jr z, Jump_012_60D6
    ld hl, hPlayerX
    dec [hl]
    ret

Jump_012_60CC::
    ld hl, hPlayerY
    inc [hl]
    ret

Jump_012_60D1::
    ld hl, hPlayerX
    inc [hl]
    ret

Jump_012_60D6::
    ld hl, hPlayerY
    dec [hl]
    ret

; entry 6 of the `rst $00` table in Func_012_5DB6
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0, hFF8D
; points at: wScriptStep
Func_012_5DB6_Case06::
Jump_012_60DB:: ; address name
    ld a, [wScriptParam0]
    cp a, $1E
    jr nc, Jump_012_60E8
    bit 1, a
    jr z, Jump_012_60F8
    jr Jump_012_60FD

Jump_012_60E8::
    cp a, $3C
    jr nc, Jump_012_60F2
    bit 2, a
    jr z, Jump_012_60F8
    jr Jump_012_60FD

Jump_012_60F2::
    bit 3, a
    jr z, Jump_012_60F8
    jr Jump_012_60FD

Jump_012_60F8::
    call DrawScriptMetaSprite21AtScrollOffset
    jr Jump_012_60FD

Jump_012_60FD::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $78
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld a, $0E
    ldh [hFF8D], a
    ret

; draws metasprite set $21 (or $22 unless wC195 & $0F = 1), flipped by the player facing, at the scroll position plus (wMessageIndex + 8, wMessageGroup + $10) (E-0125)
; 4 call sites from 4 routines (e.g. Func_012_5EE7_Case07, Func_012_5DB6_Case08, Func_012_5DB6_Case07, Func_012_5DB6_Case06)
; reads: wC195, hPlayerFacing, hScrollX, hScrollXHi, wMessageIndex, hScrollY, hScrollYHi, wMessageGroup
; writes: hSpriteSetIndex, hSpriteAttrXor, hSpriteSubIndex, hSpriteTileOffset, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, hSpriteOriginYHi
; points at: hSpriteSetIndex
DrawScriptMetaSprite21AtScrollOffset::
Func_012_6114:: ; address name
    ld a, $21
    ldh [hSpriteSetIndex], a
    ld a, [wC195]
    and a, $0F
    dec a
    jr z, Jump_012_6124
    ld hl, hSpriteSetIndex
    inc [hl]

Jump_012_6124::
    ld a, $07
    ldh [hSpriteAttrXor], a
    ldh a, [hPlayerFacing]
    cp a, $01
    jr nz, Jump_012_6132
    ld a, $27
    ldh [hSpriteAttrXor], a

Jump_012_6132::
    xor a, a
    ldh [hSpriteSubIndex], a
    ld a, $70
    ldh [hSpriteTileOffset], a
    ldh a, [hScrollX]
    ld l, a
    ldh a, [hScrollXHi]
    ld h, a
    ld a, [wMessageIndex]
    add a, $08
    add_a_to_hl
    ld a, l
    ldh [hSpriteOriginX], a
    ld a, h
    ldh [hSpriteOriginXHi], a
    ldh a, [hScrollY]
    ld l, a
    ldh a, [hScrollYHi]
    ld h, a
    ld a, [wMessageGroup]
    add a, $10
    add_a_to_hl
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, h
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

; entry 3 of the `rst $00` table in Func_012_5EE7
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, hPlayerY, hPlayerFacing
; writes: wC527, wMessageIndex, wMessageGroup, hFF8D, wFollowerRecords, wC8F4, wC8F9, wScriptParam0
; points at: wOBJPaletteBuffer, wScriptStep
Func_012_5EE7_Case03::
Jump_012_616C:: ; address name
    ld de, Data_07E_594A
    ld b, $7E
    ld hl, vTiles0 + $700
    call DecompressToVRAM
    ld de, $0108
    ld a, e
    add a, $BD
    ld e, a
    ld a, d
    adc a, $4B
    ld d, a
    ld b, $7E
    ld a, $38
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld c, $08
    call CopyFromBank
    ld a, $7F
    ld [wC527], a
    ldh a, [hPlayerX]
    ld d, a
    ldh a, [hPlayerY]
    ld e, a
    ldh a, [hPlayerFacing]
    or a, a
    jr z, Jump_012_61B5
    dec a
    jr z, Jump_012_61C1
    dec a
    jr z, Jump_012_61CD
    ld a, d
    sub a, $10
    ld [wMessageIndex], a
    ld a, e
    ld [wMessageGroup], a
    jr Jump_012_61D7

Jump_012_61B5::
    ld a, d
    ld [wMessageIndex], a
    ld a, e
    add a, $10
    ld [wMessageGroup], a
    jr Jump_012_61D7

Jump_012_61C1::
    ld a, d
    add a, $10
    ld [wMessageIndex], a
    ld a, e
    ld [wMessageGroup], a
    jr Jump_012_61D7

Jump_012_61CD::
    ld a, d
    ld [wMessageIndex], a
    ld a, e
    sub a, $10
    ld [wMessageGroup], a

Jump_012_61D7::
    ld a, $0E
    ldh [hFF8D], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wC8F4], a
    ld [wC8F9], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; script step: first frame sets the follower targets from the leader; later frames step the followers until the wC921 counter reaches $11, then advances wScriptStep (E-0122)
; 7 call sites from 7 routines (e.g. ScriptCommand43_Run_Case04, ScriptCommand38_Run_Case00, ScriptCommand61_Run_Case00, ScriptCommand64_Run_Case00, ...)
; reads: wScriptParam0
; points at: wScriptParam0, wScriptStep
ScriptStepMoveFollowersToLeader::
Func_012_61EF:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_012_6200
    farcall SetFollowerTargetsFromLeader
    ld hl, wScriptParam0
    inc [hl]
    ret

Jump_012_6200::
    farcall StepFollowersTowardTargets
    ld b, $11
    call StepWC921Counter_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 86; reached through ScriptCommand86 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand86)
; reads: wScriptStep
ScriptCommand86_Run::
Func_012_6211:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand86_Run_Case00
    dw ScriptCommand86_Run_Case01
    dw ScriptCommand86_Run_Case02
    dw ScriptCommand86_Run_Case01
    dw ScriptCommand86_Run_Case04

; entry 4 of the `rst $00` table in ScriptCommand86_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wCC45
; writes: wScriptStartRequest
; points at: wCDAF
ScriptCommand86_Run_Case04::
Jump_012_621F:: ; address name
    farcall ScriptCommand86_Run_Case04_Sub01
    ld a, [wCC45]
    swap a
    ld hl, wCDAF
    add_a_to_hl
    ld a, $FF
    ld [hl], a
    farcall DrawDoorTilesForWCC45
    farcall DrawFullScreenBufferAtScroll
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommand86_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wScriptParam1, wCC45
; writes: wScriptStartRequest, wC928
; points at: wCDAF
ScriptCommand86_Run_Case02::
Jump_012_6247:: ; address name
    ld a, [wScriptParam0]
    ld l, a
    ld a, [wScriptParam1]
    or a, l
    jr nz, Jump_012_6257
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_012_6257::
    push hl
    ld a, [wCC45]
    swap a
    ld hl, wCDAF
    add_a_to_hl
    ld a, $FF
    ld [hl], a
    pop hl
    ld a, l
    bit 7, a
    jr nz, Jump_012_6279
    ld [wC928], a
    farcall AppendItemWC928ToInventory
    jr Jump_012_6279

Jump_012_6279::
    farcall DrawDoorTilesForWCC45
    farcall DrawFullScreenBufferAtScroll
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in ScriptCommand86_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand86_Run_Case01::
Jump_012_628B:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand86_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wScriptParam1, wC634, wCECE, hFFC6
; writes: wScriptParam0, wScriptParam1, wScriptStep
; points at: wScriptStep, wC152
ScriptCommand86_Run_Case00::
Jump_012_6295:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wScriptParam0]
    ld l, a
    ld a, [wScriptParam1]
    or a, l
    jr nz, Jump_012_62A9
    ld a, $00
    call StartMessageA
    ret

Jump_012_62A9::
    ld a, l
    cp a, $80
    jr z, Jump_012_62DA
    cp a, $81
    jr z, Jump_012_62FC
    ld de, wC152
    call CopyItemNameToDE
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_012_62C3
    cp a, $00
    jr nz, Jump_012_62C9

Jump_012_62C3::
    ld a, $02
    call StartMessageA
    ret

Jump_012_62C9::
    ld a, $03
    call StartMessageA
    ld hl, $0000
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ret

Jump_012_62DA::
    farcall Func_012_689A
    ldh a, [hFFC6]
    or a, a
    jr z, Jump_012_62EB
    ld a, $08
    call StartMessageA
    ret

Jump_012_62EB::
    ld a, $09
    call StartMessageA
    ld hl, $0000
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ret

Jump_012_62FC::
    ld a, [wCECE]
    cp a, $01
    jr z, Jump_012_62DA
    ld a, $19
    call StartMessageA
    ld a, $03
    ld [wScriptStep], a
    ret

; implements script command type 81; reached through ScriptCommand81 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand81)
; reads: wScriptStep
ScriptCommand81_Run::
Func_012_630E:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand81_Run_Case00
    dw ScriptCommand81_Run_Case01
    dw ScriptCommand81_Run_Case02

; entry 2 of the `rst $00` table in ScriptCommand81_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wScriptParam1
; writes: wScriptStartRequest, wC928
ScriptCommand81_Run_Case02::
Jump_012_6318:: ; address name
    ld a, [wScriptParam0]
    ld l, a
    ld a, [wScriptParam1]
    or a, l
    jr nz, Jump_012_6328
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_012_6328::
    ld a, [wScriptParam0]
    ld l, a
    ld a, [wScriptParam1]
    ld h, a
    inc hl
    ld a, [hl]
    ld [wC928], a
    inc hl
    inc hl
    ld [hl], $01
    farcall AppendItemWC928ToInventory
    farcall CheckTwoWCDB0EntriesForWCC43
    farcall DrawFullScreenBufferAtScroll
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in ScriptCommand81_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand81_Run_Case01::
Jump_012_6351:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand81_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wScriptParam1, wC634
; writes: wScriptParam0, wScriptParam1
; points at: wScriptStep, wC152
ScriptCommand81_Run_Case00::
Jump_012_635B:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wScriptParam0]
    ld l, a
    ld a, [wScriptParam1]
    ld h, a
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    or a, a
    jr z, Jump_012_6374
    ld a, $00
    call StartMessageA
    ret

Jump_012_6374::
    dec hl
    dec hl
    ld a, [hl]
    and a, $7F
    ld de, wC152
    call CopyItemNameToDE
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_012_638A
    cp a, $00
    jr nz, Jump_012_6390

Jump_012_638A::
    ld a, $02
    call StartMessageA
    ret

Jump_012_6390::
    ld a, $03
    call StartMessageA
    ld hl, $0000
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ret

; implements script command type 80; reached through ScriptCommand80 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand80)
; reads: wScriptStep
ScriptCommand80_Run::
Func_012_63A1:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand80_Run_Case00
    dw ScriptCommand80_Run_Case01
    dw ScriptCommand80_Run_Case02
    dw ScriptCommand80_Run_Case03
    dw ScriptCommand80_Run_Case04
    dw ScriptCommand80_Run_Case05

; entry 5 of the `rst $00` table in ScriptCommand80_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
ScriptCommand80_Run_Case05::
Jump_012_63B1:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 4 of the `rst $00` table in ScriptCommand80_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC903, wC905, wScriptStartRequest
ScriptCommand80_Run_Case04::
Jump_012_63B7:: ; address name
    ld a, $05
    ld [wC903], a
    ld a, $01
    ld [wC905], a
    farcall SetModeState3AndSaveScreen
    call ScriptCommand80_Run_Shared01
    ld a, [hl]
    or a, $80
    ld [hl], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 3 of the `rst $00` table in ScriptCommand80_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wC928, wC8FE, wScriptStartRequest
ScriptCommand80_Run_Case03::
Jump_012_63D4:: ; address name
    call ScriptCommand80_Run_Shared01
    inc hl
    ld a, [hl]
    ld [wC928], a
    dec hl
    ld a, [hl]
    or a, $80
    ld [hl], a
    ld a, $FF
    ld [wC8FE], a
    farcall AppendItemWC928ToInventory
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommand80_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hFFC6, hFFC7, wC8FE, wScriptStartRequest
ScriptCommand80_Run_Case02::
Jump_012_63F2:: ; address name
    call ScriptCommand80_Run_Shared01
    inc hl
    ld a, [hl]
    push hl
    ld l, a
    ld h, $00
    ld e, a
    ld d, $00
    add hl, hl
    add hl, hl
    add hl, de
    add hl, hl
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    farcall AddGoldCapped
    pop hl
    dec hl
    ld a, [hl]
    or a, $80
    ld [hl], a
    ld a, $FF
    ld [wC8FE], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in ScriptCommand80_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptStep
ScriptCommand80_Run_Case01::
Jump_012_641F:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank12
    ret nc
    ld a, [wScriptParam0]
    ld [wScriptStep], a
    ret

; entry 0 of the `rst $00` table in ScriptCommand80_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wC634
; writes: wScriptParam0, wC8C0, wC8C1, wC8C2
; points at: wScriptStep, wC152, wC17E
ScriptCommand80_Run_Case00::
Jump_012_642B:: ; address name
    ld hl, wScriptStep
    inc [hl]
    call ScriptCommand80_Run_Shared01
    ld a, [hl]
    or a, a
    jr nz, Jump_012_6467
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_012_6441
    cp a, $00
    jr nz, Jump_012_6454

Jump_012_6441::
    inc hl
    ld a, [hl]
    ld de, wC152
    call CopyItemNameToDE
    ld a, $06
    call StartMessageA
    ld a, $03
    ld [wScriptParam0], a
    ret

Jump_012_6454::
    inc hl
    ld a, [hl]
    ld de, wC152
    call CopyItemNameToDE
    ld a, $07
    call StartMessageA
    ld a, $05
    ld [wScriptParam0], a
    ret

Jump_012_6467::
    dec a
    jr nz, Jump_012_6496
    inc hl
    ld a, [hl]
    ld l, a
    ld h, $00
    ld e, a
    ld d, $00
    add hl, hl
    add hl, hl
    add hl, de
    add hl, hl
    ld a, l
    ld [wC8C0], a
    ld a, h
    ld [wC8C1], a
    xor a, a
    ld [wC8C2], a
    call Number24ToPackedBCD
    ld de, wC17E
    call WritePackedBCDNoLeadingZeros
    ld a, $05
    call StartMessageA
    ld a, $02
    ld [wScriptParam0], a
    ret

Jump_012_6496::
    dec a
    jr nz, Jump_012_64CA
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_012_64A4
    cp a, $00
    jr nz, Jump_012_64B7

Jump_012_64A4::
    inc hl
    ld a, [hl]
    ld de, wC152
    call CopyItemNameToDE
    ld a, $02
    call StartMessageA
    ld a, $03
    ld [wScriptParam0], a
    ret

Jump_012_64B7::
    inc hl
    ld a, [hl]
    ld de, wC152
    call CopyItemNameToDE
    ld a, $03
    call StartMessageA
    ld a, $05
    ld [wScriptParam0], a
    ret

Jump_012_64CA::
    ld a, $04
    call StartMessageA
    ld a, $04
    ld [wScriptParam0], a
    ret

; only called from routines of ScriptCommand80_Run (E-0098)
; 4 call sites from 4 routines (e.g. ScriptCommand80_Run_Case04, ScriptCommand80_Run_Case03, ScriptCommand80_Run_Case02, ScriptCommand80_Run_Case00)
; reads: wCCE9, wC900
; points at: wCC48, wCCEB
ScriptCommand80_Run_Shared01::
Func_012_64D5:: ; address name
    ld a, [wCCE9]
    or a, a
    jr nz, Jump_012_64EA
    ld a, [wC900]
    add a, a
    add a, a
    add a, a
    ld hl, wCC48
    add_a_to_hl
    ret

Jump_012_64EA::
    ld a, [wC900]
    add a, a
    add a, a
    ld hl, wCCEB
    add_a_to_hl
    ret

; with SRAM enabled sets every party record's HP to max HP, MP to max MP and field $55 to 0 (E-0125)
; 10 call sites from 9 routines (e.g. ScriptCommand96_Run_Case18, ScriptCommand9B_Run_Case04, RunWC8C7Phase_Case02, GameMode5_Init_Case06, ...)
; reads: wC6FD, hFFC6, hFFC7
; writes: rRAMG
; points at: wC6FE
FullyHealParty::
Func_012_64F8:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE

Jump_012_6504::
    push hl
    ld a, [hl]
    push af
    ld c, $5D
    call LoadSRAMRecordWord
    pop af
    push af
    ld c, $5B
    call SRAMRecordAddress
    ldh a, [hFFC6]
    ld [hl+], a
    ldh a, [hFFC7]
    ld [hl], a
    pop af
    push af
    ld c, $61
    call LoadSRAMRecordWord
    pop af
    push af
    ld c, $5F
    call SRAMRecordAddress
    ldh a, [hFFC6]
    ld [hl+], a
    ldh a, [hFFC7]
    ld [hl], a
    pop af
    ld c, $55
    call SRAMRecordAddress
    xor a, a
    ld [hl], a
    pop hl
    inc hl
    dec b
    jr nz, Jump_012_6504
    xor a, a
    ld [rRAMG], a
    ret

; for 30 frames alternates every 4 frames between the normal palettes and their inverse (DMG palettes $D2/$E2 and $2D/$1D), then advances wScriptStep (E-0127)
; 7 call sites from 7 routines (e.g. ScriptCommand58_Run_Case21, ScriptCommand4A_Run_Case01, ScriptCommand41_Run_Case07, ScriptCommandA0_Run_Case01, ...)
; reads: wScriptParam0, wIsCGB
; writes: wC526, wScriptParam0
; points at: wC5E9, wC0F0, wBGPaletteBuffer, wScriptStep
ScriptStepFlashScreenNegative::
Func_012_653F:: ; address name
    ld a, [wScriptParam0]
    srl a
    srl a
    and a, $01
    jr z, Jump_012_656A
    ld hl, wC5E9
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_012_6591
    ld hl, wC0F0
    ld de, wBGPaletteBuffer
    ld bc, $0040
    call CopyBytes
    jr Jump_012_658C

Jump_012_656A::
    ld hl, wC5E9
    ld a, $2D
    ld [hl+], a
    ld a, $2D
    ld [hl+], a
    ld a, $1D
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_012_6591
    ld b, $40
    ld hl, wC0F0
    ld de, wBGPaletteBuffer

Jump_012_6584::
    ld a, [hl+]
    xor a, $FF
    ld [de], a
    inc de
    dec b
    jr nz, Jump_012_6584

Jump_012_658C::
    ld a, $7F
    ld [wC526], a

Jump_012_6591::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $1E
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; wC921 += 1; if it now equals B it is reset to 0 and carry is set, else carry is clear; returns A = 0 either way (the same 18 bytes appear in 3 banks)
; 10 call sites from 10 routines (e.g. ScriptCommand96_Run_Case04, ScriptCommand8D_Run_Case15, ScriptCommand9F_Run_Case05, ScriptCommand9F_Run_Case03, ...)
; reads: wScriptParam0
; writes: wScriptParam0
StepWC921Counter_Bank12::
Func_012_65A4:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, b
    jr z, Jump_012_65B0
    sub a, a
    ret

Jump_012_65B0::
    xor a, a
    ld [wScriptParam0], a
    scf
    ret

; entry 4 of the `rst $00` table in ScriptCommand87_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0, hFF8D, wC527
; points at: wScriptStep
ScriptCommand87_Run_Case04::
Jump_012_65B6:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, Jump_012_65C5
    inc a
    ld [wScriptParam0], a
    ld a, $0E
    ldh [hFF8D], a
    ret

Jump_012_65C5::
    farcall MoveIncapacitatedPartyMembersBack
    farcall MoveIncapacitatedPartyMembersBack
    call LoadRecordListNameTiles
    farcall Func_004_4AA8
    ld a, $7F
    ld [wC527], a
    xor a, a
    ldh [hFF8D], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; [HL] |= $02; clobbers A (the same 5 bytes appear in 4 banks)
; 2 call sites from 2 routines (e.g. ScriptCommand93_Run_Case03, ScriptCommand94_Run_Case00)
SetBit1AtHL_Bank12::
Func_012_65EB:: ; address name
    ld a, [hl]
    or a, $02
    ld [hl], a
    ret

; [HL] &= $FD; clobbers A (the same 5 bytes appear in 4 banks)
; 1 call site from 1 routine (e.g. ScriptCommand94_Run_Case02)
ClearBit1AtHL_Bank12::
Func_012_65F0:: ; address name
    ld a, [hl]
    and a, $FD
    ld [hl], a
    ret

; sets bit 2 of the byte at [HL]; only A is clobbered
; 14 call sites from 11 routines (e.g. ScriptCommand99_Run_Case05, ScriptCommand99_Run_Case00, ScriptCommand98_Run_Case05, ScriptCommand98_Run_Case00, ...)
SetBit2AtHL_B12::
Func_012_65F5:: ; address name
    ld a, [hl]
    or a, $04
    ld [hl], a
    ret

; [HL] &= $FB; clobbers A (the same 5 bytes appear in 4 banks)
; 7 call sites from 4 routines (e.g. ScriptCommand99_Run_Case0B, ScriptCommand96_Run_Case09, ScriptCommand96_Run_Case02, ScriptCommand9F_Run_Case01)
ClearBit2AtHL_Bank12::
Func_012_65FA:: ; address name
    ld a, [hl]
    and a, $FB
    ld [hl], a
    ret

; A = the player's moving coordinate: when A & $0F = 0 (a 16-pixel tile boundary) far-calls SetFollowerTargetsFromLeader; then always far-calls StepFollowersTowardTargets (E-0093) (the same 17 bytes appear in 3 banks)
; 21 call sites from 13 routines (e.g. ScriptCommand99_Run_Case02, ScriptCommand99_Run_Case01, ScriptCommand99_Run_Case00, ScriptCommand98_Run_Case06, ...)
UpdateFollowersOnStep_Bank12::
Func_012_65FF:: ; address name
    and a, $0F
    jr nz, Jump_012_6609
    farcall SetFollowerTargetsFromLeader

Jump_012_6609::
    farcall StepFollowersTowardTargets
    ret

; the bank-$12 message runner: the same four states as RunMessageBox, with A on the stack as the freeze flag instead of wC928 (state 0 also reads hMapId; not compared in full) (E-0079)
; 1 call site from 1 routine (e.g. RunMessageBoxCarryWhenIdle_Bank12)
; reads: wMessageState
RunMessageBox_Bank12::
Func_012_6610:: ; address name
    push af
    ld a, [wMessageState]
    cp a, $FF
    jr nz, Jump_012_661A
    pop af
    ret

Jump_012_661A::
    rst $00
    dw RunMessageBox_Bank12_Case00
    dw RunMessageBox_Bank12_Case01
    dw RunMessageBox_Bank12_Case02
    dw RunMessageBox_Bank12_Case03

; entry 0 of the `rst $00` table in RunMessageBox_Bank12
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageGroup, hMapId, hPlayerY
; writes: wC8CB, wC8CC, hFFB9
; points at: wMessageState
RunMessageBox_Bank12_Case00::
Jump_012_6623:: ; address name
    pop af
    or a, a
    jr nz, Jump_012_662D
    farcall SetBit1OfPlayerAndObjectFlags

Jump_012_662D::
    ld a, [wMessageGroup]
    bit 7, a
    jr nz, Jump_012_6668
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    call FillTilesFromRequest
    ld a, $69
    call QueueSoundEffect
    ld a, $01
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ldh a, [hMapId]
    cp a, $14
    jr z, Jump_012_6659
    ld a, $02
    ldh [hFFB9], a

Jump_012_6659::
    ldh a, [hPlayerY]
    cp a, $48
    jr c, Jump_012_6668
    ld a, $81
    ld [wC8CB], a
    ld a, $01
    ldh [hFFB9], a

Jump_012_6668::
    ld hl, wMessageState
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunMessageBox_Bank12
; no direct call (reached through a table, a jump or a vector)
; reads: wC8CB, wMessageIndex
; writes: wStringIndex, wStringCategory
; points at: wMessageState
RunMessageBox_Bank12_Case01::
Jump_012_666D:: ; address name
    pop af
    ld a, [wC8CB]
    and a, $03
    ret nz
    ld a, [wMessageIndex]
    ld [wStringIndex], a
    ld a, $01
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank09
    ld hl, wMessageState
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunMessageBox_Bank12
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wMessageGroup, hPlayerY
; writes: wMessageState, wC8CB, wC8CC, hFFB9
; points at: wMessageState
RunMessageBox_Bank12_Case02::
Jump_012_668A:: ; address name
    pop af
    ld a, [wC52B]
    bit 0, a
    ret nz
    ld a, [wMessageGroup]
    bit 6, a
    jr z, Jump_012_669E
    ld a, $FF
    ld [wMessageState], a
    ret

Jump_012_669E::
    ld a, $69
    call QueueSoundEffect
    ld a, $02
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ld a, $00
    ldh [hFFB9], a
    ldh a, [hPlayerY]
    cp a, $48
    jr c, Jump_012_66BC
    ld a, $82
    ld [wC8CB], a

Jump_012_66BC::
    ld hl, wMessageState
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunMessageBox_Bank12
; no direct call (reached through a table, a jump or a vector)
; reads: wC8CB
; writes: wMessageState
RunMessageBox_Bank12_Case03::
Jump_012_66C1:: ; address name
    ld a, [wC8CB]
    and a, $03
    jr z, Jump_012_66CA
    pop af
    ret

Jump_012_66CA::
    pop af
    or a, a
    jr nz, Jump_012_66D4
    farcall ClearBit1OfPlayerAndObjectFlags

Jump_012_66D4::
    ld a, $FF
    ld [wMessageState], a
    ret

; unless wMessageState is $FF (idle), runs the message box step for wMessageState (jump table) (E-0122)
; 1 call site from 1 routine (e.g. RunMessageBoxThenContinue_684A)
; reads: wMessageState
RunMessageBoxStateIfActive_Bank12::
Func_012_66DA:: ; address name
    push af
    ld a, [wMessageState]
    cp a, $FF
    jr nz, Jump_012_66E4
    pop af
    ret

Jump_012_66E4::
    rst $00
    dw RunMessageBoxStateIfActive_Bank12_Case00
    dw RunMessageBoxStateIfActive_Bank12_Case01
    dw RunMessageBoxStateIfActive_Bank12_Case02
    dw RunMessageBox_Bank12_Case03

; entry 0 of the `rst $00` table in RunMessageBoxStateIfActive_Bank12
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, hPlayerY
; writes: wC8CB, wC8CC, hFFB9
; points at: wMessageState
RunMessageBoxStateIfActive_Bank12_Case00::
Jump_012_66ED:: ; address name
    pop af
    or a, a
    jr nz, Jump_012_66F7
    farcall SetBit1OfPlayerAndObjectFlags

Jump_012_66F7::
    ld a, [wMessageIndex]
    bit 7, a
    jr nz, Jump_012_672C
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    call FillTilesFromRequest
    ld a, $69
    call QueueSoundEffect
    ld a, $01
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ld a, $02
    ldh [hFFB9], a
    ldh a, [hPlayerY]
    cp a, $48
    jr c, Jump_012_672C
    ld a, $81
    ld [wC8CB], a
    ld a, $01
    ldh [hFFB9], a

Jump_012_672C::
    ld hl, wMessageState
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunMessageBoxStateIfActive_Bank12
; no direct call (reached through a table, a jump or a vector)
; reads: wC8CB, wMessageIndex
; writes: wStringIndex, wStringCategory
; points at: wMessageState
RunMessageBoxStateIfActive_Bank12_Case01::
Jump_012_6731:: ; address name
    pop af
    ld a, [wC8CB]
    and a, $03
    ret nz
    ld a, [wMessageIndex]
    and a, $3F
    ld [wStringIndex], a
    ld a, $09
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank09
    ld hl, wMessageState
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunMessageBoxStateIfActive_Bank12
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wMessageIndex, hPlayerY
; writes: wMessageState, wC8CB, wC8CC, hFFB9
; points at: wMessageState
RunMessageBoxStateIfActive_Bank12_Case02::
Jump_012_6750:: ; address name
    pop af
    ld a, [wC52B]
    bit 0, a
    ret nz
    ld a, [wMessageIndex]
    bit 6, a
    jr z, Jump_012_6764
    ld a, $FF
    ld [wMessageState], a
    ret

Jump_012_6764::
    ld a, $69
    call QueueSoundEffect
    ld a, $02
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ld a, $00
    ldh [hFFB9], a
    ldh a, [hPlayerY]
    cp a, $48
    jr c, Jump_012_6782
    ld a, $82
    ld [wC8CB], a

Jump_012_6782::
    ld hl, wMessageState
    inc [hl]
    ret

; only called from ScriptCommand85_Run_Case05_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommand85_Run_Case05_Sub01)
; reads: wMessageState
ScriptCommand85_Run_Case05_Sub01_Sub01::
Func_012_6787:: ; address name
    push af
    ld a, [wMessageState]
    cp a, $FF
    jr nz, Jump_012_6791
    pop af
    ret

Jump_012_6791::
    rst $00
    dw Func_012_6787_Case00
    dw Func_012_6787_Case01
    dw Func_012_6787_Case02
    dw RunMessageBox_Bank12_Case03

; entry 0 of the `rst $00` table in Func_012_6787
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: wC8CB, wC8CC, hFFB9
; points at: wMessageState
Func_012_6787_Case00::
Jump_012_679A:: ; address name
    pop af
    or a, a
    jr nz, Jump_012_67A4
    farcall SetBit1OfPlayerAndObjectFlags

Jump_012_67A4::
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    call FillTilesFromRequest
    ld a, $01
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ld a, $02
    ldh [hFFB9], a
    ldh a, [hPlayerY]
    cp a, $48
    jr c, Jump_012_67CD
    ld a, $81
    ld [wC8CB], a
    ld a, $01
    ldh [hFFB9], a

Jump_012_67CD::
    ld hl, wMessageState
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_012_6787
; no direct call (reached through a table, a jump or a vector)
; reads: wC8CB, wMessageIndex
; writes: wStringIndex, wStringCategory
; points at: wMessageState
Func_012_6787_Case01::
Jump_012_67D2:: ; address name
    pop af
    ld a, [wC8CB]
    and a, $03
    ret nz
    ld a, [wMessageIndex]
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank8A
    ld hl, wMessageState
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_012_6787
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, hPlayerY
; writes: wC8CB, wC8CC, hFFB9
; points at: wMessageState
Func_012_6787_Case02::
Jump_012_67EE:: ; address name
    pop af
    ld a, [wC52B]
    bit 0, a
    ret nz
    ld a, $02
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ld a, $00
    ldh [hFFB9], a
    ldh a, [hPlayerY]
    cp a, $48
    jr c, Jump_012_680E
    ld a, $82
    ld [wC8CB], a

Jump_012_680E::
    ld hl, wMessageState
    inc [hl]
    ret

; the same 13 bytes as StartMessageHL_B0F (0F:7F68)
; 4 call sites from 4 routines (e.g. ScriptCommand9E_Run_Case02, ScriptCommand9E_Run_Case00, ScriptCommand85_Run_Case04, ScriptCommand85_Run_Case00)
; writes: wMessageIndex, wMessageGroup, wMessageState
StartMessageHL_B0F_Bank12::
Func_012_6813:: ; address name
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a, a
    ld [wMessageState], a
    ret

; wMessageIndex = A, wMessageState = 0: the next RunMessageBox call opens the window and shows that string of the group already in wMessageGroup (E-0063, E-0079)
; 35 call sites from 15 routines (e.g. ScriptCommandA1_Run_Case00, ScriptCommand9D_Run_Case00, ScriptCommand9C_Run_Case00, StartMessageFromTable48B9ByWC82C, ...)
; writes: wMessageIndex, wMessageState
StartMessageA::
Func_012_6820:: ; address name
    ld [wMessageIndex], a
    xor a, a
    ld [wMessageState], a
    ret

; wC928 = A, far-calls RunMessageBox, then carry set when wMessageState = $FF (idle), else A = 0 and carry clear (E-0079) (the same 20 bytes appear in 4 banks)
; 2 call sites from 2 routines (e.g. ScriptCommand9E_Run_Case01, ScriptCommand85_Run_Case01)
; reads: wMessageState
; writes: wC928
RunMessageBoxFar_Bank12::
Func_012_6828:: ; address name
    ld [wC928], a
    farcall RunMessageBox
    ld a, [wMessageState]
    cp a, $FF
    jr z, Jump_012_683A
    sub a, a
    ret

Jump_012_683A::
    scf
    ret

; RunMessageBox_Bank12 (A = the freeze flag), then carry set when wMessageState = $FF (idle), else A = 0 and carry clear (E-0079)
; 11 call sites from 11 routines (e.g. ScriptCommandA1_Run_Case01, ScriptCommand9D_Run_Case01, ScriptCommand8D_Run_Case1A, ScriptCommand9F_Run_Case0F, ...)
; reads: wMessageState
RunMessageBoxCarryWhenIdle_Bank12::
Func_012_683C:: ; address name
    call RunMessageBox_Bank12

Jump_012_683F::
    ld a, [wMessageState]
    cp a, $FF
    jr z, Jump_012_6848
    sub a, a
    ret

Jump_012_6848::
    scf
    ret

; runs RunMessageBoxStateIfActive_Bank12, then continues at Jump_012_683F (E-0126)
; 4 call sites from 4 routines (e.g. ScriptCommand96_Run_Case01, ScriptCommand96_Run_Case03, ScriptCommand95_Run_Case02, ScriptCommand95_Run_Case01)
; reads: wMessageState
RunMessageBoxThenContinue_684A::
Func_012_684A:: ; address name
    call RunMessageBoxStateIfActive_Bank12
    jr Jump_012_683F

; only called from ScriptCommand85_Run_Case05 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommand85_Run_Case05)
; reads: wMessageState
ScriptCommand85_Run_Case05_Sub01::
Func_012_684F:: ; address name
    call ScriptCommand85_Run_Case05_Sub01_Sub01
    jr Jump_012_683F

; B = X pixel, C = Y pixel: HL = wScreenTileBuffer + 20 * (C / 8) + B / 8 (rows of 20 entries); copies the 2 x 2 entries there to wC910, wC911 (top row) and wC912, wC913 (bottom row); HL ends on the bottom-right entry (E-0064) (the same 63 bytes appear in 3 banks)
; 1 call site from 1 routine (e.g. Func_012_5EE7_Case08)
; writes: wC910, wC911, wC912, wC913
ReadTileBuffer2x2AtPixel_Bank12_6854::
Func_012_6854:: ; address name
    ld a, c
    srl a
    srl a
    srl a
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add_a_to_hl
    add hl, hl
    add hl, hl
    ld a, b
    srl a
    srl a
    srl a
    add_a_to_hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    ld a, [hl+]
    ld [wC910], a
    ld a, [hl-]
    ld [wC911], a
    ld a, $14
    add_a_to_hl
    ld a, [hl+]
    ld [wC912], a
    ld a, [hl]
    ld [wC913], a
    ret

; runs Func_012_722A and Func_012_6EB7; shared by the field mode states (E-0122)
; 6 call sites from 6 routines (e.g. FieldModeStateDispatch_Case00, FieldModeStateDispatch_Case01, FieldModeStateDispatch_Case02, FieldModeStateDispatch_Case03, ...)
RunFunc722AAnd6EB7::
Func_012_6893:: ; address name
    call Func_012_722A
    call RunFunc722AAnd6EB7_Sub01
    ret

; 11 call sites from 10 routines (e.g. ScriptCommandF7_Run_Case27, ScriptCommandF7_Run_Case24, ScriptCommand86_Run_Case00, DispatchTalkEvent_Case01_Case65, ...)
; reads: hFFC6, hFFC8, hFFC7, hFFD0, wC966, wCD03, wCD04, wC836
; writes: wC966, hFFC6, hFFC7, hFFD0, wC836
; points at: wC70A, wC787
Func_012_689A::
    xor a, a
    ld [wC966], a

Jump_012_689E::
    call FindFreeKeySlotToHFFC6
    ldh a, [hFFC6]
    bit 7, a
    jr z, Jump_012_68AB
    xor a, a
    ldh [hFFC6], a
    ret

Jump_012_68AB::
    push af
    ld a, $FE
    ldh [hFFC7], a
    call WriteKeyEntryHFFC6
    pop af
    or a, a
    jr z, Jump_012_68FF
    ldh [hFFD0], a
    ld b, a
    ld hl, wC70A

Jump_012_68BD::
    push hl
    ld a, [hl-]
    bit 7, a
    jr nz, Jump_012_68F7
    ld a, [hl-]
    ld c, a
    ldh a, [hFFC8]
    cp a, c
    jr nz, Jump_012_68F7
    ld a, [hl]
    ld c, a
    ldh a, [hFFC7]
    cp a, c
    jr nz, Jump_012_68E9
    pop hl

Jump_012_68D2::
    ldh a, [hFFD0]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    jr Jump_012_689E

Jump_012_68E9::
    pop hl
    ld a, [wC966]
    inc a
    ld [wC966], a
    cp a, $14
    jr c, Jump_012_68D2
    jr Jump_012_68FF

Jump_012_68F7::
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    dec b
    jr nz, Jump_012_68BD

Jump_012_68FF::
    ld a, $01
    ldh [hFFC6], a
    ldh a, [hFFD0]
    add a, a
    ld hl, wC787
    add_a_to_hl
    ld a, [wCD03]
    ld [hl+], a
    ld a, [wCD04]
    ld [hl], a
    ld a, [wC836]
    set 7, a
    ld [wC836], a
    ret

; hFFC6 = the index of the first free wKeyList entry, or $80 when none is free or 20 entries lack bit 7 of byte 3 (E-0125)
; 3 call sites from 3 routines (e.g. Func_012_689A, ScriptStepCheckKeyListFull_6A80, ScriptStepCheckKeyListFull_6B45)
; writes: hFFC6
; points at: wKeyList
FindFreeKeySlotToHFFC6::
Func_012_691F:: ; address name
    ld b, $00
    ld d, $00
    ld hl, wKeyList

Jump_012_6926::
    push hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_012_6948
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr nz, Jump_012_6935
    inc d

Jump_012_6935::
    pop hl
    ld a, $04
    add_a_to_hl
    inc b
    ld a, b
    cp a, $20
    jr nz, Jump_012_6926
    ld a, $80
    ldh [hFFC6], a
    ret

Jump_012_6948::
    pop hl
    ld a, b
    ldh [hFFC6], a
    ld a, d
    cp a, $14
    ret nz
    ld a, $80
    ldh [hFFC6], a
    ret

; writes key entry hFFC6: byte 0 = hFFC7 and byte 3 = $80; for kind $FE generates the remaining bytes (Func_061_40B4, Func_060_6916) from hFFC7-hFFC9 (E-0125)
; 12 call sites from 10 routines (e.g. Func_012_689A, MapEventCountKeysAndStartScript5039, ScriptCommandF7_Run_Case24, ScriptCommand58_Run_Case2B, ...)
; reads: hFFC6, hFFC7, wCD05, hFFC8, hFFC9
; writes: hFFC6
WriteKeyEntryHFFC6::
Func_012_6955:: ; address name
    ldh a, [hFFC6]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    push hl
    ldh a, [hFFC7]
    ld [hl], a
    cp a, $FE
    jr z, Jump_012_6973
    pop hl
    inc hl
    inc hl
    inc hl
    ld [hl], $80
    ret

Jump_012_6973::
    farcall Func_061_40B4
    ld a, [wCD05]
    ldh [hFFC6], a
    farcall RollKeyContentsForLevelHFFC6
    pop hl
    inc hl
    ldh a, [hFFC7]
    ld [hl+], a
    ldh a, [hFFC8]
    ld [hl+], a
    ldh a, [hFFC9]
    ld [hl], a
    ret

; counts the 4-byte wKeyList entries before the first $FF: hFFC6 = the count, or $80 when all 32 are in use (E-0074)
; 11 call sites from 9 routines (e.g. MapEventCountKeysAndStartScript5039, ScriptCommandF7_Run_Case24, ScriptCommand58_Run_Case2B, TalkMsg0512_KamehaYo0Thanks, ...)
; writes: hFFC6
; points at: wKeyList
CountKeysOrFull::
Func_012_6990:: ; address name
    ld b, $00
    ld hl, wKeyList

Jump_012_6995::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_012_69AC
    ld a, $04
    add_a_to_hl
    inc b
    ld a, b
    cp a, $20
    jr nz, Jump_012_6995
    ld a, $80
    ldh [hFFC6], a
    ret

Jump_012_69AC::
    ld a, b
    ldh [hFFC6], a
    ret

; 2 call sites from 2 routines (e.g. PauseMenu_State3_Case01_Case10, RunWD780StateWhenNotFading_1B_Case01_Case21)
; reads: hFFC6, wC833
; writes: rRAMB, rRAMG
; points at: wC783, wC787, wC833
Func_012_69B0::
    ldh a, [hFFC6]
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
    and a, $7F
    cp a, $06
    jr c, Jump_012_69C9
    bit 7, a
    ret nz

Jump_012_69C9::
    push hl
    farcall ClearWC88EForMatchingKeyEntry
    pop hl
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    cp a, $FE
    jr z, Jump_012_6A03
    bit 7, a
    jr z, Jump_012_6A03
    and a, $1F
    push af
    ld a, $02
    ld [rRAMB], a
    pop af
    ld bc, $0195
    call Multiply8By16
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $A0
    ld h, a
    ld a, $0A
    ld [rRAMG], a
    ld a, $FF
    ld [hl], a
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a

Jump_012_6A03::
    ldh a, [hFFC6]
    cp a, $1F
    jr nz, Jump_012_6A0E
    ld hl, wC783
    jr Jump_012_6A37

Jump_012_6A0E::
    push af
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld e, l
    ld d, h
    inc de
    inc de
    inc de
    inc de
    pop af
    ld c, a
    ld a, $1F
    sub a, c
    ld b, a

Jump_012_6A28::
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_012_6A28

Jump_012_6A37::
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    ldh a, [hFFC6]
    cp a, $1F
    jr z, Jump_012_6A5D
    ld c, a
    add a, a
    ld hl, wC787
    add_a_to_hl
    ld a, $1F
    sub a, c
    ld b, a

Jump_012_6A51::
    ld e, l
    ld d, h
    inc de
    inc de
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    dec b
    jr nz, Jump_012_6A51

Jump_012_6A5D::
    ld a, [wC833]
    ld c, a
    ldh a, [hFFC6]
    cp a, c
    ret nc
    ld hl, wC833
    dec [hl]
    ret

; on map $7F or $92 at screen (0, 0), or with wCC44 = $82, runs field command $12 and places objects at wCBD3/4 and wCBCF (E-0127)
; 2 call sites from 2 routines (e.g. Func_002_4628, RunWC468ActionIfBit7_Case02)
; reads: wCC44, hMapId, hMapScreenX, hMapScreenY
; writes: hFFC6, wCBD3, wCBD4, wCBCF
PlaceSpecialMapObjectsOnEntry::
Func_012_6A6A:: ; address name
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_012_6ABC
    ldh a, [hMapId]
    cp a, $7F
    jr nz, Jump_012_6A98
    ldh a, [hMapScreenX]
    or a, a
    jr nz, Jump_012_6A98
    ldh a, [hMapScreenY]
    or a, a
    jr nz, Jump_012_6A98
    ld a, $12
    ldh [hFFC6], a
    call RunFieldCommandHFFC6
    ld a, $40
    ld [wCBD3], a
    ld a, $10
    ld [wCBD4], a
    ld a, $40
    ld [wCBCF], a
    ret

Jump_012_6A98::
    ldh a, [hMapId]
    cp a, $92
    ret nz
    ldh a, [hMapScreenX]
    or a, a
    ret nz
    ldh a, [hMapScreenY]
    or a, a
    ret nz
    ld a, $12
    ldh [hFFC6], a
    call RunFieldCommandHFFC6
    ld a, $40
    ld [wCBD3], a
    ld a, $40
    ld [wCBD4], a
    ld a, $40
    ld [wCBCF], a
    ret

Jump_012_6ABC::
    ld a, [wCC44]
    cp a, $82
    ret nz
    ld a, $12
    ldh [hFFC6], a
    call RunFieldCommandHFFC6
    ld a, $40
    ld [wCBD3], a
    ld a, $30
    ld [wCBD4], a
    ld a, $40
    ld [wCBCF], a
    ret

; decompresses Data_07E_5595 to vTiles0 + $300 (or + $700 when hFFC6 is set), wC949 = $30, and on CGB copies an 8-byte palette from bank $7E (E-0125)
; 2 call sites from 2 routines (e.g. RunWC92DStep_7363_Case00, ScriptCommand16_Run_Case0F)
; reads: hFFC6, wIsCGB
; writes: wC949, wC527
; points at: wOBJPaletteBuffer
LoadSpriteGraphics7E5595ToTiles0::
Func_012_6AD9:: ; address name
    ldh a, [hFFC6]
    or a, a
    jr nz, Jump_012_6AE3
    ld hl, vTiles0 + $300
    jr Jump_012_6AE6

Jump_012_6AE3::
    ld hl, vTiles0 + $700

Jump_012_6AE6::
    ld de, Data_07E_5595
    ld b, $7E
    call DecompressToVRAM
    ld a, $30
    ld [wC949], a
    ld a, [wIsCGB]
    or a, a
    ret z
    ldh a, [hFFC6]
    or a, a
    jr nz, Jump_012_6B01
    ld a, $18
    jr Jump_012_6B03

Jump_012_6B01::
    ld a, $38

Jump_012_6B03::
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld a, $D8
    ld de, Data_07E_4BBD
    add a, e
    ld e, a
    jr nc, Jump_012_6B15
    inc d

Jump_012_6B15::
    ld b, $7E
    ld c, $08
    call CopyFromBank
    ld a, $7F
    ld [wC527], a
    ret

; wC949 -= 2, and when the result is $C0 or more it becomes $30 (E-0117)
; 11 call sites from 11 routines (e.g. RunWC92DStep_7363_Case0F, RunWC92DStep_7363_Case0D, RunWC92DStep_7363_Case0C, RunWC92DStep_7363_Case0B, ...)
; reads: wC949
; writes: wC949
CycleWC949Down::
Func_012_6B22:: ; address name
    ld a, [wC949]
    dec a
    dec a
    ld [wC949], a
    cp a, $C0
    ret c
    ld a, $30
    ld [wC949], a
    ret

; draws metasprite set $1B with a frame from Data_012_6B7A chosen by the frame counter / 30, at ($48, wC949 + $10) (E-0125)
; 11 call sites from 11 routines (e.g. RunWC92DStep_7363_Case0F, RunWC92DStep_7363_Case0D, RunWC92DStep_7363_Case0C, RunWC92DStep_7363_Case0B, ...)
; reads: hFFC6, wFrameCounterLo, wFrameCounterHi, wC949
; writes: hSpriteTileOffset, hSpriteAttrXor, hSpriteSubIndex, hSpriteSetIndex, hSpriteOriginX, hSpriteOriginY
DrawAnimatedMetaSprite1B::
Func_012_6B33:: ; address name
    ldh a, [hFFC6]
    or a, a
    jr nz, Jump_012_6B42
    ld a, $30
    ldh [hSpriteTileOffset], a
    ld a, $03
    ldh [hSpriteAttrXor], a
    jr Jump_012_6B4A

Jump_012_6B42::
    ld a, $70
    ldh [hSpriteTileOffset], a
    ld a, $07
    ldh [hSpriteAttrXor], a

Jump_012_6B4A::
    ld a, [wFrameCounterLo]
    ld l, a
    ld a, [wFrameCounterHi]
    ld h, a
    ld a, $1E
    call DivideHLByA
    ld hl, Data_012_6B7A
    add_a_to_hl
    ld a, [hl]
    ldh [hSpriteSubIndex], a
    ld a, $1B
    ldh [hSpriteSetIndex], a
    ld a, $40
    add a, $08
    ldh [hSpriteOriginX], a
    ld a, [wC949]
    add a, $10
    ldh [hSpriteOriginY], a
    farcall DrawMetaSprite
    ret

Data_012_6B7A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02

; runs the field command for hFFC6 (jump table of 22; called from 49 routines) (E-0124)
; 51 call sites from 49 routines (e.g. PlaceSpecialMapObjectsOnEntry, Func_002_4628, RunWC8C7Phase_Case01_Sub01, StartScript4F7CAndSetFlag06, ...)
; reads: hFFC6
RunFieldCommandHFFC6::
Func_012_6B98:: ; address name
    ldh a, [hFFC6]
    rst $00
    dw RunFieldCommandHFFC6_Case00
    dw RunFieldCommandHFFC6_Case01
    dw RunFieldCommandHFFC6_Case02
    dw RunFieldCommandHFFC6_Case03
    dw RunFieldCommandHFFC6_Case04
    dw RunFieldCommandHFFC6_Case05
    dw RunFieldCommandHFFC6_Case06
    dw RunFieldCommandHFFC6_Case07
    dw RunFieldCommandHFFC6_Case08
    dw RunFieldCommandHFFC6_Case09
    dw RunFieldCommandHFFC6_Case0A
    dw RunFieldCommandHFFC6_Case0B
    dw RunFieldCommandHFFC6_Case0C
    dw RunFieldCommandHFFC6_Case0D
    dw RunFieldCommandHFFC6_Case0D
    dw RunFieldCommandHFFC6_Case0F
    dw RunFieldCommandHFFC6_Case10
    dw RunFieldCommandHFFC6_Case11
    dw RunFieldCommandHFFC6_Case12
    dw RunFieldCommandHFFC6_Case13
    dw RunFieldCommandHFFC6_Case14
    dw RunFieldCommandHFFC6_Case14

; entry 20 of the `rst $00` table in RunFieldCommandHFFC6
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF, wCBD5, wCBD6
; points at: wCBD0
RunFieldCommandHFFC6_Case14::
Jump_012_6BC7:: ; address name
    call RunFieldCommandHFFC6_Shared01
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $40
    inc hl
    ld [hl], $40
    ld a, $80
    ld [wCBCF], a
    ld hl, $0000
    ld a, l
    ld [wCBD5], a
    ld a, h
    ld [wCBD6], a
    ret

; entry 19 of the `rst $00` table in RunFieldCommandHFFC6
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF
; points at: wCBD0
RunFieldCommandHFFC6_Case13::
Jump_012_6BED:: ; address name
    call RunFieldCommandHFFC6_Shared02
    push af
    ld hl, wCBD0
    ld [hl], $30
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $03
    xor a, a
    ld [wCBCF], a
    ret

; entry 18 of the `rst $00` table in RunFieldCommandHFFC6
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF, wCBD5, wCBD6
; points at: wCBD0
RunFieldCommandHFFC6_Case12::
Jump_012_6C01:: ; address name
    call RunFieldCommandHFFC6_Shared01
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    xor a, a
    ld [wCBCF], a
    ld hl, $0000
    ld a, l
    ld [wCBD5], a
    ld a, h
    ld [wCBD6], a
    ret

; entry 17 of the `rst $00` table in RunFieldCommandHFFC6
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF, wCBD5, wCBD6
; points at: wCBD0
RunFieldCommandHFFC6_Case11::
Jump_012_6C20:: ; address name
    call RunFieldCommandHFFC6_Shared01
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    xor a, a
    ld [wCBCF], a
    ld hl, $0000
    ld a, l
    ld [wCBD5], a
    ld a, h
    ld [wCBD6], a
    ret

; entry 16 of the `rst $00` table in RunFieldCommandHFFC6
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF
; points at: wCBD0
RunFieldCommandHFFC6_Case10::
Jump_012_6C3F:: ; address name
    call RunFieldCommandHFFC6_Shared01
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $30
    inc hl
    ld [hl], $40
    xor a, a
    ld [wCBCF], a
    ret

; entry 15 of the `rst $00` table in RunFieldCommandHFFC6
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF
; points at: wCBD0
RunFieldCommandHFFC6_Case0F::
Jump_012_6C59:: ; address name
    call RunFieldCommandHFFC6_Shared01
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $40
    inc hl
    ld [hl], $E0
    xor a, a
    ld [wCBCF], a
    ret

; entry 13 of the `rst $00` table in RunFieldCommandHFFC6
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF, wCBD5, wCBD6
; points at: wCBD0
RunFieldCommandHFFC6_Case0D::
Jump_012_6C73:: ; address name
    call RunFieldCommandHFFC6_Shared02
    push af
    ld hl, wCBD0
    ld [hl], $30
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $03
    inc hl
    ld a, $50
    ld [hl], a
    inc hl
    ld a, $3C
    ld [hl], a
    ld a, $80
    ld [wCBCF], a
    ld hl, $0000
    ld a, l
    ld [wCBD5], a
    ld a, h
    ld [wCBD6], a
    ret

; entry 12 of the `rst $00` table in RunFieldCommandHFFC6
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF, wCBD5, wCBD6
; points at: wCBD0
RunFieldCommandHFFC6_Case0C::
Jump_012_6C9B:: ; address name
    call RunFieldCommandHFFC6_Shared01
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld a, $78
    ld [hl], a
    inc hl
    ld a, $50
    ld [hl], a
    xor a, a
    ld [wCBCF], a
    ld hl, $0000
    ld a, l
    ld [wCBD5], a
    ld a, h
    ld [wCBD6], a
    ret

; entry 11 of the `rst $00` table in RunFieldCommandHFFC6
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, hPlayerY
; writes: wCBCF, wCBD5, wCBD6
; points at: wCBD0
RunFieldCommandHFFC6_Case0B::
Jump_012_6CC2:: ; address name
    call RunFieldCommandHFFC6_Shared01
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ldh a, [hPlayerX]
    ld [hl], a
    inc hl
    ldh a, [hPlayerY]
    ld [hl], a
    xor a, a
    ld [wCBCF], a
    ld hl, $0000
    ld a, l
    ld [wCBD5], a
    ld a, h
    ld [wCBD6], a
    ret

; entry 10 of the `rst $00` table in RunFieldCommandHFFC6
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF
; points at: wCBD0
RunFieldCommandHFFC6_Case0A::
Jump_012_6CE9:: ; address name
    call RunFieldCommandHFFC6_Shared01
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $40
    inc hl
    ld [hl], $E0
    xor a, a
    ld [wCBCF], a
    ret

; entry 9 of the `rst $00` table in RunFieldCommandHFFC6
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF
; points at: wCBD0
RunFieldCommandHFFC6_Case09::
Jump_012_6D03:: ; address name
    call RunFieldCommandHFFC6_Shared01
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $40
    inc hl
    ld [hl], $E0
    ld a, $80
    ld [wCBCF], a
    ret

; entry 8 of the `rst $00` table in RunFieldCommandHFFC6
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF
; points at: wCBD0
RunFieldCommandHFFC6_Case08::
Jump_012_6D1E:: ; address name
    call RunFieldCommandHFFC6_Shared01
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $50
    inc hl
    ld [hl], $30
    xor a, a
    ld [wCBCF], a
    ret

; entry 7 of the `rst $00` table in RunFieldCommandHFFC6
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF
; points at: wCBD0
RunFieldCommandHFFC6_Case07::
Jump_012_6D38:: ; address name
    call RunFieldCommandHFFC6_Shared01
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $30
    inc hl
    ld [hl], $E0
    ld a, $80
    ld [wCBCF], a
    ret

; entry 6 of the `rst $00` table in RunFieldCommandHFFC6
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF, wCBD5, wCBD6
; points at: wCBD0
RunFieldCommandHFFC6_Case06::
Jump_012_6D53:: ; address name
    call RunFieldCommandHFFC6_Shared01
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $40
    inc hl
    ld [hl], $70
    ld a, $80
    ld [wCBCF], a
    ld hl, $0000
    ld a, l
    ld [wCBD5], a
    ld a, h
    ld [wCBD6], a
    ret

; entry 5 of the `rst $00` table in RunFieldCommandHFFC6
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF
; points at: wCBD0
RunFieldCommandHFFC6_Case05::
Jump_012_6D79:: ; address name
    call RunFieldCommandHFFC6_Shared01
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $40
    inc hl
    ld [hl], $00
    ld a, $80
    ld [wCBCF], a
    ret

; entry 4 of the `rst $00` table in RunFieldCommandHFFC6
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF
; points at: wCBD0
RunFieldCommandHFFC6_Case04::
Jump_012_6D94:: ; address name
    call RunFieldCommandHFFC6_Shared01
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $50
    inc hl
    ld [hl], $30
    xor a, a
    ld [wCBCF], a
    ret

; entry 3 of the `rst $00` table in RunFieldCommandHFFC6
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF
; points at: wCBD0
RunFieldCommandHFFC6_Case03::
Jump_012_6DAE:: ; address name
    call RunFieldCommandHFFC6_Shared01
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    xor a, a
    ld [wCBCF], a
    ret

; entry 2 of the `rst $00` table in RunFieldCommandHFFC6
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF
; points at: wCBD0
RunFieldCommandHFFC6_Case02::
Jump_012_6DC2:: ; address name
    call RunFieldCommandHFFC6_Shared01
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $40
    inc hl
    ld [hl], $30
    xor a, a
    ld [wCBCF], a
    ret

; entry 1 of the `rst $00` table in RunFieldCommandHFFC6
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF
; points at: wCBD0
RunFieldCommandHFFC6_Case01::
Jump_012_6DDC:: ; address name
    call RunFieldCommandHFFC6_Shared01
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    xor a, a
    ld [wCBCF], a
    ret

; entry 0 of the `rst $00` table in RunFieldCommandHFFC6
; no direct call (reached through a table, a jump or a vector)
; writes: wCBCF
; points at: wCBD0
RunFieldCommandHFFC6_Case00::
Jump_012_6DF0:: ; address name
    call RunFieldCommandHFFC6_Shared01
    push af
    ld hl, wCBD0
    ld [hl], $40
    inc hl
    pop af
    ld [hl], a
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $60
    inc hl
    ld [hl], $40
    ld a, $80
    ld [wCBCF], a
    ret

; only called from routines of RunFieldCommandHFFC6 (E-0098)
; 18 call sites from 18 routines (e.g. RunFieldCommandHFFC6_Case14, RunFieldCommandHFFC6_Case12, RunFieldCommandHFFC6_Case11, RunFieldCommandHFFC6_Case10, ...)
; reads: hFFC6, wIsCGB
; writes: wC527
; points at: wOBJPaletteBuffer
RunFieldCommandHFFC6_Shared01::
Func_012_6E0B:: ; address name
    ldh a, [hFFC6]
    and a, $7F
    add a, a
    add a, a
    ld hl, Data_012_704C
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    push hl
    ld b, $7E
    ld hl, vTiles0 + $400
    call DecompressToVRAM
    pop hl
    push hl
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_012_6E5E
    ld a, [hl]
    and a, $7F
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $BD
    ld e, a
    ld a, d
    adc a, $4B
    ld d, a
    ld b, $7E
    ld a, $20
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld c, $08
    call CopyFromBank
    ld a, $7F
    ld [wC527], a

Jump_012_6E5E::
    pop hl
    ld a, [hl]
    ret

; only called from routines of RunFieldCommandHFFC6 (E-0098)
; 2 call sites from 2 routines (e.g. RunFieldCommandHFFC6_Case13, RunFieldCommandHFFC6_Case0D)
; reads: hFFC6, wIsCGB
; writes: wC527
; points at: wOBJPaletteBuffer
RunFieldCommandHFFC6_Shared02::
Func_012_6E61:: ; address name
    ldh a, [hFFC6]
    and a, $7F
    add a, a
    add a, a
    ld hl, Data_012_704C
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    push hl
    ld b, $7E
    ld hl, vTiles0 + $300
    call DecompressToVRAM
    pop hl
    push hl
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_012_6EB4
    ld a, [hl]
    and a, $7F
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $BD
    ld e, a
    ld a, d
    adc a, $4B
    ld d, a
    ld b, $7E
    ld a, $18
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld c, $08
    call CopyFromBank
    ld a, $7F
    ld [wC527], a

Jump_012_6EB4::
    pop hl
    ld a, [hl]
    ret

; only called from RunFunc722AAnd6EB7 (E-0047)
; 1 call site from 1 routine (e.g. RunFunc722AAnd6EB7)
; reads: wC468, hScrollX, hScrollXHi, hScrollY, hScrollYHi
; writes: hSpriteTileOffset, hSpriteSetIndex, hSpriteAttrXor, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteSubIndex
; points at: wCBCF
RunFunc722AAnd6EB7_Sub01::
Func_012_6EB7:: ; address name
    ld a, [wC468]
    bit 7, a
    ret nz
    ld de, wCBCF
    ld a, [de]
    bit 6, a
    ret z
    jr Jump_012_6ED3

; unless the map is loading or wCBCF bit 7 is clear: reads the sprite entries starting at wCBCF (tile offset, set index with bit 7 selecting a sub index, attribute, position bytes), sets the hSprite inputs and 16-bit positions from them plus the scroll, and draws each with DrawMetaSprite
; 9 call sites from 9 routines (e.g. FieldModeStateDispatch_Case00, FieldModeStateDispatch_Case01, FieldModeStateDispatch_Case02, FieldModeStateDispatch_Case03, ...)
; reads: wC468, hScrollX, hScrollXHi, hScrollY, hScrollYHi
; writes: hSpriteTileOffset, hSpriteSetIndex, hSpriteAttrXor, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteSubIndex
; points at: wCBCF
DrawFieldSprites::
Func_012_6EC6:: ; address name
    ld a, [wC468]
    bit 7, a
    ret nz
    ld de, wCBCF
    ld a, [de]
    bit 7, a
    ret z

Jump_012_6ED3::
    inc de
    ld a, [de]
    ldh [hSpriteTileOffset], a
    inc de
    ld a, [de]
    and a, $7F
    ldh [hSpriteSetIndex], a
    ld a, [de]
    bit 7, a
    jr z, Jump_012_6EE7
    call DrawFieldSprites_Sub01
    jr Jump_012_6EEA

Jump_012_6EE7::
    xor a, a
    ldh [hSpriteSubIndex], a

Jump_012_6EEA::
    inc de
    ld a, [de]
    ldh [hSpriteAttrXor], a
    ld l, e
    ld h, d
    inc hl
    ld a, [hl]
    add a, $08
    ld d, a
    ldh a, [hScrollX]
    add a, d
    ldh [hSpriteOriginX], a
    ldh a, [hScrollXHi]
    adc a, $00
    ldh [hSpriteOriginXHi], a
    inc hl
    ld a, [hl]
    add a, $10
    ld d, a
    ldh a, [hScrollY]
    add a, d
    ldh [hSpriteOriginY], a
    ldh a, [hScrollYHi]
    adc a, $00
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

; only called from DrawFieldSprites (E-0047)
; 1 call site from 1 routine (e.g. DrawFieldSprites)
; reads: wCBD6
; writes: hSpriteSubIndex
; points at: wCBD5
DrawFieldSprites_Sub01::
Func_012_6F17:: ; address name
    push af
    ld hl, wCBD5
    inc [hl]
    pop af
    and a, $7F
    cp a, $13
    jr nz, Jump_012_6F2F
    ld hl, Data_012_6FF2
    call DrawFieldSprites_Sub01_Sub01
    ld a, [wCBD6]
    ldh [hSpriteSubIndex], a
    ret

Jump_012_6F2F::
    cp a, $1A
    jr nz, Jump_012_6F3F
    ld hl, Data_012_6FF7
    call DrawFieldSprites_Sub01_Sub01
    ld a, [wCBD6]
    ldh [hSpriteSubIndex], a
    ret

Jump_012_6F3F::
    cp a, $17
    jr nz, Jump_012_6F4F
    ld hl, Data_012_6FFA
    call DrawFieldSprites_Sub01_Sub01
    ld a, [wCBD6]
    ldh [hSpriteSubIndex], a
    ret

Jump_012_6F4F::
    cp a, $1F
    jr nz, Jump_012_6F68
    ld hl, Data_012_6FFE
    call DrawFieldSprites_Sub01_Sub01
    ld a, [wCBD6]
    ld hl, Data_012_700E
    add_a_to_hl
    ld a, [hl]
    ldh [hSpriteSubIndex], a
    ret

Jump_012_6F68::
    cp a, $1E
    jr nz, Jump_012_6F78
    ld hl, Data_012_701E
    call DrawFieldSprites_Sub01_Sub01
    ld a, [wCBD6]
    ldh [hSpriteSubIndex], a
    ret

Jump_012_6F78::
    cp a, $18
    jr nz, Jump_012_6F88
    ld hl, Data_012_7023
    call DrawFieldSprites_Sub01_Sub01
    ld a, [wCBD6]
    ldh [hSpriteSubIndex], a
    ret

Jump_012_6F88::
    cp a, $20
    jr nz, Jump_012_6F95
    ld hl, Data_012_7026
    call DrawFieldSprites_Sub01_Sub02
    ldh [hSpriteSubIndex], a
    ret

Jump_012_6F95::
    ret

; only called from DrawFieldSprites_Sub01 (E-0047)
; 6 call sites from 1 routine (e.g. DrawFieldSprites_Sub01)
; reads: wCBD6, wCBD5
; writes: wCBD5, wCBD6
DrawFieldSprites_Sub01_Sub01::
Func_012_6F96:: ; address name
    ld a, [wCBD6]
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ld a, [wCBD5]
    cp a, c
    jr nz, Jump_012_6FBD
    xor a, a
    ld [wCBD5], a
    inc hl
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_012_6FB6
    xor a, a
    ld [wCBD6], a
    jr Jump_012_6FBD

Jump_012_6FB6::
    ld a, [wCBD6]
    inc a
    ld [wCBD6], a

Jump_012_6FBD::
    ret

; only called from DrawFieldSprites_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DrawFieldSprites_Sub01)
; reads: wCBD6, wCBD5
; writes: wCBD5, wCBD6
; points at: wCBD6
DrawFieldSprites_Sub01_Sub02::
Func_012_6FBE:: ; address name
    push hl
    ld a, [wCBD6]
    add a, a
    add_a_to_hl
    inc hl
    ld a, [hl]
    ld c, a
    ld a, [wCBD5]
    cp a, c
    jr nz, Jump_012_6FD9
    xor a, a
    ld [wCBD5], a
    ld hl, wCBD6
    inc [hl]

Jump_012_6FD9::
    ld a, [wCBD6]
    add a, a
    pop hl
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    ret nz
    ld a, [wCBD6]
    dec a
    ld [wCBD6], a
    dec hl
    dec hl
    ld a, [hl]
    ret

Data_012_6FF2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $08, $08, $08, $08, $FF

Data_012_6FF7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $08, $08, $FF

Data_012_6FFA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $07, $07, $09, $FF

Data_012_6FFE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0E, $0E, $0E, $0E, $0E, $0E, $0E, $36, $0E, $0E, $0E, $40, $FF, $FF, $FF, $FF

Data_012_700E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $02, $01, $02, $01, $02, $00, $03, $04, $05, $06, $FF, $FF, $FF, $FF

Data_012_701E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $04, $07, $07, $04, $FF

Data_012_7023:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $20, $FF

Data_012_7026:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $1E, $00, $05, $01, $04, $02, $05, $01, $04, $00, $05, $01, $04, $02, $05
    db $03, $04, $04, $05, $03, $04, $02, $05, $05, $04, $06, $05, $05, $04, $02, $05
    db $01, $04, $00, $05, $FF, $FF

Data_012_704C:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $04B04C, $58

; 2 call sites from 2 routines (e.g. Func_002_4628, RunWC468ActionIfBit7_Case02)
; reads: wCC44, hMapId, hMapScreenX, hMapScreenY, wCC47, wC8FE, wIsCGB
; writes: wC8FE, wC900, wC8FF, wC527
; points at: wCC48, wOBJPaletteBuffer
Func_012_70A4::
    ld a, $FF
    ld [wC8FE], a
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_012_70CF
    ldh a, [hMapId]
    cp a, $20
    jr z, Jump_012_70D5
    cp a, $30
    jr z, Jump_012_70D5
    cp a, $48
    jr z, Jump_012_70D5
    cp a, $70
    jr z, Jump_012_70D5
    cp a, $A8
    jr z, Jump_012_70D5
    cp a, $B0
    jr z, Jump_012_70D5
    cp a, $B8
    jr z, Jump_012_70D5
    ret

Jump_012_70CF::
    ld a, [wCC44]
    and a, $07
    ret nz

Jump_012_70D5::
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or a, c
    ld c, a
    ld a, [wCC47]
    or a, a
    ret z
    ld b, a
    ld hl, wCC48

Jump_012_70E7::
    push hl
    ld a, [hl]
    bit 7, a
    jr nz, Jump_012_70F5
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    cp a, c
    jr z, Jump_012_7101

Jump_012_70F5::
    pop hl
    ld a, $08
    add_a_to_hl
    dec b
    jr nz, Jump_012_70E7
    ret

Jump_012_7101::
    ld a, [wCC47]
    sub a, b
    ld [wC900], a
    jr Jump_012_715E

; 2 call sites from 2 routines (e.g. Func_002_4628, RunWC468ActionIfBit7_Case02)
; reads: wCC44, hMapId, wCCE9, hMapScreenX, hMapScreenY, wC8FE, wIsCGB
; writes: wCCE9, wC900, wC8FF, wC8FE, wC527
; points at: wCCEB, wOBJPaletteBuffer
Func_012_710A::
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_012_711C
    ldh a, [hMapId]
    cp a, $30
    jr nc, Jump_012_712A
    xor a, a
    ld [wCCE9], a
    ret

Jump_012_711C::
    cp a, $85
    ret nz
    ld a, [wCCE9]
    or a, a
    ret z
    ld b, a
    ld hl, wCCEB
    jr Jump_012_7134

Jump_012_712A::
    ld a, [wCCE9]
    or a, a
    ret z
    ld b, $03
    ld hl, wCCEB

Jump_012_7134::
    ldh a, [hMapScreenX]
    swap a
    ld c, a
    ldh a, [hMapScreenY]
    or a, c
    ld c, a

Jump_012_713D::
    push hl
    ld a, [hl]
    bit 7, a
    jr nz, Jump_012_7149
    inc hl
    inc hl
    ld a, [hl]
    cp a, c
    jr z, Jump_012_7155

Jump_012_7149::
    pop hl
    ld a, $04
    add_a_to_hl
    dec b
    jr nz, Jump_012_713D
    ret

Jump_012_7155::
    ld a, [wCCE9]
    sub a, b
    ld [wC900], a
    jr Jump_012_715E

Jump_012_715E::
    inc hl
    ld a, [hl]
    ld [wC8FF], a
    pop hl
    ld a, [hl]
    and a, $03
    jr nz, Jump_012_7174
    inc hl
    ld a, [hl]
    ld hl, Data_012_71BB
    add_a_to_hl
    ld a, [hl]

Jump_012_7174::
    or a, a
    ret z
    ld [wC8FE], a

; only called from ScriptCommand84_Run_Case04_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommand84_Run_Case04_Sub01)
; reads: wC8FE, wIsCGB
; writes: wC527
; points at: wOBJPaletteBuffer
ScriptCommand84_Run_Case04_Sub01_Sub01::
Func_012_7179:: ; address name
    ld a, [wC8FE]
    ld c, a
    add a, a
    add a, c
    add a, a
    ld hl, Data_012_71E8
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld a, [hl+]
    ld b, a
    push hl
    ld hl, vTiles0 + $400
    call DecompressToVRAM
    pop hl
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, [hl]
    ld de, $4BBD
    add a, e
    ld e, a
    jr nc, Jump_012_71A4
    inc d

Jump_012_71A4::
    ld b, $7E
    ld a, $20
    ld hl, wOBJPaletteBuffer
    add_a_to_hl
    ld c, $08
    call CopyFromBank
    ld a, $7F
    ld [wC527], a
    ret

Data_012_71BB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $04, $05, $05, $05, $05, $04, $04, $04, $04, $06, $00, $04, $07, $07, $07
    db $07, $07, $07, $00, $00, $00, $00, $00, $00, $08, $08, $08, $08, $08, $00, $00
    db $05, $00, $09, $09, $09, $09, $09, $09, $09, $0A, $06, $00, $01

Data_012_71E8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $04B1E8, $42

; 2 call sites from 2 routines (e.g. RunFunc722AAnd6EB7, FieldModeStateDispatch_Case07)
; reads: wC468, wC8FE, wC956, wCCE9, wCC44, hScrollX, hScrollXHi, wC8FF, ...
; writes: hSpriteSetIndex, hSpriteSubIndex, hSpriteTileOffset, hSpriteAttrXor, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, hSpriteOriginYHi
Func_012_722A::
    ld a, [wC468]
    bit 7, a
    ret nz
    ld a, [wC8FE]
    cp a, $FF
    ret z
    ld hl, Data_012_7308
    add_a_to_hl
    ld a, [hl+]
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    ld a, $40
    ldh [hSpriteTileOffset], a
    ld a, $04
    ldh [hSpriteAttrXor], a
    ld a, [wC956]
    bit 7, a
    jp nz, Jump_012_72D5
    ld a, [wCCE9]
    or a, a
    jr nz, Jump_012_7261
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_012_729A

Jump_012_7261::
    ldh a, [hScrollX]
    ld e, a
    ldh a, [hScrollXHi]
    ld d, a
    ld a, [wC8FF]
    and a, $F0
    add a, $08
    add a, e
    ld e, a
    jr nc, Jump_012_7273
    inc d

Jump_012_7273::
    ld a, e
    ldh [hSpriteOriginX], a
    ld a, d
    ldh [hSpriteOriginXHi], a
    ldh a, [hScrollY]
    ld e, a
    ldh a, [hScrollYHi]
    ld d, a
    ld a, [wC8FF]
    and a, $0F
    swap a
    add a, $10
    add a, e
    ld e, a
    jr nc, Jump_012_728D
    inc d

Jump_012_728D::
    ld a, e
    ldh [hSpriteOriginY], a
    ld a, d
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

Jump_012_729A::
    ld a, [wC8FF]
    add a, a
    ld hl, Data_012_7313
    add_a_to_hl
    ldh a, [hScrollX]
    ld e, a
    ldh a, [hScrollXHi]
    ld d, a
    ld a, [hl+]
    add a, $08
    add a, e
    ld e, a
    jr nc, Jump_012_72B4
    inc d

Jump_012_72B4::
    ld a, e
    ldh [hSpriteOriginX], a
    ld a, d
    ldh [hSpriteOriginXHi], a
    ldh a, [hScrollY]
    ld e, a
    ldh a, [hScrollYHi]
    ld d, a
    ld a, [hl+]
    add a, $10
    add a, e
    ld e, a
    jr nc, Jump_012_72C8
    inc d

Jump_012_72C8::
    ld a, e
    ldh [hSpriteOriginY], a
    ld a, d
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

Jump_012_72D5::
    ldh a, [hScrollX]
    ld e, a
    ldh a, [hScrollXHi]
    ld d, a
    ld a, [wC8FF]
    add a, $08
    add a, e
    ld e, a
    jr nc, Jump_012_72E5
    inc d

Jump_012_72E5::
    ld a, e
    ldh [hSpriteOriginX], a
    ld a, d
    ldh [hSpriteOriginXHi], a
    ldh a, [hScrollY]
    ld e, a
    ldh a, [hScrollYHi]
    ld d, a
    ld a, [wC900]
    add a, $10
    add a, e
    ld e, a
    jr nc, Jump_012_72FB
    inc d

Jump_012_72FB::
    ld a, e
    ldh [hSpriteOriginY], a
    ld a, d
    ldh [hSpriteOriginYHi], a
    farcall DrawMetaSprite
    ret

Data_012_7308:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $09, $01, $01, $02, $03, $04, $05, $06, $07, $08

Data_012_7313:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $10, $20, $10, $70, $20, $10, $20, $40, $20, $60, $30, $30, $40, $50, $40, $70
    db $50, $10, $50, $30, $60, $50, $70, $20, $70, $40, $70, $70, $80, $10, $80, $60

; only called from routines of FieldModeStateDispatch (E-0098)
; 2 call sites from 2 routines (e.g. FieldModeStateDispatch_Case00, FieldModeStateDispatch_Case05)
; reads: wC8CB, wC468, hFF8C, wJoypadPressed, wC8FE, hPlayerX, hPlayerY, hPlayerFacing, ...
; writes: wC916, wC917, wJoypadHeld, wJoypadPressed
FieldModeStateDispatch_Shared02::
Func_012_7333:: ; address name
    ld a, [wC8CB]
    and a, $03
    ret nz
    ld a, [wC468]
    bit 7, a
    ret nz
    ldh a, [hFF8C]
    bit 0, a
    ret nz
    ld a, [wJoypadPressed]
    bit 0, a
    ret z
    ld a, [wC8FE]
    cp a, $02
    jr z, Jump_012_7356
    cp a, $03
    jr z, Jump_012_7356
    ret

Jump_012_7356::
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    ldh a, [hPlayerFacing]
    or a, a
    jr z, Jump_012_736A
    dec a
    jr z, Jump_012_7370
    dec a
    jr z, Jump_012_7376
    dec b
    jr Jump_012_7377

Jump_012_736A::
    ld a, c
    add a, $11
    ld c, a
    jr Jump_012_7377

Jump_012_7370::
    ld a, b
    add a, $11
    ld b, a
    jr Jump_012_7377

Jump_012_7376::
    dec c

Jump_012_7377::
    call IsPlayerOnTriggerCell
    or a, a
    jr z, Jump_012_73A0
    ld a, $0F
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wC8CD]
    bit 7, a
    ret z
    farcall RedrawScreenBufferIfWC8CDBit7
    ret

Jump_012_73A0::
    ret

; when the player stands on a trigger (Func_012_7536) and nothing blocks it, sets wC916 = $0F and far-calls DispatchTalkEvent, clearing the joypad state (E-0125)
; 2 call sites from 2 routines (e.g. FieldModeStateDispatch_Case07, UpdatePlayerMovement_Sub01)
; reads: wC951, wC8BF, wC8FE, hPlayerX, hPlayerY, wScriptRunning, wC917, wC916
; writes: wD091, wC916, wC917, wJoypadHeld, wJoypadPressed
CheckStepTriggerAndDispatchTalk::
Func_012_73A1:: ; address name
    ld a, [wC951]
    dec a
    ret z
    ld a, [wC8BF]
    cp a, $C0
    ret z
    ld a, [wC8FE]
    cp a, $FF
    ret z
    cp a, $02
    ret z
    cp a, $03
    ret z
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    call IsPlayerOnTriggerCell
    or a, a
    jr z, Jump_012_73F2
    ld a, [wScriptRunning]
    or a, a
    jr z, Jump_012_73DC
    ld a, [wC917]
    or a, a
    jr nz, Jump_012_73DC
    ld a, [wC916]
    cp a, $1D
    jr nz, Jump_012_73DC
    ld a, $01
    ld [wD091], a

Jump_012_73DC::
    ld a, $0F
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a

Jump_012_73F2::
    ret

; only called from FieldModeStateDispatch_Case05 (E-0047)
; 1 call site from 1 routine (e.g. FieldModeStateDispatch_Case05)
; reads: wC8CB, wC468, hFF8C, wJoypadPressed, wCC44, hPlayerX, hPlayerY, hPlayerFacing, ...
; writes: wScriptParam0, wScriptParam1, wC916, wC917, wJoypadHeld, wJoypadPressed
; points at: wCDB0, wCE8B
FieldModeStateDispatch_Case05_Sub02::
Func_012_73F3:: ; address name
    ld a, [wC8CB]
    and a, $03
    ret nz
    ld a, [wC468]
    bit 7, a
    ret nz
    ldh a, [hFF8C]
    bit 0, a
    ret nz
    ld a, [wJoypadPressed]
    bit 0, a
    ret z
    ld a, [wCC44]
    bit 7, a
    ret z
    cp a, $85
    jr z, Jump_012_7417
    cp a, $86
    ret nz

Jump_012_7417::
    ldh a, [hPlayerX]
    ld b, a
    ldh a, [hPlayerY]
    ld c, a
    ldh a, [hPlayerFacing]
    or a, a
    jr z, Jump_012_742E
    dec a
    jr z, Jump_012_7434
    dec a
    jr z, Jump_012_743A
    ld a, b
    sub a, $10
    ld b, a
    jr Jump_012_7440

Jump_012_742E::
    ld a, c
    add a, $10
    ld c, a
    jr Jump_012_7440

Jump_012_7434::
    ld a, b
    add a, $10
    ld b, a
    jr Jump_012_7440

Jump_012_743A::
    ld a, c
    sub a, $10
    ld c, a
    jr Jump_012_7440

Jump_012_7440::
    call ReadTileBuffer2x2AtPixel_Bank12
    ld a, [wCC44]
    cp a, $86
    jp z, Jump_012_74FB
    ld a, [wC910]
    cp a, $2C
    jr z, Jump_012_7479
    cp a, $2E
    jr z, Jump_012_7457
    ret

Jump_012_7457::
    ld hl, $0000
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ld a, $0E
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ret

Jump_012_7479::
    ldh a, [hMapScreenX]
    swap a
    ld b, a
    ldh a, [hMapScreenY]
    or a, b
    ld b, a
    ld a, [wCC45]
    swap a
    ld hl, wCDB0
    add_a_to_hl
    ld a, [wCC43]
    ld c, a
    ld a, [hl]
    cp a, c
    jr nz, Jump_012_74C7
    inc hl
    inc hl
    ld a, [hl]
    ld de, Data_012_752E
    add a, e
    ld e, a
    jr nc, Jump_012_74A2
    inc d

Jump_012_74A2::
    ld a, [de]
    cp a, b
    jr nz, Jump_012_74C9
    dec hl
    dec hl
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ld a, $0E
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ret

Jump_012_74C7::
    inc hl
    inc hl

Jump_012_74C9::
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    ld de, Data_012_752E
    add a, e
    ld e, a
    jr nc, Jump_012_74D6
    inc d

Jump_012_74D6::
    ld a, [de]
    cp a, b
    jr nz, Jump_012_74FA
    dec hl
    dec hl
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ld a, $0E
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a

Jump_012_74FA::
    ret

Jump_012_74FB::
    ld a, [wC910]
    cp a, $1A
    jr z, Jump_012_7508
    cp a, $1C
    jp z, Jump_012_7457
    ret

Jump_012_7508::
    ld a, [wCC45]
    ld hl, wCE8B
    add_a_to_hl
    ld a, [hl]
    ld [wScriptParam0], a
    ld a, $0D
    ld [wC916], a
    xor a, a
    ld [wC917], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ret

Data_012_752E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $10, $12, $13, $20, $21, $23, $32

; A = 1 when the player cell (B, C high nibbles) equals the trigger cell wC8FF (or its Data_012_7581 entry on special maps), else 0 (E-0127)
; 2 call sites from 2 routines (e.g. FieldModeStateDispatch_Shared02, CheckStepTriggerAndDispatchTalk)
; reads: wCC44, wC8FF
IsPlayerOnTriggerCell::
Func_012_7536:: ; address name
    push bc
    jr Jump_012_753C

Jump_012_7539::
    xor a, a
    pop bc
    ret

Jump_012_753C::
    ld a, b
    swap a
    and a, $0F
    ld b, a
    ld a, c
    swap a
    and a, $0F
    ld c, a
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_012_7565

Jump_012_754F::
    ld a, [wC8FF]
    swap a
    and a, $0F
    cp a, b
    jr nz, Jump_012_7539
    ld a, [wC8FF]
    and a, $0F
    cp a, c
    jr nz, Jump_012_7539
    ld a, $01
    pop bc
    ret

Jump_012_7565::
    cp a, $85
    jr z, Jump_012_754F
    ld a, [wC8FF]
    add a, a
    ld hl, Data_012_7581
    add_a_to_hl
    ld a, [hl+]
    cp a, b
    jr nz, Jump_012_7539
    ld a, [hl]
    cp a, c
    jr nz, Jump_012_7539
    ld a, $01
    pop bc
    ret

Data_012_7581:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $02, $01, $07, $02, $01, $02, $04, $02, $06, $03, $03, $04, $05, $04, $07
    db $05, $01, $05, $03, $06, $05, $07, $02, $07, $04, $07, $07, $08, $01, $08, $06

; B = X pixel, C = Y pixel: HL = wScreenTileBuffer + 20 * (C / 8) + B / 8 (rows of 20 entries); copies the 2 x 2 entries there to wC910, wC911 (top row) and wC912, wC913 (bottom row); HL ends on the bottom-right entry (E-0064) (the same 63 bytes appear in 3 banks)
; 2 call sites from 2 routines (e.g. Func_012_7BCC, FieldModeStateDispatch_Case05_Sub02)
; writes: wC910, wC911, wC912, wC913
ReadTileBuffer2x2AtPixel_Bank12::
Func_012_75A1:: ; address name
    ld a, c
    srl a
    srl a
    srl a
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add_a_to_hl
    add hl, hl
    add hl, hl
    ld a, b
    srl a
    srl a
    srl a
    add_a_to_hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
    ld h, a
    ld a, [hl+]
    ld [wC910], a
    ld a, [hl-]
    ld [wC911], a
    ld a, $14
    add_a_to_hl
    ld a, [hl+]
    ld [wC912], a
    ld a, [hl]
    ld [wC913], a
    ret

; 3 call sites from 3 routines (e.g. Func_012_7BCC, UpdatePlayerMovement_Sub01, RunWC468ActionIfBit7_Case03)
; reads: wScriptRunning, wC935, wCC44, hMapId, wC832
; writes: wC832
Func_012_75E0::
    ld a, [wScriptRunning]
    or a, a
    ret nz
    ld a, [wC935]
    bit 7, a
    ret nz
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_012_7615
    ldh a, [hMapId]
    cp a, $20
    jr z, Jump_012_7618
    cp a, $30
    jr z, Jump_012_7618
    cp a, $48
    jr z, Jump_012_7618
    cp a, $70
    jr z, Jump_012_7618
    cp a, $A8
    jr z, Jump_012_7618
    cp a, $B0
    jr z, Jump_012_7618
    cp a, $B8
    jr z, Jump_012_7618
    cp a, $C8
    jr z, Jump_012_7618
    ret

Jump_012_7615::
    and a, $7F
    ret nz

Jump_012_7618::
    ld a, [wC832]
    cp a, $63
    jr z, Jump_012_7624
    inc a
    ld [wC832], a
    ret

Jump_012_7624::
    xor a, a
    ld [wC832], a
    call EventCheckGoldAtLeast10000
    ret c
    call TriggerEventCDIfPartyHPTotalBelow100
    ret c
    call TriggerEventCEIfPartyMPTotalBelow100
    ret c
    call TriggerEventCFIfPartyLevelTotalBelow100
    ret c
    call TriggerEventC0IfHPDigitsRepeat
    ret c
    call Func_012_7AD0
    ret c
    call Func_012_7A4D
    ret c
    call Func_012_79DC
    ret c
    call TriggerEventC6IfGoldAtLeast5000
    ret c
    call Func_012_781E
    ret c
    call TriggerEventC7IfGold1000AndNoItems19To1C
    ret c
    call Func_012_789E
    ret c
    call Func_012_77AC
    ret c
    call TriggerEventC4OrC5IfGold1000
    ret c
    sub a, a
    ret

; when story flag $192 is set, flag $193 is clear and gold >= 10,000 ($2710): wC935 = $CC and carry set; otherwise A = 0 and carry clear (E-0075)
; 1 call site from 1 routine (e.g. Func_012_75E0)
; reads: wGoldHi, wGoldMid, wGoldLo
; writes: wC935
EventCheckGoldAtLeast10000::
Func_012_7662:: ; address name
    ld de, $0192
    call TestFlagBit
    jr nc, Jump_012_7691
    ld de, $0193
    call TestFlagBit
    jr c, Jump_012_7691
    ld a, [wGoldHi]
    or a, a
    jr nz, Jump_012_768A
    ld a, [wGoldMid]
    cp a, $27
    jr z, Jump_012_7683
    jr nc, Jump_012_768A
    jr Jump_012_7691

Jump_012_7683::
    ld a, [wGoldLo]
    cp a, $10
    jr c, Jump_012_7691

Jump_012_768A::
    ld a, $CC
    ld [wC935], a
    scf
    ret

Jump_012_7691::
    sub a, a
    ret

; with story flag $195 set and $196 clear: when the party's total HP is below 100, wC935 = $CD and carry (E-0127)
; 1 call site from 1 routine (e.g. Func_012_75E0)
; reads: wC6FD, hFFC6, hFFC7, hFFC8, hFFC9
; writes: hFFC8, hFFC9, rRAMG, wC935
; points at: wC6FE
TriggerEventCDIfPartyHPTotalBelow100::
Func_012_7693:: ; address name
    ld de, $0195
    call TestFlagBit
    jr nc, Jump_012_76EF
    ld de, $0196
    call TestFlagBit
    jr c, Jump_012_76EF
    ld a, [wC6FD]
    ld b, a
    ld hl, $0000
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    ld hl, wC6FE
    ld a, $0A
    ld [rRAMG], a

Jump_012_76B8::
    push bc
    push hl
    ld a, [hl]
    ld c, $5B
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ldh a, [hFFC8]
    ld e, a
    ldh a, [hFFC9]
    ld d, a
    add hl, de
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    pop hl
    inc hl
    pop bc
    dec b
    jr nz, Jump_012_76B8
    xor a, a
    ld [rRAMG], a
    ldh a, [hFFC9]
    or a, a
    jr nz, Jump_012_76EF
    ldh a, [hFFC8]
    cp a, $64
    jr nc, Jump_012_76EF
    ld a, $CD
    ld [wC935], a
    scf
    ret

Jump_012_76EF::
    sub a, a
    ret

; with story flag $198 set and $199 clear: when the party's total MP is below 100, wC935 = $CE and carry (E-0127)
; 1 call site from 1 routine (e.g. Func_012_75E0)
; reads: wC6FD, hFFC6, hFFC7, hFFC8, hFFC9
; writes: hFFC8, hFFC9, rRAMG, wC935
; points at: wC6FE
TriggerEventCEIfPartyMPTotalBelow100::
Func_012_76F1:: ; address name
    ld de, $0198
    call TestFlagBit
    jr nc, Jump_012_774D
    ld de, $0199
    call TestFlagBit
    jr c, Jump_012_774D
    ld a, [wC6FD]
    ld b, a
    ld hl, $0000
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    ld hl, wC6FE
    ld a, $0A
    ld [rRAMG], a

Jump_012_7716::
    push bc
    push hl
    ld a, [hl]
    ld c, $5F
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ldh a, [hFFC8]
    ld e, a
    ldh a, [hFFC9]
    ld d, a
    add hl, de
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    pop hl
    inc hl
    pop bc
    dec b
    jr nz, Jump_012_7716
    xor a, a
    ld [rRAMG], a
    ldh a, [hFFC9]
    or a, a
    jr nz, Jump_012_774D
    ldh a, [hFFC8]
    cp a, $64
    jr nc, Jump_012_774D
    ld a, $CE
    ld [wC935], a
    scf
    ret

Jump_012_774D::
    sub a, a
    ret

; with story flag $19B set and $19C clear: when the party's total level is below 100, wC935 = $CF and carry (E-0127)
; 1 call site from 1 routine (e.g. Func_012_75E0)
; reads: wC6FD, hFFC6, hFFC8, hFFC9
; writes: hFFC8, hFFC9, rRAMG, wC935
; points at: wC6FE
TriggerEventCFIfPartyLevelTotalBelow100::
Func_012_774F:: ; address name
    ld de, $019B
    call TestFlagBit
    jr nc, Jump_012_77AA
    ld de, $019C
    call TestFlagBit
    jr c, Jump_012_77AA
    ld a, [wC6FD]
    ld b, a
    ld hl, $0000
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    ld hl, wC6FE
    ld a, $0A
    ld [rRAMG], a

Jump_012_7774::
    push bc
    push hl
    ld a, [hl]
    ld c, $56
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    ld l, a
    ld h, $00
    ldh a, [hFFC8]
    ld e, a
    ldh a, [hFFC9]
    ld d, a
    add hl, de
    ld a, l
    ldh [hFFC8], a
    ld a, h
    ldh [hFFC9], a
    pop hl
    inc hl
    pop bc
    dec b
    jr nz, Jump_012_7774
    xor a, a
    ld [rRAMG], a
    ldh a, [hFFC9]
    or a, a
    jr nz, Jump_012_77AA
    ldh a, [hFFC8]
    cp a, $64
    jr nc, Jump_012_77AA
    ld a, $CF
    ld [wC935], a
    scf
    ret

Jump_012_77AA::
    sub a, a
    ret

; 1 call site from 1 routine (e.g. Func_012_75E0)
; reads: wGoldHi, wGoldMid, wC6FD, hFFC6, hFFC7, hFFC8, wGoldLo
; writes: rRAMG, wC8C0, wC8C1, wC8C2, wC935
; points at: wC6FE
Func_012_77AC::
    ld a, [wGoldHi]
    or a, a
    jr nz, Jump_012_77C4
    ld a, [wGoldMid]
    cp a, $03
    jr z, Jump_012_77BD
    jr nc, Jump_012_77C4
    jr Jump_012_7818

Jump_012_77BD::
    ld a, [wGoldLo]
    cp a, $E8
    jr c, Jump_012_7818

Jump_012_77C4::
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE
    ld a, $0A
    ld [rRAMG], a

Jump_012_77D0::
    push bc
    push hl
    ld a, [hl]
    ld c, $58
    call LoadRecordThreeBytesToHFFC6
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld a, l
    ld [wC8C0], a
    ld a, h
    ld [wC8C1], a
    ldh a, [hFFC8]
    ld [wC8C2], a
    call Number24ToPackedBCD
    ldh a, [hFFC6]
    and a, $0F
    ld c, a
    ldh a, [hFFC6]
    swap a
    and a, $0F
    cp a, c
    jr nz, Jump_012_7803
    ldh a, [hFFC7]
    and a, $0F
    cp a, c
    jr z, Jump_012_780B

Jump_012_7803::
    pop hl
    inc hl
    pop bc
    dec b
    jr nz, Jump_012_77D0
    jr Jump_012_7818

Jump_012_780B::
    pop hl
    pop bc
    xor a, a
    ld [rRAMG], a
    ld a, $C9
    ld [wC935], a
    scf
    ret

Jump_012_7818::
    xor a, a
    ld [rRAMG], a
    sub a, a
    ret

; 1 call site from 1 routine (e.g. Func_012_75E0)
; reads: wGoldHi, wGoldMid, wC6FD, hFFC6, hFFC7, hFFC9, hFFC8, wGoldLo
; writes: rRAMG, hFFC8, hFFC9, wC935
; points at: wC6FE
Func_012_781E::
    ld a, [wGoldHi]
    or a, a
    jr nz, Jump_012_7836
    ld a, [wGoldMid]
    cp a, $03
    jr z, Jump_012_782F
    jr nc, Jump_012_7836
    jr Jump_012_7898

Jump_012_782F::
    ld a, [wGoldLo]
    cp a, $E8
    jr c, Jump_012_7898

Jump_012_7836::
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE
    ld a, $0A
    ld [rRAMG], a

Jump_012_7842::
    push hl
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_012_785E
    bit 2, a
    jr nz, Jump_012_785E
    bit 0, a
    jr nz, Jump_012_785E

Jump_012_7857::
    pop hl
    inc hl
    dec b
    jr nz, Jump_012_7842
    jr Jump_012_7898

Jump_012_785E::
    ld a, [hl]
    ld c, $5D
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    srl d
    rr e
    ld a, e
    ldh [hFFC8], a
    ld a, d
    ldh [hFFC9], a
    ld a, [hl]
    ld c, $5D
    call LoadSRAMRecordWord
    ldh a, [hFFC9]
    ld c, a
    ldh a, [hFFC7]
    cp a, c
    jr c, Jump_012_7857
    jr nz, Jump_012_788C
    ldh a, [hFFC8]
    ld c, a
    ldh a, [hFFC6]
    cp a, c
    jr c, Jump_012_7857

Jump_012_788C::
    pop hl
    xor a, a
    ld [rRAMG], a
    ld a, $CB
    ld [wC935], a
    scf
    ret

Jump_012_7898::
    xor a, a
    ld [rRAMG], a
    sub a, a
    ret

; 1 call site from 1 routine (e.g. Func_012_75E0)
; reads: wC627, wGoldHi, wGoldMid, wC6FD, hFFC6, hFFC7, wGoldLo
; writes: rRAMG, wC935
; points at: wC6FE
Func_012_789E::
    ld a, [wC627]
    cp a, $FF
    jr z, Jump_012_78A9
    or a, a
    jp nz, Jump_012_7932

Jump_012_78A9::
    ld a, [wGoldHi]
    or a, a
    jr nz, Jump_012_78C1
    ld a, [wGoldMid]
    cp a, $03
    jr z, Jump_012_78BA
    jr nc, Jump_012_78C1
    jr Jump_012_7932

Jump_012_78BA::
    ld a, [wGoldLo]
    cp a, $E8
    jr c, Jump_012_7932

Jump_012_78C1::
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE
    ld de, $0000

Jump_012_78D0::
    ld a, [hl+]
    ld c, $5D
    call LoadSRAMRecordWord
    push hl
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    add hl, de
    ld e, l
    ld d, h
    pop hl
    dec b
    jr nz, Jump_012_78D0
    xor a, a
    ld [rRAMG], a
    ld l, e
    ld h, d
    ld a, $64
    call DivideHLByA
    ld c, l
    ld b, h
    ld a, $1E
    call Multiply8By16
    push hl
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE
    ld de, $0000

Jump_012_7906::
    ld a, [hl+]
    ld c, $5B
    call LoadSRAMRecordWord
    push hl
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    add hl, de
    ld e, l
    ld d, h
    pop hl
    dec b
    jr nz, Jump_012_7906
    xor a, a
    ld [rRAMG], a
    pop hl
    ld a, d
    cp a, h
    jr c, Jump_012_792B
    jr nz, Jump_012_7932
    ld a, e
    cp a, l
    jr c, Jump_012_792B
    jr nz, Jump_012_7932

Jump_012_792B::
    ld a, $C8
    ld [wC935], a
    scf
    ret

Jump_012_7932::
    sub a, a
    ret

; when wC627 is $FF or 0, the gold is at least 1000 and no inventory slot before the first empty one holds items $19-$1C: wC935 = $C7 and carry (E-0125)
; 1 call site from 1 routine (e.g. Func_012_75E0)
; reads: wC627, wGoldHi, wGoldMid, wGoldLo
; writes: wC935
; points at: wInventory
TriggerEventC7IfGold1000AndNoItems19To1C::
Func_012_7934:: ; address name
    ld a, [wC627]
    cp a, $FF
    jr z, Jump_012_793E
    or a, a
    jr nz, Jump_012_797A

Jump_012_793E::
    ld a, [wGoldHi]
    or a, a
    jr nz, Jump_012_7956
    ld a, [wGoldMid]
    cp a, $03
    jr z, Jump_012_794F
    jr nc, Jump_012_7956
    jr Jump_012_797A

Jump_012_794F::
    ld a, [wGoldLo]
    cp a, $E8
    jr c, Jump_012_797A

Jump_012_7956::
    ld hl, wInventory

Jump_012_7959::
    ld a, [hl+]
    or a, a
    jr z, Jump_012_7973
    cp a, $FF
    jr z, Jump_012_7973
    cp a, $19
    jr z, Jump_012_797A
    cp a, $1A
    jr z, Jump_012_797A
    cp a, $1B
    jr z, Jump_012_797A
    cp a, $1C
    jr z, Jump_012_797A
    jr Jump_012_7959

Jump_012_7973::
    ld a, $C7
    ld [wC935], a
    scf
    ret

Jump_012_797A::
    sub a, a
    ret

; when wC627 is $FF or 0 and the gold is at least 5000, wC935 = $C6 and carry; otherwise A = 0, no carry (E-0124)
; 1 call site from 1 routine (e.g. Func_012_75E0)
; reads: wC627, wGoldHi, wGoldMid, wGoldLo
; writes: wC935
TriggerEventC6IfGoldAtLeast5000::
Func_012_797C:: ; address name
    ld a, [wC627]
    cp a, $FF
    jr z, Jump_012_7986
    or a, a
    jr nz, Jump_012_79A5

Jump_012_7986::
    ld a, [wGoldHi]
    or a, a
    jr nz, Jump_012_799E
    ld a, [wGoldMid]
    cp a, $13
    jr z, Jump_012_7997
    jr nc, Jump_012_799E
    jr Jump_012_79A5

Jump_012_7997::
    ld a, [wGoldLo]
    cp a, $88
    jr c, Jump_012_79A5

Jump_012_799E::
    ld a, $C6
    ld [wC935], a
    scf
    ret

Jump_012_79A5::
    sub a, a
    ret

; when the gold is at least 1000 and wC634 is $FF or 0: wC935 = $C4 or $C5 at random and carry (E-0125)
; 1 call site from 1 routine (e.g. Func_012_75E0)
; reads: wGoldHi, wGoldMid, wC634, wC5E8, wGoldLo
; writes: wC935
TriggerEventC4OrC5IfGold1000::
Func_012_79A7:: ; address name
    ld a, [wGoldHi]
    or a, a
    jr nz, Jump_012_79BF
    ld a, [wGoldMid]
    cp a, $03
    jr z, Jump_012_79B8
    jr nc, Jump_012_79BF
    jr Jump_012_79CB

Jump_012_79B8::
    ld a, [wGoldLo]
    cp a, $E8
    jr c, Jump_012_79CB

Jump_012_79BF::
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_012_79C9
    or a, a
    jr nz, Jump_012_79CB

Jump_012_79C9::
    jr Jump_012_79CD

Jump_012_79CB::
    sub a, a
    ret

Jump_012_79CD::
    call NextTableByte
    ld a, [wC5E8]
    and a, $01
    add a, $C4
    ld [wC935], a
    scf
    ret

; 1 call site from 1 routine (e.g. Func_012_75E0)
; reads: wGoldHi, wGoldMid, wC634, wGoldLo, hFFC6, hFFC7, hFFC8, hFFC9
; writes: wC8C0, wC8C1, wC8C2, wC935
Func_012_79DC::
    ld a, [wGoldHi]
    or a, a
    jr nz, Jump_012_79F4
    ld a, [wGoldMid]
    cp a, $13
    jr z, Jump_012_79ED
    jr nc, Jump_012_79F4
    jr Jump_012_7A44

Jump_012_79ED::
    ld a, [wGoldLo]
    cp a, $88
    jr c, Jump_012_7A44

Jump_012_79F4::
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_012_79FD
    or a, a
    ret nz

Jump_012_79FD::
    ld a, [wGoldLo]
    ld [wC8C0], a
    ld a, [wGoldMid]
    ld [wC8C1], a
    ld a, [wGoldHi]
    ld [wC8C2], a
    call Number24ToPackedBCD
    ldh a, [hFFC6]
    and a, $0F
    ld c, a
    ldh a, [hFFC6]
    swap a
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hFFC7]
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hFFC7]
    swap a
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hFFC8]
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hFFC8]
    swap a
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hFFC9]
    and a, $0F
    add a, c
    cp a, $1E
    jr nc, Jump_012_7A46

Jump_012_7A44::
    sub a, a
    ret

Jump_012_7A46::
    ld a, $C3
    ld [wC935], a
    scf
    ret

; 1 call site from 1 routine (e.g. Func_012_75E0)
; reads: wGoldHi, wGoldMid, wC6FD, wC6FE, hFFC6, hFFC7, wC8C2, wC6FF, ...
; writes: rRAMG, wC935
Func_012_7A4D::
    ld a, [wGoldHi]
    or a, a
    jr nz, Jump_012_7A66
    ld a, [wGoldMid]
    cp a, $03
    jr z, Jump_012_7A5F
    jr nc, Jump_012_7A66
    jp Jump_012_7ACE

Jump_012_7A5F::
    ld a, [wGoldLo]
    cp a, $E8
    jr c, Jump_012_7ACE

Jump_012_7A66::
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    dec a
    jr z, Jump_012_7ABF
    ld a, [wC6FE]
    ld c, $5B
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    call HLToDecimalDigits
    ld a, [wC8C2]
    ld b, a
    ld a, [wC6FF]
    ld c, $5B
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    push bc
    call HLToDecimalDigits
    pop bc
    ld a, [wC8C2]
    cp a, b
    jr nz, Jump_012_7ACA
    ld a, [wC6FD]
    dec a
    dec a
    jr z, Jump_012_7ABF
    ld a, [wC700]
    ld c, $5B
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    push bc
    call HLToDecimalDigits
    pop bc
    ld a, [wC8C2]
    cp a, b
    jr nz, Jump_012_7ACA

Jump_012_7ABF::
    xor a, a
    ld [rRAMG], a
    ld a, $C2
    ld [wC935], a
    scf
    ret

Jump_012_7ACA::
    xor a, a
    ld [rRAMG], a

Jump_012_7ACE::
    sub a, a
    ret

; 1 call site from 1 routine (e.g. Func_012_75E0)
; reads: wC634, wGoldHi, wGoldMid, wGoldLo, hFFC6, hFFC7, hFFC8, hFFC9
; writes: wC8C0, wC8C1, wC8C2, wC935
Func_012_7AD0::
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_012_7ADA
    or a, a
    jr nz, Jump_012_7B3C

Jump_012_7ADA::
    ld a, [wGoldHi]
    or a, a
    jr nz, Jump_012_7AF3
    ld a, [wGoldMid]
    cp a, $03
    jr z, Jump_012_7AEC
    jr nc, Jump_012_7AF3
    jp Jump_012_7B3C

Jump_012_7AEC::
    ld a, [wGoldLo]
    cp a, $E8
    jr c, Jump_012_7B3C

Jump_012_7AF3::
    ld a, [wGoldLo]
    ld [wC8C0], a
    ld a, [wGoldMid]
    ld [wC8C1], a
    ld a, [wGoldHi]
    ld [wC8C2], a
    call Number24ToPackedBCD
    ldh a, [hFFC6]
    and a, $0F
    ld c, a
    ldh a, [hFFC6]
    swap a
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hFFC7]
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hFFC7]
    swap a
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hFFC8]
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hFFC8]
    swap a
    and a, $0F
    add a, c
    ld c, a
    ldh a, [hFFC9]
    and a, $0F
    add a, c
    cp a, $0C
    jr z, Jump_012_7B3E
    jr c, Jump_012_7B3E

Jump_012_7B3C::
    sub a, a
    ret

Jump_012_7B3E::
    ld a, $C1
    ld [wC935], a
    scf
    ret

; when a party member's HP has all decimal digits equal (for example 77 or 333), wC935 = $C0 and carry (E-0127)
; 1 call site from 1 routine (e.g. Func_012_75E0)
; reads: wC6FD, hFFC6, hFFC7, wC8C0, wC8C1, wC8C2
; writes: rRAMG, wC935
; points at: wC6FE
TriggerEventC0IfHPDigitsRepeat::
Func_012_7B45:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE

Jump_012_7B51::
    push bc
    push hl
    ld a, [hl]
    ld c, $5B
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    call HLToDecimalDigits
    ld a, [wC8C0]
    or a, a
    jr z, Jump_012_7B77
    ld c, a
    ld a, [wC8C1]
    cp a, c
    jr nz, Jump_012_7B86
    ld a, [wC8C2]
    cp a, c
    jr nz, Jump_012_7B86
    jr Jump_012_7B92

Jump_012_7B77::
    ld a, [wC8C1]
    or a, a
    jr z, Jump_012_7B92
    ld c, a
    ld a, [wC8C2]
    cp a, c
    jr nz, Jump_012_7B86
    jr Jump_012_7B92

Jump_012_7B86::
    pop hl
    inc hl
    pop bc
    dec b
    jr nz, Jump_012_7B51
    xor a, a
    ld [rRAMG], a
    sub a, a
    ret

Jump_012_7B92::
    pop hl
    pop bc
    xor a, a
    ld [rRAMG], a
    ld a, $C0
    ld [wC935], a
    scf
    ret

; when wC935 has bit 7 set and bit 6 clear: wC935 = 0 and wC832 = 0 (E-0117)
; 9 call sites from 7 routines (e.g. CheckWarpAtPlayer, Func_011_4130, ScriptWarpToMapFromBytesAtDE, CheckMapExitTable4480_Sub01, ...)
; reads: wC935
; writes: wC935, wC832
ClearWC935IfBit7AndNot6::
Func_012_7B9F:: ; address name
    ld a, [wC935]
    bit 7, a
    ret z
    bit 6, a
    ret nz
    xor a, a
    ld [wC935], a
    ld [wC832], a
    ret

; returns unless Func_012_7D5E is 0, wC8FE is $FF and no script runs; then, unless bit 7 of wCC44 is set, wC935 = 0 (E-0122)
; 2 call sites from 2 routines (e.g. Func_002_4628, RunWC468ActionIfBit7_Case02)
; reads: wC8FE, wScriptRunning, wCC44, wC935, wC5E8, wCB83, wCB84, wC634
; writes: wC935, wCB83, wCB8A, wCB84, wCB8B, wSpriteSlots, wCB80, wCB82, ...
ClearWC935WhenFieldIdle::
Func_012_7BB0:: ; address name
    call ClearWC935WhenFieldIdle_Sub01
    or a, a
    ret nz
    ld a, [wC8FE]
    cp a, $FF
    ret nz
    ld a, [wScriptRunning]
    or a, a
    ret nz
    ld a, [wCC44]
    bit 7, a
    jr nz, Jump_012_7BFC
    xor a, a
    ld [wC935], a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wC935, hMapId, wC5E8, wCB83, wCB84, wC634
; writes: wC935, wCB83, wCB8A, wCB84, wCB8B, wSpriteSlots, wCB80, wCB82, ...
Func_012_7BCC:: ; heuristic: follows a terminator; C0
    ld a, [wC935]
    and a, $0F
    cp a, $08
    jr z, Jump_012_7BF7
    ldh a, [hMapId]
    cp a, $20
    jr z, Jump_012_7BFF
    cp a, $30
    jr z, Jump_012_7BFF
    cp a, $48
    jr z, Jump_012_7BFF
    cp a, $70
    jr z, Jump_012_7BFF
    cp a, $A8
    jr z, Jump_012_7BFF
    cp a, $B0
    jr z, Jump_012_7BFF
    cp a, $B8
    jr z, Jump_012_7BFF
    cp a, $C8
    jr z, Jump_012_7BFF

Jump_012_7BF7::
    xor a, a
    ld [wC935], a
    ret

Jump_012_7BFC::
    and a, $7F
    ret nz

Jump_012_7BFF::
    ld a, [wC935]
    bit 7, a
    ret z
    bit 6, a
    jp z, Jump_012_7CA1
    ld a, [wC935]
    and a, $0F
    cp a, $01
    jr z, Jump_012_7C25
    cp a, $03
    jr z, Jump_012_7C25
    cp a, $04
    jr z, Jump_012_7C25
    cp a, $05
    jr z, Jump_012_7C25
    cp a, $07
    jr z, Jump_012_7C25
    jr Jump_012_7C3B

Jump_012_7C25::
    ld a, [wC634]
    cp a, $FF
    jr z, Jump_012_7C3B
    or a, a
    jr z, Jump_012_7C3B
    xor a, a
    ld [wC935], a
    ld a, $63
    ld [wC832], a
    call Func_012_75E0

Jump_012_7C3B::
    call NextTableByte
    ld a, [wC5E8]
    and a, $03
    add a, a
    ld hl, Data_012_7D56
    add_a_to_hl
    ld a, [hl+]
    ld [wCB83], a
    ld [wCB8A], a
    ld a, [hl]
    ld [wCB84], a
    ld [wCB8B], a
    ld a, [wCB83]
    ld b, a
    ld a, [wCB84]
    ld c, a
    call ReadTileBuffer2x2AtPixel_Bank12
    call Func_012_7CD9
    cp a, $01
    ret z
    ld a, $03
    ld [wSpriteSlots], a
    ld a, $01
    ld [wCB80], a
    xor a, a
    ld [wCB82], a
    ld a, $05
    ld [wCB85], a
    ld a, $00
    ld [wCB86], a
    ld a, $50
    ld [wCB87], a
    xor a, a
    ld [wCB88], a
    xor a, a
    ld [wCB89], a
    xor a, a
    ld [wCB8C], a
    ld a, $FF
    ld [wCB8E], a
    ld a, [wC935]
    and a, $BF
    ld [wC935], a

Jump_012_7CA1::
    ld a, $01
    ld [wSpriteSlotCount], a
    ld a, [wC935]
    and a, $0F
    ld hl, Data_012_7D46
    add_a_to_hl
    ld a, [hl]
    ld [wCB81], a
    ldh [hFFC6], a
    xor a, a
    ldh [hFFC7], a
    ld a, $01
    ldh [hFFC8], a
    ld a, $05
    ldh [hFFC9], a
    ld hl, vTiles0 + $500
    ld a, l
    ldh [hFFCA], a
    ld a, h
    ldh [hFFCB], a
    farcall DecompressGraphicsHFFC6ToHFFCA
    ld a, $7F
    ld [wC527], a
    ret

; 1 call site from 1 routine (e.g. Func_012_7BCC)
; reads: wC195, wC196, wCD04, hFFC6, wC634, wGoldHi, wGoldMid, wGoldLo, ...
; writes: hFFC6, wC935
; points at: wC910
Func_012_7CD9::
    ld a, [wC195]
    and a, $0F
    dec a
    jr nz, Jump_012_7D2F
    ld b, $04
    ld hl, wC910

Jump_012_7CE6::
    ld a, [hl+]
    ld c, a
    ld a, [wC196]
    cp a, c
    jr c, Jump_012_7D2C
    call NextRandomSeed
    ld a, [wCD04]
    and a, $07
    jr nz, Jump_012_7D2F
    ld a, $2C
    ldh [hFFC6], a
    call FindHFFC6InWC61DList
    ldh a, [hFFC6]
    bit 7, a
    jr nz, Jump_012_7D2F
    ld a, [wC634]
    or a, a
    jr z, Jump_012_7D0F
    cp a, $FF
    jr nz, Jump_012_7D2F

Jump_012_7D0F::
    ld a, [wGoldHi]
    ld c, a
    ld a, [wGoldMid]
    or a, c
    jr nz, Jump_012_7D20
    ld a, [wGoldLo]
    cp a, $64
    jr c, Jump_012_7D2F

Jump_012_7D20::
    ld a, [wC935]
    and a, $F0
    or a, $0A
    ld [wC935], a
    xor a, a
    ret

Jump_012_7D2C::
    dec b
    jr nz, Jump_012_7CE6

Jump_012_7D2F::
    ld b, $04
    ld hl, wC910

Jump_012_7D34::
    ld a, [hl+]
    ld c, a
    ld a, [wMaxBlockingTile]
    cp a, c
    jr c, Jump_012_7D3E
    jr Jump_012_7D43

Jump_012_7D3E::
    dec b
    jr nz, Jump_012_7D34
    xor a, a
    ret

Jump_012_7D43::
    ld a, $01
    ret

Data_012_7D46:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $12, $15, $3D, $3E, $10, $11, $17, $15, $14, $13, $57, $12, $15, $12, $14, $10

Data_012_7D56:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $20, $70, $60, $20, $60, $70, $20

; only called from ClearWC935WhenFieldIdle (E-0047)
; 1 call site from 1 routine (e.g. ClearWC935WhenFieldIdle)
; reads: wCC44, hMapId, hMapScreenX, hMapScreenY
; writes: wC935
ClearWC935WhenFieldIdle_Sub01::
Func_012_7D5E:: ; address name
    ld a, [wCC44]
    bit 7, a
    jp nz, Jump_012_7D93
    ldh a, [hMapId]
    cp a, $30
    jp nz, Jump_012_7D93
    ldh a, [hMapScreenX]
    cp a, $05
    jp nz, Jump_012_7D93
    ldh a, [hMapScreenY]
    cp a, $05
    jp nz, Jump_012_7D93
    ld de, $0076
    call TestFlagBit
    jr c, Jump_012_7D93
    ld de, $0070
    call TestFlagBit
    jr nc, Jump_012_7D93
    ld a, $00
    ld [wC935], a
    ld a, $01
    ret

Jump_012_7D93::
    xor a, a
    ret

; hFFC6 = the party index whose record species (field $0B) equals the word hFFC6/7, or $80 when none (E-0125)
; 7 call sites from 7 routines (e.g. DispatchTalkEvent_Case01_Case07_Sub01, DispatchTalkEvent_Case01_Case27, DispatchTalkEvent_Case01_Case7F, LoadListedRecordNameTilesForHFFC6, ...)
; reads: hFFC6, hFFC7, wC6FD
; writes: rRAMG, hFFC6
; points at: wC6FE
FindPartyIndexOfSpeciesHFFC6::
Func_012_7D95:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ldh a, [hFFC6]
    ld e, a
    ldh a, [hFFC7]
    ld d, a
    ld a, [wC6FD]
    ld b, a
    ld hl, wC6FE

Jump_012_7DA7::
    ld a, [hl+]
    ld c, $0B
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    cp a, e
    jr nz, Jump_012_7DB7
    ldh a, [hFFC7]
    cp a, d
    jr z, Jump_012_7DC3

Jump_012_7DB7::
    dec b
    jr nz, Jump_012_7DA7
    ld a, $80
    ldh [hFFC6], a
    xor a, a
    ld [rRAMG], a
    ret

Jump_012_7DC3::
    ld a, [wC6FD]
    sub a, b
    ldh [hFFC6], a
    xor a, a
    ld [rRAMG], a
    ret

; hFFC6 = the index of the first byte of the 24-entry list at wC61D equal to hFFC6; $FF when an entry is $00 or $FF first or no entry matches
; 47 call sites from 23 routines (e.g. Func_012_7CD9, Func_004_58C2_Case4F, Func_004_58C2_Case6A, Func_004_612B_Case38, ...)
; reads: hFFC6
; writes: hFFC6
; points at: wInventory
FindHFFC6InWC61DList::
Func_012_7DCE:: ; address name
    ldh a, [hFFC6]
    ld c, a
    ld b, $00
    ld hl, wInventory

Jump_012_7DD6::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_012_7DE8
    or a, a
    jr z, Jump_012_7DE8
    cp a, c
    jr z, Jump_012_7DED
    inc hl
    inc b
    ld a, b
    cp a, $18
    jr nz, Jump_012_7DD6

Jump_012_7DE8::
    ld a, $FF
    ldh [hFFC6], a
    ret

Jump_012_7DED::
    ld a, b
    ldh [hFFC6], a
    ret

; hFFC6 = inventory slot: moves each wInventory byte after it down by one up to slot $17 (the last slot keeps its old value), then wC634 = $FF; nothing moves when the slot is $17 (E-0106)
; 17 call sites from 10 routines (e.g. Func_004_58C2_Case6A, Func_004_612B_Case39, Talk075F_KiralFetchMeMy, Talk07A4_CouldYouHumorThis, ...)
; reads: hFFC6
; writes: wC634
; points at: wInventory
RemoveInventorySlotShiftDown::
Func_012_7DF1:: ; address name
    ldh a, [hFFC6]
    cp a, $17
    jr z, Jump_012_7E09
    ld b, a
    ld hl, wInventory
    add a, l
    ld l, a
    jr nc, Jump_012_7E00
    inc h

Jump_012_7E00::
    inc hl
    ld a, [hl-]
    ld [hl+], a
    inc b
    ld a, b
    cp a, $17
    jr nz, Jump_012_7E00

Jump_012_7E09::
    ld a, $FF
    ld [wC634], a
    ret

; 1 call site from 1 routine (e.g. Func_004_58C2_Case13)
; reads: wC6FD, hFFC7, hFFC6
; writes: rRAMG, hFFC7, hFFC8
; points at: wC6FE
Func_012_7E0F::
    ld a, $0A
    ld [rRAMG], a
    ld a, [wC6FD]
    ld b, a
    xor a, a
    ldh [hFFC7], a

Jump_012_7E1B::
    push bc
    ldh a, [hFFC7]
    ld hl, wC6FE
    add_a_to_hl
    ld b, $08
    ld c, $34

Jump_012_7E2A::
    ld a, [hl]
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    cp a, $FF
    jr z, Jump_012_7E65
    ld e, $76
    cp a, e
    jr z, Jump_012_7E77
    ld e, $77
    cp a, e
    jr z, Jump_012_7E77
    ld e, $78
    cp a, e
    jr z, Jump_012_7E77
    ld e, $79
    cp a, e
    jr z, Jump_012_7E77
    ld e, $7A
    cp a, e
    jr z, Jump_012_7E77
    ld e, $7B
    cp a, e
    jr z, Jump_012_7E77
    ld e, $7C
    cp a, e
    jr z, Jump_012_7E77
    ld e, $7D
    cp a, e
    jr z, Jump_012_7E77
    ld e, $92
    cp a, e
    jr z, Jump_012_7E77
    inc c
    dec b
    jr nz, Jump_012_7E2A

Jump_012_7E65::
    ldh a, [hFFC7]
    inc a
    ldh [hFFC7], a
    pop bc
    dec b
    jr nz, Jump_012_7E1B
    ld a, $80
    ldh [hFFC7], a
    xor a, a
    ld [rRAMG], a
    ret

Jump_012_7E77::
    ld a, e
    ldh [hFFC8], a
    pop bc
    xor a, a
    ld [rRAMG], a
    ret
    db $AF, $E0, $C7, $C9

; wGold -= the word hFFC6/hFFC7; when gold is smaller than the amount it becomes 0 instead (E-0075)
; 5 call sites from 5 routines (e.g. ScriptCommand82_Run_Case0A_Case02, ScriptCommand82_Run_Case08_Case02, ScriptCommand82_Run_Case03_Case02, ScriptCommand82_Run_Case02_Case05, ...)
; reads: hFFC6, hFFC7, wGoldHi, wGoldMid, wGoldLo
; writes: wGoldLo, wGoldMid, wGoldHi
SubtractGoldFloorZero::
Func_012_7E84:: ; address name
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld a, [wGoldHi]
    or a, a
    jr z, Jump_012_7EA0
    ld a, [wGoldMid]
    cp a, h
    jr c, Jump_012_7EB7
    jr z, Jump_012_7E9A
    jr Jump_012_7EA0

Jump_012_7E9A::
    ld a, [wGoldLo]
    cp a, l
    jr c, Jump_012_7EB7

Jump_012_7EA0::
    ld a, [wGoldLo]
    sub a, l
    ld [wGoldLo], a
    ld a, [wGoldMid]
    sbc a, h
    ld [wGoldMid], a
    ld a, [wGoldHi]
    sbc a, $00
    ld [wGoldHi], a
    ret

Jump_012_7EB7::
    xor a, a
    ld [wGoldLo], a
    ld [wGoldMid], a
    ld [wGoldHi], a
    ret

; adds the word hFFC6/hFFC7 to the 24-bit wGoldLo/Mid/Hi and caps the result at $01869F (99,999) (E-0074)
; 12 call sites from 5 routines (e.g. ScriptCommand84_Run_Case08, ScriptFetch0E, ScriptCommand80_Run_Case02, TalkMsg0A3C_KingIfYouSee, ...)
; reads: hFFC6, hFFC7, wGoldLo, wGoldMid, wGoldHi
; writes: wGoldLo, wGoldMid, wGoldHi
AddGoldCapped::
Func_012_7EC2:: ; address name
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    ld a, [wGoldLo]
    add a, l
    ld [wGoldLo], a
    ld a, [wGoldMid]
    adc a, h
    ld [wGoldMid], a
    ld a, [wGoldHi]
    adc a, $00
    ld [wGoldHi], a
    cp a, $01
    ret c
    jr z, Jump_012_7EE5
    jr Jump_012_7EF5

Jump_012_7EE5::
    ld a, [wGoldMid]
    cp a, $86
    ret c
    jr z, Jump_012_7EEF
    jr Jump_012_7EF5

Jump_012_7EEF::
    ld a, [wGoldLo]
    cp a, $9F
    ret c

Jump_012_7EF5::
    ld a, $9F
    ld [wGoldLo], a
    ld a, $86
    ld [wGoldMid], a
    ld a, $01
    ld [wGoldHi], a
    ret

; only called from ScriptCommand88_Run_Case00 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommand88_Run_Case00)
; reads: wGoldHi, wGoldMid, wGoldLo
; writes: wGoldHi, wGoldMid, wGoldLo
ScriptCommand88_Run_Case00_Sub01::
Func_012_7F05:: ; address name
    ld a, [wGoldHi]
    srl a
    ld [wGoldHi], a
    ld a, [wGoldMid]
    rra
    ld [wGoldMid], a
    ld a, [wGoldLo]
    rra
    ld [wGoldLo], a
    ret

; takes gold: all of it when below 150, 150 when below 1,500 ($05DC), otherwise one tenth (Divide24ByA, rounded down) (E-0075)
; 1 call site from 1 routine (e.g. DeductGoldPenaltyAndFormatLoss)
; reads: wGoldHi, wGoldMid, wGoldLo
; writes: wGoldLo, wGoldMid, wGoldHi
DeductGoldPenalty::
Func_012_7F1C:: ; address name
    ld a, [wGoldHi]
    or a, a
    jr nz, Jump_012_7F49
    ld a, [wGoldMid]
    or a, a
    jr nz, Jump_012_7F34
    ld a, [wGoldLo]
    cp a, $96
    jr nc, Jump_012_7F34
    ld l, a
    ld h, $00
    jr Jump_012_7F5A

Jump_012_7F34::
    ld a, [wGoldMid]
    cp a, $05
    jr c, Jump_012_7F44
    jr nz, Jump_012_7F49
    ld a, [wGoldLo]
    cp a, $DC
    jr nc, Jump_012_7F49

Jump_012_7F44::
    ld hl, $0096
    jr Jump_012_7F5A

Jump_012_7F49::
    ld a, [wGoldLo]
    ld l, a
    ld a, [wGoldMid]
    ld h, a
    ld a, [wGoldHi]
    ld e, a
    ld a, $0A
    call Divide24ByA

Jump_012_7F5A::
    ld a, [wGoldLo]
    sub a, l
    ld [wGoldLo], a
    ld a, [wGoldMid]
    sbc a, h
    ld [wGoldMid], a
    ld a, [wGoldHi]
    sbc a, $00
    ld [wGoldHi], a
    ret
    ds $8F, $00
