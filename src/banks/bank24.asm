SECTION "Bank 24", ROMX[$4000], BANK[$24]
    db $24

; start-up for wGameMode = 6; forcing this mode on the emulator shows: victory screen when forced (E-0029)
; 1 call site from 1 routine (e.g. RunGameModeInit_ToGameMode6_Init)
; reads: wLinkRules, wBattleScene, wRecordBufA, wTextWindowState, wLinkSceneByte4C, wSaveStep
; writes: hScrollY, hScrollX, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wBattlerRecords, wTextWindowState, ...
; points at: wScreenState
GameMode6_Init::
Func_024_4001:: ; address name
    ld hl, wScreenState
    ld bc, $006F

.loop:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop
    ld a, [wLinkRules + $9]
    and a, a
    jr nz, .check_battle_scene
    jr .skip

.check_battle_scene:
    ld a, [wBattleScene]
    cp a, $80
    jr z, .skip
    and a, $01
    and a, a
    jr nz, .check_record_buf_a
    jr .skip

.check_record_buf_a:
    ld a, [wRecordBufA]
    and a, a
    jr z, .skip
    ld a, [wLinkSceneByte4C]
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a

.loop2:
    farcall RunSaveGameSteps
    ld a, [wSaveStep]
    bit 7, a
    jr z, .loop2
    ld hl, wScreenState
    ld bc, $006F

.loop3:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop3

.skip:
    ld b, $46
    ld de, Tiles1Gfx_46_4001
    ld hl, vTiles1
    call DecompressToVRAM
    farcall ClearScreenBufferAndAttributes_BankF1
    xor a, a
    ldh [hScrollY], a
    ldh [hScrollX], a
    call BGMapAddressAtScroll_Bank24
    ld bc, $140D
    ld de, $01CC
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
    cp a, $08
    jr nz, .call_game_mode6_init_load_monster_picture
    ld a, [wRecordBufA + MON_SPECIES]
    ld [wBattlerRecords + BATTLER_SPECIES], a
    ld a, [wRecordBufA + MON_SPECIES + 1]
    ld [wBattlerRecords + BATTLER_SPECIES + 1], a

.call_game_mode6_init_load_monster_picture:
    call GameMode6_Init_LoadMonsterPicture
    ld a, [wBattleScene]
    cp a, $80
    jr nz, .skip2
    ld de, GameMode6_Init_Data_6F4E
    ld b, $24
    jr .call_decompress_to_ram_locked

.skip2:
    and a, $01
    and a, a
    jr nz, .skip3
    ld de, GameMode6_Init_Data_6CE4
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
    and a, $03
    jr nz, .loop4
    ld a, $FC
    call StartPaletteFade
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    xor a, a
    ld [wSpriteSlotCount], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $01
    jp ClearSGBPacketBuffer_CheckLinkMode

; per-frame routine for wGameMode = 6
; 2 call sites from 2 routines (e.g. RunGameModeUpdate_ToGameMode6_Update, RunLinkSession8Exchange_ObjectScene_GameMode6_Update)
; reads: wFadeState, wTextFlags, wScreenState, wScreenStep, wScreenSubStep
GameMode6_Update::
Func_024_4117:: ; address name
    ld a, [wFadeState]
    and a, a
    ret nz
    ld a, [wTextFlags]
    and a, a
    jr z, .read_screen_state
    ld a, [wScreenState]
    cp a, $02
    jr z, .check_screen_step
    cp a, $03
    ret nz
    ld a, [wScreenStep]
    cp a, $01
    ret nz
    ld a, [wScreenSubStep]
    cp a, $09
    ret nz
    call GameMode6_Update_UpdateAndDrawSpriteSlots
    ret

.check_screen_step:
    ld a, [wScreenStep]
    cp a, $0E
    ret nz
    ld a, [wScreenSubStep]
    cp a, $09
    ret nz
    call GameMode6_Update_UpdateAndDrawSpriteSlots
    ret

.read_screen_state:
    ld a, [wScreenState]
    rst $00
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
    dw GameMode6_Update_SwapMonstersMenu_Case0D
    dw GameMode6_Update_SwitchEgg
    dw GameMode6_Update_SwitchMonster

; by wScreenStep: shows 'obtained an egg of 0.'
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
GameMode6_Update_ObtainedEgg::
Jump_024_4170:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw GameMode6_Update_ObtainedEgg_CopyRectTo20ByteRowsJp_Bank24
    dw GameMode6_Update_ObtainedEgg_WriteScreenStepAndScreenState

; entry 0 of the `rst $00` table in GameMode6_Update_ObtainedEgg
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene, wScreenStep
; writes: wScreenStep, wTextBuf0, wStringCategory, wStringIndex
; points at: wTextBuf0
GameMode6_Update_ObtainedEgg_CopyRectTo20ByteRowsJp_Bank24::
Jump_024_4178:: ; address name
    ld a, [wBattleScene]
    cp a, $08
    jr z, .call_bg_map_address_at_scroll_bank24
    cp a, $80
    jr z, .skip
    jr .skip2

.skip:
    ld de, GameMode6_Update_ObtainedEgg_CopyRectTo20ByteRowsJp_Bank24_Data
    jr .call_copy_rect_to20_byte_rows_jp_bank24

.skip2:
    ld de, TileRect_24_5792

.call_copy_rect_to20_byte_rows_jp_bank24:
    ld hl, wWindowTileBuffer + $7A
    ld bc, $1102
    call CopyRectTo20ByteRowsJp_Bank24
    call GameMode6_Update_ObtainedEgg_Case00_WaitForVRAMAccess
    call BGMapAddressAtScroll_Bank24
    ld bc, $1406
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, [wBattleScene]
    cp a, $80
    jr z, .call_show_string_a_in_default_window_bank24
    and a, $01
    add a, $01
    call ShowStringAInDefaultWindow_Bank24
    ret

.call_show_string_a_in_default_window_bank24:
    xor a, a
    call ShowStringAInDefaultWindow_Bank24
    ret

.call_bg_map_address_at_scroll_bank24:
    call BGMapAddressAtScroll_Bank24
    ld bc, $1406
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld hl, wRecordBufA + MON_NAME
    ld de, wTextBuf0
    ld bc, $000A
    call CopyBytes
    ld a, $F0
    ld [wTextBuf0 + $A], a
    ld a, $05
    ld [wStringCategory], a
    ld a, $13
    ld [wStringIndex], a ; 'obtained an egg of 0.'
    farcall BeginStringDisplay_Bank07
    ret

; entry 1 of the `rst $00` table in GameMode6_Update_ObtainedEgg
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRules, wBattleScene, wRecordBufA, wScreenState, wRecordBufB
; writes: wScreenStep, wScreenState
GameMode6_Update_ObtainedEgg_WriteScreenStepAndScreenState::
Jump_024_41F5:: ; address name
    ld a, [wLinkRules + $9]
    and a, a
    jr nz, .check_battle_scene

.loop:
    call GameMode6_Update_WriteLinkSceneByte4BAndGameModeEtc
    ret

.check_battle_scene:
    ld a, [wBattleScene]
    cp a, $80
    jr z, .loop
    and a, $01
    and a, a
    jr z, .check_record_buf_b
    ld a, [wRecordBufA]
    and a, a
    jr z, .loop
    jr .clear_screen_step

.check_record_buf_b:
    ld a, [wRecordBufB]
    and a, a
    jr z, .loop

.clear_screen_step:
    xor a, a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; entry 1 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene, wScreenState
; writes: wScreenState
GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24::
Jump_024_4225:: ; address name
    ld de, GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24_Data
    ld hl, wWindowTileBuffer + $F0
    ld bc, $1406
    call CopyRectTo20ByteRowsJp_Bank24
    call BGMapAddressAtScroll_Bank24
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_24
    ld a, [wBattleScene]
    and a, $01
    add a, $01
    ld b, a
    ld a, [wScreenState]
    add a, b
    ld [wScreenState], a
    ret

; by wScreenStep: RunSaveGameSteps, a yes/no prompt and a 'monster egg' message
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
GameMode6_Update_SavePrompt::
Jump_024_424D:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw GameMode6_Update_SavePrompt_WriteScreenStepAndScreenSubStep
    dw GameMode6_Update_SavePrompt_LoadRecordCapacityFromFarmLevelTable
    dw GameMode6_Update_SavePrompt_RunSaveGameSteps
    dw GameMode6_Update_SavePrompt_ToShowStringAInDefaultWindow_Bank24AndStep
    dw GameMode6_Update_SavePrompt_ShowYesNo_Case04
    dw GameMode6_Update_SavePrompt_UpdateTwoChoiceCursor_Bank1D
    dw GameMode6_Update_SavePrompt_ToGameMode6_Update_WriteLinkSceneByte4BAndGameModeEtc
    dw GameMode6_Update_SavePrompt_GameMode6_Update_ShowMonsterEg
    dw GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor
    dw GameMode6_Update_SavePrompt_SetScreenStepTo05
    dw GameMode6_Update_SavePrompt_ShowStringAInDefaultWindow_Bank24
    dw GameMode6_Update_SavePrompt_ReturnStub_51A3
    dw GameMode6_Update_SavePrompt_DecompressToVRAM
    dw GameMode6_Update_SavePrompt_ToGameMode6_Update_Save_TestFlagBitAndStep
    dw GameMode6_Update_SavePrompt_ObjectScene_Case0E
    dw GameMode6_Update_SavePrompt_SetScreenStep

; entry 0 of the `rst $00` table in GameMode6_Update_SavePrompt
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene, wScreenSubStep, wRecordCapacity, wRecordsInUse, wScreenStep
; writes: wScreenStep, wScreenSubStep
GameMode6_Update_SavePrompt_WriteScreenStepAndScreenSubStep::
Jump_024_4271:: ; address name
    ld a, [wBattleScene]
    cp a, $08
    jr z, .call_count_records_in_use
    ld a, [wScreenSubStep]
    and a, a
    jr nz, .call_count_records_in_use
    ld a, $0D
    ld [wScreenStep], a
    ret

.call_count_records_in_use:
    farcall CountRecordsInUse
    farcall LoadRecordCapacityFromFarmLevelTable
    ld a, [wRecordCapacity]
    ld b, a
    ld a, [wRecordsInUse]
    cp a, b
    jr c, .check_screen_step
    ld a, $03
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    ret
    db $0A, $14, $1E

; entry 1 of the `rst $00` table in GameMode6_Update_SavePrompt
; no direct call (reached through a table, a jump or a vector)
; reads: wRecordBufB, wScreenStep
; writes: rRAMG, rRAMB, wSpeciesIdLo, wSpeciesIdHi, wSaveStep, wSaveRecordIndex, wScreenStep
; points at: sRecords, wRecordBufB
GameMode6_Update_SavePrompt_LoadRecordCapacityFromFarmLevelTable::
Jump_024_42B3:: ; address name
    farcall LoadRecordCapacityFromFarmLevelTable
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld hl, sRecords

.skip:
    ld a, [hl]
    and a, a
    jr z, .skip2
    cp a, $FF
    jr z, .skip2
    ld a, $A5
    add_a_to_hl
    jr .skip

.skip2:
    ld de, wRecordBufB
    ld b, $A5

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop
    ld a, [wRecordBufB + MON_SPECIES]
    ld [wSpeciesIdLo], a
    ld a, [wRecordBufB + MON_SPECIES + 1]
    ld [wSpeciesIdHi], a
    farcall SetSpeciesFlag
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in GameMode6_Update_SavePrompt
; no direct call (reached through a table, a jump or a vector)
; reads: wSaveStep
GameMode6_Update_SavePrompt_RunSaveGameSteps::
Jump_024_4309:: ; address name
    farcall RunSaveGameSteps
    ld a, [wSaveStep]
    bit 7, a
    ret z
    call GameMode6_Update_WriteLinkSceneByte4BAndGameModeEtc
    ret

; entry 3 of the `rst $00` table in GameMode6_Update_SavePrompt
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
GameMode6_Update_SavePrompt_ToShowStringAInDefaultWindow_Bank24AndStep::
Jump_024_4319:: ; address name
    ld a, $05
    call ShowStringAInDefaultWindow_Bank24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 4 of the `rst $00` table in GameMode6_Update_SavePrompt
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wTwoChoiceCursor, wScreenStep
GameMode6_Update_SavePrompt_ShowYesNo_Case04::
Jump_024_4326:: ; address name
    ld a, $6C
    call QueueSoundEffect
    call GameMode6_Update_SavePrompt_ShowYesNo
    ld de, TileRect_24_5A0A
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRowsJp_Bank24
    call ReturnStub_51A3
    call BGMapAddressAtScroll_Bank24
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_24
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in GameMode6_Update_SavePrompt
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wScreenStep
; writes: wScreenStep
GameMode6_Update_SavePrompt_UpdateTwoChoiceCursor_Bank1D::
Jump_024_4355:: ; address name
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, .call_game_mode6_update_save_prompt_show_yes
    cp a, $FF
    jr z, .check_two_choice_cursor
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    and a, a
    jr nz, .call_game_mode6_update_save_prompt_show_yes
    ld a, $07
    call ShowStringAInDefaultWindow_Bank24
    ld a, [wScreenStep]
    add a, $02
    ld [wScreenStep], a
    ret

.call_game_mode6_update_save_prompt_show_yes:
    call GameMode6_Update_SavePrompt_ShowYesNo
    call CopyWCA2CNameToTextBuf0
    ld a, $06
    call ShowStringAInDefaultWindow_Bank24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 6 of the `rst $00` table in GameMode6_Update_SavePrompt
; no direct call (reached through a table, a jump or a vector)
GameMode6_Update_SavePrompt_ToGameMode6_Update_WriteLinkSceneByte4BAndGameModeEtc::
Jump_024_4390:: ; address name
    call GameMode6_Update_WriteLinkSceneByte4BAndGameModeEtc
    ret

; entry 7 of the `rst $00` table in GameMode6_Update_SavePrompt
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wTwoChoiceCursor, wScreenStep
GameMode6_Update_SavePrompt_GameMode6_Update_ShowMonsterEg::
Jump_024_4394:: ; address name
    ld a, $6C
    call QueueSoundEffect
    call GameMode6_Update_ShowMonsterEg
    ld de, TileRect_24_5A50
    ld hl, wWindowTileBuffer + $10E
    ld bc, $0A05
    call CopyRectTo20ByteRowsJp_Bank24
    call ReturnStub_51A3
    call BGMapAddressAtScroll_Bank24
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_24
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 8 of the `rst $00` table in GameMode6_Update_SavePrompt
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wScreenStep
; writes: wScreenStep, wTwoChoiceCursor
GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor::
Jump_024_43C3:: ; address name
    call GameMode6_Update_SavePrompt_Case08_WriteMenuInputResultAndTwoChoiceCursorEtc
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, .call_game_mode6_update_save_prompt_show_yes
    cp a, $FF
    jr z, .check_two_choice_cursor
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    and a, a
    jr nz, .call_list_records_in_use_with_byte6_e_set
    farcall ListRecordsInUseWithByte6EClear
    jr .read_screen_step

.call_list_records_in_use_with_byte6_e_set:
    farcall ListRecordsInUseWithByte6ESet

.read_screen_step:
    ld a, [wScreenStep]
    add a, $02
    ld [wScreenStep], a
    ret

.call_game_mode6_update_save_prompt_show_yes:
    call GameMode6_Update_SavePrompt_ShowYesNo
    ld de, TileRect_24_5A0A
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRowsJp_Bank24
    xor a, a
    ld b, $BC
    ld hl, GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    call ReturnStub_51A3
    call BGMapAddressAtScroll_Bank24
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_24
    xor a, a
    ld b, $C3
    ld hl, GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, $05
    call ShowStringAInDefaultWindow_Bank24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 9 of the `rst $00` table in GameMode6_Update_SavePrompt
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep
GameMode6_Update_SavePrompt_SetScreenStepTo05::
Jump_024_4432:: ; address name
    ld a, $05
    ld [wScreenStep], a
    ret

; entry 10 of the `rst $00` table in GameMode6_Update_SavePrompt
; no direct call (reached through a table, a jump or a vector)
; reads: wListCount, wScreenStep, wTwoChoiceCursor
; writes: wScreenStep
GameMode6_Update_SavePrompt_ShowStringAInDefaultWindow_Bank24::
Jump_024_4438:: ; address name
    ld a, [wListCount]
    and a, a
    jr nz, .read_two_choice_cursor
    ld a, $11
    call ShowStringAInDefaultWindow_Bank24
    ld a, [wScreenStep]
    sub a, $02
    ld [wScreenStep], a
    ret

.read_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    ld b, $BC
    ld hl, GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 11 of the `rst $00` table in GameMode6_Update_SavePrompt
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene, wScreenStep
; writes: wScreenStep
; points at: wWindowTileBuffer
GameMode6_Update_SavePrompt_ReturnStub_51A3::
Jump_024_445F:: ; address name
    ld a, [wBattleScene]
    cp a, $08
    jr nz, .call_game_mode6_update_copy_rect_to20_byte
    ld de, GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24_Data
    ld hl, wWindowTileBuffer + $F7
    ld bc, $0606
    call CopyRectTo20ByteRowsJp_Bank24
    jr .call_bg_map_address_at_scroll_bank24

.call_game_mode6_update_copy_rect_to20_byte:
    call GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24_Shared01

.call_bg_map_address_at_scroll_bank24:
    call BGMapAddressAtScroll_Bank24
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_24
    ld de, TileRect_24_5942
    ld hl, wWindowTileBuffer
    ld bc, $1405
    call CopyRectTo20ByteRowsJp_Bank24
    call ReturnStub_51A3
    call BGMapAddressAtScroll_Bank24
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRectToBGMap_24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 12 of the `rst $00` table in GameMode6_Update_SavePrompt
; no direct call (reached through a table, a jump or a vector)
; reads: wTwoChoiceCursor, wScreenState
; writes: wScreenStep, wScreenState
; points at: wWindowTileBuffer
GameMode6_Update_SavePrompt_DecompressToVRAM::
Jump_024_44AA:: ; address name
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
    ld bc, $1405
    call CopyRectTo20ByteRowsJp_Bank24
    call ReturnStub_51A3
    call BGMapAddressAtScroll_Bank24
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRectToBGMap_24
    ld a, [wTwoChoiceCursor]
    add a, $08
    call ShowStringAInDefaultWindow_Bank24
    xor a, a
    ld [wScreenStep], a
    ld a, [wScreenState]
    add a, $02
    ld b, a
    ld a, [wTwoChoiceCursor]
    add a, b
    ld [wScreenState], a
    ret

; E-0238 (derived: HL = $44FE and 1 calls to a 16-byte VRAM copier (CopyTileBytesToVRAM_*), one tile each)
; record: tile (16 bytes, 2 bits per pixel)
Tiles_24_44FE::
Data_024_44FE:: ; address name
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; entry 0

; entry 13 of the `rst $00` table in GameMode6_Update_SavePrompt
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
GameMode6_Update_SavePrompt_ToGameMode6_Update_Save_TestFlagBitAndStep::
Jump_024_450E:: ; address name
    call GameMode6_Update_Save_TestFlagBit
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 14 of the `rst $00` table in GameMode6_Update_SavePrompt
; no direct call (reached through a table, a jump or a vector)
GameMode6_Update_SavePrompt_ObjectScene_Case0E::
Jump_024_4519:: ; address name
    call GameMode6_Update_UpdateAndDrawSpriteSlots
    call GameMode6_Update_SavePrompt_ObjectScene
    ret

; entry 15 of the `rst $00` table in GameMode6_Update_SavePrompt
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScreenSubStep
GameMode6_Update_SavePrompt_SetScreenStep::
Jump_024_4520:: ; address name
    xor a, a
    ld [wScreenStep], a
    ld a, $01
    ld [wScreenSubStep], a
    ret

; by wScreenStep: draws the sprites, then RunSaveGameSteps
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
GameMode6_Update_Save::
Jump_024_452A:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw GameMode6_Update_Save_WriteScreenStep
    dw GameMode6_Update_Save_GameMode6_Update_UpdateAndDrawSpriteSlots
    dw GameMode6_Update_Save_SetSaveStep
    dw GameMode6_Update_Save_RunSaveGameSteps

; entry 0 of the `rst $00` table in GameMode6_Update_Save
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
GameMode6_Update_Save_WriteScreenStep::
Jump_024_4536:: ; address name
    call GameMode6_Update_Save_TestFlagBit
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in GameMode6_Update_Save
; no direct call (reached through a table, a jump or a vector)
GameMode6_Update_Save_GameMode6_Update_UpdateAndDrawSpriteSlots::
Jump_024_4541:: ; address name
    call GameMode6_Update_UpdateAndDrawSpriteSlots
    call GameMode6_Update_Save_ObjectScene
    ret

