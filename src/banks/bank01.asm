SECTION "Bank 01", ROMX[$4000], BANK[$01]
    db $01

; start-up for wGameMode = 0; forcing this mode on the emulator shows: debug menu (E-0029)
; 1 call site from 1 routine (e.g. RunGameModeInit_ToGameMode0_Init)
; writes: wDebugCursor, wDebugValue0, wDebugValue1, wDebugValue2, wDebugValue3, wDebugState, wDebugSubState, wDebugCounter, ...
GameMode0_Init::
Func_001_4001:: ; address name
    ld hl, vTiles1
    ld de, $1007
    call FillTilesRequest
    ld hl, vTiles2
    ld de, $1007
    call FillTilesRequest
    xor a, a
    ld [wDebugCursor], a
    ld [wDebugValue0], a
    ld [wDebugValue1], a
    ld [wDebugValue2], a
    ld [wDebugValue3], a
    ld [wDebugState], a
    ld [wDebugSubState], a
    ld [wDebugCounter], a
    xor a, a
    ld [wDebugByteF6], a
    ld [wDebugByteF7], a
    call DebugMode_InitByModeState
    ld a, $FC
    call StartPaletteFade
    ld a, $03
    ld [wLCDCShadow], a
    ld a, $01
    jp ClearSGBPacketBuffer_CheckLinkMode

; jumps by wModeState to the init routine of each debug screen (menu, map editor, automap, picture viewer, sound test, battle setup, results, staff roll, skill viewer, record viewer, message test)
; 1 call site from 1 routine (e.g. GameMode0_Init)
; reads: wModeState
DebugMode_InitByModeState::
Func_001_4045:: ; address name
    ld a, [wModeState]
    rst $00
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
; no direct call (reached through a table, a jump or a vector)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wTextCursorLo, wTextCursorHi, ...
DebugMessageTest_Init::
Jump_001_4061:: ; address name
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
    xor a, a
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
    ld hl, vBGMap0 + $1C1
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    ld hl, vTiles2 + $200
    ld de, Tiles2Plus200Tiles_1F_4160
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $210
    ld de, Tiles2Plus210Tiles_1F_4130
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $220
    ld de, Tiles1Plus6E0Tiles_1F_4180
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $230
    ld de, Tiles2Plus230Tiles_1F_4190
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $240
    ld de, Tiles2Plus240Tiles_1F_4170
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $250
    ld de, Tiles2Plus250Tiles_1F_41D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a, a
    ld [wDebugCursor], a
    ld [wDebugValue0], a
    ld [wDebugValue1], a
    ld [wDebugValue2], a
    ld [wDebugValue3], a
    ld [wDebugState], a
    ld [wDebugSubState], a
    ld [wDebugCounter], a
    ld a, $01
    ld de, RunBattleActions_StatusChecks_CheckAction_NopRun_Bank01
    ld hl, vBGMap0
    ld bc, $1412
    call CopyRectFromBankToVRAM
    xor a, a
    ld [wMenuState], a
    xor a, a
    ld [wTemp0], a
    ld [wTemp1], a
    xor a, a
    ld [wMenuRowCount], a
    ret

; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
RunBattleActions_StatusChecks_CheckAction_NopRun_Bank01:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 32:7A49; C0
Func_001_412F:: ; address name
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    jr nz, .skip
    dec de
    ld [hl+], a
    inc hl
    nop
    nop
    nop
    nop
    db $10, $10 ; stop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop

.skip:
    nop
    nop
    nop
    nop
    nop
    inc h
    ld e, $25
    ld [hl+], a
    inc hl
    db $10, $00 ; stop
    nop
    nop
    db $10, $10 ; stop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    inc h
    ld e, $25
    ld [hl+], a
    inc hl
    ld de, $0000
    nop
    db $10, $10 ; stop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop

; init for debug-mode state 10: the screen shows the monster record viewer (E-0041)
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
DebugMonsterRecordViewer_Init::
Jump_001_4297:: ; address name
    ld a, $0F
    ld [wStringCategory], a
    ld a, $01
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld a, $01
    ld de, RunBattleActions_StatusChecks_CheckAction_NopRun_01_42BC
    ld hl, vBGMap0
    ld bc, $1412
    call CopyRectFromBankToVRAM
    ld hl, $0000
    call DebugShowMonsterRecord
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wStringCategory, wStringIndex, rVBK
; points at: wDebugCursor
RunBattleActions_StatusChecks_CheckAction_NopRun_01_42BC:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 32:7A49; C0
Func_001_42BC:: ; address name
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld de, $4140
    ld b, d
    ld b, e
    ld b, h
    ld b, l
    ld b, [hl]
    ld b, a
    ld c, b
    nop
    nop
    nop
    nop
    ld [de], a
    inc de
    inc d
    dec d
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    rla
    dec d
    jr .skip

.skip:
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    rrca
    ld a, [de]
    dec de
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    inc e
    add hl, de
    dec e
    add hl, de
    dec d
    ld e, $1F
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    jr nz, .skip2
    ld [hl+], a
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    inc hl
    inc h
    dec h
    inc h
    ld h, $27
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop

.skip2:
    nop
    nop
    nop
    nop
    nop
    inc hl
    inc h
    dec h
    inc h
    jr z, .next
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    add hl, hl
    ld d, $2A
    dec hl
    ld e, $2C
    dec d
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld [de], a
    inc de
    dec l
    ld e, $2C

.next:
    dec d
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld l, $2F
    jr nc, .skip3
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    add hl, de
    ld [de], a
    add hl, hl
    inc hl
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop

.skip3:
    nop
    ld sp, $1916
    inc hl
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    ld [de], a
    ld e, $2C
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    inc sp
    inc [hl]
    inc h
    jr nc, .skip4
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    jr nc, DebugSkillViewer_Init_Skip
    dec hl
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop

.skip4:
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop

; init for debug-mode state 9: the screen shows the skill viewer (E-0041)
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wStringCategory, wStringIndex, rVBK
; points at: wDebugCursor
DebugSkillViewer_Init::
Jump_001_4424:: ; address name
    ld a, $0F
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    farcall ShowString_Bank08

DebugSkillViewer_Init_Skip::
Jump_001_4434:: ; address name
    ld a, $01
    ld de, TileRect_01_6F30
    ld hl, vBGMap0
    ld bc, $1412
    call CopyRectFromBankToVRAM
    ld a, [wIsCGB]
    or a, a
    jr z, .skip
    ld a, $01
    ldh [rVBK], a
    xor a, a
    ld hl, vBGMap0
    ld bc, $0400
    call FillBytes
    ld a, $00
    ldh [rVBK], a

.skip:
    xor a, a
    ld hl, wDebugCursor
    ld [hl+], a
    dec a
    ld [hl], a
    ret

; init for debug-mode state 8: the screen shows the staff roll (SCENARIO & GAME DESIGNERS, YUJI HORII, ENIX, TOSE, FUMINORI ISHIKAWA) (E-0041)
; no direct call (reached through a table, a jump or a vector)
; points at: wWorkBuf
DebugStaffRoll_Init::
Jump_001_4462:: ; address name
    ld a, $31
    call QueueMusic
    xor a, a
    ld hl, wWorkBuf
    ld bc, $0038
    call FillBytes
    ret

; init for debug-mode state 7: the screen shows 'RESULTS DISPLAY' (species, gender) (E-0041)
; no direct call (reached through a table, a jump or a vector)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wArg1, wDebugCursor, ...
; points at: wScreenState
DebugResultsDisplay_Init::
Jump_001_4472:: ; address name
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
    xor a, a
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
    xor a, a
    ld [wStringCategory], a
    ld a, $27
    ld [wStringIndex], a ; 'RESULTS DISPLAY Species Gender'
    farcall ShowString_Bank1B_4C94
    ld hl, vBGMap0 + $60
    ld bc, $1001
    ld a, $80
    call FillRectWithTileSequence
    ld hl, vBGMap0 + $A0
    ld bc, $1004
    ld a, $90
    call FillRectWithTileSequence
    ld hl, vBGMap0 + $120
    ld bc, $1002
    ld a, $B0
    call FillRectWithTileSequence
    ld a, $FC
    ld [vBGMap0 + $181], a
    ld [vBGMap0 + $1E1], a
    ld [vBGMap0 + $1], a
    ld a, $FD
    ld [vBGMap0 + $1A1], a
    ld [vBGMap0 + $201], a
    ld [vBGMap0 + $21], a
    ld a, $FB
    ld [vBGMap0 + $1C1], a
    ld [vBGMap0 + $221], a
    ld de, Tiles1Plus7E0Tiles_1F_4A80
    ld hl, vTiles1 + $7E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus7F0Tiles_1F_4A90
    ld hl, vTiles1 + $7F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus7C0Tiles_1F_4780
    ld hl, vTiles1 + $7C0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, DebugResultsDisplay_Init_Data
    ld hl, vTiles1 + $7C0
    ld b, $1F
    ld c, $10
    call OrFromBankWaitVRAM
    ld de, Tiles2Plus200Tiles_1F_4160
    ld hl, vTiles1 + $7D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus7B0Tiles_1F_4480
    ld hl, vTiles1 + $7B0
    ld b, $1F
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
    ld hl, vBGMap0 + $8A
    ld bc, $0901
    ld a, $20
    call FillRectWithTileSequence
    ld hl, vBGMap0 + $EA
    ld bc, $0901
    ld a, $30
    call FillRectWithTileSequence
    ld hl, vBGMap0 + $12A
    ld bc, $0901
    ld a, $40
    call FillRectWithTileSequence
    ld hl, vBGMap0 + $AA
    ld bc, $0901
    ld a, $50
    call FillRectWithTileSequence
    xor a, a
    ld [wArg1], a
    add a, $10
    ld [vBGMap0 + $81], a
    xor a, a
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
    xor a, a
    ld [wScreenState], a
    dec b
    jr nz, .loop
    ret

; init for debug-mode state 0: the screen shows the debug menu (E-0041)
; no direct call (reached through a table, a jump or a vector)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex
DebugMainMenu_Init::
Jump_001_45EA:: ; address name
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
    xor a, a
    ld [wStringCategory], a
    ld a, $01
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vBGMap0 + $A3
    ld bc, $1002
    ld a, $80
    call FillRectWithTileSequence
    ret

; init for debug-mode state 2: the screen shows '? EDIT ?' (world, map number, position) (E-0041)
; no direct call (reached through a table, a jump or a vector)
; reads: hMapId, hMapScreenX, hPlayerX, hMapScreenY, hPlayerY
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wDebugCursor, wDebugValue0, ...
DebugMapEditor_Init::
Jump_001_461E:: ; address name
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
    xor a, a
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
    xor a, a
    ld [wStringCategory], a
    ld a, $02
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vBGMap0 + $A3
    ld bc, $1007
    ld a, $80
    call FillRectWithTileSequence
    ld a, $01
    ld de, TileRect_01_46A4
    ld hl, vBGMap0 + $EA
    ld bc, $1001
    call CopyRectFromBankToVRAM
    xor a, a
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

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 16 x 1 tiles, one row per line
TileRect_01_46A4::
Data_001_46A4:: ; address name
    db $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F ; id 0

; init for debug-mode state 3: the screen shows '? AUTOMAP ?' (key, level, position) (E-0041)
; no direct call (reached through a table, a jump or a vector)
; reads: wCurrentKeyIndex, hMapScreenX, hMapScreenY
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wDebugCursor, wDebugValue0, ...
DebugAutomap_Init::
Jump_001_46B4:: ; address name
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
    xor a, a
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
    xor a, a
    ld [wStringCategory], a
    ld a, $04
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vBGMap0 + $A3
    ld bc, $1007
    ld a, $80
    call FillRectWithTileSequence
    ld a, $01
    ld de, TileRect_01_4733
    ld hl, vBGMap0 + $EA
    ld bc, $1001
    call CopyRectFromBankToVRAM
    xor a, a
    ld [wDebugCursor], a
    ld a, [wCurrentKeyIndex]
    push af
    call LoadKeyEntryFieldsToDebugState
    pop af
    or a, $80
    ld [wDebugValue0], a
    ldh a, [hMapScreenX]
    ld [wDebugValue2], a
    ldh a, [hMapScreenY]
    ld [wDebugValue3], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 16 x 1 tiles, one row per line
TileRect_01_4733::
Data_001_4733:: ; address name
    db $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F ; id 0

; init for debug-mode state 4: the screen shows 'MONSTER BGSD CHARA': monster picture and sprite viewer (E-0041)
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wDebugValue0, wDebugValue1, ...
DebugMonsterPictureViewer_Init::
Jump_001_4743:: ; address name
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
    xor a, a
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
    xor a, a
    ld [wStringCategory], a
    ld a, $03
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vBGMap0 + $A3
    ld bc, $1002
    ld a, $80
    call FillRectWithTileSequence
    ld a, $01
    ld de, TileRect_01_47DE
    ld hl, vBGMap0 + $124
    ld bc, $0606
    call CopyRectFromBankToVRAM
    ld a, [wIsCGB]
    or a, a
    jr z, .set_debug_value0_to_00
    ld c, $4F
    ld a, $01
    ldh [c], a
    ld a, $01
    ld de, TileRect_01_4802
    ld hl, vBGMap0 + $124
    ld bc, $0606
    call CopyRectFromBankToVRAM
    ld c, $4F
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

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 6 tiles, one row per line
TileRect_01_47DE::
Data_001_47DE:: ; address name
    db $20, $21, $22, $23, $24, $25 ; id 0
    db $26, $27, $28, $29, $2A, $2B ; id 1
    db $2C, $2D, $2E, $2F, $30, $31 ; id 2
    db $32, $33, $34, $35, $36, $37 ; id 3
    db $38, $39, $3A, $3B, $3C, $3D ; id 4
    db $3E, $3F, $40, $41, $42, $43 ; id 5

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 6 tiles, one row per line
TileRect_01_4802::
Data_001_4802:: ; address name
    db $01, $01, $01, $01, $01, $01 ; id 0
    db $01, $01, $01, $01, $01, $01 ; id 1
    db $01, $01, $01, $01, $01, $01 ; id 2
    db $01, $01, $01, $01, $01, $01 ; id 3
    db $01, $01, $01, $01, $01, $01 ; id 4
    db $01, $01, $01, $01, $01, $01 ; id 5

; init for debug-mode state 5: the screen shows '? SOUND ?' (BGM, SE) (E-0041)
; no direct call (reached through a table, a jump or a vector)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wMenuState, wTemp0, ...
DebugSoundTest_Init::
Jump_001_4826:: ; address name
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
    xor a, a
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
    xor a, a
    ld [wStringCategory], a
    ld a, $06
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld a, $01
    ld de, TileRect_01_488A
    ld hl, vBGMap0 + $A3
    ld bc, $0B04
    call CopyRectFromBankToVRAM
    xor a, a
    ld [wMenuState], a
    xor a, a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 11 x 4 tiles, one row per line
TileRect_01_488A::
Data_001_488A:: ; address name
    db $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A ; id 0
    db $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $9A ; id 1
    db $A0, $A1, $A2, $A3, $A4, $A5, $10, $10, $A8, $10, $12 ; id 2
    db $B0, $B1, $B2, $B3, $B4, $B5, $10, $10, $B8, $10, $10 ; id 3

; init for debug-mode state 6: the screen shows '? BATTLE ?' (number of foes, three monsters, skill, levels) (E-0041)
; no direct call (reached through a table, a jump or a vector)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wMenuState
; points at: wWorkBuf
DebugBattleSetup_Init::
Jump_001_48B6:: ; address name
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
    xor a, a
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld hl, vTiles1
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0B09
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    xor a, a
    ld [wStringCategory], a
    ld a, $09
    ld [wStringIndex], a
    farcall ShowString_Bank08
    ld a, $01
    ld de, TileRect_01_495D
    ld hl, vBGMap0 + $40
    ld bc, $140E
    call CopyRectFromBankToVRAM
    xor a, a
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
    ld a, $0A
    ld [wMenuState], a
    call DebugBattleSetupShowFieldString
    xor a, a
    ld [wMenuState], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 20 x 14 tiles, one row per line
TileRect_01_495D::
Data_001_495D:: ; address name
    db $00, $00, $00, $00, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $00, $00, $00, $00, $00 ; id 0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 1
    db $8B, $8C, $8D, $8E, $8F, $90, $91, $10, $10, $10, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 2
    db $96, $97, $98, $99, $9A, $9B, $9C, $10, $10, $10, $A0, $20, $21, $22, $23, $24, $25, $26, $27, $28 ; id 3
    db $A1, $A2, $A3, $A4, $A5, $A6, $A7, $10, $10, $10, $AB, $2A, $2B, $2C, $2D, $2E, $2F, $30, $31, $32 ; id 4
    db $AC, $AD, $AE, $AF, $B0, $B1, $B2, $10, $10, $10, $B6, $33, $34, $35, $36, $37, $38, $39, $3A, $3B ; id 5
    db $B7, $B8, $B9, $BA, $BB, $BC, $BD, $10, $10, $10, $C1, $3C, $3D, $3E, $3F, $40, $41, $42, $43, $44 ; id 6
    db $C2, $C3, $C4, $C5, $C6, $C7, $C8, $10, $10, $10, $CC, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D ; id 7
    db $CD, $CE, $CF, $D0, $D1, $D2, $D3, $10, $10, $10, $D7, $4E, $4F, $50, $51, $52, $53, $54, $55, $56 ; id 8
    db $D8, $D9, $DA, $DB, $DC, $DD, $DE, $10, $10, $10, $E2, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 9
    db $CD, $CE, $CF, $D0, $D1, $D2, $D3, $10, $10, $10, $D7, $57, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F ; id 10
    db $D8, $D9, $DA, $DB, $DC, $DD, $DE, $10, $10, $10, $E2, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 11
    db $CD, $CE, $CF, $D0, $D1, $D2, $D3, $10, $10, $10, $D7, $60, $61, $62, $63, $64, $65, $66, $67, $68 ; id 12
    db $D8, $D9, $DA, $DB, $DC, $DD, $DE, $10, $10, $10, $E2, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 13

