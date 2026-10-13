; ROM bank $1B: link key exchange, egg service, link screens
; The annotated listing of this bank is build/listing/bank1b.asm.

SECTION "Bank 1B", ROMX[$4000], BANK[$1B]
    db $1b

; unless wLinkStatus bit 7 is set (then it sets bit 6 and returns), runs the routine for
; wLinkSession (0: wait for the serial transfer; 1-8: RunLinkSessionNExchange when wLinkMode is set
; and wLinkRole bit 0 is set); called from ComputeSpriteScrollOffsets (E-0259)
RunLinkSession::
    ld a, [wLinkStatus]
    bit 7, a
    jr z, .check_link_session
    set 6, a
    ld [wLinkStatus], a
    ret

.check_link_session:
    ld a, [wLinkSession]
    and a
    jr z, RunLinkSession_WaitSerialTransferDone
    ld a, [wLinkSession]
    jumptable
    dw RunLinkSession_WaitSerialTransferDone
    dw RunLinkSession_1Exchange
    dw RunLinkSession_2Exchange
    dw RunLinkSession_3Exchange
    dw RunLinkSession_4Exchange
    dw RunLinkSession_5Exchange
    dw RunLinkSession_6Exchange
    dw RunLinkSession_7Exchange
    dw RunLinkSession_8Exchange

RunLinkSession_WaitSerialTransferDone::
    ld a, $ff
    ld [wGlyphListPos], a
    xor a
    ld [wScreenCounter], a
    ld [wGlyphListPos], a
    call WaitSerialTransferDone
    ld a, [wScreenStep]
    ld [wGlyphListPos], a
    ldh a, [rSB]
    ld b, a
    cp $f1
    jp z, .call_link_check_screen_counter_state6
    cp $f5
    jr z, .call_link_check_screen_counter_state
    cp $f6
    jr z, .call_link_check_screen_counter_state2
    cp $b7
    jr z, .call_link_check_screen_counter_state3
    cp $e0
    jp z, .call_link_check_screen_counter_state4
    cp $dc
    jp z, .call_link_check_screen_counter_state5
    jp .check_title_screen_sub_state

.call_link_check_screen_counter_state:
    call LinkCheckScreenCounterState
    cp $ff
    jp z, .set_link_status_to_03
    ld a, [wMenuState]
    cp $02
    jr z, .read_link_role
    ld a, $02
    ld [wMenuOption], a
    ld a, [wScreenSubStep]
    ld [wGlyphListStart], a
    jp .set_link_status_to_03

.read_link_role:
    ld a, [wLinkRole]
    set 0, a
    set 1, a
    ld [wLinkRole], a
    jp .call_queue_sound_effect2

.call_link_check_screen_counter_state2:
    call LinkCheckScreenCounterState
    cp $ff
    jp z, .set_link_status_to_03
    ld a, [wMenuState]
    cp $03
    jr z, .read_link_role2
    ld a, $03
    ld [wMenuOption], a
    ld a, [wScreenSubStep]
    ld [wGlyphListStart], a
    jp .set_link_status_to_03

.read_link_role2:
    ld a, [wLinkRole]
    set 0, a
    set 1, a
    ld [wLinkRole], a
    jp .call_queue_sound_effect3

.call_link_check_screen_counter_state3:
    call LinkCheckScreenCounterState
    cp $ff
    jp z, .set_link_status_to_03
    ld a, [wMenuState]
    cp $04
    jr z, .read_link_role3
    ld a, $04
    ld [wMenuOption], a
    ld a, [wScreenSubStep]
    ld [wGlyphListStart], a
    jp .set_link_status_to_03

.read_link_role3:
    ld a, [wLinkRole]
    set 0, a
    set 1, a
    ld [wLinkRole], a
    jp .call_queue_sound_effect5

.call_link_check_screen_counter_state4:
    call LinkCheckScreenCounterState
    cp $ff
    jp z, .set_link_status_to_03
    ld a, [wMenuState]
    cp $06
    jr z, .read_link_role4
    ld a, $06
    ld [wMenuOption], a
    ld a, [wScreenSubStep]
    ld [wGlyphListStart], a
    jp .set_link_status_to_03

.read_link_role4:
    ld a, [wLinkRole]
    set 0, a
    set 1, a
    ld [wLinkRole], a
    jp .call_queue_sound_effect6

.call_link_check_screen_counter_state5:
    call LinkCheckScreenCounterState
    cp $ff
    jp z, .set_link_status_to_03
    ld a, [wMenuState]
    cp $05
    jr z, .read_link_role5
    ld a, $05
    ld [wMenuOption], a
    ld a, [wScreenSubStep]
    ld [wGlyphListStart], a
    jp .set_link_status_to_03

.read_link_role5:
    ld a, [wLinkRole]
    set 0, a
    set 1, a
    ld [wLinkRole], a
    jp .call_queue_sound_effect4

.call_link_check_screen_counter_state6:
    call LinkCheckScreenCounterState
    cp $ff
    jp z, .set_link_status_to_03
    ld a, [wMenuState]
    cp $07
    jr z, .read_link_role6
    ld a, [wLinkByte94]
    or a
    jp z, .set_link_status_to_03
    ld a, $07
    ld [wMenuOption], a
    ld a, [wScreenSubStep]
    ld [wGlyphListStart], a
    jp .set_link_status_to_03

.read_link_role6:
    ld a, [wLinkRole]
    set 0, a
    set 1, a
    ld [wLinkRole], a
    jp .call_queue_sound_effect

.check_title_screen_sub_state:
    ld a, [wTitleScreenSubState]
    cp $02
    jr z, .check_link_timer_lo
    jp .set_link_status_to_03

.check_link_timer_lo:
    ld a, [wLinkTimerLo]
    cp b
    jp z, .set_link_status_to_03
    call ShortDelayLoop
    ld a, b
    ld [wScreenState], a
    cp $f3
    jr nz, .cp_FA
    ld a, [wMenuState]
    cp $07
    jr z, .read_link_role7
    ld a, $ff
    ld [wSubMenuCursor2], a
    ld a, [wGridCursorX]
    ld [wGridCursorY], a
    jp .set_link_status_to_03

.read_link_role7:
    ld a, [wLinkRole]
    set 0, a
    res 1, a
    ld [wLinkRole], a
    jp .call_queue_sound_effect

.cp_FA:
    cp $fa
    jr nz, .cp_FB
    ld a, [wMenuState]
    cp $02
    jr z, .read_link_role8
    ld a, $ff
    ld [wSubMenuCursor2], a
    ld a, [wGridCursorX]
    ld [wGridCursorY], a
    jp .set_link_status_to_03

.read_link_role8:
    ld a, [wLinkRole]
    set 0, a
    res 1, a
    ld [wLinkRole], a
    jp .call_queue_sound_effect2

.cp_FB:
    cp $fb
    jr nz, .cp_FC
    ld a, [wMenuState]
    cp $03
    jr z, .read_link_role9
    ld a, $ff
    ld [wSubMenuCursor2], a
    ld a, [wGridCursorX]
    ld [wGridCursorY], a
    jp .set_link_status_to_03

.read_link_role9:
    ld a, [wLinkRole]
    set 0, a
    res 1, a
    ld [wLinkRole], a
    jp .call_queue_sound_effect3

.cp_FC:
    cp $fc
    jr nz, .cp_E1
    ld a, [wMenuState]
    cp $04
    jr z, .read_link_role10
    ld a, $ff
    ld [wSubMenuCursor2], a
    ld a, [wGridCursorX]
    ld [wGridCursorY], a
    jp .set_link_status_to_03

.read_link_role10:
    ld a, [wLinkRole]
    set 0, a
    res 1, a
    ld [wLinkRole], a
    jp .call_queue_sound_effect5

.cp_E1:
    cp $e1
    jr nz, .cp_DD
    ld a, [wMenuState]
    cp $06
    jr z, .read_link_role11
    ld a, $ff
    ld [wSubMenuCursor2], a
    ld a, [wGridCursorX]
    ld [wGridCursorY], a
    jp .set_link_status_to_03

.read_link_role11:
    ld a, [wLinkRole]
    set 0, a
    res 1, a
    ld [wLinkRole], a
    jp .call_queue_sound_effect6

.cp_DD:
    cp $dd
    jr nz, .set_sub_menu_cursor2_to_FF
    ld a, [wMenuState]
    cp $05
    jr z, .read_link_role12
    ld a, $ff
    ld [wSubMenuCursor2], a
    ld a, [wGridCursorX]
    ld [wGridCursorY], a
    jp .set_link_status_to_03

.read_link_role12:
    ld a, [wLinkRole]
    set 0, a
    res 1, a
    ld [wLinkRole], a
    jp .call_queue_sound_effect4

.set_sub_menu_cursor2_to_FF:
    ld a, $ff
    ld [wSubMenuCursor2], a
    jp .set_link_status_to_03
    db $3e, $ff, $ea, $70, $c4, $c3, $57, $43

.call_queue_sound_effect:
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
    jr z, .skip
    farcall LoadKeyWorldFlagsRecordFromSRAMSlotKeyWorldSlot

.skip:
    ei
    ld hl, wGameMode
    ld a, $05
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld a, $05
    ld [wLinkSession], a
    jp .clear_world_map_state

.call_queue_sound_effect2:
    ld a, $69
    call QueueSoundEffect
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $01
    ld [wLinkMode], a
    ld hl, wGameMode
    ld a, $05
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld a, $02
    ld [wLinkSession], a
    jr .clear_world_map_state

.call_queue_sound_effect3:
    ld a, $69
    call QueueSoundEffect
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $01
    ld [wLinkMode], a
    ld hl, wGameMode
    ld a, $05
    ld [hli], a
    ld a, $03
    ld [hli], a
    ld a, $03
    ld [wLinkSession], a
    jr .clear_world_map_state

.call_queue_sound_effect4:
    ld a, $69
    call QueueSoundEffect
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $01
    ld [wLinkMode], a
    ld hl, wGameMode
    ld a, $05
    ld [hli], a
    ld a, $07
    ld [hli], a
    ld a, $08
    ld [wLinkSession], a
    jr .clear_world_map_state

.call_queue_sound_effect5:
    ld a, $69
    call QueueSoundEffect
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $01
    ld [wLinkMode], a
    ld hl, wGameMode
    ld a, $05
    ld [hli], a
    ld a, $04
    ld [hli], a
    ld a, $04
    ld [wLinkSession], a
    jr .clear_world_map_state

.call_queue_sound_effect6:
    ld a, $69
    call QueueSoundEffect
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $02
    ld [wLinkMode], a
    ld hl, wGameMode
    ld a, $05
    ld [hli], a
    ld a, $06
    ld [hli], a
    ld a, $06
    ld [wLinkSession], a
    jr .clear_world_map_state

.clear_world_map_state:
    xor a
    ld [wWorldMapState], a
    ld [wGameMode2Arg], a
    ld [wLinkExchangeState], a
    ld [wLinkStateByte], a
    ld [wLinkScreenStep], a
    ld a, $01
    ld [wModeChangeRequest], a
    call ClearSoundChannelSlots

.set_link_status_to_03:
    ld a, $03
    ld [wLinkStatus], a
    ld a, $f8
    call SerialSendByte
    ret

; zeroes the first two bytes of each of six $20-byte sound channel slots from wSoundChannelSlots
; (E-0118)
ClearSoundChannelSlots::
    xor a
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
ShortDelayLoop::
    push bc
    ld bc, $0100

.loop:
    dec bc
    dec bc
    ld a, b
    or c
    jr nz, .loop
    pop bc
    ret

; A = 0 when the link state allows continuing (wTitleScreenSubState = 1 in mode 5 state 1 with
; wTitleScreenState and wLinkScreenFlag clear), else $FF; wScreenCounter = A on entry (E-0125)
LinkCheckScreenCounterState::
    ld [wScreenCounter], a
    ld c, a
    ld a, [wLinkTimerLo]
    cp c
    jr nz, .check_game_mode
    ld a, [wTitleScreenSubState]
    cp $01
    jr z, .check_game_mode
    jr .return_FF

.check_game_mode:
    ld a, [wGameMode]
    cp $05
    jr nz, .return_FF
    ld a, [wModeState]
    cp $01
    jr nz, .return_FF
    ld a, [wTitleScreenState]
    or a
    jr nz, .return_FF
    ld a, [wLinkScreenFlag]
    or a
    jr nz, .return_FF
    ld a, [wTitleScreenSubState]
    cp $01
    jr z, .return_0
    jr .return_FF

.return_0:
    xor a
    ret

.return_FF:
    ld a, $ff
    ret

; sends the byte at SendLinkByteForMenuOption_Bank1B_Data + (wMenuOption & $0F) through
; SerialSendByte (E-0122)
SendLinkByteForMenuOption_Bank1B::
    ld a, [wMenuOption]
    ld de, SendLinkByteForMenuOption_Bank1B_Data
    and $0f
    add e
    ld e, a
    jr nc, .call_serial_send_byte
    inc d

.call_serial_send_byte:
    ld a, [de]
    call SerialSendByte
    ret

SendLinkByteForMenuOption_Bank1B_Data::
    db $f4, $f4, $fa, $fb, $fc, $dd, $e1, $f3

RunLinkSession_1Exchange::
    ld a, [wLinkMode]
    or a
    jr z, .return
    ld a, [wLinkRole]
    bit 0, a
    jr z, .return
    call RunLinkSession1Exchange

.return:
    ret

; runs the routine for wLinkExchangeState (jump table of two) (E-0122)
RunLinkSession1Exchange::
    ld a, [wLinkExchangeState]
    jumptable
    dw RunLinkSession1Exchange_ToLinkSendStepWithBuffer
    dw RunLinkSession1Exchange_LinkReceiveStepWithBuffer

RunLinkSession1Exchange_ToLinkSendStepWithBuffer::
    call LinkSendStepWithBuffer
    ret

RunLinkSession1Exchange_LinkReceiveStepWithBuffer::
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

RunLinkSession_2Exchange::
    ld a, [wLinkMode]
    or a
    jr z, .return
    ld a, [wLinkRole]
    bit 0, a
    jr z, .return
    call RunLinkSession2Exchange

.return:
    ret

; runs the routine for wLinkExchangeState (jump table of two) (E-0122)
RunLinkSession2Exchange::
    ld a, [wLinkExchangeState]
    jumptable
    dw RunLinkSession2Exchange_ToLinkSendStepWithBuffer
    dw RunLinkSession2Exchange_LinkReceiveStepWithBuffer

RunLinkSession2Exchange_ToLinkSendStepWithBuffer::
    call LinkSendStepWithBuffer
    ret

RunLinkSession2Exchange_LinkReceiveStepWithBuffer::
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

RunLinkSession_3Exchange::
    ld a, [wLinkMode]
    or a
    jr z, .return
    ld a, [wLinkRole]
    bit 0, a
    jr z, .return
    call RunLinkSession3Exchange

.return:
    ret

; runs the routine for wLinkExchangeState (jump table of two) (E-0122)
RunLinkSession3Exchange::
    ld a, [wLinkExchangeState]
    jumptable
    dw RunLinkSession3Exchange_ToLinkSendStepWithBuffer
    dw RunLinkSession3Exchange_LinkReceiveStepWithBuffer

RunLinkSession3Exchange_ToLinkSendStepWithBuffer::
    call LinkSendStepWithBuffer
    ret

RunLinkSession3Exchange_LinkReceiveStepWithBuffer::
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

RunLinkSession_4Exchange::
    ld a, [wLinkMode]
    or a
    jr z, .return
    ld a, [wLinkRole]
    bit 0, a
    jr z, .return
    call RunLinkSession4Exchange

.return:
    ret

; runs the routine for wLinkExchangeState (jump table of two) (E-0122)
RunLinkSession4Exchange::
    ld a, [wLinkExchangeState]
    jumptable
    dw RunLinkSession4Exchange_ToLinkSendStepWithBuffer
    dw RunLinkSession4Exchange_LinkReceiveStepWithBuffer

RunLinkSession4Exchange_ToLinkSendStepWithBuffer::
    call LinkSendStepWithBuffer
    ret

RunLinkSession4Exchange_LinkReceiveStepWithBuffer::
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

RunLinkSession_5Exchange::
    ld a, [wLinkMode]
    or a
    jr z, .return
    ld a, [wLinkRole]
    bit 0, a
    jr z, .return
    call RunLinkSession5Exchange

.return:
    ret

; runs the routine for wLinkExchangeState (jump table of two) (E-0122)
RunLinkSession5Exchange::
    ld a, [wLinkExchangeState]
    jumptable
    dw RunLinkSession5Exchange_ToLinkSendStepWithBuffer
    dw RunLinkSession5Exchange_LinkReceiveStepWithBuffer

RunLinkSession5Exchange_ToLinkSendStepWithBuffer::
    call LinkSendStepWithBuffer
    ret

RunLinkSession5Exchange_LinkReceiveStepWithBuffer::
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

RunLinkSession_6Exchange::
    ld a, [wLinkMode]
    or a
    jr z, .return
    ld a, [wLinkRole]
    bit 0, a
    jr z, .return
    call RunLinkSession6Exchange

.return:
    ret

; runs the routine for wLinkExchangeState (jump table of two) (E-0122)
RunLinkSession6Exchange::
    ld a, [wLinkExchangeState]
    jumptable
    dw RunLinkSession6Exchange_ToLinkSendStepWithBuffer
    dw RunLinkSession6Exchange_LinkReceiveStepWithBuffer

RunLinkSession6Exchange_ToLinkSendStepWithBuffer::
    call LinkSendStepWithBuffer
    ret

RunLinkSession6Exchange_LinkReceiveStepWithBuffer::
    call LinkReceiveStepWithBuffer
    ld hl, wVBlankFlags
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call RunFrameTickFadeAndCounter_Bank1B
    farcall RunLinkSession6Exchange_Case01_ReadTitleScreenStateAndTitleScreenSubStateEtc
    ld hl, wVBlankFlags
    res 1, [hl]
    ret

RunLinkSession_7Exchange::
    ld a, [wLinkMode]
    or a
    jr z, .return
    ld a, [wLinkRole]
    bit 0, a
    jr z, .return
    call RunLinkSession7Exchange

.return:
    ret

; runs the routine for wLinkExchangeState (jump table of two) (E-0122)
RunLinkSession7Exchange::
    ld a, [wLinkExchangeState]
    jumptable
    dw RunLinkSession7Exchange_ToLinkSendStepWithBuffer
    dw RunLinkSession7Exchange_LinkReceiveStepWithBuffer

RunLinkSession7Exchange_ToLinkSendStepWithBuffer::
    call LinkSendStepWithBuffer
    ret

RunLinkSession7Exchange_LinkReceiveStepWithBuffer::
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

RunLinkSession_8Exchange::
    ld a, [wLinkMode]
    or a
    jr z, .return
    ld a, [wLinkRole]
    bit 0, a
    jr z, .return
    call RunLinkSession8Exchange

.return:
    ret

