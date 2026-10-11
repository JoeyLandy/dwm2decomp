SECTION "Bank 1B", ROMX[$4000], BANK[$1B]
    db $1B

; only called from ComputeSpriteScrollOffsets (E-0047)
; 1 call site from 1 routine (e.g. ComputeSpriteScrollOffsets)
; reads: wLinkStatus, wLinkSession, wD781, rSB, wD06B, wLinkTimerLo, wMenuState, wD786, ...
; writes: wLinkStatus, wD784, wD783, wD780, wSubMenuCursor2, wD787, wLinkRole, wJoypadReadFlag, ...
; points at: wGameMode
ComputeSpriteScrollOffsets_Sub01::
Func_01B_4001:: ; address name
    ld a, [wLinkStatus]
    bit 7, a
    jr z, Jump_01B_400E
    set 6, a
    ld [wLinkStatus], a
    ret

Jump_01B_400E::
    ld a, [wLinkSession]
    and a, a
    jr z, Func_01B_4001_Case00
    ld a, [wLinkSession]
    rst $00
    dw Func_01B_4001_Case00
    dw Func_01B_4001_Case01
    dw Func_01B_4001_Case02
    dw Func_01B_4001_Case03
    dw Func_01B_4001_Case04
    dw Func_01B_4001_Case05
    dw Func_01B_4001_Case06
    dw Func_01B_4001_Case07
    dw Func_01B_4001_Case08

; entry 0 of the `rst $00` table in Func_01B_4001
; no direct call (reached through a table, a jump or a vector)
; reads: wD781, rSB, wD06B, wLinkTimerLo, wMenuState, wD786, wLinkRole, wMapType, ...
; writes: wD784, wD783, wLinkStatus, wD780, wSubMenuCursor2, wD787, wLinkRole, wJoypadReadFlag, ...
; points at: wGameMode
Func_01B_4001_Case00::
Jump_01B_402A:: ; address name
    ld a, $FF
    ld [wD784], a
    xor a, a
    ld [wD783], a
    ld [wD784], a
    call WaitSerialTransferDone
    ld a, [wD781]
    ld [wD784], a
    ldh a, [rSB]
    ld b, a
    cp a, $F1
    jp z, Jump_01B_4132
    cp a, $F5
    jr z, Jump_01B_4060
    cp a, $F6
    jr z, Jump_01B_408A
    cp a, $B7
    jr z, Jump_01B_40B4
    cp a, $E0
    jp z, Jump_01B_40DE
    cp a, $DC
    jp z, Jump_01B_4108
    jp Jump_01B_4163

Jump_01B_4060::
    call LinkCheckWD783State
    cp a, $FF
    jp z, Jump_01B_4357
    ld a, [wMenuState]
    cp a, $02
    jr z, Jump_01B_407D
    ld a, $02
    ld [wMenuOption], a
    ld a, [wD782]
    ld [wD785], a
    jp Jump_01B_4357

Jump_01B_407D::
    ld a, [wLinkRole]
    set 0, a
    set 1, a
    ld [wLinkRole], a
    jp Jump_01B_42A4

Jump_01B_408A::
    call LinkCheckWD783State
    cp a, $FF
    jp z, Jump_01B_4357
    ld a, [wMenuState]
    cp a, $03
    jr z, Jump_01B_40A7
    ld a, $03
    ld [wMenuOption], a
    ld a, [wD782]
    ld [wD785], a
    jp Jump_01B_4357

Jump_01B_40A7::
    ld a, [wLinkRole]
    set 0, a
    set 1, a
    ld [wLinkRole], a
    jp Jump_01B_42C3

Jump_01B_40B4::
    call LinkCheckWD783State
    cp a, $FF
    jp z, Jump_01B_4357
    ld a, [wMenuState]
    cp a, $04
    jr z, Jump_01B_40D1
    ld a, $04
    ld [wMenuOption], a
    ld a, [wD782]
    ld [wD785], a
    jp Jump_01B_4357

Jump_01B_40D1::
    ld a, [wLinkRole]
    set 0, a
    set 1, a
    ld [wLinkRole], a
    jp Jump_01B_4301

Jump_01B_40DE::
    call LinkCheckWD783State
    cp a, $FF
    jp z, Jump_01B_4357
    ld a, [wMenuState]
    cp a, $06
    jr z, Jump_01B_40FB
    ld a, $06
    ld [wMenuOption], a
    ld a, [wD782]
    ld [wD785], a
    jp Jump_01B_4357

Jump_01B_40FB::
    ld a, [wLinkRole]
    set 0, a
    set 1, a
    ld [wLinkRole], a
    jp Jump_01B_4320

Jump_01B_4108::
    call LinkCheckWD783State
    cp a, $FF
    jp z, Jump_01B_4357
    ld a, [wMenuState]
    cp a, $05
    jr z, Jump_01B_4125
    ld a, $05
    ld [wMenuOption], a
    ld a, [wD782]
    ld [wD785], a
    jp Jump_01B_4357

Jump_01B_4125::
    ld a, [wLinkRole]
    set 0, a
    set 1, a
    ld [wLinkRole], a
    jp Jump_01B_42E2

Jump_01B_4132::
    call LinkCheckWD783State
    cp a, $FF
    jp z, Jump_01B_4357
    ld a, [wMenuState]
    cp a, $07
    jr z, Jump_01B_4156
    ld a, [wLinkByte94]
    or a, a
    jp z, Jump_01B_4357
    ld a, $07
    ld [wMenuOption], a
    ld a, [wD782]
    ld [wD785], a
    jp Jump_01B_4357

Jump_01B_4156::
    ld a, [wLinkRole]
    set 0, a
    set 1, a
    ld [wLinkRole], a
    jp Jump_01B_426F

Jump_01B_4163::
    ld a, [wD06B]
    cp a, $02
    jr z, Jump_01B_416D
    jp Jump_01B_4357

Jump_01B_416D::
    ld a, [wLinkTimerLo]
    cp a, b
    jp z, Jump_01B_4357
    call ShortDelayLoop
    ld a, b
    ld [wD780], a
    cp a, $F3
    jr nz, Jump_01B_41A1
    ld a, [wMenuState]
    cp a, $07
    jr z, Jump_01B_4194
    ld a, $FF
    ld [wSubMenuCursor2], a
    ld a, [wD786]
    ld [wD787], a
    jp Jump_01B_4357

Jump_01B_4194::
    ld a, [wLinkRole]
    set 0, a
    res 1, a
    ld [wLinkRole], a
    jp Jump_01B_426F

Jump_01B_41A1::
    cp a, $FA
    jr nz, Jump_01B_41C7
    ld a, [wMenuState]
    cp a, $02
    jr z, Jump_01B_41BA
    ld a, $FF
    ld [wSubMenuCursor2], a
    ld a, [wD786]
    ld [wD787], a
    jp Jump_01B_4357

Jump_01B_41BA::
    ld a, [wLinkRole]
    set 0, a
    res 1, a
    ld [wLinkRole], a
    jp Jump_01B_42A4

Jump_01B_41C7::
    cp a, $FB
    jr nz, Jump_01B_41ED
    ld a, [wMenuState]
    cp a, $03
    jr z, Jump_01B_41E0
    ld a, $FF
    ld [wSubMenuCursor2], a
    ld a, [wD786]
    ld [wD787], a
    jp Jump_01B_4357

Jump_01B_41E0::
    ld a, [wLinkRole]
    set 0, a
    res 1, a
    ld [wLinkRole], a
    jp Jump_01B_42C3

Jump_01B_41ED::
    cp a, $FC
    jr nz, Jump_01B_4213
    ld a, [wMenuState]
    cp a, $04
    jr z, Jump_01B_4206
    ld a, $FF
    ld [wSubMenuCursor2], a
    ld a, [wD786]
    ld [wD787], a
    jp Jump_01B_4357

Jump_01B_4206::
    ld a, [wLinkRole]
    set 0, a
    res 1, a
    ld [wLinkRole], a
    jp Jump_01B_4301

Jump_01B_4213::
    cp a, $E1
    jr nz, Jump_01B_4239
    ld a, [wMenuState]
    cp a, $06
    jr z, Jump_01B_422C
    ld a, $FF
    ld [wSubMenuCursor2], a
    ld a, [wD786]
    ld [wD787], a
    jp Jump_01B_4357

Jump_01B_422C::
    ld a, [wLinkRole]
    set 0, a
    res 1, a
    ld [wLinkRole], a
    jp Jump_01B_4320

Jump_01B_4239::
    cp a, $DD
    jr nz, Jump_01B_425F
    ld a, [wMenuState]
    cp a, $05
    jr z, Jump_01B_4252
    ld a, $FF
    ld [wSubMenuCursor2], a
    ld a, [wD786]
    ld [wD787], a
    jp Jump_01B_4357

Jump_01B_4252::
    ld a, [wLinkRole]
    set 0, a
    res 1, a
    ld [wLinkRole], a
    jp Jump_01B_42E2

Jump_01B_425F::
    ld a, $FF
    ld [wSubMenuCursor2], a
    jp Jump_01B_4357
    db $3E, $FF, $EA, $70, $C4, $C3, $57, $43

Jump_01B_426F::
    ld a, $69
    call QueueSoundEffect
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $01
    ld [wLinkMode], a
    di
    farcall RunSaveSteps
    ld a, [wMapType]
    bit 7, a
    jr z, Jump_01B_4292
    farcall LoadWCD07RecordFromSRAMSlotWCC42

Jump_01B_4292::
    ei
    ld hl, wGameMode
    ld a, $05
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $05
    ld [wLinkSession], a
    jp Jump_01B_433F

Jump_01B_42A4::
    ld a, $69
    call QueueSoundEffect
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $01
    ld [wLinkMode], a
    ld hl, wGameMode
    ld a, $05
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld a, $02
    ld [wLinkSession], a
    jr Jump_01B_433F

Jump_01B_42C3::
    ld a, $69
    call QueueSoundEffect
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $01
    ld [wLinkMode], a
    ld hl, wGameMode
    ld a, $05
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $03
    ld [wLinkSession], a
    jr Jump_01B_433F

Jump_01B_42E2::
    ld a, $69
    call QueueSoundEffect
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $01
    ld [wLinkMode], a
    ld hl, wGameMode
    ld a, $05
    ld [hl+], a
    ld a, $07
    ld [hl+], a
    ld a, $08
    ld [wLinkSession], a
    jr Jump_01B_433F

Jump_01B_4301::
    ld a, $69
    call QueueSoundEffect
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $01
    ld [wLinkMode], a
    ld hl, wGameMode
    ld a, $05
    ld [hl+], a
    ld a, $04
    ld [hl+], a
    ld a, $04
    ld [wLinkSession], a
    jr Jump_01B_433F

Jump_01B_4320::
    ld a, $69
    call QueueSoundEffect
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $02
    ld [wLinkMode], a
    ld hl, wGameMode
    ld a, $05
    ld [hl+], a
    ld a, $06
    ld [hl+], a
    ld a, $06
    ld [wLinkSession], a
    jr Jump_01B_433F

Jump_01B_433F::
    xor a, a
    ld [wGameMode2State], a
    ld [wGameMode2Arg], a
    ld [wLinkExchangeState], a
    ld [wLinkStateByte], a
    ld [wLinkScreenStep], a
    ld a, $01
    ld [wModeChangeRequest], a
    call ClearSoundChannelSlots

Jump_01B_4357::
    ld a, $03
    ld [wLinkStatus], a
    ld a, $F8
    call SerialSendByte
    ret

; zeroes the first two bytes of each of six $20-byte sound channel slots from wSoundChannelSlots (E-0118)
; 1 call site from 1 routine (e.g. Func_01B_4001_Case00)
; writes: wSoundChannelSlots, wDC01, wDC20, wDC21, wDC40, wDC41, wDC60, wDC61, ...
ClearSoundChannelSlots::
Func_01B_4362:: ; address name
    xor a, a
    ld [wSoundChannelSlots], a
    ld [wDC01], a
    ld [wDC20], a
    ld [wDC21], a
    ld [wDC40], a
    ld [wDC41], a
    ld [wDC60], a
    ld [wDC61], a
    ld [wDC80], a
    ld [wDC81], a
    ld [wDCA0], a
    ld [wDCA1], a
    ret

; busy-waits $80 iterations (E-0122)
; 1 call site from 1 routine (e.g. Func_01B_4001_Case00)
ShortDelayLoop::
Func_01B_4388:: ; address name
    push bc
    ld bc, $0100

Jump_01B_438C::
    dec bc
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01B_438C
    pop bc
    ret

; A = 0 when the link state allows continuing (wD06B = 1 in mode 5 state 1 with wD06A and wD06C clear), else $FF; wD783 = A on entry (E-0125)
; 6 call sites from 1 routine (e.g. Func_01B_4001_Case00)
; reads: wLinkTimerLo, wD06B, wGameMode, wModeState, wD06A, wD06C
; writes: wD783
LinkCheckWD783State::
Func_01B_4394:: ; address name
    ld [wD783], a
    ld c, a
    ld a, [wLinkTimerLo]
    cp a, c
    jr nz, Jump_01B_43A7
    ld a, [wD06B]
    cp a, $01
    jr z, Jump_01B_43A7
    jr Jump_01B_43CC

Jump_01B_43A7::
    ld a, [wGameMode]
    cp a, $05
    jr nz, Jump_01B_43CC
    ld a, [wModeState]
    cp a, $01
    jr nz, Jump_01B_43CC
    ld a, [wD06A]
    or a, a
    jr nz, Jump_01B_43CC
    ld a, [wD06C]
    or a, a
    jr nz, Jump_01B_43CC
    ld a, [wD06B]
    cp a, $01
    jr z, Jump_01B_43CA
    jr Jump_01B_43CC

Jump_01B_43CA::
    xor a, a
    ret

Jump_01B_43CC::
    ld a, $FF
    ret

