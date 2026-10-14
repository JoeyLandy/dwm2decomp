; ROM bank $07: link cable sessions and the title screen (game mode 5)
; The annotated listing of this bank is build/listing/bank07.asm.

SECTION "Bank 07", ROMX[$4000], BANK[$07]
    db $07

; ld de, this bank's string table / BeginStringDisplay (E-0353)
BeginStringDisplay_Bank07::
    ld de, BeginStringDisplay_Bank07_StringCategories
    call BeginStringDisplay
    ret
    db $11, $16, $40, $cd, $fe, $25, $c9

; BeginStringDisplay_Bank07 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; (E-0353)
ShowString_Bank07::
    call BeginStringDisplay_Bank07
    call RunStringDisplayToEnd
    ret

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
BeginStringDisplay_Bank07_StringCategories::
    dw StringList_Bank07_StringCategories_0 ; id 0
    dw StringList_Bank07_StringCategories_1 ; id 1
    dw StringList_Bank07_StringCategories_2 ; id 2
    dw StringList_Bank07_StringCategories_3 ; id 3
    dw StringList_Bank07_StringCategories_4 ; id 4
    dw StringList_Bank07_StringCategories_5 ; id 5
    dw StringList_Bank07_StringCategories_6 ; id 6

; category list of BeginStringDisplay_Bank07_StringCategories; one pointer per wStringIndex (E-0217)
; record: string
StringList_Bank07_StringCategories_0::
    dw String_07_00_00 ; id 0
    dw String_07_00_01 ; id 1
    dw String_07_00_02 ; id 2
    dw String_07_00_03 ; id 3
    dw String_07_00_04 ; id 4
    dw String_07_00_05 ; id 5
    dw String_07_00_06 ; id 6
    dw String_07_00_07 ; id 7

StringList_Bank07_StringCategories_1::
    dw String_07_01_00 ; id 0
    dw String_07_01_01 ; id 1
    dw String_07_01_02 ; id 2
    dw String_07_01_03 ; id 3
    dw String_07_01_04 ; id 4
    dw String_07_01_05 ; id 5

StringList_Bank07_StringCategories_2::
    dw String_07_02_00 ; id 0

StringList_Bank07_StringCategories_3::
    dw String_07_03_00 ; id 0
    dw String_07_03_01 ; id 1
    dw String_07_03_02 ; id 2
    dw String_07_03_03 ; id 3
    dw String_07_03_04 ; id 4
    dw String_07_03_05 ; id 5
    dw String_07_03_06 ; id 6

StringList_Bank07_StringCategories_4::
    dw String_07_04_00 ; id 0
    dw String_07_04_01 ; id 1
    dw String_07_04_02 ; id 2

StringList_Bank07_StringCategories_5::
    dw String_07_05_00 ; id 0
    dw String_07_05_01 ; id 1
    dw String_07_05_02 ; id 2
    dw String_07_05_03 ; id 3
    dw String_07_05_04 ; id 4
    dw String_07_05_05 ; id 5
    dw String_07_05_06 ; id 6
    dw String_07_05_07 ; id 7
    dw String_07_05_08 ; id 8
    dw String_07_05_09 ; id 9
    dw String_07_05_0A ; id 10
    dw String_07_05_0B ; id 11
    dw String_07_05_0C ; id 12
    dw String_07_05_0D ; id 13
    dw String_07_05_0E ; id 14
    dw String_07_05_0F ; id 15
    dw String_07_05_10 ; id 16
    dw String_07_05_11 ; id 17
    dw String_07_05_12 ; id 18
    dw String_07_05_13 ; id 19
    dw String_07_05_14 ; id 20
    dw String_07_05_15 ; id 21
    dw String_07_05_16 ; id 22
    dw String_07_05_17 ; id 23
    dw String_07_05_18 ; id 24
    dw String_07_05_19 ; id 25
    dw String_07_05_1A ; id 26

StringList_Bank07_StringCategories_6::
    dw String_07_06_00 ; id 0
    dw String_07_06_01 ; id 1
    dw String_07_06_02 ; id 2
    dw String_07_06_03 ; id 3
    dw String_07_06_04 ; id 4
    dw String_07_06_05 ; id 5
    dw String_07_06_06 ; id 6
    dw String_07_06_07 ; id 7
    dw String_07_06_08 ; id 8

String_07_00_00::
    db "ENIX@"

String_07_00_01::
    db "DRAGON WARRIOR<LINE>"
    db "   MONSTERS 2 @"

String_07_00_02::
    db "CONTINUE NEW GAME BREEDING KEY TRADEVS MODE  TEAM MODETERRY "
    db "   @"

String_07_00_03::
    db "Saved data has<LINE>"
    db "been lost.<WAIT>"
    db "@"

String_07_00_04::
    db "Master@"

String_07_00_05::
    db "Game Link<LINE>"
    db "is not ready.<PROMPT>"
    db "<CLEAR>Please check<LINE>"
    db "and try again.<WAIT>"
    db "@"

String_07_00_06::
    db "DREAM EGG@"

String_07_00_07::
    db "Game Link cannot<LINE>"
    db "be used with<PROMPT>"
    db "<CLEAR>Super Game Boy.<WAIT>"
    db "@"

String_07_01_00::
    db "DuoOwnWL:@"

String_07_01_01::
    db "Yes@"

String_07_01_02::
    db "Kill A<LINE>"
    db "<CURSOR>", $07, $01, "Next B@"

String_07_01_03::
    db "RESULTSDuoW+LevelTurnsWin", $92, "RankOwnWDuoLOwnL@"

String_07_01_04::
    db "GFDEBCAS@"

String_07_01_05::
    db "GFEDCBAS@"

String_07_02_00::
    db "Trade keys.@"

String_07_03_00::
    db "FREE BATTLE<LINE>"
    db "ENIX RULES <LINE>"
    db "LOCAL RULES<LINE>"
    db "EXIT       @"

String_07_03_01::
    db "ABEFILNORSTXYaceghiklmnrtuvxyKMDposb@"

String_07_03_02::
    db "Refused the VS<LINE>"
    db "battle.@"

String_07_03_03::
    db "The VS battle was<LINE>"
    db "refused.@"

String_07_03_04::
    db "Choosing rules.<LINE>"
    db "Please wait.@"

String_07_03_05::
    db "Receiving rules.<LINE>"
    db "Please wait.@"

String_07_03_06::
    db "Confirming rules.<LINE>"
    db "Please wait.@"

String_07_04_00::
    db "Play the boy's<LINE>"
    db "adventure?<CHOICE>"
    db "@"

String_07_04_01::
    db "Enter the boy's<LINE>"
    db "name.<PROMPT>"
    db "@"

String_07_04_02::
    db "Enter the girl's<LINE>"
    db "name.<PROMPT>"
    db "@"

String_07_05_00::
    db "Not enough money.<LINE>"
    db "Please wait.@"

String_07_05_01::
    db "Your pal doesn't<LINE>"
    db "have enough gold.<PROMPT>"
    db "<CLEAR>Will you pay the<LINE>"
    db "1000G battle fee?<CHOICE>"
    db "@"

String_07_05_02::
    db "You paid for both<LINE>"
    db "combatants.@"

String_07_05_03::
    db "Your pal paid your<LINE>"
    db "battle fee.@"

String_07_05_04::
    db "Insufficient gold<LINE>"
    db "for Team Mode.@"

String_07_05_05::
    db "You refused to pay<LINE>"
    db "the battle fee for<PROMPT>"
    db "<CLEAR>your pal.@"

String_07_05_06::
    db "Your pal refused<LINE>"
    db "to pay the battle<PROMPT>"
    db "<CLEAR>fee for you.@"

String_07_05_07::
    db "You paid the 1000G<LINE>"
    db "battle fee.<PROMPT>"
    db "<CLEAR>You can now battle<LINE>"
    db "in Team Mode.@"

String_07_05_08::
    db "Choose a monster<LINE>"
    db "for the Team Mode.@"

String_07_05_09::
    db "You refused the<LINE>"
    db "Team Mode.@"

String_07_05_0A::
    db "Your pal refused<LINE>"
    db "the Team Mode.@"

String_07_05_0B::
    db "Send your monster<LINE>"
    db "into battle?@"

String_07_05_0C::
    db "Please wait.@"

String_07_05_0D::
    db "Battle in Team<LINE>"
    db "Mode?@"

String_07_05_0E::
    db "The battle results<LINE>"
    db "will be recorded.<PROMPT>"
    db "<CLEAR>Is that OK?<CHOICE>"
    db "@"

String_07_05_0F::
    db "In Team Mode, you<LINE>"
    db "both have won.<PROMPT>"
    db "@"

String_07_05_10::
    db "In Team Mode, you<LINE>"
    db "alone won.<PROMPT>"
    db "@"

String_07_05_11::
    db "In Team Mode, you<LINE>"
    db "both lost.<MUSIC_WAIT>", $42, "<PROMPT>"
    db "@"

String_07_05_12::
    db "In Team Mode, you<LINE>"
    db "alone lost.<PROMPT>"
    db "@"

String_07_05_13::
    db "<PLAYER> obtained an<LINE>"
    db "egg of <BUF0>.<PROMPT>"
    db "@"

String_07_05_14::
    db "<BUF0>'s <BUF1><LINE>"
    db "rose by <BUF2>.<PROMPT>"
    db "@"

String_07_05_15::
    db "<BUF0>'s <BUF1><LINE>"
    db "fell by <BUF2>.<PROMPT>"
    db "@"

String_07_05_16::
    db "<PLAYER> received<LINE>"
    db "<BUF2>G.@"

String_07_05_17::
    db "There is no room<LINE>"
    db "for more monsters.<PROMPT>"
    db "<CLEAR>Switch it with<LINE>"
    db "another monster?<CHOICE>"
    db "@"

String_07_05_18::
    db "With no room for<LINE>"
    db "it , <BUF0> was<PROMPT>"
    db "<CLEAR>released in the<LINE>"
    db "wild.@"

String_07_05_19::
    db "For Team Mode,<LINE>"
    db "1000G is charged.<PROMPT>"
    db "<CLEAR>Will you pay this<LINE>"
    db "fee?<CHOICE>"
    db "@"

String_07_05_1A::
    db "Saving…<LINE>"
    db "Please wait.@"

String_07_06_00::
    db "Team Mode battle<LINE>"
    db "No. 1!<PROMPT>"
    db "@"

String_07_06_01::
    db "Team Mode battle<LINE>"
    db "No. 2!<PROMPT>"
    db "@"

String_07_06_02::
    db "Team Mode final<LINE>"
    db "battle!<PROMPT>"
    db "@"

String_07_06_03::
    db "The first monster<LINE>"
    db "is <BUF0>!<PROMPT>"
    db "@"

String_07_06_04::
    db "The second monster<LINE>"
    db "is <BUF0>!<PROMPT>"
    db "@"

String_07_06_05::
    db "The third monster<LINE>"
    db "is <BUF0>!<PROMPT>"
    db "@"

String_07_06_06::
    db "Congratulations<LINE>"
    db "for your victory!<PROMPT>"
    db "<CLEAR>You've cleared<LINE>"
    db "Round 1!<PROMPT>"
    db "@"

String_07_06_07::
    db "Congratulations<LINE>"
    db "for your victory!<PROMPT>"
    db "<CLEAR>There's just one<LINE>"
    db "round to go!<PROMPT>"
    db "@"

String_07_06_08::
    db "Congratulations<LINE>"
    db "for your victory!<PROMPT>"
    db "<CLEAR>You've won the<LINE>"
    db "tournament!<MUSIC_WAIT>", $00, "<SFX_WAIT>", $7e, "<PROMPT>"
    db "@"

; start-up for wGameMode = 5; forcing this mode on the emulator shows: title screen; also sparkles
; and a victory screen when forced (E-0029)
GameMode5_Init::
    xor a
    ld hl, wMenuState
    ld bc, $0008
    call FillBytes
    xor a
    ld hl, wTextWindowTileLo
    ld bc, $0012
    call FillBytes
    ld hl, vBGMap0 + $1c1
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    xor a
    ld hl, wTitleScreenState
    ld bc, $0008
    call FillBytes
    call ClearSTATInterruptSources
    xor a
    ld [wLinkReady], a
    ld a, [wModeState]
    jumptable
    dw GameMode5_Init_LoadSGBObjectPalettesFromPointers
    dw GameMode5_Init_InitSoundHardware
    dw GameMode5_Init_SendSGBPaletteSetPacket
    dw GameMode5_Init_SendSGBPaletteSetPacket_2
    dw GameMode5_Init_SendSGBPaletteSetPacket_ReadLinkSetupMode
    dw GameMode5_Init_WriteSaveStepAndSaveRecordIndexEtc
    dw GameMode5_Init_SendSGBPaletteSetPacket_3
    dw GameMode5_Init_WriteSaveStepAndSaveRecordIndexEtc

; Game mode 5 start-up, wModeState 0 (the boot into the intro): on the SGB loads the object
; palettes; on CGB whitens all BG palettes and clears the BG attributes; then decompresses the title
; tiles to vTiles1 and sets the DMG palettes and the rest of the screen state. (C1, E-0357)
GameMode5_Init_LoadSGBObjectPalettesFromPointers::
    ld a, [wSGBActive]
    or a
    jr z, .check_is_cgb
    ld hl, wSGBPaletteSet
    ld [hl], $00
    inc hl
    ld [hl], $00
    farcall LoadSGBObjectPalettesFromPointers
    jr .skip

.check_is_cgb:
    ld a, [wIsCGB]
    or a
    jr z, .skip
    ld b, $40
    ld hl, wBGPaletteBuffer

.loop:
    ld a, $ff
    ld [hli], a
    ld a, $7f
    ld [hli], a
    dec b
    jr nz, .loop
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $0240
    xor a
    call FillBytes
    ld a, $00
    ldh [rVBK], a

.skip:
    ld b, $46
    ld de, Tiles1Gfx
    ld hl, vTiles1
    call DecompressToRAMLocked
    xor a
    ld hl, wDMGPaletteBGP
    ld [hli], a
    ld [hli], a
    ld [hl], a
    xor a
    ldh [rBGP], a
    ldh [rOBP0], a
    ldh [rOBP1], a
    ld a, $c3
    ld hl, vBGMap0
    ld bc, $0800
    call FillBytes
    ld a, $07
    ldh [hWindowX], a
    ld a, $ff
    ldh [hWindowY], a
    ld a, $00
    ldh [hScrollX], a
    ld a, $00
    ldh [hScrollY], a
    xor a
    ld [wFrameCounterLo], a
    ld [wFrameCounterHi], a
    xor a
    ld [wSTATSplitEnable], a
    xor a
    ld [wLinkSession], a
    ld [wLinkExchangeState], a
    xor a
    ld [wLinkMode], a
    xor a
    ld [wLinkScreenStep], a
    xor a
    ld [wLinkRole], a
    ld [wLinkStatus], a
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $01
    jp ClearSGBPacketBuffer_CheckLinkMode

; Game mode 5 start-up, wModeState 1 (the title menu): silences the sound, clears the work and link
; areas, sets the SGB border and palettes and starts the fade in; clears the player, story flags and
; key-world data and the working SRAM areas (bank 0, the first $6F bytes of bank 1, bank 2), keeping
; the link setting saved in SRAM; sets message speeds (battle 4, text 1); draws the two menu
; strings; then checks the save (CheckSaveData): with no save it plays music 9, otherwise it draws
; the save summary for the result and plays music 2 or 9. (C1, E-0357)
GameMode5_Init_InitSoundHardware::
    call InitSoundHardware
    xor a
    ld hl, wWorkBuf
    ld bc, $0210
    call FillBytes
    xor a
    ld hl, wLinkRole
    ld bc, $0058
    call FillBytes
    ld a, [wSGBActive]
    or a
    jr z, .call_start_palette_fade
    ld a, $02
    call LoadSGBBorderForSetA
    call SpinDelay
    ld hl, wSGBPaletteSet
    ld [hl], $00
    inc hl
    ld [hl], $00
    farcall SendSGBPaletteSetPacket

.call_start_palette_fade:
    ld a, $fc
    call StartPaletteFade
    ld hl, hPlayerSpriteVariant
    ld bc, $000e
    xor a
    call FillBytes
    ld hl, wPlayerName
    ld bc, $0291
    xor a
    call FillBytes
    ld a, $0a
    ld [rRAMG], a
    ld a, $01
    ld [rRAMB], a
    ld a, [sSavedLinkSetting]
    or a
    jr z, .set_link_setting
    cp $01
    jr z, .set_link_setting
    xor a

.set_link_setting:
    ld [wLinkSetting], a
    xor a
    ld [rRAMB], a
    xor a
    ld [rRAMG], a
    ld hl, wStoryFlags
    ld bc, $006b
    xor a
    call FillBytes
    ld hl, wKeyWorldSlot
    ld bc, $00b5
    xor a
    call FillBytes
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld hl, sRecords
    ld bc, $2000
    xor a
    call FillBytes
    ld a, $0a
    ld [rRAMG], a
    ld a, $01
    ld [rRAMB], a
    ld hl, sRecords
    ld bc, $006f
    xor a
    call FillBytes
    ld a, $02
    ld [rRAMB], a
    ld hl, sRecords
    ld bc, $2000
    xor a
    call FillBytes
    xor a
    ld [rRAMG], a
    ld a, $04
    ld [wBattleTextSpeed], a
    ld a, $01
    ld [wTextSpeed], a
    ld b, $46
    ld de, Tiles1Gfx
    ld hl, vTiles1
    call DecompressToRAMLocked
    ld hl, vTiles2
    ld de, $0907
    call FillTilesRequest
    ld a, $00
    ld [wStringCategory], a
    ld a, $02
    ld [wStringIndex], a ; 'CONTINUE NEW GAME BREEDING KEY TRADEVS'
    farcall ShowString_Bank07
    ld hl, vTiles2 + $700
    ld de, $0907
    call FillTilesRequest
    ld a, $00
    ld [wStringCategory], a
    ld a, $06
    ld [wStringIndex], a ; 'DREAM EGG'
    farcall ShowString_Bank07
    ld a, [wIsCGB]
    or a
    jr z, .call_fill_screen_tile_buffer_with_d
    ld a, $01
    ldh [rVBK], a
    ld d, $00
    call FillScreenTileBufferWithD
    call DrawScreenBufferToBGMap0_Bank07
    xor a
    ldh [rVBK], a

.call_fill_screen_tile_buffer_with_d:
    ld d, $c3
    call FillScreenTileBufferWithD
    call DrawScreenBufferToBGMap0_Bank07
    farcall CheckSaveData
    ldh a, [hTemp0]
    ld [wTitleScreenState], a
    or a
    jr z, .call_queue_music
    ld hl, SaveCheckScreenRects
    add a
    add_a_to_hl
    deref_hl
    call CopyRecordRectToScreenBuffer_Bank07
    call DrawScreenBufferToBGMap0_Bank07
    ld a, [wTitleScreenState]
    cp $01
    jr z, .call_queue_music
    ld a, $02
    jr .call_queue_music2

.call_queue_music:
    ld a, $09

.call_queue_music2:
    call QueueMusic
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, $07
    ldh [hWindowX], a
    ld a, $00
    ldh [hWindowY], a
    ld a, $00
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    xor a
    ld [wFrameCounterLo], a
    ld [wFrameCounterHi], a
    xor a
    ld [wSTATSplitEnable], a
    xor a
    ld [wLinkSession], a
    ld [wLinkExchangeState], a
    xor a
    ld [wLinkMode], a
    xor a
    ld [wLinkScreenStep], a
    xor a
    ld [wLinkRole], a
    ld [wLinkStatus], a
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $09
    jp ClearSGBPacketBuffer_CheckLinkMode

; fills the 20 x 18 visible part of wScreenTileBuffer (32-byte rows) with D (E-0124)
FillScreenTileBufferWithD::
    ld hl, wScreenTileBuffer
    ld bc, $1412
    ld a, d

.loop:
    ld [hli], a
    dec b
    jr nz, .loop
    ld a, l
    add $0c
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, d
    ld b, $14
    dec c
    jr nz, .loop
    ret

; the same effect as CopyRecordRectToScreenBuffer_Bank07 with the copy loop's instructions in a
; different order: HL = header (word offset, width, rows) followed by tile bytes, copied into
; wScreenTileBuffer + offset with rows 32 bytes apart (E-0071)
CopyRecordRectToScreenBuffer_Bank07::
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
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, .loop
    ret

; copies the 20 x 18 entries of wScreenTileBuffer to vBGMap0 (rows 32 apart) with
; CopyRect32StrideToVRAM_Bank07 (E-0073)
DrawScreenBufferToBGMap0_Bank07::
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    lb bc, $14, $12

; the same instructions as CopyRect32StrideToVRAM_Bank16: B = width, C = rows, DE = source and HL =
; VRAM, both with rows 32 bytes apart; copies with WriteVRAMByteInc; B kept, C = 0 (E-0073)
CopyRect32StrideToVRAM_Bank07::
    push bc
    push de
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
    pop de
    ld a, e
    add $20
    ld e, a
    ld a, d
    adc $00
    ld d, a
    pop bc
    dec c
    jr nz, CopyRect32StrideToVRAM_Bank07
    ret

; Game mode 5 start-up, wModeState 2 (returning to the title from a game): clears the screen state,
; loads the save (RunSaveSteps until done, and the key world when in one), fades in, decompresses
; the title tiles, opens the text window and plays music 9 with the window and scroll reset, then
; turns the screen on. (C1, E-0357)
GameMode5_Init_SendSGBPaletteSetPacket::
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
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld a, [wSGBActive]
    or a
    jr z, .check_is_cgb
    ld hl, wSGBPaletteSet
    ld [hl], $00
    inc hl
    ld [hl], $00
    farcall SendSGBPaletteSetPacket
    jr .loop2

.check_is_cgb:
    ld a, [wIsCGB]
    or a
    jr z, .loop2
    farcall LoadPalette0FromData

.loop2:
    farcall RunSaveSteps
    ld a, [wSaveStep]
    bit 7, a
    jr z, .loop2
    ld a, [wMapType]
    bit 7, a
    jr z, .call_start_palette_fade
    farcall LoadKeyWorldFlagsRecordFromSRAMSlotKeyWorldSlot

.call_start_palette_fade:
    ld a, $fc
    call StartPaletteFade
    ld b, $46
    ld de, Tiles1Gfx
    ld hl, vTiles1
    call DecompressToRAMLocked
    farcall ClearScreenBufferAndAttributes_BankF1
    ld hl, vBGMap0
    ld bc, $0240
    ld a, $c3
    call FillBytes
    ld a, $01
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a

.loop3:
    farcall StepTextWindowOpenClose
    ld a, [wTextWindowState]
    and $03
    jr nz, .loop3
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld hl, wMenuState
    ld bc, $0008
    xor a
    call FillBytes
    ld hl, wTitleScreenState
    ld bc, $0008
    xor a
    call FillBytes
    ld a, $09
    call QueueMusic
    ld a, $07
    ldh [hWindowX], a
    ld a, $ff
    ldh [hWindowY], a
    ld a, $00
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a
    xor a
    ld [wFrameCounterLo], a
    ld [wFrameCounterHi], a
    xor a
    ld [wSTATSplitEnable], a
    xor a
    ld [wLinkSendByte], a
    xor a
    ld [wLinkMessage], a
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $09
    jp ClearSGBPacketBuffer_CheckLinkMode

; Game mode 5 start-up, wModeState 3: the same reload of the save and title screen as wModeState 2.
; (C1, E-0357)
GameMode5_Init_SendSGBPaletteSetPacket_2::
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
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld a, [wSGBActive]
    or a
    jr z, .check_is_cgb
    ld hl, wSGBPaletteSet
    ld [hl], $00
    inc hl
    ld [hl], $00
    farcall SendSGBPaletteSetPacket
    jr .loop2

.check_is_cgb:
    ld a, [wIsCGB]
    or a
    jr z, .loop2
    farcall LoadPalette0FromData

.loop2:
    farcall RunSaveSteps
    ld a, [wSaveStep]
    bit 7, a
    jr z, .loop2
    ld a, [wMapType]
    bit 7, a
    jr z, .call_start_palette_fade
    farcall LoadKeyWorldFlagsRecordFromSRAMSlotKeyWorldSlot

.call_start_palette_fade:
    ld a, $fc
    call StartPaletteFade
    ld b, $46
    ld de, Tiles1Gfx
    ld hl, vTiles1
    call DecompressToRAMLocked
    farcall ClearScreenBufferAndAttributes_BankF1
    ld hl, vBGMap0
    ld bc, $0240
    ld a, $c3
    call FillBytes
    ld a, $01
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a

.loop3:
    farcall StepTextWindowOpenClose
    ld a, [wTextWindowState]
    and $03
    jr nz, .loop3
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld hl, wMenuState
    ld bc, $0008
    xor a
    call FillBytes
    ld hl, wTitleScreenState
    ld bc, $0008
    xor a
    call FillBytes
    ld a, $09
    call QueueMusic
    ld a, $07
    ldh [hWindowX], a
    ld a, $ff
    ldh [hWindowY], a
    ld a, $00
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    xor a
    ld [wFrameCounterLo], a
    ld [wFrameCounterHi], a
    xor a
    ld [wSTATSplitEnable], a
    xor a
    ld [wLinkSendByte], a
    xor a
    ld [wLinkMessage], a
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $09
    jp ClearSGBPacketBuffer_CheckLinkMode

; Game mode 5 start-up, wModeState 4 (the link battle set-up): copies the link rules
; (GameMode5_Init_ReadLinkSetupMode), reloads the save, decompresses the link screen tiles and shows
; its strings. (C1, E-0357)
GameMode5_Init_SendSGBPaletteSetPacket_ReadLinkSetupMode::
    call GameMode5_Init_ReadLinkSetupMode
    xor a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld a, [wSGBActive]
    or a
    jr z, .check_is_cgb
    ld hl, wSGBPaletteSet
    ld [hl], $00
    inc hl
    ld [hl], $00
    farcall SendSGBPaletteSetPacket
    jr .loop

.check_is_cgb:
    ld a, [wIsCGB]
    or a
    jr z, .loop
    farcall LoadPalette0FromData

.loop:
    farcall RunSaveSteps
    ld a, [wSaveStep]
    bit 7, a
    jr z, .loop
    ld a, [wMapType]
    bit 7, a
    jr z, .call_start_palette_fade
    farcall LoadKeyWorldFlagsRecordFromSRAMSlotKeyWorldSlot