; A = first tile, B = width, C = rows, HL = BG map address (rows 32 apart): writes consecutive tile numbers A, A + 1, ... row by row; on CGB then zero-fills the $240 bytes at vBGMap0 in VRAM bank 1 (all attributes 0, regardless of the rectangle) (E-0073)
; 11 call sites from 5 routines (e.g. DebugResultsDisplay_Init, DebugMonsterPictureViewer_Init, DebugAutomap_Init, DebugMapEditor_Init, ...)
; reads: wIsCGB
FillRectWithTileSequence::
Func_001_4A75:: ; address name
    push hl
    ld d, b

.loop:
    ld [hl+], a
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
    or a, a
    ret z
    ld c, $4F
    ld a, $01
    ldh [c], a
    ld hl, vBGMap0
    ld bc, $0240
    xor a, a
    call FillBytes
    ld c, $4F
    ld a, $00
    ldh [c], a
    ret

; on CGB copies the 8-byte palette Data_001_4ACC into wBGPaletteBuffer twice and sets wC526 and wC527 = $7F (E-0117)
; 7 call sites from 7 routines (e.g. DebugMessageTest_Init, DebugResultsDisplay_Init, DebugMainMenu_Init, GameMode5_Init_SendSGBPaletteSetPacket, ...)
; reads: wIsCGB
; writes: wBGPaletteUploadRequest, wOBJPaletteUploadRequest
; points at: wBGPaletteBuffer
LoadPalette0FromData4ACC::
Func_001_4AA4:: ; address name
    ld a, [wIsCGB]
    or a, a
    ret z
    ld de, LoadPalette0FromData4ACC_Data
    ld hl, wBGPaletteBuffer
    ld bc, $0008
    call CopyBytesDEToHL_Bank00
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    ld de, LoadPalette0FromData4ACC_Data
    ld hl, wBGPaletteBuffer
    ld bc, $0008
    call CopyBytesDEToHL_Bank00
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ret

; address loaded by LoadPalette0FromData4ACC
LoadPalette0FromData4ACC_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_001_4ACC:: ; address name
    db $4D, $5E, $FF, $7F, $F2, $66, $00, $00

; per-frame routine for wGameMode = 0
; 1 call site from 1 routine (e.g. RunGameModeUpdate_ToGameMode0_Update)
; reads: wModeState
GameMode0_Update::
Func_001_4AD4:: ; address name
    ld a, [wModeState]
    rst $00
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
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wJoypadPressed, wMenuRowCount, wTemp1, wTemp0, wJoypadPressedRepeat, wMenuState, wFrameCounterLo
; writes: wStringIndex, wStringCategory, wTextWindowRows, wTextWindowWidth, wTextWindowTileLo, wTextWindowTileHi, wMenuState, wModeState
; points at: wTemp0, wModeChangeRequest
DebugMessageTest_Update::
Jump_001_4AF0:: ; address name
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld a, [wJoypadPressed]
    and a, $01
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
    rst $00
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

; entry 0 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank08::
Jump_001_4B68:: ; address name
    farcall BeginStringDisplay_Bank08
    ret

; entry 1 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank09::
Jump_001_4B6F:: ; address name
    farcall BeginStringDisplay_Bank09
    ret

; entry 2 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank28::
Jump_001_4B76:: ; address name
    farcall BeginStringDisplay_Bank28
    ret

; entry 3 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank29::
Jump_001_4B7D:: ; address name
    farcall BeginStringDisplay_Bank29
    ret

; entry 4 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank2A::
Jump_001_4B84:: ; address name
    farcall BeginStringDisplay_Bank2A
    ret

; entry 5 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank2B::
Jump_001_4B8B:: ; address name
    farcall BeginStringDisplay_Bank2B
    ret

; entry 6 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank2C::
Jump_001_4B92:: ; address name
    farcall BeginStringDisplay_Bank2C
    ret

; entry 7 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank2D::
Jump_001_4B99:: ; address name
    farcall BeginStringDisplay_Bank2D
    ret

; entry 8 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank2E::
Jump_001_4BA0:: ; address name
    farcall BeginStringDisplay_Bank2E
    ret

; entry 9 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank7C::
Jump_001_4BA7:: ; address name
    farcall BeginStringDisplay_Bank7C
    ret

; entry 10 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank80::
Jump_001_4BAE:: ; address name
    farcall BeginStringDisplay_Bank80
    ret

; entry 11 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank82::
Jump_001_4BB5:: ; address name
    farcall BeginStringDisplay_Bank82
    ret

; entry 12 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank86::
Jump_001_4BBC:: ; address name
    farcall BeginStringDisplay_Bank86
    ret

; entry 13 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank89::
Jump_001_4BC3:: ; address name
    farcall BeginStringDisplay_Bank89
    ret

; entry 14 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank07::
Jump_001_4BCA:: ; address name
    farcall BeginStringDisplay_Bank07
    ret

; entry 15 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank2F::
Jump_001_4BD1:: ; address name
    farcall BeginStringDisplay_Bank2F
    ret

; entry 16 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank37::
Jump_001_4BD8:: ; address name
    farcall BeginStringDisplay_Bank37
    ret

; entry 17 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank88::
Jump_001_4BDF:: ; address name
    farcall BeginStringDisplay_Bank88
    ret

; entry 18 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank83::
Jump_001_4BE6:: ; address name
    farcall BeginStringDisplay_Bank83
    ret

; entry 19 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank1D::
Jump_001_4BED:: ; address name
    farcall BeginStringDisplay_Bank1D
    ret

; entry 20 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank8A::
Jump_001_4BF4:: ; address name
    farcall BeginStringDisplay_Bank8A
    ret

; entry 21 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_BankF0_4001::
Jump_001_4BFB:: ; address name
    farcall BeginStringDisplay_BankF0_4001
    ret

; entry 22 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank1B_4C86::
Jump_001_4C02:: ; address name
    farcall BeginStringDisplay_Bank1B_4C86
    ret

; entry 23 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank1F::
Jump_001_4C09:: ; address name
    farcall BeginStringDisplay_Bank1F
    ret

; entry 24 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_BankF0_48A0::
Jump_001_4C10:: ; address name
    farcall BeginStringDisplay_BankF0_48A0
    ret

; entry 25 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank0D::
Jump_001_4C17:: ; address name
    farcall BeginStringDisplay_Bank0D
    ret

; entry 26 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank33_6490::
Jump_001_4C1E:: ; address name
    farcall BeginStringDisplay_Bank33_6490
    ret

; entry 27 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank24::
Jump_001_4C25:: ; address name
    farcall BeginStringDisplay_Bank24
    ret

; entry 28 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_CallUpdate_Case1C_Sub01_BeginStringDisplay::
Jump_001_4C2C:: ; address name
    farcall DebugMessageTest_Update_Case1C_Sub01_BeginStringDisplay_Sub01
    ret

; entry 29 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank0E::
Jump_001_4C33:: ; address name
    farcall BeginStringDisplay_Bank0E
    ret

; entry 30 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_BankF2::
Jump_001_4C3A:: ; address name
    farcall BeginStringDisplay_BankF2
    ret

; entry 31 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank33_7037::
Jump_001_4C41:: ; address name
    farcall BeginStringDisplay_Bank33_7037
    ret

; entry 32 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank0B::
Jump_001_4C48:: ; address name
    farcall BeginStringDisplay_Bank0B
    ret

; entry 33 of the `rst $00` table in DebugMessageTest_Update
; no direct call (reached through a table, a jump or a vector)
DebugMessageTest_Update_ToBeginStringDisplay_Bank1B_480C::
Jump_001_4C4F:: ; address name
    farcall BeginStringDisplay_Bank1B_480C
    ret

DebugMessageTest_Update_ToBeginStringDisplay_Bank1B_480C_CheckJoypadPressedRepeat::
Jump_001_4C56:: ; address name
    ld a, [wJoypadPressedRepeat]
    and a, $40
    jr z, .check_joypad_pressed_repeat
    ld a, [wMenuState]
    cp a, $00
    call z, DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE
    ld a, [wMenuState]
    cp a, $01
    call z, DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub02
    ld a, [wMenuState]
    cp a, $02
    call z, DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub03
    ld a, [wMenuState]
    sub a, $01
    jr nc, .set_menu_state
    ld a, $02

.set_menu_state:
    ld [wMenuState], a
    ld a, $69
    call QueueSoundEffect

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and a, $80
    jr z, .read_menu_state
    ld a, [wMenuState]
    cp a, $00
    call z, DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE
    ld a, [wMenuState]
    cp a, $01
    call z, DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub02
    ld a, [wMenuState]
    cp a, $02
    call z, DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub03
    ld a, [wMenuState]
    add a, $01
    cp a, $03
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
    and a, $10
    jr z, .check_joypad_pressed_repeat2
    inc [hl]
    call DebugMessageTest_Update_Case21_WriteTemp1AndMenuRowCount
    jr .call_queue_sound_effect

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    and a, $20
    jr z, .check_joypad_pressed
    dec [hl]
    call DebugMessageTest_Update_Case21_WriteTemp1AndMenuRowCount
    jr .call_queue_sound_effect

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and a, $08
    jr z, .check_joypad_pressed2
    xor a, a
    ld [hl], a

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuState]
    ld b, $21
    cp a, $00
    call z, DebugMessageTest_Update_Case21_ReadMenuStateAndTemp0Etc
    ld a, [wTemp0]
    add a, a
    ld hl, DebugMessageTestTable
    add_a_to_hl
    push hl
    inc hl
    ld a, [hl]
    pop hl
    cp a, $00
    jr z, .check_menu_state
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [de]

.check_menu_state:
    ld b, a
    ld a, [wMenuState]
    cp a, $01
    call z, DebugMessageTest_Update_Case21_ReadMenuStateAndTemp0Etc
    ld a, [wTemp0]
    add a, a
    ld hl, DebugMessageTestTable
    add_a_to_hl
    push hl
    inc hl
    ld a, [hl]
    pop hl
    cp a, $00
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
    cp a, $02
    call z, DebugMessageTest_Update_Case21_ReadMenuStateAndTemp0Etc

.check_joypad_pressed2:
    ld a, [wJoypadPressed]
    and a, $02
    jr z, .check_menu_state3
    xor a, a
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.check_menu_state3:
    ld a, [wMenuState]
    cp a, $00
    jr nz, DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_CheckMenuState
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE
    xor a, a
    ld hl, vBGMap0 + $6D
    call WriteVRAMByteInc
    call WriteVRAMByte
    jr DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub03_CheckMenuState

; only called from DebugMessageTest_Update_Case21 (E-0047)
; 2 call sites from 1 routine (e.g. DebugMessageTest_Update_ToBeginStringDisplay_Bank1B_480C)
; reads: wTemp0, wMenuState, wTemp1, wMenuRowCount
DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE::
Func_001_4D6E:: ; address name
    ld a, [wTemp0]
    ld de, vBGMap0 + $6D
    call WriteHexByteTilesAtDE
    jr DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub03_CheckMenuState

DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_CheckMenuState::
Jump_001_4D79:: ; address name
    ld a, [wMenuState]
    cp a, $01
    jr nz, DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub02_CheckFrameCounterLo
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub02
    xor a, a
    ld hl, vBGMap0 + $AD
    call WriteVRAMByteInc
    call WriteVRAMByte
    jr DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub03_CheckMenuState

; only called from DebugMessageTest_Update_Case21 (E-0047)
; 2 call sites from 1 routine (e.g. DebugMessageTest_Update_ToBeginStringDisplay_Bank1B_480C)
; reads: wTemp1, wMenuState, wTemp0, wMenuRowCount
DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub02::
Func_001_4D93:: ; address name
    ld a, [wTemp1]
    ld de, vBGMap0 + $AD
    call WriteHexByteTilesAtDE
    jr DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub03_CheckMenuState

DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub02_CheckFrameCounterLo::
Jump_001_4D9E:: ; address name
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub03
    xor a, a
    ld hl, vBGMap0 + $ED
    call WriteVRAMByteInc
    call WriteVRAMByte
    jr DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub03_CheckMenuState

; only called from DebugMessageTest_Update_Case21 (E-0047)
; 2 call sites from 1 routine (e.g. DebugMessageTest_Update_ToBeginStringDisplay_Bank1B_480C)
; reads: wMenuRowCount, wMenuState, wTemp0, wTemp1
DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub03::
Func_001_4DB1:: ; address name
    ld a, [wMenuRowCount]
    ld de, vBGMap0 + $ED
    call WriteHexByteTilesAtDE
    jr DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub03_CheckMenuState

DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub03_CheckMenuState::
Jump_001_4DBC:: ; address name
    ld a, [wMenuState]
    cp a, $00
    jr z, .check_menu_state
    ld a, [wTemp0]
    ld de, vBGMap0 + $6D
    call WriteHexByteTilesAtDE

.check_menu_state:
    ld a, [wMenuState]
    cp a, $01
    jr z, .check_menu_state2
    ld a, [wTemp1]
    ld de, vBGMap0 + $AD
    call WriteHexByteTilesAtDE

.check_menu_state2:
    ld a, [wMenuState]
    cp a, $02
    jr z, .return
    ld a, [wMenuRowCount]
    ld de, vBGMap0 + $ED
    call WriteHexByteTilesAtDE

.return:
    ret

; only called from DebugMessageTest_Update_Case21 (E-0047)
; 3 call sites from 1 routine (e.g. DebugMessageTest_Update_ToBeginStringDisplay_Bank1B_480C)
; reads: wMenuState, wTemp0, wTemp1, wMenuRowCount
; points at: wTemp0
DebugMessageTest_Update_Case21_ReadMenuStateAndTemp0Etc::
Func_001_4DED:: ; address name
    push af
    ld a, [wMenuState]
    ld hl, wTemp0
    add_a_to_hl
    ld a, b
    cp a, $FF
    jr z, .check_menu_state
    ld a, [hl]
    inc b
    cp a, b
    jr nz, .next
    ld [hl], $00

.next:
    dec b
    ld a, [hl]
    cp a, $FF
    jr nz, .check_menu_state
    ld [hl], b

.check_menu_state:
    ld a, [wMenuState]
    cp a, $00
    jr nz, .check_menu_state2
    ld de, vBGMap0 + $6D
    ld a, [wTemp0]
    jr .call_write_hex_byte_tiles_at_de

.check_menu_state2:
    ld a, [wMenuState]
    cp a, $01
    jr nz, .read_menu_row_count
    ld de, vBGMap0 + $AD
    ld a, [wTemp1]
    jr .call_write_hex_byte_tiles_at_de

.read_menu_row_count:
    ld de, vBGMap0 + $ED
    ld a, [wMenuRowCount]

.call_write_hex_byte_tiles_at_de:
    add_a_to_hl
    ld a, [hl]
    call WriteHexByteTilesAtDE
    pop af
    ret

; only called from DebugMessageTest_Update_Case21 (E-0047)
; 2 call sites from 1 routine (e.g. DebugMessageTest_Update_ToBeginStringDisplay_Bank1B_480C)
; reads: wMenuState
; writes: wTemp1, wMenuRowCount
DebugMessageTest_Update_Case21_WriteTemp1AndMenuRowCount::
Func_001_4E3B:: ; address name
    ld a, [wMenuState]
    cp a, $00
    jr nz, .cp_01
    xor a, a
    ld [wTemp1], a
    xor a, a
    ld [wMenuRowCount], a
    ret

.cp_01:
    cp a, $01
    jr nz, .return
    xor a, a
    ld [wMenuRowCount], a

.return:
    ret

; E-0233 (C1: DebugMessageTest_Update_Case21 reads the word at $4E54 + 2 * wTemp0; a zero high byte takes the value directly, otherwise the word points at a sub-list (the bytes from $4E98 on); 34 words up to the first sub-list).
; record: value (high byte 0) or pointer to a sub-list
DebugMessageTestTable::
Data_001_4E54:: ; address name
    dw $4E98 ; id 0
    dw $4EAE ; id 1
    dw $00FF ; id 2
    dw $00D4 ; id 3
    dw $00EF ; id 4
    dw $00C2 ; id 5
    dw $00D2 ; id 6
    dw $00FF ; id 7
    dw $00DD ; id 8
    dw $00EF ; id 9
    dw $00FF ; id 10
    dw $00C3 ; id 11
    dw $00FE ; id 12
    dw $00F8 ; id 13
    dw $4EB9 ; id 14
    dw $4EC1 ; id 15
    dw $4EC8 ; id 16
    dw $4ECB ; id 17
    dw $00F1 ; id 18
    dw $0017 ; id 19
    dw $002A ; id 20
    dw $002F ; id 21
    dw $0029 ; id 22
    dw $003F ; id 23
    dw $0022 ; id 24
    dw $002F ; id 25
    dw $0036 ; id 26
    dw $0015 ; id 27
    dw $009F ; id 28
    dw $0016 ; id 29
    dw $0023 ; id 30
    dw $0012 ; id 31
    dw $4ECF ; id 32
    dw $0027 ; id 33

