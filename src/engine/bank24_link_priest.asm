; ROM bank $24: link mode (game mode 6), item descriptions, the priest
; The annotated listing of this bank is build/listing/bank24.asm.

SECTION "Bank 24", ROMX[$4000], BANK[$24]
    db $24

; start-up for wGameMode = 6; forcing this mode on the emulator shows: victory screen when forced
; (E-0029)
GameMode6_Init::
    ld hl, wScreenState
    ld bc, $006f

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop
    ld a, [wLinkRules + $9]
    and a
    jr nz, .check_battle_scene
    jr .skip

.check_battle_scene:
    ld a, [wBattleScene]
    cp $80
    jr z, .skip
    and $01
    and a
    jr nz, .check_record_buf_a
    jr .skip

.check_record_buf_a:
    ld a, [wRecordBufA]
    and a
    jr z, .skip
    ld a, [wLinkSceneArg]
    ld [wArg1], a
    xor a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    xor a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a

.loop2:
    farcall RunSaveGameSteps
    ld a, [wSaveStep]
    bit 7, a
    jr z, .loop2
    ld hl, wScreenState
    ld bc, $006f

.loop3:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop3

.skip:
    ld b, $46
    ld de, Tiles1Gfx
    ld hl, vTiles1
    call DecompressToVRAM
    farcall ClearScreenBufferAndAttributes_BankF1
    xor a
    ldh [hScrollY], a
    ldh [hScrollX], a
    call BGMapAddressAtScroll_Bank24
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_24
    farcall LoadPalette0FromData_3
    farcall SendSGBFieldPaletteSet
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
    ld a, [wBattleScene]
    cp $08
    jr nz, .call_game_mode6_init_load_battler_pictures
    ld a, [wRecordBufA + MON_SPECIES]
    ld [wBattlerRecords + BATTLER_SPECIES], a
    ld a, [wRecordBufA + MON_SPECIES + 1]
    ld [wBattlerRecords + BATTLER_SPECIES + 1], a

.call_game_mode6_init_load_battler_pictures:
    call GameMode6_Init_LoadBattlerPictures
    ld a, [wBattleScene]
    cp $80
    jr nz, .skip2
    ld de, GameMode6_Init_Data2
    ld b, $24
    jr .call_decompress_to_ram_locked

.skip2:
    and $01
    and a
    jr nz, .skip3
    ld de, GameMode6_Init_Data1
    ld b, $24
    jr .call_decompress_to_ram_locked

.skip3:
    ld de, Tiles1Plus600Gfx
    ld b, $24

.call_decompress_to_ram_locked:
    ld hl, vTiles1 + $600
    call DecompressToRAMLocked
    call GameMode6_Init_ColorAndDrawPictures
    ld a, $01
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $00
    ldh [hSpriteWindowClipMode], a

.loop4:
    farcall StepTextWindowOpenClose
    ld a, [wTextWindowState]
    and $03
    jr nz, .loop4
    ld a, $fc
    call StartPaletteFade
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    xor a
    ld [wSpriteSlotCount], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $01
    jp ResumeAfterModeChange

; game mode 6, the egg and save screens after a link or the priest: by wScreenState it shows an
; obtained egg, the save prompt and the save, record lists, the monster swap menu and the egg or
; monster switch (E-0354; was: per-frame routine for wGameMode = 6)
GameMode6_Update::
    ld a, [wFadeState]
    and a
    ret nz
    ld a, [wTextFlags]
    and a
    jr z, .read_screen_state
    ld a, [wScreenState]
    cp $02
    jr z, .check_screen_step
    cp $03
    ret nz
    ld a, [wScreenStep]
    cp $01
    ret nz
    ld a, [wScreenSubStep]
    cp $09
    ret nz
    call GameMode6_Update_DrawSprites
    ret

.check_screen_step:
    ld a, [wScreenStep]
    cp $0e
    ret nz
    ld a, [wScreenSubStep]
    cp $09
    ret nz
    call GameMode6_Update_DrawSprites
    ret

.read_screen_state:
    ld a, [wScreenState]
    jumptable
    dw GameMode6_Update_ObtainedEgg
    dw GameMode6_Update_DrawResultBox
    dw GameMode6_Update_TakePrize
    dw GameMode6_Update_GiveUp
    dw GameMode6_Update_ChooseMonster
    dw GameMode6_Update_ChooseEgg
    dw GameMode6_Update_EmptyState
    dw GameMode6_Update_EmptyState
    dw GameMode6_Update_EmptyState
    dw GameMode6_Update_EmptyState
    dw GameMode6_Update_EmptyState
    dw GameMode6_Update_EmptyState
    dw GameMode6_Update_RunStatsScreen
    dw GameMode6_Update_RunEggStatsScreen
    dw GameMode6_Update_SwitchEgg
    dw GameMode6_Update_SwitchMonster

; by wScreenStep: shows 'obtained an egg of 0.' (E-0293)
GameMode6_Update_ObtainedEgg::
    ld a, [wScreenStep]
    jumptable
    dw GameMode6_Update_ShowResult
    dw GameMode6_Update_ShowResult_CheckPrize

; The result screen, step 0: for an egg (wBattleScene $08) copies wRecordBufA's name and shows
; 'obtained an egg of <name>.' (category 5, string $13); otherwise draws a 17 x 2 banner (one for a
; draw, $80, one for a result) and shows the link battle's result (bank-$33 strings: 0 'It ends in a
; draw!', 1 'Congratulations! You've won!' with scene bit 0 clear, 2 'Too bad! You've lost!' with it
; set). (C1, E-0357)
GameMode6_Update_ShowResult::
    ld a, [wBattleScene]
    cp $08
    jr z, .call_bg_map_address_at_scroll_bank24
    cp $80
    jr z, .skip
    jr .skip2

.skip:
    ld de, GameMode6_Update_ShowResult_Data
    jr .call_copy_rect_to20_byte_rows_jp_bank24

.skip2:
    ld de, GameMode6_Update_ShowResult_TileRect

.call_copy_rect_to20_byte_rows_jp_bank24:
    ld hl, wWindowTileBuffer + $7a
    lb bc, $11, $02
    call CopyRectTo20ByteRowsJp_Bank24
    call GameMode6_Update_ShowResult_WaitForVRAMAccess
    call BGMapAddressAtScroll_Bank24
    lb bc, $14, $06
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, [wBattleScene]
    cp $80
    jr z, .call_show_string_a_in_default_window_bank24
    and $01
    add $01
    call ShowStringAInDefaultWindow_Bank24
    ret

.call_show_string_a_in_default_window_bank24:
    xor a
    call ShowStringAInDefaultWindow_Bank24
    ret

.call_bg_map_address_at_scroll_bank24:
    call BGMapAddressAtScroll_Bank24
    lb bc, $14, $06
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld hl, wRecordBufA + MON_NAME
    ld de, wTextBuf0
    ld bc, $000a
    call CopyBytes
    ld a, $f0
    ld [wTextBuf0 + $a], a
    ld a, $05
    ld [wStringCategory], a
    ld a, $13
    ld [wStringIndex], a ; 'obtained an egg of 0.'
    farcall BeginStringDisplay_Bank07
    ret

; The result screen, step 1: without the prize rule (wLinkRules + 9 zero) or after a draw ends the
; screen; otherwise when the prize record is empty (wRecordBufB for the winner, wRecordBufA for the
; loser) ends too, else goes on. (C1, E-0357)
GameMode6_Update_ShowResult_CheckPrize::
    ld a, [wLinkRules + $9]
    and a
    jr nz, .check_battle_scene

.loop:
    call GameMode6_Update_EndMode
    ret

.check_battle_scene:
    ld a, [wBattleScene]
    cp $80
    jr z, .loop
    and $01
    and a
    jr z, .check_record_buf_b
    ld a, [wRecordBufA]
    and a
    jr z, .loop
    jr .clear_screen_step

.check_record_buf_b:
    ld a, [wRecordBufB]
    and a
    jr z, .loop

.clear_screen_step:
    xor a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; Game mode 6, state 1: draws a 20 x 6 box and goes to state 2 for the winner (taking the prize) or
; 3 for the loser (scene bit 0). (C1, E-0357)
GameMode6_Update_DrawResultBox::
    ld de, GameMode6_Update_DrawResultBox_Data
    ld hl, wWindowTileBuffer + $f0
    lb bc, $14, $06
    call CopyRectTo20ByteRowsJp_Bank24
    call BGMapAddressAtScroll_Bank24
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_24
    ld a, [wBattleScene]
    and $01
    add $01
    ld b, a
    ld a, [wScreenState]
    add b
    ld [wScreenState], a
    ret

; by wScreenStep: RunSaveGameSteps, a yes/no prompt and a 'monster egg' message (renamed from
; GameMode6_Update_SavePrompt from its E-0357 note, E-0367)
GameMode6_Update_TakePrize::
    ld a, [wScreenStep]
    jumptable
    dw GameMode6_Update_TakePrize_Start
    dw GameMode6_Update_TakePrize_StoreRecord
    dw GameMode6_Update_TakePrize_Save
    dw GameMode6_Update_TakePrize_AskToSwitch
    dw GameMode6_Update_TakePrize_DrawYesNo
    dw GameMode6_Update_TakePrize_ReadAnswer
    dw GameMode6_Update_TakePrize_End
    dw GameMode6_Update_TakePrize_DrawMonsterEggChoice
    dw GameMode6_Update_TakePrize_MonsterEggChoice
    dw GameMode6_Update_TakePrize_BackToYesNo
    dw GameMode6_Update_TakePrize_CheckEggs
    dw GameMode6_Update_TakePrize_RedrawBoxes
    dw GameMode6_Update_TakePrize_AskSwitchWhich
    dw GameMode6_Update_TakePrize_StartReceivingScene
    dw GameMode6_Update_TakePrize_RunReceivingScene
    dw GameMode6_Update_TakePrize_RestartAfterScene

; Taking the prize, step 0: except for an egg ($08), first plays the hand-over scene (step $0D, back
; with sub-step 1); then with the farm full (CountRecordsInUse against wRecordCapacity) goes to step
; 3, otherwise step 1. (C1, E-0357)
GameMode6_Update_TakePrize_Start::
    ld a, [wBattleScene]
    cp $08
    jr z, .call_count_records_in_use
    ld a, [wScreenSubStep]
    and a
    jr nz, .call_count_records_in_use
    ld a, $0d
    ld [wScreenStep], a
    ret

.call_count_records_in_use:
    farcall CountRecordsInUse
    farcall LoadRecordCapacityFromFarmLevelTable
    ld a, [wRecordCapacity]
    ld b, a
    ld a, [wRecordsInUse]
    cp b
    jr c, .check_screen_step
    ld a, $03
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ret
    db $0a, $14, $1e

; Taking the prize, step 1: copies wRecordBufB ($A5 bytes) into the first free SRAM record (first
; byte 0 or $FF), sets its species flag and resets the save steps. (C1, E-0357)
GameMode6_Update_TakePrize_StoreRecord::
    farcall LoadRecordCapacityFromFarmLevelTable
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld hl, sRecords

.skip:
    ld a, [hl]
    and a
    jr z, .skip2
    cp $ff
    jr z, .skip2
    ld a, $a5
    add_a_to_hl
    jr .skip

.skip2:
    ld de, wRecordBufB
    ld b, $a5

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop
    ld a, [wRecordBufB + MON_SPECIES]
    ld [wSpeciesIdLo], a
    ld a, [wRecordBufB + MON_SPECIES + 1]
    ld [wSpeciesIdHi], a
    farcall SetSpeciesFlag
    xor a
    ld [rRAMG], a
    ld [rRAMB], a
    xor a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Taking the prize, step 2: saves (RunSaveGameSteps), then ends the screen. (C1, E-0357)
GameMode6_Update_TakePrize_Save::
    farcall RunSaveGameSteps
    ld a, [wSaveStep]
    bit 7, a
    ret z
    call GameMode6_Update_EndMode
    ret

; Taking the prize, step 3: 'But you have no room for it... Switch it with another monster?'
; (bank-$33 string 5). (C1, E-0357)
GameMode6_Update_TakePrize_AskToSwitch::
    ld a, $05
    call ShowStringAInDefaultWindow_Bank24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Taking the prize, step 4: plays sound $6C and draws the yes/no box with the cursor on yes. (C1,
; E-0357)
GameMode6_Update_TakePrize_DrawYesNo::
    ld a, $6c
    call QueueSoundEffect
    call GameMode6_Update_TakePrize_ShowYesNo
    ld de, GameMode6_Update_TakePrize_DrawYesNo_TileRect
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRowsJp_Bank24
    call ReturnStub
    call BGMapAddressAtScroll_Bank24
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_24
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Taking the prize, step 5: the answer: B or no copies the prize's name and shows 'Gave up on
; getting <name> and released it in the wild...' (string 6); yes asks 'Switch with which?' (string
; 7) and goes on two steps. (C1, E-0357)
GameMode6_Update_TakePrize_ReadAnswer::
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fe
    jr z, .call_game_mode6_update_take_prize_show_yes_no
    cp $ff
    jr z, .check_two_choice_cursor
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    and a
    jr nz, .call_game_mode6_update_take_prize_show_yes_no
    ld a, $07
    call ShowStringAInDefaultWindow_Bank24
    ld a, [wScreenStep]
    add $02
    ld [wScreenStep], a
    ret

.call_game_mode6_update_take_prize_show_yes_no:
    call GameMode6_Update_TakePrize_ShowYesNo
    call CopyRecordBufBNameNameToTextBuf0
    ld a, $06
    call ShowStringAInDefaultWindow_Bank24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Taking the prize, step 6: ends the screen. (C1, E-0357)
GameMode6_Update_TakePrize_End::
    call GameMode6_Update_EndMode
    ret

; Taking the prize, step 7: plays sound $6C and draws the 'Monster / Egg' choice with the cursor on
; Monster. (C1, E-0357)
GameMode6_Update_TakePrize_DrawMonsterEggChoice::
    ld a, $6c
    call QueueSoundEffect
    call GameMode6_Update_ShowMonsterEg
    ld de, GameMode6_Update_TakePrize_DrawMonsterEggChoice_TileRect
    ld hl, wWindowTileBuffer + $10e
    lb bc, $0a, $05
    call CopyRectTo20ByteRowsJp_Bank24
    call ReturnStub
    call BGMapAddressAtScroll_Bank24
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_24
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Taking the prize, step 8: the Monster / Egg choice: B redraws the yes/no box and asks again
; (string 5, back to step 5 through step 9); A lists the monsters that are not eggs or the eggs and
; goes on two steps. (C1, E-0357)
GameMode6_Update_TakePrize_MonsterEggChoice::
    call GameMode6_Update_TakePrize_ChoiceCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fe
    jr z, .call_game_mode6_update_take_prize_show_yes_no
    cp $ff
    jr z, .check_two_choice_cursor
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    and a
    jr nz, .call_list_records_in_use_eggs
    farcall ListRecordsInUseNotEggs
    jr .read_screen_step

.call_list_records_in_use_eggs:
    farcall ListRecordsInUseEggs

.read_screen_step:
    ld a, [wScreenStep]
    add $02
    ld [wScreenStep], a
    ret

.call_game_mode6_update_take_prize_show_yes_no:
    call GameMode6_Update_TakePrize_ShowYesNo
    ld de, GameMode6_Update_TakePrize_DrawYesNo_TileRect
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRowsJp_Bank24
    xor a
    ld b, $bc
    ld hl, GameMode6_Update_TakePrize_MonsterEggChoice_Data
    call StoreBAtWordTableEntry_Bank24_2
    call ReturnStub
    call BGMapAddressAtScroll_Bank24
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_24
    xor a
    ld b, $c3
    ld hl, GameMode6_Update_TakePrize_MonsterEggChoice_Data
    call StoreBAtWordTableEntry_Bank24_2
    xor a
    ld [wTwoChoiceCursor], a
    ld a, $05
    call ShowStringAInDefaultWindow_Bank24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Taking the prize, step 9 (reached after B on the Monster / Egg choice, which redraws the yes/no
; box and asks again): back to step 5, the yes/no answer (GameMode6_Update_TakePrize_ReadAnswer).
; (C1, E-0370)
GameMode6_Update_TakePrize_BackToYesNo::
    ld a, $05
    ld [wScreenStep], a
    ret

; Taking the prize, step 10: with an empty list 'There are no eggs.' (string $11) and back to the
; choice; otherwise marks the choice and goes on. (C1, E-0357)
GameMode6_Update_TakePrize_CheckEggs::
    ld a, [wListCount]
    and a
    jr nz, .read_two_choice_cursor
    ld a, $11
    call ShowStringAInDefaultWindow_Bank24
    ld a, [wScreenStep]
    sub $02
    ld [wScreenStep], a
    ret

.read_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    ld b, $bc
    ld hl, GameMode6_Update_TakePrize_MonsterEggChoice_Data
    call StoreBAtWordTableEntry_Bank24_2
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Taking the prize, step 11: redraws the boxes over the screen and the bottom five rows. (C1,
; E-0357)
GameMode6_Update_TakePrize_RedrawBoxes::
    ld a, [wBattleScene]
    cp $08
    jr nz, .call_game_mode6_update_draw_result_banner
    ld de, GameMode6_Update_DrawResultBox_Data
    ld hl, wWindowTileBuffer + $f7
    lb bc, $06, $06
    call CopyRectTo20ByteRowsJp_Bank24
    jr .call_bg_map_address_at_scroll_bank24

.call_game_mode6_update_draw_result_banner:
    call GameMode6_Update_DrawResultBanner

.call_bg_map_address_at_scroll_bank24:
    call BGMapAddressAtScroll_Bank24
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_24
    ld de, GameMode6_Update_TakePrize_RedrawBoxes_TileRect
    ld hl, wWindowTileBuffer
    lb bc, $14, $05
    call CopyRectTo20ByteRowsJp_Bank24
    call ReturnStub
    call BGMapAddressAtScroll_Bank24
    ld de, $01a0
    add hl, de
    lb bc, $14, $05
    ld de, $0168
    call DrawScreenBufferRectToBGMap_24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Taking the prize, step 12: reloads the text tiles, draws the bottom five rows, asks 'Switch with
; which?' or 'Switch which egg?' (string 8 + choice) and goes to state 4 (the monster list) or 5
; (the egg list). (C1, E-0357)
GameMode6_Update_TakePrize_AskSwitchWhich::
    ld b, $46
    ld de, Tiles1Gfx
    ld hl, vTiles1
    call DecompressToVRAM
    ld de, vTiles1
    ld b, $24

.loop:
    push bc
    ld hl, GameMode6_Update_TakePrize_AskSwitchWhich_Tiles
    call CopyTileBytesToVRAM_Bank24_2
    pop bc
    dec b
    jr nz, .loop
    ld de, GameMode6_Update_TakePrize_AskSwitchWhich_TileRect
    ld hl, wWindowTileBuffer
    lb bc, $14, $05
    call CopyRectTo20ByteRowsJp_Bank24
    call ReturnStub
    call BGMapAddressAtScroll_Bank24
    ld de, $01a0
    add hl, de
    lb bc, $14, $05
    ld de, $0168
    call DrawScreenBufferRectToBGMap_24
    ld a, [wTwoChoiceCursor]
    add $08
    call ShowStringAInDefaultWindow_Bank24
    xor a
    ld [wScreenStep], a
    ld a, [wScreenState]
    add $02
    ld b, a
    ld a, [wTwoChoiceCursor]
    add b
    ld [wScreenState], a
    ret

; HL = $44FE and 1 calls to a 16-byte VRAM copier (CopyTileBytesToVRAM_*), one tile each (E-0238)
; record: tile (16 bytes, 2 bits per pixel)
GameMode6_Update_TakePrize_AskSwitchWhich_Tiles::
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; entry 0