; entry 2 of the `rst $00` table in GameMode6_Update_Save
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wSaveStep, wSaveRecordIndex, wScreenStep
GameMode6_Update_Save_SetSaveStep::
Jump_024_4548:: ; address name
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in GameMode6_Update_Save
; no direct call (reached through a table, a jump or a vector)
; reads: wSaveStep
GameMode6_Update_Save_RunSaveGameSteps::
Jump_024_4557:: ; address name
    farcall RunSaveGameSteps
    ld a, [wSaveStep]
    bit 7, a
    ret z
    call GameMode6_Update_WriteLinkSceneByte4BAndGameModeEtc
    ret

; by wScreenStep: a paged record list with strings (ShowStringAInDefaultWindow_Bank24), record buffer B and a two-choice input
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
GameMode6_Update_ChooseRecordList::
Jump_024_4567:: ; address name
    ld a, [wScreenStep]
    rst $00
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

; entry 0 of the `rst $00` table in GameMode6_Update_ChooseRecordList; also entries 1, 2, 3 of the table in GameMode6_Update_ChooseRecordList
; no direct call (reached through a table, a jump or a vector)
GameMode6_Update_ChooseRecordList_ToBreedMenu::
Jump_024_4587:: ; address name
    farcall BreedMenu
    ret

; entry 4 of the `rst $00` table in GameMode6_Update_ChooseRecordList; also entries 5, 9 of the table in GameMode6_Update_ChooseRecordList
; no direct call (reached through a table, a jump or a vector)
GameMode6_Update_ChooseRecordList_ToEggServiceMenu_Bank1B::
Jump_024_458E:: ; address name
    farcall EggServiceMenu_Bank1B
    ret

; entry 6 of the `rst $00` table in GameMode6_Update_ChooseRecordList
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
GameMode6_Update_ChooseRecordList_AdvanceScreenStep::
Jump_024_4595:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 7 of the `rst $00` table in GameMode6_Update_ChooseRecordList
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep
; writes: wScreenStep
GameMode6_Update_ChooseRecordList_StoreBAtWordTableEntry_Bank24_52CE::
Jump_024_459D:: ; address name
    ld a, [wListCursor]
    ld b, $BB
    ld hl, GameMode6_Update_ChooseRecordList_StoreBAtWordTableEntry_Bank24_52CE_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    call BGMapAddressAtScroll_Bank24
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_24
    ld a, [wListCursor]
    ld b, $C3
    ld hl, GameMode6_Update_ChooseRecordList_StoreBAtWordTableEntry_Bank24_52CE_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; moves the paged cursor, copies a rectangle and sets the sub-step
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
GameMode6_Update_Case04_PageList::
Jump_024_45C7:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw GameMode6_Update_Case04_PageList_UpdatePagedListCursor
    dw GameMode6_Update_Case04_PageList_CopyRectTo20ByteRowsJp_Bank24
    dw GameMode6_Update_Case04_PageList_SetScreenSubStep

; entry 0 of the `rst $00` table in GameMode6_Update_Case04_PageList
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wListCursor, wScreenStep, wScreenSubStep
; writes: wMenuInputResult, wScreenSubStep, wScreenStep
GameMode6_Update_Case04_PageList_UpdatePagedListCursor::
Jump_024_45D1:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, .read_screen_step
    cp a, $FC
    jr z, .read_screen_step
    cp a, $FD
    jr z, .read_screen_step2
    cp a, $FE
    jr z, .check_screen_sub_step
    cp a, $FF
    jr z, .call_game_mode6_update_case04_page_list
    ret

.read_screen_step:
    ld a, [wScreenStep]
    sub a, $07
    ld [wScreenStep], a
    ret

.read_screen_step2:
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.call_game_mode6_update_case04_page_list:
    call GameMode6_Update_Case04_PageList_Case00_ReadPartyCountAndListCursorEtc
    cp a, $FF
    jr nz, .read_list_cursor
    ld a, $02
    ld [wScreenSubStep], a
    ld a, $12
    call ShowStringAInDefaultWindow_Bank24
    ret

.read_list_cursor:
    ld a, [wListCursor]
    ld b, $BC
    ld hl, GameMode6_Update_ChooseRecordList_StoreBAtWordTableEntry_Bank24_52CE_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    farcall CopyListEntriesCell5NameToTextBuf0
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in GameMode6_Update_Case04_PageList
; no direct call (reached through a table, a jump or a vector)
; reads: wTwoChoiceCursor, wBattleScene, wLinkByteEB
; writes: wScreenSubStep, wListPageIndex, wListCursor, wScreenState, wScreenStep
GameMode6_Update_Case04_PageList_CopyRectTo20ByteRowsJp_Bank24::
Jump_024_463A:: ; address name
    ld de, TileRect_24_5814
    ld hl, wWindowTileBuffer + $64
    ld bc, $0E0D
    call CopyRectTo20ByteRowsJp_Bank24
    ld a, [wTwoChoiceCursor]
    ld b, $BB
    ld hl, GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    ld a, [wBattleScene]
    cp a, $08
    jr nz, .check_link_byte_eb
    ld de, GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24_Data
    ld hl, wWindowTileBuffer + $F7
    ld bc, $0606
    call CopyRectTo20ByteRowsJp_Bank24
    jr .skip

.check_link_byte_eb:
    ld a, [wLinkByteEB]
    and a, a
    jr nz, .skip
    ld de, TileRect_24_57F2
    ld hl, wWindowTileBuffer + $7A
    ld bc, $1102
    call CopyRectTo20ByteRowsJp_Bank24

.skip:
    ld de, TileRect_24_5A50
    ld hl, wWindowTileBuffer + $10E
    ld bc, $0A05
    call CopyRectTo20ByteRowsJp_Bank24
    call BGMapAddressAtScroll_Bank24
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_24
    ld a, [wTwoChoiceCursor]
    ld b, $C3
    ld hl, GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    xor a, a
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

; entry 2 of the `rst $00` table in GameMode6_Update_Case04_PageList
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenSubStep
GameMode6_Update_Case04_PageList_SetScreenSubStep::
Jump_024_46B5:: ; address name
    xor a, a
    ld [wScreenSubStep], a
    ret

; entry 10 of the `rst $00` table in GameMode6_Update_ChooseRecordList
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wChoiceCursor, wScreenState, wScreenStep, wPartyCount, wListPageIndex, wListCursor
; writes: wArg5, wScreenByteB2, wScreenByteB3, wScreenStep, wScreenSubStep, wScreenState
GameMode6_Update_ChooseRecordList_HandleTwoChoiceCursorInput_0D::
Jump_024_46BA:: ; address name
    xor a, a
    ld [wArg5], a
    farcall HandleTwoChoiceCursorInput_0D
    ld a, [wArg5]
    and a, a
    ret z
    cp a, $FE
    jr z, .check_screen_step
    cp a, $FF
    jr z, .check_choice_cursor
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.check_choice_cursor:
    ld a, [wChoiceCursor]
    and a, a
    jr nz, .check_party_count
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

.check_party_count:
    ld a, [wPartyCount]
    cp a, $02
    jr nc, .call_game_mode6_update_choose_record_list
    ld a, [wListPageIndex]
    and a, a
    jr nz, .call_game_mode6_update_choose_record_list
    ld a, [wListCursor]
    and a, a
    jr nz, .call_game_mode6_update_choose_record_list
    ld a, $12
    call ShowStringAInDefaultWindow_Bank24
    jr .check_screen_step

.call_game_mode6_update_choose_record_list:
    call GameMode6_Update_ChooseRecordList_Case0A_SetArg5ToListEntriesCell5
    ld a, $0A
    call ShowStringAInDefaultWindow_Bank24
    ld a, [wScreenStep]
    add a, $02
    ld [wScreenStep], a
    ret

; entry 11 of the `rst $00` table in GameMode6_Update_ChooseRecordList
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep
; writes: wScreenStep
GameMode6_Update_ChooseRecordList_GameMode6_Update_ShowMonsterEg::
Jump_024_4724:: ; address name
    ld de, TileRect_24_5A28
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRowsJp_Bank24
    xor a, a
    ld b, $BC
    ld hl, GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    call GameMode6_Update_ShowMonsterEg
    call BGMapAddressAtScroll_Bank24
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_24
    ld a, [wListCursor]
    ld b, $C3
    ld hl, GameMode6_Update_ChooseRecordList_StoreBAtWordTableEntry_Bank24_52CE_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    ld a, [wScreenStep]
    sub a, $03
    ld [wScreenStep], a
    ret

; entry 12 of the `rst $00` table in GameMode6_Update_ChooseRecordList
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wRecordBufB, wScreenStep
; writes: wArg1, wArg2, rRAMG, rRAMB, wSpeciesIdLo, wSpeciesIdHi, wSaveStep, wSaveRecordIndex, ...
; points at: sRecords, wRecordBufB
GameMode6_Update_ChooseRecordList_SetArg5ToListEntriesCell5::
Jump_024_475C:: ; address name
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    ld a, [wArg5]
    ld c, $A5
    call Multiply8
    ld de, sRecords
    add hl, de
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld b, $A5
    ld de, wRecordBufB

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop
    ld a, [wRecordBufB + MON_SPECIES]
    ld [wSpeciesIdLo], a
    ld a, [wRecordBufB + MON_SPECIES + 1]
    ld [wSpeciesIdHi], a
    farcall SetSpeciesFlag
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 13 of the `rst $00` table in GameMode6_Update_ChooseRecordList
; no direct call (reached through a table, a jump or a vector)
; reads: wSaveStep
GameMode6_Update_ChooseRecordList_RunSaveGameSteps::
Jump_024_47BF:: ; address name
    farcall RunSaveGameSteps
    ld a, [wSaveStep]
    bit 7, a
    ret z
    call GameMode6_Update_WriteLinkSceneByte4BAndGameModeEtc
    ret

; by wScreenStep: a paged record list, the 'Info / OK / Yes / No' window, the monster-egg message and RunSaveGameSteps
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
GameMode6_Update_ChooseRecordAndSave::
Jump_024_47CF:: ; address name
    ld a, [wScreenStep]
    rst $00
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

; entry 0 of the `rst $00` table in GameMode6_Update_ChooseRecordAndSave
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
GameMode6_Update_ChooseRecordAndSave_ToGameMode6_Update_FillTilesFromRequestAndStep::
Jump_024_47EB:: ; address name
    call GameMode6_Update_FillTilesFromRequest
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in GameMode6_Update_ChooseRecordAndSave
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
GameMode6_Update_ChooseRecordAndSave_ToCopyRectTo20ByteRowsJp_Bank24AndStep::
Jump_024_47F6:: ; address name
    ld de, TileRect_24_5B10
    ld hl, wWindowTileBuffer + $64
    ld bc, $0D09
    call CopyRectTo20ByteRowsJp_Bank24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in GameMode6_Update_ChooseRecordAndSave
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
GameMode6_Update_ChooseRecordAndSave_ClampRecordListPageCursor4::
Jump_024_480A:: ; address name
    farcall ClampRecordListPageCursor4
    ld a, [wListPages]
    cp a, $02
    jr c, .call_bg_map_address_at_scroll_bank24
    ld hl, wWindowTileBuffer + $10B
    call StoreC5BEC6AtHLStride2_Bank24
    ld hl, wWindowTileBuffer + $10C
    ld a, h
    ld [wArg1], a
    ld a, l
    ld [wArg2], a
    farcall DrawPageOfPagesAtArg1_Bank1E