; sends the byte at Data_01B_43E1 + (wC471 & $0F) through SerialSendByte (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuOption
SendLinkByteForWC471_Bank1B:: ; heuristic: follows a terminator; C0
Func_01B_43CF:: ; address name
    ld a, [wMenuOption]
    ld de, Data_01B_43E1
    and a, $0F
    add a, e
    ld e, a
    jr nc, Jump_01B_43DC
    inc d

Jump_01B_43DC::
    ld a, [de]
    call SerialSendByte
    ret

Data_01B_43E1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $F4, $F4, $FA, $FB, $FC, $DD, $E1, $F3

; entry 1 of the `rst $00` table in Func_01B_4001
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole
Func_01B_4001_Case01::
Jump_01B_43E9:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_01B_43F9
    ld a, [wLinkRole]
    bit 0, a
    jr z, Jump_01B_43F9
    call RunWC582State

Jump_01B_43F9::
    ret

; runs the routine for wC582 (jump table of two) (E-0122)
; 1 call site from 1 routine (e.g. Func_01B_4001_Case01)
; reads: wLinkExchangeState
RunWC582State::
Func_01B_43FA:: ; address name
    ld a, [wLinkExchangeState]
    rst $00
    dw RunWC582State_Case00
    dw RunWC582State_Case01

; entry 0 of the `rst $00` table in RunWC582State
; no direct call (reached through a table, a jump or a vector)
RunWC582State_Case00::
Jump_01B_4402:: ; address name
    call LinkSendStepWithBuffer
    ret

; entry 1 of the `rst $00` table in RunWC582State
; no direct call (reached through a table, a jump or a vector)
; points at: wVBlankFlags
RunWC582State_Case01::
Jump_01B_4406:: ; address name
    call LinkReceiveStepWithBuffer
    ld hl, wVBlankFlags
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call RunFrameTickFadeAndCounter_Bank1B
    farcall RunBattlePhase
    ld hl, wVBlankFlags
    res 1, [hl]
    ret

; entry 2 of the `rst $00` table in Func_01B_4001
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole
Func_01B_4001_Case02::
Jump_01B_4420:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_01B_4430
    ld a, [wLinkRole]
    bit 0, a
    jr z, Jump_01B_4430
    call RunWC582State_4431

Jump_01B_4430::
    ret

; runs the routine for wC582 (jump table of two) (E-0122)
; 1 call site from 1 routine (e.g. Func_01B_4001_Case02)
; reads: wLinkExchangeState
RunWC582State_4431::
Func_01B_4431:: ; address name
    ld a, [wLinkExchangeState]
    rst $00
    dw RunWC582State_4431_Case00
    dw RunWC582State_4431_Case01

; entry 0 of the `rst $00` table in RunWC582State_4431
; no direct call (reached through a table, a jump or a vector)
RunWC582State_4431_Case00::
Jump_01B_4439:: ; address name
    call LinkSendStepWithBuffer
    ret

; entry 1 of the `rst $00` table in RunWC582State_4431
; no direct call (reached through a table, a jump or a vector)
; points at: wVBlankFlags
RunWC582State_4431_Case01::
Jump_01B_443D:: ; address name
    call LinkReceiveStepWithBuffer
    ld hl, wVBlankFlags
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call RunFrameTickFadeAndCounter_Bank1B
    farcall RunWD780StateWhenNotFading_F1
    ld hl, wVBlankFlags
    res 1, [hl]
    ret

; entry 3 of the `rst $00` table in Func_01B_4001
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole
Func_01B_4001_Case03::
Jump_01B_4457:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_01B_4467
    ld a, [wLinkRole]
    bit 0, a
    jr z, Jump_01B_4467
    call RunWC582State_4468

Jump_01B_4467::
    ret

; runs the routine for wC582 (jump table of two) (E-0122)
; 1 call site from 1 routine (e.g. Func_01B_4001_Case03)
; reads: wLinkExchangeState
RunWC582State_4468::
Func_01B_4468:: ; address name
    ld a, [wLinkExchangeState]
    rst $00
    dw RunWC582State_4468_Case00
    dw RunWC582State_4468_Case01

; entry 0 of the `rst $00` table in RunWC582State_4468
; no direct call (reached through a table, a jump or a vector)
RunWC582State_4468_Case00::
Jump_01B_4470:: ; address name
    call LinkSendStepWithBuffer
    ret

; entry 1 of the `rst $00` table in RunWC582State_4468
; no direct call (reached through a table, a jump or a vector)
; points at: wVBlankFlags
RunWC582State_4468_Case01::
Jump_01B_4474:: ; address name
    call LinkReceiveStepWithBuffer
    ld hl, wVBlankFlags
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call RunFrameTickFadeAndCounter_Bank1B
    farcall RunWD780StateWhenNotFading_1B
    ld hl, wVBlankFlags
    res 1, [hl]
    ret

; entry 4 of the `rst $00` table in Func_01B_4001
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole
Func_01B_4001_Case04::
Jump_01B_448E:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_01B_449E
    ld a, [wLinkRole]
    bit 0, a
    jr z, Jump_01B_449E
    call RunWC582State_449F

Jump_01B_449E::
    ret

; runs the routine for wC582 (jump table of two) (E-0122)
; 1 call site from 1 routine (e.g. Func_01B_4001_Case04)
; reads: wLinkExchangeState
RunWC582State_449F::
Func_01B_449F:: ; address name
    ld a, [wLinkExchangeState]
    rst $00
    dw RunWC582State_449F_Case00
    dw RunWC582State_449F_Case01

; entry 0 of the `rst $00` table in RunWC582State_449F
; no direct call (reached through a table, a jump or a vector)
RunWC582State_449F_Case00::
Jump_01B_44A7:: ; address name
    call LinkSendStepWithBuffer
    ret

; entry 1 of the `rst $00` table in RunWC582State_449F
; no direct call (reached through a table, a jump or a vector)
; points at: wVBlankFlags
RunWC582State_449F_Case01::
Jump_01B_44AB:: ; address name
    call LinkReceiveStepWithBuffer
    ld hl, wVBlankFlags
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call RunFrameTickFadeAndCounter_Bank1B
    farcall RunWD06AState_6C12
    ld hl, wVBlankFlags
    res 1, [hl]
    ret

; entry 5 of the `rst $00` table in Func_01B_4001
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole
Func_01B_4001_Case05::
Jump_01B_44C5:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_01B_44D5
    ld a, [wLinkRole]
    bit 0, a
    jr z, Jump_01B_44D5
    call RunWC582State_44D6

Jump_01B_44D5::
    ret

; runs the routine for wC582 (jump table of two) (E-0122)
; 1 call site from 1 routine (e.g. Func_01B_4001_Case05)
; reads: wLinkExchangeState
RunWC582State_44D6::
Func_01B_44D6:: ; address name
    ld a, [wLinkExchangeState]
    rst $00
    dw RunWC582State_44D6_Case00
    dw RunWC582State_44D6_Case01

; entry 0 of the `rst $00` table in RunWC582State_44D6
; no direct call (reached through a table, a jump or a vector)
RunWC582State_44D6_Case00::
Jump_01B_44DE:: ; address name
    call LinkSendStepWithBuffer
    ret

; entry 1 of the `rst $00` table in RunWC582State_44D6
; no direct call (reached through a table, a jump or a vector)
; points at: wVBlankFlags
RunWC582State_44D6_Case01::
Jump_01B_44E2:: ; address name
    call LinkReceiveStepWithBuffer
    ld hl, wVBlankFlags
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call RunFrameTickFadeAndCounter_Bank1B
    farcall RunWC582State_44D6_Case01_Sub01
    ld hl, wVBlankFlags
    res 1, [hl]
    ret

; entry 6 of the `rst $00` table in Func_01B_4001
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole
Func_01B_4001_Case06::
Jump_01B_44FC:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_01B_450C
    ld a, [wLinkRole]
    bit 0, a
    jr z, Jump_01B_450C
    call RunWC582State_450D

Jump_01B_450C::
    ret

; runs the routine for wC582 (jump table of two) (E-0122)
; 1 call site from 1 routine (e.g. Func_01B_4001_Case06)
; reads: wLinkExchangeState
RunWC582State_450D::
Func_01B_450D:: ; address name
    ld a, [wLinkExchangeState]
    rst $00
    dw RunWC582State_450D_Case00
    dw RunWC582State_450D_Case01

; entry 0 of the `rst $00` table in RunWC582State_450D
; no direct call (reached through a table, a jump or a vector)
RunWC582State_450D_Case00::
Jump_01B_4515:: ; address name
    call LinkSendStepWithBuffer
    ret

; entry 1 of the `rst $00` table in RunWC582State_450D
; no direct call (reached through a table, a jump or a vector)
; points at: wVBlankFlags
RunWC582State_450D_Case01::
Jump_01B_4519:: ; address name
    call LinkReceiveStepWithBuffer
    ld hl, wVBlankFlags
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call RunFrameTickFadeAndCounter_Bank1B
    farcall RunWC582State_450D_Case01_Sub01
    ld hl, wVBlankFlags
    res 1, [hl]
    ret

; entry 7 of the `rst $00` table in Func_01B_4001
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole
Func_01B_4001_Case07::
Jump_01B_4533:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_01B_4543
    ld a, [wLinkRole]
    bit 0, a
    jr z, Jump_01B_4543
    call RunWC582State_4544

Jump_01B_4543::
    ret

; runs the routine for wC582 (jump table of two) (E-0122)
; 1 call site from 1 routine (e.g. Func_01B_4001_Case07)
; reads: wLinkExchangeState
RunWC582State_4544::
Func_01B_4544:: ; address name
    ld a, [wLinkExchangeState]
    rst $00
    dw RunWC582State_4544_Case00
    dw RunWC582State_4544_Case01

; entry 0 of the `rst $00` table in RunWC582State_4544
; no direct call (reached through a table, a jump or a vector)
RunWC582State_4544_Case00::
Jump_01B_454C:: ; address name
    call LinkSendStepWithBuffer
    ret

; entry 1 of the `rst $00` table in RunWC582State_4544
; no direct call (reached through a table, a jump or a vector)
; points at: wVBlankFlags
RunWC582State_4544_Case01::
Jump_01B_4550:: ; address name
    call LinkReceiveStepWithBuffer
    ld hl, wVBlankFlags
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call RunFrameTickFadeAndCounter_Bank1B
    farcall RunBattlePhaseWhenTextIdle_A0
    ld hl, wVBlankFlags
    res 1, [hl]
    ret

; entry 8 of the `rst $00` table in Func_01B_4001
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole
Func_01B_4001_Case08::
Jump_01B_456A:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_01B_457A
    ld a, [wLinkRole]
    bit 0, a
    jr z, Jump_01B_457A
    call RunWC582State_457B

Jump_01B_457A::
    ret

; runs the routine for wC582 (jump table of two) (E-0122)
; 1 call site from 1 routine (e.g. Func_01B_4001_Case08)
; reads: wLinkExchangeState
RunWC582State_457B::
Func_01B_457B:: ; address name
    ld a, [wLinkExchangeState]
    rst $00
    dw RunWC582State_457B_Case00
    dw RunWC582State_457B_Case01

; entry 0 of the `rst $00` table in RunWC582State_457B
; no direct call (reached through a table, a jump or a vector)
RunWC582State_457B_Case00::
Jump_01B_4583:: ; address name
    call LinkSendStepWithBuffer
    ret

; entry 1 of the `rst $00` table in RunWC582State_457B
; no direct call (reached through a table, a jump or a vector)
; points at: wVBlankFlags
RunWC582State_457B_Case01::
Jump_01B_4587:: ; address name
    call LinkReceiveStepWithBuffer
    ld hl, wVBlankFlags
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call RunFrameTickFadeAndCounter_Bank1B
    farcall RunWC582State_457B_Case01_Sub01
    ld hl, wVBlankFlags
    res 1, [hl]
    ret

; link: sends $F9 when not connected; otherwise reads the received byte into wC560, polls the joypad and starts sending wJoypadHeld; with bit 1 of wC5ED sends $F3 (E-0125)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRole, wVBlankFlags, rSB, wLinkJoypadHeld, wSerialReceived, wJoypadHeld
; writes: wLinkExchangeState, wSerialReceived, wLinkJoypadHeldPrev, wLinkJoypadHeld
; points at: wVBlankFlags
LinkExchangeJoypadByte:: ; heuristic: follows a terminator; C0
Func_01B_45A1:: ; address name
    ld a, [wLinkRole]
    bit 1, a
    jr nz, Jump_01B_45B2
    ld a, $01
    ld [wLinkExchangeState], a
    ld a, $F9
    jp SerialSendByte

Jump_01B_45B2::
    ld a, [wVBlankFlags]
    bit 1, a
    jr nz, Jump_01B_45DB
    ldh a, [rSB]
    ld [wSerialReceived], a
    ld a, [wLinkJoypadHeld]
    ld [wLinkJoypadHeldPrev], a
    ld a, [wSerialReceived]
    ld [wLinkJoypadHeld], a
    call PollJoypad
    call UpdateJoypadPresses
    ld a, $01
    ld [wLinkExchangeState], a
    ld a, [wJoypadHeld]
    jp StartSerialTransferInternalClock

Jump_01B_45DB::
    ld a, $20

Jump_01B_45DD::
    dec a
    jr nz, Jump_01B_45DD
    ld hl, wVBlankFlags
    set 2, [hl]
    ld a, $01
    ld [wLinkExchangeState], a
    ld a, $F3
    jp StartSerialTransferInternalClock

; link: reads the received byte into wC560 and updates the joypad state; byte $F3 restores the saved joypad state and counts down wC595 (E-0127)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRole, wLinkReady, rSB, wLinkJoypadHeld, wSerialReceived, wLinkSavedJoypadHeld, wLinkSavedJoypadHeldPrev, wLinkSendByte, ...
; writes: wSerialReceived, wLinkJoypadHeldPrev, wLinkJoypadHeld, wLinkExchangeState, wJoypadHeld, wJoypadHeldPrev, wLinkTimeoutLo, wLinkTimeoutHi
; points at: wVBlankFlags
LinkReceiveJoypadByte:: ; heuristic: follows a terminator; C0
Func_01B_45EF:: ; address name
    ld a, [wLinkRole]
    bit 1, a
    jr nz, LinkHandshakeSendFAOrFB
    ld a, [wLinkReady]
    or a, a
    jr nz, Jump_01B_4608
    ldh a, [rSB]
    ld [wSerialReceived], a
    cp a, $F3
    jp z, Jump_01B_462E
    jr Jump_01B_460D

Jump_01B_4608::
    ldh a, [rSB]
    ld [wSerialReceived], a

Jump_01B_460D::
    ld hl, wVBlankFlags
    set 1, [hl]
    ld a, [wLinkJoypadHeld]
    ld [wLinkJoypadHeldPrev], a
    ld a, [wSerialReceived]
    ld [wLinkJoypadHeld], a
    call UpdateJoypadPresses
    call RunFrameTickFadeAndCounter_Bank1B
    xor a, a
    ld [wLinkExchangeState], a
    ld hl, wVBlankFlags
    res 1, [hl]
    ret

Jump_01B_462E::
    ld a, [wLinkSavedJoypadHeld]
    ld [wJoypadHeld], a
    ld a, [wLinkSavedJoypadHeldPrev]
    ld [wJoypadHeldPrev], a
    ld a, [wLinkSendByte]
    cp a, $FF
    jr nz, Jump_01B_4651
    ld a, [wLinkTimeoutLo]
    sub a, $01
    ld [wLinkTimeoutLo], a
    ld a, [wLinkTimeoutHi]
    sbc a, $00
    ld [wLinkTimeoutHi], a

Jump_01B_4651::
    xor a, a
    ld [wLinkExchangeState], a
    ld hl, wVBlankFlags
    set 7, [hl]
    ret

; link: with bit 2 of wC5ED clear sends $FA and runs a frame; otherwise clears it, sends $FB and sets bit 7 (E-0124)
; no direct call (reached through a table, a jump or a vector)
; writes: wLinkExchangeState
; points at: wVBlankFlags
LinkHandshakeSendFAOrFB:: ; heuristic: follows a terminator; C0
Func_01B_465B:: ; address name
    ld hl, wVBlankFlags
    bit 2, [hl]
    jr nz, Jump_01B_4676
    set 1, [hl]
    xor a, a
    ld [wLinkExchangeState], a
    ld a, $FA
    call SerialSendByte
    call RunFrameTickFadeAndCounter_Bank1B
    ld hl, wVBlankFlags
    res 1, [hl]
    ret

Jump_01B_4676::
    ld hl, wVBlankFlags
    res 2, [hl]
    xor a, a
    ld [wLinkExchangeState], a
    ld a, $FB
    call SerialSendByte
    ld hl, wVBlankFlags
    set 7, [hl]
    ret

; link: sends $F9 when not connected; otherwise reads the received byte, polls the joypad and sends the queued byte or the next byte of the transfer buffer wC590 (E-0128)
; 8 call sites from 8 routines (e.g. RunWC582State_Case00, RunWC582State_4431_Case00, RunWC582State_4468_Case00, RunWC582State_449F_Case00, ...)
; reads: wLinkRole, wVBlankFlags, wLinkSendByte, rSB, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkBufferCountLo, wLinkBufferCountHi, ...
; writes: wLinkExchangeState, wSerialReceived, wLinkMessage, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkBufferCountLo, wLinkBufferCountHi, wLinkTimeoutLo, ...
; points at: wLinkBufferCountLo, wVBlankFlags
LinkSendStepWithBuffer::
Func_01B_468A:: ; address name
    ld a, [wLinkRole]
    bit 1, a
    jr nz, Jump_01B_469B
    ld a, $01
    ld [wLinkExchangeState], a
    ld a, $F9
    jp SerialSendByte

Jump_01B_469B::
    ld a, [wVBlankFlags]
    bit 1, a
    jp nz, Jump_01B_45DB
    ld a, [wLinkSendByte]
    cp a, $FF
    jr z, Jump_01B_46C3
    ldh a, [rSB]
    ld [wSerialReceived], a
    ld [wLinkMessage], a
    call PollJoypad
    call UpdateJoypadPresses
    ld a, $01
    ld [wLinkExchangeState], a
    ld a, [wLinkSendByte]
    jp StartSerialTransferInternalClock

Jump_01B_46C3::
    ld hl, wLinkBufferCountLo
    ld a, [hl+]
    or a, [hl]
    jr z, Jump_01B_471E
    ld a, [wLinkBufferPtrLo]
    ld l, a
    ld a, [wLinkBufferPtrHi]
    ld h, a
    ldh a, [rSB]
    ld [hl], a
    call PollJoypad
    call UpdateJoypadPresses
    ld a, [wLinkBufferPtrLo]
    add a, $01
    ld [wLinkBufferPtrLo], a
    ld a, [wLinkBufferPtrHi]
    adc a, $00
    ld [wLinkBufferPtrHi], a
    ld a, [wLinkBufferCountLo]
    sub a, $01
    ld [wLinkBufferCountLo], a
    ld a, [wLinkBufferCountHi]
    sbc a, $00
    ld [wLinkBufferCountHi], a
    ld a, [wLinkTimeoutLo]
    ld l, a
    ld a, [wLinkTimeoutHi]
    ld h, a
    push hl
    ld a, [wLinkTimeoutLo]
    add a, $01
    ld [wLinkTimeoutLo], a
    ld a, [wLinkTimeoutHi]
    adc a, $00
    ld [wLinkTimeoutHi], a
    pop hl
    ld a, $01
    ld [wLinkExchangeState], a
    ld a, [hl]
    jp StartSerialTransferInternalClock

Jump_01B_471E::
    ld a, $01
    ld [wLinkExchangeState], a
    ldh a, [rSB]
    ld [wSerialReceived], a
    ld [wLinkMessage], a
    call PollJoypad
    call UpdateJoypadPresses
    ld a, $F0
    jp StartSerialTransferInternalClock

; link: reads the received byte; stores it in the transfer buffer wC590 while bytes remain, else as the remote joypad; handles the $F3 resync (E-0128)
; 8 call sites from 8 routines (e.g. RunWC582State_Case01, RunWC582State_4431_Case01, RunWC582State_4468_Case01, RunWC582State_449F_Case01, ...)
; reads: wLinkRole, wLinkReady, rSB, wLinkSendByte, wSerialReceived, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkBufferCountLo, ...
; writes: wSerialReceived, wLinkMessage, wLinkExchangeState, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkBufferCountLo, wLinkBufferCountHi, wJoypadHeld, ...
; points at: wVBlankFlags, wLinkBufferCountLo
LinkReceiveStepWithBuffer::
Func_01B_4736:: ; address name
    ld a, [wLinkRole]
    bit 1, a
    jr nz, Jump_01B_47B6
    ld a, [wLinkReady]
    or a, a
    jr nz, Jump_01B_474F
    ldh a, [rSB]
    ld [wSerialReceived], a
    cp a, $F3
    jp z, Jump_01B_462E
    jr Jump_01B_4754

Jump_01B_474F::
    ldh a, [rSB]
    ld [wSerialReceived], a

Jump_01B_4754::
    ld hl, wVBlankFlags
    set 1, [hl]
    ld a, [wLinkSendByte]
    cp a, $FF
    jr z, Jump_01B_476E
    ld a, [wSerialReceived]
    ld [wLinkMessage], a
    call UpdateJoypadPresses
    xor a, a
    ld [wLinkExchangeState], a
    ret

Jump_01B_476E::
    ld hl, wLinkBufferCountLo
    ld a, [hl+]
    or a, [hl]
    jr z, Jump_01B_47A8
    ld a, [wLinkBufferPtrLo]
    ld l, a
    ld a, [wLinkBufferPtrHi]
    ld h, a
    ldh a, [rSB]
    ld [hl], a
    call UpdateJoypadPresses
    ld a, [wLinkBufferPtrLo]
    add a, $01
    ld [wLinkBufferPtrLo], a
    ld a, [wLinkBufferPtrHi]
    adc a, $00
    ld [wLinkBufferPtrHi], a
    ld a, [wLinkBufferCountLo]
    sub a, $01
    ld [wLinkBufferCountLo], a
    ld a, [wLinkBufferCountHi]
    sbc a, $00
    ld [wLinkBufferCountHi], a
    xor a, a
    ld [wLinkExchangeState], a
    ret

Jump_01B_47A8::
    ld a, [wSerialReceived]
    ld [wLinkMessage], a
    call UpdateJoypadPresses
    xor a, a
    ld [wLinkExchangeState], a
    ret

Jump_01B_47B6::
    ld hl, wVBlankFlags
    bit 2, [hl]
    jp nz, Jump_01B_4676
    set 1, [hl]
    xor a, a
    ld [wLinkExchangeState], a
    ld a, $FA
    call SerialSendByte
    ret

; calls Func_000_2620 when wC52B is non-zero, then StepFade; adds 1 to the 16-bit wFrameCounterLo/Hi and clears wC58D and wC58E (E-0073)
; 10 call sites from 10 routines (e.g. RunWC582State_Case01, RunWC582State_4431_Case01, RunWC582State_4468_Case01, RunWC582State_449F_Case01, ...)
; reads: wTextFlags, wFrameCounterLo, wFrameCounterHi
; writes: wFrameCounterLo, wFrameCounterHi, wLinkFrameCounterLo, wLinkFrameCounterHi
RunFrameTickFadeAndCounter_Bank1B::
Func_01B_47CA:: ; address name
    ld a, [wTextFlags]
    or a, a
    jr z, Jump_01B_47D3
    call StepStringDisplayUntilDone

Jump_01B_47D3::
    call StepFade
    ld a, [wFrameCounterLo]
    add a, $01
    ld [wFrameCounterLo], a
    ld a, [wFrameCounterHi]
    adc a, $00
    ld [wFrameCounterHi], a
    xor a, a
    ld [wLinkFrameCounterLo], a
    ld [wLinkFrameCounterHi], a
    ret

; while a serial transfer is in progress (bit 7 of rSC), counts wD783/wD784 up; returns A = $FE once the count reaches $400, otherwise returns when the transfer ends (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: rSC, wD783, wD784
; writes: wD783, wD784
WaitSerialTransferWithTimeout:: ; heuristic: follows a terminator; C0
Func_01B_47EE:: ; address name
    ldh a, [rSC]
    bit 7, a
    jr nz, Jump_01B_47F5
    ret

Jump_01B_47F5::
    ld a, [wD783]
    add a, $01
    ld [wD783], a
    ld a, [wD784]
    adc a, $00
    ld [wD784], a
    cp a, $04
    jr c, WaitSerialTransferWithTimeout
    ld a, $FE
    ret

; ld de, this bank's string table / BeginStringDisplay
; 5 call sites from 5 routines (e.g. ShowString_Bank1B_481A, DebugMessageTest_Update_Case21, BeginString_Bank1B_Cat0, ShowStringA10_Bank1B, ...)
BeginStringDisplay_Bank1B_480C::
Func_01B_480C:: ; address name
    ld de, Data_01B_4821
    call BeginStringDisplay
    ret
    db $11, $21, $48, $CD, $FE, $25, $C9

; Func_01B_480C (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 12 call sites from 10 routines (e.g. RunWD780StateWhenNotFading_1B_Case01_Case00, RunWD780StateWhenNotFading_1B_Case01_Case12_Sub01, ScriptCommandEF_Run_Bank1B_Case04_Case09, ScriptCommandEF_Run_Bank1B_Case05_Case06, ...)
ShowString_Bank1B_481A::
Func_01B_481A:: ; address name
    call BeginStringDisplay_Bank1B_480C
    call RunStringDisplayToEnd
    ret

Data_01B_4821:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_01B_4823

Data_01B_4823:: ; heuristic: target of a monotone pointer table; C0
    dw Data_01B_4873
    dw Data_01B_4873
    dw Data_01B_4889
    dw Data_01B_48A6
    dw Data_01B_48C8
    dw Data_01B_48E4
    dw Data_01B_4900
    dw Data_01B_4920
    dw Data_01B_492D
    dw Data_01B_494C
    dw Data_01B_4964
    dw Data_01B_4984
    dw Data_01B_49A1
    dw Data_01B_49BB
    dw Data_01B_49E1
    dw Data_01B_49EB
    dw Data_01B_4A09
    dw Data_01B_4A09
    dw Data_01B_4A2B
    dw Data_01B_4A41
    dw Data_01B_4A64
    dw Data_01B_4A7D
    dw Data_01B_4ABA
    dw Data_01B_4AD9
    dw Data_01B_4AEF
    dw Data_01B_4AFD
    dw Data_01B_4B0E
    dw Data_01B_4B25
    dw Data_01B_4B41
    dw Data_01B_4B4E
    dw Data_01B_4B4E
    dw Data_01B_4B59
    dw Data_01B_4B69
    dw Data_01B_4B75
    dw Data_01B_4BB4
    dw Data_01B_4BD2
    dw Data_01B_4C17
    dw Data_01B_4C3A
    dw Data_01B_4C4D
    dw Data_01B_4C83

Data_01B_4873:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Starting key", $F1
    db "trade", $A4, $FA, $F7
    db $F0

Data_01B_4889:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You refused to", $F1
    db "trade keys.", $FA, $F7
    db $F0

Data_01B_48A6:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Your pal refused", $F1
    db "to trade keys.", $FA, $F7
    db $F0

Data_01B_48C8:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Is it OK to trade", $F1
    db "this key?", $F0

Data_01B_48E4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "That key cannot be", $F1
    db "traded.", $F7
    db $F0

Data_01B_4900:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Please choose the", $F1
    db "key to trade.", $F0

Data_01B_4920:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Please wait.", $F0

Data_01B_492D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Keys can't have", $F1
    db "the same name.", $F7
    db $F0

Data_01B_494C:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Is it OK to trade", $F1
    db "keys?", $F0

Data_01B_4964:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Is it OK to record", $F1
    db "the results?", $F0

Data_01B_4984:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Readying trade", $A4, $F1
    db "Please wait.", $F0

Data_01B_49A1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Keys will now be", $F1
    db "traded.", $F7
    db $F0

Data_01B_49BB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Your pal has a key", $F1
    db "of the same name.", $F7
    db $F0

Data_01B_49E1:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "TradeExit", $F0

Data_01B_49EB:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You can't hold any", $F1
    db "more keys.", $F7
    db $F0

Data_01B_4A09:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Choose the members", $F1
    db "for VS battle.", $F0

Data_01B_4A2B:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pick ", $F9, "0 for the", $F1
    db "team?", $F0

Data_01B_4A41:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Choose one more", $F1
    db "member for battle?", $F0

Data_01B_4A64:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Will you put up a", $F1
    db "prize?", $F0

Data_01B_4A7D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You have no", $F1
    db "monsters on the", $FA, $F7
    db $EF, $EE, "farm to serve as", $EF, $EE, "the prize.", $F7
    db $F0

Data_01B_4ABA:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Select a monster", $F1
    db "as the prize.", $F0

Data_01B_4AD9:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Put up ", $F9, "0 as a", $F1
    db "prize?", $F0

Data_01B_4AEF:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Begin battle?", $F0

Data_01B_4AFD:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Starting battle", $A4, $F0

Data_01B_4B0E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You refused to", $F1
    db "battle.", $F0

Data_01B_4B25:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Your pal refused", $F1
    db "to battle.", $F0

Data_01B_4B41:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Please wait.", $F0

Data_01B_4B4E:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "InfoOKYesN", $F0

Data_01B_4B59:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BattlePrizeExit", $F0

Data_01B_4B69:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FightInfoEx", $F0

Data_01B_4B75:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Monster level", $F1
    db "limit exceeded.", $FA, $F7
    db $EF, $EE, "Pick another", $EF, $EE, "monster please.", $F0

Data_01B_4BB4:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "That family is not", $F1
    db "permitted.", $F0

Data_01B_4BD2:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You already chose", $F1
    db "from that family.", $FA, $F7
    db $EF, $EE, "Pick another", $EF, $EE, "monster please.", $F0

Data_01B_4C17:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "There is no prize", $F1
    db "for this battle.", $F0

Data_01B_4C3A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "There is no prize.", $F0

Data_01B_4C4D:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Your pal's key ring", $F1
    db "is full.", $FA, $F7
    db $EF, $EE, "Keys can't be", $EF, $EE, "traded.", $F7
    db $F0

Data_01B_4C83:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $00, $F0

; ld de, this bank's string table / BeginStringDisplay
; 4 call sites from 4 routines (e.g. ShowString_Bank1B_4C94, DebugMessageTest_Update_Case16, ScriptCommandED_Run_Case04_Case2C, ScriptCommandED_Run_Case04_Case36)
BeginStringDisplay_Bank1B_4C86::
Func_01B_4C86:: ; address name
    ld de, Data_01B_4C9B
    call BeginStringDisplay
    ret
    db $11, $9B, $4C, $CD, $FE, $25, $C9

; Func_01B_4C86 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 3 call sites from 3 routines (e.g. DebugResultsDisplay_Init, ScriptCommandED_Run_Case0F_Case07, ShowSaveFileInfoWindow)
ShowString_Bank1B_4C94::
Func_01B_4C94:: ; address name
    call BeginStringDisplay_Bank1B_4C86
    call RunStringDisplayToEnd
    ret

Data_01B_4C9B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_01B_4C9D

Data_01B_4C9D:: ; heuristic: target of a monotone pointer table; C0
    dw Data_01B_4CF1
    dw Data_01B_4CF1
    dw Data_01B_4D12
    dw Data_01B_4D35
    dw Data_01B_4D52
    dw Data_01B_4D6D
    dw Data_01B_4D93
    dw Data_01B_4DB8
    dw Data_01B_4DD6
    dw Data_01B_4DF4
    dw Data_01B_4E17
    dw Data_01B_4E39
    dw Data_01B_4E5B
    dw Data_01B_4E7D
    dw Data_01B_4E9E
    dw Data_01B_4EB9
    dw Data_01B_4EF2
    dw Data_01B_4F13
    dw Data_01B_4F33
    dw Data_01B_4F71
    dw Data_01B_4F93
    dw Data_01B_4FB1
    dw Data_01B_4FD2
    dw Data_01B_4FF5
    dw Data_01B_5018
    dw Data_01B_5039
    dw Data_01B_5056
    dw Data_01B_5073
    dw Data_01B_508E
    dw Data_01B_50B0
    dw Data_01B_50CF
    dw Data_01B_50EA
    dw Data_01B_50EA
    dw Data_01B_5105
    dw Data_01B_5125
    dw Data_01B_5125
    dw Data_01B_5125
    dw Data_01B_5132
    dw Data_01B_5143
    dw Data_01B_515A
    dw Data_01B_517A
    dw Data_01B_5190

Data_01B_4CF1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Welcome. What", $F1
    db "would you like?", $F0

Data_01B_4D12:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Which will be", $F1
    db "the base monster?", $F0

Data_01B_4D35:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This is the one", $F1
    db "you want?", $F0

Data_01B_4D52:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Is there", $F1
    db "anything else?", $F0

Data_01B_4D6D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You won't have a", $F1
    db "monster with you!", $F7
    db $F0

Data_01B_4D93:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That's too low", $F1
    db "in level to breed.", $F7
    db $F0

Data_01B_4DB8:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " And what will", $F1
    db "its mate be?", $F0

Data_01B_4DD6:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " There's no", $F1
    db "potential mate.", $F7
    db $F0

Data_01B_4DF4:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $F9, "0", $F1
    db "will result from", $FA, $F7
    db $EF, $EE, "this.", $EF, $EE, $F7
    db $F0

Data_01B_4E17:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " A great monster", $F1
    db "will be born!", $F7
    db $F0

Data_01B_4E39:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You already had", $F1
    db "that monster.", $F7
    db $F0

Data_01B_4E5B:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You", $42, "e never had", $F1
    db "that monster.", $F7
    db $F0

Data_01B_4E7D:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " OK to record in", $F1
    db "your Journal?", $F0

Data_01B_4E9E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Fine, fine!", $F1
    db "I'll do it!", $F7
    db $F0

Data_01B_4EB9:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hatching that", $F1
    db "will cost ", $F9, "0G.", $FA, $F7
    db $F2, "Should I hatch it", $F1
    db "too?", $F0

Data_01B_4EF2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'll hatch the", $F1
    db "egg too, then.", $F7
    db $F0

Data_01B_4F13:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I won't hatch", $F1
    db "the egg, then.", $F7
    db $F0

Data_01B_4F33:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You don't have", $F1
    db "enough gold, so", $FA, $F7
    db $F2, "I'll just do the", $F1
    db "breeding.", $F7
    db $F0

Data_01B_4F71:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'll send the", $F1
    db "egg to the farm.", $F7
    db $F0

Data_01B_4F93:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Will you take", $F1
    db $F9, "0 with you?", $F0

Data_01B_4FB1:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Raise it with", $F1
    db "love and care!", $F7
    db $F0

Data_01B_4FD2:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'll send ", $F9, "0", $F1
    db "to the farm, then.", $F7
    db $F0

Data_01B_4FF5:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Which will go", $F1
    db "back to the farm?", $F0

Data_01B_5018:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Is this the one", $F1
    db "to send home?", $F0

Data_01B_5039:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $F9, "0 is", $F1
    db "going to the farm.", $F7
    db $F0

Data_01B_5056:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Which egg should", $F1
    db "I hatch?", $F0

Data_01B_5073:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That will cost", $F1
    db $F9, "0G. OK?", $F0

Data_01B_508E:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " There isn't a", $F1
    db "single egg here.", $F7
    db $F0

Data_01B_50B0:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You don't have", $F1
    db "enough gold.", $F7
    db $F0

Data_01B_50CF:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " You got the egg", $F1
    db "of ", $F9, "0.", $F7
    db $F0

Data_01B_50EA:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Become a great", $F1
    db "master!", $F7
    db $F0

Data_01B_5105:: ; heuristic: target of a monotone pointer table; C0
    db $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Fine, fine.", $F1
    db "Just wait here.", $F7
    db $F0

Data_01B_5125:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 hatched!", $F7
    db $F0

Data_01B_5132:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Please name it.", $F7
    db $F0

Data_01B_5143:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 went", $F1
    db "away quietly", $A4, $F7
    db $F0

Data_01B_515A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RESULTS", $F1
    db "DISPLAY", $F1
    db $F1
    db "Species", $F1
    db "Gender", $F0

Data_01B_517A:: ; heuristic: target of a monotone pointer table; C0
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Unused.", $F0, "No save data.", $F0

Data_01B_5190:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $06D190, $21F

; on CGB copies the 8-byte palette Data_01B_53C6 into wBGPaletteBuffer and sets wC526 = $7F (E-0118)
; 2 call sites from 2 routines (e.g. GameMode6_Init, GameMode8_Init)
; reads: wIsCGB
; writes: wBGPaletteUploadRequest
; points at: wBGPaletteBuffer
LoadPalette0FromData53C6::
Func_01B_53AF:: ; address name
    ld a, [wIsCGB]
    or a, a
    ret z
    ld de, Data_01B_53C6
    ld hl, wBGPaletteBuffer
    ld bc, $0008
    call CopyBytesDEToHL_Bank00
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    ret

Data_01B_53C6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $4D, $5E, $FF, $7F, $F2, $66, $00, $00

; unless a fade is running, runs the routine for wD780 (jump table) (E-0122)
; 1 call site from 1 routine (e.g. RunWC582State_4468_Case01)
; reads: wFadeState, wD780
RunWD780StateWhenNotFading_1B::
Func_01B_53CE:: ; address name
    ld a, [wFadeState]
    and a, a
    ret nz
    ld a, [wD780]
    rst $00
    dw RunWD780StateWhenNotFading_1B_Case00
    dw RunWD780StateWhenNotFading_1B_Case01

; entry 0 of the `rst $00` table in RunWD780StateWhenNotFading_1B
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
RunWD780StateWhenNotFading_1B_Case00::
Jump_01B_53DB:: ; address name
    ld a, [wD781]
    rst $00
    dw RunWD780StateWhenNotFading_1B_Case00_Case00
    dw RunWD780StateWhenNotFading_1B_Case00_Case01
    dw RunWD780StateWhenNotFading_1B_Case00_Case02
    dw RunWD780StateWhenNotFading_1B_Case00_Case03
    dw RunWD780StateWhenNotFading_1B_Case00_Case04

; entry 0 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wD781
; writes: wD781
; points at: wScreenTileBuffer, wD1CC
RunWD780StateWhenNotFading_1B_Case00_Case00::
Jump_01B_53E9:: ; address name
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank1B
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01B_5407
    ld hl, wD1CC
    ld de, wRecordBufferData + $12
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank1B

Jump_01B_5407::
    ld de, Data_01F_4AD0
    ld hl, vTiles2 + $700
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4330
    ld hl, vTiles2 + $710
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 1 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781, wLinkSendByte
; points at: wD06A
RunWD780StateWhenNotFading_1B_Case00_Case01::
Jump_01B_5429:: ; address name
    ld a, $01
    call BeginString_Bank1B_Cat0
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wD06A
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD781
; writes: wD781
RunWD780StateWhenNotFading_1B_Case00_Case02::
Jump_01B_543E:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $07
    call BeginString_Bank1B_Cat0
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 3 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD781
; writes: wD781, wLinkSendByte
RunWD780StateWhenNotFading_1B_Case00_Case03::
Jump_01B_5450:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

; entry 4 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wD780
; writes: wLinkSendByte, wD781, wD780
RunWD780StateWhenNotFading_1B_Case00_Case04::
Jump_01B_5462:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, $06
    call BeginString_Bank1B_Cat0
    xor a, a
    ld [wD781], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; entry 1 of the `rst $00` table in RunWD780StateWhenNotFading_1B
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
RunWD780StateWhenNotFading_1B_Case01::
Jump_01B_547D:: ; address name
    ld a, [wD781]
    rst $00
    dw RunWD780StateWhenNotFading_1B_Case01_Case00
    dw RunWD780StateWhenNotFading_1B_Case01_Case01
    dw RunWD780StateWhenNotFading_1B_Case01_Case02
    dw RunWD780StateWhenNotFading_1B_Case01_Case03
    dw RunWD780StateWhenNotFading_1B_Case01_Case04
    dw RunWD780StateWhenNotFading_1B_Case01_Case05
    dw RunWD780StateWhenNotFading_1B_Case01_Case06
    dw RunWD780StateWhenNotFading_1B_Case01_Case07
    dw RunWD780StateWhenNotFading_1B_Case01_Case08
    dw RunWD780StateWhenNotFading_1B_Case01_Case09
    dw RunWD780StateWhenNotFading_1B_Case01_Case0A
    dw RunWD780StateWhenNotFading_1B_Case01_Case0B
    dw RunWD780StateWhenNotFading_1B_Case01_Case0C
    dw RunWD780StateWhenNotFading_1B_Case01_Case0D
    dw RunWD780StateWhenNotFading_1B_Case01_Case0E
    dw RunWD780StateWhenNotFading_1B_Case01_Case0F
    dw RunWD780StateWhenNotFading_1B_Case01_Case10
    dw RunWD780StateWhenNotFading_1B_Case01_Case11
    dw RunWD780StateWhenNotFading_1B_Case01_Case12
    dw RunWD780StateWhenNotFading_1B_Case01_Case13
    dw RunWD780StateWhenNotFading_1B_Case01_Case14
    dw RunWD780StateWhenNotFading_1B_Case01_Case07
    dw RunWD780StateWhenNotFading_1B_Case01_Case16
    dw RunWD780StateWhenNotFading_1B_Case01_Case17
    dw RunWD780StateWhenNotFading_1B_Case01_Case18
    dw RunWD780StateWhenNotFading_1B_Case01_Case0C
    dw RunWD780StateWhenNotFading_1B_Case01_Case0D
    dw RunWD780StateWhenNotFading_1B_Case01_Case1B
    dw RunWD780StateWhenNotFading_1B_Case01_Case1C
    dw RunWD780StateWhenNotFading_1B_Case01_Case1D
    dw RunWD780StateWhenNotFading_1B_Case01_Case1E
    dw RunWD780StateWhenNotFading_1B_Case01_Case1F
    dw RunWD780StateWhenNotFading_1B_Case01_Case20
    dw RunWD780StateWhenNotFading_1B_Case01_Case21
    dw RunWD780StateWhenNotFading_1B_Case01_Case22
    dw RunWD780StateWhenNotFading_1B_Case01_Case23
    dw RunWD780StateWhenNotFading_1B_Case01_Case24

; entry 0 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD781
; writes: wStringIndex, wStringCategory, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wD7AB, wD7AF, ...
RunWD780StateWhenNotFading_1B_Case01_Case00::
Jump_01B_54CB:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld de, Data_01B_6483
    ld hl, wWindowTileBuffer + $B4
    ld bc, $0F09
    call CopyRectTo20ByteRows
    farcall BuildKeyListIndexWD789
    ld a, $0E
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld hl, vTiles2 + $500
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0801
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank1B_481A
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    xor a, a
    ld [wD7AB], a
    ld [wD7AF], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 1 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wD781
RunWD780StateWhenNotFading_1B_Case01_Case01::
Jump_01B_5538:: ; address name
    ld hl, vTiles2 + $100
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1004
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, vTiles2 + $600
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1001
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 2 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B0, wD7AB, wD781
; writes: wD7F5, wD7F1, wD7F2, wD781
RunWD780StateWhenNotFading_1B_Case01_Case02::
Jump_01B_5588:: ; address name
    ld de, Data_01B_650A
    ld hl, wWindowTileBuffer + $C9
    ld bc, $0D07
    call CopyRectTo20ByteRows
    ld a, $02
    ld [wD7F5], a
    farcall ClampKeyListPageCursor
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_01B_55D4
    ld de, $0189
    call DrawC5BEC6AtScrollOffsetDE_Bank1B
    ld hl, wWindowTileBuffer + $15D
    call StoreC5BEC6AtHLStride2_Bank1B
    ld de, $018A
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    farcall DrawPageOfPagesAtScrollOffset
    ld hl, wWindowTileBuffer + $15E
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    farcall DrawPageOfPagesAtWD7F1_Bank1E

Jump_01B_55D4::
    ld a, [wD7AB]
    ld b, $BB
    ld hl, Data_01B_65DD
    call StoreBAtWordTableEntry_Bank1B
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 3 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F5, wD781
RunWD780StateWhenNotFading_1B_Case01_Case03::
Jump_01B_55F3:: ; address name
    ld a, $02
    ld [wD7F5], a
    farcall DrawKeyListPageNames
    ld a, $01
    ld [wD7F5], a
    farcall DrawKeyListPageMarks
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 4 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wD7AB, wD781
; writes: wD781
RunWD780StateWhenNotFading_1B_Case01_Case04::
Jump_01B_5611:: ; address name
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    ld a, [wD7AB]
    ld b, $C3
    ld hl, Data_01B_65DD
    call StoreBAtWordTableEntry_Bank1B
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 5 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wD781, wJoypadPressedRepeat, wMenuInputResult, wD7AB
; writes: wD781, wLinkSendByte, wMenuInputResult, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
RunWD780StateWhenNotFading_1B_Case01_Case05::
Jump_01B_5630:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_01B_5644
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $FD
    ld [wLinkSendByte], a
    ret

Jump_01B_5644::
    ld a, [wJoypadPressedRepeat]
    bit 2, a
    jr nz, Jump_01B_566C
    ld a, $05
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01B_5672
    cp a, $FC
    jr z, Jump_01B_5672
    cp a, $FE
    jr z, Jump_01B_567B
    cp a, $FF
    jr z, Jump_01B_5688
    ret

Jump_01B_566C::
    farcall ReturnStub_6333

Jump_01B_5672::
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

Jump_01B_567B::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_01B_5688::
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_01B_65DD
    call StoreBAtWordTableEntry_Bank1B
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $04
    call BeginString_Bank1B_Cat0
    ret

; entry 6 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wD782
RunWD780StateWhenNotFading_1B_Case01_Case06::
Jump_01B_56B7:: ; address name
    ld a, [wD782]
    rst $00
    dw RunWD780StateWhenNotFading_1B_Case01_Case06_Case00
    dw RunWD780StateWhenNotFading_1B_Case01_Case06_Case01
    dw RunWD780StateWhenNotFading_1B_Case01_Case06_Case02
    dw RunWD780StateWhenNotFading_1B_Case01_Case06_Case03
    dw RunWD780StateWhenNotFading_1B_Case01_Case06_Case04

; entry 0 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wLinkSendByte, wLinkRole, wD782
; writes: wLinkSendByte, wD782
RunWD780StateWhenNotFading_1B_Case01_Case06_Case00::
Jump_01B_56C5:: ; address name
    ld a, [wLinkMessage]
    cp a, $FD
    jr z, Jump_01B_56E3
    cp a, $FE
    ret nz
    ld a, [wLinkSendByte]
    cp a, $FD
    jr z, Jump_01B_56DF
    ld a, [wLinkRole]
    bit 1, a
    jr nz, Jump_01B_56DF
    jr Jump_01B_56E3

Jump_01B_56DF::
    ld b, $03
    jr Jump_01B_56E5

Jump_01B_56E3::
    ld b, $02

Jump_01B_56E5::
    xor a, a
    ld [wLinkSendByte], a
    ld a, b
    call BeginString_Bank1B_Cat0
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 1 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD782
; writes: wD782
RunWD780StateWhenNotFading_1B_Case01_Case06_Case01::
Jump_01B_56F5:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $07
    call BeginString_Bank1B_Cat0
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 2 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD782
; writes: wLinkSendByte, wD782
RunWD780StateWhenNotFading_1B_Case01_Case06_Case02::
Jump_01B_5707:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 3 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wD782
; writes: wLinkSendByte, wD782
RunWD780StateWhenNotFading_1B_Case01_Case06_Case03::
Jump_01B_5719:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 4 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wGameMode, wModeState, wModeChangeRequest
; points at: wD780
RunWD780StateWhenNotFading_1B_Case01_Case06_Case04::
Jump_01B_572B:: ; address name
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld hl, wD780
    ld bc, $006F

Jump_01B_5737::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01B_5737
    ld a, $05
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    ld a, $01
    ld [wModeChangeRequest], a
    ret

; entry 7 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD781
; writes: wTwoChoiceCursor, wD781
RunWD780StateWhenNotFading_1B_Case01_Case07::
Jump_01B_574E:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $6C
    call QueueSoundEffect
    ld de, Data_01B_65E9
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 8 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wMenuInputResult, wTwoChoiceCursor, wD781
; writes: wD781, wLinkSendByte, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
RunWD780StateWhenNotFading_1B_Case01_Case08::
Jump_01B_577C:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_01B_578E
    ld a, $06
    ld [wD781], a
    ld a, $FD
    ld [wLinkSendByte], a
    ret

Jump_01B_578E::
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_01B_57A2
    cp a, $FF
    jr z, Jump_01B_57C0
    ret

Jump_01B_57A2::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ret

Jump_01B_57C0::
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, Jump_01B_57A2
    ld a, [wD781]
    add a, $03
    ld [wD781], a
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ret

; entry 9 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
RunWD780StateWhenNotFading_1B_Case01_Case09::
Jump_01B_57E6:: ; address name
    call RunWD780StateWhenNotFading_1B_Shared01
    ld a, $06
    call BeginString_Bank1B_Cat0
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 10 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wD781
RunWD780StateWhenNotFading_1B_Case01_Case0A::
Jump_01B_57F6:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld c, $04
    ld hl, Data_01B_65DD
    call EraseCEntriesOfWordTable_Bank1B
    ld a, $05
    ld [wD781], a
    ret

; entry 11 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wD782
RunWD780StateWhenNotFading_1B_Case01_Case0B::
Jump_01B_5809:: ; address name
    ld a, [wD782]
    rst $00
    dw RunWD780StateWhenNotFading_1B_Case01_Case0B_Case00
    dw RunWD780StateWhenNotFading_1B_Case01_Case0B_Case01

; entry 1 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01_Case0B
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD781
; writes: wD782, wD781
RunWD780StateWhenNotFading_1B_Case01_Case0B_Case01::
Jump_01B_5811:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    sub a, $02
    ld [wD781], a
    ret

; entry 0 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01_Case0B
; no direct call (reached through a table, a jump or a vector)
; reads: wD782, hMapId, wD781, wMapType, wKeyWorldSlot
; writes: wD782, wD781
RunWD780StateWhenNotFading_1B_Case01_Case0B_Case00::
Jump_01B_5823:: ; address name
    call KeyEntryAddressForWD789Cell4
    push hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr z, Jump_01B_5850
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    and a, $0F
    cp a, $07
    jr nc, Jump_01B_5847
    pop hl

Jump_01B_583A::
    ld a, $05
    call BeginString_Bank1B_Cat0
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_01B_5847::
    pop hl
    ldh a, [hMapId]
    cp a, $A8
    jr c, Jump_01B_5864
    jr Jump_01B_5871

Jump_01B_5850::
    pop hl
    ld a, [wMapType]
    bit 7, a
    jr z, Jump_01B_5864
    ld a, [wKeyWorldSlot]
    ld b, a
    ld a, [hl]
    and a, $3F
    cp a, b
    jr nz, Jump_01B_5864
    jr Jump_01B_583A

Jump_01B_5864::
    ld a, $07
    call BeginString_Bank1B_Cat0
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_5871::
    ld b, $A8
    ld c, $B0
    cp a, c
    jr nc, Jump_01B_587A
    cp a, b
    ccf

Jump_01B_587A::
    jr c, Jump_01B_58B6
    ld b, $B0
    ld c, $B7
    cp a, c
    jr nc, Jump_01B_5885
    cp a, b
    ccf

Jump_01B_5885::
    jr c, Jump_01B_58BE
    ld b, $B8
    ld c, $C6
    cp a, c
    jr nc, Jump_01B_5890
    cp a, b
    ccf

Jump_01B_5890::
    jr c, Jump_01B_58C6
    ld b, $C8
    ld c, $D1
    cp a, c
    jr nc, Jump_01B_589B
    cp a, b
    ccf

Jump_01B_589B::
    jr c, Jump_01B_58CE
    ld b, $D1
    ld c, $DA
    cp a, c
    jr nc, Jump_01B_58A6
    cp a, b
    ccf

Jump_01B_58A6::
    jr c, Jump_01B_58D6
    ld b, $DA
    ld c, $E3
    cp a, c
    jr nc, Jump_01B_58B1
    cp a, b
    ccf

Jump_01B_58B1::
    jr c, Jump_01B_58DE
    jp Jump_01B_5864

Jump_01B_58B6::
    ld a, [hl]
    cp a, $07
    jr nz, Jump_01B_5864
    jp Jump_01B_583A

Jump_01B_58BE::
    ld a, [hl]
    cp a, $08
    jr nz, Jump_01B_5864
    jp Jump_01B_583A

Jump_01B_58C6::
    ld a, [hl]
    cp a, $09
    jr nz, Jump_01B_5864
    jp Jump_01B_583A

Jump_01B_58CE::
    ld a, [hl]
    cp a, $0A
    jr nz, Jump_01B_5864
    jp Jump_01B_583A

Jump_01B_58D6::
    ld a, [hl]
    cp a, $0B
    jr nz, Jump_01B_5864
    jp Jump_01B_583A

Jump_01B_58DE::
    ld a, [hl]
    cp a, $0C
    jr nz, Jump_01B_5864
    jp Jump_01B_583A

; entry 12 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD781
; writes: wD781, wLinkSendByte
RunWD780StateWhenNotFading_1B_Case01_Case0C::
Jump_01B_58E6:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

; entry 28 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD781
; writes: wLinkSendByte, wD781
RunWD780StateWhenNotFading_1B_Case01_Case1C::
Jump_01B_58F8:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld de, Data_01B_6607
    call DrawThreeTilesAtBGMap20FFromDE
    ld a, $02
    ld [wLinkSendByte], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 13 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wD781
; writes: wD781, wLinkSendByte
RunWD780StateWhenNotFading_1B_Case01_Case0D::
Jump_01B_5910:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    jr z, Jump_01B_5925
    cp a, $FE
    ret nz
    ld a, $06
    ld [wD781], a
    ld a, $FD
    ld [wLinkSendByte], a
    ret

Jump_01B_5925::
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 14 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781, wLinkBufferCountLo, wLinkBufferCountHi, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkSendByte, ...
; points at: wLinkRecvBuffer, wKeyList, wLinkPartnerName
RunWD780StateWhenNotFading_1B_Case01_Case0E::
Jump_01B_5931:: ; address name
    ld a, [wD781]
    inc a
    ld [wD781], a
    call KeyEntryAddressForWD789Cell4
    ld de, wLinkRecvBuffer
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    push de
    call WordAddressForWD789Cell4Item
    pop de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ld hl, $0006
    ld a, l
    ld [wLinkBufferCountLo], a
    ld a, h
    ld [wLinkBufferCountHi], a
    ld hl, wKeyList
    ld hl, wLinkRecvBuffer
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, wLinkPartnerName
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $FF
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; entry 35 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD781
; writes: wLinkSendByte, wD781
RunWD780StateWhenNotFading_1B_Case01_Case23::
Jump_01B_5983:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $05
    ld [wLinkSendByte], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 15 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wD781
; writes: wLinkSendByte, wLinkReady, wD781
RunWD780StateWhenNotFading_1B_Case01_Case0F::
Jump_01B_5995:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkReady], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 16 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781, wD7B4, wD782
RunWD780StateWhenNotFading_1B_Case01_Case10::
Jump_01B_59AB:: ; address name
    call RunWD780StateWhenNotFading_1B_Case01_Case10_Sub01
    cp a, $FF
    jr z, Jump_01B_59D7
    call RunWD780StateWhenNotFading_1B_Case01_Case10_Sub02
    ld a, c
    cp a, $14
    jr z, Jump_01B_59C6
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD7B4], a
    ret

Jump_01B_59C6::
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ld a, $FE
    ld [wD7B4], a
    ret

Jump_01B_59D7::
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ld a, $FF
    ld [wD7B4], a
    ret

; only called from RunWD780StateWhenNotFading_1B_Case01_Case10 (E-0047)
; 1 call site from 1 routine (e.g. RunWD780StateWhenNotFading_1B_Case01_Case10)
; reads: wRandomSeed2Lo, wLinkPartnerName, wLinkPartnerByte1, wLinkPartnerByte2
; points at: wKeyList, wLinkPartnerName
RunWD780StateWhenNotFading_1B_Case01_Case10_Sub01::
Func_01B_59E8:: ; address name
    ld hl, wKeyList
    ld de, wLinkPartnerName
    ld b, $20

Jump_01B_59F0::
    push hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_01B_5A33
    cp a, $FE
    jr z, Jump_01B_5A33
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr z, Jump_01B_5A19
    pop hl
    push hl
    ld a, [wRandomSeed2Lo]
    bit 7, a
    jr z, Jump_01B_5A33
    ld a, [hl]
    and a, $0F
    ld c, a
    ld a, [wLinkPartnerName]
    and a, $0F
    cp a, c
    jr nz, Jump_01B_5A33
    jr Jump_01B_5A3D

Jump_01B_5A19::
    pop hl
    push hl
    ld a, [wRandomSeed2Lo]
    bit 7, a
    jr nz, Jump_01B_5A33
    inc hl
    ld a, [hl+]
    ld c, a
    ld a, [wLinkPartnerByte1]
    cp a, c
    jr nz, Jump_01B_5A33
    ld a, [hl+]
    ld c, a
    ld a, [wLinkPartnerByte2]
    cp a, c
    jr nz, Jump_01B_5A33

Jump_01B_5A33::
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    dec b
    jr nz, Jump_01B_59F0
    xor a, a
    ret

Jump_01B_5A3D::
    pop hl
    ld a, $FF
    ret

; only called from RunWD780StateWhenNotFading_1B_Case01_Case10 (E-0047)
; 1 call site from 1 routine (e.g. RunWD780StateWhenNotFading_1B_Case01_Case10)
; reads: wRandomSeed2Lo
; points at: wKeyList
RunWD780StateWhenNotFading_1B_Case01_Case10_Sub02::
Func_01B_5A41:: ; address name
    ld hl, wKeyList
    ld b, $20
    ld c, $00

Jump_01B_5A48::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_01B_5A5C
    cp a, $FE
    jr z, Jump_01B_5A5B
    inc hl
    inc hl
    inc hl
    ld a, [hl-]
    dec hl
    dec hl
    bit 7, a
    jr nz, Jump_01B_5A5C

Jump_01B_5A5B::
    inc c

Jump_01B_5A5C::
    inc hl
    inc hl
    inc hl
    inc hl
    dec b
    jr nz, Jump_01B_5A48
    ld a, c
    cp a, $14
    ret c
    call KeyEntryAddressForWD789Cell4
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr nz, Jump_01B_5A7B
    ld a, [wRandomSeed2Lo]
    bit 7, a
    jr nz, Jump_01B_5A79

Jump_01B_5A79::
    dec c
    ret

Jump_01B_5A7B::
    ld a, [wRandomSeed2Lo]
    bit 7, a
    jr nz, Jump_01B_5A79
    ret

; entry 17 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wD782
RunWD780StateWhenNotFading_1B_Case01_Case11::
Jump_01B_5A83:: ; address name
    ld a, [wD782]
    rst $00
    dw RunWD780StateWhenNotFading_1B_Case01_Case11_Case00
    dw RunWD780StateWhenNotFading_1B_Case01_Case11_Case01
    dw RunWD780StateWhenNotFading_1B_Case01_Case11_Case02
    dw RunWD780StateWhenNotFading_1B_Case01_Case11_Case03
    dw RunWD780StateWhenNotFading_1B_Case01_Case11_Case04

; entry 0 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01_Case11
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B4, wD782
; writes: wLinkSendByte, wD782
RunWD780StateWhenNotFading_1B_Case01_Case11_Case00::
Jump_01B_5A91:: ; address name
    ld a, [wD7B4]
    and a, a
    jr z, Jump_01B_5AA3
    cp a, $FF
    jr z, Jump_01B_5A9F
    ld a, $04
    jr Jump_01B_5AA5

Jump_01B_5A9F::
    ld a, $03
    jr Jump_01B_5AA5

Jump_01B_5AA3::
    ld a, $02

Jump_01B_5AA5::
    ld [wLinkSendByte], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 1 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01_Case11
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wD782
; writes: wD7B5, wLinkSendByte, wD782
RunWD780StateWhenNotFading_1B_Case01_Case11_Case01::
Jump_01B_5AB0:: ; address name
    ld a, [wLinkMessage]
    cp a, $02
    jr z, Jump_01B_5AC0
    cp a, $03
    jr z, Jump_01B_5AC0
    cp a, $04
    jr z, Jump_01B_5AC0
    ret

Jump_01B_5AC0::
    ld [wD7B5], a
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 2 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01_Case11
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B5, wD7B4, wD781, wD782
; writes: wD782, wD781
RunWD780StateWhenNotFading_1B_Case01_Case11_Case02::
Jump_01B_5ACF:: ; address name
    ld a, [wD7B5]
    cp a, $03
    jr z, Jump_01B_5B07
    cp a, $04
    jr z, Jump_01B_5AF8
    ld a, [wD7B4]
    and a, a
    jr nz, Jump_01B_5AEC
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_5AEC::
    cp a, $FF
    jr z, Jump_01B_5AF4
    ld a, $0F
    jr Jump_01B_5B14

Jump_01B_5AF4::
    ld a, $08
    jr Jump_01B_5B14

Jump_01B_5AF8::
    ld a, [wD7B4]
    cp a, $FE
    jr z, Jump_01B_5B03
    ld a, $26
    jr Jump_01B_5B14

Jump_01B_5B03::
    ld a, $0F
    jr Jump_01B_5B14

Jump_01B_5B07::
    ld a, [wD7B4]
    cp a, $FF
    jr z, Jump_01B_5B12
    ld a, $0D
    jr Jump_01B_5B14

Jump_01B_5B12::
    ld a, $08

Jump_01B_5B14::
    call BeginString_Bank1B_Cat0
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 3 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01_Case11
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD782
; writes: wD782
RunWD780StateWhenNotFading_1B_Case01_Case11_Case03::
Jump_01B_5B1F:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 4 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01_Case11
; no direct call (reached through a table, a jump or a vector)
; writes: wD782, wD781
RunWD780StateWhenNotFading_1B_Case01_Case11_Case04::
Jump_01B_5B2C:: ; address name
    call RunWD780StateWhenNotFading_1B_Shared01
    ld a, $06
    call BeginString_Bank1B_Cat0
    xor a, a
    ld [wD782], a
    ld a, $0A
    ld [wD781], a
    ret

; entry 18 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
RunWD780StateWhenNotFading_1B_Case01_Case12::
Jump_01B_5B3E:: ; address name
    call RunWD780StateWhenNotFading_1B_Case01_Case12_Sub01
    ld de, Data_01B_6483
    ld hl, wWindowTileBuffer + $64
    ld bc, $0F01
    call CopyRectTo20ByteRows
    ld de, Data_01B_65CE
    ld hl, wWindowTileBuffer + $78
    ld bc, $0F01
    call CopyRectTo20ByteRows
    ld de, Data_01B_64FB
    ld hl, wWindowTileBuffer + $8C
    ld bc, $0F01
    call CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $09
    call BeginString_Bank1B_Cat0
    ret

; entry 19 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD781
; writes: wTwoChoiceCursor, wD781
RunWD780StateWhenNotFading_1B_Case01_Case13::
Jump_01B_5B7E:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $6C
    call QueueSoundEffect
    ld de, Data_01B_65A6
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 20 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wMenuInputResult, wTwoChoiceCursor, wD781
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wD781, wLinkSendByte
RunWD780StateWhenNotFading_1B_Case01_Case14::
Jump_01B_5BAC:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_01B_5BD4
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $06
    ld [wD781], a
    ld a, $FD
    ld [wLinkSendByte], a
    ret

Jump_01B_5BD4::
    call UpdateTwoChoiceCursor_Bank1B
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_01B_5BE5
    cp a, $FF
    jr z, Jump_01B_5C06
    ret

Jump_01B_5BE5::
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $06
    ld [wD781], a
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_01B_5C06::
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, Jump_01B_5BE5
    ld a, [wTwoChoiceCursor]
    ld b, $BC
    ld hl, Data_01B_65E5
    call StoreBAtWordTableEntry_Bank1B
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $0A
    call BeginString_Bank1B_Cat0
    ret

; when no text runs, copies box Data_01B_65E9 to wC412, draws it, clears wTwoChoiceCursor and wD781 += 1 (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD781
; writes: wTwoChoiceCursor, wD781
ShowTwoChoiceBox65E9WhenTextIdle:: ; heuristic: follows a terminator; C0
Func_01B_5C3B:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld de, Data_01B_65E9
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 22 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wMenuInputResult, wTwoChoiceCursor, wD781
; writes: wD781, wLinkSendByte, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
RunWD780StateWhenNotFading_1B_Case01_Case16::
Jump_01B_5C64:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_01B_5C76
    ld a, $06
    ld [wD781], a
    ld a, $FD
    ld [wLinkSendByte], a
    ret

Jump_01B_5C76::
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_01B_5C8A
    cp a, $FF
    jr z, Jump_01B_5CAD
    ret

Jump_01B_5C8A::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $09
    call BeginString_Bank1B_Cat0
    ret

Jump_01B_5CAD::
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, Jump_01B_5C8A
    ld a, [wD781]
    add a, $02
    ld [wD781], a
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ret

; entry 23 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD781
; writes: wD781
RunWD780StateWhenNotFading_1B_Case01_Case17::
Jump_01B_5CD3:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $6C
    call QueueSoundEffect
    ld de, Data_01B_65A6
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    ld a, [wD781]
    sub a, $03
    ld [wD781], a
    ret

; entry 24 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
RunWD780StateWhenNotFading_1B_Case01_Case18::
Jump_01B_5CFE:: ; address name
    ld a, $07
    call BeginString_Bank1B_Cat0
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 27 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
RunWD780StateWhenNotFading_1B_Case01_Case1B::
Jump_01B_5D0B:: ; address name
    ld a, $0B
    call BeginString_Bank1B_Cat0
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 29 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wD781
; writes: wD781, wD783, wD785, rRAMG2, rRAMB, wLinkTimeoutLo, wLinkTimeoutHi, wLinkSendByte
; points at: wD580
RunWD780StateWhenNotFading_1B_Case01_Case1D::
Jump_01B_5D18:: ; address name
    ld a, [wLinkMessage]
    cp a, $02
    ret nz
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD783], a
    ld [wD785], a
    call KeyEntryAddressForWD789Cell4
    ld a, [hl]
    cp a, $FE
    jr z, Jump_01B_5D70
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr nz, Jump_01B_5D70
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    bit 7, a
    jr z, Jump_01B_5D70
    and a, $3F
    ld bc, $0195
    call Multiply8By16
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $A0
    ld h, a
    ld de, wD580
    ld bc, $0195
    ld a, $0A
    ld [rRAMG2], a
    ld a, $02
    ld [rRAMB], a
    call CopyBytes
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    jr Jump_01B_5D7A

Jump_01B_5D70::
    ld hl, wD580
    ld bc, $0195
    xor a, a
    call FillBytes

Jump_01B_5D7A::
    ld hl, wD580
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

; entry 30 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wD781
; writes: wD781, wD09F, wD09D, wD09E, wLinkBufferCountLo, wLinkBufferCountHi, wLinkBufferPtrLo, wLinkBufferPtrHi, ...
; points at: wD200
RunWD780StateWhenNotFading_1B_Case01_Case1E::
Jump_01B_5D8B:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    ld a, [wD781]
    inc a
    ld [wD781], a
    call RunWD783Step_61A7
    ld hl, $0195
    ld a, $1E
    call DivideHLByA
    ld [wD09F], a
    ld a, l
    ld [wD09D], a
    ld a, h
    ld [wD09E], a
    ld hl, $001E
    ld a, l
    ld [wLinkBufferCountLo], a
    ld a, h
    ld [wLinkBufferCountHi], a
    ld hl, wD200
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $FF
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; entry 31 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wD781
; writes: wLinkReady, wLinkSendByte, wD781
RunWD780StateWhenNotFading_1B_Case01_Case1F::
Jump_01B_5DCF:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    ld a, $00
    ld [wLinkReady], a
    ld a, $01
    ld [wLinkSendByte], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 32 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wD09D, wD09E, wD781, wD09F
; writes: wD09D, wD09E, wLinkBufferCountLo, wLinkBufferCountHi, wD781, wLinkSendByte, wLinkReady, wD09F
RunWD780StateWhenNotFading_1B_Case01_Case20::
Jump_01B_5DE7:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    ld a, [wD09D]
    ld l, a
    ld a, [wD09E]
    ld h, a
    ld a, h
    or a, l
    jr z, Jump_01B_5E07
    dec hl
    ld a, l
    ld [wD09D], a
    ld a, h
    ld [wD09E], a
    ld hl, $001E
    jr Jump_01B_5E14

Jump_01B_5E07::
    ld a, [wD09F]
    or a, a
    jr z, Jump_01B_5E31
    ld l, a
    ld h, $00
    xor a, a
    ld [wD09F], a

Jump_01B_5E14::
    ld a, l
    ld [wLinkBufferCountLo], a
    ld a, h
    ld [wLinkBufferCountHi], a
    ld a, [wD781]
    dec a
    ld [wD781], a
    call RunWD783Step_61A7
    ld a, $FF
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

Jump_01B_5E31::
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkReady], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 33 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wD781, wD7F5, wD7F6, wRandomSeed2Lo, wLinkPartnerName, wRandomSeed2Hi, wBattleSetupByteBC, hTemp0, ...
; writes: wD781, wSaveStep, wSaveRecordIndex, hTemp0, wLinkPartnerName, wD200, rRAMG2, rRAMB, ...
; points at: wKeyList, wLinkPartnerName, wKeySeeds, wD200
RunWD780StateWhenNotFading_1B_Case01_Case21::
Jump_01B_5E41:: ; address name
    ld de, Data_01B_660A
    call DrawThreeTilesAtBGMap20FFromDE
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    call KeyEntryAddressForWD789Cell4
    ld a, [hl]
    cp a, $FE
    jr z, Jump_01B_5E67
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr nz, Jump_01B_5E6F
    jr Jump_01B_5E77

