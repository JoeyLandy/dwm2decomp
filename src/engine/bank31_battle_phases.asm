; ROM bank $31: battle phases, the end of a battle, slot drawing
; The annotated listing of this bank is build/listing/bank31.asm.

SECTION "Bank 31", ROMX[$4000], BANK[$31]
    db $31

; Start-up of game mode 4, the battle (RunGameModeInit_Battle far-calls it). Starts music 2, sends
; the SGB palette packet when wSGBActive is set, clears the scroll registers, fills vBGMap0 with
; tile $C3 (and, on a Color Game Boy, the attribute map in VRAM bank 1 with 0), puts the text cursor
; at vBGMap0 + $1C1 and far-calls GameMode4_Init_SetUpBattle. It then decompresses Tiles1Plus240Gfx
; to vTiles1 + $240 and Tiles1Plus5F0Gfx to vTiles1 + $5F0, fills 18 x 2 tiles at vTiles1
; (FillTilesRequest), starts palette fade $FC, sets hWindowX = 7, hWindowY = $FF and wLCDCShadow =
; 3, and ends by jumping to ResumeAfterModeChange with A = $0B. (C1, E-0378)
; start-up for wGameMode = 4, the battle: starts music 2, clears the BG map and builds the battle
; screen; reached from the debug battle setup (Start) and from encounters (E-0042)
GameMode4_Init::
    call ClearSTATInterruptSources
    ld a, $02
    call QueueMusic
    ld a, [wSGBActive]
    or a
    jr z, .clear_scroll_x
    ld a, $00
    ld [wSGBPaletteSet], a
    ld a, $00
    ld [wSGBAttrFile], a
    farcall SendSGBPaletteSetPacket

.clear_scroll_x:
    xor a
    ldh [hScrollX], a
    ldh [hScrollXHi], a
    xor a
    ldh [hScrollY], a
    ldh [hScrollYHi], a
    ld hl, vBGMap0
    ld bc, $0400
    ld a, $c3
    call FillBytes
    ld a, [wIsCGB]
    or a
    jr z, .set_text_cursor_lo
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $0400
    xor a
    call FillBytes
    xor a
    ldh [rVBK], a

.set_text_cursor_lo:
    ld hl, vBGMap0 + $1c1
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    farcall GameMode4_Init_SetUpBattle
    ld b, $31
    ld de, Tiles1Plus240Gfx
    ld hl, vTiles1 + $240
    call DecompressToRAMLocked
    ld b, $31
    ld de, Tiles1Plus5F0Gfx
    ld hl, vTiles1 + $5f0
    call DecompressToRAMLocked
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld hl, vBGMap0 + $1c1
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    ld a, $fc
    call StartPaletteFade
    ld a, $07
    ldh [hWindowX], a
    ld a, $ff
    ldh [hWindowY], a
    ld a, $00
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $0b
    jp ResumeAfterModeChange

; Frame routine of game mode 4, the battle (RunGameModeUpdate_Battle far-calls it). In link mode it
; runs LinkExchangeJoypadPerFrame, then (unless wEffectId is $FF) RunBattleEffectAnimation and, when
; wEffectAnimState is 2, TickSequencePtrLoSequence with interrupts off; the phase machine then runs
; from RunLinkSession1Exchange_Receive. Outside link mode it counts the play time
; (IncrementPlayTime_Bank31) and falls into RunBattlePhase. (C1, E-0378)
; per-frame routine for wGameMode = 4, the battle: in link mode (wLinkMode) it serves the serial
; link, otherwise IncrementPlayTime_Bank31 and the phase machine RunBattlePhase (wBattlePhase =
; phase (1 fight, 2 after), wBattleStep = step)
GameMode4_Update::
    ld a, [wLinkMode]
    or a
    jr z, .call_increment_play_time_bank31
    call LinkExchangeJoypadPerFrame
    ld a, [wEffectId]
    cp $ff
    ret z
    farcall RunBattleEffectAnimation
    ld a, [wEffectAnimState]
    cp $02
    ret nz
    di
    farcall TickSequencePtrLoSequence
    ei
    ret

.call_increment_play_time_bank31:
    call IncrementPlayTime_Bank31

; Jump table on wBattlePhase: 0 BattlePhase0 (the start of the battle), 1 BattlePhaseFight (the
; fight), 2 BattlePhaseEnd (after the fight). Called every frame outside link mode by
; GameMode4_Update and in link mode by RunLinkSession1Exchange_Receive; each phase is a jump table
; on wBattleStep. (C1, E-0378)
; runs BattlePhase0, BattlePhaseFight or BattlePhaseEnd for wBattlePhase (E-0122)
RunBattlePhase::
    ld a, [wBattlePhase]
    jumptable
    dw BattlePhase0
    dw BattlePhaseFight
    dw BattlePhaseEnd

; Phase 0 of RunBattlePhase, the start of the battle: a jump table on wBattleStep with
; BattlePhase0_WaitForFade (wait for the fade), Step1 (draw the screen), Step2 (the intro message),
; Step3 (a possible surprise round) and Step4 (go on to the fight). (C1, E-0378)
; wBattlePhase = 0: the start of the battle (E-0044)
BattlePhase0::
    ld a, [wBattleStep]
    jumptable
    dw BattlePhase0_WaitForFade
    dw BattlePhase0_DrawScreen
    dw BattlePhase0_Intro
    dw BattlePhase0_RollSurpriseRound
    dw BattlePhase0_StartFightPhase

; Waits for the palette fade of GameMode4_Init: returns while wFadeState is not 0, then wBattleStep
; += 1. (C2, E-0378)
; wBattlePhase 0, wBattleStep 0 (E-0044)
BattlePhase0_WaitForFade::
    ld a, [wFadeState]
    or a
    ret nz
    ld hl, wBattleStep
    inc [hl]
    ret

; Clears the window and copies the screen rectangle (ClearWindowAndCopyRectFar), draws the screen
; tile buffer to the background map (CopyScreenBufferRect20x11ToBGMapRow7), wBattleStep += 1,
; wBattleArg0 = 0 and, in link mode, wArg1 = 0 (the part counter of BattlePhase0_Intro). (C1,
; E-0378)
; wBattlePhase 0, wBattleStep 1 (E-0044)
BattlePhase0_DrawScreen::
    call ClearWindowAndCopyRectFar
    call CopyScreenBufferRect20x11ToBGMapRow7
    ld hl, wBattleStep
    inc [hl]
    xor a
    ld [wBattleArg0], a
    ld a, [wLinkMode]
    and a
    ret z
    xor a
    ld [wArg1], a
    ret

; Intro message of the battle. Outside link battles it jumps to BattlePhase0_Intro_Message. In link
; battles it is a jump table on wArg1, one part per call: 0 BattlePhase0_Intro_SendSync, 1
; BattlePhase0_Intro_ReceiveSync, 2 BattlePhase0_Intro_ExchangeNames, 3
; BattlePhase0_Intro_CopyPartnerName; each part moves wArg1 on itself, and part 3 ends in the intro
; message. (C1, E-0378)
; wBattlePhase 0, wBattleStep 2 (E-0044)
BattlePhase0_Intro::
    ld a, [wLinkMode]
    or a
    jp z, BattlePhase0_Intro_Message
    ld a, [wArg1]
    jumptable
    dw BattlePhase0_Intro_SendSync
    dw BattlePhase0_Intro_ReceiveSync
    dw BattlePhase0_Intro_ExchangeNames
    dw BattlePhase0_Intro_CopyPartnerName

; Battle start, step 2, part 0 (link): sends $D2; next part. (C2, E-0357; probed E-0378)
BattlePhase0_Intro_SendSync::
    ld a, [wArg1]
    inc a
    ld [wArg1], a
    ld a, $d2
    ld [wLinkSendByte], a
    ret

; Part 1: once the partner's $D2 arrives, clears the send byte; next part. (C2, E-0357; probed
; E-0378)
BattlePhase0_Intro_ReceiveSync::
    ld a, [wLinkMessage]
    cp $d2
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld a, [wArg1]
    inc a
    ld [wArg1], a
    ret

; Part 2: starts exchanging names: sends wPlayerName (10 bytes) and receives the partner's into
; wBattleTextWork (link buffer, ready); next part. (C2, E-0357; probed E-0378)
BattlePhase0_Intro_ExchangeNames::
    ld a, [wArg1]
    inc a
    ld [wArg1], a
    ld hl, wPlayerName
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, $000a
    ld a, l
    ld [wLinkBufferCountLo], a
    ld a, h
    ld [wLinkBufferCountHi], a
    ld hl, wBattleTextWork
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $ff
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a
    ret

; Part 3: once the exchange ends ($F0), ends the partner's name and copies it to wTextBuf0 (five
; letters plus marks); then the intro message. (C1, E-0357)
BattlePhase0_Intro_CopyPartnerName::
    ld a, [wLinkMessage]
    cp $f0
    ret nz
    xor a
    ld [wLinkSendByte], a
    xor a
    ld [wLinkReady], a
    xor a
    ld [wArg1], a
    ld a, $f0
    ld [wBattleTextWork2], a
    ld de, wBattleTextWork
    ld hl, wTextBuf0
    call CopyFiveGlyphsPlusMarks
    jp BattlePhase0_Intro_Message_AllSame

; Battle start, step 2 outside link battles: copies the foes' names (the three monster id words of
; wBattlePictureIds; the second when there are two or more foes, the third with three) to
; wTextBuf0-wTextBuf2 (CopyMonsterNameToDE_Bank31) and picks battle string 0 ('<name> appears!') for
; one foe; otherwise a 'Monsters appear!' string: 1 when every foe is the same species, 2 when the
; first two match and the third differs, 3 for two different foes, 5 when the first two differ and
; the third matches the second, 4 when the first two differ and the third differs from the second
; (it may match the first). (C1, E-0370)
BattlePhase0_Intro_Message::
    ld a, [wBattlePictureIds]
    ld l, a
    ld a, [wBattlePictureIds + $1]
    ld h, a
    ld de, wTextBuf0
    call CopyMonsterNameToDE_Bank31
    ld a, [wBattlePictureIds + $2]
    ld l, a
    ld a, [wBattlePictureIds + $3]
    ld h, a
    ld de, wTextBuf1
    ld a, [wBattleFoeCount]
    cp $01
    call nz, CopyMonsterNameToDE_Bank31
    ld a, [wBattlePictureIds + $4]
    ld l, a
    ld a, [wBattlePictureIds + $5]
    ld h, a
    ld de, wTextBuf2
    ld a, [wBattleFoeCount]
    cp $03
    call z, CopyMonsterNameToDE_Bank31
    ld a, [wBattleFoeCount]
    cp $01
    jr z, .skip
    ld a, [wBattlePictureIds]
    ld e, a
    ld a, [wBattlePictureIds + $1]
    ld d, a
    ld a, [wBattlePictureIds + $2]
    cp e
    jr nz, .check_battle_foe_count
    ld a, [wBattlePictureIds + $3]
    cp d
    jr nz, .check_battle_foe_count
    ld a, [wBattleFoeCount]
    cp $02
    jr z, BattlePhase0_Intro_Message_AllSame
    ld a, [wBattlePictureIds + $4]
    cp e
    jr nz, BattlePhase0_Intro_Message_FirstTwoMatch
    ld a, [wBattlePictureIds + $5]
    cp d
    jr nz, BattlePhase0_Intro_Message_FirstTwoMatch
    jr BattlePhase0_Intro_Message_AllSame

.check_battle_foe_count:
    ld a, [wBattleFoeCount]
    cp $02
    jr z, BattlePhase0_Intro_Message_TwoFoesDiffer
    ld a, [wBattlePictureIds + $2]
    ld e, a
    ld a, [wBattlePictureIds + $3]
    ld d, a
    ld a, [wBattlePictureIds + $4]
    cp e
    jr nz, BattlePhase0_Intro_Message_LastTwoDiffer
    ld a, [wBattlePictureIds + $5]
    cp d
    jr nz, BattlePhase0_Intro_Message_LastTwoDiffer
    jr BattlePhase0_Intro_Message_LastTwoMatch

.skip:
    ld a, $00
    jr BattlePhase0_Intro_Message_Show

; Intro message 1 (HL = wTextBuf0). (C1, E-0357)
BattlePhase0_Intro_Message_AllSame::
    ld hl, wTextBuf0
    ld a, $01
    jr BattlePhase0_Intro_Message_Show

; Intro message 2. (C1, E-0357)
BattlePhase0_Intro_Message_FirstTwoMatch::
    ld a, $02
    jr BattlePhase0_Intro_Message_Show

; Intro message 3. (C1, E-0357)
BattlePhase0_Intro_Message_TwoFoesDiffer::
    ld a, $03
    jr BattlePhase0_Intro_Message_Show

; Intro message 4. (C1, E-0357)
BattlePhase0_Intro_Message_LastTwoDiffer::
    ld a, $04
    jr BattlePhase0_Intro_Message_Show

; Intro message 5. (C1, E-0357)
BattlePhase0_Intro_Message_LastTwoMatch::
    ld a, $05

; Starts intro message A of bank $2F's category 0 and goes to the next battle step. (C1, E-0357)
BattlePhase0_Intro_Message_Show::
    ld [wStringIndex], a ; 'Monsters appear!'
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleStep
    inc [hl]
    ret

; HL = a monster id, DE = destination: H += 2 (the monster names are string categories 2 and 3, one
; per high byte of the id) and CopyStringHLToDE copies the name with its $F0 end byte to DE. The
; intro message calls it for up to three foes. (C2, E-0378)
; HL = monster id: H += 2 (string categories 2 and 3 hold the monster names), then CopyStringHLToDE
; (E-0115)
CopyMonsterNameToDE_Bank31::
    ld a, h
    add $02
    ld h, a
    call CopyStringHLToDE
    ret

; Waits until wTextFlags is 0, then wBattlePhase += 1, wBattleStep = 0, wBattleSubPhase = 0. In link
; battles and in battle kinds 2 and up it sets wBattleTurn = 1 and returns. Otherwise it draws
; random values: wRandomLo below 8 (one NextTableByte) makes a surprise round with string $0B +
; (wRandomHi & 1), wBattleArg0 = 0, the foe slots 4-6 marked; else, when the next wRandomHi is below
; 8, string $0D + (wRandomLo & 1), wBattleArg0 = 1, the party slots 0-2 marked; else wBattleTurn = 1
; and nothing more. For a surprise round each of the three marks in wSlotMarks becomes 3 (or $FF for
; a slot whose wBattleSlotOut is $FF), BattlePhase0_RollSurpriseRound_FoeName fills wTextBuf0, the
; string of category 0 of bank $2F is shown (the first pair, $0B and $0C, says the foes are stunned:
; 'appeared stunned!' for $0C; the second pair, $0D and $0E, says the foes strike first: 'suddenly
; attacked!' for $0D and 'struck without warning!' for $0E), wBattlePhase goes back by 1 and
; wBattleStep = 4. (C1, E-0378)
; wBattlePhase 0, wBattleStep 3 (E-0044)
BattlePhase0_RollSurpriseRound::
    ld a, [wTextFlags]
    or a
    ret nz
    ld hl, wBattlePhase
    inc [hl]
    xor a
    ld [wBattleStep], a
    xor a
    ld [wBattleSubPhase], a
    ld a, [wLinkMode]
    or a
    jp nz, .set_battle_turn_to_01
    ld a, [wBattleKind]
    cp $02
    jp nc, .set_battle_turn_to_01
    call NextTableByte
    ld a, [wRandomLo]
    cp $08
    jr nc, .call_next_table_byte
    ld a, [wRandomHi]
    and $01
    add $0b
    ld [wStringIndex], a
    ld a, $00
    ld [wBattleArg0], a
    ld c, $04
    jr .skip

.call_next_table_byte:
    call NextTableByte
    ld a, [wRandomHi]
    cp $08
    jr nc, .set_battle_turn_to_01
    ld a, [wRandomLo]
    and $01
    add $0d
    ld [wStringIndex], a
    ld a, $01
    ld [wBattleArg0], a
    ld c, $00

.skip:
    ld b, $03

.loop:
    ld a, c
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr z, .skip2
    ld [hl], $03
    jr .next

.skip2:
    ld [hl], $ff

.next:
    inc c
    dec b
    jr nz, .loop
    ld a, $00
    ld [wStringCategory], a
    call BattlePhase0_RollSurpriseRound_FoeName
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattlePhase
    dec [hl]
    ld a, $04
    ld [wBattleStep], a
    jr .return

.set_battle_turn_to_01:
    ld a, $01
    ld [wBattleTurn], a

.return:
    ret

; The foes' name for the next message in wTextBuf0: one foe's own name, 'Monsters' when all are the
; same species, otherwise a fixed text (BattlePhase0_RollSurpriseRound_FoeName_Data1, or Data2 for
; strings $0B-$0E, 9 or 13 bytes). (C2, E-0357; probed E-0378)
BattlePhase0_RollSurpriseRound_FoeName::
    ld a, [wBattlePictureIds]
    ld e, a
    ld a, [wBattlePictureIds + $1]
    ld d, a
    ld a, [wBattleFoeCount]
    cp $01
    jr z, .call_battle_phase0_roll_surprise_round_foe
    ld a, [wBattlePictureIds + $2]
    cp e
    jr nz, .skip2
    ld a, [wBattlePictureIds + $3]
    cp d
    jr nz, .skip2
    ld a, [wBattleFoeCount]
    cp $02
    jr z, .skip
    ld a, [wBattlePictureIds + $4]
    cp e
    jr nz, .skip2
    ld a, [wBattlePictureIds + $5]
    cp d
    jr nz, .skip2
    jr .skip

.call_battle_phase0_roll_surprise_round_foe:
    call BattlePhase0_RollSurpriseRound_FoeName_OneFoe
    jr .return

.skip:
    ld hl, wTextBuf0
    ld [hl], $16
    inc hl
    ld [hl], $32
    inc hl
    ld [hl], $31
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $37
    inc hl
    ld [hl], $28
    inc hl
    ld [hl], $35
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $f0
    jr .return

.skip2:
    ld hl, wTextBuf0
    ld de, BattlePhase0_RollSurpriseRound_FoeName_Data1
    ld b, $09
    ld a, [wStringIndex]
    cp $0b
    jr nz, .cp_0C
    ld de, BattlePhase0_RollSurpriseRound_FoeName_Data2
    ld b, $09
    jr .loop

.cp_0C:
    cp $0c
    jr nz, .cp_0D
    ld de, BattlePhase0_RollSurpriseRound_FoeName_Data2
    ld b, $0d
    jr .loop

.cp_0D:
    cp $0d
    jr nz, .cp_0E
    ld de, BattlePhase0_RollSurpriseRound_FoeName_Data2
    ld b, $0d
    jr .loop

.cp_0E:
    cp $0e
    jr nz, .loop
    ld b, $09
    ld de, BattlePhase0_RollSurpriseRound_FoeName_Data2

.loop:
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop

.return:
    ret

; Copies the foe's name (monster id DE: categories 2 and 3 of the strings) to wTextBuf0, keeping
; wStringCategory and wStringIndex. (C2, E-0357; probed E-0378)
BattlePhase0_RollSurpriseRound_FoeName_OneFoe::
    ld a, [wStringCategory]
    ld l, a
    ld a, [wStringIndex]
    ld h, a
    push hl
    ld l, e
    ld a, d
    add $02
    ld h, a
    ld de, wTextBuf0
    call CopyStringHLToDE
    ld hl, wTextBuf0

.skip:
    ld a, [hl]
    cp $f0
    jr z, .set_string_category
    inc hl
    jr .skip

.set_string_category:
    pop de
    ld a, e
    ld [wStringCategory], a
    ld a, d
    ld [wStringIndex], a
    ret

; data read by BattlePhase0_RollSurpriseRound_FoeName (9 bytes) (E-0347)
BattlePhase0_RollSurpriseRound_FoeName_Data1::
    db $30, $32, $31, $36, $37, $28, $35, $36, $f0

BattlePhase0_RollSurpriseRound_FoeName_Data2::
    db $16, $32, $31, $36, $37, $28, $35, $36, $f0

; Waits until wTextFlags is 0 (the message is done), then wBattlePhase += 1 (the fight) and
; wBattleStep = 0. Returns with A = wBattleArg0 and the flags of that byte (0 after a normal intro
; or surprise by the party, 1 after the foes struck first). (C2, E-0378)
; wBattlePhase 0, wBattleStep 4 (E-0044)
BattlePhase0_StartFightPhase::
    ld a, [wTextFlags]
    or a
    ret nz
    ld hl, wBattlePhase
    inc [hl]
    xor a
    ld [wBattleStep], a
    ld a, [wBattleArg0]
    or a
    ret

; Phase 1 of RunBattlePhase, the fight: a jump table on wBattleStep with BattleFight_BeginRound
; (start a round), Step1 (RunBattleSetup, the command menus), Step2 (RunBattleCommandEntry, the turn
; order and commands), Step3 (RunBattleActions, executing the actions) and Step4 (RunBattleStep4).
; (C1, E-0378)
; wBattlePhase = 1: the fight; steps: 1 set-up, 2 command entry, 3 executing the actions (E-0044)
BattlePhaseFight::
    ld a, [wBattleStep]
    jumptable
    dw BattleFight_BeginRound
    dw BattleFight_ChooseCommands
    dw BattleFight_Step2
    dw BattleFight_RunActions
    dw BattleFight_Step4

; Waits until wTextFlags is 0, then BattleFight_BeginRound_StartRound resets the round (wSideControl
; bit 7, wPersonalityActs, wActionQueue, wBattleActionChoice, the item bytes, wMenuState) and marks
; the slots; wBattleStep += 1 afterwards (that routine adds one more when none of the marks of the
; player side was 0 before it marked the slots again). (C2, E-0378)
; battle fight, step 0: waits for the text, clears the battle work area (FillBytes) and moves on
; (E-0354; was: wBattlePhase 1, wBattleStep 0 (E-0044))
BattleFight_BeginRound::
    ld a, [wTextFlags]
    or a
    ret nz
    call BattleFight_BeginRound_StartRound
    ld hl, wBattleStep
    inc [hl]
    ret

; Runs RunBattleSetup, the command menus of the round (a jump table on wBattleSubPhase). (C1,
; E-0378)
; wBattlePhase 1, wBattleStep 1 (E-0044)
BattleFight_ChooseCommands::
    call RunBattleSetup
    ret

; Far-calls RunBattleCommandEntry: the turn order and the command entry of every slot (sub-steps on
; wBattleSubPhase). (C1, E-0378)
; wBattlePhase 1, wBattleStep 2 (E-0044)
BattleFight_Step2::
    farcall RunBattleCommandEntry
    ret

; Far-calls RunBattleActions: executes the chosen actions (sub-steps on wBattleSubPhase). (C1,
; E-0378)
; wBattlePhase 1, wBattleStep 3 (E-0044)
BattleFight_RunActions::
    farcall RunBattleActions
    ret

; Far-calls RunBattleStep4, the last sub-steps of the round (not seen in the first battle by earlier
; readings). (C1, E-0378)
; wBattlePhase 1, wBattleStep 4 (E-0044)
BattleFight_Step4::
    farcall RunBattleStep4
    ret

; Phase 2 of RunBattlePhase, after the fight: a jump table on wBattleStep, entries 0-9:
; BattleEnd_DrawScreen to Step6, BattleEnd_LinkFinish for both 7 and 8, and BattleEnd_QueueEndSound
; (result message, experience, join offer, back to the field). (C1, E-0378)
; wBattlePhase = 2: after the fight; steps 0-9 (result message, rewards, recruiting) (E-0044)
BattlePhaseEnd::
    ld a, [wBattleStep]
    jumptable
    dw BattleEnd_DrawScreen
    dw BattleEnd_Result
    dw BattleEnd_WaitForSound
    dw BattleEnd_Records
    dw BattleEnd_AwardExperience
    dw BattleEnd_OfferJoin
    dw BattleEnd_ReturnToField
    dw BattleEnd_LinkFinish
    dw BattleEnd_LinkFinish
    dw BattleEnd_QueueEndSound

; Queues music 2 (QueueMusic), clears the window and copies the screen rectangle
; (ClearWindowAndCopyRectFar), draws the screen tile buffer to the background map
; (CopyScreenBufferRect20x11ToBGMapRow7) and wBattleStep += 1. (C1, E-0378)
; wBattlePhase 2, wBattleStep 0 (E-0044)
BattleEnd_DrawScreen::
    ld a, $02
    call QueueMusic
    call ClearWindowAndCopyRectFar
    call CopyScreenBufferRect20x11ToBGMapRow7
    ld hl, wBattleStep
    inc [hl]
    ret

; Shows the closing message of the battle. Sets wTextSpeed = 1, BattleEnd_Result_SetResult sets the
; result in wBattleScene, and the string of category 0 of bank $2F is chosen: 6 (the wiped-out text
; of the party of the player) when wBattleScene bit 0 is set; otherwise
; BattleEnd_Result_SetMessageName fills wTextBuf0 and the string is 8 + wBattleArg0 for wBattleScene
; 2 ('left the scene'), $87 in link mode 1 (the wiped-out text with the name of the partner), 7
; ('Monsters were defeated!') when wBattleArg0 is 1 or more and $86 ('Monster was defeated!') for 0.
; BeginStringDisplay_Bank2F starts it and wBattleStep += 1. (C1, E-0378)
; battle end, step 1: at text speed 1 shows the battle's closing message, battle text 6, 7, 8 +
; wBattleArg0, $86 or $87 by wBattleScene, link mode and wBattleArg0 (E-0354; was: wBattlePhase 2,
; wBattleStep 1 (E-0044))
BattleEnd_Result::
    ld a, $01
    ld [wTextSpeed], a
    call BattleEnd_Result_SetResult
    ld a, [wBattleScene]
    and $01
    jr z, .call_battle_end_result_set_message_name
    ld a, $06
    jr .set_string_index

.call_battle_end_result_set_message_name:
    call BattleEnd_Result_SetMessageName
    ld a, [wBattleScene]
    cp $02
    jr z, .read_battle_arg0
    ld a, [wLinkMode]
    cp $01
    jr nz, .check_battle_arg0
    ld a, $87
    jr .set_string_index

.check_battle_arg0:
    ld a, [wBattleArg0]
    cp $01
    ld a, $07
    jr nc, .set_string_index
    ld a, $86
    jr .set_string_index

.read_battle_arg0:
    ld a, [wBattleArg0]
    add $08

.set_string_index:
    ld [wStringIndex], a
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleStep
    inc [hl]
    ret

; Waits for the message and the sound. When all twelve bytes of wSoundChannelSlots, wSoundChannel1
; to wSoundChannel5 (two bytes each) are $FF it counts wBattleEndTimer down
; (BattleEnd_WaitForSound_CountDownTimer; nothing here tests the timer). Returns while wTextFlags is
; not 0; then wBattleStep += 1 and wBattleSubPhase = 0. (C2, E-0378)
; battle end, step 2: waits until every sound channel is idle and the text has finished, counting
; wBattleEndTimer down, then moves on (E-0354; was: wBattlePhase 2, wBattleStep 2 (E-0044))
BattleEnd_WaitForSound::
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannelSlots + $1
    and [hl]
    ld hl, wSoundChannel1
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel2
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel3
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel4
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel5
    and [hl]
    inc hl
    and [hl]
    cp $ff
    call z, BattleEnd_WaitForSound_CountDownTimer
    ld a, [wTextFlags]
    or a
    ret nz
    ld hl, wBattleStep
    inc [hl]
    xor a
    ld [wBattleSubPhase], a
    ret

; Counts wBattleEndTimer down. (C2, E-0357; probed E-0378)
BattleEnd_WaitForSound_CountDownTimer::
    ld a, [wBattleEndTimer]
    dec a
    ld [wBattleEndTimer], a
    ret nz
    ret

; Stores the result of the battle in the party records and builds the record of a foe that may join.
; BattleEnd_Records_UpdatePartyRecords runs first (not in link battles); wBattleStep += 1 and
; wBattleSubPhase = 0, and then the step goes on by 3 more in a link battle (to step 7) or by 2 more
; for any non-zero wBattleScene (to step 6). With wBattleScene 0 and wDisplaySlot 4-6 it sums the
; experience award (BattleEnd_Records_SumExpAward, link mode 0), may replace a special foe
; (BattleEnd_Records_ReplaceSpecialFoe) and builds the foe as a save-format record in wRecordBufA
; from the battler record of wDisplaySlot (name, species, family, the name of the player as master
; name, placeholder parent names, skills without $C8, status, level, stats, personality and
; resistances, equipment byte), then far-calls BattleEnd_Records_BuildSkillList,
; BattleEnd_Records_ShapeJoiner and LoadTableEntryForRecordBufASpeciesToRecordBufAExp. With any
; other wDisplaySlot it stops at step 4. (C2, E-0378)
; battle end, step 3: settles the battle MP (BattleEnd_Records_UpdatePartyRecords) and moves on,
; skipping the next steps for link battles and for battle scenes 2 and 3 (E-0354; was: wBattlePhase
; 2, wBattleStep 3 (E-0044))
BattleEnd_Records::
    call BattleEnd_Records_UpdatePartyRecords
    ld hl, wBattleStep
    inc [hl]
    xor a
    ld [wBattleSubPhase], a
    ld a, [wLinkMode]
    or a
    jr nz, .skip2
    ld a, [wBattleScene]
    or a
    jr z, .check_display_slot
    cp $03
    jr z, .skip
    cp $02
    jr z, .skip

.skip:
    ld hl, wBattleStep
    inc [hl]
    ld hl, wBattleStep
    inc [hl]
    ret

.skip2:
    ld hl, wBattleStep
    inc [hl]
    ld hl, wBattleStep
    inc [hl]
    ld hl, wBattleStep
    inc [hl]
    ret

.check_display_slot:
    ld a, [wDisplaySlot]
    cp $ff
    ret z
    sub $04
    ret c
    cp $03
    ret nc
    ld a, [wLinkMode]
    or a
    call z, BattleEnd_Records_SumExpAward
    call BattleEnd_Records_ReplaceSpecialFoe
    ld a, [wDisplaySlot]
    dec a
    ld c, $4e
    call Multiply8
    ld a, l
    add $d5
    ld e, a
    ld a, h
    adc $d0
    ld d, a
    ld hl, wRecordBufA
    ld a, l
    add $01
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld b, $0e
    call CopyBBytesDEToHL_Bank31
    push de
    ld de, wPlayerName
    ld b, $0b
    call CopyBBytesDEToHL_Bank31
    pop de
    ld a, $ff
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    call BattleEnd_Records_WriteUnknownName
    ld a, $ff
    ld [hli], a
    call BattleEnd_Records_WriteUnknownName
    ld a, $ff
    ld [hli], a
    ld b, $08
    call BattleEnd_Records_CopySkillsSkippingC8
    ld a, $ff
    ld b, $19

.loop:
    ld [hli], a
    dec b
    jr nz, .loop
    ld a, [de]
    inc de
    ld [hli], a
    ld a, [de]
    inc de
    ld [hli], a
    ld [hli], a
    ld b, $15
    call CopyBBytesDEToHL_Bank31
    xor a
    ld [hli], a
    ld [hli], a
    ld b, $1f
    call CopyBBytesDEToHL_Bank31
    call BattleEnd_Records_WriteUnknownName
    ld a, $00
    ld [hli], a
    call BattleEnd_Records_WriteUnknownName
    ld a, $00
    ld [hli], a
    ld a, [de]
    ld [hli], a
    farcall BattleEnd_Records_BuildSkillList
    farcall BattleEnd_Records_ShapeJoiner
    farcall LoadTableEntryForRecordBufASpeciesToRecordBufAExp
    ret

; DE = source, HL = destination, B = count: copies B bytes (B = 0 copies 256); DE and HL end past
; the copy, B = 0, A is clobbered. BattleEnd_Records uses it to build the record in wRecordBufA.
; (C2, E-0378)
; DE = source, HL = destination, B = count: copies B bytes (B = 0 copies 256); DE and HL end past
; the copy; clobbers A, B = 0 (E-0064) (the same 7 bytes appear in 4 banks)
CopyBBytesDEToHL_Bank31::
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, CopyBBytesDEToHL_Bank31
    ret

; HL = destination, DE = source, B = count: fills the 8 bytes at HL with $FF, then copies B source
; bytes to HL, leaving out the bytes equal to $C8; HL ends at the start + 8 and DE past the source
; bytes. BattleEnd_Records copies the skills of the foe battler record into MON_SKILLS with it. (C2,
; E-0378)
; fills 8 bytes at HL with $FF, then copies B bytes from DE, skipping $C8
BattleEnd_Records_CopySkillsSkippingC8::
    push hl
    ld a, $ff
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    pop hl
    push hl

.loop:
    ld a, [de]
    inc de
    cp $c8
    jr z, .next
    ld [hli], a

.next:
    dec b
    jr nz, .loop
    pop hl
    ld a, l
    add $08
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ret

; Writes 10 bytes at HL: three $98 placeholder glyphs and seven $F0 end bytes; HL ends past them.
; BattleEnd_Records uses it for the parent names and master names of the built record. (C2, E-0378)
; writes three $98 placeholder glyphs and seven $F0 bytes at HL
BattleEnd_Records_WriteUnknownName::
    ld a, $98
    ld [hli], a
    ld a, $98
    ld [hli], a
    ld a, $98
    ld [hli], a
    ld a, $f0
    ld [hli], a
    ld a, $f0
    ld b, $06

.loop:
    ld [hli], a
    dec b
    jr nz, .loop
    ret

; Clears the 24-bit wBattleExpAward and adds the experience of each foe slot from 4 (wBattleFoeCount
; slots) whose wBattleSlotOut byte is 1, through the table after it: pointers to BATTLER_EXP in
; wBattlerRecordSlot4, wBattlerRecordSlot5 and wBattlerRecordSlot6. BattleEnd_Records calls it
; outside link battles. (C2, E-0370; probed E-0378)
BattleEnd_Records_SumExpAward::
    ld a, [wBattleFoeCount]
    ld b, a
    ld c, $04
    xor a
    ld [wBattleExpAward], a
    ld [wBattleExpAward + $1], a
    ld [wBattleExpAward + $2], a

.loop:
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    cp $01
    jr nz, .next
    ld a, c
    and $03
    ld hl, BattleEnd_Records_SumExpAward_Data
    add a
    add_a_to_hl
    deref_hl
    ld a, [wBattleExpAward]
    add [hl]
    ld [wBattleExpAward], a
    inc hl
    ld a, [wBattleExpAward + $1]
    adc [hl]
    ld [wBattleExpAward + $1], a
    inc hl
    ld a, [wBattleExpAward + $2]
    adc [hl]
    ld [wBattleExpAward + $2], a

.next:
    inc c
    dec b
    jr nz, .loop
    ret

; data read by BattleEnd_Records_SumExpAward (6 bytes) (E-0347)
BattleEnd_Records_SumExpAward_Data::
    db $d7, $d1, $25, $d2, $73, $d2

; In battle kind 2 (wBattleKind) only: takes the first wEncounterMonsters entry (one or two foes;
; wDisplaySlot = 4) or the second (three foes; wDisplaySlot = 5), keeps its address in
; hTemp0/hTemp1, and replaces its monster id: MONSTER_BABBLE becomes MONSTER_BOXSLIME,
; MONSTER_WONDEREGG becomes MONSTER_BUTCH, $182 becomes $183, $1AB becomes $1AC (also setting
; wScreenSavedFlag to 2) and $190 becomes $1AF, each reloaded through
; BattleEnd_Records_ReplaceSpecialFoe_SetMonster; other ids are left alone. BattleEnd_Records calls
; it before it builds the record in wRecordBufA. (C2, E-0370; probed E-0378)
BattleEnd_Records_ReplaceSpecialFoe::
    ld a, [wBattleKind]
    cp $02
    ret nz
    ld a, [wBattleFoeCount]
    cp $01
    jr z, .set_temp0
    cp $02
    jr z, .set_temp0
    ld hl, wEncounterMonsters + $2
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ld a, $05
    ld [wDisplaySlot], a
    ld a, [wEncounterMonsters + $2]
    ld l, a
    ld a, [wEncounterMonsters + $3]
    ld h, a
    jr .skip

.set_temp0:
    ld hl, wEncounterMonsters
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ld a, [wEncounterMonsters]
    ld l, a
    ld a, [wEncounterMonsters + $1]
    ld h, a
    ld a, $04
    ld [wDisplaySlot], a

.skip:
    ld a, h
    or a
    jr nz, .cp_01
    ld a, l
    cp $07
    jr z, .call_battle_end_records_replace_special_foe
    cp $1a
    jr z, .call_battle_end_records_replace_special_foe2
    jr .return

.call_battle_end_records_replace_special_foe:
    ld hl, $0008
    call BattleEnd_Records_ReplaceSpecialFoe_SetMonster
    jr .return

.call_battle_end_records_replace_special_foe2:
    ld hl, $001b
    call BattleEnd_Records_ReplaceSpecialFoe_SetMonster
    jr .return

.cp_01:
    cp $01
    jr nz, .return
    ld a, l
    cp $82
    jr z, .call_battle_end_records_replace_special_foe3
    cp $ab
    jr z, .set_screen_saved_flag_to_02
    cp $90
    jr z, .call_battle_end_records_replace_special_foe4
    jr .return

.call_battle_end_records_replace_special_foe3:
    ld hl, $0183
    call BattleEnd_Records_ReplaceSpecialFoe_SetMonster
    jr .return

.set_screen_saved_flag_to_02:
    ld a, $02
    ld [wScreenSavedFlag], a
    ld hl, $01ac
    call BattleEnd_Records_ReplaceSpecialFoe_SetMonster
    jr .return

.call_battle_end_records_replace_special_foe4:
    ld hl, $01af
    call BattleEnd_Records_ReplaceSpecialFoe_SetMonster
    jr .return

.return:
    ret

; Writes monster id HL into the foe's wEncounterMonsters entry (hTemp0/1) and reloads its battler
; record. (C2, E-0357; probed E-0378)
BattleEnd_Records_ReplaceSpecialFoe_SetMonster::
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    farcall BattleEnd_Records_ReloadFoeBattler
    ret

; Like BattleEnd_WaitForSound it counts wBattleEndTimer down when the twelve sound bytes are all $FF
; (BattleEnd_AwardExperience_CountDownTimer), then always runs BattleEnd_GainExperience, a jump
; table on wBattleSubPhase that awards experience and handles level-ups and new skills; its last
; part (BattleEnd_GainExperience_Finish) does wBattleStep += 1. (C1, E-0378)
; battle end, step 4: the same wait for the sound channels, then gains experience
; (BattleEnd_GainExperience) (E-0354; was: wBattlePhase 2, wBattleStep 4 (E-0044))
BattleEnd_AwardExperience::
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannelSlots + $1
    and [hl]
    ld hl, wSoundChannel1
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel2
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel3
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel4
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel5
    and [hl]
    inc hl
    and [hl]
    cp $ff
    call z, BattleEnd_AwardExperience_CountDownTimer
    call BattleEnd_GainExperience
    ret

; Counts wBattleEndTimer down. (C2, E-0357; probed E-0378)
BattleEnd_AwardExperience_CountDownTimer::
    ld a, [wBattleEndTimer]
    dec a
    ld [wBattleEndTimer], a
    ret nz
    ret

; Offers a defeated foe to join the party. A jump table on wBattleSubPhase: 0
; BattleEnd_OfferJoin_Start (decide the offer), 1 BattleEnd_OfferJoin_DrawThenAskToJoin, 2
; BattleEnd_OfferJoin_RunSwapMenu, 3 BattleEnd_OfferJoin_RedrawBattleScreen, 4
; BattleEnd_OfferJoin_AddJoinedMonster. (C1, E-0378)
; battle end, step 5: offers the defeated monster to join, by wBattleSubPhase
; (BattleEnd_OfferJoin_DrawThenAskToJoin, the swap menu, BattleEnd_AddJoinedMonster) (E-0354; was:
; wBattlePhase 2, wBattleStep 5 (E-0044))
BattleEnd_OfferJoin::
    ld a, [wBattleSubPhase]
    jumptable
    dw BattleEnd_OfferJoin_Start
    dw BattleEnd_OfferJoin_DrawThenAskToJoin
    dw BattleEnd_OfferJoin_RunSwapMenu
    dw BattleEnd_OfferJoin_RedrawBattleScreen
    dw BattleEnd_OfferJoin_AddJoinedMonster

; Join offer, part 0: decides whether a defeated foe offers to join; none ($FF) goes to the next
; battle step; otherwise shows its picture, redraws the party panels, plays sound $6C and goes on.
; (C1, E-0357)
BattleEnd_OfferJoin_Start::
    farcall BattleEnd_OfferJoin_DecideJoinOffer
    ld a, [wDisplaySlot]
    cp $ff
    jr nz, .read_species_id_lo
    ld hl, wBattleStep
    inc [hl]
    xor a
    ld [wBattleSubPhase], a
    ret

.read_species_id_lo:
    ld a, [wSpeciesIdLo]
    ld l, a
    ld a, [wSpeciesIdHi]
    ld h, a
    ld a, l
    ld [wBattlePictureIds], a
    ld a, h
    ld [wBattlePictureIds + $1], a
    call ClearAttributesAndScreenBuffer_Bank31
    call CopyRectRecordForBattlePartyCount_Bank31
    call DrawPartySlotStatusPanels
    call ClearWindowAndCopyRectFar
    ld a, $6c
    call QueueSoundEffect
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleSubStep], a
    ret

; Part 1 of the join offer, a jump table on wBattleResolveStep: 0
; BattleEnd_OfferJoin_DrawThenAskToJoin_LoadPicture (draw the screen and the monster picture), 1
; BattleEnd_OfferJoin_DrawThenAskToJoin_Ask (BattleEnd_AskToJoin). (C1, E-0378)
; copies a rectangle to VRAM, then BattleEnd_AskToJoin
BattleEnd_OfferJoin_DrawThenAskToJoin::
    ld a, [wBattleResolveStep]
    jumptable
    dw BattleEnd_OfferJoin_DrawThenAskToJoin_LoadPicture
    dw BattleEnd_OfferJoin_DrawThenAskToJoin_Ask

; Join offer, part 1, step 0: copies the screen to the BG map and loads the joining monster's
; picture, title, tile blocks and attributes; next step. (C1, E-0357)
BattleEnd_OfferJoin_DrawThenAskToJoin_LoadPicture::
    ld de, wScreenTileBuffer
    ld hl, vBGMap0
    lb bc, $14, $12
    call CopyRect32StrideToVRAM
    call LoadBattleMonsterPictureAndTitle
    call LayoutTileBlocksForBattleFoeCount
    call LoadBattleMonsterPictureAttributes
    ld de, wScreenTileBuffer + $e7
    ld hl, vBGMap0 + $e7
    lb bc, $06, $06
    call CopyRect32StrideToVRAM
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; Join offer, part 1, step 1: asks whether it may join (BattleEnd_AskToJoin). (C1, E-0357)
BattleEnd_OfferJoin_DrawThenAskToJoin_Ask::
    farcall BattleEnd_AskToJoin
    ret

; Join offer, part 2: the swap menu (SwapMonstersMenu); when it is done (step $0A) restores the
; sprite and field settings, rebuilds the battle screen, reloads the battle tiles and returns to
; part 1, next sub-step. (C1, E-0357)
BattleEnd_OfferJoin_RunSwapMenu::
    farcall SwapMonstersMenu
    ld a, [wScreenStep]
    cp $0a
    ret nz
    ld a, [wSavedSpriteClipMode]
    ldh [hSpriteWindowClipMode], a
    ld a, $80
    ldh [hSpriteHideTile], a
    ld a, [wSavedFieldDrawFlags]
    ldh [hFieldDrawFlags], a
    ld a, [wSavedSpriteSlotCount]
    ld [wSpriteSlotCount], a
    call BuildBattleScreenBuffer
    ld b, $31
    ld de, Tiles1Plus240Gfx
    ld hl, vTiles1 + $240
    call DecompressToVRAM
    ld b, $31
    ld de, Tiles1Plus5F0Gfx
    ld hl, vTiles1 + $5f0
    call DecompressToVRAM
    ld hl, wBattleSubPhase
    dec [hl]
    ld hl, wBattleSubStep
    inc [hl]
    ret

; Join offer, part 3: redraws the battle screen at sub-step 3, runs the sub-steps and reloads the
; picture when the screen flags ask. (C1, E-0357)
BattleEnd_OfferJoin_RedrawBattleScreen::
    ld a, [wBattleSubStep]
    cp $03
    call z, BuildAndDrawBattleScreen
    farcall RunBattleEndStep5SubSteps
    ld a, [wBattleScreenFlags]
    or a
    call nz, LoadBattleMonsterPictureAndTitle
    ret

; BuildBattleScreenBuffer, then copies the 20 x 18 wScreenTileBuffer to vBGMap0
; (CopyRect32StrideToVRAM). BattleEnd_OfferJoin_RedrawBattleScreen calls it at wBattleSubStep 3.
; (C1, E-0378)
; BuildBattleScreenBuffer, then copies the 20 x 18 wScreenTileBuffer to vBGMap0
; (CopyRect32StrideToVRAM) (E-0115)
BuildAndDrawBattleScreen::
    call BuildBattleScreenBuffer
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    lb bc, $14, $12
    call CopyRect32StrideToVRAM
    ret

; Join offer, part 4: adds the monster that joined (BattleEnd_AddJoinedMonster), reloading the
; picture when the screen flags ask. (C1, E-0357)
BattleEnd_OfferJoin_AddJoinedMonster::
    farcall BattleEnd_AddJoinedMonster
    ld a, [wBattleScreenFlags]
    or a
    call nz, LoadBattleMonsterPictureAndTitle
    ret

; Builds the battle screen in wScreenTileBuffer by calling in turn LoadBattleMonsterPictureAndTitle,
; ClearAttributesAndScreenBuffer_Bank31, CopyRectRecordForBattlePartyCount_Bank31,
; DrawPartySlotStatusPanels, LayoutTileBlocksForBattleFoeCount, LoadBattleMonsterPictureAttributes
; and ClearWindowAndCopyRectFar. (C1, E-0378)
; runs LoadBattleMonsterPictureAndTitle, ClearAttributesAndScreenBuffer_Bank31,
; CopyRectRecordForBattlePartyCount_Bank31, DrawPartySlotStatusPanels,
; LayoutTileBlocksForBattleFoeCount, LoadBattleMonsterPictureAttributes and
; ClearWindowAndCopyRectFar in turn (E-0115)
BuildBattleScreenBuffer::
    call LoadBattleMonsterPictureAndTitle
    call ClearAttributesAndScreenBuffer_Bank31
    call CopyRectRecordForBattlePartyCount_Bank31
    call DrawPartySlotStatusPanels
    call LayoutTileBlocksForBattleFoeCount
    call LoadBattleMonsterPictureAttributes
    call ClearWindowAndCopyRectFar
    ret

; Clears wBattleScreenFlags, loads the picture of the monster id of wDisplaySlot (the word at
; wBattleMonsterId + 2 * slot) to vTiles2 + $140 (LoadMonsterPicture), uploads the background
; palettes (wBGPaletteUploadRequest = $7F) and the name tiles (LoadRecordListNameTiles), shows
; string 5 of category 2 (bank $09, 'InfoOKMonsterEgg') in a one-row window at vTiles1 + $6D0, then
; restores the default text window (vTiles1, size $1202). (C1, E-0378)
; loads the picture of battle monster wDisplaySlot at vTiles2 + $140, uploads palettes, loads name
; tiles and shows string 5 of category 2 (bank 09) at vTiles1 + $6D0, then restores the default
; window (E-0121)
LoadBattleMonsterPictureAndTitle::
    xor a
    ld [wBattleScreenFlags], a
    ld a, [wDisplaySlot]
    ld hl, wBattleMonsterId
    add a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld hl, vTiles2 + $140
    ld c, $01
    call LoadMonsterPicture
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes
    call LoadRecordListNameTiles
    ld hl, vTiles1 + $6d0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0c01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $02
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a ; 'InfoOKMonsterEgg'
    farcall ShowString_Bank09
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

; Leaving the battle, a jump table on wBattleSubPhase: 0 BattleEnd_ReturnToField_PlayEndMusic (music
; and fade), 1 BattleEnd_ReturnToField_FinishFade (wait for the fade), 2
; BattleEnd_ReturnToField_PlayTransitionMusic (back to the field). (C1, E-0378)
; battle end, step 6: changes the music and waits for the fade (E-0354; was: wBattlePhase 2,
; wBattleStep 6 (E-0044))
BattleEnd_ReturnToField::
    ld a, [wBattleSubPhase]
    jumptable
    dw BattleEnd_ReturnToField_PlayEndMusic
    dw BattleEnd_ReturnToField_FinishFade
    dw BattleEnd_ReturnToField_PlayTransitionMusic

; Battle end, step 6, part 0: after the text, music 2 unless the transition music is already
; playing; clears the window clipping and starts fade 4; next part. (C1, E-0357)
BattleEnd_ReturnToField_PlayEndMusic::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wCurrentMusic]
    ld hl, wTransitionMusic
    cp [hl]
    jr z, .clear_sprite_window_clip_mode
    ld a, $02
    call QueueMusic

.clear_sprite_window_clip_mode:
    xor a
    ldh [hSpriteWindowClipMode], a
    ld a, $80
    ldh [hSpriteHideTile], a
    ld a, $04
    call StartPaletteFade
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; Battle end, step 6, part 1: waits for the fade; next part. (C2, E-0357; probed E-0378)
BattleEnd_ReturnToField_FinishFade::
    ld a, [wFadeState]
    or a
    ret nz
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; Battle end, step 6, part 2: plays the transition music; in battle kinds 2 and 3 puts the followers
; on the player; back to the field (game mode 1), reloading the field tiles. (C1, E-0357)
BattleEnd_ReturnToField_PlayTransitionMusic::
    ld a, [wCurrentMusic]
    ld hl, wTransitionMusic
    cp [hl]
    jr z, .check_battle_kind
    ld a, [hl]
    call QueueMusic

.check_battle_kind:
    ld a, [wBattleKind]
    cp $02
    jr c, .set_game_mode_to_01
    cp $04
    jr nc, .set_game_mode_to_01
    call SetFollowersToPlayer

.set_game_mode_to_01:
    ld a, $01
    ld [wGameMode], a
    xor a
    ld [wModeState], a
    ld [wWorldMapState], a
    ld [wGameMode2Arg], a
    ld [wNewRecordFamily], a
    ld [wScreenState], a
    ld b, $46
    ld de, Tiles1Gfx
    ld hl, vTiles1
    call DecompressToVRAM
    farcall ExitPauseMenuToField
    ld a, $02
    ld [wFieldInitStage], a
    ld hl, wBGFillFlag
    inc [hl]
    ret

; Copies hPlayerFacing to the direction byte and hPlayerX, hPlayerY to the X and Y bytes of the
; three follower records in wFollowerRecords (offsets 0, 5 and 10; the target bytes are left as they
; are). BattleEnd_ReturnToField_PlayTransitionMusic calls it for battle kinds 2 and 3. (C2, E-0378)
; copies hPlayerFacing to the three follower directions and hPlayerX/hPlayerY to the three follower
; positions (the facing-preserving form of ResetFollowersToPlayer) (E-0118)
SetFollowersToPlayer::
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    ldh a, [hPlayerX]
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $b], a
    ldh a, [hPlayerY]
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $c], a
    ret

; Ends a link battle, a jump table on wBattleSubPhase: 0 BattleEnd_LinkFinish_SendSync, 1
; BattleEnd_LinkFinish_ReceiveSync, 2 BattleEnd_LinkFinish_FadeOutAndStore. Both wBattleStep 7 and 8
; run it. (C1, E-0378)
; battle end, step 7 (link battles): sends the end byte, waits for the partner's message and fades
; out (E-0354; was: wBattlePhase 2, wBattleStep 7 (E-0044))
BattleEnd_LinkFinish::
    ld a, [wBattleSubPhase]
    jumptable
    dw BattleEnd_LinkFinish_SendSync
    dw BattleEnd_LinkFinish_ReceiveSync
    dw BattleEnd_LinkFinish_FadeOutAndStore

; Battle end, step 7, part 0 (link): once every sound channel is idle and the text is done, sends 1;
; next part. (C2, E-0357; probed E-0378)
BattleEnd_LinkFinish_SendSync::
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannelSlots + $1
    and [hl]
    ld hl, wSoundChannel1
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel2
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel3
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel4
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel5
    and [hl]
    inc hl
    and [hl]
    cp $ff
    ret nz
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; Battle end, step 7, part 1: waits for the partner's 1; next part. (C2, E-0357; probed E-0378)
BattleEnd_LinkFinish_ReceiveSync::
    ld a, [wLinkMessage]
    cp $01
    ret nz
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; Battle end, step 7, part 2: fades out, stores the battle state into the party records, switches to
; game mode 6 and clears the link state. (C1, E-0357)
BattleEnd_LinkFinish_FadeOutAndStore::
    ld a, $04
    call StartPaletteFade
    farcall StoreBattleStateToPartyRecords_BankA3
    ld a, $06
    ld [wGameMode], a
    xor a
    ld [wModeState], a
    ld [wWorldMapState], a
    ld [wGameMode2Arg], a
    ld [wScreenState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ld hl, wBGFillFlag
    inc [hl]
    xor a
    ld [wLinkSession], a
    ld [wLinkExchangeState], a
    xor a
    ld [wLinkRole], a
    ld [wLinkStatus], a
    xor a
    ld [wLinkMode], a
    xor a
    ld [wLinkMessage], a
    xor a
    ld [wLinkSendByte], a
    xor a
    ld [wLinkScreenStep], a
    ret

; In wBattleScene 4 queues sound effect $7E (QueueSoundEffect), otherwise music $42 (QueueMusic),
; and sets wBattleStep = 7. (C2, E-0378)
; wBattlePhase 2, wBattleStep 9 (E-0044)
BattleEnd_QueueEndSound::
    ld a, [wBattleScene]
    cp $04
    jr z, .call_queue_sound_effect
    ld a, $42
    call QueueMusic
    jr .set_battle_step_to_07

.call_queue_sound_effect:
    ld a, $7e
    call QueueSoundEffect

.set_battle_step_to_07:
    ld a, $07
    ld [wBattleStep], a
    ret

; Sets the name for BattleEnd_Result's closing message in wTextBuf0: in link battles the partner's
; name (wBattleArg0 = 0); otherwise one foe's name (wBattleArg0 0), the species name followed by
; bytes $33, $34 (charmap 'p', 'q') when every foe is the same species (wBattleArg0 1), or
; 'monsters' (wBattleArg0 2). Of the strings BattleEnd_Result then shows, only String_2F_00_08
; (wBattleArg0 0) and String_2F_00_87 (link) contain <BUF0>. (C2, E-0370; probed E-0378)
BattleEnd_Result_SetMessageName::
    ld a, [wLinkMode]
    or a
    jr nz, BattleEnd_Result_SetMessageName_PartnerName
    xor a
    ld [wBattleArg0], a
    ld hl, wBattlePictureIds
    ld a, [hli]
    ld d, [hl]
    ld e, a
    inc hl
    ld a, [wBattleFoeCount]
    cp $01
    jr z, BattleEnd_Result_SetMessageName_FoeName
    ld a, $01
    ld [wBattleArg0], a
    ld a, [hli]
    cp e
    jr nz, BattleEnd_Result_SetMessageName_Monsters
    ld a, [hli]
    cp d
    jr nz, BattleEnd_Result_SetMessageName_Monsters
    ld a, [wBattleFoeCount]
    cp $02
    jr z, .call_battle_end_result_set_message_name_foe
    ld a, [hli]
    cp e
    jr nz, BattleEnd_Result_SetMessageName_Monsters
    ld a, [hl]
    cp d
    jr nz, BattleEnd_Result_SetMessageName_Monsters

.call_battle_end_result_set_message_name_foe:
    call BattleEnd_Result_SetMessageName_FoeName
    ld hl, wTextBuf0

.loop:
    ld a, [hli]
    cp $f0
    jr nz, .loop
    dec hl
    ld a, $33
    ld [hli], a
    ld a, $34
    ld [hli], a
    ld [hl], $f0
    jr BattleEnd_Result_SetMessageName_Done

; Copies foe name DE (categories 2 and 3) to wTextBuf0. (C2, E-0357; probed E-0378)
BattleEnd_Result_SetMessageName_FoeName::
    ld l, e
    ld a, d
    add $02
    ld h, a
    ld de, wTextBuf0
    call CopyStringHLToDE
    jr BattleEnd_Result_SetMessageName_Done

; Copies the partner's name (wBattleTextWork, up to 10 letters) to wTextBuf0 (wBattleArg0 0). (C2,
; E-0357; probed E-0378)
BattleEnd_Result_SetMessageName_PartnerName::
    ld de, wBattleTextWork
    ld hl, wTextBuf0
    ld b, $0a

.loop:
    ld a, [de]
    cp $f0
    jr z, .set_battle_arg0_to_00
    ld [hli], a
    inc de
    dec b
    jr nz, .loop

.set_battle_arg0_to_00:
    ld [hl], $f0
    ld a, $00
    ld [wBattleArg0], a
    jr BattleEnd_Result_SetMessageName_Done

; wTextBuf0 = 'monsters' (wBattleArg0 2). (C2, E-0357; probed E-0378)
BattleEnd_Result_SetMessageName_Monsters::
    ld hl, wTextBuf0
    ld a, $30
    ld [hli], a
    ld a, $32
    ld [hli], a
    ld a, $31
    ld [hli], a
    ld a, $36
    ld [hli], a
    ld a, $37
    ld [hli], a
    ld a, $28
    ld [hli], a
    ld a, $35
    ld [hli], a
    ld a, $36
    ld [hli], a
    ld [hl], $f0
    ld a, $02
    ld [wBattleArg0], a

; Returns. (C2, E-0357; probed E-0378)
BattleEnd_Result_SetMessageName_Done::
    ret

; Counts the play time one frame: wPlayFrames, wPlaySeconds and wPlayMinutes roll over at 60 and the
; 16-bit hours (wPlayHoursLo/Hi) go up by 1. At 999 hours (the word $03E7) with 59 minutes it
; returns before counting, so the time stops at 999:59. A copy of IncrementPlayTime called by
; GameMode4_Update. (C2, E-0378)
; the same 66 bytes as IncrementPlayTime (IncrementPlayTime) (E-0030)
IncrementPlayTime_Bank31::
    ld a, [wPlayHoursLo]
    ld l, a
    ld a, [wPlayHoursHi]
    ld h, a
    ld bc, $03e7
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    ld a, h
    or l
    or a
    jr nz, .skip
    ld a, [wPlayMinutes]
    cp $3b
    ret z

.skip:
    ld hl, wPlayFrames
    ld a, [hl]
    inc a
    ld [hl], a
    cp $3c
    ret c
    ld [hl], $00
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    cp $3c
    ret c
    ld [hl], $00
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    cp $3c
    ret c
    ld [hl], $00
    inc hl
    ld a, [hli]
    ld b, [hl]
    ld c, a
    inc bc
    ld a, b
    ld [hld], a
    ld [hl], c
    ret

; Starts a fight round: sets bit 7 of all eight wSideControl bytes (computer-controlled for now),
; clears wPersonalityActs and wActionQueue, sets wBattleActionChoice to $FF, no item
; (wBattleItemTarget and wBattleItemId $FF) and wMenuState 0. Then, for the player's slots
; (wSide0Flag slots from slot 0, or wSide1Flag slots from slot 4 for a link role with bit 1 set), it
; counts the wSlotMarks still 0 from before and, when there are none, advances wBattleStep so the
; command menu (RunBattleSetup) is skipped; finally it marks each of those slots: 3 empty, 1 blocked
; by status (CheckSlotStatusBlock) or by wBattleStatus3 byte 0 bits 6-7, byte 1 bits 2-3, byte 2
; bits 4-5 or byte 5 bits 0-1, otherwise 0. (C2, E-0370; probed E-0379)
BattleFight_BeginRound_StartRound::
    ld hl, wSideControl
    ld b, $08

.loop:
    set 7, [hl]
    inc hl
    dec b
    jr nz, .loop
    ld hl, wPersonalityActs
    ld bc, $0010
    xor a
    call FillBytes
    ld hl, wActionQueue
    ld bc, $000a
    xor a
    call FillBytes
    ld hl, wBattleActionChoice
    ld bc, $0010
    ld a, $ff
    call FillBytes
    ld a, $ff
    ld [wBattleItemTarget], a
    ld [wBattleItemId], a
    ld a, $00
    ld [wMenuState], a
    ld a, [wSide0Flag]
    ld b, a
    ld c, $00
    ld a, [wLinkMode]
    or a
    jr z, .skip
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip
    ld a, [wSide1Flag]
    ld b, a
    ld c, $04

.skip:
    push bc
    ld a, c
    ld hl, wSlotMarks
    add_a_to_hl
    ld c, $00

.loop2:
    ld a, [hli]
    or a
    jr nz, .next
    inc c

.next:
    dec b
    jr nz, .loop2
    ld a, c
    or a
    jr nz, .restore
    ld hl, wBattleStep
    inc [hl]

.restore:
    pop bc

.loop3:
    ld e, $03
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip2
    ld e, $01
    ld a, c
    call CheckSlotStatusBlock
    jr c, .skip2
    ld a, c
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hli]
    and $c0
    jr nz, .skip2
    ld a, [hli]
    and $0c
    jr nz, .skip2
    ld a, [hli]
    and $30
    jr nz, .skip2
    inc hl
    inc hl
    ld a, [hl]
    and $03
    jr nz, .skip2
    ld e, $00

.skip2:
    ld a, c
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], e
    inc c
    dec b
    jr nz, .loop3
    ret

; The command phase of a fight round, called every frame by BattleFight_ChooseCommands:
; wBattleSubPhase picks one of 13 parts. 0 is the main menu (RunBattleSetup_MainMenu: FIGHT, PLAN,
; ITEM, RUN), which sets the sub-phase to 3 for FIGHT, 1 for PLAN (RunBattleSetup_PlanMenu) or 2 for
; ITEM (RunBattleSetup_ItemMenu). 3 marks every slot still at 0 with 1
; (RunBattleSetup_MarkSlotsToAct) and the sub-phases 4-11 only act in link battles (wLinkMode
; non-zero: the partner message, then the exchange of the choices and of the random seeds, back to 5
; when the seeds differ), so in a single battle they just step on; 12 (RunBattleSetup_ClearWindow)
; clears the window, adds 1 to wBattleStep and resets wBattleSubPhase to 0. (C1, E-0379)
; battle fight step 1: one sub-step per wBattleSubPhase (13 cases, 0-12 observed in the first
; battle) that builds the battle screen and loads the combatants
RunBattleSetup::
    ld a, [wBattleSubPhase]
    jumptable
    dw RunBattleSetup_MainMenu
    dw RunBattleSetup_PlanMenu
    dw RunBattleSetup_ItemMenu
    dw RunBattleSetup_MarkSlotsToAct
    dw RunBattleSetup_ShowSelectingHeroSMove
    dw RunBattleSetup_SendLinkSync
    dw RunBattleSetup_SendLinkChoices
    dw RunBattleSetup_StartLinkExchange
    dw RunBattleSetup_UnpackPartnerChoices
    dw RunBattleSetup_CompareSeeds
    dw RunBattleSetup_WaitPartnerSeed
    dw RunBattleSetup_RetryOnSeedMismatch
    dw RunBattleSetup_ClearWindow

; The main menu of the command phase (sub-phase 0 of RunBattleSetup): wBattleResolveStep picks one
; of 17 steps. 0 saves the tactics of the player slots, 1 draws the menu, 2 the cursor, 3 moves it
; in the 2 x 2 menu (A goes on), 4 copies the menu window and 5 handles the choice
; (RunBattleSetup_MainMenu_Choose: FIGHT, PLAN and ITEM leave this sub-phase, a refusal message goes
; to step 6 and back to 2 at 7). RUN goes to the flee attempt at 8-9 ('<player> fled!', or 'But the
; escape route was cut' which goes on to 10 and the fight), to 15-16 ('No fleeing from this
; battle!', back to step 1) or to 11-14 ('Retire now?', yes/no, 'You threw in the towel!' and the
; end of the battle at 14). (C1, E-0379)
; by wBattleResolveStep: the battle's main menu (FIGHT, PLAN, ITEM and RUN, wMenuState bits 0-1) and
; the RUN choices: the flee attempt ('<player> fled!', 'But the escape route was cut'), 'No fleeing
; from this battle!' and retiring ('Retire now?', 'You threw in the towel!') (E-0364; was named for
; the flee strings only, E-0288)
RunBattleSetup_MainMenu::
    ld a, [wBattleResolveStep]
    jumptable
    dw RunBattleSetup_MainMenu_SaveTactics
    dw RunBattleSetup_MainMenu_Draw
    dw RunBattleSetup_MainMenu_DrawCursor
    dw RunBattleSetup_MainMenu_Cursor
    dw RunBattleSetup_MainMenu_CopyMenuWindow
    dw RunBattleSetup_MainMenu_Choose
    dw RunBattleSetup_MainMenu_ShowMessage
    dw RunBattleSetup_MainMenu_RedrawWindow
    dw RunBattleSetup_MainMenu_ShowFled
    dw RunBattleSetup_MainMenu_TryFlee
    dw RunBattleSetup_MainMenu_StartFight
    dw RunBattleSetup_MainMenu_ShowRetireNow
    dw RunBattleSetup_MainMenu_DrawYesNo
    dw RunBattleSetup_MainMenu_YesNoCursor
    dw RunBattleSetup_MainMenu_Retire
    dw RunBattleSetup_MainMenu_ShowNoFleeingFromThis
    dw RunBattleSetup_MainMenu_BackToMenu

; Main menu, step 0: saves the player's three slots' tactics and last tactics into wFleeWork; next
; step. (C2, E-0357; probed E-0379)
RunBattleSetup_MainMenu_SaveTactics::
    ld a, [wLinkMode]
    or a
    jr nz, .check_link_role
    ld c, $00
    jr .skip

.check_link_role:
    ld a, [wLinkRole]
    and $02
    sla a
    ld c, a

.skip:
    ld de, wFleeWork
    ld b, $03

.loop:
    ld a, c
    ld hl, wSlotTactic
    add_a_to_hl
    ld a, [hl]
    ld [de], a
    ld a, $08
    add_a_to_hl
    push de
    inc de
    inc de
    inc de
    inc de
    ld a, [hl]
    ld [de], a
    pop de
    inc de
    inc c
    dec b
    jr nz, .loop
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; Main menu, step 1: the player's side under computer control for now; draws the battle window, the
; foes' tile blocks, the menu text (string 0 of bank $09's category 2, 'FIGHTEMPLAN', with the rest
; of the words in the box) and the menu box; next step. (C1, E-0357)
RunBattleSetup_MainMenu_Draw::
    ld a, [wLinkRole]
    rlca
    and $04
    ld hl, wSideControl
    add_a_to_hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    inc hl
    set 7, [hl]
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call CopyScreenBufferRect20x11ToBGMapRow7
    ld hl, vTiles1 + $6d0
    ld de, $0701
    ld a, $02
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    call RunBattleSetup_MainMenu_BuildMenuWindow
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; Main menu, step 2: draws the menu and the cursor ($BB) at the choice in wMenuState bits 0-1; next
; step. (C1, E-0357)
RunBattleSetup_MainMenu_DrawCursor::
    call RunBattleSetup_MainMenu_DrawMenuWindow
    ld hl, RunBattleSetup_MainMenu_DrawCursor_Data
    ld a, [wMenuState]
    and $03
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $bb
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; Main menu, step 3: moves the cursor in the 2 x 2 menu; A plays sound $69, clears the sub-states
; and redraws the foes' area; next step. (C1, E-0357)
RunBattleSetup_MainMenu_Cursor::
    ld de, RunBattleSetup_MainMenu_DrawCursor_Data
    ld hl, wMenuState
    call ToggleEntryBitsByJoypadAndBlink
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .return
    ld a, $69
    call QueueSoundEffect
    ld hl, wMenuSubState
    ld bc, $0007
    ld a, $00
    call FillBytes
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]

.return:
    ret

; Main menu, step 4 (after A in RunBattleSetup_MainMenu_Cursor): copies the 14 x 5 menu window from
; wWindowTileBuffer to the BG map at row 13 (RunBattleSetup_MainMenu_DrawMenuWindow); next step.
; (C1, E-0370)
RunBattleSetup_MainMenu_CopyMenuWindow::
    call RunBattleSetup_MainMenu_DrawMenuWindow
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; Main menu, step 5, the choice: FIGHT (0) clears the player's actions, restores the tactics and
; goes to the fight (sub-phase 3); PLAN (1) takes the first able monster as wCommandMonster for the
; tactics menu (sub-phase 1), or 'But there's no one to command!' ($2D); ITEM (2) 'No items allowed
; in this battle!' ($1D) in link battles and battle kinds 4 and 5, 'There are no usable items!'
; ($1F) with none, otherwise the item menu (sub-phase 2); RUN (3) 'No fleeing from this battle!'
; ($20) in link battles, otherwise the flee attempt (step 8) in battle kinds 0 and 1, the refusal
; (step $0F) in kinds 2, 3, 5, 6 and 7, and 'Retire now?' (step $0B) in the others. (C2, E-0357;
; probed E-0379)
RunBattleSetup_MainMenu_Choose::
    ld a, [wMenuState]
    and $03
    ld [wBattleSetupDB], a
    or a
    jr z, .call_run_battle_setup_main_menu_choose_clear
    cp $01
    jr z, .read_link_role
    cp $02
    jr z, .check_link_mode
    jp .check_link_mode2

.call_run_battle_setup_main_menu_choose_clear:
    call RunBattleSetup_MainMenu_Choose_ClearActions
    call RunBattleSetup_MainMenu_RestoreTactics
    ld a, $03
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    jp .return

.read_link_role:
    ld a, [wLinkRole]
    sla a
    and $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    or a
    jr z, .set_command_monster
    inc c
    dec b
    jr nz, .loop
    ld a, $00
    ld [wStringCategory], a
    ld a, $2d
    ld [wStringIndex], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.set_command_monster:
    ld a, c
    ld [wCommandMonster], a
    ld a, $01
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    jr .return

.check_link_mode:
    ld a, [wLinkMode]
    or a
    jr nz, .set_string_index_to_1D
    ld a, [wBattleKind]
    cp $04
    jr z, .set_string_index_to_1D
    cp $05
    jr z, .set_string_index_to_1D
    call RunBattleSetup_MainMenu_Choose_ClearActions
    call CountUsableItems
    ld a, e
    or a
    jr nz, .set_battle_sub_phase_to_02
    ld a, $1f
    jr .set_string_index

.set_string_index_to_1D:
    ld a, $1d

.set_string_index:
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.set_battle_sub_phase_to_02:
    ld a, $02
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    jr .return

.check_link_mode2:
    ld a, [wLinkMode]
    or a
    jr z, .call_run_battle_setup_main_menu_choose_clear2
    ld a, $20
    jr .set_string_index

.call_run_battle_setup_main_menu_choose_clear2:
    call RunBattleSetup_MainMenu_Choose_ClearActions
    ld hl, wBattleResolveStep
    ld [hl], $08
    ld a, [wBattleKind]
    cp $02
    jr c, .return
    ld [hl], $0f
    cp $02
    jr z, .return
    cp $03
    jr z, .return
    cp $05
    jr z, .return
    cp $06
    jr z, .return
    cp $07
    jr z, .return
    ld [hl], $0b

.return:
    ret

; Clears the action choices of the player's three slots ($FF). (C2, E-0357; probed E-0379)
RunBattleSetup_MainMenu_Choose_ClearActions::
    ld a, [wLinkRole]
    and $02
    ld hl, wBattleActionChoice
    add a
    add a
    add_a_to_hl
    ld a, $ff
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ret

; Restores the player's three slots' tactics and last tactics from wFleeWork. (C2, E-0357; probed
; E-0379)
RunBattleSetup_MainMenu_RestoreTactics::
    ld a, [wLinkMode]
    or a
    jr nz, .check_link_role
    ld c, $00
    jr .skip

.check_link_role:
    ld a, [wLinkRole]
    and $02
    sla a
    ld c, a

.skip:
    ld de, wFleeWork
    ld b, $03

.loop:
    ld a, c
    ld hl, wSlotTactic
    add_a_to_hl
    ld a, [de]
    ld [hl], a
    ld a, $08
    add_a_to_hl
    push de
    inc de
    inc de
    inc de
    inc de
    ld a, [de]
    ld [hl], a
    pop de
    inc de
    inc c
    dec b
    jr nz, .loop
    ret

; Main menu, step 6: shows the chosen message (BeginStringDisplay_Bank2F); next step. (C1, E-0357)
RunBattleSetup_MainMenu_ShowMessage::
    call ClearWindowAndCopyRectFar
    call CopyMessageBoxToBGMapRow13
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; Main menu, step 7: after the text, redraws the window and returns to step 2. (C1, E-0357)
RunBattleSetup_MainMenu_RedrawWindow::
    ld a, [wTextFlags]
    or a
    ret nz
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call CopyMessageBoxToBGMapRow13
    call RunBattleSetup_MainMenu_BuildMenuWindow
    ld a, $02
    ld [wBattleResolveStep], a
    ret

; Main menu, step 8: '<player> fled!' (string $D8 of category 1) with sound $82; next step. (C1,
; E-0357)
RunBattleSetup_MainMenu_ShowFled::
    call ClearWindowAndCopyRectFar
    call CopyMessageBoxToBGMapRow13
    ld hl, wTextBuf0
    ld de, wPlayerName
    ld b, $0a

.loop:
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop
    ld [hl], $f0
    ld a, $01
    ld [wStringCategory], a
    ld a, $d8
    ld [wStringIndex], a ; '0 fled!'
    farcall BeginStringDisplay_Bank2F
    ld a, $82
    call QueueSoundEffect
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; Main menu, step 9, the flee attempt: it works on the first turn, when the party's highest level is
; more than 5 above the foes', with a chance of turn / 8 (7 in 8 from turn 4), or when no foe can
; act; otherwise 'But the escape route was cut' ($2C) and the next step. On success (outside link
; battles the personalities drop, LowerPersonalityAfterFleeing) the battle ends as fled
; (wBattleScene 2). (C1, E-0357)
RunBattleSetup_MainMenu_TryFlee::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannel1
    and [hl]
    cp $ff
    ret nz
    ld a, [wBattleTurn]
    or a
    jr z, .check_link_mode
    ld a, [wBattlePartyCount]
    ld b, a
    ld e, $00
    ld c, $00
    ld hl, wBattleLevel

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, [hl]
    cp e
    jr c, .next
    ld e, a

.next:
    inc hl
    inc c
    dec b
    jr nz, .loop
    ld a, [wBattleFoeCount]
    ld b, a
    ld d, $00
    ld c, $04
    ld hl, wBattleLevel + $4

.loop2:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next2
    ld a, [hl]
    cp d
    jr c, .next2
    ld d, a

.next2:
    inc hl
    inc c
    dec b
    jr nz, .loop2
    ld a, d
    add $05
    cp e
    jr c, .check_link_mode
    call NextTableByte
    ld a, [wRandomLo]
    and $07
    inc a
    ld b, a
    ld a, [wBattleTurn]
    cp $04
    jr c, .skip
    ld a, $07

.skip:
    cp b
    jr nc, .check_link_mode
    call RunBattleSetup_MainMenu_TryFlee_CountAbleFoes
    jr z, .check_link_mode
    ld a, $00
    ld [wStringCategory], a
    ld a, $2c
    ld [wStringIndex], a ; 'But the escape route was cut'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

.check_link_mode:
    ld a, [wLinkMode]
    or a
    jr nz, .set_battle_scene_to_02
    call LowerPersonalityAfterFleeing

.set_battle_scene_to_02:
    ld a, $02
    ld [wBattleScene], a
    ld a, $02
    ld [wBattlePhase], a
    ld a, $03
    ld [wBattleStep], a
    ld a, $01
    ld [wTextSpeed], a
    ld a, [wDataBankSave]
    ld [wDataBank], a
    xor a
    ld [wDataBankSave], a
    ret

; Counts the foes that can act (not blocked by CheckSlotStatusBlockWide_Bank31); Z when none. (C2,
; E-0357; probed E-0379)
RunBattleSetup_MainMenu_TryFlee_CountAbleFoes::
    ld a, [wBattleFoeCount]
    ld b, a
    ld c, $04
    ld e, $00

.loop:
    ld a, c
    call CheckSlotStatusBlockWide_Bank31
    jr c, .next
    inc e

.next:
    inc c
    dec b
    jr nz, .loop
    ld a, e
    or a
    ret

; After fleeing, lowers each present party monster's personality Hi, Mid, Lo and trait (not below 0)
; by its row of the table: by level band (below 10, 20, 30, or 30 and over) and trait ($97 or more
; uses the second table). (C2, E-0357; probed E-0380)
LowerPersonalityAfterFleeing::
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld hl, wBattleLevel
    add_a_to_hl
    ld a, [hl]
    ld e, $00
    cp $0a
    jr c, .skip
    ld e, $01
    cp $14
    jr c, .skip
    ld e, $02
    cp $1e
    jr c, .skip
    ld e, $03

.skip:
    ld a, c
    ld hl, wSlotTrait
    add_a_to_hl
    ld a, [hl]
    cp $97
    ld hl, LowerPersonalityAfterFleeing_Data1
    jr c, .skip2
    ld hl, LowerPersonalityAfterFleeing_Data2

.skip2:
    ld a, e
    add a
    add a
    add_a_to_hl
    ld de, wSlotPersonalityHi
    call LowerPersonalityAfterFleeing_LowerByte
    inc hl
    ld de, wSlotPersonalityMid
    call LowerPersonalityAfterFleeing_LowerByte
    inc hl
    ld de, wSlotPersonalityLo
    call LowerPersonalityAfterFleeing_LowerByte
    inc hl
    ld de, wSlotTrait
    call LowerPersonalityAfterFleeing_LowerByte

.next:
    inc c
    dec b
    jr nz, .loop
    ret

; DE = first byte of an array, C = index, HL = the address of the amount: the byte at DE + C is
; lowered by the byte at HL, and a result below 0 is stored as 0. Returns A = the stored byte, DE =
; the address DE + C, HL unchanged, carry clear and Z set when the stored byte is 0. Its only
; caller, LowerPersonalityAfterFleeing, uses it for the personality Hi, Mid, Lo and trait bytes of a
; slot. (C2, E-0380)
; the byte at DE + C -= the byte at HL, not below 0
LowerPersonalityAfterFleeing_LowerByte::
    ld a, c
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    sub [hl]
    ld [de], a
    ret nc
    xor a
    ld [de], a
    ret

; data read by LowerPersonalityAfterFleeing (16 bytes) (E-0347)
LowerPersonalityAfterFleeing_Data1::
    db $04, $00, $00, $0a, $03, $00, $00, $05, $02, $00, $00, $03, $01, $00, $00, $02

LowerPersonalityAfterFleeing_Data2::
    db $08, $00, $00, $0f, $06, $00, $00, $0a, $04, $00, $00, $05, $02, $00, $00, $03

; Main menu, step 10: after the text, marks the player's present slots 3 (empty $FF) and goes to the
; fight (sub-phase 3): the escape failed and the turn is lost. (C2, E-0357; probed E-0380)
RunBattleSetup_MainMenu_StartFight::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00
    ld hl, wSlotMarks

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    ld [hl], $03
    jr .next

.skip:
    ld [hl], $ff

.next:
    inc hl
    inc c
    dec b
    jr nz, .loop
    ld a, $03
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    ret

; Main menu, step 11: 'Retire now?' ($27); next step. (C1, E-0357)
RunBattleSetup_MainMenu_ShowRetireNow::
    call ClearWindowAndCopyRectFar
    call CopyMessageBoxToBGMapRow13
    ld a, $00
    ld [wStringCategory], a
    ld a, $27
    ld [wStringIndex], a ; 'Retire now?'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; Main menu, step 12: after the text, draws the yes/no box with the cursor on no; next step. (C1,
; E-0357)
RunBattleSetup_MainMenu_DrawYesNo::
    ld a, [wTextFlags]
    or a
    ret nz
    farcall LoadCursorTileAndRect
    ld a, $bb
    ld [wWindowTileBuffer + $7], a
    ld a, $01
    ld [wMenuSubState], a
    ld de, wScreenTileBuffer + $10e
    ld hl, vBGMap0 + $10e
    lb bc, $06, $05
    call CopyRect32StrideToVRAM
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; Main menu, step 13: the yes/no cursor; A on no redraws the foes' area and returns to the main menu
; (step 1); on yes 'You threw in the towel!' ($60) and the next step. (C1, E-0357)
RunBattleSetup_MainMenu_YesNoCursor::
    ld de, RunBattleSetup_MainMenu_YesNoCursor_Data2
    ld hl, wMenuSubState
    call ToggleEntryBitsByJoypadAndBlink
    ld a, [wJoypadPressed]
    and $01
    ret z
    ld a, [wMenuSubState]
    and $01
    ld hl, RunBattleSetup_MainMenu_YesNoCursor_Data1
    add a
    add_a_to_hl
    deref_hl
    ld a, $bc
    call WriteVRAMByte
    ld a, [wMenuSubState]
    and $01
    jr z, .set_string_category_to_00
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call CopyScreenBufferRect12x11ToBGMapRow7
    ld a, $01
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleSubPhase], a
    ret

.set_string_category_to_00:
    ld a, $00
    ld [wStringCategory], a
    ld a, $60
    ld [wStringIndex], a ; 'You threw in the towel!'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; data read by RunBattleSetup_MainMenu_YesNoCursor (4 bytes) (E-0347)
RunBattleSetup_MainMenu_YesNoCursor_Data1::
    db $2f, $99, $6f, $99

; Main menu, step 14: after the text the battle ends as given up (wBattleScene 3). (C2, E-0357;
; probed E-0380)
RunBattleSetup_MainMenu_Retire::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, $03
    ld [wBattleScene], a
    ld a, $02
    ld [wBattlePhase], a
    ld a, $06
    ld [wBattleStep], a
    xor a
    ld [wBattleSubPhase], a
    ld [wBattleResolveStep], a
    ld a, [wDataBankSave]
    ld [wDataBank], a
    xor a
    ld [wDataBankSave], a
    ret

; Main menu, step 15: 'No fleeing from this battle!' ($20); next step. (C1, E-0357)
RunBattleSetup_MainMenu_ShowNoFleeingFromThis::
    call ClearWindowAndCopyRectFar
    call CopyMessageBoxToBGMapRow13
    ld a, $00
    ld [wStringCategory], a
    ld a, $20
    ld [wStringIndex], a ; 'No fleeing from this battle!'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; Main menu, step 16: after the text, back to step 1. (C2, E-0357; probed E-0380)
RunBattleSetup_MainMenu_BackToMenu::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, $01
    ld [wBattleResolveStep], a
    ret

; Sub-phase 1 of RunBattleSetup, the PLAN menu: wBattleResolveStep ($00-$23, 36 entries) picks the
; step. The steps draw and run, one after the other, the tactic window (Charge, Mixed, Defense,
; Command), for Command the action window (Fight, Skill, Guard), the skill list, and the foe and
; ally target lists, plus the message steps; each step sets wBattleResolveStep to the next one. Step
; $20, RunBattleSetup_PlanMenu_NextMonster, goes on to the next monster of the side and after the
; last one sets wBattleSubPhase to 3. RunBattleSetup_PlanMenu_RedrawFoesAgain is the target of two
; entries ($16 and $22). (C1, E-0380)
; by wBattleResolveStep: the PLAN menu: each able monster's tactic (Charge, Mixed, Defense, Command)
; and, for Command, its action (Fight, Skill, Guard), skill and target (E-0364; was
; RunBattleSetup_PlanMenu, E-0288)
RunBattleSetup_PlanMenu::
    ld a, [wBattleResolveStep]
    jumptable
    dw RunBattleSetup_PlanMenu_DrawTactics
    dw RunBattleSetup_PlanMenu_ShowTacticCursor
    dw RunBattleSetup_PlanMenu_TacticCursor
    dw RunBattleSetup_PlanMenu_BackToMainMenu
    dw RunBattleSetup_PlanMenu_DrawActions
    dw RunBattleSetup_PlanMenu_ShowActionCursor
    dw RunBattleSetup_PlanMenu_ChooseAction
    dw RunBattleSetup_PlanMenu_AfterAction
    dw RunBattleSetup_PlanMenu_ClearForNoSkills
    dw RunBattleSetup_PlanMenu_ShowItHasNoUsable
    dw RunBattleSetup_PlanMenu_RedrawFoes
    dw RunBattleSetup_PlanMenu_BackToActions
    dw RunBattleSetup_PlanMenu_DrawFightFoeList
    dw RunBattleSetup_PlanMenu_ShowFoeCursor
    dw RunBattleSetup_PlanMenu_ChooseFoe
    dw RunBattleSetup_PlanMenu_AfterFoeTarget
    dw RunBattleSetup_PlanMenu_DrawSkillList
    dw RunBattleSetup_PlanMenu_ShowSkillCursor
    dw RunBattleSetup_PlanMenu_ChooseSkill
    dw RunBattleSetup_PlanMenu_ReturnToStep
    dw RunBattleSetup_PlanMenu_ClearForSkillMessage
    dw RunBattleSetup_PlanMenu_ShowSkillMessage
    dw RunBattleSetup_PlanMenu_RedrawFoesAgain
    dw RunBattleSetup_PlanMenu_BackToSkills
    dw RunBattleSetup_PlanMenu_DrawAllyTargets
    dw RunBattleSetup_PlanMenu_ShowAllyCursor
    dw RunBattleSetup_PlanMenu_ChooseAlly
    dw RunBattleSetup_PlanMenu_ReturnFromAllyList
    dw RunBattleSetup_PlanMenu_DrawFoeList
    dw RunBattleSetup_PlanMenu_ShowSkillFoeCursor
    dw RunBattleSetup_PlanMenu_ChooseSkillFoe
    dw RunBattleSetup_PlanMenu_ReturnFromFoeList
    dw RunBattleSetup_PlanMenu_NextMonster
    dw RunBattleSetup_PlanMenu_ShowMessage
    dw RunBattleSetup_PlanMenu_RedrawFoesAgain
    dw RunBattleSetup_PlanMenu_BackToAllyList

; PLAN menu, step 0: draws the tactics window (string 1 of bank $09's category 2: Charge, Mixed,
; Defense and, when wCommandMenuState is set, string 7; otherwise Command), the menu box and the
; monster's name tiles; next step. (C1, E-0357)
RunBattleSetup_PlanMenu_DrawTactics::
    ld hl, vTiles1 + $6d0
    ld de, $2001
    ld a, $02
    ld [wStringCategory], a
    ld a, $01
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    ld a, [wCommandMenuState]
    or a
    jr z, .clear_command_page_count
    ld a, $07
    ld [wStringIndex], a
    ld hl, vTiles2 + $50
    ld de, $0801
    call ShowStringBank09AtTilesHL_Bank31

.clear_command_page_count:
    xor a
    ld [wCommandPageCount], a
    ld a, $03
    ld [wCommandCursorMax], a
    xor a
    ld [wCommandCursor], a
    call RunBattleSetup_PlanMenu_DrawTactics_BuildBox
    ld a, [wCommandMonster]
    and $03
    ld hl, wScreenTileBuffer + $103
    call WriteFiveTilesFromTable
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; PLAN menu, step 1: puts the cursor ($BB) on the monster's last tactic (wBattleLoadWork); next
; step. (C1, E-0357)
RunBattleSetup_PlanMenu_ShowTacticCursor::
    ld a, [wCommandMonster]
    and $03
    ld hl, wBattleLoadWork
    add_a_to_hl
    ld a, [hl]
    ld [wMenuSubState], a
    call CopyScreenBufferRect12x11ToBGMapRow7
    ld hl, RunBattleSetup_PlanMenu_ShowTacticCursor_Data
    ld a, [wMenuSubState]
    and $03
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $bb
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $03
    ld [wListLastPageSize], a
    ret

; PLAN menu, step 2: moves the cursor; A plays sound $69, keeps the choice and sets it as the
; monster's tactic: Command (3) lets the player pick its move (two steps on), or with
; wCommandMenuState set gives it action 0; Charge, Mixed and Defense clear its action and leave it
; to act on the tactic (step $20); B goes back to the previous able monster, or to the main menu
; from the first. (C1, E-0357)
RunBattleSetup_PlanMenu_TacticCursor::
    ld de, RunBattleSetup_PlanMenu_ShowTacticCursor_Data
    ld hl, wMenuSubState
    call MoveBattleCommandCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    ld a, [wCommandMonster]
    and $03
    ld hl, wBattleLoadWork
    add_a_to_hl
    ld a, [wMenuSubState]
    and $03
    ld [hl], a
    call SetSlotTacticAndSlotLastTacticForCommandMonster
    cp $03
    jr nz, .read_command_monster
    ld a, [wCommandMenuState]
    or a
    jr z, .call_fill_screen_tile_buffer_row11_col4_with
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a
    add_a_to_hl
    ld [hl], $00
    jr .read_command_monster2

.call_fill_screen_tile_buffer_row11_col4_with:
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $00
    ld [wBattleArg1], a
    ret

.check_bit1:
    bit 1, a
    jr z, .return

.loop:
    ld a, [wCommandMonster]
    and $03
    jr z, .set_battle_arg1_to_00
    ld a, [wCommandMonster]
    dec a
    ld [wCommandMonster], a
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    or a
    jr nz, .loop
    ld a, [wCommandMonster]
    and $03
    ld hl, wScreenTileBuffer + $103
    call WriteFiveTilesFromTable
    ld hl, wBattleResolveStep
    dec [hl]
    jr .return

.set_battle_arg1_to_00:
    ld a, $00
    ld [wBattleArg1], a
    jr .call_fill_screen_tile_buffer_row11_col4_with2

.read_command_monster:
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a
    add_a_to_hl
    ld a, $ff
    ld [hli], a
    ld [hl], a

.read_command_monster2:
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    set 7, [hl]
    ld a, $20
    ld [wBattleResolveStep], a
    jr .return

.call_fill_screen_tile_buffer_row11_col4_with2:
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]

.return:
    ret

; PLAN menu, step 3: redraws the foes' area and returns to the main menu (step 1). (C1, E-0357)
RunBattleSetup_PlanMenu_BackToMainMenu::
    call CopyScreenBufferRect12x11ToBGMapRow7
    ld a, $01
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleSubPhase], a
    ret

; PLAN menu, step 4 (Command chosen): draws the action window (string 2 of bank $09's category 2,
; 'FightSklGuard') with the monster's name and puts the choice at its last action (wSideControl bits
; 4-5); next step. (C1, E-0357)
RunBattleSetup_PlanMenu_DrawActions::
    ld a, [wBattleArg1]
    or a
    call z, CopyScreenBufferRect12x11ToBGMapRow7
    xor a
    ld [wBattleArg1], a
    ld hl, vTiles1 + $6d0
    ld de, $0801
    ld a, $02
    ld [wStringCategory], a
    ld a, $02
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    call RunBattleSetup_PlanMenu_DrawActions_BuildBox
    ld a, [wCommandMonster]
    and $03
    ld hl, wScreenTileBuffer + $141
    call WriteFiveTilesFromTable
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    swap a
    and $03
    ld [wMenuSelectedMember], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; PLAN menu, step 5: draws the window and the cursor ($BB) at that choice; next step. (C1, E-0357)
RunBattleSetup_PlanMenu_ShowActionCursor::
    call RunBattleSetup_PlanMenu_CopyLeftBoxToBGMap
    ld hl, RunBattleSetup_PlanMenu_ShowActionCursor_Data
    ld a, [wMenuSelectedMember]
    and $03
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $bb
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; PLAN menu, step 6, the action: B goes back to the tactics (step 7, then 0); A keeps the choice in
; wSideControl bits 4-5: Fight attacks the only foe (action 0) or chooses a foe (step $0C); Skill
; shows 'It has no usable battle skills!' (step 8) or the skill list (step $10); Guard (action
; SKILL_GUARD at itself) is done. (C1, E-0357)
RunBattleSetup_PlanMenu_ChooseAction::
    ld de, RunBattleSetup_PlanMenu_ShowActionCursor_Data
    ld hl, wMenuSelectedMember
    call ThreeEntryListCursor
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit0
    ld a, $00
    ld [wBattleArg1], a
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]
    jp .return

.check_bit0:
    bit 0, a
    jp z, .return
    ld a, $69
    call QueueSoundEffect
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    and $0f
    ld [hl], a
    ld a, [wMenuSelectedMember]
    and $03
    swap a
    or [hl]
    ld [hl], a
    ld a, [wMenuSelectedMember]
    and $03
    or a
    jr z, .call_count_present_foes_of_link_role_side
    cp $01
    jr z, .call_count_usable_skills
    jr .read_command_monster

.call_count_present_foes_of_link_role_side:
    call CountPresentFoesOfLinkRoleSide_Bank31
    ld a, d
    cp $01
    jr nz, .call_fill_screen_tile_buffer_row11_col4_with
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a
    add_a_to_hl
    ld a, $00
    ld [hli], a
    ld [hl], e
    jr .set_battle_arg1_to_01

.call_fill_screen_tile_buffer_row11_col4_with:
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $0c
    ld [wBattleResolveStep], a
    xor a
    ld [wSubMenuCursor2], a
    jr .return

.call_count_usable_skills:
    call CountUsableSkills
    ld a, d
    or a
    jr nz, .call_fill_screen_tile_buffer_row11_col4_with2
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $08
    ld [wBattleResolveStep], a
    jr .return

.call_fill_screen_tile_buffer_row11_col4_with2:
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    xor a
    ld [wBattleArg1], a
    ld a, $10
    ld [wBattleResolveStep], a
    jr .return

.read_command_monster:
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a
    add_a_to_hl
    ld a, $ac
    ld [hli], a
    ld a, [wCommandMonster]
    ld [hl], a

.set_battle_arg1_to_01:
    ld a, $01
    ld [wBattleArg1], a
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]

.return:
    ret

; PLAN menu, step 7: redraws; with an action chosen goes on to the next monster (step $20),
; otherwise back to the tactics (step 0). (C1, E-0357)
RunBattleSetup_PlanMenu_AfterAction::
    call RunBattleSetup_PlanMenu_CopyLeftBoxToBGMap
    ld a, [wBattleArg1]
    or a
    jr z, .set_battle_resolve_step
    ld a, $20

.set_battle_resolve_step:
    ld [wBattleResolveStep], a
    ret

; PLAN menu, step 8: redraws and clears the message window; next step. (C1, E-0357)
RunBattleSetup_PlanMenu_ClearForNoSkills::
    call RunBattleSetup_PlanMenu_CopyLeftBoxToBGMap
    call ClearWindowAndCopyRectFar
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; PLAN menu, step 9: 'It has no usable battle skills!' ($29); next step. (C1, E-0357)
RunBattleSetup_PlanMenu_ShowItHasNoUsable::
    call CopyMessageBoxToBGMapRow13
    ld a, $00
    ld [wStringCategory], a
    ld a, $29
    ld [wStringIndex], a ; 'It has no usable battle skills!'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; PLAN menu, step 10: after the text redraws the foes' area; next step. (C2, E-0357; probed E-0380)
RunBattleSetup_PlanMenu_RedrawFoes::
    ld a, [wTextFlags]
    or a
    ret nz
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; PLAN menu, step 11: back to the action window (step 4). (C1, E-0357)
RunBattleSetup_PlanMenu_BackToActions::
    call CopyMessageBoxToBGMapRow13
    ld a, $04
    ld [wBattleResolveStep], a
    ret

; PLAN menu, step 12: draws the foe list (the other side's present slots); next step. (C1, E-0357)
RunBattleSetup_PlanMenu_DrawFightFoeList::
    call RunBattleSetup_PlanMenu_CopyLeftBoxToBGMap
    call RunBattleSetup_DrawFoeList_BuildBox
    xor a
    ld [wBattleArg1], a
    farcall ListFarSideSlots
    xor a
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; PLAN menu, step 13: puts the target cursor on the first present foe; next step. (C1, E-0357)
RunBattleSetup_PlanMenu_ShowFoeCursor::
    call CopyScreenBufferRect14x7ToBGMapRow11
    xor a
    ld [wNameSlot], a
    ld a, [wLinkRole]
    sla a
    and $04
    xor $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld e, $01
    ld a, $00
    call MoveTargetCursor
    ld hl, RunBattleSetup_PlanMenu_ShowActionCursor_Data
    and $03
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $bb
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; PLAN menu, step 14, choosing a foe to attack: B goes back (step 15, then 4); A attacks it (action
; 0 at that slot on the other side) and goes on (step 15, then $20). (C1, E-0357)
RunBattleSetup_PlanMenu_ChooseFoe::
    ld a, [wLinkRole]
    sla a
    and $04
    xor $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld de, RunBattleSetup_PlanMenu_ShowActionCursor_Data
    call TargetCursor
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit0
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $00
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.check_bit0:
    bit 0, a
    jr z, .return
    ld a, $69
    call QueueSoundEffect
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a
    add_a_to_hl
    ld a, $00
    ld [hli], a
    ld a, [wSubMenuCursor2]
    and $03
    ld b, a
    ld a, [wLinkRole]
    sla a
    and $04
    xor $04
    or b
    ld [hl], a
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $01
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]

.return:
    ret

; PLAN menu, step 15: redraws; to the next monster ($20) with a target chosen, otherwise back to the
; action window (4). (C1, E-0357)
RunBattleSetup_PlanMenu_AfterFoeTarget::
    call CopyScreenBufferRect14x7ToBGMapRow11
    ld a, [wBattleArg0]
    or a
    jr z, .set_battle_resolve_step_to_04
    ld a, $20
    jr .set_battle_resolve_step

.set_battle_resolve_step_to_04:
    ld a, $04

.set_battle_resolve_step:
    ld [wBattleResolveStep], a
    ret

; PLAN menu, step 16: the skill list: the page and entry from the monster's last skill (wSideControl
; bits 0-2), the four skill names of the page and the selected skill's description (category 9);
; next step. (C1, E-0357)
RunBattleSetup_PlanMenu_DrawSkillList::
    ld a, [wBattleArg1]
    or a
    call z, RunBattleSetup_PlanMenu_CopyLeftBoxToBGMap
    xor a
    ld [wBattleArg1], a
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    and $03
    ld [wMenuCursor], a
    ld a, [hl]
    rrca
    rrca
    and $01
    ld [wCommandCursor], a
    ld hl, wCommandCursor
    res 7, [hl]
    ld de, RunBattleSetup_PlanMenu_ShowTacticCursor_Data
    call ShowSkillPageNames
    call RunBattleSetup_PlanMenu_RedrawSkillList
    call RunBattleSetup_PlanMenu_DrawSkillList_BuildBoxes
    ld a, $09
    ld [wStringCategory], a
    ld a, [wBattleArg2]
    ld l, a
    ld a, [wBattleArg3]
    ld h, a
    ld a, [wCommandCursor]
    add a
    add a
    ld c, a
    ld a, [wMenuCursor]
    and $03
    add c
    add a
    add_a_to_hl
    ld a, [hl]
    call RunBattleSetup_PlanMenu_ShowSkillDescAndMP
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; PLAN menu, step 17: draws the list, the cursor and the page indicator; next step. (C1, E-0357)
RunBattleSetup_PlanMenu_ShowSkillCursor::
    call RunBattleSetup_PlanMenu_RedrawLowerRows
    ld hl, RunBattleSetup_PlanMenu_ShowTacticCursor_Data
    ld a, [wMenuCursor]
    and $03
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $bb
    call WriteVRAMByte
    call DrawInventoryPageIndicator
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $03
    ld [wListLastPageSize], a
    ret

; PLAN menu, step 18, choosing a skill: B goes back to the action window; A: a skill whose record
; byte 3 has bit 0 clear gives 'That skill can't be used in battle!' ($25), too little MP (cost $FF
; counts as 1) 'Not enough MP!' ($26); otherwise it keeps the cursor in wSideControl, takes the
; skill as the action and its target from record byte 4: $FF and $14 none, $80 and $12 the other
; side, $22 (and SKILL_IRONIZE) its own side, $11 the only foe or a chosen one (step $1C), $21
; itself when alone (not for SKILL_VIVIFY and SKILL_REVIVE) or a chosen ally (step $18), $40 itself.
; (C1, E-0357)
RunBattleSetup_PlanMenu_ChooseSkill::
    ld de, RunBattleSetup_PlanMenu_ShowTacticCursor_Data
    ld hl, wMenuCursor
    call MoveBattleCommandCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jp z, .check_joypad_pressed
    ld a, $69
    call QueueSoundEffect
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $20
    ld [wBattleArg1], a
    call LoadSelectedSkillRecord_Bank31
    ld a, [wRecordBufferData + $3]
    bit 0, a
    jp z, .set_string_index_to_25
    ld a, [wCommandMonster]
    ld hl, wBattleMP
    add a
    add_a_to_hl
    deref_hl
    ld a, [wRecordBufferData]
    ld c, a
    cp $ff
    jr nz, .skip
    ld c, $01

.skip:
    xor a
    ld b, a
    ld a, l
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    bit 7, h
    jp nz, .set_string_index_to_26
    ld a, [wCommandMonster]
    ld hl, wSideControl
    add_a_to_hl
    ld a, [hl]
    and $f0
    ld [hl], a
    ld a, [wCommandCursor]
    rlca
    rlca
    and $04
    or [hl]
    ld [hl], a
    ld a, [wMenuCursor]
    and $03
    or [hl]
    ld [hl], a
    ld a, [wCommandMonster]
    ld hl, wBattleActionChoice
    add a
    add_a_to_hl
    ld a, [wRecordBuffer]
    ld [hli], a
    cp $35
    jr z, .check_command_monster3
    ld a, [wRecordBufferData + $4]
    cp $ff
    jr z, .skip2
    cp $14
    jr z, .skip2
    cp $80
    jr z, .check_command_monster
    cp $12
    jr z, .check_command_monster2
    cp $22
    jr z, .check_command_monster3
    cp $11
    jr z, .call_count_present_foes_of_link_role_side
    cp $21
    jr z, .call_count_present_slots_of_link_role_side
    cp $40
    jr z, .read_command_monster
    jp .return

.skip2:
    ld hl, wBattleResolveStep
    inc [hl]
    jp .return

.check_command_monster:
    ld a, [wCommandMonster]
    and $04
    xor $04
    ld [hl], a
    ld hl, wBattleResolveStep
    inc [hl]
    jp .return

.check_command_monster2:
    ld a, [wCommandMonster]
    and $04
    xor $04
    ld [hl], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.check_command_monster3:
    ld a, [wCommandMonster]
    and $04
    ld [hl], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.call_count_present_foes_of_link_role_side:
    call CountPresentFoesOfLinkRoleSide_Bank31
    ld a, d
    cp $01
    jr nz, .set_battle_arg1_to_1C
    ld [hl], e
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.set_battle_arg1_to_1C:
    ld a, $1c
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.call_count_present_slots_of_link_role_side:
    call CountPresentSlotsOfLinkRoleSide_Bank31
    ld a, d
    cp $01
    jr nz, .set_battle_arg1_to_18
    ld a, [wRecordBuffer]
    cp $1e
    jr z, .set_battle_arg1_to_18
    cp $1f
    jr z, .set_battle_arg1_to_18
    ld a, [wCommandMonster]
    ld [hl], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.set_battle_arg1_to_18:
    ld a, $18
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.read_command_monster:
    ld a, [wCommandMonster]
    ld [hl], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .call_run_battle_setup_plan_menu_redraw_skill
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $04
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.call_run_battle_setup_plan_menu_redraw_skill:
    call RunBattleSetup_PlanMenu_RedrawSkillList
    call DrawInventoryPageIndicator

.return:
    ret

.set_string_index_to_25:
    ld a, $25
    ld [wStringIndex], a
    ld a, $13
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.set_string_index_to_26:
    ld a, $26
    ld [wStringIndex], a
    ld a, $13
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

; PLAN menu, step 19: redraws and goes to the step kept in wBattleArg1. (C1, E-0357)
RunBattleSetup_PlanMenu_ReturnToStep::
    call RunBattleSetup_PlanMenu_RedrawLowerRows
    ld a, [wBattleArg1]
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleArg1], a
    ret

; PLAN menu, step 20: redraws and clears the message window; next step. (C1, E-0357)
RunBattleSetup_PlanMenu_ClearForSkillMessage::
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call RunBattleSetup_PlanMenu_RedrawLowerRows
    call ClearWindowAndCopyRectFar
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; PLAN menu, step 21: shows message wStringIndex of category 0; next step. (C1, E-0357)
RunBattleSetup_PlanMenu_ShowSkillMessage::
    call CopyMessageBoxToBGMapRow13
    xor a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; PLAN menu, step 22: after the text redraws the foes' area; next step. (C2, E-0357; probed E-0380)
RunBattleSetup_PlanMenu_RedrawFoesAgain::
    ld a, [wTextFlags]
    or a
    ret nz
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; PLAN menu, step 23: back to the skill list (step $10). (C1, E-0357)
RunBattleSetup_PlanMenu_BackToSkills::
    call CopyMessageBoxToBGMapRow13
    ld a, $10
    ld [wBattleResolveStep], a
    ret

; PLAN menu, step 24: draws the ally list (string 3 of category 2); next step. (C1, E-0357)
RunBattleSetup_PlanMenu_DrawAllyTargets::
    ld hl, vTiles1 + $6d0
    ld de, $0801
    ld a, $02
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    call RunBattleSetup_PlanMenu_AllyListForSkill
    xor a
    ld [wSubMenuCursor2], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; PLAN menu, step 25: puts the cursor on the first present ally (fallen ones count for SKILL_VIVIFY
; and SKILL_REVIVE); next step. (C1, E-0357)
RunBattleSetup_PlanMenu_ShowAllyCursor::
    call RunBattleSetup_CopyLeftBoxToBGMap
    ld a, [wRecordBuffer]
    cp $1e
    jr z, .set_name_slot
    cp $1f
    jr z, .set_name_slot
    xor a

.set_name_slot:
    ld [wNameSlot], a
    ld a, [wLinkRole]
    sla a
    and $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld e, $01
    ld a, $00
    call MoveTargetCursor
    ld hl, RunBattleSetup_PlanMenu_ShowActionCursor_Data
    and $03
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $bb
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; PLAN menu, step 26, choosing an ally: B goes back to the skill list; A on itself with SKILL_MPASS,
; SKILL_MPASSMORE, SKILL_MPASSMOST or SKILL_COVER gives 'That skill isn't for own use!' ($65);
; otherwise the ally becomes the target and it goes on to the next monster. (C1, E-0357)
RunBattleSetup_PlanMenu_ChooseAlly::
    ld a, [wLinkRole]
    sla a
    and $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld de, RunBattleSetup_PlanMenu_ShowActionCursor_Data
    call TargetCursor
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit0
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $10
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.check_bit0:
    bit 0, a
    jr z, .return
    ld a, $69
    call QueueSoundEffect
    ld a, [wRecordBuffer]
    cp $1b
    jr z, .check_command_monster
    cp $1c
    jr z, .check_command_monster
    cp $1d
    jr z, .check_command_monster
    cp $97
    jr nz, .read_command_monster

.check_command_monster:
    ld a, [wCommandMonster]
    and $03
    ld c, a
    ld a, [wSubMenuCursor2]
    and $03
    cp c
    jr nz, .read_command_monster
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call RunBattleSetup_PlanMenu_RedrawLowerRows
    call ClearWindowAndCopyRectFar
    ld a, $65
    ld [wStringIndex], a
    ld a, $21
    ld [wBattleResolveStep], a
    jr .return

.read_command_monster:
    ld a, [wCommandMonster]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld a, [wSubMenuCursor2]
    and $03
    ld b, a
    ld a, [wCommandMonster]
    and $04
    or b
    ld [hl], a
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $20
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]

.return:
    ret

; PLAN menu, step 27: redraws and goes to the step kept in wBattleArg0. (C1, E-0357)
RunBattleSetup_PlanMenu_ReturnFromAllyList::
    call RunBattleSetup_CopyLeftBoxToBGMap
    ld a, [wBattleArg0]
    ld [wBattleResolveStep], a
    ret

; PLAN menu, step 28: draws the foe list for a skill (fallen ones too for SKILL_VIVIFY and
; SKILL_REVIVE); next step. (C1, E-0357)
RunBattleSetup_PlanMenu_DrawFoeList::
    call RunBattleSetup_DrawFoeList_BuildBox
    ld a, [wRecordBuffer]
    cp $1e
    jr z, .set_battle_arg1
    cp $1f
    jr z, .set_battle_arg1
    xor a

.set_battle_arg1:
    ld [wBattleArg1], a
    farcall ListFarSideSlots
    xor a
    ld [wBattleArg1], a
    xor a
    ld [wSubMenuCursor2], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; PLAN menu, step 29: puts the cursor on the first present foe; next step. (C1, E-0357)
RunBattleSetup_PlanMenu_ShowSkillFoeCursor::
    call CopyScreenBufferRect14x7ToBGMapRow11
    ld a, [wRecordBuffer]
    cp $1e
    jr z, .set_name_slot
    cp $1f
    jr z, .set_name_slot
    xor a

.set_name_slot:
    ld [wNameSlot], a
    ld a, [wLinkRole]
    sla a
    and $04
    xor $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld e, $01
    ld a, $00
    call MoveTargetCursor
    ld hl, RunBattleSetup_PlanMenu_ShowActionCursor_Data
    and $03
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $bb
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; PLAN menu, step 30, choosing a foe for the skill: B back to the skill list; A makes it the target
; (the other side) and goes on to the next monster. (C1, E-0357)
RunBattleSetup_PlanMenu_ChooseSkillFoe::
    ld a, [wLinkRole]
    sla a
    and $04
    xor $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld de, RunBattleSetup_PlanMenu_ShowActionCursor_Data
    call TargetCursor
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit0
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $10
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.check_bit0:
    bit 0, a
    jr z, .return
    ld a, $69
    call QueueSoundEffect
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, [wCommandMonster]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld a, [wSubMenuCursor2]
    and $03
    ld b, a
    ld a, [wLinkRole]
    sla a
    and $04
    xor $04
    or b
    ld [hl], a
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $20
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]

.return:
    ret

; PLAN menu, step 31: redraws and goes to the step kept in wBattleArg0. (C1, E-0357)
RunBattleSetup_PlanMenu_ReturnFromFoeList::
    call CopyScreenBufferRect14x7ToBGMapRow11
    ld a, [wBattleArg0]
    ld [wBattleResolveStep], a
    ret

; PLAN menu, step 32: on to the next able monster of the side (back to step 0 for it); after the
; third, to the fight (sub-phase 3). (C2, E-0357; probed E-0380)
RunBattleSetup_PlanMenu_NextMonster::
    ld a, [wCommandMonster]
    and $04
    or $03
    ld b, a

.loop:
    ld a, [wCommandMonster]
    inc a
    ld [wCommandMonster], a
    cp b
    jr z, .clear_battle_resolve_step
    ld hl, wSlotMarks
    add_a_to_hl
    ld a, [hl]
    or a
    jr nz, .loop
    xor a
    ld [wBattleResolveStep], a
    jr .return

.clear_battle_resolve_step:
    xor a
    ld [wBattleResolveStep], a
    ld a, $03
    ld [wBattleSubPhase], a

.return:
    ret

; PLAN menu, step 33: shows message wStringIndex of category 0; next step. (C1, E-0357)
RunBattleSetup_PlanMenu_ShowMessage::
    call CopyMessageBoxToBGMapRow13
    xor a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; PLAN menu, step 35: back to the ally list (step $18). (C1, E-0357)
RunBattleSetup_PlanMenu_BackToAllyList::
    call CopyMessageBoxToBGMapRow13
    ld a, $18
    ld [wBattleResolveStep], a
    ret

; Sub-phase 2 of RunBattleSetup, the ITEM menu: wBattleResolveStep ($00-$13, 20 entries) picks the
; step. Steps 0-2 draw and run the bag list, 4-7 the side window, 8-11 the ally list, 12-15 the foe
; list, and 16-19 the message for an item that cannot be used; an item that needs no further choice
; sets wBattleItemTarget and wBattleSubPhase to 3 (the fight) from the step that chose it, and B on
; the list sets wBattleItemTarget and wBattleItemId to $FF and returns to the main menu. (C1,
; E-0380)
; by wBattleResolveStep: the ITEM menu: the bag list, then the side and target the item needs
; (E-0364; was RunBattleSetup_ItemMenu, E-0304)
RunBattleSetup_ItemMenu::
    ld a, [wBattleResolveStep]
    jumptable
    dw RunBattleSetup_ItemMenu_DrawBagPage
    dw RunBattleSetup_ItemMenu_DrawList
    dw RunBattleSetup_ItemMenu_ChooseItem
    dw RunBattleSetup_ItemMenu_BackToMainMenu
    dw RunBattleSetup_ItemMenu_DrawSideWindow
    dw RunBattleSetup_ItemMenu_ShowSideCursor
    dw RunBattleSetup_ItemMenu_ChooseSide
    dw RunBattleSetup_ItemMenu_AfterSide
    dw RunBattleSetup_ItemMenu_DrawAllyTargets
    dw RunBattleSetup_ItemMenu_ShowAllyCursor
    dw RunBattleSetup_ItemMenu_ChooseAlly
    dw RunBattleSetup_ItemMenu_AfterAllyTarget
    dw RunBattleSetup_ItemMenu_DrawFoeList
    dw RunBattleSetup_ItemMenu_ShowFoeCursor
    dw RunBattleSetup_ItemMenu_ChooseFoe
    dw RunBattleSetup_ItemMenu_AfterFoeTarget
    dw RunBattleSetup_ItemMenu_ClearForMessage
    dw RunBattleSetup_ItemMenu_DrawMessageWindow
    dw RunBattleSetup_ItemMenu_ShowMessage
    dw RunBattleSetup_ItemMenu_BackToList

; ITEM menu, step 0: draws the bag page (four item names) and the selected item's description
; (category 6), with the cursor; next step. (C1, E-0357)
RunBattleSetup_ItemMenu_DrawBagPage::
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call CopyScreenBufferRect20x11ToBGMapRow7
    ld hl, wCommandCursor
    res 7, [hl]
    ld de, RunBattleSetup_PlanMenu_ShowTacticCursor_Data
    call ShowInventoryPageItemNames
    call RunBattleSetup_ItemMenu_RedrawItemList
    call RunBattleSetup_ItemMenu_DrawBagPage_BuildBox
    ld a, $06
    ld [wStringCategory], a
    ld hl, wInventory
    ld a, [wCommandCursor]
    and $0f
    add a
    add a
    ld c, a
    ld a, [wMenuOption]
    and $03
    add c
    add_a_to_hl
    ld a, [hl]
    ld [wStringIndex], a
    ld hl, vTiles1
    ld de, $0603
    call ShowStringBank08AtTilesHL_Bank31
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; ITEM menu, step 1: draws the list; on the first pass puts the cursor ($BB) on the item and the
; page indicator; next step. (C1, E-0357)
RunBattleSetup_ItemMenu_DrawList::
    call CopyScreenBufferRect20x9ToBGMapRow9
    ld a, [wBattleArg0]
    or a
    ret z
    xor a
    ld [wBattleArg0], a
    ld hl, RunBattleSetup_PlanMenu_ShowTacticCursor_Data
    ld a, [wMenuOption]
    and $03
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $bb
    call WriteVRAMByte
    call DrawInventoryPageIndicator
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $03
    ld [wListLastPageSize], a
    ret

; ITEM menu, step 2, choosing an item: A loads it: record byte 4 bit 0 gives 'This item can't be
; used in battle!' ($1E); by record byte 6: 0 choose an ally (step 8), 1 the user's whole side ($10)
; at once, 2 choose a foe (step $0C), 3 and others the other side ($20) at once, 4 and 5 choose the
; side first (step 4), 6 at once with no target; B clears the item and goes back (step 3). (C1,
; E-0357)
RunBattleSetup_ItemMenu_ChooseItem::
    ld de, RunBattleSetup_PlanMenu_ShowTacticCursor_Data
    ld hl, wMenuOption
    call MoveBattleCommandCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jp z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $00
    ld [wBattleArg1], a
    call LoadSelectedInventoryItemRecord
    ld a, [wItemId]
    ld [wBattleItemId], a
    ld a, [wItemRecord + $4]
    bit 0, a
    jr nz, .call_fill_screen_tile_buffer_row11_col4_with
    ld a, [wItemRecord + $6]
    or a
    jr z, .call_fill_screen_tile_buffer_row11_col4_with2
    cp $01
    jr z, .set_battle_item_target_to_10
    cp $02
    jr z, .call_copy_screen_buffer_rect20x9_to_bg_map
    cp $03
    jr z, .set_battle_item_target_to_20
    cp $04
    jr z, .set_battle_resolve_step_to_04
    cp $05
    jr z, .set_battle_resolve_step_to_04
    cp $06
    jr z, .set_battle_sub_phase_to_03
    jp .set_battle_item_target_to_20

.call_fill_screen_tile_buffer_row11_col4_with:
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $10
    ld [wBattleResolveStep], a
    ld a, $1e
    ld [wStringIndex], a
    jr .return

.call_fill_screen_tile_buffer_row11_col4_with2:
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call CopyScreenBufferRect20x9ToBGMapRow9
    ld a, $08
    ld [wBattleResolveStep], a
    jr .return

.set_battle_item_target_to_10:
    ld a, $10
    ld [wBattleItemTarget], a
    ld a, $03
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    jr .return

.call_copy_screen_buffer_rect20x9_to_bg_map:
    call CopyScreenBufferRect20x9ToBGMapRow9
    ld a, $0c
    ld [wBattleResolveStep], a
    jr .return

.set_battle_item_target_to_20:
    ld a, $20
    ld [wBattleItemTarget], a
    ld a, $03
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    jr .return

.set_battle_resolve_step_to_04:
    ld a, $04
    ld [wBattleResolveStep], a
    jr .return

.set_battle_sub_phase_to_03:
    ld a, $03
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a

.check_bit1:
    bit 1, a
    jr z, .check_bit2
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $ff
    ld [wBattleItemTarget], a
    ld [wBattleItemId], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.check_bit2:
    bit 2, a
    jr z, .call_run_battle_setup_item_menu_redraw_item
    farcall SortInventory
    ld de, RunBattleSetup_PlanMenu_ShowTacticCursor_Data
    ld hl, wCommandCursor
    set 7, [hl]

.call_run_battle_setup_item_menu_redraw_item:
    call RunBattleSetup_ItemMenu_RedrawItemList
    call DrawInventoryPageIndicator
    jr .return

.return:
    ret

; ITEM menu, step 3: redraws and returns to the main menu. (C1, E-0357)
RunBattleSetup_ItemMenu_BackToMainMenu::
    call CopyScreenBufferRect20x9ToBGMapRow9
    xor a
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleSubPhase], a
    ret

; ITEM menu, step 4: draws the side window ('TOWHAlyEnem', string 3 of category 2); next step. (C1,
; E-0357)
RunBattleSetup_ItemMenu_DrawSideWindow::
    ld a, [wSubMenuCursor]
    and $01
    ld [wSubMenuCursor], a
    ld a, [wBattleArg1]
    or a
    call z, CopyScreenBufferRect20x9ToBGMapRow9
    xor a
    ld [wBattleArg1], a
    ld hl, vTiles1 + $6d0
    ld de, $0801
    ld a, $02
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    call RunBattleSetup_ItemMenu_DrawSideWindow_BuildBox
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; ITEM menu, step 5: puts the cursor ($BB) on the side choice; next step. (C1, E-0357)
RunBattleSetup_ItemMenu_ShowSideCursor::
    call CopyScreenBufferRect8x7ToBGMapRow11
    ld hl, RunBattleSetup_MainMenu_DrawCursor_Data
    ld a, [wSubMenuCursor]
    and $03
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $bb
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; ITEM menu, step 6, choosing a side: items with record byte 6 bit 0 set target that whole side ($10
; allies, $20 foes); a meat (ITEM_BEEFJERKY to ITEM_METEORB) thrown at the foes goes to the first
; present foe; others choose a target (step 8 or $0C); B goes back. (C1, E-0357)
RunBattleSetup_ItemMenu_ChooseSide::
    ld de, RunBattleSetup_ItemMenu_ChooseSide_Data
    ld hl, wSubMenuCursor
    call ToggleEntryBitsByJoypadAndBlink
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, $69
    call QueueSoundEffect
    call LoadSelectedInventoryItemRecord
    ld a, [wItemRecord + $6]
    and $01
    jr nz, .check_sub_menu_cursor
    ld a, [wItemId]
    cp ITEM_BEEFJERKY
    jr c, .set_battle_arg0_to_01
    cp ITEM_BEASTTAIL
    jr nc, .set_battle_arg0_to_01
    ld a, [wSubMenuCursor]
    and $01
    jr z, .set_battle_arg0_to_01
    ld b, $04
    ld a, [wBattleSlotOut + $4]
    or a
    jr z, .set_battle_item_target
    ld b, $05
    ld a, [wBattleSlotOut + $5]
    or a
    jr z, .set_battle_item_target
    ld b, $06
    ld a, [wBattleSlotOut + $6]
    or a
    jr nz, .return

.set_battle_item_target:
    ld a, b
    ld [wBattleItemTarget], a
    jr .set_battle_sub_phase_to_03

.check_sub_menu_cursor:
    ld a, [wSubMenuCursor]
    and $01
    inc a
    swap a
    ld [wBattleItemTarget], a

.set_battle_sub_phase_to_03:
    ld a, $03
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    jr .return

.set_battle_arg0_to_01:
    ld a, $01
    ld [wBattleArg0], a
    jr .call_fill_screen_tile_buffer_row11_col4_with

.check_bit1:
    bit 1, a
    jr z, .return
    xor a
    ld [wSubMenuCursor], a
    ld a, $00
    ld [wBattleArg0], a

.call_fill_screen_tile_buffer_row11_col4_with:
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld hl, wBattleResolveStep
    inc [hl]

.return:
    ret

; ITEM menu, step 7: redraws; goes to step 8 (allies) or $0C (foes) when a target must be chosen,
; otherwise back to step 0. (C1, E-0357)
RunBattleSetup_ItemMenu_AfterSide::
    call CopyScreenBufferRect8x7ToBGMapRow11
    ld a, [wBattleArg0]
    or a
    jr z, .set_battle_resolve_step
    ld a, [wSubMenuCursor]
    and $01
    add a
    add a
    add $08

.set_battle_resolve_step:
    ld [wBattleResolveStep], a
    ret

; ITEM menu, step 8: draws the ally target list; next step. (C1, E-0357)
RunBattleSetup_ItemMenu_DrawAllyTargets::
    ld hl, vTiles1 + $6d0
    ld de, $0801
    ld a, $02
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a
    call ShowStringBank09AtTilesHL_Bank31
    call RunBattleSetup_ItemMenu_AllyListForItem
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; ITEM menu, step 9: puts the cursor on the first present ally (fallen ones count for
; ITEM_WORLDLEAF); next step. (C1, E-0357)
RunBattleSetup_ItemMenu_ShowAllyCursor::
    call RunBattleSetup_CopyLeftBoxToBGMap
    ld a, [wItemId]
    cp ITEM_WORLDLEAF
    jr z, .set_name_slot
    xor a

.set_name_slot:
    ld [wNameSlot], a
    ld a, [wLinkRole]
    sla a
    and $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld e, $01
    ld a, $00
    call MoveTargetCursor
    ld hl, RunBattleSetup_PlanMenu_ShowActionCursor_Data
    and $03
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $bb
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; ITEM menu, step 10, choosing an ally: B goes back (step 11, then 0 or the side window); A makes
; the ally the item's target (wBattleItemTarget = its slot) and goes on to the fight. (C1, E-0357)
RunBattleSetup_ItemMenu_ChooseAlly::
    ld a, [wLinkRole]
    sla a
    and $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld de, RunBattleSetup_PlanMenu_ShowActionCursor_Data
    call TargetCursor
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit0
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $00
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.check_bit0:
    bit 0, a
    jr z, .return
    ld a, $69
    call QueueSoundEffect
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, [wSubMenuCursor2]
    and $03
    ld [wBattleItemTarget], a
    ld a, $01
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.return:
    ret

; ITEM menu, step 11: redraws; with a target chosen goes to the fight (sub-phase 3); otherwise back
; to the side window (step 4) for items whose record byte 6 is 4 or 5, or to the item list (step 0).
; (C1, E-0357)
RunBattleSetup_ItemMenu_AfterAllyTarget::
    call RunBattleSetup_CopyLeftBoxToBGMap
    ld a, [wBattleArg0]
    or a
    jr nz, .set_battle_sub_phase_to_03
    call LoadSelectedInventoryItemRecord
    ld a, [wItemRecord + $6]
    cp $04
    jr z, .set_battle_resolve_step_to_04
    cp $05
    jr z, .set_battle_resolve_step_to_04
    xor a
    ld [wBattleResolveStep], a
    jr .clear_battle_arg0

.set_battle_sub_phase_to_03:
    ld a, $03
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    jr .clear_battle_arg0

.set_battle_resolve_step_to_04:
    ld a, $04
    ld [wBattleResolveStep], a

.clear_battle_arg0:
    xor a
    ld [wBattleArg0], a
    ret

; ITEM menu, step 12: draws the foe target list (fallen ones too for ITEM_WORLDLEAF); next step.
; (C1, E-0357)
RunBattleSetup_ItemMenu_DrawFoeList::
    call RunBattleSetup_DrawFoeList_BuildBox
    ld a, [wItemId]
    cp ITEM_WORLDLEAF
    jr z, .set_battle_arg1
    xor a

.set_battle_arg1:
    ld [wBattleArg1], a
    farcall ListFarSideSlots
    xor a
    ld [wBattleArg1], a
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; ITEM menu, step 13: puts the cursor on the first present foe; next step. (C1, E-0357)
RunBattleSetup_ItemMenu_ShowFoeCursor::
    call CopyScreenBufferRect14x7ToBGMapRow11
    ld a, [wItemId]
    cp ITEM_WORLDLEAF
    jr z, .set_name_slot
    xor a

.set_name_slot:
    ld [wNameSlot], a
    ld a, [wLinkRole]
    sla a
    and $04
    xor $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld e, $01
    ld a, $00
    call MoveTargetCursor
    ld hl, RunBattleSetup_PlanMenu_ShowActionCursor_Data
    and $03
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld hl, vBGMap0
    add hl, de
    ld a, $bb
    call WriteVRAMByte
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; ITEM menu, step 14, choosing a foe: B goes back; A makes the foe the target (slot 4-6, bit 2 set)
; and goes on. (C1, E-0357)
RunBattleSetup_ItemMenu_ChooseFoe::
    ld a, [wLinkRole]
    sla a
    and $04
    xor $04
    ld b, a
    ld hl, wSubMenuCursor2
    ld de, RunBattleSetup_PlanMenu_ShowActionCursor_Data
    call TargetCursor
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_bit0
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, $00
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.check_bit0:
    bit 0, a
    jr z, .return
    ld a, $69
    call QueueSoundEffect
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ld a, [wSubMenuCursor2]
    and $03
    set 2, a
    ld [wBattleItemTarget], a
    ld a, $01
    ld [wBattleArg0], a
    ld hl, wBattleResolveStep
    inc [hl]
    jr .return

.return:
    ret

; ITEM menu, step 15: redraws; as step 11. (C1, E-0357)
RunBattleSetup_ItemMenu_AfterFoeTarget::
    call RunBattleSetup_CopyLeftBoxToBGMap
    ld a, [wBattleArg0]
    or a
    jr nz, .set_battle_sub_phase_to_03
    call LoadSelectedInventoryItemRecord
    ld a, [wItemRecord + $6]
    cp $04
    jr z, .set_battle_resolve_step_to_04
    cp $05
    jr z, .set_battle_resolve_step_to_04
    xor a
    ld [wBattleResolveStep], a
    jr .clear_battle_arg0

.set_battle_sub_phase_to_03:
    ld a, $03
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    jr .clear_battle_arg0

.set_battle_resolve_step_to_04:
    ld a, $04
    ld [wBattleResolveStep], a

.clear_battle_arg0:
    xor a
    ld [wBattleArg0], a
    ret

; ITEM menu, step 16: redraws and clears the message window; next step. (C1, E-0357)
RunBattleSetup_ItemMenu_ClearForMessage::
    call CopyScreenBufferRect20x9ToBGMapRow9
    call ClearWindowAndCopyRectFar
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; ITEM menu, step 17: draws the message window; next step. (C1, E-0357)
RunBattleSetup_ItemMenu_DrawMessageWindow::
    call CopyMessageBoxToBGMapRow13
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; ITEM menu, step 18: shows message wStringIndex of category 0 and redraws the foes' area; next
; step. (C1, E-0357)
RunBattleSetup_ItemMenu_ShowMessage::
    xor a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    ret

; ITEM menu, step 19: after the text, back to the item list (step 0). (C1, E-0357)
RunBattleSetup_ItemMenu_BackToList::
    ld a, [wTextFlags]
    or a
    ret nz
    call CopyMessageBoxToBGMapRow13
    xor a
    ld [wBattleResolveStep], a
    ret

; Battle setup, sub-phase 3: marks every slot still at 0 with 1 (to act), resets the actor, redraws
; the foes' area and the window; next sub-phase. (C1, E-0357)
RunBattleSetup_MarkSlotsToAct::
    ld b, $08
    ld hl, wSlotMarks

.loop:
    ld a, [hl]
    or a
    jr nz, .next
    ld [hl], $01

.next:
    inc hl
    dec b
    jr nz, .loop
    xor a
    ld [wBattleActor], a
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call LayoutTileBlocksForBattleFoeCount
    call ClearWindowAndCopyRectFar
    call CopyScreenBufferRect20x11ToBGMapRow7
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wLinkSendByte], a
    ret

; Battle setup, sub-phase 4: in link battles, 'Selecting <partner>'s move...' ($22) with the
; partner's name; next sub-phase. (C1, E-0357)
RunBattleSetup_ShowSelectingHeroSMove::
    ld a, [wLinkMode]
    or a
    jr z, .done
    ld de, wBattleTextWork
    ld hl, wTextBuf0
    call CopyFiveGlyphsPlusMarks
    ld a, $00
    ld [wStringCategory], a
    ld a, $22
    ld [wStringIndex], a ; 'Selecting 0's move…'
    farcall BeginStringDisplay_Bank2F
    xor a
    ld [wLinkSendByte], a

.done:
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; Battle setup, sub-phase 5: in link battles sends 1; next sub-phase. (C2, E-0357; probed E-0380)
RunBattleSetup_SendLinkSync::
    ld a, [wLinkMode]
    or a
    jr z, .done
    ld a, $01
    ld [wLinkSendByte], a

.done:
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; Battle setup, sub-phase 6: in link battles, once the partner's 1 arrives, packs this side's three
; tactics, the random seed, the menu state (twice), the six action bytes, the three slot marks and
; the three side-control bytes (19 bytes) into wLinkRecvBuffer for the exchange; next sub-phase.
; (C2, E-0357; probed E-0380)
RunBattleSetup_SendLinkChoices::
    ld a, [wLinkMode]
    or a
    jp z, .done
    ld a, [wLinkMessage]
    cp $01
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld de, wSlotTactic
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip
    ld de, wSlotTactic + $4

.skip:
    ld hl, wLinkRecvBuffer
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    ld a, [wRandomLo]
    ld [hli], a
    ld a, [wRandomHi]
    ld [hli], a
    ld a, [wMenuState]
    ld [hli], a
    ld a, [wMenuState]
    ld [hli], a
    ld de, wBattleActionChoice
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip2
    ld de, wBattleActionChoice + $8

.skip2:
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    ld de, wSlotMarks
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip3
    ld de, wSlotMarks + $4

.skip3:
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    ld de, wSideControl
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip4
    ld de, wSideControl + $4

.skip4:
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    ld a, $13
    ld [wLinkBufferCountLo], a
    xor a
    ld [wLinkBufferCountHi], a
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

.done:
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; Battle setup, sub-phase 7: in link battles starts the exchange (sends $FF, ready); next sub-phase.
; (C2, E-0357; probed E-0380)
RunBattleSetup_StartLinkExchange::
    ld hl, wBattleSubPhase
    inc [hl]
    ld a, [wLinkMode]
    and a
    jr z, .return
    ld a, $ff
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkReady], a

.return:
    ret

; Battle setup, sub-phase 8: in link battles, once wLinkMessage is $F0 (the exchange is over),
; clears wLinkSendByte and wLinkReady and copies the 19-byte block received at wLinkPartnerName into
; the slots of the other side: three tactics, two seed bytes (skipped), two menu-state bytes (to
; wSlotCommands and wPartnerCommand), six action bytes, three slot marks and three side-control
; bytes, to slots 4-6 when wLinkRole bit 1 is clear and to slots 0-2 when it is set. Then the side
; with wLinkRole bit 1 clear copies wRandomLo/Hi to wRandomSeed2Lo/Hi (the received seed bytes are
; the same two bytes) and writes wMenuState over wLinkPartnerCommandA and wSlotCommands, while the
; other side loads wRandomLo/Hi from wRandomSeed2Lo/Hi and writes wMenuState over
; wLinkPartnerCommandB and wPartnerCommand. Last, the tactics of the partner slots other than
; Command (3) are copied to wSlotLastTactic; outside link battles it only goes on to the next
; sub-phase. (C2, E-0380)
RunBattleSetup_UnpackPartnerChoices::
    ld a, [wLinkMode]
    or a
    jp z, .done
    ld a, [wLinkMessage]
    cp $f0
    ret nz
    xor a
    ld [wLinkSendByte], a
    xor a
    ld [wLinkReady], a
    ld de, wSlotTactic + $4
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip
    ld de, wSlotTactic

.skip:
    ld hl, wLinkPartnerName
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc hl
    inc hl
    ld a, [hli]
    ld [wSlotCommands], a
    ld a, [hli]
    ld [wPartnerCommand], a
    ld de, wBattleActionChoice + $8
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip2
    ld de, wBattleActionChoice

.skip2:
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
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    ld de, wSlotMarks + $4
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip3
    ld de, wSlotMarks

.skip3:
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    ld de, wSideControl + $4
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip4
    ld de, wSideControl

.skip4:
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .read_random_seed2_lo
    ld a, [wRandomLo]
    ld [wRandomSeed2Lo], a
    ld a, [wRandomHi]
    ld [wRandomSeed2Hi], a
    ld a, [wMenuState]
    ld [wLinkPartnerCommandA], a
    ld a, [wMenuState]
    ld [wSlotCommands], a
    ld hl, wSlotTactic + $4
    ld de, wSlotLastTactic + $4
    jr .skip5

.read_random_seed2_lo:
    ld a, [wRandomSeed2Lo]
    ld [wRandomLo], a
    ld a, [wRandomSeed2Hi]
    ld [wRandomHi], a
    ld a, [wMenuState]
    ld [wLinkPartnerCommandB], a
    ld a, [wMenuState]
    ld [wPartnerCommand], a
    ld hl, wSlotTactic
    ld de, wSlotLastTactic

.skip5:
    ld b, $03

.loop:
    ld a, [hl]
    cp $03
    jr z, .next
    ld [de], a

.next:
    inc hl
    inc de
    dec b
    jr nz, .loop

.done:
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; Battle setup, sub-phase 9: in link battles compares the seed this side packed in sub-phase 6
; (wBattleSetupFlagsLo/Hi, the buffer bytes wLinkRecvBuffer + 3 and + 4) with wRandomSeed2Lo/Hi,
; which RunBattleSetup_UnpackPartnerChoices set (the own wRandomLo/Hi on the side with wLinkRole bit
; 1 clear, the received seed bytes on the other). wLinkSendByte and wCounterPtr0Lo become $22 when
; both bytes agree and $33 when not (the compares with wRandomLo/Hi before them are overwritten);
; outside link battles it only goes on. Next sub-phase. (C2, E-0380)
RunBattleSetup_CompareSeeds::
    ld a, [wLinkMode]
    and a
    jr nz, .skip
    jr .done

.skip:
    ld hl, wBattleSetupFlagsLo
    ld a, [hli]
    ld b, a
    ld a, [wRandomLo]
    cp b
    ld a, [wRandomSeed2Lo]
    cp b
    jr nz, .set_link_send_byte_to_33
    ld a, [hl]
    ld b, a
    ld a, [wRandomHi]
    cp b
    ld a, [wRandomSeed2Hi]
    cp b
    jr nz, .set_link_send_byte_to_33
    ld a, $22
    ld [wLinkSendByte], a
    ld [wCounterPtr0Lo], a
    jr .done

.set_link_send_byte_to_33:
    ld a, $33
    ld [wLinkSendByte], a
    ld [wCounterPtr0Lo], a

.done:
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; Battle setup, sub-phase 10: in link battles waits for the partner's $22 or $33 and keeps it in
; wCounterPtr0Hi; next sub-phase. (C2, E-0357; probed E-0380)
RunBattleSetup_WaitPartnerSeed::
    ld a, [wLinkMode]
    and a
    jr z, .done
    ld a, [wLinkMessage]
    cp $22
    jr z, .set_counter_ptr0_hi
    cp $33
    jr z, .set_counter_ptr0_hi
    ret

.set_counter_ptr0_hi:
    ld [wCounterPtr0Hi], a
    xor a
    ld [wLinkSendByte], a

.done:
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; Battle setup, sub-phase 11: in link battles, unless both sides reported matching seeds ($22 in
; wCounterPtr0Lo and wCounterPtr0Hi), goes back to the exchange (sub-phase 5); otherwise next
; sub-phase. (C2, E-0357; probed E-0380)
RunBattleSetup_RetryOnSeedMismatch::
    ld a, [wLinkMode]
    and a
    jr z, .done
    ld a, [wCounterPtr0Lo]
    cp $22
    jr nz, .set_battle_sub_phase_to_05
    ld a, [wCounterPtr0Hi]
    cp $22
    jr nz, .set_battle_sub_phase_to_05
    jr .done

.set_battle_sub_phase_to_05:
    ld a, $05
    ld [wBattleSubPhase], a
    ret

.done:
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; Battle setup, sub-phase 12: clears the window and goes to the next battle step. (C1, E-0357)
RunBattleSetup_ClearWindow::
    call FillTilesFromRequest
    ld hl, wBattleStep
    inc [hl]
    xor a
    ld [wBattleSubPhase], a
    ret

; HL = a cursor entry byte (bits 0-1 = the choice, bit 6 = the cursor tile is blanked), DE = a table
; of words, the offsets from vBGMap0 of each choice tile. Up or Down (wJoypadPressedRepeat $40 or
; $80) toggles bit 0 of the entry and Left or Right ($20 or $10) toggles bit 1: the old tile is
; blanked ($C3), the new cursor tile ($BB) drawn and sound $69 queued. With no key it flips the
; cursor tile between blank and shown through bit 6 whenever the low nibble of wFrameCounterLo is 0,
; and every path except the early return (no key, nibble not 0) clears that nibble, which restarts
; the 16-frame blink. (C1, E-0380)
; up/down toggles bit 0 and left/right bit 1 of [HL] (sound $69); otherwise blinks the entry every
; 16 frames through bit 6 (E-0125)
ToggleEntryBitsByJoypadAndBlink::
    ld a, [wJoypadPressedRepeat]
    and $c0
    jr z, .check_joypad_pressed_repeat
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [hl]
    xor $01
    ld [hl], a
    call ClearBit6AndCursorEntryTile_Bank31
    ld a, $69
    call QueueSoundEffect
    jr .check_frame_counter_lo2

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and $30
    jr z, .check_frame_counter_lo
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [hl]
    xor $02
    ld [hl], a
    call ClearBit6AndCursorEntryTile_Bank31
    ld a, $69
    call QueueSoundEffect
    jr .check_frame_counter_lo2

.check_frame_counter_lo:
    ld a, [wFrameCounterLo]
    and $0f
    jr nz, .return
    bit 6, [hl]
    jr z, .call_set_bit6_and_blank_entry_tile_bank31
    call ClearBit6AndCursorEntryTile_Bank31
    jr .check_frame_counter_lo2

.call_set_bit6_and_blank_entry_tile_bank31:
    call SetBit6AndBlankEntryTile_Bank31

.check_frame_counter_lo2:
    ld a, [wFrameCounterLo]
    and $f0
    ld [wFrameCounterLo], a

.return:
    ret

; The cursor of a three-entry list ([HL], positions at DE): Up and Down move it with wrap among 0-2
; (sound $69); otherwise it blinks every 16 frames. (C1, E-0357)
ThreeEntryListCursor::
    ld a, [wJoypadPressedRepeat]
    and $40
    jr z, .check_joypad_pressed_repeat
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [hl]
    and $03
    dec a
    cp $ff
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank31
    ld a, $02
    jr .call_clear_bit6_and_cursor_entry_tile_bank31

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and $80
    jr z, .check_frame_counter_lo
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [hl]
    and $03
    inc a
    cp $03
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank31
    xor a

.call_clear_bit6_and_cursor_entry_tile_bank31:
    ld [hl], a
    call ClearBit6AndCursorEntryTile_Bank31
    ld a, $69
    call QueueSoundEffect
    jr .check_frame_counter_lo2

.check_frame_counter_lo:
    ld a, [wFrameCounterLo]
    and $0f
    jr nz, .return
    bit 6, [hl]
    jr z, .call_set_bit6_and_blank_entry_tile_bank31
    call ClearBit6AndCursorEntryTile_Bank31
    jr .check_frame_counter_lo2

.call_set_bit6_and_blank_entry_tile_bank31:
    call SetBit6AndBlankEntryTile_Bank31

.check_frame_counter_lo2:
    ld a, [wFrameCounterLo]
    and $f0
    ld [wFrameCounterLo], a

.return:
    ret

; HL = a cursor entry byte (low nibble = the row, bit 6 = the cursor tile is blanked, bit 7 = redraw
; wanted), DE = a table of BG map offsets as for ToggleEntryBitsByJoypadAndBlink. Up and Down
; (wJoypadPressedRepeat $40 and $80) move the row with wrap: the last row is wCommandCursorMax on
; the last page (wCommandCursor = wCommandPageCount) and wListLastPageSize on the other pages, and
; with wCommandCursorMax 0 on the last page the cursor does not move. When wCommandPageCount is not
; 0, Left and Right ($20 and $10) change the page wCommandCursor with wrap and bit 7 set; arriving
; on the last page cuts the row down to wCommandCursorMax. Every move blanks the old tile, draws the
; cursor tile ($BB), queues sound $69 and sets bit 7 of the entry (Up and Down); with no key the
; cursor blinks every 16 frames, and the low nibble of wFrameCounterLo is cleared at the end. (C1,
; E-0380)
; up/down/left/right move the battle command cursor entry wCommandCursor within wListLastPageSize,
; wCommandCursorMax, wCommandPageCount, blinking it, with sound $69 (E-0131)
MoveBattleCommandCursor::
    ld a, [wJoypadPressedRepeat]
    and $40
    jr z, .check_joypad_pressed_repeat
    ld a, [wCommandCursor]
    ld b, a
    ld a, [wCommandPageCount]
    cp b
    jr nz, .call_set_bit6_and_blank_entry_tile_bank31
    ld a, [wCommandCursorMax]
    or a
    jp z, .check_frame_counter_lo3
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [hl]
    and $0f
    dec a
    cp $ff
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank31
    ld a, [wCommandCursorMax]
    jr .call_clear_bit6_and_cursor_entry_tile_bank31

.call_set_bit6_and_blank_entry_tile_bank31:
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [hl]
    and $0f
    dec a
    cp $ff
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank31
    ld a, [wListLastPageSize]

.call_clear_bit6_and_cursor_entry_tile_bank31:
    ld [hl], a
    call ClearBit6AndCursorEntryTile_Bank31
    set 7, [hl]
    ld a, $69
    call QueueSoundEffect
    jp .check_frame_counter_lo3

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and $80
    jr z, .check_command_page_count
    ld a, [wCommandCursor]
    ld b, a
    ld a, [wCommandPageCount]
    cp b
    jr nz, .call_set_bit6_and_blank_entry_tile_bank312
    ld a, [wCommandCursorMax]
    or a
    jp z, .check_frame_counter_lo3
    ld b, a
    call SetBit6AndBlankEntryTile_Bank31
    inc b
    ld a, [hl]
    and $0f
    inc a
    cp b
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank312
    ld a, $00
    jr .call_clear_bit6_and_cursor_entry_tile_bank312

.call_set_bit6_and_blank_entry_tile_bank312:
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [wListLastPageSize]
    inc a
    ld b, a
    ld a, [hl]
    and $0f
    inc a
    cp b
    jr nz, .call_clear_bit6_and_cursor_entry_tile_bank312
    xor a

.call_clear_bit6_and_cursor_entry_tile_bank312:
    ld [hl], a
    call ClearBit6AndCursorEntryTile_Bank31
    set 7, [hl]
    ld a, $69
    call QueueSoundEffect
    jr .check_frame_counter_lo3

.check_command_page_count:
    ld a, [wCommandPageCount]
    or a
    jr z, .check_frame_counter_lo
    ld b, a
    ld a, [wJoypadPressedRepeat]
    and $20
    jr z, .check_joypad_pressed_repeat2
    ld a, [wCommandCursor]
    or a
    jr nz, .set_command_cursor
    ld a, b
    jr .set_command_cursor2

.set_command_cursor:
    dec a

.set_command_cursor2:
    or $80
    ld [wCommandCursor], a
    ld a, $69
    call QueueSoundEffect
    jr .call_set_bit6_and_blank_entry_tile_bank314

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    and $10
    jr z, .check_frame_counter_lo
    ld a, [wCommandCursor]
    cp b
    jr nz, .set_command_cursor3
    xor a
    jr .set_command_cursor4

.set_command_cursor3:
    inc a

.set_command_cursor4:
    or $80
    ld [wCommandCursor], a
    ld a, $69
    call QueueSoundEffect
    jr .call_set_bit6_and_blank_entry_tile_bank314

.check_frame_counter_lo:
    ld a, [wFrameCounterLo]
    and $0f
    jr nz, .return
    bit 6, [hl]
    jr z, .call_set_bit6_and_blank_entry_tile_bank313
    call ClearBit6AndCursorEntryTile_Bank31
    jr .check_frame_counter_lo3

.call_set_bit6_and_blank_entry_tile_bank313:
    call SetBit6AndBlankEntryTile_Bank31
    jr .check_frame_counter_lo3

.call_set_bit6_and_blank_entry_tile_bank314:
    call SetBit6AndBlankEntryTile_Bank31
    ld a, [wCommandPageCount]
    ld b, a
    ld a, [wCommandCursor]
    res 7, a
    cp b
    jr nz, .check_frame_counter_lo3
    ld a, [wCommandCursorMax]
    or a
    jr nz, .skip
    xor a
    jr .check_frame_counter_lo2

.skip:
    ld b, a

.skip2:
    ld a, [hl]
    and $0f
    cp b
    jr z, .check_frame_counter_lo2
    jr c, .check_frame_counter_lo3
    dec [hl]
    jr .skip2

.check_frame_counter_lo2:
    set 7, a
    ld [hl], a

.check_frame_counter_lo3:
    ld a, [wFrameCounterLo]
    and $f0
    ld [wFrameCounterLo], a

.return:
    ret

; HL = a cursor entry byte (bits 0-5 = the entry number), DE = a table of words, the offsets from
; vBGMap0 of each entry tile: sets bit 6 of [HL] (the cursor is blanked) and writes the blank tile
; $C3 at vBGMap0 + the table word of that entry (WriteVRAMByte). HL and DE are kept, A is clobbered.
; (C1, E-0380)
; HL = entry byte, DE = table of BG map offsets: sets bit 6 of [HL] and writes tile $C3 at $9800 +
; table[[HL] & $3F] (WriteVRAMByte); HL kept (E-0074) (the same 31 bytes appear in 2 banks)
SetBit6AndBlankEntryTile_Bank31::
    set 6, [hl]
    ld a, [hl]
    and $3f
    push hl
    add a
    add e
    ld l, a
    ld a, d
    adc $00
    ld h, a
    deref_hl
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $98
    ld h, a
    ld a, $c3
    call WriteVRAMByte
    pop hl
    ret

; HL = a cursor entry byte (bits 0-5 = the entry number), DE = a table of words, the offsets from
; vBGMap0 of each entry tile: clears bit 6 of [HL] (the cursor is shown) and writes the cursor tile
; $BB at vBGMap0 + the table word of that entry (WriteVRAMByte). HL and DE are kept, A is clobbered.
; (C1, E-0380)
; HL = entry byte, DE = table of BG map offsets: clears bit 6 of [HL] and writes tile $BB at $9800 +
; table[[HL] & $3F] (WriteVRAMByte); HL kept (E-0074) (the same 31 bytes appear in 2 banks)
ClearBit6AndCursorEntryTile_Bank31::
    res 6, [hl]
    ld a, [hl]
    and $3f
    push hl
    add a
    add e
    ld l, a
    ld a, d
    adc $00
    ld h, a
    deref_hl
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $98
    ld h, a
    ld a, $bb
    call WriteVRAMByte
    pop hl
    ret

; A = 0-2, HL = the destination: clears wMenuSubState, then writes five consecutive tile numbers to
; HL..HL+4, starting at $D0, $D5 or $DA by A (the three bytes of WriteFiveTilesFromTable_Data).
; Returns HL = HL + 5. The PLAN menu calls it with A = wCommandMonster and 3 to put the name tiles
; of the monster being commanded into the screen buffer. (C2, E-0380)
; clears wMenuSubState and writes five consecutive tile numbers starting at
; WriteFiveTilesFromTable_Data[A] to HL (E-0122) (E-0344: the address in its name dropped or read as
; the label there; was WriteFiveTilesFromTable)
WriteFiveTilesFromTable::
    push hl
    ld hl, WriteFiveTilesFromTable_Data
    add_a_to_hl
    xor a
    ld [wMenuSubState], a
    ld a, [hl]
    pop hl
    ld b, $05

.loop:
    ld [hli], a
    inc a
    dec b
    jr nz, .loop
    ret

; data read by WriteFiveTilesFromTable (3 bytes) (E-0347)
WriteFiveTilesFromTable_Data::
    db $d0, $d5, $da

; Counts the command monster's skills (up to eight, stopping at $FF or 0) into C and those usable in
; battle (not $A2-$A9) into D; one page, or two for more than four; the last row of the page; cursor
; 0. (C2, E-0357; probed E-0380)
CountUsableSkills::
    ld a, [wCommandMonster]
    ld hl, wBattleSkills
    swap a
    and $f0
    add_a_to_hl
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    ld bc, $0800
    ld d, $00

.loop:
    ld a, [hli]
    cp $ff
    jr z, .skip
    or a
    jr z, .skip
    cp $a2
    jr c, .next
    cp $aa
    jr c, .next2

.next:
    inc d

.next2:
    inc c
    inc hl
    dec b
    jr nz, .loop

.skip:
    ld a, c
    cp $05
    ld a, $00
    jr c, .set_command_page_count
    inc a

.set_command_page_count:
    ld [wCommandPageCount], a
    ld a, c
    or a
    jr z, .set_command_cursor_max
    and $03
    dec a
    and $03

.set_command_cursor_max:
    ld [wCommandCursorMax], a
    xor a
    ld [wCommandCursor], a
    ret

; Shows the four skill names of page wCommandCursor of the monster wCommandMonster, with string
; category 4, in the four name tile blocks (ShowStringAAtTiles16D0 and the three after it). It first
; stores the address of the monster skill list, wBattleSkills + 16 * wCommandMonster, in
; wBattleArg2/wBattleArg3; the page starts 8 bytes (four skills at every second byte) per page after
; it. A skill $FF is shown as string 0, an empty string. (C1, E-0380)
; shows the four skill names (category 4) of page wCommandCursor of monster wCommandMonster's skills
; (wBattleSkills + 16 * wCommandMonster) in the four tile rows; $FF shows string 0 (E-0121)
ShowSkillPageNames::
    ld a, $04
    ld [wStringCategory], a
    ld a, [wCommandMonster]
    ld hl, wBattleSkills
    swap a
    and $f0
    add_a_to_hl
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    ld a, [wCommandCursor]
    add a
    add a
    add a
    add_a_to_hl
    ld a, [hli]
    inc hl
    cp $ff
    call z, ShowSkillPageNames_EmptyEntry
    call ShowStringAAtTiles16D0
    ld a, [hli]
    inc hl
    cp $ff
    call z, ShowSkillPageNames_EmptyEntry
    call ShowStringAAtTiles1760
    ld a, [hli]
    inc hl
    cp $ff
    call z, ShowSkillPageNames_EmptyEntry
    call ShowStringAAtTiles17F0
    ld a, [hl]
    cp $ff
    call z, ShowSkillPageNames_EmptyEntry
    call ShowStringAAtTiles2080
    ret

; A = 0 with Z set and carry clear, whatever it was. ShowSkillPageNames calls it when a skill place
; holds $FF, so the empty place is shown as string 0, an empty string. (C2, E-0380)
; A = 0 (xor a, so Z set and carry clear); a two-byte handler stub (E-0110) (E-0344: the address in
; its name dropped or read as the label there; was ShowSkillPageNames_EmptyEntry)
ShowSkillPageNames_EmptyEntry::
    xor a
    ret

; Skill list redraw: a page change redraws the cursor and the page's names; a new entry shows its
; description (category 9) and MP cost. (C1, E-0357)
RunBattleSetup_PlanMenu_RedrawSkillList::
    ld a, [wCommandCursor]
    bit 7, a
    jr z, .check_menu_cursor
    res 7, a
    ld [wCommandCursor], a
    ld hl, wMenuCursor
    call ClearBit6AndCursorEntryTile_Bank31
    call ShowSkillPageNames
    ld hl, wMenuCursor
    set 7, [hl]

.check_menu_cursor:
    ld a, [wMenuCursor]
    bit 7, a
    ret z
    res 7, a
    ld [wMenuCursor], a
    and $0f
    push af
    ld a, $09
    ld [wStringCategory], a
    ld a, [wBattleArg2]
    ld l, a
    ld a, [wBattleArg3]
    ld h, a
    ld a, [wCommandCursor]
    add a
    add a
    ld c, a
    pop af
    add c
    add a
    add_a_to_hl
    ld a, [hl]
    call RunBattleSetup_PlanMenu_ShowSkillDescAndMP
    ld de, wWindowTileBuffer + $88
    ld hl, vBGMap0 + $1f0
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    ld a, [de]
    call WriteVRAMByte
    ret

; Counts the bag's items (24 places, stopping at $FF or 0) into C and those usable in battle (below
; $0D, $19-$1F, $22-$27) into E; the page count and last row from C. (C2, E-0357; probed E-0380)
CountUsableItems::
    ld hl, wInventory
    ld bc, $1800
    ld e, $00

.loop:
    ld a, [hli]
    cp $ff
    jr z, .skip
    or a
    jr z, .skip
    inc c
    cp $0d
    jr c, .next
    cp $19
    jr c, .next2
    cp $20
    jr c, .next
    cp $22
    jr c, .next2
    cp $28
    jr nc, .next2

.next:
    inc e

.next2:
    dec b
    jr nz, .loop

.skip:
    ld a, c
    and $fc
    rrca
    rrca
    ld [wCommandPageCount], a
    ld a, c
    or a
    jr z, .set_command_cursor_max
    and $03
    call z, CountUsableItems_TrimPageCount
    dec a
    and $03

.set_command_cursor_max:
    ld [wCommandCursorMax], a
    xor a
    ld [wCommandCursor], a
    ret

; One page fewer when the items fill the last page exactly. (C2, E-0357; probed E-0380)
CountUsableItems_TrimPageCount::
    push af
    ld a, [wCommandPageCount]
    dec a
    ld [wCommandPageCount], a
    pop af
    ret

; Shows the four item names of bag page wCommandCursor (wInventory + 4 * page), with string category
; 5, in the four name tile blocks (ShowStringAAtTiles16D0 and the three after it). An empty place
; ($FF) is shown as string 0, an empty string. (C1, E-0380)
; shows the four item names of inventory page wCommandCursor (category 5) in the four tile rows of
; ShowStringAAtTiles16D0 ... 2080; an empty slot ($FF) shows string 0 (E-0120)
ShowInventoryPageItemNames::
    ld a, $05
    ld [wStringCategory], a
    ld hl, wInventory
    ld a, [wCommandCursor]
    add a
    add a
    add_a_to_hl
    ld a, [hli]
    cp $ff
    call z, ShowInventoryPageItemNames_EmptyEntry
    call ShowStringAAtTiles16D0
    ld a, [hli]
    cp $ff
    call z, ShowInventoryPageItemNames_EmptyEntry
    call ShowStringAAtTiles1760
    ld a, [hli]
    cp $ff
    call z, ShowInventoryPageItemNames_EmptyEntry
    call ShowStringAAtTiles17F0
    ld a, [hl]
    cp $ff
    call z, ShowInventoryPageItemNames_EmptyEntry
    call ShowStringAAtTiles2080
    ret

; A = 0 with Z set and carry clear, whatever it was. ShowInventoryPageItemNames calls it when a bag
; place holds $FF, so the empty place is shown as string 0, an empty string. (C2, E-0380)
; A = 0 (xor a, so Z set and carry clear); a two-byte handler stub (E-0110) (E-0344: the address in
; its name dropped or read as the label there; was ShowInventoryPageItemNames_EmptyEntry)
ShowInventoryPageItemNames_EmptyEntry::
    xor a
    ret

; Item list redraw: a page change redraws the cursor and the page's names; a new entry shows its
; description (category 6). (C1, E-0357)
RunBattleSetup_ItemMenu_RedrawItemList::
    ld a, [wCommandCursor]
    bit 7, a
    jr z, .check_menu_option
    res 7, a
    ld [wCommandCursor], a
    ld hl, wMenuOption
    call ClearBit6AndCursorEntryTile_Bank31
    call ShowInventoryPageItemNames
    ld hl, wMenuOption
    set 7, [hl]

.check_menu_option:
    ld a, [wMenuOption]
    bit 7, a
    ret z
    res 7, a
    ld [wMenuOption], a
    and $0f
    push af
    ld a, $06
    ld [wStringCategory], a
    ld hl, wInventory
    ld a, [wCommandCursor]
    add a
    add a
    ld c, a
    pop af
    add c
    add_a_to_hl
    ld a, [hl]
    ld [wStringIndex], a
    ld hl, vTiles1
    ld de, $0603
    call ShowStringBank08AtTilesHL_Bank31
    ret

; wItemId = wInventory[(wCommandCursor and $0F) * 4 + (wMenuOption and 3)], the item under the
; cursor of the bag list, then LoadItemRecord copies its 13-byte record to wItemRecord. Called by
; the ITEM menu steps that need the record of the chosen item. (C2, E-0380)
; wItemId = wInventory[(wCommandCursor & $0F) * 4 + (wMenuOption & 3)], then far-calls
; LoadItemRecord (E-0118)
LoadSelectedInventoryItemRecord::
    ld a, [wCommandCursor]
    and $0f
    add a
    add a
    ld hl, wInventory
    add_a_to_hl
    ld a, [wMenuOption]
    and $03
    add_a_to_hl
    ld a, [hl]
    ld [wItemId], a
    farcall LoadItemRecord
    ret

; A = a string index: stores it in wStringIndex and draws that string (the category is already in
; wStringCategory) as tiles at vTiles1 + $6D0, 9 tiles wide and 1 row (DE = $0901), through
; ShowStringBank08AtTilesHL_Bank31. HL is kept. This is the first of four name tile blocks, $90
; bytes apart, that hold the names of the four entries of a list page. (C1, E-0380)
; wStringIndex = A, then ShowStringBank08AtTilesHL_Bank31 at vTiles1 + $6D0 with size $0901; HL kept
; (E-0115)
ShowStringAAtTiles16D0::
    ld [wStringIndex], a
    push hl
    ld hl, vTiles1 + $6d0
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank31
    pop hl
    ret

; A = a string index: stores it in wStringIndex and draws that string (the category is already in
; wStringCategory) as tiles at vTiles1 + $760, 9 tiles wide and 1 row, through
; ShowStringBank08AtTilesHL_Bank31. HL is kept. Second of the four name tile blocks of a list page.
; (C1, E-0380)
; wStringIndex = A, then ShowStringBank08AtTilesHL_Bank31 at vTiles1 + $760 with size $0901; HL kept
; (E-0115)
ShowStringAAtTiles1760::
    ld [wStringIndex], a
    push hl
    ld hl, vTiles1 + $760
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank31
    pop hl
    ret

; A = a string index: stores it in wStringIndex and draws that string (the category is already in
; wStringCategory) as tiles at vTiles1 + $7F0, 9 tiles wide and 1 row, through
; ShowStringBank08AtTilesHL_Bank31. HL is kept. Third of the four name tile blocks of a list page.
; (C1, E-0380)
; wStringIndex = A, then ShowStringBank08AtTilesHL_Bank31 at vTiles1 + $7F0 with size $0901; HL kept
; (E-0115)
ShowStringAAtTiles17F0::
    ld [wStringIndex], a
    push hl
    ld hl, vTiles1 + $7f0
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank31
    pop hl
    ret

; A = a string index: stores it in wStringIndex and draws that string (the category is already in
; wStringCategory) as tiles at vTiles2 + $80, 9 tiles wide and 1 row, through
; ShowStringBank08AtTilesHL_Bank31. HL is not kept. Fourth and last of the name tile blocks of a
; list page. (C1, E-0380)
; wStringIndex = A, then ShowStringBank08AtTilesHL_Bank31 at vTiles2 + $80 with size $0901 (E-0115)
ShowStringAAtTiles2080::
    ld [wStringIndex], a
    ld hl, vTiles2 + $80
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank31
    ret

; Shows skill A's description (category 9) and its MP cost as three digits (a cost of $FF shows the
; monster's whole MP). (C1, E-0357)
RunBattleSetup_PlanMenu_ShowSkillDescAndMP::
    push af
    ld [wStringIndex], a
    ld hl, vTiles1
    ld de, $0603
    call ShowStringBank08AtTilesHL_Bank31
    pop af
    ld [wRecordBuffer], a
    xor a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ld a, [wRecordBufferData]
    cp $ff
    jr nz, .skip
    ld a, [wCommandMonster]
    ld hl, wBattleMP
    add a
    add_a_to_hl
    deref_hl
    jr .call_hl_to_decimal_digits

.skip:
    ld l, a
    ld h, $00
    jr .call_hl_to_decimal_digits

.call_hl_to_decimal_digits:
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $88
    call WriteDecimalDigitTiles
    ret

; Returns at once when wCommandPageCount is 0. Otherwise writes five tiles at vBGMap0 + $226: $C5,
; the digit tile $E0 + (wCommandCursor and 7) + 1, $BE, the digit tile $E0 + wCommandPageCount + 1,
; and $C6, the page marker of the skill list and the item list (page X of Y). (C1, E-0380)
; when wCommandPageCount is non-zero writes tiles $C5, $E0 + (wCommandCursor & 7) + 1, $BE, $E0 +
; wCommandPageCount + 1, $C6 at vBGMap0 + $226 (page X of Y) (E-0120)
DrawInventoryPageIndicator::
    ld a, [wCommandPageCount]
    or a
    ret z
    ld hl, vBGMap0 + $226
    ld a, $c5
    call WriteVRAMByteInc
    ld a, [wCommandCursor]
    and $07
    inc a
    add $e0
    call WriteVRAMByteInc
    ld a, $be
    call WriteVRAMByteInc
    ld a, [wCommandPageCount]
    inc a
    add $e0
    call WriteVRAMByteInc
    ld a, $c6
    call WriteVRAMByte
    ret

; data read by RunBattleSetup (8 bytes) (E-0347)
RunBattleSetup_MainMenu_DrawCursor_Data::
    db $c1, $01, $01, $02, $c8, $01, $08, $02

RunBattleSetup_PlanMenu_ShowTacticCursor_Data::
    db $41, $01, $81, $01, $c1, $01, $01, $02

RunBattleSetup_PlanMenu_ShowActionCursor_Data::
    db $81, $01, $c1, $01, $01, $02

RunBattleSetup_ItemMenu_ChooseSide_Data::
    db $c1, $01, $01, $02, $c1, $01, $01, $02

ForgetSkillMenu_Cursor_Data::
    db $29, $00, $69, $00, $a9, $00, $e9, $00

RunBattleSetup_MainMenu_YesNoCursor_Data2::
    db $2f, $01, $6f, $01, $2f, $01, $6f, $01

; A = a tactic (0-3): stores it in wSlotTactic at index wCommandMonster, and also in wSlotLastTactic
; at that index unless it is 3 (Command), so the last tactic other than Command is remembered. A is
; kept, and Z is set when it is 3. Called by the PLAN menu tactic step. (C2, E-0380)
; A = value: stores A in wSlotTactic[wCommandMonster], and also in wSlotLastTactic[wCommandMonster]
; unless A is 3 (E-0118)
SetSlotTacticAndSlotLastTacticForCommandMonster::
    push af
    ld a, [wCommandMonster]
    ld hl, wSlotTactic
    add_a_to_hl
    pop af
    ld [hl], a
    cp $03
    ret z
    push af
    ld a, [wCommandMonster]
    ld hl, wSlotLastTactic
    add_a_to_hl
    pop af
    ld [hl], a
    ret

; Loads the record of the skill under the cursor of the skill list: wRecordBuffer = the skill at
; wBattleSkills + 16 * wCommandMonster + 2 * (4 * (wCommandCursor and 1) + (wMenuCursor and 3)),
; wRecordBuffer + 1 = 0, then LoadSkillRecord copies its 17-byte record to wRecordBufferData. Its
; caller is RunBattleSetup_PlanMenu_ChooseSkill. (C2, E-0380)
; wRecordBuffer = the skill at wBattleSkills + 16 * wCommandMonster + 2 * (4 * (wCommandCursor & 1)
; + (wMenuCursor & 3)), wRecordBuffer + $1 = 0, then far-calls LoadSkillRecord (E-0120) (the same 48
; bytes appear in 2 banks)
LoadSelectedSkillRecord_Bank31::
    ld a, [wMenuCursor]
    and $03
    ld b, a
    ld a, [wCommandCursor]
    and $01
    add a
    add a
    add b
    add a
    ld hl, wBattleSkills
    add_a_to_hl
    ld a, [wCommandMonster]
    swap a
    add_a_to_hl
    ld a, [hl]
    ld [wRecordBuffer], a
    xor a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ret

; Counts the present slots (wBattleSlotOut 0) of the side opposite this Game Boy: slots 4-6 when
; wLinkRole bit 1 is clear, slots 0-2 when it is set. D = how many are present, E = the number of
; the last present slot (0 when none); clobbers A and BC. The PLAN menu uses it to take the only foe
; as the target without asking. (C2, E-0380)
; side base = ((wLinkRole << 1) & 4) ^ 4, the side opposite CountPresentSlotsOfLinkRoleSide_Bank31;
; D = how many of its three slots are present, E = the last present one (0 when none); clobbers A,
; BC (E-0067) (the same 28 bytes appear in 2 banks)
CountPresentFoesOfLinkRoleSide_Bank31::
    ld de, $0000
    ld b, $03
    ld a, [wLinkRole]
    sla a
    and $04
    xor $04
    ld c, a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    inc d
    ld e, c

.next:
    inc c
    dec b
    jr nz, .loop
    ret

; Counts the present slots (wBattleSlotOut 0) of this side: slots 0-2 when wLinkRole bit 1 is clear,
; slots 4-6 when it is set. D = how many are present; clobbers A and BC. The PLAN menu skill step
; uses it for a skill with target code $21: when only one slot of the side is present, the monster
; itself becomes the target without asking. (C2, E-0380)
; side base = (wLinkRole << 1) & 4: D = how many of its three slots are present; clobbers A, BC
; (E-0067) (the same 24 bytes appear in 2 banks)
CountPresentSlotsOfLinkRoleSide_Bank31::
    ld d, $00
    ld b, $03
    ld a, [wLinkRole]
    sla a
    and $04
    ld c, a

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    inc d

.next:
    inc c
    dec b
    jr nz, .loop
    ret

; The ally list may include fallen allies for SKILL_VIVIFY and SKILL_REVIVE
; (RunBattleSetup_AllyListWithFallen), otherwise only present ones
; (RunBattleSetup_AllyListPresentOnly). (C2, E-0357; probed E-0380)
RunBattleSetup_PlanMenu_AllyListForSkill::
    ld a, [wRecordBuffer]
    cp $1e
    jr z, RunBattleSetup_AllyListWithFallen
    cp $1f
    jr z, RunBattleSetup_AllyListWithFallen
    jr RunBattleSetup_AllyListPresentOnly

; The ally list may include fallen allies for ITEM_WORLDLEAF (RunBattleSetup_AllyListWithFallen),
; otherwise only present ones (RunBattleSetup_AllyListPresentOnly). (C2, E-0357; probed E-0380)
RunBattleSetup_ItemMenu_AllyListForItem::
    ld a, [wItemId]
    cp ITEM_WORLDLEAF
    jr nz, RunBattleSetup_AllyListPresentOnly

; Fills wSlotChoices for the three slots of the side at (wLinkRole << 1) & 4 (the side
; CountPresentSlotsOfLinkRoleSide_Bank31 counts): 0 (choosable) for every slot whose wBattleSlotOut
; byte is not $FF, fallen allies included, and $FF for an empty slot; then draws the list
; (RunBattleSetup_DrawAllyList). Reached from RunBattleSetup_PlanMenu_AllyListForSkill for
; SKILL_VIVIFY and SKILL_REVIVE (compared as $1E and $1F) and from
; RunBattleSetup_ItemMenu_AllyListForItem for ITEM_WORLDLEAF. (C2, E-0372; probed E-0380)
RunBattleSetup_AllyListWithFallen::
    ld a, [wLinkRole]
    sla a
    and $04
    ld de, wBattleSlotOut
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld b, $03
    ld hl, wSlotChoices

.loop:
    ld a, [de]
    cp $ff
    jr z, .skip2
    xor a

.skip2:
    ld [hli], a
    inc de
    dec b
    jr nz, .loop
    jr RunBattleSetup_DrawAllyList

; Copies the three wBattleSlotOut bytes of the side at (wLinkRole << 1) & 4 into wSlotChoices (0 for
; a present slot, nonzero for a fallen or empty one), so only present allies can be chosen; then
; draws the list (RunBattleSetup_DrawAllyList). Used for every skill and item other than
; SKILL_VIVIFY, SKILL_REVIVE and ITEM_WORLDLEAF. (C2, E-0372; probed E-0380)
RunBattleSetup_AllyListPresentOnly::
    ld a, [wLinkRole]
    sla a
    and $04
    ld de, wBattleSlotOut
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld b, $03
    ld hl, wSlotChoices

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop
    jr RunBattleSetup_DrawAllyList

; Builds the ally target window in the screen buffer (RunBattleSetup_DrawAllyList_BuildBox) and
; blanks with tile $C3 (FillFiveC3AtHL) the five-tile name of each of the three slots whose
; wSlotChoices byte is nonzero, starting at wWindowTileBuffer + $1A and $40 bytes (two 32-byte rows)
; apart. The shared end of RunBattleSetup_AllyListWithFallen and RunBattleSetup_AllyListPresentOnly.
; (C2, E-0372; probed E-0380)
RunBattleSetup_DrawAllyList::
    call RunBattleSetup_DrawAllyList_BuildBox
    ld hl, wWindowTileBuffer + $1a
    ld a, [wSlotChoices]
    or a
    call nz, FillFiveC3AtHL
    ld a, l
    add $40
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wSlotChoices + $1]
    or a
    call nz, FillFiveC3AtHL
    ld a, l
    add $40
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wSlotChoices + $2]
    or a
    call nz, FillFiveC3AtHL
    ret

; HL = an address: stores tile $C3 (the blank tile) in the five bytes from HL; HL is kept and A =
; $C3. RunBattleSetup_DrawAllyList uses it to blank the five name tiles of an ally slot that cannot
; be chosen. (C2, E-0380)
; stores tile $C3 in the five bytes from HL; HL kept (E-0118)
FillFiveC3AtHL::
    push hl
    ld a, $c3
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    pop hl
    ret

; Moves the target cursor byte at HL (low two bits = the slot 0-2) to a slot that can be chosen: B =
; the side base (0 or 4), E = the step (1 or $FF), A not 0 starts one step away from the current
; slot, A = 0 starts at the current slot (E = 1) or, when wNameSlot is non-zero, simply puts the
; cursor on slot 0. Slot 3 of the side is never taken; a present slot (wBattleSlotOut 0) is taken, a
; fallen one (1) only when wNameSlot is non-zero, an empty one ($FF) never; after four tries without
; a hit the cursor stays on the first candidate. HL and E are kept and A = the new cursor. (C2,
; E-0380)
MoveTargetCursor::
    or a
    jr nz, .skip2
    ld a, [wNameSlot]
    or a
    jr z, .skip
    ld c, $00
    jr .skip5

.skip:
    ld a, [hl]
    and $03
    dec a
    jr .skip3

.skip2:
    ld a, [hl]
    and $03

.skip3:
    add e
    and $03
    or b
    ld c, a
    ld d, $04

.loop:
    ld a, c
    and $03
    cp $03
    jr z, .skip4
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .skip5
    jr z, .skip4
    ld a, [wNameSlot]
    or a
    jr nz, .skip5

.skip4:
    ld a, c
    add e
    and $03
    or b
    ld c, a
    dec d
    jr nz, .loop

.skip5:
    ld a, c
    and $03
    ld [hl], a
    ret

; The target cursor: Up and Down step to the previous or next choosable slot; otherwise it blinks
; every 16 frames. (C1, E-0357)
TargetCursor::
    ld a, [wJoypadPressedRepeat]
    and $40
    jr z, .check_joypad_pressed_repeat
    call SetBit6AndBlankEntryTile_Bank31
    push de
    ld e, $ff
    ld a, $01
    call MoveTargetCursor
    pop de
    call ClearBit6AndCursorEntryTile_Bank31
    jr .check_frame_counter_lo2

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and $80
    jr z, .check_frame_counter_lo
    call SetBit6AndBlankEntryTile_Bank31
    push de
    ld e, $01
    ld a, $01
    call MoveTargetCursor
    pop de
    call ClearBit6AndCursorEntryTile_Bank31
    jr .check_frame_counter_lo2

.check_frame_counter_lo:
    ld a, [wFrameCounterLo]
    and $0f
    jr nz, .return
    bit 6, [hl]
    jr z, .call_set_bit6_and_blank_entry_tile_bank31
    call ClearBit6AndCursorEntryTile_Bank31
    jr .check_frame_counter_lo2

.call_set_bit6_and_blank_entry_tile_bank31:
    call SetBit6AndBlankEntryTile_Bank31

.check_frame_counter_lo2:
    ld a, [wFrameCounterLo]
    and $f0
    ld [wFrameCounterLo], a

.return:
    ret

; Far-calls RunDebugState_E0, the debug state of bank $E0, and returns. No call, jump or table entry
; in the source reaches it, so it looks unused. (C1, E-0380)
; far-calls RunDebugState_E0 (E-0122) (E-0344: the address in its name dropped or read as the label
; there; was UnreferencedDebugScreenCaller)
UnreferencedDebugScreenCaller::
    farcall RunDebugState_E0
    ret

; Sets the battle result (wBattleScene): in battle kinds below 8, 1 when none of the player's slots
; can act (present and not paralysed) or a foe is still present; with no foe left, 0 when one fell
; and 2 when none did. In link battles (kinds 8 and up), unless a result is already set: 4 when only
; this side can still act, 5 when only the other side can, $80 (a draw) otherwise. (C2, E-0357;
; probed E-0380)
BattleEnd_Result_SetResult::
    ld a, [wDataBankSave]
    ld [wDataBank], a
    xor a
    ld [wDataBankSave], a
    ld a, [wBattleKind]
    cp $08
    jr nc, .check_battle_scene
    ld bc, $0300
    ld e, $00
    call CountSlotsAbleToAct
    jr c, .skip2
    ld bc, $0304
    ld de, $0000
    call BattleEnd_Result_CountSlots
    jr nc, .skip2
    ld a, d
    or a
    jr z, .skip
    xor a
    jr .set_battle_scene

.skip:
    ld a, $02
    jr .set_battle_scene

.skip2:
    ld a, $01
    jr .set_battle_scene

.check_battle_scene:
    ld a, [wBattleScene]
    or a
    jr nz, .set_battle_scene
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .call_count_slots_able_to_act2
    ld bc, $0300
    ld e, $00
    call CountSlotsAbleToAct
    jr nc, .call_count_slots_able_to_act
    ld bc, $0304
    ld e, $00
    call CountSlotsAbleToAct
    jr c, .set_battle_scene_to_80
    jr .skip4

.call_count_slots_able_to_act:
    ld bc, $0304
    ld e, $00
    call CountSlotsAbleToAct
    jr c, .skip3
    jr .set_battle_scene_to_80

.call_count_slots_able_to_act2:
    ld bc, $0304
    ld e, $00
    call CountSlotsAbleToAct
    jr nc, .call_count_slots_able_to_act3
    ld bc, $0300
    ld e, $00
    call CountSlotsAbleToAct
    jr c, .set_battle_scene_to_80
    jr .skip4

.call_count_slots_able_to_act3:
    ld bc, $0300
    ld e, $00
    call CountSlotsAbleToAct
    jr c, .skip3
    jr .set_battle_scene_to_80

.skip3:
    ld a, $04
    jr .set_battle_scene

.skip4:
    ld a, $05
    jr .set_battle_scene

.set_battle_scene_to_80:
    ld a, $80

.set_battle_scene:
    ld [wBattleScene], a
    ret

; E = how many of B slots from C are present and not paralysed; carry when none. (C2, E-0357; probed
; E-0380)
CountSlotsAbleToAct::
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    or a
    jr nz, .next
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit BSTAT0_PARALYZED, [hl]
    jr nz, .next
    inc e

.next:
    inc c
    dec b
    jr nz, CountSlotsAbleToAct
    ld a, e
    cp $01
    ret

; B = how many slots, C = the first slot, D and E = running counts (the caller clears them): over
; those slots of wBattleSlotOut, E counts the slots that are 0 (present) and D those with any other
; value except $FF (fallen); an empty $FF slot counts in neither. Returns Z when exactly one is
; present and carry when none is. BattleEnd_Result_SetResult uses it on the foes (slots 4-6). (C2,
; E-0380)
; over B slots from C counts present (wBattleSlotOut 0) in E and out in D; Z when exactly one is
; present
BattleEnd_Result_CountSlots::
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    cp $ff
    jr z, .next2
    or a
    jr nz, .next
    inc e
    jr .next2

.next:
    inc d

.next2:
    inc c
    dec b
    jr nz, BattleEnd_Result_CountSlots
    ld a, e
    cp $01
    ret

; Battle end, step 3: outside link battles, for each party member stores its tactics into its record
; and settles the record's status, HP, MP, wBattleExtraStat and personality from the battle (SRAM
; enabled around it). (C2, E-0357; probed E-0380)
BattleEnd_Records_UpdatePartyRecords::
    ld a, [wLinkMode]
    or a
    jr nz, .return
    ld a, $0a
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00

.loop:
    push bc
    call BattleEnd_Records_StoreTactics
    ld a, c
    push bc
    ld c, MON_STATUS
    call SRAMRecordAddressMapped
    pop bc
    call RecordStatusAfterBattle
    call BattleEnd_Records_StoreHP
    call BattleEnd_Records_StoreMP
    call BattleEnd_Records_StoreExtraStat
    call BattleEnd_Records_StorePersonality
    pop bc
    inc c
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a

.return:
    ret

; C = slot (and record): stores wSlotTactic & 3 in bits 4-5 and wSlotLastTactic & 3 in bits 6-7 of
; the record's MON_SEX byte, keeping its low nibble (bit 0 is the sex); also sets wBattleResultByte
; = wMenuState & 3. BC kept; SRAM must be enabled. (C2, E-0372; probed E-0380)
BattleEnd_Records_StoreTactics::
    push bc
    ld a, c
    ld hl, wSlotTactic
    add_a_to_hl
    ld a, [hl]
    and $03
    ld b, a
    ld a, c
    ld hl, wSlotLastTactic
    add_a_to_hl
    ld a, [hl]
    rlca
    rlca
    and $0c
    or b
    swap a
    push af
    ld a, c
    ld c, MON_SEX
    call SRAMRecordAddressMapped
    ld a, [hl]
    and $0f
    pop bc
    or b
    ld [hl], a
    ld a, [wMenuState]
    and $03
    ld [wBattleResultByte], a
    pop bc
    ret

; The record's status after battle: cleared, then bit 7 when the slot fell; otherwise (not in battle
; kind 4) bit 0 for battle status bit 5 and bit 2 for battle status bits 0-1. (C2, E-0357; probed
; E-0380)
RecordStatusAfterBattle::
    ld [hl], $00
    ld a, c
    ld de, wBattleSlotOut
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    cp $01
    jr z, .done
    ld a, [wBattleKind]
    cp $04
    ret z
    ld a, c
    push hl
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    pop hl
    bit 5, a
    call nz, RecordStatusAfterBattle_MarkCursed
    and $03
    call nz, RecordStatusAfterBattle_MarkPoisoned
    ret

.done:
    set 7, [hl]
    ret

; Sets bit 0 of the record's status byte (HL = MON_STATUS) for a slot whose battle status has
; BSTAT0_CURSED; called by RecordStatusAfterBattle. (C2, E-0372; probed E-0380)
RecordStatusAfterBattle_MarkCursed::
    set 0, [hl]
    ret

; Sets bit 2 of the record's status byte (HL = MON_STATUS, the bit read as poison) for a slot whose
; battle status has BSTAT0_POISONED or BSTAT0_BADLY_POISONED; called by RecordStatusAfterBattle.
; (C2, E-0372; probed E-0380)
RecordStatusAfterBattle_MarkPoisoned::
    set 2, [hl]
    ret

; HL = the record MON_STATUS address, C = slot: saves the status byte in wBattleArg0, then stores at
; MON_HP 0 when status bit 7 (fell) is set, otherwise the wBattleHP word of the slot, cut down to
; the MON_MAX_HP word two bytes on when that is lower; the test is the sign of MON_MAX_HP minus the
; HP as a 16-bit number, so a large battle HP such as $9000 passes the test and is stored as it is.
; Returns HL at MON_MP for the next step. (C2, E-0380)
BattleEnd_Records_StoreHP::
    ld a, [hl]
    ld [wBattleArg0], a
    bit 7, [hl]
    push af
    ld a, l
    add $06
    ld l, a
    ld a, h
    adc $00
    ld h, a
    pop af
    jr nz, .skip
    push hl
    inc hl
    inc hl
    deref_hl
    push hl
    ld a, c
    ld hl, wBattleHP
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    pop hl
    ld a, l
    sub e
    ld l, a
    ld a, h
    sbc d
    ld h, a
    bit 7, h
    jr z, .restore
    add hl, de
    ld d, h
    ld e, l

.restore:
    pop hl
    jr .skip2

.skip:
    ld de, $0000

.skip2:
    ld a, e
    ld [hli], a
    ld a, d
    ld [hli], a
    inc hl
    inc hl
    ret

; HL = the MON_MP address of the record, C = slot: stores in MON_MP the wBattleMP word of the slot,
; cut down to the MON_MAX_MP word two bytes on when that is lower (the test is the sign of
; MON_MAX_MP minus the MP as a 16-bit number), and a battle MP with bit 15 set stores MON_MAX_MP.
; Nothing is subtracted from the record. Returns HL at MON_WLD (12 bytes after MON_MP) for the next
; step. (C2, E-0380)
; the record word - the slot's wBattleMP word, keeping the word when the result would be negative
BattleEnd_Records_StoreMP::
    push hl
    inc hl
    inc hl
    deref_hl
    push hl
    ld a, c
    ld hl, wBattleMP
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    pop hl
    bit 7, d
    jr nz, .skip
    ld a, l
    sub e
    ld l, a
    ld a, h
    sbc d
    ld h, a
    bit 7, h
    jr z, .restore
    add hl, de

.skip:
    ld d, h
    ld e, l

.restore:
    pop hl
    ld a, e
    ld [hli], a
    ld a, d
    ld [hli], a
    ld a, l
    add $0a
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ret

; Unless the record fell (wBattleArg0 bit 7), copies the slot's wBattleExtraStat word to HL, which
; BattleEnd_Records_StoreMP left at MON_WLD; returns HL at MON_PERSONALITY either way. (C2, E-0372;
; probed E-0380)
BattleEnd_Records_StoreExtraStat::
    ld a, [wBattleArg0]
    bit 7, a
    jr nz, .skip2
    ld a, c
    ld de, wBattleExtraStat
    add a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hld], a

.skip2:
    ld a, l
    add $04
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ret

; Unless the record fell (wBattleArg0 bit 7), copies the slot's wSlotPersonalityHi,
; wSlotPersonalityLo, wSlotTrait and wSlotPersonalityMid bytes to the four MON_PERSONALITY bytes at
; HL, in that order. (C2, E-0372; probed E-0380)
BattleEnd_Records_StorePersonality::
    ld a, [wBattleArg0]
    bit 7, a
    jr nz, .return
    ld a, c
    ld de, wSlotPersonalityHi
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld [hli], a
    ld a, c
    ld de, wSlotPersonalityLo
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    ld [hli], a
    ld a, c
    ld de, wSlotTrait
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [de]
    ld [hli], a
    ld a, c
    ld de, wSlotPersonalityMid
    add e
    ld e, a
    jr nc, .done
    inc d

.done:
    ld a, [de]
    ld [hl], a

.return:
    ret

; Runner of the experience part of the battle end, called every frame by BattleEnd_AwardExperience:
; wBattleSubPhase picks one of 10 parts. 0 BattleEnd_GainExperience_Start shows the award, 1
; BattleEnd_GainExperience_AwardParty adds it to the party records, 2
; BattleEnd_GainExperience_CheckLevelUp checks each member for a level-up, 3
; BattleEnd_GainExperience_RunNewSkillSteps runs the new-skill steps, 4
; BattleEnd_GainExperience_StoreSkillsAndLevelUp stores the skills and the level and goes back to
; part 2, 5 BattleEnd_GainExperience_AwardFarm gives the farm records their share, 6
; BattleEnd_GainExperience_FindFarmLevelUp and 7 BattleEnd_GainExperience_LevelUpFarmRecord level
; the farm records up one at a time, 8 BattleEnd_GainExperience_Finish ends the part, and 9
; BattleEnd_GainExperience_LearnSkill is the special skill step of the arena. (C1, E-0380)
; by wBattleSubPhase: adds experience to each record (AddExpToRecordCCapped/HLCapped), checks
; RecordReachedNextLevelExp, computes level-up stat gains and learned skills ('0 learned G!')
BattleEnd_GainExperience::
    ld a, [wBattleSubPhase]
    jumptable
    dw BattleEnd_GainExperience_Start
    dw BattleEnd_GainExperience_AwardParty
    dw BattleEnd_GainExperience_CheckLevelUp
    dw BattleEnd_GainExperience_RunNewSkillSteps
    dw BattleEnd_GainExperience_StoreSkillsAndLevelUp
    dw BattleEnd_GainExperience_AwardFarm
    dw BattleEnd_GainExperience_FindFarmLevelUp
    dw BattleEnd_GainExperience_LevelUpFarmRecord
    dw BattleEnd_GainExperience_Finish
    dw BattleEnd_GainExperience_LearnSkill

; Experience, part 0: no experience in battle kinds 4, 5 and 8 and up (straight to part 9, or 8 in
; link battles); otherwise the award is divided by the number of party monsters still standing and
; shown ('<player>'s party got <n> EX points!'); next part. (C1, E-0357)
BattleEnd_GainExperience_Start::
    ld a, [wBattleKind]
    cp $04
    jr c, .skip
    cp $06
    jr z, .skip
    cp $07
    jr z, .skip
    xor a
    ld [wBattleResolveStep], a
    ld a, $09
    ld [wBattleSubPhase], a
    ld a, [wLinkMode]
    ret z
    ld a, $08
    ld [wBattleSubPhase], a
    ret

.skip:
    ld bc, $0300
    ld d, $00

.loop:
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    or a
    jr nz, .next
    inc d

.next:
    inc c
    dec b
    jr nz, .loop
    ld a, [wBattleExpAward]
    ld l, a
    ld a, [wBattleExpAward + $1]
    ld h, a
    ld a, [wBattleExpAward + $2]
    ld e, a
    ld a, d
    push af
    call Divide24ByA
    pop af
    ld a, l
    ldh [hTemp0], a
    ld [wBattleExpAward], a
    ld a, h
    ldh [hTemp1], a
    ld [wBattleExpAward + $1], a
    ld a, e
    ldh [hTemp2], a
    ld [wBattleExpAward + $2], a
    ld hl, wTextBuf0
    call WriteNumber24AsDecimalString
    ld hl, $0500
    call ShowStringHL_Bank31
    ld hl, wBattleSubPhase
    inc [hl]
    ret
    db $fe, $02, $c8, $fe, $03, $28, $0d, $7d, $d6, $01, $6f, $7c, $de, $00, $67, $7b
    db $de, $00, $5f, $c9, $7d, $c6, $01, $6f, $7c, $ce, $00, $67, $7b, $ce, $00, $5f
    db $c9

; Experience, part 1: after the text adds the award to each standing party monster
; (AddExpToRecordCCapped, at most 9,999,999); next part. (C2, E-0357; probed E-0380)
BattleEnd_GainExperience_AwardParty::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld bc, $0300

.loop:
    ld a, c
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    or a
    call z, AddExpToRecordCCapped
    inc c
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleArg0], a
    ret

; C = a party slot: adds the 24-bit wBattleExpAward (low byte first) to the 3-byte MON_EXP of record
; wPartyList[C] (SRAMRecordAddressMapped; the caller enables SRAM). The sum is taken in 24 bits and
; wraps without any overflow test, and a sum above 9,999,999 ($98967F) is stored as 9,999,999. BC is
; kept. (C2, E-0380)
; adds the 24-bit wBattleExpAward-wBattleExpAward + $2 to the 3-byte field $58 of record C, capped
; at 9,999,999 ($98967F) (E-0125)
AddExpToRecordCCapped::
    push bc
    ld a, c
    ld c, MON_EXP
    call SRAMRecordAddressMapped
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a
    ld d, [hl]
    ld a, [wBattleExpAward]
    add c
    ld c, a
    ld a, [wBattleExpAward + $1]
    adc b
    ld b, a
    ld a, [wBattleExpAward + $2]
    adc d
    ld d, a
    ld a, $7f
    sub c
    ld a, $96
    sbc b
    ld a, $98
    sbc d
    jr nc, .skip
    ld c, $7f
    ld b, $96
    ld d, $98

.skip:
    ld a, d
    ld [hld], a
    ld a, b
    ld [hld], a
    ld [hl], c
    pop bc
    ret

; Part 2 of the experience part, a runner on wBattleResolveStep: step 0 is
; BattleEnd_GainExperience_CheckLevelUp_RaiseLevel (test one member and raise its battle level) and
; step 1 is BattleEnd_GainExperience_CheckLevelUp_ShowGains (the level-up message and the stat
; gains). (C1, E-0380)
; by its step: RecordReachedNextLevelExp and the record name
BattleEnd_GainExperience_CheckLevelUp::
    ld a, [wBattleResolveStep]
    jumptable
    dw BattleEnd_GainExperience_CheckLevelUp_RaiseLevel
    dw BattleEnd_GainExperience_CheckLevelUp_ShowGains

; Level-up check: for party monster wBattleArg0 still standing, when it has reached the next level's
; experience raises its battle level, redraws its panel and waits 60 frames (next step); after the
; last member skips to part 5. (C1, E-0357)
BattleEnd_GainExperience_CheckLevelUp_RaiseLevel::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, [wBattleArg0]
    ld hl, wBattleSlotOut
    add_a_to_hl
    ld a, [hl]
    or a
    jr nz, .read_party_count
    ld a, [wBattleArg0]
    ld hl, wPartyList
    add_a_to_hl
    ld a, [hl]
    call RecordReachedNextLevelExp
    bit 0, c
    jr nz, .set_battle_end_timer_to_3C

.read_party_count:
    ld a, [wPartyCount]
    ld b, a
    ld a, [wBattleArg0]
    inc a
    ld [wBattleArg0], a
    cp b
    ret c
    ld hl, wBattleSubPhase
    inc [hl]
    ld hl, wBattleSubPhase
    inc [hl]
    ld hl, wBattleSubPhase
    inc [hl]
    ret

.set_battle_end_timer_to_3C:
    ld a, $3c
    ld [wBattleEndTimer], a
    ld a, [wBattleArg0]
    ld hl, wBattleLevel
    add_a_to_hl
    inc [hl]
    ld a, [wBattleArg0]
    ld c, a
    call DrawSlotStatusMarks
    ld a, [wBattleArg0]
    ld c, a
    call CopySlotPanelRowToVRAM
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; Level-up, step 1: '<name> was promoted to Lv<n>!' with the stat gains
; (ComputeLevelUpStatGainsForBattleArg1); next part. (C1, E-0357)
BattleEnd_GainExperience_CheckLevelUp_ShowGains::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wBattleArg0]
    ld c, MON_NAME
    call SRAMRecordAddressMapped
    call CopyTenByteNameToTextBuf0
    push hl
    ld a, [wBattleArg0]
    ld hl, wPartyList
    add_a_to_hl
    ld a, [hl]
    ld [wBattleArg1], a
    farcall ComputeLevelUpStatGainsForBattleArg1
    pop hl
    call WriteLevelUpNumbersToTextBufs
    ld hl, $0501
    call ShowStringHL_Bank31
    xor a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wBattleResolveStep], a
    ret

; Experience, part 3: counts the end timer down while the sound is idle and runs its steps (new
; skills). (C1, E-0357)
BattleEnd_GainExperience_RunNewSkillSteps::
    call CountDownBattleEndTimerWhenSoundIdle
    ld a, [wBattleResolveStep]
    jumptable
    dw BattleEnd_GainExperience_CopySkillsToWorkBuf
    dw BattleEnd_GainExperience_ShowNewSkills
    dw BattleEnd_GainExperience_ChooseSkillToForget

; New skills, step 0: after the text copies the monster's eight skills into wWorkBuf (the rest $FF);
; next step. (C2, E-0357; probed E-0380)
BattleEnd_GainExperience_CopySkillsToWorkBuf::
    ld a, [wTextFlags]
    or a
    ret nz
    ld hl, wWorkBuf
    ld bc, $0038
    ld a, $ff
    call FillBytes
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wBattleArg0]
    ld c, MON_SKILLS
    call SRAMRecordAddressMapped
    ld de, wWorkBuf
    ld b, $08

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; New skills, step 1: each skill it can now learn (FindNewlyLearnableSkills) is shown ('At Lv<n>,
; <name> learned <skill>!', '<old> became <skill>!' or 'devised <skill> from the skills it knows!')
; and put into the work list in place of the old skill or a free entry; when there are no more,
; updates the farm records and goes on. (C1, E-0357)
BattleEnd_GainExperience_ShowNewSkills::
    ld a, [wTextFlags]
    or a
    ret nz
    farcall FindNewlyLearnableSkills
    ldh a, [hTemp3]
    cp $ff
    jr z, .call_remove_known_skills_from_all_skill_lists
    ld l, a
    ld h, $04
    ld de, wTextBuf2
    call CopyStringHLToDE
    ld c, $ff
    ld hl, $0503
    ldh a, [hTemp4]
    or a
    jr z, .call_show_string_hl_bank31
    ld hl, $0505
    ldh a, [hTemp4]
    cp $02
    jr z, .call_show_string_hl_bank31
    ldh a, [hTemp5]
    ld l, a
    ld h, $04
    ld de, wTextBuf3
    call CopyStringHLToDE
    ld hl, $0504
    ldh a, [hTemp5]
    ld c, a

.call_show_string_hl_bank31:
    push bc
    call ShowStringHL_Bank31
    pop bc
    ld hl, wWorkBuf
    ld b, $38

.loop:
    ld a, [hl]
    cp c
    jr nz, .next
    ldh a, [hTemp3]
    ld [hl], a
    jr .return

.next:
    inc hl
    dec b
    jr nz, .loop

.return:
    ret

.call_remove_known_skills_from_all_skill_lists:
    call RemoveKnownSkillsFromAllSkillLists
    ld hl, wBattleResolveStep
    inc [hl]
    xor a
    ld [wBattleSubStep], a
    ret

; New skills, step 2: runs the forget-skill screen (ForgetSkillMenu) each frame; with eight or fewer
; skills in the work list it moves on to part 4 (BattleEnd_GainExperience_StoreSkillsAndLevelUp),
; otherwise it asks which skill to forget. (C1, E-0372)
BattleEnd_GainExperience_ChooseSkillToForget::
    call ForgetSkillMenu
    ret

; Experience, part 4: stores the work list as the monster's skills, applies the level-up and says
; 'It has reached the limit for growth.' at its level cap; back two parts (the next level or
; member). (C1, E-0357)
BattleEnd_GainExperience_StoreSkillsAndLevelUp::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    call StoreWorkBufToRecordSkills
    call ApplyLevelUpToRecordBattleArg0
    call BattleEnd_GainExperience_ShowGrowthLimit
    xor a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    dec [hl]
    ld hl, wBattleSubPhase
    dec [hl]
    xor a
    ld [wBattleResolveStep], a
    ret

; Level-up of the record wPartyList[wBattleArg0] (the caller enables SRAM): MON_LEVEL + 1, and
; wLevelUpGains + 0..5 are added to the words MON_MAX_HP, MON_MAX_MP, MON_ATK, MON_DEF, MON_AGL and
; MON_INT (a carry goes into the high byte; the gains were already limited by
; ClampLevelUpGainsTo999). MON_HP, MON_MP, MON_MAX_LEVEL and MON_WLD are not touched. (C2, E-0380)
; record wBattleArg0: level (field $56) += 1 and the gains wLevelUpGains-wLevelUpGains + $5 are
; added to its six stat words (E-0127)
ApplyLevelUpToRecordBattleArg0::
    ld a, [wBattleArg0]
    ld c, MON_LEVEL
    call SRAMRecordAddressMapped
    inc [hl]
    ld a, l
    add $07
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wLevelUpGains]
    call AddAToWordAtHL_Bank31_2
    ld a, l
    add $03
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wLevelUpGains + $1]
    call AddAToWordAtHL_Bank31_2
    ld a, l
    add $01
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wLevelUpGains + $2]
    call AddAToWordAtHL_Bank31_2
    ld a, l
    add $01
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wLevelUpGains + $3]
    call AddAToWordAtHL_Bank31_2
    ld a, l
    add $01
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wLevelUpGains + $4]
    call AddAToWordAtHL_Bank31_2
    ld a, l
    add $01
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wLevelUpGains + $5]
    call AddAToWordAtHL_Bank31_2
    ret

; A = an amount, HL = a little-endian word: the word += A (unsigned, wrapping at $10000 with no
; cap); HL ends on the high byte and A is clobbered. Used six times by
; ApplyLevelUpToRecordBattleArg0. (C2, E-0380)
; the word at HL += A (unsigned); HL ends on the high byte; clobbers A (E-0065) (the same 7 bytes
; appear in 2 banks)
AddAToWordAtHL_Bank31_2::
    add [hl]
    ld [hli], a
    ld a, $00
    adc [hl]
    ld [hl], a
    ret

; For the record wPartyList[wBattleArg0] (the caller enables SRAM): when MON_LEVEL is at least
; MON_MAX_LEVEL, starts the message 'It has reached the limit for growth.' (category 5, string $0A)
; with BeginStringDisplay_Bank2F; otherwise it does nothing. Called by
; BattleEnd_GainExperience_StoreSkillsAndLevelUp after the level-up. (C1, E-0380)
; for record wBattleArg0: if field $56 (level) >= field $57, begins showing string $0A of category 5
; (BeginStringDisplay_Bank2F) (E-0122)
BattleEnd_GainExperience_ShowGrowthLimit::
    ld a, [wBattleArg0]
    ld c, MON_LEVEL
    call SRAMRecordAddressMapped
    ld a, [hli]
    cp [hl]
    ret c
    ld a, $0a
    ld [wStringIndex], a ; 'It has reached the limit for'
    ld a, $05
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ret

; Copies the 8 bytes at wWorkBuf to MON_SKILLS of the record wPartyList[wBattleArg0] (the caller
; enables SRAM): the skill list built in wWorkBuf by the new-skill steps becomes the skills of the
; monster. Nothing around the 8 bytes changes. (C2, E-0380)
; copies the 8 bytes at wWorkBuf to the skill list (field $34) of record wBattleArg0 (E-0122)
StoreWorkBufToRecordSkills::
    ld a, [wBattleArg0]
    ld c, MON_SKILLS
    call SRAMRecordAddressMapped
    ld de, wWorkBuf
    ld b, $08

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop
    ret

; Experience, part 5: the farm's share: the award divided by 20, 15 or 10 by wFarmLevel, added to
; each farm record (state 1, byte $6E clear); next part. (C2, E-0357; probed E-0380)
BattleEnd_GainExperience_AwardFarm::
    call DivideBattleExpAwardByModeFactor
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld hl, sRecords
    ld b, $1e
    ld c, $00

.loop:
    ld a, [hl]
    cp $01
    jr nz, .skip
    push hl
    ld a, l
    add $6e
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [hl]
    and a
    pop hl
    call z, AddExpToRecordHLCapped

.skip:
    ld a, l
    add $a5
    ld l, a
    ld a, h
    adc $00
    ld h, a
    inc c
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; Divides the 24-bit wBattleExpAward (low byte first) by 20 when wFarmLevel is 0, by 15 when it is 1
; and by 10 for any other value, rounding down, and stores the quotient back. Called by
; BattleEnd_GainExperience_AwardFarm, so it makes the share of the farm records. (C2, E-0380)
; divides the 24-bit wBattleExpAward-wBattleExpAward + $2 by 20, 15 or 10 for wFarmLevel = 0, 1 or
; other (E-0124)
DivideBattleExpAwardByModeFactor::
    ld a, [wBattleExpAward]
    ld l, a
    ld a, [wBattleExpAward + $1]
    ld h, a
    ld a, [wBattleExpAward + $2]
    ld e, a
    ld a, [wFarmLevel]
    or a
    jr z, .skip
    cp $01
    jr z, .call_divide24_by_a
    ld a, $0a
    jr .call_divide24_by_a2

.skip:
    ld a, $14
    jr .call_divide24_by_a2

.call_divide24_by_a:
    ld a, $0f

.call_divide24_by_a2:
    call Divide24ByA
    ld a, l
    ld [wBattleExpAward], a
    ld a, h
    ld [wBattleExpAward + $1], a
    ld a, e
    ld [wBattleExpAward + $2], a
    ret

; HL = the start of a monster record in SRAM (kept, as is BC): adds the 24-bit wBattleExpAward to
; the 3-byte MON_EXP at HL + $58 with the same wrap and 9,999,999 cap as AddExpToRecordCCapped.
; Called by BattleEnd_GainExperience_AwardFarm, which walks the farm records directly instead of
; through the party list. (C2, E-0380)
; adds the 24-bit wBattleExpAward-wBattleExpAward + $2 to the 3-byte field $58 of the record at HL,
; capped at 9,999,999 ($98967F) (E-0125)
AddExpToRecordHLCapped::
    push bc
    push hl
    ld a, l
    add $58
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a
    ld d, [hl]
    ld a, [wBattleExpAward]
    add c
    ld c, a
    ld a, [wBattleExpAward + $1]
    adc b
    ld b, a
    ld a, [wBattleExpAward + $2]
    adc d
    ld d, a
    ld a, $7f
    sub c
    ld a, $96
    sbc b
    ld a, $98
    sbc d
    jr nc, .skip
    ld c, $7f
    ld b, $96
    ld d, $98

.skip:
    ld a, d
    ld [hld], a
    ld a, b
    ld [hld], a
    ld [hl], c
    pop hl
    pop bc
    ret

; Experience, part 6: finds a farm record that reached its next level (wBattleArg1, next part), or
; skips two parts when none did. (C2, E-0357; probed E-0380)
BattleEnd_GainExperience_FindFarmLevelUp::
    ld hl, sRecords
    ld b, $1e
    ld c, $00

.loop:
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    cp $01
    jr nz, .skip
    push hl
    push bc
    ld a, c
    call RecordReachedNextLevelExp
    bit 0, c
    pop bc
    pop hl
    jr nz, .skip2

.skip:
    ld a, l
    add $a5
    ld l, a
    ld a, h
    adc $00
    ld h, a
    inc c
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    inc [hl]
    ld hl, wBattleSubPhase
    inc [hl]
    ret

.skip2:
    xor a
    ld [rRAMG], a
    ld a, c
    ld [wBattleArg1], a
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; Experience, part 7: levels the farm record up quietly (ComputeLevelUpStatGainsForBattleArg1,
; ApplyLevelUpToRecordBattleArg1, then FullHealRecordBattleArg1) and returns to part 6. (C2, E-0357;
; probed E-0380)
BattleEnd_GainExperience_LevelUpFarmRecord::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    farcall ComputeLevelUpStatGainsForBattleArg1
    call ApplyLevelUpToRecordBattleArg1
    call FullHealRecordBattleArg1
    xor a
    ld [rRAMG], a
    ld hl, wBattleSubPhase
    dec [hl]
    ret

; Level-up of the SRAM record number wBattleArg1, used as it is without the party list (the caller
; enables SRAM): MON_LEVEL + 1, and wLevelUpGains + 0..5 are added to the words MON_MAX_HP,
; MON_MAX_MP, MON_ATK, MON_DEF, MON_AGL and MON_INT. The same as ApplyLevelUpToRecordBattleArg0
; apart from the record number; BattleEnd_GainExperience_LevelUpFarmRecord calls it. (C2, E-0380)
; record wBattleArg1: level (field $56) += 1 and the gains wLevelUpGains-wLevelUpGains + $5 are
; added to its six stat words (E-0127)
ApplyLevelUpToRecordBattleArg1::
    ld a, [wBattleArg1]
    ld c, MON_LEVEL
    call SRAMRecordAddress
    inc [hl]
    ld a, l
    add $07
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wLevelUpGains]
    call AddAToWordAtHL_Bank31
    ld a, l
    add $03
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wLevelUpGains + $1]
    call AddAToWordAtHL_Bank31
    ld a, l
    add $01
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wLevelUpGains + $2]
    call AddAToWordAtHL_Bank31
    ld a, l
    add $01
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wLevelUpGains + $3]
    call AddAToWordAtHL_Bank31
    ld a, l
    add $01
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wLevelUpGains + $4]
    call AddAToWordAtHL_Bank31
    ld a, l
    add $01
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wLevelUpGains + $5]
    call AddAToWordAtHL_Bank31
    ret

; A = an amount, HL = a little-endian word: the word += A (unsigned, wrapping at $10000 with no
; cap); HL ends on the high byte and A is clobbered. Used six times by
; ApplyLevelUpToRecordBattleArg1. (C2, E-0380)
; the word at HL += A (unsigned); HL ends on the high byte; clobbers A (E-0065) (the same 7 bytes
; appear in 2 banks)
AddAToWordAtHL_Bank31::
    add [hl]
    ld [hli], a
    ld a, $00
    adc [hl]
    ld [hl], a
    ret

; For SRAM record number wBattleArg1 (taken as it is, not mapped through the party list): copies the
; word MON_MAX_HP to MON_HP, the word MON_MAX_MP to MON_MP and sets MON_STATUS to 0, so the record
; ends at full HP and MP with no status. SRAM must already be enabled and banked by the caller.
; Called only by BattleEnd_GainExperience_LevelUpFarmRecord, right after a farm record has been
; levelled up. (C2, E-0380)
; for SRAM record wBattleArg1: field $5B = word field $5D, field $5F = word field $61, field $55 = 0
; (E-0121)
FullHealRecordBattleArg1::
    ld a, [wBattleArg1]
    ld c, MON_MAX_HP
    call SRAMRecordAddress
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld b, a
    push hl
    ld a, l
    add $fc
    ld l, a
    ld a, h
    adc $ff
    ld h, a
    ld a, c
    ld [hli], a
    ld [hl], b
    pop hl
    push hl
    inc hl
    inc hl
    ld a, [hli]
    ld c, a
    ld b, [hl]
    pop hl
    ld a, c
    ld [hli], a
    ld a, b
    ld [hli], a
    ld a, l
    add $f4
    ld l, a
    ld a, h
    adc $ff
    ld h, a
    ld [hl], $00
    ret

; Experience, part 8: ends the experience phase: next battle step (wBattleStep + 1) with
; wBattleSubPhase 0. Reached from part 6 (BattleEnd_GainExperience_FindFarmLevelUp) when no farm
; record reaches its next level. (C2, E-0372; probed E-0380)
BattleEnd_GainExperience_Finish::
    ld hl, wBattleStep
    inc [hl]
    xor a
    ld [wBattleSubPhase], a
    ret

; Part 9 of BattleEnd_GainExperience (entry 9 of its jump table, picked by wBattleSubPhase). Part 0
; jumps here when the battle gives no experience (battle kinds 4, 5 and 8 up) outside a link battle.
; It runs the step picked by wBattleResolveStep: 0 BattleEnd_GainExperience_LearnSkill_Start, 1
; BattleEnd_GainExperience_LearnSkill_CopySkills, 2
; BattleEnd_GainExperience_LearnSkill_EndAfterText. Only arena rank 5 or more with one party monster
; and a skill remembered in wLearnSkillState gets past step 0, and step 1 always ends the phase (it
; clears hTemp0 with ClearTemp0AndA before testing it), so the text '0 learned G!' is never shown.
; (C1, E-0380)
; by its step: '0 learned G!'
BattleEnd_GainExperience_LearnSkill::
    ld a, [wBattleResolveStep]
    jumptable
    dw BattleEnd_GainExperience_LearnSkill_Start
    dw BattleEnd_GainExperience_LearnSkill_CopySkills
    dw BattleEnd_GainExperience_LearnSkill_EndAfterText

; Learned skill, step 0: only from arena rank 5, with one party monster and a skill in
; wLearnSkillState ($AA becomes $8F); otherwise next battle step. (C2, E-0357; probed E-0380)
BattleEnd_GainExperience_LearnSkill_Start::
    ld a, [wArenaRank]
    cp $05
    jr c, BattleEnd_GainExperience_LearnSkill_Done
    ld a, [wBattlePartyCount]
    cp $01
    jr nz, BattleEnd_GainExperience_LearnSkill_Done
    ld a, [wLearnSkillState]
    or a
    jr z, BattleEnd_GainExperience_LearnSkill_Done
    cp $aa
    jr nz, .done
    ld a, $8f
    ld [wLearnSkillState], a

.done:
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; Ends the experience phase from the learned-skill steps: next battle step (wBattleStep + 1) with
; wBattleSubPhase and wBattleResolveStep cleared. Reached when
; BattleEnd_GainExperience_LearnSkill_Start's conditions fail, when
; BattleEnd_GainExperience_LearnSkill_CopySkills finds hTemp0 = 0 (always), and after the text
; (BattleEnd_GainExperience_LearnSkill_EndAfterText). (C2, E-0372; probed E-0380)
BattleEnd_GainExperience_LearnSkill_Done::
    ld hl, wBattleStep
    inc [hl]
    xor a
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    ret

; Learned skill, step 1: copies the first party monster's skills to wWorkBuf, then calls
; ClearTemp0AndA, which clears hTemp0, so it always ends the step here (next battle step); the rest,
; adding skill hTemp0 and showing '<name> learned <skill>!', never runs (C1). (C1, E-0357)
BattleEnd_GainExperience_LearnSkill_CopySkills::
    ld a, [wLearnSkillState]
    ldh [hTemp0], a
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wPartyList]
    ld c, MON_SKILLS
    call SRAMRecordAddress
    ld de, wWorkBuf
    ld b, $08

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    farcall ClearTemp0AndA
    ldh a, [hTemp0]
    or a
    jr nz, .skip
    xor a
    ld [rRAMG], a
    jr BattleEnd_GainExperience_LearnSkill_Done

.skip:
    ld l, a
    ld h, $04
    ld de, wTextBuf1
    call CopyStringHLToDE
    ld a, [wPartyList]
    ld c, MON_NAME
    call SRAMRecordAddress
    ld d, h
    ld e, l
    ld hl, wTextBuf0
    call CopyFiveGlyphsPlusMarks
    ld a, [wPartyList]
    ld c, MON_SKILLS
    call SRAMRecordAddress
    ld de, wWorkBuf
    ld b, $08

.loop2:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop2
    xor a
    ld [rRAMG], a
    ld a, $05
    ld [wStringCategory], a
    ld a, $1f
    ld [wStringIndex], a ; '0 learned G!'
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; Learned skill, step 2: returns while wTextFlags is set, then ends the phase
; (BattleEnd_GainExperience_LearnSkill_Done). (C2, E-0372; probed E-0380)
BattleEnd_GainExperience_LearnSkill_EndAfterText::
    ld a, [wTextFlags]
    or a
    ret nz
    jp BattleEnd_GainExperience_LearnSkill_Done

; HL = HL + A * $4E (16-bit sum; $4E is the size of one battler record). A and BC are changed.
; Nothing in src/ calls it (see BattlerRecordFieldAddress for a similar multiply). (C2, E-0380)
; HL += A * $4E (the battler-record size, Multiply8); clobbers BC (E-0115)
AddAx4EToHL::
    push hl
    ld c, $4e
    call Multiply8
    pop bc
    add hl, bc
    ret

; A = SRAM record number (taken as it is, not mapped through the party list); returns C = 1 when the
; record has reached the experience for its next level, else C = 0. It enables SRAM bank 0 itself
; and switches SRAM off again before returning. A record whose MON_LEVEL is already at or above
; MON_MAX_LEVEL gives C = 0 at once. Otherwise it loads the species record of MON_SPECIES
; (LoadSpeciesRecord), takes its growth curve wSpeciesExpCurve and the 24-bit table entry for the
; current level (LoadExpTableEntryToTemp2 with hTemp0 = curve, hTemp1 = level, result in
; hTemp2-hTemp4, low byte first), and compares it with the 24-bit MON_EXP: C = 1 when MON_EXP is
; equal to or above the entry. Callers: BattleEnd_GainExperience_CheckLevelUp_RaiseLevel and
; BattleEnd_GainExperience_FindFarmLevelUp. (C2, E-0380)
; record A below its level cap: C = 1 when its EXP (field $58) has reached the next level's total
; from the species growth table, else 0 (E-0127)
RecordReachedNextLevelExp::
    push af
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    pop af
    ld c, MON_LEVEL
    call SRAMRecordAddress
    ld a, [hli]
    cp [hl]
    jr nc, .skip2
    ldh [hTemp1], a
    ld a, l
    add $b4
    ld l, a
    ld a, h
    adc $ff
    ld h, a
    ld a, [hli]
    ld [wSpeciesIdLo], a
    ld a, [hli]
    ld [wSpeciesIdHi], a
    ld a, l
    add $4b
    ld l, a
    ld a, h
    adc $00
    ld h, a
    push hl
    farcall LoadSpeciesRecord
    ld a, [wSpeciesExpCurve]
    ldh [hTemp0], a
    farcall LoadExpTableEntryToTemp2
    pop hl
    ldh a, [hTemp2]
    sub [hl]
    ld e, a
    inc hl
    ldh a, [hTemp3]
    sbc [hl]
    ld d, a
    inc hl
    ldh a, [hTemp4]
    sbc [hl]
    jr c, .skip
    or d
    or e
    jr nz, .skip2

.skip:
    ld c, $01
    jr .done

.skip2:
    ld c, $00

.done:
    xor a
    ld [rRAMG], a
    ret

; HL = source: copies 10 bytes (a record name, MON_NAME) to wTextBuf0 and writes the end mark $F0 as
; the eleventh byte, so a full 10-character name is still ended. HL ends 10 bytes past the source,
; DE at the $F0 and B = 0. Called by BattleEnd_GainExperience_CheckLevelUp_ShowGains with HL at
; MON_NAME. (C2, E-0380)
; copies 10 bytes from HL to wTextBuf0 and appends a $F0 terminator (E-0122)
CopyTenByteNameToTextBuf0::
    ld de, wTextBuf0
    ld b, $0a

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld a, $f0
    ld [de], a
    ret

; HL = 10 bytes into a record (the address left after the name by the copy in
; CopyTenByteNameToTextBuf0, which is MON_SPECIES; see CopyTenByteNameToTextBuf0): writes the
; numbers of the level-up message as decimal strings (digit codes 0-9 without leading zeros, then
; $F0): the byte at HL + $4B (MON_LEVEL) plus 1, the new level, to wTextBuf1, and the six
; wLevelUpGains bytes to wTextBuf2, wTextBuf2 + $4, + $8, + $C, wTextBuf3 and wTextBuf3 + $4. Called
; only by BattleEnd_GainExperience_CheckLevelUp_ShowGains, just before it shows the message
; ('promoted to Lv<n>' with the gains). (C2, E-0380)
; writes [HL + $4B] + 1 to wTextBuf1 and wLevelUpGains-wLevelUpGains + $5 to wTextBuf2-wTextBuf3 +
; $4 as decimal strings (E-0121)
WriteLevelUpNumbersToTextBufs::
    ld a, l
    add $4b
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [hl]
    inc a
    ld hl, wTextBuf1
    call WriteDecimalByteString
    ld a, [wLevelUpGains]
    ld hl, wTextBuf2
    call WriteDecimalByteString
    ld a, [wLevelUpGains + $1]
    ld hl, wTextBuf2 + $4
    call WriteDecimalByteString
    ld a, [wLevelUpGains + $2]
    ld hl, wTextBuf2 + $8
    call WriteDecimalByteString
    ld a, [wLevelUpGains + $3]
    ld hl, wTextBuf2 + $c
    call WriteDecimalByteString
    ld a, [wLevelUpGains + $4]
    ld hl, wTextBuf3
    call WriteDecimalByteString
    ld a, [wLevelUpGains + $5]
    ld hl, wTextBuf3 + $4
    call WriteDecimalByteString
    ret

; H = string category, L = string index: stores them in wStringCategory and wStringIndex and
; far-calls BeginStringDisplay_Bank2F, which starts printing that bank $2F battle text and sets
; wTextFlags. Callers pass an immediate such as $0500: BattleEnd_GainExperience_Start (the
; experience award), BattleEnd_GainExperience_CheckLevelUp_ShowGains,
; BattleEnd_GainExperience_ShowNewSkills, ForgetSkillMenu_Start, ForgetSkillMenu_AskForget and
; ForgetSkillMenu_ReadAnswer. (C1, E-0380)
; wStringCategory = H, wStringIndex = L, then far-calls BeginStringDisplay_Bank2F (E-0110)
ShowStringHL_Bank31::
    ld a, h
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank2F
    ret

; Enables SRAM bank 0, then for each of the 30 records from sRecords (record number in B, $A5 bytes
; each) whose first byte (MON_STATE) is not 0 runs RemoveKnownSkillsFromRecordSkillList; at the end
; SRAM is switched off. Together they take every skill a record knows (MON_SKILLS) out of its
; MON_SKILL_LIST. Called only by BattleEnd_GainExperience_ShowNewSkills, when there are no more new
; skills to show. (C2, E-0380)
; with SRAM enabled runs RemoveKnownSkillsFromRecordSkillList for each of the 30 records ($A5 bytes
; from sRecords) whose first byte is non-zero (E-0124) (E-0344: the address in its name dropped or
; read as the label there; was RemoveKnownSkillsFromAllSkillLists)
RemoveKnownSkillsFromAllSkillLists::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld hl, sRecords
    ld b, $00

.loop:
    ld a, [hl]
    or a
    jr z, .skip
    push hl
    push bc
    call RemoveKnownSkillsFromRecordSkillList
    pop bc
    pop hl

.skip:
    ld a, l
    add $a5
    ld l, a
    ld a, h
    adc $00
    ld h, a
    inc b
    ld a, b
    cp $1e
    jr nz, .loop
    xor a
    ld [rRAMG], a
    ret

; B = SRAM record number (taken as it is), SRAM already enabled: for each of the eight bytes of its
; MON_SKILLS that is not $FF runs RemoveKnownSkillsFromRecordSkillList_RemoveOne, so every known
; skill is removed from the record MON_SKILL_LIST. B is kept. Called only by
; RemoveKnownSkillsFromAllSkillLists. (C2, E-0380)
; runs RemoveKnownSkillsFromRecordSkillList_RemoveOne for each of the eight skills (field $34) of
; record B that is not $FF (E-0124) (E-0344: the address in its name dropped or read as the label
; there; was RemoveKnownSkillsFromRecordSkillList)
RemoveKnownSkillsFromRecordSkillList::
    push bc
    ld a, b
    ld c, MON_SKILLS
    call SRAMRecordAddress
    pop bc
    ld c, $08

.loop:
    ld a, [hli]
    cp $ff
    push hl
    push bc
    call nz, RemoveKnownSkillsFromRecordSkillList_RemoveOne
    pop bc
    pop hl
    dec c
    jr nz, .loop
    ret

; A = skill, B = record: replaces every copy of the skill in the record's 25-byte MON_SKILL_LIST
; with $FF, then packs the list (its non-$FF entries to the front, $FF after) through
; wBattlerRecords + $4 as scratch; SRAM must be enabled. RemoveKnownSkillsFromRecordSkillList runs
; it for each of the record's MON_SKILLS, and RemoveKnownSkillsFromAllSkillLists for every record,
; after BattleEnd_GainExperience_ShowNewSkills. (C2, E-0372; probed E-0380)
RemoveKnownSkillsFromRecordSkillList_RemoveOne::
    ld d, a
    push de
    ld a, b
    ld c, MON_SKILL_LIST
    call SRAMRecordAddress
    pop de
    push hl
    ld c, $19

.loop:
    ld a, [hl]
    cp d
    jr nz, .next
    ld [hl], $ff

.next:
    inc hl
    dec c
    jr nz, .loop
    pop hl
    push hl
    ld de, wBattlerRecords + $4
    ld b, $19

.loop2:
    ld a, [hl]
    ld [de], a
    ld a, $ff
    ld [hli], a
    inc de
    dec b
    jr nz, .loop2
    pop hl
    ld de, wBattlerRecords + $4
    ld b, $19

.loop3:
    ld a, [de]
    cp $ff
    jr z, .next2
    ld [hli], a

.next2:
    inc de
    dec b
    jr nz, .loop3
    ret

; The screen that asks which skill to forget when a monster would get more than eight skills. Runs
; the step picked by wBattleSubStep: 0 ForgetSkillMenu_Start (counts the skills and sets up the
; pages), 1 ForgetSkillMenu_DrawList, 2 ForgetSkillMenu_Cursor, 3 ForgetSkillMenu_AskForget, 4
; ForgetSkillMenu_DrawYesNo, 5 ForgetSkillMenu_ReadAnswer, 6 ForgetSkillMenu_RestartAfterText.
; Called every frame by BattleEnd_GainExperience_ChooseSkillToForget (new-skill step 2), which
; BattleEnd_GainExperience_ShowNewSkills reaches with wBattleSubStep = 0. When step 0 finds eight or
; fewer skills in wWorkBuf it ends the screen and goes on to the next experience part. (C1, E-0380)
; the level-up screen at the end of a battle (gaining experience): by wBattleSubStep it clears the
; screen, draws the panel and the command cursor, lets the player toggle entries and waits for the
; text (E-0354; was: runs the routine for wBattleSubStep (jump table of seven) (E-0122)) (renamed
; from RunBattleEndStep4SubSteps from its E-0357 note, E-0367)
ForgetSkillMenu::
    ld a, [wBattleSubStep]
    jumptable
    dw ForgetSkillMenu_Start
    dw ForgetSkillMenu_DrawList
    dw ForgetSkillMenu_Cursor
    dw ForgetSkillMenu_AskForget
    dw ForgetSkillMenu_DrawYesNo
    dw ForgetSkillMenu_ReadAnswer
    dw ForgetSkillMenu_RestartAfterText

; Skill list screen, step 0: with fewer than nine skills nothing to forget (next part, the battle
; screen redrawn); otherwise 'But <name> can't learn more skills! Which skill should be forgotten?',
; the pages set up; next step. (C1, E-0357)
ForgetSkillMenu_Start::
    call ForgetSkillMenu_PackSkillList
    cp $09
    jr nc, .skip
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wBattleResolveStep], a
    farcall ClearAttributesAndScreenBuffer_Bank31
    farcall CopyRectRecordForBattlePartyCount_Bank31
    farcall DrawPartySlotStatusPanels
    call FillTilesFromRequest
    farcall CopyRectRecordToScreenBuffer
    ld hl, vBGMap0
    ld bc, $1412
    ld de, wScreenTileBuffer

.loop:
    push bc

.loop2:
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, .loop2
    ld a, l
    add $0c
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, e
    add $0c
    ld e, a
    ld a, d
    adc $00
    ld d, a
    pop bc
    dec c
    jr nz, .loop
    ret

.skip:
    ld b, a
    dec a
    and $03
    ld [wCommandCursorMax], a
    ld a, $04
    call DivideBByA
    cp $00
    jr nz, .set_command_page_count
    dec b

.set_command_page_count:
    ld a, b
    ld [wCommandPageCount], a
    xor a
    ld [wCommandCursor], a
    ld a, $03
    ld [wListLastPageSize], a
    ld hl, $0506
    call ShowStringHL_Bank31
    ld hl, wBattleSubStep
    inc [hl]
    xor a
    ld [wMenuState], a
    ret

; Skill list screen, step 1: draws the list, the monster's MP, the page and the selected skill's
; name and cost; next step. (C1, E-0357)
ForgetSkillMenu_DrawList::
    ld a, [wTextFlags]
    or a
    ret nz
    call FillScreenTileBufferRow11Col4WithC3_Bank31
    call CopyScreenBufferRect20x11ToBGMapRow7
    call ForgetSkillMenu_WriteSkillNames
    farcall CopyRectRecordsAndPlaySound6C
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wBattleArg0]
    ld c, MON_MP
    call SRAMRecordAddressMapped
    deref_hl
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $a2
    call WriteDecimalDigitTiles
    xor a
    ld [rRAMG], a
    ld a, [wCommandPageCount]
    add $e1
    ld [wScreenTileBuffer + $111], a
    call ShowSelectedSkillNameAndCost
    ld de, wScreenTileBuffer + $8
    ld hl, vBGMap0 + $8
    lb bc, $0c, $09
    call CopyRect32StrideToVRAM
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    lb bc, $14, $09
    call CopyRect32StrideToVRAM
    call DrawCommandCursorPageNumber
    ld hl, wBattleSubStep
    inc [hl]
    ret

; Skill list screen, step 2: moves the cursor; A picks the skill (its name to wTextBuf2) and goes
; on; Up/Down redraw the cost; Left/Right change the page. (C1, E-0357)
ForgetSkillMenu_Cursor::
    ld de, ForgetSkillMenu_Cursor_Data
    ld hl, wMenuState
    call MoveBattleCommandCursor
    ld a, [wJoypadPressed]
    and $01
    jr z, .check_joypad_pressed_repeat
    ld a, $69
    call QueueSoundEffect
    ld a, [wCommandCursor]
    and $0f
    add a
    add a
    ld b, a
    ld a, [wMenuState]
    and $0f
    add b
    ld hl, wWorkBuf
    add_a_to_hl
    ld a, [hl]
    ld l, a
    ld h, $04
    ld de, wTextBuf2
    call CopyStringHLToDE
    ld hl, wBattleSubStep
    inc [hl]
    ret

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and $c0
    jr z, .check_joypad_pressed_repeat2
    call ForgetSkillMenu_RedrawSkillCost
    ret

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    and $30
    ret z
    ld hl, wCommandCursor
    res 7, [hl]
    call ForgetSkillMenu_WriteSkillNames
    call ForgetSkillMenu_RedrawSkillCost
    call DrawCommandCursorPageNumber
    ret

; Skill list screen, step 3: marks the chosen skill ($BC) and asks 'Forget <skill>? Are you sure?';
; next step. (C1, E-0357)
ForgetSkillMenu_AskForget::
    ld a, [wMenuState]
    and $0f
    ld hl, ForgetSkillMenu_Cursor_Data
    add a
    add_a_to_hl
    deref_hl
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $98
    ld h, a
    ld [hl], $bc
    farcall CopyRectRecordToScreenBuffer
    ld hl, vBGMap0 + $1a0
    ld de, wWindowTileBuffer + $38
    lb bc, $14, $05
    call CopyRect32StrideToVRAM
    ld hl, $0508
    call ShowStringHL_Bank31
    ld hl, wBattleSubStep
    inc [hl]
    ret

; Skill list screen, step 4: draws the yes/no box with the cursor on no; next step. (C1, E-0357)
ForgetSkillMenu_DrawYesNo::
    ld a, [wTextFlags]
    or a
    ret nz
    farcall LoadCursorTileAndRect
    ld a, $bb
    ld [wWindowTileBuffer + $7], a
    ld hl, vBGMap0 + $10e
    ld de, wScreenTileBuffer + $10e
    lb bc, $06, $05
    call CopyRect32StrideToVRAM
    ld a, $01
    ld [wMenuSubState], a
    ld hl, wBattleSubStep
    inc [hl]
    ret

; Skill list screen, step 5: yes removes the skill from the work list and says '<skill> was
; forgotten.'; no or B goes back to the list (step 1). (C1, E-0357)
ForgetSkillMenu_ReadAnswer::
    ld de, RunBattleSetup_MainMenu_YesNoCursor_Data2
    ld hl, wMenuSubState
    call ToggleEntryBitsByJoypadAndBlink
    ld a, [wJoypadPressed]
    and $01
    jr z, .check_joypad_pressed
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSubState]
    bit 0, a
    jr nz, .set_battle_sub_step_to_01
    ld a, [wCommandCursor]
    and $0f
    add a
    add a
    ld b, a
    ld a, [wMenuState]
    and $0f
    add b
    ld hl, wWorkBuf
    add_a_to_hl
    ld [hl], $ff
    ld hl, $0509
    call ShowStringHL_Bank31
    ld hl, wBattleSubStep
    inc [hl]
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $02
    ret z

.set_battle_sub_step_to_01:
    ld a, $01
    ld [wBattleSubStep], a
    ret

; Skill list screen, step 6: returns while wTextFlags is set, then sets wBattleSubStep to 0, so step
; 0 (ForgetSkillMenu_Start) recounts the skills and closes the screen when eight or fewer remain.
; (C2, E-0372; probed E-0380)
ForgetSkillMenu_RestartAfterText::
    ld a, [wTextFlags]
    or a
    ret nz
    xor a
    ld [wBattleSubStep], a
    ret

; Packs the 56-byte work list wWorkBuf: copies its non-$FF skills in order to wBattlerRecords + $4
; (filled with $FF first) and the 56 bytes back, so the skills come first and $FF fills the rest; A
; = how many skills. Called by ForgetSkillMenu_Start. (C2, E-0372; probed E-0380)
ForgetSkillMenu_PackSkillList::
    ld hl, wBattlerRecords + $4
    ld bc, $0038
    ld a, $ff
    call FillBytes
    ld hl, wWorkBuf
    ld de, wBattlerRecords + $4
    ld b, $38
    ld c, $00

.loop:
    ld a, [hli]
    cp $ff
    jr z, .next
    ld [de], a
    inc de
    inc c

.next:
    dec b
    jr nz, .loop
    ld a, c
    push af
    ld hl, wWorkBuf
    ld de, wBattlerRecords + $4
    ld b, $38

.loop2:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop2
    pop af
    ret

; Writes the four skill names of the current page (category 4) into the list window, a blank for
; $FF. (C1, E-0357)
ForgetSkillMenu_WriteSkillNames::
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, [wCommandCursor]
    and $0f
    add a
    add a
    ld hl, wWorkBuf
    add_a_to_hl
    ld bc, $0400

.loop:
    push bc
    push hl
    ld a, c
    ld hl, ForgetSkillMenu_WriteSkillNames_Data
    add a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    pop hl
    ld a, [hli]
    push hl
    cp $ff
    jr nz, .set_string_index
    xor a

.set_string_index:
    ld [wStringIndex], a
    ld a, $04
    ld [wStringCategory], a
    farcall ShowString_Bank08
    pop hl
    pop bc
    inc c
    dec b
    jr nz, .loop
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ret

; data read by ForgetSkillMenu (8 bytes) (E-0347)
ForgetSkillMenu_WriteSkillNames_Data::
    db $c0, $95, $50, $96, $e0, $96, $70, $97

; Shows the skill under the cursor on the forget-skill screen. The skill is wWorkBuf[4 *
; (wCommandCursor and $0F) + (wMenuState and $0F)]. Its short name (string category 9) is printed
; into a 3 x 18 text window at vTiles2 + $260, using the text window variables wTextWindowTileLo/Hi,
; wTextWindowRows and wTextWindowWidth, which are put back to vTiles1 and 2 x 18 at the end. Then it
; loads the skill record (LoadSkillRecord) and writes a number as three digit tiles
; (HLToDecimalDigits, WriteDecimalDigitTiles) to wWindowTileBuffer + $9E: byte 0 of the skill
; record, read as the MP cost, or, for SKILL_MEGAMAGIC, SKILL_FAREWELL and SKILL_LIFEDANCE, the
; current MP of the monster (MON_MP of the record wBattleArg0, SRAM bank 0 switched on and off
; again). Called by ForgetSkillMenu_DrawList and by ForgetSkillMenu_RedrawSkillCost. (C1, E-0380)
; shows the name (category 9) of skill wWorkBuf[4 * page + row] at vTiles2 + $260, loads its record
; and writes its MP cost (or the record's MP for skills $3D, $20, $7B) as digits at
; wWindowTileBuffer + $9E (E-0128)
ShowSelectedSkillNameAndCost::
    ld hl, vTiles2 + $260
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1203
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, [wCommandCursor]
    and $0f
    add a
    add a
    ld b, a
    ld a, [wMenuState]
    and $0f
    add b
    ld hl, wWorkBuf
    add_a_to_hl
    ld a, [hl]
    push af
    ld [wStringIndex], a
    ld a, $09
    ld [wStringCategory], a
    farcall ShowString_Bank08
    pop af
    ld [wRecordBuffer], a
    xor a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ld a, [wRecordBuffer]
    cp $3d
    jr z, .skip
    cp $20
    jr z, .skip
    cp $7b
    jr nz, .read_record_buffer_data

.skip:
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wBattleArg0]
    ld c, MON_MP
    call SRAMRecordAddressMapped
    deref_hl
    xor a
    ld [rRAMG], a
    jr .call_hl_to_decimal_digits

.read_record_buffer_data:
    ld a, [wRecordBufferData]
    ld l, a
    ld h, $00

.call_hl_to_decimal_digits:
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $9e
    call WriteDecimalDigitTiles
    ld hl, $1202
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ret

; Redraws the cost of the selected skill after the cursor moved up or down: runs
; ShowSelectedSkillNameAndCost, then copies the three digit tiles it left at wWindowTileBuffer + $9E
; to vBGMap0 + $206 (BG row 16, column 6). Called by ForgetSkillMenu_Cursor. (C1, E-0380)
; runs ShowSelectedSkillNameAndCost, then writes the three bytes at wWindowTileBuffer + $9E to
; vBGMap0 + $206 (E-0122) (E-0340: the address in its name read as its RAM name; was
; ForgetSkillMenu_RedrawSkillCost)
ForgetSkillMenu_RedrawSkillCost::
    call ShowSelectedSkillNameAndCost
    ld hl, vBGMap0 + $206
    ld de, wWindowTileBuffer + $9e
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    ld a, [de]
    call WriteVRAMByte
    ret

; Writes the digit tile $E1 + (wCommandCursor and $0F), the number of the current page of the skill
; list counted from 1, to vBGMap0 + $10F (BG row 8, column 15). Called by ForgetSkillMenu_DrawList
; and ForgetSkillMenu_Cursor. (C1, E-0380)
; writes tile $E1 + (wCommandCursor & $0F) at vBGMap0 + $10F (E-0115)
DrawCommandCursorPageNumber::
    ld a, [wCommandCursor]
    and $0f
    add $e1
    ld hl, vBGMap0 + $10f
    call WriteVRAMByte
    ret

; When the first two bytes of all six sound channel slots (wSoundChannelSlots, wSoundChannel1 to
; wSoundChannel5) are $FF, which presumably means no sound is playing, wBattleEndTimer is
; decremented by 1 (from 0 it wraps to $FF); otherwise nothing changes. Called every frame by
; BattleEnd_GainExperience_RunNewSkillSteps. (C2, E-0380)
; when every sound channel slot flag is $FF (all idle), decrements wBattleEndTimer (E-0121)
CountDownBattleEndTimerWhenSoundIdle::
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannelSlots + $1
    and [hl]
    ld hl, wSoundChannel1
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel2
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel3
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel4
    and [hl]
    inc hl
    and [hl]
    ld hl, wSoundChannel5
    and [hl]
    inc hl
    and [hl]
    cp $ff
    ret nz
    ld a, [wBattleEndTimer]
    dec a
    ld [wBattleEndTimer], a
    ret nz
    ret

; On a Game Boy Color (wIsCGB non-zero) clears the tile attributes of the visible 20 x 18 BG map to
; 0: switches VRAM to bank 1 (rVBK), writes 0 through WriteVRAMByteInc to 20 bytes of each of 18
; rows of vBGMap0 (rows 32 bytes apart) and switches back to bank 0. On any model it then fills the
; $240 bytes of wScreenTileBuffer with $C3, the blank tile. Called when a battle screen is rebuilt:
; BuildBattleScreenBuffer, BuildBattleMenuScreen, GameMode4_Init_BuildBattleScreen,
; BattleEnd_OfferJoin_Start, GameMode7_Init_DrawScreen and ForgetSkillMenu_Start. (C1, E-0380)
; on CGB writes 0 to the 20 x 18 visible attributes of vBGMap0 in VRAM bank 1 (rows 32 apart,
; WriteVRAMByteInc); then fills the $240 bytes of wScreenTileBuffer with $C3; what follows is not
; read (E-0110)
ClearAttributesAndScreenBuffer_Bank31::
    ld a, [wIsCGB]
    or a
    jr z, .skip
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $1412

.loop:
    push bc
    push hl

.loop2:
    xor a
    call WriteVRAMByteInc
    dec b
    jr nz, .loop2
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, .loop
    ld a, $00
    ldh [rVBK], a

.skip:
    ld hl, wScreenTileBuffer
    ld bc, $0240

.loop3:
    ld a, $c3
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop3
    ret

; Fills the $160 bytes from wScreenTileBuffer + $E0 (BG row 7 onward) with $C3, the blank tile; A,
; BC and HL are changed. Called by the RunBattleSetup menu steps, ForgetSkillMenu_DrawList and
; ClearAndLayoutTileBlocksForBattleFoeCount, which then build their boxes in the cleared area and
; copy it to the BG map. (C2, E-0380)
; Fills the $160 bytes at wScreenTileBuffer + $E0 with $C3; clobbers A, BC, HL (the same 15 bytes
; appear in 2 banks)
FillScreenTileBufferRow11Col4WithC3_Bank31::
    ld hl, wScreenTileBuffer + $e0
    ld bc, $0160

.loop:
    ld a, $c3
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ret

; Draws name glyph tiles for the battle screen: first a string of five $90 glyphs into each of the
; three name tile areas vTiles1 + $500, $550 and $5A0 (CopyGlyphTilesToVRAM), then for each of
; wBattlePartyCount battler records, from record 0 (or record 3, the first of slots 4-6, when
; wLinkRole bit 1 is set), copies its 10-byte BATTLER_NAME into wNameGlyphBuf and draws it into the
; same three areas in order (the 12-byte address table after the routine). (C1, E-0372)
GameMode4_Init_BuildBattleScreen_LoadNameTiles::
    ld a, $90
    ld [wNameGlyphBuf], a
    ld [wNameGlyphBuf + $1], a
    ld [wNameGlyphBuf + $2], a
    ld [wNameGlyphBuf + $3], a
    ld [wNameGlyphBuf + $4], a
    ld a, $f0
    ld [wNameGlyphBuf + $5], a
    ld de, vTiles1 + $500
    call CopyGlyphTilesToVRAM
    ld de, vTiles1 + $550
    call CopyGlyphTilesToVRAM
    ld de, vTiles1 + $5a0
    call CopyGlyphTilesToVRAM
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00
    ld a, [wLinkRole]
    bit 1, a
    jr z, .loop
    ld c, $03

.loop:
    push bc
    ld a, c
    ld bc, $004e
    call Multiply8By16
    ld a, l
    add $d5
    ld l, a
    ld a, h
    adc $d0
    ld h, a
    ld de, wNameGlyphBuf
    ld b, $0a

.loop2:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    pop bc
    push bc
    ld b, $00
    ld hl, BattlerNameTileAddresses
    add hl, bc
    add hl, bc
    ld e, [hl]
    inc hl
    ld d, [hl]
    call CopyGlyphTilesToVRAM
    pop bc
    inc c
    dec b
    jr nz, .loop
    ret

; Six words, the VRAM destinations of the battler name glyphs by battle slot: vTiles1 + $500, + $550
; and + $5A0 for slots 0-2, and the same three for slots 3-5.
; GameMode4_Init_BuildBattleScreen_LoadNameTiles copies each party battler's 10-byte name from
; wBattlerRecords + $4E * slot into wNameGlyphBuf and passes entry C as DE to CopyGlyphTilesToVRAM
; (with wLinkRole bit 1 set it starts at slot 3). (C1, E-0372)
BattlerNameTileAddresses::
    db $00, $8d, $50, $8d, $a0, $8d, $00, $8d, $50, $8d, $a0, $8d

; Builds the frame of the party panels in wScreenTileBuffer: takes record wBattlePartyCount - 1 of
; PartyCountRects (1 to 3 monsters: 8, 14 or 20 tiles wide, 7 rows, at offset 0), reads its header
; with ReadScreenBufferRectHeader_Bank31 and copies the tiles with CopyRectToStride32_Bank31 (rows
; 32 bytes apart). wBattlePartyCount must be 1 to 3. Called by the battle screen builders
; (BuildBattleScreenBuffer, BuildBattleMenuScreen, GameMode4_Init_BuildBattleScreen,
; BattleEnd_OfferJoin_Start) and ForgetSkillMenu_Start. (C2, E-0380)
; picks record wBattlePartyCount - 1 from PartyCountRects and copies it into wScreenTileBuffer
; (ReadScreenBufferRectHeader_Bank31, CopyRectToStride32_Bank31) (E-0078)
CopyRectRecordForBattlePartyCount_Bank31::
    ld a, [wBattlePartyCount]
    dec a
    ld hl, PartyCountRects
    add a
    add_a_to_hl
    deref_hl
    call ReadScreenBufferRectHeader_Bank31
    call CopyRectToStride32_Bank31
    ret

; CopyRectRecordForBattlePartyCount_Bank31 reads word wBattlePartyCount - 1 of $72C3 and copies that
; record into wScreenTileBuffer (ReadScreenBufferRectHeader_Bank31, CopyRectToStride32_Bank31);
; three records, for 1-3 party monsters (E-0221, C1)
; record: rectangle record for this party count
PartyCountRects::
    dw TileRect_PartyCountRects_1 ; id 1
    dw TileRect_PartyCountRects_2 ; id 2
    dw TileRect_PartyCountRects_3 ; id 3

; Fills the screen buffer from wScreenTileBuffer + $E0 with $C3
; (FillScreenTileBufferRow11Col4WithC3_Bank31), then falls into LayoutTileBlocksForBattleFoeCount to
; lay out the foe picture blocks. Called by the RunBattleSetup_BankA0 menu steps. (C2, E-0380)
; FillScreenTileBufferRow11Col4WithC3_Bank31, then falls into LayoutTileBlocksForBattleFoeCount
; (E-0071)
ClearAndLayoutTileBlocksForBattleFoeCount::
    call FillScreenTileBufferRow11Col4WithC3_Bank31

; wBattleFoeCount = 1 to 3: writes that many 6 x 6 blocks of consecutive tile numbers into the
; screen buffer, the first block starting at tile $14 and each block using 36 numbers, rows 32 bytes
; apart. The left column inside the buffer from wScreenTileBuffer + $E0 is 7 for one block, 4 and 10
; for two, 1, 7 and 13 for three (centred in 20 columns). D ends at $14 + 36 * wBattleFoeCount; A,
; BC and HL are changed. The block addresses come from the two small tables
; LayoutTileBlocksForBattleFoeCount_Data1 and LayoutTileBlocksForBattleFoeCount_Data2. Called by the
; battle screen builders and every RunBattleSetup menu step that redraws the foes. (C2, E-0380)
; wBattleFoeCount = count 1-3: writes that many 6 x 6 blocks of consecutive tile numbers, starting
; at $14 ($24 per block), into the 32-byte-wide buffer at wScreenTileBuffer + $E0 (row 0); left
; columns are 7 for one block, 4 and 10 for two, 1, 7 and 13 for three (centred in a 20-column
; view). Clobbers A, BC, D, HL (E-0060)
LayoutTileBlocksForBattleFoeCount::
    ld d, $14
    ld a, [wBattleFoeCount]
    dec a
    ld hl, LayoutTileBlocksForBattleFoeCount_Data1
    add a
    add_a_to_hl
    call LayoutTileBlocksForBattleFoeCount_TableBlock
    ld a, [wBattleFoeCount]
    cp $01
    jr z, LayoutTileBlocksForBattleFoeCount_Done
    dec a
    dec a
    ld hl, LayoutTileBlocksForBattleFoeCount_Data2
    add a
    add_a_to_hl
    call LayoutTileBlocksForBattleFoeCount_TableBlock
    ld a, [wBattleFoeCount]
    cp $03
    jr nz, LayoutTileBlocksForBattleFoeCount_Done
    ld hl, wScreenTileBuffer + $ed
    jr LayoutTileBlocksForBattleFoeCount_WriteBlock

; HL = the address held in the word at HL (deref_hl), then falls into the block writer (see
; LayoutTileBlocksForBattleFoeCount_WriteBlock) to write one 6 x 6 block of tile numbers from D
; there. LayoutTileBlocksForBattleFoeCount calls it for the first block (address from its first
; table) and the second (from its second table). (C2, E-0380)
; HL = the word at HL (deref_hl), falling into the next code
LayoutTileBlocksForBattleFoeCount_TableBlock::
    deref_hl

; Writes one 6 x 6 block of consecutive tile numbers from D (D ends 36 higher) at HL, rows 32 bytes
; apart, then falls into LayoutTileBlocksForBattleFoeCount_Done.
; LayoutTileBlocksForBattleFoeCount_TableBlock falls into it for the first two blocks, and the third
; block jumps here with HL = wScreenTileBuffer + $ED. (C2, E-0372; probed E-0380)
LayoutTileBlocksForBattleFoeCount_WriteBlock::
    ld bc, $0606

.loop:
    push bc
    push hl

.loop2:
    ld a, d
    inc d
    ld [hli], a
    dec b
    jr nz, .loop2
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, .loop

; The shared ret of LayoutTileBlocksForBattleFoeCount: reached after the last block is written, and
; jumped to when wBattleFoeCount is 1 (after one block) or 2 (after two). (C2, E-0372; probed
; E-0380)
LayoutTileBlocksForBattleFoeCount_Done::
    ret

; data read by LayoutTileBlocksForBattleFoeCount (6 bytes) (E-0347)
LayoutTileBlocksForBattleFoeCount_Data1::
    db $7f, $c2, $7c, $c2, $79, $c2

LayoutTileBlocksForBattleFoeCount_Data2::
    db $82, $c2, $7f, $c2

; On a Game Boy Color only (returns at once when wIsCGB is 0): loads the colour attributes of the
; foe pictures. The ids are the words at wBattlePictureIds, or at wBattleMonsterId when wLinkRole
; bit 1 is set. By wBattleFoeCount it calls LoadMonsterPictureAttributesFromDE once for one foe
; (palette 1 at vBGMap0 + $E7), twice for two (palettes 1 and 3 at + $E4 and + $EA) and otherwise
; three times (palettes 1, 3 and 5 at + $E1, + $E7 and + $ED), taking the next id with DE + 2. The
; block positions match the columns of the foe blocks (see LayoutTileBlocksForBattleFoeCount).
; Called by the battle screen builders and BattleEnd_OfferJoin_DrawThenAskToJoin_LoadPicture. (C1,
; E-0380)
; on CGB loads the picture attribute blocks for one, two or three battle monsters
; (wBattlePictureIds, or wBattleMonsterId when bit 1 of wLinkRole is set) at vBGMap0 + $E1-$ED
; (E-0125)
LoadBattleMonsterPictureAttributes::
    ld a, [wIsCGB]
    or a
    ret z
    ld a, [wLinkRole]
    bit 1, a
    ld de, wBattlePictureIds
    jr z, .check_battle_foe_count
    ld de, wBattleMonsterId

.check_battle_foe_count:
    ld a, [wBattleFoeCount]
    cp $01
    jr z, .call_load_monster_picture_attributes_from_de
    cp $02
    jr z, .call_load_monster_picture_attributes_from_de2
    jr .call_load_monster_picture_attributes_from_de3

.call_load_monster_picture_attributes_from_de:
    ld c, $01
    ld hl, vBGMap0 + $e7
    call LoadMonsterPictureAttributesFromDE
    ret

.call_load_monster_picture_attributes_from_de2:
    ld c, $01
    ld hl, vBGMap0 + $e4
    call LoadMonsterPictureAttributesFromDE
    ld c, $03
    inc de
    inc de
    ld hl, vBGMap0 + $ea
    call LoadMonsterPictureAttributesFromDE
    ret

.call_load_monster_picture_attributes_from_de3:
    ld c, $01
    ld hl, vBGMap0 + $e1
    call LoadMonsterPictureAttributesFromDE
    ld c, $03
    inc de
    inc de
    ld hl, vBGMap0 + $e7
    call LoadMonsterPictureAttributesFromDE
    ld c, $05
    inc de
    inc de
    ld hl, vBGMap0 + $ed
    call LoadMonsterPictureAttributesFromDE
    ret

; DE = address of a monster id word, C = palette number, HL = BG map address: stores C in hTemp0,
; reads the id word at [DE] and calls LoadMonsterPictureAttributes, which writes that picture 6 x 6
; colour attribute bytes (plus the palette number) to VRAM bank 1 at HL. DE is kept as it came.
; Called only by LoadBattleMonsterPictureAttributes. (C1, E-0380)
; hTemp0 = C (palette number), DE = the monster id word stored at [DE], then
; LoadMonsterPictureAttributes (HL = BG map address from the caller); DE kept (E-0110)
LoadMonsterPictureAttributesFromDE::
    push de
    ld a, c
    ldh [hTemp0], a
    ld a, [de]
    push af
    inc de
    ld a, [de]
    ld d, a
    pop af
    ld e, a
    call LoadMonsterPictureAttributes
    pop de
    ret

; Draws the HP, MP and status (or level) of the first one, two or three party slots into
; wScreenTileBuffer, by wBattlePartyCount: slot 0 (DrawSlotPanelStats0) always, slot 1
; (DrawSlotPanelStats1) unless the count is 1, slot 2 (DrawSlotPanelStats2) unless it is 1 or 2.
; Called by the battle screen builders (BuildBattleScreenBuffer, BuildBattleMenuScreen,
; GameMode4_Init_BuildBattleScreen, BattleEnd_OfferJoin_Start) and ForgetSkillMenu_Start. (C2,
; E-0380)
; draws the HP, MP and status of the first one, two or three slots (by wBattlePartyCount) (E-0122)
DrawPartySlotStatusPanels::
    call DrawSlotPanelStats0
    ld a, [wBattlePartyCount]
    cp $01
    ret z
    call DrawSlotPanelStats1
    ld a, [wBattlePartyCount]
    cp $02
    ret z
    call DrawSlotPanelStats2
    ret

; Draws the HP digits, MP digits and status marks (or level) of party slot 0 into wScreenTileBuffer:
; C = 0, or 4 when wLinkMode is neither 0 nor 2 and wLinkRole bit 1 is set (the far side of a link
; battle), then calls DrawSlotHPDigits, DrawSlotMPDigits and DrawSlotStatusMarks. Called by
; DrawPartySlotStatusPanels. (C2, E-0380)
; draws HP, MP and status marks of slot 0 (slot 4 when wLinkMode is 1 and bit 1 of wLinkRole is set)
; (E-0122)
DrawSlotPanelStats0::
    ld c, $00
    ld a, [wLinkMode]
    or a
    jr z, .call_draw_slot_hp_digits
    cp $02
    jr z, .call_draw_slot_hp_digits
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_draw_slot_hp_digits
    ld c, $04

.call_draw_slot_hp_digits:
    call DrawSlotHPDigits
    call DrawSlotMPDigits
    call DrawSlotStatusMarks
    ret

; Draws the HP digits, MP digits and status marks (or level) of party slot 1 into wScreenTileBuffer:
; C = 1, or 5 when wLinkMode is neither 0 nor 2 and wLinkRole bit 1 is set (the far side of a link
; battle), then calls DrawSlotHPDigits, DrawSlotMPDigits and DrawSlotStatusMarks. Called by
; DrawPartySlotStatusPanels. (C2, E-0380)
; draws HP, MP and status marks of slot 1 (slot 5 when wLinkMode is 1 and bit 1 of wLinkRole is set)
; (E-0122)
DrawSlotPanelStats1::
    ld c, $01
    ld a, [wLinkMode]
    or a
    jr z, .call_draw_slot_hp_digits
    cp $02
    jr z, .call_draw_slot_hp_digits
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_draw_slot_hp_digits
    ld c, $05

.call_draw_slot_hp_digits:
    call DrawSlotHPDigits
    call DrawSlotMPDigits
    call DrawSlotStatusMarks
    ret

; Draws the HP digits, MP digits and status marks (or level) of party slot 2 into wScreenTileBuffer:
; C = 2, or 6 when wLinkMode is neither 0 nor 2 and wLinkRole bit 1 is set (the far side of a link
; battle), then calls DrawSlotHPDigits, DrawSlotMPDigits and DrawSlotStatusMarks. Called by
; DrawPartySlotStatusPanels. (C2, E-0380)
; draws HP, MP and status marks of slot 2 (slot 6 when wLinkMode is 1 and bit 1 of wLinkRole is set)
; (E-0122)
DrawSlotPanelStats2::
    ld c, $02
    ld a, [wLinkMode]
    or a
    jr z, .call_draw_slot_hp_digits
    cp $02
    jr z, .call_draw_slot_hp_digits
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_draw_slot_hp_digits
    ld c, $06

.call_draw_slot_hp_digits:
    call DrawSlotHPDigits
    call DrawSlotMPDigits
    call DrawSlotStatusMarks
    ret

; Copies the panels of the first one, two or three party slots (by wBattlePartyCount, like
; DrawPartySlotStatusPanels) from the screen buffer to the BG map: CopySlotPanel0ToVRAM always,
; CopySlotPanel1ToVRAM unless the count is 1, CopySlotPanel2ToVRAM unless it is 1 or 2. No caller
; was found in src/. (C1, E-0380)
; copies the panels of the first one, two or three slots (by wBattlePartyCount) to VRAM (E-0122)
CopyPartySlotPanelsToVRAM::
    call CopySlotPanel0ToVRAM
    ld a, [wBattlePartyCount]
    cp $01
    ret z
    call CopySlotPanel1ToVRAM
    ld a, [wBattlePartyCount]
    cp $02
    ret z
    call CopySlotPanel2ToVRAM
    ret

; Copies the panel of party slot 0 from the screen buffer to the BG map: C = 0, or 4 when wLinkMode
; is neither 0 nor 2 and wLinkRole bit 1 is set, then CopySlotHPDigitsPanelToVRAM (the HP digit
; tiles), CopySlotMPDigitsPanelToVRAM (the MP digit tiles) and CopySlotPanelRowToVRAM (the five-tile
; level and status row). Called by CopyPartySlotPanelsToVRAM. (C1, E-0380)
; builds and copies the panel row of slot 0 (slot 4 when wLinkMode is 1 and bit 1 of wLinkRole is
; set) (E-0122)
CopySlotPanel0ToVRAM::
    ld c, $00
    ld a, [wLinkMode]
    or a
    jr z, .call_copy_slot_hp_digits_panel_to_vram
    cp $02
    jr z, .call_copy_slot_hp_digits_panel_to_vram
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_copy_slot_hp_digits_panel_to_vram
    ld c, $04

.call_copy_slot_hp_digits_panel_to_vram:
    call CopySlotHPDigitsPanelToVRAM
    call CopySlotMPDigitsPanelToVRAM
    call CopySlotPanelRowToVRAM
    ret

; Copies the panel of party slot 1 from the screen buffer to the BG map: C = 1, or 5 when wLinkMode
; is neither 0 nor 2 and wLinkRole bit 1 is set, then CopySlotHPDigitsPanelToVRAM (the HP digit
; tiles), CopySlotMPDigitsPanelToVRAM (the MP digit tiles) and CopySlotPanelRowToVRAM (the five-tile
; level and status row). Called by CopyPartySlotPanelsToVRAM. (C1, E-0380)
; builds and copies the panel row of slot 1 (slot 5 when wLinkMode is 1 and bit 1 of wLinkRole is
; set) (E-0122)
CopySlotPanel1ToVRAM::
    ld c, $01
    ld a, [wLinkMode]
    or a
    jr z, .call_copy_slot_hp_digits_panel_to_vram
    cp $02
    jr z, .call_copy_slot_hp_digits_panel_to_vram
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_copy_slot_hp_digits_panel_to_vram
    ld c, $05

.call_copy_slot_hp_digits_panel_to_vram:
    call CopySlotHPDigitsPanelToVRAM
    call CopySlotMPDigitsPanelToVRAM
    call CopySlotPanelRowToVRAM
    ret

; Copies the panel of party slot 2 from the screen buffer to the BG map: C = 2, or 6 when wLinkMode
; is neither 0 nor 2 and wLinkRole bit 1 is set, then CopySlotHPDigitsPanelToVRAM (the HP digit
; tiles), CopySlotMPDigitsPanelToVRAM (the MP digit tiles) and CopySlotPanelRowToVRAM (the five-tile
; level and status row). Called by CopyPartySlotPanelsToVRAM. (C1, E-0380)
; builds and copies the panel row of slot 2 (slot 6 when wLinkMode is 1 and bit 1 of wLinkRole is
; set) (E-0122)
CopySlotPanel2ToVRAM::
    ld c, $02
    ld a, [wLinkMode]
    or a
    jr z, .call_copy_slot_hp_digits_panel_to_vram
    cp $02
    jr z, .call_copy_slot_hp_digits_panel_to_vram
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_copy_slot_hp_digits_panel_to_vram
    ld c, $06

.call_copy_slot_hp_digits_panel_to_vram:
    call CopySlotHPDigitsPanelToVRAM
    call CopySlotMPDigitsPanelToVRAM
    call CopySlotPanelRowToVRAM
    ret

; Blanks the text window tiles (FillTilesFromRequest: wTextWindowWidth passes of wTextWindowRows
; tiles at wTextWindowTileLo/Hi) and far-calls CopyRectRecordToScreenBuffer in bank $1A, which
; builds the 20 x 5 message box at wScreenTileBuffer + $1A0 (BG row 13). Called by the battle screen
; builders and by the steps that show a message (BattlePhase0_DrawScreen, BattleEnd_DrawScreen,
; RunBattleSetup_MainMenu_ShowMessage, RunBattleSetup_PlanMenu_ClearForNoSkills and others). (C1,
; E-0380)
; FillTilesFromRequest, then far-calls CopyRectRecordToScreenBuffer (E-0119) (E-0344: the address in
; its name dropped or read as the label there; was ClearWindowAndCopyRectFar)
ClearWindowAndCopyRectFar::
    call FillTilesFromRequest
    farcall CopyRectRecordToScreenBuffer
    ret

; Copies the 20 x 5 message box at wWindowTileBuffer + $38 (the same bytes as wScreenTileBuffer +
; $1A0, built by CopyRectRecordToScreenBuffer) to vBGMap0 + $1A0 (BG row 13) with
; CopyRect32StrideToVRAM. Called by the steps that show a message, for example
; RunBattleSetup_MainMenu_ShowMessage, RunBattleSetup_PlanMenu_ShowMessage and
; RunBattleSetup_ItemMenu_DrawMessageWindow. (C1, E-0380)
; copies a 20 x 5 rectangle from wWindowTileBuffer + $38 (rows 32 bytes apart) to vBGMap0 + $1A0
; (row 13) with CopyRect32StrideToVRAM (E-0073) (E-0340: the address in its name read as its RAM
; name; was CopyMessageBoxToBGMapRow13)
CopyMessageBoxToBGMapRow13::
    ld de, wWindowTileBuffer + $38
    ld hl, vBGMap0 + $1a0
    lb bc, $14, $05
    call CopyRect32StrideToVRAM
    ret

; Builds the battle main menu's window in the screen buffer (far-calls
; CopyRectRecordToScreenBuffer_2 in bank $1A) and falls into RunBattleSetup_MainMenu_DrawMenuWindow,
; which copies it to the BG map. Called by RunBattleSetup_MainMenu_Draw and
; RunBattleSetup_MainMenu_RedrawWindow. (C1, E-0372)
RunBattleSetup_MainMenu_BuildMenuWindow::
    farcall CopyRectRecordToScreenBuffer_2

; Copies the 14 x 5 menu window at wWindowTileBuffer + $38 (rows 32 bytes apart) to vBGMap0 + $1A0
; (row 13) with CopyRect32StrideToVRAM. Called by RunBattleSetup_MainMenu_DrawCursor and
; RunBattleSetup_MainMenu_CopyMenuWindow, and reached from RunBattleSetup_MainMenu_BuildMenuWindow.
; (C1, E-0372)
RunBattleSetup_MainMenu_DrawMenuWindow::
    ld de, wWindowTileBuffer + $38
    ld hl, vBGMap0 + $1a0
    lb bc, $0e, $05
    call CopyRect32StrideToVRAM
    ret

; Far-calls CopyRectRecordToScreenBuffer_3 (bank $1A), which copies the tile record of a 12 x 11 box
; at wScreenTileBuffer + $E0 (BG row 7) into the screen buffer, rows 32 bytes apart; the rest of the
; buffer is not touched. Called by RunBattleSetup_PlanMenu_DrawTactics. (C2, E-0380)
; far-calls CopyRectRecordToScreenBuffer_3 in bank $1A (E-0115) (E-0344: the address in its name
; dropped or read as the label there; was RunBattleSetup_PlanMenu_DrawTactics_BuildBox)
RunBattleSetup_PlanMenu_DrawTactics_BuildBox::
    farcall CopyRectRecordToScreenBuffer_3
    ret

; Copies a 12 x 11 rectangle from wScreenTileBuffer + $E0 to vBGMap0 + $E0 (BG row 7, column 0) with
; CopyRect32StrideToVRAM. Called by RunBattleSetup_MainMenu_YesNoCursor,
; RunBattleSetup_PlanMenu_ShowTacticCursor, RunBattleSetup_PlanMenu_BackToMainMenu and
; RunBattleSetup_PlanMenu_DrawActions. (C1, E-0380)
; copies a 12 x 11 rectangle from wScreenTileBuffer + $E0 (rows 32 bytes apart) to vBGMap0 + $E0
; (row 7) with CopyRect32StrideToVRAM (E-0110) (E-0340: the address in its name read as its RAM
; name; was CopyScreenBufferRect12x11ToBGMapRow7)
CopyScreenBufferRect12x11ToBGMapRow7::
    ld de, wScreenTileBuffer + $e0
    ld hl, vBGMap0 + $e0
    lb bc, $0c, $0b
    call CopyRect32StrideToVRAM
    ret

; Far-calls CopyRectRecordToScreenBuffer_5 (bank $1A), which copies the tile record of an 8 x 9 box
; at wScreenTileBuffer + $120 (BG row 9) into the screen buffer, rows 32 bytes apart; the rest of
; the buffer is not touched. Called by RunBattleSetup_PlanMenu_DrawActions. (C2, E-0380)
; far-calls CopyRectRecordToScreenBuffer_5 in bank $1A (E-0115) (E-0344: the address in its name
; dropped or read as the label there; was RunBattleSetup_PlanMenu_DrawActions_BuildBox)
RunBattleSetup_PlanMenu_DrawActions_BuildBox::
    farcall CopyRectRecordToScreenBuffer_5
    ret

; Copies an 8 x 9 rectangle from wScreenTileBuffer + $120 to vBGMap0 + $120 (BG row 9, column 0)
; with CopyRect32StrideToVRAM; it has the same code as RunBattleSetup_CopyLeftBoxToBGMap. This copy
; is called only by PLAN menu steps: RunBattleSetup_PlanMenu_ShowActionCursor,
; RunBattleSetup_PlanMenu_AfterAction, RunBattleSetup_PlanMenu_ClearForNoSkills,
; RunBattleSetup_PlanMenu_DrawFightFoeList and RunBattleSetup_PlanMenu_DrawSkillList. (C1, E-0380)
; copies an 8 x 9 rectangle from wScreenTileBuffer + $120 (rows 32 bytes apart) to vBGMap0 + $120
; (row 9, column 0) with CopyRect32StrideToVRAM (identical to RunBattleSetup_CopyLeftBoxToBGMap at
; $74E1) (E-0078) (E-0340: the address in its name read as its RAM name; was
; RunBattleSetup_PlanMenu_CopyLeftBoxToBGMap) (E-0344: the address in its name dropped or read as
; the label there; was RunBattleSetup_PlanMenu_CopyLeftBoxToBGMap)
RunBattleSetup_PlanMenu_CopyLeftBoxToBGMap::
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    lb bc, $08, $09
    call CopyRect32StrideToVRAM
    ret

; Far-calls CopyRectRecordToScreenBuffer_7 (bank $1A), which copies the tile record of a 12 x 9 box
; at wScreenTileBuffer + $120 (BG row 9) into the screen buffer, rows 32 bytes apart; the rest of
; the buffer is not touched. Called by RunBattleSetup_ItemMenu_DrawBagPage. (C2, E-0380)
; far-calls CopyRectRecordToScreenBuffer_7 in bank $1A (E-0115) (E-0344: the address in its name
; dropped or read as the label there; was RunBattleSetup_ItemMenu_DrawBagPage_BuildBox)
RunBattleSetup_ItemMenu_DrawBagPage_BuildBox::
    farcall CopyRectRecordToScreenBuffer_7
    ret

; Copies a 20 x 9 rectangle from wScreenTileBuffer + $120 to vBGMap0 + $120 (BG rows 9 to 17) with
; CopyRect32StrideToVRAM, then sets wBattleArg0 to 1. Called by the ITEM menu steps
; RunBattleSetup_ItemMenu_DrawList, RunBattleSetup_ItemMenu_ChooseItem,
; RunBattleSetup_ItemMenu_BackToMainMenu, RunBattleSetup_ItemMenu_DrawSideWindow and
; RunBattleSetup_ItemMenu_ClearForMessage. (C1, E-0380)
; copies a 20 x 9 rectangle from wScreenTileBuffer + $120 (rows 32 bytes apart) to vBGMap0 + $120
; (row 9) with CopyRect32StrideToVRAM, then wBattleArg0 = 1 (E-0077) (E-0340: the address in its
; name read as its RAM name; was CopyScreenBufferRect20x9ToBGMapRow9)
CopyScreenBufferRect20x9ToBGMapRow9::
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    lb bc, $14, $09
    call CopyRect32StrideToVRAM
    ld a, $01
    ld [wBattleArg0], a
    ret

; Far-calls CopyRectRecordToScreenBuffer_8 (bank $1A), which copies the tile record of an 8 x 9 box
; at wScreenTileBuffer + $120 (BG row 9) into the screen buffer, rows 32 bytes apart; the rest of
; the buffer is not touched. Called by RunBattleSetup_DrawAllyList. (C2, E-0380)
; far-calls CopyRectRecordToScreenBuffer_8 in bank $1A (E-0115) (E-0344: the address in its name
; dropped or read as the label there; was RunBattleSetup_DrawAllyList_BuildBox)
RunBattleSetup_DrawAllyList_BuildBox::
    farcall CopyRectRecordToScreenBuffer_8
    ret

; Copies an 8 x 9 rectangle from wScreenTileBuffer + $120 to vBGMap0 + $120 (BG row 9, column 0)
; with CopyRect32StrideToVRAM; same code as RunBattleSetup_PlanMenu_CopyLeftBoxToBGMap. This copy is
; called by the ally cursor steps of both menus (RunBattleSetup_PlanMenu_ShowAllyCursor,
; RunBattleSetup_PlanMenu_ReturnFromAllyList, RunBattleSetup_ItemMenu_ShowAllyCursor,
; RunBattleSetup_ItemMenu_AfterAllyTarget and RunBattleSetup_ItemMenu_AfterFoeTarget). (C1, E-0380)
; copies an 8 x 9 rectangle from wScreenTileBuffer + $120 (rows 32 bytes apart) to vBGMap0 + $120
; (row 9, column 0) with CopyRect32StrideToVRAM (E-0078) (E-0340: the address in its name read as
; its RAM name; was RunBattleSetup_CopyLeftBoxToBGMap)
RunBattleSetup_CopyLeftBoxToBGMap::
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    lb bc, $08, $09
    call CopyRect32StrideToVRAM
    ret

; Far-calls CopyRectRecordToScreenBuffer_9 (bank $1A), which copies the tile record of an 8 x 7 box
; at wScreenTileBuffer + $160 (BG row 11) into the screen buffer, rows 32 bytes apart; the rest of
; the buffer is not touched. Called by RunBattleSetup_ItemMenu_DrawSideWindow. (C2, E-0380)
; far-calls CopyRectRecordToScreenBuffer_9 in bank $1A (E-0115) (E-0344: the address in its name
; dropped or read as the label there; was RunBattleSetup_ItemMenu_DrawSideWindow_BuildBox)
RunBattleSetup_ItemMenu_DrawSideWindow_BuildBox::
    farcall CopyRectRecordToScreenBuffer_9
    ret

; Copies an 8 x 7 rectangle from wScreenTileBuffer + $160 to vBGMap0 + $160 (BG row 11, column 0)
; with CopyRect32StrideToVRAM. Called by RunBattleSetup_ItemMenu_ShowSideCursor and
; RunBattleSetup_ItemMenu_AfterSide. (C1, E-0380)
; copies an 8 x 7 rectangle from wScreenTileBuffer + $160 to vBGMap0 + $160 (row 11) with
; CopyRect32StrideToVRAM (E-0115) (E-0340: the address in its name read as its RAM name; was
; CopyScreenBufferRect8x7ToBGMapRow11)
CopyScreenBufferRect8x7ToBGMapRow11::
    ld de, wScreenTileBuffer + $160
    ld hl, vBGMap0 + $160
    lb bc, $08, $07
    call CopyRect32StrideToVRAM
    ret

; Far-calls CopyRectRecordsAndToScreenBuffer (bank $1A), which copies two tile records into the
; screen buffer: a 12 x 9 box at wScreenTileBuffer + $120 (BG row 9) and an 8 x 3 box at
; wScreenTileBuffer + $1CC (BG row 14, column 12); nothing else changes. Called by
; RunBattleSetup_PlanMenu_DrawSkillList. (C2, E-0380)
; far-calls CopyRectRecordsAndToScreenBuffer in bank $1A (E-0115) (E-0344: the address in its name
; dropped or read as the label there; was RunBattleSetup_PlanMenu_DrawSkillList_BuildBoxes)
RunBattleSetup_PlanMenu_DrawSkillList_BuildBoxes::
    farcall CopyRectRecordsAndToScreenBuffer
    ret

; Copies two rectangles of wScreenTileBuffer (32-byte rows) to the same places of vBGMap0 with
; CopyRect32StrideToVRAM: 7 x 1 tiles at offset $10C (row 8, column 12) and 20 x 9 tiles at offset
; $120 (rows 9-17). Used by four PLAN menu steps: RunBattleSetup_PlanMenu_ChooseAlly,
; RunBattleSetup_PlanMenu_ClearForSkillMessage, RunBattleSetup_PlanMenu_ReturnToStep and
; RunBattleSetup_PlanMenu_ShowSkillCursor. (C1, E-0372)
; copies a 7 x 1 rectangle from wScreenTileBuffer + $10C to vBGMap0 + $10C (row 8, column 12) and a
; 20 x 9 rectangle from wScreenTileBuffer + $120 to vBGMap0 + $120 (row 9), both with
; CopyRect32StrideToVRAM (E-0110) (E-0340: the address in its name read as its RAM name; was
; RunBattleSetup_PlanMenu_RedrawLowerRows)
RunBattleSetup_PlanMenu_RedrawLowerRows::
    ld de, wScreenTileBuffer + $10c
    ld hl, vBGMap0 + $10c
    lb bc, $07, $01
    call CopyRect32StrideToVRAM
    ld de, wScreenTileBuffer + $120
    ld hl, vBGMap0 + $120
    lb bc, $14, $09
    call CopyRect32StrideToVRAM
    ret

; Far-calls CopyRectRecordToScreenBuffer_10 (bank $1A), which copies the tile record of a 14 x 7 box
; at wScreenTileBuffer + $160 (BG row 11) into the screen buffer, rows 32 bytes apart; the rest of
; the buffer is not touched. Called by RunBattleSetup_PlanMenu_DrawFightFoeList,
; RunBattleSetup_PlanMenu_DrawFoeList and RunBattleSetup_ItemMenu_DrawFoeList. (C2, E-0380)
; far-calls CopyRectRecordToScreenBuffer_10 in bank $1A (E-0115) (E-0344: the address in its name
; dropped or read as the label there; was RunBattleSetup_DrawFoeList_BuildBox)
RunBattleSetup_DrawFoeList_BuildBox::
    farcall CopyRectRecordToScreenBuffer_10
    ret

; Copies a 14 x 7 rectangle from wScreenTileBuffer + $160 to vBGMap0 + $160 (BG row 11, column 0)
; with CopyRect32StrideToVRAM. Called by the foe cursor steps of the PLAN and ITEM menus
; (RunBattleSetup_PlanMenu_ShowFoeCursor, RunBattleSetup_PlanMenu_AfterFoeTarget,
; RunBattleSetup_PlanMenu_ShowSkillFoeCursor, RunBattleSetup_PlanMenu_ReturnFromFoeList and
; RunBattleSetup_ItemMenu_ShowFoeCursor). (C1, E-0380)
; copies a 14 x 7 rectangle from wScreenTileBuffer + $160 (rows 32 bytes apart) to vBGMap0 + $160
; (row 11) with CopyRect32StrideToVRAM (E-0078) (E-0340: the address in its name read as its RAM
; name; was CopyScreenBufferRect14x7ToBGMapRow11)
CopyScreenBufferRect14x7ToBGMapRow11::
    ld de, wScreenTileBuffer + $160
    ld hl, vBGMap0 + $160
    lb bc, $0e, $07
    call CopyRect32StrideToVRAM
    ret

; Copies a 20 x 11 rectangle from wScreenTileBuffer + $E0 to vBGMap0 + $E0 (BG rows 7 to 17) by
; loading DE, HL and BC and falling into CopyRect32StrideToVRAM. Called by the screen drawing steps
; BattlePhase0_DrawScreen, BattleEnd_DrawScreen, RunBattleSetup_MainMenu_Draw,
; RunBattleSetup_ItemMenu_DrawBagPage, RunBattleSetup_MarkSlotsToAct, ForgetSkillMenu_DrawList and
; the RunBattleSetup_BankA0 menu steps. (C1, E-0380)
; copies a 20 x 11 rectangle from wScreenTileBuffer + $E0 (rows 32 bytes apart) to vBGMap0 + $E0
; (row 7), falling into CopyRect32StrideToVRAM (E-0075) (E-0340: the address in its name read as its
; RAM name; was CopyScreenBufferRect20x11ToBGMapRow7)
CopyScreenBufferRect20x11ToBGMapRow7::
    ld de, wScreenTileBuffer + $e0
    ld hl, vBGMap0 + $e0
    lb bc, $14, $0b

; B = width, C = rows, DE = source with rows 32 bytes apart, HL = BG map address (rows 32 bytes
; apart): copies the B x C rectangle to VRAM with WriteVRAMByteInc, which waits until the video chip
; allows a write. DE ends 32 * C past its start, HL at the start of the row below the last one, B is
; kept and C = 0. The shared tail of all the screen buffer to BG map copy routines of this bank.
; (C1, E-0380)
; B = width, C = rows, DE = source with 32-byte rows, HL = VRAM address with 32-byte rows: copies a
; B x C rectangle with WriteVRAMByteInc. DE ends 32 * C past its start and HL at the start of the
; row below; B kept, C = 0 (E-0060)
CopyRect32StrideToVRAM::
    push bc
    push hl

.loop:
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, .loop
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    ld a, $20
    sub b
    add e
    ld e, a
    jr nc, .next
    inc d

.next:
    dec c
    jr nz, CopyRect32StrideToVRAM
    ret

; HL = address of a 4-byte rectangle header (word offset, width, rows): returns HL =
; wScreenTileBuffer + offset, B = width, C = rows and DE = the byte after the header, where the
; tiles start. Used by CopyRectRecordForBattlePartyCount_Bank31. (C2, E-0380)
; reads a 4-byte header at HL (word offset, width, rows): returns HL = wScreenTileBuffer + offset, B
; = width, C = rows, DE = the byte after the header (E-0065) (the same 15 bytes appear in 2 banks)
ReadScreenBufferRectHeader_Bank31::
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld c, [hl]
    inc hl
    push hl
    ld hl, wScreenTileBuffer
    add hl, de
    pop de
    ret

; DE = source tiles with rows packed, HL = destination with rows 32 bytes apart, B = width, C =
; rows: copies the B x C rectangle. DE ends past the source, HL at the start of the row below the
; last one, B is kept and C = 0. Used by CopyRectRecordForBattlePartyCount_Bank31. (C2, E-0380)
; DE = source (rows packed), HL = destination with rows 32 bytes apart, B = width, C = rows: copies
; a B x C rectangle; DE ends past the source, HL at the start of the row below; B kept, C = 0
; (E-0065) (the same 18 bytes appear in 2 banks)
CopyRectToStride32_Bank31::
    push bc
    push hl

.loop:
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, CopyRectToStride32_Bank31
    ret

; a rectangle record of PartyCountRects (offset, width, rows, tiles) (E-0221, C1)
; record: offset $0000; 8 x 7 tiles
TileRect_PartyCountRects_1::
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $08, $07 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $d0, $d1, $d2, $d3, $d4, $c3, $b7 ; row 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; row 2
    db $b6, $eb, $c3, $c3, $c3, $c3, $c3, $b7 ; row 3
    db $b6, $ec, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $ea, $af, $c3, $c3, $c3, $c3, $b7 ; row 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 6

; record: offset $0000; 14 x 7 tiles
TileRect_PartyCountRects_2::
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $0e, $07 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $d0, $d1, $d2, $d3, $d4, $c3, $d5, $d6, $d7, $d8, $d9, $c3, $b7 ; row 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; row 2
    db $b6, $eb, $c3, $c3, $c3, $c3, $c3, $eb, $c3, $c3, $c3, $c3, $c3, $b7 ; row 3
    db $b6, $ec, $c3, $c3, $c3, $c3, $c3, $ec, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $ea, $af, $c3, $c3, $c3, $c3, $ea, $af, $c3, $c3, $c3, $c3, $b7 ; row 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 6

; record: offset $0000; 20 x 7 tiles
TileRect_PartyCountRects_3::
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $14, $07 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $d0, $d1, $d2, $d3, $d4, $c3, $d5, $d6, $d7, $d8, $d9, $c3, $da, $db, $dc, $dd, $de, $c3, $b7 ; row 1
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $ba ; row 2
    db $b6, $eb, $c3, $c3, $c3, $c3, $c3, $eb, $c3, $c3, $c3, $c3, $c3, $eb, $c3, $c3, $c3, $c3, $c3, $b7 ; row 3
    db $b6, $ec, $c3, $c3, $c3, $c3, $c3, $ec, $c3, $c3, $c3, $c3, $c3, $ec, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $ea, $af, $c3, $c3, $c3, $c3, $ea, $af, $c3, $c3, $c3, $c3, $ea, $af, $c3, $c3, $c3, $c3, $b7 ; row 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 6

; C = battle slot. Draws the status row of the slot panel (five tile places from wScreenTileBuffer +
; $A1 + 6 * (C and 3)), only for the shown slots: 0-2, or 4-6 when wLinkMode is non-zero and
; wLinkRole bit 1 is set; slots 3 and 7 never. With wLinkMode 2 it only far-calls
; DrawSlotStatusMarks_BankA0. A slot with no battler in play (CarryUnlessBattleSlotOutSlotEmpty,
; wBattleSlotOut non-zero) gets the level (DrawSlotStatusMarks_DrawLevel) and $C2 in the fifth mark
; place. A slot in play whose status byte (wBattleStatus, 9 bytes per slot) is 0 gets the level and
; $C3 there. Otherwise the five mark places are blanked with $C3 (DrawSlotStatusMarks_BlankMarks)
; and one mark is written for each set bit: BSTAT0_POISONED, BSTAT0_BADLY_POISONED (the same place,
; so badly poisoned wins), BSTAT0_CONFUSED, BSTAT0_CURSED, BSTAT0_PARALYZED, BSTAT0_ASLEEP; the
; sleep counter bits 2 and 3 draw nothing. BC is kept. (C2, E-0380)
; C = battle slot, drawn only for the displayed side (slots 0-2 normally, 4-6 when wLinkMode = 1 and
; wLinkRole bit 1 is set; slots 3 and 7 never); with wLinkMode = 2 the bank-$A0 version is
; far-called instead: draws the slot's status markers from its status bytes (the per-status part is
; not read to its end) (E-0111)
DrawSlotStatusMarks::
    ld a, [wLinkMode]
    cp $02
    jr nz, .check_link_mode
    farcall DrawSlotStatusMarks_BankA0
    ret

.check_link_mode:
    push bc
    ld a, [wLinkMode]
    or a
    jr z, .skip
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip
    ld a, c
    cp $04
    jr c, .done
    jr .skip2

.skip:
    ld a, c
    cp $04
    jr nc, .done

.skip2:
    and $03
    cp $03
    jr z, .done
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .call_draw_slot_status_marks_draw_level2
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    or a
    jr z, .call_draw_slot_status_marks_draw_level
    call DrawSlotStatusMarks_BlankMarks
    bit 0, [hl]
    call nz, DrawSlotStatusMarks_PoisonMark
    bit 1, [hl]
    call nz, DrawSlotStatusMarks_BadPoisonMark
    bit 4, [hl]
    call nz, DrawSlotStatusMarks_ConfusionMark
    bit 5, [hl]
    call nz, DrawSlotStatusMarks_CurseMark
    bit 6, [hl]
    call nz, DrawSlotStatusMarks_ParalysisMark
    bit 7, [hl]
    call nz, DrawSlotStatusMarks_SleepMark
    jr .done

.call_draw_slot_status_marks_draw_level:
    call DrawSlotStatusMarks_DrawLevel
    ld a, c
    and $03
    ld hl, DrawSlotStatusMarks_Data
    add a
    add_a_to_hl
    call DerefHL_Bank31
    ld [hl], $c3
    jr .done

.call_draw_slot_status_marks_draw_level2:
    call DrawSlotStatusMarks_DrawLevel
    ld a, c
    and $03
    ld hl, DrawSlotStatusMarks_Data
    add a
    add_a_to_hl
    call DerefHL_Bank31
    ld [hl], $c2

.done:
    pop bc
    ret

; Writes tile $C3 to the five mark places of the slot panel in wScreenTileBuffer ($A1 to $A5 plus 6
; * (C and 3)); HL kept. DrawSlotStatusMarks runs it first when the slot has a status bit set.
; DrawSlotStatusMarks_DrawLevel uses only the first four of these places, for the level. (C2,
; E-0380)
DrawSlotStatusMarks_BlankMarks::
    push hl
    ld hl, SlotStatusMarkFirstAddrs
    call ReadWordTableEntryForSlotC
    ld a, $c3
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    pop hl
    ret

; Writes the curse mark $C0 (BSTAT0_CURSED) at the first mark place of slot C's panel; HL kept. (C2,
; E-0372; probed E-0380)
DrawSlotStatusMarks_CurseMark::
    push hl
    ld hl, SlotStatusMarkFirstAddrs
    call ReadWordTableEntryForSlotC
    ld [hl], $c0
    pop hl
    ret

; Writes the poison mark $C1 (BSTAT0_POISONED) at the third mark place of slot C's panel; HL kept.
; (C2, E-0372; probed E-0380)
DrawSlotStatusMarks_PoisonMark::
    push hl
    ld hl, SlotStatusMarkThirdAddrs
    call ReadWordTableEntryForSlotC
    ld [hl], $c1
    pop hl
    ret

; Writes the bad poison mark $C7 (BSTAT0_BADLY_POISONED) at the third mark place of slot C's panel,
; the poison mark's place; HL kept. (C2, E-0372; probed E-0380)
DrawSlotStatusMarks_BadPoisonMark::
    push hl
    ld hl, SlotStatusMarkThirdAddrs
    call ReadWordTableEntryForSlotC
    ld [hl], $c7
    pop hl
    ret

; Writes the sleep mark $C8 (BSTAT0_ASLEEP) at the fourth mark place of slot C's panel; HL kept.
; (C2, E-0372; probed E-0380)
DrawSlotStatusMarks_SleepMark::
    push hl
    ld hl, SlotStatusMarkFourthAddrs
    call ReadWordTableEntryForSlotC
    ld [hl], $c8
    pop hl
    ret

; Writes the confusion mark $C9 (BSTAT0_CONFUSED) at the second mark place of slot C's panel; HL
; kept. (C2, E-0372; probed E-0380)
DrawSlotStatusMarks_ConfusionMark::
    push hl
    ld hl, SlotStatusMarkSecondAddrs
    call ReadWordTableEntryForSlotC
    ld [hl], $c9
    pop hl
    ret

; Writes the paralysis mark $CA (BSTAT0_PARALYZED) at the fifth mark place of slot C's panel, where
; DrawSlotStatusMarks otherwise writes $C2 or $C3; HL kept. (C2, E-0372; probed E-0380)
DrawSlotStatusMarks_ParalysisMark::
    push hl
    ld hl, DrawSlotStatusMarks_Data
    call ReadWordTableEntryForSlotC
    ld [hl], $ca
    pop hl
    ret

; HL = table of words, C = slot: HL = the word at HL + 2 * (C and 3), and A = its low byte (the
; table index is added to L with the carry into H, then it falls into DerefHL_Bank31). Used by
; DrawSlotStatusMarks_BlankMarks and the single mark routines to find a place in wScreenTileBuffer.
; (C2, E-0380)
; HL = table: HL = the word at HL + 2 * (C & 3) (falls into DerefHL_Bank31) (E-0110)
ReadWordTableEntryForSlotC::
    ld a, c
    and $03
    add a
    add l
    ld l, a
    jr nc, DerefHL_Bank31
    inc h

; HL = the word at HL (low byte first, as deref_hl); A = its low byte. Used by DrawSlotStatusMarks
; and, as the tail of ReadWordTableEntryForSlotC, by the mark routines. (C2, E-0380)
; HL = the word at HL; A = its low byte (E-0110)
DerefHL_Bank31::
    deref_hl
    ret

; Three words, wScreenTileBuffer + $A1, + $A7 and + $AD: the first of the five status-mark tiles of
; the panels of slots 0, 1 and 2, picked by C & 3 through ReadWordTableEntryForSlotC.
; DrawSlotStatusMarks_BlankMarks blanks the five tiles from here ($C3) and
; DrawSlotStatusMarks_CurseMark writes mark $C0 here. (C1, E-0372)
SlotStatusMarkFirstAddrs::
    db $39, $c2, $3f, $c2, $45, $c2

; Three words, wScreenTileBuffer + $A2, + $A8 and + $AE: the second status-mark tile of the panels
; of slots 0-2 (by C & 3). DrawSlotStatusMarks_ConfusionMark writes mark $C9 there. (C1, E-0372)
SlotStatusMarkSecondAddrs::
    db $3a, $c2, $40, $c2, $46, $c2

; Three words, wScreenTileBuffer + $A3, + $A9 and + $AF: the third status-mark tile of the panels of
; slots 0-2 (by C & 3). DrawSlotStatusMarks_PoisonMark writes mark $C1 there and
; DrawSlotStatusMarks_BadPoisonMark mark $C7. (C1, E-0372)
SlotStatusMarkThirdAddrs::
    db $3b, $c2, $41, $c2, $47, $c2

; Three words, wScreenTileBuffer + $A4, + $AA and + $B0: the fourth status-mark tile of the panels
; of slots 0-2 (by C & 3). DrawSlotStatusMarks_SleepMark writes mark $C8 there; the fifth tile's
; table is DrawSlotStatusMarks_Data. (C1, E-0372)
SlotStatusMarkFourthAddrs::
    db $3c, $c2, $42, $c2, $48, $c2

DrawSlotStatusMarks_Data::
    db $3d, $c2, $43, $c2, $49, $c2

; C = battle slot. Copies the five-tile level and status row of the slot panel from
; wScreenTileBuffer to the same offset of vBGMap0 (offset from SlotPanelRowOffsets: $A1, $A7 or $AD
; by C and 3, WriteVRAMByteInc), only for the shown slots (0-2, or 4-6 when wLinkMode is non-zero
; and wLinkRole bit 1 is set; never 3 and 7). With wLinkMode 2 it far-calls
; CopySlotPanelRowToVRAM_BankA0 instead. Called by CopySlotPanel0ToVRAM to CopySlotPanel2ToVRAM,
; BattleEnd_GainExperience_CheckLevelUp_RaiseLevel and RedrawChangedSlotPanels. (C1, E-0380)
; C = battle slot, drawn only for the displayed side (slots 0-2 normally, 4-6 when wLinkMode = 1 and
; wLinkRole bit 1 is set; slots 3 and 7 never); with wLinkMode = 2 the bank-$A0 version is
; far-called instead: copies the slot's 5-tile panel row from wScreenTileBuffer to the same position
; of vBGMap0 (offset from SlotPanelRowOffsets, WriteVRAMByteInc) (E-0111)
CopySlotPanelRowToVRAM::
    ld a, [wLinkMode]
    or a
    jr z, .skip
    cp $02
    jr nz, .check_link_role
    farcall CopySlotPanelRowToVRAM_BankA0
    ret

.check_link_role:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip
    ld a, c
    cp $04
    jr c, .return
    jr .skip2

.skip:
    ld a, c
    cp $04
    jr nc, .return

.skip2:
    and $03
    cp $03
    jr z, .return
    ld hl, SlotPanelRowOffsets
    add a
    add_a_to_hl
    deref_hl
    push hl
    ld de, wScreenTileBuffer
    add hl, de
    pop de
    push hl
    ld hl, vBGMap0
    add hl, de
    pop de
    ld b, $05

.loop:
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, .loop

.return:
    ret

; C = battle slot. Writes the HP of the slot (the word wBattleHP + 2 * C) as three digit tiles ($E0
; + digit, leading zeros blank $C3, HLToDecimalDigits and WriteDecimalDigitTiles) into
; wScreenTileBuffer at +$62, +$68 or +$6E for the panel C and 3 = 0, 1 or 2. Only the shown slots
; are drawn: 0-2, or 4-6 when wLinkMode is non-zero and wLinkRole bit 1 is set; slots 3 and 7 never.
; With wLinkMode 2 it only far-calls DrawSlotHPDigits_BankA0, which has its own place table (slot 1
; at +$6F). BC is kept when it draws itself. (C2, E-0380)
; C = battle slot, drawn only for the displayed side (slots 0-2 normally, 4-6 when wLinkMode = 1 and
; wLinkRole bit 1 is set; slots 3 and 7 never); with wLinkMode = 2 the bank-$A0 version is
; far-called instead: writes the slot's HP (wBattleHP) as decimal digit tiles (HLToDecimalDigits)
; into wScreenTileBuffer at the position from DrawSlotHPDigits_Data (E-0111)
DrawSlotHPDigits::
    ld a, [wLinkMode]
    cp $02
    jr nz, .skip
    farcall DrawSlotHPDigits_BankA0
    ret

.skip:
    push bc
    or a
    jr z, .skip2
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip2
    ld a, c
    cp $04
    jr c, .done
    jr .skip3

.skip2:
    ld a, c
    cp $04
    jr nc, .done

.skip3:
    and $03
    cp $03
    jr z, .done
    ld a, c
    ld hl, wBattleHP
    add a
    add_a_to_hl
    deref_hl
    push bc
    call HLToDecimalDigits
    pop bc
    ld a, c
    and $03
    push hl
    ld hl, DrawSlotHPDigits_Data
    add a
    add_a_to_hl
    deref_hl
    ld de, wScreenTileBuffer
    add hl, de
    ld d, h
    ld e, l
    pop hl
    call WriteDecimalDigitTiles

.done:
    pop bc
    ret

; C = battle slot. Writes the MP of the slot (the word wBattleMP + 2 * C) as three digit tiles ($E0
; + digit, leading zeros blank $C3) into wScreenTileBuffer at +$82, +$88 or +$8E for the panel C and
; 3 = 0, 1 or 2. Only the shown slots are drawn: 0-2, or 4-6 when wLinkMode is non-zero and
; wLinkRole bit 1 is set; slots 3 and 7 never. With wLinkMode 2 it only far-calls
; DrawSlotMPDigits_BankA0 (slot 1 at +$8F). BC is kept when it draws itself. (C2, E-0380)
; C = battle slot, drawn only for the displayed side (slots 0-2 normally, 4-6 when wLinkMode = 1 and
; wLinkRole bit 1 is set; slots 3 and 7 never); with wLinkMode = 2 the bank-$A0 version is
; far-called instead: writes the slot's MP (wBattleMP) as decimal digit tiles into wScreenTileBuffer
; at the slot's position (E-0111)
DrawSlotMPDigits::
    ld a, [wLinkMode]
    cp $02
    jr nz, .skip
    farcall DrawSlotMPDigits_BankA0
    ret

.skip:
    push bc
    or a
    jr z, .skip2
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip2
    ld a, c
    cp $04
    jr c, .done
    jr .skip3

.skip2:
    ld a, c
    cp $04
    jr nc, .done

.skip3:
    and $03
    cp $03
    jr z, .done
    ld a, c
    ld hl, wBattleMP
    add a
    add_a_to_hl
    deref_hl
    push bc
    call HLToDecimalDigits
    pop bc
    ld a, c
    and $03
    push hl
    ld hl, DrawSlotMPDigits_Data
    add a
    add_a_to_hl
    deref_hl
    ld de, wScreenTileBuffer
    add hl, de
    ld d, h
    ld e, l
    pop hl
    call WriteDecimalDigitTiles

.done:
    pop bc
    ret

; C = slot: in wLinkMode 2 far-calls DrawSlotLevel_BankA0; otherwise, only for the displayed side
; (slots 0-2, or 4-6 when wLinkMode is nonzero and wLinkRole bit 1 is set; never slots 3 and 7),
; writes the level label tiles $EA, $AF and the slot's wBattleLevel in two digits
; (HLToDecimalDigits, WriteTwoDigitTilesFromDigits1) at the slot's panel offset in wScreenTileBuffer
; ($A1, $A7 or $AD). BC kept. (C2, E-0372; probed E-0380)
DrawSlotStatusMarks_DrawLevel::
    ld a, [wLinkMode]
    cp $02
    jr nz, .skip
    farcall DrawSlotLevel_BankA0
    ret

.skip:
    push bc
    or a
    jr z, .skip2
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip2
    ld a, c
    cp $04
    jr c, .done
    jr .skip3

.skip2:
    ld a, c
    cp $04
    jr nc, .done

.skip3:
    and $03
    cp $03
    jr z, .done
    ld a, c
    and $03
    ld hl, DrawSlotStatusMarks_DrawLevel_Data
    add a
    add_a_to_hl
    deref_hl
    ld de, wScreenTileBuffer
    add hl, de
    ld [hl], $ea
    inc hl
    ld [hl], $af
    inc hl
    push hl
    ld a, c
    ld hl, wBattleLevel
    add_a_to_hl
    ld l, [hl]
    ld h, $00
    push bc
    call HLToDecimalDigits
    pop bc
    pop de
    call WriteTwoDigitTilesFromDigits1

.done:
    pop bc
    ret

; C = battle slot. Copies the three HP digit tiles of the slot panel from wScreenTileBuffer to the
; same offset of vBGMap0 (offsets +$62, +$68 or +$6E from DrawSlotHPDigits_Data by C and 3), only
; for the shown slots (0-2, or 4-6 when wLinkMode is non-zero and wLinkRole bit 1 is set; never 3
; and 7). With wLinkMode 2 it far-calls CopySlotHPDigitsPanelToVRAM_BankA0. Called by
; CopySlotPanel0ToVRAM to CopySlotPanel2ToVRAM and RedrawChangedSlotPanels. (C1, E-0380)
; copies three tiles at offset DrawSlotHPDigits_Data[slot] from the screen buffer to vBGMap0 for the
; shown side (CopySlotHPDigitsPanelToVRAM_BankA0 in mode 2) (E-0125) (E-0344: the address in its
; name dropped or read as the label there; was CopySlotHPDigitsPanelToVRAM)
CopySlotHPDigitsPanelToVRAM::
    ld a, [wLinkMode]
    or a
    jr z, .skip
    cp $02
    jr nz, .check_link_role
    farcall CopySlotHPDigitsPanelToVRAM_BankA0
    ret

.check_link_role:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip
    ld a, c
    cp $04
    jr c, .return
    jr .skip2

.skip:
    ld a, c
    cp $04
    jr nc, .return

.skip2:
    and $03
    cp $03
    jr z, .return
    ld hl, DrawSlotHPDigits_Data
    add a
    add_a_to_hl
    deref_hl
    push hl
    ld de, wScreenTileBuffer
    add hl, de
    pop de
    push hl
    ld hl, vBGMap0
    add hl, de
    pop de
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    call WriteVRAMByte

.return:
    ret

; C = battle slot. Copies the three MP digit tiles of the slot panel from wScreenTileBuffer to the
; same offset of vBGMap0 (offsets +$82, +$88 or +$8E from DrawSlotMPDigits_Data by C and 3), only
; for the shown slots (0-2, or 4-6 when wLinkMode is non-zero and wLinkRole bit 1 is set; never 3
; and 7). With wLinkMode 2 it far-calls CopySlotMPDigitsPanelToVRAM_BankA0. Called by
; CopySlotPanel0ToVRAM to CopySlotPanel2ToVRAM and RedrawChangedSlotPanels. (C1, E-0380)
; copies three tiles at offset DrawSlotMPDigits_Data[slot] from the screen buffer to vBGMap0 for the
; shown side (CopySlotMPDigitsPanelToVRAM_BankA0 in mode 2) (E-0125) (E-0344: the address in its
; name dropped or read as the label there; was CopySlotMPDigitsPanelToVRAM)
CopySlotMPDigitsPanelToVRAM::
    ld a, [wLinkMode]
    or a
    jr z, .skip
    cp $02
    jr nz, .check_link_role
    farcall CopySlotMPDigitsPanelToVRAM_BankA0
    ret

.check_link_role:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip
    ld a, c
    cp $04
    jr c, .return
    jr .skip2

.skip:
    ld a, c
    cp $04
    jr nc, .return

.skip2:
    and $03
    cp $03
    jr z, .return
    ld hl, DrawSlotMPDigits_Data
    add a
    add_a_to_hl
    deref_hl
    push hl
    ld de, wScreenTileBuffer
    add hl, de
    pop de
    push hl
    ld hl, vBGMap0
    add hl, de
    pop de
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    call WriteVRAMByte

.return:
    ret

; C = battle slot. Copies the two level tiles (digits) of the slot panel from wScreenTileBuffer to
; the same offset of vBGMap0 (offsets from DrawSlotStatusMarks_DrawLevel_Data: +$A1, +$A7 or +$AD by
; C and 3), only for the shown slots (0-2, or 4-6 when wLinkMode is non-zero and wLinkRole bit 1 is
; set; never 3 and 7). With wLinkMode 2 it far-calls CopySlotLevelPanelToVRAM_BankA0. No caller was
; found in src/. (C1, E-0380)
; copies two tiles at offset DrawSlotStatusMarks_DrawLevel_Data[slot] from the screen buffer to
; vBGMap0 for the shown side (CopySlotLevelPanelToVRAM_BankA0 in mode 2) (E-0125) (E-0344: the
; address in its name dropped or read as the label there; was CopySlotLevelPanelToVRAM)
CopySlotLevelPanelToVRAM::
    ld a, [wLinkMode]
    or a
    jr z, .skip
    cp $02
    jr nz, .check_link_role
    farcall CopySlotLevelPanelToVRAM_BankA0
    ret

.check_link_role:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip
    ld a, c
    cp $04
    jr c, .return
    jr .skip2

.skip:
    ld a, c
    cp $04
    jr nc, .return

.skip2:
    and $03
    cp $03
    jr z, .return
    ld hl, DrawSlotStatusMarks_DrawLevel_Data
    add a
    add_a_to_hl
    deref_hl
    push hl
    ld de, wScreenTileBuffer
    add hl, de
    pop de
    push hl
    ld hl, vBGMap0
    add hl, de
    pop de
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    ld a, [de]
    call WriteVRAMByte

.return:
    ret

; HL = VRAM tile address, D = width in tiles, E = rows (the callers pass for example DE = $0801):
; saves the text window (wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth),
; sets it to HL and DE, far-calls ShowString_Bank09 to draw string wStringIndex of category
; wStringCategory, then puts the old window back. A, BC, DE and HL change. The command-phase menus
; call it after setting category 2 (RunBattleSetup_MainMenu_Draw,
; RunBattleSetup_PlanMenu_DrawTactics, RunBattleSetup_PlanMenu_DrawActions,
; RunBattleSetup_PlanMenu_DrawAllyTargets, RunBattleSetup_ItemMenu_DrawSideWindow,
; RunBattleSetup_ItemMenu_DrawAllyTargets). (C1, E-0380)
; saves the string window wTextWindowTileLo-wTextWindowWidth, sets the tile destination to HL and
; the size to DE, far-calls ShowString_Bank09, then restores the window (E-0067) (the same 59 bytes
; appear in 3 banks)
ShowStringBank09AtTilesHL_Bank31::
    ld a, [wTextWindowTileLo]
    ld c, a
    ld a, [wTextWindowTileHi]
    ld b, a
    push bc
    ld a, [wTextWindowRows]
    ld c, a
    ld a, [wTextWindowWidth]
    ld b, a
    push bc
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    farcall ShowString_Bank09
    pop de
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    ret

; HL = VRAM tile address, D = width in tiles, E = rows (the callers pass DE = $0603 or $0901): saves
; the text window (wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth), sets it
; to HL and DE, far-calls ShowString_Bank08 to draw string wStringIndex of category wStringCategory,
; then puts the old window back. A, BC, DE and HL change. Callers set the category and index first:
; the item menu writes the description of the selected item (category 6,
; RunBattleSetup_ItemMenu_DrawBagPage and RunBattleSetup_ItemMenu_RedrawItemList),
; RunBattleSetup_PlanMenu_ShowSkillDescAndMP the description of a skill, and the wrappers
; ShowStringAAtTiles16D0, ShowStringAAtTiles1760, ShowStringAAtTiles17F0 and ShowStringAAtTiles2080
; draw the string numbered A at four fixed tile addresses. (C1, E-0380)
; saves the string window wTextWindowTileLo-wTextWindowWidth, sets the tile destination to HL and
; the size to DE, far-calls ShowString_Bank08, then restores the window (E-0067) (the same 59 bytes
; appear in 2 banks)
ShowStringBank08AtTilesHL_Bank31::
    ld a, [wTextWindowTileLo]
    ld c, a
    ld a, [wTextWindowTileHi]
    ld b, a
    push bc
    ld a, [wTextWindowRows]
    ld c, a
    ld a, [wTextWindowWidth]
    ld b, a
    push bc
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    farcall ShowString_Bank08
    pop de
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    ret

; No caller in src (the copy in bank $A0 is the same code and has none either). DE = pointer to five
; glyphs, HL = VRAM tile address: copies the five glyphs to wTextBuf0 with CopyFiveGlyphsPlusMarks
; (which ends them with $F0), saves the text window, sets it to HL with width 5 and 1 row, far-calls
; ShowString_Bank08 for string 0 of category 2 and puts the old window back. String_08_02_00 is only
; the end byte $F0, so what it would draw is unclear. (C1, E-0380)
; the same 80 bytes as UnreferencedShowFiveGlyphsAtTilesHL_BankA0; no caller found (E-0238)
UnreferencedShowFiveGlyphsAtTilesHL_Bank31:: ; configured code entry (E-0238); C0
    push hl
    ld hl, wTextBuf0
    call CopyFiveGlyphsPlusMarks
    pop hl
    ld a, [wTextWindowTileLo]
    ld c, a
    ld a, [wTextWindowTileHi]
    ld b, a
    push bc
    ld a, [wTextWindowRows]
    ld c, a
    ld a, [wTextWindowWidth]
    ld b, a
    push bc
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld de, $0501
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    ld a, $02
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    farcall ShowString_Bank08
    pop de
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    ret

; data read by DrawSlotHPDigits (6 bytes) (E-0347)
DrawSlotHPDigits_Data::
    db $62, $00, $68, $00, $6e, $00

DrawSlotMPDigits_Data::
    db $82, $00, $88, $00, $8e, $00

DrawSlotStatusMarks_DrawLevel_Data::
    db $a1, $00, $a7, $00, $ad, $00

; CopySlotPanelRowToVRAM reads the word at $7ADA + 2 * (slot & 3) and copies 5 tiles from
; wScreenTileBuffer + offset to the same offset of vBGMap0; three words for slots 0-2 (E-0212, C1)
; record: offset of the slot's panel row in the screen buffer / BG map
SlotPanelRowOffsets::
    dw $00a1 ; id 0
    dw $00a7 ; id 1
    dw $00ad ; id 2

; A = battle slot (0-7): sets HL = wBattleATK and continues in GetBattleStatWord_Bank31, which
; returns HL = the attack word of that slot (low byte first, from wBattleATK + 2 * A) and A = its
; low byte. No caller of this copy in src (the same code is in other banks). (C2, E-0380)
; the same 55 bytes as GetBattleATK_Bank39 (GetBattleATK_Bank39) (E-0060)
GetBattleATK_Bank31:: ; configured code entry (E-0212); C0
    ld hl, wBattleATK
    jr GetBattleStatWord_Bank31

; A = battle slot (0-7): sets HL = wBattleDEF and continues in GetBattleStatWord_Bank31, which
; returns HL = the defence word of that slot (low byte first, from wBattleDEF + 2 * A) and A = its
; low byte. No caller of this copy in src (the same code is in other banks). (C2, E-0380)
; the same 50 bytes as GetBattleDEF_Bank39 (GetBattleDEF_Bank39) (E-0060)
GetBattleDEF_Bank31:: ; configured code entry (E-0212); C0
    ld hl, wBattleDEF
    jr GetBattleStatWord_Bank31

; A = battle slot (0-7): sets HL = wBattleMaxHP and continues in GetBattleStatWord_Bank31, which
; returns HL = the maximum HP word of that slot (low byte first, from wBattleMaxHP + 2 * A) and A =
; its low byte. No caller of this copy in src (the same code is in other banks). (C2, E-0380)
; the same 45 bytes as GetBattleMaxHP_Bank39 (GetBattleMaxHP_Bank39) (E-0060)
GetBattleMaxHP_Bank31:: ; configured code entry (E-0212); C0
    ld hl, wBattleMaxHP
    jr GetBattleStatWord_Bank31

; A = battle slot (0-7): sets HL = wBattleMaxMP and continues in GetBattleStatWord_Bank31, which
; returns HL = the maximum MP word of that slot (low byte first, from wBattleMaxMP + 2 * A) and A =
; its low byte. No caller of this copy in src (the same code is in other banks). (C2, E-0380)
; the same 40 bytes as GetBattleMaxMP_Bank39 (GetBattleMaxMP_Bank39) (E-0060)
GetBattleMaxMP_Bank31:: ; configured code entry (E-0212); C0
    ld hl, wBattleMaxMP
    jr GetBattleStatWord_Bank31

; A = battle slot (0-7): sets HL = wBattleHP and continues in GetBattleStatWord_Bank31, which
; returns HL = the current HP word of that slot (low byte first, from wBattleHP + 2 * A) and A = its
; low byte. No caller of this copy in src (the same code is in other banks). (C2, E-0380)
; the same 35 bytes as GetBattleHP_Bank39 (GetBattleHP_Bank39) (E-0060)
GetBattleHP_Bank31:: ; configured code entry (E-0212); C0
    ld hl, wBattleHP
    jr GetBattleStatWord_Bank31

; A = battle slot (0-7): sets HL = wBattleMP and continues in GetBattleStatWord_Bank31, which
; returns HL = the current MP word of that slot (low byte first, from wBattleMP + 2 * A) and A = its
; low byte. No caller of this copy in src (the same code is in other banks). (C2, E-0380)
; the same 30 bytes as GetBattleMP_Bank39 (GetBattleMP_Bank39) (E-0060)
GetBattleMP_Bank31:: ; configured code entry (E-0212); C0
    ld hl, wBattleMP
    jr GetBattleStatWord_Bank31

; A = battle slot (0-7): sets HL = wBattleAGL and continues in GetBattleStatWord_Bank31, which
; returns HL = the agility word of that slot (low byte first, from wBattleAGL + 2 * A) and A = its
; low byte. No caller of this copy in src (the same code is in other banks). (C2, E-0380)
; the same 25 bytes as GetBattleAGL_Bank39 (GetBattleAGL_Bank39) (E-0060)
GetBattleAGL_Bank31:: ; configured code entry (E-0212); C0
    ld hl, wBattleAGL
    jr GetBattleStatWord_Bank31

; A = slot: returns A = the byte at wSlotAIMode + A (the AI mode of that slot) and leaves HL
; pointing at it. No caller of this copy in src. (C2, E-0380)
; A = the byte at wSlotAIMode + A; clobbers HL (the same 10 bytes appear in 5 banks)
ReadSlotAIModeIndexed_Bank31:: ; configured code entry (E-0212); C0
    ld hl, wSlotAIMode
    add_a_to_hl
    ld a, [hl]
    ret

; The shared tail of GetBattleATK_Bank31 ... GetBattleAGL_Bank31: HL = a per-slot word table, A =
; slot: returns HL = the word at HL + 2 * A (A doubled in 8 bits) and A = its low byte (deref_hl).
; (C2, E-0372; probed E-0380)
GetBattleStatWord_Bank31::
    add a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A. A is doubled in 8 bits first, so A above $7F wraps (A = $90 adds $20); the sum
; carries into H. A is clobbered. No caller of this copy in src. (C2, E-0380)
; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes
; appear in 12 banks)
AddDoubleAToHL_Bank31::
    add a
    add_a_to_hl
    ret

; Carry set when wBattleActor is below 4 (slots 0-3), clear otherwise. When wLinkMode is 1 and bit 1
; of wLinkRole is set the test is reversed (carry set for slots 4 and up); other link modes use the
; plain test. That carry means the local side is inferred from this reversal, not checked. A is
; clobbered. No caller of this copy in src. (C2, E-0380)
; carry set when wBattleActor < 4 (slots 0-3); when wLinkMode = 1 and wLinkRole bit 1 is set the
; test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the
; reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
ActorOnLocalSide_Bank31::
    ld a, [wLinkMode]
    cp $01
    jr nz, .check_battle_actor
    ld a, [wLinkRole]
    bit 1, a
    jr z, .check_battle_actor
    ld a, [wBattleActor]
    cp $04
    ccf
    ret

.check_battle_actor:
    ld a, [wBattleActor]
    cp $04
    ret

; Carry set when wBattleTarget is below 4 (slots 0-3), clear otherwise. When wLinkMode is 1 and bit
; 1 of wLinkRole is set the test is reversed (carry set for slots 4 and up); other link modes use
; the plain test. A is clobbered. No caller of this copy in src. (C2, E-0380)
; carry set when wBattleTarget < 4 (slots 0-3); when wLinkMode = 1 and wLinkRole bit 1 is set the
; test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 12
; banks)
TargetOnLocalSide_Bank31::
    ld a, [wLinkMode]
    cp $01
    jr nz, .check_battle_target
    ld a, [wLinkRole]
    bit 1, a
    jr z, .check_battle_target
    ld a, [wBattleTarget]
    cp $04
    ccf
    ret

.check_battle_target:
    ld a, [wBattleTarget]
    cp $04
    ret

; D = mask number 0-6 (not range checked), E = slot: ANDs ClearBitMaskTable_Bank31[D] ($DF, $FE,
; $00, $FD, $73, $EF, $BF) into status byte 0 of the slot (wBattleStatus + 9 * E). The masks clear
; BSTAT0_CURSED, BSTAT0_POISONED, the whole byte, BSTAT0_BADLY_POISONED, the sleep bits
; (BSTAT0_ASLEEP and both turn bits), BSTAT0_CONFUSED and BSTAT0_PARALYZED. Returns D = the mask, A
; = the new byte and HL = the address of the byte. No caller of this copy in src. (C2, E-0380)
; wBattleStatus + 9 * E &= ClearBitMaskTable_Bank31[D] (AddAx9ToHL); not reached from traced code
; (E-0212)
ClearBattleStatusBitsWithMaskD_Bank31:: ; configured code entry (E-0212); C0
    ld a, d
    ld hl, ClearBitMaskTable_Bank31
    add_a_to_hl
    ld d, [hl]
    ld a, e
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, d
    and [hl]
    ld [hl], a
    ret

; the copy in bank $31 of ClearBitMaskTable_Bank31 (E-0205), read by the routine at $7B54; the block
; $7B54-$7BEE has the same bytes as $4075-$410F in banks $05, $A1 and $A3, apart from the table
; address (E-0212, C1)
; record: AND mask
ClearBitMaskTable_Bank31::
    db $df ; id 0
    db $fe ; id 1
    db $00 ; id 2
    db $fd ; id 3
    db $73 ; id 4
    db $ef ; id 5
    db $bf ; id 6

; A = slot: sets bit 0 of the byte at wLevelUpGains + A and keeps HL (A is clobbered). In battle
; bits 0, 1 and 2 of wLevelUpGains[slot] ask for a redraw of the HP digits, MP digits and status
; marks of the slot panel: RedrawChangedSlotPanels draws what is flagged and clears the bits. Bit 0
; is the HP digits. No caller of this copy in src. (C2, E-0380)
; Sets bit 0 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit0OfLevelUpGainsIndexed_Bank31:: ; configured code entry (E-0212); C0
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; A = slot: sets bit 1 of the byte at wLevelUpGains + A and keeps HL (A is clobbered). In battle
; bits 0, 1 and 2 of wLevelUpGains[slot] ask for a redraw of the HP digits, MP digits and status
; marks of the slot panel: RedrawChangedSlotPanels draws what is flagged and clears the bits. Bit 1
; is the MP digits. No caller of this copy in src. (C2, E-0380)
; Sets bit 1 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit1OfLevelUpGainsIndexed_Bank31:: ; configured code entry (E-0212); C0
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; A = slot: sets bit 2 of the byte at wLevelUpGains + A and keeps HL (A is clobbered). In battle
; bits 0, 1 and 2 of wLevelUpGains[slot] ask for a redraw of the HP digits, MP digits and status
; marks of the slot panel: RedrawChangedSlotPanels draws what is flagged and clears the bits. Bit 2
; is the status marks. No caller of this copy in src. (C2, E-0380)
; Sets bit 2 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks)
SetBit2OfLevelUpGainsIndexed_Bank31:: ; configured code entry (E-0212); C0
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

; A = slot 0-7: returns A = 9 * g(wSlotPersonalityHi[A]) + 3 * g(wSlotPersonalityMid[A]) +
; g(wSlotPersonalityLo[A]), with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (a number 0-26; the
; same index PersonalityIndexOfRecord builds from a save record). HL and BC are kept. No caller of
; this copy in src. (C2, E-0380)
; A = slot 0-7: returns A = 9 * g(wSlotPersonalityHi[A]) + 3 * g(wSlotPersonalityMid[A]) +
; g(wSlotPersonalityLo[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index
; PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes
; appear in 13 banks)
PersonalityIndexOfSlot_Bank31:: ; configured code entry (E-0212); C0
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp $c0
    jr nc, .skip
    ld l, $09
    cp $40
    jr nc, .skip
    ld l, $12

.skip:
    ld a, l
    add b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityMid
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp $c0
    jr nc, .skip2
    ld l, $03
    cp $40
    jr nc, .skip2
    ld l, $06

.skip2:
    ld a, l
    add b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp $c0
    jr nc, .skip3
    ld l, $01
    cp $40
    jr nc, .skip3
    ld l, $02

.skip3:
    ld a, l
    add b
    pop bc
    pop hl
    ret

; A = slot: carry set when CheckSlotStatusBlock sets it (the slot is absent, or status byte 0 & $D0,
; byte 3 & $3F, byte 5 & $C0 or byte 8 bit 3 is set), or when status byte 3 & $C0 or status byte 4 &
; $0C is set (wBattleStatus3 + 9 * A); otherwise carry clear. A, BC and HL are kept. Its only caller
; here is RunBattleSetup_MainMenu_TryFlee_CountAbleFoes. (C2, E-0380)
; A = slot: carry set when CheckSlotStatusBlock sets it, or when status byte 3 & $C0 or byte 4 & $0C
; is set (wBattleStatus3 + 9 * A); otherwise carry clear; A, BC, HL kept (E-0067) (the same 31 bytes
; appear in 12 banks)
CheckSlotStatusBlockWide_Bank31::
    call CheckSlotStatusBlock
    ret c
    push hl
    push bc
    ld c, a
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hli]
    and $c0
    jr nz, .set_carry
    ld a, [hl]
    and $0c
    jr nz, .set_carry
    xor a
    jr .skip

.set_carry:
    scf

.skip:
    ld a, c
    pop bc
    pop hl
    ret

; A = slot: returns A = status byte 3 & $C0 (wBattleStatus3 + 9 * slot) or, when that is zero,
; status byte 4 & $0C; Z set when both are clear. HL is kept. No caller of this copy in src. (C2,
; E-0380)
; A = slot: with HL = wBattleStatus3 + 9 * A (status byte 3 of wBattleStatus), A = byte 3 & $C0, or
; byte 4 & $0C when that is zero; Z set when both are clear; HL kept (E-0067) (the same 17 bytes
; appear in 13 banks)
SlotHasStatus3Or4Bits_Bank31::
    push hl
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hli]
    and $c0
    jr nz, .done
    ld a, [hl]
    and $0c

.done:
    pop hl
    ret

; LZSS-compressed: 477 bytes that expand to 704 (E-0016, E-0017)
Tiles1Plus240Gfx::
    INCBIN "gfx/misc/tiles1_plus240_gfx.lz"

; LZSS-compressed: 151 bytes that expand to 224 (E-0016, E-0017)
Tiles1Plus5F0Gfx::
    INCBIN "gfx/misc/tiles1_plus5_f0_gfx.lz"
    ds $16e, $00
