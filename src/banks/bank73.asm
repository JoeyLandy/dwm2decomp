SECTION "Bank 73", ROMX[$4000], BANK[$73]
    db $73

; implements script command type 82 (SCRIPT_GOLD_ITEM_OR_LOSS), the script of talk category 8: random gold or item (NextRandomSeed, AddGoldCapped, AppendItemWC928ToInventory) or a gold loss (DeductGoldPenaltyAndFormatLoss); reached through ScriptCommand82 in bank $10 (E-0038, E-0286)
; 1 call site from 1 routine (e.g. ScriptCommand82)
; reads: wPendingFieldEvent
GoldItemOrLoss::
Func_073_4001:: ; address name
    ld a, [wPendingFieldEvent]
    and a, $0F
    rst $00
    dw GoldItemOrLoss_Case00
    dw GoldItemOrLoss_Case01
    dw GoldItemOrLoss_Case02
    dw GoldItemOrLoss_Case03
    dw GoldItemOrLoss_Case04
    dw GoldItemOrLoss_Case05
    dw GoldItemOrLoss_Case06
    dw GoldItemOrLoss_Case07
    dw GoldItemOrLoss_Case08
    dw GoldItemOrLoss_Case09
    dw GoldItemOrLoss_Case0A
    dw GoldItemOrLoss_Case0B
    dw GoldItemOrLoss_Case0C
    dw GoldItemOrLoss_Case0C
    dw GoldItemOrLoss_Case0C
    dw GoldItemOrLoss_Case0C

; entry 12 of the `rst $00` table in GoldItemOrLoss
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
GoldItemOrLoss_Case0C::
Jump_073_4027:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw GoldItemOrLoss_Case0C_StartMessageHL_B73AndStep
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case0C_SaveScreenBufferToBGMap1
    dw GoldItemOrLoss_Case0C_ShowGreatLogsMajorFacilitiesAre
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case0C_ShowHeroPeeredIntoThe
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd

; entry 0 of the `rst $00` table in GoldItemOrLoss_Case0C
; no direct call (reached through a table, a jump or a vector)
; reads: wPendingFieldEvent
; points at: wScriptStep
GoldItemOrLoss_Case0C_StartMessageHL_B73AndStep::
Jump_073_403F:: ; address name
    ld a, [wPendingFieldEvent]
    and a, $0F
    sub a, $0C
    add a, $3A
    ld l, a
    ld h, $00
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in GoldItemOrLoss_Case0C
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene, wPendingFieldEvent
; writes: wScriptStep
; points at: wScriptStep
GoldItemOrLoss_Case0C_ShowGreatLogsMajorFacilitiesAre::
Jump_073_4053:: ; address name
    ld a, [wBattleScene]
    or a, a
    jr nz, .check_pending_field_event
    ld hl, $003E ; 'GreatLog's major facilities are situated above'
    call StartMessageHL_B73
    ld a, [wPendingFieldEvent]
    and a, $0F
    sub a, $0C
    add a, a
    ld hl, $4090
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    call SetFlagBit
    ld hl, wScriptStep
    inc [hl]
    ret

.check_pending_field_event:
    ld a, [wPendingFieldEvent]
    and a, $0F
    sub a, $0C
    add a, $3F
    ld l, a
    ld h, $00
    call StartMessageHL_B73
    ld a, $06
    ld [wScriptStep], a
    ret
    db $93, $01, $96, $01, $99, $01, $9C, $01

; entry 11 of the `rst $00` table in GoldItemOrLoss
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
GoldItemOrLoss_Case0B::
Jump_073_4098:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw GoldItemOrLoss_Case0B_Msg4037_HeroTriedToOpen
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case0B_ShowKamehaWahahahNoGoing
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case0C_SaveScreenBufferToBGMap1
    dw GoldItemOrLoss_Case0B_ShowHeroPeeredIntoThe
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case0B_ToScriptStepFlashScreenNegative
    dw GoldItemOrLoss_Case0B_ShowCobiHeroPapasCalling
    dw GoldItemOrLoss_Case0B_WriteScriptParam0AndFieldDrawFlagsEtc
    dw ScriptStepBlinkSpritesThenEnd
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case0C_ShowHeroPeeredIntoThe
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd

; entry 0 of the `rst $00` table in GoldItemOrLoss_Case0B
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
GoldItemOrLoss_Case0B_Msg4037_HeroTriedToOpen::
Jump_073_40BA:: ; address name
    ld hl, $4037 ; '0 tried to open the chest.'
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in GoldItemOrLoss_Case0B
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult
; writes: wScriptStep
; points at: wScriptStep
GoldItemOrLoss_Case0B_ShowKamehaWahahahNoGoing::
Jump_073_40C5:: ; address name
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, .call_start_message_hl_b73
    ld hl, vTiles0 + $49
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b73:
    ld hl, vTiles0 + $48
    call StartMessageHL_B73
    ld a, $0D
    ld [wScriptStep], a
    ret

; entry 5 of the `rst $00` table in GoldItemOrLoss_Case0B
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene, wIsCGB
; writes: wScriptStep
; points at: wBGPaletteBuffer, wBGPaletteCopy, wScriptStep
GoldItemOrLoss_Case0B_ShowHeroPeeredIntoThe::
Jump_073_40E2:: ; address name
    ld a, [wBattleScene]
    or a, a
    jr nz, .call_start_message_hl_b73
    ld hl, $0038 ; '0 peered into the vase. A'
    call StartMessageHL_B73
    ld a, [wIsCGB]
    or a, a
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
    ld hl, $0039 ; 'Hey! You brats! Scram! Hands off'
    call StartMessageHL_B73
    ld a, $0B
    ld [wScriptStep], a
    ret

; entry 7 of the `rst $00` table in GoldItemOrLoss_Case0C
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
GoldItemOrLoss_Case0C_ShowHeroPeeredIntoThe::
Jump_073_4111:: ; address name
    ld hl, $000F ; '0 peered into the barrel. It'
    call StartMessageHL_B73
    call DeductGoldPenaltyAndFormatLoss
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in GoldItemOrLoss
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
GoldItemOrLoss_Case0A::
Jump_073_411F:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw GoldItemOrLoss_Case0A_ShowGoHelpYourMother
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case0A_ShowIfSomeMonsterMasters
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case0A_SaveScreenBufferToBGMap1
    dw GoldItemOrLoss_Case0A_WriteScriptParam0
    dw GoldItemOrLoss_Case0A_ReadJoypadPressed
    dw GoldItemOrLoss_Case0A_ReadFrameCounterLoAndMenuCursor
    dw GoldItemOrLoss_Case0A_RestoreScreenBufferFromBGMap1
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd

; entry 8 of the `rst $00` table in GoldItemOrLoss_Case0A
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wMenuState, wMenuSubState, wMenuSelectedMember
; writes: wScriptParam0, wStepPtrLo, hTemp0, hTemp1
; points at: wScriptStep
GoldItemOrLoss_Case0A_RestoreScreenBufferFromBGMap1::
Jump_073_4139:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $3C
    ret nz
    farcall RestoreScreenBufferFromBGMap1
    farcall DrawFullScreenBufferAtScroll
    ld b, $46
    ld de, Tiles1Gfx_46_4001
    ld hl, vTiles1
    call DecompressToVRAM
    call LoadRecordListNameTiles
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld a, [wMenuState]
    and a, $F0
    swap a
    ld de, SymbolRowTable_453A
    add a, e
    ld e, a
    jr nc, .check_menu_sub_state
    inc d

.check_menu_sub_state:
    ld a, [de]
    ld c, a
    ld a, [wMenuSubState]
    and a, $F0
    swap a
    ld de, SymbolRowTable_4544
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    cp a, c
    jp nz, .loop
    ld a, [wMenuSelectedMember]
    and a, $F0
    swap a
    ld de, SymbolRowTable_454E
    add a, e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    cp a, c
    jp nz, .check_menu_state
    ld a, [wMenuState]
    and a, $F0
    swap a
    ld de, SymbolRowTable_453A
    add a, e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [de]
    or a, a
    jr nz, .skip4
    ld hl, $0032 ; 'Hello, there! You must be the'
    call StartMessageHL_B73
    ld a, $1E
    ld [wStepPtrLo], a
    farcall AppendItemWC928ToInventory
    ret

.skip4:
    dec a
    jr nz, .skip5
    ld hl, $0030 ; 'Heh, so these are the newcomers?'
    call StartMessageHL_B73
    ld a, $2C
    ld [wStepPtrLo], a
    farcall AppendItemWC928ToInventory
    ret

.skip5:
    dec a
    jr nz, .skip6
    ld hl, $0031 ; 'C'mon, Warubou!'
    call StartMessageHL_B73
    ld hl, $03E8
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
    ld hl, $01F4
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall AddGoldCapped
    ret

.call_start_message_hl_b73:
    ld hl, $0045 ; 'You must be the farm kids.'
    call StartMessageHL_B73
    ld hl, $00C8
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall AddGoldCapped
    ret

.loop:
    ld hl, $0035 ; 'The King is too lenient on'
    call StartMessageHL_B73
    ret

.check_menu_state:
    ld a, [wMenuState]
    and a, $F0
    swap a
    ld de, SymbolRowTable_453A
    add a, e
    ld e, a
    jr nc, .skip7
    inc d

.skip7:
    ld a, [de]
    or a, a
    jr nz, .skip8
    ld hl, $0046 ; 'Thanks for coming by. I'll always'
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
    ld hl, $0047 ; '0 read the notice. We guarantee'
    call StartMessageHL_B73
    ld hl, $0032
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall AddGoldCapped
    ret

; entry 7 of the `rst $00` table in GoldItemOrLoss_Case0A
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo, wMenuCursor
; points at: wMenuState, wScriptStep, wMenuSubState, wMenuSelectedMember
GoldItemOrLoss_Case0A_ReadFrameCounterLoAndMenuCursor::
Jump_073_4269:: ; address name
    call GoldItemOrLoss_WaitFrameCounterLo
    ld a, [wFrameCounterLo]
    and a, $01
    jr z, .call_gold_item_or_loss_write_temp0_and_temp1
    ld a, [wMenuCursor]
    dec a
    jr nz, .skip
    ld hl, wMenuState
    call GoldItemOrLoss_Case0A_Case07_Sub01
    or a, a
    jr z, .call_gold_item_or_loss_write_temp0_and_temp1
    ld hl, wScriptStep
    dec [hl]
    jr .call_gold_item_or_loss_write_temp0_and_temp1

.skip:
    dec a
    jr nz, .call_gold_item_or_loss_case0_a_case07_sub01
    ld hl, wMenuSubState
    call GoldItemOrLoss_Case0A_Case07_Sub01
    or a, a
    jr z, .call_gold_item_or_loss_write_temp0_and_temp1
    ld hl, wScriptStep
    dec [hl]
    jr .call_gold_item_or_loss_write_temp0_and_temp1

.call_gold_item_or_loss_case0_a_case07_sub01:
    ld hl, wMenuSelectedMember
    call GoldItemOrLoss_Case0A_Case07_Sub01
    or a, a
    jr z, .call_gold_item_or_loss_write_temp0_and_temp1
    ld hl, wScriptStep
    inc [hl]

.call_gold_item_or_loss_write_temp0_and_temp1:
    call GoldItemOrLoss_WriteTemp0AndTemp1
    ret

; only called from GoldItemOrLoss_Case0A_Case07 (E-0047)
; 3 call sites from 1 routine (e.g. GoldItemOrLoss_Case0A_ReadFrameCounterLoAndMenuCursor)
GoldItemOrLoss_Case0A_Case07_Sub01::
Func_073_42AB:: ; address name
    ld a, [hl]
    and a, $0F
    jr z, .return_01
    ld a, [hl]
    inc a
    ld [hl], a
    and a, $F0
    swap a
    cp a, $0A
    jr nz, .return_0
    xor a, a
    ld [hl], a

.return_0:
    xor a, a
    ret

.return_01:
    ld a, $01
    ret

; entry 6 of the `rst $00` table in GoldItemOrLoss_Case0A
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed
; points at: wMenuCursor, wScriptStep
GoldItemOrLoss_Case0A_ReadJoypadPressed::
Jump_073_42C2:: ; address name
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .call_gold_item_or_loss_wait_frame_counter_lo
    ld hl, wMenuCursor
    inc [hl]
    ld hl, wScriptStep
    inc [hl]

.call_gold_item_or_loss_wait_frame_counter_lo:
    call GoldItemOrLoss_WaitFrameCounterLo
    call GoldItemOrLoss_WriteTemp0AndTemp1
    ret

; entry 5 of the `rst $00` table in GoldItemOrLoss_Case0A
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0
; points at: wScriptStep
GoldItemOrLoss_Case0A_WriteScriptParam0::
Jump_073_42D8:: ; address name
    call GoldItemOrLoss_WaitFrameCounterLo
    call GoldItemOrLoss_WriteTemp0AndTemp1
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

; entry 4 of the `rst $00` table in GoldItemOrLoss_Case0A
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyRandomHi, wIsCGB
; writes: wMenuState, wMenuSubState, wMenuSelectedMember, wMenuCursor, rSVBK
; points at: wScreenTileBuffer, wScriptStep
GoldItemOrLoss_Case0A_SaveScreenBufferToBGMap1::
Jump_073_42F1:: ; address name
    farcall SaveScreenBufferToBGMap1
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $07
    swap a
    ld [wMenuState], a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $07
    swap a
    ld [wMenuSubState], a
    call NextRandomSeed
    ld a, [wKeyRandomHi]
    and a, $07
    swap a
    ld [wMenuSelectedMember], a
    xor a, a
    ld [wMenuCursor], a
    call GoldItemOrLoss_WriteTemp0AndTemp1
    ld de, $4378
    ld hl, wScreenTileBuffer
    ld b, $03

.loop:
    push hl
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
    ld a, [de]
    inc de
    ld [hl+], a
    pop hl
    ld a, [wIsCGB]
    or a, a
    jr z, .skip
    push hl
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
    ld a, $02
    ldh [rSVBK], a
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    xor a, a
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
    db $B0, $B1, $B1, $B1, $B2, $B6, $A4, $A5, $A6, $B7, $B3, $B4, $B4, $B4, $B5

; entry 2 of the `rst $00` table in GoldItemOrLoss_Case0A
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult
; writes: hTemp0, hTemp1, wScriptStep
; points at: wScriptStep
GoldItemOrLoss_Case0A_ShowIfSomeMonsterMasters::
Jump_073_4387:: ; address name
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, .call_start_message_hl_b73
    ld hl, $002F ; 'If some monster masters keep their'
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
    ld hl, $0036 ; 'There were many wild monsters in'
    call StartMessageHL_B73
    ld a, $09
    ld [wScriptStep], a
    ret

; entry 0 of the `rst $00` table in GoldItemOrLoss_Case0A
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
GoldItemOrLoss_Case0A_ShowGoHelpYourMother::
Jump_073_43B3:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, $002E ; 'Go help your mother now.'
    call StartMessageHL_B73
    ret

; only called from routines of GoldItemOrLoss (E-0098)
; 3 call sites from 3 routines (e.g. GoldItemOrLoss_Case0A_ReadFrameCounterLoAndMenuCursor, GoldItemOrLoss_Case0A_ReadJoypadPressed, GoldItemOrLoss_Case0A_WriteScriptParam0)
; reads: wFrameCounterLo, wMenuCursor, wMenuState, wMenuSubState, wMenuSelectedMember
; writes: wMenuState, wMenuSubState, wMenuSelectedMember
GoldItemOrLoss_WaitFrameCounterLo::
Func_073_43BE:: ; address name
    ld a, [wFrameCounterLo]
    and a, $01
    ret z
    ld a, [wMenuCursor]
    cp a, $03
    ret z
    or a, a
    jr nz, .check_menu_cursor
    ld a, [wMenuState]
    add a, $02
    ld [wMenuState], a
    and a, $F0
    swap a
    cp a, $0A
    jr nz, .check_menu_cursor
    ld a, [wMenuState]
    and a, $0F
    ld [wMenuState], a

.check_menu_cursor:
    ld a, [wMenuCursor]
    cp a, $02
    jr z, .read_menu_selected_member
    ld a, [wMenuSubState]
    add a, $01
    ld [wMenuSubState], a
    and a, $F0
    swap a
    cp a, $0A
    jr nz, .read_menu_selected_member
    ld a, [wMenuSubState]
    and a, $0F
    ld [wMenuSubState], a

.read_menu_selected_member:
    ld a, [wMenuSelectedMember]
    add a, $04
    ld [wMenuSelectedMember], a
    and a, $F0
    swap a
    cp a, $0A
    jr nz, .return
    ld a, [wMenuSelectedMember]
    and a, $0F
    ld [wMenuSelectedMember], a

.return:
    ret

; only called from routines of GoldItemOrLoss (E-0098)
; 4 call sites from 4 routines (e.g. GoldItemOrLoss_Case0A_ReadFrameCounterLoAndMenuCursor, GoldItemOrLoss_Case0A_ReadJoypadPressed, GoldItemOrLoss_Case0A_WriteScriptParam0, GoldItemOrLoss_Case0A_SaveScreenBufferToBGMap1)
; reads: wMenuState, wMenuSubState, wMenuSelectedMember
; writes: hTemp0, hTemp1
GoldItemOrLoss_WriteTemp0AndTemp1::
Func_073_441D:: ; address name
    ld hl, vTiles1 + $240
    ld a, [wMenuState]
    and a, $F0
    swap a
    push af
    ld de, SymbolRowTable_453A
    add a, e
    ld e, a
    jr nc, .set_temp0
    inc d

.set_temp0:
    ld a, [de]
    ldh [hTemp0], a
    pop af
    inc a
    cp a, $0A
    jr nz, .skip
    ld a, $00

.skip:
    ld de, SymbolRowTable_453A
    add a, e
    ld e, a
    jr nc, .set_temp1
    inc d

.set_temp1:
    ld a, [de]
    ldh [hTemp1], a
    ld a, [wMenuState]
    call GoldItemOrLoss_Shared02_WriteVRAMByteInc
    ld a, [wMenuSubState]
    and a, $F0
    swap a
    push af
    ld de, SymbolRowTable_4544
    add a, e
    ld e, a
    jr nc, .set_temp02
    inc d

.set_temp02:
    ld a, [de]
    ldh [hTemp0], a
    pop af
    inc a
    cp a, $0A
    jr nz, .skip2
    ld a, $00

.skip2:
    ld de, SymbolRowTable_4544
    add a, e
    ld e, a
    jr nc, .set_temp12
    inc d

.set_temp12:
    ld a, [de]
    ldh [hTemp1], a
    ld a, [wMenuSubState]
    call GoldItemOrLoss_Shared02_WriteVRAMByteInc
    ld a, [wMenuSelectedMember]
    and a, $F0
    swap a
    push af
    ld de, SymbolRowTable_454E
    add a, e
    ld e, a
    jr nc, .set_temp03
    inc d

.set_temp03:
    ld a, [de]
    ldh [hTemp0], a
    pop af
    inc a
    cp a, $0A
    jr nz, .skip3
    ld a, $00

.skip3:
    ld de, SymbolRowTable_454E
    add a, e
    ld e, a
    jr nc, .set_temp13
    inc d

.set_temp13:
    ld a, [de]
    ldh [hTemp1], a
    ld a, [wMenuSelectedMember]
    call GoldItemOrLoss_Shared02_WriteVRAMByteInc
    ret

; only called from GoldItemOrLoss_Shared02 (E-0047)
; 3 call sites from 1 routine (e.g. GoldItemOrLoss_WriteTemp0AndTemp1)
; reads: hTemp1, hTemp2, hTemp0
; writes: hTemp2
GoldItemOrLoss_Shared02_WriteVRAMByteInc::
Func_073_44A5:: ; address name
    and a, $0E
    ldh [hTemp2], a
    or a, a
    jr z, .read_temp23
    ldh a, [hTemp1]
    swap a
    ld de, SymbolTiles_73_44EA
    add a, e
    ld e, a
    jr nc, .read_temp2
    inc d

.read_temp2:
    ldh a, [hTemp2]
    ld c, a
    ld a, $10
    sub a, c
    add a, e
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
    sub a, c
    ld b, a
    ldh a, [hTemp0]
    swap a
    ld de, SymbolTiles_73_44EA
    add a, e
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

; E-0214 (C1: the routine at GoldItemOrLoss_Shared02_WriteVRAMByteInc.loop / GoldItemOrLoss_Shared02_WriteVRAMByteInc.loop2 copies 16 bytes, or a part of them, from $44EA + 16 * hTemp1 (or hTemp0) to VRAM with WriteVRAMByteInc; 5 tiles end at the first of three 10-byte tables).
; record: one 2bpp tile (16 bytes)
SymbolTiles_73_44EA::
Data_073_44EA:: ; address name
    db $FF, $00, $FF, $10, $FF, $38, $FF, $FE, $FF, $7C, $FF, $38, $FF, $7C, $FF, $C6 ; id 0
    db $FF, $00, $FF, $38, $FF, $7C, $FF, $FE, $FF, $FE, $FF, $FE, $FF, $7C, $FF, $38 ; id 1
    db $FF, $00, $FF, $7E, $FF, $7E, $FF, $7E, $FF, $7E, $FF, $7E, $FF, $7E, $FF, $00 ; id 2
    db $FF, $00, $FF, $00, $FF, $10, $FF, $38, $FF, $7C, $FF, $FE, $FF, $FE, $FF, $00 ; id 3
    db $FF, $00, $FF, $00, $FF, $44, $FF, $28, $FF, $10, $FF, $28, $FF, $44, $FF, $00 ; id 4

; E-0214 (C1: bank-$73 code reads the byte at $453A + (wMenuState >> 4) and compares the three tables' values with each other; values 0-4, one of the five tiles of SymbolTiles_73_44EA).
; record: symbol number 0-4
SymbolRowTable_453A::
Data_073_453A:: ; address name
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

; E-0214 (C1: bank-$73 code reads the byte at $4544 + (wMenuSubState >> 4) and compares the three tables' values with each other; values 0-4, one of the five tiles of SymbolTiles_73_44EA).
; record: symbol number 0-4
SymbolRowTable_4544::
Data_073_4544:: ; address name
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

; E-0214 (C1: bank-$73 code reads the byte at $454E + (wMenuSelectedMember >> 4) and compares the three tables' values with each other; values 0-4, one of the five tiles of SymbolTiles_73_44EA).
; record: symbol number 0-4
SymbolRowTable_454E::
Data_073_454E:: ; address name
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

; HL = $C6FE + A; with SRAM enabled ($0100 = $0A) adds the byte at $45CA + wScriptParam0 to the 16-bit value read through Func_000_1F89, caps it at 999, writes it back through Func_000_1FD1, stores the difference in wC8C0/wC8C1 and shows it (Func_000_173A, Func_000_23CA); no caller found (E-0214)
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wMenuState, hTemp0, hTemp1, hTemp3, hTemp2
; writes: rRAMG, hTemp2, hTemp3, wDigits
; points at: wPartyList, wTextNumber
AddRewardToCounterCappedAt999:: ; configured code entry (E-0214); C0
Func_073_4558:: ; address name
    ld hl, wPartyList
    add_a_to_hl
    ld a, $0A
    ld [rRAMG], a
    ld a, [wScriptParam0]
    ld de, RewardAmounts_73_45CA
    add a, e
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
    add a, c
    ldh [hTemp2], a
    ldh a, [hTemp1]
    adc a, $00
    ldh [hTemp3], a
    pop bc
    ldh a, [hTemp3]
    cp a, $03
    jr nz, .call_sram_record_address
    ldh a, [hTemp2]
    cp a, $E8
    jr c, .call_sram_record_address
    ld de, $03E7
    ld a, e
    ldh [hTemp2], a
    ld a, d
    ldh [hTemp3], a

.call_sram_record_address:
    ld a, [hl]
    call SRAMRecordAddress
    ldh a, [hTemp2]
    ld [hl+], a
    ldh a, [hTemp3]
    ld [hl], a
    xor a, a
    ld [rRAMG], a
    ldh a, [hTemp0]
    ld c, a
    ldh a, [hTemp2]
    sub a, c
    ld [wDigits], a
    ldh a, [hTemp1]
    ld c, a
    ldh a, [hTemp3]
    sbc a, c
    ld [wDigits + $1], a
    xor a, a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ld de, wTextNumber
    call WritePackedBCDNoLeadingZeros
    ret

; E-0214 (C1: AddRewardToCounterCappedAt999 adds the byte at $45CA + wScriptParam0; 6 bytes end at the code after them).
; record: amount added
RewardAmounts_73_45CA::
Data_073_45CA:: ; address name
    db $5D ; id 0
    db $61 ; id 1
    db $63 ; id 2
    db $65 ; id 3
    db $67 ; id 4
    db $69 ; id 5

; entry 8 of the `rst $00` table in GoldItemOrLoss
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
GoldItemOrLoss_Case08::
Jump_073_45D0:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw GoldItemOrLoss_Case08_ShowTaraWellBeOK
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case08_ShowHeroCheckedTheBookshelf
    dw GoldItemOrLoss_Case08_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case08_ToScriptStepFlashScreenNegative
    dw GoldItemOrLoss_Case08_Msg0052_OhMyTheWell
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd

; entry 0 of the `rst $00` table in GoldItemOrLoss_Case08
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
GoldItemOrLoss_Case08_ShowTaraWellBeOK::
Jump_073_45E4:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, $4021 ; 'Tara We'll be OK! I'm going'
    call StartMessageHL_B73
    ret

; entry 2 of the `rst $00` table in GoldItemOrLoss_Case08
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult
; writes: wVisitedScreens, hTemp0, hTemp1, wScriptStep
; points at: wScriptStep
GoldItemOrLoss_Case08_ShowHeroCheckedTheBookshelf::
Jump_073_45EF:: ; address name
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, .call_start_message_hl_b73
    ld hl, vTiles0 + $23
    call StartMessageHL_B73
    ld a, $FF
    ld [wVisitedScreens], a
    ld [wVisitedScreens + $1], a
    ld [wVisitedScreens + $2], a
    ld [wVisitedScreens + $3], a
    ld [wVisitedScreens + $4], a
    ld [wVisitedScreens + $5], a
    ld [wVisitedScreens + $6], a
    ld [wVisitedScreens + $7], a
    ld hl, $00C8
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

; entry 4 of the `rst $00` table in GoldItemOrLoss_Case08
; no direct call (reached through a table, a jump or a vector)
GoldItemOrLoss_Case08_ToScriptStepFlashScreenNegative::
Jump_073_4635:: ; address name
    farcall ScriptStepFlashScreenNegative
    ret

; entry 5 of the `rst $00` table in GoldItemOrLoss_Case08
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
GoldItemOrLoss_Case08_Msg0052_OhMyTheWell::
Jump_073_463C:: ; address name
    ld hl, $0052 ; 'Oh my, the well isn't safe!'
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in GoldItemOrLoss
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
GoldItemOrLoss_Case06::
Jump_073_4647:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw GoldItemOrLoss_Case06_CopyItemNameToDE
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case06_ShowThisIsATale
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case06_ShowSlashIfYoureIn
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd
    dw $0000 ; unused index (E-0207)
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case06_ShowThereArentManyFriends
    dw $0000 ; unused index (E-0207)
    dw $0000 ; unused index (E-0207)
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case06_ShowThisHayIsPretty
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd

; entry 13 of the `rst $00` table in GoldItemOrLoss_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuSelectedMember
; writes: wStepPtrLo
; points at: wScriptStep
GoldItemOrLoss_Case06_ShowThisHayIsPretty::
Jump_073_466F:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, $001B ; 'This hay is pretty good. Maybe'
    call StartMessageHL_B73
    ld a, [wMenuSelectedMember]
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld a, [wMenuSelectedMember]
    ld [wStepPtrLo], a
    farcall AppendItemWC928ToInventory
    ret

; entry 9 of the `rst $00` table in GoldItemOrLoss_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult, wMenuSubState
; writes: wMenuState, wScriptStep
GoldItemOrLoss_Case06_ShowThereArentManyFriends::
Jump_073_468F:: ; address name
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, .call_start_message_hl_b73
    ld a, [wMenuSubState]
    ld [wMenuState], a
    ld hl, wShadowOAM + $19
    call StartMessageHL_B73
    ld a, $03
    ld [wScriptStep], a
    ret

.call_start_message_hl_b73:
    ld hl, vTiles0 + $1A
    call StartMessageHL_B73
    ld a, $0C
    ld [wScriptStep], a
    ret

; entry 4 of the `rst $00` table in GoldItemOrLoss_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyRandomLo, wMenuState, wMenuSubState, wScriptParam1, wDigits, wGoldLo, wGoldMid, wGoldHi, ...
; writes: wMenuSubState, wDigits, wGoldLo, wGoldMid, wGoldHi, wScriptParam1, wMenuSelectedMember, wStepPtrLo, ...
; points at: wTextNumber, wScriptStep
GoldItemOrLoss_Case06_ShowSlashIfYoureIn::
Jump_073_46B3:: ; address name
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and a, $0F
    cp a, $0D
    jr nc, GoldItemOrLoss_Case06_ShowSlashIfYoureIn
    ld [wMenuSubState], a
    inc a
    ld [wDigits], a
    xor a, a
    ld [wDigits + $1], a
    xor a, a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ld de, wTextNumber
    call WritePackedBCDNoLeadingZeros
    ld a, [wMenuState]
    ld c, a
    ld a, [wMenuSubState]
    cp a, c
    jr nz, .check_text_yes_no_result
    ld hl, vTiles0 + $18
    call StartMessageHL_B73
    jp .read_script_param1

.check_text_yes_no_result:
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, .read_menu_state
    ld a, [wMenuState]
    ld c, a
    ld a, [wMenuSubState]
    cp a, c
    jp c, .call_start_message_hl_b73
    jr .check_script_param1

.read_menu_state:
    ld a, [wMenuState]
    ld c, a
    ld a, [wMenuSubState]
    cp a, c
    jp nc, .call_start_message_hl_b73
    jr .check_script_param1

.check_script_param1:
    ld a, [wScriptParam1]
    inc a
    ld [wScriptParam1], a
    ld a, [wScriptParam0]
    ld [wMenuSelectedMember], a
    ld a, [wScriptParam1]
    cp a, $05
    jr nz, .call_next_random_seed
    ld hl, vTiles0 + $1C
    call StartMessageHL_B73
    ld a, [wMenuSelectedMember]
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld a, [wMenuSelectedMember]
    ld [wStepPtrLo], a
    farcall AppendItemWC928ToInventory
    ld a, $0E
    ld [wScriptStep], a
    ret

.call_next_random_seed:
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and a, $03
    ld hl, $4822
    add_a_to_hl
    ld a, [wScriptParam1]
    add a, a
    add a, a
    add_a_to_hl
    ld a, [hl]
    ld [wScriptParam0], a
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld a, [wScriptParam1]
    sla a
    ld hl, $4836
    add_a_to_hl
    ld a, [hl+]
    ld [wDigits], a
    ld a, [hl]
    ld [wDigits + $1], a
    xor a, a
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
    add a, a
    ld hl, $4836
    add_a_to_hl
    ld a, [hl+]
    ld [wDigits], a
    ld a, [hl]
    ld [wDigits + $1], a
    xor a, a
    ld [wDigits + $2], a
    ld a, [wDigits]
    ld c, a
    ld a, [wGoldLo]
    sub a, c
    ld [wGoldLo], a
    ld a, [wDigits + $1]
    ld c, a
    ld a, [wGoldMid]
    sbc a, c
    ld [wGoldMid], a
    ld a, [wGoldHi]
    sbc a, $00
    ld [wGoldHi], a
    call Number24ToPackedBCD
    ld de, wTextNumber + $3
    call WritePackedBCDNoLeadingZeros
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in GoldItemOrLoss_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult
; writes: wMenuState, wScriptStep
; points at: wScriptStep
GoldItemOrLoss_Case06_ShowThisIsATale::
Jump_073_47DB:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wTextYesNoResult]
    or a, a
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

; entry 0 of the `rst $00` table in GoldItemOrLoss_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyRandomLo
; writes: wScriptParam0
; points at: wScriptStep
GoldItemOrLoss_Case06_CopyItemNameToDE::
Jump_073_47FD:: ; address name
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and a, $03
    ld hl, $4822
    add_a_to_hl
    ld a, [hl]
    ld [wScriptParam0], a
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld hl, $4013 ; 'Tara Big brother! GreatLog will be'
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret
    db $03, $22, $28, $2A, $0B, $25, $05, $2B, $0C, $23, $27, $2C, $11, $12, $26, $1E
    db $0D, $0E, $0F, $10, $64, $00, $2C, $01, $58, $02, $E8, $03, $DC, $05

; entry 9 of the `rst $00` table in GoldItemOrLoss
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
GoldItemOrLoss_Case09::
Jump_073_4840:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw GoldItemOrLoss_Case09_ShowHeroCheckedTheDresser
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case09_ShowWarubouWhatIsThis
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case0C_SaveScreenBufferToBGMap1
    dw GoldItemOrLoss_Case09_ShowHeroCheckedTheDresser_Case05
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case09_ProcessRecordFields5DTo69ThenItemString
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case09_ProcessRecordFields5DTo69ThenItemString_Case09
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case09_ShowHeroCheckedTheOven
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd

; entry 0 of the `rst $00` table in GoldItemOrLoss_Case09
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
GoldItemOrLoss_Case09_ShowHeroCheckedTheDresser::
Jump_073_4860:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, $4024 ; '0 checked the dresser. Children's clothes'
    call StartMessageHL_B73
    ret

; entry 2 of the `rst $00` table in GoldItemOrLoss_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult
; writes: wScriptStep
; points at: wScriptStep
GoldItemOrLoss_Case09_ShowWarubouWhatIsThis::
Jump_073_486B:: ; address name
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, .call_start_message_hl_b73
    ld hl, vTiles0 + $51
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b73:
    ld hl, vTiles0 + $50
    call StartMessageHL_B73
    ld a, $0C
    ld [wScriptStep], a
    ret

; entry 5 of the `rst $00` table in GoldItemOrLoss_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene
; points at: wScriptStep
GoldItemOrLoss_Case09_ShowHeroCheckedTheDresser_Case05::
Jump_073_4888:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wBattleScene]
    or a, a
    jr nz, .call_start_message_hl_b73
    ld hl, $0025 ; '0 checked the dresser. It smelled'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, $0053 ; 'Warubou Wa-hey! I'm starving!'
    call StartMessageHL_B73
    ret

; entry 7 of the `rst $00` table in GoldItemOrLoss_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene, wPartyCount, wPartyList, hTemp0
; writes: wScriptStep, rRAMG
; points at: wScriptStep
GoldItemOrLoss_Case09_ProcessRecordFields5DTo69ThenItemString::
Jump_073_48A0:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wBattleScene]
    or a, a
    jr nz, .call_start_message_hl_b73
    ld a, $00
    call ProcessRecordFields5DTo69ThenItemString
    ld a, $00
    call GoldItemOrLoss_CopyRecordNameToNameGlyphBuf
    ld a, $00
    call GoldItemOrLoss_LoadSRAMRecordWord
    ld a, [wPartyCount]
    dec a
    jr nz, .read_party_list