Jump_01B_5E67::
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    jr Jump_01B_5E96

Jump_01B_5E6F::
    ld a, $FF
    ld [hl-], a
    ld [hl-], a
    ld [hl-], a
    ld [hl-], a
    jr Jump_01B_5E96

Jump_01B_5E77::
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    bit 7, a
    jr z, Jump_01B_5E67
    farcall SetWD7F5ToWD789Cell4
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ldh [hTemp0], a
    farcall DeleteKeyEntryHFFC6

Jump_01B_5E96::
    ld hl, wKeyList
    ld c, $00

Jump_01B_5E9B::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_01B_5EB6
    ld a, $04
    add_a_to_hl
    inc c
    ld a, c
    cp a, $20
    jr c, Jump_01B_5E9B
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    ret

Jump_01B_5EB6::
    push bc
    ld a, [wRandomSeed2Lo]
    bit 7, a
    jr z, Jump_01B_5EE7
    ld a, [wLinkPartnerName]
    and a, $0F
    sub a, $07
    ld de, $0203
    add a, e
    ld e, a
    jr nc, Jump_01B_5ECD
    inc d

Jump_01B_5ECD::
    push hl
    push bc
    call TestFlagBit
    jr c, Jump_01B_5EDB
    ld a, [wLinkPartnerName]
    and a, $0F
    jr Jump_01B_5EE2

