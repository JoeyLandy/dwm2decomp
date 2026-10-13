; ROM bank $01: debug menu: message test, debug battle set-up, monster creation, results
; The annotated listing of this bank is build/listing/bank01.asm.

SECTION "Bank 01", ROMX[$4000], BANK[$01]
    db $01

; start-up for wGameMode = 0; forcing this mode on the emulator shows: debug menu (E-0029)
GameMode0_Init::
    ld hl, vTiles1
    ld de, $1007
    call FillTilesRequest
    ld hl, vTiles2
    ld de, $1007
    call FillTilesRequest
    xor a
    ld [wDebugCursor], a
    ld [wDebugValue0], a
    ld [wDebugValue1], a
    ld [wDebugValue2], a
    ld [wDebugValue3], a
    ld [wDebugState], a
    ld [wDebugSubState], a
    ld [wDebugCounter], a
    xor a
    ld [wDebugByteF6], a
    ld [wDebugByteF7], a
    call DebugMode_InitByModeState
    ld a, $fc
    call StartPaletteFade
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $01
    jp ClearSGBPacketBuffer_CheckLinkMode

; jumps by wModeState to the init routine of each debug screen (menu, map editor, automap, picture
; viewer, sound test, battle setup, results, staff roll, skill viewer, record viewer, message test)
DebugMode_InitByModeState::
    ld a, [wModeState]
    jumptable
    dw DebugMainMenu_Init
    dw DebugMainMenu_Init
    dw DebugMapEditor_Init
    dw DebugAutomap_Init
    dw DebugMonsterPictureViewer_Init
    dw DebugSoundTest_Init
    dw DebugBattleSetup_Init
    dw DebugResultsDisplay_Init
    dw DebugStaffRoll_Init
    dw DebugSkillViewer_Init
    dw DebugMonsterRecordViewer_Init
    dw DebugMessageTest_Init

; init for debug-mode state 11: the screen shows 'LIBNO / MESNO' message test (E-0041)
DebugMessageTest_Init::
    call LoadPalette0FromData4ACC
    ld hl, vTiles2 + $100
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1001
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vTiles2 + $300
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1207
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld hl, vBGMap0 + $1c1
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    ld hl, vTiles2 + $200
    ld de, Tiles2Plus200Tiles_1F_4160
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $210
    ld de, Tiles2Plus210Tiles_1F_4130
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $220
    ld de, Tiles1Plus6E0Tiles_1F_4180
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $230
    ld de, Tiles2Plus230Tiles_1F_4190
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $240
    ld de, Tiles2Plus240Tiles_1F_4170
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $250
    ld de, Tiles2Plus250Tiles_1F_41D0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a
    ld [wDebugCursor], a
    ld [wDebugValue0], a
    ld [wDebugValue1], a
    ld [wDebugValue2], a
    ld [wDebugValue3], a
    ld [wDebugState], a
    ld [wDebugSubState], a
    ld [wDebugCounter], a
    ld a, $01
    ld de, TileRect_01_412F
    ld hl, vBGMap0
    lb bc, $14, $12
    call CopyRectFromBankToVRAM
    xor a
    ld [wMenuState], a
    xor a
    ld [wTemp0], a
    ld [wTemp1], a
    xor a
    ld [wMenuRowCount], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 20 x 18 tiles, one row per line
TileRect_01_412F::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 1
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 2
    db $00, $00, $00, $00, $20, $21, $1b, $22, $23, $00, $00, $00, $00, $10, $10, $00, $00, $00, $00, $00 ; id 3
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 4
    db $00, $00, $00, $00, $24, $1e, $25, $22, $23, $10, $00, $00, $00, $10, $10, $00, $00, $00, $00, $00 ; id 5
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 6
    db $00, $00, $00, $00, $24, $1e, $25, $22, $23, $11, $00, $00, $00, $10, $10, $00, $00, $00, $00, $00 ; id 7
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 8
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 9
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 10
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 11
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 12
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 13
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 14
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 15
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 16
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 17

; init for debug-mode state 10: the screen shows the monster record viewer (E-0041)
DebugMonsterRecordViewer_Init::
    ld a, $0f
    ld [wStringCategory], a
    ld a, $01
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld a, $01
    ld de, TileRect_01_42BC
    ld hl, vBGMap0
    lb bc, $14, $12
    call CopyRectFromBankToVRAM
    ld hl, $0000
    call DebugShowMonsterRecord
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 20 x 18 tiles, one row per line
TileRect_01_42BC::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 0
    db $00, $00, $00, $00, $00, $00, $00, $11, $40, $41, $42, $43, $44, $45, $46, $47, $48, $00, $00, $00 ; id 1
    db $00, $12, $13, $14, $15, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 2
    db $00, $17, $15, $18, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 3
    db $00, $0f, $1a, $1b, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 4
    db $00, $1c, $19, $1d, $19, $15, $1e, $1f, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 5
    db $00, $20, $21, $22, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 6
    db $00, $23, $24, $25, $24, $26, $27, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 7
    db $00, $23, $24, $25, $24, $28, $27, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 8
    db $00, $29, $16, $2a, $2b, $1e, $2c, $15, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 9
    db $00, $12, $13, $2d, $1e, $2c, $15, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 10
    db $00, $2e, $2f, $30, $23, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 11
    db $00, $19, $12, $29, $23, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 12
    db $00, $31, $16, $19, $23, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 13
    db $00, $12, $1e, $2c, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 14
    db $00, $33, $34, $24, $30, $1e, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 15
    db $00, $30, $35, $2b, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 16
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 17

; init for debug-mode state 9: the screen shows the skill viewer (E-0041)
DebugSkillViewer_Init::
    ld a, $0f
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld a, $01
    ld de, TileRect_01_6F30
    ld hl, vBGMap0
    lb bc, $14, $12
    call CopyRectFromBankToVRAM
    ld a, [wIsCGB]
    or a
    jr z, .skip
    ld a, $01
    ldh [rVBK], a
    xor a
    ld hl, vBGMap0
    ld bc, $0400
    call FillBytes
    ld a, $00
    ldh [rVBK], a

.skip:
    xor a
    ld hl, wDebugCursor
    ld [hli], a
    dec a
    ld [hl], a
    ret

; init for debug-mode state 8: the screen shows the staff roll (SCENARIO & GAME DESIGNERS, YUJI
; HORII, ENIX, TOSE, FUMINORI ISHIKAWA) (E-0041)
DebugStaffRoll_Init::
    ld a, $31
    call QueueMusic
    xor a
    ld hl, wWorkBuf
    ld bc, $0038
    call FillBytes
    ret

; init for debug-mode state 7: the screen shows 'RESULTS DISPLAY' (species, gender) (E-0041)
DebugResultsDisplay_Init::
    call LoadPalette0FromData4ACC
    ld hl, vTiles2 + $100
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1001
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1005
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a
    ld [wStringCategory], a
    ld a, $27
    ld [wStringIndex], a ; 'RESULTS DISPLAY Species Gender'
    farcall ShowString_Bank1B_4C94
    ld hl, vBGMap0 + $60
    lb bc, $10, $01
    ld a, $80
    call FillRectWithTileSequence
    ld hl, vBGMap0 + $a0
    lb bc, $10, $04
    ld a, $90
    call FillRectWithTileSequence
    ld hl, vBGMap0 + $120
    lb bc, $10, $02
    ld a, $b0
    call FillRectWithTileSequence
    ld a, $fc
    ld [vBGMap0 + $181], a
    ld [vBGMap0 + $1e1], a
    ld [vBGMap0 + $1], a
    ld a, $fd
    ld [vBGMap0 + $1a1], a
    ld [vBGMap0 + $201], a
    ld [vBGMap0 + $21], a
    ld a, $fb
    ld [vBGMap0 + $1c1], a
    ld [vBGMap0 + $221], a
    ld de, Tiles1Plus7E0Tiles_1F_4A80
    ld hl, vTiles1 + $7e0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus7F0Tiles_1F_4A90
    ld hl, vTiles1 + $7f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus7C0Tiles_1F_4780
    ld hl, vTiles1 + $7c0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, DebugResultsDisplay_Init_Data
    ld hl, vTiles1 + $7c0
    ld b, $1f
    ld c, $10
    call OrFromBankWaitVRAM
    ld de, Tiles2Plus200Tiles_1F_4160
    ld hl, vTiles1 + $7d0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus7B0Tiles_1F_4480
    ld hl, vTiles1 + $7b0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $200
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, vTiles2 + $300
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    call FillTilesFromRequest
    ld hl, vTiles2 + $400
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    call FillTilesFromRequest
    ld hl, vTiles2 + $500
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    call FillTilesFromRequest
    ld hl, vBGMap0 + $8a
    lb bc, $09, $01
    ld a, $20
    call FillRectWithTileSequence
    ld hl, vBGMap0 + $ea
    lb bc, $09, $01
    ld a, $30
    call FillRectWithTileSequence
    ld hl, vBGMap0 + $12a
    lb bc, $09, $01
    ld a, $40
    call FillRectWithTileSequence
    ld hl, vBGMap0 + $aa
    lb bc, $09, $01
    ld a, $50
    call FillRectWithTileSequence
    xor a
    ld [wArg1], a
    add $10
    ld [vBGMap0 + $81], a
    xor a
    ld [wDebugCursor], a
    ld [wDebugValue0], a
    ld [wDebugValue1], a
    ld [wDebugValue2], a
    ld [wDebugValue3], a
    ld [wDebugState], a
    ld [wDebugSubState], a
    ld [wDebugCounter], a
    ld hl, wScreenState
    ld b, $60

.loop:
    xor a
    ld [wScreenState], a
    dec b
    jr nz, .loop
    ret

; init for debug-mode state 0: the screen shows the debug menu (E-0041)
DebugMainMenu_Init::
    call LoadPalette0FromData4ACC
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1008
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a
    ld [wStringCategory], a
    ld a, $01
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vBGMap0 + $a3
    lb bc, $10, $02
    ld a, $80
    call FillRectWithTileSequence
    ret

; init for debug-mode state 2: the screen shows '? EDIT ?' (world, map number, position) (E-0041)
DebugMapEditor_Init::
    ld hl, vTiles2 + $100
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1001
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1008
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a
    ld [wStringCategory], a
    ld a, $02
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vBGMap0 + $a3
    lb bc, $10, $07
    ld a, $80
    call FillRectWithTileSequence
    ld a, $01
    ld de, TileRect_01_46A4
    ld hl, vBGMap0 + $ea
    lb bc, $10, $01
    call CopyRectFromBankToVRAM
    xor a
    ld [wDebugCursor], a
    ldh a, [hMapId]
    ld [wDebugValue0], a
    ldh a, [hMapScreenX]
    ld [wDebugValue1], a
    ldh a, [hPlayerX]
    ld [wDebugValue2], a
    ldh a, [hMapScreenY]
    ld [wDebugValue3], a
    ldh a, [hPlayerY]
    ld [wDebugState], a
    ld a, $01
    ld [wDebugSubState], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 16 x 1 tiles, one row per line
TileRect_01_46A4::
    db $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2a, $2b, $2c, $2d, $2e, $2f ; id 0

; init for debug-mode state 3: the screen shows '? AUTOMAP ?' (key, level, position) (E-0041)
DebugAutomap_Init::
    ld hl, vTiles2 + $100
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1001
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1008
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a
    ld [wStringCategory], a
    ld a, $04
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vBGMap0 + $a3
    lb bc, $10, $07
    ld a, $80
    call FillRectWithTileSequence
    ld a, $01
    ld de, TileRect_01_4733
    ld hl, vBGMap0 + $ea
    lb bc, $10, $01
    call CopyRectFromBankToVRAM
    xor a
    ld [wDebugCursor], a
    ld a, [wCurrentKeyIndex]
    push af
    call LoadKeyEntryFieldsToDebugState
    pop af
    or $80
    ld [wDebugValue0], a
    ldh a, [hMapScreenX]
    ld [wDebugValue2], a
    ldh a, [hMapScreenY]
    ld [wDebugValue3], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 16 x 1 tiles, one row per line
TileRect_01_4733::
    db $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2a, $2b, $2c, $2d, $2e, $2f ; id 0

; init for debug-mode state 4: the screen shows 'MONSTER BGSD CHARA': monster picture and sprite
; viewer (E-0041)
DebugMonsterPictureViewer_Init::
    ld hl, vTiles2 + $100
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1001
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1008
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vBGMap0 + $a3
    lb bc, $10, $02
    ld a, $80
    call FillRectWithTileSequence
    ld a, $01
    ld de, TileRect_01_47DE
    ld hl, vBGMap0 + $124
    lb bc, $06, $06
    call CopyRectFromBankToVRAM
    ld a, [wIsCGB]
    or a
    jr z, .set_debug_value0_to_00
    ld c, $4f
    ld a, $01
    ldh [c], a
    ld a, $01
    ld de, TileRect_01_4802
    ld hl, vBGMap0 + $124
    lb bc, $06, $06
    call CopyRectFromBankToVRAM
    ld c, $4f
    ld a, $00
    ldh [c], a

.set_debug_value0_to_00:
    ld a, $00
    ld [wDebugValue0], a
    ld a, $80
    ld [wDebugValue1], a
    ld a, $00
    ld [wDebugValue2], a
    ld a, $80
    ld [wDebugValue3], a
    ld a, $00
    ld [wDebugState], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 6 x 6 tiles, one row per line
TileRect_01_47DE::
    db $20, $21, $22, $23, $24, $25 ; id 0
    db $26, $27, $28, $29, $2a, $2b ; id 1
    db $2c, $2d, $2e, $2f, $30, $31 ; id 2
    db $32, $33, $34, $35, $36, $37 ; id 3
    db $38, $39, $3a, $3b, $3c, $3d ; id 4
    db $3e, $3f, $40, $41, $42, $43 ; id 5

TileRect_01_4802::
    db $01, $01, $01, $01, $01, $01 ; id 0
    db $01, $01, $01, $01, $01, $01 ; id 1
    db $01, $01, $01, $01, $01, $01 ; id 2
    db $01, $01, $01, $01, $01, $01 ; id 3
    db $01, $01, $01, $01, $01, $01 ; id 4
    db $01, $01, $01, $01, $01, $01 ; id 5

; init for debug-mode state 5: the screen shows '? SOUND ?' (BGM, SE) (E-0041)
DebugSoundTest_Init::
    ld hl, vTiles2 + $100
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1001
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1008
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a
    ld [wStringCategory], a
    ld a, $06
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld a, $01
    ld de, TileRect_01_488A
    ld hl, vBGMap0 + $a3
    lb bc, $0b, $04
    call CopyRectFromBankToVRAM
    xor a
    ld [wMenuState], a
    xor a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 11 x 4 tiles, one row per line
TileRect_01_488A::
    db $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8a ; id 0
    db $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $9a ; id 1
    db $a0, $a1, $a2, $a3, $a4, $a5, $10, $10, $a8, $10, $12 ; id 2
    db $b0, $b1, $b2, $b3, $b4, $b5, $10, $10, $b8, $10, $10 ; id 3

; init for debug-mode state 6: the screen shows '? BATTLE ?' (number of foes, three monsters, skill,
; levels) (E-0041)
DebugBattleSetup_Init::
    ld hl, vTiles2 + $100
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1001
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0b09
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a
    ld [wStringCategory], a
    ld a, $09
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld a, $01
    ld de, TileRect_01_495D
    ld hl, vBGMap0 + $40
    lb bc, $14, $0e
    call CopyRectFromBankToVRAM
    xor a
    ld hl, wWorkBuf
    ld bc, $0018
    call FillBytes
    ld a, $01
    ld [wMenuState], a
    call DebugBattleSetupShowFieldString
    ld a, $02
    ld [wMenuState], a
    call DebugBattleSetupShowFieldString
    ld a, $03
    ld [wMenuState], a
    call DebugBattleSetupShowFieldString
    ld a, $04
    ld [wMenuState], a
    call DebugBattleSetupShowFieldString
    ld a, $05
    ld [wMenuState], a
    call DebugBattleSetupShowFieldString
    ld a, $06
    ld [wMenuState], a
    call DebugBattleSetupShowFieldString
    ld a, $08
    ld [wMenuState], a
    call DebugBattleSetupShowFieldString
    ld a, $0a
    ld [wMenuState], a
    call DebugBattleSetupShowFieldString
    xor a
    ld [wMenuState], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 20 x 14 tiles, one row per line
TileRect_01_495D::
    db $00, $00, $00, $00, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8a, $00, $00, $00, $00, $00 ; id 0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 1
    db $8b, $8c, $8d, $8e, $8f, $90, $91, $10, $10, $10, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 2
    db $96, $97, $98, $99, $9a, $9b, $9c, $10, $10, $10, $a0, $20, $21, $22, $23, $24, $25, $26, $27, $28 ; id 3
    db $a1, $a2, $a3, $a4, $a5, $a6, $a7, $10, $10, $10, $ab, $2a, $2b, $2c, $2d, $2e, $2f, $30, $31, $32 ; id 4
    db $ac, $ad, $ae, $af, $b0, $b1, $b2, $10, $10, $10, $b6, $33, $34, $35, $36, $37, $38, $39, $3a, $3b ; id 5
    db $b7, $b8, $b9, $ba, $bb, $bc, $bd, $10, $10, $10, $c1, $3c, $3d, $3e, $3f, $40, $41, $42, $43, $44 ; id 6
    db $c2, $c3, $c4, $c5, $c6, $c7, $c8, $10, $10, $10, $cc, $45, $46, $47, $48, $49, $4a, $4b, $4c, $4d ; id 7
    db $cd, $ce, $cf, $d0, $d1, $d2, $d3, $10, $10, $10, $d7, $4e, $4f, $50, $51, $52, $53, $54, $55, $56 ; id 8
    db $d8, $d9, $da, $db, $dc, $dd, $de, $10, $10, $10, $e2, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 9
    db $cd, $ce, $cf, $d0, $d1, $d2, $d3, $10, $10, $10, $d7, $57, $58, $59, $5a, $5b, $5c, $5d, $5e, $5f ; id 10
    db $d8, $d9, $da, $db, $dc, $dd, $de, $10, $10, $10, $e2, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 11
    db $cd, $ce, $cf, $d0, $d1, $d2, $d3, $10, $10, $10, $d7, $60, $61, $62, $63, $64, $65, $66, $67, $68 ; id 12
    db $d8, $d9, $da, $db, $dc, $dd, $de, $10, $10, $10, $e2, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 13