; runs the routine for wLinkExchangeState (jump table of two) (E-0122)
RunLinkSession8Exchange::
    ld a, [wLinkExchangeState]
    jumptable
    dw RunLinkSession8Exchange_ToLinkSendStepWithBuffer
    dw RunLinkSession8Exchange_LinkReceiveStepWithBuffer

RunLinkSession8Exchange_ToLinkSendStepWithBuffer::
    call LinkSendStepWithBuffer
    ret

RunLinkSession8Exchange_LinkReceiveStepWithBuffer::
    call LinkReceiveStepWithBuffer
    ld hl, wVBlankFlags
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call RunFrameTickFadeAndCounter_Bank1B
    farcall RunLinkSession8Exchange_Case01_WriteTitleScreenState
    ld hl, wVBlankFlags
    res 1, [hl]
    ret

; link: sends $F9 when not connected; otherwise reads the received byte into wLinkJoypadHeld, polls
; the joypad and starts sending wJoypadHeld; with bit 1 of wVBlankFlags sends $F3 (E-0125)
LinkExchangeJoypadByte::
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .check_v_blank_flags
    ld a, $01
    ld [wLinkExchangeState], a
    ld a, $f9
    jp SerialSendByte

.check_v_blank_flags:
    ld a, [wVBlankFlags]
    bit 1, a
    jr nz, LinkExchangeJoypadByte_Skip
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

LinkExchangeJoypadByte_Skip::
    ld a, $20

.loop:
    dec a
    jr nz, .loop
    ld hl, wVBlankFlags
    set 2, [hl]
    ld a, $01
    ld [wLinkExchangeState], a
    ld a, $f3
    jp StartSerialTransferInternalClock

; link: reads the received byte into wLinkJoypadHeld and updates the joypad state; byte $F3 restores
; the saved joypad state and counts down wLinkTimeoutLo (E-0127)
LinkReceiveJoypadByte::
    ld a, [wLinkRole]
    bit 1, a
    jr nz, LinkHandshakeSendFAOrFB
    ld a, [wLinkReady]
    or a
    jr nz, .set_serial_received
    ldh a, [rSB]
    ld [wSerialReceived], a
    cp $f3
    jp z, LinkReceiveJoypadByte_ReadLinkSavedJoypadHeld
    jr .read_link_joypad_held

.set_serial_received:
    ldh a, [rSB]
    ld [wSerialReceived], a

.read_link_joypad_held:
    ld hl, wVBlankFlags
    set 1, [hl]
    ld a, [wLinkJoypadHeld]
    ld [wLinkJoypadHeldPrev], a
    ld a, [wSerialReceived]
    ld [wLinkJoypadHeld], a
    call UpdateJoypadPresses
    call RunFrameTickFadeAndCounter_Bank1B
    xor a
    ld [wLinkExchangeState], a
    ld hl, wVBlankFlags
    res 1, [hl]
    ret

LinkReceiveJoypadByte_ReadLinkSavedJoypadHeld::
    ld a, [wLinkSavedJoypadHeld]
    ld [wJoypadHeld], a
    ld a, [wLinkSavedJoypadHeldPrev]
    ld [wJoypadHeldPrev], a
    ld a, [wLinkSendByte]
    cp $ff
    jr nz, .clear_link_exchange_state
    ld a, [wLinkTimeoutLo]
    sub $01
    ld [wLinkTimeoutLo], a
    ld a, [wLinkTimeoutHi]
    sbc $00
    ld [wLinkTimeoutHi], a

.clear_link_exchange_state:
    xor a
    ld [wLinkExchangeState], a
    ld hl, wVBlankFlags
    set 7, [hl]
    ret

; link: with bit 2 of wVBlankFlags clear sends $FA and runs a frame; otherwise clears it, sends $FB
; and sets bit 7 (E-0124)
LinkHandshakeSendFAOrFB::
    ld hl, wVBlankFlags
    bit 2, [hl]
    jr nz, LinkHandshakeSendFAOrFB_Skip
    set 1, [hl]
    xor a
    ld [wLinkExchangeState], a
    ld a, $fa
    call SerialSendByte
    call RunFrameTickFadeAndCounter_Bank1B
    ld hl, wVBlankFlags
    res 1, [hl]
    ret

LinkHandshakeSendFAOrFB_Skip::
    ld hl, wVBlankFlags
    res 2, [hl]
    xor a
    ld [wLinkExchangeState], a
    ld a, $fb
    call SerialSendByte
    ld hl, wVBlankFlags
    set 7, [hl]
    ret

; link: sends $F9 when not connected; otherwise reads the received byte, polls the joypad and sends
; the queued byte or the next byte of the transfer buffer wLinkBufferPtrLo (E-0128)
LinkSendStepWithBuffer::
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .check_v_blank_flags
    ld a, $01
    ld [wLinkExchangeState], a
    ld a, $f9
    jp SerialSendByte

.check_v_blank_flags:
    ld a, [wVBlankFlags]
    bit 1, a
    jp nz, LinkExchangeJoypadByte_Skip
    ld a, [wLinkSendByte]
    cp $ff
    jr z, .skip
    ldh a, [rSB]
    ld [wSerialReceived], a
    ld [wLinkMessage], a
    call PollJoypad
    call UpdateJoypadPresses
    ld a, $01
    ld [wLinkExchangeState], a
    ld a, [wLinkSendByte]
    jp StartSerialTransferInternalClock

.skip:
    ld hl, wLinkBufferCountLo
    ld a, [hli]
    or [hl]
    jr z, .set_link_exchange_state_to_01
    ld a, [wLinkBufferPtrLo]
    ld l, a
    ld a, [wLinkBufferPtrHi]
    ld h, a
    ldh a, [rSB]
    ld [hl], a
    call PollJoypad
    call UpdateJoypadPresses
    ld a, [wLinkBufferPtrLo]
    add $01
    ld [wLinkBufferPtrLo], a
    ld a, [wLinkBufferPtrHi]
    adc $00
    ld [wLinkBufferPtrHi], a
    ld a, [wLinkBufferCountLo]
    sub $01
    ld [wLinkBufferCountLo], a
    ld a, [wLinkBufferCountHi]
    sbc $00
    ld [wLinkBufferCountHi], a
    ld a, [wLinkTimeoutLo]
    ld l, a
    ld a, [wLinkTimeoutHi]
    ld h, a
    push hl
    ld a, [wLinkTimeoutLo]
    add $01
    ld [wLinkTimeoutLo], a
    ld a, [wLinkTimeoutHi]
    adc $00
    ld [wLinkTimeoutHi], a
    pop hl
    ld a, $01
    ld [wLinkExchangeState], a
    ld a, [hl]
    jp StartSerialTransferInternalClock

.set_link_exchange_state_to_01:
    ld a, $01
    ld [wLinkExchangeState], a
    ldh a, [rSB]
    ld [wSerialReceived], a
    ld [wLinkMessage], a
    call PollJoypad
    call UpdateJoypadPresses
    ld a, $f0
    jp StartSerialTransferInternalClock

; link: reads the received byte; stores it in the transfer buffer wLinkBufferPtrLo while bytes
; remain, else as the remote joypad; handles the $F3 resync (E-0128)
LinkReceiveStepWithBuffer::
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .skip2
    ld a, [wLinkReady]
    or a
    jr nz, .set_serial_received
    ldh a, [rSB]
    ld [wSerialReceived], a
    cp $f3
    jp z, LinkReceiveJoypadByte_ReadLinkSavedJoypadHeld
    jr .check_link_send_byte

.set_serial_received:
    ldh a, [rSB]
    ld [wSerialReceived], a

.check_link_send_byte:
    ld hl, wVBlankFlags
    set 1, [hl]
    ld a, [wLinkSendByte]
    cp $ff
    jr z, .skip
    ld a, [wSerialReceived]
    ld [wLinkMessage], a
    call UpdateJoypadPresses
    xor a
    ld [wLinkExchangeState], a
    ret

.skip:
    ld hl, wLinkBufferCountLo
    ld a, [hli]
    or [hl]
    jr z, .read_serial_received
    ld a, [wLinkBufferPtrLo]
    ld l, a
    ld a, [wLinkBufferPtrHi]
    ld h, a
    ldh a, [rSB]
    ld [hl], a
    call UpdateJoypadPresses
    ld a, [wLinkBufferPtrLo]
    add $01
    ld [wLinkBufferPtrLo], a
    ld a, [wLinkBufferPtrHi]
    adc $00
    ld [wLinkBufferPtrHi], a
    ld a, [wLinkBufferCountLo]
    sub $01
    ld [wLinkBufferCountLo], a
    ld a, [wLinkBufferCountHi]
    sbc $00
    ld [wLinkBufferCountHi], a
    xor a
    ld [wLinkExchangeState], a
    ret

.read_serial_received:
    ld a, [wSerialReceived]
    ld [wLinkMessage], a
    call UpdateJoypadPresses
    xor a
    ld [wLinkExchangeState], a
    ret

.skip2:
    ld hl, wVBlankFlags
    bit 2, [hl]
    jp nz, LinkHandshakeSendFAOrFB_Skip
    set 1, [hl]
    xor a
    ld [wLinkExchangeState], a
    ld a, $fa
    call SerialSendByte
    ret

; calls StepTextPrinter when wTextFlags is non-zero, then StepFade; adds 1 to the 16-bit
; wFrameCounterLo/Hi and clears wLinkFrameCounterLo and wLinkFrameCounterHi (E-0073)
RunFrameTickFadeAndCounter_Bank1B::
    ld a, [wTextFlags]
    or a
    jr z, .call_step_fade
    call StepTextPrinter

.call_step_fade:
    call StepFade
    ld a, [wFrameCounterLo]
    add $01
    ld [wFrameCounterLo], a
    ld a, [wFrameCounterHi]
    adc $00
    ld [wFrameCounterHi], a
    xor a
    ld [wLinkFrameCounterLo], a
    ld [wLinkFrameCounterHi], a
    ret

; while a serial transfer is in progress (bit 7 of rSC), counts wScreenCounter/wGlyphListPos up;
; returns A = $FE once the count reaches $400, otherwise returns when the transfer ends (E-0122)
WaitSerialTransferWithTimeout::
    ldh a, [rSC]
    bit 7, a
    jr nz, .read_screen_counter
    ret

.read_screen_counter:
    ld a, [wScreenCounter]
    add $01
    ld [wScreenCounter], a
    ld a, [wGlyphListPos]
    adc $00
    ld [wGlyphListPos], a
    cp $04
    jr c, WaitSerialTransferWithTimeout
    ld a, $fe
    ret

; ld de, this bank's string table / BeginStringDisplay
BeginStringDisplay_Bank1B_480C::
    ld de, StringCategories_1B_4821
    call BeginStringDisplay
    ret
    db $11, $21, $48, $cd, $fe, $25, $c9

