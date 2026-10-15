; ROM bank $1B: link key exchange, egg service, link screens
; The annotated listing of this bank is build/listing/bank1b.asm.

SECTION "Bank 1B", ROMX[$4000], BANK[$1B]
    db $1b

; Runs one step of the link, called from SerialInterruptHandler (the serial interrupt) with every
; register saved by the handler. If bit 7 of wLinkStatus is set it sets bit 6 and returns; otherwise
; it dispatches on wLinkSession: 0 RunLinkSession_FindPartner (taken directly for 0), 1
; RunLinkSession_Battle, 2 RunLinkSession_Breeding, 3 RunLinkSession_KeyTrade, 4
; RunLinkSession_BattleSetup, 5 RunLinkSession_WonderlandBreeding, 6 RunLinkSession_TeamMode, 7
; RunLinkSession_BattleWhenTextIdle, 8 RunLinkSession_EggExchange. Sessions 1-8 each run their
; exchange routine (RunLinkSession1Exchange to RunLinkSession8Exchange) only while wLinkMode is
; non-zero and bit 0 of wLinkRole is set. The table entries are the wrappers RunLinkSession_Battle
; to RunLinkSession_EggExchange, not the exchange routines themselves, as an earlier comment said.
; (C1, E-0379)
; unless wLinkStatus bit 7 is set (then it sets bit 6 and returns), runs the routine for
; wLinkSession (0: wait for the serial transfer; 1-8: RunLinkSession1Exchange to
; RunLinkSession8Exchange when wLinkMode is set and wLinkRole bit 0 is set); called from
; ComputeSpriteScrollOffsets (E-0259)
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
    jr z, RunLinkSession_FindPartner
    ld a, [wLinkSession]
    jumptable
    dw RunLinkSession_FindPartner
    dw RunLinkSession_Battle
    dw RunLinkSession_Breeding
    dw RunLinkSession_KeyTrade
    dw RunLinkSession_BattleSetup
    dw RunLinkSession_WonderlandBreeding
    dw RunLinkSession_TeamMode
    dw RunLinkSession_BattleWhenTextIdle
    dw RunLinkSession_EggExchange

; Link session 0, finding a partner: waits for the serial byte and reads the partner's choice. A
; leader code ($F5, $F6, $B7, $DC, $E0, or $F1 with wLinkSetting) or a follower code ($FA, $FB, $FC,
; $DD, $E1, $F3, only in title sub-state 2 and when it differs from wLinkTimerLo) names link option
; 2-7; when this side's menu stands on the same option it takes the link role (bit 0, bit 1 for a
; leader code) and starts the link: sound $69, link mode 1 (2 for option 6), game mode 5 with the
; option's state and the link session (5, 2, 3, 8, 4 or 6; option 7 first reloads the save,
; RunLoadGameSteps); otherwise it notes the partner's option or a mismatch ($FF). Always sets
; wLinkStatus 3 and sends $F8. Eight unreached bytes sit inside it. (C1, E-0357)
RunLinkSession_FindPartner::
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
    ld a, [wLinkSetting]
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
    farcall RunLoadGameSteps
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

; Zeroes the first two bytes of each of the six sound channel slots (wSoundChannelSlots,
; wSoundChannel1 to wSoundChannel5, $20 bytes apart) and leaves the other bytes alone. Called only
; by RunLinkSession_FindPartner, right after it requests the game mode change into the link session.
; (C2, E-0379)
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

; Busy-waits $80 passes of a loop that takes BC down by 2 each pass (BC starts at $0100), then
; returns with BC as it was, A = 0 and Z set. Called by RunLinkSession_FindPartner after it accepts
; a follower code and before it stores the code in wScreenState. (C2, E-0379)
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

; A = the byte received from the partner (a leader code in the callers); it is stored in
; wScreenCounter and kept in C. Returns A = 0 only when wGameMode is 5, wModeState is 1,
; wTitleScreenState is 0, wLinkScreenFlag is 0 and wTitleScreenSubState is 1; otherwise A = $FF. A
; match of the byte with wLinkTimerLo stops it with $FF when wTitleScreenSubState is not 1, which
; the final test would give anyway. Called six times by RunLinkSession_FindPartner, once per leader
; code. (C2, E-0379)
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

; Sends the byte at SendLinkByteForMenuOption_Bank1B_Data + (wMenuOption AND $0F) with
; SerialSendByte (external clock). The table holds $F4, $F4, $FA, $FB, $FC, $DD, $E1, $F3 for
; options 0-7; options 2-7 give exactly the follower codes that RunLinkSession_FindPartner matches
; against wMenuState 2-7. The index is masked to 4 bits, not limited to the 8 entries. No call, jump
; or pointer to it was found in src/. (C1, E-0379)
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

; Eight bytes $F4, $F4, $FA, $FB, $FC, $DD, $E1, $F3: the link byte sent for menu option 0 to 7.
; SendLinkByteForMenuOption_Bank1B sends the entry numbered wMenuOption AND $0F with SerialSendByte;
; the mask also allows indexes 8 to 15, which fall past the table. The bytes equal
; SendLinkByteForMenuOption_Data in the title code, and no call to this copy was found. (C1, E-0381)
SendLinkByteForMenuOption_Bank1B_Data::
    db $f4, $f4, $fa, $fb, $fc, $dd, $e1, $f3

; Link session 1 (battle): while linked as the active role runs its exchange. (C1, E-0357)
RunLinkSession_Battle::
    ld a, [wLinkMode]
    or a
    jr z, .return
    ld a, [wLinkRole]
    bit 0, a
    jr z, .return
    call RunLinkSession1Exchange

.return:
    ret

; Jumptable on wLinkExchangeState: 0 RunLinkSession1Exchange_Send (the send half), 1
; RunLinkSession1Exchange_Receive (the receive half). The send half sets the state to 1 once it has
; started a transfer and the receive half sets it back to 0, so successive serial interrupts
; alternate between the two. Called only by RunLinkSession_Battle (link session 1); its receive half
; runs RunBattlePhase. (C1, E-0379)
; runs the routine for wLinkExchangeState (jump table of two) (E-0122)
RunLinkSession1Exchange::
    ld a, [wLinkExchangeState]
    jumptable
    dw RunLinkSession1Exchange_Send
    dw RunLinkSession1Exchange_Receive

; Link session 1, exchange state 0: sends one byte (LinkSendStepWithBuffer). (C1, E-0357)
RunLinkSession1Exchange_Send::
    call LinkSendStepWithBuffer
    ret

; Link session 1, exchange state 1: receives one byte; then, unless the resync flag (wVBlankFlags
; bit 7) was set, runs a frame and the battle phase (RunBattlePhase). (C1, E-0357)
RunLinkSession1Exchange_Receive::
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

; Link session 2: while linked as the active role runs its exchange. (C1, E-0357)
RunLinkSession_Breeding::
    ld a, [wLinkMode]
    or a
    jr z, .return
    ld a, [wLinkRole]
    bit 0, a
    jr z, .return
    call RunLinkSession2Exchange

.return:
    ret

; Jumptable on wLinkExchangeState: 0 RunLinkSession2Exchange_Send, 1
; RunLinkSession2Exchange_Receive; the two halves alternate, the send half leaving the state at 1
; and the receive half at 0. Called only by RunLinkSession_Breeding (link session 2); its receive
; half runs RunScreenStateWhenNotFading_F1. (C1, E-0379)
; runs the routine for wLinkExchangeState (jump table of two) (E-0122)
RunLinkSession2Exchange::
    ld a, [wLinkExchangeState]
    jumptable
    dw RunLinkSession2Exchange_Send
    dw RunLinkSession2Exchange_Receive

; Link session 2, exchange state 0: sends one byte. (C1, E-0357)
RunLinkSession2Exchange_Send::
    call LinkSendStepWithBuffer
    ret

; Link session 2, exchange state 1: receives one byte, then runs a frame and the session's screen
; (RunScreenStateWhenNotFading_F1). (C1, E-0357)
RunLinkSession2Exchange_Receive::
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

; Link session 3 (the key trade): while linked as the active role runs its exchange. (C1, E-0357)
RunLinkSession_KeyTrade::
    ld a, [wLinkMode]
    or a
    jr z, .return
    ld a, [wLinkRole]
    bit 0, a
    jr z, .return
    call RunLinkSession3Exchange

.return:
    ret

; Jumptable on wLinkExchangeState: 0 RunLinkSession3Exchange_Send, 1
; RunLinkSession3Exchange_Receive; the two halves alternate, the send half leaving the state at 1
; and the receive half at 0. Called only by RunLinkSession_KeyTrade (link session 3); its receive
; half runs RunScreenStateWhenNotFading_1B, the key trade screens. (C1, E-0379)
; runs the routine for wLinkExchangeState (jump table of two) (E-0122)
RunLinkSession3Exchange::
    ld a, [wLinkExchangeState]
    jumptable
    dw RunLinkSession3Exchange_Send
    dw RunLinkSession3Exchange_Receive

; Link session 3, exchange state 0: sends one byte. (C1, E-0357)
RunLinkSession3Exchange_Send::
    call LinkSendStepWithBuffer
    ret

; Link session 3, exchange state 1: receives one byte, then runs a frame and the session's screen
; (RunScreenStateWhenNotFading_1B). (C1, E-0357)
RunLinkSession3Exchange_Receive::
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

; Link session 4: while linked as the active role runs its exchange. (C1, E-0357)
RunLinkSession_BattleSetup::
    ld a, [wLinkMode]
    or a
    jr z, .return
    ld a, [wLinkRole]
    bit 0, a
    jr z, .return
    call RunLinkSession4Exchange

.return:
    ret

; Jumptable on wLinkExchangeState: 0 RunLinkSession4Exchange_Send, 1
; RunLinkSession4Exchange_Receive; the two halves alternate, the send half leaving the state at 1
; and the receive half at 0. Called only by RunLinkSession_BattleSetup (link session 4); its receive
; half runs RunLinkSession4ScreenState. (C1, E-0379)
; runs the routine for wLinkExchangeState (jump table of two) (E-0122)
RunLinkSession4Exchange::
    ld a, [wLinkExchangeState]
    jumptable
    dw RunLinkSession4Exchange_Send
    dw RunLinkSession4Exchange_Receive

; Link session 4, exchange state 0: sends one byte. (C1, E-0357)
RunLinkSession4Exchange_Send::
    call LinkSendStepWithBuffer
    ret

; Link session 4, exchange state 1: receives one byte, then runs a frame and the session's screen
; (RunLinkSession4ScreenState). (C1, E-0357)
RunLinkSession4Exchange_Receive::
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

; Link session 5: while linked as the active role runs its exchange. (C1, E-0357)
RunLinkSession_WonderlandBreeding::
    ld a, [wLinkMode]
    or a
    jr z, .return
    ld a, [wLinkRole]
    bit 0, a
    jr z, .return
    call RunLinkSession5Exchange

.return:
    ret

; Jumptable on wLinkExchangeState with two entries: 0 RunLinkSession5Exchange_Send, 1
; RunLinkSession5Exchange_Receive; the two halves alternate, the send half leaving the state at 1
; and the receive half at 0. Called only by RunLinkSession_WonderlandBreeding (link session 5); its
; receive half runs RunLinkSession5Exchange_RunScreen. An earlier comment said entries 2-3 belong to
; session 6; the table has only two entries and session 6 has its own RunLinkSession6Exchange. (C1,
; E-0379)
; link sessions 5 and 6 (RunLinkSession): by wLinkExchangeState it sends and receives one exchange
; of the session's buffer; entries 2-3 are session 6's; the screens it runs show record stats and
; link breeding (E-0354; was: runs the routine for wLinkExchangeState (jump table of two) (E-0122))
RunLinkSession5Exchange::
    ld a, [wLinkExchangeState]
    jumptable
    dw RunLinkSession5Exchange_Send
    dw RunLinkSession5Exchange_Receive

; Link session 5, exchange state 0: sends one byte. (C1, E-0357)
RunLinkSession5Exchange_Send::
    call LinkSendStepWithBuffer
    ret

; Link session 5, exchange state 1: receives one byte, then runs a frame and the session's screen.
; (C1, E-0357)
RunLinkSession5Exchange_Receive::
    call LinkReceiveStepWithBuffer
    ld hl, wVBlankFlags
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call RunFrameTickFadeAndCounter_Bank1B
    farcall RunLinkSession5Exchange_RunScreen
    ld hl, wVBlankFlags
    res 1, [hl]
    ret

; Link session 6: while linked as the active role runs its exchange. (C1, E-0357)
RunLinkSession_TeamMode::
    ld a, [wLinkMode]
    or a
    jr z, .return
    ld a, [wLinkRole]
    bit 0, a
    jr z, .return
    call RunLinkSession6Exchange

.return:
    ret

; Jumptable on wLinkExchangeState: 0 RunLinkSession6Exchange_Send, 1
; RunLinkSession6Exchange_Receive; the two halves alternate, the send half leaving the state at 1
; and the receive half at 0. Called only by RunLinkSession_TeamMode (link session 6); its receive
; half runs TeamMode_Screen. (C1, E-0379)
; runs the routine for wLinkExchangeState (jump table of two) (E-0122)
RunLinkSession6Exchange::
    ld a, [wLinkExchangeState]
    jumptable
    dw RunLinkSession6Exchange_Send
    dw RunLinkSession6Exchange_Receive

; Link session 6, exchange state 0: sends one byte. (C1, E-0357)
RunLinkSession6Exchange_Send::
    call LinkSendStepWithBuffer
    ret

; Link session 6, exchange state 1: receives one byte, then runs a frame and the session's screen.
; (C1, E-0357)
RunLinkSession6Exchange_Receive::
    call LinkReceiveStepWithBuffer
    ld hl, wVBlankFlags
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call RunFrameTickFadeAndCounter_Bank1B
    farcall TeamMode_Screen
    ld hl, wVBlankFlags
    res 1, [hl]
    ret

; Link session 7 (battle): while linked as the active role runs its exchange. (C1, E-0357)
RunLinkSession_BattleWhenTextIdle::
    ld a, [wLinkMode]
    or a
    jr z, .return
    ld a, [wLinkRole]
    bit 0, a
    jr z, .return
    call RunLinkSession7Exchange

.return:
    ret

; Jumptable on wLinkExchangeState: 0 RunLinkSession7Exchange_Send, 1
; RunLinkSession7Exchange_Receive; the two halves alternate, the send half leaving the state at 1
; and the receive half at 0. Called only by RunLinkSession_BattleWhenTextIdle (link session 7); its
; receive half runs RunBattlePhaseWhenTextIdle_A0. (C1, E-0379)
; runs the routine for wLinkExchangeState (jump table of two) (E-0122)
RunLinkSession7Exchange::
    ld a, [wLinkExchangeState]
    jumptable
    dw RunLinkSession7Exchange_Send
    dw RunLinkSession7Exchange_Receive

; Link session 7, exchange state 0: sends one byte. (C1, E-0357)
RunLinkSession7Exchange_Send::
    call LinkSendStepWithBuffer
    ret

; Link session 7, exchange state 1: receives one byte, then runs a frame and the battle phase while
; text is idle (RunBattlePhaseWhenTextIdle_A0). (C1, E-0357)
RunLinkSession7Exchange_Receive::
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

; Link session 8: while linked as the active role runs its exchange. (C1, E-0357)
RunLinkSession_EggExchange::
    ld a, [wLinkMode]
    or a
    jr z, .return
    ld a, [wLinkRole]
    bit 0, a
    jr z, .return
    call RunLinkSession8Exchange

.return:
    ret

; Jumptable on wLinkExchangeState: 0 RunLinkSession8Exchange_Send, 1
; RunLinkSession8Exchange_Receive; the two halves alternate, the send half leaving the state at 1
; and the receive half at 0. Called only by RunLinkSession_EggExchange (link session 8); its receive
; half runs RunLinkSession8Exchange_Receive_DreamEggScreen. (C1, E-0379)
; link session 8 (RunLinkSession runs it each frame while linked): by wLinkExchangeState it sends
; (0, LinkSendStepWithBuffer) and receives (1, LinkReceiveStepWithBuffer) one exchange of the
; session's buffer; the receive side runs the session's screens (LinkRecordScreen, the egg scene of
; GameMode6_Update) (E-0354; was: runs the routine for wLinkExchangeState (jump table of two)
; (E-0122))
RunLinkSession8Exchange::
    ld a, [wLinkExchangeState]
    jumptable
    dw RunLinkSession8Exchange_Send
    dw RunLinkSession8Exchange_Receive

; Link session 8, exchange state 0: sends one byte. (C1, E-0357)
RunLinkSession8Exchange_Send::
    call LinkSendStepWithBuffer
    ret

; Link session 8, exchange state 1: receives one byte, then runs a frame and the session's screen.
; (C1, E-0357)
RunLinkSession8Exchange_Receive::
    call LinkReceiveStepWithBuffer
    ld hl, wVBlankFlags
    bit 7, [hl]
    res 7, [hl]
    ret nz
    call RunFrameTickFadeAndCounter_Bank1B
    farcall RunLinkSession8Exchange_Receive_DreamEggScreen
    ld hl, wVBlankFlags
    res 1, [hl]
    ret

; Joypad exchange, send half (the same shape as LinkSendStepWithBuffer without the buffer). If bit 1
; of wLinkRole is clear it sets wLinkExchangeState = 1 and arms $F9 with SerialSendByte. Otherwise,
; if bit 1 of wVBlankFlags is set it continues at LinkExchangeJoypadByte_SendResync; if not, it
; takes the received byte from rSB into wSerialReceived and wLinkJoypadHeld (the old value to
; wLinkJoypadHeldPrev), polls the local pad (PollJoypad, UpdateJoypadPresses), sets
; wLinkExchangeState = 1 and starts a transfer of wJoypadHeld with the internal clock. No call, jump
; or pointer to it was found in src/. (C1, E-0379)
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
    jr nz, LinkExchangeJoypadByte_SendResync
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

