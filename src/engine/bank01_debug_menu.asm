; ROM bank $01: debug menu: message test, debug battle set-up, monster creation, results
; The annotated listing of this bank is build/listing/bank01.asm.

SECTION "Bank 01", ROMX
    db $01

; Start-up of game mode 0, the debug menu (far-called by RunGameModeInit_DebugMenu): fills 112 tiles
; at vTiles1 and 112 at vTiles2 with the plain tile of FillTilesRequest (DE = $1007), clears
; wDebugCursor, wDebugValue0 to wDebugValue3, wDebugState, wDebugSubState, wDebugCounter,
; wDebugUnusedA and wDebugUnusedB, and builds the screen picked by wModeState
; (DebugMode_InitByModeState). It then starts a palette fade with A = $FC (StartPaletteFade), sets
; wLCDCShadow = $03 and jumps to ResumeAfterModeChange with A = 1 for SetInterruptEnable.
; GameMode0_Update runs the matching update. (C1, E-0373)
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
    ld [wDebugUnusedA], a
    ld [wDebugUnusedB], a
    call DebugMode_InitByModeState
    ld a, $fc
    call StartPaletteFade
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $01
    jp ResumeAfterModeChange

SECTION "Bank 01 DebugMode_InitByModeState", ROMX

; Builds the debug screen picked by wModeState through its jump table (GameMode0_Update keeps the
; same order for the updates): 0 and 1 DebugMainMenu_Init, 2 DebugMapEditor_Init, 3
; DebugAutomap_Init, 4 DebugMonsterPictureViewer_Init, 5 DebugSoundTest_Init, 6
; DebugBattleSetup_Init, 7 DebugResultsDisplay_Init, 8 DebugStaffRoll_Init, 9 DebugSkillViewer_Init,
; 10 DebugMonsterRecordViewer_Init, 11 DebugMessageTest_Init. States 1-11 follow the items of the
; debug menu text, '1:GOTO PROGRAM' to 'B:MESSAGE CHK' (2 is '2:EDIT', 7 '7:HAIGOU', 9 '9:TOKUGI
; CHECK', 10 'A:ENEMY TBL CHK'). Only caller: GameMode0_Init. (C1, E-0373)
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

; Builds debug screen 11 ('B:MESSAGE CHK' in the debug menu), whose tile map shows 'LIBNO / MESNO':
; loads palette 0 (LoadPalette0FromData), prints string 0/0 '0123456789ABCDEF' into a 16 x 1 tile
; window at vTiles2 + $100 (ShowString_Bank08), then sets the window to vTiles2 + $300 (18 wide, 7
; rows) with wTextCursorLo/Hi at vBGMap0 + $1C1 for the message under test. It copies six tiles from
; bank $1F to vTiles2 + $200-$250, clears the debug work bytes, copies the 20 x 18
; DebugMessageTest_Init_TileRect to vBGMap0 and clears wMenuState, wTemp0, wTemp1 and wMenuRowCount.
; (C1, E-0373)
; init for debug-mode state 11: the screen shows 'LIBNO / MESNO' message test (E-0041)
DebugMessageTest_Init::
    call LoadPalette0FromData
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
    ld de, Tiles2Plus200Tiles
    ld b, BANK(Tiles2Plus200Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $210
    ld de, Tiles2Plus210Tiles
    ld b, BANK(Tiles2Plus210Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $220
    ld de, Tiles1Plus6E0Tiles
    ld b, BANK(Tiles1Plus6E0Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $230
    ld de, Tiles2Plus230Tiles
    ld b, BANK(Tiles2Plus230Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $240
    ld de, Tiles2Plus240Tiles
    ld b, BANK(Tiles2Plus240Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $250
    ld de, Tiles2Plus250Tiles
    ld b, BANK(Tiles2Plus250Tiles)
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
    ld de, DebugMessageTest_Init_TileRect
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

SECTION "Bank 01 DebugMessageTest_Init_TileRect", ROMX

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 20 x 18 tiles, one row per line
DebugMessageTest_Init_TileRect::
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

; Builds debug screen 10 ('A:ENEMY TBL CHK' in the debug menu), the monster record viewer: shows
; string category $0F, index 1 (ShowString_Bank08; that is String_95_06_00, an empty string), copies
; the 20 x 18 DebugMonsterRecordViewer_Init_TileRect from bank $01 to vBGMap0 and draws monster 0
; with DebugShowMonsterRecord (HL = 0). (C1, E-0373)
; init for debug-mode state 10: the screen shows the monster record viewer (E-0041)
DebugMonsterRecordViewer_Init::
    ld a, $0f
    ld [wStringCategory], a
    ld a, $01
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld a, $01
    ld de, DebugMonsterRecordViewer_Init_TileRect
    ld hl, vBGMap0
    lb bc, $14, $12
    call CopyRectFromBankToVRAM
    ld hl, $0000
    call DebugShowMonsterRecord
    ret

SECTION "Bank 01 DebugMonsterRecordViewer_Init_TileRect", ROMX

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 20 x 18 tiles, one row per line
DebugMonsterRecordViewer_Init_TileRect::
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

; Builds debug screen 9 ('9:TOKUGI CHECK' in the debug menu), the skill viewer: shows string $0F/0
; (String_95_06_00, empty), copies the 20 x 18 DebugSkillViewer_Init_TileRect to vBGMap0, and on CGB
; clears the $400 attribute bytes of vBGMap0 in VRAM bank 1. Then wDebugCursor = 0 and wDebugValue0
; = $FF. (C1, E-0373)
; init for debug-mode state 9: the screen shows the skill viewer (E-0041)
DebugSkillViewer_Init::
    ld a, $0f
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld a, $01
    ld de, DebugSkillViewer_Init_TileRect
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

SECTION "Bank 01 DebugStaffRoll_Init", ROMX

; Builds debug screen 8 ('8:STAFF ROLL' in the debug menu), shown as the staff roll ('SCENARIO &
; GAME DESIGNERS' ...): queues music $31 (QueueMusic, wMusicRequest) and clears the 56 bytes at
; wWorkBuf. DebugStaffRoll_Update then far-calls DebugStaffRoll_Update_RunScene, which runs
; DebugStaffRoll_Credits while wWorkBuf is 0. (C2, E-0373)
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

SECTION "Bank 01 DebugResultsDisplay_Init", ROMX

; Builds debug screen 7 ('7:HAIGOU' in the debug menu), titled 'RESULTS DISPLAY' with 'Species' and
; 'Gender': loads palette 0, prints '0123456789ABCDEF' to vTiles2 + $100 and the title string
; (category 0, index $27, ShowBreedingString) to vTiles1, lays tile sequences on vBGMap0
; (FillRectWithTileSequence), puts tiles $FB-$FD in column 1, copies six tiles from bank $1F (one
; ORed with CopyGlyphTilesToVRAM_Data2), fills four 9-tile blocks at vTiles2 + $200, $300, $400 and
; $500 with the plain tile (FillTilesFromRequest) and shows them in four 9-wide rows. It sets wArg1
; = 0, tile $10 at vBGMap0 + $81 and clears the debug work bytes. Its last loop loads HL =
; wScreenState and B = $60 but stores 0 to wScreenState itself 96 times, so only that one byte is
; cleared. (C1, E-0373)
; init for debug-mode state 7: the screen shows 'RESULTS DISPLAY' (species, gender) (E-0041)
DebugResultsDisplay_Init::
    call LoadPalette0FromData
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
    ld [wStringIndex], a
    farcall ShowBreedingString
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
    ld de, Tiles1Plus7E0Tiles
    ld hl, vTiles1 + $7e0
    ld b, BANK(Tiles1Plus7E0Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus7F0Tiles_2
    ld hl, vTiles1 + $7f0
    ld b, BANK(Tiles1Plus7F0Tiles_2)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus7C0Tiles_2
    ld hl, vTiles1 + $7c0
    ld b, BANK(Tiles1Plus7C0Tiles_2)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, CopyGlyphTilesToVRAM_Data2
    ld hl, vTiles1 + $7c0
    ld b, BANK(CopyGlyphTilesToVRAM_Data2)
    ld c, $10
    call OrFromBankWaitVRAM
    ld de, Tiles2Plus200Tiles
    ld hl, vTiles1 + $7d0
    ld b, BANK(Tiles2Plus200Tiles)
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus7B0Tiles
    ld hl, vTiles1 + $7b0
    ld b, BANK(Tiles1Plus7B0Tiles)
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

SECTION "Bank 01 DebugMainMenu_Init", ROMX

; Builds debug screens 0 and 1, the debug menu: loads palette 0, prints string 0/1 ('DEBUG MODE',
; 'SELECT' and the items '1:GOTO PROGRAM' to 'B:MESSAGE CHK') into a 16-wide, 8-row window at
; vTiles1, and lays tile numbers from $80 in a 16 x 2 rectangle at vBGMap0 + $A3
; (FillRectWithTileSequence). (C1, E-0373)
; init for debug-mode state 0: the screen shows the debug menu (E-0041)
DebugMainMenu_Init::
    call LoadPalette0FromData
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

SECTION "Bank 01 DebugMapEditor_Init", ROMX

; Builds debug screen 2 ('2:EDIT'), titled '? EDIT ?' with WORLD, MAP X/Y and POS X/Y: prints
; '0123456789ABCDEF' to vTiles2 + $100 and string 0/2 into a 16 x 8 window at vTiles1, lays tile
; numbers from $80 in a 16 x 7 rectangle at vBGMap0 + $A3 and the 16 tiles of
; DebugMapEditor_Init_TileRect at vBGMap0 + $EA. Then wDebugCursor = 0, wDebugValue0 = hMapId,
; wDebugValue1 = hMapScreenX, wDebugValue2 = hPlayerX, wDebugValue3 = hMapScreenY, wDebugState =
; hPlayerY and wDebugSubState = 1. (C1, E-0373)
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
    ld de, DebugMapEditor_Init_TileRect
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

SECTION "Bank 01 DebugMapEditor_Init_TileRect", ROMX

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 16 x 1 tiles, one row per line
DebugMapEditor_Init_TileRect::
    db $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2a, $2b, $2c, $2d, $2e, $2f ; id 0

; Builds debug screen 3 ('3:AUTOMAP CHECK'), titled '? AUTOMAP ?' with KEY, KEYID, LEVEL and POS
; X/Y: prints '0123456789ABCDEF' to vTiles2 + $100 and string 0/4 into a 16 x 8 window at vTiles1,
; lays tile numbers from $80 in a 16 x 7 rectangle at vBGMap0 + $A3 and DebugAutomap_Init_TileRect
; at vBGMap0 + $EA. Then wDebugCursor = 0, LoadKeyEntryFieldsToDebugState loads the entry of
; wCurrentKeyIndex (wDebugState, wDebugSubState, wDebugValue1), and wDebugValue0 = wCurrentKeyIndex
; | $80, wDebugValue2 = hMapScreenX, wDebugValue3 = hMapScreenY. (C1, E-0373)
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
    ld de, DebugAutomap_Init_TileRect
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

SECTION "Bank 01 DebugAutomap_Init_TileRect", ROMX

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 16 x 1 tiles, one row per line
DebugAutomap_Init_TileRect::
    db $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2a, $2b, $2c, $2d, $2e, $2f ; id 0

; Builds debug screen 4 ('4:GRAFHICS' in the debug menu): prints string 0/0 '0123456789ABCDEF' into
; a 16 x 1 window at vTiles2 + $100 and string 0/3 'MONSTER BGSD CHARA' into a 16-wide, 8-row window
; at vTiles1 (ShowString_Bank08), fills a 16 x 2 block of tiles $80 on at vBGMap0 + $A3
; (FillRectWithTileSequence), copies the 6 x 6 DebugMonsterPictureViewer_Init_TileRect to vBGMap0 +
; $124 and on CGB DebugMonsterPictureViewer_Init_TileRect_2 into VRAM bank 1. It sets wDebugValue0 =
; 0, wDebugValue1 = $80, wDebugValue2 = 0, wDebugValue3 = $80 (picture and sprite number 0, both
; marked for loading by bit 7) and wDebugState = 0. (C1, E-0374)
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
    ld de, DebugMonsterPictureViewer_Init_TileRect
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
    ld de, DebugMonsterPictureViewer_Init_TileRect_2
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

SECTION "Bank 01 DebugMonsterPictureViewer_Init_TileRect", ROMX

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 6 x 6 tiles, one row per line
DebugMonsterPictureViewer_Init_TileRect::
    db $20, $21, $22, $23, $24, $25 ; id 0
    db $26, $27, $28, $29, $2a, $2b ; id 1
    db $2c, $2d, $2e, $2f, $30, $31 ; id 2
    db $32, $33, $34, $35, $36, $37 ; id 3
    db $38, $39, $3a, $3b, $3c, $3d ; id 4
    db $3e, $3f, $40, $41, $42, $43 ; id 5

DebugMonsterPictureViewer_Init_TileRect_2::
    db $01, $01, $01, $01, $01, $01 ; id 0
    db $01, $01, $01, $01, $01, $01 ; id 1
    db $01, $01, $01, $01, $01, $01 ; id 2
    db $01, $01, $01, $01, $01, $01 ; id 3
    db $01, $01, $01, $01, $01, $01 ; id 4
    db $01, $01, $01, $01, $01, $01 ; id 5

; Builds debug screen 5 ('5:SOUNDS' in the debug menu): prints string 0/0 '0123456789ABCDEF' into a
; 16 x 1 window at vTiles2 + $100 and string 0/6 (the same text as 0/5, '? SOUND ?' with 'BGM' and
; 'SE') into a 16-wide, 8-row window at vTiles1, copies the 11 x 4 DebugSoundTest_Init_TileRect to
; vBGMap0 + $A3, and clears wMenuState (the selected line) and wTemp0 and wTemp1 (the music and
; effect numbers). (C1, E-0374)
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
    ld de, DebugSoundTest_Init_TileRect
    ld hl, vBGMap0 + $a3
    lb bc, $0b, $04
    call CopyRectFromBankToVRAM
    xor a
    ld [wMenuState], a
    xor a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

SECTION "Bank 01 DebugSoundTest_Init_TileRect", ROMX

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 11 x 4 tiles, one row per line
DebugSoundTest_Init_TileRect::
    db $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8a ; id 0
    db $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $9a ; id 1
    db $a0, $a1, $a2, $a3, $a4, $a5, $10, $10, $a8, $10, $12 ; id 2
    db $b0, $b1, $b2, $b3, $b4, $b5, $10, $10, $b8, $10, $10 ; id 3

; Builds debug screen 6 ('6:BATTLE' in the debug menu): prints string 0/0 '0123456789ABCDEF' into a
; 16 x 1 window at vTiles2 + $100 and string 0/9 ('? BATTLE ?', 'No. foes', 'Monster 1' to 'Monster
; 3', 'Debug', 'Skill ID', 'Species', 'Level') into an 11-wide, 9-row window at vTiles1, copies the
; 20 x 14 DebugBattleSetup_Init_TileRect to vBGMap0 + $40, clears the 24 bytes of wWorkBuf (the 12
; field words) and draws fields 1-6, 8 and 10 with DebugBattleSetupShowFieldString, leaving
; wMenuState = 0. (C1, E-0374)
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
    ld de, DebugBattleSetup_Init_TileRect
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

SECTION "Bank 01 DebugBattleSetup_Init_TileRect", ROMX

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 20 x 14 tiles, one row per line
DebugBattleSetup_Init_TileRect::
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

; A = first tile, B = width, C = rows, HL = BG map address: writes the consecutive tile numbers A, A
; + 1, ... row by row (rows 32 bytes apart); A ends past the last tile. On CGB it then switches to
; VRAM bank 1, zero-fills the $240 bytes from vBGMap0 (all attributes 0, not only the rectangle) and
; switches back to bank 0. It writes VRAM without waiting, so its callers (the debug screen
; builders) run it while the screen is off. (C1, E-0374)
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

SECTION "Bank 01 LoadPalette0FromData", ROMX

; On CGB copies the 8 bytes of LoadPalette0FromData_Data (palette 0, four colours) to
; wBGPaletteBuffer, sets wBGPaletteUploadRequest = $7F, copies the same 8 bytes to wBGPaletteBuffer
; again and sets wOBJPaletteUploadRequest = $7F, so wOBJPaletteBuffer is not changed by it. Does
; nothing on DMG (wIsCGB = 0). Used by the debug screens and three link/title screens in bank $07.
; (C2, E-0374)
; on CGB copies the 8-byte palette LoadPalette0FromData_Data into wBGPaletteBuffer twice and sets
; wBGPaletteUploadRequest and wOBJPaletteUploadRequest = $7F (E-0117) (E-0344: the address in its
; name dropped or read as the label there; was LoadPalette0FromData)
LoadPalette0FromData::
    ld a, [wIsCGB]
    or a
    ret z
    ld de, LoadPalette0FromData_Data
    ld hl, wBGPaletteBuffer
    ld bc, $0008
    call CopyBytesDEToHL_Bank00
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ld de, LoadPalette0FromData_Data
    ld hl, wBGPaletteBuffer
    ld bc, $0008
    call CopyBytesDEToHL_Bank00
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ret

SECTION "Bank 01 LoadPalette0FromData_Data", ROMX

; Four little-endian RGB555 colours, $5E4D, $7FFF, $66F2 and $0000: one CGB palette of four colours.
; LoadPalette0FromData copies it to wBGPaletteBuffer, sets wBGPaletteUploadRequest to $7F, copies it
; to wBGPaletteBuffer a second time and sets wOBJPaletteUploadRequest to $7F, all only when wIsCGB
; is non-zero. The bank $02 copy of the routine (LoadPalette0FromData_Bank02) sends its second copy
; to wOBJPaletteBuffer instead. (C1, E-0381)
LoadPalette0FromData_Data::
    db $4d, $5e, $ff, $7f, $f2, $66, $00, $00

; The per-frame routine of game mode 0, the debug menu (far-called by RunGameModeUpdate): jumps
; through a 12-entry table by wModeState in the order of DebugMode_InitByModeState: 0 and 1
; DebugMainMenu_Update, 2 DebugMapEditor_Update, 3 DebugAutomap_Update, 4
; DebugMonsterPictureViewer_Update, 5 DebugSoundTest_Update, 6 DebugBattleSetup_Update, 7
; DebugResultsDisplay_Update, 8 DebugStaffRoll_Update, 9 DebugSkillViewer_Update, 10
; DebugMonsterRecordViewer_Update, 11 DebugMessageTest_Update. (C1, E-0374)
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

; Each frame of the message test (debug screen 11, 'B:MESSAGE CHK'): returns while bit 0 of
; wTextFlags is set (a message still printing). Without A pressed it goes to
; DebugMessageTest_Update_HandleInput. With A it sets wStringIndex = wMenuRowCount (the third
; number), wStringCategory = wTemp1 (the second), an 18-wide, 4-row text window at vTiles2 + $300,
; and jumps through a 34-entry table by wTemp0 (the library number) to the step that far-calls the
; BeginStringDisplay of one bank (DebugMessageTest_Update_ShowBank08 for 0,
; DebugMessageTest_Update_ShowBank09 for 1, 1 $09, 2-8 $28-$2E, 9 $7C, ..., 33 $1B). (C1, E-0374)
; update for debug-mode state 11: the screen shows 'LIBNO / MESNO' message test (E-0041)
DebugMessageTest_Update::
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld a, [wJoypadPressed]
    and $01
    jp z, DebugMessageTest_Update_HandleInput
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
    dw DebugMessageTest_Update_ShowBank08
    dw DebugMessageTest_Update_ShowBank09
    dw DebugMessageTest_Update_ShowBank28
    dw DebugMessageTest_Update_ShowBank29
    dw DebugMessageTest_Update_ShowBank2A
    dw DebugMessageTest_Update_ShowBank2B
    dw DebugMessageTest_Update_ShowBank2C
    dw DebugMessageTest_Update_ShowBank2D
    dw DebugMessageTest_Update_ShowBank2E
    dw DebugMessageTest_Update_ShowBank7C
    dw DebugMessageTest_Update_ShowBank80
    dw DebugMessageTest_Update_ShowBank82
    dw DebugMessageTest_Update_ShowBank86
    dw DebugMessageTest_Update_ShowBank89
    dw DebugMessageTest_Update_ShowBank07
    dw DebugMessageTest_Update_ShowBank2F
    dw DebugMessageTest_Update_ShowBank37
    dw DebugMessageTest_Update_ShowBank88
    dw DebugMessageTest_Update_ShowBank83
    dw DebugMessageTest_Update_ShowBank1D
    dw DebugMessageTest_Update_ShowBank8A
    dw DebugMessageTest_Update_ShowBankF0
    dw DebugMessageTest_Update_ShowBank1BSecond
    dw DebugMessageTest_Update_ShowBank1F
    dw DebugMessageTest_Update_ShowBankF0Second
    dw DebugMessageTest_Update_ShowBank0D
    dw DebugMessageTest_Update_ShowBank33
    dw DebugMessageTest_Update_ShowBank24
    dw DebugMessageTest_Update_ShowBank0E
    dw DebugMessageTest_Update_ShowBank0ESecond
    dw DebugMessageTest_Update_ShowBankF2
    dw DebugMessageTest_Update_ShowBank33Second
    dw DebugMessageTest_Update_ShowBank0B
    dw DebugMessageTest_Update_ShowBank1B

; Message test, library 0 ($00): shows the chosen message from the message table of bank $08 by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank08::
    farcall BeginStringDisplay_Bank08
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank09", ROMX

; Message test, library 1 ($01): shows the chosen message from the message table of bank $09 by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank09::
    farcall BeginStringDisplay_Bank09
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank28", ROMX

; Message test, library 2 ($02): shows the chosen message from the message table of bank $28 by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank28::
    farcall BeginStringDisplay_Bank28
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank29", ROMX

; Message test, library 3 ($03): shows the chosen message from the message table of bank $29 by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank29::
    farcall BeginStringDisplay_Bank29
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank2A", ROMX

; Message test, library 4 ($04): shows the chosen message from the message table of bank $2A by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank2A::
    farcall BeginStringDisplay_Bank2A
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank2B", ROMX

; Message test, library 5 ($05): shows the chosen message from the message table of bank $2B by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank2B::
    farcall BeginStringDisplay_Bank2B
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank2C", ROMX

; Message test, library 6 ($06): shows the chosen message from the message table of bank $2C by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank2C::
    farcall BeginStringDisplay_Bank2C
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank2D", ROMX

; Message test, library 7 ($07): shows the chosen message from the message table of bank $2D by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank2D::
    farcall BeginStringDisplay_Bank2D
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank2E", ROMX

; Message test, library 8 ($08): shows the chosen message from the message table of bank $2E by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank2E::
    farcall BeginStringDisplay_Bank2E
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank7C", ROMX

; Message test, library 9 ($09): shows the chosen message from the message table of bank $7C by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank7C::
    farcall BeginStringDisplay_Bank7C
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank80", ROMX

; Message test, library 10 ($0A): shows the chosen message from the message table of bank $80 by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank80::
    farcall BeginStringDisplay_Bank80
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank82", ROMX

; Message test, library 11 ($0B): shows the chosen message from the message table of bank $82 by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank82::
    farcall BeginStringDisplay_Bank82
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank86", ROMX

; Message test, library 12 ($0C): shows the chosen message from the message table of bank $86 by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank86::
    farcall BeginStringDisplay_Bank86
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank89", ROMX

; Message test, library 13 ($0D): shows the chosen message from the message table of bank $89 by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank89::
    farcall BeginStringDisplay_Bank89
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank07", ROMX

; Message test, library 14 ($0E): shows the chosen message from the message table of bank $07 by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank07::
    farcall BeginStringDisplay_Bank07
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank2F", ROMX

; Message test, library 15 ($0F): shows the chosen message from the message table of bank $2F by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank2F::
    farcall BeginStringDisplay_Bank2F
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank37", ROMX

; Message test, library 16 ($10): shows the chosen message from the message table of bank $37 by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank37::
    farcall BeginStringDisplay_Bank37
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank88", ROMX

; Message test, library 17 ($11): shows the chosen message from the message table of bank $88 by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank88::
    farcall BeginStringDisplay_Bank88
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank83", ROMX

; Message test, library 18 ($12): shows the chosen message from the message table of bank $83 by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank83::
    farcall BeginStringDisplay_Bank83
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank1D", ROMX

; Message test, library 19 ($13): shows the chosen message from the message table of bank $1D by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank1D::
    farcall BeginStringDisplay_Bank1D
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank8A", ROMX

; Message test, library 20 ($14): shows the chosen message from the message table of bank $8A by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank8A::
    farcall BeginStringDisplay_Bank8A
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBankF0", ROMX

; Message test, library 21 ($15): shows the chosen message from the message table of bank $F0 by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBankF0::
    farcall BeginStringDisplay_BankF0
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank1BSecond", ROMX

; Message test, library 22 ($16): shows the chosen message from the message table of bank $1B by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank1BSecond::
    farcall BeginBreedingStringDisplay
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank1F", ROMX

; Message test, library 23 ($17): shows the chosen message from the message table of bank $1F by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank1F::
    farcall BeginStringDisplay_Bank1F
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBankF0Second", ROMX

; Message test, library 24 ($18): shows the chosen message from the message table of bank $F0 (a
; second table in that bank) by far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBankF0Second::
    farcall BeginStringDisplay_BankF0_2
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank0D", ROMX

; Message test, library 25 ($19): shows the chosen message from the message table of bank $0D by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank0D::
    farcall BeginStringDisplay_Bank0D
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank33", ROMX

; Message test, library 26 ($1A): shows the chosen message from the message table of bank $33 by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank33::
    farcall BeginStringDisplay_Bank33
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank24", ROMX

; Message test, library 27 ($1B): shows the chosen message from the message table of bank $24 by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank24::
    farcall BeginStringDisplay_Bank24
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank0E", ROMX

; Message test, library 28 ($1C): shows the chosen message from bank $0E's message table
; MessageStrings_Bank0E by far-calling BeginMessageDisplay_Bank0E in bank $0E, which takes indexes
; from $88 on from an overflow table in bank $96. (C1, E-0369)
DebugMessageTest_Update_ShowBank0E::
    farcall BeginMessageDisplay_Bank0E
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank0ESecond", ROMX

; Message test, library 29 ($1D): shows the chosen message from the message table of bank $0E by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank0ESecond::
    farcall BeginStringDisplay_Bank0E
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBankF2", ROMX

; Message test, library 30 ($1E): shows the chosen message from the message table of bank $F2 by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBankF2::
    farcall BeginStringDisplay_BankF2
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank33Second", ROMX

; Message test, library 31 ($1F): shows the chosen message from the message table of bank $33 (a
; second table in that bank) by far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank33Second::
    farcall BeginStringDisplay_Bank33_2
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank0B", ROMX

; Message test, library 32 ($20): shows the chosen message from the message table of bank $0B by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank0B::
    farcall BeginStringDisplay_Bank0B
    ret

SECTION "Bank 01 DebugMessageTest_Update_ShowBank1B", ROMX

; Message test, library 33 ($21): shows the chosen message from the message table of bank $1B by
; far-calling its BeginStringDisplay routine. (C1, E-0357)
DebugMessageTest_Update_ShowBank1B::
    farcall BeginStringDisplay_Bank1B
    ret

SECTION "Bank 01 DebugMessageTest_Update_HandleInput", ROMX

; The message test's input when A is not pressed. Up and Down move between its three numbers
; (wMenuState 0-2: the library at wTemp0, then the two message numbers at wTemp1 and wMenuRowCount,
; each redrawn as two hex digits at BG rows 3, 5 and 7, column 13). Right and Left change the
; selected number (changing the library clears both message numbers, changing the first clears the
; second); Start sets it to 0. Each number wraps at its limit: $21 for the library, otherwise the
; limit from DebugMessageTestTable for that library. B leaves the screen (wModeState = 0 and a mode
; change request). The selected number blinks (8 frames blank, 8 shown). Sound $69 plays on each
; change. (C1, E-0357)
DebugMessageTest_Update_HandleInput::
    ld a, [wJoypadPressedRepeat]
    and $40
    jr z, .check_joypad_pressed_repeat
    ld a, [wMenuState]
    cp $00
    call z, DebugMessageTest_Update_DrawLibrary
    ld a, [wMenuState]
    cp $01
    call z, DebugMessageTest_Update_DrawCategory
    ld a, [wMenuState]
    cp $02
    call z, DebugMessageTest_Update_DrawMessageIndex
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
    call z, DebugMessageTest_Update_DrawLibrary
    ld a, [wMenuState]
    cp $01
    call z, DebugMessageTest_Update_DrawCategory
    ld a, [wMenuState]
    cp $02
    call z, DebugMessageTest_Update_DrawMessageIndex
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
    call DebugMessageTest_ClearDependentNumbers
    jr .call_queue_sound_effect

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    and $20
    jr z, .check_joypad_pressed
    dec [hl]
    call DebugMessageTest_ClearDependentNumbers
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
    call z, DebugMessageTest_WrapNumber
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
    call z, DebugMessageTest_WrapNumber
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
    call z, DebugMessageTest_WrapNumber

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
    jr nz, DebugMessageTest_Update_BlinkCategory
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, DebugMessageTest_Update_DrawLibrary
    xor a
    ld hl, vBGMap0 + $6d
    call WriteVRAMByteInc
    call WriteVRAMByte
    jr DebugMessageTest_Update_DrawUnselectedNumbers

SECTION "Bank 01 DebugMessageTest_Update_DrawLibrary", ROMX

; Redraws the message test's library number (wTemp0) at BG row 3, column 13, then the other two
; numbers. (C1, E-0357)
DebugMessageTest_Update_DrawLibrary::
    ld a, [wTemp0]
    ld de, vBGMap0 + $6d
    call WriteHexByteTilesAtDE
    jr DebugMessageTest_Update_DrawUnselectedNumbers

SECTION "Bank 01 DebugMessageTest_Update_BlinkCategory", ROMX

; Blinks the message test's second number when it is selected: on frames with bit 3 of
; wFrameCounterLo clear it blanks its two digits at BG row 5; otherwise it is drawn. Then redraws
; the unselected numbers. (C1, E-0357)
DebugMessageTest_Update_BlinkCategory::
    ld a, [wMenuState]
    cp $01
    jr nz, DebugMessageTest_Update_BlinkMessageIndex
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, DebugMessageTest_Update_DrawCategory
    xor a
    ld hl, vBGMap0 + $ad
    call WriteVRAMByteInc
    call WriteVRAMByte
    jr DebugMessageTest_Update_DrawUnselectedNumbers

SECTION "Bank 01 DebugMessageTest_Update_DrawCategory", ROMX

; Redraws the message test's second number (wTemp1) at BG row 5, column 13, then the others. (C1,
; E-0357)
DebugMessageTest_Update_DrawCategory::
    ld a, [wTemp1]
    ld de, vBGMap0 + $ad
    call WriteHexByteTilesAtDE
    jr DebugMessageTest_Update_DrawUnselectedNumbers

SECTION "Bank 01 DebugMessageTest_Update_BlinkMessageIndex", ROMX

; Blinks the message test's third number (wMenuRowCount) the same way at BG row 7. (C1, E-0357)
DebugMessageTest_Update_BlinkMessageIndex::
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, DebugMessageTest_Update_DrawMessageIndex
    xor a
    ld hl, vBGMap0 + $ed
    call WriteVRAMByteInc
    call WriteVRAMByte
    jr DebugMessageTest_Update_DrawUnselectedNumbers

SECTION "Bank 01 DebugMessageTest_Update_DrawMessageIndex", ROMX

; Redraws the message test's third number (wMenuRowCount) at BG row 7, column 13, then the others.
; (C1, E-0357)
DebugMessageTest_Update_DrawMessageIndex::
    ld a, [wMenuRowCount]
    ld de, vBGMap0 + $ed
    call WriteHexByteTilesAtDE
    jr DebugMessageTest_Update_DrawUnselectedNumbers

SECTION "Bank 01 DebugMessageTest_Update_DrawUnselectedNumbers", ROMX

; Redraws the message test's numbers that are not selected (wMenuState), so only the selected one
; blinks. (C1, E-0357)
DebugMessageTest_Update_DrawUnselectedNumbers::
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

SECTION "Bank 01 DebugMessageTest_WrapNumber", ROMX

; Wraps the selected message-test number to its limit B: a value of B + 1 becomes 0 and $FF becomes
; B (unless B is $FF, meaning no limit), then redraws it. (C1, E-0357)
DebugMessageTest_WrapNumber::
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

SECTION "Bank 01 DebugMessageTest_ClearDependentNumbers", ROMX

; Clears the message numbers that depend on the one just changed: changing the library clears both,
; changing the first clears the second. (C2, E-0357; probed E-0374)
DebugMessageTest_ClearDependentNumbers::
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

SECTION "Bank 01 DebugMessageTestTable", ROMX

; DebugMessageTest_Update_ShowBank1B reads the word at $4E54 + 2 * wTemp0; a zero high byte takes
; the value directly, otherwise the word points at a sub-list (the bytes from $4E98 on); 34 words up
; to the first sub-list (E-0233, C1)
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

; Each frame of the monster record viewer (debug screen 10, 'A:ENEMY TBL CHK'): B returns to the
; debug menu (wGameMode 0, wModeState 0, mode change request). Left and Right step the monster id
; (wDebugCursor low, wDebugValue0 high) by 1, or by 16 while Select is held, within 0-$2AA: Left
; below 0 gives $2AB, Right at $2AB or more gives 0; then DebugShowMonsterRecord draws the new id.
; With neither it returns (DebugShowMonsterRecord_Done). (C1, E-0374)
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
    jp z, DebugShowMonsterRecord_Done
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

; HL = monster id: stores it in wDebugCursor/wDebugValue0 and wMonsterId, loads the MonsterTable
; entry with LoadMonsterRecord and draws it on the record viewer: the id as three hex digits at BG
; row 1, column 4; the name (ShowString_Bank88, category = id high byte, index = id low byte) in a 9
; x 1 window at vTiles2 + $400, saving and restoring the text window settings; the word at
; wRecordBuffer as hex at row 2; bytes 0-3 of wRecordBufferData as hex at row 3; the words at bytes
; 4, 8, $A, $C, $E, $10 and $12 as decimal (DebugShowMonsterRecord_Number24ToPackedBCD) at rows 4
; and 7-12; and bytes 6, 7 and $14-$17 as decimal (WriteDecimalByteTiles_Bank01) at rows 5, 6 and
; 13-16. Falls through to DebugShowMonsterRecord_Done. (C1, E-0374)
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
    call DebugShowMonsterRecord_DrawLowHexDigit
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
    call DebugShowMonsterRecord_DrawLowHexDigit
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
    ld a, [wRecordBufferData + $12]
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

; Ends DebugShowMonsterRecord (its drawing falls through to here) and is the exit
; DebugMonsterRecordViewer_Update jumps to when Right is not pressed this frame: returns. (C2,
; E-0369; probed E-0374)
DebugShowMonsterRecord_Done::
    ret

SECTION "Bank 01 DebugSkillViewer_Update", ROMX

; Each frame of the skill viewer (debug screen 9, '9:TOKUGI CHECK'): B returns to the debug menu.
; Left and Right step the skill number wDebugCursor through 0-$AE with wrap; the number is copied to
; wDebugValue0 and nothing more happens while it equals the one there before. A new number is drawn
; as hex at BG row 2, column 7; its record is loaded into wRecordBufferData (LoadSkillRecordPart,
; wBattleArg0 = 0, $11 bytes); byte 0 is drawn in decimal at row 4; the skill name (string category
; 4, index = the number; number 0 shows string $0E/1) goes to vTiles1 + $200; bytes 1, 2, 3 & 3, the
; high nibble of byte 3 and byte 4 (through DebugSkillViewer_Update_IndexOfFlagValue) pick strings
; of categories $12, $13, $14, $10 and $11; bytes 5-8 are drawn as 8 flag tiles each at rows 10-13
; (DebugSkillViewer_Update_DrawFlagBits); and four numbers capped at 9999
; (DebugSkillViewer_Update_ToCappedBCD) show the words at bytes 9 and $D and the sums byte 9 + byte
; $B and byte $D + byte $F (words) at rows 15 and 16. (C1, E-0374)
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
    call DebugSkillViewer_Update_DrawFlagBits
    ld a, [wRecordBufferData + $6]
    ld hl, vBGMap0 + $16b
    ld bc, $0801
    call DebugSkillViewer_Update_DrawFlagBits
    ld a, [wRecordBufferData + $7]
    ld hl, vBGMap0 + $18b
    ld bc, $0801
    call DebugSkillViewer_Update_DrawFlagBits
    ld a, [wRecordBufferData + $8]
    ld hl, vBGMap0 + $1ab
    ld bc, $0801
    call DebugSkillViewer_Update_DrawFlagBits
    ld a, [wRecordBufferData + $9]
    ld l, a
    ld a, [wRecordBufferData + $a]
    ld h, a
    call DebugSkillViewer_Update_ToCappedBCD
    ld hl, vBGMap0 + $1ea
    ld bc, $0100
    call DebugSkillViewer_Update_DrawFourDigits
    ld a, [wRecordBufferData + $9]
    ld l, a
    ld a, [wRecordBufferData + $a]
    ld h, a
    ld a, [wRecordBufferData + $b]
    ld e, a
    ld a, [wRecordBufferData + $c]
    ld d, a
    add hl, de
    call DebugSkillViewer_Update_ToCappedBCD
    ld hl, vBGMap0 + $1ef
    ld bc, $0100
    call DebugSkillViewer_Update_DrawFourDigits
    ld a, [wRecordBufferData + $d]
    ld l, a
    ld a, [wRecordBufferData + $e]
    ld h, a
    call DebugSkillViewer_Update_ToCappedBCD
    ld hl, vBGMap0 + $20a
    ld bc, $0100
    call DebugSkillViewer_Update_DrawFourDigits
    ld a, [wRecordBufferData + $d]
    ld l, a
    ld a, [wRecordBufferData + $e]
    ld h, a
    ld a, [wRecordBufferData + $f]
    ld e, a
    ld a, [wRecordBufferData + $10]
    ld d, a
    add hl, de
    call DebugSkillViewer_Update_ToCappedBCD
    ld hl, vBGMap0 + $20f
    ld bc, $0100
    call DebugSkillViewer_Update_DrawFourDigits
    ret

SECTION "Bank 01 DebugSkillViewer_Update_ToCappedBCD", ROMX

; For the debug skill viewer: converts HL to packed decimal digits (Number24ToPackedBCD) and caps
; the display at 9999: when the value has a digit above the thousands it shows $99 $99. (C2, E-0357;
; probed E-0374)
DebugSkillViewer_Update_ToCappedBCD::
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

SECTION "Bank 01 DebugSkillViewer_Update_DrawFourDigits", ROMX

; Draws the four packed-decimal digits in hTemp1 and hTemp0 at HL for the debug skill viewer,
; suppressing leading zeros: a digit is drawn as tile B + digit once any digit so far was non-zero,
; otherwise as the blank tile C; the last digit is always drawn. (C1, E-0357)
DebugSkillViewer_Update_DrawFourDigits::
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

SECTION "Bank 01 DebugSkillViewer_Update_IndexOfFlagValue", ROMX

; A = a skill record byte (byte 4): returns A = C = its position in the list $11, $12, $14, $21,
; $22, $31, $32, $40, $80 (1-9), or 10 for any other value; A = 0 returns at once with A = 0 and C
; unchanged. DebugSkillViewer_Update uses the result as the string index of category $11. (C2,
; E-0374)
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

SECTION "Bank 01 DebugSkillViewer_Update_DrawFlagBits", ROMX

; Draws B flag tiles at HL for the debug skill viewer: for each bit tested by the mask bytes at
; DebugSkillViewer_Update_DrawFlagBits_Data, tile C + 1 when that bit of D is set, otherwise tile C.
; (C1, E-0357)
DebugSkillViewer_Update_DrawFlagBits::
    ld d, a
    ld e, $00

.loop:
    push hl
    ld a, e
    ld hl, DebugSkillViewer_Update_DrawFlagBits_Data
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

SECTION "Bank 01 DebugSkillViewer_Update_DrawFlagBits_Data", ROMX

; Eight single-bit masks $80, $40, $20, $10, $08, $04, $02, $01, indexed by the tile number 0-7
; counted from the left. DebugSkillViewer_Update_DrawFlagBits tests the flag byte in D against each
; mask, most significant bit first, and writes tile C + 1 for a set bit and tile C for a clear bit
; to B consecutive VRAM cells starting at HL. (C1, E-0381)
DebugSkillViewer_Update_DrawFlagBits_Data::
    db $80, $40, $20, $10, $08, $04, $02, $01

; Draws the number DE as up to five decimal digits at HL for the debug monster viewer
; (Number24ToPackedBCD, then hTemp2 to hTemp0), with leading zeros shown as the blank tile C and the
; other digits as tile B + digit. (C1, E-0357)
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

SECTION "Bank 01 WriteDecimalByteTiles_Bank01", ROMX

; A = number, HL = VRAM address, B = the tile of digit 0, C = the blank tile: writes three tiles at
; HL, HL + 1 and HL + 2: the hundreds and tens as tile B + digit, a leading zero (A below 100, or
; below 10) as tile C, and the ones as tile B + digit. HL ends on the last tile and D = the ones
; digit; each write is a WriteVRAMByte between di and ei. The debug record and skill viewers call it
; with B = 1, C = 0. (C1, E-0374)
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

SECTION "Bank 01 DivModAByE_Bank01", ROMX

; D = A / E and A = A mod E by repeated subtraction (E must not be 0); E is kept. Used by
; WriteDecimalByteTiles_Bank01 with E = 100 and 10. (C2, E-0374)
; D = A / E and A = A mod E by repeated subtraction (E-0122)
DivModAByE_Bank01::
    ld d, $ff

.loop:
    inc d
    sub e
    jr nc, .loop
    add e
    ret

SECTION "Bank 01 WriteTileDPlusBAtHL", ROMX

; Writes tile D + B at VRAM address HL with WriteVRAMByte between di and ei; AF is kept. The digit
; writer of the debug record and skill viewers (WriteDecimalByteTiles_Bank01, WriteHexByteTilesAtHL,
; DebugShowMonsterRecord_DrawLowHexDigit). (C1, E-0374)
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

SECTION "Bank 01 WriteTileCAtHL", ROMX

; Writes tile C at VRAM address HL with WriteVRAMByte between di and ei; AF is kept.
; WriteDecimalByteTiles_Bank01 uses it for blank leading digits. (C1, E-0374)
; writes tile C at VRAM address HL with interrupts off (WriteVRAMByte); AF kept (E-0114)
WriteTileCAtHL::
    push af
    ld a, c
    di
    call WriteVRAMByte
    ei
    pop af
    ret

SECTION "Bank 01 WriteHexByteTilesAtHL", ROMX

; A = byte, B = the tile of digit 0, HL = VRAM address: writes the high nibble of A at HL + 1 and
; the low nibble at HL + 2 as tiles B + nibble (falling into
; DebugShowMonsterRecord_DrawLowHexDigit); HL ends at HL + 2. DebugShowMonsterRecord uses it with B
; = 1 and puts the third hex digit of an id at HL with DebugShowMonsterRecord_DrawLowHexDigit. (C1,
; E-0374)
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

; Draws the low nibble of A as one hex-digit tile (tile B + nibble) at HL: the second half of a hex
; byte on the debug monster viewer. (C1, E-0357)
DebugShowMonsterRecord_DrawLowHexDigit::
    and $0f
    ld d, a
    call WriteTileDPlusBAtHL
    ret

SECTION "Bank 01 DebugStaffRoll_Update", ROMX

; Each frame of debug screen 8 ('8:STAFF ROLL'): far-calls DebugStaffRoll_Update_RunScene (bank
; $E0), which runs the credits or one of the staff roll scenes. (C1, E-0374)
; update for debug-mode state 8: the screen shows the staff roll (SCENARIO & GAME DESIGNERS, YUJI
; HORII, ENIX, TOSE, FUMINORI ISHIKAWA) (E-0041)
DebugStaffRoll_Update::
    farcall DebugStaffRoll_Update_RunScene
    ret

SECTION "Bank 01 DebugResultsDisplay_Update", ROMX

; Each frame of the debug breeding screen (debug screen 7, '7:HAIGOU'), by wScreenState: 0 runs
; DebugResultsDisplay_Update_HandleInput (the field editor), 1 DebugResultsDisplay_Update_ShowChild.
; Any other state is the resistance editor: A builds the parents
; (DebugResultsDisplay_Update_BuildParents), B leaves (DebugResultsDisplay_Update_ExitToMenu), Right
; and Left move wSharedMenuWork over the 27 resistances (0-$1A, wrapping; the digit left is redrawn
; first), Up and Down decrease and increase the selected value in parent A list (wGridCursorY, when
; wDebugCursor = 4) or parent B list (wDebugResultsBuf), wrapping through 0-3, and Start redraws the
; digit and returns to the field editor (wScreenState = 0, wSharedMenuWork = 0). With no button the
; selected digit blinks (DebugResultsDisplay_Update_BlinkResistance). (C1, E-0374)
; update for debug-mode state 7: the screen shows 'RESULTS DISPLAY' (species, gender) (E-0041)
DebugResultsDisplay_Update::
    ld a, [wScreenState]
    and a
    jp z, DebugResultsDisplay_Update_HandleInput
    cp $01
    jp z, DebugResultsDisplay_Update_ShowChild
    ld a, [wJoypadPressedRepeat]
    bit 0, a
    jp nz, DebugResultsDisplay_Update_BuildParents
    bit 1, a
    jp nz, DebugResultsDisplay_Update_ExitToMenu
    bit 4, a
    jp nz, .call_debug_results_display_update_draw2
    bit 5, a
    jp nz, .call_debug_results_display_update_draw3
    bit 6, a
    jp nz, .check_debug_cursor
    bit 7, a
    jp nz, .check_debug_cursor2
    bit 3, a
    jr nz, .call_debug_results_display_update_draw
    call DebugResultsDisplay_Update_BlinkResistance
    ret

.call_debug_results_display_update_draw:
    call DebugResultsDisplay_Update_DrawResistance
    xor a
    ld [wScreenState], a
    ld [wSharedMenuWork], a
    ret

.check_debug_cursor:
    ld a, [wDebugCursor]
    cp $04
    jr nz, .read_shared_menu_work
    ld hl, wGridCursorY
    jr .read_shared_menu_work2

.read_shared_menu_work:
    ld hl, wDebugResultsBuf

.read_shared_menu_work2:
    ld a, [wSharedMenuWork]
    add_a_to_hl
    ld a, [hl]
    and a
    jr nz, .call_debug_results_display_update_blink
    ld a, $04

.call_debug_results_display_update_blink:
    dec a
    ld [hl], a
    call DebugResultsDisplay_Update_BlinkResistance
    ret

.check_debug_cursor2:
    ld a, [wDebugCursor]
    cp $04
    jr nz, .read_shared_menu_work3
    ld hl, wGridCursorY
    jr .read_shared_menu_work4

.read_shared_menu_work3:
    ld hl, wDebugResultsBuf

.read_shared_menu_work4:
    ld a, [wSharedMenuWork]
    add_a_to_hl
    ld a, [hl]
    cp $03
    jr c, .call_debug_results_display_update_blink2
    ld a, $ff

.call_debug_results_display_update_blink2:
    inc a
    ld [hl], a
    call DebugResultsDisplay_Update_BlinkResistance
    ret

.call_debug_results_display_update_draw2:
    call DebugResultsDisplay_Update_DrawResistance
    ld a, [wSharedMenuWork]
    cp $1a
    jr c, .set_shared_menu_work
    ld a, $ff

.set_shared_menu_work:
    inc a
    ld [wSharedMenuWork], a
    call DebugResultsDisplay_Update_BlinkResistance
    ret

.call_debug_results_display_update_draw3:
    call DebugResultsDisplay_Update_DrawResistance
    ld a, [wSharedMenuWork]
    and a
    jr nz, .set_shared_menu_work2
    ld a, $1b

.set_shared_menu_work2:
    dec a
    ld [wSharedMenuWork], a
    call DebugResultsDisplay_Update_BlinkResistance
    ret

SECTION "Bank 01 DebugResultsDisplay_Update_BlinkResistance", ROMX

; The debug breeding screen's blink timer: wDebugCounter counts 0 to $17; for counts below $10 the
; selected value is drawn, for $10-$17 it is blanked, then the count restarts. (C1, E-0357)
DebugResultsDisplay_Update_BlinkResistance::
    ld a, [wDebugCounter]
    inc a
    ld [wDebugCounter], a
    cp $10
    jr c, DebugResultsDisplay_Update_DrawResistance
    cp $18
    jr c, DebugResultsDisplay_Update_BlankResistance
    xor a
    ld [wDebugCounter], a

; Draws the selected resistance digit on the debug breeding screen: the byte at index
; wSharedMenuWork of parent A's resistance list (wGridCursorY, when wDebugCursor = 4) or parent B's
; (wDebugResultsBuf), as one digit tile at its place on the screen. (C1, E-0357)
DebugResultsDisplay_Update_DrawResistance::
    ld a, [wDebugCursor]
    cp $04
    jr nz, .read_shared_menu_work
    ld hl, wGridCursorY
    jr .read_shared_menu_work2

.read_shared_menu_work:
    ld hl, wDebugResultsBuf

.read_shared_menu_work2:
    ld a, [wSharedMenuWork]
    add_a_to_hl
    ld a, [hl]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call DebugResultsDisplay_ResistanceAddress
    ld a, [wDigits + $2]
    add $10
    ld c, a
    di
    call WaitForVRAMAccess
    ld a, c
    ld [hl], a
    ei
    ret

SECTION "Bank 01 DebugResultsDisplay_Update_BlankResistance", ROMX

; Blanks the selected resistance digit on the debug breeding screen (the off phase of its blink).
; (C1, E-0357)
DebugResultsDisplay_Update_BlankResistance::
    call DebugResultsDisplay_ResistanceAddress
    di
    call WaitForVRAMAccess
    xor a
    ld [hl], a
    ei
    ret

SECTION "Bank 01 DebugResultsDisplay_ResistanceAddress", ROMX

; HL = the screen address of resistance wSharedMenuWork on the debug breeding screen: a row for
; parent A (wDebugCursor = 4) or B, from the two address words in
; DebugResultsDisplay_ResistanceAddress_Data1/2; indices from 14 use the second row. (C2, E-0357;
; probed E-0374)
DebugResultsDisplay_ResistanceAddress::
    ld a, [wDebugCursor]
    cp $04
    jr nz, .check_shared_menu_work
    ld de, DebugResultsDisplay_ResistanceAddress_Data1
    jr .check_shared_menu_work2

.check_shared_menu_work:
    ld de, DebugResultsDisplay_ResistanceAddress_Data2

.check_shared_menu_work2:
    ld a, [wSharedMenuWork]
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

SECTION "Bank 01 DebugResultsDisplay_ResistanceAddress_Data1", ROMX

; Two BG map addresses, $9986 and $99A6 (vBGMap0 row 12, column 6 and row 13, column 6).
; DebugResultsDisplay_ResistanceAddress uses this pair when wDebugCursor is 4 (the first parent):
; the first word for a resistance number wSharedMenuWork below 14, the second word for 14 and above
; (number minus 14), and it adds the remaining number to the address as a column offset. The 27
; resistance digits are therefore a row of 14 and a row of 13. (C1, E-0381)
DebugResultsDisplay_ResistanceAddress_Data1::
    db $86, $99, $a6, $99

; Two BG map addresses, $99E6 and $9A06 (vBGMap0 row 15, column 6 and row 16, column 6): the same
; two-row layout of the 27 resistance digits for the other parent, used by
; DebugResultsDisplay_ResistanceAddress when wDebugCursor is not 4. The index is wSharedMenuWork as
; for DebugResultsDisplay_ResistanceAddress_Data1. (C1, E-0381)
DebugResultsDisplay_ResistanceAddress_Data2::
    db $e6, $99, $06, $9a

; State 1 of DebugResultsDisplay_Update (entered from DebugResultsDisplay_Update_BuildParents):
; computes and shows the child on the debug breeding screen. A wArg1 other than 0 or 2 (the marker
; DebugToggleArg1Marker toggles) becomes 0; it runs ComputeBreedingChild on wRecordBufA and
; wRecordBufB and returns at once unless wArg5 is then $FF. With a child species (wArg6/wArg7 not
; both $FF) it tests that species with TestBitInFieldAtArg3 against the address of
; DebugResultsDisplay_Update_ShowChild_Data ($75C5), which, read while bank $15 is mapped, is the
; bit field BreedShowNameSpeciesBits; with the bit clear it draws the unknown-name placeholder at
; vTiles2 + $500 (otherwise it blanks that field), then draws the child's name at vTiles2 + $200,
; its species number, sex mark, plus value, level and maximum level
; (DebugResultsDisplay_Update_ShowChild_DrawBCD) and its 27 resistance digits, restores wArg1 and
; clears wScreenState and wNameEntryState. With no child it draws the placeholder in both name
; fields and number 0, clears wScreenState and wNameEntryState and returns without popping the saved
; wArg1, so its ret takes that pushed AF as the return address (as read, not run). (C1, E-0369)
DebugResultsDisplay_Update_ShowChild::
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
    ld de, DebugResultsDisplay_Update_ShowChild_Data
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
    call DebugResultsDisplay_Update_ShowChild_DrawBCD
    ld hl, wChildRecord + MON_LEVEL
    ld a, [hl]
    ld c, a
    ld de, vBGMap0 + $22
    call PackTwoDigitsOfCAsBCD
    call DebugResultsDisplay_Update_ShowChild_DrawBCD
    ld hl, wChildRecord + MON_MAX_LEVEL
    ld a, [hl]
    ld c, a
    ld de, vBGMap0 + $42
    call PackTwoDigitsOfCAsBCD
    call DebugResultsDisplay_Update_ShowChild_DrawBCD
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

SECTION "Bank 01 DebugResultsDisplay_Update_ShowChild_DrawBCD", ROMX

; Writes C as two hex-digit tiles ($10 + each nibble) at DE, waiting for VRAM access before each.
; (C1, E-0357)
DebugResultsDisplay_Update_ShowChild_DrawBCD::
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

SECTION "Bank 01 DebugResultsDisplay_Update_HandleInput", ROMX

; State 0 of DebugResultsDisplay_Update, the input of the debug breeding screen ('RESULTS DISPLAY').
; A builds the parents and computes the child (DebugResultsDisplay_Update_BuildParents), B leaves
; (DebugResultsDisplay_Update_ExitToMenu), Up and Down move between the ten fields, Right and Left
; change the selected field, Start opens the resistance editor for a parent
; (DebugResultsDisplay_Update_PressStart). Select loads both parents' default resistances from their
; species records (LoadSpeciesRecord, CopySpeciesResistancesFromIndexCToDE) into wGridCursorY
; (parent A) and wDebugResultsBuf (parent B) and draws them as digit tiles. With no button it blinks
; the selected field (DebugResultsDisplay_BlinkSelectedField). (C1, E-0369)
DebugResultsDisplay_Update_HandleInput::
    ld a, [wJoypadPressedRepeat]
    bit 0, a
    jp nz, DebugResultsDisplay_Update_BuildParents
    bit 1, a
    jp nz, DebugResultsDisplay_Update_ExitToMenu
    bit 6, a
    jp nz, DebugResultsDisplay_Update_PrevField
    bit 7, a
    jp nz, DebugResultsDisplay_Update_NextField
    bit 4, a
    jp nz, DebugResultsDisplay_Update_IncreaseField
    bit 5, a
    jp nz, DebugResultsDisplay_Update_DecreaseField
    bit 3, a
    jp nz, DebugResultsDisplay_Update_PressStart
    bit 2, a
    jp nz, .read_debug_value0
    call DebugResultsDisplay_BlinkSelectedField
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
    call CopySpeciesResistancesFromIndexCToDE
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
    call CopySpeciesResistancesFromIndexCToDE
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

SECTION "Bank 01 CopySpeciesResistancesFromIndexCToDE", ROMX

; C = first resistance index, DE = destination: copies the species resistances from index C through
; $1A (wSpeciesRecord + SPECIES_RESISTANCES + C, one at a time through LoadSpeciesResistanceArg4 in
; bank $0E, which leaves each in wArg5) to DE, DE + 1, ...; the first byte is copied before the
; test, so C = $1B or more copies one byte. DE ends past the copy, C = $1B, wArg4 = the last index.
; DebugResultsDisplay_Update_HandleInput uses it with C = 0 to load both parents default
; resistances. (C2, E-0374)
; for C up to $1A, loads byte C of wSpeciesRecord + $12 (LoadSpeciesResistanceArg4) and stores it at
; DE (E-0122) (E-0340: the address in its name read as its RAM name; was
; CopySpeciesResistancesFromIndexCToDE) (E-0345: copies from wSpeciesRecord + $12
; (SPECIES_RESISTANCES); was CopySpeciesResistancesFromIndexCToDE)
CopySpeciesResistancesFromIndexCToDE::
    push bc
    push de
    ld a, c
    ld [wArg4], a
    farcall LoadSpeciesResistanceArg4
    pop de
    pop bc
    ld a, [wArg5]
    ld [de], a
    inc de
    inc c
    ld a, c
    cp $1b
    jr c, CopySpeciesResistancesFromIndexCToDE
    ret

SECTION "Bank 01 DebugToggleArg1Marker", ROMX

; Toggles wArg1 between 0 and 2 and, with interrupts off after WaitForVRAMAccess, writes tile $10 +
; wArg1 (tile $10 or $12) at vBGMap0 + $81 (BG row 4, column 1).
; DebugResultsDisplay_Update_PressStart calls it for Start on a field other than the plus values;
; DebugResultsDisplay_Update_ShowChild passes wArg1 (0 or 2) to ComputeBreedingChild. (C1, E-0374)
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

SECTION "Bank 01 DebugResultsDisplay_Update_PressStart", ROMX

; Start on the debug breeding screen: on parent A's plus-value field (4) or parent B's (7) it opens
; the resistance editor (wScreenState + 2, starting at resistance 0); on other fields it toggles the
; marker at the top left (DebugToggleArg1Marker). (C1, E-0357)
DebugResultsDisplay_Update_PressStart::
    ld a, [wDebugCursor]
    cp $04
    jr z, .call_debug_results_display_draw_selected
    cp $07
    jr z, .call_debug_results_display_draw_selected
    call DebugToggleArg1Marker
    call DebugResultsDisplay_BlinkSelectedField
    ret

.call_debug_results_display_draw_selected:
    call DebugResultsDisplay_DrawSelectedField
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    xor a
    ld [wSharedMenuWork], a
    ret

SECTION "Bank 01 DebugResultsDisplay_Update_PrevField", ROMX

; Up on the debug breeding screen: redraws the current field and moves to the previous one (stops at
; field 0). (C1, E-0357)
DebugResultsDisplay_Update_PrevField::
    call DebugResultsDisplay_DrawSelectedField
    ld a, [wDebugCursor]
    and a
    ret z
    dec a
    ld [wDebugCursor], a
    call DebugResultsDisplay_BlinkSelectedField
    ret

SECTION "Bank 01 DebugResultsDisplay_Update_NextField", ROMX

; Down on the debug breeding screen: redraws the current field and moves to the next one (stops at
; field 9). (C1, E-0357)
DebugResultsDisplay_Update_NextField::
    call DebugResultsDisplay_DrawSelectedField
    ld a, [wDebugCursor]
    cp $09
    ret z
    inc a
    ld [wDebugCursor], a
    call DebugResultsDisplay_BlinkSelectedField
    ret

SECTION "Bank 01 DebugResultsDisplay_Update_IncreaseField", ROMX

; Right on the debug breeding screen: increases the selected field. The species fields (0 and 2)
; count 0-$174, wrapping to 0, and the species name is redrawn; the sex fields (1 and 3) toggle
; between 0 and 1; the other fields go on to DebugResultsDisplay_Update_IncreaseField_Number. (C1,
; E-0357)
DebugResultsDisplay_Update_IncreaseField::
    ld a, [wDebugCursor]
    and a
    jr z, .skip6
    cp $01
    jr z, .skip
    cp $02
    jr z, .skip5
    cp $03
    jr z, .skip2
    jp DebugResultsDisplay_Update_IncreaseField_Number

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
    call DebugResultsDisplay_BlinkSelectedField
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
    ld bc, -1

.next:
    inc bc
    pop hl
    ld a, c
    ld [hli], a
    ld a, b
    ld [hl], a
    call DebugResultsDisplay_BlinkSelectedField
    ld a, [wDebugCursor]
    cp $02
    jr z, DebugResultsDisplay_Update_DrawParentBName
    ld de, wDebugValue0
    ld hl, vTiles2 + $300
    jr DebugResultsDisplay_Update_DrawSpeciesName

SECTION "Bank 01 DebugResultsDisplay_Update_DrawParentBName", ROMX

; Redraws parent B's species name (from wDebugValue3) at vTiles2 + $400. (C1, E-0357)
DebugResultsDisplay_Update_DrawParentBName::
    ld de, wDebugValue3
    ld hl, vTiles2 + $400

; Clears a 9 x 1 tile name field at HL and draws the name of the species whose id word is at DE
; there (DrawMonsterNameForWordAtDE_Bank01). (C1, E-0357)
DebugResultsDisplay_Update_DrawSpeciesName::
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

SECTION "Bank 01 DebugResultsDisplay_Update_DecreaseField", ROMX

; Left on the debug breeding screen: decreases the selected field. The species fields wrap from 0 to
; $174, the sex fields toggle, the other fields go on to
; DebugResultsDisplay_Update_DecreaseField_Number. (C1, E-0357)
DebugResultsDisplay_Update_DecreaseField::
    ld a, [wDebugCursor]
    and a
    jr z, .skip5
    cp $01
    jr z, .skip
    cp $02
    jr z, .skip6
    cp $03
    jr z, .skip2
    jp DebugResultsDisplay_Update_DecreaseField_Number

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
    call DebugResultsDisplay_BlinkSelectedField
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
    call DebugResultsDisplay_BlinkSelectedField
    ld a, [wDebugCursor]
    cp $02
    jp z, DebugResultsDisplay_Update_DrawParentBName
    ld de, wDebugValue0
    ld hl, vTiles2 + $300
    jp DebugResultsDisplay_Update_DrawSpeciesName

SECTION "Bank 01 DebugResultsDisplay_Update_IncreaseField_Number", ROMX

; Right on the numeric fields of the debug breeding screen: parent A's plus value (field 4,
; wScreenStep), level (5, wScreenCounter) and item (6, wGlyphListStart), and parent B's plus value
; (7, wScreenSubStep), level (8, wGlyphListPos) and item (9, wGridCursorX). Plus values and levels
; count 0-99, items 0-$1B, wrapping to 0. (C1, E-0357)
DebugResultsDisplay_Update_IncreaseField_Number::
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
    call DebugResultsDisplay_BlinkSelectedField
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

SECTION "Bank 01 DebugResultsDisplay_Update_DecreaseField_Number", ROMX

; Left on the numeric fields of the debug breeding screen: the same fields counted down, wrapping
; from 0 to 99 (or $1B for items). (C1, E-0357)
DebugResultsDisplay_Update_DecreaseField_Number::
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
    call DebugResultsDisplay_BlinkSelectedField
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

SECTION "Bank 01 DebugResultsDisplay_Update_ExitToMenu", ROMX

; B on the debug breeding screen: clears all its values and leaves for the debug menu (wModeState =
; 0 and a mode change request). (C2, E-0357; probed E-0374)
DebugResultsDisplay_Update_ExitToMenu::
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

SECTION "Bank 01 DebugResultsDisplay_Update_BuildParents", ROMX

; A on the debug breeding screen: when both levels (wScreenCounter, wGlyphListPos) are at least 10
; and the parents' sexes (wDebugValue2, wDebugSubState) differ, clears $1EF bytes from wRecordBufA
; and builds the two parent records in wRecordBufA and wRecordBufB from the entered species, family
; (FamilyForSpeciesIdArg6), sex, plus value, level, item and resistances, then adds 1 to
; wScreenState and clears wNameEntryState. From state 0 this moves to state 1,
; DebugResultsDisplay_Update_ShowChild; the resistance editor (state 2 or more) also jumps here on
; A, and the same increment leaves it in the editor. (C2, E-0369; probed E-0374)
DebugResultsDisplay_Update_BuildParents::
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

SECTION "Bank 01 DebugResultsDisplay_BlinkSelectedField", ROMX

; The blink of the selected field on the debug breeding screen: wDebugCounter + 1; counts 1-$0F draw
; the field (DebugResultsDisplay_DrawSelectedField), $10-$17 blank its three tiles
; (StepDebugCursorDebugCounter_BlankField), and $18 sets the counter to 0 and draws.
; DebugResultsDisplay_Update_HandleInput calls it on frames with no button, and the field steps
; (DebugResultsDisplay_Update_PressStart, DebugResultsDisplay_Update_PrevField,
; DebugResultsDisplay_Update_NextField, DebugResultsDisplay_Update_IncreaseField and others) after a
; change. (C1, E-0374)
; debug: wDebugCounter += 1; below $10 continues at DebugResultsDisplay_DrawSelectedField, below $18
; at StepDebugCursorDebugCounter_BlankField, then wraps to 0 (E-0126)
DebugResultsDisplay_BlinkSelectedField::
    ld a, [wDebugCounter]
    inc a
    ld [wDebugCounter], a
    cp $10
    jr c, DebugResultsDisplay_DrawSelectedField
    cp $18
    jp c, StepDebugCursorDebugCounter_BlankField
    xor a
    ld [wDebugCounter], a

; Draws field wDebugCursor (0-9) of the debug breeding screen at the BG address
; DebugResultsDisplay_DrawSelectedField_Data2[field], from the RAM word whose address is
; DebugResultsDisplay_DrawSelectedField_Data1[field]. Fields 0 and 2 (the species words of parents A
; and B, wDebugValue0 and wDebugValue3) are drawn as three hex digits (WriteThreeHexDigitsAtDE);
; fields 1 and 3 (their sexes, wDebugValue2 and wDebugSubState) as one tile, the byte + $FE; fields
; 4-9 (plus value, level and item of A, wScreenStep, wScreenCounter and wGlyphListStart, then of B,
; wScreenSubStep, wGlyphListPos and wGridCursorX) as the last two decimal digits of the low byte
; (PackTwoDigitsOfCAsBCD, WriteHexByteTilesAtDE). (C1, E-0374)
; debug: draws the value of field wDebugCursor (DebugResultsDisplay_DrawSelectedField_Data1) at
; DebugResultsDisplay_DrawSelectedField_Data2[wDebugCursor] as hex, a tile or BCD (E-0128)
DebugResultsDisplay_DrawSelectedField::
    ld a, [wDebugCursor]
    sla a
    ld de, DebugResultsDisplay_DrawSelectedField_Data1
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
    ld hl, DebugResultsDisplay_DrawSelectedField_Data2
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
    ld hl, DebugResultsDisplay_DrawSelectedField_Data2
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
    ld hl, DebugResultsDisplay_DrawSelectedField_Data2
    add_a_to_hl
    ld a, [hl]
    ld e, a
    inc hl
    ld a, [hl]
    ld d, a
    call PackTwoDigitsOfCAsBCD
    call WriteHexByteTilesAtDE
    ret

SECTION "Bank 01 PackTwoDigitsOfCAsBCD", ROMX

; C = the tens and ones digits of C packed as BCD (tens in the high nibble), through
; HLToDecimalDigits (wDigits); the hundreds are dropped and DE is kept. Used for the two-digit
; fields of the debug breeding screen. (C2, E-0374)
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

SECTION "Bank 01 StepDebugCursorDebugCounter_BlankField", ROMX

; Blanks the three digit tiles of debug field wDebugCursor (screen address from
; DrawDebugFieldValueDebugCursor_Data2): the off phase of the field's blink. (C1, E-0357)
StepDebugCursorDebugCounter_BlankField::
    ld a, [wDebugCursor]
    sla a
    ld hl, DebugResultsDisplay_DrawSelectedField_Data2
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

SECTION "Bank 01 DebugResultsDisplay_DrawSelectedField_Data1", ROMX

; Ten words, indexed by the field number wDebugCursor (0-9): each is the address of the RAM value
; that field shows. They are wDebugValue0, wDebugValue2, wDebugValue3, wDebugSubState, wScreenStep,
; wScreenCounter, wGlyphListStart, wScreenSubStep, wGlyphListPos and wGridCursorX.
; DebugResultsDisplay_DrawSelectedField loads the word stored there into BC and draws it as hex
; digits, a one-tile value or two decimal digits depending on the field. (C1, E-0381)
DebugResultsDisplay_DrawSelectedField_Data1::
    db $f9, $c5, $fb, $c5, $fc, $c5, $fe, $c5, $81, $d7, $83, $d7, $85, $d7, $82, $d7
    db $84, $d7, $86, $d7

; Ten BG map addresses, indexed by the field number wDebugCursor (0-9), where the breeding debug
; screen draws that field: fields 0-3 at vBGMap0 rows 7-10, column 6 ($98E6, $9906, $9926, $9946)
; and fields 4-9 at rows 12-17, column 2 ($9982, $99A2, ... $9A22).
; DebugResultsDisplay_DrawSelectedField draws the value there and
; StepDebugCursorDebugCounter_BlankField blanks three cells from it during the blink. (C1, E-0381)
DebugResultsDisplay_DrawSelectedField_Data2::
    db $e6, $98, $06, $99, $26, $99, $46, $99, $82, $99, $a2, $99, $c2, $99, $e2, $99
    db $02, $9a, $22, $9a

; DE points at a monster id word, HL = tile address: copies that monster name to wNameGlyphBuf
; (CopyMonsterNameToBuffer_B01), ends it with $F0 at wNameGlyphBuf + $A (at most 10 glyphs) and
; draws its glyphs at HL (CopyGlyphTilesToVRAM). Used for the species names of the debug breeding
; screen (DebugResultsDisplay_Update_ShowChild, DebugResultsDisplay_Update_DrawSpeciesName). (C1,
; E-0374)
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

SECTION "Bank 01 CopyMonsterNameToBuffer_B01", ROMX

; HL = monster id: with wDataBank = $08 it reads entry 2 of StringDatabase
; (StringTable_MonsterNames) with ReadWordFromDataBank, then the string pointer at that list + 2 *
; HL, and copies 16 bytes from it in bank $08 to wNameGlyphBuf with CopyFromBankWaitVRAM; wDataBank
; is restored. (C1, E-0374)
; HL = string number; copies 16 bytes of that string of StringTable_MonsterNames (bank $08, via
; wDataBank) to wNameGlyphBuf; wDataBank is restored
CopyMonsterNameToBuffer_B01::
    push hl
    ld a, [wDataBank]
    push af
    ld a, BANK(StringDatabase)
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

SECTION "Bank 01 DebugResultsDisplay_Update_WriteUnknownName", ROMX

; Fills wNameGlyphBuf with nine $98 placeholder glyphs followed by $F0; HL ends on the $F0.
; DebugResultsDisplay_Update_ShowChild draws it as the child name placeholder. (C2, E-0374)
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

SECTION "Bank 01 DebugAutomap_Update", ROMX

; Each frame of the automap check (debug screen 3, '3:AUTOMAP CHECK'). A starts a key world
; (DebugAutomap_Update_EnterKeyWorld) when wDebugState is $FF or wDebugSubState bit 7 is clear,
; otherwise it acts as B. B (unless wDebugState is $FF) sets wCurrentKeyIndex = wDebugValue0 and
; hMapScreenX/Y = wDebugValue2/3 and enters the field (game mode 1, wScriptRunning 0): with
; wDebugSubState bit 7 set on map DebugAutomap_Update_Data[wDebugState & $1F] (wMapType 0,
; wModeState 0); otherwise in the key world of SRAM slot wDebugState & $7F
; (LoadKeyWorldFlagsRecordFromSRAMSlotKeyWorldSlot, wMapType $80, map size from
; wKeyWorldWidth/Height, wModeState 5). Start returns to the debug menu. Up and Down move
; wDebugCursor over four fields; Right and Left change field 0 the key (wDebugValue0: Left from 0
; gives $13, Right wraps after $1F; LoadKeyEntryFieldsToDebugState reloads its fields), 1 the level
; (wDebugValue1, 0-99 wrapping, not while wDebugSubState bit 7 is set), 2 and 3 the screen X and Y
; (wDebugValue2/3, 0-15). A changed key or level (bit 7) is redrawn
; (DebugAutomap_Update_DrawKeyName, the number at row 8, DebugAutomap_Update_DrawLevel), X and Y at
; rows 10 and 11, and tile $F8 marks the field at column 9 (tile $80 elsewhere). (C1, E-0374)
; update for debug-mode state 3: the screen shows '? AUTOMAP ?' (key, level, position) (E-0041)
DebugAutomap_Update::
    ld a, [wJoypadPressed]
    bit 0, a
    jp z, .check_bit1
    ld a, [wDebugState]
    cp $ff
    jr z, .call_debug_automap_update_enter_key_world
    ld a, [wDebugSubState]
    bit 7, a
    jr nz, .check_debug_state

.call_debug_automap_update_enter_key_world:
    call DebugAutomap_Update_EnterKeyWorld
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
    call DebugAutomap_Update_DrawKeyName

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
    call DebugAutomap_Update_DrawLevel

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

SECTION "Bank 01 DebugAutomap_Update_Data", ROMX

; Thirteen map ids: $00, $05, $20, $30, $48, $70, $A0, $A8, $B0, $B8, $C8, $D1, $DA. When bit 7 of
; wDebugSubState is set, DebugAutomap_Update (B pressed) stores the entry at index wDebugState & $1F
; into hMapId and enters the field (game mode 1, wMapType 0). wDebugState is byte 0 of the chosen
; wKeyList entry, and the index is masked to 0-31, so the reader does not stop at the thirteenth
; entry. (C1, E-0381)
DebugAutomap_Update_Data::
    db $00, $05, $20, $30, $48, $70, $a0, $a8, $b0, $b8, $c8, $d1, $da

; Starts a debug key world from the automap screen: rolls the key contents for level wDebugValue1
; (RollKeyContentsForLevelTemp0) and sets wCurrentKeyIndex = wDebugValue0. Byte 0 of its wKeyList
; entry ($C707 + 4 * key) becomes, when wDebugState is $FF, the first free SRAM key-world slot
; (FindSRAMSlotMarkerIndex; with none free it returns here), otherwise its old value & $7F; it is
; also wKeyWorldSlot. Bytes 1-3 get hTemp1-hTemp3 (byte 3 also wPartyStrength). It then generates
; the key world (GenerateKeyWorld, which sets bit 7 of byte 0 again), saves the key world record
; (SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot), sets the map size from the key world, places the
; player and the three followers facing 0 at the goal screen and position, and enters the field
; (game mode 1, wModeState 5, wMapType $80). (C2, E-0374)
DebugAutomap_Update_EnterKeyWorld::
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
    farcall GenerateKeyWorld
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

SECTION "Bank 01 LoadKeyEntryFieldsToDebugState", ROMX

; A = key slot: wDebugState = byte 0 and wDebugSubState = byte 3 of its wKeyList entry ($C707 + 4 *
; A), and wDebugValue1 = byte 3 | $80 (the level, marked for redrawing). Used by DebugAutomap_Init
; and when the key changes in DebugAutomap_Update. (C2, E-0374)
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

SECTION "Bank 01 DebugAutomap_Update_DrawLevel", ROMX

; Draws the debug automap's level number (wDebugValue1 & $7F) at BG row 9, column 10; for a slot
; from SRAM (wDebugState $FF) or a key whose bit 7 of wDebugSubState is set it shows and stores 0.
; (C1, E-0357)
DebugAutomap_Update_DrawLevel::
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

SECTION "Bank 01 DebugAutomap_Update_DrawKeyName", ROMX

; Draws the key name on the debug automap screen: clears the 15-glyph name, then shows a fixed
; five-glyph string when the slot is from SRAM and wDebugSubState bit 7 is set, the name of the
; debug menu entry (DebugMenuNames, 16 bytes each, by wDebugState) when only bit 7 is set, or the
; key's name (WriteKeyNameToDE for wDebugValue0 & $1F). (C1, E-0357)
DebugAutomap_Update_DrawKeyName::
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

SECTION "Bank 01 DebugMenuNames", ROMX

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

; Each frame of the map editor (debug screen 2, '2:EDIT'). A: when DebugMapEditor_CheckPosition
; (hTemp0 = wDebugValue0) rejects the position it draws tiles $F0-$F7 at vBGMap0 + $1A5 (the 'NOT
; DATA' text); otherwise it sets hMapId = wDebugValue0, hMapScreenX = wDebugValue1, hMapScreenY =
; wDebugValue3, hPlayerX = wDebugValue2, hPlayerY = wDebugState, clears wFieldReturnPhase and
; returns to the debug menu (game mode 0, wModeState 0). Up and Down move wDebugCursor over five
; fields; Left and Right held change the field every fourth frame: 0 the map (wDebugValue0; going
; below 0 or reaching $FF gives $E1; the map name, string 0/(10 + map), is reprinted at vTiles2 +
; $200), 1 screen X (wDebugValue1) and 2 screen Y (wDebugValue3), 0-15 wrapping, 3 and 4 the player
; X and Y (wDebugValue2, wDebugState) in steps of 16. It redraws the values at rows 8-11 and marks
; the field with tile $F8 at column 9. (C1, E-0374)
; update for debug-mode state 2: the screen shows '? EDIT ?' (world, map number, position) (E-0041)
DebugMapEditor_Update::
    ld a, [wJoypadPressedRepeat]
    bit 0, a
    jr z, .check_joypad_pressed_repeat
    ld a, [wDebugValue0]
    ldh [hTemp0], a
    call DebugMapEditor_CheckPosition
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

SECTION "Bank 01 DebugMainMenu_Update", ROMX

; Each frame of the debug menu (wModeState 0 and 1): Down or Right select the next of 12 items and
; Up or Left the previous one (wDebugCursor, wrapping); the selected line is highlighted by writing
; its 16 tiles (wDebugCursor * 16 + $A0 on) at vBGMap0 + $122. A on item 0 ('1:GOTO PROGRAM') enters
; the field (wGameMode 1, wMapType 0, wKeyWorldRefresh $80); items 1-10 open debug screens 2-11
; (wGameMode 0, wModeState = item + 1; item 3 also sets wFieldTransitionStep = $80); item 11
; ('RETURN') copies wDebugMenuFlag0-3 into wGameMode, wModeState and the two bytes after them. Each
; choice requests a mode change. (C1, E-0374)
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

SECTION "Bank 01 DebugMonsterPictureViewer_Update", ROMX

; Each frame of the picture viewer (debug screen 4, '4:GRAFHICS'). A cycles wDebugState 0-3 (the
; sprite pose), B returns to the debug menu, Up or Down switch wDebugCursor between the picture
; number (wDebugValue0/1) and the sprite number (wDebugValue2/3). Left and Right step the selected
; number through 0-$17E with wrap, setting bit 7 of its high byte. A marked picture number is
; cleared of the mark and loaded (LoadMonsterPicture to vTiles2 + $200; on CGB
; LoadMonsterPictureAttributes and a BG palette upload); a marked sprite number is decompressed from
; its MonsterSpriteTable entry (bank $04) to vTiles0 + $200, and on CGB its 8 palette bytes from
; bank $27 ($7328 + 8 * number) go to wOBJPaletteBuffer. The selected number blinks (bit 3 of the
; wDebugSubState frame count), both are drawn as three hex digits at rows 5 and 6, and the sprite is
; drawn at the scroll position + ($70, $60) with sub-sprite 2 * pose (pose 3 is sub-sprite 2
; mirrored, hSpriteAttrXor $20) plus a frame that alternates every 16 frames, by
; DrawMetaSpriteSet_Bank27 (high byte not 0), DrawMetaSpriteSet_Bank26 (wDebugValue2 bit 7) or
; DrawMetaSpriteSet_Bank25. (C1, E-0374)
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
    ASSERT BANK(MonsterSpriteTable) == $04, "MonsterSpriteTable is read with bank $04 mapped"
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
    add LOW(MonsterSpritePalettes)
    ld l, a
    ld a, h
    adc HIGH(MonsterSpritePalettes)
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

SECTION "Bank 01 DebugSoundTest_Update", ROMX

; Each frame of the sound test (debug screen 5, '5:SOUNDS'). Start plays the selection: on the music
; line (wMenuState 0) it resets the sound hardware (InitSoundHardware) and queues music
; DebugSoundTestMusic[wTemp0]; on the effect line it queues effect DebugSoundTestEffects[wTemp1]. Up
; or Down switch the line (redrawing the old one). Right and Left step the selected number and A
; sets it to 0; each change plays effect $69 and wraps it to $20 music entries or $54 effect entries
; with DebugSoundTest_WrapAndDrawId, which draws the sound id. B returns to the debug menu
; (wModeState 0). The selected number blinks at row 7 or 8, column 9. (C1, E-0374)
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
    jr nz, .call_debug_sound_test_update_draw_effect
    call DebugSoundTest_Update_DrawMusicNumber
    jr .read_menu_state

.call_debug_sound_test_update_draw_effect:
    call DebugSoundTest_Update_DrawEffectNumber

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
    call z, DebugSoundTest_WrapAndDrawId
    ld b, $54
    cp $01
    call z, DebugSoundTest_WrapAndDrawId

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
    jr nz, DebugSoundTest_Update_BlinkEffectNumber
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, DebugSoundTest_Update_DrawMusicNumber
    xor a
    ld hl, vBGMap0 + $e9
    call WriteVRAMByteInc
    call WriteVRAMByte
    jr DebugSoundTest_Update_Done

SECTION "Bank 01 DebugSoundTest_Update_DrawMusicNumber", ROMX

; Redraws the sound test's music number (wTemp0) at BG row 7, column 9. (C1, E-0357)
DebugSoundTest_Update_DrawMusicNumber::
    ld a, [wTemp0]
    ld de, vBGMap0 + $e9
    call WriteHexByteTilesAtDE
    jr DebugSoundTest_Update_Done

SECTION "Bank 01 DebugSoundTest_Update_BlinkEffectNumber", ROMX

; Blinks the sound test's sound-effect number when it is selected: blank on frames with bit 3 of
; wFrameCounterLo clear, otherwise drawn. (C1, E-0357)
DebugSoundTest_Update_BlinkEffectNumber::
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, DebugSoundTest_Update_DrawEffectNumber
    xor a
    ld hl, vBGMap0 + $109
    call WriteVRAMByteInc
    call WriteVRAMByte
    jr DebugSoundTest_Update_Done

SECTION "Bank 01 DebugSoundTest_Update_DrawEffectNumber", ROMX

; Redraws the sound test's sound-effect number (wTemp1) at BG row 8, column 9. (C1, E-0357)
DebugSoundTest_Update_DrawEffectNumber::
    ld a, [wTemp1]
    ld de, vBGMap0 + $109
    call WriteHexByteTilesAtDE

; The sound test's shared exit: returns. (C2, E-0357; probed E-0374)
DebugSoundTest_Update_Done::
    ret

SECTION "Bank 01 DebugSoundTest_WrapAndDrawId", ROMX

; Wraps the selected sound-test number to its count B (B wraps to 0, $FF to B - 1) and draws the
; sound id it selects: the byte of DebugSoundTestMusic (row 7, column 12) or DebugSoundTestEffects
; (row 8, column 12) at that index. (C1, E-0357)
DebugSoundTest_WrapAndDrawId::
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

SECTION "Bank 01 DebugSoundTestMusic", ROMX

; DebugSoundTest_Update passes the byte at $65DE + wTemp0 to QueueMusic after InitSoundHardware, and
; DebugSoundTest_WrapAndDrawId draws it in hex; 32 entries (E-0238, C1)
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
; DebugSoundTest_WrapAndDrawId.read_temp1 draws it in hex at vBGMap0 + $10C; 84 entries up to the
; next routine (E-0238, C1)
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

; Each frame of the battle set-up (debug screen 6, '6:BATTLE'). Without Start it runs
; DebugBattleSetup_Update_HandleInput. Start sets wEncounterKind = the first field (wWorkBuf, 'No.
; foes') and wBattleKind = the 'Debug' field (wWorkBuf + 8) shifted right; a non-zero battle kind
; goes to DebugBattleSetup_Update_LoadEncounter, otherwise the three monster ids at wWorkBuf + 2 are
; copied to wEncounterMonsters (DebugBattleSetup_CopyMonsterId, 0 becomes 1) and it falls into
; DebugBattleSetup_Update_StartBattle. (C1, E-0374)
; update for debug-mode state 6: the screen shows '? BATTLE ?' (number of foes, three monsters,
; skill, levels) (E-0041)
DebugBattleSetup_Update::
    ld a, [wJoypadPressed]
    and $08
    jp z, DebugBattleSetup_Update_HandleInput
    ld a, [wWorkBuf]
    ld [wEncounterKind], a
    ld a, [wWorkBuf + $8]
    sra a
    ld [wBattleKind], a
    or a
    jr nz, DebugBattleSetup_Update_LoadEncounter
    ld hl, wEncounterMonsters
    ld de, wWorkBuf + $2
    call DebugBattleSetup_CopyMonsterId
    call DebugBattleSetup_CopyMonsterId
    call DebugBattleSetup_CopyMonsterId

; Starts the debug battle (DebugBattleSetup_Update falls through to here after loading the foes, and
; DebugBattleSetup_Update_LoadEncounter jumps here): clears the menu values, creates the save data
; the battle needs (a fresh default game when wWorkBuf + 8 is set, otherwise
; DebugBattleSetup_Update_EnsureSave), switches to game mode 4 (wModeState 0) with a mode change
; request and wBGFillFlag, and starts palette fade 4. (C1, E-0369)
DebugBattleSetup_Update_StartBattle::
    xor a
    ld [wMenuState], a
    xor a
    ld [wDebugCursor], a
    ld [wDebugValue0], a
    ld [wDebugValue1], a
    ld a, [wWorkBuf + $8]
    or a
    jr nz, .call_debug_battle_setup_create_default_game
    call DebugBattleSetup_Update_EnsureSave
    jr .set_game_mode_to_04

.call_debug_battle_setup_create_default_game:
    call DebugBattleSetup_CreateDefaultGame

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

SECTION "Bank 01 DebugBattleSetup_CopyMonsterId", ROMX

; Copies one word from DE to HL; a zero word is stored as 1. DE and HL end past the word, A = the
; high byte. The debug battle set-up uses it three times to copy the foe monster ids into
; wEncounterMonsters (DebugBattleSetup_Update and DebugBattleSetup_Update_LoadEncounter). (C2,
; E-0374)
; debug battle setup: copies a word from DE to HL (a zero word becomes 1); the following entries
; load the setup into wEncounterMonsters-wEncounterClass and handle input (E-0131)
DebugBattleSetup_CopyMonsterId::
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

SECTION "Bank 01 DebugBattleSetup_Update_LoadEncounter", ROMX

; Copies the debug battle set-up into the encounter: from wWorkBuf + $C, three foes' monster ids
; (wEncounterMonsters), a level (wWildLevel), a band (wWildBand) and a class (wEncounterClass), then
; starts the battle. (C1, E-0357)
DebugBattleSetup_Update_LoadEncounter::
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
    ld [wEncounterClass], a
    jr DebugBattleSetup_Update_StartBattle

SECTION "Bank 01 DebugBattleSetup_Update_HandleInput", ROMX

; Input of the debug battle set-up screen ('? BATTLE ?'): A clears the selected value, B stores the
; foe count and the three monster words and leaves, Up and Down move between the 12 values, Right
; and Left change the selected one by 1 (by 16 with Select held, clamped to its limit). The selected
; value blinks; any change redraws it and the field's description string. (C1, E-0357)
DebugBattleSetup_Update_HandleInput::
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
    call DebugBattleSetup_CopyMonsterId
    call DebugBattleSetup_CopyMonsterId
    call DebugBattleSetup_CopyMonsterId
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
    jr z, .call_debug_battle_setup_wrap_value_after_step
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
    call DebugBattleSetup_WrapValueAfterBigStep
    jr .call_draw_debug_value_hex_for_menu_state

.call_debug_battle_setup_wrap_value_after_step:
    inc de
    call DebugBattleSetup_WrapValueAfterStep

.call_draw_debug_value_hex_for_menu_state:
    call DrawDebugValueHexForMenuState
    jr .clear_frame_counter_lo

.check_joypad_held:
    ld a, [wJoypadHeld]
    bit 2, a
    jr z, .call_debug_battle_setup_wrap_value_after_step2
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
    call DebugBattleSetup_WrapValueAfterBigStep
    jr .call_draw_debug_value_hex_for_menu_state2

.call_debug_battle_setup_wrap_value_after_step2:
    dec de
    call DebugBattleSetup_WrapValueAfterStep

.call_draw_debug_value_hex_for_menu_state2:
    call DrawDebugValueHexForMenuState
    jr .clear_frame_counter_lo

.read_menu_state:
    ld a, [wMenuState]
    ld hl, DebugBattleSetup_Update_HandleInput_Data
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

SECTION "Bank 01 DrawDebugValueHexForMenuState", ROMX

; Draws field wMenuState of the battle set-up: the word wWorkBuf[wMenuState] as three hex digits
; (WriteThreeHexDigitsAtDE) at the BG address DebugBattleSetup_Update_HandleInput_Data[wMenuState]
; (rows 4-15, column 7). DebugBattleSetup_Update_HandleInput calls it after a change and before the
; cursor moves. (C1, E-0374)
; writes the word wWorkBuf[wMenuState] as three hex digits at the address
; DebugBattleSetup_Update_HandleInput_Data[wMenuState] (E-0122)
DrawDebugValueHexForMenuState::
    ld a, [wMenuState]
    ld hl, DebugBattleSetup_Update_HandleInput_Data
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

SECTION "Bank 01 DebugBattleSetup_WrapValueAfterStep", ROMX

; DE = a battle set-up value after a step of 1, HL = where it goes: stores DE at HL when it is at
; most the limit DebugBattleSetup_WrapValueAfterStep_Data[wMenuState] (limit - DE is computed only
; to test its sign); a DE above the limit stores 0, and DE = $FFFF (0 - 1) stores the limit. So
; Right and Left wrap the field between 0 and its limit. (C2, E-0374)
; stores DebugBattleSetup_WrapValueAfterStep_Data[wMenuState] - DE at HL (floored at 0; DE = $FFFF
; stores the limit) (E-0125)
DebugBattleSetup_WrapValueAfterStep::
    push hl
    ld a, [wMenuState]
    ld hl, DebugBattleSetup_WrapValueAfterStep_Data
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

SECTION "Bank 01 DebugBattleSetup_WrapValueAfterBigStep", ROMX

; DE = a battle set-up value after a step of 16 (Select held), HL = where it goes: stores DE at HL
; when it is at most the limit DebugBattleSetup_WrapValueAfterStep_Data[wMenuState]; otherwise a
; negative DE (bit 15 set) stores the limit and a positive one stores 0. It wraps rather than
; clamps. (C2, E-0374)
; clamps the word DE to 0 .. DebugBattleSetup_WrapValueAfterStep_Data[wMenuState] (negative becomes
; the limit) and stores it at HL (E-0124)
DebugBattleSetup_WrapValueAfterBigStep::
    push hl
    ld a, [wMenuState]
    ld hl, DebugBattleSetup_WrapValueAfterStep_Data
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

SECTION "Bank 01 DebugBattleSetup_Update_EnsureSave", ROMX

; Makes sure the debug battle has usable party data. It returns without changes when wPartyCount is
; 1-3, wFarmLevel is below 3 and each of the first wPartyCount bytes of wPartyList is below 10, 20
; or 30 (for wFarmLevel 0, 1 or 2) and, taken as a party slot and mapped through wPartyList a second
; time by DebugBattleSetup_Update_EnsureSave_InParty, names a record whose MON_STATE is 2. Any other
; case far-calls CheckSaveData: hTemp0 = 0 (a valid save) gives one call of RunLoadGameSteps, and
; any other hTemp0 replaces the data with the default debug game
; (DebugBattleSetup_CreateDefaultGame). Called by DebugBattleSetup_Update_StartBattle when wWorkBuf
; + 8 is 0. (C2, E-0384)
DebugBattleSetup_Update_EnsureSave::
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
    call DebugBattleSetup_Update_EnsureSave_InParty
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
    jr nz, .call_debug_battle_setup_create_default_game
    farcall RunLoadGameSteps
    ret

.call_debug_battle_setup_create_default_game:
    call DebugBattleSetup_CreateDefaultGame
    ret

SECTION "Bank 01 DebugBattleSetup_Update_EnsureSave_InParty", ROMX

; Returns Z when party record A has state 2 (MON_STATE). (C2, E-0357; probed E-0374)
DebugBattleSetup_Update_EnsureSave_InParty::
    ld c, MON_STATE
    call SRAMRecordAddressMapped
    ld a, [hl]
    cp $02
    ret

SECTION "Bank 01 DebugBattleSetup_Update_HandleInput_Data", ROMX

; Twelve BG map addresses, $9887, $98A7, ... $99E7 (vBGMap0 rows 4 to 15, column 7, one per row),
; indexed by the field number wMenuState (0-11) of the debug battle set-up screen.
; DebugBattleSetup_Update_HandleInput blinks the selected value there and
; DrawDebugValueHexForMenuState redraws the field value (the word of wWorkBuf + 2 * wMenuState)
; there as three hex digits. (C1, E-0381)
DebugBattleSetup_Update_HandleInput_Data::
    db $87, $98, $a7, $98, $c7, $98, $e7, $98, $07, $99, $27, $99, $47, $99, $67, $99
    db $87, $99, $a7, $99, $c7, $99, $e7, $99

; Twelve little-endian words, indexed by the field number wMenuState (0-11): the largest value each
; battle set-up field may take, $0002, $02AB, $02AB, $02AB, $0001, $0000, $0140, $0063, $0140,
; $0063, $0140, $0063. DebugBattleSetup_WrapValueAfterStep and
; DebugBattleSetup_WrapValueAfterBigStep wrap a value stepped below 0 to this limit and a value
; above the limit to 0. (C1, E-0381)
DebugBattleSetup_WrapValueAfterStep_Data::
    db $02, $00, $ab, $02, $ab, $02, $ab, $02, $01, $00, $00, $00, $40, $01, $63, $00
    db $40, $01, $63, $00, $40, $01, $63, $00

; Draws field wMenuState of the battle set-up from its wWorkBuf word (low byte = index, high byte =
; category), saving and restoring the text window settings: field 0 nothing; fields 1-3 (the
; monsters) the bank $88 string (ShowString_Bank88) in a 9 x 1 window from
; DebugBattleSetupShowFieldString_Data1; field 4 ('Debug') string wWorkBuf + 8 of category 2 in bank
; $2F at vTiles2 + $3C0; field 5 ('Skill ID') string 0 of category 4 of bank $08 (an empty name) at
; vTiles2 + $450; fields 6, 8 and 10 the bank $08 string of category high byte + 2 at
; DebugBattleSetupShowFieldString_Data2; fields 7, 9 and 11 the low byte as two decimal digit tiles
; ($10 + digit) at DebugBattleSetupShowFieldString_Data3. (C1, E-0374)
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

SECTION "Bank 01 DebugBattleSetupShowFieldString_Data1", ROMX

; Three VRAM glyph-tile addresses, vTiles2 + $200, + $2A0 and + $330 ($9200, $92A0, $9330), indexed
; by wMenuState - 1 for fields 1-3 (the three monsters). DebugBattleSetupShowFieldString puts one in
; wTextWindowTileLo/Hi with a window of 9 tiles by 1 row ($0901) before ShowString_Bank88 draws the
; name of the monster there. (C1, E-0381)
DebugBattleSetupShowFieldString_Data1::
    db $00, $92, $a0, $92, $30, $93

; Three VRAM glyph-tile addresses, vTiles2 + $4E0, + $570 and + $600 ($94E0, $9570, $9600), indexed
; by (wMenuState - 6) / 2 for fields 6, 8 and 10. DebugBattleSetupShowFieldString uses each as the 9
; by 1 text window where ShowString_Bank08 draws the string whose index is the low byte of that
; field and whose category is the high byte + 2. (C1, E-0381)
DebugBattleSetupShowFieldString_Data2::
    db $e0, $94, $70, $95, $00, $96

; Three BG map addresses, $996B, $99AB and $99EB (vBGMap0 rows 11, 13 and 15, column 11), indexed by
; (wMenuState - 7) / 2 for fields 7, 9 and 11. DebugBattleSetupShowFieldString writes the low byte
; of that field there as two decimal digit tiles ($10 + tens digit, $10 + ones digit). (C1, E-0381)
DebugBattleSetupShowFieldString_Data3::
    db $6b, $99, $ab, $99, $eb, $99

; DE = VRAM address: writes A as two hex-digit tiles, $10 + high nibble at DE and $10 + low nibble
; at DE + 1, each after WaitForVRAMAccess (interrupts are not disabled); DE ends on the second tile
; and A = its tile. (C1, E-0374)
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

SECTION "Bank 01 WriteThreeHexDigitsAtDE", ROMX

; DE = VRAM address: writes the low nibble of B, then the high and low nibbles of C, as tiles $10 +
; nibble at DE, DE + 1 and DE + 2, each after WaitForVRAMAccess; DE ends on the last tile. Draws
; 12-bit numbers (monster, picture and sprite ids, battle set-up words) on the debug screens. (C1,
; E-0374)
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

SECTION "Bank 01 DebugBattleSetup_CreateDefaultGame", ROMX

; Creates the default debug game: the player at map 0, screen (2, 0), position ($40, $40) with the
; followers on the same spot, a fixed six-glyph player name, 99,999 gold ($01869F), three party
; members (records 0-2), 24 inventory items, 80 tiny medals (wTinyMedals), an empty key list, and 30
; random monster records (DebugBattleSetup_CreateDefaultGame_RandomMonsters). (C2, E-0357; probed
; E-0374)
DebugBattleSetup_CreateDefaultGame::
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
    call DebugBattleSetup_CreateDefaultGame_RandomMonsters
    ret

SECTION "Bank 01 DebugBattleSetup_CreateDefaultGame_RandomMonsters", ROMX

; Fills the debug save with 30 random monsters (PickRandomMonsterSkipping7ETo82 for records 0 to
; $1D), then marks records 0-2 with state 2 (in the party) and the next 27 with state 1. (C2,
; E-0357; probed E-0374)
DebugBattleSetup_CreateDefaultGame_RandomMonsters::
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

SECTION "Bank 01 PickRandomMonsterSkipping7ETo82", ROMX

; Draws table random numbers (NextTableByte) until E = wRandomLo | wRandomHi is neither 0 nor
; $7E-$82, then creates record wBattleArg0 from MonsterTable entry D = 0, E with
; PickRandomMonsterSkipping7ETo82_CreateRecord (random sex and personality, state 1). Only ids 1-$FF
; can come out. DebugBattleSetup_CreateDefaultGame_RandomMonsters calls it for each of 30 records.
; (C2, E-0374)
; draws random ids until one is non-zero and not $7E-$82, then creates that record
; (PickRandomMonsterSkipping7ETo82_CreateRecord) (E-0124)
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
    call PickRandomMonsterSkipping7ETo82_CreateRecord
    ret

SECTION "Bank 01 CreateMonsterRecordInSlot_Build", ROMX

; Builds monster record wBattleArg0 in SRAM from MonsterTable entry DE (LoadMonsterRecord): state
; hTemp3, species, sex (random when wBattleArg1 is $FF, otherwise from
; CreateMonsterRecordOfKindTemp1_LoadMonsterRecord_Data1 by kind), the player as owner, placeholder
; parent names, the template's level (also stored in wRecordBufA + MON_LEVEL), HP (a template value
; of $400 or more becomes 999) and MP, stats and other fields, a random personality word when
; wBattleArg2 is set, the species' family, starting skills, maximum level and resistances; a name
; (random from 14, or from the per-kind table CreateMonsterRecordInSlot_Build_Data2), the experience
; for its level, and the species marked as seen (SetSpeciesFlag). (C2, E-0369; probed E-0374)
CreateMonsterRecordInSlot_Build::
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
    ld hl, CreateMonsterRecordInSlot_Build_Data1
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
    ld a, [wRecordBufferData + $12]
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
    farcall CreateMonsterRecordInSlot_Build_CopyDefaultName
    jr .read_species_id_lo

.skip6:
    push hl
    ld hl, CreateMonsterRecordInSlot_Build_Data2
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
    farcall LoadTableEntryForRecordBufASpeciesToRecordBufAExp
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

SECTION "Bank 01 CopyBBytesDEToHL_Bank01", ROMX

; DE = source, HL = destination, B = count: copies B bytes (B = 0 copies 256); DE and HL end past
; the copy, B = 0. The bank $01 copy of a helper found in 4 banks; CreateMonsterRecordInSlot_Build
; copies the owner name, resistances and default names with it. (C2, E-0374)
; DE = source, HL = destination, B = count: copies B bytes (B = 0 copies 256); DE and HL end past
; the copy; clobbers A, B = 0 (E-0064) (the same 7 bytes appear in 4 banks)
CopyBBytesDEToHL_Bank01::
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, CopyBBytesDEToHL_Bank01
    ret

SECTION "Bank 01 FillBBytesAtHL_Bank01", ROMX

; Stores A in B bytes from HL (B = 0 fills 256); HL ends past the fill, B = 0, A is kept.
; CreateMonsterRecordInSlot_Build uses it to fill $16 bytes with $FF after the starting skills of a
; new record. (C2, E-0374)
; stores A in B bytes from HL (B = 0 fills 256); HL ends past the fill, B = 0 (E-0065) (the same 5
; bytes appear in 2 banks)
FillBBytesAtHL_Bank01::
    ld [hli], a
    dec b
    jr nz, FillBBytesAtHL_Bank01
    ret

SECTION "Bank 01 WriteUnknownNamePlaceholder_Bank01", ROMX

; Writes the placeholder name '???' ($98 three times), seven $F0 bytes and a 0 at HL (11 bytes); HL
; ends past them, A = 0, B = 0. CreateMonsterRecordInSlot_Build calls it twice in a row for the two
; parent names of a new record. (C2, E-0374)
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

SECTION "Bank 01 CreateMonsterRecordOfKindTemp1", ROMX

; Creates a monster record of kind hTemp1 (0-8) in record slot hTemp2 with state hTemp3: enables
; SRAM (bank 0), stores the kind in wBattleArg1, clears wBattleArg2 (no random personality), takes
; the word for the kind from CreateMonsterRecordOfKindTemp1_Data as the MonsterTable entry DE and
; runs CreateMonsterRecordInSlot (slot to wBattleArg0). Kinds 1 and 2 then set MON_EGG of the new
; record to 1 (an egg not yet appraised); SRAM is disabled at the end. Talk events and scenes in
; banks $13, $73 and $85 far-call it. (C2, E-0374)
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
    call CreateMonsterRecordInSlot
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

SECTION "Bank 01 PickRandomMonsterSkipping7ETo82_CreateRecord", ROMX

; The record creation of PickRandomMonsterSkipping7ETo82 for a random monster: wBattleArg1 and
; wBattleArg2 = $FF (random sex and personality), state 1. (C2, E-0357; probed E-0374)
PickRandomMonsterSkipping7ETo82_CreateRecord::
    ld a, $ff
    ld [wBattleArg1], a
    ld [wBattleArg2], a
    ld a, $01
    ldh [hTemp3], a
    ld a, [wBattleArg0]

; Creates the record in slot A (stored in wBattleArg0) with CreateMonsterRecordInSlot_Build.
; CreateMonsterRecordOfKindTemp1 calls it, and PickRandomMonsterSkipping7ETo82_CreateRecord falls
; through into it. (C2, E-0369; probed E-0374)
CreateMonsterRecordInSlot::
    ld [wBattleArg0], a
    call CreateMonsterRecordInSlot_Build
    ret

SECTION "Bank 01 DebugBattleSetup_ClearKeyList", ROMX

; Copies the 128 bytes of DebugBattleSetup_ClearKeyList_Data (all $FF in this ROM) into wKeyList,
; four bytes per pass for 32 passes (B ends 0), so the debug default-game set-up that calls it, just
; before DebugBattleSetup_CreateDefaultGame_RandomMonsters, leaves the key list empty ($FF
; throughout). (C2, E-0374)
; copies 128 bytes (32 four-byte entries) from its table into wKeyList; the table is all $FF in this
; ROM, so the debug battle set-up empties the key list (E-0334: wKeyList reads $FF throughout after
; it) (was DebugBattleSetup_ClearKeyList)
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

SECTION "Bank 01 DebugBattleSetup_ClearKeyList_Data", ROMX

; A block of $80 bytes all $FF: 32 four-byte wKeyList entries filled with the end marker $FF.
; DebugBattleSetup_ClearKeyList copies all of it over wKeyList (32 times 4 bytes) to empty the key
; list. (C1, E-0381)
DebugBattleSetup_ClearKeyList_Data::
    ds $80, $ff

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 20 x 18 tiles, one row per line
DebugSkillViewer_Init_TileRect::
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

CreateMonsterRecordInSlot_Build_Data1::
    db $00, $00, $01, $00, $00, $00, $01, $00, $00

CreateMonsterRecordInSlot_Build_Data2::
    dw CreateMonsterRecordInSlot_Build_Data2_Entry00
    dw CreateMonsterRecordInSlot_Build_Data2_Entry01
    dw CreateMonsterRecordInSlot_Build_Data2_Entry02
    dw CreateMonsterRecordInSlot_Build_Data2_Entry03
    dw CreateMonsterRecordInSlot_Build_Data2_Entry04
    dw CreateMonsterRecordInSlot_Build_Data2_Entry05
    dw CreateMonsterRecordInSlot_Build_Data2_Entry06
    dw CreateMonsterRecordInSlot_Build_Data2_Entry07
    dw CreateMonsterRecordInSlot_Build_Data2_Entry08

CreateMonsterRecordInSlot_Build_Data2_Entry00::
    db $0b, $2c, $2c, $31, $32, $f0, $f0, $f0, $f0, $f0

CreateMonsterRecordInSlot_Build_Data2_Entry01::
    db $0e, $2a, $2a, $f0, $f0, $f0, $f0, $f0, $f0, $f0

CreateMonsterRecordInSlot_Build_Data2_Entry02::
    db $0e, $2a, $2a, $f0, $f0, $f0, $f0, $f0, $f0, $f0

CreateMonsterRecordInSlot_Build_Data2_Entry03::
    db $20, $24, $35, $38, $0b, $f0, $f0, $f0, $f0, $f0

CreateMonsterRecordInSlot_Build_Data2_Entry04::
    db $19, $28, $37, $2c, $0b, $f0, $f0, $f0, $f0, $f0

CreateMonsterRecordInSlot_Build_Data2_Entry05::
    db $1c, $34, $38, $2c, $3d, $f0, $f0, $f0, $f0, $f0

CreateMonsterRecordInSlot_Build_Data2_Entry06::
    db $15, $24, $30, $2c, $24, $f0, $f0, $f0, $f0, $f0

CreateMonsterRecordInSlot_Build_Data2_Entry07::
    db $1c, $24, $37, $30, $24, $f0, $f0, $f0, $f0, $f0

CreateMonsterRecordInSlot_Build_Data2_Entry08::
    db $0b, $35, $24, $25, $32, $f0, $f0, $f0, $f0, $f0
    ds $4a6, $00

DebugResultsDisplay_Update_ShowChild_Data::
    ds $a3b, $00