; A = first tile, B = width, C = rows, HL = BG map address (rows 32 apart): writes consecutive tile
; numbers A, A + 1, ... row by row; on CGB then zero-fills the $240 bytes at vBGMap0 in VRAM bank 1
; (all attributes 0, regardless of the rectangle) (E-0073)
FillRectWithTileSequence::
    push hl
    ld d, b

.loop:
    ld [hli], a
    inc a
    dec b
    jr nz, .loop
    ld b, d
    ld e, a
    pop hl
    ld a, $20
    add_a_to_hl
    ld a, e
    dec c
    jr nz, FillRectWithTileSequence
    ld a, [wIsCGB]
    or a
    ret z
    ld c, $4f
    ld a, $01
    ldh [c], a
    ld hl, vBGMap0
    ld bc, $0240
    xor a
    call FillBytes
    ld c, $4f
    ld a, $00
    ldh [c], a
    ret

; on CGB copies the 8-byte palette LoadPalette0FromData4ACC_Data into wBGPaletteBuffer twice and
; sets wBGPaletteUploadRequest and wOBJPaletteUploadRequest = $7F (E-0117)
LoadPalette0FromData4ACC::
    ld a, [wIsCGB]
    or a
    ret z
    ld de, LoadPalette0FromData4ACC_Data
    ld hl, wBGPaletteBuffer
    ld bc, $0008
    call CopyBytesDEToHL_Bank00
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ld de, LoadPalette0FromData4ACC_Data
    ld hl, wBGPaletteBuffer
    ld bc, $0008
    call CopyBytesDEToHL_Bank00
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ret

LoadPalette0FromData4ACC_Data::
    db $4d, $5e, $ff, $7f, $f2, $66, $00, $00

; per-frame routine for wGameMode = 0
GameMode0_Update::
    ld a, [wModeState]
    jumptable
    dw DebugMainMenu_Update
    dw DebugMainMenu_Update
    dw DebugMapEditor_Update
    dw DebugAutomap_Update
    dw DebugMonsterPictureViewer_Update
    dw DebugSoundTest_Update
    dw DebugBattleSetup_Update
    dw DebugResultsDisplay_Update
    dw DebugStaffRoll_Update
    dw DebugSkillViewer_Update
    dw DebugMonsterRecordViewer_Update
    dw DebugMessageTest_Update

; update for debug-mode state 11: the screen shows 'LIBNO / MESNO' message test (E-0041)
DebugMessageTest_Update::
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld a, [wJoypadPressed]
    and $01
    jp z, DebugMessageTest_Update_ToBeginStringDisplay_Bank1B_480C_CheckJoypadPressedRepeat
    ld a, [wMenuRowCount]
    ld [wStringIndex], a
    ld a, [wTemp1]
    ld [wStringCategory], a
    ld de, $1204
    ld hl, vTiles2 + $300
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, [wTemp0]
    jumptable
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank08
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank09
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank28
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank29
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank2A
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank2B
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank2C
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank2D
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank2E
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank7C
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank80
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank82
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank86
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank89
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank07
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank2F
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank37
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank88
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank83
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank1D
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank8A
    dw DebugMessageTest_Update_ToBeginStringDisplay_BankF0_4001
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank1B_4C86
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank1F
    dw DebugMessageTest_Update_ToBeginStringDisplay_BankF0_48A0
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank0D
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank33_6490
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank24
    dw DebugMessageTest_Update_CallUpdate_Case1C_Sub01_BeginStringDisplay
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank0E
    dw DebugMessageTest_Update_ToBeginStringDisplay_BankF2
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank33_7037
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank0B
    dw DebugMessageTest_Update_ToBeginStringDisplay_Bank1B_480C

DebugMessageTest_Update_ToBeginStringDisplay_Bank08::
    farcall BeginStringDisplay_Bank08
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank09::
    farcall BeginStringDisplay_Bank09
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank28::
    farcall BeginStringDisplay_Bank28
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank29::
    farcall BeginStringDisplay_Bank29
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank2A::
    farcall BeginStringDisplay_Bank2A
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank2B::
    farcall BeginStringDisplay_Bank2B
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank2C::
    farcall BeginStringDisplay_Bank2C
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank2D::
    farcall BeginStringDisplay_Bank2D
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank2E::
    farcall BeginStringDisplay_Bank2E
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank7C::
    farcall BeginStringDisplay_Bank7C
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank80::
    farcall BeginStringDisplay_Bank80
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank82::
    farcall BeginStringDisplay_Bank82
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank86::
    farcall BeginStringDisplay_Bank86
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank89::
    farcall BeginStringDisplay_Bank89
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank07::
    farcall BeginStringDisplay_Bank07
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank2F::
    farcall BeginStringDisplay_Bank2F
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank37::
    farcall BeginStringDisplay_Bank37
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank88::
    farcall BeginStringDisplay_Bank88
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank83::
    farcall BeginStringDisplay_Bank83
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank1D::
    farcall BeginStringDisplay_Bank1D
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank8A::
    farcall BeginStringDisplay_Bank8A
    ret

DebugMessageTest_Update_ToBeginStringDisplay_BankF0_4001::
    farcall BeginStringDisplay_BankF0_4001
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank1B_4C86::
    farcall BeginStringDisplay_Bank1B_4C86
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank1F::
    farcall BeginStringDisplay_Bank1F
    ret

DebugMessageTest_Update_ToBeginStringDisplay_BankF0_48A0::
    farcall BeginStringDisplay_BankF0_48A0
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank0D::
    farcall BeginStringDisplay_Bank0D
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank33_6490::
    farcall BeginStringDisplay_Bank33_6490
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank24::
    farcall BeginStringDisplay_Bank24
    ret

DebugMessageTest_Update_CallUpdate_Case1C_Sub01_BeginStringDisplay::
    farcall DebugMessageTest_Update_Case1C_Sub01_BeginStringDisplay_Sub01
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank0E::
    farcall BeginStringDisplay_Bank0E
    ret

DebugMessageTest_Update_ToBeginStringDisplay_BankF2::
    farcall BeginStringDisplay_BankF2
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank33_7037::
    farcall BeginStringDisplay_Bank33_7037
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank0B::
    farcall BeginStringDisplay_Bank0B
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank1B_480C::
    farcall BeginStringDisplay_Bank1B_480C
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank1B_480C_CheckJoypadPressedRepeat::
    ld a, [wJoypadPressedRepeat]
    and $40
    jr z, .check_joypad_pressed_repeat
    ld a, [wMenuState]
    cp $00
    call z, DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE
    ld a, [wMenuState]
    cp $01
    call z, DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub02
    ld a, [wMenuState]
    cp $02
    call z, DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub03
    ld a, [wMenuState]
    sub $01
    jr nc, .set_menu_state
    ld a, $02

.set_menu_state:
    ld [wMenuState], a
    ld a, $69
    call QueueSoundEffect

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and $80
    jr z, .read_menu_state
    ld a, [wMenuState]
    cp $00
    call z, DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE
    ld a, [wMenuState]
    cp $01
    call z, DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub02
    ld a, [wMenuState]
    cp $02
    call z, DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub03
    ld a, [wMenuState]
    add $01
    cp $03
    jr nz, .set_menu_state2
    ld a, $00

.set_menu_state2:
    ld [wMenuState], a
    ld a, $69
    call QueueSoundEffect

.read_menu_state:
    ld a, [wMenuState]
    ld c, a
    ld b, $00
    ld hl, wTemp0
    add hl, bc
    ld a, [wJoypadPressedRepeat]
    and $10
    jr z, .check_joypad_pressed_repeat2
    inc [hl]
    call DebugMessageTest_Update_Case21_WriteTemp1AndMenuRowCount
    jr .call_queue_sound_effect

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    and $20
    jr z, .check_joypad_pressed
    dec [hl]
    call DebugMessageTest_Update_Case21_WriteTemp1AndMenuRowCount
    jr .call_queue_sound_effect

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $08
    jr z, .check_joypad_pressed2
    xor a
    ld [hl], a

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuState]
    ld b, $21
    cp $00
    call z, DebugMessageTest_Update_Case21_ReadMenuStateAndTemp0Etc
    ld a, [wTemp0]
    add a
    ld hl, DebugMessageTestTable
    add_a_to_hl
    push hl
    inc hl
    ld a, [hl]
    pop hl
    cp $00
    jr z, .check_menu_state
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [de]

.check_menu_state:
    ld b, a
    ld a, [wMenuState]
    cp $01
    call z, DebugMessageTest_Update_Case21_ReadMenuStateAndTemp0Etc
    ld a, [wTemp0]
    add a
    ld hl, DebugMessageTestTable
    add_a_to_hl
    push hl
    inc hl
    ld a, [hl]
    pop hl
    cp $00
    jr nz, .skip
    ld a, [hl]
    jr .check_menu_state2

.skip:
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld h, b
    ld l, c
    ld a, [wTemp1]
    inc a
    add_a_to_hl
    ld a, [hl]

.check_menu_state2:
    ld b, a
    ld a, [wMenuState]
    cp $02
    call z, DebugMessageTest_Update_Case21_ReadMenuStateAndTemp0Etc

.check_joypad_pressed2:
    ld a, [wJoypadPressed]
    and $02
    jr z, .check_menu_state3
    xor a
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.check_menu_state3:
    ld a, [wMenuState]
    cp $00
    jr nz, DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_CheckMenuState
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE
    xor a
    ld hl, vBGMap0 + $6d
    call WriteVRAMByteInc
    call WriteVRAMByte
    jr DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub03_CheckMenuState

DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE::
    ld a, [wTemp0]
    ld de, vBGMap0 + $6d
    call WriteHexByteTilesAtDE
    jr DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub03_CheckMenuState

DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_CheckMenuState::
    ld a, [wMenuState]
    cp $01
    jr nz, DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub02_CheckFrameCounterLo
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub02
    xor a
    ld hl, vBGMap0 + $ad
    call WriteVRAMByteInc
    call WriteVRAMByte
    jr DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub03_CheckMenuState

DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub02::
    ld a, [wTemp1]
    ld de, vBGMap0 + $ad
    call WriteHexByteTilesAtDE
    jr DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub03_CheckMenuState

DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub02_CheckFrameCounterLo::
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub03
    xor a
    ld hl, vBGMap0 + $ed
    call WriteVRAMByteInc
    call WriteVRAMByte
    jr DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub03_CheckMenuState

DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub03::
    ld a, [wMenuRowCount]
    ld de, vBGMap0 + $ed
    call WriteHexByteTilesAtDE
    jr DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub03_CheckMenuState

DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub03_CheckMenuState::
    ld a, [wMenuState]
    cp $00
    jr z, .check_menu_state
    ld a, [wTemp0]
    ld de, vBGMap0 + $6d
    call WriteHexByteTilesAtDE

.check_menu_state:
    ld a, [wMenuState]
    cp $01
    jr z, .check_menu_state2
    ld a, [wTemp1]
    ld de, vBGMap0 + $ad
    call WriteHexByteTilesAtDE

.check_menu_state2:
    ld a, [wMenuState]
    cp $02
    jr z, .return
    ld a, [wMenuRowCount]
    ld de, vBGMap0 + $ed
    call WriteHexByteTilesAtDE

.return:
    ret

DebugMessageTest_Update_Case21_ReadMenuStateAndTemp0Etc::
    push af
    ld a, [wMenuState]
    ld hl, wTemp0
    add_a_to_hl
    ld a, b
    cp $ff
    jr z, .check_menu_state
    ld a, [hl]
    inc b
    cp b
    jr nz, .next
    ld [hl], $00

.next:
    dec b
    ld a, [hl]
    cp $ff
    jr nz, .check_menu_state
    ld [hl], b

.check_menu_state:
    ld a, [wMenuState]
    cp $00
    jr nz, .check_menu_state2
    ld de, vBGMap0 + $6d
    ld a, [wTemp0]
    jr .call_write_hex_byte_tiles_at_de

.check_menu_state2:
    ld a, [wMenuState]
    cp $01
    jr nz, .read_menu_row_count
    ld de, vBGMap0 + $ad
    ld a, [wTemp1]
    jr .call_write_hex_byte_tiles_at_de

.read_menu_row_count:
    ld de, vBGMap0 + $ed
    ld a, [wMenuRowCount]

.call_write_hex_byte_tiles_at_de:
    add_a_to_hl
    ld a, [hl]
    call WriteHexByteTilesAtDE
    pop af
    ret

DebugMessageTest_Update_Case21_WriteTemp1AndMenuRowCount::
    ld a, [wMenuState]
    cp $00
    jr nz, .cp_01
    xor a
    ld [wTemp1], a
    xor a
    ld [wMenuRowCount], a
    ret

.cp_01:
    cp $01
    jr nz, .return
    xor a
    ld [wMenuRowCount], a

.return:
    ret

; DebugMessageTest_Update_Case21 reads the word at $4E54 + 2 * wTemp0; a zero high byte takes the
; value directly, otherwise the word points at a sub-list (the bytes from $4E98 on); 34 words up to
; the first sub-list (E-0233, C1)
; record: value (high byte 0) or pointer to a sub-list
DebugMessageTestTable::
    dw $4e98 ; id 0
    dw $4eae ; id 1
    dw $00ff ; id 2
    dw $00d4 ; id 3
    dw $00ef ; id 4
    dw $00c2 ; id 5
    dw $00d2 ; id 6
    dw $00ff ; id 7
    dw $00dd ; id 8
    dw $00ef ; id 9
    dw $00ff ; id 10
    dw $00c3 ; id 11
    dw $00fe ; id 12
    dw $00f8 ; id 13
    dw $4eb9 ; id 14
    dw $4ec1 ; id 15
    dw $4ec8 ; id 16
    dw $4ecb ; id 17
    dw $00f1 ; id 18
    dw $0017 ; id 19
    dw $002a ; id 20
    dw $002f ; id 21
    dw $0029 ; id 22
    dw $003f ; id 23
    dw $0022 ; id 24
    dw $002f ; id 25
    dw $0036 ; id 26
    dw $0015 ; id 27
    dw $009f ; id 28
    dw $0016 ; id 29
    dw $0023 ; id 30
    dw $0012 ; id 31
    dw $4ecf ; id 32
    dw $0027 ; id 33

; the sub-lists that DebugMessageTestTable's pointer words name ($4E98, $4EAE, $4EB9, $4EC1, $4EC8,
; $4ECB, $4ECF); their format is not read (E-0233, C1)
; record: sub-lists named by DebugMessageTestTable
DebugMessageTestSubLists::
    db $14, $ff, $10, $ff, $7f, $df, $6f, $6f, $27, $0d, $af, $00, $23, $00, $06, $05, $01, $08, $0a, $1b, $07, $03, $09, $02, $19, $09, $57, $00, $53, $0c, $0d, $00, $21, $06, $06, $05, $00, $06, $02, $1a, $08, $05, $85, $fc, $03, $00, $00, $21, $01, $35, $1f, $02, $ff, $ff, $ff, $02, $ff, $84, $0a, $c9 ; entry 0

; update for debug-mode state 10: the screen shows the monster record viewer (E-0041)
DebugMonsterRecordViewer_Update::
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_joypad_pressed_repeat
    xor a
    ld [wGameMode], a
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    bit 5, a
    jr z, .check_joypad_pressed_repeat2
    ld a, [wJoypadHeld]
    bit 2, a
    jr nz, .read_debug_cursor
    ld a, [wDebugCursor]
    sub $01
    ld [wDebugCursor], a
    ld a, [wDebugValue0]
    sbc $00
    ld [wDebugValue0], a
    jr .read_debug_cursor2

.read_debug_cursor:
    ld a, [wDebugCursor]
    ld l, a
    ld a, [wDebugValue0]
    ld h, a
    ld a, l
    sub $10
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    ld a, l
    ld [wDebugCursor], a
    ld a, h
    ld [wDebugValue0], a

.read_debug_cursor2:
    ld a, [wDebugCursor]
    ld l, a
    ld a, [wDebugValue0]
    ld h, a
    ld bc, $02ab
    call CompareHLToBC
    jr c, DebugShowMonsterRecord
    ld hl, $02ab
    jr DebugShowMonsterRecord

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    bit 4, a
    jp z, DebugShowMonsterRecord_Return
    ld a, [wJoypadHeld]
    bit 2, a
    jr nz, .read_debug_cursor3
    ld a, [wDebugCursor]
    add $01
    ld [wDebugCursor], a
    ld a, [wDebugValue0]
    adc $00
    ld [wDebugValue0], a
    jr .read_debug_cursor4

.read_debug_cursor3:
    ld a, [wDebugCursor]
    ld l, a
    ld a, [wDebugValue0]
    ld h, a
    ld a, l
    add $10
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, l
    ld [wDebugCursor], a
    ld a, h
    ld [wDebugValue0], a

.read_debug_cursor4:
    ld a, [wDebugCursor]
    ld l, a
    ld a, [wDebugValue0]
    ld h, a
    ld bc, $02ab
    call CompareHLToBC
    jr c, DebugShowMonsterRecord
    ld hl, $0000