.call_bg_map_address_at_scroll_bank24:
    call BGMapAddressAtScroll_Bank24
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in GameMode6_Update_ChooseRecordAndSave
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg5, wScreenStep
GameMode6_Update_ChooseRecordAndSave_DrawRecordListPageSpeciesNames::
Jump_024_4842:: ; address name
    xor a, a
    ld [wArg5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 4 of the `rst $00` table in GameMode6_Update_ChooseRecordAndSave
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep
GameMode6_Update_ChooseRecordAndSave_DrawRecordListPageMarks::
Jump_024_4854:: ; address name
    ld de, Tiles2Plus420Tiles_1F_4990
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a, a
    ld [wArg1], a
    ld a, $02
    ld [wArg2], a
    farcall DrawRecordListPageMarks
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in GameMode6_Update_ChooseRecordAndSave
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wListCursor, wScreenStep
; writes: wMenuInputResult, wScreenStep
GameMode6_Update_ChooseRecordAndSave_UpdatePagedListCursor::
Jump_024_4878:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, .read_screen_step
    cp a, $FC
    jr z, .read_screen_step
    cp a, $FD
    jr z, .return
    cp a, $FE
    jr z, .check_screen_step
    cp a, $FF
    jr z, .read_list_cursor
    ret

.read_screen_step:
    ld a, [wScreenStep]
    sub a, $05
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
    ld b, $BC
    ld hl, GameMode6_Update_ChooseRecordList_StoreBAtWordTableEntry_Bank24_52CE_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    farcall CopyListEntriesCell5NameToTextBuf0
    ld a, [wScreenStep]
    add a, $02
    ld [wScreenStep], a
    ret

; entry 6 of the `rst $00` table in GameMode6_Update_ChooseRecordAndSave
; no direct call (reached through a table, a jump or a vector)
; reads: wTwoChoiceCursor
; writes: wScreenState, wScreenStep, wScreenSubStep, wListPageIndex, wListCursor
GameMode6_Update_ChooseRecordAndSave_StoreBAtWordTableEntry_Bank24_52CE::
Jump_024_48C8:: ; address name
    ld a, [wTwoChoiceCursor]
    ld b, $C3
    ld hl, GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    ld a, $04
    ld [wScreenState], a
    ld a, $08
    ld [wScreenStep], a
    ld a, $01
    ld [wScreenSubStep], a
    xor a, a
    ld [wListPageIndex], a
    ld [wListCursor], a
    ret

; entry 7 of the `rst $00` table in GameMode6_Update_ChooseRecordAndSave
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wChoiceCursor, wScreenStep
GameMode6_Update_ChooseRecordAndSave_ShowInfoOKYesN::
Jump_024_48EA:: ; address name
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
    ld a, $0D
    ld [wStringIndex], a ; 'InfoOKYesN'
    farcall ShowString_Bank33_7045
    ld a, $6C
    call QueueSoundEffect
    ld de, TileRect_24_5B85
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRowsJp_Bank24
    call BGMapAddressAtScroll_Bank24
    ld bc, $140D
    ld de, $01CC
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
    xor a, a
    ld [wChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 8 of the `rst $00` table in GameMode6_Update_ChooseRecordAndSave
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wChoiceCursor, wScreenState, wScreenStep, wArg6
; writes: wArg5, wScreenByteB2, wScreenByteB3, wScreenStep, wScreenSubStep, wScreenState
GameMode6_Update_ChooseRecordAndSave_HandleTwoChoiceCursorInput_0D::
Jump_024_494E:: ; address name
    xor a, a
    ld [wArg5], a
    farcall HandleTwoChoiceCursorInput_0D
    ld a, [wArg5]
    and a, a
    ret z
    cp a, $FE
    jr z, .check_screen_step
    cp a, $FF
    jr z, .check_choice_cursor
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.check_choice_cursor:
    ld a, [wChoiceCursor]
    and a, a
    jr nz, .call_set_arg5_to_list_entries_cell4
    ld a, [wScreenState]
    ld [wScreenByteB2], a
    ld a, [wScreenStep]
    ld [wScreenByteB3], a
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, $0D
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
    ld a, $0A
    call ShowStringAInDefaultWindow_Bank24
    ld a, [wScreenStep]
    add a, $02
    ld [wScreenStep], a
    ret

; entry 9 of the `rst $00` table in GameMode6_Update_ChooseRecordAndSave
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep
; writes: wScreenStep
GameMode6_Update_ChooseRecordAndSave_GameMode6_Update_ShowMonsterEg::
Jump_024_49AF:: ; address name
    ld de, TileRect_24_5A82
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRowsJp_Bank24
    ld a, $01
    ld b, $BC
    ld hl, GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    call GameMode6_Update_ShowMonsterEg
    call BGMapAddressAtScroll_Bank24
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_24
    ld a, [wListCursor]
    ld b, $C3
    ld hl, GameMode6_Update_ChooseRecordList_StoreBAtWordTableEntry_Bank24_52CE_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    ld a, [wScreenStep]
    sub a, $04
    ld [wScreenStep], a
    ret

; entry 10 of the `rst $00` table in GameMode6_Update_ChooseRecordAndSave
; no direct call (reached through a table, a jump or a vector)
; reads: wArg5, wArg6, wRecordBufB, wScreenStep
; writes: wArg1, wArg2, rRAMG, rRAMB, wSpeciesIdLo, wSpeciesIdHi, wSaveStep, wSaveRecordIndex, ...
; points at: sRecords, wRecordBufB
GameMode6_Update_ChooseRecordAndSave_SetArg5ToListEntriesCell4::
Jump_024_49E8:: ; address name
    farcall SetArg5ToListEntriesCell4
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    ld a, [wArg5]
    ld c, $A5
    call Multiply8
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld de, sRecords
    add hl, de
    ld b, $A5
    ld de, wRecordBufB

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop
    ld a, [wRecordBufB + MON_SPECIES]
    ld [wSpeciesIdLo], a
    ld a, [wRecordBufB + MON_SPECIES + 1]
    ld [wSpeciesIdHi], a
    farcall SetSpeciesFlag
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 11 of the `rst $00` table in GameMode6_Update_ChooseRecordAndSave
; no direct call (reached through a table, a jump or a vector)
; reads: wSaveStep
GameMode6_Update_ChooseRecordAndSave_RunSaveGameSteps::
Jump_024_4A4C:: ; address name
    farcall RunSaveGameSteps
    ld a, [wSaveStep]
    bit 7, a
    ret z
    call GameMode6_Update_WriteLinkSceneByte4BAndGameModeEtc
    ret

; entry 6 of the `rst $00` table in GameMode6_Update; also entries 7, 8, 9, 10, 11 of the table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
GameMode6_Update_Return::
Jump_024_4A5C:: ; address name
    ret

; entry 12 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wScreenState
; writes: wScreenStep, wScreenSubStep, wScreenState
GameMode6_Update_SwapMonstersMenu::
Jump_024_4A5D:: ; address name
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

; entry 13 of the `rst $00` table in GameMode6_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wScreenState
; writes: wScreenStep, wScreenSubStep, wScreenState
GameMode6_Update_SwapMonstersMenu_Case0D::
Jump_024_4A79:: ; address name
    farcall SwapMonstersMenu
    ld a, [wScreenStep]
    cp a, $0A
    ret nz
    xor a, a
    ld [wScreenStep], a
    ld [wScreenSubStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; by wScreenStep: the 'Info / OK / Yes / No' window, the list of records with byte $6E set and 'Switch which egg?'
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
GameMode6_Update_SwitchEgg::
Jump_024_4A94:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw GameMode6_Update_SwitchEgg_ShowInfoOKYesN
    dw GameMode6_Update_SwitchEgg_ListRecordsInUseWithByte6ESet
    dw GameMode6_Update_SwitchEgg_DrawRecordListPageSpeciesNames
    dw GameMode6_Update_SwitchEgg_DrawRecordListPageMarks
    dw GameMode6_Update_SwitchEgg_ShowSwitchWhichEgg
    dw GameMode6_Update_SwitchEgg_StoreBAtWordTableEntry_Bank24_52CE

; entry 0 of the `rst $00` table in GameMode6_Update_SwitchEgg
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene, wListCursor, wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wScreenStep
GameMode6_Update_SwitchEgg_ShowInfoOKYesN::
Jump_024_4AA4:: ; address name
    ld b, $46
    ld de, Tiles1Gfx_46_4001
    ld hl, vTiles1
    call DecompressToVRAM
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
    ld a, $0D
    ld [wStringIndex], a ; 'InfoOKYesN'
    farcall ShowString_Bank33_7045
    call GameMode6_Update_FillTilesFromRequest
    ld a, [wBattleScene]
    cp a, $08
    jr nz, .call_game_mode6_update_copy_rect_to20_byte
    ld de, GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24_Data
    ld hl, wWindowTileBuffer + $F7
    ld bc, $0606
    call CopyRectTo20ByteRowsJp_Bank24
    jr .skip

.call_game_mode6_update_copy_rect_to20_byte:
    call GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24_Shared01

.skip:
    ld de, TileRect_24_5B10
    ld hl, wWindowTileBuffer + $64
    ld bc, $0D09
    call CopyRectTo20ByteRowsJp_Bank24
    ld a, [wListCursor]
    ld b, $BB
    ld hl, GameMode6_Update_ChooseRecordList_StoreBAtWordTableEntry_Bank24_52CE_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in GameMode6_Update_SwitchEgg
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
GameMode6_Update_SwitchEgg_ListRecordsInUseWithByte6ESet::
Jump_024_4B0E:: ; address name
    farcall ListRecordsInUseWithByte6ESet
    farcall ClampRecordListPageCursor4
    ld a, [wListPages]
    cp a, $02
    jr c, .check_screen_step
    ld hl, wWindowTileBuffer + $10B
    call StoreC5BEC6AtHLStride2_Bank24
    ld hl, wWindowTileBuffer + $10C
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

; entry 2 of the `rst $00` table in GameMode6_Update_SwitchEgg
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg5, wScreenStep
GameMode6_Update_SwitchEgg_DrawRecordListPageSpeciesNames::
Jump_024_4B40:: ; address name
    xor a, a
    ld [wArg5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in GameMode6_Update_SwitchEgg
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wArg1, wArg2, wScreenStep
GameMode6_Update_SwitchEgg_DrawRecordListPageMarks::
Jump_024_4B52:: ; address name
    ld de, Tiles2Plus420Tiles_1F_4990
    ld hl, vTiles1 + $4E0
    ld b, $1F
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

; entry 4 of the `rst $00` table in GameMode6_Update_SwitchEgg
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wScreenStep
GameMode6_Update_SwitchEgg_ShowSwitchWhichEgg::
Jump_024_4B77:: ; address name
    ld de, TileRect_24_5B85
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
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
    xor a, a
    ld [wStringCategory], a
    ld a, $09
    ld [wStringIndex], a ; 'Switch which egg?'
    farcall ShowString_Bank33_7045
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in GameMode6_Update_SwitchEgg
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenByteB2, wScreenByteB3, wGameMode, wLinkSession
; writes: hSpriteHideTile, wScreenSubStep, wScreenState, wScreenStep, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
GameMode6_Update_SwitchEgg_StoreBAtWordTableEntry_Bank24_52CE::
Jump_024_4BB0:: ; address name
    ld a, [wListCursor]
    ld b, $BC
    ld hl, GameMode6_Update_ChooseRecordList_StoreBAtWordTableEntry_Bank24_52CE_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    call BGMapAddressAtScroll_Bank24
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_24
    call BGMapAddressAtScroll_Bank24
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRectToBGMap_24
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
    ld a, [wGameMode]
    cp a, $05
    ret nz
    ld a, [wLinkSession]
    cp a, $08
    ret z
    ld a, $08
    ld [wScreenStep], a
    ld a, $11
    ld [wScreenState], a
    ret

; by wScreenStep: the 'Info / OK / Yes / No' window, a record list and 'Switch with which?'
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
GameMode6_Update_SwitchMonster::
Jump_024_4C18:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw GameMode6_Update_SwitchMonster_ShowInfoOKYesN
    dw GameMode6_Update_SwitchMonster_ListRecordsInUseWithByte6EClear
    dw GameMode6_Update_SwitchMonster_DrawRecordListPageNames
    dw GameMode6_Update_SwitchMonster_ToEggServiceMenu_Bank1B
    dw GameMode6_Update_SwitchMonster_ToEggServiceMenu_Bank1B
    dw GameMode6_Update_SwitchMonster_AdvanceScreenStep
    dw GameMode6_Update_SwitchMonster_ToEggServiceMenu_Bank1B
    dw GameMode6_Update_SwitchMonster_ShowSwitchWithWhich

; entry 0 of the `rst $00` table in GameMode6_Update_SwitchMonster
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleScene, wListCursor, wScreenStep
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wScreenStep
GameMode6_Update_SwitchMonster_ShowInfoOKYesN::
Jump_024_4C2C:: ; address name
    ld b, $46
    ld de, Tiles1Gfx_46_4001
    ld hl, vTiles1
    call DecompressToVRAM
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
    ld a, $0D
    ld [wStringIndex], a ; 'InfoOKYesN'
    farcall ShowString_Bank33_7045
    call GameMode6_Update_SwitchMonster_Case00_FillTilesFromRequest
    ld a, [wBattleScene]
    cp a, $08
    jr z, .check_battle_scene
    call GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24_Shared01

.check_battle_scene:
    ld a, [wBattleScene]
    cp a, $08
    jr z, .skip
    call GameMode6_Update_SwitchMonster_Case00_LoadSRAMRecordWord
    jr .skip2

.skip:
    ld de, GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24_Data
    ld hl, wWindowTileBuffer + $F7
    ld bc, $0606
    call CopyRectTo20ByteRowsJp_Bank24

.skip2:
    ld de, TileRect_24_5AB8
    ld hl, wWindowTileBuffer + $64
    ld bc, $080B
    call CopyRectTo20ByteRowsJp_Bank24
    ld a, [wListCursor]
    ld b, $BC
    ld hl, GameMode6_Update_ChooseRecordList_StoreBAtWordTableEntry_Bank24_52CE_Data
    call StoreBAtWordTableEntry_Bank24_52CE
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in GameMode6_Update_SwitchMonster
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wScreenStep
; writes: wArg1, wArg2, wScreenStep
GameMode6_Update_SwitchMonster_ListRecordsInUseWithByte6EClear::
Jump_024_4CA0:: ; address name
    farcall ListRecordsInUseWithByte6EClear
    farcall ClampRecordListPageCursor5
    ld a, [wListPages]
    cp a, $02
    jr c, .check_screen_step
    ld hl, wWindowTileBuffer + $12E
    call StoreC5BEC6AtHLStride2_Bank24
    ld hl, wWindowTileBuffer + $12F
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

; entry 2 of the `rst $00` table in GameMode6_Update_SwitchMonster
; no direct call (reached through a table, a jump or a vector)
; writes: wArg1
GameMode6_Update_SwitchMonster_DrawRecordListPageNames::
Jump_024_4CD2:: ; address name
    farcall DrawRecordListPageNames
    xor a, a
    ld [wArg1], a
    farcall MarkPartyMembersInRecordListPage
    ret

; entry 3 of the `rst $00` table in GameMode6_Update_SwitchMonster; also entries 4, 6 of the table in GameMode6_Update_SwitchMonster
; no direct call (reached through a table, a jump or a vector)
GameMode6_Update_SwitchMonster_ToEggServiceMenu_Bank1B::
Jump_024_4CE3:: ; address name
    farcall EggServiceMenu_Bank1B
    ret

; entry 5 of the `rst $00` table in GameMode6_Update_SwitchMonster
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
GameMode6_Update_SwitchMonster_AdvanceScreenStep::
Jump_024_4CEA:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 7 of the `rst $00` table in GameMode6_Update_SwitchMonster
; no direct call (reached through a table, a jump or a vector)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringIndex, wStringCategory
GameMode6_Update_SwitchMonster_ShowSwitchWithWhich::
Jump_024_4CF2:: ; address name
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
    xor a, a
    ld [wStringCategory], a
    farcall ShowString_Bank33_7045
    farcall EggServiceMenu_Bank1B
    ret

; only called from routines of GameMode6_Update (E-0098)
; 3 call sites from 3 routines (e.g. GameMode6_Update_SavePrompt_ReturnStub_51A3, GameMode6_Update_SwitchEgg_ShowInfoOKYesN, GameMode6_Update_SwitchMonster_ShowInfoOKYesN)
; reads: wLinkByteEB
GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24_Shared01::
Func_024_4D21:: ; address name
    ld a, [wLinkByteEB]
    and a, a
    ret nz
    call GameMode6_Update_Shared01_DecompressToVRAM
    ld de, TileRect_24_57F2
    ld hl, wWindowTileBuffer + $7A
    ld bc, $1102
    call CopyRectTo20ByteRowsJp_Bank24
    ret

; only called from GameMode6_Update_ObtainedEgg_Case00 (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Update_ObtainedEgg_CopyRectTo20ByteRowsJp_Bank24)
; reads: wIsCGB
GameMode6_Update_ObtainedEgg_Case00_WaitForVRAMAccess::
Func_024_4D36:: ; address name
    ld a, [wIsCGB]
    and a, a
    ret z
    ld hl, rBGPI
    di
    call WaitForVRAMAccess
    ld a, $B8
    ld [hl+], a
    ei
    ld de, GameMode6_Update_ObtainedEgg_Case00_WaitForVRAMAccess_Data_6CA4
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
    ld de, GameMode6_Update_ObtainedEgg_Case00_WaitForVRAMAccess_Data_57D6
    ld hl, wWindowAttrBuffer + $7B
    ld b, $1C

.loop2:
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, .loop2
    ret

; only called from routines of GameMode6_Update_SavePrompt (E-0098)
; 3 call sites from 3 routines (e.g. GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor, GameMode6_Update_SavePrompt_UpdateTwoChoiceCursor_Bank1D, GameMode6_Update_SavePrompt_ShowYesNo_Case04)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wTextFlags, wTextControl
GameMode6_Update_SavePrompt_ShowYesNo::
Func_024_4D65:: ; address name
    ld hl, vTiles2 + $6D0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0301
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a, a
    ld [wStringCategory], a
    ld a, $0C
    ld [wStringIndex], a ; 'YesNo'
    farcall ShowString_Bank33_7045
    xor a, a
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

; only called from routines of GameMode6_Update (E-0098)
; 3 call sites from 3 routines (e.g. GameMode6_Update_SavePrompt_GameMode6_Update_ShowMonsterEg, GameMode6_Update_ChooseRecordList_GameMode6_Update_ShowMonsterEg, GameMode6_Update_ChooseRecordAndSave_GameMode6_Update_ShowMonsterEg)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wTextFlags, wTextControl
GameMode6_Update_ShowMonsterEg::
Func_024_4DA8:: ; address name
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
    xor a, a
    ld [wStringCategory], a
    ld a, $0B
    ld [wStringIndex], a ; 'MonsterE?g'
    farcall ShowString_Bank33_7045
    xor a, a
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

; only called from routines of GameMode6_Update (E-0098)
; 6 call sites from 6 routines (e.g. GameMode6_Update_ObtainedEgg_WriteScreenStepAndScreenState, GameMode6_Update_SavePrompt_ToGameMode6_Update_WriteLinkSceneByte4BAndGameModeEtc, GameMode6_Update_SavePrompt_RunSaveGameSteps, GameMode6_Update_Save_RunSaveGameSteps, ...)
; reads: wBattleScene
; writes: wLinkSceneByte4B, wGameMode, wModeState, wModeChangeRequest
; points at: wScreenState
GameMode6_Update_WriteLinkSceneByte4BAndGameModeEtc::
Func_024_4DEB:: ; address name
    ld hl, wScreenState
    ld bc, $006F

.loop:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    xor a, a
    ld [wLinkSceneByte4B], a
    ld a, $05
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    ld a, $01
    ld [wModeChangeRequest], a
    ld a, [wBattleScene]
    cp a, $08
    ret nz
    ret

; the same steps as CopyRectTo20ByteRows (copy a B x C rectangle from DE to HL with rows 20 bytes apart; on CGB zero-fill the same rectangle at HL + $0E68 with rSVBK = 2) but encoded with jp instead of jr, so its bytes differ (E-0066)
; 22 call sites from 16 routines (e.g. GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24, GameMode6_Update_ObtainedEgg_CopyRectTo20ByteRowsJp_Bank24, GameMode6_Update_SavePrompt_DecompressToVRAM, GameMode6_Update_SavePrompt_ReturnStub_51A3, ...)
; reads: wIsCGB
; writes: rSVBK
CopyRectTo20ByteRowsJp_Bank24::
Func_024_4E12:: ; address name
    push hl
    push bc

.loop:
    push hl
    push bc

.loop2:
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, .loop2
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jp nz, .loop
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

.loop3:
    push hl
    push bc

.loop4:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop4
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jp nz, .loop3
    ld a, $00
    ldh [rSVBK], a
    ret

; copies a rectangle of the screen buffer (offset DE) to the BG map at HL, sets wTextCursorLo = HL + $1C1, and on CGB copies its attributes (E-0127)
; 18 call sites from 15 routines (e.g. GameMode6_Init, GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24, GameMode6_Update_ObtainedEgg_CopyRectTo20ByteRowsJp_Bank24, GameMode6_Update_SavePrompt_DecompressToVRAM, ...)
; reads: wIsCGB
; writes: wTextCursorLo, wTextCursorHi, rSVBK
; points at: wScreenTileBuffer, wScreenAttrBuffer
DrawScreenBufferRectToBGMap_24::
Func_024_4E57:: ; address name
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
; 22 call sites from 17 routines (e.g. GameMode6_Init, GameMode6_Init_UploadBGPalettes, GameMode6_Init_Sub01_WriteVRAMByteInc, GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank24::
Func_024_4EAB:: ; address name
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
; no direct call (reached through a table, a jump or a vector)
CopyBytesDEToHL_Bank24_4ECC:: ; heuristic: follows a terminator; C0
Func_024_4ECC:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, CopyBytesDEToHL_Bank24_4ECC
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same 19 bytes appear in 5 banks)
; no direct call (reached through a table, a jump or a vector)
; writes: rSVBK
CopyLow3BitsToWRAMBank2_Bank24_4ED5:: ; heuristic: follows a terminator; C0
Func_024_4ED5:: ; address name
    ld a, $02
    ldh [rSVBK], a

.loop:
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld a, $00
    ldh [rSVBK], a
    ret

; wStringIndex = A, wStringCategory = 0, string window = vTiles1 with size word $1202 (as SetDefaultStringWindow), then far-calls BeginStringDisplay_Bank33_7037 (E-0072)
; 15 call sites from 12 routines (e.g. GameMode6_Update_ObtainedEgg_CopyRectTo20ByteRowsJp_Bank24, GameMode6_Update_SavePrompt_DecompressToVRAM, GameMode6_Update_SavePrompt_ShowStringAInDefaultWindow_Bank24, GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor, ...)
; writes: wStringIndex, wStringCategory, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ShowStringAInDefaultWindow_Bank24::
Func_024_4EE8:: ; address name
    ld [wStringIndex], a
    xor a, a
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
; 2 call sites from 2 routines (e.g. GameMode6_Update_SavePrompt_UpdateTwoChoiceCursor_Bank1D, GameMode6_Update_SavePrompt_ObjectScene_CopyWCA2CNameToTextBuf0)
; points at: wTextBuf0
CopyWCA2CNameToTextBuf0::
Func_024_4F0C:: ; address name
    ld hl, wRecordBufB + MON_NAME
    jp CopyWC987NameToTextBuf0_Skip

; copies up to 10 name bytes from wRecordBufA + $1 (stopping at $F0) to wTextBuf0 with a $F0 terminator (E-0124)
; 1 call site from 1 routine (e.g. GameMode6_Update_Save_ObjectScene_CopyWC987NameToTextBuf0)
; points at: wTextBuf0
CopyWC987NameToTextBuf0::
Func_024_4F12:: ; address name
    ld hl, wRecordBufA + MON_NAME

CopyWC987NameToTextBuf0_Skip::
Jump_024_4F15:: ; address name
    ld de, wTextBuf0
    ld b, $0A

.loop:
    ld a, [hl]
    cp a, $F0
    jr z, .done
    ld [de], a
    inc de
    inc hl
    dec b
    jr nz, .loop

.done:
    ld a, $F0
    ld [de], a
    ret

; only called from GameMode6_Update_Case04_PageList_Case00 (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Update_Case04_PageList_UpdatePagedListCursor)
; reads: wPartyCount, wListCursor, wListPageIndex
GameMode6_Update_Case04_PageList_Case00_ReadPartyCountAndListCursorEtc::
Func_024_4F29:: ; address name
    ld a, [wPartyCount]
    cp a, $02
    jr nc, .return_0
    ld a, [wListCursor]
    and a, a
    jr nz, .return_0
    ld a, [wListPageIndex]
    and a, a
    jr nz, .return_0
    ld a, $FF
    ret

.return_0:
    xor a, a
    ret

; only called from GameMode6_Update_ChooseRecordAndSave_Case08 (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Update_ChooseRecordAndSave_HandleTwoChoiceCursorInput_0D)
; writes: rRAMG, rRAMB
; points at: sRecords
GameMode6_Update_ChooseRecordAndSave_Case08_Multiply8::
Func_024_4F41:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $A5
    call Multiply8
    ld de, sRecords
    add hl, de
    ld a, $0B
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld d, [hl]
    ld h, d
    ld l, e
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

; HL = string number; copies 16 bytes of that string of StringTable_MonsterNames (bank $08, via wDataBank) to wNameGlyphBuf; wDataBank is restored
; 1 call site from 1 routine (e.g. GameMode6_Update_ChooseRecordAndSave_HandleTwoChoiceCursorInput_0D)
; reads: wDataBank
; writes: wDataBank
; points at: wTextBuf0
CopyMonsterNameToBuffer_B24::
Func_024_4F68:: ; address name
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

; only called from GameMode6_Update_ChooseRecordList_Case0A (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Update_ChooseRecordList_HandleTwoChoiceCursorInput_0D)
; reads: wArg5, wArg6
; writes: rRAMG, rRAMB, wNameGlyphBuf
; points at: wNameGlyphBuf, wTextBuf0
GameMode6_Update_ChooseRecordList_Case0A_SetArg5ToListEntriesCell5::
Func_024_4FA3:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0

.skip:
    ld a, [hl]
    cp a, $F0
    jr z, .done
    ld [de], a
    inc hl
    inc de
    jr .skip

.done:
    ld a, $F0
    ld [de], a
    ret

; only called from GameMode6_Update_SwitchMonster_Case00 (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Update_SwitchMonster_ShowInfoOKYesN)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
GameMode6_Update_SwitchMonster_Case00_FillTilesFromRequest::
Func_024_4FD9:: ; address name
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
    ret

; only called from GameMode6_Update_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24_Shared01)
GameMode6_Update_Shared01_DecompressToVRAM::
Func_024_504C:: ; address name
    and a, $01
    and a, a
    jr nz, .skip
    ld de, GameMode6_Init_Data_6CE4
    ld b, $24
    jr .call_decompress_to_vram

.skip:
    ld de, Tiles1Plus600Gfx_24_6E13
    ld b, $24

.call_decompress_to_vram:
    ld hl, vTiles2
    call DecompressToVRAM
    ret

; only called from GameMode6_Init (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Init)
; reads: wBattleScene, wIsCGB, wScreenByteBD
; writes: wBGPaletteUploadRequest, hTemp0, wArg5, wArg6, wArg1, wArg2, wArg3, wArg4, ...
GameMode6_Init_UploadBGPalettes::
Func_024_5064:: ; address name
    ld a, [wBattleScene]
    cp a, $08
    ret z
    ld a, [wIsCGB]
    and a, a
    jp z, .check_battle_scene
    ld hl, wBattlerRecords + BATTLER_SPECIES
    ld de, wBattlerRecordSlot4 + BATTLER_SPECIES
    call GameMode6_Init_ReadLinkSceneByte4B
    ld a, [hl+]
    ld e, a
    ld d, [hl]
    push de
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes
    ld a, $01
    ldh [hTemp0], a
    call BGMapAddressAtScroll_Bank24
    xor a, a
    call GameMode6_Init_Sub01_ReadScreenByteBD
    add hl, de
    pop de
    call LoadMonsterPictureAttributes
    ld a, [wScreenByteBD]
    cp a, $01
    jr z, .check_battle_scene
    ld hl, wBattlerRecordSlot1 + BATTLER_SPECIES
    ld de, wBattlerRecordSlot5 + BATTLER_SPECIES
    call GameMode6_Init_ReadLinkSceneByte4B
    ld a, [hl+]
    ld e, a
    ld d, [hl]
    push de
    ld a, $7F
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
    cp a, $02
    jr z, .check_battle_scene
    ld hl, wBattlerRecordSlot2 + BATTLER_SPECIES
    ld de, wBattlerRecordSlot6 + BATTLER_SPECIES
    call GameMode6_Init_ReadLinkSceneByte4B
    ld a, [hl+]
    ld e, a
    ld d, [hl]
    push de
    ld a, $7F
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
    cp a, $08
    jp nz, GameMode6_Init_Sub01_WriteVRAMByteInc_CallBGMapAddressAtScroll_Bank24
    ld hl, wWindowTileBuffer + $F7
    call GameMode6_Init_Sub01_WriteVRAMByteInc
    ld hl, wScreenTileBuffer + $93

; only called from GameMode6_Init_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Init_UploadBGPalettes)
GameMode6_Init_Sub01_WriteVRAMByteInc::
Func_024_5101:: ; address name
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
    add a, $0E
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jr nz, .loop
    ld hl, vBGMap0 + $E7
    ld bc, $0606
    ld d, $20

.loop2:
    ld a, d
    call WriteVRAMByteInc
    inc d
    dec b
    jr nz, .loop2
    ld a, l
    add a, $1A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $06
    dec c
    jr nz, .loop2
    call ReturnStub_51A3
    ret

GameMode6_Init_Sub01_WriteVRAMByteInc_CallBGMapAddressAtScroll_Bank24::
Jump_024_513A:: ; address name
    call BGMapAddressAtScroll_Bank24
    ld de, $00E0
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

; only called from GameMode6_Init_Sub01 (E-0047)
; 3 call sites from 1 routine (e.g. GameMode6_Init_UploadBGPalettes)
; reads: wScreenByteBD
GameMode6_Init_Sub01_ReadScreenByteBD::
Func_024_5174:: ; address name
    push hl
    ld e, a
    ld d, $00
    ld a, [wScreenByteBD]
    dec a
    ld hl, GameMode6_Init_Sub01_ReadScreenByteBD_Data_5191
    jr z, .skip
    dec a
    ld hl, GameMode6_Init_Sub01_ReadScreenByteBD_Data_5197
    jr z, .skip
    ld hl, GameMode6_Init_Sub01_ReadScreenByteBD_Data_519D

.skip:
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    pop hl
    ret

; address loaded by GameMode6_Init_Sub01_ReadScreenByteBD
GameMode6_Init_Sub01_ReadScreenByteBD_Data_5191:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_024_5191:: ; address name
    db $E7, $00, $00, $00, $00, $00

; address loaded by GameMode6_Init_Sub01_ReadScreenByteBD
GameMode6_Init_Sub01_ReadScreenByteBD_Data_5197:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_024_5197:: ; address name
    db $E4, $00, $EA, $00, $00, $00

; address loaded by GameMode6_Init_Sub01_ReadScreenByteBD
GameMode6_Init_Sub01_ReadScreenByteBD_Data_519D:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_024_519D:: ; address name
    db $E1, $00, $E7, $00, $ED, $00

; a bare ret (E-0115)
; 6 call sites from 6 routines (e.g. GameMode6_Init_Sub01_WriteVRAMByteInc, GameMode6_Update_SavePrompt_DecompressToVRAM, GameMode6_Update_SavePrompt_ReturnStub_51A3, GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor, ...)
ReturnStub_51A3::
Func_024_51A3:: ; address name
    ret

; on CGB with wBattleScene = 8: copies the 6 x 6 block Data_024_51D3 into the WRAM-bank-2 buffer at wWindowAttrBuffer + $F7 (20-byte rows) (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wBattleScene
; writes: rSVBK
CopyAttributeBlock51D3ToWD25F:: ; heuristic: follows a terminator; C0
Func_024_51A4:: ; address name
    ld a, [wIsCGB]
    and a, a
    ret z
    ld a, [wBattleScene]
    cp a, $08
    ret nz
    ld hl, CopyAttributeBlock51D3ToWD25F_Data
    ld de, wWindowAttrBuffer + $F7
    ld a, $02
    ldh [rSVBK], a
    ld bc, $0606

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld b, $06
    ld a, e
    add a, $0E
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec c
    jr nz, .loop
    xor a, a
    ldh [rSVBK], a
    ret

; address loaded by CopyAttributeBlock51D3ToWD25F
CopyAttributeBlock51D3ToWD25F_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_024_51D3:: ; address name
    ds $24, $01

; only called from routines of GameMode6_Init (E-0098)
; 7 call sites from 2 routines (e.g. GameMode6_Init_UploadBGPalettes, GameMode6_Init_LoadMonsterPicture)
; reads: wLinkSceneByte4B
GameMode6_Init_ReadLinkSceneByte4B::
Func_024_51F7:: ; address name
    ld a, [wLinkSceneByte4B]
    and a, a
    jr nz, .done
    ret

.done:
    ld l, e
    ld h, d
    ret

; only called from GameMode6_Init (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Init)
; reads: wBattleScene
; writes: wScreenByteBD
GameMode6_Init_LoadMonsterPicture::
Func_024_5201:: ; address name
    ld a, [wBattleScene]
    cp a, $08
    jr nz, .call_game_mode6_init_read_link_scene_byte4_b
    ld hl, wBattlerRecords + BATTLER_SPECIES
    ld de, wBattlerRecordSlot4 + BATTLER_SPECIES
    call GameMode6_Init_ReadLinkSceneByte4B
    ld a, [hl+]
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
    ld a, [hl+]
    ld e, a
    ld d, [hl]
    ld hl, vTiles2
    ld c, $01
    call LoadMonsterPicture
    ld hl, wBattlerRecordSlot1 + BATTLER_SPECIES
    ld de, wBattlerRecordSlot5 + BATTLER_SPECIES
    call GameMode6_Init_ReadLinkSceneByte4B
    ld a, [hl+]
    ld b, a
    ld a, [hl-]
    or a, b
    and a, a
    jr nz, .skip
    ld a, $01
    ld [wScreenByteBD], a
    ret

.skip:
    ld a, [hl+]
    ld e, a
    ld d, [hl]
    ld hl, vTiles2 + $240
    ld c, $03
    call LoadMonsterPicture
    ld hl, wBattlerRecordSlot2 + BATTLER_SPECIES
    ld de, wBattlerRecordSlot6 + BATTLER_SPECIES
    call GameMode6_Init_ReadLinkSceneByte4B
    ld a, [hl+]
    ld b, a
    ld a, [hl-]
    or a, b
    and a, a
    jr nz, .skip2
    ld a, $02
    ld [wScreenByteBD], a
    ret

.skip2:
    ld a, [hl+]
    ld e, a
    ld d, [hl]
    ld hl, vTiles2 + $480
    ld c, $05
    call LoadMonsterPicture
    ld a, $03
    ld [wScreenByteBD], a
    ret

; only called from GameMode6_Update_SwitchMonster_Case00 (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Update_SwitchMonster_ShowInfoOKYesN)
; reads: wListPageIndex, wListCursor, hTemp0, hTemp1
; writes: rRAMG2, rRAMB
; points at: wListEntries
GameMode6_Update_SwitchMonster_Case00_LoadSRAMRecordWord::
Func_024_527E:: ; address name
    ld a, [wListPageIndex]
    ld b, a
    sla a
    sla a
    add a, b
    ld b, a
    ld a, [wListCursor]
    add a, b
    ld hl, wListEntries
    add_a_to_hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
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
    xor a, a
    ld [rRAMG2], a
    ret

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for rSTAT bit 1 to clear; clobbers A; HL and DE advance (the same 20 bytes appear in 3 banks)
; 1 call site from 1 routine (e.g. GameMode6_Update_SavePrompt_DecompressToVRAM)
; reads: rSTAT
CopyTileBytesToVRAM_Bank24_52BA::
Func_024_52BA:: ; address name
    xor a, a

.loop:
    push af
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    pop af
    inc a
    cp a, $10
    jr c, .loop
    ret

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers A, DE, HL (the same 16 bytes appear in 4 banks)
; 17 call sites from 12 routines (e.g. GameMode6_Update_SavePrompt_ShowStringAInDefaultWindow_Bank24, GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor, GameMode6_Update_ChooseRecordList_GameMode6_Update_ShowMonsterEg, GameMode6_Update_ChooseRecordList_StoreBAtWordTableEntry_Bank24_52CE, ...)
StoreBAtWordTableEntry_Bank24_52CE::
Func_024_52CE:: ; address name
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

; copies the $A5 bytes at Data_024_52ED to wRecordBufB (E-0122)
; no direct call (reached through a table, a jump or a vector)
; points at: wRecordBufB
CopyDefaultRecordToRecordBufB:: ; heuristic: follows a terminator; C0
Func_024_52DE:: ; address name
    ld hl, DefaultMonsterRecord
    ld de, wRecordBufB
    ld b, $A5

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

; E-0239 (C1: CopyDefaultRecordToRecordBufB copies these $A5 bytes to wRecordBufB; laid out like PresetMonsterRecords (E-0235): byte 0 = 1, both names "???"; fields from E-0034, E-0104, E-0122, E-0125 and E-0237, laid out in E-0262).
; record: one $A5-byte monster record in the SRAM record format
DefaultMonsterRecord::
Data_024_52ED:: ; address name
    db $01 ; id 0: state: 0 empty, 1 or 2 in use (E-0104)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; name, bytes 1-10 (E-0034)
    dw $00D4 ; word $0B (compared with monster ids by talk events $29/$47, E-0236)
    db $07 ; $0D: low nibble = family (E-0122)
    db $00 ; $0E: bit 0 = sex, 0 male, 1 female (C2, E-0311)
    db "???", $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; master name, $0F-$18 (E-0034, E-0297)
    db $00 ; $19: master id (C1, E-0306)
    dw $FFFF, $FFFF ; $1A, $1C: species of parent 1 and 2 (E-0297)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $1E: master name of parent 1 (E-0297)
    db $00 ; $28 (unused)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $29: master name of parent 2 (E-0297)
    db $00 ; $33 (unused)
    db $16, $1B, $40, $00, $00, $00, $00, $00 ; skills, $34-$3B (E-0122)
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; $3C-$54: the list AppendMappedSkillsToWCA67 appends to, up to $FF (E-0237)
    db $00 ; $55: status bits (bit 2 read as poison, E-0085)
    db $12 ; $56: level (E-0122)
    db $2D ; $57: level cap (C1, E-0296)
    db $00, $00, $00 ; $58: EXP, 24 bits (E-0125)
    dw $0083, $0083, $0028, $0028 ; $5B HP, $5D max HP, $5F MP, $61 max MP (E-0122)
    dw $008A, $005D, $0045, $017F ; $63 ATK, $65 DEF, $67 AGL, $69 INT (C1, E-0290)
    db $00, $00, $00, $00 ; $6B WLD word, $6D plus value, $6E egg state 0/1/2 (E-0296, E-0311)
    db $C8, $C8, $96, $50 ; $6F-$72: personality axes from MonsterTable bytes 22-25 (E-0034)
    db $01, $01, $01, $00, $00, $02, $02, $02, $02, $00, $00, $02, $00, $00, $03, $00, $00, $02, $02, $02, $02, $00, $00, $00, $00, $00, $01 ; $73-$8D: 27 resistance levels (C1, E-0299)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $8E: name of parent 1 (E-0297)
    db $00 ; $98: plus value of parent 1 (E-0297)
    db $98, $98, $98, $F0, $F0, $F0, $F0, $F0, $F0, $F0 ; $99: name of parent 2 (E-0297)
    db $00 ; $A3: plus value of parent 2 (E-0297)
    db $00 ; $A4: equipped item (E-0125)

; [HL] = $C5, [HL+2] = $BE, [HL+4] = $C6; HL ends at HL+4; clobbers A (the same 14 bytes appear in 8 banks)
; 3 call sites from 3 routines (e.g. GameMode6_Update_ChooseRecordAndSave_ClampRecordListPageCursor4, GameMode6_Update_SwitchEgg_ListRecordsInUseWithByte6ESet, GameMode6_Update_SwitchMonster_ListRecordsInUseWithByte6EClear)
StoreC5BEC6AtHLStride2_Bank24::
Func_024_5392:: ; address name
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

; only called from routines of GameMode6_Update (E-0098)
; 2 call sites from 2 routines (e.g. GameMode6_Update_ChooseRecordAndSave_ToGameMode6_Update_FillTilesFromRequestAndStep, GameMode6_Update_SwitchEgg_ShowInfoOKYesN)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
GameMode6_Update_FillTilesFromRequest::
Func_024_53A0:: ; address name
    ld hl, vTiles1 + $3F0
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
    ld hl, $0F01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, vTiles1 + $6A0
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

; by wScreenSubStep: alternates timed waits (wScreenCounter) with moves of field objects 1, 2 and 5, and copies a name to the text buffer: a short object animation
; 1 call site from 1 routine (e.g. GameMode6_Update_Save_GameMode6_Update_UpdateAndDrawSpriteSlots)
; reads: wScreenSubStep
GameMode6_Update_Save_ObjectScene::
Func_024_5434:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw GameMode6_Update_Save_ObjectScene_WriteScreenCounterAndScreenSubStep
    dw GameMode6_Update_Save_ObjectScene_WriteObject2AndSpriteSlotsEtc
    dw GameMode6_Update_Save_ObjectScene_WriteScreenCounterAndScreenSubStep
    dw GameMode6_Update_Save_ObjectScene_WriteObject1AndScreenSubStep
    dw GameMode6_Update_Save_ObjectScene_WriteScreenCounterAndScreenSubStep
    dw GameMode6_Update_Save_ObjectScene_WriteObject5AndScreenSubStep
    dw GameMode6_Update_Save_ObjectScene_WriteScreenCounterAndScreenSubStep
    dw GameMode6_Update_Save_ObjectScene_WriteObject2AndScreenSubStep
    dw GameMode6_Update_Save_ObjectScene_CopyWC987NameToTextBuf0
    dw GameMode6_Update_Save_ObjectScene_WriteScreenCounterAndScreenSubStep
    dw GameMode6_Update_Save_ObjectScene_WriteScreenCounterAndScreenSubStep
    dw GameMode6_Update_Save_ObjectScene_WriteObject5AndObject1Etc
    dw GameMode6_Update_Save_ObjectScene_WriteObject2AndObject1Etc
    dw GameMode6_Update_Save_ObjectScene_WriteSpriteSlotsAndScreenSubStepEtc

; entry 1 of the `rst $00` table in GameMode6_Update_Save_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, wObject2, wScreenSubStep
; writes: wObject2, wSpriteSlots, wScreenSubStep
GameMode6_Update_Save_ObjectScene_WriteObject2AndSpriteSlotsEtc::
Jump_024_5454:: ; address name
    ld a, [wSpriteSlots + $9]
    and a, $03
    and a, a
    ret z
    ld a, [wObject2 + OBJ_X]
    dec a
    ld [wObject2 + OBJ_X], a
    ld a, [wSpriteSlots + $B]
    dec a
    ld [wSpriteSlots + $B], a
    cp a, $58
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 0 of the `rst $00` table in GameMode6_Update_Save_ObjectScene; also entries 2, 4, 6, 9, 10 of the table in GameMode6_Update_Save_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenCounter, wScreenSubStep
; writes: wScreenCounter, wScreenSubStep
GameMode6_Update_Save_ObjectScene_WriteScreenCounterAndScreenSubStep::
Jump_024_5474:: ; address name
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp a, $10
    ret c
    xor a, a
    ld [wScreenCounter], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 3 of the `rst $00` table in GameMode6_Update_Save_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, wScreenSubStep
; writes: wObject1, wScreenSubStep
GameMode6_Update_Save_ObjectScene_WriteObject1AndScreenSubStep::
Jump_024_548A:: ; address name
    ld a, [wObject1 + OBJ_ANIM_COUNTER]
    and a, $03
    and a, a
    ret z
    ld a, [wObject1 + OBJ_X]
    inc a
    ld [wObject1 + OBJ_X], a
    cp a, $38
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 5 of the `rst $00` table in GameMode6_Update_Save_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; reads: wRecordBufB, wScreenSubStep
; writes: wObject5, wScreenSubStep
GameMode6_Update_Save_ObjectScene_WriteObject5AndScreenSubStep::
Jump_024_54A3:: ; address name
    ld a, [wRecordBufB + MON_EGG]
    and a, a
    jr z, .check_screen_sub_step
    ld a, $80
    ld [wObject5], a

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 7 of the `rst $00` table in GameMode6_Update_Save_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; reads: wRecordBufB, wObject2, wScreenSubStep
; writes: wObject2, wScreenSubStep
GameMode6_Update_Save_ObjectScene_WriteObject2AndScreenSubStep::
Jump_024_54B6:: ; address name
    ld a, [wRecordBufB + MON_EGG]
    and a, a
    jr nz, .check_screen_sub_step
    ld a, [wObject2 + OBJ_ANIM_COUNTER]
    and a, $03
    and a, a
    ret z
    ld a, [wObject2 + OBJ_X]
    dec a
    ld [wObject2 + OBJ_X], a
    cp a, $28
    ret nz
    ld a, $01
    ld [wObject2 + OBJ_STATE], a

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 8 of the `rst $00` table in GameMode6_Update_Save_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
; writes: wScreenSubStep
GameMode6_Update_Save_ObjectScene_CopyWC987NameToTextBuf0::
Jump_024_54DA:: ; address name
    call CopyWC987NameToTextBuf0
    ld a, $03
    call ShowStringAInDefaultWindow_Bank24
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 11 of the `rst $00` table in GameMode6_Update_Save_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, wScreenSubStep
; writes: wObject5, wObject1, wScreenSubStep
GameMode6_Update_Save_ObjectScene_WriteObject5AndObject1Etc::
Jump_024_54EA:: ; address name
    xor a, a
    ld [wObject5], a
    ld a, $03
    ld [wObject1 + OBJ_STATE], a
    ld a, [wObject1 + OBJ_ANIM_COUNTER]
    and a, $03
    and a, a
    ret z
    ld a, [wObject1 + OBJ_X]
    dec a
    ld [wObject1 + OBJ_X], a
    cp a, $18
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 12 of the `rst $00` table in GameMode6_Update_Save_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, wObject2, wScreenSubStep
; writes: wObject2, wObject1, wScreenSubStep
GameMode6_Update_Save_ObjectScene_WriteObject2AndObject1Etc::
Jump_024_550C:: ; address name
    ld a, $03
    ld [wObject2 + OBJ_STATE], a
    ld a, [wObject1 + OBJ_ANIM_COUNTER]
    and a, $03
    and a, a
    ret z
    ld a, [wObject2 + OBJ_X]
    dec a
    ld [wObject2 + OBJ_X], a
    ld a, [wObject1 + OBJ_X]
    dec a
    ld [wObject1 + OBJ_X], a
    cp a, $D8
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 13 of the `rst $00` table in GameMode6_Update_Save_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, wScreenStep
; writes: wSpriteSlots, wScreenSubStep, wScreenStep
GameMode6_Update_Save_ObjectScene_WriteSpriteSlotsAndScreenSubStepEtc::
Jump_024_5531:: ; address name
    ld a, $01
    ld [wSpriteSlots + $7], a
    ld a, [wSpriteSlots + $9]
    and a, $03
    and a, a
    ret z
    ld a, [wSpriteSlots + $B]
    inc a
    ld [wSpriteSlots + $B], a
    cp a, $B0
    ret nz
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; by wScreenSubStep: timed waits and moves of field objects 1, 2 and 5 with a name copy, as GameMode6_Update_Save_ObjectScene
; 1 call site from 1 routine (e.g. GameMode6_Update_SavePrompt_ObjectScene_Case0E)
; reads: wScreenSubStep
GameMode6_Update_SavePrompt_ObjectScene::
Func_024_5553:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw GameMode6_Update_SavePrompt_ObjectScene_WriteScreenCounterAndScreenSubStep
    dw GameMode6_Update_SavePrompt_ObjectScene_WriteSpriteSlotsAndScreenSubStep
    dw GameMode6_Update_SavePrompt_ObjectScene_WriteScreenCounterAndScreenSubStep
    dw GameMode6_Update_SavePrompt_ObjectScene_WriteObject2AndObject1Etc
    dw GameMode6_Update_SavePrompt_ObjectScene_WriteScreenCounterAndScreenSubStep
    dw GameMode6_Update_SavePrompt_ObjectScene_WriteObject5AndScreenSubStep
    dw GameMode6_Update_SavePrompt_ObjectScene_WriteScreenCounterAndScreenSubStep
    dw GameMode6_Update_SavePrompt_ObjectScene_WriteObject2AndScreenSubStep
    dw GameMode6_Update_SavePrompt_ObjectScene_CopyWCA2CNameToTextBuf0
    dw GameMode6_Update_SavePrompt_ObjectScene_WriteScreenCounterAndScreenSubStep
    dw GameMode6_Update_SavePrompt_ObjectScene_WriteScreenCounterAndScreenSubStep
    dw GameMode6_Update_SavePrompt_ObjectScene_WriteObject1AndScreenSubStep
    dw GameMode6_Update_SavePrompt_ObjectScene_WriteObject5AndSpriteSlotsEtc
    dw GameMode6_Update_SavePrompt_ObjectScene_WriteObject2AndSpriteSlotsEtc

; entry 1 of the `rst $00` table in GameMode6_Update_SavePrompt_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, wScreenSubStep
; writes: wSpriteSlots, wScreenSubStep
GameMode6_Update_SavePrompt_ObjectScene_WriteSpriteSlotsAndScreenSubStep::
Jump_024_5573:: ; address name
    ld a, [wSpriteSlots + $9]
    and a, $03
    and a, a
    ret z
    ld a, [wSpriteSlots + $B]
    dec a
    ld [wSpriteSlots + $B], a
    cp a, $59
    ret nc
    ld a, $58
    ld [wSpriteSlots + $B], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 3 of the `rst $00` table in GameMode6_Update_SavePrompt_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, wObject2, wScreenSubStep
; writes: wObject2, wObject1, wScreenSubStep
GameMode6_Update_SavePrompt_ObjectScene_WriteObject2AndObject1Etc::
Jump_024_5591:: ; address name
    ld a, [wObject1 + OBJ_ANIM_COUNTER]
    and a, $03
    and a, a
    ret z
    ld a, [wObject2 + OBJ_X]
    inc a
    ld [wObject2 + OBJ_X], a
    ld a, [wObject1 + OBJ_X]
    inc a
    ld [wObject1 + OBJ_X], a
    cp a, $38
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 0 of the `rst $00` table in GameMode6_Update_SavePrompt_ObjectScene; also entries 2, 4, 6, 9, 10 of the table in GameMode6_Update_SavePrompt_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenCounter, wScreenSubStep
; writes: wScreenCounter, wScreenSubStep
GameMode6_Update_SavePrompt_ObjectScene_WriteScreenCounterAndScreenSubStep::
Jump_024_55B1:: ; address name
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp a, $10
    ret c
    xor a, a
    ld [wScreenCounter], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 5 of the `rst $00` table in GameMode6_Update_SavePrompt_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; reads: wRecordBufB, wScreenSubStep
; writes: wObject5, wScreenSubStep
GameMode6_Update_SavePrompt_ObjectScene_WriteObject5AndScreenSubStep::
Jump_024_55C7:: ; address name
    ld a, [wRecordBufB + MON_EGG]
    and a, a
    jr z, .check_screen_sub_step
    ld a, $80
    ld [wObject5], a

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 7 of the `rst $00` table in GameMode6_Update_SavePrompt_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; reads: wRecordBufB, wObject2, wScreenSubStep
; writes: wObject2, wScreenSubStep
GameMode6_Update_SavePrompt_ObjectScene_WriteObject2AndScreenSubStep::
Jump_024_55DA:: ; address name
    ld a, [wRecordBufB + MON_EGG]
    and a, a
    jr nz, .check_screen_sub_step
    ld a, [wObject2 + OBJ_ANIM_COUNTER]
    and a, $03
    and a, a
    ret z
    ld a, [wObject2 + OBJ_X]
    inc a
    ld [wObject2 + OBJ_X], a
    cp a, $68
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

; entry 8 of the `rst $00` table in GameMode6_Update_SavePrompt_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
; writes: wScreenSubStep
GameMode6_Update_SavePrompt_ObjectScene_CopyWCA2CNameToTextBuf0::
Jump_024_5603:: ; address name
    call CopyWCA2CNameToTextBuf0
    ld a, $04
    call ShowStringAInDefaultWindow_Bank24
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 11 of the `rst $00` table in GameMode6_Update_SavePrompt_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, wScreenSubStep
; writes: wObject1, wScreenSubStep
GameMode6_Update_SavePrompt_ObjectScene_WriteObject1AndScreenSubStep::
Jump_024_5613:: ; address name
    ld a, $03
    ld [wObject1 + OBJ_STATE], a
    ld a, [wObject1 + OBJ_ANIM_COUNTER]
    and a, $03
    and a, a
    ret z
    ld a, [wObject1 + OBJ_X]
    dec a
    ld [wObject1 + OBJ_X], a
    cp a, $E0
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 12 of the `rst $00` table in GameMode6_Update_SavePrompt_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, wScreenSubStep
; writes: wObject5, wSpriteSlots, wScreenSubStep
GameMode6_Update_SavePrompt_ObjectScene_WriteObject5AndSpriteSlotsEtc::
Jump_024_5631:: ; address name
    xor a, a
    ld [wObject5], a
    ld a, $01
    ld [wSpriteSlots + $7], a
    ld a, [wSpriteSlots + $9]
    and a, $03
    and a, a
    ret z
    ld a, [wSpriteSlots + $B]
    inc a
    ld [wSpriteSlots + $B], a
    cp a, $78
    ret c
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 13 of the `rst $00` table in GameMode6_Update_SavePrompt_ObjectScene
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, wObject2, wScreenStep
; writes: wObject2, wSpriteSlots, wScreenSubStep, wScreenStep
GameMode6_Update_SavePrompt_ObjectScene_WriteObject2AndSpriteSlotsEtc::
Jump_024_5653:: ; address name
    ld a, $01
    ld [wObject2 + OBJ_STATE], a
    ld a, [wSpriteSlots + $9]
    and a, $03
    and a, a
    ret z
    ld a, [wObject2 + OBJ_X]
    inc a
    ld [wObject2 + OBJ_X], a
    ld a, [wSpriteSlots + $B]
    inc a
    ld [wSpriteSlots + $B], a
    cp a, $C0
    ret c
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; only called from routines of GameMode6_Update (E-0098)
; 4 call sites from 3 routines (e.g. GameMode6_Update, GameMode6_Update_SavePrompt_ObjectScene_Case0E, GameMode6_Update_Save_GameMode6_Update_UpdateAndDrawSpriteSlots)
; reads: wRecordBufB
GameMode6_Update_UpdateAndDrawSpriteSlots::
Func_024_567C:: ; address name
    farcall UpdateAndDrawSpriteSlots
    ld a, [wRecordBufB + MON_EGG]
    and a, a
    ret z
    farcall DrawFieldSprites
    ret

; only called from routines of GameMode6_Update_Save (E-0098)
; 2 call sites from 2 routines (e.g. GameMode6_Update_SavePrompt_ToGameMode6_Update_Save_TestFlagBitAndStep, GameMode6_Update_Save_WriteScreenStep)
; reads: wRecordBufB, wBattleScene, wIsCGB, wRecordBufA
; writes: hTemp0, hTemp1, wObject2, wSpriteSlotCount, wOBJPaletteUploadRequest, wObject5
; points at: wSpriteSlots, wObject1, hTemp0, wObject2
GameMode6_Update_Save_TestFlagBit::
Func_024_568E:: ; address name
    ld de, $0000
    call TestFlagBit
    jr c, .skip
    ld hl, GameMode6_Update_Save_TestFlagBit_Data_5BE9
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
    ld hl, GameMode6_Update_Save_TestFlagBit_Data_5BD1
    jr .call_copy_bytes_de_from_hl_bank242

.skip2:
    ld hl, GameMode6_Update_Save_TestFlagBit_Data_5BD7

.call_copy_bytes_de_from_hl_bank242:
    ld de, hTemp0
    ld b, $06
    call CopyBytesDEFromHL_Bank24
    farcall DecompressGraphicsTemp0ToTemp4
    ld hl, GameMode6_Update_Save_TestFlagBit_Data_5BDD
    ld de, hTemp0
    ld b, $06
    call CopyBytesDEFromHL_Bank24
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, [wRecordBufB + MON_EGG]
    and a, a
    jr nz, .set_temp0_to_0D
    ld hl, GameMode6_Update_Save_TestFlagBit_Data_5BE3
    ld de, hTemp0
    ld b, $06
    call CopyBytesDEFromHL_Bank24
    ld a, [wBattleScene]
    cp a, $08
    jr z, .read_record_buf_a
    and a, $01
    and a, a
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
    cp a, $08
    jr z, .skip3
    and a, $01
    and a, a
    jr nz, .skip3
    ld hl, GameMode6_Update_Save_TestFlagBit_Data_5C19
    jr .call_copy_bytes_de_from_hl_bank243

.skip3:
    ld hl, Object2Init_24_5C29

.call_copy_bytes_de_from_hl_bank243:
    ld de, wObject2
    ld b, $10
    call CopyBytesDEFromHL_Bank24
    ld a, [wBattleScene]
    cp a, $08
    jr z, .read_record_buf_a2
    and a, $01
    and a, a
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
    ld a, $0D
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    xor a, a
    ld [wObject5], a
    ld a, $48
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld a, $02
    ld [wSpriteSlotCount], a

.check_is_cgb:
    ld a, [wIsCGB]
    and a, a
    jr z, .return
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a

.return:
    ret

; the same 7 bytes as CopyBytesDEFromHL (34:406E)
; 6 call sites from 1 routine (e.g. GameMode6_Update_Save_TestFlagBit)
CopyBytesDEFromHL_Bank24::
Func_024_578B:: ; address name
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, CopyBytesDEFromHL_Bank24
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 17 x 2 tiles, one row per line
TileRect_24_5792::
Data_024_5792:: ; address name
    db $E0, $E1, $E2, $E3, $E4, $E5, $C3, $E6, $E7, $E8, $E9, $EA, $EB, $EC, $ED, $EE, $EF ; id 0
    db $F0, $F1, $F2, $F3, $F4, $F5, $C3, $F6, $F7, $F8, $F9, $FA, $FB, $FC, $FD, $FE, $FF ; id 1

; address loaded by GameMode6_Update_ObtainedEgg_CopyRectTo20ByteRowsJp_Bank24
GameMode6_Update_ObtainedEgg_CopyRectTo20ByteRowsJp_Bank24_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_024_57B4:: ; address name
    db $C3, $C3, $C3, $C3, $C3, $E0, $E1, $E2, $E3, $E4, $E5, $E6, $E7, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $C3, $C3
    db $C3, $C3

; address loaded by GameMode6_Update_ObtainedEgg_Case00_WaitForVRAMAccess
GameMode6_Update_ObtainedEgg_Case00_WaitForVRAMAccess_Data_57D6:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_024_57D6:: ; address name
    ds $1C, $07

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 17 x 2 tiles, one row per line
TileRect_24_57F2::
Data_024_57F2:: ; address name
    db $00, $01, $02, $03, $04, $05, $C3, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F ; id 0
    db $10, $11, $12, $13, $14, $15, $C3, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F ; id 1

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 14 x 13 tiles, one row per line
TileRect_24_5814::
Data_024_5814:: ; address name
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 0
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 1
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 2
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 4
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 5
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 6
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 7
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 8
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 9
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 10
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 11
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3 ; id 12

; address loaded by GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24, GameMode6_Update_SavePrompt_ReturnStub_51A3, GameMode6_Update_Case04_PageList_CopyRectTo20ByteRowsJp_Bank24, GameMode6_Update_SwitchEgg_ShowInfoOKYesN and 1 more
GameMode6_Update_CopyRectTo20ByteRowsJp_Bank24_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_024_58CA:: ; address name
    ds $78, $C3

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 20 x 5 tiles, one row per line
TileRect_24_5942::
Data_024_5942:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 20 x 5 tiles, one row per line
TileRect_24_59A6::
Data_024_59A6:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $8B, $8C, $8D, $8E, $8F, $90, $91, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F, $A0, $A1, $A2, $A3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 5 tiles, one row per line
TileRect_24_5A0A::
Data_024_5A0A:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $6D, $6E, $6F, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $70, $71, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 5 tiles, one row per line
TileRect_24_5A28::
Data_024_5A28:: ; address name
    db $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $76, $77, $78, $79, $7A, $7B, $7C, $B7 ; id 1
    db $B2, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B7, $7F, $7F, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B5, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 10 x 5 tiles, one row per line
TileRect_24_5A50::
Data_024_5A50:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $76, $77, $78, $79, $7A, $7B, $7C, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $7D, $7F, $7F, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 5 tiles, one row per line
TileRect_24_5A82::
Data_024_5A82:: ; address name
    db $B5, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $76, $77, $78, $79, $7A, $7B, $7C, $B7 ; id 1
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $7D, $7F, $7F, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; address loaded by GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor, GameMode6_Update_SavePrompt_ShowStringAInDefaultWindow_Bank24, GameMode6_Update_Case04_PageList_CopyRectTo20ByteRowsJp_Bank24, GameMode6_Update_ChooseRecordList_GameMode6_Update_ShowMonsterEg and 2 more
GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_024_5AAA:: ; address name
    db $23, $C4, $4B, $C4

; address loaded by GameMode6_Update_ChooseRecordList_StoreBAtWordTableEntry_Bank24_52CE, GameMode6_Update_Case04_PageList_UpdatePagedListCursor, GameMode6_Update_ChooseRecordList_GameMode6_Update_ShowMonsterEg, GameMode6_Update_ChooseRecordAndSave_UpdatePagedListCursor and 4 more
GameMode6_Update_ChooseRecordList_StoreBAtWordTableEntry_Bank24_52CE_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_024_5AAE:: ; address name
    db $79, $C3, $A1, $C3, $C9, $C3, $F1, $C3, $19, $C4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 11 tiles, one row per line
TileRect_24_5AB8::
Data_024_5AB8:: ; address name
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

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 13 x 9 tiles, one row per line
TileRect_24_5B10::
Data_024_5B10:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $D9, $DA, $DB, $DC, $DD, $DE, $C0, $C1, $C2, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $F5, $F6, $F7, $F8, $F9, $FA, $FB, $FC, $BF, $C3, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $C7, $C8, $C9, $CA, $CB, $EA, $EB, $EC, $ED, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 5 tiles, one row per line
TileRect_24_5B85::
Data_024_5B85:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $70, $71, $72, $73, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $74, $75, $C3, $C3, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4
    db $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F
    db $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F
    db $40, $41, $42, $43

; address loaded by GameMode6_Update_Save_TestFlagBit
GameMode6_Update_Save_TestFlagBit_Data_5BD1:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_024_5BD1:: ; address name
    db $00, $00, $01, $04, $00, $80

; address loaded by GameMode6_Update_Save_TestFlagBit
GameMode6_Update_Save_TestFlagBit_Data_5BD7:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_024_5BD7:: ; address name
    db $01, $00, $01, $01, $00, $80

; address loaded by GameMode6_Update_Save_TestFlagBit
GameMode6_Update_Save_TestFlagBit_Data_5BDD:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_024_5BDD:: ; address name
    db $0C, $00, $01, $05, $00, $81

; address loaded by GameMode6_Update_Save_TestFlagBit
GameMode6_Update_Save_TestFlagBit_Data_5BE3:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_024_5BE3:: ; address name
    db $00, $00, $00, $02, $00, $82

; address loaded by GameMode6_Update_Save_TestFlagBit
GameMode6_Update_Save_TestFlagBit_Data_5BE9:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_024_5BE9:: ; address name
    db $00, $01, $00, $00, $A0, $40, $04, $03, $00, $00, $00, $A0, $40, $04, $00, $00

; E-0264 (derived: Func_024_578B copies these 16 bytes to wSpriteSlots)
; record: 16 bytes copied to wSpriteSlots
SpriteSlotsInit_24_5BF9::
Data_024_5BF9:: ; address name
    db $00, $01, $01, $00, $A0, $40, $01, $03, $00, $00, $00, $A0, $40, $04, $00, $00 ; entry 0

; E-0264 (derived: Func_024_578B copies these 16 bytes to wObject1)
; record: 16 bytes copied to wObject1
Object1Init_24_5C09::
Data_024_5C09:: ; address name
    db $00, $01, $0C, $00, $E0, $40, $05, $01, $10, $00, $00, $E0, $40, $04, $00, $00 ; entry 0

; address loaded by GameMode6_Update_Save_TestFlagBit
GameMode6_Update_Save_TestFlagBit_Data_5C19:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_024_5C19:: ; address name
    db $00, $00, $00, $00, $D0, $40, $02, $01, $20, $00, $00, $D0, $40, $04, $00, $00

; E-0264 (derived: Func_024_578B copies these 16 bytes to wObject2)
; record: 16 bytes copied to wObject2
Object2Init_24_5C29::
Data_024_5C29:: ; address name
    db $00, $00, $00, $00, $B0, $40, $02, $03, $20, $00, $00, $B0, $40, $04, $00, $00 ; entry 0

; only called from GameMode6_Update_SavePrompt_Case08 (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Update_SavePrompt_WriteScreenStepAndTwoChoiceCursor)
; reads: wJoypadPressedRepeat, wJoypadPressed, wTwoChoiceCursor
; writes: wMenuInputResult, wTwoChoiceCursor, wScreenCounter
GameMode6_Update_SavePrompt_Case08_WriteMenuInputResultAndTwoChoiceCursorEtc::
Func_024_5C39:: ; address name
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
    xor a, a
    ld [wMenuInputResult], a
    ret

.call_game_mode6_update_save_prompt_case08:
    call GameMode6_Update_SavePrompt_Case08_Sub01_ReadTwoChoiceCursor_Sub03
    ld a, [wTwoChoiceCursor]
    and a, a
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
    cp a, $01
    jr c, .set_two_choice_cursor2
    xor a, a
    ld [wTwoChoiceCursor], a
    jr .clear_screen_counter

.set_two_choice_cursor2:
    inc a
    ld [wTwoChoiceCursor], a

.clear_screen_counter:
    xor a, a
    ld [wScreenCounter], a
    call GameMode6_Update_SavePrompt_Case08_Sub01_ReadTwoChoiceCursor
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

.call_game_mode6_update_save_prompt_case083:
    call GameMode6_Update_SavePrompt_Case08_Sub01_StepBGMapAddressBackOnScrollWrap
    ld a, $69
    call QueueSoundEffect
    ld a, $FF
    ld [wMenuInputResult], a
    ret

.set_menu_input_result_to_FE:
    ld a, $FE
    ld [wMenuInputResult], a
    ret

; only called from GameMode6_Update_SavePrompt_Case08_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Update_SavePrompt_Case08_WriteMenuInputResultAndTwoChoiceCursorEtc)
; reads: wJoypadRepeatTimer, wScreenCounter, wTwoChoiceCursor
; writes: wScreenCounter
GameMode6_Update_SavePrompt_Case08_Sub01_WriteScreenCounter::
Func_024_5CA7:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, GameMode6_Update_SavePrompt_Case08_Sub01_ReadTwoChoiceCursor
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp a, $10
    jr c, GameMode6_Update_SavePrompt_Case08_Sub01_ReadTwoChoiceCursor
    cp a, $18
    jr c, GameMode6_Update_SavePrompt_Case08_Sub01_ReadTwoChoiceCursor_Sub03
    xor a, a
    ld [wScreenCounter], a

; only called from GameMode6_Update_SavePrompt_Case08_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Update_SavePrompt_Case08_WriteMenuInputResultAndTwoChoiceCursorEtc)
; reads: wTwoChoiceCursor
GameMode6_Update_SavePrompt_Case08_Sub01_ReadTwoChoiceCursor::
Func_024_5CC1:: ; address name
    ld b, $BB
    jr GameMode6_Update_SavePrompt_Case08_Sub01_StepBGMapAddressBackOnScrollWrap_ReadTwoChoiceCursor

; only called from GameMode6_Update_SavePrompt_Case08_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. GameMode6_Update_SavePrompt_Case08_WriteMenuInputResultAndTwoChoiceCursorEtc)
; reads: wTwoChoiceCursor
GameMode6_Update_SavePrompt_Case08_Sub01_ReadTwoChoiceCursor_Sub03::
Func_024_5CC5:: ; address name
    ld b, $C3
    jr GameMode6_Update_SavePrompt_Case08_Sub01_StepBGMapAddressBackOnScrollWrap_ReadTwoChoiceCursor