; Joypad exchange, after a short wait: sets wVBlankFlags bit 2, exchange state 1 and sends $F3 (the
; resync byte). (C1, E-0357)
LinkExchangeJoypadByte_SendResync::
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

; Joypad exchange, receive half. If bit 1 of wLinkRole is set it continues at
; LinkHandshakeSendFAOrFB. Otherwise it reads the received byte from rSB into wSerialReceived; when
; wLinkReady is zero and the byte is $F3 it continues at LinkReceiveJoypadByte_Resync. It then sets
; bit 1 of wVBlankFlags, stores the byte as wLinkJoypadHeld (the old value to wLinkJoypadHeldPrev),
; runs UpdateJoypadPresses and RunFrameTickFadeAndCounter_Bank1B, sets wLinkExchangeState = 0 and
; clears bit 1 of wVBlankFlags. No call, jump or pointer to it was found in src/. (C1, E-0379)
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
    jp z, LinkReceiveJoypadByte_Resync
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

; Joypad exchange, the $F3 resync: restores the saved joypad state; when no byte was queued ($FF)
; counts down the link timeout; back to exchange state 0 with the resync flag (bit 7). (C2, E-0357;
; probed E-0379)
LinkReceiveJoypadByte_Resync::
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

; Receive-side handshake used when bit 1 of wLinkRole is set. If bit 2 of wVBlankFlags is clear it
; sets bit 1 of wVBlankFlags, wLinkExchangeState = 0, arms $FA with SerialSendByte, runs
; RunFrameTickFadeAndCounter_Bank1B and clears bit 1 again; if bit 2 is set it continues at
; LinkHandshakeSendFAOrFB_SendFB. Reached only by a jump from LinkReceiveJoypadByte, which has no
; caller in src/. (C1, E-0379)
; link: with bit 2 of wVBlankFlags clear sends $FA and runs a frame; otherwise clears it, sends $FB
; and sets bit 7 (E-0124)
LinkHandshakeSendFAOrFB::
    ld hl, wVBlankFlags
    bit 2, [hl]
    jr nz, LinkHandshakeSendFAOrFB_SendFB
    set 1, [hl]
    xor a
    ld [wLinkExchangeState], a
    ld a, $fa
    call SerialSendByte
    call RunFrameTickFadeAndCounter_Bank1B
    ld hl, wVBlankFlags
    res 1, [hl]
    ret

; Handshake, the second half: clears wVBlankFlags bit 2, sends $FB and sets the resync flag. (C1,
; E-0357)
LinkHandshakeSendFAOrFB_SendFB::
    ld hl, wVBlankFlags
    res 2, [hl]
    xor a
    ld [wLinkExchangeState], a
    ld a, $fb
    call SerialSendByte
    ld hl, wVBlankFlags
    set 7, [hl]
    ret

; Send half of the link exchange, shared by the send halves of the eight session exchanges
; (RunLinkSession1Exchange_Send to RunLinkSession8Exchange_Send). If bit 1 of wLinkRole is clear it
; sets wLinkExchangeState = 1 and arms $F9 with SerialSendByte. Otherwise, with bit 1 of
; wVBlankFlags set it continues at LinkExchangeJoypadByte_SendResync (sends $F3). Else it takes the
; byte received in rSB into wSerialReceived and wLinkMessage, polls the pad (PollJoypad,
; UpdateJoypadPresses), sets wLinkExchangeState = 1 and starts an internal-clock transfer of:
; wLinkSendByte when it is not $FF; else, while the 16-bit count wLinkBufferCountLo/Hi is non-zero,
; the byte at the address held in wLinkTimeoutLo/Hi (which is advanced by 1), after storing the byte
; just received at wLinkBufferPtrLo/Hi and moving that pointer up and the count down; else $F0. (C1,
; E-0379)
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
    jp nz, LinkExchangeJoypadByte_SendResync
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

; Receive half of the link exchange, shared by the receive halves of the eight session exchanges
; (RunLinkSession1Exchange_Receive to RunLinkSession8Exchange_Receive). If bit 1 of wLinkRole is set
; it continues at LinkHandshakeSendFAOrFB_SendFB when bit 2 of wVBlankFlags is set, else sets bit 1
; of wVBlankFlags, wLinkExchangeState = 0 and arms $FA. If bit 1 is clear it reads rSB into
; wSerialReceived (when wLinkReady is zero and the byte is $F3 it continues at
; LinkReceiveJoypadByte_Resync), sets bit 1 of wVBlankFlags, and then: with wLinkSendByte not $FF or
; no bytes left in wLinkBufferCountLo/Hi it stores the byte in wLinkMessage; otherwise it stores it
; at wLinkBufferPtrLo/Hi and moves that pointer up and the count down. It calls UpdateJoypadPresses
; and sets wLinkExchangeState = 0 in all those cases. (C1, E-0379)
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
    jp z, LinkReceiveJoypadByte_Resync
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
    jp nz, LinkHandshakeSendFAOrFB_SendFB
    set 1, [hl]
    xor a
    ld [wLinkExchangeState], a
    ld a, $fa
    call SerialSendByte
    ret

; Runs one frame of the screen work for the link: calls StepTextPrinter when wTextFlags is non-zero,
; then StepFade; adds 1 to the 16-bit wFrameCounterLo/Hi and zeroes wLinkFrameCounterLo/Hi. Called
; by the receive half of every link session and by LinkReceiveJoypadByte and
; LinkHandshakeSendFAOrFB. (C1, E-0379)
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

; While bit 7 of rSC (a transfer in progress) is set, adds 1 to the 16-bit counter
; wScreenCounter/wGlyphListPos and tests it; if the high byte reaches 4 it returns A = $FE,
; otherwise it returns when the transfer ends. No call, jump or pointer to it was found in src/
; outside itself. (C1, E-0379)
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

; DE = BeginStringDisplay_Bank1B_StringCategories (the first string table of this bank: texts of the
; key trade, team battle and battle prize screens), then BeginStringDisplay starts the string chosen
; by wStringCategory and wStringIndex. Far-called by BeginString_Bank1B_Cat0, ShowStringA10_Bank1B
; and ShowStringA10_Bank33, and by the debug message test. (C1, E-0379)
; ld de, this bank's string table / BeginStringDisplay (E-0344: the address in its name dropped or
; read as the label there; was BeginStringDisplay_Bank1B)
BeginStringDisplay_Bank1B::
    ld de, BeginStringDisplay_Bank1B_StringCategories
    call BeginStringDisplay
    ret
    db $11, $21, $48, $cd, $fe, $25, $c9

; BeginStringDisplay_Bank1B, then RunStringDisplayToEnd, so the whole string chosen by
; wStringCategory and wStringIndex is printed at once in the window set by wTextWindowTileLo/Hi,
; wTextWindowRows and wTextWindowWidth. Far-called by LinkKeyTrade_BuildKeyList,
; LinkKeyTrade_ShowKeyName, LinkBattleSetupMenu_ShowBattlePrizeExit, EggServiceMenu_ShowInfoOKChoice
; and other egg service menu steps, and the bank-$33 link screens. (C1, E-0379)
; BeginStringDisplay_Bank1B (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; (E-0344: the address in its name dropped or read as the label there; was ShowString_Bank1B)
ShowString_Bank1B::
    call BeginStringDisplay_Bank1B
    call RunStringDisplayToEnd
    ret

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
BeginStringDisplay_Bank1B_StringCategories::
    dw StringList_Bank1B_StringCategories_0 ; id 0

; category list of BeginStringDisplay_Bank1B_StringCategories; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank1B_StringCategories_0::
    dw Text_StartingKeyTrade ; id 0
    dw Text_StartingKeyTrade ; id 1
    dw Text_YouRefusedToTrade ; id 2
    dw Text_YourPalRefusedTo ; id 3
    dw Text_IsItOKTo_2 ; id 4
    dw Text_ThatKeyCannotBe ; id 5
    dw Text_PleaseChooseTheKey ; id 6
    dw Text_PleaseWait_2 ; id 7
    dw Text_KeysCantHaveThe ; id 8
    dw Text_IsItOKTo_3 ; id 9
    dw Text_IsItOKTo_4 ; id 10
    dw Text_ReadyingTradePleaseWait ; id 11
    dw Text_KeysWillNowBe ; id 12
    dw Text_YourPalHasA ; id 13
    dw Text_TradeExit ; id 14
    dw Text_YouCantHoldAny ; id 15
    dw Text_ChooseTheMembersFor ; id 16
    dw Text_ChooseTheMembersFor ; id 17
    dw Text_PickForTheTeam ; id 18
    dw Text_ChooseOneMoreMember ; id 19
    dw Text_WillYouPutUp ; id 20
    dw Text_YouHaveNoMonsters ; id 21
    dw Text_SelectAMonsterAs ; id 22
    dw Text_PutUpAsA ; id 23
    dw Text_BeginBattle ; id 24
    dw Text_StartingBattle ; id 25
    dw Text_YouRefusedToBattle ; id 26
    dw Text_YourPalRefusedTo_2 ; id 27
    dw Text_PleaseWait_3 ; id 28
    dw Text_InfoOKYesN ; id 29
    dw Text_InfoOKYesN ; id 30
    dw Text_BattlePrizeExit ; id 31
    dw Text_FightInfoEx ; id 32
    dw Text_MonsterLevelLimitExceeded ; id 33
    dw Text_ThatFamilyIsNot ; id 34
    dw Text_YouAlreadyChoseFrom ; id 35
    dw Text_ThereIsNoPrize ; id 36
    dw Text_ThereIsNoPrize_2 ; id 37
    dw Text_YourPalsKeyRing ; id 38
    dw Text_Empty ; id 39

Text_StartingKeyTrade::
    db "Starting key<LINE>"
    db "trade…<PROMPT>"
    db "@"

Text_YouRefusedToTrade::
    db "You refused to<LINE>"
    db "trade keys.<PROMPT>"
    db "@"

Text_YourPalRefusedTo::
    db "Your pal refused<LINE>"
    db "to trade keys.<PROMPT>"
    db "@"

Text_IsItOKTo_2::
    db "Is it OK to trade<LINE>"
    db "this key?@"

Text_ThatKeyCannotBe::
    db "That key cannot be<LINE>"
    db "traded.<WAIT>"
    db "@"

Text_PleaseChooseTheKey::
    db "Please choose the<LINE>"
    db "key to trade.@"

Text_PleaseWait_2::
    db "Please wait.@"

Text_KeysCantHaveThe::
    db "Keys can't have<LINE>"
    db "the same name.<WAIT>"
    db "@"

Text_IsItOKTo_3::
    db "Is it OK to trade<LINE>"
    db "keys?@"

Text_IsItOKTo_4::
    db "Is it OK to record<LINE>"
    db "the results?@"

Text_ReadyingTradePleaseWait::
    db "Readying trade…<LINE>"
    db "Please wait.@"

Text_KeysWillNowBe::
    db "Keys will now be<LINE>"
    db "traded.<WAIT>"
    db "@"

Text_YourPalHasA::
    db "Your pal has a key<LINE>"
    db "of the same name.<WAIT>"
    db "@"

Text_TradeExit::
    db "TradeExit@"

Text_YouCantHoldAny::
    db "You can't hold any<LINE>"
    db "more keys.<WAIT>"
    db "@"

Text_ChooseTheMembersFor::
    db "Choose the members<LINE>"
    db "for VS battle.@"

Text_PickForTheTeam::
    db "Pick <BUF0> for the<LINE>"
    db "team?@"

Text_ChooseOneMoreMember::
    db "Choose one more<LINE>"
    db "member for battle?@"

Text_WillYouPutUp::
    db "Will you put up a<LINE>"
    db "prize?@"

Text_YouHaveNoMonsters::
    db "You have no<LINE>"
    db "monsters on the<PROMPT>"
    db "<NEXT>farm to serve as"
    db "<NEXT>the prize.<WAIT>"
    db "@"

Text_SelectAMonsterAs::
    db "Select a monster<LINE>"
    db "as the prize.@"

Text_PutUpAsA::
    db "Put up <BUF0> as a<LINE>"
    db "prize?@"

Text_BeginBattle::
    db "Begin battle?@"

Text_StartingBattle::
    db "Starting battle…@"

Text_YouRefusedToBattle::
    db "You refused to<LINE>"
    db "battle.@"

Text_YourPalRefusedTo_2::
    db "Your pal refused<LINE>"
    db "to battle.@"

Text_PleaseWait_3::
    db "Please wait.@"

Text_InfoOKYesN::
    db "InfoOKYesN@"

Text_BattlePrizeExit::
    db "BattlePrizeExit@"

Text_FightInfoEx::
    db "FightInfoEx@"

Text_MonsterLevelLimitExceeded::
    db "Monster level<LINE>"
    db "limit exceeded.<PROMPT>"
    db "<NEXT>Pick another"
    db "<NEXT>monster please.@"

Text_ThatFamilyIsNot::
    db "That family is not<LINE>"
    db "permitted.@"

Text_YouAlreadyChoseFrom::
    db "You already chose<LINE>"
    db "from that family.<PROMPT>"
    db "<NEXT>Pick another"
    db "<NEXT>monster please.@"

Text_ThereIsNoPrize::
    db "There is no prize<LINE>"
    db "for this battle.@"

Text_ThereIsNoPrize_2::
    db "There is no prize.@"

Text_YourPalsKeyRing::
    db "Your pal's key ring<LINE>"
    db "is full.<PROMPT>"
    db "<NEXT>Keys can't be"
    db "<NEXT>traded.<WAIT>"
    db "@"

Text_Empty::
    db $f9, $00, $f0

; DE = BeginBreedingStringDisplay_StringCategories (the second string table of this bank: the
; breeding and egg texts such as 'Welcome. What would you like?'), then BeginStringDisplay starts
; the string chosen by wStringCategory and wStringIndex. Far-called by
; BreedMenu_ChooseParents_ShowLinkPrompt, BreedMenu_ChooseParents_Breed and the debug message test.
; (C1, E-0379)
; ld de, this bank's string table / BeginStringDisplay (E-0344: the address in its name dropped or
; read as the label there; was BeginBreedingStringDisplay)
BeginBreedingStringDisplay::
    ld de, BeginBreedingStringDisplay_StringCategories
    call BeginStringDisplay
    ret
    db $11, $9b, $4c, $cd, $fe, $25, $c9