.call_start_palette_fade:
    ld a, $fc
    call StartPaletteFade
    ld b, $31
    ld de, Tiles1Plus240Gfx
    ld hl, vTiles1 + $240
    call DecompressToRAMLocked
    ld b, $31
    ld de, Tiles1Plus5F0Gfx
    ld hl, vTiles1 + $5f0
    call DecompressToRAMLocked
    ld hl, vTiles2 + $400
    ld de, $0b04
    call FillTilesRequest
    ld hl, $0300
    call GameMode5_Init_ShowString_Bank07
    ld a, $00
    ld [wWorkBuf + $1], a
    farcall LoadAllFamilyIconTiles
    ld hl, vTiles2 + $b0
    ld de, $2501
    call FillTilesRequest
    ld hl, $0301
    call GameMode5_Init_ShowString_Bank07
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld hl, wScreenTileBuffer
    ld bc, $0240
    ld a, $c3
    call FillBytes
    ld hl, SaveCheckScreenRects + $2fe
    call CopyRecordRectToScreenBuffer_Bank07
    call DrawScreenBufferToBGMap0_Bank07
    ld hl, wMenuState
    ld bc, $0008
    xor a
    call FillBytes
    ld hl, wTitleScreenState
    ld bc, $0008
    xor a
    call FillBytes
    ld a, $09
    call QueueMusic
    ld a, $07
    ldh [hWindowX], a
    ld a, $ff
    ldh [hWindowY], a
    ld a, $00
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    xor a
    ld [wFrameCounterLo], a
    ld [wFrameCounterHi], a
    xor a
    ld [wSTATSplitEnable], a
    xor a
    ld [wLinkSendByte], a
    xor a
    ld [wLinkMessage], a
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $09
    jp ClearSGBPacketBuffer_CheckLinkMode

; Copies the 10 link rule bytes to wLinkRules: the saved copy (wLinkRulesCopy) when wLinkSetupMode
; is 2, otherwise the defaults at GameMode5_Init_ReadLinkSetupMode_Data. (C1, E-0357)
GameMode5_Init_ReadLinkSetupMode::
    ld a, [wLinkSetupMode]
    cp $02
    jr z, .skip
    ld hl, GameMode5_Init_ReadLinkSetupMode_Data
    jr .skip2

.skip:
    ld hl, wLinkRulesCopy

.skip2:
    ld de, wLinkRules
    ld b, $0a

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

; data read by GameMode5_Init_ReadLinkSetupMode (10 bytes) (E-0347)
GameMode5_Init_ReadLinkSetupMode_Data::
    db $01, $00, $00, $63, $29, $01, $00, $00, $63, $80

; copies the 10 bytes at wLinkRules to wLinkRulesCopy (E-0122)
CopyLinkRulesToLinkRulesCopy::
    ld hl, wLinkRules
    ld de, wLinkRulesCopy
    ld b, $0a

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ret

; Game mode 5 start-up, wModeState 5: clears vTiles0 ($1800 bytes, waiting for VRAM access), then
; continues into wModeState 6. (C1, E-0357)
GameMode5_Init_WriteSaveStepAndSaveRecordIndexEtc::
    ld hl, vTiles0
    ld bc, $0c00
    xor a

.loop:
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    xor a
    ld [hli], a
    ld [hli], a
    ei
    dec bc
    ld a, b
    or c
    jr nz, .loop

; Game mode 5 start-up, wModeState 6 (returning after a link battle): clears the screen state,
; reloads the save, blanks the BG map, restores the party's HP, MP and status from the battle
; (GameMode5_Init_LoadSRAMRecordWord), fully heals the party, and reopens the title text window with
; music 9. (C1, E-0357)
GameMode5_Init_SendSGBPaletteSetPacket_3::
    ld hl, wScreenState
    ld bc, $006f

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop
    xor a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld a, [wSGBActive]
    or a
    jr z, .check_is_cgb
    ld hl, wSGBPaletteSet
    ld [hl], $00
    inc hl
    ld [hl], $00
    farcall SendSGBPaletteSetPacket
    jr .loop2

.check_is_cgb:
    ld a, [wIsCGB]
    or a
    jr z, .loop2
    farcall LoadPalette0FromData

.loop2:
    farcall RunSaveSteps
    ld a, [wSaveStep]
    bit 7, a
    jr z, .loop2
    ld a, [wMapType]
    bit 7, a
    jr z, .skip
    farcall LoadKeyWorldFlagsRecordFromSRAMSlotKeyWorldSlot

.skip:
    ld hl, vBGMap0
    ld bc, $1412

.loop3:
    ld a, $c3

.loop4:
    call WriteVRAMByteInc
    dec b
    jr nz, .loop4
    ld a, l
    add $0c
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld b, $14
    dec c
    jr nz, .loop3
    call GameMode5_Init_LoadSRAMRecordWord
    farcall FullyHealParty
    ld a, $fc
    call StartPaletteFade
    ld b, $46
    ld de, Tiles1Gfx
    ld hl, vTiles1
    call DecompressToRAMLocked
    farcall ClearScreenBufferAndAttributes_BankF1
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, $01
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $00
    ldh [hSpriteWindowClipMode], a

.loop5:
    farcall StepTextWindowOpenClose
    ld a, [wTextWindowState]
    and $03
    jr nz, .loop5
    ld hl, wMenuState
    ld bc, $0008
    xor a
    call FillBytes
    ld hl, wTitleScreenState
    ld bc, $0008
    xor a
    call FillBytes
    ld a, $09
    call QueueMusic
    ld a, $07
    ldh [hWindowX], a
    ld a, $ff
    ldh [hWindowY], a
    ld a, $00
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    xor a
    ld [wFrameCounterLo], a
    ld [wFrameCounterHi], a
    xor a
    ld [wSTATSplitEnable], a
    xor a
    ld [wLinkSendByte], a
    xor a
    ld [wLinkMessage], a
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $09
    jp ClearSGBPacketBuffer_CheckLinkMode

; Copies each party member's HP, MP and status from SRAM into wBattleStateBuffer (5 bytes per
; member), then fills the entries of absent members. (C1, E-0357)
GameMode5_Init_LoadSRAMRecordWord::
    ld a, $0a
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList
    ld de, wBattleStateBuffer

.loop:
    push hl
    ld a, [hl]
    ld c, MON_HP
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld [de], a
    inc de
    ldh a, [hTemp1]
    ld [de], a
    inc de
    ld a, [hl]
    ld c, MON_MP
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld [de], a
    inc de
    ldh a, [hTemp1]
    ld [de], a
    inc de
    ld a, [hl]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    ld [de], a
    inc de
    pop hl
    inc hl
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a
    ld a, [wPartyCount]
    cp $03
    ret z
    ld a, $ff
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ret

; game mode 5 (the title screen, new-player set-up and link set-up): by wModeState it loads the
; screens, waits for the fade, then exchanges joypad state over the link each frame
; (LinkExchangeJoypadPerFrame) (E-0354; was: per-frame routine for wGameMode = 5)
GameMode5_Update::
    ld a, [wModeState]
    jumptable
    dw GameMode5_Update_LoadScreens
    dw GameMode5_Update_WaitFadeState
    dw GameMode5_Update_LinkExchangeJoypadPerFrame
    dw GameMode5_Update_LinkExchangeJoypadPerFrame_2
    dw GameMode5_Update_LinkExchangeJoypadPerFrame_3
    dw GameMode5_Update_ToGameMode5_Update_LinkExchangeJoypadPerFrame
    dw GameMode5_Update_ToGameMode5_Update_LinkExchangeJoypadPerFrame
    dw GameMode5_Update_2

; Game mode 5 frame, wModeState 5: far-calls GameMode5_Update_LinkExchangeJoypadPerFrame_4. (C1,
; E-0357)
GameMode5_Update_ToGameMode5_Update_LinkExchangeJoypadPerFrame::
    farcall GameMode5_Update_LinkExchangeJoypadPerFrame_4
    ret

; Game mode 5 frame, wModeState 7: far-calls GameMode5_Update_LinkExchangeJoypadPerFrame_5. (C1,
; E-0357)
GameMode5_Update_2::
    farcall GameMode5_Update_LinkExchangeJoypadPerFrame_5
    ret

; blinks the cursor of the list entry [HL] every 8 frames; up/down moves it (wrapping over
; wSubMenuCursor entries) with sound $69 (E-0127)
MoveVerticalCursorInListHL::
    ld a, [wFrameCounterLo]
    and $07
    jr nz, .check_sub_menu_cursor
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, .call_write_bb_tile_at_word_table_entry_c
    call EraseCursorAtEntryHL_Bank07
    jr .check_sub_menu_cursor

.call_write_bb_tile_at_word_table_entry_c:
    call WriteBBTileAtWordTableEntryC_Bank07

.check_sub_menu_cursor:
    ld a, [wSubMenuCursor]
    cp $01
    jr z, .return
    ld c, [hl]
    ld a, [wJoypadPressedRepeat]
    and $40
    jr z, .check_joypad_pressed_repeat
    ld a, [hl]
    dec a
    ld [hl], a
    cp $ff
    jr nz, .clear_frame_counter_lo
    ld a, [wSubMenuCursor]
    dec a
    ld [hl], a
    jr .clear_frame_counter_lo

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and $80
    jr z, .return
    ld a, [wSubMenuCursor]
    dec a
    inc [hl]
    cp [hl]
    ccf
    jr c, .clear_frame_counter_lo
    xor a
    ld [hl], a
    jr .clear_frame_counter_lo

.return:
    ret

.clear_frame_counter_lo:
    xor a
    ld [wFrameCounterLo], a
    call WriteC3TileAtWordTableEntryC_Bank07
    ld a, $69
    call QueueSoundEffect
    call WriteBBTileAtWordTableEntryC_Bank07
    ret

; A blinking cursor that Left/Right move through a list: every 8 frames the cursor tile at entry
; [HL] alternates with a blank; Left and Right change [HL], wrapping within wSubMenuCursor2 entries,
; and redraw it. (C1, E-0357)
RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07::
    ld a, [wFrameCounterLo]
    and $07
    jr nz, .check_joypad_pressed_repeat
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, .call_write_bb_tile_at_word_table_entry_c
    call EraseCursorAtEntryHL_Bank07
    jr .check_joypad_pressed_repeat

.call_write_bb_tile_at_word_table_entry_c:
    call WriteBBTileAtWordTableEntryC_Bank07

.check_joypad_pressed_repeat:
    ld c, [hl]
    ld a, [wJoypadPressedRepeat]
    and $20
    jr z, .check_joypad_pressed_repeat2
    ld a, [hl]
    dec a
    ld [hl], a
    cp $ff
    jr nz, .clear_frame_counter_lo
    ld a, [wSubMenuCursor2]
    dec a
    ld [hl], a
    jr .clear_frame_counter_lo

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    and $10
    jr z, .return
    ld a, [wSubMenuCursor2]
    dec a
    inc [hl]
    cp [hl]
    ccf
    jr c, .clear_frame_counter_lo
    xor a
    ld [hl], a
    jr .clear_frame_counter_lo

.return:
    ret

.clear_frame_counter_lo:
    xor a
    ld [wFrameCounterLo], a
    call WriteC3TileAtWordTableEntryC_Bank07
    ld a, $69
    call QueueSoundEffect
    call WriteBBTileAtWordTableEntryC_Bank07
    ret

; C = [HL]; writes the cursor tile $BB at the VRAM address in entry C of the word table at DE,
; waiting for VRAM access (E-0124)
WriteBBTileAtWordTableEntryC_Bank07::
    ld c, [hl]
    push hl
    ld a, c
    add a
    add e
    ld l, a
    ld a, $00
    adc d
    ld h, a
    deref_hl
    ld a, $bb
    push af

.loop:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    pop af
    ld [hl], a
    pop hl
    ret

; C = [HL], then falls into WriteC3TileAtWordTableEntryC_Bank07 (E-0126)
EraseCursorAtEntryHL_Bank07::
    ld c, [hl]

; writes the blank tile $C3 at the VRAM address in entry C of the word table at DE, waiting for VRAM
; access (E-0124)
WriteC3TileAtWordTableEntryC_Bank07::
    push hl
    ld a, c
    add a
    add e
    ld l, a
    ld a, $00
    adc d
    ld h, a
    deref_hl
    ld a, $c3
    push af

.loop:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    pop af
    ld [hl], a
    pop hl
    ret

; menu code in bank $07 passes $5086, $5096, $509E, $50AA ... $50FA to
; WriteBCTileAtWordTableEntry_Bank07, EraseCursorAtEntryHL_Bank07 and MoveVerticalCursorInListHL;
; each run indexed by a menu position; 60 words in all (E-0220, C1)
; record: 60 BG map addresses, used in runs of up to 8 by the menus of bank $07
CursorPositionWords_Bank07::
    dw vBGMap0 + $21, vBGMap0 + $61, vBGMap0 + $a1, vBGMap0 + $e1, vBGMap0 + $121, vBGMap0 + $161, vBGMap0 + $1a1, vBGMap0 + $1e1 ; entry 0
    dw vBGMap0 + $a3, vBGMap0 + $e3, vBGMap0 + $123, vBGMap0 + $163, vBGMap0 + $61, vBGMap0 + $c1, vBGMap0 + $101, vBGMap0 + $141
    dw vBGMap0 + $181, vBGMap0 + $1c1, vBGMap0 + $68, vBGMap0 + $6e, vBGMap0 + $ce, vBGMap0 + $d1, vBGMap0 + $10e, vBGMap0 + $111
    dw vBGMap0 + $14e, vBGMap0 + $151, vBGMap0 + $18e, vBGMap0 + $191, vBGMap0 + $1ce, vBGMap0 + $1d1, vBGMap0 + $81, vBGMap0 + $c1
    dw vBGMap0 + $101, vBGMap0 + $141, vBGMap0 + $181, vBGMap0 + $1c1, vBGMap0 + $201, vBGMap0 + $8c, vBGMap0 + $8e, vBGMap0 + $90
    dw vBGMap0 + $cc, vBGMap0 + $ce, vBGMap0 + $d0, vBGMap0 + $10c, vBGMap0 + $10e, vBGMap0 + $110, vBGMap0 + $14c, vBGMap0 + $14e
    dw vBGMap0 + $150, vBGMap0 + $18c, vBGMap0 + $18e, vBGMap0 + $190, vBGMap0 + $1cc, vBGMap0 + $1ce, vBGMap0 + $1d0, vBGMap0 + $20c
    dw vBGMap0 + $20e, vBGMap0 + $210, vBGMap0 + $101, vBGMap0 + $141

; HL = table of VRAM addresses, A = index: writes tile $BC at the address in entry A (WriteVRAMByte)
; (E-0067) (the same 15 bytes appear in 3 banks)
WriteBCTileAtWordTableEntry_Bank07::
    add a
    add_a_to_hl
    deref_hl
    ld a, $bc
    call WriteVRAMByte
    ret

; writes blank tile $C3 to the 20 x 18 visible area of vBGMap0 (E-0124)
ClearBGMap0Screen20x18::
    ld hl, vBGMap0
    ld bc, $1412
    ld a, $c3

.loop:
    call WriteVRAMByteInc
    dec b
    jr nz, .loop
    ld a, l
    add $0c
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, $c3
    ld b, $14
    dec c
    jr nz, .loop
    ret

; wStringCategory = H, wStringIndex = L, then far-calls BeginStringDisplay_Bank07 (E-0114)
ShowStringHL_Bank07::
    ld a, h
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank07
    ret

; Shows string H:L (category H, index L) with ShowString_Bank07. (C1, E-0357)
GameMode5_Init_ShowString_Bank07::
    ld a, h
    ld [wStringCategory], a
    ld a, l
    ld [wStringIndex], a
    farcall ShowString_Bank07
    ret

; after CheckSaveData, GameMode5_Init_InitSoundHardware.call_fill_screen_tile_buffer_with_d reads
; the word at $5149 + 2 * hTemp0 (hTemp0 >= 1) and passes it to CopyRecordRectToScreenBuffer_Bank07;
; three words, so index 3 would read the offset word ($0000) of TileRect_SaveCheckScreenRects_0,
; which follows; entry 0 is not read on that path (E-0220, C1)
; record: rectangle record for this CheckSaveData result ($0000 = none)
SaveCheckScreenRects::
    dw TileRect_SaveCheckScreenRects_0 ; id 0
    dw TileRect_SaveCheckScreenRects_1 ; id 1
    dw TileRect_SaveCheckScreenRects_2 ; id 2

; a rectangle record of SaveCheckScreenRects, in the CopyRecordRectToScreenBuffer_Bank07 format:
; offset, width, rows, tiles (E-0220, C1)
; record: offset $0000; 12 x 15 tiles
TileRect_SaveCheckScreenRects_0::
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $0c, $0f ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $00, $01, $02, $03, $04, $05, $06, $07, $08, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $09, $0a, $0b, $0c, $0d, $0e, $0f, $10, $11, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $c3, $12, $13, $14, $15, $16, $17, $18, $19, $1a, $b7 ; row 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 6
    db $b6, $c3, $1b, $1c, $1d, $1e, $1f, $20, $21, $22, $23, $b7 ; row 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 8
    db $b6, $c3, $24, $25, $26, $27, $28, $29, $2a, $2b, $2c, $b7 ; row 9
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 10
    db $b6, $c3, $70, $71, $72, $73, $74, $75, $76, $77, $78, $b7 ; row 11
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 12
    db $b6, $c3, $2d, $2e, $2f, $30, $31, $32, $33, $34, $35, $b7 ; row 13
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 14

; a tile-rectangle record for CopyRecordRectToScreenBuffer_Bank07 (E-0161)
; record: offset $0000 (row 0, column 0); 12 x 17 tiles
TileRect07_1::
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $0c, $11 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $00, $01, $02, $03, $04, $05, $06, $07, $08, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $09, $0a, $0b, $0c, $0d, $0e, $0f, $10, $11, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $c3, $12, $13, $14, $15, $16, $17, $18, $19, $1a, $b7 ; row 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 6
    db $b6, $c3, $1b, $1c, $1d, $1e, $1f, $20, $21, $22, $23, $b7 ; row 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 8
    db $b6, $c3, $24, $25, $26, $27, $28, $29, $2a, $2b, $2c, $b7 ; row 9
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 10
    db $b6, $c3, $70, $71, $72, $73, $74, $75, $76, $77, $78, $b7 ; row 11
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 12
    db $b6, $c3, $2d, $2e, $2f, $30, $31, $32, $33, $34, $35, $b7 ; row 13
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 14
    db $b6, $c3, $36, $37, $38, $39, $3a, $3b, $3c, $3d, $3e, $b7 ; row 15
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 16

; record: offset $0000; 12 x 3 tiles
TileRect_SaveCheckScreenRects_1::
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $0c, $03 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $09, $0a, $0b, $0c, $0d, $0e, $0f, $10, $11, $b7 ; row 1
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 2

; a rectangle record of SaveCheckScreenRects, in the CopyRecordRectToScreenBuffer_Bank07 format:
; offset, width, rows, tiles (E-0220, C1)
; record: offset $01A0; 20 x 5 tiles
TileRect_SaveCheckScreenRects_2::
    dw $01a0 ; entry 0: offset into wScreenTileBuffer
    db $14, $05 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8a, $8b, $8c, $8d, $8e, $8f, $90, $91, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $92, $93, $94, $95, $96, $97, $98, $99, $9a, $9b, $9c, $9d, $9e, $9f, $a0, $a1, $a2, $a3, $b7 ; row 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 4

; a tile-rectangle record for CopyRecordRectToScreenBuffer_Bank07 (E-0161)
; record: offset $0060 (row 3, column 0); 20 x 11 tiles
TileRect07_2::
    dw $0060 ; entry 0: offset into wScreenTileBuffer
    db $14, $0b ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $68, $69, $6a, $6b, $6c, $6d, $ed, $40, $41, $42, $43, $44, $c3, $c3, $c3, $ed, $c3, $c3, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $45, $46, $47, $48, $49, $4a, $c3, $ea, $ed, $c3, $c3, $c3, $c3, $c3, $57, $58, $c3, $c3, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $59, $5a, $c3, $c3, $b7 ; row 4
    db $b6, $4b, $4c, $4d, $4e, $4f, $50, $c3, $ea, $ed, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 6
    db $b6, $51, $52, $53, $54, $55, $56, $c3, $ea, $ed, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 8
    db $b6, $5b, $5c, $5d, $5e, $5f, $60, $61, $62, $63, $64, $65, $66, $67, $c3, $c3, $c3, $c3, $c3, $b7 ; row 9
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 10

; record: offset $0082 (row 4, column 2); 16 x 9 tiles
TileRect07_3::
    dw $0082 ; entry 0: offset into wScreenTileBuffer
    db $10, $09 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $c3, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4a, $c3, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $c3, $4b, $4c, $4d, $4e, $4f, $50, $51, $52, $53, $54, $55, $c3, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $c3, $c3, $56, $57, $58, $59, $5a, $5b, $5c, $5d, $5e, $5f, $60, $c3, $b7 ; row 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 6
    db $b6, $c3, $c3, $61, $62, $63, $64, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 8

; record: offset $0020 (row 1, column 0); 20 x 16 tiles
TileRect07_4::
    dw $0020 ; entry 0: offset into wScreenTileBuffer
    db $14, $10 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 1
    db $b6, $c3, $0c, $0b, $15, $15, $10, $0d, $c3, $14, $15, $0b, $13, $15, $c3, $0d, $16, $0f, $15, $b7 ; row 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $c3, $14, $1e, $1d, $1f, $1f, $c3, $10, $1d, $20, $1d, $23, $c3, $c3, $17, $c3, $c3, $11, $b7 ; row 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 6
    db $b6, $c3, $10, $1a, $25, $1a, $1f, $c3, $10, $1d, $20, $1d, $23, $c3, $c3, $17, $c3, $c3, $11, $b7 ; row 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 8
    db $b6, $c3, $0e, $18, $20, $1d, $1f, $27, $10, $1d, $20, $1d, $23, $c3, $c3, $17, $c3, $c3, $11, $b7 ; row 9
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 10
    db $b6, $c3, $15, $24, $22, $21, $c3, $10, $1d, $20, $1d, $23, $c3, $c3, $c3, $17, $c3, $c3, $11, $b7 ; row 11
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 12
    db $b6, $c3, $0d, $26, $19, $1c, $18, $21, $1b, $1a, $c3, $c3, $c3, $c3, $c3, $17, $c3, $c3, $11, $b7 ; row 13
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 14
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 15

; record: offset $0000 (row 0, column 0); 20 x 18 tiles
TileRect07_5::
    dw $0000 ; entry 0: offset into wScreenTileBuffer
    db $14, $12 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $c3, $c3, $14, $28, $0f, $10, $10, $c3, $10, $0f, $29, $0f, $15, $c3, $c3, $c3, $c3, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $10, $0f, $29, $0f, $15, $c3, $b7 ; row 3
    db $b6, $c3, $0b, $23, $1e, $c3, $29, $18, $1b, $1d, $19, $c3, $c3, $e0, $c3, $e1, $c3, $11, $2c, $b7 ; row 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 5
    db $b6, $c3, $14, $24, $2b, $2b, $2c, $22, $23, $c3, $c3, $c3, $c3, $e0, $c3, $e1, $c3, $11, $2c, $b7 ; row 6
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 7
    db $b6, $c3, $13, $1a, $19, $2c, $25, $1a, $22, $c3, $c3, $c3, $c3, $e0, $c3, $e1, $c3, $11, $2c, $b7 ; row 8
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 9
    db $b6, $c3, $0c, $22, $1a, $18, $23, $1c, $c3, $c3, $c3, $c3, $c3, $e0, $c3, $e1, $c3, $11, $2c, $b7 ; row 10
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 11
    db $b6, $c3, $2a, $18, $21, $19, $1a, $c3, $c3, $c3, $c3, $c3, $c3, $e0, $c3, $e1, $c3, $11, $2c, $b7 ; row 12
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 13
    db $b6, $c3, $0b, $23, $1e, $c3, $14, $1e, $1d, $1f, $1f, $c3, $c3, $e0, $c3, $e1, $c3, $11, $2c, $b7 ; row 14
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 15
    db $b6, $c3, $29, $1a, $1b, $18, $20, $18, $1b, $1d, $19, $c3, $c3, $e0, $c3, $e1, $c3, $11, $2c, $b7 ; row 16
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 17

; a tile-rectangle record for CopyRecordRectToScreenBuffer_Bank07 (E-0161)
; record: offset $00E0 (row 7, column 0); 20 x 5 tiles
RunLinkSession4ScreenState_EditRules_TileRect::
    dw $00e0 ; entry 0: offset into wScreenTileBuffer
    db $14, $05 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $15, $2c, $23, $18, $1f, $c3, $10, $1a, $25, $1a, $1f, $2d, $c3, $c3, $c3, $c3, $c3, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $29, $18, $26, $c3, $10, $1a, $25, $1a, $1f, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 4

; record: offset $0062 (row 3, column 2); 15 x 11 tiles
RunLinkSession4ScreenState_EditRules_CopyRecordRectToScreenBuffer_Bank07AndStep_TileRect::
    dw $0062 ; entry 0: offset into wScreenTileBuffer
    db $0f, $0b ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $c3, $0b, $25, $18, $1d, $1f, $1d, $2e, $1f, $1a, $c3, $c3, $b7 ; row 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 2
    db $b6, $c3, $c3, $0e, $18, $20, $1d, $1f, $1d, $1a, $2d, $c3, $c3, $c3, $b7 ; row 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 4
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 5
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 6
    db $b6, $c3, $00, $c3, $01, $c3, $02, $c3, $03, $c3, $04, $c3, $05, $c3, $b7 ; row 7
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 8
    db $b6, $c3, $06, $c3, $07, $c3, $08, $c3, $09, $c3, $0a, $c3, $c3, $c3, $b7 ; row 9
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 10

; record: offset $00E1 (row 7, column 1); 18 x 5 tiles
RunLinkSession4ScreenState_EditRules_CopyRecordRectToScreenBuffer_Bank07AndStep_2_TileRect::
    dw $00e1 ; entry 0: offset into wScreenTileBuffer
    db $12, $05 ; width, rows
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; row 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 1
    db $b6, $15, $24, $22, $21, $c3, $10, $1d, $20, $1d, $23, $c3, $c3, $c5, $c3, $c3, $c6, $b7 ; row 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; row 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; row 4

; CopyBytes copies these 8 bytes to wOBJPaletteBuffer + $20 (E-0264)
; record: 8 bytes copied to wOBJPaletteBuffer + $20
OBJPaletteBufferPlus20Init::
    db $de, $67, $1f, $33, $3c, $12, $00, $00 ; entry 0

; by wTitleScreenState: steps that decompress screen graphics (two DecompressToVRAM each), one with
; music, and RunGameMode5Case00SubStates (E-0303)
GameMode5_Update_LoadScreens::
    ld a, [wTitleScreenState]
    jumptable
    dw GameMode5_Update_LoadScreens_Screen0
    dw GameMode5_Update_LoadScreens_Screen1
    dw GameMode5_Update_LoadScreens_Screen2
    dw GameMode5_Update_LoadScreens_RunGameMode5Case00SubStates
    dw GameMode5_Update_LoadScreens_ScreenWithMusic

