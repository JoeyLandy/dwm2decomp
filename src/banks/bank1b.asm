SECTION "Bank 1B", ROMX[$4000], BANK[$1B]
    db $1B

; unless wLinkStatus bit 7 is set (then it sets bit 6 and returns), runs the routine for wLinkSession (0: wait for the serial transfer; 1-8: RunLinkSessionNExchange when wLinkMode is set and wLinkRole bit 0 is set); called from ComputeSpriteScrollOffsets (E-0259)
; 1 call site from 1 routine (e.g. ComputeSpriteScrollOffsets)
; reads: wLinkStatus, wLinkSession, wScreenStep, rSB, wLinkScreenSubState, wLinkTimerLo, wMenuState, wGridCursorX, ...
; writes: wLinkStatus, wGlyphListPos, wScreenCounter, wScreenState, wSubMenuCursor2, wGridCursorY, wLinkRole, wJoypadReadFlag, ...
; points at: wGameMode
RunLinkSession::
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
    jr z, RunLinkSession_WaitSerialTransferDone
    ld a, [wLinkSession]
    rst $00
    dw RunLinkSession_WaitSerialTransferDone
    dw RunLinkSession_1Exchange
    dw RunLinkSession_2Exchange
    dw RunLinkSession_3Exchange
    dw RunLinkSession_4Exchange
    dw RunLinkSession_5Exchange
    dw RunLinkSession_6Exchange
    dw RunLinkSession_7Exchange
    dw RunLinkSession_8Exchange

; entry 0 of the `rst $00` table in RunLinkSession
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, rSB, wLinkScreenSubState, wLinkTimerLo, wMenuState, wGridCursorX, wLinkRole, wMapType, ...
; writes: wGlyphListPos, wScreenCounter, wLinkStatus, wScreenState, wSubMenuCursor2, wGridCursorY, wLinkRole, wJoypadReadFlag, ...
; points at: wGameMode
RunLinkSession_WaitSerialTransferDone::
Jump_01B_402A:: ; address name
    ld a, $FF
    ld [wGlyphListPos], a
    xor a, a
    ld [wScreenCounter], a
    ld [wGlyphListPos], a
    call WaitSerialTransferDone
    ld a, [wScreenStep]
    ld [wGlyphListPos], a
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
    call LinkCheckScreenCounterState
    cp a, $FF
    jp z, Jump_01B_4357
    ld a, [wMenuState]
    cp a, $02
    jr z, Jump_01B_407D
    ld a, $02
    ld [wMenuOption], a
    ld a, [wScreenSubStep]
    ld [wGlyphListStart], a
    jp Jump_01B_4357

Jump_01B_407D::
    ld a, [wLinkRole]
    set 0, a
    set 1, a
    ld [wLinkRole], a
    jp Jump_01B_42A4

Jump_01B_408A::
    call LinkCheckScreenCounterState
    cp a, $FF
    jp z, Jump_01B_4357
    ld a, [wMenuState]
    cp a, $03
    jr z, Jump_01B_40A7
    ld a, $03
    ld [wMenuOption], a
    ld a, [wScreenSubStep]
    ld [wGlyphListStart], a
    jp Jump_01B_4357

Jump_01B_40A7::
    ld a, [wLinkRole]
    set 0, a
    set 1, a
    ld [wLinkRole], a
    jp Jump_01B_42C3

Jump_01B_40B4::
    call LinkCheckScreenCounterState
    cp a, $FF
    jp z, Jump_01B_4357
    ld a, [wMenuState]
    cp a, $04
    jr z, Jump_01B_40D1
    ld a, $04
    ld [wMenuOption], a
    ld a, [wScreenSubStep]
    ld [wGlyphListStart], a
    jp Jump_01B_4357

Jump_01B_40D1::
    ld a, [wLinkRole]
    set 0, a
    set 1, a
    ld [wLinkRole], a
    jp Jump_01B_4301

Jump_01B_40DE::
    call LinkCheckScreenCounterState
    cp a, $FF
    jp z, Jump_01B_4357
    ld a, [wMenuState]
    cp a, $06
    jr z, Jump_01B_40FB
    ld a, $06
    ld [wMenuOption], a
    ld a, [wScreenSubStep]
    ld [wGlyphListStart], a
    jp Jump_01B_4357

Jump_01B_40FB::
    ld a, [wLinkRole]
    set 0, a
    set 1, a
    ld [wLinkRole], a
    jp Jump_01B_4320

Jump_01B_4108::
    call LinkCheckScreenCounterState
    cp a, $FF
    jp z, Jump_01B_4357
    ld a, [wMenuState]
    cp a, $05
    jr z, Jump_01B_4125
    ld a, $05
    ld [wMenuOption], a
    ld a, [wScreenSubStep]
    ld [wGlyphListStart], a
    jp Jump_01B_4357

Jump_01B_4125::
    ld a, [wLinkRole]
    set 0, a
    set 1, a
    ld [wLinkRole], a
    jp Jump_01B_42E2

Jump_01B_4132::
    call LinkCheckScreenCounterState
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
    ld a, [wScreenSubStep]
    ld [wGlyphListStart], a
    jp Jump_01B_4357

Jump_01B_4156::
    ld a, [wLinkRole]
    set 0, a
    set 1, a
    ld [wLinkRole], a
    jp Jump_01B_426F

Jump_01B_4163::
    ld a, [wLinkScreenSubState]
    cp a, $02
    jr z, Jump_01B_416D
    jp Jump_01B_4357

Jump_01B_416D::
    ld a, [wLinkTimerLo]
    cp a, b
    jp z, Jump_01B_4357
    call ShortDelayLoop
    ld a, b
    ld [wScreenState], a
    cp a, $F3
    jr nz, Jump_01B_41A1
    ld a, [wMenuState]
    cp a, $07
    jr z, Jump_01B_4194
    ld a, $FF
    ld [wSubMenuCursor2], a
    ld a, [wGridCursorX]
    ld [wGridCursorY], a
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
    ld a, [wGridCursorX]
    ld [wGridCursorY], a
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
    ld a, [wGridCursorX]
    ld [wGridCursorY], a
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
    ld a, [wGridCursorX]
    ld [wGridCursorY], a
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
    ld a, [wGridCursorX]
    ld [wGridCursorY], a
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
    ld a, [wGridCursorX]
    ld [wGridCursorY], a
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
    farcall LoadKeyWorldFlagsRecordFromSRAMSlotKeyWorldSlot

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
; 1 call site from 1 routine (e.g. RunLinkSession_WaitSerialTransferDone)
; writes: wSoundChannelSlots, wSoundChannel1, wSoundChannel2, wSoundChannel3, wSoundChannel4, wSoundChannel5
ClearSoundChannelSlots::
Func_01B_4362:: ; address name
    xor a, a
    ld [wSoundChannelSlots], a
    ld [wSoundChannelSlots + $1], a
    ld [wSoundChannel1], a
    ld [wSoundChannel1 + $1], a
    ld [wSoundChannel2], a
    ld [wSoundChannel2 + $1], a
    ld [wSoundChannel3], a
    ld [wSoundChannel3 + $1], a
    ld [wSoundChannel4], a
    ld [wSoundChannel4 + $1], a
    ld [wSoundChannel5], a
    ld [wSoundChannel5 + $1], a
    ret

; busy-waits $80 iterations (E-0122)
; 1 call site from 1 routine (e.g. RunLinkSession_WaitSerialTransferDone)
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
; 6 call sites from 1 routine (e.g. RunLinkSession_WaitSerialTransferDone)
; reads: wLinkTimerLo, wLinkScreenSubState, wGameMode, wModeState, wLinkScreenState, wLinkScreenFlag
; writes: wScreenCounter
LinkCheckScreenCounterState::
Func_01B_4394:: ; address name
    ld [wScreenCounter], a
    ld c, a
    ld a, [wLinkTimerLo]
    cp a, c
    jr nz, Jump_01B_43A7
    ld a, [wLinkScreenSubState]
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
    ld a, [wLinkScreenState]
    or a, a
    jr nz, Jump_01B_43CC
    ld a, [wLinkScreenFlag]
    or a, a
    jr nz, Jump_01B_43CC
    ld a, [wLinkScreenSubState]
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
SendLinkByteForMenuOption_Bank1B:: ; heuristic: follows a terminator; C0
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

; address loaded by SendLinkByteForMenuOption_Bank1B
Data_01B_43E1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $F4, $F4, $FA, $FB, $FC, $DD, $E1, $F3

; entry 1 of the `rst $00` table in RunLinkSession
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole
RunLinkSession_1Exchange::
Jump_01B_43E9:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_01B_43F9
    ld a, [wLinkRole]
    bit 0, a
    jr z, Jump_01B_43F9
    call RunLinkSession1Exchange

Jump_01B_43F9::
    ret

; runs the routine for wC582 (jump table of two) (E-0122)
; 1 call site from 1 routine (e.g. RunLinkSession_1Exchange)
; reads: wLinkExchangeState
RunLinkSession1Exchange::
Func_01B_43FA:: ; address name
    ld a, [wLinkExchangeState]
    rst $00
    dw RunLinkSession1Exchange_ToLinkSendStepWithBuffer
    dw RunLinkSession1Exchange_LinkReceiveStepWithBuffer

; entry 0 of the `rst $00` table in RunLinkSession1Exchange
; no direct call (reached through a table, a jump or a vector)
RunLinkSession1Exchange_ToLinkSendStepWithBuffer::
Jump_01B_4402:: ; address name
    call LinkSendStepWithBuffer
    ret

; entry 1 of the `rst $00` table in RunLinkSession1Exchange
; no direct call (reached through a table, a jump or a vector)
; points at: wVBlankFlags
RunLinkSession1Exchange_LinkReceiveStepWithBuffer::
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

; entry 2 of the `rst $00` table in RunLinkSession
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole
RunLinkSession_2Exchange::
Jump_01B_4420:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_01B_4430
    ld a, [wLinkRole]
    bit 0, a
    jr z, Jump_01B_4430
    call RunLinkSession2Exchange

Jump_01B_4430::
    ret

; runs the routine for wC582 (jump table of two) (E-0122)
; 1 call site from 1 routine (e.g. RunLinkSession_2Exchange)
; reads: wLinkExchangeState
RunLinkSession2Exchange::
Func_01B_4431:: ; address name
    ld a, [wLinkExchangeState]
    rst $00
    dw RunLinkSession2Exchange_ToLinkSendStepWithBuffer
    dw RunLinkSession2Exchange_LinkReceiveStepWithBuffer

; entry 0 of the `rst $00` table in RunLinkSession2Exchange
; no direct call (reached through a table, a jump or a vector)
RunLinkSession2Exchange_ToLinkSendStepWithBuffer::
Jump_01B_4439:: ; address name
    call LinkSendStepWithBuffer
    ret

; entry 1 of the `rst $00` table in RunLinkSession2Exchange
; no direct call (reached through a table, a jump or a vector)
; points at: wVBlankFlags
RunLinkSession2Exchange_LinkReceiveStepWithBuffer::
Jump_01B_443D:: ; address name
    call LinkReceiveStepWithBuffer
    ld hl, wVBlankFlags
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call RunFrameTickFadeAndCounter_Bank1B
    farcall RunScreenStateWhenNotFading_F1
    ld hl, wVBlankFlags
    res 1, [hl]
    ret

; entry 3 of the `rst $00` table in RunLinkSession
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole
RunLinkSession_3Exchange::
Jump_01B_4457:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_01B_4467
    ld a, [wLinkRole]
    bit 0, a
    jr z, Jump_01B_4467
    call RunLinkSession3Exchange

Jump_01B_4467::
    ret

; runs the routine for wC582 (jump table of two) (E-0122)
; 1 call site from 1 routine (e.g. RunLinkSession_3Exchange)
; reads: wLinkExchangeState
RunLinkSession3Exchange::
Func_01B_4468:: ; address name
    ld a, [wLinkExchangeState]
    rst $00
    dw RunLinkSession3Exchange_ToLinkSendStepWithBuffer
    dw RunLinkSession3Exchange_LinkReceiveStepWithBuffer

; entry 0 of the `rst $00` table in RunLinkSession3Exchange
; no direct call (reached through a table, a jump or a vector)
RunLinkSession3Exchange_ToLinkSendStepWithBuffer::
Jump_01B_4470:: ; address name
    call LinkSendStepWithBuffer
    ret

; entry 1 of the `rst $00` table in RunLinkSession3Exchange
; no direct call (reached through a table, a jump or a vector)
; points at: wVBlankFlags
RunLinkSession3Exchange_LinkReceiveStepWithBuffer::
Jump_01B_4474:: ; address name
    call LinkReceiveStepWithBuffer
    ld hl, wVBlankFlags
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call RunFrameTickFadeAndCounter_Bank1B
    farcall RunScreenStateWhenNotFading_1B
    ld hl, wVBlankFlags
    res 1, [hl]
    ret

; entry 4 of the `rst $00` table in RunLinkSession
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole
RunLinkSession_4Exchange::
Jump_01B_448E:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_01B_449E
    ld a, [wLinkRole]
    bit 0, a
    jr z, Jump_01B_449E
    call RunLinkSession4Exchange

Jump_01B_449E::
    ret

; runs the routine for wC582 (jump table of two) (E-0122)
; 1 call site from 1 routine (e.g. RunLinkSession_4Exchange)
; reads: wLinkExchangeState
RunLinkSession4Exchange::
Func_01B_449F:: ; address name
    ld a, [wLinkExchangeState]
    rst $00
    dw RunLinkSession4Exchange_ToLinkSendStepWithBuffer
    dw RunLinkSession4Exchange_LinkReceiveStepWithBuffer

; entry 0 of the `rst $00` table in RunLinkSession4Exchange
; no direct call (reached through a table, a jump or a vector)
RunLinkSession4Exchange_ToLinkSendStepWithBuffer::
Jump_01B_44A7:: ; address name
    call LinkSendStepWithBuffer
    ret

; entry 1 of the `rst $00` table in RunLinkSession4Exchange
; no direct call (reached through a table, a jump or a vector)
; points at: wVBlankFlags
RunLinkSession4Exchange_LinkReceiveStepWithBuffer::
Jump_01B_44AB:: ; address name
    call LinkReceiveStepWithBuffer
    ld hl, wVBlankFlags
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call RunFrameTickFadeAndCounter_Bank1B
    farcall RunLinkSession4ScreenState
    ld hl, wVBlankFlags
    res 1, [hl]
    ret

; entry 5 of the `rst $00` table in RunLinkSession
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole
RunLinkSession_5Exchange::
Jump_01B_44C5:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_01B_44D5
    ld a, [wLinkRole]
    bit 0, a
    jr z, Jump_01B_44D5
    call RunLinkSession5Exchange

Jump_01B_44D5::
    ret

; runs the routine for wC582 (jump table of two) (E-0122)
; 1 call site from 1 routine (e.g. RunLinkSession_5Exchange)
; reads: wLinkExchangeState
RunLinkSession5Exchange::
Func_01B_44D6:: ; address name
    ld a, [wLinkExchangeState]
    rst $00
    dw RunLinkSession5Exchange_ToLinkSendStepWithBuffer
    dw RunLinkSession5Exchange_LinkReceiveStepWithBuffer

; entry 0 of the `rst $00` table in RunLinkSession5Exchange
; no direct call (reached through a table, a jump or a vector)
RunLinkSession5Exchange_ToLinkSendStepWithBuffer::
Jump_01B_44DE:: ; address name
    call LinkSendStepWithBuffer
    ret

; entry 1 of the `rst $00` table in RunLinkSession5Exchange
; no direct call (reached through a table, a jump or a vector)
; points at: wVBlankFlags
RunLinkSession5Exchange_LinkReceiveStepWithBuffer::
Jump_01B_44E2:: ; address name
    call LinkReceiveStepWithBuffer
    ld hl, wVBlankFlags
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call RunFrameTickFadeAndCounter_Bank1B
    farcall RunLinkSession5Exchange_Case01_WaitFadeState
    ld hl, wVBlankFlags
    res 1, [hl]
    ret

; entry 6 of the `rst $00` table in RunLinkSession
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole
RunLinkSession_6Exchange::
Jump_01B_44FC:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_01B_450C
    ld a, [wLinkRole]
    bit 0, a
    jr z, Jump_01B_450C
    call RunLinkSession6Exchange

Jump_01B_450C::
    ret

; runs the routine for wC582 (jump table of two) (E-0122)
; 1 call site from 1 routine (e.g. RunLinkSession_6Exchange)
; reads: wLinkExchangeState
RunLinkSession6Exchange::
Func_01B_450D:: ; address name
    ld a, [wLinkExchangeState]
    rst $00
    dw RunLinkSession6Exchange_ToLinkSendStepWithBuffer
    dw RunLinkSession6Exchange_LinkReceiveStepWithBuffer

; entry 0 of the `rst $00` table in RunLinkSession6Exchange
; no direct call (reached through a table, a jump or a vector)
RunLinkSession6Exchange_ToLinkSendStepWithBuffer::
Jump_01B_4515:: ; address name
    call LinkSendStepWithBuffer
    ret

; entry 1 of the `rst $00` table in RunLinkSession6Exchange
; no direct call (reached through a table, a jump or a vector)
; points at: wVBlankFlags
RunLinkSession6Exchange_LinkReceiveStepWithBuffer::
Jump_01B_4519:: ; address name
    call LinkReceiveStepWithBuffer
    ld hl, wVBlankFlags
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call RunFrameTickFadeAndCounter_Bank1B
    farcall RunLinkSession6Exchange_Case01_ReadLinkScreenStateAndLinkScreenSubStateEtc
    ld hl, wVBlankFlags
    res 1, [hl]
    ret

; entry 7 of the `rst $00` table in RunLinkSession
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole
RunLinkSession_7Exchange::
Jump_01B_4533:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_01B_4543
    ld a, [wLinkRole]
    bit 0, a
    jr z, Jump_01B_4543
    call RunLinkSession7Exchange

Jump_01B_4543::
    ret

; runs the routine for wC582 (jump table of two) (E-0122)
; 1 call site from 1 routine (e.g. RunLinkSession_7Exchange)
; reads: wLinkExchangeState
RunLinkSession7Exchange::
Func_01B_4544:: ; address name
    ld a, [wLinkExchangeState]
    rst $00
    dw RunLinkSession7Exchange_ToLinkSendStepWithBuffer
    dw RunLinkSession7Exchange_LinkReceiveStepWithBuffer

; entry 0 of the `rst $00` table in RunLinkSession7Exchange
; no direct call (reached through a table, a jump or a vector)
RunLinkSession7Exchange_ToLinkSendStepWithBuffer::
Jump_01B_454C:: ; address name
    call LinkSendStepWithBuffer
    ret

; entry 1 of the `rst $00` table in RunLinkSession7Exchange
; no direct call (reached through a table, a jump or a vector)
; points at: wVBlankFlags
RunLinkSession7Exchange_LinkReceiveStepWithBuffer::
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

; entry 8 of the `rst $00` table in RunLinkSession
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRole
RunLinkSession_8Exchange::
Jump_01B_456A:: ; address name
    ld a, [wLinkMode]
    or a, a
    jr z, Jump_01B_457A
    ld a, [wLinkRole]
    bit 0, a
    jr z, Jump_01B_457A
    call RunLinkSession8Exchange