; Taking the prize, step 13: sets up the scene's sprites and objects
; (GameMode6_Update_SetUpPrizeScene) and goes to step 14, which runs
; GameMode6_Update_ReceivingScene. (C1, E-0370)
GameMode6_Update_TakePrize_StartReceivingScene::
    call GameMode6_Update_SetUpPrizeScene
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Taking the prize, step 14: draws the sprites and runs the hand-over scene. (C1, E-0357)
GameMode6_Update_TakePrize_RunReceivingScene::
    call GameMode6_Update_DrawSprites
    call GameMode6_Update_ReceivingScene
    ret

; Taking the prize, step 15: back to step 0 with sub-step 1 (the scene has played). (C1, E-0357)
GameMode6_Update_TakePrize_RestartAfterScene::
    xor a
    ld [wScreenStep], a
    ld a, $01
    ld [wScreenSubStep], a
    ret

; by wScreenStep: draws the sprites, then RunSaveGameSteps (renamed from GameMode6_Update_Save from
; its E-0357 note, E-0367)
GameMode6_Update_GiveUp::
    ld a, [wScreenStep]
    jumptable
    dw GameMode6_Update_GiveUp_StartHandOverScene
    dw GameMode6_Update_GiveUp_RunHandOver
    dw GameMode6_Update_GiveUp_StartSave
    dw GameMode6_Update_GiveUp_Save

; Giving up the prize, step 0: sets up the scene's sprites and objects
; (GameMode6_Update_SetUpPrizeScene) and goes to step 1, which runs GameMode6_Update_HandOverScene.
; (C1, E-0370)
GameMode6_Update_GiveUp_StartHandOverScene::
    call GameMode6_Update_SetUpPrizeScene
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Giving up the prize, step 1: draws the sprites and runs the hand-over scene. (C1, E-0357)
GameMode6_Update_GiveUp_RunHandOver::
    call GameMode6_Update_DrawSprites
    call GameMode6_Update_HandOverScene
    ret

; Giving up the prize, step 2: clears wSaveStep and wSaveRecordIndex so that step 3
; (GameMode6_Update_GiveUp_Save) runs RunSaveGameSteps from its start, and goes to step 3. (C1,
; E-0370)
GameMode6_Update_GiveUp_StartSave::
    xor a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Giving up the prize, step 3: saves (RunSaveGameSteps), then ends the screen. (C1, E-0357)
GameMode6_Update_GiveUp_Save::
    farcall RunSaveGameSteps
    ld a, [wSaveStep]
    bit 7, a
    ret z
    call GameMode6_Update_EndMode
    ret

; by wScreenStep: a paged record list with strings (ShowStringAInDefaultWindow_Bank24), record
; buffer B and a two-choice input (renamed from GameMode6_Update_ChooseRecordList from its E-0357
; note, E-0367)
GameMode6_Update_ChooseMonster::
    ld a, [wScreenStep]
    jumptable
    dw GameMode6_Update_ChooseMonster_BuildList
    dw GameMode6_Update_ChooseMonster_BuildList
    dw GameMode6_Update_ChooseMonster_BuildList
    dw GameMode6_Update_ChooseMonster_BuildList
    dw GameMode6_Update_ChooseMonster_RunPickStep
    dw GameMode6_Update_ChooseMonster_RunPickStep
    dw GameMode6_Update_ChooseMonster_NoRuleBox
    dw GameMode6_Update_ChooseMonster_ShowCursorMark
    dw GameMode6_Update_PageList
    dw GameMode6_Update_ChooseMonster_RunPickStep
    dw GameMode6_Update_ChooseMonster_InfoOrOK
    dw GameMode6_Update_ChooseMonster_RedrawChoiceBox
    dw GameMode6_Update_ChooseMonster_SwitchForPrize
    dw GameMode6_Update_ChooseMonster_Save

; Choosing the monster to switch, steps 0-3: far-calls BreedMenu, which with wScreenState = 4 runs
; BreedMenu_ChooseParents at the same wScreenStep: BreedMenu_ChooseParents_Init,
; BreedMenu_ChooseParents_ClearList, BreedMenu_ChooseParents_ListMonsters and
; BreedMenu_ChooseParents_DrawNames (the list box, the list of farm monsters that are not eggs and
; the page's names). (C1, E-0370)
GameMode6_Update_ChooseMonster_BuildList::
    farcall BreedMenu
    ret

; Choosing the monster to switch, steps 4, 5 and 9: far-calls LinkBattleSetupMenu, which with
; wScreenState = 4 runs EggServiceMenu_Bank1B_PickRecords at the same wScreenStep:
; DrawListEntriesCell5RecordPanel (step 4), ClearAndDrawListEntriesCell5NameAtTiles1780 (step 5) and
; EggServiceMenu_Bank1B_PickRecords_ShowInfoOKYesN (step 9, the 'Info / OK' choice). (C1, E-0370)
GameMode6_Update_ChooseMonster_RunPickStep::
    farcall LinkBattleSetupMenu
    ret

; Choosing the monster to switch, step 6: only advances wScreenStep. The list's other steps come
; from EggServiceMenu_Bank1B_PickRecords, whose step 6 draws the rule box
; (DrawRuleBoxByLinkRuleTurnLimit1Bit7); this screen leaves it out. (C1, E-0370)
GameMode6_Update_ChooseMonster_NoRuleBox::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing the monster to switch, step 7: draws the cursor mark at the list entry, redraws and
; clears it again. (C1, E-0357)
GameMode6_Update_ChooseMonster_ShowCursorMark::
    ld a, [wListCursor]
    ld b, $bb
    ld hl, GameMode6_Update_ChooseMonster_ShowCursorMark_Data
    call StoreBAtWordTableEntry_Bank24_2
    call BGMapAddressAtScroll_Bank24
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_24
    ld a, [wListCursor]
    ld b, $c3
    ld hl, GameMode6_Update_ChooseMonster_ShowCursorMark_Data
    call StoreBAtWordTableEntry_Bank24_2
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; (E-0345: was GameMode6_Update_PageList) moves the paged cursor, copies a rectangle and sets the
; sub-step
GameMode6_Update_PageList::
    ld a, [wScreenSubStep]
    jumptable
    dw GameMode6_Update_PageList_Cursor
    dw GameMode6_Update_PageList_Cancel
    dw GameMode6_Update_PageList_BackToCursor

; The switch list's cursor (sub-step 0): a page change goes back seven steps, $FD back four, B to
; sub-step 1; A, when the pick would leave the party empty, 'You'll be left with no monster.'
; (string $12, sub-step 2); otherwise marks the entry, copies its name and goes on. (C1, E-0357)
GameMode6_Update_PageList_Cursor::
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
    jr z, .check_screen_sub_step
    cp $ff
    jr z, .call_game_mode6_update_page_list_would_empty
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

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.call_game_mode6_update_page_list_would_empty:
    call GameMode6_Update_PageList_WouldEmptyParty
    cp $ff
    jr nz, .read_list_cursor
    ld a, $02
    ld [wScreenSubStep], a
    ld a, $12
    call ShowStringAInDefaultWindow_Bank24
    ret

.read_list_cursor:
    ld a, [wListCursor]
    ld b, $bc
    ld hl, GameMode6_Update_ChooseMonster_ShowCursorMark_Data
    call StoreBAtWordTableEntry_Bank24_2
    farcall CopyListEntriesCell5NameToTextBuf0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The switch list's B (sub-step 1): redraws the boxes, resets the list and asks 'Switch with which?'
; (string 7) again at the Monster / Egg choice (state 2, step 8). (C1, E-0357)
GameMode6_Update_PageList_Cancel::
    ld de, GameMode6_Update_PageList_Cancel_TileRect_2
    ld hl, wWindowTileBuffer + $64
    lb bc, $0e, $0d
    call CopyRectTo20ByteRowsJp_Bank24
    ld a, [wTwoChoiceCursor]
    ld b, $bb
    ld hl, GameMode6_Update_TakePrize_MonsterEggChoice_Data
    call StoreBAtWordTableEntry_Bank24_2
    ld a, [wBattleScene]
    cp $08
    jr nz, .check_link_breed_result
    ld de, GameMode6_Update_DrawResultBox_Data
    ld hl, wWindowTileBuffer + $f7
    lb bc, $06, $06
    call CopyRectTo20ByteRowsJp_Bank24
    jr .skip

.check_link_breed_result:
    ld a, [wLinkBreedResult]
    and a
    jr nz, .skip
    ld de, GameMode6_Update_PageList_Cancel_TileRect
    ld hl, wWindowTileBuffer + $7a
    lb bc, $11, $02
    call CopyRectTo20ByteRowsJp_Bank24

.skip:
    ld de, GameMode6_Update_TakePrize_DrawMonsterEggChoice_TileRect
    ld hl, wWindowTileBuffer + $10e
    lb bc, $0a, $05
    call CopyRectTo20ByteRowsJp_Bank24
    call BGMapAddressAtScroll_Bank24
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_24
    ld a, [wTwoChoiceCursor]
    ld b, $c3
    ld hl, GameMode6_Update_TakePrize_MonsterEggChoice_Data
    call StoreBAtWordTableEntry_Bank24_2
    xor a
    ld [wScreenSubStep], a
    ld [wListPageIndex], a
    ld [wListCursor], a
    ld a, $07
    call ShowStringAInDefaultWindow_Bank24
    ld a, $02
    ld [wScreenState], a
    ld a, $08
    ld [wScreenStep], a
    ret

; The switch list, sub-step 2 (after 'You'll be left with no monster.'): back to the cursor,
; sub-step 0 (GameMode6_Update_PageList_Cursor). GameMode6_Update itself does nothing while
; wTextFlags is set, so this runs once the message is done. (C1, E-0370)
GameMode6_Update_PageList_BackToCursor::
    xor a
    ld [wScreenSubStep], a
    ret

; Choosing the monster to switch, step 10: the 'Info / OK' choice: B goes on one step; Info opens
; the stats screen (state $0C) returning here; OK on the only party member (fewer than two, first
; entry) gives 'You'll be left with no monster.', otherwise '<name> was released.' (string $0A) and
; on two steps. (C1, E-0357)
GameMode6_Update_ChooseMonster_InfoOrOK::
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
    jr nz, .check_party_count
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

.check_party_count:
    ld a, [wPartyCount]
    cp $02
    jr nc, .call_game_mode6_update_choose_monster_info_or
    ld a, [wListPageIndex]
    and a
    jr nz, .call_game_mode6_update_choose_monster_info_or
    ld a, [wListCursor]
    and a
    jr nz, .call_game_mode6_update_choose_monster_info_or
    ld a, $12
    call ShowStringAInDefaultWindow_Bank24
    jr .check_screen_step

.call_game_mode6_update_choose_monster_info_or:
    call GameMode6_Update_ChooseMonster_InfoOrOK_CopyName
    ld a, $0a
    call ShowStringAInDefaultWindow_Bank24
    ld a, [wScreenStep]
    add $02
    ld [wScreenStep], a
    ret

; Choosing the monster to switch, step 11: redraws the choice box and goes back three steps to the
; list. (C1, E-0357)
GameMode6_Update_ChooseMonster_RedrawChoiceBox::
    ld de, GameMode6_Update_ChooseMonster_RedrawChoiceBox_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRowsJp_Bank24
    xor a
    ld b, $bc
    ld hl, GameMode6_Update_TakePrize_MonsterEggChoice_Data
    call StoreBAtWordTableEntry_Bank24_2
    call GameMode6_Update_ShowMonsterEg
    call BGMapAddressAtScroll_Bank24
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_24
    ld a, [wListCursor]
    ld b, $c3
    ld hl, GameMode6_Update_ChooseMonster_ShowCursorMark_Data
    call StoreBAtWordTableEntry_Bank24_2
    ld a, [wScreenStep]
    sub $03
    ld [wScreenStep], a
    ret

; Choosing the monster to switch, step 12: deletes the chosen SRAM record
; (DeleteSRAMRecordAndCompact), writes the prize (wRecordBufB) at record wArg5, sets its species
; flag and resets the save steps. (C1, E-0357)
GameMode6_Update_ChooseMonster_SwitchForPrize::
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wArg1], a
    xor a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    ld a, [wArg5]
    ld c, $a5
    call Multiply8
    ld de, sRecords
    add hl, de
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld b, $a5
    ld de, wRecordBufB

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop
    ld a, [wRecordBufB + MON_SPECIES]
    ld [wSpeciesIdLo], a
    ld a, [wRecordBufB + MON_SPECIES + 1]
    ld [wSpeciesIdHi], a
    farcall SetSpeciesFlag
    xor a
    ld [rRAMG], a
    ld [rRAMB], a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing the monster to switch, step 13: saves, then ends the screen. (C1, E-0357)
GameMode6_Update_ChooseMonster_Save::
    farcall RunSaveGameSteps
    ld a, [wSaveStep]
    bit 7, a
    ret z
    call GameMode6_Update_EndMode
    ret

; by wScreenStep: a paged record list, the 'Info / OK / Yes / No' window, the monster-egg message
; and RunSaveGameSteps (renamed from GameMode6_Update_ChooseRecordAndSave from its E-0357 note,
; E-0367)
GameMode6_Update_ChooseEgg::
    ld a, [wScreenStep]
    jumptable
    dw GameMode6_Update_ChooseEgg_ClearTiles
    dw GameMode6_Update_ChooseEgg_DrawListBox
    dw GameMode6_Update_ChooseEgg_DrawPageFrame
    dw GameMode6_Update_ChooseEgg_DrawSpeciesNames
    dw GameMode6_Update_ChooseEgg_DrawMarks
    dw GameMode6_Update_ChooseEgg_ListCursor
    dw GameMode6_Update_ChooseEgg_Cancel
    dw GameMode6_Update_ChooseEgg_ShowInfoOKYesN
    dw GameMode6_Update_ChooseEgg_InfoOrOK
    dw GameMode6_Update_ChooseEgg_RedrawChoiceBox
    dw GameMode6_Update_ChooseEgg_SwitchForPrize
    dw GameMode6_Update_ChooseEgg_Save

; Choosing the egg to switch, step 0: clears the egg list's tile areas and resets the text window
; (GameMode6_Update_ClearEggListTiles), then goes to step 1. (C1, E-0370)
GameMode6_Update_ChooseEgg_ClearTiles::
    call GameMode6_Update_ClearEggListTiles
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing the egg to switch, step 1: copies the 13 x 9 list box. (C1, E-0357)
GameMode6_Update_ChooseEgg_DrawListBox::
    ld de, GameMode6_Update_ChooseEgg_DrawListBox_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $0d, $09
    call CopyRectTo20ByteRowsJp_Bank24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing the egg to switch, step 2: clamps the page cursor of four and, with two or more pages,
; draws the page arrows and numbers. (C1, E-0357)
GameMode6_Update_ChooseEgg_DrawPageFrame::
    farcall ClampRecordListPageCursor4
    ld a, [wListPages]
    cp $02
    jr c, .call_bg_map_address_at_scroll_bank24
    ld hl, wWindowTileBuffer + $10b
    call StoreC5BEC6AtHLStride2_Bank24
    ld hl, wWindowTileBuffer + $10c
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    farcall DrawPageOfPagesAtArg1_Bank1E

.call_bg_map_address_at_scroll_bank24:
    call BGMapAddressAtScroll_Bank24
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing the egg to switch, step 3: draws the page's species names. (C1, E-0357)
GameMode6_Update_ChooseEgg_DrawSpeciesNames::
    xor a
    ld [wArg5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing the egg to switch, step 4: loads the mark tiles and draws the page's marks. (C1, E-0357)
GameMode6_Update_ChooseEgg_DrawMarks::
    ld de, Tiles2Plus420Tiles
    ld hl, vTiles1 + $4e0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a
    ld [wArg1], a
    ld a, $02
    ld [wArg2], a
    farcall DrawRecordListPageMarks
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing the egg to switch, step 5: the list cursor: a page change goes back five steps, B on one,
; A marks the entry, copies its name and goes on two. (C1, E-0357)
GameMode6_Update_ChooseEgg_ListCursor::
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
    jr z, .return
    cp $fe
    jr z, .check_screen_step
    cp $ff
    jr z, .read_list_cursor
    ret

.read_screen_step:
    ld a, [wScreenStep]
    sub $05
    ld [wScreenStep], a
    ret

.return:
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.read_list_cursor:
    ld a, [wListCursor]
    ld b, $bc
    ld hl, GameMode6_Update_ChooseMonster_ShowCursorMark_Data
    call StoreBAtWordTableEntry_Bank24_2
    farcall CopyListEntriesCell5NameToTextBuf0
    ld a, [wScreenStep]
    add $02
    ld [wScreenStep], a
    ret

; Choosing the egg to switch, step 6 (B): clears the choice mark and goes through the monster list's
; B (state 4, step 8, sub-step 1) back to the Monster / Egg choice. (C1, E-0357)
GameMode6_Update_ChooseEgg_Cancel::
    ld a, [wTwoChoiceCursor]
    ld b, $c3
    ld hl, GameMode6_Update_TakePrize_MonsterEggChoice_Data
    call StoreBAtWordTableEntry_Bank24_2
    ld a, $04
    ld [wScreenState], a
    ld a, $08
    ld [wScreenStep], a
    ld a, $01
    ld [wScreenSubStep], a
    xor a
    ld [wListPageIndex], a
    ld [wListCursor], a
    ret

; Choosing the egg to switch, step 7: shows 'Info / OK' (bank-$33 string $0D) in its 8 x 5 box with
; sound $6C and the cursor on Info. (C1, E-0357)
GameMode6_Update_ChooseEgg_ShowInfoOKYesN::
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
    ld a, $0d
    ld [wStringIndex], a ; 'InfoOKYesN'
    farcall ShowString_Bank33_2
    ld a, $6c
    call QueueSoundEffect
    ld de, GameMode6_Update_ChooseEgg_ShowInfoOKYesN_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRowsJp_Bank24
    call BGMapAddressAtScroll_Bank24
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_24
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

; Choosing the egg to switch, step 8: B goes on one step; Info opens the stats screen (state $0D)
; returning here; OK copies the egg's species name (its record's MON_SPECIES word) and shows '<name>
; was released.' (string $0A), on two steps. (C1, E-0357)
GameMode6_Update_ChooseEgg_InfoOrOK::
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
    jr nz, .call_set_arg5_to_list_entries_cell4
    ld a, [wScreenState]
    ld [wReturnScreenState], a
    ld a, [wScreenStep]
    ld [wReturnScreenStep], a
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0d
    ld [wScreenState], a
    ret

.call_set_arg5_to_list_entries_cell4:
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    call GameMode6_Update_ChooseEgg_InfoOrOK_GetSpecies
    call CopyMonsterNameToBuffer_B24
    ld a, $0a
    call ShowStringAInDefaultWindow_Bank24
    ld a, [wScreenStep]
    add $02
    ld [wScreenStep], a
    ret

; Choosing the egg to switch, step 9: redraws the Monster / Egg box with Egg marked and goes back
; four steps to the list cursor. (C1, E-0357)
GameMode6_Update_ChooseEgg_RedrawChoiceBox::
    ld de, GameMode6_Update_ChooseEgg_RedrawChoiceBox_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRowsJp_Bank24
    ld a, $01
    ld b, $bc
    ld hl, GameMode6_Update_TakePrize_MonsterEggChoice_Data
    call StoreBAtWordTableEntry_Bank24_2
    call GameMode6_Update_ShowMonsterEg
    call BGMapAddressAtScroll_Bank24
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_24
    ld a, [wListCursor]
    ld b, $c3
    ld hl, GameMode6_Update_ChooseMonster_ShowCursorMark_Data
    call StoreBAtWordTableEntry_Bank24_2
    ld a, [wScreenStep]
    sub $04
    ld [wScreenStep], a
    ret

; Choosing the egg to switch, step 10: deletes the chosen egg's SRAM record
; (DeleteSRAMRecordAndCompact), writes the prize (wRecordBufB) at record wArg5, sets its species
; flag and resets the save steps. (C1, E-0357)
GameMode6_Update_ChooseEgg_SwitchForPrize::
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wArg1], a
    xor a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    ld a, [wArg5]
    ld c, $a5
    call Multiply8
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld de, sRecords
    add hl, de
    ld b, $a5
    ld de, wRecordBufB

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop
    ld a, [wRecordBufB + MON_SPECIES]
    ld [wSpeciesIdLo], a
    ld a, [wRecordBufB + MON_SPECIES + 1]
    ld [wSpeciesIdHi], a
    farcall SetSpeciesFlag
    xor a
    ld [rRAMG], a
    ld [rRAMB], a
    xor a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Choosing the egg to switch, step 11: saves, then ends the screen. (C1, E-0357)