; two DecompressToVRAM steps, then the next link sub-state (E-0304)
GameMode5_Update_LoadScreens_Screen0::
    ld a, [wTitleScreenSubState]
    jumptable
    dw GameMode5_Update_LoadScreens_Screen0_DecompressToVRAM
    dw GameMode5_Update_LoadScreens_Screen0_DecompressToVRAM
    dw GameMode5_Update_WriteWorkBufAndTitleScreenSubState

; Intro screen 0, step 0: after the first call, decompresses the screen's tiles, map and (on CGB)
; attributes and palettes, draws them, resets the palettes and fades in; then starts the screen's
; timer. (C1, E-0357)
GameMode5_Update_LoadScreens_Screen0_DecompressToVRAM::
    ld a, [wTitleScreenSubState]
    or a
    jr z, .skip
    ld b, $e1
    ld de, Tiles2Gfx_4
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $e1
    ld de, GameMode5_Update_LoadScreens_Screen0_ScreenTileBufferGfx
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a
    jr z, .call_draw_full_screen_buffer_to_bg_map
    ld a, $02
    ldh [rSVBK], a
    ld b, $e1
    ld de, GameMode5_Update_LoadScreens_Screen0_ScreenAttrBufferGfx
    ld hl, wScreenAttrBuffer
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $e1
    ld de, GameMode5_Update_LoadScreens_Screen0_BGPaletteBufferData
    ld hl, wBGPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM

.call_draw_full_screen_buffer_to_bg_map:
    ld hl, vBGMap0
    call DrawFullScreenBufferToBGMap
    call ResetLinkScreenPalettes
    ld a, $fc
    call StartPaletteFade

.skip:
    ld hl, wTitleScreenSubState
    inc [hl]
    xor a
    ld [wWorkBuf], a
    ld [wWorkBuf + $1], a
    ret

; Intro screen 0, step 2: shows the screen for three seconds (60-frame units in wWorkBuf + 1), then
; goes to intro screen 1; after two seconds A, B or Start skips ahead. (C1, E-0357)
GameMode5_Update_WriteWorkBufAndTitleScreenSubState::
    ld a, [wWorkBuf]
    inc a
    ld [wWorkBuf], a
    cp $3c
    jr c, .check_joypad_pressed
    xor a
    ld [wWorkBuf], a
    ld a, [wWorkBuf + $1]
    inc a
    ld [wWorkBuf + $1], a
    cp $03
    jr nc, StartFadeToLinkScreenState1_Skip
    cp $02
    ret c

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $0b
    ret

; wTitleScreenSubState = 0, wTitleScreenState = 1 and starts palette fade 4; the following entry
; advances wTitleScreenState instead (E-0122)
StartFadeToLinkScreenState1::
    xor a
    ld [wTitleScreenSubState], a
    ld a, $01
    ld [wTitleScreenState], a
    ld a, $04
    call StartPaletteFade
    ret

; Starts the next intro screen: wTitleScreenState + 1, sub-state 0, fade out. (C1, E-0357)
StartFadeToLinkScreenState1_Skip::
    ld hl, wTitleScreenState
    inc [hl]
    xor a
    ld [wTitleScreenSubState], a
    ld a, $04
    call StartPaletteFade
    ret

; two DecompressToVRAM steps, then the next link sub-state (E-0304)
GameMode5_Update_LoadScreens_Screen1::
    ld a, [wTitleScreenSubState]
    jumptable
    dw GameMode5_Update_LoadScreens_Screen1_DecompressToVRAM
    dw GameMode5_Update_LoadScreens_Screen1_DecompressToVRAM
    dw GameMode5_Update_LoadScreens_WriteWorkBufAndTitleScreenSubState

; Intro screen 1, step 0: decompresses and draws its tiles, map, attributes and palettes, then fades
; in. (C1, E-0357)
GameMode5_Update_LoadScreens_Screen1_DecompressToVRAM::
    ld a, [wTitleScreenSubState]
    or a
    jr z, .skip
    ld b, $e1
    ld de, Tiles2Gfx_5
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $e1
    ld de, GameMode5_Update_LoadScreens_Screen1_ScreenTileBufferGfx
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a
    jr z, .call_draw_full_screen_buffer_to_bg_map
    ld a, $02
    ldh [rSVBK], a
    ld b, $e1
    ld de, GameMode5_Update_LoadScreens_Screen1_ScreenAttrBufferGfx
    ld hl, wScreenAttrBuffer
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $e1
    ld de, GameMode5_Update_LoadScreens_Screen1_BGPaletteBufferData
    ld hl, wBGPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM

.call_draw_full_screen_buffer_to_bg_map:
    ld hl, vBGMap0
    call DrawFullScreenBufferToBGMap
    call ResetLinkScreenPalettes
    ld a, $fc
    call StartPaletteFade

.skip:
    ld hl, wTitleScreenSubState
    inc [hl]
    xor a
    ld [wWorkBuf], a
    ld [wWorkBuf + $1], a
    ret

; Intro screen 1, step 2: shows it for three seconds (A, B or Start skip after two), then intro
; screen 2. (C1, E-0357)
GameMode5_Update_LoadScreens_WriteWorkBufAndTitleScreenSubState::
    ld a, [wWorkBuf]
    inc a
    ld [wWorkBuf], a
    cp $3c
    jr c, .check_joypad_pressed
    xor a
    ld [wWorkBuf], a
    ld a, [wWorkBuf + $1]
    inc a
    ld [wWorkBuf + $1], a
    cp $03
    jr nc, StartFadeToLinkScreenState2_Skip
    cp $02
    ret c

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $0b
    ret

; wTitleScreenSubState = 0, wTitleScreenState = 2 and starts palette fade 4; the following entry
; advances wTitleScreenState instead (E-0122)
StartFadeToLinkScreenState2::
    xor a
    ld [wTitleScreenSubState], a
    ld a, $02
    ld [wTitleScreenState], a
    ld a, $04
    call StartPaletteFade
    ret

; Starts the next intro screen: wTitleScreenState + 1, sub-state 0, fade out. (C1, E-0357)
StartFadeToLinkScreenState2_Skip::
    ld hl, wTitleScreenState
    inc [hl]
    xor a
    ld [wTitleScreenSubState], a
    ld a, $04
    call StartPaletteFade
    ret

; two DecompressToVRAM steps, then a palette fade (E-0304)
GameMode5_Update_LoadScreens_Screen2::
    ld a, [wTitleScreenSubState]
    jumptable
    dw GameMode5_Update_LoadScreens_Screen2_DecompressToVRAM
    dw GameMode5_Update_LoadScreens_Screen2_DecompressToVRAM
    dw GameMode5_Update_LoadScreens_Screen2_StartPaletteFade

; Intro screen 2, step 0: decompresses and draws its tiles, map, attributes and palettes, then fades
; in. (C1, E-0357)
GameMode5_Update_LoadScreens_Screen2_DecompressToVRAM::
    ld a, [wTitleScreenSubState]
    or a
    jr z, .skip
    ld b, $e1
    ld de, Tiles2Gfx_6
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $e1
    ld de, GameMode5_Update_LoadScreens_Screen2_ScreenTileBufferGfx
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a
    jr z, .call_draw_full_screen_buffer_to_bg_map
    ld a, $02
    ldh [rSVBK], a
    ld b, $e1
    ld de, GameMode5_Update_LoadScreens_Screen2_ScreenAttrBufferGfx
    ld hl, wScreenAttrBuffer
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $e1
    ld de, GameMode5_Update_LoadScreens_Screen2_BGPaletteBufferData
    ld hl, wBGPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM

.call_draw_full_screen_buffer_to_bg_map:
    ld hl, vBGMap0
    call DrawFullScreenBufferToBGMap
    call ResetLinkScreenPalettes
    ld a, $fc
    call StartPaletteFade

.skip:
    ld hl, wTitleScreenSubState
    inc [hl]
    xor a
    ld [wWorkBuf], a
    ld [wWorkBuf + $1], a
    ret

; Intro screen 2, step 2: after $5A frames goes on to the next state; after $3C frames A, B or Start
; jump straight to state 3 (the title opening). (C1, E-0357)
GameMode5_Update_LoadScreens_Screen2_StartPaletteFade::
    ld a, [wWorkBuf]
    inc a
    ld [wWorkBuf], a
    cp $5a
    jr nc, .clear_work_buf
    cp $3c
    ret c
    ld a, [wJoypadPressed]
    and $0b
    ret z
    xor a
    ld [wWorkBuf], a
    xor a
    ld [wTitleScreenSubState], a
    ld a, $03
    ld [wTitleScreenState], a
    ld a, $04
    call StartPaletteFade
    ret

.clear_work_buf:
    xor a
    ld [wWorkBuf], a
    ld hl, wTitleScreenState
    inc [hl]
    xor a
    ld [wTitleScreenSubState], a
    ld a, $04
    call StartPaletteFade
    ret

; Title state 3: runs the title opening (RunGameMode5Case00SubStates); A, B or Start skip it to
; state 4. (C1, E-0357)
GameMode5_Update_LoadScreens_RunGameMode5Case00SubStates::
    ld a, [wJoypadPressed]
    and $0b
    jr z, RunGameMode5Case00SubStates
    call RunGameMode5Case00SubStates
    ld a, $04
    ld [wTitleScreenState], a
    xor a
    ld [wTitleScreenSubState], a
    ld a, $04
    call StartPaletteFade
    ret

; the opening of the title screen (game mode 5, state 0): by wTitleScreenSubState it decompresses
; the graphics, scrolls the title in (the scroll bytes in wWorkBuf), draws the logo meta-sprite and
; fades (E-0354; was: runs the routine for wTitleScreenSubState (jump table of nine sub-states)
; (E-0122))
RunGameMode5Case00SubStates::
    ld a, [wTitleScreenSubState]
    jumptable
    dw RunGameMode5Case00SubStates_DecompressToVRAM
    dw RunGameMode5Case00SubStates_ReadWordTableEntry_Bank00
    dw RunGameMode5Case00SubStates_DrawMetaSprite0AtX50YWorkBuf1
    dw RunGameMode5Case00SubStates_DrawMetaSprite0AtX50YWorkBuf1_2
    dw RunGameMode5Case00SubStates_DecompressToVRAM_RunGameMode5Case00SubStates_ReadWorkBufAndTitleScreenSubState
    dw RunGameMode5Case00SubStates_StartPaletteFade
    dw RunGameMode5Case00SubStates_DecompressToVRAM_2
    dw RunGameMode5Case00SubStates_ReadWordTableEntry_Bank00_2
    dw RunGameMode5Case00SubStates_StartPaletteFade_ReadWorkBufAndTitleScreenSubState

; Title opening, step 0: after the fade decompresses the sprite tiles, clears tiles and both BG maps
; (and the CGB attributes), and sets up the falling stars. (C1, E-0357)
RunGameMode5Case00SubStates_DecompressToVRAM::
    ld a, [wFadeState]
    or a
    ret nz
    ld b, $7e
    ld de, Tiles0Gfx
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, $7e
    ld de, Tiles0Plus100Gfx
    ld hl, vTiles0 + $100
    call DecompressToVRAM
    ld b, $10
    ld hl, vTiles2

.loop:
    di
    ld a, $ff
    call WriteVRAMByteInc
    ei
    dec b
    jr nz, .loop
    ld hl, vBGMap0
    ld bc, $0400

.loop2:
    di
    ld a, $00
    call WriteVRAMByteInc
    ei
    dec bc
    ld a, b
    or c
    jr nz, .loop2
    ld a, [wIsCGB]
    or a
    jr z, .skip
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $0400

.loop3:
    di
    ld a, $ff
    call WriteVRAMByteInc
    ei
    dec bc
    ld a, b
    or c
    jr nz, .loop3
    ld a, $00
    ldh [rVBK], a
    xor a
    ld hl, wBGPaletteBuffer
    ld bc, $0040
    call FillBytes
    ld b, $7e
    ld de, LoadPlayerAndFollowerSpriteGraphics_LoadSRAMRecordByte_2
    ld hl, wOBJPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM
    ld b, $7e
    ld de, OBJPaletteBufferPlus8Data_2
    ld hl, wOBJPaletteBuffer + $8
    ld c, $08
    call CopyFromBankWaitVRAM

.skip:
    xor a
    ld hl, wWorkBuf
    ld bc, $004c
    call FillBytes
    lb hl, $e0, $00
    ld a, l
    ld [wWorkBuf], a
    ld a, h
    ld [wWorkBuf + $1], a
    ld a, $01
    ld [wLinkMenuCounter], a
    ld hl, wWorkBuf + $2
    call RunGameMode5Case00SubStates_NextTableByte
    call ResetLinkScreenPalettes
    ld a, $fc
    call StartPaletteFade
    ld a, $dd
    call QueueSoundEffect
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Title opening, step 1: every 8 frames starts another of 10 falling sparkles (positions from a
; table), moving the ones already started. (C1, E-0357)
RunGameMode5Case00SubStates_ReadWordTableEntry_Bank00::
    ld a, [wFadeState]
    or a
    ret nz
    ld a, [wLinkMenuCounter]
    ld b, a
    ld hl, wWorkBuf + $2
    call RunGameMode5Case00SubStates_ReadWorkBufAndTitleScreenSubState
    ld a, [wLinkMenuEntry]
    inc a
    ld [wLinkMenuEntry], a
    and $07
    ret nz
    ld a, [wLinkMenuCounter]
    ld hl, RunGameMode5Case00SubStates_ReadWordTableEntry_Bank00_Data
    call ReadWordTableEntry_Bank00
    call RunGameMode5Case00SubStates_NextTableByte
    ld a, [wLinkMenuCounter]
    inc a
    ld [wLinkMenuCounter], a
    cp $0a
    ret c
    xor a
    ld [wLinkMenuEntry], a
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Title opening, step 2: moves the title sprite down 1/4 pixel per frame (wWorkBuf) until it reaches
; Y $50, keeping the sparkles moving. (C1, E-0357)
RunGameMode5Case00SubStates_DrawMetaSprite0AtX50YWorkBuf1::
    ld a, [wWorkBuf]
    ld l, a
    ld a, [wWorkBuf + $1]
    ld h, a
    ld de, $0040
    add hl, de
    ld a, l
    ld [wWorkBuf], a
    ld a, h
    ld [wWorkBuf + $1], a
    call DrawMetaSprite0AtX50YWorkBuf1
    ld a, [wLinkMenuCounter]
    ld b, a
    ld hl, wWorkBuf + $2
    call RunGameMode5Case00SubStates_ReadWorkBufAndTitleScreenSubState
    ld a, [wWorkBuf + $1]
    cp $50
    ret nz
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Title opening, step 3: keeps the title sprite and sparkles drawn for wLinkMenuEntry frames, then
; fades out. (C1, E-0357)
RunGameMode5Case00SubStates_DrawMetaSprite0AtX50YWorkBuf1_2::
    call DrawMetaSprite0AtX50YWorkBuf1
    ld a, [wLinkMenuCounter]
    ld b, a
    ld hl, wWorkBuf + $2
    call RunGameMode5Case00SubStates_ReadWorkBufAndTitleScreenSubState
    ld a, [wLinkMenuEntry]
    dec a
    ld [wLinkMenuEntry], a
    ret nz
    ld hl, wTitleScreenSubState
    inc [hl]
    ld a, $04
    call StartPaletteFade
    ret

; Title opening, step 4: after the fade decompresses and draws the next screen (tiles, map,
; attributes and palettes) and fades in, waiting $5A frames. (C1, E-0357)
RunGameMode5Case00SubStates_DecompressToVRAM_RunGameMode5Case00SubStates_ReadWorkBufAndTitleScreenSubState::
    ld a, [wLinkMenuCounter]
    ld b, a
    ld hl, wWorkBuf + $2
    ld a, [wFadeState]
    or a
    jp nz, RunGameMode5Case00SubStates_ReadWorkBufAndTitleScreenSubState
    ld b, $e1
    ld de, Tiles2Gfx_8
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $e1
    ld de, RunGameMode5Case00SubStates_ScreenTileBufferGfx
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a
    jr z, .call_draw_full_screen_buffer_to_bg_map
    ld a, $02
    ldh [rSVBK], a
    ld b, $e1
    ld de, RunGameMode5Case00SubStates_ScreenAttrBufferGfx
    ld hl, wScreenAttrBuffer
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $e1
    ld de, RunGameMode5Case00SubStates_ReadWorkBufAndTitleScreenSubState_BGPaletteBufferData
    ld hl, wBGPaletteBuffer
    ld c, $08
    call CopyFromBankWaitVRAM

.call_draw_full_screen_buffer_to_bg_map:
    ld hl, vBGMap0
    call DrawFullScreenBufferToBGMap
    call ResetLinkScreenPalettes
    ld a, $fc
    call StartPaletteFade
    ld hl, wTitleScreenSubState
    inc [hl]
    ld a, $5a
    ld [wWorkBuf], a
    ret

; Title opening, step 5: waits out the $5A frames, then fades out. (C1, E-0357)
RunGameMode5Case00SubStates_StartPaletteFade::
    ld a, [wFadeState]
    or a
    ret nz
    ld a, [wWorkBuf]
    dec a
    ld [wWorkBuf], a
    ret nz
    ld hl, wTitleScreenSubState
    inc [hl]
    ld a, $04
    call StartPaletteFade
    ret

; Title opening, step 6: decompresses the title screen's tiles and both BG map layers and its
; palettes, fades in and clears the sparkle state. (C1, E-0357)
RunGameMode5Case00SubStates_DecompressToVRAM_2::
    ld a, [wFadeState]
    or a
    ret nz
    ld b, $e1
    ld de, Tiles1Gfx_2
    ld hl, vTiles1
    call DecompressToVRAM
    ld b, $e1
    ld de, Tiles2Gfx_7
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $e1
    ld de, BGMap0Gfx
    ld hl, vBGMap0
    call DecompressToVRAM
    ld a, [wIsCGB]
    or a
    jr z, .call_reset_link_screen_palettes
    ld a, $01
    ldh [rVBK], a
    ld b, $e1
    ld de, BGMap0Gfx_2
    ld hl, vBGMap0
    call DecompressToVRAM
    ld a, $00
    ldh [rVBK], a
    ld b, $e1
    ld de, RunGameMode5Case00SubStates_BGPaletteBufferData
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBankWaitVRAM

.call_reset_link_screen_palettes:
    call ResetLinkScreenPalettes
    ld a, $fc
    call StartPaletteFade
    xor a
    ld hl, wWorkBuf
    ld bc, $004c
    call FillBytes
    ld a, $01
    ld [wLinkMenuCounter], a
    lb hl, $68, $00
    ld a, l
    ld [wWorkBuf], a
    ld a, h
    ld [wWorkBuf + $1], a
    ld hl, wWorkBuf + $2
    call RunGameMode5Case00SubStates_NextTableByte
    call SetScrollYFromWorkBuf1
    ldh [rSCY], a
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Title opening, step 7: starts the sparkles again (one every 8 frames, up to 10) and scrolls the
; screen up half a pixel per frame (hScrollY from wWorkBuf + 1). (C1, E-0357)
RunGameMode5Case00SubStates_ReadWordTableEntry_Bank00_2::
    ld a, [wFadeState]
    or a
    ret nz
    ld a, [wLinkMenuCounter]
    ld b, a
    ld hl, wWorkBuf + $2
    call RunGameMode5Case00SubStates_ReadWorkBufAndTitleScreenSubState
    ld a, [wLinkMenuCounter]
    cp $0a
    jr nc, .read_work_buf
    ld a, [wLinkMenuEntry]
    inc a
    ld [wLinkMenuEntry], a
    and $07
    jr nz, .read_work_buf
    ld a, [wLinkMenuCounter]
    ld hl, RunGameMode5Case00SubStates_ReadWordTableEntry_Bank00_Data
    call ReadWordTableEntry_Bank00
    call RunGameMode5Case00SubStates_NextTableByte
    ld a, [wLinkMenuCounter]
    inc a
    ld [wLinkMenuCounter], a
    ret

.read_work_buf:
    ld a, [wWorkBuf]
    ld l, a
    ld a, [wWorkBuf + $1]
    ld h, a
    ld de, $0080
    ld a, l
    sub e
    ld l, a
    ld a, h
    sbc d
    ld h, a
    ld a, l
    ld [wWorkBuf], a
    ld a, h
    ld [wWorkBuf + $1], a
    call SetScrollYFromWorkBuf1
    ld a, [wWorkBuf + $1]
    or a
    ret nz
    ld a, $3c
    ld [wWorkBuf], a
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Title opening, step 8: keeps the sparkles moving for a count of frames, then moves to the next
; title state with a fade. (C1, E-0357)
RunGameMode5Case00SubStates_StartPaletteFade_ReadWorkBufAndTitleScreenSubState::
    ld a, [wLinkMenuCounter]
    ld b, a
    ld hl, wWorkBuf + $2
    call RunGameMode5Case00SubStates_ReadWorkBufAndTitleScreenSubState
    ld a, [wWorkBuf]
    dec a
    ld [wWorkBuf], a
    ret nz
    ld hl, wTitleScreenState
    inc [hl]
    xor a
    ld [wTitleScreenSubState], a
    ld a, $04
    call StartPaletteFade
    ret

; draws metasprite set 0, sub-index 0, at X = $50, Y = wWorkBuf + $1 (E-0122) (E-0340: the address
; in its name read as its RAM name; was DrawMetaSprite0AtX50YWorkBuf1)
DrawMetaSprite0AtX50YWorkBuf1::
    ld a, $50
    ldh [hSpriteOriginX], a
    ld a, [wWorkBuf + $1]
    ldh [hSpriteOriginY], a
    xor a
    ldh [hSpriteSetIndex], a
    ldh [hSpriteSubIndex], a
    ldh [hSpriteTileOffset], a
    ldh [hSpriteAttrXor], a
    farcall DrawMetaSprite
    ret

; hScrollY = wWorkBuf + $1 (E-0114) (E-0340: the address in its name read as its RAM name; was
; SetScrollYFromWorkBuf1)
SetScrollYFromWorkBuf1::
    ld a, [wWorkBuf + $1]
    ldh [hScrollY], a
    ret

; Moves the sparkles: each 6-byte entry from HL (B of them) advances by its kind (falling toward
; wWorkBuf + 1 + $50, rising, or another path) and is drawn. (C1, E-0357)
RunGameMode5Case00SubStates_ReadWorkBufAndTitleScreenSubState::
    push bc
    push hl
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    pop hl
    or a
    jr nz, .skip
    push hl
    inc hl
    inc hl
    inc hl
    ld a, [wWorkBuf + $1]
    add $50
    ld c, a
    ld a, [hl]
    inc a
    ld [hl], a
    cp c
    pop hl
    jr .skip4

.skip:
    dec a
    jr nz, .skip2
    push hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    cp $30
    pop hl
    jr .skip4

.skip2:
    push hl
    inc hl
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    add $40
    ld [hl], a
    pop hl
    jr nz, .skip4
    ld a, [wTitleScreenSubState]
    cp $08
    jr nc, .skip3
    push hl
    inc hl
    inc hl
    inc hl
    ld a, [wWorkBuf + $1]
    ld c, a
    ld a, [hl]
    inc a
    ld [hl], a
    sub $28
    cp c
    pop hl
    jr .skip4

.skip3:
    push hl
    inc hl
    inc hl
    inc hl
    ld a, [wWorkBuf + $1]
    ld c, a
    ld a, [hl]
    inc a
    ld [hl], a
    sub $18
    cp c
    pop hl

.skip4:
    push hl
    call z, RunGameMode5Case00SubStates_NextTableByte
    pop hl
    ld a, [hl]
    inc a
    ld [hli], a
    ld c, a
    ld a, [hl]
    and $03
    push de
    ld de, RunGameMode5Case00SubStates_Data
    add e
    ld e, a
    jr nc, .skip5
    inc d

.skip5:
    ld a, [de]
    pop de
    ld b, a
    ld a, c
    cp b
    jr c, .call_run_game_mode5_case00_sub_states_draw
    ld a, [hl]
    inc a
    ld [hld], a
    xor a
    ld [hli], a

.call_run_game_mode5_case00_sub_states_draw:
    call RunGameMode5Case00SubStates_DrawMetaSprite
    pop bc
    dec b
    jp nz, RunGameMode5Case00SubStates_ReadWorkBufAndTitleScreenSubState
    ret

; Draws one sparkle: frame (entry byte & 3) of meta-sprite set $1E at the entry's X and Y, with tile
; offset $10 and palette 1. (C1, E-0357)
RunGameMode5Case00SubStates_DrawMetaSprite::
    ld a, [hli]
    and $03
    ldh [hSpriteSubIndex], a
    ld a, [hli]
    ldh [hSpriteOriginX], a
    ld a, [hli]
    ldh [hSpriteOriginY], a
    ld a, $1e
    ldh [hSpriteSetIndex], a
    ld a, $10
    ldh [hSpriteTileOffset], a
    ld a, $01
    ldh [hSpriteAttrXor], a
    inc hl
    inc hl
    push hl
    farcall DrawMetaSprite
    pop hl
    ret

; Starts a sparkle entry at HL: a random X ($30-$6F) and a start Y and kind that depend on the
; opening step (falling from the title sprite, from slightly above it, or kind 2). (C1, E-0357)
RunGameMode5Case00SubStates_NextTableByte::
    xor a
    ld [hli], a
    ld [hli], a
    push hl
    call NextTableByte
    pop hl
    and $3f
    add $30
    ld [hli], a
    ld a, [wTitleScreenSubState]
    cp $03
    jr nc, .cp_05
    ld a, [wWorkBuf + $1]
    ld [hli], a
    xor a
    ld [hli], a
    ld [hli], a
    ret

.cp_05:
    cp $05
    jr nc, .read_work_buf
    push hl
    call NextTableByte
    pop hl
    and $3f
    ld e, a
    ld a, [wWorkBuf + $1]
    sub $20
    add e
    ld [hli], a
    ld a, $01
    ld [hli], a
    xor a
    ld [hli], a
    ret

.read_work_buf:
    ld a, [wWorkBuf + $1]
    sub $20
    ld [hli], a
    ld a, $02
    ld [hli], a
    xor a
    ld [hli], a
    ret

; data read by RunGameMode5Case00SubStates (24 bytes) (E-0347)
RunGameMode5Case00SubStates_ReadWordTableEntry_Bank00_Data::
    db $9f, $d0, $a5, $d0, $ab, $d0, $b1, $d0, $b7, $d0, $bd, $d0, $c3, $d0, $c9, $d0
    db $cf, $d0, $d5, $d0, $db, $d0, $e1, $d0

RunGameMode5Case00SubStates_Data::
    db $04, $07, $07, $04