.loop:
    ld hl, $0026 ; '0 checked the oven. It smelled'
    call StartMessageHL_B73
    ld a, $0C
    ld [wScriptStep], a
    ret

.read_party_list:
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyList + $1]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG], a
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .loop
    ld hl, $4026 ; '0 checked the oven. It smelled'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, $000F ; '0 peered into the barrel. It'
    call StartMessageHL_B73
    call DeductGoldPenaltyAndFormatLoss
    ld a, $0C
    ld [wScriptStep], a
    ret

; entry 9 of the `rst $00` table in GoldItemOrLoss_Case09
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount, wPartyList, hTemp0
; writes: wScriptStep, rRAMG
; points at: wScriptStep
GoldItemOrLoss_Case09_ProcessRecordFields5DTo69ThenItemString_Case09::
Jump_073_48F8:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, $01
    call ProcessRecordFields5DTo69ThenItemString
    ld a, $01
    call GoldItemOrLoss_CopyRecordNameToNameGlyphBuf
    ld a, $01
    call GoldItemOrLoss_LoadSRAMRecordWord
    ld a, [wPartyCount]
    dec a
    dec a
    jr nz, .read_party_list

.loop:
    ld hl, vTiles0 + $26
    call StartMessageHL_B73
    ld a, $0C
    ld [wScriptStep], a
    ret

.read_party_list:
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyList + $2]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG], a
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .loop
    ld hl, wShadowOAM + $26
    call StartMessageHL_B73
    ret

; entry 11 of the `rst $00` table in GoldItemOrLoss_Case09
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
GoldItemOrLoss_Case09_ShowHeroCheckedTheOven::
Jump_073_493C:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, vTiles0 + $26
    call StartMessageHL_B73
    ld a, $02
    call ProcessRecordFields5DTo69ThenItemString
    ld a, $02
    call GoldItemOrLoss_CopyRecordNameToNameGlyphBuf
    ld a, $02
    call GoldItemOrLoss_LoadSRAMRecordWord
    ret

; for record wC6FE[A]: passes word field $5D and word fields $61, $63, $65, $67, $69 (B = 1-5) to Func_073_49B1, then copies the item string to wC152 (E-0121)
; 3 call sites from 3 routines (e.g. GoldItemOrLoss_Case09_ShowHeroCheckedTheOven, GoldItemOrLoss_Case09_ProcessRecordFields5DTo69ThenItemString_Case09, GoldItemOrLoss_Case09_ProcessRecordFields5DTo69ThenItemString)
; reads: hTemp0, hTemp1
; writes: rRAMG, hTemp2
; points at: wPartyList
ProcessRecordFields5DTo69ThenItemString::
Func_073_4956:: ; address name
    ld hl, wPartyList
    add_a_to_hl
    ld a, $0A
    ld [rRAMG], a
    xor a, a
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
    xor a, a
    ld [rRAMG], a
    call CopyItemStringToWC152
    ret

; only called from ProcessRecordFields5DTo69ThenItemString (E-0047)
; 5 call sites from 1 routine (e.g. ProcessRecordFields5DTo69ThenItemString)
; reads: hTemp1, hTemp0
; writes: hTemp2
ProcessRecordFields5DTo69ThenItemString_WriteTemp2::
Func_073_49B1:: ; address name
    ldh a, [hTemp1]
    cp a, d
    jr c, .set_temp2
    ret nz
    ldh a, [hTemp0]
    cp a, e
    ret nc

.set_temp2:
    ld a, b
    ldh [hTemp2], a
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    ret

; wScriptParam0 = hFFC8; copies string hFFC8 + $28 of category 5 (item names) to wC152 (CopyStringToBuffer_Bank09) (E-0118)
; 1 call site from 1 routine (e.g. ProcessRecordFields5DTo69ThenItemString)
; reads: hTemp2
; writes: wScriptParam0, wStringIndex, wStringCategory, wStringDestLo, wStringDestHi
CopyItemStringToWC152::
Func_073_49C5:: ; address name
    ldh a, [hTemp2]
    ld [wScriptParam0], a
    add a, $28
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

; only called from routines of GoldItemOrLoss (E-0098)
; 3 call sites from 3 routines (e.g. GoldItemOrLoss_Case09_ShowHeroCheckedTheOven, GoldItemOrLoss_Case09_ProcessRecordFields5DTo69ThenItemString_Case09, GoldItemOrLoss_Case09_ProcessRecordFields5DTo69ThenItemString)
; writes: rRAMG
; points at: wPartyList, wNameGlyphBuf
GoldItemOrLoss_CopyRecordNameToNameGlyphBuf::
Func_073_49E6:: ; address name
    ld hl, wPartyList
    add_a_to_hl
    ld a, $0A
    ld [rRAMG], a
    ld a, [hl]
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    xor a, a
    ld [rRAMG], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf1 + $7
    ld b, $0A

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld a, $F0
    ld [de], a
    ret

; only called from routines of GoldItemOrLoss (E-0098)
; 3 call sites from 3 routines (e.g. GoldItemOrLoss_Case09_ShowHeroCheckedTheOven, GoldItemOrLoss_Case09_ProcessRecordFields5DTo69ThenItemString_Case09, GoldItemOrLoss_Case09_ProcessRecordFields5DTo69ThenItemString)
; reads: wScriptParam0, hTemp0, hTemp1, hTemp3, hTemp2
; writes: rRAMG, hTemp2, hTemp3, wDigits
; points at: wPartyList, wTextNumber
GoldItemOrLoss_LoadSRAMRecordWord::
Func_073_4A0F:: ; address name
    ld hl, wPartyList
    add_a_to_hl
    ld a, $0A
    ld [rRAMG], a
    ld a, [wScriptParam0]
    ld de, $4A7C
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld c, a
    ld a, [hl]
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    add a, $14
    ldh [hTemp2], a
    ldh a, [hTemp1]
    adc a, $00
    ldh [hTemp3], a
    ldh a, [hTemp3]
    cp a, $03
    jr nz, .call_sram_record_address
    ldh a, [hTemp2]
    cp a, $E8
    jr c, .call_sram_record_address
    ld de, $03E7
    ld a, e
    ldh [hTemp2], a
    ld a, d
    ldh [hTemp3], a

.call_sram_record_address:
    ld a, [hl]
    call SRAMRecordAddress
    ldh a, [hTemp2]
    ld [hl+], a
    ldh a, [hTemp3]
    ld [hl], a
    xor a, a
    ld [rRAMG], a
    ldh a, [hTemp0]
    ld c, a
    ldh a, [hTemp2]
    sub a, c
    ld [wDigits], a
    ldh a, [hTemp1]
    ld c, a
    ldh a, [hTemp3]
    sbc a, c
    ld [wDigits + $1], a
    xor a, a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ld de, wTextNumber
    call WritePackedBCDNoLeadingZeros
    ret
    db $5D, $61, $63, $65, $67, $69

; entry 7 of the `rst $00` table in GoldItemOrLoss
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
GoldItemOrLoss_Case07::
Jump_073_4A82:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw GoldItemOrLoss_Case07_ShowHeroPeeredIntoThe
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case07_ShowWarubouItsADead
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case0C_SaveScreenBufferToBGMap1
    dw GoldItemOrLoss_Case07_ShowYouEComeAt
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case07_ShowThisHayIsPretty
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case07_ShowThisHayIsPretty_Case0B

; entry 0 of the `rst $00` table in GoldItemOrLoss_Case07
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
GoldItemOrLoss_Case07_ShowHeroPeeredIntoThe::
Jump_073_4A9E:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, $401D ; '0 peered into the barrel. It'
    call StartMessageHL_B73
    ret

; entry 2 of the `rst $00` table in GoldItemOrLoss_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult
; writes: wScriptStep
; points at: wScriptStep
GoldItemOrLoss_Case07_ShowWarubouItsADead::
Jump_073_4AA9:: ; address name
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, .call_start_message_hl_b73
    ld hl, vTiles0 + $4B
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b73:
    ld hl, vTiles0 + $4A
    call StartMessageHL_B73
    ld a, $08
    ld [wScriptStep], a
    ret

; entry 5 of the `rst $00` table in GoldItemOrLoss_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene
; points at: wScriptStep
GoldItemOrLoss_Case07_ShowYouEComeAt::
Jump_073_4AC6:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wBattleScene]
    or a, a
    jr nz, .call_start_message_hl_b73
    ld hl, $001E ; 'You e come at the right'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, $001F ; 'Cobi Sure, Mama! We'll be fine.'
    call StartMessageHL_B73
    ret

; entry 7 of the `rst $00` table in GoldItemOrLoss_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene, wKeyRandomLo, wStepPtrLo, wInventory
; writes: wStepPtrLo, wScriptStep
; points at: wScriptStep
GoldItemOrLoss_Case07_ShowThisHayIsPretty::
Jump_073_4ADE:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wBattleScene]
    or a, a
    jr nz, .call_start_message_hl_b732
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and a, $03
    add a, $19
    ld [wStepPtrLo], a
    farcall AppendItemWC928ToInventory
    ld a, [wStepPtrLo]
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld a, [wInventory + $17]
    or a, a
    jr z, .call_start_message_hl_b73
    cp a, $FF
    jr z, .call_start_message_hl_b73
    ld hl, $001B ; 'This hay is pretty good. Maybe'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, $401B ; 'This hay is pretty good. Maybe'
    call StartMessageHL_B73
    ld a, $0A
    ld [wScriptStep], a
    ret

.call_start_message_hl_b732:
    ld hl, $000F ; '0 peered into the barrel. It'
    call StartMessageHL_B73
    call DeductGoldPenaltyAndFormatLoss
    ret

; entry 11 of the `rst $00` table in GoldItemOrLoss_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wKeyRandomLo, wStepPtrLo, wInventory
; writes: wStepPtrLo, wScriptStep
; points at: wScriptStep
GoldItemOrLoss_Case07_ShowThisHayIsPretty_Case0B::
Jump_073_4B2B:: ; address name
    call NextRandomSeed
    ld a, [wKeyRandomLo]
    and a, $03
    add a, $19
    ld [wStepPtrLo], a
    farcall AppendItemWC928ToInventory
    ld a, [wStepPtrLo]
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld a, [wInventory + $17]
    or a, a
    jr z, .call_start_message_hl_b73
    cp a, $FF
    jr z, .call_start_message_hl_b73
    ld hl, vTiles0 + $1B
    call StartMessageHL_B73
    ld a, $08
    ld [wScriptStep], a
    ret

.call_start_message_hl_b73:
    ld hl, wShadowOAM + $1B
    call StartMessageHL_B73
    ld hl, wScriptStep
    dec [hl]
    ret

; entry 5 of the `rst $00` table in GoldItemOrLoss
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
GoldItemOrLoss_Case05::
Jump_073_4B68:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw GoldItemOrLoss_Case05_ShowHeroPeeredIntoThe
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case05_ShowWarubouWaheyGiveMe
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case0C_SaveScreenBufferToBGMap1
    dw GoldItemOrLoss_Case05_ShowCobiHeroTheySaid
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case05_StartMessageHL_B73
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd

; entry 0 of the `rst $00` table in GoldItemOrLoss_Case05
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
GoldItemOrLoss_Case05_ShowHeroPeeredIntoThe::
Jump_073_4B80:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, $4010 ; '0 peered into the vase. Freshly'
    call StartMessageHL_B73
    ret

; entry 2 of the `rst $00` table in GoldItemOrLoss_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult
; writes: wScriptStep
; points at: wScriptStep
GoldItemOrLoss_Case05_ShowWarubouWaheyGiveMe::
Jump_073_4B8B:: ; address name
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, .call_start_message_hl_b73
    ld hl, vTiles0 + $4F
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b73:
    ld hl, vTiles0 + $4E
    call StartMessageHL_B73
    ld a, $08
    ld [wScriptStep], a
    ret

; entry 5 of the `rst $00` table in GoldItemOrLoss_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene
; points at: wScriptStep
GoldItemOrLoss_Case05_ShowCobiHeroTheySaid::
Jump_073_4BA8:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wBattleScene]
    or a, a
    jr nz, .call_start_message_hl_b73
    ld hl, $0011 ; 'Cobi 0! They said GreatLog will'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, $0012 ; 'Land ho! There's GreatLog!'
    call StartMessageHL_B73
    call DeductGoldPenaltyAndFormatLoss
    ret

; entry 4 of the `rst $00` table in GoldItemOrLoss
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
GoldItemOrLoss_Case04::
Jump_073_4BC3:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw GoldItemOrLoss_Case04_ShowGreatLogsKingAskedUs
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case04_ShowWowYouKidsSure
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case0C_SaveScreenBufferToBGMap1
    dw GoldItemOrLoss_Case04_ShowGreatLogsKingAskedUs_Case05
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case05_StartMessageHL_B73
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd

; entry 0 of the `rst $00` table in GoldItemOrLoss_Case04
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
GoldItemOrLoss_Case04_ShowGreatLogsKingAskedUs::
Jump_073_4BDB:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, $400B ; 'GreatLog's King asked us to settle'
    call StartMessageHL_B73
    ret

; entry 2 of the `rst $00` table in GoldItemOrLoss_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult
; writes: wScriptStep
; points at: wScriptStep
GoldItemOrLoss_Case04_ShowWowYouKidsSure::
Jump_073_4BE6:: ; address name
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, .call_start_message_hl_b73
    ld hl, vTiles0 + $4D
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

.call_start_message_hl_b73:
    ld hl, vTiles0 + $4C
    call StartMessageHL_B73
    ld a, $08
    ld [wScriptStep], a
    ret

; entry 5 of the `rst $00` table in GoldItemOrLoss_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene
; points at: wScriptStep
GoldItemOrLoss_Case04_ShowGreatLogsKingAskedUs_Case05::
Jump_073_4C03:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wBattleScene]
    or a, a
    jr nz, .call_start_message_hl_b73
    ld hl, $000C ; 'GreatLog's King asked us to settle'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, $000E ; 'Worried about your monsters? Don't be!'
    call StartMessageHL_B73
    ret

; entry 7 of the `rst $00` table in GoldItemOrLoss_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene, wRandomLo, hTemp0
; writes: wStepPtrLo
; points at: wScriptStep
GoldItemOrLoss_Case05_StartMessageHL_B73::
Jump_073_4C1B:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wBattleScene]
    or a, a
    jr nz, .call_start_message_hl_b73
    call NextTableByte
    ld a, [wRandomLo]
    cp a, $10
    jr c, .call_generate_new_key_entry

.loop:
    ld hl, $000D ; 'When our farm gets established in'
    call StartMessageHL_B73
    ld a, $29
    ld [wStepPtrLo], a
    farcall AppendItemWC928ToInventory
    ret

.call_generate_new_key_entry:
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    or a, a
    jr z, .loop
    ld hl, $0043 ; '0 checked the odd object. It'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, $000F ; '0 peered into the barrel. It'
    call StartMessageHL_B73
    call DeductGoldPenaltyAndFormatLoss
    ret

; saves the gold, far-calls DeductGoldPenalty, stores the amount lost in wC8C0-wC8C2 and writes it as packed BCD to wC17E (Func_000_23CA) (E-0121)
; 5 call sites from 5 routines (e.g. GoldItemOrLoss_Case05_StartMessageHL_B73, GoldItemOrLoss_Case05_ShowCobiHeroTheySaid, GoldItemOrLoss_Case07_ShowThisHayIsPretty, GoldItemOrLoss_Case09_ProcessRecordFields5DTo69ThenItemString, ...)
; reads: wGoldLo, wGoldMid, wGoldHi, wDigits
; writes: wDigits
; points at: wTextNumber
DeductGoldPenaltyAndFormatLoss::
Func_073_4C5D:: ; address name
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
    sub a, c
    ld [wDigits], a
    ld a, [wGoldMid]
    ld c, a
    ld a, [wDigits + $1]
    sbc a, c
    ld [wDigits + $1], a
    ld a, [wGoldHi]
    ld c, a
    ld a, [wDigits + $2]
    sbc a, c
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ld de, wTextNumber
    call WritePackedBCDNoLeadingZeros
    ret

; entry 3 of the `rst $00` table in GoldItemOrLoss
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
GoldItemOrLoss_Case03::
Jump_073_4CA0:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw GoldItemOrLoss_Case03_ShowGoodThatsGoodTo
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case03_ShowIsThatSoToo
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd

; entry 0 of the `rst $00` table in GoldItemOrLoss_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wDigits
; points at: wScriptStep, wTextNumber
GoldItemOrLoss_Case03_ShowGoodThatsGoodTo::
Jump_073_4CAE:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, $4008 ; 'Good. That's good to hear! You'
    call StartMessageHL_B73
    call GoldItemOrLoss_SetWStepArrivedIfPartyHasField55Bit7
    ld a, [wScriptParam0]
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld a, [wScriptParam0]
    call ReadBank16Table4CC3Word
    ld e, l
    ld d, h
    add hl, hl
    add hl, hl
    add hl, de
    ld a, l
    ld [wDigits], a
    ld a, h
    ld [wDigits + $1], a
    xor a, a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ld de, wTextNumber
    call WritePackedBCDNoLeadingZeros
    ret

; entry 2 of the `rst $00` table in GoldItemOrLoss_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult, wScriptParam0
; writes: wStepPtrLo, hTemp0, hTemp1
; points at: wScriptStep
GoldItemOrLoss_Case03_ShowIsThatSoToo::
Jump_073_4CE5:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, .call_start_message_hl_b73
    ld a, [wScriptParam0]
    ld [wStepPtrLo], a
    farcall AppendItemWC928ToInventory
    ld a, [wScriptParam0]
    call ReadBank16Table4CC3Word
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
    ld hl, vTiles0 + $A
    call StartMessageHL_B73
    ret

; entry 2 of the `rst $00` table in GoldItemOrLoss
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
GoldItemOrLoss_Case02::
Jump_073_4D20:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw GoldItemOrLoss_Case02_ShowYouFolksRunA
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case02_ShowHeroPeeredIntoThe
    dw GoldItemOrLoss_Case08_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case0B_ToScriptStepFlashScreenNegative
    dw GoldItemOrLoss_Case02_ShowTheresASpiritIn
    dw GoldItemOrLoss_Case0B_WriteScriptParam0AndFieldDrawFlagsEtc
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd

; entry 0 of the `rst $00` table in GoldItemOrLoss_Case02
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
GoldItemOrLoss_Case02_ShowYouFolksRunA::
Jump_073_4D36:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, $4005 ; 'You folks run a monster farm?'
    call StartMessageHL_B73
    ret

; entry 2 of the `rst $00` table in GoldItemOrLoss_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult
; points at: wScriptStep
GoldItemOrLoss_Case02_ShowHeroPeeredIntoThe::
Jump_073_4D41:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wTextYesNoResult]
    or a, a
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

; entry 5 of the `rst $00` table in GoldItemOrLoss_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex
; writes: hTemp0, hTemp1
; points at: wScriptStep
GoldItemOrLoss_Case02_ShowTheresASpiritIn::
Jump_073_4D5B:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wMessageIndex]
    cp a, $27
    jr nz, .call_start_message_hl_b73
    ld hl, $03E8
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall SubtractGoldFloorZero
    farcall FullyHealParty
    ld hl, $0006 ; 'There's a spirit in GreatLog that's'
    call StartMessageHL_B73
    ret

.call_start_message_hl_b73:
    ld hl, vTiles0 + $7
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in GoldItemOrLoss
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
GoldItemOrLoss_Case01::
Jump_073_4D8D:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw GoldItemOrLoss_Case01_ShowTaraThereYouAre
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case01_ShowCobiWhatsWrongHero
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd

; entry 0 of the `rst $00` table in GoldItemOrLoss_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wDigits
; points at: wScriptStep, wTextNumber
GoldItemOrLoss_Case01_ShowTaraThereYouAre::
Jump_073_4D9B:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld hl, $4002 ; 'Tara There you are, big brother!'
    call StartMessageHL_B73
    call GoldItemOrLoss_SetWStepArrivedIfPartyHasField55Bit7
    ld a, [wScriptParam0]
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE
    ld a, [wScriptParam0]
    call ReadBank16Table4CC3Word
    ld a, l
    ld [wDigits], a
    ld a, h
    ld [wDigits + $1], a
    xor a, a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ld de, wTextNumber
    call WritePackedBCDNoLeadingZeros
    ret

; entry 2 of the `rst $00` table in GoldItemOrLoss_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult, wScriptParam0
; writes: wStepPtrLo, hTemp0, hTemp1
; points at: wScriptStep
GoldItemOrLoss_Case01_ShowCobiWhatsWrongHero::
Jump_073_4DCD:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, .call_start_message_hl_b73
    ld a, [wScriptParam0]
    ld [wStepPtrLo], a
    farcall AppendItemWC928ToInventory
    ld a, [wScriptParam0]
    call ReadBank16Table4CC3Word
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

; entry 0 of the `rst $00` table in GoldItemOrLoss
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
GoldItemOrLoss_Case00::
Jump_073_4E03:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw GoldItemOrLoss_Case00_Msg0000_InTheMiddleOf
    dw GoldItemOrLoss_Case08_RunMessageBoxCarryWhenIdle_Bank73
    dw GoldItemOrLoss_Case0B_ToScriptStepFlashScreenNegative
    dw GoldItemOrLoss_Case0B_ShowCobiHeroPapasCalling
    dw GoldItemOrLoss_Case0B_WriteScriptParam0AndFieldDrawFlagsEtc
    dw GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73
    dw ScriptStepBlinkSpritesThenEnd

; entry 0 of the `rst $00` table in GoldItemOrLoss_Case00
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
GoldItemOrLoss_Case00_Msg0000_InTheMiddleOf::
Jump_073_4E15:: ; address name
    ld hl, $0000 ; 'In the middle of the sea'
    call StartMessageHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in GoldItemOrLoss_Case08
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; points at: wBGPaletteBuffer, wBGPaletteCopy, wScriptStep
GoldItemOrLoss_Case08_RunMessageBoxCarryWhenIdle_Bank73::
Jump_073_4E20:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank73
    ret nc
    ld a, [wIsCGB]
    or a, a
    jr z, .call_queue_sound_effect
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes

.call_queue_sound_effect:
    ld a, $7A
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in GoldItemOrLoss_Case0B
; no direct call (reached through a table, a jump or a vector)
GoldItemOrLoss_Case0B_ToScriptStepFlashScreenNegative::
Jump_073_4E41:: ; address name
    farcall ScriptStepFlashScreenNegative
    ret

; entry 8 of the `rst $00` table in GoldItemOrLoss_Case0B
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0
; points at: wScriptStep
GoldItemOrLoss_Case0B_ShowCobiHeroPapasCalling::
Jump_073_4E48:: ; address name
    farcall FullyHealParty
    ld hl, $0001 ; 'Cobi 0! Papa's calling. He's at'
    call StartMessageHL_B73
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in GoldItemOrLoss_Case0C
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73::
Jump_073_4E5D:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in GoldItemOrLoss_Case0B
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0, hFieldDrawFlags, wOBJPaletteUploadRequest
; points at: wScriptStep
GoldItemOrLoss_Case0B_WriteScriptParam0AndFieldDrawFlagsEtc::
Jump_073_4E67:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, .call_move_incapacitated_party_members_back
    inc a
    ld [wScriptParam0], a
    ld a, $0E
    ldh [hFieldDrawFlags], a
    ret

.call_move_incapacitated_party_members_back:
    farcall MoveIncapacitatedPartyMembersBack
    farcall MoveIncapacitatedPartyMembersBack
    call LoadRecordListNameTiles
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    xor a, a
    ldh [hFieldDrawFlags], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; toggles wSpriteSlotCount between 0 and 1 at a slowing rate for $78 frames, then requests script $80 and clears wC935 (E-0125)
; 1 call site from 1 routine (e.g. SceneSpiritEnvoy2_ScriptStepBlinkSpritesThenEnd)
; reads: wScriptParam0
; writes: wSpriteSlotCount, wScriptParam0, wScriptStartRequest, wPendingFieldEvent
ScriptStepBlinkSpritesThenEnd::
Func_073_4E9C:: ; address name
    ld a, [wScriptParam0]
    cp a, $1E
    jr nc, .cp_3C
    bit 3, a
    jr z, .set_sprite_slot_count_to_01
    jr .clear_sprite_slot_count

.cp_3C:
    cp a, $3C
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
    xor a, a
    ld [wSpriteSlotCount], a

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $78
    ret nz
    ld a, $80
    ld [wScriptStartRequest], a
    xor a, a
    ld [wPendingFieldEvent], a
    ret

; HL is stored in wC924 (low) and wC925 (high); then wC926 = 0
; 80 call sites from 44 routines (e.g. GoldItemOrLoss_Case00_Msg0000_InTheMiddleOf, GoldItemOrLoss_Case01_ShowCobiWhatsWrongHero, GoldItemOrLoss_Case01_ShowTaraThereYouAre, GoldItemOrLoss_Case02_ShowTheresASpiritIn, ...)
; writes: wMessageIndex, wMessageGroup, wMessageState
StartMessageHL_B73::
Func_073_4ED8:: ; address name
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a, a
    ld [wMessageState], a
    ret

; the bank-$73 message runner: returns at once when wMessageState is $FF (idle), otherwise steps the message (the same opening as RunMessageBox_Bank12) (E-0116)
; 1 call site from 1 routine (e.g. RunMessageBoxCarryWhenIdle_Bank73)
; reads: wMessageState
RunMessageBox_Bank73::
Func_073_4EE5:: ; address name
    push af
    ld a, [wMessageState]
    cp a, $FF
    jr nz, .skip
    pop af
    ret