Jump_01B_5EDB::
    ld a, [wLinkPartnerName]
    set 6, a
    and a, $4F

Jump_01B_5EE2::
    pop bc
    pop hl
    ld [wLinkPartnerName], a

Jump_01B_5EE7::
    ld de, wLinkPartnerName
    ld b, $04

Jump_01B_5EEC::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_01B_5EEC
    pop bc
    push bc
    ld l, c
    ld h, $00
    sla l
    rl h
    ld de, wKeySeeds
    add hl, de
    ld a, [wRandomSeed2Hi]
    ld [hl+], a
    ld a, [wBattleSetupByteBC]
    ld [hl], a
    pop bc
    ld a, [wLinkPartnerName]
    cp a, $FE
    jr z, Jump_01B_5F7D
    ld a, [wRandomSeed2Lo]
    bit 7, a
    jr nz, Jump_01B_5F7D
    ld a, [wLinkPartnerName]
    bit 7, a
    jr z, Jump_01B_5F7D
    push bc
    call ClearWD201Bit7AndFourSlots
    farcall FindSRAMSlotMarkerIndex
    ldh a, [hTemp0]
    and a, $7F
    ld c, a
    ld a, [wD200]
    and a, $50
    or a, c
    ld [wD200], a
    ld a, $0A
    ld [rRAMG2], a
    ld a, $02
    ld [rRAMB], a
    xor a, a
    ldh [rSVBK], a
    ldh a, [hTemp0]
    and a, $7F
    ld bc, $0195
    call Multiply8By16
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $A0
    ld h, a
    ld e, l
    ld d, h
    ld hl, wD200
    ld bc, $0195
    call CopyBytes
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    pop bc
    ld a, c
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
    and a, $80
    ld b, a
    ldh a, [hTemp0]
    or a, b
    ld [hl], a

Jump_01B_5F7D::
    ld a, $0C
    call BeginString_Bank1B_Cat0
    ld a, $80
    ld [wGameFlags836], a
    ret

; entry 34 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wSaveStep, wD781
; writes: wD781, wD783
RunWD780StateWhenNotFading_1B_Case01_Case22::
Jump_01B_5F88:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    farcall RunSaveGameSteps
    ld a, [wSaveStep]
    bit 7, a
    ret z
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD783], a
    ld a, $07
    call BeginString_Bank1B_Cat0
    ret