; BeginStringDisplay_Bank1B_480C (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
ShowString_Bank1B_481A::
    call BeginStringDisplay_Bank1B_480C
    call RunStringDisplayToEnd
    ret

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_1B_4821::
    dw StringList_1B_4823 ; id 0

; category list of StringCategories_1B_4821; one pointer per wStringIndex (E-0217)
; record: string
StringList_1B_4823::
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

String_1B_4821_00_00::
    db "Starting key<LINE>"
    db "trade…<PROMPT>"
    db "@"

String_1B_4821_00_02::
    db "You refused to<LINE>"
    db "trade keys.<PROMPT>"
    db "@"

String_1B_4821_00_03::
    db "Your pal refused<LINE>"
    db "to trade keys.<PROMPT>"
    db "@"

String_1B_4821_00_04::
    db "Is it OK to trade<LINE>"
    db "this key?@"

String_1B_4821_00_05::
    db "That key cannot be<LINE>"
    db "traded.<WAIT>"
    db "@"

String_1B_4821_00_06::
    db "Please choose the<LINE>"
    db "key to trade.@"

String_1B_4821_00_07::
    db "Please wait.@"

String_1B_4821_00_08::
    db "Keys can't have<LINE>"
    db "the same name.<WAIT>"
    db "@"

String_1B_4821_00_09::
    db "Is it OK to trade<LINE>"
    db "keys?@"

String_1B_4821_00_0A::
    db "Is it OK to record<LINE>"
    db "the results?@"

String_1B_4821_00_0B::
    db "Readying trade…<LINE>"
    db "Please wait.@"

String_1B_4821_00_0C::
    db "Keys will now be<LINE>"
    db "traded.<WAIT>"
    db "@"

String_1B_4821_00_0D::
    db "Your pal has a key<LINE>"
    db "of the same name.<WAIT>"
    db "@"

String_1B_4821_00_0E::
    db "TradeExit@"

String_1B_4821_00_0F::
    db "You can't hold any<LINE>"
    db "more keys.<WAIT>"
    db "@"

String_1B_4821_00_10::
    db "Choose the members<LINE>"
    db "for VS battle.@"

String_1B_4821_00_12::
    db "Pick <BUF0> for the<LINE>"
    db "team?@"

String_1B_4821_00_13::
    db "Choose one more<LINE>"
    db "member for battle?@"

String_1B_4821_00_14::
    db "Will you put up a<LINE>"
    db "prize?@"

String_1B_4821_00_15::
    db "You have no<LINE>"
    db "monsters on the<PROMPT>"
    db "<NEXT>farm to serve as"
    db "<NEXT>the prize.<WAIT>"
    db "@"

String_1B_4821_00_16::
    db "Select a monster<LINE>"
    db "as the prize.@"

String_1B_4821_00_17::
    db "Put up <BUF0> as a<LINE>"
    db "prize?@"

String_1B_4821_00_18::
    db "Begin battle?@"

String_1B_4821_00_19::
    db "Starting battle…@"

String_1B_4821_00_1A::
    db "You refused to<LINE>"
    db "battle.@"

String_1B_4821_00_1B::
    db "Your pal refused<LINE>"
    db "to battle.@"

String_1B_4821_00_1C::
    db "Please wait.@"

String_1B_4821_00_1D::
    db "InfoOKYesN@"

String_1B_4821_00_1F::
    db "BattlePrizeExit@"

String_1B_4821_00_20::
    db "FightInfoEx@"

String_1B_4821_00_21::
    db "Monster level<LINE>"
    db "limit exceeded.<PROMPT>"
    db "<NEXT>Pick another"
    db "<NEXT>monster please.@"

String_1B_4821_00_22::
    db "That family is not<LINE>"
    db "permitted.@"

String_1B_4821_00_23::
    db "You already chose<LINE>"
    db "from that family.<PROMPT>"
    db "<NEXT>Pick another"
    db "<NEXT>monster please.@"

String_1B_4821_00_24::
    db "There is no prize<LINE>"
    db "for this battle.@"

String_1B_4821_00_25::
    db "There is no prize.@"

String_1B_4821_00_26::
    db "Your pal's key ring<LINE>"
    db "is full.<PROMPT>"
    db "<NEXT>Keys can't be"
    db "<NEXT>traded.<WAIT>"
    db "@"

String_1B_4821_00_27::
    db $f9, $00, $f0

; ld de, this bank's string table / BeginStringDisplay
BeginStringDisplay_Bank1B_4C86::
    ld de, StringCategories_1B_4C9B
    call BeginStringDisplay
    ret
    db $11, $9b, $4c, $cd, $fe, $25, $c9

; BeginStringDisplay_Bank1B_4C86 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
ShowString_Bank1B_4C94::
    call BeginStringDisplay_Bank1B_4C86
    call RunStringDisplayToEnd
    ret

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_1B_4C9B::
    dw StringList_1B_4C9D ; id 0

; category list of StringCategories_1B_4C9B; one pointer per wStringIndex (E-0217)
; record: string
StringList_1B_4C9D::
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

String_1B_4C9B_00_00::
    db "<VOICE1>*: Welcome. What<LINE>"
    db "would you like?@"

String_1B_4C9B_00_02::
    db "<VOICE1>*: Which will be<LINE>"
    db "the base monster?@"

String_1B_4C9B_00_03::
    db "<VOICE1>*: This is the one<LINE>"
    db "you want?@"

String_1B_4C9B_00_04::
    db "<VOICE1>*: Is there<LINE>"
    db "anything else?@"

String_1B_4C9B_00_05::
    db "<VOICE1>*: You won't have a<LINE>"
    db "monster with you!<WAIT>"
    db "@"

String_1B_4C9B_00_06::
    db "<VOICE1>*: That's too low<LINE>"
    db "in level to breed.<WAIT>"
    db "@"

String_1B_4C9B_00_07::
    db "<VOICE1>*: And what will<LINE>"
    db "its mate be?@"

String_1B_4C9B_00_08::
    db "<VOICE1>*: There's no<LINE>"
    db "potential mate.<WAIT>"
    db "@"

String_1B_4C9B_00_09::
    db "<VOICE1>*: <BUF0><LINE>"
    db "will result from<PROMPT>"
    db "<NEXT>this."
    db "<NEXT><WAIT>"
    db "@"

String_1B_4C9B_00_0A::
    db "<VOICE1>*: A great monster<LINE>"
    db "will be born!<WAIT>"
    db "@"

String_1B_4C9B_00_0B::
    db "<VOICE1>*: You already had<LINE>"
    db "that monster.<WAIT>"
    db "@"

String_1B_4C9B_00_0C::
    db "<VOICE1>*: You've never had<LINE>"
    db "that monster.<WAIT>"
    db "@"

String_1B_4C9B_00_0D::
    db "<VOICE1>*: OK to record in<LINE>"
    db "your Journal?@"

String_1B_4C9B_00_0E::
    db "<VOICE1>*: Fine, fine!<LINE>"
    db "I'll do it!<WAIT>"
    db "@"

String_1B_4C9B_00_0F::
    db "<VOICE1>*: Hatching that<LINE>"
    db "will cost <BUF0>G.<PROMPT>"
    db "<CLEAR>Should I hatch it<LINE>"
    db "too?@"

String_1B_4C9B_00_10::
    db "<VOICE1>*: I'll hatch the<LINE>"
    db "egg too, then.<WAIT>"
    db "@"

String_1B_4C9B_00_11::
    db "<VOICE1>*: I won't hatch<LINE>"
    db "the egg, then.<WAIT>"
    db "@"

String_1B_4C9B_00_12::
    db "<VOICE1>*: You don't have<LINE>"
    db "enough gold, so<PROMPT>"
    db "<CLEAR>I'll just do the<LINE>"
    db "breeding.<WAIT>"
    db "@"

String_1B_4C9B_00_13::
    db "<VOICE1>*: I'll send the<LINE>"
    db "egg to the farm.<WAIT>"
    db "@"

String_1B_4C9B_00_14::
    db "<VOICE1>*: Will you take<LINE>"
    db "<BUF0> with you?@"

String_1B_4C9B_00_15::
    db "<VOICE1>*: Raise it with<LINE>"
    db "love and care!<WAIT>"
    db "@"

String_1B_4C9B_00_16::
    db "<VOICE1>*: I'll send <BUF0><LINE>"
    db "to the farm, then.<WAIT>"
    db "@"

String_1B_4C9B_00_17::
    db "<VOICE1>*: Which will go<LINE>"
    db "back to the farm?@"

String_1B_4C9B_00_18::
    db "<VOICE1>*: Is this the one<LINE>"
    db "to send home?@"

String_1B_4C9B_00_19::
    db "<VOICE1>*: <BUF0> is<LINE>"
    db "going to the farm.<WAIT>"
    db "@"

String_1B_4C9B_00_1A::
    db "<VOICE1>*: Which egg should<LINE>"
    db "I hatch?@"

String_1B_4C9B_00_1B::
    db "<VOICE1>*: That will cost<LINE>"
    db "<BUF0>G. OK?@"

String_1B_4C9B_00_1C::
    db "<VOICE1>*: There isn't a<LINE>"
    db "single egg here.<WAIT>"
    db "@"

String_1B_4C9B_00_1D::
    db "<VOICE1>*: You don't have<LINE>"
    db "enough gold.<WAIT>"
    db "@"

String_1B_4C9B_00_1E::
    db "<VOICE1>*: You got the egg<LINE>"
    db "of <BUF0>.<WAIT>"
    db "@"

String_1B_4C9B_00_1F::
    db "<VOICE1>*: Become a great<LINE>"
    db "master!<WAIT>"
    db "@"

String_1B_4C9B_00_21::
    db "<VOICE1>*: Fine, fine.<LINE>"
    db "Just wait here.<WAIT>"
    db "@"

String_1B_4C9B_00_22::
    db "<BUF0> hatched!<WAIT>"
    db "@"

String_1B_4C9B_00_25::
    db "Please name it.<WAIT>"
    db "@"

String_1B_4C9B_00_26::
    db "<BUF0> went<LINE>"
    db "away quietly…<WAIT>"
    db "@"

String_1B_4C9B_00_27::
    db "RESULTS<LINE>"
    db "DISPLAY<LINE>"
    db "<LINE>"
    db "Species<LINE>"
    db "Gender@"

String_1B_4C9B_00_28::
    db "Unused.@"
    db "No save data.@"

; the last target of the bank-$1B message pointer table, laid out like its other entries: two
; control bytes, then text up to $F0 (E-0197, C1)
; record: $EA, $45 (window control bytes, as at the other entries of this pointer table); message
Text_1B_5190::
String_1B_4C9B_00_29::
    db $ea, $45 ; entry 0
    db " Accessories will<LINE>", "be in the Vault.<WAIT>", "@"

; no reader found; the 84 words match RejectedNameList in bank $14 in order, each ending in $F0 with
; no padding; an unreferenced routine follows at $5352 (E-0197, C1)
; record: 84 $F0-terminated words, the same as RejectedNameList (14:$70F0) without padding
RejectedNameListCopy_1B::
    db "Ass@" ; entry 0: word 0
    db "ASS@" ; word 1
    db "Dink@" ; word 2
    db "DINK@" ; word 3
    db "Dork@" ; word 4
    db "DORK@" ; word 5
    db "Cunt@" ; word 6
    db "CUNT@" ; word 7
    db "Kunt@" ; word 8
    db "KUNT@" ; word 9
    db "Fuck@" ; word 10
    db "FUCK@" ; word 11
    db "Shit@" ; word 12
    db "SHIT@" ; word 13
    db "Sex@" ; word 14
    db "SEX@" ; word 15
    db "Poop@" ; word 16
    db "POOP@" ; word 17
    db "Dong@" ; word 18
    db "DONG@" ; word 19
    db "Pene@" ; word 20
    db "PENE@" ; word 21
    db "Clit@" ; word 22
    db "CLIT@" ; word 23
    db "Twat@" ; word 24
    db "TWAT@" ; word 25
    db "Snot@" ; word 26
    db "SNOT@" ; word 27
    db "Fag@" ; word 28
    db "FAG@" ; word 29
    db "Homo@" ; word 30
    db "HOMO@" ; word 31
    db "Poon@" ; word 32
    db "POON@" ; word 33
    db "Piss@" ; word 34
    db "PISS@" ; word 35
    db "Prick@" ; word 36
    db "PRICK@" ; word 37
    db "Fukk@" ; word 38
    db "FUKK@" ; word 39
    db "Coon@" ; word 40
    db "COON@" ; word 41
    db "Nazi@" ; word 42
    db "NAZI@" ; word 43
    db "Niga@" ; word 44
    db "NIGA@" ; word 45
    db "Nigga@" ; word 46
    db "NIGGA@" ; word 47
    db "Jap@" ; word 48
    db "JAP@" ; word 49
    db "Jew@" ; word 50
    db "JEW@" ; word 51
    db "Wop@" ; word 52
    db "WOP@" ; word 53
    db "Spic@" ; word 54
    db "SPIC@" ; word 55
    db "Butt@" ; word 56
    db "BUTT@" ; word 57
    db "Perv@" ; word 58
    db "PERV@" ; word 59
    db "Dumb@" ; word 60
    db "DUMB@" ; word 61
    db "Dolt@" ; word 62
    db "DOLT@" ; word 63
    db "Anus@" ; word 64
    db "ANUS@" ; word 65
    db "Anal@" ; word 66
    db "ANAL@" ; word 67
    db "Jerk@" ; word 68
    db "JERK@" ; word 69
    db "Puke@" ; word 70
    db "PUKE@" ; word 71
    db "Snot@" ; word 72
    db "SNOT@" ; word 73
    db "Barf@" ; word 74
    db "BARF@" ; word 75
    db "Pus@" ; word 76
    db "PUS@" ; word 77
    db "Pussy@" ; word 78
    db "PUSSY@" ; word 79
    db "Bung@" ; word 80
    db "BUNG@" ; word 81
    db "Suck@" ; word 82
    db "SUCK@" ; word 83

; C1 static reading (E-0197): not reached from any traced code, pointer or far call found; the bytes
; after the word list at $51B6 decode as one routine: clear $6F bytes from wScreenState, decompress
; bank $46 $4001 to $8800, far-call F1:$4AA8, LoadPalette0FromData53C6, then wait on
; wTextWindowState and jp $077A
; clears $6F bytes from wScreenState, decompresses bank $46 $4001 to $8800, far-calls F1:$4AA8 and
; LoadPalette0FromData53C6, waits on wTextWindowState and jumps to $077A; no caller found (E-0197)
UnreferencedScreenInitFromBank46:: ; configured code entry (E-0197); C0
    ld hl, wScreenState
    ld bc, $006f

.loop:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld b, $46
    ld de, Tiles1Gfx_46_4001
    ld hl, vTiles1
    call DecompressToRAMLocked
    farcall ClearScreenBufferAndAttributes_BankF1
    call LoadPalette0FromData53C6
    xor a
    ldh [hScrollY], a
    ldh [hScrollX], a
    ld a, $fc
    call StartPaletteFade
    ld a, $01
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a

.loop2:
    farcall StepTextWindowOpenClose
    ld a, [wTextWindowState]
    and $03
    jr nz, .loop2
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, $02
    ldh [hSpriteWindowClipMode], a
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $01
    jp ClearSGBPacketBuffer_CheckLinkMode

; on CGB copies the 8-byte palette LoadPalette0FromData53C6_Data into wBGPaletteBuffer and sets
; wBGPaletteUploadRequest = $7F (E-0118)
LoadPalette0FromData53C6::
    ld a, [wIsCGB]
    or a
    ret z
    ld de, LoadPalette0FromData53C6_Data
    ld hl, wBGPaletteBuffer
    ld bc, $0008
    call CopyBytesDEToHL_Bank00
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ret

LoadPalette0FromData53C6_Data::
    db $4d, $5e, $ff, $7f, $f2, $66, $00, $00

; unless a fade is running, runs the routine for wScreenState (jump table) (E-0122)
RunScreenStateWhenNotFading_1B::
    ld a, [wFadeState]
    and a
    ret nz
    ld a, [wScreenState]
    jumptable
    dw LinkKeyTrade_Start
    dw LinkKeyTrade

; by wScreenStep: 'Starting key trade', 'Please wait.', 'Please choose the key to trade.'
LinkKeyTrade_Start::
    ld a, [wScreenStep]
    jumptable
    dw LinkKeyTrade_Start_CopyBytesDEToHL_Bank1B
    dw LinkKeyTrade_Start_ShowStartingKeyTrade
    dw LinkKeyTrade_Start_ShowPleaseWait
    dw LinkKeyTrade_Start_WaitTextFlags
    dw LinkKeyTrade_Start_ShowPleaseChooseTheKey

LinkKeyTrade_Start_CopyBytesDEToHL_Bank1B::
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank1B
    ld a, [wIsCGB]
    and a
    jr z, .skip
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank1B

.skip:
    ld de, Tiles1Plus4A0Tiles_1F_4AD0
    ld hl, vTiles2 + $700
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles_1F_4330
    ld hl, vTiles2 + $710
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

LinkKeyTrade_Start_ShowStartingKeyTrade::
    ld a, $01 ; 'Starting key trade…'
    call BeginString_Bank1B_Cat0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wLinkSendByte], a
    ld hl, wTitleScreenState
    inc [hl]
    ret

LinkKeyTrade_Start_ShowPleaseWait::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $07 ; 'Please wait.'
    call BeginString_Bank1B_Cat0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

LinkKeyTrade_Start_WaitTextFlags::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

LinkKeyTrade_Start_ShowPleaseChooseTheKey::
    ld a, [wLinkMessage]
    cp $01
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, $06 ; 'Please choose the key to trade.'
    call BeginString_Bank1B_Cat0
    xor a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; by wScreenStep: builds the key list, exchanges bytes and messages over the link (LinkSendByte,
; WaitLinkMessage) and saves (RunSaveGameSteps)
LinkKeyTrade::
    ld a, [wScreenStep]
    jumptable
    dw LinkKeyTrade_BuildKeyListIndexListEntries
    dw LinkKeyTrade_FillTilesFromRequest
    dw LinkKeyTrade_ClampKeyListPageCursor
    dw LinkKeyTrade_DrawKeyListPageNames
    dw LinkKeyTrade_BGMapAddressAtScroll_Bank1B
    dw LinkKeyTrade_WriteScreenStepAndLinkSendByteEtc
    dw LinkKeyTrade_WaitForPartner
    dw LinkKeyTrade_QueueSoundEffect
    dw LinkKeyTrade_WriteScreenStepAndLinkSendByteEtc_Case08
    dw LinkKeyTrade_ShowPleaseChooseTheKey
    dw LinkKeyTrade_EraseCEntriesOfWordTable_Bank1B
    dw LinkKeyTrade_KeyCannotBeTraded
    dw LinkKeyTrade_WaitTextFlags
    dw LinkKeyTrade_WriteScreenStepAndLinkSendByte
    dw LinkKeyTrade_KeyEntryAddressForListEntriesCell4
    dw LinkKeyTrade_WaitLinkMessage
    dw LinkKeyTrade_WriteScreenStepAndSelectedRecordEtc
    dw LinkKeyTrade_KeysSameName
    dw LinkKeyTrade_ShowIsItOKTo
    dw LinkKeyTrade_QueueSoundEffect_Case13
    dw LinkKeyTrade_WriteTextWindowTileLoAndTextWindowTileHiEtc
    dw LinkKeyTrade_QueueSoundEffect
    dw LinkKeyTrade_WriteScreenStepAndLinkSendByteEtc_Case16
    dw LinkKeyTrade_QueueSoundEffect_Case17
    dw LinkKeyTrade_ToBeginString_Bank1B_Cat0AndStep
    dw LinkKeyTrade_WaitTextFlags
    dw LinkKeyTrade_WriteScreenStepAndLinkSendByte
    dw LinkKeyTrade_ToBeginString_Bank1B_Cat0AndStep_Case1B
    dw LinkKeyTrade_DrawThreeTilesAtBGMap20FFromDE
    dw LinkKeyTrade_KeyEntryAddressForListEntriesCell4_Case1D
    dw LinkKeyTrade_RunScreenCounterStep_61A7
    dw LinkKeyTrade_WaitLinkMessage_Case1F
    dw LinkKeyTrade_WaitLinkMessage_Case20
    dw LinkKeyTrade_DrawThreeTilesAtBGMap20FFromDE_Case21
    dw LinkKeyTrade_ShowPleaseWait
    dw LinkKeyTrade_WaitTextFlags_Case23
    dw LinkKeyTrade_WaitLinkMessage_Case24

LinkKeyTrade_BuildKeyListIndexListEntries::
    ld a, [wTextFlags]
    and a
    ret nz
    ld de, TileRect_1B_6483
    ld hl, wWindowTileBuffer + $b4
    lb bc, $0f, $09
    call CopyRectTo20ByteRows
    farcall BuildKeyListIndexListEntries
    ld a, $0e
    ld [wStringIndex], a
    xor a
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
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_1B
    xor a
    ld [wListCursor], a
    ld [wListPageIndex], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

LinkKeyTrade_FillTilesFromRequest::
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

LinkKeyTrade_ClampKeyListPageCursor::
    ld de, TileRect_1B_650A
    ld hl, wWindowTileBuffer + $c9
    lb bc, $0d, $07
    call CopyRectTo20ByteRows
    ld a, $02
    ld [wArg5], a
    farcall ClampKeyListPageCursor
    ld a, [wListPages]
    cp $02
    jr c, .read_list_cursor
    ld de, $0189
    call DrawC5BEC6AtScrollOffsetDE_Bank1B
    ld hl, wWindowTileBuffer + $15d
    call StoreC5BEC6AtHLStride2_Bank1B
    ld de, $018a
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    farcall DrawPageOfPagesAtScrollOffset
    ld hl, wWindowTileBuffer + $15e
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    farcall DrawPageOfPagesAtArg1_Bank1E

.read_list_cursor:
    ld a, [wListCursor]
    ld b, $bb
    ld hl, LinkKeyTrade_ClampKeyListPageCursor_Data
    call StoreBAtWordTableEntry_Bank1B
    call BGMapAddressAtScroll_Bank1B
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_1B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

LinkKeyTrade_DrawKeyListPageNames::
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

LinkKeyTrade_BGMapAddressAtScroll_Bank1B::
    call BGMapAddressAtScroll_Bank1B
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_1B
    ld a, [wListCursor]
    ld b, $c3
    ld hl, LinkKeyTrade_ClampKeyListPageCursor_Data
    call StoreBAtWordTableEntry_Bank1B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

LinkKeyTrade_WriteScreenStepAndLinkSendByteEtc::
    ld a, [wLinkMessage]
    cp $fe
    jr nz, .check_joypad_pressed_repeat
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $fd
    ld [wLinkSendByte], a
    ret

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    bit 2, a
    jr nz, .call_return_stub_6333
    ld a, $05
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fb
    jr z, .read_screen_step
    cp $fc
    jr z, .read_screen_step
    cp $fe
    jr z, .check_screen_step
    cp $ff
    jr z, .check_screen_step2
    ret

.call_return_stub_6333:
    farcall ReturnStub_6333

.read_screen_step:
    ld a, [wScreenStep]
    sub $04
    ld [wScreenStep], a
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $fe
    ld [wLinkSendByte], a
    ret

.check_screen_step2:
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    ld a, [wListCursor]
    ld b, $bc
    ld hl, LinkKeyTrade_ClampKeyListPageCursor_Data
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
    ld a, $04 ; 'Is it OK to trade this'
    call BeginString_Bank1B_Cat0
    ret

; by its step: 'Please wait.' and the partner's link message
LinkKeyTrade_WaitForPartner::
    ld a, [wScreenSubStep]
    jumptable
    dw LinkKeyTrade_WaitForPartner_BeginString_Bank1B_Cat0
    dw LinkKeyTrade_WaitForPartner_ShowPleaseWait
    dw LinkKeyTrade_WaitForPartner_WaitTextFlags
    dw LinkKeyTrade_WaitForPartner_WaitLinkMessage
    dw LinkKeyTrade_WaitForPartner_WaitTextFlags_Case04

LinkKeyTrade_WaitForPartner_BeginString_Bank1B_Cat0::
    ld a, [wLinkMessage]
    cp $fd
    jr z, .clear_link_send_byte
    cp $fe
    ret nz
    ld a, [wLinkSendByte]
    cp $fd
    jr z, .skip
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .skip
    jr .clear_link_send_byte

.skip:
    ld b, $03
    jr .clear_link_send_byte2

.clear_link_send_byte:
    ld b, $02

.clear_link_send_byte2:
    xor a
    ld [wLinkSendByte], a
    ld a, b
    call BeginString_Bank1B_Cat0
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

LinkKeyTrade_WaitForPartner_ShowPleaseWait::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $07 ; 'Please wait.'
    call BeginString_Bank1B_Cat0
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

LinkKeyTrade_WaitForPartner_WaitTextFlags::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

LinkKeyTrade_WaitForPartner_WaitLinkMessage::
    ld a, [wLinkMessage]
    cp $01
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

LinkKeyTrade_WaitForPartner_WaitTextFlags_Case04::
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld hl, wScreenState
    ld bc, $006f

.loop:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld a, $05
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    ld a, $01
    ld [wModeChangeRequest], a
    ret

LinkKeyTrade_QueueSoundEffect::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $6c
    call QueueSoundEffect
    ld de, TileRect_1B_65E9
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_1B
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

LinkKeyTrade_WriteScreenStepAndLinkSendByteEtc_Case08::
    ld a, [wLinkMessage]
    cp $fe
    jr nz, .call_update_two_choice_cursor_bank1_d
    ld a, $06
    ld [wScreenStep], a
    ld a, $fd
    ld [wLinkSendByte], a
    ret

.call_update_two_choice_cursor_bank1_d:
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fe
    jr z, .loop
    cp $ff
    jr z, .check_two_choice_cursor
    ret

.loop:
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

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp $01
    jr z, .loop
    ld a, [wScreenStep]
    add $03
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

LinkKeyTrade_ShowPleaseChooseTheKey::
    call LinkKeyTrade_CopyRectTo20ByteRows
    ld a, $06 ; 'Please choose the key to trade.'
    call BeginString_Bank1B_Cat0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

LinkKeyTrade_EraseCEntriesOfWordTable_Bank1B::
    ld a, [wTextFlags]
    and a
    ret nz
    ld c, $04
    ld hl, LinkKeyTrade_ClampKeyListPageCursor_Data
    call EraseCEntriesOfWordTable_Bank1B
    ld a, $05
    ld [wScreenStep], a
    ret

; by its step: 'That key cannot be traded.' and 'Please wait.'
LinkKeyTrade_KeyCannotBeTraded::
    ld a, [wScreenSubStep]
    jumptable
    dw LinkKeyTrade_KeyCannotBeTraded_KeyEntryAddressForListEntriesCell4
    dw LinkKeyTrade_KeyCannotBeTraded_WaitTextFlags

LinkKeyTrade_KeyCannotBeTraded_WaitTextFlags::
    ld a, [wTextFlags]
    and a
    ret nz
    xor a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    sub $02
    ld [wScreenStep], a
    ret