; BeginBreedingStringDisplay, then RunStringDisplayToEnd, so the whole string of the second string
; table of this bank is printed at once in the window set by wTextWindowTileLo/Hi, wTextWindowRows
; and wTextWindowWidth. Far-called by BreedMenu_RedrawListScreen_ShowEggFee, ShowSaveFileInfoWindow
; and DebugResultsDisplay_Init. (C1, E-0379)
; BeginBreedingStringDisplay (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; (E-0344: the address in its name dropped or read as the label there; was ShowBreedingString)
ShowBreedingString::
    call BeginBreedingStringDisplay
    call RunStringDisplayToEnd
    ret

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
BeginBreedingStringDisplay_StringCategories::
    dw StringList_1B ; id 0

; category list of BeginBreedingStringDisplay_StringCategories; one pointer per wStringIndex
; (E-0217)
; record: string
StringList_1B::
; another name for the data at StringList_1B, whose note is above (E-0381)
BreedingStrings_Category0::
    dw Text_WelcomeWhatWouldYou ; id 0
    dw Text_WelcomeWhatWouldYou ; id 1
    dw Text_WhichWillBeThe ; id 2
    dw Text_ThisIsTheOne ; id 3
    dw Text_IsThereAnythingElse ; id 4
    dw Text_YouWontHaveA ; id 5
    dw Text_ThatsTooLowIn ; id 6
    dw Text_AndWhatWillIts ; id 7
    dw Text_TheresNoPotentialMate ; id 8
    dw Text_WillResultFromThis ; id 9
    dw Text_AGreatMonsterWill ; id 10
    dw Text_YouAlreadyHadThat ; id 11
    dw Text_YouveNeverHadThat ; id 12
    dw Text_OKToRecordIn ; id 13
    dw Text_FineFineIllDo ; id 14
    dw Text_HatchingThatWillCost ; id 15
    dw Text_IllHatchTheEgg ; id 16
    dw Text_IWontHatchThe ; id 17
    dw Text_YouDontHaveEnough ; id 18
    dw Text_IllSendTheEgg ; id 19
    dw Text_WillYouTakeWith ; id 20
    dw Text_RaiseItWithLove ; id 21
    dw Text_IllSendToThe ; id 22
    dw Text_WhichWillGoBack ; id 23
    dw Text_IsThisTheOne ; id 24
    dw Text_IsGoingToThe ; id 25
    dw Text_WhichEggShouldI ; id 26
    dw Text_ThatWillCostG ; id 27
    dw Text_ThereIsntASingle ; id 28
    dw Text_YouDontHaveEnough_2 ; id 29
    dw Text_YouGotTheEgg ; id 30
    dw Text_BecomeAGreatMaster ; id 31
    dw Text_BecomeAGreatMaster ; id 32
    dw Text_FineFineJustWait ; id 33
    dw Text_Hatched ; id 34
    dw Text_Hatched ; id 35
    dw Text_Hatched ; id 36
    dw Text_PleaseNameIt ; id 37
    dw Text_WentAwayQuietly ; id 38
    dw Text_RESULTSDISPLAYSpeciesGender ; id 39
    dw Text_UnusedNoSaveData ; id 40
    dw Text_AccessoriesWillBeIn_2 ; id 41

Text_WelcomeWhatWouldYou::
    db "<VOICE1>*: Welcome. What<LINE>"
    db "would you like?@"

Text_WhichWillBeThe::
    db "<VOICE1>*: Which will be<LINE>"
    db "the base monster?@"

Text_ThisIsTheOne::
    db "<VOICE1>*: This is the one<LINE>"
    db "you want?@"

Text_IsThereAnythingElse::
    db "<VOICE1>*: Is there<LINE>"
    db "anything else?@"

Text_YouWontHaveA::
    db "<VOICE1>*: You won't have a<LINE>"
    db "monster with you!<WAIT>"
    db "@"

Text_ThatsTooLowIn::
    db "<VOICE1>*: That's too low<LINE>"
    db "in level to breed.<WAIT>"
    db "@"

Text_AndWhatWillIts::
    db "<VOICE1>*: And what will<LINE>"
    db "its mate be?@"

Text_TheresNoPotentialMate::
    db "<VOICE1>*: There's no<LINE>"
    db "potential mate.<WAIT>"
    db "@"

Text_WillResultFromThis::
    db "<VOICE1>*: <BUF0><LINE>"
    db "will result from<PROMPT>"
    db "<NEXT>this."
    db "<NEXT><WAIT>"
    db "@"

Text_AGreatMonsterWill::
    db "<VOICE1>*: A great monster<LINE>"
    db "will be born!<WAIT>"
    db "@"

Text_YouAlreadyHadThat::
    db "<VOICE1>*: You already had<LINE>"
    db "that monster.<WAIT>"
    db "@"

Text_YouveNeverHadThat::
    db "<VOICE1>*: You've never had<LINE>"
    db "that monster.<WAIT>"
    db "@"

Text_OKToRecordIn::
    db "<VOICE1>*: OK to record in<LINE>"
    db "your Journal?@"

Text_FineFineIllDo::
    db "<VOICE1>*: Fine, fine!<LINE>"
    db "I'll do it!<WAIT>"
    db "@"

Text_HatchingThatWillCost::
    db "<VOICE1>*: Hatching that<LINE>"
    db "will cost <BUF0>G.<PROMPT>"
    db "<CLEAR>Should I hatch it<LINE>"
    db "too?@"

Text_IllHatchTheEgg::
    db "<VOICE1>*: I'll hatch the<LINE>"
    db "egg too, then.<WAIT>"
    db "@"

Text_IWontHatchThe::
    db "<VOICE1>*: I won't hatch<LINE>"
    db "the egg, then.<WAIT>"
    db "@"

Text_YouDontHaveEnough::
    db "<VOICE1>*: You don't have<LINE>"
    db "enough gold, so<PROMPT>"
    db "<CLEAR>I'll just do the<LINE>"
    db "breeding.<WAIT>"
    db "@"

Text_IllSendTheEgg::
    db "<VOICE1>*: I'll send the<LINE>"
    db "egg to the farm.<WAIT>"
    db "@"

Text_WillYouTakeWith::
    db "<VOICE1>*: Will you take<LINE>"
    db "<BUF0> with you?@"

Text_RaiseItWithLove::
    db "<VOICE1>*: Raise it with<LINE>"
    db "love and care!<WAIT>"
    db "@"

Text_IllSendToThe::
    db "<VOICE1>*: I'll send <BUF0><LINE>"
    db "to the farm, then.<WAIT>"
    db "@"

Text_WhichWillGoBack::
    db "<VOICE1>*: Which will go<LINE>"
    db "back to the farm?@"

Text_IsThisTheOne::
    db "<VOICE1>*: Is this the one<LINE>"
    db "to send home?@"

Text_IsGoingToThe::
    db "<VOICE1>*: <BUF0> is<LINE>"
    db "going to the farm.<WAIT>"
    db "@"

Text_WhichEggShouldI::
    db "<VOICE1>*: Which egg should<LINE>"
    db "I hatch?@"

Text_ThatWillCostG::
    db "<VOICE1>*: That will cost<LINE>"
    db "<BUF0>G. OK?@"

Text_ThereIsntASingle::
    db "<VOICE1>*: There isn't a<LINE>"
    db "single egg here.<WAIT>"
    db "@"

Text_YouDontHaveEnough_2::
    db "<VOICE1>*: You don't have<LINE>"
    db "enough gold.<WAIT>"
    db "@"

Text_YouGotTheEgg::
    db "<VOICE1>*: You got the egg<LINE>"
    db "of <BUF0>.<WAIT>"
    db "@"

Text_BecomeAGreatMaster::
    db "<VOICE1>*: Become a great<LINE>"
    db "master!<WAIT>"
    db "@"

Text_FineFineJustWait::
    db "<VOICE1>*: Fine, fine.<LINE>"
    db "Just wait here.<WAIT>"
    db "@"

Text_Hatched::
    db "<BUF0> hatched!<WAIT>"
    db "@"

Text_PleaseNameIt::
    db "Please name it.<WAIT>"
    db "@"

Text_WentAwayQuietly::
    db "<BUF0> went<LINE>"
    db "away quietly…<WAIT>"
    db "@"

Text_RESULTSDISPLAYSpeciesGender::
    db "RESULTS<LINE>"
    db "DISPLAY<LINE>"
    db "<LINE>"
    db "Species<LINE>"
    db "Gender@"

Text_UnusedNoSaveData::
    db "Unused.@"
    db "No save data.@"

; the last target of the bank-$1B message pointer table, laid out like its other entries: two
; control bytes, then text up to $F0 (E-0197, C1)
; record: $EA, $45 (window control bytes, as at the other entries of this pointer table); message
Text_AccessoriesWillBeIn_2::
; another name for the data at Text_AccessoriesWillBeIn_2, whose note is above (E-0381)
Text_AccessoriesWillBeIn_3::
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

; Zeroes $6F bytes from wScreenState, decompresses Tiles1Gfx from ROM bank $46 to vTiles1, far-calls
; ClearScreenBufferAndAttributes_BankF1, calls LoadPalette0FromData_3, zeroes hScrollX and hScrollY,
; starts a palette fade (A = $FC), sets wTextWindowState = 1, wTextWindowStep = 0 and
; hSpriteWindowClipMode = 2, and runs StepTextWindowOpenClose until the low two bits of
; wTextWindowState are clear. It then requests tile fills with FillTilesRequest (HL = vTiles1, DE =
; $1202), sets hSpriteWindowClipMode = 2 and wLCDCShadow = 3, and ends by jumping to
; ResumeAfterModeChange with A = 1. No call, jump or pointer to it was found in src/. (C1, E-0379)
; clears $6F bytes from wScreenState, decompresses bank $46 $4001 to $8800, far-calls F1:$4AA8 and
; LoadPalette0FromData_3, waits on wTextWindowState and jumps to $077A; no caller found (E-0197)
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
    ld de, Tiles1Gfx
    ld hl, vTiles1
    call DecompressToRAMLocked
    farcall ClearScreenBufferAndAttributes_BankF1
    call LoadPalette0FromData_3
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
    jp ResumeAfterModeChange

; Does nothing when wIsCGB is zero. On CGB it copies the 8 bytes of LoadPalette0FromData_3_Data ($4D
; $5E $FF $7F $F2 $66 $00 $00) to wBGPaletteBuffer and sets wBGPaletteUploadRequest = $7F so the
; palette is uploaded later. Far-called by GameMode6_Init and GameMode8_Init, and called by
; UnreferencedScreenInitFromBank46. (C2, E-0379)
; on CGB copies the 8-byte palette LoadPalette0FromData_3_Data into wBGPaletteBuffer and sets
; wBGPaletteUploadRequest = $7F (E-0118) (E-0344: the address in its name dropped or read as the
; label there; was LoadPalette0FromData_3)
LoadPalette0FromData_3::
    ld a, [wIsCGB]
    or a
    ret z
    ld de, LoadPalette0FromData_3_Data
    ld hl, wBGPaletteBuffer
    ld bc, $0008
    call CopyBytesDEToHL_Bank00
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ret

; Four CGB colours as RGB555 words, low byte first: $5E4D, $7FFF, $66F2, $0000 (a blue, white, a
; paler blue, black). LoadPalette0FromData_3 copies the 8 bytes to the start of wBGPaletteBuffer,
; which is background palette 0, when wIsCGB is set and sets wBGPaletteUploadRequest to $7F. (C1,
; E-0381)
LoadPalette0FromData_3_Data::
    db $4d, $5e, $ff, $7f, $f2, $66, $00, $00

; Returns at once while wFadeState is non-zero; otherwise jumptable on wScreenState: 0
; LinkKeyTrade_Start, 1 LinkKeyTrade. Far-called each frame by RunLinkSession3Exchange_Receive, so
; these are the screens of the key trade (link session 3). (C1, E-0379)
; unless a fade is running, runs the routine for wScreenState (jump table) (E-0122)
RunScreenStateWhenNotFading_1B::
    ld a, [wFadeState]
    and a
    ret nz
    ld a, [wScreenState]
    jumptable
    dw LinkKeyTrade_Start
    dw LinkKeyTrade

; Key trade start-up, jumptable on wScreenStep (state 0 of RunScreenStateWhenNotFading_1B): 0
; LinkKeyTrade_Start_SaveScreen, 1 LinkKeyTrade_Start_ShowStartingKeyTrade, 2
; LinkKeyTrade_Start_ShowPleaseWait, 3 LinkKeyTrade_Start_SignalReady, 4
; LinkKeyTrade_Start_ShowPleaseChooseTheKey. The last step moves wScreenState on to LinkKeyTrade.
; (C1, E-0379)
; by wScreenStep: 'Starting key trade', 'Please wait.', 'Please choose the key to trade.'
LinkKeyTrade_Start::
    ld a, [wScreenStep]
    jumptable
    dw LinkKeyTrade_Start_SaveScreen
    dw LinkKeyTrade_Start_ShowStartingKeyTrade
    dw LinkKeyTrade_Start_ShowPleaseWait
    dw LinkKeyTrade_Start_SignalReady
    dw LinkKeyTrade_Start_ShowPleaseChooseTheKey

; Key trade start, step 0: saves the screen to the window buffer and loads two box tiles. (C1,
; E-0357)
LinkKeyTrade_Start_SaveScreen::
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
    ld de, Tiles1Plus4A0Tiles
    ld hl, vTiles2 + $700
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles
    ld hl, vTiles2 + $710
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Key trade start, step 1: 'Starting key trade...' (string 1); clears the send byte and advances the
; title state. (C1, E-0357)
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

; Key trade start, step 2: 'Please wait.' (string 7). (C1, E-0357)
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

; Key trade start, step 3: once the text has finished sends 1 (ready). (C2, E-0357; probed E-0379)
LinkKeyTrade_Start_SignalReady::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

; Key trade start, step 4: when the partner answers 1, 'Please choose the key to trade.' (string 6)
; and on to the key list. (C1, E-0357)
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

; Key trade screens (state 1 of RunScreenStateWhenNotFading_1B), jumptable on wScreenStep with 37
; entries: 0-5 build and draw the key list and run the cursor, 6 LinkKeyTrade_WaitForPartner (the
; stop path), 7-10 the first yes/no question, 11 LinkKeyTrade_KeyCannotBeTraded, 12-16 the key
; exchange and check, 17 LinkKeyTrade_KeysSameName, 18-28 the confirmation questions, 29-32 the
; key-world record sent in 30-byte parts, 33 LinkKeyTrade_SwapKeys, 34-35 the save, 36
; LinkKeyTrade_ExitToTitleMenu. Entries 12 and 25 share LinkKeyTrade_SignalReady, 13 and 26 share
; LinkKeyTrade_WaitPartnerAnswer, 7 and 21 LinkKeyTrade_DrawYesNo. (C1, E-0379)
; by wScreenStep: builds the key list, exchanges bytes and messages over the link (sending a byte
; and waiting for the partner's message) and saves (RunSaveGameSteps)
LinkKeyTrade::
    ld a, [wScreenStep]
    jumptable
    dw LinkKeyTrade_BuildKeyList
    dw LinkKeyTrade_ClearNameTiles
    dw LinkKeyTrade_DrawListBox
    dw LinkKeyTrade_DrawKeyNames
    dw LinkKeyTrade_RedrawScreen
    dw LinkKeyTrade_KeyCursor
    dw LinkKeyTrade_WaitForPartner
    dw LinkKeyTrade_DrawYesNo
    dw LinkKeyTrade_ReadAnswer
    dw LinkKeyTrade_ShowPleaseChooseTheKey
    dw LinkKeyTrade_EraseMarks
    dw LinkKeyTrade_KeyCannotBeTraded
    dw LinkKeyTrade_SignalReady
    dw LinkKeyTrade_WaitPartnerAnswer
    dw LinkKeyTrade_ExchangeKeys
    dw LinkKeyTrade_EndKeyExchange
    dw LinkKeyTrade_CheckPartnerKey
    dw LinkKeyTrade_KeysSameName
    dw LinkKeyTrade_ShowIsItOKTo
    dw LinkKeyTrade_DrawYesNoAgain
    dw LinkKeyTrade_ReadAnswer2
    dw LinkKeyTrade_DrawYesNo
    dw LinkKeyTrade_ReadAnswer3
    dw LinkKeyTrade_DrawYesNoAndBack
    dw LinkKeyTrade_ConfirmPleaseWait
    dw LinkKeyTrade_SignalReady
    dw LinkKeyTrade_WaitPartnerAnswer
    dw LinkKeyTrade_ShowReadyingTrade
    dw LinkKeyTrade_SendReady
    dw LinkKeyTrade_CopyKeyWorldRecord
    dw LinkKeyTrade_SendRecord
    dw LinkKeyTrade_EndRecordPart
    dw LinkKeyTrade_SendNextRecordPart
    dw LinkKeyTrade_SwapKeys
    dw LinkKeyTrade_ShowPleaseWait
    dw LinkKeyTrade_SignalSaveDone
    dw LinkKeyTrade_ExitToTitleMenu

; Key trade, step 0: draws the key box, builds the key list (BuildKeyListIndexListEntries) and its
; heading (string $0E), redraws and resets the cursor. (C1, E-0357)
LinkKeyTrade_BuildKeyList::
    ld a, [wTextFlags]
    and a
    ret nz
    ld de, LinkKeyTrade_BuildKeyList_TileRect
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
    farcall ShowString_Bank1B
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

; Key trade, step 1: clears the name tile areas. (C1, E-0357)
LinkKeyTrade_ClearNameTiles::
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

; Key trade, step 2: draws the list box, clamps the page cursor, the page arrows and numbers, and
; shows the cursor. (C1, E-0357)
LinkKeyTrade_DrawListBox::
    ld de, LinkKeyTrade_DrawListBox_TileRect
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
    ld hl, LinkKeyTrade_DrawListBox_Data
    call StoreBAtWordTableEntry_Bank1B
    call BGMapAddressAtScroll_Bank1B
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_1B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Key trade, step 3: draws the page's key names and marks. (C1, E-0357)
LinkKeyTrade_DrawKeyNames::
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

; Key trade, step 4: redraws and clears the cursor mark. (C1, E-0357)
LinkKeyTrade_RedrawScreen::
    call BGMapAddressAtScroll_Bank1B
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_1B
    ld a, [wListCursor]
    ld b, $c3
    ld hl, LinkKeyTrade_DrawListBox_Data
    call StoreBAtWordTableEntry_Bank1B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Key trade, step 5: the key cursor: when the partner sends $FE (cancelled) answers $FD and goes on;
; Select shows the key's details (ReturnStub_3); a page change or move redraws; B sends $FE; A marks
; the key and asks 'Is it OK to trade this ...' (string 4). (C1, E-0357)
LinkKeyTrade_KeyCursor::
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
    jr nz, .call_return_stub_3
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

.call_return_stub_3:
    farcall ReturnStub_3

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
    ld hl, LinkKeyTrade_DrawListBox_Data
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

; Key trade step 6, jumptable on wScreenSubStep: 0 LinkKeyTrade_WaitForPartner_ShowStopReason, 1
; LinkKeyTrade_WaitForPartner_ShowPleaseWait, 2 LinkKeyTrade_WaitForPartner_SignalReady, 3
; LinkKeyTrade_WaitForPartner_PartnerReady, 4 LinkKeyTrade_WaitForPartner_ExitToTitleMenu. It is
; entered when this side cancels (sends $FE) or the partner $FE arrives (answered with $FD), and it
; ends the trade by returning to the title menu. (C1, E-0379)
; by its step: 'Please wait.' and the partner's link message
LinkKeyTrade_WaitForPartner::
    ld a, [wScreenSubStep]
    jumptable
    dw LinkKeyTrade_WaitForPartner_ShowStopReason
    dw LinkKeyTrade_WaitForPartner_ShowPleaseWait
    dw LinkKeyTrade_WaitForPartner_SignalReady
    dw LinkKeyTrade_WaitForPartner_PartnerReady
    dw LinkKeyTrade_WaitForPartner_ExitToTitleMenu

; Waiting for the partner, sub-step 0: on $FD or $FE from the partner shows why the trade stops
; (string 2, or 3 when this side cancelled or leads) and goes on. (C1, E-0357)
LinkKeyTrade_WaitForPartner_ShowStopReason::
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

; Waiting for the partner, sub-step 1: 'Please wait.' (string 7). (C1, E-0357)
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

; Waiting for the partner, sub-step 2: once the text has finished sends 1. (C2, E-0357; probed
; E-0379)
LinkKeyTrade_WaitForPartner_SignalReady::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Waiting for the partner, sub-step 3: when the partner answers 1, goes on. (C2, E-0357; probed
; E-0379)
LinkKeyTrade_WaitForPartner_PartnerReady::
    ld a, [wLinkMessage]
    cp $01
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Waiting for the partner, sub-step 4: once bit 0 of wTextFlags is clear, zeroes $6F bytes from
; wScreenState and requests a change to game mode 5 with wModeState 1 (wModeChangeRequest = 1), the
; title menu start-up GameMode5_Init_TitleMenu. (C2, E-0370; probed E-0379)
LinkKeyTrade_WaitForPartner_ExitToTitleMenu::
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

; Key trade, step 7: plays sound $6C and draws the yes/no box. (C1, E-0357)
LinkKeyTrade_DrawYesNo::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $6c
    call QueueSoundEffect
    ld de, LinkKeyTrade_DrawYesNo_TileRect
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

; Key trade, step 8: the yes/no answer; a partner's cancel ($FE) goes to step 6 sending $FD; no goes
; on one step, yes three. (C1, E-0357)
LinkKeyTrade_ReadAnswer::
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

; Key trade, step 9: redraws and 'Please choose the key to trade.' (string 6). (C1, E-0357)
LinkKeyTrade_ShowPleaseChooseTheKey::
    call LinkKeyTrade_RestoreYesNoArea
    ld a, $06 ; 'Please choose the key to trade.'
    call BeginString_Bank1B_Cat0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Key trade, step 10: once the text has finished erases the four marks and returns to the cursor
; (step 5). (C2, E-0357; probed E-0379)
LinkKeyTrade_EraseMarks::
    ld a, [wTextFlags]
    and a
    ret nz
    ld c, $04
    ld hl, LinkKeyTrade_DrawListBox_Data
    call EraseCEntriesOfWordTable_Bank1B
    ld a, $05
    ld [wScreenStep], a
    ret

; Key trade step 11, jumptable on wScreenSubStep: 0 LinkKeyTrade_KeyCannotBeTraded_Check (shows
; 'That key cannot be traded.' or 'Please wait.'), 1 LinkKeyTrade_KeyCannotBeTraded_AskAgain (goes
; back two steps once the text is done). (C1, E-0379)
; by its step: 'That key cannot be traded.' and 'Please wait.'
LinkKeyTrade_KeyCannotBeTraded::
    ld a, [wScreenSubStep]
    jumptable
    dw LinkKeyTrade_KeyCannotBeTraded_Check
    dw LinkKeyTrade_KeyCannotBeTraded_AskAgain

; Key trade refusal, sub-step 1: once the text has finished goes back two steps. (C2, E-0357; probed
; E-0379)
LinkKeyTrade_KeyCannotBeTraded_AskAgain::
    ld a, [wTextFlags]
    and a
    ret nz
    xor a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    sub $02
    ld [wScreenStep], a
    ret

; Key trade refusal, sub-step 0: 'That key cannot be traded.' (string 5) for a story key below kind
; 7, a story key whose world is the one the player is in (maps $A8-$E2 by kind 7-12), or the
; generated key of the key world being played; otherwise 'Please wait.' and on. (C1, E-0357)
LinkKeyTrade_KeyCannotBeTraded_Check::
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

; Key trade, step 12: once the text has finished sends 1. (C2, E-0357; probed E-0379)
LinkKeyTrade_SignalReady::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

; Key trade, step 28: draws three tiles at the top, sends 2 and goes on. (C1, E-0357)
LinkKeyTrade_SendReady::
    ld a, [wTextFlags]
    and a
    ret nz
    ld de, LinkKeyTrade_SendReady_Data
    call DrawThreeTilesAtBGMap20FFromDE
    ld a, $02
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Key trade, step 13: when the partner answers 1 goes on; on $FE returns to step 6 sending $FD. (C2,
; E-0357; probed E-0379)
LinkKeyTrade_WaitPartnerAnswer::
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

; Key trade step 14: adds 1 to wScreenStep, then copies the four bytes of the chosen key entry
; (KeyEntryAddressForListEntriesCell4) and the two bytes of its wKeySeeds word
; (KeySeedAddressForListEntriesCell4) to wLinkRecvBuffer. It then sets the transfer count
; wLinkBufferCountLo/Hi to 6, wLinkTimeoutLo/Hi to wLinkRecvBuffer (the address
; LinkSendStepWithBuffer sends from), wLinkBufferPtrLo/Hi to wLinkPartnerName (where the partner key
; is stored), wLinkSendByte = $FF and wLinkReady = 1. An earlier note called the second part the
; item word; it is the key seed word. (C2, E-0379)
LinkKeyTrade_ExchangeKeys::
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
    call KeySeedAddressForListEntriesCell4
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

; Key trade, step 35: once the text has finished sends 5. (C2, E-0357; probed E-0379)
LinkKeyTrade_SignalSaveDone::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $05
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Key trade, step 15: when the exchange ends ($F0) goes on. (C2, E-0357; probed E-0379)
LinkKeyTrade_EndKeyExchange::
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

; Key trade step 16: adds 1 to wScreenStep, then sets wSelectedRecord. $FF (and wScreenSubStep = 0)
; when LinkKeyTrade_HasLikeKey finds a story key of the same kind as the partner story key; $FE (and
; wScreenSubStep = 0) when LinkKeyTrade_CheckPartnerKey_CountGeneratedKeys returns exactly 20;
; otherwise 0, leaving wScreenSubStep alone. Equal bytes 1 and 2 of a generated key do not make a
; match (see LinkKeyTrade_HasLikeKey). An earlier note said a match by the same generated bytes
; gives $FF; that never happens. (C2, E-0379)
LinkKeyTrade_CheckPartnerKey::
    call LinkKeyTrade_HasLikeKey
    cp $ff
    jr z, .check_screen_step2
    call LinkKeyTrade_CheckPartnerKey_CountGeneratedKeys
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

; Scans the 32 entries of wKeyList and returns A = $FF if one is a story key (byte 3 bit 7 set)
; whose byte 0 low nibble equals the low nibble of the partner key in wLinkPartnerName, and the
; partner key is also a story key (bit 7 of wRandomSeed2Lo, the fourth received byte); otherwise A =
; 0. Entries whose byte 0 is $FF or $FE are skipped. A generated entry (bit 7 clear) is compared
; with the partner bytes wLinkPartnerByte1 and wLinkPartnerByte2, but both outcomes of that test
; fall into the same next-entry code, so it never gives $FF. An earlier note said the same generated
; bytes count as a like key; that is not so. (C2, E-0379)
LinkKeyTrade_HasLikeKey::
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

; Counts the generated keys (kind $FE or byte 3 bit 7 clear) into C; at 20 or more C drops by one
; when the chosen key is generated or the partner's is a story key (a place frees up). (C2, E-0357;
; probed E-0379)
LinkKeyTrade_CheckPartnerKey_CountGeneratedKeys::
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

; Key trade step 17, jumptable on wScreenSubStep: 0 LinkKeyTrade_KeysSameName_SendResult, 1
; LinkKeyTrade_KeysSameName_WaitResult, 2 LinkKeyTrade_KeysSameName_Decide, 3
; LinkKeyTrade_KeysSameName_EndRefusalText, 4 LinkKeyTrade_KeysSameName_ShowPleaseChooseTheKey. The
; two sides swap the result of LinkKeyTrade_CheckPartnerKey and either go on to step 18 or show a
; refusal text and return to step $0A. (C1, E-0379)
; by wScreenSubStep: "Keys can't have the same name.", then back to 'Please choose the key to
; trade.'
LinkKeyTrade_KeysSameName::
    ld a, [wScreenSubStep]
    jumptable
    dw LinkKeyTrade_KeysSameName_SendResult
    dw LinkKeyTrade_KeysSameName_WaitResult
    dw LinkKeyTrade_KeysSameName_Decide
    dw LinkKeyTrade_KeysSameName_EndRefusalText
    dw LinkKeyTrade_KeysSameName_ShowPleaseChooseTheKey

; Same-name check, sub-step 0: sends this side's result (2 fine, 3 already held, 4 no room). (C2,
; E-0357; probed E-0379)
LinkKeyTrade_KeysSameName_SendResult::
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

