; ROM bank $73: GreatLog events and story scenes, reward items
; The annotated listing of this bank is build/listing/bank73.asm.

SECTION "Bank 73", ROMX[$4000], BANK[$73]
    db $73

; implements script command type 82 (SCRIPT_GREATLOG_FIELD_EVENT): talk category 8: jumps by
; wPendingFieldEvent & $0F to 13 scripted scenes on the Great Log island (Cobi, Tara, Warubou and
; Kameha dialogue); scene $0A gives gold or items, scene $0C takes a gold loss
; (DeductGoldPenaltyAndFormatLoss); corrects the E-0286 reading 'GreatLogFieldEvents'; reached
; through ScriptCommand82 in bank $10 (E-0038, E-0293)
GreatLogFieldEvents::
    ld a, [wPendingFieldEvent]
    and $0f
    jumptable
    dw GreatLogFieldEvents_PapaCalling
    dw GreatLogFieldEvents_TaraThereYouAre
    dw GreatLogFieldEvents_YouFolksRunA
    dw GreatLogFieldEvents_GoodToHear
    dw GreatLogFieldEvents_KingAskedUs
    dw GreatLogFieldEvents_WarubouGiveMe
    dw GreatLogFieldEvents_ThisIsATale
    dw GreatLogFieldEvents_WarubouItsADead
    dw GreatLogFieldEvents_TaraWellBeOK
    dw GreatLogFieldEvents_WarubouWhatIsThis
    dw GreatLogFieldEvents_GoHelpYourMotherScene
    dw GreatLogFieldEvents_KamehaNoGoing
    dw GreatLogFieldEvents_MajorFacilities
    dw GreatLogFieldEvents_MajorFacilities
    dw GreatLogFieldEvents_MajorFacilities
    dw GreatLogFieldEvents_MajorFacilities

; scenes $0C-$0F: "GreatLog's major facilities are situated above ...", a barrel message and the
; gold loss (E-0293)
GreatLogFieldEvents_MajorFacilities::
    ld a, [wScriptStep]
    jumptable
    dw GreatLogFieldEvents_MajorFacilities_StartMessageHL_B73AndStep
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_MajorFacilities_SaveScreenBufferToBGMap1
    dw GreatLogFieldEvents_MajorFacilities_ShowGreatLogsMajorFacilitiesAre
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_MajorFacilities_ShowHeroPeeredIntoThe
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd

; step 0 of GreatLogFieldEvents_MajorFacilities: calls StartMessageHL_B73; advances wScriptStep
; (E-0347)
GreatLogFieldEvents_MajorFacilities_StartMessageHL_B73AndStep::
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

; step 3 of GreatLogFieldEvents_MajorFacilities: branches on wBattleScene; shows 'GreatLog's major
; facilities are situated'; calls SetFlagBit; advances wScriptStep; calls StartMessageHL_B73; sets
; wScriptStep to 6 (E-0347)
GreatLogFieldEvents_MajorFacilities_ShowGreatLogsMajorFacilitiesAre::
    ld a, [wBattleScene]
    or a
    jr nz, .check_pending_field_event
    ld hl, $003e ; '*: GreatLog's major facilities are situated'
    call StartMessageHL_B73
    ld a, [wPendingFieldEvent]
    and $0f
    sub $0c
    add a
    ld hl, GreatLogFieldEvents_MajorFacilities_ShowGreatLogsMajorFacilitiesAre_Data
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

; data read by GreatLogFieldEvents (8 bytes) (E-0347)
GreatLogFieldEvents_MajorFacilities_ShowGreatLogsMajorFacilitiesAre_Data::
    db $93, $01, $96, $01, $99, $01, $9c, $01

; scene $0B: a chest message, 'Kameha Wahahah! No going ...', a vase message (E-0293)
GreatLogFieldEvents_KamehaNoGoing::
    ld a, [wScriptStep]
    jumptable
    dw GreatLogFieldEvents_KamehaNoGoing_Msg_HeroTriedToOpen
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_KamehaNoGoing_ShowKamehaWahahahNoGoing
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_MajorFacilities_SaveScreenBufferToBGMap1
    dw GreatLogFieldEvents_KamehaNoGoing_ShowHeroPeeredIntoThe
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_KamehaNoGoing_ToScriptStepFlashScreenNegative
    dw GreatLogFieldEvents_KamehaNoGoing_ShowCobiHeroPapasCalling
    dw GreatLogFieldEvents_KamehaNoGoing_WriteScriptParam0AndFieldDrawFlagsEtc
    dw ScriptStepBlinkSpritesThenEnd
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_MajorFacilities_ShowHeroPeeredIntoThe
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd

; step 0 of GreatLogFieldEvents_KamehaNoGoing: shows '0 tried to open the chest.'; advances
; wScriptStep (E-0347)
GreatLogFieldEvents_KamehaNoGoing_Msg_HeroTriedToOpen::
    ld hl, MSG_KEEP_OPEN | $0037 ; '0 tried to open the chest.'
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; step 2 of GreatLogFieldEvents_KamehaNoGoing: branches on wTextYesNoResult; calls
; StartMessageHL_B73; advances wScriptStep; calls StartMessageHL_B73; sets wScriptStep to $0d
; (E-0347)
GreatLogFieldEvents_KamehaNoGoing_ShowKamehaWahahahNoGoing::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b73
    ld hl, vTiles0 + $49
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b73:
    ld hl, vTiles0 + $48
    call StartMessageHL_B73
    ld a, $0d
    ld [wScriptStep], a
    ret

; step 5 of GreatLogFieldEvents_KamehaNoGoing: branches on wBattleScene; shows '0 peered into the
; vase. A'; branches on wIsCGB; calls CopyBytes; advances wScriptStep; shows 'Hey! You brats! Scram!
; Hands'; sets wScriptStep to $0b (E-0347)
GreatLogFieldEvents_KamehaNoGoing_ShowHeroPeeredIntoThe::
    ld a, [wBattleScene]
    or a
    jr nz, .call_start_message_hl_b73
    ld hl, $0038 ; '0 peered into the vase. A'
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
    ld hl, $0039 ; '*: Hey! You brats! Scram! Hands'
    call StartMessageHL_B73
    ld a, $0b
    ld [wScriptStep], a
    ret

; step 7 of GreatLogFieldEvents_MajorFacilities: shows '0 peered into the barrel. It'; calls
; DeductGoldPenaltyAndFormatLoss; advances wScriptStep (E-0347)
GreatLogFieldEvents_MajorFacilities_ShowHeroPeeredIntoThe::
    ld hl, $000f ; '0 peered into the barrel. It'
    call StartMessageHL_B73
    call DeductGoldPenaltyAndFormatLoss
    ld hl, wScriptStep
    inc [hl]
    ret

; by its step: messages 'Go help your mother' and 'If some monster masters ...', a saved screen, a
; joypad wait and sprite blinking (E-0293)
GreatLogFieldEvents_GoHelpYourMotherScene::
    ld a, [wScriptStep]
    jumptable
    dw GreatLogFieldEvents_GoHelpYourMotherScene_ShowGoHelpYourMother
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_GoHelpYourMotherScene_ShowIfSomeMonsterMasters
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_GoHelpYourMotherScene_SaveScreenBufferToBGMap1
    dw GreatLogFieldEvents_GoHelpYourMotherScene_WriteScriptParam0
    dw GreatLogFieldEvents_GoHelpYourMotherScene_ReadJoypadPressed
    dw GreatLogFieldEvents_GoHelpYourMotherScene_TickCounter_2
    dw GreatLogFieldEvents_GoHelpYourMotherScene_RestoreScreenBufferFromBGMap1
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd

; step 8 of GreatLogFieldEvents_GoHelpYourMotherScene: increments wScriptParam0; returns unless
; wScriptParam0 is $3c; calls RestoreScreenBufferFromBGMap1; calls DrawFullScreenBufferAtScroll;
; calls DecompressToVRAM; calls LoadRecordListNameTiles; sets wScriptParam0 to 0; advances
; wScriptStep; branches on the byte at
; GreatLogFieldEvents_GoHelpYourMotherScene_RestoreScreenBufferFromBGMap1_SymbolRowTable_2; branches
; on the byte at
; GreatLogFieldEvents_GoHelpYourMotherScene_RestoreScreenBufferFromBGMap1_SymbolRowTable_3; branches
; on the byte at
; GreatLogFieldEvents_GoHelpYourMotherScene_RestoreScreenBufferFromBGMap1_SymbolRowTable; shows
; 'Hello, there! You must be'; then 27 more steps (see the code) (E-0347)
GreatLogFieldEvents_GoHelpYourMotherScene_RestoreScreenBufferFromBGMap1::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $3c
    ret nz
    farcall RestoreScreenBufferFromBGMap1
    farcall DrawFullScreenBufferAtScroll
    ld b, $46
    ld de, Tiles1Gfx
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
    ld de, GreatLogFieldEvents_GoHelpYourMotherScene_RestoreScreenBufferFromBGMap1_SymbolRowTable
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
    ld de, GreatLogFieldEvents_GoHelpYourMotherScene_RestoreScreenBufferFromBGMap1_SymbolRowTable_2
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
    ld de, GreatLogFieldEvents_GoHelpYourMotherScene_RestoreScreenBufferFromBGMap1_SymbolRowTable_3
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
    ld de, GreatLogFieldEvents_GoHelpYourMotherScene_RestoreScreenBufferFromBGMap1_SymbolRowTable
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [de]
    or a
    jr nz, .skip4
    ld hl, $0032 ; '*: Hello, there! You must be'
    call StartMessageHL_B73
    ld a, $1e
    ld [wStepPtrLo], a
    farcall AppendItemStepPtrLoToInventory
    ret

.skip4:
    dec a
    jr nz, .skip5
    ld hl, $0030 ; '*: Heh, so these are the'
    call StartMessageHL_B73
    ld a, $2c
    ld [wStepPtrLo], a
    farcall AppendItemStepPtrLoToInventory
    ret

.skip5:
    dec a
    jr nz, .skip6
    ld hl, $0031 ; '*: C'mon, Warubou!'
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
    ld hl, $0044 ; '0 checked the peculiar door. It'
    call StartMessageHL_B73
    ld hl, $01f4
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall AddGoldCapped
    ret

.call_start_message_hl_b73:
    ld hl, $0045 ; '*: You must be the farm'
    call StartMessageHL_B73
    ld hl, $00c8
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall AddGoldCapped
    ret

.loop:
    ld hl, $0035 ; '*: The King is too lenient'
    call StartMessageHL_B73
    ret

.check_menu_state:
    ld a, [wMenuState]
    and $f0
    swap a
    ld de, GreatLogFieldEvents_GoHelpYourMotherScene_RestoreScreenBufferFromBGMap1_SymbolRowTable
    add e
    ld e, a
    jr nc, .skip7
    inc d

.skip7:
    ld a, [de]
    or a
    jr nz, .skip8
    ld hl, $0046 ; '*: Thanks for coming by. I'll'
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
    ld hl, $0047 ; '0 read the notice. 'We guarantee'
    call StartMessageHL_B73
    ld hl, $0032
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall AddGoldCapped
    ret

; step 7 of GreatLogFieldEvents_GoHelpYourMotherScene: calls
; GreatLogFieldEvents_GoHelpYourMotherScene_WaitFrameCounterLo; calls
; GreatLogFieldEvents_GoHelpYourMotherScene_TickCounter; decrements wScriptStep; calls
; GreatLogFieldEvents_GoHelpYourMotherScene_TickCounter; decrements wScriptStep; calls
; GreatLogFieldEvents_GoHelpYourMotherScene_TickCounter; advances wScriptStep; calls
; GreatLogFieldEvents_GoHelpYourMotherScene_WriteTemp0AndTemp1 (E-0347)
GreatLogFieldEvents_GoHelpYourMotherScene_TickCounter_2::
    call GreatLogFieldEvents_GoHelpYourMotherScene_WaitFrameCounterLo
    ld a, [wFrameCounterLo]
    and $01
    jr z, .call_great_log_field_events_go_help_your2
    ld a, [wMenuCursor]
    dec a
    jr nz, .skip
    ld hl, wMenuState
    call GreatLogFieldEvents_GoHelpYourMotherScene_TickCounter
    or a
    jr z, .call_great_log_field_events_go_help_your2
    ld hl, wScriptStep
    dec [hl]
    jr .call_great_log_field_events_go_help_your2

.skip:
    dec a
    jr nz, .call_great_log_field_events_go_help_your
    ld hl, wMenuSubState
    call GreatLogFieldEvents_GoHelpYourMotherScene_TickCounter
    or a
    jr z, .call_great_log_field_events_go_help_your2
    ld hl, wScriptStep
    dec [hl]
    jr .call_great_log_field_events_go_help_your2

.call_great_log_field_events_go_help_your:
    ld hl, wMenuSelectedMember
    call GreatLogFieldEvents_GoHelpYourMotherScene_TickCounter
    or a
    jr z, .call_great_log_field_events_go_help_your2
    ld hl, wScriptStep
    inc [hl]

.call_great_log_field_events_go_help_your2:
    call GreatLogFieldEvents_GoHelpYourMotherScene_WriteTemp0AndTemp1
    ret

; returns 1 when the low nibble at HL is 0; otherwise counts the high nibble up and wraps it at 10,
; returning 0 (E-0305)
GreatLogFieldEvents_GoHelpYourMotherScene_TickCounter::
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

; step 6 of GreatLogFieldEvents_GoHelpYourMotherScene: branches on wJoypadPressed; increments
; wMenuCursor; advances wScriptStep; calls
; GreatLogFieldEvents_GoHelpYourMotherScene_WaitFrameCounterLo; calls
; GreatLogFieldEvents_GoHelpYourMotherScene_WriteTemp0AndTemp1 (E-0347)
GreatLogFieldEvents_GoHelpYourMotherScene_ReadJoypadPressed::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .call_great_log_field_events_go_help_your
    ld hl, wMenuCursor
    inc [hl]
    ld hl, wScriptStep
    inc [hl]

.call_great_log_field_events_go_help_your:
    call GreatLogFieldEvents_GoHelpYourMotherScene_WaitFrameCounterLo
    call GreatLogFieldEvents_GoHelpYourMotherScene_WriteTemp0AndTemp1
    ret

; step 5 of GreatLogFieldEvents_GoHelpYourMotherScene: calls
; GreatLogFieldEvents_GoHelpYourMotherScene_WaitFrameCounterLo; calls
; GreatLogFieldEvents_GoHelpYourMotherScene_WriteTemp0AndTemp1; increments wScriptParam0; returns
; unless wScriptParam0 is $1e; sets wScriptParam0 to 0; advances wScriptStep (E-0347)
GreatLogFieldEvents_GoHelpYourMotherScene_WriteScriptParam0::
    call GreatLogFieldEvents_GoHelpYourMotherScene_WaitFrameCounterLo
    call GreatLogFieldEvents_GoHelpYourMotherScene_WriteTemp0AndTemp1
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

; step 4 of GreatLogFieldEvents_GoHelpYourMotherScene: calls SaveScreenBufferToBGMap1; calls
; NextRandomSeed; copies wKeyRandomHi & $07 to wMenuState; calls NextRandomSeed; copies wKeyRandomHi
; & $07 to wMenuSubState; calls NextRandomSeed; copies wKeyRandomHi & $07 to wMenuSelectedMember;
; sets wMenuCursor to 0; calls GreatLogFieldEvents_GoHelpYourMotherScene_WriteTemp0AndTemp1;
; branches on wIsCGB; sets rSVBK to 2; sets rSVBK to 0; then 3 more steps (see the code) (E-0347)
GreatLogFieldEvents_GoHelpYourMotherScene_SaveScreenBufferToBGMap1::
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
    call GreatLogFieldEvents_GoHelpYourMotherScene_WriteTemp0AndTemp1
    ld de, GreatLogFieldEvents_GoHelpYourMotherScene_SaveScreenBufferToBGMap1_Data
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

; data read by GreatLogFieldEvents (15 bytes) (E-0347)
GreatLogFieldEvents_GoHelpYourMotherScene_SaveScreenBufferToBGMap1_Data::
    db $b0, $b1, $b1, $b1, $b2, $b6, $a4, $a5, $a6, $b7, $b3, $b4, $b4, $b4, $b5

; step 2 of GreatLogFieldEvents_GoHelpYourMotherScene: branches on wTextYesNoResult; shows 'If some
; monster masters keep'; copies L to hTemp0; copies H to hTemp1; calls SubtractGoldFloorZero;
; advances wScriptStep; shows 'There were many wild monsters'; sets wScriptStep to 9 (E-0347)
GreatLogFieldEvents_GoHelpYourMotherScene_ShowIfSomeMonsterMasters::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b73
    ld hl, $002f ; '*: If some monster masters keep'
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
    ld hl, $0036 ; '*: There were many wild monsters'
    call StartMessageHL_B73
    ld a, $09
    ld [wScriptStep], a
    ret

; step 0 of GreatLogFieldEvents_GoHelpYourMotherScene: advances wScriptStep; shows 'Go help your
; mother now.' (E-0347)
GreatLogFieldEvents_GoHelpYourMotherScene_ShowGoHelpYourMother::
    ld hl, wScriptStep
    inc [hl]
    ld hl, $002e ; '*: Go help your mother now.'
    call StartMessageHL_B73
    ret

; May return early; returns if wMenuCursor is $03; branches on wMenuCursor; sets wMenuState; copies
; wMenuState & $0f to wMenuState; branches on wMenuCursor; sets wMenuSubState; copies wMenuSubState
; & $0f to wMenuSubState; sets wMenuSelectedMember; copies wMenuSelectedMember & $0f to
; wMenuSelectedMember (E-0347)
GreatLogFieldEvents_GoHelpYourMotherScene_WaitFrameCounterLo::
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

; Copies the byte at
; GreatLogFieldEvents_GoHelpYourMotherScene_RestoreScreenBufferFromBGMap1_SymbolRowTable to hTemp0;
; copies the byte at
; GreatLogFieldEvents_GoHelpYourMotherScene_RestoreScreenBufferFromBGMap1_SymbolRowTable to hTemp1;
; calls DrawSymbolTilesForTemp1; copies the byte at
; GreatLogFieldEvents_GoHelpYourMotherScene_RestoreScreenBufferFromBGMap1_SymbolRowTable_2 to
; hTemp0; copies the byte at
; GreatLogFieldEvents_GoHelpYourMotherScene_RestoreScreenBufferFromBGMap1_SymbolRowTable_2 to
; hTemp1; calls DrawSymbolTilesForTemp1; copies the byte at
; GreatLogFieldEvents_GoHelpYourMotherScene_RestoreScreenBufferFromBGMap1_SymbolRowTable_3 to
; hTemp0; copies the byte at
; GreatLogFieldEvents_GoHelpYourMotherScene_RestoreScreenBufferFromBGMap1_SymbolRowTable_3 to
; hTemp1; calls DrawSymbolTilesForTemp1 (E-0347)
GreatLogFieldEvents_GoHelpYourMotherScene_WriteTemp0AndTemp1::
    ld hl, vTiles1 + $240
    ld a, [wMenuState]
    and $f0
    swap a
    push af
    ld de, GreatLogFieldEvents_GoHelpYourMotherScene_RestoreScreenBufferFromBGMap1_SymbolRowTable
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
    ld de, GreatLogFieldEvents_GoHelpYourMotherScene_RestoreScreenBufferFromBGMap1_SymbolRowTable
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
    ld de, GreatLogFieldEvents_GoHelpYourMotherScene_RestoreScreenBufferFromBGMap1_SymbolRowTable_2
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
    ld de, GreatLogFieldEvents_GoHelpYourMotherScene_RestoreScreenBufferFromBGMap1_SymbolRowTable_2
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
    ld de, GreatLogFieldEvents_GoHelpYourMotherScene_RestoreScreenBufferFromBGMap1_SymbolRowTable_3
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
    ld de, GreatLogFieldEvents_GoHelpYourMotherScene_RestoreScreenBufferFromBGMap1_SymbolRowTable_3
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

; A & $0E -> hTemp2; when it is not zero, points DE into DrawSymbolTilesForTemp1_SymbolTiles at
; hTemp1 * 16 + (16 - hTemp2) and copies the tiles (E-0293)
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
GreatLogFieldEvents_GoHelpYourMotherScene_RestoreScreenBufferFromBGMap1_SymbolRowTable::
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
GreatLogFieldEvents_GoHelpYourMotherScene_RestoreScreenBufferFromBGMap1_SymbolRowTable_2::
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
GreatLogFieldEvents_GoHelpYourMotherScene_RestoreScreenBufferFromBGMap1_SymbolRowTable_3::
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

; HL = $C6FE + A; with SRAM enabled ($0100 = $0A) adds the byte at $45CA + wScriptParam0 to the
; 16-bit value read through LoadSRAMRecordWord, caps it at 999, writes it back through
; SRAMRecordAddress, stores the difference in wDigits/wDigits + $1 and shows it
; (Number24ToPackedBCD, WritePackedBCDNoLeadingZeros); no caller found (E-0214)
AddRewardToCounterCappedAt999:: ; configured code entry (E-0214); C0
    ld hl, wPartyList
    add_a_to_hl
    ld a, $0a
    ld [rRAMG], a
    ld a, [wScriptParam0]
    ld de, AddRewardToCounterCappedAt999_RewardAmounts
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

; AddRewardToCounterCappedAt999 adds the byte at $45CA + wScriptParam0; 6 bytes end at the code
; after them (E-0214, C1)
; record: amount added
AddRewardToCounterCappedAt999_RewardAmounts::
    db $5d ; id 0
    db $61 ; id 1
    db $63 ; id 2
    db $65 ; id 3
    db $67 ; id 4
    db $69 ; id 5

; scene 8: "Tara We'll be OK", a bookshelf message, a negative flash, 'Oh my! The well ...' (E-0293)
GreatLogFieldEvents_TaraWellBeOK::
    ld a, [wScriptStep]
    jumptable
    dw GreatLogFieldEvents_TaraWellBeOK_ShowTaraWellBeOK
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_TaraWellBeOK_ShowHeroCheckedTheBookshelf
    dw GreatLogFieldEvents_TaraWellBeOK_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_TaraWellBeOK_ToScriptStepFlashScreenNegative
    dw GreatLogFieldEvents_TaraWellBeOK_Msg0052_OhMyTheWell
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd

; step 0 of GreatLogFieldEvents_TaraWellBeOK: advances wScriptStep; shows 'Tara: We'll be OK! I'm
; going' (E-0347)
GreatLogFieldEvents_TaraWellBeOK_ShowTaraWellBeOK::
    ld hl, wScriptStep
    inc [hl]
    ld hl, MSG_KEEP_OPEN | $0021 ; 'Tara: We'll be OK! I'm going'
    call StartMessageHL_B73
    ret

