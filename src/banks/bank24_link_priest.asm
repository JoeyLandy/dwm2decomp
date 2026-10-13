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
    ld a, [wLinkSceneByte4C]
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
    ld de, Tiles1Gfx_46_4001
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
    farcall LoadPalette0FromData53C6
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
    jr nz, .call_game_mode6_init_load_monster_picture
    ld a, [wRecordBufA + MON_SPECIES]
    ld [wBattlerRecords + BATTLER_SPECIES], a
    ld a, [wRecordBufA + MON_SPECIES + 1]
    ld [wBattlerRecords + BATTLER_SPECIES + 1], a

.call_game_mode6_init_load_monster_picture:
    call GameMode6_Init_LoadMonsterPicture
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
    ld de, Tiles1Plus600Gfx_24_6E13
    ld b, $24

.call_decompress_to_ram_locked:
    ld hl, vTiles1 + $600
    call DecompressToRAMLocked
    call GameMode6_Init_UploadBGPalettes
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
    jp ClearSGBPacketBuffer_CheckLinkMode

; per-frame routine for wGameMode = 6
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
    call GameMode6_Update_UpdateAndDrawSpriteSlots
    ret

.check_screen_step:
    ld a, [wScreenStep]
    cp $0e
    ret nz
    ld a, [wScreenSubStep]
    cp $09
    ret nz
    call GameMode6_Update_UpdateAndDrawSpriteSlots
    ret

.read_screen_state:
    ld a, [wScreenState]
    jumptable
    dw GameMode6_Update_ObtainedEgg
    dw GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24
    dw GameMode6_Update_SavePrompt
    dw GameMode6_Update_Save
    dw GameMode6_Update_ChooseRecordList
    dw GameMode6_Update_ChooseRecordAndSave
    dw GameMode6_Update_Return
    dw GameMode6_Update_Return
    dw GameMode6_Update_Return
    dw GameMode6_Update_Return
    dw GameMode6_Update_Return
    dw GameMode6_Update_Return
    dw GameMode6_Update_SwapMonstersMenu
    dw GameMode6_Update_SwapMonstersMenu_Case0D_SetScreenStep
    dw GameMode6_Update_SwitchEgg
    dw GameMode6_Update_SwitchMonster

; by wScreenStep: shows 'obtained an egg of 0.'
GameMode6_Update_ObtainedEgg::
    ld a, [wScreenStep]
    jumptable
    dw GameMode6_Update_ObtainedEgg_CopyRectTo20ByteRowsJp_Bank24
    dw GameMode6_Update_ObtainedEgg_WriteScreenStepAndScreenState

GameMode6_Update_ObtainedEgg_CopyRectTo20ByteRowsJp_Bank24::
    ld a, [wBattleScene]
    cp $08
    jr z, .call_bg_map_address_at_scroll_bank24
    cp $80
    jr z, .skip
    jr .skip2

.skip:
    ld de, GameMode6_Update_ObtainedEgg_CopyRectTo20ByteRowsJp_Bank24_Data
    jr .call_copy_rect_to20_byte_rows_jp_bank24

.skip2:
    ld de, TileRect_24_5792

.call_copy_rect_to20_byte_rows_jp_bank24:
    ld hl, wWindowTileBuffer + $7a
    lb bc, $11, $02
    call CopyRectTo20ByteRowsJp_Bank24
    call GameMode6_Update_ObtainedEgg_Case00_WaitForVRAMAccess
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

GameMode6_Update_ObtainedEgg_WriteScreenStepAndScreenState::
    ld a, [wLinkRules + $9]
    and a
    jr nz, .check_battle_scene

.loop:
    call GameMode6_Update_WriteLinkSceneByte4BAndGameModeEtc
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

GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24::
    ld de, GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24_Data
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

; by wScreenStep: RunSaveGameSteps, a yes/no prompt and a 'monster egg' message
GameMode6_Update_SavePrompt::
    ld a, [wScreenStep]
    jumptable
    dw GameMode6_Update_SavePrompt_WriteScreenStepAndScreenSubStep
    dw GameMode6_Update_SavePrompt_LoadRecordCapacityFromFarmLevelTable
    dw GameMode6_Update_SavePrompt_RunSaveGameSteps
    dw GameMode6_Update_SavePrompt_ToShowStringAInDefaultWindow_Bank24AndStep
    dw GameMode6_Update_SavePrompt_ShowYesNo_Case04_ReturnStub_51A3
    dw GameMode6_Update_SavePrompt_UpdateTwoChoiceCursor_Bank1D
    dw GameMode6_Update_SavePrompt_ToGameMode6_Update_WriteLinkSceneByte4BAndGameModeEtc
    dw GameMode6_Update_SavePrompt_GameMode6_Update_ShowMonsterEg
    dw GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor
    dw GameMode6_Update_SavePrompt_SetScreenStepTo05
    dw GameMode6_Update_SavePrompt_ShowStringAInDefaultWindow_Bank24
    dw GameMode6_Update_SavePrompt_ReturnStub_51A3
    dw GameMode6_Update_SavePrompt_DecompressToVRAM
    dw GameMode6_Update_SavePrompt_ToGameMode6_Update_Save_TestFlagBitAndStep
    dw GameMode6_Update_SavePrompt_ObjectScene_Case0E_GameMode6_Update_UpdateAndDrawSpriteSlots
    dw GameMode6_Update_SavePrompt_SetScreenStep

GameMode6_Update_SavePrompt_WriteScreenStepAndScreenSubStep::
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

GameMode6_Update_SavePrompt_LoadRecordCapacityFromFarmLevelTable::
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

GameMode6_Update_SavePrompt_RunSaveGameSteps::
    farcall RunSaveGameSteps
    ld a, [wSaveStep]
    bit 7, a
    ret z
    call GameMode6_Update_WriteLinkSceneByte4BAndGameModeEtc
    ret

GameMode6_Update_SavePrompt_ToShowStringAInDefaultWindow_Bank24AndStep::
    ld a, $05
    call ShowStringAInDefaultWindow_Bank24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

GameMode6_Update_SavePrompt_ShowYesNo_Case04_ReturnStub_51A3::
    ld a, $6c
    call QueueSoundEffect
    call GameMode6_Update_SavePrompt_ShowYesNo
    ld de, TileRect_24_5A0A
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRowsJp_Bank24
    call ReturnStub_51A3
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

GameMode6_Update_SavePrompt_UpdateTwoChoiceCursor_Bank1D::
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fe
    jr z, .call_game_mode6_update_save_prompt_show_yes
    cp $ff
    jr z, .check_two_choice_cursor
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    and a
    jr nz, .call_game_mode6_update_save_prompt_show_yes
    ld a, $07
    call ShowStringAInDefaultWindow_Bank24
    ld a, [wScreenStep]
    add $02
    ld [wScreenStep], a
    ret

.call_game_mode6_update_save_prompt_show_yes:
    call GameMode6_Update_SavePrompt_ShowYesNo
    call CopyRecordBufBNameNameToTextBuf0
    ld a, $06
    call ShowStringAInDefaultWindow_Bank24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

GameMode6_Update_SavePrompt_ToGameMode6_Update_WriteLinkSceneByte4BAndGameModeEtc::
    call GameMode6_Update_WriteLinkSceneByte4BAndGameModeEtc
    ret

GameMode6_Update_SavePrompt_GameMode6_Update_ShowMonsterEg::
    ld a, $6c
    call QueueSoundEffect
    call GameMode6_Update_ShowMonsterEg
    ld de, TileRect_24_5A50
    ld hl, wWindowTileBuffer + $10e
    lb bc, $0a, $05
    call CopyRectTo20ByteRowsJp_Bank24
    call ReturnStub_51A3
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

GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor::
    call GameMode6_Update_SavePrompt_Case08_WriteMenuInputResultAndTwoChoiceCursorEtc
    ld a, [wMenuInputResult]
    and a
    ret z
    cp $fe
    jr z, .call_game_mode6_update_save_prompt_show_yes
    cp $ff
    jr z, .check_two_choice_cursor
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    and a
    jr nz, .call_list_records_in_use_with_byte6_e_set
    farcall ListRecordsInUseWithByte6EClear
    jr .read_screen_step

.call_list_records_in_use_with_byte6_e_set:
    farcall ListRecordsInUseWithByte6ESet

.read_screen_step:
    ld a, [wScreenStep]
    add $02
    ld [wScreenStep], a
    ret

.call_game_mode6_update_save_prompt_show_yes:
    call GameMode6_Update_SavePrompt_ShowYesNo
    ld de, TileRect_24_5A0A
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRowsJp_Bank24
    xor a
    ld b, $bc
    ld hl, GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    call ReturnStub_51A3
    call BGMapAddressAtScroll_Bank24
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_24
    xor a
    ld b, $c3
    ld hl, GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    xor a
    ld [wTwoChoiceCursor], a
    ld a, $05
    call ShowStringAInDefaultWindow_Bank24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

GameMode6_Update_SavePrompt_SetScreenStepTo05::
    ld a, $05
    ld [wScreenStep], a
    ret

GameMode6_Update_SavePrompt_ShowStringAInDefaultWindow_Bank24::
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
    ld hl, GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