; HL = monster id (the debug monster viewer wraps it at $02AB): stores it in
; wDebugCursor/wDebugValue0 and wMonsterId/wMonsterId + $1, loads the record with LoadMonsterRecord
; and draws the id, the name (string bank $88, category = id high byte, index = id low byte) and the
; record's fields on the debug screen
DebugShowMonsterRecord::
    ld a, l
    ld [wDebugCursor], a
    ld a, h
    ld [wDebugValue0], a
    ld a, l
    ld [wMonsterId], a
    ld a, h
    ld [wMonsterId + $1], a
    farcall LoadMonsterRecord
    ld a, [wMonsterId]
    ld hl, vBGMap0 + $24
    ld bc, $0100
    call WriteHexByteTilesAtHL
    ld a, [wMonsterId + $1]
    ld hl, vBGMap0 + $24
    call DebugShowMonsterRecord_WriteTileDPlusBAtHL
    ld a, [wMonsterId + $1]
    ld [wStringCategory], a
    ld a, [wMonsterId]
    ld [wStringIndex], a
    ld hl, vTiles2 + $400
    ld de, $0901
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
    farcall ShowString_Bank88
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
    ld a, [wRecordBuffer]
    ld hl, vBGMap0 + $4f
    ld bc, $0100
    call WriteHexByteTilesAtHL
    ld a, [wRecordBuffer + $1]
    ld hl, vBGMap0 + $4f
    call DebugShowMonsterRecord_WriteTileDPlusBAtHL
    ld a, [wRecordBufferData]
    ld hl, vBGMap0 + $66
    ld bc, $0100
    call WriteHexByteTilesAtHL
    ld a, [wRecordBufferData + $1]
    inc hl
    call WriteHexByteTilesAtHL
    ld a, [wRecordBufferData + $2]
    inc hl
    call WriteHexByteTilesAtHL
    ld a, [wRecordBufferData + $3]
    inc hl
    call WriteHexByteTilesAtHL
    ld a, [wRecordBufferData + $4]
    ld e, a
    ld a, [wRecordBufferData + $5]
    ld d, a
    ld hl, vBGMap0 + $8d
    ld bc, $0100
    call DebugShowMonsterRecord_Number24ToPackedBCD
    ld a, [wRecordBufferData + $6]
    ld hl, vBGMap0 + $af
    ld bc, $0100
    call WriteDecimalByteTiles_Bank01
    ld a, [wRecordBufferData + $7]
    ld hl, vBGMap0 + $cf
    ld bc, $0100
    call WriteDecimalByteTiles_Bank01
    ld a, [wRecordBufferData + $8]
    ld e, a
    ld a, [wRecordBufferData + $9]
    ld d, a
    ld hl, vBGMap0 + $ed
    ld bc, $0100
    call DebugShowMonsterRecord_Number24ToPackedBCD
    ld a, [wRecordBufferData + $a]
    ld e, a
    ld a, [wRecordBufferData + $b]
    ld d, a
    ld hl, vBGMap0 + $10d
    ld bc, $0100
    call DebugShowMonsterRecord_Number24ToPackedBCD
    ld a, [wRecordBufferData + $c]
    ld e, a
    ld a, [wRecordBufferData + $d]
    ld d, a
    ld hl, vBGMap0 + $12d
    ld bc, $0100
    call DebugShowMonsterRecord_Number24ToPackedBCD
    ld a, [wRecordBufferData + $e]
    ld e, a
    ld a, [wRecordBufferData + $f]
    ld d, a
    ld hl, vBGMap0 + $14d
    ld bc, $0100
    call DebugShowMonsterRecord_Number24ToPackedBCD
    ld a, [wRecordBufferData + $10]
    ld e, a
    ld a, [wRecordBufferData + $11]
    ld d, a
    ld hl, vBGMap0 + $16d
    ld bc, $0100
    call DebugShowMonsterRecord_Number24ToPackedBCD
    ld a, [wScreenAttrBuffer]
    ld e, a
    ld a, [wRecordBufferData + $13]
    ld d, a
    ld hl, vBGMap0 + $18d
    ld bc, $0100
    call DebugShowMonsterRecord_Number24ToPackedBCD
    ld a, [wRecordBufferData + $14]
    ld hl, vBGMap0 + $1af
    ld bc, $0100
    call WriteDecimalByteTiles_Bank01
    ld a, [wRecordBufferData + $15]
    ld hl, vBGMap0 + $1cf
    ld bc, $0100
    call WriteDecimalByteTiles_Bank01
    ld a, [wRecordBufferData + $16]
    ld hl, vBGMap0 + $1ef
    ld bc, $0100
    call WriteDecimalByteTiles_Bank01
    ld a, [wRecordBufferData + $17]
    ld hl, vBGMap0 + $20f
    ld bc, $0100
    call WriteDecimalByteTiles_Bank01

DebugShowMonsterRecord_Return::
    ret

; update for debug-mode state 9: the screen shows the skill viewer (E-0041)
DebugSkillViewer_Update::
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_joypad_pressed_repeat
    xor a
    ld [wGameMode], a
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    bit 5, a
    jr z, .check_joypad_pressed_repeat2
    ld a, [wDebugCursor]
    dec a
    ld [wDebugCursor], a
    cp $af
    jr c, .check_joypad_pressed_repeat2
    ld a, $ae
    ld [wDebugCursor], a

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    bit 4, a
    jr z, .skip
    ld a, [wDebugCursor]
    inc a
    ld [wDebugCursor], a
    cp $af
    jr c, .skip
    xor a
    ld [wDebugCursor], a

.skip:
    ld hl, wDebugCursor
    ld a, [hli]
    cp [hl]
    ld [hl], a
    ret z
    ld hl, vBGMap0 + $46
    ld bc, $0100
    call WriteHexByteTilesAtHL
    ld a, [wDebugCursor]
    ld [wRecordBuffer], a
    xor a
    ld [wRecordBuffer + $1], a
    xor a
    ld [wBattleArg0], a
    ld a, $11
    ld [wBattleArg1], a
    ld hl, wRecordBufferData
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    farcall LoadSkillRecordPart
    ld a, [wRecordBufferData]
    ld hl, vBGMap0 + $90
    ld bc, $0100
    call WriteDecimalByteTiles_Bank01
    ld a, $04
    ld [wStringCategory], a
    ld a, [wRecordBuffer]
    or a
    jr nz, .set_string_index
    ld a, $0e
    ld [wStringCategory], a
    ld a, $01

.set_string_index:
    ld [wStringIndex], a
    ld hl, vTiles1 + $200
    ld de, $0901
    call FillTilesRequest
    farcall ShowString_Bank08
    ld a, $12
    ld [wStringCategory], a
    ld a, [wRecordBufferData + $1]
    ld [wStringIndex], a
    ld hl, vTiles1
    ld de, $0501
    call FillTilesRequest
    farcall ShowString_Bank08
    ld a, $13
    ld [wStringCategory], a
    ld a, [wRecordBufferData + $2]
    ld [wStringIndex], a
    ld hl, vTiles1 + $50
    ld de, $0401
    call FillTilesRequest
    farcall ShowString_Bank08
    ld a, $14
    ld [wStringCategory], a
    ld a, [wRecordBufferData + $3]
    and $03
    ld [wStringIndex], a
    ld hl, vTiles1 + $90
    ld de, $0401
    call FillTilesRequest
    farcall ShowString_Bank08
    ld a, $10
    ld [wStringCategory], a
    ld a, [wRecordBufferData + $3]
    and $f0
    swap a
    ld [wStringIndex], a
    ld hl, vTiles1 + $d0
    ld de, $0801
    call FillTilesRequest
    farcall ShowString_Bank08
    ld a, $11
    ld [wStringCategory], a
    ld a, [wRecordBufferData + $4]
    call DebugSkillViewer_Update_IndexOfFlagValue
    ld [wStringIndex], a
    ld hl, vTiles1 + $150
    ld de, $0801
    call FillTilesRequest
    farcall ShowString_Bank08
    ld a, [wRecordBufferData + $5]
    ld hl, vBGMap0 + $14b
    ld bc, $0801
    call DebugSkillViewer_Update_WriteVRAMByte
    ld a, [wRecordBufferData + $6]
    ld hl, vBGMap0 + $16b
    ld bc, $0801
    call DebugSkillViewer_Update_WriteVRAMByte
    ld a, [wRecordBufferData + $7]
    ld hl, vBGMap0 + $18b
    ld bc, $0801
    call DebugSkillViewer_Update_WriteVRAMByte
    ld a, [wRecordBufferData + $8]
    ld hl, vBGMap0 + $1ab
    ld bc, $0801
    call DebugSkillViewer_Update_WriteVRAMByte
    ld a, [wRecordBufferData + $9]
    ld l, a
    ld a, [wRecordBufferData + $a]
    ld h, a
    call DebugSkillViewer_Update_Number24ToPackedBCD
    ld hl, vBGMap0 + $1ea
    ld bc, $0100
    call DebugSkillViewer_Update_WriteVRAMByteInc
    ld a, [wRecordBufferData + $9]
    ld l, a
    ld a, [wRecordBufferData + $a]
    ld h, a
    ld a, [wRecordBufferData + $b]
    ld e, a
    ld a, [wRecordBufferData + $c]
    ld d, a
    add hl, de
    call DebugSkillViewer_Update_Number24ToPackedBCD
    ld hl, vBGMap0 + $1ef
    ld bc, $0100
    call DebugSkillViewer_Update_WriteVRAMByteInc
    ld a, [wRecordBufferData + $d]
    ld l, a
    ld a, [wRecordBufferData + $e]
    ld h, a
    call DebugSkillViewer_Update_Number24ToPackedBCD
    ld hl, vBGMap0 + $20a
    ld bc, $0100
    call DebugSkillViewer_Update_WriteVRAMByteInc
    ld a, [wRecordBufferData + $d]
    ld l, a
    ld a, [wRecordBufferData + $e]
    ld h, a
    ld a, [wRecordBufferData + $f]
    ld e, a
    ld a, [wRecordBufferData + $10]
    ld d, a
    add hl, de
    call DebugSkillViewer_Update_Number24ToPackedBCD
    ld hl, vBGMap0 + $20f
    ld bc, $0100
    call DebugSkillViewer_Update_WriteVRAMByteInc
    ret

DebugSkillViewer_Update_Number24ToPackedBCD::
    ld a, l
    ld [wDigits], a
    ld a, h
    ld [wDigits + $1], a
    xor a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ld hl, hTemp3
    ld a, [hld]
    or [hl]
    ret z
    ld a, $99
    ldh [hTemp1], a
    ld a, $99
    ldh [hTemp0], a
    ret

DebugSkillViewer_Update_WriteVRAMByteInc::
    ld e, $00
    ldh a, [hTemp1]
    and $f0
    swap a
    ld d, a
    or e
    ld e, a
    ld a, c
    jr z, .call_write_vram_byte_inc
    ld a, d
    add b

.call_write_vram_byte_inc:
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hTemp1]
    and $0f
    ld d, a
    or e
    ld e, a
    ld a, c
    jr z, .call_write_vram_byte_inc2
    ld a, d
    add b

.call_write_vram_byte_inc2:
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hTemp0]
    and $f0
    swap a
    ld d, a
    or e
    ld e, a
    ld a, c
    jr z, .call_write_vram_byte_inc3
    ld a, d
    add b

.call_write_vram_byte_inc3:
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hTemp0]
    and $0f
    add b
    di
    call WriteVRAMByteInc
    ei
    ret

; C = the position of A in the list $11, $12, $14, $21, $22, $31, $32, $40, $80, ...; returns at
; once for 0
DebugSkillViewer_Update_IndexOfFlagValue::
    or a
    ret z
    ld c, $01
    cp $11
    jr z, .done
    inc c
    cp $12
    jr z, .done
    inc c
    cp $14
    jr z, .done
    inc c
    cp $21
    jr z, .done
    inc c
    cp $22
    jr z, .done
    inc c
    cp $31
    jr z, .done
    inc c
    cp $32
    jr z, .done
    inc c
    cp $40
    jr z, .done
    inc c
    cp $80
    jr z, .done
    inc c

.done:
    ld a, c
    ret

DebugSkillViewer_Update_WriteVRAMByte::
    ld d, a
    ld e, $00

.loop:
    push hl
    ld a, e
    ld hl, DebugSkillViewer_Update_WriteVRAMByte_Data
    add_a_to_hl
    ld a, d
    and [hl]
    jr z, .skip
    ld a, $01

.skip:
    add c
    pop hl
    di
    call WriteVRAMByte
    ei
    inc hl
    inc e
    dec b
    jr nz, .loop
    ret

DebugSkillViewer_Update_WriteVRAMByte_Data::
    db $80, $40, $20, $10, $08, $04, $02, $01

DebugShowMonsterRecord_Number24ToPackedBCD::
    push bc
    push hl
    ld a, e
    ld [wDigits], a
    ld a, d
    ld [wDigits + $1], a
    xor a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    pop hl
    pop bc
    ld e, $00
    ldh a, [hTemp2]
    and $0f
    ld d, a
    or e
    ld e, a
    ld a, d
    jr nz, .call_write_vram_byte_inc
    ld a, c
    jr .call_write_vram_byte_inc2

.call_write_vram_byte_inc:
    add b

.call_write_vram_byte_inc2:
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hTemp1]
    and $f0
    swap a
    ld d, a
    or e
    ld e, a
    ld a, d
    jr nz, .call_write_vram_byte_inc3
    ld a, c
    jr .call_write_vram_byte_inc4

.call_write_vram_byte_inc3:
    add b

.call_write_vram_byte_inc4:
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hTemp1]
    and $0f
    ld d, a
    or e
    ld e, a
    ld a, d
    jr nz, .call_write_vram_byte_inc5
    ld a, c
    jr .call_write_vram_byte_inc6

.call_write_vram_byte_inc5:
    add b

.call_write_vram_byte_inc6:
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hTemp0]
    and $f0
    swap a
    ld d, a
    or e
    ld e, a
    ld a, d
    jr nz, .call_write_vram_byte_inc7
    ld a, c
    jr .call_write_vram_byte_inc8

.call_write_vram_byte_inc7:
    add b

.call_write_vram_byte_inc8:
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hTemp0]
    and $0f
    add b
    di
    call WriteVRAMByte
    ei
    ret

; writes A as decimal digit tiles at HL (three digits, with tile C for absent leading digits)
; (E-0124)
WriteDecimalByteTiles_Bank01::
    cp $64
    jr nc, .call_div_mod_a_by_e_bank01
    call WriteTileCAtHL
    inc hl
    cp $0a
    jr nc, .call_div_mod_a_by_e_bank012
    call WriteTileCAtHL
    inc hl
    jr .call_write_tile_d_plus_b_at_hl

.call_div_mod_a_by_e_bank01:
    ld e, $64
    call DivModAByE_Bank01
    call WriteTileDPlusBAtHL
    inc hl

.call_div_mod_a_by_e_bank012:
    ld e, $0a
    call DivModAByE_Bank01
    call WriteTileDPlusBAtHL
    inc hl

.call_write_tile_d_plus_b_at_hl:
    ld d, a
    call WriteTileDPlusBAtHL
    ret

; D = A / E and A = A mod E by repeated subtraction (E-0122)
DivModAByE_Bank01::
    ld d, $ff

.loop:
    inc d
    sub e
    jr nc, .loop
    add e
    ret

; writes tile D + B at VRAM address HL with interrupts off (WriteVRAMByte); AF kept (E-0114)
WriteTileDPlusBAtHL::
    push af
    ld a, d
    add b
    di
    call WriteVRAMByte
    ei
    pop af
    ret

; writes tile C at VRAM address HL with interrupts off (WriteVRAMByte); AF kept (E-0114)
WriteTileCAtHL::
    push af
    ld a, c
    di
    call WriteVRAMByte
    ei
    pop af
    ret

; HL += 1, writes the high nibble of A as a tile (WriteTileDPlusBAtHL), then falls into the
; low-nibble write (E-0122)
WriteHexByteTilesAtHL::
    inc hl
    push af
    swap a
    and $0f
    ld d, a
    call WriteTileDPlusBAtHL
    inc hl
    pop af

DebugShowMonsterRecord_WriteTileDPlusBAtHL::
    and $0f
    ld d, a
    call WriteTileDPlusBAtHL
    ret

; update for debug-mode state 8: the screen shows the staff roll (SCENARIO & GAME DESIGNERS, YUJI
; HORII, ENIX, TOSE, FUMINORI ISHIKAWA) (E-0041)
DebugStaffRoll_Update::
    farcall DebugStaffRoll_Update_RunFieldEventFieldEventKind
    ret

; update for debug-mode state 7: the screen shows 'RESULTS DISPLAY' (species, gender) (E-0041)
DebugResultsDisplay_Update::
    ld a, [wScreenState]
    and a
    jp z, DebugResultsDisplay_Update_Sub02_Sub01_WaitForVRAMAccess_CheckJoypadPressedRepeat
    cp $01
    jp z, DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD_Data2_CheckArg1
    ld a, [wJoypadPressedRepeat]
    bit 0, a
    jp nz, DebugToggleArg1Marker_CheckScreenCounter
    bit 1, a
    jp nz, DebugToggleArg1Marker_ClearDebugCursor
    bit 4, a
    jp nz, .call_debug_results_display_update_hl_to2
    bit 5, a
    jp nz, .call_debug_results_display_update_hl_to3
    bit 6, a
    jp nz, .check_debug_cursor
    bit 7, a
    jp nz, .check_debug_cursor2
    bit 3, a
    jr nz, .call_debug_results_display_update_hl_to
    call DebugResultsDisplay_Update_WriteDebugCounter
    ret

.call_debug_results_display_update_hl_to:
    call DebugResultsDisplay_Update_HLToDecimalDigits
    xor a
    ld [wScreenState], a
    ld [wScreenByteBD], a
    ret

.check_debug_cursor:
    ld a, [wDebugCursor]
    cp $04
    jr nz, .read_screen_byte_bd
    ld hl, wGridCursorY
    jr .read_screen_byte_bd2

.read_screen_byte_bd:
    ld hl, wDebugResultsBuf

.read_screen_byte_bd2:
    ld a, [wScreenByteBD]
    add_a_to_hl
    ld a, [hl]
    and a
    jr nz, .call_debug_results_display_update_write_debug
    ld a, $04

.call_debug_results_display_update_write_debug:
    dec a
    ld [hl], a
    call DebugResultsDisplay_Update_WriteDebugCounter
    ret

.check_debug_cursor2:
    ld a, [wDebugCursor]
    cp $04
    jr nz, .read_screen_byte_bd3
    ld hl, wGridCursorY
    jr .read_screen_byte_bd4

.read_screen_byte_bd3:
    ld hl, wDebugResultsBuf