; Same-name check, sub-step 1: waits for the partner's result (2-4). (C2, E-0357; probed E-0379)
LinkKeyTrade_KeysSameName_WaitResult::
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

; Same-name check, sub-step 2: with both fine goes on; otherwise shows the matching refusal ('Keys
; can't have the same name.' string 8, or strings $0D, $0F or $26). (C1, E-0357)
LinkKeyTrade_KeysSameName_Decide::
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

; Same-name check, sub-step 3: waits for the text. (C2, E-0357; probed E-0379)
LinkKeyTrade_KeysSameName_EndRefusalText::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Same-name check, sub-step 4: redraws and 'Please choose the key to trade.' and returns to step
; $0A. (C1, E-0357)
LinkKeyTrade_KeysSameName_ShowPleaseChooseTheKey::
    call LinkKeyTrade_RestoreYesNoArea
    ld a, $06 ; 'Please choose the key to trade.'
    call BeginString_Bank1B_Cat0
    xor a
    ld [wScreenSubStep], a
    ld a, $0a
    ld [wScreenStep], a
    ret

; Key trade, step 18: draws the partner's key name (LinkKeyTrade_WritePartnerKeyName) in the box and
; asks 'Is it OK to trade keys?' (string 9). (C1, E-0357)
LinkKeyTrade_ShowIsItOKTo::
    call LinkKeyTrade_WritePartnerKeyName
    ld de, LinkKeyTrade_BuildKeyList_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $0f, $01
    call CopyRectTo20ByteRows
    ld de, LinkKeyTrade_ShowIsItOKTo_TileRect
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

; Key trade, step 19: plays sound $6C and draws the yes/no box. (C1, E-0357)
LinkKeyTrade_DrawYesNoAgain::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $6c
    call QueueSoundEffect
    ld de, LinkKeyTrade_DrawYesNoAgain_TileRect
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

; Key trade, step 20: the answer; a partner's cancel goes to step 6 sending $FD; no sends $FE and
; goes to step 6; yes marks it and asks 'Is it OK to record the ...' (string $0A). (C1, E-0357)
LinkKeyTrade_ReadAnswer2::
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
    ld hl, LinkKeyTrade_ReadAnswer2_Data
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

; Does nothing while wTextFlags is non-zero. Otherwise draws the 6 x 5 yes/no box
; LinkKeyTrade_DrawYesNo_TileRect at wWindowTileBuffer + $112 (CopyRectTo20ByteRows), copies 20 x 13
; tiles of the screen buffer from offset $01CC to the BG map at the current scroll position
; (DrawScreenBufferRectToBGMap_1B), sets wTwoChoiceCursor = 0 and adds 1 to wScreenStep. It is
; LinkKeyTrade_DrawYesNo without the sound effect $6C. No call, jump or pointer to it was found in
; src/. (C1, E-0379)
; when no text runs, copies box LinkKeyTrade_DrawYesNo_TileRect to wWindowTileBuffer + $112, draws
; it, clears wTwoChoiceCursor and wScreenStep += 1 (E-0124) (E-0344: the address in its name dropped
; or read as the label there; was ShowTwoChoiceBoxWhenTextIdle)
ShowTwoChoiceBoxWhenTextIdle::
    ld a, [wTextFlags]
    and a
    ret nz
    ld de, LinkKeyTrade_DrawYesNo_TileRect
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

; Key trade, step 22: the answer; a partner's cancel goes to step 6; no asks 'Is it OK to trade
; keys?' again; yes goes on two steps. (C1, E-0357)
LinkKeyTrade_ReadAnswer3::
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

; Key trade, step 23: plays sound $6C, draws the yes/no box and goes back three steps. (C1, E-0357)
LinkKeyTrade_DrawYesNoAndBack::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $6c
    call QueueSoundEffect
    ld de, LinkKeyTrade_DrawYesNoAgain_TileRect
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

; Key trade, step 24: 'Please wait.' (string 7). (C1, E-0357)
LinkKeyTrade_ConfirmPleaseWait::
    ld a, $07 ; 'Please wait.'
    call BeginString_Bank1B_Cat0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Key trade, step 27: 'Readying trade... Please wait.' (string $0B). (C1, E-0357)
LinkKeyTrade_ShowReadyingTrade::
    ld a, $0b ; 'Readying trade… Please wait.'
    call BeginString_Bank1B_Cat0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Key trade, step 29: when the partner answers 2, copies the chosen key's saved key-world record
; ($195 bytes from SRAM bank 2 at $A000 + $195 x its index) into wArenaEntry for a generated key
; with a record, or clears it, and sends 1. (C1, E-0357)
LinkKeyTrade_CopyKeyWorldRecord::
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

; Key trade, step 30: when the partner answers 1 starts sending the record in 30-byte parts (13
; parts and the rest). (C1, E-0357)
LinkKeyTrade_SendRecord::
    ld a, [wLinkMessage]
    cp $01
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    call RunScreenCounterStep
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

; Key trade, step 31: when a part's exchange ends ($F0) sends 1. (C2, E-0357; probed E-0379)
LinkKeyTrade_EndRecordPart::
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

; Key trade, step 32: when the partner answers 1 sends the next part (back one step) until the
; record is sent. (C1, E-0357)
LinkKeyTrade_SendNextRecordPart::
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
    call RunScreenCounterStep
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

; Key trade, step 33: draws three tiles, removes the traded key (a story key's four bytes $FF, a
; generated one through DeleteKeyEntryTemp0) and stores the partner's key in a free slot of the 32
; (with its key-world record and story flags), then on two steps. (C1, E-0357)
LinkKeyTrade_SwapKeys::
    ld de, LinkKeyTrade_SwapKeys_Data
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
    ld a, [wLinkPartnerCommandA]
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
    call ClearLinkExchangeBuffer1Bit7AndFourSlots
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
    ld [wInventorySortFlags], a
    ret

; Key trade, step 34: saves (RunSaveGameSteps) and shows 'Please wait.'. (C1, E-0357)
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

; Key trade, step 36: when the partner answers 5, clears wLinkSendByte, zeroes $6F bytes from
; wScreenState, clears hDecompressLock and requests a change to game mode 5 with wModeState 1
; (wModeChangeRequest = 1), the title menu start-up GameMode5_Init_TitleMenu. (C2, E-0370; probed
; E-0379)
LinkKeyTrade_ExitToTitleMenu::
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

; Clears bit 7 of wLinkExchangeBuffer + $1 and zeroes the four bytes at wLinkExchangeBuffer + $178,
; + $17C, + $180 and + $184 (4 apart), leaving the bytes between them alone. Called only by
; LinkKeyTrade_SwapKeys. (C2, E-0379)
; clears bit 7 of wLinkExchangeBuffer + $1 and the bytes at wLinkExchangeBuffer + $1 + $177 + 4 * n
; for n = 0-3 (E-0122) (E-0340: the address in its name read as its RAM name; was
; ClearLinkExchangeBuffer1Bit7AndFourSlots)
ClearLinkExchangeBuffer1Bit7AndFourSlots::
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

; Writes the partner's key name into wNameGlyphBuf: a fixed name for $FE, a story key's name, or a
; generated key's two name parts from the bank-$09 strings (wLinkPartnerByte1 + 1 and
; wLinkPartnerByte2 + $11), followed by mark $5B. (C1, E-0357)
LinkKeyTrade_WritePartnerKeyName::
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
    jr LinkKeyTrade_ShowKeyName

.check_random_seed2_lo:
    ld a, [wRandomSeed2Lo]
    bit 7, a
    jp nz, LinkKeyTrade_WriteStoryKeyName
    ld a, $09
    ld [wDataBank], a
    ld a, [wLinkPartnerByte1]
    inc a
    call CopyDataBankStringToTextBuf0
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
    call CopyDataBankStringToTextBuf0
    pop hl
    ld de, wTextBuf0

.skip2:
    ld a, [de]
    cp $f0
    jr z, LinkKeyTrade_EndKeyName
    ld [hli], a
    inc de
    jr .skip2

; Ends the key name with mark $5B and $F0. (C1, E-0357)
LinkKeyTrade_EndKeyName::
    ld a, $5b
    ld [hli], a
    ld a, $f0
    ld [hl], a
    ld a, $03
    ld [wArg5], a

; Copies the key name from wNameGlyphBuf into wTextBuf0 and shows it (string $27) in an 11 x 1
; window at VRAM $9600. (C1, E-0357)
LinkKeyTrade_ShowKeyName::
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
    farcall ShowString_Bank1B
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