GameMode6_Update_SavePrompt_ReturnStub_51A3::
    ld a, [wBattleScene]
    cp $08
    jr nz, .call_game_mode6_update_copy_rect_to20_byte
    ld de, GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24_Data
    ld hl, wWindowTileBuffer + $f7
    lb bc, $06, $06
    call CopyRectTo20ByteRowsJp_Bank24
    jr .call_bg_map_address_at_scroll_bank24

.call_game_mode6_update_copy_rect_to20_byte:
    call GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24_Shared01_GameMode6_Update_Shared01_DecompressToVRAM

.call_bg_map_address_at_scroll_bank24:
    call BGMapAddressAtScroll_Bank24
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_24
    ld de, TileRect_24_5942
    ld hl, wWindowTileBuffer
    lb bc, $14, $05
    call CopyRectTo20ByteRowsJp_Bank24
    call ReturnStub_51A3
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

GameMode6_Update_SavePrompt_DecompressToVRAM::
    ld b, $46
    ld de, Tiles1Gfx_46_4001
    ld hl, vTiles1
    call DecompressToVRAM
    ld de, vTiles1
    ld b, $24

.loop:
    push bc
    ld hl, Tiles_24_44FE
    call CopyTileBytesToVRAM_Bank24_52BA
    pop bc
    dec b
    jr nz, .loop
    ld de, TileRect_24_59A6
    ld hl, wWindowTileBuffer
    lb bc, $14, $05
    call CopyRectTo20ByteRowsJp_Bank24
    call ReturnStub_51A3
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
Tiles_24_44FE::
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; entry 0

GameMode6_Update_SavePrompt_ToGameMode6_Update_Save_TestFlagBitAndStep::
    call GameMode6_Update_Save_TestFlagBit
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

GameMode6_Update_SavePrompt_ObjectScene_Case0E_GameMode6_Update_UpdateAndDrawSpriteSlots::
    call GameMode6_Update_UpdateAndDrawSpriteSlots
    call GameMode6_Update_SavePrompt_ObjectScene
    ret

GameMode6_Update_SavePrompt_SetScreenStep::
    xor a
    ld [wScreenStep], a
    ld a, $01
    ld [wScreenSubStep], a
    ret

; by wScreenStep: draws the sprites, then RunSaveGameSteps
GameMode6_Update_Save::
    ld a, [wScreenStep]
    jumptable
    dw GameMode6_Update_Save_WriteScreenStep
    dw GameMode6_Update_Save_GameMode6_Update_UpdateAndDrawSpriteSlots
    dw GameMode6_Update_Save_SetSaveStep
    dw GameMode6_Update_Save_RunSaveGameSteps

GameMode6_Update_Save_WriteScreenStep::
    call GameMode6_Update_Save_TestFlagBit
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

GameMode6_Update_Save_GameMode6_Update_UpdateAndDrawSpriteSlots::
    call GameMode6_Update_UpdateAndDrawSpriteSlots
    call GameMode6_Update_Save_ObjectScene
    ret

GameMode6_Update_Save_SetSaveStep::
    xor a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

GameMode6_Update_Save_RunSaveGameSteps::
    farcall RunSaveGameSteps
    ld a, [wSaveStep]
    bit 7, a
    ret z
    call GameMode6_Update_WriteLinkSceneByte4BAndGameModeEtc
    ret

; by wScreenStep: a paged record list with strings (ShowStringAInDefaultWindow_Bank24), record
; buffer B and a two-choice input
GameMode6_Update_ChooseRecordList::
    ld a, [wScreenStep]
    jumptable
    dw GameMode6_Update_ChooseRecordList_ToBreedMenu
    dw GameMode6_Update_ChooseRecordList_ToBreedMenu
    dw GameMode6_Update_ChooseRecordList_ToBreedMenu
    dw GameMode6_Update_ChooseRecordList_ToBreedMenu
    dw GameMode6_Update_ChooseRecordList_ToEggServiceMenu_Bank1B
    dw GameMode6_Update_ChooseRecordList_ToEggServiceMenu_Bank1B
    dw GameMode6_Update_ChooseRecordList_AdvanceScreenStep
    dw GameMode6_Update_ChooseRecordList_StoreBAtWordTableEntry_Bank24_52CE
    dw GameMode6_Update_Case04_PageList
    dw GameMode6_Update_ChooseRecordList_ToEggServiceMenu_Bank1B
    dw GameMode6_Update_ChooseRecordList_HandleTwoChoiceCursorInput_0D
    dw GameMode6_Update_ChooseRecordList_GameMode6_Update_ShowMonsterEg
    dw GameMode6_Update_ChooseRecordList_SetArg5ToListEntriesCell5
    dw GameMode6_Update_ChooseRecordList_RunSaveGameSteps

GameMode6_Update_ChooseRecordList_ToBreedMenu::
    farcall BreedMenu
    ret

GameMode6_Update_ChooseRecordList_ToEggServiceMenu_Bank1B::
    farcall EggServiceMenu_Bank1B
    ret

GameMode6_Update_ChooseRecordList_AdvanceScreenStep::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

GameMode6_Update_ChooseRecordList_StoreBAtWordTableEntry_Bank24_52CE::
    ld a, [wListCursor]
    ld b, $bb
    ld hl, GameMode6_Update_ChooseRecordList_StoreBAtWordTableEntry_Bank24_52CE_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    call BGMapAddressAtScroll_Bank24
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_24
    ld a, [wListCursor]
    ld b, $c3
    ld hl, GameMode6_Update_ChooseRecordList_StoreBAtWordTableEntry_Bank24_52CE_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; moves the paged cursor, copies a rectangle and sets the sub-step
GameMode6_Update_Case04_PageList::
    ld a, [wScreenSubStep]
    jumptable
    dw GameMode6_Update_Case04_PageList_UpdatePagedListCursor
    dw GameMode6_Update_Case04_PageList_CopyRectTo20ByteRowsJp_Bank24
    dw GameMode6_Update_Case04_PageList_SetScreenSubStep

GameMode6_Update_Case04_PageList_UpdatePagedListCursor::
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
    jr z, .call_game_mode6_update_case04_page_list
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

.call_game_mode6_update_case04_page_list:
    call GameMode6_Update_Case04_PageList_Case00_ReadPartyCountAndListCursorEtc
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
    ld hl, GameMode6_Update_ChooseRecordList_StoreBAtWordTableEntry_Bank24_52CE_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    farcall CopyListEntriesCell5NameToTextBuf0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

GameMode6_Update_Case04_PageList_CopyRectTo20ByteRowsJp_Bank24::
    ld de, TileRect_24_5814
    ld hl, wWindowTileBuffer + $64
    lb bc, $0e, $0d
    call CopyRectTo20ByteRowsJp_Bank24
    ld a, [wTwoChoiceCursor]
    ld b, $bb
    ld hl, GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    ld a, [wBattleScene]
    cp $08
    jr nz, .check_link_byte_eb
    ld de, GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24_Data
    ld hl, wWindowTileBuffer + $f7
    lb bc, $06, $06
    call CopyRectTo20ByteRowsJp_Bank24
    jr .skip

.check_link_byte_eb:
    ld a, [wLinkByteEB]
    and a
    jr nz, .skip
    ld de, TileRect_24_57F2
    ld hl, wWindowTileBuffer + $7a
    lb bc, $11, $02
    call CopyRectTo20ByteRowsJp_Bank24

.skip:
    ld de, TileRect_24_5A50
    ld hl, wWindowTileBuffer + $10e
    lb bc, $0a, $05
    call CopyRectTo20ByteRowsJp_Bank24
    call BGMapAddressAtScroll_Bank24
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_24
    ld a, [wTwoChoiceCursor]
    ld b, $c3
    ld hl, GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor_Data
    call StoreBAtWordTableEntry_Bank24_52CE
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

GameMode6_Update_Case04_PageList_SetScreenSubStep::
    xor a
    ld [wScreenSubStep], a
    ret

GameMode6_Update_ChooseRecordList_HandleTwoChoiceCursorInput_0D::
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
    jr nc, .call_game_mode6_update_choose_record_list
    ld a, [wListPageIndex]
    and a
    jr nz, .call_game_mode6_update_choose_record_list
    ld a, [wListCursor]
    and a
    jr nz, .call_game_mode6_update_choose_record_list
    ld a, $12
    call ShowStringAInDefaultWindow_Bank24
    jr .check_screen_step

.call_game_mode6_update_choose_record_list:
    call GameMode6_Update_ChooseRecordList_Case0A_SetArg5ToListEntriesCell5
    ld a, $0a
    call ShowStringAInDefaultWindow_Bank24
    ld a, [wScreenStep]
    add $02
    ld [wScreenStep], a
    ret

GameMode6_Update_ChooseRecordList_GameMode6_Update_ShowMonsterEg::
    ld de, TileRect_24_5A28
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRowsJp_Bank24
    xor a
    ld b, $bc
    ld hl, GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    call GameMode6_Update_ShowMonsterEg
    call BGMapAddressAtScroll_Bank24
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_24
    ld a, [wListCursor]
    ld b, $c3
    ld hl, GameMode6_Update_ChooseRecordList_StoreBAtWordTableEntry_Bank24_52CE_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    ld a, [wScreenStep]
    sub $03
    ld [wScreenStep], a
    ret

GameMode6_Update_ChooseRecordList_SetArg5ToListEntriesCell5::
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