; entry 36 of the `rst $00` table in RunWD780StateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte, hDecompressLock, wGameMode, wModeState, wModeChangeRequest
; points at: wD780
RunWD780StateWhenNotFading_1B_Case01_Case24::
Jump_01B_5FAA:: ; address name
    ld a, [wLinkMessage]
    cp a, $05
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wD780
    ld bc, $006F

Jump_01B_5FBA::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01B_5FBA
    xor a, a
    ldh [hDecompressLock], a
    ld a, $05
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    ld a, $01
    ld [wModeChangeRequest], a
    ret

; clears bit 7 of wD201 and the bytes at wD201 + $177 + 4 * n for n = 0-3 (E-0122)
; 1 call site from 1 routine (e.g. RunWD780StateWhenNotFading_1B_Case01_Case21)
; reads: wD201
; writes: wD201
; points at: wD201
ClearWD201Bit7AndFourSlots::
Func_01B_5FD4:: ; address name
    ld a, [wD201]
    res 7, a
    ld [wD201], a
    ld bc, $0177
    ld hl, wD201
    add hl, bc
    ld b, $04

Jump_01B_5FE5::
    xor a, a
    ld [hl], a
    ld a, $04
    add_a_to_hl
    dec b
    jr nz, Jump_01B_5FE5
    ret

; only called from RunWD780StateWhenNotFading_1B_Case01_Case12 (E-0047)
; 1 call site from 1 routine (e.g. RunWD780StateWhenNotFading_1B_Case01_Case12)
; reads: wLinkPartnerName, wRandomSeed2Lo, wLinkPartnerByte1, wLinkPartnerByte2, wDataBank
; writes: wD7F5, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringIndex, wStringCategory, wDataBank, ...
; points at: wNameGlyphBuf, wTextBuf0
RunWD780StateWhenNotFading_1B_Case01_Case12_Sub01::
Func_01B_5FF2:: ; address name
    ld a, [wLinkPartnerName]
    cp a, $FE
    jr nz, Jump_01B_6024
    ld hl, wNameGlyphBuf
    ld a, $16
    ld [hl+], a
    ld a, $24
    ld [hl+], a
    ld a, $2A
    ld [hl+], a
    ld a, $2C
    ld [hl+], a
    ld a, $26
    ld [hl+], a
    ld a, $90
    ld [hl+], a
    ld a, $14
    ld [hl+], a
    ld a, $28
    ld [hl+], a
    ld a, $3C
    ld [hl+], a
    ld a, $5B
    ld [hl+], a
    ld a, $F0
    ld [hl], a
    ld a, $03
    ld [wD7F5], a
    jr Jump_01B_606E

Jump_01B_6024::
    ld a, [wRandomSeed2Lo]
    bit 7, a
    jp nz, Jump_01B_60D4
    ld a, $09
    ld [wDataBank], a
    ld a, [wLinkPartnerByte1]
    inc a
    call CopyDataBankString4078ToWC130
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0

Jump_01B_603E::
    ld a, [de]
    cp a, $F0
    jr z, Jump_01B_6047
    ld [hl+], a
    inc de
    jr Jump_01B_603E

Jump_01B_6047::
    push hl
    ld a, $09
    ld [wDataBank], a
    ld a, [wLinkPartnerByte2]
    inc a
    add a, $10
    call CopyDataBankString4078ToWC130
    pop hl
    ld de, wTextBuf0

Jump_01B_605A::
    ld a, [de]
    cp a, $F0
    jr z, Jump_01B_6063
    ld [hl+], a
    inc de
    jr Jump_01B_605A

Jump_01B_6063::
    ld a, $5B
    ld [hl+], a
    ld a, $F0
    ld [hl], a
    ld a, $03
    ld [wD7F5], a

Jump_01B_606E::
    ld hl, wTextBuf0
    ld de, wNameGlyphBuf

Jump_01B_6074::
    ld a, [de]
    cp a, $F0
    jr z, Jump_01B_607D
    ld [hl+], a
    inc de
    jr Jump_01B_6074

Jump_01B_607D::
    ld [hl], a
    ld hl, vTiles2 + $600
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0B01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $27
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall ShowString_Bank1B_481A
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ret

; copies the 16-byte string named by the word table $4078 + 2 * A (in bank 9) to wC130; the next entry copies a key name word to wC8CF (E-0127)
; 2 call sites from 1 routine (e.g. RunWD780StateWhenNotFading_1B_Case01_Case12_Sub01)
; points at: wTextBuf0
CopyDataBankString4078ToWC130::
Func_01B_60BA:: ; address name
    sla a
    ld hl, $4078
    add_a_to_hl
    call ReadWordFromDataBank
    ld e, b
    ld d, c
    ld hl, wTextBuf0
    ld b, $09
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

Jump_01B_60D4::
    ld a, [wLinkPartnerName]
    and a, $3F
    ld l, a
    ld h, $00
    push hl
    ld a, [wDataBank]
    push af
    ld a, $09
    ld [wDataBank], a
    ld hl, Data_009_4016
    ld a, $0C
    add_a_to_hl
    call ReadWordFromDataBank
    ld e, b
    ld b, c
    ld c, e
    pop af
    pop hl
    push af
    sla l
    rl h
    add hl, bc
    call ReadWordFromDataBank
    ld a, b
    ld e, a
    ld a, c
    ld d, a
    pop af
    ld [wDataBank], a
    ld hl, wNameGlyphBuf
    ld b, $09
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $F0
    ld [wNameGlyphBuf + $D], a
    ld hl, wNameGlyphBuf

Jump_01B_611B::
    ld a, [hl+]
    cp a, $F0
    jr z, Jump_01B_6122
    jr Jump_01B_611B

Jump_01B_6122::
    jp Jump_01B_6063
    db $21, $A1, $5D, $06, $1D, $D7, $FA, $F5, $D7, $67, $FA, $F6, $D7, $6F, $7E, $6F
    db $26, $00, $29, $29, $7D, $C6, $07, $6F, $7C, $CE, $C7, $67, $7E, $E6, $7F, $01
    db $95, $01, $CD, $AA, $16, $7D, $C6, $00, $6F, $7C, $CE, $A0, $67, $C9

; far-calls SetWD7F5ToWD789Cell4, reads the key slot stored there and returns HL = wKeyList + 4 * slot (= $C707 + 4 * slot) (E-0120)
; 5 call sites from 5 routines (e.g. RunWD780StateWhenNotFading_1B_Case01_Case21, RunWD780StateWhenNotFading_1B_Case01_Case1D, RunWD780StateWhenNotFading_1B_Case01_Case10_Sub02, RunWD780StateWhenNotFading_1B_Case01_Case0E, ...)
; reads: wD7F5, wD7F6
KeyEntryAddressForWD789Cell4::
Func_01B_6153:: ; address name
    farcall SetWD7F5ToWD789Cell4
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
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
    ret

; far-calls SetWD7F5ToWD789Cell4, reads the byte at that address and returns HL = $C787 + 2 * that byte (E-0119)
; 1 call site from 1 routine (e.g. RunWD780StateWhenNotFading_1B_Case01_Case0E)
; reads: wD7F5, wD7F6
WordAddressForWD789Cell4Item::
Func_01B_6170:: ; address name
    farcall SetWD7F5ToWD789Cell4
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld l, a
    ld h, $00
    add hl, hl
    ld a, l
    add a, $87
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ret

; writes the three bytes at DE to vBGMap0 + $20F onward (WaitForVRAMAccess, interrupts off per byte) (E-0120)
; 3 call sites from 3 routines (e.g. RunWD780StateWhenNotFading_1B_Case01_Case21, RunWD780StateWhenNotFading_1B_Case01_Case1C, RunWD783Step_61A7_Case05)
DrawThreeTilesAtBGMap20FFromDE::
Func_01B_618C:: ; address name
    ld hl, vBGMap0 + $20F
    di
    call WaitForVRAMAccess
    ld a, [de]
    ld [hl+], a
    ei
    inc de
    di
    call WaitForVRAMAccess
    ld a, [de]
    ld [hl+], a
    ei
    inc de
    di
    call WaitForVRAMAccess
    ld a, [de]
    ld [hl], a
    ei
    ret

; runs the routine for wD783 (jump table of six; steps 2 and 4 reuse 0, 3 reuses 1) (E-0122)
; 2 call sites from 2 routines (e.g. RunWD780StateWhenNotFading_1B_Case01_Case20, RunWD780StateWhenNotFading_1B_Case01_Case1E)
; reads: wD783
RunWD783Step_61A7::
Func_01B_61A7:: ; address name
    ld a, [wD783]
    rst $00
    dw RunWD783Step_61A7_Case00
    dw RunWD783Step_61A7_Case01
    dw RunWD783Step_61A7_Case00
    dw RunWD783Step_61A7_Case01
    dw RunWD783Step_61A7_Case00
    dw RunWD783Step_61A7_Case05

; entry 0 of the `rst $00` table in RunWD783Step_61A7
; no direct call (reached through a table, a jump or a vector)
; reads: wD785, wD783
; writes: wD783
RunWD783Step_61A7_Case00::
Jump_01B_61B7:: ; address name
    ld b, $C3
    jr WriteTileBAtBGMap20FPlusWD785

; entry 1 of the `rst $00` table in RunWD783Step_61A7
; no direct call (reached through a table, a jump or a vector)
; reads: wD785, wD783
; writes: wD783
RunWD783Step_61A7_Case01::
Jump_01B_61BB:: ; address name
    ld b, $BC

; writes B at vBGMap0 + $20F + wD785 (WaitForVRAMAccess, interrupts off), then wD783 += 1 (E-0118)
; 1 call site from 1 routine (e.g. RunWD783Step_61A7_Case05)
; reads: wD785, wD783
; writes: wD783
WriteTileBAtBGMap20FPlusWD785::
Func_01B_61BD:: ; address name
    ld hl, vBGMap0 + $20F
    ld a, [wD785]
    add_a_to_hl
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ld a, [wD783]
    inc a
    ld [wD783], a
    ret

; entry 5 of the `rst $00` table in RunWD783Step_61A7
; no direct call (reached through a table, a jump or a vector)
; reads: wD785
; writes: wD783, wD785
RunWD783Step_61A7_Case05::
Jump_01B_61D7:: ; address name
    ld b, $BB
    call WriteTileBAtBGMap20FPlusWD785
    xor a, a
    ld [wD783], a
    ld a, [wD785]
    inc a
    ld [wD785], a
    cp a, $03
    ret c
    xor a, a
    ld [wD785], a
    ld de, Data_01B_6607
    call DrawThreeTilesAtBGMap20FFromDE
    ret

; A = string index: wStringIndex = A, wStringCategory = 0, then BeginStringDisplay_Bank1B_480C
; 18 call sites from 17 routines (e.g. RunWD780StateWhenNotFading_1B_Case00_Case04, RunWD780StateWhenNotFading_1B_Case00_Case02, RunWD780StateWhenNotFading_1B_Case00_Case01, RunWD780StateWhenNotFading_1B_Case01_Case22, ...)
; writes: wStringIndex, wStringCategory
BeginString_Bank1B_Cat0::
Func_01B_61F5:: ; address name
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank1B_480C
    ret

; only called from routines of RunWD780StateWhenNotFading_1B (E-0098)
; 2 call sites from 2 routines (e.g. RunWD780StateWhenNotFading_1B_Case01_Case09, RunWD780StateWhenNotFading_1B_Case01_Case11_Case04)
; writes: wD7F1, wD7F2
RunWD780StateWhenNotFading_1B_Shared01::
Func_01B_6203:: ; address name
    ld b, $00
    ld c, $05
    ld hl, $027A
    ld de, $00AE
    xor a, a
    ld [wD7F1], a
    ld a, $06
    ld [wD7F2], a
    call RunWD780StateWhenNotFading_1B_Shared01_Sub01
    ld de, Data_01B_6565
    ld hl, wWindowTileBuffer + $112
    ld bc, $0105
    call CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    ret

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0
; 24 call sites from 18 routines (e.g. RunWD780StateWhenNotFading_1B_Case01_Case17, RunWD780StateWhenNotFading_1B_Case01_Case13, RunWD780StateWhenNotFading_1B_Case01_Case12, RunWD780StateWhenNotFading_1B_Shared01, ...)
; reads: wIsCGB
; writes: rSVBK
CopyRectTo20ByteRows::
Func_01B_6232:: ; address name
    push hl
    push bc

Jump_01B_6234::
    push hl
    push bc

Jump_01B_6236::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_01B_6236
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jp nz, Jump_01B_6234
    pop bc
    pop hl
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, l
    add a, $68
    ld l, a
    ld a, h
    adc a, $0E
    ld h, a
    ld a, $02
    ldh [rSVBK], a

Jump_01B_625D::
    push hl
    push bc

Jump_01B_625F::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_01B_625F
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jp nz, Jump_01B_625D
    ld a, $00
    ldh [rSVBK], a
    ret

; copies a rectangle of the screen buffer (offset DE) to the BG map at HL, sets wC554 = HL + $1C1, and on CGB copies its attributes (E-0127)
; 18 call sites from 17 routines (e.g. RunWD780StateWhenNotFading_1B_Case01_Case17, RunWD780StateWhenNotFading_1B_Case01_Case13, RunWD780StateWhenNotFading_1B_Case01_Case12, RunWD780StateWhenNotFading_1B_Shared01, ...)
; reads: wIsCGB
; writes: wTextCursorLo, wTextCursorHi, rSVBK
; points at: wScreenTileBuffer
DrawScreenBufferRectToBGMap_1B::
Func_01B_6277:: ; address name
    push de
    push bc
    push hl
    ld hl, wScreenTileBuffer
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    push hl
    call CopyRectToBGMapWrapped
    pop hl
    push hl
    ld a, l
    add a, $C1
    ld l, a
    ld a, h
    adc a, $01
    ld h, a
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    pop hl
    pop bc
    pop de
    ld a, [wIsCGB]
    or a, a
    ret z
    push de
    call WaitForVRAMAccess
    push bc
    ld c, $4F
    ld a, $01
    ldh [c], a
    pop bc
    pop de
    ld a, $02
    ldh [rSVBK], a
    push hl
    ld hl, wRecordBufferData + $12
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    call CopyRectToBGMapWrapped
    call WaitForVRAMAccess
    ld a, $00
    ldh [rSVBK], a
    ld c, $4F
    ld a, $00
    ldh [c], a
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 20 call sites from 19 routines (e.g. RunWD780StateWhenNotFading_1B_Case01_Case17, UpdateTwoChoiceCursor_Bank1B_Sub04, RunWD780StateWhenNotFading_1B_Case01_Case13, RunWD780StateWhenNotFading_1B_Case01_Case12, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank1B::
Func_01B_62CB:: ; address name
    ld hl, vBGMap0
    ldh a, [hScrollY]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add_a_to_hl
    ret

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
; 2 call sites from 2 routines (e.g. RunWD780StateWhenNotFading_1B_Case00_Case00, RunWD780StateWhenNotFading_1B_Shared01_Sub01)
CopyBytesDEToHL_Bank1B::
Func_01B_62EC:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, CopyBytesDEToHL_Bank1B
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same 19 bytes appear in 5 banks)
; 2 call sites from 2 routines (e.g. RunWD780StateWhenNotFading_1B_Case00_Case00, RunWD780StateWhenNotFading_1B_Shared01_Sub01)
; writes: rSVBK
CopyLow3BitsToWRAMBank2_Bank1B::
Func_01B_62F5:: ; address name
    ld a, $02
    ldh [rSVBK], a

Jump_01B_62F9::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01B_62F9
    ld a, $00
    ldh [rSVBK], a
    ret

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers A, DE, HL (the same 16 bytes appear in 4 banks)
; 10 call sites from 9 routines (e.g. RunWD780StateWhenNotFading_1B_Case01_Case14, EraseCEntriesOfWordTable_Bank1B, RunWD780StateWhenNotFading_1B_Case01_Case05, RunWD780StateWhenNotFading_1B_Case01_Case04, ...)
StoreBAtWordTableEntry_Bank1B::
Func_01B_6308:: ; address name
    push bc
    sla a
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    pop bc
    ld a, b
    ld [de], a
    ret

; stores tile $C3 at the addresses of entries 0 to C - 1 of the word table at HL (E-0122)
; 3 call sites from 3 routines (e.g. RunWD780StateWhenNotFading_1B_Case01_Case0A, ScriptCommandEF_Run_Bank1B_Case04_Case0B, ScriptCommandEF_Run_Bank1B_Case04_Case0A_Sub01)
EraseCEntriesOfWordTable_Bank1B::
Func_01B_6318:: ; address name
    ld a, c
    ld b, a
    ld c, $00

Jump_01B_631C::
    ld a, c
    push bc
    ld b, $C3
    push hl
    call StoreBAtWordTableEntry_Bank1B
    pop hl
    pop bc
    inc c
    ld a, c
    cp a, b
    jr c, Jump_01B_631C
    ret

; draws tiles $C5, $BE, $C6 at BGMapAddressAtScroll + DE, two entries apart (WaitForVRAMAccess, interrupts off) (E-0120)
; 2 call sites from 2 routines (e.g. RunWD780StateWhenNotFading_1B_Case01_Case02, DrawRecordListPageIndicators_1B)
DrawC5BEC6AtScrollOffsetDE_Bank1B::
Func_01B_632C:: ; address name
    push de
    call BGMapAddressAtScroll_Bank1B
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, $C5
    ld [hl], a
    ei
    inc hl
    inc hl
    di
    call WaitForVRAMAccess
    ld a, $BE
    ld [hl], a
    ei
    inc hl
    inc hl
    di
    call WaitForVRAMAccess
    ld a, $C6
    ld [hl], a
    ei
    ret

; [HL] = $C5, [HL+2] = $BE, [HL+4] = $C6; HL ends at HL+4; clobbers A (the same 14 bytes appear in 8 banks)
; 3 call sites from 3 routines (e.g. RunWD780StateWhenNotFading_1B_Case01_Case02, DrawRecordListPageIndicators_1B, ScriptCommandEF_Run_Bank1B_Case0E_Case01)
StoreC5BEC6AtHLStride2_Bank1B::
Func_01B_634F:: ; address name
    ld a, $C5
    ld [hl], a
    inc hl
    inc hl
    ld a, $BE
    ld [hl], a
    inc hl
    inc hl
    ld a, $C6
    ld [hl], a
    ret

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for rSTAT bit 1 to clear; clobbers A; HL and DE advance (the same 20 bytes appear in 3 banks)
; no direct call (reached through a table, a jump or a vector)
; reads: rSTAT
CopyTileBytesToVRAM_Bank1B:: ; heuristic: follows a terminator; C0
Func_01B_635D:: ; address name
    xor a, a

Jump_01B_635E::
    push af
    di

Jump_01B_6360::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01B_6360
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    pop af
    inc a
    cp a, $10
    jr c, Jump_01B_635E
    ret

; only called from RunWD780StateWhenNotFading_1B_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. RunWD780StateWhenNotFading_1B_Shared01)
; reads: wD7F1, wD7F2, wIsCGB
; points at: wScreenTileBuffer
RunWD780StateWhenNotFading_1B_Shared01_Sub01::
Func_01B_6371:: ; address name
    push bc
    push hl
    push de
    ld de, wScreenTileBuffer
    add hl, de
    pop de
    push de
    push hl
    ld hl, wScreenTileBuffer
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    ld a, [wD7F1]
    ld b, a
    ld a, [wD7F2]
    ld c, a
    call CopyBytesDEToHL_Bank1B
    pop de
    pop hl
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01B_63B6
    push hl
    push de
    ld de, wRecordBufferData + $12
    add hl, de
    pop de
    push de
    push hl
    ld hl, wRecordBufferData + $12
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    ld a, [wD7F1]
    ld b, a
    ld a, [wD7F2]
    ld c, a
    call CopyLow3BitsToWRAMBank2_Bank1B
    pop de
    pop hl

Jump_01B_63B6::
    pop bc
    ld a, $14
    add_a_to_hl
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_01B_63C5
    inc d

Jump_01B_63C5::
    inc b
    ld a, b
    cp a, c
    jr c, RunWD780StateWhenNotFading_1B_Shared01_Sub01
    ret

; the same instructions as UpdateTwoChoiceCursor_Bank1D, calling this bank's own helpers: wTwoChoiceCursor (0 or 1): Up and Down each toggle it, erase the old cursor (tile $C3), draw the new one (tile $BB), play sound $69 and set wMenuInputResult = $FD; A draws the confirmed cursor (tile $BC), plays sound $69 and sets $FF; B sets $FE; with no input the cursor blinks (wD783 counts frames once wJoypadRepeatTimer reaches $14) and the result is 0. Its cursor positions come from this bank's own table and were not compared (E-0068)
; 1 call site from 1 routine (e.g. RunWD780StateWhenNotFading_1B_Case01_Case14)
; reads: wJoypadPressedRepeat, wJoypadPressed, wTwoChoiceCursor
; writes: wMenuInputResult, wTwoChoiceCursor, wD783
UpdateTwoChoiceCursor_Bank1B::
Func_01B_63CB:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_01B_63E9
    bit 7, a
    jr nz, Jump_01B_63FF
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, Jump_01B_6425
    bit 1, a
    jr nz, Jump_01B_6433
    call UpdateTwoChoiceCursor_Bank1B_Sub01
    xor a, a
    ld [wMenuInputResult], a
    ret

Jump_01B_63E9::
    call UpdateTwoChoiceCursor_Bank1B_Sub03
    ld a, [wTwoChoiceCursor]
    and a, a
    jr nz, Jump_01B_63F9
    ld a, $01
    ld [wTwoChoiceCursor], a
    jr Jump_01B_6413

Jump_01B_63F9::
    dec a
    ld [wTwoChoiceCursor], a
    jr Jump_01B_6413

Jump_01B_63FF::
    call UpdateTwoChoiceCursor_Bank1B_Sub03
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr c, Jump_01B_640F
    xor a, a
    ld [wTwoChoiceCursor], a
    jr Jump_01B_6413