.read_screen_byte_bd4:
    ld a, [wScreenByteBD]
    add_a_to_hl
    ld a, [hl]
    cp $03
    jr c, .call_debug_results_display_update_write_debug2
    ld a, $ff

.call_debug_results_display_update_write_debug2:
    inc a
    ld [hl], a
    call DebugResultsDisplay_Update_WriteDebugCounter
    ret

.call_debug_results_display_update_hl_to2:
    call DebugResultsDisplay_Update_HLToDecimalDigits
    ld a, [wScreenByteBD]
    cp $1a
    jr c, .set_screen_byte_bd
    ld a, $ff

.set_screen_byte_bd:
    inc a
    ld [wScreenByteBD], a
    call DebugResultsDisplay_Update_WriteDebugCounter
    ret

.call_debug_results_display_update_hl_to3:
    call DebugResultsDisplay_Update_HLToDecimalDigits
    ld a, [wScreenByteBD]
    and a
    jr nz, .set_screen_byte_bd2
    ld a, $1b

.set_screen_byte_bd2:
    dec a
    ld [wScreenByteBD], a
    call DebugResultsDisplay_Update_WriteDebugCounter
    ret

DebugResultsDisplay_Update_WriteDebugCounter::
    ld a, [wDebugCounter]
    inc a
    ld [wDebugCounter], a
    cp $10
    jr c, DebugResultsDisplay_Update_HLToDecimalDigits
    cp $18
    jr c, DebugResultsDisplay_Update_HLToDecimalDigits_CallDebugResultsDisplay_Update_Sub02_ReadDeb
    xor a
    ld [wDebugCounter], a

DebugResultsDisplay_Update_HLToDecimalDigits::
    ld a, [wDebugCursor]
    cp $04
    jr nz, .read_screen_byte_bd
    ld hl, wGridCursorY
    jr .read_screen_byte_bd2

.read_screen_byte_bd:
    ld hl, wDebugResultsBuf

.read_screen_byte_bd2:
    ld a, [wScreenByteBD]
    add_a_to_hl
    ld a, [hl]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD
    ld a, [wDigits + $2]
    add $10
    ld c, a
    di
    call WaitForVRAMAccess
    ld a, c
    ld [hl], a
    ei
    ret

DebugResultsDisplay_Update_HLToDecimalDigits_CallDebugResultsDisplay_Update_Sub02_ReadDeb::
    call DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD
    di
    call WaitForVRAMAccess
    xor a
    ld [hl], a
    ei
    ret

DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD::
    ld a, [wDebugCursor]
    cp $04
    jr nz, .check_screen_byte_bd
    ld de, DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD_Data1
    jr .check_screen_byte_bd2

.check_screen_byte_bd:
    ld de, DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD_Data2

.check_screen_byte_bd2:
    ld a, [wScreenByteBD]
    cp $0e
    jr c, .skip
    sub $0e
    inc de
    inc de

.skip:
    push af
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    pop af
    add_a_to_hl
    ret

DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD_Data1::
    db $86, $99, $a6, $99

DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD_Data2::
    db $e6, $99, $06, $9a

DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD_Data2_CheckArg1::
    ld a, [wArg1]
    and a
    jr z, .call_compute_breeding_child
    cp $02
    jr z, .call_compute_breeding_child
    xor a
    ld [wArg1], a

.call_compute_breeding_child:
    farcall ComputeBreedingChild
    ld a, [wArg5]
    cp $ff
    ret nz
    ld a, [wArg1]
    push af
    ld a, [wArg7]
    cp $ff
    jr nz, .read_arg6
    ld a, [wArg6]
    cp $ff
    jr z, .call_debug_results_display_update_write

.read_arg6:
    ld a, [wArg6]
    ld [wArg1], a
    ld a, [wArg7]
    ld [wArg2], a
    ld de, DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD_Data3
    ld a, e
    ld [wArg3], a
    ld a, d
    ld [wArg4], a
    farcall TestBitInFieldAtArg3
    ld a, [wArg5]
    cp $ff
    jr z, .set_text_window_tile_lo
    call DebugResultsDisplay_Update_WriteUnknownName
    ld hl, vTiles2 + $500
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld de, vTiles2 + $500
    call CopyGlyphTilesToVRAM
    jr .set_text_window_tile_lo2

.call_debug_results_display_update_write:
    call DebugResultsDisplay_Update_WriteUnknownName
    ld hl, vTiles2 + $500
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    ld hl, vTiles2 + $200
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    call FillTilesFromRequest
    ld de, vTiles2 + $200
    call CopyGlyphTilesToVRAM
    ld de, vTiles2 + $500
    call CopyGlyphTilesToVRAM
    ld bc, $0000
    ld de, vBGMap0 + $6a
    call WriteThreeHexDigitsAtDE
    xor a
    ld [wScreenState], a
    ld [wNameEntryState], a
    ret

.set_text_window_tile_lo:
    ld hl, vTiles2 + $500
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest

.set_text_window_tile_lo2:
    ld hl, vTiles2 + $200
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    call FillTilesFromRequest
    ld de, wArg6
    ld hl, vTiles2 + $200
    call DrawMonsterNameForWordAtDE_Bank01
    ld a, [wArg6]
    ld c, a
    ld a, [wArg7]
    ld b, a
    ld de, vBGMap0 + $6a
    call WriteThreeHexDigitsAtDE
    ld hl, wChildRecord + MON_SEX
    ld a, [hl]
    and $01
    add $fe
    ld c, a
    ld hl, vBGMap0 + $71
    di
    call WaitForVRAMAccess
    ld a, c
    ld [hl], a
    ei
    ld hl, wChildRecord + MON_PLUS
    ld a, [hl]
    ld c, a
    ld de, vBGMap0 + $2
    call PackTwoDigitsOfCAsBCD
    call DebugResultsDisplay_Update_Sub02_Sub01_WaitForVRAMAccess
    ld hl, wChildRecord + MON_LEVEL
    ld a, [hl]
    ld c, a
    ld de, vBGMap0 + $22
    call PackTwoDigitsOfCAsBCD
    call DebugResultsDisplay_Update_Sub02_Sub01_WaitForVRAMAccess
    ld hl, wChildRecord + MON_MAX_LEVEL
    ld a, [hl]
    ld c, a
    ld de, vBGMap0 + $42
    call PackTwoDigitsOfCAsBCD
    call DebugResultsDisplay_Update_Sub02_Sub01_WaitForVRAMAccess
    ld hl, wChildRecord + MON_RESISTANCES
    ld de, vBGMap0 + $6
    ld c, $00

.loop:
    di
    call WaitForVRAMAccess
    ld a, [hli]
    add $10
    ld [de], a
    ei
    inc de
    inc c
    ld a, c
    cp $0e
    jr c, .loop
    ld de, vBGMap0 + $26
    ld c, $00

.loop2:
    di
    call WaitForVRAMAccess
    ld a, [hli]
    add $10
    ld [de], a
    ei
    inc de
    inc c
    ld a, c
    cp $0d
    jr c, .loop2
    pop af
    ld [wArg1], a
    xor a
    ld [wScreenState], a
    ld [wNameEntryState], a
    ret

DebugResultsDisplay_Update_Sub02_Sub01_WaitForVRAMAccess::
    ld a, c
    and $f0
    swap a
    add $10
    ld b, a
    ld a, c
    and $0f
    add $10
    ld c, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [de], a
    inc de
    ei
    di
    call WaitForVRAMAccess
    ld a, c
    ld [de], a
    ei
    ret

DebugResultsDisplay_Update_Sub02_Sub01_WaitForVRAMAccess_CheckJoypadPressedRepeat::
    ld a, [wJoypadPressedRepeat]
    bit 0, a
    jp nz, DebugToggleArg1Marker_CheckScreenCounter
    bit 1, a
    jp nz, DebugToggleArg1Marker_ClearDebugCursor
    bit 6, a
    jp nz, DebugToggleArg1Marker_CallDrawDebugFieldValueDebugCursor
    bit 7, a
    jp nz, DebugToggleArg1Marker_CallDrawDebugFieldValueDebugCursor2
    bit 4, a
    jp nz, DebugToggleArg1Marker_CheckDebugCursor2
    bit 5, a
    jp nz, DebugToggleArg1Marker_CheckDebugCursor3
    bit 3, a
    jp nz, DebugToggleArg1Marker_CheckDebugCursor
    bit 2, a
    jp nz, .read_debug_value0
    call StepDebugCursorDebugCounter
    ret

.read_debug_value0:
    ld a, [wDebugValue0]
    ld [wArg2], a
    ld a, [wDebugValue1]
    ld [wArg3], a
    ld a, [wArg2]
    ld [wSpeciesIdLo], a
    ld a, [wArg3]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld c, $00
    ld de, wGridCursorY
    call CopySpeciesExpCurveBBytesFromIndexCToDE
    ld a, [wDebugValue3]
    ld [wArg2], a
    ld a, [wDebugState]
    ld [wArg3], a
    ld a, [wArg2]
    ld [wSpeciesIdLo], a
    ld a, [wArg3]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld c, $00
    ld de, wDebugResultsBuf
    call CopySpeciesExpCurveBBytesFromIndexCToDE
    ld hl, wGridCursorY
    ld de, vBGMap0 + $186
    ld c, $00

.loop:
    di
    call WaitForVRAMAccess
    ld a, [hli]
    add $10
    ld [de], a
    ei
    inc de
    inc c
    ld a, c
    cp $0e
    jr c, .loop
    ld de, vBGMap0 + $1a6
    ld c, $00

.loop2:
    di
    call WaitForVRAMAccess
    ld a, [hli]
    add $10
    ld [de], a
    ei
    inc de
    inc c
    ld a, c
    cp $0d
    jr c, .loop2
    ld hl, wDebugResultsBuf
    ld de, vBGMap0 + $1e6
    ld c, $00

.loop3:
    di
    call WaitForVRAMAccess
    ld a, [hli]
    add $10
    ld [de], a
    ei
    inc de
    inc c
    ld a, c
    cp $0e
    jr c, .loop3
    ld de, vBGMap0 + $206
    ld c, $00

.loop4:
    di
    call WaitForVRAMAccess
    ld a, [hli]
    add $10
    ld [de], a
    ei
    inc de
    inc c
    ld a, c
    cp $0d
    jr c, .loop4
    ret

; for C up to $1A, loads byte C of wSpeciesRecord + $12 (LoadWD01AByteArg4) and stores it at DE
; (E-0122) (E-0340: the address in its name read as its RAM name; was CopyWD01ABytesFromIndexCToDE)
CopySpeciesExpCurveBBytesFromIndexCToDE::
    push bc
    push de
    ld a, c
    ld [wArg4], a
    farcall LoadSpeciesExpCurveBByteArg4
    pop de
    pop bc
    ld a, [wArg5]
    ld [de], a
    inc de
    inc c
    ld a, c
    cp $1b
    jr c, CopySpeciesExpCurveBBytesFromIndexCToDE
    ret

; debug: toggles wArg1 between 0 and 2 and writes tile $10 + wArg1 at vBGMap0 + $81; the following
; entries are the debug results screen input handlers (E-0131)
DebugToggleArg1Marker::
    ld a, [wArg1]
    and a
    jr nz, .clear_arg1
    ld a, $02
    ld [wArg1], a
    jr .call_wait_for_vram_access

.clear_arg1:
    xor a
    ld [wArg1], a

.call_wait_for_vram_access:
    di
    call WaitForVRAMAccess
    ld a, [wArg1]
    add $10
    ld [vBGMap0 + $81], a
    ei
    ret

DebugToggleArg1Marker_CheckDebugCursor::
    ld a, [wDebugCursor]
    cp $04
    jr z, .call_draw_debug_field_value_debug_cursor
    cp $07
    jr z, .call_draw_debug_field_value_debug_cursor
    call DebugToggleArg1Marker
    call StepDebugCursorDebugCounter
    ret

.call_draw_debug_field_value_debug_cursor:
    call DrawDebugFieldValueDebugCursor
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    xor a
    ld [wScreenByteBD], a
    ret

DebugToggleArg1Marker_CallDrawDebugFieldValueDebugCursor::
    call DrawDebugFieldValueDebugCursor
    ld a, [wDebugCursor]
    and a
    ret z
    dec a
    ld [wDebugCursor], a
    call StepDebugCursorDebugCounter
    ret

DebugToggleArg1Marker_CallDrawDebugFieldValueDebugCursor2::
    call DrawDebugFieldValueDebugCursor
    ld a, [wDebugCursor]
    cp $09
    ret z
    inc a
    ld [wDebugCursor], a
    call StepDebugCursorDebugCounter
    ret

DebugToggleArg1Marker_CheckDebugCursor2::
    ld a, [wDebugCursor]
    and a
    jr z, .skip6
    cp $01
    jr z, .skip
    cp $02
    jr z, .skip5
    cp $03
    jr z, .skip2
    jp DebugToggleArg1Marker_Cp04

.skip:
    ld hl, wDebugValue2
    jr .skip3

.skip2:
    ld hl, wDebugSubState

.skip3:
    push hl
    ld a, [hl]
    ld c, a
    and a
    jr z, .skip4
    ld a, $ff

.skip4:
    inc a
    ld c, a
    pop hl
    ld a, c
    ld [hl], a
    call StepDebugCursorDebugCounter
    ret

.skip5:
    ld hl, wDebugValue3
    jr .skip7

.skip6:
    ld hl, wDebugValue0

.skip7:
    push hl
    ld a, [hli]
    ld c, a
    ld a, [hl]
    ld b, a
    cp $01
    jr c, .next
    ld a, c
    cp $74
    jr c, .next
    ld bc, $ffff

.next:
    inc bc
    pop hl
    ld a, c
    ld [hli], a
    ld a, b
    ld [hl], a
    call StepDebugCursorDebugCounter
    ld a, [wDebugCursor]
    cp $02
    jr z, DebugToggleArg1Marker_Loop
    ld de, wDebugValue0
    ld hl, vTiles2 + $300
    jr DebugToggleArg1Marker_Skip

DebugToggleArg1Marker_Loop::
    ld de, wDebugValue3
    ld hl, vTiles2 + $400

DebugToggleArg1Marker_Skip::
    push de
    push hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    pop hl
    pop de
    call DrawMonsterNameForWordAtDE_Bank01
    ret

DebugToggleArg1Marker_CheckDebugCursor3::
    ld a, [wDebugCursor]
    and a
    jr z, .skip5
    cp $01
    jr z, .skip
    cp $02
    jr z, .skip6
    cp $03
    jr z, .skip2
    jp DebugToggleArg1Marker_Cp042

.skip:
    ld hl, wDebugValue2
    jr .skip3

.skip2:
    ld hl, wDebugSubState

.skip3:
    push hl
    ld a, [hl]
    cp $01
    jr z, .skip4
    ld a, $02

.skip4:
    dec a
    pop hl
    ld [hl], a
    call StepDebugCursorDebugCounter
    ret

.skip5:
    ld hl, wDebugValue0
    jr .skip7

.skip6:
    ld hl, wDebugValue3

.skip7:
    push hl
    ld a, [hli]
    ld c, a
    ld a, [hl]
    ld b, a
    and a
    jr nz, .next
    ld a, c
    and a
    jr nz, .next
    ld bc, $0175

.next:
    dec bc
    pop hl
    ld a, c
    ld [hli], a
    ld a, b
    ld [hl], a
    call StepDebugCursorDebugCounter
    ld a, [wDebugCursor]
    cp $02
    jp z, DebugToggleArg1Marker_Loop
    ld de, wDebugValue0
    ld hl, vTiles2 + $300
    jp DebugToggleArg1Marker_Skip

DebugToggleArg1Marker_Cp04::
    cp $04
    jr z, .skip
    cp $05
    jr z, .skip5
    cp $06
    jr z, .skip7
    cp $07
    jr z, .skip2
    cp $08
    jr z, .skip6
    jr .skip8

.skip:
    ld hl, wScreenStep
    ld c, $63
    jr .skip3

.skip2:
    ld hl, wScreenSubStep
    ld c, $63

.skip3:
    push hl
    ld a, [hl]
    cp c
    jr c, .skip4
    ld a, $ff

.skip4:
    inc a
    pop hl
    ld [hl], a
    call StepDebugCursorDebugCounter
    ret

.skip5:
    ld hl, wScreenCounter
    ld c, $63
    jr .skip3

.skip6:
    ld hl, wGlyphListPos
    ld c, $63
    jr .skip3

.skip7:
    ld hl, wGlyphListStart
    ld c, $1b
    jr .skip3

.skip8:
    ld hl, wGridCursorX
    ld c, $1b
    jr .skip3

DebugToggleArg1Marker_Cp042::
    cp $04
    jr z, .skip
    cp $05
    jr z, .skip5
    cp $06
    jr z, .skip7
    cp $07
    jr z, .skip2
    cp $08
    jr z, .skip6
    jr .skip8

.skip:
    ld hl, wScreenStep
    ld c, $64
    jr .skip3

.skip2:
    ld hl, wScreenSubStep
    ld c, $64

.skip3:
    push hl
    ld a, [hl]
    and a
    jr nz, .skip4
    ld a, c

.skip4:
    dec a
    pop hl
    ld [hl], a
    call StepDebugCursorDebugCounter
    ret

.skip5:
    ld hl, wScreenCounter
    ld c, $64
    jr .skip3

.skip6:
    ld hl, wGlyphListPos
    ld c, $64
    jr .skip3

.skip7:
    ld hl, wGlyphListStart
    ld c, $1c
    jr .skip3

.skip8:
    ld hl, wGridCursorX
    ld c, $1c
    jr .skip3

DebugToggleArg1Marker_ClearDebugCursor::
    xor a
    ld [wDebugCursor], a
    ld [wDebugValue0], a
    ld [wDebugValue1], a
    ld [wDebugValue2], a
    ld [wDebugValue3], a
    ld [wDebugState], a
    ld [wDebugSubState], a
    ld [wDebugCounter], a
    xor a
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

DebugToggleArg1Marker_CheckScreenCounter::
    ld a, [wScreenCounter]
    cp $0a
    ret c
    ld a, [wGlyphListPos]
    cp $0a
    ret c
    ld hl, wDebugValue2
    ld de, wDebugSubState
    ld a, [hl]
    ld b, a
    ld a, [de]
    cp b
    jr nz, .skip
    ret