; A = string number. Reads word A of the pointer list CopyKeyNameWordToDE_StringList from the ROM
; bank in wDataBank (ReadWordFromDataBank), then copies the 16 bytes it points to from ROM bank $09
; into wTextBuf0 (CopyFromBankWaitVRAM with B = 9, C = $10). Called twice by
; LinkKeyTrade_WritePartnerKeyName, which sets wDataBank to $09 and passes the two name part numbers
; of a generated key. (C1, E-0379)
; copies the 16-byte string named by the word table $4078 + 2 * A (in bank 9) to wTextBuf0; the next
; entry copies a key name word to wNameGlyphBuf (E-0127) (E-0344: the address in its name dropped or
; read as the label there; was CopyDataBankStringToTextBuf0)
CopyDataBankStringToTextBuf0::
    sla a
    ld hl, CopyKeyNameWordToDE_StringList
    add_a_to_hl
    call ReadWordFromDataBank
    ld e, b
    ld d, c
    ld hl, wTextBuf0
    ld b, $09
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; Reached by a jump from LinkKeyTrade_WritePartnerKeyName for a story key (bit 7 of wRandomSeed2Lo,
; the partner key's fourth byte): copies string wLinkPartnerName & $3F of category $0C in bank $09
; (16 glyphs) into wNameGlyphBuf, puts $F0 at wNameGlyphBuf + $D, scans to the first $F0 and jumps
; to LinkKeyTrade_EndKeyName. The scan leaves HL one byte past that $F0, so the mark $5B is written
; after the end byte and LinkKeyTrade_ShowKeyName, which copies up to the first $F0, shows the name
; without the mark. 46 unreached bytes follow the jump. (C1, E-0370)
LinkKeyTrade_WriteStoryKeyName::
    ld a, [wLinkPartnerName]
    and $3f
    ld l, a
    ld h, $00
    push hl
    ld a, [wDataBank]
    push af
    ld a, $09
    ld [wDataBank], a
    ld hl, BeginStringDisplay_Bank09_StringCategories
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
    jr z, .to_link_key_trade_end_key_name
    jr .skip

.to_link_key_trade_end_key_name:
    jp LinkKeyTrade_EndKeyName
    db $21, $a1, $5d, $06, $1d, $d7, $fa, $f5, $d7, $67, $fa, $f6, $d7, $6f, $7e, $6f
    db $26, $00, $29, $29, $7d, $c6, $07, $6f, $7c, $ce, $c7, $67, $7e, $e6, $7f, $01
    db $95, $01, $cd, $aa, $16, $7d, $c6, $00, $6f, $7c, $ce, $a0, $67, $c9

; Far-calls SetArg5ToListEntriesCell4 (wArg5/wArg6 = wListEntries + 4 * wListPageIndex +
; wListCursor), reads the key slot number stored there and returns HL = wKeyList + 4 * slot, the
; 4-byte key entry; A and DE are clobbered. Called by LinkKeyTrade_KeyCannotBeTraded_Check,
; LinkKeyTrade_ExchangeKeys, LinkKeyTrade_CheckPartnerKey_CountGeneratedKeys,
; LinkKeyTrade_CopyKeyWorldRecord and LinkKeyTrade_SwapKeys. (C2, E-0379)
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

; Far-calls SetArg5ToListEntriesCell4, reads the key slot number at wListEntries + 4 *
; wListPageIndex + wListCursor and returns HL = wKeySeeds + 2 * slot, the 2-byte seed word of that
; key. A and DE are clobbered. Called only by LinkKeyTrade_ExchangeKeys. The label says item, but
; wKeySeeds holds the seed saved when a key is generated. (C2, E-0379)
; far-calls SetArg5ToListEntriesCell4, reads the byte at that address and returns HL = $C787 + 2 *
; that byte (E-0119)
KeySeedAddressForListEntriesCell4::
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

; Writes the three bytes at DE to vBGMap0 + $20F, + $210 and + $211 (each write waits for VRAM
; access with interrupts off). DE ends 2 past its start, HL = vBGMap0 + $211. Called by
; LinkKeyTrade_SendReady, LinkKeyTrade_SwapKeys and RunScreenCounterStep_AnimateDots. (C1, E-0379)
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

; Jumptable on wScreenCounter with six entries, the waiting animation of the key trade record
; transfer: 0, 2 and 4 RunScreenCounterStep_DrawBlankDot; 1 and 3 RunScreenCounterStep_DrawDot; 5
; RunScreenCounterStep_AnimateDots. Each step ends by adding 1 to wScreenCounter, except the last,
; which sets it back to 0. Called by LinkKeyTrade_SendRecord and LinkKeyTrade_SendNextRecordPart.
; (C1, E-0379)
; runs the routine for wScreenCounter (jump table of six; steps 2 and 4 reuse 0, 3 reuses 1)
; (E-0122) (E-0344: the address in its name dropped or read as the label there; was
; RunScreenCounterStep)
RunScreenCounterStep::
    ld a, [wScreenCounter]
    jumptable
    dw RunScreenCounterStep_DrawBlankDot
    dw RunScreenCounterStep_DrawDot
    dw RunScreenCounterStep_DrawBlankDot
    dw RunScreenCounterStep_DrawDot
    dw RunScreenCounterStep_DrawBlankDot
    dw RunScreenCounterStep_AnimateDots

; The waiting animation, counters 0, 2 and 4 (three entries of the RunScreenCounterStep jumptable):
; draws the blank tile ($C3) at the current dot through WriteTileBAtBGMap20FPlusGlyphListStart,
; which also advances wScreenCounter. (C1, E-0370)
RunScreenCounterStep_DrawBlankDot::
    ld b, $c3
    jr WriteTileBAtBGMap20FPlusGlyphListStart

; The waiting animation, counters 1 and 3 (two entries of the RunScreenCounterStep jumptable on
; wScreenCounter): draws tile $BC at the current dot (vBGMap0 + $20F + wGlyphListStart) by falling
; through into WriteTileBAtBGMap20FPlusGlyphListStart, which also advances wScreenCounter. (C1,
; E-0370)
RunScreenCounterStep_DrawDot::
    ld b, $bc

; B = tile number. Writes it at vBGMap0 + $20F + wGlyphListStart (waits for VRAM access with
; interrupts off), then adds 1 to wScreenCounter. HL, A are clobbered. Reached by the jump from
; RunScreenCounterStep_DrawBlankDot, by falling through from RunScreenCounterStep_DrawDot and by a
; call from RunScreenCounterStep_AnimateDots. (C1, E-0379)
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

; The waiting animation, counter 5: draws the cursor tile ($BB) at the dot, moves to the next of
; three dots and redraws the three after the last. (C1, E-0357)
RunScreenCounterStep_AnimateDots::
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
    ld de, LinkKeyTrade_SendReady_Data
    call DrawThreeTilesAtBGMap20FFromDE
    ret

; A = string index: stores it in wStringIndex, sets wStringCategory = 0 and far-calls
; BeginStringDisplay_Bank1B, so the string starts printing in the text window set up by the caller.
; Called by the key trade steps for their messages (for example 'Please wait.' as index 7 and
; 'Please choose the key to trade.' as index 6). (C1, E-0379)
; A = string index: wStringIndex = A, wStringCategory = 0, then BeginStringDisplay_Bank1B
BeginString_Bank1B_Cat0::
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank1B
    ret

; Restores the area under the yes/no box from the saved screen: copies five rows of six bytes from
; wScreenTileBuffer + $AE to wScreenTileBuffer + $27A (the same place as wWindowTileBuffer + $112,
; where the box is drawn), with their GBC attributes (LinkKeyTrade_RestoreYesNoArea_CopyRows); puts
; back the key box's right edge there, a one-tile column of $B7 four times and the corner $B5; then
; redraws 13 rows of the screen (DrawScreenBufferRectToBGMap_1B). (C1, E-0370)
LinkKeyTrade_RestoreYesNoArea::
    ld b, $00
    ld c, $05
    ld hl, $027a
    ld de, $00ae
    xor a
    ld [wArg1], a
    ld a, $06
    ld [wArg2], a
    call LinkKeyTrade_RestoreYesNoArea_CopyRows
    ld de, LinkKeyTrade_RestoreYesNoArea_TileRect
    ld hl, wWindowTileBuffer + $112
    lb bc, $01, $05
    call CopyRectTo20ByteRows
    call BGMapAddressAtScroll_Bank1B
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_1B
    ret

; DE = source, HL = destination, B = width, C = rows: copies the rectangle with destination rows 20
; bytes apart; the source rows are packed. DE ends past the source. On DMG (wIsCGB zero) that is
; all, with BC and HL kept and A = 0. On CGB it then zero-fills a rectangle of the same shape at HL
; + $0E68 (for HL inside wWindowTileBuffer that is wWindowAttrBuffer) with rSVBK = 2, rows 20 apart,
; and sets rSVBK = 0; BC ends as B and 0, HL at the row after the last. Called by the key trade and
; link menu routines to draw boxes into wWindowTileBuffer. (C2, E-0379)
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

; HL = BG map address, DE = offset into wScreenTileBuffer, B = width, C = rows: copies the rectangle
; from wScreenTileBuffer + DE to the BG map with CopyRectToBGMapWrapped, and sets wTextCursorLo/Hi
; to HL + $1C1. On CGB it then selects VRAM bank 1 and work RAM bank 2 and copies the same rectangle
; from wScreenAttrBuffer + DE as the attributes, then restores rVBK and rSVBK to 0. On DMG BC, DE
; and HL are kept; on CGB the attribute copy leaves DE past the source, HL at the start of the last
; row and C = 0. Called with HL from BGMapAddressAtScroll_Bank1B, B = $14, C = $0D, DE = $01CC by
; the key trade screens. (C1, E-0379)
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

; Returns HL = vBGMap0 + (hScrollY AND $F8) * 4 + hScrollX / 8, the BG map entry at the top left of
; the scrolled screen. A and DE are clobbered. Called by the key trade and link menu routines that
; draw boxes or marks. (C1, E-0379)
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
; past the copy, BC = 0 and A = 0. Called by LinkKeyTrade_Start_SaveScreen and
; LinkKeyTrade_RestoreYesNoArea_CopyRows. (C2, E-0379)
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

; DE = source, HL = destination, BC = count: sets rSVBK = 2, copies BC bytes with each ANDed with
; $07 (the palette number bits of a CGB attribute byte), then sets rSVBK = 0; DE and HL end past the
; copy, BC = 0 and A = 0. Called by LinkKeyTrade_Start_SaveScreen and
; LinkKeyTrade_RestoreYesNoArea_CopyRows for the CGB attribute copies. (C2, E-0379)
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

; HL = table of 16-bit addresses, A = index, B = value: stores B at the address held in entry A; BC
; is kept; A ends as B; DE and HL are clobbered. Called by the key trade, link battle setup and egg
; service menus to draw or erase marks in the tile buffers. (C2, E-0379)
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

; HL = table of 16-bit addresses, C = count: stores tile $C3 at the addresses of entries 0 to C - 1
; (through StoreBAtWordTableEntry_Bank1B). Entry 0 is always erased, so C = 0 erases one entry like
; C = 1. Called by LinkKeyTrade_EraseMarks, LinkBattleSetupMenu_EraseMarks and
; EggServiceMenu_Bank1B_PickRecords_MarkPrize. (C2, E-0379)
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

; DE = offset: writes tiles $C5, $BE, $C6 at BGMapAddressAtScroll_Bank1B + DE, + DE + 2 and + DE + 4
; (each write waits for VRAM access with interrupts off). Called by LinkKeyTrade_DrawListBox (DE =
; $0189) and DrawRecordListPageIndicators_1B. (C1, E-0379)
; draws tiles $C5, $BE, $C6 at BGMapAddressAtScroll_Bank1B + DE, two entries apart
; (WaitForVRAMAccess, interrupts off) (E-0120)
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

; Stores $C5 at [HL], $BE at [HL + 2] and $C6 at [HL + 4], leaving the bytes between them alone; HL
; ends as HL + 4 and A = $C6. Called by LinkKeyTrade_DrawListBox, DrawRecordListPageIndicators_1B
; and LinkBattleSetupMenu_ListMembers. (C2, E-0379)
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

; Copies 16 bytes (one tile) from [HL] to [DE], one byte at a time: it disables interrupts, waits
; until bit 1 of rSTAT is clear (VRAM can be written), stores the byte and enables interrupts again.
; HL and DE end 16 bytes on; only A (= $10 at the end) and the flags change, C is not used, and
; interrupts are left enabled. Nothing in src/ calls this copy. (C1, E-0379)
; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for
; rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (E-0353: corrected; was: Copies 16 bytes
; from [HL] to [DE]; each byte is written with interrupts off after waiting for rSTAT bit 1 to
; clear; clobbers A; HL and DE advance) (the same 20 bytes appear in 3 banks)
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

; Copies rows B up to C - 1 (its one caller passes B = 0, C = 5) of wArg1:wArg2 bytes each (a 16-bit
; count) from offset DE to offset HL, both inside wScreenTileBuffer, rows 20 bytes apart; on the GBC
; it also copies the same rows inside wScreenAttrBuffer (CopyLow3BitsToWRAMBank2_Bank1B). (C2,
; E-0370; probed E-0379)
LinkKeyTrade_RestoreYesNoArea_CopyRows::
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
    jr c, LinkKeyTrade_RestoreYesNoArea_CopyRows
    ret

; Yes/no cursor update for the link key trade, called by LinkKeyTrade_ReadAnswer2; the cursor is
; wTwoChoiceCursor (0 or 1). Up (bit 6 of wJoypadPressedRepeat) or Down (bit 7) toggles it, hides
; the old cursor (tile $C3), shows the new one (tile $BB), resets wScreenCounter, queues sound
; effect $69 and sets wMenuInputResult = $FD. A (bit 0 of wJoypadPressed) draws the chosen tile $BC,
; queues sound $69 and sets $FF; B (bit 1) sets $FE; with no press the cursor blinks (shown for 16
; counts, hidden for 8, once wJoypadRepeatTimer is $14 or more) and the result is 0. The two cursor
; places are the BG map entries at scroll offsets $012D and $016D
; (UpdateTwoChoiceCursor_Bank1B_DrawTile_Data). (C1, E-0379)
; the same instructions as UpdateTwoChoiceCursor_Bank1D, calling this bank's own helpers:
; wTwoChoiceCursor (0 or 1): Up and Down each toggle it, erase the old cursor (tile $C3), draw the
; new one (tile $BB), play sound $69 and set wMenuInputResult = $FD; A draws the confirmed cursor
; (tile $BC), plays sound $69 and sets $FF; B sets $FE; with no input the cursor blinks
; (wScreenCounter counts frames once wJoypadRepeatTimer reaches $14) and the result is 0. Its cursor
; positions come from this bank's own table and were not compared (E-0068)
UpdateTwoChoiceCursor_Bank1B::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_update_two_choice_cursor_bank1_b_hide
    bit 7, a
    jr nz, .call_update_two_choice_cursor_bank1_b_hide2
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, .call_update_two_choice_cursor_bank1_b_mark
    bit 1, a
    jr nz, .set_menu_input_result_to_FE
    call UpdateTwoChoiceCursor_Bank1B_Blink
    xor a
    ld [wMenuInputResult], a
    ret

.call_update_two_choice_cursor_bank1_b_hide:
    call UpdateTwoChoiceCursor_Bank1B_Hide
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

.call_update_two_choice_cursor_bank1_b_hide2:
    call UpdateTwoChoiceCursor_Bank1B_Hide
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
    call UpdateTwoChoiceCursor_Bank1B_Show
    ld a, $69
    call QueueSoundEffect
    ld a, $fd
    ld [wMenuInputResult], a
    ret

.call_update_two_choice_cursor_bank1_b_mark:
    call UpdateTwoChoiceCursor_Bank1B_MarkChosen
    ld a, $69
    call QueueSoundEffect
    ld a, $ff
    ld [wMenuInputResult], a
    ret

.set_menu_input_result_to_FE:
    ld a, $fe
    ld [wMenuInputResult], a
    ret

; Blinks the yes/no cursor: after $14 frames of the repeat timer, shown for 16 counts and hidden for
; 8. (C1, E-0357)
UpdateTwoChoiceCursor_Bank1B_Blink::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, UpdateTwoChoiceCursor_Bank1B_Show
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp $10
    jr c, UpdateTwoChoiceCursor_Bank1B_Show
    cp $18
    jr c, UpdateTwoChoiceCursor_Bank1B_Hide
    xor a
    ld [wScreenCounter], a

; Draws the cursor tile ($BB) at the yes/no cursor. (C1, E-0357)
UpdateTwoChoiceCursor_Bank1B_Show::
    ld b, $bb
    jr UpdateTwoChoiceCursor_Bank1B_DrawTile

; Draws the blank tile ($C3) at the yes/no cursor. (C1, E-0357)
UpdateTwoChoiceCursor_Bank1B_Hide::
    ld b, $c3
    jr UpdateTwoChoiceCursor_Bank1B_DrawTile

; Draws the chosen tile ($BC) at the yes/no cursor. (C1, E-0357)
UpdateTwoChoiceCursor_Bank1B_MarkChosen::
    ld b, $bc

; Writes tile B at the yes/no cursor's place (UpdateTwoChoiceCursor_Bank1B_DrawTile_Data), stepping
; back on a scroll wrap, waiting for VRAM access. (C1, E-0357)
UpdateTwoChoiceCursor_Bank1B_DrawTile::
    ld a, [wTwoChoiceCursor]
    sla a
    ld hl, UpdateTwoChoiceCursor_Bank1B_DrawTile_Data
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

; Two words that are offsets from the BG map entry at the top left of the visible screen
; (BGMapAddressAtScroll_Bank1B): $012D and $016D, which are rows 9 and 11 of column 13.
; UpdateTwoChoiceCursor_Bank1B_DrawTile indexes them with wTwoChoiceCursor (0 or 1) and writes tile
; B at that entry, stepping back a row when the view has wrapped. (C1, E-0381)
UpdateTwoChoiceCursor_Bank1B_DrawTile_Data::
    db $2d, $01, $6d, $01

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 15 x 9 tiles, one row per line
LinkKeyTrade_BuildKeyList_TileRect::
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
LinkKeyTrade_DrawListBox_TileRect::
    db $c3, $c3, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1a ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $c3, $c3, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2a ; id 2
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $c3, $c3, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3a ; id 4
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 5
    db $c3, $c3, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4a ; id 6

; record: 1 x 5 tiles, one row per line
LinkKeyTrade_RestoreYesNoArea_TileRect::
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
LinkKeyTrade_DrawYesNoAgain_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $50, $51, $52, $53, $54, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $55, $56, $57, $58, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 15 x 1 tiles, one row per line
LinkKeyTrade_ShowIsItOKTo_TileRect::
    db $b6, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6a, $6b, $c3, $b7 ; id 0

LinkKeyTrade_DrawListBox_Data::
    db $ca, $c3, $f2, $c3, $1a, $c4, $42, $c4

LinkKeyTrade_ReadAnswer2_Data::
    db $25, $c4, $4d, $c4

; record: 6 x 5 tiles, one row per line
LinkKeyTrade_DrawYesNo_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $ce, $cf, $df, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $a5, $71, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; id 4

LinkKeyTrade_SendReady_Data::
    db $bc, $bc, $bc

LinkKeyTrade_SwapKeys_Data::
    db $a0, $a1, $a2

; Link session 4's screen set-up before LinkBattleSetupMenu: clears 256 bytes from wScreenState (B
; starts at 0, so the $6F loaded into C is unused), decompresses Tiles1Gfx (bank $46) into vTiles1,
; clears the screen buffer (ClearScreenBufferAndAttributes_BankF1), opens a text window at vTiles1
; (wTextWindowRows = $02, wTextWindowWidth = $12) and waits until it is open
; (StepTextWindowOpenClose). (C1, E-0369)
RunLinkSession4ScreenState_PrepareSetupMenu_Run::
    ld hl, wScreenState
    ld bc, $006f

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop
    ld b, $46
    ld de, Tiles1Gfx
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