; E-0233 (C1: the sub-lists that DebugMessageTestTable's pointer words name ($4E98, $4EAE, $4EB9, $4EC1, $4EC8, $4ECB, $4ECF); their format is not read).
; record: sub-lists named by DebugMessageTestTable
DebugMessageTestSubLists::
Data_001_4E98:: ; address name
    db $14, $FF, $10, $FF, $7F, $DF, $6F, $6F, $27, $0D, $AF, $00, $23, $00, $06, $05, $01, $08, $0A, $1B, $07, $03, $09, $02, $19, $09, $57, $00, $53, $0C, $0D, $00, $21, $06, $06, $05, $00, $06, $02, $1A, $08, $05, $85, $FC, $03, $00, $00, $21, $01, $35, $1F, $02, $FF, $FF, $FF, $02, $FF, $84, $0A, $C9 ; entry 0

; update for debug-mode state 10: the screen shows the monster record viewer (E-0041)
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wJoypadPressedRepeat, wJoypadHeld, wDebugCursor, wDebugValue0, wMonsterId, wTextWindowTileLo, wTextWindowTileHi, ...
; writes: wGameMode, wModeState, wDebugCursor, wDebugValue0, wMonsterId, wStringCategory, wStringIndex, wTextWindowTileLo, ...
; points at: wModeChangeRequest
DebugMonsterRecordViewer_Update::
Jump_001_4ED4:: ; address name
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_joypad_pressed_repeat
    xor a, a
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
    sub a, $01
    ld [wDebugCursor], a
    ld a, [wDebugValue0]
    sbc a, $00
    ld [wDebugValue0], a
    jr .read_debug_cursor2

.read_debug_cursor:
    ld a, [wDebugCursor]
    ld l, a
    ld a, [wDebugValue0]
    ld h, a
    ld a, l
    sub a, $10
    ld l, a
    ld a, h
    sbc a, $00
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
    ld bc, $02AB
    call CompareHLToBC
    jr c, DebugShowMonsterRecord
    ld hl, $02AB
    jr DebugShowMonsterRecord

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    bit 4, a
    jp z, DebugShowMonsterRecord_Return
    ld a, [wJoypadHeld]
    bit 2, a
    jr nz, .read_debug_cursor3
    ld a, [wDebugCursor]
    add a, $01
    ld [wDebugCursor], a
    ld a, [wDebugValue0]
    adc a, $00
    ld [wDebugValue0], a
    jr .read_debug_cursor4

.read_debug_cursor3:
    ld a, [wDebugCursor]
    ld l, a
    ld a, [wDebugValue0]
    ld h, a
    ld a, l
    add a, $10
    ld l, a
    ld a, h
    adc a, $00
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
    ld bc, $02AB
    call CompareHLToBC
    jr c, DebugShowMonsterRecord
    ld hl, $0000

; HL = monster id (the debug monster viewer wraps it at $02AB): stores it in wC5F8/wC5F9 and wMonsterId/wCFE7, loads the record with LoadMonsterRecord and draws the id, the name (string bank $88, category = id high byte, index = id low byte) and the record's fields on the debug screen
; 1 call site from 1 routine (e.g. DebugMonsterRecordViewer_Init)
; reads: wMonsterId, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wRecordBuffer, wRecordBufferData, wScreenAttrBuffer
; writes: wDebugCursor, wDebugValue0, wMonsterId, wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, ...
DebugShowMonsterRecord::
Func_001_4F80:: ; address name
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
    ld hl, vBGMap0 + $4F
    ld bc, $0100
    call WriteHexByteTilesAtHL
    ld a, [wRecordBuffer + $1]
    ld hl, vBGMap0 + $4F
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
    ld hl, vBGMap0 + $8D
    ld bc, $0100
    call DebugShowMonsterRecord_Number24ToPackedBCD
    ld a, [wRecordBufferData + $6]
    ld hl, vBGMap0 + $AF
    ld bc, $0100
    call WriteDecimalByteTiles_Bank01
    ld a, [wRecordBufferData + $7]
    ld hl, vBGMap0 + $CF
    ld bc, $0100
    call WriteDecimalByteTiles_Bank01
    ld a, [wRecordBufferData + $8]
    ld e, a
    ld a, [wRecordBufferData + $9]
    ld d, a
    ld hl, vBGMap0 + $ED
    ld bc, $0100
    call DebugShowMonsterRecord_Number24ToPackedBCD
    ld a, [wRecordBufferData + $A]
    ld e, a
    ld a, [wRecordBufferData + $B]
    ld d, a
    ld hl, vBGMap0 + $10D
    ld bc, $0100
    call DebugShowMonsterRecord_Number24ToPackedBCD
    ld a, [wRecordBufferData + $C]
    ld e, a
    ld a, [wRecordBufferData + $D]
    ld d, a
    ld hl, vBGMap0 + $12D
    ld bc, $0100
    call DebugShowMonsterRecord_Number24ToPackedBCD
    ld a, [wRecordBufferData + $E]
    ld e, a
    ld a, [wRecordBufferData + $F]
    ld d, a
    ld hl, vBGMap0 + $14D
    ld bc, $0100
    call DebugShowMonsterRecord_Number24ToPackedBCD
    ld a, [wRecordBufferData + $10]
    ld e, a
    ld a, [wRecordBufferData + $11]
    ld d, a
    ld hl, vBGMap0 + $16D
    ld bc, $0100
    call DebugShowMonsterRecord_Number24ToPackedBCD
    ld a, [wScreenAttrBuffer]
    ld e, a
    ld a, [wRecordBufferData + $13]
    ld d, a
    ld hl, vBGMap0 + $18D
    ld bc, $0100
    call DebugShowMonsterRecord_Number24ToPackedBCD
    ld a, [wRecordBufferData + $14]
    ld hl, vBGMap0 + $1AF
    ld bc, $0100
    call WriteDecimalByteTiles_Bank01
    ld a, [wRecordBufferData + $15]
    ld hl, vBGMap0 + $1CF
    ld bc, $0100
    call WriteDecimalByteTiles_Bank01
    ld a, [wRecordBufferData + $16]
    ld hl, vBGMap0 + $1EF
    ld bc, $0100
    call WriteDecimalByteTiles_Bank01
    ld a, [wRecordBufferData + $17]
    ld hl, vBGMap0 + $20F
    ld bc, $0100
    call WriteDecimalByteTiles_Bank01

DebugShowMonsterRecord_Return::
Jump_001_50EC:: ; address name
    ret

; update for debug-mode state 9: the screen shows the skill viewer (E-0041)
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wJoypadPressedRepeat, wDebugCursor, wRecordBufferData, wRecordBuffer
; writes: wGameMode, wModeState, wDebugCursor, wRecordBuffer, wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3, ...
; points at: wModeChangeRequest, wDebugCursor, wRecordBufferData
DebugSkillViewer_Update::
Jump_001_50ED:: ; address name
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, .check_joypad_pressed_repeat
    xor a, a
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
    cp a, $AF
    jr c, .check_joypad_pressed_repeat2
    ld a, $AE
    ld [wDebugCursor], a

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    bit 4, a
    jr z, .skip
    ld a, [wDebugCursor]
    inc a
    ld [wDebugCursor], a
    cp a, $AF
    jr c, .skip
    xor a, a
    ld [wDebugCursor], a

.skip:
    ld hl, wDebugCursor
    ld a, [hl+]
    cp a, [hl]
    ld [hl], a
    ret z
    ld hl, vBGMap0 + $46
    ld bc, $0100
    call WriteHexByteTilesAtHL
    ld a, [wDebugCursor]
    ld [wRecordBuffer], a
    xor a, a
    ld [wRecordBuffer + $1], a
    xor a, a
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
    or a, a
    jr nz, .set_string_index
    ld a, $0E
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
    and a, $03
    ld [wStringIndex], a
    ld hl, vTiles1 + $90
    ld de, $0401
    call FillTilesRequest
    farcall ShowString_Bank08
    ld a, $10
    ld [wStringCategory], a
    ld a, [wRecordBufferData + $3]
    and a, $F0
    swap a
    ld [wStringIndex], a
    ld hl, vTiles1 + $D0
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
    ld hl, vBGMap0 + $14B
    ld bc, $0801
    call DebugSkillViewer_Update_WriteVRAMByte
    ld a, [wRecordBufferData + $6]
    ld hl, vBGMap0 + $16B
    ld bc, $0801
    call DebugSkillViewer_Update_WriteVRAMByte
    ld a, [wRecordBufferData + $7]
    ld hl, vBGMap0 + $18B
    ld bc, $0801
    call DebugSkillViewer_Update_WriteVRAMByte
    ld a, [wRecordBufferData + $8]
    ld hl, vBGMap0 + $1AB
    ld bc, $0801
    call DebugSkillViewer_Update_WriteVRAMByte
    ld a, [wRecordBufferData + $9]
    ld l, a
    ld a, [wRecordBufferData + $A]
    ld h, a
    call DebugSkillViewer_Update_Number24ToPackedBCD
    ld hl, vBGMap0 + $1EA
    ld bc, $0100
    call DebugSkillViewer_Update_WriteVRAMByteInc
    ld a, [wRecordBufferData + $9]
    ld l, a
    ld a, [wRecordBufferData + $A]
    ld h, a
    ld a, [wRecordBufferData + $B]
    ld e, a
    ld a, [wRecordBufferData + $C]
    ld d, a
    add hl, de
    call DebugSkillViewer_Update_Number24ToPackedBCD
    ld hl, vBGMap0 + $1EF
    ld bc, $0100
    call DebugSkillViewer_Update_WriteVRAMByteInc
    ld a, [wRecordBufferData + $D]
    ld l, a
    ld a, [wRecordBufferData + $E]
    ld h, a
    call DebugSkillViewer_Update_Number24ToPackedBCD
    ld hl, vBGMap0 + $20A
    ld bc, $0100
    call DebugSkillViewer_Update_WriteVRAMByteInc
    ld a, [wRecordBufferData + $D]
    ld l, a
    ld a, [wRecordBufferData + $E]
    ld h, a
    ld a, [wRecordBufferData + $F]
    ld e, a
    ld a, [wRecordBufferData + $10]
    ld d, a
    add hl, de
    call DebugSkillViewer_Update_Number24ToPackedBCD
    ld hl, vBGMap0 + $20F
    ld bc, $0100
    call DebugSkillViewer_Update_WriteVRAMByteInc
    ret

; only called from DebugSkillViewer_Update (E-0047)
; 4 call sites from 1 routine (e.g. DebugSkillViewer_Update)
; writes: wDigits, hTemp1, hTemp0
; points at: hTemp3
DebugSkillViewer_Update_Number24ToPackedBCD::
Func_001_52AF:: ; address name
    ld a, l
    ld [wDigits], a
    ld a, h
    ld [wDigits + $1], a
    xor a, a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ld hl, hTemp3
    ld a, [hl-]
    or a, [hl]
    ret z
    ld a, $99
    ldh [hTemp1], a
    ld a, $99
    ldh [hTemp0], a
    ret

; only called from DebugSkillViewer_Update (E-0047)
; 4 call sites from 1 routine (e.g. DebugSkillViewer_Update)
; reads: hTemp1, hTemp0
DebugSkillViewer_Update_WriteVRAMByteInc::
Func_001_52CD:: ; address name
    ld e, $00
    ldh a, [hTemp1]
    and a, $F0
    swap a
    ld d, a
    or a, e
    ld e, a
    ld a, c
    jr z, .call_write_vram_byte_inc
    ld a, d
    add a, b

.call_write_vram_byte_inc:
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hTemp1]
    and a, $0F
    ld d, a
    or a, e
    ld e, a
    ld a, c
    jr z, .call_write_vram_byte_inc2
    ld a, d
    add a, b

.call_write_vram_byte_inc2:
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hTemp0]
    and a, $F0
    swap a
    ld d, a
    or a, e
    ld e, a
    ld a, c
    jr z, .call_write_vram_byte_inc3
    ld a, d
    add a, b

.call_write_vram_byte_inc3:
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hTemp0]
    and a, $0F
    add a, b
    di
    call WriteVRAMByteInc
    ei
    ret

; C = the position of A in the list $11, $12, $14, $21, $22, $31, $32, $40, $80, ...; returns at once for 0
; 1 call site from 1 routine (e.g. DebugSkillViewer_Update)
DebugSkillViewer_Update_IndexOfFlagValue::
Func_001_5311:: ; address name
    or a, a
    ret z
    ld c, $01
    cp a, $11
    jr z, .done
    inc c
    cp a, $12
    jr z, .done
    inc c
    cp a, $14
    jr z, .done
    inc c
    cp a, $21
    jr z, .done
    inc c
    cp a, $22
    jr z, .done
    inc c
    cp a, $31
    jr z, .done
    inc c
    cp a, $32
    jr z, .done
    inc c
    cp a, $40
    jr z, .done
    inc c
    cp a, $80
    jr z, .done
    inc c

.done:
    ld a, c
    ret

; only called from DebugSkillViewer_Update (E-0047)
; 4 call sites from 1 routine (e.g. DebugSkillViewer_Update)
DebugSkillViewer_Update_WriteVRAMByte::
Func_001_5344:: ; address name
    ld d, a
    ld e, $00

.loop:
    push hl
    ld a, e
    ld hl, DebugSkillViewer_Update_WriteVRAMByte_Data
    add_a_to_hl
    ld a, d
    and a, [hl]
    jr z, .skip
    ld a, $01

.skip:
    add a, c
    pop hl
    di
    call WriteVRAMByte
    ei
    inc hl
    inc e
    dec b
    jr nz, .loop
    ret

; address loaded by DebugSkillViewer_Update_WriteVRAMByte
DebugSkillViewer_Update_WriteVRAMByte_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_001_5364:: ; address name
    db $80, $40, $20, $10, $08, $04, $02, $01

; only called from DebugShowMonsterRecord (E-0047)
; 7 call sites from 1 routine (e.g. DebugShowMonsterRecord)
; reads: hTemp2, hTemp1, hTemp0
; writes: wDigits
DebugShowMonsterRecord_Number24ToPackedBCD::
Func_001_536C:: ; address name
    push bc
    push hl
    ld a, e
    ld [wDigits], a
    ld a, d
    ld [wDigits + $1], a
    xor a, a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    pop hl
    pop bc
    ld e, $00
    ldh a, [hTemp2]
    and a, $0F
    ld d, a
    or a, e
    ld e, a
    ld a, d
    jr nz, .call_write_vram_byte_inc
    ld a, c
    jr .call_write_vram_byte_inc2

.call_write_vram_byte_inc:
    add a, b

.call_write_vram_byte_inc2:
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hTemp1]
    and a, $F0
    swap a
    ld d, a
    or a, e
    ld e, a
    ld a, d
    jr nz, .call_write_vram_byte_inc3
    ld a, c
    jr .call_write_vram_byte_inc4

.call_write_vram_byte_inc3:
    add a, b

.call_write_vram_byte_inc4:
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hTemp1]
    and a, $0F
    ld d, a
    or a, e
    ld e, a
    ld a, d
    jr nz, .call_write_vram_byte_inc5
    ld a, c
    jr .call_write_vram_byte_inc6

.call_write_vram_byte_inc5:
    add a, b

.call_write_vram_byte_inc6:
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hTemp0]
    and a, $F0
    swap a
    ld d, a
    or a, e
    ld e, a
    ld a, d
    jr nz, .call_write_vram_byte_inc7
    ld a, c
    jr .call_write_vram_byte_inc8

.call_write_vram_byte_inc7:
    add a, b

.call_write_vram_byte_inc8:
    di
    call WriteVRAMByteInc
    ei
    ldh a, [hTemp0]
    and a, $0F
    add a, b
    di
    call WriteVRAMByte
    ei
    ret

; writes A as decimal digit tiles at HL (three digits, with tile C for absent leading digits) (E-0124)
; 7 call sites from 2 routines (e.g. DebugShowMonsterRecord, DebugSkillViewer_Update)
WriteDecimalByteTiles_Bank01::
Func_001_53DC:: ; address name
    cp a, $64
    jr nc, .call_div_mod_a_by_e_bank01
    call WriteTileCAtHL
    inc hl
    cp a, $0A
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
    ld e, $0A
    call DivModAByE_Bank01
    call WriteTileDPlusBAtHL
    inc hl

.call_write_tile_d_plus_b_at_hl:
    ld d, a
    call WriteTileDPlusBAtHL
    ret

; D = A / E and A = A mod E by repeated subtraction (E-0122)
; 2 call sites from 1 routine (e.g. WriteDecimalByteTiles_Bank01)
DivModAByE_Bank01::
Func_001_5405:: ; address name
    ld d, $FF

.loop:
    inc d
    sub a, e
    jr nc, .loop
    add a, e
    ret

; writes tile D + B at VRAM address HL with interrupts off (WriteVRAMByte); AF kept (E-0114)
; 5 call sites from 3 routines (e.g. WriteDecimalByteTiles_Bank01, DebugShowMonsterRecord_WriteTileDPlusBAtHL, WriteHexByteTilesAtHL)
WriteTileDPlusBAtHL::
Func_001_540D:: ; address name
    push af
    ld a, d
    add a, b
    di
    call WriteVRAMByte
    ei
    pop af
    ret