; step 2 of GreatLogFieldEvents_TaraWellBeOK: branches on wTextYesNoResult; calls
; StartMessageHL_B73; sets wVisitedScreens to $ff; copies L to hTemp0; copies H to hTemp1; calls
; SubtractGoldFloorZero; advances wScriptStep; calls StartMessageHL_B73; sets wScriptStep to 6
; (E-0347)
GreatLogFieldEvents_TaraWellBeOK_ShowHeroCheckedTheBookshelf::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b73
    ld hl, vTiles0 + $23
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
    ld hl, vTiles0 + $22
    call StartMessageHL_B73
    ld a, $06
    ld [wScriptStep], a
    ret

; step 4 of GreatLogFieldEvents_TaraWellBeOK: calls ScriptStepFlashScreenNegative (E-0347)
GreatLogFieldEvents_TaraWellBeOK_ToScriptStepFlashScreenNegative::
    farcall ScriptStepFlashScreenNegative
    ret

; step 5 of GreatLogFieldEvents_TaraWellBeOK: shows 'Oh my, the well isn't'; advances wScriptStep
; (E-0347)
GreatLogFieldEvents_TaraWellBeOK_Msg0052_OhMyTheWell::
    ld hl, $0052 ; '*: Oh my, the well isn't'
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; scene 6: an item name, 'This is a tale ...', 'Slash If you're in ...' (E-0293)
GreatLogFieldEvents_ThisIsATale::
    ld a, [wScriptStep]
    jumptable
    dw GreatLogFieldEvents_ThisIsATale_CopyItemNameToDE
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_ThisIsATale_ShowThisIsATale
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_ThisIsATale_ShowSlashIfYoureIn
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd
    dw $0000 ; unused index (E-0207)
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_ThisIsATale_ShowThereArentManyFriends
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_ThisIsATale_ShowThisHayIsPretty
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd

; step 13 of GreatLogFieldEvents_ThisIsATale: advances wScriptStep; shows 'This hay is pretty
; good.'; calls CopyItemNameToDE; copies wMenuSelectedMember to wStepPtrLo; calls
; AppendItemStepPtrLoToInventory (E-0347)
GreatLogFieldEvents_ThisIsATale_ShowThisHayIsPretty::
    ld hl, wScriptStep
    inc [hl]
    ld hl, $001b ; '*: This hay is pretty good.'
    call StartMessageHL_B73
    ld a, [wMenuSelectedMember]
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld a, [wMenuSelectedMember]
    ld [wStepPtrLo], a
    farcall AppendItemStepPtrLoToInventory
    ret

; step 9 of GreatLogFieldEvents_ThisIsATale: branches on wTextYesNoResult; copies wMenuSubState to
; wMenuState; calls StartMessageHL_B73; sets wScriptStep to 3; calls StartMessageHL_B73; sets
; wScriptStep to $0c (E-0347)
GreatLogFieldEvents_ThisIsATale_ShowThereArentManyFriends::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b73
    ld a, [wMenuSubState]
    ld [wMenuState], a
    ld hl, wShadowOAM + $19
    call StartMessageHL_B73
    ld a, $03
    ld [wScriptStep], a
    ret

.call_start_message_hl_b73:
    ld hl, vTiles0 + $1a
    call StartMessageHL_B73
    ld a, $0c
    ld [wScriptStep], a
    ret

; step 4 of GreatLogFieldEvents_ThisIsATale: calls NextRandomSeed; may continue in
; GreatLogFieldEvents_ThisIsATale_ShowSlashIfYoureIn; copies wKeyRandomLo & $0f to wMenuSubState;
; copies wKeyRandomLo & $0f to wDigits; calls Number24ToPackedBCD; calls
; WritePackedBCDNoLeadingZeros; branches on wMenuSubState; calls StartMessageHL_B73; branches on
; wTextYesNoResult; branches on wMenuSubState; increments wScriptParam1; copies wScriptParam0 to
; wMenuSelectedMember; then 22 more steps (see the code) (E-0347)
GreatLogFieldEvents_ThisIsATale_ShowSlashIfYoureIn::
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and $0f
    cp $0d
    jr nc, GreatLogFieldEvents_ThisIsATale_ShowSlashIfYoureIn
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
    ld hl, vTiles0 + $18
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
    ld hl, vTiles0 + $1c
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
    ld hl, GreatLogFieldEvents_ThisIsATale_ShowSlashIfYoureIn_Data1
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
    ld hl, GreatLogFieldEvents_ThisIsATale_ShowSlashIfYoureIn_Data2
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
    ld hl, wShadowOAM + $16
    call StartMessageHL_B73
    ld a, $08
    ld [wScriptStep], a
    ret

.call_start_message_hl_b73:
    ld hl, vTiles0 + $17
    call StartMessageHL_B73

.read_script_param1:
    ld a, [wScriptParam1]
    add a
    ld hl, GreatLogFieldEvents_ThisIsATale_ShowSlashIfYoureIn_Data2
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

; step 2 of GreatLogFieldEvents_ThisIsATale: advances wScriptStep; branches on wTextYesNoResult;
; sets wMenuState to 6; calls StartMessageHL_B73; sets wScriptStep to $10 (E-0347)
GreatLogFieldEvents_ThisIsATale_ShowThisIsATale::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b73
    ld a, $06
    ld [wMenuState], a
    ld hl, wShadowOAM + $14
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, vTiles0 + $15
    call StartMessageHL_B73
    ld a, $10
    ld [wScriptStep], a
    ret

; step 0 of GreatLogFieldEvents_ThisIsATale: calls NextRandomSeed; copies the byte at
; GreatLogFieldEvents_ThisIsATale_ShowSlashIfYoureIn_Data1 to wScriptParam0; calls CopyItemNameToDE;
; shows 'Tara: Big brother! GreatLog will be'; advances wScriptStep (E-0347)
GreatLogFieldEvents_ThisIsATale_CopyItemNameToDE::
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and $03
    ld hl, GreatLogFieldEvents_ThisIsATale_ShowSlashIfYoureIn_Data1
    add_a_to_hl
    ld a, [hl]
    ld [wScriptParam0], a
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld hl, MSG_KEEP_OPEN | $0013 ; 'Tara: Big brother! GreatLog will be'
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; data read by GreatLogFieldEvents_ThisIsATale_ShowSlashIfYoureIn (20 bytes) (E-0347)
GreatLogFieldEvents_ThisIsATale_ShowSlashIfYoureIn_Data1::
    db $03, $22, $28, $2a, $0b, $25, $05, $2b, $0c, $23, $27, $2c, $11, $12, $26, $1e
    db $0d, $0e, $0f, $10

GreatLogFieldEvents_ThisIsATale_ShowSlashIfYoureIn_Data2::
    db $64, $00, $2c, $01, $58, $02, $e8, $03, $dc, $05

; scene 9: a dresser message, 'Warubou What is this ...' (E-0293)
GreatLogFieldEvents_WarubouWhatIsThis::
    ld a, [wScriptStep]
    jumptable
    dw GreatLogFieldEvents_WarubouWhatIsThis_ShowHeroCheckedTheDresser
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_WarubouWhatIsThis_ShowWarubouWhatIsThis
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_MajorFacilities_SaveScreenBufferToBGMap1
    dw GreatLogFieldEvents_WarubouWhatIsThis_ShowHeroCheckedTheDresser_HeroCheckedTheDresser
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_WarubouWhatIsThis_ProcessRecordFields5DTo69ThenItemString
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_WarubouWhatIsThis_ProcessRecordFields5DTo69ThenItemString_2
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_WarubouWhatIsThis_ShowHeroCheckedTheOven
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd

; step 0 of GreatLogFieldEvents_WarubouWhatIsThis: advances wScriptStep; shows '0 checked the
; dresser. Children's clothes' (E-0347)
GreatLogFieldEvents_WarubouWhatIsThis_ShowHeroCheckedTheDresser::
    ld hl, wScriptStep
    inc [hl]
    ld hl, MSG_KEEP_OPEN | $0024 ; '0 checked the dresser. Children's clothes'
    call StartMessageHL_B73
    ret

; step 2 of GreatLogFieldEvents_WarubouWhatIsThis: branches on wTextYesNoResult; calls
; StartMessageHL_B73; advances wScriptStep; calls StartMessageHL_B73; sets wScriptStep to $0c
; (E-0347)
GreatLogFieldEvents_WarubouWhatIsThis_ShowWarubouWhatIsThis::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b73
    ld hl, vTiles0 + $51
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b73:
    ld hl, vTiles0 + $50
    call StartMessageHL_B73
    ld a, $0c
    ld [wScriptStep], a
    ret

; step 5 of GreatLogFieldEvents_WarubouWhatIsThis: advances wScriptStep; branches on wBattleScene;
; shows '0 checked the dresser. It smelled'; shows 'Warubou: Wa-hey! I'm starving!' (E-0347)
GreatLogFieldEvents_WarubouWhatIsThis_ShowHeroCheckedTheDresser_HeroCheckedTheDresser::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wBattleScene]
    or a
    jr nz, .call_start_message_hl_b73
    ld hl, $0025 ; '0 checked the dresser. It smelled'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, $0053 ; 'Warubou: Wa-hey! I'm starving!'
    call StartMessageHL_B73
    ret

; step 7 of GreatLogFieldEvents_WarubouWhatIsThis: advances wScriptStep; branches on wBattleScene;
; calls ProcessRecordFields5DTo69ThenItemString; calls
; GreatLogFieldEvents_WarubouWhatIsThis_CopyRecordNameToNameGlyphBuf; calls
; GreatLogFieldEvents_WarubouWhatIsThis_LoadSRAMRecordWord; shows '0 checked the oven. It smelled';
; sets wScriptStep to $0c; sets rRAMG to $0a; calls LoadSRAMRecordByte; sets rRAMG to 0; branches on
; hTemp0; shows '0 checked the oven. It smelled'; then 3 more steps (see the code) (E-0347)
GreatLogFieldEvents_WarubouWhatIsThis_ProcessRecordFields5DTo69ThenItemString::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wBattleScene]
    or a
    jr nz, .call_start_message_hl_b73
    ld a, $00
    call ProcessRecordFields5DTo69ThenItemString
    ld a, $00
    call GreatLogFieldEvents_WarubouWhatIsThis_CopyRecordNameToNameGlyphBuf
    ld a, $00
    call GreatLogFieldEvents_WarubouWhatIsThis_LoadSRAMRecordWord
    ld a, [wPartyCount]
    dec a
    jr nz, .read_party_list

.loop:
    ld hl, $0026 ; '0 checked the oven. It smelled'
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
    ld hl, MSG_KEEP_OPEN | $0026 ; '0 checked the oven. It smelled'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, $000f ; '0 peered into the barrel. It'
    call StartMessageHL_B73
    call DeductGoldPenaltyAndFormatLoss
    ld a, $0c
    ld [wScriptStep], a
    ret

; step 9 of GreatLogFieldEvents_WarubouWhatIsThis: advances wScriptStep; calls
; ProcessRecordFields5DTo69ThenItemString; calls
; GreatLogFieldEvents_WarubouWhatIsThis_CopyRecordNameToNameGlyphBuf; calls
; GreatLogFieldEvents_WarubouWhatIsThis_LoadSRAMRecordWord; calls StartMessageHL_B73; sets
; wScriptStep to $0c; sets rRAMG to $0a; calls LoadSRAMRecordByte; sets rRAMG to 0; branches on
; hTemp0; calls StartMessageHL_B73 (E-0347)
GreatLogFieldEvents_WarubouWhatIsThis_ProcessRecordFields5DTo69ThenItemString_2::
    ld hl, wScriptStep
    inc [hl]
    ld a, $01
    call ProcessRecordFields5DTo69ThenItemString
    ld a, $01
    call GreatLogFieldEvents_WarubouWhatIsThis_CopyRecordNameToNameGlyphBuf
    ld a, $01
    call GreatLogFieldEvents_WarubouWhatIsThis_LoadSRAMRecordWord
    ld a, [wPartyCount]
    dec a
    dec a
    jr nz, .read_party_list

.loop:
    ld hl, vTiles0 + $26
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
    ld hl, wShadowOAM + $26
    call StartMessageHL_B73
    ret

; step 11 of GreatLogFieldEvents_WarubouWhatIsThis: advances wScriptStep; calls StartMessageHL_B73;
; calls ProcessRecordFields5DTo69ThenItemString; calls
; GreatLogFieldEvents_WarubouWhatIsThis_CopyRecordNameToNameGlyphBuf; calls
; GreatLogFieldEvents_WarubouWhatIsThis_LoadSRAMRecordWord (E-0347)
GreatLogFieldEvents_WarubouWhatIsThis_ShowHeroCheckedTheOven::
    ld hl, wScriptStep
    inc [hl]
    ld hl, vTiles0 + $26
    call StartMessageHL_B73
    ld a, $02
    call ProcessRecordFields5DTo69ThenItemString
    ld a, $02
    call GreatLogFieldEvents_WarubouWhatIsThis_CopyRecordNameToNameGlyphBuf
    ld a, $02
    call GreatLogFieldEvents_WarubouWhatIsThis_LoadSRAMRecordWord
    ret

; for record wPartyList[A]: passes word field $5D and word fields $61, $63, $65, $67, $69 (B = 1-5)
; to ProcessRecordFields5DTo69ThenItemString_WriteTemp2, then copies the item string to wTextBuf2 +
; $2 (E-0121)
ProcessRecordFields5DTo69ThenItemString::
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
    call ProcessRecordFields5DTo69ThenItemString_WriteTemp2
    ld b, $02
    ld a, [hl]
    ld c, MON_ATK
    call LoadSRAMRecordWord
    call ProcessRecordFields5DTo69ThenItemString_WriteTemp2
    ld b, $03
    ld a, [hl]
    ld c, MON_DEF
    call LoadSRAMRecordWord
    call ProcessRecordFields5DTo69ThenItemString_WriteTemp2
    ld b, $04
    ld a, [hl]
    ld c, MON_AGL
    call LoadSRAMRecordWord
    call ProcessRecordFields5DTo69ThenItemString_WriteTemp2
    ld b, $05
    ld a, [hl]
    ld c, MON_INT
    call LoadSRAMRecordWord
    call ProcessRecordFields5DTo69ThenItemString_WriteTemp2
    xor a
    ld [rRAMG], a
    call CopyItemStringToTextBuf22
    ret

; called from ProcessRecordFields5DTo69ThenItemString: branches on hTemp1; returns unless hTemp1 is
; d; returns if hTemp0 is at least e; copies B to hTemp2 (E-0347)
ProcessRecordFields5DTo69ThenItemString_WriteTemp2::
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

; wScriptParam0 = hTemp2; copies string hTemp2 + $28 of category 5 (item names) to wTextBuf2 + $2
; (CopyStringToBuffer_Bank09) (E-0118) (E-0340: the address in its name read as its RAM name; was
; CopyItemStringToTextBuf22)
CopyItemStringToTextBuf22::
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

; Sets rRAMG to $0a; calls CopyRecordNameToNameGlyphBuf; sets rRAMG to 0 (E-0347)
GreatLogFieldEvents_WarubouWhatIsThis_CopyRecordNameToNameGlyphBuf::
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

; Sets rRAMG to $0a; calls LoadSRAMRecordWord; sets hTemp2; sets hTemp3; branches on hTemp3;
; branches on hTemp2; copies E to hTemp2; copies D to hTemp3; calls SRAMRecordAddress; sets rRAMG to
; 0; sets wDigits; calls Number24ToPackedBCD; then 1 more step (see the code) (E-0347)
GreatLogFieldEvents_WarubouWhatIsThis_LoadSRAMRecordWord::
    ld hl, wPartyList
    add_a_to_hl
    ld a, $0a
    ld [rRAMG], a
    ld a, [wScriptParam0]
    ld de, GreatLogFieldEvents_WarubouWhatIsThis_LoadSRAMRecordWord_Data
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

; data read by GreatLogFieldEvents (6 bytes) (E-0347)
GreatLogFieldEvents_WarubouWhatIsThis_LoadSRAMRecordWord_Data::
    db $5d, $61, $63, $65, $67, $69

; scene 7: a vase message, "Warubou It's a dead ...", 'This hay is pretty ...' (E-0293)
GreatLogFieldEvents_WarubouItsADead::
    ld a, [wScriptStep]
    jumptable
    dw GreatLogFieldEvents_WarubouItsADead_ShowHeroPeeredIntoThe
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_WarubouItsADead_ShowWarubouItsADead
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_MajorFacilities_SaveScreenBufferToBGMap1
    dw GreatLogFieldEvents_WarubouItsADead_ShowYouveComeAtThe
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_WarubouItsADead_ShowThisHayIsPretty
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_WarubouItsADead_ShowThisHayIsPretty_AppendItemStepPtrLoToInventory

; step 0 of GreatLogFieldEvents_WarubouItsADead: advances wScriptStep; shows '0 peered into the
; barrel. It' (E-0347)
GreatLogFieldEvents_WarubouItsADead_ShowHeroPeeredIntoThe::
    ld hl, wScriptStep
    inc [hl]
    ld hl, MSG_KEEP_OPEN | $001d ; '0 peered into the barrel. It'
    call StartMessageHL_B73
    ret

; step 2 of GreatLogFieldEvents_WarubouItsADead: branches on wTextYesNoResult; calls
; StartMessageHL_B73; advances wScriptStep; calls StartMessageHL_B73; sets wScriptStep to 8 (E-0347)
GreatLogFieldEvents_WarubouItsADead_ShowWarubouItsADead::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b73
    ld hl, vTiles0 + $4b
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b73:
    ld hl, vTiles0 + $4a
    call StartMessageHL_B73
    ld a, $08
    ld [wScriptStep], a
    ret

; step 5 of GreatLogFieldEvents_WarubouItsADead: advances wScriptStep; branches on wBattleScene;
; shows 'You've come at the right'; shows 'Cobi: Sure, Mama! We'll be fine.' (E-0347)
GreatLogFieldEvents_WarubouItsADead_ShowYouveComeAtThe::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wBattleScene]
    or a
    jr nz, .call_start_message_hl_b73
    ld hl, $001e ; '*: You've come at the right'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, $001f ; 'Cobi: Sure, Mama! We'll be fine.'
    call StartMessageHL_B73
    ret

; step 7 of GreatLogFieldEvents_WarubouItsADead: advances wScriptStep; branches on wBattleScene;
; calls NextRandomSeed; sets wStepPtrLo; calls AppendItemStepPtrLoToInventory; calls
; CopyItemNameToDE; shows 'This hay is pretty good.'; sets wScriptStep to $0a; shows '0 peered into
; the barrel. It'; calls DeductGoldPenaltyAndFormatLoss (E-0347)
GreatLogFieldEvents_WarubouItsADead_ShowThisHayIsPretty::
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
    ld hl, $001b ; '*: This hay is pretty good.'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, MSG_KEEP_OPEN | $001b ; '*: This hay is pretty good.'
    call StartMessageHL_B73
    ld a, $0a
    ld [wScriptStep], a
    ret

.call_start_message_hl_b732:
    ld hl, $000f ; '0 peered into the barrel. It'
    call StartMessageHL_B73
    call DeductGoldPenaltyAndFormatLoss
    ret

; step 11 of GreatLogFieldEvents_WarubouItsADead: calls NextRandomSeed; sets wStepPtrLo; calls
; AppendItemStepPtrLoToInventory; calls CopyItemNameToDE; calls StartMessageHL_B73; sets wScriptStep
; to 8; calls StartMessageHL_B73; decrements wScriptStep (E-0347)
GreatLogFieldEvents_WarubouItsADead_ShowThisHayIsPretty_AppendItemStepPtrLoToInventory::
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
    ld hl, vTiles0 + $1b
    call StartMessageHL_B73
    ld a, $08
    ld [wScriptStep], a
    ret

.call_start_message_hl_b73:
    ld hl, wShadowOAM + $1b
    call StartMessageHL_B73
    ld hl, wScriptStep
    dec [hl]
    ret

; scene 5: a vase message, 'Warubou Wahey! Give me ...', 'Cobi Hero, they said ...' (E-0293)
GreatLogFieldEvents_WarubouGiveMe::
    ld a, [wScriptStep]
    jumptable
    dw GreatLogFieldEvents_WarubouGiveMe_ShowHeroPeeredIntoThe
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_WarubouGiveMe_ShowWarubouWaheyGiveMe
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_MajorFacilities_SaveScreenBufferToBGMap1
    dw GreatLogFieldEvents_WarubouGiveMe_ShowCobiHeroTheySaid
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_WarubouGiveMe_StartMessageHL_B73
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd

; step 0 of GreatLogFieldEvents_WarubouGiveMe: advances wScriptStep; shows '0 peered into the vase.
; Freshly' (E-0347)
GreatLogFieldEvents_WarubouGiveMe_ShowHeroPeeredIntoThe::
    ld hl, wScriptStep
    inc [hl]
    ld hl, MSG_KEEP_OPEN | $0010 ; '0 peered into the vase. Freshly'
    call StartMessageHL_B73
    ret

; step 2 of GreatLogFieldEvents_WarubouGiveMe: branches on wTextYesNoResult; calls
; StartMessageHL_B73; advances wScriptStep; calls StartMessageHL_B73; sets wScriptStep to 8 (E-0347)
GreatLogFieldEvents_WarubouGiveMe_ShowWarubouWaheyGiveMe::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b73
    ld hl, vTiles0 + $4f
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b73:
    ld hl, vTiles0 + $4e
    call StartMessageHL_B73
    ld a, $08
    ld [wScriptStep], a
    ret

; step 5 of GreatLogFieldEvents_WarubouGiveMe: advances wScriptStep; branches on wBattleScene; shows
; 'Cobi: 0! They said GreatLog will'; shows 'Land ho! There's GreatLog!'; calls
; DeductGoldPenaltyAndFormatLoss (E-0347)
GreatLogFieldEvents_WarubouGiveMe_ShowCobiHeroTheySaid::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wBattleScene]
    or a
    jr nz, .call_start_message_hl_b73
    ld hl, $0011 ; 'Cobi: 0! They said GreatLog will'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, $0012 ; '*: Land ho! There's GreatLog!'
    call StartMessageHL_B73
    call DeductGoldPenaltyAndFormatLoss
    ret

; scene 4: "GreatLog's king asked us ...", 'Wow, you kids sure ...' (E-0293)
GreatLogFieldEvents_KingAskedUs::
    ld a, [wScriptStep]
    jumptable
    dw GreatLogFieldEvents_KingAskedUs_ShowGreatLogsKingAskedUs
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_KingAskedUs_ShowWowYouKidsSure
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_MajorFacilities_SaveScreenBufferToBGMap1
    dw GreatLogFieldEvents_KingAskedUs_ShowGreatLogsKingAskedUs_GreatLog
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_WarubouGiveMe_StartMessageHL_B73
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd

; step 0 of GreatLogFieldEvents_KingAskedUs: advances wScriptStep; shows 'GreatLog's King asked us
; to' (E-0347)
GreatLogFieldEvents_KingAskedUs_ShowGreatLogsKingAskedUs::
    ld hl, wScriptStep
    inc [hl]
    ld hl, MSG_KEEP_OPEN | $000b ; '*: GreatLog's King asked us to'
    call StartMessageHL_B73
    ret

; step 2 of GreatLogFieldEvents_KingAskedUs: branches on wTextYesNoResult; calls StartMessageHL_B73;
; advances wScriptStep; calls StartMessageHL_B73; sets wScriptStep to 8 (E-0347)
GreatLogFieldEvents_KingAskedUs_ShowWowYouKidsSure::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .call_start_message_hl_b73
    ld hl, vTiles0 + $4d
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b73:
    ld hl, vTiles0 + $4c
    call StartMessageHL_B73
    ld a, $08
    ld [wScriptStep], a
    ret

; step 5 of GreatLogFieldEvents_KingAskedUs: advances wScriptStep; branches on wBattleScene; shows
; 'GreatLog's King asked us to'; shows 'Worried about your monsters? Don't' (E-0347)
GreatLogFieldEvents_KingAskedUs_ShowGreatLogsKingAskedUs_GreatLog::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wBattleScene]
    or a
    jr nz, .call_start_message_hl_b73
    ld hl, $000c ; '*: GreatLog's King asked us to'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, $000e ; '*: Worried about your monsters? Don't'
    call StartMessageHL_B73
    ret

; step 7 of GreatLogFieldEvents_WarubouGiveMe: advances wScriptStep; branches on wBattleScene; calls
; NextTableByte; branches on wRandomLo; shows 'When our farm gets established'; sets wStepPtrLo to
; $29; calls AppendItemStepPtrLoToInventory; calls GenerateNewKeyEntry; branches on hTemp0; shows '0
; checked the odd object. It'; shows '0 peered into the barrel. It'; calls
; DeductGoldPenaltyAndFormatLoss (E-0347)
GreatLogFieldEvents_WarubouGiveMe_StartMessageHL_B73::
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
    ld hl, $000d ; '*: When our farm gets established'
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
    ld hl, $0043 ; '0 checked the odd object. It'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, $000f ; '0 peered into the barrel. It'
    call StartMessageHL_B73
    call DeductGoldPenaltyAndFormatLoss
    ret

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

; scene 3: 'Good. That's good to hear! You ...', 'Is that so? ...' (E-0293)
GreatLogFieldEvents_GoodToHear::
    ld a, [wScriptStep]
    jumptable
    dw GreatLogFieldEvents_GoodToHear_ShowGoodThatsGoodTo
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_GoodToHear_ShowIsThatSoToo
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd

; step 0 of GreatLogFieldEvents_GoodToHear: advances wScriptStep; shows 'Good. That's good to
; hear!'; calls GreatLogFieldEvents_SetWStepArrivedIfPartyHasField55Bit7; calls CopyItemNameToDE;
; calls ReadBank16TableWord; copies L to wDigits; calls Number24ToPackedBCD; calls
; WritePackedBCDNoLeadingZeros (E-0347)
GreatLogFieldEvents_GoodToHear_ShowGoodThatsGoodTo::
    ld hl, wScriptStep
    inc [hl]
    ld hl, MSG_KEEP_OPEN | $0008 ; '*: Good. That's good to hear!'
    call StartMessageHL_B73
    call GreatLogFieldEvents_SetWStepArrivedIfPartyHasField55Bit7
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

; step 2 of GreatLogFieldEvents_GoodToHear: advances wScriptStep; branches on wTextYesNoResult;
; copies wScriptParam0 to wStepPtrLo; calls AppendItemStepPtrLoToInventory; calls
; ReadBank16TableWord; copies L to hTemp0; copies H to hTemp1; calls SubtractGoldFloorZero; calls
; StartMessageHL_B73 (E-0347)
GreatLogFieldEvents_GoodToHear_ShowIsThatSoToo::
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
    ld hl, vTiles0 + $9
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, vTiles0 + $a
    call StartMessageHL_B73
    ret

; scene 2: 'You folks run a ...', a vase message, 'There's a spirit in ...' (E-0293)
GreatLogFieldEvents_YouFolksRunA::
    ld a, [wScriptStep]
    jumptable
    dw GreatLogFieldEvents_YouFolksRunA_ShowYouFolksRunA
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_YouFolksRunA_ShowHeroPeeredIntoThe
    dw GreatLogFieldEvents_TaraWellBeOK_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_KamehaNoGoing_ToScriptStepFlashScreenNegative
    dw GreatLogFieldEvents_YouFolksRunA_ShowTheresASpiritIn
    dw GreatLogFieldEvents_KamehaNoGoing_WriteScriptParam0AndFieldDrawFlagsEtc
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd

; step 0 of GreatLogFieldEvents_YouFolksRunA: advances wScriptStep; shows 'You folks run a monster'
; (E-0347)
GreatLogFieldEvents_YouFolksRunA_ShowYouFolksRunA::
    ld hl, wScriptStep
    inc [hl]
    ld hl, MSG_KEEP_OPEN | $0005 ; '*: You folks run a monster'
    call StartMessageHL_B73
    ret

; step 2 of GreatLogFieldEvents_YouFolksRunA: advances wScriptStep; branches on wTextYesNoResult;
; calls StartMessageHL_B73; advances wScriptStep (E-0347)
GreatLogFieldEvents_YouFolksRunA_ShowHeroPeeredIntoThe::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wTextYesNoResult]
    or a
    jr nz, .skip
    ld hl, vTiles0 + $27
    call StartMessageHL_B73
    ret

.skip:
    ld hl, wScriptStep
    inc [hl]
    ld hl, wScriptStep
    inc [hl]
    ret

; step 5 of GreatLogFieldEvents_YouFolksRunA: advances wScriptStep; branches on wMessageIndex;
; copies L to hTemp0; copies H to hTemp1; calls SubtractGoldFloorZero; calls FullyHealParty; shows
; 'There's a spirit in GreatLog'; calls StartMessageHL_B73; advances wScriptStep (E-0347)
GreatLogFieldEvents_YouFolksRunA_ShowTheresASpiritIn::
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
    ld hl, $0006 ; '*: There's a spirit in GreatLog'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, vTiles0 + $7
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; scene 1: 'Tara There you are, big brother!', 'Cobi What's wrong, Hero?' (E-0293)
GreatLogFieldEvents_TaraThereYouAre::
    ld a, [wScriptStep]
    jumptable
    dw GreatLogFieldEvents_TaraThereYouAre_ShowTaraThereYouAre
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_TaraThereYouAre_ShowCobiWhatsWrongHero
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd

; step 0 of GreatLogFieldEvents_TaraThereYouAre: advances wScriptStep; shows 'Tara: There you are,
; big brother!'; calls GreatLogFieldEvents_SetWStepArrivedIfPartyHasField55Bit7; calls
; CopyItemNameToDE; calls ReadBank16TableWord; copies L to wDigits; calls Number24ToPackedBCD; calls
; WritePackedBCDNoLeadingZeros (E-0347)
GreatLogFieldEvents_TaraThereYouAre_ShowTaraThereYouAre::
    ld hl, wScriptStep
    inc [hl]
    ld hl, MSG_KEEP_OPEN | $0002 ; 'Tara: There you are, big brother!'
    call StartMessageHL_B73
    call GreatLogFieldEvents_SetWStepArrivedIfPartyHasField55Bit7
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

; step 2 of GreatLogFieldEvents_TaraThereYouAre: advances wScriptStep; branches on wTextYesNoResult;
; copies wScriptParam0 to wStepPtrLo; calls AppendItemStepPtrLoToInventory; calls
; ReadBank16TableWord; copies L to hTemp0; copies H to hTemp1; calls SubtractGoldFloorZero; calls
; StartMessageHL_B73 (E-0347)
GreatLogFieldEvents_TaraThereYouAre_ShowCobiWhatsWrongHero::
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
    ld hl, vTiles0 + $3
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, vTiles0 + $4
    call StartMessageHL_B73
    ret

; scene 0: 'In the middle of ...', a negative flash, 'Cobi Hero, Papa's calling' (E-0293)
GreatLogFieldEvents_PapaCalling::
    ld a, [wScriptStep]
    jumptable
    dw GreatLogFieldEvents_PapaCalling_Msg0000_InTheMiddleOf
    dw GreatLogFieldEvents_TaraWellBeOK_RunMessageBoxCarryWhenIdle_Bank73
    dw GreatLogFieldEvents_KamehaNoGoing_ToScriptStepFlashScreenNegative
    dw GreatLogFieldEvents_KamehaNoGoing_ShowCobiHeroPapasCalling
    dw GreatLogFieldEvents_KamehaNoGoing_WriteScriptParam0AndFieldDrawFlagsEtc
    dw GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd

; step 0 of GreatLogFieldEvents_PapaCalling: shows 'In the middle of the sea'; advances wScriptStep
; (E-0347)
GreatLogFieldEvents_PapaCalling_Msg0000_InTheMiddleOf::
    ld hl, $0000 ; 'In the middle of the sea'
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; step 3 of GreatLogFieldEvents_TaraWellBeOK: calls RunMessageBoxCarryWhenIdle_Bank73; may return
; early; branches on wIsCGB; calls CopyBytes; plays sound $7a; advances wScriptStep (E-0347)
GreatLogFieldEvents_TaraWellBeOK_RunMessageBoxCarryWhenIdle_Bank73::
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

; step 7 of GreatLogFieldEvents_KamehaNoGoing: calls ScriptStepFlashScreenNegative (E-0347)
GreatLogFieldEvents_KamehaNoGoing_ToScriptStepFlashScreenNegative::
    farcall ScriptStepFlashScreenNegative
    ret

; step 8 of GreatLogFieldEvents_KamehaNoGoing: calls FullyHealParty; shows 'Cobi: 0! Papa's calling.
; He's at'; sets wScriptParam0 to 0; advances wScriptStep (E-0347)
GreatLogFieldEvents_KamehaNoGoing_ShowCobiHeroPapasCalling::
    farcall FullyHealParty
    ld hl, $0001 ; 'Cobi: 0! Papa's calling. He's at'
    call StartMessageHL_B73
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 1 of GreatLogFieldEvents_MajorFacilities: calls RunMessageBoxCarryWhenIdle_Bank73; may return
; early; advances wScriptStep (E-0347)
GreatLogFieldEvents_MajorFacilities_RunMessageBoxCarryWhenIdle_Bank73::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 9 of GreatLogFieldEvents_KamehaNoGoing: branches on wScriptParam0; increments wScriptParam0;
; sets hFieldDrawFlags to $0e; calls MoveIncapacitatedPartyMembersBack; calls
; LoadRecordListNameTiles; calls LoadPlayerAndFollowerSpriteGraphics; sets wOBJPaletteUploadRequest
; to $7f; sets hFieldDrawFlags to 0; sets wScriptParam0 to 0; advances wScriptStep (E-0347)
GreatLogFieldEvents_KamehaNoGoing_WriteScriptParam0AndFieldDrawFlagsEtc::
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

; HL is stored in wMessageIndex (low) and wMessageGroup (high); then wMessageState = 0 (E-0351)
StartMessageHL_B73::
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a
    ld [wMessageState], a
    ret

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
    dw RunMessageBox_Bank73_SetBit1OfPlayerAndObjectFlags
    dw RunMessageBox_Bank73_BeginStringDisplay_Bank09
    dw RunMessageBox_Bank73_WriteMessageStateAndTextWindowStateEtc
    dw RunMessageBox_Bank73_WriteMessageState

; step 0 of RunMessageBox_Bank73: calls SetBit1OfPlayerAndObjectFlags; branches on wMessageGroup;
; calls FillTilesRequest; calls FillTilesFromRequest; plays sound $69; sets wTextWindowState to 1;
; sets wTextWindowStep to 0; sets hSpriteWindowClipMode to 2; branches on hPlayerY; sets
; wTextWindowState to $81; sets hSpriteWindowClipMode to 1; advances wMessageState (E-0347)
RunMessageBox_Bank73_SetBit1OfPlayerAndObjectFlags::
    pop af
    or a
    jr nz, .check_message_group
    farcall SetBit1OfPlayerAndObjectFlags

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

; step 1 of RunMessageBox_Bank73: may return early; copies wMessageIndex to wStringIndex; sets
; wStringCategory to 5; calls BeginStringDisplay_Bank09; advances wMessageState (E-0347)
RunMessageBox_Bank73_BeginStringDisplay_Bank09::
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

; step 2 of RunMessageBox_Bank73: returns if bit 0 of wTextFlags is set; branches on wMessageGroup;
; sets wMessageState to $ff; plays sound $69; sets wTextWindowState to 2; sets wTextWindowStep to 0;
; sets hSpriteWindowClipMode to 0; branches on hPlayerY; sets wTextWindowState to $82; advances
; wMessageState (E-0347)
RunMessageBox_Bank73_WriteMessageStateAndTextWindowStateEtc::
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

; step 3 of RunMessageBox_Bank73: calls ClearBit1OfPlayerAndObjectFlags; sets wMessageState to $ff
; (E-0347)
RunMessageBox_Bank73_WriteMessageState::
    ld a, [wTextWindowState]
    and $03
    jr z, .restore
    pop af
    ret

.restore:
    pop af
    or a
    jr nz, .set_message_state_to_FF
    farcall ClearBit1OfPlayerAndObjectFlags

.set_message_state_to_FF:
    ld a, $ff
    ld [wMessageState], a
    ret

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

; Calls SetWStepArrivedIfPartyHasField55Bit7; branches on wStepArrived; sets wScriptParam0 to $0c;
; calls GreatLogFieldEvents_ReadBank16TableWord; may return early; calls
; GreatLogFieldEvents_LoadSRAMRecordByte_2; branches on wStepArrived; sets wScriptParam0 to 8; calls
; GreatLogFieldEvents_ReadBank16TableWord; may return early; calls
; GreatLogFieldEvents_LoadSRAMRecordByte; branches on wStepArrived; then 40 more steps (see the
; code) (E-0347)
GreatLogFieldEvents_SetWStepArrivedIfPartyHasField55Bit7::
    farcall SetWStepArrivedIfPartyHasField55Bit7
    ld a, [wStepArrived]
    or a
    jr z, .call_great_log_field_events_load_sram_record
    ld a, $0c
    ld [wScriptParam0], a
    call GreatLogFieldEvents_ReadBank16TableWord
    or a
    ret nz

.call_great_log_field_events_load_sram_record:
    farcall GreatLogFieldEvents_LoadSRAMRecordByte_2
    ld a, [wStepArrived]
    or a
    jr z, .call_great_log_field_events_load_sram_record2
    ld a, $08
    ld [wScriptParam0], a
    call GreatLogFieldEvents_ReadBank16TableWord
    or a
    ret nz

.call_great_log_field_events_load_sram_record2:
    farcall GreatLogFieldEvents_LoadSRAMRecordByte
    ld a, [wStepArrived]
    or a
    jr z, .check_party_count
    ld a, $06
    ld [wScriptParam0], a
    call GreatLogFieldEvents_ReadBank16TableWord
    or a
    ret nz

.check_party_count:
    ld a, [wPartyCount]
    cp $03
    jr z, .call_great_log_field_events_load_sram_record3
    farcall CountRecordsInUse
    ld a, [wRecordsInUse]
    cp $03
    jr nc, .check_records_in_use
    ld a, $19
    ld [wScriptParam0], a
    call GreatLogFieldEvents_ReadBank16TableWord
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
    call GreatLogFieldEvents_ReadBank16TableWord
    or a
    ret nz

.check_records_in_use2:
    ld a, [wRecordsInUse]
    cp $06
    jr c, .call_great_log_field_events_load_sram_record3
    cp $0b
    jr nc, .call_great_log_field_events_load_sram_record3
    ld a, $1b
    ld [wScriptParam0], a
    call GreatLogFieldEvents_ReadBank16TableWord
    or a
    ret nz

.call_great_log_field_events_load_sram_record3:
    call GreatLogFieldEvents_LoadSRAMRecordWord
    ldh a, [hTemp3]
    or a
    jr nz, .set_script_param0_to_05
    ldh a, [hTemp2]
    cp $65
    jr c, .check_temp3

.set_script_param0_to_05:
    ld a, $05
    ld [wScriptParam0], a
    call GreatLogFieldEvents_ReadBank16TableWord
    or a
    ret nz

.check_temp3:
    ldh a, [hTemp3]
    or a
    jr nz, .call_great_log_field_events_set_temp2
    ldh a, [hTemp2]
    cp $65
    jr nc, .call_great_log_field_events_set_temp2
    or a
    jr z, .call_great_log_field_events_set_temp2
    ld a, $04
    ld [wScriptParam0], a
    call GreatLogFieldEvents_ReadBank16TableWord
    or a
    ret nz

.call_great_log_field_events_set_temp2:
    call GreatLogFieldEvents_SetTemp2
    ldh a, [hTemp3]
    or a
    jr nz, .set_script_param0_to_03
    ldh a, [hTemp2]
    cp $65
    jr c, .check_temp32

.set_script_param0_to_03:
    ld a, $03
    ld [wScriptParam0], a
    call GreatLogFieldEvents_ReadBank16TableWord
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
    call GreatLogFieldEvents_ReadBank16TableWord
    or a
    ret nz

.set_script_param0_to_01:
    ld a, $01
    ld [wScriptParam0], a
    ret

; Copies L to hTemp2; copies H to hTemp3; sets rRAMG to $0a; branches on wPartyCount; calls
; LoadSRAMRecordWord; copies L to hTemp2; copies H to hTemp3; calls LoadSRAMRecordWord; sets hTemp2;
; sets hTemp3; sets rRAMG to 0 (E-0347)
GreatLogFieldEvents_SetTemp2::
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

; Copies L to hTemp2; copies H to hTemp3; sets rRAMG to $0a; branches on wPartyCount; calls
; LoadSRAMRecordWord; copies L to hTemp2; copies H to hTemp3; calls LoadSRAMRecordWord; sets hTemp2;
; sets hTemp3; sets rRAMG to 0 (E-0347)
GreatLogFieldEvents_LoadSRAMRecordWord::
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

; Calls ReadBank16TableWord; branches on wGoldHi; branches on wGoldMid; branches on wGoldLo (E-0347)
GreatLogFieldEvents_ReadBank16TableWord::
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

; step 2 of GreatLogFieldEvents_MajorFacilities: advances wScriptStep; sets wBattleIntroKind to 6;
; sets wBattleTransitionSubStep to 1; sets wModeState to 3; sets wBattleTransitionStep to 0; sets
; wFieldReturnPhase to 2; calls SaveScreenBufferToBGMap1; calls
; PickRandomEncounterCountdownFromTable (E-0347)
GreatLogFieldEvents_MajorFacilities_SaveScreenBufferToBGMap1::
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

; implements script command type CB (SCRIPT_SCENE_CHEST_BATTLE): a cutscene step named after the
; scene its only script shows: '0 checked the treasure chest.' (key entry mark and encounter);
; reached through ScriptCommandCB in bank $10 (E-0038, E-0245)
SceneChestBattle::
    ld a, [wScriptStep]
    jumptable
    dw SceneChestBattle_ToSceneChestBattle_StartMessageHL_B73b
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw SceneChestBattle_StartScriptedEncounterTemp0
    dw SceneChestBattle_ToSceneChestBattle_StartMessageHL_B73b_2
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw SceneChestBattle_WriteTemp0AndScriptStep
    dw SceneChestBattle_ScriptStepBlinkObjectTemp0
    dw SceneChestBattle_SetFlagBit
    dw SceneChestBattle_SetBit2AtHL_B73
    dw SceneChestBattle_ClearBit2AtHL_Bank73
    dw SceneChestBattle_SetFlagBit

; step 9 of SceneChestBattle: increments wScriptParam0; returns unless wScriptParam0 is $10; calls
; ClearBit2AtHL_Bank73; advances wScriptStep (E-0347)
SceneChestBattle_ClearBit2AtHL_Bank73::
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

; step 7 of SceneChestBattle: calls SetFlagBit; sets wScriptStartRequest to $80 (E-0347)
SceneChestBattle_SetFlagBit::
    ldh a, [hMapId]
    sub $c8
    add a
    ld hl, SceneChestBattle_SetFlagBit_Data
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; data read by SceneChestBattle (54 bytes) (E-0347)
SceneChestBattle_SetFlagBit_Data::
    db $00, $00, $00, $00, $d4, $01, $d9, $01, $dd, $01, $6a, $01, $6e, $01, $00, $00
    db $00, $00, $00, $00, $00, $00, $74, $01, $78, $01, $7c, $01, $d5, $00, $d9, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $df, $00, $f8, $00, $fc, $00, $f2, $01
    db $f6, $01, $00, $00, $00, $00

; step 6 of SceneChestBattle: sets hTemp0 to 0; sets hTemp1 to $30; calls
; ScriptStepBlinkObjectTemp0; returns if hTemp0 is 0; sets wSpriteSlotCount to 0; advances
; wScriptStep (E-0347)
SceneChestBattle_ScriptStepBlinkObjectTemp0::
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

; step 5 of SceneChestBattle: branches on hMapId; advances wScriptStep; sets hTemp0 to $0a; calls
; MarkKeyEntryKindTemp0Bit6; sets EVENT_SCENE_CHEST_BATTLE; sets hTemp0 to $0b; calls
; MarkKeyEntryKindTemp0Bit6; sets EVENT_SCENE_CHEST_BATTLE_207; sets hTemp0 to $0c; calls
; MarkKeyEntryKindTemp0Bit6; sets EVENT_SCENE_CHEST_BATTLE_208; sets wScriptStep to 8 (E-0347)
SceneChestBattle_WriteTemp0AndScriptStep::
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

; step 3 of SceneChestBattle: calls SceneChestBattle_StartMessageHL_B73b (E-0347)
SceneChestBattle_ToSceneChestBattle_StartMessageHL_B73b_2::
    ld de, SceneChestBattle_ToSceneChestBattle_StartMessageHL_B73b_Data
    call SceneChestBattle_StartMessageHL_B73b
    ret

; step 2 of SceneChestBattle: copies the byte at SceneChestBattle_StartScriptedEncounterTemp0_Data
; to hTemp0; calls StartScriptedEncounterTemp0; advances wScriptStep (E-0347)
SceneChestBattle_StartScriptedEncounterTemp0::
    ldh a, [hMapId]
    sub $c8
    ld de, SceneChestBattle_StartScriptedEncounterTemp0_Data
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

; data read by SceneChestBattle (27 bytes) (E-0347)
SceneChestBattle_StartScriptedEncounterTemp0_Data::
    db $00, $00, $20, $21, $22, $23, $24, $00, $00, $00, $00, $25, $26, $27, $28, $29
    db $00, $00, $00, $00, $2a, $2b, $2c, $2d, $2e, $00, $00