; Runs the VS battle set-up, one frame at a time, by a jump table on wScreenState (16 states): 0
; LinkBattleSetupMenu_Init, 1 LinkBattleSetupMenu_EndIntroText, 2
; LinkBattleSetupMenu_WaitForPartner, 3 LinkBattleSetupMenu_EnterPickRecords, 4
; LinkBattleSetupMenu_PickRecords, 5 LinkBattleSetupMenu_ConfirmAndStart, 6-12
; LinkBattleSetupMenu_RunStatsScreen, 13 LinkBattleSetupMenu_RunScreen, 14
; LinkBattleSetupMenu_ListAfterPrizeScreen and 15 LinkBattleSetupMenu_ListAfterInfoScreen.
; Far-called by RunLinkSession4ScreenState_RunSetupMenu, and also by
; GameMode6_Update_ChooseMonster_RunPickStep, GameMode6_Update_SwitchMonster_RunListStep and
; GameMode6_Update_SwitchMonster_ShowSwitchWithWhich, which reuse its picking and list states. State
; 2 is where every 'refused to battle' path of states 4 and 5 ends up (wScreenState = 2). (C1,
; E-0379)
; a 16-step dispatcher on wScreenState laid out like EggServiceMenu (bank $0D), but only the
; dispatch matches: the steps are this bank's own and run a link exchange (a message, waiting for
; the partner, picking records, starting the link battle) rather than the egg service (E-0363;
; narrows E-0107) (renamed from EggServiceMenu_Bank1B from its E-0357 note, E-0367)
LinkBattleSetupMenu::
    ld a, [wScreenState]
    jumptable
    dw LinkBattleSetupMenu_Init
    dw LinkBattleSetupMenu_EndIntroText
    dw LinkBattleSetupMenu_WaitForPartner
    dw LinkBattleSetupMenu_EnterPickRecords
    dw LinkBattleSetupMenu_PickRecords
    dw LinkBattleSetupMenu_ConfirmAndStart
    dw LinkBattleSetupMenu_RunStatsScreen
    dw LinkBattleSetupMenu_RunStatsScreen
    dw LinkBattleSetupMenu_RunStatsScreen
    dw LinkBattleSetupMenu_RunStatsScreen
    dw LinkBattleSetupMenu_RunStatsScreen
    dw LinkBattleSetupMenu_RunStatsScreen
    dw LinkBattleSetupMenu_RunStatsScreen
    dw LinkBattleSetupMenu_RunScreen
    dw LinkBattleSetupMenu_ListAfterPrizeScreen
    dw LinkBattleSetupMenu_ListAfterInfoScreen

; Link battle setup, state 0: sets sprite hide tile $C0, shows the first string and clears the
; picked rows. (LinkBattleSetupMenu is named after its bank-$0D twin; the strings here are the VS
; battle's.) (C1, E-0357)
LinkBattleSetupMenu_Init::
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

; Link battle setup, state 1: once the text has finished goes on two states. (C2, E-0357; probed
; E-0379)
LinkBattleSetupMenu_EndIntroText::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    ret

; State 2 of LinkBattleSetupMenu, by wScreenStep (5 steps), the aftermath of a refusal: 0
; EggServiceMenu_Bank1B_WaitForPartner_PalRefused waits for a $FE from the partner, 1
; EggServiceMenu_Bank1B_WaitForPartner_ShowWait shows 'Please wait.', 2
; EggServiceMenu_Bank1B_WaitForPartner_SignalReady sends 1, 3
; EggServiceMenu_Bank1B_WaitForPartner_PartnerReady waits for a 1 from the partner and 4
; EggServiceMenu_Bank1B_WaitForPartner_ExitToTitle returns to the title menu (game mode 5). Every
; 'refused to battle' path of the picking and start states shows its message, sends $FE and enters
; this state at step 0. (C1, E-0379)
; by its step: 'Please wait.' and the partner's link message
LinkBattleSetupMenu_WaitForPartner::
    ld a, [wScreenStep]
    jumptable
    dw EggServiceMenu_Bank1B_WaitForPartner_PalRefused
    dw EggServiceMenu_Bank1B_WaitForPartner_ShowWait
    dw EggServiceMenu_Bank1B_WaitForPartner_SignalReady
    dw EggServiceMenu_Bank1B_WaitForPartner_PartnerReady
    dw EggServiceMenu_Bank1B_WaitForPartner_ExitToTitle

; Waiting for the partner, step 0: when the partner sends $FE, goes on. (C2, E-0357; probed E-0379)
EggServiceMenu_Bank1B_WaitForPartner_PalRefused::
    ld a, [wLinkMessage]
    cp $fe
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Waiting for the partner, step 1: 'Please wait.' (string $0C). (C1, E-0357)
EggServiceMenu_Bank1B_WaitForPartner_ShowWait::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $0c ; 'Please wait.'
    call ShowStringA10_Bank1B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Waiting for the partner, step 2: once the text has finished sends 1. (C2, E-0357; probed E-0379)
EggServiceMenu_Bank1B_WaitForPartner_SignalReady::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Waiting for the partner, step 3: when the partner answers 1, goes on. (C2, E-0357; probed E-0379)
EggServiceMenu_Bank1B_WaitForPartner_PartnerReady::
    ld a, [wLinkMessage]
    cp $01
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Waiting for the partner, step 4: once bit 0 of wTextFlags is clear, zeroes $6F bytes from
; wScreenState and requests a change to game mode 5 with wModeState 1 (wModeChangeRequest = 1), the
; title menu start-up GameMode5_Init_TitleMenu. (C2, E-0370; probed E-0379)
EggServiceMenu_Bank1B_WaitForPartner_ExitToTitle::
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

; Link battle setup, state 3: moves on. (C2, E-0357; probed E-0379)
LinkBattleSetupMenu_EnterPickRecords::
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; State 4 of LinkBattleSetupMenu: picking the three team members (and the prize question) from the
; stored monsters, by wScreenStep (14 steps): 0, 1 and 3 run BreedMenu once the text is done
; (LinkBattleSetupMenu_RunRecordList, LinkBattleSetupMenu_RunRecordListAgain; with wScreenState = 4
; BreedMenu runs its own BreedMenu_ChooseParents steps 0, 1 and 3), 2
; DrawRecordListPageIndicators_1B, 4 DrawListEntriesCell5RecordPanel, 5
; ClearAndDrawListEntriesCell5NameAtTiles1780, 6 DrawRuleBoxByLinkRuleTurnLimit1Bit7, 7
; LinkBattleSetupMenu_ShowCursorMark, 8 EggServiceMenu_Bank1B_PickRecords_ListCursor, 9
; LinkBattleSetupMenu_PickRecords_ShowInfoOKYesN, 10 EggServiceMenu_Bank1B_PickRecords_InfoOrOK, 11
; LinkBattleSetupMenu_EraseMarks, 12 LinkBattleSetupMenu_CountPick and 13
; EggServiceMenu_Bank1B_PickRecords_AskMoreOrPrize (itself a jump table on wScreenSubStep). The link
; priest scene GameMode6_Update_ChooseMonster_RunPickStep also runs steps 4, 5 and 9. (C1, E-0379)
; by wScreenStep: record list pages and panels with the 'Info / OK / Yes / No' window
LinkBattleSetupMenu_PickRecords::
    ld a, [wScreenStep]
    jumptable
    dw LinkBattleSetupMenu_RunRecordList
    dw LinkBattleSetupMenu_RunRecordListAgain
    dw DrawRecordListPageIndicators_1B
    dw LinkBattleSetupMenu_RunRecordListAgain
    dw DrawListEntriesCell5RecordPanel
    dw ClearAndDrawListEntriesCell5NameAtTiles1780
    dw DrawRuleBoxByLinkRuleTurnLimit1Bit7
    dw LinkBattleSetupMenu_ShowCursorMark
    dw EggServiceMenu_Bank1B_PickRecords_ListCursor
    dw LinkBattleSetupMenu_PickRecords_ShowInfoOKYesN
    dw EggServiceMenu_Bank1B_PickRecords_InfoOrOK
    dw LinkBattleSetupMenu_EraseMarks
    dw LinkBattleSetupMenu_CountPick
    dw EggServiceMenu_Bank1B_PickRecords_AskMoreOrPrize

; Picking members, step 1: once the text has finished runs the record list's steps (BreedMenu). (C1,
; E-0357)
LinkBattleSetupMenu_RunRecordListAgain::
    ld a, [wTextFlags]
    and a
    ret nz
    farcall BreedMenu
    ret

; Picking members, step 0: once the text has finished runs the record list's steps (BreedMenu). (C1,
; E-0357)
LinkBattleSetupMenu_RunRecordList::
    ld a, [wTextFlags]
    and a
    ret nz
    farcall BreedMenu
    ret

; Step 2 of LinkBattleSetupMenu_PickRecords (also far-called by
; RunLinkSession6Exchange_Pick_ListMonsters): rebuilds the pick list with
; ListAvailableRecordsForSelection, clamps the page and cursor with ClampRecordListPageCursor5
; (which sets wListPages), and when there are two or more pages draws the bracket tiles $C5, $BE,
; $C6 at BG map scroll offset $0142 (DrawC5BEC6AtScrollOffsetDE_Bank1B) and at wWindowTileBuffer +
; $12E (StoreC5BEC6AtHLStride2_Bank1B), and the current page and the page count as digit tiles
; (DrawPageOfPagesAtScrollOffset with offset $0143, DrawPageOfPagesAtArg1_Bank1E at
; wWindowTileBuffer + $12F). Then wScreenStep += 1. (C1, E-0379)
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

; Draws the info panel of the monster under the list cursor: the record index comes from
; SetArg5ToListEntriesCell5 (wListEntries + 5 * wListPageIndex + wListCursor); its family icon is
; loaded as VRAM tile $C7 (LoadFamilyIconTileForRecordB_Bank1B with wArg1 = $C7); the 5 x 1
; rectangle DrawListEntriesCell5RecordPanel_TileRect goes to wWindowTileBuffer + $134 and the 13 x 2
; rectangle DrawListEntriesCell5RecordPanel_TileRect_2 to wWindowTileBuffer + $140; its level and
; sex mark are written from wWindowTileBuffer + $143
; (DrawListEntriesCell5RecordPanel_DrawLevelAndSex); wScreenStep += 1. Step 4 of
; LinkBattleSetupMenu_PickRecords, LinkBattleSetupMenu_DrawCursorPanel, and far-called by
; CallDrawListEntriesCell5RecordPanel. (C1, E-0379)
; for the record at wListEntries cell 5: draws its graphics (LoadFamilyIconTileForRecordB_Bank1B
; with wArg1 = $C7), copies two rectangles to wWindowTileBuffer + $134 and wWindowTileBuffer + $140,
; draws its details at wWindowTileBuffer + $143 (DrawListEntriesCell5RecordPanel_DrawLevelAndSex)
; and wScreenStep += 1 (E-0121)
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
    ld de, DrawListEntriesCell5RecordPanel_TileRect
    ld hl, wWindowTileBuffer + $134
    lb bc, $05, $01
    call CopyRectTo20ByteRows
    ld de, DrawListEntriesCell5RecordPanel_TileRect_2
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
    call DrawListEntriesCell5RecordPanel_DrawLevelAndSex
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Blanks 5 tiles at vTiles1 + $780 (FillTilesFromRequest with the request wTextWindowRows = 1,
; wTextWindowWidth = 5) and draws the name of the record at list cell 5 there
; (DrawListEntriesCell5RecordNameAtTiles1780); wScreenStep += 1. Step 5 of
; LinkBattleSetupMenu_PickRecords, LinkBattleSetupMenu_DrawCursorName, and far-called by
; CallClearAndDrawListEntriesCell5Name and RunLinkSession6Exchange_BackFromStats_DrawName. (C1,
; E-0379)
; clears 5 tiles at vTiles1 + $780, draws the name of the record at wListEntries cell 5 there and
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

; Copies the picks box to wWindowTileBuffer + $6E (CopyRectTo20ByteRows, rows 20 bytes apart): the
; 10 x 7 rectangle DrawRuleBoxByLinkRuleTurnLimit1Bit7_TileRect (three rows marked with the digit
; tiles $E1-$E3) when bit 7 of wLinkRules + $9 is clear, or the 10 x 9 rectangle
; DrawRuleBoxByLinkRuleTurnLimit1Bit7_TileRect_2 (a fourth row below a border row) when it is set;
; then wScreenStep += 1. Bit 7 of wLinkRules + $9 is the bit that makes
; EggServiceMenu_Bank1B_PickRecords_AskPrize ask the prize questions. Step 6 of
; LinkBattleSetupMenu_PickRecords and, through LinkBattleSetupMenu_DrawPicksBox, step 5 of the list
; states. (C2, E-0379)
; copies box DrawRuleBoxByLinkRuleTurnLimit1Bit7_TileRect (10 x 7) or
; DrawRuleBoxByLinkRuleTurnLimit1Bit7_TileRect_2 (10 x 9, when bit 7 of wLinkRules + $9 is set) to
; wWindowTileBuffer + $6E, then wScreenStep += 1 (E-0124) (E-0340: the address in its name read as
; its RAM name; was DrawRuleBoxByLinkRuleTurnLimit1Bit7)
DrawRuleBoxByLinkRuleTurnLimit1Bit7::
    ld a, [wLinkRules + $9]
    bit 7, a
    jr nz, .skip
    ld de, DrawRuleBoxByLinkRuleTurnLimit1Bit7_TileRect
    ld hl, wWindowTileBuffer + $6e
    lb bc, $0a, $07
    call CopyRectTo20ByteRows
    jr .check_screen_step

.skip:
    ld de, DrawRuleBoxByLinkRuleTurnLimit1Bit7_TileRect_2
    ld hl, wWindowTileBuffer + $6e
    lb bc, $0a, $09
    call CopyRectTo20ByteRows

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Picking members, step 7: shows and clears the cursor mark, redraws and resets the string window.
; (C1, E-0357)
LinkBattleSetupMenu_ShowCursorMark::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wListCursor]
    ld b, $bb
    ld hl, LinkBattleSetupMenu_ShowCursorMark_Data
    call StoreBAtWordTableEntry_Bank1B
    call BGMapAddressAtScroll_Bank1B
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_1B
    ld a, [wListCursor]
    ld b, $c3
    ld hl, LinkBattleSetupMenu_ShowCursorMark_Data
    call StoreBAtWordTableEntry_Bank1B
    call SetDefaultStringWindow_Bank1B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Picking members, step 8: the list cursor. When wLinkMessage is $FE (the partner refused) it shows
; 'Your pal refused to battle.' (string $0B), goes to screen state 2 and sends $FE. Otherwise
; UpdatePagedListCursor: $FB/$FC go back 7 steps (redraw), $FD back 4; B ($FE) with no picks refuses
; ('You refused to battle.', state 2, sends $FE), with one or two picks drops the last one, and at
; three or more sets wPickCount to wSelectedRecord - 1 (the count saved by
; EggServiceMenu_Bank1B_PickRecords_AskPrize before it set three); both show 'Choose the members for
; VS battle.', clear the bottom rows and go to step 1. A ($FF) records the pick and, when
; CheckPickAgainstLinkRules allows it, marks the entry, copies its name to wTextBuf0, goes on one
; step and asks 'Pick <BUF0> for the team?' (string 2) or, at three picks, 'Put up <BUF0> as a
; prize?' (string 7). (C1, E-0372)
EggServiceMenu_Bank1B_PickRecords_ListCursor::
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
    call EggServiceMenu_Bank1B_PickRecords_RecordPick
    call CheckPickAgainstLinkRules
    cp $ff
    jr z, .read_list_cursor
    ret

.read_list_cursor:
    ld a, [wListCursor]
    ld b, $bc
    ld hl, LinkBattleSetupMenu_ShowCursorMark_Data
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

; Picking members, step 9: shows the 'Info / OK' choice (string $1E), plays sound $6C and draws its
; box. (C1, E-0357)
LinkBattleSetupMenu_PickRecords_ShowInfoOKYesN::
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
    farcall ShowString_Bank1B
    ld a, $6c
    call QueueSoundEffect
    ld de, EggServiceMenu_InfoOKBoxTileRect
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