GameMode6_Update_ChooseEgg_Save::
    farcall RunSaveGameSteps
    ld a, [wSaveStep]
    bit 7, a
    ret z
    call GameMode6_Update_EndMode
    ret

; Game mode 6, states 6-11: a bare ret, so those states do nothing; whether anything sets
; wScreenState to 6-11 in this mode is not read. (C1, E-0370)
GameMode6_Update_EmptyState::
    ret

; Game mode 6, state 12: runs the stats screen (SwapMonstersMenu) for the monster list until its
; step $0A, then state 15 (back to the monster list). (C1, E-0357)
GameMode6_Update_RunStatsScreen::
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

; Game mode 6, state 13: runs the stats screen for the egg list until its step $0A, then state 14
; (back to the egg list). (C1, E-0357)
GameMode6_Update_RunEggStatsScreen::
    farcall SwapMonstersMenu
    ld a, [wScreenStep]
    cp $0a
    ret nz
    xor a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; by wScreenStep: the 'Info / OK / Yes / No' window, the list of records with byte $6E set and
; 'Switch which egg?' (E-0293)
GameMode6_Update_SwitchEgg::
    ld a, [wScreenStep]
    jumptable
    dw GameMode6_Update_SwitchEgg_ShowInfoOKYesN
    dw GameMode6_Update_SwitchEgg_ListEggs
    dw GameMode6_Update_SwitchEgg_DrawSpeciesNames
    dw GameMode6_Update_SwitchEgg_DrawMarks
    dw GameMode6_Update_SwitchEgg_ShowSwitchWhichEgg
    dw GameMode6_Update_SwitchEgg_MarkAndReturn

; Back from the stats screen to the egg list, step 0: reloads the text tiles and 'Info / OK', clears
; the tile areas, redraws the boxes and marks the entry. (C1, E-0357)
GameMode6_Update_SwitchEgg_ShowInfoOKYesN::
    ld b, $46
    ld de, Tiles1Gfx
    ld hl, vTiles1
    call DecompressToVRAM
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
    ld a, $0d
    ld [wStringIndex], a ; 'InfoOKYesN'
    farcall ShowString_Bank33_2
    call GameMode6_Update_ClearEggListTiles
    ld a, [wBattleScene]
    cp $08
    jr nz, .call_game_mode6_update_draw_result_banner
    ld de, GameMode6_Update_DrawResultBox_Data
    ld hl, wWindowTileBuffer + $f7
    lb bc, $06, $06
    call CopyRectTo20ByteRowsJp_Bank24
    jr .skip

.call_game_mode6_update_draw_result_banner:
    call GameMode6_Update_DrawResultBanner

.skip:
    ld de, GameMode6_Update_ChooseEgg_DrawListBox_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $0d, $09
    call CopyRectTo20ByteRowsJp_Bank24
    ld a, [wListCursor]
    ld b, $bb
    ld hl, GameMode6_Update_ChooseMonster_ShowCursorMark_Data
    call StoreBAtWordTableEntry_Bank24_2
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Back to the egg list, step 1: lists the eggs, clamps the page cursor of four and draws the page
; arrows and numbers when there are two or more pages. (C1, E-0357)
GameMode6_Update_SwitchEgg_ListEggs::
    farcall ListRecordsInUseEggs
    farcall ClampRecordListPageCursor4
    ld a, [wListPages]
    cp $02
    jr c, .check_screen_step
    ld hl, wWindowTileBuffer + $10b
    call StoreC5BEC6AtHLStride2_Bank24
    ld hl, wWindowTileBuffer + $10c
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

; Back to the egg list, step 2: draws the page's species names. (C1, E-0357)
GameMode6_Update_SwitchEgg_DrawSpeciesNames::
    xor a
    ld [wArg5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Back to the egg list, step 3: loads the mark tiles and draws the page's marks. (C1, E-0357)
GameMode6_Update_SwitchEgg_DrawMarks::
    ld de, Tiles2Plus420Tiles
    ld hl, vTiles1 + $4e0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $01
    ld [wArg1], a
    ld a, $02
    ld [wArg2], a
    farcall DrawRecordListPageMarks
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Back to the egg list, step 4: draws the Info / OK box and 'Switch which egg?' (string 9). (C1,
; E-0357)
GameMode6_Update_SwitchEgg_ShowSwitchWhichEgg::
    ld de, GameMode6_Update_ChooseEgg_ShowInfoOKYesN_TileRect
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRowsJp_Bank24
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
    ld a, $09
    ld [wStringIndex], a ; 'Switch which egg?'
    farcall ShowString_Bank33_2
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Back to the egg list, step 5: marks the entry, redraws the screen and the bottom rows, restores
; hide tile $70 and returns to the saved state and step; in game mode 5 outside link session 8,
; state $11 step 8 instead. (C1, E-0357)
GameMode6_Update_SwitchEgg_MarkAndReturn::
    ld a, [wListCursor]
    ld b, $bc
    ld hl, GameMode6_Update_ChooseMonster_ShowCursorMark_Data
    call StoreBAtWordTableEntry_Bank24_2
    call BGMapAddressAtScroll_Bank24
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_24
    call BGMapAddressAtScroll_Bank24
    ld de, $01a0
    add hl, de
    lb bc, $14, $05
    ld de, $0168
    call DrawScreenBufferRectToBGMap_24
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
    ld a, [wGameMode]
    cp $05
    ret nz
    ld a, [wLinkSession]
    cp $08
    ret z
    ld a, $08
    ld [wScreenStep], a
    ld a, $11
    ld [wScreenState], a
    ret

; by wScreenStep: the 'Info / OK / Yes / No' window, a record list and 'Switch with which?' (E-0292)
GameMode6_Update_SwitchMonster::
    ld a, [wScreenStep]
    jumptable
    dw GameMode6_Update_SwitchMonster_ShowInfoOKYesN
    dw GameMode6_Update_SwitchMonster_ListMonsters
    dw GameMode6_Update_SwitchMonster_DrawNames
    dw GameMode6_Update_SwitchMonster_RunListStep
    dw GameMode6_Update_SwitchMonster_RunListStep
    dw GameMode6_Update_SwitchMonster_NoRuleBox
    dw GameMode6_Update_SwitchMonster_RunListStep
    dw GameMode6_Update_SwitchMonster_ShowSwitchWithWhich

; Back from the stats screen to the monster list, step 0: reloads the text tiles and 'Info / OK',
; clears the tile areas, redraws the boxes (for a link battle with the chosen monster's picture) and
; marks the entry. (C1, E-0357)
GameMode6_Update_SwitchMonster_ShowInfoOKYesN::
    ld b, $46
    ld de, Tiles1Gfx
    ld hl, vTiles1
    call DecompressToVRAM
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
    ld a, $0d
    ld [wStringIndex], a ; 'InfoOKYesN'
    farcall ShowString_Bank33_2
    call GameMode6_Update_SwitchMonster_ClearTiles
    ld a, [wBattleScene]
    cp $08
    jr z, .check_battle_scene
    call GameMode6_Update_DrawResultBanner

.check_battle_scene:
    ld a, [wBattleScene]
    cp $08
    jr z, .skip
    call GameMode6_Update_SwitchMonster_LoadPicture
    jr .skip2

.skip:
    ld de, GameMode6_Update_DrawResultBox_Data
    ld hl, wWindowTileBuffer + $f7
    lb bc, $06, $06
    call CopyRectTo20ByteRowsJp_Bank24

.skip2:
    ld de, GameMode6_Update_SwitchMonster_ShowInfoOKYesN_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $0b
    call CopyRectTo20ByteRowsJp_Bank24
    ld a, [wListCursor]
    ld b, $bc
    ld hl, GameMode6_Update_ChooseMonster_ShowCursorMark_Data
    call StoreBAtWordTableEntry_Bank24_2
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Back to the monster list, step 1: lists the monsters that are not eggs, clamps the page cursor of
; five and draws the page arrows and numbers when there are two or more pages. (C1, E-0357)
GameMode6_Update_SwitchMonster_ListMonsters::
    farcall ListRecordsInUseNotEggs
    farcall ClampRecordListPageCursor5
    ld a, [wListPages]
    cp $02
    jr c, .check_screen_step
    ld hl, wWindowTileBuffer + $12e
    call StoreC5BEC6AtHLStride2_Bank24
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

; Back to the monster list, step 2: draws the page's names and marks the party members. (C1, E-0357)
GameMode6_Update_SwitchMonster_DrawNames::
    farcall DrawRecordListPageNames
    xor a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    ret

; Back to the monster list, steps 3, 4 and 6: far-calls LinkBattleSetupMenu, which with wScreenState
; = $0F runs EggServiceMenu_Bank1B_ListAvailableRecords2 at the same wScreenStep:
; LinkBattleSetupMenu_DrawCursorPanel (3),
; EggServiceMenu_CallClearAndDrawListEntriesCell5NameAtTiles1780 (4) and
; EggServiceMenu_Bank1B_ListAvailableRecords2_ShowInfoOKYesN (6). (C1, E-0370)
GameMode6_Update_SwitchMonster_RunListStep::
    farcall LinkBattleSetupMenu
    ret

; Back to the monster list, step 5: only advances wScreenStep, in place of step 5 of
; EggServiceMenu_Bank1B_ListAvailableRecords2 (LinkBattleSetupMenu_DrawPicksBox, the rule box). (C1,
; E-0370)
GameMode6_Update_SwitchMonster_NoRuleBox::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Back to the monster list, step 7: clears the text window, shows 'Switch with which?' (string 8)
; and runs the list's steps. (C1, E-0357)
GameMode6_Update_SwitchMonster_ShowSwitchWithWhich::
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
    ld a, $08
    ld [wStringIndex], a ; 'Switch with which?'
    xor a
    ld [wStringCategory], a
    farcall ShowString_Bank33_2
    farcall LinkBattleSetupMenu
    ret

; Unless wLinkBreedResult is set: decompresses GameMode6_Init_Data1 into vTiles2
; (GameMode6_Update_LoadBannerTiles, entered with A = 0) and copies the 17 x 2 rectangle
; GameMode6_Update_PageList_Cancel_TileRect (tiles $00-$1F) to wWindowTileBuffer + $7A, where
; GameMode6_Update_ShowResult draws the result banner. Used by
; GameMode6_Update_TakePrize_RedrawBoxes, GameMode6_Update_SwitchEgg_ShowInfoOKYesN and
; GameMode6_Update_SwitchMonster_ShowInfoOKYesN. (C1, E-0370)
GameMode6_Update_DrawResultBanner::
    ld a, [wLinkBreedResult]
    and a
    ret nz
    call GameMode6_Update_LoadBannerTiles
    ld de, GameMode6_Update_PageList_Cancel_TileRect
    ld hl, wWindowTileBuffer + $7a
    lb bc, $11, $02
    call CopyRectTo20ByteRowsJp_Bank24
    ret

; On the GBC loads background palette 7 (BGPI $B8, auto-increment; 8 bytes) and $1C attribute bytes
; for the result banner. (C1, E-0357)
GameMode6_Update_ShowResult_WaitForVRAMAccess::
    ld a, [wIsCGB]
    and a
    ret z
    ld hl, rBGPI
    di
    call WaitForVRAMAccess
    ld a, $b8
    ld [hli], a
    ei
    ld de, GameMode6_Update_ShowResult_WaitForVRAMAccess_Data2
    ld b, $08

.loop:
    di
    call WaitForVRAMAccess
    ld a, [de]
    ld [hl], a
    ei
    inc de
    dec b
    jr nz, .loop
    ld de, GameMode6_Update_ShowResult_WaitForVRAMAccess_Data1
    ld hl, wWindowAttrBuffer + $7b
    ld b, $1c

.loop2:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop2
    ret

; Shows 'Yes / No' (bank-$33 string $0C) in a 3 x 1 window at VRAM $96D0 and resets the text window.
; (C1, E-0357)
GameMode6_Update_TakePrize_ShowYesNo::
    ld hl, vTiles2 + $6d0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0301
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a
    ld [wStringCategory], a
    ld a, $0c
    ld [wStringIndex], a ; 'YesNo'
    farcall ShowString_Bank33_2
    xor a
    ld [wTextFlags], a
    ld [wTextControl], a
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

; Shows 'Monster / Egg' (bank-$33 string $0B) in a 7 x 1 window at VRAM $9760 and resets the text
; window. (C1, E-0357)
GameMode6_Update_ShowMonsterEg::
    ld hl, vTiles2 + $760
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0701
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a
    ld [wStringCategory], a
    ld a, $0b
    ld [wStringIndex], a ; 'MonsterE?g'
    farcall ShowString_Bank33_2
    xor a
    ld [wTextFlags], a
    ld [wTextControl], a
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

; Ends game mode 6: clears $6F bytes of screen state from wScreenState, the link scene, and switches
; to game mode 5, state 1 (the link menu). (C1, E-0357)
GameMode6_Update_EndMode::
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
    ld [wLinkScene], a
    ld a, $05
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    ld a, $01
    ld [wModeChangeRequest], a
    ld a, [wBattleScene]
    cp $08
    ret nz
    ret

; the same steps as CopyRectTo20ByteRows (copy a B x C rectangle from DE to HL with rows 20 bytes
; apart; on CGB zero-fill the same rectangle at HL + $0E68 with rSVBK = 2) but encoded with jp
; instead of jr, so its bytes differ (E-0066)
CopyRectTo20ByteRowsJp_Bank24::
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
DrawScreenBufferRectToBGMap_24::
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
; hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks) (E-0353)
BGMapAddressAtScroll_Bank24::
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
CopyBytesDEToHL_Bank24_2::
    ld a, [de]
    inc de
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, CopyBytesDEToHL_Bank24_2
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same
; 19 bytes appear in 5 banks) (E-0353)
CopyLow3BitsToWRAMBank2_Bank24_2::
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

; wStringIndex = A, wStringCategory = 0, string window = vTiles1 with size word $1202 (as
; SetDefaultStringWindow), then far-calls BeginStringDisplay_Bank33_2 (E-0072)
ShowStringAInDefaultWindow_Bank24::
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
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
    farcall BeginStringDisplay_Bank33_2
    ret

; HL = wRecordBufB + $1, then copies up to 10 name bytes to wTextBuf0 with a $F0 terminator (E-0124)
; (E-0340: the address in its name read as its RAM name; was CopyRecordBufBNameNameToTextBuf0)
CopyRecordBufBNameNameToTextBuf0::
    ld hl, wRecordBufB + MON_NAME
    jp CopyNameAtHLToTextBuf0

; copies up to 10 name bytes from wRecordBufA + $1 (stopping at $F0) to wTextBuf0 with a $F0
; terminator (E-0124) (E-0340: the address in its name read as its RAM name; was
; CopyRecordBufANameNameToTextBuf0)
CopyRecordBufANameNameToTextBuf0::
    ld hl, wRecordBufA + MON_NAME

; Copies the name at HL (up to ten bytes, stopping at $F0) to wTextBuf0 and ends it with $F0. (C1,
; E-0357)
CopyNameAtHLToTextBuf0::
    ld de, wTextBuf0
    ld b, $0a

.loop:
    ld a, [hl]
    cp $f0
    jr z, .done
    ld [de], a
    inc de
    inc hl
    dec b
    jr nz, .loop

.done:
    ld a, $f0
    ld [de], a
    ret