; step 0 of SceneChestBattle: calls SceneChestBattle_StartMessageHL_B73b (E-0347)
SceneChestBattle_ToSceneChestBattle_StartMessageHL_B73b::
    ld de, SceneChestBattle_ToSceneChestBattle_StartMessageHL_B73b_MapMessageTable
    call SceneChestBattle_StartMessageHL_B73b
    ret

; Calls StartMessageHL_B73b; advances wScriptStep (E-0347)
SceneChestBattle_StartMessageHL_B73b::
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

; SceneChestBattle_ToSceneChestBattle_StartMessageHL_B73b passes $530C to
; SceneChestBattle_StartMessageHL_B73b, which reads the word at DE + 2 * (hMapId - $C8) and starts
; that message (StartMessageHL_B73b); 54 words, one per map from $C8 (id = map number); the table
; ends at KeyBossBeaten2 (E-0214, C1)
; record: message word ($0000 = none)
SceneChestBattle_ToSceneChestBattle_StartMessageHL_B73b_MapMessageTable::
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
SceneChestBattle_ToSceneChestBattle_StartMessageHL_B73b_Data::
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

; implements script command type C9 (SCRIPT_SCENE_MILAYOU_FOREST): a cutscene step named after the
; scene its only script shows: 'Milayou I thought this forest looked...'; reached through
; ScriptCommandC9 in bank $10 (E-0038, E-0245)
SceneMilayouForest::
    ld a, [wScriptStep]
    jumptable
    dw SceneChestBattle_SetBit2AtHL_B73
    dw SceneMilayouForest_ClearBit2AtHL_Bank73

; step 1 of SceneMilayouForest: increments wScriptParam0; returns unless wScriptParam0 is $10; calls
; ClearBit2AtHL_Bank73; sets wScriptStartRequest to $80 (E-0347)
SceneMilayouForest_ClearBit2AtHL_Bank73::
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

; step 8 of SceneChestBattle: calls SetBit2AtHL_B73; advances wScriptStep; branches on hPlayerX;
; branches on hPlayerY; branches on the byte at wFollowerRecords + $1; sets wScriptParam1 to $ff;
; sets wScriptParam1 to 1 (E-0347)
SceneChestBattle_SetBit2AtHL_B73::
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

; implements script command type C5 (SCRIPT_SCENE_WIZSTONE): a cutscene step named after the scene
; its only script shows: 'Kiral This stone, the WizStone, it...'; reached through ScriptCommandC5 in
; bank $10 (E-0038, E-0245)
SceneWizstone::
    ld a, [wScriptStep]
    jumptable
    dw SceneWizstone_WriteSpriteSlotsAndScriptStep
    dw SceneWizstone_StepObjectTowardCoord
    dw SceneWizstone_Msg0780_ProfessorKiralUsedThe
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw SceneWizstone_AdvanceScriptStep
    dw SceneWizstone_Msg0781_KiralYesYesSuccess
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw SceneWizstone_StepObjectTowardCoord_SetStepPtrHi
    dw SceneWizstone_Msg0782_HeroReceivedTheSmartBook
    dw SceneWizstone_RunMessageBoxFar_Bank73

; step 8 of SceneWizstone: shows '0 received the SmartBook.'; advances wScriptStep (E-0347)
SceneWizstone_Msg0782_HeroReceivedTheSmartBook::
    ld hl, $0782 ; '0 received the SmartBook.'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; step 7 of SceneWizstone: sets wStepPtrHi to 0; sets wStepTarget to 0; sets wStepPtrLo to $40;
; calls StepObjectTowardCoord; sets wStepPtrHi to 0; sets wStepTarget to 3; sets wStepPtrLo to $10;
; calls StepObjectTowardCoord; returns if wStepArrived is 0; advances wScriptStep (E-0347)
SceneWizstone_StepObjectTowardCoord_SetStepPtrHi::
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

; step 5 of SceneWizstone: shows 'Kiral: Yes! Yes! Success! I owe'; advances wScriptStep (E-0347)
SceneWizstone_Msg0781_KiralYesYesSuccess::
    ld hl, $0781 ; 'Kiral: Yes! Yes! Success! I owe'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; step 4 of SceneWizstone: advances wScriptStep (E-0347)
SceneWizstone_AdvanceScriptStep::
    ld hl, wScriptStep
    inc [hl]
    ret

; step 2 of SceneWizstone: shows 'Professor Kiral used the WizStone on'; advances wScriptStep
; (E-0347)
SceneWizstone_Msg0780_ProfessorKiralUsedThe::
    ld hl, $0780 ; 'Professor Kiral used the WizStone on'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; step 1 of SceneWizstone: sets wStepPtrHi to 0; sets wStepTarget to 1; sets wStepPtrLo to $50;
; calls StepObjectTowardCoord; sets wStepPtrHi to 0; sets wStepTarget to 2; sets wStepPtrLo to $30;
; calls StepObjectTowardCoord; returns if wStepArrived is 0; advances wScriptStep (E-0347)
SceneWizstone_StepObjectTowardCoord::
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

; step 0 of SceneWizstone: branches on hPlayerX; branches on hPlayerY; branches on wPartyCount;
; branches on the byte at wFollowerRecords + $1; sets wScriptStep to 2; advances wScriptStep
; (E-0347)
SceneWizstone_WriteSpriteSlotsAndScriptStep::
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

; implements script command type CC (SCRIPT_SCENE_CYAL_SHINE): a cutscene step named after the scene
; its only script shows: ... 'So Cyal took a shine to...'; reached through ScriptCommandCC in bank
; $10 (E-0038, E-0245)
SceneCyalShine::
    ld a, [wScriptStep]
    jumptable
    dw SceneCyalShine_RunFieldCommandTemp0AndStep
    dw SceneCyalShine_StepScriptParam0Counter_Bank73

; step 1 of SceneCyalShine: calls StepScriptParam0Counter_Bank73; may return early; sets wObject5 to
; 0; sets wScriptStartRequest to $80 (E-0347)
SceneCyalShine_StepScriptParam0Counter_Bank73::
    ld b, $3c
    call StepScriptParam0Counter_Bank73
    ret nc
    xor a
    ld [wObject5], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 0 of SceneCyalShine: sets hTemp0 to 5; calls RunFieldCommandTemp0; sets wObject5 +
; SCRIPTOBJ_X to $40; sets wObject5 + SCRIPTOBJ_Y to $20; advances wScriptStep (E-0347)
SceneCyalShine_RunFieldCommandTemp0AndStep::
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

; implements script command type C1 (SCRIPT_SCENE_TOO_STRONG): a cutscene step named after the scene
; its only script shows: 'Too strong Arroooh!' ... 'Rolt What? Cyal was abducted?'; reached through
; ScriptCommandC1 in bank $10 (E-0038, E-0245)
SceneTooStrong::
    ld a, [wScriptStep]
    jumptable
    dw SceneTooStrong_ScriptStepBlinkObjectTemp0
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw SceneTooStrong_SetBit2AtHL_B73
    dw SceneTooStrong_WriteMessageIndexAndMessageGroupEtc

; step 3 of SceneTooStrong: copies L to wMessageIndex; copies H to wMessageGroup; sets wObject1 +
; OBJ_Y; sets wStepPtrHi to 0; sets wStepTarget to 1; sets wStepPtrLo to $c0; calls
; StepObjectTowardCoord; sets wStepPtrHi to 1; sets wStepTarget to 1; sets wStepPtrLo to $c0; calls
; StepObjectTowardCoord; returns if wStepArrived is 0; then 1 more step (see the code) (E-0347)
SceneTooStrong_WriteMessageIndexAndMessageGroupEtc::
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

; step 2 of SceneTooStrong: calls SetBit2AtHL_B73; sets wObject1 + OBJ_STATE to 1; branches on
; wObject1 + OBJ_X; increments wObject1 + OBJ_X; calls ClearBit2AtHL_Bank73; copies L to
; wMessageIndex; copies H to wMessageGroup; advances wScriptStep (E-0347)
SceneTooStrong_SetBit2AtHL_B73::
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

; step 0 of SceneTooStrong: sets hTemp0 to 2; sets hTemp1 to $40; calls ScriptStepBlinkObjectTemp0;
; branches on wObject2 + OBJ_Y; sets wObject3 + OBJ_Y to $30; returns if hTemp0 is 0; decrements
; wSpriteSlotCount; sets wObject1 + OBJ_STATE to 0; shows 'Tch, I can't enjoy my'; advances
; wScriptStep (E-0347)
SceneTooStrong_ScriptStepBlinkObjectTemp0::
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

; implements script command type C0 (SCRIPT_SCENE_ROLT_ELDER): a cutscene step named after the scene
; its only script shows: 'I'm the village's elder.' ... 'Rolt That was fast, 0.'; reached through
; ScriptCommandC0 in bank $10 (E-0038, E-0245)
SceneRoltElder::
    ld a, [wScriptStep]
    jumptable
    dw SceneRoltElder_SetBit2AtHL_B73
    dw SceneRoltElder_WriteObject1AndObject2
    dw SceneRoltElder_WriteObject2AndObject1
    dw SceneRoltElder_ClearBit2AtHL_Bank73

; step 3 of SceneRoltElder: decrements wObject2 + OBJ_Y; decrements wObject1 + OBJ_Y; returns unless
; wObject1 + OBJ_Y is $50; calls ClearBit2AtHL_Bank73; sets wScriptStartRequest to $80 (E-0347)
SceneRoltElder_ClearBit2AtHL_Bank73::
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

; step 2 of SceneRoltElder: increments wObject2 + OBJ_X; increments wObject1 + OBJ_X; returns unless
; wObject1 + OBJ_X is $60; sets wObject1 + OBJ_STATE to 2; sets wObject2 + OBJ_STATE to 2; advances
; wScriptStep (E-0347)
SceneRoltElder_WriteObject2AndObject1::
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

; step 1 of SceneRoltElder: increments wObject1 + OBJ_X; decrements wObject2 + OBJ_Y; returns unless
; wObject2 + OBJ_Y is $60; sets wObject2 + OBJ_STATE to 1; advances wScriptStep (E-0347)
SceneRoltElder_WriteObject1AndObject2::
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

; step 0 of SceneRoltElder: calls SetBit2AtHL_B73; decrements wObject2 + OBJ_Y; decrements wObject1
; + OBJ_Y; returns unless wObject1 + OBJ_Y is $60; sets wObject1 + OBJ_STATE to 1; advances
; wScriptStep (E-0347)
SceneRoltElder_SetBit2AtHL_B73::
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

; implements script command type 64 (SCRIPT_GATHER_FOLLOWERS): moves the followers onto the leader
; (ScriptStepMoveFollowersToLeader); reached through ScriptCommand64 in bank $10 (E-0038, E-0245)
GatherFollowers::
    ld a, [wScriptStep]
    jumptable
    dw GatherFollowers_ScriptStepMoveFollowersToLeader
    dw GatherFollowers_ScriptStepMoveFollowersToLeader
    dw GatherFollowers_ScriptStepMoveFollowersToLeader
    dw GatherFollowers_SetScriptStartRequestTo80

; step 3 of GatherFollowers: sets wScriptStartRequest to $80 (E-0347)
GatherFollowers_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

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

; implements script command type 61 (SCRIPT_SCENE_KAMEHA_STOLE): a cutscene step named after the
; scene its only script shows: 'King Kameha made off with the...'; reached through ScriptCommand61
; in bank $10 (E-0038, E-0245)
SceneKamehaStole::
    ld a, [wScriptStep]
    jumptable
    dw SceneKamehaStole_ToScriptStepMoveFollowersToLeader
    dw SceneKamehaStole_ToScriptStepMoveFollowersToLeader
    dw SceneKamehaStole_ToScriptStepMoveFollowersToLeader
    dw SceneKamehaStole_WriteFollowerRecordsAndScriptStep
    dw SceneKamehaStole_WriteFollowerRecordsAndScriptStep_2
    dw SceneKamehaStole_WriteFollowerRecords
    dw SceneKamehaStole_WriteFollowerDelayAndMapSpriteKindEtc

; step 6 of SceneKamehaStole: sets wScreenTileBuffer + $a8 to $2b; sets wScreenTileBuffer + $a8 to
; $2c; sets wScreenTileBuffer + $bc to $2d; sets wScreenTileBuffer + $bc to $2e; sets
; wScreenTileBuffer + $ce to $2b; sets wScreenTileBuffer + $ce to $2c; sets wScreenTileBuffer + $e2
; to $2d; sets wScreenTileBuffer + $e2 to $2e; sets wScreenTileBuffer + $f8 to $2b; sets
; wScreenTileBuffer + $f8 to $2c; sets wScreenTileBuffer + $10c to $2d; sets wScreenTileBuffer +
; $10c to $2e; then 4 more steps (see the code) (E-0347)
SceneKamehaStole_WriteFollowerDelayAndMapSpriteKindEtc::
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

; step 5 of SceneKamehaStole: increments wFollowerRecords + $c; may return early; advances
; wScriptStep (E-0347)
SceneKamehaStole_WriteFollowerRecords::
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

; step 4 of SceneKamehaStole: may return early; advances wScriptStep; may return early; sets
; wScriptStep to 6 (E-0347)
SceneKamehaStole_WriteFollowerRecordsAndScriptStep_2::
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

; step 3 of SceneKamehaStole: sets wFollowerRecords to 2; sets wFollowerRecords to 3; may return
; early; sets wFollowerRecords to 0; advances wScriptStep; may return early; sets wScriptStep to 6
; (E-0347)
SceneKamehaStole_WriteFollowerRecordsAndScriptStep::
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

; step 0 of SceneKamehaStole: calls ScriptStepMoveFollowersToLeader (E-0347)
SceneKamehaStole_ToScriptStepMoveFollowersToLeader::
    farcall ScriptStepMoveFollowersToLeader
    ret

; implements script command type 60; reached through ScriptCommand60 in bank $10 (E-0038)
ScriptCommand60_Run::
    ld a, [wScriptStep]
    jumptable
    dw ScriptCommand60_Run_RunFieldCommandTemp0
    dw ScriptCommand60_Run_ScriptApplyStepDeltaAtDE_Bank73
    dw ScriptCommand60_Run_AddStepDeltaToPointedByte
    dw ScriptCommand60_Run_StepScriptParam0Counter_Bank73
    dw ScriptCommand60_Run_ScriptApplyStepDeltaAtDE_Bank73_FindTemp0InInventoryList

; step 4 of ScriptCommand60_Run: increments wObject5 + SCRIPTOBJ_X; increments wObject5 +
; SCRIPTOBJ_Y; calls ScriptApplyStepDeltaAtDE_Bank73; may return early; sets wObject5 to 0; sets
; hTemp0 to $2c; calls FindTemp0InInventoryList; calls RemoveInventorySlotShiftDown; sets
; wScriptStartRequest to $80 (E-0347)
ScriptCommand60_Run_ScriptApplyStepDeltaAtDE_Bank73_FindTemp0InInventoryList::
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

; step 3 of ScriptCommand60_Run: calls StepScriptParam0Counter_Bank73; may return early; advances
; wScriptStep (E-0347)
ScriptCommand60_Run_StepScriptParam0Counter_Bank73::
    ld b, $5a
    call StepScriptParam0Counter_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 2 of ScriptCommand60_Run: copies E to wStepPtrLo; copies D to wStepPtrHi; calls
; AddStepDeltaToPointedByte; increments wScriptParam0; returns unless wScriptParam0 is $20; sets
; wScriptParam0 to 0; advances wScriptStep (E-0347)
ScriptCommand60_Run_AddStepDeltaToPointedByte::
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

; step 0 of ScriptCommand60_Run: sets hTemp0 to $10; calls RunFieldCommandTemp0; sets wObject5 +
; SCRIPTOBJ_X to $50; sets wObject5 + SCRIPTOBJ_Y to $30; sets wObject5 to $80; advances wScriptStep
; (E-0347)
ScriptCommand60_Run_RunFieldCommandTemp0::
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

; implements script command type 59 (also 5A); reached through ScriptCommand59 in bank $10 (E-0038)
SceneSawKameha::
    ld a, [wScriptStep]
    jumptable
    dw SceneSawKameha_StepObjectTowardCoord
    dw SceneSawKameha_ClearBit2AtHL_Bank73
    dw SceneSawKameha_CountKeysOrFull

; step 2 of SceneSawKameha: calls CountKeysOrFull; sets hTemp1 to 5; calls WriteKeyEntryTemp0; sets
; wInventorySortFlags; sets wScriptStartRequest to $80 (E-0347)
SceneSawKameha_CountKeysOrFull::
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

; step 1 of SceneSawKameha: decrements wFollowerRecords + $2; decrements wFollowerRecords + $7;
; decrements wFollowerRecords + $c; decrements hPlayerY; returns unless hPlayerY is $c0; calls
; ClearBit2AtHL_Bank73; sets hMapId to $19; sets hMapScreenX to 0; sets hMapScreenY to 0; sets
; wWarpDestX to $40; sets wWarpDestY to $40; sets wFieldTransitionKind to 3; then 1 more step (see
; the code) (E-0347)
SceneSawKameha_ClearBit2AtHL_Bank73::
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

; step 0 of SceneSawKameha: sets wStepPtrHi to 0; sets wStepTarget to 2; sets wStepPtrLo to $b0;
; calls StepObjectTowardCoord; sets wStepPtrLo to 0; calls StepPlayerUpTowardStepPtrLo; returns if
; wStepArrived is 0; calls SetBit2AtHL_B73; advances wScriptStep (E-0347)
SceneSawKameha_StepObjectTowardCoord::
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

; implements script command type 57 (SCRIPT_SCENE_THREE_ITEMS_BATTLE): a cutscene step named after
; the scene its only script shows: 'Good. You have brought the three...' ... 'Don't you ever give
; up?' (encounter); reached through ScriptCommand57 in bank $10 (E-0038, E-0245)
SceneThreeItemsBattle::
    ld a, [wScriptStep]
    jumptable
    dw SceneThreeItemsBattle_StartScriptedEncounterTemp0AndStep
    dw SceneThreeItemsBattle_Msg0480_GwaahYouveBeatenMe
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw SceneThreeItemsBattle_ScriptStepBlinkObjectTemp0

; step 3 of SceneThreeItemsBattle: sets hTemp0 to 0; sets hTemp1 to $20; calls
; ScriptStepBlinkObjectTemp0; returns if hTemp0 is 0; sets wSpriteSlotCount to 0; sets
; wScriptStartRequest to $80 (E-0347)
SceneThreeItemsBattle_ScriptStepBlinkObjectTemp0::
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

; step 1 of SceneThreeItemsBattle: shows 'Gwaah! You've beaten me fairly!'; advances wScriptStep
; (E-0347)
SceneThreeItemsBattle_Msg0480_GwaahYouveBeatenMe::
    ld hl, $0480 ; '*: Gwaah! You've beaten me fairly!'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; step 0 of SceneThreeItemsBattle: sets hTemp0 to $1c; calls StartScriptedEncounterTemp0; advances
; wScriptStep (E-0347)
SceneThreeItemsBattle_StartScriptedEncounterTemp0AndStep::
    ld a, $1c
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

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

; implements script command type 55 (SCRIPT_SET_FLAG_322): sets story flag $322 (wStoryFlags + $64
; bit 2); 'A door opened somewhere'; reached through ScriptCommand55 in bank $10 (E-0038, E-0245)
SetFlag322::
    ld a, [wStoryFlags + $64]
    set 2, a
    ld [wStoryFlags + $64], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 54 (SCRIPT_SCENE_GRAVESTONE): a cutscene step named after the scene
; its only script shows: before '0 checked the gravestone.'; reached through ScriptCommand54 in bank
; $10 (E-0038, E-0245)
SceneGravestone::
    ld a, [wScriptStep]
    jumptable
    dw SceneGravestone_SetBit2AtHL_B73
    dw SceneGravestone_WriteScriptStartRequest
    dw ScriptStepMoveObjectCB8AByDirection
    dw SceneGravestone_StepObjectTowardCoord
    dw SceneGravestone_ScriptStepBlinkObjectTemp0

; step 4 of SceneGravestone: sets hTemp0 to 0; sets hTemp1 to $20; calls ScriptStepBlinkObjectTemp0;
; returns if hTemp0 is 0; sets wSpriteSlotCount to 0; plays sound $66; sets wScreenTileBuffer + $2
; to $56; sets wScreenTileBuffer + $2 to $57; sets wScreenTileBuffer + $2 to $58; sets
; wScreenTileBuffer + $2 to $59; sets wScreenTileBuffer + $2 to $5a; sets wScreenTileBuffer + $2 to
; $5b; then 3 more steps (see the code) (E-0347)
SceneGravestone_ScriptStepBlinkObjectTemp0::
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

; step 3 of SceneGravestone: sets wStepPtrHi to 0; sets wStepTarget to 2; sets wStepPtrLo to $20;
; calls StepObjectTowardCoord; returns if wStepArrived is 0; advances wScriptStep (E-0347)
SceneGravestone_StepObjectTowardCoord::
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

; moves wSpriteSlots + $B/wSpriteSlots + $C one pixel in direction wScriptParam1 for 16 frames; at
; ($80, $30) advances wScriptStep, otherwise repeats the step (E-0125)
ScriptStepMoveObjectCB8AByDirection::
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

; step 1 of SceneGravestone: branches on wMaxBlockingTile; calls
; ScriptStepMoveObjectCB8AByDirection; advances wScriptStep; calls ClearBit2AtHL_Bank73; sets
; wScriptStartRequest to $80 (E-0347)
SceneGravestone_WriteScriptStartRequest::
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
    call ScriptStepMoveObjectCB8AByDirection
    ld hl, wScriptStep
    inc [hl]
    ret

.call_clear_bit2_at_hl_bank73:
    ld hl, wSpriteSlots + $d
    call ClearBit2AtHL_Bank73
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 0 of SceneGravestone: copies the byte at SceneGravestone_SetBit2AtHL_B73_Data to
; wScriptParam1; copies the byte at SceneGravestone_SetBit2AtHL_B73_Data to wMessageIndex; copies
; the byte at SceneGravestone_SetBit2AtHL_B73_Data to wMessageGroup; calls SetBit2AtHL_B73; advances
; wScriptStep (E-0347)
SceneGravestone_SetBit2AtHL_B73::
    ldh a, [hPlayerX]
    swap a
    and $0f
    sub $05
    and $03
    sla a
    sla a
    ld hl, SceneGravestone_SetBit2AtHL_B73_Data
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

; data read by SceneGravestone (16 bytes) (E-0347)
SceneGravestone_SetBit2AtHL_B73_Data::
    db $03, $f0, $00, $00, $02, $00, $f0, $00, $00, $00, $10, $00, $01, $10, $00, $00