.skip:
    rst $00
    dw RunMessageBox_Bank73_SetBit1OfPlayerAndObjectFlags
    dw RunMessageBox_Bank73_BeginStringDisplay_Bank09
    dw RunMessageBox_Bank73_WriteMessageStateAndTextWindowStateEtc
    dw RunMessageBox_Bank73_WriteMessageState

; entry 0 of the `rst $00` table in RunMessageBox_Bank73
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageGroup, hPlayerY
; writes: wTextWindowState, wTextWindowStep, hSpriteWindowClipMode
; points at: wMessageState
RunMessageBox_Bank73_SetBit1OfPlayerAndObjectFlags::
Jump_073_4EF8:: ; address name
    pop af
    or a, a
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
    cp a, $48
    jr c, .done
    ld a, $81
    ld [wTextWindowState], a
    ld a, $01
    ldh [hSpriteWindowClipMode], a

.done:
    ld hl, wMessageState
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunMessageBox_Bank73
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowState, wMessageIndex
; writes: wStringIndex, wStringCategory
; points at: wMessageState
RunMessageBox_Bank73_BeginStringDisplay_Bank09::
Jump_073_4F3C:: ; address name
    pop af
    ld a, [wTextWindowState]
    and a, $03
    ret nz
    ld a, [wMessageIndex]
    ld [wStringIndex], a
    ld a, $05
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank09
    ld hl, wMessageState
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunMessageBox_Bank73
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wMessageGroup, hPlayerY
; writes: wMessageState, wTextWindowState, wTextWindowStep, hSpriteWindowClipMode
; points at: wMessageState
RunMessageBox_Bank73_WriteMessageStateAndTextWindowStateEtc::
Jump_073_4F59:: ; address name
    pop af
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld a, [wMessageGroup]
    bit 6, a
    jr z, .call_queue_sound_effect
    ld a, $FF
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
    cp a, $48
    jr c, .done
    ld a, $82
    ld [wTextWindowState], a

.done:
    ld hl, wMessageState
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunMessageBox_Bank73
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowState
; writes: wMessageState
RunMessageBox_Bank73_WriteMessageState::
Jump_073_4F90:: ; address name
    ld a, [wTextWindowState]
    and a, $03
    jr z, .restore
    pop af
    ret

.restore:
    pop af
    or a, a
    jr nz, .set_message_state_to_FF
    farcall ClearBit1OfPlayerAndObjectFlags

.set_message_state_to_FF:
    ld a, $FF
    ld [wMessageState], a
    ret

; RunMessageBox_Bank73, then carry set when wMessageState = $FF (idle), else A = 0 and carry clear (E-0116)
; 2 call sites from 2 routines (e.g. GoldItemOrLoss_Case08_RunMessageBoxCarryWhenIdle_Bank73, GoldItemOrLoss_Case0C_RunMessageBoxCarryWhenIdle_Bank73)
; reads: wMessageState
RunMessageBoxCarryWhenIdle_Bank73::
Func_073_4FA9:: ; address name
    call RunMessageBox_Bank73
    ld a, [wMessageState]
    cp a, $FF
    jr z, .return_carry
    sub a, a
    ret

.return_carry:
    scf
    ret

; HL = the word at $4CC3 + 13 * A in bank $16 (ReadByteInBank twice) (E-0121)
; 5 call sites from 5 routines (e.g. GoldItemOrLoss_Case01_ShowCobiWhatsWrongHero, GoldItemOrLoss_Case01_ShowTaraThereYouAre, GoldItemOrLoss_Shared05_ReadBank16Table4CC3Word, GoldItemOrLoss_Case03_ShowIsThatSoToo, ...)
ReadBank16Table4CC3Word::
Func_073_4FB7:: ; address name
    ld c, $0D
    call Multiply8
    ld a, l
    add a, $C3
    ld l, a
    ld a, h
    adc a, $4C
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

; only called from routines of GoldItemOrLoss (E-0098)
; 2 call sites from 2 routines (e.g. GoldItemOrLoss_Case01_ShowTaraThereYouAre, GoldItemOrLoss_Case03_ShowGoodThatsGoodTo)
; reads: wStepArrived, wPartyCount, wRecordsInUse, hTemp3, hTemp2
; writes: wScriptParam0
GoldItemOrLoss_SetWStepArrivedIfPartyHasField55Bit7::
Func_073_4FD2:: ; address name
    farcall SetWStepArrivedIfPartyHasField55Bit7
    ld a, [wStepArrived]
    or a, a
    jr z, .call_gold_item_or_loss_shared05_load_sram
    ld a, $0C
    ld [wScriptParam0], a
    call GoldItemOrLoss_Shared05_ReadBank16Table4CC3Word
    or a, a
    ret nz

.call_gold_item_or_loss_shared05_load_sram:
    farcall GoldItemOrLoss_Shared05_LoadSRAMRecordByte
    ld a, [wStepArrived]
    or a, a
    jr z, .call_gold_item_or_loss_shared05_load_sram2
    ld a, $08
    ld [wScriptParam0], a
    call GoldItemOrLoss_Shared05_ReadBank16Table4CC3Word
    or a, a
    ret nz

.call_gold_item_or_loss_shared05_load_sram2:
    farcall GoldItemOrLoss_Shared05_LoadSRAMRecordByte_Sub01
    ld a, [wStepArrived]
    or a, a
    jr z, .check_party_count
    ld a, $06
    ld [wScriptParam0], a
    call GoldItemOrLoss_Shared05_ReadBank16Table4CC3Word
    or a, a
    ret nz

.check_party_count:
    ld a, [wPartyCount]
    cp a, $03
    jr z, .call_gold_item_or_loss_shared05_load_sram3
    farcall CountRecordsInUse
    ld a, [wRecordsInUse]
    cp a, $03
    jr nc, .check_records_in_use
    ld a, $19
    ld [wScriptParam0], a
    call GoldItemOrLoss_Shared05_ReadBank16Table4CC3Word
    or a, a
    ret nz

.check_records_in_use:
    ld a, [wRecordsInUse]
    cp a, $03
    jr c, .check_records_in_use2
    cp a, $06
    jr nc, .check_records_in_use2
    ld a, $1A
    ld [wScriptParam0], a
    call GoldItemOrLoss_Shared05_ReadBank16Table4CC3Word
    or a, a
    ret nz

.check_records_in_use2:
    ld a, [wRecordsInUse]
    cp a, $06
    jr c, .call_gold_item_or_loss_shared05_load_sram3
    cp a, $0B
    jr nc, .call_gold_item_or_loss_shared05_load_sram3
    ld a, $1B
    ld [wScriptParam0], a
    call GoldItemOrLoss_Shared05_ReadBank16Table4CC3Word
    or a, a
    ret nz

.call_gold_item_or_loss_shared05_load_sram3:
    call GoldItemOrLoss_Shared05_LoadSRAMRecordWord
    ldh a, [hTemp3]
    or a, a
    jr nz, .set_script_param0_to_05
    ldh a, [hTemp2]
    cp a, $65
    jr c, .check_temp3

.set_script_param0_to_05:
    ld a, $05
    ld [wScriptParam0], a
    call GoldItemOrLoss_Shared05_ReadBank16Table4CC3Word
    or a, a
    ret nz

.check_temp3:
    ldh a, [hTemp3]
    or a, a
    jr nz, .call_gold_item_or_loss_shared05_load_sram4
    ldh a, [hTemp2]
    cp a, $65
    jr nc, .call_gold_item_or_loss_shared05_load_sram4
    or a, a
    jr z, .call_gold_item_or_loss_shared05_load_sram4
    ld a, $04
    ld [wScriptParam0], a
    call GoldItemOrLoss_Shared05_ReadBank16Table4CC3Word
    or a, a
    ret nz

.call_gold_item_or_loss_shared05_load_sram4:
    call GoldItemOrLoss_Shared05_LoadSRAMRecordWord_Sub03
    ldh a, [hTemp3]
    or a, a
    jr nz, .set_script_param0_to_03
    ldh a, [hTemp2]
    cp a, $65
    jr c, .check_temp32

.set_script_param0_to_03:
    ld a, $03
    ld [wScriptParam0], a
    call GoldItemOrLoss_Shared05_ReadBank16Table4CC3Word
    or a, a
    ret nz

.check_temp32:
    ldh a, [hTemp3]
    or a, a
    jr nz, .set_script_param0_to_01
    ldh a, [hTemp2]
    cp a, $33
    jr c, .set_script_param0_to_01
    cp a, $64
    jr nc, .set_script_param0_to_01
    ld a, $02
    ld [wScriptParam0], a
    call GoldItemOrLoss_Shared05_ReadBank16Table4CC3Word
    or a, a
    ret nz

.set_script_param0_to_01:
    ld a, $01
    ld [wScriptParam0], a
    ret

; only called from GoldItemOrLoss_Shared05 (E-0047)
; 1 call site from 1 routine (e.g. GoldItemOrLoss_SetWStepArrivedIfPartyHasField55Bit7)
; reads: wPartyCount, hTemp0, hTemp1, hTemp2, hTemp3
; writes: hTemp2, hTemp3, rRAMG
; points at: wPartyList
GoldItemOrLoss_Shared05_LoadSRAMRecordWord_Sub03::
Func_073_50C3:: ; address name
    ld hl, $0000
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyCount]
    or a, a
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
    sub a, l
    ldh [hTemp2], a
    ldh a, [hTemp3]
    sbc a, h
    ldh [hTemp3], a
    pop hl
    inc hl
    dec b
    jr nz, .loop

.done:
    xor a, a
    ld [rRAMG], a
    ret

; only called from GoldItemOrLoss_Shared05 (E-0047)
; 1 call site from 1 routine (e.g. GoldItemOrLoss_SetWStepArrivedIfPartyHasField55Bit7)
; reads: wPartyCount, hTemp0, hTemp1, hTemp2, hTemp3
; writes: hTemp2, hTemp3, rRAMG
; points at: wPartyList
GoldItemOrLoss_Shared05_LoadSRAMRecordWord::
Func_073_5117:: ; address name
    ld hl, $0000
    ld a, l
    ldh [hTemp2], a
    ld a, h
    ldh [hTemp3], a
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyCount]
    or a, a
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
    sub a, l
    ldh [hTemp2], a
    ldh a, [hTemp3]
    sbc a, h
    ldh [hTemp3], a
    pop hl
    inc hl
    dec b
    jr nz, .loop

.done:
    xor a, a
    ld [rRAMG], a
    ret

; only called from GoldItemOrLoss_Shared05 (E-0047)
; 10 call sites from 1 routine (e.g. GoldItemOrLoss_SetWStepArrivedIfPartyHasField55Bit7)
; reads: wPendingFieldEvent, wGoldHi, wGoldMid, wGoldLo
GoldItemOrLoss_Shared05_ReadBank16Table4CC3Word::
Func_073_516B:: ; address name
    call ReadBank16Table4CC3Word
    ld a, [wPendingFieldEvent]
    and a, $0F
    dec a
    jr z, .check_gold_hi
    ld e, l
    ld d, h
    add hl, hl
    add hl, hl
    add hl, de

.check_gold_hi:
    ld a, [wGoldHi]
    or a, a
    jr z, .check_gold_mid

.loop:
    ld a, $01
    ret

.check_gold_mid:
    ld a, [wGoldMid]
    cp a, h
    jr c, .return_0
    jr nz, .loop
    ld a, [wGoldLo]
    cp a, l
    jr nc, .loop

.return_0:
    xor a, a
    ret

; entry 2 of the `rst $00` table in GoldItemOrLoss_Case0C
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleIntroKind, wBattleTransitionSubStep, wModeState, wBattleTransitionStep, wFieldReturnPhase
; points at: wScriptStep
GoldItemOrLoss_Case0C_SaveScreenBufferToBGMap1::
Jump_073_5194:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, $06
    ld [wBattleIntroKind], a
    ld a, $01
    ld [wBattleTransitionSubStep], a
    ld a, $03
    ld [wModeState], a
    xor a, a
    ld [wBattleTransitionStep], a
    ld a, $02
    ld [wFieldReturnPhase], a
    farcall SaveScreenBufferToBGMap1
    farcall PickRandomEncounterCountdownFromTable478F
    ret

; implements script command type CB (SCRIPT_SCENE_CHEST_BATTLE): a cutscene step named after the scene its only script shows: '0 checked the treasure chest.' (key entry mark and encounter); reached through ScriptCommandCB in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommandCB)
; reads: wScriptStep
SceneChestBattle::
Func_073_51BD:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneChestBattle_ToSceneChestBattle_StartMessageHL_B73b
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw SceneChestBattle_StartScriptedEncounterTemp0
    dw SceneChestBattle_ToSceneChestBattle_StartMessageHL_B73b_Case03
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw SceneChestBattle_WriteTemp0AndScriptStep
    dw SceneChestBattle_ScriptStepBlinkObjectTemp0
    dw SceneChestBattle_SetFlagBit
    dw SceneChestBattle_SetBit2AtHL_B73
    dw SceneChestBattle_ClearBit2AtHL_Bank73
    dw SceneChestBattle_SetFlagBit

; entry 9 of the `rst $00` table in SceneChestBattle
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, wSpriteSlots, wScriptParam0
; writes: wSpriteSlots, wScriptParam0
; points at: wScriptStep
SceneChestBattle_ClearBit2AtHL_Bank73::
Jump_073_51D7:: ; address name
    ld a, [wScriptParam1]
    ld c, a
    ld a, [wSpriteSlots + $B]
    add a, c
    ld [wSpriteSlots + $B], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $10
    ret nz
    xor a, a
    ld [wSpriteSlots + $7], a
    ld hl, wSpriteSlots + $D
    call ClearBit2AtHL_Bank73
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in SceneChestBattle
; no direct call (reached through a table, a jump or a vector)
; reads: hMapId
; writes: wScriptStartRequest
SceneChestBattle_SetFlagBit::
Jump_073_51FB:: ; address name
    ldh a, [hMapId]
    sub a, $C8
    add a, a
    ld hl, $5215
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret
    db $00, $00, $00, $00, $D4, $01, $D9, $01, $DD, $01, $6A, $01, $6E, $01, $00, $00
    db $00, $00, $00, $00, $00, $00, $74, $01, $78, $01, $7C, $01, $D5, $00, $D9, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $DF, $00, $F8, $00, $FC, $00, $F2, $01
    db $F6, $01, $00, $00, $00, $00

; entry 6 of the `rst $00` table in SceneChestBattle
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0, hTemp1, wSpriteSlotCount
; points at: wScriptStep
SceneChestBattle_ScriptStepBlinkObjectTemp0::
Jump_073_524B:: ; address name
    xor a, a
    ldh [hTemp0], a
    ld a, $30
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a, a
    ret z
    xor a, a
    ld [wSpriteSlotCount], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in SceneChestBattle
; no direct call (reached through a table, a jump or a vector)
; reads: hMapId
; writes: hTemp0, wScriptStep
; points at: wScriptStep
SceneChestBattle_WriteTemp0AndScriptStep::
Jump_073_5265:: ; address name
    ldh a, [hMapId]
    cp a, $CE
    jr z, .set_temp0_to_0A
    cp a, $D7
    jr z, .set_temp0_to_0B
    cp a, $E0
    jr z, .set_temp0_to_0C
    ld hl, wScriptStep
    inc [hl]
    ret

.set_temp0_to_0A:
    ld a, $0A
    ldh [hTemp0], a
    farcall MarkKeyEntryKindTemp0Bit6
    ld de, $0206
    call SetFlagBit
    jr .set_script_step_to_08

.set_temp0_to_0B:
    ld a, $0B
    ldh [hTemp0], a
    farcall MarkKeyEntryKindTemp0Bit6
    ld de, $0207
    call SetFlagBit
    jr .set_script_step_to_08

.set_temp0_to_0C:
    ld a, $0C
    ldh [hTemp0], a
    farcall MarkKeyEntryKindTemp0Bit6
    ld de, $0208
    call SetFlagBit

.set_script_step_to_08:
    ld a, $08
    ld [wScriptStep], a
    ret

; entry 3 of the `rst $00` table in SceneChestBattle
; no direct call (reached through a table, a jump or a vector)
SceneChestBattle_ToSceneChestBattle_StartMessageHL_B73b_Case03::
Jump_073_52B2:: ; address name
    ld de, $5342
    call SceneChestBattle_StartMessageHL_B73b
    ret

; entry 2 of the `rst $00` table in SceneChestBattle
; no direct call (reached through a table, a jump or a vector)
; reads: hMapId
; writes: hTemp0
; points at: wScriptStep
SceneChestBattle_StartScriptedEncounterTemp0::
Jump_073_52B9:: ; address name
    ldh a, [hMapId]
    sub a, $C8
    ld de, $52D3
    add a, e
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
    db $00, $00, $20, $21, $22, $23, $24, $00, $00, $00, $00, $25, $26, $27, $28, $29
    db $00, $00, $00, $00, $2A, $2B, $2C, $2D, $2E, $00, $00

; entry 0 of the `rst $00` table in SceneChestBattle
; no direct call (reached through a table, a jump or a vector)
SceneChestBattle_ToSceneChestBattle_StartMessageHL_B73b::
Jump_073_52EE:: ; address name
    ld de, MapMessageTable_530C
    call SceneChestBattle_StartMessageHL_B73b
    ret

; only called from routines of SceneChestBattle (E-0098)
; 2 call sites from 2 routines (e.g. SceneChestBattle_ToSceneChestBattle_StartMessageHL_B73b_Case03, SceneChestBattle_ToSceneChestBattle_StartMessageHL_B73b)
; reads: hMapId
; points at: wScriptStep
SceneChestBattle_StartMessageHL_B73b::
Func_073_52F5:: ; address name
    ldh a, [hMapId]
    sub a, $C8
    add a, a
    add a, e
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

; E-0214 (C1: SceneChestBattle_Case00 passes $530C to SceneChestBattle_Shared01, which reads the word at DE + 2 * (hMapId - $C8) and starts that message (StartMessageHL_B73b); 54 words, one per map from $C8 (id = map number); the table ends at KeyBossBeaten2).
; record: message word ($0000 = none)
MapMessageTable_530C::
Data_073_530C:: ; address name
    dw $0000 ; id 200 none
    dw $0000 ; id 201 none
    dw $0C04 ; id 202 'This is the second floor- the'
    dw $0C08 ; id 203 'This is the third floor- the'
    dw $0C0C ; id 204 'This is the fourth floor- the'
    dw $0C10 ; id 205 'This is the fifth floor- the'
    dw $0C14 ; id 206 'Well. How impressive. I must commend'
    dw $0000 ; id 207 none
    dw $0000 ; id 208 none
    dw $0000 ; id 209 none
    dw $0000 ; id 210 none
    dw $0C1C ; id 211 'This is the second floor- the'
    dw $0C20 ; id 212 'This is the third floor- the'
    dw $0C24 ; id 213 'This is the fourth floor- the'
    dw $0C28 ; id 214 'This is the fifth floor- the'
    dw $0C2C ; id 215 'Ah, you have impressed me. It's'
    dw $0000 ; id 216 none
    dw $0000 ; id 217 none
    dw $0000 ; id 218 none
    dw $0000 ; id 219 none
    dw $0C34 ; id 220 'This is the second floor. This'
    dw $0C38 ; id 221 'This is the third floor. It's'
    dw $0C3C ; id 222 'This is the fourth floor. The'
    dw $0C40 ; id 223 'This is the fifth floor. Welcome'
    dw $0C44 ; id 224 'Oh? Well, well, you're the first'
    dw $0000 ; id 225 none
    dw $0000 ; id 226 none
    dw $0000 ; id 227 none
    dw $0000 ; id 228 none
    dw $0C07 ; id 229 'Not bad, not bad at all.'
    dw $0C0B ; id 230 'You're quite good. The treasures are'
    dw $0C0F ; id 231 'Wow, aren't you good. Go ahead'
    dw $0C13 ; id 232 'Well done. So it shall be.'
    dw $0C16 ; id 233 'Well. How impressive. Conquering the Power'
    dw $0000 ; id 234 none
    dw $0000 ; id 235 none
    dw $0000 ; id 236 none
    dw $0000 ; id 237 none
    dw $0C1F ; id 238 'Well played. I can't complain. Fine.'
    dw $0C23 ; id 239 'Bravo. Take the treasures. Upstairs is'
    dw $0C27 ; id 240 'Remarkable, I must admit. You have'
    dw $0C2B ; id 241 'You're quite tough. The treasures are'
    dw $0C2E ; id 242 'You are to be commended for'
    dw $0000 ; id 243 none
    dw $0000 ; id 244 none
    dw $0000 ; id 245 none
    dw $0000 ; id 246 none
    dw $0C37 ; id 247 'You're quite good at this. Sure,'
    dw $0C3B ; id 248 'You e shown me your worth.'
    dw $0C3F ; id 249 'Fine, we will confer all the'
    dw $0C43 ; id 250 'All right. Good enough. The treasures'
    dw $0C46 ; id 251 'You are good! I like you!'
    dw $0000 ; id 252 none
    dw $0000 ; id 253 none

; implements script command type CA (SCRIPT_KEY_BOSS_BEATEN_2): the same as SCRIPT_KEY_BOSS_BEATEN for another boss: 'But No! I lost to this'; reached through ScriptCommandCA in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommandCA)
; reads: hTemp0, wStoryFlags
; writes: hTemp0, hTemp1, wStoryFlags, wObject1, wScriptStartRequest
KeyBossBeaten2::
Func_073_5378:: ; address name
    xor a, a
    ldh [hTemp0], a
    ld a, $20
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a, a
    ret z
    ld a, $09
    ldh [hTemp0], a
    farcall MarkKeyEntryKindTemp0Bit6
    ld a, [wStoryFlags + $68]
    set 1, a
    ld [wStoryFlags + $68], a
    ld a, $50
    ld [wObject1 + $B], a
    ld a, $70
    ld [wObject1 + $C], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type C9 (SCRIPT_SCENE_MILAYOU_FOREST): a cutscene step named after the scene its only script shows: 'Milayou I thought this forest looked...'; reached through ScriptCommandC9 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommandC9)
; reads: wScriptStep
SceneMilayouForest::
Func_073_53AB:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneChestBattle_SetBit2AtHL_B73
    dw SceneMilayouForest_ClearBit2AtHL_Bank73

; entry 1 of the `rst $00` table in SceneMilayouForest
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, wSpriteSlots, wScriptParam0
; writes: wSpriteSlots, wScriptParam0, wScriptStartRequest
SceneMilayouForest_ClearBit2AtHL_Bank73::
Jump_073_53B3:: ; address name
    ld a, [wScriptParam1]
    ld c, a
    ld a, [wSpriteSlots + $B]
    add a, c
    ld [wSpriteSlots + $B], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $10
    ret nz
    xor a, a
    ld [wSpriteSlots + $7], a
    ld hl, wSpriteSlots + $D
    call ClearBit2AtHL_Bank73
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 8 of the `rst $00` table in SceneChestBattle
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, hPlayerY, wPartyCount
; writes: wScriptParam1, wSpriteSlots
; points at: wScriptStep
SceneChestBattle_SetBit2AtHL_B73::
Jump_073_53D8:: ; address name
    ld hl, wSpriteSlots + $D
    call SetBit2AtHL_B73
    ld hl, wScriptStep
    inc [hl]
    ldh a, [hPlayerX]
    cp a, $30
    jr nz, .read_party_count
    ldh a, [hPlayerY]
    cp a, $20
    jr z, .set_script_param1_to_012

.read_party_count:
    ld a, [wPartyCount]
    ld b, a
    ld hl, wFollowerRecords + $1

.loop:
    push hl
    ld a, [hl+]
    cp a, $30
    jr nz, .restore
    ld a, [hl]
    cp a, $20
    jr z, .set_script_param1_to_01

.restore:
    pop hl
    inc hl
    inc hl
    dec b
    jr nz, .loop
    ld a, $FF
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

; implements script command type C8 (SCRIPT_SCENE_MERCY): a cutscene step named after the scene its only script shows: 'Please! Mercy! Spare us! Take back...'; reached through ScriptCommandC8 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommandC8)
; reads: wSpriteSlots
; writes: wObject2, wSpriteSlots, wObject1, wScriptStartRequest
SceneMercy::
Func_073_541D:: ; address name
    ld a, $10
    ld [wObject2 + $C], a
    xor a, a
    ld [wSpriteSlots + $7], a
    ld [wObject1 + $7], a
    ld hl, wSpriteSlots + $D
    call SetBit2AtHL_B73
    ld hl, wObject1 + $D
    call SetBit2AtHL_B73
    ld a, [wSpriteSlots + $C]
    inc a
    inc a
    ld [wSpriteSlots + $C], a
    ld [wObject1 + $C], a
    cp a, $B0
    ret nz
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type C5 (SCRIPT_SCENE_WIZSTONE): a cutscene step named after the scene its only script shows: 'Kiral This stone, the WizStone, it...'; reached through ScriptCommandC5 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommandC5)
; reads: wScriptStep
SceneWizstone::
Func_073_5449:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneWizstone_WriteSpriteSlotsAndScriptStep
    dw SceneWizstone_StepObjectTowardCoord
    dw SceneWizstone_Msg0780_ProfessorKiralUsedThe
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw SceneWizstone_AdvanceScriptStep
    dw SceneWizstone_Msg0781_KiralYesYesSuccess
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw SceneWizstone_StepObjectTowardCoord_Case07
    dw SceneWizstone_Msg0782_HeroReceivedTheSmartBook
    dw SceneWizstone_RunMessageBoxFar_Bank73

; entry 8 of the `rst $00` table in SceneWizstone
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneWizstone_Msg0782_HeroReceivedTheSmartBook::
Jump_073_5461:: ; address name
    ld hl, $0782 ; '0 received the SmartBook.'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in SceneWizstone
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, wStepArrived, hPlayerFacing
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wSpriteSlots
; points at: wScriptStep
SceneWizstone_StepObjectTowardCoord_Case07::
Jump_073_546C:: ; address name
    ld a, [wSpriteSlots + $C]
    cp a, $40
    jr z, .clear_step_ptr_hi
    xor a, a
    ld [wStepPtrHi], a
    ld a, $00
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ret

.clear_step_ptr_hi:
    xor a, a
    ld [wStepPtrHi], a
    ld a, $03
    ld [wStepTarget], a
    ld a, $10
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ld [wSpriteSlots + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in SceneWizstone
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneWizstone_Msg0781_KiralYesYesSuccess::
Jump_073_54AF:: ; address name
    ld hl, $0781 ; 'Kiral Yes! Yes! Success! I owe'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in SceneWizstone
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneWizstone_AdvanceScriptStep::
Jump_073_54BA:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in SceneWizstone
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneWizstone_Msg0780_ProfessorKiralUsedThe::
Jump_073_54BF:: ; address name
    ld hl, $0780 ; 'Professor Kiral used the WizStone on'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneWizstone
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wSpriteSlots
; points at: wScriptStep
SceneWizstone_StepObjectTowardCoord::
Jump_073_54CA:: ; address name
    ld a, [wSpriteSlots + $B]
    cp a, $50
    jr z, .clear_step_ptr_hi
    xor a, a
    ld [wStepPtrHi], a
    ld a, $01
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ret

.clear_step_ptr_hi:
    xor a, a
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneWizstone
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, hPlayerY, wPartyCount
; writes: wSpriteSlots, wScriptStep
; points at: wScriptStep
SceneWizstone_WriteSpriteSlotsAndScriptStep::
Jump_073_5509:: ; address name
    ldh a, [hPlayerX]
    cp a, $40
    jr nz, .check_party_count
    ldh a, [hPlayerY]
    cp a, $40
    jr z, .done

.check_party_count:
    ld a, [wPartyCount]
    or a, a
    jr z, .set_sprite_slots_to_02
    ld b, a
    ld hl, wFollowerRecords + $1

.loop:
    push hl
    ld a, [hl+]
    cp a, $40
    jr nz, .restore
    ld a, [hl]
    cp a, $40
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

; implements script command type CC (SCRIPT_SCENE_CYAL_SHINE): a cutscene step named after the scene its only script shows: ... 'So Cyal took a shine to...'; reached through ScriptCommandCC in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommandCC)
; reads: wScriptStep
SceneCyalShine::
Func_073_5546:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneCyalShine_RunFieldCommandTemp0AndStep
    dw SceneCyalShine_StepScriptParam0Counter_Bank73

; entry 1 of the `rst $00` table in SceneCyalShine
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5, wScriptStartRequest
SceneCyalShine_StepScriptParam0Counter_Bank73::
Jump_073_554E:: ; address name
    ld b, $3C
    call StepScriptParam0Counter_Bank73
    ret nc
    xor a, a
    ld [wObject5], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 0 of the `rst $00` table in SceneCyalShine
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wObject5
; points at: wScriptStep
SceneCyalShine_RunFieldCommandTemp0AndStep::
Jump_073_555E:: ; address name
    ld a, $05
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + $4], a
    ld a, $20
    ld [wObject5 + $5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type C6 (SCRIPT_SCENE_CYAL_ROLT): a cutscene step named after the scene its only script shows: 'Rolt 0, I'm sorry we put...' ... 'I'm glad that Cyal and Rolt...'; reached through ScriptCommandC6 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommandC6)
; reads: wScriptStep
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind, wScriptStartRequest
SceneCyalRolt::
Func_073_5577:: ; address name
    ld a, [wScriptStep]
    or a, a
    jr nz, .set_script_start_request_to_80
    ld a, $A9
    ldh [hMapId], a
    ld a, $01
    ldh [hMapScreenX], a
    xor a, a
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

; implements script command type C3 (SCRIPT_KEY_BOSS_BEATEN): marks key entry kind hTemp0 with bit 6 (MarkKeyEntryKindTemp0Bit6) and blinks an object: 'Wh-what? I Lost to a child?'; reached through ScriptCommandC3 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommandC3)
; reads: hTemp0
; writes: hTemp0, hTemp1, wScriptStartRequest
KeyBossBeaten::
Func_073_55A4:: ; address name
    xor a, a
    ldh [hTemp0], a
    ld a, $30
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a, a
    ret z
    ld a, $07
    ldh [hTemp0], a
    farcall MarkKeyEntryKindTemp0Bit6
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type C1 (SCRIPT_SCENE_TOO_STRONG): a cutscene step named after the scene its only script shows: 'Too strong Arroooh!' ... 'Rolt What? Cyal was abducted?'; reached through ScriptCommandC1 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommandC1)
; reads: wScriptStep
SceneTooStrong::
Func_073_55C5:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneTooStrong_ScriptStepBlinkObjectTemp0
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw SceneTooStrong_SetBit2AtHL_B73
    dw SceneTooStrong_WriteMessageIndexAndMessageGroupEtc