Jump_01B_640F::
    inc a
    ld [wTwoChoiceCursor], a

Jump_01B_6413::
    xor a, a
    ld [wD783], a
    call UpdateTwoChoiceCursor_Bank1B_Sub02
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

Jump_01B_6425::
    call UpdateTwoChoiceCursor_Bank1B_Sub04
    ld a, $69
    call QueueSoundEffect
    ld a, $FF
    ld [wMenuInputResult], a
    ret

Jump_01B_6433::
    ld a, $FE
    ld [wMenuInputResult], a
    ret

; only called from UpdateTwoChoiceCursor_Bank1B (E-0047)
; 1 call site from 1 routine (e.g. UpdateTwoChoiceCursor_Bank1B)
; reads: wJoypadRepeatTimer, wD783, wTwoChoiceCursor
; writes: wD783
UpdateTwoChoiceCursor_Bank1B_Sub01::
Func_01B_6439:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, UpdateTwoChoiceCursor_Bank1B_Sub02
    ld a, [wD783]
    inc a
    ld [wD783], a
    cp a, $10
    jr c, UpdateTwoChoiceCursor_Bank1B_Sub02
    cp a, $18
    jr c, UpdateTwoChoiceCursor_Bank1B_Sub03
    xor a, a
    ld [wD783], a

; only called from UpdateTwoChoiceCursor_Bank1B (E-0047)
; 1 call site from 1 routine (e.g. UpdateTwoChoiceCursor_Bank1B)
; reads: wTwoChoiceCursor
UpdateTwoChoiceCursor_Bank1B_Sub02::
Func_01B_6453:: ; address name
    ld b, $BB
    jr Jump_01B_645D

; only called from UpdateTwoChoiceCursor_Bank1B (E-0047)
; 2 call sites from 1 routine (e.g. UpdateTwoChoiceCursor_Bank1B)
; reads: wTwoChoiceCursor
UpdateTwoChoiceCursor_Bank1B_Sub03::
Func_01B_6457:: ; address name
    ld b, $C3
    jr Jump_01B_645D

; only called from UpdateTwoChoiceCursor_Bank1B (E-0047)
; 1 call site from 1 routine (e.g. UpdateTwoChoiceCursor_Bank1B)
; reads: wTwoChoiceCursor
UpdateTwoChoiceCursor_Bank1B_Sub04::
Func_01B_645B:: ; address name
    ld b, $BC

Jump_01B_645D::
    ld a, [wTwoChoiceCursor]
    sla a
    ld hl, Data_01B_647F
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    push de
    call BGMapAddressAtScroll_Bank1B
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_01B_647F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2D, $01, $6D, $01

Data_01B_6483:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $06E483, $78

Data_01B_64FB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_01B_650A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $06E50A, $5B

Data_01B_6565:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $06E565, $41

Data_01B_65A6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $50, $51, $52, $53, $54, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $55, $56, $57, $58, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_01B_65CE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B6, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6A, $6B, $C3, $B7

Data_01B_65DD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $CA, $C3, $F2, $C3, $1A, $C4, $42, $C4

Data_01B_65E5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $25, $C4, $4D, $C4

Data_01B_65E9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $CE, $CF, $DF, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $A5, $71, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

Data_01B_6607:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $BC, $BC, $BC

Data_01B_660A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A0, $A1, $A2

; only called from RunWD06AState_6C12_Case06 (E-0047)
; 1 call site from 1 routine (e.g. RunWD06AState_6C12_Case06)
; reads: wTextWindowState
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wTextWindowState, wTextWindowStep, hSpriteWindowClipMode
; points at: wD780
RunWD06AState_6C12_Case06_Sub01::
Func_01B_660D:: ; address name
    ld hl, wD780
    ld bc, $006F

Jump_01B_6613::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_01B_6613
    ld b, $46
    ld de, Data_046_4001
    ld hl, vTiles1
    call DecompressToVRAM
    farcall ClearScreenBufferAndAttributes_BankF1
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld a, $01
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $00
    ldh [hSpriteWindowClipMode], a

Jump_01B_6650::
    farcall StepTextWindowOpenClose
    ld a, [wTextWindowState]
    and a, $03
    jr nz, Jump_01B_6650
    ret

; the same instruction sequence as ScriptCommandEF_Run (bank $0D) apart from label operands, which refer to this bank's own routines and tables; the twin's note describes the shape (E-0107)
; 4 call sites from 4 routines (e.g. RunWD06AState_6C12_Case07, GameMode6_Update_Case04_Case04, GameMode6_Update_Case0F_Case03, GameMode6_Update_Case0F_Case07)
; reads: wD780
ScriptCommandEF_Run_Bank1B::
Func_01B_665E:: ; address name
    ld a, [wD780]
    rst $00
    dw ScriptCommandEF_Run_Bank1B_Case00
    dw ScriptCommandEF_Run_Bank1B_Case01
    dw ScriptCommandEF_Run_Bank1B_Case02
    dw ScriptCommandEF_Run_Bank1B_Case03
    dw ScriptCommandEF_Run_Bank1B_Case04
    dw ScriptCommandEF_Run_Bank1B_Case05
    dw ScriptCommandEF_Run_Bank1B_Case06
    dw ScriptCommandEF_Run_Bank1B_Case06
    dw ScriptCommandEF_Run_Bank1B_Case06
    dw ScriptCommandEF_Run_Bank1B_Case06
    dw ScriptCommandEF_Run_Bank1B_Case06
    dw ScriptCommandEF_Run_Bank1B_Case06
    dw ScriptCommandEF_Run_Bank1B_Case06
    dw ScriptCommandEF_Run_Bank1B_Case0D
    dw ScriptCommandEF_Run_Bank1B_Case0E
    dw ScriptCommandEF_Run_Bank1B_Case0F

; entry 0 of the `rst $00` table in ScriptCommandEF_Run_Bank1B
; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: hSpriteHideTile, wStringCategory, wD780
ScriptCommandEF_Run_Bank1B_Case00::
Jump_01B_6682:: ; address name
    ld a, $C0
    ldh [hSpriteHideTile], a
    xor a, a
    ld [wStringCategory], a
    call ShowStringA10_Bank1B
    call ClearTileRowsFromWD7DC
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; entry 1 of the `rst $00` table in ScriptCommandEF_Run_Bank1B
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD780
; writes: wD780
ScriptCommandEF_Run_Bank1B_Case01::
Jump_01B_6698:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wD780]
    inc a
    inc a
    ld [wD780], a
    ret

; entry 2 of the `rst $00` table in ScriptCommandEF_Run_Bank1B
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandEF_Run_Bank1B_Case02::
Jump_01B_66A6:: ; address name
    ld a, [wD781]
    rst $00
    dw ScriptCommandEF_Run_Bank1B_Case02_Case00
    dw ScriptCommandEF_Run_Bank1B_Case02_Case01
    dw ScriptCommandEF_Run_Bank1B_Case02_Case02
    dw ScriptCommandEF_Run_Bank1B_Case02_Case03
    dw ScriptCommandEF_Run_Bank1B_Case02_Case04

; entry 0 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wD781
; writes: wLinkSendByte, wD781
ScriptCommandEF_Run_Bank1B_Case02_Case00::
Jump_01B_66B4:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 1 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD781
; writes: wD781
ScriptCommandEF_Run_Bank1B_Case02_Case01::
Jump_01B_66C6:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $0C
    call ShowStringA10_Bank1B
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 2 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD781
; writes: wLinkSendByte, wD781
ScriptCommandEF_Run_Bank1B_Case02_Case02::
Jump_01B_66D8:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 3 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wD781
; writes: wLinkSendByte, wD781
ScriptCommandEF_Run_Bank1B_Case02_Case03::
Jump_01B_66EA:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 4 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wGameMode, wModeState, wModeChangeRequest
; points at: wD780
ScriptCommandEF_Run_Bank1B_Case02_Case04::
Jump_01B_66FC:: ; address name
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld hl, wD780
    ld bc, $006F

Jump_01B_6708::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01B_6708
    ld a, $05
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    ld a, $01
    ld [wModeChangeRequest], a
    ret

; entry 3 of the `rst $00` table in ScriptCommandEF_Run_Bank1B
; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD780
ScriptCommandEF_Run_Bank1B_Case03::
Jump_01B_671F:: ; address name
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; entry 4 of the `rst $00` table in ScriptCommandEF_Run_Bank1B
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandEF_Run_Bank1B_Case04::
Jump_01B_6727:: ; address name
    ld a, [wD781]
    rst $00
    dw ScriptCommandEF_Run_Bank1B_Case04_Case00
    dw ScriptCommandEF_Run_Bank1B_Case04_Case01
    dw DrawRecordListPageIndicators_1B
    dw ScriptCommandEF_Run_Bank1B_Case04_Case01
    dw DrawWD789Cell5RecordPanel
    dw ClearAndDrawWD789Cell5NameAtTiles1780
    dw DrawRuleBoxByWD04CBit7
    dw ScriptCommandEF_Run_Bank1B_Case04_Case07
    dw ScriptCommandEF_Run_Bank1B_Case04_Case08
    dw ScriptCommandEF_Run_Bank1B_Case04_Case09
    dw ScriptCommandEF_Run_Bank1B_Case04_Case0A
    dw ScriptCommandEF_Run_Bank1B_Case04_Case0B
    dw ScriptCommandEF_Run_Bank1B_Case04_Case0C
    dw ScriptCommandEF_Run_Bank1B_Case04_Case0D

; entry 1 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
ScriptCommandEF_Run_Bank1B_Case04_Case01::
Jump_01B_6747:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    farcall ScriptCommandED_Run
    ret

; entry 0 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
ScriptCommandEF_Run_Bank1B_Case04_Case00::
Jump_01B_6753:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    farcall ScriptCommandED_Run
    ret

; runs Func_01B_7399 and Func_01E_7163; with two or more pages draws the bracket and page-of-pages indicators; wD781 += 1 (E-0124)
; 1 call site from 1 routine (e.g. Func_033_5215_Table2_Case04_Case02)
; reads: wD7B0, wD781
; writes: wD7F1, wD7F2, wD781
DrawRecordListPageIndicators_1B::
Func_01B_675F:: ; address name
    call ListAvailableRecordsForSelection
    farcall ClampRecordListPageCursor5
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_01B_679D
    ld de, $0142
    call DrawC5BEC6AtScrollOffsetDE_Bank1B
    ld hl, wWindowTileBuffer + $12E
    call StoreC5BEC6AtHLStride2_Bank1B
    ld de, $0143
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    farcall DrawPageOfPagesAtScrollOffset
    ld hl, wWindowTileBuffer + $12F
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    farcall DrawPageOfPagesAtWD7F1_Bank1E

Jump_01B_679D::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; for the record at WD789 cell 5: draws its graphics (Func_01B_7460 with wD7F1 = $C7), copies two rectangles to wC434 and wC440, draws its details at wC443 (Func_01B_7487) and wD781 += 1 (E-0121)
; 2 call sites from 2 routines (e.g. ScriptCommandEF_Run_Bank1B_Case0E_Case03, CallDrawWD789Cell5RecordPanel)
; reads: wD7F5, wD7F6, wD781
; writes: wD7F1, wD7F2, wD7F3, wD781
DrawWD789Cell5RecordPanel::
Func_01B_67A5:: ; address name
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    ld a, $C7
    ld [wD7F1], a
    call LoadFamilyIconTileForRecordB_Bank1B
    ld de, Data_01B_7738
    ld hl, wWindowTileBuffer + $134
    ld bc, $0501
    call CopyRectTo20ByteRows
    ld de, Data_01B_773D
    ld hl, wWindowTileBuffer + $140
    ld bc, $0D02
    call CopyRectTo20ByteRows
    pop af
    ld [wD7F1], a
    ld hl, wWindowTileBuffer + $143
    ld a, l
    ld [wD7F2], a
    ld a, h
    ld [wD7F3], a
    call DrawWD789Cell5RecordPanel_Sub01
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; clears 5 tiles at vTiles1 + $780, draws the name of the record at WD789 cell 5 there and wD781 += 1 (E-0122)
; 3 call sites from 3 routines (e.g. ScriptCommandEF_Run_Bank1B_Case0E_Case04, CallClearAndDrawWD789Cell5Name, Func_033_5215_Table2_Case0E_Case04)
; reads: wD781
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wD781
ClearAndDrawWD789Cell5NameAtTiles1780::
Func_01B_67F0:: ; address name
    ld hl, vTiles1 + $780
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0501
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    call DrawWD789Cell5RecordNameAtTiles1780
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; copies box Data_01B_7757 (10 x 7) or Data_01B_779D (10 x 9, when bit 7 of wD04C is set) to wC36E, then wD781 += 1 (E-0124)
; 1 call site from 1 routine (e.g. ScriptCommandEF_Run_Bank1B_Case0E_Case05)
; reads: wD04C, wD781
; writes: wD781
DrawRuleBoxByWD04CBit7::
Func_01B_6814:: ; address name
    ld a, [wD04C]
    bit 7, a
    jr nz, Jump_01B_6829
    ld de, Data_01B_7757
    ld hl, wWindowTileBuffer + $6E
    ld bc, $0A07
    call CopyRectTo20ByteRows
    jr Jump_01B_6835

Jump_01B_6829::
    ld de, Data_01B_779D
    ld hl, wWindowTileBuffer + $6E
    ld bc, $0A09
    call CopyRectTo20ByteRows

Jump_01B_6835::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 7 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD7AB, wD781
; writes: wD781
ScriptCommandEF_Run_Bank1B_Case04_Case07::
Jump_01B_683D:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wD7AB]
    ld b, $BB
    ld hl, Data_01B_786F
    call StoreBAtWordTableEntry_Bank1B
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    ld a, [wD7AB]
    ld b, $C3
    ld hl, Data_01B_786F
    call StoreBAtWordTableEntry_Bank1B
    call SetDefaultStringWindow_Bank1B
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 8 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wMenuInputResult, wD7AB, wD781, wD7DC, wD7B4
; writes: wD780, wD781, wD782, wLinkSendByte, wMenuInputResult, wD7DC, wD7AB, wD7AF
ScriptCommandEF_Run_Bank1B_Case04_Case08::
Jump_01B_686F:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_01B_688D
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0B
    call ShowStringA10_Bank1B
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_01B_688D::
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_01B_68B1
    cp a, $FC
    jr z, Jump_01B_68B1
    cp a, $FD
    jr z, Jump_01B_68BA
    cp a, $FE
    jr z, Jump_01B_68C3
    cp a, $FF
    jr z, Jump_01B_690D
    ret

Jump_01B_68B1::
    ld a, [wD781]
    sub a, $07
    ld [wD781], a
    ret

Jump_01B_68BA::
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

Jump_01B_68C3::
    ld a, [wD7DC]
    and a, a
    jr z, Jump_01B_68F6
    cp a, $03
    jr c, Jump_01B_68DE
    ld a, [wD7B4]
    ld [wD7DC], a
    dec a
    ld [wD7DC], a
    ld a, $01
    call ShowStringA10_Bank1B
    jr Jump_01B_68E6

Jump_01B_68DE::
    dec a
    ld [wD7DC], a
    xor a, a
    call ShowStringA10_Bank1B

Jump_01B_68E6::
    call ClearTileRowsFromWD7DC
    xor a, a
    ld [wD7AB], a
    ld [wD7AF], a
    ld a, $01
    ld [wD781], a
    ret

Jump_01B_68F6::
    ld a, $02
    ld [wD780], a
    ld a, $0A
    call ShowStringA10_Bank1B
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_01B_690D::
    call ScriptCommandEF_Run_Bank1B_Shared01
    call ScriptCommandEF_Run_Bank1B_Shared02
    cp a, $FF
    jr z, Jump_01B_6918
    ret

Jump_01B_6918::
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_01B_786F
    call StoreBAtWordTableEntry_Bank1B
    call CopyWD789Cell5NameToWC130
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, [wD7DC]
    cp a, $03
    jr z, Jump_01B_693A
    ld a, $02
    call ShowStringA10_Bank1B
    ret

Jump_01B_693A::
    ld a, $07
    call ShowStringA10_Bank1B
    ret

; entry 9 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD781
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wD7AD, wD781
ScriptCommandEF_Run_Bank1B_Case04_Case09::
Jump_01B_6940:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld hl, vTiles2 + $700
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0C01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a, a
    ld [wStringCategory], a
    ld a, $1E
    ld [wStringIndex], a
    farcall ShowString_Bank1B_481A
    ld a, $6C
    call QueueSoundEffect
    ld de, Data_01B_7847
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a, a
    ld [wD7AD], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 10 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wD7F5, wD7AD, wD780, wD781, wD7DC, wD7F6
; writes: wD780, wD781, wD782, wLinkSendByte, wD7F5, wD7B2, wD7B3, wLinkSceneByte4C, ...
ScriptCommandEF_Run_Bank1B_Case04_Case0A::
Jump_01B_69A9:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_01B_69C7
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0B
    call ShowStringA10_Bank1B
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_01B_69C7::
    xor a, a
    ld [wD7F5], a
    farcall HandleTwoChoiceCursorInput_0D
    ld a, [wD7F5]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_01B_69DF
    cp a, $FF
    jr z, Jump_01B_69E7
    ret

Jump_01B_69DF::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_69E7::
    ld a, [wD7AD]
    and a, a
    jr nz, Jump_01B_6A06
    ld a, [wD780]
    ld [wD7B2], a
    ld a, [wD781]
    ld [wD7B3], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0C
    ld [wD780], a
    ret

Jump_01B_6A06::
    call ScriptCommandEF_Run_Bank1B_Shared01
    ld a, [wD7DC]
    cp a, $03
    jr c, Jump_01B_6A46
    call ScriptCommandEF_Run_Bank1B_Case04_Case0A_Sub02
    cp a, $FF
    jr nz, Jump_01B_6A18
    ret

Jump_01B_6A18::
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld [wLinkSceneByte4C], a
    ld a, $04
    ld [wD7DC], a
    call ScriptCommandEF_Run_Bank1B_Case04_Case0A_Sub01
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ld a, $0C
    call ShowStringA10_Bank1B
    ret

Jump_01B_6A46::
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    ret

; entry 11 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD781
; writes: wD781
ScriptCommandEF_Run_Bank1B_Case04_Case0B::
Jump_01B_6A4F:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld c, $05
    ld hl, Data_01B_786F
    call EraseCEntriesOfWordTable_Bank1B
    jr Jump_01B_6A71

; only called from ScriptCommandEF_Run_Bank1B_Case04_Case0A (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandEF_Run_Bank1B_Case04_Case0A)
; reads: wD7AB, wD781
; writes: wD781
ScriptCommandEF_Run_Bank1B_Case04_Case0A_Sub01::
Func_01B_6A5E:: ; address name
    ld c, $05
    ld hl, Data_01B_786F
    call EraseCEntriesOfWordTable_Bank1B
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_01B_786F
    call StoreBAtWordTableEntry_Bank1B

Jump_01B_6A71::
    call ScriptCommandEF_Run_Bank1B_Shared03
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    ld a, [wD781]
    sub a, $03
    ld [wD781], a
    ret

; entry 12 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD7DC, wD781
; writes: wD7DC, wD781
ScriptCommandEF_Run_Bank1B_Case04_Case0C::
Jump_01B_6A89:: ; address name
    call ScriptCommandEF_Run_Bank1B_Shared02
    cp a, $FF
    ret nz
    call ScriptCommandEF_Run_Bank1B_Shared03
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    ld a, [wD7DC]
    inc a
    ld [wD7DC], a
    call ClearTileRowsFromWD7DC
    call DrawWD7DDRecordNamesAndIcons
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 13 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wD782
; writes: wD780, wD781, wD782, wLinkSendByte
ScriptCommandEF_Run_Bank1B_Case04_Case0D::
Jump_01B_6AB3:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_01B_6AD1
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0B
    call ShowStringA10_Bank1B
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_01B_6AD1::
    ld a, [wD782]
    rst $00
    dw Func_01B_6A5E_Case00
    dw Func_01B_6A5E_Case01
    dw Func_01B_6A5E_Case02
    dw Func_01B_6A5E_Case03
    dw Func_01B_6A5E_Case04
    dw Func_01B_6A5E_Case05
    dw Func_01B_6A5E_Case01
    dw Func_01B_6A5E_Case07

; entry 0 of the `rst $00` table in Func_01B_6A5E
; no direct call (reached through a table, a jump or a vector)
; reads: wD7DC, wD7A9, wD782
; writes: wD782
Func_01B_6A5E_Case00::
Jump_01B_6AE5:: ; address name
    ld a, [wD7DC]
    cp a, $03
    jr z, Jump_01B_6B02
    call ListAvailableRecordsForSelection
    ld a, [wD7A9]
    and a, a
    jr z, Jump_01B_6B02
    ld a, $03
    call ShowStringA10_Bank1B
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_01B_6B02::
    ld a, [wD782]
    add a, $04
    ld [wD782], a
    ret

; entry 1 of the `rst $00` table in Func_01B_6A5E
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD782, wD7DC
; writes: wTwoChoiceCursor, wD782
Func_01B_6A5E_Case01::
Jump_01B_6B0B:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $6C
    call QueueSoundEffect
    ld de, Data_01B_78CB
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    ld a, [wD782]
    cp a, $01
    jr z, Jump_01B_6B3F
    ld a, [wD7DC]
    cp a, $03
    jr nz, Jump_01B_6B3F
    ld a, $01
    jr Jump_01B_6B40

Jump_01B_6B3F::
    xor a, a

Jump_01B_6B40::
    ld [wTwoChoiceCursor], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 2 of the `rst $00` table in Func_01B_6A5E
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wMenuInputResult, wTwoChoiceCursor, wD782
; writes: wD780, wD781, wD782, wLinkSendByte
Func_01B_6A5E_Case02::
Jump_01B_6B4B:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_01B_6B69
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0B
    call ShowStringA10_Bank1B
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_01B_6B69::
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_01B_6B7D
    cp a, $FF
    jr z, Jump_01B_6B89
    ret