; Picking members, step 10: the Info / OK choice (the partner's refusal stops as before): Info opens
; the stats screen (state $0C); OK adds the pick, and with three picks (and the prize not a party
; member) keeps the prize, sets four picks and waits for the partner ('Please wait.'). (C1, E-0357)
EggServiceMenu_Bank1B_PickRecords_InfoOrOK::
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
    ld [wReturnScreenState], a
    ld a, [wScreenStep]
    ld [wReturnScreenStep], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0c
    ld [wScreenState], a
    ret

.call_egg_service_menu_bank1_b_pick_records:
    call EggServiceMenu_Bank1B_PickRecords_RecordPick
    ld a, [wPickCount]
    cp $03
    jr c, .check_screen_step2
    call EggServiceMenu_Bank1B_PickRecords_CursorInParty
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
    ld [wLinkSceneArg], a
    ld a, $04
    ld [wPickCount], a
    call EggServiceMenu_Bank1B_PickRecords_MarkPrize
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

; Picking members, step 11: once the text has finished erases the five marks, redraws and goes back
; three steps. (C1, E-0357)
LinkBattleSetupMenu_EraseMarks::
    ld a, [wTextFlags]
    and a
    ret nz
    ld c, $05
    ld hl, LinkBattleSetupMenu_ShowCursorMark_Data
    call EraseCEntriesOfWordTable_Bank1B
    jr LinkBattleSetupMenu_RedrawBoxAndStepBack

; Erases the five marks (EraseCEntriesOfWordTable_Bank1B), marks the cursor entry with the chosen
; tile ($BC) and falls into LinkBattleSetupMenu_RedrawBoxAndStepBack. Its one caller, picking step
; 10 once the prize monster is chosen, then sets wScreenStep to 0 itself. (C1, E-0370)
EggServiceMenu_Bank1B_PickRecords_MarkPrize::
    ld c, $05
    ld hl, LinkBattleSetupMenu_ShowCursorMark_Data
    call EraseCEntriesOfWordTable_Bank1B
    ld a, [wListCursor]
    ld b, $bc
    ld hl, LinkBattleSetupMenu_ShowCursorMark_Data
    call StoreBAtWordTableEntry_Bank1B

; Draws the box by the rules and goes back three steps. (C1, E-0357)
LinkBattleSetupMenu_RedrawBoxAndStepBack::
    call LinkBattleSetupMenu_EraseInfoOKBox
    call BGMapAddressAtScroll_Bank1B
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_1B
    ld a, [wScreenStep]
    sub $03
    ld [wScreenStep], a
    ret

; Picking members, step 12: when the pick is allowed, redraws, counts it and draws the picked
; members' names and icons. (C1, E-0357)
LinkBattleSetupMenu_CountPick::
    call CheckPickAgainstLinkRules
    cp $ff
    ret nz
    call LinkBattleSetupMenu_EraseInfoOKBox
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

; Picking members, step 13: the partner's refusal stops as before; otherwise runs its sub-steps
; (another member, the prize question, waiting). (C1, E-0357)
EggServiceMenu_Bank1B_PickRecords_AskMoreOrPrize::
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
    dw EggServiceMenu_Bank1B_PickRecords_AskOneMore
    dw LinkBattleSetupMenu_DrawYesNo
    dw EggServiceMenu_Bank1B_PickRecords_AnswerOneMore
    dw EggServiceMenu_Bank1B_PickRecords_BackToPicking
    dw EggServiceMenu_Bank1B_PickRecords_AskPrize
    dw EggServiceMenu_Bank1B_PickRecords_FinishPicks
    dw LinkBattleSetupMenu_DrawYesNo
    dw EggServiceMenu_Bank1B_PickRecords_AnswerPrize

; Choosing another member: below three picks and with members left asks 'Choose one more member for
; battle?' (string 3); otherwise skips to the prize sub-step. (C1, E-0357)
EggServiceMenu_Bank1B_PickRecords_AskOneMore::
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

; Draws the yes/no box (sound $6C), with the answer set to no at three picks. (C1, E-0357)
LinkBattleSetupMenu_DrawYesNo::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, $6c
    call QueueSoundEffect
    ld de, LinkBattleSetupMenu_DrawYesNo_TileRect
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

; The answer to another member: yes clears the box and returns to picking (string 0); no goes on two
; sub-steps. (C1, E-0357)
EggServiceMenu_Bank1B_PickRecords_AnswerOneMore::
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
    call DrawChoiceBoxByLinkRuleTurnLimit1Bit7
    ld a, [wScreenSubStep]
    add $02
    ld [wScreenSubStep], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    and a
    jr nz, .loop
    call DrawChoiceBoxByLinkRuleTurnLimit1Bit7
    xor a
    call ShowStringA10_Bank1B
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Once the text has finished returns to picking (step 0). (C2, E-0357; probed E-0379)
EggServiceMenu_Bank1B_PickRecords_BackToPicking::
    ld a, [wTextFlags]
    and a
    ret nz
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ret

; Sub-step 4 of the picking step 13 (the prize): without the prize rule (wLinkRules + 9 bit 7 clear)
; shows 'Please wait.' (string $0C) and finishes the picks (FinishPickedRecordsEntryAndAdvance).
; With it, when ListRecordsState1NotEggs lists nothing it pads the picks to three with $FF, shows
; 'You have no monsters on the ...' (string 5) and goes on one sub-step; otherwise it shows 'Will
; you put up a prize?' (string 4), pads the picks, saves wPickCount in wSelectedRecord, sets
; wPickCount to 3, goes on two sub-steps and clears wTwoChoiceCursor. (C1, E-0372)
EggServiceMenu_Bank1B_PickRecords_AskPrize::
    ld a, [wLinkRules + $9]
    bit 7, a
    jr nz, .call_list_records_state1_not_eggs
    ld a, $0c ; 'Please wait.'
    call ShowStringA10_Bank1B
    call FinishPickedRecordsEntryAndAdvance
    ret

.call_list_records_state1_not_eggs:
    farcall ListRecordsState1NotEggs
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

; Once the text has finished finishes the picks and shows 'Please wait.'. (C1, E-0357)
EggServiceMenu_Bank1B_PickRecords_FinishPicks::
    ld a, [wTextFlags]
    and a
    ret nz
    call FinishPickedRecordsEntryAndAdvance
    ld a, $0c ; 'Please wait.'
    call ShowStringA10_Bank1B
    ret

; The prize answer: no clears the prize ($FF) and goes back two sub-steps; yes asks 'Select a
; monster as the prize.' (string 6). (C1, E-0357)
EggServiceMenu_Bank1B_PickRecords_AnswerPrize::
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
    call DrawChoiceBoxByLinkRuleTurnLimit1Bit7
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
    call DrawChoiceBoxByLinkRuleTurnLimit1Bit7
    ld a, $06 ; 'Select a monster as the prize.'
    call ShowStringA10_Bank1B
    ld a, $03
    ld [wScreenSubStep], a
    ret

; State 5 of LinkBattleSetupMenu, after the picks: the exchange over the link and the start of the
; battle, by wScreenStep (22 steps): 0 LinkBattleSetupMenu_DrawPickedMembers, 1
; LinkBattleSetupMenu_CopyPrizeRecord, 2, 11, 14 and 19
; EggServiceMenu_Bank1B_StartLinkBattle_SignalReady, 3 and 20
; EggServiceMenu_Bank1B_StartLinkBattle_PalReady, 4 LinkBattleSetupMenu_ExchangePrizes, 5
; EggServiceMenu_Bank1B_StartLinkBattle_AskBegin ('Begin battle?'), 6
; EggServiceMenu_Bank1B_StartLinkBattle_ChoiceBox, 7
; EggServiceMenu_Bank1B_StartLinkBattle_ReadChoice, 8
; EggServiceMenu_Bank1B_StartLinkBattle_RetryChoice, 9
; EggServiceMenu_Bank1B_StartLinkBattle_PleaseWait, 10 and 18
; EggServiceMenu_Bank1B_StartLinkBattle_TextDone, 12
; EggServiceMenu_Bank1B_StartLinkBattle_PalBattleOK, 13 LinkBattleSetupMenu_PackMembers, 15
; EggServiceMenu_Bank1B_StartLinkBattle_SendMembers, 16
; EggServiceMenu_Bank1B_StartLinkBattle_EndExchange, 17
; EggServiceMenu_Bank1B_StartLinkBattle_Announce ('Starting battle') and 21
; LinkBattleSetupMenu_StartBattle. (C1, E-0379)
; by wScreenStep: the picked records, 'Begin battle?', 'Please wait.', 'Starting battle' or 'Your
; pal refused to battle.' over the link
LinkBattleSetupMenu_ConfirmAndStart::
    ld a, [wScreenStep]
    jumptable
    dw LinkBattleSetupMenu_DrawPickedMembers
    dw LinkBattleSetupMenu_CopyPrizeRecord
    dw EggServiceMenu_Bank1B_StartLinkBattle_SignalReady
    dw EggServiceMenu_Bank1B_StartLinkBattle_PalReady
    dw LinkBattleSetupMenu_ExchangePrizes
    dw EggServiceMenu_Bank1B_StartLinkBattle_AskBegin
    dw EggServiceMenu_Bank1B_StartLinkBattle_ChoiceBox
    dw EggServiceMenu_Bank1B_StartLinkBattle_ReadChoice
    dw EggServiceMenu_Bank1B_StartLinkBattle_RetryChoice
    dw EggServiceMenu_Bank1B_StartLinkBattle_PleaseWait
    dw EggServiceMenu_Bank1B_StartLinkBattle_TextDone
    dw EggServiceMenu_Bank1B_StartLinkBattle_SignalReady
    dw EggServiceMenu_Bank1B_StartLinkBattle_PalBattleOK
    dw LinkBattleSetupMenu_PackMembers
    dw EggServiceMenu_Bank1B_StartLinkBattle_SignalReady
    dw EggServiceMenu_Bank1B_StartLinkBattle_SendMembers
    dw EggServiceMenu_Bank1B_StartLinkBattle_EndExchange
    dw EggServiceMenu_Bank1B_StartLinkBattle_Announce
    dw EggServiceMenu_Bank1B_StartLinkBattle_TextDone
    dw EggServiceMenu_Bank1B_StartLinkBattle_SignalReady
    dw EggServiceMenu_Bank1B_StartLinkBattle_PalReady
    dw LinkBattleSetupMenu_StartBattle

; Starting the battle, step 17: 'Starting battle...' (string 9). (C1, E-0357)
EggServiceMenu_Bank1B_StartLinkBattle_Announce::
    ld a, $09 ; 'Starting battle…'
    call ShowStringA10_Bank1B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Starting the battle, step 9: 'Please wait.'. (C1, E-0357)
EggServiceMenu_Bank1B_StartLinkBattle_PleaseWait::
    ld a, $0c ; 'Please wait.'
    call ShowStringA10_Bank1B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Starting the battle, steps 10 and 18 (the jump table of LinkBattleSetupMenu_ConfirmAndStart lists
; it twice): once wTextFlags is zero, wScreenStep += 1; while text is still running it returns. (C2,
; E-0379)
EggServiceMenu_Bank1B_StartLinkBattle_TextDone::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Starting the battle, step 0: once the text has finished draws the picked members' names and icons.
; (C1, E-0357)
LinkBattleSetupMenu_DrawPickedMembers::
    ld a, [wTextFlags]
    and a
    ret nz
    call DrawPickedRecordsRecordNamesAndIcons
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Starting the battle, step 1: copies the prize monster's record into wRecordBufA, or with no prize
; an empty record with the player's name as its master. (C1, E-0357)
LinkBattleSetupMenu_CopyPrizeRecord::
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

; Starting the battle, steps 2, 11, 14 and 19 (the jump table of LinkBattleSetupMenu_ConfirmAndStart
; lists it four times): wScreenStep += 1 and wLinkSendByte = 1, with no waiting. The step after it
; waits for the answer of the partner: EggServiceMenu_Bank1B_StartLinkBattle_PalReady after steps 2
; and 19, EggServiceMenu_Bank1B_StartLinkBattle_PalBattleOK after 11 and
; EggServiceMenu_Bank1B_StartLinkBattle_SendMembers after 14. (C2, E-0379)
EggServiceMenu_Bank1B_StartLinkBattle_SignalReady::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

; Starting the battle, steps 3 and 20 (each after
; EggServiceMenu_Bank1B_StartLinkBattle_SignalReady): when wLinkMessage is 1 clears wLinkSendByte
; and goes on one step; when it is $FE shows 'Your pal refused to battle.' (string $0B), goes to
; screen state 2 (step and sub-step 0) and sends $FE; any other value waits.
; EggServiceMenu_Bank1B_StartLinkBattle_PalBattleOK (step 12) has the same code. (C1, E-0372)
EggServiceMenu_Bank1B_StartLinkBattle_PalReady::
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

; Starting the battle, step 4: exchanges the prize records ($A5 bytes, wRecordBufA out, wRecordBufB
; in). (C2, E-0357; probed E-0379)
LinkBattleSetupMenu_ExchangePrizes::
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

; Starting the battle, step 16: when the exchange ends ($F0), goes on. (C2, E-0357; probed E-0379)
EggServiceMenu_Bank1B_StartLinkBattle_EndExchange::
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

; Starting the battle, step 5: when the exchange ends asks 'Begin battle?' (string 8). (C1, E-0357)
EggServiceMenu_Bank1B_StartLinkBattle_AskBegin::
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

; Starting the battle, step 6: shows the 'Battle / Prize / Exit' choice (string $1F), plays sound
; $6C and draws its box. (C1, E-0357)
EggServiceMenu_Bank1B_StartLinkBattle_ChoiceBox::
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
    farcall ShowString_Bank1B
    ld a, $6c
    call QueueSoundEffect
    ld de, EggServiceMenu_BattlePrizeExitBoxTileRect
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

; Starting the battle, step 7: the choice (the partner's refusal stops as before): Battle goes on
; two steps; Prize shows the partner's prize ('There is no prize for this ...' string $14 without
; the rule, 'There is no prize.' string $15 when none, otherwise its stats screen, state $0D); Exit
; or B refuses ('You refused to battle.'). (C1, E-0357)
EggServiceMenu_Bank1B_StartLinkBattle_ReadChoice::
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
    ld [wReturnScreenState], a
    ld a, [wScreenStep]
    ld [wReturnScreenStep], a
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

; Starting the battle, step 8: once the text has finished goes back to the choice. (C2, E-0357;
; probed E-0379)
EggServiceMenu_Bank1B_StartLinkBattle_RetryChoice::
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    ret

; Starting the battle, step 12: on the partner's 1 goes on; on $FE 'Your pal refused to battle.'.
; (C1, E-0357)
EggServiceMenu_Bank1B_StartLinkBattle_PalBattleOK::
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

; Starting the battle, step 13: picks the link scene (1 for the leader, 0 otherwise), packs the
; picked members into this side's battler records (wBattlerRecords or slot 4) and prepares the
; exchange into the other side's. (C1, E-0357)
LinkBattleSetupMenu_PackMembers::
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .set_link_scene_to_01
    xor a
    ld [wLinkScene], a
    call LinkBattleSetupMenu_PackBattlerRecords
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

.set_link_scene_to_01:
    ld a, $01
    ld [wLinkScene], a
    call LinkBattleSetupMenu_PackBattlerRecords
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

; Starting the battle, step 15: on the partner's 1 starts the $EA-byte exchange of the battler
; records. (C2, E-0357; probed E-0379)
EggServiceMenu_Bank1B_StartLinkBattle_SendMembers::
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

; Starting the battle, step 21: switches to game mode 4 (the battle), link session 1, and clears the
; link bytes. (C2, E-0357; probed E-0379)
LinkBattleSetupMenu_StartBattle::
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

; Link battle setup, state 6: runs the stats screen (SwapMonstersMenu) until its step $0A, then goes
; on three states. (C1, E-0357)
LinkBattleSetupMenu_RunStatsScreen::
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

; Link battle setup, state 13: runs the screen (RunScreenStateWhenNotFading_F1); back in state $0E
; restores the list position. (C1, E-0357)
LinkBattleSetupMenu_RunScreen::
    farcall RunScreenStateWhenNotFading_F1
    ld a, [wScreenState]
    cp $0e
    ret nz
    ld a, [wItemGridX]
    ld [wListCursor], a
    ld a, [wItemGridY]
    ld [wListPageIndex], a
    ret

; State 14 of LinkBattleSetupMenu, by wScreenStep (8 steps): redraws the pick list after the screen
; of the prize of the partner (state 13 ends by moving on to state 14): 0
; LinkBattleSetupMenu_DrawListBox, 1 LinkBattleSetupMenu_ListMembers, 2
; LinkBattleSetupMenu_DrawPageNames, 3 LinkBattleSetupMenu_DrawCursorPanel, 4
; LinkBattleSetupMenu_DrawCursorName, 5 LinkBattleSetupMenu_DrawPicksBox, 6
; LinkBattleSetupMenu_ShowBattlePrizeExit (the 'Battle / Prize / Exit' window) and 7
; LinkBattleSetupMenu_LeaveList, which returns to the wReturnScreenState and wReturnScreenStep that
; EggServiceMenu_Bank1B_StartLinkBattle_ReadChoice saved when the Prize choice was taken. (C1,
; E-0379)
; by wScreenStep: ListAvailableRecordsForSelection, the list page, the record panel and the 'Battle
; / Prize / Exit' window
LinkBattleSetupMenu_ListAfterPrizeScreen::
    ld a, [wScreenStep]
    jumptable
    dw LinkBattleSetupMenu_DrawListBox
    dw LinkBattleSetupMenu_ListMembers
    dw LinkBattleSetupMenu_DrawPageNames
    dw LinkBattleSetupMenu_DrawCursorPanel
    dw LinkBattleSetupMenu_DrawCursorName
    dw LinkBattleSetupMenu_DrawPicksBox
    dw LinkBattleSetupMenu_ShowBattlePrizeExit
    dw LinkBattleSetupMenu_LeaveList

; Listing members, step 6: shows the 'Battle / Prize / Exit' choice (string $1F) and draws its box;
; answer 1. (C1, E-0357)
LinkBattleSetupMenu_ShowBattlePrizeExit::
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
    farcall ShowString_Bank1B
    ld de, EggServiceMenu_BattlePrizeExitBoxTileRect
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

; State 15 of LinkBattleSetupMenu, by wScreenStep (8 steps): the same steps as
; LinkBattleSetupMenu_ListAfterPrizeScreen except that step 6 is EggServiceMenu_ShowInfoOKChoice
; (the 'Info / OK' window with the pick question). It follows the stats screen of state 12, which
; LinkBattleSetupMenu_RunStatsScreen leaves by adding 3 to wScreenState;
; LinkBattleSetupMenu_LeaveList then returns to the state and step saved when Info was chosen. Also
; run by GameMode6_Update_SwitchMonster_RunListStep. (C1, E-0379)
; the LinkBattleSetupMenu_ListAfterPrizeScreen steps again
LinkBattleSetupMenu_ListAfterInfoScreen::
    ld a, [wScreenStep]
    jumptable
    dw LinkBattleSetupMenu_DrawListBox
    dw LinkBattleSetupMenu_ListMembers
    dw LinkBattleSetupMenu_DrawPageNames
    dw LinkBattleSetupMenu_DrawCursorPanel
    dw LinkBattleSetupMenu_DrawCursorName
    dw LinkBattleSetupMenu_DrawPicksBox
    dw EggServiceMenu_ShowInfoOKChoice
    dw LinkBattleSetupMenu_LeaveList

; Listing members, step 0: clears the record panel tiles, draws the list box and marks the cursor
; entry. (C1, E-0357)
LinkBattleSetupMenu_DrawListBox::
    call ClearRecordPanelTiles
    ld de, LinkBattleSetupMenu_DrawListBox_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $0b
    call CopyRectTo20ByteRows
    ld a, [wListCursor]
    ld b, $bc
    ld hl, LinkBattleSetupMenu_ShowCursorMark_Data
    call StoreBAtWordTableEntry_Bank1B
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Listing members, step 1: lists the monsters that may be picked (ListAvailableRecordsForSelection),
; clamps the page cursor and draws the page numbers. (C1, E-0357)
LinkBattleSetupMenu_ListMembers::
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

; Listing members, step 2: draws the page's names and marks the party members. (C1, E-0357)
LinkBattleSetupMenu_DrawPageNames::
    farcall DrawRecordListPageNames
    xor a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    ret

; Listing members, step 3: draws the panel of the monster under the cursor. (C1, E-0357)
LinkBattleSetupMenu_DrawCursorPanel::
    call DrawListEntriesCell5RecordPanel
    ret

; Listing members, step 4: draws the name of the monster under the cursor. (C1, E-0357)
LinkBattleSetupMenu_DrawCursorName::
    call ClearAndDrawListEntriesCell5NameAtTiles1780
    ret

; Listing members, step 5: draws the picks box (DrawRuleBoxByLinkRuleTurnLimit1Bit7, which advances
; wScreenStep): three numbered rows, and a fourth row when bit 7 of wLinkRules + $9 is set, the same
; bit that turns on the prize questions (EggServiceMenu_Bank1B_PickRecords_AskPrize). (C2, E-0370;
; probed E-0379)
LinkBattleSetupMenu_DrawPicksBox::
    call DrawRuleBoxByLinkRuleTurnLimit1Bit7
    ret

; Listing members, step 6 (second list): shows 'Info / OK' and the pick question (string $12, or $17
; for the prize at three picks) and draws its box. (C1, E-0357)
EggServiceMenu_ShowInfoOKChoice::
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
    farcall ShowString_Bank1B
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
    farcall ShowString_Bank1B
    ld de, EggServiceMenu_InfoOKBoxTileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRows
    xor a
    ld [wChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Listing members, step 7 (leaving): redraws the screen and the bottom rows, restores hide tile $70
; and returns to the saved screen state and step. (C1, E-0357)
LinkBattleSetupMenu_LeaveList::
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
    ld a, [wReturnScreenState]
    ld [wScreenState], a
    ld a, [wReturnScreenStep]
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

; Packs the picked members for the battle exchange into this side's battler records: per member its
; name (14 bytes), skills (8), status and $15 bytes of stats, $1F bytes from the personality, its
; item, then $FF. (C1, E-0357)
LinkBattleSetupMenu_PackBattlerRecords::
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

; Copies E bytes from [BC] to [HL]; BC and HL end E bytes on and E = 0. E = 0 copies 256 bytes,
; because E is decremented before it is tested. Used by LinkBattleSetupMenu_PackBattlerRecords for
; the 14-byte name, the 8 skills, $15 stat bytes and $1F personality bytes of each picked member.
; (C2, E-0379)
; copies E bytes from BC to HL; BC and HL advance, E = 0 (E-0115)
CopyEBytesBCToHL::
    ld a, [bc]
    ld [hli], a
    inc bc
    dec e
    jr nz, CopyEBytesBCToHL
    ret

; Blanks the tiles of the record panel and redraws the picked names: FillTilesFromRequest clears 15
; tiles at vTiles1 + $500, 5 at vTiles1 + $700, 5 at vTiles1 + $780, 3 at vTiles1 + $240 and 2 at
; vTiles1 + $4E0; then it runs ClearTileRowsFromPickCount with wPickCount temporarily 0 (all four
; name rows), restores wPickCount and redraws the picked names and icons with
; DrawPickedRecordsRecordNamesAndIcons. Step 0 of the list states (LinkBattleSetupMenu_DrawListBox),
; and far-called by RunLinkSession6Exchange_BackFromStats_DrawInfo and
; RunLinkSession6Exchange_BackFromOwnStats_DrawBox. (C1, E-0379)
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

; Returns $FF when the monster under the cursor is in the party. (C2, E-0357; probed E-0379)
EggServiceMenu_Bank1B_PickRecords_CursorInParty::
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

; Fills wPickedRecords[wPickCount] up to wPickedRecords[2] with $FF (3 - wPickCount entries), so
; unused pick slots read $FF; returns at once, changing nothing, when wPickCount = 3. Used by
; EggServiceMenu_Bank1B_PickRecords_AskPrize and FinishPickedRecordsEntryAndAdvance. (C2, E-0379)
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

; Loads byte C of picked record A (wPickedRecords) from SRAM into hTemp0. (C1, E-0357)
LoadPickedRecordByte::
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

; Returns $FF when the newest pick's family is already among the earlier picks (the one-per-family
; rule), otherwise 0. (C1, E-0357)
PickFamilyAlreadyPicked::
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
    call LoadPickedRecordByte
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

; Erases the 6 x 5 yes/no choice box at wWindowTileBuffer + $112: copies
; DrawChoiceBoxByLinkRuleTurnLimit1Bit7_TileRect (blank tiles $C3) or, when bit 7 of wLinkRules + $9
; is set, DrawChoiceBoxByLinkRuleTurnLimit1Bit7_TileRect_2 (the same with the first row $B4 ... $B5,
; the bottom border of the taller picks box) with CopyRectTo20ByteRows, then redraws 13 rows of the
; window buffer on the BG map (BGMapAddressAtScroll_Bank1B, DrawScreenBufferRectToBGMap_1B with B =
; $14, C = $0D, DE = $01CC). Called after the answer to the 'another member' and prize questions in
; EggServiceMenu_Bank1B_PickRecords_AnswerOneMore and EggServiceMenu_Bank1B_PickRecords_AnswerPrize.
; (C1, E-0379)
; copies box DrawChoiceBoxByLinkRuleTurnLimit1Bit7_TileRect or
; DrawChoiceBoxByLinkRuleTurnLimit1Bit7_TileRect_2 (by bit 7 of wLinkRules + $9) to
; wWindowTileBuffer + $112 and draws it at scroll + $1CC (E-0124) (E-0340: the address in its name
; read as its RAM name; was DrawChoiceBoxByLinkRuleTurnLimit1Bit7)
DrawChoiceBoxByLinkRuleTurnLimit1Bit7::
    ld a, [wLinkRules + $9]
    bit 7, a
    jr nz, .skip
    ld de, DrawChoiceBoxByLinkRuleTurnLimit1Bit7_TileRect
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows
    jr .call_bg_map_address_at_scroll_bank1_b

.skip:
    ld de, DrawChoiceBoxByLinkRuleTurnLimit1Bit7_TileRect_2
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows

.call_bg_map_address_at_scroll_bank1_b:
    call BGMapAddressAtScroll_Bank1B
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_1B
    ret

; Redraws the 8 x 5 block at wWindowTileBuffer + $110, the place of the 'Info / OK' box
; (EggServiceMenu_InfoOKBoxTileRect), with mostly blank tiles (the left column keeps the border
; tiles $B2, $B7, $B5): LinkBattleSetupMenu_EraseInfoOKBox_TileRect when bit 7 of wLinkRules + $9 is
; clear, or LinkBattleSetupMenu_EraseInfoOKBox_TileRect_2, whose first row is the bottom border $B4
; ... $B5 of the taller picks box, when it is set (CopyRectTo20ByteRows, rows 20 apart). It only
; fills the buffer. Called by LinkBattleSetupMenu_RedrawBoxAndStepBack and
; LinkBattleSetupMenu_CountPick, after the Info / OK choice. (C2, E-0379)
LinkBattleSetupMenu_EraseInfoOKBox::
    ld a, [wLinkRules + $9]
    bit 7, a
    jr nz, .skip
    ld de, LinkBattleSetupMenu_EraseInfoOKBox_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRows
    jr .return

.skip:
    ld de, LinkBattleSetupMenu_EraseInfoOKBox_TileRect_2
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRows

.return:
    ret

; Builds the pick list wListEntries from the first $1E stored records (sRecords, SRAM bank 0): the
; 30 bytes of wListEntries and wListEntries2 are zeroed first; a record is listed when its MON_STATE
; is 1, or 2 while wPickCount is not 3, and its MON_EGG byte is 0; while wPickCount is 1 or 2, a
; record already in wPickedRecords is left out. Each listed record index is appended to wListEntries
; and wListCount is the length; wRecordsFlagged counts the records with the right state whose
; MON_EGG byte was not 0. SRAM is switched off (rRAMG2 = 0) and MovePartyRecordsToFrontOfList moves
; the party members to the front. (C1, E-0379)
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

; A = string number: sets wStringIndex = A + $10 and wStringCategory = 0, then far-calls
; BeginStringDisplay_Bank1B to start that string. Every state of the VS set-up uses it for its
; messages, for example A = $0B for 'Your pal refused to battle.' and A = $0C for 'Please wait.'.
; (C1, E-0379)
; wStringIndex = A + $10, wStringCategory = 0, then far-calls BeginStringDisplay_Bank1B (E-0063)
ShowStringA10_Bank1B::
    add $10
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank1B
    ret

; Sets the text window request to the default message area: wTextWindowTileLo/Hi = vTiles1 ($8800),
; wTextWindowRows = 2 and wTextWindowWidth = $12. Changes only those four bytes (and A, HL). (C1,
; E-0379)
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

; B = SRAM record index, wArg1 = VRAM tile number: with SRAM bank 0 on, takes the low nibble of
; MON_FAMILY of the record into wWorkBuf, puts wArg1 in wWorkBuf + 1, and far-calls
; LoadFamilyIconTileForWorkBuf, which writes the 16-byte family icon to that tile. SRAM is switched
; off again at the end (rRAMG2 = 0). Used by DrawListEntriesCell5RecordPanel (tile $C7) and
; DrawPickedRecordsRecordNamesAndIcons. (C1, E-0379)
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

; Draws SRAM record wArg1's level as two digit tiles (a leading zero blanked by
; BlankLeadingZeroDigits_F) at HL = wArg3:wArg2, and its sex mark (tile $CC + (MON_SEX & 1)) seven
; bytes further on. (C1, E-0370)
DrawListEntriesCell5RecordPanel_DrawLevelAndSex::
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