Jump_01B_457A::
    ret

; runs the routine for wC582 (jump table of two) (E-0122)
; 1 call site from 1 routine (e.g. RunLinkSession_8Exchange)
; reads: wLinkExchangeState
RunLinkSession8Exchange::
Func_01B_457B:: ; address name
    ld a, [wLinkExchangeState]
    rst $00
    dw RunLinkSession8Exchange_ToLinkSendStepWithBuffer
    dw RunLinkSession8Exchange_LinkReceiveStepWithBuffer

; entry 0 of the `rst $00` table in RunLinkSession8Exchange
; no direct call (reached through a table, a jump or a vector)
RunLinkSession8Exchange_ToLinkSendStepWithBuffer::
Jump_01B_4583:: ; address name
    call LinkSendStepWithBuffer
    ret

; entry 1 of the `rst $00` table in RunLinkSession8Exchange
; no direct call (reached through a table, a jump or a vector)
; points at: wVBlankFlags
RunLinkSession8Exchange_LinkReceiveStepWithBuffer::
Jump_01B_4587:: ; address name
    call LinkReceiveStepWithBuffer
    ld hl, wVBlankFlags
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call RunFrameTickFadeAndCounter_Bank1B
    farcall RunLinkSession8Exchange_Case01_WriteLinkScreenState
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
; 8 call sites from 8 routines (e.g. RunLinkSession1Exchange_ToLinkSendStepWithBuffer, RunLinkSession2Exchange_ToLinkSendStepWithBuffer, RunLinkSession3Exchange_ToLinkSendStepWithBuffer, RunLinkSession4Exchange_ToLinkSendStepWithBuffer, ...)
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
; 8 call sites from 8 routines (e.g. RunLinkSession1Exchange_LinkReceiveStepWithBuffer, RunLinkSession2Exchange_LinkReceiveStepWithBuffer, RunLinkSession3Exchange_LinkReceiveStepWithBuffer, RunLinkSession4Exchange_LinkReceiveStepWithBuffer, ...)
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
; 10 call sites from 10 routines (e.g. RunLinkSession1Exchange_LinkReceiveStepWithBuffer, RunLinkSession2Exchange_LinkReceiveStepWithBuffer, RunLinkSession3Exchange_LinkReceiveStepWithBuffer, RunLinkSession4Exchange_LinkReceiveStepWithBuffer, ...)
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
; reads: rSC, wScreenCounter, wGlyphListPos
; writes: wScreenCounter, wGlyphListPos
WaitSerialTransferWithTimeout:: ; heuristic: follows a terminator; C0
Func_01B_47EE:: ; address name
    ldh a, [rSC]
    bit 7, a
    jr nz, Jump_01B_47F5
    ret

Jump_01B_47F5::
    ld a, [wScreenCounter]
    add a, $01
    ld [wScreenCounter], a
    ld a, [wGlyphListPos]
    adc a, $00
    ld [wGlyphListPos], a
    cp a, $04
    jr c, WaitSerialTransferWithTimeout
    ld a, $FE
    ret

; ld de, this bank's string table / BeginStringDisplay
; 5 call sites from 5 routines (e.g. ShowString_Bank1B_481A, DebugMessageTest_Update_ToBeginStringDisplay_Bank1B_480C, BeginString_Bank1B_Cat0, ShowStringA10_Bank1B, ...)
BeginStringDisplay_Bank1B_480C::
Func_01B_480C:: ; address name
    ld de, StringCategories_1B_4821
    call BeginStringDisplay
    ret
    db $11, $21, $48, $CD, $FE, $25, $C9