.skip:
    ld hl, wRecordBufA
    ld bc, $01ef

.loop:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld hl, wRecordBufA + MON_SPECIES
    ld a, [wDebugValue0]
    ld [hli], a
    ld a, [wDebugValue1]
    ld [hli], a
    ld hl, wRecordBufB + MON_SPECIES
    ld a, [wDebugValue3]
    ld [hli], a
    ld a, [wDebugState]
    ld [hli], a
    ld hl, wRecordBufA + MON_SEX
    ld a, [wDebugValue2]
    ld [hl], a
    ld hl, wRecordBufB + MON_SEX
    ld a, [wDebugSubState]
    ld [hl], a
    ld a, [wDebugValue0]
    ld [wArg6], a
    ld a, [wDebugValue1]
    ld [wArg7], a
    farcall FamilyForSpeciesIdArg6
    ld a, [wArg5]
    ld hl, wRecordBufA + MON_FAMILY
    ld [hl], a
    ld a, [wDebugValue3]
    ld [wArg6], a
    ld a, [wDebugState]
    ld [wArg7], a
    farcall FamilyForSpeciesIdArg6
    ld a, [wArg5]
    ld hl, wRecordBufB + MON_FAMILY
    ld [hl], a
    ld hl, wRecordBufA + MON_PLUS
    ld a, [wScreenStep]
    ld [hl], a
    ld hl, wRecordBufB + MON_PLUS
    ld a, [wScreenSubStep]
    ld [hl], a
    ld hl, wRecordBufA + MON_LEVEL
    ld a, [wScreenCounter]
    ld [hl], a
    ld hl, wRecordBufB + MON_LEVEL
    ld a, [wGlyphListPos]
    ld [hl], a
    ld hl, wRecordBufA + MON_ITEM
    ld a, [wGlyphListStart]
    ld [hl], a
    ld hl, wRecordBufB + MON_ITEM
    ld a, [wGridCursorX]
    ld [hl], a
    ld hl, wGridCursorY
    ld de, wRecordBufA + MON_RESISTANCES
    ld b, $1b

.loop2:
    ld a, [hl]
    ld [de], a
    inc hl
    inc de
    dec b
    jr nz, .loop2
    ld hl, wDebugResultsBuf
    ld de, wRecordBufB + MON_RESISTANCES
    ld b, $1b

.loop3:
    ld a, [hl]
    ld [de], a
    inc hl
    inc de
    dec b
    jr nz, .loop3
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a
    ld [wNameEntryState], a
    ret

; debug: wDebugCounter += 1; below $10 continues at DrawDebugFieldValueDebugCursor, below $18 at
; PackTwoDigitsOfCAsBCD_ReadDebugCursor, then wraps to 0 (E-0126)
StepDebugCursorDebugCounter::
    ld a, [wDebugCounter]
    inc a
    ld [wDebugCounter], a
    cp $10
    jr c, DrawDebugFieldValueDebugCursor
    cp $18
    jp c, PackTwoDigitsOfCAsBCD_ReadDebugCursor
    xor a
    ld [wDebugCounter], a

; debug: draws the value of field wDebugCursor (DrawDebugFieldValueDebugCursor_Data1) at
; DrawDebugFieldValueDebugCursor_Data2[wDebugCursor] as hex, a tile or BCD (E-0128)
DrawDebugFieldValueDebugCursor::
    ld a, [wDebugCursor]
    sla a
    ld de, DrawDebugFieldValueDebugCursor_Data1
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
    ld a, [hl]
    ld c, a
    inc hl
    ld a, [hl]
    ld b, a
    ld a, [wDebugCursor]
    cp $04
    jr nc, .read_debug_cursor2
    bit 0, a
    jr nz, .read_debug_cursor
    ld a, [wDebugCursor]
    sla a
    ld hl, DrawDebugFieldValueDebugCursor_Data2
    add_a_to_hl
    ld a, [hl]
    ld e, a
    inc hl
    ld a, [hl]
    ld d, a
    call WriteThreeHexDigitsAtDE
    ret

.read_debug_cursor:
    ld a, [wDebugCursor]
    sla a
    ld hl, DrawDebugFieldValueDebugCursor_Data2
    add_a_to_hl
    ld a, [hl]
    ld e, a
    inc hl
    ld a, [hl]
    ld d, a
    di
    call WaitForVRAMAccess
    ld a, c
    add $fe
    ld [de], a
    ei
    ret

.read_debug_cursor2:
    ld a, [wDebugCursor]
    sla a
    ld hl, DrawDebugFieldValueDebugCursor_Data2
    add_a_to_hl
    ld a, [hl]
    ld e, a
    inc hl
    ld a, [hl]
    ld d, a
    call PackTwoDigitsOfCAsBCD
    call WriteHexByteTilesAtDE
    ret

; C = the last two decimal digits of C packed as BCD (E-0125)
PackTwoDigitsOfCAsBCD::
    push de
    ld l, c
    ld h, $00
    call HLToDecimalDigits
    ld a, [wDigits + $1]
    and $0f
    swap a
    ld c, a
    ld a, [wDigits + $2]
    and $0f
    or c
    ld c, a
    pop de
    ret

PackTwoDigitsOfCAsBCD_ReadDebugCursor::
    ld a, [wDebugCursor]
    sla a
    ld hl, DrawDebugFieldValueDebugCursor_Data2
    add_a_to_hl
    ld a, [hl]
    ld e, a
    inc hl
    ld a, [hl]
    ld d, a
    di
    call WaitForVRAMAccess
    xor a
    ld [de], a
    inc de
    ei
    di
    call WaitForVRAMAccess
    xor a
    ld [de], a
    inc de
    ei
    di
    call WaitForVRAMAccess
    xor a
    ld [de], a
    inc de
    ei
    ret

DrawDebugFieldValueDebugCursor_Data1::
    db $f9, $c5, $fb, $c5, $fc, $c5, $fe, $c5, $81, $d7, $83, $d7, $85, $d7, $82, $d7
    db $84, $d7, $86, $d7

DrawDebugFieldValueDebugCursor_Data2::
    db $e6, $98, $06, $99, $26, $99, $46, $99, $82, $99, $a2, $99, $c2, $99, $e2, $99
    db $02, $9a, $22, $9a

; reads a monster id word at DE, copies its name and draws its glyphs at HL (E-0122)
DrawMonsterNameForWordAtDE_Bank01::
    push hl
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call CopyMonsterNameToBuffer_B01
    pop hl
    ld e, l
    ld d, h
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    call CopyGlyphTilesToVRAM
    ret

; HL = string number; copies 16 bytes of that string of StringTable_MonsterNames (bank $08, via
; wDataBank) to wNameGlyphBuf; wDataBank is restored
CopyMonsterNameToBuffer_B01::
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
    ld hl, wNameGlyphBuf
    ld b, $08
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; fills wNameGlyphBuf with nine $98 placeholder glyphs and $F0
DebugResultsDisplay_Update_WriteUnknownName::
    ld c, $00
    ld hl, wNameGlyphBuf

.loop:
    ld a, $98
    ld [hli], a
    inc c
    ld a, c
    cp $09
    jr c, .loop
    ld a, $f0
    ld [hl], a
    ret

; update for debug-mode state 3: the screen shows '? AUTOMAP ?' (key, level, position) (E-0041)
DebugAutomap_Update::
    ld a, [wJoypadPressed]
    bit 0, a
    jp z, .check_bit1
    ld a, [wDebugState]
    cp $ff
    jr z, .call_debug_automap_update_roll_key_contents
    ld a, [wDebugSubState]
    bit 7, a
    jr nz, .check_debug_state

.call_debug_automap_update_roll_key_contents:
    call DebugAutomap_Update_RollKeyContentsForLevelTemp0
    ret

.check_bit1:
    bit 1, a
    jr z, .check_bit3

.check_debug_state:
    ld a, [wDebugState]
    cp $ff
    ret z
    ld a, [wDebugValue0]
    ld [wCurrentKeyIndex], a
    ld a, [wDebugValue2]
    ldh [hMapScreenX], a
    ld a, [wDebugValue3]
    ldh [hMapScreenY], a
    ld a, [wDebugSubState]
    bit 7, a
    jr z, .check_debug_state2
    ld a, [wDebugState]
    and $1f
    ld hl, DebugAutomap_Update_Data
    add_a_to_hl
    ld a, [hl]
    ldh [hMapId], a
    xor a
    ld [wMapType], a
    xor a
    ld [wScriptRunning], a
    ld a, $01
    ld [wGameMode], a
    xor a
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.check_debug_state2:
    ld a, [wDebugState]
    and $7f
    ld [wKeyWorldSlot], a
    farcall LoadKeyWorldFlagsRecordFromSRAMSlotKeyWorldSlot
    ld a, $80
    ld [wMapType], a
    xor a
    ld [wScriptRunning], a
    ld a, [wKeyWorldWidth]
    ld [wMapWidthScreens], a
    ld a, [wKeyWorldHeight]
    ld [wMapHeightScreens], a
    ld a, $01
    ld [wGameMode], a
    ld a, $05
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.check_bit3:
    bit 3, a
    jr z, .check_joypad_pressed_repeat
    ld a, $00
    ld [wGameMode], a
    ld a, $00
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr z, .check_bit7
    ld a, [wDebugCursor]
    dec a
    cp $ff
    jr nz, .set_debug_cursor
    ld a, $03

.set_debug_cursor:
    ld [wDebugCursor], a
    jr .check_joypad_pressed_repeat2

.check_bit7:
    bit 7, a
    jr z, .check_joypad_pressed_repeat2
    ld a, [wDebugCursor]
    inc a
    cp $04
    jr nz, .set_debug_cursor2
    xor a

.set_debug_cursor2:
    ld [wDebugCursor], a

.check_joypad_pressed_repeat2:
    ld c, $00
    ld a, [wJoypadPressedRepeat]
    bit 5, a
    jr z, .check_bit4
    ld c, $ff
    jr .skip

.check_bit4:
    bit 4, a
    jr z, .skip
    ld c, $01

.skip:
    bit 0, c
    jr z, .check_debug_value0
    ld a, [wDebugCursor]
    or a
    jr nz, .skip2
    ld a, [wDebugValue0]
    add c
    cp $20
    jr nz, .cp_FF
    xor a
    jr .set_debug_value0

.cp_FF:
    cp $ff
    jr nz, .set_debug_value0
    ld a, $13

.set_debug_value0:
    or $80
    ld [wDebugValue0], a
    and $7f
    call LoadKeyEntryFieldsToDebugState
    jr .check_debug_value0

.skip2:
    dec a
    jr nz, .skip3
    ld a, [wDebugSubState]
    bit 7, a
    jr nz, .skip3
    ld a, [wDebugValue1]
    add c
    cp $64
    jr nz, .cp_FF2
    xor a
    jr .set_debug_value1

.cp_FF2:
    cp $ff
    jr nz, .set_debug_value1
    ld a, $63

.set_debug_value1:
    or $80
    ld [wDebugValue1], a
    jr .check_debug_value0

.skip3:
    dec a
    jr nz, .skip4
    ld a, [wDebugValue2]
    add c
    and $0f
    ld [wDebugValue2], a
    jr .check_debug_value0

.skip4:
    dec a
    jr nz, .check_debug_value0
    ld a, [wDebugValue3]
    add c
    and $0f
    ld [wDebugValue3], a

.check_debug_value0:
    ld a, [wDebugValue0]
    bit 7, a
    jr z, .check_debug_value02
    call DebugAutomap_Update_CopyGlyphTilesToVRAM

.check_debug_value02:
    ld a, [wDebugValue0]
    bit 7, a
    jr z, .check_debug_value03
    and $7f
    ld de, vBGMap0 + $10a
    call WriteHexByteTilesAtDE

.check_debug_value03:
    ld a, [wDebugValue0]
    bit 7, a
    jr nz, .check_debug_value04
    ld a, [wDebugValue1]
    bit 7, a
    jr z, .read_debug_value2

.check_debug_value04:
    ld a, [wDebugValue0]
    and $7f
    ld [wDebugValue0], a
    ld a, [wDebugValue1]
    and $7f
    ld [wDebugValue1], a
    call DebugAutomap_Update_WriteHexByteTilesAtDE

.read_debug_value2:
    ld a, [wDebugValue2]
    ld de, vBGMap0 + $14a
    call WriteHexByteTilesAtDE
    ld a, [wDebugValue3]
    ld de, vBGMap0 + $16a
    call WriteHexByteTilesAtDE
    ld hl, vBGMap0 + $109
    ld b, $00

.loop:
    ld a, [wDebugCursor]
    cp b
    jr z, .call_write_vram_byte
    ld a, $80
    call WriteVRAMByte
    jr .skip5

.call_write_vram_byte:
    ld a, $f8
    call WriteVRAMByte

.skip5:
    ld a, $20
    add_a_to_hl
    inc b
    ld a, b
    cp $05
    jr nz, .loop
    ret

DebugAutomap_Update_Data::
    db $00, $05, $20, $30, $48, $70, $a0, $a8, $b0, $b8, $c8, $d1, $da

DebugAutomap_Update_RollKeyContentsForLevelTemp0::
    ld a, [wDebugValue1]
    ldh [hTemp0], a
    farcall RollKeyContentsForLevelTemp0
    ld a, [wDebugValue0]
    ld [wCurrentKeyIndex], a
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
    ld a, [wDebugState]
    cp $ff
    jr nz, .skip
    push hl
    farcall FindSRAMSlotMarkerIndex
    pop hl
    ldh a, [hTemp0]
    cp $ff
    ret z
    ld [hli], a
    jr .set_key_world_slot

.skip:
    ld a, [hl]
    and $7f
    ld [hli], a

.set_key_world_slot:
    ld [wKeyWorldSlot], a
    ldh a, [hTemp1]
    ld [hli], a
    ldh a, [hTemp2]
    ld [hli], a
    ldh a, [hTemp3]
    ld [hl], a
    ld [wPartyStrength], a
    farcall DebugAutomap_Update_Sub01_DebugAutomap_Update_MergeKeyWorldAreas
    farcall SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot
    ld a, [wKeyWorldWidth]
    ld [wMapWidthScreens], a
    ld a, [wKeyWorldHeight]
    ld [wMapHeightScreens], a
    xor a
    ldh [hPlayerFacing], a
    ld a, [wKeyWorldGoalScreen]
    swap a
    and $0f
    ldh [hMapScreenX], a
    ld a, [wKeyWorldGoalScreen]
    and $0f
    ldh [hMapScreenY], a
    ld a, [wKeyWorldGoalPos]
    ldh [hPlayerX], a
    ld a, [wKeyWorldGoalPos2]
    ldh [hPlayerY], a
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
    ld a, $80
    ld [wMapType], a
    ld a, $01
    ld [wGameMode], a
    ld a, $05
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

; A = key slot: wDebugState = byte 0 and wDebugSubState = byte 3 of its wKeyList entry, wDebugValue1
; = byte 3 | $80 (E-0120)
LoadKeyEntryFieldsToDebugState::
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
    ld [wDebugState], a
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    ld [wDebugSubState], a
    or $80
    ld [wDebugValue1], a
    ret

DebugAutomap_Update_WriteHexByteTilesAtDE::
    ld a, [wDebugState]
    cp $ff
    jr z, .clear_debug_value1
    ld a, [wDebugSubState]
    bit 7, a
    jr nz, .clear_debug_value1
    ld a, [wDebugValue1]
    and $7f
    ld de, vBGMap0 + $12a
    call WriteHexByteTilesAtDE
    ret

.clear_debug_value1:
    xor a
    ld [wDebugValue1], a
    ld de, vBGMap0 + $12a
    call WriteHexByteTilesAtDE
    ret

DebugAutomap_Update_CopyGlyphTilesToVRAM::
    ld a, $90
    ld [wNameGlyphBuf], a
    ld [wNameGlyphBuf + $1], a
    ld [wNameGlyphBuf + $2], a
    ld [wNameGlyphBuf + $3], a
    ld [wNameGlyphBuf + $4], a
    ld [wNameGlyphBuf + $5], a
    ld [wNameGlyphBuf + $6], a
    ld [wNameGlyphBuf + $7], a
    ld [wNameGlyphBuf + $8], a
    ld [wNameGlyphBuf + $9], a
    ld [wNameGlyphBuf + $a], a
    ld [wNameGlyphBuf + $b], a
    ld [wNameGlyphBuf + $c], a
    ld [wNameGlyphBuf + $d], a
    ld [wNameGlyphBuf + $e], a
    ld a, $f0
    ld [wNameGlyphBuf + $f], a
    ld de, vTiles2 + $200
    call CopyGlyphTilesToVRAM
    ld a, [wDebugSubState]
    bit 7, a
    jr z, .check_debug_sub_state
    ld a, [wDebugState]
    cp $ff
    jr nz, .check_debug_sub_state
    ld a, $29
    ld [wNameGlyphBuf], a
    ld a, $2a
    ld [wNameGlyphBuf + $1], a
    ld a, $8d
    ld [wNameGlyphBuf + $2], a
    ld a, $39
    ld [wNameGlyphBuf + $3], a
    ld a, $2f
    ld [wNameGlyphBuf + $4], a
    ld a, $f0
    ld [wNameGlyphBuf + $5], a
    ld de, vTiles2 + $200
    call CopyGlyphTilesToVRAM
    ret

.check_debug_sub_state:
    ld a, [wDebugSubState]
    bit 7, a
    jr z, .check_debug_value0
    ld a, [wDebugState]
    dec a
    swap a
    and $f0
    ld hl, DebugMenuNames
    add_a_to_hl
    ld de, wNameGlyphBuf

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    cp $f0
    jr nz, .loop
    ld de, vTiles2 + $200
    call CopyGlyphTilesToVRAM
    ret

.check_debug_value0:
    ld a, [wDebugValue0]
    and $1f
    ld de, wNameGlyphBuf
    call WriteKeyNameToDE
    ld de, vTiles2 + $200
    call CopyGlyphTilesToVRAM
    ret