; entry 3 of the `rst $00` table in SceneTooStrong
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wMessageGroup, wSpriteSlots, wObject1, wStepArrived
; writes: wMessageIndex, wMessageGroup, wSpriteSlots, wObject1, wStepPtrHi, wStepTarget, wStepPtrLo, wScriptStartRequest
SceneTooStrong_WriteMessageIndexAndMessageGroupEtc::
Jump_073_55D1:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    ld a, l
    sub a, $08
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    ld a, [wSpriteSlots + $C]
    sub a, h
    ld [wSpriteSlots + $C], a
    ld a, [wObject1 + $C]
    sub a, h
    ld [wObject1 + $C], a
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $01
    ld [wStepTarget], a
    ld a, $C0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $01
    ld [wStepTarget], a
    ld a, $C0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in SceneTooStrong
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1
; writes: wObject1, wMessageIndex, wMessageGroup
; points at: wScriptStep
SceneTooStrong_SetBit2AtHL_B73::
Jump_073_562C:: ; address name
    ld hl, wObject1 + $D
    call SetBit2AtHL_B73
    ld a, $01
    ld [wObject1 + $7], a
    ld a, [wObject1 + $B]
    cp a, $60
    jr z, .call_clear_bit2_at_hl_bank73
    inc a
    ld [wObject1 + $B], a
    ret

.call_clear_bit2_at_hl_bank73:
    ld hl, wObject1 + $D
    call ClearBit2AtHL_Bank73
    ld hl, $0300
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneTooStrong
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2, hTemp0, wSpriteSlotCount
; writes: hTemp0, hTemp1, wObject3, wSpriteSlotCount, wObject1
; points at: wScriptStep
SceneTooStrong_ScriptStepBlinkObjectTemp0::
Jump_073_5659:: ; address name
    ld a, $02
    ldh [hTemp0], a
    ld a, $40
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ld a, [wObject2 + $C]
    cp a, $40
    jr z, .set_object3
    ld a, $30

.set_object3:
    ld [wObject3 + $C], a
    ldh a, [hTemp0]
    or a, a
    ret z
    ld a, [wSpriteSlotCount]
    dec a
    dec a
    ld [wSpriteSlotCount], a
    xor a, a
    ld [wObject1 + $7], a
    ld hl, $0725 ; 'Tch, I can't enjoy my meal'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type C0 (SCRIPT_SCENE_ROLT_ELDER): a cutscene step named after the scene its only script shows: 'I'm the village's elder.' ... 'Rolt That was fast, 0.'; reached through ScriptCommandC0 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommandC0)
; reads: wScriptStep
SceneRoltElder::
Func_073_568E:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneRoltElder_SetBit2AtHL_B73
    dw SceneRoltElder_WriteObject1AndObject2
    dw SceneRoltElder_WriteObject2AndObject1
    dw SceneRoltElder_ClearBit2AtHL_Bank73

; entry 3 of the `rst $00` table in SceneRoltElder
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2, wObject1
; writes: wObject2, wObject1, wScriptStartRequest
SceneRoltElder_ClearBit2AtHL_Bank73::
Jump_073_569A:: ; address name
    ld a, [wObject2 + $C]
    dec a
    ld [wObject2 + $C], a
    ld a, [wObject1 + $C]
    dec a
    ld [wObject1 + $C], a
    cp a, $50
    ret nz
    ld hl, wObject1 + $D
    call ClearBit2AtHL_Bank73
    ld hl, wObject2 + $D
    call ClearBit2AtHL_Bank73
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in SceneRoltElder
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2, wObject1
; writes: wObject2, wObject1
; points at: wScriptStep
SceneRoltElder_WriteObject2AndObject1::
Jump_073_56BD:: ; address name
    ld a, [wObject2 + $B]
    inc a
    ld [wObject2 + $B], a
    ld a, [wObject1 + $B]
    inc a
    ld [wObject1 + $B], a
    cp a, $60
    ret nz
    ld a, $02
    ld [wObject1 + $7], a
    ld [wObject2 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneRoltElder
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, wObject2
; writes: wObject1, wObject2
; points at: wScriptStep
SceneRoltElder_WriteObject1AndObject2::
Jump_073_56DB:: ; address name
    ld a, [wObject1 + $B]
    inc a
    ld [wObject1 + $B], a
    ld a, [wObject2 + $C]
    dec a
    ld [wObject2 + $C], a
    cp a, $60
    ret nz
    ld a, $01
    ld [wObject2 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneRoltElder
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2, wObject1
; writes: wObject2, wObject1
; points at: wScriptStep
SceneRoltElder_SetBit2AtHL_B73::
Jump_073_56F6:: ; address name
    ld hl, wObject1 + $D
    call SetBit2AtHL_B73
    ld hl, wObject2 + $D
    call SetBit2AtHL_B73
    ld a, [wObject2 + $C]
    dec a
    ld [wObject2 + $C], a
    ld a, [wObject1 + $C]
    dec a
    ld [wObject1 + $C], a
    cp a, $60
    ret nz
    ld a, $01
    ld [wObject1 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 64 (SCRIPT_GATHER_FOLLOWERS): moves the followers onto the leader (ScriptStepMoveFollowersToLeader); reached through ScriptCommand64 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand64)
; reads: wScriptStep
GatherFollowers::
Func_073_571D:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw GatherFollowers_ScriptStepMoveFollowersToLeader
    dw GatherFollowers_ScriptStepMoveFollowersToLeader
    dw GatherFollowers_ScriptStepMoveFollowersToLeader
    dw GatherFollowers_SetScriptStartRequestTo80

; entry 3 of the `rst $00` table in GatherFollowers
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
GatherFollowers_SetScriptStartRequestTo80::
Jump_073_5729:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 63 (SCRIPT_SCENE_RIVAL_FADE): a cutscene step named after the scene its only script shows: 'You defeated my monster? Urggh' (palette fade); reached through ScriptCommand63 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand63)
; reads: wScriptStep
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind, wScriptStartRequest
SceneRivalFade::
Func_073_572F:: ; address name
    ld a, [wScriptStep]
    or a, a
    jr nz, .set_script_start_request_to_80
    ld a, $28
    ldh [hMapId], a
    xor a, a
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

; implements script command type 61 (SCRIPT_SCENE_KAMEHA_STOLE): a cutscene step named after the scene its only script shows: 'King Kameha made off with the...'; reached through ScriptCommand61 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand61)
; reads: wScriptStep
SceneKamehaStole::
Func_073_5761:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneKamehaStole_ToScriptStepMoveFollowersToLeader
    dw SceneKamehaStole_ToScriptStepMoveFollowersToLeader
    dw SceneKamehaStole_ToScriptStepMoveFollowersToLeader
    dw SceneKamehaStole_WriteFollowerRecordsAndScriptStep
    dw SceneKamehaStole_WriteFollowerRecordsAndScriptStep_Case04
    dw SceneKamehaStole_WriteFollowerRecords
    dw SceneKamehaStole_WriteFollowerDelayAndMapSpriteKindEtc

; entry 6 of the `rst $00` table in SceneKamehaStole
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount
; writes: wFollowerDelay, wMapSpriteKind, wScriptStartRequest
SceneKamehaStole_WriteFollowerDelayAndMapSpriteKindEtc::
Jump_073_5773:: ; address name
    ld hl, wScreenTileBuffer + $A8
    ld [hl], $2B
    inc hl
    ld [hl], $2C
    ld hl, wScreenTileBuffer + $BC
    ld [hl], $2D
    inc hl
    ld [hl], $2E
    ld a, [wPartyCount]
    dec a
    jr z, .call_draw_full_screen_buffer_at_scroll
    ld hl, wScreenTileBuffer + $CE
    ld [hl], $2B
    inc hl
    ld [hl], $2C
    ld hl, wScreenTileBuffer + $E2
    ld [hl], $2D
    inc hl
    ld [hl], $2E
    ld a, [wPartyCount]
    dec a
    dec a
    jr z, .call_draw_full_screen_buffer_at_scroll
    ld hl, wScreenTileBuffer + $F8
    ld [hl], $2B
    inc hl
    ld [hl], $2C
    ld hl, wScreenTileBuffer + $10C
    ld [hl], $2D
    inc hl
    ld [hl], $2E

.call_draw_full_screen_buffer_at_scroll:
    farcall DrawFullScreenBufferAtScroll
    ld a, $01
    ld [wFollowerDelay], a
    xor a, a
    ld [wMapSpriteKind], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 5 of the `rst $00` table in SceneKamehaStole
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerRecords
; writes: wFollowerRecords
; points at: wScriptStep
SceneKamehaStole_WriteFollowerRecords::
Jump_073_57C5:: ; address name
    ld a, [wFollowerRecords + $C]
    cp a, $60
    jr z, .set_follower_records_to_01
    ld hl, wFollowerRecords + $C
    inc [hl]
    ret

.set_follower_records_to_01:
    ld a, $01
    ld [wFollowerRecords + $A], a
    ld a, [wFollowerRecords + $B]
    inc a
    ld [wFollowerRecords + $B], a
    cp a, $40
    ret nz
    ld a, $02
    ld [wFollowerRecords + $A], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in SceneKamehaStole
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerRecords, wPartyCount
; writes: wFollowerRecords, wScriptStep
; points at: wScriptStep
SceneKamehaStole_WriteFollowerRecordsAndScriptStep_Case04::
Jump_073_57EA:: ; address name
    ld a, [wFollowerRecords + $6]
    cp a, $30
    jr z, .clear_follower_records
    ld a, [wFollowerRecords + $6]
    dec a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $B], a
    ret

.clear_follower_records:
    xor a, a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ld a, [wFollowerRecords + $7]
    inc a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $C], a
    cp a, $50
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

; entry 3 of the `rst $00` table in SceneKamehaStole
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerRecords, wPartyCount
; writes: wFollowerRecords, wScriptStep
; points at: wScriptStep
SceneKamehaStole_WriteFollowerRecordsAndScriptStep::
Jump_073_5825:: ; address name
    ld a, [wFollowerRecords + $2]
    cp a, $40
    jr z, .set_follower_records_to_03
    ld a, $02
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ld a, [wFollowerRecords + $2]
    dec a
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $C], a
    ret

.set_follower_records_to_03:
    ld a, $03
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ld a, [wFollowerRecords + $1]
    dec a
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $B], a
    cp a, $40
    ret nz
    xor a, a
    ld [wFollowerRecords], a
    ld hl, wScriptStep
    inc [hl]
    ld a, [wPartyCount]
    dec a
    ret nz
    ld a, $06
    ld [wScriptStep], a
    ret

; entry 0 of the `rst $00` table in SceneKamehaStole
; no direct call (reached through a table, a jump or a vector)
SceneKamehaStole_ToScriptStepMoveFollowersToLeader::
Jump_073_5873:: ; address name
    farcall ScriptStepMoveFollowersToLeader
    ret

; implements script command type 60; reached through ScriptCommand60 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand60)
; reads: wScriptStep
ScriptCommand60_Run::
Func_073_587A:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand60_Run_RunFieldCommandTemp0
    dw ScriptCommand60_Run_ScriptApplyStepDeltaAtDE_Bank73
    dw ScriptCommand60_Run_AddStepDeltaToPointedByte
    dw ScriptCommand60_Run_StepScriptParam0Counter_Bank73
    dw ScriptCommand60_Run_ScriptApplyStepDeltaAtDE_Bank73_Case04

; entry 4 of the `rst $00` table in ScriptCommand60_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5, hTemp0, wScriptStartRequest
ScriptCommand60_Run_ScriptApplyStepDeltaAtDE_Bank73_Case04::
Jump_073_5888:: ; address name
    ld hl, wObject5 + $4
    inc [hl]
    ld hl, wObject5 + $5
    inc [hl]
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    xor a, a
    ld [wObject5], a
    ld a, $2C
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    farcall RemoveInventorySlotShiftDown
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 3 of the `rst $00` table in ScriptCommand60_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand60_Run_StepScriptParam0Counter_Bank73::
Jump_073_58B1:: ; address name
    ld b, $5A
    call StepScriptParam0Counter_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in ScriptCommand60_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: wScriptStep
ScriptCommand60_Run_AddStepDeltaToPointedByte::
Jump_073_58BC:: ; address name
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
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in ScriptCommand60_Run
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wObject5
; points at: wScriptStep
ScriptCommand60_Run_RunFieldCommandTemp0::
Jump_073_58E0:: ; address name
    ld a, $10
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $50
    ld [wObject5 + $4], a
    ld a, $30
    ld [wObject5 + $5], a
    ld a, $80
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 5D (SCRIPT_SCENE_DARCK_TAUNT): a cutscene step named after the scene its only script shows: 'N No How could my monsters' ... 'Darck Fawahahah!'; reached through ScriptCommand5D in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand5D)
; reads: hTemp0
; writes: hTemp0, hTemp1, wSpriteSlotCount, wScriptStartRequest
SceneDarckTaunt::
Func_073_58FE:: ; address name
    xor a, a
    ldh [hTemp0], a
    ld a, $30
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

; implements script command type 5C (SCRIPT_TAKE_ITEM): removes item hTemp0 from the inventory (FindTemp0InInventoryList, RemoveInventorySlotShiftDown); '0 handed over the TidalBell.'; reached through ScriptCommand5C in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand5C)
; reads: wScriptParam0
; writes: wObject1, wScriptParam0, hTemp0, wScriptStartRequest
TakeItem::
Func_073_5919:: ; address name
    ld a, [wScriptParam0]
    cp a, $1E
    jr nc, .cp_3C
    bit 1, a
    jr z, .set_object1_to_20
    jr .set_object1_to_E0

.cp_3C:
    cp a, $3C
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
    ld [wObject1 + $C], a
    jr .check_script_param0

.set_object1_to_E0:
    ld a, $E0
    ld [wObject1 + $C], a

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $78
    ret nz
    ld a, $20
    ld [wObject1 + $C], a
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
; 2 call sites from 2 routines (e.g. ScriptCommand59, ScriptCommand5A)
; reads: wScriptStep
SceneSawKameha::
Func_073_5987:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneSawKameha_StepObjectTowardCoord
    dw SceneSawKameha_ClearBit2AtHL_Bank73
    dw SceneSawKameha_CountKeysOrFull

; entry 2 of the `rst $00` table in SceneSawKameha
; no direct call (reached through a table, a jump or a vector)
; reads: wGameFlags836
; writes: hTemp1, wGameFlags836, wScriptStartRequest
SceneSawKameha_CountKeysOrFull::
Jump_073_5991:: ; address name
    farcall CountKeysOrFull
    ld a, $05
    ldh [hTemp1], a
    farcall WriteKeyEntryTemp0
    ld a, [wGameFlags836]
    set 7, a
    ld [wGameFlags836], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in SceneSawKameha
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: hPlayerY, hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
; points at: hPlayerStateFlags
SceneSawKameha_ClearBit2AtHL_Bank73::
Jump_073_59AF:: ; address name
    ld hl, wFollowerRecords + $2
    dec [hl]
    ld hl, wFollowerRecords + $7
    dec [hl]
    ld hl, wFollowerRecords + $C
    dec [hl]
    ldh a, [hPlayerY]
    dec a
    ldh [hPlayerY], a
    cp a, $C0
    ret nz
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank73
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
    ret

; entry 0 of the `rst $00` table in SceneSawKameha
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo
; points at: hPlayerStateFlags, wScriptStep
SceneSawKameha_StepObjectTowardCoord::
Jump_073_59E6:: ; address name
    ld a, $00
    ld [wStepPtrHi], a
    ld a, $02
    ld [wStepTarget], a
    ld a, $B0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $00
    ld [wStepPtrLo], a
    farcall StepPlayerUpTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 57 (SCRIPT_SCENE_THREE_ITEMS_BATTLE): a cutscene step named after the scene its only script shows: 'Good. You have brought the three...' ... 'Don't you ever give up?' (encounter); reached through ScriptCommand57 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand57)
; reads: wScriptStep
SceneThreeItemsBattle::
Func_073_5A16:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneThreeItemsBattle_StartScriptedEncounterTemp0AndStep
    dw SceneThreeItemsBattle_Msg0480_GwaahYouEBeaten
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw SceneThreeItemsBattle_ScriptStepBlinkObjectTemp0

; entry 3 of the `rst $00` table in SceneThreeItemsBattle
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0, hTemp1, wSpriteSlotCount, wScriptStartRequest
SceneThreeItemsBattle_ScriptStepBlinkObjectTemp0::
Jump_073_5A22:: ; address name
    xor a, a
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

; entry 1 of the `rst $00` table in SceneThreeItemsBattle
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneThreeItemsBattle_Msg0480_GwaahYouEBeaten::
Jump_073_5A3D:: ; address name
    ld hl, $0480 ; 'Gwaah! You e beaten me fairly!'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneThreeItemsBattle
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
; points at: wScriptStep
SceneThreeItemsBattle_StartScriptedEncounterTemp0AndStep::
Jump_073_5A48:: ; address name
    ld a, $1C
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 68 (SCRIPT_SCENE_FOUND_ME): a cutscene step named after the scene its only script shows: 'I'm surprised anyone managed to find...'; reached through ScriptCommand68 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand68)
; reads: hPlayerX, wPartyCount, wStepArrived
; writes: wStepTarget, wStepPtrLo, wStepPtrHi, wScriptStartRequest
SceneFoundMe::
Func_073_5A57:: ; address name
    ldh a, [hPlayerX]
    cp a, $40
    jr z, .set_step_target_to_01
    cp a, $60
    jr z, .set_step_target_to_03
    ld a, [wPartyCount]
    ld b, a
    ld hl, wFollowerRecords + $1

.loop:
    push hl
    ld a, [hl]
    cp a, $40
    jr nz, .skip
    inc hl
    ld a, [hl]
    cp a, $40
    jr nz, .restore
    pop hl
    jr .set_step_target_to_01

.skip:
    ld a, [hl]
    cp a, $60
    jr nz, .restore
    inc hl
    ld a, [hl]
    cp a, $40
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
    xor a, a
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 56 (SCRIPT_SCENE_BEATEN_FAIRLY): a cutscene step named after the scene its only script shows: 'You've beaten me fairly Take...'; reached through ScriptCommand56 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand56)
; reads: hTemp0
; writes: hTemp0, hTemp1, wSpriteSlotCount, wScriptStartRequest
SceneBeatenFairly::
Func_073_5ABB:: ; address name
    xor a, a
    ldh [hTemp0], a
    ld a, $30
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

; implements script command type 55 (SCRIPT_SET_FLAG_322): sets story flag $322 (wStoryFlags + $64 bit 2); 'A door opened somewhere'; reached through ScriptCommand55 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand55)
; reads: wStoryFlags
; writes: wStoryFlags, wScriptStartRequest
SetFlag322::
Func_073_5AD6:: ; address name
    ld a, [wStoryFlags + $64]
    set 2, a
    ld [wStoryFlags + $64], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 54 (SCRIPT_SCENE_GRAVESTONE): a cutscene step named after the scene its only script shows: before '0 checked the gravestone.'; reached through ScriptCommand54 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand54)
; reads: wScriptStep
SceneGravestone::
Func_073_5AE4:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneGravestone_SetBit2AtHL_B73
    dw SceneGravestone_WriteScriptStartRequest
    dw ScriptStepMoveObjectCB8AByDirection
    dw SceneGravestone_StepObjectTowardCoord
    dw SceneGravestone_ScriptStepBlinkObjectTemp0

; entry 4 of the `rst $00` table in SceneGravestone
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, wStoryFlags
; writes: hTemp0, hTemp1, wSpriteSlotCount, wStoryFlags, wScriptStartRequest
SceneGravestone_ScriptStepBlinkObjectTemp0::
Jump_073_5AF2:: ; address name
    xor a, a
    ldh [hTemp0], a
    ld a, $20
    ldh [hTemp1], a
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a, a
    ret z
    xor a, a
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
    ld [hl], $5A
    inc hl
    ld [hl], $5A
    inc hl
    ld [hl], $5B
    farcall DrawFullScreenBufferAtScroll
    ld de, $00B1
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 3 of the `rst $00` table in SceneGravestone
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo
; points at: wScriptStep
SceneGravestone_StepObjectTowardCoord::
Jump_073_5B47:: ; address name
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

; moves wCB8A/wCB8B one pixel in direction wScriptParam1 for 16 frames; at ($80, $30) advances wScriptStep, otherwise repeats the step (E-0125)
; 1 call site from 1 routine (e.g. SceneGravestone_WriteScriptStartRequest)
; reads: wScriptParam1, wScriptParam0, wSpriteSlots
; writes: wScriptParam0
; points at: wScriptStep
ScriptStepMoveObjectCB8AByDirection::
Func_073_5B66:: ; address name
    ld a, [wScriptParam1]
    or a, a
    jr nz, .skip
    ld hl, wSpriteSlots + $C
    inc [hl]
    jr .check_script_param02

.skip:
    dec a
    jr nz, .skip2
    ld hl, wSpriteSlots + $B
    inc [hl]
    jr .check_script_param02

.skip2:
    dec a
    jr nz, .check_script_param0
    ld hl, wSpriteSlots + $C
    dec [hl]
    jr .check_script_param02

.check_script_param0:
    ld hl, wSpriteSlots + $B
    dec [hl]

.check_script_param02:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $10
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld a, [wSpriteSlots + $C]
    cp a, $30
    jr nz, .done
    ld a, [wSpriteSlots + $B]
    cp a, $80
    jr nz, .done
    ld hl, wScriptStep
    inc [hl]
    ret

.done:
    ld hl, wScriptStep
    dec [hl]
    ret

; entry 1 of the `rst $00` table in SceneGravestone
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wSpriteSlots, wMessageGroup, wMaxBlockingTile
; writes: wScriptStartRequest
; points at: wScreenTileBuffer, wTilesUnderPoint, wScriptStep
SceneGravestone_WriteScriptStartRequest::
Jump_073_5BAE:: ; address name
    ld a, [wMessageIndex]
    ld d, a
    ld a, [wSpriteSlots + $B]
    add a, d
    ld b, a
    ld a, [wMessageGroup]
    ld d, a
    ld a, [wSpriteSlots + $C]
    add a, d
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
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ld a, $13
    inc de
    add_a_to_hl
    ld a, [hl+]
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
    cp a, c
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
    ld hl, wSpriteSlots + $D
    call ClearBit2AtHL_Bank73
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 0 of the `rst $00` table in SceneGravestone
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: wScriptParam1, wSpriteSlots, wMessageIndex, wMessageGroup
; points at: wScriptStep
SceneGravestone_SetBit2AtHL_B73::
Jump_073_5C1F:: ; address name
    ldh a, [hPlayerX]
    swap a
    and a, $0F
    sub a, $05
    and a, $03
    sla a
    sla a
    ld hl, $5C4F
    add_a_to_hl
    ld a, [hl+]
    ld [wScriptParam1], a
    ld [wSpriteSlots + $7], a
    ld a, [hl+]
    ld [wMessageIndex], a
    ld a, [hl]
    ld [wMessageGroup], a
    ld hl, wSpriteSlots + $D
    call SetBit2AtHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret
    db $03, $F0, $00, $00, $02, $00, $F0, $00, $00, $00, $10, $00, $01, $10, $00, $00

; implements script command type 53 (SCRIPT_SCENE_JUSTICE): a cutscene step named after the scene its only script shows: 'Let the power of justice smite...' ... '0 checked the gravestone.'; reached through ScriptCommand53 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand53)
; reads: hPlayerX, hPlayerY, wScreenTileBuffer, wStoryFlags
; writes: wStoryFlags, wScriptStartRequest
SceneJustice::
Func_073_5C5F:: ; address name
    ldh a, [hPlayerX]
    cp a, $30
    jr nz, .check_player_y
    ldh a, [hPlayerY]
    cp a, $30
    jr nz, .call_scene_justice_write_svbk
    ld hl, wScreenTileBuffer + $52
    call SceneJustice_WriteSVBK
    ld hl, wScreenTileBuffer + $F2
    call SceneJustice_WriteSVBK
    ld hl, wScreenTileBuffer + $100
    call SceneJustice_WriteSVBK
    jr .check_screen_tile_buffer

.call_scene_justice_write_svbk:
    ld hl, wScreenTileBuffer + $F2
    call SceneJustice_WriteSVBK
    ld hl, wScreenTileBuffer + $100
    call SceneJustice_WriteSVBK
    jr .check_screen_tile_buffer

.check_player_y:
    ldh a, [hPlayerY]
    cp a, $30
    jr nz, .call_scene_justice_write_svbk2
    ld hl, wScreenTileBuffer + $60
    call SceneJustice_WriteSVBK
    ld hl, wScreenTileBuffer + $F2
    call SceneJustice_WriteSVBK
    jr .check_screen_tile_buffer

.call_scene_justice_write_svbk2:
    ld hl, wScreenTileBuffer + $60
    call SceneJustice_WriteSVBK
    ld hl, wScreenTileBuffer + $100
    call SceneJustice_WriteSVBK

.check_screen_tile_buffer:
    ld a, [wScreenTileBuffer + $52]
    cp a, $10
    jr nz, .call_draw_full_screen_buffer_at_scroll
    ld a, [wScreenTileBuffer + $60]
    cp a, $10
    jr nz, .call_draw_full_screen_buffer_at_scroll
    ld a, [wScreenTileBuffer + $F2]
    cp a, $10
    jr nz, .call_draw_full_screen_buffer_at_scroll
    ld a, [wScreenTileBuffer + $100]
    cp a, $10
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
    ld [hl], $4A
    inc hl
    ld [hl], $4A
    inc hl
    ld [hl], $4B
    ld a, [wStoryFlags + $64]
    set 0, a
    ld [wStoryFlags + $64], a
    ld de, $00B0
    call SetFlagBit

.call_draw_full_screen_buffer_at_scroll:
    farcall DrawFullScreenBufferAtScroll
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from SceneJustice (E-0047)
; 9 call sites from 1 routine (e.g. SceneJustice)
; reads: wIsCGB
; writes: rSVBK
SceneJustice_WriteSVBK::
Func_073_5D09:: ; address name
    push hl
    call SceneJustice_Sub01_Sub01
    call SceneJustice_Sub01_Sub01
    call SceneJustice_Sub01_Sub01
    call SceneJustice_Sub01_Sub01
    pop hl
    ld a, [wIsCGB]
    or a, a
    ret z
    ld c, $04
    ld a, [hl]
    cp a, $18
    ld c, $05
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
    ld a, $02
    ldh [rSVBK], a
    call SceneJustice_Sub01_Sub02
    call SceneJustice_Sub01_Sub02
    call SceneJustice_Sub01_Sub02
    call SceneJustice_Sub01_Sub02
    ld a, $00
    ldh [rSVBK], a
    ret

; only called from SceneJustice_Sub01 (E-0047)
; 4 call sites from 1 routine (e.g. SceneJustice_WriteSVBK)
SceneJustice_Sub01_Sub01::
Func_073_5D48:: ; address name
    ld a, [hl]
    add a, $08
    cp a, $28
    jr c, .skip
    sub a, $18

.skip:
    ld [hl+], a
    ld a, [hl]
    add a, $08
    cp a, $28
    jr c, .skip2
    sub a, $18

.skip2:
    ld [hl-], a
    ld a, $14
    add_a_to_hl
    ld a, [hl]
    ret

; only called from SceneJustice_Sub01 (E-0047)
; 4 call sites from 1 routine (e.g. SceneJustice_WriteSVBK)
SceneJustice_Sub01_Sub02::
Func_073_5D65:: ; address name
    ld a, c
    ld [hl+], a
    ld [hl-], a
    ld a, $14
    add_a_to_hl
    ld a, [hl]
    ret

; implements script command type 67 (SCRIPT_SCENE_JUSTICE_2): a cutscene step named after the scene its only script shows: 'Let the power of justice smite...'; reached through ScriptCommand67 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand67)
; reads: hMapId, hMapScreenX, hTemp0
; writes: hTemp0, hTemp1, wSpriteSlotCount, wScriptStartRequest
SceneJustice2::
Func_073_5D71:: ; address name
    xor a, a
    ldh [hTemp0], a
    ld a, $20
    ldh [hTemp1], a
    ldh a, [hMapId]
    cp a, $8C
    jr z, .call_script_step_blink_object_temp0
    ldh a, [hMapScreenX]
    cp a, $01
    jr nz, .call_script_step_blink_object_temp0
    ld a, $50
    ldh [hTemp1], a

.call_script_step_blink_object_temp0:
    farcall ScriptStepBlinkObjectTemp0
    ldh a, [hTemp0]
    or a, a
    ret z
    xor a, a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld de, $00C5
    ldh a, [hMapId]
    cp a, $8C
    jr z, .call_set_flag_bit
    inc de
    ldh a, [hMapScreenX]
    or a, a
    jr z, .call_set_flag_bit
    inc de

.call_set_flag_bit:
    call SetFlagBit
    ret

; implements script command type 52 (SCRIPT_SCENE_SMALL_HOLE): a cutscene step named after the scene its only script shows: '0 checked the small hole.' ... 'You can take this treasure, but...'; reached through ScriptCommand52 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand52)
; reads: wScriptStep
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind, wScriptStartRequest
SceneSmallHole::
Func_073_5DAF:: ; address name
    ld a, [wScriptStep]
    or a, a
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

; implements script command type 51 (SCRIPT_SCENE_MADCONDOR_CRY): a cutscene step named after the scene its only script shows: 'Kweeeeeh!'; reached through ScriptCommand51 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand51)
; reads: wScriptStep
SceneMadcondorCry::
Func_073_5DDD:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneMadcondorCry_StepScriptParam0Counter_Bank73
    dw SceneMadcondorCry_WriteScriptParam0
    dw SceneMadcondorCry_WritePlayerYAndFollowerRecordsEtc
    dw SceneMadcondorCry_ScriptStartFadeAndAdvanceStep
    dw SceneMadcondorCry_Msg0433_Kweeeeeh
    dw SceneWizstone_RunMessageBoxFar_Bank73

; entry 4 of the `rst $00` table in SceneMadcondorCry
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneMadcondorCry_Msg0433_Kweeeeeh::
Jump_073_5DED:: ; address name
    ld hl, $0433 ; 'Kweeeeeh!'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in SceneMadcondorCry