; implements script command type 53 (SCRIPT_SCENE_JUSTICE): a cutscene step named after the scene
; its only script shows: 'Let the power of justice smite...' ... '0 checked the gravestone.';
; reached through ScriptCommand53 in bank $10 (E-0038, E-0245)
SceneJustice::
    ldh a, [hPlayerX]
    cp $30
    jr nz, .check_player_y
    ldh a, [hPlayerY]
    cp $30
    jr nz, .call_scene_justice_step_wrap_position_2
    ld hl, wScreenTileBuffer + $52
    call SceneJustice_StepWrapPosition_2
    ld hl, wScreenTileBuffer + $f2
    call SceneJustice_StepWrapPosition_2
    ld hl, wScreenTileBuffer + $100
    call SceneJustice_StepWrapPosition_2
    jr .check_screen_tile_buffer

.call_scene_justice_step_wrap_position_2:
    ld hl, wScreenTileBuffer + $f2
    call SceneJustice_StepWrapPosition_2
    ld hl, wScreenTileBuffer + $100
    call SceneJustice_StepWrapPosition_2
    jr .check_screen_tile_buffer

.check_player_y:
    ldh a, [hPlayerY]
    cp $30
    jr nz, .call_scene_justice_step_wrap_position_22
    ld hl, wScreenTileBuffer + $60
    call SceneJustice_StepWrapPosition_2
    ld hl, wScreenTileBuffer + $f2
    call SceneJustice_StepWrapPosition_2
    jr .check_screen_tile_buffer

.call_scene_justice_step_wrap_position_22:
    ld hl, wScreenTileBuffer + $60
    call SceneJustice_StepWrapPosition_2
    ld hl, wScreenTileBuffer + $100
    call SceneJustice_StepWrapPosition_2

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

; called from SceneJustice: calls SceneJustice_StepWrapPosition; returns if wIsCGB is 0; sets rSVBK
; to 2; calls SceneJustice_SetPosition; sets rSVBK to 0 (E-0347)
SceneJustice_StepWrapPosition_2::
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

; adds 8 to two position bytes, wrapping each below $28, and reads the byte $14 on (E-0305)
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

; stores C to two position bytes and reads the byte $14 on (E-0305)
SceneJustice_SetPosition::
    ld a, c
    ld [hli], a
    ld [hld], a
    ld a, $14
    add_a_to_hl
    ld a, [hl]
    ret

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

; implements script command type 51 (SCRIPT_SCENE_MADCONDOR_CRY): a cutscene step named after the
; scene its only script shows: 'Kweeeeeh!'; reached through ScriptCommand51 in bank $10 (E-0038,
; E-0245)
SceneMadcondorCry::
    ld a, [wScriptStep]
    jumptable
    dw SceneMadcondorCry_StepScriptParam0Counter_Bank73
    dw SceneMadcondorCry_WriteScriptParam0
    dw SceneMadcondorCry_WritePlayerYAndFollowerRecordsEtc
    dw SceneMadcondorCry_ScriptStartFadeAndAdvanceStep
    dw SceneMadcondorCry_Msg0433_Kweeeeeh
    dw SceneWizstone_RunMessageBoxFar_Bank73

; step 4 of SceneMadcondorCry: shows 'Kweeeeeh!'; advances wScriptStep (E-0347)
SceneMadcondorCry_Msg0433_Kweeeeeh::
    ld hl, $0433 ; '*: Kweeeeeh!'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; step 3 of SceneMadcondorCry: sets hMapScreenY to 0; sets wWarpDestX to $40; sets wWarpDestY to
; $30; sets wFieldTransitionKind to 3; calls ScriptStartFadeAndAdvanceStep (E-0347)
SceneMadcondorCry_ScriptStartFadeAndAdvanceStep::
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

; step 2 of SceneMadcondorCry: increments wSpriteSlots + $b; increments wScriptParam0; calls
; SceneMadcondorCry_WriteMessageIndexAndMessageGroupEtc; sets hPlayerY; sets hPlayerX; may return
; early; sets wScriptParam0 to 0; advances wScriptStep (E-0347)
SceneMadcondorCry_WritePlayerYAndFollowerRecordsEtc::
    ld hl, wSpriteSlots + $b
    inc [hl]
    ld a, [wScriptParam0]
    and $01
    jr nz, .call_scene_madcondor_cry_write_message_index
    ld hl, wSpriteSlots + $b
    inc [hl]

.call_scene_madcondor_cry_write_message_index:
    ld hl, wScriptParam0
    inc [hl]
    call SceneMadcondorCry_WriteMessageIndexAndMessageGroupEtc
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

; step 1 of SceneMadcondorCry: increments wSpriteSlots + $b; increments wScriptParam0; calls
; SceneMadcondorCry_WriteMessageIndexAndMessageGroupEtc; may return early; sets wScriptParam0 to 0;
; advances wScriptStep (E-0347)
SceneMadcondorCry_WriteScriptParam0::
    ld hl, wSpriteSlots + $b
    inc [hl]
    ld a, [wScriptParam0]
    and $01
    jr nz, .call_scene_madcondor_cry_write_message_index
    ld hl, wSpriteSlots + $b
    inc [hl]

.call_scene_madcondor_cry_write_message_index:
    ld hl, wScriptParam0
    inc [hl]
    call SceneMadcondorCry_WriteMessageIndexAndMessageGroupEtc
    cp $70
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Copies L to wMessageIndex; copies H to wMessageGroup (E-0347)
SceneMadcondorCry_WriteMessageIndexAndMessageGroupEtc::
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

; step 0 of SceneMadcondorCry: calls StepScriptParam0Counter_Bank73; may return early; calls
; SetBit2AtHL_B73; copies L to wMessageIndex; copies H to wMessageGroup; advances wScriptStep
; (E-0347)
SceneMadcondorCry_StepScriptParam0Counter_Bank73::
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

; implements script command type 50 (SCRIPT_SCENE_MADCONDOR): a cutscene step named after the scene
; its only script shows: 'Look! A MadCondor! It has something!'; reached through ScriptCommand50 in
; bank $10 (E-0038, E-0245)
SceneMadcondor::
    ld a, [wScriptStep]
    jumptable
    dw SceneMadcondor_StepScriptParam0Counter_Bank73
    dw SceneMadcondor_WriteScriptParam0
    dw SceneMadcondor_WriteObject1AndScriptStartRequest

; step 2 of SceneMadcondor: decrements wSpriteSlots + $b; increments wScriptParam0; calls
; SceneMadcondor_WriteMessageIndexAndMessageGroupEtc; sets wObject1 + OBJ_Y; sets wObject1 + OBJ_X;
; may return early; sets wScriptStartRequest to $80 (E-0347)
SceneMadcondor_WriteObject1AndScriptStartRequest::
    ld hl, wSpriteSlots + $b
    dec [hl]
    ld hl, wScriptParam0
    inc [hl]
    call SceneMadcondor_WriteMessageIndexAndMessageGroupEtc
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

; step 1 of SceneMadcondor: decrements wSpriteSlots + $b; increments wScriptParam0; calls
; SceneMadcondor_WriteMessageIndexAndMessageGroupEtc; may return early; sets wScriptParam0 to 0;
; advances wScriptStep (E-0347)
SceneMadcondor_WriteScriptParam0::
    ld hl, wSpriteSlots + $b
    dec [hl]
    ld hl, wScriptParam0
    inc [hl]
    call SceneMadcondor_WriteMessageIndexAndMessageGroupEtc
    ld a, [wSpriteSlots + $b]
    cp $40
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Copies L to wMessageIndex; copies H to wMessageGroup (E-0347)
SceneMadcondor_WriteMessageIndexAndMessageGroupEtc::
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

; step 0 of SceneMadcondor: calls StepScriptParam0Counter_Bank73; may return early; calls
; SetBit2AtHL_B73; copies L to wMessageIndex; copies H to wMessageGroup; advances wScriptStep
; (E-0347)
SceneMadcondor_StepScriptParam0Counter_Bank73::
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

; implements script command type 4C; reached through ScriptCommand4C in bank $10 (E-0038)
ScriptCommand4C_Run::
    ld a, [wScriptStep]
    jumptable
    dw ScriptCommand4C_Run_RunFieldCommandTemp0
    dw ScriptCommand4C_Run_StepScriptParam0Counter_Bank73

; step 1 of ScriptCommand4C_Run: sets wObject5 to $80; decrements wObject5 + SCRIPTOBJ_Y; calls
; StepScriptParam0Counter_Bank73; may return early; sets wObject5 to 0; sets wScriptStartRequest to
; $80 (E-0347)
ScriptCommand4C_Run_StepScriptParam0Counter_Bank73::
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

; step 0 of ScriptCommand4C_Run: sets hTemp0 to $11; calls RunFieldCommandTemp0; checks
; EVENT_SCENE_DARCK_DEFEATED; branches on the byte at
; ScriptCommand4C_Run_RunFieldCommandTemp0_Data2; copies the byte at
; ScriptCommand4C_Run_RunFieldCommandTemp0_Data2 & $f0 to wObject5 + SCRIPTOBJ_X; sets wObject5 +
; SCRIPTOBJ_Y; advances wScriptStep (E-0347)
ScriptCommand4C_Run_RunFieldCommandTemp0::
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld hl, ScriptCommand4C_Run_RunFieldCommandTemp0_Data1
    ld de, EVENT_SCENE_DARCK_DEFEATED
    call TestFlagBit
    jr nc, .read_map_id
    ld hl, ScriptCommand4C_Run_RunFieldCommandTemp0_Data2

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

; data read by ScriptCommand4C_Run_RunFieldCommandTemp0 (12 bytes) (E-0347)
ScriptCommand4C_Run_RunFieldCommandTemp0_Data1::
    db $06, $31, $12, $44, $00, $63, $02, $24, $16, $53, $1a, $43

ScriptCommand4C_Run_RunFieldCommandTemp0_Data2::
    db $06, $31, $12, $44, $00, $53, $02, $24, $16, $42, $1a, $43

; implements script command type 47 (SCRIPT_SCENE_SPIRIT_ENVOY_2): a cutscene step named after the
; scene its only script shows: 'Oh? An envoy from the spirit!' ... 'You startled me'; reached
; through ScriptCommand47 in bank $10 (E-0038, E-0245)
SceneSpiritEnvoy2::
    ld a, [wScriptStep]
    jumptable
    dw SceneSpiritEnvoy2_SetBit1AtHL_Bank73
    dw SceneSpiritEnvoy2_ScriptStepBlinkSpritesThenEnd

; step 1 of SceneSpiritEnvoy2: increments wSpriteSlots + $c; calls ScriptStepBlinkSpritesThenEnd
; (E-0347)
SceneSpiritEnvoy2_ScriptStepBlinkSpritesThenEnd::
    ld a, [wScriptParam0]
    and $01
    jr z, .call_script_step_blink_sprites_then_end
    ld hl, wSpriteSlots + $c
    inc [hl]

.call_script_step_blink_sprites_then_end:
    call ScriptStepBlinkSpritesThenEnd
    ret

; step 0 of SceneSpiritEnvoy2: calls SetBit1AtHL_Bank73; calls StepScriptParam0Counter_Bank73; may
; return early; advances wScriptStep; checks EVENT_SCENE_SPIRIT_ENVOY2; sets
; EVENT_SCENE_SPIRIT_ENVOY2; sets EVENT_SCENE_SPIRIT_ENVOY2_099 (E-0347)
SceneSpiritEnvoy2_SetBit1AtHL_Bank73::
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

; implements script command type 44 (SCRIPT_SCENE_REAL_KING): a cutscene step named after the scene
; its only script shows: before 'I'm the real King, you fake!'; reached through ScriptCommand44 in
; bank $10 (E-0038, E-0245)
SceneRealKing::
    ld a, [wScriptStep]
    jumptable
    dw SceneRealKing_RunFieldCommandTemp0
    dw SceneRealKing_QueueSoundEffect
    dw SceneRealKing_StepScriptParam0Counter_Bank73

; step 2 of SceneRealKing: calls StepScriptParam0Counter_Bank73; may return early; sets wObject2 +
; OBJ_Y to $40; sets wObject1 + OBJ_Y to $50; sets wObject5 to 0; sets wSpriteSlotCount to 3; plays
; sound $00; sets wScriptStartRequest to $80 (E-0347)
SceneRealKing_StepScriptParam0Counter_Bank73::
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

; step 1 of SceneRealKing: increments wObject2 + OBJ_Y; decrements wObject1 + OBJ_Y; returns unless
; wObject1 + OBJ_Y is $48; sets wSpriteSlotCount to 0; sets wObject5 to $80; plays sound $7d;
; advances wScriptStep (E-0347)
SceneRealKing_QueueSoundEffect::
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

; step 0 of SceneRealKing: increments wScriptParam0; may return early; decrements wObject2 + OBJ_Y;
; increments wObject1 + OBJ_Y; returns unless wObject1 + OBJ_Y is $58; sets hTemp0 to $0c; calls
; RunFieldCommandTemp0; sets wObject5 + SCRIPTOBJ_X to $40; sets wObject5 + SCRIPTOBJ_Y to $48;
; advances wScriptStep (E-0347)
SceneRealKing_RunFieldCommandTemp0::
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

; implements script command type 3E (SCRIPT_SCENE_STRONGEST_MASTER): a cutscene step named after the
; scene its only script shows: 'The strongest master I've ever...'; reached through ScriptCommand3E
; in bank $10 (E-0038, E-0245)
SceneStrongestMaster::
    ld a, [wScriptStep]
    jumptable
    dw SceneStrongestMaster_SetupScriptSpriteFromMapSpriteKind
    dw SceneStrongestMaster_ToPlaySound83AndAdvanceScriptStep
    dw SceneStrongestMaster_ToScriptStepAnimateSpriteBySteps
    dw SceneStrongestMaster_WriteFieldDrawFlagsAndMapSpriteKindEtc

; step 3 of SceneStrongestMaster: calls DrawFullScreenBufferAtScroll; sets hFieldDrawFlags to 0;
; sets wMapSpriteKind to 0; sets wScriptStartRequest to $80 (E-0347)
SceneStrongestMaster_WriteFieldDrawFlagsAndMapSpriteKindEtc::
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

; step 2 of SceneStrongestMaster: calls ScriptStepAnimateSpriteBySteps (E-0347)
SceneStrongestMaster_ToScriptStepAnimateSpriteBySteps::
    farcall ScriptStepAnimateSpriteBySteps
    ret

; step 1 of SceneStrongestMaster: calls PlaySound83AndAdvanceScriptStep (E-0347)
SceneStrongestMaster_ToPlaySound83AndAdvanceScriptStep::
    farcall PlaySound83AndAdvanceScriptStep
    ret

; step 0 of SceneStrongestMaster: sets wMapSpriteKind to $10; calls
; SetupScriptSpriteFromMapSpriteKind (E-0347)
SceneStrongestMaster_SetupScriptSpriteFromMapSpriteKind::
    ld a, $10
    ld [wMapSpriteKind], a
    farcall SetupScriptSpriteFromMapSpriteKind
    ret

; step 0 of GatherFollowers: sets wMapSpriteKind to $10; calls ScriptStepMoveFollowersToLeader
; (E-0347)
GatherFollowers_ScriptStepMoveFollowersToLeader::
    ld a, $10
    ld [wMapSpriteKind], a
    farcall ScriptStepMoveFollowersToLeader
    ret

; implements script command type 3D (SCRIPT_REWARD_ITEM_OR_KEY_2): the same rewards as
; SCRIPT_REWARD_ITEM_OR_KEY in another scene: 'Fantastic! I can open my shop' ... 'I like you to
; have this.'; reached through ScriptCommand3D in bank $10 (E-0038, E-0245)
RewardItemOrKey2::
    ld a, [wScriptStep]
    jumptable
    dw RewardItemOrKey2_FindPartyIndexOfSpeciesTemp0
    dw RewardItemOrKey2_ReadMessageIndexAndMessageGroup
    dw RewardItemOrKey2_WriteObject3
    dw RewardItemOrKey2_LoadListedRecordNameTilesForTemp0
    dw RewardItemOrKey2_StepScriptParam0Counter_Bank73
    dw RewardItemOrKey2_ShowHuhThereIsSomething
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw RewardItemOrKey2_TestFlagBit
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw RewardItemOrKey2_TestFlagBit_SetScriptStartRequest

; step 9 of RewardItemOrKey2: sets wScriptStartRequest to $80; copies hPlayerFacing & $03 to
; wObject1 + OBJ_STATE; checks EVENT_REWARD_ITEM_OR_KEY; sets wStepPtrLo to $2c; calls
; AppendItemStepPtrLoToInventory; calls CountKeysOrFull; sets hTemp1 to 4; calls WriteKeyEntryTemp0;
; sets wInventorySortFlags; sets EVENT_WARUBOU_WA_HEY_FIND_ANOTHER (E-0347)
RewardItemOrKey2_TestFlagBit_SetScriptStartRequest::
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

; step 7 of RewardItemOrKey2: checks EVENT_REWARD_ITEM_OR_KEY; shows 'What's that? Hey, a Magic';
; sets wObject1 + OBJ_STATE to 0; sets wObject3 + OBJ_STATE to 2; advances wScriptStep (E-0347)
RewardItemOrKey2_TestFlagBit::
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

; step 5 of RewardItemOrKey2: copies wScriptParam0 & $01 to wObject3 + OBJ_STATE; increments
; wScriptParam0; returns unless wScriptParam0 is $78; sets wScriptParam0 to 0; advances wScriptStep;
; shows 'Huh? There is something here.' (E-0347)
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

; step 4 of RewardItemOrKey2: calls StepScriptParam0Counter_Bank73; may return early; advances
; wScriptStep (E-0347)
RewardItemOrKey2_StepScriptParam0Counter_Bank73::
    ld b, $3c
    call StepScriptParam0Counter_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 3 of RewardItemOrKey2: copies L to hTemp0; copies H to hTemp1; calls
; LoadListedRecordNameTilesForTemp0; sets hFieldDrawFlags to 0; sets wScriptParam0 to 0; advances
; wScriptStep (E-0347)
RewardItemOrKey2_LoadListedRecordNameTilesForTemp0::
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

; step 2 of RewardItemOrKey2: sets wObject3 + OBJ_Y to $50; advances wScriptStep (E-0347)
RewardItemOrKey2_WriteObject3::
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

; step 1 of RewardItemOrKey2: advances wScriptStep (E-0347)
RewardItemOrKey2_ReadMessageIndexAndMessageGroup::
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

; step 0 of RewardItemOrKey2: copies L to hTemp0; copies H to hTemp1; calls
; FindPartyIndexOfSpeciesTemp0; copies L to wMessageIndex; copies H to wMessageGroup; copies the
; byte at wFollowerRecords to wSavedPlayerState; advances wScriptStep (E-0347)
RewardItemOrKey2_FindPartyIndexOfSpeciesTemp0::
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

; implements script command type 3C (SCRIPT_REWARD_ITEM_OR_KEY): gives an item or a key entry
; (AppendItemStepPtrLoToInventory, WriteKeyEntryTemp0); 'Great, 0! Thanks a lot!' ... 'Here, 0! You
; hold onto it.'; reached through ScriptCommand3C in bank $10 (E-0038, E-0245)
RewardItemOrKey::
    ld a, [wScriptStep]
    jumptable
    dw RewardItemOrKey_FindPartyIndexOfSpeciesTemp0
    dw RewardItemOrKey_ReadMessageIndexAndMessageGroup
    dw RewardItemOrKey_WriteObject1
    dw RewardItemOrKey_WriteObject1AndScriptStep
    dw RewardItemOrKey_ReadMessageIndexAndMessageGroup_2
    dw RewardItemOrKey_WriteObject1_AdvanceScriptStep_3
    dw RewardItemOrKey_WriteObject1AndScriptStep_SetScriptStep
    dw RewardItemOrKey_ReadMessageIndexAndMessageGroup
    dw RewardItemOrKey_WriteObject1_AdvanceScriptStep_2
    dw RewardItemOrKey_WriteObject1AndScriptStep
    dw RewardItemOrKey_ReadMessageIndexAndMessageGroup_2
    dw RewardItemOrKey_WriteObject1_AdvanceScriptStep
    dw RewardItemOrKey_WriteObject1AndScriptStep_SetScriptStep
    dw RewardItemOrKey_LoadListedRecordNameTilesForTemp0
    dw RewardItemOrKey_StepScriptParam0Counter_Bank73
    dw RewardItemOrKey_ShowOKLetMeDig
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw RewardItemOrKey_TestFlagBit
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw RewardItemOrKey_TestFlagBit_SetScriptStartRequest

; step 19 of RewardItemOrKey: sets wScriptStartRequest to $80; checks EVENT_REWARD_ITEM_OR_KEY_2;
; sets wStepPtrLo to $2c; calls AppendItemStepPtrLoToInventory; calls CountKeysOrFull; sets hTemp1
; to 4; calls WriteKeyEntryTemp0; sets wInventorySortFlags; sets EVENT_WARUBOU_WA_HEY_FIND_ANOTHER
; (E-0347)
RewardItemOrKey_TestFlagBit_SetScriptStartRequest::
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

; step 17 of RewardItemOrKey: checks EVENT_REWARD_ITEM_OR_KEY_2; shows 'What's wrong, MadGopher? Did
; you'; advances wScriptStep; branches on wObject1 + OBJ_X; sets wObject1 + OBJ_STATE to 1; branches
; on $01; sets wObject1 + OBJ_STATE to 3; branches on wObject1 + OBJ_Y; sets wObject1 + OBJ_STATE to
; 0; sets wObject1 + OBJ_STATE to 2 (E-0347)
RewardItemOrKey_TestFlagBit::
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

; step 15 of RewardItemOrKey: copies wScriptParam0 & $01 to wObject1 + OBJ_STATE; increments
; wScriptParam0; returns unless wScriptParam0 is $78; sets wScriptParam0 to 0; advances wScriptStep;
; shows 'OK! Let me dig! One-two,' (E-0347)
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

; step 14 of RewardItemOrKey: calls StepScriptParam0Counter_Bank73; may return early; advances
; wScriptStep (E-0347)
RewardItemOrKey_StepScriptParam0Counter_Bank73::
    ld b, $3c
    call StepScriptParam0Counter_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 13 of RewardItemOrKey: copies L to hTemp0; copies H to hTemp1; calls
; LoadListedRecordNameTilesForTemp0; sets hFieldDrawFlags to 0; sets wObject1 + OBJ_STATE to 0;
; increments wSpriteSlotCount; sets wScriptParam0 to 0; advances wScriptStep (E-0347)
RewardItemOrKey_LoadListedRecordNameTilesForTemp0::
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

; step 11 of RewardItemOrKey: sets wObject1 + OBJ_X to $50; advances wScriptStep; calls
; RewardItemOrKey_DecAndFace3 (E-0347)
RewardItemOrKey_WriteObject1_AdvanceScriptStep::
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

; step 8 of RewardItemOrKey: sets wObject1 + OBJ_Y to $20; advances wScriptStep; calls
; RewardItemOrKey_DecAndFace2 (E-0347)
RewardItemOrKey_WriteObject1_AdvanceScriptStep_2::
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