GameMode6_Update_ChooseRecordList_RunSaveGameSteps::
    farcall RunSaveGameSteps
    ld a, [wSaveStep]
    bit 7, a
    ret z
    call GameMode6_Update_WriteLinkSceneByte4BAndGameModeEtc
    ret

; by wScreenStep: a paged record list, the 'Info / OK / Yes / No' window, the monster-egg message
; and RunSaveGameSteps
GameMode6_Update_ChooseRecordAndSave::
    ld a, [wScreenStep]
    jumptable
    dw GameMode6_Update_ChooseRecordAndSave_ToGameMode6_Update_FillTilesFromRequestAndStep
    dw GameMode6_Update_ChooseRecordAndSave_ToCopyRectTo20ByteRowsJp_Bank24AndStep
    dw GameMode6_Update_ChooseRecordAndSave_ClampRecordListPageCursor4
    dw GameMode6_Update_ChooseRecordAndSave_DrawRecordListPageSpeciesNames
    dw GameMode6_Update_ChooseRecordAndSave_DrawRecordListPageMarks
    dw GameMode6_Update_ChooseRecordAndSave_UpdatePagedListCursor
    dw GameMode6_Update_ChooseRecordAndSave_StoreBAtWordTableEntry_Bank24_52CE
    dw GameMode6_Update_ChooseRecordAndSave_ShowInfoOKYesN
    dw GameMode6_Update_ChooseRecordAndSave_HandleTwoChoiceCursorInput_0D
    dw GameMode6_Update_ChooseRecordAndSave_GameMode6_Update_ShowMonsterEg
    dw GameMode6_Update_ChooseRecordAndSave_SetArg5ToListEntriesCell4
    dw GameMode6_Update_ChooseRecordAndSave_RunSaveGameSteps

GameMode6_Update_ChooseRecordAndSave_ToGameMode6_Update_FillTilesFromRequestAndStep::
    call GameMode6_Update_FillTilesFromRequest
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

GameMode6_Update_ChooseRecordAndSave_ToCopyRectTo20ByteRowsJp_Bank24AndStep::
    ld de, TileRect_24_5B10
    ld hl, wWindowTileBuffer + $64
    lb bc, $0d, $09
    call CopyRectTo20ByteRowsJp_Bank24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

GameMode6_Update_ChooseRecordAndSave_ClampRecordListPageCursor4::
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

GameMode6_Update_ChooseRecordAndSave_DrawRecordListPageSpeciesNames::
    xor a
    ld [wArg5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

GameMode6_Update_ChooseRecordAndSave_DrawRecordListPageMarks::
    ld de, Tiles2Plus420Tiles_1F_4990
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

GameMode6_Update_ChooseRecordAndSave_UpdatePagedListCursor::
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
    ld hl, GameMode6_Update_ChooseRecordList_StoreBAtWordTableEntry_Bank24_52CE_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    farcall CopyListEntriesCell5NameToTextBuf0
    ld a, [wScreenStep]
    add $02
    ld [wScreenStep], a
    ret

GameMode6_Update_ChooseRecordAndSave_StoreBAtWordTableEntry_Bank24_52CE::
    ld a, [wTwoChoiceCursor]
    ld b, $c3
    ld hl, GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor_Data
    call StoreBAtWordTableEntry_Bank24_52CE
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

GameMode6_Update_ChooseRecordAndSave_ShowInfoOKYesN::
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
    farcall ShowString_Bank33_7045
    ld a, $6c
    call QueueSoundEffect
    ld de, TileRect_24_5B85
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

GameMode6_Update_ChooseRecordAndSave_HandleTwoChoiceCursorInput_0D::
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
    call GameMode6_Update_ChooseRecordAndSave_Case08_Multiply8
    call CopyMonsterNameToBuffer_B24
    ld a, $0a
    call ShowStringAInDefaultWindow_Bank24
    ld a, [wScreenStep]
    add $02
    ld [wScreenStep], a
    ret

GameMode6_Update_ChooseRecordAndSave_GameMode6_Update_ShowMonsterEg::
    ld de, TileRect_24_5A82
    ld hl, wWindowTileBuffer + $110
    lb bc, $08, $05
    call CopyRectTo20ByteRowsJp_Bank24
    ld a, $01
    ld b, $bc
    ld hl, GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    call GameMode6_Update_ShowMonsterEg
    call BGMapAddressAtScroll_Bank24
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_24
    ld a, [wListCursor]
    ld b, $c3
    ld hl, GameMode6_Update_ChooseRecordList_StoreBAtWordTableEntry_Bank24_52CE_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    ld a, [wScreenStep]
    sub $04
    ld [wScreenStep], a
    ret

GameMode6_Update_ChooseRecordAndSave_SetArg5ToListEntriesCell4::
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

GameMode6_Update_ChooseRecordAndSave_RunSaveGameSteps::
    farcall RunSaveGameSteps
    ld a, [wSaveStep]
    bit 7, a
    ret z
    call GameMode6_Update_WriteLinkSceneByte4BAndGameModeEtc
    ret

GameMode6_Update_Return::
    ret

GameMode6_Update_SwapMonstersMenu::
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

GameMode6_Update_SwapMonstersMenu_Case0D_SetScreenStep::
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
; 'Switch which egg?'
GameMode6_Update_SwitchEgg::
    ld a, [wScreenStep]
    jumptable
    dw GameMode6_Update_SwitchEgg_ShowInfoOKYesN
    dw GameMode6_Update_SwitchEgg_ListRecordsInUseWithByte6ESet
    dw GameMode6_Update_SwitchEgg_DrawRecordListPageSpeciesNames
    dw GameMode6_Update_SwitchEgg_DrawRecordListPageMarks
    dw GameMode6_Update_SwitchEgg_ShowSwitchWhichEgg
    dw GameMode6_Update_SwitchEgg_StoreBAtWordTableEntry_Bank24_52CE

GameMode6_Update_SwitchEgg_ShowInfoOKYesN::
    ld b, $46
    ld de, Tiles1Gfx_46_4001
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
    farcall ShowString_Bank33_7045
    call GameMode6_Update_FillTilesFromRequest
    ld a, [wBattleScene]
    cp $08
    jr nz, .call_game_mode6_update_copy_rect_to20_byte
    ld de, GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24_Data
    ld hl, wWindowTileBuffer + $f7
    lb bc, $06, $06
    call CopyRectTo20ByteRowsJp_Bank24
    jr .skip

.call_game_mode6_update_copy_rect_to20_byte:
    call GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24_Shared01_GameMode6_Update_Shared01_DecompressToVRAM

.skip:
    ld de, TileRect_24_5B10
    ld hl, wWindowTileBuffer + $64
    lb bc, $0d, $09
    call CopyRectTo20ByteRowsJp_Bank24
    ld a, [wListCursor]
    ld b, $bb
    ld hl, GameMode6_Update_ChooseRecordList_StoreBAtWordTableEntry_Bank24_52CE_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

GameMode6_Update_SwitchEgg_ListRecordsInUseWithByte6ESet::
    farcall ListRecordsInUseWithByte6ESet
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

GameMode6_Update_SwitchEgg_DrawRecordListPageSpeciesNames::
    xor a
    ld [wArg5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

GameMode6_Update_SwitchEgg_DrawRecordListPageMarks::
    ld de, Tiles2Plus420Tiles_1F_4990
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

GameMode6_Update_SwitchEgg_ShowSwitchWhichEgg::
    ld de, TileRect_24_5B85
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
    farcall ShowString_Bank33_7045
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

GameMode6_Update_SwitchEgg_StoreBAtWordTableEntry_Bank24_52CE::
    ld a, [wListCursor]
    ld b, $bc
    ld hl, GameMode6_Update_ChooseRecordList_StoreBAtWordTableEntry_Bank24_52CE_Data
    call StoreBAtWordTableEntry_Bank24_52CE
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

; by wScreenStep: the 'Info / OK / Yes / No' window, a record list and 'Switch with which?'
GameMode6_Update_SwitchMonster::
    ld a, [wScreenStep]
    jumptable
    dw GameMode6_Update_SwitchMonster_ShowInfoOKYesN
    dw GameMode6_Update_SwitchMonster_ListRecordsInUseWithByte6EClear
    dw GameMode6_Update_SwitchMonster_DrawRecordListPageNames
    dw GameMode6_Update_SwitchMonster_ToEggServiceMenu_Bank1B
    dw GameMode6_Update_SwitchMonster_ToEggServiceMenu_Bank1B
    dw GameMode6_Update_SwitchMonster_AdvanceScreenStep
    dw GameMode6_Update_SwitchMonster_ToEggServiceMenu_Bank1B
    dw GameMode6_Update_SwitchMonster_ShowSwitchWithWhich

GameMode6_Update_SwitchMonster_ShowInfoOKYesN::
    ld b, $46
    ld de, Tiles1Gfx_46_4001
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
    farcall ShowString_Bank33_7045
    call GameMode6_Update_SwitchMonster_Case00_FillTilesFromRequest
    ld a, [wBattleScene]
    cp $08
    jr z, .check_battle_scene
    call GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24_Shared01_GameMode6_Update_Shared01_DecompressToVRAM

.check_battle_scene:
    ld a, [wBattleScene]
    cp $08
    jr z, .skip
    call GameMode6_Update_SwitchMonster_Case00_LoadSRAMRecordWord
    jr .skip2

.skip:
    ld de, GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24_Data
    ld hl, wWindowTileBuffer + $f7
    lb bc, $06, $06
    call CopyRectTo20ByteRowsJp_Bank24

.skip2:
    ld de, TileRect_24_5AB8
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $0b
    call CopyRectTo20ByteRowsJp_Bank24
    ld a, [wListCursor]
    ld b, $bc
    ld hl, GameMode6_Update_ChooseRecordList_StoreBAtWordTableEntry_Bank24_52CE_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

GameMode6_Update_SwitchMonster_ListRecordsInUseWithByte6EClear::
    farcall ListRecordsInUseWithByte6EClear
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

GameMode6_Update_SwitchMonster_DrawRecordListPageNames::
    farcall DrawRecordListPageNames
    xor a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    ret

GameMode6_Update_SwitchMonster_ToEggServiceMenu_Bank1B::
    farcall EggServiceMenu_Bank1B
    ret

GameMode6_Update_SwitchMonster_AdvanceScreenStep::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

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
    farcall ShowString_Bank33_7045
    farcall EggServiceMenu_Bank1B
    ret

GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24_Shared01_GameMode6_Update_Shared01_DecompressToVRAM::
    ld a, [wLinkByteEB]
    and a
    ret nz
    call GameMode6_Update_Shared01_DecompressToVRAM
    ld de, TileRect_24_57F2
    ld hl, wWindowTileBuffer + $7a
    lb bc, $11, $02
    call CopyRectTo20ByteRowsJp_Bank24
    ret

GameMode6_Update_ObtainedEgg_Case00_WaitForVRAMAccess::
    ld a, [wIsCGB]
    and a
    ret z
    ld hl, rBGPI
    di
    call WaitForVRAMAccess
    ld a, $b8
    ld [hli], a
    ei
    ld de, GameMode6_Update_ObtainedEgg_Case00_WaitForVRAMAccess_Data2
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
    ld de, GameMode6_Update_ObtainedEgg_Case00_WaitForVRAMAccess_Data1
    ld hl, wWindowAttrBuffer + $7b
    ld b, $1c

.loop2:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop2
    ret

GameMode6_Update_SavePrompt_ShowYesNo::
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
    farcall ShowString_Bank33_7045
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
    farcall ShowString_Bank33_7045
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

GameMode6_Update_WriteLinkSceneByte4BAndGameModeEtc::
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
    ld [wLinkSceneByte4B], a
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
; hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
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
CopyBytesDEToHL_Bank24_4ECC::
    ld a, [de]
    inc de
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, CopyBytesDEToHL_Bank24_4ECC
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same
; 19 bytes appear in 5 banks)
CopyLow3BitsToWRAMBank2_Bank24_4ED5::
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
; SetDefaultStringWindow), then far-calls BeginStringDisplay_Bank33_7037 (E-0072)
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
    farcall BeginStringDisplay_Bank33_7037
    ret