; no direct call (reached through a table, a jump or a vector)
; writes: hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
SceneMadcondorCry_ScriptStartFadeAndAdvanceStep::
Jump_073_5DF8:: ; address name
    xor a, a
    ldh [hMapScreenY], a
    ld a, $40
    ld [wWarpDestX], a
    ld a, $30
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; entry 2 of the `rst $00` table in SceneMadcondorCry
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wSpriteSlots
; writes: hPlayerY, wFollowerRecords, hPlayerX, wScriptParam0
; points at: wScriptParam0, wScriptStep
SceneMadcondorCry_WritePlayerYAndFollowerRecordsEtc::
Jump_073_5E11:: ; address name
    ld hl, wSpriteSlots + $B
    inc [hl]
    ld a, [wScriptParam0]
    and a, $01
    jr nz, .call_scene_madcondor_cry_write_message_index
    ld hl, wSpriteSlots + $B
    inc [hl]

.call_scene_madcondor_cry_write_message_index:
    ld hl, wScriptParam0
    inc [hl]
    call SceneMadcondorCry_WriteMessageIndexAndMessageGroupEtc
    add a, $10
    ldh [hPlayerY], a
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $C], a
    ld a, [wSpriteSlots + $B]
    ldh [hPlayerX], a
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $B], a
    ld a, [wSpriteSlots + $C]
    cp a, $C0
    ret c
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneMadcondorCry
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0
; points at: wScriptParam0, wScriptStep
SceneMadcondorCry_WriteScriptParam0::
Jump_073_5E51:: ; address name
    ld hl, wSpriteSlots + $B
    inc [hl]
    ld a, [wScriptParam0]
    and a, $01
    jr nz, .call_scene_madcondor_cry_write_message_index
    ld hl, wSpriteSlots + $B
    inc [hl]

.call_scene_madcondor_cry_write_message_index:
    ld hl, wScriptParam0
    inc [hl]
    call SceneMadcondorCry_WriteMessageIndexAndMessageGroupEtc
    cp a, $70
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; only called from routines of SceneMadcondorCry (E-0098)
; 2 call sites from 2 routines (e.g. SceneMadcondorCry_WritePlayerYAndFollowerRecordsEtc, SceneMadcondorCry_WriteScriptParam0)
; reads: wMessageIndex, wMessageGroup, wSpriteSlots
; writes: wMessageIndex, wMessageGroup, wSpriteSlots
SceneMadcondorCry_WriteMessageIndexAndMessageGroupEtc::
Func_073_5E73:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    ld a, l
    sub a, $18
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    ld a, [wMessageGroup]
    ld h, a
    ld a, [wSpriteSlots + $C]
    add a, h
    ld [wSpriteSlots + $C], a
    ret

; entry 0 of the `rst $00` table in SceneMadcondorCry
; no direct call (reached through a table, a jump or a vector)
; writes: wMessageIndex, wMessageGroup
; points at: wScriptStep
SceneMadcondorCry_StepScriptParam0Counter_Bank73::
Jump_073_5E97:: ; address name
    ld b, $3C
    call StepScriptParam0Counter_Bank73
    ret nc
    ld hl, wSpriteSlots + $D
    call SetBit2AtHL_B73
    ld hl, $05C0
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 50 (SCRIPT_SCENE_MADCONDOR): a cutscene step named after the scene its only script shows: 'Look! A MadCondor! It has something!'; reached through ScriptCommand50 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand50)
; reads: wScriptStep
SceneMadcondor::
Func_073_5EB3:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneMadcondor_StepScriptParam0Counter_Bank73
    dw SceneMadcondor_WriteScriptParam0
    dw SceneMadcondor_WriteObject1AndScriptStartRequest

; entry 2 of the `rst $00` table in SceneMadcondor
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots
; writes: wObject1, wScriptStartRequest
; points at: wScriptParam0
SceneMadcondor_WriteObject1AndScriptStartRequest::
Jump_073_5EBD:: ; address name
    ld hl, wSpriteSlots + $B
    dec [hl]
    ld hl, wScriptParam0
    inc [hl]
    call SceneMadcondor_WriteMessageIndexAndMessageGroupEtc
    add a, $10
    ld [wObject1 + $C], a
    ld a, [wSpriteSlots + $B]
    ld [wObject1 + $B], a
    ld a, [wSpriteSlots + $B]
    cp a, $E0
    ret nz
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in SceneMadcondor
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots
; writes: wScriptParam0
; points at: wScriptParam0, wScriptStep
SceneMadcondor_WriteScriptParam0::
Jump_073_5EDF:: ; address name
    ld hl, wSpriteSlots + $B
    dec [hl]
    ld hl, wScriptParam0
    inc [hl]
    call SceneMadcondor_WriteMessageIndexAndMessageGroupEtc
    ld a, [wSpriteSlots + $B]
    cp a, $40
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; only called from routines of SceneMadcondor (E-0098)
; 2 call sites from 2 routines (e.g. SceneMadcondor_WriteObject1AndScriptStartRequest, SceneMadcondor_WriteScriptParam0)
; reads: wMessageIndex, wMessageGroup, wSpriteSlots
; writes: wMessageIndex, wMessageGroup, wSpriteSlots
SceneMadcondor_WriteMessageIndexAndMessageGroupEtc::
Func_073_5EF9:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    ld a, l
    sub a, $10
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    ld a, [wMessageGroup]
    ld h, a
    ld a, [wSpriteSlots + $C]
    add a, h
    ld [wSpriteSlots + $C], a
    ret

; entry 0 of the `rst $00` table in SceneMadcondor
; no direct call (reached through a table, a jump or a vector)
; writes: wMessageIndex, wMessageGroup
; points at: wScriptStep
SceneMadcondor_StepScriptParam0Counter_Bank73::
Jump_073_5F1D:: ; address name
    ld b, $3C
    call StepScriptParam0Counter_Bank73
    ret nc
    ld hl, wSpriteSlots + $D
    call SetBit2AtHL_B73
    ld hl, $03C0
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 4F (SCRIPT_SET_TILES_D2): writes tiles $68-$6B into a 2 x 2 block of wScreenTileBuffer ($D2, $D3, $E6, $E7) and redraws the screen; reached through ScriptCommand4F in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand4F)
; writes: wScriptStartRequest
SetTilesD2::
Func_073_5F39:: ; address name
    ld hl, wScreenTileBuffer + $D2
    ld [hl], $68
    inc hl
    ld [hl], $69
    ld hl, wScreenTileBuffer + $E6
    ld [hl], $6A
    inc hl
    ld [hl], $6B
    farcall DrawFullScreenBufferAtScroll
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; adds record wD7F5 to the party: Func_001_6E46, wC6FD += 1, writes a follower entry (wCBB6, wCBBA, wCBBB) and wC6FE[n] = wD7F5, refreshes the list and sprites, then requests script $80 (E-0121)
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wPartyCount, wObject3
; writes: hTemp1, hTemp2, hTemp3, wOBJPaletteUploadRequest, wScriptStartRequest
; points at: wPartyCount, wFollowerRecords, wPartyList, wSpriteSlotCount
AddRecordArg5AsFollower:: ; heuristic: follows a terminator; C0
Func_073_5F55:: ; address name
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
    add a, a
    add a, a
    add a, c
    ld hl, wFollowerRecords
    add_a_to_hl
    ld a, [wObject3 + $7]
    ld [hl+], a
    ld a, [wObject3 + $B]
    ld [hl+], a
    ld a, [wObject3 + $C]
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
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld hl, wSpriteSlotCount
    dec [hl]
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 4C; reached through ScriptCommand4C in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand4C)
; reads: wScriptStep
ScriptCommand4C_Run::
Func_073_5FBC:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand4C_Run_RunFieldCommandTemp0
    dw ScriptCommand4C_Run_StepScriptParam0Counter_Bank73

; entry 1 of the `rst $00` table in ScriptCommand4C_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wObject5, wScriptStartRequest
ScriptCommand4C_Run_StepScriptParam0Counter_Bank73::
Jump_073_5FC4:: ; address name
    ld a, $80
    ld [wObject5], a
    ld a, [wScriptParam0]
    and a, $03
    jr nz, .call_step_script_param0_counter_bank73
    ld hl, wObject5 + $5
    dec [hl]

.call_step_script_param0_counter_bank73:
    ld b, $5A
    call StepScriptParam0Counter_Bank73
    ret nc
    xor a, a
    ld [wObject5], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 0 of the `rst $00` table in ScriptCommand4C_Run
; no direct call (reached through a table, a jump or a vector)
; reads: hMapId
; writes: hTemp0, wObject5
; points at: wScriptStep
ScriptCommand4C_Run_RunFieldCommandTemp0::
Jump_073_5FE4:: ; address name
    ld a, $11
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld hl, $6020
    ld de, $00D1
    call TestFlagBit
    jr nc, .read_map_id
    ld hl, $602C

.read_map_id:
    ldh a, [hMapId]
    ld c, a

.skip:
    push hl
    ld a, [hl]
    cp a, c
    jr nz, .restore
    inc hl
    ld a, [hl]
    and a, $F0
    ld [wObject5 + $4], a
    ld a, [hl]
    and a, $0F
    swap a
    add a, $F8
    ld [wObject5 + $5], a
    pop hl
    ld hl, wScriptStep
    inc [hl]
    ret

.restore:
    pop hl
    inc hl
    inc hl
    jr .skip
    db $06, $31, $12, $44, $00, $63, $02, $24, $16, $53, $1A, $43, $06, $31, $12, $44
    db $00, $53, $02, $24, $16, $42, $1A, $43

; implements script command type 47 (SCRIPT_SCENE_SPIRIT_ENVOY_2): a cutscene step named after the scene its only script shows: 'Oh? An envoy from the spirit!' ... 'You startled me'; reached through ScriptCommand47 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand47)
; reads: wScriptStep
SceneSpiritEnvoy2::
Func_073_6038:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneSpiritEnvoy2_SetBit1AtHL_Bank73
    dw SceneSpiritEnvoy2_ScriptStepBlinkSpritesThenEnd

; entry 1 of the `rst $00` table in SceneSpiritEnvoy2
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
SceneSpiritEnvoy2_ScriptStepBlinkSpritesThenEnd::
Jump_073_6040:: ; address name
    ld a, [wScriptParam0]
    and a, $01
    jr z, .call_script_step_blink_sprites_then_end
    ld hl, wSpriteSlots + $C
    inc [hl]

.call_script_step_blink_sprites_then_end:
    call ScriptStepBlinkSpritesThenEnd
    ret

; entry 0 of the `rst $00` table in SceneSpiritEnvoy2
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlots
; points at: wScriptStep
SceneSpiritEnvoy2_SetBit1AtHL_Bank73::
Jump_073_604F:: ; address name
    ld hl, wSpriteSlots + $D
    call SetBit1AtHL_Bank73
    ld b, $1E
    call StepScriptParam0Counter_Bank73
    ret nc
    xor a, a
    ld [wSpriteSlots + $7], a
    ld hl, wScriptStep
    inc [hl]
    ld de, $0098
    call TestFlagBit
    jr c, .call_set_flag_bit
    ld de, $0098
    call SetFlagBit
    ret

.call_set_flag_bit:
    ld de, $0099
    call SetFlagBit
    ret

; implements script command type 44 (SCRIPT_SCENE_REAL_KING): a cutscene step named after the scene its only script shows: before 'I'm the real King, you fake!'; reached through ScriptCommand44 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand44)
; reads: wScriptStep
SceneRealKing::
Func_073_6079:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneRealKing_RunFieldCommandTemp0
    dw SceneRealKing_QueueSoundEffect
    dw SceneRealKing_StepScriptParam0Counter_Bank73

; entry 2 of the `rst $00` table in SceneRealKing
; no direct call (reached through a table, a jump or a vector)
; writes: wObject2, wObject1, wObject5, wSpriteSlotCount, wScriptStartRequest
SceneRealKing_StepScriptParam0Counter_Bank73::
Jump_073_6083:: ; address name
    ld b, $78
    call StepScriptParam0Counter_Bank73
    ret nc
    ld a, $40
    ld [wObject2 + $C], a
    ld a, $50
    ld [wObject1 + $C], a
    xor a, a
    ld [wObject5], a
    ld a, $03
    ld [wSpriteSlotCount], a
    ld a, $00
    call QueueSoundEffect
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in SceneRealKing
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2, wObject1
; writes: wObject2, wObject1, wSpriteSlotCount, wObject5
; points at: wScriptStep
SceneRealKing_QueueSoundEffect::
Jump_073_60A7:: ; address name
    ld a, [wObject2 + $C]
    inc a
    inc a
    ld [wObject2 + $C], a
    ld a, [wObject1 + $C]
    dec a
    dec a
    ld [wObject1 + $C], a
    cp a, $48
    ret nz
    xor a, a
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wObject5], a
    ld a, $7D
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneRealKing
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject1
; writes: wScriptParam0, wObject1, hTemp0, wObject5
; points at: wScriptStep
SceneRealKing_RunFieldCommandTemp0::
Jump_073_60CD:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    ret nz
    ld hl, wObject2 + $C
    dec [hl]
    ld a, [wObject1 + $C]
    inc a
    ld [wObject1 + $C], a
    cp a, $58
    ret nz
    ld a, $0C
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $40
    ld [wObject5 + $4], a
    ld a, $48
    ld [wObject5 + $5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 3F (SCRIPT_BLINK_SPRITES): shows the first sprite slot only on alternate groups of four frames (wSpriteSlotCount by wFrameCounterLo bit 2); reached through ScriptCommand3F in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand3F)
; reads: wFrameCounterLo, wObject1
; writes: wSpriteSlotCount, wObject1, wScriptStartRequest
BlinkSprites::
Func_073_60FE:: ; address name
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
    ld a, [wObject1 + $C]
    inc a
    ld [wObject1 + $C], a
    cp a, $70
    ret nz
    ld a, $02
    ld [wSpriteSlotCount], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 3E (SCRIPT_SCENE_STRONGEST_MASTER): a cutscene step named after the scene its only script shows: 'The strongest master I've ever...'; reached through ScriptCommand3E in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand3E)
; reads: wScriptStep
SceneStrongestMaster::
Func_073_6126:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneStrongestMaster_SetupScriptSpriteFromMapSpriteKind
    dw SceneStrongestMaster_ToPlaySound83AndAdvanceScriptStep
    dw SceneStrongestMaster_ToScriptStepAnimateSpriteBySteps
    dw SceneStrongestMaster_WriteFieldDrawFlagsAndMapSpriteKindEtc

; entry 3 of the `rst $00` table in SceneStrongestMaster
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageGroup, wMessageIndex
; writes: hFieldDrawFlags, wMapSpriteKind, wScriptStartRequest
SceneStrongestMaster_WriteFieldDrawFlagsAndMapSpriteKindEtc::
Jump_073_6132:: ; address name
    ld a, [wMessageGroup]
    swap a
    and a, $0F
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
    and a, $0F
    add a, a
    add_a_to_hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $C1
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
    xor a, a
    ldh [hFieldDrawFlags], a
    xor a, a
    ld [wMapSpriteKind], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in SceneStrongestMaster
; no direct call (reached through a table, a jump or a vector)
SceneStrongestMaster_ToScriptStepAnimateSpriteBySteps::
Jump_073_6181:: ; address name
    farcall ScriptStepAnimateSpriteBySteps
    ret

; entry 1 of the `rst $00` table in SceneStrongestMaster
; no direct call (reached through a table, a jump or a vector)
SceneStrongestMaster_ToPlaySound83AndAdvanceScriptStep::
Jump_073_6188:: ; address name
    farcall PlaySound83AndAdvanceScriptStep
    ret

; entry 0 of the `rst $00` table in SceneStrongestMaster
; no direct call (reached through a table, a jump or a vector)
; writes: wMapSpriteKind
SceneStrongestMaster_SetupScriptSpriteFromMapSpriteKind::
Jump_073_618F:: ; address name
    ld a, $10
    ld [wMapSpriteKind], a
    farcall SetupScriptSpriteFromMapSpriteKind
    ret

; entry 0 of the `rst $00` table in GatherFollowers
; no direct call (reached through a table, a jump or a vector)
; writes: wMapSpriteKind
GatherFollowers_ScriptStepMoveFollowersToLeader::
Jump_073_619B:: ; address name
    ld a, $10
    ld [wMapSpriteKind], a
    farcall ScriptStepMoveFollowersToLeader
    ret

; implements script command type 3D (SCRIPT_REWARD_ITEM_OR_KEY_2): the same rewards as SCRIPT_REWARD_ITEM_OR_KEY in another scene: 'Fantastic! I can open my shop' ... 'I like you to have this.'; reached through ScriptCommand3D in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand3D)
; reads: wScriptStep
RewardItemOrKey2::
Func_073_61A7:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw RewardItemOrKey2_FindPartyIndexOfSpeciesTemp0
    dw RewardItemOrKey2_ReadMessageIndexAndMessageGroup
    dw RewardItemOrKey2_WriteObject3
    dw RewardItemOrKey2_LoadListedRecordNameTilesForTemp0
    dw RewardItemOrKey2_StepScriptParam0Counter_Bank73
    dw RewardItemOrKey2_ShowHuhThereIsSomething
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw RewardItemOrKey2_TestFlagBit
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw RewardItemOrKey2_TestFlagBit_Case09

; entry 9 of the `rst $00` table in RewardItemOrKey2
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerFacing, wInventory, wGameFlags836
; writes: wScriptStartRequest, wObject1, wStepPtrLo, hTemp1, wGameFlags836
RewardItemOrKey2_TestFlagBit_Case09::
Jump_073_61BF:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ld [wObject1 + $7], a
    ld de, $0191
    call TestFlagBit
    jr c, .call_count_keys_or_full
    ld a, [wInventory + $17]
    cp a, $FF
    jr z, .set_step_ptr_lo_to_2C
    or a, a
    jr z, .set_step_ptr_lo_to_2C
    ret

.set_step_ptr_lo_to_2C:
    ld a, $2C
    ld [wStepPtrLo], a
    farcall AppendItemWC928ToInventory
    ret

.call_count_keys_or_full:
    farcall CountKeysOrFull
    ld a, $04
    ldh [hTemp1], a
    farcall WriteKeyEntryTemp0
    ld a, [wGameFlags836]
    set 7, a
    ld [wGameFlags836], a
    ld de, $0135
    call SetFlagBit
    ret

; entry 7 of the `rst $00` table in RewardItemOrKey2
; no direct call (reached through a table, a jump or a vector)
; writes: wObject1, wObject3
; points at: wScriptStep
RewardItemOrKey2_TestFlagBit::
Jump_073_620B:: ; address name
    ld de, $0191
    call TestFlagBit
    jr c, .call_start_message_hl_b73b
    ld hl, $0D3F
    jr .call_start_message_hl_b73b2

.call_start_message_hl_b73b:
    ld hl, $0D4B ; 'What's that? Hey, a Magic Key!'

.call_start_message_hl_b73b2:
    call StartMessageHL_B73b
    ld a, $00
    ld [wObject1 + $7], a
    ld a, $02
    ld [wObject3 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RewardItemOrKey2
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wObject3, wScriptParam0
; points at: wScriptStep
RewardItemOrKey2_ShowHuhThereIsSomething::
Jump_073_622D:: ; address name
    ld a, [wScriptParam0]
    swap a
    and a, $01
    add a, a
    inc a
    ld [wObject3 + $7], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $78
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld hl, $0D3E ; 'Huh? There is something here. Under'
    call StartMessageHL_B73b
    ret

; entry 4 of the `rst $00` table in RewardItemOrKey2
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
RewardItemOrKey2_StepScriptParam0Counter_Bank73::
Jump_073_6252:: ; address name
    ld b, $3C
    call StepScriptParam0Counter_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RewardItemOrKey2
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wMessageGroup, wSavedPlayerState
; writes: hTemp0, hTemp1, hFieldDrawFlags, wScriptParam0
; points at: wScriptStep
RewardItemOrKey2_LoadListedRecordNameTilesForTemp0::
Jump_073_625D:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    ld a, [wSavedPlayerState]
    ld [hl+], a
    ld a, [wSavedPlayerState + $1]
    ld [hl+], a
    ld a, [wSavedPlayerState + $2]
    ld [hl], a
    ld hl, $00B9
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall LoadListedRecordNameTilesForTemp0
    xor a, a
    ldh [hFieldDrawFlags], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RewardItemOrKey2
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wMessageGroup
; writes: wObject3
; points at: wScriptStep
RewardItemOrKey2_WriteObject3::
Jump_073_628C:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $50
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
    ld [wObject3 + $C], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RewardItemOrKey2
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wMessageGroup
; points at: wScriptStep
RewardItemOrKey2_ReadMessageIndexAndMessageGroup::
Jump_073_62B0:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $40
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
    cp a, $20
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

; entry 0 of the `rst $00` table in RewardItemOrKey2
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0
; writes: hTemp0, hTemp1, wMessageIndex, wMessageGroup, wSavedPlayerState
; points at: wFollowerRecords, wScriptStep
RewardItemOrKey2_FindPartyIndexOfSpeciesTemp0::
Jump_073_62D7:: ; address name
    ld hl, $00B9
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall FindPartyIndexOfSpeciesTemp0
    ldh a, [hTemp0]
    ld c, a
    sla a
    sla a
    add a, c
    ld hl, wFollowerRecords
    add_a_to_hl
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    ld a, [hl+]
    ld [wSavedPlayerState], a
    ld a, [hl+]
    ld [wSavedPlayerState + $1], a
    ld a, [hl]
    ld [wSavedPlayerState + $2], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 3C (SCRIPT_REWARD_ITEM_OR_KEY): gives an item or a key entry (AppendItemWC928ToInventory, WriteKeyEntryTemp0); 'Great, 0! Thanks a lot!' ... 'Here, 0! You hold onto it.'; reached through ScriptCommand3C in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand3C)
; reads: wScriptStep
RewardItemOrKey::
Func_073_630F:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw RewardItemOrKey_FindPartyIndexOfSpeciesTemp0
    dw RewardItemOrKey_ReadMessageIndexAndMessageGroup
    dw RewardItemOrKey_WriteObject1
    dw RewardItemOrKey_WriteObject1AndScriptStep
    dw RewardItemOrKey_ReadMessageIndexAndMessageGroup_Case04
    dw RewardItemOrKey_WriteObject1_Case05
    dw RewardItemOrKey_WriteObject1AndScriptStep_Case06
    dw RewardItemOrKey_ReadMessageIndexAndMessageGroup
    dw RewardItemOrKey_WriteObject1_Case08
    dw RewardItemOrKey_WriteObject1AndScriptStep
    dw RewardItemOrKey_ReadMessageIndexAndMessageGroup_Case04
    dw RewardItemOrKey_WriteObject1_Case0B
    dw RewardItemOrKey_WriteObject1AndScriptStep_Case06
    dw RewardItemOrKey_LoadListedRecordNameTilesForTemp0
    dw RewardItemOrKey_StepScriptParam0Counter_Bank73
    dw RewardItemOrKey_ShowOKLetMeDig
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw RewardItemOrKey_TestFlagBit
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw RewardItemOrKey_TestFlagBit_Case13

; entry 19 of the `rst $00` table in RewardItemOrKey
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerFacing, wInventory, wGameFlags836
; writes: wScriptStartRequest, wSpriteSlots, wStepPtrLo, hTemp1, wGameFlags836
RewardItemOrKey_TestFlagBit_Case13::
Jump_073_633B:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ld [wSpriteSlots + $7], a
    ld de, $0134
    call TestFlagBit
    jr c, .call_count_keys_or_full
    ld a, [wInventory + $17]
    cp a, $FF
    jr z, .set_step_ptr_lo_to_2C
    or a, a
    jr z, .set_step_ptr_lo_to_2C
    ret

.set_step_ptr_lo_to_2C:
    ld a, $2C
    ld [wStepPtrLo], a
    farcall AppendItemWC928ToInventory
    ret

.call_count_keys_or_full:
    farcall CountKeysOrFull
    ld a, $04
    ldh [hTemp1], a
    farcall WriteKeyEntryTemp0
    ld a, [wGameFlags836]
    set 7, a
    ld [wGameFlags836], a
    ld de, $0135
    call SetFlagBit
    ret

; entry 17 of the `rst $00` table in RewardItemOrKey
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1
; writes: wSpriteSlots, wObject1
; points at: wScriptStep
RewardItemOrKey_TestFlagBit::
Jump_073_6387:: ; address name
    ld de, $0134
    call TestFlagBit
    jr c, .call_start_message_hl_b73b
    ld hl, $0D46
    jr .call_start_message_hl_b73b2

.call_start_message_hl_b73b:
    ld hl, $0D16 ; 'What's wrong, MadGopher? Did you find'

.call_start_message_hl_b73b2:
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ld a, [wObject1 + $B]
    cp a, $50
    jr nz, .cp_70
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld a, $01
    ld [wObject1 + $7], a
    ret

.cp_70:
    cp a, $70
    jr nz, .check_object1
    ld a, $01
    ld [wSpriteSlots + $7], a
    ld a, $03
    ld [wObject1 + $7], a
    ret

.check_object1:
    ld a, [wObject1 + $C]
    cp a, $20
    jr nz, .clear_sprite_slots
    ld a, $02
    ld [wSpriteSlots + $7], a
    xor a, a
    ld [wObject1 + $7], a
    ret

.clear_sprite_slots:
    xor a, a
    ld [wSpriteSlots + $7], a
    ld a, $02
    ld [wObject1 + $7], a
    ret

; entry 15 of the `rst $00` table in RewardItemOrKey
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wObject1, wScriptParam0
; points at: wScriptStep
RewardItemOrKey_ShowOKLetMeDig::
Jump_073_63DA:: ; address name
    ld a, [wScriptParam0]
    swap a
    and a, $01
    add a, a
    inc a
    ld [wObject1 + $7], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $78
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld hl, $0D15 ; 'OK! Let me dig! One-two, one-two!'
    call StartMessageHL_B73b
    ret

; entry 14 of the `rst $00` table in RewardItemOrKey
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
RewardItemOrKey_StepScriptParam0Counter_Bank73::
Jump_073_63FF:: ; address name
    ld b, $3C
    call StepScriptParam0Counter_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in RewardItemOrKey
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wMessageGroup, wSavedPlayerState
; writes: hTemp0, hTemp1, hFieldDrawFlags, wObject1, wScriptParam0
; points at: wSpriteSlotCount, wScriptStep
RewardItemOrKey_LoadListedRecordNameTilesForTemp0::
Jump_073_640A:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    ld a, [wSavedPlayerState]
    ld [hl+], a
    ld a, [wSavedPlayerState + $1]
    ld [hl+], a
    ld a, [wSavedPlayerState + $2]
    ld [hl], a
    ld hl, $005A
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall LoadListedRecordNameTilesForTemp0
    xor a, a
    ldh [hFieldDrawFlags], a
    xor a, a
    ld [wObject1 + $7], a
    ld hl, wSpriteSlotCount
    inc [hl]
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 11 of the `rst $00` table in RewardItemOrKey
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wMessageGroup
; writes: wObject1
; points at: wScriptStep
RewardItemOrKey_WriteObject1_Case0B::
Jump_073_6441:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $50
    jr nz, .call_reward_item_or_key_shared03
    ld a, $50
    ld [wObject1 + $B], a
    ld hl, wScriptStep
    inc [hl]
    ret

.call_reward_item_or_key_shared03:
    call RewardItemOrKey_Shared03
    ret

; entry 8 of the `rst $00` table in RewardItemOrKey
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wMessageGroup
; writes: wObject1
; points at: wScriptStep
RewardItemOrKey_WriteObject1_Case08::
Jump_073_645D:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $20
    jr nz, .call_reward_item_or_key_shared02
    ld a, $20
    ld [wObject1 + $C], a
    ld hl, wScriptStep
    inc [hl]
    ret

.call_reward_item_or_key_shared02:
    call RewardItemOrKey_Shared02
    ret

; entry 6 of the `rst $00` table in RewardItemOrKey
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wMessageGroup
; writes: wObject1, wScriptStep
RewardItemOrKey_WriteObject1AndScriptStep_Case06::
Jump_073_647A:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $30
    jr nz, .skip
    ld a, $30
    ld [wObject1 + $C], a
    ld a, $0D
    ld [wScriptStep], a
    ret

.skip:
    jr nc, .call_reward_item_or_key_shared02
    call RewardItemOrKey_Shared01
    ret

.call_reward_item_or_key_shared02:
    call RewardItemOrKey_Shared02
    ret

; entry 5 of the `rst $00` table in RewardItemOrKey
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wMessageGroup
; writes: wObject1
; points at: wScriptStep
RewardItemOrKey_WriteObject1_Case05::
Jump_073_649E:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $70
    jr nz, .call_reward_item_or_key_shared04
    ld a, $70
    ld [wObject1 + $B], a
    ld hl, wScriptStep
    inc [hl]
    ret

.call_reward_item_or_key_shared04:
    call RewardItemOrKey_Shared04
    ret

; entry 4 of the `rst $00` table in RewardItemOrKey
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wMessageGroup
; points at: wScriptStep
RewardItemOrKey_ReadMessageIndexAndMessageGroup_Case04::
Jump_073_64BA:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $20
    jr nz, .cp_40

.loop:
    ld hl, wScriptStep
    inc [hl]
    ret

.cp_40:
    cp a, $40
    jr z, .loop
    jr nc, .call_reward_item_or_key_shared02
    call RewardItemOrKey_Shared01
    ret

.call_reward_item_or_key_shared02:
    call RewardItemOrKey_Shared02
    ret

; entry 3 of the `rst $00` table in RewardItemOrKey
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wMessageGroup
; writes: wObject1, wScriptStep
RewardItemOrKey_WriteObject1AndScriptStep::
Jump_073_64DC:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $60
    jr nz, .skip
    ld a, $60
    ld [wObject1 + $B], a
    ld a, $0D
    ld [wScriptStep], a
    ret

.skip:
    jr nc, .call_reward_item_or_key_shared03
    call RewardItemOrKey_Shared04
    ret

.call_reward_item_or_key_shared03:
    call RewardItemOrKey_Shared03
    ret

; entry 2 of the `rst $00` table in RewardItemOrKey
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wMessageGroup
; writes: wObject1
; points at: wScriptStep
RewardItemOrKey_WriteObject1::
Jump_073_64FF:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $40
    jr nz, .call_reward_item_or_key_shared01
    ld a, $40
    ld [wObject1 + $C], a
    ld hl, wScriptStep
    inc [hl]
    ret

.call_reward_item_or_key_shared01:
    call RewardItemOrKey_Shared01
    ret