; writes tile C at VRAM address HL with interrupts off (WriteVRAMByte); AF kept (E-0114)
; 2 call sites from 1 routine (e.g. WriteDecimalByteTiles_Bank01)
WriteTileCAtHL::
Func_001_5417:: ; address name
    push af
    ld a, c
    di
    call WriteVRAMByte
    ei
    pop af
    ret

; HL += 1, writes the high nibble of A as a tile (WriteTileDPlusBAtHL), then falls into the low-nibble write (E-0122)
; 7 call sites from 2 routines (e.g. DebugShowMonsterRecord, DebugSkillViewer_Update)
WriteHexByteTilesAtHL::
Func_001_5420:: ; address name
    inc hl
    push af
    swap a
    and a, $0F
    ld d, a
    call WriteTileDPlusBAtHL
    inc hl
    pop af

; only called from DebugShowMonsterRecord (E-0047)
; 2 call sites from 1 routine (e.g. DebugShowMonsterRecord)
DebugShowMonsterRecord_WriteTileDPlusBAtHL::
Func_001_542C:: ; address name
    and a, $0F
    ld d, a
    call WriteTileDPlusBAtHL
    ret

; update for debug-mode state 8: the screen shows the staff roll (SCENARIO & GAME DESIGNERS, YUJI HORII, ENIX, TOSE, FUMINORI ISHIKAWA) (E-0041)
; no direct call (reached through a table, a jump or a vector)
DebugStaffRoll_Update::
Jump_001_5433:: ; address name
    farcall DebugStaffRoll_Update_RunFieldEventFieldEventKind
    ret

; update for debug-mode state 7: the screen shows 'RESULTS DISPLAY' (species, gender) (E-0041)
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState, wJoypadPressedRepeat, wDebugCursor, wScreenByteBD, wScreenCounter, wGlyphListPos, wDebugValue0, wDebugValue1, ...
; writes: wScreenState, wScreenByteBD, wDebugCursor, wDebugValue0, wDebugValue1, wDebugValue2, wDebugValue3, wDebugState, ...
; points at: wGridCursorY, wDebugResultsBuf, wModeChangeRequest, wDebugValue2, wDebugSubState, wRecordBufA, wArg6
DebugResultsDisplay_Update::
Jump_001_543A:: ; address name
    ld a, [wScreenState]
    and a, a
    jp z, DebugResultsDisplay_Update_Sub02_Sub01_WaitForVRAMAccess_CheckJoypadPressedRepeat
    cp a, $01
    jp z, DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD_Data_5560_CheckArg1
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
    xor a, a
    ld [wScreenState], a
    ld [wScreenByteBD], a
    ret

.check_debug_cursor:
    ld a, [wDebugCursor]
    cp a, $04
    jr nz, .read_screen_byte_bd
    ld hl, wGridCursorY
    jr .read_screen_byte_bd2

.read_screen_byte_bd:
    ld hl, wDebugResultsBuf

.read_screen_byte_bd2:
    ld a, [wScreenByteBD]
    add_a_to_hl
    ld a, [hl]
    and a, a
    jr nz, .call_debug_results_display_update_write_debug
    ld a, $04

.call_debug_results_display_update_write_debug:
    dec a
    ld [hl], a
    call DebugResultsDisplay_Update_WriteDebugCounter
    ret

.check_debug_cursor2:
    ld a, [wDebugCursor]
    cp a, $04
    jr nz, .read_screen_byte_bd3
    ld hl, wGridCursorY
    jr .read_screen_byte_bd4

.read_screen_byte_bd3:
    ld hl, wDebugResultsBuf

.read_screen_byte_bd4:
    ld a, [wScreenByteBD]
    add_a_to_hl
    ld a, [hl]
    cp a, $03
    jr c, .call_debug_results_display_update_write_debug2
    ld a, $FF

.call_debug_results_display_update_write_debug2:
    inc a
    ld [hl], a
    call DebugResultsDisplay_Update_WriteDebugCounter
    ret

.call_debug_results_display_update_hl_to2:
    call DebugResultsDisplay_Update_HLToDecimalDigits
    ld a, [wScreenByteBD]
    cp a, $1A
    jr c, .set_screen_byte_bd
    ld a, $FF

.set_screen_byte_bd:
    inc a
    ld [wScreenByteBD], a
    call DebugResultsDisplay_Update_WriteDebugCounter
    ret

.call_debug_results_display_update_hl_to3:
    call DebugResultsDisplay_Update_HLToDecimalDigits
    ld a, [wScreenByteBD]
    and a, a
    jr nz, .set_screen_byte_bd2
    ld a, $1B

.set_screen_byte_bd2:
    dec a
    ld [wScreenByteBD], a
    call DebugResultsDisplay_Update_WriteDebugCounter
    ret

; only called from DebugResultsDisplay_Update (E-0047)
; 5 call sites from 1 routine (e.g. DebugResultsDisplay_Update)
; reads: wDebugCounter, wDebugCursor, wScreenByteBD, wDigits
; writes: wDebugCounter
; points at: wGridCursorY, wDebugResultsBuf
DebugResultsDisplay_Update_WriteDebugCounter::
Func_001_54E8:: ; address name
    ld a, [wDebugCounter]
    inc a
    ld [wDebugCounter], a
    cp a, $10
    jr c, DebugResultsDisplay_Update_HLToDecimalDigits
    cp a, $18
    jr c, DebugResultsDisplay_Update_HLToDecimalDigits_CallDebugResultsDisplay_Update_Sub02_ReadDeb
    xor a, a
    ld [wDebugCounter], a

; only called from DebugResultsDisplay_Update (E-0047)
; 3 call sites from 1 routine (e.g. DebugResultsDisplay_Update)
; reads: wDebugCursor, wScreenByteBD, wDigits
; points at: wGridCursorY, wDebugResultsBuf
DebugResultsDisplay_Update_HLToDecimalDigits::
Func_001_54FB:: ; address name
    ld a, [wDebugCursor]
    cp a, $04
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
    add a, $10
    ld c, a
    di
    call WaitForVRAMAccess
    ld a, c
    ld [hl], a
    ei
    ret

DebugResultsDisplay_Update_HLToDecimalDigits_CallDebugResultsDisplay_Update_Sub02_ReadDeb::
Jump_001_552A:: ; address name
    call DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD
    di
    call WaitForVRAMAccess
    xor a, a
    ld [hl], a
    ei
    ret

; only called from DebugResultsDisplay_Update_Sub02 (E-0047)
; 2 call sites from 1 routine (e.g. DebugResultsDisplay_Update_HLToDecimalDigits)
; reads: wDebugCursor, wScreenByteBD
DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD::
Func_001_5535:: ; address name
    ld a, [wDebugCursor]
    cp a, $04
    jr nz, .check_screen_byte_bd
    ld de, DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD_Data_555C
    jr .check_screen_byte_bd2

.check_screen_byte_bd:
    ld de, DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD_Data_5560

.check_screen_byte_bd2:
    ld a, [wScreenByteBD]
    cp a, $0E
    jr c, .skip
    sub a, $0E
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

; address loaded by DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD
DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD_Data_555C:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_001_555C:: ; address name
    db $86, $99, $A6, $99

; address loaded by DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD
DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD_Data_5560:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_001_5560:: ; address name
    db $E6, $99, $06, $9A

DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD_Data_5560_CheckArg1::
Jump_001_5564:: ; address name
    ld a, [wArg1]
    and a, a
    jr z, .call_compute_breeding_child
    cp a, $02
    jr z, .call_compute_breeding_child
    xor a, a
    ld [wArg1], a

.call_compute_breeding_child:
    farcall ComputeBreedingChild
    ld a, [wArg5]
    cp a, $FF
    ret nz
    ld a, [wArg1]
    push af
    ld a, [wArg7]
    cp a, $FF
    jr nz, .read_arg6
    ld a, [wArg6]
    cp a, $FF
    jr z, .call_debug_results_display_update_write

.read_arg6:
    ld a, [wArg6]
    ld [wArg1], a
    ld a, [wArg7]
    ld [wArg2], a
    ld de, DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD_Data_75C5
    ld a, e
    ld [wArg3], a
    ld a, d
    ld [wArg4], a
    farcall TestBitInFieldAtArg3
    ld a, [wArg5]
    cp a, $FF
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
    ld de, vBGMap0 + $6A
    call WriteThreeHexDigitsAtDE
    xor a, a
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
    ld de, vBGMap0 + $6A
    call WriteThreeHexDigitsAtDE
    ld hl, wChildRecord + MON_SEX
    ld a, [hl]
    and a, $01
    add a, $FE
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
    ld a, [hl+]
    add a, $10
    ld [de], a
    ei
    inc de
    inc c
    ld a, c
    cp a, $0E
    jr c, .loop
    ld de, vBGMap0 + $26
    ld c, $00

.loop2:
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    add a, $10
    ld [de], a
    ei
    inc de
    inc c
    ld a, c
    cp a, $0D
    jr c, .loop2
    pop af
    ld [wArg1], a
    xor a, a
    ld [wScreenState], a
    ld [wNameEntryState], a
    ret

; only called from DebugResultsDisplay_Update_Sub02_Sub01 (E-0047)
; 3 call sites from 1 routine (e.g. DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD)
DebugResultsDisplay_Update_Sub02_Sub01_WaitForVRAMAccess::
Func_001_56D3:: ; address name
    ld a, c
    and a, $F0
    swap a
    add a, $10
    ld b, a
    ld a, c
    and a, $0F
    add a, $10
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
Jump_001_56F1:: ; address name
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
    call CopyWD01ABytesFromIndexCToDE
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
    call CopyWD01ABytesFromIndexCToDE
    ld hl, wGridCursorY
    ld de, vBGMap0 + $186
    ld c, $00

.loop:
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    add a, $10
    ld [de], a
    ei
    inc de
    inc c
    ld a, c
    cp a, $0E
    jr c, .loop
    ld de, vBGMap0 + $1A6
    ld c, $00

.loop2:
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    add a, $10
    ld [de], a
    ei
    inc de
    inc c
    ld a, c
    cp a, $0D
    jr c, .loop2
    ld hl, wDebugResultsBuf
    ld de, vBGMap0 + $1E6
    ld c, $00

.loop3:
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    add a, $10
    ld [de], a
    ei
    inc de
    inc c
    ld a, c
    cp a, $0E
    jr c, .loop3
    ld de, vBGMap0 + $206
    ld c, $00

.loop4:
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    add a, $10
    ld [de], a
    ei
    inc de
    inc c
    ld a, c
    cp a, $0D
    jr c, .loop4
    ret

; for C up to $1A, loads byte C of wD01A (LoadWD01AByteArg4) and stores it at DE (E-0122)
; 2 call sites from 1 routine (e.g. DebugResultsDisplay_Update_Sub02_Sub01_WaitForVRAMAccess)
; reads: wArg5
; writes: wArg4
CopyWD01ABytesFromIndexCToDE::
Func_001_57C7:: ; address name
    push bc
    push de
    ld a, c
    ld [wArg4], a
    farcall LoadWD01AByteArg4
    pop de
    pop bc
    ld a, [wArg5]
    ld [de], a
    inc de
    inc c
    ld a, c
    cp a, $1B
    jr c, CopyWD01ABytesFromIndexCToDE
    ret

; debug: toggles wD7F1 between 0 and 2 and writes tile $10 + wD7F1 at vBGMap0 + $81; the following entries are the debug results screen input handlers (E-0131)
; 1 call site from 1 routine (e.g. DebugToggleArg1Marker)
; reads: wArg1
; writes: wArg1
DebugToggleArg1Marker::
Func_001_57E1:: ; address name
    ld a, [wArg1]
    and a, a
    jr nz, .clear_arg1
    ld a, $02
    ld [wArg1], a
    jr .call_wait_for_vram_access

.clear_arg1:
    xor a, a
    ld [wArg1], a

.call_wait_for_vram_access:
    di
    call WaitForVRAMAccess
    ld a, [wArg1]
    add a, $10
    ld [vBGMap0 + $81], a
    ei
    ret

DebugToggleArg1Marker_CheckDebugCursor::
Jump_001_5800:: ; address name
    ld a, [wDebugCursor]
    cp a, $04
    jr z, .call_draw_debug_field_value_debug_cursor
    cp a, $07
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
    xor a, a
    ld [wScreenByteBD], a
    ret

DebugToggleArg1Marker_CallDrawDebugFieldValueDebugCursor::
Jump_001_5822:: ; address name
    call DrawDebugFieldValueDebugCursor
    ld a, [wDebugCursor]
    and a, a
    ret z
    dec a
    ld [wDebugCursor], a
    call StepDebugCursorDebugCounter
    ret

DebugToggleArg1Marker_CallDrawDebugFieldValueDebugCursor2::
Jump_001_5832:: ; address name
    call DrawDebugFieldValueDebugCursor
    ld a, [wDebugCursor]
    cp a, $09
    ret z
    inc a
    ld [wDebugCursor], a
    call StepDebugCursorDebugCounter
    ret

DebugToggleArg1Marker_CheckDebugCursor2::
Jump_001_5843:: ; address name
    ld a, [wDebugCursor]
    and a, a
    jr z, .skip6
    cp a, $01
    jr z, .skip
    cp a, $02
    jr z, .skip5
    cp a, $03
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
    and a, a
    jr z, .skip4
    ld a, $FF

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
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld b, a
    cp a, $01
    jr c, .next
    ld a, c
    cp a, $74
    jr c, .next
    ld bc, $FFFF

.next:
    inc bc
    pop hl
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl], a
    call StepDebugCursorDebugCounter
    ld a, [wDebugCursor]
    cp a, $02
    jr z, DebugToggleArg1Marker_Loop
    ld de, wDebugValue0
    ld hl, vTiles2 + $300
    jr DebugToggleArg1Marker_Skip

DebugToggleArg1Marker_Loop::
Jump_001_58A2:: ; address name
    ld de, wDebugValue3
    ld hl, vTiles2 + $400

DebugToggleArg1Marker_Skip::
Jump_001_58A8:: ; address name
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
Jump_001_58C6:: ; address name
    ld a, [wDebugCursor]
    and a, a
    jr z, .skip5
    cp a, $01
    jr z, .skip
    cp a, $02
    jr z, .skip6
    cp a, $03
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
    cp a, $01
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
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld b, a
    and a, a
    jr nz, .next
    ld a, c
    and a, a
    jr nz, .next
    ld bc, $0175

.next:
    dec bc
    pop hl
    ld a, c
    ld [hl+], a
    ld a, b
    ld [hl], a
    call StepDebugCursorDebugCounter
    ld a, [wDebugCursor]
    cp a, $02
    jp z, DebugToggleArg1Marker_Loop
    ld de, wDebugValue0
    ld hl, vTiles2 + $300
    jp DebugToggleArg1Marker_Skip

DebugToggleArg1Marker_Cp04::
Jump_001_5923:: ; address name
    cp a, $04
    jr z, .skip
    cp a, $05
    jr z, .skip5
    cp a, $06
    jr z, .skip7
    cp a, $07
    jr z, .skip2
    cp a, $08
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
    cp a, c
    jr c, .skip4
    ld a, $FF

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
    ld c, $1B
    jr .skip3

.skip8:
    ld hl, wGridCursorX
    ld c, $1B
    jr .skip3

DebugToggleArg1Marker_Cp042::
Jump_001_596F:: ; address name
    cp a, $04
    jr z, .skip
    cp a, $05
    jr z, .skip5
    cp a, $06
    jr z, .skip7
    cp a, $07
    jr z, .skip2
    cp a, $08
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
    and a, a
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
    ld c, $1C
    jr .skip3

.skip8:
    ld hl, wGridCursorX
    ld c, $1C
    jr .skip3

DebugToggleArg1Marker_ClearDebugCursor::
Jump_001_59BA:: ; address name
    xor a, a
    ld [wDebugCursor], a
    ld [wDebugValue0], a
    ld [wDebugValue1], a
    ld [wDebugValue2], a
    ld [wDebugValue3], a
    ld [wDebugState], a
    ld [wDebugSubState], a
    ld [wDebugCounter], a
    xor a, a
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

DebugToggleArg1Marker_CheckScreenCounter::
Jump_001_59DC:: ; address name
    ld a, [wScreenCounter]
    cp a, $0A
    ret c
    ld a, [wGlyphListPos]
    cp a, $0A
    ret c
    ld hl, wDebugValue2
    ld de, wDebugSubState
    ld a, [hl]
    ld b, a
    ld a, [de]
    cp a, b
    jr nz, .skip
    ret

.skip:
    ld hl, wRecordBufA
    ld bc, $01EF

.loop:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld hl, wRecordBufA + MON_SPECIES
    ld a, [wDebugValue0]
    ld [hl+], a
    ld a, [wDebugValue1]
    ld [hl+], a
    ld hl, wRecordBufB + MON_SPECIES
    ld a, [wDebugValue3]
    ld [hl+], a
    ld a, [wDebugState]
    ld [hl+], a
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
    ld b, $1B

.loop2:
    ld a, [hl]
    ld [de], a
    inc hl
    inc de
    dec b
    jr nz, .loop2
    ld hl, wDebugResultsBuf
    ld de, wRecordBufB + MON_RESISTANCES
    ld b, $1B

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
    xor a, a
    ld [wNameEntryState], a
    ret