; HL = wRecordBufB + $1, then copies up to 10 name bytes to wTextBuf0 with a $F0 terminator (E-0124)
; (E-0340: the address in its name read as its RAM name; was CopyWCA2CNameToTextBuf0)
CopyRecordBufBNameNameToTextBuf0::
    ld hl, wRecordBufB + MON_NAME
    jp CopyRecordBufANameNameToTextBuf0_Skip

; copies up to 10 name bytes from wRecordBufA + $1 (stopping at $F0) to wTextBuf0 with a $F0
; terminator (E-0124) (E-0340: the address in its name read as its RAM name; was
; CopyWC987NameToTextBuf0)
CopyRecordBufANameNameToTextBuf0::
    ld hl, wRecordBufA + MON_NAME

CopyRecordBufANameNameToTextBuf0_Skip::
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

GameMode6_Update_Case04_PageList_Case00_ReadPartyCountAndListCursorEtc::
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

GameMode6_Update_ChooseRecordAndSave_Case08_Multiply8::
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
; wDataBank) to wNameGlyphBuf; wDataBank is restored
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

GameMode6_Update_ChooseRecordList_Case0A_SetArg5ToListEntriesCell5::
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

GameMode6_Update_SwitchMonster_Case00_FillTilesFromRequest::
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

GameMode6_Update_Shared01_DecompressToVRAM::
    and $01
    and a
    jr nz, .skip
    ld de, GameMode6_Init_Data1
    ld b, $24
    jr .call_decompress_to_vram

.skip:
    ld de, Tiles1Plus600Gfx_24_6E13
    ld b, $24

.call_decompress_to_vram:
    ld hl, vTiles2
    call DecompressToVRAM
    ret

GameMode6_Init_UploadBGPalettes::
    ld a, [wBattleScene]
    cp $08
    ret z
    ld a, [wIsCGB]
    and a
    jp z, .check_battle_scene
    ld hl, wBattlerRecords + BATTLER_SPECIES
    ld de, wBattlerRecordSlot4 + BATTLER_SPECIES
    call GameMode6_Init_ReadLinkSceneByte4B
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
    call GameMode6_Init_Sub01_ReadScreenByteBD
    add hl, de
    pop de
    call LoadMonsterPictureAttributes
    ld a, [wScreenByteBD]
    cp $01
    jr z, .check_battle_scene
    ld hl, wBattlerRecordSlot1 + BATTLER_SPECIES
    ld de, wBattlerRecordSlot5 + BATTLER_SPECIES
    call GameMode6_Init_ReadLinkSceneByte4B
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
    call GameMode6_Init_Sub01_ReadScreenByteBD
    add hl, de
    pop de
    call LoadMonsterPictureAttributes
    ld a, [wScreenByteBD]
    cp $02
    jr z, .check_battle_scene
    ld hl, wBattlerRecordSlot2 + BATTLER_SPECIES
    ld de, wBattlerRecordSlot6 + BATTLER_SPECIES
    call GameMode6_Init_ReadLinkSceneByte4B
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
    call GameMode6_Init_Sub01_ReadScreenByteBD
    add hl, de
    pop de
    call LoadMonsterPictureAttributes

.check_battle_scene:
    ld a, [wBattleScene]
    cp $08
    jp nz, GameMode6_Init_Sub01_WriteVRAMByteInc_CallBGMapAddressAtScroll_Bank24
    ld hl, wWindowTileBuffer + $f7
    call GameMode6_Init_Sub01_WriteVRAMByteInc
    ld hl, wScreenTileBuffer + $93

GameMode6_Init_Sub01_WriteVRAMByteInc::
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
    call ReturnStub_51A3
    ret

GameMode6_Init_Sub01_WriteVRAMByteInc_CallBGMapAddressAtScroll_Bank24::
    call BGMapAddressAtScroll_Bank24
    ld de, $00e0
    add hl, de
    ld a, h
    ld [wArg5], a
    ld a, l
    ld [wArg6], a
    ld a, [wScreenByteBD]
    dec a
    ld c, $78
    call Multiply8
    ld de, TileRect_1F_720D
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

GameMode6_Init_Sub01_ReadScreenByteBD::
    push hl
    ld e, a
    ld d, $00
    ld a, [wScreenByteBD]
    dec a
    ld hl, GameMode6_Init_Sub01_ReadScreenByteBD_Data1
    jr z, .skip
    dec a
    ld hl, GameMode6_Init_Sub01_ReadScreenByteBD_Data2
    jr z, .skip
    ld hl, GameMode6_Init_Sub01_ReadScreenByteBD_Data3

.skip:
    add hl, de
    ld a, [hli]
    ld e, a
    ld a, [hl]
    ld d, a
    pop hl
    ret

GameMode6_Init_Sub01_ReadScreenByteBD_Data1::
    db $e7, $00, $00, $00, $00, $00

GameMode6_Init_Sub01_ReadScreenByteBD_Data2::
    db $e4, $00, $ea, $00, $00, $00

GameMode6_Init_Sub01_ReadScreenByteBD_Data3::
    db $e1, $00, $e7, $00, $ed, $00

; a bare ret (E-0115)
ReturnStub_51A3::
    ret

; on CGB with wBattleScene = 8: copies the 6 x 6 block
; CopyAttributeBlock51D3ToBattlerRecordSlot64_Data into the WRAM-bank-2 buffer at wWindowAttrBuffer
; + $F7 (20-byte rows) (E-0124) (E-0340: the address in its name read as its RAM name; was
; CopyAttributeBlock51D3ToWD25F)
CopyAttributeBlock51D3ToBattlerRecordSlot64::
    ld a, [wIsCGB]
    and a
    ret z
    ld a, [wBattleScene]
    cp $08
    ret nz
    ld hl, CopyAttributeBlock51D3ToBattlerRecordSlot64_Data
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

CopyAttributeBlock51D3ToBattlerRecordSlot64_Data::
    ds $24, $01

GameMode6_Init_ReadLinkSceneByte4B::
    ld a, [wLinkSceneByte4B]
    and a
    jr nz, .done
    ret

.done:
    ld l, e
    ld h, d
    ret

GameMode6_Init_LoadMonsterPicture::
    ld a, [wBattleScene]
    cp $08
    jr nz, .call_game_mode6_init_read_link_scene_byte4_b
    ld hl, wBattlerRecords + BATTLER_SPECIES
    ld de, wBattlerRecordSlot4 + BATTLER_SPECIES
    call GameMode6_Init_ReadLinkSceneByte4B
    ld a, [hli]
    ld e, a
    ld d, [hl]
    ld hl, vTiles2 + $200
    ld c, $01
    call LoadMonsterPicture
    ld a, $01
    ld [wScreenByteBD], a
    ret