; only called from GameMode6_Update_SavePrompt_Case08_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. GameMode6_Update_SavePrompt_Case08_WriteMenuInputResultAndTwoChoiceCursorEtc)
; reads: wTwoChoiceCursor
GameMode6_Update_SavePrompt_Case08_Sub01_StepBGMapAddressBackOnScrollWrap::
Func_024_5CC9:: ; address name
    ld b, $BC

GameMode6_Update_SavePrompt_Case08_Sub01_StepBGMapAddressBackOnScrollWrap_ReadTwoChoiceCursor::
Jump_024_5CCB:: ; address name
    ld a, [wTwoChoiceCursor]
    add a, a
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

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 1 call site from 1 routine (e.g. GameMode6_Update_SavePrompt_Case08_Sub01_StepBGMapAddressBackOnScrollWrap)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank24_5CEB::
Func_024_5CEB:: ; address name
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

; address loaded by GameMode6_Update_SavePrompt_Case08_Sub01_StepBGMapAddressBackOnScrollWrap
GameMode6_Update_SavePrompt_Case08_Sub01_StepBGMapAddressBackOnScrollWrap_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_024_5D0C:: ; address name
    db $2B, $01, $6B, $01

; ld de, this bank's string table / BeginStringDisplay
; 2 call sites from 2 routines (e.g. ShowString_Bank24, DebugMessageTest_Update_ToBeginStringDisplay_Bank24)
BeginStringDisplay_Bank24::
Func_024_5D10:: ; address name
    ld de, StringCategories_24_5D25
    call BeginStringDisplay
    ret
    db $11, $25, $5D, $CD, $FE, $25, $C9