; step 6 of RewardItemOrKey: sets wObject1 + OBJ_Y to $30; sets wScriptStep to $0d; calls
; RewardItemOrKey_IncAndFace0; calls RewardItemOrKey_DecAndFace2 (E-0347)
RewardItemOrKey_WriteObject1AndScriptStep_SetScriptStep::
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

; step 5 of RewardItemOrKey: sets wObject1 + OBJ_X to $70; advances wScriptStep; calls
; RewardItemOrKey_IncAndFace1 (E-0347)
RewardItemOrKey_WriteObject1_AdvanceScriptStep_3::
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

; step 4 of RewardItemOrKey: advances wScriptStep; calls RewardItemOrKey_IncAndFace0; calls
; RewardItemOrKey_DecAndFace2 (E-0347)
RewardItemOrKey_ReadMessageIndexAndMessageGroup_2::
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

; step 3 of RewardItemOrKey: sets wObject1 + OBJ_X to $60; sets wScriptStep to $0d; calls
; RewardItemOrKey_IncAndFace1; calls RewardItemOrKey_DecAndFace3 (E-0347)
RewardItemOrKey_WriteObject1AndScriptStep::
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

; step 2 of RewardItemOrKey: sets wObject1 + OBJ_Y to $40; advances wScriptStep; calls
; RewardItemOrKey_IncAndFace0 (E-0347)
RewardItemOrKey_WriteObject1::
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

; step 1 of RewardItemOrKey: advances wScriptStep; calls RewardItemOrKey_IncAndFace1; calls
; RewardItemOrKey_DecAndFace3 (E-0347)
RewardItemOrKey_ReadMessageIndexAndMessageGroup::
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

; step 0 of RewardItemOrKey: copies L to hTemp0; copies H to hTemp1; calls
; FindPartyIndexOfSpeciesTemp0; copies L to wMessageIndex; copies H to wMessageGroup; copies the
; byte at wFollowerRecords to wSavedPlayerState; decrements wSpriteSlotCount; branches on
; hPlayerFacing; advances wScriptStep; branches on hPlayerFacing; sets wScriptStep to 4; branches on
; hPlayerFacing; then 2 more steps (see the code) (E-0347)
RewardItemOrKey_FindPartyIndexOfSpeciesTemp0::
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

; increments the position byte and sets the facing two bytes back to 0 (E-0305)
RewardItemOrKey_IncAndFace0::
    inc a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $00
    ret

; decrements the position byte and sets the facing two bytes back to 2 (E-0305)
RewardItemOrKey_DecAndFace2::
    dec a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $02
    ret

; decrements the position byte and sets the facing one byte back to 3 (E-0305)
RewardItemOrKey_DecAndFace3::
    dec a
    ld [hl], a
    dec hl
    ld [hl], $03
    ret

; increments the position byte and sets the facing one byte back to 1 (E-0305)
RewardItemOrKey_IncAndFace1::
    inc a
    ld [hl], a
    dec hl
    ld [hl], $01
    ret

; implements script command type 3A (SCRIPT_SCENE_MASTER_THANKS): a cutscene step named after the
; scene its only script shows: 'R Really? Wow! Thank you!' ... 'I became a master because I...';
; reached through ScriptCommand3A in bank $10 (E-0038, E-0245)
SceneMasterThanks::
    ld a, [wScriptStep]
    jumptable
    dw SceneMasterThanks_FindPartyIndexOfSpeciesTemp0
    dw SceneMasterThanks_WriteScriptStep
    dw SceneMasterThanks_ReadMessageIndexAndMessageGroup
    dw SceneMasterThanks_ReadMessageIndexAndMessageGroup_AdvanceScriptStep_3
    dw SceneMasterThanks_ReadMessageIndexAndMessageGroup_AdvanceScriptStep_2
    dw SceneMasterThanks_WriteSpriteSlotsAndFieldDrawFlagsEtc
    dw SceneMasterThanks_WriteScriptStep_2
    dw SceneMasterThanks_ReadMessageIndexAndMessageGroup_AdvanceScriptStep_3
    dw SceneMasterThanks_ReadMessageIndexAndMessageGroup_AdvanceScriptStep
    dw SceneMasterThanks_WriteSpriteSlotsAndFieldDrawFlags
    dw SceneMasterThanks_LoadListedRecordNameTilesForTemp0
    dw SceneMasterThanks_AddStepDeltaToPointedByte

; step 11 of SceneMasterThanks: copies E to wStepPtrLo; copies D to wStepPtrHi; calls
; AddStepDeltaToPointedByte; increments wScriptParam0; returns unless wScriptParam0 is $20; sets
; wScriptStartRequest to $80 (E-0347)
SceneMasterThanks_AddStepDeltaToPointedByte::
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

; step 10 of SceneMasterThanks: copies L to hTemp0; copies H to hTemp1; calls
; LoadListedRecordNameTilesForTemp0; sets hFieldDrawFlags to 0; advances wScriptStep (E-0347)
SceneMasterThanks_LoadListedRecordNameTilesForTemp0::
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

; step 9 of SceneMasterThanks: sets hFieldDrawFlags to $0e; advances wScriptStep; sets wScriptStep
; to 1; sets wScriptStep to 3 (E-0347)
SceneMasterThanks_WriteSpriteSlotsAndFieldDrawFlags::
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

; step 8 of SceneMasterThanks: advances wScriptStep; sets wScriptStep to 0 (E-0347)
SceneMasterThanks_ReadMessageIndexAndMessageGroup_AdvanceScriptStep::
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

; step 6 of SceneMasterThanks: sets wScriptStep to 7; sets wScriptStep to 8 (E-0347)
SceneMasterThanks_WriteScriptStep_2::
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

; step 5 of SceneMasterThanks: sets hFieldDrawFlags to $0e; sets wScriptStep to $0a (E-0347)
SceneMasterThanks_WriteSpriteSlotsAndFieldDrawFlagsEtc::
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

; step 4 of SceneMasterThanks: advances wScriptStep; sets wScriptStep to 2 (E-0347)
SceneMasterThanks_ReadMessageIndexAndMessageGroup_AdvanceScriptStep_2::
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

; step 3 of SceneMasterThanks: advances wScriptStep; sets wScriptStep to 1 (E-0347)
SceneMasterThanks_ReadMessageIndexAndMessageGroup_AdvanceScriptStep_3::
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

; step 2 of SceneMasterThanks: advances wScriptStep; sets wScriptStep to 2 (E-0347)
SceneMasterThanks_ReadMessageIndexAndMessageGroup::
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

; step 1 of SceneMasterThanks: sets wScriptStep to 2; branches on $02; sets wScriptStep to 3; sets
; wScriptStep to 4 (E-0347)
SceneMasterThanks_WriteScriptStep::
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

; step 0 of SceneMasterThanks: copies L to hTemp0; copies H to hTemp1; calls
; FindPartyIndexOfSpeciesTemp0; copies L to wMessageIndex; copies H to wMessageGroup; copies the
; byte at wFollowerRecords to wSavedPlayerState; branches on hPlayerY; advances wScriptStep;
; branches on hPlayerY; sets wScriptStep to 6; branches on wMessageIndex; branches on the byte at
; wFollowerRecords + $1 (E-0347)
SceneMasterThanks_FindPartyIndexOfSpeciesTemp0::
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

; implements script command type 35 (SCRIPT_SCENE_KAMEHA_ESCAPE): a cutscene step named after the
; scene its only script shows: '0 checked the crate.' ... 'Kameha Wahahahah! Thanks for guiding me';
; reached through ScriptCommand35 in bank $10 (E-0038, E-0245)
SceneKamehaEscape::
    ld a, [wScriptStep]
    jumptable
    dw SceneKamehaEscape_QueueMusic
    dw SceneKamehaEscape_StepScriptParam0Counter_Bank73
    dw SceneKamehaEscape_WriteStepPtrLo
    dw SceneKamehaEscape_SetScriptParam0
    dw SceneKamehaEscape_StepScriptParam0Counter_Bank73
    dw SceneKamehaEscape_StepScriptParam0Counter_Bank73
    dw SceneKamehaEscape_ScriptStartFadeAndAdvanceStep
    dw SceneKamehaEscape_StepScriptParam0Counter_Bank73
    dw SceneKamehaEscape_RedrawColumnsBesideScreenAndStep
    dw SceneKamehaEscape_WriteStepPtrLo
    dw SceneKamehaEscape_WriteScriptParam0
    dw SceneKamehaEscape_StepScriptParam0Counter_Bank73
    dw SceneKamehaEscape_StepScriptParam0Counter_Bank73
    dw SceneKamehaEscape_WriteMapScreenXAndMapScreenYEtc
    dw SceneKamehaEscape_StepScriptParam0Counter_Bank73
    dw SceneKamehaEscape_RedrawColumnsBesideScreenAndStep
    dw SceneKamehaEscape_WriteStepPtrLo
    dw SceneKamehaEscape_WriteScriptParam0_SetScriptParam0
    dw SceneKamehaEscape_StepScriptParam0Counter_Bank73
    dw SceneKamehaEscape_StepScriptParam0Counter_Bank73
    dw SceneKamehaEscape_ScriptStartFadeAndAdvanceStep_SetMapId
    dw SceneKamehaEscape_SetScriptStartRequestTo80

; step 21 of SceneKamehaEscape: sets wScriptStartRequest to $80 (E-0347)
SceneKamehaEscape_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 20 of SceneKamehaEscape: sets hMapId to $40; sets hMapScreenX to 0; sets hMapScreenY to 0;
; copies hPlayerX to wWarpDestX; sets wWarpDestY to $40; sets wFieldTransitionKind to 3; calls
; ScriptStartFadeAndAdvanceStep (E-0347)
SceneKamehaEscape_ScriptStartFadeAndAdvanceStep_SetMapId::
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

; step 17 of SceneKamehaEscape: increments wScriptParam0; branches on wScriptParam0; sets
; wScriptParam0 to 0; advances wScriptStep; branches on wScriptParam0; calls
; SceneKamehaEscape_DecompressToVRAM; continues in SceneKamehaEscape_DecompressToVRAM_2; calls
; SceneKamehaEscape_DecompressToVRAM; continues in SceneKamehaEscape_DecompressToVRAM_2 (E-0347)
SceneKamehaEscape_WriteScriptParam0_SetScriptParam0::
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
    jr z, .call_scene_kameha_escape_decompress_to_vram
    ld de, Map30Attrs0_Y4X5
    ld b, $56
    call SceneKamehaEscape_DecompressToVRAM
    ld de, Map30Screens0_Y4X5
    ld b, $56
    jp SceneKamehaEscape_DecompressToVRAM_2

.call_scene_kameha_escape_decompress_to_vram:
    ld de, Map30Attrs2_Y4X5
    ld b, $56
    call SceneKamehaEscape_DecompressToVRAM
    ld de, Map30Screens2_Y4X5
    ld b, $56
    jr SceneKamehaEscape_DecompressToVRAM_2

; step 13 of SceneKamehaEscape: sets hMapScreenX to 5; sets hMapScreenY to 4; continues in
; SceneKamehaEscape_ScriptStartFadeAndAdvanceStep_SetMapIdTo30 (E-0347)
SceneKamehaEscape_WriteMapScreenXAndMapScreenYEtc::
    ld a, $05
    ldh [hMapScreenX], a
    ld a, $04
    ldh [hMapScreenY], a
    jr SceneKamehaEscape_ScriptStartFadeAndAdvanceStep_SetMapIdTo30

; step 10 of SceneKamehaEscape: increments wScriptParam0; branches on wScriptParam0; sets
; wScriptParam0 to 0; advances wScriptStep; branches on wScriptParam0; calls
; SceneKamehaEscape_DecompressToVRAM; continues in SceneKamehaEscape_DecompressToVRAM_2; calls
; SceneKamehaEscape_DecompressToVRAM (E-0347)
SceneKamehaEscape_WriteScriptParam0::
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
    jr z, .call_scene_kameha_escape_decompress_to_vram
    ld de, Map30Attrs0_Y5X6
    ld b, $56
    call SceneKamehaEscape_DecompressToVRAM
    ld de, Map30Screens0_Y5X6
    ld b, $56
    jr SceneKamehaEscape_DecompressToVRAM_2

.call_scene_kameha_escape_decompress_to_vram:
    ld de, Map30Attrs0_Y0X0
    ld b, $56
    call SceneKamehaEscape_DecompressToVRAM
    ld de, Map30Screens0_Y0X0
    ld b, $56

; called from SceneKamehaEscape_SetScriptParam0: calls DecompressToVRAM; calls
; DrawFullScreenBufferAtScroll (E-0347)
SceneKamehaEscape_DecompressToVRAM_2::
    ld hl, wScreenTileBuffer
    call DecompressToVRAM
    farcall DrawFullScreenBufferAtScroll
    ret

; Returns if wIsCGB is 0; sets rSVBK to 2; calls DecompressToVRAM; sets rSVBK to 0 (E-0347)
SceneKamehaEscape_DecompressToVRAM::
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

; step 6 of SceneKamehaEscape: sets hMapScreenX to 6; sets hMapScreenY to 5 (E-0347)
SceneKamehaEscape_ScriptStartFadeAndAdvanceStep::
    ld a, $06
    ldh [hMapScreenX], a
    ld a, $05
    ldh [hMapScreenY], a

; Sets hMapId to $30; copies hPlayerX to wWarpDestX; sets wWarpDestY to $e0; sets
; wFieldTransitionKind to 3; calls ScriptStartFadeAndAdvanceStep (E-0347)
SceneKamehaEscape_ScriptStartFadeAndAdvanceStep_SetMapIdTo30::
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

; step 3 of SceneKamehaEscape: calls SceneKamehaEscape_DecompressToVRAM_2; calls
; SceneKamehaEscape_DecompressToVRAM; calls DrawFullScreenBufferAtScroll; increments wScriptParam0;
; returns unless wScriptParam0 is $09; sets wScriptParam0 to 0; advances wScriptStep (E-0347)
SceneKamehaEscape_SetScriptParam0::
    ld a, [wScriptParam0]
    ld b, a
    ld a, $06
    call DivideBByA
    add a
    add a
    ld hl, SceneKamehaEscape_DecompressToVRAM_Data
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld b, $58
    push hl
    call SceneKamehaEscape_DecompressToVRAM_2
    pop hl
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld b, $58
    call SceneKamehaEscape_DecompressToVRAM
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

; data read by SceneKamehaEscape (24 bytes) (E-0347)
SceneKamehaEscape_DecompressToVRAM_Data::
    db $06, $47, $42, $4c, $fb, $47, $cb, $4c, $ee, $48, $3c, $4d, $fb, $47, $cb, $4c
    db $06, $47, $42, $4c, $ff, $45, $b3, $4b

; step 2 of SceneKamehaEscape: sets wStepPtrLo to $b4; calls
; SceneKamehaEscape_WriteScrollXAndScrollXHi (E-0347)
SceneKamehaEscape_WriteStepPtrLo::
    ld a, $b4
    ld [wStepPtrLo], a
    farcall SceneKamehaEscape_WriteScrollXAndScrollXHi
    ret

; step 1 of SceneKamehaEscape: calls StepScriptParam0Counter_Bank73; may return early; advances
; wScriptStep (E-0347)
SceneKamehaEscape_StepScriptParam0Counter_Bank73::
    ld b, $3c
    call StepScriptParam0Counter_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 0 of SceneKamehaEscape: plays music $02; plays sound $70 (E-0347)
SceneKamehaEscape_QueueMusic::
    ld a, $02
    call QueueMusic
    ld a, $70
    call QueueSoundEffect

; step 8 of SceneKamehaEscape: calls RedrawColumnsBesideScreen; advances wScriptStep (E-0347)
SceneKamehaEscape_RedrawColumnsBesideScreenAndStep::
    ld a, $48
    ld [wSpriteSlots + $b], a
    farcall RedrawColumnsBesideScreen
    ld hl, wScriptStep
    inc [hl]
    ret

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

; implements script command type 33 (SCRIPT_SCENE_CRATE): a cutscene step named after the scene its
; only script shows: '0 checked the treasure chest.' ... '0 checked the crate.'; reached through
; ScriptCommand33 in bank $10 (E-0038, E-0245)
SceneCrate::
    ld a, [wScriptStep]
    jumptable
    dw SceneCrate_ScriptStartFadeAndAdvanceStep
    dw SceneCrate_WriteScriptParam0AndSpriteSlotsEtc
    dw SceneCrate_UpdatePlayerMovement
    dw SceneCrate_WriteScriptParam0AndSpriteSlotsEtc_SetScriptParam0
    dw SceneCrate_WritePlayerYAndFollowerRecords
    dw SceneCrate_WriteFollowerRecords
    dw SceneCrate_WriteFollowerRecords_AdvanceScriptStep_2
    dw SceneCrate_WriteFollowerRecords_AdvanceScriptStep
    dw ScriptStepBlinkSpritesThenEnd

; step 7 of SceneCrate: may return early; advances wScriptStep (E-0347)
SceneCrate_WriteFollowerRecords_AdvanceScriptStep::
    ld a, [wFollowerRecords + $c]
    inc a
    ld [wFollowerRecords + $c], a
    cp $40
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; step 6 of SceneCrate: may return early; advances wScriptStep (E-0347)
SceneCrate_WriteFollowerRecords_AdvanceScriptStep_2::
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

; step 5 of SceneCrate: may return early; advances wScriptStep (E-0347)
SceneCrate_WriteFollowerRecords::
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

; step 4 of SceneCrate: increments hPlayerY; returns unless hPlayerY is $40; sets wFollowerRecords
; to 0; advances wScriptStep (E-0347)
SceneCrate_WritePlayerYAndFollowerRecords::
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

; step 3 of SceneCrate: increments wScriptParam0; may return early; sets hPlayerX to $40; sets
; hPlayerY to $30; sets hPlayerFacing to 0; sets wScriptParam0 to 0; advances wScriptStep (E-0347)
SceneCrate_WriteScriptParam0AndSpriteSlotsEtc_SetScriptParam0::
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

; step 2 of SceneCrate: calls UpdatePlayerMovement; calls RunFieldActionRequestActionIfBit7; returns
; if bit 7 of wFieldActionRequest is set; sets wSpriteSlotCount to 1; advances wScriptStep (E-0347)
SceneCrate_UpdatePlayerMovement::
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

; step 1 of SceneCrate: increments wScriptParam0; may return early; sets wFieldActionRequest to $80;
; sets wScreenScrollDir to 8; increments hMapScreenY; sets hPlayerStateFlags; copies L to
; hPlayerStepDYLo; copies H to hPlayerStepDYHi; calls UpdatePlayerMovement; calls
; RunFieldActionRequestActionIfBit7; sets wScriptParam0 to 0; advances wScriptStep (E-0347)
SceneCrate_WriteScriptParam0AndSpriteSlotsEtc::
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

; step 0 of SceneCrate: sets hMapId to $30; sets hMapScreenX to 5; sets hMapScreenY to 5; sets
; wWarpDestX to $e0; sets wWarpDestY to $e0; sets wFieldTransitionKind to 3; calls
; ScriptStartFadeAndAdvanceStep (E-0347)
SceneCrate_ScriptStartFadeAndAdvanceStep::
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

; implements script command type 30 (SCRIPT_SCENE_SAILOR_RING): a cutscene step named after the
; scene its only script shows: after '0 received the Sailor Ring.'; reached through ScriptCommand30
; in bank $10 (E-0038, E-0245)
SceneSailorRing::
    ld a, [wScriptStep]
    jumptable
    dw SceneSailorRing_ScriptStartFadeAndAdvanceStep
    dw SceneSailorRing_SetScriptStartRequestTo80

; step 0 of SceneSailorRing: sets hMapId to $36; sets hMapScreenX to 0; sets hMapScreenY to 0; sets
; wWarpDestX to $40; sets wWarpDestY to $80; sets wFieldTransitionKind to 3; calls
; ScriptStartFadeAndAdvanceStep (E-0347)
SceneSailorRing_ScriptStartFadeAndAdvanceStep::
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

; step 1 of SceneSailorRing: sets wScriptStartRequest to $80 (E-0347)
SceneSailorRing_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

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

; implements script command type 2D (SCRIPT_SCENE_MERMAID_SONG_2): a cutscene step named after the
; scene its only script shows: the same scene as SCRIPT_SCENE_MERMAID_SONG (two objects moved by
; table); reached through ScriptCommand2D in bank $10 (E-0038, E-0245)
SceneMermaidSong2::
    ld a, [wScriptStep]
    jumptable
    dw SceneMermaidSong2_StepPlayerDownTowardStepPtrLo
    dw SceneMermaidSong2_ToScriptStepMoveFollowersToLeader
    dw SceneMermaidSong2_ToScriptStepMoveFollowersToLeader
    dw SceneMermaidSong2_ToScriptStepMoveFollowersToLeader
    dw SceneMermaidSong2_SetBit2AtHL_B73
    dw SceneMermaidSong2_ToSceneMermaidSong2_MoveSteps
    dw Talk0886_NsDancingLuredA
    dw SceneMermaidSong2_ShowBravoBravoYouWere
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw WarpToMap41
    dw SceneMermaidSong2_SetScriptStartRequestTo80

; step 10 of SceneMermaidSong2: sets wScriptStartRequest to $80 (E-0347)
SceneMermaidSong2_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

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

; step 7 of SceneMermaidSong2: calls RunMessageBoxFar_Bank73; may return early; sets wObject1 +
; OBJ_STATE to 1; advances wScriptStep; shows 'Bravo, bravo! You were fabulous!' (E-0347)
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

; implements script command type 2C (SCRIPT_SCENE_DANCING): a cutscene step named after the scene
; its only script shows: 'Then I'll sing! Lalala lala la' ... 'Erm The sense of rhythm just...';
; reached through ScriptCommand2C in bank $10 (E-0038, E-0245)
SceneDancing::
    ld a, [wScriptStep]
    jumptable
    dw SceneMermaidSong2_StepPlayerDownTowardStepPtrLo
    dw SceneMermaidSong2_ToScriptStepMoveFollowersToLeader
    dw SceneMermaidSong2_ToScriptStepMoveFollowersToLeader
    dw SceneMermaidSong2_ToScriptStepMoveFollowersToLeader
    dw SceneMermaidSong2_SetBit2AtHL_B73
    dw SceneDancing_SetBit2AtHL_B73AndStep
    dw SceneDancing_ToSceneDancing_DanceSteps
    dw SceneDancing_Talk0886_NsDancingLuredA
    dw SceneDancing_SetScriptStartRequestTo80

; step 8 of SceneDancing: sets wScriptStartRequest to $80 (E-0347)
SceneDancing_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 7 of SceneDancing: calls Talk0886_NsDancingLuredA; sets wObject1 + OBJ_X to $e0 (E-0347)
SceneDancing_Talk0886_NsDancingLuredA::
    call Talk0886_NsDancingLuredA
    ld a, $e0
    ld [wObject1 + OBJ_X], a
    ret