; Func_01B_480C (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 12 call sites from 10 routines (e.g. RunScreenStateWhenNotFading_1B_Case01_BuildKeyListIndexListEntries, RunScreenStateWhenNotFading_1B_Case01_Case12_WriteArg5AndTextWindowTileLoEtc, EggServiceMenu_Bank1B_Case04_ShowInfoOKYesN, EggServiceMenu_Bank1B_Case05_ShowBattlePrizeExit, ...)
ShowString_Bank1B_481A::
Func_01B_481A:: ; address name
    call BeginStringDisplay_Bank1B_480C
    call RunStringDisplayToEnd
    ret

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_1B_4821::
Data_01B_4821:: ; address name
    dw StringList_1B_4823 ; id 0

; E-0217 (derived: category list of StringCategories_1B_4821; one pointer per wStringIndex)
; record: string
StringList_1B_4823::
Data_01B_4823:: ; address name
    dw String_1B_4821_00_00 ; id 0
    dw String_1B_4821_00_00 ; id 1
    dw String_1B_4821_00_02 ; id 2
    dw String_1B_4821_00_03 ; id 3
    dw String_1B_4821_00_04 ; id 4
    dw String_1B_4821_00_05 ; id 5
    dw String_1B_4821_00_06 ; id 6
    dw String_1B_4821_00_07 ; id 7
    dw String_1B_4821_00_08 ; id 8
    dw String_1B_4821_00_09 ; id 9
    dw String_1B_4821_00_0A ; id 10
    dw String_1B_4821_00_0B ; id 11
    dw String_1B_4821_00_0C ; id 12
    dw String_1B_4821_00_0D ; id 13
    dw String_1B_4821_00_0E ; id 14
    dw String_1B_4821_00_0F ; id 15
    dw String_1B_4821_00_10 ; id 16
    dw String_1B_4821_00_10 ; id 17
    dw String_1B_4821_00_12 ; id 18
    dw String_1B_4821_00_13 ; id 19
    dw String_1B_4821_00_14 ; id 20
    dw String_1B_4821_00_15 ; id 21
    dw String_1B_4821_00_16 ; id 22
    dw String_1B_4821_00_17 ; id 23
    dw String_1B_4821_00_18 ; id 24
    dw String_1B_4821_00_19 ; id 25
    dw String_1B_4821_00_1A ; id 26
    dw String_1B_4821_00_1B ; id 27
    dw String_1B_4821_00_1C ; id 28
    dw String_1B_4821_00_1D ; id 29
    dw String_1B_4821_00_1D ; id 30
    dw String_1B_4821_00_1F ; id 31
    dw String_1B_4821_00_20 ; id 32
    dw String_1B_4821_00_21 ; id 33
    dw String_1B_4821_00_22 ; id 34
    dw String_1B_4821_00_23 ; id 35
    dw String_1B_4821_00_24 ; id 36
    dw String_1B_4821_00_25 ; id 37
    dw String_1B_4821_00_26 ; id 38
    dw String_1B_4821_00_27 ; id 39

String_1B_4821_00_00:: ; heuristic: string; C0
Data_01B_4873:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Starting key", $F1
    db "trade", $A4, $FA, $F7
    db $F0

String_1B_4821_00_02:: ; heuristic: string; C0
Data_01B_4889:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You refused to", $F1
    db "trade keys.", $FA, $F7
    db $F0

String_1B_4821_00_03:: ; heuristic: string; C0
Data_01B_48A6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Your pal refused", $F1
    db "to trade keys.", $FA, $F7
    db $F0

String_1B_4821_00_04:: ; heuristic: string; C0
Data_01B_48C8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Is it OK to trade", $F1
    db "this key?", $F0

String_1B_4821_00_05:: ; heuristic: string; C0
Data_01B_48E4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "That key cannot be", $F1
    db "traded.", $F7
    db $F0

String_1B_4821_00_06:: ; heuristic: string; C0
Data_01B_4900:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Please choose the", $F1
    db "key to trade.", $F0

String_1B_4821_00_07:: ; heuristic: string; C0
Data_01B_4920:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Please wait.", $F0

String_1B_4821_00_08:: ; heuristic: string; C0
Data_01B_492D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Keys can't have", $F1
    db "the same name.", $F7
    db $F0

String_1B_4821_00_09:: ; heuristic: string; C0
Data_01B_494C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Is it OK to trade", $F1
    db "keys?", $F0

String_1B_4821_00_0A:: ; heuristic: string; C0
Data_01B_4964:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Is it OK to record", $F1
    db "the results?", $F0

String_1B_4821_00_0B:: ; heuristic: string; C0
Data_01B_4984:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Readying trade", $A4, $F1
    db "Please wait.", $F0

String_1B_4821_00_0C:: ; heuristic: string; C0
Data_01B_49A1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Keys will now be", $F1
    db "traded.", $F7
    db $F0

String_1B_4821_00_0D:: ; heuristic: string; C0
Data_01B_49BB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Your pal has a key", $F1
    db "of the same name.", $F7
    db $F0

String_1B_4821_00_0E:: ; heuristic: string; C0
Data_01B_49E1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "TradeExit", $F0

String_1B_4821_00_0F:: ; heuristic: string; C0
Data_01B_49EB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You can't hold any", $F1
    db "more keys.", $F7
    db $F0

String_1B_4821_00_10:: ; heuristic: string; C0
Data_01B_4A09:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Choose the members", $F1
    db "for VS battle.", $F0

String_1B_4821_00_12:: ; heuristic: string; C0
Data_01B_4A2B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Pick ", $F9, "0 for the", $F1
    db "team?", $F0

String_1B_4821_00_13:: ; heuristic: string; C0
Data_01B_4A41:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Choose one more", $F1
    db "member for battle?", $F0

String_1B_4821_00_14:: ; heuristic: string; C0
Data_01B_4A64:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Will you put up a", $F1
    db "prize?", $F0

String_1B_4821_00_15:: ; heuristic: string; C0
Data_01B_4A7D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You have no", $F1
    db "monsters on the", $FA, $F7
    db $EF, $EE, "farm to serve as", $EF, $EE, "the prize.", $F7
    db $F0

String_1B_4821_00_16:: ; heuristic: string; C0
Data_01B_4ABA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Select a monster", $F1
    db "as the prize.", $F0

String_1B_4821_00_17:: ; heuristic: string; C0
Data_01B_4AD9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Put up ", $F9, "0 as a", $F1
    db "prize?", $F0

String_1B_4821_00_18:: ; heuristic: string; C0
Data_01B_4AEF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Begin battle?", $F0

String_1B_4821_00_19:: ; heuristic: string; C0
Data_01B_4AFD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Starting battle", $A4, $F0

String_1B_4821_00_1A:: ; heuristic: string; C0
Data_01B_4B0E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You refused to", $F1
    db "battle.", $F0

String_1B_4821_00_1B:: ; heuristic: string; C0
Data_01B_4B25:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Your pal refused", $F1
    db "to battle.", $F0

String_1B_4821_00_1C:: ; heuristic: string; C0
Data_01B_4B41:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Please wait.", $F0

String_1B_4821_00_1D:: ; heuristic: string; C0
Data_01B_4B4E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "InfoOKYesN", $F0

String_1B_4821_00_1F:: ; heuristic: string; C0
Data_01B_4B59:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "BattlePrizeExit", $F0

String_1B_4821_00_20:: ; heuristic: string; C0
Data_01B_4B69:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "FightInfoEx", $F0

String_1B_4821_00_21:: ; heuristic: string; C0
Data_01B_4B75:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Monster level", $F1
    db "limit exceeded.", $FA, $F7
    db $EF, $EE, "Pick another", $EF, $EE, "monster please.", $F0

String_1B_4821_00_22:: ; heuristic: string; C0
Data_01B_4BB4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "That family is not", $F1
    db "permitted.", $F0

String_1B_4821_00_23:: ; heuristic: string; C0
Data_01B_4BD2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "You already chose", $F1
    db "from that family.", $FA, $F7
    db $EF, $EE, "Pick another", $EF, $EE, "monster please.", $F0

String_1B_4821_00_24:: ; heuristic: string; C0
Data_01B_4C17:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "There is no prize", $F1
    db "for this battle.", $F0

String_1B_4821_00_25:: ; heuristic: string; C0
Data_01B_4C3A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "There is no prize.", $F0

String_1B_4821_00_26:: ; heuristic: string; C0
Data_01B_4C4D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Your pal's key ring", $F1
    db "is full.", $FA, $F7
    db $EF, $EE, "Keys can't be", $EF, $EE, "traded.", $F7
    db $F0

String_1B_4821_00_27:: ; heuristic: string; C0
Data_01B_4C83:: ; address name
    db $F9, $00, $F0

; ld de, this bank's string table / BeginStringDisplay
; 4 call sites from 4 routines (e.g. ShowString_Bank1B_4C94, DebugMessageTest_Update_ToBeginStringDisplay_Bank1B_4C86, BreedMenu_Case04_DrawBottomBoxForLinkAndSetScreenSubStep, BreedMenu_Case04_WriteScreenSubStepAndScreenStepEtc)
BeginStringDisplay_Bank1B_4C86::
Func_01B_4C86:: ; address name
    ld de, StringCategories_1B_4C9B
    call BeginStringDisplay
    ret
    db $11, $9B, $4C, $CD, $FE, $25, $C9

; Func_01B_4C86 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 3 call sites from 3 routines (e.g. DebugResultsDisplay_Init, BreedMenu_Case0F_SetArg5ToListEntriesCell4, ShowSaveFileInfoWindow)
ShowString_Bank1B_4C94::
Func_01B_4C94:: ; address name
    call BeginStringDisplay_Bank1B_4C86
    call RunStringDisplayToEnd
    ret

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_1B_4C9B::
Data_01B_4C9B:: ; address name
    dw StringList_1B_4C9D ; id 0

; E-0217 (derived: category list of StringCategories_1B_4C9B; one pointer per wStringIndex)
; record: string
StringList_1B_4C9D::
Data_01B_4C9D:: ; address name
    dw String_1B_4C9B_00_00 ; id 0
    dw String_1B_4C9B_00_00 ; id 1
    dw String_1B_4C9B_00_02 ; id 2
    dw String_1B_4C9B_00_03 ; id 3
    dw String_1B_4C9B_00_04 ; id 4
    dw String_1B_4C9B_00_05 ; id 5
    dw String_1B_4C9B_00_06 ; id 6
    dw String_1B_4C9B_00_07 ; id 7
    dw String_1B_4C9B_00_08 ; id 8
    dw String_1B_4C9B_00_09 ; id 9
    dw String_1B_4C9B_00_0A ; id 10
    dw String_1B_4C9B_00_0B ; id 11
    dw String_1B_4C9B_00_0C ; id 12
    dw String_1B_4C9B_00_0D ; id 13
    dw String_1B_4C9B_00_0E ; id 14
    dw String_1B_4C9B_00_0F ; id 15
    dw String_1B_4C9B_00_10 ; id 16
    dw String_1B_4C9B_00_11 ; id 17
    dw String_1B_4C9B_00_12 ; id 18
    dw String_1B_4C9B_00_13 ; id 19
    dw String_1B_4C9B_00_14 ; id 20
    dw String_1B_4C9B_00_15 ; id 21
    dw String_1B_4C9B_00_16 ; id 22
    dw String_1B_4C9B_00_17 ; id 23
    dw String_1B_4C9B_00_18 ; id 24
    dw String_1B_4C9B_00_19 ; id 25
    dw String_1B_4C9B_00_1A ; id 26
    dw String_1B_4C9B_00_1B ; id 27
    dw String_1B_4C9B_00_1C ; id 28
    dw String_1B_4C9B_00_1D ; id 29
    dw String_1B_4C9B_00_1E ; id 30
    dw String_1B_4C9B_00_1F ; id 31
    dw String_1B_4C9B_00_1F ; id 32
    dw String_1B_4C9B_00_21 ; id 33
    dw String_1B_4C9B_00_22 ; id 34
    dw String_1B_4C9B_00_22 ; id 35
    dw String_1B_4C9B_00_22 ; id 36
    dw String_1B_4C9B_00_25 ; id 37
    dw String_1B_4C9B_00_26 ; id 38
    dw String_1B_4C9B_00_27 ; id 39
    dw String_1B_4C9B_00_28 ; id 40
    dw Text_1B_5190 ; id 41

String_1B_4C9B_00_00:: ; heuristic: string; C0
Data_01B_4CF1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Welcome. What", $F1
    db "would you like?", $F0

String_1B_4C9B_00_02:: ; heuristic: string; C0
Data_01B_4D12:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Which will be", $F1
    db "the base monster?", $F0

String_1B_4C9B_00_03:: ; heuristic: string; C0
Data_01B_4D35:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " This is the one", $F1
    db "you want?", $F0

String_1B_4C9B_00_04:: ; heuristic: string; C0
Data_01B_4D52:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Is there", $F1
    db "anything else?", $F0

String_1B_4C9B_00_05:: ; heuristic: string; C0
Data_01B_4D6D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You won't have a", $F1
    db "monster with you!", $F7
    db $F0

String_1B_4C9B_00_06:: ; heuristic: string; C0
Data_01B_4D93:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " That's too low", $F1
    db "in level to breed.", $F7
    db $F0

String_1B_4C9B_00_07:: ; heuristic: string; C0
Data_01B_4DB8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " And what will", $F1
    db "its mate be?", $F0

String_1B_4C9B_00_08:: ; heuristic: string; C0
Data_01B_4DD6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " There's no", $F1
    db "potential mate.", $F7
    db $F0

String_1B_4C9B_00_09:: ; heuristic: string; C0
Data_01B_4DF4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $F9, "0", $F1
    db "will result from", $FA, $F7
    db $EF, $EE, "this.", $EF, $EE, $F7
    db $F0

String_1B_4C9B_00_0A:: ; heuristic: string; C0
Data_01B_4E17:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " A great monster", $F1
    db "will be born!", $F7
    db $F0

String_1B_4C9B_00_0B:: ; heuristic: string; C0
Data_01B_4E39:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You already had", $F1
    db "that monster.", $F7
    db $F0

String_1B_4C9B_00_0C:: ; heuristic: string; C0
Data_01B_4E5B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You", $42, "e never had", $F1
    db "that monster.", $F7
    db $F0

String_1B_4C9B_00_0D:: ; heuristic: string; C0
Data_01B_4E7D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " OK to record in", $F1
    db "your Journal?", $F0

String_1B_4C9B_00_0E:: ; heuristic: string; C0
Data_01B_4E9E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Fine, fine!", $F1
    db "I'll do it!", $F7
    db $F0

String_1B_4C9B_00_0F:: ; heuristic: string; C0
Data_01B_4EB9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Hatching that", $F1
    db "will cost ", $F9, "0G.", $FA, $F7
    db $F2, "Should I hatch it", $F1
    db "too?", $F0

String_1B_4C9B_00_10:: ; heuristic: string; C0
Data_01B_4EF2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'll hatch the", $F1
    db "egg too, then.", $F7
    db $F0

String_1B_4C9B_00_11:: ; heuristic: string; C0
Data_01B_4F13:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I won't hatch", $F1
    db "the egg, then.", $F7
    db $F0

String_1B_4C9B_00_12:: ; heuristic: string; C0
Data_01B_4F33:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You don't have", $F1
    db "enough gold, so", $FA, $F7
    db $F2, "I'll just do the", $F1
    db "breeding.", $F7
    db $F0

String_1B_4C9B_00_13:: ; heuristic: string; C0
Data_01B_4F71:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'll send the", $F1
    db "egg to the farm.", $F7
    db $F0

String_1B_4C9B_00_14:: ; heuristic: string; C0
Data_01B_4F93:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Will you take", $F1
    db $F9, "0 with you?", $F0

String_1B_4C9B_00_15:: ; heuristic: string; C0
Data_01B_4FB1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Raise it with", $F1
    db "love and care!", $F7
    db $F0

String_1B_4C9B_00_16:: ; heuristic: string; C0
Data_01B_4FD2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " I'll send ", $F9, "0", $F1
    db "to the farm, then.", $F7
    db $F0

String_1B_4C9B_00_17:: ; heuristic: string; C0
Data_01B_4FF5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Which will go", $F1
    db "back to the farm?", $F0

String_1B_4C9B_00_18:: ; heuristic: string; C0
Data_01B_5018:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Is this the one", $F1
    db "to send home?", $F0

String_1B_4C9B_00_19:: ; heuristic: string; C0
Data_01B_5039:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " ", $F9, "0 is", $F1
    db "going to the farm.", $F7
    db $F0

String_1B_4C9B_00_1A:: ; heuristic: string; C0
Data_01B_5056:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Which egg should", $F1
    db "I hatch?", $F0

String_1B_4C9B_00_1B:: ; heuristic: string; C0
Data_01B_5073:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " That will cost", $F1
    db $F9, "0G. OK?", $F0

String_1B_4C9B_00_1C:: ; heuristic: string; C0
Data_01B_508E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " There isn't a", $F1
    db "single egg here.", $F7
    db $F0

String_1B_4C9B_00_1D:: ; heuristic: string; C0
Data_01B_50B0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You don't have", $F1
    db "enough gold.", $F7
    db $F0

String_1B_4C9B_00_1E:: ; heuristic: string; C0
Data_01B_50CF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " You got the egg", $F1
    db "of ", $F9, "0.", $F7
    db $F0

String_1B_4C9B_00_1F:: ; heuristic: string; C0
Data_01B_50EA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Become a great", $F1
    db "master!", $F7
    db $F0

String_1B_4C9B_00_21:: ; heuristic: string; C0
Data_01B_5105:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $45, " Fine, fine.", $F1
    db "Just wait here.", $F7
    db $F0

String_1B_4C9B_00_22:: ; heuristic: string; C0
Data_01B_5125:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 hatched!", $F7
    db $F0

String_1B_4C9B_00_25:: ; heuristic: string; C0
Data_01B_5132:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Please name it.", $F7
    db $F0

String_1B_4C9B_00_26:: ; heuristic: string; C0
Data_01B_5143:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $F9, "0 went", $F1
    db "away quietly", $A4, $F7
    db $F0

String_1B_4C9B_00_27:: ; heuristic: string; C0
Data_01B_515A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RESULTS", $F1
    db "DISPLAY", $F1
    db $F1
    db "Species", $F1
    db "Gender", $F0

String_1B_4C9B_00_28:: ; heuristic: string; C0
Data_01B_517A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Unused.", $F0, "No save data.", $F0

; E-0197 (C1: the last target of the bank-$1B message pointer table, laid out like its other entries: two control bytes, then text up to $F0).
; record: $EA, $45 (window control bytes, as at the other entries of this pointer table); message
Text_1B_5190::
String_1B_4C9B_00_29:: ; heuristic: start of a structured table; C0
Data_01B_5190:: ; address name
    db $EA, $45 ; entry 0
    db " Accessories will", $F1, "be in the Vault.", $F7, $F0

; E-0197 (C1: no reader found; the 84 words match RejectedNameList in bank $14 in order, each ending in $F0 with no padding; an unreferenced routine follows at $5352).
; record: 84 $F0-terminated words, the same as RejectedNameList (14:$70F0) without padding
RejectedNameListCopy_1B::
Data_01B_51B6:: ; address name
    db "Ass", $F0 ; entry 0: word 0
    db "ASS", $F0 ; word 1
    db "Dink", $F0 ; word 2
    db "DINK", $F0 ; word 3
    db "Dork", $F0 ; word 4
    db "DORK", $F0 ; word 5
    db "Cunt", $F0 ; word 6
    db "CUNT", $F0 ; word 7
    db "Kunt", $F0 ; word 8
    db "KUNT", $F0 ; word 9
    db "Fuck", $F0 ; word 10
    db "FUCK", $F0 ; word 11
    db "Shit", $F0 ; word 12
    db "SHIT", $F0 ; word 13
    db "Sex", $F0 ; word 14
    db "SEX", $F0 ; word 15
    db "Poop", $F0 ; word 16
    db "POOP", $F0 ; word 17
    db "Dong", $F0 ; word 18
    db "DONG", $F0 ; word 19
    db "Pene", $F0 ; word 20
    db "PENE", $F0 ; word 21
    db "Clit", $F0 ; word 22
    db "CLIT", $F0 ; word 23
    db "Twat", $F0 ; word 24
    db "TWAT", $F0 ; word 25
    db "Snot", $F0 ; word 26
    db "SNOT", $F0 ; word 27
    db "Fag", $F0 ; word 28
    db "FAG", $F0 ; word 29
    db "Homo", $F0 ; word 30
    db "HOMO", $F0 ; word 31
    db "Poon", $F0 ; word 32
    db "POON", $F0 ; word 33
    db "Piss", $F0 ; word 34
    db "PISS", $F0 ; word 35
    db "Prick", $F0 ; word 36
    db "PRICK", $F0 ; word 37
    db "Fukk", $F0 ; word 38
    db "FUKK", $F0 ; word 39
    db "Coon", $F0 ; word 40
    db "COON", $F0 ; word 41
    db "Nazi", $F0 ; word 42
    db "NAZI", $F0 ; word 43
    db "Niga", $F0 ; word 44
    db "NIGA", $F0 ; word 45
    db "Nigga", $F0 ; word 46
    db "NIGGA", $F0 ; word 47
    db "Jap", $F0 ; word 48
    db "JAP", $F0 ; word 49
    db "Jew", $F0 ; word 50
    db "JEW", $F0 ; word 51
    db "Wop", $F0 ; word 52
    db "WOP", $F0 ; word 53
    db "Spic", $F0 ; word 54
    db "SPIC", $F0 ; word 55
    db "Butt", $F0 ; word 56
    db "BUTT", $F0 ; word 57
    db "Perv", $F0 ; word 58
    db "PERV", $F0 ; word 59
    db "Dumb", $F0 ; word 60
    db "DUMB", $F0 ; word 61
    db "Dolt", $F0 ; word 62
    db "DOLT", $F0 ; word 63
    db "Anus", $F0 ; word 64
    db "ANUS", $F0 ; word 65
    db "Anal", $F0 ; word 66
    db "ANAL", $F0 ; word 67
    db "Jerk", $F0 ; word 68
    db "JERK", $F0 ; word 69
    db "Puke", $F0 ; word 70
    db "PUKE", $F0 ; word 71
    db "Snot", $F0 ; word 72
    db "SNOT", $F0 ; word 73
    db "Barf", $F0 ; word 74
    db "BARF", $F0 ; word 75
    db "Pus", $F0 ; word 76
    db "PUS", $F0 ; word 77
    db "Pussy", $F0 ; word 78
    db "PUSSY", $F0 ; word 79
    db "Bung", $F0 ; word 80
    db "BUNG", $F0 ; word 81
    db "Suck", $F0 ; word 82
    db "SUCK", $F0 ; word 83

; C1 static reading (E-0197): not reached from any traced code, pointer or far call found; the bytes after the word list at $51B6 decode as one routine: clear $6F bytes from wScreenState, decompress bank $46 $4001 to $8800, far-call F1:$4AA8, LoadPalette0FromData53C6, then wait on wC8CB and jp $077A
; clears $6F bytes from wScreenState, decompresses bank $46 $4001 to $8800, far-calls F1:$4AA8 and LoadPalette0FromData53C6, waits on wC8CB and jumps to $077A; no caller found (E-0197)
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowState
; writes: hScrollY, hScrollX, wTextWindowState, wTextWindowStep, hSpriteWindowClipMode, wLCDCShadow
; points at: wScreenState
UnreferencedScreenInitFromBank46:: ; configured code entry (E-0197); C0
Func_01B_5352:: ; address name
    ld hl, wScreenState
    ld bc, $006F

Jump_01B_5358::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01B_5358
    ld b, $46
    ld de, Tiles1Gfx_46_4001
    ld hl, vTiles1
    call DecompressToRAMLocked
    farcall ClearScreenBufferAndAttributes_BankF1
    call LoadPalette0FromData53C6
    xor a, a
    ldh [hScrollY], a
    ldh [hScrollX], a
    ld a, $FC
    call StartPaletteFade
    ld a, $01
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a

Jump_01B_538B::
    farcall StepTextWindowOpenClose
    ld a, [wTextWindowState]
    and a, $03
    jr nz, Jump_01B_538B
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, $02
    ldh [hSpriteWindowClipMode], a
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $01
    jp Jump_000_077A

; on CGB copies the 8-byte palette Data_01B_53C6 into wBGPaletteBuffer and sets wC526 = $7F (E-0118)
; 3 call sites from 3 routines (e.g. UnreferencedScreenInitFromBank46, GameMode6_Init, GameMode8_Init)
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

; address loaded by LoadPalette0FromData53C6
Data_01B_53C6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $4D, $5E, $FF, $7F, $F2, $66, $00, $00

; unless a fade is running, runs the routine for wD780 (jump table) (E-0122)
; 1 call site from 1 routine (e.g. RunLinkSession3Exchange_LinkReceiveStepWithBuffer)
; reads: wFadeState, wScreenState
RunScreenStateWhenNotFading_1B::
Func_01B_53CE:: ; address name
    ld a, [wFadeState]
    and a, a
    ret nz
    ld a, [wScreenState]
    rst $00
    dw RunScreenStateWhenNotFading_1B_Case00
    dw RunScreenStateWhenNotFading_1B_Case01

; entry 0 of the `rst $00` table in RunScreenStateWhenNotFading_1B
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
RunScreenStateWhenNotFading_1B_Case00::
Jump_01B_53DB:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RunScreenStateWhenNotFading_1B_Case00_CopyBytesDEToHL_Bank1B
    dw RunScreenStateWhenNotFading_1B_Case00_BeginString_Bank1B_Cat0AndStep
    dw RunScreenStateWhenNotFading_1B_Case00_BeginString_Bank1B_Cat0
    dw RunScreenStateWhenNotFading_1B_Case00_WaitTextFlags
    dw RunScreenStateWhenNotFading_1B_Case00_BeginString_Bank1B_Cat0_Case04

; entry 0 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wScreenStep
; writes: wScreenStep
; points at: wScreenTileBuffer, wScreenAttrBuffer
RunScreenStateWhenNotFading_1B_Case00_CopyBytesDEToHL_Bank1B::
Jump_01B_53E9:: ; address name
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank1B
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01B_5407
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank1B

Jump_01B_5407::
    ld de, Tiles1Plus4A0Tiles_1F_4AD0
    ld hl, vTiles2 + $700
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles_1F_4330
    ld hl, vTiles2 + $710
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wLinkSendByte
; points at: wLinkScreenState
RunScreenStateWhenNotFading_1B_Case00_BeginString_Bank1B_Cat0AndStep::
Jump_01B_5429:: ; address name
    ld a, $01
    call BeginString_Bank1B_Cat0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wLinkScreenState
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wScreenStep
RunScreenStateWhenNotFading_1B_Case00_BeginString_Bank1B_Cat0::
Jump_01B_543E:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $07
    call BeginString_Bank1B_Cat0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wScreenStep, wLinkSendByte
RunScreenStateWhenNotFading_1B_Case00_WaitTextFlags::
Jump_01B_5450:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

; entry 4 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenState
; writes: wLinkSendByte, wScreenStep, wScreenState
RunScreenStateWhenNotFading_1B_Case00_BeginString_Bank1B_Cat0_Case04::
Jump_01B_5462:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, $06
    call BeginString_Bank1B_Cat0
    xor a, a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 1 of the `rst $00` table in RunScreenStateWhenNotFading_1B
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
RunScreenStateWhenNotFading_1B_Case01::
Jump_01B_547D:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw RunScreenStateWhenNotFading_1B_Case01_BuildKeyListIndexListEntries
    dw RunScreenStateWhenNotFading_1B_Case01_FillTilesFromRequest
    dw RunScreenStateWhenNotFading_1B_Case01_ClampKeyListPageCursor
    dw RunScreenStateWhenNotFading_1B_Case01_DrawKeyListPageNames
    dw RunScreenStateWhenNotFading_1B_Case01_BGMapAddressAtScroll_Bank1B
    dw RunScreenStateWhenNotFading_1B_Case01_WriteScreenStepAndLinkSendByteEtc
    dw RunScreenStateWhenNotFading_1B_Case01_Case06
    dw RunScreenStateWhenNotFading_1B_Case01_QueueSoundEffect
    dw RunScreenStateWhenNotFading_1B_Case01_WriteScreenStepAndLinkSendByteEtc_Case08
    dw RunScreenStateWhenNotFading_1B_Case01_BeginString_Bank1B_Cat0
    dw RunScreenStateWhenNotFading_1B_Case01_EraseCEntriesOfWordTable_Bank1B
    dw RunScreenStateWhenNotFading_1B_Case01_Case0B
    dw RunScreenStateWhenNotFading_1B_Case01_WaitTextFlags
    dw RunScreenStateWhenNotFading_1B_Case01_WriteScreenStepAndLinkSendByte
    dw RunScreenStateWhenNotFading_1B_Case01_KeyEntryAddressForListEntriesCell4
    dw RunScreenStateWhenNotFading_1B_Case01_WaitLinkMessage
    dw RunScreenStateWhenNotFading_1B_Case01_WriteScreenStepAndSelectedRecordEtc
    dw RunScreenStateWhenNotFading_1B_Case01_Case11
    dw RunScreenStateWhenNotFading_1B_Case01_BeginString_Bank1B_Cat0_Case12
    dw RunScreenStateWhenNotFading_1B_Case01_QueueSoundEffect_Case13
    dw RunScreenStateWhenNotFading_1B_Case01_Case14
    dw RunScreenStateWhenNotFading_1B_Case01_QueueSoundEffect
    dw RunScreenStateWhenNotFading_1B_Case01_WriteScreenStepAndLinkSendByteEtc_Case16
    dw RunScreenStateWhenNotFading_1B_Case01_QueueSoundEffect_Case17
    dw RunScreenStateWhenNotFading_1B_Case01_ToBeginString_Bank1B_Cat0AndStep
    dw RunScreenStateWhenNotFading_1B_Case01_WaitTextFlags
    dw RunScreenStateWhenNotFading_1B_Case01_WriteScreenStepAndLinkSendByte
    dw RunScreenStateWhenNotFading_1B_Case01_ToBeginString_Bank1B_Cat0AndStep_Case1B
    dw RunScreenStateWhenNotFading_1B_Case01_DrawThreeTilesAtBGMap20FFromDE
    dw RunScreenStateWhenNotFading_1B_Case01_KeyEntryAddressForListEntriesCell4_Case1D
    dw RunScreenStateWhenNotFading_1B_Case01_RunScreenCounterStep_61A7
    dw RunScreenStateWhenNotFading_1B_Case01_WaitLinkMessage_Case1F
    dw RunScreenStateWhenNotFading_1B_Case01_WaitLinkMessage_Case20
    dw RunScreenStateWhenNotFading_1B_Case01_DrawThreeTilesAtBGMap20FFromDE_Case21
    dw RunScreenStateWhenNotFading_1B_Case01_RunSaveGameSteps
    dw RunScreenStateWhenNotFading_1B_Case01_WaitTextFlags_Case23
    dw RunScreenStateWhenNotFading_1B_Case01_WaitLinkMessage_Case24

; entry 0 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wStringIndex, wStringCategory, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wListCursor, wListPageIndex, ...
RunScreenStateWhenNotFading_1B_Case01_BuildKeyListIndexListEntries::
Jump_01B_54CB:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld de, TileRect_1B_6483
    ld hl, wWindowTileBuffer + $B4
    ld bc, $0F09
    call CopyRectTo20ByteRows
    farcall BuildKeyListIndexListEntries
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
    ld [wListCursor], a
    ld [wListPageIndex], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenStep
RunScreenStateWhenNotFading_1B_Case01_FillTilesFromRequest::
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wListCursor, wScreenStep
; writes: wArg5, wArg1, wArg2, wScreenStep
RunScreenStateWhenNotFading_1B_Case01_ClampKeyListPageCursor::
Jump_01B_5588:: ; address name
    ld de, TileRect_1B_650A
    ld hl, wWindowTileBuffer + $C9
    ld bc, $0D07
    call CopyRectTo20ByteRows
    ld a, $02
    ld [wArg5], a
    farcall ClampKeyListPageCursor
    ld a, [wListPages]
    cp a, $02
    jr c, Jump_01B_55D4
    ld de, $0189
    call DrawC5BEC6AtScrollOffsetDE_Bank1B
    ld hl, wWindowTileBuffer + $15D
    call StoreC5BEC6AtHLStride2_Bank1B
    ld de, $018A
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    farcall DrawPageOfPagesAtScrollOffset
    ld hl, wWindowTileBuffer + $15E
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    farcall DrawPageOfPagesAtArg1_Bank1E

Jump_01B_55D4::
    ld a, [wListCursor]
    ld b, $BB
    ld hl, Data_01B_65DD
    call StoreBAtWordTableEntry_Bank1B
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg5, wScreenStep
RunScreenStateWhenNotFading_1B_Case01_DrawKeyListPageNames::
Jump_01B_55F3:: ; address name
    ld a, $02
    ld [wArg5], a
    farcall DrawKeyListPageNames
    ld a, $01
    ld [wArg5], a
    farcall DrawKeyListPageMarks
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 4 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep
; writes: wScreenStep
RunScreenStateWhenNotFading_1B_Case01_BGMapAddressAtScroll_Bank1B::
Jump_01B_5611:: ; address name
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    ld a, [wListCursor]
    ld b, $C3
    ld hl, Data_01B_65DD
    call StoreBAtWordTableEntry_Bank1B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep, wJoypadPressedRepeat, wMenuInputResult, wListCursor
; writes: wScreenStep, wLinkSendByte, wMenuInputResult, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
RunScreenStateWhenNotFading_1B_Case01_WriteScreenStepAndLinkSendByteEtc::
Jump_01B_5630:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_01B_5644
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
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
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

Jump_01B_567B::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_01B_5688::
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    ld a, [wListCursor]
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

; entry 6 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
RunScreenStateWhenNotFading_1B_Case01_Case06::
Jump_01B_56B7:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw RunScreenStateWhenNotFading_1B_Case01_Case06_BeginString_Bank1B_Cat0
    dw RunScreenStateWhenNotFading_1B_Case01_Case06_BeginString_Bank1B_Cat0_Case01
    dw RunScreenStateWhenNotFading_1B_Case01_Case06_WaitTextFlags
    dw RunScreenStateWhenNotFading_1B_Case01_Case06_WaitLinkMessage
    dw RunScreenStateWhenNotFading_1B_Case01_Case06_WaitTextFlags_Case04

; entry 0 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wLinkSendByte, wLinkRole, wScreenSubStep
; writes: wLinkSendByte, wScreenSubStep
RunScreenStateWhenNotFading_1B_Case01_Case06_BeginString_Bank1B_Cat0::
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
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 1 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenSubStep
; writes: wScreenSubStep
RunScreenStateWhenNotFading_1B_Case01_Case06_BeginString_Bank1B_Cat0_Case01::
Jump_01B_56F5:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $07
    call BeginString_Bank1B_Cat0
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 2 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenSubStep
; writes: wLinkSendByte, wScreenSubStep
RunScreenStateWhenNotFading_1B_Case01_Case06_WaitTextFlags::
Jump_01B_5707:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 3 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenSubStep
; writes: wLinkSendByte, wScreenSubStep
RunScreenStateWhenNotFading_1B_Case01_Case06_WaitLinkMessage::
Jump_01B_5719:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 4 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wGameMode, wModeState, wModeChangeRequest
; points at: wScreenState
RunScreenStateWhenNotFading_1B_Case01_Case06_WaitTextFlags_Case04::
Jump_01B_572B:: ; address name
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld hl, wScreenState
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

; entry 7 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wTwoChoiceCursor, wScreenStep
RunScreenStateWhenNotFading_1B_Case01_QueueSoundEffect::
Jump_01B_574E:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $6C
    call QueueSoundEffect
    ld de, TileRect_1B_65E9
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 8 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wMenuInputResult, wTwoChoiceCursor, wScreenStep
; writes: wScreenStep, wLinkSendByte, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
RunScreenStateWhenNotFading_1B_Case01_WriteScreenStepAndLinkSendByteEtc_Case08::
Jump_01B_577C:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_01B_578E
    ld a, $06
    ld [wScreenStep], a
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
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
    ld a, [wScreenStep]
    add a, $03
    ld [wScreenStep], a
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

; entry 9 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunScreenStateWhenNotFading_1B_Case01_BeginString_Bank1B_Cat0::
Jump_01B_57E6:: ; address name
    call RunScreenStateWhenNotFading_1B_CopyRectTo20ByteRows
    ld a, $06
    call BeginString_Bank1B_Cat0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 10 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wScreenStep
RunScreenStateWhenNotFading_1B_Case01_EraseCEntriesOfWordTable_Bank1B::
Jump_01B_57F6:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld c, $04
    ld hl, Data_01B_65DD
    call EraseCEntriesOfWordTable_Bank1B
    ld a, $05
    ld [wScreenStep], a
    ret

; entry 11 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
RunScreenStateWhenNotFading_1B_Case01_Case0B::
Jump_01B_5809:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw RunScreenStateWhenNotFading_1B_Case01_Case0B_KeyEntryAddressForListEntriesCell4
    dw RunScreenStateWhenNotFading_1B_Case01_Case0B_WaitTextFlags

; entry 1 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01_Case0B
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wScreenSubStep, wScreenStep
RunScreenStateWhenNotFading_1B_Case01_Case0B_WaitTextFlags::
Jump_01B_5811:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    sub a, $02
    ld [wScreenStep], a
    ret

; entry 0 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01_Case0B
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, hMapId, wScreenStep, wMapType, wKeyWorldSlot
; writes: wScreenSubStep, wScreenStep
RunScreenStateWhenNotFading_1B_Case01_Case0B_KeyEntryAddressForListEntriesCell4::
Jump_01B_5823:: ; address name
    call KeyEntryAddressForListEntriesCell4
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
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
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

; entry 12 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wScreenStep, wLinkSendByte
RunScreenStateWhenNotFading_1B_Case01_WaitTextFlags::
Jump_01B_58E6:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

; entry 28 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wLinkSendByte, wScreenStep
RunScreenStateWhenNotFading_1B_Case01_DrawThreeTilesAtBGMap20FFromDE::
Jump_01B_58F8:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld de, Data_01B_6607
    call DrawThreeTilesAtBGMap20FFromDE
    ld a, $02
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 13 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wScreenStep, wLinkSendByte
RunScreenStateWhenNotFading_1B_Case01_WriteScreenStepAndLinkSendByte::
Jump_01B_5910:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    jr z, Jump_01B_5925
    cp a, $FE
    ret nz
    ld a, $06
    ld [wScreenStep], a
    ld a, $FD
    ld [wLinkSendByte], a
    ret

Jump_01B_5925::
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 14 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wLinkBufferCountLo, wLinkBufferCountHi, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkSendByte, ...
; points at: wLinkRecvBuffer, wKeyList, wLinkPartnerName
RunScreenStateWhenNotFading_1B_Case01_KeyEntryAddressForListEntriesCell4::
Jump_01B_5931:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    call KeyEntryAddressForListEntriesCell4
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
    call WordAddressForListEntriesCell4Item
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

; entry 35 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wLinkSendByte, wScreenStep
RunScreenStateWhenNotFading_1B_Case01_WaitTextFlags_Case23::
Jump_01B_5983:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $05
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 15 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wLinkSendByte, wLinkReady, wScreenStep
RunScreenStateWhenNotFading_1B_Case01_WaitLinkMessage::
Jump_01B_5995:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    xor a, a
    ld [wLinkReady], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 16 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wSelectedRecord, wScreenSubStep
RunScreenStateWhenNotFading_1B_Case01_WriteScreenStepAndSelectedRecordEtc::
Jump_01B_59AB:: ; address name
    call RunScreenStateWhenNotFading_1B_Case01_Case10_Sub01
    cp a, $FF
    jr z, Jump_01B_59D7
    call RunScreenStateWhenNotFading_1B_Case01_Case10_ReadRandomSeed2Lo
    ld a, c
    cp a, $14
    jr z, Jump_01B_59C6
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wSelectedRecord], a
    ret