; Func_024_5D10 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 1 call site from 1 routine (e.g. PriestMenu_ShowServices_ShowRviDoxUncurt)
ShowString_Bank24::
Func_024_5D1E:: ; address name
    call BeginStringDisplay_Bank24
    call RunStringDisplayToEnd
    ret

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_24_5D25::
Data_024_5D25:: ; address name
    dw StringList_24_5D27 ; id 0

; E-0217 (derived: category list of StringCategories_24_5D25; one pointer per wStringIndex)
; record: string
StringList_24_5D27::
Data_024_5D27:: ; address name
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

String_24_00_00:: ; heuristic: string; C0
Data_024_5D53:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Oh? But none", $F1
    db "appear to be dead", $A4, $FA, $F7
    db $F0

String_24_00_02:: ; heuristic: string; C0
Data_024_5D78:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Oh? But no one", $F1
    db "is poisoned.", $FA, $F7
    db $F0

String_24_00_03:: ; heuristic: string; C0
Data_024_5D99:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: But none appear", $F1
    db "to be cursed", $A4, $FA, $F7
    db $F0

String_24_00_04:: ; heuristic: string; C0
Data_024_5DBC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Do you need any", $F1
    db "other help?", $F0

String_24_00_05:: ; heuristic: string; C0
Data_024_5DDB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: May the gods go", $F1
    db "with you.", $F7
    db $F0