; debug: wC5FF += 1; below $10 continues at Func_001_5AC0, below $18 at PackTwoDigitsOfCAsBCD_ReadDebugCursor, then wraps to 0 (E-0126)
; 10 call sites from 2 routines (e.g. DebugResultsDisplay_Update_Sub02_Sub01_WaitForVRAMAccess, DebugToggleArg1Marker)
; reads: wDebugCounter, wDebugCursor
; writes: wDebugCounter
StepDebugCursorDebugCounter::
Func_001_5AAC:: ; address name
    ld a, [wDebugCounter]
    inc a
    ld [wDebugCounter], a
    cp a, $10
    jr c, DrawDebugFieldValueDebugCursor
    cp a, $18
    jp c, PackTwoDigitsOfCAsBCD_ReadDebugCursor
    xor a, a
    ld [wDebugCounter], a

; debug: draws the value of field wC5F8 (Data_001_5B70) at Data_001_5B84[wC5F8] as hex, a tile or BCD (E-0128)
; 3 call sites from 1 routine (e.g. DebugToggleArg1Marker)
; reads: wDebugCursor
DrawDebugFieldValueDebugCursor::
Func_001_5AC0:: ; address name
    ld a, [wDebugCursor]
    sla a
    ld de, DrawDebugFieldValueDebugCursor_Data_5B70
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
    ld a, [hl]
    ld c, a
    inc hl
    ld a, [hl]
    ld b, a
    ld a, [wDebugCursor]
    cp a, $04
    jr nc, .read_debug_cursor2
    bit 0, a
    jr nz, .read_debug_cursor
    ld a, [wDebugCursor]
    sla a
    ld hl, DrawDebugFieldValueDebugCursor_Data_5B84
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
    ld hl, DrawDebugFieldValueDebugCursor_Data_5B84
    add_a_to_hl
    ld a, [hl]
    ld e, a
    inc hl
    ld a, [hl]
    ld d, a
    di
    call WaitForVRAMAccess
    ld a, c
    add a, $FE
    ld [de], a
    ei
    ret

.read_debug_cursor2:
    ld a, [wDebugCursor]
    sla a
    ld hl, DrawDebugFieldValueDebugCursor_Data_5B84
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
; 4 call sites from 2 routines (e.g. DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD, DrawDebugFieldValueDebugCursor)
; reads: wDigits
PackTwoDigitsOfCAsBCD::
Func_001_5B2D:: ; address name
    push de
    ld l, c
    ld h, $00
    call HLToDecimalDigits
    ld a, [wDigits + $1]
    and a, $0F
    swap a
    ld c, a
    ld a, [wDigits + $2]
    and a, $0F
    or a, c
    ld c, a
    pop de
    ret

PackTwoDigitsOfCAsBCD_ReadDebugCursor::
Jump_001_5B45:: ; address name
    ld a, [wDebugCursor]
    sla a
    ld hl, DrawDebugFieldValueDebugCursor_Data_5B84
    add_a_to_hl
    ld a, [hl]
    ld e, a
    inc hl
    ld a, [hl]
    ld d, a
    di
    call WaitForVRAMAccess
    xor a, a
    ld [de], a
    inc de
    ei
    di
    call WaitForVRAMAccess
    xor a, a
    ld [de], a
    inc de
    ei
    di
    call WaitForVRAMAccess
    xor a, a
    ld [de], a
    inc de
    ei
    ret

; address loaded by DrawDebugFieldValueDebugCursor
DrawDebugFieldValueDebugCursor_Data_5B70:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_001_5B70:: ; address name
    db $F9, $C5, $FB, $C5, $FC, $C5, $FE, $C5, $81, $D7, $83, $D7, $85, $D7, $82, $D7
    db $84, $D7, $86, $D7

; address loaded by DrawDebugFieldValueDebugCursor, PackTwoDigitsOfCAsBCD
DrawDebugFieldValueDebugCursor_Data_5B84:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_001_5B84:: ; address name
    db $E6, $98, $06, $99, $26, $99, $46, $99, $82, $99, $A2, $99, $C2, $99, $E2, $99
    db $02, $9A, $22, $9A

; reads a monster id word at DE, copies its name and draws its glyphs at HL (E-0122)
; 2 call sites from 2 routines (e.g. DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD, DebugToggleArg1Marker)
; writes: wNameGlyphBuf
DrawMonsterNameForWordAtDE_Bank01::
Func_001_5B98:: ; address name
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
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    call CopyGlyphTilesToVRAM
    ret

; HL = string number; copies 16 bytes of that string of StringTable_MonsterNames (bank $08, via wDataBank) to wC8CF; wDataBank is restored
; 1 call site from 1 routine (e.g. DrawMonsterNameForWordAtDE_Bank01)
; reads: wDataBank
; writes: wDataBank
; points at: wNameGlyphBuf
CopyMonsterNameToBuffer_B01::
Func_001_5BAD:: ; address name
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
; 2 call sites from 1 routine (e.g. DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD)
; points at: wNameGlyphBuf
DebugResultsDisplay_Update_WriteUnknownName::
Func_001_5BE8:: ; address name
    ld c, $00
    ld hl, wNameGlyphBuf

.loop:
    ld a, $98
    ld [hl+], a
    inc c
    ld a, c
    cp a, $09
    jr c, .loop
    ld a, $F0
    ld [hl], a
    ret

; update for debug-mode state 3: the screen shows '? AUTOMAP ?' (key, level, position) (E-0041)
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wDebugState, wDebugSubState, wDebugValue0, wDebugValue2, wDebugValue3, wKeyWorldWidth, wKeyWorldHeight, ...
; writes: wCurrentKeyIndex, hMapScreenX, hMapScreenY, hMapId, wMapType, wScriptRunning, wGameMode, wModeState, ...
; points at: wModeChangeRequest
DebugAutomap_Update::
Jump_001_5BFA:: ; address name
    ld a, [wJoypadPressed]
    bit 0, a
    jp z, .check_bit1
    ld a, [wDebugState]
    cp a, $FF
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
    cp a, $FF
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
    and a, $1F
    ld hl, DebugAutomap_Update_Data
    add_a_to_hl
    ld a, [hl]
    ldh [hMapId], a
    xor a, a
    ld [wMapType], a
    xor a, a
    ld [wScriptRunning], a
    ld a, $01
    ld [wGameMode], a
    xor a, a
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.check_debug_state2:
    ld a, [wDebugState]
    and a, $7F
    ld [wKeyWorldSlot], a
    farcall LoadKeyWorldFlagsRecordFromSRAMSlotKeyWorldSlot
    ld a, $80
    ld [wMapType], a
    xor a, a
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
    cp a, $FF
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
    cp a, $04
    jr nz, .set_debug_cursor2
    xor a, a

.set_debug_cursor2:
    ld [wDebugCursor], a

.check_joypad_pressed_repeat2:
    ld c, $00
    ld a, [wJoypadPressedRepeat]
    bit 5, a
    jr z, .check_bit4
    ld c, $FF
    jr .skip

.check_bit4:
    bit 4, a
    jr z, .skip
    ld c, $01

.skip:
    bit 0, c
    jr z, .check_debug_value0
    ld a, [wDebugCursor]
    or a, a
    jr nz, .skip2
    ld a, [wDebugValue0]
    add a, c
    cp a, $20
    jr nz, .cp_FF
    xor a, a
    jr .set_debug_value0

.cp_FF:
    cp a, $FF
    jr nz, .set_debug_value0
    ld a, $13

.set_debug_value0:
    or a, $80
    ld [wDebugValue0], a
    and a, $7F
    call LoadKeyEntryFieldsToDebugState
    jr .check_debug_value0

.skip2:
    dec a
    jr nz, .skip3
    ld a, [wDebugSubState]
    bit 7, a
    jr nz, .skip3
    ld a, [wDebugValue1]
    add a, c
    cp a, $64
    jr nz, .cp_FF2
    xor a, a
    jr .set_debug_value1

.cp_FF2:
    cp a, $FF
    jr nz, .set_debug_value1
    ld a, $63

.set_debug_value1:
    or a, $80
    ld [wDebugValue1], a
    jr .check_debug_value0

.skip3:
    dec a
    jr nz, .skip4
    ld a, [wDebugValue2]
    add a, c
    and a, $0F
    ld [wDebugValue2], a
    jr .check_debug_value0

.skip4:
    dec a
    jr nz, .check_debug_value0
    ld a, [wDebugValue3]
    add a, c
    and a, $0F
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
    and a, $7F
    ld de, vBGMap0 + $10A
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
    and a, $7F
    ld [wDebugValue0], a
    ld a, [wDebugValue1]
    and a, $7F
    ld [wDebugValue1], a
    call DebugAutomap_Update_WriteHexByteTilesAtDE

.read_debug_value2:
    ld a, [wDebugValue2]
    ld de, vBGMap0 + $14A
    call WriteHexByteTilesAtDE
    ld a, [wDebugValue3]
    ld de, vBGMap0 + $16A
    call WriteHexByteTilesAtDE
    ld hl, vBGMap0 + $109
    ld b, $00

.loop:
    ld a, [wDebugCursor]
    cp a, b
    jr z, .call_write_vram_byte
    ld a, $80
    call WriteVRAMByte
    jr .skip5

.call_write_vram_byte:
    ld a, $F8
    call WriteVRAMByte

.skip5:
    ld a, $20
    add_a_to_hl
    inc b
    ld a, b
    cp a, $05
    jr nz, .loop
    ret

; address loaded by DebugAutomap_Update
DebugAutomap_Update_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_001_5DAD:: ; address name
    db $00, $05, $20, $30, $48, $70, $A0, $A8, $B0, $B8, $C8, $D1, $DA

; only called from DebugAutomap_Update (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update)
; reads: wDebugValue1, wDebugValue0, wDebugState, hTemp0, hTemp1, hTemp2, hTemp3, wKeyWorldWidth, ...
; writes: hTemp0, wCurrentKeyIndex, wKeyWorldSlot, wPartyStrength, wMapWidthScreens, wMapHeightScreens, hPlayerFacing, hMapScreenX, ...
; points at: wModeChangeRequest
DebugAutomap_Update_RollKeyContentsForLevelTemp0::
Func_001_5DBA:: ; address name
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
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [wDebugState]
    cp a, $FF
    jr nz, .skip
    push hl
    farcall FindSRAMSlotMarkerIndex
    pop hl
    ldh a, [hTemp0]
    cp a, $FF
    ret z
    ld [hl+], a
    jr .set_key_world_slot

.skip:
    ld a, [hl]
    and a, $7F
    ld [hl+], a

.set_key_world_slot:
    ld [wKeyWorldSlot], a
    ldh a, [hTemp1]
    ld [hl+], a
    ldh a, [hTemp2]
    ld [hl+], a
    ldh a, [hTemp3]
    ld [hl], a
    ld [wPartyStrength], a
    farcall DebugAutomap_Update_Sub01_DebugAutomap_Update_MergeKeyWorldAreas
    farcall SaveKeyWorldFlagsRecordToSRAMSlotKeyWorldSlot
    ld a, [wKeyWorldWidth]
    ld [wMapWidthScreens], a
    ld a, [wKeyWorldHeight]
    ld [wMapHeightScreens], a
    xor a, a
    ldh [hPlayerFacing], a
    ld a, [wKeyWorldGoalScreen]
    swap a
    and a, $0F
    ldh [hMapScreenX], a
    ld a, [wKeyWorldGoalScreen]
    and a, $0F
    ldh [hMapScreenY], a
    ld a, [wKeyWorldGoalPos]
    ldh [hPlayerX], a
    ld a, [wKeyWorldGoalPos2]
    ldh [hPlayerY], a
    ldh a, [hPlayerFacing]
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ldh a, [hPlayerX]
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $B], a
    ldh a, [hPlayerY]
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $C], a
    ld a, $80
    ld [wMapType], a
    ld a, $01
    ld [wGameMode], a
    ld a, $05
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

; A = key slot: wC5FD = byte 0 and wC5FE = byte 3 of its wKeyList entry, wC5FA = byte 3 | $80 (E-0120)
; 2 call sites from 2 routines (e.g. DebugAutomap_Update, DebugAutomap_Init)
; writes: wDebugState, wDebugSubState, wDebugValue1
LoadKeyEntryFieldsToDebugState::
Func_001_5E6C:: ; address name
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    ld [wDebugState], a
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    ld [wDebugSubState], a
    or a, $80
    ld [wDebugValue1], a
    ret

; only called from DebugAutomap_Update (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update)
; reads: wDebugState, wDebugSubState, wDebugValue1
; writes: wDebugValue1
DebugAutomap_Update_WriteHexByteTilesAtDE::
Func_001_5E8A:: ; address name
    ld a, [wDebugState]
    cp a, $FF
    jr z, .clear_debug_value1
    ld a, [wDebugSubState]
    bit 7, a
    jr nz, .clear_debug_value1
    ld a, [wDebugValue1]
    and a, $7F
    ld de, vBGMap0 + $12A
    call WriteHexByteTilesAtDE
    ret

.clear_debug_value1:
    xor a, a
    ld [wDebugValue1], a
    ld de, vBGMap0 + $12A
    call WriteHexByteTilesAtDE
    ret

; only called from DebugAutomap_Update (E-0047)
; 1 call site from 1 routine (e.g. DebugAutomap_Update)
; reads: wDebugSubState, wDebugState, wDebugValue0
; writes: wNameGlyphBuf
; points at: wNameGlyphBuf
DebugAutomap_Update_CopyGlyphTilesToVRAM::
Func_001_5EAF:: ; address name
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
    ld [wNameGlyphBuf + $A], a
    ld [wNameGlyphBuf + $B], a
    ld [wNameGlyphBuf + $C], a
    ld [wNameGlyphBuf + $D], a
    ld [wNameGlyphBuf + $E], a
    ld a, $F0
    ld [wNameGlyphBuf + $F], a
    ld de, vTiles2 + $200
    call CopyGlyphTilesToVRAM
    ld a, [wDebugSubState]
    bit 7, a
    jr z, .check_debug_sub_state
    ld a, [wDebugState]
    cp a, $FF
    jr nz, .check_debug_sub_state
    ld a, $29
    ld [wNameGlyphBuf], a
    ld a, $2A
    ld [wNameGlyphBuf + $1], a
    ld a, $8D
    ld [wNameGlyphBuf + $2], a
    ld a, $39
    ld [wNameGlyphBuf + $3], a
    ld a, $2F
    ld [wNameGlyphBuf + $4], a
    ld a, $F0
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
    and a, $F0
    ld hl, DebugMenuNames
    add_a_to_hl
    ld de, wNameGlyphBuf

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    cp a, $F0
    jr nz, .loop
    ld de, vTiles2 + $200
    call CopyGlyphTilesToVRAM
    ret

.check_debug_value0:
    ld a, [wDebugValue0]
    and a, $1F
    ld de, wNameGlyphBuf
    call WriteKeyNameToDE
    ld de, vTiles2 + $200
    call CopyGlyphTilesToVRAM
    ret

; E-0233 (C1: the debug menu copies the string at $5F56 + 16 * (wDebugState - 1) up to $F0 to wNameGlyphBuf and draws it with CopyGlyphTilesToVRAM; 10 rows, then an 8-byte string for the 11th entry).
; record: a debug menu entry name: glyph codes ending in $F0, padded to 16 bytes (not charmap.inc text)
DebugMenuNames::
Data_001_5F56:: ; address name
    db $8A, $87, $42, $8D, $26, $3D, $29, $2A, $8D, $F0, $00, $00, $00, $00, $00, $00 ; id 1
    db $5E, $56, $66, $67, $3D, $29, $2A, $8D, $F0, $00, $00, $00, $00, $00, $00, $00 ; id 2
    db $29, $25, $32, $8D, $2B, $3D, $29, $2A, $8D, $F0, $00, $00, $00, $00, $00, $00 ; id 3
    db $44, $30, $8D, $26, $44, $3D, $29, $2A, $8D, $F0, $00, $00, $00, $00, $00, $00 ; id 4
    db $40, $4A, $26, $33, $25, $4F, $2B, $3D, $29, $2A, $8D, $F0, $00, $00, $00, $00 ; id 5
    db $64, $88, $62, $6A, $9C, $3D, $2F, $52, $3D, $29, $2A, $8D, $F0, $00, $00, $00 ; id 6
    db $5C, $87, $77, $3D, $47, $4F, $3D, $29, $2A, $8D, $F0, $00, $00, $00, $00, $00 ; id 7
    db $2C, $55, $2A, $4B, $26, $2F, $8D, $4D, $3D, $29, $2A, $8D, $F0, $00, $00, $00 ; id 8
    db $28, $47, $25, $37, $8D, $3D, $29, $2A, $8D, $F0, $00, $00, $00, $00, $00, $00 ; id 9
    db $43, $47, $3D, $35, $29, $25, $3D, $29, $2A, $8D, $F0, $00, $00, $00, $00, $00 ; id 10
    db $2F, $51, $55, $3D, $29, $2A, $8D, $F0 ; end

; update for debug-mode state 2: the screen shows '? EDIT ?' (world, map number, position) (E-0041)
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wDebugValue0, wDebugValue1, wDebugValue2, wDebugValue3, wDebugState, wDebugCursor, wFrameCounterLo, ...
; writes: hTemp0, hMapId, hMapScreenX, hPlayerX, hMapScreenY, hPlayerY, wFieldReturnPhase, wGameMode, ...
; points at: wModeChangeRequest, wDebugSubState
DebugMapEditor_Update::
Jump_001_5FFE:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 0, a
    jr z, .check_joypad_pressed_repeat
    ld a, [wDebugValue0]
    ldh [hTemp0], a
    call DebugMapEditor_Update_WriteROMB0AndTemp0
    or a, a
    jr z, .read_debug_value0
    ld b, $08
    ld hl, vBGMap0 + $1A5
    ld a, $F0

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
    xor a, a
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
    cp a, $FF
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
    cp a, $05
    jr nz, .set_debug_cursor2
    xor a, a