Jump_01B_59C6::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    ld a, $FE
    ld [wSelectedRecord], a
    ret

Jump_01B_59D7::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    ld a, $FF
    ld [wSelectedRecord], a
    ret

; only called from RunScreenStateWhenNotFading_1B_Case01_Case10 (E-0047)
; 1 call site from 1 routine (e.g. RunScreenStateWhenNotFading_1B_Case01_WriteScreenStepAndSelectedRecordEtc)
; reads: wRandomSeed2Lo, wLinkPartnerName, wLinkPartnerByte1, wLinkPartnerByte2
; points at: wKeyList, wLinkPartnerName
RunScreenStateWhenNotFading_1B_Case01_Case10_Sub01::
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

; only called from RunScreenStateWhenNotFading_1B_Case01_Case10 (E-0047)
; 1 call site from 1 routine (e.g. RunScreenStateWhenNotFading_1B_Case01_WriteScreenStepAndSelectedRecordEtc)
; reads: wRandomSeed2Lo
; points at: wKeyList
RunScreenStateWhenNotFading_1B_Case01_Case10_ReadRandomSeed2Lo::
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
    call KeyEntryAddressForListEntriesCell4
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

; entry 17 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
RunScreenStateWhenNotFading_1B_Case01_Case11::
Jump_01B_5A83:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw RunScreenStateWhenNotFading_1B_Case01_Case11_WriteLinkSendByteAndScreenSubStep
    dw RunScreenStateWhenNotFading_1B_Case01_Case11_WriteItemGridXAndLinkSendByteEtc
    dw RunScreenStateWhenNotFading_1B_Case01_Case11_WriteScreenSubStepAndScreenStep
    dw RunScreenStateWhenNotFading_1B_Case01_Case11_WaitTextFlags
    dw RunScreenStateWhenNotFading_1B_Case01_Case11_BeginString_Bank1B_Cat0

; entry 0 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01_Case11
; no direct call (reached through a table, a jump or a vector)
; reads: wSelectedRecord, wScreenSubStep
; writes: wLinkSendByte, wScreenSubStep
RunScreenStateWhenNotFading_1B_Case01_Case11_WriteLinkSendByteAndScreenSubStep::
Jump_01B_5A91:: ; address name
    ld a, [wSelectedRecord]
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
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 1 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01_Case11
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenSubStep
; writes: wItemGridX, wLinkSendByte, wScreenSubStep
RunScreenStateWhenNotFading_1B_Case01_Case11_WriteItemGridXAndLinkSendByteEtc::
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
    ld [wItemGridX], a
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 2 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01_Case11
; no direct call (reached through a table, a jump or a vector)
; reads: wItemGridX, wSelectedRecord, wScreenStep, wScreenSubStep
; writes: wScreenSubStep, wScreenStep
RunScreenStateWhenNotFading_1B_Case01_Case11_WriteScreenSubStepAndScreenStep::
Jump_01B_5ACF:: ; address name
    ld a, [wItemGridX]
    cp a, $03
    jr z, Jump_01B_5B07
    cp a, $04
    jr z, Jump_01B_5AF8
    ld a, [wSelectedRecord]
    and a, a
    jr nz, Jump_01B_5AEC
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
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
    ld a, [wSelectedRecord]
    cp a, $FE
    jr z, Jump_01B_5B03
    ld a, $26
    jr Jump_01B_5B14

Jump_01B_5B03::
    ld a, $0F
    jr Jump_01B_5B14

Jump_01B_5B07::
    ld a, [wSelectedRecord]
    cp a, $FF
    jr z, Jump_01B_5B12
    ld a, $0D
    jr Jump_01B_5B14

Jump_01B_5B12::
    ld a, $08

Jump_01B_5B14::
    call BeginString_Bank1B_Cat0
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 3 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01_Case11
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenSubStep
; writes: wScreenSubStep
RunScreenStateWhenNotFading_1B_Case01_Case11_WaitTextFlags::
Jump_01B_5B1F:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 4 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01_Case11
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenSubStep, wScreenStep
RunScreenStateWhenNotFading_1B_Case01_Case11_BeginString_Bank1B_Cat0::
Jump_01B_5B2C:: ; address name
    call RunScreenStateWhenNotFading_1B_CopyRectTo20ByteRows
    ld a, $06
    call BeginString_Bank1B_Cat0
    xor a, a
    ld [wScreenSubStep], a
    ld a, $0A
    ld [wScreenStep], a
    ret

; entry 18 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunScreenStateWhenNotFading_1B_Case01_BeginString_Bank1B_Cat0_Case12::
Jump_01B_5B3E:: ; address name
    call RunScreenStateWhenNotFading_1B_Case01_Case12_WriteArg5AndTextWindowTileLoEtc
    ld de, TileRect_1B_6483
    ld hl, wWindowTileBuffer + $64
    ld bc, $0F01
    call CopyRectTo20ByteRows
    ld de, TileRect_1B_65CE
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $09
    call BeginString_Bank1B_Cat0
    ret

; entry 19 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wTwoChoiceCursor, wScreenStep
RunScreenStateWhenNotFading_1B_Case01_QueueSoundEffect_Case13::
Jump_01B_5B7E:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $6C
    call QueueSoundEffect
    ld de, TileRect_1B_65A6
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 20 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wMenuInputResult, wTwoChoiceCursor, wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenStep, wLinkSendByte
RunScreenStateWhenNotFading_1B_Case01_Case14::
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
    ld [wScreenStep], a
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
    ld [wScreenStep], a
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
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
; reads: wTextFlags, wScreenStep
; writes: wTwoChoiceCursor, wScreenStep
ShowTwoChoiceBox65E9WhenTextIdle:: ; heuristic: follows a terminator; C0
Func_01B_5C3B:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld de, TileRect_1B_65E9
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 22 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wMenuInputResult, wTwoChoiceCursor, wScreenStep
; writes: wScreenStep, wLinkSendByte, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
RunScreenStateWhenNotFading_1B_Case01_WriteScreenStepAndLinkSendByteEtc_Case16::
Jump_01B_5C64:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_01B_5C76
    ld a, $06
    ld [wScreenStep], a
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
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
    ld a, [wScreenStep]
    add a, $02
    ld [wScreenStep], a
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

; entry 23 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wScreenStep
RunScreenStateWhenNotFading_1B_Case01_QueueSoundEffect_Case17::
Jump_01B_5CD3:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $6C
    call QueueSoundEffect
    ld de, TileRect_1B_65A6
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    ld a, [wScreenStep]
    sub a, $03
    ld [wScreenStep], a
    ret

; entry 24 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunScreenStateWhenNotFading_1B_Case01_ToBeginString_Bank1B_Cat0AndStep::
Jump_01B_5CFE:: ; address name
    ld a, $07
    call BeginString_Bank1B_Cat0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 27 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
RunScreenStateWhenNotFading_1B_Case01_ToBeginString_Bank1B_Cat0AndStep_Case1B::
Jump_01B_5D0B:: ; address name
    ld a, $0B
    call BeginString_Bank1B_Cat0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 29 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wScreenStep, wScreenCounter, wGlyphListStart, rRAMG2, rRAMB, wLinkTimeoutLo, wLinkTimeoutHi, wLinkSendByte
; points at: wArenaEntry
RunScreenStateWhenNotFading_1B_Case01_KeyEntryAddressForListEntriesCell4_Case1D::
Jump_01B_5D18:: ; address name
    ld a, [wLinkMessage]
    cp a, $02
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenCounter], a
    ld [wGlyphListStart], a
    call KeyEntryAddressForListEntriesCell4
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
    ld de, wArenaEntry
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
    ld hl, wArenaEntry
    ld bc, $0195
    xor a, a
    call FillBytes

Jump_01B_5D7A::
    ld hl, wArenaEntry
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

; entry 30 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wScreenStep, wWorkBuf, wLinkBufferCountLo, wLinkBufferCountHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkSendByte, wLinkReady
; points at: wLinkExchangeBuffer
RunScreenStateWhenNotFading_1B_Case01_RunScreenCounterStep_61A7::
Jump_01B_5D8B:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    call RunScreenCounterStep_61A7
    ld hl, $0195
    ld a, $1E
    call DivideHLByA
    ld [wWorkBuf + $2], a
    ld a, l
    ld [wWorkBuf], a
    ld a, h
    ld [wWorkBuf + $1], a
    ld hl, $001E
    ld a, l
    ld [wLinkBufferCountLo], a
    ld a, h
    ld [wLinkBufferCountHi], a
    ld hl, wLinkExchangeBuffer
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $FF
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; entry 31 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wLinkReady, wLinkSendByte, wScreenStep
RunScreenStateWhenNotFading_1B_Case01_WaitLinkMessage_Case1F::
Jump_01B_5DCF:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    ld a, $00
    ld [wLinkReady], a
    ld a, $01
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 32 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wWorkBuf, wScreenStep
; writes: wWorkBuf, wLinkBufferCountLo, wLinkBufferCountHi, wScreenStep, wLinkSendByte, wLinkReady
RunScreenStateWhenNotFading_1B_Case01_WaitLinkMessage_Case20::
Jump_01B_5DE7:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    ld a, [wWorkBuf]
    ld l, a
    ld a, [wWorkBuf + $1]
    ld h, a
    ld a, h
    or a, l
    jr z, Jump_01B_5E07
    dec hl
    ld a, l
    ld [wWorkBuf], a
    ld a, h
    ld [wWorkBuf + $1], a
    ld hl, $001E
    jr Jump_01B_5E14

Jump_01B_5E07::
    ld a, [wWorkBuf + $2]
    or a, a
    jr z, Jump_01B_5E31
    ld l, a
    ld h, $00
    xor a, a
    ld [wWorkBuf + $2], a

Jump_01B_5E14::
    ld a, l
    ld [wLinkBufferCountLo], a
    ld a, h
    ld [wLinkBufferCountHi], a
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    call RunScreenCounterStep_61A7
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 33 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wArg5, wArg6, wRandomSeed2Lo, wLinkPartnerName, wRandomSeed2Hi, wBattleSetupByteBC, hTemp0, ...
; writes: wScreenStep, wSaveStep, wSaveRecordIndex, hTemp0, wLinkPartnerName, wLinkExchangeBuffer, rRAMG2, rRAMB, ...
; points at: wKeyList, wLinkPartnerName, wKeySeeds, wLinkExchangeBuffer
RunScreenStateWhenNotFading_1B_Case01_DrawThreeTilesAtBGMap20FFromDE_Case21::
Jump_01B_5E41:: ; address name
    ld de, Data_01B_660A
    call DrawThreeTilesAtBGMap20FFromDE
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    call KeyEntryAddressForListEntriesCell4
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
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ldh [hTemp0], a
    farcall DeleteKeyEntryTemp0

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
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
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
    ld a, [wLinkExchangeBuffer]
    and a, $50
    or a, c
    ld [wLinkExchangeBuffer], a
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
    ld hl, wLinkExchangeBuffer
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

; entry 34 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wSaveStep, wScreenStep
; writes: wScreenStep, wScreenCounter
RunScreenStateWhenNotFading_1B_Case01_RunSaveGameSteps::
Jump_01B_5F88:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    farcall RunSaveGameSteps
    ld a, [wSaveStep]
    bit 7, a
    ret z
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenCounter], a
    ld a, $07
    call BeginString_Bank1B_Cat0
    ret

; entry 36 of the `rst $00` table in RunScreenStateWhenNotFading_1B_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage
; writes: wLinkSendByte, hDecompressLock, wGameMode, wModeState, wModeChangeRequest
; points at: wScreenState
RunScreenStateWhenNotFading_1B_Case01_WaitLinkMessage_Case24::
Jump_01B_5FAA:: ; address name
    ld a, [wLinkMessage]
    cp a, $05
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld hl, wScreenState
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
; 1 call site from 1 routine (e.g. RunScreenStateWhenNotFading_1B_Case01_DrawThreeTilesAtBGMap20FFromDE_Case21)
; reads: wLinkExchangeBuffer
; writes: wLinkExchangeBuffer
ClearWD201Bit7AndFourSlots::
Func_01B_5FD4:: ; address name
    ld a, [wLinkExchangeBuffer + $1]
    res 7, a
    ld [wLinkExchangeBuffer + $1], a
    ld bc, $0177
    ld hl, wLinkExchangeBuffer + $1
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

; only called from RunScreenStateWhenNotFading_1B_Case01_Case12 (E-0047)
; 1 call site from 1 routine (e.g. RunScreenStateWhenNotFading_1B_Case01_BeginString_Bank1B_Cat0_Case12)
; reads: wLinkPartnerName, wRandomSeed2Lo, wLinkPartnerByte1, wLinkPartnerByte2, wDataBank
; writes: wArg5, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringIndex, wStringCategory, wDataBank, ...
; points at: wNameGlyphBuf, wTextBuf0
RunScreenStateWhenNotFading_1B_Case01_Case12_WriteArg5AndTextWindowTileLoEtc::
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
    ld [wArg5], a
    jr Jump_01B_606E

Jump_01B_6024::
    ld a, [wRandomSeed2Lo]
    bit 7, a
    jp nz, Jump_01B_60D4
    ld a, $09
    ld [wDataBank], a
    ld a, [wLinkPartnerByte1]
    inc a
    call CopyDataBankString4078ToTextBuf0
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
    call CopyDataBankString4078ToTextBuf0
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
    ld [wArg5], a

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
    ld [wStringIndex], a ; '0'
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
; 2 call sites from 1 routine (e.g. RunScreenStateWhenNotFading_1B_Case01_Case12_WriteArg5AndTextWindowTileLoEtc)
; points at: wTextBuf0
CopyDataBankString4078ToTextBuf0::
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
    ld hl, StringCategories_09_4016
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