; DecompressToVRAM, QueueMusic, then the next link sub-state (E-0304)
GameMode5_Update_LoadScreens_ScreenWithMusic::
    ld a, [wTitleScreenSubState]
    jumptable
    dw GameMode5_Update_LoadScreens_ScreenWithMusic_DecompressToVRAM
    dw GameMode5_Update_LoadScreens_ScreenWithMusic_QueueMusic
    dw GameMode5_Update_LoadScreens_CheckJoypadPressed

; Title state with music, step 0: after the fade decompresses the title tiles, map, attributes and
; BG and object palettes and draws them. (C1, E-0357)
GameMode5_Update_LoadScreens_ScreenWithMusic_DecompressToVRAM::
    ld a, [wFadeState]
    or a
    ret nz
    ld b, $e1
    ld de, Tiles0Gfx_4
    ld hl, vTiles0
    call DecompressToVRAM
    ld b, $e1
    ld de, Tiles1Gfx_2
    ld hl, vTiles1
    call DecompressToVRAM
    ld b, $e1
    ld de, Tiles2Gfx_7
    ld hl, vTiles2
    call DecompressToVRAM
    ld b, $e1
    ld de, GameMode5_Update_LoadScreens_ScreenTileBufferGfx
    ld hl, wScreenTileBuffer
    call DecompressToRAMLocked
    ld a, [wIsCGB]
    or a
    jr z, .call_draw_full_screen_buffer_to_bg_map
    ld a, $02
    ldh [rSVBK], a
    ld b, $e1
    ld de, GameMode5_Update_LoadScreens_ScreenAttrBufferGfx
    ld hl, wScreenAttrBuffer
    call DecompressToRAMLocked
    ld a, $00
    ldh [rSVBK], a
    ld b, $e1
    ld de, RunGameMode5Case00SubStates_BGPaletteBufferData
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBankWaitVRAM
    ld b, $e1
    ld de, GameMode5_Update_LoadScreens_OBJPaletteBufferData
    ld hl, wOBJPaletteBuffer
    ld c, $10
    call CopyFromBankWaitVRAM

.call_draw_full_screen_buffer_to_bg_map:
    ld hl, vBGMap0
    call DrawFullScreenBufferToBGMap
    call ResetLinkScreenPalettes
    ld a, $fc
    call StartPaletteFade
    ld hl, wTitleScreenSubState
    inc [hl]
    xor a
    ld [wWorkBuf], a
    ld [wWorkBuf + $1], a
    ldh [hScrollY], a
    ret

; Title state with music, step 1: plays music 6 and sets a $B4-frame timer. (C1, E-0357)
GameMode5_Update_LoadScreens_ScreenWithMusic_QueueMusic::
    ld a, [wFadeState]
    or a
    ret nz
    ld a, $b4
    ld [wWorkBuf], a
    ld a, $06
    call QueueMusic
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Title state with music, step 2: A, B or Start go to the title menu (wModeState 1); when the music
; has ended on all channels and the timer has run out it goes back to the intro (state 2). (C1,
; E-0357)
GameMode5_Update_LoadScreens_CheckJoypadPressed::
    ld a, [wJoypadPressed]
    and $0b
    jr nz, .call_start_palette_fade2
    ld a, [wSoundChannel2]
    ld hl, wSoundChannel3
    and [hl]
    ld hl, wSoundChannel4
    and [hl]
    ld hl, wSoundChannel5
    and [hl]
    cp $ff
    ret nz
    ld a, [wWorkBuf]
    dec a
    ld [wWorkBuf], a
    jr z, .call_start_palette_fade
    ret

.call_start_palette_fade:
    ld a, $04
    call StartPaletteFade
    xor a
    ld [wTitleScreenSubState], a
    ld a, $02
    ld [wTitleScreenState], a
    ret

.call_start_palette_fade2:
    ld a, $04
    call StartPaletteFade
    ld a, $01
    ld [wModeState], a
    ld a, $00
    ld [wWorldMapState], a
    ld a, $00
    ld [wGameMode2Arg], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

; on CGB only: draws sprite set 0, sub-index 1, at ($38, $30) through RunBankE1Routine (E-0124)
DrawCGBMetaSpriteAt38_30::
    ld a, [wIsCGB]
    or a
    ret z
    xor a
    ldh [hSpriteSetIndex], a
    ld a, $01
    xor $01
    ldh [hSpriteSubIndex], a
    xor a
    ldh [hSpriteTileOffset], a
    ldh [hSpriteOriginXHi], a
    ldh [hSpriteOriginYHi], a
    ldh [hSpriteAttrXor], a
    ld a, $38
    ldh [hSpriteOriginX], a
    ld a, $30
    ldh [hSpriteOriginY], a
    farcall RunBankE1Routine
    ret

; sets the DMG palettes $D2/$D2/$E2 (also in wDMGPaletteBytes) and resets the fade; on the Super
; Game Boy blanks rBGP/rOBP, sends PAL_SET for wSGBPaletteSet and copies 8 bytes from $58FA to
; wOBJPaletteBuffer + $20 (E-0128)
ResetLinkScreenPalettes::
    ld hl, wDMGPaletteBGP
    ld a, $d2
    ld [hli], a
    ld a, $d2
    ld [hli], a
    ld a, $e2
    ld [hl], a
    ld hl, wDMGPaletteBytes
    ld a, [wDMGPaletteBGP]
    ld [hli], a
    ld a, [wDMGPaletteOBP0]
    ld [hli], a
    ld a, [wDMGPaletteOBP1]
    ld [hl], a
    call ResetFadeFromDMGPaletteBGP
    ld a, [wSGBActive]
    or a
    jr z, .return
    xor a
    ldh [rBGP], a
    ldh [rOBP0], a
    ldh [rOBP1], a
    ld a, [wSGBPaletteSet]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    ld [wSGBPaletteNum0Lo], a
    ld a, h
    ld [wSGBPaletteNum0Hi], a
    inc hl
    ld a, l
    ld [wSGBPaletteNum1Lo], a
    ld a, h
    ld [wSGBPaletteNum1Hi], a
    inc hl
    ld a, l
    ld [wSGBPaletteNum2Lo], a
    ld a, h
    ld [wSGBPaletteNum2Hi], a
    inc hl
    ld a, l
    ld [wSGBPaletteNum3Lo], a
    ld a, h
    ld [wSGBPaletteNum3Hi], a
    ld a, $b1
    ld [wSGBPacketBuffer], a
    ld a, [wSGBAttrFile]
    ld [wSGBPacketBuffer + $1], a
    ld a, $ff
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    farcall LoadSGBObjectPalettesFromPointers
    ld hl, OBJPaletteBufferPlus20Init
    ld de, wOBJPaletteBuffer + $20
    ld bc, $0008
    call CopyBytes

.return:
    ret

; Game mode 5, wModeState 1, the title menu: after any fade runs the screen for wTitleScreenState:
; the menu, the link start, save-data-lost, continue, the link error, the save screens, the new
; player set-up, the link refusal and the duo set-up. (C1, E-0357)
GameMode5_Update_WaitFadeState::
    ld a, [wFadeState]
    and a
    ret nz
    ld a, $02
    ld [wScreenStep], a
    ld a, [wTitleScreenState]
    jumptable
    dw GameMode5_Update_RunGameMode5Case01SubStates
    dw GameMode5_Update_SerialSendByte
    dw GameMode5_Update_SaveDataLost
    dw GameMode5_Update_StartPaletteFade
    dw GameMode5_Update_ShowGameLinkIsNot
    dw GameMode5_Update_SetScreenStep
    dw GameMode5_Update_NewPlayerSetup
    dw GameMode5_Update_ShowGameLinkCannotBe
    dw GameMode5_Update_DuoOwnWL

; Title menu: runs the menu (RunGameMode5Case01SubStates); when it asks to start a link
; (wLinkScreenStep), sends that byte with this console driving the clock and waits for the transfer.
; (C1, E-0357)
GameMode5_Update_RunGameMode5Case01SubStates::
    call RunGameMode5Case01SubStates
    ld a, [wLinkScreenStep]
    or a
    jr z, .return2
    ld a, [wLinkScreenStep]
    ld b, a
    xor a
    ld [wLinkScreenStep], a
    ld a, [wModeChangeRequest]
    or a
    jr nz, .return2
    ld a, $0f
    ld [wGridCursorX], a
    ld a, b
    ld [wLinkTimerLo], a
    call StartSerialTransferInternalClock
    ld a, $01
    ld [wGridCursorX], a

.loop:
    ld a, [wLinkStatus]
    and $03
    cp $03
    jr nz, .loop
    ld a, [wModeChangeRequest]
    and a
    jr nz, .return

.return:
    ret

.return2:
    ret

; the link menu of game mode 5 (state 1): by wTitleScreenSubState it signals the partner over the
; serial port (SerialSendByte), draws the link menu screen and reads the menu choice (E-0354; was:
; runs the routine for wTitleScreenSubState (jump table of three sub-states) (E-0122))
RunGameMode5Case01SubStates::
    ld a, [wTitleScreenSubState]
    jumptable
    dw RunGameMode5Case01SubStates_SerialSendByte
    dw RunGameMode5Case01SubStates_SerialSendByte_SetScreenStep
    dw RunGameMode5Case01SubStates_ReadMenuState

; Title menu, step 0: sends the 'not ready' byte $F4 to a partner, draws the menu (the normal one
; or, with the link setting on, the version with the link entry), sets the cursor range (7 or 8
; entries) and clears the link state. (C1, E-0357)
; code: sets wScreenStep to 0; sets wScreenSubStep to $f4; calls SerialSendByte; sets wScreenStep to
; 1; calls FillBytes; branches on wLinkSetting; calls CopyRecordRectToScreenBuffer_Bank07; calls
; DrawScreenBufferToBGMap0_Bank07; sets wSubMenuCursor to 8; sets wSubMenuCursor2 to 0; copies
; wMenuState to wMenuOption; sets wLinkScreenStep to 0; then 2 more steps (see the code) (E-0347)
RunGameMode5Case01SubStates_SerialSendByte::
    xor a
    ld [wScreenStep], a
    ld a, $f4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, wScreenTileBuffer
    ld bc, $0240
    ld a, $c3
    call FillBytes
    ld hl, TileRect_SaveCheckScreenRects_0
    ld a, [wLinkSetting]
    or a
    jr z, .call_copy_record_rect_to_screen_buffer_bank07
    ld hl, TileRect_SaveCheckScreenRects_0 + $b8

.call_copy_record_rect_to_screen_buffer_bank07:
    call CopyRecordRectToScreenBuffer_Bank07
    call DrawScreenBufferToBGMap0_Bank07
    ld a, [wLinkSetting]
    and $01
    ld a, $07
    jr z, .set_sub_menu_cursor
    ld a, $08

.set_sub_menu_cursor:
    ld [wSubMenuCursor], a
    xor a
    ld [wSubMenuCursor2], a
    ld a, [wMenuState]
    ld [wMenuOption], a
    xor a
    ld [wLinkScreenStep], a
    ld [wLinkTimerLo], a
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Title menu, step 1: keeps sending $F4 while a fade or text runs; otherwise sends the highlighted
; entry's byte each frame ($C0 when A is pressed) so a linked partner sees the choice. Up/Down move
; the cursor (MoveVerticalCursorInListHL). A on a Super Game Boy with entry 2 or later shows message
; 7 and the save frame and goes to state 5; otherwise A marks entries 0-1 (cursor tile and sound
; $69) and moves to step 2, which runs the entry. (C1, E-0357)
RunGameMode5Case01SubStates_SerialSendByte_SetScreenStep::
    ld a, [wFadeState]
    and a
    jr z, .check_text_flags
    xor a
    ld [wScreenStep], a
    ld a, $f4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ret

.check_text_flags:
    ld a, [wTextFlags]
    bit 0, a
    jr z, .check_joypad_pressed
    xor a
    ld [wScreenStep], a
    ld a, $f4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, .call_serial_send_byte
    call SendLinkByteForMenuOption
    jr .check_joypad_pressed2

.call_serial_send_byte:
    ld a, $c0
    call SerialSendByte

.check_joypad_pressed2:
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_menu_option
    ld a, [wSGBActive]
    or a
    jr z, .check_menu_state
    ld a, [wMenuState]
    and $0f
    cp $02
    jr c, .check_menu_state
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, $00
    ld [wStringCategory], a
    ld a, $07
    ld [wStringIndex], a ; 'Game Link cannot be used with'
    farcall BeginStringDisplay_Bank07
    ld hl, TileRect_SaveCheckScreenRects_2
    call CopyRecordRectToScreenBuffer_Bank07
    ld hl, vBGMap0 + $1a0
    ld de, wWindowTileBuffer + $38
    lb bc, $14, $05
    call CopyRect32StrideToVRAM_Bank07
    ld a, $05
    ld [wTitleScreenState], a
    ret

.check_menu_state:
    ld a, [wMenuState]
    and $0f
    ld b, $02
    ld c, $08
    cp c
    jr nc, .skip
    cp b
    ccf

.skip:
    jr c, .skip2
    ld a, [wMenuState]
    ld hl, CursorPositionWords_Bank07
    and $07
    call WriteBCTileAtWordTableEntry_Bank07
    ld a, $69
    call QueueSoundEffect

.skip2:
    ld hl, wTitleScreenSubState
    inc [hl]
    xor a
    ld [wLinkScreenFlag], a
    jr .return

.check_menu_option:
    ld de, CursorPositionWords_Bank07
    ld hl, wMenuState
    ld a, [wMenuOption]
    cp [hl]
    call nz, EraseCursorAtEntryHL_Bank07
    ld a, [wMenuOption]
    ld [hl], a
    call MoveVerticalCursorInListHL
    ld a, [wMenuState]
    ld [wMenuOption], a

.return:
    ret

; wScreenStep = 0, sends the byte at $65BD + (wMenuOption & $0F) through SerialSendByte (stored in
; wScreenSubStep), then wScreenStep = 1 (E-0122)
SendLinkByteForMenuOption::
    ld a, [wMenuOption]
    ld de, SendLinkByteForMenuOption_Data
    and $0f
    add e
    ld e, a
    jr nc, .clear_screen_step
    inc d

.clear_screen_step:
    xor a
    ld [wScreenStep], a
    ld a, [de]
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ret

; Runs the title menu entry chosen (wMenuState & $0F): continue, new game, the link entries and
; others. (C1, E-0357)
RunGameMode5Case01SubStates_ReadMenuState::
    ld a, [wMenuState]
    and $0f
    jumptable
    dw RunGameMode5Case01SubStates_SerialSendByte_2
    dw RunGameMode5Case01SubStates_ClearScreenStateBlock
    dw RunGameMode5Case01SubStates_WriteJoypadReadFlagAndLinkScreenStepEtc
    dw RunGameMode5Case01SubStates_SetJoypadReadFlag
    dw RunGameMode5Case01SubStates_WriteJoypadReadFlagAndLinkScreenStepEtc_SetJoypadReadFlag
    dw RunGameMode5Case01SubStates_4
    dw RunGameMode5Case01SubStates_2
    dw RunGameMode5Case01SubStates_3

; Title menu 'continue': sends $F4, then steps by wLinkScreenFlag: show the save summary, wait for
; the confirmation, load the save. (C1, E-0357)
RunGameMode5Case01SubStates_SerialSendByte_2::
    xor a
    ld [wScreenStep], a
    ld a, $f4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld a, [wLinkScreenFlag]
    jumptable
    dw RunGameMode5Case01SubStates_ShowMaster
    dw RunGameMode5Case01SubStates_FillBytes
    dw RunGameMode5Case01SubStates_RunSaveSteps

; Continue, step 0: draws the save summary: the 'Master' title string, the summary frame and
; graphics with the cursor, and the completion mark. (C1, E-0357)
RunGameMode5Case01SubStates_ShowMaster::
    ld hl, vTiles2 + $680
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0401
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $00
    ld [wStringCategory], a
    ld a, $04
    ld [wStringIndex], a ; 'Master'
    farcall ShowString_Bank07
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
    ld hl, TileRect_SaveCheckScreenRects_2 + $68
    call CopyRecordRectToScreenBuffer_Bank07
    farcall DecompressA4GraphicsAndContinue
    ld a, $bc
    ld [wScreenTileBuffer + $21], a
    call DrawScreenBufferToBGMap0_Bank07
    call RunGameMode5Case01SubStates_WriteRAMGAndRAMBEtc
    ld hl, wLinkScreenFlag
    inc [hl]
    ret

; Continue, step 1: A confirms (starts loading the save), B returns to the menu (blanking the
; screen). (C1, E-0357)
RunGameMode5Case01SubStates_FillBytes::
    ld a, [wJoypadPressed]
    and $01
    jr z, .check_joypad_pressed
    ld hl, wLinkScreenFlag
    inc [hl]
    xor a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    jr .call_run_game_mode5_case01_sub_states_write

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $02
    jr z, .call_run_game_mode5_case01_sub_states_write
    ld hl, wScreenTileBuffer
    ld bc, $0240
    ld a, $c3
    call FillBytes
    xor a
    ld [wLinkScreenFlag], a
    xor a
    ld [wTitleScreenSubState], a
    ret

.call_run_game_mode5_case01_sub_states_write:
    call RunGameMode5Case01SubStates_WriteRAMGAndRAMBEtc
    ret

; Continue, step 2: loads the save (RunSaveSteps until done) and the key world, sets the map size in
; a key world, clears the field return state and timers, puts the followers on the player, picks a
; new encounter countdown and goes to state 3 (start the game). (C1, E-0357)
RunGameMode5Case01SubStates_RunSaveSteps::
    call RunGameMode5Case01SubStates_WriteRAMGAndRAMBEtc
    farcall RunSaveSteps
    ld a, [wSaveStep]
    bit 7, a
    ret z
    farcall LoadKeyWorldFlagsRecordFromSRAMSlotKeyWorldSlot
    ld a, [wMapType]
    bit 7, a
    jr z, .clear_field_return_phase
    cp $80
    jr nz, .clear_field_return_phase
    ld a, [wKeyWorldWidth]
    ld [wMapWidthScreens], a
    ld a, [wKeyWorldHeight]
    ld [wMapHeightScreens], a

.clear_field_return_phase:
    xor a
    ld [wFieldReturnPhase], a
    xor a
    ld [wTalkCountdown], a
    ld [wEncounterDelay], a
    farcall ClearBit1OfPlayerAndObjectFlags
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
    call ClearScreenStateBlock
    farcall PickRandomEncounterCountdownFromTable
    ld a, $03
    ld [wTitleScreenState], a
    ret

; Draws the completion mark on the title save summary: when the save (SRAM bank 1) has a battle
; record and the game was completed, meta-sprite set $29 at (128, 64). (C1, E-0357)
RunGameMode5Case01SubStates_WriteRAMGAndRAMBEtc::
    ld a, $0a
    ld [rRAMG], a
    ld a, $01
    ld [rRAMB], a
    ld a, [wBattlerRecords]
    or a
    jr z, .skip
    ld a, [wTitleGameCompleted]
    or a
    jr z, .skip
    ld a, $29
    ldh [hSpriteSetIndex], a
    xor a
    ldh [hSpriteSubIndex], a
    ldh [hSpriteTileOffset], a
    ldh [hSpriteAttrXor], a
    ld hl, $0080
    ld a, l
    ldh [hSpriteOriginX], a
    ld a, h
    ldh [hSpriteOriginXHi], a
    ld hl, $0040
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, h
    ldh [hSpriteOriginYHi], a
    xor a
    ld [rRAMB], a
    xor a
    ld [rRAMG], a
    farcall DrawMetaSprite
    ret

.skip:
    xor a
    ld [rRAMB], a
    xor a
    ld [rRAMG], a
    ret

; Title menu 'new game': clears the screen state and starts the new player set-up (wTitleScreenState
; 6). (C1, E-0357)
RunGameMode5Case01SubStates_ClearScreenStateBlock::
    call ClearScreenStateBlock
    call InitLinkScreenStateBlock
    ret

; clears the $80 bytes from wScreenState (E-0122)
ClearScreenStateBlock::
    ld hl, wScreenState
    ld b, $80

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop
    ret

; Title menu link entry 2: when the partner has answered ($FF or $FE in wSubMenuCursor2), marks the
; entry and goes to state 4 (or 7 when refused, wGridCursorX = 2); otherwise asks to send link byte
; $F5. (C1, E-0357)
RunGameMode5Case01SubStates_WriteJoypadReadFlagAndLinkScreenStepEtc::
    ld a, [wSubMenuCursor2]
    cp $ff
    jr z, .clear_screen_step
    cp $fe
    jr z, .set_grid_cursor_x_to_02
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $f5
    ld [wLinkScreenStep], a
    ret

.clear_screen_step:
    xor a
    ld [wScreenStep], a
    ld a, $f4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vBGMap0 + $a1
    ld a, $bc
    call WriteTileSound69ThenTitleScreenState4
    ret

.set_grid_cursor_x_to_02:
    ld a, $02
    ld [wGridCursorX], a
    xor a
    ld [wScreenStep], a
    ld a, $f4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vBGMap0 + $a1
    ld a, $bc
    call WriteTileSound69ThenTitleScreenState7
    ret

; writes A to VRAM at HL, plays sound $69, clears wLinkScreenStep and wSubMenuCursor2 and sets
; wTitleScreenState = 7 (E-0122) (E-0340: the address in its name read as its RAM name; was
; WriteTileSound69ThenTitleScreenState7)
WriteTileSound69ThenTitleScreenState7::
    call WriteVRAMByte
    ld a, $69
    call QueueSoundEffect
    xor a
    ld [wLinkScreenStep], a
    ld a, $07
    ld [wTitleScreenState], a
    xor a
    ld [wSubMenuCursor2], a
    ret

; Title menu link entry 3: the same as entry 2 with link byte $F6 and the cursor on the next row.
; (C1, E-0357)
RunGameMode5Case01SubStates_SetJoypadReadFlag::
    ld a, [wSubMenuCursor2]
    cp $ff
    jr z, .clear_screen_step
    cp $fe
    jr z, .set_grid_cursor_x_to_02
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $f6
    ld [wLinkScreenStep], a
    ret

.clear_screen_step:
    xor a
    ld [wScreenStep], a
    ld a, $f4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vBGMap0 + $e1
    ld a, $bc
    call WriteTileSound69ThenTitleScreenState4
    ret

.set_grid_cursor_x_to_02:
    ld a, $02
    ld [wGridCursorX], a
    xor a
    ld [wScreenStep], a
    ld a, $f4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vBGMap0 + $e1
    ld a, $bc
    call WriteTileSound69ThenTitleScreenState7
    ret

; Title menu link entry 4: as entries 2 and 3, sending link byte $B7, cursor on row 9. (C1, E-0357)
RunGameMode5Case01SubStates_WriteJoypadReadFlagAndLinkScreenStepEtc_SetJoypadReadFlag::
    ld a, [wSubMenuCursor2]
    cp $ff
    jr z, .clear_screen_step
    cp $fe
    jr z, .set_grid_cursor_x_to_02
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $b7
    ld [wLinkScreenStep], a
    ret

.clear_screen_step:
    xor a
    ld [wScreenStep], a
    ld a, $f4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vBGMap0 + $121
    ld a, $bc
    call WriteTileSound69ThenTitleScreenState4
    ret

.set_grid_cursor_x_to_02:
    ld a, $02
    ld [wGridCursorX], a
    xor a
    ld [wScreenStep], a
    ld a, $f4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vBGMap0 + $121
    ld a, $bc
    call WriteTileSound69ThenTitleScreenState7
    ret

; Title menu link entry 6: as entry 2, sending link byte $E0, cursor on row 13. (C1, E-0357)
RunGameMode5Case01SubStates_2::
    ld a, [wSubMenuCursor2]
    cp $ff
    jr z, .clear_screen_step
    cp $fe
    jr z, .set_grid_cursor_x_to_02
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $e0
    ld [wLinkScreenStep], a
    ret

.clear_screen_step:
    xor a
    ld [wScreenStep], a
    ld a, $f4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vBGMap0 + $1a1
    ld a, $bc
    call WriteTileSound69ThenTitleScreenState4
    ret

.set_grid_cursor_x_to_02:
    ld a, $02
    ld [wGridCursorX], a
    xor a
    ld [wScreenStep], a
    ld a, $f4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vBGMap0 + $1a1
    ld a, $bc
    call WriteTileSound69ThenTitleScreenState7
    ret

; Title menu link entry 7: as entry 2, sending link byte $F1, cursor on row 15. (C1, E-0357)
RunGameMode5Case01SubStates_3::
    ld a, [wSubMenuCursor2]
    cp $ff
    jr z, .clear_screen_step
    cp $fe
    jr z, .set_grid_cursor_x_to_02
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $f1
    ld [wLinkScreenStep], a
    ret

.clear_screen_step:
    xor a
    ld [wScreenStep], a
    ld a, $f4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vBGMap0 + $1e1
    ld a, $bc
    call WriteTileSound69ThenTitleScreenState4
    ret

.set_grid_cursor_x_to_02:
    ld a, $02
    ld [wGridCursorX], a
    xor a
    ld [wScreenStep], a
    ld a, $f4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vBGMap0 + $1e1
    ld a, $bc
    call WriteTileSound69ThenTitleScreenState7
    ret

; Title menu link entry 5: as entry 2, sending link byte $DC, cursor on row 11. (C1, E-0357)
RunGameMode5Case01SubStates_4::
    ld a, [wSubMenuCursor2]
    cp $ff
    jr z, .clear_screen_step
    cp $fe
    jr z, .set_grid_cursor_x_to_02
    ld a, $00
    ld [wJoypadReadFlag], a
    ld a, $dc
    ld [wLinkScreenStep], a
    ret

.clear_screen_step:
    xor a
    ld [wScreenStep], a
    ld a, $f4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vBGMap0 + $161
    ld a, $bc
    call WriteTileSound69ThenTitleScreenState4
    ret

.set_grid_cursor_x_to_02:
    ld a, $02
    ld [wGridCursorX], a
    xor a
    ld [wScreenStep], a
    ld a, $f4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vBGMap0 + $161
    ld a, $bc
    call WriteTileSound69ThenTitleScreenState7
    ret

; writes A to VRAM at HL, plays sound $69, clears wLinkScreenStep and wSubMenuCursor2 and sets
; wTitleScreenState = 4 (E-0122) (E-0340: the address in its name read as its RAM name; was
; WriteTileSound69ThenTitleScreenState4)
WriteTileSound69ThenTitleScreenState4::
    call WriteVRAMByte
    ld a, $69
    call QueueSoundEffect
    xor a
    ld [wLinkScreenStep], a
    ld a, $04
    ld [wTitleScreenState], a
    xor a
    ld [wSubMenuCursor2], a
    ret