; Returns $FF when the pick would leave the party empty (fewer than two party members and the cursor
; on page 0's first entry), otherwise 0. (C1, E-0357)
GameMode6_Update_PageList_WouldEmptyParty::
    ld a, [wPartyCount]
    cp $02
    jr nc, .return_0
    ld a, [wListCursor]
    and a
    jr nz, .return_0
    ld a, [wListPageIndex]
    and a
    jr nz, .return_0
    ld a, $ff
    ret

.return_0:
    xor a
    ret

; HL = list entry address: returns HL = the MON_SPECIES word of the SRAM record numbered by the byte
; at HL (SRAM enabled through rRAMG for the read and disabled after).
; GameMode6_Update_ChooseEgg_InfoOrOK passes it to CopyMonsterNameToBuffer_B24 for the egg's message
; (string $0A). (C1, E-0370)
GameMode6_Update_ChooseEgg_InfoOrOK_GetSpecies::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $a5
    call Multiply8
    ld de, sRecords
    add hl, de
    ld a, $0b
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld d, [hl]
    ld h, d
    ld l, e
    xor a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

; HL = string number; copies 16 bytes of that string of StringTable_MonsterNames (bank $08, via
; wDataBank) to wNameGlyphBuf; wDataBank is restored (E-0026)
CopyMonsterNameToBuffer_B24::
    push hl
    ld a, [wDataBank]
    push af
    ld a, $08
    ld [wDataBank], a
    ld hl, StringDatabase
    ld a, $04
    add_a_to_hl
    call ReadWordFromDataBank
    ld a, b
    ld e, a
    ld a, c
    ld b, a
    ld a, e
    ld c, a
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
    ld hl, wTextBuf0
    ld b, $08
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; Copies the name (MON_NAME) of the list entry under the cursor (SetArg5ToListEntriesCell5:
; wListEntries + 5 * wListPageIndex + wListCursor) into wTextBuf0 up to its $F0 and ends it with
; $F0, for the message GameMode6_Update_ChooseMonster_InfoOrOK then shows (string $0A). It enables
; SRAM through rRAMG and does not disable it again. (C1, E-0370)
GameMode6_Update_ChooseMonster_InfoOrOK_CopyName::
    ld a, $0a
    ld [rRAMG], a
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
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0

.skip:
    ld a, [hl]
    cp $f0
    jr z, .done
    ld [de], a
    inc hl
    inc de
    jr .skip

.done:
    ld a, $f0
    ld [de], a
    ret

; Fills tile areas with the blank pattern through FillTilesFromRequest: 15 tiles at vTiles1 + $500,
; 5 at + $700, 5 at + $780, 3 at + $240 and 2 at + $4E0; the text window bytes (wTextWindowTileLo to
; wTextWindowWidth) are left on the last area. (C1, E-0370)
GameMode6_Update_SwitchMonster_ClearTiles::
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
    ret

; Decompresses into vTiles2 ($9000) by A bit 0: clear GameMode6_Init_Data1, set Tiles1Plus600Gfx
; (both in bank $24). Its only caller, GameMode6_Update_DrawResultBanner, enters with A = 0. (C1,
; E-0370)
GameMode6_Update_LoadBannerTiles::
    and $01
    and a
    jr nz, .skip
    ld de, GameMode6_Init_Data1
    ld b, $24
    jr .call_decompress_to_vram

.skip:
    ld de, Tiles1Plus600Gfx
    ld b, $24

.call_decompress_to_vram:
    ld hl, vTiles2
    call DecompressToVRAM
    ret

; Called by GameMode6_Init after GameMode6_Init_LoadBattlerPictures; returns at once when
; wBattleScene is $08. On the GBC, for each shown battler (wSharedMenuWork 1-3; species from
; wBattlerRecords, wBattlerRecordSlot1 and wBattlerRecordSlot2, or the slots 4-6 when wLinkScene is
; set) requests and uploads the BG palettes (wBGPaletteUploadRequest = $7F, UploadBGPalettes) and
; writes the picture's attributes with hTemp0 = 1, 3, 5 at the BG map position from
; GameMode6_Init_PicturePosition (LoadMonsterPictureAttributes). Then draws the 20 x 6 picture row
; (GameMode6_Init_DrawPictureRow). Its egg branch (GameMode6_Init_DrawEggPicture for wBattleScene
; $08) is not reached from this entry, since the routine has already returned for $08. (C1, E-0370)
GameMode6_Init_ColorAndDrawPictures::
    ld a, [wBattleScene]
    cp $08
    ret z
    ld a, [wIsCGB]
    and a
    jp z, .check_battle_scene
    ld hl, wBattlerRecords + BATTLER_SPECIES
    ld de, wBattlerRecordSlot4 + BATTLER_SPECIES
    call GameMode6_Init_SelectBattlerSide
    ld a, [hli]
    ld e, a
    ld d, [hl]
    push de
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes
    ld a, $01
    ldh [hTemp0], a
    call BGMapAddressAtScroll_Bank24
    xor a
    call GameMode6_Init_PicturePosition
    add hl, de
    pop de
    call LoadMonsterPictureAttributes
    ld a, [wSharedMenuWork]
    cp $01
    jr z, .check_battle_scene
    ld hl, wBattlerRecordSlot1 + BATTLER_SPECIES
    ld de, wBattlerRecordSlot5 + BATTLER_SPECIES
    call GameMode6_Init_SelectBattlerSide
    ld a, [hli]
    ld e, a
    ld d, [hl]
    push de
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes
    ld a, $03
    ldh [hTemp0], a
    call BGMapAddressAtScroll_Bank24
    ld a, $02
    call GameMode6_Init_PicturePosition
    add hl, de
    pop de
    call LoadMonsterPictureAttributes
    ld a, [wSharedMenuWork]
    cp $02
    jr z, .check_battle_scene
    ld hl, wBattlerRecordSlot2 + BATTLER_SPECIES
    ld de, wBattlerRecordSlot6 + BATTLER_SPECIES
    call GameMode6_Init_SelectBattlerSide
    ld a, [hli]
    ld e, a
    ld d, [hl]
    push de
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes
    ld a, $05
    ldh [hTemp0], a
    call BGMapAddressAtScroll_Bank24
    ld a, $04
    call GameMode6_Init_PicturePosition
    add hl, de
    pop de
    call LoadMonsterPictureAttributes

.check_battle_scene:
    ld a, [wBattleScene]
    cp $08
    jp nz, GameMode6_Init_DrawPictureRow
    ld hl, wWindowTileBuffer + $f7
    call GameMode6_Init_DrawEggPicture
    ld hl, wScreenTileBuffer + $93

; HL = a buffer with 20-byte rows: writes tile numbers $20-$43 there as a 6 x 6 block, then the same
; block into vBGMap0 + $E7 (WriteVRAMByteInc, rows 32 bytes apart), then ReturnStub. The egg branch
; of GameMode6_Init_ColorAndDrawPictures calls it with HL = wWindowTileBuffer + $F7 and falls into
; it with wScreenTileBuffer + $93; that branch is not reached (see there). (C1, E-0370)
GameMode6_Init_DrawEggPicture::
    ld bc, $0606
    ld d, $20

.loop:
    ld [hl], d
    inc d
    inc hl
    dec b
    jr nz, .loop
    ld b, $06
    ld a, l
    add $0e
    ld l, a
    ld a, h
    adc $00
    ld h, a
    dec c
    jr nz, .loop
    ld hl, vBGMap0 + $e7
    ld bc, $0606
    ld d, $20

.loop2:
    ld a, d
    call WriteVRAMByteInc
    inc d
    dec b
    jr nz, .loop2
    ld a, l
    add $1a
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld b, $06
    dec c
    jr nz, .loop2
    call ReturnStub
    ret

; Draws the 20 x 6 tile rectangle for wSharedMenuWork battlers (entry wSharedMenuWork - 1, $78 bytes
; each, of the table after it) at BG map offset $E0 from the scroll origin
; (DrawTileRectFromArg1Params with wArg7 = 1). (C1, E-0370)
GameMode6_Init_DrawPictureRow::
    call BGMapAddressAtScroll_Bank24
    ld de, $00e0
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld a, [wSharedMenuWork]
    dec a
    ld c, $78
    call Multiply8
    ld de, GameMode6_Init_WriteVRAMByteInc_CallBGMapAddressAtScroll_Bank24_TileRect
    add hl, de
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    ld a, $14
    ld [wArg3], a
    ld a, $06
    ld [wArg4], a
    ld a, $01
    ld [wArg7], a
    farcall DrawTileRectFromArg1Params
    ret

; A = byte offset 0, 2 or 4 (the battler): returns DE = the word at that offset of the position
; table for wSharedMenuWork battlers (1: $E7; 2: $E4, $EA; 3: $E1, $E7, $ED), the BG map offset of
; that picture; HL kept. (C1, E-0370)
GameMode6_Init_PicturePosition::
    push hl
    ld e, a
    ld d, $00
    ld a, [wSharedMenuWork]
    dec a
    ld hl, GameMode6_Init_PicturePosition_Data1
    jr z, .skip
    dec a
    ld hl, GameMode6_Init_PicturePosition_Data2
    jr z, .skip
    ld hl, GameMode6_Init_PicturePosition_Data3

.skip:
    add hl, de
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    pop hl
    ret

; data read by GameMode6_Init_PicturePosition (6 bytes) (E-0347)
GameMode6_Init_PicturePosition_Data1::
    db $e7, $00, $00, $00, $00, $00

GameMode6_Init_PicturePosition_Data2::
    db $e4, $00, $ea, $00, $00, $00

GameMode6_Init_PicturePosition_Data3::
    db $e1, $00, $e7, $00, $ed, $00

; a bare ret (E-0115) (E-0344: the address in its name dropped or read as the label there; was
; ReturnStub)
ReturnStub::
    ret

; on CGB with wBattleScene = 8: copies the 6 x 6 block CopyAttributeBlockToBattlerRecordSlot64_Data
; into the WRAM-bank-2 buffer at wWindowAttrBuffer + $F7 (20-byte rows) (E-0124) (E-0340: the
; address in its name read as its RAM name; was CopyAttributeBlockToBattlerRecordSlot64) (E-0344:
; the address in its name dropped or read as the label there; was
; CopyAttributeBlockToBattlerRecordSlot64)
CopyAttributeBlockToBattlerRecordSlot64::
    ld a, [wIsCGB]
    and a
    ret z
    ld a, [wBattleScene]
    cp $08
    ret nz
    ld hl, CopyAttributeBlockToBattlerRecordSlot64_Data
    ld de, wWindowAttrBuffer + $f7
    ld a, $02
    ldh [rSVBK], a
    ld bc, $0606

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld b, $06
    ld a, e
    add $0e
    ld e, a
    ld a, d
    adc $00
    ld d, a
    dec c
    jr nz, .loop
    xor a
    ldh [rSVBK], a
    ret

; data read by CopyAttributeBlockToBattlerRecordSlot64 (E-0347)
CopyAttributeBlockToBattlerRecordSlot64_Data::
    ds $24, $01

; HL = DE when wLinkScene is set, else HL unchanged: picks which side's battler records to read.
; (C1, E-0357)
GameMode6_Init_SelectBattlerSide::
    ld a, [wLinkScene]
    and a
    jr nz, .done
    ret

.done:
    ld l, e
    ld h, d
    ret

; Loads the battlers' pictures (LoadMonsterPicture, DE = species, C = 1, 3, 5): for wBattleScene $08
; only the first battler, into vTiles2 + $200, with wSharedMenuWork = 1; otherwise the first into
; vTiles2 and, while the next species word is non-zero, the second into vTiles2 + $240 and the third
; into + $480, counting them (1-3) in wSharedMenuWork. Species come from wBattlerRecords,
; wBattlerRecordSlot1 and wBattlerRecordSlot2, or the slots 4-6 when wLinkScene is set
; (GameMode6_Init_SelectBattlerSide). (C1, E-0370)
GameMode6_Init_LoadBattlerPictures::
    ld a, [wBattleScene]
    cp $08
    jr nz, .call_game_mode6_init_select_battler_side
    ld hl, wBattlerRecords + BATTLER_SPECIES
    ld de, wBattlerRecordSlot4 + BATTLER_SPECIES
    call GameMode6_Init_SelectBattlerSide
    ld a, [hli]
    ld e, a
    ld d, [hl]
    ld hl, vTiles2 + $200
    ld c, $01
    call LoadMonsterPicture
    ld a, $01
    ld [wSharedMenuWork], a
    ret

.call_game_mode6_init_select_battler_side:
    ld hl, wBattlerRecords + BATTLER_SPECIES
    ld de, wBattlerRecordSlot4 + BATTLER_SPECIES
    call GameMode6_Init_SelectBattlerSide
    ld a, [hli]
    ld e, a
    ld d, [hl]
    ld hl, vTiles2
    ld c, $01
    call LoadMonsterPicture
    ld hl, wBattlerRecordSlot1 + BATTLER_SPECIES
    ld de, wBattlerRecordSlot5 + BATTLER_SPECIES
    call GameMode6_Init_SelectBattlerSide
    ld a, [hli]
    ld b, a
    ld a, [hld]
    or b
    and a
    jr nz, .skip
    ld a, $01
    ld [wSharedMenuWork], a
    ret

.skip:
    ld a, [hli]
    ld e, a
    ld d, [hl]
    ld hl, vTiles2 + $240
    ld c, $03
    call LoadMonsterPicture
    ld hl, wBattlerRecordSlot2 + BATTLER_SPECIES
    ld de, wBattlerRecordSlot6 + BATTLER_SPECIES
    call GameMode6_Init_SelectBattlerSide
    ld a, [hli]
    ld b, a
    ld a, [hld]
    or b
    and a
    jr nz, .skip2
    ld a, $02
    ld [wSharedMenuWork], a
    ret

.skip2:
    ld a, [hli]
    ld e, a
    ld d, [hl]
    ld hl, vTiles2 + $480
    ld c, $05
    call LoadMonsterPicture
    ld a, $03
    ld [wSharedMenuWork], a
    ret

; Loads the picture of the list entry under the cursor (its MON_SPECIES) into VRAM $9200. (C1,
; E-0357)
GameMode6_Update_SwitchMonster_LoadPicture::
    ld a, [wListPageIndex]
    ld b, a
    sla a
    sla a
    add b
    ld b, a
    ld a, [wListCursor]
    add b
    ld hl, wListEntries
    add_a_to_hl
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    push hl
    ld a, [hl]
    ld c, MON_SPECIES
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld e, a
    ldh a, [hTemp1]
    ld d, a
    push de
    ld hl, vTiles2 + $200
    ld c, $01
    call LoadMonsterPicture
    pop de
    pop hl
    xor a
    ld [rRAMG2], a
    ret

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for
; rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (E-0353: corrected; was: Copies 16 bytes
; from [HL] to [DE]; each byte is written with interrupts off after waiting for rSTAT bit 1 to
; clear; clobbers A; HL and DE advance) (the same 20 bytes appear in 3 banks)
CopyTileBytesToVRAM_Bank24_2::
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

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers
; A, DE, HL (the same 16 bytes appear in 4 banks) (E-0353)
StoreBAtWordTableEntry_Bank24_2::
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

; copies the $A5 bytes at DefaultMonsterRecord to wRecordBufB (E-0122)
CopyDefaultRecordToRecordBufB::
    ld hl, DefaultMonsterRecord
    ld de, wRecordBufB
    ld b, $a5

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

; CopyDefaultRecordToRecordBufB copies these $A5 bytes to wRecordBufB; laid out like
; PresetMonsterRecords (E-0235): byte 0 = 1, both names "???"; fields from E-0034, E-0104, E-0122,
; E-0125 and E-0237, laid out in E-0262 (E-0239, C1)
; record: one $A5-byte monster record in the SRAM record format
DefaultMonsterRecord::
    db $01 ; id 0: state: 0 empty, 1 or 2 in use (E-0104)
    db "???@", $f0, $f0, $f0, $f0, $f0, $f0 ; name, bytes 1-10 (E-0034)
    dw $00d4 ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $07 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E: bit 0 = sex, 0 male, 1 female (C2, E-0311)
    db "???@", $f0, $f0, $f0, $f0, $f0, $f0 ; master name, $0F-$18 (E-0034, E-0297)
    db $00 ; $19: master id (C1, E-0306)
    dw $ffff, $ffff ; $1A, $1C: species of parent 1 and 2 (E-0297)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $1E: master name of parent 1 (E-0297)
    db $00 ; $28 (unused)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $29: master name of parent 2 (E-0297)
    db $00 ; $33 (unused)
    db SKILL_HEAL, SKILL_MPASS, SKILL_FIREAIR, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT ; skills, $34-$3B (E-0122)
    db ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT ; $3C-$54: the list AppendMappedSkillsToRecordBufBSkillList appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $12 ; $56: level (E-0122)
    db $2d ; $57: level cap (C1, E-0296)
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $0083, $0083, $0028, $0028 ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    dw $008a, $005d, $0045, $017f ; $63 ATK, $65 DEF, $67 AGL, $69 INT (C1, E-0290)
    db $00, $00, $00, $00 ; $6B WLD word, $6D plus value, $6E egg state 0/1/2 (E-0296, E-0311)
    db $c8, $c8, $96, $50 ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $01, $01, $01, $00, $00, $02, $02, $02, $02, $00, $00, $02, $00, $00, $03, $00, $00, $02, $02, $02, $02, $00, $00, $00, $00, $00, $01 ; $73-$8D: 27 resistance levels (C1, E-0299)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $8E: name of parent 1 (E-0297)
    db $00 ; $98: plus value of parent 1 (E-0297)
    db $98, $98, $98, $f0, $f0, $f0, $f0, $f0, $f0, $f0 ; $99: name of parent 2 (E-0297)
    db $00 ; $A3: plus value of parent 2 (E-0297)
    db ITEM_00 ; $A4: equipped item (E-0125)

; [HL] = $C5, [HL+2] = $BE, [HL+4] = $C6; HL ends at HL+4; clobbers A (the same 14 bytes appear in 8
; banks) (E-0353)
StoreC5BEC6AtHLStride2_Bank24::
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

; Fills tile areas with the blank pattern through FillTilesFromRequest: 4 tiles at vTiles1 + $3F0, 5
; at + $470, 15 at + $500, 4 at + $6A0 and 8 at + $750; then sets the text window back to vTiles1
; with rows $02 and width $12 (without filling). Used by GameMode6_Update_ChooseEgg_ClearTiles and
; GameMode6_Update_SwitchEgg_ShowInfoOKYesN. (C1, E-0370)
GameMode6_Update_ClearEggListTiles::
    ld hl, vTiles1 + $3f0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0401
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $470
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
    ld hl, vTiles1 + $6a0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0401
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $750
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0801
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
    ret

; by wScreenSubStep: alternates timed waits (wScreenCounter) with moves of field objects 1, 2 and 5,
; and copies a name to the text buffer: a short object animation (renamed from
; GameMode6_Update_Save_ObjectScene from its E-0357 note, E-0367)
GameMode6_Update_HandOverScene::
    ld a, [wScreenSubStep]
    jumptable
    dw GameMode6_Update_HandOverScene_Wait
    dw GameMode6_Update_HandOverScene_MoveObject2
    dw GameMode6_Update_HandOverScene_Wait
    dw GameMode6_Update_HandOverScene_MoveObject1
    dw GameMode6_Update_HandOverScene_Wait
    dw GameMode6_Update_HandOverScene_ShowEgg
    dw GameMode6_Update_HandOverScene_Wait
    dw GameMode6_Update_HandOverScene_MoveObject2Left
    dw GameMode6_Update_HandOverScene_ShowTurnedOver
    dw GameMode6_Update_HandOverScene_Wait
    dw GameMode6_Update_HandOverScene_Wait
    dw GameMode6_Update_HandOverScene_WalkObject1
    dw GameMode6_Update_HandOverScene_WalkObjects
    dw GameMode6_Update_HandOverScene_MoveSprite

; Hand-over scene, sub-step 1: on three counts of every four (wSpriteSlots + 9) moves object 2 and
; the sprite at wSpriteSlots + $B left until it reaches $58. (C1, E-0357)
GameMode6_Update_HandOverScene_MoveObject2::
    ld a, [wSpriteSlots + $9]
    and $03
    and a
    ret z
    ld a, [wObject2 + OBJ_X]
    dec a
    ld [wObject2 + OBJ_X], a
    ld a, [wSpriteSlots + $b]
    dec a
    ld [wSpriteSlots + $b], a
    cp $58
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Hand-over scene, sub-step 0: a 16-frame wait. (C1, E-0357)
GameMode6_Update_HandOverScene_Wait::
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp $10
    ret c
    xor a
    ld [wScreenCounter], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Hand-over scene, sub-step 3: on three counts of every four moves object 1 right until X $38. (C1,
; E-0357)
GameMode6_Update_HandOverScene_MoveObject1::
    ld a, [wObject1 + OBJ_ANIM_COUNTER]
    and $03
    and a
    ret z
    ld a, [wObject1 + OBJ_X]
    inc a
    ld [wObject1 + OBJ_X], a
    cp $38
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Hand-over scene, sub-step 5: shows object 5 (state $80) when wRecordBufB is an egg. (C1, E-0357)
GameMode6_Update_HandOverScene_ShowEgg::
    ld a, [wRecordBufB + MON_EGG]
    and a
    jr z, .check_screen_sub_step
    ld a, $80
    ld [wObject5], a

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Hand-over scene, sub-step 7: unless wRecordBufB is an egg, on three counts of every four moves
; object 2 left until X $28, then turns it right (state 1). (C1, E-0357)
GameMode6_Update_HandOverScene_MoveObject2Left::
    ld a, [wRecordBufB + MON_EGG]
    and a
    jr nz, .check_screen_sub_step
    ld a, [wObject2 + OBJ_ANIM_COUNTER]
    and $03
    and a
    ret z
    ld a, [wObject2 + OBJ_X]
    dec a
    ld [wObject2 + OBJ_X], a
    cp $28
    ret nz
    ld a, $01
    ld [wObject2 + OBJ_STATE], a

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Hand-over scene, sub-step 8: copies the prize's name (wRecordBufA) and shows 'Turned over
; <name>...' (bank-$33 string 3). (C1, E-0357)
GameMode6_Update_HandOverScene_ShowTurnedOver::
    call CopyRecordBufANameNameToTextBuf0
    ld a, $03
    call ShowStringAInDefaultWindow_Bank24
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Hand-over scene, sub-step 11: hides object 5, turns object 1 left (state 3) and walks it on three
; counts of every four until X $18. (C1, E-0357)
GameMode6_Update_HandOverScene_WalkObject1::
    xor a
    ld [wObject5], a
    ld a, $03
    ld [wObject1 + OBJ_STATE], a
    ld a, [wObject1 + OBJ_ANIM_COUNTER]
    and $03
    and a
    ret z
    ld a, [wObject1 + OBJ_X]
    dec a
    ld [wObject1 + OBJ_X], a
    cp $18
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Hand-over scene, sub-step 12: turns object 2 left and walks objects 1 and 2 left on three counts
; of every four until object 1 reaches X $D8 (off the screen). (C1, E-0357)
GameMode6_Update_HandOverScene_WalkObjects::
    ld a, $03
    ld [wObject2 + OBJ_STATE], a
    ld a, [wObject1 + OBJ_ANIM_COUNTER]
    and $03
    and a
    ret z
    ld a, [wObject2 + OBJ_X]
    dec a
    ld [wObject2 + OBJ_X], a
    ld a, [wObject1 + OBJ_X]
    dec a
    ld [wObject1 + OBJ_X], a
    cp $d8
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Hand-over scene, sub-step 13: moves the sprite at wSpriteSlots + $B right on three counts of every
; four until $B0, then ends the scene. (C1, E-0357)
GameMode6_Update_HandOverScene_MoveSprite::
    ld a, $01
    ld [wSpriteSlots + $7], a
    ld a, [wSpriteSlots + $9]
    and $03
    and a
    ret z
    ld a, [wSpriteSlots + $b]
    inc a
    ld [wSpriteSlots + $b], a
    cp $b0
    ret nz
    xor a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; by wScreenSubStep: timed waits and moves of field objects 1, 2 and 5 with a name copy, as
; GameMode6_Update_HandOverScene (renamed from GameMode6_Update_SavePrompt_ObjectScene from its
; E-0357 note, E-0367)
GameMode6_Update_ReceivingScene::
    ld a, [wScreenSubStep]
    jumptable
    dw GameMode6_Update_ReceivingScene_Wait
    dw GameMode6_Update_ReceivingScene_MoveSprite
    dw GameMode6_Update_ReceivingScene_Wait
    dw GameMode6_Update_ReceivingScene_MoveObjects
    dw GameMode6_Update_ReceivingScene_Wait
    dw GameMode6_Update_ReceivingScene_ShowEgg
    dw GameMode6_Update_ReceivingScene_Wait
    dw GameMode6_Update_ReceivingScene_MoveObject2
    dw GameMode6_Update_ReceivingScene_ShowReceived
    dw GameMode6_Update_ReceivingScene_Wait
    dw GameMode6_Update_ReceivingScene_Wait
    dw GameMode6_Update_ReceivingScene_WalkObject1
    dw GameMode6_Update_ReceivingScene_HideEgg
    dw GameMode6_Update_ReceivingScene_MoveObject2Right

; Receiving scene, sub-step 1: moves the sprite at wSpriteSlots + $B left on three counts of every
; four until $58 at most. (C1, E-0357)
GameMode6_Update_ReceivingScene_MoveSprite::
    ld a, [wSpriteSlots + $9]
    and $03
    and a
    ret z
    ld a, [wSpriteSlots + $b]
    dec a
    ld [wSpriteSlots + $b], a
    cp $59
    ret nc
    ld a, $58
    ld [wSpriteSlots + $b], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Receiving scene, sub-step 3: on three counts of every four moves objects 1 and 2 right until
; object 1 reaches X $38. (C1, E-0357)
GameMode6_Update_ReceivingScene_MoveObjects::
    ld a, [wObject1 + OBJ_ANIM_COUNTER]
    and $03
    and a
    ret z
    ld a, [wObject2 + OBJ_X]
    inc a
    ld [wObject2 + OBJ_X], a
    ld a, [wObject1 + OBJ_X]
    inc a
    ld [wObject1 + OBJ_X], a
    cp $38
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Receiving scene, sub-step 0: a 16-frame wait. (C1, E-0357)
GameMode6_Update_ReceivingScene_Wait::
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp $10
    ret c
    xor a
    ld [wScreenCounter], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Receiving scene, sub-step 5: shows object 5 (state $80) when the prize (wRecordBufB) is an egg.
; (C1, E-0357)
GameMode6_Update_ReceivingScene_ShowEgg::
    ld a, [wRecordBufB + MON_EGG]
    and a
    jr z, .check_screen_sub_step
    ld a, $80
    ld [wObject5], a

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Receiving scene, sub-step 7: unless the prize is an egg, on three counts of every four moves
; object 2 right until X $68, then turns it left (state 3). (C1, E-0357)
GameMode6_Update_ReceivingScene_MoveObject2::
    ld a, [wRecordBufB + MON_EGG]
    and a
    jr nz, .check_screen_sub_step
    ld a, [wObject2 + OBJ_ANIM_COUNTER]
    and $03
    and a
    ret z
    ld a, [wObject2 + OBJ_X]
    inc a
    ld [wObject2 + OBJ_X], a
    cp $68
    ret c
    ld a, $68
    ld [wObject2 + OBJ_X], a
    ld a, $03
    ld [wObject2 + OBJ_STATE], a

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Receiving scene, sub-step 8: copies the prize's name and shows 'Received <name>' (bank-$33 string
; 4). (C1, E-0357)
GameMode6_Update_ReceivingScene_ShowReceived::
    call CopyRecordBufBNameNameToTextBuf0
    ld a, $04
    call ShowStringAInDefaultWindow_Bank24
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Receiving scene, sub-step 11: turns object 1 left (state 3) and walks it on three counts of every
; four until X $E0 (off the screen). (C1, E-0357)
GameMode6_Update_ReceivingScene_WalkObject1::
    ld a, $03
    ld [wObject1 + OBJ_STATE], a
    ld a, [wObject1 + OBJ_ANIM_COUNTER]
    and $03
    and a
    ret z
    ld a, [wObject1 + OBJ_X]
    dec a
    ld [wObject1 + OBJ_X], a
    cp $e0
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Receiving scene, sub-step 12: hides object 5 and moves the sprite at wSpriteSlots + $B right on
; three counts of every four until $78. (C1, E-0357)
GameMode6_Update_ReceivingScene_HideEgg::
    xor a
    ld [wObject5], a
    ld a, $01
    ld [wSpriteSlots + $7], a
    ld a, [wSpriteSlots + $9]
    and $03
    and a
    ret z
    ld a, [wSpriteSlots + $b]
    inc a
    ld [wSpriteSlots + $b], a
    cp $78
    ret c
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Receiving scene, sub-step 13: turns object 2 right (state 1) and moves it and that sprite right on
; three counts of every four until the sprite reaches $C0, then ends the scene. (C1, E-0357)
GameMode6_Update_ReceivingScene_MoveObject2Right::
    ld a, $01
    ld [wObject2 + OBJ_STATE], a
    ld a, [wSpriteSlots + $9]
    and $03
    and a
    ret z
    ld a, [wObject2 + OBJ_X]
    inc a
    ld [wObject2 + OBJ_X], a
    ld a, [wSpriteSlots + $b]
    inc a
    ld [wSpriteSlots + $b], a
    cp $c0
    ret c
    xor a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; Draws the sprite slots, and the field sprites too when the prize is an egg. (C1, E-0357)