; far-calls SetArg5ToListEntriesCell4, reads the key slot stored there and returns HL = wKeyList + 4 * slot (= $C707 + 4 * slot) (E-0120)
; 5 call sites from 5 routines (e.g. RunScreenStateWhenNotFading_1B_Case01_DrawThreeTilesAtBGMap20FFromDE_Case21, RunScreenStateWhenNotFading_1B_Case01_KeyEntryAddressForListEntriesCell4_Case1D, RunScreenStateWhenNotFading_1B_Case01_Case10_ReadRandomSeed2Lo, RunScreenStateWhenNotFading_1B_Case01_KeyEntryAddressForListEntriesCell4, ...)
; reads: wArg5, wArg6
KeyEntryAddressForListEntriesCell4::
Func_01B_6153:: ; address name
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
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

; far-calls SetArg5ToListEntriesCell4, reads the byte at that address and returns HL = $C787 + 2 * that byte (E-0119)
; 1 call site from 1 routine (e.g. RunScreenStateWhenNotFading_1B_Case01_KeyEntryAddressForListEntriesCell4)
; reads: wArg5, wArg6
WordAddressForListEntriesCell4Item::
Func_01B_6170:: ; address name
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
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
; 3 call sites from 3 routines (e.g. RunScreenStateWhenNotFading_1B_Case01_DrawThreeTilesAtBGMap20FFromDE_Case21, RunScreenStateWhenNotFading_1B_Case01_DrawThreeTilesAtBGMap20FFromDE, RunScreenCounterStep_61A7_WriteTileBAtBGMap20FPlusGlyphListStart)
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
; 2 call sites from 2 routines (e.g. RunScreenStateWhenNotFading_1B_Case01_WaitLinkMessage_Case20, RunScreenStateWhenNotFading_1B_Case01_RunScreenCounterStep_61A7)
; reads: wScreenCounter
RunScreenCounterStep_61A7::
Func_01B_61A7:: ; address name
    ld a, [wScreenCounter]
    rst $00
    dw RunScreenCounterStep_61A7_WriteScreenCounter
    dw WriteTileBAtBGMap20FPlusGlyphListStartWithBBC
    dw RunScreenCounterStep_61A7_WriteScreenCounter
    dw WriteTileBAtBGMap20FPlusGlyphListStartWithBBC
    dw RunScreenCounterStep_61A7_WriteScreenCounter
    dw RunScreenCounterStep_61A7_WriteTileBAtBGMap20FPlusGlyphListStart

; entry 0 of the `rst $00` table in RunScreenCounterStep_61A7
; no direct call (reached through a table, a jump or a vector)
; reads: wGlyphListStart, wScreenCounter
; writes: wScreenCounter
RunScreenCounterStep_61A7_WriteScreenCounter::
Jump_01B_61B7:: ; address name
    ld b, $C3
    jr WriteTileBAtBGMap20FPlusGlyphListStart

; entry 1 of the `rst $00` table in RunScreenCounterStep_61A7
; no direct call (reached through a table, a jump or a vector)
; reads: wGlyphListStart, wScreenCounter
; writes: wScreenCounter
WriteTileBAtBGMap20FPlusGlyphListStartWithBBC::
Jump_01B_61BB:: ; address name
    ld b, $BC

; writes B at vBGMap0 + $20F + wD785 (WaitForVRAMAccess, interrupts off), then wD783 += 1 (E-0118)
; 1 call site from 1 routine (e.g. RunScreenCounterStep_61A7_WriteTileBAtBGMap20FPlusGlyphListStart)
; reads: wGlyphListStart, wScreenCounter
; writes: wScreenCounter
WriteTileBAtBGMap20FPlusGlyphListStart::
Func_01B_61BD:: ; address name
    ld hl, vBGMap0 + $20F
    ld a, [wGlyphListStart]
    add_a_to_hl
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    ret

; entry 5 of the `rst $00` table in RunScreenCounterStep_61A7
; no direct call (reached through a table, a jump or a vector)
; reads: wGlyphListStart
; writes: wScreenCounter, wGlyphListStart
RunScreenCounterStep_61A7_WriteTileBAtBGMap20FPlusGlyphListStart::
Jump_01B_61D7:: ; address name
    ld b, $BB
    call WriteTileBAtBGMap20FPlusGlyphListStart
    xor a, a
    ld [wScreenCounter], a
    ld a, [wGlyphListStart]
    inc a
    ld [wGlyphListStart], a
    cp a, $03
    ret c
    xor a, a
    ld [wGlyphListStart], a
    ld de, Data_01B_6607
    call DrawThreeTilesAtBGMap20FFromDE
    ret

; A = string index: wStringIndex = A, wStringCategory = 0, then BeginStringDisplay_Bank1B_480C
; 18 call sites from 17 routines (e.g. RunScreenStateWhenNotFading_1B_Case00_BeginString_Bank1B_Cat0_Case04, RunScreenStateWhenNotFading_1B_Case00_BeginString_Bank1B_Cat0, RunScreenStateWhenNotFading_1B_Case00_BeginString_Bank1B_Cat0AndStep, RunScreenStateWhenNotFading_1B_Case01_RunSaveGameSteps, ...)
; writes: wStringIndex, wStringCategory
BeginString_Bank1B_Cat0::
Func_01B_61F5:: ; address name
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank1B_480C
    ret

; only called from routines of RunScreenStateWhenNotFading_1B (E-0098)
; 2 call sites from 2 routines (e.g. RunScreenStateWhenNotFading_1B_Case01_BeginString_Bank1B_Cat0, RunScreenStateWhenNotFading_1B_Case01_Case11_BeginString_Bank1B_Cat0)
; writes: wArg1, wArg2
RunScreenStateWhenNotFading_1B_CopyRectTo20ByteRows::
Func_01B_6203:: ; address name
    ld b, $00
    ld c, $05
    ld hl, $027A
    ld de, $00AE
    xor a, a
    ld [wArg1], a
    ld a, $06
    ld [wArg2], a
    call RunScreenStateWhenNotFading_1B_Shared01_CopyBytesDEToHL_Bank1B
    ld de, TileRect_1B_6565
    ld hl, wWindowTileBuffer + $112
    ld bc, $0105
    call CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    ret

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0
; 24 call sites from 18 routines (e.g. RunScreenStateWhenNotFading_1B_Case01_QueueSoundEffect_Case17, RunScreenStateWhenNotFading_1B_Case01_QueueSoundEffect_Case13, RunScreenStateWhenNotFading_1B_Case01_BeginString_Bank1B_Cat0_Case12, RunScreenStateWhenNotFading_1B_CopyRectTo20ByteRows, ...)
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
; 18 call sites from 17 routines (e.g. RunScreenStateWhenNotFading_1B_Case01_QueueSoundEffect_Case17, RunScreenStateWhenNotFading_1B_Case01_QueueSoundEffect_Case13, RunScreenStateWhenNotFading_1B_Case01_BeginString_Bank1B_Cat0_Case12, RunScreenStateWhenNotFading_1B_CopyRectTo20ByteRows, ...)
; reads: wIsCGB
; writes: wTextCursorLo, wTextCursorHi, rSVBK
; points at: wScreenTileBuffer, wScreenAttrBuffer
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
    ld hl, wScreenAttrBuffer
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
; 20 call sites from 19 routines (e.g. RunScreenStateWhenNotFading_1B_Case01_QueueSoundEffect_Case17, UpdateTwoChoiceCursor_Bank1B_StepBGMapAddressBackOnScrollWrap, RunScreenStateWhenNotFading_1B_Case01_QueueSoundEffect_Case13, RunScreenStateWhenNotFading_1B_Case01_BeginString_Bank1B_Cat0_Case12, ...)
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
; 2 call sites from 2 routines (e.g. RunScreenStateWhenNotFading_1B_Case00_CopyBytesDEToHL_Bank1B, RunScreenStateWhenNotFading_1B_Shared01_CopyBytesDEToHL_Bank1B)
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
; 2 call sites from 2 routines (e.g. RunScreenStateWhenNotFading_1B_Case00_CopyBytesDEToHL_Bank1B, RunScreenStateWhenNotFading_1B_Shared01_CopyBytesDEToHL_Bank1B)
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
; 10 call sites from 9 routines (e.g. RunScreenStateWhenNotFading_1B_Case01_Case14, EraseCEntriesOfWordTable_Bank1B, RunScreenStateWhenNotFading_1B_Case01_WriteScreenStepAndLinkSendByteEtc, RunScreenStateWhenNotFading_1B_Case01_BGMapAddressAtScroll_Bank1B, ...)
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
; 3 call sites from 3 routines (e.g. RunScreenStateWhenNotFading_1B_Case01_EraseCEntriesOfWordTable_Bank1B, EggServiceMenu_Bank1B_Case04_EraseCEntriesOfWordTable_Bank1B, EggServiceMenu_Bank1B_Case04_Case0A_EraseCEntriesOfWordTable_Bank1B)
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
; 2 call sites from 2 routines (e.g. RunScreenStateWhenNotFading_1B_Case01_ClampKeyListPageCursor, DrawRecordListPageIndicators_1B)
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
; 3 call sites from 3 routines (e.g. RunScreenStateWhenNotFading_1B_Case01_ClampKeyListPageCursor, DrawRecordListPageIndicators_1B, EggServiceMenu_Bank1B_Case0E_ListAvailableRecordsForSelection)
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

; only called from RunScreenStateWhenNotFading_1B_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. RunScreenStateWhenNotFading_1B_CopyRectTo20ByteRows)
; reads: wArg1, wArg2, wIsCGB
; points at: wScreenTileBuffer, wScreenAttrBuffer
RunScreenStateWhenNotFading_1B_Shared01_CopyBytesDEToHL_Bank1B::
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
    ld a, [wArg1]
    ld b, a
    ld a, [wArg2]
    ld c, a
    call CopyBytesDEToHL_Bank1B
    pop de
    pop hl
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01B_63B6
    push hl
    push de
    ld de, wScreenAttrBuffer
    add hl, de
    pop de
    push de
    push hl
    ld hl, wScreenAttrBuffer
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    pop hl
    ld a, [wArg1]
    ld b, a
    ld a, [wArg2]
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
    jr c, RunScreenStateWhenNotFading_1B_Shared01_CopyBytesDEToHL_Bank1B
    ret

; the same instructions as UpdateTwoChoiceCursor_Bank1D, calling this bank's own helpers: wTwoChoiceCursor (0 or 1): Up and Down each toggle it, erase the old cursor (tile $C3), draw the new one (tile $BB), play sound $69 and set wMenuInputResult = $FD; A draws the confirmed cursor (tile $BC), plays sound $69 and sets $FF; B sets $FE; with no input the cursor blinks (wD783 counts frames once wJoypadRepeatTimer reaches $14) and the result is 0. Its cursor positions come from this bank's own table and were not compared (E-0068)
; 1 call site from 1 routine (e.g. RunScreenStateWhenNotFading_1B_Case01_Case14)
; reads: wJoypadPressedRepeat, wJoypadPressed, wTwoChoiceCursor
; writes: wMenuInputResult, wTwoChoiceCursor, wScreenCounter
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
    call UpdateTwoChoiceCursor_Bank1B_WriteScreenCounter
    xor a, a
    ld [wMenuInputResult], a
    ret

Jump_01B_63E9::
    call UpdateTwoChoiceCursor_Bank1B_ReadTwoChoiceCursor_Sub03
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
    call UpdateTwoChoiceCursor_Bank1B_ReadTwoChoiceCursor_Sub03
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
    ld [wScreenCounter], a
    call UpdateTwoChoiceCursor_Bank1B_ReadTwoChoiceCursor
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

Jump_01B_6425::
    call UpdateTwoChoiceCursor_Bank1B_StepBGMapAddressBackOnScrollWrap
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
; reads: wJoypadRepeatTimer, wScreenCounter, wTwoChoiceCursor
; writes: wScreenCounter
UpdateTwoChoiceCursor_Bank1B_WriteScreenCounter::
Func_01B_6439:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, UpdateTwoChoiceCursor_Bank1B_ReadTwoChoiceCursor
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp a, $10
    jr c, UpdateTwoChoiceCursor_Bank1B_ReadTwoChoiceCursor
    cp a, $18
    jr c, UpdateTwoChoiceCursor_Bank1B_ReadTwoChoiceCursor_Sub03
    xor a, a
    ld [wScreenCounter], a

; only called from UpdateTwoChoiceCursor_Bank1B (E-0047)
; 1 call site from 1 routine (e.g. UpdateTwoChoiceCursor_Bank1B)
; reads: wTwoChoiceCursor
UpdateTwoChoiceCursor_Bank1B_ReadTwoChoiceCursor::
Func_01B_6453:: ; address name
    ld b, $BB
    jr Jump_01B_645D

; only called from UpdateTwoChoiceCursor_Bank1B (E-0047)
; 2 call sites from 1 routine (e.g. UpdateTwoChoiceCursor_Bank1B)
; reads: wTwoChoiceCursor
UpdateTwoChoiceCursor_Bank1B_ReadTwoChoiceCursor_Sub03::
Func_01B_6457:: ; address name
    ld b, $C3
    jr Jump_01B_645D

; only called from UpdateTwoChoiceCursor_Bank1B (E-0047)
; 1 call site from 1 routine (e.g. UpdateTwoChoiceCursor_Bank1B)
; reads: wTwoChoiceCursor
UpdateTwoChoiceCursor_Bank1B_StepBGMapAddressBackOnScrollWrap::
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

; address loaded by UpdateTwoChoiceCursor_Bank1B_StepBGMapAddressBackOnScrollWrap
Data_01B_647F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2D, $01, $6D, $01

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 15 x 9 tiles, one row per line
TileRect_1B_6483::
Data_01B_6483:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 7
Data_01B_64FB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 13 x 7 tiles, one row per line
TileRect_1B_650A::
Data_01B_650A:: ; address name
    db $C3, $C3, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1A ; id 0
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 1
    db $C3, $C3, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2A ; id 2
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 3
    db $C3, $C3, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3A ; id 4
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 5
    db $C3, $C3, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A ; id 6

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 1 x 5 tiles, one row per line
TileRect_1B_6565::
Data_01B_6565:: ; address name
    db $B7 ; id 0
    db $B7 ; id 1
    db $B7 ; id 2
    db $B7 ; id 3
    db $B5 ; id 4
    db $B6, $C3, $C3, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1A, $B7, $B6
    db $C3, $C3, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2A, $B7, $B6, $C3
    db $C3, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $B7, $B6, $C3, $C3
    db $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $B7

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 5 tiles, one row per line
TileRect_1B_65A6::
Data_01B_65A6:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $50, $51, $52, $53, $54, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $55, $56, $57, $58, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 15 x 1 tiles, one row per line
TileRect_1B_65CE::
Data_01B_65CE:: ; address name
    db $B6, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6A, $6B, $C3, $B7 ; id 0

; address loaded by RunScreenStateWhenNotFading_1B_Case01_ClampKeyListPageCursor, RunScreenStateWhenNotFading_1B_Case01_BGMapAddressAtScroll_Bank1B, RunScreenStateWhenNotFading_1B_Case01_WriteScreenStepAndLinkSendByteEtc, RunScreenStateWhenNotFading_1B_Case01_EraseCEntriesOfWordTable_Bank1B
Data_01B_65DD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $CA, $C3, $F2, $C3, $1A, $C4, $42, $C4

; address loaded by RunScreenStateWhenNotFading_1B_Case01_Case14
Data_01B_65E5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $25, $C4, $4D, $C4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 5 tiles, one row per line
TileRect_1B_65E9::
Data_01B_65E9:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $CE, $CF, $DF, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $A5, $71, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B5 ; id 4

; address loaded by RunScreenStateWhenNotFading_1B_Case01_DrawThreeTilesAtBGMap20FFromDE, RunScreenCounterStep_61A7_WriteTileBAtBGMap20FPlusGlyphListStart
Data_01B_6607:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $BC, $BC, $BC

; address loaded by RunScreenStateWhenNotFading_1B_Case01_DrawThreeTilesAtBGMap20FFromDE_Case21
Data_01B_660A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A0, $A1, $A2

; only called from RunLinkSession4ScreenState_Case06 (E-0047)
; 1 call site from 1 routine (e.g. RunLinkSession4ScreenState_Case06_DecompressToVRAMAndStep)
; reads: wTextWindowState
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wTextWindowState, wTextWindowStep, hSpriteWindowClipMode
; points at: wScreenState
RunLinkSession4ScreenState_Case06_DecompressToVRAM::
Func_01B_660D:: ; address name
    ld hl, wScreenState
    ld bc, $006F

Jump_01B_6613::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_01B_6613
    ld b, $46
    ld de, Tiles1Gfx_46_4001
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

; the same instruction sequence as EggServiceMenu (bank $0D) apart from label operands, which refer to this bank's own routines and tables; the twin's note describes the shape (E-0107)
; 4 call sites from 4 routines (e.g. RunLinkSession4ScreenState_ToEggServiceMenu_Bank1B, GameMode6_Update_Case04_ToEggServiceMenu_Bank1B, GameMode6_Update_Case0F_ToEggServiceMenu_Bank1B, GameMode6_Update_Case0F_ShowSwitchWithWhich)
; reads: wScreenState
EggServiceMenu_Bank1B::
Func_01B_665E:: ; address name
    ld a, [wScreenState]
    rst $00
    dw EggServiceMenu_Bank1B_ShowStringA10_Bank1B
    dw EggServiceMenu_Bank1B_WaitTextFlags
    dw EggServiceMenu_Bank1B_Case02
    dw EggServiceMenu_Bank1B_AdvanceScreenState
    dw EggServiceMenu_Bank1B_Case04
    dw EggServiceMenu_Bank1B_Case05
    dw EggServiceMenu_Bank1B_SwapMonstersMenu
    dw EggServiceMenu_Bank1B_SwapMonstersMenu
    dw EggServiceMenu_Bank1B_SwapMonstersMenu
    dw EggServiceMenu_Bank1B_SwapMonstersMenu
    dw EggServiceMenu_Bank1B_SwapMonstersMenu
    dw EggServiceMenu_Bank1B_SwapMonstersMenu
    dw EggServiceMenu_Bank1B_SwapMonstersMenu
    dw EggServiceMenu_Bank1B_RunScreenStateWhenNotFading_F1
    dw EggServiceMenu_Bank1B_Case0E
    dw EggServiceMenu_Bank1B_Case0F

; entry 0 of the `rst $00` table in EggServiceMenu_Bank1B
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: hSpriteHideTile, wStringCategory, wScreenState
EggServiceMenu_Bank1B_ShowStringA10_Bank1B::
Jump_01B_6682:: ; address name
    ld a, $C0
    ldh [hSpriteHideTile], a
    xor a, a
    ld [wStringCategory], a
    call ShowStringA10_Bank1B
    call ClearTileRowsFromPickCount
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 1 of the `rst $00` table in EggServiceMenu_Bank1B
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenState
; writes: wScreenState
EggServiceMenu_Bank1B_WaitTextFlags::
Jump_01B_6698:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    ret

; entry 2 of the `rst $00` table in EggServiceMenu_Bank1B
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
EggServiceMenu_Bank1B_Case02::
Jump_01B_66A6:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw EggServiceMenu_Bank1B_Case02_WaitLinkMessage
    dw EggServiceMenu_Bank1B_Case02_ShowStringA10_Bank1B
    dw EggServiceMenu_Bank1B_Case02_WaitTextFlags
    dw EggServiceMenu_Bank1B_Case02_WaitLinkMessage_Case03
    dw EggServiceMenu_Bank1B_Case02_WaitTextFlags_Case04