.call_game_mode6_init_read_link_scene_byte4_b:
    ld hl, wBattlerRecords + BATTLER_SPECIES
    ld de, wBattlerRecordSlot4 + BATTLER_SPECIES
    call GameMode6_Init_ReadLinkSceneByte4B
    ld a, [hli]
    ld e, a
    ld d, [hl]
    ld hl, vTiles2
    ld c, $01
    call LoadMonsterPicture
    ld hl, wBattlerRecordSlot1 + BATTLER_SPECIES
    ld de, wBattlerRecordSlot5 + BATTLER_SPECIES
    call GameMode6_Init_ReadLinkSceneByte4B
    ld a, [hli]
    ld b, a
    ld a, [hld]
    or b
    and a
    jr nz, .skip
    ld a, $01
    ld [wScreenByteBD], a
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
    call GameMode6_Init_ReadLinkSceneByte4B
    ld a, [hli]
    ld b, a
    ld a, [hld]
    or b
    and a
    jr nz, .skip2
    ld a, $02
    ld [wScreenByteBD], a
    ret

.skip2:
    ld a, [hli]
    ld e, a
    ld d, [hl]
    ld hl, vTiles2 + $480
    ld c, $05
    call LoadMonsterPicture
    ld a, $03
    ld [wScreenByteBD], a
    ret

GameMode6_Update_SwitchMonster_Case00_LoadSRAMRecordWord::
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
; rSTAT bit 1 to clear; clobbers A; HL and DE advance (the same 20 bytes appear in 3 banks)
CopyTileBytesToVRAM_Bank24_52BA::
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
; A, DE, HL (the same 16 bytes appear in 4 banks)
StoreBAtWordTableEntry_Bank24_52CE::
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
    db ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT, ACTION_FIGHT ; $3C-$54: the list AppendMappedSkillsToWCA67 appends to, up to $FF (E-0237)
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
; banks)
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

GameMode6_Update_FillTilesFromRequest::
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
; and copies a name to the text buffer: a short object animation
GameMode6_Update_Save_ObjectScene::
    ld a, [wScreenSubStep]
    jumptable
    dw GameMode6_Update_Save_ObjectScene_WriteScreenCounterAndScreenSubStep
    dw GameMode6_Update_Save_ObjectScene_WriteObject2AndSpriteSlotsEtc
    dw GameMode6_Update_Save_ObjectScene_WriteScreenCounterAndScreenSubStep
    dw GameMode6_Update_Save_ObjectScene_WriteObject1AndScreenSubStep
    dw GameMode6_Update_Save_ObjectScene_WriteScreenCounterAndScreenSubStep
    dw GameMode6_Update_Save_ObjectScene_WriteObject5AndScreenSubStep
    dw GameMode6_Update_Save_ObjectScene_WriteScreenCounterAndScreenSubStep
    dw GameMode6_Update_Save_ObjectScene_WriteObject2AndScreenSubStep
    dw GameMode6_Update_Save_ObjectScene_CopyRecordBufANameNameToTextBuf0
    dw GameMode6_Update_Save_ObjectScene_WriteScreenCounterAndScreenSubStep
    dw GameMode6_Update_Save_ObjectScene_WriteScreenCounterAndScreenSubStep
    dw GameMode6_Update_Save_ObjectScene_WriteObject5AndObject1Etc
    dw GameMode6_Update_Save_ObjectScene_WriteObject2AndObject1Etc
    dw GameMode6_Update_Save_ObjectScene_WriteSpriteSlotsAndScreenSubStepEtc

GameMode6_Update_Save_ObjectScene_WriteObject2AndSpriteSlotsEtc::
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

GameMode6_Update_Save_ObjectScene_WriteScreenCounterAndScreenSubStep::
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

GameMode6_Update_Save_ObjectScene_WriteObject1AndScreenSubStep::
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

GameMode6_Update_Save_ObjectScene_WriteObject5AndScreenSubStep::
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

GameMode6_Update_Save_ObjectScene_WriteObject2AndScreenSubStep::
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

GameMode6_Update_Save_ObjectScene_CopyRecordBufANameNameToTextBuf0::
    call CopyRecordBufANameNameToTextBuf0
    ld a, $03
    call ShowStringAInDefaultWindow_Bank24
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

GameMode6_Update_Save_ObjectScene_WriteObject5AndObject1Etc::
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

GameMode6_Update_Save_ObjectScene_WriteObject2AndObject1Etc::
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

GameMode6_Update_Save_ObjectScene_WriteSpriteSlotsAndScreenSubStepEtc::
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
; GameMode6_Update_Save_ObjectScene
GameMode6_Update_SavePrompt_ObjectScene::
    ld a, [wScreenSubStep]
    jumptable
    dw GameMode6_Update_SavePrompt_ObjectScene_WriteScreenCounterAndScreenSubStep
    dw GameMode6_Update_SavePrompt_ObjectScene_WriteSpriteSlotsAndScreenSubStep
    dw GameMode6_Update_SavePrompt_ObjectScene_WriteScreenCounterAndScreenSubStep
    dw GameMode6_Update_SavePrompt_ObjectScene_WriteObject2AndObject1Etc
    dw GameMode6_Update_SavePrompt_ObjectScene_WriteScreenCounterAndScreenSubStep
    dw GameMode6_Update_SavePrompt_ObjectScene_WriteObject5AndScreenSubStep
    dw GameMode6_Update_SavePrompt_ObjectScene_WriteScreenCounterAndScreenSubStep
    dw GameMode6_Update_SavePrompt_ObjectScene_WriteObject2AndScreenSubStep
    dw GameMode6_Update_SavePrompt_ObjectScene_CopyRecordBufBNameNameToTextBuf0
    dw GameMode6_Update_SavePrompt_ObjectScene_WriteScreenCounterAndScreenSubStep
    dw GameMode6_Update_SavePrompt_ObjectScene_WriteScreenCounterAndScreenSubStep
    dw GameMode6_Update_SavePrompt_ObjectScene_WriteObject1AndScreenSubStep
    dw GameMode6_Update_SavePrompt_ObjectScene_WriteObject5AndSpriteSlotsEtc
    dw GameMode6_Update_SavePrompt_ObjectScene_WriteObject2AndSpriteSlotsEtc

GameMode6_Update_SavePrompt_ObjectScene_WriteSpriteSlotsAndScreenSubStep::
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

GameMode6_Update_SavePrompt_ObjectScene_WriteObject2AndObject1Etc::
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

GameMode6_Update_SavePrompt_ObjectScene_WriteScreenCounterAndScreenSubStep::
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

GameMode6_Update_SavePrompt_ObjectScene_WriteObject5AndScreenSubStep::
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

GameMode6_Update_SavePrompt_ObjectScene_WriteObject2AndScreenSubStep::
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

GameMode6_Update_SavePrompt_ObjectScene_CopyRecordBufBNameNameToTextBuf0::
    call CopyRecordBufBNameNameToTextBuf0
    ld a, $04
    call ShowStringAInDefaultWindow_Bank24
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

GameMode6_Update_SavePrompt_ObjectScene_WriteObject1AndScreenSubStep::
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

GameMode6_Update_SavePrompt_ObjectScene_WriteObject5AndSpriteSlotsEtc::
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

GameMode6_Update_SavePrompt_ObjectScene_WriteObject2AndSpriteSlotsEtc::
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

GameMode6_Update_UpdateAndDrawSpriteSlots::
    farcall UpdateAndDrawSpriteSlots
    ld a, [wRecordBufB + MON_EGG]
    and a
    ret z
    farcall DrawFieldSprites
    ret

GameMode6_Update_Save_TestFlagBit::
    ld de, $0000
    call TestFlagBit
    jr c, .skip
    ld hl, GameMode6_Update_Save_TestFlagBit_Data5
    jr .call_copy_bytes_de_from_hl_bank24

.skip:
    ld hl, SpriteSlotsInit_24_5BF9

.call_copy_bytes_de_from_hl_bank24:
    ld de, wSpriteSlots
    ld b, $10
    call CopyBytesDEFromHL_Bank24
    ld hl, Object1Init_24_5C09
    ld de, wObject1
    ld b, $10
    call CopyBytesDEFromHL_Bank24
    ld de, $0000
    call TestFlagBit
    jr c, .skip2
    ld hl, GameMode6_Update_Save_TestFlagBit_Data1
    jr .call_copy_bytes_de_from_hl_bank242

.skip2:
    ld hl, GameMode6_Update_Save_TestFlagBit_Data2

.call_copy_bytes_de_from_hl_bank242:
    ld de, hTemp0
    ld b, $06
    call CopyBytesDEFromHL_Bank24
    farcall DecompressGraphicsTemp0ToTemp4
    ld hl, GameMode6_Update_Save_TestFlagBit_Data3
    ld de, hTemp0
    ld b, $06
    call CopyBytesDEFromHL_Bank24
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, [wRecordBufB + MON_EGG]
    and a
    jr nz, .set_temp0_to_0D
    ld hl, GameMode6_Update_Save_TestFlagBit_Data4
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
    ld hl, GameMode6_Update_Save_TestFlagBit_Data6
    jr .call_copy_bytes_de_from_hl_bank243