; Clears the not yet used name rows of the picked-members list: with the request 6 tiles x 1
; (wTextWindowRows = 1, wTextWindowWidth = 6) FillTilesFromRequest blanks the rows at vTiles2 +
; $100, $160, $1C0 and $220 starting from row wPickCount (0 clears all four, 1 the last three, 2 the
; last two, 3 the last one, 4 or more none), then SetDefaultStringWindow_Bank1B restores the default
; window request. (C1, E-0379)
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

; Draws the picked monsters: for the first n entries of wPickedRecords (n = wPickCount, but 4 when
; wPickCount is 4 or more; nothing when it is 0), skipping entries that are $FF, it copies the name
; of the record (CopyRecordNameToNameGlyphBuf, MON_NAME, $F0 terminator) and draws its glyph tiles
; at the VRAM address in entry i of DrawPickedRecordsRecordNamesAndIcons_Data1 ($9110, $9170, $91D0,
; $9230), then loads its family icon into the tile in entry i of
; DrawPickedRecordsRecordNamesAndIcons_Data2 ($10, $16, $1C, $22) with
; LoadFamilyIconTileForRecordB_Bank1B. Used by LinkBattleSetupMenu_CountPick,
; LinkBattleSetupMenu_DrawPickedMembers and ClearRecordPanelTiles. (C1, E-0379)
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

; Four words, VRAM addresses $9110, $9170, $91D0, $9230 (vTiles2 + $110, + $170, + $1D0, + $230, six
; tiles apart). DrawPickedRecordsRecordNamesAndIcons draws the name of picked record c (c = 0 to 3,
; up to wPickCount) with CopyGlyphTilesToVRAM at word c; the family icon goes to the tile before it
; (DrawPickedRecordsRecordNamesAndIcons_Data2). (C1, E-0381)
DrawPickedRecordsRecordNamesAndIcons_Data1::
    db $10, $91, $70, $91, $d0, $91, $30, $92

; Four tile numbers $10, $16, $1C, $22 (six apart, in the $9000 area): for picked record c,
; DrawPickedRecordsRecordNamesAndIcons puts the value in wArg1 and
; LoadFamilyIconTileForRecordB_Bank1B writes the family icon of that record to the tile; the name
; tiles of DrawPickedRecordsRecordNamesAndIcons_Data1 begin at the next tile. (C1, E-0381)
DrawPickedRecordsRecordNamesAndIcons_Data2::
    db $10, $16, $1c, $22

; Draws the name of the record at list cell 5 (the byte at the pointer SetArg5ToListEntriesCell5
; puts in wArg5:wArg6): with SRAM bank 0 on it copies the name (CopyRecordNameToNameGlyphBuf,
; MON_NAME) to wNameGlyphBuf, stores the $F0 terminator at wNameGlyphBuf + $A, draws its glyph tiles
; at vTiles1 + $780 (CopyGlyphTilesToVRAM) and switches SRAM off. (C1, E-0379)
; with SRAM bank 0 enabled, copies the name of the record stored at wListEntries cell 5
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

; Records the monster under the cursor as the next pick (wPickedRecords + wPickCount). (C2, E-0357;
; probed E-0379)
EggServiceMenu_Bank1B_PickRecords_RecordPick::
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

; Checks a pick against the link rules: with the total-level rule the picks' levels summed must not
; exceed the limit, with the level rule its level must not exceed wLinkRules + 3 ('Monster level
; limit exceeded. Pick another' string $11, back one step); then the family rule and the rest;
; returns $FF when allowed. (C1, E-0357)
CheckPickAgainstLinkRules::
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
    call LoadPickedRecordByte
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
    jr nz, .call_pick_family_already_picked
    ld a, [wPickCount]
    ld c, $0d
    call LoadPickedRecordByte
    ldh a, [hTemp0]
    and $0f
    sla a
    ld de, CheckPickAgainstLinkRules_Data
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

.call_pick_family_already_picked:
    call PickFamilyAlreadyPicked
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

; Copies the name of the record at list cell 5 into wTextBuf0 for the next message: with SRAM bank 0
; on it gets the record index from SetArg5ToListEntriesCell5, copies the name to wNameGlyphBuf
; (CopyRecordNameToNameGlyphBuf, MON_NAME) and the first 11 bytes of wNameGlyphBuf to wTextBuf0,
; then switches SRAM off (rRAMB and rRAMG = 0). Used before the pick questions ('Pick <BUF0> for the
; team?') by EggServiceMenu_Bank1B_PickRecords_ListCursor and EggServiceMenu_ShowInfoOKChoice, and
; far-called by GameMode6_Update_PageList_Cursor and GameMode6_Update_ChooseEgg_ListCursor. (C1,
; E-0379)
; copies the name of the record at wListEntries cell 5 (11 bytes) to wTextBuf0 (E-0124)
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

; Ends the picking: PadPickedRecordsWithFFToThree fills the unused pick slots with $FF,
; wSelectedRecord = wPickCount, wPackWork = $FF, wPickCount = 4, wScreenStep and wScreenSubStep = 0
; and wScreenState += 1 (to state 5, LinkBattleSetupMenu_ConfirmAndStart). Called by
; EggServiceMenu_Bank1B_PickRecords_AskPrize and EggServiceMenu_Bank1B_PickRecords_FinishPicks. (C2,
; E-0379)
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
DrawListEntriesCell5RecordPanel_TileRect::
    db $b1, $b1, $b1, $b1, $b2 ; id 0

; record: 13 x 2 tiles, one row per line
DrawListEntriesCell5RecordPanel_TileRect_2::
    db $b6, $ea, $ed, $c3, $c3, $f8, $f9, $fa, $fb, $fc, $c3, $c7, $b7 ; id 0
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 1

; record: 10 x 7 tiles, one row per line
DrawRuleBoxByLinkRuleTurnLimit1Bit7_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $e1, $ed, $11, $12, $13, $14, $15, $10, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $e2, $ed, $17, $18, $19, $1a, $1b, $16, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $e3, $ed, $1d, $1e, $1f, $20, $21, $1c, $b7 ; id 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 6

; record: 10 x 9 tiles, one row per line
DrawRuleBoxByLinkRuleTurnLimit1Bit7_TileRect_2::
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
LinkBattleSetupMenu_EraseInfoOKBox_TileRect::
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $b2, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 2
    db $b7, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $b5, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 4

LinkBattleSetupMenu_EraseInfoOKBox_TileRect_2::
    db $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $b2, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 2
    db $b7, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $b5, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 4

TileRect_1B::
; another name for the data at TileRect_1B, whose note is above (E-0381)
EggServiceMenu_InfoOKBoxTileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $70, $71, $72, $73, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $74, $75, $c3, $c3, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

LinkBattleSetupMenu_ShowCursorMark_Data::
    db $79, $c3, $a1, $c3, $c9, $c3, $f1, $c3, $19, $c4

CheckPickAgainstLinkRules_Data::
    db $00, $40, $00, $20, $00, $10, $00, $08, $00, $04, $00, $02, $00, $01, $80, $00
    db $40, $00, $20, $00, $10, $00

; record: 6 x 5 tiles, one row per line
DrawChoiceBoxByLinkRuleTurnLimit1Bit7_TileRect::
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 2
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 4

DrawChoiceBoxByLinkRuleTurnLimit1Bit7_TileRect_2::
    db $b4, $b4, $b4, $b4, $b4, $b5 ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 2
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 4

LinkBattleSetupMenu_DrawYesNo_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $76, $77, $78, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $79, $73, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; id 4

; record: 9 x 7 tiles, one row per line
TileRect_1B_2::
; another name for the data at TileRect_1B_2, whose note is above (E-0381)
EggServiceMenu_BattlePrizeExitBoxTileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $30, $31, $32, $33, $34, $35, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $36, $37, $38, $39, $3a, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $3b, $3c, $3d, $3e, $c3, $c3, $b7 ; id 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 6

; record: 8 x 11 tiles, one row per line
LinkBattleSetupMenu_DrawListBox_TileRect::
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