; entry 1 of the `rst $00` table in RewardItemOrKey
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wMessageGroup
; points at: wScriptStep
RewardItemOrKey_ReadMessageIndexAndMessageGroup::
Jump_073_651C:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $70
    jr nz, .cp_50

.loop:
    ld hl, wScriptStep
    inc [hl]
    ret

.cp_50:
    cp a, $50
    jr z, .loop
    jr nc, .call_reward_item_or_key_shared03
    call RewardItemOrKey_Shared04
    ret

.call_reward_item_or_key_shared03:
    call RewardItemOrKey_Shared03
    ret

; entry 0 of the `rst $00` table in RewardItemOrKey
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, hPlayerFacing
; writes: hTemp0, hTemp1, wMessageIndex, wMessageGroup, wSavedPlayerState, wScriptStep
; points at: wFollowerRecords, wSpriteSlotCount, wScriptStep
RewardItemOrKey_FindPartyIndexOfSpeciesTemp0::
Jump_073_653D:: ; address name
    ld hl, $005A
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall FindPartyIndexOfSpeciesTemp0
    ldh a, [hTemp0]
    ld c, a
    sla a
    sla a
    add a, c
    ld hl, wFollowerRecords
    add_a_to_hl
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    ld a, [hl+]
    ld [wSavedPlayerState], a
    ld a, [hl+]
    ld [wSavedPlayerState + $1], a
    ld a, [hl]
    ld [wSavedPlayerState + $2], a
    ld hl, wSpriteSlotCount
    dec [hl]
    ldh a, [hPlayerFacing]
    or a, a
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
    ld a, $0A
    ld [wScriptStep], a
    ret

; only called from routines of RewardItemOrKey (E-0098)
; 3 call sites from 3 routines (e.g. RewardItemOrKey_WriteObject1AndScriptStep_Case06, RewardItemOrKey_ReadMessageIndexAndMessageGroup_Case04, RewardItemOrKey_WriteObject1)
RewardItemOrKey_Shared01::
Func_073_6596:: ; address name
    inc a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $00
    ret

; only called from routines of RewardItemOrKey (E-0098)
; 3 call sites from 3 routines (e.g. RewardItemOrKey_WriteObject1_Case08, RewardItemOrKey_WriteObject1AndScriptStep_Case06, RewardItemOrKey_ReadMessageIndexAndMessageGroup_Case04)
RewardItemOrKey_Shared02::
Func_073_659D:: ; address name
    dec a
    ld [hl], a
    dec hl
    dec hl
    ld [hl], $02
    ret

; only called from routines of RewardItemOrKey (E-0098)
; 3 call sites from 3 routines (e.g. RewardItemOrKey_WriteObject1_Case0B, RewardItemOrKey_WriteObject1AndScriptStep, RewardItemOrKey_ReadMessageIndexAndMessageGroup)
RewardItemOrKey_Shared03::
Func_073_65A4:: ; address name
    dec a
    ld [hl], a
    dec hl
    ld [hl], $03
    ret

; only called from routines of RewardItemOrKey (E-0098)
; 3 call sites from 3 routines (e.g. RewardItemOrKey_WriteObject1_Case05, RewardItemOrKey_WriteObject1AndScriptStep, RewardItemOrKey_ReadMessageIndexAndMessageGroup)
RewardItemOrKey_Shared04::
Func_073_65AA:: ; address name
    inc a
    ld [hl], a
    dec hl
    ld [hl], $01
    ret

; implements script command type 3A (SCRIPT_SCENE_MASTER_THANKS): a cutscene step named after the scene its only script shows: 'R Really? Wow! Thank you!' ... 'I became a master because I...'; reached through ScriptCommand3A in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand3A)
; reads: wScriptStep
SceneMasterThanks::
Func_073_65B0:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneMasterThanks_FindPartyIndexOfSpeciesTemp0
    dw SceneMasterThanks_WriteScriptStep
    dw SceneMasterThanks_ReadMessageIndexAndMessageGroup
    dw SceneMasterThanks_ReadMessageIndexAndMessageGroup_Case03
    dw SceneMasterThanks_ReadMessageIndexAndMessageGroup_Case04
    dw SceneMasterThanks_WriteSpriteSlotsAndFieldDrawFlagsEtc
    dw SceneMasterThanks_WriteScriptStep_Case06
    dw SceneMasterThanks_ReadMessageIndexAndMessageGroup_Case03
    dw SceneMasterThanks_ReadMessageIndexAndMessageGroup_Case08
    dw SceneMasterThanks_WriteSpriteSlotsAndFieldDrawFlags
    dw SceneMasterThanks_LoadListedRecordNameTilesForTemp0
    dw SceneMasterThanks_AddStepDeltaToPointedByte

; entry 11 of the `rst $00` table in SceneMasterThanks
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0, wScriptStartRequest
SceneMasterThanks_AddStepDeltaToPointedByte::
Jump_073_65CC:: ; address name
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
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 10 of the `rst $00` table in SceneMasterThanks
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wMessageGroup, wSavedPlayerState
; writes: hTemp0, hTemp1, hFieldDrawFlags
; points at: wScriptStep
SceneMasterThanks_LoadListedRecordNameTilesForTemp0::
Jump_073_65ED:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    ld a, [wSavedPlayerState]
    ld [hl+], a
    ld a, [wSavedPlayerState + $1]
    ld [hl+], a
    ld a, [wSavedPlayerState + $2]
    ld [hl], a
    ld hl, $0002
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    farcall LoadListedRecordNameTilesForTemp0
    xor a, a
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in SceneMasterThanks
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wMessageGroup
; writes: wSpriteSlots, hFieldDrawFlags
; points at: wScriptStep
SceneMasterThanks_WriteSpriteSlotsAndFieldDrawFlags::
Jump_073_6618:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $40
    jr nz, .skip
    dec hl
    ld [hl], $02
    ld a, $02
    ld [wSpriteSlots + $7], a
    ld a, $40
    ld [wSpriteSlots + $B], a
    ld a, $50
    ld [wSpriteSlots + $C], a
    ld a, $0E
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

; entry 8 of the `rst $00` table in SceneMasterThanks
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wMessageGroup
; points at: wScriptStep
SceneMasterThanks_ReadMessageIndexAndMessageGroup_Case08::
Jump_073_664F:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $50
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

; entry 6 of the `rst $00` table in SceneMasterThanks
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wMessageGroup
; writes: wScriptStep
SceneMasterThanks_WriteScriptStep_Case06::
Jump_073_666A:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $40
    jr z, .set_script_step_to_07
    cp a, $50
    jr nz, .set_script_step_to_08

.set_script_step_to_07:
    ld a, $07
    ld [wScriptStep], a
    ret

.set_script_step_to_08:
    ld a, $08
    ld [wScriptStep], a
    ret

; entry 5 of the `rst $00` table in SceneMasterThanks
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wMessageGroup
; writes: wSpriteSlots, hFieldDrawFlags, wScriptStep
SceneMasterThanks_WriteSpriteSlotsAndFieldDrawFlagsEtc::
Jump_073_6688:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $40
    jr nz, .skip
    dec hl
    ld [hl], $00
    ld a, $40
    ld [wSpriteSlots + $B], a
    ld a, $0E
    ldh [hFieldDrawFlags], a
    ld a, $0A
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

; entry 4 of the `rst $00` table in SceneMasterThanks
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wMessageGroup
; points at: wScriptStep
SceneMasterThanks_ReadMessageIndexAndMessageGroup_Case04::
Jump_073_66B6:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $30
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

; entry 3 of the `rst $00` table in SceneMasterThanks
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wMessageGroup
; points at: wScriptStep
SceneMasterThanks_ReadMessageIndexAndMessageGroup_Case03::
Jump_073_66D1:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $60
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

; entry 2 of the `rst $00` table in SceneMasterThanks
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wMessageGroup
; points at: wScriptStep
SceneMasterThanks_ReadMessageIndexAndMessageGroup::
Jump_073_66EA:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    inc hl
    ld a, [hl]
    cp a, $50
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

; entry 1 of the `rst $00` table in SceneMasterThanks
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageIndex, wMessageGroup
; writes: wScriptStep
SceneMasterThanks_WriteScriptStep::
Jump_073_6705:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a
    inc hl
    ld a, [hl]
    cp a, $40
    jr nz, .cp_50
    ld a, $02
    ld [wScriptStep], a
    ret

.cp_50:
    cp a, $50
    jr nz, .set_script_step_to_04
    ld a, $03
    ld [wScriptStep], a
    ret

.set_script_step_to_04:
    ld a, $04
    ld [wScriptStep], a
    ret

; entry 0 of the `rst $00` table in SceneMasterThanks
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, hPlayerY, wMessageIndex, wPartyCount
; writes: hTemp0, hTemp1, wMessageIndex, wMessageGroup, wSavedPlayerState, wScriptStep
; points at: wFollowerRecords, wScriptStep, wMessageIndex
SceneMasterThanks_FindPartyIndexOfSpeciesTemp0::
Jump_073_6729:: ; address name
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
    add a, c
    ld hl, wFollowerRecords
    add_a_to_hl
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    ld a, [hl+]
    ld [wSavedPlayerState], a
    ld a, [hl+]
    ld [wSavedPlayerState + $1], a
    ld a, [hl]
    ld [wSavedPlayerState + $2], a
    ldh a, [hPlayerY]
    cp a, $50
    jr nz, .check_player_y

.done:
    ld hl, wScriptStep
    inc [hl]
    ret

.check_player_y:
    ldh a, [hPlayerY]
    cp a, $30
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
    cp a, $40
    jr z, .read_party_count
    jr c, .loop
    jr .done

.read_party_count:
    ld a, [wPartyCount]
    ld b, a
    ld hl, wFollowerRecords + $1

.loop2:
    push hl
    ld a, [hl+]
    cp a, $40
    jr nz, .restore
    ld a, [hl]
    cp a, $30
    jr nz, .restore
    pop hl
    jr .loop

.restore:
    pop hl
    dec b
    jr nz, .loop2
    jr .done
    db $C9

; implements script command type 35 (SCRIPT_SCENE_KAMEHA_ESCAPE): a cutscene step named after the scene its only script shows: '0 checked the crate.' ... 'Kameha Wahahahah! Thanks for guiding me'; reached through ScriptCommand35 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand35)
; reads: wScriptStep
SceneKamehaEscape::
Func_073_679F:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneKamehaEscape_QueueMusic
    dw SceneKamehaEscape_StepScriptParam0Counter_Bank73
    dw SceneKamehaEscape_WriteStepPtrLo
    dw SceneKamehaEscape_Case03_DecompressToVRAM_Case03
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
    dw SceneKamehaEscape_WriteScriptParam0_Case11
    dw SceneKamehaEscape_StepScriptParam0Counter_Bank73
    dw SceneKamehaEscape_StepScriptParam0Counter_Bank73
    dw SceneKamehaEscape_ScriptStartFadeAndAdvanceStep_Case14
    dw SceneKamehaEscape_SetScriptStartRequestTo80

; entry 21 of the `rst $00` table in SceneKamehaEscape
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
SceneKamehaEscape_SetScriptStartRequestTo80::
Jump_073_67CF:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 20 of the `rst $00` table in SceneKamehaEscape
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags, hPlayerX
; writes: wStoryFlags, hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
SceneKamehaEscape_ScriptStartFadeAndAdvanceStep_Case14::
Jump_073_67D5:: ; address name
    ld a, [wStoryFlags + $62]
    set 1, a
    ld [wStoryFlags + $62], a
    ld a, $40
    ldh [hMapId], a
    xor a, a
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

; entry 17 of the `rst $00` table in SceneKamehaEscape
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0
; points at: wScriptStep, wScreenTileBuffer
SceneKamehaEscape_WriteScriptParam0_Case11::
Jump_073_67FC:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $14
    jr nz, .check_script_param0
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]

.check_script_param0:
    ld a, [wScriptParam0]
    bit 0, a
    jr z, .call_scene_kameha_escape_decompress_to_vram
    ld de, $77D0
    ld b, $56
    call SceneKamehaEscape_DecompressToVRAM
    ld de, $5ADB
    ld b, $56
    jp SceneKamehaEscape_Case03_DecompressToVRAM

.call_scene_kameha_escape_decompress_to_vram:
    ld de, $7827
    ld b, $56
    call SceneKamehaEscape_DecompressToVRAM
    ld de, $5B8F
    ld b, $56
    jr SceneKamehaEscape_Case03_DecompressToVRAM

; entry 13 of the `rst $00` table in SceneKamehaEscape
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: hMapScreenX, hMapScreenY, hMapId, wWarpDestX, wWarpDestY, wFieldTransitionKind
SceneKamehaEscape_WriteMapScreenXAndMapScreenYEtc::
Jump_073_6835:: ; address name
    ld a, $05
    ldh [hMapScreenX], a
    ld a, $04
    ldh [hMapScreenY], a
    jr SceneKamehaEscape_ScriptStartFadeAndAdvanceStep_SetMapIdTo30

; entry 10 of the `rst $00` table in SceneKamehaEscape
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0
; points at: wScriptStep, wScreenTileBuffer
SceneKamehaEscape_WriteScriptParam0::
Jump_073_683F:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $14
    jr nz, .check_script_param0
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]

.check_script_param0:
    ld a, [wScriptParam0]
    bit 0, a
    jr z, .call_scene_kameha_escape_decompress_to_vram
    ld de, $7ABA
    ld b, $56
    call SceneKamehaEscape_DecompressToVRAM
    ld de, $61F0
    ld b, $56
    jr SceneKamehaEscape_Case03_DecompressToVRAM

.call_scene_kameha_escape_decompress_to_vram:
    ld de, $6D99
    ld b, $56
    call SceneKamehaEscape_DecompressToVRAM
    ld de, Map30Screens0_Y0X0
    ld b, $56

; only called from SceneKamehaEscape_Case03 (E-0047)
; 1 call site from 1 routine (e.g. SceneKamehaEscape_Case03_DecompressToVRAM_Case03)
; points at: wScreenTileBuffer
SceneKamehaEscape_Case03_DecompressToVRAM::
Func_073_6875:: ; address name
    ld hl, wScreenTileBuffer
    call DecompressToVRAM
    farcall DrawFullScreenBufferAtScroll
    ret

; only called from routines of SceneKamehaEscape (E-0098)
; 5 call sites from 3 routines (e.g. SceneKamehaEscape_WriteScriptParam0_Case11, SceneKamehaEscape_WriteScriptParam0, SceneKamehaEscape_Case03_DecompressToVRAM_Case03)
; reads: wIsCGB
; writes: rSVBK
; points at: wScreenAttrBuffer
SceneKamehaEscape_DecompressToVRAM::
Func_073_6882:: ; address name
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, $02
    ldh [rSVBK], a
    ld hl, wScreenAttrBuffer
    call DecompressToVRAM
    ld a, $00
    ldh [rSVBK], a
    ret

; entry 6 of the `rst $00` table in SceneKamehaEscape
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: hMapScreenX, hMapScreenY, hMapId, wWarpDestX, wWarpDestY, wFieldTransitionKind
SceneKamehaEscape_ScriptStartFadeAndAdvanceStep::
Jump_073_6896:: ; address name
    ld a, $06
    ldh [hMapScreenX], a
    ld a, $05
    ldh [hMapScreenY], a

SceneKamehaEscape_ScriptStartFadeAndAdvanceStep_SetMapIdTo30::
Jump_073_689E:: ; address name
    ld a, $30
    ldh [hMapId], a
    ldh a, [hPlayerX]
    ld [wWarpDestX], a
    ld a, $E0
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; entry 3 of the `rst $00` table in SceneKamehaEscape
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0
; points at: wScriptStep
SceneKamehaEscape_Case03_DecompressToVRAM_Case03::
Jump_073_68B8:: ; address name
    ld a, [wScriptParam0]
    ld b, a
    ld a, $06
    call DivideBByA
    add a, a
    add a, a
    ld hl, $68F8
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld b, $58
    push hl
    call SceneKamehaEscape_Case03_DecompressToVRAM
    pop hl
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld b, $58
    call SceneKamehaEscape_DecompressToVRAM
    farcall DrawFullScreenBufferAtScroll
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $09
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret
    db $06, $47, $42, $4C, $FB, $47, $CB, $4C, $EE, $48, $3C, $4D, $FB, $47, $CB, $4C
    db $06, $47, $42, $4C, $FF, $45, $B3, $4B

; entry 2 of the `rst $00` table in SceneKamehaEscape
; no direct call (reached through a table, a jump or a vector)
; writes: wStepPtrLo
SceneKamehaEscape_WriteStepPtrLo::
Jump_073_6910:: ; address name
    ld a, $B4
    ld [wStepPtrLo], a
    farcall SceneKamehaEscape_Case02_WriteScrollXAndScrollXHi
    ret

; entry 1 of the `rst $00` table in SceneKamehaEscape
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneKamehaEscape_StepScriptParam0Counter_Bank73::
Jump_073_691C:: ; address name
    ld b, $3C
    call StepScriptParam0Counter_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneKamehaEscape
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlots
; points at: wScriptStep
SceneKamehaEscape_QueueMusic::
Jump_073_6927:: ; address name
    ld a, $02
    call QueueMusic
    ld a, $70
    call QueueSoundEffect

; entry 8 of the `rst $00` table in SceneKamehaEscape
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlots
; points at: wScriptStep
SceneKamehaEscape_RedrawColumnsBesideScreenAndStep::
Jump_073_6931:: ; address name
    ld a, $48
    ld [wSpriteSlots + $B], a
    farcall RedrawColumnsBesideScreen
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 34 (SCRIPT_SET_TILES_FLAG_310): writes tiles $58-$5B into a 2 x 2 block of wScreenTileBuffer ($AA, $AB, $BE, $BF), redraws the screen and sets story flag $310; reached through ScriptCommand34 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand34)
; reads: wStoryFlags
; writes: wScreenTileBuffer, wStoryFlags, wScriptStartRequest
SetTilesFlag310::
Func_073_6941:: ; address name
    ld a, $58
    ld [wScreenTileBuffer + $AA], a
    ld a, $59
    ld [wScreenTileBuffer + $AB], a
    ld a, $5A
    ld [wScreenTileBuffer + $BE], a
    ld a, $5B
    ld [wScreenTileBuffer + $BF], a
    farcall DrawFullScreenBufferAtScroll
    ld a, [wStoryFlags + $62]
    set 0, a
    ld [wStoryFlags + $62], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 33 (SCRIPT_SCENE_CRATE): a cutscene step named after the scene its only script shows: '0 checked the treasure chest.' ... '0 checked the crate.'; reached through ScriptCommand33 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand33)
; reads: wScriptStep
SceneCrate::
Func_073_6969:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneCrate_ScriptStartFadeAndAdvanceStep
    dw SceneCrate_WriteScriptParam0AndSpriteSlotsEtc
    dw SceneCrate_UpdatePlayerMovement
    dw SceneCrate_WriteScriptParam0AndSpriteSlotsEtc_Case03
    dw SceneCrate_WritePlayerYAndFollowerRecords
    dw SceneCrate_WriteFollowerRecords
    dw SceneCrate_WriteFollowerRecords_Case06
    dw SceneCrate_WriteFollowerRecords_Case07
    dw ScriptStepBlinkSpritesThenEnd

; entry 7 of the `rst $00` table in SceneCrate
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerRecords
; writes: wFollowerRecords
; points at: wScriptStep
SceneCrate_WriteFollowerRecords_Case07::
Jump_073_697F:: ; address name
    ld a, [wFollowerRecords + $C]
    inc a
    ld [wFollowerRecords + $C], a
    cp a, $40
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in SceneCrate
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerRecords
; writes: wFollowerRecords
; points at: wScriptStep
SceneCrate_WriteFollowerRecords_Case06::
Jump_073_698E:: ; address name
    ld a, [wFollowerRecords + $7]
    inc a
    ld [wFollowerRecords + $7], a
    cp a, $40
    ret nz
    ld a, $40
    ld [wFollowerRecords + $B], a
    ld a, $30
    ld [wFollowerRecords + $C], a
    xor a, a
    ld [wFollowerRecords + $A], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in SceneCrate
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerRecords
; writes: wFollowerRecords
; points at: wScriptStep
SceneCrate_WriteFollowerRecords::
Jump_073_69AB:: ; address name
    ld a, [wFollowerRecords + $2]
    inc a
    ld [wFollowerRecords + $2], a
    cp a, $40
    ret nz
    ld a, $40
    ld [wFollowerRecords + $6], a
    ld a, $30
    ld [wFollowerRecords + $7], a
    xor a, a
    ld [wFollowerRecords + $5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in SceneCrate
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY
; writes: hPlayerY, wFollowerRecords
; points at: wScriptStep
SceneCrate_WritePlayerYAndFollowerRecords::
Jump_073_69C8:: ; address name
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp a, $40
    ret nz
    ld a, $40
    ld [wFollowerRecords + $1], a
    ld a, $30
    ld [wFollowerRecords + $2], a
    xor a, a
    ld [wFollowerRecords], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in SceneCrate
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wSpriteSlots
; writes: wScriptParam0, wSpriteSlots, hPlayerX, hPlayerY, hPlayerFacing
; points at: wScriptStep
SceneCrate_WriteScriptParam0AndSpriteSlotsEtc_Case03::
Jump_073_69E3:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $01
    ret nz
    ld a, [wSpriteSlots + $C]
    inc a
    ld [wSpriteSlots + $C], a
    cp a, $30
    ret nz
    ld a, $40
    ldh [hPlayerX], a
    ld a, $30
    ldh [hPlayerY], a
    xor a, a
    ldh [hPlayerFacing], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in SceneCrate
; no direct call (reached through a table, a jump or a vector)
; reads: wFieldActionRequest
; writes: wSpriteSlots, wSpriteSlotCount
; points at: wScriptStep
SceneCrate_UpdatePlayerMovement::
Jump_073_6A0B:: ; address name
    farcall UpdatePlayerMovement
    farcall RunFieldActionRequestActionIfBit7
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    xor a, a
    ld [wSpriteSlots + $C], a
    ld a, $01
    ld [wSpriteSlotCount], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneCrate
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wSpriteSlots, hPlayerStateFlags
; writes: wScriptParam0, wSpriteSlots, wFieldActionRequest, wScreenScrollDir, hPlayerStateFlags, hPlayerStepDYLo, hPlayerStepDYHi
; points at: hMapScreenY, hFF80, wScriptStep
SceneCrate_WriteScriptParam0AndSpriteSlotsEtc::
Jump_073_6A2B:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $01
    ret nz
    ld a, [wSpriteSlots + $C]
    inc a
    ld [wSpriteSlots + $C], a
    cp a, $80
    ret nz
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
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneCrate
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
SceneCrate_ScriptStartFadeAndAdvanceStep::
Jump_073_6A71:: ; address name
    ld a, $30
    ldh [hMapId], a
    ld a, $05
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $E0
    ld [wWarpDestX], a
    ld a, $E0
    ld [wWarpDestY], a
    ld a, $03
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; implements script command type 30 (SCRIPT_SCENE_SAILOR_RING): a cutscene step named after the scene its only script shows: after '0 received the Sailor Ring.'; reached through ScriptCommand30 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand30)
; reads: wScriptStep
SceneSailorRing::
Func_073_6A91:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneSailorRing_ScriptStartFadeAndAdvanceStep
    dw SceneSailorRing_SetScriptStartRequestTo80

; entry 0 of the `rst $00` table in SceneSailorRing
; no direct call (reached through a table, a jump or a vector)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
SceneSailorRing_ScriptStartFadeAndAdvanceStep::
Jump_073_6A99:: ; address name
    ld a, $36
    ldh [hMapId], a
    xor a, a
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

; entry 1 of the `rst $00` table in SceneSailorRing
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
SceneSailorRing_SetScriptStartRequestTo80::
Jump_073_6AB8:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 2F (SCRIPT_SCENE_TENTACLES): a cutscene step named after the scene its only script shows: 'Close your eyes for a little...' ... 'Thick, suction-cupped tentacles snaked out'; reached through ScriptCommand2F in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand2F)
; reads: wScriptStep
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind, wScriptStartRequest
SceneTentacles::
Func_073_6ABE:: ; address name
    ld a, [wScriptStep]
    or a, a
    jr nz, .set_script_start_request_to_80
    ld a, [wScriptStep]
    or a, a
    jr nz, .set_script_start_request_to_80
    ld a, $3C
    ldh [hMapId], a
    xor a, a
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

; implements script command type 2E (SCRIPT_WARP_MAP41): warps to map $41 (WarpToMap41); used after 'Close your eyes a little while.'; reached through ScriptCommand2E in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand2E)
; reads: wScriptStep
; writes: wScriptStartRequest
WarpMap41::
Func_073_6AEF:: ; address name
    ld a, [wScriptStep]
    or a, a
    jr nz, .set_script_start_request_to_80
    call WarpToMap41
    ret

.set_script_start_request_to_80:
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 2D (SCRIPT_SCENE_MERMAID_SONG_2): a cutscene step named after the scene its only script shows: the same scene as SCRIPT_SCENE_MERMAID_SONG (two objects moved by table); reached through ScriptCommand2D in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand2D)
; reads: wScriptStep
SceneMermaidSong2::
Func_073_6AFF:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneMermaidSong2_StepPlayerDownTowardWC928
    dw SceneMermaidSong2_ToScriptStepMoveFollowersToLeader
    dw SceneMermaidSong2_ToScriptStepMoveFollowersToLeader
    dw SceneMermaidSong2_ToScriptStepMoveFollowersToLeader
    dw SceneMermaidSong2_SetBit2AtHL_B73
    dw SceneMermaidSong2_Case05
    dw Talk0886_NsDancingLuredA
    dw SceneMermaidSong2_ShowBravoBravoYouWere
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw WarpToMap41
    dw SceneMermaidSong2_SetScriptStartRequestTo80

; entry 10 of the `rst $00` table in SceneMermaidSong2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
SceneMermaidSong2_SetScriptStartRequestTo80::
Jump_073_6B19:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; hMapId = $41, hMapScreenX/Y = 0/1, wC8C8/wC8C9 = $70/$30, wC8C6 = 1, then ScriptStartFadeAndAdvanceStep and sets story flag $6F (E-0118)
; 1 call site from 1 routine (e.g. WarpMap41)
; writes: hMapId, hMapScreenX, hMapScreenY, wWarpDestX, wWarpDestY, wFieldTransitionKind
WarpToMap41::
Func_073_6B1F:: ; address name
    ld a, $41
    ldh [hMapId], a
    xor a, a
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
    ld de, $006F
    call SetFlagBit
    ret