.set_debug_cursor2:
    ld [wDebugCursor], a

.check_frame_counter_lo:
    ld c, $00
    ld a, [wFrameCounterLo]
    and a, $03
    jr nz, .skip
    ld a, [wJoypadHeld]
    bit 5, a
    jr z, .check_bit4
    ld c, $FF
    jr .skip

.check_bit4:
    bit 4, a
    jr z, .skip
    ld c, $01

.skip:
    bit 0, c
    jr z, .check_debug_sub_state
    ld a, [wDebugCursor]
    or a, a
    jr nz, .skip2
    ld a, [wDebugValue0]
    add a, c
    cp a, $FF
    jr nz, .set_debug_value0
    ld a, $E1

.set_debug_value0:
    ld [wDebugValue0], a
    ld hl, wDebugSubState
    inc [hl]
    jr .check_debug_sub_state

.skip2:
    dec a
    jr nz, .skip3
    ld a, [wDebugValue1]
    add a, c
    and a, $0F
    ld [wDebugValue1], a
    jr .check_debug_sub_state

.skip3:
    dec a
    jr nz, .skip4
    ld a, [wDebugValue3]
    add a, c
    and a, $0F
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
    add a, c
    ld [wDebugValue2], a
    jr .check_debug_sub_state

.skip5:
    sla c
    sla c
    sla c
    sla c
    ld a, [wDebugState]
    add a, c
    ld [wDebugState], a

.check_debug_sub_state:
    ld a, [wDebugSubState]
    or a, a
    jr z, .read_debug_value1
    ld a, [wDebugValue0]
    add a, $0A
    ld [wStringIndex], a
    xor a, a
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
    xor a, a
    ld [wDebugSubState], a

.read_debug_value1:
    ld a, [wDebugValue1]
    ld de, vBGMap0 + $10A
    call WriteHexByteTilesAtDE
    ld a, [wDebugValue3]
    ld de, vBGMap0 + $12A
    call WriteHexByteTilesAtDE
    ld a, [wDebugValue2]
    swap a
    and a, $0F
    ld de, vBGMap0 + $14A
    call WriteHexByteTilesAtDE
    ld a, [wDebugState]
    swap a
    and a, $0F
    ld de, vBGMap0 + $16A
    call WriteHexByteTilesAtDE
    ld hl, vBGMap0 + $E9
    ld b, $00

.loop2:
    ld a, [wDebugCursor]
    cp a, b
    jr z, .call_write_vram_byte
    ld a, $80
    call WriteVRAMByte
    jr .skip6

.call_write_vram_byte:
    ld a, $F8
    call WriteVRAMByte

.skip6:
    ld a, $20
    add_a_to_hl
    inc b
    ld a, b
    cp a, $05
    jr nz, .loop2
    ret

; update for debug-mode state 0: the screen shows the debug menu (E-0041)
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wDebugCursor, wJoypadPressed, wDebugMenuFlag0, wDebugMenuFlag1, wDebugMenuFlag2, wDebugMenuFlag3
; writes: wDebugCursor, wGameMode, wMapType, wKeyWorldRefresh, wModeState, wFieldTransitionStep
; points at: wModeChangeRequest, wGameMode
DebugMainMenu_Update::
Jump_001_616A:: ; address name
    ld a, [wJoypadPressedRepeat]
    and a, $90
    jr z, .check_joypad_pressed_repeat
    ld a, [wDebugCursor]
    inc a
    cp a, $0C
    jr nz, .set_debug_cursor
    ld a, $00
    jr .set_debug_cursor

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    and a, $60
    jr z, .read_debug_cursor
    ld a, [wDebugCursor]
    dec a
    cp a, $FF
    jr nz, .set_debug_cursor
    ld a, $0B

.set_debug_cursor:
    ld [wDebugCursor], a

.read_debug_cursor:
    ld a, [wDebugCursor]
    swap a
    add a, $A0
    ld hl, vBGMap0 + $122
    ld b, $10

.loop:
    call WriteVRAMByteInc
    inc a
    dec b
    jr nz, .loop
    ld a, [wJoypadPressed]
    and a, $01
    ret z
    ld a, [wDebugCursor]
    or a, a
    jr nz, .skip
    ld a, $01
    ld [wGameMode], a
    ld hl, wModeChangeRequest
    inc [hl]
    xor a, a
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
    ld a, $0A
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.skip10:
    dec a
    jr nz, .read_debug_menu_flag0
    ld a, $00
    ld [wGameMode], a
    ld a, $0B
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.read_debug_menu_flag0:
    ld hl, wGameMode
    ld a, [wDebugMenuFlag0]
    ld [hl+], a
    ld a, [wDebugMenuFlag1]
    ld [hl+], a
    ld a, [wDebugMenuFlag2]
    ld [hl+], a
    ld a, [wDebugMenuFlag3]
    ld [hl], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

; update for debug-mode state 4: the screen shows 'MONSTER BGSD CHARA': monster picture and sprite viewer (E-0041)
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wDebugState, wDebugCursor, wJoypadPressedRepeat, wDebugValue1, wDebugValue0, wIsCGB, wDebugValue3, ...
; writes: wDebugState, wDebugCursor, wDebugValue0, wDebugValue1, hTemp0, wBGPaletteUploadRequest, wDebugValue3, wOBJPaletteUploadRequest, ...
; points at: wDebugValue0, wOBJPaletteBuffer, wDebugSubState, wModeChangeRequest
DebugMonsterPictureViewer_Update::
Jump_001_6294:: ; address name
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, .check_bit1
    ld a, [wDebugState]
    inc a
    and a, $03
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
    and a, $C0
    jr z, .read_debug_cursor
    ld a, [wDebugCursor]
    inc a
    and a, $01
    ld [wDebugCursor], a
    ret

.read_debug_cursor:
    ld a, [wDebugCursor]
    sla a
    ld de, wDebugValue0
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
    ld a, [wJoypadPressedRepeat]
    bit 5, a
    jr z, .check_bit4
    dec hl
    ld a, h
    or a, $80
    ld [de], a
    dec de
    ld a, l
    ld [de], a
    ld a, h
    cp a, $FF
    jr nz, .check_debug_value1
    ld a, [wDebugCursor]
    or a, a
    jr nz, .skip2
    ld hl, $017E
    ld a, h
    or a, $80
    ld h, a
    ld a, l
    ld [wDebugValue0], a
    ld a, h
    ld [wDebugValue1], a
    jr .check_debug_value1

.skip2:
    ld hl, $017E
    ld a, h
    or a, $80
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
    or a, a
    jr nz, .skip3
    ld a, $7E
    cp a, l
    jr nz, .next
    ld a, $01
    cp a, h
    jr nz, .next
    ld a, $80
    ld [de], a
    dec de
    xor a, a
    ld [de], a
    jr .check_debug_value1

.skip3:
    ld a, $7E
    cp a, l
    jr nz, .next
    ld a, $01
    cp a, h
    jr nz, .next
    ld a, $80
    ld [de], a
    dec de
    xor a, a
    ld [de], a
    jr .check_debug_value1

.next:
    inc hl
    ld a, h
    or a, $80
    ld [de], a
    dec de
    ld a, l
    ld [de], a

.check_debug_value1:
    ld a, [wDebugValue1]
    bit 7, a
    jr z, .check_debug_value3
    and a, $7F
    ld [wDebugValue1], a
    ld a, [wDebugValue0]
    ld e, a
    ld a, [wDebugValue1]
    ld d, a
    ld hl, vTiles2 + $200
    ld c, $01
    call LoadMonsterPicture
    ld a, [wIsCGB]
    or a, a
    jr z, .check_debug_value3
    ld hl, vBGMap0 + $124
    ld a, $01
    ldh [hTemp0], a
    ld a, [wDebugValue0]
    ld e, a
    ld a, [wDebugValue1]
    ld d, a
    call LoadMonsterPictureAttributes
    ld a, $7F
    ld [wBGPaletteUploadRequest], a

.check_debug_value3:
    ld a, [wDebugValue3]
    bit 7, a
    jr z, .check_debug_cursor
    and a, $7F
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
    or a, a
    jr z, .check_debug_cursor
    ld a, [wDebugValue2]
    ld l, a
    ld a, [wDebugValue3]
    ld h, a
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, l
    add a, $28
    ld l, a
    ld a, h
    adc a, $73
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
    ld [hl+], a
    pop bc
    inc de
    dec c
    jr nz, .loop
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a

.check_debug_cursor:
    ld hl, wDebugSubState
    inc [hl]
    ld a, [wDebugCursor]
    or a, a
    jr nz, .read_debug_value0
    ld a, [wDebugSubState]
    bit 3, a
    jr z, .read_debug_value0
    xor a, a
    ld hl, vBGMap0 + $AB
    call WriteVRAMByteInc
    call WriteVRAMByteInc
    call WriteVRAMByteInc
    jr .check_debug_cursor2

.read_debug_value0:
    ld a, [wDebugValue0]
    ld c, a
    ld a, [wDebugValue1]
    ld b, a
    ld de, vBGMap0 + $AB
    call WriteThreeHexDigitsAtDE

.check_debug_cursor2:
    ld a, [wDebugCursor]
    or a, a
    jr z, .read_debug_value2
    ld a, [wDebugSubState]
    bit 3, a
    jr z, .read_debug_value2
    xor a, a
    ld hl, vBGMap0 + $CB
    call WriteVRAMByteInc
    call WriteVRAMByteInc
    call WriteVRAMByteInc
    jr .set_sprite_attr_xor_to_00

.read_debug_value2:
    ld a, [wDebugValue2]
    ld c, a
    ld a, [wDebugValue3]
    ld b, a
    ld de, vBGMap0 + $CB
    call WriteThreeHexDigitsAtDE

.set_sprite_attr_xor_to_00:
    ld a, $00
    ldh [hSpriteAttrXor], a
    ld a, [wDebugState]
    cp a, $03
    jr nz, .read_frame_counter_lo
    ld a, $20
    ldh [hSpriteAttrXor], a
    ld a, $01

.read_frame_counter_lo:
    sla a
    ld c, a
    ld a, [wFrameCounterLo]
    swap a
    and a, $01
    add a, c
    ldh [hSpriteSubIndex], a
    ld a, $20
    ldh [hSpriteTileOffset], a
    ldh a, [hScrollX]
    ld c, a
    ldh a, [hScrollXHi]
    ld b, a
    ld a, c
    add a, $70
    ld c, a
    ld a, b
    adc a, $00
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
    add a, $60
    ld c, a
    ld a, b
    adc a, $00
    ld b, a
    ld a, c
    ldh [hSpriteOriginY], a
    ld a, b
    ldh [hSpriteOriginYHi], a
    ld a, [wDebugValue2]
    and a, $7F
    ldh [hSpriteSetIndex], a
    ld a, [wDebugValue3]
    or a, a
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
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuState, wTemp0, wTemp1, wJoypadPressedRepeat, wFrameCounterLo
; writes: wMenuState, wModeState
; points at: wTemp0, wModeChangeRequest
DebugSoundTest_Update::
Jump_001_64C0:: ; address name
    ld a, [wJoypadPressed]
    and a, $08
    jr z, .check_joypad_pressed_repeat
    ld a, [wMenuState]
    or a, a
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
    and a, $C0
    jr z, .read_menu_state2
    ld a, [wMenuState]
    or a, a
    jr nz, .call_debug_sound_test_update_write_hex_byte
    call DebugSoundTest_Update_WriteHexByteTilesAtDE
    jr .read_menu_state

.call_debug_sound_test_update_write_hex_byte:
    call DebugSoundTest_Update_WriteHexByteTilesAtDE_Sub02

.read_menu_state:
    ld a, [wMenuState]
    xor a, $01
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
    and a, $10
    jr z, .check_joypad_pressed_repeat2
    inc [hl]
    jr .call_queue_sound_effect

.check_joypad_pressed_repeat2:
    ld a, [wJoypadPressedRepeat]
    and a, $20
    jr z, .check_joypad_pressed
    dec [hl]
    jr .call_queue_sound_effect

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and a, $01
    jr z, .check_joypad_pressed2
    xor a, a
    ld [hl], a

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuState]
    ld b, $20
    cp a, $00
    call z, DebugSoundTest_Update_ReadMenuStateAndTemp0Etc
    ld b, $54
    cp a, $01
    call z, DebugSoundTest_Update_ReadMenuStateAndTemp0Etc

.check_joypad_pressed2:
    ld a, [wJoypadPressed]
    and a, $02
    jr z, .check_menu_state
    xor a, a
    ld [wModeState], a
    ld hl, wModeChangeRequest
    inc [hl]
    ret

.check_menu_state:
    ld a, [wMenuState]
    or a, a
    jr nz, DebugSoundTest_Update_WriteHexByteTilesAtDE_CheckFrameCounterLo
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, DebugSoundTest_Update_WriteHexByteTilesAtDE
    xor a, a
    ld hl, vBGMap0 + $E9
    call WriteVRAMByteInc
    call WriteVRAMByte
    jr DebugSoundTest_Update_WriteHexByteTilesAtDE_Sub02_Return

; only called from DebugSoundTest_Update (E-0047)
; 1 call site from 1 routine (e.g. DebugSoundTest_Update)
; reads: wTemp0
DebugSoundTest_Update_WriteHexByteTilesAtDE::
Func_001_6578:: ; address name
    ld a, [wTemp0]
    ld de, vBGMap0 + $E9
    call WriteHexByteTilesAtDE
    jr DebugSoundTest_Update_WriteHexByteTilesAtDE_Sub02_Return

DebugSoundTest_Update_WriteHexByteTilesAtDE_CheckFrameCounterLo::
Jump_001_6583:: ; address name
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, DebugSoundTest_Update_WriteHexByteTilesAtDE_Sub02
    xor a, a
    ld hl, vBGMap0 + $109
    call WriteVRAMByteInc
    call WriteVRAMByte
    jr DebugSoundTest_Update_WriteHexByteTilesAtDE_Sub02_Return

; only called from DebugSoundTest_Update (E-0047)
; 1 call site from 1 routine (e.g. DebugSoundTest_Update)
; reads: wTemp1
DebugSoundTest_Update_WriteHexByteTilesAtDE_Sub02::
Func_001_6596:: ; address name
    ld a, [wTemp1]
    ld de, vBGMap0 + $109
    call WriteHexByteTilesAtDE

DebugSoundTest_Update_WriteHexByteTilesAtDE_Sub02_Return::
Jump_001_659F:: ; address name
    ret

; only called from DebugSoundTest_Update (E-0047)
; 2 call sites from 1 routine (e.g. DebugSoundTest_Update)
; reads: wMenuState, wTemp0, wTemp1
; points at: wTemp0
DebugSoundTest_Update_ReadMenuStateAndTemp0Etc::
Func_001_65A0:: ; address name
    push af
    ld a, [wMenuState]
    ld hl, wTemp0
    add_a_to_hl
    ld a, [hl]
    cp a, b
    jr nz, .skip
    ld [hl], $00

.skip:
    ld a, [hl]
    cp a, $FF
    jr nz, .check_menu_state
    dec b
    ld [hl], b

.check_menu_state:
    ld a, [wMenuState]
    or a, a
    jr nz, .read_temp1
    ld hl, DebugSoundTestMusic
    ld de, vBGMap0 + $EC
    ld a, [wTemp0]
    jr .call_write_hex_byte_tiles_at_de

.read_temp1:
    ld hl, DebugSoundTestEffects
    ld de, vBGMap0 + $10C
    ld a, [wTemp1]

.call_write_hex_byte_tiles_at_de:
    add_a_to_hl
    ld a, [hl]
    call WriteHexByteTilesAtDE
    pop af
    ret

; E-0238 (C1: DebugSoundTest_Update passes the byte at $65DE + wTemp0 to QueueMusic after InitSoundHardware, and DebugSoundTest_Update_Sub03 draws it in hex; 32 entries).
; record: music number
DebugSoundTestMusic::
Data_001_65DE:: ; address name
    db $02 ; id 0
    db $06 ; id 1
    db $09 ; id 2
    db $0C ; id 3
    db $0F ; id 4
    db $13 ; id 5
    db $16 ; id 6
    db $19 ; id 7
    db $1C ; id 8
    db $1F ; id 9
    db $22 ; id 10
    db $25 ; id 11
    db $28 ; id 12
    db $2B ; id 13
    db $2E ; id 14
    db $31 ; id 15
    db $35 ; id 16
    db $3D ; id 17
    db $40 ; id 18
    db $42 ; id 19
    db $44 ; id 20
    db $46 ; id 21
    db $48 ; id 22
    db $4A ; id 23
    db $4D ; id 24
    db $50 ; id 25
    db $52 ; id 26
    db $54 ; id 27
    db $58 ; id 28
    db $CC ; id 29
    db $CF ; id 30
    db $D6 ; id 31