GameMode6_Update_DrawSprites::
    farcall UpdateAndDrawSpriteSlots
    ld a, [wRecordBufB + MON_EGG]
    and a
    ret z
    farcall DrawFieldSprites
    ret

; Sets up the prize scene for GameMode6_Update_TakePrize_StartReceivingScene and
; GameMode6_Update_GiveUp_StartHandOverScene: copies 16 bytes to wSpriteSlots and Object1Init to
; wObject1 and decompresses two graphics sets through hTemp0 (DecompressGraphicsTemp0ToTemp4); the
; sprite table and the first graphics set each have an alternative chosen when EVENT_NEVER_SET is
; set, so the alternatives are never used. When wRecordBufB's MON_EGG is non-zero it runs field
; command $0D (RunFieldCommandTemp0), clears wObject5, sets its SCRIPTOBJ_X/SCRIPTOBJ_Y to $48/$40
; and wSpriteSlotCount = 2. Otherwise it decompresses the monster's graphics and copies object 2 (a
; 16-byte table for the winner, Object2Init when wBattleScene is $08 or has bit 0 set) with
; OBJ_SPRITE_ID = the species of wRecordBufB (winner) or wRecordBufA, and wSpriteSlotCount = 3. On
; the GBC it sets wOBJPaletteUploadRequest = $7F. (C1, E-0370)
GameMode6_Update_SetUpPrizeScene::
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jr c, .skip
    ld hl, GameMode6_Update_SetUpPrizeScene_Data5
    jr .call_copy_bytes_de_from_hl_bank24

.skip:
    ld hl, GameMode6_Update_SetUpPrizeScene_SpriteSlotsInit

.call_copy_bytes_de_from_hl_bank24:
    ld de, wSpriteSlots
    ld b, $10
    call CopyBytesDEFromHL_Bank24
    ld hl, Object1Init
    ld de, wObject1
    ld b, $10
    call CopyBytesDEFromHL_Bank24
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jr c, .skip2
    ld hl, GameMode6_Update_SetUpPrizeScene_Data1
    jr .call_copy_bytes_de_from_hl_bank242

.skip2:
    ld hl, GameMode6_Update_SetUpPrizeScene_Data2

.call_copy_bytes_de_from_hl_bank242:
    ld de, hTemp0
    ld b, $06
    call CopyBytesDEFromHL_Bank24
    farcall DecompressGraphicsTemp0ToTemp4
    ld hl, GameMode6_Update_SetUpPrizeScene_Data3
    ld de, hTemp0
    ld b, $06
    call CopyBytesDEFromHL_Bank24
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, [wRecordBufB + MON_EGG]
    and a
    jr nz, .set_temp0_to_0D
    ld hl, GameMode6_Update_SetUpPrizeScene_Data4
    ld de, hTemp0
    ld b, $06
    call CopyBytesDEFromHL_Bank24
    ld a, [wBattleScene]
    cp $08
    jr z, .read_record_buf_a
    and $01
    and a
    jr nz, .read_record_buf_a
    ld a, [wRecordBufB + MON_SPECIES]
    ldh [hTemp0], a
    ld a, [wRecordBufB + MON_SPECIES + 1]
    ldh [hTemp1], a
    jr .call_decompress_graphics_temp0_to_temp4

.read_record_buf_a:
    ld a, [wRecordBufA + MON_SPECIES]
    ldh [hTemp0], a
    ld a, [wRecordBufA + MON_SPECIES + 1]
    ldh [hTemp1], a

.call_decompress_graphics_temp0_to_temp4:
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, [wBattleScene]
    cp $08
    jr z, .skip3
    and $01
    and a
    jr nz, .skip3
    ld hl, GameMode6_Update_SetUpPrizeScene_Data6
    jr .call_copy_bytes_de_from_hl_bank243

.skip3:
    ld hl, Object2Init

.call_copy_bytes_de_from_hl_bank243:
    ld de, wObject2
    ld b, $10
    call CopyBytesDEFromHL_Bank24
    ld a, [wBattleScene]
    cp $08
    jr z, .read_record_buf_a2
    and $01
    and a
    jr nz, .read_record_buf_a2
    ld a, [wRecordBufB + MON_SPECIES]
    ld [wObject2 + OBJ_SPRITE_ID], a
    ld a, [wRecordBufB + MON_SPECIES + 1]
    ld [wObject2 + OBJ_SPRITE_ID + 1], a
    jr .set_sprite_slot_count_to_03

.read_record_buf_a2:
    ld a, [wRecordBufA + MON_SPECIES]
    ld [wObject2 + OBJ_SPRITE_ID], a
    ld a, [wRecordBufA + MON_SPECIES + 1]
    ld [wObject2 + OBJ_SPRITE_ID + 1], a

.set_sprite_slot_count_to_03:
    ld a, $03
    ld [wSpriteSlotCount], a
    jr .check_is_cgb

.set_temp0_to_0D:
    ld a, $0d
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    xor a
    ld [wObject5], a
    ld a, $48
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld a, $02
    ld [wSpriteSlotCount], a

.check_is_cgb:
    ld a, [wIsCGB]
    and a
    jr z, .return
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a

.return:
    ret

; the same 7 bytes as CopyBytesDEFromHL (CopyBytesDEFromHL) (E-0353)
CopyBytesDEFromHL_Bank24::
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, CopyBytesDEFromHL_Bank24
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 17 x 2 tiles, one row per line
GameMode6_Update_ShowResult_TileRect::
    db $e0, $e1, $e2, $e3, $e4, $e5, $c3, $e6, $e7, $e8, $e9, $ea, $eb, $ec, $ed, $ee, $ef ; id 0
    db $f0, $f1, $f2, $f3, $f4, $f5, $c3, $f6, $f7, $f8, $f9, $fa, $fb, $fc, $fd, $fe, $ff ; id 1

GameMode6_Update_ShowResult_Data::
    db $c3, $c3, $c3, $c3, $c3, $e0, $e1, $e2, $e3, $e4, $e5, $e6, $e7, $c3, $c3, $c3
    db $c3, $c3, $c3, $c3, $c3, $c3, $f0, $f1, $f2, $f3, $f4, $f5, $f6, $f7, $c3, $c3
    db $c3, $c3

GameMode6_Update_ShowResult_WaitForVRAMAccess_Data1::
    ds $1c, $07

GameMode6_Update_PageList_Cancel_TileRect::
    db $00, $01, $02, $03, $04, $05, $c3, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f ; id 0
    db $10, $11, $12, $13, $14, $15, $c3, $16, $17, $18, $19, $1a, $1b, $1c, $1d, $1e, $1f ; id 1

; record: 14 x 13 tiles, one row per line
GameMode6_Update_PageList_Cancel_TileRect_2::
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 2
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 4
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 5
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 6
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 7
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 8
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 9
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 10
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 11
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3 ; id 12

GameMode6_Update_DrawResultBox_Data::
    ds $78, $c3

; record: 20 x 5 tiles, one row per line
GameMode6_Update_TakePrize_RedrawBoxes_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

GameMode6_Update_TakePrize_AskSwitchWhich_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8a, $8b, $8c, $8d, $8e, $8f, $90, $91, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $92, $93, $94, $95, $96, $97, $98, $99, $9a, $9b, $9c, $9d, $9e, $9f, $a0, $a1, $a2, $a3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; record: 6 x 5 tiles, one row per line
GameMode6_Update_TakePrize_DrawYesNo_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $6d, $6e, $6f, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $70, $71, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; id 4

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 5 tiles, one row per line
GameMode6_Update_ChooseMonster_RedrawChoiceBox_TileRect::
    db $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $76, $77, $78, $79, $7a, $7b, $7c, $b7 ; id 1
    db $b2, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b7, $7f, $7f, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b5, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; record: 10 x 5 tiles, one row per line
GameMode6_Update_TakePrize_DrawMonsterEggChoice_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $76, $77, $78, $79, $7a, $7b, $7c, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $7d, $7f, $7f, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

GameMode6_Update_ChooseEgg_RedrawChoiceBox_TileRect::
    db $b5, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $76, $77, $78, $79, $7a, $7b, $7c, $b7 ; id 1
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $7d, $7f, $7f, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

GameMode6_Update_TakePrize_MonsterEggChoice_Data::
    db $23, $c4, $4b, $c4

GameMode6_Update_ChooseMonster_ShowCursorMark_Data::
    db $79, $c3, $a1, $c3, $c9, $c3, $f1, $c3, $19, $c4

; record: 8 x 11 tiles, one row per line
GameMode6_Update_SwitchMonster_ShowInfoOKYesN_TileRect::
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

; record: 13 x 9 tiles, one row per line
GameMode6_Update_ChooseEgg_DrawListBox_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $d5, $d6, $d7, $d8, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $d9, $da, $db, $dc, $dd, $de, $c0, $c1, $c2, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $f5, $f6, $f7, $f8, $f9, $fa, $fb, $fc, $bf, $c3, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $c7, $c8, $c9, $ca, $cb, $ea, $eb, $ec, $ed, $c3, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 5 tiles, one row per line
GameMode6_Update_ChooseEgg_ShowInfoOKYesN_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $70, $71, $72, $73, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $74, $75, $c3, $c3, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4
    db $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2a, $2b, $2c, $2d, $2e, $2f
    db $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3a, $3b, $3c, $3d, $3e, $3f
    db $40, $41, $42, $43

GameMode6_Update_SetUpPrizeScene_Data1::
    db $00, $00, $01, $04, $00, $80

GameMode6_Update_SetUpPrizeScene_Data2::
    db $01, $00, $01, $01, $00, $80

GameMode6_Update_SetUpPrizeScene_Data3::
    db $0c, $00, $01, $05, $00, $81

GameMode6_Update_SetUpPrizeScene_Data4::
    db $00, $00, $00, $02, $00, $82

GameMode6_Update_SetUpPrizeScene_Data5::
    db $00, $01, $00, $00, $a0, $40, $04, $03, $00, $00, $00, $a0, $40, $04, $00, $00

; CopyBytesDEFromHL_Bank24 copies these 16 bytes to wSpriteSlots (E-0264)
; record: 16 bytes copied to wSpriteSlots
GameMode6_Update_SetUpPrizeScene_SpriteSlotsInit::
    db $00, $01, $01, $00, $a0, $40, $01, $03, $00, $00, $00, $a0, $40, $04, $00, $00 ; entry 0

; CopyBytesDEFromHL_Bank24 copies these 16 bytes to wObject1 (E-0264)
; record: 16 bytes copied to wObject1
Object1Init::
    db $00, $01, $0c, $00, $e0, $40, $05, $01, $10, $00, $00, $e0, $40, $04, $00, $00 ; entry 0

GameMode6_Update_SetUpPrizeScene_Data6::
    db $00, $00, $00, $00, $d0, $40, $02, $01, $20, $00, $00, $d0, $40, $04, $00, $00

; CopyBytesDEFromHL_Bank24 copies these 16 bytes to wObject2 (E-0264)
; record: 16 bytes copied to wObject2
Object2Init::
    db $00, $00, $00, $00, $b0, $40, $02, $03, $20, $00, $00, $b0, $40, $04, $00, $00 ; entry 0

; The prize yes/no and Monster / Egg cursor: Up/Down toggle wTwoChoiceCursor with sound $69 ($FD); A
; $FF with sound $69; B $FE; otherwise blinks the cursor and returns 0. (C1, E-0357)
GameMode6_Update_TakePrize_ChoiceCursor::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_game_mode6_update_take_prize_choice
    bit 7, a
    jr nz, .call_game_mode6_update_take_prize_choice2
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, .call_game_mode6_update_take_prize_choice3
    bit 1, a
    jr nz, .set_menu_input_result_to_FE
    call GameMode6_Update_TakePrize_ChoiceCursor_Blink
    xor a
    ld [wMenuInputResult], a
    ret

.call_game_mode6_update_take_prize_choice:
    call GameMode6_Update_TakePrize_ChoiceCursor_Hide
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

.call_game_mode6_update_take_prize_choice2:
    call GameMode6_Update_TakePrize_ChoiceCursor_Hide
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
    call GameMode6_Update_TakePrize_ChoiceCursor_Show
    ld a, $69
    call QueueSoundEffect
    ld a, $fd
    ld [wMenuInputResult], a
    ret

.call_game_mode6_update_take_prize_choice3:
    call GameMode6_Update_TakePrize_ChoiceCursor_Mark
    ld a, $69
    call QueueSoundEffect
    ld a, $ff
    ld [wMenuInputResult], a
    ret

.set_menu_input_result_to_FE:
    ld a, $fe
    ld [wMenuInputResult], a
    ret

; Blinks the two-choice cursor: after $14 frames of the repeat timer, shown for 16 counts and hidden
; for 8. (C1, E-0357)
GameMode6_Update_TakePrize_ChoiceCursor_Blink::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, GameMode6_Update_TakePrize_ChoiceCursor_Show
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp $10
    jr c, GameMode6_Update_TakePrize_ChoiceCursor_Show
    cp $18
    jr c, GameMode6_Update_TakePrize_ChoiceCursor_Hide
    xor a
    ld [wScreenCounter], a

; Draws the cursor tile ($BB) at the two-choice cursor. (C1, E-0357)
GameMode6_Update_TakePrize_ChoiceCursor_Show::
    ld b, $bb
    jr GameMode6_Update_TakePrize_ChoiceCursor_DrawTile

; Draws the blank tile ($C3) at the two-choice cursor. (C1, E-0357)
GameMode6_Update_TakePrize_ChoiceCursor_Hide::
    ld b, $c3
    jr GameMode6_Update_TakePrize_ChoiceCursor_DrawTile

; Draws the chosen tile ($BC) at the two-choice cursor. (C1, E-0357)
GameMode6_Update_TakePrize_ChoiceCursor_Mark::
    ld b, $bc

; Writes tile B at the two-choice cursor's place
; (GameMode6_Update_TakePrize_ChoiceCursor_DrawTile_Data), stepping back on a scroll wrap, waiting
; for VRAM access. (C1, E-0357)
GameMode6_Update_TakePrize_ChoiceCursor_DrawTile::
    ld a, [wTwoChoiceCursor]
    add a
    ld hl, GameMode6_Update_TakePrize_ChoiceCursor_DrawTile_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank24_3
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX,
; hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks) (E-0353)
BGMapAddressAtScroll_Bank24_3::
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

; data read by GameMode6_Update_TakePrize_ChoiceCursor_DrawTile (4 bytes) (E-0347)
GameMode6_Update_TakePrize_ChoiceCursor_DrawTile_Data::
    db $2b, $01, $6b, $01

; ld de, this bank's string table / BeginStringDisplay (E-0353)
BeginStringDisplay_Bank24::
    ld de, BeginStringDisplay_Bank24_StringCategories
    call BeginStringDisplay
    ret
    db $11, $25, $5d, $cd, $fe, $25, $c9