; entry 0 of the `rst $00` table in EggServiceMenu_Bank1B_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wLinkSendByte, wScreenStep
EggServiceMenu_Bank1B_Case02_WaitLinkMessage::
Jump_01B_66B4:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in EggServiceMenu_Bank1B_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wScreenStep
EggServiceMenu_Bank1B_Case02_ShowStringA10_Bank1B::
Jump_01B_66C6:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $0C
    call ShowStringA10_Bank1B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in EggServiceMenu_Bank1B_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wLinkSendByte, wScreenStep
EggServiceMenu_Bank1B_Case02_WaitTextFlags::
Jump_01B_66D8:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in EggServiceMenu_Bank1B_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wLinkSendByte, wScreenStep
EggServiceMenu_Bank1B_Case02_WaitLinkMessage_Case03::
Jump_01B_66EA:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 4 of the `rst $00` table in EggServiceMenu_Bank1B_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wGameMode, wModeState, wModeChangeRequest
; points at: wScreenState
EggServiceMenu_Bank1B_Case02_WaitTextFlags_Case04::
Jump_01B_66FC:: ; address name
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld hl, wScreenState
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

; entry 3 of the `rst $00` table in EggServiceMenu_Bank1B
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenState
EggServiceMenu_Bank1B_AdvanceScreenState::
Jump_01B_671F:: ; address name
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 4 of the `rst $00` table in EggServiceMenu_Bank1B
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
EggServiceMenu_Bank1B_Case04::
Jump_01B_6727:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw EggServiceMenu_Bank1B_Case04_BreedMenu
    dw EggServiceMenu_Bank1B_Case04_BreedMenu_Case01
    dw DrawRecordListPageIndicators_1B
    dw EggServiceMenu_Bank1B_Case04_BreedMenu_Case01
    dw DrawListEntriesCell5RecordPanel
    dw ClearAndDrawListEntriesCell5NameAtTiles1780
    dw DrawRuleBoxByWD04CBit7
    dw EggServiceMenu_Bank1B_Case04_SetDefaultStringWindow_Bank1B
    dw EggServiceMenu_Bank1B_Case04_ShowStringA10_Bank1B
    dw EggServiceMenu_Bank1B_Case04_ShowInfoOKYesN
    dw EggServiceMenu_Bank1B_Case04_ShowStringA10_Bank1B_Case0A
    dw EggServiceMenu_Bank1B_Case04_EraseCEntriesOfWordTable_Bank1B
    dw EggServiceMenu_Bank1B_Case04_ClearTileRowsFromPickCount
    dw EggServiceMenu_Bank1B_Case04_ShowStringA10_Bank1B_Case0D

; entry 1 of the `rst $00` table in EggServiceMenu_Bank1B_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
EggServiceMenu_Bank1B_Case04_BreedMenu_Case01::
Jump_01B_6747:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    farcall BreedMenu
    ret

; entry 0 of the `rst $00` table in EggServiceMenu_Bank1B_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
EggServiceMenu_Bank1B_Case04_BreedMenu::
Jump_01B_6753:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    farcall BreedMenu
    ret

; runs Func_01B_7399 and Func_01E_7163; with two or more pages draws the bracket and page-of-pages indicators; wD781 += 1 (E-0124)
; 1 call site from 1 routine (e.g. RunLinkSession6Exchange_Case01_Sub01_Table2_Case04_Case02)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
DrawRecordListPageIndicators_1B::
Func_01B_675F:: ; address name
    call ListAvailableRecordsForSelection
    farcall ClampRecordListPageCursor5
    ld a, [wListPages]
    cp a, $02
    jr c, Jump_01B_679D
    ld de, $0142
    call DrawC5BEC6AtScrollOffsetDE_Bank1B
    ld hl, wWindowTileBuffer + $12E
    call StoreC5BEC6AtHLStride2_Bank1B
    ld de, $0143
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    farcall DrawPageOfPagesAtScrollOffset
    ld hl, wWindowTileBuffer + $12F
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    farcall DrawPageOfPagesAtArg1_Bank1E

Jump_01B_679D::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; for the record at WD789 cell 5: draws its graphics (Func_01B_7460 with wD7F1 = $C7), copies two rectangles to wC434 and wC440, draws its details at wC443 (Func_01B_7487) and wD781 += 1 (E-0121)
; 2 call sites from 2 routines (e.g. EggServiceMenu_Bank1B_Case0E_ToDrawListEntriesCell5RecordPanel, CallDrawListEntriesCell5RecordPanel)
; reads: wArg5, wArg6, wScreenStep
; writes: wArg1, wArg2, wArg3, wScreenStep
DrawListEntriesCell5RecordPanel::
Func_01B_67A5:: ; address name
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    ld a, $C7
    ld [wArg1], a
    call LoadFamilyIconTileForRecordB_Bank1B
    ld de, TileRect_1B_7738
    ld hl, wWindowTileBuffer + $134
    ld bc, $0501
    call CopyRectTo20ByteRows
    ld de, TileRect_1B_773D
    ld hl, wWindowTileBuffer + $140
    ld bc, $0D02
    call CopyRectTo20ByteRows
    pop af
    ld [wArg1], a
    ld hl, wWindowTileBuffer + $143
    ld a, l
    ld [wArg2], a
    ld a, h
    ld [wArg3], a
    call DrawListEntriesCell5RecordPanel_HLToDecimalDigits
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; clears 5 tiles at vTiles1 + $780, draws the name of the record at WD789 cell 5 there and wD781 += 1 (E-0122)
; 3 call sites from 3 routines (e.g. EggServiceMenu_Bank1B_Case0E_ToClearAndDrawListEntriesCell5NameAtTiles1780, CallClearAndDrawListEntriesCell5Name, RunLinkSession6Exchange_Case01_Sub01_Table2_Case0E_Case04)
; reads: wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScreenStep
ClearAndDrawListEntriesCell5NameAtTiles1780::
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
    call DrawListEntriesCell5RecordNameAtTiles1780
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; copies box Data_01B_7757 (10 x 7) or Data_01B_779D (10 x 9, when bit 7 of wD04C is set) to wC36E, then wD781 += 1 (E-0124)
; 1 call site from 1 routine (e.g. EggServiceMenu_Bank1B_Case0E_ToDrawRuleBoxByWD04CBit7)
; reads: wLinkRules, wScreenStep
; writes: wScreenStep
DrawRuleBoxByWD04CBit7::
Func_01B_6814:: ; address name
    ld a, [wLinkRules + $9]
    bit 7, a
    jr nz, Jump_01B_6829
    ld de, TileRect_1B_7757
    ld hl, wWindowTileBuffer + $6E
    ld bc, $0A07
    call CopyRectTo20ByteRows
    jr Jump_01B_6835

Jump_01B_6829::
    ld de, TileRect_1B_779D
    ld hl, wWindowTileBuffer + $6E
    ld bc, $0A09
    call CopyRectTo20ByteRows

Jump_01B_6835::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 7 of the `rst $00` table in EggServiceMenu_Bank1B_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wListCursor, wScreenStep
; writes: wScreenStep
EggServiceMenu_Bank1B_Case04_SetDefaultStringWindow_Bank1B::
Jump_01B_683D:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wListCursor]
    ld b, $BB
    ld hl, Data_01B_786F
    call StoreBAtWordTableEntry_Bank1B
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    ld a, [wListCursor]
    ld b, $C3
    ld hl, Data_01B_786F
    call StoreBAtWordTableEntry_Bank1B
    call SetDefaultStringWindow_Bank1B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 8 of the `rst $00` table in EggServiceMenu_Bank1B_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wMenuInputResult, wListCursor, wScreenStep, wPickCount, wSelectedRecord
; writes: wScreenState, wScreenStep, wScreenSubStep, wLinkSendByte, wMenuInputResult, wPickCount, wListCursor, wListPageIndex
EggServiceMenu_Bank1B_Case04_ShowStringA10_Bank1B::
Jump_01B_686F:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_01B_688D
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
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
    ld a, [wScreenStep]
    sub a, $07
    ld [wScreenStep], a
    ret

Jump_01B_68BA::
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

Jump_01B_68C3::
    ld a, [wPickCount]
    and a, a
    jr z, Jump_01B_68F6
    cp a, $03
    jr c, Jump_01B_68DE
    ld a, [wSelectedRecord]
    ld [wPickCount], a
    dec a
    ld [wPickCount], a
    ld a, $01
    call ShowStringA10_Bank1B
    jr Jump_01B_68E6

Jump_01B_68DE::
    dec a
    ld [wPickCount], a
    xor a, a
    call ShowStringA10_Bank1B

Jump_01B_68E6::
    call ClearTileRowsFromPickCount
    xor a, a
    ld [wListCursor], a
    ld [wListPageIndex], a
    ld a, $01
    ld [wScreenStep], a
    ret

Jump_01B_68F6::
    ld a, $02
    ld [wScreenState], a
    ld a, $0A
    call ShowStringA10_Bank1B
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_01B_690D::
    call EggServiceMenu_Bank1B_SetArg5ToListEntriesCell5
    call EggServiceMenu_Bank1B_WriteScreenStepAndRAMG2Etc
    cp a, $FF
    jr z, Jump_01B_6918
    ret

Jump_01B_6918::
    ld a, [wListCursor]
    ld b, $BC
    ld hl, Data_01B_786F
    call StoreBAtWordTableEntry_Bank1B
    call CopyListEntriesCell5NameToTextBuf0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, [wPickCount]
    cp a, $03
    jr z, Jump_01B_693A
    ld a, $02
    call ShowStringA10_Bank1B
    ret

Jump_01B_693A::
    ld a, $07
    call ShowStringA10_Bank1B
    ret

; entry 9 of the `rst $00` table in EggServiceMenu_Bank1B_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wChoiceCursor, wScreenStep
EggServiceMenu_Bank1B_Case04_ShowInfoOKYesN::
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
    ld [wStringIndex], a ; 'InfoOKYesN'
    farcall ShowString_Bank1B_481A
    ld a, $6C
    call QueueSoundEffect
    ld de, TileRect_1B_7847
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
    ld [wChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 10 of the `rst $00` table in EggServiceMenu_Bank1B_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wArg5, wChoiceCursor, wScreenState, wScreenStep, wPickCount, wArg6
; writes: wScreenState, wScreenStep, wScreenSubStep, wLinkSendByte, wArg5, wScreenByteB2, wScreenByteB3, wLinkSceneByte4C, ...
EggServiceMenu_Bank1B_Case04_ShowStringA10_Bank1B_Case0A::
Jump_01B_69A9:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_01B_69C7
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0B
    call ShowStringA10_Bank1B
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_01B_69C7::
    xor a, a
    ld [wArg5], a
    farcall HandleTwoChoiceCursorInput_0D
    ld a, [wArg5]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_01B_69DF
    cp a, $FF
    jr z, Jump_01B_69E7
    ret

Jump_01B_69DF::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_01B_69E7::
    ld a, [wChoiceCursor]
    and a, a
    jr nz, Jump_01B_6A06
    ld a, [wScreenState]
    ld [wScreenByteB2], a
    ld a, [wScreenStep]
    ld [wScreenByteB3], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0C
    ld [wScreenState], a
    ret

Jump_01B_6A06::
    call EggServiceMenu_Bank1B_SetArg5ToListEntriesCell5
    ld a, [wPickCount]
    cp a, $03
    jr c, Jump_01B_6A46
    call EggServiceMenu_Bank1B_Case04_Case0A_SetArg5ToListEntriesCell5
    cp a, $FF
    jr nz, Jump_01B_6A18
    ret

Jump_01B_6A18::
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wLinkSceneByte4C], a
    ld a, $04
    ld [wPickCount], a
    call EggServiceMenu_Bank1B_Case04_Case0A_EraseCEntriesOfWordTable_Bank1B
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld a, $0C
    call ShowStringA10_Bank1B
    ret

Jump_01B_6A46::
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    ret

; entry 11 of the `rst $00` table in EggServiceMenu_Bank1B_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wScreenStep
EggServiceMenu_Bank1B_Case04_EraseCEntriesOfWordTable_Bank1B::
Jump_01B_6A4F:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld c, $05
    ld hl, Data_01B_786F
    call EraseCEntriesOfWordTable_Bank1B
    jr Jump_01B_6A71

; only called from EggServiceMenu_Bank1B_Case04_Case0A (E-0047)
; 1 call site from 1 routine (e.g. EggServiceMenu_Bank1B_Case04_ShowStringA10_Bank1B_Case0A)
; reads: wListCursor, wScreenStep
; writes: wScreenStep
EggServiceMenu_Bank1B_Case04_Case0A_EraseCEntriesOfWordTable_Bank1B::
Func_01B_6A5E:: ; address name
    ld c, $05
    ld hl, Data_01B_786F
    call EraseCEntriesOfWordTable_Bank1B
    ld a, [wListCursor]
    ld b, $BC
    ld hl, Data_01B_786F
    call StoreBAtWordTableEntry_Bank1B

Jump_01B_6A71::
    call EggServiceMenu_Bank1B_CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    ld a, [wScreenStep]
    sub a, $03
    ld [wScreenStep], a
    ret

; entry 12 of the `rst $00` table in EggServiceMenu_Bank1B_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wPickCount, wScreenStep
; writes: wPickCount, wScreenStep
EggServiceMenu_Bank1B_Case04_ClearTileRowsFromPickCount::
Jump_01B_6A89:: ; address name
    call EggServiceMenu_Bank1B_WriteScreenStepAndRAMG2Etc
    cp a, $FF
    ret nz
    call EggServiceMenu_Bank1B_CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    ld a, [wPickCount]
    inc a
    ld [wPickCount], a
    call ClearTileRowsFromPickCount
    call DrawPickedRecordsRecordNamesAndIcons
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 13 of the `rst $00` table in EggServiceMenu_Bank1B_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenSubStep
; writes: wScreenState, wScreenStep, wScreenSubStep, wLinkSendByte
EggServiceMenu_Bank1B_Case04_ShowStringA10_Bank1B_Case0D::
Jump_01B_6AB3:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_01B_6AD1
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0B
    call ShowStringA10_Bank1B
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_01B_6AD1::
    ld a, [wScreenSubStep]
    rst $00
    dw EggServiceMenu_Bank1B_Case04_Case0A_Sub01_ListAvailableRecordsForSelection
    dw EggServiceMenu_Bank1B_Case04_Case0A_Sub01_QueueSoundEffect
    dw EggServiceMenu_Bank1B_Case04_Case0A_Sub01_ShowStringA10_Bank1B
    dw EggServiceMenu_Bank1B_Case04_Case0A_Sub01_WaitTextFlags
    dw EggServiceMenu_Bank1B_Case04_Case0A_Sub01_ShowStringA10_Bank1B_Case04
    dw EggServiceMenu_Bank1B_Case04_Case0A_Sub01_FinishPickedRecordsEntryAndAdvance
    dw EggServiceMenu_Bank1B_Case04_Case0A_Sub01_QueueSoundEffect
    dw EggServiceMenu_Bank1B_Case04_Case0A_Sub01_ShowStringA10_Bank1B_Case07

; entry 0 of the `rst $00` table in Func_01B_6A5E
; no direct call (reached through a table, a jump or a vector)
; reads: wPickCount, wListCount, wScreenSubStep
; writes: wScreenSubStep
EggServiceMenu_Bank1B_Case04_Case0A_Sub01_ListAvailableRecordsForSelection::
Jump_01B_6AE5:: ; address name
    ld a, [wPickCount]
    cp a, $03
    jr z, Jump_01B_6B02
    call ListAvailableRecordsForSelection
    ld a, [wListCount]
    and a, a
    jr z, Jump_01B_6B02
    ld a, $03
    call ShowStringA10_Bank1B
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

Jump_01B_6B02::
    ld a, [wScreenSubStep]
    add a, $04
    ld [wScreenSubStep], a
    ret

; entry 1 of the `rst $00` table in Func_01B_6A5E
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenSubStep, wPickCount
; writes: wTwoChoiceCursor, wScreenSubStep
EggServiceMenu_Bank1B_Case04_Case0A_Sub01_QueueSoundEffect::
Jump_01B_6B0B:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, $6C
    call QueueSoundEffect
    ld de, TileRect_1B_78CB
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    ld a, [wScreenSubStep]
    cp a, $01
    jr z, Jump_01B_6B3F
    ld a, [wPickCount]
    cp a, $03
    jr nz, Jump_01B_6B3F
    ld a, $01
    jr Jump_01B_6B40

Jump_01B_6B3F::
    xor a, a

Jump_01B_6B40::
    ld [wTwoChoiceCursor], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 2 of the `rst $00` table in Func_01B_6A5E
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wMenuInputResult, wTwoChoiceCursor, wScreenSubStep
; writes: wScreenState, wScreenStep, wScreenSubStep, wLinkSendByte
EggServiceMenu_Bank1B_Case04_Case0A_Sub01_ShowStringA10_Bank1B::
Jump_01B_6B4B:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_01B_6B69
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
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
    ld a, [wScreenSubStep]
    add a, $02
    ld [wScreenSubStep], a
    ret

Jump_01B_6B89::
    ld a, [wTwoChoiceCursor]
    and a, a
    jr nz, Jump_01B_6B7D
    call DrawChoiceBoxByWD04CBit7
    xor a, a
    call ShowStringA10_Bank1B
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 3 of the `rst $00` table in Func_01B_6A5E
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wScreenStep, wScreenSubStep
EggServiceMenu_Bank1B_Case04_Case0A_Sub01_WaitTextFlags::
Jump_01B_6B9E:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ret

; entry 4 of the `rst $00` table in Func_01B_6A5E
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRules, wListCount, wScreenSubStep, wPickCount
; writes: wScreenSubStep, wSelectedRecord, wPickCount, wTwoChoiceCursor
EggServiceMenu_Bank1B_Case04_Case0A_Sub01_ShowStringA10_Bank1B_Case04::
Jump_01B_6BAB:: ; address name
    ld a, [wLinkRules + $9]
    bit 7, a
    jr nz, Jump_01B_6BBB
    ld a, $0C
    call ShowStringA10_Bank1B
    call FinishPickedRecordsEntryAndAdvance
    ret

Jump_01B_6BBB::
    farcall ListRecordsState1WithByte6EClear
    ld a, [wListCount]
    and a, a
    jr nz, Jump_01B_6BD7
    call PadPickedRecordsWithFFToThree
    ld a, $05
    call ShowStringA10_Bank1B
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