String_24_00_06:: ; heuristic: string; C0
Data_024_5DF9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Which monster", $F1
    db "should be revived?", $F0

String_24_00_07:: ; heuristic: string; C0
Data_024_5E1D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Who should be", $F1
    db "cured of poison?", $F0

String_24_00_08:: ; heuristic: string; C0
Data_024_5E3F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Who should be", $F1
    db "freed of a curse?", $F0

String_24_00_09:: ; heuristic: string; C0
Data_024_5E62:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Surely you jest.", $F1
    db "That one is alive.", $FA, $F7
    db $F0

String_24_00_0A:: ; heuristic: string; C0
Data_024_5E8B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: But that monster", $F1
    db "is not poisoned.", $FA, $F7
    db $F0

String_24_00_0B:: ; heuristic: string; C0
Data_024_5EB2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: But that monster", $F1
    db "is not cursed.", $FA, $F7
    db $F0

String_24_00_0C:: ; heuristic: string; C0
Data_024_5ED7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: I must ask for a", $F1
    db "small donation of", $FA, $F7
    db $EF, $EE, $F9, "0G.", $EF, $EE, "Do you accept?", $F0

String_24_00_0D:: ; heuristic: string; C0
Data_024_5F15:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Gods, the", $F1
    db "spirits of earth!", $FA, $F7
    db $EF, $EE, "Please summon the", $EF, $EE, "soul of ", $F9, "0!", $F7
    db $F0

String_24_00_0E:: ; heuristic: string; C0
Data_024_5F57:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Gods, I  beg", $F1
    db "you, purify the", $FA, $F7
    db $EF, $EE, "poison sullying", $EF, $EE, $F9, "0!", $F7
    db $F0

String_24_00_0F:: ; heuristic: string; C0
Data_024_5F90:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Gods, I beg", $F1
    db "you, free ", $F9, "0", $FA, $F7
    db $EF, $EE, "from its enslaving", $EF, $EE, "curse!", $F7
    db $F0

String_24_00_10:: ; heuristic: string; C0
Data_024_5FCB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $F9, "0 was revived!", $F7
    db $F0

String_24_00_11:: ; heuristic: string; C0
Data_024_5FDD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $F9, "0 was cleansed", $F1
    db "of poison.", $F7
    db $F0

String_24_00_12:: ; heuristic: string; C0
Data_024_5FFA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, $F9, "0 was freed", $F1
    db "from the curse.", $F7
    db $F0

String_24_00_13:: ; heuristic: string; C0
Data_024_6019:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "No one else seems", $F1
    db "to need help.", $FA, $F7
    db $EF, $EE, "Come see me again", $EF, $EE, "if you need to.", $FA, $F7
    db $EF, $EE, "The gods will be", $EF, $EE, "with you always.", $F7
    db $F0

String_24_00_14:: ; heuristic: string; C0
Data_024_6087:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EA, "*: Oh, my, my", $A4, $F1
    db "How deplorable!", $FA, $F7
    db $EF, $EE, "You haven't enough", $EF, $EE, "gold for this.", $FA, $F7
    db $F0

String_24_00_15:: ; heuristic: string; C0
Data_024_60CD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "RviD-oxUncurt", $F0

; implements script command type F8 (SCRIPT_PRIEST): the priest: 'Which monster should be revived?', curse removal (mode 11, bank $24 strings); reached through ScriptCommandF8 in bank $10 (E-0038, E-0244) (C2 from E-0330: Revive / De-Tox / Uncurse / Exit; a revival costs 25G here)
; 1 call site from 1 routine (e.g. ScriptCommandF8)
; reads: wScreenState
PriestMenu::
Func_024_60DB:: ; address name
    ld a, [wScreenState]
    rst $00
    dw PriestMenu_SwapMonstersMenu
    dw PriestMenu_ShowServices
    dw PriestMenu_PayForService

; entry 0 of the `rst $00` table in PriestMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wMessageMode
PriestMenu_SwapMonstersMenu::
Jump_024_60E5:: ; address name
    farcall SwapMonstersMenu
    ld a, $0B
    ld [wMessageMode], a
    ret

; by wScreenStep: the 'Revive / Detox / Uncurse' window and the gold panel
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
PriestMenu_ShowServices::
Jump_024_60F1:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw PriestMenu_ShowServices_ShowRviDoxUncurt
    dw PriestMenu_ShowServices_DrawGoldPanel_Bank24
    dw PriestMenu_ShowServices_BGMapAddressAtScroll_Bank24_6866

; entry 0 of the `rst $00` table in PriestMenu_ShowServices
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wStringCategory, wStringIndex, wScreenStep
; points at: wTextWindowTileLo
PriestMenu_ShowServices_ShowRviDoxUncurt::
Jump_024_60FB:: ; address name
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $8F
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $0E
    xor a, a
    ld [wStringCategory], a
    ld a, $15
    ld [wStringIndex], a ; 'RviD-oxUncurt'
    farcall ShowString_Bank24
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in PriestMenu_ShowServices
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
PriestMenu_ShowServices_DrawGoldPanel_Bank24::
Jump_024_612C:: ; address name
    ld de, TileRect_24_6B8B
    ld hl, wWindowTileBuffer + $64
    ld bc, $0A09
    call CopyRectTo20ByteRows_Bank24
    call DrawGoldPanel_Bank24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in PriestMenu_ShowServices
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
; writes: wScreenStep, wScreenState
PriestMenu_ShowServices_BGMapAddressAtScroll_Bank24_6866::
Jump_024_6143:: ; address name
    call BGMapAddressAtScroll_Bank24_6866
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRectNoOrigin_Bank24
    xor a, a
    ld [wScreenStep], a
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    ret

; PriestMenu screen state 2, by wScreenStep: picks a party member, shows the gold panel, confirms with two choices and SubtractArg1AmountFromGold
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
PriestMenu_PayForService::
Jump_024_615B:: ; address name
    ld a, [wScreenStep]
    rst $00
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

; entry 0 of the `rst $00` table in PriestMenu_PayForService
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wListCursor, wScreenStep
; writes: wMenuInputResult, wListCount, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wScreenStep, wChoiceCursor
PriestMenu_PayForService_UpdateListCursorListCursor::
Jump_024_6183:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    ld a, $04
    ld [wListCount], a
    farcall UpdateListCursorListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, .set_two_choice_cursor_to_04
    cp a, $FF
    jr z, .check_list_cursor
    ret

.set_two_choice_cursor_to_04:
    ld a, $04

.set_two_choice_cursor:
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_list_cursor:
    ld a, [wListCursor]
    and a, a
    jr z, .call_priest_menu_pay_for_service_load_sram
    cp a, $01
    jr z, .call_priest_menu_pay_for_service_load_sram2
    cp a, $02
    jr z, .call_priest_menu_pay_for_service_load_sram3
    jr .set_two_choice_cursor_to_04

.call_priest_menu_pay_for_service_load_sram:
    ld b, $80
    call PriestMenu_PayForService_LoadSRAMRecordByte_Shared01
    cp a, $FF
    jr z, .clear_two_choice_cursor
    ld a, $01
    jr .set_two_choice_cursor

.call_priest_menu_pay_for_service_load_sram2:
    ld b, $04
    call PriestMenu_PayForService_LoadSRAMRecordByte_Shared01
    cp a, $FF
    jr z, .clear_two_choice_cursor
    ld a, $02
    jr .set_two_choice_cursor

.call_priest_menu_pay_for_service_load_sram3:
    ld b, $01
    call PriestMenu_PayForService_LoadSRAMRecordByte_Shared01
    cp a, $FF
    jr z, .clear_two_choice_cursor
    ld a, $03
    jr .set_two_choice_cursor

.clear_two_choice_cursor:
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, [wListCursor]
    ld b, $BC
    ld hl, PriestMenu_PayForService_UpdateListCursorListCursor_Data
    call StoreBAtWordTableEntry_Bank24
    xor a, a
    ld [wChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in PriestMenu_PayForService
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep
; writes: wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest
PriestMenu_PayForService_CopyTileBytesToVRAM_Bank24::
Jump_024_620A:: ; address name
    ld a, [wListCursor]
    ld [wTwoChoiceCursor], a
    ld hl, Tiles_24_6239
    ld de, vTiles1 + $7E0
    call CopyTileBytesToVRAM_Bank24
    ld hl, Tiles_24_6249
    call CopyTileBytesToVRAM_Bank24
    ld hl, Tiles_24_6259
    ld de, vTiles1 + $6F0
    call CopyTileBytesToVRAM_Bank24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; E-0238 (derived: HL = $6239 and 1 calls to a 16-byte VRAM copier (CopyTileBytesToVRAM_*), one tile each)
; record: tile (16 bytes, 2 bits per pixel)
Tiles_24_6239::
Data_024_6239:: ; address name
    db $FF, $06, $FF, $06, $FF, $06, $FF, $FF, $FF, $FF, $FF, $00, $FF, $00, $FF, $00 ; entry 0

; E-0238 (derived: HL = $6249 and 1 calls to a 16-byte VRAM copier (CopyTileBytesToVRAM_*), one tile each)
; record: tile (16 bytes, 2 bits per pixel)
Tiles_24_6249::
Data_024_6249:: ; address name
    db $FF, $00, $FF, $00, $FF, $00, $FF, $F8, $FF, $FC, $FF, $0E, $FF, $06, $FF, $06 ; entry 0

; E-0238 (derived: HL = $6259 and 1 calls to a 16-byte VRAM copier (CopyTileBytesToVRAM_*), one tile each)
; record: tile (16 bytes, 2 bits per pixel)
Tiles_24_6259::
Data_024_6259:: ; address name
    db $FF, $60, $FF, $60, $FF, $60, $FF, $1F, $FF, $3F, $FF, $70, $FF, $60, $FF, $60 ; entry 0

; entry 2 of the `rst $00` table in PriestMenu_PayForService
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
PriestMenu_PayForService_CopyRectTo20ByteRows_Bank24::
Jump_024_6269:: ; address name
    ld de, TileRect_24_6C49
    ld hl, wWindowTileBuffer + $DC
    ld bc, $0B07
    call CopyRectTo20ByteRows_Bank24
    call PriestMenu_PayForService_Case02_PriestMenu_PayForService_WriteMarkC0
    call BGMapAddressAtScroll_Bank24_6866
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectNoOrigin_Bank24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in PriestMenu_PayForService
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wScreenStep
; writes: wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
PriestMenu_PayForService_WriteScreenStepAndTwoChoiceCursorEtc::
Jump_024_628C:: ; address name
    call PriestMenu_PayForService_Case03_WriteMenuInputResultAndChoiceCursorEtc
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, .check_screen_step
    cp a, $FF
    jr z, .read_screen_step
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.read_screen_step:
    ld a, [wScreenStep]
    add a, $02
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 4 of the `rst $00` table in PriestMenu_PayForService
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor
; writes: wArg1, wArg2, wScreenStep, wScriptCommandType, wScriptStartRequest
PriestMenu_PayForService_DrawGoldPanel_Bank24::
Jump_024_62C9:: ; address name
    ld b, $00
    ld c, $07
    ld hl, $0244
    ld de, $0078
    xor a, a
    ld [wArg1], a
    ld a, $0B
    ld [wArg2], a
    call PriestMenu_PayForService_Case04_CopyBytesDEToHL_Bank24
    ld de, TileRect_24_6B8B
    ld hl, wWindowTileBuffer + $64
    ld bc, $0A09
    call CopyRectTo20ByteRows_Bank24
    call DrawGoldPanel_Bank24
    ld a, [wListCursor]
    ld b, $BB
    ld hl, PriestMenu_PayForService_UpdateListCursorListCursor_Data
    call StoreBAtWordTableEntry_Bank24
    call BGMapAddressAtScroll_Bank24_6866
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectNoOrigin_Bank24
    ld a, [wListCursor]
    ld b, $C3
    ld hl, PriestMenu_PayForService_UpdateListCursorListCursor_Data
    call StoreBAtWordTableEntry_Bank24
    xor a, a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 5 of the `rst $00` table in PriestMenu_PayForService
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wChoiceCursor, hTemp0, wScreenStep
; writes: rRAMG, rRAMB, wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wPartyList
PriestMenu_PayForService_LoadSRAMRecordByte::
Jump_024_631E:: ; address name
    ld a, [wListCursor]
    and a, a
    jr z, .skip
    cp a, $01
    jr z, .skip2
    ld b, $01
    jr .skip3

.skip:
    ld b, $80
    jr .skip3

.skip2:
    ld b, $04

.skip3:
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wChoiceCursor]
    ld hl, wPartyList
    add_a_to_hl
    ld a, [hl]
    ld c, MON_STATUS
    push bc
    call LoadSRAMRecordByte
    pop bc
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ldh a, [hTemp0]
    and a, b
    and a, a
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
    xor a, a

.set_two_choice_cursor:
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 6 of the `rst $00` table in PriestMenu_PayForService
; no direct call (reached through a table, a jump or a vector)
; reads: wListCursor, wScreenStep, wChoiceCursor, hTemp0
; writes: wListEntries, wGrid2CursorX, wGrid2CursorY, wTextBuf0, wScreenStep, wScriptCommandType, wScriptStartRequest, rRAMG, ...
; points at: wPartyList, wArg4, wTextBuf0
PriestMenu_PayForService_WriteListEntriesAndGrid2CursorXEtc::
Jump_024_637B:: ; address name
    ld a, [wListCursor]
    and a, a
    jr z, .skip
    cp a, $01
    jr z, .set_list_entries_to_03
    ld a, $14
    ld [wListEntries], a
    xor a, a
    ld [wGrid2CursorX], a
    ld [wGrid2CursorY], a
    ld a, $02
    ld [wTextBuf0], a
    ld a, $00
    ld [wTextBuf0 + $1], a
    ld a, $F0
    ld [wTextBuf0 + $2], a
    jr .check_screen_step

.set_list_entries_to_03:
    ld a, $03
    ld [wListEntries], a
    xor a, a
    ld [wGrid2CursorX], a
    ld [wGrid2CursorY], a
    ld a, $03
    ld [wTextBuf0], a
    ld a, $F0
    ld [wTextBuf0 + $1], a

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.skip:
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wChoiceCursor]
    ld hl, wPartyList
    add_a_to_hl
    ld a, [hl]
    ld c, MON_LEVEL
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ldh a, [hTemp0]
    ld c, $0A
    call Multiply8
    ld a, $0A
    add_a_to_hl
    srl h
    rr l
    ld a, l
    ld [wListEntries], a
    ld [wDigits], a
    ld a, h
    ld [wGrid2CursorX], a
    ld [wDigits + $1], a
    xor a, a
    ld [wGrid2CursorY], a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    farcall UnpackBCDToDigitsArg1
    ld hl, wArg4
    ld de, wTextBuf0
    ld b, $04

.loop:
    ld a, [hl]
    cp a, $E3
    jr nz, .loop2
    inc hl
    dec b
    jr nz, .loop

.loop2:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    ld a, $F0
    ld [de], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 7 of the `rst $00` table in PriestMenu_PayForService
; no direct call (reached through a table, a jump or a vector)
; reads: wChoiceCursor, wScreenStep
; writes: wScreenStep, wTwoChoiceCursor
PriestMenu_PayForService_QueueSoundEffect::
Jump_024_6445:: ; address name
    ld a, $6C
    call QueueSoundEffect
    ld de, TileRect_24_6479
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank24
    ld a, [wChoiceCursor]
    ld b, $BC
    ld hl, PriestMenu_PayForService_QueueSoundEffect_Data
    call StoreBAtWordTableEntry_Bank24
    call BGMapAddressAtScroll_Bank24_6866
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectNoOrigin_Bank24
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 5 tiles, one row per line
TileRect_24_6479::
Data_024_6479:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $CE, $CF, $DF, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $A5, $F5, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B5 ; id 4

; entry 8 of the `rst $00` table in PriestMenu_PayForService
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wGrid2CursorY, wGrid2CursorX, wListEntries, wArg1, wScreenStep
; writes: wArg3, wArg2, wArg1, wTwoChoiceCursor, wScreenStep, wScreenSubStep, wScriptCommandType, wScriptStartRequest
PriestMenu_PayForService_UpdateTwoChoiceCursor_Bank1D::
Jump_024_6497:: ; address name
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, .loop
    cp a, $FF
    jr z, .check_two_choice_cursor
    ret

.loop:
    call PriestMenu_PayForService_BGMapAddressAtScroll_Bank24_6866
    xor a, a
    ld [wScreenSubStep], a
    ld a, $02

.set_two_choice_cursor:
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_two_choice_cursor:
    ld a, [wTwoChoiceCursor]
    and a, a
    jr nz, .loop
    ld a, [wGrid2CursorY]
    ld [wArg3], a
    ld a, [wGrid2CursorX]
    ld [wArg2], a
    ld a, [wListEntries]
    ld [wArg1], a
    farcall IsAmountInArg1AboveGold
    ld a, [wArg1]
    cp a, $FF
    jr z, .set_screen_sub_step_to_01
    call PriestMenu_PayForService_BGMapAddressAtScroll_Bank24_6866
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    add a, $02
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_screen_sub_step_to_01:
    ld a, $01
    ld [wScreenSubStep], a
    ld a, $01
    jr .set_two_choice_cursor

; entry 9 of the `rst $00` table in PriestMenu_PayForService
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest, wScreenSubStep
PriestMenu_PayForService_WriteScreenStepAndScriptCommandTypeEtc::
Jump_024_6513:: ; address name
    call PriestMenu_PayForService_BGMapAddressAtScroll_Bank24_6866
    ld a, [wScreenSubStep]
    and a, a
    jr nz, .set_screen_step_to_04
    ld a, $01
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_screen_step_to_04:
    ld a, $04
    ld [wScreenStep], a
    xor a, a
    ld [wScreenSubStep], a
    ret

; entry 10 of the `rst $00` table in PriestMenu_PayForService
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, wScreenStep, wListCursor, wGrid2CursorX, wListEntries
; writes: wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wScreenSubStep, wArg3, wArg2, wArg1
PriestMenu_PayForService_SubtractArg1AmountFromGold::
Jump_024_6535:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jr z, .clear_arg3
    cp a, $01
    jr z, .check_list_cursor
    jr .check_screen_step