; entry 7 of the `rst $00` table in SceneMermaidSong2
; no direct call (reached through a table, a jump or a vector)
; writes: wObject1
; points at: wScriptStep
SceneMermaidSong2_ShowBravoBravoYouWere::
Jump_073_6B46:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank73
    ret nc
    ld a, $01
    ld [wObject1 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ld hl, $0849 ; 'Bravo, bravo! You were fabulous! You'
    call StartMessageHL_B73b
    ret

; implements script command type 2C (SCRIPT_SCENE_DANCING): a cutscene step named after the scene its only script shows: 'Then I'll sing! Lalala lala la' ... 'Erm The sense of rhythm just...'; reached through ScriptCommand2C in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand2C)
; reads: wScriptStep
SceneDancing::
Func_073_6B5B:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneMermaidSong2_StepPlayerDownTowardWC928
    dw SceneMermaidSong2_ToScriptStepMoveFollowersToLeader
    dw SceneMermaidSong2_ToScriptStepMoveFollowersToLeader
    dw SceneMermaidSong2_ToScriptStepMoveFollowersToLeader
    dw SceneMermaidSong2_SetBit2AtHL_B73
    dw SceneDancing_SetBit2AtHL_B73AndStep
    dw SceneDancing_Case06
    dw SceneDancing_Talk0886_NsDancingLuredA
    dw SceneDancing_SetScriptStartRequestTo80

; entry 8 of the `rst $00` table in SceneDancing
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
SceneDancing_SetScriptStartRequestTo80::
Jump_073_6B71:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 7 of the `rst $00` table in SceneDancing
; no direct call (reached through a table, a jump or a vector)
; writes: wObject1
SceneDancing_Talk0886_NsDancingLuredA::
Jump_073_6B77:: ; address name
    call Talk0886_NsDancingLuredA
    ld a, $E0
    ld [wObject1 + $B], a
    ret

; entry 6 of the `rst $00` table in SceneDancing
; no direct call (reached through a table, a jump or a vector)
SceneDancing_Case06::
Jump_073_6B80:: ; address name
    farcall SceneDancing_Case06_Sub01
    ret

; entry 5 of the `rst $00` table in SceneDancing
; no direct call (reached through a table, a jump or a vector)
; points at: hPlayerStateFlags, wScriptStep
SceneDancing_SetBit2AtHL_B73AndStep::
Jump_073_6B87:: ; address name
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B73
    ld hl, hPlayerStateFlags
    call SetBit1AtHL_Bank73
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 2B (SCRIPT_SCENE_MERMAID_SONG): a cutscene step named after the scene its only script shows: 'Then I'll sing! Lalala lala la' ... 'In the past, mermaids are said...'; reached through ScriptCommand2B in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand2B)
; reads: wScriptStep
SceneMermaidSong::
Func_073_6B98:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneMermaidSong2_StepPlayerDownTowardWC928
    dw SceneMermaidSong2_ToScriptStepMoveFollowersToLeader
    dw SceneMermaidSong2_ToScriptStepMoveFollowersToLeader
    dw SceneMermaidSong2_ToScriptStepMoveFollowersToLeader
    dw SceneMermaidSong2_SetBit2AtHL_B73
    dw SceneMermaidSong2_Case05
    dw Talk0886_NsDancingLuredA
    dw SceneMermaidSong_ShowBravoBravoYouWere
    dw SceneMermaidSong_RunMessageBoxFar_Bank73
    dw SceneMermaidSong_RunMessageBoxFar_Bank73_Case09
    dw ScriptCommand60_Run_ScriptApplyStepDeltaAtDE_Bank73
    dw SceneMermaidSong_ShowHeroReceivedATinyMedal
    dw SceneMermaidSong_RunMessageBoxFar_Bank73

; entry 8 of the `rst $00` table in SceneMermaidSong
; no direct call (reached through a table, a jump or a vector)
; writes: wObject1, wScriptStartRequest
SceneMermaidSong_RunMessageBoxFar_Bank73::
Jump_073_6BB6:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank73
    ret nc
    ld a, $E0
    ld [wObject1 + $B], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 11 of the `rst $00` table in SceneMermaidSong
; no direct call (reached through a table, a jump or a vector)
; reads: wObject5, wScriptParam0
; writes: wObject5, wStepPtrLo, wStepPtrHi, wScriptParam0, hFieldDrawFlags
; points at: wScriptStep
SceneMermaidSong_ShowHeroReceivedATinyMedal::
Jump_073_6BC6:: ; address name
    ld a, [wObject5 + $4]
    inc a
    inc a
    ld [wObject5 + $4], a
    ld de, wObject5 + $5
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
    xor a, a
    ld [wObject5], a
    ld a, $2C
    ld [wStepPtrLo], a
    farcall AppendItemWC928ToInventory
    ld de, $006E
    call SetFlagBit
    ld hl, $0813 ; '0 received a TinyMedal.'
    call StartMessageHL_B73b
    xor a, a
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand60_Run
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
ScriptCommand60_Run_ScriptApplyStepDeltaAtDE_Bank73::
Jump_073_6C0C:: ; address name
    ld hl, wObject5 + $5
    dec [hl]
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    ld a, $65
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in SceneMermaidSong
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wObject5, hFieldDrawFlags
; points at: wScriptStep
SceneMermaidSong_RunMessageBoxFar_Bank73_Case09::
Jump_073_6C21:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank73
    ret nc
    ld a, $10
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld a, $80
    ld [wObject5], a
    ld a, $0E
    ldh [hFieldDrawFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in SceneMermaidSong
; no direct call (reached through a table, a jump or a vector)
; reads: wInventory
; writes: wObject1
; points at: wScriptStep
SceneMermaidSong_ShowBravoBravoYouWere::
Jump_073_6C3E:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank73
    ret nc
    ld a, $01
    ld [wObject1 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ld de, $006E
    call TestFlagBit
    jr nc, .check_inventory
    ld hl, $0815 ; 'Bravo, bravo! You were fabulous! You'
    call StartMessageHL_B73b
    ret

.check_inventory:
    ld a, [wInventory + $17]
    cp a, $FF
    jr z, .call_start_message_hl_b73b
    or a, a
    jr z, .call_start_message_hl_b73b
    ld hl, $0814 ; 'Bravo, bravo! You were fabulous! You'
    call StartMessageHL_B73b
    ret

.call_start_message_hl_b73b:
    ld hl, $0812 ; 'Bravo, bravo! You were fabulous! You'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; starts 1 constant message(s); the first in the code is $0886, whose string begins 'N's dancing lured a mermaid to' (the leading N is a name substitution); the surrounding logic is not interpreted (E-0097)
; 1 call site from 1 routine (e.g. SceneDancing_Talk0886_NsDancingLuredA)
; reads: hPlayerX
; writes: wFollowerRecords, hPlayerFacing, hPlayerX, wScriptParam0, wObject1
; points at: hPlayerStateFlags, wScriptStep
Talk0886_NsDancingLuredA::
Func_073_6C77:: ; address name
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B73
    ld a, $03
    ld [wFollowerRecords], a
    xor a, a
    ld [wFollowerRecords + $5], a
    ld a, $02
    ld [wFollowerRecords + $A], a
    ld a, $01
    ldh [hPlayerFacing], a
    ld hl, wFollowerRecords + $1
    dec [hl]
    ld hl, wFollowerRecords + $7
    inc [hl]
    ld hl, wFollowerRecords + $C
    dec [hl]
    ldh a, [hPlayerX]
    inc a
    ldh [hPlayerX], a
    cp a, $70
    ret nz
    ld a, $03
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank73
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ld a, $30
    ld [wObject1 + $B], a
    ld hl, $0886 ; 'N's dancing lured a mermaid to'
    call StartMessageHL_B73b
    ret

; entry 5 of the `rst $00` table in SceneMermaidSong2
; no direct call (reached through a table, a jump or a vector)
SceneMermaidSong2_Case05::
Jump_073_6CCA:: ; address name
    farcall SceneMermaidSong2_Case05_Sub01
    ret

; entry 4 of the `rst $00` table in SceneMermaidSong2
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX
; writes: wFollowerRecords, hPlayerFacing, hPlayerX, wScriptParam0, wScriptSubStep
; points at: hPlayerStateFlags, wScriptStep
SceneMermaidSong2_SetBit2AtHL_B73::
Jump_073_6CD1:: ; address name
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B73
    ld a, $01
    ld [wFollowerRecords], a
    ld a, $02
    ld [wFollowerRecords + $5], a
    xor a, a
    ld [wFollowerRecords + $A], a
    ld a, $03
    ldh [hPlayerFacing], a
    ld hl, wFollowerRecords + $1
    inc [hl]
    ld hl, wFollowerRecords + $7
    dec [hl]
    ld hl, wFollowerRecords + $C
    inc [hl]
    ldh a, [hPlayerX]
    dec a
    ldh [hPlayerX], a
    cp a, $60
    ret nz
    xor a, a
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank73
    ld hl, wScriptStep
    inc [hl]
    xor a, a
    ld [wScriptParam0], a
    ld [wScriptSubStep], a
    ret

; entry 1 of the `rst $00` table in SceneMermaidSong2
; no direct call (reached through a table, a jump or a vector)
SceneMermaidSong2_ToScriptStepMoveFollowersToLeader::
Jump_073_6D1B:: ; address name
    farcall ScriptStepMoveFollowersToLeader
    ret

; entry 0 of the `rst $00` table in SceneMermaidSong2
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerY, hPlayerX, wStepArrived
; writes: wStepPtrLo, hPlayerFacing
; points at: wScriptStep
SceneMermaidSong2_StepPlayerDownTowardWC928::
Jump_073_6D22:: ; address name
    ldh a, [hPlayerY]
    cp a, $40
    jr z, .check_player_x
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerDownTowardWC928
    ret

.check_player_x:
    ldh a, [hPlayerX]
    cp a, $70
    jr z, .done
    ld a, $70
    ld [wStepPtrLo], a
    farcall StepPlayerRightTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ldh [hPlayerFacing], a

.done:
    ld hl, wScriptStep
    inc [hl]
    ret

; ld a, [wScriptStep] / rst $00 with a six-entry table, the shape of a ScriptCommandXX_Run implementation; no script command stub or other code reaches it (E-0214)
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStep
UnreferencedScriptStepDispatch_73_6D52:: ; configured code entry (E-0214); C0
Func_073_6D52:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw UnreferencedScriptStepDispatch_73_6D52_Msg4D0F_HmYouAreQuite
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw UnreferencedScriptStepDispatch_73_6D52_ShowOhButICan
    dw SceneWizstone_RunMessageBoxFar_Bank73
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw UnreferencedScriptStepDispatch_73_6D52_ClearArg5IfAtOrAboveLimitForFarmLevel

; entry 5 of the `rst $00` table in UnreferencedScriptStepDispatch_73_6D52
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wPartyCount, wSpriteSlots
; writes: hTemp1, hTemp2, hTemp3, wOBJPaletteUploadRequest, wScriptStartRequest
; points at: wPartyCount, wFollowerRecords, wPartyList, wSpriteSlotCount
UnreferencedScriptStepDispatch_73_6D52_ClearArg5IfAtOrAboveLimitForFarmLevel::
Jump_073_6D62:: ; address name
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
    add a, a
    add a, a
    add a, c
    ld hl, wFollowerRecords
    add_a_to_hl
    ld a, [wSpriteSlots + $7]
    ld [hl+], a
    ld a, [wSpriteSlots + $B]
    ld [hl+], a
    ld a, [wSpriteSlots + $C]
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
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld hl, wSpriteSlotCount
    dec [hl]
    ld de, $0078
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in UnreferencedScriptStepDispatch_73_6D52
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult, wArg5, wPartyCount
; points at: wScriptStep
UnreferencedScriptStepDispatch_73_6D52_ShowOhButICan::
Jump_073_6DD5:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wTextYesNoResult]
    or a, a
    jr z, .call_clear_arg5_if_at_or_above_limit_for_farm
    ld hl, vTiles1 + $512
    call StartMessageHL_B73b
    ret

.call_clear_arg5_if_at_or_above_limit_for_farm:
    farcall ClearArg5IfAtOrAboveLimitForFarmLevel
    ld a, [wArg5]
    cp a, $FF
    jr z, .call_start_message_hl_b73b
    ld a, [wPartyCount]
    cp a, $03
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

; entry 0 of the `rst $00` table in UnreferencedScriptStepDispatch_73_6D52
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
UnreferencedScriptStepDispatch_73_6D52_Msg4D0F_HmYouAreQuite::
Jump_073_6E0C:: ; address name
    ld hl, $4D0F ; 'Hm, you are quite strong I'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 26 (SCRIPT_SCENE_MONSTERS_IN_TOW): a cutscene step named after the scene its only script shows: 'That will help you for certain.' ... 'Heh, you have monsters in tow?'; reached through ScriptCommand26 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand26)
; reads: wScriptStep
SceneMonstersInTow::
Func_073_6E17:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneMonstersInTow_CopyBytes
    dw GoldItemOrLoss_Case0B_ToScriptStepFlashScreenNegative
    dw SceneMonstersInTow_ScriptStartFadeAndAdvanceStep
    dw SceneMonstersInTow_SetScriptStartRequestTo80

; entry 3 of the `rst $00` table in SceneMonstersInTow
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
SceneMonstersInTow_SetScriptStartRequestTo80::
Jump_073_6E23:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in SceneMonstersInTow
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, hPlayerY, hPlayerFacing
; writes: wWarpDestX, wWarpDestY, wFieldTransitionKind
SceneMonstersInTow_ScriptStartFadeAndAdvanceStep::
Jump_073_6E29:: ; address name
    ldh a, [hPlayerX]
    ld [wWarpDestX], a
    ldh a, [hPlayerY]
    ld [wWarpDestY], a
    ldh a, [hPlayerFacing]
    inc a
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; entry 0 of the `rst $00` table in SceneMonstersInTow
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: hSpriteWindowClipMode
; points at: wBGPaletteBuffer, wBGPaletteCopy, wScriptStep
SceneMonstersInTow_CopyBytes::
Jump_073_6E40:: ; address name
    xor a, a
    ldh [hSpriteWindowClipMode], a
    ld a, [wIsCGB]
    or a, a
    jr z, .call_queue_sound_effect
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes

.call_queue_sound_effect:
    ld a, $7A
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 1E (SCRIPT_CHECK_ITEM): sets wGameFlags836 from whether item hTemp0 is in the inventory (FindTemp0InInventoryList); reached through ScriptCommand1E in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand1E)
; reads: hTemp0, wGameFlags836
; writes: hTemp0, wGameFlags836, wScriptStartRequest
; points at: wInventory
CheckItem::
Func_073_6E5F:: ; address name
    ld a, $19
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, .read_temp0
    ld a, $1A
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, .read_temp0
    ld a, $1B
    ldh [hTemp0], a
    farcall FindTemp0InInventoryList
    ldh a, [hTemp0]
    bit 7, a
    jr z, .read_temp0
    ld a, $1C
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
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 25 (SCRIPT_SCENE_WATER_SOLVED): a cutscene step named after the scene its only script shows: 'You will? So we can go...' ... 'King This should solve the water...'; reached through ScriptCommand25 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand25)
; reads: wScriptStep
SceneWaterSolved::
Func_073_6EBA:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneWaterSolved_ScriptStartFadeAndAdvanceStep
    dw SceneWaterSolved_SetScriptStartRequestTo80

; entry 1 of the `rst $00` table in SceneWaterSolved
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
SceneWaterSolved_SetScriptStartRequestTo80::
Jump_073_6EC2:: ; address name
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 0 of the `rst $00` table in SceneWaterSolved
; no direct call (reached through a table, a jump or a vector)
; reads: wStoryFlags, hPlayerX, hPlayerY, hPlayerFacing
; writes: wStoryFlags, wWarpDestX, wWarpDestY, wFieldTransitionKind
SceneWaterSolved_ScriptStartFadeAndAdvanceStep::
Jump_073_6EC8:: ; address name
    ld a, [wStoryFlags + $61]
    or a, $02
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

; implements script command type 21 (SCRIPT_SCENE_KING_AUDIENCE): a cutscene step named after the scene its only script shows: 'King You wish to see our...' ... 'King I see. This is what...'; reached through ScriptCommand21 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand21)
; reads: wScriptStep
SceneKingAudience::
Func_073_6EE7:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneKingAudience_StepScriptParam0Counter_Bank73
    dw SceneKingAudience_StepScriptParam0Counter_Bank73_Case01

; entry 0 of the `rst $00` table in SceneKingAudience
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
; points at: wScriptStep
SceneKingAudience_StepScriptParam0Counter_Bank73::
Jump_073_6EEF:: ; address name
    ld b, $5A
    call StepScriptParam0Counter_Bank73
    ret nc
    ld a, $05
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneKingAudience
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5, wScriptStartRequest
SceneKingAudience_StepScriptParam0Counter_Bank73_Case01::
Jump_073_6F04:: ; address name
    ld b, $28
    call StepScriptParam0Counter_Bank73
    ret nc
    xor a, a
    ld [wObject5], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 1A (SCRIPT_SCENE_OASIS_KEY): a cutscene step named after the scene its only script shows: 'This here is a Magic...' ... '0 received the Oasis Key.'; reached through ScriptCommand1A in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand1A)
; reads: hPlayerX, hPlayerY, wObject5
; writes: wObject5, wScriptStartRequest
SceneOasisKey::
Func_073_6F14:: ; address name
    ldh a, [hPlayerX]
    cp a, $50
    jr nz, .cp_30
    ld hl, wObject5 + $4
    inc [hl]
    ld hl, wObject5 + $5
    inc [hl]
    jr .call_script_apply_step_delta_at_de_bank73

.cp_30:
    cp a, $30
    jr nz, .check_player_y
    ld hl, wObject5 + $4
    dec [hl]
    ld hl, wObject5 + $5
    inc [hl]
    jr .call_script_apply_step_delta_at_de_bank73

.check_player_y:
    ldh a, [hPlayerY]
    cp a, $20
    jr z, .call_script_apply_step_delta_at_de_bank73
    ld a, [wObject5 + $5]
    inc a
    inc a
    ld [wObject5 + $5], a

.call_script_apply_step_delta_at_de_bank73:
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    xor a, a
    ld [wObject5], a
    ld a, $40
    ld [wObject5 + $4], a
    ld a, $30
    ld [wObject5 + $5], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 19 (SCRIPT_SCENE_WARUBOU_MAGIC_KEY): a cutscene step named after the scene its only script shows: 'Warubou Wa-hey! Good, good, good!' ... 'This here is a Magic...'; reached through ScriptCommand19 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand19)
; reads: wScriptStep
; writes: wObject5, wScriptStartRequest
; points at: wScriptStep
SceneWarubouMagicKey::
Func_073_6F5B:: ; address name
    ld a, [wScriptStep]
    or a, a
    jr nz, .skip
    ld a, $80
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

.skip:
    ld hl, wObject5 + $5
    dec [hl]
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 20; reached through ScriptCommand20 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand20)
; reads: wScriptStep
ScriptCommand20_Run::
Func_073_6F7C:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw ScriptCommand20_Run_WriteScriptParam0
    dw ScriptCommand20_Run_WriteScriptParam0AndFollowerRecords
    dw ScriptCommand20_Run_WriteFollowerRecords
    dw ScriptCommand20_Run_SetFlagBit

; entry 3 of the `rst $00` table in ScriptCommand20_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerFacing
; writes: wScriptParam0, wSpriteSlots, wScriptStartRequest
ScriptCommand20_Run_SetFlagBit::
Jump_073_6F88:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $3C
    ret nz
    ld a, $72
    call QueueSoundEffect
    ldh a, [hPlayerFacing]
    inc a
    inc a
    and a, $03
    ld [wSpriteSlots + $7], a
    ld a, $40
    ld [wSpriteSlots + $B], a
    ld de, $0019
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommand20_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerRecords
; writes: wFollowerRecords
; points at: wScriptStep
ScriptCommand20_Run_WriteFollowerRecords::
Jump_073_6FB1:: ; address name
    ld a, $01
    ld [wFollowerRecords + $5], a
    ld a, [wFollowerRecords + $6]
    inc a
    ld [wFollowerRecords + $6], a
    cp a, $B0
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in ScriptCommand20_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wFollowerRecords
; writes: wScriptParam0, wFollowerRecords
; points at: wScriptStep
ScriptCommand20_Run_WriteScriptParam0AndFollowerRecords::
Jump_073_6FC5:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, .check_follower_records
    ld a, [wFollowerRecords + $6]
    cp a, $50
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
    cp a, $40
    jr nz, .skip
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

.skip:
    jr nc, .set_follower_records_to_02
    xor a, a
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

; entry 0 of the `rst $00` table in ScriptCommand20_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerRecords
; writes: wScriptParam0
; points at: wScriptStep
ScriptCommand20_Run_WriteScriptParam0::
Jump_073_7007:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ld a, [wFollowerRecords + $6]
    cp a, $40
    jr nz, .set_script_param0_to_01
    ld a, [wFollowerRecords + $7]
    cp a, $20
    jr nz, .set_script_param0_to_01
    xor a, a
    ld [wScriptParam0], a
    ret

.set_script_param0_to_01:
    ld a, $01
    ld [wScriptParam0], a
    ret

; implements script command type 16 (SCRIPT_SCENE_WARUBOU_FOOD_2): a cutscene step named after the scene its only script shows: the same scene as SCRIPT_SCENE_WARUBOU_FOOD; reached through ScriptCommand16 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand16)
; reads: wScriptStep
SceneWarubouFood2::
Func_073_7024:: ; address name
    ld a, [wScriptStep]
    rst $00
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
    dw SceneWarubouFood2_ShiftObjectsYByTable7526
    dw SceneWarubouFood2_ShowCobiThatsOursGive
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw SceneWarubouFood2_ShiftObjectsYByTable7526_Case0E
    dw SceneWarubouFood2_AddStepDeltaToPointedByte
    dw SceneWarubouFood2_ScriptApplyStepDeltaAtDE_Bank73
    dw SceneWarubouFood2_CycleSpriteFloatYDown
    dw SceneWarubouFood2_RunMessageBoxFar_Bank73
    dw SceneWarubouFood2_CycleSpriteFloatYDown_Case13
    dw SceneWarubouFood2_RunMessageBoxFar_Bank73
    dw SceneWarubouFood2_CycleSpriteFloatYDown_Case15
    dw SceneWarubouFood2_ShowWarubouWaheyItsThe
    dw SceneWarubouFood2_RunMessageBox
    dw SceneWarubouFood2_ShowWarubouWaroohWillIt
    dw SceneChestBattle_RunMessageBoxFar_Bank73
    dw SceneWarubouFood2_StepPlayerLeftTowardWC928
    dw SceneWarubouFood2_ScriptApplyStepDeltaAtDE_Bank73_Case1B
    dw SceneWarubouFood2_WriteScriptParam0AndStepPtrLoEtc

; entry 28 of the `rst $00` table in SceneWarubouFood2
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wStepArrived
; writes: wScriptParam0, wStepPtrLo, hPlayerFacing, wFollowerRecords, wScriptStartRequest
SceneWarubouFood2_WriteScriptParam0AndStepPtrLoEtc::
Jump_073_7062:: ; address name
    ld a, [wScriptParam0]
    inc a
    cp a, $1E
    jr z, .set_script_param0
    ld [wScriptParam0], a
    ret

.set_script_param0:
    dec a
    ld [wScriptParam0], a
    ld a, $40
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $02
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld de, $000C
    call SetFlagBit
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 27 of the `rst $00` table in SceneWarubouFood2
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
; points at: wScriptStep
SceneWarubouFood2_ScriptApplyStepDeltaAtDE_Bank73_Case1B::
Jump_073_7095:: ; address name
    ld hl, wObject5 + $5
    inc [hl]
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    xor a, a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 26 of the `rst $00` table in SceneWarubouFood2
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrLo, hPlayerFacing
; points at: wScriptStep
SceneWarubouFood2_StepPlayerLeftTowardWC928::
Jump_073_70A9:: ; address name
    ld a, $68
    ld [wStepPtrLo], a
    farcall StepPlayerLeftTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $02
    ldh [hPlayerFacing], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 24 of the `rst $00` table in SceneWarubouFood2
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneWarubouFood2_ShowWarubouWaroohWillIt::
Jump_073_70C2:: ; address name
    ld b, $B4
    call StepScriptParam0Counter_Bank73
    ret nc
    ld hl, $005C ; 'Warubou Warooh! Will it hold? You'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 23 of the `rst $00` table in SceneWarubouFood2
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageState, wScriptParam0, wSpriteSlots
; writes: wStepPtrLo, wStepPtrHi, wSpriteSlots, wScriptParam0, hTemp0
; points at: wScriptStep
SceneWarubouFood2_RunMessageBox::
Jump_073_70D3:: ; address name
    ld a, [wMessageState]
    cp a, $FF
    jr z, .check_script_param0
    xor a, a
    ld [wStepPtrLo], a
    farcall RunMessageBox
    ret

.check_script_param0:
    ld a, [wScriptParam0]
    or a, a
    jr nz, .set_step_ptr_lo
    ld a, $65
    call QueueSoundEffect

.set_step_ptr_lo:
    ld de, wSpriteSlots + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and a, $01
    jr nz, .check_sprite_slots
    ld a, [wSpriteSlots + $7]
    inc a
    and a, $03
    ld [wSpriteSlots + $7], a

.check_sprite_slots:
    ld a, [wSpriteSlots + $B]
    cp a, $40
    jr z, .check_script_param02
    dec a
    dec a
    ld [wSpriteSlots + $B], a

.check_script_param02:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    jr z, .call_queue_sound_effect
    farcall CycleSpriteFloatYDown
    xor a, a
    ldh [hTemp0], a
    farcall DrawAnimatedMetaSprite1B
    ret

.call_queue_sound_effect:
    ld a, $72
    call QueueSoundEffect
    ld de, FieldSpriteGfx49
    ld b, $7D
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $49
    ld [wSpriteSlots + $2], a
    xor a, a
    ld [wSpriteSlots + $7], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 22 of the `rst $00` table in SceneWarubouFood2
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
; points at: wScriptStep
SceneWarubouFood2_ShowWarubouWaheyItsThe::
Jump_073_715A:: ; address name
    farcall CycleSpriteFloatYDown
    xor a, a
    ldh [hTemp0], a
    farcall DrawAnimatedMetaSprite1B
    ld de, wSpriteSlots + $7
    call RotateDirectionAtDEEvery32_Bank73
    ld b, $78
    call StepScriptParam0Counter_Bank73
    ret nc
    ld hl, $005B ; 'Warubou Wa-hey! It's the only way!'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 21 of the `rst $00` table in SceneWarubouFood2
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: hTemp0, wStepPtrHi, wStepTarget, wStepPtrLo, wScriptParam0
; points at: wScriptParam0, wScriptStep
SceneWarubouFood2_CycleSpriteFloatYDown_Case15::
Jump_073_7180:: ; address name
    farcall CycleSpriteFloatYDown
    xor a, a
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
    ld a, $B0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 19 of the `rst $00` table in SceneWarubouFood2
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0
SceneWarubouFood2_CycleSpriteFloatYDown_Case13::
Jump_073_71BC:: ; address name
    farcall CycleSpriteFloatYDown
    xor a, a
    ldh [hTemp0], a
    farcall DrawAnimatedMetaSprite1B
    ld de, wSpriteSlots + $7
    call RotateDirectionAtDEEvery32_Bank73
    ld de, wObject1 + $C
    ld hl, $005A
    call ScriptStepAdjust32TimesThenMessage_Bank73
    ret

; entry 18 of the `rst $00` table in SceneWarubouFood2
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0
; points at: wScriptParam0, wScriptStep
SceneWarubouFood2_RunMessageBoxFar_Bank73::
Jump_073_71DB:: ; address name
    ld a, $01
    call RunMessageBoxFar_Bank73
    push af
    ld de, wSpriteSlots + $7
    call RotateDirectionAtDEEvery32_Bank73
    ld hl, wScriptParam0
    inc [hl]
    pop af
    ret nc
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 17 of the `rst $00` table in SceneWarubouFood2
; no direct call (reached through a table, a jump or a vector)
; writes: wFollowerRecords, hTemp0, wObject5
SceneWarubouFood2_CycleSpriteFloatYDown::
Jump_073_71F6:: ; address name
    ld a, $02
    ld [wFollowerRecords], a
    ld a, $70
    ld [wFollowerRecords + $1], a
    ld a, $40
    ld [wFollowerRecords + $2], a
    farcall CycleSpriteFloatYDown
    xor a, a
    ldh [hTemp0], a
    farcall DrawAnimatedMetaSprite1B
    ld a, $80
    ld [wObject5], a
    ld de, wSpriteSlots + $C
    ld hl, $0059
    call ScriptStepAdjust32TimesThenMessage_Bank73
    ret

; entry 16 of the `rst $00` table in SceneWarubouFood2
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, hPlayerY
; writes: wObject2, wWarpDestX, wWarpDestY, wFieldTransitionKind
SceneWarubouFood2_ScriptApplyStepDeltaAtDE_Bank73::
Jump_073_7223:: ; address name
    ld a, $02
    ld [wObject2 + $7], a
    ld hl, wObject2 + $C
    inc [hl]
    ld de, wObject2 + $C
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    ld de, $000B
    call SetFlagBit
    ldh a, [hPlayerX]
    ld [wWarpDestX], a
    ldh a, [hPlayerY]
    ld [wWarpDestY], a
    ld a, $04
    ld [wFieldTransitionKind], a
    farcall ScriptStartFadeAndAdvanceStep
    ret

; entry 15 of the `rst $00` table in SceneWarubouFood2
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0, hTemp0
; points at: wScriptStep
SceneWarubouFood2_AddStepDeltaToPointedByte::
Jump_073_724F:: ; address name
    ld hl, wObject2 + $B
    dec [hl]
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
    ld de, wObject5 + $5
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and a, $01
    jr z, .check_script_param0

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    xor a, a
    ldh [hTemp0], a
    farcall LoadSpriteGraphics7E5595ToTiles0
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 14 of the `rst $00` table in SceneWarubouFood2
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerRecords
; writes: wFollowerRecords, wObject1, wObject2, wObject5, wScriptParam0
; points at: wScriptStep
SceneWarubouFood2_ShiftObjectsYByTable7526_Case0E::
Jump_073_72A9:: ; address name
    ld a, [wFollowerRecords + $2]
    dec a
    dec a
    ld [wFollowerRecords + $2], a
    cp a, $38
    jr z, .set_object1_to_80
    call ShiftObjectsYByTable7526
    ret

.set_object1_to_80:
    ld a, $80
    ld [wObject1 + $B], a
    ld a, $60
    ld [wObject2 + $B], a
    ld a, $70
    ld [wObject5 + $4], a
    ld a, $63
    call QueueSoundEffect
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in SceneWarubouFood2
; no direct call (reached through a table, a jump or a vector)
; reads: wFrameCounterLo, wFollowerRecords
; writes: wFollowerRecords
; points at: wScriptStep
SceneWarubouFood2_ShowCobiThatsOursGive::
Jump_073_72D6:: ; address name
    ld a, [wFrameCounterLo]
    and a, $03
    ret nz
    ld a, [wFollowerRecords + $2]
    inc a
    ld [wFollowerRecords + $2], a
    cp a, $48
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ld de, $0001
    call TestFlagBit
    jr c, .call_start_message_hl_b73b
    ld hl, $0058 ; 'Cobi That's ours! Give it back!'
    call StartMessageHL_B73b
    ret

.call_start_message_hl_b73b:
    ld hl, $005E ; 'Tara That's ours! Give it back!'
    call StartMessageHL_B73b
    ret

; entry 11 of the `rst $00` table in SceneWarubouFood2
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerRecords
; writes: wFollowerRecords
; points at: wScriptStep
SceneWarubouFood2_ShiftObjectsYByTable7526::
Jump_073_7300:: ; address name
    call ShiftObjectsYByTable7526
    ld a, [wFollowerRecords + $1]
    dec a
    ld [wFollowerRecords + $1], a
    cp a, $70
    ret nz
    ld a, $02
    ld [wFollowerRecords], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in SceneWarubouFood2
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneWarubouFood2_ShowWarubouWaheySomePrince::
Jump_073_7317:: ; address name
    ld de, wObject1 + $C
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    ld hl, $0055 ; 'Warubou Wa-hey! Some prince! Dirty mouth!'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in SceneWarubouFood2
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneWarubouFood2_ShowKamehaGimmeItYou::
Jump_073_7329:: ; address name
    ld de, wObject2 + $C
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    ld hl, $0054 ; 'Kameha Gimme it! You just ate!'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneWarubouFood2
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneWarubouFood2_ShowWarubouWaheyImStarving::
Jump_073_733B:: ; address name
    ld de, wObject1 + $C
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    ld hl, $0053 ; 'Warubou Wa-hey! I'm starving!'
    call StartMessageHL_B73b
    ld hl, wScriptStep
    inc [hl]
    ret

; sets bit 2 of the objects at wCB9C and wCBAC, wCBCF = $80, runs Func_073_736B and advances wScriptStep once wScriptParam0 is 0 (E-0122)
; 1 call site from 1 routine (e.g. SceneHomecoming_ToScriptStepSetObjectBit2AndWait)
; reads: wScriptParam0
; writes: wObject5
; points at: wScriptStep
ScriptStepSetObjectBit2AndWait::
Func_073_734D:: ; address name
    ld hl, wObject1 + $D
    call SetBit2AtHL_B73
    ld hl, wObject2 + $D
    call SetBit2AtHL_B73
    ld a, $80
    ld [wObject5], a
    call ShiftObjectsYByTable7526
    ld a, [wScriptParam0]
    or a, a
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; adds the signed step $7526[wScriptParam0 & $3F] (negated with bit 6) to wCB9A, wCBAA and wCBD3, then wScriptParam0 += 1 (E-0124)
; 3 call sites from 3 routines (e.g. SceneWarubouFood2_ShiftObjectsYByTable7526_Case0E, SceneWarubouFood2_ShiftObjectsYByTable7526, ScriptStepSetObjectBit2AndWait)
; reads: wScriptParam0, wObject1, wObject2, wObject5
; writes: wObject1, wObject2, wObject5
; points at: wScriptParam0
ShiftObjectsYByTable7526::
Func_073_736B:: ; address name
    ld a, [wScriptParam0]
    and a, $3F
    ld hl, $7526
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ld a, [wScriptParam0]
    and a, $40
    jr z, .read_object1
    ld a, c
    xor a, $FF
    inc a
    ld c, a