Jump_01B_6BD7::
    ld a, $04
    call ShowStringA10_Bank1B
    call PadPickedRecordsWithFFToThree
    ld a, [wPickCount]
    ld [wSelectedRecord], a
    ld a, $03
    ld [wPickCount], a
    ld a, [wScreenSubStep]
    add a, $02
    ld [wScreenSubStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ret

; entry 5 of the `rst $00` table in Func_01B_6A5E
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
EggServiceMenu_Bank1B_Case04_Case0A_Sub01_FinishPickedRecordsEntryAndAdvance::
Jump_01B_6BF7:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    call FinishPickedRecordsEntryAndAdvance
    ld a, $0C
    call ShowStringA10_Bank1B
    ret

; entry 7 of the `rst $00` table in Func_01B_6A5E
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wMenuInputResult, wTwoChoiceCursor, wScreenSubStep
; writes: wScreenState, wScreenStep, wScreenSubStep, wLinkSendByte, wPickCount, wPackWork
EggServiceMenu_Bank1B_Case04_Case0A_Sub01_ShowStringA10_Bank1B_Case07::
Jump_01B_6C05:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_01B_6C23
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
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
    ld [wPickCount], a
    ld a, $FF
    ld [wPackWork], a
    ld a, [wScreenSubStep]
    sub a, $02
    ld [wScreenSubStep], a
    ret

Jump_01B_6C4D::
    ld a, [wTwoChoiceCursor]
    and a, a
    jr nz, Jump_01B_6C37
    call DrawChoiceBoxByWD04CBit7
    ld a, $06
    call ShowStringA10_Bank1B
    ld a, $03
    ld [wScreenSubStep], a
    ret

; entry 5 of the `rst $00` table in EggServiceMenu_Bank1B
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
EggServiceMenu_Bank1B_Case05::
Jump_01B_6C61:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw EggServiceMenu_Bank1B_Case05_DrawPickedRecordsRecordNamesAndIcons
    dw EggServiceMenu_Bank1B_Case05_FillBytes
    dw EggServiceMenu_Bank1B_Case05_SetScreenStep
    dw EggServiceMenu_Bank1B_Case05_ShowStringA10_Bank1B
    dw EggServiceMenu_Bank1B_Case05_WriteScreenStepAndLinkTimeoutLoEtc
    dw EggServiceMenu_Bank1B_Case05_ShowStringA10_Bank1B_Case05
    dw EggServiceMenu_Bank1B_Case05_ShowBattlePrizeExit
    dw EggServiceMenu_Bank1B_Case05_ShowStringA10_Bank1B_Case07
    dw EggServiceMenu_Bank1B_Case05_WaitTextFlags
    dw EggServiceMenu_Bank1B_Case05_ToShowStringA10_Bank1BAndStep
    dw EggServiceMenu_Bank1B_Case05_WaitTextFlags_Case0A
    dw EggServiceMenu_Bank1B_Case05_SetScreenStep
    dw EggServiceMenu_Bank1B_Case05_ShowStringA10_Bank1B_Case0C
    dw EggServiceMenu_Bank1B_Case05_WriteLinkSceneByte4BAndLinkTimeoutLoEtc
    dw EggServiceMenu_Bank1B_Case05_SetScreenStep
    dw EggServiceMenu_Bank1B_Case05_WaitLinkMessage
    dw EggServiceMenu_Bank1B_Case05_WaitLinkMessage_Case10
    dw EggServiceMenu_Bank1B_Case05_ToShowStringA10_Bank1BAndStep_Case11
    dw EggServiceMenu_Bank1B_Case05_WaitTextFlags_Case0A
    dw EggServiceMenu_Bank1B_Case05_SetScreenStep
    dw EggServiceMenu_Bank1B_Case05_ShowStringA10_Bank1B
    dw EggServiceMenu_Bank1B_Case05_WriteGameModeAndModeStateEtc

; entry 17 of the `rst $00` table in EggServiceMenu_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
EggServiceMenu_Bank1B_Case05_ToShowStringA10_Bank1BAndStep_Case11::
Jump_01B_6C91:: ; address name
    ld a, $09
    call ShowStringA10_Bank1B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 9 of the `rst $00` table in EggServiceMenu_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
EggServiceMenu_Bank1B_Case05_ToShowStringA10_Bank1BAndStep::
Jump_01B_6C9E:: ; address name
    ld a, $0C
    call ShowStringA10_Bank1B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 10 of the `rst $00` table in EggServiceMenu_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wScreenStep
EggServiceMenu_Bank1B_Case05_WaitTextFlags_Case0A::
Jump_01B_6CAB:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 0 of the `rst $00` table in EggServiceMenu_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wScreenStep
EggServiceMenu_Bank1B_Case05_DrawPickedRecordsRecordNamesAndIcons::
Jump_01B_6CB8:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    call DrawPickedRecordsRecordNamesAndIcons
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in EggServiceMenu_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wPackWork, wScreenStep
; writes: rRAMG2, rRAMB, wScreenStep
; points at: wRecordBufA, sRecords
EggServiceMenu_Bank1B_Case05_FillBytes::
Jump_01B_6CC8:: ; address name
    ld a, [wPackWork]
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
    ld hl, sRecords + $F
    ld de, wRecordBufA + $F
    ld b, $0A
    jr Jump_01B_6D03

Jump_01B_6CEC::
    ld c, $A5
    call Multiply8
    ld de, sRecords
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in EggServiceMenu_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wLinkSendByte
EggServiceMenu_Bank1B_Case05_SetScreenStep::
Jump_01B_6D11:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

; entry 3 of the `rst $00` table in EggServiceMenu_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wScreenState, wScreenStep, wScreenSubStep, wLinkSendByte
EggServiceMenu_Bank1B_Case05_ShowStringA10_Bank1B::
Jump_01B_6D1E:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    jr z, Jump_01B_6D3F
    cp a, $FE
    ret nz
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0B
    call ShowStringA10_Bank1B
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_01B_6D3F::
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 4 of the `rst $00` table in EggServiceMenu_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferCountLo, wLinkBufferCountHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wLinkSendByte, ...
; points at: wRecordBufA, wRecordBufB
EggServiceMenu_Bank1B_Case05_WriteScreenStepAndLinkTimeoutLoEtc::
Jump_01B_6D4B:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
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

; entry 16 of the `rst $00` table in EggServiceMenu_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wLinkReady, wLinkSendByte, wScreenStep
EggServiceMenu_Bank1B_Case05_WaitLinkMessage_Case10::
Jump_01B_6D7E:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    ld a, $00
    ld [wLinkReady], a
    ld a, $00
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in EggServiceMenu_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wLinkReady, wLinkSendByte, wScreenStep
EggServiceMenu_Bank1B_Case05_ShowStringA10_Bank1B_Case05::
Jump_01B_6D96:: ; address name
    ld a, [wLinkMessage]
    cp a, $F0
    ret nz
    ld a, $00
    ld [wLinkReady], a
    ld a, $00
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $08
    call ShowStringA10_Bank1B
    ret

; entry 6 of the `rst $00` table in EggServiceMenu_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wTwoChoiceCursor, wScreenStep
EggServiceMenu_Bank1B_Case05_ShowBattlePrizeExit::
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
    ld [wStringIndex], a ; 'BattlePrizeExit'
    farcall ShowString_Bank1B_481A
    ld a, $6C
    call QueueSoundEffect
    ld de, TileRect_1B_78E9
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
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 7 of the `rst $00` table in EggServiceMenu_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wMenuInputResult, wTwoChoiceCursor, wLinkRules, wScreenStep, wRecordBufB, wScreenState, wListCursor, ...
; writes: wScreenState, wScreenStep, wScreenSubStep, wLinkSendByte, wScreenByteB2, wScreenByteB3, wItemGridX, wItemGridY, ...
EggServiceMenu_Bank1B_Case05_ShowStringA10_Bank1B_Case07::
Jump_01B_6E09:: ; address name
    ld a, [wLinkMessage]
    cp a, $FE
    jr nz, Jump_01B_6E27
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
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
    ld [wScreenState], a
    ld a, $0A
    call ShowStringA10_Bank1B
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
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
    ld a, [wScreenStep]
    add a, $02
    ld [wScreenStep], a
    ret

Jump_01B_6E67::
    ld a, [wLinkRules + $9]
    bit 7, a
    jr nz, Jump_01B_6E7B
    ld a, $14
    call ShowStringA10_Bank1B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_01B_6E7B::
    ld a, [wRecordBufB]
    and a, a
    jr nz, Jump_01B_6E8E
    ld a, $15
    call ShowStringA10_Bank1B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_01B_6E8E::
    ld a, [wScreenState]
    ld [wScreenByteB2], a
    ld a, [wScreenStep]
    ld [wScreenByteB3], a
    ld a, $0D
    ld [wScreenState], a
    ld a, [wListCursor]
    ld [wItemGridX], a
    ld a, [wListPageIndex]
    ld [wItemGridY], a
    xor a, a
    ld [wListCursor], a
    ld [wListPageIndex], a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ret

; entry 8 of the `rst $00` table in EggServiceMenu_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScreenStep
; writes: wScreenStep
EggServiceMenu_Bank1B_Case05_WaitTextFlags::
Jump_01B_6EB9:: ; address name
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    ret

; entry 12 of the `rst $00` table in EggServiceMenu_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wScreenState, wScreenStep, wScreenSubStep, wLinkSendByte
EggServiceMenu_Bank1B_Case05_ShowStringA10_Bank1B_Case0C::
Jump_01B_6EC6:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    jr z, Jump_01B_6EE7
    cp a, $FE
    ret nz
    ld a, $02
    ld [wScreenState], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0B
    call ShowStringA10_Bank1B
    ld a, $FE
    ld [wLinkSendByte], a
    ret

Jump_01B_6EE7::
    xor a, a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 13 of the `rst $00` table in EggServiceMenu_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRole, wScreenStep
; writes: wLinkSceneByte4B, wLinkTimeoutLo, wLinkTimeoutHi, wLinkBufferPtrLo, wLinkBufferPtrHi, wScreenStep
; points at: wBattlerRecords, wBattlerRecordSlot4
EggServiceMenu_Bank1B_Case05_WriteLinkSceneByte4BAndLinkTimeoutLoEtc::
Jump_01B_6EF3:: ; address name
    ld a, [wLinkRole]
    bit 1, a
    jr nz, Jump_01B_6F1F
    xor a, a
    ld [wLinkSceneByte4B], a
    call EggServiceMenu_Bank1B_Case05_Case0D_WriteRAMG2AndRAMB
    ld hl, wBattlerRecords
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, wBattlerRecordSlot4
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_01B_6F1F::
    ld a, $01
    ld [wLinkSceneByte4B], a
    call EggServiceMenu_Bank1B_Case05_Case0D_WriteRAMG2AndRAMB
    ld hl, wBattlerRecordSlot4
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, wBattlerRecords
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 15 of the `rst $00` table in EggServiceMenu_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMessage, wScreenStep
; writes: wScreenStep, wLinkBufferCountLo, wLinkBufferCountHi, wLinkSendByte, wLinkReady
EggServiceMenu_Bank1B_Case05_WaitLinkMessage::
Jump_01B_6F45:: ; address name
    ld a, [wLinkMessage]
    cp a, $01
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
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

; entry 21 of the `rst $00` table in EggServiceMenu_Bank1B_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wGameMode, wModeState, wGameMode2State, wGameMode2Arg, wModeChangeRequest, wLinkSession, wLinkExchangeState, wLinkSendByte, ...
EggServiceMenu_Bank1B_Case05_WriteGameModeAndModeStateEtc::
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

; entry 6 of the `rst $00` table in EggServiceMenu_Bank1B
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wScreenState
; writes: wScreenStep, wScreenSubStep, wScreenState
EggServiceMenu_Bank1B_SwapMonstersMenu::
Jump_01B_6F8F:: ; address name
    farcall SwapMonstersMenu
    ld a, [wScreenStep]
    cp a, $0A
    ret nz
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    add a, $03
    ld [wScreenState], a
    ret

; entry 13 of the `rst $00` table in EggServiceMenu_Bank1B
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState, wItemGridX, wItemGridY
; writes: wListCursor, wListPageIndex
EggServiceMenu_Bank1B_RunScreenStateWhenNotFading_F1::
Jump_01B_6FAB:: ; address name
    farcall RunScreenStateWhenNotFading_F1
    ld a, [wScreenState]
    cp a, $0E
    ret nz
    ld a, [wItemGridX]
    ld [wListCursor], a
    ld a, [wItemGridY]
    ld [wListPageIndex], a
    ret

; entry 14 of the `rst $00` table in EggServiceMenu_Bank1B
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
EggServiceMenu_Bank1B_Case0E::
Jump_01B_6FC4:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw EggServiceMenu_Bank1B_Case0E_ClearRecordPanelTiles
    dw EggServiceMenu_Bank1B_Case0E_ListAvailableRecordsForSelection
    dw EggServiceMenu_Bank1B_Case0E_DrawRecordListPageNames
    dw EggServiceMenu_Bank1B_Case0E_ToDrawListEntriesCell5RecordPanel
    dw EggServiceMenu_Bank1B_Case0E_ToClearAndDrawListEntriesCell5NameAtTiles1780
    dw EggServiceMenu_Bank1B_Case0E_ToDrawRuleBoxByWD04CBit7
    dw EggServiceMenu_Bank1B_Case0E_ShowBattlePrizeExit
    dw EggServiceMenu_Bank1B_Case0E_BGMapAddressAtScroll_Bank1B

; entry 6 of the `rst $00` table in EggServiceMenu_Bank1B_Case0E
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wTwoChoiceCursor, wScreenStep
EggServiceMenu_Bank1B_Case0E_ShowBattlePrizeExit::
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
    ld [wStringIndex], a ; 'BattlePrizeExit'
    farcall ShowString_Bank1B_481A
    ld de, TileRect_1B_78E9
    ld hl, wWindowTileBuffer + $E7
    ld bc, $0907
    call CopyRectTo20ByteRows
    call SetDefaultStringWindow_Bank1B
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 15 of the `rst $00` table in EggServiceMenu_Bank1B
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
EggServiceMenu_Bank1B_Case0F::
Jump_01B_7019:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw EggServiceMenu_Bank1B_Case0E_ClearRecordPanelTiles
    dw EggServiceMenu_Bank1B_Case0E_ListAvailableRecordsForSelection
    dw EggServiceMenu_Bank1B_Case0E_DrawRecordListPageNames
    dw EggServiceMenu_Bank1B_Case0E_ToDrawListEntriesCell5RecordPanel
    dw EggServiceMenu_Bank1B_Case0E_ToClearAndDrawListEntriesCell5NameAtTiles1780
    dw EggServiceMenu_Bank1B_Case0E_ToDrawRuleBoxByWD04CBit7
    dw EggServiceMenu_Bank1B_Case0F_ShowInfoOKYesN
    dw EggServiceMenu_Bank1B_Case0E_BGMapAddressAtScroll_Bank1B

; entry 0 of the `rst $00` table in EggServiceMenu_Bank1B_Case0E
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep
; writes: wScreenStep
EggServiceMenu_Bank1B_Case0E_ClearRecordPanelTiles::
Jump_01B_702D:: ; address name
    call ClearRecordPanelTiles
    ld de, TileRect_1B_7928
    ld hl, wWindowTileBuffer + $64
    ld bc, $080B
    call CopyRectTo20ByteRows
    ld a, [wListCursor]
    ld b, $BC
    ld hl, Data_01B_786F
    call StoreBAtWordTableEntry_Bank1B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in EggServiceMenu_Bank1B_Case0E
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
EggServiceMenu_Bank1B_Case0E_ListAvailableRecordsForSelection::
Jump_01B_704F:: ; address name
    call ListAvailableRecordsForSelection
    farcall ClampRecordListPageCursor5
    ld a, [wListPages]
    cp a, $02
    jr c, Jump_01B_7076
    ld hl, wWindowTileBuffer + $12E
    call StoreC5BEC6AtHLStride2_Bank1B
    ld hl, wWindowTileBuffer + $12F
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    farcall DrawPageOfPagesAtArg1_Bank1E

Jump_01B_7076::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in EggServiceMenu_Bank1B_Case0E
; no direct call (reached through a table, a jump or a vector)
; writes: wArg1
EggServiceMenu_Bank1B_Case0E_DrawRecordListPageNames::
Jump_01B_707E:: ; address name
    farcall DrawRecordListPageNames
    xor a, a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    ret

; entry 3 of the `rst $00` table in EggServiceMenu_Bank1B_Case0E
; no direct call (reached through a table, a jump or a vector)
EggServiceMenu_Bank1B_Case0E_ToDrawListEntriesCell5RecordPanel::
Jump_01B_708F:: ; address name
    call DrawListEntriesCell5RecordPanel
    ret

; entry 4 of the `rst $00` table in EggServiceMenu_Bank1B_Case0E
; no direct call (reached through a table, a jump or a vector)
EggServiceMenu_Bank1B_Case0E_ToClearAndDrawListEntriesCell5NameAtTiles1780::
Jump_01B_7093:: ; address name
    call ClearAndDrawListEntriesCell5NameAtTiles1780
    ret

; entry 5 of the `rst $00` table in EggServiceMenu_Bank1B_Case0E
; no direct call (reached through a table, a jump or a vector)
EggServiceMenu_Bank1B_Case0E_ToDrawRuleBoxByWD04CBit7::
Jump_01B_7097:: ; address name
    call DrawRuleBoxByWD04CBit7
    ret

; entry 6 of the `rst $00` table in EggServiceMenu_Bank1B_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wPickCount, wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wChoiceCursor, wScreenStep
EggServiceMenu_Bank1B_Case0F_ShowInfoOKYesN::
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
    ld [wStringIndex], a ; 'InfoOKYesN'
    farcall ShowString_Bank1B_481A
    call CopyListEntriesCell5NameToTextBuf0
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
    ld a, [wPickCount]
    cp a, $03
    jr c, Jump_01B_70E8
    ld a, $17
    jr Jump_01B_70EA

Jump_01B_70E8::
    ld a, $12

Jump_01B_70EA::
    ld [wStringIndex], a
    farcall ShowString_Bank1B_481A
    ld de, TileRect_1B_7847
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows
    xor a, a
    ld [wChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 7 of the `rst $00` table in EggServiceMenu_Bank1B_Case0E
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenByteB2, wScreenByteB3
; writes: hSpriteHideTile, wScreenSubStep, wScreenState, wScreenStep, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
EggServiceMenu_Bank1B_Case0E_BGMapAddressAtScroll_Bank1B::
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
    ld [wScreenSubStep], a
    ld a, [wScreenByteB2]
    ld [wScreenState], a
    ld a, [wScreenByteB3]
    ld [wScreenStep], a
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

; only called from EggServiceMenu_Bank1B_Case05_Case0D (E-0047)
; 2 call sites from 1 routine (e.g. EggServiceMenu_Bank1B_Case05_WriteLinkSceneByte4BAndLinkTimeoutLoEtc)
; reads: wLinkRole
; writes: rRAMG2, rRAMB
; points at: wBattlerRecords, wBattlerRecordSlot4, wPickedRecords
EggServiceMenu_Bank1B_Case05_Case0D_WriteRAMG2AndRAMB::
Func_01B_7152:: ; address name
    ld hl, wBattlerRecords
    ld a, [wLinkRole]
    bit 1, a
    jr z, Jump_01B_715F
    ld hl, wBattlerRecordSlot4

Jump_01B_715F::
    ld c, $00

Jump_01B_7161::
    push bc
    push hl
    ld a, c
    ld de, wPickedRecords
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
; 4 call sites from 1 routine (e.g. EggServiceMenu_Bank1B_Case05_Case0D_WriteRAMG2AndRAMB)
CopyEBytesBCToHL::
Func_01B_71FE:: ; address name
    ld a, [bc]
    ld [hl+], a
    inc bc
    dec e
    jr nz, CopyEBytesBCToHL
    ret

; clears the tile rows at vTiles1 + $500, $700, $780, $240 and $4E0, then the rows from wD7DC = 0 and from the saved wD7DC (E-0127)
; 3 call sites from 3 routines (e.g. EggServiceMenu_Bank1B_Case0E_ClearRecordPanelTiles, RunLinkSession6Exchange_Case01_Sub01_Table2_Case0E_Case00, RunLinkSession6Exchange_Case01_Sub01_Table2_Case0F_Case00)
; reads: wPickCount
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wPickCount
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
    ld a, [wPickCount]
    push af
    xor a, a
    ld [wPickCount], a
    call ClearTileRowsFromPickCount
    pop af
    ld [wPickCount], a
    call DrawPickedRecordsRecordNamesAndIcons
    ret

; only called from EggServiceMenu_Bank1B_Case04_Case0A (E-0047)
; 1 call site from 1 routine (e.g. EggServiceMenu_Bank1B_Case04_ShowStringA10_Bank1B_Case0A)
; reads: wArg5, wArg6, wPartyCount
; points at: wPartyList
EggServiceMenu_Bank1B_Case04_Case0A_SetArg5ToListEntriesCell5::
Func_01B_728A:: ; address name
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
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
; 3 call sites from 2 routines (e.g. FinishPickedRecordsEntryAndAdvance, EggServiceMenu_Bank1B_Case04_Case0A_Sub01_ShowStringA10_Bank1B_Case04)
; reads: wPickCount
; points at: wPickedRecords
PadPickedRecordsWithFFToThree::
Func_01B_72AD:: ; address name
    ld a, [wPickCount]
    cp a, $03
    ret z
    ld hl, wPickedRecords
    add_a_to_hl
    ld a, [wPickCount]
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

; only called from routines of EggServiceMenu_Bank1B (E-0098)
; 3 call sites from 2 routines (e.g. EggServiceMenu_Bank1B_WriteScreenStepAndRAMG2Etc, EggServiceMenu_Bank1B_Shared02_WriteRAMG2AndRAMB)
; writes: rRAMG2, rRAMB
; points at: wPickedRecords
EggServiceMenu_Bank1B_LoadSRAMRecordByte::
Func_01B_72CA:: ; address name
    ld hl, wPickedRecords
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

; only called from EggServiceMenu_Bank1B_Shared02 (E-0047)
; 1 call site from 1 routine (e.g. EggServiceMenu_Bank1B_WriteScreenStepAndRAMG2Etc)
; reads: wPickCount, hTemp0
; writes: rRAMG2, rRAMB
; points at: wArg1, wPickedRecords
EggServiceMenu_Bank1B_Shared02_WriteRAMG2AndRAMB::
Func_01B_72E7:: ; address name
    ld a, [wPickCount]
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
    call EggServiceMenu_Bank1B_LoadSRAMRecordByte
    pop bc
    push bc
    ld hl, wArg1
    ld a, c
    add_a_to_hl
    ldh a, [hTemp0]
    and a, $0F
    ld [hl], a
    pop bc
    inc c
    dec b
    jr nz, Jump_01B_72F3
    ld a, [wPickCount]
    ld hl, wPickedRecords
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
    ld a, [wPickCount]
    ld b, a
    ld hl, wArg1

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
; 4 call sites from 2 routines (e.g. EggServiceMenu_Bank1B_Case04_Case0A_Sub01_ShowStringA10_Bank1B_Case07, EggServiceMenu_Bank1B_Case04_Case0A_Sub01_ShowStringA10_Bank1B)
; reads: wLinkRules
DrawChoiceBoxByWD04CBit7::
Func_01B_7349:: ; address name
    ld a, [wLinkRules + $9]
    bit 7, a
    jr nz, Jump_01B_735E
    ld de, TileRect_1B_788F
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows
    jr Jump_01B_736A

Jump_01B_735E::
    ld de, TileRect_1B_78AD
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows

Jump_01B_736A::
    call BGMapAddressAtScroll_Bank1B
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B
    ret

; only called from routines of EggServiceMenu_Bank1B (E-0098)
; 2 call sites from 2 routines (e.g. EggServiceMenu_Bank1B_Case04_ClearTileRowsFromPickCount, EggServiceMenu_Bank1B_Case04_Case0A_EraseCEntriesOfWordTable_Bank1B)
; reads: wLinkRules
EggServiceMenu_Bank1B_CopyRectTo20ByteRows::
Func_01B_7377:: ; address name
    ld a, [wLinkRules + $9]
    bit 7, a
    jr nz, Jump_01B_738C
    ld de, TileRect_1B_77F7
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows
    jr Jump_01B_7398

Jump_01B_738C::
    ld de, TileRect_1B_781F
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows

Jump_01B_7398::
    ret

; lists in wD789 the stored records (state 1, or 2 unless wD7DC is 3) whose field $6E is clear and that are not already chosen in wD7DD; count in wD7A9 (E-0130)
; 3 call sites from 3 routines (e.g. DrawRecordListPageIndicators_1B, EggServiceMenu_Bank1B_Case0E_ListAvailableRecordsForSelection, EggServiceMenu_Bank1B_Case04_Case0A_Sub01_ListAvailableRecordsForSelection)
; reads: wPickCount, wRecordsFlagged
; writes: wListCount, rRAMG2, rRAMB, wRecordsFlagged
; points at: wListEntries, wListEntries2, sRecords, wPickedRecords
ListAvailableRecordsForSelection::
Func_01B_7399:: ; address name
    ld hl, wListEntries
    ld b, $1E

Jump_01B_739E::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_01B_739E
    ld hl, wListEntries2
    ld b, $1E

Jump_01B_73A8::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_01B_73A8
    xor a, a
    ld [wListCount], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld [wRecordsFlagged], a
    ld de, sRecords
    ld hl, wListEntries
    ld b, $00
    ld c, $00

Jump_01B_73C7::
    ld a, [de]
    and a, a
    jr z, Jump_01B_741D
    cp a, $01
    jr z, Jump_01B_73DD
    ld a, [wPickCount]
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
    ld a, [wPickCount]
    and a, a
    jr z, Jump_01B_7410
    cp a, $03
    jr nc, Jump_01B_7410
    push hl
    push de
    push bc
    ld d, b
    ld hl, wPickedRecords
    ld a, [wPickCount]
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
    ld a, [wRecordsFlagged]
    inc a
    ld [wRecordsFlagged], a

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
    ld [wListCount], a
    xor a, a
    ld [rRAMG2], a
    farcall MovePartyRecordsToFrontOfList
    ret

; wStringIndex = A + $10, wStringCategory = 0, then far-calls BeginStringDisplay_Bank1B_480C (E-0063)
; 32 call sites from 17 routines (e.g. EggServiceMenu_Bank1B_ShowStringA10_Bank1B, EggServiceMenu_Bank1B_Case02_ShowStringA10_Bank1B, EggServiceMenu_Bank1B_Case04_ShowStringA10_Bank1B_Case0D, EggServiceMenu_Bank1B_WriteScreenStepAndRAMG2Etc, ...)
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
; 4 call sites from 4 routines (e.g. ClearTileRowsFromPickCount, EggServiceMenu_Bank1B_Case04_SetDefaultStringWindow_Bank1B, EggServiceMenu_Bank1B_Case05_ShowBattlePrizeExit, EggServiceMenu_Bank1B_Case0E_ShowBattlePrizeExit)
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

; wD09D = field $0D of SRAM record B & $0F (its family), wD09E = wD7F1, then LoadFamilyIconTileForWorkBuf (E-0122)
; 2 call sites from 2 routines (e.g. DrawPickedRecordsRecordNamesAndIcons, DrawListEntriesCell5RecordPanel)
; reads: hTemp0, wArg1
; writes: rRAMG2, rRAMB, wWorkBuf
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
    ld [wWorkBuf], a
    ld a, [wArg1]
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    xor a, a
    ld [rRAMG2], a
    ret

; only called from DrawListEntriesCell5RecordPanel (E-0047)
; 1 call site from 1 routine (e.g. DrawListEntriesCell5RecordPanel)
; reads: wArg1, wArg2, wArg3, hTemp0, wDigits
; writes: rRAMG2, rRAMB
DrawListEntriesCell5RecordPanel_HLToDecimalDigits::
Func_01B_7487:: ; address name
    ld a, [wArg1]
    ld b, a
    ld a, [wArg2]
    ld l, a
    ld a, [wArg3]
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
    farcall BlankLeadingZeroDigits_F
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
; 4 call sites from 4 routines (e.g. EggServiceMenu_Bank1B_ShowStringA10_Bank1B, ClearRecordPanelTiles, EggServiceMenu_Bank1B_Case04_ClearTileRowsFromPickCount, EggServiceMenu_Bank1B_Case04_ShowStringA10_Bank1B)
; reads: wPickCount
; writes: wTextWindowRows, wTextWindowWidth, wTextWindowTileLo, wTextWindowTileHi
ClearTileRowsFromPickCount::
Func_01B_74DC:: ; address name
    ld hl, $0601
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, [wPickCount]
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
; 3 call sites from 3 routines (e.g. ClearRecordPanelTiles, EggServiceMenu_Bank1B_Case04_ClearTileRowsFromPickCount, EggServiceMenu_Bank1B_Case05_DrawPickedRecordsRecordNamesAndIcons)
; reads: wPickCount
; writes: rRAMG2, rRAMB, wNameGlyphBuf, wArg1
; points at: wPickedRecords
DrawPickedRecordsRecordNamesAndIcons::
Func_01B_7537:: ; address name
    ld a, [wPickCount]
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
    ld hl, wPickedRecords
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
    call CopyRecordNameToNameGlyphBuf
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
    ld [wArg1], a
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

; address loaded by DrawPickedRecordsRecordNamesAndIcons
Data_01B_75A8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $10, $91, $70, $91, $D0, $91, $30, $92

; address loaded by DrawPickedRecordsRecordNamesAndIcons
Data_01B_75B0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $10, $16, $1C, $22

; with SRAM bank 0 enabled, copies the name of the record stored at WD789 cell 5 (CopyRecordNameToNameGlyphBuf, C = 1) and draws its glyphs at vTiles1 + $780 (E-0120)
; 1 call site from 1 routine (e.g. ClearAndDrawListEntriesCell5NameAtTiles1780)
; reads: wArg5, wArg6
; writes: rRAMG2, rRAMB, wNameGlyphBuf
DrawListEntriesCell5RecordNameAtTiles1780::
Func_01B_75B4:: ; address name
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $01
    call CopyRecordNameToNameGlyphBuf
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    ld de, vTiles1 + $780
    call CopyGlyphTilesToVRAM
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ret

; only called from routines of EggServiceMenu_Bank1B (E-0098)
; 2 call sites from 2 routines (e.g. EggServiceMenu_Bank1B_Case04_ShowStringA10_Bank1B_Case0A, EggServiceMenu_Bank1B_Case04_ShowStringA10_Bank1B)
; reads: wArg5, wArg6, wPickCount
; points at: wPickedRecords
EggServiceMenu_Bank1B_SetArg5ToListEntriesCell5::
Func_01B_75E4:: ; address name
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld de, wPickedRecords
    ld a, [wPickCount]
    add a, e
    ld e, a
    jr nc, Jump_01B_75FD
    inc d

Jump_01B_75FD::
    ld a, [hl]
    ld [de], a
    ret

; only called from routines of EggServiceMenu_Bank1B (E-0098)
; 2 call sites from 2 routines (e.g. EggServiceMenu_Bank1B_Case04_ClearTileRowsFromPickCount, EggServiceMenu_Bank1B_Case04_ShowStringA10_Bank1B)
; reads: wPickCount, wLinkRules, hTemp0, wScreenStep, wArg5, wArg6
; writes: wScreenStep, rRAMG2, rRAMB, rRAMG
EggServiceMenu_Bank1B_WriteScreenStepAndRAMG2Etc::
Func_01B_7600:: ; address name
    ld a, [wPickCount]
    cp a, $03
    jp z, Jump_01B_76E0
    ld a, [wLinkRules + $5]
    bit 7, a
    jr z, Jump_01B_7688
    bit 6, a
    jr nz, Jump_01B_764B
    ld a, [wPickCount]
    inc a
    ld b, a
    ld c, $00
    ld de, $0000

Jump_01B_761D::
    push bc
    push de
    ld a, c
    ld c, $56
    call EggServiceMenu_Bank1B_LoadSRAMRecordByte
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
    ld a, [wLinkRules + $5]
    and a, $01
    ld h, a
    ld a, [wLinkRules + $4]
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
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
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
    ld a, [wLinkRules + $3]
    ld b, a
    ldh a, [hTemp0]
    cp a, b
    jr c, Jump_01B_7688
    jr z, Jump_01B_7688

Jump_01B_767A::
    ld a, $11
    call ShowStringA10_Bank1B
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    xor a, a
    ret

Jump_01B_7688::
    ld a, [wLinkRules + $6]
    bit 7, a
    jr z, Jump_01B_76E0
    ld a, [wLinkRules + $7]
    bit 0, a
    jr nz, Jump_01B_76CB
    ld a, [wPickCount]
    ld c, $0D
    call EggServiceMenu_Bank1B_LoadSRAMRecordByte
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
    ld bc, wLinkRules + $6
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
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    xor a, a
    ret

Jump_01B_76CB::
    call EggServiceMenu_Bank1B_Shared02_WriteRAMG2AndRAMB
    cp a, $FF
    jr nz, Jump_01B_76E0
    ld a, $13
    call ShowStringA10_Bank1B
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    xor a, a
    ret

Jump_01B_76E0::
    ld a, $FF
    ret

; copies the name of the record at WD789 cell 5 (11 bytes) to wC130 (E-0124)
; 4 call sites from 4 routines (e.g. EggServiceMenu_Bank1B_Case04_ShowStringA10_Bank1B, EggServiceMenu_Bank1B_Case0F_ShowInfoOKYesN, GameMode6_Update_Case04_Case08_UpdatePagedListCursor, GameMode6_Update_Case05_UpdatePagedListCursor)
; reads: wArg5, wArg6
; writes: rRAMG2, rRAMB, rRAMG
; points at: wNameGlyphBuf, wTextBuf0
CopyListEntriesCell5NameToTextBuf0::
Func_01B_76E3:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld c, $01
    call CopyRecordNameToNameGlyphBuf
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
; 2 call sites from 2 routines (e.g. EggServiceMenu_Bank1B_Case04_Case0A_Sub01_FinishPickedRecordsEntryAndAdvance, EggServiceMenu_Bank1B_Case04_Case0A_Sub01_ShowStringA10_Bank1B_Case04)
; reads: wPickCount, wScreenState
; writes: wSelectedRecord, wPackWork, wPickCount, wScreenStep, wScreenSubStep, wScreenState
FinishPickedRecordsEntryAndAdvance::
Func_01B_7716:: ; address name
    call PadPickedRecordsWithFFToThree
    ld a, [wPickCount]
    ld [wSelectedRecord], a
    ld a, $FF
    ld [wPackWork], a
    ld a, $04
    ld [wPickCount], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 5 x 1 tiles, one row per line
TileRect_1B_7738::
Data_01B_7738:: ; address name
    db $B1, $B1, $B1, $B1, $B2 ; id 0

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 13 x 2 tiles, one row per line
TileRect_1B_773D::
Data_01B_773D:: ; address name
    db $B6, $EA, $ED, $C3, $C3, $F8, $F9, $FA, $FB, $FC, $C3, $C7, $B7 ; id 0
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 1

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 10 x 7 tiles, one row per line
TileRect_1B_7757::
Data_01B_7757:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $E1, $ED, $11, $12, $13, $14, $15, $10, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $E2, $ED, $17, $18, $19, $1A, $1B, $16, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $E3, $ED, $1D, $1E, $1F, $20, $21, $1C, $B7 ; id 5
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 6

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 10 x 9 tiles, one row per line
TileRect_1B_779D::
Data_01B_779D:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $E1, $ED, $11, $12, $13, $14, $15, $10, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $E2, $ED, $17, $18, $19, $1A, $1B, $16, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $E3, $ED, $1D, $1E, $1F, $20, $21, $1C, $B7 ; id 5
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA ; id 6
    db $B6, $C3, $C3, $23, $24, $25, $26, $27, $22, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 5 tiles, one row per line
TileRect_1B_77F7::
Data_01B_77F7:: ; address name
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 0
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 1
    db $B2, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 2
    db $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 3
    db $B5, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 5 tiles, one row per line
TileRect_1B_781F::
Data_01B_781F:: ; address name
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 0
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 1
    db $B2, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 2
    db $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 3
    db $B5, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 5 tiles, one row per line
TileRect_1B_7847::
Data_01B_7847:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $70, $71, $72, $73, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $74, $75, $C3, $C3, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; address loaded by EggServiceMenu_Bank1B_Case04_SetDefaultStringWindow_Bank1B, EggServiceMenu_Bank1B_Case04_ShowStringA10_Bank1B, EggServiceMenu_Bank1B_Case04_EraseCEntriesOfWordTable_Bank1B, EggServiceMenu_Bank1B_Case04_Case0A_EraseCEntriesOfWordTable_Bank1B and 1 more
Data_01B_786F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $79, $C3, $A1, $C3, $C9, $C3, $F1, $C3, $19, $C4

; address loaded by EggServiceMenu_Bank1B_WriteScreenStepAndRAMG2Etc
Data_01B_7879:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $40, $00, $20, $00, $10, $00, $08, $00, $04, $00, $02, $00, $01, $80, $00
    db $40, $00, $20, $00, $10, $00

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 5 tiles, one row per line
TileRect_1B_788F::
Data_01B_788F:: ; address name
    db $C3, $C3, $C3, $C3, $C3, $C3 ; id 0
    db $C3, $C3, $C3, $C3, $C3, $C3 ; id 1
    db $C3, $C3, $C3, $C3, $C3, $C3 ; id 2
    db $C3, $C3, $C3, $C3, $C3, $C3 ; id 3
    db $C3, $C3, $C3, $C3, $C3, $C3 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 5 tiles, one row per line
TileRect_1B_78AD::
Data_01B_78AD:: ; address name
    db $B4, $B4, $B4, $B4, $B4, $B5 ; id 0
    db $C3, $C3, $C3, $C3, $C3, $C3 ; id 1
    db $C3, $C3, $C3, $C3, $C3, $C3 ; id 2
    db $C3, $C3, $C3, $C3, $C3, $C3 ; id 3
    db $C3, $C3, $C3, $C3, $C3, $C3 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 5 tiles, one row per line
TileRect_1B_78CB::
Data_01B_78CB:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $76, $77, $78, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $79, $73, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 9 x 7 tiles, one row per line
TileRect_1B_78E9::
Data_01B_78E9:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $30, $31, $32, $33, $34, $35, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $36, $37, $38, $39, $3A, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $3B, $3C, $3D, $3E, $C3, $C3, $B7 ; id 5
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 6

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 11 tiles, one row per line
TileRect_1B_7928::
Data_01B_7928:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $D5, $D6, $D7, $D8, $D9, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $DA, $DB, $DC, $DD, $DE, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $F0, $F1, $F2, $F3, $F4, $B7 ; id 7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 8
    db $B6, $C3, $A4, $A5, $A6, $CE, $CF, $B7 ; id 9
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 10
    ds $680, $00