; E-0238 (C1: DebugSoundTest_Update passes the byte at $65FE + wTemp1 to QueueSoundEffect, and the code at DebugSoundTest_Update_ReadMenuStateAndTemp0Etc.read_temp1 draws it in hex at vBGMap0 + $10C; 84 entries up to the next routine).
; record: sound effect number
DebugSoundTestEffects::
Data_001_65FE:: ; address name
    db $00 ; id 0
    db $60 ; id 1
    db $61 ; id 2
    db $62 ; id 3
    db $63 ; id 4
    db $65 ; id 5
    db $66 ; id 6
    db $67 ; id 7
    db $69 ; id 8
    db $6A ; id 9
    db $6B ; id 10
    db $6C ; id 11
    db $6D ; id 12
    db $70 ; id 13
    db $72 ; id 14
    db $74 ; id 15
    db $76 ; id 16
    db $78 ; id 17
    db $7A ; id 18
    db $7B ; id 19
    db $7C ; id 20
    db $7D ; id 21
    db $7E ; id 22
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
    db $8B ; id 33
    db $8D ; id 34
    db $8F ; id 35
    db $90 ; id 36
    db $91 ; id 37
    db $93 ; id 38
    db $94 ; id 39
    db $95 ; id 40
    db $96 ; id 41
    db $97 ; id 42
    db $98 ; id 43
    db $99 ; id 44
    db $9A ; id 45
    db $9B ; id 46
    db $9D ; id 47
    db $9E ; id 48
    db $9F ; id 49
    db $A1 ; id 50
    db $A2 ; id 51
    db $A3 ; id 52
    db $A4 ; id 53
    db $A5 ; id 54
    db $A7 ; id 55
    db $A8 ; id 56
    db $A9 ; id 57
    db $AA ; id 58
    db $AB ; id 59
    db $AC ; id 60
    db $AE ; id 61
    db $B0 ; id 62
    db $B1 ; id 63
    db $B2 ; id 64
    db $B4 ; id 65
    db $B6 ; id 66
    db $B8 ; id 67
    db $BA ; id 68
    db $BC ; id 69
    db $BD ; id 70
    db $BF ; id 71
    db $C1 ; id 72
    db $C3 ; id 73
    db $C5 ; id 74
    db $C7 ; id 75
    db $C9 ; id 76
    db $CB ; id 77
    db $D2 ; id 78
    db $D4 ; id 79
    db $D9 ; id 80
    db $DA ; id 81
    db $DC ; id 82
    db $DD ; id 83

; update for debug-mode state 6: the screen shows '? BATTLE ?' (number of foes, three monsters, skill, levels) (E-0041)
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wWorkBuf, wMenuState, wJoypadPressedRepeat, wJoypadHeld, wFrameCounterLo
; writes: wEncounterKind, wBattleKind, wMenuState, wDebugCursor, wDebugValue0, wDebugValue1, wGameMode, wModeState, ...
; points at: wEncounterMonsters, wModeChangeRequest, wBGFillFlag, wWorkBuf
DebugBattleSetup_Update::
Jump_001_6652:: ; address name
    ld a, [wJoypadPressed]
    and a, $08
    jp z, DebugBattleSetupLoadWords_CheckJoypadPressed
    ld a, [wWorkBuf]
    ld [wEncounterKind], a
    ld a, [wWorkBuf + $8]
    sra a
    ld [wBattleKind], a
    or a, a
    jr nz, DebugBattleSetupLoadWords_SetEncounterMonsters
    ld hl, wEncounterMonsters
    ld de, wWorkBuf + $2
    call DebugBattleSetupLoadWords
    call DebugBattleSetupLoadWords
    call DebugBattleSetupLoadWords

DebugBattleSetup_Update_ClearMenuState::
Jump_001_667A:: ; address name
    xor a, a
    ld [wMenuState], a
    xor a, a
    ld [wDebugCursor], a
    ld [wDebugValue0], a
    ld [wDebugValue1], a
    ld a, [wWorkBuf + $8]
    or a, a
    jr nz, .call_debug_battle_setup_update_write_map_id
    call DebugBattleSetup_Update_Sub01_SRAMRecordAddressMapped_Sub01
    jr .set_game_mode_to_04

.call_debug_battle_setup_update_write_map_id:
    call DebugBattleSetup_Update_WriteMapIdAndMapScreenXEtc

.set_game_mode_to_04:
    ld a, $04
    ld [wGameMode], a
    xor a, a
    ld [wModeState], a
    ld a, $04
    call StartPaletteFade
    ld hl, wModeChangeRequest
    inc [hl]
    ld hl, wBGFillFlag
    inc [hl]
    ret

; debug battle setup: copies a word from DE to HL (a zero word becomes 1); the following entries load the setup into wCFDD-wCFE5 and handle input (E-0131)
; 6 call sites from 2 routines (e.g. DebugBattleSetup_Update, DebugBattleSetupLoadWords)
DebugBattleSetupLoadWords::
Func_001_66AD:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    ld c, a
    ld a, [de]
    inc de
    ld [hl+], a
    or a, c
    ret nz
    dec hl
    dec hl
    ld [hl], $01
    inc hl
    inc hl
    ret

DebugBattleSetupLoadWords_SetEncounterMonsters::
Jump_001_66BD:: ; address name
    ld hl, wWorkBuf + $C
    ld a, [hl+]
    ld [wEncounterMonsters], a
    ld a, [hl+]
    ld [wEncounterMonsters + $1], a
    ld a, [hl+]
    ld [wWildLevel], a
    inc hl
    ld a, [hl+]
    ld [wEncounterMonsters + $2], a
    ld a, [hl+]
    ld [wEncounterMonsters + $3], a
    ld a, [hl+]
    ld [wWildBand], a
    inc hl
    ld a, [hl+]
    ld [wEncounterMonsters + $4], a
    ld a, [hl+]
    ld [wEncounterMonsters + $5], a
    ld a, [hl+]
    ld [wWildByteE5], a
    jr DebugBattleSetup_Update_ClearMenuState

DebugBattleSetupLoadWords_CheckJoypadPressed::
Jump_001_66E8:: ; address name
    ld a, [wJoypadPressed]
    and a, $01
    jr z, .check_joypad_pressed
    ld a, [wMenuState]
    add a, a
    ld hl, wWorkBuf
    add_a_to_hl
    xor a, a
    ld [hl+], a
    ld [hl], a
    jp .clear_frame_counter_lo

.check_joypad_pressed:
    ld a, [wJoypadPressed]
    and a, $02
    jr z, .check_joypad_pressed_repeat
    ld a, [wWorkBuf]
    ld [wEncounterKind], a
    ld hl, wEncounterMonsters
    ld de, wWorkBuf + $2
    call DebugBattleSetupLoadWords
    call DebugBattleSetupLoadWords
    call DebugBattleSetupLoadWords
    xor a, a
    ld [wDebugCursor], a
    ld [wDebugValue0], a
    ld [wDebugValue1], a
    xor a, a
    ld [wMenuState], a
    xor a, a
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
    cp a, $FF
    jr nz, .set_menu_state
    ld a, $0B

.set_menu_state:
    ld [wMenuState], a
    jp .clear_frame_counter_lo

.check_bit7:
    bit 7, a
    jr z, .skip
    call DrawDebugValueHexForMenuState
    ld a, [wMenuState]
    inc a
    cp a, $0C
    jr nz, .set_menu_state2
    xor a, a

.set_menu_state2:
    ld [wMenuState], a
    jp .clear_frame_counter_lo

.skip:
    and a, $30
    jr z, .read_menu_state
    ld a, [wMenuState]
    add a, a
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
    add a, a
    add_a_to_hl
    deref_hl
    ld a, [wFrameCounterLo]
    bit 3, a
    jr nz, .read_menu_state2
    xor a, a
    call WriteVRAMByteInc
    call WriteVRAMByteInc
    call WriteVRAMByte
    jr .return

.read_menu_state2:
    push hl
    ld a, [wMenuState]
    add a, a
    ld hl, wWorkBuf
    add_a_to_hl
    ld c, [hl]
    inc hl
    ld b, [hl]
    pop de
    call WriteThreeHexDigitsAtDE
    jr .return

.clear_frame_counter_lo:
    xor a, a
    ld [wFrameCounterLo], a
    call DebugBattleSetupShowFieldString

.return:
    ret

; writes the word wD09D[wC46B] as three hex digits at the address Data_001_68D3[wC46B] (E-0122)
; 4 call sites from 1 routine (e.g. DebugBattleSetupLoadWords)
; reads: wMenuState
; points at: wWorkBuf
DrawDebugValueHexForMenuState::
Func_001_6809:: ; address name
    ld a, [wMenuState]
    ld hl, DebugBattleSetupLoadWords_Data
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, [wMenuState]
    ld hl, wWorkBuf
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    call WriteThreeHexDigitsAtDE
    ret

; stores Data_001_68EB[wC46B] - DE at HL (floored at 0; DE = $FFFF stores the limit) (E-0125)
; 2 call sites from 1 routine (e.g. DebugBattleSetupLoadWords)
; reads: wMenuState
SubtractDEFromDebugLimit::
Func_001_682B:: ; address name
    push hl
    ld a, [wMenuState]
    ld hl, SubtractDEFromDebugLimit_Data
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    ld a, d
    and a, e
    cp a, $FF
    jr z, .skip
    ld a, c
    sub a, e
    ld c, a
    ld a, b
    sbc a, d
    ld b, a
    bit 7, b
    jr z, .restore
    xor a, a
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

; clamps the word DE to 0 .. Data_001_68EB[wC46B] (negative becomes the limit) and stores it at HL (E-0124)
; 2 call sites from 1 routine (e.g. DebugBattleSetupLoadWords)
; reads: wMenuState
ClampDebugValueToTableLimit::
Func_001_6857:: ; address name
    push hl
    ld a, [wMenuState]
    ld hl, SubtractDEFromDebugLimit_Data
    add a, a
    add_a_to_hl
    ld a, [hl+]
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
    xor a, a
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

; only called from DebugBattleSetup_Update (E-0047)
; 1 call site from 1 routine (e.g. DebugBattleSetup_Update)
; reads: wPartyCount, wFarmLevel, hTemp0
; points at: wPartyList
DebugBattleSetup_Update_Sub01_SRAMRecordAddressMapped_Sub01::
Func_001_6880:: ; address name
    ld a, [wPartyCount]
    or a, a
    jr z, .call_check_save_data
    cp a, $04
    jr nc, .call_check_save_data
    ld b, a
    ld hl, wPartyList
    ld a, [wFarmLevel]
    cp a, $03
    jr nc, .call_check_save_data
    ld c, $0A
    cp a, $00
    jr z, .loop
    ld c, $14
    cp a, $01
    jr z, .loop
    ld c, $1E

.loop:
    ld a, [hl+]
    cp a, c
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
    or a, a
    jr nz, .call_debug_battle_setup_update_write_map_id
    farcall RunSaveSteps
    ret

.call_debug_battle_setup_update_write_map_id:
    call DebugBattleSetup_Update_WriteMapIdAndMapScreenXEtc
    ret

; only called from DebugBattleSetup_Update_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. DebugBattleSetup_Update_Sub01_SRAMRecordAddressMapped_Sub01)
DebugBattleSetup_Update_Sub01_SRAMRecordAddressMapped::
Func_001_68CA:: ; address name
    ld c, MON_STATE
    call SRAMRecordAddressMapped
    ld a, [hl]
    cp a, $02
    ret

; address loaded by DebugBattleSetupLoadWords, DrawDebugValueHexForMenuState
DebugBattleSetupLoadWords_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_001_68D3:: ; address name
    db $87, $98, $A7, $98, $C7, $98, $E7, $98, $07, $99, $27, $99, $47, $99, $67, $99
    db $87, $99, $A7, $99, $C7, $99, $E7, $99

; address loaded by SubtractDEFromDebugLimit, ClampDebugValueToTableLimit
SubtractDEFromDebugLimit_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_001_68EB:: ; address name
    db $02, $00, $AB, $02, $AB, $02, $AB, $02, $01, $00, $00, $00, $40, $01, $63, $00
    db $40, $01, $63, $00, $40, $01, $63, $00

; debug battle setup: shows the string for field wC46B (wD09D entries, ShowString_Bank88) at the window from Data_001_6A6C, with special cases for fields 4-6 (E-0131)
; 9 call sites from 2 routines (e.g. DebugBattleSetupLoadWords, DebugBattleSetup_Init)
; reads: wMenuState, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wWorkBuf
; writes: wStringIndex, wStringCategory, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; points at: wWorkBuf
DebugBattleSetupShowFieldString::
Func_001_6903:: ; address name
    ld a, [wMenuState]
    or a, a
    ret z
    cp a, $04
    jr z, .read_work_buf
    cp a, $05
    jp z, .clear_string_index
    cp a, $06
    jp nc, .read_menu_state
    ld hl, wWorkBuf
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld h, [hl]
    ld [wStringIndex], a
    ld a, h
    ld [wStringCategory], a
    ld hl, DebugBattleSetupShowFieldString_Data_6A6C
    ld a, [wMenuState]
    dec a
    add a, a
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
    ld hl, vTiles2 + $3C0
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
    xor a, a
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
    add a, a
    add_a_to_hl
    ld a, [wMenuState]
    cp a, $07
    jr z, .call_divide_b_by_a
    cp a, $09
    jr z, .call_divide_b_by_a
    cp a, $0B
    jr z, .call_divide_b_by_a
    ld a, [hl+]
    ld [wStringIndex], a
    ld a, [hl]
    add a, $02
    ld [wStringCategory], a
    ld a, [wMenuState]
    sub a, $06
    ld hl, DebugBattleSetupShowFieldString_Data_6A72
    add_a_to_hl
    deref_hl
    ld de, $0901
    jr .read_text_window_tile_lo

.call_divide_b_by_a:
    ld b, [hl]
    ld a, $0A
    call DivideBByA
    ld c, a
    push bc
    ld a, [wMenuState]
    sub a, $07
    ld hl, DebugBattleSetupShowFieldString_Data_6A78
    add_a_to_hl
    deref_hl
    pop bc
    ld a, b
    add a, $10
    call WriteVRAMByteInc
    ld a, c
    add a, $10
    call WriteVRAMByte
    ret

; address loaded by DebugBattleSetupShowFieldString
DebugBattleSetupShowFieldString_Data_6A6C:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_001_6A6C:: ; address name
    db $00, $92, $A0, $92, $30, $93

; address loaded by DebugBattleSetupShowFieldString
DebugBattleSetupShowFieldString_Data_6A72:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_001_6A72:: ; address name
    db $E0, $94, $70, $95, $00, $96

; address loaded by DebugBattleSetupShowFieldString
DebugBattleSetupShowFieldString_Data_6A78:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_001_6A78:: ; address name
    db $6B, $99, $AB, $99, $EB, $99

; DE = VRAM address: writes A as two hex-digit tiles ($10 + high nibble, then $10 + low nibble), each after WaitForVRAMAccess; DE ends on the second tile (E-0071)
; 20 call sites from 11 routines (e.g. DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub03, DebugMessageTest_Update_Case21_ReadMenuStateAndTemp0Etc, DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE_Sub02, DebugMessageTest_Update_Case21_WriteHexByteTilesAtDE, ...)
WriteHexByteTilesAtDE::
Func_001_6A7E:: ; address name
    push af
    swap a
    and a, $0F
    add a, $10
    push af
    call WaitForVRAMAccess
    pop af
    ld [de], a
    inc de
    pop af
    and a, $0F
    add a, $10
    push af
    call WaitForVRAMAccess
    pop af
    ld [de], a
    ret

; writes the low nibble of B, then both nibbles of C, as tiles $10 + nibble at DE (WaitForVRAMAccess each); DE ends on the last tile (E-0120)
; 7 call sites from 5 routines (e.g. DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD, DrawDebugFieldValueDebugCursor, DrawDebugValueHexForMenuState, DebugBattleSetupLoadWords, ...)
WriteThreeHexDigitsAtDE::
Func_001_6A98:: ; address name
    ld a, b
    and a, $0F
    add a, $10
    push af
    call WaitForVRAMAccess
    pop af
    ld [de], a
    inc de
    ld a, c
    swap a
    and a, $0F
    add a, $10
    push af
    call WaitForVRAMAccess
    pop af
    ld [de], a
    inc de
    ld a, c
    and a, $0F
    add a, $10
    push af
    call WaitForVRAMAccess
    pop af
    ld [de], a
    ret