.read_object1:
    ld a, [wObject1 + $B]
    add a, c
    ld [wObject1 + $B], a
    ld a, [wObject2 + $B]
    add a, c
    ld [wObject2 + $B], a
    ld a, [wObject5 + $4]
    add a, c
    ld [wObject5 + $4], a
    ld hl, wScriptParam0
    inc [hl]
    ret

; implements script command type 15 (SCRIPT_SCENE_WARUBOU_FOOD): a cutscene step named after the scene its only script shows: 'Warubou What is this? Food? Perfect!' ... 'Calm down and listen!'; reached through ScriptCommand15 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand15)
; reads: wScriptStep
SceneWarubouFood::
Func_073_73A0:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneWarubouFood_StepPlayerRightTowardWC928
    dw SceneWarubouFood_WriteObject2AndPlayerXEtc
    dw SceneWarubouFood_WriteObject2AndPlayerXEtc_Case02
    dw SceneWarubouFood_WriteObject2AndPlayerXEtc_Case02
    dw SceneWarubouFood_WriteObject2AndPlayerXEtc
    dw SceneWarubouFood_WriteObject2AndPlayerXEtc
    dw SceneWarubouFood_WriteObject2AndPlayerXEtc_Case02
    dw SceneWarubouFood_WriteObject2AndPlayerXEtc_Case02
    dw SceneWarubouFood_WriteObject2AndPlayerXEtc
    dw SceneWarubouFood_QueueSoundEffect
    dw SceneWarubouFood_StepObjectTowardCoord

; entry 10 of the `rst $00` table in SceneWarubouFood
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wObject2, wObject1, wScriptStartRequest
; points at: wScriptParam0
SceneWarubouFood_StepObjectTowardCoord::
Jump_073_73BA:: ; address name
    ld a, [wScriptParam0]
    or a, a
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
    or a, a
    ret z
    ld a, $E0
    ld [wObject2 + $B], a
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
    or a, a
    ret z
    ld a, $E0
    ld [wObject1 + $B], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 9 of the `rst $00` table in SceneWarubouFood
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerX, wObject2
; writes: wObject5, wScriptParam0, wStepPtrLo, wStepPtrHi, wScriptParam1, hPlayerX, wObject2
; points at: hPlayerStateFlags, wScriptStep
SceneWarubouFood_QueueSoundEffect::
Jump_073_741E:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, .read_script_param0
    ld a, $65
    call QueueSoundEffect

.read_script_param0:
    ld a, [wScriptParam0]
    ld hl, $749A
    add_a_to_hl
    ld a, [hl]
    ld [wObject5 + $4], a
    ld a, [wScriptParam0]
    push af
    srl a
    ld [wScriptParam0], a
    ld de, wObject5 + $5
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    pop af
    ld [wScriptParam0], a
    ldh a, [hPlayerX]
    cp a, $00
    jr nz, .set_player_x
    ld hl, hPlayerStateFlags
    call ClearBit2AtHL_Bank73
    ld hl, wObject2 + $D
    call ClearBit2AtHL_Bank73
    jr .check_script_param0

.set_player_x:
    dec a
    dec a
    ldh [hPlayerX], a
    ld a, [wObject2 + $B]
    inc a
    inc a
    ld [wObject2 + $B], a

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $40
    ret nz
    xor a, a
    ld [wObject5], a
    ld a, $68
    ld [wObject5 + $4], a
    ld a, $30
    ld [wObject5 + $5], a
    ld hl, wScriptStep
    inc [hl]
    xor a, a
    ld [wScriptParam0], a
    ld [wScriptParam1], a
    ret
    db $21, $22, $23, $23, $24, $25, $26, $27, $28, $29, $2A, $2A, $2B, $2C, $2D, $2E
    db $2F, $30, $30, $31, $32, $33, $34, $35, $35, $36, $37, $38, $39, $39, $3A, $3B
    db $3C, $3C, $3D, $3E, $3E, $3F, $40, $40, $41, $42, $42, $43, $44, $44, $45, $46
    db $46, $47, $48, $48, $49, $4A, $4A, $4B, $4C, $4C, $4D, $4E, $4E, $4F, $50, $50

; entry 2 of the `rst $00` table in SceneWarubouFood
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject2, hPlayerX, wFollowerRecords, wObject5
; writes: wObject2, hPlayerX, wFollowerRecords, wObject5, wScriptParam0
; points at: wScriptStep
SceneWarubouFood_WriteObject2AndPlayerXEtc_Case02::
Jump_073_74DA:: ; address name
    ld a, [wScriptParam0]
    ld hl, $7526
    add_a_to_hl
    ld a, [hl]
    xor a, $FF
    inc a
    ld c, a
    jr SceneWarubouFood_WriteObject2AndPlayerXEtc_ReadObject2

; entry 1 of the `rst $00` table in SceneWarubouFood
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wObject2, hPlayerX, wFollowerRecords, wObject5
; writes: wObject2, hPlayerX, wFollowerRecords, wObject5, wScriptParam0
; points at: wScriptStep
SceneWarubouFood_WriteObject2AndPlayerXEtc::
Jump_073_74EC:: ; address name
    ld a, [wScriptParam0]
    ld hl, $7526
    add_a_to_hl
    ld a, [hl]
    ld c, a

SceneWarubouFood_WriteObject2AndPlayerXEtc_ReadObject2::
Jump_073_74F9:: ; address name
    ld a, [wObject2 + $B]
    add a, c
    ld [wObject2 + $B], a
    ldh a, [hPlayerX]
    add a, c
    ldh [hPlayerX], a
    ld a, [wFollowerRecords + $1]
    add a, c
    ld [wFollowerRecords + $1], a
    ld a, [wObject5 + $4]
    add a, c
    ld [wObject5 + $4], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $40
    ret nz
    ld hl, wScriptStep
    inc [hl]
    xor a, a
    ld [wScriptParam0], a
    ret
    db $01, $00, $01, $00, $01, $01, $00, $FF, $01, $00, $00, $FF, $00, $FF, $FF, $00
    db $01, $00, $00, $00, $01, $01, $FF, $00, $00, $FF, $00, $00, $00, $FF, $01, $00
    db $01, $00, $01, $00, $00, $01, $01, $01, $00, $00, $FF, $00, $00, $00, $FF, $01
    db $FF, $00, $00, $01, $FF, $FF, $FF, $00, $00, $00, $FF, $00, $00, $FF, $FF, $00

; entry 0 of the `rst $00` table in SceneWarubouFood
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrLo, wFollowerRecords
; points at: hPlayerStateFlags, wScriptStep
SceneWarubouFood_StepPlayerRightTowardWC928::
Jump_073_7566:: ; address name
    ld a, $10
    ld [wStepPtrLo], a
    farcall StepPlayerRightTowardWC928
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $01
    ld [wFollowerRecords], a
    ld hl, hPlayerStateFlags
    call SetBit2AtHL_B73
    ld hl, wObject2 + $D
    call SetBit2AtHL_B73
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 17 (SCRIPT_SCENE_PACKAGE): a cutscene step named after the scene its only script shows: 'Did you get the package from...' ... 'Oh goodness, you're filthy!'; reached through ScriptCommand17 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand17)
; reads: wScriptStep, hPlayerX, hPlayerY
; writes: wObject5, wScriptStartRequest
; points at: wScriptStep
ScenePackage::
Func_073_758C:: ; address name
    ld a, [wScriptStep]
    or a, a
    jr nz, .check_player_x
    ldh a, [hPlayerX]
    ld [wObject5 + $4], a
    ldh a, [hPlayerY]
    ld [wObject5 + $5], a
    ld a, $80
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

.check_player_x:
    ldh a, [hPlayerX]
    cp a, $30
    jr nz, .cp_50
    ld hl, wObject5 + $4
    inc [hl]
    jr .call_script_apply_step_delta_at_de_bank73

.cp_50:
    cp a, $50
    jr nz, .check_player_y
    ld hl, wObject5 + $4
    dec [hl]
    jr .call_script_apply_step_delta_at_de_bank73

.check_player_y:
    ldh a, [hPlayerY]
    cp a, $20
    jr nz, .skip
    ld hl, wObject5 + $5
    inc [hl]
    jr .call_script_apply_step_delta_at_de_bank73

.skip:
    ld hl, wObject5 + $5
    dec [hl]

.call_script_apply_step_delta_at_de_bank73:
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    xor a, a
    ld [wObject5], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 14 (SCRIPT_SCENE_WARUBOU_SMELLS): a cutscene step named after the scene its only script shows: 'Warubou Wha? I smell something!' ... 'What is this? Food? Perfect!'; reached through ScriptCommand14 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand14)
; reads: wScriptStep
SceneWarubouSmells::
Func_073_75DD:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneWarubouSmells_WriteObject2
    dw SceneWarubouSmells_QueueSoundEffect
    dw SceneWarubouSmells_AddStepDeltaToPointedByte
    dw SceneWarubouSmells_StepScriptParam0Counter_Bank73

; entry 3 of the `rst $00` table in SceneWarubouSmells
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
SceneWarubouSmells_StepScriptParam0Counter_Bank73::
Jump_073_75E9:: ; address name
    ld b, $3C
    call StepScriptParam0Counter_Bank73
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in SceneWarubouSmells
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerX, wFollowerRecords, wScriptParam0
; writes: hPlayerX, wFollowerRecords, wObject5, wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: wScriptStep
SceneWarubouSmells_AddStepDeltaToPointedByte::
Jump_073_75F5:: ; address name
    ldh a, [hPlayerX]
    cp a, $00
    jr z, .set_object5_to_80
    dec a
    dec a
    ldh [hPlayerX], a
    ld a, [wFollowerRecords + $1]
    cp a, $00
    jr z, .set_object5_to_80
    dec a
    dec a
    ld [wFollowerRecords + $1], a

.set_object5_to_80:
    ld a, $80
    ld [wObject5], a
    ld de, wObject5 + $5
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
    ld a, $50
    ld [wObject5 + $5], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneWarubouSmells
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2
; writes: wObject2
; points at: wScriptStep
SceneWarubouSmells_QueueSoundEffect::
Jump_073_7639:: ; address name
    ld a, [wObject2 + $B]
    dec a
    dec a
    ld [wObject2 + $B], a
    cp a, $30
    ret nz
    ld a, $63
    call QueueSoundEffect
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneWarubouSmells
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2
; writes: wObject2
; points at: wScriptStep
SceneWarubouSmells_WriteObject2::
Jump_073_764E:: ; address name
    ld a, [wObject2 + $B]
    inc a
    ld [wObject2 + $B], a
    cp a, $40
    ret nz
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 13 (SCRIPT_SCENE_SPINNING): a cutscene step named after the scene its only script shows: 'Oh It's all spinning around' ... 'You must be the farm kids.'; reached through ScriptCommand13 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand13)
; reads: wScriptStep
SceneSpinning::
Func_073_765D:: ; address name
    ld a, [wScriptStep]
    rst $00
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
    dw SceneSpinning_StepObjectTowardCoord_Case0F
    dw SceneSpinning_StepObjectTowardCoord_Case10

; entry 16 of the `rst $00` table in SceneSpinning
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wScriptStartRequest
SceneSpinning_StepObjectTowardCoord_Case10::
Jump_073_7683:: ; address name
    ld a, $01
    ld [wStepPtrHi], a
    ld a, $82
    ld [wStepTarget], a
    ld a, $E0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $82
    ld [wStepTarget], a
    ld a, $E0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 15 of the `rst $00` table in SceneSpinning
; no direct call (reached through a table, a jump or a vector)
; reads: wObject2
; writes: wStepTarget, wStepPtrLo, wStepPtrHi, wObject5
; points at: wScriptStep
SceneSpinning_StepObjectTowardCoord_Case0F::
Jump_073_76B8:: ; address name
    ld a, [wObject2 + $B]
    cp a, $40
    jr z, .set_step_target_to_82
    ld a, $83
    ld [wStepTarget], a
    ld a, $40
    ld [wStepPtrLo], a
    jr .set_step_ptr_hi_to_02

.set_step_target_to_82:
    ld a, $82
    ld [wStepTarget], a
    ld a, $E0
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
    ld hl, wObject5 + $5
    inc [hl]
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    xor a, a
    ld [wObject5], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in SceneSpinning
; no direct call (reached through a table, a jump or a vector)
SceneSpinning_ToScriptStepAdjust32TimesThenMessage_Bank73::
Jump_073_7709:: ; address name
    ld de, wSpriteSlots + $C
    ld hl, $0039
    call ScriptStepAdjust32TimesThenMessage_Bank73
    ret

; entry 7 of the `rst $00` table in SceneSpinning
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: wScriptStep
SceneSpinning_WriteStepPtrLoAndStepPtrHiEtc::
Jump_073_7713:: ; address name
    ld hl, wObject5 + $4
    inc [hl]
    jr SceneSpinning_AddStepDeltaToPointedByte_SetStepPtrLo

; entry 5 of the `rst $00` table in SceneSpinning
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: wScriptStep
SceneSpinning_AddStepDeltaToPointedByte::
Jump_073_7719:: ; address name
    ld hl, wObject5 + $4
    dec [hl]

SceneSpinning_AddStepDeltaToPointedByte_SetStepPtrLo::
Jump_073_771D:: ; address name
    ld de, wObject5 + $5
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
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in SceneSpinning
; no direct call (reached through a table, a jump or a vector)
; writes: wObject2
; points at: wScriptStep
SceneSpinning_ScriptApplyStepDeltaAtDE_Bank73::
Jump_073_7741:: ; address name
    ld hl, wObject5 + $4
    dec [hl]
    ld hl, wObject5 + $5
    dec [hl]
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    ld a, $03
    ld [wObject2 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in SceneSpinning
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneSpinning_StepScriptParam0Counter_Bank73::
Jump_073_775A:: ; address name
    ld b, $1E
    call StepScriptParam0Counter_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneSpinning
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo, wObject2
; points at: wScriptStep
SceneSpinning_StepObjectTowardCoord::
Jump_073_7765:: ; address name
    ld a, [wObject1 + $B]
    cp a, $30
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
    or a, a
    ret z
    ld a, $01
    ld [wObject2 + $7], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in SceneSpinning
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wObject2, wObject1, wScriptParam0
; points at: wScriptParam0, wScriptStep
SceneSpinning_WriteObject2AndObject1Etc::
Jump_073_77A5:: ; address name
    ld hl, wScriptParam0
    inc [hl]
    ld a, [wScriptParam0]
    cp a, $3C
    jr nz, .cp_78
    ld a, $50
    ld [wObject2 + $B], a
    ret

.cp_78:
    cp a, $78
    jr nz, .cp_B4
    ld a, $20
    ld [wObject1 + $B], a
    ret

.cp_B4:
    cp a, $B4
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; implements script command type 12 (SCRIPT_SCENE_LEARN_QUICK): a cutscene step named after the scene its only script shows: 'Wow, you kids sure learn quick!' ... 'Oh It's all spinning around'; reached through ScriptCommand12 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand12)
; reads: wScriptStep
SceneLearnQuick::
Func_073_77CC:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneLearnQuick_SetMessageIndex
    dw SceneLearnQuick_StepScriptParam0Counter_Bank73
    dw SceneLearnQuick_StepScriptParam0Counter_Bank73_Case02
    dw SceneLearnQuick_StepObjectTowardCoord
    dw SceneLearnQuick_StepObjectTowardCoord_Case04
    dw SceneLearnQuick_WriteScriptStartRequest

; entry 5 of the `rst $00` table in SceneLearnQuick
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1
; writes: wScriptStartRequest
SceneLearnQuick_WriteScriptStartRequest::
Jump_073_77DC:: ; address name
    call SceneLearnQuick_WriteScriptParam0AndSpriteSlots
    ld a, [wScriptParam1]
    or a, a
    ret nz
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 4 of the `rst $00` table in SceneLearnQuick
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, wMessageIndex, wStepArrived, wObject2
; writes: wStepTarget, wStepPtrLo, wStepPtrHi, wMessageIndex, wScriptParam0
; points at: wScriptStep
SceneLearnQuick_StepObjectTowardCoord_Case04::
Jump_073_77EA:: ; address name
    call SceneLearnQuick_WriteScriptParam0AndSpriteSlots
    ld a, [wObject1 + $C]
    cp a, $30
    jr z, .set_step_target_to_83
    ld a, $82
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a
    jr .set_step_ptr_hi_to_01

.set_step_target_to_83:
    ld a, $83
    ld [wStepTarget], a
    ld a, $E0
    ld [wStepPtrLo], a

.set_step_ptr_hi_to_01:
    ld a, $01
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, [wMessageIndex]
    or a, a
    jr nz, .check_object2
    ld a, $02
    ld [wStepPtrHi], a
    ld a, $83
    ld [wStepTarget], a
    ld a, $20
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    ld a, $01
    ld [wMessageIndex], a
    ret

.check_object2:
    ld a, [wObject2 + $C]
    cp a, $30
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
    ld a, $E0
    ld [wStepPtrLo], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    ret z
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in SceneLearnQuick
; no direct call (reached through a table, a jump or a vector)
; reads: wStepArrived
; writes: wStepPtrHi, wStepTarget, wStepPtrLo
; points at: wScriptStep
SceneLearnQuick_StepObjectTowardCoord::
Jump_073_787B:: ; address name
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
    or a, a
    ret z
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in SceneLearnQuick
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam1, wMessageIndex
; points at: wScriptStep
SceneLearnQuick_StepScriptParam0Counter_Bank73_Case02::
Jump_073_78B2:: ; address name
    call SceneLearnQuick_WriteStepTargetAndStepPtrLoEtc
    call SceneLearnQuick_WriteSpriteSlots
    ld b, $A0
    call StepScriptParam0Counter_Bank73
    ret nc
    ld a, $40
    ld [wScriptParam1], a
    xor a, a
    ld [wMessageIndex], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in SceneLearnQuick
; no direct call (reached through a table, a jump or a vector)
; writes: wMessageIndex, wMessageGroup
; points at: wScriptStep
SceneLearnQuick_StepScriptParam0Counter_Bank73::
Jump_073_78CC:: ; address name
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

; entry 0 of the `rst $00` table in SceneLearnQuick
; no direct call (reached through a table, a jump or a vector)
; writes: wMessageIndex, wMessageGroup
; points at: wScriptStep
SceneLearnQuick_SetMessageIndex::
Jump_073_78E7:: ; address name
    ld a, $01
    ld [wMessageIndex], a
    xor a, a
    ld [wMessageGroup], a
    ld hl, wScriptStep
    inc [hl]
    ret

; only called from routines of SceneLearnQuick (E-0098)
; 2 call sites from 2 routines (e.g. SceneLearnQuick_StepScriptParam0Counter_Bank73_Case02, SceneLearnQuick_StepScriptParam0Counter_Bank73)
; reads: wMessageIndex, wStepArrived, wMessageGroup
; writes: wStepTarget, wStepPtrLo, wStepPtrHi, wMessageIndex, wMessageGroup
SceneLearnQuick_WriteStepTargetAndStepPtrLoEtc::
Func_073_78F5:: ; address name
    ld b, $00
    ld a, [wMessageIndex]
    bit 7, a
    jr z, .skip
    ld b, $80

.skip:
    and a, $03
    jr nz, .skip2
    ld a, b
    or a, $01
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    jr .set_step_ptr_hi_to_01

.skip2:
    dec a
    jr nz, .skip3
    ld a, b
    or a, $00
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    jr .set_step_ptr_hi_to_01

.skip3:
    dec a
    jr nz, .set_step_target
    ld a, b
    or a, $03
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a
    jr .set_step_ptr_hi_to_01

.set_step_target:
    ld a, b
    or a, $02
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a

.set_step_ptr_hi_to_01:
    ld a, $01
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    jr z, .check_message_group
    ld a, [wMessageIndex]
    inc a
    and a, $83
    ld [wMessageIndex], a

.check_message_group:
    ld b, $00
    ld a, [wMessageGroup]
    bit 7, a
    jr z, .skip4
    ld b, $80

.skip4:
    and a, $03
    jr nz, .skip5
    ld a, b
    or a, $01
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    jr .set_step_ptr_hi_to_02

.skip5:
    dec a
    jr nz, .skip6
    ld a, b
    or a, $00
    ld [wStepTarget], a
    ld a, $50
    ld [wStepPtrLo], a
    jr .set_step_ptr_hi_to_02

.skip6:
    dec a
    jr nz, .set_step_target2
    ld a, b
    or a, $03
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a
    jr .set_step_ptr_hi_to_02

.set_step_target2:
    ld a, b
    or a, $02
    ld [wStepTarget], a
    ld a, $30
    ld [wStepPtrLo], a

.set_step_ptr_hi_to_02:
    ld a, $02
    ld [wStepPtrHi], a
    farcall StepObjectTowardCoord
    ld a, [wStepArrived]
    or a, a
    jr z, .return
    ld a, [wMessageGroup]
    inc a
    and a, $83
    ld [wMessageGroup], a

.return:
    ret

; only called from routines of SceneLearnQuick (E-0098)
; 2 call sites from 2 routines (e.g. SceneLearnQuick_StepScriptParam0Counter_Bank73_Case02, SceneLearnQuick_StepScriptParam0Counter_Bank73)
; reads: wMessageGroup
; writes: wSpriteSlots
SceneLearnQuick_WriteSpriteSlots::
Func_073_79B8:: ; address name
    ld a, [wMessageGroup]
    and a, $03
    ld hl, $79CA
    add_a_to_hl
    ld a, [hl]
    ld [wSpriteSlots + $7], a
    ret
    db $01, $00, $03, $02

; only called from routines of SceneLearnQuick (E-0098)
; 3 call sites from 3 routines (e.g. SceneLearnQuick_WriteScriptStartRequest, SceneLearnQuick_StepObjectTowardCoord_Case04, SceneLearnQuick_StepObjectTowardCoord)
; reads: wFrameCounterLo, wScriptParam1, wScriptParam0
; writes: wScriptParam0, wSpriteSlots
; points at: wScriptParam1
SceneLearnQuick_WriteScriptParam0AndSpriteSlots::
Func_073_79CE:: ; address name
    ld a, [wFrameCounterLo]
    and a, $08
    jr nz, .read_script_param1
    ld hl, wScriptParam1
    dec [hl]

.read_script_param1:
    ld a, [wScriptParam1]
    swap a
    and a, $0F
    ld c, a
    ld a, [wScriptParam0]
    add a, c
    ld [wScriptParam0], a
    swap a
    and a, $03
    ld c, a
    ld a, $03
    sub a, c
    ld [wSpriteSlots + $7], a
    ret

; implements script command type 11 (SCRIPT_SCENE_FARM_KIDS): a cutscene step named after the scene its only script shows: 'You must be the farm kids.' ... 'Warubou Wha? I smell something!'; reached through ScriptCommand11 in bank $10 (E-0038, E-0245)
; 1 call site from 1 routine (e.g. ScriptCommand11)
; reads: wScriptStep
SceneFarmKids::
Func_073_79F4:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw SceneFarmKids_StepScriptParam0Counter_Bank73
    dw SceneFarmKids_ScriptApplyStepDeltaAtDE_Bank73

; entry 1 of the `rst $00` table in SceneFarmKids
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5, wScriptStartRequest
SceneFarmKids_ScriptApplyStepDeltaAtDE_Bank73::
Jump_073_79FC:: ; address name
    ld hl, wObject5 + $5
    inc [hl]
    ld de, wObject5 + $5
    call ScriptApplyStepDeltaAtDE_Bank73
    ret nc
    xor a, a
    ld [wObject5], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 0 of the `rst $00` table in SceneFarmKids
; no direct call (reached through a table, a jump or a vector)
; writes: wObject5
; points at: wScriptStep
SceneFarmKids_StepScriptParam0Counter_Bank73::
Jump_073_7A11:: ; address name
    ld a, $40
    ld [wObject5 + $4], a
    ld a, $30
    ld [wObject5 + $5], a
    ld a, $80
    ld [wObject5], a
    ld b, $3C
    call StepScriptParam0Counter_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; wC921 += 1; if it now equals B it is reset to 0 and carry is set, else carry is clear; returns A = 0 either way (the same 18 bytes appear in 3 banks)
; 19 call sites from 19 routines (e.g. SceneCyalShine_StepScriptParam0Counter_Bank73, ScriptCommand60_Run_StepScriptParam0Counter_Bank73, SceneMadcondorCry_StepScriptParam0Counter_Bank73, SceneMadcondor_StepScriptParam0Counter_Bank73, ...)
; reads: wScriptParam0
; writes: wScriptParam0
StepScriptParam0Counter_Bank73::
Func_073_7A2B:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, b
    jr z, .clear_script_param0
    sub a, a
    ret

.clear_script_param0:
    xor a, a
    ld [wScriptParam0], a
    scf
    ret

; [HL] |= $02; clobbers A (the same 5 bytes appear in 4 banks)
; 2 call sites from 2 routines (e.g. SceneSpiritEnvoy2_SetBit1AtHL_Bank73, SceneDancing_SetBit2AtHL_B73AndStep)
SetBit1AtHL_Bank73::
Func_073_7A3D:: ; address name
    ld a, [hl]
    or a, $02
    ld [hl], a
    ret

; [HL] &= $FD; clobbers A (the same 5 bytes appear in 4 banks)
; no direct call (reached through a table, a jump or a vector)
ClearBit1AtHL_Bank73:: ; heuristic: follows a terminator; C0
Func_073_7A42:: ; address name
    ld a, [hl]
    and a, $FD
    ld [hl], a
    ret

; sets bit 2 of the byte at [HL]; only A is clobbered
; 17 call sites from 13 routines (e.g. SceneMercy, SceneChestBattle_SetBit2AtHL_B73, SceneTooStrong_SetBit2AtHL_B73, SceneRoltElder_SetBit2AtHL_B73, ...)
SetBit2AtHL_B73::
Func_073_7A47:: ; address name
    ld a, [hl]
    or a, $04
    ld [hl], a
    ret

; [HL] &= $FB; clobbers A (the same 5 bytes appear in 4 banks)
; 11 call sites from 9 routines (e.g. SceneChestBattle_ClearBit2AtHL_Bank73, SceneMilayouForest_ClearBit2AtHL_Bank73, SceneTooStrong_SetBit2AtHL_B73, SceneRoltElder_ClearBit2AtHL_Bank73, ...)
ClearBit2AtHL_Bank73::
Func_073_7A4C:: ; address name
    ld a, [hl]
    and a, $FB
    ld [hl], a
    ret

; when wScriptParam0 & $1F = 0: [DE] = ([DE] + 1) & 3, the next of four directions; otherwise returns with A = wScriptParam0 & $1F (E-0064) (the same 12 bytes appear in 3 banks)
; 4 call sites from 4 routines (e.g. SceneWarubouFood2_ShowWarubouWaheyItsThe, SceneWarubouFood2_CycleSpriteFloatYDown_Case15, SceneWarubouFood2_CycleSpriteFloatYDown_Case13, SceneWarubouFood2_RunMessageBoxFar_Bank73)
; reads: wScriptParam0
RotateDirectionAtDEEvery32_Bank73::
Func_073_7A51:: ; address name
    ld a, [wScriptParam0]
    and a, $1F
    ret nz
    ld a, [de]
    inc a
    and a, $03
    ld [de], a
    ret

; the same 34 bytes as ScriptApplyStepDeltaAtDE (0F:7EE9)
; 13 call sites from 13 routines (e.g. ScenePackage, SceneWarubouMagicKey, SceneOasisKey, ScriptCommand60_Run_ScriptApplyStepDeltaAtDE_Bank73_Case04, ...)
; reads: wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0
ScriptApplyStepDeltaAtDE_Bank73::
Func_073_7A5D:: ; address name
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
    jr z, .clear_script_param0
    sub a, a
    ret

.clear_script_param0:
    xor a, a
    ld [wScriptParam0], a
    scf
    ret

; stores DE in wC928/9 and far-calls AddStepDeltaToPointedByte each frame; after 32 frames starts message HL, clears wScriptParam0 and advances wScriptStep (E-0121)
; 3 call sites from 3 routines (e.g. SceneWarubouFood2_CycleSpriteFloatYDown_Case13, SceneWarubouFood2_CycleSpriteFloatYDown, SceneSpinning_ToScriptStepAdjust32TimesThenMessage_Bank73)
; reads: wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: wScriptStep
ScriptStepAdjust32TimesThenMessage_Bank73::
Func_073_7A7F:: ; address name
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
    cp a, $20
    ret nz
    call StartMessageHL_B73b
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; HL is stored in wC924 (low) and wC925 (high); then wC926 = 0
; 29 call sites from 24 routines (e.g. UnreferencedScriptStepDispatch_73_6D52_ShowOhButICan, UnreferencedScriptStepDispatch_73_6D52_Msg4D0F_HmYouAreQuite, SceneChestBattle_StartMessageHL_B73b, SceneWizstone_Msg0782_HeroReceivedTheSmartBook, ...)
; writes: wMessageIndex, wMessageGroup, wMessageState
StartMessageHL_B73b::
Func_073_7AA5:: ; address name
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a, a
    ld [wMessageState], a
    ret

; wC928 = A, far-calls RunMessageBox, then carry set when wMessageState = $FF (idle), else A = 0 and carry clear (E-0079) (the same 20 bytes appear in 4 banks)
; 7 call sites from 7 routines (e.g. SceneWizstone_RunMessageBoxFar_Bank73, SceneMermaidSong2_ShowBravoBravoYouWere, SceneMermaidSong_RunMessageBoxFar_Bank73_Case09, SceneMermaidSong_RunMessageBoxFar_Bank73, ...)
; reads: wMessageState
; writes: wStepPtrLo
RunMessageBoxFar_Bank73::
Func_073_7AB2:: ; address name
    ld [wStepPtrLo], a
    farcall RunMessageBox
    ld a, [wMessageState]
    cp a, $FF
    jr z, .return_carry
    sub a, a
    ret

.return_carry:
    scf
    ret

; entry 1 of the `rst $00` table in SceneChestBattle
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
SceneChestBattle_RunMessageBoxFar_Bank73::
Jump_073_7AC6:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank73
    ret nc
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in SceneWizstone
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptStartRequest
SceneWizstone_RunMessageBoxFar_Bank73::
Jump_073_7AD0:: ; address name
    xor a, a
    call RunMessageBoxFar_Bank73
    ret nc
    ld a, $80
    ld [wScriptStartRequest], a
    ret
    ds $525, $00