.clear_arg3:
    xor a, a
    ld [wArg3], a
    ld a, [wGrid2CursorX]
    ld [wArg2], a
    ld a, [wListEntries]
    ld [wArg1], a
    farcall SubtractArg1AmountFromGold
    call DrawGoldPanel_Bank24
    call BGMapAddressAtScroll_Bank24_6866
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectNoOrigin_Bank24
    call PriestMenu_PayForService_CopyRecordNameToNameGlyphBuf
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.check_list_cursor:
    ld a, [wListCursor]
    and a, a
    jr z, .clear_screen_sub_step
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.clear_screen_sub_step:
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, [wListCursor]
    ld [wTwoChoiceCursor], a
    xor a, a
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
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 11 of the `rst $00` table in PriestMenu_PayForService
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep, wIsCGB, wScreenStep, wScreenCounter, wGlyphListPos
; writes: hSpriteWindowClipMode, wScreenSubStep, wScreenStep, wScreenCounter, wGlyphListPos
; points at: wScreenTileBuffer, wWindowTileBuffer, wScreenAttrBuffer, wWindowAttrBuffer
PriestMenu_PayForService_QueueMusic::
Jump_024_65B1:: ; address name
    ld a, [wScreenSubStep]
    and a, a
    jr z, .call_queue_music
    cp a, $01
    jr z, .read_screen_counter
    jr .skip

.call_queue_music:
    ld a, $3D
    call QueueMusic
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

.read_screen_counter:
    ld a, [wScreenCounter]
    add a, $01
    ld [wScreenCounter], a
    ld a, [wGlyphListPos]
    adc a, $00
    ld [wGlyphListPos], a
    ld a, [wGlyphListPos]
    and a, a
    ret z
    ld a, [wScreenCounter]
    cp a, $28
    ret c
    xor a, a
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
    and a, a
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
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectNoOrigin_Bank24
    call BGMapAddressAtScroll_Bank24_6866
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRectNoOrigin_Bank24
    xor a, a
    ldh [hSpriteWindowClipMode], a
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 15 of the `rst $00` table in PriestMenu_PayForService
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: hSpriteWindowClipMode, wScreenStep
; points at: wTextWindowTileLo, wWindowTileBuffer
PriestMenu_PayForService_FillTilesFromRequest::
Jump_024_6655:: ; address name
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    call FillTilesFromRequest
    ld de, TileRect_24_6BE5
    ld hl, wWindowTileBuffer
    ld bc, $1405
    call CopyRectTo20ByteRows_Bank24
    call BGMapAddressAtScroll_Bank24_6866
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRectNoOrigin_Bank24
    ld a, $02
    ldh [hSpriteWindowClipMode], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 12 of the `rst $00` table in PriestMenu_PayForService; also entry 14 of the table in PriestMenu_PayForService
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenCounter, wScreenStep
; writes: wScreenCounter, wScreenStep
; points at: wScreenCounter
PriestMenu_PayForService_WriteScreenCounterAndScreenStep::
Jump_024_668D:: ; address name
    ld hl, wScreenCounter
    inc [hl]
    ld a, [wScreenCounter]
    cp a, $1C
    ret c
    xor a, a
    ld [wScreenCounter], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; two CopyBytes steps
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
PriestMenu_PayForService_CopyBuffers::
Jump_024_66A3:: ; address name
    ld a, [wScreenSubStep]
    rst $00
    dw PriestMenu_PayForService_CopyBuffers_CopyBytes
    dw PriestMenu_PayForService_CopyBuffers_CopyBytes_Case01

; entry 0 of the `rst $00` table in PriestMenu_PayForService_CopyBuffers
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wScreenSubStep
; writes: wScreenSubStep
; points at: wBGPaletteBuffer, wBGPaletteCopy
PriestMenu_PayForService_CopyBuffers_CopyBytes::
Jump_024_66AB:: ; address name
    ld a, [wIsCGB]
    or a, a
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

; entry 1 of the `rst $00` table in PriestMenu_PayForService_CopyBuffers
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenCounter, wIsCGB, wScreenStep, wListCursor
; writes: wBGPaletteUploadRequest, wScreenCounter, wScreenSubStep, wScreenStep
; points at: wDMGPaletteBGP, wBGPaletteCopy, wBGPaletteBuffer
PriestMenu_PayForService_CopyBuffers_CopyBytes_Case01::
Jump_024_66C5:: ; address name
    ld a, [wScreenCounter]
    sra a
    sra a
    and a, $01
    jr z, .skip
    ld hl, wDMGPaletteBGP
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, .check_screen_counter
    ld hl, wBGPaletteCopy
    ld de, wBGPaletteBuffer
    ld bc, $0040
    call CopyBytes
    jr .set_bg_palette_upload_request_to_7F

.skip:
    ld hl, wDMGPaletteBGP
    ld a, $2D
    ld [hl+], a
    ld a, $2D
    ld [hl+], a
    ld a, $1D
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, .check_screen_counter
    ld b, $40
    ld hl, wBGPaletteCopy
    ld de, wBGPaletteBuffer

.loop:
    ld a, [hl+]
    xor a, $FF
    ld [de], a
    inc de
    dec b
    jr nz, .loop

.set_bg_palette_upload_request_to_7F:
    ld a, $7F
    ld [wBGPaletteUploadRequest], a

.check_screen_counter:
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp a, $1E
    ret c
    xor a, a
    ld [wScreenCounter], a
    xor a, a
    ld [wScreenSubStep], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, [wListCursor]
    and a, a
    ret nz
    farcall RestartMapMusic
    ret

; entry 16 of the `rst $00` table in PriestMenu_PayForService
; no direct call (reached through a table, a jump or a vector)
; reads: wChoiceCursor, wListCursor, wScreenStep
; writes: rRAMG, rRAMB, wScreenStep, wOBJPaletteUploadRequest, wScriptCommandType, wScriptStartRequest
; points at: wPartyList
PriestMenu_PayForService_SRAMRecordAddress::
Jump_024_673C:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
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
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld b, a
    ld a, [hl]
    and a, b
    ld [hl], a
    pop hl
    ld a, [wListCursor]
    and a, a
    jr nz, .skip2
    ld a, [hl]
    ld c, MON_MAX_HP
    call SRAMRecordAddress
    ld a, [hl+]
    ld e, a
    ld a, [hl-]
    ld d, a
    dec hl
    dec hl
    ld a, e
    ld [hl+], a
    ld [hl], d
    inc hl
    ld a, $04
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl-]
    ld d, a
    dec hl
    dec hl
    ld a, e
    ld [hl+], a
    ld [hl], d
    farcall RunMoveIncapacitatedPartyMembersBackTwice
    call LoadRecordListNameTiles

.skip2:
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    call PriestMenu_PayForService_CopyRecordNameToNameGlyphBuf
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; address loaded by PriestMenu_PayForService_SRAMRecordAddress
PriestMenu_PayForService_SRAMRecordAddress_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_024_67BD:: ; address name
    db $00, $FB, $FE

; entry 17 of the `rst $00` table in PriestMenu_PayForService
; no direct call (reached through a table, a jump or a vector)
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wScreenStep
PriestMenu_PayForService_WriteTwoChoiceCursorAndScriptCommandTypeEtc::
Jump_024_67C0:: ; address name
    ld b, $80
    call PriestMenu_PayForService_LoadSRAMRecordByte_Shared01
    cp a, $FF
    jr z, .clear_two_choice_cursor
    ld b, $04
    call PriestMenu_PayForService_LoadSRAMRecordByte_Shared01
    cp a, $FF
    jr z, .clear_two_choice_cursor
    ld b, $01
    call PriestMenu_PayForService_LoadSRAMRecordByte_Shared01
    cp a, $FF
    jr z, .clear_two_choice_cursor
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.clear_two_choice_cursor:
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, $04
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the same 58 bytes appear in 8 banks)
; 6 call sites from 6 routines (e.g. PriestMenu_ShowServices_DrawGoldPanel_Bank24, DrawGoldPanel_Bank24, PriestMenu_PayForService_FillTilesFromRequest, PriestMenu_PayForService_QueueSoundEffect, ...)
; reads: wIsCGB
; writes: rSVBK
CopyRectTo20ByteRows_Bank24::
Func_024_67FD:: ; address name
    push hl
    push bc

.loop:
    push bc
    push hl

.loop2:
    ld a, [de]
    inc de
    ld [hl+], a
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
    and a, a
    ret z
    ld a, l
    add a, $68
    ld l, a
    ld a, h
    adc a, $0E
    ld h, a
    ld a, $02
    ldh [rSVBK], a

.loop3:
    push bc
    push hl

.loop4:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop4
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, .loop3
    xor a, a
    ldh [rSVBK], a
    ret

; DE = offset into wScreenTileBuffer, B = width, C = rows, HL = BG map address: CopyRectToBGMapWrapped from wScreenTileBuffer + DE; on CGB the same rectangle is then copied from wScreenAttrBuffer + DE (rSVBK = 2) into VRAM bank 1, the attributes; on DMG BC, DE and HL are kept. wTextCursorLo/wTextCursorHi are not written (E-0062)
; 9 call sites from 8 routines (e.g. PriestMenu_ShowServices_BGMapAddressAtScroll_Bank24_6866, PriestMenu_PayForService_FillTilesFromRequest, PriestMenu_PayForService_QueueMusic, PriestMenu_PayForService_SubtractArg1AmountFromGold, ...)
; reads: wIsCGB
; writes: rVBK, rSVBK
; points at: wScreenTileBuffer, wScreenAttrBuffer
DrawScreenBufferRectNoOrigin_Bank24::
Func_024_6837:: ; address name
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
    and a, a
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
    xor a, a
    ldh [rSVBK], a
    ldh [rVBK], a
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 10 call sites from 9 routines (e.g. PriestMenu_ShowServices_BGMapAddressAtScroll_Bank24_6866, PriestMenu_PayForService_FillTilesFromRequest, PriestMenu_PayForService_QueueMusic, PriestMenu_PayForService_SubtractArg1AmountFromGold, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank24_6866::
Func_024_6866:: ; address name
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
; 4 call sites from 3 routines (e.g. PriestMenu_PayForService_QueueMusic, PriestMenu_PayForService_Shared02_CopyBytesDEToHL_Bank24, PriestMenu_PayForService_Case04_CopyBytesDEToHL_Bank24)
CopyBytesDEToHL_Bank24::
Func_024_6887:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, CopyBytesDEToHL_Bank24
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same 18 bytes appear in 7 banks)
; 3 call sites from 2 routines (e.g. PriestMenu_PayForService_QueueMusic, PriestMenu_PayForService_Case04_CopyBytesDEToHL_Bank24)
; writes: rSVBK
CopyLow3BitsToWRAMBank2_Bank24::
Func_024_6890:: ; address name
    ld a, $02
    ldh [rSVBK], a

.loop:
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    xor a, a
    ldh [rSVBK], a
    ret

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers A, DE, HL (the same 14 bytes appear in 8 banks)
; 4 call sites from 3 routines (e.g. PriestMenu_PayForService_QueueSoundEffect, PriestMenu_PayForService_DrawGoldPanel_Bank24, PriestMenu_PayForService_UpdateListCursorListCursor)
StoreBAtWordTableEntry_Bank24::
Func_024_68A2:: ; address name
    push bc
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop bc
    ld a, b
    ld [de], a
    ret

; copies an 8 x 3 frame (Data_024_68EB) into the screen buffer at wWindowTileBuffer + $70, converts wGold to packed BCD (Number24ToPackedBCD) and Func_015_6676, then writes the digits as tiles $E0 + d at wWindowTileBuffer + $86 (E-0074)
; 3 call sites from 3 routines (e.g. PriestMenu_ShowServices_DrawGoldPanel_Bank24, PriestMenu_PayForService_SubtractArg1AmountFromGold, PriestMenu_PayForService_DrawGoldPanel_Bank24)
; reads: wGoldLo, wGoldMid, wGoldHi
; writes: wDigits
; points at: wArg3
DrawGoldPanel_Bank24::
Func_024_68B0:: ; address name
    ld de, TileRect_24_68EB
    ld hl, wWindowTileBuffer + $70
    ld bc, $0803
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
    add a, $E0
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $05
    jr c, .loop
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 3 tiles, one row per line
TileRect_24_68EB::
Data_024_68EB:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $BF, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 2

; only called from routines of PriestMenu_PayForService (E-0098)
; 6 call sites from 2 routines (e.g. PriestMenu_PayForService_WriteTwoChoiceCursorAndScriptCommandTypeEtc, PriestMenu_PayForService_UpdateListCursorListCursor)
; reads: wPartyCount, hTemp0
; writes: rRAMG, rRAMB
; points at: wPartyList
PriestMenu_PayForService_LoadSRAMRecordByte_Shared01::
Func_024_6903:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
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
    and a, b
    and a, a
    jr nz, .restore
    pop bc
    pop hl
    pop de
    inc hl
    inc e
    ld a, e
    cp a, c
    jr c, .loop
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

.restore:
    pop bc
    pop hl
    pop de
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ld a, $FF
    ret

; only called from PriestMenu_PayForService_Case02 (E-0047)
; 1 call site from 1 routine (e.g. PriestMenu_PayForService_CopyRectTo20ByteRows_Bank24)
; reads: wPartyCount, hTemp0
; writes: rRAMG, rRAMB
; points at: wPartyList
PriestMenu_PayForService_Case02_PriestMenu_PayForService_WriteMarkC0::
Func_024_6944:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
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
    cp a, c
    jr c, .loop
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ret

; writes tile $C0 at the table address for entry E
; 1 call site from 1 routine (e.g. PriestMenu_PayForService_Case02_PriestMenu_PayForService_WriteMarkC0)
PriestMenu_PayForService_WriteMarkC0::
Func_024_6987:: ; address name
    push de
    ld a, e
    add a, a
    ld hl, PriestMenu_PayForService_WriteMarkC0_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, $C0
    ld [de], a
    pop de
    ret

; writes tile $C1 at the table address for entry E
; 1 call site from 1 routine (e.g. PriestMenu_PayForService_Case02_PriestMenu_PayForService_WriteMarkC0)
PriestMenu_PayForService_WriteMarkC1::
Func_024_699A:: ; address name
    push de
    ld a, e
    add a, a
    ld hl, PriestMenu_PayForService_WriteMarkC1_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, $C1
    ld [de], a
    pop de
    ret

; writes tile $C2 at the table address for entry E
; 1 call site from 1 routine (e.g. PriestMenu_PayForService_Case02_PriestMenu_PayForService_WriteMarkC0)
PriestMenu_PayForService_WriteMarkC2::
Func_024_69AD:: ; address name
    push de
    ld a, e
    add a, a
    ld hl, PriestMenu_PayForService_WriteMarkC2_Data
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, $C2
    ld [de], a
    pop de
    ret

; address loaded by PriestMenu_PayForService_WriteMarkC0
PriestMenu_PayForService_WriteMarkC0_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_024_69C0:: ; address name
    db $F7, $C3, $1F, $C4, $47, $C4

; address loaded by PriestMenu_PayForService_WriteMarkC1
PriestMenu_PayForService_WriteMarkC1_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_024_69C6:: ; address name
    db $F8, $C3, $20, $C4, $48, $C4

; address loaded by PriestMenu_PayForService_WriteMarkC2
PriestMenu_PayForService_WriteMarkC2_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_024_69CC:: ; address name
    db $F9, $C3, $21, $C4, $49, $C4

; only called from PriestMenu_PayForService_Case03 (E-0047)
; 1 call site from 1 routine (e.g. PriestMenu_PayForService_WriteScreenStepAndTwoChoiceCursorEtc)
; reads: wJoypadPressedRepeat, wJoypadPressed, wPartyCount, wChoiceCursor
; writes: wMenuInputResult, wChoiceCursor, wCursorBlinkAE
PriestMenu_PayForService_Case03_WriteMenuInputResultAndChoiceCursorEtc::
Func_024_69D2:: ; address name
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
    xor a, a
    ld [wMenuInputResult], a
    ret

.call_priest_menu_pay_for_service_case03_sub01:
    call PriestMenu_PayForService_Case03_Sub01_ReadChoiceCursor_Sub03
    ld a, [wChoiceCursor]
    and a, a
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
    cp a, b
    jr c, .set_choice_cursor2
    xor a, a
    ld [wChoiceCursor], a
    jr .clear_cursor_blink_ae

.set_choice_cursor2:
    inc a
    ld [wChoiceCursor], a

.clear_cursor_blink_ae:
    xor a, a
    ld [wCursorBlinkAE], a
    call PriestMenu_PayForService_Case03_Sub01_ReadChoiceCursor
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call PriestMenu_PayForService_Case03_Sub01_StepBGMapAddressBackOnScrollWrap
    ld a, $FF
    ld [wMenuInputResult], a
    ret

.set_menu_input_result_to_FE:
    ld a, $FE
    ld [wMenuInputResult], a
    ret

; only called from PriestMenu_PayForService_Case03_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. PriestMenu_PayForService_Case03_WriteMenuInputResultAndChoiceCursorEtc)
; reads: wJoypadRepeatTimer, wCursorBlinkAE, wChoiceCursor
; writes: wCursorBlinkAE
PriestMenu_PayForService_Case03_Sub01_WriteCursorBlinkAE::
Func_024_6A46:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, PriestMenu_PayForService_Case03_Sub01_ReadChoiceCursor
    ld a, [wCursorBlinkAE]
    inc a
    ld [wCursorBlinkAE], a
    cp a, $10
    jr c, PriestMenu_PayForService_Case03_Sub01_ReadChoiceCursor
    cp a, $18
    jr c, PriestMenu_PayForService_Case03_Sub01_ReadChoiceCursor_Sub03
    xor a, a
    ld [wCursorBlinkAE], a

; only called from PriestMenu_PayForService_Case03_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. PriestMenu_PayForService_Case03_WriteMenuInputResultAndChoiceCursorEtc)
; reads: wChoiceCursor
PriestMenu_PayForService_Case03_Sub01_ReadChoiceCursor::
Func_024_6A60:: ; address name
    ld b, $BB
    jr PriestMenu_PayForService_Case03_Sub01_StepBGMapAddressBackOnScrollWrap_ReadChoiceCursor

; only called from PriestMenu_PayForService_Case03_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. PriestMenu_PayForService_Case03_WriteMenuInputResultAndChoiceCursorEtc)
; reads: wChoiceCursor
PriestMenu_PayForService_Case03_Sub01_ReadChoiceCursor_Sub03::
Func_024_6A64:: ; address name
    ld b, $C3
    jr PriestMenu_PayForService_Case03_Sub01_StepBGMapAddressBackOnScrollWrap_ReadChoiceCursor

; only called from PriestMenu_PayForService_Case03_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. PriestMenu_PayForService_Case03_WriteMenuInputResultAndChoiceCursorEtc)
; reads: wChoiceCursor
PriestMenu_PayForService_Case03_Sub01_StepBGMapAddressBackOnScrollWrap::
Func_024_6A68:: ; address name
    ld b, $BC

PriestMenu_PayForService_Case03_Sub01_StepBGMapAddressBackOnScrollWrap_ReadChoiceCursor::
Jump_024_6A6A:: ; address name
    ld a, [wChoiceCursor]
    add a, a
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

; address loaded by PriestMenu_PayForService_Case03_Sub01_StepBGMapAddressBackOnScrollWrap
PriestMenu_PayForService_Case03_Sub01_StepBGMapAddressBackOnScrollWrap_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_024_6A8A:: ; address name
    db $E1, $00, $21, $01, $61, $01

; only called from PriestMenu_PayForService_Case04 (E-0047)
; 1 call site from 1 routine (e.g. PriestMenu_PayForService_DrawGoldPanel_Bank24)
; reads: wArg1, wArg2, wIsCGB
; points at: wScreenTileBuffer, wScreenAttrBuffer
PriestMenu_PayForService_Case04_CopyBytesDEToHL_Bank24::
Func_024_6A90:: ; address name
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
    and a, a
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
    add a, e
    ld e, a
    jr nc, .next
    inc d

.next:
    dec c
    jr nz, PriestMenu_PayForService_Case04_CopyBytesDEToHL_Bank24
    ret

; only called from routines of PriestMenu_PayForService (E-0098)
; 3 call sites from 2 routines (e.g. PriestMenu_PayForService_WriteScreenStepAndScriptCommandTypeEtc, PriestMenu_PayForService_UpdateTwoChoiceCursor_Bank1D)
; reads: wIsCGB, rSVBK
; writes: rSVBK
PriestMenu_PayForService_BGMapAddressAtScroll_Bank24_6866::
Func_024_6AE4:: ; address name
    ld hl, wWindowTileBuffer + $112
    ld de, wScreenTileBuffer + $AE
    ld c, $00
    call PriestMenu_PayForService_Shared02_CopyBytesDEToHL_Bank24
    ld a, [wIsCGB]
    and a, a
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
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectNoOrigin_Bank24
    ret