Jump_01B_6B7D::
    call DrawChoiceBoxByWD04CBit7
    ld a, [wD782]
    add a, $02
    ld [wD782], a
    ret

Jump_01B_6B89::
    ld a, [wTwoChoiceCursor]
    and a, a
    jr nz, Jump_01B_6B7D
    call DrawChoiceBoxByWD04CBit7
    xor a, a
    call ShowStringA10_Bank1B
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 3 of the `rst $00` table in Func_01B_6A5E
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wD781, wD782
Func_01B_6A5E_Case03::
Jump_01B_6B9E:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ret

; entry 4 of the `rst $00` table in Func_01B_6A5E
; no direct call (reached through a table, a jump or a vector)
; reads: wD04C, wD7A9, wD782, wD7DC
; writes: wD782, wD7B4, wD7DC, wTwoChoiceCursor
Func_01B_6A5E_Case04::
Jump_01B_6BAB:: ; address name
    ld a, [wD04C]
    bit 7, a
    jr nz, Jump_01B_6BBB
    ld a, $0C
    call ShowStringA10_Bank1B
    call FinishWD7DDEntryAndAdvance
    ret

Jump_01B_6BBB::
    farcall ListRecordsState1WithByte6EClear
    ld a, [wD7A9]
    and a, a
    jr nz, Jump_01B_6BD7
    call PadWD7DDWithFFToThree
    ld a, $05
    call ShowStringA10_Bank1B
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_01B_6BD7::
    ld a, $04
    call ShowStringA10_Bank1B
    call PadWD7DDWithFFToThree
    ld a, [wD7DC]
    ld [wD7B4], a
    ld a, $03
    ld [wD7DC], a
    ld a, [wD782]
    add a, $02
    ld [wD782], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ret

; entry 5 of the `rst $00` table in Func_01B_6A5E
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
Func_01B_6A5E_Case05::
Jump_01B_6BF7:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    call FinishWD7DDEntryAndAdvance
    ld a, $0C
    call ShowStringA10_Bank1B
    ret

; entry 7 of the `rst $00` table in Func_01B_6A5E
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wMenuInputResult, wTwoChoiceCursor, wD782
; writes: wD780, wD781, wD782, wLinkSendByte, wD7DC, wD7E0
Func_01B_6A5E_Case07::
Jump_01B_6C05:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_01B_6C23
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0B
    call ShowStringA10_Bank1B
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_01B_6C23::
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_01B_6C37
    cp a, $FF
    jr z, Jump_01B_6C4D
    ret

Jump_01B_6C37::
    call DrawChoiceBoxByWD04CBit7
    ld a, $04
    ld [wD7DC], a
    ld a, $FF
    ld [wD7E0], a
    ld a, [wD782]
    sub a, $02
    ld [wD782], a
    ret

Jump_01B_6C4D::
    ld a, [wTwoChoiceCursor]
    and a, a
    jr nz, Jump_01B_6C37
    call DrawChoiceBoxByWD04CBit7
    ld a, $06
    call ShowStringA10_Bank1B
    ld a, $03
    ld [wD782], a
    ret

; entry 5 of the `rst $00` table in ScriptCommandEF_Run_Bank1B
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandEF_Run_Bank1B_Case05::
Jump_01B_6C61:: ; address name
    ld a, [wD781]
    rst $00
    dw ScriptCommandEF_Run_Bank1B_Case05_Case00
    dw ScriptCommandEF_Run_Bank1B_Case05_Case01
    dw ScriptCommandEF_Run_Bank1B_Case05_Case02
    dw ScriptCommandEF_Run_Bank1B_Case05_Case03
    dw ScriptCommandEF_Run_Bank1B_Case05_Case04
    dw ScriptCommandEF_Run_Bank1B_Case05_Case05
    dw ScriptCommandEF_Run_Bank1B_Case05_Case06
    dw ScriptCommandEF_Run_Bank1B_Case05_Case07
    dw ScriptCommandEF_Run_Bank1B_Case05_Case08
    dw ScriptCommandEF_Run_Bank1B_Case05_Case09
    dw ScriptCommandEF_Run_Bank1B_Case05_Case0A
    dw ScriptCommandEF_Run_Bank1B_Case05_Case02
    dw ScriptCommandEF_Run_Bank1B_Case05_Case0C
    dw ScriptCommandEF_Run_Bank1B_Case05_Case0D
    dw ScriptCommandEF_Run_Bank1B_Case05_Case02
    dw ScriptCommandEF_Run_Bank1B_Case05_Case0F
    dw ScriptCommandEF_Run_Bank1B_Case05_Case10
    dw ScriptCommandEF_Run_Bank1B_Case05_Case11
    dw ScriptCommandEF_Run_Bank1B_Case05_Case0A
    dw ScriptCommandEF_Run_Bank1B_Case05_Case02
    dw ScriptCommandEF_Run_Bank1B_Case05_Case03
    dw ScriptCommandEF_Run_Bank1B_Case05_Case15

; entry 17 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
ScriptCommandEF_Run_Bank1B_Case05_Case11::
Jump_01B_6C91:: ; address name
    ld a, $09
    call ShowStringA10_Bank1B
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 9 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
ScriptCommandEF_Run_Bank1B_Case05_Case09::
Jump_01B_6C9E:: ; address name
    ld a, $0C
    call ShowStringA10_Bank1B
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 10 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD781
; writes: wD781
ScriptCommandEF_Run_Bank1B_Case05_Case0A::
Jump_01B_6CAB:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 0 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD781
; writes: wD781
ScriptCommandEF_Run_Bank1B_Case05_Case00::
Jump_01B_6CB8:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    call DrawWD7DDRecordNamesAndIcons
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 1 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wD7E0, wD781
; writes: rRAMG2, rRAMB, wD781
; points at: wRecordBufA, sA00F, sA000
ScriptCommandEF_Run_Bank1B_Case05_Case01::
Jump_01B_6CC8:: ; address name
    ld a, [wD7E0]
    cp a, $FF
    jr nz, Jump_01B_6CEC
    ld hl, wRecordBufA
    ld bc, $00A5
    xor a, a
    call FillBytes
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, sA00F
    ld de, wRecordBufA + $F
    ld b, $0A
    jr Jump_01B_6D03

Jump_01B_6CEC::
    ld c, $A5
    call Multiply8
    ld de, sA000
    add hl, de
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld de, wRecordBufA
    ld b, $A5

Jump_01B_6D03::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_01B_6D03
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 2 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781, wLinkSendByte
ScriptCommandEF_Run_Bank1B_Case05_Case02::
Jump_01B_6D11:: ; address name
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

; entry 3 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wD781
; writes: wD780, wD781, wD782, wLinkSendByte
ScriptCommandEF_Run_Bank1B_Case05_Case03::
Jump_01B_6D1E:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    jr z, Jump_01B_6D3F
    cp a, $FE
    ret nz
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0B
    call ShowStringA10_Bank1B
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_01B_6D3F::
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 4 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferCountLo, wLinkBufferCountHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkSendByte, ...
; points at: wRecordBufA, wRecordBufB
ScriptCommandEF_Run_Bank1B_Case05_Case04::
Jump_01B_6D4B:: ; address name
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld hl, wRecordBufA
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, $00A5
    ld a, l
    ld [wLinkBufferCountLo], a
    ld a, h
    ld [wLinkBufferCountHi], a
    ld hl, wRecordBufB
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $FF
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; entry 16 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wD781
; writes: wLinkReady, wLinkSendByte, wD781
ScriptCommandEF_Run_Bank1B_Case05_Case10::
Jump_01B_6D7E:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    ld a, $00
    ld [wLinkReady], a
    ld a, $00
    ld [wLinkSendByte], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 5 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wD781
; writes: wLinkReady, wLinkSendByte, wD781
ScriptCommandEF_Run_Bank1B_Case05_Case05::
Jump_01B_6D96:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    ld a, $00
    ld [wLinkReady], a
    ld a, $00
    ld [wLinkSendByte], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $08
    call ShowStringA10_Bank1B
    ret

; entry 6 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD781
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wTwoChoiceCursor, wD781
ScriptCommandEF_Run_Bank1B_Case05_Case06::
Jump_01B_6DB3:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld hl, vTiles2 + $300
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0E01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a, a
    ld [wStringCategory], a
    ld a, $1F
    ld [wStringIndex], a
    farcall ShowString_Bank1B_481A
    ld a, $6C
    call QueueSoundEffect
    ld de, Data_01B_78E9
    ld hl, wWindowTileBuffer + $E7
    ld bc, $0907
    call CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    call SetDefaultStringWindow_Bank1B
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 7 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wMenuInputResult, wTwoChoiceCursor, wD04C, wD781, wRecordBufB, wD780, wD7AB, ...
; writes: wD780, wD781, wD782, wLinkSendByte, wD7B2, wD7B3, wD7B5, wD7B6, ...
ScriptCommandEF_Run_Bank1B_Case05_Case07::
Jump_01B_6E09:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_01B_6E27
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0B
    call ShowStringA10_Bank1B
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_01B_6E27::
    farcall HandleThreeChoiceCursorInput_F1
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_01B_6E3B
    cp a, $FF
    jr z, Jump_01B_6E52
    ret

Jump_01B_6E3B::
    ld a, $02
    ld [wD780], a
    ld a, $0A
    call ShowStringA10_Bank1B
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_01B_6E52::
    ld a, [wTwoChoiceCursor]
    and a, a
    jr z, Jump_01B_6E5E
    cp a, $01
    jr z, Jump_01B_6E67
    jr Jump_01B_6E3B

Jump_01B_6E5E::
    ld a, [wD781]
    add a, $02
    ld [wD781], a
    ret

Jump_01B_6E67::
    ld a, [wD04C]
    bit 7, a
    jr nz, Jump_01B_6E7B
    ld a, $14
    call ShowStringA10_Bank1B
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_6E7B::
    ld a, [wRecordBufB]
    and a, a
    jr nz, Jump_01B_6E8E
    ld a, $15
    call ShowStringA10_Bank1B
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_6E8E::
    ld a, [wD780]
    ld [wD7B2], a
    ld a, [wD781]
    ld [wD7B3], a
    ld a, $0D
    ld [wD780], a
    ld a, [wD7AB]
    ld [wD7B5], a
    ld a, [wD7AF]
    ld [wD7B6], a
    xor a, a
    ld [wD7AB], a
    ld [wD7AF], a
    ld [wD781], a
    ld [wD782], a
    ret

; entry 8 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wD781
; writes: wD781
ScriptCommandEF_Run_Bank1B_Case05_Case08::
Jump_01B_6EB9:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wD781]
    dec a
    ld [wD781], a
    ret

; entry 12 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wD781
; writes: wD780, wD781, wD782, wLinkSendByte
ScriptCommandEF_Run_Bank1B_Case05_Case0C::
Jump_01B_6EC6:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    jr z, Jump_01B_6EE7
    cp a, $FE
    ret nz
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $0B
    call ShowStringA10_Bank1B
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_01B_6EE7::
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 13 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRole, wD781
; writes: wLinkSceneByte4B, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wD781
; points at: wBattlerRecords, wD1BF
ScriptCommandEF_Run_Bank1B_Case05_Case0D::
Jump_01B_6EF3:: ; address name
    ld a, [wLinkRole]
    bit 1, a
    jr nz, Jump_01B_6F1F
    xor a, a
    ld [wLinkSceneByte4B], a
    call ScriptCommandEF_Run_Bank1B_Case05_Case0D_Sub01
    ld hl, wBattlerRecords
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, wD1BF
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01B_6F1F::
    ld a, $01
    ld [wLinkSceneByte4B], a
    call ScriptCommandEF_Run_Bank1B_Case05_Case0D_Sub01
    ld hl, wD1BF
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, wBattlerRecords
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 15 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wD781
; writes: wD781, wLinkBufferCountLo, wLinkBufferCountHi, wLinkSendByte, wLinkReady
ScriptCommandEF_Run_Bank1B_Case05_Case0F::
Jump_01B_6F45:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld hl, $00EA
    ld a, l
    ld [wLinkBufferCountLo], a
    ld a, h
    ld [wLinkBufferCountHi], a
    ld a, $FF
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; entry 21 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wGameMode, wModeState, wGameMode2State, wGameMode2Arg, wModeChangeRequest, wLinkSession, wLinkExchangeState, wLinkSendByte, ...
ScriptCommandEF_Run_Bank1B_Case05_Case15::
Jump_01B_6F68:: ; address name
    ld a, $04
    ld [wGameMode], a
    xor a, a
    ld [wModeState], a
    ld [wGameMode2State], a
    ld [wGameMode2Arg], a
    ld a, $01
    ld [wModeChangeRequest], a
    ld a, $01
    ld [wLinkSession], a
    ld a, $00
    ld [wLinkExchangeState], a
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkMessage], a
    ret

; entry 6 of the `rst $00` table in ScriptCommandEF_Run_Bank1B
; no direct call (reached through a table, a jump or a vector)
; reads: wD781, wD780
; writes: wD781, wD782, wD780
ScriptCommandEF_Run_Bank1B_Case06::
Jump_01B_6F8F:: ; address name
    farcall ScriptCommandE8_Run
    ld a, [wD781]
    cp a, $0A
    ret nz
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, [wD780]
    add a, $03
    ld [wD780], a
    ret

; entry 13 of the `rst $00` table in ScriptCommandEF_Run_Bank1B
; no direct call (reached through a table, a jump or a vector)
; reads: wD780, wD7B5, wD7B6
; writes: wD7AB, wD7AF
ScriptCommandEF_Run_Bank1B_Case0D::
Jump_01B_6FAB:: ; address name
    farcall RunWD780StateWhenNotFading_F1
    ld a, [wD780]
    cp a, $0E
    ret nz
    ld a, [wD7B5]
    ld [wD7AB], a
    ld a, [wD7B6]
    ld [wD7AF], a
    ret

; entry 14 of the `rst $00` table in ScriptCommandEF_Run_Bank1B
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandEF_Run_Bank1B_Case0E::
Jump_01B_6FC4:: ; address name
    ld a, [wD781]
    rst $00
    dw ScriptCommandEF_Run_Bank1B_Case0E_Case00
    dw ScriptCommandEF_Run_Bank1B_Case0E_Case01
    dw ScriptCommandEF_Run_Bank1B_Case0E_Case02
    dw ScriptCommandEF_Run_Bank1B_Case0E_Case03
    dw ScriptCommandEF_Run_Bank1B_Case0E_Case04
    dw ScriptCommandEF_Run_Bank1B_Case0E_Case05
    dw ScriptCommandEF_Run_Bank1B_Case0E_Case06
    dw ScriptCommandEF_Run_Bank1B_Case0E_Case07

; entry 6 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case0E
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wTwoChoiceCursor, wD781
ScriptCommandEF_Run_Bank1B_Case0E_Case06::
Jump_01B_6FD8:: ; address name
    ld hl, vTiles2 + $300
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0E01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a, a
    ld [wStringCategory], a
    ld a, $1F
    ld [wStringIndex], a
    farcall ShowString_Bank1B_481A
    ld de, Data_01B_78E9
    ld hl, wWindowTileBuffer + $E7
    ld bc, $0907
    call CopyRectTo20ByteRows
    call SetDefaultStringWindow_Bank1B
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 15 of the `rst $00` table in ScriptCommandEF_Run_Bank1B
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandEF_Run_Bank1B_Case0F::
Jump_01B_7019:: ; address name
    ld a, [wD781]
    rst $00
    dw ScriptCommandEF_Run_Bank1B_Case0E_Case00
    dw ScriptCommandEF_Run_Bank1B_Case0E_Case01
    dw ScriptCommandEF_Run_Bank1B_Case0E_Case02
    dw ScriptCommandEF_Run_Bank1B_Case0E_Case03
    dw ScriptCommandEF_Run_Bank1B_Case0E_Case04
    dw ScriptCommandEF_Run_Bank1B_Case0E_Case05
    dw ScriptCommandEF_Run_Bank1B_Case0F_Case06
    dw ScriptCommandEF_Run_Bank1B_Case0E_Case07

; entry 0 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case0E
; no direct call (reached through a table, a jump or a vector)
; reads: wD7AB, wD781
; writes: wD781
ScriptCommandEF_Run_Bank1B_Case0E_Case00::
Jump_01B_702D:: ; address name
    call ClearRecordPanelTiles
    ld de, Data_01B_7928
    ld hl, wWindowTileBuffer + $64
    ld bc, $080B
    call CopyRectTo20ByteRows
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_01B_786F
    call StoreBAtWordTableEntry_Bank1B
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 1 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case0E
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B0, wD781
; writes: wD7F1, wD7F2, wD781
ScriptCommandEF_Run_Bank1B_Case0E_Case01::
Jump_01B_704F:: ; address name
    call ListAvailableRecordsForSelection
    farcall ClampRecordListPageCursor5
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_01B_7076
    ld hl, wWindowTileBuffer + $12E
    call StoreC5BEC6AtHLStride2_Bank1B
    ld hl, wWindowTileBuffer + $12F
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    farcall DrawPageOfPagesAtWD7F1_Bank1E

Jump_01B_7076::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 2 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case0E
; no direct call (reached through a table, a jump or a vector)
; writes: wD7F1
ScriptCommandEF_Run_Bank1B_Case0E_Case02::
Jump_01B_707E:: ; address name
    farcall DrawRecordListPageNames
    xor a, a
    ld [wD7F1], a
    farcall MarkPartyMembersInRecordListPage
    ret

; entry 3 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case0E
; no direct call (reached through a table, a jump or a vector)
ScriptCommandEF_Run_Bank1B_Case0E_Case03::
Jump_01B_708F:: ; address name
    call DrawWD789Cell5RecordPanel
    ret

; entry 4 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case0E
; no direct call (reached through a table, a jump or a vector)
ScriptCommandEF_Run_Bank1B_Case0E_Case04::
Jump_01B_7093:: ; address name
    call ClearAndDrawWD789Cell5NameAtTiles1780
    ret

; entry 5 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case0E
; no direct call (reached through a table, a jump or a vector)
ScriptCommandEF_Run_Bank1B_Case0E_Case05::
Jump_01B_7097:: ; address name
    call DrawRuleBoxByWD04CBit7
    ret

; entry 6 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wD7DC, wD781
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wD7AD, wD781
ScriptCommandEF_Run_Bank1B_Case0F_Case06::
Jump_01B_709B:: ; address name
    ld hl, vTiles2 + $700
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0C01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a, a
    ld [wStringCategory], a
    ld a, $1E
    ld [wStringIndex], a
    farcall ShowString_Bank1B_481A
    call CopyWD789Cell5NameToWC130
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a, a
    ld [wStringCategory], a
    ld a, [wD7DC]
    cp a, $03
    jr c, Jump_01B_70E8
    ld a, $17
    jr Jump_01B_70EA

Jump_01B_70E8::
    ld a, $12

Jump_01B_70EA::
    ld [wStringIndex], a
    farcall ShowString_Bank1B_481A
    ld de, Data_01B_7847
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows
    xor a, a
    ld [wD7AD], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 7 of the `rst $00` table in ScriptCommandEF_Run_Bank1B_Case0E
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B2, wD7B3
; writes: hSpriteHideTile, wD782, wD780, wD781, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ScriptCommandEF_Run_Bank1B_Case0E_Case07::
Jump_01B_710B:: ; address name
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    call BGMapAddressAtScroll_Bank1B
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRectToBGMap_1B
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a, a
    ld [wD782], a
    ld a, [wD7B2]
    ld [wD780], a
    ld a, [wD7B3]
    ld [wD781], a
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ret

; only called from ScriptCommandEF_Run_Bank1B_Case05_Case0D (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandEF_Run_Bank1B_Case05_Case0D)
; reads: wLinkRole
; writes: rRAMG2, rRAMB
; points at: wBattlerRecords, wD1BF, wD7DD
ScriptCommandEF_Run_Bank1B_Case05_Case0D_Sub01::
Func_01B_7152:: ; address name
    ld hl, wBattlerRecords
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_01B_715F
    ld hl, wD1BF

Jump_01B_715F::
    ld c, $00

Jump_01B_7161::
    push bc
    push hl
    ld a, c
    ld de, wD7DD
    add a, e
    ld e, a
    jr nc, Jump_01B_716C
    inc d

Jump_01B_716C::
    push de
    ld a, [de]
    cp a, $FF
    jp z, Jump_01B_71DA
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [de]
    ld c, $01
    call SRAMRecordAddress
    ld c, l
    ld b, h
    pop de
    pop hl
    push hl
    push de
    ld e, $0E
    call CopyEBytesBCToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $34
    call SRAMRecordAddress
    ld c, l
    ld b, h
    pop hl
    ld e, $08
    call CopyEBytesBCToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $55
    call SRAMRecordAddress
    ld c, l
    ld b, h
    pop hl
    ld a, [bc]
    ld [hl+], a
    inc bc
    ld a, [bc]
    ld [hl+], a
    inc bc
    inc bc
    ld e, $15
    call CopyEBytesBCToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $6F
    call SRAMRecordAddress
    ld c, l
    ld b, h
    pop hl
    ld e, $1F
    call CopyEBytesBCToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, $A4
    call SRAMRecordAddress
    ld c, l
    ld b, h
    pop hl
    ld a, [bc]
    ld [hl+], a
    ld a, $FF
    ld [hl], a
    jr Jump_01B_71E5

Jump_01B_71DA::
    pop de
    pop hl
    push hl
    push de
    ld bc, $004E
    xor a, a
    call FillBytes

Jump_01B_71E5::
    pop de
    pop hl
    pop bc
    inc c
    ld a, $4E
    add_a_to_hl
    ld a, c
    cp a, $03
    jp c, Jump_01B_7161
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ret

; copies E bytes from BC to HL; BC and HL advance, E = 0 (E-0115)
; 4 call sites from 1 routine (e.g. ScriptCommandEF_Run_Bank1B_Case05_Case0D_Sub01)
CopyEBytesBCToHL::
Func_01B_71FE:: ; address name
    ld a, [bc]
    ld [hl+], a
    inc bc
    dec e
    jr nz, CopyEBytesBCToHL
    ret