; the debug menu copies the string at $5F56 + 16 * (wDebugState - 1) up to $F0 to wNameGlyphBuf and
; draws it with CopyGlyphTilesToVRAM; 10 rows, then an 8-byte string for the 11th entry (E-0233, C1)
; record: a debug menu entry name: glyph codes ending in $F0, padded to 16 bytes (not charmap.inc
; text)
DebugMenuNames::
    db $8a, $87, $42, $8d, $26, $3d, $29, $2a, $8d, $f0, $00, $00, $00, $00, $00, $00 ; id 1
    db $5e, $56, $66, $67, $3d, $29, $2a, $8d, $f0, $00, $00, $00, $00, $00, $00, $00 ; id 2
    db $29, $25, $32, $8d, $2b, $3d, $29, $2a, $8d, $f0, $00, $00, $00, $00, $00, $00 ; id 3
    db $44, $30, $8d, $26, $44, $3d, $29, $2a, $8d, $f0, $00, $00, $00, $00, $00, $00 ; id 4
    db $40, $4a, $26, $33, $25, $4f, $2b, $3d, $29, $2a, $8d, $f0, $00, $00, $00, $00 ; id 5
    db $64, $88, $62, $6a, $9c, $3d, $2f, $52, $3d, $29, $2a, $8d, $f0, $00, $00, $00 ; id 6
    db $5c, $87, $77, $3d, $47, $4f, $3d, $29, $2a, $8d, $f0, $00, $00, $00, $00, $00 ; id 7
    db $2c, $55, $2a, $4b, $26, $2f, $8d, $4d, $3d, $29, $2a, $8d, $f0, $00, $00, $00 ; id 8
    db $28, $47, $25, $37, $8d, $3d, $29, $2a, $8d, $f0, $00, $00, $00, $00, $00, $00 ; id 9
    db $43, $47, $3d, $35, $29, $25, $3d, $29, $2a, $8d, $f0, $00, $00, $00, $00, $00 ; id 10
    db $2f, $51, $55, $3d, $29, $2a, $8d, $f0 ; end

; update for debug-mode state 2: the screen shows '? EDIT ?' (world, map number, position) (E-0041)
DebugMapEditor_Update::
    ld a, [wJoypadPressedRepeat]
    bit 0, a
    jr z, .check_joypad_pressed_repeat
    ld a, [wDebugValue0]
    ldh [hTemp0], a
    call DebugMapEditor_Update_WriteROMB0AndTemp0
    or a
    jr z, .read_debug_value0
    ld b, $08
    ld hl, vBGMap0 + $1a5
    ld a, $f0

.loop:
    call WriteVRAMByteInc
    inc a
    dec b
    jr nz, .loop
    ret

.read_debug_value0:
    ld a, [wDebugValue0]
    ldh [hMapId], a
    ld a, [wDebugValue1]
    ldh [hMapScreenX], a
    ld a, [wDebugValue2]
    ldh [hPlayerX], a
    ld a, [wDebugValue3]
    ldh [hMapScreenY], a
    ld a, [wDebugState]
    ldh [hPlayerY], a
    xor a
    ld [wFieldReturnPhase], a
    ld a, $00
    ld [wGameMode], a
    ld a, $00
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr z, .check_bit7
    ld a, [wDebugCursor]
    dec a
    cp $ff
    jr nz, .set_debug_cursor
    ld a, $04

.set_debug_cursor:
    ld [wDebugCursor], a
    jr .check_frame_counter_lo

.check_bit7:
    bit 7, a
    jr z, .check_frame_counter_lo
    ld a, [wDebugCursor]
    inc a
    cp $05
    jr nz, .set_debug_cursor2
    xor a

.set_debug_cursor2:
    ld [wDebugCursor], a

.check_frame_counter_lo:
    ld c, $00
    ld a, [wFrameCounterLo]
    and $03
    jr nz, .skip
    ld a, [wJoypadHeld]
    bit 5, a
    jr z, .check_bit4
    ld c, $ff
    jr .skip

.check_bit4:
    bit 4, a
    jr z, .skip
    ld c, $01

.skip:
    bit 0, c
    jr z, .check_debug_sub_state
    ld a, [wDebugCursor]
    or a
    jr nz, .skip2
    ld a, [wDebugValue0]
    add c
    cp $ff
    jr nz, .set_debug_value0
    ld a, $e1

.set_debug_value0:
    ld [wDebugValue0], a
    ld hl, wDebugSubState
    inc [hl]
    jr .check_debug_sub_state

.skip2:
    dec a
    jr nz, .skip3
    ld a, [wDebugValue1]
    add c
    and $0f
    ld [wDebugValue1], a
    jr .check_debug_sub_state

.skip3:
    dec a
    jr nz, .skip4
    ld a, [wDebugValue3]
    add c
    and $0f
    ld [wDebugValue3], a
    jr .check_debug_sub_state

.skip4:
    dec a
    jr nz, .skip5
    sla c
    sla c
    sla c
    sla c
    ld a, [wDebugValue2]
    add c
    ld [wDebugValue2], a
    jr .check_debug_sub_state

.skip5:
    sla c
    sla c
    sla c
    sla c
    ld a, [wDebugState]
    add c
    ld [wDebugState], a

.check_debug_sub_state:
    ld a, [wDebugSubState]
    or a
    jr z, .read_debug_value1
    ld a, [wDebugValue0]
    add $0a
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    ld hl, vTiles2 + $200
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1001
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank08
    xor a
    ld [wDebugSubState], a

.read_debug_value1:
    ld a, [wDebugValue1]
    ld de, vBGMap0 + $10a
    call WriteHexByteTilesAtDE
    ld a, [wDebugValue3]
    ld de, vBGMap0 + $12a
    call WriteHexByteTilesAtDE
    ld a, [wDebugValue2]
    swap a
    and $0f
    ld de, vBGMap0 + $14a
    call WriteHexByteTilesAtDE
    ld a, [wDebugState]
    swap a
    and $0f
    ld de, vBGMap0 + $16a
    call WriteHexByteTilesAtDE
    ld hl, vBGMap0 + $e9
    ld b, $00

.loop2:
    ld a, [wDebugCursor]
    cp b
    jr z, .call_write_vram_byte
    ld a, $80
    call WriteVRAMByte
    jr .skip6

.call_write_vram_byte:
    ld a, $f8
    call WriteVRAMByte

.skip6:
    ld a, $20
    add_a_to_hl
    inc b
    ld a, b
    cp $05
    jr nz, .loop2
    ret

; update for debug-mode state 0: the screen shows the debug menu (E-0041)
DebugMainMenu_Update::
    ld a, [wJoypadPressedRepeat]
    and $90
    jr z, .check_joypad_pressed_repeat
    ld a, [wDebugCursor]
    inc a
    cp $0c
    jr nz, .set_debug_cursor
    ld a, $00
    jr .set_debug_cursor

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and $60
    jr z, .read_debug_cursor
    ld a, [wDebugCursor]
    dec a
    cp $ff
    jr nz, .set_debug_cursor
    ld a, $0b

.set_debug_cursor:
    ld [wDebugCursor], a

.read_debug_cursor:
    ld a, [wDebugCursor]
    swap a
    add $a0
    ld hl, vBGMap0 + $122
    ld b, $10

.loop:
    call WriteVRAMByteInc
    inc a
    dec b
    jr nz, .loop
    ld a, [wJoypadPressed]
    and $01
    ret z
    ld a, [wDebugCursor]
    or a
    jr nz, .skip
    ld a, $01
    ld [wGameMode], a
    ld hl, wModeChangeRequest
    inc [hl]
    xor a
    ld [wMapType], a
    ld a, $80
    ld [wKeyWorldRefresh], a
    ret

.skip:
    dec a
    jr nz, .skip2
    ld a, $00
    ld [wGameMode], a
    ld a, $02
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.skip2:
    dec a
    jr nz, .skip3
    ld a, $00
    ld [wGameMode], a
    ld a, $03
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.skip3:
    dec a
    jr nz, .skip4
    ld a, $00
    ld [wGameMode], a
    ld a, $04
    ld [wModeState], a
    ld a, $80
    ld [wFieldTransitionStep], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.skip4:
    dec a
    jr nz, .skip5
    ld a, $00
    ld [wGameMode], a
    ld a, $05
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.skip5:
    dec a
    jr nz, .skip6
    ld a, $00
    ld [wGameMode], a
    ld a, $06
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.skip6:
    dec a
    jr nz, .skip7
    ld a, $00
    ld [wGameMode], a
    ld a, $07
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.skip7:
    dec a
    jr nz, .skip8
    ld a, $00
    ld [wGameMode], a
    ld a, $08
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.skip8:
    dec a
    jr nz, .skip9
    ld a, $00
    ld [wGameMode], a
    ld a, $09
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.skip9:
    dec a
    jr nz, .skip10
    ld a, $00
    ld [wGameMode], a
    ld a, $0a
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.skip10:
    dec a
    jr nz, .read_debug_menu_flag0
    ld a, $00
    ld [wGameMode], a
    ld a, $0b
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.read_debug_menu_flag0:
    ld hl, wGameMode
    ld a, [wDebugMenuFlag0]
    ld [hli], a
    ld a, [wDebugMenuFlag1]
    ld [hli], a
    ld a, [wDebugMenuFlag2]
    ld [hli], a
    ld a, [wDebugMenuFlag3]
    ld [hl], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

; update for debug-mode state 4: the screen shows 'MONSTER BGSD CHARA': monster picture and sprite
; viewer (E-0041)
DebugMonsterPictureViewer_Update::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, [wDebugState]
    inc a
    and $03
    ld [wDebugState], a
    jr .check_joypad_pressed

.check_bit1:
    bit 1, a
    jr z, .check_joypad_pressed
    ld a, $00
    ld [wGameMode], a
    ld a, $00
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $c0
    jr z, .read_debug_cursor
    ld a, [wDebugCursor]
    inc a
    and $01
    ld [wDebugCursor], a
    ret

.read_debug_cursor:
    ld a, [wDebugCursor]
    sla a
    ld de, wDebugValue0
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
    ld a, [wJoypadPressedRepeat]
    bit 5, a
    jr z, .check_bit4
    dec hl
    ld a, h
    or $80
    ld [de], a
    dec de
    ld a, l
    ld [de], a
    ld a, h
    cp $ff
    jr nz, .check_debug_value1
    ld a, [wDebugCursor]
    or a
    jr nz, .skip2
    ld hl, $017e
    ld a, h
    or $80
    ld h, a
    ld a, l
    ld [wDebugValue0], a
    ld a, h
    ld [wDebugValue1], a
    jr .check_debug_value1

.skip2:
    ld hl, $017e
    ld a, h
    or $80
    ld h, a
    ld a, l
    ld [wDebugValue2], a
    ld a, h
    ld [wDebugValue3], a
    jr .check_debug_value1

.check_bit4:
    bit 4, a
    jr z, .check_debug_value1
    ld a, [wDebugCursor]
    or a
    jr nz, .skip3
    ld a, $7e
    cp l
    jr nz, .next
    ld a, $01
    cp h
    jr nz, .next
    ld a, $80
    ld [de], a
    dec de
    xor a
    ld [de], a
    jr .check_debug_value1

.skip3:
    ld a, $7e
    cp l
    jr nz, .next
    ld a, $01
    cp h
    jr nz, .next
    ld a, $80
    ld [de], a
    dec de
    xor a
    ld [de], a
    jr .check_debug_value1

.next:
    inc hl
    ld a, h
    or $80
    ld [de], a
    dec de
    ld a, l
    ld [de], a

.check_debug_value1:
    ld a, [wDebugValue1]
    bit 7, a
    jr z, .check_debug_value3
    and $7f
    ld [wDebugValue1], a
    ld a, [wDebugValue0]
    ld e, a
    ld a, [wDebugValue1]
    ld d, a
    ld hl, vTiles2 + $200
    ld c, $01
    call LoadMonsterPicture
    ld a, [wIsCGB]
    or a
    jr z, .check_debug_value3
    ld hl, vBGMap0 + $124
    ld a, $01
    ldh [hTemp0], a
    ld a, [wDebugValue0]
    ld e, a
    ld a, [wDebugValue1]
    ld d, a
    call LoadMonsterPictureAttributes
    ld a, $7f
    ld [wBGPaletteUploadRequest], a

.check_debug_value3:
    ld a, [wDebugValue3]
    bit 7, a
    jr z, .check_debug_cursor
    and $7f
    ld [wDebugValue3], a
    ld a, [wDebugValue2]
    ld e, a
    ld a, [wDebugValue3]
    ld d, a
    ld a, [wDebugValue2]
    ld l, a
    ld a, [wDebugValue3]
    ld h, a
    add hl, hl
    add hl, de
    ld de, MonsterSpriteTable
    add hl, de
    ld e, l
    ld d, h
    ld b, $04
    call ReadByteInBank
    ld l, c
    inc de
    call ReadByteInBank
    ld h, c
    inc de
    call ReadByteInBank
    ld b, c
    ld e, l
    ld d, h
    ld hl, vTiles0 + $200
    call DecompressToVRAM
    ld a, [wIsCGB]
    or a
    jr z, .check_debug_cursor
    ld a, [wDebugValue2]
    ld l, a
    ld a, [wDebugValue3]
    ld h, a
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add $28
    ld l, a
    ld a, h
    adc $73
    ld h, a
    ld e, l
    ld d, h
    ld b, $27
    ld hl, wOBJPaletteBuffer
    ld c, $08

.loop:
    push bc
    call ReadByteInBank
    ld a, c
    ld [hli], a
    pop bc
    inc de
    dec c
    jr nz, .loop
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a

.check_debug_cursor:
    ld hl, wDebugSubState
    inc [hl]
    ld a, [wDebugCursor]
    or a
    jr nz, .read_debug_value0
    ld a, [wDebugSubState]
    bit 3, a
    jr z, .read_debug_value0
    xor a
    ld hl, vBGMap0 + $ab
    call WriteVRAMByteInc
    call WriteVRAMByteInc
    call WriteVRAMByteInc
    jr .check_debug_cursor2

.read_debug_value0:
    ld a, [wDebugValue0]
    ld c, a
    ld a, [wDebugValue1]
    ld b, a
    ld de, vBGMap0 + $ab
    call WriteThreeHexDigitsAtDE

.check_debug_cursor2:
    ld a, [wDebugCursor]
    or a
    jr z, .read_debug_value2
    ld a, [wDebugSubState]
    bit 3, a
    jr z, .read_debug_value2
    xor a
    ld hl, vBGMap0 + $cb
    call WriteVRAMByteInc
    call WriteVRAMByteInc
    call WriteVRAMByteInc
    jr .set_sprite_attr_xor_to_00

.read_debug_value2:
    ld a, [wDebugValue2]
    ld c, a
    ld a, [wDebugValue3]
    ld b, a
    ld de, vBGMap0 + $cb
    call WriteThreeHexDigitsAtDE

.set_sprite_attr_xor_to_00:
    ld a, $00
    ldh [hSpriteAttrXor], a
    ld a, [wDebugState]
    cp $03
    jr nz, .read_frame_counter_lo
    ld a, $20
    ldh [hSpriteAttrXor], a
    ld a, $01

.read_frame_counter_lo:
    sla a
    ld c, a
    ld a, [wFrameCounterLo]
    swap a
    and $01
    add c
    ldh [hSpriteSubIndex], a
    ld a, $20
    ldh [hSpriteTileOffset], a
    ldh a, [hScrollX]
    ld c, a
    ldh a, [hScrollXHi]
    ld b, a
    ld a, c
    add $70
    ld c, a
    ld a, b
    adc $00
    ld b, a
    ld a, c
    ldh [hSpriteOriginX], a
    ld a, b
    ldh [hSpriteOriginXHi], a
    ldh a, [hScrollY]
    ld c, a
    ldh a, [hScrollYHi]
    ld b, a
    ld a, c
    add $60
    ld c, a
    ld a, b
    adc $00
    ld b, a
    ld a, c
    ldh [hSpriteOriginY], a
    ld a, b
    ldh [hSpriteOriginYHi], a
    ld a, [wDebugValue2]
    and $7f
    ldh [hSpriteSetIndex], a
    ld a, [wDebugValue3]
    or a
    jr nz, .call_draw_meta_sprite_set_bank27
    ld a, [wDebugValue2]
    bit 7, a
    jr nz, .call_draw_meta_sprite_set_bank26
    farcall DrawMetaSpriteSet_Bank25
    ret

.call_draw_meta_sprite_set_bank26:
    farcall DrawMetaSpriteSet_Bank26
    ret

.call_draw_meta_sprite_set_bank27:
    farcall DrawMetaSpriteSet_Bank27
    ret

; update for debug-mode state 5: the screen shows '? SOUND ?' (BGM, SE) (E-0041)
DebugSoundTest_Update::
    ld a, [wJoypadPressed]
    and $08
    jr z, .check_joypad_pressed_repeat
    ld a, [wMenuState]
    or a
    jr nz, .read_temp1
    call InitSoundHardware
    ld a, [wTemp0]
    ld hl, DebugSoundTestMusic
    add_a_to_hl
    ld a, [hl]
    call QueueMusic
    ret

.read_temp1:
    ld a, [wTemp1]
    ld hl, DebugSoundTestEffects
    add_a_to_hl
    ld a, [hl]
    call QueueSoundEffect
    ret

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and $c0
    jr z, .read_menu_state2
    ld a, [wMenuState]
    or a
    jr nz, .call_debug_sound_test_update_write_hex_byte
    call DebugSoundTest_Update_WriteHexByteTilesAtDE
    jr .read_menu_state

.call_debug_sound_test_update_write_hex_byte:
    call DebugSoundTest_Update_WriteHexByteTilesAtDE_Sub02

.read_menu_state:
    ld a, [wMenuState]
    xor $01
    ld [wMenuState], a
    ld a, $69
    call QueueSoundEffect

.read_menu_state2:
    ld a, [wMenuState]
    ld c, a
    ld b, $00
    ld hl, wTemp0
    add hl, bc
    ld a, [wJoypadPressedRepeat]
    and $10
    jr z, .check_joypad_pressed_repeat2
    inc [hl]
    jr .call_queue_sound_effect

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    and $20
    jr z, .check_joypad_pressed
    dec [hl]
    jr .call_queue_sound_effect

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $01
    jr z, .check_joypad_pressed2
    xor a
    ld [hl], a

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuState]
    ld b, $20
    cp $00
    call z, DebugSoundTest_Update_ReadMenuStateAndTemp0Etc
    ld b, $54
    cp $01
    call z, DebugSoundTest_Update_ReadMenuStateAndTemp0Etc