; BeginStringDisplay_Bank24 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; (E-0353)
ShowString_Bank24::
    call BeginStringDisplay_Bank24
    call RunStringDisplayToEnd
    ret

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
BeginStringDisplay_Bank24_StringCategories::
    dw StringList_Bank24_StringCategories_0 ; id 0

; category list of BeginStringDisplay_Bank24_StringCategories; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank24_StringCategories_0::
    dw String_24_00_00 ; id 0
    dw String_24_00_00 ; id 1
    dw String_24_00_02 ; id 2
    dw String_24_00_03 ; id 3
    dw String_24_00_04 ; id 4
    dw String_24_00_05 ; id 5
    dw String_24_00_06 ; id 6
    dw String_24_00_07 ; id 7
    dw String_24_00_08 ; id 8
    dw String_24_00_09 ; id 9
    dw String_24_00_0A ; id 10
    dw String_24_00_0B ; id 11
    dw String_24_00_0C ; id 12
    dw String_24_00_0D ; id 13
    dw String_24_00_0E ; id 14
    dw String_24_00_0F ; id 15
    dw String_24_00_10 ; id 16
    dw String_24_00_11 ; id 17
    dw String_24_00_12 ; id 18
    dw String_24_00_13 ; id 19
    dw String_24_00_14 ; id 20
    dw String_24_00_15 ; id 21

String_24_00_00::
    db "<VOICE1>*: Oh? But none<LINE>"
    db "appear to be dead…<PROMPT>"
    db "@"

String_24_00_02::
    db "<VOICE1>*: Oh? But no one<LINE>"
    db "is poisoned.<PROMPT>"
    db "@"

String_24_00_03::
    db "<VOICE1>*: But none appear<LINE>"
    db "to be cursed…<PROMPT>"
    db "@"

String_24_00_04::
    db "<VOICE1>*: Do you need any<LINE>"
    db "other help?@"

String_24_00_05::
    db "<VOICE1>*: May the gods go<LINE>"
    db "with you.<WAIT>"
    db "@"

String_24_00_06::
    db "<VOICE1>*: Which monster<LINE>"
    db "should be revived?@"

String_24_00_07::
    db "<VOICE1>*: Who should be<LINE>"
    db "cured of poison?@"

String_24_00_08::
    db "<VOICE1>*: Who should be<LINE>"
    db "freed of a curse?@"

String_24_00_09::
    db "<VOICE1>*: Surely you jest.<LINE>"
    db "That one is alive.<PROMPT>"
    db "@"

String_24_00_0A::
    db "<VOICE1>*: But that monster<LINE>"
    db "is not poisoned.<PROMPT>"
    db "@"

String_24_00_0B::
    db "<VOICE1>*: But that monster<LINE>"
    db "is not cursed.<PROMPT>"
    db "@"

String_24_00_0C::
    db "<VOICE1>*: I must ask for a<LINE>"
    db "small donation of<PROMPT>"
    db "<NEXT><BUF0>G."
    db "<NEXT>Do you accept?@"

String_24_00_0D::
    db "<VOICE1>*: Gods, the<LINE>"
    db "spirits of earth!<PROMPT>"
    db "<NEXT>Please summon the"
    db "<NEXT>soul of <BUF0>!<WAIT>"
    db "@"

String_24_00_0E::
    db "<VOICE1>*: Gods, I  beg<LINE>"
    db "you, purify the<PROMPT>"
    db "<NEXT>poison sullying"
    db "<NEXT><BUF0>!<WAIT>"
    db "@"

String_24_00_0F::
    db "<VOICE1>*: Gods, I beg<LINE>"
    db "you, free <BUF0><PROMPT>"
    db "<NEXT>from its enslaving"
    db "<NEXT>curse!<WAIT>"
    db "@"

String_24_00_10::
    db "<VOICE1><BUF0> was revived!<WAIT>"
    db "@"

String_24_00_11::
    db "<VOICE1><BUF0> was cleansed<LINE>"
    db "of poison.<WAIT>"
    db "@"

String_24_00_12::
    db "<VOICE1><BUF0> was freed<LINE>"
    db "from the curse.<WAIT>"
    db "@"

String_24_00_13::
    db "<VOICE1>No one else seems<LINE>"
    db "to need help.<PROMPT>"
    db "<NEXT>Come see me again"
    db "<NEXT>if you need to.<PROMPT>"
    db "<NEXT>The gods will be"
    db "<NEXT>with you always.<WAIT>"
    db "@"

String_24_00_14::
    db "<VOICE1>*: Oh, my, my…<LINE>"
    db "How deplorable!<PROMPT>"
    db "<NEXT>You haven't enough"
    db "<NEXT>gold for this.<PROMPT>"
    db "@"

String_24_00_15::
    db "RviD-oxUncurt@"

; implements script command type F8 (SCRIPT_PRIEST): the priest: 'Which monster should be revived?',
; curse removal (mode 11, bank $24 strings); reached through ScriptCommandF8 in bank $10 (E-0038,
; E-0244) (C2 from E-0330: Revive / De-Tox / Uncurse / Exit; a revival costs 25G here)
PriestMenu::
    ld a, [wScreenState]
    jumptable
    dw PriestMenu_Init
    dw PriestMenu_ShowServices
    dw PriestMenu_PayForService

; The priest, state 0: runs SwapMonstersMenu and sets message mode $0B. (C1, E-0357)
PriestMenu_Init::
    farcall SwapMonstersMenu
    ld a, $0b
    ld [wMessageMode], a
    ret

; by wScreenStep: the 'Revive / Detox / Uncurse' window and the gold panel (E-0293)
PriestMenu_ShowServices::
    ld a, [wScreenStep]
    jumptable
    dw PriestMenu_ShowServices_ShowRviDoxUncurt
    dw PriestMenu_ShowServices_DrawServiceBox
    dw PriestMenu_ShowServices_RedrawScreen

; The priest's services, step 0: shows 'Revive / Detox / Uncurse' (string $15) in a 14 x 1 window at
; VRAM $8F00, then resets the window to $8800. (C1, E-0357)
PriestMenu_ShowServices_ShowRviDoxUncurt::
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $8f
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld [hl], $0e
    xor a
    ld [wStringCategory], a
    ld a, $15
    ld [wStringIndex], a ; 'RviD-oxUncurt'
    farcall ShowString_Bank24
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The priest's services, step 1: draws the 10 x 9 service box and the gold panel. (C1, E-0357)
PriestMenu_ShowServices_DrawServiceBox::
    ld de, PriestMenu_ShowServices_DrawServiceBox_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $0a, $09
    call CopyRectTo20ByteRows_Bank24
    call DrawGoldPanel_Bank24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The priest's services, step 2: draws the screen and goes to the next state. (C1, E-0357)
PriestMenu_ShowServices_RedrawScreen::
    call BGMapAddressAtScroll_Bank24_2
    lb bc, $14, $0b
    ld de, $01cc
    call DrawScreenBufferRectNoOrigin_Bank24
    xor a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; PriestMenu screen state 2, by wScreenStep: picks a party member, shows the gold panel, confirms
; with two choices and SubtractArg1AmountFromGold (E-0288)
PriestMenu_PayForService::
    ld a, [wScreenStep]
    jumptable
    dw PriestMenu_PayForService_PickService
    dw PriestMenu_PayForService_AnswerService
    dw PriestMenu_PayForService_DrawPartyBox
    dw PriestMenu_PartyCursorStep
    dw PriestMenu_PayForService_Back
    dw PriestMenu_PayForService_CheckMember
    dw PriestMenu_PayForService_SetPrice
    dw PriestMenu_PayForService_DrawYesNo
    dw PriestMenu_PayForService_ReadAnswer
    dw PriestMenu_AfterAnswer
    dw PriestMenu_PayForService_Pay
    dw PriestMenu_PayForService_PlayPrayer
    dw PriestMenu_PayForService_Wait
    dw PriestMenu_PayForService_CopyBuffers
    dw PriestMenu_PayForService_Wait
    dw PriestMenu_PayForService_ClearTextTiles
    dw PriestMenu_PayForService_CureMember
    dw PriestMenu_CheckMoreToCure

; The priest, picking the service (step 0): B answers 4 (leave); A on Revive, Detox or Uncurse
; answers the service + 1 when no party member is dead (status bit 7), poisoned (bit 2) or cursed
; (bit 0) by it, otherwise 0 and marks it; each answer is wTwoChoiceCursor and resumes the script
; ($80). (C1, E-0357)
PriestMenu_PayForService_PickService::
    xor a
    ld [wMenuInputResult], a
    ld a, $04
    ld [wListCount], a
    farcall UpdateListCursorListCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fe
    jr z, .set_two_choice_cursor_to_04
    cp $ff
    jr z, .check_list_cursor
    ret

.set_two_choice_cursor_to_04:
    ld a, $04

.set_two_choice_cursor:
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_list_cursor:
    ld a, [wListCursor]
    and a
    jr z, .call_priest_menu_any_member_has_status
    cp $01
    jr z, .call_priest_menu_any_member_has_status2
    cp $02
    jr z, .call_priest_menu_any_member_has_status3
    jr .set_two_choice_cursor_to_04

.call_priest_menu_any_member_has_status:
    ld b, $80
    call PriestMenu_AnyMemberHasStatus
    cp $ff
    jr z, .clear_two_choice_cursor
    ld a, $01
    jr .set_two_choice_cursor

.call_priest_menu_any_member_has_status2:
    ld b, $04
    call PriestMenu_AnyMemberHasStatus
    cp $ff
    jr z, .clear_two_choice_cursor
    ld a, $02
    jr .set_two_choice_cursor

.call_priest_menu_any_member_has_status3:
    ld b, $01
    call PriestMenu_AnyMemberHasStatus
    cp $ff
    jr z, .clear_two_choice_cursor
    ld a, $03
    jr .set_two_choice_cursor

.clear_two_choice_cursor:
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, [wListCursor]
    ld b, $bc
    ld hl, PriestMenu_PayForService_PickService_Data
    call StoreBAtWordTableEntry_Bank24
    xor a
    ld [wChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; The priest, step 1: answers the service number, loads the three status mark tiles and resumes the
; script. (C1, E-0357)
PriestMenu_PayForService_AnswerService::
    ld a, [wListCursor]
    ld [wTwoChoiceCursor], a
    ld hl, PriestMenu_PayForService_AnswerService_Tiles
    ld de, vTiles1 + $7e0
    call CopyTileBytesToVRAM_Bank24
    ld hl, PriestMenu_PayForService_AnswerService_Tiles_2
    call CopyTileBytesToVRAM_Bank24
    ld hl, PriestMenu_PayForService_AnswerService_Tiles_3
    ld de, vTiles1 + $6f0
    call CopyTileBytesToVRAM_Bank24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; HL = $6239 and 1 calls to a 16-byte VRAM copier (CopyTileBytesToVRAM_*), one tile each (E-0238)
; record: tile (16 bytes, 2 bits per pixel)
PriestMenu_PayForService_AnswerService_Tiles::
    db $ff, $06, $ff, $06, $ff, $06, $ff, $ff, $ff, $ff, $ff, $00, $ff, $00, $ff, $00 ; entry 0

; HL = $6249 and 1 calls to a 16-byte VRAM copier (CopyTileBytesToVRAM_*), one tile each (E-0238)
PriestMenu_PayForService_AnswerService_Tiles_2::
    db $ff, $00, $ff, $00, $ff, $00, $ff, $f8, $ff, $fc, $ff, $0e, $ff, $06, $ff, $06 ; entry 0

; HL = $6259 and 1 calls to a 16-byte VRAM copier (CopyTileBytesToVRAM_*), one tile each (E-0238)
PriestMenu_PayForService_AnswerService_Tiles_3::
    db $ff, $60, $ff, $60, $ff, $60, $ff, $1f, $ff, $3f, $ff, $70, $ff, $60, $ff, $60 ; entry 0

; The priest, step 2: draws the 11 x 7 party box with each member's status marks. (C1, E-0357)
PriestMenu_PayForService_DrawPartyBox::
    ld de, PriestMenu_PayForService_DrawPartyBox_TileRect
    ld hl, wWindowTileBuffer + $dc
    lb bc, $0b, $07
    call CopyRectTo20ByteRows_Bank24
    call PriestMenu_PayForService_DrawPartyBox_StatusMarks
    call BGMapAddressAtScroll_Bank24_2
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectNoOrigin_Bank24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The priest, step 3: the party cursor: B answers 1 and goes on; A answers 0 and goes on two steps.
; (C1, E-0357)
PriestMenu_PartyCursorStep::
    call PriestMenu_PartyCursor
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fe
    jr z, .check_screen_step
    cp $ff
    jr z, .read_screen_step
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_screen_step:
    ld a, [wScreenStep]
    add $02
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; The priest, step 4 (back): restores the box area, redraws the service box and gold panel, draws
; and clears the service mark and returns to step 0. (C1, E-0357)
PriestMenu_PayForService_Back::
    ld b, $00
    ld c, $07
    ld hl, $0244
    ld de, $0078
    xor a
    ld [wArg1], a
    ld a, $0b
    ld [wArg2], a
    call PriestMenu_PayForService_Back_CopyRows
    ld de, PriestMenu_ShowServices_DrawServiceBox_TileRect
    ld hl, wWindowTileBuffer + $64
    lb bc, $0a, $09
    call CopyRectTo20ByteRows_Bank24
    call DrawGoldPanel_Bank24
    ld a, [wListCursor]
    ld b, $bb
    ld hl, PriestMenu_PayForService_PickService_Data
    call StoreBAtWordTableEntry_Bank24
    call BGMapAddressAtScroll_Bank24_2
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectNoOrigin_Bank24
    ld a, [wListCursor]
    ld b, $c3
    ld hl, PriestMenu_PayForService_PickService_Data
    call StoreBAtWordTableEntry_Bank24
    xor a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; The priest, step 5: when the chosen member lacks the service's status answers the service + 1 and
; returns to step 1; otherwise answers 0 and goes on. (C1, E-0357)
PriestMenu_PayForService_CheckMember::
    ld a, [wListCursor]
    and a
    jr z, .skip
    cp $01
    jr z, .skip2
    ld b, $01
    jr .skip3

.skip:
    ld b, $80
    jr .skip3

.skip2:
    ld b, $04

.skip3:
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wChoiceCursor]
    ld hl, wPartyList
    add_a_to_hl
    ld a, [hl]
    ld c, MON_STATUS
    push bc
    call LoadSRAMRecordByte
    pop bc
    xor a
    ld [rRAMG], a
    ld [rRAMB], a
    ldh a, [hTemp0]
    and b
    and a
    jr nz, .check_screen_step
    ld a, $01
    ld [wScreenStep], a
    ld a, [wListCursor]
    inc a
    jr .set_two_choice_cursor

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a

.set_two_choice_cursor:
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; The priest, step 6: sets the price (wListEntries, wGrid2CursorX/Y as a 24-bit number) and its
; digits in wTextBuf0: Revive costs (level x 10 + 10) / 2, Detox 3, Uncurse 20. (C1, E-0357)
PriestMenu_PayForService_SetPrice::
    ld a, [wListCursor]
    and a
    jr z, .skip
    cp $01
    jr z, .set_list_entries_to_03
    ld a, $14
    ld [wListEntries], a
    xor a
    ld [wGrid2CursorX], a
    ld [wGrid2CursorY], a
    ld a, $02
    ld [wTextBuf0], a
    ld a, $00
    ld [wTextBuf0 + $1], a
    ld a, $f0
    ld [wTextBuf0 + $2], a
    jr .check_screen_step

.set_list_entries_to_03:
    ld a, $03
    ld [wListEntries], a
    xor a
    ld [wGrid2CursorX], a
    ld [wGrid2CursorY], a
    ld a, $03
    ld [wTextBuf0], a
    ld a, $f0
    ld [wTextBuf0 + $1], a

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.skip:
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wChoiceCursor]
    ld hl, wPartyList
    add_a_to_hl
    ld a, [hl]
    ld c, MON_LEVEL
    call LoadSRAMRecordByte
    xor a
    ld [rRAMG], a
    ld [rRAMB], a
    ldh a, [hTemp0]
    ld c, $0a
    call Multiply8
    ld a, $0a
    add_a_to_hl
    srl h
    rr l
    ld a, l
    ld [wListEntries], a
    ld [wDigits], a
    ld a, h
    ld [wGrid2CursorX], a
    ld [wDigits + $1], a
    xor a
    ld [wGrid2CursorY], a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    farcall UnpackBCDToDigitsArg1
    ld hl, wArg4
    ld de, wTextBuf0
    ld b, $04

.loop:
    ld a, [hl]
    cp $e3
    jr nz, .loop2
    inc hl
    dec b
    jr nz, .loop

.loop2:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    ld a, $f0
    ld [de], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; The priest, step 7: plays sound $6C and draws the yes/no box with the member marked. (C1, E-0357)
PriestMenu_PayForService_DrawYesNo::
    ld a, $6c
    call QueueSoundEffect
    ld de, PriestMenu_PayForService_DrawYesNo_TileRect
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows_Bank24
    ld a, [wChoiceCursor]
    ld b, $bc
    ld hl, PriestMenu_PayForService_DrawYesNo_Data
    call StoreBAtWordTableEntry_Bank24
    call BGMapAddressAtScroll_Bank24_2
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectNoOrigin_Bank24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 6 x 5 tiles, one row per line
PriestMenu_PayForService_DrawYesNo_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $ce, $cf, $df, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $a5, $f5, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; id 4

; The priest, step 8: the yes/no answer: B or no restores the box and answers 2; yes with too little
; gold (IsAmountInArg1AboveGold) answers 1 (sub-step 1); otherwise restores the box, answers 0 and
; goes on two steps. (C1, E-0357)
PriestMenu_PayForService_ReadAnswer::
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
    call PriestMenu_RestoreTwoChoiceBoxArea
    xor a
    ld [wScreenSubStep], a
    ld a, $02

.set_two_choice_cursor:
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    and a
    jr nz, .loop
    ld a, [wGrid2CursorY]
    ld [wArg3], a
    ld a, [wGrid2CursorX]
    ld [wArg2], a
    ld a, [wListEntries]
    ld [wArg1], a
    farcall IsAmountInArg1AboveGold
    ld a, [wArg1]
    cp $ff
    jr z, .set_screen_sub_step_to_01
    call PriestMenu_RestoreTwoChoiceBoxArea
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    add $02
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_screen_sub_step_to_01:
    ld a, $01
    ld [wScreenSubStep], a
    ld a, $01
    jr .set_two_choice_cursor

; The priest, step 9: restores the box; after a refusal returns to step 1 (resuming the script),
; after too little gold to step 4. (C1, E-0357)
PriestMenu_AfterAnswer::
    call PriestMenu_RestoreTwoChoiceBoxArea
    ld a, [wScreenSubStep]
    and a
    jr nz, .set_screen_step_to_04
    ld a, $01
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_screen_step_to_04:
    ld a, $04
    ld [wScreenStep], a
    xor a
    ld [wScreenSubStep], a
    ret

; The priest, step 10: pays the price (SubtractArg1AmountFromGold), redraws the gold panel and
; copies the member's name; then answers the service number and goes on. (C1, E-0357)
PriestMenu_PayForService_Pay::
    ld a, [wScreenSubStep]
    and a
    jr z, .clear_arg3
    cp $01
    jr z, .check_list_cursor
    jr .check_screen_step

.clear_arg3:
    xor a
    ld [wArg3], a
    ld a, [wGrid2CursorX]
    ld [wArg2], a
    ld a, [wListEntries]
    ld [wArg1], a
    farcall SubtractArg1AmountFromGold
    call DrawGoldPanel_Bank24
    call BGMapAddressAtScroll_Bank24_2
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectNoOrigin_Bank24
    call PriestMenu_PayForService_CopyMemberName
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.check_list_cursor:
    ld a, [wListCursor]
    and a
    jr z, .clear_screen_sub_step
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.clear_screen_sub_step:
    xor a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, [wListCursor]
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, [wListCursor]
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; The priest, step 11: plays music $3D, waits $128 frames, then restores the window tile buffer (and
; the GBC attributes) from the saved copy in wScreenTileBuffer, redraws and clears the sprite window
; clip mode. (C1, E-0357)
PriestMenu_PayForService_PlayPrayer::
    ld a, [wScreenSubStep]
    and a
    jr z, .call_queue_music
    cp $01
    jr z, .read_screen_counter
    jr .skip