.skip3:
    ld hl, Object2Init_24_5C29

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

; the same 7 bytes as CopyBytesDEFromHL (CopyBytesDEFromHL)
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
TileRect_24_5792::
    db $e0, $e1, $e2, $e3, $e4, $e5, $c3, $e6, $e7, $e8, $e9, $ea, $eb, $ec, $ed, $ee, $ef ; id 0
    db $f0, $f1, $f2, $f3, $f4, $f5, $c3, $f6, $f7, $f8, $f9, $fa, $fb, $fc, $fd, $fe, $ff ; id 1

GameMode6_Update_ObtainedEgg_CopyRectTo20ByteRowsJp_Bank24_Data::
    db $c3, $c3, $c3, $c3, $c3, $e0, $e1, $e2, $e3, $e4, $e5, $e6, $e7, $c3, $c3, $c3
    db $c3, $c3, $c3, $c3, $c3, $c3, $f0, $f1, $f2, $f3, $f4, $f5, $f6, $f7, $c3, $c3
    db $c3, $c3

GameMode6_Update_ObtainedEgg_Case00_WaitForVRAMAccess_Data1::
    ds $1c, $07

TileRect_24_57F2::
    db $00, $01, $02, $03, $04, $05, $c3, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f ; id 0
    db $10, $11, $12, $13, $14, $15, $c3, $16, $17, $18, $19, $1a, $1b, $1c, $1d, $1e, $1f ; id 1

; record: 14 x 13 tiles, one row per line
TileRect_24_5814::
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

GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24_Data::
    ds $78, $c3

; record: 20 x 5 tiles, one row per line
TileRect_24_5942::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

TileRect_24_59A6::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8a, $8b, $8c, $8d, $8e, $8f, $90, $91, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $92, $93, $94, $95, $96, $97, $98, $99, $9a, $9b, $9c, $9d, $9e, $9f, $a0, $a1, $a2, $a3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; record: 6 x 5 tiles, one row per line
TileRect_24_5A0A::
    db $b0, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $6d, $6e, $6f, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $70, $71, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; id 4

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 5 tiles, one row per line
TileRect_24_5A28::
    db $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $76, $77, $78, $79, $7a, $7b, $7c, $b7 ; id 1
    db $b2, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b7, $7f, $7f, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b5, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; record: 10 x 5 tiles, one row per line
TileRect_24_5A50::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $76, $77, $78, $79, $7a, $7b, $7c, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $7d, $7f, $7f, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

TileRect_24_5A82::
    db $b5, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $76, $77, $78, $79, $7a, $7b, $7c, $b7 ; id 1
    db $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $7d, $7f, $7f, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor_Data::
    db $23, $c4, $4b, $c4

GameMode6_Update_ChooseRecordList_StoreBAtWordTableEntry_Bank24_52CE_Data::
    db $79, $c3, $a1, $c3, $c9, $c3, $f1, $c3, $19, $c4

; record: 8 x 11 tiles, one row per line
TileRect_24_5AB8::
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
TileRect_24_5B10::
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
TileRect_24_5B85::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $70, $71, $72, $73, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $74, $75, $c3, $c3, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4
    db $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2a, $2b, $2c, $2d, $2e, $2f
    db $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3a, $3b, $3c, $3d, $3e, $3f
    db $40, $41, $42, $43

GameMode6_Update_Save_TestFlagBit_Data1::
    db $00, $00, $01, $04, $00, $80

GameMode6_Update_Save_TestFlagBit_Data2::
    db $01, $00, $01, $01, $00, $80

GameMode6_Update_Save_TestFlagBit_Data3::
    db $0c, $00, $01, $05, $00, $81

GameMode6_Update_Save_TestFlagBit_Data4::
    db $00, $00, $00, $02, $00, $82

GameMode6_Update_Save_TestFlagBit_Data5::
    db $00, $01, $00, $00, $a0, $40, $04, $03, $00, $00, $00, $a0, $40, $04, $00, $00

; CopyBytesDEFromHL_Bank24 copies these 16 bytes to wSpriteSlots (E-0264)
; record: 16 bytes copied to wSpriteSlots
SpriteSlotsInit_24_5BF9::
    db $00, $01, $01, $00, $a0, $40, $01, $03, $00, $00, $00, $a0, $40, $04, $00, $00 ; entry 0

; CopyBytesDEFromHL_Bank24 copies these 16 bytes to wObject1 (E-0264)
; record: 16 bytes copied to wObject1
Object1Init_24_5C09::
    db $00, $01, $0c, $00, $e0, $40, $05, $01, $10, $00, $00, $e0, $40, $04, $00, $00 ; entry 0

GameMode6_Update_Save_TestFlagBit_Data6::
    db $00, $00, $00, $00, $d0, $40, $02, $01, $20, $00, $00, $d0, $40, $04, $00, $00

; CopyBytesDEFromHL_Bank24 copies these 16 bytes to wObject2 (E-0264)
; record: 16 bytes copied to wObject2
Object2Init_24_5C29::
    db $00, $00, $00, $00, $b0, $40, $02, $03, $20, $00, $00, $b0, $40, $04, $00, $00 ; entry 0

GameMode6_Update_SavePrompt_Case08_WriteMenuInputResultAndTwoChoiceCursorEtc::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_game_mode6_update_save_prompt_case08
    bit 7, a
    jr nz, .call_game_mode6_update_save_prompt_case082
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, .call_game_mode6_update_save_prompt_case083
    bit 1, a
    jr nz, .set_menu_input_result_to_FE
    call GameMode6_Update_SavePrompt_Case08_Sub01_WriteScreenCounter
    xor a
    ld [wMenuInputResult], a
    ret

.call_game_mode6_update_save_prompt_case08:
    call GameMode6_Update_SavePrompt_Case08_Sub01_ReadTwoChoiceCursor_Sub03
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

.call_game_mode6_update_save_prompt_case082:
    call GameMode6_Update_SavePrompt_Case08_Sub01_ReadTwoChoiceCursor_Sub03
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
    call GameMode6_Update_SavePrompt_Case08_Sub01_ReadTwoChoiceCursor
    ld a, $69
    call QueueSoundEffect
    ld a, $fd
    ld [wMenuInputResult], a
    ret

.call_game_mode6_update_save_prompt_case083:
    call GameMode6_Update_SavePrompt_Case08_Sub01_StepBGMapAddressBackOnScrollWrap
    ld a, $69
    call QueueSoundEffect
    ld a, $ff
    ld [wMenuInputResult], a
    ret

.set_menu_input_result_to_FE:
    ld a, $fe
    ld [wMenuInputResult], a
    ret

GameMode6_Update_SavePrompt_Case08_Sub01_WriteScreenCounter::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, GameMode6_Update_SavePrompt_Case08_Sub01_ReadTwoChoiceCursor
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp $10
    jr c, GameMode6_Update_SavePrompt_Case08_Sub01_ReadTwoChoiceCursor
    cp $18
    jr c, GameMode6_Update_SavePrompt_Case08_Sub01_ReadTwoChoiceCursor_Sub03
    xor a
    ld [wScreenCounter], a

GameMode6_Update_SavePrompt_Case08_Sub01_ReadTwoChoiceCursor::
    ld b, $bb
    jr GameMode6_Update_SavePrompt_Case08_Sub01_StepBGMapAddressBackOnScrollWrap_ReadTwoChoiceCursor

GameMode6_Update_SavePrompt_Case08_Sub01_ReadTwoChoiceCursor_Sub03::
    ld b, $c3
    jr GameMode6_Update_SavePrompt_Case08_Sub01_StepBGMapAddressBackOnScrollWrap_ReadTwoChoiceCursor

GameMode6_Update_SavePrompt_Case08_Sub01_StepBGMapAddressBackOnScrollWrap::
    ld b, $bc

GameMode6_Update_SavePrompt_Case08_Sub01_StepBGMapAddressBackOnScrollWrap_ReadTwoChoiceCursor::
    ld a, [wTwoChoiceCursor]
    add a
    ld hl, GameMode6_Update_SavePrompt_Case08_Sub01_StepBGMapAddressBackOnScrollWrap_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank24_5CEB
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
; hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
BGMapAddressAtScroll_Bank24_5CEB::
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

GameMode6_Update_SavePrompt_Case08_Sub01_StepBGMapAddressBackOnScrollWrap_Data::
    db $2b, $01, $6b, $01

; ld de, this bank's string table / BeginStringDisplay
BeginStringDisplay_Bank24::
    ld de, StringCategories_24_5D25
    call BeginStringDisplay
    ret
    db $11, $25, $5d, $cd, $fe, $25, $c9

; BeginStringDisplay_Bank24 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
ShowString_Bank24::
    call BeginStringDisplay_Bank24
    call RunStringDisplayToEnd
    ret

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_24_5D25::
    dw StringList_24_5D27 ; id 0

; category list of StringCategories_24_5D25; one pointer per wStringIndex (E-0217)
; record: string
StringList_24_5D27::
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
    dw PriestMenu_SwapMonstersMenu
    dw PriestMenu_ShowServices
    dw PriestMenu_PayForService