LinkKeyTrade_KeyCannotBeTraded_KeyEntryAddressForListEntriesCell4::
    call KeyEntryAddressForListEntriesCell4
    push hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr z, .check_map_type
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    and $0f
    cp $07
    jr nc, .check_map_id
    pop hl

.call_begin_string_bank1_b_cat0:
    ld a, $05 ; 'That key cannot be traded.'
    call BeginString_Bank1B_Cat0
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.check_map_id:
    pop hl
    ldh a, [hMapId]
    cp $a8
    jr c, .loop
    jr .skip

.check_map_type:
    pop hl
    ld a, [wMapType]
    bit 7, a
    jr z, .loop
    ld a, [wKeyWorldSlot]
    ld b, a
    ld a, [hl]
    and $3f
    cp b
    jr nz, .loop
    jr .call_begin_string_bank1_b_cat0

.loop:
    ld a, $07 ; 'Please wait.'
    call BeginString_Bank1B_Cat0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.skip:
    ld b, $a8
    ld c, $b0
    cp c
    jr nc, .skip2
    cp b
    ccf

.skip2:
    jr c, .skip8
    ld b, $b0
    ld c, $b7
    cp c
    jr nc, .skip3
    cp b
    ccf

.skip3:
    jr c, .skip9
    ld b, $b8
    ld c, $c6
    cp c
    jr nc, .skip4
    cp b
    ccf

.skip4:
    jr c, .skip10
    ld b, $c8
    ld c, $d1
    cp c
    jr nc, .skip5
    cp b
    ccf

.skip5:
    jr c, .skip11
    ld b, $d1
    ld c, $da
    cp c
    jr nc, .skip6
    cp b
    ccf

.skip6:
    jr c, .skip12
    ld b, $da
    ld c, $e3
    cp c
    jr nc, .skip7
    cp b
    ccf

.skip7:
    jr c, .skip13
    jp .loop

.skip8:
    ld a, [hl]
    cp $07
    jr nz, .loop
    jp .call_begin_string_bank1_b_cat0

.skip9:
    ld a, [hl]
    cp $08
    jr nz, .loop
    jp .call_begin_string_bank1_b_cat0

.skip10:
    ld a, [hl]
    cp $09
    jr nz, .loop
    jp .call_begin_string_bank1_b_cat0

.skip11:
    ld a, [hl]
    cp $0a
    jr nz, .loop
    jp .call_begin_string_bank1_b_cat0

.skip12:
    ld a, [hl]
    cp $0b
    jr nz, .loop
    jp .call_begin_string_bank1_b_cat0

.skip13:
    ld a, [hl]
    cp $0c
    jr nz, .loop
    jp .call_begin_string_bank1_b_cat0

LinkKeyTrade_WaitTextFlags::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

LinkKeyTrade_DrawThreeTilesAtBGMap20FFromDE::
    ld a, [wTextFlags]
    and a
    ret nz
    ld de, LinkKeyTrade_DrawThreeTilesAtBGMap20FFromDE_Data
    call DrawThreeTilesAtBGMap20FFromDE
    ld a, $02
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

LinkKeyTrade_WriteScreenStepAndLinkSendByte::
    ld a, [wLinkMessage]
    cp $01
    jr z, .clear_link_send_byte
    cp $fe
    ret nz
    ld a, $06
    ld [wScreenStep], a
    ld a, $fd
    ld [wLinkSendByte], a
    ret

.clear_link_send_byte:
    xor a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

LinkKeyTrade_KeyEntryAddressForListEntriesCell4::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    call KeyEntryAddressForListEntriesCell4
    ld de, wLinkRecvBuffer
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    push de
    call WordAddressForListEntriesCell4Item
    pop de
    ld a, [hli]
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
    ld a, $ff
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

LinkKeyTrade_WaitTextFlags_Case23::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $05
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

LinkKeyTrade_WaitLinkMessage::
    ld a, [wLinkMessage]
    cp $f0
    ret nz
    xor a
    ld [wLinkSendByte], a
    xor a
    ld [wLinkReady], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

LinkKeyTrade_WriteScreenStepAndSelectedRecordEtc::
    call LinkKeyTrade_Case10_ReadRandomSeed2LoAndLinkPartnerNameEtc
    cp $ff
    jr z, .check_screen_step2
    call LinkKeyTrade_Case10_ReadRandomSeed2Lo
    ld a, c
    cp $14
    jr z, .check_screen_step
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wSelectedRecord], a
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ld a, $fe
    ld [wSelectedRecord], a
    ret

.check_screen_step2:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ld a, $ff
    ld [wSelectedRecord], a
    ret

LinkKeyTrade_Case10_ReadRandomSeed2LoAndLinkPartnerNameEtc::
    ld hl, wKeyList
    ld de, wLinkPartnerName
    ld b, $20

.loop:
    push hl
    ld a, [hl]
    cp $ff
    jr z, .restore
    cp $fe
    jr z, .restore
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr z, .check_random_seed2_lo
    pop hl
    push hl
    ld a, [wRandomSeed2Lo]
    bit 7, a
    jr z, .restore
    ld a, [hl]
    and $0f
    ld c, a
    ld a, [wLinkPartnerName]
    and $0f
    cp c
    jr nz, .restore
    jr .done

.check_random_seed2_lo:
    pop hl
    push hl
    ld a, [wRandomSeed2Lo]
    bit 7, a
    jr nz, .restore
    inc hl
    ld a, [hli]
    ld c, a
    ld a, [wLinkPartnerByte1]
    cp c
    jr nz, .restore
    ld a, [hli]
    ld c, a
    ld a, [wLinkPartnerByte2]
    cp c
    jr nz, .restore

.restore:
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    dec b
    jr nz, .loop
    xor a
    ret

.done:
    pop hl
    ld a, $ff
    ret

LinkKeyTrade_Case10_ReadRandomSeed2Lo::
    ld hl, wKeyList
    ld b, $20
    ld c, $00

.loop:
    ld a, [hl]
    cp $ff
    jr z, .next2
    cp $fe
    jr z, .next
    inc hl
    inc hl
    inc hl
    ld a, [hld]
    dec hl
    dec hl
    bit 7, a
    jr nz, .next2

.next:
    inc c

.next2:
    inc hl
    inc hl
    inc hl
    inc hl
    dec b
    jr nz, .loop
    ld a, c
    cp $14
    ret c
    call KeyEntryAddressForListEntriesCell4
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr nz, .check_random_seed2_lo
    ld a, [wRandomSeed2Lo]
    bit 7, a
    jr nz, .loop2

.loop2:
    dec c
    ret

.check_random_seed2_lo:
    ld a, [wRandomSeed2Lo]
    bit 7, a
    jr nz, .loop2
    ret

; by wScreenSubStep: "Keys can't have the same name.", then back to 'Please choose the key to
; trade.'
LinkKeyTrade_KeysSameName::
    ld a, [wScreenSubStep]
    jumptable
    dw LinkKeyTrade_KeysSameName_WriteLinkSendByteAndScreenSubStep
    dw LinkKeyTrade_KeysSameName_WriteItemGridXAndLinkSendByteEtc
    dw LinkKeyTrade_KeysSameName_WriteScreenSubStepAndScreenStep
    dw LinkKeyTrade_KeysSameName_WaitTextFlags
    dw LinkKeyTrade_KeysSameName_ShowPleaseChooseTheKey

LinkKeyTrade_KeysSameName_WriteLinkSendByteAndScreenSubStep::
    ld a, [wSelectedRecord]
    and a
    jr z, .set_link_send_byte_to_02
    cp $ff
    jr z, .skip
    ld a, $04
    jr .set_link_send_byte

.skip:
    ld a, $03
    jr .set_link_send_byte

.set_link_send_byte_to_02:
    ld a, $02

.set_link_send_byte:
    ld [wLinkSendByte], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

LinkKeyTrade_KeysSameName_WriteItemGridXAndLinkSendByteEtc::
    ld a, [wLinkMessage]
    cp $02
    jr z, .set_item_grid_x
    cp $03
    jr z, .set_item_grid_x
    cp $04
    jr z, .set_item_grid_x
    ret

.set_item_grid_x:
    ld [wItemGridX], a
    xor a
    ld [wLinkSendByte], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

LinkKeyTrade_KeysSameName_WriteScreenSubStepAndScreenStep::
    ld a, [wItemGridX]
    cp $03
    jr z, .check_selected_record2
    cp $04
    jr z, .check_selected_record
    ld a, [wSelectedRecord]
    and a
    jr nz, .cp_FF
    xor a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.cp_FF:
    cp $ff
    jr z, .skip
    ld a, $0f
    jr .call_begin_string_bank1_b_cat02

.skip:
    ld a, $08
    jr .call_begin_string_bank1_b_cat02

.check_selected_record:
    ld a, [wSelectedRecord]
    cp $fe
    jr z, .skip2
    ld a, $26
    jr .call_begin_string_bank1_b_cat02

.skip2:
    ld a, $0f
    jr .call_begin_string_bank1_b_cat02

.check_selected_record2:
    ld a, [wSelectedRecord]
    cp $ff
    jr z, .call_begin_string_bank1_b_cat0
    ld a, $0d
    jr .call_begin_string_bank1_b_cat02

.call_begin_string_bank1_b_cat0:
    ld a, $08 ; 'Keys can't have the same name.'

.call_begin_string_bank1_b_cat02:
    call BeginString_Bank1B_Cat0
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

LinkKeyTrade_KeysSameName_WaitTextFlags::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

LinkKeyTrade_KeysSameName_ShowPleaseChooseTheKey::
    call LinkKeyTrade_CopyRectTo20ByteRows
    ld a, $06 ; 'Please choose the key to trade.'
    call BeginString_Bank1B_Cat0
    xor a
    ld [wScreenSubStep], a
    ld a, $0a
    ld [wScreenStep], a
    ret

LinkKeyTrade_ShowIsItOKTo::
    call LinkKeyTrade_Case12_WriteArg5AndTextWindowTileLoEtc
    ld de, TileRect_1B_6483
    ld hl, wWindowTileBuffer + $64
    lb bc, $0f, $01
    call CopyRectTo20ByteRows
    ld de, TileRect_1B_65CE
    ld hl, wWindowTileBuffer + $78
    lb bc, $0f, $01
    call CopyRectTo20ByteRows
    ld de, LinkKeyTrade_ShowIsItOKTo_Data
    ld hl, wWindowTileBuffer + $8c
    lb bc, $0f, $01
    call CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_1B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $09 ; 'Is it OK to trade keys?'
    call BeginString_Bank1B_Cat0
    ret

LinkKeyTrade_QueueSoundEffect_Case13::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $6c
    call QueueSoundEffect
    ld de, TileRect_1B_65A6
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_1B
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

LinkKeyTrade_WriteTextWindowTileLoAndTextWindowTileHiEtc::
    ld a, [wLinkMessage]
    cp $fe
    jr nz, .call_update_two_choice_cursor_bank1_b
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
    ld a, $fd
    ld [wLinkSendByte], a
    ret

.call_update_two_choice_cursor_bank1_b:
    call UpdateTwoChoiceCursor_Bank1B
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fe
    jr z, .loop
    cp $ff
    jr z, .check_two_choice_cursor
    ret

.loop:
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
    ld a, $fe
    ld [wLinkSendByte], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp $01
    jr z, .loop
    ld a, [wTwoChoiceCursor]
    ld b, $bc
    ld hl, LinkKeyTrade_WriteTextWindowTileLoAndTextWindowTileHiEtc_Data
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
    ld a, $0a ; 'Is it OK to record the'
    call BeginString_Bank1B_Cat0
    ret

; when no text runs, copies box TileRect_1B_65E9 to wWindowTileBuffer + $112, draws it, clears
; wTwoChoiceCursor and wScreenStep += 1 (E-0124)
ShowTwoChoiceBox65E9WhenTextIdle::
    ld a, [wTextFlags]
    and a
    ret nz
    ld de, TileRect_1B_65E9
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_1B
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

LinkKeyTrade_WriteScreenStepAndLinkSendByteEtc_Case16::
    ld a, [wLinkMessage]
    cp $fe
    jr nz, .call_update_two_choice_cursor_bank1_d
    ld a, $06
    ld [wScreenStep], a
    ld a, $fd
    ld [wLinkSendByte], a
    ret

.call_update_two_choice_cursor_bank1_d:
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fe
    jr z, .loop
    cp $ff
    jr z, .check_two_choice_cursor
    ret

.loop:
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
    ld a, $09 ; 'Is it OK to trade keys?'
    call BeginString_Bank1B_Cat0
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    cp $01
    jr z, .loop
    ld a, [wScreenStep]
    add $02
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

LinkKeyTrade_QueueSoundEffect_Case17::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $6c
    call QueueSoundEffect
    ld de, TileRect_1B_65A6
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_1B
    ld a, [wScreenStep]
    sub $03
    ld [wScreenStep], a
    ret

LinkKeyTrade_ToBeginString_Bank1B_Cat0AndStep::
    ld a, $07 ; 'Please wait.'
    call BeginString_Bank1B_Cat0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

LinkKeyTrade_ToBeginString_Bank1B_Cat0AndStep_Case1B::
    ld a, $0b ; 'Readying trade… Please wait.'
    call BeginString_Bank1B_Cat0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

LinkKeyTrade_KeyEntryAddressForListEntriesCell4_Case1D::
    ld a, [wLinkMessage]
    cp $02
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScreenCounter], a
    ld [wGlyphListStart], a
    call KeyEntryAddressForListEntriesCell4
    ld a, [hl]
    cp $fe
    jr z, .skip
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr nz, .skip
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    bit 7, a
    jr z, .skip
    and $3f
    ld bc, $0195
    call Multiply8By16
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $a0
    ld h, a
    ld de, wArenaEntry
    ld bc, $0195
    ld a, $0a
    ld [rRAMG2], a
    ld a, $02
    ld [rRAMB], a
    call CopyBytes
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    jr .set_link_timeout_lo

.skip:
    ld hl, wArenaEntry
    ld bc, $0195
    xor a
    call FillBytes

.set_link_timeout_lo:
    ld hl, wArenaEntry
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

LinkKeyTrade_RunScreenCounterStep_61A7::
    ld a, [wLinkMessage]
    cp $01
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    call RunScreenCounterStep_61A7
    ld hl, $0195
    ld a, $1e
    call DivideHLByA
    ld [wWorkBuf + $2], a
    ld a, l
    ld [wWorkBuf], a
    ld a, h
    ld [wWorkBuf + $1], a
    ld hl, $001e
    ld a, l
    ld [wLinkBufferCountLo], a
    ld a, h
    ld [wLinkBufferCountHi], a
    ld hl, wLinkExchangeBuffer
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $ff
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

LinkKeyTrade_WaitLinkMessage_Case1F::
    ld a, [wLinkMessage]
    cp $f0
    ret nz
    ld a, $00
    ld [wLinkReady], a
    ld a, $01
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

LinkKeyTrade_WaitLinkMessage_Case20::
    ld a, [wLinkMessage]
    cp $01
    ret nz
    ld a, [wWorkBuf]
    ld l, a
    ld a, [wWorkBuf + $1]
    ld h, a
    ld a, h
    or l
    jr z, .check_work_buf
    dec hl
    ld a, l
    ld [wWorkBuf], a
    ld a, h
    ld [wWorkBuf + $1], a
    ld hl, $001e
    jr .set_link_buffer_count_lo

.check_work_buf:
    ld a, [wWorkBuf + $2]
    or a
    jr z, .clear_link_send_byte
    ld l, a
    ld h, $00
    xor a
    ld [wWorkBuf + $2], a

.set_link_buffer_count_lo:
    ld a, l
    ld [wLinkBufferCountLo], a
    ld a, h
    ld [wLinkBufferCountHi], a
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    call RunScreenCounterStep_61A7
    ld a, $ff
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

.clear_link_send_byte:
    xor a
    ld [wLinkSendByte], a
    xor a
    ld [wLinkReady], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

LinkKeyTrade_DrawThreeTilesAtBGMap20FFromDE_Case21::
    ld de, LinkKeyTrade_DrawThreeTilesAtBGMap20FFromDE_Case21_Data
    call DrawThreeTilesAtBGMap20FFromDE
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    call KeyEntryAddressForListEntriesCell4
    ld a, [hl]
    cp $fe
    jr z, .loop
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr nz, .skip
    jr .next

.loop:
    ld a, $ff
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    jr .skip2

.skip:
    ld a, $ff
    ld [hld], a
    ld [hld], a
    ld [hld], a
    ld [hld], a
    jr .skip2

.next:
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    bit 7, a
    jr z, .loop
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ldh [hTemp0], a
    farcall DeleteKeyEntryTemp0

.skip2:
    ld hl, wKeyList
    ld c, $00

.loop2:
    ld a, [hl]
    cp $ff
    jr z, .check_random_seed2_lo
    ld a, $04
    add_a_to_hl
    inc c
    ld a, c
    cp $20
    jr c, .loop2
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    ret

.check_random_seed2_lo:
    push bc
    ld a, [wRandomSeed2Lo]
    bit 7, a
    jr z, .skip3
    ld a, [wLinkPartnerName]
    and $0f
    sub $07
    ld de, $0203
    add e
    ld e, a
    jr nc, .call_test_flag_bit
    inc d

.call_test_flag_bit:
    push hl
    push bc
    call TestFlagBit
    jr c, .read_link_partner_name
    ld a, [wLinkPartnerName]
    and $0f
    jr .set_link_partner_name

.read_link_partner_name:
    ld a, [wLinkPartnerName]
    set 6, a
    and $4f

.set_link_partner_name:
    pop bc
    pop hl
    ld [wLinkPartnerName], a

.skip3:
    ld de, wLinkPartnerName
    ld b, $04

.loop3:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop3
    pop bc
    push bc
    ld l, c
    ld h, $00
    sla l
    rl h
    ld de, wKeySeeds
    add hl, de
    ld a, [wRandomSeed2Hi]
    ld [hli], a
    ld a, [wBattleSetupByteBC]
    ld [hl], a
    pop bc
    ld a, [wLinkPartnerName]
    cp $fe
    jr z, .call_begin_string_bank1_b_cat0
    ld a, [wRandomSeed2Lo]
    bit 7, a
    jr nz, .call_begin_string_bank1_b_cat0
    ld a, [wLinkPartnerName]
    bit 7, a
    jr z, .call_begin_string_bank1_b_cat0
    push bc
    call ClearWD201Bit7AndFourSlots
    farcall FindSRAMSlotMarkerIndex
    ldh a, [hTemp0]
    and $7f
    ld c, a
    ld a, [wLinkExchangeBuffer]
    and $50
    or c
    ld [wLinkExchangeBuffer], a
    ld a, $0a
    ld [rRAMG2], a
    ld a, $02
    ld [rRAMB], a
    xor a
    ldh [rSVBK], a
    ldh a, [hTemp0]
    and $7f
    ld bc, $0195
    call Multiply8By16
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $a0
    ld h, a
    ld e, l
    ld d, h
    ld hl, wLinkExchangeBuffer
    ld bc, $0195
    call CopyBytes
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    pop bc
    ld a, c
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add $07
    ld l, a
    ld a, h
    adc $c7
    ld h, a
    ld a, [hl]
    and $80
    ld b, a
    ldh a, [hTemp0]
    or b
    ld [hl], a