.check_joypad_pressed2:
    ld a, [wJoypadPressed]
    and $02
    jr z, .check_menu_state
    xor a
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.check_menu_state:
    ld a, [wMenuState]
    or a
    jr nz, DebugSoundTest_Update_WriteHexByteTilesAtDE_CheckFrameCounterLo
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, DebugSoundTest_Update_WriteHexByteTilesAtDE
    xor a
    ld hl, vBGMap0 + $e9
    call WriteVRAMByteInc
    call WriteVRAMByte
    jr DebugSoundTest_Update_WriteHexByteTilesAtDE_Sub02_Return

DebugSoundTest_Update_WriteHexByteTilesAtDE::
    ld a, [wTemp0]
    ld de, vBGMap0 + $e9
    call WriteHexByteTilesAtDE
    jr DebugSoundTest_Update_WriteHexByteTilesAtDE_Sub02_Return

DebugSoundTest_Update_WriteHexByteTilesAtDE_CheckFrameCounterLo::
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, DebugSoundTest_Update_WriteHexByteTilesAtDE_Sub02
    xor a
    ld hl, vBGMap0 + $109
    call WriteVRAMByteInc
    call WriteVRAMByte
    jr DebugSoundTest_Update_WriteHexByteTilesAtDE_Sub02_Return

DebugSoundTest_Update_WriteHexByteTilesAtDE_Sub02::
    ld a, [wTemp1]
    ld de, vBGMap0 + $109
    call WriteHexByteTilesAtDE

DebugSoundTest_Update_WriteHexByteTilesAtDE_Sub02_Return::
    ret

DebugSoundTest_Update_ReadMenuStateAndTemp0Etc::
    push af
    ld a, [wMenuState]
    ld hl, wTemp0
    add_a_to_hl
    ld a, [hl]
    cp b
    jr nz, .skip
    ld [hl], $00

.skip:
    ld a, [hl]
    cp $ff
    jr nz, .check_menu_state
    dec b
    ld [hl], b

.check_menu_state:
    ld a, [wMenuState]
    or a
    jr nz, .read_temp1
    ld hl, DebugSoundTestMusic
    ld de, vBGMap0 + $ec
    ld a, [wTemp0]
    jr .call_write_hex_byte_tiles_at_de

.read_temp1:
    ld hl, DebugSoundTestEffects
    ld de, vBGMap0 + $10c
    ld a, [wTemp1]

.call_write_hex_byte_tiles_at_de:
    add_a_to_hl
    ld a, [hl]
    call WriteHexByteTilesAtDE
    pop af
    ret

; DebugSoundTest_Update passes the byte at $65DE + wTemp0 to QueueMusic after InitSoundHardware, and
; DebugSoundTest_Update_Sub03 draws it in hex; 32 entries (E-0238, C1)
; record: music number
DebugSoundTestMusic::
    db $02 ; id 0
    db $06 ; id 1
    db $09 ; id 2
    db $0c ; id 3
    db $0f ; id 4
    db $13 ; id 5
    db $16 ; id 6
    db $19 ; id 7
    db $1c ; id 8
    db $1f ; id 9
    db $22 ; id 10
    db $25 ; id 11
    db $28 ; id 12
    db $2b ; id 13
    db $2e ; id 14
    db $31 ; id 15
    db $35 ; id 16
    db $3d ; id 17
    db $40 ; id 18
    db $42 ; id 19
    db $44 ; id 20
    db $46 ; id 21
    db $48 ; id 22
    db $4a ; id 23
    db $4d ; id 24
    db $50 ; id 25
    db $52 ; id 26
    db $54 ; id 27
    db $58 ; id 28
    db $cc ; id 29
    db $cf ; id 30
    db $d6 ; id 31

; DebugSoundTest_Update passes the byte at $65FE + wTemp1 to QueueSoundEffect, and the code at
; DebugSoundTest_Update_ReadMenuStateAndTemp0Etc.read_temp1 draws it in hex at vBGMap0 + $10C; 84
; entries up to the next routine (E-0238, C1)
; record: sound effect number
DebugSoundTestEffects::
    db $00 ; id 0
    db $60 ; id 1
    db $61 ; id 2
    db $62 ; id 3
    db $63 ; id 4
    db $65 ; id 5
    db $66 ; id 6
    db $67 ; id 7
    db $69 ; id 8
    db $6a ; id 9
    db $6b ; id 10
    db $6c ; id 11
    db $6d ; id 12
    db $70 ; id 13
    db $72 ; id 14
    db $74 ; id 15
    db $76 ; id 16
    db $78 ; id 17
    db $7a ; id 18
    db $7b ; id 19
    db $7c ; id 20
    db $7d ; id 21
    db $7e ; id 22
    db $80 ; id 23
    db $81 ; id 24
    db $82 ; id 25
    db $83 ; id 26
    db $84 ; id 27
    db $85 ; id 28
    db $86 ; id 29
    db $87 ; id 30
    db $88 ; id 31
    db $89 ; id 32
    db $8b ; id 33
    db $8d ; id 34
    db $8f ; id 35
    db $90 ; id 36
    db $91 ; id 37
    db $93 ; id 38
    db $94 ; id 39
    db $95 ; id 40
    db $96 ; id 41
    db $97 ; id 42
    db $98 ; id 43
    db $99 ; id 44
    db $9a ; id 45
    db $9b ; id 46
    db $9d ; id 47
    db $9e ; id 48
    db $9f ; id 49
    db $a1 ; id 50
    db $a2 ; id 51
    db $a3 ; id 52
    db $a4 ; id 53
    db $a5 ; id 54
    db $a7 ; id 55
    db $a8 ; id 56
    db $a9 ; id 57
    db $aa ; id 58
    db $ab ; id 59
    db $ac ; id 60
    db $ae ; id 61
    db $b0 ; id 62
    db $b1 ; id 63
    db $b2 ; id 64
    db $b4 ; id 65
    db $b6 ; id 66
    db $b8 ; id 67
    db $ba ; id 68
    db $bc ; id 69
    db $bd ; id 70
    db $bf ; id 71
    db $c1 ; id 72
    db $c3 ; id 73
    db $c5 ; id 74
    db $c7 ; id 75
    db $c9 ; id 76
    db $cb ; id 77
    db $d2 ; id 78
    db $d4 ; id 79
    db $d9 ; id 80
    db $da ; id 81
    db $dc ; id 82
    db $dd ; id 83

; update for debug-mode state 6: the screen shows '? BATTLE ?' (number of foes, three monsters,
; skill, levels) (E-0041)
DebugBattleSetup_Update::
    ld a, [wJoypadPressed]
    and $08
    jp z, DebugBattleSetupLoadWords_CheckJoypadPressed
    ld a, [wWorkBuf]
    ld [wEncounterKind], a
    ld a, [wWorkBuf + $8]
    sra a
    ld [wBattleKind], a
    or a
    jr nz, DebugBattleSetupLoadWords_SetEncounterMonsters
    ld hl, wEncounterMonsters
    ld de, wWorkBuf + $2
    call DebugBattleSetupLoadWords
    call DebugBattleSetupLoadWords
    call DebugBattleSetupLoadWords

DebugBattleSetup_Update_ClearMenuState::
    xor a
    ld [wMenuState], a
    xor a
    ld [wDebugCursor], a
    ld [wDebugValue0], a
    ld [wDebugValue1], a
    ld a, [wWorkBuf + $8]
    or a
    jr nz, .call_debug_battle_setup_update_write_map_id
    call DebugBattleSetup_Update_Sub01_SRAMRecordAddressMapped_Sub01
    jr .set_game_mode_to_04

.call_debug_battle_setup_update_write_map_id:
    call DebugBattleSetup_Update_WriteMapIdAndMapScreenXEtc

.set_game_mode_to_04:
    ld a, $04
    ld [wGameMode], a
    xor a
    ld [wModeState], a
    ld a, $04
    call StartPaletteFade
    ld hl, wModeChangeRequest
    inc [hl]
    ld hl, wBGFillFlag
    inc [hl]
    ret

; debug battle setup: copies a word from DE to HL (a zero word becomes 1); the following entries
; load the setup into wEncounterMonsters-wWildByteE5 and handle input (E-0131)
DebugBattleSetupLoadWords::
    ld a, [de]
    inc de
    ld [hli], a
    ld c, a
    ld a, [de]
    inc de
    ld [hli], a
    or c
    ret nz
    dec hl
    dec hl
    ld [hl], $01
    inc hl
    inc hl
    ret

DebugBattleSetupLoadWords_SetEncounterMonsters::
    ld hl, wWorkBuf + $c
    ld a, [hli]
    ld [wEncounterMonsters], a
    ld a, [hli]
    ld [wEncounterMonsters + $1], a
    ld a, [hli]
    ld [wWildLevel], a
    inc hl
    ld a, [hli]
    ld [wEncounterMonsters + $2], a
    ld a, [hli]
    ld [wEncounterMonsters + $3], a
    ld a, [hli]
    ld [wWildBand], a
    inc hl
    ld a, [hli]
    ld [wEncounterMonsters + $4], a
    ld a, [hli]
    ld [wEncounterMonsters + $5], a
    ld a, [hli]
    ld [wWildByteE5], a
    jr DebugBattleSetup_Update_ClearMenuState

DebugBattleSetupLoadWords_CheckJoypadPressed::
    ld a, [wJoypadPressed]
    and $01
    jr z, .check_joypad_pressed
    ld a, [wMenuState]
    add a
    ld hl, wWorkBuf
    add_a_to_hl
    xor a
    ld [hli], a
    ld [hl], a
    jp .clear_frame_counter_lo

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and $02
    jr z, .check_joypad_pressed_repeat
    ld a, [wWorkBuf]
    ld [wEncounterKind], a
    ld hl, wEncounterMonsters
    ld de, wWorkBuf + $2
    call DebugBattleSetupLoadWords
    call DebugBattleSetupLoadWords
    call DebugBattleSetupLoadWords
    xor a
    ld [wDebugCursor], a
    ld [wDebugValue0], a
    ld [wDebugValue1], a
    xor a
    ld [wMenuState], a
    xor a
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr z, .check_bit7
    call DrawDebugValueHexForMenuState
    ld a, [wMenuState]
    dec a
    cp $ff
    jr nz, .set_menu_state
    ld a, $0b

.set_menu_state:
    ld [wMenuState], a
    jp .clear_frame_counter_lo

.check_bit7:
    bit 7, a
    jr z, .skip
    call DrawDebugValueHexForMenuState
    ld a, [wMenuState]
    inc a
    cp $0c
    jr nz, .set_menu_state2
    xor a

.set_menu_state2:
    ld [wMenuState], a
    jp .clear_frame_counter_lo

.skip:
    and $30
    jr z, .read_menu_state
    ld a, [wMenuState]
    add a
    ld hl, wWorkBuf
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    dec hl
    ld a, [wJoypadPressedRepeat]
    bit 4, a
    jr z, .check_joypad_held
    ld a, [wJoypadHeld]
    bit 2, a
    jr z, .call_subtract_de_from_debug_limit
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    inc de
    call ClampDebugValueToTableLimit
    jr .call_draw_debug_value_hex_for_menu_state

.call_subtract_de_from_debug_limit:
    inc de
    call SubtractDEFromDebugLimit

.call_draw_debug_value_hex_for_menu_state:
    call DrawDebugValueHexForMenuState
    jr .clear_frame_counter_lo

.check_joypad_held:
    ld a, [wJoypadHeld]
    bit 2, a
    jr z, .call_subtract_de_from_debug_limit2
    dec de
    dec de
    dec de
    dec de
    dec de
    dec de
    dec de
    dec de
    dec de
    dec de
    dec de
    dec de
    dec de
    dec de
    dec de
    dec de
    call ClampDebugValueToTableLimit
    jr .call_draw_debug_value_hex_for_menu_state2

.call_subtract_de_from_debug_limit2:
    dec de
    call SubtractDEFromDebugLimit

.call_draw_debug_value_hex_for_menu_state2:
    call DrawDebugValueHexForMenuState
    jr .clear_frame_counter_lo

.read_menu_state:
    ld a, [wMenuState]
    ld hl, DebugBattleSetupLoadWords_Data
    add a
    add_a_to_hl
    deref_hl
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, .read_menu_state2
    xor a
    call WriteVRAMByteInc
    call WriteVRAMByteInc
    call WriteVRAMByte
    jr .return

.read_menu_state2:
    push hl
    ld a, [wMenuState]
    add a
    ld hl, wWorkBuf
    add_a_to_hl
    ld c, [hl]
    inc hl
    ld b, [hl]
    pop de
    call WriteThreeHexDigitsAtDE
    jr .return

.clear_frame_counter_lo:
    xor a
    ld [wFrameCounterLo], a
    call DebugBattleSetupShowFieldString

.return:
    ret

; writes the word wWorkBuf[wMenuState] as three hex digits at the address
; DebugBattleSetupLoadWords_Data[wMenuState] (E-0122)
DrawDebugValueHexForMenuState::
    ld a, [wMenuState]
    ld hl, DebugBattleSetupLoadWords_Data
    add a
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld a, [wMenuState]
    ld hl, wWorkBuf
    add a
    add_a_to_hl
    ld a, [hli]
    ld b, [hl]
    ld c, a
    call WriteThreeHexDigitsAtDE
    ret

; stores SubtractDEFromDebugLimit_Data[wMenuState] - DE at HL (floored at 0; DE = $FFFF stores the
; limit) (E-0125)
SubtractDEFromDebugLimit::
    push hl
    ld a, [wMenuState]
    ld hl, SubtractDEFromDebugLimit_Data
    add a
    add_a_to_hl
    ld a, [hli]
    ld b, [hl]
    ld c, a
    ld a, d
    and e
    cp $ff
    jr z, .skip
    ld a, c
    sub e
    ld c, a
    ld a, b
    sbc d
    ld b, a
    bit 7, b
    jr z, .restore
    xor a
    ld d, a
    ld e, a
    jr .restore

.skip:
    ld d, b
    ld e, c

.restore:
    pop hl
    ld [hl], e
    inc hl
    ld [hl], d
    ret

; clamps the word DE to 0 .. SubtractDEFromDebugLimit_Data[wMenuState] (negative becomes the limit)
; and stores it at HL (E-0124)
ClampDebugValueToTableLimit::
    push hl
    ld a, [wMenuState]
    ld hl, SubtractDEFromDebugLimit_Data
    add a
    add_a_to_hl
    ld a, [hli]
    ld b, [hl]
    ld c, a
    ld h, d
    ld l, e
    inc bc
    call CompareHLToBC
    jr c, .restore
    dec bc
    bit 7, h
    jr nz, .skip
    xor a
    ld d, a
    ld e, a
    jr .restore

.skip:
    ld d, b
    ld e, c

.restore:
    pop hl
    ld [hl], e
    inc hl
    ld [hl], d
    ret

DebugBattleSetup_Update_Sub01_SRAMRecordAddressMapped_Sub01::
    ld a, [wPartyCount]
    or a
    jr z, .call_check_save_data
    cp $04
    jr nc, .call_check_save_data
    ld b, a
    ld hl, wPartyList
    ld a, [wFarmLevel]
    cp $03
    jr nc, .call_check_save_data
    ld c, $0a
    cp $00
    jr z, .loop
    ld c, $14
    cp $01
    jr z, .loop
    ld c, $1e

.loop:
    ld a, [hli]
    cp c
    jr nc, .call_check_save_data
    push bc
    push hl
    call DebugBattleSetup_Update_Sub01_SRAMRecordAddressMapped
    pop hl
    pop bc
    jr nz, .call_check_save_data
    dec b
    jr nz, .loop
    ret

.call_check_save_data:
    farcall CheckSaveData
    ldh a, [hTemp0]
    or a
    jr nz, .call_debug_battle_setup_update_write_map_id
    farcall RunSaveSteps
    ret

.call_debug_battle_setup_update_write_map_id:
    call DebugBattleSetup_Update_WriteMapIdAndMapScreenXEtc
    ret

DebugBattleSetup_Update_Sub01_SRAMRecordAddressMapped::
    ld c, MON_STATE
    call SRAMRecordAddressMapped
    ld a, [hl]
    cp $02
    ret

DebugBattleSetupLoadWords_Data::
    db $87, $98, $a7, $98, $c7, $98, $e7, $98, $07, $99, $27, $99, $47, $99, $67, $99
    db $87, $99, $a7, $99, $c7, $99, $e7, $99

SubtractDEFromDebugLimit_Data::
    db $02, $00, $ab, $02, $ab, $02, $ab, $02, $01, $00, $00, $00, $40, $01, $63, $00
    db $40, $01, $63, $00, $40, $01, $63, $00

; debug battle setup: shows the string for field wMenuState (wWorkBuf entries, ShowString_Bank88) at
; the window from DebugBattleSetupShowFieldString_Data1, with special cases for fields 4-6 (E-0131)
DebugBattleSetupShowFieldString::
    ld a, [wMenuState]
    or a
    ret z
    cp $04
    jr z, .read_work_buf
    cp $05
    jp z, .clear_string_index
    cp $06
    jp nc, .read_menu_state
    ld hl, wWorkBuf
    add a
    add_a_to_hl
    ld a, [hli]
    ld h, [hl]
    ld [wStringIndex], a
    ld a, h
    ld [wStringCategory], a
    ld hl, DebugBattleSetupShowFieldString_Data1
    ld a, [wMenuState]
    dec a
    add a
    add_a_to_hl
    deref_hl
    ld de, $0901
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
    farcall ShowString_Bank88
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

.read_work_buf:
    ld a, [wWorkBuf + $8]
    ld [wStringIndex], a
    ld a, $02
    ld [wStringCategory], a
    ld hl, vTiles2 + $3c0
    ld de, $0901
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
    farcall ShowString_Bank2F
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

.clear_string_index:
    xor a
    ld [wStringIndex], a
    ld a, $04
    ld [wStringCategory], a
    ld hl, vTiles2 + $450
    ld de, $0901