.call_queue_music:
    ld a, $3d
    call QueueMusic
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.read_screen_counter:
    ld a, [wScreenCounter]
    add $01
    ld [wScreenCounter], a
    ld a, [wGlyphListPos]
    adc $00
    ld [wGlyphListPos], a
    ld a, [wGlyphListPos]
    and a
    ret z
    ld a, [wScreenCounter]
    cp $28
    ret c
    xor a
    ld [wScreenCounter], a
    ld [wGlyphListPos], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.skip:
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank24
    ld hl, wWindowTileBuffer
    ld de, wScreenTileBuffer + $104
    ld bc, $0064
    call CopyBytesDEToHL_Bank24
    ld a, [wIsCGB]
    and a
    jr z, .call_bg_map_address_at_scroll_bank24_2
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank24
    ld hl, wWindowAttrBuffer
    ld de, wScreenAttrBuffer + $104
    ld bc, $0064
    call CopyLow3BitsToWRAMBank2_Bank24

.call_bg_map_address_at_scroll_bank24_2:
    call BGMapAddressAtScroll_Bank24_2
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectNoOrigin_Bank24
    call BGMapAddressAtScroll_Bank24_2
    ld de, $01a0
    add hl, de
    lb bc, $14, $05
    ld de, $0168
    call DrawScreenBufferRectNoOrigin_Bank24
    xor a
    ldh [hSpriteWindowClipMode], a
    xor a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The priest, step 15: clears the text tiles, draws the bottom five rows and sets sprite window clip
; mode 2. (C1, E-0357)
PriestMenu_PayForService_ClearTextTiles::
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    call FillTilesFromRequest
    ld de, PriestMenu_PayForService_ClearTextTiles_TileRect
    ld hl, wWindowTileBuffer
    lb bc, $14, $05
    call CopyRectTo20ByteRows_Bank24
    call BGMapAddressAtScroll_Bank24_2
    ld de, $01a0
    add hl, de
    lb bc, $14, $05
    ld de, $0168
    call DrawScreenBufferRectNoOrigin_Bank24
    ld a, $02
    ldh [hSpriteWindowClipMode], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; The priest, step 12: a $1C-frame wait. (C1, E-0357)
PriestMenu_PayForService_Wait::
    ld hl, wScreenCounter
    inc [hl]
    ld a, [wScreenCounter]
    cp $1c
    ret c
    xor a
    ld [wScreenCounter], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; two CopyBytes steps (E-0303)
PriestMenu_PayForService_CopyBuffers::
    ld a, [wScreenSubStep]
    jumptable
    dw PriestMenu_PayForService_SavePalettes
    dw PriestMenu_PayForService_FlashPalettes

; The priest's flash, sub-step 0: on the GBC saves the 64 bytes of background palettes. (C1, E-0357)
PriestMenu_PayForService_SavePalettes::
    ld a, [wIsCGB]
    or a
    jr z, .check_screen_sub_step
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; The priest's flash, sub-step 1: every four frames swaps the palettes between $D2, $D2, $E2 (DMG)
; with the saved GBC palettes and $2D, $2D, $1D with every saved GBC byte inverted, for $1E frames;
; then unless the service was Revive restarts the map music. (C1, E-0357)
PriestMenu_PayForService_FlashPalettes::
    ld a, [wScreenCounter]
    sra a
    sra a
    and $01
    jr z, .skip
    ld hl, wDMGPaletteBGP
    ld a, $d2
    ld [hli], a
    ld a, $d2
    ld [hli], a
    ld a, $e2
    ld [hl], a
    ld a, [wIsCGB]
    or a
    jr z, .check_screen_counter
    ld hl, wBGPaletteCopy
    ld de, wBGPaletteBuffer
    ld bc, $0040
    call CopyBytes
    jr .set_bg_palette_upload_request_to_7F

.skip:
    ld hl, wDMGPaletteBGP
    ld a, $2d
    ld [hli], a
    ld a, $2d
    ld [hli], a
    ld a, $1d
    ld [hl], a
    ld a, [wIsCGB]
    or a
    jr z, .check_screen_counter
    ld b, $40
    ld hl, wBGPaletteCopy
    ld de, wBGPaletteBuffer

.loop:
    ld a, [hli]
    xor $ff
    ld [de], a
    inc de
    dec b
    jr nz, .loop

.set_bg_palette_upload_request_to_7F:
    ld a, $7f
    ld [wBGPaletteUploadRequest], a

.check_screen_counter:
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp $1e
    ret c
    xor a
    ld [wScreenCounter], a
    xor a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, [wListCursor]
    and a
    ret nz
    farcall RestartMapMusic
    ret

; The priest, step 16: clears the service's status bit on the member
; (PriestMenu_PayForService_CureMember_Data); for Revive also sets HP and MP to their maximums and
; moves the party's fallen members back (RunMoveIncapacitatedPartyMembersBackTwice); copies the
; name, reloads the player sprites and resumes the script. (C1, E-0357)
PriestMenu_PayForService_CureMember::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wChoiceCursor]
    ld hl, wPartyList
    add_a_to_hl
    push hl
    ld a, [hl]
    ld c, MON_STATUS
    call SRAMRecordAddress
    ld a, [wListCursor]
    ld de, PriestMenu_PayForService_CureMember_Data
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld b, a
    ld a, [hl]
    and b
    ld [hl], a
    pop hl
    ld a, [wListCursor]
    and a
    jr nz, .skip2
    ld a, [hl]
    ld c, MON_MAX_HP
    call SRAMRecordAddress
    ld a, [hli]
    ld e, a
    ld a, [hld]
    ld d, a
    dec hl
    dec hl
    ld a, e
    ld [hli], a
    ld [hl], d
    inc hl
    ld a, $04
    add_a_to_hl
    ld a, [hli]
    ld e, a
    ld a, [hld]
    ld d, a
    dec hl
    dec hl
    ld a, e
    ld [hli], a
    ld [hl], d
    farcall RunMoveIncapacitatedPartyMembersBackTwice
    call LoadRecordListNameTiles

.skip2:
    xor a
    ld [rRAMG], a
    ld [rRAMB], a
    call PriestMenu_PayForService_CopyMemberName
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; data read by PriestMenu (3 bytes) (E-0347)
PriestMenu_PayForService_CureMember_Data::
    db $00, $fb, $fe

; The priest, step 17: when any party member is still dead, poisoned or cursed answers 0 and returns
; to step 4; otherwise answers 1. (C1, E-0357)
PriestMenu_CheckMoreToCure::
    ld b, $80
    call PriestMenu_AnyMemberHasStatus
    cp $ff
    jr z, .clear_two_choice_cursor
    ld b, $04
    call PriestMenu_AnyMemberHasStatus
    cp $ff
    jr z, .clear_two_choice_cursor
    ld b, $01
    call PriestMenu_AnyMemberHasStatus
    cp $ff
    jr z, .clear_two_choice_cursor
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.clear_two_choice_cursor:
    xor a
    ld [wTwoChoiceCursor], a
    ld a, $04
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it
; then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the
; same 58 bytes appear in 8 banks) (E-0353)
CopyRectTo20ByteRows_Bank24::
    push hl
    push bc

.loop:
    push bc
    push hl

.loop2:
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop2
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, .loop
    pop bc
    pop hl
    ld a, [wIsCGB]
    and a
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
    push bc
    push hl

.loop4:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop4
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, .loop3
    xor a
    ldh [rSVBK], a
    ret

; DE = offset into wScreenTileBuffer, B = width, C = rows, HL = BG map address:
; CopyRectToBGMapWrapped from wScreenTileBuffer + DE; on CGB the same rectangle is then copied from
; wScreenAttrBuffer + DE (rSVBK = 2) into VRAM bank 1, the attributes; on DMG BC, DE and HL are
; kept. wTextCursorLo/wTextCursorHi are not written (E-0062)
DrawScreenBufferRectNoOrigin_Bank24::
    push de
    push bc
    push hl
    ld hl, wScreenTileBuffer
    add hl, de
    ld e, l
    ld d, h
    pop hl
    push hl
    call CopyRectToBGMapWrapped
    pop hl
    pop bc
    pop de
    ld a, [wIsCGB]
    and a
    ret z
    ld a, $01
    ldh [rVBK], a
    ld a, $02
    ldh [rSVBK], a
    push hl
    ld hl, wScreenAttrBuffer
    add hl, de
    ld e, l
    ld d, h
    pop hl
    call CopyRectToBGMapWrapped
    xor a
    ldh [rSVBK], a
    ldh [rVBK], a
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX,
; hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks) (E-0353)
BGMapAddressAtScroll_Bank24_2::
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
CopyBytesDEToHL_Bank24::
    ld a, [de]
    inc de
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, CopyBytesDEToHL_Bank24
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same
; 18 bytes appear in 7 banks) (E-0353)
CopyLow3BitsToWRAMBank2_Bank24::
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
    xor a
    ldh [rSVBK], a
    ret

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers
; A, DE, HL (the same 14 bytes appear in 8 banks) (E-0353)
StoreBAtWordTableEntry_Bank24::
    push bc
    add a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop bc
    ld a, b
    ld [de], a
    ret

; copies an 8 x 3 frame (DrawGoldPanel_Bank24_TileRect) into the screen buffer at wWindowTileBuffer
; + $70, converts wGold to packed BCD (Number24ToPackedBCD) and UnpackBCDToDigitsArg1, then writes
; the digits as tiles $E0 + d at wWindowTileBuffer + $86 (E-0074)
DrawGoldPanel_Bank24::
    ld de, DrawGoldPanel_Bank24_TileRect
    ld hl, wWindowTileBuffer + $70
    lb bc, $08, $03
    call CopyRectTo20ByteRows_Bank24
    ld a, [wGoldLo]
    ld [wDigits], a
    ld a, [wGoldMid]
    ld [wDigits + $1], a
    ld a, [wGoldHi]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    farcall UnpackBCDToDigitsArg1
    ld hl, wWindowTileBuffer + $86
    ld de, wArg3
    ld c, $00

.loop:
    ld a, [de]
    add $e0
    ld [hli], a
    inc de
    inc c
    ld a, c
    cp $05
    jr c, .loop
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 3 tiles, one row per line
DrawGoldPanel_Bank24_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $bf, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 2

; Returns $FF when any party member's status has a bit of mask B (bit 7 dead, bit 2 poisoned, bit 0
; cursed), otherwise 0. (C1, E-0357)
PriestMenu_AnyMemberHasStatus::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wPartyCount]
    ld c, a
    ld hl, wPartyList
    ld e, $00

.loop:
    push de
    push hl
    push bc
    ld a, [hl]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    pop bc
    push bc
    and b
    and a
    jr nz, .restore
    pop bc
    pop hl
    pop de
    inc hl
    inc e
    ld a, e
    cp c
    jr c, .loop
    xor a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

.restore:
    pop bc
    pop hl
    pop de
    xor a
    ld [rRAMG], a
    ld [rRAMB], a
    ld a, $ff
    ret

; Draws the status marks of every party member: tile $C0 for bit 0, $C1 for bit 2, $C2 for bit 7.
; (C1, E-0357)
PriestMenu_PayForService_DrawPartyBox_StatusMarks::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wPartyCount]
    ld c, a
    ld e, $00
    ld hl, wPartyList

.loop:
    push hl
    push bc
    push de
    ld a, [hl]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    pop de
    push de
    ldh a, [hTemp0]
    bit 0, a
    call nz, PriestMenu_PayForService_WriteMarkC0
    ldh a, [hTemp0]
    bit 2, a
    call nz, PriestMenu_PayForService_WriteMarkC1
    ldh a, [hTemp0]
    bit 7, a
    call nz, PriestMenu_PayForService_WriteMarkC2
    pop de
    pop bc
    pop hl
    inc hl
    inc e
    ld a, e
    cp c
    jr c, .loop
    xor a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

; writes tile $C0 at the table address for entry E (E-0305)
PriestMenu_PayForService_WriteMarkC0::
    push de
    ld a, e
    add a
    ld hl, PriestMenu_PayForService_WriteMarkC0_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, $c0
    ld [de], a
    pop de
    ret

; writes tile $C1 at the table address for entry E (E-0305)
PriestMenu_PayForService_WriteMarkC1::
    push de
    ld a, e
    add a
    ld hl, PriestMenu_PayForService_WriteMarkC1_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, $c1
    ld [de], a
    pop de
    ret

; writes tile $C2 at the table address for entry E (E-0305)
PriestMenu_PayForService_WriteMarkC2::
    push de
    ld a, e
    add a
    ld hl, PriestMenu_PayForService_WriteMarkC2_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, $c2
    ld [de], a
    pop de
    ret

; data read by PriestMenu (6 bytes) (E-0347)
PriestMenu_PayForService_WriteMarkC0_Data::
    db $f7, $c3, $1f, $c4, $47, $c4

PriestMenu_PayForService_WriteMarkC1_Data::
    db $f8, $c3, $20, $c4, $48, $c4

PriestMenu_PayForService_WriteMarkC2_Data::
    db $f9, $c3, $21, $c4, $49, $c4

; The priest's party cursor: Up/Down move wChoiceCursor over the party with wrap and sound $69
; ($FD); A $FF with sound $69; B $FE; otherwise blinks the cursor and returns 0. (C1, E-0357)
PriestMenu_PartyCursor::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_priest_menu_party_cursor_hide
    bit 7, a
    jr nz, .call_priest_menu_party_cursor_hide2
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, .call_queue_sound_effect
    bit 1, a
    jr nz, .set_menu_input_result_to_FE
    call PriestMenu_PartyCursor_Blink
    xor a
    ld [wMenuInputResult], a
    ret

.call_priest_menu_party_cursor_hide:
    call PriestMenu_PartyCursor_Hide
    ld a, [wChoiceCursor]
    and a
    jr nz, .set_choice_cursor
    ld a, [wPartyCount]
    dec a
    ld [wChoiceCursor], a
    jr .clear_cursor_blink_ae

.set_choice_cursor:
    dec a
    ld [wChoiceCursor], a
    jr .clear_cursor_blink_ae

.call_priest_menu_party_cursor_hide2:
    call PriestMenu_PartyCursor_Hide
    ld a, [wPartyCount]
    dec a
    ld b, a
    ld a, [wChoiceCursor]
    cp b
    jr c, .set_choice_cursor2
    xor a
    ld [wChoiceCursor], a
    jr .clear_cursor_blink_ae

.set_choice_cursor2:
    inc a
    ld [wChoiceCursor], a

.clear_cursor_blink_ae:
    xor a
    ld [wCursorBlinkAE], a
    call PriestMenu_PartyCursor_Show
    ld a, $69
    call QueueSoundEffect
    ld a, $fd
    ld [wMenuInputResult], a
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call PriestMenu_PartyCursor_MarkChosen
    ld a, $ff
    ld [wMenuInputResult], a
    ret

.set_menu_input_result_to_FE:
    ld a, $fe
    ld [wMenuInputResult], a
    ret

; Blinks the party cursor: after $14 frames of the repeat timer, shown for 16 counts and hidden for
; 8. (C1, E-0357)
PriestMenu_PartyCursor_Blink::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, PriestMenu_PartyCursor_Show
    ld a, [wCursorBlinkAE]
    inc a
    ld [wCursorBlinkAE], a
    cp $10
    jr c, PriestMenu_PartyCursor_Show
    cp $18
    jr c, PriestMenu_PartyCursor_Hide
    xor a
    ld [wCursorBlinkAE], a

; Draws the cursor tile ($BB) at the party cursor. (C1, E-0357)
PriestMenu_PartyCursor_Show::
    ld b, $bb
    jr PriestMenu_PartyCursor_DrawTile

; Draws the blank tile ($C3) at the party cursor. (C1, E-0357)
PriestMenu_PartyCursor_Hide::
    ld b, $c3
    jr PriestMenu_PartyCursor_DrawTile

; Draws the chosen tile ($BC) at the party cursor. (C1, E-0357)
PriestMenu_PartyCursor_MarkChosen::
    ld b, $bc

; B = tile: writes it straight into the BG map at the party cursor: wChoiceCursor picks one of the
; three offsets in the word table after it, added to the address from BGMapAddressAtScroll_Bank24_2
; and wrapped by StepBGMapAddressBackOnScrollWrap; the write is made with interrupts off after
; WaitForVRAMAccess. (C1, E-0370)
PriestMenu_PartyCursor_DrawTile::
    ld a, [wChoiceCursor]
    add a
    ld hl, PriestMenu_PartyCursor_DrawTile_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank24_2
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; data read by PriestMenu (6 bytes) (E-0347)
PriestMenu_PartyCursor_DrawTile_Data::
    db $e1, $00, $21, $01, $61, $01

; Copies C rows of wArg1:wArg2 bytes from offset DE to offset HL within wScreenTileBuffer (and
; wScreenAttrBuffer on the GBC), rows 20 bytes apart. (C1, E-0357)
PriestMenu_PayForService_Back_CopyRows::
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
    ld e, l
    ld d, h
    pop hl
    ld a, [wArg1]
    ld b, a
    ld a, [wArg2]
    ld c, a
    call CopyBytesDEToHL_Bank24
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
    ld e, l
    ld d, h
    pop hl
    ld a, [wArg1]
    ld b, a
    ld a, [wArg2]
    ld c, a
    call CopyLow3BitsToWRAMBank2_Bank24
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
    dec c
    jr nz, PriestMenu_PayForService_Back_CopyRows
    ret

; Restores the yes/no box area (six bytes, five rows) of wWindowTileBuffer from wScreenTileBuffer
; (on the GBC its attributes from WRAM bank 2) and redraws the screen. (C1, E-0357)
PriestMenu_RestoreTwoChoiceBoxArea::
    ld hl, wWindowTileBuffer + $112
    ld de, wScreenTileBuffer + $ae
    ld c, $00
    call PriestMenu_RestoreTwoChoiceBoxArea_CopyRows
    ld a, [wIsCGB]
    and a
    jr z, .call_bg_map_address_at_scroll_bank24_2
    ldh a, [rSVBK]
    set 1, a
    ldh [rSVBK], a
    ld hl, wWindowAttrBuffer + $112
    ld de, wWorkBuf + $11
    ld c, $00
    call PriestMenu_RestoreTwoChoiceBoxArea_CopyRows
    ldh a, [rSVBK]
    res 1, a
    ldh [rSVBK], a

.call_bg_map_address_at_scroll_bank24_2:
    call BGMapAddressAtScroll_Bank24_2
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectNoOrigin_Bank24
    ret

; Copies five rows of six bytes from DE to HL, 20-byte rows. (C1, E-0357)
PriestMenu_RestoreTwoChoiceBoxArea_CopyRows::
    push hl
    push de
    push bc
    ld bc, $0006
    call CopyBytesDEToHL_Bank24
    pop bc
    pop de
    pop hl
    ld a, $14
    add_a_to_hl
    ld a, $14
    add e
    ld e, a
    jr nc, .next
    inc d

.next:
    inc c
    ld a, c
    cp $05
    jr c, PriestMenu_RestoreTwoChoiceBoxArea_CopyRows
    ret

; Copies the chosen party member's name (up to ten bytes) into wTextBuf0. (C1, E-0357)
PriestMenu_PayForService_CopyMemberName::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld a, [wChoiceCursor]
    ld hl, wPartyList
    add_a_to_hl
    ld a, [hl]
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    xor a
    ld [rRAMG], a
    ld [rRAMB], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
    ld c, $00

.loop:
    ld a, [hl]
    cp $f0
    jr z, .done
    ld [de], a
    inc hl
    inc de
    inc c
    ld a, c
    cp $0a
    jr c, .loop