; data read by SendLinkByteForMenuOption (8 bytes) (E-0347)
SendLinkByteForMenuOption_Data::
    db $f4, $f4, $fa, $fb, $fc, $dd, $e1, $f3

; Title state 1, the link start: sends $F4, puts the cursor on entry 1 of a two-entry list and waits
; for A; A starts the link (the rest of the state follows in the code after it). (C1, E-0357)
GameMode5_Update_SerialSendByte::
    xor a
    ld [wScreenStep], a
    ld a, $f4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld a, $01
    ld [wMenuState], a
    ld a, $01
    ld [wSubMenuCursor], a
    ld hl, wWorkBuf
    ld [hl], $00
    ld de, CursorPositionWords_Bank07
    call MoveVerticalCursorInListHL
    ld a, [wJoypadPressed]
    and $01
    ret z

; wTitleScreenState = 6 and the three bytes after it = 0 (E-0114)
InitLinkScreenStateBlock::
    ld hl, wTitleScreenState
    ld a, $06
    ld [hli], a
    xor a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    ret

; by wTitleScreenSubState: 'Saved data has been lost.', then clears memory (E-0293)
GameMode5_Update_SaveDataLost::
    ld a, [wTitleScreenSubState]
    jumptable
    dw GameMode5_Update_SaveDataLost_ShowSavedDataHasBeen
    dw GameMode5_Update_SaveDataLost_ReadSoundChannelSlots
    dw GameMode5_Update_SaveDataLost_FillBytes

; Save data lost, step 0: after the fade shows 'Saved data has been lost' (message 3) and plays
; sound $52. (C1, E-0357)
GameMode5_Update_SaveDataLost_ShowSavedDataHasBeen::
    ld a, [wFadeState]
    or a
    ret nz
    xor a
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a ; 'Saved data has been lost.'
    farcall BeginStringDisplay_Bank07
    ld a, $52
    call QueueMusic
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Save data lost, step 1: waits until the sound has finished on both channels. (C1, E-0357)
GameMode5_Update_SaveDataLost_ReadSoundChannelSlots::
    ld a, [wSoundChannelSlots]
    ld hl, wSoundChannel1
    and [hl]
    cp $ff
    ret nz
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Save data lost, step 2: after the message clears all four SRAM banks and draws the empty save
; frame. (C1, E-0357)
GameMode5_Update_SaveDataLost_FillBytes::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld hl, sRecords
    ld bc, $2000
    xor a
    call FillBytes
    ld a, $01
    ld [rRAMB], a
    ld hl, sRecords
    ld bc, $2000
    xor a
    call FillBytes
    ld a, $02
    ld [rRAMB], a
    ld hl, sRecords
    ld bc, $2000
    xor a
    call FillBytes
    ld a, $03
    ld [rRAMB], a
    ld hl, sRecords
    ld bc, $2000
    xor a
    call FillBytes
    xor a
    ld [rRAMB], a
    xor a
    ld [rRAMG], a
    ld hl, wScreenTileBuffer
    ld bc, $0240
    ld a, $c3
    call FillBytes
    ld hl, TileRect_SaveCheckScreenRects_1
    call CopyRecordRectToScreenBuffer_Bank07
    call DrawScreenBufferToBGMap0_Bank07
    xor a
    ld [wTitleScreenSubState], a
    ld hl, wTitleScreenState
    dec [hl]
    ld a, $09
    call QueueMusic
    ret

; Title state 3, starting the game: sends $F4, fades out and switches to game mode 1 (the field),
; its state 1 when a script is running, 5 in a key world, 0 otherwise. (C1, E-0357)
GameMode5_Update_StartPaletteFade::
    xor a
    ld [wScreenStep], a
    ld a, $f4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld a, $04
    call StartPaletteFade
    ld hl, wGameMode
    ld a, $01
    ld [hli], a
    ld a, [wScriptRunning]
    bit 0, a
    ld a, $01
    jr nz, .skip
    ld a, [wMapType]
    bit 7, a
    ld a, $05
    jr nz, .skip
    ld a, $00

.skip:
    ld [hli], a
    ld a, $00
    ld [hli], a
    ld [hl], $00
    call ClearScreenStateBlock
    ld hl, wModeChangeRequest
    inc [hl]
    ret

; Title state 7, link refused: shows message 7 with the error numbers from wLinkTimerLo,
; wGridCursorY and wScreenState written into the text buffer as digits. (C1, E-0357)
GameMode5_Update_ShowGameLinkCannotBe::
    xor a
    ld [wScreenStep], a
    ld a, $f4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, [wLinkTimerLo]
    ld b, a
    and $f0
    swap a
    ld [wTextBuf0], a
    ld a, b
    and $0f
    ld [wTextBuf0 + $1], a
    ld a, $f0
    ld [wTextBuf0 + $2], a
    ld a, [wGridCursorY]
    ld [wTextBuf0 + $4], a
    ld a, $f0
    ld [wTextBuf0 + $5], a
    ld a, [wScreenState]
    ld b, a
    and $f0
    swap a
    ld [wTextBuf0 + $8], a
    ld a, b
    and $0f
    ld [wTextBuf0 + $9], a
    ld a, $f0
    ld [wTextBuf0 + $a], a
    ld a, $00
    ld [wStringCategory], a
    ld a, $07
    ld [wStringIndex], a ; 'Game Link cannot be used with'
    farcall BeginStringDisplay_Bank07
    ld hl, TileRect_SaveCheckScreenRects_2
    call CopyRecordRectToScreenBuffer_Bank07
    ld hl, vBGMap0 + $1a0
    ld de, wWindowTileBuffer + $38
    lb bc, $14, $05
    call CopyRect32StrideToVRAM_Bank07
    ld a, $05
    ld [wTitleScreenState], a
    ret

; Title state 8, the duo set-up: erases the cursor, restores the menu choice and shows message 8
; with three numbers (wScreenCounter, wGlyphListPos, wGlyphListStart) as digits. (C1, E-0357)
GameMode5_Update_DuoOwnWL::
    xor a
    ld [wScreenStep], a
    ld a, $f4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    call EraseCursorAtEntryHL_Bank07
    ld a, [wMenuOption]
    ld [wMenuState], a
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, [wScreenCounter]
    ld b, a
    and $f0
    swap a
    ld [wTextBuf0], a
    ld a, b
    and $0f
    ld [wTextBuf0 + $1], a
    ld a, $f0
    ld [wTextBuf0 + $2], a
    ld a, [wGlyphListPos]
    ld [wTextBuf0 + $4], a
    ld a, $f0
    ld [wTextBuf0 + $5], a
    ld a, [wGlyphListStart]
    ld b, a
    and $f0
    swap a
    ld [wTextBuf0 + $8], a
    ld a, b
    and $0f
    ld [wTextBuf0 + $9], a
    ld a, $f0
    ld [wTextBuf0 + $a], a
    ld a, $00
    ld [wStringCategory], a
    ld a, $08
    ld [wStringIndex], a ; 'DuoOwnWL:'
    farcall BeginStringDisplay_Bank07
    ld hl, TileRect_SaveCheckScreenRects_2
    call CopyRecordRectToScreenBuffer_Bank07
    ld hl, vBGMap0 + $1a0
    ld de, wWindowTileBuffer + $38
    lb bc, $14, $05
    call CopyRect32StrideToVRAM_Bank07
    ld a, $05
    ld [wTitleScreenState], a
    ret

; Title state 4, link failed: shows 'Game Link is not ...' (message 5) in the window and moves to
; state 5. (C1, E-0357)
GameMode5_Update_ShowGameLinkIsNot::
    xor a
    ld [wScreenStep], a
    ld a, $f4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, $00
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a ; 'Game Link is not ready. Please'
    farcall BeginStringDisplay_Bank07
    ld hl, TileRect_SaveCheckScreenRects_2
    call CopyRecordRectToScreenBuffer_Bank07
    ld hl, vBGMap0 + $1a0
    ld de, wWindowTileBuffer + $38
    lb bc, $14, $05
    call CopyRect32StrideToVRAM_Bank07
    ld hl, wTitleScreenState
    inc [hl]
    ret

; Title state 5: after the message returns to the title menu (state 0). (C1, E-0357)
GameMode5_Update_SetScreenStep::
    xor a
    ld [wScreenStep], a
    ld a, $f4
    ld [wScreenSubStep], a
    call SerialSendByte
    ld a, $01
    ld [wScreenStep], a
    ld a, [wTextFlags]
    or a
    ret nz
    xor a
    ld [wTitleScreenState], a
    ld [wTitleScreenSubState], a
    ret

; by wTitleScreenSubState: fades, sets a flag, runs name entry, then InitGoldAndClearInventory
; (E-0293)
GameMode5_Update_NewPlayerSetup::
    ld a, [wTitleScreenSubState]
    jumptable
    dw GameMode5_Update_NewPlayerSetup_ToStartPaletteFadeAndStep
    dw GameMode5_Update_NewPlayerSetup_DrawFullScreenBufferToBGMap
    dw GameMode5_Update_NewPlayerSetup_WaitFadeState
    dw GameMode5_Update_NewPlayerSetup_SetFlagBit
    dw GameMode5_Update_NewPlayerSetup_AdvanceTitleScreenSubState
    dw GameMode5_Update_NewPlayerSetup_RunNameEntryStateWhenNotFading
    dw GameMode5_Update_NewPlayerSetup_InitGoldAndClearInventory

; New player set-up, step 0: fades out. (C1, E-0357)
GameMode5_Update_NewPlayerSetup_ToStartPaletteFadeAndStep::
    ld a, $04
    call StartPaletteFade
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; New player set-up, step 1: after the fade blanks the screen buffer and attributes, draws them and
; prepares the text window. (C1, E-0357)
GameMode5_Update_NewPlayerSetup_DrawFullScreenBufferToBGMap::
    ld a, [wFadeState]
    or a
    ret nz
    ld a, $c3
    ld hl, wScreenTileBuffer
    ld bc, $02d0
    call FillBytes
    ld a, [wIsCGB]
    or a
    jr z, .call_draw_full_screen_buffer_to_bg_map
    ld a, $02
    ldh [rSVBK], a
    xor a
    ld hl, wScreenAttrBuffer
    ld bc, $02d0
    call FillBytes
    xor a
    ldh [rSVBK], a

.call_draw_full_screen_buffer_to_bg_map:
    ld hl, vBGMap0
    call DrawFullScreenBufferToBGMap
    ld a, [wSGBActive]
    or a
    jr z, .set_text_window_tile_lo
    ld hl, wOBJPaletteBuffer
    ld de, wOBJPaletteBuffer + $20
    ld b, $20

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop

.set_text_window_tile_lo:
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
    ld a, $fc
    call StartPaletteFade
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; New player set-up, step 2: waits for the fade. (C1, E-0357)
GameMode5_Update_NewPlayerSetup_WaitFadeState::
    ld a, [wFadeState]
    or a
    ret nz
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; New player set-up, step 3: sets the story flag EVENT_IN_THE_MIDDLE_OF_THE (the game has begun) and
; sets the name entry's mode (wWorkBuf) from EVENT_NEVER_SET, which is never set. (C1, E-0357)
GameMode5_Update_NewPlayerSetup_SetFlagBit::
    ld e, LOW(EVENT_IN_THE_MIDDLE_OF_THE)
    ld d, HIGH(EVENT_IN_THE_MIDDLE_OF_THE)
    call SetFlagBit
    ld a, $01
    ld [wWorkBuf], a
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jr c, .done
    xor a
    ld [wWorkBuf], a

.done:
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; New player set-up, step 4: moves on at once. (C1, E-0357)
GameMode5_Update_NewPlayerSetup_AdvanceTitleScreenSubState::
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; New player set-up, step 5: runs the name entry for the player's name
; (RunNameEntryStateWhenNotFading); while it runs, a random player id is drawn each frame; when it
; finishes, copies the 10-glyph name to wPlayerName. (C1, E-0357)
GameMode5_Update_NewPlayerSetup_RunNameEntryStateWhenNotFading::
    ld hl, wArg1
    ld a, $00
    ld [hli], a
    ld a, [wWorkBuf]
    ld [hli], a
    xor a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    farcall RunNameEntryStateWhenNotFading
    call NextTableByte
    ld a, [wRandomLo]
    ld [wPlayerId], a
    ld a, [wArg5]
    cp $ff
    ret nz
    ld de, wNameGlyphBuf
    ld hl, wPlayerName
    ld b, $0a

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; New player set-up, step 6: puts the player on map $38 at screen (0, 0), position ($E0, 0), empty
; party, gold 100 and an empty inventory, creates the starting monster record
; (GameMode5_Update_NewPlayerSetup_LoadMonsterRecord), clears the key list and starts the game
; (title state 3). (C1, E-0357)
GameMode5_Update_NewPlayerSetup_InitGoldAndClearInventory::
    ld a, $38
    ldh [hMapId], a
    xor a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $e0
    ldh [hPlayerX], a
    ld [wFollowerRecords + $1], a
    xor a
    ldh [hPlayerY], a
    ld [wFollowerRecords + $2], a
    xor a
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld a, $00
    ld [wPartyCount], a
    ld a, $00
    ld [wPartyList], a
    call InitGoldAndClearInventory
    call GameMode5_Update_NewPlayerSetup_LoadMonsterRecord
    ld hl, wKeyList
    ld bc, $0080
    ld a, $ff
    call FillBytes
    xor a
    ld [wFieldReturnPhase], a
    ld a, $03
    ld [wTitleScreenState], a
    ret

; wGold = 100 and the 24 wInventory slots = 0 (the new-game setup path, InitLinkScreenStateBlock)
; (E-0074)
InitGoldAndClearInventory::
    ld a, $64
    ld [wGoldLo], a
    ld a, $00
    ld [wGoldMid], a
    ld a, $00
    ld [wGoldHi], a
    ld hl, wInventory
    ld bc, $0018
    ld a, $00
    call FillBytes
    ret

; Creates the starting monster in SRAM record 0 from MonsterTable entry 1: state 2 (in the party), a
; fixed six-glyph name, no parents, the player as owner, then its level, HP, MP, stats, skills and
; resistances from the template and species, written field by field. (C1, E-0357)
GameMode5_Update_NewPlayerSetup_LoadMonsterRecord::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld hl, $0001
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wMonsterId + $1], a
    farcall LoadMonsterRecord
    ld hl, sRecords
    ld a, $02
    ld [hli], a
    ld a, $1c
    ld [hli], a
    ld a, $2f
    ld [hli], a
    ld a, $24
    ld [hli], a
    ld a, $36
    ld [hli], a
    ld a, $2b
    ld [hli], a
    ld a, $f0
    ld [hli], a
    ld a, $ff
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld a, [wRecordBuffer]
    ld [hli], a
    ld a, [wRecordBuffer + $1]
    ld [hli], a
    inc hl
    xor a
    ld [hli], a
    ld de, wPlayerName
    ld b, $0b
    call CopyBBytesDEToHL_Bank07
    ld a, $ff
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld a, l
    add $16
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wRecordBufferData]
    ld [hli], a
    ld a, [wRecordBufferData + $1]
    ld [hli], a
    ld a, [wRecordBufferData + $2]
    ld [hli], a
    ld a, [wRecordBufferData + $3]
    ld [hli], a
    ld a, $ff
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld a, l
    add $19
    ld l, a
    ld a, h
    adc $00
    ld h, a
    xor a
    ld [hli], a
    ld a, [wRecordBufferData + $7]
    ld [hli], a
    ld a, l
    add $04
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wRecordBufferData + $8]
    ld [hli], a
    ld a, [wRecordBufferData + $9]
    ld [hli], a
    ld a, [wRecordBufferData + $8]
    ld [hli], a
    ld a, [wRecordBufferData + $9]
    ld [hli], a
    ld a, [wRecordBufferData + $a]
    ld [hli], a
    ld a, [wRecordBufferData + $b]
    ld [hli], a
    ld a, [wRecordBufferData + $a]
    ld [hli], a
    ld a, [wRecordBufferData + $b]
    ld [hli], a
    ld a, [wRecordBufferData + $c]
    ld [hli], a
    ld a, [wRecordBufferData + $d]
    ld [hli], a
    ld a, [wRecordBufferData + $e]
    ld [hli], a
    ld a, [wRecordBufferData + $f]
    ld [hli], a
    ld a, [wRecordBufferData + $10]
    ld [hli], a
    ld a, [wRecordBufferData + $11]
    ld [hli], a
    ld a, [wScreenAttrBuffer]
    ld [hli], a
    ld a, [wRecordBufferData + $13]
    ld [hli], a
    xor a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld a, [wRecordBufferData + $14]
    ld [hli], a
    ld a, [wRecordBufferData + $15]
    ld [hli], a
    ld a, [wRecordBufferData + $16]
    ld [hli], a
    ld a, [wRecordBufferData + $17]
    ld [hli], a
    ld a, [wRecordBuffer]
    ld l, a
    ld a, [wRecordBuffer + $1]
    ld h, a
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld hl, sRecords + $d
    ld a, [wSpeciesRecord]
    ld [hl], a
    ld a, l
    add $2f
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wSpeciesRecord + SPECIES_SKILLS]
    ld [hli], a
    ld a, [wSpeciesRecord + SPECIES_SKILLS + 1]
    ld [hli], a
    ld a, [wSpeciesRecord + SPECIES_SKILLS + 2]
    ld [hli], a
    ld b, $16
    ld a, $ff
    call FillBBytesAtHL_Bank07
    ld a, l
    add $02
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wSpeciesRecord + SPECIES_MAX_LEVEL]
    ld [hli], a
    xor a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld a, l
    add $18
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld de, wSpeciesRecord + SPECIES_RESISTANCES
    ld b, $1b
    call CopyBBytesDEToHL_Bank07
    ld a, l
    add $16
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld [hl], $00
    ld hl, sRecords + $8e
    call GameMode5_Update_NewPlayerSetup_WriteUnknownName
    ld hl, sRecords + $99
    call GameMode5_Update_NewPlayerSetup_WriteUnknownName
    ld hl, sRecords + $1e
    call GameMode5_Update_NewPlayerSetup_WriteUnknownName
    ld hl, sRecords + $29
    call GameMode5_Update_NewPlayerSetup_WriteUnknownName
    farcall SetSpeciesFlag
    ret

; stores A in B bytes from HL (B = 0 fills 256); HL ends past the fill, B = 0 (E-0065) (the same 5
; bytes appear in 2 banks)
FillBBytesAtHL_Bank07::
    ld [hli], a
    dec b
    jr nz, FillBBytesAtHL_Bank07
    ret

; DE = source, HL = destination, B = count: copies B bytes (B = 0 copies 256); DE and HL end past
; the copy; clobbers A, B = 0 (E-0064) (the same 7 bytes appear in 4 banks)
CopyBBytesDEToHL_Bank07::
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, CopyBBytesDEToHL_Bank07
    ret

; writes three $98 placeholder glyphs and seven $F0 bytes at HL (E-0305)
GameMode5_Update_NewPlayerSetup_WriteUnknownName::
    ld a, $98
    ld [hli], a
    ld a, $98
    ld [hli], a
    ld a, $98
    ld [hli], a
    ld a, $f0
    ld b, $07

.loop:
    ld [hli], a
    dec b
    jr nz, .loop
    ret

; Game mode 5, wModeState 2, a link session in progress: exchanges the joypad each frame
; (LinkExchangeJoypadPerFrame); in title state 1 runs the save when asked (wMenuCounter) and, when
; the link scene is set, switches to game mode 1 with talk event $21 and its script. (C1, E-0357)
GameMode5_Update_LinkExchangeJoypadPerFrame::
    ld a, [wLinkSession]
    cp $05
    jp z, RunLinkSession4ScreenState_CallLinkExchangeJoypadPerFrame
    call LinkExchangeJoypadPerFrame
    ld a, [wTitleScreenState]
    cp $01
    jr z, .check_screen_state
    ret

.check_screen_state:
    ld a, [wScreenState]
    cp $0c
    jr z, .check_screen_sub_step
    cp $0d
    jp z, .check_screen_step
    ld a, [wMenuCounter]
    and a
    jr z, .check_link_scene
    farcall RunSaveGameSteps
    ld a, [wSaveStep]
    bit 7, a
    ret z
    xor a
    ld [wMenuCounter], a

.check_link_scene:
    ld a, [wLinkScene]
    or a
    ret z
    ld a, $01
    ld [wGameMode], a
    ld a, $01
    ld [wModeChangeRequest], a
    xor a
    ld [wMapType], a
    xor a
    ld [wTalkEventIndex], a
    ld a, $21
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    farcall FetchScriptCommand
    ld a, $e0
    ldh [hPlayerX], a
    ld a, $00
    ldh [hPlayerY], a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $14
    ldh [hMapId], a
    xor a
    ldh [hPlayerStateFlags], a
    ld [wPartyCount], a
    xor a
    ld [wFieldReturnPhase], a
    ld a, [wSaveStateFlag]
    ld [wLinkSaveStateFlag], a
    xor a
    ld [wSaveStateFlag], a
    xor a
    ld [wLinkMode], a
    ld [wLinkScene], a
    ld [wScriptInDataBank], a
    ld [wMessageMode], a
    ret

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    and a
    ret nz
    ld a, [wScreenStep]
    cp $15
    jr z, .call_draw_list_entries_cell5_species_sprite
    cp $20
    jr z, .call_call_draw_party_species_sprites
    ret

.call_draw_list_entries_cell5_species_sprite:
    farcall DrawListEntriesCell5SpeciesSprite
    ret

.call_call_draw_party_species_sprites:
    farcall CallDrawPartySpeciesSpritesPreservingArg1AndTemp0
    ret

.check_screen_step:
    ld a, [wScreenStep]
    cp $15
    jr z, .call_draw_record_buf_b_species_sprite_part
    cp $20
    jr z, .call_draw_record_buf_b_species_sprites
    ret

.call_draw_record_buf_b_species_sprite_part:
    farcall DrawRecordBufBSpeciesSpritePart_BankF1
    ret

.call_draw_record_buf_b_species_sprites:
    farcall DrawRecordBufBSpeciesSprites
    ret
    db $c9

; Game mode 5, wModeState 3: exchanges the joypad each frame. (C1, E-0357)
GameMode5_Update_LinkExchangeJoypadPerFrame_2::
    call LinkExchangeJoypadPerFrame
    ld a, [wTitleScreenState]
    cp $01
    jr z, .return
    ret

.return:
    ret

; Game mode 5, wModeState 4: exchanges the joypad each frame and, on the record screens
; (wScreenState $0C or $0D), redraws the species sprites the current step shows. (C1, E-0357)
GameMode5_Update_LinkExchangeJoypadPerFrame_3::
    call LinkExchangeJoypadPerFrame
    ld a, [wTitleScreenState]
    or a
    jr nz, .check_screen_state
    ret

.check_screen_state:
    ld a, [wScreenState]
    cp $0c
    jr z, .check_screen_sub_step
    cp $0d
    jr z, .check_screen_step
    ret

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    and a
    ret nz
    ld a, [wScreenStep]
    cp $20
    jr z, .call_call_draw_party_species_sprites
    cp $15
    jr z, .call_draw_list_entries_cell5_species_sprite
    ret

.call_draw_list_entries_cell5_species_sprite:
    farcall DrawListEntriesCell5SpeciesSprite
    ret

.call_call_draw_party_species_sprites:
    farcall CallDrawPartySpeciesSpritesPreservingArg1AndTemp0
    ret

.check_screen_step:
    ld a, [wScreenStep]
    cp $15
    jr z, .call_draw_record_buf_b_species_sprite_part
    cp $20
    jr z, .call_draw_record_buf_b_species_sprites
    ret

.call_draw_record_buf_b_species_sprite_part:
    farcall DrawRecordBufBSpeciesSpritePart_BankF1
    ret

.call_draw_record_buf_b_species_sprites:
    farcall DrawRecordBufBSpeciesSprites
    ret

; the link battle set-up screens (link session 4): by wTitleScreenState it saves and syncs, sets the
; battle kind, edits the link battle rules or starts with preset ones, signals readiness over the
; link, and hands over to the egg service menu (E-0354; was: runs the routine for wTitleScreenState
; (jump table of nine states) (E-0122))
RunLinkSession4ScreenState::
    ld a, [wTitleScreenState]
    jumptable
    dw RunLinkSession4ScreenState_SaveAndSync
    dw RunLinkSession4ScreenState_WriteTitleScreenSubStateAndLinkScreenFlagEtc
    dw RunLinkSession4ScreenState_SetBattleKindAndSync
    dw RunLinkSession4ScreenState_EditRules
    dw RunLinkSession4ScreenState_StartWithPresetRules
    dw RunLinkSession4ScreenState_WriteLinkSendByteAndLinkReadyEtc
    dw RunLinkSession4ScreenState_DecompressToVRAMAndStep
    dw RunLinkSession4ScreenState_ToEggServiceMenu_Bank1B
    dw RunLinkSession4ScreenState_ResetAndSignal

; by wTitleScreenSubState: RunSaveSteps, then a link message wait (E-0293)
RunLinkSession4ScreenState_SaveAndSync::
    ld a, [wTitleScreenSubState]
    jumptable
    dw RunLinkSession4ScreenState_SaveAndSync_RunSaveSteps
    dw RunLinkSession4ScreenState_SetTitleScreenSubState
    dw RunLinkSession4ScreenState_SaveAndSync_WaitLinkMessage

; Link battle set-up, save and sync, step 0: after the fade saves the game, copies the party's HP,
; MP and status, fully heals the party and starts the sync. (C1, E-0357)
RunLinkSession4ScreenState_SaveAndSync_RunSaveSteps::
    ld a, [wFadeState]
    or a
    ret nz
    di
    farcall RunSaveSteps
    ei
    call RunLinkSession4ScreenState_SaveAndSync_LoadSRAMRecordWord
    farcall FullyHealParty
    ld a, $04
    ld [wSubMenuCursor], a
    xor a
    ld [wLinkSendByte], a
    ld a, [wTitleScreenSubState]
    inc a
    ld [wTitleScreenSubState], a
    ret

; Copies each party member's HP, MP and status from SRAM into wBattleStateBuffer (5 bytes each),
; then fills the entries of absent members. (C1, E-0357)
RunLinkSession4ScreenState_SaveAndSync_LoadSRAMRecordWord::
    ld a, $0a
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartyList
    ld de, wBattleStateBuffer

.loop:
    push hl
    ld a, [hl]
    ld c, MON_HP
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld [de], a
    inc de
    ldh a, [hTemp1]
    ld [de], a
    inc de
    ld a, [hl]
    ld c, MON_MP
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld [de], a
    inc de
    ldh a, [hTemp1]
    ld [de], a
    inc de
    ld a, [hl]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    ld [de], a
    inc de
    pop hl
    inc hl
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG], a
    ld a, [wPartyCount]
    cp $03
    ret z
    ld a, $ff
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ld [de], a
    inc de
    ret