.read_text_window_tile_lo:
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

.read_menu_state:
    ld a, [wMenuState]
    ld hl, wWorkBuf
    add a
    add_a_to_hl
    ld a, [wMenuState]
    cp $07
    jr z, .call_divide_b_by_a
    cp $09
    jr z, .call_divide_b_by_a
    cp $0b
    jr z, .call_divide_b_by_a
    ld a, [hli]
    ld [wStringIndex], a
    ld a, [hl]
    add $02
    ld [wStringCategory], a
    ld a, [wMenuState]
    sub $06
    ld hl, DebugBattleSetupShowFieldString_Data2
    add_a_to_hl
    deref_hl
    ld de, $0901
    jr .read_text_window_tile_lo

.call_divide_b_by_a:
    ld b, [hl]
    ld a, $0a
    call DivideBByA
    ld c, a
    push bc
    ld a, [wMenuState]
    sub $07
    ld hl, DebugBattleSetupShowFieldString_Data3
    add_a_to_hl
    deref_hl
    pop bc
    ld a, b
    add $10
    call WriteVRAMByteInc
    ld a, c
    add $10
    call WriteVRAMByte
    ret

DebugBattleSetupShowFieldString_Data1::
    db $00, $92, $a0, $92, $30, $93

DebugBattleSetupShowFieldString_Data2::
    db $e0, $94, $70, $95, $00, $96

DebugBattleSetupShowFieldString_Data3::
    db $6b, $99, $ab, $99, $eb, $99

; DE = VRAM address: writes A as two hex-digit tiles ($10 + high nibble, then $10 + low nibble),
; each after WaitForVRAMAccess; DE ends on the second tile (E-0071)
WriteHexByteTilesAtDE::
    push af
    swap a
    and $0f
    add $10
    push af
    call WaitForVRAMAccess
    pop af
    ld [de], a
    inc de
    pop af
    and $0f
    add $10
    push af
    call WaitForVRAMAccess
    pop af
    ld [de], a
    ret

; writes the low nibble of B, then both nibbles of C, as tiles $10 + nibble at DE (WaitForVRAMAccess
; each); DE ends on the last tile (E-0120)
WriteThreeHexDigitsAtDE::
    ld a, b
    and $0f
    add $10
    push af
    call WaitForVRAMAccess
    pop af
    ld [de], a
    inc de
    ld a, c
    swap a
    and $0f
    add $10
    push af
    call WaitForVRAMAccess
    pop af
    ld [de], a
    inc de
    ld a, c
    and $0f
    add $10
    push af
    call WaitForVRAMAccess
    pop af
    ld [de], a
    ret

DebugBattleSetup_Update_WriteMapIdAndMapScreenXEtc::
    ld a, $00
    ldh [hMapId], a
    ld a, $02
    ldh [hMapScreenX], a
    ld a, $00
    ldh [hMapScreenY], a
    ld a, $40
    ldh [hPlayerX], a
    ld a, $40
    ldh [hPlayerY], a
    ld a, $00
    ld [wFollowerRecords], a
    ld a, $40
    ld [wFollowerRecords + $1], a
    ld a, $40
    ld [wFollowerRecords + $2], a
    ld a, $00
    ld [wFollowerRecords + $5], a
    ld a, $40
    ld [wFollowerRecords + $6], a
    ld a, $40
    ld [wFollowerRecords + $7], a
    ld a, $00
    ld [wFollowerRecords + $a], a
    ld a, $40
    ld [wFollowerRecords + $b], a
    ld a, $40
    ld [wFollowerRecords + $c], a
    ld a, $24
    ld [wPlayerName], a
    ld a, $35
    ld [wPlayerName + $1], a
    ld a, $8d
    ld [wPlayerName + $2], a
    ld a, $2f
    ld [wPlayerName + $3], a
    ld a, $2b
    ld [wPlayerName + $4], a
    ld a, $55
    ld [wPlayerName + $5], a
    ld a, $f0
    ld [wPlayerName + $6], a
    ld a, $f0
    ld [wPlayerName + $7], a
    ld a, $f0
    ld [wPlayerName + $8], a
    ld a, $f0
    ld [wPlayerName + $9], a
    ld a, $9f
    ld [wGoldLo], a
    ld a, $86
    ld [wGoldMid], a
    ld a, $01
    ld [wGoldHi], a
    ld a, $03
    ld [wPartyCount], a
    ld a, $00
    ld [wPartyList], a
    ld a, $01
    ld [wPartyList + $1], a
    ld a, $02
    ld [wPartyList + $2], a
    ld a, $01
    ld [wInventory], a
    ld a, $02
    ld [wInventory + $1], a
    ld a, $03
    ld [wInventory + $2], a
    ld a, $04
    ld [wInventory + $3], a
    ld a, $05
    ld [wInventory + $4], a
    ld a, $06
    ld [wInventory + $5], a
    ld a, $01
    ld [wInventory + $6], a
    ld a, $1f
    ld [wInventory + $7], a
    ld a, $09
    ld [wInventory + $8], a
    ld a, $33
    ld [wInventory + $9], a
    ld a, $0b
    ld [wEventItemSlot], a
    ld a, $20
    ld [wInventory + $b], a
    ld a, $28
    ld [wInventory + $c], a
    ld a, $0e
    ld [wInventory + $d], a
    ld a, $0f
    ld [wInventory + $e], a
    ld a, $10
    ld [wInventory + $f], a
    ld a, $11
    ld [wInventory + $10], a
    ld a, $12
    ld [wInventory + $11], a
    ld a, $1c
    ld [wInventory + $12], a
    ld a, $1c
    ld [wInventory + $13], a
    ld a, $1c
    ld [wInventory + $14], a
    ld a, $0c
    ld [wInventory + $15], a
    ld a, $0c
    ld [wInventory + $16], a
    ld a, $0c
    ld [wInventory + $17], a
    ld a, $50
    ld [wTinyMedalsLo], a
    xor a
    ld [wTinyMedalsHi], a
    call DebugBattleSetup_ClearKeyList
    call DebugBattleSetup_Update_Shared01_PickRandomMonsterSkipping7ETo82
    ret

DebugBattleSetup_Update_Shared01_PickRandomMonsterSkipping7ETo82::
    ld b, $1e
    xor a
    ld [wBattleArg0], a

.loop:
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    push bc
    call PickRandomMonsterSkipping7ETo82
    pop bc
    xor a
    ld [rRAMG], a
    ld hl, wBattleArg0
    inc [hl]
    dec b
    jr nz, .loop
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ld hl, sRecords
    ld de, $00a5
    ld [hl], $02
    add hl, de
    ld [hl], $02
    add hl, de
    ld [hl], $02
    ld b, $1b

.loop2:
    add hl, de
    ld [hl], $01
    dec b
    jr nz, .loop2
    xor a
    ld [rRAMG], a
    ret

; draws random ids until one is non-zero and not $7E-$82, then creates that record
; (PickRandomMonsterSkipping7ETo82_WriteBattleArg1AndBattleArg2Etc) (E-0124)
PickRandomMonsterSkipping7ETo82::
    call NextTableByte
    ld a, [wRandomLo]
    ld e, a
    ld a, [wRandomHi]
    or e
    ld e, a
    or a
    jr z, PickRandomMonsterSkipping7ETo82
    cp $7e
    jr z, PickRandomMonsterSkipping7ETo82
    cp $7f
    jr z, PickRandomMonsterSkipping7ETo82
    cp $80
    jr z, PickRandomMonsterSkipping7ETo82
    cp $81
    jr z, PickRandomMonsterSkipping7ETo82
    cp $82
    jr z, PickRandomMonsterSkipping7ETo82
    ld d, $00
    call PickRandomMonsterSkipping7ETo82_WriteBattleArg1AndBattleArg2Etc
    ret

CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord::
    ldh a, [hTemp3]
    push af
    ld a, e
    ld [wMonsterId], a
    ld a, d
    ld [wMonsterId + $1], a
    farcall LoadMonsterRecord
    ld a, [wBattleArg0]
    ld c, MON_STATE
    call SRAMRecordAddress
    pop af
    ld [hl], a
    ld a, l
    add $0b
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wRecordBuffer]
    ld [hli], a
    ld a, [wRecordBuffer + $1]
    ld [hli], a
    inc hl
    ld a, [wBattleArg1]
    cp $ff
    jr nz, .skip
    ld a, [wRandomHi]
    and $01
    jr .skip2

.skip:
    push hl
    ld hl, CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data1
    add_a_to_hl
    ld a, [hl]
    pop hl

.skip2:
    ld [hli], a
    ld de, wPlayerName
    ld b, $0b
    call CopyBBytesDEToHL_Bank01
    ld a, $ff
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    call WriteUnknownNamePlaceholder_Bank01
    call WriteUnknownNamePlaceholder_Bank01
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
    ld [wRecordBufA + MON_LEVEL], a
    ld a, l
    add $04
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wRecordBufferData + $8]
    ld e, a
    ld a, [wRecordBufferData + $9]
    ld d, a
    ld a, d
    cp $04
    jr c, .skip3
    ld de, $03e7

.skip3:
    ld a, e
    ld [hli], a
    ld a, d
    ld [hli], a
    ld a, e
    ld [hli], a
    ld a, d
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
    ld a, [wBattleArg2]
    or a
    jr z, .skip4
    push hl
    call NextTableByte
    pop hl
    ld a, [wRandomLo]
    ld [hli], a
    ld a, [wRandomHi]
    and $01
    ld [hli], a
    jr .skip5

.skip4:
    xor a
    ld [hli], a
    ld [hli], a

.skip5:
    xor a
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
    ld a, [wBattleArg0]
    ld c, MON_FAMILY
    call SRAMRecordAddress
    ld a, [wSpeciesRecord]
    ld [hl], a
    ld a, a
    ld [wWorkBuf], a
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
    call FillBBytesAtHL_Bank01
    ld a, l
    add $02
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, [wSpeciesRecord + SPECIES_MAX_LEVEL]
    ld [hl], a
    ld a, l
    add $1c
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld de, wSpeciesRecord + SPECIES_RESISTANCES
    ld b, $1b
    call CopyBBytesDEToHL_Bank01
    call WriteUnknownNamePlaceholder_Bank01
    call WriteUnknownNamePlaceholder_Bank01
    ld [hl], $00
    ld a, [wBattleArg1]
    cp $ff
    jr nz, .skip6
    call NextTableByte
    ld a, [wRandomLo]
    ld b, a
    ld a, $0e
    call DivideBByA
    ld [wWorkBuf + $1], a
    ld a, [wBattleArg0]
    ld c, MON_NAME
    call SRAMRecordAddress
    ld a, l
    ld [wWorkBuf + $2], a
    ld a, h
    ld [wWorkBuf + $3], a
    farcall CreateMonsterRecordOfKindTemp1_Sub01_Sub01_ReadWorkBuf
    jr .read_species_id_lo

.skip6:
    push hl
    ld hl, CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data2
    add a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld a, l
    sub $a3
    ld l, a
    ld a, h
    sbc $00
    ld h, a
    ld b, $0a
    call CopyBBytesDEToHL_Bank01

.read_species_id_lo:
    ld a, [wSpeciesIdLo]
    ld l, a
    ld a, [wSpeciesIdHi]
    ld h, a
    ld a, l
    ld [wRecordBufA + MON_SPECIES], a
    ld a, h
    ld [wRecordBufA + MON_SPECIES + 1], a
    farcall LoadTable4E60EntryForRecordBufASpeciesToRecordBufAExp
    ld a, [wBattleArg0]
    ld c, MON_EXP
    call SRAMRecordAddress
    ld a, [wRecordBufA + MON_EXP]
    ld [hli], a
    ld a, [wRecordBufA + MON_EXP + 1]
    ld [hli], a
    ld a, [wRecordBufA + MON_EXP + 2]
    ld [hli], a
    farcall SetSpeciesFlag
    ret

; DE = source, HL = destination, B = count: copies B bytes (B = 0 copies 256); DE and HL end past
; the copy; clobbers A, B = 0 (E-0064) (the same 7 bytes appear in 4 banks)
CopyBBytesDEToHL_Bank01::
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, CopyBBytesDEToHL_Bank01
    ret

; stores A in B bytes from HL (B = 0 fills 256); HL ends past the fill, B = 0 (E-0065) (the same 5
; bytes appear in 2 banks)
FillBBytesAtHL_Bank01::
    ld [hli], a
    dec b
    jr nz, FillBBytesAtHL_Bank01
    ret

; writes '???' ($98 x 3), seven $F0 bytes and a 0 at HL (E-0122)
WriteUnknownNamePlaceholder_Bank01::
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
    ld a, $00
    ld [hli], a
    ret

; with SRAM enabled creates a record from the template CreateMonsterRecordOfKindTemp1_Data[hTemp1]
; (wBattleArg1 = hTemp1, level hTemp2); kinds 1 and 2 also set field $6E = 1 (E-0124)
CreateMonsterRecordOfKindTemp1::
    ld a, $0a
    ld [rRAMG], a
    xor a
    ld [rRAMB], a
    ldh a, [hTemp1]
    ld [wBattleArg1], a
    ld hl, CreateMonsterRecordOfKindTemp1_Data
    add a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    xor a
    ld [wBattleArg2], a
    ldh a, [hTemp2]
    call CreateMonsterRecordOfKindTemp1_WriteBattleArg0
    ldh a, [hTemp1]
    cp $01
    jr z, .read_battle_arg0
    cp $02
    jr nz, .done

.read_battle_arg0:
    ld a, [wBattleArg0]
    ld c, MON_EGG
    call SRAMRecordAddress
    ld [hl], $01

.done:
    xor a
    ld [rRAMG], a
    ret

PickRandomMonsterSkipping7ETo82_WriteBattleArg1AndBattleArg2Etc::
    ld a, $ff
    ld [wBattleArg1], a
    ld [wBattleArg2], a
    ld a, $01
    ldh [hTemp3], a
    ld a, [wBattleArg0]

CreateMonsterRecordOfKindTemp1_WriteBattleArg0::
    ld [wBattleArg0], a
    call CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord
    ret

; copies 128 bytes (32 four-byte entries) from its table into wKeyList; the table is all $FF in this
; ROM, so the debug battle set-up empties the key list (E-0334: wKeyList reads $FF throughout after
; it) (was DebugBattleSetup_Update_FillKeyListFromTable)
DebugBattleSetup_ClearKeyList::
    ld de, DebugBattleSetup_ClearKeyList_Data
    ld hl, wKeyList
    ld b, $20

.loop:
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
    dec b
    jr nz, .loop
    ret

DebugBattleSetup_ClearKeyList_Data::
    ds $80, $ff

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 20 x 18 tiles, one row per line
TileRect_01_6F30::
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 1
    db $00, $11, $12, $13, $35, $0e, $00, $00, $00, $00, $a0, $a1, $a2, $a3, $a4, $a5, $a6, $a7, $a8, $00 ; id 2
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 3
    db $00, $14, $15, $16, $17, $18, $19, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 4
    db $00, $1a, $1b, $1c, $1d, $14, $1e, $1f, $20, $15, $12, $00, $00, $00, $80, $81, $82, $83, $84, $00 ; id 5
    db $00, $14, $1e, $1f, $20, $15, $12, $21, $22, $23, $00, $00, $00, $00, $00, $85, $86, $87, $88, $00 ; id 6
    db $00, $14, $24, $16, $1a, $25, $00, $00, $00, $00, $00, $00, $00, $00, $00, $89, $8a, $8b, $8c, $00 ; id 7
    db $00, $33, $29, $34, $29, $28, $1d, $29, $00, $00, $00, $8d, $8e, $8f, $90, $91, $92, $93, $94, $00 ; id 8
    db $00, $26, $16, $27, $28, $1d, $29, $00, $00, $00, $00, $95, $96, $97, $98, $99, $9a, $9b, $9c, $00 ; id 9
    db $00, $2a, $2b, $2c, $36, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 10
    db $00, $2a, $2b, $2c, $36, $03, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 11
    db $00, $2a, $2b, $2c, $36, $04, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 12
    db $00, $2a, $2b, $2c, $36, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 13
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $31, $29, $14, $15, $16, $00, $31, $29, $32, $29, $00 ; id 14
    db $00, $2d, $27, $2e, $1a, $30, $26, $16, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 15
    db $00, $2f, $25, $1a, $30, $26, $16, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 16
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 17

CreateMonsterRecordOfKindTemp1_Data::
    db $83, $01, $63, $02, $64, $02, $58, $02, $59, $02, $1b, $00, $7a, $02, $79, $02
    db $78, $02

CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data1::
    db $00, $00, $01, $00, $00, $00, $01, $00, $00

CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data2::
    dw CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data2_Entry00
    dw CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data2_Entry01
    dw CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data2_Entry02
    dw CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data2_Entry03
    dw CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data2_Entry04
    dw CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data2_Entry05
    dw CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data2_Entry06
    dw CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data2_Entry07
    dw CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data2_Entry08

CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data2_Entry00::
    db $0b, $2c, $2c, $31, $32, $f0, $f0, $f0, $f0, $f0

CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data2_Entry01::
    db $0e, $2a, $2a, $f0, $f0, $f0, $f0, $f0, $f0, $f0

CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data2_Entry02::
    db $0e, $2a, $2a, $f0, $f0, $f0, $f0, $f0, $f0, $f0

CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data2_Entry03::
    db $20, $24, $35, $38, $0b, $f0, $f0, $f0, $f0, $f0

CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data2_Entry04::
    db $19, $28, $37, $2c, $0b, $f0, $f0, $f0, $f0, $f0

CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data2_Entry05::
    db $1c, $34, $38, $2c, $3d, $f0, $f0, $f0, $f0, $f0

CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data2_Entry06::
    db $15, $24, $30, $2c, $24, $f0, $f0, $f0, $f0, $f0

CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data2_Entry07::
    db $1c, $24, $37, $30, $24, $f0, $f0, $f0, $f0, $f0

CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data2_Entry08::
    db $0b, $35, $24, $25, $32, $f0, $f0, $f0, $f0, $f0
    ds $4a6, $00

DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD_Data3::
    ds $a3b, $00