.done:
    ld a, $f0
    ld [de], a
    ret

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for
; rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (the same 17 bytes appear in 7 banks)
; (E-0353)
CopyTileBytesToVRAM_Bank24::
    ld c, $10

.loop:
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [hli]
    ld [de], a
    inc de
    ei
    dec c
    jr nz, .loop
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 10 x 9 tiles, one row per line
PriestMenu_ShowServices_DrawServiceBox_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $f0, $cf, $f1, $f2, $f1, $cf, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $f3, $cf, $f4, $a8, $f5, $f6, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $f7, $f8, $f9, $fa, $fb, $df, $cf, $b7 ; id 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 6
    db $b6, $c3, $a9, $f6, $f2, $fc, $c3, $c3, $c3, $b7 ; id 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 8

; record: 20 x 5 tiles, one row per line
PriestMenu_PayForService_ClearTextTiles_TileRect::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8a, $8b, $8c, $8d, $8e, $8f, $90, $91, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $92, $93, $94, $95, $96, $97, $98, $99, $9a, $9b, $9c, $9d, $9e, $9f, $a0, $a1, $a2, $a3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; record: 11 x 7 tiles, one row per line
PriestMenu_PayForService_DrawPartyBox_TileRect::
    db $ef, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $fe, $ff ; id 0
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $d5, $d6, $d7, $d8, $d9, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $da, $db, $dc, $dd, $de, $c3, $c3, $c3, $b7 ; id 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 6

PriestMenu_PayForService_PickService_Data::
    db $79, $c3, $a1, $c3, $c9, $c3, $f1, $c3

PriestMenu_PayForService_DrawYesNo_Data::
    db $f1, $c3, $19, $c4, $41, $c4

GameMode6_Update_ShowResult_WaitForVRAMAccess_Data2::
    ds $38, $00
    db $1f, $00, $ff, $7f, $00, $7e, $00, $00

; LZSS-compressed: 303 bytes that expand to 512 (E-0016, E-0017)
GameMode6_Init_Data1::
    INCBIN "gfx/misc/game_mode6_init_data1.lz"

; LZSS-compressed: 315 bytes that expand to 512 (E-0016, E-0017)
Tiles1Plus600Gfx::
    INCBIN "gfx/misc/tiles1_plus600_gfx.lz"

; LZSS-compressed: 247 bytes that expand to 512 (E-0016, E-0017)
GameMode6_Init_Data2::
    INCBIN "gfx/misc/game_mode6_init_data2.lz"

; draws the next glyph of the description of the item at wItemGrid[4 * wItemGridY + wItemGridX]
; (text table ItemDescriptionTable), handling the $F0 and $F1 control bytes (E-0131)
StepItemDescriptionText::
    ld a, [wTextCounter6]
    and a
    jr nz, .check_screen_state

.check_screen_state:
    ld a, [wScreenState]
    cp $04
    jr nz, .call_load_arg1_byte_for_item_grid_x_item_grid
    ld hl, wItemGrid
    jr .read_item_grid_y

.call_load_arg1_byte_for_item_grid_x_item_grid:
    farcall LoadArg1ByteForItemGridXItemGridY
    ld a, [wArg1]
    jr .skip

.read_item_grid_y:
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wItemGridX]
    add_a_to_hl
    ld a, [hl]

.skip:
    ld e, a
    ld d, $00
    sla e
    rl d
    ld hl, ItemDescriptionTable
    add hl, de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    ld a, [wTextCounter2]
    ld e, a
    ld a, [wTextCounter1]
    ld d, a
    add hl, de
    ld a, [hl]
    cp $f0
    jp z, .clear_text_counter1
    cp $f1
    jp z, .read_text_counter12
    ld [wListCursorBlink], a
    push hl
    ld hl, GlyphFont
    swap a
    ld d, a
    and $f0
    ld e, a
    ld a, d
    and $0f
    ld d, a
    add hl, de
    ld e, l
    ld d, h
    push de
    ld a, [wListCursorBlink]
    cp $8d
    jr z, .read_text_counter4
    cp $8e
    jr z, .read_text_counter4
    jr .read_text_counter42

.read_text_counter4:
    ld a, [wTextCounter4]
    ld e, a
    ld a, [wTextCounter3]
    ld d, a
    ld a, e
    sub $10
    ld e, a
    ld a, d
    sbc $00
    ld [wTextCounter3], a
    ld a, e
    ld [wTextCounter4], a

.read_text_counter42:
    ld a, [wTextCounter4]
    ld e, a
    ld a, [wTextCounter3]
    ld d, a
    ld hl, vTiles1
    add hl, de
    pop de
    ld b, $1f
    ld c, $10
    ld a, [wListCursorBlink]
    cp $8d
    jr z, .call_or_from_bank_wait_vram
    cp $8e
    jr z, .call_or_from_bank_wait_vram
    call CopyFromBankWaitVRAM
    jr .read_text_counter1

.call_or_from_bank_wait_vram:
    call OrFromBankWaitVRAM

.read_text_counter1:
    pop hl
    ld a, [wTextCounter1]
    ld d, a
    ld a, [wTextCounter2]
    add $01
    ld [wTextCounter2], a
    ld a, d
    adc $00
    ld [wTextCounter1], a
    ld a, [wTextCounter3]
    ld d, a
    ld a, [wTextCounter4]
    ld e, a
    add $10
    ld e, a
    ld a, d
    adc $00
    ld [wTextCounter3], a
    ld a, e
    ld [wTextCounter4], a
    jp StepItemDescriptionText

.clear_text_counter1:
    xor a
    ld [wTextCounter1], a
    ld [wTextCounter2], a
    ld [wTextCounter3], a
    ld [wTextCounter4], a
    ld a, [wTextCounter0]
    inc a
    ld [wTextCounter0], a
    ret

.read_text_counter12:
    ld a, [wTextCounter1]
    ld d, a
    ld a, [wTextCounter2]
    add $01
    ld [wTextCounter2], a
    ld a, d
    adc $00
    ld [wTextCounter1], a
    ld a, $01
    ld [wTextCounter3], a
    ld a, $20
    ld [wTextCounter4], a
    jp StepItemDescriptionText

; StepItemDescriptionText reads the word at $7158 + 2 * the item number under the item grid cursor
; and shows the text from there plus wTextCounter1/2; 99 words, one per ItemTable entry (E-0255, C1)
; record: description text
ItemDescriptionTable::
    dw ItemDescription_Herb ; id 0
    dw ItemDescription_Herb ; id 1
    dw ItemDescription_LoveWater ; id 2
    dw ItemDescription_WorldDew ; id 3
    dw ItemDescription_Potion ; id 4
    dw ItemDescription_ElfWater ; id 5
    dw ItemDescription_Antidote ; id 6
    dw ItemDescription_MoonHerb ; id 7
    dw ItemDescription_Laurel ; id 8
    dw ItemDescription_AwakeSand ; id 9
    dw ItemDescription_SkyBell ; id 10
    dw ItemDescription_SageRock ; id 11
    dw ItemDescription_WorldLeaf ; id 12
    dw ItemDescription_ATKseed ; id 13
    dw ItemDescription_DEFseed ; id 14
    dw ItemDescription_AGLseed ; id 15
    dw ItemDescription_INTseed ; id 16
    dw ItemDescription_LifeAcorn ; id 17
    dw ItemDescription_MysticNut ; id 18
    dw ItemDescription_Quest ; id 19
    dw ItemDescription_Horror ; id 20
    dw ItemDescription_BeNice ; id 21
    dw ItemDescription_Cheater ; id 22
    dw ItemDescription_Smart ; id 23
    dw ItemDescription_Comedy ; id 24
    dw ItemDescription_BeefJerky ; id 25
    dw ItemDescription_PorkChop ; id 26
    dw ItemDescription_Rib ; id 27
    dw ItemDescription_Sirloin ; id 28
    dw ItemDescription_BadMeat ; id 29
    dw ItemDescription_MeteOrb ; id 30
    dw ItemDescription_BeastTail ; id 31
    dw ItemDescription_Repellent ; id 32
    dw ItemDescription_ShinyHarp ; id 33
    dw ItemDescription_Mist ; id 34
    dw ItemDescription_Friend ; id 35
    dw ItemDescription_Wind ; id 36
    dw ItemDescription_Bolt ; id 37
    dw ItemDescription_Snow ; id 38
    dw ItemDescription_Fire ; id 39
    dw ItemDescription_Warp ; id 40
    dw ItemDescription_WarpWing ; id 41
    dw ItemDescription_ExitBell ; id 42
    dw ItemDescription_Bookmark ; id 43
    dw ItemDescription_TinyMedal ; id 44
    dw ItemDescription_GoldPass ; id 45
    dw ItemDescription_LogTwig ; id 46
    dw ItemDescription_2F ; id 47
    dw ItemDescription_2F ; id 48
    dw ItemDescription_MoonRock ; id 49
    dw ItemDescription_Crest ; id 50
    dw ItemDescription_YunaSoul ; id 51
    dw ItemDescription_SleepHerb ; id 52
    dw ItemDescription_Change ; id 53
    dw ItemDescription_TidalBell ; id 54
    dw ItemDescription_HarMirror ; id 55
    dw ItemDescription_Sky ; id 56
    dw ItemDescription_Heaven ; id 57
    dw ItemDescription_Heaven_2 ; id 58
    dw ItemDescription_Heaven_3 ; id 59
    dw ItemDescription_WizStone ; id 60
    dw ItemDescription_Pretty ; id 61
    dw ItemDescription_Accessory ; id 62
    dw ItemDescription_Accessory ; id 63
    dw ItemDescription_VITbelt ; id 64
    dw ItemDescription_DracoBelt ; id 65
    dw ItemDescription_MagicBelt ; id 66
    dw ItemDescription_OddBelt ; id 67
    dw ItemDescription_StoneFang ; id 68
    dw ItemDescription_SteelFang ; id 69
    dw ItemDescription_MermScale ; id 70
    dw ItemDescription_DrakScale ; id 71
    dw ItemDescription_AGL ; id 72
    dw ItemDescription_Starry ; id 73
    dw ItemDescription_Smart_2 ; id 74
    dw ItemDescription_Wise ; id 75
    dw ItemDescription_MagicCape ; id 76
    dw ItemDescription_DracoCape ; id 77
    dw ItemDescription_SilvrCape ; id 78
    dw ItemDescription_GoldCape ; id 79
    dw ItemDescription_PltnmCape ; id 80
    dw ItemDescription_OrcaCape ; id 81
    dw ItemDescription_BraveCape ; id 82
    dw ItemDescription_DScale ; id 83
    dw ItemDescription_None ; id 84
    dw ItemDescription_None ; id 85
    dw ItemDescription_None ; id 86
    dw ItemDescription_None ; id 87
    dw ItemDescription_None ; id 88
    dw ItemDescription_None ; id 89
    dw ItemDescription_Life ; id 90
    dw ItemDescription_Divine ; id 91
    dw ItemDescription_War ; id 92
    dw ItemDescription_Mage ; id 93
    dw ItemDescription_Fight ; id 94
    dw ItemDescription_Sailor ; id 95
    dw ItemDescription_Thief ; id 96
    dw ItemDescription_Cleric ; id 97
    dw ItemDescription_62 ; id 98

ItemDescription_Herb::
    db "Restores HP of one<LINE>"
    db "monster by "
    db $03, $00, $9d, $04, $00, $b5, $f0

ItemDescription_LoveWater::
    db "Restores HP of one<LINE>"
    db "monster by "
    db $06, $00, $9d, $07, $00, $b5, $f0

ItemDescription_WorldDew::
    db "Fully restores HP<LINE>"
    db "of all monsters.@"

ItemDescription_Potion::
    db "Restores MP of one<LINE>"
    db "monster by "
    db $02, $00, $9d, $03, $00, $b5, $f0

ItemDescription_ElfWater::
    db "Fully restores MP<LINE>"
    db "of one monster.@"

ItemDescription_Antidote::
    db "Removes all traces<LINE>"
    db "of poison.@"

ItemDescription_MoonHerb::
    db "Cures paralysis.@"

ItemDescription_Laurel::
    db "Lifts a curse off<LINE>"
    db "one monster.@"

ItemDescription_AwakeSand::
    db "Awakens a sleeping<LINE>"
    db "monster.@"

ItemDescription_SkyBell::
    db "Snaps a monster<LINE>"
    db "out of confusion.@"

ItemDescription_SageRock::
    db "Restores HP of all<LINE>"
    db "monsters by "
    db $06, $00, $9d, $07, $00, $b5, $f0

ItemDescription_WorldLeaf::
    db "Revives a dead<LINE>"
    db "monster.@"

ItemDescription_ATKseed::
    db "Raises ATK by 3.@"

ItemDescription_DEFseed::
    db "Raises DEF by 3.@"

ItemDescription_AGLseed::
    db "Raises AGL by 3.@"

ItemDescription_INTseed::
    db "Raises INT by 3.@"

ItemDescription_LifeAcorn::
    db "Raises max. HP<LINE>"
    db "by 5.@"

ItemDescription_MysticNut::
    db "Raises max. MP<LINE>"
    db "by 5.@"

ItemDescription_Quest::
    db "Makes the reader<LINE>"
    db "braver.@"

ItemDescription_Horror::
    db "Makes the reader<LINE>"
    db "more cowardly.@"

ItemDescription_BeNice::
    db "Makes the reader<LINE>"
    db "more kindly.@"

ItemDescription_Cheater::
    db "Makes the reader<LINE>"
    db "more sly.@"

ItemDescription_Smart::
    db "Makes the reader<LINE>"
    db "more thoughtful.@"

ItemDescription_Comedy::
    db "Makes the reader<LINE>"
    db "simple-minded.@"

ItemDescription_BeefJerky::
    db "Tames monsters<LINE>"
    db "just a little.@"

ItemDescription_PorkChop::
    db "Tames monsters a<LINE>"
    db "little bit.@"

ItemDescription_Rib::
    db "Tames monsters a<LINE>"
    db "lot.@"

ItemDescription_Sirloin::
    db "Tames monsters<LINE>"
    db "very much.@"

ItemDescription_BadMeat::
    db "Tames a tiny bit,<LINE>"
    db "but also poisons.@"

ItemDescription_MeteOrb::
    db "Tames monsters<LINE>"
    db "incredibly.@"

ItemDescription_BeastTail::
    db "Checks if monster<LINE>"
    db "was caught before.@"

ItemDescription_Repellent::
    db "Prevents monsters<LINE>"
    db "from appearing.@"

ItemDescription_ShinyHarp::
    db "Attracts monsters<LINE>"
    db "when strummed.@"

ItemDescription_Mist::
    db "Prevents casting<LINE>"
    db "of spells.@"

ItemDescription_Friend::
    db "Doubles physical<LINE>"
    db "power of one.@"

ItemDescription_Wind::
    db "Hits all enemies<LINE>"
    db "with a windstorm.@"

ItemDescription_Bolt::
    db "Hits all enemies<LINE>"
    db "with lightning.@"

ItemDescription_Snow::
    db "Hits all enemies<LINE>"
    db "with a blizzard.@"

ItemDescription_Fire::
    db "Hits one target<LINE>"
    db "with a fireball.@"

ItemDescription_Warp::
    db "Instantly warps to<LINE>"
    db "the Door Shrine.@"

ItemDescription_WarpWing::
    db "Instantly warps to<LINE>"
    db "GreatLog.@"

ItemDescription_ExitBell::
    db "Instantly warps to<LINE>"
    db "the exit.@"

ItemDescription_Bookmark::
    db "Enables saving in<LINE>"
    db "the Journal.@"

ItemDescription_TinyMedal::
    db "Collect and trade<LINE>"
    db "for rare gifts.@"

ItemDescription_GoldPass::
    db "Get a 10-percent<LINE>"
    db "discount at shops.@"

ItemDescription_LogTwig::
    db "Moves the Door<LINE>"
    db "Shrine.@"

ItemDescription_2F::
    db "Reveals Mirage<LINE>"
    db "Lake.@"

ItemDescription_MoonRock::
    db "A magic stone that<LINE>"
    db "raises the tide.@"

ItemDescription_Crest::
    db "A medal from the<LINE>"
    db "elemental spirit.@"

ItemDescription_YunaSoul::
    db "The lost soul of a<LINE>"
    db "princess.@"

ItemDescription_SleepHerb::
    db "A blue flower that<LINE>"
    db "grows in snow.@"

ItemDescription_Change::
    db "Transforms users<LINE>"
    db "into monsters.@"

ItemDescription_TidalBell::
    db "Summons a clam for<LINE>"
    db "crossing the sea.@"

ItemDescription_HarMirror::
    db "Destroys what it<LINE>"
    db "reflects.@"

ItemDescription_Sky::
    db "Summons a cloud<LINE>"
    db "for flying.@"

ItemDescription_Heaven::
    db "A legendary helmet<LINE>"
    db "found in a cave.@"

ItemDescription_Heaven_2::
    db "A legendary armor<LINE>"
    db "found in a tower.@"

ItemDescription_Heaven_3::
    db "A legendary sword<LINE>"
    db "found in a castle.@"

ItemDescription_WizStone::
    db "A magical stone<LINE>"
    db "that glows blue.@"

ItemDescription_Pretty::
    db "A beautiful gold<LINE>"
    db "ring.@"

ItemDescription_Accessory::
    db "Undefined.@"

ItemDescription_VITbelt::
    db "Raises max. HP<LINE>"
    db "by 30.@"

ItemDescription_DracoBelt::
    db "Raises max. HP<LINE>"
    db "by 80.@"

ItemDescription_MagicBelt::
    db "Raises max. MP<LINE>"
    db "by 30.@"

ItemDescription_OddBelt::
    db "Raises max. MP<LINE>"
    db "by 80.@"

ItemDescription_StoneFang::
    db "Raises ATK by 10.@"

ItemDescription_SteelFang::
    db "Raises ATK by 50.@"

ItemDescription_MermScale::
    db "Raises DEF by 10.@"

ItemDescription_DrakScale::
    db "Raises DEF by 50.@"

ItemDescription_AGL::
    db "Raises AGL by 10.@"

ItemDescription_Starry::
    db "Raises AGL by 50.@"

ItemDescription_Smart_2::
    db "Raises INT by 50.@"

ItemDescription_Wise::
    db "Raises INT by 100.@"

ItemDescription_MagicCape::
    db "Raises resistance<LINE>"
    db "to attack spells.@"

ItemDescription_DracoCape::
    db "Raises resistance<LINE>"
    db "to fire and ice.@"

ItemDescription_SilvrCape::
    db "Resists confusion,<LINE>"
    db "poison "
    db $b6
    db " sleep.@"

ItemDescription_GoldCape::
    db "Resists most<LINE>"
    db "status skills.@"

ItemDescription_PltnmCape::
    db "Resists curse,<LINE>"
    db "paralysis "
    db $b6
    db " death.@"

ItemDescription_OrcaCape::
    db "Raises resistance<LINE>"
    db "to water skills.@"

ItemDescription_BraveCape::
    db "Prevents skills<LINE>"
    db "from being sealed.@"

ItemDescription_DScale::
    db "Raises DEF by 5.@"

ItemDescription_None::
    db "Undefined.@"

ItemDescription_Life::
    db "Restores HP by 1<LINE>"
    db "on every step.@"

ItemDescription_Divine::
    db "Restores MP by 1<LINE>"
    db "on every step.@"

ItemDescription_War::
    db "Promotes max. HP<LINE>"
    db "gain.@"

ItemDescription_Mage::
    db "Promotes max.<LINE>"
    db "MP gain.@"

ItemDescription_Fight::
    db "Promotes ATK gain<LINE>"
    db "while growing.@"

ItemDescription_Sailor::
    db "Promotes DEF gain<LINE>"
    db "while growing.@"

ItemDescription_Thief::
    db "Promotes AGL gain<LINE>"
    db "while growing.@"

ItemDescription_Cleric::
    db "Promotes INT gain<LINE>"
    db "while growing.@"

ItemDescription_62::
    db "Undefined.@"
    ds $3dd, $00