; only called from routines of DebugBattleSetup_Update (E-0098)
; 2 call sites from 2 routines (e.g. DebugBattleSetup_Update_Sub01_SRAMRecordAddressMapped_Sub01, DebugBattleSetup_Update)
; writes: hMapId, hMapScreenX, hMapScreenY, hPlayerX, hPlayerY, wFollowerRecords, wPlayerName, wGoldLo, ...
DebugBattleSetup_Update_WriteMapIdAndMapScreenXEtc::
Func_001_6ABE:: ; address name
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
    ld [wFollowerRecords + $A], a
    ld a, $40
    ld [wFollowerRecords + $B], a
    ld a, $40
    ld [wFollowerRecords + $C], a
    ld a, $24
    ld [wPlayerName], a
    ld a, $35
    ld [wPlayerName + $1], a
    ld a, $8D
    ld [wPlayerName + $2], a
    ld a, $2F
    ld [wPlayerName + $3], a
    ld a, $2B
    ld [wPlayerName + $4], a
    ld a, $55
    ld [wPlayerName + $5], a
    ld a, $F0
    ld [wPlayerName + $6], a
    ld a, $F0
    ld [wPlayerName + $7], a
    ld a, $F0
    ld [wPlayerName + $8], a
    ld a, $F0
    ld [wPlayerName + $9], a
    ld a, $9F
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
    ld a, $1F
    ld [wInventory + $7], a
    ld a, $09
    ld [wInventory + $8], a
    ld a, $33
    ld [wInventory + $9], a
    ld a, $0B
    ld [wEventItemSlot], a
    ld a, $20
    ld [wInventory + $B], a
    ld a, $28
    ld [wInventory + $C], a
    ld a, $0E
    ld [wInventory + $D], a
    ld a, $0F
    ld [wInventory + $E], a
    ld a, $10
    ld [wInventory + $F], a
    ld a, $11
    ld [wInventory + $10], a
    ld a, $12
    ld [wInventory + $11], a
    ld a, $1C
    ld [wInventory + $12], a
    ld a, $1C
    ld [wInventory + $13], a
    ld a, $1C
    ld [wInventory + $14], a
    ld a, $0C
    ld [wSaveByte32], a
    ld a, $0C
    ld [wInventory + $16], a
    ld a, $0C
    ld [wInventory + $17], a
    ld a, $50
    ld [wArenaWinsLo], a
    xor a, a
    ld [wArenaWinsHi], a
    call DebugBattleSetup_Update_FillKeyListFromTable
    call DebugBattleSetup_Update_Shared01_PickRandomMonsterSkipping7ETo82
    ret

; only called from DebugBattleSetup_Update_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. DebugBattleSetup_Update_WriteMapIdAndMapScreenXEtc)
; writes: wBattleArg0, rRAMG, rRAMB
; points at: wBattleArg0, sRecords
DebugBattleSetup_Update_Shared01_PickRandomMonsterSkipping7ETo82::
Func_001_6BDC:: ; address name
    ld b, $1E
    xor a, a
    ld [wBattleArg0], a

.loop:
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    push bc
    call PickRandomMonsterSkipping7ETo82
    pop bc
    xor a, a
    ld [rRAMG], a
    ld hl, wBattleArg0
    inc [hl]
    dec b
    jr nz, .loop
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld hl, sRecords
    ld de, $00A5
    ld [hl], $02
    add hl, de
    ld [hl], $02
    add hl, de
    ld [hl], $02
    ld b, $1B

.loop2:
    add hl, de
    ld [hl], $01
    dec b
    jr nz, .loop2
    xor a, a
    ld [rRAMG], a
    ret

; draws random ids until one is non-zero and not $7E-$82, then creates that record (Func_001_6E82) (E-0124)
; 1 call site from 1 routine (e.g. DebugBattleSetup_Update_Shared01_PickRandomMonsterSkipping7ETo82)
; reads: wRandomLo, wRandomHi
PickRandomMonsterSkipping7ETo82::
Func_001_6C1F:: ; address name
    call NextTableByte
    ld a, [wRandomLo]
    ld e, a
    ld a, [wRandomHi]
    or a, e
    ld e, a
    or a, a
    jr z, PickRandomMonsterSkipping7ETo82
    cp a, $7E
    jr z, PickRandomMonsterSkipping7ETo82
    cp a, $7F
    jr z, PickRandomMonsterSkipping7ETo82
    cp a, $80
    jr z, PickRandomMonsterSkipping7ETo82
    cp a, $81
    jr z, PickRandomMonsterSkipping7ETo82
    cp a, $82
    jr z, PickRandomMonsterSkipping7ETo82
    ld d, $00
    call PickRandomMonsterSkipping7ETo82_WriteBattleArg1AndBattleArg2Etc
    ret

; only called from CreateMonsterRecordOfKindTemp1_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. CreateMonsterRecordOfKindTemp1_WriteBattleArg0)
; reads: hTemp3, wBattleArg0, wRecordBuffer, wBattleArg1, wRandomHi, wRecordBufferData, wScreenAttrBuffer, wBattleArg2, ...
; writes: wMonsterId, wRecordBufA, wSpeciesIdLo, wSpeciesIdHi, wWorkBuf
; points at: wPlayerName
CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord::
Func_001_6C48:: ; address name
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
    add a, $0B
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wRecordBuffer]
    ld [hl+], a
    ld a, [wRecordBuffer + $1]
    ld [hl+], a
    inc hl
    ld a, [wBattleArg1]
    cp a, $FF
    jr nz, .skip
    ld a, [wRandomHi]
    and a, $01
    jr .skip2

.skip:
    push hl
    ld hl, CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data_70AA
    add_a_to_hl
    ld a, [hl]
    pop hl

.skip2:
    ld [hl+], a
    ld de, wPlayerName
    ld b, $0B
    call CopyBBytesDEToHL_Bank01
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    call WriteUnknownNamePlaceholder_Bank01
    call WriteUnknownNamePlaceholder_Bank01
    ld a, [wRecordBufferData]
    ld [hl+], a
    ld a, [wRecordBufferData + $1]
    ld [hl+], a
    ld a, [wRecordBufferData + $2]
    ld [hl+], a
    ld a, [wRecordBufferData + $3]
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    ld a, l
    add a, $19
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    xor a, a
    ld [hl+], a
    ld a, [wRecordBufferData + $7]
    ld [hl+], a
    ld [wRecordBufA + MON_LEVEL], a
    ld a, l
    add a, $04
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wRecordBufferData + $8]
    ld e, a
    ld a, [wRecordBufferData + $9]
    ld d, a
    ld a, d
    cp a, $04
    jr c, .skip3
    ld de, $03E7

.skip3:
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a
    ld a, [wRecordBufferData + $A]
    ld [hl+], a
    ld a, [wRecordBufferData + $B]
    ld [hl+], a
    ld a, [wRecordBufferData + $A]
    ld [hl+], a
    ld a, [wRecordBufferData + $B]
    ld [hl+], a
    ld a, [wRecordBufferData + $C]
    ld [hl+], a
    ld a, [wRecordBufferData + $D]
    ld [hl+], a
    ld a, [wRecordBufferData + $E]
    ld [hl+], a
    ld a, [wRecordBufferData + $F]
    ld [hl+], a
    ld a, [wRecordBufferData + $10]
    ld [hl+], a
    ld a, [wRecordBufferData + $11]
    ld [hl+], a
    ld a, [wScreenAttrBuffer]
    ld [hl+], a
    ld a, [wRecordBufferData + $13]
    ld [hl+], a
    ld a, [wBattleArg2]
    or a, a
    jr z, .skip4
    push hl
    call NextTableByte
    pop hl
    ld a, [wRandomLo]
    ld [hl+], a
    ld a, [wRandomHi]
    and a, $01
    ld [hl+], a
    jr .skip5

.skip4:
    xor a, a
    ld [hl+], a
    ld [hl+], a

.skip5:
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ld a, [wRecordBufferData + $14]
    ld [hl+], a
    ld a, [wRecordBufferData + $15]
    ld [hl+], a
    ld a, [wRecordBufferData + $16]
    ld [hl+], a
    ld a, [wRecordBufferData + $17]
    ld [hl+], a
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
    add a, $2F
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wSpeciesRecord + SPECIES_SKILLS]
    ld [hl+], a
    ld a, [wSpeciesRecord + SPECIES_SKILLS + 1]
    ld [hl+], a
    ld a, [wSpeciesRecord + SPECIES_SKILLS + 2]
    ld [hl+], a
    ld b, $16
    ld a, $FF
    call FillBBytesAtHL_Bank01
    ld a, l
    add a, $02
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wSpeciesRecord + SPECIES_MAX_LEVEL]
    ld [hl], a
    ld a, l
    add a, $1C
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld de, wSpeciesRecord + SPECIES_RESISTANCES
    ld b, $1B
    call CopyBBytesDEToHL_Bank01
    call WriteUnknownNamePlaceholder_Bank01
    call WriteUnknownNamePlaceholder_Bank01
    ld [hl], $00
    ld a, [wBattleArg1]
    cp a, $FF
    jr nz, .skip6
    call NextTableByte
    ld a, [wRandomLo]
    ld b, a
    ld a, $0E
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
    ld hl, CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data_70B3
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld a, l
    sub a, $A3
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
    ld b, $0A
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
    farcall LoadTable4E60EntryForWC991ToWC9DE
    ld a, [wBattleArg0]
    ld c, MON_EXP
    call SRAMRecordAddress
    ld a, [wRecordBufA + MON_EXP]
    ld [hl+], a
    ld a, [wRecordBufA + MON_EXP + 1]
    ld [hl+], a
    ld a, [wRecordBufA + MON_EXP + 2]
    ld [hl+], a
    farcall SetSpeciesFlag
    ret

; DE = source, HL = destination, B = count: copies B bytes (B = 0 copies 256); DE and HL end past the copy; clobbers A, B = 0 (E-0064) (the same 7 bytes appear in 4 banks)
; 3 call sites from 1 routine (e.g. CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord)
CopyBBytesDEToHL_Bank01::
Func_001_6E25:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, CopyBBytesDEToHL_Bank01
    ret

; stores A in B bytes from HL (B = 0 fills 256); HL ends past the fill, B = 0 (E-0065) (the same 5 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord)
FillBBytesAtHL_Bank01::
Func_001_6E2C:: ; address name
    ld [hl+], a
    dec b
    jr nz, FillBBytesAtHL_Bank01
    ret

; writes '???' ($98 x 3), seven $F0 bytes and a 0 at HL (E-0122)
; 4 call sites from 1 routine (e.g. CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord)
WriteUnknownNamePlaceholder_Bank01::
Func_001_6E31:: ; address name
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $F0
    ld b, $07

.loop:
    ld [hl+], a
    dec b
    jr nz, .loop
    ld a, $00
    ld [hl+], a
    ret

; with SRAM enabled creates a record from the template Data_001_7098[hFFC7] (wD869 = hFFC7, level hFFC8); kinds 1 and 2 also set field $6E = 1 (E-0124)
; 11 call sites from 11 routines (e.g. GreatLogTalkEvents_ShowTheFarmIsFull, GreatLogTalkEvents_TestFlagBit_Case42, AddRecordArg5AsFollower, UnreferencedScriptStepDispatch_73_6D52_ClearArg5IfAtOrAboveLimitForFarmLevel, ...)
; reads: hTemp1, hTemp2, wBattleArg0
; writes: rRAMG, rRAMB, wBattleArg1, wBattleArg2
CreateMonsterRecordOfKindTemp1::
Func_001_6E46:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ldh a, [hTemp1]
    ld [wBattleArg1], a
    ld hl, CreateMonsterRecordOfKindTemp1_Data
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    xor a, a
    ld [wBattleArg2], a
    ldh a, [hTemp2]
    call CreateMonsterRecordOfKindTemp1_WriteBattleArg0
    ldh a, [hTemp1]
    cp a, $01
    jr z, .read_battle_arg0
    cp a, $02
    jr nz, .done

.read_battle_arg0:
    ld a, [wBattleArg0]
    ld c, MON_EGG
    call SRAMRecordAddress
    ld [hl], $01

.done:
    xor a, a
    ld [rRAMG], a
    ret

; only called from PickRandomMonsterSkipping7ETo82 (E-0047)
; 1 call site from 1 routine (e.g. PickRandomMonsterSkipping7ETo82)
; reads: wBattleArg0
; writes: wBattleArg1, wBattleArg2, hTemp3, wBattleArg0
PickRandomMonsterSkipping7ETo82_WriteBattleArg1AndBattleArg2Etc::
Func_001_6E82:: ; address name
    ld a, $FF
    ld [wBattleArg1], a
    ld [wBattleArg2], a
    ld a, $01
    ldh [hTemp3], a
    ld a, [wBattleArg0]

; only called from CreateMonsterRecordOfKindTemp1 (E-0047)
; 1 call site from 1 routine (e.g. CreateMonsterRecordOfKindTemp1)
; writes: wBattleArg0
CreateMonsterRecordOfKindTemp1_WriteBattleArg0::
Func_001_6E91:: ; address name
    ld [wBattleArg0], a
    call CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord
    ret

; copies 128 bytes (32 four-byte entries) from its table into wKeyList
; 1 call site from 1 routine (e.g. DebugBattleSetup_Update_WriteMapIdAndMapScreenXEtc)
; points at: wKeyList
DebugBattleSetup_Update_FillKeyListFromTable::
Func_001_6E98:: ; address name
    ld de, DebugBattleSetup_Update_FillKeyListFromTable_Data
    ld hl, wKeyList
    ld b, $20

.loop:
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
    dec b
    jr nz, .loop
    ret

; address loaded by DebugBattleSetup_Update_FillKeyListFromTable
DebugBattleSetup_Update_FillKeyListFromTable_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_001_6EB0:: ; address name
    ds $80, $FF

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 20 x 18 tiles, one row per line
TileRect_01_6F30::
Data_001_6F30:: ; address name
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 1
    db $00, $11, $12, $13, $35, $0E, $00, $00, $00, $00, $A0, $A1, $A2, $A3, $A4, $A5, $A6, $A7, $A8, $00 ; id 2
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 3
    db $00, $14, $15, $16, $17, $18, $19, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 4
    db $00, $1A, $1B, $1C, $1D, $14, $1E, $1F, $20, $15, $12, $00, $00, $00, $80, $81, $82, $83, $84, $00 ; id 5
    db $00, $14, $1E, $1F, $20, $15, $12, $21, $22, $23, $00, $00, $00, $00, $00, $85, $86, $87, $88, $00 ; id 6
    db $00, $14, $24, $16, $1A, $25, $00, $00, $00, $00, $00, $00, $00, $00, $00, $89, $8A, $8B, $8C, $00 ; id 7
    db $00, $33, $29, $34, $29, $28, $1D, $29, $00, $00, $00, $8D, $8E, $8F, $90, $91, $92, $93, $94, $00 ; id 8
    db $00, $26, $16, $27, $28, $1D, $29, $00, $00, $00, $00, $95, $96, $97, $98, $99, $9A, $9B, $9C, $00 ; id 9
    db $00, $2A, $2B, $2C, $36, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 10
    db $00, $2A, $2B, $2C, $36, $03, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 11
    db $00, $2A, $2B, $2C, $36, $04, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 12
    db $00, $2A, $2B, $2C, $36, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 13
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $31, $29, $14, $15, $16, $00, $31, $29, $32, $29, $00 ; id 14
    db $00, $2D, $27, $2E, $1A, $30, $26, $16, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 15
    db $00, $2F, $25, $1A, $30, $26, $16, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 16
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 17

; address loaded by CreateMonsterRecordOfKindTemp1
CreateMonsterRecordOfKindTemp1_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_001_7098:: ; address name
    db $83, $01, $63, $02, $64, $02, $58, $02, $59, $02, $1B, $00, $7A, $02, $79, $02
    db $78, $02

; address loaded by CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord
CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data_70AA:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_001_70AA:: ; address name
    db $00, $00, $01, $00, $00, $00, $01, $00, $00

; address loaded by CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord
CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data_70B3:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_001_70B3:: ; address name
    dw CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data_70B3_Entry00
    dw CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data_70B3_Entry01
    dw CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data_70B3_Entry02
    dw CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data_70B3_Entry03
    dw CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data_70B3_Entry04
    dw CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data_70B3_Entry05
    dw CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data_70B3_Entry06
    dw CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data_70B3_Entry07
    dw CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data_70B3_Entry08

CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data_70B3_Entry00:: ; heuristic: target of a monotone pointer table; C0
Data_001_70C5:: ; address name
    db $0B, $2C, $2C, $31, $32, $F0, $F0, $F0, $F0, $F0

CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data_70B3_Entry01:: ; heuristic: target of a monotone pointer table; C0
Data_001_70CF:: ; address name
    db $0E, $2A, $2A, $F0, $F0, $F0, $F0, $F0, $F0, $F0

CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data_70B3_Entry02:: ; heuristic: target of a monotone pointer table; C0
Data_001_70D9:: ; address name
    db $0E, $2A, $2A, $F0, $F0, $F0, $F0, $F0, $F0, $F0

CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data_70B3_Entry03:: ; heuristic: target of a monotone pointer table; C0
Data_001_70E3:: ; address name
    db $20, $24, $35, $38, $0B, $F0, $F0, $F0, $F0, $F0

CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data_70B3_Entry04:: ; heuristic: target of a monotone pointer table; C0
Data_001_70ED:: ; address name
    db $19, $28, $37, $2C, $0B, $F0, $F0, $F0, $F0, $F0

CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data_70B3_Entry05:: ; heuristic: target of a monotone pointer table; C0
Data_001_70F7:: ; address name
    db $1C, $34, $38, $2C, $3D, $F0, $F0, $F0, $F0, $F0

CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data_70B3_Entry06:: ; heuristic: target of a monotone pointer table; C0
Data_001_7101:: ; address name
    db $15, $24, $30, $2C, $24, $F0, $F0, $F0, $F0, $F0

CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data_70B3_Entry07:: ; heuristic: target of a monotone pointer table; C0
Data_001_710B:: ; address name
    db $1C, $24, $37, $30, $24, $F0, $F0, $F0, $F0, $F0

CreateMonsterRecordOfKindTemp1_Sub01_LoadMonsterRecord_Data_70B3_Entry08:: ; heuristic: target of a monotone pointer table; C0
Data_001_7115:: ; address name
    db $0B, $35, $24, $25, $32, $F0, $F0, $F0, $F0, $F0
    ds $4A6, $00

; address loaded by DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD
DebugResultsDisplay_Update_Sub02_ReadDebugCursorAndScreenByteBD_Data_75C5:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_001_75C5:: ; address name
    ds $A3B, $00