.call_begin_string_bank1_b_cat0:
    ld a, $0c ; 'Keys will now be traded.'
    call BeginString_Bank1B_Cat0
    ld a, $80
    ld [wGameFlags836], a
    ret

LinkKeyTrade_ShowPleaseWait::
    ld a, [wTextFlags]
    and a
    ret nz
    farcall RunSaveGameSteps
    ld a, [wSaveStep]
    bit 7, a
    ret z
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScreenCounter], a
    ld a, $07 ; 'Please wait.'
    call BeginString_Bank1B_Cat0
    ret

LinkKeyTrade_WaitLinkMessage_Case24::
    ld a, [wLinkMessage]
    cp $05
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld hl, wScreenState
    ld bc, $006f

.loop:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    xor a
    ldh [hDecompressLock], a
    ld a, $05
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    ld a, $01
    ld [wModeChangeRequest], a
    ret

; clears bit 7 of wLinkExchangeBuffer + $1 and the bytes at wLinkExchangeBuffer + $1 + $177 + 4 * n
; for n = 0-3 (E-0122)
ClearWD201Bit7AndFourSlots::
    ld a, [wLinkExchangeBuffer + $1]
    res 7, a
    ld [wLinkExchangeBuffer + $1], a
    ld bc, $0177
    ld hl, wLinkExchangeBuffer + $1
    add hl, bc
    ld b, $04

.loop:
    xor a
    ld [hl], a
    ld a, $04
    add_a_to_hl
    dec b
    jr nz, .loop
    ret

LinkKeyTrade_Case12_WriteArg5AndTextWindowTileLoEtc::
    ld a, [wLinkPartnerName]
    cp $fe
    jr nz, .check_random_seed2_lo
    ld hl, wNameGlyphBuf
    ld a, $16
    ld [hli], a
    ld a, $24
    ld [hli], a
    ld a, $2a
    ld [hli], a
    ld a, $2c
    ld [hli], a
    ld a, $26
    ld [hli], a
    ld a, $90
    ld [hli], a
    ld a, $14
    ld [hli], a
    ld a, $28
    ld [hli], a
    ld a, $3c
    ld [hli], a
    ld a, $5b
    ld [hli], a
    ld a, $f0
    ld [hl], a
    ld a, $03
    ld [wArg5], a
    jr LinkKeyTrade_Case12_WriteArg5AndTextWindowTileLoEtc_Skip2

.check_random_seed2_lo:
    ld a, [wRandomSeed2Lo]
    bit 7, a
    jp nz, CopyDataBankString4078ToTextBuf0_CheckLinkPartnerName
    ld a, $09
    ld [wDataBank], a
    ld a, [wLinkPartnerByte1]
    inc a
    call CopyDataBankString4078ToTextBuf0
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0

.skip:
    ld a, [de]
    cp $f0
    jr z, .set_data_bank_to_09
    ld [hli], a
    inc de
    jr .skip

.set_data_bank_to_09:
    push hl
    ld a, $09
    ld [wDataBank], a
    ld a, [wLinkPartnerByte2]
    inc a
    add $10
    call CopyDataBankString4078ToTextBuf0
    pop hl
    ld de, wTextBuf0

.skip2:
    ld a, [de]
    cp $f0
    jr z, LinkKeyTrade_Case12_WriteArg5AndTextWindowTileLoEtc_Skip
    ld [hli], a
    inc de
    jr .skip2

LinkKeyTrade_Case12_WriteArg5AndTextWindowTileLoEtc_Skip::
    ld a, $5b
    ld [hli], a
    ld a, $f0
    ld [hl], a
    ld a, $03
    ld [wArg5], a

LinkKeyTrade_Case12_WriteArg5AndTextWindowTileLoEtc_Skip2::
    ld hl, wTextBuf0
    ld de, wNameGlyphBuf

.skip:
    ld a, [de]
    cp $f0
    jr z, .skip2
    ld [hli], a
    inc de
    jr .skip

.skip2:
    ld [hl], a
    ld hl, vTiles2 + $600
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0b01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $27
    ld [wStringIndex], a ; '0'
    xor a
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

; copies the 16-byte string named by the word table $4078 + 2 * A (in bank 9) to wTextBuf0; the next
; entry copies a key name word to wNameGlyphBuf (E-0127)
CopyDataBankString4078ToTextBuf0::
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

CopyDataBankString4078ToTextBuf0_CheckLinkPartnerName::
    ld a, [wLinkPartnerName]
    and $3f
    ld l, a
    ld h, $00
    push hl
    ld a, [wDataBank]
    push af
    ld a, $09
    ld [wDataBank], a
    ld hl, StringCategories_09_4016
    ld a, $0c
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
    ld a, $f0
    ld [wNameGlyphBuf + $d], a
    ld hl, wNameGlyphBuf

.skip:
    ld a, [hli]
    cp $f0
    jr z, .skip2
    jr .skip

.skip2:
    jp LinkKeyTrade_Case12_WriteArg5AndTextWindowTileLoEtc_Skip
    db $21, $a1, $5d, $06, $1d, $d7, $fa, $f5, $d7, $67, $fa, $f6, $d7, $6f, $7e, $6f
    db $26, $00, $29, $29, $7d, $c6, $07, $6f, $7c, $ce, $c7, $67, $7e, $e6, $7f, $01
    db $95, $01, $cd, $aa, $16, $7d, $c6, $00, $6f, $7c, $ce, $a0, $67, $c9

; far-calls SetArg5ToListEntriesCell4, reads the key slot stored there and returns HL = wKeyList + 4
; * slot (= $C707 + 4 * slot) (E-0120)
KeyEntryAddressForListEntriesCell4::
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
    add $07
    ld l, a
    ld a, h
    adc $c7
    ld h, a
    ret

; far-calls SetArg5ToListEntriesCell4, reads the byte at that address and returns HL = $C787 + 2 *
; that byte (E-0119)
WordAddressForListEntriesCell4Item::
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
    add $87
    ld l, a
    ld a, h
    adc $c7
    ld h, a
    ret

; writes the three bytes at DE to vBGMap0 + $20F onward (WaitForVRAMAccess, interrupts off per byte)
; (E-0120)
DrawThreeTilesAtBGMap20FFromDE::
    ld hl, vBGMap0 + $20f
    di
    call WaitForVRAMAccess
    ld a, [de]
    ld [hli], a
    ei
    inc de
    di
    call WaitForVRAMAccess
    ld a, [de]
    ld [hli], a
    ei
    inc de
    di
    call WaitForVRAMAccess
    ld a, [de]
    ld [hl], a
    ei
    ret

; runs the routine for wScreenCounter (jump table of six; steps 2 and 4 reuse 0, 3 reuses 1)
; (E-0122)
RunScreenCounterStep_61A7::
    ld a, [wScreenCounter]
    jumptable
    dw RunScreenCounterStep_61A7_WriteScreenCounter
    dw WriteTileBAtBGMap20FPlusGlyphListStartWithBBC
    dw RunScreenCounterStep_61A7_WriteScreenCounter
    dw WriteTileBAtBGMap20FPlusGlyphListStartWithBBC
    dw RunScreenCounterStep_61A7_WriteScreenCounter
    dw RunScreenCounterStep_61A7_WriteTileBAtBGMap20FPlusGlyphListStart

RunScreenCounterStep_61A7_WriteScreenCounter::
    ld b, $c3
    jr WriteTileBAtBGMap20FPlusGlyphListStart

WriteTileBAtBGMap20FPlusGlyphListStartWithBBC::
    ld b, $bc

; writes B at vBGMap0 + $20F + wGlyphListStart (WaitForVRAMAccess, interrupts off), then
; wScreenCounter += 1 (E-0118)
WriteTileBAtBGMap20FPlusGlyphListStart::
    ld hl, vBGMap0 + $20f
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

RunScreenCounterStep_61A7_WriteTileBAtBGMap20FPlusGlyphListStart::
    ld b, $bb
    call WriteTileBAtBGMap20FPlusGlyphListStart
    xor a
    ld [wScreenCounter], a
    ld a, [wGlyphListStart]
    inc a
    ld [wGlyphListStart], a
    cp $03
    ret c
    xor a
    ld [wGlyphListStart], a
    ld de, LinkKeyTrade_DrawThreeTilesAtBGMap20FFromDE_Data
    call DrawThreeTilesAtBGMap20FFromDE
    ret

; A = string index: wStringIndex = A, wStringCategory = 0, then BeginStringDisplay_Bank1B_480C
BeginString_Bank1B_Cat0::
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank1B_480C
    ret

LinkKeyTrade_CopyRectTo20ByteRows::
    ld b, $00
    ld c, $05
    ld hl, $027a
    ld de, $00ae
    xor a
    ld [wArg1], a
    ld a, $06
    ld [wArg2], a
    call LinkKeyTrade_Shared01_CopyBytesDEToHL_Bank1B
    ld de, TileRect_1B_6565
    ld hl, wWindowTileBuffer + $112
    lb bc, $01, $05
    call CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_1B
    ret

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it
; then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0
CopyRectTo20ByteRows::
    push hl
    push bc

.loop:
    push hl
    push bc

.loop2:
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop2
    pop bc
    pop hl
    ld a, l
    add $14
    ld l, a
    ld a, h
    adc $00
    ld h, a
    dec c
    jp nz, .loop
    pop bc
    pop hl
    ld a, [wIsCGB]
    or a
    ret z
    ld a, l
    add $68
    ld l, a
    ld a, h
    adc $0e
    ld h, a
    ld a, $02
    ldh [rSVBK], a

.loop3:
    push hl
    push bc

.loop4:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop4
    pop bc
    pop hl
    ld a, l
    add $14
    ld l, a
    ld a, h
    adc $00
    ld h, a
    dec c
    jp nz, .loop3
    ld a, $00
    ldh [rSVBK], a
    ret

; copies a rectangle of the screen buffer (offset DE) to the BG map at HL, sets wTextCursorLo = HL +
; $1C1, and on CGB copies its attributes (E-0127)
DrawScreenBufferRectToBGMap_1B::
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
    add $c1
    ld l, a
    ld a, h
    adc $01
    ld h, a
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    pop hl
    pop bc
    pop de
    ld a, [wIsCGB]
    or a
    ret z
    push de
    call WaitForVRAMAccess
    push bc
    ld c, $4f
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
    ld c, $4f
    ld a, $00
    ldh [c], a
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX,
; hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
BGMapAddressAtScroll_Bank1B::
    ld hl, vBGMap0
    ldh a, [hScrollY]
    and $f8
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

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end
; past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
CopyBytesDEToHL_Bank1B::
    ld a, [de]
    inc de
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, CopyBytesDEToHL_Bank1B
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same
; 19 bytes appear in 5 banks)
CopyLow3BitsToWRAMBank2_Bank1B::
    ld a, $02
    ldh [rSVBK], a

.loop:
    ld a, [de]
    and $07
    inc de
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld a, $00
    ldh [rSVBK], a
    ret

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers
; A, DE, HL (the same 16 bytes appear in 4 banks)
StoreBAtWordTableEntry_Bank1B::
    push bc
    sla a
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    pop bc
    ld a, b
    ld [de], a
    ret

; stores tile $C3 at the addresses of entries 0 to C - 1 of the word table at HL (E-0122)
EraseCEntriesOfWordTable_Bank1B::
    ld a, c
    ld b, a
    ld c, $00

.loop:
    ld a, c
    push bc
    ld b, $c3
    push hl
    call StoreBAtWordTableEntry_Bank1B
    pop hl
    pop bc
    inc c
    ld a, c
    cp b
    jr c, .loop
    ret

; draws tiles $C5, $BE, $C6 at BGMapAddressAtScroll + DE, two entries apart (WaitForVRAMAccess,
; interrupts off) (E-0120)
DrawC5BEC6AtScrollOffsetDE_Bank1B::
    push de
    call BGMapAddressAtScroll_Bank1B
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, $c5
    ld [hl], a
    ei
    inc hl
    inc hl
    di
    call WaitForVRAMAccess
    ld a, $be
    ld [hl], a
    ei
    inc hl
    inc hl
    di
    call WaitForVRAMAccess
    ld a, $c6
    ld [hl], a
    ei
    ret

; [HL] = $C5, [HL+2] = $BE, [HL+4] = $C6; HL ends at HL+4; clobbers A (the same 14 bytes appear in 8
; banks)
StoreC5BEC6AtHLStride2_Bank1B::
    ld a, $c5
    ld [hl], a
    inc hl
    inc hl
    ld a, $be
    ld [hl], a
    inc hl
    inc hl
    ld a, $c6
    ld [hl], a
    ret

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for
; rSTAT bit 1 to clear; clobbers A; HL and DE advance (the same 20 bytes appear in 3 banks)
CopyTileBytesToVRAM_Bank1B::
    xor a

.loop:
    push af
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [hli]
    ld [de], a
    inc de
    ei
    pop af
    inc a
    cp $10
    jr c, .loop
    ret

LinkKeyTrade_Shared01_CopyBytesDEToHL_Bank1B::
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
    and a
    jr z, .restore
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

.restore:
    pop bc
    ld a, $14
    add_a_to_hl
    ld a, $14
    add e
    ld e, a
    jr nc, .next
    inc d

.next:
    inc b
    ld a, b
    cp c
    jr c, LinkKeyTrade_Shared01_CopyBytesDEToHL_Bank1B
    ret

; the same instructions as UpdateTwoChoiceCursor_Bank1D, calling this bank's own helpers:
; wTwoChoiceCursor (0 or 1): Up and Down each toggle it, erase the old cursor (tile $C3), draw the
; new one (tile $BB), play sound $69 and set wMenuInputResult = $FD; A draws the confirmed cursor
; (tile $BC), plays sound $69 and sets $FF; B sets $FE; with no input the cursor blinks
; (wScreenCounter counts frames once wJoypadRepeatTimer reaches $14) and the result is 0. Its cursor
; positions come from this bank's own table and were not compared (E-0068)
UpdateTwoChoiceCursor_Bank1B::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_update_two_choice_cursor_bank1_b_read
    bit 7, a
    jr nz, .call_update_two_choice_cursor_bank1_b_read2
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, .call_update_two_choice_cursor_bank1_b_step_bg
    bit 1, a
    jr nz, .set_menu_input_result_to_FE
    call UpdateTwoChoiceCursor_Bank1B_WriteScreenCounter
    xor a
    ld [wMenuInputResult], a
    ret

.call_update_two_choice_cursor_bank1_b_read:
    call UpdateTwoChoiceCursor_Bank1B_ReadTwoChoiceCursor_Sub03
    ld a, [wTwoChoiceCursor]
    and a
    jr nz, .set_two_choice_cursor
    ld a, $01
    ld [wTwoChoiceCursor], a
    jr .clear_screen_counter

.set_two_choice_cursor:
    dec a
    ld [wTwoChoiceCursor], a
    jr .clear_screen_counter

.call_update_two_choice_cursor_bank1_b_read2:
    call UpdateTwoChoiceCursor_Bank1B_ReadTwoChoiceCursor_Sub03
    ld a, [wTwoChoiceCursor]
    cp $01
    jr c, .set_two_choice_cursor2
    xor a
    ld [wTwoChoiceCursor], a
    jr .clear_screen_counter

.set_two_choice_cursor2:
    inc a
    ld [wTwoChoiceCursor], a

.clear_screen_counter:
    xor a
    ld [wScreenCounter], a
    call UpdateTwoChoiceCursor_Bank1B_ReadTwoChoiceCursor
    ld a, $69
    call QueueSoundEffect
    ld a, $fd
    ld [wMenuInputResult], a
    ret

.call_update_two_choice_cursor_bank1_b_step_bg:
    call UpdateTwoChoiceCursor_Bank1B_StepBGMapAddressBackOnScrollWrap
    ld a, $69
    call QueueSoundEffect
    ld a, $ff
    ld [wMenuInputResult], a
    ret

.set_menu_input_result_to_FE:
    ld a, $fe
    ld [wMenuInputResult], a
    ret

UpdateTwoChoiceCursor_Bank1B_WriteScreenCounter::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, UpdateTwoChoiceCursor_Bank1B_ReadTwoChoiceCursor
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp $10
    jr c, UpdateTwoChoiceCursor_Bank1B_ReadTwoChoiceCursor
    cp $18
    jr c, UpdateTwoChoiceCursor_Bank1B_ReadTwoChoiceCursor_Sub03
    xor a
    ld [wScreenCounter], a

UpdateTwoChoiceCursor_Bank1B_ReadTwoChoiceCursor::
    ld b, $bb
    jr UpdateTwoChoiceCursor_Bank1B_StepBGMapAddressBackOnScrollWrap_ReadTwoChoiceCursor

UpdateTwoChoiceCursor_Bank1B_ReadTwoChoiceCursor_Sub03::
    ld b, $c3
    jr UpdateTwoChoiceCursor_Bank1B_StepBGMapAddressBackOnScrollWrap_ReadTwoChoiceCursor

UpdateTwoChoiceCursor_Bank1B_StepBGMapAddressBackOnScrollWrap::
    ld b, $bc

UpdateTwoChoiceCursor_Bank1B_StepBGMapAddressBackOnScrollWrap_ReadTwoChoiceCursor::
    ld a, [wTwoChoiceCursor]
    sla a
    ld hl, UpdateTwoChoiceCursor_Bank1B_StepBGMapAddressBackOnScrollWrap_Data
    add_a_to_hl
    ld a, [hli]
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

UpdateTwoChoiceCursor_Bank1B_StepBGMapAddressBackOnScrollWrap_Data::
    db $2d, $01, $6d, $01

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 15 x 9 tiles, one row per line
TileRect_1B_6483::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 7
LinkKeyTrade_ShowIsItOKTo_Data::
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

; record: 13 x 7 tiles, one row per line
TileRect_1B_650A::
    db $c3, $c3, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1a ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $c3, $c3, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2a ; id 2
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $c3, $c3, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3a ; id 4
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 5
    db $c3, $c3, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4a ; id 6

; record: 1 x 5 tiles, one row per line
TileRect_1B_6565::
    db $b7 ; id 0
    db $b7 ; id 1
    db $b7 ; id 2
    db $b7 ; id 3
    db $b5 ; id 4
    db $b6, $c3, $c3, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1a, $b7, $b6
    db $c3, $c3, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2a, $b7, $b6, $c3
    db $c3, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3a, $b7, $b6, $c3, $c3
    db $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4a, $b7

; record: 8 x 5 tiles, one row per line
TileRect_1B_65A6::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $50, $51, $52, $53, $54, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $55, $56, $57, $58, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 15 x 1 tiles, one row per line
TileRect_1B_65CE::
    db $b6, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6a, $6b, $c3, $b7 ; id 0