PriestMenu_SwapMonstersMenu::
    farcall SwapMonstersMenu
    ld a, $0b
    ld [wMessageMode], a
    ret

; by wScreenStep: the 'Revive / Detox / Uncurse' window and the gold panel
PriestMenu_ShowServices::
    ld a, [wScreenStep]
    jumptable
    dw PriestMenu_ShowServices_ShowRviDoxUncurt
    dw PriestMenu_ShowServices_DrawGoldPanel_Bank24
    dw PriestMenu_ShowServices_BGMapAddressAtScroll_Bank24_6866

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

PriestMenu_ShowServices_DrawGoldPanel_Bank24::
    ld de, TileRect_24_6B8B
    ld hl, wWindowTileBuffer + $64
    lb bc, $0a, $09
    call CopyRectTo20ByteRows_Bank24
    call DrawGoldPanel_Bank24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

PriestMenu_ShowServices_BGMapAddressAtScroll_Bank24_6866::
    call BGMapAddressAtScroll_Bank24_6866
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
; with two choices and SubtractArg1AmountFromGold
PriestMenu_PayForService::
    ld a, [wScreenStep]
    jumptable
    dw PriestMenu_PayForService_UpdateListCursorListCursor
    dw PriestMenu_PayForService_CopyTileBytesToVRAM_Bank24
    dw PriestMenu_PayForService_CopyRectTo20ByteRows_Bank24
    dw PriestMenu_PayForService_WriteScreenStepAndTwoChoiceCursorEtc
    dw PriestMenu_PayForService_DrawGoldPanel_Bank24
    dw PriestMenu_PayForService_LoadSRAMRecordByte
    dw PriestMenu_PayForService_WriteListEntriesAndGrid2CursorXEtc
    dw PriestMenu_PayForService_QueueSoundEffect
    dw PriestMenu_PayForService_UpdateTwoChoiceCursor_Bank1D
    dw PriestMenu_PayForService_WriteScreenStepAndScriptCommandTypeEtc
    dw PriestMenu_PayForService_SubtractArg1AmountFromGold
    dw PriestMenu_PayForService_QueueMusic
    dw PriestMenu_PayForService_WriteScreenCounterAndScreenStep
    dw PriestMenu_PayForService_CopyBuffers
    dw PriestMenu_PayForService_WriteScreenCounterAndScreenStep
    dw PriestMenu_PayForService_FillTilesFromRequest
    dw PriestMenu_PayForService_SRAMRecordAddress
    dw PriestMenu_PayForService_WriteTwoChoiceCursorAndScriptCommandTypeEtc

PriestMenu_PayForService_UpdateListCursorListCursor::
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
    jr z, .call_priest_menu_pay_for_service_load_sram
    cp $01
    jr z, .call_priest_menu_pay_for_service_load_sram2
    cp $02
    jr z, .call_priest_menu_pay_for_service_load_sram3
    jr .set_two_choice_cursor_to_04

.call_priest_menu_pay_for_service_load_sram:
    ld b, $80
    call PriestMenu_PayForService_LoadSRAMRecordByte_Shared01
    cp $ff
    jr z, .clear_two_choice_cursor
    ld a, $01
    jr .set_two_choice_cursor

.call_priest_menu_pay_for_service_load_sram2:
    ld b, $04
    call PriestMenu_PayForService_LoadSRAMRecordByte_Shared01
    cp $ff
    jr z, .clear_two_choice_cursor
    ld a, $02
    jr .set_two_choice_cursor

.call_priest_menu_pay_for_service_load_sram3:
    ld b, $01
    call PriestMenu_PayForService_LoadSRAMRecordByte_Shared01
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
    ld hl, PriestMenu_PayForService_UpdateListCursorListCursor_Data
    call StoreBAtWordTableEntry_Bank24
    xor a
    ld [wChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

PriestMenu_PayForService_CopyTileBytesToVRAM_Bank24::
    ld a, [wListCursor]
    ld [wTwoChoiceCursor], a
    ld hl, Tiles_24_6239
    ld de, vTiles1 + $7e0
    call CopyTileBytesToVRAM_Bank24
    ld hl, Tiles_24_6249
    call CopyTileBytesToVRAM_Bank24
    ld hl, Tiles_24_6259
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
Tiles_24_6239::
    db $ff, $06, $ff, $06, $ff, $06, $ff, $ff, $ff, $ff, $ff, $00, $ff, $00, $ff, $00 ; entry 0

; HL = $6249 and 1 calls to a 16-byte VRAM copier (CopyTileBytesToVRAM_*), one tile each (E-0238)
Tiles_24_6249::
    db $ff, $00, $ff, $00, $ff, $00, $ff, $f8, $ff, $fc, $ff, $0e, $ff, $06, $ff, $06 ; entry 0

; HL = $6259 and 1 calls to a 16-byte VRAM copier (CopyTileBytesToVRAM_*), one tile each (E-0238)
Tiles_24_6259::
    db $ff, $60, $ff, $60, $ff, $60, $ff, $1f, $ff, $3f, $ff, $70, $ff, $60, $ff, $60 ; entry 0

PriestMenu_PayForService_CopyRectTo20ByteRows_Bank24::
    ld de, TileRect_24_6C49
    ld hl, wWindowTileBuffer + $dc
    lb bc, $0b, $07
    call CopyRectTo20ByteRows_Bank24
    call PriestMenu_PayForService_Case02_PriestMenu_PayForService_WriteMarkC0
    call BGMapAddressAtScroll_Bank24_6866
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectNoOrigin_Bank24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

PriestMenu_PayForService_WriteScreenStepAndTwoChoiceCursorEtc::
    call PriestMenu_PayForService_Case03_WriteMenuInputResultAndChoiceCursorEtc
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

PriestMenu_PayForService_DrawGoldPanel_Bank24::
    ld b, $00
    ld c, $07
    ld hl, $0244
    ld de, $0078
    xor a
    ld [wArg1], a
    ld a, $0b
    ld [wArg2], a
    call PriestMenu_PayForService_Case04_CopyBytesDEToHL_Bank24
    ld de, TileRect_24_6B8B
    ld hl, wWindowTileBuffer + $64
    lb bc, $0a, $09
    call CopyRectTo20ByteRows_Bank24
    call DrawGoldPanel_Bank24
    ld a, [wListCursor]
    ld b, $bb
    ld hl, PriestMenu_PayForService_UpdateListCursorListCursor_Data
    call StoreBAtWordTableEntry_Bank24
    call BGMapAddressAtScroll_Bank24_6866
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectNoOrigin_Bank24
    ld a, [wListCursor]
    ld b, $c3
    ld hl, PriestMenu_PayForService_UpdateListCursorListCursor_Data
    call StoreBAtWordTableEntry_Bank24
    xor a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

PriestMenu_PayForService_LoadSRAMRecordByte::
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

PriestMenu_PayForService_WriteListEntriesAndGrid2CursorXEtc::
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

PriestMenu_PayForService_QueueSoundEffect::
    ld a, $6c
    call QueueSoundEffect
    ld de, TileRect_24_6479
    ld hl, wWindowTileBuffer + $112
    lb bc, $06, $05
    call CopyRectTo20ByteRows_Bank24
    ld a, [wChoiceCursor]
    ld b, $bc
    ld hl, PriestMenu_PayForService_QueueSoundEffect_Data
    call StoreBAtWordTableEntry_Bank24
    call BGMapAddressAtScroll_Bank24_6866
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
TileRect_24_6479::
    db $b0, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $ce, $cf, $df, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $a5, $f5, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; id 4

PriestMenu_PayForService_UpdateTwoChoiceCursor_Bank1D::
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
    call PriestMenu_PayForService_BGMapAddressAtScroll_Bank24_6866
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
    call PriestMenu_PayForService_BGMapAddressAtScroll_Bank24_6866
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

PriestMenu_PayForService_WriteScreenStepAndScriptCommandTypeEtc::
    call PriestMenu_PayForService_BGMapAddressAtScroll_Bank24_6866
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

PriestMenu_PayForService_SubtractArg1AmountFromGold::
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
    call BGMapAddressAtScroll_Bank24_6866
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectNoOrigin_Bank24
    call PriestMenu_PayForService_CopyRecordNameToNameGlyphBuf
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

PriestMenu_PayForService_QueueMusic::
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
    jr z, .call_bg_map_address_at_scroll_bank24_6866
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank24
    ld hl, wWindowAttrBuffer
    ld de, wScreenAttrBuffer + $104
    ld bc, $0064
    call CopyLow3BitsToWRAMBank2_Bank24

.call_bg_map_address_at_scroll_bank24_6866:
    call BGMapAddressAtScroll_Bank24_6866
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectNoOrigin_Bank24
    call BGMapAddressAtScroll_Bank24_6866
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

PriestMenu_PayForService_FillTilesFromRequest::
    ld hl, wTextWindowTileLo
    xor a
    ld [hli], a
    ld a, $88
    ld [hli], a
    ld a, $02
    ld [hli], a
    ld [hl], $12
    call FillTilesFromRequest
    ld de, TileRect_24_6BE5
    ld hl, wWindowTileBuffer
    lb bc, $14, $05
    call CopyRectTo20ByteRows_Bank24
    call BGMapAddressAtScroll_Bank24_6866
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

PriestMenu_PayForService_WriteScreenCounterAndScreenStep::
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

; two CopyBytes steps
PriestMenu_PayForService_CopyBuffers::
    ld a, [wScreenSubStep]
    jumptable
    dw PriestMenu_PayForService_CopyBuffers_CopyBytes
    dw PriestMenu_PayForService_CopyBuffers_CopyBytes_Case01_RestartMapMusic

PriestMenu_PayForService_CopyBuffers_CopyBytes::
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

PriestMenu_PayForService_CopyBuffers_CopyBytes_Case01_RestartMapMusic::
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

PriestMenu_PayForService_SRAMRecordAddress::
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
    ld de, PriestMenu_PayForService_SRAMRecordAddress_Data
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
    call PriestMenu_PayForService_CopyRecordNameToNameGlyphBuf
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

PriestMenu_PayForService_SRAMRecordAddress_Data::
    db $00, $fb, $fe

PriestMenu_PayForService_WriteTwoChoiceCursorAndScriptCommandTypeEtc::
    ld b, $80
    call PriestMenu_PayForService_LoadSRAMRecordByte_Shared01
    cp $ff
    jr z, .clear_two_choice_cursor
    ld b, $04
    call PriestMenu_PayForService_LoadSRAMRecordByte_Shared01
    cp $ff
    jr z, .clear_two_choice_cursor
    ld b, $01
    call PriestMenu_PayForService_LoadSRAMRecordByte_Shared01
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
; same 58 bytes appear in 8 banks)
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
; hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
BGMapAddressAtScroll_Bank24_6866::
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
; 18 bytes appear in 7 banks)
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
; A, DE, HL (the same 14 bytes appear in 8 banks)
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