; only called from PriestMenu_PayForService_Shared02 (E-0047)
; 2 call sites from 1 routine (e.g. PriestMenu_PayForService_BGMapAddressAtScroll_Bank24_6866)
PriestMenu_PayForService_Shared02_CopyBytesDEToHL_Bank24::
Func_024_6B19:: ; address name
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
    add a, e
    ld e, a
    jr nc, .next
    inc d

.next:
    inc c
    ld a, c
    cp a, $05
    jr c, PriestMenu_PayForService_Shared02_CopyBytesDEToHL_Bank24
    ret

; only called from routines of PriestMenu_PayForService (E-0098)
; 2 call sites from 2 routines (e.g. PriestMenu_PayForService_SRAMRecordAddress, PriestMenu_PayForService_SubtractArg1AmountFromGold)
; reads: wChoiceCursor
; writes: rRAMG, rRAMB, wNameGlyphBuf
; points at: wPartyList, wNameGlyphBuf, wTextBuf0
PriestMenu_PayForService_CopyRecordNameToNameGlyphBuf::
Func_024_6B3A:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wChoiceCursor]
    ld hl, wPartyList
    add_a_to_hl
    ld a, [hl]
    ld c, MON_NAME
    call CopyRecordNameToNameGlyphBuf
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
    ld c, $00

.loop:
    ld a, [hl]
    cp a, $F0
    jr z, .done
    ld [de], a
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $0A
    jr c, .loop

.done:
    ld a, $F0
    ld [de], a
    ret

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (the same 17 bytes appear in 7 banks)
; 3 call sites from 1 routine (e.g. PriestMenu_PayForService_CopyTileBytesToVRAM_Bank24)
; reads: rSTAT
CopyTileBytesToVRAM_Bank24::
Func_024_6B7A:: ; address name
    ld c, $10

.loop:
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    dec c
    jr nz, .loop
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 10 x 9 tiles, one row per line
TileRect_24_6B8B::
Data_024_6B8B:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $F0, $CF, $F1, $F2, $F1, $CF, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $F3, $CF, $F4, $A8, $F5, $F6, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $F7, $F8, $F9, $FA, $FB, $DF, $CF, $B7 ; id 5
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 6
    db $B6, $C3, $A9, $F6, $F2, $FC, $C3, $C3, $C3, $B7 ; id 7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 8

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 20 x 5 tiles, one row per line
TileRect_24_6BE5::
Data_024_6BE5:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $8B, $8C, $8D, $8E, $8F, $90, $91, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F, $A0, $A1, $A2, $A3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 11 x 7 tiles, one row per line
TileRect_24_6C49::
Data_024_6C49:: ; address name
    db $EF, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $FE, $FF ; id 0
    db $B6, $C3, $D0, $D1, $D2, $D3, $D4, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $D5, $D6, $D7, $D8, $D9, $C3, $C3, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $DA, $DB, $DC, $DD, $DE, $C3, $C3, $C3, $B7 ; id 5
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 6

; address loaded by PriestMenu_PayForService_UpdateListCursorListCursor, PriestMenu_PayForService_DrawGoldPanel_Bank24
PriestMenu_PayForService_UpdateListCursorListCursor_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_024_6C96:: ; address name
    db $79, $C3, $A1, $C3, $C9, $C3, $F1, $C3

; address loaded by PriestMenu_PayForService_QueueSoundEffect
PriestMenu_PayForService_QueueSoundEffect_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_024_6C9E:: ; address name
    db $F1, $C3, $19, $C4, $41, $C4

; address loaded by GameMode6_Update_ObtainedEgg_Case00_WaitForVRAMAccess
GameMode6_Update_ObtainedEgg_Case00_WaitForVRAMAccess_Data_6CA4:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_024_6CA4:: ; address name
    ds $38, $00
    db $1F, $00, $FF, $7F, $00, $7E, $00, $00

; address loaded by GameMode6_Init, GameMode6_Update_Shared01_DecompressToVRAM
; LZSS-compressed asset: 303 bytes expand to 512 (tools/lzss_gfx.py, E-0016/E-0017; C1)
GameMode6_Init_Data_6CE4:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_024_6CE4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $092CE4, $12F

; address loaded by GameMode6_Init, GameMode6_Update_Shared01_DecompressToVRAM
; LZSS-compressed asset: 315 bytes expand to 512 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Tiles1Plus600Gfx_24_6E13:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_024_6E13:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $092E13, $13B

; address loaded by GameMode6_Init
; LZSS-compressed asset: 247 bytes expand to 512 (tools/lzss_gfx.py, E-0016/E-0017; C1)
GameMode6_Init_Data_6F4E:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_024_6F4E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $092F4E, $F7

; draws the next glyph of the description of the item at wItemGrid[4 * wItemGridY + wItemGridX] (text table Data_024_7158), handling the $F0 and $F1 control bytes (E-0131)
; 1 call site from 1 routine (e.g. ShopMenu_Shared01_ToStepItemDescriptionText)
; reads: wTextCounter6, wScreenState, wItemGridY, wItemGridX, wTextCounter2, wTextCounter1, wCursorBlinkB8, wTextCounter4, ...
; writes: wCursorBlinkB8, wTextCounter2, wTextCounter1, wTextCounter3, wTextCounter4, wTextCounter0
; points at: wItemGrid
StepItemDescriptionText::
Func_024_7045:: ; address name
    ld a, [wTextCounter6]
    and a, a
    jr nz, .check_screen_state

.check_screen_state:
    ld a, [wScreenState]
    cp a, $04
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
    cp a, $F0
    jp z, .clear_text_counter1
    cp a, $F1
    jp z, .read_text_counter12
    ld [wCursorBlinkB8], a
    push hl
    ld hl, $4010
    swap a
    ld d, a
    and a, $F0
    ld e, a
    ld a, d
    and a, $0F
    ld d, a
    add hl, de
    ld e, l
    ld d, h
    push de
    ld a, [wCursorBlinkB8]
    cp a, $8D
    jr z, .read_text_counter4
    cp a, $8E
    jr z, .read_text_counter4
    jr .read_text_counter42

.read_text_counter4:
    ld a, [wTextCounter4]
    ld e, a
    ld a, [wTextCounter3]
    ld d, a
    ld a, e
    sub a, $10
    ld e, a
    ld a, d
    sbc a, $00
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
    ld b, $1F
    ld c, $10
    ld a, [wCursorBlinkB8]
    cp a, $8D
    jr z, .call_or_from_bank_wait_vram
    cp a, $8E
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
    add a, $01
    ld [wTextCounter2], a
    ld a, d
    adc a, $00
    ld [wTextCounter1], a
    ld a, [wTextCounter3]
    ld d, a
    ld a, [wTextCounter4]
    ld e, a
    add a, $10
    ld e, a
    ld a, d
    adc a, $00
    ld [wTextCounter3], a
    ld a, e
    ld [wTextCounter4], a
    jp StepItemDescriptionText

.clear_text_counter1:
    xor a, a
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
    add a, $01
    ld [wTextCounter2], a
    ld a, d
    adc a, $00
    ld [wTextCounter1], a
    ld a, $01
    ld [wTextCounter3], a
    ld a, $20
    ld [wTextCounter4], a
    jp StepItemDescriptionText

; E-0255 (C1: StepItemDescriptionText reads the word at $7158 + 2 * the item number under the item grid cursor and shows the text from there plus wTextCounter1/2; 99 words, one per ItemTable entry).
; record: description text
ItemDescriptionTable::
Data_024_7158:: ; address name
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

ItemDescription_Herb:: ; heuristic: item description; C0
Data_024_721E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores HP of one", $F1
    db "monster by "
    db $03, $00, $9D, $04, $00, $B5, $F0

ItemDescription_LoveWater:: ; heuristic: item description; C0
Data_024_7243:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores HP of one", $F1
    db "monster by "
    db $06, $00, $9D, $07, $00, $B5, $F0

ItemDescription_WorldDew:: ; heuristic: item description; C0
Data_024_7268:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fully restores HP", $F1
    db "of all monsters.", $F0

ItemDescription_Potion:: ; heuristic: item description; C0
Data_024_728B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores MP of one", $F1
    db "monster by "
    db $02, $00, $9D, $03, $00, $B5, $F0

ItemDescription_ElfWater:: ; heuristic: item description; C0
Data_024_72B0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Fully restores MP", $F1
    db "of one monster.", $F0

ItemDescription_Antidote:: ; heuristic: item description; C0
Data_024_72D2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Removes all traces", $F1
    db "of poison.", $F0

ItemDescription_MoonHerb:: ; heuristic: item description; C0
Data_024_72F0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Cures paralysis.", $F0

ItemDescription_Laurel:: ; heuristic: item description; C0
Data_024_7301:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Lifts a curse off", $F1
    db "one monster.", $F0

ItemDescription_AwakeSand:: ; heuristic: item description; C0
Data_024_7320:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Awakens a sleeping", $F1
    db "monster.", $F0

ItemDescription_SkyBell:: ; heuristic: item description; C0
Data_024_733C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Snaps a monster", $F1
    db "out of confusion.", $F0

ItemDescription_SageRock:: ; heuristic: item description; C0
Data_024_735E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores HP of all", $F1
    db "monsters by "
    db $06, $00, $9D, $07, $00, $B5, $F0

ItemDescription_WorldLeaf:: ; heuristic: item description; C0
Data_024_7384:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Revives a dead", $F1
    db "monster.", $F0

ItemDescription_ATKseed:: ; heuristic: item description; C0
Data_024_739C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises ATK by 3.", $F0

ItemDescription_DEFseed:: ; heuristic: item description; C0
Data_024_73AD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises DEF by 3.", $F0

ItemDescription_AGLseed:: ; heuristic: item description; C0
Data_024_73BE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises AGL by 3.", $F0

ItemDescription_INTseed:: ; heuristic: item description; C0
Data_024_73CF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises INT by 3.", $F0

ItemDescription_LifeAcorn:: ; heuristic: item description; C0
Data_024_73E0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. HP", $F1
    db "by 5.", $F0

ItemDescription_MysticNut:: ; heuristic: item description; C0
Data_024_73F5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. MP", $F1
    db "by 5.", $F0

ItemDescription_Quest:: ; heuristic: item description; C0
Data_024_740A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "braver.", $F0

ItemDescription_Horror:: ; heuristic: item description; C0
Data_024_7423:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "more cowardly.", $F0

ItemDescription_BeNice:: ; heuristic: item description; C0
Data_024_7443:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "more kindly.", $F0

ItemDescription_Cheater:: ; heuristic: item description; C0
Data_024_7461:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "more sly.", $F0

ItemDescription_Smart:: ; heuristic: item description; C0
Data_024_747C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "more thoughtful.", $F0

ItemDescription_Comedy:: ; heuristic: item description; C0
Data_024_749E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Makes the reader", $F1
    db "simple-minded.", $F0

ItemDescription_BeefJerky:: ; heuristic: item description; C0
Data_024_74BE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames monsters", $F1
    db "just a little.", $F0

ItemDescription_PorkChop:: ; heuristic: item description; C0
Data_024_74DC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames monsters a", $F1
    db "little bit.", $F0

ItemDescription_Rib:: ; heuristic: item description; C0
Data_024_74F9:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames monsters a", $F1
    db "lot.", $F0

ItemDescription_Sirloin:: ; heuristic: item description; C0
Data_024_750F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames monsters", $F1
    db "very much.", $F0

ItemDescription_BadMeat:: ; heuristic: item description; C0
Data_024_7529:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames a tiny bit,", $F1
    db "but also poisons.", $F0

ItemDescription_MeteOrb:: ; heuristic: item description; C0
Data_024_754D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Tames monsters", $F1
    db "incredibly.", $F0

ItemDescription_BeastTail:: ; heuristic: item description; C0
Data_024_7568:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Checks if monster", $F1
    db "was caught before.", $F0

ItemDescription_Repellent:: ; heuristic: item description; C0
Data_024_758D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Prevents monsters", $F1
    db "from appearing.", $F0

ItemDescription_ShinyHarp:: ; heuristic: item description; C0
Data_024_75AF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Attracts monsters", $F1
    db "when strummed.", $F0

ItemDescription_Mist:: ; heuristic: item description; C0
Data_024_75D0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Prevents casting", $F1
    db "of spells.", $F0

ItemDescription_Friend:: ; heuristic: item description; C0
Data_024_75EC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Doubles physical", $F1
    db "power of one.", $F0

ItemDescription_Wind:: ; heuristic: item description; C0
Data_024_760B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hits all enemies", $F1
    db "with a windstorm.", $F0

ItemDescription_Bolt:: ; heuristic: item description; C0
Data_024_762E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hits all enemies", $F1
    db "with lightning.", $F0

ItemDescription_Snow:: ; heuristic: item description; C0
Data_024_764F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hits all enemies", $F1
    db "with a blizzard.", $F0

ItemDescription_Fire:: ; heuristic: item description; C0
Data_024_7671:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Hits one target", $F1
    db "with a fireball.", $F0

ItemDescription_Warp:: ; heuristic: item description; C0
Data_024_7692:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Instantly warps to", $F1
    db "the Door Shrine.", $F0

ItemDescription_WarpWing:: ; heuristic: item description; C0
Data_024_76B6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Instantly warps to", $F1
    db "GreatLog.", $F0

ItemDescription_ExitBell:: ; heuristic: item description; C0
Data_024_76D3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Instantly warps to", $F1
    db "the exit.", $F0

ItemDescription_Bookmark:: ; heuristic: item description; C0
Data_024_76F0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Enables saving in", $F1
    db "the Journal.", $F0

ItemDescription_TinyMedal:: ; heuristic: item description; C0
Data_024_770F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Collect and trade", $F1
    db "for rare gifts.", $F0

ItemDescription_GoldPass:: ; heuristic: item description; C0
Data_024_7731:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Get a 10-percent", $F1
    db "discount at shops.", $F0

ItemDescription_LogTwig:: ; heuristic: item description; C0
Data_024_7755:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Moves the Door", $F1
    db "Shrine.", $F0

ItemDescription_2F:: ; heuristic: item description; C0
Data_024_776C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Reveals Mirage", $F1
    db "Lake.", $F0

ItemDescription_MoonRock:: ; heuristic: item description; C0
Data_024_7781:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A magic stone that", $F1
    db "raises the tide.", $F0

ItemDescription_Crest:: ; heuristic: item description; C0
Data_024_77A5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A medal from the", $F1
    db "elemental spirit.", $F0

ItemDescription_YunaSoul:: ; heuristic: item description; C0
Data_024_77C8:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "The lost soul of a", $F1
    db "princess.", $F0

ItemDescription_SleepHerb:: ; heuristic: item description; C0
Data_024_77E5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A blue flower that", $F1
    db "grows in snow.", $F0

ItemDescription_Change:: ; heuristic: item description; C0
Data_024_7807:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Transforms users", $F1
    db "into monsters.", $F0

ItemDescription_TidalBell:: ; heuristic: item description; C0
Data_024_7827:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons a clam for", $F1
    db "crossing the sea.", $F0

ItemDescription_HarMirror:: ; heuristic: item description; C0
Data_024_784C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Destroys what it", $F1
    db "reflects.", $F0

ItemDescription_Sky:: ; heuristic: item description; C0
Data_024_7867:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Summons a cloud", $F1
    db "for flying.", $F0

ItemDescription_Heaven:: ; heuristic: item description; C0
Data_024_7883:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A legendary helmet", $F1
    db "found in a cave.", $F0

ItemDescription_Heaven_78A7:: ; heuristic: item description; C0
Data_024_78A7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A legendary armor", $F1
    db "found in a tower.", $F0

ItemDescription_Heaven_78CB:: ; heuristic: item description; C0
Data_024_78CB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A legendary sword", $F1
    db "found in a castle.", $F0

ItemDescription_WizStone:: ; heuristic: item description; C0
Data_024_78F0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A magical stone", $F1
    db "that glows blue.", $F0

ItemDescription_Pretty:: ; heuristic: item description; C0
Data_024_7911:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "A beautiful gold", $F1
    db "ring.", $F0

ItemDescription_Accessory:: ; heuristic: item description; C0
Data_024_7928:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Undefined.", $F0

ItemDescription_VITbelt:: ; heuristic: item description; C0
Data_024_7933:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. HP", $F1
    db "by 30.", $F0

ItemDescription_DracoBelt:: ; heuristic: item description; C0
Data_024_7949:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. HP", $F1
    db "by 80.", $F0

ItemDescription_MagicBelt:: ; heuristic: item description; C0
Data_024_795F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. MP", $F1
    db "by 30.", $F0

ItemDescription_OddBelt:: ; heuristic: item description; C0
Data_024_7975:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises max. MP", $F1
    db "by 80.", $F0

ItemDescription_StoneFang:: ; heuristic: item description; C0
Data_024_798B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises ATK by 10.", $F0

ItemDescription_SteelFang:: ; heuristic: item description; C0
Data_024_799D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises ATK by 50.", $F0

ItemDescription_MermScale:: ; heuristic: item description; C0
Data_024_79AF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises DEF by 10.", $F0

ItemDescription_DrakScale:: ; heuristic: item description; C0
Data_024_79C1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises DEF by 50.", $F0

ItemDescription_AGL:: ; heuristic: item description; C0
Data_024_79D3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises AGL by 10.", $F0

ItemDescription_Starry:: ; heuristic: item description; C0
Data_024_79E5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises AGL by 50.", $F0

ItemDescription_Smart_79F7:: ; heuristic: item description; C0
Data_024_79F7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises INT by 50.", $F0

ItemDescription_Wise:: ; heuristic: item description; C0
Data_024_7A09:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises INT by 100.", $F0

ItemDescription_MagicCape:: ; heuristic: item description; C0
Data_024_7A1C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises resistance", $F1
    db "to attack spells.", $F0

ItemDescription_DracoCape:: ; heuristic: item description; C0
Data_024_7A40:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises resistance", $F1
    db "to fire and ice.", $F0

ItemDescription_SilvrCape:: ; heuristic: item description; C0
Data_024_7A63:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Resists confusion,", $F1
    db "poison "
    db $B6
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " sleep.", $F0

ItemDescription_GoldCape:: ; heuristic: item description; C0
Data_024_7A86:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Resists most", $F1
    db "status skills.", $F0

ItemDescription_PltnmCape:: ; heuristic: item description; C0
Data_024_7AA2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Resists curse,", $F1
    db "paralysis "
    db $B6
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " death.", $F0

ItemDescription_OrcaCape:: ; heuristic: item description; C0
Data_024_7AC4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises resistance", $F1
    db "to water skills.", $F0

ItemDescription_BraveCape:: ; heuristic: item description; C0
Data_024_7AE7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Prevents skills", $F1
    db "from being sealed.", $F0

ItemDescription_DScale:: ; heuristic: item description; C0
Data_024_7B0A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Raises DEF by 5.", $F0

ItemDescription_None:: ; heuristic: item description; C0
Data_024_7B1B:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Undefined.", $F0

ItemDescription_Life:: ; heuristic: item description; C0
Data_024_7B26:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores HP by 1", $F1
    db "on every step.", $F0

ItemDescription_Divine:: ; heuristic: item description; C0
Data_024_7B46:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Restores MP by 1", $F1
    db "on every step.", $F0

ItemDescription_War:: ; heuristic: item description; C0
Data_024_7B66:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes max. HP", $F1
    db "gain.", $F0

ItemDescription_Mage:: ; heuristic: item description; C0
Data_024_7B7D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes max.", $F1
    db "MP gain.", $F0

ItemDescription_Fight:: ; heuristic: item description; C0
Data_024_7B94:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes ATK gain", $F1
    db "while growing.", $F0

ItemDescription_Sailor:: ; heuristic: item description; C0
Data_024_7BB5:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes DEF gain", $F1
    db "while growing.", $F0

ItemDescription_Thief:: ; heuristic: item description; C0
Data_024_7BD6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes AGL gain", $F1
    db "while growing.", $F0

ItemDescription_Cleric:: ; heuristic: item description; C0
Data_024_7BF7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Promotes INT gain", $F1
    db "while growing.", $F0

ItemDescription_62:: ; heuristic: item description; C0
Data_024_7C18:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "Undefined.", $F0
    ds $3DD, $00