LinkKeyTrade_ClampKeyListPageCursor_Data::
    db $ca, $c3, $f2, $c3, $1a, $c4, $42, $c4

LinkKeyTrade_WriteTextWindowTileLoAndTextWindowTileHiEtc_Data::
    db $25, $c4, $4d, $c4

; record: 6 x 5 tiles, one row per line
TileRect_1B_65E9::
    db $b0, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $ce, $cf, $df, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $a5, $71, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; id 4

LinkKeyTrade_DrawThreeTilesAtBGMap20FFromDE_Data::
    db $bc, $bc, $bc

LinkKeyTrade_DrawThreeTilesAtBGMap20FFromDE_Case21_Data::
    db $a0, $a1, $a2

RunLinkSession4ScreenState_Case06_DecompressToVRAM::
    ld hl, wScreenState
    ld bc, $006f

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop
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

.loop2:
    farcall StepTextWindowOpenClose
    ld a, [wTextWindowState]
    and $03
    jr nz, .loop2
    ret

; the same instruction sequence as EggServiceMenu (bank $0D) apart from label operands, which refer
; to this bank's own routines and tables; the twin's note describes the shape (E-0107)
EggServiceMenu_Bank1B::
    ld a, [wScreenState]
    jumptable
    dw EggServiceMenu_Bank1B_ShowStringA10_Bank1B
    dw EggServiceMenu_Bank1B_WaitTextFlags
    dw EggServiceMenu_Bank1B_WaitForPartner
    dw EggServiceMenu_Bank1B_AdvanceScreenState
    dw EggServiceMenu_Bank1B_PickRecords
    dw EggServiceMenu_Bank1B_StartLinkBattle
    dw EggServiceMenu_Bank1B_SwapMonstersMenu
    dw EggServiceMenu_Bank1B_SwapMonstersMenu
    dw EggServiceMenu_Bank1B_SwapMonstersMenu
    dw EggServiceMenu_Bank1B_SwapMonstersMenu
    dw EggServiceMenu_Bank1B_SwapMonstersMenu
    dw EggServiceMenu_Bank1B_SwapMonstersMenu
    dw EggServiceMenu_Bank1B_SwapMonstersMenu
    dw EggServiceMenu_Bank1B_RunScreenStateWhenNotFading_F1
    dw EggServiceMenu_Bank1B_ListAvailableRecords
    dw EggServiceMenu_Bank1B_ListAvailableRecords2

EggServiceMenu_Bank1B_ShowStringA10_Bank1B::
    ld a, $c0
    ldh [hSpriteHideTile], a
    xor a
    ld [wStringCategory], a
    call ShowStringA10_Bank1B
    call ClearTileRowsFromPickCount
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

EggServiceMenu_Bank1B_WaitTextFlags::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    ret

; by its step: 'Please wait.' and the partner's link message
EggServiceMenu_Bank1B_WaitForPartner::
    ld a, [wScreenStep]
    jumptable
    dw EggServiceMenu_Bank1B_WaitForPartner_WaitLinkMessage
    dw EggServiceMenu_Bank1B_WaitForPartner_ShowPleaseWait
    dw EggServiceMenu_Bank1B_WaitForPartner_WaitTextFlags
    dw EggServiceMenu_Bank1B_WaitForPartner_WaitLinkMessage_Case03
    dw EggServiceMenu_Bank1B_WaitForPartner_WaitTextFlags_Case04

EggServiceMenu_Bank1B_WaitForPartner_WaitLinkMessage::
    ld a, [wLinkMessage]
    cp $fe
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

EggServiceMenu_Bank1B_WaitForPartner_ShowPleaseWait::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $0c ; 'Please wait.'
    call ShowStringA10_Bank1B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

EggServiceMenu_Bank1B_WaitForPartner_WaitTextFlags::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

EggServiceMenu_Bank1B_WaitForPartner_WaitLinkMessage_Case03::
    ld a, [wLinkMessage]
    cp $01
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

EggServiceMenu_Bank1B_WaitForPartner_WaitTextFlags_Case04::
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld hl, wScreenState
    ld bc, $006f

.loop:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld a, $05
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    ld a, $01
    ld [wModeChangeRequest], a
    ret

EggServiceMenu_Bank1B_AdvanceScreenState::
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; by wScreenStep: record list pages and panels with the 'Info / OK / Yes / No' window
EggServiceMenu_Bank1B_PickRecords::
    ld a, [wScreenStep]
    jumptable
    dw EggServiceMenu_Bank1B_PickRecords_BreedMenu
    dw EggServiceMenu_Bank1B_PickRecords_BreedMenu_Case01
    dw DrawRecordListPageIndicators_1B
    dw EggServiceMenu_Bank1B_PickRecords_BreedMenu_Case01
    dw DrawListEntriesCell5RecordPanel
    dw ClearAndDrawListEntriesCell5NameAtTiles1780
    dw DrawRuleBoxByWD04CBit7
    dw EggServiceMenu_Bank1B_PickRecords_SetDefaultStringWindow_Bank1B
    dw EggServiceMenu_Bank1B_PickRecords_ShowYourPalRefusedTo
    dw EggServiceMenu_Bank1B_PickRecords_ShowInfoOKYesN
    dw EggServiceMenu_Bank1B_PickRecords_ShowYourPalRefusedTo_Case0A
    dw EggServiceMenu_Bank1B_PickRecords_EraseCEntriesOfWordTable_Bank1B
    dw EggServiceMenu_Bank1B_PickRecords_ClearTileRowsFromPickCount
    dw EggServiceMenu_Bank1B_PickRecords_ShowYourPalRefusedTo_Case0D

EggServiceMenu_Bank1B_PickRecords_BreedMenu_Case01::
    ld a, [wTextFlags]
    and a
    ret nz
    farcall BreedMenu
    ret

EggServiceMenu_Bank1B_PickRecords_BreedMenu::
    ld a, [wTextFlags]
    and a
    ret nz
    farcall BreedMenu
    ret

; runs ListAvailableRecordsForSelection and ClampRecordListPageCursor5; with two or more pages draws
; the bracket and page-of-pages indicators; wScreenStep += 1 (E-0124)
DrawRecordListPageIndicators_1B::
    call ListAvailableRecordsForSelection
    farcall ClampRecordListPageCursor5
    ld a, [wListPages]
    cp $02
    jr c, .check_screen_step
    ld de, $0142
    call DrawC5BEC6AtScrollOffsetDE_Bank1B
    ld hl, wWindowTileBuffer + $12e
    call StoreC5BEC6AtHLStride2_Bank1B
    ld de, $0143
    ld a, d
    ld [wArg1], a
    ld a, e
    ld [wArg2], a
    farcall DrawPageOfPagesAtScrollOffset
    ld hl, wWindowTileBuffer + $12f
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    farcall DrawPageOfPagesAtArg1_Bank1E

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; for the record at WD789 cell 5: draws its graphics (LoadFamilyIconTileForRecordB_Bank1B with wArg1
; = $C7), copies two rectangles to wWindowTileBuffer + $134 and wWindowTileBuffer + $140, draws its
; details at wWindowTileBuffer + $143 (DrawListEntriesCell5RecordPanel_HLToDecimalDigits) and
; wScreenStep += 1 (E-0121)
DrawListEntriesCell5RecordPanel::
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    ld a, $c7
    ld [wArg1], a
    call LoadFamilyIconTileForRecordB_Bank1B
    ld de, TileRect_1B_7738
    ld hl, wWindowTileBuffer + $134
    lb bc, $05, $01
    call CopyRectTo20ByteRows
    ld de, TileRect_1B_773D
    ld hl, wWindowTileBuffer + $140
    lb bc, $0d, $02
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

; clears 5 tiles at vTiles1 + $780, draws the name of the record at WD789 cell 5 there and
; wScreenStep += 1 (E-0122)
ClearAndDrawListEntriesCell5NameAtTiles1780::
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

; copies box TileRect_1B_7757 (10 x 7) or TileRect_1B_779D (10 x 9, when bit 7 of wLinkRules + $9 is
; set) to wWindowTileBuffer + $6E, then wScreenStep += 1 (E-0124)
DrawRuleBoxByWD04CBit7::
    ld a, [wLinkRules + $9]
    bit 7, a
    jr nz, .skip
    ld de, TileRect_1B_7757
    ld hl, wWindowTileBuffer + $6e
    lb bc, $0a, $07
    call CopyRectTo20ByteRows
    jr .check_screen_step

.skip:
    ld de, TileRect_1B_779D
    ld hl, wWindowTileBuffer + $6e
    lb bc, $0a, $09
    call CopyRectTo20ByteRows

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

EggServiceMenu_Bank1B_PickRecords_SetDefaultStringWindow_Bank1B::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wListCursor]
    ld b, $bb
    ld hl, EggServiceMenu_Bank1B_PickRecords_SetDefaultStringWindow_Bank1B_Data
    call StoreBAtWordTableEntry_Bank1B
    call BGMapAddressAtScroll_Bank1B
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_1B
    ld a, [wListCursor]
    ld b, $c3
    ld hl, EggServiceMenu_Bank1B_PickRecords_SetDefaultStringWindow_Bank1B_Data
    call StoreBAtWordTableEntry_Bank1B
    call SetDefaultStringWindow_Bank1B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

EggServiceMenu_Bank1B_PickRecords_ShowYourPalRefusedTo::
    ld a, [wLinkMessage]
    cp $fe
    jr nz, .clear_menu_input_result
    ld a, $02
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0b ; 'Your pal refused to battle.'
    call ShowStringA10_Bank1B
    ld a, $fe
    ld [wLinkSendByte], a
    ret

.clear_menu_input_result:
    xor a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fb
    jr z, .read_screen_step
    cp $fc
    jr z, .read_screen_step
    cp $fd
    jr z, .read_screen_step2
    cp $fe
    jr z, .check_pick_count
    cp $ff
    jr z, .call_egg_service_menu_bank1_b_pick_records
    ret

.read_screen_step:
    ld a, [wScreenStep]
    sub $07
    ld [wScreenStep], a
    ret

.read_screen_step2:
    ld a, [wScreenStep]
    sub $04
    ld [wScreenStep], a
    ret

.check_pick_count:
    ld a, [wPickCount]
    and a
    jr z, .set_screen_state_to_02
    cp $03
    jr c, .set_pick_count
    ld a, [wSelectedRecord]
    ld [wPickCount], a
    dec a
    ld [wPickCount], a
    ld a, $01 ; 'Choose the members for VS battle.'
    call ShowStringA10_Bank1B
    jr .call_clear_tile_rows_from_pick_count

.set_pick_count:
    dec a
    ld [wPickCount], a
    xor a
    call ShowStringA10_Bank1B

.call_clear_tile_rows_from_pick_count:
    call ClearTileRowsFromPickCount
    xor a
    ld [wListCursor], a
    ld [wListPageIndex], a
    ld a, $01
    ld [wScreenStep], a
    ret

.set_screen_state_to_02:
    ld a, $02
    ld [wScreenState], a
    ld a, $0a ; 'You refused to battle.'
    call ShowStringA10_Bank1B
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $fe
    ld [wLinkSendByte], a
    ret

.call_egg_service_menu_bank1_b_pick_records:
    call EggServiceMenu_Bank1B_PickRecords_SetArg5ToListEntriesCell5
    call EggServiceMenu_Bank1B_PickRecords_WriteScreenStepAndRAMG2Etc
    cp $ff
    jr z, .read_list_cursor
    ret

.read_list_cursor:
    ld a, [wListCursor]
    ld b, $bc
    ld hl, EggServiceMenu_Bank1B_PickRecords_SetDefaultStringWindow_Bank1B_Data
    call StoreBAtWordTableEntry_Bank1B
    call CopyListEntriesCell5NameToTextBuf0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, [wPickCount]
    cp $03
    jr z, .call_show_string_a10_bank1_b
    ld a, $02 ; 'Pick 0 for the team?'
    call ShowStringA10_Bank1B
    ret

.call_show_string_a10_bank1_b:
    ld a, $07 ; 'Put up 0 as a prize?'
    call ShowStringA10_Bank1B
    ret

EggServiceMenu_Bank1B_PickRecords_ShowInfoOKYesN::
    ld a, [wTextFlags]
    and a
    ret nz
    ld hl, vTiles2 + $700
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0c01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a
    ld [wStringCategory], a
    ld a, $1e
    ld [wStringIndex], a ; 'InfoOKYesN'
    farcall ShowString_Bank1B_481A
    ld a, $6c
    call QueueSoundEffect
    ld de, TileRect_1B_7847
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    lb bc, $14, $0d
    ld de, $01cc
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
    xor a
    ld [wChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

EggServiceMenu_Bank1B_PickRecords_ShowYourPalRefusedTo_Case0A::
    ld a, [wLinkMessage]
    cp $fe
    jr nz, .clear_arg5
    ld a, $02
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0b ; 'Your pal refused to battle.'
    call ShowStringA10_Bank1B
    ld a, $fe
    ld [wLinkSendByte], a
    ret

.clear_arg5:
    xor a
    ld [wArg5], a
    farcall HandleTwoChoiceCursorInput_0D
    ld a, [wArg5]
    and a
    ret z
    cp $fe
    jr z, .check_screen_step
    cp $ff
    jr z, .check_choice_cursor
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.check_choice_cursor:
    ld a, [wChoiceCursor]
    and a
    jr nz, .call_egg_service_menu_bank1_b_pick_records
    ld a, [wScreenState]
    ld [wScreenByteB2], a
    ld a, [wScreenStep]
    ld [wScreenByteB3], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0c
    ld [wScreenState], a
    ret

.call_egg_service_menu_bank1_b_pick_records:
    call EggServiceMenu_Bank1B_PickRecords_SetArg5ToListEntriesCell5
    ld a, [wPickCount]
    cp $03
    jr c, .check_screen_step2
    call EggServiceMenu_Bank1B_PickRecords_Case0A_SetArg5ToListEntriesCell5
    cp $ff
    jr nz, .call_set_arg5_to_list_entries_cell5
    ret

.call_set_arg5_to_list_entries_cell5:
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wLinkSceneByte4C], a
    ld a, $04
    ld [wPickCount], a
    call EggServiceMenu_Bank1B_PickRecords_Case0A_EraseCEntriesOfWordTable_Bank1B
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ld a, $0c ; 'Please wait.'
    call ShowStringA10_Bank1B
    ret

.check_screen_step2:
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    ret

EggServiceMenu_Bank1B_PickRecords_EraseCEntriesOfWordTable_Bank1B::
    ld a, [wTextFlags]
    and a
    ret nz
    ld c, $05
    ld hl, EggServiceMenu_Bank1B_PickRecords_SetDefaultStringWindow_Bank1B_Data
    call EraseCEntriesOfWordTable_Bank1B
    jr EggServiceMenu_Bank1B_PickRecords_Case0A_EraseCEntriesOfWordTable_Bank1B_CallEggServiceMenu_Bank1B_PickRecords_CopyRe

EggServiceMenu_Bank1B_PickRecords_Case0A_EraseCEntriesOfWordTable_Bank1B::
    ld c, $05
    ld hl, EggServiceMenu_Bank1B_PickRecords_SetDefaultStringWindow_Bank1B_Data
    call EraseCEntriesOfWordTable_Bank1B
    ld a, [wListCursor]
    ld b, $bc
    ld hl, EggServiceMenu_Bank1B_PickRecords_SetDefaultStringWindow_Bank1B_Data
    call StoreBAtWordTableEntry_Bank1B

EggServiceMenu_Bank1B_PickRecords_Case0A_EraseCEntriesOfWordTable_Bank1B_CallEggServiceMenu_Bank1B_PickRecords_CopyRe::
    call EggServiceMenu_Bank1B_PickRecords_CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_1B
    ld a, [wScreenStep]
    sub $03
    ld [wScreenStep], a
    ret

EggServiceMenu_Bank1B_PickRecords_ClearTileRowsFromPickCount::
    call EggServiceMenu_Bank1B_PickRecords_WriteScreenStepAndRAMG2Etc
    cp $ff
    ret nz
    call EggServiceMenu_Bank1B_PickRecords_CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    lb bc, $14, $0d
    ld de, $01cc
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

EggServiceMenu_Bank1B_PickRecords_ShowYourPalRefusedTo_Case0D::
    ld a, [wLinkMessage]
    cp $fe
    jr nz, .read_screen_sub_step
    ld a, $02
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0b ; 'Your pal refused to battle.'
    call ShowStringA10_Bank1B
    ld a, $fe
    ld [wLinkSendByte], a
    ret

.read_screen_sub_step:
    ld a, [wScreenSubStep]
    jumptable
    dw EggServiceMenu_Bank1B_PickRecords_Case0A_Sub01_ShowChooseOneMoreMember
    dw EggServiceMenu_Bank1B_PickRecords_Case0A_Sub01_QueueSoundEffect
    dw EggServiceMenu_Bank1B_PickRecords_Case0A_Sub01_ShowYourPalRefusedTo
    dw EggServiceMenu_Bank1B_PickRecords_Case0A_Sub01_WaitTextFlags
    dw EggServiceMenu_Bank1B_PickRecords_Case0A_Sub01_ShowPleaseWait
    dw EggServiceMenu_Bank1B_PickRecords_Case0A_Sub01_ShowPleaseWait_Case05
    dw EggServiceMenu_Bank1B_PickRecords_Case0A_Sub01_QueueSoundEffect
    dw EggServiceMenu_Bank1B_PickRecords_Case0A_Sub01_ShowYourPalRefusedTo_Case07

EggServiceMenu_Bank1B_PickRecords_Case0A_Sub01_ShowChooseOneMoreMember::
    ld a, [wPickCount]
    cp $03
    jr z, .read_screen_sub_step
    call ListAvailableRecordsForSelection
    ld a, [wListCount]
    and a
    jr z, .read_screen_sub_step
    ld a, $03 ; 'Choose one more member for battle?'
    call ShowStringA10_Bank1B
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.read_screen_sub_step:
    ld a, [wScreenSubStep]
    add $04
    ld [wScreenSubStep], a
    ret

EggServiceMenu_Bank1B_PickRecords_Case0A_Sub01_QueueSoundEffect::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $6c
    call QueueSoundEffect
    ld de, TileRect_1B_78CB
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_1B
    ld a, [wScreenSubStep]
    cp $01
    jr z, .clear_two_choice_cursor
    ld a, [wPickCount]
    cp $03
    jr nz, .clear_two_choice_cursor
    ld a, $01
    jr .set_two_choice_cursor

.clear_two_choice_cursor:
    xor a

.set_two_choice_cursor:
    ld [wTwoChoiceCursor], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

EggServiceMenu_Bank1B_PickRecords_Case0A_Sub01_ShowYourPalRefusedTo::
    ld a, [wLinkMessage]
    cp $fe
    jr nz, .call_update_two_choice_cursor_bank1_d
    ld a, $02
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0b ; 'Your pal refused to battle.'
    call ShowStringA10_Bank1B
    ld a, $fe
    ld [wLinkSendByte], a
    ret