; Save and sync, step 1: sends link byte $D3. (C1, E-0357)
RunLinkSession4ScreenState_SetTitleScreenSubState::
    ld a, [wTitleScreenSubState]
    inc a
    ld [wTitleScreenSubState], a
    ld a, $d3
    ld [wLinkSendByte], a
    ret

; Save and sync, step 2: waits for the partner's $D3, then moves to the next set-up state. (C1,
; E-0357)
RunLinkSession4ScreenState_SaveAndSync_WaitLinkMessage::
    ld a, [wLinkMessage]
    cp $d3
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld [wTitleScreenSubState], a
    ld a, [wTitleScreenState]
    inc a
    ld [wTitleScreenState], a
    ret

; Link battle set-up, state 1, the battle type choice. A partner's choice is followed: $FE edit the
; rules, $FD battle kind 8 with the current rules, $FC battle kind 9 with preset rules B, $FB battle
; kind 8 with preset rules A. Otherwise this side chooses among four entries: preset A (sends $FB,
; state 5), preset B ($FC, state 5), the current rules (loaded with LoadInvertedBit7FlagsToWorkBuf,
; $FD, state 3) and edit the rules (or B: sends $FE, next state); sound $69 on A. (C1, E-0357)
RunLinkSession4ScreenState_WriteTitleScreenSubStateAndLinkScreenFlagEtc::
    ld a, [wLinkMessage]
    cp $fe
    jr nz, .cp_FD
    ld a, $01
    ld [wTitleScreenSubState], a
    ld a, $01
    ld [wLinkScreenFlag], a
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wTitleScreenState
    inc [hl]
    jp .return

.cp_FD:
    cp $fd
    jr nz, .cp_FC
    ld a, $08
    ld [wBattleKind], a
    ld hl, wTitleScreenState
    inc [hl]
    ld hl, wTitleScreenState
    inc [hl]
    ld hl, wTitleScreenState
    inc [hl]
    xor a
    ld [wLinkSendByte], a
    jp .return

.cp_FC:
    cp $fc
    jr nz, .cp_FB
    call InitLinkRulesPresetB
    ld a, $09
    ld [wBattleKind], a
    ld a, $01
    ld [wLinkSetupMode], a
    jr .set_title_screen_state_to_08

.cp_FB:
    cp $fb
    jr nz, .call_move_vertical_cursor_in_list_hl
    call InitLinkRulesPresetA
    ld a, $08
    ld [wBattleKind], a
    ld a, $00
    ld [wLinkSetupMode], a

.set_title_screen_state_to_08:
    ld a, $08
    ld [wTitleScreenState], a
    jp .return

.call_move_vertical_cursor_in_list_hl:
    ld de, CursorPositionWords_Bank07 + $10
    ld hl, wMenuState
    call MoveVerticalCursorInListHL
    ld a, [wJoypadPressed]
    and $01
    jr z, .check_joypad_pressed
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuState]
    and $03
    cp $03
    jr z, .set_link_send_byte_to_FE
    or a
    jr z, .call_init_link_rules_preset_a
    cp $01
    jr z, .call_init_link_rules_preset_b
    call LoadInvertedBit7FlagsToWorkBuf
    ld a, $08
    ld [wBattleKind], a
    lb de, $fd, $03
    jr .set_title_screen_state

.call_init_link_rules_preset_a:
    call InitLinkRulesPresetA
    ld a, $08
    ld [wBattleKind], a
    ld a, $00
    ld [wLinkSetupMode], a
    lb de, $fb, $05
    jr .set_title_screen_state

.call_init_link_rules_preset_b:
    call InitLinkRulesPresetB
    ld a, $09
    ld [wBattleKind], a
    ld a, $01
    ld [wLinkSetupMode], a
    lb de, $fc, $05

.set_title_screen_state:
    ld a, e
    ld [wTitleScreenState], a
    ld a, d
    ld [wLinkSendByte], a
    jr .return

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $02
    jr z, .return

.set_link_send_byte_to_FE:
    ld a, $fe
    ld [wLinkSendByte], a
    xor a
    ld [wLinkScreenFlag], a
    xor a
    ld [wTitleScreenSubState], a
    ld hl, wTitleScreenState
    inc [hl]

.return:
    ret

; stores 0, 0, 0, $63, $29, $01, 0, 0, $63, $80 at wLinkRules-wLinkRules + $9 (E-0120)
InitLinkRulesPresetA::
    ld hl, wLinkRules
    xor a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld a, $63
    ld [hli], a
    ld a, $29
    ld [hli], a
    ld a, $01
    ld [hli], a
    xor a
    ld [hli], a
    ld [hli], a
    ld a, $63
    ld [hli], a
    ld [hl], $80
    ret

; stores $01, $81, $01, $63, $29, $01, $80, $01, $9E, $00 at wLinkRules-wLinkRules + $9 (E-0120)
InitLinkRulesPresetB::
    ld hl, wLinkRules
    ld a, $01
    ld [hli], a
    ld a, $81
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $63
    ld [hli], a
    ld a, $29
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $80
    ld [hli], a
    ld a, $01
    ld [hli], a
    ld a, $9e
    ld [hli], a
    ld [hl], $00
    ret

; wWorkBuf = 0, then wWorkBuf + $1-wWorkBuf + $5 = the inverted bit 7 of wLinkRules + $1, wLinkRules
; + $5, wLinkRules + $6, wLinkRuleTurnLimit and wLinkRules + $9 (E-0121)
LoadInvertedBit7FlagsToWorkBuf::
    ld hl, wWorkBuf
    xor a
    ld [hli], a
    ld a, [wLinkRules + $1]
    rlca
    and $01
    xor $01
    ld [hli], a
    ld a, [wLinkRules + $5]
    rlca
    and $01
    xor $01
    ld [hli], a
    ld a, [wLinkRules + $6]
    rlca
    and $01
    xor $01
    ld [hli], a
    ld a, [wLinkRuleTurnLimit]
    rlca
    and $01
    xor $01
    ld [hli], a
    ld a, [wLinkRules + $9]
    rlca
    and $01
    xor $01
    ld [hl], a
    ret

; by wTitleScreenSubState: writes wBattleKind and the link screen state, copies a record rectangle,
; shows a string and waits for the partner (E-0304)
RunLinkSession4ScreenState_SetBattleKindAndSync::
    ld a, [wTitleScreenSubState]
    jumptable
    dw RunLinkSession4ScreenState_CheckLinkMessage
    dw RunLinkSession4ScreenState_SetBattleKindAndSync_SetTitleScreenSubState
    dw RunLinkSession4ScreenState_SetBattleKindAndSync_WaitLinkMessage
    dw RunLinkSession4ScreenState_SetBattleKindAndSync_WaitLinkMessage_AdvanceTitleScreenSubState
    dw RunLinkSession4ScreenState_SetBattleKindAndSync_ShowStringHL_Bank07
    dw RunLinkSession4ScreenState_WaitTextFlags
    dw RunLinkSession4ScreenState_SetBattleKindAndSync_2
    dw RunLinkSession4ScreenState_SetBattleKindAndSync_FillBytes

; Battle kind and sync, step 0: on the side that does not drive the clock (wLinkRole bit 1 clear),
; acts on the partner's choice: $FB preset rules A and battle kind 8, $FC preset rules B and battle
; kind 9, $FD as the following lines; $01 and $FE continue. (C1, E-0357)
RunLinkSession4ScreenState_CheckLinkMessage::
    ld a, [wLinkMessage]
    cp $01
    jr z, .clear_link_send_byte
    cp $fe
    jr z, .clear_link_send_byte
    cp $fb
    jr z, .check_link_role
    cp $fc
    jr z, .check_link_role2
    cp $fd
    jr z, .check_link_role3
    ret

.check_link_role:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .clear_link_send_byte
    call InitLinkRulesPresetA
    ld a, $08
    ld [wBattleKind], a
    ld a, $00
    ld [wLinkSetupMode], a
    ld a, $05
    ld [wTitleScreenState], a
    ret

.check_link_role2:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .clear_link_send_byte
    call InitLinkRulesPresetB
    ld a, $09
    ld [wBattleKind], a
    ld a, $01
    ld [wLinkSetupMode], a
    ld a, $05
    ld [wTitleScreenState], a
    ret

.check_link_role3:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .clear_link_send_byte
    ld a, $08
    ld [wBattleKind], a
    ld a, $04
    ld [wTitleScreenState], a
    xor a
    ld [wLinkSendByte], a
    ret

.clear_link_send_byte:
    xor a
    ld [wLinkSendByte], a
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Battle kind and sync, step 1: sends link byte 2. (C1, E-0357)
RunLinkSession4ScreenState_SetBattleKindAndSync_SetTitleScreenSubState::
    ld hl, wTitleScreenSubState
    inc [hl]
    ld a, $02
    ld [wLinkSendByte], a
    ret

; Battle kind and sync, step 2: waits for the partner's 2, then redraws the message window. (C1,
; E-0357)
RunLinkSession4ScreenState_SetBattleKindAndSync_WaitLinkMessage::
    ld a, [wLinkMessage]
    cp $02
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld hl, TileRect_SaveCheckScreenRects_2
    call CopyRecordRectToScreenBuffer_Bank07
    ld hl, vBGMap0 + $1a0
    ld de, wWindowTileBuffer + $38
    lb bc, $14, $05
    call CopyRect32StrideToVRAM_Bank07
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Battle kind and sync, step 3: waits until the partner's message byte returns to 0. (C1, E-0357)
RunLinkSession4ScreenState_SetBattleKindAndSync_WaitLinkMessage_AdvanceTitleScreenSubState::
    ld a, [wLinkMessage]
    or a
    ret nz
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Battle kind and sync, step 4: shows message $0302, or $0303 when wLinkScreenFlag is set. (C1,
; E-0357)
RunLinkSession4ScreenState_SetBattleKindAndSync_ShowStringHL_Bank07::
    ld hl, $0302
    ld a, [wLinkScreenFlag]
    or a
    jr z, .call_show_string_hl_bank07
    inc l

.call_show_string_hl_bank07:
    call ShowStringHL_Bank07
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Battle kind and sync, step 5: after the message sends link byte 1. (C1, E-0357)
RunLinkSession4ScreenState_WaitTextFlags::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Battle kind and sync, step 6: waits for the partner's 1. (C1, E-0357)
RunLinkSession4ScreenState_SetBattleKindAndSync_2::
    ld a, [wLinkMessage]
    cp $01
    ret nz
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Battle kind and sync, step 7: ends the link session (clears the link state and work bytes) and
; returns to the title (game mode 5, wModeState 1) with a fade. (C1, E-0357)
RunLinkSession4ScreenState_SetBattleKindAndSync_FillBytes::
    xor a
    ld [wLinkSession], a
    ld [wLinkExchangeState], a
    ld [wLinkRole], a
    ld [wLinkStatus], a
    ld [wLinkMode], a
    ld [wLinkMessage], a
    ld [wLinkSendByte], a
    ld [wLinkScreenStep], a
    ld hl, wWorkBuf
    ld bc, $001e
    xor a
    call FillBytes
    ld hl, wModeChangeRequest
    inc [hl]
    ld hl, wGameMode
    ld a, $05
    ld [hli], a
    ld a, $01
    ld [hli], a
    xor a
    ld [hli], a
    ld [hl], a
    ld a, $04
    call StartPaletteFade
    ret

; by wTitleScreenSubState: a vertical list cursor over the link battle rules; its steps read and
; write wLinkRules (19 uses) and wLinkRuleTurnLimit, mark entries
; (WriteBCTileAtWordTableEntry_Bank07) and exchange bytes and messages over the link (E-0304)
RunLinkSession4ScreenState_EditRules::
    ld a, [wTitleScreenSubState]
    jumptable
    dw RunLinkSession4ScreenState_WriteSubMenuCursorAndLinkSendByteEtc
    dw RunLinkSession4ScreenState_EditRules_MoveVerticalCursorInListHL
    dw RunLinkSession4ScreenState_EditRules_SetLinkSendByte
    dw RunLinkSession4ScreenState_EditRules_WriteWorkBufAndTitleScreenSubStateEtc
    dw RunLinkSession4ScreenState_EditRules_WaitLinkMessage
    dw RunLinkSession4ScreenState_WriteLinkBufferCountLoAndLinkTimeoutLoEtc
    dw RunLinkSession4ScreenState_EditRules_WaitLinkMessage_SetLinkSendByte
    dw RunLinkSession4ScreenState_EditRules_CopyRecordRectToScreenBuffer_Bank07AndStep
    dw RunLinkSession4ScreenState_ToShowStringHL_Bank07AndStep
    dw RunLinkSession4ScreenState_EditRules_WaitTextFlags
    dw RunLinkSession4ScreenState_EditRules_CheckLinkMessage
    dw RunLinkSession4ScreenState_EditRules_2
    dw RunLinkSession4ScreenState_EditRules_CopyRecordRectToScreenBuffer_Bank07
    dw RunLinkSession4ScreenState_EditRules_MoveVerticalCursorInListHL_WriteBCTileAtWordTableEntry_Bank07
    dw RunLinkSession4ScreenState_EditRules_WriteBCTileAtWordTableEntry_Bank07
    dw RunLinkSession4ScreenState_EditRules_WriteBCTileAtWordTableEntry_Bank07_2
    dw RunLinkSession4ScreenState_EditRules_3
    dw RunLinkSession4ScreenState_EditRules_4
    dw RunLinkSession4ScreenState_EditRules_5
    dw RunLinkSession4ScreenState_EditRules_6
    dw RunLinkSession4ScreenState_EditRules_7
    dw RunLinkSession4ScreenState_EditRules_WriteWorkBufAndTitleScreenSubStateEtc_3
    dw RunLinkSession4ScreenState_EditRules_CopyRecordRectToScreenBuffer_Bank07_CopyRect32StrideToVRAM_Bank07
    dw RunLinkSession4ScreenState_EditRules_MoveVerticalCursorInListHL_2
    dw RunLinkSession4ScreenState_EditRules_WriteWorkBufAndTitleScreenSubStateEtc_4
    dw RunLinkSession4ScreenState_EditRules_CopyRecordRectToScreenBuffer_Bank07AndStep_CopyRect32StrideToVRAM_Bank07
    dw RunLinkSession4ScreenState_EditRules_QueueSoundEffect
    dw RunLinkSession4ScreenState_EditRules_WriteWorkBufAndTitleScreenSubStateEtc_5
    dw RunLinkSession4ScreenState_EditRules_CopyRecordRectToScreenBuffer_Bank07AndStep_2
    dw RunLinkSession4ScreenState_EditRules_SetTitleScreenSubState
    dw RunLinkSession4ScreenState_EditRules_QueueSoundEffect_RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07

; Link rules editor, step 0: on the side not driving the clock follows the partner's choice ($FE
; editing, $FD battle kind 8, $FB preset A, $FC preset B); otherwise draws the rules screen. (C1,
; E-0357)
RunLinkSession4ScreenState_WriteSubMenuCursorAndLinkSendByteEtc::
    ld a, [wLinkMessage]
    cp $fe
    jr z, .check_link_role
    cp $fd
    jr z, .check_link_role2
    cp $fb
    jr z, .check_link_role3
    cp $fc
    jr z, .check_link_role4
    jr .call_fill_screen_tile_buffer_with_d

.check_link_role:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_fill_screen_tile_buffer_with_d
    ld a, $01
    ld [wTitleScreenSubState], a
    ld a, $01
    ld [wLinkScreenFlag], a
    ld a, $01
    ld [wLinkSendByte], a
    ld a, $02
    ld [wTitleScreenState], a
    ret

.check_link_role2:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_fill_screen_tile_buffer_with_d
    ld a, $08
    ld [wBattleKind], a
    ld a, $04
    ld [wTitleScreenState], a
    xor a
    ld [wLinkSendByte], a
    ret

.check_link_role3:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_fill_screen_tile_buffer_with_d
    call InitLinkRulesPresetA
    ld a, $08
    ld [wBattleKind], a
    ld a, $00
    ld [wLinkSetupMode], a
    ld a, $05
    ld [wTitleScreenState], a
    ret

.check_link_role4:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_fill_screen_tile_buffer_with_d
    call InitLinkRulesPresetB
    ld a, $09
    ld [wBattleKind], a
    ld a, $01
    ld [wLinkSetupMode], a
    ld a, $05
    ld [wTitleScreenState], a
    ret

.call_fill_screen_tile_buffer_with_d:
    ld d, $c3
    call FillScreenTileBufferWithD
    ld hl, TileRect_SaveCheckScreenRects_2 + $1dc
    call CopyRecordRectToScreenBuffer_Bank07
    call DrawWorkBufSelectionTilesAndPanels
    call DrawScreenBufferToBGMap0_Bank07
    ld a, $06
    ld [wSubMenuCursor], a
    ld hl, wTitleScreenSubState
    inc [hl]
    xor a
    ld [wLinkSendByte], a
    ret

; Link rules editor, step 1: the cursor over the rule list; A opens the selected rule (its current
; value from wWorkBuf and its step from RunLinkSession4ScreenState_EditRules_Data). (C1, E-0357)
RunLinkSession4ScreenState_EditRules_MoveVerticalCursorInListHL::
    ld hl, wMenuSubState
    ld de, CursorPositionWords_Bank07 + $18
    call MoveVerticalCursorInListHL
    ld a, [wJoypadPressed]
    and $02
    jr z, .check_joypad_pressed
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $01
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSubState]
    ld hl, CursorPositionWords_Bank07 + $18
    and $07
    call WriteBCTileAtWordTableEntry_Bank07
    ld a, $02
    ld [wSubMenuCursor2], a
    ld a, [wMenuSubState]
    and $07
    ld hl, wWorkBuf
    add_a_to_hl
    ld a, [hl]
    ld [wMenuSelectedMember], a
    ld a, [wMenuSubState]
    and $07
    ld hl, RunLinkSession4ScreenState_EditRules_Data
    add_a_to_hl
    ld a, [hl]
    ld [wTitleScreenSubState], a
    xor a
    ld [wLinkScreenFlag], a
    ret

; data read by RunLinkSession4ScreenState (6 bytes) (E-0347)
RunLinkSession4ScreenState_EditRules_Data::
    db $03, $0b, $15, $18, $1b, $1e

; Link rules editor, step 2 (leave): sends $FE and returns to the battle type choice. (C1, E-0357)
RunLinkSession4ScreenState_EditRules_SetLinkSendByte::
    ld a, $fe
    ld [wLinkSendByte], a
    ld a, $02
    ld [wTitleScreenState], a
    xor a
    ld [wTitleScreenSubState], a
    xor a
    ld [wLinkScreenFlag], a
    ret

; Link rules editor, step 3, the 'decide' rule: Left/Right choose yes or no; B goes back keeping the
; choice; A with 'no' returns to the list; with 'yes' it writes the edited rule values from wWorkBuf
; + 1 onward into wLinkRules (each as bit 7, inverted) and starts sending them. (C1, E-0357)
RunLinkSession4ScreenState_EditRules_WriteWorkBufAndTitleScreenSubStateEtc::
    ld hl, wMenuSelectedMember
    ld de, CursorPositionWords_Bank07 + $24
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and $02
    jr z, .check_joypad_pressed
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf], a
    xor a
    ld [wTitleScreenSubState], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $01
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    and $01
    jr z, .skip
    ld a, $02
    ld [wTitleScreenSubState], a
    ret

.skip:
    ld hl, wLinkRules
    ld a, $01
    ld [hli], a
    ld a, [wWorkBuf + $1]
    call SetHLBit7FromInverseABit0
    inc hl
    inc hl
    inc hl
    ld a, [wWorkBuf + $2]
    call SetHLBit7FromInverseABit0
    ld a, [wWorkBuf + $3]
    call SetHLBit7FromInverseABit0
    inc hl
    ld a, [wWorkBuf + $4]
    call SetHLBit7FromInverseABit0
    ld a, [wWorkBuf + $5]
    call SetHLBit7FromInverseABit0
    ld a, $02
    ld [wLinkSetupMode], a
    call CopyLinkRulesToLinkRulesCopy
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; bit 7 of [HL] = NOT bit 0 of A (the other bits kept); HL += 1 (E-0119)
SetHLBit7FromInverseABit0::
    rrca
    and $80
    xor $80
    res 7, [hl]
    or [hl]
    ld [hli], a
    ret

; Link rules editor, step 4: waits for the partner's 2 and answers 2. (C1, E-0357)
RunLinkSession4ScreenState_EditRules_WaitLinkMessage::
    ld a, [wLinkMessage]
    cp $02
    ret nz
    ld a, $02
    ld [wLinkSendByte], a
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Link rules editor, step 5: starts the transfer of the 10 rule bytes from wLinkRules, receiving the
; partner's into wLinkPartnerName, and sends $FF. (C1, E-0357)
RunLinkSession4ScreenState_WriteLinkBufferCountLoAndLinkTimeoutLoEtc::
    ld a, $0a
    ld [wLinkBufferCountLo], a
    ld hl, wLinkRules
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, wLinkPartnerName
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $01
    ld [wLinkReady], a
    ld a, $ff
    ld [wLinkSendByte], a
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Link rules editor, step 6: waits for the partner's $F0 (transfer done). (C1, E-0357)
RunLinkSession4ScreenState_EditRules_WaitLinkMessage_SetLinkSendByte::
    ld a, [wLinkMessage]
    cp $f0
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Link rules editor, step 7: redraws the message window. (C1, E-0357)
RunLinkSession4ScreenState_EditRules_CopyRecordRectToScreenBuffer_Bank07AndStep::
    ld hl, TileRect_SaveCheckScreenRects_2
    call CopyRecordRectToScreenBuffer_Bank07
    ld hl, vBGMap0 + $1a0
    ld de, wWindowTileBuffer + $38
    lb bc, $14, $05
    call CopyRect32StrideToVRAM_Bank07
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Link rules editor, step 8: shows message $0306. (C1, E-0357)
RunLinkSession4ScreenState_ToShowStringHL_Bank07AndStep::
    ld hl, $0306
    call ShowStringHL_Bank07
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Link rules editor, step 9: waits for the message. (C1, E-0357)
RunLinkSession4ScreenState_EditRules_WaitTextFlags::
    ld a, [wTextFlags]
    or a
    ret nz
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Link rules editor, step 10: the partner's $FE returns to the battle type choice (edit again); its
; 1 goes to state 5 (the battle). (C1, E-0357)
RunLinkSession4ScreenState_EditRules_CheckLinkMessage::
    ld a, [wLinkMessage]
    cp $fe
    jr nz, .cp_01
    ld a, $02
    ld [wTitleScreenState], a
    xor a
    ld [wTitleScreenSubState], a
    ld a, $01
    ld [wLinkScreenFlag], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

.cp_01:
    cp $01
    ret nz
    ld a, $01
    ld [wLinkSendByte], a
    ld a, $05
    ld [wTitleScreenState], a
    ld a, $01
    ld [wTitleScreenSubState], a
    ld a, $00
    ld [wLinkScreenFlag], a
    ret

; Link rules editor, step 11, a yes/no rule: Left/Right choose; B goes back keeping it; A stores it,
; and 'yes' moves on to the rule's details. (C1, E-0357)
RunLinkSession4ScreenState_EditRules_2::
    ld hl, wMenuSelectedMember
    ld de, CursorPositionWords_Bank07 + $28
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and $02
    jr z, .check_joypad_pressed
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf + $1], a
    xor a
    ld [wTitleScreenSubState], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $01
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf + $1], a
    or a
    jr z, .skip
    xor a
    ld [wTitleScreenSubState], a
    ret

.skip:
    ld hl, wTitleScreenSubState
    inc [hl]
    xor a
    ld [wLinkScreenFlag], a
    ret

; Link rules editor, step 12: draws the rule details screen and, for each rule bit of wLinkRules + 1
; (bits 6, 5, 4 and on), stores its value in wWorkBuf + 6 onward (2 when the rule is off, else the
; matching bit of wLinkRules + 2) and draws its mark. (C1, E-0357)
RunLinkSession4ScreenState_EditRules_CopyRecordRectToScreenBuffer_Bank07::
    ld hl, TileRect_SaveCheckScreenRects_2 + $320
    call CopyRecordRectToScreenBuffer_Bank07
    call DrawScreenBufferToBGMap0_Bank07
    ld de, wWorkBuf + $6
    ld hl, vBGMap0 + $8c
    ld a, [wLinkRules + $1]
    ld c, a
    ld a, [wLinkRules + $2]
    ld b, a
    ld a, $02
    bit 6, c
    jr z, .call_run_link_session4_screen_state_edit
    ld a, b
    rlca
    rlca
    and $01

.call_run_link_session4_screen_state_edit:
    ld [de], a
    inc de
    call RunLinkSession4ScreenState_EditRules_WriteVRAMByte
    ld a, $02
    bit 5, c
    jr z, .call_run_link_session4_screen_state_edit2
    ld a, b
    rrca
    swap a
    and $01

.call_run_link_session4_screen_state_edit2:
    ld [de], a
    inc de
    call RunLinkSession4ScreenState_EditRules_WriteVRAMByte
    ld a, $02
    bit 4, c
    jr z, .call_run_link_session4_screen_state_edit3
    ld a, b
    swap a
    and $01

.call_run_link_session4_screen_state_edit3:
    ld [de], a
    inc de
    call RunLinkSession4ScreenState_EditRules_WriteVRAMByte
    ld a, $02
    bit 3, c
    jr z, .call_run_link_session4_screen_state_edit4
    ld a, b
    rrca
    rrca
    rrca
    and $01

.call_run_link_session4_screen_state_edit4:
    ld [de], a
    inc de
    call RunLinkSession4ScreenState_EditRules_WriteVRAMByte
    ld a, $02
    bit 2, c
    jr z, .call_run_link_session4_screen_state_edit5
    ld a, b
    rrca
    rrca
    and $01

.call_run_link_session4_screen_state_edit5:
    ld [de], a
    inc de
    call RunLinkSession4ScreenState_EditRules_WriteVRAMByte
    ld a, $02
    bit 1, c
    jr z, .call_run_link_session4_screen_state_edit6
    ld a, b
    rrca
    and $01

.call_run_link_session4_screen_state_edit6:
    ld [de], a
    inc de
    call RunLinkSession4ScreenState_EditRules_WriteVRAMByte
    ld a, $02
    bit 0, c
    jr z, .call_run_link_session4_screen_state_edit7
    ld a, b
    and $01

.call_run_link_session4_screen_state_edit7:
    ld [de], a
    call RunLinkSession4ScreenState_EditRules_WriteVRAMByte
    xor a
    ld [wMenuCursor], a
    ld a, $07
    ld [wSubMenuCursor], a
    ld a, $03
    ld [wSubMenuCursor2], a
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Draws a rule detail mark: cursor tile $BC at HL + 2 * A, then moves HL down two BG map rows for
; the next rule. (C1, E-0357)
RunLinkSession4ScreenState_EditRules_WriteVRAMByte::
    push bc
    push hl
    add a
    add_a_to_hl
    ld a, $bc
    call WriteVRAMByte
    pop hl
    ld bc, $0040
    add hl, bc
    pop bc
    ret