; clears the tile rows at vTiles1 + $500, $700, $780, $240 and $4E0, then the rows from wD7DC = 0 and from the saved wD7DC (E-0127)
; 3 call sites from 3 routines (e.g. ScriptCommandEF_Run_Bank1B_Case0E_Case00, Func_033_5215_Table2_Case0E_Case00, Func_033_5215_Table2_Case0F_Case00)
; reads: wD7DC
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wD7DC
ClearRecordPanelTiles::
Func_01B_7205:: ; address name
    ld hl, vTiles1 + $500
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0F01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $700
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0501
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $780
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $240
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0301
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $4E0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0201
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld a, [wD7DC]
    push af
    xor a, a
    ld [wD7DC], a
    call ClearTileRowsFromWD7DC
    pop af
    ld [wD7DC], a
    call DrawWD7DDRecordNamesAndIcons
    ret

; only called from ScriptCommandEF_Run_Bank1B_Case04_Case0A (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandEF_Run_Bank1B_Case04_Case0A)
; reads: wD7F5, wD7F6, wPartyCount
; points at: wPartyList
ScriptCommandEF_Run_Bank1B_Case04_Case0A_Sub02::
Func_01B_728A:: ; address name
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld e, a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList

Jump_01B_72A1::
    ld a, [hl+]
    cp a, e
    jr z, Jump_01B_72AA
    dec b
    jr nz, Jump_01B_72A1
    xor a, a
    ret

Jump_01B_72AA::
    ld a, $FF
    ret

; fills wD7DD[wD7DC] to wD7DD[2] with $FF (does nothing when wD7DC = 3) (E-0122)
; 3 call sites from 2 routines (e.g. FinishWD7DDEntryAndAdvance, Func_01B_6A5E_Case04)
; reads: wD7DC
; points at: wD7DD
PadWD7DDWithFFToThree::
Func_01B_72AD:: ; address name
    ld a, [wD7DC]
    cp a, $03
    ret z
    ld hl, wD7DD
    add_a_to_hl
    ld a, [wD7DC]
    ld b, a
    ld a, $03
    sub a, b
    ld b, a

Jump_01B_72C3::
    ld a, $FF
    ld [hl+], a
    dec b
    jr nz, Jump_01B_72C3
    ret

; only called from routines of ScriptCommandEF_Run_Bank1B (E-0098)
; 3 call sites from 2 routines (e.g. ScriptCommandEF_Run_Bank1B_Shared02, ScriptCommandEF_Run_Bank1B_Shared02_Sub01)
; writes: rRAMG2, rRAMB
; points at: wD7DD
ScriptCommandEF_Run_Bank1B_Shared04::
Func_01B_72CA:: ; address name
    ld hl, wD7DD
    add_a_to_hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ret

; only called from ScriptCommandEF_Run_Bank1B_Shared02 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandEF_Run_Bank1B_Shared02)
; reads: wD7DC, hTemp0
; writes: rRAMG2, rRAMB
; points at: wD7F1, wD7DD
ScriptCommandEF_Run_Bank1B_Shared02_Sub01::
Func_01B_72E7:: ; address name
    ld a, [wD7DC]
    and a, a
    jr nz, Jump_01B_72EF

Jump_01B_72ED::
    xor a, a
    ret

Jump_01B_72EF::
    inc a
    ld b, a
    ld c, $00

Jump_01B_72F3::
    push bc
    ld a, c
    ld c, $0D
    call ScriptCommandEF_Run_Bank1B_Shared04
    pop bc
    push bc
    ld hl, wD7F1
    ld a, c
    add_a_to_hl
    ldh a, [hTemp0]
    and a, $0F
    ld [hl], a
    pop bc
    inc c
    dec b
    jr nz, Jump_01B_72F3
    ld a, [wD7DC]
    ld hl, wD7DD
    add_a_to_hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $0D
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG2], a
    ldh a, [hTemp0]
    and a, $0F
    ld d, a
    ld a, [wD7DC]
    ld b, a
    ld hl, wD7F1

Jump_01B_7339::
    push hl
    ld a, [hl]
    cp a, d
    jr z, Jump_01B_7345
    pop hl
    inc hl
    dec b
    jr nz, Jump_01B_7339
    jr Jump_01B_72ED

Jump_01B_7345::
    pop hl
    ld a, $FF
    ret

; copies box Data_01B_788F or Data_01B_78AD (by bit 7 of wD04C) to wC412 and draws it at scroll + $1CC (E-0124)
; 4 call sites from 2 routines (e.g. Func_01B_6A5E_Case07, Func_01B_6A5E_Case02)
; reads: wD04C
DrawChoiceBoxByWD04CBit7::
Func_01B_7349:: ; address name
    ld a, [wD04C]
    bit 7, a
    jr nz, Jump_01B_735E
    ld de, Data_01B_788F
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows
    jr Jump_01B_736A

Jump_01B_735E::
    ld de, Data_01B_78AD
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows

Jump_01B_736A::
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    ret

; only called from routines of ScriptCommandEF_Run_Bank1B (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommandEF_Run_Bank1B_Case04_Case0C, ScriptCommandEF_Run_Bank1B_Case04_Case0A_Sub01)
; reads: wD04C
ScriptCommandEF_Run_Bank1B_Shared03::
Func_01B_7377:: ; address name
    ld a, [wD04C]
    bit 7, a
    jr nz, Jump_01B_738C
    ld de, Data_01B_77F7
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows
    jr Jump_01B_7398

Jump_01B_738C::
    ld de, Data_01B_781F
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows

Jump_01B_7398::
    ret

; lists in wD789 the stored records (state 1, or 2 unless wD7DC is 3) whose field $6E is clear and that are not already chosen in wD7DD; count in wD7A9 (E-0130)
; 3 call sites from 3 routines (e.g. DrawRecordListPageIndicators_1B, ScriptCommandEF_Run_Bank1B_Case0E_Case01, Func_01B_6A5E_Case00)
; reads: wD7DC, wD7B9
; writes: wD7A9, rRAMG2, rRAMB, wD7B9
; points at: wD789, wD7BE, sA000, wD7DD
ListAvailableRecordsForSelection::
Func_01B_7399:: ; address name
    ld hl, wD789
    ld b, $1E

Jump_01B_739E::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_01B_739E
    ld hl, wD7BE
    ld b, $1E

Jump_01B_73A8::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_01B_73A8
    xor a, a
    ld [wD7A9], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld [wD7B9], a
    ld de, sA000
    ld hl, wD789
    ld b, $00
    ld c, $00

Jump_01B_73C7::
    ld a, [de]
    and a, a
    jr z, Jump_01B_741D
    cp a, $01
    jr z, Jump_01B_73DD
    ld a, [wD7DC]
    cp a, $03
    jr z, Jump_01B_741D
    ld a, [de]
    cp a, $02
    jr z, Jump_01B_73DD
    jr Jump_01B_741D

Jump_01B_73DD::
    push de
    ld a, $6E
    add a, e
    ld e, a
    jr nc, Jump_01B_73E5
    inc d

Jump_01B_73E5::
    ld a, [de]
    and a, a
    jr nz, Jump_01B_7415
    pop de
    ld a, [wD7DC]
    and a, a
    jr z, Jump_01B_7410
    cp a, $03
    jr nc, Jump_01B_7410
    push hl
    push de
    push bc
    ld d, b
    ld hl, wD7DD
    ld a, [wD7DC]
    ld b, a

Jump_01B_73FF::
    ld a, [hl+]
    cp a, d
    jr z, Jump_01B_740B
    dec b
    jr nz, Jump_01B_73FF
    pop bc
    pop de
    pop hl
    jr Jump_01B_7410

Jump_01B_740B::
    pop bc
    pop de
    pop hl
    jr Jump_01B_741D

Jump_01B_7410::
    inc c
    ld a, b
    ld [hl+], a
    jr Jump_01B_741D

Jump_01B_7415::
    pop de
    ld a, [wD7B9]
    inc a
    ld [wD7B9], a

Jump_01B_741D::
    ld a, $A5
    add a, e
    ld e, a
    jr nc, Jump_01B_7424
    inc d

Jump_01B_7424::
    inc b
    ld a, b
    cp a, $1E
    jr c, Jump_01B_73C7
    ld a, c
    ld [wD7A9], a
    xor a, a
    ld [rRAMG2], a
    farcall MovePartyRecordsToFrontOfList
    ret

; wStringIndex = A + $10, wStringCategory = 0, then far-calls BeginStringDisplay_Bank1B_480C (E-0063)
; 32 call sites from 17 routines (e.g. ScriptCommandEF_Run_Bank1B_Case00, ScriptCommandEF_Run_Bank1B_Case02_Case01, ScriptCommandEF_Run_Bank1B_Case04_Case0D, ScriptCommandEF_Run_Bank1B_Shared02, ...)
; writes: wStringIndex, wStringCategory
ShowStringA10_Bank1B::
Func_01B_7439:: ; address name
    add a, $10
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank1B_480C
    ret

; sets the string window: wC52D/wC52E = vTiles1 ($8800), wC52F/wC530 = $02, $12 (E-0067) (the same 23 bytes appear in 2 banks)
; 4 call sites from 4 routines (e.g. ClearTileRowsFromWD7DC, ScriptCommandEF_Run_Bank1B_Case04_Case07, ScriptCommandEF_Run_Bank1B_Case05_Case06, ScriptCommandEF_Run_Bank1B_Case0E_Case06)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
SetDefaultStringWindow_Bank1B::
Func_01B_7449:: ; address name
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ret

; wD09D = field $0D of SRAM record B & $0F (its family), wD09E = wD7F1, then LoadFamilyIconTileForWD09D (E-0122)
; 2 call sites from 2 routines (e.g. DrawWD7DDRecordNamesAndIcons, DrawWD789Cell5RecordPanel)
; reads: hTemp0, wD7F1
; writes: rRAMG2, rRAMB, wD09D, wD09E
LoadFamilyIconTileForRecordB_Bank1B::
Func_01B_7460:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, b
    ld c, $0D
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $0F
    ld [wD09D], a
    ld a, [wD7F1]
    ld [wD09E], a
    farcall LoadFamilyIconTileForWD09D
    xor a, a
    ld [rRAMG2], a
    ret

; only called from DrawWD789Cell5RecordPanel (E-0047)
; 1 call site from 1 routine (e.g. DrawWD789Cell5RecordPanel)
; reads: wD7F1, wD7F2, wD7F3, hTemp0, wDigits
; writes: rRAMG2, rRAMB
DrawWD789Cell5RecordPanel_Sub01::
Func_01B_7487:: ; address name
    ld a, [wD7F1]
    ld b, a
    ld a, [wD7F2]
    ld l, a
    ld a, [wD7F3]
    ld h, a
    push bc
    push hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, b
    ld c, $56
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigitsWC8C0
    ld a, [wDigits + $1]
    add a, $E0
    pop hl
    push hl
    ld [hl+], a
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl+], a
    pop hl
    pop bc
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    push hl
    ld a, b
    ld c, $0E
    ld b, $01
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $01
    add a, $CC
    pop hl
    ld [hl], a
    ret

; clears the 6-tile rows of vTiles2 + $100-$220 from row wD7DC onward, then restores the default window (E-0127)
; 4 call sites from 4 routines (e.g. ScriptCommandEF_Run_Bank1B_Case00, ClearRecordPanelTiles, ScriptCommandEF_Run_Bank1B_Case04_Case0C, ScriptCommandEF_Run_Bank1B_Case04_Case08)
; reads: wD7DC
; writes: wTextWindowRows, wTextWindowWidth, wTextWindowTileLo, wTextWindowTileHi
ClearTileRowsFromWD7DC::
Func_01B_74DC:: ; address name
    ld hl, $0601
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, [wD7DC]
    and a, a
    jr z, Jump_01B_74FB
    cp a, $01
    jr z, Jump_01B_7509
    cp a, $02
    jr z, Jump_01B_7517
    cp a, $03
    jr z, Jump_01B_7525
    jr Jump_01B_7533

Jump_01B_74FB::
    ld hl, vTiles2 + $100
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    call FillTilesFromRequest

Jump_01B_7509::
    ld hl, vTiles2 + $160
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    call FillTilesFromRequest

Jump_01B_7517::
    ld hl, vTiles2 + $1C0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    call FillTilesFromRequest

Jump_01B_7525::
    ld hl, vTiles2 + $220
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    call FillTilesFromRequest

Jump_01B_7533::
    call SetDefaultStringWindow_Bank1B
    ret

; for up to wD7DC records listed at wD7DD draws each name at Data_01B_75A8[n] and loads its family icon into tile Data_01B_75B0[n] (E-0128)
; 3 call sites from 3 routines (e.g. ClearRecordPanelTiles, ScriptCommandEF_Run_Bank1B_Case04_Case0C, ScriptCommandEF_Run_Bank1B_Case05_Case00)
; reads: wD7DC
; writes: rRAMG2, rRAMB, wNameGlyphBuf, wD7F1
; points at: wD7DD
DrawWD7DDRecordNamesAndIcons::
Func_01B_7537:: ; address name
    ld a, [wD7DC]
    and a, a
    jr z, Jump_01B_75A7
    cp a, $01
    jr z, Jump_01B_754D
    cp a, $02
    jr z, Jump_01B_7551
    cp a, $03
    jr z, Jump_01B_7555
    ld b, $04
    jr Jump_01B_7557

Jump_01B_754D::
    ld b, $01
    jr Jump_01B_7557

Jump_01B_7551::
    ld b, $02
    jr Jump_01B_7557

Jump_01B_7555::
    ld b, $03

Jump_01B_7557::
    ld hl, wD7DD
    ld c, $00

Jump_01B_755C::
    push hl
    push bc
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    cp a, $FF
    jr z, Jump_01B_75A0
    ld c, $01
    call CopyRecordNameToWC8CF
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    pop bc
    push bc
    ld a, c
    sla a
    ld hl, Data_01B_75A8
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    call CopyGlyphTilesToVRAM
    pop bc
    pop hl
    push hl
    push bc
    ld a, [hl]
    ld b, a
    ld a, c
    ld hl, Data_01B_75B0
    add_a_to_hl
    ld a, [hl]
    ld [wD7F1], a
    call LoadFamilyIconTileForRecordB_Bank1B

Jump_01B_75A0::
    pop bc
    pop hl
    inc hl
    inc c
    dec b
    jr nz, Jump_01B_755C

Jump_01B_75A7::
    ret

Data_01B_75A8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $10, $91, $70, $91, $D0, $91, $30, $92

Data_01B_75B0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $10, $16, $1C, $22

; with SRAM bank 0 enabled, copies the name of the record stored at WD789 cell 5 (CopyRecordNameToWC8CF, C = 1) and draws its glyphs at vTiles1 + $780 (E-0120)
; 1 call site from 1 routine (e.g. ClearAndDrawWD789Cell5NameAtTiles1780)
; reads: wD7F5, wD7F6
; writes: rRAMG2, rRAMB, wNameGlyphBuf
DrawWD789Cell5RecordNameAtTiles1780::
Func_01B_75B4:: ; address name
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $01
    call CopyRecordNameToWC8CF
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    ld de, vTiles1 + $780
    call CopyGlyphTilesToVRAM
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ret

; only called from routines of ScriptCommandEF_Run_Bank1B (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommandEF_Run_Bank1B_Case04_Case0A, ScriptCommandEF_Run_Bank1B_Case04_Case08)
; reads: wD7F5, wD7F6, wD7DC
; points at: wD7DD
ScriptCommandEF_Run_Bank1B_Shared01::
Func_01B_75E4:: ; address name
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld de, wD7DD
    ld a, [wD7DC]
    add a, e
    ld e, a
    jr nc, Jump_01B_75FD
    inc d

Jump_01B_75FD::
    ld a, [hl]
    ld [de], a
    ret

; only called from routines of ScriptCommandEF_Run_Bank1B (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommandEF_Run_Bank1B_Case04_Case0C, ScriptCommandEF_Run_Bank1B_Case04_Case08)
; reads: wD7DC, wD048, hTemp0, wD047, wD049, wD04A, wD781, wD7F5, ...
; writes: wD781, rRAMG2, rRAMB, rRAMG
; points at: wD049
ScriptCommandEF_Run_Bank1B_Shared02::
Func_01B_7600:: ; address name
    ld a, [wD7DC]
    cp a, $03
    jp z, Jump_01B_76E0
    ld a, [wD048]
    bit 7, a
    jr z, Jump_01B_7688
    bit 6, a
    jr nz, Jump_01B_764B
    ld a, [wD7DC]
    inc a
    ld b, a
    ld c, $00
    ld de, $0000

Jump_01B_761D::
    push bc
    push de
    ld a, c
    ld c, $56
    call ScriptCommandEF_Run_Bank1B_Shared04
    pop de
    ldh a, [hTemp0]
    add a, e
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop bc
    inc c
    dec b
    jr nz, Jump_01B_761D
    ld a, [wD048]
    and a, $01
    ld h, a
    ld a, [wD047]
    ld l, a
    ld a, h
    cp a, d
    jr c, Jump_01B_767A
    jr z, Jump_01B_7645
    jr Jump_01B_7688

Jump_01B_7645::
    ld a, l
    cp a, e
    jr c, Jump_01B_767A
    jr Jump_01B_7688

Jump_01B_764B::
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $56
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG2], a
    ld [rRAMG], a
    ld a, [wD046]
    ld b, a
    ldh a, [hTemp0]
    cp a, b
    jr c, Jump_01B_7688
    jr z, Jump_01B_7688

Jump_01B_767A::
    ld a, $11
    call ShowStringA10_Bank1B
    ld a, [wD781]
    dec a
    ld [wD781], a
    xor a, a
    ret

Jump_01B_7688::
    ld a, [wD049]
    bit 7, a
    jr z, Jump_01B_76E0
    ld a, [wD04A]
    bit 0, a
    jr nz, Jump_01B_76CB
    ld a, [wD7DC]
    ld c, $0D
    call ScriptCommandEF_Run_Bank1B_Shared04
    ldh a, [hTemp0]
    and a, $0F
    sla a
    ld de, Data_01B_7879
    add a, e
    ld e, a
    jr nc, Jump_01B_76AC
    inc d

Jump_01B_76AC::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld bc, wD049
    ld a, [bc]
    and a, h
    jr nz, Jump_01B_76BD
    inc bc
    ld a, [bc]
    and a, l
    jr z, Jump_01B_76E0

Jump_01B_76BD::
    ld a, $12
    call ShowStringA10_Bank1B
    ld a, [wD781]
    dec a
    ld [wD781], a
    xor a, a
    ret

Jump_01B_76CB::
    call ScriptCommandEF_Run_Bank1B_Shared02_Sub01
    cp a, $FF
    jr nz, Jump_01B_76E0
    ld a, $13
    call ShowStringA10_Bank1B
    ld a, [wD781]
    dec a
    ld [wD781], a
    xor a, a
    ret

Jump_01B_76E0::
    ld a, $FF
    ret

; copies the name of the record at WD789 cell 5 (11 bytes) to wC130 (E-0124)
; 4 call sites from 4 routines (e.g. ScriptCommandEF_Run_Bank1B_Case04_Case08, ScriptCommandEF_Run_Bank1B_Case0F_Case06, GameMode6_Update_Case04_Case08_Case00, GameMode6_Update_Case05_Case05)
; reads: wD7F5, wD7F6
; writes: rRAMG2, rRAMB, rRAMG
; points at: wNameGlyphBuf, wTextBuf0
CopyWD789Cell5NameToWC130::
Func_01B_76E3:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld c, $01
    call CopyRecordNameToWC8CF
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
    ld b, $0B

Jump_01B_7708::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_01B_7708
    xor a, a
    ld [rRAMB], a
    ld [rRAMG], a
    ret

; pads wD7DD, wD7B4 = wD7DC, wD7E0 = $FF, wD7DC = 4, clears wD781/wD782 and wD780 += 1 (E-0122)
; 2 call sites from 2 routines (e.g. Func_01B_6A5E_Case05, Func_01B_6A5E_Case04)
; reads: wD7DC, wD780
; writes: wD7B4, wD7E0, wD7DC, wD781, wD782, wD780
FinishWD7DDEntryAndAdvance::
Func_01B_7716:: ; address name
    call PadWD7DDWithFFToThree
    ld a, [wD7DC]
    ld [wD7B4], a
    ld a, $FF
    ld [wD7E0], a
    ld a, $04
    ld [wD7DC], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Data_01B_7738:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B1, $B1, $B1, $B1, $B2

Data_01B_773D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B6, $EA, $ED, $C3, $C3, $F8, $F9, $FA, $FB, $FC, $C3, $C7, $B7, $B3, $B4, $B4
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_01B_7757:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $06F757, $46

Data_01B_779D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $06F79D, $5A

Data_01B_77F7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $10, $C3
    db $B2, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $B5, $C3, $C3, $C3, $C3, $C3, $C3, $C3

Data_01B_781F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $B2, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $B5, $C3, $C3, $C3, $C3, $C3, $C3, $C3

Data_01B_7847:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $70, $71, $72, $73, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $74, $75, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_01B_786F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $79, $C3, $A1, $C3, $C9, $C3, $F1, $C3, $19, $C4

Data_01B_7879:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $40, $00, $20, $00, $10, $00, $08, $00, $04, $00, $02, $00, $01, $80, $00
    db $40, $00, $20, $00, $10, $00

Data_01B_788F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $1E, $C3

Data_01B_78AD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B4, $B4, $B4, $B4, $B4, $B5
    ds $18, $C3

Data_01B_78CB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $76, $77, $78, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $79, $73, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

Data_01B_78E9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $30, $31, $32, $33, $34
    db $35, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $36, $37, $38
    db $39, $3A, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $3B
    db $3C, $3D, $3E, $C3, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_01B_7928:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $06F928, $58
    ds $680, $00