.call_update_two_choice_cursor_bank1_d:
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fe
    jr z, .loop
    cp $ff
    jr z, .check_two_choice_cursor
    ret

.loop:
    call DrawChoiceBoxByWD04CBit7
    ld a, [wScreenSubStep]
    add $02
    ld [wScreenSubStep], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    and a
    jr nz, .loop
    call DrawChoiceBoxByWD04CBit7
    xor a
    call ShowStringA10_Bank1B
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

EggServiceMenu_Bank1B_PickRecords_Case0A_Sub01_WaitTextFlags::
    ld a, [wTextFlags]
    and a
    ret nz
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ret

EggServiceMenu_Bank1B_PickRecords_Case0A_Sub01_ShowPleaseWait::
    ld a, [wLinkRules + $9]
    bit 7, a
    jr nz, .call_list_records_state1_with_byte6_e_clear
    ld a, $0c ; 'Please wait.'
    call ShowStringA10_Bank1B
    call FinishPickedRecordsEntryAndAdvance
    ret

.call_list_records_state1_with_byte6_e_clear:
    farcall ListRecordsState1WithByte6EClear
    ld a, [wListCount]
    and a
    jr nz, .call_show_string_a10_bank1_b
    call PadPickedRecordsWithFFToThree
    ld a, $05 ; 'You have no monsters on the'
    call ShowStringA10_Bank1B
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.call_show_string_a10_bank1_b:
    ld a, $04 ; 'Will you put up a prize?'
    call ShowStringA10_Bank1B
    call PadPickedRecordsWithFFToThree
    ld a, [wPickCount]
    ld [wSelectedRecord], a
    ld a, $03
    ld [wPickCount], a
    ld a, [wScreenSubStep]
    add $02
    ld [wScreenSubStep], a
    xor a
    ld [wTwoChoiceCursor], a
    ret

EggServiceMenu_Bank1B_PickRecords_Case0A_Sub01_ShowPleaseWait_Case05::
    ld a, [wTextFlags]
    and a
    ret nz
    call FinishPickedRecordsEntryAndAdvance
    ld a, $0c ; 'Please wait.'
    call ShowStringA10_Bank1B
    ret

EggServiceMenu_Bank1B_PickRecords_Case0A_Sub01_ShowYourPalRefusedTo_Case07::
    ld a, [wLinkMessage]
    cp $fe
    jr nz, .call_update_two_choice_cursor_bank1_d
    ld a, $02
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0b ; 'Your pal refused to battle.'
    call ShowStringA10_Bank1B
    ld a, $fe
    ld [wLinkSendByte], a
    ret

.call_update_two_choice_cursor_bank1_d:
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fe
    jr z, .loop
    cp $ff
    jr z, .check_two_choice_cursor
    ret

.loop:
    call DrawChoiceBoxByWD04CBit7
    ld a, $04
    ld [wPickCount], a
    ld a, $ff
    ld [wPackWork], a
    ld a, [wScreenSubStep]
    sub $02
    ld [wScreenSubStep], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    and a
    jr nz, .loop
    call DrawChoiceBoxByWD04CBit7
    ld a, $06 ; 'Select a monster as the prize.'
    call ShowStringA10_Bank1B
    ld a, $03
    ld [wScreenSubStep], a
    ret

; by wScreenStep: the picked records, 'Begin battle?', 'Please wait.', 'Starting battle' or 'Your
; pal refused to battle.' over the link
EggServiceMenu_Bank1B_StartLinkBattle::
    ld a, [wScreenStep]
    jumptable
    dw EggServiceMenu_Bank1B_StartLinkBattle_DrawPickedRecordsRecordNamesAndIcons
    dw EggServiceMenu_Bank1B_StartLinkBattle_FillBytes
    dw EggServiceMenu_Bank1B_StartLinkBattle_SetScreenStep
    dw EggServiceMenu_Bank1B_StartLinkBattle_ShowYourPalRefusedTo
    dw EggServiceMenu_Bank1B_StartLinkBattle_WriteScreenStepAndLinkTimeoutLoEtc
    dw EggServiceMenu_Bank1B_StartLinkBattle_ShowBeginBattle
    dw EggServiceMenu_Bank1B_StartLinkBattle_ShowBattlePrizeExit
    dw EggServiceMenu_Bank1B_StartLinkBattle_ShowYourPalRefusedTo_Case07
    dw EggServiceMenu_Bank1B_StartLinkBattle_WaitTextFlags
    dw EggServiceMenu_Bank1B_StartLinkBattle_ToShowStringA10_Bank1BAndStep
    dw EggServiceMenu_Bank1B_StartLinkBattle_WaitTextFlags_Case0A
    dw EggServiceMenu_Bank1B_StartLinkBattle_SetScreenStep
    dw EggServiceMenu_Bank1B_StartLinkBattle_ShowYourPalRefusedTo_Case0C
    dw EggServiceMenu_Bank1B_StartLinkBattle_WriteLinkSceneByte4BAndLinkTimeoutLoEtc
    dw EggServiceMenu_Bank1B_StartLinkBattle_SetScreenStep
    dw EggServiceMenu_Bank1B_StartLinkBattle_WaitLinkMessage
    dw EggServiceMenu_Bank1B_StartLinkBattle_WaitLinkMessage_Case10
    dw EggServiceMenu_Bank1B_StartLinkBattle_ToShowStringA10_Bank1BAndStep_Case11
    dw EggServiceMenu_Bank1B_StartLinkBattle_WaitTextFlags_Case0A
    dw EggServiceMenu_Bank1B_StartLinkBattle_SetScreenStep
    dw EggServiceMenu_Bank1B_StartLinkBattle_ShowYourPalRefusedTo
    dw EggServiceMenu_Bank1B_StartLinkBattle_WriteGameModeAndModeStateEtc

EggServiceMenu_Bank1B_StartLinkBattle_ToShowStringA10_Bank1BAndStep_Case11::
    ld a, $09 ; 'Starting battle…'
    call ShowStringA10_Bank1B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

EggServiceMenu_Bank1B_StartLinkBattle_ToShowStringA10_Bank1BAndStep::
    ld a, $0c ; 'Please wait.'
    call ShowStringA10_Bank1B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

EggServiceMenu_Bank1B_StartLinkBattle_WaitTextFlags_Case0A::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

EggServiceMenu_Bank1B_StartLinkBattle_DrawPickedRecordsRecordNamesAndIcons::
    ld a, [wTextFlags]
    and a
    ret nz
    call DrawPickedRecordsRecordNamesAndIcons
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

EggServiceMenu_Bank1B_StartLinkBattle_FillBytes::
    ld a, [wPackWork]
    cp $ff
    jr nz, .call_multiply8
    ld hl, wRecordBufA
    ld bc, $00a5
    xor a
    call FillBytes
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld hl, sRecords + $f
    ld de, wRecordBufA + MON_MASTER_NAME
    ld b, $0a
    jr .loop

.call_multiply8:
    ld c, $a5
    call Multiply8
    ld de, sRecords
    add hl, de
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld de, wRecordBufA
    ld b, $a5

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

EggServiceMenu_Bank1B_StartLinkBattle_SetScreenStep::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

EggServiceMenu_Bank1B_StartLinkBattle_ShowYourPalRefusedTo::
    ld a, [wLinkMessage]
    cp $01
    jr z, .clear_link_send_byte
    cp $fe
    ret nz
    ld a, $02
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0b ; 'Your pal refused to battle.'
    call ShowStringA10_Bank1B
    ld a, $fe
    ld [wLinkSendByte], a
    ret

.clear_link_send_byte:
    xor a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

EggServiceMenu_Bank1B_StartLinkBattle_WriteScreenStepAndLinkTimeoutLoEtc::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld hl, wRecordBufA
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, $00a5
    ld a, l
    ld [wLinkBufferCountLo], a
    ld a, h
    ld [wLinkBufferCountHi], a
    ld hl, wRecordBufB
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $ff
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

EggServiceMenu_Bank1B_StartLinkBattle_WaitLinkMessage_Case10::
    ld a, [wLinkMessage]
    cp $f0
    ret nz
    ld a, $00
    ld [wLinkReady], a
    ld a, $00
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

EggServiceMenu_Bank1B_StartLinkBattle_ShowBeginBattle::
    ld a, [wLinkMessage]
    cp $f0
    ret nz
    ld a, $00
    ld [wLinkReady], a
    ld a, $00
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $08 ; 'Begin battle?'
    call ShowStringA10_Bank1B
    ret

EggServiceMenu_Bank1B_StartLinkBattle_ShowBattlePrizeExit::
    ld a, [wTextFlags]
    and a
    ret nz
    ld hl, vTiles2 + $300
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0e01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a
    ld [wStringCategory], a
    ld a, $1f
    ld [wStringIndex], a ; 'BattlePrizeExit'
    farcall ShowString_Bank1B_481A
    ld a, $6c
    call QueueSoundEffect
    ld de, TileRect_1B_78E9
    ld hl, wWindowTileBuffer + $e7
    lb bc, $09, $07
    call CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_1B
    call SetDefaultStringWindow_Bank1B
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

EggServiceMenu_Bank1B_StartLinkBattle_ShowYourPalRefusedTo_Case07::
    ld a, [wLinkMessage]
    cp $fe
    jr nz, .call_handle_three_choice_cursor_input_f1
    ld a, $02
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0b ; 'Your pal refused to battle.'
    call ShowStringA10_Bank1B
    ld a, $fe
    ld [wLinkSendByte], a
    ret

.call_handle_three_choice_cursor_input_f1:
    farcall HandleThreeChoiceCursorInput_F1
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fe
    jr z, .set_screen_state_to_02
    cp $ff
    jr z, .check_two_choice_cursor
    ret

.set_screen_state_to_02:
    ld a, $02
    ld [wScreenState], a
    ld a, $0a ; 'You refused to battle.'
    call ShowStringA10_Bank1B
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $fe
    ld [wLinkSendByte], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    and a
    jr z, .read_screen_step
    cp $01
    jr z, .check_link_rules
    jr .set_screen_state_to_02

.read_screen_step:
    ld a, [wScreenStep]
    add $02
    ld [wScreenStep], a
    ret

.check_link_rules:
    ld a, [wLinkRules + $9]
    bit 7, a
    jr nz, .check_record_buf_b
    ld a, $14 ; 'There is no prize for this'
    call ShowStringA10_Bank1B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.check_record_buf_b:
    ld a, [wRecordBufB]
    and a
    jr nz, .read_screen_state
    ld a, $15 ; 'There is no prize.'
    call ShowStringA10_Bank1B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.read_screen_state:
    ld a, [wScreenState]
    ld [wScreenByteB2], a
    ld a, [wScreenStep]
    ld [wScreenByteB3], a
    ld a, $0d
    ld [wScreenState], a
    ld a, [wListCursor]
    ld [wItemGridX], a
    ld a, [wListPageIndex]
    ld [wItemGridY], a
    xor a
    ld [wListCursor], a
    ld [wListPageIndex], a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ret

EggServiceMenu_Bank1B_StartLinkBattle_WaitTextFlags::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    ret

EggServiceMenu_Bank1B_StartLinkBattle_ShowYourPalRefusedTo_Case0C::
    ld a, [wLinkMessage]
    cp $01
    jr z, .clear_link_send_byte
    cp $fe
    ret nz
    ld a, $02
    ld [wScreenState], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0b ; 'Your pal refused to battle.'
    call ShowStringA10_Bank1B
    ld a, $fe
    ld [wLinkSendByte], a
    ret

.clear_link_send_byte:
    xor a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

EggServiceMenu_Bank1B_StartLinkBattle_WriteLinkSceneByte4BAndLinkTimeoutLoEtc::
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .set_link_scene_byte4_b_to_01
    xor a
    ld [wLinkSceneByte4B], a
    call EggServiceMenu_Bank1B_StartLinkBattle_Case0D_WriteRAMG2AndRAMB
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

.set_link_scene_byte4_b_to_01:
    ld a, $01
    ld [wLinkSceneByte4B], a
    call EggServiceMenu_Bank1B_StartLinkBattle_Case0D_WriteRAMG2AndRAMB
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

EggServiceMenu_Bank1B_StartLinkBattle_WaitLinkMessage::
    ld a, [wLinkMessage]
    cp $01
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld hl, $00ea
    ld a, l
    ld [wLinkBufferCountLo], a
    ld a, h
    ld [wLinkBufferCountHi], a
    ld a, $ff
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

EggServiceMenu_Bank1B_StartLinkBattle_WriteGameModeAndModeStateEtc::
    ld a, $04
    ld [wGameMode], a
    xor a
    ld [wModeState], a
    ld [wWorldMapState], a
    ld [wGameMode2Arg], a
    ld a, $01
    ld [wModeChangeRequest], a
    ld a, $01
    ld [wLinkSession], a
    ld a, $00
    ld [wLinkExchangeState], a
    xor a
    ld [wLinkSendByte], a
    xor a
    ld [wLinkMessage], a
    ret

EggServiceMenu_Bank1B_SwapMonstersMenu::
    farcall SwapMonstersMenu
    ld a, [wScreenStep]
    cp $0a
    ret nz
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    add $03
    ld [wScreenState], a
    ret

EggServiceMenu_Bank1B_RunScreenStateWhenNotFading_F1::
    farcall RunScreenStateWhenNotFading_F1
    ld a, [wScreenState]
    cp $0e
    ret nz
    ld a, [wItemGridX]
    ld [wListCursor], a
    ld a, [wItemGridY]
    ld [wListPageIndex], a
    ret

; by wScreenStep: ListAvailableRecordsForSelection, the list page, the record panel and the 'Battle
; / Prize / Exit' window
EggServiceMenu_Bank1B_ListAvailableRecords::
    ld a, [wScreenStep]
    jumptable
    dw EggServiceMenu_Bank1B_ListAvailableRecords_ClearRecordPanelTiles
    dw EggServiceMenu_Bank1B_ListAvailableRecords_ListAvailableRecordsForSelection
    dw EggServiceMenu_Bank1B_ListAvailableRecords_DrawRecordListPageNames
    dw EggServiceMenu_Bank1B_ListAvailableRecords_ToDrawListEntriesCell5RecordPanel
    dw EggServiceMenu_Bank1B_ListAvailableRecords_CallClearAndDrawListEntriesCell5NameAtTiles1780
    dw EggServiceMenu_Bank1B_ListAvailableRecords_ToDrawRuleBoxByWD04CBit7
    dw EggServiceMenu_Bank1B_ListAvailableRecords_ShowBattlePrizeExit
    dw EggServiceMenu_Bank1B_ListAvailableRecords_BGMapAddressAtScroll_Bank1B

EggServiceMenu_Bank1B_ListAvailableRecords_ShowBattlePrizeExit::
    ld hl, vTiles2 + $300
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0e01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a
    ld [wStringCategory], a
    ld a, $1f
    ld [wStringIndex], a ; 'BattlePrizeExit'
    farcall ShowString_Bank1B_481A
    ld de, TileRect_1B_78E9
    ld hl, wWindowTileBuffer + $e7
    lb bc, $09, $07
    call CopyRectTo20ByteRows
    call SetDefaultStringWindow_Bank1B
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; the EggServiceMenu_Bank1B_ListAvailableRecords steps again
EggServiceMenu_Bank1B_ListAvailableRecords2::
    ld a, [wScreenStep]
    jumptable
    dw EggServiceMenu_Bank1B_ListAvailableRecords_ClearRecordPanelTiles
    dw EggServiceMenu_Bank1B_ListAvailableRecords_ListAvailableRecordsForSelection
    dw EggServiceMenu_Bank1B_ListAvailableRecords_DrawRecordListPageNames
    dw EggServiceMenu_Bank1B_ListAvailableRecords_ToDrawListEntriesCell5RecordPanel
    dw EggServiceMenu_Bank1B_ListAvailableRecords_CallClearAndDrawListEntriesCell5NameAtTiles1780
    dw EggServiceMenu_Bank1B_ListAvailableRecords_ToDrawRuleBoxByWD04CBit7
    dw EggServiceMenu_Bank1B_ListAvailableRecords2_ShowInfoOKYesN
    dw EggServiceMenu_Bank1B_ListAvailableRecords_BGMapAddressAtScroll_Bank1B

EggServiceMenu_Bank1B_ListAvailableRecords_ClearRecordPanelTiles::
    call ClearRecordPanelTiles
    ld de, TileRect_1B_7928
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $0b
    call CopyRectTo20ByteRows
    ld a, [wListCursor]
    ld b, $bc
    ld hl, EggServiceMenu_Bank1B_PickRecords_SetDefaultStringWindow_Bank1B_Data
    call StoreBAtWordTableEntry_Bank1B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

EggServiceMenu_Bank1B_ListAvailableRecords_ListAvailableRecordsForSelection::
    call ListAvailableRecordsForSelection
    farcall ClampRecordListPageCursor5
    ld a, [wListPages]
    cp $02
    jr c, .check_screen_step
    ld hl, wWindowTileBuffer + $12e
    call StoreC5BEC6AtHLStride2_Bank1B
    ld hl, wWindowTileBuffer + $12f
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    farcall DrawPageOfPagesAtArg1_Bank1E

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

EggServiceMenu_Bank1B_ListAvailableRecords_DrawRecordListPageNames::
    farcall DrawRecordListPageNames
    xor a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    ret

EggServiceMenu_Bank1B_ListAvailableRecords_ToDrawListEntriesCell5RecordPanel::
    call DrawListEntriesCell5RecordPanel
    ret

EggServiceMenu_Bank1B_ListAvailableRecords_CallClearAndDrawListEntriesCell5NameAtTiles1780::
    call ClearAndDrawListEntriesCell5NameAtTiles1780
    ret

EggServiceMenu_Bank1B_ListAvailableRecords_ToDrawRuleBoxByWD04CBit7::
    call DrawRuleBoxByWD04CBit7
    ret

EggServiceMenu_Bank1B_ListAvailableRecords2_ShowInfoOKYesN::
    ld hl, vTiles2 + $700
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0c01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a
    ld [wStringCategory], a
    ld a, $1e
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
    xor a
    ld [wStringCategory], a
    ld a, [wPickCount]
    cp $03
    jr c, .set_string_index_to_12
    ld a, $17
    jr .set_string_index

.set_string_index_to_12:
    ld a, $12