; Link rules editor, step 13: the cursor over the rule details. A opens the detail chosen (step 14 +
; entry); B packs the chosen detail values (wWorkBuf + 6 onward, 2 meaning off) back into the rule
; bits of wLinkRules + 1 and + 2 and returns. (C1, E-0357)
RunLinkSession4ScreenState_EditRules_MoveVerticalCursorInListHL_WriteBCTileAtWordTableEntry_Bank07::
    ld hl, wMenuCursor
    ld de, CursorPositionWords_Bank07 + $3c
    call MoveVerticalCursorInListHL
    ld a, [wJoypadPressed]
    and $01
    jr z, .check_joypad_pressed
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuCursor]
    ld hl, CursorPositionWords_Bank07 + $3c
    call WriteBCTileAtWordTableEntry_Bank07
    ld a, [wMenuCursor]
    and $07
    inc a
    ld hl, wTitleScreenSubState
    add [hl]
    ld [hl], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $02
    ret z
    ld bc, $0000
    ld a, [wWorkBuf + $6]
    cp $02
    jr z, .check_work_buf
    rrca
    rrca
    and $40
    or b
    ld b, a
    set 6, c

.check_work_buf:
    ld a, [wWorkBuf + $7]
    cp $02
    jr z, .check_work_buf2
    swap a
    rlca
    and $20
    or b
    ld b, a
    set 5, c

.check_work_buf2:
    ld a, [wWorkBuf + $8]
    cp $02
    jr z, .check_work_buf3
    swap a
    and $10
    or b
    ld b, a
    set 4, c

.check_work_buf3:
    ld a, [wWorkBuf + $9]
    cp $02
    jr z, .check_work_buf4
    swap a
    rrca
    and $08
    or b
    ld b, a
    set 3, c

.check_work_buf4:
    ld a, [wWorkBuf + $a]
    cp $02
    jr z, .check_work_buf5
    rlca
    rlca
    and $04
    or b
    ld b, a
    set 2, c

.check_work_buf5:
    ld a, [wWorkBuf + $b]
    cp $02
    jr z, .check_work_buf6
    rlca
    and $02
    or b
    ld b, a
    set 1, c

.check_work_buf6:
    ld a, [wWorkBuf + $c]
    cp $02
    jr z, .set_link_rules
    and $01
    or b
    ld b, a
    set 0, c

.set_link_rules:
    ld a, c
    ld [wLinkRules + $1], a
    ld a, b
    ld [wLinkRules + $2], a
    xor a
    ld [wTitleScreenSubState], a
    ret

; Link rules editor, step 14: chooses detail value 1 among its options (Left/Right on wWorkBuf + 6);
; A or B marks it and returns to the detail list (step 13). (C1, E-0357)
RunLinkSession4ScreenState_EditRules_WriteBCTileAtWordTableEntry_Bank07::
    ld hl, wWorkBuf + $6
    ld de, CursorPositionWords_Bank07 + $4a
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wWorkBuf + $6]
    and $03
    ld hl, CursorPositionWords_Bank07 + $4a
    call WriteBCTileAtWordTableEntry_Bank07
    ld a, $0d
    ld [wTitleScreenSubState], a
    ret

; Link rules editor, step 15: chooses detail value 2 (wWorkBuf + 7), then back to the detail list.
; (C1, E-0357)
RunLinkSession4ScreenState_EditRules_WriteBCTileAtWordTableEntry_Bank07_2::
    ld hl, wWorkBuf + $7
    ld de, CursorPositionWords_Bank07 + $50
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wWorkBuf + $7]
    and $03
    ld hl, CursorPositionWords_Bank07 + $50
    call WriteBCTileAtWordTableEntry_Bank07
    ld a, $0d
    ld [wTitleScreenSubState], a
    ret

; Link rules editor, step 16: chooses detail value 3 (wWorkBuf + 8), then back to the detail list.
; (C1, E-0357)
RunLinkSession4ScreenState_EditRules_3::
    ld hl, wWorkBuf + $8
    ld de, CursorPositionWords_Bank07 + $56
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wWorkBuf + $8]
    and $03
    ld hl, CursorPositionWords_Bank07 + $56
    call WriteBCTileAtWordTableEntry_Bank07
    ld a, $0d
    ld [wTitleScreenSubState], a
    ret

; Link rules editor, step 17: chooses detail value 4 (wWorkBuf + 9), then back to the detail list.
; (C1, E-0357)
RunLinkSession4ScreenState_EditRules_4::
    ld hl, wWorkBuf + $9
    ld de, CursorPositionWords_Bank07 + $5c
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wWorkBuf + $9]
    and $03
    ld hl, CursorPositionWords_Bank07 + $5c
    call WriteBCTileAtWordTableEntry_Bank07
    ld a, $0d
    ld [wTitleScreenSubState], a
    ret

; Link rules editor, step 18: chooses detail value 5 (wWorkBuf + $A), then back to the detail list.
; (C1, E-0357)
RunLinkSession4ScreenState_EditRules_5::
    ld hl, wWorkBuf + $a
    ld de, CursorPositionWords_Bank07 + $62
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wWorkBuf + $a]
    and $03
    ld hl, CursorPositionWords_Bank07 + $62
    call WriteBCTileAtWordTableEntry_Bank07
    ld a, $0d
    ld [wTitleScreenSubState], a
    ret

; Link rules editor, step 19: chooses detail value 6 (wWorkBuf + $B), then back to the detail list.
; (C1, E-0357)
RunLinkSession4ScreenState_EditRules_6::
    ld hl, wWorkBuf + $b
    ld de, CursorPositionWords_Bank07 + $68
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wWorkBuf + $b]
    and $03
    ld hl, CursorPositionWords_Bank07 + $68
    call WriteBCTileAtWordTableEntry_Bank07
    ld a, $0d
    ld [wTitleScreenSubState], a
    ret

; Link rules editor, step 20: chooses detail value 7 (wWorkBuf + $C), then back to the detail list.
; (C1, E-0357)
RunLinkSession4ScreenState_EditRules_7::
    ld hl, wWorkBuf + $c
    ld de, CursorPositionWords_Bank07 + $6e
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wWorkBuf + $c]
    and $03
    ld hl, CursorPositionWords_Bank07 + $6e
    call WriteBCTileAtWordTableEntry_Bank07
    ld a, $0d
    ld [wTitleScreenSubState], a
    ret

; Link rules editor, step 21, the second yes/no rule (wWorkBuf + 2): B goes back keeping the choice;
; A stores it and 'yes' moves to its values. (C1, E-0357)
RunLinkSession4ScreenState_EditRules_WriteWorkBufAndTitleScreenSubStateEtc_3::
    ld hl, wMenuSelectedMember
    ld de, CursorPositionWords_Bank07 + $2c
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and $02
    jr z, .check_joypad_pressed
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf + $2], a
    xor a
    ld [wTitleScreenSubState], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $01
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf + $2], a
    or a
    jr z, .skip
    xor a
    ld [wTitleScreenSubState], a
    ret

.skip:
    ld hl, wTitleScreenSubState
    inc [hl]
    xor a
    ld [wLinkScreenFlag], a
    ret

; Link rules editor, step 22: draws the level rule's panel with its two numbers (the total of
; wLinkRules + 4/5 and the limit in wLinkRules + 3) and sets the cursor on the entry chosen by bit 6
; of wLinkRules + 4's high byte. (C1, E-0357)
RunLinkSession4ScreenState_EditRules_CopyRecordRectToScreenBuffer_Bank07_CopyRect32StrideToVRAM_Bank07::
    ld hl, RunLinkSession4ScreenState_EditRules_TileRect
    call CopyRecordRectToScreenBuffer_Bank07
    ld hl, vBGMap0 + $e0
    ld de, wScreenTileBuffer + $e0
    lb bc, $14, $05
    call CopyRect32StrideToVRAM_Bank07
    call RunLinkSession4ScreenState_EditRules_HLToDecimalDigits_2
    call RunLinkSession4ScreenState_EditRules_HLToDecimalDigits_3
    ld a, [wLinkRules + $4]
    rlca
    rlca
    and $01
    ld [wMenuCursor], a
    ld a, $02
    ld [wSubMenuCursor], a
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Link rules editor, step 23: the level rule's values. Up/Down choose between the total level and
; the single-level limit; Left/Right change it: the total (wLinkRules + 4/5) between 3 and 297
; ($129), the limit (wLinkRules + 3) between 1 and 99. A or B store which form is chosen in bit 6 of
; wLinkRules + 5 and return to the rule list. (C1, E-0357)
RunLinkSession4ScreenState_EditRules_MoveVerticalCursorInListHL_2::
    ld hl, wMenuCursor
    ld de, CursorPositionWords_Bank07 + $74
    call MoveVerticalCursorInListHL
    ld a, [wJoypadPressedRepeat]
    and $30
    jr z, .check_joypad_pressed
    ld a, [wMenuCursor]
    and $01
    jr nz, .read_link_rules
    ld a, [wLinkRules + $4]
    ld l, a
    ld a, [wLinkRules + $5]
    and $c0
    push af
    ld a, [wLinkRules + $5]
    and $3f
    ld h, a
    ld a, [wJoypadPressedRepeat]
    and $20
    jr z, .next
    dec hl
    ld a, h
    or a
    jr nz, .set_link_rules
    ld a, l
    cp $03
    jr nc, .set_link_rules
    ld hl, $0003
    jr .set_link_rules

.next:
    inc hl
    ld a, l
    sub $29
    ld a, h
    sbc $01
    jr c, .set_link_rules
    ld hl, $0129

.set_link_rules:
    pop af
    or h
    ld [wLinkRules + $5], a
    ld a, l
    ld [wLinkRules + $4], a
    call RunLinkSession4ScreenState_EditRules_HLToDecimalDigits_2
    jr .check_joypad_pressed

.read_link_rules:
    ld a, [wLinkRules + $3]
    ld l, a
    ld a, [wJoypadPressedRepeat]
    and $20
    jr z, .skip
    dec hl
    ld a, l
    or a
    jr nz, .set_link_rules2
    ld hl, $0001
    jr .set_link_rules2

.skip:
    inc l
    ld a, l
    cp $64
    jr c, .set_link_rules2
    ld hl, $0063

.set_link_rules2:
    ld a, l
    ld [wLinkRules + $3], a
    call RunLinkSession4ScreenState_EditRules_HLToDecimalDigits_3

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuCursor]
    rrca
    rrca
    and $40
    ld h, a
    ld a, [wLinkRules + $5]
    and $bf
    or h
    ld [wLinkRules + $5], a
    xor a
    ld [wTitleScreenSubState], a
    ret

; Draws the total-level number of the level rule (wLinkRules + 4/5, low six bits of the high byte)
; at BG row 8, column 14: a left arrow when it can go lower (4 or more), up to three digits without
; leading zeros, and a right arrow when it can go higher. (C1, E-0357)
RunLinkSession4ScreenState_EditRules_HLToDecimalDigits_2::
    ld a, [wLinkRules + $4]
    ld l, a
    ld a, [wLinkRules + $5]
    and $3f
    ld h, a
    push hl
    call HLToDecimalDigits
    pop de
    ld b, $c5
    ld a, e
    sub $04
    ld a, d
    sbc $00
    jr nc, .call_write_vram_byte_inc
    ld b, $c3

.call_write_vram_byte_inc:
    ld hl, vBGMap0 + $10e
    ld a, b
    call WriteVRAMByteInc
    ld c, $01
    ld a, [wDigits]
    add $e0
    cp $e0
    jr nz, .call_write_vram_byte_inc2
    ld c, $00
    ld a, $c3

.call_write_vram_byte_inc2:
    call WriteVRAMByteInc
    ld a, [wDigits + $1]
    add $e0
    cp $e0
    jr nz, .call_write_vram_byte_inc3
    bit 0, c
    jr nz, .call_write_vram_byte_inc3
    ld a, $c3

.call_write_vram_byte_inc3:
    call WriteVRAMByteInc
    ld a, [wDigits + $2]
    add $e0
    call WriteVRAMByteInc
    ld b, $c6
    ld a, e
    sub $29
    ld a, d
    sbc $01
    jr c, .call_write_vram_byte
    ld b, $c3

.call_write_vram_byte:
    ld a, b
    call WriteVRAMByte
    ret

; Draws the single-level limit (wLinkRules + 3) at BG row 10, column 14: a left arrow when 2 or
; more, two digits, and a right arrow below 99. (C1, E-0357)
RunLinkSession4ScreenState_EditRules_HLToDecimalDigits_3::
    ld a, [wLinkRules + $3]
    ld l, a
    ld h, $00
    push hl
    call HLToDecimalDigits
    pop de
    ld b, $c5
    ld a, e
    cp $02
    jr nc, .call_write_vram_byte_inc
    ld b, $c3

.call_write_vram_byte_inc:
    ld hl, vBGMap0 + $14e
    ld a, b
    call WriteVRAMByteInc
    ld a, $c3
    call WriteVRAMByteInc
    ld a, [wDigits + $1]
    add $e0
    cp $e0
    jr nz, .call_write_vram_byte_inc2
    ld a, $c3

.call_write_vram_byte_inc2:
    call WriteVRAMByteInc
    ld a, [wDigits + $2]
    add $e0
    call WriteVRAMByteInc
    ld b, $c6
    ld a, e
    cp $63
    jr c, .call_write_vram_byte
    ld b, $c3

.call_write_vram_byte:
    ld a, b
    call WriteVRAMByte
    ret

; Link rules editor, step 24, the third yes/no rule (wWorkBuf + 3): B goes back keeping it; A stores
; it and 'yes' moves to its values. (C1, E-0357)
RunLinkSession4ScreenState_EditRules_WriteWorkBufAndTitleScreenSubStateEtc_4::
    ld hl, wMenuSelectedMember
    ld de, CursorPositionWords_Bank07 + $30
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and $02
    jr z, .check_joypad_pressed
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf + $3], a
    xor a
    ld [wTitleScreenSubState], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $01
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf + $3], a
    or a
    jr z, .skip
    xor a
    ld [wTitleScreenSubState], a
    ret

.skip:
    ld hl, wTitleScreenSubState
    inc [hl]
    xor a
    ld [wLinkScreenFlag], a
    ret

; Link rules editor, step 25: draws the family panel and the mark of each of the 11 families
; (RunLinkSession4ScreenState_EditRules_CallDrawRuleMark). (C1, E-0357)
RunLinkSession4ScreenState_EditRules_CopyRecordRectToScreenBuffer_Bank07AndStep_CopyRect32StrideToVRAM_Bank07::
    ld hl, RunLinkSession4ScreenState_EditRules_CopyRecordRectToScreenBuffer_Bank07AndStep_TileRect
    call CopyRecordRectToScreenBuffer_Bank07
    ld hl, vBGMap0 + $62
    ld de, wScreenTileBuffer + $62
    lb bc, $0f, $0b
    call CopyRect32StrideToVRAM_Bank07
    call RunLinkSession4ScreenState_EditRules_CallDrawRuleMark
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Link rules editor, step 26, the family exclusions: the cursor moves over the 11 families; A
; toggles the selected family's bit in wLinkRules + 6/7 and redraws its mark; B returns, unless
; every family is excluded (sound $84 refuses it). (C1, E-0357)
RunLinkSession4ScreenState_EditRules_QueueSoundEffect::
    call RunLinkSession4ScreenState_EditRules_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and $02
    jr z, .check_joypad_pressed
    ld a, [wLinkRules + $6]
    and $7f
    cp $7f
    jr nz, .clear_title_screen_sub_state
    ld a, [wLinkRules + $7]
    and $f0
    cp $f0
    jr nz, .clear_title_screen_sub_state
    ld a, $84
    call QueueSoundEffect
    ret

.clear_title_screen_sub_state:
    xor a
    ld [wTitleScreenSubState], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $01
    ret z
    ld a, $69
    call QueueSoundEffect
    call RunLinkSession4ScreenState_EditRules_ReadMenuCursor
    ld a, [wMenuCursor]
    call RunLinkSession4ScreenState_EditRules_DrawRuleMark
    ret

; Toggles the family under the cursor: flips its bit (from the mask table
; RunLinkSession4ScreenState_EditRules_ReadMenuCursor_Data) in wLinkRules + 6 or + 7. (C1, E-0357)
RunLinkSession4ScreenState_EditRules_ReadMenuCursor::
    ld a, [wMenuCursor]
    ld hl, RunLinkSession4ScreenState_EditRules_ReadMenuCursor_Data
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld hl, wLinkRules + $6
    add_a_to_hl
    ld a, d
    cpl
    ld e, a
    ld a, [hl]
    and d
    jr z, .skip
    ld a, [hl]
    and e
    jr .done

.skip:
    ld a, [hl]
    or d

.done:
    ld [hl], a
    ret

; The family cursor: blinks every 8 frames and moves over two columns of entries (0-5 and 6-10):
; Up/Down switch column, Left/Right move within the order, wrapping. (C1, E-0357)
RunLinkSession4ScreenState_EditRules_EraseCursorAtEntryHL_Bank07::
    ld hl, wMenuCursor
    ld de, RunLinkSession4ScreenState_EditRules_EraseCursorAtEntryHL_Bank07_Data
    ld a, [wFrameCounterLo]
    and $07
    jr z, .check_joypad_pressed_repeat
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, .call_write_bb_tile_at_word_table_entry_c
    call EraseCursorAtEntryHL_Bank07
    jr .check_joypad_pressed_repeat

.call_write_bb_tile_at_word_table_entry_c:
    call WriteBBTileAtWordTableEntryC_Bank07

.check_joypad_pressed_repeat:
    ld c, [hl]
    ld a, [wJoypadPressedRepeat]
    and $c0
    jr z, .check_joypad_pressed_repeat2
    ld a, [hl]
    cp $05
    jr c, .skip
    jr z, .clear_frame_counter_lo
    sub $06
    jr .clear_frame_counter_lo

.skip:
    add $06
    jr .clear_frame_counter_lo

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    and $20
    jr z, .check_joypad_pressed_repeat3
    ld a, [hl]
    or a
    jr z, .skip2
    cp $06
    jr z, .skip3
    dec a
    jr .clear_frame_counter_lo

.skip2:
    ld a, $05
    jr .clear_frame_counter_lo

.skip3:
    ld a, $0a
    jr .clear_frame_counter_lo

.check_joypad_pressed_repeat3:
    ld a, [wJoypadPressedRepeat]
    and $10
    ret z
    ld a, [hl]
    cp $05
    jr z, .skip4
    cp $0a
    jr z, .skip5
    inc a
    jr .clear_frame_counter_lo

.skip4:
    xor a
    jr .clear_frame_counter_lo

.skip5:
    ld a, $06

.clear_frame_counter_lo:
    ld [hl], a
    xor a
    ld [wFrameCounterLo], a
    call WriteC3TileAtWordTableEntryC_Bank07
    call WriteBBTileAtWordTableEntryC_Bank07
    ret

; data read by RunLinkSession4ScreenState (22 bytes) (E-0347)
RunLinkSession4ScreenState_EditRules_EraseCursorAtEntryHL_Bank07_Data::
    db $43, $99, $45, $99, $47, $99, $49, $99, $4b, $99, $4d, $99, $83, $99, $85, $99
    db $87, $99, $89, $99, $8b, $99

; Draws the marks of all 11 families. (C1, E-0357)
RunLinkSession4ScreenState_EditRules_CallDrawRuleMark::
    ld bc, $0b00

.loop:
    push bc
    ld a, c
    call RunLinkSession4ScreenState_EditRules_DrawRuleMark
    pop bc
    inc c
    dec b
    jr nz, .loop
    ret

; tests the wLinkRules + 6 bit for rule A (mask table) and writes the rule's tile or the blank $C3
; into the BG map (E-0305)
RunLinkSession4ScreenState_EditRules_DrawRuleMark::
    ld c, a
    ld hl, RunLinkSession4ScreenState_EditRules_ReadMenuCursor_Data
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld hl, wLinkRules + $6
    add_a_to_hl
    ld e, [hl]
    ld a, c
    ld hl, vBGMap0 + $e4
    add_a_to_hl
    ld a, e
    and d
    ld a, $c3
    jr nz, .call_write_vram_byte
    ld a, c

.call_write_vram_byte:
    call WriteVRAMByte
    ret

; data read by RunLinkSession4ScreenState (22 bytes) (E-0347)
RunLinkSession4ScreenState_EditRules_ReadMenuCursor_Data::
    db $00, $40, $00, $20, $00, $10, $00, $08, $00, $04, $00, $02, $00, $01, $01, $80
    db $01, $40, $01, $20, $01, $10

; Link rules editor, step 27, the fourth yes/no rule (wWorkBuf + 4): B goes back keeping it; A
; stores it and 'yes' moves to its values. (C1, E-0357)
RunLinkSession4ScreenState_EditRules_WriteWorkBufAndTitleScreenSubStateEtc_5::
    ld hl, wMenuSelectedMember
    ld de, CursorPositionWords_Bank07 + $34
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and $02
    jr z, .check_joypad_pressed
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf + $4], a
    xor a
    ld [wTitleScreenSubState], a
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $01
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf + $4], a
    or a
    jr z, .skip
    xor a
    ld [wTitleScreenSubState], a
    ret

.skip:
    ld hl, wTitleScreenSubState
    inc [hl]
    xor a
    ld [wLinkScreenFlag], a
    ret

; Link rules editor, step 28: draws the turn limit panel and its number. (C1, E-0357)
RunLinkSession4ScreenState_EditRules_CopyRecordRectToScreenBuffer_Bank07AndStep_2::
    ld hl, RunLinkSession4ScreenState_EditRules_CopyRecordRectToScreenBuffer_Bank07AndStep_2_TileRect
    call CopyRecordRectToScreenBuffer_Bank07
    ld hl, vBGMap0 + $e1
    ld de, wScreenTileBuffer + $e1
    lb bc, $12, $05
    call CopyRect32StrideToVRAM_Bank07
    call RunLinkSession4ScreenState_EditRules_HLToDecimalDigits
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Link rules editor, step 29, the turn limit: Left/Right change wLinkRuleTurnLimit between 10 and 99
; (bit 7 kept); A or B return to the rule list. (C1, E-0357)
RunLinkSession4ScreenState_EditRules_SetTitleScreenSubState::
    ld a, [wJoypadPressed]
    and $03
    jr z, .check_joypad_pressed_repeat
    ld a, $69
    call QueueSoundEffect
    xor a
    ld [wTitleScreenSubState], a
    ret

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and $20
    jr z, .check_joypad_pressed_repeat2
    ld a, [wLinkRuleTurnLimit]
    and $80
    ld d, a
    ld a, [wLinkRuleTurnLimit]
    and $7f
    cp $0b
    jr c, .return
    dec a
    or d
    ld [wLinkRuleTurnLimit], a
    jr .call_run_link_session4_screen_state_edit

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    and $10
    jr z, .return
    ld a, [wLinkRuleTurnLimit]
    and $80
    ld d, a
    ld a, [wLinkRuleTurnLimit]
    and $7f
    cp $63
    jr nc, .return
    inc a
    or d
    ld [wLinkRuleTurnLimit], a

.call_run_link_session4_screen_state_edit:
    call RunLinkSession4ScreenState_EditRules_HLToDecimalDigits

.return:
    ret

; Draws the turn limit (wLinkRuleTurnLimit & $7F) at BG row 9, column 14: arrows when it can go
; lower (11 or more) or higher (below 99), and two digits. (C1, E-0357)
RunLinkSession4ScreenState_EditRules_HLToDecimalDigits::
    ld a, [wLinkRuleTurnLimit]
    and $7f
    push af
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld bc, wLinkTradeByte
    pop af
    cp $0b
    jr nc, .cp_63
    ld b, $c3

.cp_63:
    cp $63
    jr c, .call_write_vram_byte_inc
    ld c, $c3

.call_write_vram_byte_inc:
    ld hl, vBGMap0 + $12e
    ld a, b
    call WriteVRAMByteInc
    ld a, [wDigits + $1]
    add $e0
    cp $e0
    jr nz, .call_write_vram_byte_inc2
    ld a, $c3

.call_write_vram_byte_inc2:
    call WriteVRAMByteInc
    ld a, [wDigits + $2]
    add $e0
    call WriteVRAMByteInc
    ld a, c
    call WriteVRAMByte
    ret

; Link rules editor, step 30, the fifth yes/no rule (wWorkBuf + 5): A or B store the choice and
; return to the rule list. (C1, E-0357)
RunLinkSession4ScreenState_EditRules_QueueSoundEffect_RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07::
    ld hl, wMenuSelectedMember
    ld de, CursorPositionWords_Bank07 + $38
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and $03
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    ld [wWorkBuf + $5], a
    xor a
    ld [wTitleScreenSubState], a
    ret

; by wTitleScreenSubState: InitLinkRulesPresetA, a message, then link message exchange (E-0288)
RunLinkSession4ScreenState_StartWithPresetRules::
    ld a, [wTitleScreenSubState]
    jumptable
    dw RunLinkSession4ScreenState_StartWithPresetRules_InitLinkRulesPresetA
    dw RunLinkSession4ScreenState_ShowStringHL_Bank07AndStep
    dw RunLinkSession4ScreenState_StartWithPresetRules_WaitTextFlags
    dw RunLinkSession4ScreenState_StartWithPresetRules_CheckLinkMessage
    dw RunLinkSession4ScreenState_StartWithPresetRules_WaitTextFlags_SetLinkSendByte
    dw RunLinkSession4ScreenState_StartWithPresetRules_WaitLinkMessage
    dw RunLinkSession4ScreenState_StartWithPresetRules_WaitLinkMessage_SetLinkSendByte
    dw RunLinkSession4ScreenState_StartWithPresetRules_FillScreenTileBufferWithD
    dw RunLinkSession4ScreenState_StartWithPresetRules_QueueSoundEffect
    dw RunLinkSession4ScreenState_SetTitleScreenState
    dw RunLinkSession4ScreenState_AdvanceTitleScreenSubState
    dw RunLinkSession4ScreenState_SetLinkSendByte

; Start with preset rules, step 0: a partner's $FB, $FC or $FD sets the rules (preset A with battle
; kind 8, preset B with kind 9, or kind 8 with the current rules) and moves on; otherwise redraws
; the message window. (C1, E-0357)
RunLinkSession4ScreenState_StartWithPresetRules_InitLinkRulesPresetA::
    ld a, [wLinkMessage]
    cp $fb
    jr z, .call_init_link_rules_preset_a
    cp $fc
    jr z, .call_init_link_rules_preset_b
    cp $fd
    jr z, .set_battle_kind_to_08
    jr .call_copy_record_rect_to_screen_buffer_bank07