; copies an 8 x 3 frame (TileRect_24_68EB) into the screen buffer at wWindowTileBuffer + $70,
; converts wGold to packed BCD (Number24ToPackedBCD) and UnpackBCDToDigitsArg1, then writes the
; digits as tiles $E0 + d at wWindowTileBuffer + $86 (E-0074)
DrawGoldPanel_Bank24::
    ld de, TileRect_24_68EB
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
TileRect_24_68EB::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $bf, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 2

PriestMenu_PayForService_LoadSRAMRecordByte_Shared01::
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

PriestMenu_PayForService_Case02_PriestMenu_PayForService_WriteMarkC0::
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

; writes tile $C0 at the table address for entry E
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

; writes tile $C1 at the table address for entry E
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

; writes tile $C2 at the table address for entry E
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

PriestMenu_PayForService_WriteMarkC0_Data::
    db $f7, $c3, $1f, $c4, $47, $c4

PriestMenu_PayForService_WriteMarkC1_Data::
    db $f8, $c3, $20, $c4, $48, $c4

PriestMenu_PayForService_WriteMarkC2_Data::
    db $f9, $c3, $21, $c4, $49, $c4

PriestMenu_PayForService_Case03_WriteMenuInputResultAndChoiceCursorEtc::
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_priest_menu_pay_for_service_case03_sub01
    bit 7, a
    jr nz, .call_priest_menu_pay_for_service_case03_sub012
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, .call_queue_sound_effect
    bit 1, a
    jr nz, .set_menu_input_result_to_FE
    call PriestMenu_PayForService_Case03_Sub01_WriteCursorBlinkAE
    xor a
    ld [wMenuInputResult], a
    ret

.call_priest_menu_pay_for_service_case03_sub01:
    call PriestMenu_PayForService_Case03_Sub01_ReadChoiceCursor_Sub03
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

.call_priest_menu_pay_for_service_case03_sub012:
    call PriestMenu_PayForService_Case03_Sub01_ReadChoiceCursor_Sub03
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
    call PriestMenu_PayForService_Case03_Sub01_ReadChoiceCursor
    ld a, $69
    call QueueSoundEffect
    ld a, $fd
    ld [wMenuInputResult], a
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call PriestMenu_PayForService_Case03_Sub01_StepBGMapAddressBackOnScrollWrap
    ld a, $ff
    ld [wMenuInputResult], a
    ret

.set_menu_input_result_to_FE:
    ld a, $fe
    ld [wMenuInputResult], a
    ret

PriestMenu_PayForService_Case03_Sub01_WriteCursorBlinkAE::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, PriestMenu_PayForService_Case03_Sub01_ReadChoiceCursor
    ld a, [wCursorBlinkAE]
    inc a
    ld [wCursorBlinkAE], a
    cp $10
    jr c, PriestMenu_PayForService_Case03_Sub01_ReadChoiceCursor
    cp $18
    jr c, PriestMenu_PayForService_Case03_Sub01_ReadChoiceCursor_Sub03
    xor a
    ld [wCursorBlinkAE], a

PriestMenu_PayForService_Case03_Sub01_ReadChoiceCursor::
    ld b, $bb
    jr PriestMenu_PayForService_Case03_Sub01_StepBGMapAddressBackOnScrollWrap_ReadChoiceCursor

PriestMenu_PayForService_Case03_Sub01_ReadChoiceCursor_Sub03::
    ld b, $c3
    jr PriestMenu_PayForService_Case03_Sub01_StepBGMapAddressBackOnScrollWrap_ReadChoiceCursor

PriestMenu_PayForService_Case03_Sub01_StepBGMapAddressBackOnScrollWrap::
    ld b, $bc

PriestMenu_PayForService_Case03_Sub01_StepBGMapAddressBackOnScrollWrap_ReadChoiceCursor::
    ld a, [wChoiceCursor]
    add a
    ld hl, PriestMenu_PayForService_Case03_Sub01_StepBGMapAddressBackOnScrollWrap_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank24_6866
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

PriestMenu_PayForService_Case03_Sub01_StepBGMapAddressBackOnScrollWrap_Data::
    db $e1, $00, $21, $01, $61, $01

PriestMenu_PayForService_Case04_CopyBytesDEToHL_Bank24::
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
    jr nz, PriestMenu_PayForService_Case04_CopyBytesDEToHL_Bank24
    ret

PriestMenu_PayForService_BGMapAddressAtScroll_Bank24_6866::
    ld hl, wWindowTileBuffer + $112
    ld de, wScreenTileBuffer + $ae
    ld c, $00
    call PriestMenu_PayForService_Shared02_CopyBytesDEToHL_Bank24
    ld a, [wIsCGB]
    and a
    jr z, .call_bg_map_address_at_scroll_bank24_6866
    ldh a, [rSVBK]
    set 1, a
    ldh [rSVBK], a
    ld hl, wWindowAttrBuffer + $112
    ld de, wWorkBuf + $11
    ld c, $00
    call PriestMenu_PayForService_Shared02_CopyBytesDEToHL_Bank24
    ldh a, [rSVBK]
    res 1, a
    ldh [rSVBK], a

.call_bg_map_address_at_scroll_bank24_6866:
    call BGMapAddressAtScroll_Bank24_6866
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectNoOrigin_Bank24
    ret

PriestMenu_PayForService_Shared02_CopyBytesDEToHL_Bank24::
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
    jr c, PriestMenu_PayForService_Shared02_CopyBytesDEToHL_Bank24
    ret

PriestMenu_PayForService_CopyRecordNameToNameGlyphBuf::
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
TileRect_24_6B8B::
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
TileRect_24_6BE5::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8a, $8b, $8c, $8d, $8e, $8f, $90, $91, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $92, $93, $94, $95, $96, $97, $98, $99, $9a, $9b, $9c, $9d, $9e, $9f, $a0, $a1, $a2, $a3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; record: 11 x 7 tiles, one row per line
TileRect_24_6C49::
    db $ef, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $b9, $fe, $ff ; id 0
    db $b6, $c3, $d0, $d1, $d2, $d3, $d4, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $d5, $d6, $d7, $d8, $d9, $c3, $c3, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $da, $db, $dc, $dd, $de, $c3, $c3, $c3, $b7 ; id 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 6

PriestMenu_PayForService_UpdateListCursorListCursor_Data::
    db $79, $c3, $a1, $c3, $c9, $c3, $f1, $c3

PriestMenu_PayForService_QueueSoundEffect_Data::
    db $f1, $c3, $19, $c4, $41, $c4

GameMode6_Update_ObtainedEgg_Case00_WaitForVRAMAccess_Data2::
    ds $38, $00
    db $1f, $00, $ff, $7f, $00, $7e, $00, $00

; LZSS-compressed: 303 bytes that expand to 512 (E-0016, E-0017)
GameMode6_Init_Data1::
    INCBIN "gfx/misc/game_mode6_init_data1.lz"

; LZSS-compressed: 315 bytes that expand to 512 (E-0016, E-0017)
Tiles1Plus600Gfx_24_6E13::
    INCBIN "gfx/misc/tiles1_plus600_gfx_24_6_e13.lz"

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
    ld [wCursorBlinkB8], a
    push hl
    ld hl, $4010
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
    ld a, [wCursorBlinkB8]
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
    ld a, [wCursorBlinkB8]
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
    dw ItemDescription_Heaven_78A7 ; id 58
    dw ItemDescription_Heaven_78CB ; id 59
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
    dw ItemDescription_Smart_79F7 ; id 74
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

ItemDescription_Heaven_78A7::
    db "A legendary armor<LINE>"
    db "found in a tower.@"

ItemDescription_Heaven_78CB::
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

ItemDescription_Smart_79F7::
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
