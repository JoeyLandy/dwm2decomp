; ROM bank $73: GreatLog events and story scenes, reward items
; The annotated listing of this bank is build/listing/bank73.asm.

SECTION "Bank 73", ROMX[$4000], BANK[$73]
    db $73

; Script command type 82 (SCRIPT_TRAVELER_EVENT, reached through ScriptCommand82 in bank $10). It
; jumps by wPendingFieldEvent & $0F to one of the traveler encounters: 0 TravelerEvents_Healer, 1
; TravelerEvents_Merchant, 2 TravelerEvents_PaidHealer, 3 TravelerEvents_PriceyMerchant, 4
; TravelerEvents_WanderingMaster, 5 TravelerEvents_TravelingMaster, 6 TravelerEvents_CardGame, 7
; TravelerEvents_RewardBattle, 8 TravelerEvents_MapSeller, 9 TravelerEvents_MedicineMaster, 10
; TravelerEvents_CasinoShip, 11 TravelerEvents_HealerBattle and 12-15 TravelerEvents_Thief. Each of
; those routines is a state machine on wScriptStep. (C1, E-0384)
; implements script command type 82 (SCRIPT_TRAVELER_EVENT): talk category 8: jumps by
; wPendingFieldEvent & $0F to 13 traveler encounters: a healer, two merchants, a paid healer, three
; masters to battle, a card game, a map seller, a medicine master, the casino ship, a healer to
; battle and a thief (four openings); their lines are category 5 of bank $09, shown by
; RunMessageBox_Bank73 (E-0364; was TravelerEvents, named from the wrong message table, E-0293);
; reached through ScriptCommand82 in bank $10 (E-0038)
TravelerEvents::
    ld a, [wPendingFieldEvent]
    and $0f
    jumptable
    dw TravelerEvents_Healer
    dw TravelerEvents_Merchant
    dw TravelerEvents_PaidHealer
    dw TravelerEvents_PriceyMerchant
    dw TravelerEvents_WanderingMaster
    dw TravelerEvents_TravelingMaster
    dw TravelerEvents_CardGame
    dw TravelerEvents_RewardBattle
    dw TravelerEvents_MapSeller
    dw TravelerEvents_MedicineMaster
    dw TravelerEvents_CasinoShip
    dw TravelerEvents_HealerBattle
    dw TravelerEvents_Thief
    dw TravelerEvents_Thief
    dw TravelerEvents_Thief
    dw TravelerEvents_Thief

; Events $0C-$0F of TravelerEvents, a thief. A state machine on wScriptStep: 0
; TravelerEvents_Thief_ShowOpeningLine, 1 TravelerEvents_Thief_WaitMessage, 2
; TravelerEvents_Thief_StartBattle, 3 TravelerEvents_Thief_ShowTheFugitiveMasterWas (after the
; battle: a win sets the event story flag and shows 'The fugitive master was captured and sent back
; to GreatLog.', next steps 4 wait and 5 ScriptStepBlinkSpritesThenEnd; a loss goes to step 6), 6
; wait, 7 TravelerEvents_Thief_ShowHeroLostG (takes the gold), 8 wait, 9
; ScriptStepBlinkSpritesThenEnd. (C1, E-0384)
; events $0C-$0F: a thief ('Let me lighten your purse.' or a remark on the party): a battle; a win
; sends him back to GreatLog, a loss costs gold (E-0364; was TravelerEvents_Thief, named from the
; wrong message table, E-0293)
TravelerEvents_Thief::
    ld a, [wScriptStep]
    jumptable
    dw TravelerEvents_Thief_ShowOpeningLine
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_Thief_StartBattle
    dw TravelerEvents_Thief_ShowTheFugitiveMasterWas
    dw TravelerEvents_Thief_WaitMessage
    dw ScriptStepBlinkSpritesThenEnd
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_Thief_ShowHeroLostG
    dw TravelerEvents_Thief_WaitMessage
    dw ScriptStepBlinkSpritesThenEnd

; Thief, step 0: the thief's opening line, message $3A + (event - $0C): 'Let me lighten your
; purse.', or a remark on the party's injured, tired or weak monsters ($3B-$3D); next step. (C2,
; E-0357; probed E-0384)
TravelerEvents_Thief_ShowOpeningLine::
    ld a, [wPendingFieldEvent]
    and $0f
    sub $0c
    add $3a
    ld l, a
    ld h, $00
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; Thief, step 3: after the battle; when the player won, 'The fugitive master was captured and sent
; back to GreatLog.' ($3E) and sets the event's flag from the table (next step); when the player
; lost, message $3F + (event - $0C) ('I'll unburden you of your gold.' and the lines after it) and
; step 6. (C2, E-0357; probed E-0384)
TravelerEvents_Thief_ShowTheFugitiveMasterWas::
    ld a, [wBattleScene]
    or a
    jr nz, .check_pending_field_event
    ld hl, $003e ; 'The fugitive master was captured and'
    call StartMessageHL_B73
    ld a, [wPendingFieldEvent]
    and $0f
    sub $0c
    add a
    ld hl, TravelerEvents_Thief_ShowTheFugitiveMasterWas_Data
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

.check_pending_field_event:
    ld a, [wPendingFieldEvent]
    and $0f
    sub $0c
    add $3f
    ld l, a
    ld h, $00
    call StartMessageHL_B73
    ld a, $06
    ld [wScriptStep], a
    ret

; Four little-endian story flag numbers, $0193, $0196, $0199 and $019C (EVENT_KING_IF_YOU_SEE,
; EVENT_KING_IF_YOU_SEE_196, EVENT_KING_IF_YOU_SEE_199 and EVENT_KING_IF_YOU_SEE_19C), one per
; traveler thief event $0C-$0F (index wPendingFieldEvent AND $0F, minus $0C, times 2). After the
; player wins the battle, TravelerEvents_Thief_ShowTheFugitiveMasterWas loads the word into DE and
; calls SetFlagBit to set that flag. (C1, E-0381)
TravelerEvents_Thief_ShowTheFugitiveMasterWas_Data::
    db $93, $01, $96, $01, $99, $01, $9c, $01

; Event $0B of TravelerEvents, a healer who must be beaten. A state machine on wScriptStep: 0
; TravelerEvents_HealerBattle_ShowIWillHealYour (yes/no question), 1 wait for the message
; (TravelerEvents_Thief_WaitMessage), 2 TravelerEvents_HealerBattle_ShowITakeBeingA (yes goes on to
; 3, no jumps to step 13), 3 wait, 4 TravelerEvents_Thief_StartBattle, 5
; TravelerEvents_HealerBattle_ShowFineFineISurrender (after the battle: a win goes on to 6, a loss
; jumps to step 11), 6 wait, 7 TravelerEvents_HealerBattle_FlashScreen, 8
; TravelerEvents_HealerBattle_ShowIWillPrayFor, 9 TravelerEvents_AfterHealing, 10
; ScriptStepBlinkSpritesThenEnd, 11 wait, 12 TravelerEvents_Thief_ShowHeroLostG, 13 wait, 14
; ScriptStepBlinkSpritesThenEnd. (C1, E-0384)
; event $0B: 'I will heal your injuries for you... If you can defeat me': a win heals the party
; (E-0364; was TravelerEvents_HealerBattle, named from the wrong message table, E-0293)
TravelerEvents_HealerBattle::
    ld a, [wScriptStep]
    jumptable
    dw TravelerEvents_HealerBattle_ShowIWillHealYour
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_HealerBattle_ShowITakeBeingA
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_Thief_StartBattle
    dw TravelerEvents_HealerBattle_ShowFineFineISurrender
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_HealerBattle_FlashScreen
    dw TravelerEvents_HealerBattle_ShowIWillPrayFor
    dw TravelerEvents_AfterHealing
    dw ScriptStepBlinkSpritesThenEnd
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_Thief_ShowHeroLostG
    dw TravelerEvents_Thief_WaitMessage
    dw ScriptStepBlinkSpritesThenEnd

; Healer battle, step 0: 'I will heal your injuries for you... If you can defeat me, that is. Well?'
; ($37, yes/no); next step. (C2, E-0357; probed E-0384)
TravelerEvents_HealerBattle_ShowIWillHealYour::
    ld hl, MSG_KEEP_OPEN | $0037 ; '*: I will heal your injuries'
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; Healer battle, step 2: yes gives 'I take being a master seriously. I won't hold back from
; anything!' ($49) and the next step; no gives 'You've no courage to battle? Shame, it really is.'
; ($48) and step $0D. (C2, E-0357; probed E-0384)
TravelerEvents_HealerBattle_ShowITakeBeingA::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b73
    ld hl, MSG_ALREADY_OPEN | $0049 ; '*: I take being a master'
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b73:
    ld hl, MSG_ALREADY_OPEN | $0048 ; '*: You've no courage to battle?'
    call StartMessageHL_B73
    ld a, $0d
    ld [wScriptStep], a
    ret

; Healer battle, step 5: after the battle, a win gives 'Fine, fine, I surrender. I'll heal your
; party as promised.' ($38) and saves the palettes for the flash (next step); a loss gives 'Your
; lack of training is clear...' ($39) and step $0B. (C2, E-0357; probed E-0384)
TravelerEvents_HealerBattle_ShowFineFineISurrender::
    ld a, [wBattleScene]
    or a
    jr nz, .call_start_message_hl_b73
    ld hl, $0038 ; '*: Fine, fine, I surrender. I'll'
    call StartMessageHL_B73
    ld a, [wIsCGB]
    or a
    jr z, .done
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes

.done:
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b73:
    ld hl, $0039 ; '*: Your lack of training is'
    call StartMessageHL_B73
    ld a, $0b
    ld [wScriptStep], a
    ret

; Thief, step 7: '<player> lost <n>G.' ($0F) after the thief takes the gold penalty
; (DeductGoldPenaltyAndFormatLoss); next step. (C2, E-0357; probed E-0384)
TravelerEvents_Thief_ShowHeroLostG::
    ld hl, $000f ; '0 lost G.'
    call StartMessageHL_B73
    call DeductGoldPenaltyAndFormatLoss
    ld hl, wScriptStep
    inc [hl]
    ret

; Step runner of traveler event $0A, the casino ship slot machine: wScriptStep picks the step. 0
; TravelerEvents_CasinoShip_Welcome, 2 TravelerEvents_CasinoShip_ShowStopTheReelsWith, 4
; TravelerEvents_CasinoShip_SpinReels, 5 TravelerEvents_CasinoShip_FreeSpin, 6
; TravelerEvents_CasinoShip_CheckStopButton, 7 TravelerEvents_CasinoShip_StopReel, 8
; TravelerEvents_CasinoShip_PayOut and 10 ScriptStepBlinkSpritesThenEnd; steps 1, 3 and 9 wait for
; the message (TravelerEvents_Thief_WaitMessage). One step runs per call. (C1, E-0384)
; event $0A: the casino ship's slot machine: 100G a spin, three reels stopped with A, prizes by the
; symbols (E-0364; was TravelerEvents_CasinoShip, named from the wrong message table, E-0293)
TravelerEvents_CasinoShip::
    ld a, [wScriptStep]
    jumptable
    dw TravelerEvents_CasinoShip_Welcome
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_CasinoShip_ShowStopTheReelsWith
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_CasinoShip_SpinReels
    dw TravelerEvents_CasinoShip_FreeSpin
    dw TravelerEvents_CasinoShip_CheckStopButton
    dw TravelerEvents_CasinoShip_StopReel
    dw TravelerEvents_CasinoShip_PayOut
    dw TravelerEvents_Thief_WaitMessage
    dw ScriptStepBlinkSpritesThenEnd

; Casino ship, step 8: after 60 frames restores the screen and tiles and pays out by the reels'
; symbols: three alike pays by the symbol (0 a MeteOrb, 1 a TinyMedal, 2 1000G, 3 500G, others 200G;
; messages $32, $30, $31, $44, $45); only the first two alike pays 100G for symbol 0 ($46) or 50G
; for symbol 1 ($47); otherwise 'Too bad... Try again, OK?' ($35). (C1, E-0357)
TravelerEvents_CasinoShip_PayOut::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $3c
    ret nz
    farcall RestoreScreenBufferFromBGMap1
    farcall DrawFullScreenBufferAtScroll
    ld b, $46
    ld de, LetterFrameIconDigitTiles
    ld hl, vTiles1
    call DecompressToVRAM
    call LoadRecordListNameTiles
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld a, [wMenuState]
    and $f0
    swap a
    ld de, CasinoReel1Symbols
    add e
    ld e, a
    jr nc, .check_menu_sub_state
    inc d

.check_menu_sub_state:
    ld a, [de]
    ld c, a
    ld a, [wMenuSubState]
    and $f0
    swap a
    ld de, CasinoReel2Symbols
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    cp c
    jp nz, .loop
    ld a, [wMenuSelectedMember]
    and $f0
    swap a
    ld de, CasinoReel3Symbols
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    cp c
    jp nz, .check_menu_state
    ld a, [wMenuState]
    and $f0
    swap a
    ld de, CasinoReel1Symbols
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [de]
    or a
    jr nz, .skip4
    ld hl, $0032 ; '*: Whoa! You've won a MeteOrb!'
    call StartMessageHL_B73
    ld a, $1e
    ld [wStepPtrLo], a
    farcall AppendItemStepPtrLoToInventory
    ret

.skip4:
    dec a
    jr nz, .skip5
    ld hl, $0030 ; '*: Lucky! You win a TinyMedal!'
    call StartMessageHL_B73
    ld a, $2c
    ld [wStepPtrLo], a
    farcall AppendItemStepPtrLoToInventory
    ret

.skip5:
    dec a
    jr nz, .skip6
    ld hl, $0031 ; '*: There it is! You win'
    call StartMessageHL_B73
    ld hl, $03e8
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall AddGoldCapped
    ret

.skip6:
    dec a
    jr nz, .call_start_message_hl_b73
    ld hl, $0044 ; '*: Lucky, kid! You've won 500G!'
    call StartMessageHL_B73
    ld hl, $01f4
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall AddGoldCapped
    ret

.call_start_message_hl_b73:
    ld hl, $0045 ; '*: Lucky, kid! You've won 200G!'
    call StartMessageHL_B73
    ld hl, $00c8
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall AddGoldCapped
    ret

.loop:
    ld hl, $0035 ; '*: Too bad… Try again, OK?'
    call StartMessageHL_B73
    ret

.check_menu_state:
    ld a, [wMenuState]
    and $f0
    swap a
    ld de, CasinoReel1Symbols
    add e
    ld e, a
    jr nc, .skip7
    inc d

.skip7:
    ld a, [de]
    or a
    jr nz, .skip8
    ld hl, $0046 ; '*: Lucky, kid! You've won 100G!'
    call StartMessageHL_B73
    ld hl, $0064
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall AddGoldCapped
    ret

.skip8:
    dec a
    jr nz, .loop
    ld hl, $0047 ; '*: Lucky, kid! You've won 50G!'
    call StartMessageHL_B73
    ld hl, $0032
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall AddGoldCapped
    ret

; Casino ship, step 7: the reels spin (every other frame); the reel chosen by wMenuCursor stops when
; its symbol lines up; when all three have stopped goes on, otherwise back to step 6. (C1, E-0357)
TravelerEvents_CasinoShip_StopReel::
    call TravelerEvents_CasinoShip_AdvanceReels
    ld a, [wFrameCounterLo]
    and $01
    jr z, .call_traveler_events_casino_ship_draw_reels
    ld a, [wMenuCursor]
    dec a
    jr nz, .skip
    ld hl, wMenuState
    call TravelerEvents_CasinoShip_TickCounter
    or a
    jr z, .call_traveler_events_casino_ship_draw_reels
    ld hl, wScriptStep
    dec [hl]
    jr .call_traveler_events_casino_ship_draw_reels

.skip:
    dec a
    jr nz, .call_traveler_events_casino_ship_tick_counter
    ld hl, wMenuSubState
    call TravelerEvents_CasinoShip_TickCounter
    or a
    jr z, .call_traveler_events_casino_ship_draw_reels
    ld hl, wScriptStep
    dec [hl]
    jr .call_traveler_events_casino_ship_draw_reels

.call_traveler_events_casino_ship_tick_counter:
    ld hl, wMenuSelectedMember
    call TravelerEvents_CasinoShip_TickCounter
    or a
    jr z, .call_traveler_events_casino_ship_draw_reels
    ld hl, wScriptStep
    inc [hl]

.call_traveler_events_casino_ship_draw_reels:
    call TravelerEvents_CasinoShip_DrawReels
    ret

; HL = the address of a reel byte (high nibble = the symbol 0-9, low nibble = the position inside it
; in sixteenths). When the low nibble is 0 the reel is lined up with a symbol: returns A = 1 and
; leaves the byte alone. Otherwise adds 1 to the byte (a carry out of the low nibble moves on to the
; next symbol), sets the byte to 0 when that makes the symbol 10, and returns A = 0.
; TravelerEvents_CasinoShip_StopReel calls it for the reel that was just stopped, so the reel runs
; on to its next symbol edge. (C2, E-0384)
; returns 1 when the low nibble at HL is 0; otherwise counts the high nibble up and wraps it at 10,
; returning 0
TravelerEvents_CasinoShip_TickCounter::
    ld a, [hl]
    and $0f
    jr z, .return_01
    ld a, [hl]
    inc a
    ld [hl], a
    and $f0
    swap a
    cp $0a
    jr nz, .return_0
    xor a
    ld [hl], a

.return_0:
    xor a
    ret

.return_01:
    ld a, $01
    ret

; Casino ship, step 6: A stops the next reel (wMenuCursor + 1); the reels keep spinning and are
; redrawn. (C1, E-0357)
TravelerEvents_CasinoShip_CheckStopButton::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .call_traveler_events_casino_ship_advance
    ld hl, wMenuCursor
    inc [hl]
    ld hl, wScriptStep
    inc [hl]

.call_traveler_events_casino_ship_advance:
    call TravelerEvents_CasinoShip_AdvanceReels
    call TravelerEvents_CasinoShip_DrawReels
    ret

; Casino ship, step 5: spins and redraws the reels for 30 frames; next step. (C1, E-0357)
TravelerEvents_CasinoShip_FreeSpin::
    call TravelerEvents_CasinoShip_AdvanceReels
    call TravelerEvents_CasinoShip_DrawReels
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $1e
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Casino ship, step 4: saves the screen, sets the three reels to random symbols (0-7), draws the
; slot frame (with CGB attributes); next step. (C1, E-0357)
TravelerEvents_CasinoShip_SpinReels::
    farcall SaveScreenBufferToBGMap1
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $07
    swap a
    ld [wMenuState], a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $07
    swap a
    ld [wMenuSubState], a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and $07
    swap a
    ld [wMenuSelectedMember], a
    xor a
    ld [wMenuCursor], a
    call TravelerEvents_CasinoShip_DrawReels
    ld de, TravelerEvents_CasinoShip_SpinReels_Data
    ld hl, wScreenTileBuffer
    ld b, $03

.loop:
    push hl
    ld a, [de]
    inc de
    ld [hli], a
    ld a, [de]
    inc de
    ld [hli], a
    ld a, [de]
    inc de
    ld [hli], a
    ld a, [de]
    inc de
    ld [hli], a
    ld a, [de]
    inc de
    ld [hli], a
    pop hl
    ld a, [wIsCGB]
    or a
    jr z, .skip
    push hl
    ld a, l
    sub $98
    ld l, a
    ld a, h
    sbc $c1
    ld h, a
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $d0
    ld h, a
    ld a, $02
    ldh [rSVBK], a
    xor a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    xor a
    ldh [rSVBK], a
    pop hl

.skip:
    ld a, $14
    add_a_to_hl
    dec b
    jr nz, .loop
    farcall DrawFullScreenBufferAtScroll
    ld hl, wScriptStep
    inc [hl]
    ret

; Fifteen tile ids forming a slot machine frame of three rows of five tiles: $B0 $B1 $B1 $B1 $B2
; (top edge), $B6 $A4 $A5 $A6 $B7 (middle, where $A4-$A6 are the three reel windows) and $B3 $B4 $B4
; $B4 $B5 (bottom edge). TravelerEvents_CasinoShip_SpinReels copies the rows into wScreenTileBuffer,
; one row every $14 tiles, then draws the buffer with DrawFullScreenBufferAtScroll. (C1, E-0381)
TravelerEvents_CasinoShip_SpinReels_Data::
    db $b0, $b1, $b1, $b1, $b2, $b6, $a4, $a5, $a6, $b7, $b3, $b4, $b4, $b4, $b5

; Casino ship, step 2: yes takes 100G with SubtractGoldFloorZero (the gold is not checked first:
; with wGoldHi 0 and under 100G it wraps to $FFxxxx) and starts message $2F ('Stop the reels with
; the A Button...'); next step. No starts message $36 (the see-you-again line) and sets step 9. (C2,
; E-0384)
TravelerEvents_CasinoShip_ShowStopTheReelsWith::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b73
    ld hl, $002f ; '*: Stop the reels with the'
    call StartMessageHL_B73
    ld hl, $0064
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall SubtractGoldFloorZero
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b73:
    ld hl, $0036 ; '*: That's too bad. See you'
    call StartMessageHL_B73
    ld a, $09
    ld [wScriptStep], a
    ret

; Casino ship, step 0: 'Welcome aboard the casino ship! Have a spin on the slots for 100G!' ($2E,
; yes/no); next step. (C2, E-0357; probed E-0384)
TravelerEvents_CasinoShip_Welcome::
    ld hl, wScriptStep
    inc [hl]
    ld hl, $002e ; '*: Welcome aboard the casino ship!'
    call StartMessageHL_B73
    ret

; Every other frame (wFrameCounterLo odd) turns the reels not yet stopped (wMenuCursor = how many
; times A has been pressed; 3 = all stopped): reel 1 (wMenuState) by 2, reel 2 (wMenuSubState) by 1
; and reel 3 (wMenuSelectedMember) by 4. In each byte the high nibble is the symbol, wrapping after
; ten, and the low nibble the position within it in sixteenths. (C2, E-0371; probed E-0384)
TravelerEvents_CasinoShip_AdvanceReels::
    ld a, [wFrameCounterLo]
    and $01
    ret z
    ld a, [wMenuCursor]
    cp $03
    ret z
    or a
    jr nz, .check_menu_cursor
    ld a, [wMenuState]
    add $02
    ld [wMenuState], a
    and $f0
    swap a
    cp $0a
    jr nz, .check_menu_cursor
    ld a, [wMenuState]
    and $0f
    ld [wMenuState], a

.check_menu_cursor:
    ld a, [wMenuCursor]
    cp $02
    jr z, .read_menu_selected_member
    ld a, [wMenuSubState]
    add $01
    ld [wMenuSubState], a
    and $f0
    swap a
    cp $0a
    jr nz, .read_menu_selected_member
    ld a, [wMenuSubState]
    and $0f
    ld [wMenuSubState], a

.read_menu_selected_member:
    ld a, [wMenuSelectedMember]
    add $04
    ld [wMenuSelectedMember], a
    and $f0
    swap a
    cp $0a
    jr nz, .return
    ld a, [wMenuSelectedMember]
    and $0f
    ld [wMenuSelectedMember], a

.return:
    ret

; Draws the three reels' current and next symbols (DrawSymbolTilesForTemp1) from their symbol rows.
; (C1, E-0357)
TravelerEvents_CasinoShip_DrawReels::
    ld hl, vTiles1 + $240
    ld a, [wMenuState]
    and $f0
    swap a
    push af
    ld de, CasinoReel1Symbols
    add e
    ld e, a
    jr nc, .set_temp0
    inc d

.set_temp0:
    ld a, [de]
    ldh [hTemp0], a
    pop af
    inc a
    cp $0a
    jr nz, .skip
    ld a, $00

.skip:
    ld de, CasinoReel1Symbols
    add e
    ld e, a
    jr nc, .set_temp1
    inc d

.set_temp1:
    ld a, [de]
    ldh [hTemp1], a
    ld a, [wMenuState]
    call DrawSymbolTilesForTemp1
    ld a, [wMenuSubState]
    and $f0
    swap a
    push af
    ld de, CasinoReel2Symbols
    add e
    ld e, a
    jr nc, .set_temp02
    inc d

.set_temp02:
    ld a, [de]
    ldh [hTemp0], a
    pop af
    inc a
    cp $0a
    jr nz, .skip2
    ld a, $00

.skip2:
    ld de, CasinoReel2Symbols
    add e
    ld e, a
    jr nc, .set_temp12
    inc d

.set_temp12:
    ld a, [de]
    ldh [hTemp1], a
    ld a, [wMenuSubState]
    call DrawSymbolTilesForTemp1
    ld a, [wMenuSelectedMember]
    and $f0
    swap a
    push af
    ld de, CasinoReel3Symbols
    add e
    ld e, a
    jr nc, .set_temp03
    inc d

.set_temp03:
    ld a, [de]
    ldh [hTemp0], a
    pop af
    inc a
    cp $0a
    jr nz, .skip3
    ld a, $00

.skip3:
    ld de, CasinoReel3Symbols
    add e
    ld e, a
    jr nc, .set_temp13
    inc d

.set_temp13:
    ld a, [de]
    ldh [hTemp1], a
    ld a, [wMenuSelectedMember]
    call DrawSymbolTilesForTemp1
    ret

; Writes one 16-byte reel window tile to video RAM at HL (HL advances 16) with WriteVRAMByteInc. A =
; the reel byte, whose bits 1-3 (A AND $0E, kept in hTemp2) are the scroll offset in bytes (even,
; 0-14); hTemp0 = the symbol shown now and hTemp1 = the symbol after it (0-4, tiles of
; DrawSymbolTilesForTemp1_SymbolTiles). With an offset the tile starts with the last hTemp2 bytes of
; the next symbol and goes on with the first 16 - hTemp2 bytes of the current one; with offset 0 it
; is the current symbol alone. Clobbers A, BC, DE and hTemp2. (C1, E-0384)
; A & $0E -> hTemp2; when it is not zero, points DE into DrawSymbolTilesForTemp1_SymbolTiles at
; hTemp1 * 16 + (16 - hTemp2) and copies the tiles
DrawSymbolTilesForTemp1::
    and $0e
    ldh [hTemp2], a
    or a
    jr z, .read_temp23
    ldh a, [hTemp1]
    swap a
    ld de, DrawSymbolTilesForTemp1_SymbolTiles
    add e
    ld e, a
    jr nc, .read_temp2
    inc d

.read_temp2:
    ldh a, [hTemp2]
    ld c, a
    ld a, $10
    sub c
    add e
    ld e, a
    jr nc, .read_temp22
    inc d

.read_temp22:
    ldh a, [hTemp2]
    ld b, a

.loop:
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, .loop

.read_temp23:
    ldh a, [hTemp2]
    ld c, a
    ld a, $10
    sub c
    ld b, a
    ldh a, [hTemp0]
    swap a
    ld de, DrawSymbolTilesForTemp1_SymbolTiles
    add e
    ld e, a
    jr nc, .loop2
    inc d

.loop2:
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, .loop2
    ret

; the routine at DrawSymbolTilesForTemp1.loop / DrawSymbolTilesForTemp1.loop2 copies 16 bytes, or a
; part of them, from $44EA + 16 * hTemp1 (or hTemp0) to VRAM with WriteVRAMByteInc; 5 tiles end at
; the first of three 10-byte tables (E-0214, C1)
; record: one 2bpp tile (16 bytes)
DrawSymbolTilesForTemp1_SymbolTiles::
    db $ff, $00, $ff, $10, $ff, $38, $ff, $fe, $ff, $7c, $ff, $38, $ff, $7c, $ff, $c6 ; id 0
    db $ff, $00, $ff, $38, $ff, $7c, $ff, $fe, $ff, $fe, $ff, $fe, $ff, $7c, $ff, $38 ; id 1
    db $ff, $00, $ff, $7e, $ff, $7e, $ff, $7e, $ff, $7e, $ff, $7e, $ff, $7e, $ff, $00 ; id 2
    db $ff, $00, $ff, $00, $ff, $10, $ff, $38, $ff, $7c, $ff, $fe, $ff, $fe, $ff, $00 ; id 3
    db $ff, $00, $ff, $00, $ff, $44, $ff, $28, $ff, $10, $ff, $28, $ff, $44, $ff, $00 ; id 4

; bank-$73 code reads the byte at $453A + (wMenuState >> 4) and compares the three tables' values
; with each other; values 0-4, one of the five tiles of DrawSymbolTilesForTemp1_SymbolTiles (E-0214,
; C1)
; record: symbol number 0-4
CasinoReel1Symbols::
    db $01 ; id 0
    db $03 ; id 1
    db $00 ; id 2
    db $02 ; id 3
    db $04 ; id 4
    db $01 ; id 5
    db $03 ; id 6
    db $00 ; id 7
    db $02 ; id 8
    db $04 ; id 9

; bank-$73 code reads the byte at $4544 + (wMenuSubState >> 4) and compares the three tables' values
; with each other; values 0-4, one of the five tiles of DrawSymbolTilesForTemp1_SymbolTiles (E-0214,
; C1)
CasinoReel2Symbols::
    db $03 ; id 0
    db $00 ; id 1
    db $04 ; id 2
    db $02 ; id 3
    db $04 ; id 4
    db $04 ; id 5
    db $03 ; id 6
    db $01 ; id 7
    db $02 ; id 8
    db $01 ; id 9

; bank-$73 code reads the byte at $454E + (wMenuSelectedMember >> 4) and compares the three tables'
; values with each other; values 0-4, one of the five tiles of DrawSymbolTilesForTemp1_SymbolTiles
; (E-0214, C1)
CasinoReel3Symbols::
    db $00 ; id 0
    db $02 ; id 1
    db $03 ; id 2
    db $04 ; id 3
    db $01 ; id 4
    db $04 ; id 5
    db $03 ; id 6
    db $04 ; id 7
    db $02 ; id 8
    db $03 ; id 9

; No caller found. A = party index: adds the byte wMenuState to one of six stat words of the SRAM
; record wPartyList[A], the stat chosen by wScriptParam0 (0-5) through
; AddMenuStateToPartyStatCapped_StatOffsets, which holds the record field offsets MON_MAX_HP,
; MON_MAX_MP, MON_ATK, MON_DEF, MON_AGL and MON_INT, not amounts. The new word is stored back, and
; the gain is written as digits into wTextNumber. A sum from $3E8 to $3FF is stored as 999; a sum of
; $400 or more is stored as it is. It does the same job as TravelerEvents_MedicineMaster_BoostStat,
; which adds 20. (C2, E-0384)
; HL = $C6FE + A; with SRAM enabled ($0100 = $0A) adds the byte at $45CA + wScriptParam0 to the
; 16-bit value read through LoadSRAMRecordWord, caps it at 999, writes it back through
; SRAMRecordAddress, stores the difference in wDigits/wDigits + $1 and shows it
; (Number24ToPackedBCD, WritePackedBCDNoLeadingZeros); no caller found (E-0214)
AddMenuStateToPartyStatCapped:: ; configured code entry (E-0214); C0
    ld hl, wPartyList
    add_a_to_hl
    ld a, $0a
    ld [rRAMG], a
    ld a, [wScriptParam0]
    ld de, AddMenuStateToPartyStatCapped_StatOffsets
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld c, a
    ld a, [hl]
    call LoadSRAMRecordWord
    push bc
    ld a, [wMenuState]
    ld c, a
    ldh a, [hTemp0]
    add c
    ldh [hTemp2], a
    ldh a, [hTemp1]
    adc $00
    ldh [hTemp3], a
    pop bc
    ldh a, [hTemp3]
    cp $03
    jr nz, .call_sram_record_address
    ldh a, [hTemp2]
    cp $e8
    jr c, .call_sram_record_address
    ld de, $03e7
    ld a, e
    ldh [hTemp2], a
    ld a, d
    ldh [hTemp3], a

.call_sram_record_address:
    ld a, [hl]
    call SRAMRecordAddress
    ldh a, [hTemp2]
    ld [hli], a
    ldh a, [hTemp3]
    ld [hl], a
    xor a
    ld [rRAMG], a
    ldh a, [hTemp0]
    ld c, a
    ldh a, [hTemp2]
    sub c
    ld [wDigits], a
    ldh a, [hTemp1]
    ld c, a
    ldh a, [hTemp3]
    sbc c
    ld [wDigits + $1], a
    xor a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ld de, wTextNumber
    call WritePackedBCDNoLeadingZeros
    ret

; AddMenuStateToPartyStatCapped adds the byte at $45CA + wScriptParam0; 6 bytes end at the code
; after them (E-0214, C1)
; record: amount added
AddMenuStateToPartyStatCapped_StatOffsets::
    db $5d ; id 0
    db $61 ; id 1
    db $63 ; id 2
    db $65 ; id 3
    db $67 ; id 4
    db $69 ; id 5

; Step runner of traveler event 8, the map seller: wScriptStep picks the step. 0
; TravelerEvents_MapSeller_ShowDoYouWantA, 2 TravelerEvents_MapSeller_ShowHeroHandedOver2Hero, 3
; TravelerEvents_MapSeller_SavePalettes, 4 TravelerEvents_MapSeller_FlashScreen, 5
; TravelerEvents_MapSeller_Msg0052_NowYouCanSee and 7 ScriptStepBlinkSpritesThenEnd; steps 1 and 6
; wait for the message (TravelerEvents_Thief_WaitMessage). One step runs per call. (C1, E-0384)
; event 8: 'Do you want a map? Just 200G.': on yes marks every screen visited (E-0364; was
; TravelerEvents_MapSeller, named from the wrong message table, E-0293)
TravelerEvents_MapSeller::
    ld a, [wScriptStep]
    jumptable
    dw TravelerEvents_MapSeller_ShowDoYouWantA
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_MapSeller_ShowHeroHandedOver2Hero
    dw TravelerEvents_MapSeller_SavePalettes
    dw TravelerEvents_MapSeller_FlashScreen
    dw TravelerEvents_MapSeller_Msg0052_NowYouCanSee
    dw TravelerEvents_Thief_WaitMessage
    dw ScriptStepBlinkSpritesThenEnd

; Map seller, step 0: 'Do you want a map? Just 200G.' ($21, yes/no); next step. (C2, E-0357; probed
; E-0384)
TravelerEvents_MapSeller_ShowDoYouWantA::
    ld hl, wScriptStep
    inc [hl]
    ld hl, MSG_KEEP_OPEN | $0021 ; 'Do you want a map? Just'
    call StartMessageHL_B73
    ret

; Map seller, step 2: yes marks every screen visited, takes 200G and says '<player> handed over
; 200G.' ($23), next step; no gives 'No? That's too bad.' ($22) and step 6. (C2, E-0357; probed
; E-0384)
TravelerEvents_MapSeller_ShowHeroHandedOver2Hero::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b73
    ld hl, MSG_ALREADY_OPEN | $0023 ; '0 handed over 200G.'
    call StartMessageHL_B73
    ld a, $ff
    ld [wVisitedScreens], a
    ld [wVisitedScreens + $1], a
    ld [wVisitedScreens + $2], a
    ld [wVisitedScreens + $3], a
    ld [wVisitedScreens + $4], a
    ld [wVisitedScreens + $5], a
    ld [wVisitedScreens + $6], a
    ld [wVisitedScreens + $7], a
    ld hl, $00c8
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall SubtractGoldFloorZero
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b73:
    ld hl, MSG_ALREADY_OPEN | $0022 ; '*: No? That's too bad.'
    call StartMessageHL_B73
    ld a, $06
    ld [wScriptStep], a
    ret

; Map seller, step 4: the screen flash (ScriptStepFlashScreenNegative). (C2, E-0357; probed E-0384)
TravelerEvents_MapSeller_FlashScreen::
    farcall ScriptStepFlashScreenNegative
    ret

; Map seller, step 5: 'Now you can see the entire world!' ($52); next step. (C2, E-0357; probed
; E-0384)
TravelerEvents_MapSeller_Msg0052_NowYouCanSee::
    ld hl, $0052 ; '*: Now you can see the'
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; Step runner of traveler event 6, the high-low card game: wScriptStep picks the step. 0
; TravelerEvents_CardGame_OfferPrize, 2 TravelerEvents_CardGame_ShowIllPickACard, 4
; TravelerEvents_CardGame_ShowIPickedOhSame, 9 TravelerEvents_CardGame_ShowDoYouThinkThe, 13
; TravelerEvents_CardGame_ShowHeroObtainedTheY; steps 6, 15 and 17 are
; ScriptStepBlinkSpritesThenEnd, and steps 1, 3, 5, 8, 12, 14 and 16 wait for the message
; (TravelerEvents_Thief_WaitMessage). Steps 7, 10 and 11 hold the word $0000 and no step number
; reaches them. (C1, E-0384)
; event 6: the high-low card game: guess whether a card from 1 to 13 is above the last one, for
; prizes over up to five rounds (E-0364; was TravelerEvents_CardGame, named from the wrong message
; table, E-0293)
TravelerEvents_CardGame::
    ld a, [wScriptStep]
    jumptable
    dw TravelerEvents_CardGame_OfferPrize
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_CardGame_ShowIllPickACard
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_CardGame_ShowIPickedOhSame
    dw TravelerEvents_Thief_WaitMessage
    dw ScriptStepBlinkSpritesThenEnd
    dw $0000 ; unused index (E-0207)
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_CardGame_ShowDoYouThinkThe
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_CardGame_ShowHeroObtainedTheY
    dw TravelerEvents_Thief_WaitMessage
    dw ScriptStepBlinkSpritesThenEnd
    dw TravelerEvents_Thief_WaitMessage
    dw ScriptStepBlinkSpritesThenEnd

; Card game, step 13: '<player> obtained the <prize>.' ($1B) and the prize goes into the bag; next
; step. (C2, E-0357; probed E-0384)
TravelerEvents_CardGame_ShowHeroObtainedTheY::
    ld hl, wScriptStep
    inc [hl]
    ld hl, $001b ; '0 obtained the Y.'
    call StartMessageHL_B73
    ld a, [wMenuSelectedMember]
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld a, [wMenuSelectedMember]
    ld [wStepPtrLo], a
    farcall AppendItemStepPtrLoToInventory
    ret

; Card game, step 9: yes plays on with the last card as the mark ('Do you think the next card I pick
; will be above <n>?', $19) from step 3; no gives 'Awww, you won't play? Please come again and try
; your luck!' ($1A) and step $0C, where the prize is handed over. (C2, E-0357; probed E-0384)
TravelerEvents_CardGame_ShowDoYouThinkThe::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b73
    ld a, [wMenuSubState]
    ld [wMenuState], a
    ld hl, MSG_KEEP_OPEN | MSG_ALREADY_OPEN | $0019 ; '*: Do you think the next'
    call StartMessageHL_B73
    ld a, $03
    ld [wScriptStep], a
    ret

.call_start_message_hl_b73:
    ld hl, MSG_ALREADY_OPEN | $001a ; '*: Awww, you won't play? Please'
    call StartMessageHL_B73
    ld a, $0c
    ld [wScriptStep], a
    ret

; Card game, step 4: draws a card (1-13): the same number as the mark loses ('Oh, same number?
; Sorry, I win in this case.', $18); guessing right (above with yes, below with no) wins: after the
; fifth win the last prize ('That was the last prize!', $1C, step $0E), otherwise the next prize
; (one of four from the table row for the win count) and the next stake ('Wow! You win! Next,
; <prize> is the prize.', $16); guessing wrong loses ('Whoops, you lose. I'll take <n>G and any
; prize.', $17). (C2, E-0357; probed E-0384)
TravelerEvents_CardGame_ShowIPickedOhSame::
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and $0f
    cp $0d
    jr nc, TravelerEvents_CardGame_ShowIPickedOhSame
    ld [wMenuSubState], a
    inc a
    ld [wDigits], a
    xor a
    ld [wDigits + $1], a
    xor a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ld de, wTextNumber
    call WritePackedBCDNoLeadingZeros
    ld a, [wMenuState]
    ld c, a
    ld a, [wMenuSubState]
    cp c
    jr nz, .check_text_yes_no_result
    ld hl, MSG_ALREADY_OPEN | $0018 ; '*: I picked… ! Oh, same'
    call StartMessageHL_B73
    jp .read_script_param1

.check_text_yes_no_result:
    ld a, [wTextYesNoResult]
    or a
    jr nz, .read_menu_state
    ld a, [wMenuState]
    ld c, a
    ld a, [wMenuSubState]
    cp c
    jp c, .call_start_message_hl_b73
    jr .check_script_param1

.read_menu_state:
    ld a, [wMenuState]
    ld c, a
    ld a, [wMenuSubState]
    cp c
    jp nc, .call_start_message_hl_b73
    jr .check_script_param1

.check_script_param1:
    ld a, [wScriptParam1]
    inc a
    ld [wScriptParam1], a
    ld a, [wScriptParam0]
    ld [wMenuSelectedMember], a
    ld a, [wScriptParam1]
    cp $05
    jr nz, .call_next_random_seed
    ld hl, MSG_ALREADY_OPEN | $001c ; '*: I picked… ! Wow! You'
    call StartMessageHL_B73
    ld a, [wMenuSelectedMember]
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld a, [wMenuSelectedMember]
    ld [wStepPtrLo], a
    farcall AppendItemStepPtrLoToInventory
    ld a, $0e
    ld [wScriptStep], a
    ret

.call_next_random_seed:
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and $03
    ld hl, TravelerEvents_CardGame_ShowIPickedOhSame_Data1
    add_a_to_hl
    ld a, [wScriptParam1]
    add a
    add a
    add_a_to_hl
    ld a, [hl]
    ld [wScriptParam0], a
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld a, [wScriptParam1]
    sla a
    ld hl, TravelerEvents_CardGame_ShowIPickedOhSame_Data2
    add_a_to_hl
    ld a, [hli]
    ld [wDigits], a
    ld a, [hl]
    ld [wDigits + $1], a
    xor a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ld de, wTextNumber + $3
    call WritePackedBCDNoLeadingZeros
    ld hl, MSG_KEEP_OPEN | MSG_ALREADY_OPEN | $0016 ; '*: I picked… ! Wow! You'
    call StartMessageHL_B73
    ld a, $08
    ld [wScriptStep], a
    ret

.call_start_message_hl_b73:
    ld hl, MSG_ALREADY_OPEN | $0017 ; '*: I picked… ! Whoops, you'
    call StartMessageHL_B73

.read_script_param1:
    ld a, [wScriptParam1]
    add a
    ld hl, TravelerEvents_CardGame_ShowIPickedOhSame_Data2
    add_a_to_hl
    ld a, [hli]
    ld [wDigits], a
    ld a, [hl]
    ld [wDigits + $1], a
    xor a
    ld [wDigits + $2], a
    ld a, [wDigits]
    ld c, a
    ld a, [wGoldLo]
    sub c
    ld [wGoldLo], a
    ld a, [wDigits + $1]
    ld c, a
    ld a, [wGoldMid]
    sbc c
    ld [wGoldMid], a
    ld a, [wGoldHi]
    sbc $00
    ld [wGoldHi], a
    call Number24ToPackedBCD
    ld de, wTextNumber + $3
    call WritePackedBCDNoLeadingZeros
    ld hl, wScriptStep
    inc [hl]
    ret

; Card game, step 2: yes sets the mark to 7 ('I'll pick a card between 1 and 13. Is the card I
; picked above 7?', $14) and goes on; no gives 'I'll have nice prizes next time.' ($15) and step
; $10. (C2, E-0357; probed E-0384)
TravelerEvents_CardGame_ShowIllPickACard::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b73
    ld a, $06
    ld [wMenuState], a
    ld hl, MSG_KEEP_OPEN | MSG_ALREADY_OPEN | $0014 ; '*: I'll pick a card between'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, MSG_ALREADY_OPEN | $0015 ; '*: I'll have nice prizes next'
    call StartMessageHL_B73
    ld a, $10
    ld [wScriptStep], a
    ret

; Card game, step 0: picks the first prize at random (one of four) and offers it ('Hi! Want to try
; your luck? <prize> is the prize!', $13); next step. (C2, E-0357; probed E-0384)
TravelerEvents_CardGame_OfferPrize::
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and $03
    ld hl, TravelerEvents_CardGame_ShowIPickedOhSame_Data1
    add_a_to_hl
    ld a, [hl]
    ld [wScriptParam0], a
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld hl, MSG_KEEP_OPEN | $0013 ; '*: Hi! Want to try your'
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; Five rows of four item ids (20 bytes), the possible prizes of the card game, one row per win count
; (wScriptParam1 0-4): ITEM_WORLDDEW, ITEM_MIST, ITEM_WARP, ITEM_EXITBELL; ITEM_SAGEROCK, ITEM_BOLT,
; ITEM_ELFWATER, ITEM_BOOKMARK; ITEM_WORLDLEAF, ITEM_FRIEND, ITEM_FIRE, ITEM_TINYMEDAL;
; ITEM_LIFEACORN, ITEM_MYSTICNUT, ITEM_SNOW, ITEM_METEORB; ITEM_ATKSEED, ITEM_DEFSEED, ITEM_AGLSEED,
; ITEM_INTSEED. The column is wKeyRandomLo AND 3; the chosen id goes to wScriptParam0 and its name
; to the message text. TravelerEvents_CardGame_OfferPrize reads row 0 and
; TravelerEvents_CardGame_ShowIPickedOhSame the row of the next win count. (C1, E-0381)
TravelerEvents_CardGame_ShowIPickedOhSame_Data1::
    db $03, $22, $28, $2a, $0b, $25, $05, $2b, $0c, $23, $27, $2c, $11, $12, $26, $1e
    db $0d, $0e, $0f, $10

; Five little-endian words, 100, 300, 600, 1000 and 1500, one per win count (wScriptParam1 0-4): the
; gold stake of the card game at that level. TravelerEvents_CardGame_ShowIPickedOhSame loads the
; word into wDigits, converts it with Number24ToPackedBCD and writes it into wTextNumber for the
; message "I will take <n>G and any prize" on a loss, or the next stake on a win. (C1, E-0381)
TravelerEvents_CardGame_ShowIPickedOhSame_Data2::
    db $64, $00, $2c, $01, $58, $02, $e8, $03, $dc, $05

; Step runner of traveler event 9, the medicine master: wScriptStep picks the step. 0
; TravelerEvents_MedicineMaster_Offer, 2 TravelerEvents_MedicineMaster_Answer, 4
; TravelerEvents_Thief_StartBattle, 5 TravelerEvents_MedicineMaster_AfterBattle, 7
; TravelerEvents_MedicineMaster_RaiseStat, 9 TravelerEvents_MedicineMaster_RaiseStat2, 11
; TravelerEvents_MedicineMaster_ShowNsYRoseBy and 13 ScriptStepBlinkSpritesThenEnd; steps 1, 3, 6,
; 8, 10 and 12 wait for the message (TravelerEvents_Thief_WaitMessage). (C1, E-0384)
; event 9: a battle for 'special medicine': a win raises a stat of each party monster by up to 20
; (E-0364; was TravelerEvents_MedicineMaster, named from the wrong message table, E-0293)
TravelerEvents_MedicineMaster::
    ld a, [wScriptStep]
    jumptable
    dw TravelerEvents_MedicineMaster_Offer
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_MedicineMaster_Answer
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_Thief_StartBattle
    dw TravelerEvents_MedicineMaster_AfterBattle
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_MedicineMaster_RaiseStat
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_MedicineMaster_RaiseStat2
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_MedicineMaster_ShowNsYRoseBy
    dw TravelerEvents_Thief_WaitMessage
    dw ScriptStepBlinkSpritesThenEnd

; Medicine master, step 0: 'I'll give you special medicine if you manage to defeat me.' ($24); next
; step. (C2, E-0357; probed E-0384)
TravelerEvents_MedicineMaster_Offer::
    ld hl, wScriptStep
    inc [hl]
    ld hl, MSG_KEEP_OPEN | $0024 ; '*: I'll give you special medicine'
    call StartMessageHL_B73
    ret

; Medicine master, step 2: no gives message $50 ('I thought you were dedicated...') and step $0C;
; yes gives message $51 ('My eyes didn't mislead me. Ready?') and the next step. (C2, E-0357; probed
; E-0384)
TravelerEvents_MedicineMaster_Answer::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b73
    ld hl, MSG_ALREADY_OPEN | $0051 ; '*: My eyes didn't mislead me.'
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b73:
    ld hl, MSG_ALREADY_OPEN | $0050 ; '*: I thought you were dedicated…'
    call StartMessageHL_B73
    ld a, $0c
    ld [wScriptStep], a
    ret

; Medicine master, step 5: after the battle, a win gives 'You've won. As promised, let me give you
; some of my medicine.' ($25); a loss gives message $53 ('I hope you'll put up more of a fight next
; time...'). (C2, E-0357; probed E-0384)
TravelerEvents_MedicineMaster_AfterBattle::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wBattleScene]
    or a
    jr nz, .call_start_message_hl_b73
    ld hl, $0025 ; '*: You've won. As promised, let'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, $0053 ; '*: I hope you'll put up'
    call StartMessageHL_B73
    ret

; Medicine master, step 7: on a win finds the lowest of the six stats of party member 0
; (MedicineMaster_FindLowestStat sets wScriptParam0 and the stat name), copies the name of the
; monster (TravelerEvents_MedicineMaster_CopyMonsterName) and raises that stat by 20, at most 999
; (TravelerEvents_MedicineMaster_BoostStat), then starts message $26 (the stat rose message): with
; MSG_KEEP_OPEN and on to the next step when a second monster that is not fallen (MON_STATUS bit 7)
; follows, otherwise without it and with step $0C. On a loss starts message $0F, takes the gold
; penalty (DeductGoldPenaltyAndFormatLoss) and sets step $0C. (C2, E-0384)
TravelerEvents_MedicineMaster_RaiseStat::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wBattleScene]
    or a
    jr nz, .call_start_message_hl_b73
    ld a, $00
    call MedicineMaster_FindLowestStat
    ld a, $00
    call TravelerEvents_MedicineMaster_CopyMonsterName
    ld a, $00
    call TravelerEvents_MedicineMaster_BoostStat
    ld a, [wPartyCount]
    dec a
    jr nz, .read_party_list

.loop:
    ld hl, $0026 ; 'N's Y rose by .'
    call StartMessageHL_B73
    ld a, $0c
    ld [wScriptStep], a
    ret

.read_party_list:
    ld a, $0a
    ld [rRAMG], a
    ld a, [wPartyList + $1]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    xor a
    ld [rRAMG], a
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .loop
    ld hl, MSG_KEEP_OPEN | $0026 ; 'N's Y rose by .'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, $000f ; '0 lost G.'
    call StartMessageHL_B73
    call DeductGoldPenaltyAndFormatLoss
    ld a, $0c
    ld [wScriptStep], a
    ret

; Medicine master, step 9: the same for party member 1: raises its lowest stat by 20 (at most 999)
; and starts message $26 with MSG_ALREADY_OPEN; with MSG_KEEP_OPEN as well and on to the next step
; when a third monster that is not fallen (MON_STATUS bit 7) follows, otherwise with step $0C. (C2,
; E-0384)
TravelerEvents_MedicineMaster_RaiseStat2::
    ld hl, wScriptStep
    inc [hl]
    ld a, $01
    call MedicineMaster_FindLowestStat
    ld a, $01
    call TravelerEvents_MedicineMaster_CopyMonsterName
    ld a, $01
    call TravelerEvents_MedicineMaster_BoostStat
    ld a, [wPartyCount]
    dec a
    dec a
    jr nz, .read_party_list

.loop:
    ld hl, MSG_ALREADY_OPEN | $0026 ; 'N's Y rose by .'
    call StartMessageHL_B73
    ld a, $0c
    ld [wScriptStep], a
    ret

.read_party_list:
    ld a, $0a
    ld [rRAMG], a
    ld a, [wPartyList + $2]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    xor a
    ld [rRAMG], a
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .loop
    ld hl, MSG_KEEP_OPEN | MSG_ALREADY_OPEN | $0026 ; 'N's Y rose by .'
    call StartMessageHL_B73
    ret

; Medicine master, step 11: the same for party member 2: starts message $26 with MSG_ALREADY_OPEN,
; raises the lowest stat of that monster by 20 (at most 999) and goes to the next step. (C2, E-0384)
TravelerEvents_MedicineMaster_ShowNsYRoseBy::
    ld hl, wScriptStep
    inc [hl]
    ld hl, MSG_ALREADY_OPEN | $0026 ; 'N's Y rose by .'
    call StartMessageHL_B73
    ld a, $02
    call MedicineMaster_FindLowestStat
    ld a, $02
    call TravelerEvents_MedicineMaster_CopyMonsterName
    ld a, $02
    call TravelerEvents_MedicineMaster_BoostStat
    ret

; A = party index: reads the six stat words MON_MAX_HP, MON_MAX_MP, MON_ATK, MON_DEF, MON_AGL and
; MON_INT of the SRAM record wPartyList[A] and keeps the index 0-5 of the lowest (the first one when
; several are equal) in hTemp2, comparing with MedicineMaster_FindLowestStat_KeepLowest. Then
; MedicineMaster_CopyStatName stores that index in wScriptParam0 and copies the stat name ('HP',
; 'MP', 'ATK', 'DEF', 'AGL' or 'INT') to wTextBuf2 + 2. The medicine master steps use it to pick the
; stat to raise. (C2, E-0384)
; for record wPartyList[A]: passes word field $5D and word fields $61, $63, $65, $67, $69 (B = 1-5)
; to MedicineMaster_FindLowestStat_KeepLowest, then copies the item string to wTextBuf2 + $2
; (E-0121)
MedicineMaster_FindLowestStat::
    ld hl, wPartyList
    add_a_to_hl
    ld a, $0a
    ld [rRAMG], a
    xor a
    ldh [hTemp2], a
    ld a, [hl]
    ld c, MON_MAX_HP
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ld b, $01
    ld a, [hl]
    ld c, MON_MAX_MP
    call LoadSRAMRecordWord
    call MedicineMaster_FindLowestStat_KeepLowest
    ld b, $02
    ld a, [hl]
    ld c, MON_ATK
    call LoadSRAMRecordWord
    call MedicineMaster_FindLowestStat_KeepLowest
    ld b, $03
    ld a, [hl]
    ld c, MON_DEF
    call LoadSRAMRecordWord
    call MedicineMaster_FindLowestStat_KeepLowest
    ld b, $04
    ld a, [hl]
    ld c, MON_AGL
    call LoadSRAMRecordWord
    call MedicineMaster_FindLowestStat_KeepLowest
    ld b, $05
    ld a, [hl]
    ld c, MON_INT
    call LoadSRAMRecordWord
    call MedicineMaster_FindLowestStat_KeepLowest
    xor a
    ld [rRAMG], a
    call MedicineMaster_CopyStatName
    ret

; Keeps the lowest stat so far: when the word hTemp0/hTemp1 is below DE, hTemp2 = B (its index) and
; DE = the word. (C2, E-0357; probed E-0384)
MedicineMaster_FindLowestStat_KeepLowest::
    ldh a, [hTemp1]
    cp d
    jr c, .set_temp2
    ret nz
    ldh a, [hTemp0]
    cp e
    ret nc

.set_temp2:
    ld a, b
    ldh [hTemp2], a
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ret

; hTemp2 = a stat index 0-5: stores it in wScriptParam0 and copies string hTemp2 + $28 of bank $09
; category 5 (CopyStringToBuffer_Bank09), which is the stat name 'HP', 'MP', 'ATK', 'DEF', 'AGL' or
; 'INT', to wTextBuf2 + 2. (C2, E-0384)
; wScriptParam0 = hTemp2; copies string hTemp2 + $28 of category 5 (item names) to wTextBuf2 + $2
; (CopyStringToBuffer_Bank09) (E-0118) (E-0340: the address in its name read as its RAM name; was
; MedicineMaster_CopyStatName)
MedicineMaster_CopyStatName::
    ldh a, [hTemp2]
    ld [wScriptParam0], a
    add $28
    ld [wStringIndex], a
    ld a, $05
    ld [wStringCategory], a
    ld hl, wTextBuf2 + $2
    ld a, l
    ld [wStringDestLo], a
    ld a, h
    ld [wStringDestHi], a
    farcall CopyStringToBuffer_Bank09
    ret

; A = party index: copies the 10 name bytes of the SRAM record wPartyList[A] to wTextBuf1 + $7 and
; writes $F0 after them; the last name byte and the $F0 land in wTextBuf2 and wTextBuf2 + $1,
; because the buffers are only 16 bytes apart. (C2, E-0384)
TravelerEvents_MedicineMaster_CopyMonsterName::
    ld hl, wPartyList
    add_a_to_hl
    ld a, $0a
    ld [rRAMG], a
    ld a, [hl]
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    xor a
    ld [rRAMG], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf1 + $7
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

; A = party index: raises one stat word of the SRAM record wPartyList[A], the field chosen by
; wScriptParam0 (0-5) through TravelerEvents_MedicineMaster_BoostStat_Data, by 20. A result from
; $3E8 to $3FF is stored as 999 (a larger one would be stored as it is). The gain actually added is
; written as digits into wTextNumber. (C2, E-0384)
TravelerEvents_MedicineMaster_BoostStat::
    ld hl, wPartyList
    add_a_to_hl
    ld a, $0a
    ld [rRAMG], a
    ld a, [wScriptParam0]
    ld de, TravelerEvents_MedicineMaster_BoostStat_Data
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld c, a
    ld a, [hl]
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    add $14
    ldh [hTemp2], a
    ldh a, [hTemp1]
    adc $00
    ldh [hTemp3], a
    ldh a, [hTemp3]
    cp $03
    jr nz, .call_sram_record_address
    ldh a, [hTemp2]
    cp $e8
    jr c, .call_sram_record_address
    ld de, $03e7
    ld a, e
    ldh [hTemp2], a
    ld a, d
    ldh [hTemp3], a

.call_sram_record_address:
    ld a, [hl]
    call SRAMRecordAddress
    ldh a, [hTemp2]
    ld [hli], a
    ldh a, [hTemp3]
    ld [hl], a
    xor a
    ld [rRAMG], a
    ldh a, [hTemp0]
    ld c, a
    ldh a, [hTemp2]
    sub c
    ld [wDigits], a
    ldh a, [hTemp1]
    ld c, a
    ldh a, [hTemp3]
    sbc c
    ld [wDigits + $1], a
    xor a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ld de, wTextNumber
    call WritePackedBCDNoLeadingZeros
    ret

; Six record field offsets of a monster, $5D, $61, $63, $65, $67 and $69 (MON_MAX_HP, MON_MAX_MP,
; MON_ATK, MON_DEF, MON_AGL, MON_INT), indexed by wScriptParam0 (0-5).
; TravelerEvents_MedicineMaster_BoostStat reads the 16-bit stat at that offset in the SRAM record of
; the chosen party member, adds 20 (at most 999) and writes it back, and shows the gain as a number
; in the message. (C1, E-0381)
TravelerEvents_MedicineMaster_BoostStat_Data::
    db $5d, $61, $63, $65, $67, $69

; Step runner of traveler event 7, the reward battle: wScriptStep picks the step. 0
; TravelerEvents_RewardBattle_ShowIfYouCanBeat, 2 TravelerEvents_RewardBattle_ShowAhTheSparkleIn, 4
; TravelerEvents_Thief_StartBattle, 5 TravelerEvents_RewardBattle_ShowVeryGoodHeresYour, 7
; TravelerEvents_RewardBattle_ShowHeroObtainedTheY, 9 ScriptStepBlinkSpritesThenEnd and 11
; TravelerEvents_RewardBattle_GiveMeat; steps 1, 3, 6, 8 and 10 wait for the message
; (TravelerEvents_Thief_WaitMessage). (C1, E-0384)
; event 7: 'If you can beat me, I'll give you something good.': a win fills the bag with random meat
; (E-0364; was TravelerEvents_RewardBattle, named from the wrong message table, E-0293)
TravelerEvents_RewardBattle::
    ld a, [wScriptStep]
    jumptable
    dw TravelerEvents_RewardBattle_ShowIfYouCanBeat
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_RewardBattle_ShowAhTheSparkleIn
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_Thief_StartBattle
    dw TravelerEvents_RewardBattle_ShowVeryGoodHeresYour
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_RewardBattle_ShowHeroObtainedTheY
    dw TravelerEvents_Thief_WaitMessage
    dw ScriptStepBlinkSpritesThenEnd
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_RewardBattle_GiveMeat

; Reward battle, step 0: 'If you can beat me, I'll give you something good. Want to battle?' ($1D,
; yes/no); next step. (C2, E-0357; probed E-0384)
TravelerEvents_RewardBattle_ShowIfYouCanBeat::
    ld hl, wScriptStep
    inc [hl]
    ld hl, MSG_KEEP_OPEN | $001d ; '*: If you can beat me,'
    call StartMessageHL_B73
    ret

; Reward battle, step 2: yes gives 'Ah, the sparkle in your eyes... I'd best not disappoint you!'
; ($4B) and the next step; no gives 'No? You're rather cowardly.' ($4A) and step 8. (C2, E-0357;
; probed E-0384)
TravelerEvents_RewardBattle_ShowAhTheSparkleIn::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b73
    ld hl, MSG_ALREADY_OPEN | $004b ; '*: Ah, the sparkle in your'
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b73:
    ld hl, MSG_ALREADY_OPEN | $004a ; '*: No? You're rather cowardly.'
    call StartMessageHL_B73
    ld a, $08
    ld [wScriptStep], a
    ret

; Reward battle, step 5: after the battle, a win gives 'Very good. Here's your reward.' ($1E); a
; loss gives 'Well, that was unseemly. You shouldn't shirk from training.' ($1F). (C2, E-0357;
; probed E-0384)
TravelerEvents_RewardBattle_ShowVeryGoodHeresYour::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wBattleScene]
    or a
    jr nz, .call_start_message_hl_b73
    ld hl, $001e ; '*: Very good. Here's your reward.'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, $001f ; '*: Well, that was unseemly. You'
    call StartMessageHL_B73
    ret

; Reward battle, step 7: on a win gives a random meat (ITEM_BEEFJERKY to ITEM_SIRLOIN) with
; '<player> obtained the <item>.' ($1B), and while the bag still has room keeps the window open for
; more (step $0A); on a loss '<player> lost <n>G.' ($0F) after the gold penalty. (C2, E-0357; probed
; E-0384)
TravelerEvents_RewardBattle_ShowHeroObtainedTheY::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wBattleScene]
    or a
    jr nz, .call_start_message_hl_b732
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and $03
    add $19
    ld [wStepPtrLo], a
    farcall AppendItemStepPtrLoToInventory
    ld a, [wStepPtrLo]
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld a, [wInventory + $17]
    or a
    jr z, .call_start_message_hl_b73
    cp $ff
    jr z, .call_start_message_hl_b73
    ld hl, $001b ; '0 obtained the Y.'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, MSG_KEEP_OPEN | $001b ; '0 obtained the Y.'
    call StartMessageHL_B73
    ld a, $0a
    ld [wScriptStep], a
    ret

.call_start_message_hl_b732:
    ld hl, $000f ; '0 lost G.'
    call StartMessageHL_B73
    call DeductGoldPenaltyAndFormatLoss
    ret

; Reward battle, step 11: another random meat ($19-$1C) with message $1B: back a step for more while
; the bag has room, otherwise the window closes (step 8); so the reward fills the bag with meat.
; (C2, E-0357; probed E-0384)
TravelerEvents_RewardBattle_GiveMeat::
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and $03
    add $19
    ld [wStepPtrLo], a
    farcall AppendItemStepPtrLoToInventory
    ld a, [wStepPtrLo]
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld a, [wInventory + $17]
    or a
    jr z, .call_start_message_hl_b73
    cp $ff
    jr z, .call_start_message_hl_b73
    ld hl, MSG_ALREADY_OPEN | $001b ; '0 obtained the Y.'
    call StartMessageHL_B73
    ld a, $08
    ld [wScriptStep], a
    ret

.call_start_message_hl_b73:
    ld hl, MSG_KEEP_OPEN | MSG_ALREADY_OPEN | $001b ; '0 obtained the Y.'
    call StartMessageHL_B73
    ld hl, wScriptStep
    dec [hl]
    ret

; Step runner of traveler event 5, the traveling master: wScriptStep picks the step. 0
; TravelerEvents_TravelingMaster_Greet, 2 TravelerEvents_TravelingMaster_ShowOhYoureReadyAre, 4
; TravelerEvents_Thief_StartBattle, 5 TravelerEvents_TravelingMaster_ShowUhohILostI, 7
; TravelerEvents_TravelingMaster_Reward and 9 ScriptStepBlinkSpritesThenEnd; steps 1, 3, 6 and 8
; wait for the message (TravelerEvents_Thief_WaitMessage). (C1, E-0384)
; event 5: 'I'm a traveling master...': a battle on yes; a win gives a Magic Key (16 in 256) or a
; WarpWing (E-0364; was TravelerEvents_TravelingMaster, named from the wrong message table, E-0293)
TravelerEvents_TravelingMaster::
    ld a, [wScriptStep]
    jumptable
    dw TravelerEvents_TravelingMaster_Greet
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_TravelingMaster_ShowOhYoureReadyAre
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_Thief_StartBattle
    dw TravelerEvents_TravelingMaster_ShowUhohILostI
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_TravelingMaster_Reward
    dw TravelerEvents_Thief_WaitMessage
    dw ScriptStepBlinkSpritesThenEnd

; Traveling master, step 0: 'I'm a traveling master. I'm training my monsters.' ($10); next step.
; (C2, E-0357; probed E-0384)
TravelerEvents_TravelingMaster_Greet::
    ld hl, wScriptStep
    inc [hl]
    ld hl, MSG_KEEP_OPEN | $0010 ; '*: I'm a traveling master. I'm'
    call StartMessageHL_B73
    ret

; Traveling master, step 2: no gives message $4E ('Oh, you poor monsters...') and step 8; yes gives
; message $4F ('Oh, you're ready, are you?...') and the next step. (C2, E-0357; probed E-0384)
TravelerEvents_TravelingMaster_ShowOhYoureReadyAre::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b73
    ld hl, MSG_ALREADY_OPEN | $004f ; '*: Oh, you're ready, are you?'
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b73:
    ld hl, MSG_ALREADY_OPEN | $004e ; '*: Oh, you poor monsters. You'
    call StartMessageHL_B73
    ld a, $08
    ld [wScriptStep], a
    ret

; Traveling master, step 5: after the battle, a win gives 'Uh-oh, I lost! I can do better!' ($11); a
; loss gives 'I'm sorry, but you didn't put up much resistance...' ($12) and the gold penalty. (C2,
; E-0357; probed E-0384)
TravelerEvents_TravelingMaster_ShowUhohILostI::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wBattleScene]
    or a
    jr nz, .call_start_message_hl_b73
    ld hl, $0011 ; '*: Uh-oh, I lost! I can'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, $0012 ; '*: I'm sorry, but you didn't'
    call StartMessageHL_B73
    call DeductGoldPenaltyAndFormatLoss
    ret

; Step runner of traveler event 4, the wandering master: wScriptStep picks the step. 0
; TravelerEvents_WanderingMaster_Greet, 2 TravelerEvents_WanderingMaster_Answer, 4
; TravelerEvents_Thief_StartBattle, 5 TravelerEvents_WanderingMaster_AfterBattle, 7
; TravelerEvents_TravelingMaster_Reward (shared with the traveling master) and 9
; ScriptStepBlinkSpritesThenEnd; steps 1, 3, 6 and 8 wait for the message
; (TravelerEvents_Thief_WaitMessage). (C1, E-0384)
; event 4: 'I'm a wandering master...': a battle on yes (E-0364; was TravelerEvents_WanderingMaster,
; named from the wrong message table, E-0293)
TravelerEvents_WanderingMaster::
    ld a, [wScriptStep]
    jumptable
    dw TravelerEvents_WanderingMaster_Greet
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_WanderingMaster_Answer
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_Thief_StartBattle
    dw TravelerEvents_WanderingMaster_AfterBattle
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_TravelingMaster_Reward
    dw TravelerEvents_Thief_WaitMessage
    dw ScriptStepBlinkSpritesThenEnd

; Wandering master, step 0: 'I'm a wandering master. I've been on the road for training.' ($0B);
; next step. (C2, E-0357; probed E-0384)
TravelerEvents_WanderingMaster_Greet::
    ld hl, wScriptStep
    inc [hl]
    ld hl, MSG_KEEP_OPEN | $000b ; '*: I'm a wandering master. I've'
    call StartMessageHL_B73
    ret

; Wandering master, step 2: no gives message $4C ('What? Little chicken!...') and step 8; yes gives
; message $4D ('Good answer! Let's battle!') and the next step. (C2, E-0357; probed E-0384)
TravelerEvents_WanderingMaster_Answer::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b73
    ld hl, MSG_ALREADY_OPEN | $004d ; '*: Good answer! Let's battle!'
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b73:
    ld hl, MSG_ALREADY_OPEN | $004c ; '*: What? Little chicken! Go home'
    call StartMessageHL_B73
    ld a, $08
    ld [wScriptStep], a
    ret

; Wandering master, step 5: after the battle, a win gives 'Urgh. Tougher than me...' ($0C); a loss
; gives 'Hahahah! I overestimated you!' ($0E). (C2, E-0357; probed E-0384)
TravelerEvents_WanderingMaster_AfterBattle::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wBattleScene]
    or a
    jr nz, .call_start_message_hl_b73
    ld hl, $000c ; '*: Urgh. Tougher than me… I'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, $000e ; '*: Hahahah! I overestimated you!'
    call StartMessageHL_B73
    ret

; Traveling master, step 7: on a win, with a chance of 16 in 256 a new Magic Key ('<player> received
; a Magic Key.', $43; GenerateNewKeyEntry), otherwise or with no free key slot a WarpWing ($0D, item
; $29); on a loss '<player> lost <n>G.' ($0F) after the gold penalty. (C2, E-0357; probed E-0384)
TravelerEvents_TravelingMaster_Reward::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wBattleScene]
    or a
    jr nz, .call_start_message_hl_b73
    call NextTableByte
    ld a, [wRandomLo]
    cp $10
    jr c, .call_generate_new_key_entry

.loop:
    ld hl, $000d ; '0 obtained a WarpWing.'
    call StartMessageHL_B73
    ld a, $29
    ld [wStepPtrLo], a
    farcall AppendItemStepPtrLoToInventory
    ret

.call_generate_new_key_entry:
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    or a
    jr z, .loop
    ld hl, $0043 ; '0 received a Magic Key.'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, $000f ; '0 lost G.'
    call StartMessageHL_B73
    call DeductGoldPenaltyAndFormatLoss
    ret

; Takes the gold penalty and formats the loss for a message: saves the gold in wDigits, far-calls
; DeductGoldPenalty (all the gold when it is under 150G, otherwise 150G while the gold is under
; 1500G, otherwise a tenth, rounded down), then wDigits = the gold lost (24 bits), which
; Number24ToPackedBCD and WritePackedBCDNoLeadingZeros write as digits followed by $F0 into
; wTextNumber. Used for the 'lost <n>G' message after a lost traveler battle. (C2, E-0384)
; saves the gold, far-calls DeductGoldPenalty, stores the amount lost in wDigits-wDigits + $2 and
; writes it as packed BCD to wTextNumber (WritePackedBCDNoLeadingZeros) (E-0121)
DeductGoldPenaltyAndFormatLoss::
    ld a, [wGoldLo]
    ld [wDigits], a
    ld a, [wGoldMid]
    ld [wDigits + $1], a
    ld a, [wGoldHi]
    ld [wDigits + $2], a
    farcall DeductGoldPenalty
    ld a, [wGoldLo]
    ld c, a
    ld a, [wDigits]
    sub c
    ld [wDigits], a
    ld a, [wGoldMid]
    ld c, a
    ld a, [wDigits + $1]
    sbc c
    ld [wDigits + $1], a
    ld a, [wGoldHi]
    ld c, a
    ld a, [wDigits + $2]
    sbc c
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ld de, wTextNumber
    call WritePackedBCDNoLeadingZeros
    ret

; Step runner of traveler event 3, the pricey merchant: wScriptStep picks the step. 0
; TravelerEvents_PriceyMerchant_ShowYJustGWell, 2 TravelerEvents_PriceyMerchant_Sell and 4
; ScriptStepBlinkSpritesThenEnd; steps 1 and 3 wait for the message
; (TravelerEvents_Thief_WaitMessage). (C1, E-0384)
; event 3: offers an item the party needs at five times its price ('<item>! Just <n>G! Well?')
; (E-0364; was TravelerEvents_PriceyMerchant, named from the wrong message table, E-0293)
TravelerEvents_PriceyMerchant::
    ld a, [wScriptStep]
    jumptable
    dw TravelerEvents_PriceyMerchant_ShowYJustGWell
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_PriceyMerchant_Sell
    dw TravelerEvents_Thief_WaitMessage
    dw ScriptStepBlinkSpritesThenEnd

; Pricey merchant, step 0: offers the item chosen for the party (TravelerEvents_ChooseMerchantItem)
; at five times its price ('<item>! Just <n>G! Well?', $08); next step. (C2, E-0357; probed E-0384)
TravelerEvents_PriceyMerchant_ShowYJustGWell::
    ld hl, wScriptStep
    inc [hl]
    ld hl, MSG_KEEP_OPEN | $0008 ; '*: Y! Just G! Well?'
    call StartMessageHL_B73
    call TravelerEvents_ChooseMerchantItem
    ld a, [wScriptParam0]
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld a, [wScriptParam0]
    call ReadBank16TableWord
    ld e, l
    ld d, h
    add hl, hl
    add hl, hl
    add hl, de
    ld a, l
    ld [wDigits], a
    ld a, h
    ld [wDigits + $1], a
    xor a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ld de, wTextNumber
    call WritePackedBCDNoLeadingZeros
    ret

; Pricey merchant, step 2: on yes (wTextYesNoResult 0) adds item wScriptParam0 to the bag
; (AppendItemStepPtrLoToInventory), takes five times its price (ReadBank16TableWord times 5, through
; SubtractGoldFloorZero) and starts message $09 ('Heheheh, thanks!...'); on no starts message $0A
; ('Tch, tightwad...'). Next step either way. The price is taken without checking that the player
; can pay: with wGoldHi 0 a price above the gold wraps the gold to $FFxxxx instead of stopping at 0,
; which can only happen for the Herb that TravelerEvents_ChooseMerchantItem offers without a price
; check. (C2, E-0384)
TravelerEvents_PriceyMerchant_Sell::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b73
    ld a, [wScriptParam0]
    ld [wStepPtrLo], a
    farcall AppendItemStepPtrLoToInventory
    ld a, [wScriptParam0]
    call ReadBank16TableWord
    ld e, l
    ld d, h
    add hl, hl
    add hl, hl
    add hl, de
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall SubtractGoldFloorZero
    ld hl, MSG_ALREADY_OPEN | $0009 ; '*: Heheheh, thanks! See you again!'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, MSG_ALREADY_OPEN | $000a ; '*: Tch, tightwad… You'll regret this.'
    call StartMessageHL_B73
    ret

; Step runner of traveler event 2, the paid healer: wScriptStep picks the step. 0
; TravelerEvents_PaidHealer_ShowIllHealYouFor, 2 TravelerEvents_PaidHealer_ShowAnEmptyString, 3
; TravelerEvents_MapSeller_SavePalettes, 4 TravelerEvents_HealerBattle_FlashScreen, 5
; TravelerEvents_PaidHealer_ShowHeheheMoneyIsMy, 6 TravelerEvents_AfterHealing and 8
; ScriptStepBlinkSpritesThenEnd; steps 1 and 7 wait for the message
; (TravelerEvents_Thief_WaitMessage). (C1, E-0384)
; event 2: 'I'll heal you for 1000G. Well?': on yes takes 1000G and heals the party (E-0364; was
; TravelerEvents_PaidHealer, named from the wrong message table, E-0293)
TravelerEvents_PaidHealer::
    ld a, [wScriptStep]
    jumptable
    dw TravelerEvents_PaidHealer_ShowIllHealYouFor
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_PaidHealer_ShowAnEmptyString
    dw TravelerEvents_MapSeller_SavePalettes
    dw TravelerEvents_HealerBattle_FlashScreen
    dw TravelerEvents_PaidHealer_ShowHeheheMoneyIsMy
    dw TravelerEvents_AfterHealing
    dw TravelerEvents_Thief_WaitMessage
    dw ScriptStepBlinkSpritesThenEnd

; Paid healer, step 0: 'I'll heal you for 1000G. Well?' ($05, yes/no); next step. (C2, E-0357;
; probed E-0384)
TravelerEvents_PaidHealer_ShowIllHealYouFor::
    ld hl, wScriptStep
    inc [hl]
    ld hl, MSG_KEEP_OPEN | $0005 ; '*: I'll heal you for 1000G.'
    call StartMessageHL_B73
    ret

; Paid healer, step 2: yes shows message $27 (an empty string, used as the yes mark) and goes on; no
; skips two steps. (C2, E-0357; probed E-0384)
TravelerEvents_PaidHealer_ShowAnEmptyString::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wTextYesNoResult]
    or a
    jr nz, .skip
    ld hl, MSG_ALREADY_OPEN | $0027 ; '(an empty string)'
    call StartMessageHL_B73
    ret

.skip:
    ld hl, wScriptStep
    inc [hl]
    ld hl, wScriptStep
    inc [hl]
    ret

; Paid healer, step 5: after a yes (wMessageIndex = $27) takes 1000G, fully heals the party and says
; 'Hehehe, money is my motivation...' ($06); otherwise 'Heh, I hope your luck holds, kid!...' ($07).
; (C2, E-0357; probed E-0384)
TravelerEvents_PaidHealer_ShowHeheheMoneyIsMy::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wMessageIndex]
    cp $27
    jr nz, .call_start_message_hl_b73
    ld hl, $03e8
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall SubtractGoldFloorZero
    farcall FullyHealParty
    ld hl, $0006 ; '*: Hehehe, money is my motivation.'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, MSG_ALREADY_OPEN | $0007 ; '*: Heh, I hope your luck'
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; Step runner of traveler event 1, the merchant: wScriptStep picks the step. 0
; TravelerEvents_Merchant_ShowYOnlyGWell, 2 TravelerEvents_Merchant_ShowThanksHopeISee and 4
; ScriptStepBlinkSpritesThenEnd; steps 1 and 3 wait for the message
; (TravelerEvents_Thief_WaitMessage). (C1, E-0384)
; event 1: offers an item the party needs at its price ('<item>! Only <n>G! Well?'), sold on yes
; (E-0364; was TravelerEvents_Merchant, named from the wrong message table, E-0293)
TravelerEvents_Merchant::
    ld a, [wScriptStep]
    jumptable
    dw TravelerEvents_Merchant_ShowYOnlyGWell
    dw TravelerEvents_Thief_WaitMessage
    dw TravelerEvents_Merchant_ShowThanksHopeISee
    dw TravelerEvents_Thief_WaitMessage
    dw ScriptStepBlinkSpritesThenEnd

; Merchant, step 0: offers the item chosen for the party (TravelerEvents_ChooseMerchantItem) at its
; price ('<item>! Only <n>G! Well?', $02); next step. (C2, E-0357; probed E-0384)
TravelerEvents_Merchant_ShowYOnlyGWell::
    ld hl, wScriptStep
    inc [hl]
    ld hl, MSG_KEEP_OPEN | $0002 ; '*: Y! Only G! Well?'
    call StartMessageHL_B73
    call TravelerEvents_ChooseMerchantItem
    ld a, [wScriptParam0]
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld a, [wScriptParam0]
    call ReadBank16TableWord
    ld a, l
    ld [wDigits], a
    ld a, h
    ld [wDigits + $1], a
    xor a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ld de, wTextNumber
    call WritePackedBCDNoLeadingZeros
    ret

; Merchant, step 2: yes gives the item and takes the price ('Thanks! Hope I see you again!', $03);
; no gives 'Hah? Not buying? Bah, another time.' ($04). (C2, E-0357; probed E-0384)
TravelerEvents_Merchant_ShowThanksHopeISee::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b73
    ld a, [wScriptParam0]
    ld [wStepPtrLo], a
    farcall AppendItemStepPtrLoToInventory
    ld a, [wScriptParam0]
    call ReadBank16TableWord
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall SubtractGoldFloorZero
    ld hl, MSG_ALREADY_OPEN | $0003 ; '*: Thanks! Hope I see you'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, MSG_ALREADY_OPEN | $0004 ; '*: Hah? Not buying? Bah, another'
    call StartMessageHL_B73
    ret

; Step runner of traveler event 0, the healer: wScriptStep picks the step. 0
; TravelerEvents_Healer_Msg0000_AllowMeToHeal, 1 TravelerEvents_MapSeller_SavePalettes, 2
; TravelerEvents_HealerBattle_FlashScreen, 3 TravelerEvents_HealerBattle_ShowIWillPrayFor, 4
; TravelerEvents_AfterHealing and 6 ScriptStepBlinkSpritesThenEnd; step 5 waits for the message
; (TravelerEvents_Thief_WaitMessage). (C1, E-0384)
; event 0: 'Allow me to heal your injuries.', a flash, the party healed, 'I will pray for you.
; Farewell.' (E-0364; was TravelerEvents_Healer, named from the wrong message table, E-0293)
TravelerEvents_Healer::
    ld a, [wScriptStep]
    jumptable
    dw TravelerEvents_Healer_Msg0000_AllowMeToHeal
    dw TravelerEvents_MapSeller_SavePalettes
    dw TravelerEvents_HealerBattle_FlashScreen
    dw TravelerEvents_HealerBattle_ShowIWillPrayFor
    dw TravelerEvents_AfterHealing
    dw TravelerEvents_Thief_WaitMessage
    dw ScriptStepBlinkSpritesThenEnd

; Healer, step 0: 'Allow me to heal your injuries.' ($00); next step. (C2, E-0357; probed E-0384)
TravelerEvents_Healer_Msg0000_AllowMeToHeal::
    ld hl, $0000 ; '*: Allow me to heal your'
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; After the message, saves the palettes for the flash (CGB) and plays sound $7A; next step. (C1,
; E-0357)
TravelerEvents_MapSeller_SavePalettes::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank73
    ret nc
    ld a, [wIsCGB]
    or a
    jr z, .call_queue_sound_effect
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes

.call_queue_sound_effect:
    ld a, $7a
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; The screen-flash step (far-calls ScriptStepFlashScreenNegative): step 7 of
; TravelerEvents_HealerBattle, step 4 of TravelerEvents_PaidHealer, step 2 of TravelerEvents_Healer
; and step 1 of SceneMonstersInTow. (C2, E-0371; probed E-0384)
TravelerEvents_HealerBattle_FlashScreen::
    farcall ScriptStepFlashScreenNegative
    ret

; Healer battle, step 8: fully heals the party and says 'I will pray for you. Farewell.' ($01); next
; step. (C2, E-0357; probed E-0384)
TravelerEvents_HealerBattle_ShowIWillPrayFor::
    farcall FullyHealParty
    ld hl, $0001 ; '*: I will pray for you.'
    call StartMessageHL_B73
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Waits for the event's message (RunMessageBoxCarryWhenIdle_Bank73); next step. (C1, E-0357)
TravelerEvents_Thief_WaitMessage::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; After healing: first frame redraws the field; second puts fallen monsters behind the others
; (twice), reloads the name tiles, the player and follower sprites and the object palettes; next
; step. (C1, E-0357)
TravelerEvents_AfterHealing::
    ld a, [wScriptParam0]
    or a
    jr nz, .call_move_incapacitated_party_members_back
    inc a
    ld [wScriptParam0], a
    ld a, $0e
    ldh [hFieldDrawFlags], a
    ret

.call_move_incapacitated_party_members_back:
    farcall MoveIncapacitatedPartyMembersBack
    farcall MoveIncapacitatedPartyMembersBack
    call LoadRecordListNameTiles
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    xor a
    ldh [hFieldDrawFlags], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Closing step of the traveler events: for 120 frames (wScriptParam0 from 0 to $77) it sets
; wSpriteSlotCount to 1 or 0 from one bit of wScriptParam0, so the sprites blink: bit 3 below $1E,
; bit 2 below $3C and bit 1 from there on, which makes the blinking faster. When wScriptParam0
; reaches $78 it requests the next script command ($80 in wScriptStartRequest) and clears
; wPendingFieldEvent. (C2, E-0384)
; toggles wSpriteSlotCount between 0 and 1 at a slowing rate for $78 frames, then requests script
; $80 and clears wPendingFieldEvent (E-0125)
ScriptStepBlinkSpritesThenEnd::
    ld a, [wScriptParam0]
    cp $1e
    jr nc, .cp_3C
    bit 3, a
    jr z, .set_sprite_slot_count_to_01
    jr .clear_sprite_slot_count

.cp_3C:
    cp $3c
    jr nc, .check_bit1
    bit 2, a
    jr z, .set_sprite_slot_count_to_01
    jr .clear_sprite_slot_count

.check_bit1:
    bit 1, a
    jr z, .set_sprite_slot_count_to_01
    jr .clear_sprite_slot_count

.set_sprite_slot_count_to_01:
    ld a, $01
    ld [wSpriteSlotCount], a
    jr .check_script_param0

.clear_sprite_slot_count:
    xor a
    ld [wSpriteSlotCount], a

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $78
    ret nz
    ld a, $80
    ld [wScriptStartRequest], a
    xor a
    ld [wPendingFieldEvent], a
    ret

; HL = a message word: stores L in wMessageIndex and H in wMessageGroup (H bits 6 and 7 are
; MSG_KEEP_OPEN and MSG_ALREADY_OPEN) and sets wMessageState to 0, so that RunMessageBox_Bank73
; starts the message from its first step. Clobbers A. (C2, E-0384)
; HL is stored in wMessageIndex (low) and wMessageGroup (high); then wMessageState = 0
StartMessageHL_B73::
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a
    ld [wMessageState], a
    ret

; Runner of the event message box. A is passed by the caller (TravelerEvents_Thief_WaitMessage
; passes 0). It saves AF and returns at once with A kept when wMessageState is $FF (idle); otherwise
; it jumps by wMessageState to RunMessageBox_Bank73_Open (0), RunMessageBox_Bank73_ShowText (1),
; RunMessageBox_Bank73_Close (2) or RunMessageBox_Bank73_Finish (3). Every step pops the saved AF;
; Open freezes the field animation only when the saved A is 0, and Finish resumes it only then. (C1,
; E-0384)
; the bank-$73 message runner: returns at once when wMessageState is $FF (idle), otherwise steps the
; message (the same opening as RunMessageBox_Bank12) (E-0116)
RunMessageBox_Bank73::
    push af
    ld a, [wMessageState]
    cp $ff
    jr nz, .skip
    pop af
    ret

.skip:
    jumptable
    dw RunMessageBox_Bank73_Open
    dw RunMessageBox_Bank73_ShowText
    dw RunMessageBox_Bank73_Close
    dw RunMessageBox_Bank73_Finish

; Event message, step 0: unless a step pointer is set, freezes the player and objects; unless
; wMessageGroup bit 7, clears the window tiles, plays sound $69 and opens the text window (at the
; top when the player is low); next step. (C1, E-0357)
RunMessageBox_Bank73_Open::
    pop af
    or a
    jr nz, .check_message_group
    farcall FreezeFieldAnimation

.check_message_group:
    ld a, [wMessageGroup]
    bit 7, a
    jr nz, .done
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    call FillTilesFromRequest
    ld a, $69
    call QueueSoundEffect
    ld a, $01
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a
    ldh a, [hPlayerY]
    cp $48
    jr c, .done
    ld a, $81
    ld [wTextWindowState], a
    ld a, $01
    ldh [hSpriteWindowClipMode], a

.done:
    ld hl, wMessageState
    inc [hl]
    ret

; Event message, step 1: once the window is open, starts string wMessageIndex of bank $09's category
; 5 (the event lines); next step. (C1, E-0357)
RunMessageBox_Bank73_ShowText::
    pop af
    ld a, [wTextWindowState]
    and $03
    ret nz
    ld a, [wMessageIndex]
    ld [wStringIndex], a
    ld a, $05
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank09
    ld hl, wMessageState
    inc [hl]
    ret

; Event message, step 2: after the text, with wMessageGroup bit 6 (keep open) ends at once ($FF);
; otherwise plays sound $69 and starts closing the window; next step. (C2, E-0357; probed E-0384)
RunMessageBox_Bank73_Close::
    pop af
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld a, [wMessageGroup]
    bit 6, a
    jr z, .call_queue_sound_effect
    ld a, $ff
    ld [wMessageState], a
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    ld a, $02
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $00
    ldh [hSpriteWindowClipMode], a
    ldh a, [hPlayerY]
    cp $48
    jr c, .done
    ld a, $82
    ld [wTextWindowState], a

.done:
    ld hl, wMessageState
    inc [hl]
    ret

; Event message, step 3: once wTextWindowState shows the window closed, pops the A that
; RunMessageBox_Bank73 saved on entry; when it is 0 calls ResumeFieldAnimation (unfreezing the
; player and objects), then marks the message idle (wMessageState = $FF). (C2, E-0371; probed
; E-0384)
RunMessageBox_Bank73_Finish::
    ld a, [wTextWindowState]
    and $03
    jr z, .restore
    pop af
    ret

.restore:
    pop af
    or a
    jr nz, .set_message_state_to_FF
    farcall ResumeFieldAnimation

.set_message_state_to_FF:
    ld a, $ff
    ld [wMessageState], a
    ret

; Runs RunMessageBox_Bank73 with the A given, then returns carry set (A = $FF) when wMessageState is
; $FF (the message is finished) and carry clear with A = 0 while it is still running. (C1, E-0384)
; RunMessageBox_Bank73, then carry set when wMessageState = $FF (idle), else A = 0 and carry clear
; (E-0116)
RunMessageBoxCarryWhenIdle_Bank73::
    call RunMessageBox_Bank73
    ld a, [wMessageState]
    cp $ff
    jr z, .return_carry
    sub a
    ret

.return_carry:
    scf
    ret

; A = item id: HL = the 16-bit word at $4CC3 + 13 * A in ROM bank $16, read a byte at a time with
; ReadByteInBank (13-byte records, only the first word is read). Every caller treats it as the price
; of item A in gold (for example 10 for ITEM_HERB and 500 for ITEM_WORLDDEW). Clobbers A, BC and DE.
; (C2, E-0384)
; HL = the word at $4CC3 + 13 * A in bank $16 (ReadByteInBank twice) (E-0121) (E-0344: the address
; in its name dropped or read as the label there; was ReadBank16TableWord)
ReadBank16TableWord::
    ld c, $0d
    call Multiply8
    ld a, l
    add $c3
    ld l, a
    ld a, h
    adc $4c
    ld h, a
    ld e, l
    ld d, h
    ld b, $16
    call ReadByteInBank
    ld l, c
    inc de
    call ReadByteInBank
    ld h, c
    ret

; Chooses the merchants' item in wScriptParam0, taking the first that TravelerEvents_CanAffordItem
; accepts: ITEM_WORLDLEAF for a fallen monster (SetWStepArrivedIfPartyHasField55Bit7), ITEM_LAUREL
; for MON_STATUS bit 0, ITEM_ANTIDOTE for poison, a meat when wPartyCount is not 3 (ITEM_BEEFJERKY,
; ITEM_PORKCHOP or ITEM_RIB for wRecordsInUse under 3, 3-5 or 6-10), ITEM_ELFWATER when 101 or more
; MP is missing, ITEM_POTION for 1-100 missing MP, ITEM_WORLDDEW for 101 or more missing HP and
; ITEM_LOVEWATER for 51-99. Otherwise wScriptParam0 = ITEM_HERB without a price check. Called by
; TravelerEvents_Merchant_ShowYOnlyGWell and TravelerEvents_PriceyMerchant_ShowYJustGWell. (C2,
; E-0371; probed E-0384)
TravelerEvents_ChooseMerchantItem::
    farcall SetWStepArrivedIfPartyHasField55Bit7
    ld a, [wStepArrived]
    or a
    jr z, .call_traveler_events_party_has_status_bit0
    ld a, $0c
    ld [wScriptParam0], a
    call TravelerEvents_CanAffordItem
    or a
    ret nz

.call_traveler_events_party_has_status_bit0:
    farcall TravelerEvents_PartyHasStatusBit0
    ld a, [wStepArrived]
    or a
    jr z, .call_traveler_events_party_has_poison
    ld a, $08
    ld [wScriptParam0], a
    call TravelerEvents_CanAffordItem
    or a
    ret nz

.call_traveler_events_party_has_poison:
    farcall TravelerEvents_PartyHasPoison
    ld a, [wStepArrived]
    or a
    jr z, .check_party_count
    ld a, $06
    ld [wScriptParam0], a
    call TravelerEvents_CanAffordItem
    or a
    ret nz

.check_party_count:
    ld a, [wPartyCount]
    cp $03
    jr z, .call_traveler_events_sum_missing_mp
    farcall CountRecordsInUse
    ld a, [wRecordsInUse]
    cp $03
    jr nc, .check_records_in_use
    ld a, $19
    ld [wScriptParam0], a
    call TravelerEvents_CanAffordItem
    or a
    ret nz

.check_records_in_use:
    ld a, [wRecordsInUse]
    cp $03
    jr c, .check_records_in_use2
    cp $06
    jr nc, .check_records_in_use2
    ld a, $1a
    ld [wScriptParam0], a
    call TravelerEvents_CanAffordItem
    or a
    ret nz

.check_records_in_use2:
    ld a, [wRecordsInUse]
    cp $06
    jr c, .call_traveler_events_sum_missing_mp
    cp $0b
    jr nc, .call_traveler_events_sum_missing_mp
    ld a, $1b
    ld [wScriptParam0], a
    call TravelerEvents_CanAffordItem
    or a
    ret nz

.call_traveler_events_sum_missing_mp:
    call TravelerEvents_SumMissingMP
    ldh a, [hTemp3]
    or a
    jr nz, .set_script_param0_to_05
    ldh a, [hTemp2]
    cp $65
    jr c, .check_temp3

.set_script_param0_to_05:
    ld a, $05
    ld [wScriptParam0], a
    call TravelerEvents_CanAffordItem
    or a
    ret nz

.check_temp3:
    ldh a, [hTemp3]
    or a
    jr nz, .call_traveler_events_sum_missing_hp
    ldh a, [hTemp2]
    cp $65
    jr nc, .call_traveler_events_sum_missing_hp
    or a
    jr z, .call_traveler_events_sum_missing_hp
    ld a, $04
    ld [wScriptParam0], a
    call TravelerEvents_CanAffordItem
    or a
    ret nz

.call_traveler_events_sum_missing_hp:
    call TravelerEvents_SumMissingHP
    ldh a, [hTemp3]
    or a
    jr nz, .set_script_param0_to_03
    ldh a, [hTemp2]
    cp $65
    jr c, .check_temp32

.set_script_param0_to_03:
    ld a, $03
    ld [wScriptParam0], a
    call TravelerEvents_CanAffordItem
    or a
    ret nz

.check_temp32:
    ldh a, [hTemp3]
    or a
    jr nz, .set_script_param0_to_01
    ldh a, [hTemp2]
    cp $33
    jr c, .set_script_param0_to_01
    cp $64
    jr nc, .set_script_param0_to_01
    ld a, $02
    ld [wScriptParam0], a
    call TravelerEvents_CanAffordItem
    or a
    ret nz

.set_script_param0_to_01:
    ld a, $01
    ld [wScriptParam0], a
    ret

; hTemp2/hTemp3 = the HP the party is missing (max HP minus HP, summed). (C2, E-0357; probed E-0384)
TravelerEvents_SumMissingHP::
    ld hl, $0000
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    ld a, $0a
    ld [rRAMG], a
    ld a, [wPartyCount]
    or a
    jr z, .done
    ld b, a
    ld hl, wPartyList

.loop:
    ld a, [hl]
    ld c, MON_MAX_HP
    call LoadSRAMRecordWord
    push hl
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ldh a, [hTemp2]
    ld e, a
    ldh a, [hTemp3]
    ld d, a
    add hl, de
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    pop hl
    ld a, [hl]
    ld c, MON_HP
    call LoadSRAMRecordWord
    push hl
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ldh a, [hTemp2]
    sub l
    ldh [hTemp2], a
    ldh a, [hTemp3]
    sbc h
    ldh [hTemp3], a
    pop hl
    inc hl
    dec b
    jr nz, .loop

.done:
    xor a
    ld [rRAMG], a
    ret

; hTemp2/hTemp3 = the MP the party is missing (max MP minus MP, summed). (C2, E-0357; probed E-0384)
TravelerEvents_SumMissingMP::
    ld hl, $0000
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    ld a, $0a
    ld [rRAMG], a
    ld a, [wPartyCount]
    or a
    jr z, .done
    ld b, a
    ld hl, wPartyList

.loop:
    ld a, [hl]
    ld c, MON_MAX_MP
    call LoadSRAMRecordWord
    push hl
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ldh a, [hTemp2]
    ld e, a
    ldh a, [hTemp3]
    ld d, a
    add hl, de
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    pop hl
    ld a, [hl]
    ld c, MON_MP
    call LoadSRAMRecordWord
    push hl
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    ldh a, [hTemp2]
    sub l
    ldh [hTemp2], a
    ldh a, [hTemp3]
    sbc h
    ldh [hTemp3], a
    pop hl
    inc hl
    dec b
    jr nz, .loop

.done:
    xor a
    ld [rRAMG], a
    ret

; A = item id (the caller has just stored it in wScriptParam0): HL = its price
; (ReadBank16TableWord), times five unless wPendingFieldEvent & $0F is 1 (TravelerEvents_Merchant);
; returns A = 1 when the gold covers it (any wGoldHi, or wGoldMid/wGoldLo at least the price),
; otherwise A = 0. (C2, E-0371; probed E-0384)
TravelerEvents_CanAffordItem::
    call ReadBank16TableWord
    ld a, [wPendingFieldEvent]
    and $0f
    dec a
    jr z, .check_gold_hi
    ld e, l
    ld d, h
    add hl, hl
    add hl, hl
    add hl, de

.check_gold_hi:
    ld a, [wGoldHi]
    or a
    jr z, .check_gold_mid

.loop:
    ld a, $01
    ret

.check_gold_mid:
    ld a, [wGoldMid]
    cp h
    jr c, .return_0
    jr nz, .loop
    ld a, [wGoldLo]
    cp l
    jr nc, .loop

.return_0:
    xor a
    ret

; Thief, step 2: starts the battle (battle intro 6) after saving the screen and setting the
; encounter countdown; next step. (C1, E-0357)
TravelerEvents_Thief_StartBattle::
    ld hl, wScriptStep
    inc [hl]
    ld a, $06
    ld [wBattleIntroKind], a
    ld a, $01
    ld [wBattleTransitionSubStep], a
    ld a, $03
    ld [wModeState], a
    xor a
    ld [wBattleTransitionStep], a
    ld a, $02
    ld [wFieldReturnPhase], a
    farcall SaveScreenBufferToBGMap1
    farcall PickRandomEncounterCountdownFromTable
    ret

; Step runner of script command $CB, the treasure chest battle scenes: wScriptStep picks the step. 0
; SceneChestBattle_ShowPreBattleMessage, 2 SceneChestBattle_StartBattle, 3
; SceneChestBattle_ShowPostBattleMessage, 5 SceneChestBattle_MarkKeyUsed, 6
; SceneChestBattle_BlinkOut, 7 and 10 SceneChestBattle_SetChestFlag, 8 SceneChestBattle_StartSprite,
; 9 SceneChestBattle_MoveSprite; steps 1 and 4 wait for the message (SceneChestBattle_WaitMessage).
; Plain chests run 0 to 7; on maps $CE, $D7 and $E0 step 5 jumps to step 8 and the scene ends at
; step 10. (C1, E-0384)
; implements script command type CB (SCRIPT_SCENE_CHEST_BATTLE): a cutscene step named after the
; scene its only script shows: '0 checked the treasure chest.' (key entry mark and encounter);
; reached through ScriptCommandCB in bank $10 (E-0038, E-0245)
SceneChestBattle::
    ld a, [wScriptStep]
    jumptable
    dw SceneChestBattle_ShowPreBattleMessage
    dw SceneChestBattle_WaitMessage
    dw SceneChestBattle_StartBattle
    dw SceneChestBattle_ShowPostBattleMessage
    dw SceneChestBattle_WaitMessage
    dw SceneChestBattle_MarkKeyUsed
    dw SceneChestBattle_BlinkOut
    dw SceneChestBattle_SetChestFlag
    dw SceneChestBattle_StartSprite
    dw SceneChestBattle_MoveSprite
    dw SceneChestBattle_SetChestFlag

; Chest battle, step 9: moves sprite 0 by wScriptParam1 a frame for 16 frames, then stops it (bit 2
; clear); next step. (C2, E-0357; probed E-0384)
SceneChestBattle_MoveSprite::
    ld a, [wScriptParam1]
    ld c, a
    ld a, [wSpriteSlots + $b]
    add c
    ld [wSpriteSlots + $b], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $10
    ret nz
    xor a
    ld [wSpriteSlots + $7], a
    ld hl, wSpriteSlots + $d
    call ClearBit2AtHL_Bank73
    ld hl, wScriptStep
    inc [hl]
    ret

; Chest battle, step 7: sets the map's chest flag (the table by hMapId - $C8) and asks for the next
; script command. (C2, E-0357; probed E-0384)
SceneChestBattle_SetChestFlag::
    ldh a, [hMapId]
    sub $c8
    add a
    ld hl, SceneChestBattle_SetChestFlag_Data
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Twenty-seven little-endian story flag numbers (54 bytes), one per map id $C8-$E2 (index hMapId -
; $C8). Fifteen are the object-removed story flag of the same map, such as
; EVENT_MAP_CA_OBJECT_REMOVED for map $CA (maps $CA-$CE, $D3-$D7 and $DC-$E0); the rest are $0000
; (EVENT_NEVER_SET). SceneChestBattle_SetChestFlag loads the word into DE and calls SetFlagBit after
; a chest battle. (C1, E-0381)
SceneChestBattle_SetChestFlag_Data::
    db $00, $00, $00, $00, $d4, $01, $d9, $01, $dd, $01, $6a, $01, $6e, $01, $00, $00
    db $00, $00, $00, $00, $00, $00, $74, $01, $78, $01, $7c, $01, $d5, $00, $d9, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $df, $00, $f8, $00, $fc, $00, $f2, $01
    db $f6, $01, $00, $00, $00, $00

; Chest battle, step 6: blinks object 0 at Y $30 until done, then hides the sprites; next step. (C2,
; E-0357; probed E-0384)
SceneChestBattle_BlinkOut::
    xor a
    ldh [hTemp0], a
    ld a, $30
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a
    ret z
    xor a
    ld [wSpriteSlotCount], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Chest battle, step 5: on maps $CE, $D7 and $E0 marks the key of kind $0A, $0B or $0C as used (bit
; 6) and sets EVENT_SCENE_CHEST_BATTLE, _207 or _208, then step 8; other maps go on. (C2, E-0357;
; probed E-0384)
SceneChestBattle_MarkKeyUsed::
    ldh a, [hMapId]
    cp $ce
    jr z, .set_temp0_to_0A
    cp $d7
    jr z, .set_temp0_to_0B
    cp $e0
    jr z, .set_temp0_to_0C
    ld hl, wScriptStep
    inc [hl]
    ret

.set_temp0_to_0A:
    ld a, $0a
    ldh [hTemp0], a
    farcall MarkKeyEntryKindTemp0Bit6
    ld de, EVENT_SCENE_CHEST_BATTLE
    call SetFlagBit
    jr .set_script_step_to_08

.set_temp0_to_0B:
    ld a, $0b
    ldh [hTemp0], a
    farcall MarkKeyEntryKindTemp0Bit6
    ld de, EVENT_SCENE_CHEST_BATTLE_207
    call SetFlagBit
    jr .set_script_step_to_08

.set_temp0_to_0C:
    ld a, $0c
    ldh [hTemp0], a
    farcall MarkKeyEntryKindTemp0Bit6
    ld de, EVENT_SCENE_CHEST_BATTLE_208
    call SetFlagBit

.set_script_step_to_08:
    ld a, $08
    ld [wScriptStep], a
    ret

; Chest battle, step 3 (after the scripted encounter of step 2): starts this map's message from
; SceneChestBattle_ToSceneChestBattle_StartMessageHL_B73b_Data by hMapId
; (SceneChestBattle_StartMapMessage); next step. (C2, E-0371; probed E-0384)
SceneChestBattle_ShowPostBattleMessage::
    ld de, SceneChestBattle_ShowPostBattleMessage_Data
    call SceneChestBattle_StartMapMessage
    ret

; Chest battle, step 2: starts the map's scripted encounter (the table by hMapId - $C8); next step.
; (C1, E-0357)
SceneChestBattle_StartBattle::
    ldh a, [hMapId]
    sub $c8
    ld de, SceneChestBattle_StartBattle_Data
    add e
    ld e, a
    jr nc, .set_temp0
    inc d

.set_temp0:
    ld a, [de]
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; Twenty-seven record numbers of ScriptedEncounterTable, one per map id $C8-$E2 (index hMapId -
; $C8): $20-$24 for maps $CA-$CE, $25-$29 for maps $D3-$D7 and $2A-$2E for maps $DC-$E0, and $00 for
; the other maps. SceneChestBattle_StartBattle puts the byte in hTemp0 and calls
; StartScriptedEncounterTemp0 to start the chest monster battle. (C1, E-0381)
SceneChestBattle_StartBattle_Data::
    db $00, $00, $20, $21, $22, $23, $24, $00, $00, $00, $00, $25, $26, $27, $28, $29
    db $00, $00, $00, $00, $2a, $2b, $2c, $2d, $2e, $00, $00

; Chest battle, step 0: starts this map's message from
; SceneChestBattle_ToSceneChestBattle_StartMessageHL_B73b_MapMessageTable by hMapId
; (SceneChestBattle_StartMapMessage); next step. (C2, E-0371; probed E-0384)
SceneChestBattle_ShowPreBattleMessage::
    ld de, ChestBattlePreBattleMessages
    call SceneChestBattle_StartMapMessage
    ret

; Starts the message word at DE + 2 x (hMapId - $C8) (StartMessageHL_B73b); next step. (C2, E-0357;
; probed E-0384)
SceneChestBattle_StartMapMessage::
    ldh a, [hMapId]
    sub $c8
    add a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; 27 message words, one per map $C8-$E2 (index hMapId - $C8; $0000 = none), that
; SceneChestBattle_ShowPreBattleMessage starts through SceneChestBattle_StartMapMessage
; (StartMessageHL_B73b) before the chest battle: 'This is the second floor-' to the fifth, and a
; closing line, for each of three five-map groups. SceneChestBattle_ShowPostBattleMessage_Data, the
; after-battle words for the same maps, follows directly. (C1, E-0372); E-0214 (C1:
; SceneChestBattle_ShowPreBattleMessage passes $530C to SceneChestBattle_StartMapMessage, which
; reads the word at DE + 2 * (hMapId - $C8) and starts that message (StartMessageHL_B73b); 54 words,
; one per map from $C8 (id = map number); the table ends at KeyBossBeaten2). (named from its
; reading, E-0372; was SceneChestBattle_ToSceneChestBattle_StartMessageHL_B73b_MapMessageTable)
; record: message word ($0000 = none)
ChestBattlePreBattleMessages::
    dw $0000 ; id 200 none
    dw $0000 ; id 201 none
    dw $0c04 ; id 202 '*: This is the second floor-'
    dw $0c08 ; id 203 '*: This is the third floor-'
    dw $0c0c ; id 204 '*: This is the fourth floor-'
    dw $0c10 ; id 205 '*: This is the fifth floor-'
    dw $0c14 ; id 206 '*: Well. How impressive. I must'
    dw $0000 ; id 207 none
    dw $0000 ; id 208 none
    dw $0000 ; id 209 none
    dw $0000 ; id 210 none
    dw $0c1c ; id 211 '*: This is the second floor-'
    dw $0c20 ; id 212 '*: This is the third floor-'
    dw $0c24 ; id 213 '*: This is the fourth floor-'
    dw $0c28 ; id 214 '*: This is the fifth floor-'
    dw $0c2c ; id 215 '*: Ah, you have impressed me.'
    dw $0000 ; id 216 none
    dw $0000 ; id 217 none
    dw $0000 ; id 218 none
    dw $0000 ; id 219 none
    dw $0c34 ; id 220 '*: This is the second floor.'
    dw $0c38 ; id 221 '*: This is the third floor.'
    dw $0c3c ; id 222 '*: This is the fourth floor.'
    dw $0c40 ; id 223 '*: This is the fifth floor.'
    dw $0c44 ; id 224 '*: Oh? Well, well, you're the'
    dw $0000 ; id 225 none
    dw $0000 ; id 226 none
SceneChestBattle_ShowPostBattleMessage_Data::
    dw $0000 ; id 227 none
    dw $0000 ; id 228 none
    dw $0c07 ; id 229 '*: Not bad, not bad at'
    dw $0c0b ; id 230 '*: You're quite good. The treasures'
    dw $0c0f ; id 231 '*: Wow, aren't you good. Go'
    dw $0c13 ; id 232 '*: Well done. So it shall'
    dw $0c16 ; id 233 '*: Well. How impressive. Conquering the'
    dw $0000 ; id 234 none
    dw $0000 ; id 235 none
    dw $0000 ; id 236 none
    dw $0000 ; id 237 none
    dw $0c1f ; id 238 '*: Well played. I can't complain.'
    dw $0c23 ; id 239 '*: Bravo. Take the treasures. Upstairs'
    dw $0c27 ; id 240 '*: Remarkable, I must admit. You'
    dw $0c2b ; id 241 '*: You're quite tough. The treasures'
    dw $0c2e ; id 242 '*: You are to be commended'
    dw $0000 ; id 243 none
    dw $0000 ; id 244 none
    dw $0000 ; id 245 none
    dw $0000 ; id 246 none
    dw $0c37 ; id 247 '*: You're quite good at this.'
    dw $0c3b ; id 248 '*: You've shown me your worth.'
    dw $0c3f ; id 249 '*: Fine, we will confer all'
    dw $0c43 ; id 250 '*: All right. Good enough. The'
    dw $0c46 ; id 251 '*: You are good! I like'
    dw $0000 ; id 252 none
    dw $0000 ; id 253 none

; Script command $CA, like KeyBossBeaten for a second boss: every call blinks sprite 0 at Y $20
; (ScriptStepBlinkObjectTemp0, 120 frames). When the blink is done it marks the key entry of kind 9
; with bit 6 (MarkKeyEntryKindTemp0Bit6), sets bit 1 of wStoryFlags + $68, puts wObject1 at X $50, Y
; $70 and requests the next script command ($80 in wScriptStartRequest). (C2, E-0384)
; implements script command type CA (SCRIPT_KEY_BOSS_BEATEN_2): the same as SCRIPT_KEY_BOSS_BEATEN
; for another boss: 'But No! I lost to this'; reached through ScriptCommandCA in bank $10 (E-0038,
; E-0245)
KeyBossBeaten2::
    xor a
    ldh [hTemp0], a
    ld a, $20
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a
    ret z
    ld a, $09
    ldh [hTemp0], a
    farcall MarkKeyEntryKindTemp0Bit6
    ld a, [wStoryFlags + $68]
    set 1, a
    ld [wStoryFlags + $68], a
    ld a, $50
    ld [wObject1 + OBJ_X], a
    ld a, $70
    ld [wObject1 + OBJ_Y], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Step runner of script command $C9: step 0 is SceneChestBattle_StartSprite and step 1
; SceneMilayouForest_MoveSprite, which ends by requesting the next script command. (C2, E-0384)
; implements script command type C9 (SCRIPT_SCENE_MILAYOU_FOREST): a cutscene step named after the
; scene its only script shows: 'Milayou I thought this forest looked...'; reached through
; ScriptCommandC9 in bank $10 (E-0038, E-0245)
SceneMilayouForest::
    ld a, [wScriptStep]
    jumptable
    dw SceneChestBattle_StartSprite
    dw SceneMilayouForest_MoveSprite

; Milayou forest, step 1: moves sprite 0 by wScriptParam1 a frame for 16 frames, then stops it and
; asks for the next script command. (C2, E-0357; probed E-0384)
SceneMilayouForest_MoveSprite::
    ld a, [wScriptParam1]
    ld c, a
    ld a, [wSpriteSlots + $b]
    add c
    ld [wSpriteSlots + $b], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $10
    ret nz
    xor a
    ld [wSpriteSlots + $7], a
    ld hl, wSpriteSlots + $d
    call ClearBit2AtHL_Bank73
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Chest battle, step 8: sprite 0 starts moving (bit 2 of its flags) and the step goes on. It walks
; right (wScriptParam1 = 1, facing 1) when the player stands at ($30, $20) or the first follower
; record (wFollowerRecords + $1, + $2) holds that spot, otherwise left (wScriptParam1 = $FF, facing
; 3). The follower loop advances only 2 bytes per party member although the records are 5 bytes
; apart (SceneWizstone_Start steps by 5), so only the first follower is read correctly. (C2, E-0384)
SceneChestBattle_StartSprite::
    ld hl, wSpriteSlots + $d
    call SetBit2AtHL_B73
    ld hl, wScriptStep
    inc [hl]
    ldh a, [hPlayerX]
    cp $30
    jr nz, .read_party_count
    ldh a, [hPlayerY]
    cp $20
    jr z, .set_script_param1_to_012

.read_party_count:
    ld a, [wPartyCount]
    ld b, a
    ld hl, wFollowerRecords + $1

.loop:
    push hl
    ld a, [hli]
    cp $30
    jr nz, .restore
    ld a, [hl]
    cp $20
    jr z, .set_script_param1_to_01

.restore:
    pop hl
    inc hl
    inc hl
    dec b
    jr nz, .loop
    ld a, $ff
    ld [wScriptParam1], a
    ld a, $03
    ld [wSpriteSlots + $7], a
    ret

.set_script_param1_to_01:
    pop hl

.set_script_param1_to_012:
    ld a, $01
    ld [wScriptParam1], a
    ld a, $01
    ld [wSpriteSlots + $7], a
    ret

; Script command $C8, run on every frame until it asks for the next command: sets wObject2 + OBJ_Y
; to $10, stops sprite 0 (wSpriteSlots + $7 = 0) and object 1 (OBJ_STATE 0), sets the moving bit
; (bit 2) in their flags, adds 2 to the Y of sprite 0 (wSpriteSlots + $C) and copies it to wObject1
; + OBJ_Y. When that Y is exactly $B0 it requests the next script command ($80 in
; wScriptStartRequest). (C2, E-0384)
; implements script command type C8 (SCRIPT_SCENE_MERCY): a cutscene step named after the scene its
; only script shows: 'Please! Mercy! Spare us! Take back...'; reached through ScriptCommandC8 in
; bank $10 (E-0038, E-0245)
SceneMercy::
    ld a, $10
    ld [wObject2 + OBJ_Y], a
    xor a
    ld [wSpriteSlots + $7], a
    ld [wObject1 + OBJ_STATE], a
    ld hl, wSpriteSlots + $d
    call SetBit2AtHL_B73
    ld hl, wObject1 + OBJ_FLAGS
    call SetBit2AtHL_B73
    ld a, [wSpriteSlots + $c]
    inc a
    inc a
    ld [wSpriteSlots + $c], a
    ld [wObject1 + OBJ_Y], a
    cp $b0
    ret nz
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Step runner of script command $C5, the WizStone scene: wScriptStep picks the step. 0
; SceneWizstone_Start, 1 SceneWizstone_WalkKiral, 2 SceneWizstone_Msg0780_ProfessorKiralUsedThe, 4
; SceneWizstone_PauseOneFrame, 5 SceneWizstone_Msg0781_KiralYesYesSuccess, 7
; SceneWizstone_WalkKiralBack, 8 SceneWizstone_Msg0782_HeroReceivedTheSmartBook; steps 3 and 6 wait
; for the message (SceneChestBattle_WaitMessage) and step 9 waits and then requests the next script
; command (SceneWizstone_WaitMessage). (C1, E-0384)
; implements script command type C5 (SCRIPT_SCENE_WIZSTONE): a cutscene step named after the scene
; its only script shows: 'Kiral This stone, the WizStone, it...'; reached through ScriptCommandC5 in
; bank $10 (E-0038, E-0245)
SceneWizstone::
    ld a, [wScriptStep]
    jumptable
    dw SceneWizstone_Start
    dw SceneWizstone_WalkKiral
    dw SceneWizstone_Msg0780_ProfessorKiralUsedThe
    dw SceneChestBattle_WaitMessage
    dw SceneWizstone_PauseOneFrame
    dw SceneWizstone_Msg0781_KiralYesYesSuccess
    dw SceneChestBattle_WaitMessage
    dw SceneWizstone_WalkKiralBack
    dw SceneWizstone_Msg0782_HeroReceivedTheSmartBook
    dw SceneWizstone_WaitMessage

; Wizstone, step 8: '<player> received the SmartBook.' ($0782); next step. (C2, E-0357; probed
; E-0384)
SceneWizstone_Msg0782_HeroReceivedTheSmartBook::
    ld hl, $0782 ; '0 received the SmartBook.'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; Wizstone, step 7: walks Kiral (object 0) down to Y $40 and then left to X $10; once there turns it
; to face the player; next step. (C2, E-0357; probed E-0384)
SceneWizstone_WalkKiralBack::
    ld a, [wSpriteSlots + $c]
    cp $40
    jr z, .clear_step_ptr_hi
    xor a
    ld [wStepPtrHi], a
    ld a, $00
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ret

.clear_step_ptr_hi:
    xor a
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $10
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and $03
    ld [wSpriteSlots + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Wizstone, step 5: 'Kiral: Yes! Yes! Success! I owe...' ($0781); next step. (C2, E-0357; probed
; E-0384)
SceneWizstone_Msg0781_KiralYesYesSuccess::
    ld hl, $0781 ; 'Kiral: Yes! Yes! Success! I owe'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; Wizstone, step 4 (between the wait after message $0780 and message $0781): only advances
; wScriptStep, so the next message starts a frame later. (C2, E-0371; probed E-0384)
SceneWizstone_PauseOneFrame::
    ld hl, wScriptStep
    inc [hl]
    ret

; Wizstone, step 2: 'Professor Kiral used the WizStone on...' ($0780); next step. (C2, E-0357;
; probed E-0384)
SceneWizstone_Msg0780_ProfessorKiralUsedThe::
    ld hl, $0780 ; 'Professor Kiral used the WizStone on'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; Wizstone, step 1: walks Kiral right to X $50 and then up to Y $30; once there it faces left; next
; step. (C2, E-0357; probed E-0384)
SceneWizstone_WalkKiral::
    ld a, [wSpriteSlots + $b]
    cp $50
    jr z, .clear_step_ptr_hi
    xor a
    ld [wStepPtrHi], a
    ld a, $01
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ret

.clear_step_ptr_hi:
    xor a
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Wizstone, step 0: when the player or a follower already stands at ($40, $40) goes on to step 1;
; otherwise Kiral faces up and the scene jumps to step 2. (C2, E-0357; probed E-0384)
SceneWizstone_Start::
    ldh a, [hPlayerX]
    cp $40
    jr nz, .check_party_count
    ldh a, [hPlayerY]
    cp $40
    jr z, .done

.check_party_count:
    ld a, [wPartyCount]
    or a
    jr z, .set_sprite_slots_to_02
    ld b, a
    ld hl, wFollowerRecords + $1

.loop:
    push hl
    ld a, [hli]
    cp $40
    jr nz, .restore
    ld a, [hl]
    cp $40
    jr z, .restore2

.restore:
    pop hl
    ld a, $05
    add_a_to_hl
    dec b
    jr nz, .loop

.set_sprite_slots_to_02:
    ld a, $02
    ld [wSpriteSlots + $7], a
    ld a, $02
    ld [wScriptStep], a
    ret

.restore2:
    pop hl

.done:
    ld hl, wScriptStep
    inc [hl]
    ret

; Step runner of script command $CC: step 0 is SceneCyalShine_LoadObject5 and step 1
; SceneCyalShine_Wait, which hides object 5 after 60 frames and requests the next script command.
; (C1, E-0384)
; implements script command type CC (SCRIPT_SCENE_CYAL_SHINE): a cutscene step named after the scene
; its only script shows: ... 'So Cyal took a shine to...'; reached through ScriptCommandCC in bank
; $10 (E-0038, E-0245)
SceneCyalShine::
    ld a, [wScriptStep]
    jumptable
    dw SceneCyalShine_LoadObject5
    dw SceneCyalShine_Wait

; Cyal shine, step 1: after 60 frames hides object 5 and asks for the next script command. (C2,
; E-0357; probed E-0384)
SceneCyalShine_Wait::
    ld b, $3c
    call StepScriptParam0Counter_Bank73
    ret nc
    xor a
    ld [wObject5], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Cyal shine, step 0: runs field command 5 and places object 5 at ($40, $20); next step. (C1,
; E-0357)
SceneCyalShine_LoadObject5::
    ld a, $05
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $20
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Script command $C6: on step 0 sets the destination of a map change (hMapId $A9, screen X 1, screen
; Y 0, wWarpDestX $60, wWarpDestY $10, wFieldTransitionKind 2) and starts the fade
; (ScriptStartFadeAndAdvanceStep, which also advances wScriptStep); on any later step it requests
; the next script command ($80 in wScriptStartRequest). (C1, E-0384)
; implements script command type C6 (SCRIPT_SCENE_CYAL_ROLT): a cutscene step named after the scene
; its only script shows: 'Rolt 0, I'm sorry we put...' ... 'I'm glad that Cyal and Rolt...'; reached
; through ScriptCommandC6 in bank $10 (E-0038, E-0245)
SceneCyalRolt::
    ld a, [wScriptStep]
    or a
    jr nz, .set_script_start_request_to_80
    ld a, $a9
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a
    ldh [hMapScreenY], a
    ld a, $60
    ld [wWarpDestX], a
    ld a, $10
    ld [wWarpDestY], a
    ld a, $02
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

.set_script_start_request_to_80:
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Script command $C3: every call blinks sprite 0 at Y $30 (ScriptStepBlinkObjectTemp0, 120 frames).
; When the blink is done it marks the key entry of kind 7 with bit 6 (MarkKeyEntryKindTemp0Bit6) and
; requests the next script command ($80 in wScriptStartRequest). (C2, E-0384)
; implements script command type C3 (SCRIPT_KEY_BOSS_BEATEN): marks key entry kind hTemp0 with bit 6
; (MarkKeyEntryKindTemp0Bit6) and blinks an object: 'Wh-what? I Lost to a child?'; reached through
; ScriptCommandC3 in bank $10 (E-0038, E-0245)
KeyBossBeaten::
    xor a
    ldh [hTemp0], a
    ld a, $30
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a
    ret z
    ld a, $07
    ldh [hTemp0], a
    farcall MarkKeyEntryKindTemp0Bit6
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Step runner of script command $C1: wScriptStep picks the step. 0 SceneTooStrong_BlinkOut, 1
; SceneChestBattle_WaitMessage, 2 SceneTooStrong_WalkRight and 3 SceneTooStrong_JumpOff. (C1,
; E-0384)
; implements script command type C1 (SCRIPT_SCENE_TOO_STRONG): a cutscene step named after the scene
; its only script shows: 'Too strong Arroooh!' ... 'Rolt What? Cyal was abducted?'; reached through
; ScriptCommandC1 in bank $10 (E-0038, E-0245)
SceneTooStrong::
    ld a, [wScriptStep]
    jumptable
    dw SceneTooStrong_BlinkOut
    dw SceneChestBattle_WaitMessage
    dw SceneTooStrong_WalkRight
    dw SceneTooStrong_JumpOff

; Too strong, step 3: walks sprite 0 and object 1 right to X $C0 together while moving their Y by
; the high byte of a counter (wMessageIndex/Group reused) that starts at $0300 and drops by 8 a
; frame, a jump arc; once there asks for the next script command. (C2, E-0357; probed E-0384)
SceneTooStrong_JumpOff::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    ld a, l
    sub $08
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    ld a, [wSpriteSlots + $c]
    sub h
    ld [wSpriteSlots + $c], a
    ld a, [wObject1 + OBJ_Y]
    sub h
    ld [wObject1 + OBJ_Y], a
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $01
    ld [wStepTarget], a
    ld a, $c0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $01
    ld [wStepTarget], a
    ld a, $c0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Too strong, step 2: object 1 walks right to X $60, then stops; sets the speed counter to $0300;
; next step. (C2, E-0357; probed E-0384)
SceneTooStrong_WalkRight::
    ld hl, wObject1 + OBJ_FLAGS
    call SetBit2AtHL_B73
    ld a, $01
    ld [wObject1 + OBJ_STATE], a
    ld a, [wObject1 + OBJ_X]
    cp $60
    jr z, .call_clear_bit2_at_hl_bank73
    inc a
    ld [wObject1 + OBJ_X], a
    ret

.call_clear_bit2_at_hl_bank73:
    ld hl, wObject1 + OBJ_FLAGS
    call ClearBit2AtHL_Bank73
    ld hl, $0300
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Too strong, step 0: blinks object 2 at Y $40 (object 3 follows it); afterwards drops two sprite
; slots, stops object 1 and says 'Tch, I can't enjoy my...' ($0725); next step. (C2, E-0357; probed
; E-0384)
SceneTooStrong_BlinkOut::
    ld a, $02
    ldh [hTemp0], a
    ld a, $40
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ld a, [wObject2 + OBJ_Y]
    cp $40
    jr z, .set_object3
    ld a, $30

.set_object3:
    ld [wObject3 + OBJ_Y], a
    ldh a, [hTemp0]
    or a
    ret z
    ld a, [wSpriteSlotCount]
    dec a
    dec a
    ld [wSpriteSlotCount], a
    xor a
    ld [wObject1 + OBJ_STATE], a
    ld hl, $0725 ; '*: Tch, I can't enjoy my'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; Step runner of script command $C0, the Rolt and elder scene: wScriptStep picks the step. 0
; SceneRoltElder_WalkUp, 1 SceneRoltElder_WalkApart, 2 SceneRoltElder_WalkRight and 3
; SceneRoltElder_WalkUpTogether. (C2, E-0384)
; implements script command type C0 (SCRIPT_SCENE_ROLT_ELDER): a cutscene step named after the scene
; its only script shows: 'I'm the village's elder.' ... 'Rolt That was fast, 0.'; reached through
; ScriptCommandC0 in bank $10 (E-0038, E-0245)
SceneRoltElder::
    ld a, [wScriptStep]
    jumptable
    dw SceneRoltElder_WalkUp
    dw SceneRoltElder_WalkApart
    dw SceneRoltElder_WalkRight
    dw SceneRoltElder_WalkUpTogether

; Rolt elder, step 3: objects 1 and 2 walk up together until object 1 reaches Y $50; then they stop
; and the next script command is asked for. (C2, E-0357; probed E-0384)
SceneRoltElder_WalkUpTogether::
    ld a, [wObject2 + OBJ_Y]
    dec a
    ld [wObject2 + OBJ_Y], a
    ld a, [wObject1 + OBJ_Y]
    dec a
    ld [wObject1 + OBJ_Y], a
    cp $50
    ret nz
    ld hl, wObject1 + OBJ_FLAGS
    call ClearBit2AtHL_Bank73
    ld hl, wObject2 + OBJ_FLAGS
    call ClearBit2AtHL_Bank73
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Rolt elder, step 2: objects 1 and 2 walk right together until object 1 reaches X $60; then both
; face up; next step. (C2, E-0357; probed E-0384)
SceneRoltElder_WalkRight::
    ld a, [wObject2 + OBJ_X]
    inc a
    ld [wObject2 + OBJ_X], a
    ld a, [wObject1 + OBJ_X]
    inc a
    ld [wObject1 + OBJ_X], a
    cp $60
    ret nz
    ld a, $02
    ld [wObject1 + OBJ_STATE], a
    ld [wObject2 + OBJ_STATE], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Rolt elder, step 1: object 1 walks right and object 2 up until object 2 reaches Y $60; it then
; faces right; next step. (C2, E-0357; probed E-0384)
SceneRoltElder_WalkApart::
    ld a, [wObject1 + OBJ_X]
    inc a
    ld [wObject1 + OBJ_X], a
    ld a, [wObject2 + OBJ_Y]
    dec a
    ld [wObject2 + OBJ_Y], a
    cp $60
    ret nz
    ld a, $01
    ld [wObject2 + OBJ_STATE], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Rolt elder, step 0: objects 1 and 2 start moving and walk up until object 1 reaches Y $60, which
; then faces right; next step. (C2, E-0357; probed E-0384)
SceneRoltElder_WalkUp::
    ld hl, wObject1 + OBJ_FLAGS
    call SetBit2AtHL_B73
    ld hl, wObject2 + OBJ_FLAGS
    call SetBit2AtHL_B73
    ld a, [wObject2 + OBJ_Y]
    dec a
    ld [wObject2 + OBJ_Y], a
    ld a, [wObject1 + OBJ_Y]
    dec a
    ld [wObject1 + OBJ_Y], a
    cp $60
    ret nz
    ld a, $01
    ld [wObject1 + OBJ_STATE], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Step runner of script command $64: steps 0, 1 and 2 are GatherFollowers_MoveToLeader (map sprite
; kind $10, then ScriptStepMoveFollowersToLeader moves the followers onto the leader; each of the
; three runs ends when its counter reaches $11 and advances wScriptStep) and step 3 is
; GatherFollowers_SetScriptStartRequestTo80. (C2, E-0384)
; implements script command type 64 (SCRIPT_GATHER_FOLLOWERS): moves the followers onto the leader
; (ScriptStepMoveFollowersToLeader); reached through ScriptCommand64 in bank $10 (E-0038, E-0245)
GatherFollowers::
    ld a, [wScriptStep]
    jumptable
    dw GatherFollowers_MoveToLeader
    dw GatherFollowers_MoveToLeader
    dw GatherFollowers_MoveToLeader
    dw GatherFollowers_SetScriptStartRequestTo80

; Gather followers, step 3: asks for the next script command. (C2, E-0357; probed E-0384)
GatherFollowers_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Script command $63: on step 0 sets the destination of a map change (hMapId $28, screen X 0, screen
; Y 1, wWarpDestX $40, wWarpDestY $80, wFieldTransitionKind 3), starts the fade
; (ScriptStartFadeAndAdvanceStep) and a palette fade (StartPaletteFade with A = 4); on any later
; step it requests the next script command ($80 in wScriptStartRequest). (C1, E-0384)
; implements script command type 63 (SCRIPT_SCENE_RIVAL_FADE): a cutscene step named after the scene
; its only script shows: 'You defeated my monster? Urggh' (palette fade); reached through
; ScriptCommand63 in bank $10 (E-0038, E-0245)
SceneRivalFade::
    ld a, [wScriptStep]
    or a
    jr nz, .set_script_start_request_to_80
    ld a, $28
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ld a, $01
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $80
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld a, $04
    call StartPaletteFade
    ret

.set_script_start_request_to_80:
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Step runner of script command $61: wScriptStep picks the step. 0, 1 and 2
; SceneKamehaStole_GatherFollowers, 3 SceneKamehaStole_WalkFollowers, 4
; SceneKamehaStole_WalkFollower2, 5 SceneKamehaStole_WalkFollower3 and 6
; SceneKamehaStole_DrawBlocks. (C1, E-0384)
; implements script command type 61 (SCRIPT_SCENE_KAMEHA_STOLE): a cutscene step named after the
; scene its only script shows: 'King Kameha made off with the...'; reached through ScriptCommand61
; in bank $10 (E-0038, E-0245)
SceneKamehaStole::
    ld a, [wScriptStep]
    jumptable
    dw SceneKamehaStole_GatherFollowers
    dw SceneKamehaStole_GatherFollowers
    dw SceneKamehaStole_GatherFollowers
    dw SceneKamehaStole_WalkFollowers
    dw SceneKamehaStole_WalkFollower2
    dw SceneKamehaStole_WalkFollower3
    dw SceneKamehaStole_DrawBlocks

; Kameha stole, step 6: draws a 2 x 2 block of tiles $2B-$2E behind each follower's place (as many
; as the party has), redraws the screen, sets the follower delay to 1, clears the map sprite kind
; and asks for the next script command. (C1, E-0357)
SceneKamehaStole_DrawBlocks::
    ld hl, wScreenTileBuffer + $a8
    ld [hl], $2b
    inc hl
    ld [hl], $2c
    ld hl, wScreenTileBuffer + $bc
    ld [hl], $2d
    inc hl
    ld [hl], $2e
    ld a, [wPartyCount]
    dec a
    jr z, .call_draw_full_screen_buffer_at_scroll
    ld hl, wScreenTileBuffer + $ce
    ld [hl], $2b
    inc hl
    ld [hl], $2c
    ld hl, wScreenTileBuffer + $e2
    ld [hl], $2d
    inc hl
    ld [hl], $2e
    ld a, [wPartyCount]
    dec a
    dec a
    jr z, .call_draw_full_screen_buffer_at_scroll
    ld hl, wScreenTileBuffer + $f8
    ld [hl], $2b
    inc hl
    ld [hl], $2c
    ld hl, wScreenTileBuffer + $10c
    ld [hl], $2d
    inc hl
    ld [hl], $2e

.call_draw_full_screen_buffer_at_scroll:
    farcall DrawFullScreenBufferAtScroll
    ld a, $01
    ld [wFollowerDelay], a
    xor a
    ld [wMapSpriteKind], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Kameha stole, step 5: the third follower walks down to Y $60 and then right to X $40, facing up
; when it arrives; next step. (C2, E-0357; probed E-0384)
SceneKamehaStole_WalkFollower3::
    ld a, [wFollowerRecords + $c]
    cp $60
    jr z, .set_follower_records_to_01
    ld hl, wFollowerRecords + $c
    inc [hl]
    ret

.set_follower_records_to_01:
    ld a, $01
    ld [wFollowerRecords + $a], a
    ld a, [wFollowerRecords + $b]
    inc a
    ld [wFollowerRecords + $b], a
    cp $40
    ret nz
    ld a, $02
    ld [wFollowerRecords + $a], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Kameha stole, step 4: the second follower walks left to X $30 and then down to Y $50; with two in
; the party the scene skips to step 6, otherwise next step. (C2, E-0357; probed E-0384)
SceneKamehaStole_WalkFollower2::
    ld a, [wFollowerRecords + $6]
    cp $30
    jr z, .clear_follower_records
    ld a, [wFollowerRecords + $6]
    dec a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $b], a
    ret

.clear_follower_records:
    xor a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    ld a, [wFollowerRecords + $7]
    inc a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $c], a
    cp $50
    ret nz
    ld a, $01
    ld [wFollowerRecords + $5], a
    ld hl, wScriptStep
    inc [hl]
    ld a, [wPartyCount]
    dec a
    dec a
    ret nz
    ld a, $06
    ld [wScriptStep], a
    ret

; Kameha stole, step 3: all three followers walk up to Y $40 and then left to X $40; with one in the
; party the scene skips to step 6, otherwise next step. (C2, E-0357; probed E-0384)
SceneKamehaStole_WalkFollowers::
    ld a, [wFollowerRecords + $2]
    cp $40
    jr z, .set_follower_records_to_03
    ld a, $02
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    ld a, [wFollowerRecords + $2]
    dec a
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $c], a
    ret

.set_follower_records_to_03:
    ld a, $03
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    ld a, [wFollowerRecords + $1]
    dec a
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $b], a
    cp $40
    ret nz
    xor a
    ld [wFollowerRecords], a
    ld hl, wScriptStep
    inc [hl]
    ld a, [wPartyCount]
    dec a
    ret nz
    ld a, $06
    ld [wScriptStep], a
    ret

; Kameha stole, steps 0-2: far-calls ScriptStepMoveFollowersToLeader to gather the followers on the
; leader. (C2, E-0371; probed E-0384)
SceneKamehaStole_GatherFollowers::
    farcall ScriptStepMoveFollowersToLeader
    ret

; Step runner of script command $60: wScriptStep picks the step. 0 ScriptCommand60_Run_ShowObject, 1
; ScriptCommand60_Run_RaiseObject, 2 ScriptCommand60_Run_HopSprite, 3 ScriptCommand60_Run_Wait and 4
; ScriptCommand60_Run_TakeMedal. (C2, E-0384)
; implements script command type 60; reached through ScriptCommand60 in bank $10 (E-0038)
ScriptCommand60_Run::
    ld a, [wScriptStep]
    jumptable
    dw ScriptCommand60_Run_ShowObject
    dw ScriptCommand60_Run_RaiseObject
    dw ScriptCommand60_Run_HopSprite
    dw ScriptCommand60_Run_Wait
    dw ScriptCommand60_Run_TakeMedal

; Command 60, step 4: object 5 sinks away along the hop curve; then it is hidden, a TinyMedal ($2C)
; is taken from the bag and the next script command is asked for. (C2, E-0357; probed E-0384)
ScriptCommand60_Run_TakeMedal::
    ld hl, wObject5 + SCRIPTOBJ_X
    inc [hl]
    ld hl, wObject5 + SCRIPTOBJ_Y
    inc [hl]
    ld de, wObject5 + SCRIPTOBJ_Y
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    xor a
    ld [wObject5], a
    ld a, $2c
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    farcall RemoveInventorySlotShiftDown
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Command 60, step 3: waits 90 frames; next step. (C2, E-0357; probed E-0384)
ScriptCommand60_Run_Wait::
    ld b, $5a
    call StepScriptParam0Counter_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; Command 60, step 2: sprite 0 hops by the table for 32 frames; next step. (C2, E-0357; probed
; E-0384)
ScriptCommand60_Run_HopSprite::
    ld de, wSpriteSlots + $c
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $20
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Command 60, step 0: runs field command $10 and shows object 5 at ($50, $30); next step. (C1,
; E-0357)
ScriptCommand60_Run_ShowObject::
    ld a, $10
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $50
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $30
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld a, $80
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Script command $5D: every call blinks sprite 0 at Y $30 (ScriptStepBlinkObjectTemp0, 120 frames).
; When the blink is done it sets wSpriteSlotCount to 0 and requests the next script command ($80 in
; wScriptStartRequest). (C2, E-0384)
; implements script command type 5D (SCRIPT_SCENE_DARCK_TAUNT): a cutscene step named after the
; scene its only script shows: 'N No How could my monsters' ... 'Darck Fawahahah!'; reached through
; ScriptCommand5D in bank $10 (E-0038, E-0245)
SceneDarckTaunt::
    xor a
    ldh [hTemp0], a
    ld a, $30
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a
    ret z
    xor a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Script command $5C: for 120 frames (wScriptParam0 up to $77) object 1 (wObject1 + OBJ_Y) blinks
; between Y $20 and Y $E0 (hidden) on bit 1 of wScriptParam0 below $1E, bit 2 below $3C and bit 3
; from there on (slower and slower). When wScriptParam0 reaches $78 it sets Y back to $20, removes
; the three items ITEM_TIDALBELL ($36), ITEM_HARMIRROR ($37) and ITEM_SKY ($38) from the bag
; (FindTemp0InInventoryList, RemoveInventorySlotShiftDown, once each) and requests the next script
; command ($80). hTemp0 is not an input. (C2, E-0384)
; implements script command type 5C (SCRIPT_TAKE_ITEM): removes item hTemp0 from the inventory
; (FindTemp0InInventoryList, RemoveInventorySlotShiftDown); '0 handed over the TidalBell.'; reached
; through ScriptCommand5C in bank $10 (E-0038, E-0245)
TakeItem::
    ld a, [wScriptParam0]
    cp $1e
    jr nc, .cp_3C
    bit 1, a
    jr z, .set_object1_to_20
    jr .set_object1_to_E0

.cp_3C:
    cp $3c
    jr nc, .check_bit3
    bit 2, a
    jr z, .set_object1_to_20
    jr .set_object1_to_E0

.check_bit3:
    bit 3, a
    jr z, .set_object1_to_20
    jr .set_object1_to_E0

.set_object1_to_20:
    ld a, $20
    ld [wObject1 + OBJ_Y], a
    jr .check_script_param0

.set_object1_to_E0:
    ld a, $e0
    ld [wObject1 + OBJ_Y], a

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $78
    ret nz
    ld a, $20
    ld [wObject1 + OBJ_Y], a
    ld a, $36
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    farcall RemoveInventorySlotShiftDown
    ld a, $37
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    farcall RemoveInventorySlotShiftDown
    ld a, $38
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    farcall RemoveInventorySlotShiftDown
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Step runner of script commands $59 and $5A: wScriptStep picks the step. 0 SceneSawKameha_WalkUp, 1
; SceneSawKameha_WalkOffAndWarp and 2 SceneSawKameha_AddKey. (C1, E-0384)
; implements script command type 59 (also 5A); reached through ScriptCommand59 in bank $10 (E-0038)
SceneSawKameha::
    ld a, [wScriptStep]
    jumptable
    dw SceneSawKameha_WalkUp
    dw SceneSawKameha_WalkOffAndWarp
    dw SceneSawKameha_AddKey

; Saw Kameha, step 2: adds a key of kind 5 to the key list (in the first free entry) and asks for
; the bag sort and the next script command. (C2, E-0357; probed E-0384)
SceneSawKameha_AddKey::
    farcall CountKeysOrFull
    ld a, $05
    ldh [hTemp1], a
    farcall WriteKeyEntryTemp0
    ld a, [wInventorySortFlags]
    set 7, a
    ld [wInventorySortFlags], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Saw Kameha, step 1: the player and the followers walk up off the screen (Y $C0); then warps to map
; $19, screen (0, 0) at ($40, $40) with transition kind 3 and a fade. (C1, E-0357)
SceneSawKameha_WalkOffAndWarp::
    ld hl, wFollowerRecords + $2
    dec [hl]
    ld hl, wFollowerRecords + $7
    dec [hl]
    ld hl, wFollowerRecords + $c
    dec [hl]
    ldh a, [hPlayerY]
    dec a
    ldh [hPlayerY], a
    cp $c0
    ret nz
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank73
    ld a, $19
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; Saw Kameha, step 0: object 0 walks up to Y $B0 while the player walks up to Y 0; once there the
; player keeps moving (bit 2); next step. (C2, E-0357; probed E-0384)
SceneSawKameha_WalkUp::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $b0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $00
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; Step runner of script command $57: wScriptStep picks the step. 0
; SceneThreeItemsBattle_StartBattle, 1 SceneThreeItemsBattle_Msg0480_GwaahYouveBeatenMe, 2
; SceneChestBattle_WaitMessage and 3 SceneThreeItemsBattle_BlinkOut. (C1, E-0384)
; implements script command type 57 (SCRIPT_SCENE_THREE_ITEMS_BATTLE): a cutscene step named after
; the scene its only script shows: 'Good. You have brought the three...' ... 'Don't you ever give
; up?' (encounter); reached through ScriptCommand57 in bank $10 (E-0038, E-0245)
SceneThreeItemsBattle::
    ld a, [wScriptStep]
    jumptable
    dw SceneThreeItemsBattle_StartBattle
    dw SceneThreeItemsBattle_Msg0480_GwaahYouveBeatenMe
    dw SceneChestBattle_WaitMessage
    dw SceneThreeItemsBattle_BlinkOut

; Three items battle, step 3: blinks object 0 at Y $20, then hides the sprites and asks for the next
; script command. (C2, E-0357; probed E-0384)
SceneThreeItemsBattle_BlinkOut::
    xor a
    ldh [hTemp0], a
    ld a, $20
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a
    ret z
    xor a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Three items battle, step 1: 'Gwaah! You've beaten me fairly!' ($0480); next step. (C2, E-0357;
; probed E-0384)
SceneThreeItemsBattle_Msg0480_GwaahYouveBeatenMe::
    ld hl, $0480 ; '*: Gwaah! You've beaten me fairly!'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; Three items battle, step 0: starts scripted encounter $1C; next step. (C1, E-0357)
SceneThreeItemsBattle_StartBattle::
    ld a, $1c
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; Script command $68: moves sprite 0 sideways, one pixel a call (StepObjectTowardCoord): toward X
; $60 when the player stands at X $40 (any Y) or a follower stands at ($40, $40), toward X $40 when
; the player stands at X $60 or a follower stands at ($60, $40), and toward X $40 when nobody does.
; Followers are read from wFollowerRecords + $1 at 5-byte steps. When the sprite has arrived it
; requests the next script command ($80 in wScriptStartRequest). (C2, E-0384)
; implements script command type 68 (SCRIPT_SCENE_FOUND_ME): a cutscene step named after the scene
; its only script shows: 'I'm surprised anyone managed to find...'; reached through ScriptCommand68
; in bank $10 (E-0038, E-0245)
SceneFoundMe::
    ldh a, [hPlayerX]
    cp $40
    jr z, .set_step_target_to_01
    cp $60
    jr z, .set_step_target_to_03
    ld a, [wPartyCount]
    ld b, a
    ld hl, wFollowerRecords + $1

.loop:
    push hl
    ld a, [hl]
    cp $40
    jr nz, .skip
    inc hl
    ld a, [hl]
    cp $40
    jr nz, .restore
    pop hl
    jr .set_step_target_to_01

.skip:
    ld a, [hl]
    cp $60
    jr nz, .restore
    inc hl
    ld a, [hl]
    cp $40
    jr nz, .restore
    pop hl
    jr .set_step_target_to_03

.restore:
    pop hl
    ld a, $05
    add_a_to_hl
    dec b
    jr nz, .loop

.set_step_target_to_03:
    ld a, $03
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    jr .clear_step_ptr_hi

.set_step_target_to_01:
    ld a, $01
    ld [wStepTarget], a
    ld a, $60
    ld [wStepPtrLo], a

.clear_step_ptr_hi:
    xor a
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Script command $56: every call blinks sprite 0 at Y $30 (ScriptStepBlinkObjectTemp0, 120 frames).
; When the blink is done it sets wSpriteSlotCount to 0 and requests the next script command ($80 in
; wScriptStartRequest). (C2, E-0384)
; implements script command type 56 (SCRIPT_SCENE_BEATEN_FAIRLY): a cutscene step named after the
; scene its only script shows: 'You've beaten me fairly Take...'; reached through ScriptCommand56 in
; bank $10 (E-0038, E-0245)
SceneBeatenFairly::
    xor a
    ldh [hTemp0], a
    ld a, $30
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a
    ret z
    xor a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Script command $55: sets bit 2 of wStoryFlags + $64 (story flag $322, keeping the other bits) and
; requests the next script command ($80 in wScriptStartRequest). (C2, E-0384)
; implements script command type 55 (SCRIPT_SET_FLAG_322): sets story flag $322 (wStoryFlags + $64
; bit 2); 'A door opened somewhere'; reached through ScriptCommand55 in bank $10 (E-0038, E-0245)
SetFlag322::
    ld a, [wStoryFlags + $64]
    set 2, a
    ld [wStoryFlags + $64], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Step runner of script command $54, the gravestone scene: wScriptStep picks the step. 0
; SceneGravestone_StartPush, 1 SceneGravestone_PushIfClear, 2 SceneGravestone_MoveStone, 3
; SceneGravestone_WalkUp and 4 SceneGravestone_Open. Steps 1 and 2 repeat in turn for each 16-pixel
; push. (C1, E-0384)
; implements script command type 54 (SCRIPT_SCENE_GRAVESTONE): a cutscene step named after the scene
; its only script shows: before '0 checked the gravestone.'; reached through ScriptCommand54 in bank
; $10 (E-0038, E-0245)
SceneGravestone::
    ld a, [wScriptStep]
    jumptable
    dw SceneGravestone_StartPush
    dw SceneGravestone_PushIfClear
    dw SceneGravestone_MoveStone
    dw SceneGravestone_WalkUp
    dw SceneGravestone_Open

; Gravestone, step 4: blinks object 0 at Y $20; afterwards hides the sprites, sets story flag byte
; $64 bit 1, plays sound $66, draws the opened tiles ($56-$5B), redraws the screen, sets
; EVENT_SCENE_GRAVESTONE and asks for the next script command. (C1, E-0357)
SceneGravestone_Open::
    xor a
    ldh [hTemp0], a
    ld a, $20
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a
    ret z
    xor a
    ld [wSpriteSlotCount], a
    ld a, [wStoryFlags + $64]
    set 1, a
    ld [wStoryFlags + $64], a
    ld a, $66
    call QueueSoundEffect
    ld hl, wScreenTileBuffer + $2
    ld [hl], $56
    inc hl
    ld [hl], $57
    inc hl
    ld [hl], $57
    inc hl
    ld [hl], $58
    inc hl
    ld a, $10
    add_a_to_hl
    ld [hl], $59
    inc hl
    ld [hl], $5a
    inc hl
    ld [hl], $5a
    inc hl
    ld [hl], $5b
    farcall DrawFullScreenBufferAtScroll
    ld de, EVENT_SCENE_GRAVESTONE
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Gravestone, step 3: walks object 0 up to Y $20; next step. (C2, E-0357; probed E-0384)
SceneGravestone_WalkUp::
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; Moves sprite 0 (wSpriteSlots + $B is X, + $C is Y) one pixel a call in the direction wScriptParam1
; (0 down, 1 right, 2 up, 3 left) and counts wScriptParam0 up; after 16 calls it clears the counter
; and tests the position: at X $80, Y $30 it goes on to the next step, otherwise it goes back one
; step (to SceneGravestone_PushIfClear, for the next 16-pixel push). (C2, E-0384)
; moves wSpriteSlots + $B/wSpriteSlots + $C one pixel in direction wScriptParam1 for 16 frames; at
; ($80, $30) advances wScriptStep, otherwise repeats the step (E-0125)
SceneGravestone_MoveStone::
    ld a, [wScriptParam1]
    or a
    jr nz, .skip
    ld hl, wSpriteSlots + $c
    inc [hl]
    jr .check_script_param02

.skip:
    dec a
    jr nz, .skip2
    ld hl, wSpriteSlots + $b
    inc [hl]
    jr .check_script_param02

.skip2:
    dec a
    jr nz, .check_script_param0
    ld hl, wSpriteSlots + $c
    dec [hl]
    jr .check_script_param02

.check_script_param0:
    ld hl, wSpriteSlots + $b
    dec [hl]

.check_script_param02:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $10
    ret nz
    xor a
    ld [wScriptParam0], a
    ld a, [wSpriteSlots + $c]
    cp $30
    jr nz, .done
    ld a, [wSpriteSlots + $b]
    cp $80
    jr nz, .done
    ld hl, wScriptStep
    inc [hl]
    ret

.done:
    ld hl, wScriptStep
    dec [hl]
    ret

; Gravestone, step 1: checks the four tiles under the stone's next place (its position plus the step
; in wMessageIndex/Group): a blocking tile stops it (moving bit clear, next script command);
; otherwise it moves a step (SceneGravestone_MoveStone); next step. (C2, E-0357; probed E-0384)
SceneGravestone_PushIfClear::
    ld a, [wMessageIndex]
    ld d, a
    ld a, [wSpriteSlots + $b]
    add d
    ld b, a
    ld a, [wMessageGroup]
    ld d, a
    ld a, [wSpriteSlots + $c]
    add d
    ld c, a
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
    ld de, wScreenTileBuffer
    add hl, de
    ld de, wTilesUnderPoint
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ld a, $13
    inc de
    add_a_to_hl
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    dec de
    dec de
    dec de
    ld b, $04

.loop:
    ld a, [de]
    inc de
    ld c, a
    ld a, [wMaxBlockingTile]
    cp c
    jr c, .next
    jr .call_clear_bit2_at_hl_bank73

.next:
    dec b
    jr nz, .loop
    call SceneGravestone_MoveStone
    ld hl, wScriptStep
    inc [hl]
    ret

.call_clear_bit2_at_hl_bank73:
    ld hl, wSpriteSlots + $d
    call ClearBit2AtHL_Bank73
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Gravestone, step 0: by the player's column picks the push direction (the table entry: facing and
; the X/Y step kept in wMessageIndex/Group) and starts object 0 moving; next step. (C2, E-0357;
; probed E-0384)
SceneGravestone_StartPush::
    ldh a, [hPlayerX]
    swap a
    and $0f
    sub $05
    and $03
    sla a
    sla a
    ld hl, SceneGravestone_StartPush_Data
    add_a_to_hl
    ld a, [hli]
    ld [wScriptParam1], a
    ld [wSpriteSlots + $7], a
    ld a, [hli]
    ld [wMessageIndex], a
    ld a, [hl]
    ld [wMessageGroup], a
    ld hl, wSpriteSlots + $d
    call SetBit2AtHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; Four 4-byte entries chosen by the player column: ((hPlayerX high nibble) - 5) AND 3. Byte 0 is a
; facing for wScriptParam1 and the sprite slot (3 left, 2 up, 0 down, 1 right), byte 1 goes to
; wMessageIndex and byte 2 to wMessageGroup as the X and Y step ($F0 is -16, $10 is +16); byte 3 is
; $00 and is not read. The four entries are (3, -16, 0), (2, 0, -16), (0, 0, +16) and (1, +16, 0),
; so the gravestone is pushed left, up, down or right depending on where the player stands. (C1,
; E-0381)
SceneGravestone_StartPush_Data::
    db $03, $f0, $00, $00, $02, $00, $f0, $00, $00, $00, $10, $00, $01, $10, $00, $00

; Script command $53, the justice puzzle, run once per call: depending on whether hPlayerX and
; hPlayerY equal $30 it advances two or three of the four 2 x 4 tile blocks at wScreenTileBuffer +
; $52, + $60, + $F2 and + $100 (SceneJustice_AnimateTileBlock). When the first tile of all four
; blocks is $10 it queues sound $66, draws the tiles $46-$4B at wScreenTileBuffer + $30, sets bit 0
; of wStoryFlags + $64 and EVENT_SCENE_JUSTICE. Every call ends by redrawing the screen
; (DrawFullScreenBufferAtScroll) and requesting the next script command ($80 in
; wScriptStartRequest). (C1, E-0384)
; implements script command type 53 (SCRIPT_SCENE_JUSTICE): a cutscene step named after the scene
; its only script shows: 'Let the power of justice smite...' ... '0 checked the gravestone.';
; reached through ScriptCommand53 in bank $10 (E-0038, E-0245)
SceneJustice::
    ldh a, [hPlayerX]
    cp $30
    jr nz, .check_player_y
    ldh a, [hPlayerY]
    cp $30
    jr nz, .call_scene_justice_animate_tile_block
    ld hl, wScreenTileBuffer + $52
    call SceneJustice_AnimateTileBlock
    ld hl, wScreenTileBuffer + $f2
    call SceneJustice_AnimateTileBlock
    ld hl, wScreenTileBuffer + $100
    call SceneJustice_AnimateTileBlock
    jr .check_screen_tile_buffer

.call_scene_justice_animate_tile_block:
    ld hl, wScreenTileBuffer + $f2
    call SceneJustice_AnimateTileBlock
    ld hl, wScreenTileBuffer + $100
    call SceneJustice_AnimateTileBlock
    jr .check_screen_tile_buffer

.check_player_y:
    ldh a, [hPlayerY]
    cp $30
    jr nz, .call_scene_justice_animate_tile_block2
    ld hl, wScreenTileBuffer + $60
    call SceneJustice_AnimateTileBlock
    ld hl, wScreenTileBuffer + $f2
    call SceneJustice_AnimateTileBlock
    jr .check_screen_tile_buffer

.call_scene_justice_animate_tile_block2:
    ld hl, wScreenTileBuffer + $60
    call SceneJustice_AnimateTileBlock
    ld hl, wScreenTileBuffer + $100
    call SceneJustice_AnimateTileBlock

.check_screen_tile_buffer:
    ld a, [wScreenTileBuffer + $52]
    cp $10
    jr nz, .call_draw_full_screen_buffer_at_scroll
    ld a, [wScreenTileBuffer + $60]
    cp $10
    jr nz, .call_draw_full_screen_buffer_at_scroll
    ld a, [wScreenTileBuffer + $f2]
    cp $10
    jr nz, .call_draw_full_screen_buffer_at_scroll
    ld a, [wScreenTileBuffer + $100]
    cp $10
    jr nz, .call_draw_full_screen_buffer_at_scroll
    ld a, $66
    call QueueSoundEffect
    ld hl, wScreenTileBuffer + $30
    ld [hl], $46
    inc hl
    ld [hl], $47
    inc hl
    ld [hl], $47
    inc hl
    ld [hl], $48
    inc hl
    ld a, $10
    add_a_to_hl
    ld [hl], $49
    inc hl
    ld [hl], $4a
    inc hl
    ld [hl], $4a
    inc hl
    ld [hl], $4b
    ld a, [wStoryFlags + $64]
    set 0, a
    ld [wStoryFlags + $64], a
    ld de, EVENT_SCENE_JUSTICE
    call SetFlagBit

.call_draw_full_screen_buffer_at_scroll:
    farcall DrawFullScreenBufferAtScroll
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; HL = a place in wScreenTileBuffer (rows of 20): adds 8 to the block of tile numbers there, two
; wide and four rows tall (SceneJustice_StepWrapPosition per row, $28 and above wrapping back by
; $18); on CGB also writes attribute 5 to the same 8 bytes of wScreenAttrBuffer (WRAM bank 2,
; SceneJustice_SetPosition). The cp $18 before C = 5 has no effect, so the attribute is always 5.
; (C2, E-0371; probed E-0384)
SceneJustice_AnimateTileBlock::
    push hl
    call SceneJustice_StepWrapPosition
    call SceneJustice_StepWrapPosition
    call SceneJustice_StepWrapPosition
    call SceneJustice_StepWrapPosition
    pop hl
    ld a, [wIsCGB]
    or a
    ret z
    ld c, $04
    ld a, [hl]
    cp $18
    ld c, $05
    ld a, l
    sub $98
    ld l, a
    ld a, h
    sbc $c1
    ld h, a
    ld a, l
    add $00
    ld l, a
    ld a, h
    adc $d0
    ld h, a
    ld a, $02
    ldh [rSVBK], a
    call SceneJustice_SetPosition
    call SceneJustice_SetPosition
    call SceneJustice_SetPosition
    call SceneJustice_SetPosition
    ld a, $00
    ldh [rSVBK], a
    ret

; HL = a tile pair in wScreenTileBuffer: adds 8 to each of the two bytes at HL and HL + 1, taking
; $18 off a result of $28 or more, then HL += $14 (the next row of the 20-wide buffer) and A = the
; byte there. Clobbers A. (C2, E-0384)
; adds 8 to two position bytes, wrapping each below $28, and reads the byte $14 on
SceneJustice_StepWrapPosition::
    ld a, [hl]
    add $08
    cp $28
    jr c, .skip
    sub $18

.skip:
    ld [hli], a
    ld a, [hl]
    add $08
    cp $28
    jr c, .skip2
    sub $18

.skip2:
    ld [hld], a
    ld a, $14
    add_a_to_hl
    ld a, [hl]
    ret

; HL = a pair of bytes, C = the value: stores C at HL and HL + 1, then HL += $14 and A = the byte
; there. Clobbers A. (C2, E-0384)
; stores C to two position bytes and reads the byte $14 on
SceneJustice_SetPosition::
    ld a, c
    ld [hli], a
    ld [hld], a
    ld a, $14
    add_a_to_hl
    ld a, [hl]
    ret

; Script command $67: every call blinks sprite 0 (ScriptStepBlinkObjectTemp0, 120 frames) at Y $20,
; or at Y $50 when hMapId is not $8C and hMapScreenX is 1. When the blink is done it sets
; wSpriteSlotCount to 0, requests the next script command ($80 in wScriptStartRequest) and sets a
; story flag: $C5 on map $8C, otherwise $C6 on screen X 0 or $C7 on any other screen X. (C2, E-0384)
; implements script command type 67 (SCRIPT_SCENE_JUSTICE_2): a cutscene step named after the scene
; its only script shows: 'Let the power of justice smite...'; reached through ScriptCommand67 in
; bank $10 (E-0038, E-0245)
SceneJustice2::
    xor a
    ldh [hTemp0], a
    ld a, $20
    ldh [hTemp1], a
    ldh a, [hMapId]
    cp $8c
    jr z, .call_script_step_blink_object_temp0
    ldh a, [hMapScreenX]
    cp $01
    jr nz, .call_script_step_blink_object_temp0
    ld a, $50
    ldh [hTemp1], a

.call_script_step_blink_object_temp0:
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a
    ret z
    xor a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld de, $00c5
    ldh a, [hMapId]
    cp $8c
    jr z, .call_set_flag_bit
    inc de
    ldh a, [hMapScreenX]
    or a
    jr z, .call_set_flag_bit
    inc de

.call_set_flag_bit:
    call SetFlagBit
    ret

; Script command $52: on step 0 sets the destination of a map change (hMapId $82, screen X 1, screen
; Y 2, wWarpDestX $40, wWarpDestY $80, wFieldTransitionKind 3) and starts the fade
; (ScriptStartFadeAndAdvanceStep, which also advances wScriptStep); on any later step it requests
; the next script command ($80 in wScriptStartRequest). (C1, E-0384)
; implements script command type 52 (SCRIPT_SCENE_SMALL_HOLE): a cutscene step named after the scene
; its only script shows: '0 checked the small hole.' ... 'You can take this treasure, but...';
; reached through ScriptCommand52 in bank $10 (E-0038, E-0245)
SceneSmallHole::
    ld a, [wScriptStep]
    or a
    jr nz, .set_script_start_request_to_80
    ld a, $82
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    ld a, $02
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $80
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

.set_script_start_request_to_80:
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Step runner of script command $51: wScriptStep picks the step. 0 SceneMadcondorCry_Start, 1
; SceneMadcondorCry_FlyRightToY70, 2 SceneMadcondorCry_FlyRight, 3 SceneMadcondorCry_Warp, 4
; SceneMadcondorCry_Msg0433_Kweeeeeh and 5 SceneWizstone_WaitMessage. (C2, E-0384)
; implements script command type 51 (SCRIPT_SCENE_MADCONDOR_CRY): a cutscene step named after the
; scene its only script shows: 'Kweeeeeh!'; reached through ScriptCommand51 in bank $10 (E-0038,
; E-0245)
SceneMadcondorCry::
    ld a, [wScriptStep]
    jumptable
    dw SceneMadcondorCry_Start
    dw SceneMadcondorCry_FlyRightToY70
    dw SceneMadcondorCry_FlyRight
    dw SceneMadcondorCry_Warp
    dw SceneMadcondorCry_Msg0433_Kweeeeeh
    dw SceneWizstone_WaitMessage

; Madcondor cry, step 4: 'Kweeeeeh!' ($0433); next step. (C2, E-0357; probed E-0384)
SceneMadcondorCry_Msg0433_Kweeeeeh::
    ld hl, $0433 ; '*: Kweeeeeh!'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; Madcondor cry, step 3: warps to screen row 0 at ($40, $30) with transition kind 3 and a fade. (C1,
; E-0357)
SceneMadcondorCry_Warp::
    xor a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $30
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; Madcondor cry, step 2: Madcondor (sprite 0) flies right one or two pixels a frame on its arc
; (SceneMadcondorCry_ArcY), carrying the player and the followers 16 pixels below it; once its Y
; reaches $C0 (off the screen) the next step. (C2, E-0357; probed E-0384)
SceneMadcondorCry_FlyRight::
    ld hl, wSpriteSlots + $b
    inc [hl]
    ld a, [wScriptParam0]
    and $01
    jr nz, .call_scene_madcondor_cry_arc_y
    ld hl, wSpriteSlots + $b
    inc [hl]

.call_scene_madcondor_cry_arc_y:
    ld hl, wScriptParam0
    inc [hl]
    call SceneMadcondorCry_ArcY
    add $10
    ldh [hPlayerY], a
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $c], a
    ld a, [wSpriteSlots + $b]
    ldh [hPlayerX], a
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $b], a
    ld a, [wSpriteSlots + $c]
    cp $c0
    ret c
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Madcondor cry, step 1: Madcondor flies right one or two pixels a frame along its arc until its Y
; comes to $70; next step. (C2, E-0357; probed E-0384)
SceneMadcondorCry_FlyRightToY70::
    ld hl, wSpriteSlots + $b
    inc [hl]
    ld a, [wScriptParam0]
    and $01
    jr nz, .call_scene_madcondor_cry_arc_y
    ld hl, wSpriteSlots + $b
    inc [hl]

.call_scene_madcondor_cry_arc_y:
    ld hl, wScriptParam0
    inc [hl]
    call SceneMadcondorCry_ArcY
    cp $70
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Adds the high byte of the arc counter in wMessageIndex/Group, which drops by $18 a frame, to
; sprite 0's Y (down at first, then up once the counter goes below zero); returns A = the new Y.
; (C2, E-0357; probed E-0384)
SceneMadcondorCry_ArcY::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    ld a, l
    sub $18
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    ld a, [wMessageGroup]
    ld h, a
    ld a, [wSpriteSlots + $c]
    add h
    ld [wSpriteSlots + $c], a
    ret

; Madcondor cry, step 0: after 60 frames sprite 0 starts moving and the arc counter is set to $05C0;
; next step. (C2, E-0357; probed E-0384)
SceneMadcondorCry_Start::
    ld b, $3c
    call StepScriptParam0Counter_Bank73
    ret nc
    ld hl, wSpriteSlots + $d
    call SetBit2AtHL_B73
    ld hl, $05c0
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Step runner of script command $50: wScriptStep picks the step. 0 SceneMadcondor_Start, 1
; SceneMadcondor_FlyLeftToX40 and 2 SceneMadcondor_FlyLeft. (C2, E-0384)
; implements script command type 50 (SCRIPT_SCENE_MADCONDOR): a cutscene step named after the scene
; its only script shows: 'Look! A MadCondor! It has something!'; reached through ScriptCommand50 in
; bank $10 (E-0038, E-0245)
SceneMadcondor::
    ld a, [wScriptStep]
    jumptable
    dw SceneMadcondor_Start
    dw SceneMadcondor_FlyLeftToX40
    dw SceneMadcondor_FlyLeft

; Madcondor, step 2: Madcondor flies left on its arc with object 1 hanging 16 pixels below; at X $E0
; (off the screen) asks for the next script command. (C2, E-0357; probed E-0384)
SceneMadcondor_FlyLeft::
    ld hl, wSpriteSlots + $b
    dec [hl]
    ld hl, wScriptParam0
    inc [hl]
    call SceneMadcondor_ArcY
    add $10
    ld [wObject1 + OBJ_Y], a
    ld a, [wSpriteSlots + $b]
    ld [wObject1 + OBJ_X], a
    ld a, [wSpriteSlots + $b]
    cp $e0
    ret nz
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Madcondor, step 1: Madcondor flies left on its arc until X $40; next step. (C2, E-0357; probed
; E-0384)
SceneMadcondor_FlyLeftToX40::
    ld hl, wSpriteSlots + $b
    dec [hl]
    ld hl, wScriptParam0
    inc [hl]
    call SceneMadcondor_ArcY
    ld a, [wSpriteSlots + $b]
    cp $40
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Adds the high byte of the arc counter in wMessageIndex/Group, which drops by $10 a frame, to
; sprite 0's Y; returns A = the new Y. (C2, E-0357; probed E-0384)
SceneMadcondor_ArcY::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    ld a, l
    sub $10
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    ld a, [wMessageGroup]
    ld h, a
    ld a, [wSpriteSlots + $c]
    add h
    ld [wSpriteSlots + $c], a
    ret

; Madcondor, step 0: after 60 frames sprite 0 starts moving and the arc counter is set to $03C0;
; next step. (C2, E-0357; probed E-0384)
SceneMadcondor_Start::
    ld b, $3c
    call StepScriptParam0Counter_Bank73
    ret nc
    ld hl, wSpriteSlots + $d
    call SetBit2AtHL_B73
    ld hl, $03c0
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Script command 4F (SCRIPT_SET_TILES_D2): writes tiles $68 and $69 at offsets $D2 and $D3 of
; wScreenTileBuffer and tiles $6A and $6B at $E6 and $E7 (a 2 x 2 block, the buffer rows being 20
; tiles wide), redraws the screen with DrawFullScreenBufferAtScroll and asks for the next script
; command (wScriptStartRequest = $80). A script (see Script_FineYou) runs it after message $0411 and
; sound $66; why those tiles are drawn there is not known. (C1, E-0384)
; implements script command type 4F (SCRIPT_SET_TILES_D2): writes tiles $68-$6B into a 2 x 2 block
; of wScreenTileBuffer ($D2, $D3, $E6, $E7) and redraws the screen; reached through ScriptCommand4F
; in bank $10 (E-0038, E-0245)
SetTilesD2::
    ld hl, wScreenTileBuffer + $d2
    ld [hl], $68
    inc hl
    ld [hl], $69
    ld hl, wScreenTileBuffer + $e6
    ld [hl], $6a
    inc hl
    ld [hl], $6b
    farcall DrawFullScreenBufferAtScroll
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Creates a monster record of kind 0 in record slot wArg5 with state 2
; (CreateMonsterRecordOfKindTemp1), adds 1 to wPartyCount, stores the state, X and Y of wObject3 as
; the new follower entry in wFollowerRecords (entry party count - 1) and sets that entry of
; wPartyList to wArg5. It then reorders the party (MoveIncapacitatedPartyMembersBack twice), reloads
; the name tiles and the player and follower sprite graphics, requests an object palette upload
; ($7F), lowers wSpriteSlotCount by 1 and asks for the next script command. No call or table entry
; in the ROM reaches it (the disassembler found it after a terminator), so it looks like unused
; code. (C1, E-0384)
; adds record wArg5 to the party: CreateMonsterRecordOfKindTemp1, wPartyCount += 1, writes a
; follower entry (wObject3 + $7, wObject3 + $B, wObject3 + $C) and wPartyList[n] = wArg5, refreshes
; the list and sprites, then requests script $80 (E-0121)
AddRecordArg5AsFollower::
    ld a, $00
    ldh [hTemp1], a
    ld a, [wArg5]
    ldh [hTemp2], a
    ld a, $02
    ldh [hTemp3], a
    farcall CreateMonsterRecordOfKindTemp1
    ld hl, wPartyCount
    inc [hl]
    ld a, [wPartyCount]
    dec a
    ld c, a
    add a
    add a
    add c
    ld hl, wFollowerRecords
    add_a_to_hl
    ld a, [wObject3 + OBJ_STATE]
    ld [hli], a
    ld a, [wObject3 + OBJ_X]
    ld [hli], a
    ld a, [wObject3 + OBJ_Y]
    ld [hl], a
    ld a, [wPartyCount]
    dec a
    ld hl, wPartyList
    add_a_to_hl
    ld a, [wArg5]
    ld [hl], a
    farcall MoveIncapacitatedPartyMembersBack
    farcall MoveIncapacitatedPartyMembersBack
    call LoadRecordListNameTiles
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ld hl, wSpriteSlotCount
    dec [hl]
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Script command 4C, run each frame by ScriptCommand4C: wScriptStep 0 is
; ScriptCommand4C_Run_PlaceObject (places object 5 by the map) and 1 is
; ScriptCommand4C_Run_RaiseObject (shows it and raises it for 90 frames, then asks for the next
; script command). No script_command in src names type 4C, so which scene uses it is not known. (C1,
; E-0384)
; implements script command type 4C; reached through ScriptCommand4C in bank $10 (E-0038)
ScriptCommand4C_Run::
    ld a, [wScriptStep]
    jumptable
    dw ScriptCommand4C_Run_PlaceObject
    dw ScriptCommand4C_Run_RaiseObject

; Command 4C, step 1: shows object 5 and raises it a pixel every four frames for 90 frames; then
; hides it and asks for the next script command. (C2, E-0357; probed E-0384)
ScriptCommand4C_Run_RaiseObject::
    ld a, $80
    ld [wObject5], a
    ld a, [wScriptParam0]
    and $03
    jr nz, .call_step_script_param0_counter_bank73
    ld hl, wObject5 + SCRIPTOBJ_Y
    dec [hl]

.call_step_script_param0_counter_bank73:
    ld b, $5a
    call StepScriptParam0Counter_Bank73
    ret nc
    xor a
    ld [wObject5], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Command 4C, step 0: runs field command $11 and places object 5 by the map's entry in the table
; (the second table once Darck has been defeated): X from the high nibble, Y from the low nibble (x
; 16 - 8); next step. (C1, E-0357)
ScriptCommand4C_Run_PlaceObject::
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld hl, ScriptCommand4C_Run_PlaceObject_Data1
    ld de, EVENT_SCENE_DARCK_DEFEATED
    call TestFlagBit
    jr nc, .read_map_id
    ld hl, ScriptCommand4C_Run_PlaceObject_Data2

.read_map_id:
    ldh a, [hMapId]
    ld c, a

.skip:
    push hl
    ld a, [hl]
    cp c
    jr nz, .restore
    inc hl
    ld a, [hl]
    and $f0
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, [hl]
    and $0f
    swap a
    add $f8
    ld [wObject5 + SCRIPTOBJ_Y], a
    pop hl
    ld hl, wScriptStep
    inc [hl]
    ret

.restore:
    pop hl
    inc hl
    inc hl
    jr .skip

; Six (map id, position) byte pairs, used before EVENT_SCENE_DARCK_DEFEATED is set: maps $06, $12,
; $00, $02, $16 and $1A with positions $31, $44, $63, $24, $53 and $43.
; ScriptCommand4C_Run_PlaceObject searches the list for hMapId (there is no end marker, so the map
; must be listed) and places wObject5 at X = the high nibble times 16 and Y = the low nibble times
; 16 minus 8. (C1, E-0381)
ScriptCommand4C_Run_PlaceObject_Data1::
    db $06, $31, $12, $44, $00, $63, $02, $24, $16, $53, $1a, $43

; The same six (map id, position) pairs as ScriptCommand4C_Run_PlaceObject_Data1, used once
; EVENT_SCENE_DARCK_DEFEATED is set, with two positions changed: map $00 is $53 instead of $63 and
; map $16 is $42 instead of $53. ScriptCommand4C_Run_PlaceObject finds the pair for hMapId and
; places wObject5 at X = the high nibble times 16 and Y = the low nibble times 16 minus 8. (C1,
; E-0381)
ScriptCommand4C_Run_PlaceObject_Data2::
    db $06, $31, $12, $44, $00, $53, $02, $24, $16, $42, $1a, $43

; Script command 47 (SCRIPT_SCENE_SPIRIT_ENVOY_2), run each frame by ScriptCommand47: wScriptStep 0
; is SceneSpiritEnvoy2_Float (sprite 0 floats for 30 frames, faces down and sets a story flag) and 1
; is SceneSpiritEnvoy2_BlinkAway (the sprites blink away). Its only script: see
; Script_SceneSpiritEnvoy2; neighbouring scripts show the messages 'Oh? An envoy from the spirit!'
; and 'You startled me'. (C2, E-0384)
; implements script command type 47 (SCRIPT_SCENE_SPIRIT_ENVOY_2): a cutscene step named after the
; scene its only script shows: 'Oh? An envoy from the spirit!' ... 'You startled me'; reached
; through ScriptCommand47 in bank $10 (E-0038, E-0245)
SceneSpiritEnvoy2::
    ld a, [wScriptStep]
    jumptable
    dw SceneSpiritEnvoy2_Float
    dw SceneSpiritEnvoy2_BlinkAway

; Spirit envoy 2, step 1: sprite 0 sinks a pixel every other frame while the sprites blink away
; (ScriptStepBlinkSpritesThenEnd). (C2, E-0357; probed E-0384)
SceneSpiritEnvoy2_BlinkAway::
    ld a, [wScriptParam0]
    and $01
    jr z, .call_script_step_blink_sprites_then_end
    ld hl, wSpriteSlots + $c
    inc [hl]

.call_script_step_blink_sprites_then_end:
    call ScriptStepBlinkSpritesThenEnd
    ret

; Spirit envoy 2, step 0: sprite 0 floats (bit 1) for 30 frames, then faces down; sets
; EVENT_SCENE_SPIRIT_ENVOY2, or EVENT_SCENE_SPIRIT_ENVOY2_099 when it is already set; next step.
; (C2, E-0357; probed E-0384)
SceneSpiritEnvoy2_Float::
    ld hl, wSpriteSlots + $d
    call SetBit1AtHL_Bank73
    ld b, $1e
    call StepScriptParam0Counter_Bank73
    ret nc
    xor a
    ld [wSpriteSlots + $7], a
    ld hl, wScriptStep
    inc [hl]
    ld de, EVENT_SCENE_SPIRIT_ENVOY2
    call TestFlagBit
    jr c, .call_set_flag_bit
    ld de, EVENT_SCENE_SPIRIT_ENVOY2
    call SetFlagBit
    ret

.call_set_flag_bit:
    ld de, EVENT_SCENE_SPIRIT_ENVOY2_099
    call SetFlagBit
    ret

; Script command 44 (SCRIPT_SCENE_REAL_KING), run each frame by ScriptCommand44: wScriptStep 0 is
; SceneRealKing_Separate (object 2 rises and object 1 sinks a pixel every fourth frame), 1 is
; SceneRealKing_MoveTogether (the reverse, two pixels a frame: object 2 down and object 1 up, until
; object 1 is at Y $48; then object 5 is shown) and 2 is SceneRealKing_Restore (after 120 frames
; objects 2 and 1 are put back at Y $40 and $50 and the next script command is asked for). A script
; (see Script_I_14) runs it just before message $0365 ('the real King, you' ...), so it seems to
; show the two Kings pulling apart and merging; that reading is a guess from the message and the
; movement. (C1, E-0384)
; implements script command type 44 (SCRIPT_SCENE_REAL_KING): a cutscene step named after the scene
; its only script shows: before 'I'm the real King, you fake!'; reached through ScriptCommand44 in
; bank $10 (E-0038, E-0245)
SceneRealKing::
    ld a, [wScriptStep]
    jumptable
    dw SceneRealKing_Separate
    dw SceneRealKing_MoveTogether
    dw SceneRealKing_Restore

; Real king, step 2: after 120 frames puts objects 2 and 1 back at Y $40 and $50, hides object 5,
; shows three sprites, plays sound 0 and asks for the next script command. (C2, E-0357; probed
; E-0384)
SceneRealKing_Restore::
    ld b, $78
    call StepScriptParam0Counter_Bank73
    ret nc
    ld a, $40
    ld [wObject2 + OBJ_Y], a
    ld a, $50
    ld [wObject1 + OBJ_Y], a
    xor a
    ld [wObject5], a
    ld a, $03
    ld [wSpriteSlotCount], a
    ld a, $00
    call QueueSoundEffect
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Real king, step 1: reverses step 0. Each frame object 2 moves down 2 pixels and object 1 up 2
; pixels, so they move toward each other from where step 0 left them (object 2 higher, object 1
; lower); when object 1 reaches Y $48 it hides the sprites (wSpriteSlotCount = 0), shows object 5,
; queues sound $7D and moves on to step 2. (C2, E-0384)
SceneRealKing_MoveTogether::
    ld a, [wObject2 + OBJ_Y]
    inc a
    inc a
    ld [wObject2 + OBJ_Y], a
    ld a, [wObject1 + OBJ_Y]
    dec a
    dec a
    ld [wObject1 + OBJ_Y], a
    cp $48
    ret nz
    xor a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wObject5], a
    ld a, $7d
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; Real king, step 0: every four frames object 2 rises and object 1 sinks a pixel until object 1
; reaches Y $58; then runs field command $0C and places object 5 at ($40, $48); next step. (C1,
; E-0357)
SceneRealKing_Separate::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and $03
    ret nz
    ld hl, wObject2 + OBJ_Y
    dec [hl]
    ld a, [wObject1 + OBJ_Y]
    inc a
    ld [wObject1 + OBJ_Y], a
    cp $58
    ret nz
    ld a, $0c
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $48
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Script command 3F (SCRIPT_BLINK_SPRITES), run each frame by ScriptCommand3F: sets wSpriteSlotCount
; to 1 when bit 2 of wFrameCounterLo is set and to 2 when it is clear, so the second slot (object 1)
; is drawn only in alternate groups of four frames, and moves object 1 down one pixel a frame. When
; its Y reaches $70 it sets wSpriteSlotCount to 2 and asks for the next script command. A script
; (see Script_YouWillNoWords) runs it after message $8318. (C2, E-0384)
; implements script command type 3F (SCRIPT_BLINK_SPRITES): shows the first sprite slot only on
; alternate groups of four frames (wSpriteSlotCount by wFrameCounterLo bit 2); reached through
; ScriptCommand3F in bank $10 (E-0038, E-0245)
BlinkSprites::
    ld a, [wFrameCounterLo]
    bit 2, a
    jr z, .set_sprite_slot_count_to_02
    ld a, $01
    ld [wSpriteSlotCount], a
    jr .check_object1

.set_sprite_slot_count_to_02:
    ld a, $02
    ld [wSpriteSlotCount], a

.check_object1:
    ld a, [wObject1 + OBJ_Y]
    inc a
    ld [wObject1 + OBJ_Y], a
    cp $70
    ret nz
    ld a, $02
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Script command 3E (SCRIPT_SCENE_STRONGEST_MASTER), run each frame by ScriptCommand3E: wScriptStep
; 0 is SceneStrongestMaster_SetUpSprite (map sprite kind $10 and the script sprite in front of the
; player), 1 is SceneStrongestMaster_PlaySound (sound $83), 2 is SceneStrongestMaster_AnimateSprite
; and 3 is SceneStrongestMaster_DrawBlock (draws a 2 x 2 tile block and asks for the next script
; command). A script (see Script_SceneStrongestMaster) runs it and then sets
; EVENT_SCENE_STRONGEST_MASTER. (C1, E-0384)
; implements script command type 3E (SCRIPT_SCENE_STRONGEST_MASTER): a cutscene step named after the
; scene its only script shows: 'The strongest master I've ever...'; reached through ScriptCommand3E
; in bank $10 (E-0038, E-0245)
SceneStrongestMaster::
    ld a, [wScriptStep]
    jumptable
    dw SceneStrongestMaster_SetUpSprite
    dw SceneStrongestMaster_PlaySound
    dw SceneStrongestMaster_AnimateSprite
    dw SceneStrongestMaster_DrawBlock

; Strongest master, step 3: draws tiles $44-$47 (a 2 x 2 block) at the place kept in
; wMessageIndex/Group's high nibbles, redraws the screen, clears the field draw flags and map sprite
; kind and asks for the next script command. (C1, E-0357)
SceneStrongestMaster_DrawBlock::
    ld a, [wMessageGroup]
    swap a
    and $0f
    sla a
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
    and $0f
    add a
    add_a_to_hl
    ld a, l
    add $98
    ld l, a
    ld a, h
    adc $c1
    ld h, a
    push hl
    ld [hl], $44
    inc hl
    ld [hl], $45
    ld a, $13
    add_a_to_hl
    ld [hl], $46
    inc hl
    ld [hl], $47
    pop hl
    farcall DrawFullScreenBufferAtScroll
    xor a
    ldh [hFieldDrawFlags], a
    xor a
    ld [wMapSpriteKind], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Strongest master, step 2: animates the script sprite (ScriptStepAnimateSpriteBySteps). (C1,
; E-0357)
SceneStrongestMaster_AnimateSprite::
    farcall ScriptStepAnimateSpriteBySteps
    ret

; Strongest master, step 1: plays sound $83 and goes on. (C2, E-0357; probed E-0384)
SceneStrongestMaster_PlaySound::
    farcall PlaySound83AndAdvanceScriptStep
    ret

; Strongest master, step 0: map sprite kind $10 and its script sprite
; (SetupScriptSpriteInFrontOfPlayer). (C1, E-0357)
SceneStrongestMaster_SetUpSprite::
    ld a, $10
    ld [wMapSpriteKind], a
    farcall SetupScriptSpriteInFrontOfPlayer
    ret

; Gather followers, step 0: map sprite kind $10, then moves the followers onto the leader
; (ScriptStepMoveFollowersToLeader). (C2, E-0357; probed E-0384)
GatherFollowers_MoveToLeader::
    ld a, $10
    ld [wMapSpriteKind], a
    farcall ScriptStepMoveFollowersToLeader
    ret

; Script command 3D (SCRIPT_REWARD_ITEM_OR_KEY_2), run each frame by ScriptCommand3D: the ArmyAnt in
; the party (MONSTER_ARMYANT) walks to a spot and digs up a reward. wScriptStep picks 0
; RewardItemOrKey2_FindDigger, 1 RewardItemOrKey2_WalkDigger, 2 RewardItemOrKey2_WalkDownToY50, 3
; RewardItemOrKey2_RestoreDigger, 4 RewardItemOrKey2_Wait, 5
; RewardItemOrKey2_ShowHuhThereIsSomething, 7 RewardItemOrKey2_ShowMessage and 9
; RewardItemOrKey2_GiveReward, with SceneChestBattle_WaitMessage at 6 and 8. Scripts that run it
; after message $88C9: see Script_FantasticICanOpen, see Script_FantasticICanOpen_2 and see
; Script_FantasticICanOpen_3; the scripts that follow announce an Ice Key or a TinyMedal. (C1,
; E-0384)
; implements script command type 3D (SCRIPT_REWARD_ITEM_OR_KEY_2): the same rewards as
; SCRIPT_REWARD_ITEM_OR_KEY in another scene: 'Fantastic! I can open my shop' ... 'I like you to
; have this.'; reached through ScriptCommand3D in bank $10 (E-0038, E-0245)
RewardItemOrKey2::
    ld a, [wScriptStep]
    jumptable
    dw RewardItemOrKey2_FindDigger
    dw RewardItemOrKey2_WalkDigger
    dw RewardItemOrKey2_WalkDownToY50
    dw RewardItemOrKey2_RestoreDigger
    dw RewardItemOrKey2_Wait
    dw RewardItemOrKey2_ShowHuhThereIsSomething
    dw SceneChestBattle_WaitMessage
    dw RewardItemOrKey2_ShowMessage
    dw SceneChestBattle_WaitMessage
    dw RewardItemOrKey2_GiveReward

; Dig reward 2, step 9: asks for the next script command and turns object 1 to face the player; with
; EVENT_REWARD_ITEM_OR_KEY set adds a key of kind 4 (asking for a bag sort) and sets
; EVENT_WARUBOU_WA_HEY_FIND_ANOTHER; otherwise a TinyMedal ($2C) when the bag has room. (C2, E-0357;
; probed E-0384)
RewardItemOrKey2_GiveReward::
    ld a, $80
    ld [wScriptStartRequest], a
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and $03
    ld [wObject1 + OBJ_STATE], a
    ld de, EVENT_REWARD_ITEM_OR_KEY
    call TestFlagBit
    jr c, .call_count_keys_or_full
    ld a, [wInventory + $17]
    cp $ff
    jr z, .set_step_ptr_lo_to_2C
    or a
    jr z, .set_step_ptr_lo_to_2C
    ret

.set_step_ptr_lo_to_2C:
    ld a, $2c
    ld [wStepPtrLo], a
    farcall AppendItemStepPtrLoToInventory
    ret

.call_count_keys_or_full:
    farcall CountKeysOrFull
    ld a, $04
    ldh [hTemp1], a
    farcall WriteKeyEntryTemp0
    ld a, [wInventorySortFlags]
    set 7, a
    ld [wInventorySortFlags], a
    ld de, EVENT_WARUBOU_WA_HEY_FIND_ANOTHER
    call SetFlagBit
    ret

; Dig reward 2, step 7: message $0D4B ('What's that? Hey, a Magic...') when EVENT_REWARD_ITEM_OR_KEY
; is set, otherwise $0D3F; object 1 faces down and object 3 up; next step. (C2, E-0357; probed
; E-0384)
RewardItemOrKey2_ShowMessage::
    ld de, EVENT_REWARD_ITEM_OR_KEY
    call TestFlagBit
    jr c, .call_start_message_hl_b73b
    ld hl, $0d3f
    jr .call_start_message_hl_b73b2

.call_start_message_hl_b73b:
    ld hl, $0d4b ; '*: What's that? Hey, a Magic'

.call_start_message_hl_b73b2:
    call StartMessageHL_B73b
    ld a, $00
    ld [wObject1 + OBJ_STATE], a
    ld a, $02
    ld [wObject3 + OBJ_STATE], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Dig reward 2, step 5: object 3 digs (facing 1 and 3 alternating every 16 frames) for 120 frames;
; then 'Huh? There is something here.' ($0D3E); next step. (C2, E-0357; probed E-0384)
RewardItemOrKey2_ShowHuhThereIsSomething::
    ld a, [wScriptParam0]
    swap a
    and $01
    add a
    inc a
    ld [wObject3 + OBJ_STATE], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $78
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld hl, $0d3e ; '*: Huh? There is something here.'
    call StartMessageHL_B73b
    ret

; Dig reward 2, step 4: waits 60 frames; next step. (C2, E-0357; probed E-0384)
RewardItemOrKey2_Wait::
    ld b, $3c
    call StepScriptParam0Counter_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; Dig reward 2, step 3: puts the digger's follower record back as it was, refreshes the party's name
; tiles for species $B9 (LoadListedRecordNameTilesForTemp0) and clears the draw flags; next step.
; (C1, E-0357)
RewardItemOrKey2_RestoreDigger::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    ld a, [wSavedPlayerState]
    ld [hli], a
    ld a, [wSavedPlayerState + $1]
    ld [hli], a
    ld a, [wSavedPlayerState + $2]
    ld [hl], a
    ld hl, $00b9
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall LoadListedRecordNameTilesForTemp0
    xor a
    ldh [hFieldDrawFlags], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Dig reward 2, step 2: the digger whose record wMessageIndex/wMessageGroup points at walks down (Y
; + 1 a frame, facing 0) to Y $50; there it turns to facing 1, object 3 gets Y $50 (wObject3 +
; OBJ_Y) and the next step. (C2, E-0371; probed E-0384)
RewardItemOrKey2_WalkDownToY50::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp $50
    jr z, .next
    inc a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $00
    ret

.next:
    dec hl
    dec hl
    ld [hl], $01
    ld a, $50
    ld [wObject3 + OBJ_Y], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Dig reward 2, step 1: the digger walks down to Y $40 and then left to X $20; next step. (C2,
; E-0357; probed E-0384)
RewardItemOrKey2_WalkDigger::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp $40
    jr z, .next
    inc a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $00
    ret

.next:
    dec hl
    ld a, [hl]
    cp $20
    jr z, .done
    dec a
    ld [hl], a
    dec hl
    ld [hl], $03
    ret

.done:
    ld hl, wScriptStep
    inc [hl]
    ret

; Dig reward 2, step 0: finds the party monster of species $B9 (FindPartyIndexOfSpeciesTemp0), keeps
; the address of its follower record in wMessageIndex/Group and saves the record
; (wSavedPlayerState); next step. (C2, E-0357; probed E-0384)
RewardItemOrKey2_FindDigger::
    ld hl, $00b9
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall FindPartyIndexOfSpeciesTemp0
    ldh a, [hTemp0]
    ld c, a
    sla a
    sla a
    add c
    ld hl, wFollowerRecords
    add_a_to_hl
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    ld a, [hli]
    ld [wSavedPlayerState], a
    ld a, [hli]
    ld [wSavedPlayerState + $1], a
    ld a, [hl]
    ld [wSavedPlayerState + $2], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Script command 3C (SCRIPT_REWARD_ITEM_OR_KEY), run each frame by ScriptCommand3C: the same dig
; scene as RewardItemOrKey2 with the MadGopher in the party (MONSTER_MADGOPHER) and object 1. Step 0
; is RewardItemOrKey_FindDigger, which picks the route by the player facing (step 1, 4, 7 or $0A);
; steps 1 to 12 are walking legs (RewardItemOrKey_WalkTowardX50 at 1 and 7,
; RewardItemOrKey_WalkDownToY40 at 2, RewardItemOrKey_WalkToX60 at 3 and 9,
; RewardItemOrKey_WalkTowardY40 at 4 and 10, RewardItemOrKey_WalkRightToX70 at 5,
; RewardItemOrKey_WalkToY30 at 6 and 12, RewardItemOrKey_WalkUpToY20 at 8,
; RewardItemOrKey_WalkLeftToX50 at 11), then 13 RewardItemOrKey_RestoreDigger, 14
; RewardItemOrKey_Wait, 15 RewardItemOrKey_ShowOKLetMeDig, 17 RewardItemOrKey_ShowMessage and 19
; RewardItemOrKey_GiveReward, with SceneChestBattle_WaitMessage at 16 and 18. Scripts that run it
; after message $88B4: see Script_GreatHeroThanksA, see Script_GreatHeroThanksA_2 and see
; Script_GreatHeroThanksA_3. (C1, E-0384)
; implements script command type 3C (SCRIPT_REWARD_ITEM_OR_KEY): gives an item or a key entry
; (AppendItemStepPtrLoToInventory, WriteKeyEntryTemp0); 'Great, 0! Thanks a lot!' ... 'Here, 0! You
; hold onto it.'; reached through ScriptCommand3C in bank $10 (E-0038, E-0245)
RewardItemOrKey::
    ld a, [wScriptStep]
    jumptable
    dw RewardItemOrKey_FindDigger
    dw RewardItemOrKey_WalkTowardX50
    dw RewardItemOrKey_WalkDownToY40
    dw RewardItemOrKey_WalkToX60
    dw RewardItemOrKey_WalkTowardY40
    dw RewardItemOrKey_WalkRightToX70
    dw RewardItemOrKey_WalkToY30
    dw RewardItemOrKey_WalkTowardX50
    dw RewardItemOrKey_WalkUpToY20
    dw RewardItemOrKey_WalkToX60
    dw RewardItemOrKey_WalkTowardY40
    dw RewardItemOrKey_WalkLeftToX50
    dw RewardItemOrKey_WalkToY30
    dw RewardItemOrKey_RestoreDigger
    dw RewardItemOrKey_Wait
    dw RewardItemOrKey_ShowOKLetMeDig
    dw SceneChestBattle_WaitMessage
    dw RewardItemOrKey_ShowMessage
    dw SceneChestBattle_WaitMessage
    dw RewardItemOrKey_GiveReward

; Dig reward, step 19: asks for the next script command and turns sprite 0 to face the player
; (facing = player facing + 2, mod 4). With EVENT_REWARD_ITEM_OR_KEY_2 clear it adds a TinyMedal
; ($2C) when the last bag slot is empty and does nothing for a full bag; with it set it adds a key
; entry of kind 4 (setting bit 7 of wInventorySortFlags to ask for a sort) and sets
; EVENT_WARUBOU_WA_HEY_FIND_ANOTHER. It works like RewardItemOrKey2_GiveReward, which does the same
; for object 1 with EVENT_REWARD_ITEM_OR_KEY. (C2, E-0384)
RewardItemOrKey_GiveReward::
    ld a, $80
    ld [wScriptStartRequest], a
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and $03
    ld [wSpriteSlots + $7], a
    ld de, EVENT_REWARD_ITEM_OR_KEY_2
    call TestFlagBit
    jr c, .call_count_keys_or_full
    ld a, [wInventory + $17]
    cp $ff
    jr z, .set_step_ptr_lo_to_2C
    or a
    jr z, .set_step_ptr_lo_to_2C
    ret

.set_step_ptr_lo_to_2C:
    ld a, $2c
    ld [wStepPtrLo], a
    farcall AppendItemStepPtrLoToInventory
    ret

.call_count_keys_or_full:
    farcall CountKeysOrFull
    ld a, $04
    ldh [hTemp1], a
    farcall WriteKeyEntryTemp0
    ld a, [wInventorySortFlags]
    set 7, a
    ld [wInventorySortFlags], a
    ld de, EVENT_WARUBOU_WA_HEY_FIND_ANOTHER
    call SetFlagBit
    ret

; Dig reward, step 17: message $0D16 ('What's wrong, MadGopher? Did you...') when
; EVENT_REWARD_ITEM_OR_KEY_2 is set, otherwise $0D46; sprite 0 and object 1 face each other by
; object 1's place; next step. (C2, E-0357; probed E-0384)
RewardItemOrKey_ShowMessage::
    ld de, EVENT_REWARD_ITEM_OR_KEY_2
    call TestFlagBit
    jr c, .call_start_message_hl_b73b
    ld hl, $0d46
    jr .call_start_message_hl_b73b2

.call_start_message_hl_b73b:
    ld hl, $0d16 ; '*: What's wrong, MadGopher? Did you'

.call_start_message_hl_b73b2:
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ld a, [wObject1 + OBJ_X]
    cp $50
    jr nz, .cp_70
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld a, $01
    ld [wObject1 + OBJ_STATE], a
    ret

.cp_70:
    cp $70
    jr nz, .check_object1
    ld a, $01
    ld [wSpriteSlots + $7], a
    ld a, $03
    ld [wObject1 + OBJ_STATE], a
    ret

.check_object1:
    ld a, [wObject1 + OBJ_Y]
    cp $20
    jr nz, .clear_sprite_slots
    ld a, $02
    ld [wSpriteSlots + $7], a
    xor a
    ld [wObject1 + OBJ_STATE], a
    ret

.clear_sprite_slots:
    xor a
    ld [wSpriteSlots + $7], a
    ld a, $02
    ld [wObject1 + OBJ_STATE], a
    ret

; Dig reward, step 15: object 1 digs for 120 frames (facing 1 and 3 alternating every 16 frames);
; then 'OK! Let me dig! One-two,...' ($0D15); next step. (C2, E-0357; probed E-0384)
RewardItemOrKey_ShowOKLetMeDig::
    ld a, [wScriptParam0]
    swap a
    and $01
    add a
    inc a
    ld [wObject1 + OBJ_STATE], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $78
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld hl, $0d15 ; '*: OK! Let me dig! One-two,'
    call StartMessageHL_B73b
    ret

; Dig reward, step 14: waits 60 frames; next step. (C2, E-0357; probed E-0384)
RewardItemOrKey_Wait::
    ld b, $3c
    call StepScriptParam0Counter_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; Dig reward, step 13: puts the digger's follower record back as it was, refreshes the party's name
; tiles for species $5A (LoadListedRecordNameTilesForTemp0), clears the draw flags, has object 1
; face down and shows one more sprite; next step. (C1, E-0357)
RewardItemOrKey_RestoreDigger::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    ld a, [wSavedPlayerState]
    ld [hli], a
    ld a, [wSavedPlayerState + $1]
    ld [hli], a
    ld a, [wSavedPlayerState + $2]
    ld [hl], a
    ld hl, $005a
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall LoadListedRecordNameTilesForTemp0
    xor a
    ldh [hFieldDrawFlags], a
    xor a
    ld [wObject1 + OBJ_STATE], a
    ld hl, wSpriteSlotCount
    inc [hl]
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Dig reward, a walking leg: the digger walks left to X $50; there object 1 takes X $50 and the next
; step. (C2, E-0357; probed E-0384)
RewardItemOrKey_WalkLeftToX50::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    ld a, [hl]
    cp $50
    jr nz, .call_reward_item_or_key_dec_and_face3
    ld a, $50
    ld [wObject1 + OBJ_X], a
    ld hl, wScriptStep
    inc [hl]
    ret

.call_reward_item_or_key_dec_and_face3:
    call RewardItemOrKey_DecAndFace3
    ret

; Dig reward, a walking leg: the digger walks up to Y $20; there object 1 takes Y $20 and the next
; step. (C2, E-0357; probed E-0384)
RewardItemOrKey_WalkUpToY20::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp $20
    jr nz, .call_reward_item_or_key_dec_and_face2
    ld a, $20
    ld [wObject1 + OBJ_Y], a
    ld hl, wScriptStep
    inc [hl]
    ret

.call_reward_item_or_key_dec_and_face2:
    call RewardItemOrKey_DecAndFace2
    ret

; Dig reward, a walking leg: the digger walks to Y $30 (down or up); there object 1 takes Y $30 and
; the scene goes to step $0D. (C2, E-0357; probed E-0384)
RewardItemOrKey_WalkToY30::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp $30
    jr nz, .skip
    ld a, $30
    ld [wObject1 + OBJ_Y], a
    ld a, $0d
    ld [wScriptStep], a
    ret

.skip:
    jr nc, .call_reward_item_or_key_dec_and_face2
    call RewardItemOrKey_IncAndFace0
    ret

.call_reward_item_or_key_dec_and_face2:
    call RewardItemOrKey_DecAndFace2
    ret

; Dig reward, a walking leg: the digger walks right to X $70; there object 1 takes X $70 and the
; next step. (C2, E-0357; probed E-0384)
RewardItemOrKey_WalkRightToX70::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    ld a, [hl]
    cp $70
    jr nz, .call_reward_item_or_key_inc_and_face1
    ld a, $70
    ld [wObject1 + OBJ_X], a
    ld hl, wScriptStep
    inc [hl]
    ret

.call_reward_item_or_key_inc_and_face1:
    call RewardItemOrKey_IncAndFace1
    ret

; Dig reward, a walking leg: the digger walks toward Y $40, stopping at $20 or $40; next step. (C2,
; E-0357; probed E-0384)
RewardItemOrKey_WalkTowardY40::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp $20
    jr nz, .cp_40

.loop:
    ld hl, wScriptStep
    inc [hl]
    ret

.cp_40:
    cp $40
    jr z, .loop
    jr nc, .call_reward_item_or_key_dec_and_face2
    call RewardItemOrKey_IncAndFace0
    ret

.call_reward_item_or_key_dec_and_face2:
    call RewardItemOrKey_DecAndFace2
    ret

; Dig reward, a walking leg: the digger walks to X $60 (right or left); there object 1 takes X $60
; and the scene goes to step $0D. (C2, E-0357; probed E-0384)
RewardItemOrKey_WalkToX60::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    ld a, [hl]
    cp $60
    jr nz, .skip
    ld a, $60
    ld [wObject1 + OBJ_X], a
    ld a, $0d
    ld [wScriptStep], a
    ret

.skip:
    jr nc, .call_reward_item_or_key_dec_and_face3
    call RewardItemOrKey_IncAndFace1
    ret

.call_reward_item_or_key_dec_and_face3:
    call RewardItemOrKey_DecAndFace3
    ret

; Dig reward, a walking leg: the digger walks down to Y $40; there object 1 takes Y $40 and the next
; step. (C2, E-0357; probed E-0384)
RewardItemOrKey_WalkDownToY40::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp $40
    jr nz, .call_reward_item_or_key_inc_and_face0
    ld a, $40
    ld [wObject1 + OBJ_Y], a
    ld hl, wScriptStep
    inc [hl]
    ret

.call_reward_item_or_key_inc_and_face0:
    call RewardItemOrKey_IncAndFace0
    ret

; Dig reward, a walking leg: the digger walks toward X $50, stopping at $50 or $70; next step. (C2,
; E-0357; probed E-0384)
RewardItemOrKey_WalkTowardX50::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    ld a, [hl]
    cp $70
    jr nz, .cp_50

.loop:
    ld hl, wScriptStep
    inc [hl]
    ret

.cp_50:
    cp $50
    jr z, .loop
    jr nc, .call_reward_item_or_key_dec_and_face3
    call RewardItemOrKey_IncAndFace1
    ret

.call_reward_item_or_key_dec_and_face3:
    call RewardItemOrKey_DecAndFace3
    ret

; Dig reward, step 0: finds the party monster of species $5A, keeps the address of its follower
; record and saves the record, hides one sprite, and starts the walk for the player's facing: down
; step 1, right step 4, up step 7, left step $0A. (C2, E-0357; probed E-0384)
RewardItemOrKey_FindDigger::
    ld hl, $005a
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall FindPartyIndexOfSpeciesTemp0
    ldh a, [hTemp0]
    ld c, a
    sla a
    sla a
    add c
    ld hl, wFollowerRecords
    add_a_to_hl
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    ld a, [hli]
    ld [wSavedPlayerState], a
    ld a, [hli]
    ld [wSavedPlayerState + $1], a
    ld a, [hl]
    ld [wSavedPlayerState + $2], a
    ld hl, wSpriteSlotCount
    dec [hl]
    ldh a, [hPlayerFacing]
    or a
    jr nz, .skip
    ld hl, wScriptStep
    inc [hl]
    ret

.skip:
    dec a
    jr nz, .skip2
    ld a, $04
    ld [wScriptStep], a
    ret

.skip2:
    dec a
    jr nz, .set_script_step_to_0A
    ld a, $07
    ld [wScriptStep], a
    ret

.set_script_step_to_0A:
    ld a, $0a
    ld [wScriptStep], a
    ret

; A = the position byte of a follower record (already read from [HL]) and HL = its address, as the
; walking legs of RewardItemOrKey leave them: stores A + 1 at [HL] and sets the byte two before it
; (the record direction) to 0, which is facing down. Called by RewardItemOrKey_WalkToY30,
; RewardItemOrKey_WalkTowardY40 and RewardItemOrKey_WalkDownToY40. (C2, E-0384)
; increments the position byte and sets the facing two bytes back to 0
RewardItemOrKey_IncAndFace0::
    inc a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $00
    ret

; A = the position byte of a follower record (already read from [HL]) and HL = its address: stores A
; - 1 at [HL] and sets the byte two before it (the record direction) to 2, which is facing up.
; Called by RewardItemOrKey_WalkUpToY20, RewardItemOrKey_WalkToY30 and
; RewardItemOrKey_WalkTowardY40. (C2, E-0384)
; decrements the position byte and sets the facing two bytes back to 2
RewardItemOrKey_DecAndFace2::
    dec a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $02
    ret

; A = the X byte of a follower record (already read from [HL]) and HL = its address: stores A - 1 at
; [HL] and sets the byte one before it (the record direction) to 3, which is facing left. Called by
; RewardItemOrKey_WalkLeftToX50, RewardItemOrKey_WalkToX60 and RewardItemOrKey_WalkTowardX50. (C2,
; E-0384)
; decrements the position byte and sets the facing one byte back to 3
RewardItemOrKey_DecAndFace3::
    dec a
    ld [hl], a
    dec hl
    ld [hl], $03
    ret

; A = the X byte of a follower record (already read from [HL]) and HL = its address: stores A + 1 at
; [HL] and sets the byte one before it (the record direction) to 1, which is facing right. Called by
; RewardItemOrKey_WalkRightToX70, RewardItemOrKey_WalkToX60 and RewardItemOrKey_WalkTowardX50. (C2,
; E-0384)
; increments the position byte and sets the facing one byte back to 1
RewardItemOrKey_IncAndFace1::
    inc a
    ld [hl], a
    dec hl
    ld [hl], $01
    ret

; Script command 3A (SCRIPT_SCENE_MASTER_THANKS), run each frame by ScriptCommand3A: the party
; monster of species 2 (MONSTER_SPOTSLIME) is walked along a path chosen from its X and the player
; Y, and then sprite 0 hops. wScriptStep picks 0 SceneMasterThanks_FindMaster, 1
; SceneMasterThanks_PickPathByX, 2 SceneMasterThanks_WalkUpToY50, 3 and 7
; SceneMasterThanks_WalkRightToX60, 4 SceneMasterThanks_WalkUpToY30, 5
; SceneMasterThanks_WalkToX40AndFaceDown, 6 SceneMasterThanks_PickSecondPathByX, 8
; SceneMasterThanks_WalkDownToY50, 9 SceneMasterThanks_WalkToX40, 10 SceneMasterThanks_RestoreMaster
; and 11 SceneMasterThanks_Hop (which asks for the next script command). A script (see
; Script_RReallyWowThank) runs it after message $8265. (C1, E-0384)
; implements script command type 3A (SCRIPT_SCENE_MASTER_THANKS): a cutscene step named after the
; scene its only script shows: 'R Really? Wow! Thank you!' ... 'I became a master because I...';
; reached through ScriptCommand3A in bank $10 (E-0038, E-0245)
SceneMasterThanks::
    ld a, [wScriptStep]
    jumptable
    dw SceneMasterThanks_FindMaster
    dw SceneMasterThanks_PickPathByX
    dw SceneMasterThanks_WalkUpToY50
    dw SceneMasterThanks_WalkRightToX60
    dw SceneMasterThanks_WalkUpToY30
    dw SceneMasterThanks_WalkToX40AndFaceDown
    dw SceneMasterThanks_PickSecondPathByX
    dw SceneMasterThanks_WalkRightToX60
    dw SceneMasterThanks_WalkDownToY50
    dw SceneMasterThanks_WalkToX40
    dw SceneMasterThanks_RestoreMaster
    dw SceneMasterThanks_Hop

; Master thanks, last step: sprite 0 hops by the table for 32 frames, then the next script command
; is asked for. (C2, E-0357; probed E-0384)
SceneMasterThanks_Hop::
    ld de, wSpriteSlots + $c
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $20
    ret nz
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Master thanks: puts the monster's follower record back as it was and refreshes the party's name
; tiles for species 2 (LoadListedRecordNameTilesForTemp0); next step. (C1, E-0357)
SceneMasterThanks_RestoreMaster::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    ld a, [wSavedPlayerState]
    ld [hli], a
    ld a, [wSavedPlayerState + $1]
    ld [hli], a
    ld a, [wSavedPlayerState + $2]
    ld [hl], a
    ld hl, $0002
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall LoadListedRecordNameTilesForTemp0
    xor a
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Master thanks, a walking leg: the monster walks to X $40 (right or left); there it faces up,
; sprite 0 faces up at ($40, $50) and the field is redrawn (draw flags $0E); next step. (C2, E-0357;
; probed E-0384)
SceneMasterThanks_WalkToX40::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    ld a, [hl]
    cp $40
    jr nz, .skip
    dec hl
    ld [hl], $02
    ld a, $02
    ld [wSpriteSlots + $7], a
    ld a, $40
    ld [wSpriteSlots + $b], a
    ld a, $50
    ld [wSpriteSlots + $c], a
    ld a, $0e
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

.skip:
    jr nc, .skip2
    inc a
    ld [hl], a
    dec hl
    ld [hl], $01
    ret

.skip2:
    dec a
    ld [hl], a
    dec hl
    ld [hl], $03
    ret

; Master thanks, a walking leg: the monster walks down to Y $50; next step. (C2, E-0357; probed
; E-0384)
SceneMasterThanks_WalkDownToY50::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp $50
    jr nz, .skip
    ld hl, wScriptStep
    inc [hl]
    ret

.skip:
    inc a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $00
    ret

; Master thanks: at X $40 or $50 goes to step 7, otherwise step 8. (C2, E-0357; probed E-0384)
SceneMasterThanks_PickSecondPathByX::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    ld a, [hl]
    cp $40
    jr z, .set_script_step_to_07
    cp $50
    jr nz, .set_script_step_to_08

.set_script_step_to_07:
    ld a, $07
    ld [wScriptStep], a
    ret

.set_script_step_to_08:
    ld a, $08
    ld [wScriptStep], a
    ret

; Master thanks, a walking leg: the monster walks to X $40; there it faces down, sprite 0 takes X
; $40, the field is redrawn and the scene goes to step $0A. (C2, E-0357; probed E-0384)
SceneMasterThanks_WalkToX40AndFaceDown::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    ld a, [hl]
    cp $40
    jr nz, .skip
    dec hl
    ld [hl], $00
    ld a, $40
    ld [wSpriteSlots + $b], a
    ld a, $0e
    ldh [hFieldDrawFlags], a
    ld a, $0a
    ld [wScriptStep], a
    ret

.skip:
    jr nc, .skip2
    inc a
    ld [hl], a
    dec hl
    ld [hl], $01
    ret

.skip2:
    dec a
    ld [hl], a
    dec hl
    ld [hl], $03
    ret

; Master thanks, a walking leg: the monster walks up to Y $30; next step. (C2, E-0357; probed
; E-0384)
SceneMasterThanks_WalkUpToY30::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp $30
    jr nz, .skip
    ld hl, wScriptStep
    inc [hl]
    ret

.skip:
    dec a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $02
    ret

; Master thanks, a walking leg: the monster walks right to X $60; next step. (C2, E-0357; probed
; E-0384)
SceneMasterThanks_WalkRightToX60::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    ld a, [hl]
    cp $60
    jr nz, .skip
    ld hl, wScriptStep
    inc [hl]
    ret

.skip:
    inc a
    ld [hl], a
    dec hl
    ld [hl], $01
    ret

; Master thanks, a walking leg: the monster walks up to Y $50; next step. (C2, E-0357; probed
; E-0384)
SceneMasterThanks_WalkUpToY50::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp $50
    jr nz, .skip
    ld hl, wScriptStep
    inc [hl]
    ret

.skip:
    dec a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $02
    ret

; Master thanks: by the monster's X, $40 goes to step 2, $50 to step 3, others step 4. (C2, E-0357;
; probed E-0384)
SceneMasterThanks_PickPathByX::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    ld a, [hl]
    cp $40
    jr nz, .cp_50
    ld a, $02
    ld [wScriptStep], a
    ret

.cp_50:
    cp $50
    jr nz, .set_script_step_to_04
    ld a, $03
    ld [wScriptStep], a
    ret

.set_script_step_to_04:
    ld a, $04
    ld [wScriptStep], a
    ret

; Step 0 of SceneMasterThanks: finds the party monster of species 2 (FindPartyIndexOfSpeciesTemp0),
; keeps its follower record address in wMessageIndex/Group and saves the record in
; wSavedPlayerState. With the player at Y $50 it moves on to step 1 and at Y $30 it goes to step 6.
; Otherwise it compares the low byte of the stored record address with $40 (not the record Y, which
; the two inc hl before it point at; apparently a slip); that byte is $EF, $F4 or $F9 for a found
; monster (or $6F when none is), always above $40, so this path always moves on to step 1 and the
; branch to step 6 for a follower standing at ($40, $30) can never run. (C2, E-0384)
SceneMasterThanks_FindMaster::
    ld hl, $0002
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall FindPartyIndexOfSpeciesTemp0
    ldh a, [hTemp0]
    ld c, a
    sla a
    sla a
    add c
    ld hl, wFollowerRecords
    add_a_to_hl
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    ld a, [hli]
    ld [wSavedPlayerState], a
    ld a, [hli]
    ld [wSavedPlayerState + $1], a
    ld a, [hl]
    ld [wSavedPlayerState + $2], a
    ldh a, [hPlayerY]
    cp $50
    jr nz, .check_player_y

.done:
    ld hl, wScriptStep
    inc [hl]
    ret

.check_player_y:
    ldh a, [hPlayerY]
    cp $30
    jr nz, .skip

.loop:
    ld a, $06
    ld [wScriptStep], a
    ret

.skip:
    ld hl, wMessageIndex
    inc hl
    inc hl
    ld a, [wMessageIndex]
    cp $40
    jr z, .read_party_count
    jr c, .loop
    jr .done

.read_party_count:
    ld a, [wPartyCount]
    ld b, a
    ld hl, wFollowerRecords + $1

.loop2:
    push hl
    ld a, [hli]
    cp $40
    jr nz, .restore
    ld a, [hl]
    cp $30
    jr nz, .restore
    pop hl
    jr .loop

.restore:
    pop hl
    dec b
    jr nz, .loop2
    jr .done
    db $c9

; Script command 35 (SCRIPT_SCENE_KAMEHA_ESCAPE), run each frame by ScriptCommand35. wScriptStep
; picks 0 SceneKamehaEscape_PlayMusic (music 2, sound $70, then it runs on into
; SceneKamehaEscape_PlaceSpriteRedrawEdges), 1 SceneKamehaEscape_Wait, 2 SceneKamehaEscape_Shake, 3
; SceneKamehaEscape_AnimateScreen, 4 and 5 SceneKamehaEscape_Wait, 6 SceneKamehaEscape_Warp, 7
; SceneKamehaEscape_Wait, 8 SceneKamehaEscape_PlaceSpriteRedrawEdges, 9 SceneKamehaEscape_Shake, 10
; SceneKamehaEscape_FlickerTwoScreens, 11 and 12 SceneKamehaEscape_Wait, 13
; SceneKamehaEscape_WarpToScreen54, 14 SceneKamehaEscape_Wait, 15
; SceneKamehaEscape_PlaceSpriteRedrawEdges, 16 SceneKamehaEscape_Shake, 17
; SceneKamehaEscape_FlickerScreenVersions, 18 and 19 SceneKamehaEscape_Wait, 20
; SceneKamehaEscape_WarpOut and 21 SceneKamehaEscape_SetScriptStartRequestTo80. A script (see
; Script_SceneKamehaEscape) runs it on its own. (C1, E-0384)
; implements script command type 35 (SCRIPT_SCENE_KAMEHA_ESCAPE): a cutscene step named after the
; scene its only script shows: '0 checked the crate.' ... 'Kameha Wahahahah! Thanks for guiding me';
; reached through ScriptCommand35 in bank $10 (E-0038, E-0245)
SceneKamehaEscape::
    ld a, [wScriptStep]
    jumptable
    dw SceneKamehaEscape_PlayMusic
    dw SceneKamehaEscape_Wait
    dw SceneKamehaEscape_Shake
    dw SceneKamehaEscape_AnimateScreen
    dw SceneKamehaEscape_Wait
    dw SceneKamehaEscape_Wait
    dw SceneKamehaEscape_Warp
    dw SceneKamehaEscape_Wait
    dw SceneKamehaEscape_PlaceSpriteRedrawEdges
    dw SceneKamehaEscape_Shake
    dw SceneKamehaEscape_FlickerTwoScreens
    dw SceneKamehaEscape_Wait
    dw SceneKamehaEscape_Wait
    dw SceneKamehaEscape_WarpToScreen54
    dw SceneKamehaEscape_Wait
    dw SceneKamehaEscape_PlaceSpriteRedrawEdges
    dw SceneKamehaEscape_Shake
    dw SceneKamehaEscape_FlickerScreenVersions
    dw SceneKamehaEscape_Wait
    dw SceneKamehaEscape_Wait
    dw SceneKamehaEscape_WarpOut
    dw SceneKamehaEscape_SetScriptStartRequestTo80

; Kameha escape, last step: asks for the next script command. (C2, E-0357; probed E-0384)
SceneKamehaEscape_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Kameha escape: sets story flag byte $62 bit 1 and warps to map $40, screen (0, 0) at (the player's
; X, $40), transition kind 3, with a fade. (C1, E-0357)
SceneKamehaEscape_WarpOut::
    ld a, [wStoryFlags + $62]
    set 1, a
    ld [wStoryFlags + $62], a
    ld a, $40
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ldh a, [hPlayerX]
    ld [wWarpDestX], a
    ld a, $40
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; Kameha escape: for 20 frames alternates screen (5, 4) of map $30 between its two versions
; (Map30Screens0/2_Y4X5 and their attributes) every frame; then next step. (C1, E-0357)
SceneKamehaEscape_FlickerScreenVersions::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $14
    jr nz, .check_script_param0
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]

.check_script_param0:
    ld a, [wScriptParam0]
    bit 0, a
    jr z, .call_scene_kameha_escape_load_screen_attrs
    ld de, Map30Attrs0_Y4X5
    ld b, $56
    call SceneKamehaEscape_LoadScreenAttrs
    ld de, Map30Screens0_Y4X5
    ld b, $56
    jp SceneKamehaEscape_DrawScreen

.call_scene_kameha_escape_load_screen_attrs:
    ld de, Map30Attrs2_Y4X5
    ld b, $56
    call SceneKamehaEscape_LoadScreenAttrs
    ld de, Map30Screens2_Y4X5
    ld b, $56
    jr SceneKamehaEscape_DrawScreen

; Kameha escape: sets screen (5, 4) and warps there on map $30 (the same warp setup as the step
; after it). (C1, E-0357)
SceneKamehaEscape_WarpToScreen54::
    ld a, $05
    ldh [hMapScreenX], a
    ld a, $04
    ldh [hMapScreenY], a
    jr SceneKamehaEscape_WarpToScreen

; Kameha escape: for 20 frames alternates between screen (6, 5) and screen (0, 0) of map $30 every
; frame; then next step. (C1, E-0357)
SceneKamehaEscape_FlickerTwoScreens::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $14
    jr nz, .check_script_param0
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]

.check_script_param0:
    ld a, [wScriptParam0]
    bit 0, a
    jr z, .call_scene_kameha_escape_load_screen_attrs
    ld de, Map30Attrs0_Y5X6
    ld b, $56
    call SceneKamehaEscape_LoadScreenAttrs
    ld de, Map30Screens0_Y5X6
    ld b, $56
    jr SceneKamehaEscape_DrawScreen

.call_scene_kameha_escape_load_screen_attrs:
    ld de, Map30Attrs0_Y0X0
    ld b, $56
    call SceneKamehaEscape_LoadScreenAttrs
    ld de, Map30Screens0_Y0X0
    ld b, $56

; Decompresses the screen at DE (bank B) into wScreenTileBuffer and redraws the field. (C1, E-0357)
SceneKamehaEscape_DrawScreen::
    ld hl, wScreenTileBuffer
    call DecompressToVRAM
    farcall DrawFullScreenBufferAtScroll
    ret

; On CGB decompresses the attributes at DE (bank B) into wScreenAttrBuffer (WRAM bank 2). (C1,
; E-0357)
SceneKamehaEscape_LoadScreenAttrs::
    ld a, [wIsCGB]
    or a
    ret z
    ld a, $02
    ldh [rSVBK], a
    ld hl, wScreenAttrBuffer
    call DecompressToVRAM
    ld a, $00
    ldh [rSVBK], a
    ret

; Kameha escape, step 6: warps to screen (6, 5) of map $30 at (the player's X, $E0), transition kind
; 3, with a fade. (C1, E-0357)
SceneKamehaEscape_Warp::
    ld a, $06
    ldh [hMapScreenX], a
    ld a, $05
    ldh [hMapScreenY], a

; Warps to map $30 at the screen already set, (the player's X, $E0), transition kind 3, with a fade.
; (C1, E-0357)
SceneKamehaEscape_WarpToScreen::
    ld a, $30
    ldh [hMapId], a
    ldh a, [hPlayerX]
    ld [wWarpDestX], a
    ld a, $e0
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; Kameha escape, step 3: shows nine frames of the screen's animation, one a frame: frame (count mod
; 6) from the table (screen and attributes, bank $58); next step after the ninth. (C1, E-0357)
SceneKamehaEscape_AnimateScreen::
    ld a, [wScriptParam0]
    ld b, a
    ld a, $06
    call DivideBByA
    add a
    add a
    ld hl, SceneKamehaEscape_AnimateScreen_Data
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld b, $58
    push hl
    call SceneKamehaEscape_DrawScreen
    pop hl
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld b, $58
    call SceneKamehaEscape_LoadScreenAttrs
    farcall DrawFullScreenBufferAtScroll
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $09
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Six 4-byte frames: two ROM addresses in bank $58, the screen tile map and its attribute map. The
; frame is the frame counter modulo 6: Map40ScreenMostRocks with Map40AttrsMostRocks,
; Map40ScreenFewRocks with Map40AttrsFewRocks, Map40Screens2_Y0X0 with Map40Attrs2_Y0X0,
; Map40ScreenFewRocks with Map40AttrsFewRocks again, Map40ScreenMostRocks with Map40AttrsMostRocks
; again, and Map40Screens0_Y0X0 with Map40Attrs0_Y0X0. SceneKamehaEscape_AnimateScreen draws one
; frame per call for nine frames with SceneKamehaEscape_DrawScreen and
; SceneKamehaEscape_LoadScreenAttrs. (C1, E-0381)
SceneKamehaEscape_AnimateScreen_Data::
    db $06, $47, $42, $4c, $fb, $47, $cb, $4c, $ee, $48, $3c, $4d, $fb, $47, $cb, $4c
    db $06, $47, $42, $4c, $ff, $45, $b3, $4b

; Kameha escape, step 2: shakes the screen for 180 frames. (C2, E-0357; probed E-0384)
SceneKamehaEscape_Shake::
    ld a, $b4
    ld [wStepPtrLo], a
    farcall ShakeScreenForStepCount
    ret

; Kameha escape, step 1: waits 60 frames; next step. (C2, E-0357; probed E-0384)
SceneKamehaEscape_Wait::
    ld b, $3c
    call StepScriptParam0Counter_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; Kameha escape, step 0: music 2 and sound $70, then the wait. (C1, E-0357)
SceneKamehaEscape_PlayMusic::
    ld a, $02
    call QueueMusic
    ld a, $70
    call QueueSoundEffect

; Kameha escape, steps 8 and 15 (each after a warp and a wait): sets sprite 0's X (wSpriteSlots +
; $B) to $48 and redraws the BG columns just off the screen edges (RedrawColumnsBesideScreen); next
; step. (C1, E-0371)
SceneKamehaEscape_PlaceSpriteRedrawEdges::
    ld a, $48
    ld [wSpriteSlots + $b], a
    farcall RedrawColumnsBesideScreen
    ld hl, wScriptStep
    inc [hl]
    ret

; Script command 34 (SCRIPT_SET_TILES_FLAG_310): writes tiles $58 to $5B into a 2 x 2 block of
; wScreenTileBuffer (offsets $AA, $AB, $BE and $BF), redraws the screen with
; DrawFullScreenBufferAtScroll, sets bit 0 of wStoryFlags + $62 (story flag $310) and asks for the
; next script command. A script (see Script_HeroCheckedTheCrate) runs it after message $0863. (C1,
; E-0384)
; implements script command type 34 (SCRIPT_SET_TILES_FLAG_310): writes tiles $58-$5B into a 2 x 2
; block of wScreenTileBuffer ($AA, $AB, $BE, $BF), redraws the screen and sets story flag $310;
; reached through ScriptCommand34 in bank $10 (E-0038, E-0245)
SetTilesFlag310::
    ld a, $58
    ld [wScreenTileBuffer + $aa], a
    ld a, $59
    ld [wScreenTileBuffer + $ab], a
    ld a, $5a
    ld [wScreenTileBuffer + $be], a
    ld a, $5b
    ld [wScreenTileBuffer + $bf], a
    farcall DrawFullScreenBufferAtScroll
    ld a, [wStoryFlags + $62]
    set 0, a
    ld [wStoryFlags + $62], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Script command 33 (SCRIPT_SCENE_CRATE), run each frame by ScriptCommand33: wScriptStep picks 0
; SceneCrate_Warp (fade to map $30), 1 SceneCrate_LowerCrate, 2 SceneCrate_Scroll, 3
; SceneCrate_LowerCrateToY30, 4 SceneCrate_WalkPlayerDown, 5 SceneCrate_WalkFirstFollower, 6
; SceneCrate_WalkSecondFollower, 7 SceneCrate_WalkThirdFollower and 8 ScriptStepBlinkSpritesThenEnd
; (which ends the command). A script (see Script_HeroCheckedTheTreasure) runs it after message
; $0887. (C1, E-0384)
; implements script command type 33 (SCRIPT_SCENE_CRATE): a cutscene step named after the scene its
; only script shows: '0 checked the treasure chest.' ... '0 checked the crate.'; reached through
; ScriptCommand33 in bank $10 (E-0038, E-0245)
SceneCrate::
    ld a, [wScriptStep]
    jumptable
    dw SceneCrate_Warp
    dw SceneCrate_LowerCrate
    dw SceneCrate_Scroll
    dw SceneCrate_LowerCrateToY30
    dw SceneCrate_WalkPlayerDown
    dw SceneCrate_WalkFirstFollower
    dw SceneCrate_WalkSecondFollower
    dw SceneCrate_WalkThirdFollower
    dw ScriptStepBlinkSpritesThenEnd

; Crate, step 7: the third follower walks down to Y $40; next step. (C2, E-0357; probed E-0384)
SceneCrate_WalkThirdFollower::
    ld a, [wFollowerRecords + $c]
    inc a
    ld [wFollowerRecords + $c], a
    cp $40
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; Crate, step 6: the second follower walks down to Y $40; then the third is placed at ($40, $30)
; facing down; next step. (C2, E-0357; probed E-0384)
SceneCrate_WalkSecondFollower::
    ld a, [wFollowerRecords + $7]
    inc a
    ld [wFollowerRecords + $7], a
    cp $40
    ret nz
    ld a, $40
    ld [wFollowerRecords + $b], a
    ld a, $30
    ld [wFollowerRecords + $c], a
    xor a
    ld [wFollowerRecords + $a], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Crate, step 5: the first follower walks down to Y $40; then the second is placed at ($40, $30)
; facing down; next step. (C2, E-0357; probed E-0384)
SceneCrate_WalkFirstFollower::
    ld a, [wFollowerRecords + $2]
    inc a
    ld [wFollowerRecords + $2], a
    cp $40
    ret nz
    ld a, $40
    ld [wFollowerRecords + $6], a
    ld a, $30
    ld [wFollowerRecords + $7], a
    xor a
    ld [wFollowerRecords + $5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Crate, step 4: the player walks down to Y $40; then the first follower is placed at ($40, $30)
; facing down; next step. (C2, E-0357; probed E-0384)
SceneCrate_WalkPlayerDown::
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp $40
    ret nz
    ld a, $40
    ld [wFollowerRecords + $1], a
    ld a, $30
    ld [wFollowerRecords + $2], a
    xor a
    ld [wFollowerRecords], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Crate, step 3: the crate (sprite 0) moves down a pixel every other frame to Y $30; then the player
; appears at ($40, $30) facing down; next step. (C2, E-0357; probed E-0384)
SceneCrate_LowerCrateToY30::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and $01
    ret nz
    ld a, [wSpriteSlots + $c]
    inc a
    ld [wSpriteSlots + $c], a
    cp $30
    ret nz
    ld a, $40
    ldh [hPlayerX], a
    ld a, $30
    ldh [hPlayerY], a
    xor a
    ldh [hPlayerFacing], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Crate, step 2: lets the field scroll to the next screen (UpdatePlayerMovement and the field
; action); once it is done shows one sprite with its Y at 0; next step. (C1, E-0357)
SceneCrate_Scroll::
    farcall UpdatePlayerMovement
    farcall RunFieldActionRequestActionIfBit7
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    xor a
    ld [wSpriteSlots + $c], a
    ld a, $01
    ld [wSpriteSlotCount], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Crate, step 1: the crate moves down a pixel every other frame to Y $80; then the screen scrolls
; down (field action $80, scroll direction 8, the next screen row, the player frozen and stepping up
; 128); next step. (C1, E-0357)
SceneCrate_LowerCrate::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and $01
    ret nz
    ld a, [wSpriteSlots + $c]
    inc a
    ld [wSpriteSlots + $c], a
    cp $80
    ret nz
    ld a, $80
    ld [wFieldActionRequest], a
    ld a, $08
    ld [wScreenScrollDir], a
    ld hl, hMapScreenY
    inc [hl]
    ldh a, [hPlayerStateFlags]
    or $01
    ldh [hPlayerStateFlags], a
    ld hl, -128
    ld a, l
    ldh [hPlayerStepDYLo], a
    ld a, h
    ldh [hPlayerStepDYHi], a
    farcall UpdatePlayerMovement
    farcall RunFieldActionRequestActionIfBit7
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Crate, step 0: warps to map $30, screen (5, 5) at ($E0, $E0), transition kind 3, with a fade. (C1,
; E-0357)
SceneCrate_Warp::
    ld a, $30
    ldh [hMapId], a
    ld a, $05
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $e0
    ld [wWarpDestX], a
    ld a, $e0
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; Script command 30 (SCRIPT_SCENE_SAILOR_RING), run each frame by ScriptCommand30: wScriptStep 0 is
; SceneSailorRing_Warp (fade to map $36) and 1 is SceneSailorRing_SetScriptStartRequestTo80 (asks
; for the next script command). A script (see Script_SceneSailorRing) runs it on its own. (C1,
; E-0384)
; implements script command type 30 (SCRIPT_SCENE_SAILOR_RING): a cutscene step named after the
; scene its only script shows: after '0 received the Sailor Ring.'; reached through ScriptCommand30
; in bank $10 (E-0038, E-0245)
SceneSailorRing::
    ld a, [wScriptStep]
    jumptable
    dw SceneSailorRing_Warp
    dw SceneSailorRing_SetScriptStartRequestTo80

; Sailor ring, step 0: warps to map $36, screen (0, 0) at ($40, $80), transition kind 3, with a
; fade. (C1, E-0357)
SceneSailorRing_Warp::
    ld a, $36
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $80
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; Sailor ring, step 1: asks for the next script command. (C2, E-0357; probed E-0384)
SceneSailorRing_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Script command 2F (SCRIPT_SCENE_TENTACLES), run each frame by ScriptCommand2F: while wScriptStep
; is 0 it sets hMapId to $3C, the screen to (0, 0), wWarpDestX and wWarpDestY to $50 and $40 and
; wFieldTransitionKind to 4, and starts the fade (ScriptStartFadeAndAdvanceStep, which moves
; wScriptStep on); any later step asks for the next script command. A script (see
; Script_CloseYourEyesFor) runs it after message $888F. (C1, E-0384)
; implements script command type 2F (SCRIPT_SCENE_TENTACLES): a cutscene step named after the scene
; its only script shows: 'Close your eyes for a little...' ... 'Thick, suction-cupped tentacles
; snaked out'; reached through ScriptCommand2F in bank $10 (E-0038, E-0245)
SceneTentacles::
    ld a, [wScriptStep]
    or a
    jr nz, .set_script_start_request_to_80
    ld a, [wScriptStep]
    or a
    jr nz, .set_script_start_request_to_80
    ld a, $3c
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $50
    ld [wWarpDestX], a
    ld a, $40
    ld [wWarpDestY], a
    ld a, $04
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

.set_script_start_request_to_80:
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Script command 2E (SCRIPT_WARP_MAP41), run each frame by ScriptCommand2E: while wScriptStep is 0
; it calls WarpToMap41 (the fade warp to map $41); once the fade has moved wScriptStep on, it asks
; for the next script command. A script (see Script_CloseYourEyesA) runs it after message $884C.
; (C1, E-0384)
; implements script command type 2E (SCRIPT_WARP_MAP41): warps to map $41 (WarpToMap41); used after
; 'Close your eyes a little while.'; reached through ScriptCommand2E in bank $10 (E-0038, E-0245)
WarpMap41::
    ld a, [wScriptStep]
    or a
    jr nz, .set_script_start_request_to_80
    call WarpToMap41
    ret

.set_script_start_request_to_80:
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Script command 2D (SCRIPT_SCENE_MERMAID_SONG_2), run each frame by ScriptCommand2D: wScriptStep
; picks 0 SceneMermaidSong2_WalkPlayer, 1 to 3 SceneMermaidSong2_GatherFollowers, 4
; SceneMermaidSong2_WalkLeft, 5 SceneMermaidSong2_RunMoveSteps, 6
; MermaidSong_WalkRightToX70ThenMessage, 7 SceneMermaidSong2_ShowBravoBravoYouWere, 8
; SceneChestBattle_WaitMessage, 9 WarpToMap41 and 10 SceneMermaidSong2_SetScriptStartRequestTo80. A
; script (see Script_ThenI_3) runs it after message $8811. (C1, E-0384)
; implements script command type 2D (SCRIPT_SCENE_MERMAID_SONG_2): a cutscene step named after the
; scene its only script shows: the same scene as SCRIPT_SCENE_MERMAID_SONG (two objects moved by
; table); reached through ScriptCommand2D in bank $10 (E-0038, E-0245)
SceneMermaidSong2::
    ld a, [wScriptStep]
    jumptable
    dw SceneMermaidSong2_WalkPlayer
    dw SceneMermaidSong2_GatherFollowers
    dw SceneMermaidSong2_GatherFollowers
    dw SceneMermaidSong2_GatherFollowers
    dw SceneMermaidSong2_WalkLeft
    dw SceneMermaidSong2_RunMoveSteps
    dw MermaidSong_WalkRightToX70ThenMessage
    dw SceneMermaidSong2_ShowBravoBravoYouWere
    dw SceneChestBattle_WaitMessage
    dw WarpToMap41
    dw SceneMermaidSong2_SetScriptStartRequestTo80

; Mermaid song 2, step 10: asks for the next script command. (C2, E-0357; probed E-0384)
SceneMermaidSong2_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Sets hMapId to $41, hMapScreenX and hMapScreenY to 0 and 1, wWarpDestX and wWarpDestY to $70 and
; $30 and wFieldTransitionKind to 1, starts the fade (ScriptStartFadeAndAdvanceStep, which moves
; wScriptStep on) and sets story flag EVENT_IN_THE_PAST_MERMAIDS_ARE. Called by WarpMap41 and entry
; 9 of SceneMermaidSong2. (C1, E-0384)
; hMapId = $41, hMapScreenX/Y = 0/1, wWarpDestX/wWarpDestY = $70/$30, wFieldTransitionKind = 1, then
; ScriptStartFadeAndAdvanceStep and sets story flag $6F (E-0118)
WarpToMap41::
    ld a, $41
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ld a, $01
    ldh [hMapScreenY], a
    ld a, $70
    ld [wWarpDestX], a
    ld a, $30
    ld [wWarpDestY], a
    ld a, $01
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ld de, EVENT_IN_THE_PAST_MERMAIDS_ARE
    call SetFlagBit
    ret

; Mermaid song 2, step 7: after the message object 1 faces right and 'Bravo, bravo! You were
; fabulous!...' ($0849); next step. (C1, E-0357)
SceneMermaidSong2_ShowBravoBravoYouWere::
    xor a
    call RunMessageBoxFar_Bank73
    ret nc
    ld a, $01
    ld [wObject1 + OBJ_STATE], a
    ld hl, wScriptStep
    inc [hl]
    ld hl, $0849 ; '*: Bravo, bravo! You were fabulous!'
    call StartMessageHL_B73b
    ret

; Script command 2C (SCRIPT_SCENE_DANCING), run each frame by ScriptCommand2C: wScriptStep picks 0
; SceneMermaidSong2_WalkPlayer, 1 to 3 SceneMermaidSong2_GatherFollowers, 4
; SceneMermaidSong2_WalkLeft, 5 SceneDancing_FreezePlayer, 6 SceneDancing_Dance, 7
; SceneDancing_LuredMermaid and 8 SceneDancing_SetScriptStartRequestTo80. A script (see
; Script_ThenI) runs it after message $8811 and before message $0816. (C2, E-0384)
; implements script command type 2C (SCRIPT_SCENE_DANCING): a cutscene step named after the scene
; its only script shows: 'Then I'll sing! Lalala lala la' ... 'Erm The sense of rhythm just...';
; reached through ScriptCommand2C in bank $10 (E-0038, E-0245)
SceneDancing::
    ld a, [wScriptStep]
    jumptable
    dw SceneMermaidSong2_WalkPlayer
    dw SceneMermaidSong2_GatherFollowers
    dw SceneMermaidSong2_GatherFollowers
    dw SceneMermaidSong2_GatherFollowers
    dw SceneMermaidSong2_WalkLeft
    dw SceneDancing_FreezePlayer
    dw SceneDancing_Dance
    dw SceneDancing_LuredMermaid
    dw SceneDancing_SetScriptStartRequestTo80

; Dancing, step 8: asks for the next script command. (C2, E-0357; probed E-0384)
SceneDancing_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Dancing, step 7: runs MermaidSong_WalkRightToX70ThenMessage (the walk right to X $70 that ends by
; starting message $0886 and moving wScriptStep on) and then, on every call, moves object 1 off the
; screen (X $E0), which overrides the X $30 that walk sets at its end. (C2, E-0384)
SceneDancing_LuredMermaid::
    call MermaidSong_WalkRightToX70ThenMessage
    ld a, $e0
    ld [wObject1 + OBJ_X], a
    ret

; Dancing, step 6: the dance (SceneDancing_DanceSteps). (C2, E-0357; probed E-0384)
SceneDancing_Dance::
    farcall SceneDancing_DanceSteps
    ret

; Dancing, step 5: the player moves and is frozen (bits 2 and 1); next step. (C2, E-0357; probed
; E-0384)
SceneDancing_FreezePlayer::
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B73
    ld hl, hPlayerStateFlags
    call SetBit1AtHL_Bank73
    ld hl, wScriptStep
    inc [hl]
    ret

; Script command 2B (SCRIPT_SCENE_MERMAID_SONG), run each frame by ScriptCommand2B: wScriptStep
; picks 0 SceneMermaidSong2_WalkPlayer, 1 to 3 SceneMermaidSong2_GatherFollowers, 4
; SceneMermaidSong2_WalkLeft, 5 SceneMermaidSong2_RunMoveSteps, 6
; MermaidSong_WalkRightToX70ThenMessage, 7 SceneMermaidSong_ShowBravoBravoYouWere, 8 and 12
; SceneMermaidSong_MoveOff, 9 SceneMermaidSong_ShowObject, 10 ScriptCommand60_Run_RaiseObject and 11
; SceneMermaidSong_ShowHeroReceivedATinyMedal. A script (see Script_ThenI_2) runs it after message
; $8811. (C1, E-0384)
; implements script command type 2B (SCRIPT_SCENE_MERMAID_SONG): a cutscene step named after the
; scene its only script shows: 'Then I'll sing! Lalala lala la' ... 'In the past, mermaids are
; said...'; reached through ScriptCommand2B in bank $10 (E-0038, E-0245)
SceneMermaidSong::
    ld a, [wScriptStep]
    jumptable
    dw SceneMermaidSong2_WalkPlayer
    dw SceneMermaidSong2_GatherFollowers
    dw SceneMermaidSong2_GatherFollowers
    dw SceneMermaidSong2_GatherFollowers
    dw SceneMermaidSong2_WalkLeft
    dw SceneMermaidSong2_RunMoveSteps
    dw MermaidSong_WalkRightToX70ThenMessage
    dw SceneMermaidSong_ShowBravoBravoYouWere
    dw SceneMermaidSong_MoveOff
    dw SceneMermaidSong_ShowObject
    dw ScriptCommand60_Run_RaiseObject
    dw SceneMermaidSong_ShowHeroReceivedATinyMedal
    dw SceneMermaidSong_MoveOff

; Mermaid song, step 8: after the message moves object 1 off the screen and asks for the next script
; command. (C1, E-0357)
SceneMermaidSong_MoveOff::
    xor a
    call RunMessageBoxFar_Bank73
    ret nc
    ld a, $e0
    ld [wObject1 + OBJ_X], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Mermaid song, step 11: object 5 hops right two pixels a frame for 32 frames; then it is hidden, a
; TinyMedal ($2C) goes into the bag, EVENT_SCENE_MERMAID_SONG is set and '<player> received a
; TinyMedal.' ($0813); next step. (C2, E-0357; probed E-0384)
SceneMermaidSong_ShowHeroReceivedATinyMedal::
    ld a, [wObject5 + SCRIPTOBJ_X]
    inc a
    inc a
    ld [wObject5 + SCRIPTOBJ_X], a
    ld de, wObject5 + SCRIPTOBJ_Y
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $20
    ret nz
    xor a
    ld [wObject5], a
    ld a, $2c
    ld [wStepPtrLo], a
    farcall AppendItemStepPtrLoToInventory
    ld de, EVENT_SCENE_MERMAID_SONG
    call SetFlagBit
    ld hl, $0813 ; '0 received a TinyMedal.'
    call StartMessageHL_B73b
    xor a
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Command 60, step 1: object 5 rises along the hop curve; then sound $65 and the next step. (C2,
; E-0357; probed E-0384)
ScriptCommand60_Run_RaiseObject::
    ld hl, wObject5 + SCRIPTOBJ_Y
    dec [hl]
    ld de, wObject5 + SCRIPTOBJ_Y
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    ld a, $65
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; Mermaid song, step 9: after the message runs field command $10, shows object 5 and redraws the
; field (draw flags $0E); next step. (C1, E-0357)
SceneMermaidSong_ShowObject::
    xor a
    call RunMessageBoxFar_Bank73
    ret nc
    ld a, $10
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $80
    ld [wObject5], a
    ld a, $0e
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Mermaid song, step 7: after the message object 1 faces right; with EVENT_SCENE_MERMAID_SONG
; already set message $0815, with a full bag $0814, otherwise $0812 and one more step (the medal).
; (C1, E-0357)
SceneMermaidSong_ShowBravoBravoYouWere::
    xor a
    call RunMessageBoxFar_Bank73
    ret nc
    ld a, $01
    ld [wObject1 + OBJ_STATE], a
    ld hl, wScriptStep
    inc [hl]
    ld de, EVENT_SCENE_MERMAID_SONG
    call TestFlagBit
    jr nc, .check_inventory
    ld hl, $0815 ; '*: Bravo, bravo! You were fabulous!'
    call StartMessageHL_B73b
    ret

.check_inventory:
    ld a, [wInventory + $17]
    cp $ff
    jr z, .call_start_message_hl_b73b
    or a
    jr z, .call_start_message_hl_b73b
    ld hl, $0814 ; '*: Bravo, bravo! You were fabulous!'
    call StartMessageHL_B73b
    ret

.call_start_message_hl_b73b:
    ld hl, $0812 ; '*: Bravo, bravo! You were fabulous!'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; Run once a frame as the dance walk of the mermaid scenes (step 6 of SceneMermaidSong and
; SceneMermaidSong2, and from SceneDancing_LuredMermaid): hPlayerX goes up by 1 facing right (1)
; while the first follower steps left (direction 3), the second down (0) and the third up (2). When
; hPlayerX reaches $70 everyone faces left (3), the moving bit of hPlayerStateFlags is cleared,
; wScriptParam0 is cleared, wObject1 + OBJ_X is set to $30, message $0886 ('dancing lured a mermaid
; to' ...) starts and wScriptStep moves on. Despite the Talk name it is not a talk handler. (C2,
; E-0384)
; starts 1 constant message(s); the first in the code is $0886, whose string begins 'N's dancing
; lured a mermaid to' (the leading N is a name substitution); the surrounding logic is not
; interpreted (E-0097)
MermaidSong_WalkRightToX70ThenMessage::
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B73
    ld a, $03
    ld [wFollowerRecords], a
    xor a
    ld [wFollowerRecords + $5], a
    ld a, $02
    ld [wFollowerRecords + $a], a
    ld a, $01
    ldh [hPlayerFacing], a
    ld hl, wFollowerRecords + $1
    dec [hl]
    ld hl, wFollowerRecords + $7
    inc [hl]
    ld hl, wFollowerRecords + $c
    dec [hl]
    ldh a, [hPlayerX]
    inc a
    ldh [hPlayerX], a
    cp $70
    ret nz
    ld a, $03
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank73
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld a, $30
    ld [wObject1 + OBJ_X], a
    ld hl, $0886 ; 'N's dancing lured a mermaid to'
    call StartMessageHL_B73b
    ret

; Mermaid song 2, step 5: the moves (SceneMermaidSong2_MoveSteps). (C2, E-0357; probed E-0384)
SceneMermaidSong2_RunMoveSteps::
    farcall SceneMermaidSong2_MoveSteps
    ret

; Mermaid song 2, step 4: the player walks left to X $60 with the followers stepping beside; then
; all face down and stand; next step. (C2, E-0357; probed E-0384)
SceneMermaidSong2_WalkLeft::
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B73
    ld a, $01
    ld [wFollowerRecords], a
    ld a, $02
    ld [wFollowerRecords + $5], a
    xor a
    ld [wFollowerRecords + $a], a
    ld a, $03
    ldh [hPlayerFacing], a
    ld hl, wFollowerRecords + $1
    inc [hl]
    ld hl, wFollowerRecords + $7
    dec [hl]
    ld hl, wFollowerRecords + $c
    inc [hl]
    ldh a, [hPlayerX]
    dec a
    ldh [hPlayerX], a
    cp $60
    ret nz
    xor a
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank73
    ld hl, wScriptStep
    inc [hl]
    xor a
    ld [wScriptParam0], a
    ld [wScriptSubStep], a
    ret

; Mermaid song 2, step 1: gathers the followers on the leader. (C2, E-0357; probed E-0384)
SceneMermaidSong2_GatherFollowers::
    farcall ScriptStepMoveFollowersToLeader
    ret

; Mermaid song 2, step 0: the player walks down to Y $40 and then right to X $70, facing down at the
; end; next step. (C2, E-0357; probed E-0384)
SceneMermaidSong2_WalkPlayer::
    ldh a, [hPlayerY]
    cp $40
    jr z, .check_player_x
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardStepPtrLo
    ret

.check_player_x:
    ldh a, [hPlayerX]
    cp $70
    jr z, .done
    ld a, $70
    ld [wStepPtrLo], a
    farcall StepPlayerRightTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    xor a
    ldh [hPlayerFacing], a

.done:
    ld hl, wScriptStep
    inc [hl]
    ret

; A six-entry step table that nothing in the ROM calls: 0
; UnreferencedScriptStepDispatch_73_ShowQuiteStrong (a yes/no message), 1
; SceneChestBattle_WaitMessage, 2 UnreferencedScriptStepDispatch_73_ShowOhButICan (acts on the
; answer), 3 SceneWizstone_WaitMessage, 4 SceneChestBattle_WaitMessage and 5
; UnreferencedScriptStepDispatch_73_MakeMonster (adds a new monster to the party and asks for the
; next script command). (C1, E-0384)
; ld a, [wScriptStep] / rst $00 with a six-entry table, the shape of a script command's
; implementation; no script command stub or other code reaches it (E-0214) (E-0344: the address in
; its name dropped or read as the label there; was UnreferencedScriptStepDispatch_73)
UnreferencedScriptStepDispatch_73:: ; configured code entry (E-0214); C0
    ld a, [wScriptStep]
    jumptable
    dw UnreferencedScriptStepDispatch_73_ShowQuiteStrong
    dw SceneChestBattle_WaitMessage
    dw UnreferencedScriptStepDispatch_73_ShowOhButICan
    dw SceneWizstone_WaitMessage
    dw SceneChestBattle_WaitMessage
    dw UnreferencedScriptStepDispatch_73_MakeMonster

; Unreferenced script steps, step 5: makes a monster record of template 5
; (CreateMonsterRecordOfKindTemp1) in the free record wArg5, adds it to the party as a new follower
; at sprite 0's place and facing, reorders the party, reloads the name tiles, sprites and palettes,
; hides one sprite, sets EVENT_SCENE_WATCH_OUT_078 and asks for the next script command. (C1,
; E-0357)
UnreferencedScriptStepDispatch_73_MakeMonster::
    farcall ClearArg5IfAtOrAboveLimitForFarmLevel
    ld a, $05
    ldh [hTemp1], a
    ld a, [wArg5]
    ldh [hTemp2], a
    ld a, $02
    ldh [hTemp3], a
    farcall CreateMonsterRecordOfKindTemp1
    ld hl, wPartyCount
    inc [hl]
    ld a, [wPartyCount]
    dec a
    ld c, a
    add a
    add a
    add c
    ld hl, wFollowerRecords
    add_a_to_hl
    ld a, [wSpriteSlots + $7]
    ld [hli], a
    ld a, [wSpriteSlots + $b]
    ld [hli], a
    ld a, [wSpriteSlots + $c]
    ld [hl], a
    ld a, [wPartyCount]
    dec a
    ld hl, wPartyList
    add_a_to_hl
    ld a, [wArg5]
    ld [hl], a
    farcall MoveIncapacitatedPartyMembersBack
    farcall MoveIncapacitatedPartyMembersBack
    call LoadRecordListNameTiles
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ld hl, wSpriteSlotCount
    dec [hl]
    ld de, EVENT_SCENE_WATCH_OUT_078
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Unreferenced script steps, step 2: no gives 'Oh, but... I can be...' ($0D12); yes, with a free
; record and room in the party, 'Great! Let's make this work!' ($0D10) and one more step, otherwise
; 'Your party's full... There isn't...' ($0D11). (C2, E-0357; probed E-0384)
UnreferencedScriptStepDispatch_73_ShowOhButICan::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wTextYesNoResult]
    or a
    jr z, .call_clear_arg5_if_at_or_above_limit_for_farm
    ld hl, MSG_ALREADY_OPEN | $0d12 ; '*: Oh, but… I can be'
    call StartMessageHL_B73b
    ret

.call_clear_arg5_if_at_or_above_limit_for_farm:
    farcall ClearArg5IfAtOrAboveLimitForFarmLevel
    ld a, [wArg5]
    cp $ff
    jr z, .call_start_message_hl_b73b
    ld a, [wPartyCount]
    cp $03
    jr z, .call_start_message_hl_b73b
    ld hl, MSG_ALREADY_OPEN | $0d10 ; '*: Great! Let's make this work!'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b73b:
    ld hl, MSG_ALREADY_OPEN | $0d11 ; '*: Your party's full… There isn't'
    call StartMessageHL_B73b
    ret

; Unreferenced script steps, step 0: 'Hm, you are quite strong...' ($0D0F, kept open for a yes/no);
; next step. (C2, E-0357; probed E-0384)
UnreferencedScriptStepDispatch_73_ShowQuiteStrong::
    ld hl, MSG_KEEP_OPEN | $0d0f ; '*: Hm, you are quite strong…'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; Script command 26 (SCRIPT_SCENE_MONSTERS_IN_TOW), run each frame by ScriptCommand26: wScriptStep
; picks 0 SceneMonstersInTow_SavePalettes, 1 TravelerEvents_HealerBattle_FlashScreen (the screen
; flash), 2 SceneMonstersInTow_Warp (fade warp in place) and 3
; SceneMonstersInTow_SetScriptStartRequestTo80. A script (see Script_SceneMonstersInTow) runs it
; after setting EVENT_SCENE_MONSTERS_IN_TOW. (C1, E-0384)
; implements script command type 26 (SCRIPT_SCENE_MONSTERS_IN_TOW): a cutscene step named after the
; scene its only script shows: 'That will help you for certain.' ... 'Heh, you have monsters in
; tow?'; reached through ScriptCommand26 in bank $10 (E-0038, E-0245)
SceneMonstersInTow::
    ld a, [wScriptStep]
    jumptable
    dw SceneMonstersInTow_SavePalettes
    dw TravelerEvents_HealerBattle_FlashScreen
    dw SceneMonstersInTow_Warp
    dw SceneMonstersInTow_SetScriptStartRequestTo80

; Monsters in tow, step 3: asks for the next script command. (C2, E-0357; probed E-0384)
SceneMonstersInTow_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Monsters in tow, step 2: warps in place (the player's position, transition kind facing + 1) with a
; fade. (C1, E-0357)
SceneMonstersInTow_Warp::
    ldh a, [hPlayerX]
    ld [wWarpDestX], a
    ldh a, [hPlayerY]
    ld [wWarpDestY], a
    ldh a, [hPlayerFacing]
    inc a
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; Monsters in tow, step 0: clears the window clipping, saves the palettes for the flash (CGB) and
; plays sound $7A; next step. (C2, E-0357; probed E-0384)
SceneMonstersInTow_SavePalettes::
    xor a
    ldh [hSpriteWindowClipMode], a
    ld a, [wIsCGB]
    or a
    jr z, .call_queue_sound_effect
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes

.call_queue_sound_effect:
    ld a, $7a
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; Script command 1E (SCRIPT_CHECK_ITEM), run each frame by ScriptCommand1E. Looks for item $19
; (ITEM_BEEFJERKY), $1A (ITEM_PORKCHOP), $1B (ITEM_RIB) and $1C (ITEM_SIRLOIN) in the bag in that
; order (FindTemp0InInventoryList, which stops at the first empty slot) and replaces the first one
; found with item $30 (ITEM_WATERCALL), sets bit 6 of wInventorySortFlags and asks for the next
; script command. With none of them it returns at once, so the command runs again next frame. A
; script (see Script_HeroHandedOverSome) runs it after the messages 'handed over some food' and
; 'received a WaterCall'. (C2, E-0384)
; implements script command type 1E (SCRIPT_CHECK_ITEM): looks items up in the inventory
; (FindTemp0InInventoryList) and, after changing a slot, sets bit 6 of wInventorySortFlags (E-0340);
; reached through ScriptCommand1E in bank $10 (E-0038, E-0245)
ReplaceFoodWithWaterCall::
    ld a, $19
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, .read_temp0
    ld a, $1a
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, .read_temp0
    ld a, $1b
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, .read_temp0
    ld a, $1c
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, .read_temp0
    ret

.read_temp0:
    ld hl, wInventory
    ldh a, [hTemp0]
    add_a_to_hl
    ld [hl], $30
    ld a, [wInventorySortFlags]
    set 6, a
    ld [wInventorySortFlags], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Script command 25 (SCRIPT_SCENE_WATER_SOLVED), run each frame by ScriptCommand25: wScriptStep 0 is
; SceneWaterSolved_Warp (sets bit 1 of wStoryFlags + $61 and starts a fade warp in place) and 1 is
; SceneWaterSolved_SetScriptStartRequestTo80 (asks for the next script command). The script that
; uses it sets EVENT_SCENE_WATER_SOLVED right after it. (C1, E-0384)
; implements script command type 25 (SCRIPT_SCENE_WATER_SOLVED): a cutscene step named after the
; scene its only script shows: 'You will? So we can go...' ... 'King This should solve the
; water...'; reached through ScriptCommand25 in bank $10 (E-0038, E-0245)
SceneWaterSolved::
    ld a, [wScriptStep]
    jumptable
    dw SceneWaterSolved_Warp
    dw SceneWaterSolved_SetScriptStartRequestTo80

; Water solved, step 1: asks for the next script command. (C2, E-0357; probed E-0384)
SceneWaterSolved_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Water solved, step 0: sets story flag byte $61 bit 1 and warps in place (transition kind facing +
; 1) with a fade. (C1, E-0357)
SceneWaterSolved_Warp::
    ld a, [wStoryFlags + $61]
    or $02
    ld [wStoryFlags + $61], a
    ldh a, [hPlayerX]
    ld [wWarpDestX], a
    ldh a, [hPlayerY]
    ld [wWarpDestY], a
    ldh a, [hPlayerFacing]
    inc a
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; Script command 21 (SCRIPT_SCENE_KING_AUDIENCE), run each frame by ScriptCommand21: wScriptStep 0
; is SceneKingAudience_Wait (after 90 frames runs field command 5) and 1 is
; SceneKingAudience_HideObject (after 40 frames hides object 5 and asks for the next script
; command). A script (see Script_KingYouWishTo) runs it after message $8D02. (C1, E-0384)
; implements script command type 21 (SCRIPT_SCENE_KING_AUDIENCE): a cutscene step named after the
; scene its only script shows: 'King You wish to see our...' ... 'King I see. This is what...';
; reached through ScriptCommand21 in bank $10 (E-0038, E-0245)
SceneKingAudience::
    ld a, [wScriptStep]
    jumptable
    dw SceneKingAudience_Wait
    dw SceneKingAudience_HideObject

; King audience, step 0: after 90 frames runs field command 5; next step. (C1, E-0357)
SceneKingAudience_Wait::
    ld b, $5a
    call StepScriptParam0Counter_Bank73
    ret nc
    ld a, $05
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; King audience, step 1: after 40 frames hides object 5 and asks for the next script command. (C2,
; E-0357; probed E-0384)
SceneKingAudience_HideObject::
    ld b, $28
    call StepScriptParam0Counter_Bank73
    ret nc
    xor a
    ld [wObject5], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Script command 1A (SCRIPT_SCENE_OASIS_KEY), one call a frame: moves object 5, the sprite shown by
; the earlier script command 19 (like SceneWarubouMagicKey), toward the player: right and down 1
; pixel when hPlayerX is $50, left and down 1 when it is $30, otherwise down 2 unless hPlayerY is
; $20, and always adds the hop table entry for the frame (ScriptApplyStepDeltaAtDE_Bank73). After 16
; calls it hides object 5, puts it at ($40, $30) and asks for the next script command. A script (see
; Script_WarubouWaHeyGood_2) runs it between the messages $0080 and $0081 ('received the Oasis
; Key'). (C2, E-0384)
; implements script command type 1A (SCRIPT_SCENE_OASIS_KEY): a cutscene step named after the scene
; its only script shows: 'This here is a Magic...' ... '0 received the Oasis Key.'; reached through
; ScriptCommand1A in bank $10 (E-0038, E-0245)
SceneOasisKey::
    ldh a, [hPlayerX]
    cp $50
    jr nz, .cp_30
    ld hl, wObject5 + SCRIPTOBJ_X
    inc [hl]
    ld hl, wObject5 + SCRIPTOBJ_Y
    inc [hl]
    jr .call_script_apply_step_delta_at_de_bank73

.cp_30:
    cp $30
    jr nz, .check_player_y
    ld hl, wObject5 + SCRIPTOBJ_X
    dec [hl]
    ld hl, wObject5 + SCRIPTOBJ_Y
    inc [hl]
    jr .call_script_apply_step_delta_at_de_bank73

.check_player_y:
    ldh a, [hPlayerY]
    cp $20
    jr z, .call_script_apply_step_delta_at_de_bank73
    ld a, [wObject5 + SCRIPTOBJ_Y]
    inc a
    inc a
    ld [wObject5 + SCRIPTOBJ_Y], a

.call_script_apply_step_delta_at_de_bank73:
    ld de, wObject5 + SCRIPTOBJ_Y
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    xor a
    ld [wObject5], a
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $30
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Script command 19 (SCRIPT_SCENE_WARUBOU_MAGIC_KEY), one call a frame: at wScriptStep 0 it shows
; object 5 (wObject5 = $80) and moves on; afterwards it moves object 5 up 1 pixel a frame plus the
; hop table entry (ScriptApplyStepDeltaAtDE_Bank73) and after 16 calls asks for the next script
; command. A script (see Script_WarubouWaHeyGood_2) runs it after message $807F and before message
; $0080 ('This here is a Magic'). (C2, E-0384)
; implements script command type 19 (SCRIPT_SCENE_WARUBOU_MAGIC_KEY): a cutscene step named after
; the scene its only script shows: 'Warubou Wa-hey! Good, good, good!' ... 'This here is a
; Magic...'; reached through ScriptCommand19 in bank $10 (E-0038, E-0245)
SceneWarubouMagicKey::
    ld a, [wScriptStep]
    or a
    jr nz, .skip
    ld a, $80
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

.skip:
    ld hl, wObject5 + SCRIPTOBJ_Y
    dec [hl]
    ld de, wObject5 + SCRIPTOBJ_Y
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Script command 20, run each frame by ScriptCommand20: wScriptStep picks 0
; ScriptCommand20_Run_CheckFollower2Spot, 1 ScriptCommand20_Run_WalkFollower2, 2
; ScriptCommand20_Run_WalkFollower2Off and 3 ScriptCommand20_Run_FaceAndSetFlag (which asks for the
; next script command). No script_command in src names type $20, so which scene uses it is not
; known. (C2, E-0384)
; implements script command type 20; reached through ScriptCommand20 in bank $10 (E-0038)
ScriptCommand20_Run::
    ld a, [wScriptStep]
    jumptable
    dw ScriptCommand20_Run_CheckFollower2Spot
    dw ScriptCommand20_Run_WalkFollower2
    dw ScriptCommand20_Run_WalkFollower2Off
    dw ScriptCommand20_Run_FaceAndSetFlag

; Command 20, step 3: after 60 frames plays sound $72, turns sprite 0 to face the player at X $40,
; sets EVENT_SCRIPT_COMMAND20_TURNED and asks for the next script command. (C2, E-0357; probed
; E-0384)
ScriptCommand20_Run_FaceAndSetFlag::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $3c
    ret nz
    ld a, $72
    call QueueSoundEffect
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and $03
    ld [wSpriteSlots + $7], a
    ld a, $40
    ld [wSpriteSlots + $b], a
    ld de, EVENT_SCRIPT_COMMAND20_TURNED
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Command 20, step 2: the second follower walks right to X $B0 (off the screen); next step. (C2,
; E-0357; probed E-0384)
ScriptCommand20_Run_WalkFollower2Off::
    ld a, $01
    ld [wFollowerRecords + $5], a
    ld a, [wFollowerRecords + $6]
    inc a
    ld [wFollowerRecords + $6], a
    cp $b0
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; Command 20, step 1: the second follower walks right to X $50, then to Y $40 (down or up); next
; step. (C2, E-0357; probed E-0384)
ScriptCommand20_Run_WalkFollower2::
    ld a, [wScriptParam0]
    or a
    jr nz, .check_follower_records
    ld a, [wFollowerRecords + $6]
    cp $50
    jr nz, .set_follower_records_to_01
    ld a, $01
    ld [wScriptParam0], a
    ret

.set_follower_records_to_01:
    ld a, $01
    ld [wFollowerRecords + $5], a
    ld hl, wFollowerRecords + $6
    inc [hl]
    ret

.check_follower_records:
    ld a, [wFollowerRecords + $7]
    cp $40
    jr nz, .skip
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

.skip:
    jr nc, .set_follower_records_to_02
    xor a
    ld [wFollowerRecords + $5], a
    ld hl, wFollowerRecords + $7
    inc [hl]
    ret

.set_follower_records_to_02:
    ld a, $02
    ld [wFollowerRecords + $5], a
    ld hl, wFollowerRecords + $7
    dec [hl]
    ret

; Command 20, step 0: notes in wScriptParam0 whether the second follower already stands at ($40,
; $20) (0) or not (1); next step. (C2, E-0357; probed E-0384)
ScriptCommand20_Run_CheckFollower2Spot::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wFollowerRecords + $6]
    cp $40
    jr nz, .set_script_param0_to_01
    ld a, [wFollowerRecords + $7]
    cp $20
    jr nz, .set_script_param0_to_01
    xor a
    ld [wScriptParam0], a
    ret

.set_script_param0_to_01:
    ld a, $01
    ld [wScriptParam0], a
    ret

; Script command 16 (SCRIPT_SCENE_WARUBOU_FOOD_2), run each frame by ScriptCommand16: 29 steps.
; wScriptStep picks 0 and 10 ScriptStepSetObjectBit2AndWait, 1 and 2
; SceneWarubouFood2_ShowWarubouWaheyImStarving, 4 and 5 SceneWarubouFood2_ShowKamehaGimmeItYou, 7
; and 8 SceneWarubouFood2_ShowWarubouWaheySomePrince, 11 SceneWarubouFood2_ShiftObjects, 12
; SceneWarubouFood2_ShowCobiThatsOursGive, 14 SceneWarubouFood2_WalkFollowerUp, 15
; SceneWarubouFood2_HopTogether, 16 SceneWarubouFood2_SinkObject2, 17 SceneWarubouFood2_ShowFloater,
; 19 SceneWarubouFood2_HopObject1, 21 SceneWarubouFood2_WalkObject1, 22
; SceneWarubouFood2_ShowWarubouWaheyItsThe, 23 SceneWarubouFood2_HopSprite, 24
; SceneWarubouFood2_ShowWarubouWaroohWillIt, 26 SceneWarubouFood2_WalkPlayer, 27
; SceneWarubouFood2_SinkObject5 and 28 SceneWarubouFood2_WalkPlayerLeft, with the message waits at
; 3, 6, 9, 13, 18, 20 and 25 (SceneChestBattle_WaitMessage or SceneWarubouFood2_WaitMessage). A
; script (see Script_WarubouCalmDownAnd) runs it before message $005D. (C1, E-0384)
; implements script command type 16 (SCRIPT_SCENE_WARUBOU_FOOD_2): a cutscene step named after the
; scene its only script shows: the same scene as SCRIPT_SCENE_WARUBOU_FOOD; reached through
; ScriptCommand16 in bank $10 (E-0038, E-0245)
SceneWarubouFood2::
    ld a, [wScriptStep]
    jumptable
    dw ScriptStepSetObjectBit2AndWait
    dw SceneWarubouFood2_ShowWarubouWaheyImStarving
    dw SceneWarubouFood2_ShowWarubouWaheyImStarving
    dw SceneChestBattle_WaitMessage
    dw SceneWarubouFood2_ShowKamehaGimmeItYou
    dw SceneWarubouFood2_ShowKamehaGimmeItYou
    dw SceneChestBattle_WaitMessage
    dw SceneWarubouFood2_ShowWarubouWaheySomePrince
    dw SceneWarubouFood2_ShowWarubouWaheySomePrince
    dw SceneChestBattle_WaitMessage
    dw ScriptStepSetObjectBit2AndWait
    dw SceneWarubouFood2_ShiftObjects
    dw SceneWarubouFood2_ShowCobiThatsOursGive
    dw SceneChestBattle_WaitMessage
    dw SceneWarubouFood2_WalkFollowerUp
    dw SceneWarubouFood2_HopTogether
    dw SceneWarubouFood2_SinkObject2
    dw SceneWarubouFood2_ShowFloater
    dw SceneWarubouFood2_WaitMessage
    dw SceneWarubouFood2_HopObject1
    dw SceneWarubouFood2_WaitMessage
    dw SceneWarubouFood2_WalkObject1
    dw SceneWarubouFood2_ShowWarubouWaheyItsThe
    dw SceneWarubouFood2_HopSprite
    dw SceneWarubouFood2_ShowWarubouWaroohWillIt
    dw SceneChestBattle_WaitMessage
    dw SceneWarubouFood2_WalkPlayer
    dw SceneWarubouFood2_SinkObject5
    dw SceneWarubouFood2_WalkPlayerLeft

; Warubou food 2, step 28: after 30 frames the player walks left to X $40; there the player and the
; first follower face up, EVENT_SCENE_WARUBOU_FOOD2_00C is set and the next script command is asked
; for. (C2, E-0357; probed E-0384)
SceneWarubouFood2_WalkPlayerLeft::
    ld a, [wScriptParam0]
    inc a
    cp $1e
    jr z, .set_script_param0
    ld [wScriptParam0], a
    ret

.set_script_param0:
    dec a
    ld [wScriptParam0], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $02
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld de, EVENT_SCENE_WARUBOU_FOOD2_00C
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Warubou food 2, step 27: object 5 sinks away along the hop curve; then it is hidden; next step.
; (C2, E-0357; probed E-0384)
SceneWarubouFood2_SinkObject5::
    ld hl, wObject5 + SCRIPTOBJ_Y
    inc [hl]
    ld de, wObject5 + SCRIPTOBJ_Y
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    xor a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Warubou food 2, step 26: the player walks left to X $68 and faces up; next step. (C2, E-0357;
; probed E-0384)
SceneWarubouFood2_WalkPlayer::
    ld a, $68
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $02
    ldh [hPlayerFacing], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Warubou food 2, step 24: after 180 frames 'Warubou: Warooh! Will it hold? You...' ($005C); next
; step. (C2, E-0357; probed E-0384)
SceneWarubouFood2_ShowWarubouWaroohWillIt::
    ld b, $b4
    call StepScriptParam0Counter_Bank73
    ret nc
    ld hl, $005c ; 'Warubou: Warooh! Will it hold? You'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; Warubou food 2, step 23: once the message is done, sprite 0 hops (sound $65 at the start), turning
; every other frame and moving left two pixels a frame to X $40, for 32 frames; then sound $72,
; sprite $49 loaded into the tiles at $8500 and the next step. (C1, E-0357)
SceneWarubouFood2_HopSprite::
    ld a, [wMessageState]
    cp $ff
    jr z, .check_script_param0
    xor a
    ld [wStepPtrLo], a
    farcall RunMessageBox
    ret

.check_script_param0:
    ld a, [wScriptParam0]
    or a
    jr nz, .set_step_ptr_lo
    ld a, $65
    call QueueSoundEffect

.set_step_ptr_lo:
    ld de, wSpriteSlots + $c
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and $01
    jr nz, .check_sprite_slots
    ld a, [wSpriteSlots + $7]
    inc a
    and $03
    ld [wSpriteSlots + $7], a

.check_sprite_slots:
    ld a, [wSpriteSlots + $b]
    cp $40
    jr z, .check_script_param02
    dec a
    dec a
    ld [wSpriteSlots + $b], a

.check_script_param02:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $20
    jr z, .call_queue_sound_effect
    farcall CycleSpriteFloatYDown
    xor a
    ldh [hTemp0], a
    farcall DrawAnimatedMetaSprite1B
    ret

.call_queue_sound_effect:
    ld a, $72
    call QueueSoundEffect
    ld de, FieldSpriteGfx49
    ld b, $7d
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $49
    ld [wSpriteSlots + $2], a
    xor a
    ld [wSpriteSlots + $7], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Warubou food 2, step 22: the floating sprite, sprite 0 turning every 32 frames; after 120 frames
; 'Warubou: Wa-hey! It's the only way!' ($005B); next step. (C1, E-0357)
SceneWarubouFood2_ShowWarubouWaheyItsThe::
    farcall CycleSpriteFloatYDown
    xor a
    ldh [hTemp0], a
    farcall DrawAnimatedMetaSprite1B
    ld de, wSpriteSlots + $7
    call RotateDirectionAtDEEvery32_Bank73
    ld b, $78
    call StepScriptParam0Counter_Bank73
    ret nc
    ld hl, $005b ; 'Warubou: Wa-hey! It's the only way!'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; Warubou food 2, step 21: the floating sprite and turning sprite 0; object 1 walks right two pixels
; a frame to X $B0; next step. (C1, E-0357)
SceneWarubouFood2_WalkObject1::
    farcall CycleSpriteFloatYDown
    xor a
    ldh [hTemp0], a
    farcall DrawAnimatedMetaSprite1B
    ld de, wSpriteSlots + $7
    call RotateDirectionAtDEEvery32_Bank73
    ld hl, wScriptParam0
    inc [hl]
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $81
    ld [wStepTarget], a
    ld a, $b0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Warubou food 2, step 19: the floating sprite and turning sprite 0; object 1 hops for 32 frames,
; then message $005A. (C1, E-0357)
SceneWarubouFood2_HopObject1::
    farcall CycleSpriteFloatYDown
    xor a
    ldh [hTemp0], a
    farcall DrawAnimatedMetaSprite1B
    ld de, wSpriteSlots + $7
    call RotateDirectionAtDEEvery32_Bank73
    ld de, wObject1 + OBJ_Y
    ld hl, $005a
    call ScriptStepAdjust32TimesThenMessage_Bank73
    ret

; Warubou food 2, step 18: sprite 0 keeps turning while the message runs; next step. (C1, E-0357)
SceneWarubouFood2_WaitMessage::
    ld a, $01
    call RunMessageBoxFar_Bank73
    push af
    ld de, wSpriteSlots + $7
    call RotateDirectionAtDEEvery32_Bank73
    ld hl, wScriptParam0
    inc [hl]
    pop af
    ret nc
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Warubou food 2, step 17: puts the first follower at ($70, $40) facing up, shows the floating
; sprite and object 5; sprite 0 hops for 32 frames, then message $0059. (C1, E-0357)
SceneWarubouFood2_ShowFloater::
    ld a, $02
    ld [wFollowerRecords], a
    ld a, $70
    ld [wFollowerRecords + $1], a
    ld a, $40
    ld [wFollowerRecords + $2], a
    farcall CycleSpriteFloatYDown
    xor a
    ldh [hTemp0], a
    farcall DrawAnimatedMetaSprite1B
    ld a, $80
    ld [wObject5], a
    ld de, wSpriteSlots + $c
    ld hl, $0059
    call ScriptStepAdjust32TimesThenMessage_Bank73
    ret

; Warubou food 2, step 16: object 2 (facing up) sinks away along the hop curve; then
; EVENT_SCENE_WARUBOU_FOOD2 is set and it warps in place (transition kind 4) with a fade. (C1,
; E-0357)
SceneWarubouFood2_SinkObject2::
    ld a, $02
    ld [wObject2 + OBJ_STATE], a
    ld hl, wObject2 + OBJ_Y
    inc [hl]
    ld de, wObject2 + OBJ_Y
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    ld de, EVENT_SCENE_WARUBOU_FOOD2
    call SetFlagBit
    ldh a, [hPlayerX]
    ld [wWarpDestX], a
    ldh a, [hPlayerY]
    ld [wWarpDestY], a
    ld a, $04
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; Warubou food 2, step 15: object 2 moves left while objects 1, 2 and 5 hop together for 32 frames;
; then the sprite tiles are reloaded; next step. (C1, E-0357)
SceneWarubouFood2_HopTogether::
    ld hl, wObject2 + OBJ_X
    dec [hl]
    ld de, wObject1 + OBJ_Y
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld de, wObject2 + OBJ_Y
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld de, wObject5 + SCRIPTOBJ_Y
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and $01
    jr z, .check_script_param0

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $20
    ret nz
    xor a
    ldh [hTemp0], a
    farcall LoadSpriteGraphics7EToTiles0
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Warubou food 2, step 14: the first follower walks up two pixels a frame to Y $38 while the objects
; shift by the table; then objects 1, 2 and 5 take X $80, $60 and $70, sound $63, next step. (C2,
; E-0357; probed E-0384)
SceneWarubouFood2_WalkFollowerUp::
    ld a, [wFollowerRecords + $2]
    dec a
    dec a
    ld [wFollowerRecords + $2], a
    cp $38
    jr z, .set_object1_to_80
    call ShiftObjectsXByTable
    ret

.set_object1_to_80:
    ld a, $80
    ld [wObject1 + OBJ_X], a
    ld a, $60
    ld [wObject2 + OBJ_X], a
    ld a, $70
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $63
    call QueueSoundEffect
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Warubou food 2, step 12: every four frames the first follower walks down, to Y $48; then 'Cobi:
; That's ours! Give it back!' ($0058), or Tara's line ($005E) when EVENT_IN_THE_MIDDLE_OF_THE is
; set; next step. (C2, E-0357; probed E-0384)
SceneWarubouFood2_ShowCobiThatsOursGive::
    ld a, [wFrameCounterLo]
    and $03
    ret nz
    ld a, [wFollowerRecords + $2]
    inc a
    ld [wFollowerRecords + $2], a
    cp $48
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ld de, EVENT_IN_THE_MIDDLE_OF_THE
    call TestFlagBit
    jr c, .call_start_message_hl_b73b
    ld hl, $0058 ; 'Cobi: That's ours! Give it back!'
    call StartMessageHL_B73b
    ret

.call_start_message_hl_b73b:
    ld hl, $005e ; 'Tara: That's ours! Give it back!'
    call StartMessageHL_B73b
    ret

; Warubou food 2, step 11: the objects shift by the table while the first follower walks left to X
; $70; then it faces up; next step. (C2, E-0357; probed E-0384)
SceneWarubouFood2_ShiftObjects::
    call ShiftObjectsXByTable
    ld a, [wFollowerRecords + $1]
    dec a
    ld [wFollowerRecords + $1], a
    cp $70
    ret nz
    ld a, $02
    ld [wFollowerRecords], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Warubou food 2, step 7: object 1 hops; then 'Warubou: Wa-hey! Some prince! Dirty mouth!' ($0055);
; next step. (C2, E-0357; probed E-0384)
SceneWarubouFood2_ShowWarubouWaheySomePrince::
    ld de, wObject1 + OBJ_Y
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    ld hl, $0055 ; 'Warubou: Wa-hey! Some prince! Dirty mouth!'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; Warubou food 2, step 4: object 2 hops; then 'Kameha: Gimme it! You just ate!' ($0054); next step.
; (C2, E-0357; probed E-0384)
SceneWarubouFood2_ShowKamehaGimmeItYou::
    ld de, wObject2 + OBJ_Y
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    ld hl, $0054 ; 'Kameha: Gimme it! You just ate!'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; Warubou food 2, step 1: object 1 hops; then 'Warubou: Wa-hey! I'm starving!' ($0053); next step.
; (C2, E-0357; probed E-0384)
SceneWarubouFood2_ShowWarubouWaheyImStarving::
    ld de, wObject1 + OBJ_Y
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    ld hl, $0053 ; 'Warubou: Wa-hey! I'm starving!'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; Sets bit 2 of the flags of objects 1 and 2 (wObject1 + OBJ_FLAGS, wObject2 + OBJ_FLAGS), shows
; object 5 (wObject5 = $80) and shifts the X of objects 1, 2 and 5 by one entry of
; SceneWarubouFood_StepsX_Data (wScriptParam0 counts up). It moves wScriptStep on only when
; wScriptParam0 wraps from $FF to 0, so after 256 calls. Steps 0 and 10 of SceneWarubouFood2, and
; far-called from a bank $0F scene. (C2, E-0384)
; sets bit 2 of the objects at wObject1 + $D and wObject2 + $D, wObject5 = $80, runs
; ShiftObjectsXByTable and advances wScriptStep once wScriptParam0 is 0 (E-0122)
ScriptStepSetObjectBit2AndWait::
    ld hl, wObject1 + OBJ_FLAGS
    call SetBit2AtHL_B73
    ld hl, wObject2 + OBJ_FLAGS
    call SetBit2AtHL_B73
    ld a, $80
    ld [wObject5], a
    call ShiftObjectsXByTable
    ld a, [wScriptParam0]
    or a
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; Adds one step of SceneWarubouFood_StepsX_Data to the X (not the Y, despite the name) of objects 1
; and 2 and of object 5: the entry is wScriptParam0 AND $3F, negated when bit 6 of wScriptParam0 is
; set, so the objects wobble out and back over 128 calls; then wScriptParam0 goes up by 1. Called by
; ScriptStepSetObjectBit2AndWait, SceneWarubouFood2_ShiftObjects and
; SceneWarubouFood2_WalkFollowerUp. (C2, E-0384)
; adds the signed step $7526[wScriptParam0 & $3F] (negated with bit 6) to wObject1 + $B, wObject2 +
; $B and wObject5 + $4, then wScriptParam0 += 1 (E-0124) (E-0344: the address in its name dropped or
; read as the label there; was ShiftObjectsXByTable)
ShiftObjectsXByTable::
    ld a, [wScriptParam0]
    and $3f
    ld hl, SceneWarubouFood_StepsX_Data
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ld a, [wScriptParam0]
    and $40
    jr z, .read_object1
    ld a, c
    xor $ff
    inc a
    ld c, a

.read_object1:
    ld a, [wObject1 + OBJ_X]
    add c
    ld [wObject1 + OBJ_X], a
    ld a, [wObject2 + OBJ_X]
    add c
    ld [wObject2 + OBJ_X], a
    ld a, [wObject5 + SCRIPTOBJ_X]
    add c
    ld [wObject5 + SCRIPTOBJ_X], a
    ld hl, wScriptParam0
    inc [hl]
    ret

; Script command 15 (SCRIPT_SCENE_WARUBOU_FOOD), run each frame by ScriptCommand15: wScriptStep
; picks 0 SceneWarubouFood_WalkPlayer, then SceneWarubouFood_MoveRight at 1, 4, 5 and 8 and
; SceneWarubouFood_MoveLeft at 2, 3, 6 and 7 (each a 64-frame sideways wobble of the player, object
; 2, the first follower and object 5), 9 SceneWarubouFood_FlyObject5 and 10
; SceneWarubouFood_WalkObjects (which asks for the next script command). A script (see
; Script_WarubouWhaISmell) runs it after message $0051. (C2, E-0384)
; implements script command type 15 (SCRIPT_SCENE_WARUBOU_FOOD): a cutscene step named after the
; scene its only script shows: 'Warubou What is this? Food? Perfect!' ... 'Calm down and listen!';
; reached through ScriptCommand15 in bank $10 (E-0038, E-0245)
SceneWarubouFood::
    ld a, [wScriptStep]
    jumptable
    dw SceneWarubouFood_WalkPlayer
    dw SceneWarubouFood_MoveRight
    dw SceneWarubouFood_MoveLeft
    dw SceneWarubouFood_MoveLeft
    dw SceneWarubouFood_MoveRight
    dw SceneWarubouFood_MoveRight
    dw SceneWarubouFood_MoveLeft
    dw SceneWarubouFood_MoveLeft
    dw SceneWarubouFood_MoveRight
    dw SceneWarubouFood_FlyObject5
    dw SceneWarubouFood_WalkObjects

; Warubou food, step 10: object 1 walks up and object 2 right, two pixels a frame, to $50; object 2
; then goes off the screen (X $E0); in the next pass object 1 walks right to X $50 and goes off the
; screen too, and the next script command is asked for. (C2, E-0357; probed E-0384)
SceneWarubouFood_WalkObjects::
    ld a, [wScriptParam0]
    or a
    jr nz, .set_step_ptr_hi_to_01
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $82
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $81
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $e0
    ld [wObject2 + OBJ_X], a
    ld hl, wScriptParam0
    inc [hl]
    ret

.set_step_ptr_hi_to_01:
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $81
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $e0
    ld [wObject1 + OBJ_X], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Warubou food, step 9: object 5 flies along the table's X positions on the hop curve (sound $65 at
; the start) for 64 frames while the player walks left two pixels a frame to X 0 (then stops) and
; object 2 right; then object 5 is hidden at ($68, $30); next step. (C2, E-0357; probed E-0384)
SceneWarubouFood_FlyObject5::
    ld a, [wScriptParam0]
    or a
    jr nz, .read_script_param0
    ld a, $65
    call QueueSoundEffect

.read_script_param0:
    ld a, [wScriptParam0]
    ld hl, SceneWarubouFood_FlyObject5_Data
    add_a_to_hl
    ld a, [hl]
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, [wScriptParam0]
    push af
    srl a
    ld [wScriptParam0], a
    ld de, wObject5 + SCRIPTOBJ_Y
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    pop af
    ld [wScriptParam0], a
    ldh a, [hPlayerX]
    cp $00
    jr nz, .set_player_x
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank73
    ld hl, wObject2 + OBJ_FLAGS
    call ClearBit2AtHL_Bank73
    jr .check_script_param0

.set_player_x:
    dec a
    dec a
    ldh [hPlayerX], a
    ld a, [wObject2 + OBJ_X]
    inc a
    inc a
    ld [wObject2 + OBJ_X], a

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $40
    ret nz
    xor a
    ld [wObject5], a
    ld a, $68
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $30
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld hl, wScriptStep
    inc [hl]
    xor a
    ld [wScriptParam0], a
    ld [wScriptParam1], a
    ret

; Sixty-four X positions for wObject5 (SCRIPTOBJ_X), one per frame (index wScriptParam0, 0-63),
; rising from $21 to $50 and never decreasing, most frames by one pixel and every third or fourth
; frame by none. SceneWarubouFood_FlyObject5 writes the byte into wObject5 + SCRIPTOBJ_X each frame,
; while AddStepDeltaToPointedByte_Data supplies the Y hop; at frame 64 the object is hidden at ($68,
; $30). (C1, E-0381)
SceneWarubouFood_FlyObject5_Data::
    db $21, $22, $23, $23, $24, $25, $26, $27, $28, $29, $2a, $2a, $2b, $2c, $2d, $2e
    db $2f, $30, $30, $31, $32, $33, $34, $35, $35, $36, $37, $38, $39, $39, $3a, $3b
    db $3c, $3c, $3d, $3e, $3e, $3f, $40, $40, $41, $42, $42, $43, $44, $44, $45, $46
    db $46, $47, $48, $48, $49, $4a, $4a, $4b, $4c, $4c, $4d, $4e, $4e, $4f, $50, $50

; Warubou food, step 2: moves object 2, the player, the first follower and object 5 left by the
; table for 64 frames (SceneWarubouFood_AddToX); next step. (C2, E-0357; probed E-0384)
SceneWarubouFood_MoveLeft::
    ld a, [wScriptParam0]
    ld hl, SceneWarubouFood_StepsX_Data
    add_a_to_hl
    ld a, [hl]
    xor $ff
    inc a
    ld c, a
    jr SceneWarubouFood_AddToX

; Warubou food, step 1: moves them right by the table for 64 frames (SceneWarubouFood_AddToX); next
; step. (C2, E-0357; probed E-0384)
SceneWarubouFood_MoveRight::
    ld a, [wScriptParam0]
    ld hl, SceneWarubouFood_StepsX_Data
    add_a_to_hl
    ld a, [hl]
    ld c, a

; Adds C to the X of object 2, the player, the first follower and object 5; after 64 frames the next
; step. (C2, E-0357; probed E-0384)
SceneWarubouFood_AddToX::
    ld a, [wObject2 + OBJ_X]
    add c
    ld [wObject2 + OBJ_X], a
    ldh a, [hPlayerX]
    add c
    ldh [hPlayerX], a
    ld a, [wFollowerRecords + $1]
    add c
    ld [wFollowerRecords + $1], a
    ld a, [wObject5 + SCRIPTOBJ_X]
    add c
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $40
    ret nz
    ld hl, wScriptStep
    inc [hl]
    xor a
    ld [wScriptParam0], a
    ret

; Sixty-four signed per-frame steps, each -1, 0 or +1 (32 zeros, 16 of each sign), which sum to
; zero. Despite the name the steps are added to the X coordinate: ShiftObjectsXByTable adds entry
; (wScriptParam0 AND $3F), negated when bit 6 is set, to wObject1, wObject2 and wObject5;
; SceneWarubouFood_MoveRight and SceneWarubouFood_MoveLeft add or subtract it for the player,
; wObject2, the first follower and wObject5 over 64 frames. The objects end where they began, so it
; is a back-and-forth wobble rather than a walk. (C1, E-0381)
SceneWarubouFood_StepsX_Data::
    db $01, $00, $01, $00, $01, $01, $00, $ff, $01, $00, $00, $ff, $00, $ff, $ff, $00
    db $01, $00, $00, $00, $01, $01, $ff, $00, $00, $ff, $00, $00, $00, $ff, $01, $00
    db $01, $00, $01, $00, $00, $01, $01, $01, $00, $00, $ff, $00, $00, $00, $ff, $01
    db $ff, $00, $00, $01, $ff, $ff, $ff, $00, $00, $00, $ff, $00, $00, $ff, $ff, $00

; Warubou food, step 0: the player walks right to X $10; then the first follower faces right and the
; player and object 2 keep moving (bit 2); next step. (C2, E-0357; probed E-0384)
SceneWarubouFood_WalkPlayer::
    ld a, $10
    ld [wStepPtrLo], a
    farcall StepPlayerRightTowardStepPtrLo
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $01
    ld [wFollowerRecords], a
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B73
    ld hl, wObject2 + OBJ_FLAGS
    call SetBit2AtHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; Script command 17 (SCRIPT_SCENE_PACKAGE), one call a frame: at wScriptStep 0 it shows object 5 at
; the player position and moves on. Afterwards it moves object 5 one pixel a call toward the middle
; (right when hPlayerX is $30, left when it is $50, otherwise down when hPlayerY is $20 and up when
; not) and adds the hop table entry (ScriptApplyStepDeltaAtDE_Bank73); after 16 calls it hides
; object 5 and asks for the next script command. A script (see Script_DidYouGetThe) runs it between
; messages $006A and $006B. (C2, E-0384)
; implements script command type 17 (SCRIPT_SCENE_PACKAGE): a cutscene step named after the scene
; its only script shows: 'Did you get the package from...' ... 'Oh goodness, you're filthy!';
; reached through ScriptCommand17 in bank $10 (E-0038, E-0245)
ScenePackage::
    ld a, [wScriptStep]
    or a
    jr nz, .check_player_x
    ldh a, [hPlayerX]
    ld [wObject5 + SCRIPTOBJ_X], a
    ldh a, [hPlayerY]
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld a, $80
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

.check_player_x:
    ldh a, [hPlayerX]
    cp $30
    jr nz, .cp_50
    ld hl, wObject5 + SCRIPTOBJ_X
    inc [hl]
    jr .call_script_apply_step_delta_at_de_bank73

.cp_50:
    cp $50
    jr nz, .check_player_y
    ld hl, wObject5 + SCRIPTOBJ_X
    dec [hl]
    jr .call_script_apply_step_delta_at_de_bank73

.check_player_y:
    ldh a, [hPlayerY]
    cp $20
    jr nz, .skip
    ld hl, wObject5 + SCRIPTOBJ_Y
    inc [hl]
    jr .call_script_apply_step_delta_at_de_bank73

.skip:
    ld hl, wObject5 + SCRIPTOBJ_Y
    dec [hl]

.call_script_apply_step_delta_at_de_bank73:
    ld de, wObject5 + SCRIPTOBJ_Y
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    xor a
    ld [wObject5], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Script command 14 (SCRIPT_SCENE_WARUBOU_SMELLS), run each frame by ScriptCommand14: wScriptStep
; picks 0 SceneWarubouSmells_WalkObject2Right, 1 SceneWarubouSmells_WalkObject2, 2
; SceneWarubouSmells_WalkLeft and 3 SceneWarubouSmells_Wait (which asks for the next script
; command). A script (see Script_WarubouWhaISmell) runs it after message $0050. (C2, E-0384)
; implements script command type 14 (SCRIPT_SCENE_WARUBOU_SMELLS): a cutscene step named after the
; scene its only script shows: 'Warubou Wha? I smell something!' ... 'What is this? Food? Perfect!';
; reached through ScriptCommand14 in bank $10 (E-0038, E-0245)
SceneWarubouSmells::
    ld a, [wScriptStep]
    jumptable
    dw SceneWarubouSmells_WalkObject2Right
    dw SceneWarubouSmells_WalkObject2
    dw SceneWarubouSmells_WalkLeft
    dw SceneWarubouSmells_Wait

; Warubou smells, step 3: after 60 frames asks for the next script command. (C2, E-0357; probed
; E-0384)
SceneWarubouSmells_Wait::
    ld b, $3c
    call StepScriptParam0Counter_Bank73
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Warubou smells, step 2: the player and the first follower walk left two pixels a frame to X 0
; while object 5 hops for 32 frames; then object 5 sits at Y $50; next step. (C2, E-0357; probed
; E-0384)
SceneWarubouSmells_WalkLeft::
    ldh a, [hPlayerX]
    cp $00
    jr z, .set_object5_to_80
    dec a
    dec a
    ldh [hPlayerX], a
    ld a, [wFollowerRecords + $1]
    cp $00
    jr z, .set_object5_to_80
    dec a
    dec a
    ld [wFollowerRecords + $1], a

.set_object5_to_80:
    ld a, $80
    ld [wObject5], a
    ld de, wObject5 + SCRIPTOBJ_Y
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $20
    ret nz
    ld a, $50
    ld [wObject5 + SCRIPTOBJ_Y], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Warubou smells, step 1: object 2 walks left two pixels a frame to X $30; then sound $63; next
; step. (C2, E-0357; probed E-0384)
SceneWarubouSmells_WalkObject2::
    ld a, [wObject2 + OBJ_X]
    dec a
    dec a
    ld [wObject2 + OBJ_X], a
    cp $30
    ret nz
    ld a, $63
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; Warubou smells, step 0: object 2 walks right to X $40; next step. (C2, E-0357; probed E-0384)
SceneWarubouSmells_WalkObject2Right::
    ld a, [wObject2 + OBJ_X]
    inc a
    ld [wObject2 + OBJ_X], a
    cp $40
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; Script command 13 (SCRIPT_SCENE_SPINNING), run each frame by ScriptCommand13: wScriptStep picks 0
; SceneSpinning_PlaceObjects, 1 SceneSpinning_WalkObjects, 2 4 6 8 10 and 12 SceneSpinning_Wait, 3
; SceneSpinning_RaiseObject5, 5 and 9 SceneSpinning_HopObject5, 7 and 11
; SceneSpinning_HopObject5Right, 13 SceneSpinning_HopObject0ThenMessage, 14
; SceneChestBattle_WaitMessage, 15 SceneSpinning_WalkOff and 16 SceneSpinning_WalkUpOff (which asks
; for the next script command). A script (see Script_SceneSpinning) plays sound $28 and waits 100
; frames before it. (C1, E-0384)
; implements script command type 13 (SCRIPT_SCENE_SPINNING): a cutscene step named after the scene
; its only script shows: 'Oh It's all spinning around' ... 'You must be the farm kids.'; reached
; through ScriptCommand13 in bank $10 (E-0038, E-0245)
SceneSpinning::
    ld a, [wScriptStep]
    jumptable
    dw SceneSpinning_PlaceObjects
    dw SceneSpinning_WalkObjects
    dw SceneSpinning_Wait
    dw SceneSpinning_RaiseObject5
    dw SceneSpinning_Wait
    dw SceneSpinning_HopObject5
    dw SceneSpinning_Wait
    dw SceneSpinning_HopObject5Right
    dw SceneSpinning_Wait
    dw SceneSpinning_HopObject5
    dw SceneSpinning_Wait
    dw SceneSpinning_HopObject5Right
    dw SceneSpinning_Wait
    dw SceneSpinning_HopObject0ThenMessage
    dw SceneChestBattle_WaitMessage
    dw SceneSpinning_WalkOff
    dw SceneSpinning_WalkUpOff

; Spinning, step 16: objects 1 and 2 walk up two pixels a frame to Y $E0 (off the screen); then the
; next script command. (C2, E-0357; probed E-0384)
SceneSpinning_WalkUpOff::
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $82
    ld [wStepTarget], a
    ld a, $e0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $82
    ld [wStepTarget], a
    ld a, $e0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Spinning, step 15: object 2 walks left to X $40 and then up off the screen while object 1 walks up
; to Y $40 and object 5 sinks away on the hop curve; then object 5 is hidden; next step. (C2,
; E-0357; probed E-0384)
SceneSpinning_WalkOff::
    ld a, [wObject2 + OBJ_X]
    cp $40
    jr z, .set_step_target_to_82
    ld a, $83
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    jr .set_step_ptr_hi_to_02

.set_step_target_to_82:
    ld a, $82
    ld [wStepTarget], a
    ld a, $e0
    ld [wStepPtrLo], a

.set_step_ptr_hi_to_02:
    ld a, $02
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $82
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld hl, wObject5 + SCRIPTOBJ_Y
    inc [hl]
    ld de, wObject5 + SCRIPTOBJ_Y
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    xor a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Spinning, step 13: sprite 0 hops for 32 frames, then message $0039. (C2, E-0357; probed E-0384)
SceneSpinning_HopObject0ThenMessage::
    ld de, wSpriteSlots + $c
    ld hl, $0039
    call ScriptStepAdjust32TimesThenMessage_Bank73
    ret

; Spinning, step 7: object 5 hops right for 32 frames (SceneSpinning_HopObject5OnCurve). (C2,
; E-0357; probed E-0384)
SceneSpinning_HopObject5Right::
    ld hl, wObject5 + SCRIPTOBJ_X
    inc [hl]
    jr SceneSpinning_HopObject5OnCurve

; Spinning, step 5: object 5 hops left for 32 frames (SceneSpinning_HopObject5OnCurve). (C2, E-0357;
; probed E-0384)
SceneSpinning_HopObject5::
    ld hl, wObject5 + SCRIPTOBJ_X
    dec [hl]

; Object 5 hops along the curve; after 32 frames the next step. (C2, E-0357; probed E-0384)
SceneSpinning_HopObject5OnCurve::
    ld de, wObject5 + SCRIPTOBJ_Y
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $20
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Spinning, step 3: object 5 rises left along the hop curve; then object 2 faces left; next step.
; (C2, E-0357; probed E-0384)
SceneSpinning_RaiseObject5::
    ld hl, wObject5 + SCRIPTOBJ_X
    dec [hl]
    ld hl, wObject5 + SCRIPTOBJ_Y
    dec [hl]
    ld de, wObject5 + SCRIPTOBJ_Y
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    ld a, $03
    ld [wObject2 + OBJ_STATE], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Spinning, step 2: waits 30 frames; next step. (C2, E-0357; probed E-0384)
SceneSpinning_Wait::
    ld b, $1e
    call StepScriptParam0Counter_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; Spinning, step 1: object 1 walks right to X $30 and object 2 down to Y $40; then object 2 faces
; right; next step. (C2, E-0357; probed E-0384)
SceneSpinning_WalkObjects::
    ld a, [wObject1 + OBJ_X]
    cp $30
    jr z, .set_step_ptr_hi_to_02
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $01
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord

.set_step_ptr_hi_to_02:
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $00
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $01
    ld [wObject2 + OBJ_STATE], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Spinning, step 0: over 180 frames sets object 2's X to $50 at frame 60 and object 1's X to $20 at
; frame 120; next step. (C2, E-0357; probed E-0384)
SceneSpinning_PlaceObjects::
    ld hl, wScriptParam0
    inc [hl]
    ld a, [wScriptParam0]
    cp $3c
    jr nz, .cp_78
    ld a, $50
    ld [wObject2 + OBJ_X], a
    ret

.cp_78:
    cp $78
    jr nz, .cp_B4
    ld a, $20
    ld [wObject1 + OBJ_X], a
    ret

.cp_B4:
    cp $b4
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Script command 12 (SCRIPT_SCENE_LEARN_QUICK), run each frame by ScriptCommand12: wScriptStep picks
; 0 SceneLearnQuick_StartLegs, 1 SceneLearnQuick_RunSquare, 2 SceneLearnQuick_RunSquareFast, 3
; SceneLearnQuick_RunLeft, 4 SceneLearnQuick_RunOff and 5 SceneLearnQuick_SpinUntilStopped (which
; asks for the next script command). A script (see Script_OhIt) runs it after sound $28 and before
; message $0033 ('all spinning around'). (C2, E-0384)
; implements script command type 12 (SCRIPT_SCENE_LEARN_QUICK): a cutscene step named after the
; scene its only script shows: 'Wow, you kids sure learn quick!' ... 'Oh It's all spinning around';
; reached through ScriptCommand12 in bank $10 (E-0038, E-0245)
SceneLearnQuick::
    ld a, [wScriptStep]
    jumptable
    dw SceneLearnQuick_StartLegs
    dw SceneLearnQuick_RunSquare
    dw SceneLearnQuick_RunSquareFast
    dw SceneLearnQuick_RunLeft
    dw SceneLearnQuick_RunOff
    dw SceneLearnQuick_SpinUntilStopped

; Learn quick, step 5: sprite 0 spins on, slowing down (SceneLearnQuick_SpinSprite); when it has
; stopped (wScriptParam1 = 0) asks for the next script command. (C2, E-0357; probed E-0384)
SceneLearnQuick_SpinUntilStopped::
    call SceneLearnQuick_SpinSprite
    ld a, [wScriptParam1]
    or a
    ret nz
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Learn quick, step 4: while sprite 0 spins, object 1 runs up to Y $30 and then left off the screen,
; object 2 left to X $20 and then up to Y $30 and left off the screen (two pixels a frame); then the
; next step. (C2, E-0357; probed E-0384)
SceneLearnQuick_RunOff::
    call SceneLearnQuick_SpinSprite
    ld a, [wObject1 + OBJ_Y]
    cp $30
    jr z, .set_step_target_to_83
    ld a, $82
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a
    jr .set_step_ptr_hi_to_01

.set_step_target_to_83:
    ld a, $83
    ld [wStepTarget], a
    ld a, $e0
    ld [wStepPtrLo], a

.set_step_ptr_hi_to_01:
    ld a, $01
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, [wMessageIndex]
    or a
    jr nz, .check_object2
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $83
    ld [wStepTarget], a
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld a, $01
    ld [wMessageIndex], a
    ret

.check_object2:
    ld a, [wObject2 + OBJ_Y]
    cp $30
    jr z, .set_step_ptr_hi_to_02
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $82
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ret

.set_step_ptr_hi_to_02:
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $83
    ld [wStepTarget], a
    ld a, $e0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Learn quick, step 3: while sprite 0 spins, objects 1 and 2 run left to X $20; next step. (C2,
; E-0357; probed E-0384)
SceneLearnQuick_RunLeft::
    call SceneLearnQuick_SpinSprite
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $83
    ld [wStepTarget], a
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $83
    ld [wStepTarget], a
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; Learn quick, step 2: objects 1 and 2 keep running round the square (SceneLearnQuick_RunSquareStep)
; and sprite 0 faces by object 2's leg, for 160 frames; then the spin starts (speed $40); next step.
; (C2, E-0357; probed E-0384)
SceneLearnQuick_RunSquareFast::
    call SceneLearnQuick_RunSquareStep
    call SceneLearnQuick_FaceSprite0ByLeg
    ld b, $a0
    call StepScriptParam0Counter_Bank73
    ret nc
    ld a, $40
    ld [wScriptParam1], a
    xor a
    ld [wMessageIndex], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Learn quick, step 1: the same run round the square for 128 frames; then both runners go fast (leg
; bit 7 in wMessageIndex/Group); next step. (C2, E-0357; probed E-0384)
SceneLearnQuick_RunSquare::
    call SceneLearnQuick_RunSquareStep
    call SceneLearnQuick_FaceSprite0ByLeg
    ld b, $80
    call StepScriptParam0Counter_Bank73
    ret nc
    ld a, $81
    ld [wMessageIndex], a
    ld a, $80
    ld [wMessageGroup], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Learn quick, step 0: object 1 starts on leg 1 and object 2 on leg 0 (wMessageIndex/Group reused);
; next step. (C2, E-0357; probed E-0384)
SceneLearnQuick_StartLegs::
    ld a, $01
    ld [wMessageIndex], a
    xor a
    ld [wMessageGroup], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Runs objects 1 and 2 round the square between $30 and $50 (right to X $50, down to Y $50, left to
; X $30, up to Y $30), each on its own leg (wMessageIndex for object 1, wMessageGroup for object 2;
; bit 7 means two pixels a frame), moving to the next leg on arrival. (C2, E-0357; probed E-0384)
SceneLearnQuick_RunSquareStep::
    ld b, $00
    ld a, [wMessageIndex]
    bit 7, a
    jr z, .skip
    ld b, $80

.skip:
    and $03
    jr nz, .skip2
    ld a, b
    or $01
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    jr .set_step_ptr_hi_to_01

.skip2:
    dec a
    jr nz, .skip3
    ld a, b
    or $00
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    jr .set_step_ptr_hi_to_01

.skip3:
    dec a
    jr nz, .set_step_target
    ld a, b
    or $03
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a
    jr .set_step_ptr_hi_to_01

.set_step_target:
    ld a, b
    or $02
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a

.set_step_ptr_hi_to_01:
    ld a, $01
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    jr z, .check_message_group
    ld a, [wMessageIndex]
    inc a
    and $83
    ld [wMessageIndex], a

.check_message_group:
    ld b, $00
    ld a, [wMessageGroup]
    bit 7, a
    jr z, .skip4
    ld b, $80

.skip4:
    and $03
    jr nz, .skip5
    ld a, b
    or $01
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    jr .set_step_ptr_hi_to_02

.skip5:
    dec a
    jr nz, .skip6
    ld a, b
    or $00
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    jr .set_step_ptr_hi_to_02

.skip6:
    dec a
    jr nz, .set_step_target2
    ld a, b
    or $03
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a
    jr .set_step_ptr_hi_to_02

.set_step_target2:
    ld a, b
    or $02
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a

.set_step_ptr_hi_to_02:
    ld a, $02
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a
    jr z, .return
    ld a, [wMessageGroup]
    inc a
    and $83
    ld [wMessageGroup], a

.return:
    ret

; Sprite 0 faces by object 2's leg (wMessageGroup & 3, from the table). (C2, E-0357; probed E-0384)
SceneLearnQuick_FaceSprite0ByLeg::
    ld a, [wMessageGroup]
    and $03
    ld hl, SceneLearnQuick_FaceSprite0ByLeg_Data
    add_a_to_hl
    ld a, [hl]
    ld [wSpriteSlots + $7], a
    ret

; Four facing bytes indexed by wMessageGroup AND 3 (the leg of object 2): 1, 0, 3, 2.
; SceneLearnQuick_FaceSprite0ByLeg stores the byte in wSpriteSlots + 7 as the facing of sprite 0.
; With the facing values seen in the Homecoming and Gravestone scenes (3 left, 2 up, 0 down, 1
; right) the four legs make sprite 0 face right, down, left and up in turn. (C1, E-0381)
SceneLearnQuick_FaceSprite0ByLeg_Data::
    db $01, $00, $03, $02

; Spins sprite 0. On every frame where bit 3 of wFrameCounterLo is clear (8 frames of each 16) the
; speed in wScriptParam1 drops by 1. Every call the angle in wScriptParam0 grows by the high nibble
; of the speed (speed / 16), and sprite 0 faces 3 minus bits 4 and 5 of the angle, so it turns
; through 3, 2, 1 and 0. (C2, E-0384)
SceneLearnQuick_SpinSprite::
    ld a, [wFrameCounterLo]
    and $08
    jr nz, .read_script_param1
    ld hl, wScriptParam1
    dec [hl]

.read_script_param1:
    ld a, [wScriptParam1]
    swap a
    and $0f
    ld c, a
    ld a, [wScriptParam0]
    add c
    ld [wScriptParam0], a
    swap a
    and $03
    ld c, a
    ld a, $03
    sub c
    ld [wSpriteSlots + $7], a
    ret

; Runs one frame of script command type 11 (SCRIPT_SCENE_FARM_KIDS) by wScriptStep: step 0 is
; SceneFarmKids_ShowObject, step 1 is SceneFarmKids_SinkObject. Together they show a small
; meta-sprite (object 5, wObject5) for 60 frames, drop it 16 pixels over 16 frames, hide it and ask
; for the next script command; the text of the scene ('You must be the farm kids.' ...) is shown by
; the script commands around it, not here. Reached through ScriptCommand11 in bank $10. (C2, E-0384)
; implements script command type 11 (SCRIPT_SCENE_FARM_KIDS): a cutscene step named after the scene
; its only script shows: 'You must be the farm kids.' ... 'Warubou Wha? I smell something!'; reached
; through ScriptCommand11 in bank $10 (E-0038, E-0245)
SceneFarmKids::
    ld a, [wScriptStep]
    jumptable
    dw SceneFarmKids_ShowObject
    dw SceneFarmKids_SinkObject

; Farm kids, step 1: every frame adds 1 to the Y of object 5 (wObject5 + SCRIPTOBJ_Y), then
; ScriptApplyStepDeltaAtDE_Bank73 adds the hop-curve delta for the frame; so the object sinks 16
; pixels over 16 frames. When that call reports the 16th frame (carry set) the object is hidden
; (wObject5 = 0) and wScriptStartRequest = $80 asks for the next script command. (C2, E-0384)
SceneFarmKids_SinkObject::
    ld hl, wObject5 + SCRIPTOBJ_Y
    inc [hl]
    ld de, wObject5 + SCRIPTOBJ_Y
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    xor a
    ld [wObject5], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Farm kids, step 0: sets object 5 (wObject5) to shown (byte 0 = $80) at X = $40, Y = $30 every
; frame and counts wScriptParam0 up to 60 with StepScriptParam0Counter_Bank73; when the 60th frame
; is reached wScriptStep is incremented, so the next step is SceneFarmKids_SinkObject. (C2, E-0384)
SceneFarmKids_ShowObject::
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $30
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld a, $80
    ld [wObject5], a
    ld b, $3c
    call StepScriptParam0Counter_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; Counts script frames: adds 1 to wScriptParam0 and compares it with B. If it now equals B,
; wScriptParam0 is reset to 0 and carry is set (B frames have passed); otherwise carry is clear. A
; is 0 on return in both cases. Input B = the frame count to wait for. Used by about 20 scene steps
; in this bank (for example SceneFarmKids_ShowObject); the same 18 bytes exist in three banks. (C2,
; E-0384)
; wScriptParam0 += 1; if it now equals B it is reset to 0 and carry is set, else carry is clear;
; returns A = 0 either way (the same 18 bytes appear in 3 banks)
StepScriptParam0Counter_Bank73::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp b
    jr z, .clear_script_param0
    sub a
    ret

.clear_script_param0:
    xor a
    ld [wScriptParam0], a
    scf
    ret

; Sets bit 1 of the byte at HL ([HL] |= $02); A is clobbered with the result and HL is unchanged.
; Its two callers (SceneSpiritEnvoy2_Float and one more) point HL at wSpriteSlots + $D, the flag
; byte of sprite slot 0, where bit 1 is the animation freeze bit. The same 5 bytes exist in four
; banks. (C2, E-0384)
; [HL] |= $02; clobbers A (the same 5 bytes appear in 4 banks)
SetBit1AtHL_Bank73::
    ld a, [hl]
    or $02
    ld [hl], a
    ret

; Clears bit 1 of the byte at HL ([HL] &= $FD); A is clobbered with the result. The pair of
; SetBit1AtHL_Bank73. Nothing in src/ calls this copy of the helper (the other banks have their own
; copies, for example ClearBit1AtHL_Bank0F, which are called). The same 5 bytes exist in four banks.
; (C2, E-0384)
; [HL] &= $FD; clobbers A (the same 5 bytes appear in 4 banks)
ClearBit1AtHL_Bank73::
    ld a, [hl]
    and $fd
    ld [hl], a
    ret

; Sets bit 2 of the byte at HL ([HL] |= $04); A is clobbered with the result. Scene steps in this
; bank call it with HL = wSpriteSlots + $D, wObject1 + OBJ_FLAGS or hPlayerStateFlags (bit 2 of
; those is the frame-rule bit of an object, and the moving bit of the player), paired with
; ClearBit2AtHL_Bank73. (C2, E-0384)
; sets bit 2 of the byte at [HL]; only A is clobbered
SetBit2AtHL_B73::
    ld a, [hl]
    or $04
    ld [hl], a
    ret

; Clears bit 2 of the byte at HL ([HL] &= $FB); A is clobbered with the result. The pair of
; SetBit2AtHL_B73, called by about 11 scene steps in this bank, mostly with HL = wSpriteSlots + $D.
; The same 5 bytes exist in four banks. (C2, E-0384)
; [HL] &= $FB; clobbers A (the same 5 bytes appear in 4 banks)
ClearBit2AtHL_Bank73::
    ld a, [hl]
    and $fb
    ld [hl], a
    ret

; Every 32nd script frame, steps the direction byte at DE on to the next of four values: when
; wScriptParam0 & $1F is 0, [DE] = ([DE] + 1) & 3 (A holds the new value). On the other frames it
; changes nothing and returns with A = wScriptParam0 & $1F (not zero, so the zero flag is clear).
; Its four callers (Warubou food 2 steps such as SceneWarubouFood2_ShowWarubouWaheyItsThe) pass DE =
; wSpriteSlots + $7 to keep sprite 0 turning. (C2, E-0384)
; when wScriptParam0 & $1F = 0: [DE] = ([DE] + 1) & 3, the next of four directions; otherwise
; returns with A = wScriptParam0 & $1F (E-0064) (the same 12 bytes appear in 3 banks)
RotateDirectionAtDEEvery32_Bank73::
    ld a, [wScriptParam0]
    and $1f
    ret nz
    ld a, [de]
    inc a
    and $03
    ld [de], a
    ret

; Moves the byte at DE (an X or Y coordinate) along a 32-frame hop curve: stores DE in
; wStepPtrLo/wStepPtrHi, far-calls AddStepDeltaToPointedByte (adds the signed delta table entry
; number wScriptParam0 / 2 to [DE]), then adds 2 to wScriptParam0. After 16 calls wScriptParam0
; reaches $20, is reset to 0 and carry is set; before that carry is clear. A is 0 on return. Same 34
; bytes as ScriptApplyStepDeltaAtDE in another bank. Many scene steps in this bank call it once per
; frame. (C2, E-0384)
; the same 34 bytes as ScriptApplyStepDeltaAtDE (ScriptApplyStepDeltaAtDE) (E-0062)
ScriptApplyStepDeltaAtDE_Bank73::
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    cp $20
    jr z, .clear_script_param0
    sub a
    ret

.clear_script_param0:
    xor a
    ld [wScriptParam0], a
    scf
    ret

; Input DE = address of a coordinate byte, HL = a message word. Each frame stores DE in
; wStepPtrLo/wStepPtrHi, far-calls AddStepDeltaToPointedByte (adds table entry wScriptParam0 / 2 to
; [DE]) and adds 1 to wScriptParam0. On the 32nd frame (count $20) it starts the message with
; StartMessageHL_B73b, clears wScriptParam0 and increments wScriptStep; before that it just returns.
; Used by the hop steps SceneWarubouFood2_HopObject1, SceneSpinning_HopObject0ThenMessage and one
; more in this bank. (C2, E-0384)
; stores DE in wStepPtrLo/9 and far-calls AddStepDeltaToPointedByte each frame; after 32 frames
; starts message HL, clears wScriptParam0 and advances wScriptStep (E-0121)
ScriptStepAdjust32TimesThenMessage_Bank73::
    push hl
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    pop hl
    cp $20
    ret nz
    call StartMessageHL_B73b
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Starts a message by message word: stores L in wMessageIndex and H in wMessageGroup, then sets
; wMessageState to 0, which makes the next RunMessageBox calls (via RunMessageBoxFar_Bank73) open
; the window and show it. A is 0 on return. The bank-$73 copy of a shared helper; about 25 scene
; steps call it. (C2, E-0384)
; HL is stored in wMessageIndex (low) and wMessageGroup (high); then wMessageState = 0
StartMessageHL_B73b::
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a
    ld [wMessageState], a
    ret

; Runs one frame of the message box from bank $73: A is stored in wStepPtrLo (0 lets RunMessageBox
; freeze the player and objects when it opens the window; non-zero skips that), then RunMessageBox
; in bank $5F is far-called. Returns carry set when wMessageState is $FF (the message is finished or
; idle), otherwise carry clear with A = 0. Scene steps call it every frame until carry is set, then
; move to the next step. (C1, E-0384)
; wStepPtrLo = A, far-calls RunMessageBox, then carry set when wMessageState = $FF (idle), else A =
; 0 and carry clear (E-0079) (the same 20 bytes appear in 4 banks)
RunMessageBoxFar_Bank73::
    ld [wStepPtrLo], a
    farcall RunMessageBox
    ld a, [wMessageState]
    cp $ff
    jr z, .return_carry
    sub a
    ret

.return_carry:
    scf
    ret

; Chest battle, step 1: waits for the message (RunMessageBoxFar_Bank73); next step. (C1, E-0357)
SceneChestBattle_WaitMessage::
    xor a
    call RunMessageBoxFar_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; Wizstone, step 9: after the message asks for the next script command. (C1, E-0357)
SceneWizstone_WaitMessage::
    xor a
    call RunMessageBoxFar_Bank73
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret
    ds $525, $00