.set_string_index:
    ld [wStringIndex], a
    farcall ShowString_Bank1B_481A
    ld de, TileRect_1B_7847
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRows
    xor a
    ld [wChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

EggServiceMenu_Bank1B_ListAvailableRecords_BGMapAddressAtScroll_Bank1B::
    call BGMapAddressAtScroll_Bank1B
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_1B
    call BGMapAddressAtScroll_Bank1B
    ld de, $01a0
    add hl, de
    lb bc, $14, $05
    ld de, $0168
    call DrawScreenBufferRectToBGMap_1B
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a
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

EggServiceMenu_Bank1B_StartLinkBattle_Case0D_WriteRAMG2AndRAMB::
    ld hl, wBattlerRecords
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip
    ld hl, wBattlerRecordSlot4

.skip:
    ld c, $00

.loop:
    push bc
    push hl
    ld a, c
    ld de, wPickedRecords
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    push de
    ld a, [de]
    cp $ff
    jp z, .restore
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [de]
    ld c, MON_NAME
    call SRAMRecordAddress
    ld c, l
    ld b, h
    pop de
    pop hl
    push hl
    push de
    ld e, $0e
    call CopyEBytesBCToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, MON_SKILLS
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
    ld c, MON_STATUS
    call SRAMRecordAddress
    ld c, l
    ld b, h
    pop hl
    ld a, [bc]
    ld [hli], a
    inc bc
    ld a, [bc]
    ld [hli], a
    inc bc
    inc bc
    ld e, $15
    call CopyEBytesBCToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, MON_PERSONALITY
    call SRAMRecordAddress
    ld c, l
    ld b, h
    pop hl
    ld e, $1f
    call CopyEBytesBCToHL
    pop de
    push de
    push hl
    ld a, [de]
    ld c, MON_ITEM
    call SRAMRecordAddress
    ld c, l
    ld b, h
    pop hl
    ld a, [bc]
    ld [hli], a
    ld a, $ff
    ld [hl], a
    jr .restore2

.restore:
    pop de
    pop hl
    push hl
    push de
    ld bc, $004e
    xor a
    call FillBytes

.restore2:
    pop de
    pop hl
    pop bc
    inc c
    ld a, $4e
    add_a_to_hl
    ld a, c
    cp $03
    jp c, .loop
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    ret

; copies E bytes from BC to HL; BC and HL advance, E = 0 (E-0115)
CopyEBytesBCToHL::
    ld a, [bc]
    ld [hli], a
    inc bc
    dec e
    jr nz, CopyEBytesBCToHL
    ret

; clears the tile rows at vTiles1 + $500, $700, $780, $240 and $4E0, then the rows from wPickCount =
; 0 and from the saved wPickCount (E-0127)
ClearRecordPanelTiles::
    ld hl, vTiles1 + $500
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0f01
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
    ld hl, vTiles1 + $4e0
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
    xor a
    ld [wPickCount], a
    call ClearTileRowsFromPickCount
    pop af
    ld [wPickCount], a
    call DrawPickedRecordsRecordNamesAndIcons
    ret

EggServiceMenu_Bank1B_PickRecords_Case0A_SetArg5ToListEntriesCell5::
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

.loop:
    ld a, [hli]
    cp e
    jr z, .return_FF
    dec b
    jr nz, .loop
    xor a
    ret

.return_FF:
    ld a, $ff
    ret

; fills wPickedRecords[wPickCount] to wPickedRecords[2] with $FF (does nothing when wPickCount = 3)
; (E-0122)
PadPickedRecordsWithFFToThree::
    ld a, [wPickCount]
    cp $03
    ret z
    ld hl, wPickedRecords
    add_a_to_hl
    ld a, [wPickCount]
    ld b, a
    ld a, $03
    sub b
    ld b, a

.loop:
    ld a, $ff
    ld [hli], a
    dec b
    jr nz, .loop
    ret

EggServiceMenu_Bank1B_PickRecords_LoadSRAMRecordByte::
    ld hl, wPickedRecords
    add_a_to_hl
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    call LoadSRAMRecordByte
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    ret

EggServiceMenu_Bank1B_PickRecords_Shared02_WriteRAMG2AndRAMB::
    ld a, [wPickCount]
    and a
    jr nz, .skip

.return_0:
    xor a
    ret

.skip:
    inc a
    ld b, a
    ld c, $00

.loop:
    push bc
    ld a, c
    ld c, $0d
    call EggServiceMenu_Bank1B_PickRecords_LoadSRAMRecordByte
    pop bc
    push bc
    ld hl, wArg1
    ld a, c
    add_a_to_hl
    ldh a, [hTemp0]
    and $0f
    ld [hl], a
    pop bc
    inc c
    dec b
    jr nz, .loop
    ld a, [wPickCount]
    ld hl, wPickedRecords
    add_a_to_hl
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    ld c, MON_FAMILY
    call LoadSRAMRecordByte
    xor a
    ld [rRAMG2], a
    ldh a, [hTemp0]
    and $0f
    ld d, a
    ld a, [wPickCount]
    ld b, a
    ld hl, wArg1

.loop2:
    push hl
    ld a, [hl]
    cp d
    jr z, .done
    pop hl
    inc hl
    dec b
    jr nz, .loop2
    jr .return_0

.done:
    pop hl
    ld a, $ff
    ret

; copies box TileRect_1B_788F or TileRect_1B_78AD (by bit 7 of wLinkRules + $9) to wWindowTileBuffer
; + $112 and draws it at scroll + $1CC (E-0124)
DrawChoiceBoxByWD04CBit7::
    ld a, [wLinkRules + $9]
    bit 7, a
    jr nz, .skip
    ld de, TileRect_1B_788F
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows
    jr .call_bg_map_address_at_scroll_bank1_b

.skip:
    ld de, TileRect_1B_78AD
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows

.call_bg_map_address_at_scroll_bank1_b:
    call BGMapAddressAtScroll_Bank1B
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_1B
    ret

EggServiceMenu_Bank1B_PickRecords_CopyRectTo20ByteRows::
    ld a, [wLinkRules + $9]
    bit 7, a
    jr nz, .skip
    ld de, TileRect_1B_77F7
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRows
    jr .return

.skip:
    ld de, TileRect_1B_781F
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRows

.return:
    ret

; lists in wListEntries the stored records (state 1, or 2 unless wPickCount is 3) whose field $6E is
; clear and that are not already chosen in wPickedRecords; count in wListCount (E-0130)
ListAvailableRecordsForSelection::
    ld hl, wListEntries
    ld b, $1e

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop
    ld hl, wListEntries2
    ld b, $1e

.loop2:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop2
    xor a
    ld [wListCount], a
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld [wRecordsFlagged], a
    ld de, sRecords
    ld hl, wListEntries
    ld b, $00
    ld c, $00

.loop3:
    ld a, [de]
    and a
    jr z, .skip3
    cp $01
    jr z, .skip
    ld a, [wPickCount]
    cp $03
    jr z, .skip3
    ld a, [de]
    cp $02
    jr z, .skip
    jr .skip3

.skip:
    push de
    ld a, $6e
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    and a
    jr nz, .check_records_flagged
    pop de
    ld a, [wPickCount]
    and a
    jr z, .next
    cp $03
    jr nc, .next
    push hl
    push de
    push bc
    ld d, b
    ld hl, wPickedRecords
    ld a, [wPickCount]
    ld b, a

.loop4:
    ld a, [hli]
    cp d
    jr z, .restore
    dec b
    jr nz, .loop4
    pop bc
    pop de
    pop hl
    jr .next

.restore:
    pop bc
    pop de
    pop hl
    jr .skip3

.next:
    inc c
    ld a, b
    ld [hli], a
    jr .skip3

.check_records_flagged:
    pop de
    ld a, [wRecordsFlagged]
    inc a
    ld [wRecordsFlagged], a

.skip3:
    ld a, $a5
    add e
    ld e, a
    jr nc, .next2
    inc d

.next2:
    inc b
    ld a, b
    cp $1e
    jr c, .loop3
    ld a, c
    ld [wListCount], a
    xor a
    ld [rRAMG2], a
    farcall MovePartyRecordsToFrontOfList
    ret

; wStringIndex = A + $10, wStringCategory = 0, then far-calls BeginStringDisplay_Bank1B_480C
; (E-0063)
ShowStringA10_Bank1B::
    add $10
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank1B_480C
    ret

; sets the string window: wTextWindowTileLo/wTextWindowTileHi = vTiles1 ($8800),
; wTextWindowRows/wTextWindowWidth = $02, $12 (E-0067) (the same 23 bytes appear in 2 banks)
SetDefaultStringWindow_Bank1B::
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

; wWorkBuf = field $0D of SRAM record B & $0F (its family), wWorkBuf + $1 = wArg1, then
; LoadFamilyIconTileForWorkBuf (E-0122)
LoadFamilyIconTileForRecordB_Bank1B::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, b
    ld c, MON_FAMILY
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and $0f
    ld [wWorkBuf], a
    ld a, [wArg1]
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    xor a
    ld [rRAMG2], a
    ret

DrawListEntriesCell5RecordPanel_HLToDecimalDigits::
    ld a, [wArg1]
    ld b, a
    ld a, [wArg2]
    ld l, a
    ld a, [wArg3]
    ld h, a
    push bc
    push hl
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, b
    ld c, MON_LEVEL
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigits_F
    ld a, [wDigits + $1]
    add $e0
    pop hl
    push hl
    ld [hli], a
    ld a, [wDigits + $2]
    add $e0
    ld [hli], a
    pop hl
    pop bc
    ld a, l
    add $07
    ld l, a
    ld a, h
    adc $00
    ld h, a
    push hl
    ld a, b
    ld c, MON_SEX
    ld b, $01
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and $01
    add $cc
    pop hl
    ld [hl], a
    ret

; clears the 6-tile rows of vTiles2 + $100-$220 from row wPickCount onward, then restores the
; default window (E-0127)
ClearTileRowsFromPickCount::
    ld hl, $0601
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, [wPickCount]
    and a
    jr z, .set_text_window_tile_lo
    cp $01
    jr z, .set_text_window_tile_lo2
    cp $02
    jr z, .set_text_window_tile_lo3
    cp $03
    jr z, .set_text_window_tile_lo4
    jr .call_set_default_string_window_bank1_b

.set_text_window_tile_lo:
    ld hl, vTiles2 + $100
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    call FillTilesFromRequest

.set_text_window_tile_lo2:
    ld hl, vTiles2 + $160
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    call FillTilesFromRequest

.set_text_window_tile_lo3:
    ld hl, vTiles2 + $1c0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    call FillTilesFromRequest

.set_text_window_tile_lo4:
    ld hl, vTiles2 + $220
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    call FillTilesFromRequest

.call_set_default_string_window_bank1_b:
    call SetDefaultStringWindow_Bank1B
    ret

; for up to wPickCount records listed at wPickedRecords draws each name at
; DrawPickedRecordsRecordNamesAndIcons_Data1[n] and loads its family icon into tile
; DrawPickedRecordsRecordNamesAndIcons_Data2[n] (E-0128)
DrawPickedRecordsRecordNamesAndIcons::
    ld a, [wPickCount]
    and a
    jr z, .return
    cp $01
    jr z, .skip
    cp $02
    jr z, .skip2
    cp $03
    jr z, .skip3
    ld b, $04
    jr .skip4

.skip:
    ld b, $01
    jr .skip4

.skip2:
    ld b, $02
    jr .skip4

.skip3:
    ld b, $03

.skip4:
    ld hl, wPickedRecords
    ld c, $00

.loop:
    push hl
    push bc
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    cp $ff
    jr z, .restore
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    pop bc
    push bc
    ld a, c
    sla a
    ld hl, DrawPickedRecordsRecordNamesAndIcons_Data1
    add_a_to_hl
    ld a, [hli]
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
    ld hl, DrawPickedRecordsRecordNamesAndIcons_Data2
    add_a_to_hl
    ld a, [hl]
    ld [wArg1], a
    call LoadFamilyIconTileForRecordB_Bank1B

.restore:
    pop bc
    pop hl
    inc hl
    inc c
    dec b
    jr nz, .loop

.return:
    ret

DrawPickedRecordsRecordNamesAndIcons_Data1::
    db $10, $91, $70, $91, $d0, $91, $30, $92

DrawPickedRecordsRecordNamesAndIcons_Data2::
    db $10, $16, $1c, $22

; with SRAM bank 0 enabled, copies the name of the record stored at WD789 cell 5
; (CopyRecordNameToNameGlyphBuf, C = 1) and draws its glyphs at vTiles1 + $780 (E-0120)
DrawListEntriesCell5RecordNameAtTiles1780::
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    ld de, vTiles1 + $780
    call CopyGlyphTilesToVRAM
    xor a
    ld [rRAMG2], a
    ld [rRAMB], a
    ret

EggServiceMenu_Bank1B_PickRecords_SetArg5ToListEntriesCell5::
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld de, wPickedRecords
    ld a, [wPickCount]
    add e
    ld e, a
    jr nc, .done
    inc d

.done:
    ld a, [hl]
    ld [de], a
    ret

EggServiceMenu_Bank1B_PickRecords_WriteScreenStepAndRAMG2Etc::
    ld a, [wPickCount]
    cp $03
    jp z, .return_FF
    ld a, [wLinkRules + $5]
    bit 7, a
    jr z, .check_link_rules
    bit 6, a
    jr nz, .call_set_arg5_to_list_entries_cell5
    ld a, [wPickCount]
    inc a
    ld b, a
    ld c, $00
    ld de, $0000

.loop:
    push bc
    push de
    ld a, c
    ld c, $56
    call EggServiceMenu_Bank1B_PickRecords_LoadSRAMRecordByte
    pop de
    ldh a, [hTemp0]
    add e
    ld e, a
    ld a, d
    adc $00
    ld d, a
    pop bc
    inc c
    dec b
    jr nz, .loop
    ld a, [wLinkRules + $5]
    and $01
    ld h, a
    ld a, [wLinkRules + $4]
    ld l, a
    ld a, h
    cp d
    jr c, .call_show_string_a10_bank1_b
    jr z, .skip
    jr .check_link_rules

.skip:
    ld a, l
    cp e
    jr c, .call_show_string_a10_bank1_b
    jr .check_link_rules

.call_set_arg5_to_list_entries_cell5:
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    ld c, MON_LEVEL
    call LoadSRAMRecordByte
    xor a
    ld [rRAMG2], a
    ld [rRAMG], a
    ld a, [wLinkRules + $3]
    ld b, a
    ldh a, [hTemp0]
    cp b
    jr c, .check_link_rules
    jr z, .check_link_rules

.call_show_string_a10_bank1_b:
    ld a, $11 ; 'Monster level limit exceeded. Pick another'
    call ShowStringA10_Bank1B
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    xor a
    ret

.check_link_rules:
    ld a, [wLinkRules + $6]
    bit 7, a
    jr z, .return_FF
    ld a, [wLinkRules + $7]
    bit 0, a
    jr nz, .call_egg_service_menu_bank1_b_pick_records
    ld a, [wPickCount]
    ld c, $0d
    call EggServiceMenu_Bank1B_PickRecords_LoadSRAMRecordByte
    ldh a, [hTemp0]
    and $0f
    sla a
    ld de, EggServiceMenu_Bank1B_PickRecords_WriteScreenStepAndRAMG2Etc_Data
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld bc, wLinkRules + $6
    ld a, [bc]
    and h
    jr nz, .call_show_string_a10_bank1_b2
    inc bc
    ld a, [bc]
    and l
    jr z, .return_FF

.call_show_string_a10_bank1_b2:
    ld a, $12 ; 'That family is not permitted.'
    call ShowStringA10_Bank1B
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    xor a
    ret

.call_egg_service_menu_bank1_b_pick_records:
    call EggServiceMenu_Bank1B_PickRecords_Shared02_WriteRAMG2AndRAMB
    cp $ff
    jr nz, .return_FF
    ld a, $13 ; 'You already chose from that family.'
    call ShowStringA10_Bank1B
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    xor a
    ret

.return_FF:
    ld a, $ff
    ret

; copies the name of the record at WD789 cell 5 (11 bytes) to wTextBuf0 (E-0124)
CopyListEntriesCell5NameToTextBuf0::
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
    ld b, $0b

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    xor a
    ld [rRAMB], a
    ld [rRAMG], a
    ret

; pads wPickedRecords, wSelectedRecord = wPickCount, wPackWork = $FF, wPickCount = 4, clears
; wScreenStep/wScreenSubStep and wScreenState += 1 (E-0122)
FinishPickedRecordsEntryAndAdvance::
    call PadPickedRecordsWithFFToThree
    ld a, [wPickCount]
    ld [wSelectedRecord], a
    ld a, $ff
    ld [wPackWork], a
    ld a, $04
    ld [wPickCount], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 5 x 1 tiles, one row per line
TileRect_1B_7738::
    db $b1, $b1, $b1, $b1, $b2 ; id 0

; record: 13 x 2 tiles, one row per line
TileRect_1B_773D::
    db $b6, $ea, $ed, $c3, $c3, $f8, $f9, $fa, $fb, $fc, $c3, $c7, $b7 ; id 0
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 1

; record: 10 x 7 tiles, one row per line
TileRect_1B_7757::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $e1, $ed, $11, $12, $13, $14, $15, $10, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $e2, $ed, $17, $18, $19, $1a, $1b, $16, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $e3, $ed, $1d, $1e, $1f, $20, $21, $1c, $b7 ; id 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 6

; record: 10 x 9 tiles, one row per line
TileRect_1B_779D::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $e1, $ed, $11, $12, $13, $14, $15, $10, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $e2, $ed, $17, $18, $19, $1a, $1b, $16, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $e3, $ed, $1d, $1e, $1f, $20, $21, $1c, $b7 ; id 5
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; id 6
    db $b6, $c3, $c3, $23, $24, $25, $26, $27, $22, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 5 tiles, one row per line
TileRect_1B_77F7::
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $b2, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 2
    db $b7, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $b5, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 4

TileRect_1B_781F::
    db $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $b2, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 2
    db $b7, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $b5, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 4

TileRect_1B_7847::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $70, $71, $72, $73, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $74, $75, $c3, $c3, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

EggServiceMenu_Bank1B_PickRecords_SetDefaultStringWindow_Bank1B_Data::
    db $79, $c3, $a1, $c3, $c9, $c3, $f1, $c3, $19, $c4

EggServiceMenu_Bank1B_PickRecords_WriteScreenStepAndRAMG2Etc_Data::
    db $00, $40, $00, $20, $00, $10, $00, $08, $00, $04, $00, $02, $00, $01, $80, $00
    db $40, $00, $20, $00, $10, $00

; record: 6 x 5 tiles, one row per line
TileRect_1B_788F::
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 2
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 4

TileRect_1B_78AD::
    db $b4, $b4, $b4, $b4, $b4, $b5 ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 2
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 4

TileRect_1B_78CB::
    db $b0, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $76, $77, $78, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $79, $73, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; id 4

; record: 9 x 7 tiles, one row per line
TileRect_1B_78E9::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $30, $31, $32, $33, $34, $35, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $36, $37, $38, $39, $3a, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $3b, $3c, $3d, $3e, $c3, $c3, $b7 ; id 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 6

; record: 8 x 11 tiles, one row per line
TileRect_1B_7928::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $d5, $d6, $d7, $d8, $d9, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $da, $db, $dc, $dd, $de, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $f0, $f1, $f2, $f3, $f4, $b7 ; id 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 8
    db $b6, $c3, $a4, $a5, $a6, $ce, $cf, $b7 ; id 9
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 10
    ds $680, $00