.call_init_link_rules_preset_a:
    call InitLinkRulesPresetA
    ld a, $08
    ld [wBattleKind], a
    ld a, $00
    ld [wLinkSetupMode], a
    ld a, $05
    ld [wTitleScreenState], a
    ret

.call_init_link_rules_preset_b:
    call InitLinkRulesPresetB
    ld a, $09
    ld [wBattleKind], a
    ld a, $01
    ld [wLinkSetupMode], a
    ld a, $05
    ld [wTitleScreenState], a
    ret

.set_battle_kind_to_08:
    ld a, $08
    ld [wBattleKind], a
    ld a, $04
    ld [wTitleScreenState], a
    ret

.call_copy_record_rect_to_screen_buffer_bank07:
    ld hl, TileRect_SaveCheckScreenRects_2
    call CopyRecordRectToScreenBuffer_Bank07
    ld hl, vBGMap0 + $1a0
    ld de, wWindowTileBuffer + $38
    lb bc, $14, $05
    call CopyRect32StrideToVRAM_Bank07
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Preset rules, step 1: shows message $0304 and clears the link byte. (C1, E-0357)
RunLinkSession4ScreenState_ShowStringHL_Bank07AndStep::
    ld hl, $0304
    call ShowStringHL_Bank07
    xor a
    ld [wLinkSendByte], a
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Preset rules, step 2: waits for the message. (C1, E-0357)
RunLinkSession4ScreenState_StartWithPresetRules_WaitTextFlags::
    ld a, [wTextFlags]
    or a
    ret nz
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Preset rules, step 3: the partner's $FE returns to the battle type choice; its 1 shows message
; $0305 and moves on. (C1, E-0357)
RunLinkSession4ScreenState_StartWithPresetRules_CheckLinkMessage::
    ld a, [wLinkMessage]
    cp $fe
    jr nz, .cp_01
    ld a, $02
    ld [wTitleScreenState], a
    ld a, $00
    ld [wTitleScreenSubState], a
    ld a, $01
    ld [wLinkScreenFlag], a
    ld a, $01
    ld [wLinkSendByte], a
    ret

.cp_01:
    cp $01
    ret nz
    ld hl, $0305
    call ShowStringHL_Bank07
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Preset rules, step 4: after the message sends link byte 2. (C1, E-0357)
RunLinkSession4ScreenState_StartWithPresetRules_WaitTextFlags_SetLinkSendByte::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, $02
    ld [wLinkSendByte], a
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Preset rules, step 5: on the partner's 2 starts receiving the partner's 10 rule bytes into
; wLinkRules (from wLinkRecvBuffer) and sends $FF. (C1, E-0357)
RunLinkSession4ScreenState_StartWithPresetRules_WaitLinkMessage::
    ld a, [wLinkMessage]
    cp $02
    ret nz
    ld a, $0a
    ld [wLinkBufferCountLo], a
    ld hl, wLinkRecvBuffer
    ld a, l
    ld [wLinkTimeoutLo], a
    ld a, h
    ld [wLinkTimeoutHi], a
    ld hl, wLinkRules
    ld a, l
    ld [wLinkBufferPtrLo], a
    ld a, h
    ld [wLinkBufferPtrHi], a
    ld a, $01
    ld [wLinkReady], a
    ld a, $ff
    ld [wLinkSendByte], a
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Preset rules, step 6: waits for the partner's $F0 (transfer done). (C1, E-0357)
RunLinkSession4ScreenState_StartWithPresetRules_WaitLinkMessage_SetLinkSendByte::
    ld a, [wLinkMessage]
    cp $f0
    ret nz
    xor a
    ld [wLinkSendByte], a
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Preset rules, step 7: draws the received rules (LoadInvertedBit7FlagsToWorkBuf,
; DrawWorkBufSelectionTilesAndPanels) with a yes/no question, and saves a copy
; (CopyLinkRulesToLinkRulesCopy). (C1, E-0357)
RunLinkSession4ScreenState_StartWithPresetRules_FillScreenTileBufferWithD::
    ld d, $c3
    call FillScreenTileBufferWithD
    ld hl, TileRect_SaveCheckScreenRects_2 + $1dc
    call CopyRecordRectToScreenBuffer_Bank07
    call LoadInvertedBit7FlagsToWorkBuf
    call DrawWorkBufSelectionTilesAndPanels
    call DrawScreenBufferToBGMap0_Bank07
    ld a, $02
    ld [wSubMenuCursor2], a
    ld a, $00
    ld [wMenuSelectedMember], a
    ld hl, wTitleScreenSubState
    inc [hl]
    call CopyLinkRulesToLinkRulesCopy
    ret

; Preset rules, step 8: the yes/no question. Yes accepts the partner's rules (wLinkSetupMode 2) and
; sends 1; no or B sends $FE and skips a step. (C1, E-0357)
RunLinkSession4ScreenState_StartWithPresetRules_QueueSoundEffect::
    ld hl, wMenuSelectedMember
    ld de, CursorPositionWords_Bank07 + $24
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and $01
    jr z, .check_joypad_pressed
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    and $01
    jr nz, .set_link_send_byte_to_FE
    ld a, $02
    ld [wLinkSetupMode], a
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $02
    ret z

.set_link_send_byte_to_FE:
    ld a, $fe
    ld [wLinkSendByte], a
    ld hl, wTitleScreenSubState
    inc [hl]
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Preset rules, step 9: on the partner's 1 goes to the battle (state 5). (C1, E-0357)
RunLinkSession4ScreenState_SetTitleScreenState::
    ld a, [wLinkMessage]
    cp $01
    ret nz
    ld a, $05
    ld [wTitleScreenState], a
    ld a, $01
    ld [wTitleScreenSubState], a
    xor a
    ld [wLinkScreenFlag], a
    ret

; Preset rules, step 10: moves on. (C1, E-0357)
RunLinkSession4ScreenState_AdvanceTitleScreenSubState::
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Preset rules, step 11: sends 1 and returns to the battle type choice. (C1, E-0357)
RunLinkSession4ScreenState_SetLinkSendByte::
    ld a, $01
    ld [wLinkSendByte], a
    ld a, $02
    ld [wTitleScreenState], a
    xor a
    ld [wLinkScreenFlag], a
    xor a
    ld [wTitleScreenSubState], a
    ret

; Link battle set-up, state 5. First call: on the side not driving the clock, the partner's $FE
; returns to rules editing and its $FD sets battle kind 8 (state 4); on that side a partner's $FC or
; $FB that differs from this side's choice applies preset rules A (kind 8) or B (kind 9). It then
; goes to state 8. Later calls blank the screen, clear the link bytes and move to the next state.
; (C1, E-0357)
RunLinkSession4ScreenState_WriteLinkSendByteAndLinkReadyEtc::
    ld a, [wTitleScreenSubState]
    and a
    jr z, .check_link_message
    jp .skip

.check_link_message:
    ld a, [wLinkMessage]
    cp $fe
    jr z, .check_link_role
    cp $fd
    jr z, .check_link_role2
    jr .check_link_message2

.check_link_role:
    ld a, [wLinkRole]
    bit 1, a
    jp z, .set_title_screen_state_to_08
    ld a, $01
    ld [wTitleScreenSubState], a
    ld a, $01
    ld [wLinkScreenFlag], a
    ld a, $01
    ld [wLinkSendByte], a
    ld a, $02
    ld [wTitleScreenState], a
    ret

.check_link_role2:
    ld a, [wLinkRole]
    bit 1, a
    jr z, .set_title_screen_state_to_08
    ld a, $08
    ld [wBattleKind], a
    ld a, $04
    ld [wTitleScreenState], a
    xor a
    ld [wLinkSendByte], a
    ret

.check_link_message2:
    ld a, [wLinkMessage]
    cp $fc
    jr z, .check_menu_state
    cp $fb
    jr z, .check_menu_state
    jr .set_title_screen_state_to_08

.check_menu_state:
    ld a, [wMenuState]
    and a
    jr z, .check_link_message3
    ld a, [wLinkMessage]
    cp $fc
    jr z, .set_title_screen_state_to_08
    ld a, [wLinkRole]
    bit 1, a
    jr z, .set_title_screen_state_to_08
    call InitLinkRulesPresetA
    ld a, $08
    ld [wBattleKind], a
    ld a, $00
    ld [wLinkSetupMode], a
    ld a, $05
    ld [wTitleScreenState], a
    jr .set_title_screen_state_to_08

.check_link_message3:
    ld a, [wLinkMessage]
    cp $fb
    jr z, .set_title_screen_state_to_08
    ld a, [wLinkRole]
    bit 1, a
    jr z, .set_title_screen_state_to_08
    call InitLinkRulesPresetB
    ld a, $09
    ld [wBattleKind], a
    ld a, $01
    ld [wLinkSetupMode], a
    ld a, $05
    ld [wTitleScreenState], a
    jr .set_title_screen_state_to_08

.set_title_screen_state_to_08:
    ld a, $08
    ld [wTitleScreenState], a
    ld a, $00
    ld [wTitleScreenSubState], a
    ret

.skip:
    ld hl, wScreenTileBuffer
    ld bc, $0280
    ld a, $c3
    call FillBytes
    call DrawScreenBufferToBGMap0_Bank07
    xor a
    ld [wLinkSendByte], a
    xor a
    ld [wLinkReady], a
    ld hl, wTitleScreenState
    inc [hl]
    ret

; Link set-up, state 6: decompresses the next screen's graphics
; (RunLinkSession4ScreenState_DecompressToVRAM) and moves on. (C1, E-0357)
RunLinkSession4ScreenState_DecompressToVRAMAndStep::
    farcall RunLinkSession4ScreenState_DecompressToVRAM
    ld hl, wTitleScreenState
    inc [hl]
    ret

; Link set-up, state 7: runs the egg service menu (EggServiceMenu_Bank1B). (C1, E-0357)
RunLinkSession4ScreenState_ToEggServiceMenu_Bank1B::
    farcall EggServiceMenu_Bank1B
    ret

; draws a tile at wScreenTileBuffer + $68, wScreenTileBuffer + $CE, wScreenTileBuffer + $10E,
; wScreenTileBuffer + $14E, wWindowTileBuffer + $26 or wWindowTileBuffer + $66 (or 6/3 past it)
; depending on wWorkBuf-wWorkBuf + $5, then runs the four panel routines
; DrawWorkBufSelectionTilesAndPanels_ReadLinkRules, 7B9D, 7C07 and 7C5F (E-0121)
DrawWorkBufSelectionTilesAndPanels::
    ld a, [wWorkBuf]
    ld hl, wScreenTileBuffer + $68
    ld bc, $0006
    call WriteBCTileAtHLOrHLPlusBC
    ld a, [wWorkBuf + $1]
    ld hl, wScreenTileBuffer + $ce
    ld bc, $0003
    call WriteBCTileAtHLOrHLPlusBC
    ld a, [wWorkBuf + $2]
    ld hl, wScreenTileBuffer + $10e
    ld bc, $0003
    call WriteBCTileAtHLOrHLPlusBC
    ld a, [wWorkBuf + $3]
    ld hl, wScreenTileBuffer + $14e
    ld bc, $0003
    call WriteBCTileAtHLOrHLPlusBC
    ld a, [wWorkBuf + $4]
    ld hl, wWindowTileBuffer + $26
    ld bc, $0003
    call WriteBCTileAtHLOrHLPlusBC
    ld a, [wWorkBuf + $5]
    ld hl, wWindowTileBuffer + $66
    ld bc, $0003
    call WriteBCTileAtHLOrHLPlusBC
    call DrawWorkBufSelectionTilesAndPanels_ReadLinkRules
    call DrawWorkBufSelectionTilesAndPanels_ReadLinkRulesAndDigits
    call DrawWorkBufSelectionTilesAndPanels_ReadLinkRules_2
    call DrawWorkBufSelectionTilesAndPanels_HLToDecimalDigits
    ret

; writes tile $BC at HL when A = 0, else at HL + BC (E-0079)
WriteBCTileAtHLOrHLPlusBC::
    or a
    jr z, .done
    add hl, bc

.done:
    ld [hl], $bc
    ret

; Draws the yes/no marks of the link rules on the rules summary: for each rule bit of wLinkRules + 1
; (bits 6 down to 0) tile $16 (off) or a digit tile from the matching bit of wLinkRules + 2. (C1,
; E-0357)
DrawWorkBufSelectionTilesAndPanels_ReadLinkRules::
    ld a, [wLinkRules + $1]
    ld c, a
    ld a, [wLinkRules + $2]
    ld b, a
    ld hl, wScreenTileBuffer + $e7
    ld a, $16
    bit 6, c
    jr z, .skip
    ld a, b
    rlca
    rlca
    and $01
    add $e0

.skip:
    ld [hli], a
    ld a, $16
    bit 5, c
    jr z, .skip2
    ld a, b
    rrca
    swap a
    and $01
    add $e0

.skip2:
    ld [hli], a
    ld a, $16
    bit 4, c
    jr z, .skip3
    ld a, b
    swap a
    and $01
    add $e0

.skip3:
    ld [hli], a
    ld a, $16
    bit 3, c
    jr z, .skip4
    ld a, b
    rlca
    swap a
    and $01
    add $e0

.skip4:
    ld [hli], a
    ld a, $16
    bit 2, c
    jr z, .skip5
    ld a, b
    rrca
    rrca
    and $01
    add $e0

.skip5:
    ld [hli], a
    ld a, $16
    bit 1, c
    jr z, .skip6
    ld a, b
    rrca
    and $01
    add $e0

.skip6:
    ld [hli], a
    ld a, $16
    bit 0, c
    jr z, .done
    ld a, b
    and $01
    add $e0

.done:
    ld [hli], a
    ret

; Draws the level rule on the rules summary: the label (DrawWorkBufSelectionTilesAndPanels_Data1, or
; Data2 for the single-level form when wLinkRules + 5 bit 6 is set) and the number (wLinkRules + 3,
; or the total from wLinkRules + 4/5). (C1, E-0357)
DrawWorkBufSelectionTilesAndPanels_ReadLinkRulesAndDigits::
    ld de, DrawWorkBufSelectionTilesAndPanels_Data1
    ld a, [wLinkRules + $5]
    bit 6, a
    jr z, .read_link_rules
    ld de, DrawWorkBufSelectionTilesAndPanels_Data2
    ld a, [wLinkRules + $3]
    ld c, a
    ld b, $00
    jr .skip

.read_link_rules:
    ld a, [wLinkRules + $4]
    ld c, a
    ld a, [wLinkRules + $5]
    and $01
    ld b, a

.skip:
    push bc
    ld hl, wScreenTileBuffer + $126
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
    ld [hl], a
    inc hl
    inc de
    ld a, [de]
    ld [hl], a
    pop hl
    call HLToDecimalDigits
    ld c, $01
    ld hl, wScreenTileBuffer + $12c
    ld a, [wDigits]
    add $e0
    cp $e0
    jr nz, .read_digits
    ld c, $00
    ld a, $c3

.read_digits:
    ld [hli], a
    ld a, [wDigits + $1]
    add $e0
    cp $e0
    jr nz, .read_digits2
    bit 0, c
    jr nz, .read_digits2
    ld a, $c3

.read_digits2:
    ld [hli], a
    ld a, [wDigits + $2]
    add $e0
    ld [hl], a
    ret

; data read by DrawWorkBufSelectionTilesAndPanels (5 bytes) (E-0347)
DrawWorkBufSelectionTilesAndPanels_Data1::
    db $15, $12, $15, $0b, $10

DrawWorkBufSelectionTilesAndPanels_Data2::
    db $29, $0b, $16, $c3, $c3

; Draws the excluded families on the rules summary: for each family bit of wLinkRules + 6/7 that is
; clear, writes its icon tile number (0, 1, 2, ...) at wScreenTileBuffer + $163 onward. (C1, E-0357)
DrawWorkBufSelectionTilesAndPanels_ReadLinkRules_2::
    ld a, [wLinkRules + $6]
    ld e, a
    ld a, [wLinkRules + $7]
    ld d, a
    ld hl, wScreenTileBuffer + $163
    xor a
    bit 6, e
    jr nz, .skip
    ld [hl], a

.skip:
    inc a
    inc hl
    bit 5, e
    jr nz, .skip2
    ld [hl], a

.skip2:
    inc a
    inc hl
    bit 4, e
    jr nz, .skip3
    ld [hl], a

.skip3:
    inc a
    inc hl
    bit 3, e
    jr nz, .skip4
    ld [hl], a

.skip4:
    inc a
    inc hl
    bit 2, e
    jr nz, .skip5
    ld [hl], a

.skip5:
    inc a
    inc hl
    bit 1, e
    jr nz, .skip6
    ld [hl], a

.skip6:
    inc a
    inc hl
    bit 0, e
    jr nz, .skip7
    ld [hl], a

.skip7:
    inc a
    inc hl
    bit 7, d
    jr nz, .skip8
    ld [hl], a

.skip8:
    inc a
    inc hl
    bit 6, d
    jr nz, .skip9
    ld [hl], a

.skip9:
    inc a
    inc hl
    bit 5, d
    jr nz, .skip10
    ld [hl], a

.skip10:
    inc a
    inc hl
    bit 4, d
    jr nz, .return
    ld [hl], a

.return:
    ret

; Draws the turn limit on the rules summary (wLinkRuleTurnLimit without bit 7, one or two digits) in
; wWindowTileBuffer. (C1, E-0357)
DrawWorkBufSelectionTilesAndPanels_HLToDecimalDigits::
    ld a, [wLinkRuleTurnLimit]
    ld l, a
    res 7, l
    ld h, $00
    call HLToDecimalDigits
    ld hl, wWindowTileBuffer + $46
    ld a, [wDigits + $1]
    or a
    jr z, .read_digits
    add $e0
    ld [hl], a

.read_digits:
    inc hl
    ld a, [wDigits + $2]
    add $e0
    ld [hl], a
    ret

; fills the screen buffer, plays a sound, sets the link state and send bytes (E-0303)
RunLinkSession4ScreenState_ResetAndSignal::
    ld a, [wTitleScreenSubState]
    jumptable
    dw RunLinkSession4ScreenState_ResetAndSignal_FillScreenTileBufferWithD
    dw RunLinkSession4ScreenState_ResetAndSignal_QueueSoundEffect
    dw RunLinkSession4ScreenState_ResetAndSignal_CheckLinkMessage
    dw RunLinkSession4ScreenState_ResetAndSignal_SetLinkSendByte
    dw RunLinkSession4ScreenState_ResetAndSignal_SetLinkSendByte_SetLinkSendByte

; Reset and signal, step 0: unless the partner sent $FE, draws the rules summary with a yes/no
; question. (C1, E-0357)
RunLinkSession4ScreenState_ResetAndSignal_FillScreenTileBufferWithD::
    ld a, [wLinkMessage]
    cp $fe
    jp z, RunLinkSession4ScreenState_ResetAndSignal_SetLinkSendByte_SetLinkSendByte
    ld d, $c3
    call FillScreenTileBufferWithD
    ld hl, TileRect_SaveCheckScreenRects_2 + $1dc
    call CopyRecordRectToScreenBuffer_Bank07
    call LoadInvertedBit7FlagsToWorkBuf
    call DrawWorkBufSelectionTilesAndPanels
    call DrawScreenBufferToBGMap0_Bank07
    ld a, $02
    ld [wSubMenuCursor2], a
    ld a, $00
    ld [wMenuSelectedMember], a
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Reset and signal, step 1: the yes/no question: yes sends 1 and moves on; no or B sends $FE and
; skips a step; a partner's $FE ends at step 4. (C1, E-0357)
RunLinkSession4ScreenState_ResetAndSignal_QueueSoundEffect::
    ld a, [wLinkMessage]
    cp $fe
    jr z, RunLinkSession4ScreenState_ResetAndSignal_SetLinkSendByte_SetLinkSendByte
    ld hl, wMenuSelectedMember
    ld de, CursorPositionWords_Bank07 + $24
    call RunLinkSession4ScreenState_EraseCursorAtEntryHL_Bank07
    ld a, [wJoypadPressed]
    and $01
    jr z, .check_joypad_pressed
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    and $01
    jr nz, .set_link_send_byte_to_FE
    ld a, $01
    ld [wLinkSendByte], a
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $02
    ret z

.set_link_send_byte_to_FE:
    ld a, $fe
    ld [wLinkSendByte], a
    ld hl, wTitleScreenSubState
    inc [hl]
    ld hl, wTitleScreenSubState
    inc [hl]
    ret

; Reset and signal, step 2: on the partner's 1 goes to the battle (state 5); its $FE goes to step 4.
; (C1, E-0357)
RunLinkSession4ScreenState_ResetAndSignal_CheckLinkMessage::
    ld a, [wLinkMessage]
    cp $fe
    jr z, RunLinkSession4ScreenState_ResetAndSignal_SetLinkSendByte_SetLinkSendByte
    cp $01
    ret nz
    ld a, $05
    ld [wTitleScreenState], a
    ld a, $01
    ld [wTitleScreenSubState], a
    xor a
    ld [wLinkScreenFlag], a
    ret

; Reset and signal, step 3: sends 1 and returns to the battle type choice. (C1, E-0357)
RunLinkSession4ScreenState_ResetAndSignal_SetLinkSendByte::
    ld a, $01
    ld [wLinkSendByte], a
    ld a, $02
    ld [wTitleScreenState], a
    xor a
    ld [wTitleScreenSubState], a
    xor a
    ld [wLinkScreenFlag], a
    ret

; Reset and signal, step 4: sends 1 and returns to the battle type choice in rules-editing mode
; (wLinkScreenFlag 1). (C1, E-0357)
RunLinkSession4ScreenState_ResetAndSignal_SetLinkSendByte_SetLinkSendByte::
    ld a, $01
    ld [wLinkSendByte], a
    ld a, $02
    ld [wTitleScreenState], a
    xor a
    ld [wTitleScreenSubState], a
    ld a, $01
    ld [wLinkScreenFlag], a
    ret

; Link session 5's per-frame exchange: exchanges the joypad; on the record screens redraws the
; species sprites; when the link scene is set, completes the link breeding
; (RunLinkSession4ScreenState_ResetAndSignal_ComputeBreedingChild) and enters the field (game mode
; 1) on map $14 at ($E0, 0) with talk event $21, an empty party and the rest of the field state
; reset. (C1, E-0357)
RunLinkSession4ScreenState_CallLinkExchangeJoypadPerFrame::
    call LinkExchangeJoypadPerFrame
    ld a, [wTitleScreenState]
    cp $01
    jr z, .check_screen_state
    ret

.check_screen_state:
    ld a, [wScreenState]
    cp $0c
    jr z, .check_screen_sub_step
    cp $0d
    jr z, .check_screen_step
    ld a, [wLinkScene]
    or a
    ret z
    call RunLinkSession4ScreenState_ResetAndSignal_ComputeBreedingChild
    ld a, $01
    ld [wGameMode], a
    ld a, $01
    ld [wModeChangeRequest], a
    xor a
    ld [wMapType], a
    xor a
    ld [wTalkEventIndex], a
    ld a, $21
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    farcall FetchScriptCommand
    ld a, $e0
    ldh [hPlayerX], a
    ld a, $00
    ldh [hPlayerY], a
    ldh [hMapScreenX], a
    ldh [hMapScreenY], a
    ld a, $14
    ldh [hMapId], a
    xor a
    ldh [hPlayerStateFlags], a
    ld [wPartyCount], a
    xor a
    ld [wFieldReturnPhase], a
    ld a, [wSaveStateFlag]
    ld [wLinkSaveStateFlag], a
    xor a
    ld [wSaveStateFlag], a
    xor a
    ld [wLinkMode], a
    ld [wLinkScene], a
    ld [wScriptInDataBank], a
    ld [wMessageMode], a
    ret

.check_screen_sub_step:
    ld a, [wScreenSubStep]
    and a
    ret nz
    ld a, [wScreenStep]
    cp $15
    jr z, .call_draw_list_entries_cell5_species_sprite
    cp $20
    jr z, .call_call_draw_party_species_sprites
    ret

.call_draw_list_entries_cell5_species_sprite:
    farcall DrawListEntriesCell5SpeciesSprite
    ret

.call_call_draw_party_species_sprites:
    farcall CallDrawPartySpeciesSpritesPreservingArg1AndTemp0
    ret

.check_screen_step:
    ld a, [wScreenStep]
    cp $15
    jr z, .call_draw_record_buf_b_species_sprite_part
    cp $20
    jr z, .call_draw_record_buf_b_species_sprites
    ret

.call_draw_record_buf_b_species_sprite_part:
    farcall DrawRecordBufBSpeciesSpritePart_BankF1
    ret

.call_draw_record_buf_b_species_sprites:
    farcall DrawRecordBufBSpeciesSprites
    ret
    db $c9

; Completes a link breeding on the clock-driving side: computes the child (ComputeBreedingChild with
; wArg1 = 2), deletes the chosen parent's record (DeleteSRAMRecordAndCompact) and writes the child's
; $A5-byte record in its place, then saves; the other side clears its breeding result. (C1, E-0357)
RunLinkSession4ScreenState_ResetAndSignal_ComputeBreedingChild::
    ld a, [wLinkRole]
    bit 1, a
    jp z, .clear_link_breed_result
    ld a, $02
    ld [wArg1], a
    farcall ComputeBreedingChild
    ld a, [wItemGridX]
    ld [wListCursor], a
    ld a, [wItemGridY]
    ld [wListPageIndex], a
    farcall SetArg5ToListEntriesCell5
    ld a, [wArg5]
    ld h, a
    ld a, [wArg6]
    ld l, a
    ld a, [hl]
    ld [wArg1], a
    ld a, $01
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    ld a, $0a
    ld [rRAMG2], a
    xor a
    ld [rRAMB], a
    ld a, [wArg6]
    ld l, a
    ld a, [wArg7]
    ld h, a
    ld de, wChildRecord
    ld b, $a5

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec b
    jr nz, .loop
    xor a
    ld [rRAMG2], a
    xor a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld hl, wChildRecord + MON_SPECIES
    ld a, [hli]
    ld [wArg1], a
    ld a, [hl]
    ld [wArg2], a
    ld de, wMonsterLibraryBuf
    ld a, e
    ld [wArg3], a
    ld a, d
    ld [wArg4], a
    farcall SetBitInFieldAtArg3
    ld hl, wPackWork
    ld b, $07

.loop2:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop2

.clear_link_breed_result:
    xor a
    ld [wLinkBreedResult], a
    xor a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a

.loop3:
    farcall RunSaveGameSteps
    ld a, [wSaveStep]
    bit 7, a
    jr z, .loop3
    ld hl, wScreenState
    ld bc, $006f

.loop4:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop4
    ret
    ds $16c, $00