; step 6 of SceneDancing: calls SceneDancing_DanceSteps (E-0347)
SceneDancing_ToSceneDancing_DanceSteps::
    farcall SceneDancing_DanceSteps
    ret

; step 5 of SceneDancing: calls SetBit2AtHL_B73; calls SetBit1AtHL_Bank73; advances wScriptStep
; (E-0347)
SceneDancing_SetBit2AtHL_B73AndStep::
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B73
    ld hl, hPlayerStateFlags
    call SetBit1AtHL_Bank73
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 2B (SCRIPT_SCENE_MERMAID_SONG): a cutscene step named after the
; scene its only script shows: 'Then I'll sing! Lalala lala la' ... 'In the past, mermaids are
; said...'; reached through ScriptCommand2B in bank $10 (E-0038, E-0245)
SceneMermaidSong::
    ld a, [wScriptStep]
    jumptable
    dw SceneMermaidSong2_StepPlayerDownTowardStepPtrLo
    dw SceneMermaidSong2_ToScriptStepMoveFollowersToLeader
    dw SceneMermaidSong2_ToScriptStepMoveFollowersToLeader
    dw SceneMermaidSong2_ToScriptStepMoveFollowersToLeader
    dw SceneMermaidSong2_SetBit2AtHL_B73
    dw SceneMermaidSong2_ToSceneMermaidSong2_MoveSteps
    dw Talk0886_NsDancingLuredA
    dw SceneMermaidSong_ShowBravoBravoYouWere
    dw SceneMermaidSong_RunMessageBoxFar_Bank73
    dw SceneMermaidSong_RunMessageBoxFar_Bank73_RunFieldCommandTemp0
    dw ScriptCommand60_Run_ScriptApplyStepDeltaAtDE_Bank73
    dw SceneMermaidSong_ShowHeroReceivedATinyMedal
    dw SceneMermaidSong_RunMessageBoxFar_Bank73

; step 8 of SceneMermaidSong: calls RunMessageBoxFar_Bank73; may return early; sets wObject1 + OBJ_X
; to $e0; sets wScriptStartRequest to $80 (E-0347)
SceneMermaidSong_RunMessageBoxFar_Bank73::
    xor a
    call RunMessageBoxFar_Bank73
    ret nc
    ld a, $e0
    ld [wObject1 + OBJ_X], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 11 of SceneMermaidSong: increments wObject5 + SCRIPTOBJ_X; copies E to wStepPtrLo; copies D
; to wStepPtrHi; calls AddStepDeltaToPointedByte; increments wScriptParam0; returns unless
; wScriptParam0 is $20; sets wObject5 to 0; sets wStepPtrLo to $2c; calls
; AppendItemStepPtrLoToInventory; sets EVENT_SCENE_MERMAID_SONG; shows '0 received a TinyMedal.';
; sets hFieldDrawFlags to 0; then 1 more step (see the code) (E-0347)
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

; step 1 of ScriptCommand60_Run: decrements wObject5 + SCRIPTOBJ_Y; calls
; ScriptApplyStepDeltaAtDE_Bank73; may return early; plays sound $65; advances wScriptStep (E-0347)
ScriptCommand60_Run_ScriptApplyStepDeltaAtDE_Bank73::
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

; step 9 of SceneMermaidSong: calls RunMessageBoxFar_Bank73; may return early; sets hTemp0 to $10;
; calls RunFieldCommandTemp0; sets wObject5 to $80; sets hFieldDrawFlags to $0e; advances
; wScriptStep (E-0347)
SceneMermaidSong_RunMessageBoxFar_Bank73_RunFieldCommandTemp0::
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

; step 7 of SceneMermaidSong: calls RunMessageBoxFar_Bank73; may return early; sets wObject1 +
; OBJ_STATE to 1; advances wScriptStep; checks EVENT_SCENE_MERMAID_SONG; shows 'Bravo, bravo! You
; were fabulous!'; advances wScriptStep (E-0347)
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

; starts 1 constant message(s); the first in the code is $0886, whose string begins 'N's dancing
; lured a mermaid to' (the leading N is a name substitution); the surrounding logic is not
; interpreted (E-0097)
Talk0886_NsDancingLuredA::
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

; step 5 of SceneMermaidSong2: calls SceneMermaidSong2_MoveSteps (E-0347)
SceneMermaidSong2_ToSceneMermaidSong2_MoveSteps::
    farcall SceneMermaidSong2_MoveSteps
    ret

; step 4 of SceneMermaidSong2: calls SetBit2AtHL_B73; sets wFollowerRecords to 1; sets hPlayerFacing
; to 3; increments wFollowerRecords + $1; decrements wFollowerRecords + $7; increments
; wFollowerRecords + $c; decrements hPlayerX; returns unless hPlayerX is $60; sets hPlayerFacing to
; 0; sets wFollowerRecords to 0; calls ClearBit2AtHL_Bank73; advances wScriptStep; then 2 more steps
; (see the code) (E-0347)
SceneMermaidSong2_SetBit2AtHL_B73::
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

; step 1 of SceneMermaidSong2: calls ScriptStepMoveFollowersToLeader (E-0347)
SceneMermaidSong2_ToScriptStepMoveFollowersToLeader::
    farcall ScriptStepMoveFollowersToLeader
    ret

; step 0 of SceneMermaidSong2: branches on hPlayerY; sets wStepPtrLo to $40; calls
; StepPlayerDownTowardStepPtrLo; branches on hPlayerX; sets wStepPtrLo to $70; calls
; StepPlayerRightTowardStepPtrLo; returns if wStepArrived is 0; sets hPlayerFacing to 0; advances
; wScriptStep (E-0347)
SceneMermaidSong2_StepPlayerDownTowardStepPtrLo::
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

; ld a, [wScriptStep] / rst $00 with a six-entry table, the shape of a script command's
; implementation; no script command stub or other code reaches it (E-0214) (E-0344: the address in
; its name dropped or read as the label there; was UnreferencedScriptStepDispatch_73)
UnreferencedScriptStepDispatch_73:: ; configured code entry (E-0214); C0
    ld a, [wScriptStep]
    jumptable
    dw UnreferencedScriptStepDispatch_73_Msg_HmYouAreQuite
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw UnreferencedScriptStepDispatch_73_ShowOhButICan
    dw SceneWizstone_RunMessageBoxFar_Bank73
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw UnreferencedScriptStepDispatch_73_ClearArg5IfAtOrAboveLimitForFarmLevel

; step 5 of UnreferencedScriptStepDispatch_73: calls ClearArg5IfAtOrAboveLimitForFarmLevel; sets
; hTemp1 to 5; copies wArg5 to hTemp2; sets hTemp3 to 2; calls CreateMonsterRecordOfKindTemp1;
; increments wPartyCount; calls MoveIncapacitatedPartyMembersBack; calls LoadRecordListNameTiles;
; calls LoadPlayerAndFollowerSpriteGraphics; sets wOBJPaletteUploadRequest to $7f; decrements
; wSpriteSlotCount; sets EVENT_SCENE_WATCH_OUT_078; then 1 more step (see the code) (E-0347)
UnreferencedScriptStepDispatch_73_ClearArg5IfAtOrAboveLimitForFarmLevel::
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

; step 2 of UnreferencedScriptStepDispatch_73: advances wScriptStep; branches on wTextYesNoResult;
; calls StartMessageHL_B73b; calls ClearArg5IfAtOrAboveLimitForFarmLevel; branches on wArg5;
; branches on wPartyCount; calls StartMessageHL_B73b; advances wScriptStep; calls
; StartMessageHL_B73b (E-0347)
UnreferencedScriptStepDispatch_73_ShowOhButICan::
    ld hl, wScriptStep
    inc [hl]
    ld a, [wTextYesNoResult]
    or a
    jr z, .call_clear_arg5_if_at_or_above_limit_for_farm
    ld hl, vTiles1 + $512
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
    ld hl, vTiles1 + $510
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b73b:
    ld hl, vTiles1 + $511
    call StartMessageHL_B73b
    ret

; step 0 of UnreferencedScriptStepDispatch_73: shows 'Hm, you are quite strong…'; advances
; wScriptStep (E-0347)
UnreferencedScriptStepDispatch_73_Msg_HmYouAreQuite::
    ld hl, MSG_KEEP_OPEN | $0d0f ; '*: Hm, you are quite strong…'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 26 (SCRIPT_SCENE_MONSTERS_IN_TOW): a cutscene step named after the
; scene its only script shows: 'That will help you for certain.' ... 'Heh, you have monsters in
; tow?'; reached through ScriptCommand26 in bank $10 (E-0038, E-0245)
SceneMonstersInTow::
    ld a, [wScriptStep]
    jumptable
    dw SceneMonstersInTow_CopyBytes
    dw GreatLogFieldEvents_KamehaNoGoing_ToScriptStepFlashScreenNegative
    dw SceneMonstersInTow_ScriptStartFadeAndAdvanceStep
    dw SceneMonstersInTow_SetScriptStartRequestTo80

; step 3 of SceneMonstersInTow: sets wScriptStartRequest to $80 (E-0347)
SceneMonstersInTow_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 2 of SceneMonstersInTow: copies hPlayerX to wWarpDestX; copies hPlayerY to wWarpDestY; copies
; hPlayerFacing+1 to wFieldTransitionKind; calls ScriptStartFadeAndAdvanceStep (E-0347)
SceneMonstersInTow_ScriptStartFadeAndAdvanceStep::
    ldh a, [hPlayerX]
    ld [wWarpDestX], a
    ldh a, [hPlayerY]
    ld [wWarpDestY], a
    ldh a, [hPlayerFacing]
    inc a
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; step 0 of SceneMonstersInTow: sets hSpriteWindowClipMode to 0; branches on wIsCGB; calls
; CopyBytes; plays sound $7a; advances wScriptStep (E-0347)
SceneMonstersInTow_CopyBytes::
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

; implements script command type 1E (SCRIPT_CHECK_ITEM): looks items up in the inventory
; (FindTemp0InInventoryList) and, after changing a slot, sets bit 6 of wInventorySortFlags (E-0340);
; reached through ScriptCommand1E in bank $10 (E-0038, E-0245)
CheckItem::
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

; implements script command type 25 (SCRIPT_SCENE_WATER_SOLVED): a cutscene step named after the
; scene its only script shows: 'You will? So we can go...' ... 'King This should solve the
; water...'; reached through ScriptCommand25 in bank $10 (E-0038, E-0245)
SceneWaterSolved::
    ld a, [wScriptStep]
    jumptable
    dw SceneWaterSolved_ScriptStartFadeAndAdvanceStep
    dw SceneWaterSolved_SetScriptStartRequestTo80

; step 1 of SceneWaterSolved: sets wScriptStartRequest to $80 (E-0347)
SceneWaterSolved_SetScriptStartRequestTo80::
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 0 of SceneWaterSolved: copies hPlayerX to wWarpDestX; copies hPlayerY to wWarpDestY; copies
; hPlayerFacing+1 to wFieldTransitionKind; calls ScriptStartFadeAndAdvanceStep (E-0347)
SceneWaterSolved_ScriptStartFadeAndAdvanceStep::
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

; implements script command type 21 (SCRIPT_SCENE_KING_AUDIENCE): a cutscene step named after the
; scene its only script shows: 'King You wish to see our...' ... 'King I see. This is what...';
; reached through ScriptCommand21 in bank $10 (E-0038, E-0245)
SceneKingAudience::
    ld a, [wScriptStep]
    jumptable
    dw SceneKingAudience_StepScriptParam0Counter_Bank73
    dw SceneKingAudience_StepScriptParam0Counter_Bank73_SetObject5

; step 0 of SceneKingAudience: calls StepScriptParam0Counter_Bank73; may return early; sets hTemp0
; to 5; calls RunFieldCommandTemp0; advances wScriptStep (E-0347)
SceneKingAudience_StepScriptParam0Counter_Bank73::
    ld b, $5a
    call StepScriptParam0Counter_Bank73
    ret nc
    ld a, $05
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; step 1 of SceneKingAudience: calls StepScriptParam0Counter_Bank73; may return early; sets wObject5
; to 0; sets wScriptStartRequest to $80 (E-0347)
SceneKingAudience_StepScriptParam0Counter_Bank73_SetObject5::
    ld b, $28
    call StepScriptParam0Counter_Bank73
    ret nc
    xor a
    ld [wObject5], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

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

; implements script command type 20; reached through ScriptCommand20 in bank $10 (E-0038)
ScriptCommand20_Run::
    ld a, [wScriptStep]
    jumptable
    dw ScriptCommand20_Run_WriteScriptParam0
    dw ScriptCommand20_Run_WriteScriptParam0AndFollowerRecords
    dw ScriptCommand20_Run_WriteFollowerRecords
    dw ScriptCommand20_Run_SetFlagBit

; step 3 of ScriptCommand20_Run: increments wScriptParam0; returns unless wScriptParam0 is $3c;
; plays sound $72; sets EVENT_SCRIPT_COMMAND20_TURNED; sets wScriptStartRequest to $80 (E-0347)
ScriptCommand20_Run_SetFlagBit::
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

; step 2 of ScriptCommand20_Run: may return early; advances wScriptStep (E-0347)
ScriptCommand20_Run_WriteFollowerRecords::
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

; step 1 of ScriptCommand20_Run: branches on wScriptParam0; sets wScriptParam0 to 1; increments
; wFollowerRecords + $6; sets wScriptParam0 to 0; advances wScriptStep; increments wFollowerRecords
; + $7; decrements wFollowerRecords + $7 (E-0347)
ScriptCommand20_Run_WriteScriptParam0AndFollowerRecords::
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

; step 0 of ScriptCommand20_Run: advances wScriptStep; sets wScriptParam0 to 0; sets wScriptParam0
; to 1 (E-0347)
ScriptCommand20_Run_WriteScriptParam0::
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

; implements script command type 16 (SCRIPT_SCENE_WARUBOU_FOOD_2): a cutscene step named after the
; scene its only script shows: the same scene as SCRIPT_SCENE_WARUBOU_FOOD; reached through
; ScriptCommand16 in bank $10 (E-0038, E-0245)
SceneWarubouFood2::
    ld a, [wScriptStep]
    jumptable
    dw ScriptStepSetObjectBit2AndWait
    dw SceneWarubouFood2_ShowWarubouWaheyImStarving
    dw SceneWarubouFood2_ShowWarubouWaheyImStarving
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw SceneWarubouFood2_ShowKamehaGimmeItYou
    dw SceneWarubouFood2_ShowKamehaGimmeItYou
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw SceneWarubouFood2_ShowWarubouWaheySomePrince
    dw SceneWarubouFood2_ShowWarubouWaheySomePrince
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw ScriptStepSetObjectBit2AndWait
    dw SceneWarubouFood2_ShiftObjectsYByTable
    dw SceneWarubouFood2_ShowCobiThatsOursGive
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw SceneWarubouFood2_ShiftObjectsYByTable_2
    dw SceneWarubouFood2_AddStepDeltaToPointedByte
    dw SceneWarubouFood2_ScriptApplyStepDeltaAtDE_Bank73
    dw SceneWarubouFood2_CycleSpriteFloatYDown
    dw SceneWarubouFood2_RunMessageBoxFar_Bank73
    dw SceneWarubouFood2_CycleSpriteFloatYDown_DrawAnimatedMetaSprite1B_2
    dw SceneWarubouFood2_RunMessageBoxFar_Bank73
    dw SceneWarubouFood2_CycleSpriteFloatYDown_DrawAnimatedMetaSprite1B
    dw SceneWarubouFood2_ShowWarubouWaheyItsThe
    dw SceneWarubouFood2_RunMessageBox
    dw SceneWarubouFood2_ShowWarubouWaroohWillIt
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw SceneWarubouFood2_StepPlayerLeftTowardStepPtrLo
    dw SceneWarubouFood2_ScriptApplyStepDeltaAtDE_Bank73_SetObject5
    dw SceneWarubouFood2_WriteScriptParam0AndStepPtrLoEtc

; step 28 of SceneWarubouFood2: branches on wScriptParam0; increments wScriptParam0; sets wStepPtrLo
; to $40; calls StepPlayerLeftTowardStepPtrLo; returns if wStepArrived is 0; sets hPlayerFacing to
; 2; sets wFollowerRecords to 2; sets EVENT_SCENE_WARUBOU_FOOD2_00C; sets wScriptStartRequest to $80
; (E-0347)
SceneWarubouFood2_WriteScriptParam0AndStepPtrLoEtc::
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

; step 27 of SceneWarubouFood2: increments wObject5 + SCRIPTOBJ_Y; calls
; ScriptApplyStepDeltaAtDE_Bank73; may return early; sets wObject5 to 0; advances wScriptStep
; (E-0347)
SceneWarubouFood2_ScriptApplyStepDeltaAtDE_Bank73_SetObject5::
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

; step 26 of SceneWarubouFood2: sets wStepPtrLo to $68; calls StepPlayerLeftTowardStepPtrLo; returns
; if wStepArrived is 0; sets hPlayerFacing to 2; advances wScriptStep (E-0347)
SceneWarubouFood2_StepPlayerLeftTowardStepPtrLo::
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

; step 24 of SceneWarubouFood2: calls StepScriptParam0Counter_Bank73; may return early; shows
; 'Warubou: Warooh! Will it hold? You'; advances wScriptStep (E-0347)
SceneWarubouFood2_ShowWarubouWaroohWillIt::
    ld b, $b4
    call StepScriptParam0Counter_Bank73
    ret nc
    ld hl, $005c ; 'Warubou: Warooh! Will it hold? You'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; step 23 of SceneWarubouFood2: branches on wMessageState; sets wStepPtrLo to 0; calls
; RunMessageBox; branches on wScriptParam0; plays sound $65; copies E to wStepPtrLo; copies D to
; wStepPtrHi; calls AddStepDeltaToPointedByte; increments wScriptParam0; branches on wScriptParam0;
; calls CycleSpriteFloatYDown; sets hTemp0 to 0; then 5 more steps (see the code) (E-0347)
SceneWarubouFood2_RunMessageBox::
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

; step 22 of SceneWarubouFood2: calls CycleSpriteFloatYDown; sets hTemp0 to 0; calls
; DrawAnimatedMetaSprite1B; calls RotateDirectionAtDEEvery32_Bank73; calls
; StepScriptParam0Counter_Bank73; may return early; shows 'Warubou: Wa-hey! It's the only way!';
; advances wScriptStep (E-0347)
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

; step 21 of SceneWarubouFood2: calls CycleSpriteFloatYDown; sets hTemp0 to 0; calls
; DrawAnimatedMetaSprite1B; calls RotateDirectionAtDEEvery32_Bank73; increments wScriptParam0; sets
; wStepPtrHi to 1; sets wStepTarget to $81; sets wStepPtrLo to $b0; calls StepObjectTowardCoord;
; returns if wStepArrived is 0; sets wScriptParam0 to 0; advances wScriptStep (E-0347)
SceneWarubouFood2_CycleSpriteFloatYDown_DrawAnimatedMetaSprite1B::
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

; step 19 of SceneWarubouFood2: calls CycleSpriteFloatYDown; sets hTemp0 to 0; calls
; DrawAnimatedMetaSprite1B; calls RotateDirectionAtDEEvery32_Bank73; calls
; ScriptStepAdjust32TimesThenMessage_Bank73 (E-0347)
SceneWarubouFood2_CycleSpriteFloatYDown_DrawAnimatedMetaSprite1B_2::
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

; step 18 of SceneWarubouFood2: calls RunMessageBoxFar_Bank73; calls
; RotateDirectionAtDEEvery32_Bank73; increments wScriptParam0; may return early; sets wScriptParam0
; to 0; advances wScriptStep (E-0347)
SceneWarubouFood2_RunMessageBoxFar_Bank73::
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

; step 17 of SceneWarubouFood2: sets wFollowerRecords to 2; calls CycleSpriteFloatYDown; sets hTemp0
; to 0; calls DrawAnimatedMetaSprite1B; sets wObject5 to $80; calls
; ScriptStepAdjust32TimesThenMessage_Bank73 (E-0347)
SceneWarubouFood2_CycleSpriteFloatYDown::
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

; step 16 of SceneWarubouFood2: sets wObject2 + OBJ_STATE to 2; increments wObject2 + OBJ_Y; calls
; ScriptApplyStepDeltaAtDE_Bank73; may return early; sets EVENT_SCENE_WARUBOU_FOOD2; copies hPlayerX
; to wWarpDestX; copies hPlayerY to wWarpDestY; sets wFieldTransitionKind to 4; calls
; ScriptStartFadeAndAdvanceStep (E-0347)
SceneWarubouFood2_ScriptApplyStepDeltaAtDE_Bank73::
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

; step 15 of SceneWarubouFood2: decrements wObject2 + OBJ_X; copies E to wStepPtrLo; copies D to
; wStepPtrHi; calls AddStepDeltaToPointedByte; copies E to wStepPtrLo; copies D to wStepPtrHi; calls
; AddStepDeltaToPointedByte; copies E to wStepPtrLo; copies D to wStepPtrHi; calls
; AddStepDeltaToPointedByte; increments wScriptParam0; returns unless wScriptParam0 is $20; then 4
; more steps (see the code) (E-0347)
SceneWarubouFood2_AddStepDeltaToPointedByte::
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

; step 14 of SceneWarubouFood2: calls ShiftObjectsYByTable; sets wObject1 + OBJ_X to $80; sets
; wObject2 + OBJ_X to $60; sets wObject5 + SCRIPTOBJ_X to $70; plays sound $63; sets wScriptParam0
; to 0; advances wScriptStep (E-0347)
SceneWarubouFood2_ShiftObjectsYByTable_2::
    ld a, [wFollowerRecords + $2]
    dec a
    dec a
    ld [wFollowerRecords + $2], a
    cp $38
    jr z, .set_object1_to_80
    call ShiftObjectsYByTable
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

; step 12 of SceneWarubouFood2: may return early; advances wScriptStep; checks
; EVENT_IN_THE_MIDDLE_OF_THE; shows 'Cobi: That's ours! Give it back!'; shows 'Tara: That's ours!
; Give it back!' (E-0347)
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

; step 11 of SceneWarubouFood2: calls ShiftObjectsYByTable; may return early; sets wFollowerRecords
; to 2; advances wScriptStep (E-0347)
SceneWarubouFood2_ShiftObjectsYByTable::
    call ShiftObjectsYByTable
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

; step 7 of SceneWarubouFood2: calls ScriptApplyStepDeltaAtDE_Bank73; may return early; shows
; 'Warubou: Wa-hey! Some prince! Dirty mouth!'; advances wScriptStep (E-0347)
SceneWarubouFood2_ShowWarubouWaheySomePrince::
    ld de, wObject1 + OBJ_Y
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    ld hl, $0055 ; 'Warubou: Wa-hey! Some prince! Dirty mouth!'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; step 4 of SceneWarubouFood2: calls ScriptApplyStepDeltaAtDE_Bank73; may return early; shows
; 'Kameha: Gimme it! You just ate!'; advances wScriptStep (E-0347)
SceneWarubouFood2_ShowKamehaGimmeItYou::
    ld de, wObject2 + OBJ_Y
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    ld hl, $0054 ; 'Kameha: Gimme it! You just ate!'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; step 1 of SceneWarubouFood2: calls ScriptApplyStepDeltaAtDE_Bank73; may return early; shows
; 'Warubou: Wa-hey! I'm starving!'; advances wScriptStep (E-0347)
SceneWarubouFood2_ShowWarubouWaheyImStarving::
    ld de, wObject1 + OBJ_Y
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    ld hl, $0053 ; 'Warubou: Wa-hey! I'm starving!'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; sets bit 2 of the objects at wObject1 + $D and wObject2 + $D, wObject5 = $80, runs
; ShiftObjectsYByTable and advances wScriptStep once wScriptParam0 is 0 (E-0122)
ScriptStepSetObjectBit2AndWait::
    ld hl, wObject1 + OBJ_FLAGS
    call SetBit2AtHL_B73
    ld hl, wObject2 + OBJ_FLAGS
    call SetBit2AtHL_B73
    ld a, $80
    ld [wObject5], a
    call ShiftObjectsYByTable
    ld a, [wScriptParam0]
    or a
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; adds the signed step $7526[wScriptParam0 & $3F] (negated with bit 6) to wObject1 + $B, wObject2 +
; $B and wObject5 + $4, then wScriptParam0 += 1 (E-0124) (E-0344: the address in its name dropped or
; read as the label there; was ShiftObjectsYByTable)
ShiftObjectsYByTable::
    ld a, [wScriptParam0]
    and $3f
    ld hl, ShiftObjectsYByTable_Data
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

; implements script command type 15 (SCRIPT_SCENE_WARUBOU_FOOD): a cutscene step named after the
; scene its only script shows: 'Warubou What is this? Food? Perfect!' ... 'Calm down and listen!';
; reached through ScriptCommand15 in bank $10 (E-0038, E-0245)
SceneWarubouFood::
    ld a, [wScriptStep]
    jumptable
    dw SceneWarubouFood_StepPlayerRightTowardStepPtrLo
    dw SceneWarubouFood_WriteObject2AndPlayerXEtc
    dw SceneWarubouFood_WriteObject2AndPlayerXEtc_2
    dw SceneWarubouFood_WriteObject2AndPlayerXEtc_2
    dw SceneWarubouFood_WriteObject2AndPlayerXEtc
    dw SceneWarubouFood_WriteObject2AndPlayerXEtc
    dw SceneWarubouFood_WriteObject2AndPlayerXEtc_2
    dw SceneWarubouFood_WriteObject2AndPlayerXEtc_2
    dw SceneWarubouFood_WriteObject2AndPlayerXEtc
    dw SceneWarubouFood_QueueSoundEffect
    dw SceneWarubouFood_StepObjectTowardCoord

; step 10 of SceneWarubouFood: branches on wScriptParam0; sets wStepPtrHi to 1; sets wStepTarget to
; $82; sets wStepPtrLo to $50; calls StepObjectTowardCoord; sets wStepPtrHi to 2; sets wStepTarget
; to $81; sets wStepPtrLo to $50; calls StepObjectTowardCoord; returns if wStepArrived is 0; sets
; wObject2 + OBJ_X to $e0; increments wScriptParam0; then 7 more steps (see the code) (E-0347)
SceneWarubouFood_StepObjectTowardCoord::
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

; step 9 of SceneWarubouFood: branches on wScriptParam0; plays sound $65; copies the byte at
; SceneWarubouFood_QueueSoundEffect_Data to wObject5 + SCRIPTOBJ_X; sets wScriptParam0; copies E to
; wStepPtrLo; copies D to wStepPtrHi; calls AddStepDeltaToPointedByte; sets wScriptParam0; branches
; on hPlayerX; calls ClearBit2AtHL_Bank73; sets hPlayerX; increments wObject2 + OBJ_X; then 8 more
; steps (see the code) (E-0347)
SceneWarubouFood_QueueSoundEffect::
    ld a, [wScriptParam0]
    or a
    jr nz, .read_script_param0
    ld a, $65
    call QueueSoundEffect

.read_script_param0:
    ld a, [wScriptParam0]
    ld hl, SceneWarubouFood_QueueSoundEffect_Data
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

; data read by SceneWarubouFood (64 bytes) (E-0347)
SceneWarubouFood_QueueSoundEffect_Data::
    db $21, $22, $23, $23, $24, $25, $26, $27, $28, $29, $2a, $2a, $2b, $2c, $2d, $2e
    db $2f, $30, $30, $31, $32, $33, $34, $35, $35, $36, $37, $38, $39, $39, $3a, $3b
    db $3c, $3c, $3d, $3e, $3e, $3f, $40, $40, $41, $42, $42, $43, $44, $44, $45, $46
    db $46, $47, $48, $48, $49, $4a, $4a, $4b, $4c, $4c, $4d, $4e, $4e, $4f, $50, $50

; step 2 of SceneWarubouFood: changes HL, A and C; continues in
; SceneWarubouFood_WriteObject2AndPlayerXEtc_ReadObject2 (E-0347)
SceneWarubouFood_WriteObject2AndPlayerXEtc_2::
    ld a, [wScriptParam0]
    ld hl, ShiftObjectsYByTable_Data
    add_a_to_hl
    ld a, [hl]
    xor $ff
    inc a
    ld c, a
    jr SceneWarubouFood_WriteObject2AndPlayerXEtc_ReadObject2

; step 1 of SceneWarubouFood: changes HL, A and C (E-0347)
SceneWarubouFood_WriteObject2AndPlayerXEtc::
    ld a, [wScriptParam0]
    ld hl, ShiftObjectsYByTable_Data
    add_a_to_hl
    ld a, [hl]
    ld c, a

; Sets wObject2 + OBJ_X; sets hPlayerX; sets wObject5 + SCRIPTOBJ_X; increments wScriptParam0;
; returns unless wScriptParam0 is $40; advances wScriptStep; sets wScriptParam0 to 0 (E-0347)
SceneWarubouFood_WriteObject2AndPlayerXEtc_ReadObject2::
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

; data read by ShiftObjectsYByTable (64 bytes) (E-0347)
ShiftObjectsYByTable_Data::
    db $01, $00, $01, $00, $01, $01, $00, $ff, $01, $00, $00, $ff, $00, $ff, $ff, $00
    db $01, $00, $00, $00, $01, $01, $ff, $00, $00, $ff, $00, $00, $00, $ff, $01, $00
    db $01, $00, $01, $00, $00, $01, $01, $01, $00, $00, $ff, $00, $00, $00, $ff, $01
    db $ff, $00, $00, $01, $ff, $ff, $ff, $00, $00, $00, $ff, $00, $00, $ff, $ff, $00

; step 0 of SceneWarubouFood: sets wStepPtrLo to $10; calls StepPlayerRightTowardStepPtrLo; returns
; if wStepArrived is 0; sets wFollowerRecords to 1; calls SetBit2AtHL_B73; advances wScriptStep
; (E-0347)
SceneWarubouFood_StepPlayerRightTowardStepPtrLo::
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

; implements script command type 14 (SCRIPT_SCENE_WARUBOU_SMELLS): a cutscene step named after the
; scene its only script shows: 'Warubou Wha? I smell something!' ... 'What is this? Food? Perfect!';
; reached through ScriptCommand14 in bank $10 (E-0038, E-0245)
SceneWarubouSmells::
    ld a, [wScriptStep]
    jumptable
    dw SceneWarubouSmells_WriteObject2
    dw SceneWarubouSmells_QueueSoundEffect
    dw SceneWarubouSmells_AddStepDeltaToPointedByte
    dw SceneWarubouSmells_StepScriptParam0Counter_Bank73

; step 3 of SceneWarubouSmells: calls StepScriptParam0Counter_Bank73; may return early; sets
; wScriptStartRequest to $80 (E-0347)
SceneWarubouSmells_StepScriptParam0Counter_Bank73::
    ld b, $3c
    call StepScriptParam0Counter_Bank73
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 2 of SceneWarubouSmells: branches on hPlayerX; decrements hPlayerX; sets wObject5 to $80;
; copies E to wStepPtrLo; copies D to wStepPtrHi; calls AddStepDeltaToPointedByte; increments
; wScriptParam0; returns unless wScriptParam0 is $20; sets wObject5 + SCRIPTOBJ_Y to $50; sets
; wScriptParam0 to 0; advances wScriptStep (E-0347)
SceneWarubouSmells_AddStepDeltaToPointedByte::
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

; step 1 of SceneWarubouSmells: decrements wObject2 + OBJ_X; returns unless wObject2 + OBJ_X is $30;
; plays sound $63; advances wScriptStep (E-0347)
SceneWarubouSmells_QueueSoundEffect::
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

; step 0 of SceneWarubouSmells: increments wObject2 + OBJ_X; returns unless wObject2 + OBJ_X is $40;
; advances wScriptStep (E-0347)
SceneWarubouSmells_WriteObject2::
    ld a, [wObject2 + OBJ_X]
    inc a
    ld [wObject2 + OBJ_X], a
    cp $40
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 13 (SCRIPT_SCENE_SPINNING): a cutscene step named after the scene
; its only script shows: 'Oh It's all spinning around' ... 'You must be the farm kids.'; reached
; through ScriptCommand13 in bank $10 (E-0038, E-0245)
SceneSpinning::
    ld a, [wScriptStep]
    jumptable
    dw SceneSpinning_WriteObject2AndObject1Etc
    dw SceneSpinning_StepObjectTowardCoord
    dw SceneSpinning_StepScriptParam0Counter_Bank73
    dw SceneSpinning_ScriptApplyStepDeltaAtDE_Bank73
    dw SceneSpinning_StepScriptParam0Counter_Bank73
    dw SceneSpinning_AddStepDeltaToPointedByte
    dw SceneSpinning_StepScriptParam0Counter_Bank73
    dw SceneSpinning_WriteStepPtrLoAndStepPtrHiEtc
    dw SceneSpinning_StepScriptParam0Counter_Bank73
    dw SceneSpinning_AddStepDeltaToPointedByte
    dw SceneSpinning_StepScriptParam0Counter_Bank73
    dw SceneSpinning_WriteStepPtrLoAndStepPtrHiEtc
    dw SceneSpinning_StepScriptParam0Counter_Bank73
    dw SceneSpinning_ToScriptStepAdjust32TimesThenMessage_Bank73
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw SceneSpinning_StepObjectTowardCoord_SetStepTarget
    dw SceneSpinning_StepObjectTowardCoord_SetStepPtrHi

; step 16 of SceneSpinning: sets wStepPtrHi to 1; sets wStepTarget to $82; sets wStepPtrLo to $e0;
; calls StepObjectTowardCoord; sets wStepPtrHi to 2; sets wStepTarget to $82; sets wStepPtrLo to
; $e0; calls StepObjectTowardCoord; returns if wStepArrived is 0; sets wScriptStartRequest to $80
; (E-0347)
SceneSpinning_StepObjectTowardCoord_SetStepPtrHi::
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

; step 15 of SceneSpinning: branches on wObject2 + OBJ_X; sets wStepTarget to $83; sets wStepPtrLo
; to $40; sets wStepTarget to $82; sets wStepPtrLo to $e0; sets wStepPtrHi to 2; calls
; StepObjectTowardCoord; sets wStepPtrHi to 1; sets wStepTarget to $82; sets wStepPtrLo to $40;
; calls StepObjectTowardCoord; increments wObject5 + SCRIPTOBJ_Y; then 4 more steps (see the code)
; (E-0347)
SceneSpinning_StepObjectTowardCoord_SetStepTarget::
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

; step 13 of SceneSpinning: calls ScriptStepAdjust32TimesThenMessage_Bank73 (E-0347)
SceneSpinning_ToScriptStepAdjust32TimesThenMessage_Bank73::
    ld de, wSpriteSlots + $c
    ld hl, $0039
    call ScriptStepAdjust32TimesThenMessage_Bank73
    ret

; step 7 of SceneSpinning: increments wObject5 + SCRIPTOBJ_X; continues in
; SceneSpinning_AddStepDeltaToPointedByte_SetStepPtrLo (E-0347)
SceneSpinning_WriteStepPtrLoAndStepPtrHiEtc::
    ld hl, wObject5 + SCRIPTOBJ_X
    inc [hl]
    jr SceneSpinning_AddStepDeltaToPointedByte_SetStepPtrLo

; step 5 of SceneSpinning: decrements wObject5 + SCRIPTOBJ_X (E-0347)
SceneSpinning_AddStepDeltaToPointedByte::
    ld hl, wObject5 + SCRIPTOBJ_X
    dec [hl]

; Copies E to wStepPtrLo; copies D to wStepPtrHi; calls AddStepDeltaToPointedByte; increments
; wScriptParam0; returns unless wScriptParam0 is $20; sets wScriptParam0 to 0; advances wScriptStep
; (E-0347)
SceneSpinning_AddStepDeltaToPointedByte_SetStepPtrLo::
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

; step 3 of SceneSpinning: decrements wObject5 + SCRIPTOBJ_X; decrements wObject5 + SCRIPTOBJ_Y;
; calls ScriptApplyStepDeltaAtDE_Bank73; may return early; sets wObject2 + OBJ_STATE to 3; advances
; wScriptStep (E-0347)
SceneSpinning_ScriptApplyStepDeltaAtDE_Bank73::
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

; step 2 of SceneSpinning: calls StepScriptParam0Counter_Bank73; may return early; advances
; wScriptStep (E-0347)
SceneSpinning_StepScriptParam0Counter_Bank73::
    ld b, $1e
    call StepScriptParam0Counter_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 1 of SceneSpinning: branches on wObject1 + OBJ_X; sets wStepPtrHi to 1; sets wStepTarget to
; 1; sets wStepPtrLo to $30; calls StepObjectTowardCoord; sets wStepPtrHi to 2; sets wStepTarget to
; 0; sets wStepPtrLo to $40; calls StepObjectTowardCoord; returns if wStepArrived is 0; sets
; wObject2 + OBJ_STATE to 1; advances wScriptStep (E-0347)
SceneSpinning_StepObjectTowardCoord::
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

; step 0 of SceneSpinning: increments wScriptParam0; branches on wScriptParam0; sets wObject2 +
; OBJ_X to $50; branches on $50; sets wObject1 + OBJ_X to $20; returns unless $20 is $b4; sets
; wScriptParam0 to 0; advances wScriptStep (E-0347)
SceneSpinning_WriteObject2AndObject1Etc::
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

; implements script command type 12 (SCRIPT_SCENE_LEARN_QUICK): a cutscene step named after the
; scene its only script shows: 'Wow, you kids sure learn quick!' ... 'Oh It's all spinning around';
; reached through ScriptCommand12 in bank $10 (E-0038, E-0245)
SceneLearnQuick::
    ld a, [wScriptStep]
    jumptable
    dw SceneLearnQuick_SetMessageIndex
    dw SceneLearnQuick_StepScriptParam0Counter_Bank73
    dw SceneLearnQuick_StepScriptParam0Counter_Bank73_SceneLearnQuick_WriteStepTargetAndStepPtrLoEtc
    dw SceneLearnQuick_StepObjectTowardCoord
    dw SceneLearnQuick_StepObjectTowardCoord_SceneLearnQuick_WriteScriptParam0AndSpriteSlots
    dw SceneLearnQuick_WriteScriptStartRequest

; step 5 of SceneLearnQuick: calls SceneLearnQuick_WriteScriptParam0AndSpriteSlots; returns unless
; wScriptParam1 is 0; sets wScriptStartRequest to $80 (E-0347)
SceneLearnQuick_WriteScriptStartRequest::
    call SceneLearnQuick_WriteScriptParam0AndSpriteSlots
    ld a, [wScriptParam1]
    or a
    ret nz
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; step 4 of SceneLearnQuick: calls SceneLearnQuick_WriteScriptParam0AndSpriteSlots; branches on
; wObject1 + OBJ_Y; sets wStepTarget to $82; sets wStepPtrLo to $30; sets wStepTarget to $83; sets
; wStepPtrLo to $e0; sets wStepPtrHi to 1; calls StepObjectTowardCoord; branches on wMessageIndex;
; sets wStepPtrHi to 2; sets wStepTarget to $83; sets wStepPtrLo to $20; then 15 more steps (see the
; code) (E-0347)
SceneLearnQuick_StepObjectTowardCoord_SceneLearnQuick_WriteScriptParam0AndSpriteSlots::
    call SceneLearnQuick_WriteScriptParam0AndSpriteSlots
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

; step 3 of SceneLearnQuick: calls SceneLearnQuick_WriteScriptParam0AndSpriteSlots; sets wStepPtrHi
; to 2; sets wStepTarget to $83; sets wStepPtrLo to $20; calls StepObjectTowardCoord; sets
; wStepPtrHi to 1; sets wStepTarget to $83; sets wStepPtrLo to $20; calls StepObjectTowardCoord;
; returns if wStepArrived is 0; advances wScriptStep (E-0347)
SceneLearnQuick_StepObjectTowardCoord::
    call SceneLearnQuick_WriteScriptParam0AndSpriteSlots
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

; step 2 of SceneLearnQuick: calls SceneLearnQuick_WriteStepTargetAndStepPtrLoEtc; calls
; SceneLearnQuick_WriteSpriteSlots; calls StepScriptParam0Counter_Bank73; may return early; sets
; wScriptParam1 to $40; sets wMessageIndex to 0; advances wScriptStep (E-0347)
SceneLearnQuick_StepScriptParam0Counter_Bank73_SceneLearnQuick_WriteStepTargetAndStepPtrLoEtc::
    call SceneLearnQuick_WriteStepTargetAndStepPtrLoEtc
    call SceneLearnQuick_WriteSpriteSlots
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

; step 1 of SceneLearnQuick: calls SceneLearnQuick_WriteStepTargetAndStepPtrLoEtc; calls
; SceneLearnQuick_WriteSpriteSlots; calls StepScriptParam0Counter_Bank73; may return early; sets
; wMessageIndex to $81; sets wMessageGroup to $80; advances wScriptStep (E-0347)
SceneLearnQuick_StepScriptParam0Counter_Bank73::
    call SceneLearnQuick_WriteStepTargetAndStepPtrLoEtc
    call SceneLearnQuick_WriteSpriteSlots
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

; step 0 of SceneLearnQuick: sets wMessageIndex to 1; sets wMessageGroup to 0; advances wScriptStep
; (E-0347)
SceneLearnQuick_SetMessageIndex::
    ld a, $01
    ld [wMessageIndex], a
    xor a
    ld [wMessageGroup], a
    ld hl, wScriptStep
    inc [hl]
    ret

; Branches on wMessageIndex; sets wStepTarget; sets wStepPtrLo to $50; branches on wMessageIndex;
; sets wStepTarget; sets wStepPtrLo to $50; branches on wMessageIndex; sets wStepTarget; sets
; wStepPtrLo to $30; sets wStepTarget; sets wStepPtrLo to $30; sets wStepPtrHi to 1; then 18 more
; steps (see the code) (E-0347)
SceneLearnQuick_WriteStepTargetAndStepPtrLoEtc::
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

; Changes HL and A (E-0347)
SceneLearnQuick_WriteSpriteSlots::
    ld a, [wMessageGroup]
    and $03
    ld hl, SceneLearnQuick_WriteSpriteSlots_Data
    add_a_to_hl
    ld a, [hl]
    ld [wSpriteSlots + $7], a
    ret

; data read by SceneLearnQuick (4 bytes) (E-0347)
SceneLearnQuick_WriteSpriteSlots_Data::
    db $01, $00, $03, $02

; Decrements wScriptParam1; sets wScriptParam0 (E-0347)
SceneLearnQuick_WriteScriptParam0AndSpriteSlots::
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

; implements script command type 11 (SCRIPT_SCENE_FARM_KIDS): a cutscene step named after the scene
; its only script shows: 'You must be the farm kids.' ... 'Warubou Wha? I smell something!'; reached
; through ScriptCommand11 in bank $10 (E-0038, E-0245)
SceneFarmKids::
    ld a, [wScriptStep]
    jumptable
    dw SceneFarmKids_StepScriptParam0Counter_Bank73
    dw SceneFarmKids_ScriptApplyStepDeltaAtDE_Bank73

; step 1 of SceneFarmKids: increments wObject5 + SCRIPTOBJ_Y; calls ScriptApplyStepDeltaAtDE_Bank73;
; may return early; sets wObject5 to 0; sets wScriptStartRequest to $80 (E-0347)
SceneFarmKids_ScriptApplyStepDeltaAtDE_Bank73::
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

; step 0 of SceneFarmKids: sets wObject5 + SCRIPTOBJ_X to $40; sets wObject5 + SCRIPTOBJ_Y to $30;
; sets wObject5 to $80; calls StepScriptParam0Counter_Bank73; may return early; advances wScriptStep
; (E-0347)
SceneFarmKids_StepScriptParam0Counter_Bank73::
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

; wScriptParam0 += 1; if it now equals B it is reset to 0 and carry is set, else carry is clear;
; returns A = 0 either way (the same 18 bytes appear in 3 banks) (E-0351)
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

; [HL] |= $02; clobbers A (the same 5 bytes appear in 4 banks) (E-0351)
SetBit1AtHL_Bank73::
    ld a, [hl]
    or $02
    ld [hl], a
    ret

; [HL] &= $FD; clobbers A (the same 5 bytes appear in 4 banks) (E-0351)
ClearBit1AtHL_Bank73::
    ld a, [hl]
    and $fd
    ld [hl], a
    ret

; sets bit 2 of the byte at [HL]; only A is clobbered (E-0351)
SetBit2AtHL_B73::
    ld a, [hl]
    or $04
    ld [hl], a
    ret

; [HL] &= $FB; clobbers A (the same 5 bytes appear in 4 banks) (E-0351)
ClearBit2AtHL_Bank73::
    ld a, [hl]
    and $fb
    ld [hl], a
    ret

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

; HL is stored in wMessageIndex (low) and wMessageGroup (high); then wMessageState = 0 (E-0351)
StartMessageHL_B73b::
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a
    ld [wMessageState], a
    ret

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

; step 1 of SceneChestBattle: calls RunMessageBoxFar_Bank73; may return early; advances wScriptStep
; (E-0347)
SceneChestBattle_RunMessageBoxFar_Bank73::
    xor a
    call RunMessageBoxFar_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; step 9 of SceneWizstone: calls RunMessageBoxFar_Bank73; may return early; sets wScriptStartRequest
; to $80 (E-0347)
SceneWizstone_RunMessageBoxFar_Bank73::
    xor a
    call RunMessageBoxFar_Bank73
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret
    ds $525, $00
