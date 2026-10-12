SECTION "Bank 03", ROMX[$4000], BANK[$03]
    db $03

; start-up for wGameMode = 2; forcing this mode on the emulator shows: monster status panel (incomplete when forced) (E-0029)
; 1 call site from 1 routine (e.g. RunGameModeInit_ToGameMode2_Init)
; writes: wDataBankSave, wTextCursorLo, wTextCursorHi
GameMode2_Init::
Func_003_4001:: ; address name
    xor a, a
    ld [wDataBankSave], a
    ld hl, vBGMap0 + $1C1
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    ld a, $01
    jp Jump_000_077A

; per-frame routine for wGameMode = 2
; 1 call site from 1 routine (e.g. RunGameModeUpdate_ToGameMode2_Update)
; reads: wGameMode2State, wModeState, wIsCGB, hScrollY, hScrollX, wScriptTemp4, wStoryFlags, wSpriteSlotCount
; writes: wSpriteSlotCount, wBGPaletteUploadRequest, rVBK, hScrollX, hScrollY, wMenuSelectedMember, wMenuCursor, wSubMenuCursor, ...
; points at: wBGPaletteBuffer, wScreenTileBuffer, wGameMode2State, wTemp0, wWorkBuf
GameMode2_Update::
Func_003_4015:: ; address name
    ld a, [wGameMode2State]
    bit 7, a
    jr z, Jump_003_4036
    call GameMode2_Update_Sub01
    ld a, [wModeState]
    and a, $07
    rst $00
    dw PauseMenu_Main
    dw PauseMenu_Items
    dw PauseMenu_Skills
    dw PauseMenu_State3
    dw PauseMenu_State4

; GameMode2_Update, wModeState 4: hands over to Func_0F1_4001 (state 4) (E-0046)
; no direct call (reached through a table, a jump or a vector)
PauseMenu_State4::
Jump_003_402F:: ; address name
    farcall PauseMenu_State4_Sub02
    ret

Jump_003_4036::
    ld a, [wGameMode2State]
    or a, a
    jp nz, Jump_003_40BE
    xor a, a
    ld [wSpriteSlotCount], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_003_4073
    ld hl, wBGPaletteBuffer
    ld bc, $0040
    ld a, $FF
    call FillBytes
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $2020

Jump_003_4064::
    xor a, a
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_003_4064
    ld b, $20
    dec c
    jr nz, Jump_003_4064
    xor a, a
    ldh [rVBK], a

Jump_003_4073::
    ld hl, wScreenTileBuffer
    ld bc, $0240
    ld a, $C3
    call FillBytes
    ldh a, [hScrollY]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $98
    ld d, a
    ld a, d
    and a, $9B
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add a, e
    ld e, a
    jr nc, Jump_003_40A6
    inc d

Jump_003_40A6::
    ld l, e
    ld h, d
    ld de, wScreenTileBuffer
    ld bc, $1412
    call CopyRectToBGMap
    xor a, a
    ldh [hScrollX], a
    ldh [hScrollY], a
    call CopyTileBufferToBGMap
    ld hl, wGameMode2State
    inc [hl]
    ret

Jump_003_40BE::
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld hl, vTiles2
    ld de, $1007
    call FillTilesRequest
    ld hl, wTemp0
    ld bc, $0020
    xor a, a
    call FillBytes
    ld hl, wWorkBuf
    ld bc, $0028
    xor a, a
    call FillBytes
    xor a, a
    ld [wMenuSelectedMember], a
    ld [wMenuCursor], a
    ld [wSubMenuCursor], a
    ld [wSubMenuCursor2], a
    ld [wMenuOption], a
    ld [wMenuOption2], a
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    call PauseMenu_State4_Sub01
    xor a, a
    ld [rRAMG], a
    xor a, a
    ld [wLevelUpGains], a
    call CopyTileBufferToBGMap
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_003_414C
    ld hl, wBGPaletteBuffer
    ld a, $39
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld a, $FF
    ld [hl+], a
    ld a, $7F
    ld [hl+], a
    ld a, $3F
    ld [hl+], a
    ld a, $03
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld a, $00
    ld [hl+], a
    ld de, Data_003_7BF5
    ld b, $08

Jump_003_413E::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_003_413E
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes

Jump_003_414C::
    ld a, $80
    ld [wGameMode2State], a
    xor a, a
    ld [wDataBankSave], a
    ld hl, vBGMap0 + $1C0
    ld a, l
    ld [wTextCursorLo], a
    ld a, h
    ld [wTextCursorHi], a
    ld de, $0025
    call TestFlagBit
    ret c
    ld de, $019F
    call TestFlagBit
    ret nc
    ld a, [wScriptTemp4]
    ld [wPartyCount], a
    ld de, $0025
    call SetFlagBit
    ld a, [wStoryFlags + $60]
    set 6, a
    ld [wStoryFlags + $60], a
    ld a, $02
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ld a, $60
    ldh [hPlayerX], a
    ld [wFollowerRecords + $1], a
    ld [wFollowerRecords + $6], a
    ld [wFollowerRecords + $B], a
    ld a, $50
    ldh [hPlayerY], a
    ld [wFollowerRecords + $2], a
    ld [wFollowerRecords + $7], a
    ld [wFollowerRecords + $C], a
    ld a, [wSpriteSlotCount]
    ld [wSpriteSnapshotCount], a
    ld a, $00
    ld [wSpriteSlots], a
    ld a, $01
    ld [wSpriteSlots + $1], a
    ld a, $05
    ld [wSpriteSlots + $2], a
    ld a, $00
    ld [wSpriteSlots + $3], a
    ld a, $40
    ld [wSpriteSlots + $4], a
    ld [wSpriteSlots + $B], a
    ld a, $30
    ld [wSpriteSlots + $5], a
    ld [wSpriteSlots + $C], a
    ld a, $05
    ld [wSpriteSlots + $6], a
    ld a, $00
    ld [wSpriteSlots + $7], a
    ld a, $50
    ld [wSpriteSlots + $8], a
    ld a, $62
    ld [wSpriteSlots + $9], a
    xor a, a
    ld [wSpriteSlots + $A], a
    xor a, a
    ld [wSpriteSlots + $D], a
    ld a, $01
    ld [wSpriteSlots + $E], a
    ld a, $02
    ld [wSpriteSlots + $F], a
    ld a, $E0
    ld [wObject1 + $4], a
    ld [wObject1 + $B], a
    ld [wObject2 + $4], a
    ld [wObject2 + $B], a
    ret

; only called from PauseMenu_State4 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_State4)
; reads: wModeState
PauseMenu_State4_Sub01::
Func_003_4208:: ; address name
    ld a, [wModeState]
    and a, $07
    rst $00
    dw PauseMenu_State4_Sub01_LoadBlankedBlocks00To03WithCursor
    dw PauseMenu_State4_Sub01_ResetInventoryMenuToFirstPage
    dw PauseMenu_State4_Sub01_LoadScreenBlocks1CAnd0C
    dw PauseMenu_State4_Sub01_Case03
    dw PauseMenu_State4_Sub01_ResetInventoryMenuToFirstPage

; entry 0 of the `rst $00` table in Func_003_4208
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount
; writes: wMenuRowCount, wMenuPageCount, wMenuPage
PauseMenu_State4_Sub01_LoadBlankedBlocks00To03WithCursor::
Jump_003_4218:: ; address name
    call LoadBlankedBlocks00To03WithCursor
    call DecompressMenuTilesTo16E0
    farcall LoadTilesForPartyRecords
    ld a, [wPartyCount]
    ld [wMenuRowCount], a
    ld a, $00
    ld [wMenuPageCount], a
    ld a, $00
    ld [wMenuPage], a
    ret

; entry 1 of the `rst $00` table in Func_003_4208
; no direct call (reached through a table, a jump or a vector)
PauseMenu_State4_Sub01_ResetInventoryMenuToFirstPage::
Jump_003_4235:: ; address name
    call ResetInventoryMenuToFirstPage
    call BuildInventoryScreenBase
    call ShowString0Bank09AtTiles16E0ThenItemDescription
    ret

; entry 2 of the `rst $00` table in Func_003_4208
; no direct call (reached through a table, a jump or a vector)
; writes: wMenuPageCount, wMenuPage, wMenuItemCount, wMenuSelectedMember, wMenuCursor, wSubMenuCursor
PauseMenu_State4_Sub01_LoadScreenBlocks1CAnd0C::
Jump_003_423F:: ; address name
    call LoadScreenBlocks1CAnd0C
    call ShowString1Bank09AtTiles16E0ThenDetails
    xor a, a
    ld [wMenuPageCount], a
    ld [wMenuPage], a
    ld [wMenuItemCount], a
    ld [wMenuSelectedMember], a
    ld [wMenuCursor], a
    ld [wSubMenuCursor], a
    ret

; entry 3 of the `rst $00` table in Func_003_4208
; no direct call (reached through a table, a jump or a vector)
; reads: wModeState
; writes: wTemp0
PauseMenu_State4_Sub01_Case03::
Jump_003_4259:: ; address name
    ld a, [wModeState]
    bit 3, a
    jr z, Jump_003_427D
    ld de, $0025
    call TestFlagBit
    jr c, Jump_003_4270
    ld de, $019F
    call TestFlagBit
    jr c, Jump_003_4277

Jump_003_4270::
    ld a, $01
    ld [wTemp0], a
    jr Jump_003_427D

Jump_003_4277::
    ld a, $06
    ld [wTemp0], a
    ret

Jump_003_427D::
    call LoadScreenBlock21
    call ShowString2Bank09InWindowThenDefault
    ret

; fills the $240 bytes at wScreenTileBuffer with $C3 (the same 12 bytes appear in 2 banks)
; 14 call sites from 14 routines (e.g. LoadScreenBlock21, LoadScreenBlocks1CAnd0C, BuildInventoryScreenBase, LoadBlankedBlocks00To03WithCursor, ...)
; points at: wScreenTileBuffer
ClearScreenTileBuffer_Bank03::
Func_003_4284:: ; address name
    ld hl, wScreenTileBuffer
    ld bc, $0240
    ld a, $C3
    call FillBytes
    ret

; HL = header (word offset, width, rows) followed by the tile bytes: copies the rectangle into wScreenTileBuffer + offset with rows 32 bytes apart (the same steps as ReadScreenBufferRectHeader then CopyRectToStride32) (E-0065) (the same 32 bytes appear in 2 banks)
; 3 call sites from 3 routines (e.g. BuildSkillScreenTileBuffer, PauseMenu_Skills_Case02_Case01_Sub01, BuildItemScreenForWItemId)
; points at: wScreenTileBuffer
CopyRecordRectToScreenBuffer_Bank03::
Func_003_4290:: ; address name
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

Jump_003_429E::
    push bc
    push hl

Jump_003_42A0::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_003_42A0
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_003_429E
    ret

; copies a rectangle record (offset, width, height, tiles) to the screen buffer, replacing tiles $15-$A3 with blank $C3 (E-0125)
; no direct call (reached through a table, a jump or a vector)
; points at: wScreenTileBuffer
CopyRectRecordBlankingText_Bank03:: ; heuristic: follows a terminator; C0
Func_003_42B0:: ; address name
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

Jump_003_42BE::
    push bc
    push hl

Jump_003_42C0::
    ld a, [de]
    cp a, $15
    jr c, Jump_003_42CB
    cp a, $A4
    jr nc, Jump_003_42CB
    ld a, $C3

Jump_003_42CB::
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_003_42C0
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_003_42BE
    ret

; copies the 20 x 18 tiles at the start of wScreenTileBuffer to vBGMap0 (CopyRectToBGMap with BC = $1412)
; 36 call sites from 33 routines (e.g. PauseMenu_State4, PauseMenu_Main_Case03_Case01_Sub01_Case02, ExitPauseMenuToField, PauseMenu_State3_Case00_Case00, ...)
; points at: wScreenTileBuffer
CopyTileBufferToBGMap::
Func_003_42DA:: ; address name
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld bc, $1412

; HL = BG map address, DE = source, B = width, C = rows: writes B bytes per row with WriteVRAMByte (HL wraps inside its 32-entry row, then the source and destination each move down 32 and HL is masked with $9B)
; 24 call sites from 21 routines (e.g. PauseMenu_State4, PauseMenu_State3_Case00_Case02, PauseMenu_State3_Case01_Case0E, PauseMenu_State3_Case01_Case0D, ...)
CopyRectToBGMap::
Func_003_42E3:: ; address name
    push bc
    push hl
    push de

Jump_003_42E6::
    ld a, [de]
    inc de
    call WriteVRAMByte
    ld a, l
    and a, $1F
    cp a, $1F
    jr z, Jump_003_42F5
    inc hl
    jr Jump_003_42F9

Jump_003_42F5::
    ld a, l
    and a, $E0
    ld l, a

Jump_003_42F9::
    dec b
    jr nz, Jump_003_42E6
    pop de
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop hl
    ld bc, $0020
    add hl, bc
    ld a, h
    and a, $9B
    ld h, a
    pop bc
    dec c
    jr nz, CopyRectToBGMap
    ret

; B = width, C = rows, DE = source, HL = VRAM with rows 32 bytes apart: copies B bytes per row with WriteVRAMByteInc, then skips 14 source bytes (rows B + 14 bytes apart, 20 for a 6-wide rectangle); B kept, C = 0 (E-0067) (the same 28 bytes appear in 2 banks)
; 4 call sites from 2 routines (e.g. DrawRecordMonsterPictureForMenuSelectedMember, PauseMenu_Main_Case03_Case01_Sub01_Case02)
CopyRectToVRAMSourceStrideBPlus14_Bank03::
Func_003_4313:: ; address name
    push bc
    push hl

Jump_003_4315::
    ld a, [de]
    inc de
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_003_4315
    ld a, e
    add a, $0E
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop hl
    ld bc, $0020
    add hl, bc
    pop bc
    dec c
    jr nz, CopyRectToVRAMSourceStrideBPlus14_Bank03
    ret

; far-calls Func_002_5E82 and reloads the record list name tiles (E-0122)
; 2 call sites from 2 routines (e.g. PauseMenu_Skills_Case00_Case00, PauseMenu_Items_Case00_Case00)
RefreshRecordListAndNameTiles::
Func_003_432F:: ; address name
    farcall RunMoveIncapacitatedPartyMembersBackTwice
    call LoadRecordListNameTiles
    ret

; clears the object flag bits, saves the player position to wC8C8/9, whitens the CGB palettes, blanks the screen and returns to game mode 1 through Func_002_4628 (E-0125)
; 12 call sites from 12 routines (e.g. PauseMenu_Main_ToExitPauseMenuToField, PauseMenu_State3_Case00_Case01, PauseMenu_State3_Case01_Case06, PauseMenu_State3_Case01_Case01, ...)
; reads: hPlayerX, hPlayerY, wIsCGB
; writes: wWarpDestX, wWarpDestY, wWarpDestFacing, rRAMG, wBGPaletteUploadRequest, wFieldInitStage, wGameMode
; points at: wBGPaletteBuffer, wScreenTileBuffer, wFieldInitStage
ExitPauseMenuToField::
Func_003_4339:: ; address name
    call ClearBit1OfPlayerAndObjectFlags_Bank03
    ldh a, [hPlayerX]
    ld [wWarpDestX], a
    ldh a, [hPlayerY]
    ld [wWarpDestY], a
    xor a, a
    ld [wWarpDestFacing], a
    xor a, a
    ld [rRAMG], a
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_003_4367
    ld hl, wBGPaletteBuffer
    ld bc, $0040
    ld a, $FF
    call FillBytes
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes

Jump_003_4367::
    ld hl, wScreenTileBuffer
    ld bc, $0240
    ld a, $C3
    call FillBytes
    call CopyTileBufferToBGMap
    ld hl, wFieldInitStage
    inc [hl]
    farcall InitFieldScreen
    xor a, a
    ld [wFieldInitStage], a
    ld a, $01
    ld [wGameMode], a
    ret

; clears bit 1 of hFF8C and of the flags byte of the five objects at wCB8C, wCB9C ... (stride $10) (E-0121)
; 1 call site from 1 routine (e.g. ExitPauseMenuToField)
; reads: hPlayerStateFlags
; writes: hPlayerStateFlags
ClearBit1OfPlayerAndObjectFlags_Bank03::
Func_003_4389:: ; address name
    ldh a, [hPlayerStateFlags]
    and a, $FD
    ldh [hPlayerStateFlags], a
    ld hl, wSpriteSlots + $D
    ld a, [hl]
    and a, $FD
    ld [hl], a
    ld a, $10
    add_a_to_hl
    ld a, [hl]
    and a, $FD
    ld [hl], a
    ld a, $10
    add_a_to_hl
    ld a, [hl]
    and a, $FD
    ld [hl], a
    ld a, $10
    add_a_to_hl
    ld a, [hl]
    and a, $FD
    ld [hl], a
    ld a, $10
    add_a_to_hl
    ld a, [hl]
    and a, $FD
    ld [hl], a
    ret

; HL = the word at HL + 2 * A; falls through (E-0122)
; 2 call sites from 2 routines (e.g. WithSRAMDrawMemberRecordByte0D_Sub01_Sub03, WithSRAMDrawMemberRecordByte0D_Sub01_CopyTenBytesToTextBuf0)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; writes: wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
DerefWordTableEntryA_Bank03::
Func_003_43C3:: ; address name
    add a, a
    add_a_to_hl
    deref_hl

; wStringCategory = 8, wStringIndex = 5, then falls into the window setup and display (E-0122)
; 3 call sites from 3 routines (e.g. PauseMenu_State3_Case05_Case00, WithSRAMDraw4ACEAnd4BE8_Sub01, WithSRAMDrawMemberRecordByte0D_Sub01)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; writes: wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
SelectString5Category8ThenShow::
Func_003_43CC:: ; address name
    ld a, $08
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a

; only called from WithSRAMDrawMemberRecordByte0D_Sub01 (E-0047)
; 3 call sites from 1 routine (e.g. WithSRAMDrawMemberRecordByte0D_Sub01)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
WithSRAMDrawMemberRecordByte0D_Sub01_Sub01::
Func_003_43D6:: ; address name
    ld de, $0501

; saves the string window wC52D-wC530, sets the tile destination to HL and the size to DE, far-calls ShowString_Bank08, then restores the window (restores in a different register order from the bank-$31 copy, same effect) (E-0067) (the same 59 bytes appear in 2 banks)
; 11 call sites from 8 routines (e.g. ShowSelectedItemDescription, PauseMenu_State3_Shared02, PauseMenu_Skills_Shared02, DrawItemTargetStatPreview, ...)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ShowStringBank08AtTilesHL_Bank03::
Func_003_43D9:: ; address name
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
    pop bc
    ld a, c
    ld [wTextWindowRows], a
    ld a, b
    ld [wTextWindowWidth], a
    pop bc
    ld a, c
    ld [wTextWindowTileLo], a
    ld a, b
    ld [wTextWindowTileHi], a
    ret

; copies 10 bytes from HL to wC130 and writes $F0 after them; HL advances; BC kept (E-0101)
; 4 call sites from 4 routines (e.g. PauseMenu_State3_Case05_Case00, WithSRAMDraw4ACEAnd4BE8_Sub01, WithSRAMDrawMemberRecordByte0D_Sub01_Sub03, WithSRAMDrawMemberRecordByte0D_Sub01_CopyTenBytesToTextBuf0)
; points at: wTextBuf0
CopyTenBytesToTextBuf0::
Func_003_4414:: ; address name
    ld de, wTextBuf0
    push bc
    ld b, $0A

Jump_003_441A::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_003_441A
    ld a, $F0
    ld [de], a
    pop bc
    ret

; HL = cursor byte (low nibble = row, bit 7 = page-changed flag). Up/Down (wJoypadPressedRepeat bits 6/7) move the row with wrap over wMenuRowCount, erase the old cursor (Func_003_44F0), play sound $69, store the row (clearing bit 7) and draw it (Func_003_4506). When wMenuPageCount >= 2, Left/Right (bits 5/4) step wMenuPage with wrap, clamp the row to wMenuLastPageRows - 1 on the last page, set bit 7 and play sound $69. With no input the cursor blinks every 16 frames. wFrameCounterLo is reset on each move (E-0060)
; 19 call sites from 19 routines (e.g. PauseMenu_State3_Case00_Case01, PauseMenu_State3_Case01_Case0E, PauseMenu_State3_Case01_Case03, PauseMenu_State3_Case01_Case01, ...)
; reads: wJoypadPressedRepeat, wMenuRowCount, wMenuPageCount, wMenuPage, wMenuLastPageRows, wFrameCounterLo
; writes: wFrameCounterLo, wMenuPage
UpdateMenuCursor::
Func_003_4425:: ; address name
    ld a, [wJoypadPressedRepeat]
    and a, $40
    jr z, Jump_003_443A
    ld a, [hl]
    and a, $0F
    dec a
    cp a, $FF
    jr nz, Jump_003_447E
    ld a, [wMenuRowCount]
    dec a
    jr Jump_003_447E

Jump_003_443A::
    ld a, [wJoypadPressedRepeat]
    and a, $80
    jr z, Jump_003_444F
    ld a, [wMenuRowCount]
    ld c, a
    ld a, [hl]
    and a, $0F
    inc a
    cp a, c
    jr nz, Jump_003_447E
    xor a, a
    jr Jump_003_447E

Jump_003_444F::
    ld a, [wMenuPageCount]
    or a, a
    jr z, Jump_003_44CB
    cp a, $01
    jr z, Jump_003_44CB
    ld b, a
    ld a, [wJoypadPressedRepeat]
    and a, $20
    jr z, Jump_003_446D
    ld a, [wMenuPage]
    dec a
    cp a, $FF
    jr nz, Jump_003_449C
    ld a, b
    dec a
    jr Jump_003_449C

Jump_003_446D::
    ld a, [wJoypadPressedRepeat]
    and a, $10
    jr z, Jump_003_44CB
    ld a, [wMenuPage]
    inc a
    cp a, b
    jr nz, Jump_003_449C
    xor a, a
    jr Jump_003_449C

Jump_003_447E::
    and a, $0F
    ld b, a
    ld a, [hl]
    and a, $0F
    cp a, b
    jr z, Jump_003_4491
    push de
    call UpdateMenuCursor_Sub01
    pop de
    ld a, $69
    call QueueSoundEffect

Jump_003_4491::
    ld [hl], b
    ld a, b
    call UpdateMenuCursor_Sub02
    xor a, a
    ld [wFrameCounterLo], a
    jr Jump_003_44EF

Jump_003_449C::
    ld [wMenuPage], a
    inc a
    cp a, b
    jr nz, Jump_003_44BE
    ld a, [hl]
    and a, $0F
    ld c, a
    ld a, [wMenuLastPageRows]
    dec a
    cp a, c
    jr nc, Jump_003_44BE
    jr z, Jump_003_44BE
    push af
    push de
    ld a, [hl]
    and a, $0F
    call UpdateMenuCursor_Sub01
    pop de
    pop af
    ld [hl], a
    call UpdateMenuCursor_Sub02

Jump_003_44BE::
    set 7, [hl]
    xor a, a
    ld [wFrameCounterLo], a
    ld a, $69
    call QueueSoundEffect
    jr Jump_003_44EF

Jump_003_44CB::
    ld a, [wFrameCounterLo]
    and a, $0F
    jr nz, Jump_003_44EF
    ld a, [wFrameCounterLo]
    bit 4, a
    jr z, Jump_003_44E1
    ld a, [hl]
    and a, $0F
    call UpdateMenuCursor_Sub02
    jr Jump_003_44EF

Jump_003_44E1::
    ld a, [hl]
    and a, $0F
    call UpdateMenuCursor_Sub01
    ld a, [wFrameCounterLo]
    set 3, a
    ld [wFrameCounterLo], a

Jump_003_44EF::
    ret

; only called from UpdateMenuCursor (E-0047)
; 3 call sites from 1 routine (e.g. UpdateMenuCursor)
UpdateMenuCursor_Sub01::
Func_003_44F0:: ; address name
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_003_44F6
    inc d

Jump_003_44F6::
    ld a, [de]
    push af
    inc de
    ld a, [de]
    ld d, a
    pop af
    ld e, a
    di
    call WaitForVRAMAccess
    ld a, $C3
    ld [de], a
    ei
    ret

; only called from UpdateMenuCursor (E-0047)
; 3 call sites from 1 routine (e.g. UpdateMenuCursor)
UpdateMenuCursor_Sub02::
Func_003_4506:: ; address name
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_003_450C
    inc d

Jump_003_450C::
    ld a, [de]
    push af
    inc de
    ld a, [de]
    ld d, a
    pop af
    ld e, a
    di
    call WaitForVRAMAccess
    ld a, $BB
    ld [de], a
    ei
    ret

; writes the cursor tile $BB into wScreenTileBuffer at the position of MenuCursorPositions_Bank03[wC46D & 3] (BG map address + $2998) (E-0101)
; 4 call sites from 4 routines (e.g. LoadBlankedBlocks00To03WithCursor, LoadBlankedBlocks00And04To06WithCursor, LoadBlankedBlocks00_07_08WithCursor, LoadBlankedBlocks00_09_0AWithCursor)
; reads: wMenuSelectedMember
DrawMenuCursorTileInBuffer::
Func_003_451C:: ; address name
    ld a, [wMenuSelectedMember]
    and a, $03
    ld hl, MenuCursorPositions_Bank03
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $29
    ld h, a
    ld [hl], $BB
    ret

; HL = table of BG map addresses ($98xx), A = index: adds $2998 to entry A, which turns a $9800 BG map address into the same position in wScreenTileBuffer ($C198, 32-wide rows), and writes tile $BC there (E-0072) (the same 20 bytes appear in 2 banks)
; 15 call sites from 14 routines (e.g. LoadScreenBlock21WithCursor, BuildScreenBlocks21To25WithCursor, PauseMenu_State3_Shared04, PauseMenu_State3_Case04_LoadScreenBlock21AndStep, ...)
WriteBCTileToScreenBufferAtTableEntry_Bank03::
Func_003_4538:: ; address name
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    add a, $98
    ld l, a
    ld a, h
    adc a, $29
    ld h, a
    ld [hl], $BC
    ret

; HL = table of VRAM addresses, A = index: writes tile $BC at the address in entry A (WriteVRAMByte) (E-0067) (the same 15 bytes appear in 3 banks)
; 4 call sites from 4 routines (e.g. PauseMenu_State3_Case00_Case01, PauseMenu_State3_Case01_Case0E, PauseMenu_State3_Case01_Case01, PauseMenu_State3_Case06_Case02)
WriteBCTileAtWordTableEntry_Bank03::
Func_003_454C:: ; address name
    add a, a
    add_a_to_hl
    deref_hl
    ld a, $BC
    call WriteVRAMByte
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ShowStringBank08AtTilesHL_03_455B:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 03:43D9; C0
Func_003_455B:: ; address name
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
    pop hl
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ret

; only called from GameMode2_Update (E-0047)
; 1 call site from 1 routine (e.g. GameMode2_Update)
; reads: wGM2TimerFrames, wPlayHoursLo, wPlayHoursHi, wPlayMinutes, wGM2TimerSeconds, wGM2TimerMinutes
; writes: wGM2TimerFrames, wGM2TimerSeconds, wGM2TimerMinutes
; points at: wPlayFrames
GameMode2_Update_Sub01::
Func_003_4596:: ; address name
    ld a, [wGM2TimerFrames]
    inc a
    cp a, $3C
    jr nc, Jump_003_45A3
    ld [wGM2TimerFrames], a
    jr Jump_003_45C9

Jump_003_45A3::
    xor a, a
    ld [wGM2TimerFrames], a
    ld a, [wGM2TimerSeconds]
    inc a
    cp a, $3C
    jr nc, Jump_003_45B4
    ld [wGM2TimerSeconds], a
    jr Jump_003_45C9

Jump_003_45B4::
    xor a, a
    ld [wGM2TimerSeconds], a
    ld a, [wGM2TimerMinutes]
    inc a
    cp a, $3C
    jr nc, Jump_003_45C5
    ld [wGM2TimerMinutes], a
    jr Jump_003_45C9

Jump_003_45C5::
    xor a, a
    ld [wGM2TimerMinutes], a

Jump_003_45C9::
    ld a, [wPlayHoursLo]
    ld l, a
    ld a, [wPlayHoursHi]
    ld h, a
    ld bc, $03E7
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, h
    or a, l
    or a, a
    jr nz, Jump_003_45E5
    ld a, [wPlayMinutes]
    cp a, $3B
    ret z

Jump_003_45E5::
    ld hl, wPlayFrames
    ld a, [hl]
    inc a
    ld [hl], a
    cp a, $3C
    ret c
    ld [hl], $00
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    cp a, $3C
    ret c
    ld [hl], $00
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    cp a, $3C
    ret c
    ld [hl], $00
    inc hl
    ld a, [hl+]
    ld b, [hl]
    ld c, a
    inc bc
    ld a, b
    ld [hl-], a
    ld [hl], c
    ret

; ten BG map addresses: rows 3, 5, 7, 9, 11 and 13 of column 1 ($9861 ... $99A1) and rows 1, 3, 5 and 7 of column 9 ($9829 ... $98E9), indexed by the cursor slot (wC46D & 3 or & 7) by the bank-$03 menu cursor routines (E-0101)
; address loaded by DrawMenuCursorTileInBuffer, PauseMenu_Main_Case00_Case02, PauseMenu_Main_Case01_Case02, PauseMenu_Main_Case02_Case02 and 12 more
MenuCursorPositions_Bank03:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_003_460B:: ; address name
    db $61, $98, $A1, $98, $E1, $98, $21, $99, $61, $99, $A1, $99

; address loaded by PauseMenu_Items_Case00_Case01, BuildScreenBlock0EWithCursor, PauseMenu_Skills_Case01_Case01, PauseMenu_Skills_Case02_Case01_Sub01 and 2 more
Data_003_4617:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $29, $98, $69, $98, $A9, $98, $E9, $98

; address loaded by PauseMenu_Items_Case01_Case01, BuildScreenBlocks0EAnd0FWithCursor, BuildScreenBlock0EWithSubMenuCursor
Data_003_461F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A1, $98, $E1, $98

; address loaded by PauseMenu_Items_Case03_Case03
Data_003_4623:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $99, $61, $99

; address loaded by PauseMenu_State3_Case01_Case0E
Data_003_4627:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $99, $41, $99

; address loaded by PauseMenu_State3_Case01_Case01
Data_003_462B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $47, $99, $87, $99, $C7, $99, $07, $9A

; address loaded by PauseMenu_State3_Case01_Case03, PauseMenu_State3_Shared04, BuildScreenBlocks21To25WithCursor
Data_003_4633:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $61, $98, $A1, $98

; address loaded by PauseMenu_State3_Case02_Case02
Data_003_4637:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $4A, $99, $8A, $99, $CA, $99, $0A, $9A

; address loaded by PauseMenu_State3_Case04_Case02
Data_003_463F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $64, $98, $A4, $98, $E4, $98

; address loaded by PauseMenu_Items_Case02_Case1D, PauseMenu_State3_Case06_Case02
Data_003_4645:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2F, $99, $6F, $99

; address loaded by MenuCursorAddressMenuCursor
Data_003_4649:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $82, $99, $84, $99, $86, $99, $88, $99, $8A, $99, $8C, $99, $8E, $99, $90, $99

; runs the routine for wC0A4 (jump table of four screens) (E-0122)
; 2 call sites from 2 routines (e.g. PauseMenu_State3_Case06_Case03, PauseMenu_Items_Case02_Case1E)
; reads: wPauseMenuScreen
RunPauseMenuScreen::
Func_003_4659:: ; address name
    ld a, [wPauseMenuScreen]
    rst $00
    dw RunPauseMenuScreen_Case00
    dw RunPauseMenuScreen_AdvancePauseMenuScreen
    dw RunPauseMenuScreen_Case02
    dw RunPauseMenuScreen_AdvancePauseMenuScreen_Case03

; entry 0 of the `rst $00` table in RunPauseMenuScreen
; no direct call (reached through a table, a jump or a vector)
; reads: wCurrentMusic
; writes: wMenuLastPageRows, wSaveStep, wSaveRecordIndex
; points at: wPauseMenuScreen
RunPauseMenuScreen_Case00::
Jump_003_4665:: ; address name
    ld a, [wCurrentMusic]
    ld [wMenuLastPageRows], a
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld hl, wPauseMenuScreen
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunPauseMenuScreen
; no direct call (reached through a table, a jump or a vector)
; points at: wPauseMenuScreen
RunPauseMenuScreen_AdvancePauseMenuScreen::
Jump_003_4677:: ; address name
    ld hl, wPauseMenuScreen
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunPauseMenuScreen
; no direct call (reached through a table, a jump or a vector)
; reads: wSaveStep
; points at: wPauseMenuScreen
RunPauseMenuScreen_Case02::
Jump_003_467C:: ; address name
    farcall RunSaveGameSteps_7347
    ld a, [wSaveStep]
    bit 7, a
    ret z
    ld hl, wPauseMenuScreen
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunPauseMenuScreen
; no direct call (reached through a table, a jump or a vector)
; points at: wPauseMenuScreen
RunPauseMenuScreen_AdvancePauseMenuScreen_Case03::
Jump_003_468D:: ; address name
    ld hl, wPauseMenuScreen
    inc [hl]
    ret

; GameMode2_Update, wModeState 0: the main pause menu: PLAN (Keys, Plan, Text Speed, Re-Order, Info, Journal) and, for the first monster, INFO with its level, ATK, DEF, AGL, INT, WLD, HP and MP (E-0046)
; no direct call (reached through a table, a jump or a vector)
; reads: wDataBankSave, wTemp0, wTemp1
PauseMenu_Main::
Jump_003_4692:: ; address name
    ld a, [wDataBankSave]
    or a, a
    jp nz, Jump_003_4FED
    ld a, [wTemp0]
    rst $00
    dw PauseMenu_Main_Case00
    dw PauseMenu_Main_Case01
    dw PauseMenu_Main_Case02
    dw PauseMenu_Main_Case03
    dw PauseMenu_Main_ToExitPauseMenuToField

; entry 0 of the `rst $00` table in PauseMenu_Main
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp1
PauseMenu_Main_Case00::
Jump_003_46A7:: ; address name
    ld a, [wTemp1]
    rst $00
    dw PauseMenu_Main_Case00_Case00
    dw PauseMenu_Main_Case00_Case01
    dw PauseMenu_Main_Case00_Case02
    dw PauseMenu_Main_Case00_Return

; entry 0 of the `rst $00` table in PauseMenu_Main_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wPauseMenuScreen
; points at: wTemp1
PauseMenu_Main_Case00_Case00::
Jump_003_46B3:: ; address name
    ld a, [wPauseMenuScreen]
    or a, a
    jr nz, Jump_003_46BF
    call LoadBlankedBlocks00To03WithCursor
    call CopyTileBufferToBGMap

Jump_003_46BF::
    ld hl, wTemp1
    inc [hl]

; entry 3 of the `rst $00` table in PauseMenu_Main_Case00
; no direct call (reached through a table, a jump or a vector)
PauseMenu_Main_Case00_Return::
Jump_003_46C3:: ; address name
    ret

; entry 1 of the `rst $00` table in PauseMenu_Main_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wPauseMenuScreen
; writes: rRAMG, rRAMB
; points at: wScreenTileBuffer, wTemp1
PauseMenu_Main_Case00_Case01::
Jump_003_46C4:: ; address name
    ld a, [wPauseMenuScreen]
    or a, a
    jr nz, Jump_003_46CD
    call LoadScreenBlocks00To03

Jump_003_46CD::
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    call DrawRecordMonsterPictureForMenuSelectedMember
    xor a, a
    ld [rRAMG], a
    call WithSRAMDraw4ACEAnd4B52
    ld hl, vBGMap0
    ld bc, $1412
    ld de, wScreenTileBuffer
    call CopyRectToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

; entry 2 of the `rst $00` table in PauseMenu_Main_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed
; writes: wTemp1, wPauseMenuScreen, wDataBankSave
; points at: wMenuSelectedMember, wTemp0
PauseMenu_Main_Case00_Case02::
Jump_003_46F1:: ; address name
    ld de, MenuCursorPositions_Bank03
    ld hl, wMenuSelectedMember
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, Jump_003_4706
    xor a, a
    ld [wTemp1], a
    ret

Jump_003_4706::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_471E
    ld a, $69
    call QueueSoundEffect
    ld hl, wTemp0
    inc [hl]
    xor a, a
    ld [wTemp1], a
    ld [wPauseMenuScreen], a
    ret

Jump_003_471E::
    bit 1, a
    jr z, Jump_003_4726
    call ExitPauseMenuToField
    ret

Jump_003_4726::
    bit 2, a
    jr z, Jump_003_4734
    ld a, $01
    ld [wDataBankSave], a
    xor a, a
    ld [wTemp1], a
    ret

Jump_003_4734::
    ret

; entry 1 of the `rst $00` table in PauseMenu_Main
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp1
PauseMenu_Main_Case01::
Jump_003_4735:: ; address name
    ld a, [wTemp1]
    rst $00
    dw PauseMenu_Main_Case01_Case00
    dw PauseMenu_Main_Case01_Case01
    dw PauseMenu_Main_Case01_Case02

; entry 0 of the `rst $00` table in PauseMenu_Main_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wPauseMenuScreen
; points at: wTemp1
PauseMenu_Main_Case01_Case00::
Jump_003_473F:: ; address name
    ld a, [wPauseMenuScreen]
    or a, a
    jr nz, Jump_003_474B
    call LoadBlankedBlocks00And04To06WithCursor
    call CopyTileBufferToBGMap

Jump_003_474B::
    ld hl, wTemp1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_Main_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wPauseMenuScreen
; points at: wTemp1
PauseMenu_Main_Case01_Case01::
Jump_003_4750:: ; address name
    ld a, [wPauseMenuScreen]
    or a, a
    jr nz, Jump_003_4759
    call LoadScreenBlocks00And04To06

Jump_003_4759::
    call WithSRAMDraw4ACEAnd4BE8
    ld hl, vBGMap0 + $21
    ld bc, $1311
    ld de, wScreenTileBuffer + $21
    call CopyRectToBGMap
    call DecompressRecordSpeciesGraphicsToTiles0
    ld hl, wTemp1
    inc [hl]
    ret

; entry 2 of the `rst $00` table in PauseMenu_Main_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed
; writes: wTemp1, wPauseMenuScreen, wDataBankSave
; points at: wMenuSelectedMember, wTemp0
PauseMenu_Main_Case01_Case02::
Jump_003_4770:: ; address name
    farcall DrawMetaSpritePartC0
    ld de, MenuCursorPositions_Bank03
    ld hl, wMenuSelectedMember
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, Jump_003_478B
    xor a, a
    ld [wTemp1], a
    ret

Jump_003_478B::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_47A3
    ld a, $69
    call QueueSoundEffect
    ld hl, wTemp0
    inc [hl]
    xor a, a
    ld [wTemp1], a
    ld [wPauseMenuScreen], a
    ret

Jump_003_47A3::
    bit 1, a
    jr z, Jump_003_47B3
    ld hl, wTemp0
    dec [hl]
    xor a, a
    ld [wTemp1], a
    ld [wPauseMenuScreen], a
    ret

Jump_003_47B3::
    bit 2, a
    jr z, Jump_003_47C1
    ld a, $01
    ld [wDataBankSave], a
    xor a, a
    ld [wTemp1], a
    ret

Jump_003_47C1::
    ret

; entry 2 of the `rst $00` table in PauseMenu_Main
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp1
PauseMenu_Main_Case02::
Jump_003_47C2:: ; address name
    ld a, [wTemp1]
    rst $00
    dw PauseMenu_Main_Case02_Case00
    dw PauseMenu_Main_Case02_Case01
    dw PauseMenu_Main_Case02_Case02

; entry 0 of the `rst $00` table in PauseMenu_Main_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wPauseMenuScreen
; points at: wTemp1
PauseMenu_Main_Case02_Case00::
Jump_003_47CC:: ; address name
    ld a, [wPauseMenuScreen]
    or a, a
    jr nz, Jump_003_47D8
    call LoadBlankedBlocks00_07_08WithCursor
    call CopyTileBufferToBGMap

Jump_003_47D8::
    ld hl, wTemp1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_Main_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wPauseMenuScreen
; points at: wTemp1
PauseMenu_Main_Case02_Case01::
Jump_003_47DD:: ; address name
    ld a, [wPauseMenuScreen]
    or a, a
    jr nz, Jump_003_47E6
    call LoadScreenBlocks00_07_08

Jump_003_47E6::
    call WithSRAMShowRecordSpeciesAndSkillNames
    ld hl, vBGMap0 + $21
    ld bc, $1311
    ld de, wScreenTileBuffer + $21
    call CopyRectToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

; entry 2 of the `rst $00` table in PauseMenu_Main_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed
; writes: wTemp1, wPauseMenuScreen, wDataBankSave
; points at: wMenuSelectedMember, wTemp0
PauseMenu_Main_Case02_Case02::
Jump_003_47FA:: ; address name
    ld de, MenuCursorPositions_Bank03
    ld hl, wMenuSelectedMember
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, Jump_003_480F
    xor a, a
    ld [wTemp1], a
    ret

Jump_003_480F::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_4827
    ld a, $69
    call QueueSoundEffect
    ld hl, wTemp0
    inc [hl]
    xor a, a
    ld [wTemp1], a
    ld [wPauseMenuScreen], a
    ret

Jump_003_4827::
    bit 1, a
    jr z, Jump_003_4837
    ld hl, wTemp0
    dec [hl]
    xor a, a
    ld [wTemp1], a
    ld [wPauseMenuScreen], a
    ret

Jump_003_4837::
    bit 2, a
    jr z, Jump_003_4845
    ld a, $01
    ld [wDataBankSave], a
    xor a, a
    ld [wTemp1], a
    ret

Jump_003_4845::
    ret

; entry 3 of the `rst $00` table in PauseMenu_Main
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp1
PauseMenu_Main_Case03::
Jump_003_4846:: ; address name
    ld a, [wTemp1]
    rst $00
    dw PauseMenu_Main_Case03_Case00
    dw PauseMenu_Main_Case03_Case01
    dw PauseMenu_Main_Case03_Case02

; entry 0 of the `rst $00` table in PauseMenu_Main_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wPauseMenuScreen
; points at: wTemp1
PauseMenu_Main_Case03_Case00::
Jump_003_4850:: ; address name
    ld a, [wPauseMenuScreen]
    or a, a
    jr nz, Jump_003_485C
    call LoadBlankedBlocks00_09_0AWithCursor
    call CopyTileBufferToBGMap

Jump_003_485C::
    ld hl, wTemp1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_Main_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wPauseMenuScreen
; points at: wTemp1
PauseMenu_Main_Case03_Case01::
Jump_003_4861:: ; address name
    ld a, [wPauseMenuScreen]
    or a, a
    jr nz, Jump_003_486A
    call LoadScreenBlocks00_09_0A

Jump_003_486A::
    call WithSRAMDrawMemberRecordByte0D
    ld hl, vBGMap0 + $21
    ld bc, $1311
    ld de, wScreenTileBuffer + $21
    call CopyRectToBGMap
    call PauseMenu_Main_Case03_Case01_Sub01
    ld hl, wTemp1
    inc [hl]
    ret

; entry 2 of the `rst $00` table in PauseMenu_Main_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wWorkBuf
; writes: wTemp1, hOamNextEntry, wArg1, wArg2, wPauseMenuScreen, wDataBankSave
; points at: wMenuSelectedMember, wShadowOAM, wTemp0
PauseMenu_Main_Case03_Case02::
Jump_003_4881:: ; address name
    ld de, MenuCursorPositions_Bank03
    ld hl, wMenuSelectedMember
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, Jump_003_4896
    xor a, a
    ld [wTemp1], a
    ret

Jump_003_4896::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_48B3
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ldh [hOamNextEntry], a
    ld hl, wShadowOAM
    ld bc, $00A0
    call FillBytes
    ld hl, wTemp0
    inc [hl]
    ret

Jump_003_48B3::
    ld a, [wWorkBuf]
    ld l, a
    ld a, [wWorkBuf + $1]
    ld h, a
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    farcall DrawPartySpeciesSprites
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, Jump_003_48DC
    ld hl, wTemp0
    dec [hl]
    xor a, a
    ld [wTemp1], a
    ld [wPauseMenuScreen], a
    ret

Jump_003_48DC::
    bit 2, a
    jr z, Jump_003_48EA
    ld a, $01
    ld [wDataBankSave], a
    xor a, a
    ld [wTemp1], a
    ret

Jump_003_48EA::
    ret

; entry 4 of the `rst $00` table in PauseMenu_Main
; no direct call (reached through a table, a jump or a vector)
PauseMenu_Main_ToExitPauseMenuToField::
Jump_003_48EB:: ; address name
    call ExitPauseMenuToField
    ret

; clears the screen tile buffer, copies blocks $00-$03 into it, then wC0A4 += 1 (E-0117)
; 1 call site from 1 routine (e.g. PauseMenu_Main_Case00_Case01)
; points at: wPauseMenuScreen
LoadScreenBlocks00To03::
Func_003_48EF:: ; address name
    call ClearScreenTileBuffer_Bank03
    ld e, $00
    farcall CopyBlockToTileBuffer
    ld e, $01
    farcall CopyBlockToTileBuffer
    ld e, $02
    farcall CopyBlockToTileBuffer
    ld e, $03
    farcall CopyBlockToTileBuffer
    ld hl, wPauseMenuScreen
    inc [hl]
    ret

; clears the screen tile buffer, copies blocks $00, $04, $05, $06, then wC0A4 += 1 (E-0117)
; 1 call site from 1 routine (e.g. PauseMenu_Main_Case01_Case01)
; points at: wPauseMenuScreen
LoadScreenBlocks00And04To06::
Func_003_4917:: ; address name
    call ClearScreenTileBuffer_Bank03
    ld e, $00
    farcall CopyBlockToTileBuffer
    ld e, $04
    farcall CopyBlockToTileBuffer
    ld e, $05
    farcall CopyBlockToTileBuffer
    ld e, $06
    farcall CopyBlockToTileBuffer
    ld hl, wPauseMenuScreen
    inc [hl]
    ret

; clears the screen tile buffer, copies blocks $00, $07, $08, then wC0A4 += 1 (E-0117)
; 1 call site from 1 routine (e.g. PauseMenu_Main_Case02_Case01)
; points at: wPauseMenuScreen
LoadScreenBlocks00_07_08::
Func_003_493F:: ; address name
    call ClearScreenTileBuffer_Bank03
    ld e, $00
    farcall CopyBlockToTileBuffer
    ld e, $07
    farcall CopyBlockToTileBuffer
    ld e, $08
    farcall CopyBlockToTileBuffer
    ld hl, wPauseMenuScreen
    inc [hl]
    ret

; clears the screen tile buffer, copies blocks $00, $09, $0A, then wC0A4 += 1 (E-0117)
; 1 call site from 1 routine (e.g. PauseMenu_Main_Case03_Case01)
; points at: wPauseMenuScreen
LoadScreenBlocks00_09_0A::
Func_003_495F:: ; address name
    call ClearScreenTileBuffer_Bank03
    ld e, $00
    farcall CopyBlockToTileBuffer
    ld e, $09
    farcall CopyBlockToTileBuffer
    ld e, $0A
    farcall CopyBlockToTileBuffer
    ld hl, wPauseMenuScreen
    inc [hl]
    ret

; clears the screen tile buffer, copies block $2D + wC6FD and block $31, then wC0A4 += 1 (E-0117)
; 1 call site from 1 routine (e.g. PauseMenu_Main_Case03_Case01_Sub01_Case01)
; reads: wPartyCount
; points at: wPauseMenuScreen
LoadScreenBlockForPartySize::
Func_003_497F:: ; address name
    call ClearScreenTileBuffer_Bank03
    ld a, [wPartyCount]
    add a, $2D
    ld e, a
    farcall CopyBlockToTileBuffer
    ld e, $31
    farcall CopyBlockToTileBuffer
    ld hl, wPauseMenuScreen
    inc [hl]
    ret

; clears the screen tile buffer, copies blocks $00-$03 with CopyBlockToTileBufferBlankingText, then DrawMenuCursorTileInBuffer (E-0117)
; 2 call sites from 2 routines (e.g. PauseMenu_State4_Sub01_LoadBlankedBlocks00To03WithCursor, PauseMenu_Main_Case00_Case00)
LoadBlankedBlocks00To03WithCursor::
Func_003_499B:: ; address name
    call ClearScreenTileBuffer_Bank03
    ld e, $00
    farcall CopyBlockToTileBufferBlankingText
    ld e, $01
    farcall CopyBlockToTileBufferBlankingText
    ld e, $02
    farcall CopyBlockToTileBufferBlankingText
    ld e, $03
    farcall CopyBlockToTileBufferBlankingText
    call DrawMenuCursorTileInBuffer
    ret

; as LoadBlankedBlocks00To03WithCursor with blocks $00, $04, $05, $06 (E-0117)
; 1 call site from 1 routine (e.g. PauseMenu_Main_Case01_Case00)
LoadBlankedBlocks00And04To06WithCursor::
Func_003_49C2:: ; address name
    call ClearScreenTileBuffer_Bank03
    ld e, $00
    farcall CopyBlockToTileBufferBlankingText
    ld e, $04
    farcall CopyBlockToTileBufferBlankingText
    ld e, $05
    farcall CopyBlockToTileBufferBlankingText
    ld e, $06
    farcall CopyBlockToTileBufferBlankingText
    call DrawMenuCursorTileInBuffer
    ret

; as LoadBlankedBlocks00To03WithCursor with blocks $00, $07, $08 (E-0117)
; 1 call site from 1 routine (e.g. PauseMenu_Main_Case02_Case00)
LoadBlankedBlocks00_07_08WithCursor::
Func_003_49E9:: ; address name
    call ClearScreenTileBuffer_Bank03
    ld e, $00
    farcall CopyBlockToTileBufferBlankingText
    ld e, $07
    farcall CopyBlockToTileBufferBlankingText
    ld e, $08
    farcall CopyBlockToTileBufferBlankingText
    call DrawMenuCursorTileInBuffer
    ret

; as LoadBlankedBlocks00To03WithCursor with blocks $00, $09, $0A (E-0117)
; 1 call site from 1 routine (e.g. PauseMenu_Main_Case03_Case00)
LoadBlankedBlocks00_09_0AWithCursor::
Func_003_4A08:: ; address name
    call ClearScreenTileBuffer_Bank03
    ld e, $00
    farcall CopyBlockToTileBufferBlankingText
    ld e, $09
    farcall CopyBlockToTileBufferBlankingText
    ld e, $0A
    farcall CopyBlockToTileBufferBlankingText
    call DrawMenuCursorTileInBuffer
    ret

; decompresses Data_016_7B7D (bank $16) to vTiles1 + $6E0, then runs Func_003_4A36 (E-0122)
; 1 call site from 1 routine (e.g. PauseMenu_State4_Sub01_LoadBlankedBlocks00To03WithCursor)
DecompressMenuTilesTo16E0::
Func_003_4A27:: ; address name
    ld b, $16
    ld de, Tiles1Plus6E0Gfx_16_7B7D
    ld hl, vTiles1 + $6E0
    call DecompressToVRAM
    call DrawRecordMonsterPictureForMenuSelectedMember
    ret

; loads the picture of the species of record wC46D & $0F at vTiles2 + $5C0; on CGB also uploads palettes and copies its 6 x 6 attribute block to vBGMap0 + $161 (E-0125)
; 2 call sites from 2 routines (e.g. DecompressMenuTilesTo16E0, PauseMenu_Main_Case00_Case01)
; reads: wMenuSelectedMember, wIsCGB
; writes: wBGPaletteUploadRequest, hTemp0, rVBK, rSVBK
; points at: wScreenAttrBuffer
DrawRecordMonsterPictureForMenuSelectedMember::
Func_003_4A36:: ; address name
    ld c, $0B
    ld a, [wMenuSelectedMember]
    and a, $0F
    call SRAMRecordAddressMapped
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    ld hl, vTiles2 + $5C0
    ld c, $01
    call LoadMonsterPicture
    pop de
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_003_4A83
    push de
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    call UploadBGPalettes
    pop de
    ld a, $01
    ldh [hTemp0], a
    ld hl, wScreenAttrBuffer
    call LoadMonsterPictureAttributeBlock
    ld a, $01
    ldh [rVBK], a
    ld a, $02
    ldh [rSVBK], a
    ld hl, vBGMap0 + $161
    ld de, wScreenAttrBuffer
    ld bc, $0606
    call CopyRectToVRAMSourceStrideBPlus14_Bank03
    ld a, $00
    ldh [rSVBK], a
    ld a, $00
    ldh [rVBK], a

Jump_003_4A83::
    ret

; with SRAM bank 0 enabled runs Func_003_4ACE and Func_003_4B52 (E-0122)
; 1 call site from 1 routine (e.g. PauseMenu_Main_Case00_Case01)
; writes: rRAMG, rRAMB
WithSRAMDraw4ACEAnd4B52::
Func_003_4A84:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    call BuildRecordLevelAndStatusRow
    call WithSRAMDraw4ACEAnd4B52_Sub01
    xor a, a
    ld [rRAMG], a
    ret

; with SRAM bank 0 enabled runs Func_003_4ACE and Func_003_4BE8 (E-0122)
; 1 call site from 1 routine (e.g. PauseMenu_Main_Case01_Case01)
; writes: rRAMG, rRAMB
WithSRAMDraw4ACEAnd4BE8::
Func_003_4A98:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    call BuildRecordLevelAndStatusRow
    call WithSRAMDraw4ACEAnd4BE8_Sub01
    xor a, a
    ld [rRAMG], a
    ret

; with SRAM bank 0 enabled runs ShowRecordSpeciesAndSkillNames (E-0122)
; 1 call site from 1 routine (e.g. PauseMenu_Main_Case02_Case01)
; writes: rRAMG, rRAMB
WithSRAMShowRecordSpeciesAndSkillNames::
Func_003_4AAC:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    call ShowRecordSpeciesAndSkillNames
    xor a, a
    ld [rRAMG], a
    ret

; with SRAM bank 0 enabled, reads byte $0D of the selected member's record (wMenuSelectedMember) and draws species name and icon (ShowSpeciesNameAndIconForSlotB) from it and the following word unless it is $FFFF (E-0122, E-0259)
; 1 call site from 1 routine (e.g. PauseMenu_Main_Case03_Case01)
; writes: rRAMG, rRAMB
WithSRAMDrawMemberRecordByte0D::
Func_003_4ABD:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    call WithSRAMDrawMemberRecordByte0D_Sub01
    xor a, a
    ld [rRAMG], a
    ret

; writes record wC46D's level (field $56, marked with tile $14 at the cap in field $57), status marks from field $55 and the field $0E mark into the row at wC1C1 (E-0127)
; 2 call sites from 2 routines (e.g. WithSRAMDraw4ACEAnd4B52, WithSRAMDraw4ACEAnd4BE8)
; reads: wMenuSelectedMember
; writes: wScreenTileBuffer
BuildRecordLevelAndStatusRow::
Func_003_4ACE:: ; address name
    ld hl, wScreenTileBuffer + $29
    ld a, $C3
    ld [hl+], a
    ld a, $EA
    ld [hl+], a
    ld a, $ED
    ld [hl+], a
    ld a, $C3
    ld [hl+], a
    ld a, $C3
    ld [hl+], a
    ld a, $C3
    ld [hl+], a
    ld a, $C3
    ld [hl+], a
    ld [hl], $C3
    ld c, $56
    ld a, [wMenuSelectedMember]
    and a, $0F
    call SRAMRecordAddressMapped
    push hl
    ld a, [hl]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld de, wScreenTileBuffer + $2C
    call WriteTwoDigitTilesFromWC8C1
    pop hl
    ld a, [hl+]
    cp a, [hl]
    jr c, Jump_003_4B0A
    ld a, $14
    ld [wScreenTileBuffer + $29], a

Jump_003_4B0A::
    ld c, $55
    ld a, [wMenuSelectedMember]
    and a, $0F
    call SRAMRecordAddressMapped
    ld a, [hl]
    or a, a
    jr z, Jump_003_4B27
    bit 7, a
    call nz, SetWC1C8TileC2
    bit 0, a
    call nz, SetWC1C6TileC0
    bit 2, a
    call nz, SetWC1C7TileC1

Jump_003_4B27::
    ld c, $0E
    ld a, [wMenuSelectedMember]
    and a, $0F
    call SRAMRecordAddressMapped
    ld a, [hl]
    and a, $01
    add a, $CC
    ld [wScreenTileBuffer + $32], a
    ret

; wC1C8 = $C2; AF kept (E-0119)
; 1 call site from 1 routine (e.g. BuildRecordLevelAndStatusRow)
; writes: wScreenTileBuffer
SetWC1C8TileC2::
Func_003_4B3A:: ; address name
    push af
    ld a, $C2
    ld [wScreenTileBuffer + $30], a
    pop af
    ret

; wC1C6 = $C0; AF kept (E-0119)
; 1 call site from 1 routine (e.g. BuildRecordLevelAndStatusRow)
; writes: wScreenTileBuffer
SetWC1C6TileC0::
Func_003_4B42:: ; address name
    push af
    ld a, $C0
    ld [wScreenTileBuffer + $2E], a
    pop af
    ret

; wC1C7 = $C1; AF kept (E-0119)
; 1 call site from 1 routine (e.g. BuildRecordLevelAndStatusRow)
; writes: wScreenTileBuffer
SetWC1C7TileC1::
Func_003_4B4A:: ; address name
    push af
    ld a, $C1
    ld [wScreenTileBuffer + $2F], a
    pop af
    ret

; only called from WithSRAMDraw4ACEAnd4B52 (E-0047)
; 1 call site from 1 routine (e.g. WithSRAMDraw4ACEAnd4B52)
; reads: wMenuSelectedMember
WithSRAMDraw4ACEAnd4B52_Sub01::
Func_003_4B52:: ; address name
    ld c, $63
    ld a, [wMenuSelectedMember]
    and a, $0F
    call SRAMRecordAddressMapped
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wScreenTileBuffer + $70
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wScreenTileBuffer + $B0
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wScreenTileBuffer + $F0
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wScreenTileBuffer + $130
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    push hl
    deref_hl
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $8
    call WriteDecimalDigitTiles
    pop hl
    ld a, l
    add a, $F0
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $64
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $68
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $A4
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    deref_hl
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $A8
    call WriteDecimalDigitTiles
    ret

; only called from WithSRAMDraw4ACEAnd4BE8 (E-0047)
; 1 call site from 1 routine (e.g. WithSRAMDraw4ACEAnd4BE8)
; reads: wMenuSelectedMember, wDigits, wSpeciesExpCurve, hTemp2, hTemp3, hTemp4
; writes: wStringIndex, wStringCategory, wScreenTileBuffer, wDigits, wSpeciesIdLo, wSpeciesIdHi, hTemp0, hTemp1
WithSRAMDraw4ACEAnd4BE8_Sub01::
Func_003_4BE8:: ; address name
    ld c, $A4
    ld a, [wMenuSelectedMember]
    and a, $0F
    call SRAMRecordAddressMapped
    ld a, [hl]
    ld [wStringIndex], a
    ld a, $0B
    ld [wStringCategory], a
    ld hl, vTiles2 + $350
    ld de, $0603
    call ShowStringBank08AtTilesHL_Bank03
    ld c, $6F
    ld a, [wMenuSelectedMember]
    and a, $0F
    call SRAMRecordAddressMapped
    ld a, [hl+]
    cp a, $40
    jr c, Jump_003_4C1B
    cp a, $C0
    jr c, Jump_003_4C1F
    ld c, $00
    jr Jump_003_4C21

Jump_003_4C1B::
    ld c, $12
    jr Jump_003_4C21

Jump_003_4C1F::
    ld c, $09

Jump_003_4C21::
    ld a, [hl+]
    inc hl
    cp a, $40
    jr c, Jump_003_4C2F
    cp a, $C0
    jr c, Jump_003_4C33
    ld b, $00
    jr Jump_003_4C35

Jump_003_4C2F::
    ld b, $02
    jr Jump_003_4C35

Jump_003_4C33::
    ld b, $01

Jump_003_4C35::
    ld a, [hl]
    cp a, $40
    jr c, Jump_003_4C41
    cp a, $C0
    jr c, Jump_003_4C45
    xor a, a
    jr Jump_003_4C47

Jump_003_4C41::
    ld a, $06
    jr Jump_003_4C47

Jump_003_4C45::
    ld a, $03

Jump_003_4C47::
    add a, b
    add a, c
    ld [wStringIndex], a
    ld a, $07
    ld [wStringCategory], a
    ld hl, vTiles2 + $4C0
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank03
    ld c, $0B
    ld a, [wMenuSelectedMember]
    and a, $0F
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld h, [hl]
    ld [wStringIndex], a
    ld a, h
    add a, $02
    ld [wStringCategory], a
    ld hl, vTiles2 + $550
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank03
    ld a, [wMenuSelectedMember]
    and a, $0F
    add a, $C7
    ld [wScreenTileBuffer + $E9], a
    ld a, $C3
    ld [wScreenTileBuffer + $EA], a
    ld [wScreenTileBuffer + $EB], a
    ld [wScreenTileBuffer + $EC], a
    ld c, $6D
    ld a, [wMenuSelectedMember]
    and a, $0F
    call SRAMRecordAddressMapped
    ld a, [hl]
    or a, a
    jr z, Jump_003_4CB8
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld hl, wScreenTileBuffer + $EB
    ld a, [wDigits + $1]
    or a, a
    jr z, Jump_003_4CAD
    add a, $E0
    ld [hl+], a

Jump_003_4CAD::
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    ld a, $FC
    ld [wScreenTileBuffer + $EA], a

Jump_003_4CB8::
    ld c, $0F
    ld a, [wMenuSelectedMember]
    and a, $0F
    call SRAMRecordAddressMapped
    call CopyTenBytesToTextBuf0
    ld hl, vTiles2 + $470
    call SelectString5Category8ThenShow
    ld c, $58
    ld a, [wMenuSelectedMember]
    and a, $0F
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld [wDigits], a
    ld e, a
    ld a, [hl+]
    ld [wDigits + $1], a
    ld d, a
    ld a, [hl]
    ld [wDigits + $2], a
    ld c, a
    push bc
    push de
    call Number24ToPackedBCD
    ld de, wWindowTileBuffer + $24
    call WithSRAMDraw4ACEAnd4BE8_Sub01_Sub01
    ld c, $0B
    ld a, [wMenuSelectedMember]
    and a, $0F
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesExpCurve]
    ldh [hTemp0], a
    ld c, $56
    ld a, [wMenuSelectedMember]
    and a, $0F
    call SRAMRecordAddressMapped
    ld a, [hl]
    ldh [hTemp1], a
    farcall LoadExpTableEntryToTemp2
    ld c, $56
    ld a, [wMenuSelectedMember]
    and a, $0F
    call SRAMRecordAddressMapped
    pop de
    pop bc
    ld a, [hl+]
    cp a, [hl]
    jr nc, Jump_003_4D43
    ldh a, [hTemp2]
    sub a, e
    ld [wDigits], a
    ldh a, [hTemp3]
    sbc a, d
    ld [wDigits + $1], a
    ldh a, [hTemp4]
    sbc a, c
    ld [wDigits + $2], a
    jr Jump_003_4D4D

Jump_003_4D43::
    xor a, a
    ld [wDigits], a
    ld [wDigits + $1], a
    ld [wDigits + $2], a

Jump_003_4D4D::
    call Number24ToPackedBCD
    ld de, wWindowTileBuffer + $A4
    call WithSRAMDraw4ACEAnd4BE8_Sub01_Sub01
    ret

; for SRAM record wC46D & $0F: shows the species category $0D string at vTiles2 + $2C0 and the eight skills of field $34 in slots 0-7 (E-0121)
; 1 call site from 1 routine (e.g. WithSRAMShowRecordSpeciesAndSkillNames)
; reads: wMenuSelectedMember, wSpeciesRecord
; writes: wSpeciesIdLo, wSpeciesIdHi, wStringIndex, wStringCategory
ShowRecordSpeciesAndSkillNames::
Func_003_4D57:: ; address name
    ld c, $0B
    ld a, [wMenuSelectedMember]
    and a, $0F
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord + $B]
    ld [wStringIndex], a
    ld a, $0D
    ld [wStringCategory], a
    ld hl, vTiles2 + $2C0
    ld de, $0602
    call ShowStringBank08AtTilesHL_Bank03
    ld c, $34
    ld a, [wMenuSelectedMember]
    and a, $0F
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld b, $00
    call ShowRecordSpeciesAndSkillNames_Sub01
    ld a, [hl+]
    ld b, $01
    call ShowSkillNameAtSlotB
    ld a, [hl+]
    ld b, $02
    call ShowSkillNameAtSlotB
    ld a, [hl+]
    ld b, $03
    call ShowSkillNameAtSlotB
    ld a, [hl+]
    ld b, $04
    call ShowSkillNameAtSlotB
    ld a, [hl+]
    ld b, $05
    call ShowSkillNameAtSlotB
    ld a, [hl+]
    ld b, $06
    call ShowSkillNameAtSlotB
    ld a, [hl]
    ld b, $07
    call ShowSkillNameAtSlotB
    ret

; only called from ShowRecordSpeciesAndSkillNames (E-0047)
; 1 call site from 1 routine (e.g. ShowRecordSpeciesAndSkillNames)
; writes: wStringCategory, wStringIndex
ShowRecordSpeciesAndSkillNames_Sub01::
Func_003_4DBE:: ; address name
    cp a, $FF
    jr nz, ShowSkillNameAtSlotB
    push hl
    ld a, $08
    ld [wStringCategory], a
    ld a, $0E
    ld [wStringIndex], a
    jr Jump_003_4DDD

; A = skill number ($FF shows entry 0), B = slot: wStringIndex = A, wStringCategory = 4 (StringTable_SkillNames in the bank-$08 database), then ShowStringBank08AtTilesHL with the tile address from Data_003_4DF2[B] and size $0901; HL kept (E-0076)
; 7 call sites from 1 routine (e.g. ShowRecordSpeciesAndSkillNames)
; writes: wStringIndex, wStringCategory
ShowSkillNameAtSlotB::
Func_003_4DCF:: ; address name
    push hl
    cp a, $FF
    jr nz, Jump_003_4DD5
    xor a, a

Jump_003_4DD5::
    ld [wStringIndex], a
    ld a, $04
    ld [wStringCategory], a

Jump_003_4DDD::
    ld a, b
    ld hl, Data_003_4DF2
    add a, a
    add_a_to_hl
    deref_hl
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank03
    pop hl
    ret

; address loaded by ShowSkillNameAtSlotB
Data_003_4DF2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $80, $93, $10, $94, $A0, $94, $30, $95, $C0, $95, $50, $96, $E0, $96, $70, $97

; only called from WithSRAMDrawMemberRecordByte0D (E-0047)
; 1 call site from 1 routine (e.g. WithSRAMDrawMemberRecordByte0D)
; reads: wMenuSelectedMember, wMenuLastPageRows
; writes: wMenuLastPageRows, wScreenTileBuffer, wWindowTileBuffer
; points at: wTextBuf0
WithSRAMDrawMemberRecordByte0D_Sub01::
Func_003_4E02:: ; address name
    ld c, $0D
    ld a, [wMenuSelectedMember]
    and a, $0F
    call SRAMRecordAddressMapped
    ld a, [hl]
    swap a
    and a, $0F
    ld [wMenuLastPageRows], a
    ld a, l
    add a, $0D
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    and a, [hl]
    dec hl
    cp a, $FF
    jr z, Jump_003_4E69
    ld a, [wMenuLastPageRows]
    ld b, a
    call ShowSpeciesNameAndIconForSlotB
    ld a, [wMenuLastPageRows]
    xor a, $01
    ld b, a
    call ShowSpeciesNameAndIconForSlotB
    ld a, [wMenuLastPageRows]
    ld b, a
    call WithSRAMDrawMemberRecordByte0D_Sub01_CopyTenBytesToTextBuf0
    ld a, [wMenuLastPageRows]
    xor a, $01
    ld b, a
    call WithSRAMDrawMemberRecordByte0D_Sub01_CopyTenBytesToTextBuf0
    ld a, l
    add a, $5A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wMenuLastPageRows]
    ld b, a
    call WithSRAMDrawMemberRecordByte0D_Sub01_Sub03
    ld a, [wMenuLastPageRows]
    xor a, $01
    ld b, a
    call WithSRAMDrawMemberRecordByte0D_Sub01_Sub03
    ld a, [wMenuLastPageRows]
    add a, $CC
    ld [wScreenTileBuffer + $6E], a
    xor a, $01
    ld [wWindowTileBuffer + $26], a
    ret

Jump_003_4E69::
    ld hl, vTiles2 + $580
    ld bc, $0140

Jump_003_4E6F::
    ld a, $FF
    call WriteVRAMByteInc
    xor a, a
    call WriteVRAMByteInc
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_003_4E6F
    ld a, $C3
    ld hl, wScreenTileBuffer + $6A
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    inc hl
    ld [hl], a
    ld hl, wWindowTileBuffer + $22
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    inc hl
    ld [hl], a
    ld hl, wTextBuf0
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld a, $98
    ld [hl+], a
    ld [hl], $F0
    ld hl, vTiles2 + $580
    call SelectString5Category8ThenShow
    ld hl, vTiles2 + $670
    call WithSRAMDrawMemberRecordByte0D_Sub01_Sub01
    ld hl, vTiles2 + $6C0
    call WithSRAMDrawMemberRecordByte0D_Sub01_Sub01
    ld hl, vTiles2 + $7B0
    call WithSRAMDrawMemberRecordByte0D_Sub01_Sub01
    ret

; reads a species id at [HL] (HL += 2), shows its name (category id-high + 2) at the window from Data_003_4F5D[B], loads the species record, sets wD09D = family, wD09E = Data_003_4F61[B] and far-calls Func_016_7A48 (E-0121)
; 2 call sites from 1 routine (e.g. WithSRAMDrawMemberRecordByte0D_Sub01)
; reads: wSpeciesRecord
; writes: wSpeciesIdLo, wStringIndex, wSpeciesIdHi, wStringCategory, wWorkBuf
ShowSpeciesNameAndIconForSlotB::
Func_003_4EB6:: ; address name
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld [wStringIndex], a
    ld a, [hl+]
    ld [wSpeciesIdHi], a
    add a, $02
    ld [wStringCategory], a
    push hl
    push bc
    ld hl, Data_003_4F5D
    ld a, b
    add a, a
    add_a_to_hl
    deref_hl
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank03
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord]
    ld [wWorkBuf], a
    pop bc
    ld a, b
    ld hl, Data_003_4F61
    add_a_to_hl
    ld a, [hl]
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    pop hl
    ret

; only called from WithSRAMDrawMemberRecordByte0D_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. WithSRAMDrawMemberRecordByte0D_Sub01)
WithSRAMDrawMemberRecordByte0D_Sub01_CopyTenBytesToTextBuf0::
Func_003_4EFD:: ; address name
    call CopyTenBytesToTextBuf0
    inc hl
    push hl
    push bc
    ld a, b
    ld hl, Data_003_4F63
    call DerefWordTableEntryA_Bank03
    pop bc
    pop hl
    ret

; only called from WithSRAMDrawMemberRecordByte0D_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. WithSRAMDrawMemberRecordByte0D_Sub01)
; reads: wDigits
WithSRAMDrawMemberRecordByte0D_Sub01_Sub03::
Func_003_4F0D:: ; address name
    call CopyTenBytesToTextBuf0
    push hl
    push bc
    ld a, b
    ld hl, Data_003_4F67
    call DerefWordTableEntryA_Bank03
    pop bc
    pop hl
    push hl
    ld a, b
    ld hl, Data_003_4F6B
    add a, a
    add_a_to_hl
    deref_hl
    ld a, $C3
    ld [hl+], a
    ld [hl+], a
    ld [hl], a
    pop hl
    ld a, [hl+]
    push hl
    or a, a
    jr z, Jump_003_4F5B
    ld l, a
    ld h, $00
    push bc
    call HLToDecimalDigits
    pop bc
    ld a, b
    ld hl, Data_003_4F6B
    add a, a
    add_a_to_hl
    deref_hl
    ld a, $FC
    ld [hl+], a
    ld a, [wDigits + $1]
    or a, a
    jr z, Jump_003_4F55
    add a, $E0
    ld [hl+], a

Jump_003_4F55::
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a

Jump_003_4F5B::
    pop hl
    ret

; address loaded by ShowSpeciesNameAndIconForSlotB
Data_003_4F5D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E0, $95, $20, $97

; address loaded by ShowSpeciesNameAndIconForSlotB
Data_003_4F61:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $5D, $71

; address loaded by WithSRAMDrawMemberRecordByte0D_Sub01_CopyTenBytesToTextBuf0
Data_003_4F63:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $70, $96, $B0, $97

; address loaded by WithSRAMDrawMemberRecordByte0D_Sub01_Sub03
Data_003_4F67:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $80, $95, $C0, $96

; address loaded by WithSRAMDrawMemberRecordByte0D_Sub01_Sub03
Data_003_4F6B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $02, $C2, $22, $C3

; reads field $0B of SRAM record wC46D & $0F and decompresses its graphics to vTiles0 (DecompressGraphicsArg1ToArg4); then sets wD7F3-wD7F6 = $00, $90, $40, $00 and hFFB9 = 0 (E-0121)
; 1 call site from 1 routine (e.g. PauseMenu_Main_Case01_Case01)
; reads: wMenuSelectedMember
; writes: rRAMG, rRAMB, wArg1, wArg2, wArg3, wArg4, wArg5, wArg6, ...
DecompressRecordSpeciesGraphicsToTiles0::
Func_003_4F6F:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld c, $0B
    ld a, [wMenuSelectedMember]
    and a, $0F
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld [wArg1], a
    ld a, [hl]
    ld [wArg2], a
    xor a, a
    ld [wArg3], a
    ld hl, vTiles0
    ld a, l
    ld [wArg4], a
    ld a, h
    ld [wArg5], a
    farcall DecompressGraphicsArg1ToArg4
    xor a, a
    ld [rRAMG], a
    ld a, $00
    ld [wArg3], a
    ld a, $90
    ld [wArg4], a
    ld a, $40
    ld [wArg5], a
    ld a, $00
    ld [wArg6], a
    xor a, a
    ldh [hSpriteWindowClipMode], a
    ret

; only called from PauseMenu_Main_Case03_Case01 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_Main_Case03_Case01)
; reads: wMenuSelectedMember
; writes: rRAMG, rRAMB, wArg1, wArg2, wWorkBuf, hSpriteWindowClipMode
; points at: wPartyList
PauseMenu_Main_Case03_Case01_Sub01::
Func_003_4FBB:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wMenuSelectedMember]
    ld hl, wPartyList
    add_a_to_hl
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    ld a, l
    ld [wWorkBuf], a
    ld a, h
    ld [wWorkBuf + $1], a
    farcall LoadPartySpeciesSpriteGraphics
    xor a, a
    ld [rRAMG], a
    xor a, a
    ldh [hSpriteWindowClipMode], a
    ret

Jump_003_4FED::
    ld a, [wTemp1]
    rst $00
    dw PauseMenu_Main_Case03_Case01_Sub01_Case00
    dw PauseMenu_Main_Case03_Case01_Sub01_Case01
    dw PauseMenu_Main_Case03_Case01_Sub01_Case02
    dw PauseMenu_Main_Case03_Case01_Sub01_Case03
    dw PauseMenu_Main_Case03_Case01_Sub01_Case04

; entry 0 of the `rst $00` table in Func_003_4FBB
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: rVBK
; points at: wTemp1
PauseMenu_Main_Case03_Case01_Sub01_Case00::
Jump_003_4FFB:: ; address name
    ld hl, vBGMap0
    ld bc, $1412

Jump_003_5001::
    ld a, $C3
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_003_5001
    ld b, $14
    ld a, l
    add a, $0C
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jr nz, Jump_003_5001
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_003_503D
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0
    ld bc, $1412

Jump_003_5026::
    xor a, a
    call WriteVRAMByteInc
    dec b
    jr nz, Jump_003_5026
    ld b, $14
    ld a, l
    add a, $0C
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jr nz, Jump_003_5026
    xor a, a
    ldh [rVBK], a

Jump_003_503D::
    ld hl, wTemp1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_003_4FBB
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount, wIsCGB
; writes: rRAMG, rRAMB, hTemp0, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wBGPaletteUploadRequest
; points at: wTemp1
PauseMenu_Main_Case03_Case01_Sub01_Case01::
Jump_003_5042:: ; address name
    call LoadScreenBlockForPartySize
    call FillTilesFromRequest
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wPartyCount]
    ld b, a
    ld c, $00

Jump_003_5057::
    push bc
    push bc
    ld a, c
    ld c, $0B
    call SRAMRecordAddressMapped
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop bc
    ld hl, Data_003_518F
    ld a, c
    add_a_to_hl
    ld a, c
    ld c, [hl]
    ld hl, Data_003_5192
    add a, a
    add_a_to_hl
    deref_hl
    push de
    call LoadMonsterPicture
    pop de
    pop bc
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_003_50AC
    push bc
    ld a, c
    ld hl, Data_003_518F
    add_a_to_hl
    ld a, [hl]
    ldh [hTemp0], a
    ld a, c
    ld hl, Data_003_5198
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    add a, $00
    ld l, a
    ld a, h
    adc a, $D0
    ld h, a
    call LoadMonsterPictureAttributeBlock
    pop bc

Jump_003_50AC::
    call DrawRecordHPMPAndLevelForRowC
    call ShowRecordSpeciesNameForRowC
    call DrawRecordByte0EMarkTile
    inc c
    dec b
    jr nz, Jump_003_5057
    ld hl, vTiles1
    ld de, $1202
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    xor a, a
    ld [rRAMG], a
    ld hl, wTemp1
    inc [hl]
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    ret

; for record C writes HP (field $5B), MP (field $5F) and level (field $56) as digits at the screen-buffer position Data_003_519E[C] (E-0127)
; 1 call site from 1 routine (e.g. PauseMenu_Main_Case03_Case01_Sub01_Case01)
DrawRecordHPMPAndLevelForRowC::
Func_003_50DD:: ; address name
    push bc
    ld a, c
    ld hl, Data_003_519E
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, c
    ld c, $5B
    call SRAMRecordAddressMapped
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    push de
    call HLToDecimalDigits
    pop de
    push de
    call WriteDecimalDigitTiles
    pop de
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop hl
    inc hl
    inc hl
    inc hl
    push hl
    deref_hl
    push de
    call HLToDecimalDigits
    pop de
    push de
    call WriteDecimalDigitTiles
    pop de
    ld a, e
    add a, $21
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop hl
    ld a, l
    add a, $F7
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    ld l, [hl]
    ld h, $00
    push de
    call HLToDecimalDigits
    pop de
    call WriteTwoDigitTilesFromWC8C1
    pop bc
    ret

; shows the species name (field $0B) of SRAM record C in the window from Data_003_51A4[C], size $0109 (E-0121)
; 1 call site from 1 routine (e.g. PauseMenu_Main_Case03_Case01_Sub01_Case01)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringIndex, wStringCategory
ShowRecordSpeciesNameForRowC::
Func_003_5137:: ; address name
    push bc
    ld a, c
    ld hl, Data_003_51A4
    add a, a
    add_a_to_hl
    deref_hl
    ld de, $0901
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    ld a, c
    ld c, $0B
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld h, [hl]
    ld [wStringIndex], a
    ld a, h
    add a, $02
    ld [wStringCategory], a
    farcall ShowString_Bank08
    pop bc
    ret

; C = record: writes tile $CC + (bit 0 of record byte $0E) at the address from Data_003_51AA[C]; BC kept (E-0120)
; 1 call site from 1 routine (e.g. PauseMenu_Main_Case03_Case01_Sub01_Case01)
DrawRecordByte0EMarkTile::
Func_003_5171:: ; address name
    push bc
    ld a, c
    ld hl, Data_003_51AA
    add a, a
    add_a_to_hl
    deref_hl
    push hl
    ld a, c
    ld c, $0E
    call SRAMRecordAddressMapped
    ld a, [hl]
    pop hl
    and a, $01
    add a, $CC
    ld [hl], a
    pop bc
    ret

; address loaded by PauseMenu_Main_Case03_Case01_Sub01_Case01
Data_003_518F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $03, $05

; address loaded by PauseMenu_Main_Case03_Case01_Sub01_Case01
Data_003_5192:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $91, $80, $93, $C0, $95

; address loaded by PauseMenu_Main_Case03_Case01_Sub01_Case01
Data_003_5198:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $80, $00, $00, $01

; address loaded by DrawRecordHPMPAndLevelForRowC
Data_003_519E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FA, $C1, $00, $C2, $06, $C2

; address loaded by ShowRecordSpeciesNameForRowC
Data_003_51A4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $88, $90, $88, $20, $89

; address loaded by DrawRecordByte0EMarkTile
Data_003_51AA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $66, $C3, $86, $C3, $A6, $C3

; entry 2 of the `rst $00` table in Func_003_4FBB
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wPartyCount
; writes: rVBK, rSVBK
; points at: wScreenAttrBuffer, wTemp1
PauseMenu_Main_Case03_Case01_Sub01_Case02::
Jump_003_51B0:: ; address name
    call CopyTileBufferToBGMap
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_003_51FB
    ld bc, $0606
    ld a, $01
    ldh [rVBK], a
    ld a, $02
    ldh [rSVBK], a
    ld hl, vBGMap0 + $E1
    ld de, wScreenAttrBuffer
    call CopyRectToVRAMSourceStrideBPlus14_Bank03
    ld a, [wPartyCount]
    cp a, $01
    jr z, Jump_003_51F3
    ld hl, vBGMap0 + $E7
    ld de, wScreenAttrBuffer + $80
    ld bc, $0606
    call CopyRectToVRAMSourceStrideBPlus14_Bank03
    ld a, [wPartyCount]
    cp a, $02
    jr z, Jump_003_51F3
    ld hl, vBGMap0 + $ED
    ld de, wScreenAttrBuffer + $100
    ld bc, $0606
    call CopyRectToVRAMSourceStrideBPlus14_Bank03

Jump_003_51F3::
    ld a, $00
    ldh [rSVBK], a
    ld a, $00
    ldh [rVBK], a

Jump_003_51FB::
    ld hl, wTemp1
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_003_4FBB
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed
; points at: wTemp1
PauseMenu_Main_Case03_Case01_Sub01_Case03::
Jump_003_5200:: ; address name
    ld a, [wJoypadPressed]
    and a, $04
    ret z
    ld hl, wTemp1
    inc [hl]
    ret

; entry 4 of the `rst $00` table in Func_003_4FBB
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: rVBK, wDataBankSave, wTemp1, wPauseMenuScreen
PauseMenu_Main_Case03_Case01_Sub01_Case04::
Jump_003_520B:: ; address name
    ld hl, vBGMap0
    ld bc, $1412
    ld d, $C3
    call FillVRAMRowsWithD
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_003_522E
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap0 + $E0
    ld bc, $1406
    ld d, $00
    call FillVRAMRowsWithD
    xor a, a
    ldh [rVBK], a

Jump_003_522E::
    call WriteSixteenTilesFrom5264AtTiles2140
    xor a, a
    ld [wDataBankSave], a
    xor a, a
    ld [wTemp1], a
    xor a, a
    ld [wPauseMenuScreen], a
    ret

; D = tile, B = first-row width, C = rows: writes D with WriteVRAMByteInc; after each row moves 12 entries on (to the next 32-entry row) and uses width 20 (E-0117)
; 2 call sites from 1 routine (e.g. PauseMenu_Main_Case03_Case01_Sub01_Case04)
FillVRAMRowsWithD::
Func_003_523E:: ; address name
    ld a, d
    call WriteVRAMByteInc
    dec b
    jr nz, FillVRAMRowsWithD
    ld a, l
    add a, $0C
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld b, $14
    dec c
    jr nz, FillVRAMRowsWithD
    ret

; writes the 16 bytes at Data_003_5264 to vTiles2 + $140 (E-0122)
; 1 call site from 1 routine (e.g. PauseMenu_Main_Case03_Case01_Sub01_Case04)
WriteSixteenTilesFrom5264AtTiles2140::
Func_003_5253:: ; address name
    ld de, Data_003_5264
    ld hl, vTiles2 + $140
    ld b, $10

Jump_003_525B::
    ld a, [de]
    call WriteVRAMByteInc
    inc de
    dec b
    jr nz, Jump_003_525B
    ret

; address loaded by WriteSixteenTilesFrom5264AtTiles2140
Data_003_5264:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $00, $FF, $10, $FF, $10, $FF, $FE, $FF, $7C, $FF, $38, $FF, $7C, $FF, $C6

; GameMode2_Update, wModeState 1: the ITEM list ('No items' at the start of a game) (E-0046)
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp0
PauseMenu_Items::
Jump_003_5274:: ; address name
    ld a, [wTemp0]
    rst $00
    dw PauseMenu_Items_Case00
    dw PauseMenu_Items_Case01
    dw PauseMenu_Items_Case02
    dw PauseMenu_Items_Case03

; entry 0 of the `rst $00` table in PauseMenu_Items
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp1
PauseMenu_Items_Case00::
Jump_003_5280:: ; address name
    ld a, [wTemp1]
    rst $00
    dw PauseMenu_Items_Case00_Case00
    dw PauseMenu_Items_Case00_Case01

; entry 0 of the `rst $00` table in PauseMenu_Items_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wLevelUpGains
; points at: wTemp1
PauseMenu_Items_Case00_Case00::
Jump_003_5288:: ; address name
    ld a, [wLevelUpGains]
    or a, a
    call nz, RefreshRecordListAndNameTiles
    call SetupInventoryMenuPages_Bank03
    call BuildInventoryScreenBase
    call SetMenuRowsForPage_Bank03_59DB
    call ShowSelectedItemDescription
    call CopyTileBufferToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_Items_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wInventory, wJoypadPressed, wJoypadPressedRepeat, wMenuRowCount, wMenuPage, wMenuCursor
; writes: wInventorySlot, wItemId, wTemp1, wSubMenuCursor
; points at: wMenuCursor, wInventory, wTextBuf2, wPlayerName, wTextBuf0, wTemp0
PauseMenu_Items_Case00_Case01::
Jump_003_52A3:: ; address name
    ld a, [wInventory]
    or a, a
    jr nz, Jump_003_52AE
    ld a, [wJoypadPressed]
    jr Jump_003_5328

Jump_003_52AE::
    ld de, Data_003_4617
    ld hl, wMenuCursor
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, Jump_003_52C8
    ld a, [wMenuRowCount]
    cp a, $01
    ret z
    call ShowSelectedItemDescription
    ret

Jump_003_52C8::
    ld hl, wMenuCursor
    bit 7, [hl]
    jr z, Jump_003_52DE
    res 7, [hl]
    call SetMenuRowsForPage_Bank03_59DB
    call ShowSelectedItemDescription
    call ShowInventoryPageItemNames_Bank03
    call DrawMenuPageNumber_Bank03
    ret

Jump_003_52DE::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_5328
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuPage]
    add a, a
    add a, a
    ld c, a
    ld a, [wMenuCursor]
    add a, c
    ld [wInventorySlot], a
    ld hl, wInventory
    add_a_to_hl
    ld a, [hl]
    ld [wItemId], a
    ld l, a
    ld h, $05
    ld de, wTextBuf2
    call CopyStringHLToDE
    ld de, wPlayerName
    ld hl, wTextBuf0
    call CopyFiveGlyphsPlusMarks
    farcall LoadItemRecord
    ld hl, wTemp0
    inc [hl]
    xor a, a
    ld [wTemp1], a
    xor a, a
    ld [wSubMenuCursor], a
    ret

Jump_003_5328::
    bit 1, a
    jr z, Jump_003_5330
    call ExitPauseMenuToField
    ret

Jump_003_5330::
    bit 2, a
    ret z
    farcall SortInventory
    call ShowSelectedItemDescription
    call ShowInventoryPageItemNames_Bank03
    ret

; entry 1 of the `rst $00` table in PauseMenu_Items
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp1
PauseMenu_Items_Case01::
Jump_003_5340:: ; address name
    ld a, [wTemp1]
    rst $00
    dw PauseMenu_Items_Case01_BuildScreenBlock0EWithCursorAndStep
    dw PauseMenu_Items_Case01_Case01

; entry 0 of the `rst $00` table in PauseMenu_Items_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wMenuRowCount, wMenuPageCount
; points at: wTemp1
PauseMenu_Items_Case01_BuildScreenBlock0EWithCursorAndStep::
Jump_003_5348:: ; address name
    call BuildScreenBlock0EWithCursor
    call CopyTileBufferToBGMap
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    ld hl, wTemp1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_Items_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wSubMenuCursor
; writes: wTemp0, wTemp1
; points at: wSubMenuCursor, wTemp0
PauseMenu_Items_Case01_Case01::
Jump_003_535D:: ; address name
    ld de, Data_003_461F
    ld hl, wSubMenuCursor
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_5381
    ld a, $69
    call QueueSoundEffect
    ld a, [wSubMenuCursor]
    and a, $01
    add a, $02
    ld [wTemp0], a
    xor a, a
    ld [wTemp1], a
    ret

Jump_003_5381::
    bit 1, a
    ret z
    ld hl, wTemp0
    dec [hl]
    xor a, a
    ld [wTemp1], a
    ret

; entry 2 of the `rst $00` table in PauseMenu_Items
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp1
PauseMenu_Items_Case02::
Jump_003_538D:: ; address name
    ld a, [wTemp1]
    rst $00
    dw PauseMenu_Items_Case02_Case00
    dw PauseMenu_Items_Case02_BuildScreenBlock0EWithSubMenuCursorAndStep
    dw PauseMenu_Items_Case02_BeginStringDisplay_Bank08AndStep
    dw PauseMenu_Items_Case02_Case03
    dw PauseMenu_Items_Case02_BuildItemScreenForWItemIdAndStep
    dw PauseMenu_Items_Case02_Case05
    dw PauseMenu_Items_Case02_BuildItemScreenWithRecordCursorAndStep
    dw PauseMenu_Items_Case02_Case07
    dw PauseMenu_Items_Case02_Case08
    dw PauseMenu_Items_Case02_Case09
    dw PauseMenu_Items_Case02_Case0A
    dw PauseMenu_Items_Case02_Case0B
    dw PauseMenu_Items_Case02_Case0A
    dw PauseMenu_Items_Case02_BuildScreenBlock0EWithSubMenuCursorAndStep
    dw PauseMenu_Items_Case02_Case07
    dw PauseMenu_Items_Case02_Case08
    dw PauseMenu_Items_Case02_Case09
    dw PauseMenu_Items_Case02_Case0A
    dw PauseMenu_Items_Case02_Case0B
    dw PauseMenu_Items_Case02_Case0A
    dw PauseMenu_Items_Case02_BuildScreenBlock0EWithSubMenuCursorAndStep
    dw PauseMenu_Items_Case02_Case07
    dw PauseMenu_Items_Case02_Case16
    dw PauseMenu_Items_Case02_ShowButNothingHappened
    dw PauseMenu_Items_Case02_Case18
    dw PauseMenu_Items_Case02_Case19
    dw PauseMenu_Items_Case02_Case1A
    dw PauseMenu_Items_Case02_ShowButItCouldntBe
    dw PauseMenu_Items_Case02_Case1C
    dw PauseMenu_Items_Case02_Case1D
    dw PauseMenu_Items_Case02_Case1E
    dw PauseMenu_Items_Case02_Case1F
    dw PauseMenu_Items_Case02_ShowYourProgressHasBeen
    dw PauseMenu_Items_Case02_Case21

; entry 0 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wItemRecord
; writes: wTemp1
; points at: wTemp1
PauseMenu_Items_Case02_Case00::
Jump_003_53D5:: ; address name
    ld a, [wItemRecord + $4]
    bit 1, a
    jr nz, Jump_003_53FC
    ld a, [wItemRecord + $6]
    or a, a
    jr z, Jump_003_53F0
    cp a, $04
    jr z, Jump_003_53F0
    cp a, $07
    jr z, Jump_003_53F6
    ld a, $0D
    ld [wTemp1], a
    ret

Jump_003_53F0::
    ld a, $04
    ld [wTemp1], a
    ret

Jump_003_53F6::
    ld a, $14
    ld [wTemp1], a
    ret

Jump_003_53FC::
    ld hl, wTemp1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; points at: wTemp1
PauseMenu_Items_Case02_BuildScreenBlock0EWithSubMenuCursorAndStep::
Jump_003_5401:: ; address name
    call BuildScreenBlock0EWithSubMenuCursor
    call CopyTileBufferToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

; entry 2 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wTemp1
PauseMenu_Items_Case02_BeginStringDisplay_Bank08AndStep::
Jump_003_540C:: ; address name
    ld a, $08
    ld [wStringCategory], a
    ld a, $06
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    ld hl, wTemp1
    inc [hl]
    ret

; entry 3 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wTemp0, wTemp1
PauseMenu_Items_Case02_Case03::
Jump_003_5421:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    xor a, a
    ld [wTemp0], a
    xor a, a
    ld [wTemp1], a
    ret

; entry 4 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount
; writes: wMenuSelectedMember, wMenuRowCount, wMenuPageCount
; points at: wTemp1
PauseMenu_Items_Case02_BuildItemScreenForWItemIdAndStep::
Jump_003_542F:: ; address name
    xor a, a
    ld [wMenuSelectedMember], a
    call BuildItemScreenForWItemId
    call CopyTileBufferToBGMap
    ld a, [wPartyCount]
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    ld hl, wTemp1
    inc [hl]
    ret

; entry 5 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wMenuSelectedMember
; writes: rRAMG, rRAMB, wTargetRecord, wTemp0, wTemp1
; points at: wMenuSelectedMember, wTextBuf1, wTemp1
PauseMenu_Items_Case02_Case05::
Jump_003_5449:: ; address name
    ld de, MenuCursorPositions_Bank03
    ld hl, wMenuSelectedMember
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, Jump_003_5469
    call DrawItemTargetStatPreview
    ld hl, vBGMap0 + $141
    ld bc, $0903
    ld de, wScreenTileBuffer + $141
    call CopyRectToBGMap
    ret

Jump_003_5469::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_549C
    ld a, $69
    call QueueSoundEffect
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wMenuSelectedMember]
    and a, $03
    ld [wTargetRecord], a
    ld c, $01
    call SRAMRecordAddressMapped
    ld e, l
    ld d, h
    ld hl, wTextBuf1
    call CopyFiveGlyphsPlusMarks
    xor a, a
    ld [rRAMG], a
    ld hl, wTemp1
    inc [hl]
    ret

Jump_003_549C::
    bit 1, a
    ret z
    ld a, $01
    ld [wTemp0], a
    xor a, a
    ld [wTemp1], a
    ret

; entry 6 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; points at: wTemp1
PauseMenu_Items_Case02_BuildItemScreenWithRecordCursorAndStep::
Jump_003_54A9:: ; address name
    call BuildItemScreenWithRecordCursor
    call CopyTileBufferToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

; entry 7 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wItemMessage
; writes: wStringCategory, wStringIndex, wTemp1
; points at: wTemp1
PauseMenu_Items_Case02_Case07::
Jump_003_54B4:: ; address name
    ld a, $00
    ld [wStringCategory], a
    ld a, [wItemMessage]
    ld [wStringIndex], a
    cp a, $25
    jr z, Jump_003_54CE
    farcall BeginStringDisplay_Bank37
    ld hl, wTemp1
    inc [hl]
    ret

Jump_003_54CE::
    ld a, $1B
    ld [wTemp1], a
    ret

; entry 8 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wItemId, wItemRecord
; writes: rRAMG, rRAMB, wTemp1
; points at: wTemp1
PauseMenu_Items_Case02_Case08::
Jump_003_54D4:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    farcall CheckItemUsable
    xor a, a
    ld [rRAMG], a
    ld hl, wTemp1
    inc [hl]
    ld a, [wItemId]
    cp a, $FF
    ret z
    ld a, [wItemRecord + $6]
    cp a, $00
    jr z, Jump_003_550C
    cp a, $02
    jr z, Jump_003_550C
    cp a, $04
    jr z, Jump_003_550C
    ld a, $12
    ld [wTemp1], a
    ret

Jump_003_550C::
    ld a, $0B
    ld [wTemp1], a
    ret

; entry 9 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wInventorySlot
; writes: wStringIndex, wStringCategory
; points at: wInventory, wTemp1
PauseMenu_Items_Case02_Case09::
Jump_003_5512:: ; address name
    ld a, [wInventorySlot]
    ld hl, wInventory
    add_a_to_hl
    ld a, [hl]
    cp a, $40
    jr c, Jump_003_5532
    cp a, $62
    jr nc, Jump_003_5532
    ld a, $32
    ld [wStringIndex], a
    ld a, $00
    ld [wStringCategory], a
    jr Jump_003_553C

Jump_003_5532::
    ld a, $02
    ld [wStringIndex], a ; 'But nothing happened!'
    ld a, $00
    ld [wStringCategory], a

Jump_003_553C::
    farcall BeginStringDisplay_Bank37
    ld hl, wTemp1
    inc [hl]
    ret

; entry 10 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
PauseMenu_Items_Case02_Case0A::
Jump_003_5547:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    call ResetInventoryMenuToFirstPage
    ret

; entry 11 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wItemRecordByte0A, hTemp0
; writes: rRAMG, rRAMB, wStringIndex, wStringCategory, wMenuPage, wMenuCursor
; points at: wTemp1
PauseMenu_Items_Case02_Case0B::
Jump_003_5550:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    farcall ApplyItemEffect
    xor a, a
    ld [rRAMG], a
    ld a, [wItemRecordByte0A]
    ld [wStringIndex], a
    cp a, $27
    jr z, Jump_003_5585

Jump_003_556E::
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37
    ld hl, wTemp1
    inc [hl]
    xor a, a
    ld [wMenuPage], a
    ld [wMenuCursor], a
    ret

Jump_003_5585::
    ldh a, [hTemp0]
    or a, a
    jr z, Jump_003_556E
    ld a, $31
    ld [wStringIndex], a
    jr Jump_003_556E

; entry 22 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wItemId, wItemRecordByte0A
; writes: rRAMG, rRAMB
; points at: wTemp1
PauseMenu_Items_Case02_Case16::
Jump_003_5591:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    farcall CheckItemUsable
    xor a, a
    ld [rRAMG], a
    ld hl, wTemp1
    inc [hl]
    ld a, [wItemId]
    cp a, $FF
    ret z
    cp a, $FE
    ret z
    ld hl, wTemp1
    inc [hl]
    ld hl, wTemp1
    inc [hl]
    ld a, [wItemRecordByte0A]
    or a, a
    ret nz
    ld hl, wTemp1
    inc [hl]
    ret

; entry 23 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; writes: wStringIndex, wStringCategory
; points at: wTemp1
PauseMenu_Items_Case02_ShowButNothingHappened::
Jump_003_55C9:: ; address name
    ld a, $02
    ld [wStringIndex], a ; 'But nothing happened!'
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37
    ld hl, wTemp1
    inc [hl]
    ret

; entry 24 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wTemp0, wTemp1
PauseMenu_Items_Case02_Case18::
Jump_003_55DE:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    xor a, a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

; entry 25 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wItemRecordByte0A
; writes: rRAMG, rRAMB, wStringIndex, wStringCategory
; points at: wTemp1
PauseMenu_Items_Case02_Case19::
Jump_003_55EB:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    farcall ApplyItemEffect
    xor a, a
    ld [rRAMG], a
    ld a, [wItemRecordByte0A]
    ld [wStringIndex], a
    cp a, $FF
    jr z, Jump_003_5614
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37

Jump_003_5614::
    ld hl, wTemp1
    inc [hl]
    ret

; entry 26 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
PauseMenu_Items_Case02_Case1A::
Jump_003_5619:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    call ExitPauseMenuToField
    ret

; entry 27 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wItemId
; writes: wStringCategory, wStringIndex
; points at: wTemp1
PauseMenu_Items_Case02_ShowButItCouldntBe::
Jump_003_5622:: ; address name
    farcall CheckItemUsable
    ld hl, wTemp1
    inc [hl]
    ld a, [wItemId]
    cp a, $FF
    jr nz, Jump_003_5643
    ld a, $01
    ld [wStringCategory], a
    ld a, $14
    ld [wStringIndex], a ; 'But it couldn't be used here.'
    ld hl, wTemp1
    inc [hl]
    inc [hl]
    inc [hl]

Jump_003_5643::
    farcall BeginStringDisplay_Bank37
    ret

; entry 28 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wMenuRowCount, wMenuPageCount, wSubMenuCursor
; points at: wTemp1
PauseMenu_Items_Case02_Case1C::
Jump_003_564A:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $6C
    call QueueSoundEffect
    call LoadScreenBlock2B
    call CopyTileBufferToBGMap
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    xor a, a
    ld [wSubMenuCursor], a
    ld hl, wTemp1
    inc [hl]
    ret

; entry 29 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wSubMenuCursor, wMapType, wPendingFieldEvent, wSpriteSlotCount, wScreenSavedFlag
; writes: wItemMenuByte6D, wItemMenuByte6E, wSpriteSlotCount, wScreenSavedFlag, rRAMG, rRAMB, wPauseMenuScreen, wTemp0, ...
; points at: wSubMenuCursor, wTemp1
PauseMenu_Items_Case02_Case1D::
Jump_003_566D:: ; address name
    ld hl, wSubMenuCursor
    ld de, Data_003_4645
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_56C7
    ld a, $69
    call QueueSoundEffect
    ld a, [wSubMenuCursor]
    and a, $01
    jr nz, Jump_003_56CA
    ld a, [wMapType]
    cp a, $80
    jr nz, Jump_003_56AA
    ld a, [wPendingFieldEvent]
    bit 7, a
    jr z, Jump_003_56AA
    ld a, [wSpriteSlotCount]
    ld [wItemMenuByte6D], a
    ld a, [wScreenSavedFlag]
    ld [wItemMenuByte6E], a
    xor a, a
    ld [wSpriteSlotCount], a
    ld [wScreenSavedFlag], a

Jump_003_56AA::
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    farcall ApplyItemEffect
    xor a, a
    ld [rRAMG], a
    xor a, a
    ld [wPauseMenuScreen], a
    ld hl, wTemp1
    inc [hl]
    ret

Jump_003_56C7::
    bit 1, a
    ret z

Jump_003_56CA::
    xor a, a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

; entry 30 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wPauseMenuScreen
; points at: wTemp1
PauseMenu_Items_Case02_Case1E::
Jump_003_56D2:: ; address name
    call RunPauseMenuScreen
    ld a, [wPauseMenuScreen]
    cp a, $04
    ret nz
    ld hl, wTemp1
    inc [hl]
    ld hl, wTemp1
    inc [hl]
    ret

; entry 31 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wTemp0, wTemp1
PauseMenu_Items_Case02_Case1F::
Jump_003_56E4:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    jr Jump_003_56CA

; entry 32 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; writes: wStringIndex, wStringCategory
; points at: wTemp1
PauseMenu_Items_Case02_ShowYourProgressHasBeen::
Jump_003_56EB:: ; address name
    ld a, $26
    ld [wStringIndex], a ; 'Your progress has been recorded.'
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37
    ld hl, wTemp1
    inc [hl]
    ret

; entry 33 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wMapType, wPendingFieldEvent, wItemMenuByte6D, wItemMenuByte6E
; writes: wSpriteSlotCount, wScreenSavedFlag, wTemp0, wTemp1, wPauseMenuScreen
PauseMenu_Items_Case02_Case21::
Jump_003_5700:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wMapType]
    cp a, $80
    jr nz, Jump_003_571F
    ld a, [wPendingFieldEvent]
    bit 7, a
    jr z, Jump_003_571F
    ld a, [wItemMenuByte6D]
    ld [wSpriteSlotCount], a
    ld a, [wItemMenuByte6E]
    ld [wScreenSavedFlag], a

Jump_003_571F::
    call ResetInventoryMenuToFirstPage
    xor a, a
    ld [wTemp0], a
    ld [wTemp1], a
    ld [wPauseMenuScreen], a
    ret

; entry 3 of the `rst $00` table in PauseMenu_Items
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp1
PauseMenu_Items_Case03::
Jump_003_572D:: ; address name
    ld a, [wTemp1]
    rst $00
    dw PauseMenu_Items_Case03_BuildScreenBlock0EWithSubMenuCursorAndStep
    dw PauseMenu_Items_Case03_BeginStringDisplay_Bank08AndStep
    dw PauseMenu_Items_Case03_Case02
    dw PauseMenu_Items_Case03_Case03
    dw PauseMenu_Items_Case03_Case04
    dw PauseMenu_Items_Case03_Case05
    dw PauseMenu_Items_Case03_ToResetInventoryMenuToFirstPage

; entry 0 of the `rst $00` table in PauseMenu_Items_Case03
; no direct call (reached through a table, a jump or a vector)
; points at: wTemp1
PauseMenu_Items_Case03_BuildScreenBlock0EWithSubMenuCursorAndStep::
Jump_003_573F:: ; address name
    call BuildScreenBlock0EWithSubMenuCursor
    call CopyTileBufferToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_Items_Case03
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wTemp1
PauseMenu_Items_Case03_BeginStringDisplay_Bank08AndStep::
Jump_003_574A:: ; address name
    ld a, $08
    ld [wStringCategory], a
    ld a, $01
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    ld hl, wTemp1
    inc [hl]
    ret

; entry 2 of the `rst $00` table in PauseMenu_Items_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wSubMenuCursor2, wMenuRowCount, wMenuPageCount
; points at: wTemp1
PauseMenu_Items_Case03_Case02::
Jump_003_575F:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    xor a, a
    ld [wSubMenuCursor2], a
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    call BuildScreenBlocks0EAnd0FWithCursor
    call CopyTileBufferToBGMap
    ld a, $6C
    call QueueSoundEffect
    ld hl, wTemp1
    inc [hl]
    ret

; entry 3 of the `rst $00` table in PauseMenu_Items_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wSubMenuCursor2
; writes: wTemp1, wTemp0
; points at: wSubMenuCursor2
PauseMenu_Items_Case03_Case03::
Jump_003_5782:: ; address name
    ld de, Data_003_4623
    ld hl, wSubMenuCursor2
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_57B9
    ld a, $69
    call QueueSoundEffect
    ld a, [wSubMenuCursor2]
    and a, $01
    ld hl, Data_003_4623
    add a, a
    add_a_to_hl
    deref_hl
    ld a, $BC
    call WriteVRAMByte
    ld a, [wSubMenuCursor2]
    and a, $01
    add a, a
    add a, $04
    ld [wTemp1], a
    ret

Jump_003_57B9::
    bit 1, a
    ret z
    ld a, $01
    ld [wTemp0], a
    xor a, a
    ld [wTemp1], a
    ret

; entry 4 of the `rst $00` table in PauseMenu_Items_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wItemRecord, wInventorySlot
; writes: wStringCategory, wStringIndex
; points at: wTemp1, wInventory
PauseMenu_Items_Case03_Case04::
Jump_003_57C6:: ; address name
    ld a, [wItemRecord + $8]
    bit 1, a
    jr z, Jump_003_57E2
    ld a, $08
    ld [wStringCategory], a
    ld a, $02
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    ld hl, wTemp1
    inc [hl]
    ret

Jump_003_57E2::
    ld a, [wInventorySlot]
    ld hl, wInventory
    add_a_to_hl
    ld [hl], $00
    ld a, $08
    ld [wStringCategory], a
    ld a, $04
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    farcall CompactInventory
    ld hl, wTemp1
    inc [hl]
    ret

; entry 5 of the `rst $00` table in PauseMenu_Items_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wMenuPage, wMenuCursor
PauseMenu_Items_Case03_Case05::
Jump_003_580A:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    xor a, a
    ld [wMenuPage], a
    ld [wMenuCursor], a
    call ResetInventoryMenuToFirstPage
    ret

; entry 6 of the `rst $00` table in PauseMenu_Items_Case03
; no direct call (reached through a table, a jump or a vector)
PauseMenu_Items_Case03_ToResetInventoryMenuToFirstPage::
Jump_003_581A:: ; address name
    call ResetInventoryMenuToFirstPage
    ret

; clears the screen buffer, copies blocks $0B and $0C and, with items, block $0D and the page indicator (page wMenuPage of wC0A7) (E-0124)
; 3 call sites from 3 routines (e.g. PauseMenu_State4_Sub01_ResetInventoryMenuToFirstPage, PauseMenu_Items_Case00_Case00, BuildScreenBlock0EWithCursor)
; reads: wInventory, wMenuItemCount, wMenuPage
BuildInventoryScreenBase::
Func_003_581E:: ; address name
    call ClearScreenTileBuffer_Bank03
    ld e, $0B
    farcall CopyBlockToTileBuffer
    ld e, $0C
    farcall CopyBlockToTileBuffer
    ld a, [wInventory]
    or a, a
    ret z
    ld e, $0D
    farcall CopyBlockToTileBuffer
    ld a, [wMenuItemCount]
    cp a, $02
    jr c, Jump_003_585C
    ld hl, wScreenTileBuffer + $10E
    ld a, $C5
    ld [hl+], a
    ld a, [wMenuPage]
    add a, $E1
    ld [hl+], a
    ld a, $BE
    ld [hl+], a
    ld a, [wMenuItemCount]
    add a, $E0
    ld [hl+], a
    ld [hl], $C6

Jump_003_585C::
    ret

; runs Func_003_581E, copies screen block $0E to the tile buffer and draws the cursor for wC46E & 7 (E-0122)
; 4 call sites from 4 routines (e.g. PauseMenu_Items_Case01_BuildScreenBlock0EWithCursorAndStep, BuildItemScreenForWItemId, BuildScreenBlock0EWithSubMenuCursor, BuildScreenBlocks0EAnd0F)
; reads: wMenuCursor
BuildScreenBlock0EWithCursor::
Func_003_585D:: ; address name
    call BuildInventoryScreenBase
    ld e, $0E
    farcall CopyBlockToTileBuffer
    ld a, [wMenuCursor]
    and a, $07
    ld hl, Data_003_4617
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ret

; builds block $0E with the cursor, blocks $11 and $1B, and the rectangle chosen by wItemId (Data_003_5C8B to Data_003_5CEE), then runs Func_003_5AA7 (E-0122)
; 2 call sites from 2 routines (e.g. BuildItemScreenWithRecordCursor, PauseMenu_Items_Case02_BuildItemScreenForWItemIdAndStep)
; reads: wItemId
BuildItemScreenForWItemId::
Func_003_5874:: ; address name
    call BuildScreenBlock0EWithCursor
    ld e, $11
    farcall CopyBlockToTileBuffer
    ld e, $1B
    farcall CopyBlockToTileBuffer
    ld a, [wItemId]
    ld hl, Data_003_5C8B
    add_a_to_hl
    ld a, [hl]
    ld hl, Data_003_5CEE
    add a, a
    add_a_to_hl
    deref_hl
    call CopyRecordRectToScreenBuffer_Bank03
    call DrawItemTargetStatPreview
    ret

; fills tiles, builds the item screen, copies block $10 and draws the cursor for wC46D & 3 (E-0122)
; 1 call site from 1 routine (e.g. PauseMenu_Items_Case02_BuildItemScreenWithRecordCursorAndStep)
; reads: wMenuSelectedMember
BuildItemScreenWithRecordCursor::
Func_003_58A6:: ; address name
    call FillTilesFromRequest
    call BuildItemScreenForWItemId
    ld e, $10
    farcall CopyBlockToTileBuffer
    ld a, [wMenuSelectedMember]
    and a, $03
    ld hl, MenuCursorPositions_Bank03
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ret

; builds block $0E with the cursor and copies block $0F (E-0122)
; 1 call site from 1 routine (e.g. BuildScreenBlocks0EAnd0FWithCursor)
BuildScreenBlocks0EAnd0F::
Func_003_58C0:: ; address name
    call BuildScreenBlock0EWithCursor
    ld e, $0F
    farcall CopyBlockToTileBuffer
    ret
    db $CD, $0E, $29

; builds blocks $0E and $0F, copies block $10 and draws the cursor for wC46F & 3 (E-0122)
; 1 call site from 1 routine (e.g. PauseMenu_Items_Case03_Case02)
; reads: wSubMenuCursor
BuildScreenBlocks0EAnd0FWithCursor::
Func_003_58CF:: ; address name
    call BuildScreenBlocks0EAnd0F
    ld e, $10
    farcall CopyBlockToTileBuffer
    ld a, [wSubMenuCursor]
    and a, $03
    ld hl, Data_003_461F
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ret

; fills tiles, builds block $0E with the cursor, copies block $10 and draws the cursor for wC46F & 3 (E-0122)
; 2 call sites from 2 routines (e.g. PauseMenu_Items_Case02_BuildScreenBlock0EWithSubMenuCursorAndStep, PauseMenu_Items_Case03_BuildScreenBlock0EWithSubMenuCursorAndStep)
; reads: wSubMenuCursor
BuildScreenBlock0EWithSubMenuCursor::
Func_003_58E6:: ; address name
    call FillTilesFromRequest
    call BuildScreenBlock0EWithCursor
    ld e, $10
    farcall CopyBlockToTileBuffer
    ld a, [wSubMenuCursor]
    and a, $03
    ld hl, Data_003_461F
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ret

; inventory slot = (wMenuPage & $0F) * 4 + (wC46E & $0F): shows that item's string of category 6 (the item descriptions of the bank-$08 database; item $1F uses string $6F) at vTiles2 + $230 with size $1203 (ShowStringBank08AtTilesHL_Bank03) (E-0101)
; 5 call sites from 3 routines (e.g. ShowString0Bank09AtTiles16E0ThenItemDescription, PauseMenu_Items_Case00_Case01, PauseMenu_Items_Case00_Case00)
; reads: wMenuPage, wMenuCursor
; writes: wStringIndex, wStringCategory
; points at: wInventory
ShowSelectedItemDescription::
Func_003_5900:: ; address name
    ld a, [wMenuPage]
    and a, $0F
    add a, a
    add a, a
    ld c, a
    ld a, [wMenuCursor]
    and a, $0F
    add a, c
    ld c, a
    ld b, $00
    ld hl, wInventory
    add hl, bc
    ld a, [hl]
    cp a, $1F
    jr nz, Jump_003_591C
    ld a, $6F

Jump_003_591C::
    ld [wStringIndex], a
    ld a, $06
    ld [wStringCategory], a
    ld hl, vTiles2 + $230
    ld de, $1203
    call ShowStringBank08AtTilesHL_Bank03
    ret

; shows the four item names of inventory page wMenuPage (or the empty-inventory text and wC61E entries) at vTiles2 + $5C0 onward, preserving the window (E-0129)
; 4 call sites from 3 routines (e.g. ShowString0Bank09AtTiles16E0ThenItemDescription, ResetInventoryMenuToFirstPage, PauseMenu_Items_Case00_Case01)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wInventory, wMenuPage
; writes: wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi
; points at: wInventory
ShowInventoryPageItemNames_Bank03::
Func_003_592E:: ; address name
    ld a, [wTextWindowTileLo]
    ld l, a
    ld a, [wTextWindowTileHi]
    ld h, a
    push hl
    ld a, [wTextWindowRows]
    ld l, a
    ld a, [wTextWindowWidth]
    ld h, a
    push hl
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, [wInventory]
    or a, a
    jr nz, Jump_003_5976
    ld a, $08
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    ld hl, vTiles2 + $5C0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    farcall ShowString_Bank08
    ld de, wInventory + $1
    ld hl, vTiles2 + $650
    ld b, $03
    jr Jump_003_598A

Jump_003_5976::
    ld a, [wMenuPage]
    and a, $0F
    add a, a
    add a, a
    ld de, wInventory
    add a, e
    ld e, a
    jr nc, Jump_003_5985
    inc d

Jump_003_5985::
    ld b, $04
    ld hl, vTiles2 + $5C0

Jump_003_598A::
    ld a, $05
    ld [wStringCategory], a

Jump_003_598F::
    ld a, [de]
    cp a, $FF
    jr nz, Jump_003_5995
    xor a, a

Jump_003_5995::
    inc de
    ld [wStringIndex], a
    push bc
    push de
    push hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    farcall ShowString_Bank08
    pop hl
    ld de, $0090
    add hl, de
    pop de
    pop bc
    dec b
    jr nz, Jump_003_598F
    pop hl
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ret

; when wMenuPageCount is non-zero, writes tile $E1 + (wMenuPage & $0F) at vBGMap0 + $10F (E-0067) (the same 20 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. PauseMenu_Items_Case00_Case01)
; reads: wMenuPageCount, wMenuPage
DrawMenuPageNumber_Bank03::
Func_003_59C7:: ; address name
    ld a, [wMenuPageCount]
    or a, a
    jr z, Jump_003_59DA
    ld a, [wMenuPage]
    and a, $0F
    add a, $E1
    ld hl, vBGMap0 + $10F
    call WriteVRAMByte

Jump_003_59DA::
    ret

; when wMenuPage & $0F = wC0A7 - 1 (the last page): wMenuRowCount = wMenuLastPageRows and the cursor row wC46E is clamped below it; otherwise wMenuRowCount = 4; then clears bit 7 of wMenuPage (E-0064) (the same 44 bytes appear in 3 banks)
; 2 call sites from 2 routines (e.g. PauseMenu_Items_Case00_Case01, PauseMenu_Items_Case00_Case00)
; reads: wMenuItemCount, wMenuPage, wMenuLastPageRows, wMenuCursor
; writes: wMenuRowCount, wMenuCursor
; points at: wMenuPage
SetMenuRowsForPage_Bank03_59DB::
Func_003_59DB:: ; address name
    ld a, [wMenuItemCount]
    dec a
    ld c, a
    ld a, [wMenuPage]
    and a, $0F
    cp a, c
    jr nz, Jump_003_59FC
    ld a, [wMenuLastPageRows]
    ld [wMenuRowCount], a
    ld c, a
    ld a, [wMenuCursor]
    cp a, c
    jr c, Jump_003_5A01
    dec c
    ld a, c
    ld [wMenuCursor], a
    jr Jump_003_5A01

Jump_003_59FC::
    ld a, $04
    ld [wMenuRowCount], a

Jump_003_5A01::
    ld hl, wMenuPage
    res 7, [hl]
    ret

; shows string 0 of category 0 (ShowString_Bank09) at vTiles1 + $6E0 with size $0127, preserving the window, then ShowSelectedItemDescription and Func_003_592E (E-0121)
; 1 call site from 1 routine (e.g. PauseMenu_State4_Sub01_ResetInventoryMenuToFirstPage)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex
ShowString0Bank09AtTiles16E0ThenItemDescription::
Func_003_5A07:: ; address name
    ld a, [wTextWindowTileLo]
    ld l, a
    ld a, [wTextWindowTileHi]
    ld h, a
    push hl
    ld a, [wTextWindowRows]
    ld l, a
    ld a, [wTextWindowWidth]
    ld h, a
    push hl
    ld hl, vTiles1 + $6E0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $2701
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $00
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a ; 'WHATUsoePersoHPMPATKDEFAGLINTWLDnality'
    farcall ShowString_Bank09
    pop hl
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    call ShowSelectedItemDescription
    call ShowInventoryPageItemNames_Bank03
    ret

; counts wInventory items until a $00 or $FF byte (24 slots); a $FF ends the list and that slot and the rest are rewritten as $00. Pages of 4: wMenuPageCount = wC0A7 = ceil(count / 4), at least 1; wMenuLastPageRows = count mod 4, or 4; wMenuRowCount = wMenuLastPageRows when wMenuPage equals the page count, else 4 (E-0067) (the same 79 bytes appear in 2 banks)
; 2 call sites from 2 routines (e.g. ResetInventoryMenuToFirstPage, PauseMenu_Items_Case00_Case00)
; reads: wMenuPage, wMenuLastPageRows
; writes: wMenuPageCount, wMenuItemCount, wMenuLastPageRows, wMenuRowCount
; points at: wInventory
SetupInventoryMenuPages_Bank03::
Func_003_5A58:: ; address name
    ld hl, wInventory
    ld bc, $1800

Jump_003_5A5E::
    ld a, [hl+]
    or a, a
    jr z, Jump_003_5A72
    cp a, $FF
    jr z, Jump_003_5A6C
    inc c
    dec b
    jr nz, Jump_003_5A5E
    jr Jump_003_5A72

Jump_003_5A6C::
    dec hl
    xor a, a

Jump_003_5A6E::
    ld [hl+], a
    dec b
    jr nz, Jump_003_5A6E

Jump_003_5A72::
    ld b, c
    ld a, $04
    call DivideBByA
    ld a, c
    and a, $03
    jr z, Jump_003_5A7E
    inc b

Jump_003_5A7E::
    ld a, b
    cp a, $00
    jr nz, Jump_003_5A85
    inc b
    ld a, b

Jump_003_5A85::
    ld [wMenuPageCount], a
    ld [wMenuItemCount], a
    ld a, c
    and a, $03
    or a, a
    jr nz, Jump_003_5A93
    ld a, $04

Jump_003_5A93::
    ld [wMenuLastPageRows], a
    ld a, [wMenuPage]
    cp a, b
    jr nz, Jump_003_5AA1
    ld a, [wMenuLastPageRows]
    jr Jump_003_5AA3

Jump_003_5AA1::
    ld a, $04

Jump_003_5AA3::
    ld [wMenuRowCount], a
    ret

; for item wItemId (kind Data_003_5C8B) writes the target record's affected value (HP, MP or a stat word) as digits in the item screen (E-0131)
; 2 call sites from 2 routines (e.g. BuildItemScreenForWItemId, PauseMenu_Items_Case02_Case05)
; reads: wMenuSelectedMember, wItemId, hTemp0, hTemp1
; writes: rRAMG, rRAMB, wStringIndex, wStringCategory, hTemp0, hTemp1, wScreenTileBuffer, wTextWindowTileLo, ...
DrawItemTargetStatPreview::
Func_003_5AA7:: ; address name
    ld a, [wMenuSelectedMember]
    ld c, a
    ld a, [wItemId]
    ld hl, Data_003_5C8B
    add_a_to_hl
    ld a, [hl]
    push af
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    pop af
    or a, a
    jr z, Jump_003_5AE5
    cp a, $01
    jr z, Jump_003_5AEA
    cp a, $02
    jr z, Jump_003_5B32
    cp a, $03
    jr z, Jump_003_5B01
    cp a, $04
    jr z, Jump_003_5B06
    cp a, $05
    jr z, Jump_003_5B0B
    cp a, $06
    jr z, Jump_003_5B10
    cp a, $07
    jr z, Jump_003_5B15
    jp Jump_003_5B85

Jump_003_5AE5::
    ld a, c
    ld c, $5B
    jr Jump_003_5AED

Jump_003_5AEA::
    ld a, c
    ld c, $5F

Jump_003_5AED::
    call SRAMRecordAddressMapped
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $19
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    jr Jump_003_5B1B

Jump_003_5B01::
    ld a, c
    ld c, $6B
    jr Jump_003_5B18

Jump_003_5B06::
    ld a, c
    ld c, $63
    jr Jump_003_5B18

Jump_003_5B0B::
    ld a, c
    ld c, $65
    jr Jump_003_5B18

Jump_003_5B10::
    ld a, c
    ld c, $67
    jr Jump_003_5B18

Jump_003_5B15::
    ld a, c
    ld c, $69

Jump_003_5B18::
    call SRAMRecordAddressMapped

Jump_003_5B1B::
    deref_hl
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $1D
    call WriteDecimalDigitTiles
    ld a, $C3
    ld [wScreenTileBuffer + $146], a
    ld [wScreenTileBuffer + $147], a
    jp Jump_003_5BFA

Jump_003_5B32::
    ld a, c
    call MapIndexViaPartyList
    call PersonalityIndexOfRecord
    ld c, a
    ld [wStringIndex], a
    ld a, $07
    ld [wStringCategory], a
    ld hl, Data_003_5C28
    ld b, $00
    add hl, bc
    ld a, [hl]
    push af
    ld hl, vTiles2 + $1A0
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank03
    pop af
    ld hl, wWindowTileBuffer + $19
    ld c, a
    ld b, c
    ld a, $1A

Jump_003_5B5B::
    ld [hl+], a
    inc a
    dec b
    jr nz, Jump_003_5B5B
    ld a, $09
    sub a, c
    ld b, a
    or a, a
    jr z, Jump_003_5B6D
    ld a, $C3

Jump_003_5B69::
    ld [hl+], a
    dec b
    jr nz, Jump_003_5B69

Jump_003_5B6D::
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
    jr Jump_003_5BFA

Jump_003_5B85::
    ld a, c
    ld c, $A4
    call SRAMRecordAddressMapped
    ld a, [hl]
    push af
    or a, a
    jr z, Jump_003_5B92
    add a, $3F

Jump_003_5B92::
    ld [wStringIndex], a
    ld a, $05
    ld [wStringCategory], a
    ld hl, vTiles2 + $1A0
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank03
    pop af
    ld hl, RecordA4StringTileCounts_03
    add a, a
    add_a_to_hl
    ld b, [hl]
    ld a, l
    ldh [hTemp0], a
    ld a, h
    ldh [hTemp1], a
    ld hl, wScreenTileBuffer + $141
    ld a, b
    ld c, a
    or a, a
    jr z, Jump_003_5BC4
    ld a, $1A

Jump_003_5BBE::
    ld [hl+], a
    inc a
    dec b
    jr nz, Jump_003_5BBE
    ld d, a

Jump_003_5BC4::
    ld a, $07
    sub a, c
    cp a, $00
    jr z, Jump_003_5BD2
    ld b, a
    ld a, $C3

Jump_003_5BCE::
    ld [hl+], a
    dec b
    jr nz, Jump_003_5BCE

Jump_003_5BD2::
    ld hl, wWindowTileBuffer + $19
    ld b, $07
    ld a, c
    or a, a
    jr z, Jump_003_5BF2
    push hl
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    inc hl
    ld b, [hl]
    pop hl

Jump_003_5BE5::
    ld a, b
    cp a, $00
    jr z, Jump_003_5BF0
    ld a, d
    ld [hl+], a
    inc d
    dec b
    jr nz, Jump_003_5BE5

Jump_003_5BF0::
    ld b, $03

Jump_003_5BF2::
    ld a, $C3

Jump_003_5BF4::
    ld [hl+], a
    dec b
    jr nz, Jump_003_5BF4
    jr Jump_003_5C11

Jump_003_5BFA::
    ld a, [wMenuSelectedMember]
    ld c, $55
    call SRAMRecordAddressMapped
    bit 7, [hl]
    call nz, SetWC2DFTileC2_Bank03_5C16
    bit 2, [hl]
    call nz, SetWC2DFTileC1_Bank03_5C1C
    bit 0, [hl]
    call nz, SetWC2DETileC0_Bank03_5C22

Jump_003_5C11::
    xor a, a
    ld [rRAMG], a
    ret

; wC2DF = $C2 (E-0114) (the same 6 bytes appear in 3 banks)
; 1 call site from 1 routine (e.g. DrawItemTargetStatPreview)
; writes: wScreenTileBuffer
SetWC2DFTileC2_Bank03_5C16::
Func_003_5C16:: ; address name
    ld a, $C2
    ld [wScreenTileBuffer + $147], a
    ret

; wC2DF = $C1 (E-0114) (the same 6 bytes appear in 3 banks)
; 1 call site from 1 routine (e.g. DrawItemTargetStatPreview)
; writes: wScreenTileBuffer
SetWC2DFTileC1_Bank03_5C1C::
Func_003_5C1C:: ; address name
    ld a, $C1
    ld [wScreenTileBuffer + $147], a
    ret

; wC2DE = $C0 (E-0114) (the same 6 bytes appear in 3 banks)
; 1 call site from 1 routine (e.g. DrawItemTargetStatPreview)
; writes: wScreenTileBuffer
SetWC2DETileC0_Bank03_5C22::
Func_003_5C22:: ; address name
    ld a, $C0
    ld [wScreenTileBuffer + $146], a
    ret

; address loaded by DrawItemTargetStatPreview
Data_003_5C28:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $08, $05, $04, $07, $05, $06, $08, $06, $09, $09, $07, $07, $06, $08, $08, $05
    db $06, $07, $05, $03, $05, $03, $07, $05, $08, $08, $04

; E-0239 (C1: after showing string category 5, index (record byte $A4) + $3F (when non-zero) into tiles from vTiles2 + $1A0, the code reads the pair at 2 * (record byte $A4): byte 0 tiles from $1A go into wScreenTileBuffer + $141 (the rest of 7 filled with $C3), byte 1 continues the tile numbers at wWindowTileBuffer + $19; 36 pairs; the bank $03 and $F1 copies are identical).
; record: tiles of the first row, tiles of the second row
RecordA4StringTileCounts_03::
Data_003_5C43:: ; address name
    db $00, $00 ; id 0
    db $03, $04 ; id 1
    db $05, $04 ; id 2
    db $05, $04 ; id 3
    db $03, $04 ; id 4
    db $05, $04 ; id 5
    db $05, $04 ; id 6
    db $04, $05 ; id 7
    db $04, $05 ; id 8
    db $04, $00 ; id 9
    db $07, $00 ; id 10
    db $06, $00 ; id 11
    db $05, $00 ; id 12
    db $05, $04 ; id 13
    db $05, $04 ; id 14
    db $05, $04 ; id 15
    db $04, $04 ; id 16
    db $05, $04 ; id 17
    db $04, $04 ; id 18
    db $05, $04 ; id 19
    db $07, $00 ; id 20
    db $00, $00 ; id 21
    db $00, $00 ; id 22
    db $00, $00 ; id 23
    db $00, $00 ; id 24
    db $00, $00 ; id 25
    db $00, $00 ; id 26
    db $05, $00 ; id 27
    db $07, $00 ; id 28
    db $04, $00 ; id 29
    db $05, $00 ; id 30
    db $06, $00 ; id 31
    db $07, $00 ; id 32
    db $06, $00 ; id 33
    db $07, $00 ; id 34
    db $00, $00 ; id 35

; address loaded by BuildItemScreenForWItemId, DrawItemTargetStatPreview
Data_003_5C8B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $04, $05, $06
    db $07, $00, $01, $02, $02, $02, $02, $02, $02, $03, $03, $03, $03, $03
    ds $22, $00
    ds $23, $08

; address loaded by BuildItemScreenForWItemId
Data_003_5CEE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_003_5D00
    dw Data_003_5D28
    dw Data_003_5D50
    dw Data_003_5D78
    dw Data_003_5DA0
    dw Data_003_5DC8
    dw Data_003_5DF0
    dw Data_003_5E18
    dw Data_003_5E40

; LZSS-compressed asset: 253 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_003_5D00:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $FB, $FC, $ED
    ds $18, $C3
    db $BE, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3

; LZSS-compressed asset: 258 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_003_5D28:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $FD, $FE, $ED
    ds $18, $C3
    db $BE, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3

; LZSS-compressed asset: 261 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_003_5D50:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $F6, $F7, $F8, $F9, $FA, $0E, $0F, $10, $11, $12, $13, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $1A, $1B, $1C, $1D
    db $1E, $1F, $20, $21, $22, $C3, $C3, $C3

; LZSS-compressed asset: 273 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_003_5D78:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $0B, $0C, $0D, $ED
    ds $20, $C3

; LZSS-compressed asset: 302 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_003_5DA0:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $FF, $00, $01, $ED
    ds $20, $C3

; LZSS-compressed asset: 305 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_003_5DC8:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $02, $03, $04, $ED
    ds $20, $C3

; LZSS-compressed asset: 311 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_003_5DF0:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $05, $06, $07, $ED
    ds $20, $C3

; LZSS-compressed asset: 320 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_003_5E18:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03, $08, $09, $0A, $ED
    ds $20, $C3

; LZSS-compressed asset: 324 bytes expand to 321 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_003_5E40:: ; heuristic: target of a monotone pointer table; C0
    db $41, $01, $0C, $03
    ds $24, $C3

; wMenuPage = 0, wC46E = 0, sets up the inventory pages, clamps the page, runs Func_003_592E and clears wC0A0/1 (E-0124)
; 5 call sites from 5 routines (e.g. PauseMenu_State4_Sub01_ResetInventoryMenuToFirstPage, PauseMenu_Items_Case02_Case21, PauseMenu_Items_Case02_Case0A, PauseMenu_Items_Case03_ToResetInventoryMenuToFirstPage, ...)
; writes: wMenuPage, wMenuCursor, wTemp0, wTemp1
; points at: wMenuPage
ResetInventoryMenuToFirstPage::
Func_003_5E68:: ; address name
    xor a, a
    ld [wMenuPage], a
    xor a, a
    ld [wMenuCursor], a
    call SetupInventoryMenuPages_Bank03
    ld hl, wMenuPage

Jump_003_5E76::
    ld a, [hl+]
    cp a, [hl]
    jr c, Jump_003_5E7E
    dec hl
    dec [hl]
    jr Jump_003_5E76

Jump_003_5E7E::
    call ShowInventoryPageItemNames_Bank03
    xor a, a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

; GameMode2_Update, wModeState 2: the SKILLS list ('No skills' at the start) (E-0046)
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp0
PauseMenu_Skills::
Jump_003_5E89:: ; address name
    ld a, [wTemp0]
    rst $00
    dw PauseMenu_Skills_Case00
    dw PauseMenu_Skills_Case01
    dw PauseMenu_Skills_Case02
    dw PauseMenu_Skills_Case03

; entry 0 of the `rst $00` table in PauseMenu_Skills
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp1
PauseMenu_Skills_Case00::
Jump_003_5E95:: ; address name
    ld a, [wTemp1]
    rst $00
    dw PauseMenu_Skills_Case00_Case00
    dw PauseMenu_Skills_Case00_Case01
    dw PauseMenu_Skills_Case00_BuildScreenBlocks1CAnd0CWithCursorAndStep
    dw PauseMenu_Skills_Case00_ShowADeadMonsterCant
    dw PauseMenu_Skills_Case00_Case04

; entry 0 of the `rst $00` table in PauseMenu_Skills_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wLevelUpGains, wMenuPageCount, wPartyCount
; writes: rRAMG, rRAMB, wMenuRowCount, wMenuPageCount
; points at: wTemp1
PauseMenu_Skills_Case00_Case00::
Jump_003_5EA3:: ; address name
    ld a, [wLevelUpGains]
    or a, a
    call nz, RefreshRecordListAndNameTiles
    ld a, [wMenuPageCount]
    or a, a
    jr z, Jump_003_5EC8
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    call LoadScreenBlocks1CAnd0C
    call ShowRecordSkillPageNames_Bank03
    ld a, $00
    ld [rRAMG], a
    call CopyTileBufferToBGMap

Jump_003_5EC8::
    ld a, [wPartyCount]
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    ld hl, wTemp1
    inc [hl]
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    call PauseMenu_Skills_Shared04
    call PauseMenu_Skills_Shared01
    ld a, $00
    ld [rRAMG], a
    call CopyTileBufferToBGMap
    ret

; entry 1 of the `rst $00` table in PauseMenu_Skills_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wMenuSelectedMember
; writes: wMenuPage, rRAMG, rRAMB, wTemp0, wTemp1, wMenuCursor
; points at: wMenuSelectedMember
PauseMenu_Skills_Case00_Case01::
Jump_003_5EF0:: ; address name
    ld de, MenuCursorPositions_Bank03
    ld hl, wMenuSelectedMember
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, Jump_003_5F23
    xor a, a
    ld [wMenuPage], a
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    call PauseMenu_Skills_Shared04
    call PauseMenu_Skills_Shared01
    call ShowRecordSkillPageNames_Bank03
    call PauseMenu_Skills_Shared05
    ld a, $00
    ld [rRAMG], a
    call CopyTileBufferToBGMap
    ret

Jump_003_5F23::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_5F75
    ld a, $69
    call QueueSoundEffect
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wMenuSelectedMember]
    and a, $03
    ld c, $34
    call SRAMRecordAddressMapped
    ld a, [hl]
    or a, a
    jr z, Jump_003_5F6F
    cp a, $FF
    jr z, Jump_003_5F6F
    ld a, [wMenuSelectedMember]
    ld c, $55
    call SRAMRecordAddressMapped
    bit 7, [hl]
    jr nz, Jump_003_5F6A
    ld a, $01
    ld [wTemp0], a
    xor a, a
    ld [wTemp1], a
    xor a, a
    ld [wMenuPage], a
    xor a, a
    ld [wMenuCursor], a
    jr Jump_003_5F6F

Jump_003_5F6A::
    ld a, $02
    ld [wTemp1], a

Jump_003_5F6F::
    ld a, $00
    ld [rRAMG], a
    ret

Jump_003_5F75::
    bit 1, a
    ret z
    call ExitPauseMenuToField
    ret

; entry 2 of the `rst $00` table in PauseMenu_Skills_Case00
; no direct call (reached through a table, a jump or a vector)
; points at: wTemp1
PauseMenu_Skills_Case00_BuildScreenBlocks1CAnd0CWithCursorAndStep::
Jump_003_5F7C:: ; address name
    call BuildScreenBlocks1CAnd0CWithCursor
    ld hl, vBGMap0 + $1A0
    ld bc, $1405
    ld de, wWindowTileBuffer + $38
    call CopyRectToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

; entry 3 of the `rst $00` table in PauseMenu_Skills_Case00
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wTemp1
PauseMenu_Skills_Case00_ShowADeadMonsterCant::
Jump_003_5F90:: ; address name
    ld a, $01
    ld [wStringCategory], a
    ld a, $1A
    ld [wStringIndex], a ; 'A dead monster can't use a'
    farcall BeginStringDisplay_Bank37
    ld hl, wTemp1
    inc [hl]
    ret

; entry 4 of the `rst $00` table in PauseMenu_Skills_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wTemp1
PauseMenu_Skills_Case00_Case04::
Jump_003_5FA5:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    xor a, a
    ld [wTemp1], a
    ret

; entry 1 of the `rst $00` table in PauseMenu_Skills
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp1
PauseMenu_Skills_Case01::
Jump_003_5FAF:: ; address name
    ld a, [wTemp1]
    rst $00
    dw PauseMenu_Skills_Case01_Case00
    dw PauseMenu_Skills_Case01_Case01
    dw PauseMenu_Skills_Case01_BuildRecordField5FValueScreenWithCursorAndStep
    dw PauseMenu_Skills_Case01_BeginStringDisplay_Bank37AndStep
    dw PauseMenu_Skills_Case01_Case04

; entry 0 of the `rst $00` table in PauseMenu_Skills_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuSelectedMember
; writes: rRAMG, rRAMB, wMenuRowCount
; points at: wTemp1
PauseMenu_Skills_Case01_Case00::
Jump_003_5FBD:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    call BuildRecordField5FValueScreen
    call PauseMenu_Skills_Shared02
    ld a, $00
    ld [rRAMG], a
    call PauseMenu_Skills_Shared01
    call PauseMenu_Skills_Shared05
    call CopyTileBufferToBGMap
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wMenuSelectedMember]
    and a, $03
    ld c, $34
    call SRAMRecordAddressMapped
    ld bc, $0800

Jump_003_5FF2::
    ld a, [hl+]
    or a, a
    jr z, Jump_003_5FFB
    cp a, $FF
    jr z, Jump_003_5FFB
    inc c

Jump_003_5FFB::
    dec b
    jr nz, Jump_003_5FF2
    call PauseMenu_Skills_Case01_Case00_Sub01
    ld [wMenuRowCount], a
    call PauseMenu_Skills_Shared01
    call SetMenuRowsForPage_Bank03
    call ShowRecordSkillPageNames_Bank03
    call PauseMenu_Skills_Shared05
    ld a, $00
    ld [rRAMG], a
    call CopyTileBufferToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_Skills_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wMenuRowCount, wJoypadPressed
; writes: rRAMG, rRAMB, wTemp0, wSubMenuCursor, wTemp1, wStringIndex, wMenuPage
; points at: wMenuCursor, wTemp1
PauseMenu_Skills_Case01_Case01::
Jump_003_601D:: ; address name
    ld de, Data_003_4617
    ld hl, wMenuCursor
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, Jump_003_6052
    ld a, [wMenuRowCount]
    cp a, $01
    ret z
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    call PauseMenu_Skills_Shared02
    ld a, $00
    ld [rRAMG], a
    ld hl, vBGMap0 + $206
    ld bc, $0301
    ld de, wWindowTileBuffer + $9E
    call CopyRectToBGMap
    ret

Jump_003_6052::
    ld hl, wMenuCursor
    bit 7, [hl]
    jr z, Jump_003_6083
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    res 7, [hl]
    call SetMenuRowsForPage_Bank03
    call PauseMenu_Skills_Shared02
    call ShowRecordSkillPageNames_Bank03
    call PauseMenu_Skills_Shared05
    ld hl, vBGMap0 + $206
    ld bc, $0301
    ld de, wWindowTileBuffer + $9E
    call CopyRectToBGMap
    ld a, $00
    ld [rRAMG], a
    ret

Jump_003_6083::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_60B8
    ld a, $69
    call QueueSoundEffect
    call LookupInventorySlotForRecordBuffer
    jr z, Jump_003_60A7
    call PauseMenu_Skills_Case01_Case01_Sub01
    jr nz, Jump_003_60AE
    ld a, $02
    ld [wTemp0], a
    xor a, a
    ld [wSubMenuCursor], a
    xor a, a
    ld [wTemp1], a
    ret

Jump_003_60A7::
    ld a, $1B
    ld [wStringIndex], a
    jr Jump_003_60B3

Jump_003_60AE::
    ld a, $19
    ld [wStringIndex], a

Jump_003_60B3::
    ld hl, wTemp1
    inc [hl]
    ret

Jump_003_60B8::
    bit 1, a
    ret z
    xor a, a
    ld [wTemp0], a
    ld [wTemp1], a
    ld [wMenuPage], a
    ret

; entry 2 of the `rst $00` table in PauseMenu_Skills_Case01
; no direct call (reached through a table, a jump or a vector)
; points at: wTemp1
PauseMenu_Skills_Case01_BuildRecordField5FValueScreenWithCursorAndStep::
Jump_003_60C6:: ; address name
    call BuildRecordField5FValueScreenWithCursor
    call PauseMenu_Skills_Shared01
    call PauseMenu_Skills_Shared05
    call CopyTileBufferToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

; entry 3 of the `rst $00` table in PauseMenu_Skills_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory
; points at: wTemp1
PauseMenu_Skills_Case01_BeginStringDisplay_Bank37AndStep::
Jump_003_60D7:: ; address name
    ld a, $01
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37
    ld hl, wTemp1
    inc [hl]
    ret

; entry 4 of the `rst $00` table in PauseMenu_Skills_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wTemp0, wTemp1, wMenuPage
PauseMenu_Skills_Case01_Case04::
Jump_003_60E7:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    xor a, a
    ld [wTemp0], a
    xor a, a
    ld [wTemp1], a
    xor a, a
    ld [wMenuPage], a
    ret

; entry 2 of the `rst $00` table in PauseMenu_Skills
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp1
PauseMenu_Skills_Case02::
Jump_003_60F9:: ; address name
    ld a, [wTemp1]
    rst $00
    dw PauseMenu_Skills_Case02_Case00
    dw PauseMenu_Skills_Case02_Case01
    dw PauseMenu_Skills_Case02_Case02

; entry 0 of the `rst $00` table in PauseMenu_Skills_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wRecordBufferData
; points at: wTemp0, wTemp1
PauseMenu_Skills_Case02_Case00::
Jump_003_6103:: ; address name
    ld a, [wRecordBufferData + $4]
    cp a, $21
    jr z, Jump_003_611B
    call BuildRecordField5FValueScreenWithCursor
    call PauseMenu_Skills_Shared01
    call PauseMenu_Skills_Shared05
    call CopyTileBufferToBGMap
    ld hl, wTemp0
    inc [hl]
    ret

Jump_003_611B::
    ld hl, wTemp1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_Skills_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount
; writes: rRAMG, rRAMB, wMenuRowCount
; points at: wTemp1
PauseMenu_Skills_Case02_Case01::
Jump_003_6120:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    call PauseMenu_Skills_Case02_Case01_Sub01
    call PauseMenu_Skills_Shared03
    ld a, $00
    ld [rRAMG], a
    call PauseMenu_Skills_Shared01
    call PauseMenu_Skills_Shared05
    call CopyTileBufferToBGMap
    ld a, [wPartyCount]
    ld [wMenuRowCount], a
    ld hl, wTemp1
    inc [hl]
    ret

; entry 2 of the `rst $00` table in PauseMenu_Skills_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wSubMenuCursor, wTargetRecord
; writes: rRAMG, rRAMB, wTargetRecord, wTemp1, wTemp0, wMenuPage
; points at: wSubMenuCursor, wTextBuf1, wTemp0
PauseMenu_Skills_Case02_Case02::
Jump_003_6149:: ; address name
    ld de, MenuCursorPositions_Bank03
    ld hl, wSubMenuCursor
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, Jump_003_6178
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    call PauseMenu_Skills_Shared03
    ld a, $00
    ld [rRAMG], a
    ld hl, vBGMap0 + $141
    ld bc, $0703
    ld de, wScreenTileBuffer + $141
    call CopyRectToBGMap
    ret

Jump_003_6178::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_61BD
    ld a, $69
    call QueueSoundEffect
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wSubMenuCursor]
    and a, $03
    ld [wTargetRecord], a
    call BuildSkillScreenTileBuffer
    call PauseMenu_Skills_Shared03
    call CopyTileBufferToBGMap
    ld a, [wTargetRecord]
    ld c, $01
    call SRAMRecordAddressMapped
    ld e, l
    ld d, h
    ld hl, wTextBuf1
    call CopyFiveGlyphsPlusMarks
    ld a, $00
    ld [rRAMG], a
    ld hl, wTemp0
    inc [hl]
    xor a, a
    ld [wTemp1], a
    ret

Jump_003_61BD::
    bit 1, a
    ret z
    ld a, $01
    ld [wTemp0], a
    xor a, a
    ld [wTemp1], a
    xor a, a
    ld [wMenuPage], a
    ret

; entry 3 of the `rst $00` table in PauseMenu_Skills
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp1
PauseMenu_Skills_Case03::
Jump_003_61CE:: ; address name
    ld a, [wTemp1]
    rst $00
    dw PauseMenu_Skills_Case03_Case00
    dw PauseMenu_Skills_Case03_Case01
    dw PauseMenu_Skills_Case03_Case02
    dw PauseMenu_Skills_Case03_Case03
    dw PauseMenu_Skills_Case03_Case04
    dw PauseMenu_Skills_Case03_Case05
    dw PauseMenu_Skills_Case03_Case06
    dw PauseMenu_Skills_Case03_Case07
    dw PauseMenu_Skills_Case03_Case08
    dw PauseMenu_Skills_Case03_Case09
    dw PauseMenu_Skills_Case03_ShowHeroReturnedWithAn
    dw PauseMenu_Skills_Case03_Case0B

; entry 0 of the `rst $00` table in PauseMenu_Skills_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuSelectedMember, wRecordBuffer
; writes: rRAMG, rRAMB
; points at: wTextBuf0, wTextBuf2, wTemp1
PauseMenu_Skills_Case03_Case00::
Jump_003_61EA:: ; address name
    call PauseMenu_Skills_Shared01
    call PauseMenu_Skills_Shared05
    call CopyTileBufferToBGMap
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wMenuSelectedMember]
    ld c, $01
    call SRAMRecordAddressMapped
    ld e, l
    ld d, h
    ld hl, wTextBuf0
    call CopyFiveGlyphsPlusMarks
    ld a, [wRecordBuffer]
    ld l, a
    ld h, $04
    ld de, wTextBuf2
    call CopyStringHLToDE
    ld a, $00
    ld [rRAMG], a
    ld hl, wTemp1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_Skills_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wInventorySlot
; writes: wStringIndex, wStringCategory
; points at: wTemp1
PauseMenu_Skills_Case03_Case01::
Jump_003_6223:: ; address name
    ld a, [wInventorySlot]
    ld hl, Data_003_6987
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    call nz, QueueSoundEffect
    ld a, [wInventorySlot]
    ld hl, Data_003_69AF
    add_a_to_hl
    ld a, [hl]
    ld [wStringIndex], a
    ld a, $01
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37
    ld hl, wTemp1
    inc [hl]
    ret

; entry 2 of the `rst $00` table in PauseMenu_Skills_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wSubMenuCursor, wItemId
; writes: wTargetRecord, rRAMG, rRAMB
; points at: wTemp1
PauseMenu_Skills_Case03_Case02::
Jump_003_6253:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wSubMenuCursor]
    ld [wTargetRecord], a
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    farcall PauseMenu_Skills_Case03_Case02_Sub01
    ld a, $00
    ld [rRAMG], a
    ld hl, wTemp1
    inc [hl]
    ld a, [wItemId]
    cp a, $FF
    ret z
    ld hl, wTemp1
    inc [hl]
    ld hl, wTemp1
    inc [hl]
    ret

; entry 3 of the `rst $00` table in PauseMenu_Skills_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wItemMessage
; writes: wStringIndex, wStringCategory
; points at: wTemp1
PauseMenu_Skills_Case03_Case03::
Jump_003_6286:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wItemMessage]
    ld [wStringIndex], a
    ld a, $01
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37
    ld hl, wTemp1
    inc [hl]
    ret

; entry 4 of the `rst $00` table in PauseMenu_Skills_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wTemp0, wTemp1, wMenuPage
PauseMenu_Skills_Case03_Case04::
Jump_003_62A1:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    xor a, a
    ld [wTemp0], a
    ld [wTemp1], a
    xor a, a
    ld [wMenuPage], a
    ret

; entry 5 of the `rst $00` table in PauseMenu_Skills_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wRecordBufferData, wMenuSelectedMember, wItemId, wRandomLo
; writes: rRAMG, rRAMB, wItemEffectAmount, wItemEffectRange, wItemMessage, wTemp1
; points at: wTemp1
PauseMenu_Skills_Case03_Case05::
Jump_003_62B2:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wRecordBufferData]
    cp a, $FF
    jr nz, Jump_003_62D8
    ld a, [wMenuSelectedMember]
    ld c, $5F
    call SRAMRecordAddressMapped
    deref_hl
    ld a, l
    ld [wItemEffectAmount], a
    ld a, h
    ld [wItemEffectRange], a
    jr Jump_003_62DB

Jump_003_62D8::
    ld l, a
    ld h, $00

Jump_003_62DB::
    push hl
    ld a, [wMenuSelectedMember]
    ld c, $5F
    call SRAMRecordAddressMapped
    pop bc
    ld a, [hl]
    sub a, c
    ld [hl+], a
    ld a, [hl]
    sbc a, b
    ld [hl], a
    ld hl, wTemp1
    inc [hl]
    ld a, $00
    ld [rRAMG], a
    ld a, [wItemId]
    cp a, $1E
    ret nz
    call NextTableByte
    ld a, [wRandomLo]
    bit 7, a
    ret z
    ld a, $13
    ld [wItemMessage], a
    ld a, $03
    ld [wTemp1], a
    ret

; entry 6 of the `rst $00` table in PauseMenu_Skills_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wInventorySlot
; points at: wTemp1
PauseMenu_Skills_Case03_Case06::
Jump_003_630E:: ; address name
    ld a, [wInventorySlot]
    ld hl, Data_003_699B
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    call nz, QueueSoundEffect
    ld hl, wTemp1
    inc [hl]
    ret

; entry 7 of the `rst $00` table in PauseMenu_Skills_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wItemId, wItemMessage
; writes: rRAMG, rRAMB, wStringCategory, wStringIndex
; points at: wTemp1
PauseMenu_Skills_Case03_Case07::
Jump_003_6324:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    farcall PauseMenu_Skills_Case03_Case07_Sub01
    ld a, $00
    ld [rRAMG], a
    ld a, [wItemId]
    cp a, $19
    jr z, Jump_003_634F
    cp a, $1A
    jr z, Jump_003_634F
    cp a, $24
    jr z, Jump_003_634F
    ld a, $01
    ld [wStringCategory], a
    jr Jump_003_6354

Jump_003_634F::
    ld a, $00
    ld [wStringCategory], a

Jump_003_6354::
    ld a, [wItemMessage]
    ld [wStringIndex], a
    cp a, $FF
    jr z, Jump_003_6364
    farcall BeginStringDisplay_Bank37

Jump_003_6364::
    ld hl, wTemp1
    inc [hl]
    ret

; entry 8 of the `rst $00` table in PauseMenu_Skills_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wInventorySlot
; points at: wTemp1
PauseMenu_Skills_Case03_Case08::
Jump_003_6369:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld hl, wTemp1
    inc [hl]
    ld a, [wInventorySlot]
    cp a, $10
    ret z
    ld hl, wTemp1
    inc [hl]
    ld a, [wInventorySlot]
    cp a, $11
    ret z
    ld hl, wTemp1
    inc [hl]
    ret

; entry 9 of the `rst $00` table in PauseMenu_Skills_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wItemId, wWorkBuf
; writes: wStringCategory, wStringIndex, wItemId, wTemp1
; points at: wTextBuf3
PauseMenu_Skills_Case03_Case09::
Jump_003_6387:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wItemId]
    cp a, $FF
    jr z, Jump_003_63CA
    ld a, [wWorkBuf + $1]
    ld hl, wWorkBuf + $2
    add a, a
    add_a_to_hl
    deref_hl
    ld a, h
    add a, $02
    ld h, a
    ld de, wTextBuf3
    call CopyStringHLToDE
    ld a, $01
    ld [wStringCategory], a
    ld a, $0C
    ld [wStringIndex], a ; '0 There are m around.'
    farcall BeginStringDisplay_Bank37
    ld hl, wWorkBuf + $1
    ld a, [hl]
    inc a
    ld [hl-], a
    cp a, [hl]
    ret c
    ld a, $FF
    ld [wItemId], a
    ret

Jump_003_63CA::
    ld a, $0B
    ld [wTemp1], a
    ret

; entry 10 of the `rst $00` table in PauseMenu_Skills_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wItemId
; writes: wStringIndex, wStringCategory, wTemp1
PauseMenu_Skills_Case03_ShowHeroReturnedWithAn::
Jump_003_63D0:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, [wItemId]
    cp a, $FF
    jr z, Jump_003_63E3
    ld a, $0F
    ld [wStringIndex], a ; '0 returned with an item. obtained'
    jr Jump_003_63E8

Jump_003_63E3::
    ld a, $10
    ld [wStringIndex], a ; '0 came back with nothing'

Jump_003_63E8::
    ld a, $01
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37
    ld a, $0B
    ld [wTemp1], a
    ret

; entry 11 of the `rst $00` table in PauseMenu_Skills_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wDataBankSave, wItemId
; writes: wTemp0, wTemp1, wMenuPage, wMenuCursor
PauseMenu_Skills_Case03_Case0B::
Jump_003_63F9:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    xor a, a
    ld [wTemp0], a
    ld [wTemp1], a
    ld a, [wDataBankSave]
    or a, a
    jr z, Jump_003_640F
    call ExitPauseMenuToField
    ret

Jump_003_640F::
    ld a, [wItemId]
    cp a, $FF
    ret z
    xor a, a
    ld [wMenuPage], a
    xor a, a
    ld [wMenuCursor], a
    ret

; clears the screen tile buffer and copies blocks $1C and $0C into it (CopyBlockToTileBuffer) (E-0101)
; 4 call sites from 4 routines (e.g. PauseMenu_State4_Sub01_LoadScreenBlocks1CAnd0C, BuildScreenBlocks1CAnd0CWithCursor, PauseMenu_Skills_Case00_Case00, BuildRecordField5FValueScreen)
LoadScreenBlocks1CAnd0C::
Func_003_641E:: ; address name
    call ClearScreenTileBuffer_Bank03
    ld e, $1C
    farcall CopyBlockToTileBuffer
    ld e, $0C
    farcall CopyBlockToTileBuffer
    ret

; only called from routines of PauseMenu_Skills (E-0098)
; 8 call sites from 7 routines (e.g. PauseMenu_Skills_Case00_Case01, PauseMenu_Skills_Case00_Case00, PauseMenu_Skills_Case01_BuildRecordField5FValueScreenWithCursorAndStep, PauseMenu_Skills_Case01_Case00, ...)
; reads: wMenuSelectedMember, wMenuItemCount, wMenuPage
PauseMenu_Skills_Shared01::
Func_003_6432:: ; address name
    ld a, [wMenuSelectedMember]
    and a, $03
    ld c, $34
    call SRAMRecordAddressMapped
    ld d, h
    ld e, l
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_003_6450

Jump_003_6443::
    ld de, TileRect_03_6A98
    ld bc, $0501
    ld hl, wScreenTileBuffer + $10E
    call CopyRectToBGMap
    ret

Jump_003_6450::
    ld a, [wMenuItemCount]
    cp a, $01
    jr z, Jump_003_6443
    ld hl, wScreenTileBuffer + $10E
    ld a, $C5
    ld [hl+], a
    ld a, [wMenuPage]
    add a, $E1
    ld [hl+], a
    ld a, $BE
    ld [hl+], a
    ld a, [wMenuItemCount]
    add a, $E0
    ld [hl+], a
    ld [hl], $C6
    ret

; loads blocks $1C, $0C and $1D, writes field $5F of record wC46D & 3 as decimal digits at wC3A2 and draws the cursor for wC46D & 3 (E-0122)
; 2 call sites from 2 routines (e.g. BuildRecordField5FValueScreenWithCursor, PauseMenu_Skills_Case01_Case00)
; reads: wMenuSelectedMember
BuildRecordField5FValueScreen::
Func_003_646F:: ; address name
    call LoadScreenBlocks1CAnd0C
    ld e, $1D
    farcall CopyBlockToTileBuffer
    ld a, [wMenuSelectedMember]
    and a, $03
    ld c, $5F
    call SRAMRecordAddressMapped
    deref_hl
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $A2
    call WriteDecimalDigitTiles
    ld a, [wMenuSelectedMember]
    and a, $03
    ld hl, MenuCursorPositions_Bank03
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ret

; only called from PauseMenu_Skills_Case02_Case01 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Case02_Case01)
; reads: wMenuSelectedMember, wRecordBufferData, wMenuCursor, wRecordBuffer
PauseMenu_Skills_Case02_Case01_Sub01::
Func_003_649C:: ; address name
    call ClearScreenTileBuffer_Bank03
    ld e, $20
    farcall CopyBlockToTileBuffer
    ld e, $0C
    farcall CopyBlockToTileBuffer
    ld e, $1D
    farcall CopyBlockToTileBuffer
    ld a, [wMenuSelectedMember]
    and a, $03
    ld c, $5F
    call SRAMRecordAddressMapped
    deref_hl
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $A2
    call WriteDecimalDigitTiles
    ld a, [wRecordBufferData]
    cp a, $FF
    jr z, Jump_003_64DA
    ld l, a
    ld h, $00
    call HLToDecimalDigits

Jump_003_64DA::
    ld de, wWindowTileBuffer + $9E
    call WriteDecimalDigitTiles
    ld a, [wMenuCursor]
    and a, $07
    ld hl, Data_003_4617
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ld a, [wRecordBuffer]
    ld l, a
    ld a, [wRecordBuffer + $1]
    ld h, a
    ld a, l
    add a, $51
    ld l, a
    ld a, h
    adc a, $68
    ld h, a
    ld a, [hl]
    ld hl, TileRectTable_03_6921
    add a, a
    add_a_to_hl
    deref_hl
    call CopyRecordRectToScreenBuffer_Bank03
    ret

; fills tiles, builds the field-$5F screen, draws the cursor for wC46E & 7 and copies block $10 (E-0122)
; 2 call sites from 2 routines (e.g. PauseMenu_Skills_Case01_BuildRecordField5FValueScreenWithCursorAndStep, PauseMenu_Skills_Case02_Case00)
; reads: wMenuCursor
BuildRecordField5FValueScreenWithCursor::
Func_003_650C:: ; address name
    call FillTilesFromRequest
    call BuildRecordField5FValueScreen
    ld a, [wMenuCursor]
    and a, $07
    ld hl, Data_003_4617
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ld e, $10
    farcall CopyBlockToTileBuffer
    ret

; fills the screen tile buffer: blocks $20 and $0C, cursor marks for wC46E and wC46F, the rectangle chosen by the skill wRecordBuffer (table $6851 to Data_003_6921), then block $10 (E-0121)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Case02_Case02)
; reads: wMenuCursor, wSubMenuCursor, wRecordBuffer
BuildSkillScreenTileBuffer::
Func_003_6526:: ; address name
    call FillTilesFromRequest
    call ClearScreenTileBuffer_Bank03
    ld e, $20
    farcall CopyBlockToTileBuffer
    ld e, $0C
    farcall CopyBlockToTileBuffer
    ld a, [wMenuCursor]
    and a, $07
    ld hl, Data_003_4617
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ld a, [wSubMenuCursor]
    and a, $03
    ld hl, MenuCursorPositions_Bank03
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ld a, [wRecordBuffer]
    ld l, a
    ld a, [wRecordBuffer + $1]
    ld h, a
    ld a, l
    add a, $51
    ld l, a
    ld a, h
    adc a, $68
    ld h, a
    ld a, [hl]
    ld hl, TileRectTable_03_6921
    add a, a
    add_a_to_hl
    deref_hl
    call CopyRecordRectToScreenBuffer_Bank03
    ld e, $10
    farcall CopyBlockToTileBuffer
    ret

; fills tiles, loads blocks $1C and $0C, draws the cursor for wC46D & 3 and copies block $10 (E-0122)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Case00_BuildScreenBlocks1CAnd0CWithCursorAndStep)
; reads: wMenuSelectedMember
BuildScreenBlocks1CAnd0CWithCursor::
Func_003_657B:: ; address name
    call FillTilesFromRequest
    call LoadScreenBlocks1CAnd0C
    ld a, [wMenuSelectedMember]
    and a, $03
    ld hl, MenuCursorPositions_Bank03
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ld e, $10
    farcall CopyBlockToTileBuffer
    ret

; shows string 1 of category 0 (ShowString_Bank09) at vTiles1 + $6E0 with size $0107, preserving the window, then Func_003_67B0 (E-0121)
; 1 call site from 1 routine (e.g. PauseMenu_State4_Sub01_LoadScreenBlocks1CAnd0C)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex
ShowString1Bank09AtTiles16E0ThenDetails::
Func_003_6595:: ; address name
    ld a, [wTextWindowTileLo]
    ld l, a
    ld a, [wTextWindowTileHi]
    ld h, a
    push hl
    ld a, [wTextWindowRows]
    ld l, a
    ld a, [wTextWindowWidth]
    ld h, a
    push hl
    ld hl, vTiles1 + $6E0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0701
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $00
    ld [wStringCategory], a
    ld a, $01
    ld [wStringIndex], a ; 'TOWHOHPMP'
    farcall ShowString_Bank09
    pop hl
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    call ShowRecordSkillPageNames_Bank03
    ret

; only called from routines of PauseMenu_Skills (E-0098)
; 3 call sites from 2 routines (e.g. PauseMenu_Skills_Case01_Case01, PauseMenu_Skills_Case01_Case00)
; reads: wMenuSelectedMember, wMenuCursor, wMenuPage, wRecordBufferData
; writes: wStringIndex, wRecordBuffer, wItemId, wStringCategory
PauseMenu_Skills_Shared02::
Func_003_65E3:: ; address name
    ld a, [wMenuSelectedMember]
    and a, $03
    ld c, $34
    call SRAMRecordAddressMapped
    ld a, [wMenuCursor]
    and a, $07
    ld c, a
    ld a, [wMenuPage]
    and a, $0F
    add a, a
    add a, a
    add a, c
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_003_6606
    xor a, a

Jump_003_6606::
    ld [wStringIndex], a
    ld [wRecordBuffer], a
    ld [wItemId], a
    xor a, a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    ld a, [wRecordBufferData]
    cp a, $FF
    jr z, Jump_003_6625
    ld l, a
    ld h, $00
    jr Jump_003_6632

Jump_003_6625::
    ld a, [wMenuSelectedMember]
    and a, $03
    ld c, $5F
    call SRAMRecordAddressMapped
    deref_hl

Jump_003_6632::
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $9E
    call WriteDecimalDigitTiles
    ld a, $09
    ld [wStringCategory], a
    ld hl, vTiles2 + $230
    ld de, $1203
    call ShowStringBank08AtTilesHL_Bank03
    ret

; only called from routines of PauseMenu_Skills (E-0098)
; 3 call sites from 2 routines (e.g. PauseMenu_Skills_Case02_Case02, PauseMenu_Skills_Case02_Case01)
; reads: wRecordBuffer, wSubMenuCursor
; writes: wScreenTileBuffer
PauseMenu_Skills_Shared03::
Func_003_664A:: ; address name
    ld a, [wRecordBuffer]
    ld l, a
    ld a, [wRecordBuffer + $1]
    ld h, a
    ld a, l
    add a, $51
    ld l, a
    ld a, h
    adc a, $68
    ld h, a
    ld a, [hl]
    or a, a
    jr nz, Jump_003_6662
    ld c, $5B
    jr Jump_003_6664

Jump_003_6662::
    ld c, $5F

Jump_003_6664::
    ld a, [wSubMenuCursor]
    and a, $03
    call SRAMRecordAddressMapped
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $19
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    deref_hl
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $1D
    call WriteDecimalDigitTiles
    ld a, [wSubMenuCursor]
    and a, $03
    ld c, $55
    call SRAMRecordAddressMapped
    ld a, $C3
    ld [wScreenTileBuffer + $146], a
    ld [wScreenTileBuffer + $147], a
    bit 7, [hl]
    call nz, SetWC2DFTileC2_Bank03
    bit 2, [hl]
    call nz, SetWC2DFTileC1_Bank03
    bit 0, [hl]
    call nz, SetWC2DETileC0_Bank03
    ret

; wC2DF = $C2 (E-0114) (the same 6 bytes appear in 3 banks)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Shared03)
; writes: wScreenTileBuffer
SetWC2DFTileC2_Bank03::
Func_003_66A9:: ; address name
    ld a, $C2
    ld [wScreenTileBuffer + $147], a
    ret

; wC2DF = $C1 (E-0114) (the same 6 bytes appear in 3 banks)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Shared03)
; writes: wScreenTileBuffer
SetWC2DFTileC1_Bank03::
Func_003_66AF:: ; address name
    ld a, $C1
    ld [wScreenTileBuffer + $147], a
    ret

; wC2DE = $C0 (E-0114) (the same 6 bytes appear in 3 banks)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Shared03)
; writes: wScreenTileBuffer
SetWC2DETileC0_Bank03::
Func_003_66B5:: ; address name
    ld a, $C0
    ld [wScreenTileBuffer + $146], a
    ret

; only called from PauseMenu_Skills_Case01_Case01 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Case01_Case01)
; reads: wMenuSelectedMember, wRecordBufferData
; writes: rRAMG, rRAMB
PauseMenu_Skills_Case01_Case01_Sub01::
Func_003_66BB:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wMenuSelectedMember]
    and a, $03
    ld c, $5F
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, $00
    ld [rRAMG], a
    ld a, [wRecordBufferData]
    cp a, $FF
    jr nz, Jump_003_66E2
    ld h, d
    ld l, e
    jr Jump_003_66E5

Jump_003_66E2::
    ld l, a
    ld h, $00

Jump_003_66E5::
    ld a, e
    sub a, l
    ld e, a
    ld a, d
    sbc a, h
    ld d, a
    bit 7, d
    ret

; wD082 = Data_003_6700[wRecordBuffer]; Z set when it is $FF (E-0119)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Case01_Case01)
; reads: wRecordBuffer
; writes: wInventorySlot
LookupInventorySlotForRecordBuffer::
Func_003_66EE:: ; address name
    ld a, [wRecordBuffer]
    ld hl, Data_003_6700
    add_a_to_hl
    ld a, [hl]
    ld [wInventorySlot], a
    cp a, $FF
    ret

; address loaded by LookupInventorySlotForRecordBuffer
Data_003_6700:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $16, $FF
    db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $FF, $0A, $FF, $FF, $0B
    ds $7D, $FF
    db $0C, $0D, $0E, $0F, $10, $11, $12, $13, $FF, $FF, $FF, $FF, $FF, $FF

; shows four skill names of record wC46D & 3 for page wMenuPage (or string $0E when it has none) at vTiles2 + $5C0 onward, preserving the window (E-0129)
; 5 call sites from 5 routines (e.g. ShowString1Bank09AtTiles16E0ThenDetails, PauseMenu_Skills_Case00_Case01, PauseMenu_Skills_Case00_Case00, PauseMenu_Skills_Case01_Case01, ...)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wMenuSelectedMember, wMenuPage
; writes: wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi
ShowRecordSkillPageNames_Bank03::
Func_003_67B0:: ; address name
    ld a, [wTextWindowTileLo]
    ld l, a
    ld a, [wTextWindowTileHi]
    ld h, a
    push hl
    ld a, [wTextWindowRows]
    ld l, a
    ld a, [wTextWindowWidth]
    ld h, a
    push hl
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, [wMenuSelectedMember]
    and a, $03
    ld c, $34
    call SRAMRecordAddressMapped
    ld d, h
    ld e, l
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_003_6803
    ld a, $08
    ld [wStringCategory], a
    ld a, $0E
    ld [wStringIndex], a
    ld hl, vTiles2 + $5C0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    push de
    farcall ShowString_Bank08
    pop de
    inc de
    ld hl, vTiles2 + $650
    ld b, $03
    jr Jump_003_6814

Jump_003_6803::
    ld a, [wMenuPage]
    and a, $0F
    add a, a
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_003_680F
    inc d

Jump_003_680F::
    ld b, $04
    ld hl, vTiles2 + $5C0

Jump_003_6814::
    ld a, $04
    ld [wStringCategory], a

Jump_003_6819::
    ld a, [de]
    cp a, $FF
    jr nz, Jump_003_681F
    xor a, a

Jump_003_681F::
    inc de
    ld [wStringIndex], a
    push bc
    push de
    push hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    farcall ShowString_Bank08
    pop hl
    ld de, $0090
    add hl, de
    pop de
    pop bc
    dec b
    jr nz, Jump_003_6819
    pop hl
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ret
    ds $1B, $00
    db $01, $01, $01
    ds $B2, $00

; E-0221 (derived: a word table of tile-rectangle records; the code derefs one entry into HL for a record copier)
; record: rectangle record
TileRectTable_03_6921::
Data_003_6921:: ; address name
    dw TileRect_03_6925 ; id 0
    dw TileRect_03_6956 ; id 1

; E-0161 (derived: a tile-rectangle record for CopyRecordRectToScreenBuffer)
; record: offset $0120 (row 9, column 0); 9 x 5 tiles
TileRect_03_6925::
Data_003_6925:: ; address name
    dw $0120 ; entry 0: offset into wScreenTileBuffer
    db $09, $05 ; width, rows
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; row 0
    db $B6, $F3, $F4, $ED, $C3, $C3, $C3, $C3, $B7 ; row 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 2
    db $B6, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $B7 ; row 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; row 4

; E-0161 (derived: a tile-rectangle record for CopyRecordRectToScreenBuffer)
; record: offset $0120 (row 9, column 0); 9 x 5 tiles
TileRect_03_6956::
Data_003_6956:: ; address name
    dw $0120 ; entry 0: offset into wScreenTileBuffer
    db $09, $05 ; width, rows
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; row 0
    db $B6, $F5, $F6, $ED, $C3, $C3, $C3, $C3, $B7 ; row 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; row 2
    db $B6, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $B7 ; row 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; row 4

; address loaded by PauseMenu_Skills_Case03_Case01
Data_003_6987:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $7A, $7A, $7A, $7A, $7A, $7A, $7A, $7A, $7A, $7A, $7A, $7A, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF

; address loaded by PauseMenu_Skills_Case03_Case06
Data_003_699B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $85, $85, $85, $85, $85, $85, $85, $85, $85, $85, $85, $85, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF

; address loaded by PauseMenu_Skills_Case03_Case01
Data_003_69AF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $02, $00, $00
    db $03, $04, $05, $00

; only called from routines of PauseMenu_Skills (E-0098)
; 2 call sites from 2 routines (e.g. PauseMenu_Skills_Case00_Case01, PauseMenu_Skills_Case00_Case00)
; reads: wMenuSelectedMember
; writes: wMenuPageCount, wMenuItemCount, wMenuLastPageRows
PauseMenu_Skills_Shared04::
Func_003_69C3:: ; address name
    ld a, [wMenuSelectedMember]
    and a, $03
    ld c, $34
    call SRAMRecordAddressMapped
    ld c, $00

Jump_003_69CF::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_003_69D7
    inc c
    jr Jump_003_69CF

Jump_003_69D7::
    ld a, c
    cp a, $00
    jr z, Jump_003_69E6
    cp a, $05
    jr c, Jump_003_69E4
    ld a, $02
    jr Jump_003_69E6

Jump_003_69E4::
    ld a, $01

Jump_003_69E6::
    ld b, a
    ld [wMenuPageCount], a
    ld [wMenuItemCount], a
    ld a, c
    cp a, $09
    jr c, Jump_003_69F4
    ld a, $04

Jump_003_69F4::
    and a, $03
    or a, a
    jr nz, Jump_003_69FB
    ld a, $04

Jump_003_69FB::
    ld [wMenuLastPageRows], a
    ret

; only called from PauseMenu_Skills_Case01_Case00 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Case01_Case00)
; reads: wMenuPage, wMenuLastPageRows
; writes: wMenuPageCount, wMenuItemCount, wMenuLastPageRows
PauseMenu_Skills_Case01_Case00_Sub01::
Func_003_69FF:: ; address name
    ld a, c
    cp a, $00
    jr z, Jump_003_6A0E
    cp a, $05
    jr c, Jump_003_6A0C
    ld a, $02
    jr Jump_003_6A0E

Jump_003_6A0C::
    ld a, $01

Jump_003_6A0E::
    ld b, a
    ld [wMenuPageCount], a
    ld [wMenuItemCount], a
    ld a, c
    cp a, $09
    jr c, Jump_003_6A1C
    ld a, $04

Jump_003_6A1C::
    and a, $03
    or a, a
    jr nz, Jump_003_6A23
    ld a, $04

Jump_003_6A23::
    ld [wMenuLastPageRows], a
    ld a, [wMenuPage]
    cp a, b
    jr nz, Jump_003_6A31
    ld a, [wMenuLastPageRows]
    jr Jump_003_6A33

Jump_003_6A31::
    ld a, $04

Jump_003_6A33::
    ret

; when wMenuPage & $0F = wC0A7 - 1 (the last page): wMenuRowCount = wMenuLastPageRows and the cursor row wC46E is clamped below it; otherwise wMenuRowCount = 4; then clears bit 7 of wMenuPage (E-0064) (the same 44 bytes appear in 3 banks)
; 2 call sites from 2 routines (e.g. PauseMenu_Skills_Case01_Case01, PauseMenu_Skills_Case01_Case00)
; reads: wMenuItemCount, wMenuPage, wMenuLastPageRows, wMenuCursor
; writes: wMenuRowCount, wMenuCursor
; points at: wMenuPage
SetMenuRowsForPage_Bank03::
Func_003_6A34:: ; address name
    ld a, [wMenuItemCount]
    dec a
    ld c, a
    ld a, [wMenuPage]
    and a, $0F
    cp a, c
    jr nz, Jump_003_6A55
    ld a, [wMenuLastPageRows]
    ld [wMenuRowCount], a
    ld c, a
    ld a, [wMenuCursor]
    cp a, c
    jr c, Jump_003_6A5A
    dec c
    ld a, c
    ld [wMenuCursor], a
    jr Jump_003_6A5A

Jump_003_6A55::
    ld a, $04
    ld [wMenuRowCount], a

Jump_003_6A5A::
    ld hl, wMenuPage
    res 7, [hl]
    ret

; only called from routines of PauseMenu_Skills (E-0098)
; 8 call sites from 7 routines (e.g. PauseMenu_Skills_Case00_Case01, PauseMenu_Skills_Case01_BuildRecordField5FValueScreenWithCursorAndStep, PauseMenu_Skills_Case01_Case01, PauseMenu_Skills_Case01_Case00, ...)
; reads: wMenuSelectedMember, wMenuItemCount, wMenuPageCount, wMenuPage
PauseMenu_Skills_Shared05::
Func_003_6A60:: ; address name
    ld a, [wMenuSelectedMember]
    and a, $03
    ld c, $34
    call SRAMRecordAddressMapped
    ld d, h
    ld e, l
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_003_6A7E

Jump_003_6A71::
    ld de, TileRect_03_6A98
    ld bc, $0501
    ld hl, wScreenTileBuffer + $10E
    call CopyRectToBGMap
    ret

Jump_003_6A7E::
    ld a, [wMenuItemCount]
    cp a, $01
    jr z, Jump_003_6A71
    ld a, [wMenuPageCount]
    or a, a
    ret z
    ld a, [wMenuPage]
    and a, $0F
    add a, $E1
    ld hl, vBGMap0 + $10F
    call WriteVRAMByte
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 5 x 1 tiles, one row per line
TileRect_03_6A98::
Data_003_6A98:: ; address name
    db $B4, $B4, $B4, $B4, $B4 ; id 0

; GameMode2_Update, wModeState 3: an item list screen (state 3) (E-0046)
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp0
PauseMenu_State3::
Jump_003_6A9D:: ; address name
    ld a, [wTemp0]
    rst $00
    dw PauseMenu_State3_Case00
    dw PauseMenu_State3_Case01
    dw PauseMenu_State3_Case02
    dw PauseMenu_State3_Case03
    dw PauseMenu_State3_Case04
    dw PauseMenu_State3_Case05
    dw PauseMenu_State3_Case06

; entry 0 of the `rst $00` table in PauseMenu_State3
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp1
PauseMenu_State3_Case00::
Jump_003_6AAF:: ; address name
    ld a, [wTemp1]
    rst $00
    dw PauseMenu_State3_Case00_Case00
    dw PauseMenu_State3_Case00_Case01
    dw PauseMenu_State3_Case00_Case02
    dw PauseMenu_State3_Case00_Case03

; entry 0 of the `rst $00` table in PauseMenu_State3_Case00
; no direct call (reached through a table, a jump or a vector)
; writes: wMenuRowCount, wMenuPageCount
; points at: wTemp1
PauseMenu_State3_Case00_Case00::
Jump_003_6ABB:: ; address name
    call LoadScreenBlock21
    call CopyTileBufferToBGMap
    call LoadRecordListNameTiles
    farcall LoadTilesForPartyRecords
    ld a, $06
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    ld hl, wTemp1
    inc [hl]
    call FillTiles21E0PreservingWindow
    ret

; entry 1 of the `rst $00` table in PauseMenu_State3_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuSelectedMember
; writes: wTemp0, wTemp1, wMenuPage, wMenuCursor
; points at: wMenuSelectedMember, wTemp1
PauseMenu_State3_Case00_Case01::
Jump_003_6ADC:: ; address name
    ld hl, wMenuSelectedMember
    ld de, MenuCursorPositions_Bank03
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_6B2C
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuSelectedMember]
    and a, $07
    ld hl, MenuCursorPositions_Bank03
    call WriteBCTileAtWordTableEntry_Bank03
    ld a, [wMenuSelectedMember]
    and a, $07
    inc a
    ld [wTemp0], a
    cp a, $06
    jr nz, Jump_003_6B1F
    call Bank16Func4645ResultTest
    jr z, Jump_003_6B1F
    ld e, $10
    farcall CopyBlockToTileBuffer
    xor a, a
    ld [wTemp0], a
    ld hl, wTemp1
    inc [hl]
    ret

Jump_003_6B1F::
    xor a, a
    ld [wTemp1], a
    xor a, a
    ld [wMenuPage], a
    xor a, a
    ld [wMenuCursor], a
    ret

Jump_003_6B2C::
    bit 1, a
    ret z
    call ExitPauseMenuToField
    ret

; entry 2 of the `rst $00` table in PauseMenu_State3_Case00
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wTemp1
PauseMenu_State3_Case00_Case02::
Jump_003_6B33:: ; address name
    ld hl, vBGMap0 + $1A0
    ld de, wWindowTileBuffer + $38
    ld bc, $1405
    call CopyRectToBGMap
    ld a, $08
    ld [wStringCategory], a
    ld a, $0D
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    ld hl, wTemp1
    inc [hl]
    ret

; entry 3 of the `rst $00` table in PauseMenu_State3_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wTemp1
PauseMenu_State3_Case00_Case03::
Jump_003_6B54:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    xor a, a
    ld [wTemp1], a
    ret

; far-calls Func_016_4645 and sets Z from its result C (E-0122)
; 1 call site from 1 routine (e.g. PauseMenu_State3_Case00_Case01)
Bank16Func4645ResultTest::
Func_003_6B5E:: ; address name
    farcall Bank16Func4645ResultTest_Sub01
    ld a, c
    or a, a
    ret

; entry 1 of the `rst $00` table in PauseMenu_State3
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp1
PauseMenu_State3_Case01::
Jump_003_6B67:: ; address name
    ld a, [wTemp1]
    rst $00
    dw PauseMenu_State3_Case01_Case00
    dw PauseMenu_State3_Case01_Case01
    dw PauseMenu_State3_Case01_Case02
    dw PauseMenu_State3_Case01_Case03
    dw PauseMenu_State3_Case01_ToPauseMenu_State3_Shared04AndStep
    dw PauseMenu_State3_Case01_Case05
    dw PauseMenu_State3_Case01_Case06
    dw PauseMenu_State3_Case01_ToPauseMenu_State3_Shared04AndStep_Case07
    dw PauseMenu_State3_Case01_BeginStringDisplay_Bank08AndStep
    dw PauseMenu_State3_Case01_Case09
    dw PauseMenu_State3_Case01_PauseMenu_State3_Shared04AndStep
    dw PauseMenu_State3_Case01_BeginStringDisplay_Bank08AndStep_Case0B
    dw PauseMenu_State3_Case01_Case0C
    dw PauseMenu_State3_Case01_Case0D
    dw PauseMenu_State3_Case01_Case0E
    dw PauseMenu_State3_Case01_BeginStringDisplay_Bank08AndStep_Case0F
    dw PauseMenu_State3_Case01_Case10

; entry 0 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; points at: wTextWindowTileLo, wTemp1
PauseMenu_State3_Case01_Case00::
Jump_003_6B8D:: ; address name
    ld hl, vTiles2 + $710
    ld de, Tiles2Plus710Tiles_1F_4910
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $720
    ld de, Tiles2Plus710Tiles_1F_4910
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $730
    ld de, Tiles2Plus710Tiles_1F_4910
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    call BuildScreenBlocks21To23
    ld hl, wTextWindowTileLo
    ld a, $50
    ld [hl+], a
    ld a, $93
    ld [hl+], a
    ld a, $05
    ld [hl+], a
    ld a, $0C
    ld [hl+], a
    call FillTilesFromRequest
    call CopyTileBufferToBGMap
    call PauseMenu_State3_Shared06
    call PauseMenu_State3_Shared07
    ld hl, wTemp1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wPauseListCount, wJoypadPressed, wGameFlags836, wJoypadPressedRepeat, wMenuPageCount, wWindowTileBuffer, wMenuCursor, wModeState
; writes: wGameFlags836, wTemp1, wTemp0, wDataBankSave
; points at: wMenuCursor, wTemp1
PauseMenu_State3_Case01_Case01::
Jump_003_6BD7:: ; address name
    ld a, [wPauseListCount]
    or a, a
    jr z, Jump_003_6C52
    ld hl, wMenuCursor
    ld de, Data_003_462B
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    and a, $04
    jr z, Jump_003_6C05
    ld a, $69
    call QueueSoundEffect
    ld a, [wGameFlags836]
    bit 7, a
    jr nz, Jump_003_6BFB
    xor a, $02

Jump_003_6BFB::
    res 7, a
    ld [wGameFlags836], a
    xor a, a
    ld [wTemp1], a
    ret

Jump_003_6C05::
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, Jump_003_6C10
    call PauseMenu_State3_Shared07
    ret

Jump_003_6C10::
    ld a, [wJoypadPressedRepeat]
    and a, $30
    jr z, Jump_003_6C36
    ld a, [wMenuPageCount]
    cp a, $02
    ret c
    call PauseMenu_State3_Shared06
    call PauseMenu_State3_Shared07
    ld a, [wMenuPageCount]
    cp a, $02
    ret c
    call ComputeMenuPagesForPauseListCountItems
    ld hl, vBGMap0 + $22F
    ld a, [wWindowTileBuffer + $C7]
    call WriteVRAMByte
    ret

Jump_003_6C36::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_6C52
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuCursor]
    and a, $07
    ld hl, Data_003_462B
    call WriteBCTileAtWordTableEntry_Bank03
    ld hl, wTemp1
    inc [hl]
    ret

Jump_003_6C52::
    ld a, [wJoypadPressed]
    bit 1, a
    ret z
    xor a, a
    ld [wTemp0], a
    ld [wTemp1], a
    ld a, [wModeState]
    bit 3, a
    ret z
    ld a, $40
    ld [wDataBankSave], a
    call ExitPauseMenuToField
    ret

; entry 2 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wMenuRowCount, wMenuPageCount, wSubMenuCursor
; points at: wScreenTileBuffer, wTemp1
PauseMenu_State3_Case01_Case02::
Jump_003_6C6E:: ; address name
    call BuildScreenBlocks21To24
    ld hl, vBGMap0
    ld de, wScreenTileBuffer
    ld bc, $0709
    call CopyRectToBGMap
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    xor a, a
    ld [wSubMenuCursor], a
    ld hl, wTemp1
    inc [hl]
    ret

; entry 3 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wSubMenuCursor, wCurrentKeyIndex, wMapType
; writes: wTemp1, wStringIndex, wStringCategory, wStringDestLo, wStringDestHi
; points at: wSubMenuCursor, wTemp1, wTextBuf2
PauseMenu_State3_Case01_Case03::
Jump_003_6C90:: ; address name
    ld hl, wSubMenuCursor
    ld de, Data_003_4633
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jp z, Jump_003_6D29
    ld a, $69
    call QueueSoundEffect
    ld a, [wSubMenuCursor]
    and a, $01
    jr nz, Jump_003_6CB2
    ld hl, wTemp1
    inc [hl]
    ret

Jump_003_6CB2::
    call TestListEntryBit7
    jr nz, Jump_003_6CEE
    push af
    ld c, a
    ld a, [wCurrentKeyIndex]
    cp a, c
    jr nz, Jump_003_6CC9
    ld a, [wMapType]
    bit 7, a
    jr z, Jump_003_6CC9
    pop af
    jr Jump_003_6D23

Jump_003_6CC9::
    pop af
    push af
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
    cp a, $FE
    jr nz, Jump_003_6CE1
    pop af
    ld a, [hl]
    jr Jump_003_6CE2

Jump_003_6CE1::
    pop af

Jump_003_6CE2::
    ld de, wTextBuf2
    call WriteKeyNameToDE
    ld a, $0A
    ld [wTemp1], a
    ret

Jump_003_6CEE::
    and a, $7F
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
    and a, $3F
    cp a, $07
    jr c, Jump_003_6D23
    ld [wStringIndex], a
    ld a, $06
    ld [wStringCategory], a
    ld hl, wTextBuf2
    ld a, l
    ld [wStringDestLo], a
    ld a, h
    ld [wStringDestHi], a
    farcall CopyStringToBuffer_Bank09
    ld a, $0A
    ld [wTemp1], a
    ret

Jump_003_6D23::
    ld a, $07
    ld [wTemp1], a
    ret

Jump_003_6D29::
    bit 1, a
    ret z
    xor a, a
    ld [wTemp1], a
    ret

; entry 4 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; points at: wTemp1
PauseMenu_State3_Case01_ToPauseMenu_State3_Shared04AndStep::
Jump_003_6D31:: ; address name
    call PauseMenu_State3_Shared04
    ld hl, wTemp1
    inc [hl]
    ret

; entry 5 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wModeState
; writes: wDataBankSave, wStringIndex, wStringCategory
; points at: wTemp1
PauseMenu_State3_Case01_Case05::
Jump_003_6D39:: ; address name
    call TestListEntryBit7
    jr nz, Jump_003_6D60
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
    cp a, $FE
    jr nz, Jump_003_6D60
    ld a, [wModeState]
    bit 3, a
    jr z, Jump_003_6D5C
    ld a, $40
    ld [wDataBankSave], a

Jump_003_6D5C::
    ld a, $0C
    jr Jump_003_6D69

Jump_003_6D60::
    ld a, [wModeState]
    bit 3, a
    jr nz, Jump_003_6D73
    ld a, $09

Jump_003_6D69::
    ld [wStringIndex], a
    ld a, $08
    ld [wStringCategory], a
    jr Jump_003_6D85

Jump_003_6D73::
    call TestListEntryBit7
    set 7, a
    ld [wDataBankSave], a
    ld a, $08
    ld [wStringCategory], a
    ld a, $0B
    ld [wStringIndex], a

Jump_003_6D85::
    farcall BeginStringDisplay_Bank08
    ld hl, wTemp1
    inc [hl]
    ret

; entry 6 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wModeState
; writes: wTemp1
PauseMenu_State3_Case01_Case06::
Jump_003_6D90:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    xor a, a
    ld [wTemp1], a
    ld a, [wModeState]
    bit 3, a
    ret z
    call ExitPauseMenuToField
    ret

; entry 7 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; points at: wTemp1
PauseMenu_State3_Case01_ToPauseMenu_State3_Shared04AndStep_Case07::
Jump_003_6DA3:: ; address name
    call PauseMenu_State3_Shared04
    ld hl, wTemp1
    inc [hl]
    ret

; entry 8 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wTemp1
PauseMenu_State3_Case01_BeginStringDisplay_Bank08AndStep::
Jump_003_6DAB:: ; address name
    ld a, $08
    ld [wStringCategory], a
    ld a, $08
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    ld hl, wTemp1
    inc [hl]
    ret

; entry 9 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wTemp1
PauseMenu_State3_Case01_Case09::
Jump_003_6DC0:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    xor a, a
    ld [wTemp1], a
    ret

; entry 10 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wMenuRowCount, wMenuPageCount
; points at: wTemp1
PauseMenu_State3_Case01_PauseMenu_State3_Shared04AndStep::
Jump_003_6DCA:: ; address name
    call PauseMenu_State3_Shared04
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    ld hl, wTemp1
    inc [hl]
    ret

; entry 11 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wTemp1
PauseMenu_State3_Case01_BeginStringDisplay_Bank08AndStep_Case0B::
Jump_003_6DDC:: ; address name
    ld a, $08
    ld [wStringCategory], a
    ld a, $07
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    ld hl, wTemp1
    inc [hl]
    ret

; entry 12 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; points at: wTemp1
PauseMenu_State3_Case01_Case0C::
Jump_003_6DF1:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld hl, wTemp1
    inc [hl]
    ret

; entry 13 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wMenuRowCount, wMenuPageCount, wSubMenuCursor2
; points at: wTemp1
PauseMenu_State3_Case01_Case0D::
Jump_003_6DFB:: ; address name
    call BuildScreenBlocks21To25WithCursor
    ld hl, vBGMap0 + $E0
    ld de, wScreenTileBuffer + $E0
    ld bc, $0605
    call CopyRectToBGMap
    ld a, $6C
    call QueueSoundEffect
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    xor a, a
    ld [wSubMenuCursor2], a
    ld a, $01
    ld [wSubMenuCursor2], a
    ld hl, wTemp1
    inc [hl]
    ret

; entry 14 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wSubMenuCursor2
; writes: wMenuRowCount, wMenuPageCount, wSubMenuCursor, wTemp1
; points at: wSubMenuCursor2, wTemp1
PauseMenu_State3_Case01_Case0E::
Jump_003_6E27:: ; address name
    ld hl, wSubMenuCursor2
    ld de, Data_003_4627
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_6E53
    ld a, $69
    call QueueSoundEffect
    ld a, [wSubMenuCursor2]
    and a, $01
    ld hl, Data_003_4627
    call WriteBCTileAtWordTableEntry_Bank03
    ld a, [wSubMenuCursor2]
    and a, $01
    jr nz, Jump_003_6E56
    ld hl, wTemp1
    inc [hl]
    ret

Jump_003_6E53::
    bit 1, a
    ret z

Jump_003_6E56::
    call BuildScreenBlocks21To24
    ld hl, vBGMap0 + $80
    ld de, wScreenTileBuffer + $80
    ld bc, $0609
    call CopyRectToBGMap
    ld hl, vBGMap0 + $1A0
    ld de, wWindowTileBuffer + $38
    ld bc, $1405
    call CopyRectToBGMap
    call PauseMenu_State3_Shared06
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    xor a, a
    ld [wSubMenuCursor], a
    ld a, $03
    ld [wTemp1], a
    ret

; entry 15 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wStringIndex, wStringCategory
; points at: wTemp1
PauseMenu_State3_Case01_BeginStringDisplay_Bank08AndStep_Case0F::
Jump_003_6E88:: ; address name
    ld a, $04
    ld [wStringIndex], a
    ld a, $08
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank08
    ld hl, wTemp1
    inc [hl]
    ret

; entry 16 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wTemp1, hTemp0, wMenuPage, wMenuCursor
PauseMenu_State3_Case01_Case10::
Jump_003_6E9D:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    xor a, a
    ld [wTemp1], a
    call TestListEntryBit7
    jr z, Jump_003_6EAF
    res 7, a
    and a, $3F

Jump_003_6EAF::
    ldh [hTemp0], a
    farcall DeleteKeyEntryTemp0
    xor a, a
    ld [wMenuPage], a
    ld [wMenuCursor], a
    ret

; index = wMenuPage * 4 + (wC46E & 7): A = wD0A7[index], Z clear when its bit 7 is set (E-0117)
; 4 call sites from 3 routines (e.g. PauseMenu_State3_Case01_Case10, PauseMenu_State3_Case01_Case05, PauseMenu_State3_Case01_Case03)
; reads: wMenuPage, wMenuCursor
TestListEntryBit7::
Func_003_6EBF:: ; address name
    ld a, [wMenuPage]
    ld b, a
    add a, a
    add a, a
    ld b, a
    ld a, [wMenuCursor]
    and a, $07
    add a, b
    ld hl, wWorkBuf + $A
    add_a_to_hl
    ld a, [hl]
    bit 7, a
    ret

; entry 2 of the `rst $00` table in PauseMenu_State3
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp1
PauseMenu_State3_Case02::
Jump_003_6ED8:: ; address name
    ld a, [wTemp1]
    rst $00
    dw PauseMenu_State3_Case02_Case00_Sub01AndStep
    dw PauseMenu_State3_Case02_Case01
    dw PauseMenu_State3_Case02_Case02

; entry 0 of the `rst $00` table in PauseMenu_State3_Case02
; no direct call (reached through a table, a jump or a vector)
; writes: wPauseMenuStep, wMenuRowCount, wMenuPageCount, wMenuPage
; points at: wTemp1
PauseMenu_State3_Case02_Case00_Sub01AndStep::
Jump_003_6EE2:: ; address name
    xor a, a
    ld [wPauseMenuStep], a
    call PauseMenu_State3_Case02_Case00_LoadScreenBlock21WithCursor
    call CopyTileBufferToBGMap
    ld a, $04
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    ld a, $00
    ld [wMenuPage], a
    ld hl, wTemp1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_State3_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wPauseMenuStep
; writes: rRAMG, rRAMB, wMenuCursor
; points at: wTemp1
PauseMenu_State3_Case02_Case01::
Jump_003_6F00:: ; address name
    ld a, [wPauseMenuStep]
    ld hl, Data_003_6FBB
    add_a_to_hl
    ld a, [hl]
    ld hl, wScreenTileBuffer + $EE
    ld [hl+], a
    inc a
    ld [hl+], a
    inc a
    ld [hl+], a
    inc a
    ld [hl+], a
    inc a
    ld [hl], a
    ld hl, vBGMap0 + $EA
    ld de, wScreenTileBuffer + $EA
    ld bc, $090A
    call CopyRectToBGMap
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wPauseMenuStep]
    ld c, $0E
    call SRAMRecordAddressMapped
    ld a, [hl]
    swap a
    and a, $03
    ld [wMenuCursor], a
    ld a, $00
    ld [rRAMG], a
    ld hl, wTemp1
    inc [hl]
    ret

; entry 2 of the `rst $00` table in PauseMenu_State3_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wPauseMenuStep, wMenuCursor, wPartyCount
; writes: wPauseMenuStep, wTemp0, wTemp1, rRAMG, rRAMB
; points at: wMenuCursor, wTemp1
PauseMenu_State3_Case02_Case02::
Jump_003_6F48:: ; address name
    ld hl, wMenuCursor
    ld de, Data_003_4637
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, Jump_003_6F6F
    ld a, [wPauseMenuStep]
    or a, a
    jr z, Jump_003_6F67
    dec a
    ld [wPauseMenuStep], a
    ld hl, wTemp1
    dec [hl]
    ret

Jump_003_6F67::
    xor a, a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

Jump_003_6F6F::
    bit 0, a
    ret z
    ld a, $69
    call QueueSoundEffect
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wPauseMenuStep]
    ld c, $0E
    call SRAMRecordAddressMapped
    ld a, [wMenuCursor]
    and a, $03
    swap a
    ld c, a
    cp a, $30
    jr nz, Jump_003_6F9A
    ld a, [hl]
    and a, $C0
    jr Jump_003_6F9C

Jump_003_6F9A::
    rlca
    rlca

Jump_003_6F9C::
    or a, c
    ld c, a
    ld a, [hl]
    and a, $0F
    or a, c
    ld [hl], a
    ld a, $00
    ld [rRAMG], a
    ld a, [wPartyCount]
    ld c, a
    ld a, [wPauseMenuStep]
    inc a
    ld [wPauseMenuStep], a
    cp a, c
    jr z, Jump_003_6F67
    ld hl, wTemp1
    dec [hl]
    ret

; address loaded by PauseMenu_State3_Case02_Case01
Data_003_6FBB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $D5, $DA

; entry 3 of the `rst $00` table in PauseMenu_State3
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp1
PauseMenu_State3_Case03::
Jump_003_6FBE:: ; address name
    ld a, [wTemp1]
    rst $00
    dw PauseMenu_State3_Case03_LoadScreenBlock21CursorAnd2CAndStep
    dw PauseMenu_State3_Case03_Case01

; entry 0 of the `rst $00` table in PauseMenu_State3_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuSaveByte34
; writes: wMenuCursor
; points at: wTemp1
PauseMenu_State3_Case03_LoadScreenBlock21CursorAnd2CAndStep::
Jump_003_6FC6:: ; address name
    call LoadScreenBlock21CursorAnd2C
    call CopyTileBufferToBGMap
    ld a, [wMenuSaveByte34]
    ld [wMenuCursor], a
    ld hl, wTemp1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_State3_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wMenuCursor, wJoypadPressedRepeat, wFrameCounterLo
; writes: wMenuSaveByte34, wTemp0, wTemp1, wMenuCursor, wFrameCounterLo
PauseMenu_State3_Case03_Case01::
Jump_003_6FD7:: ; address name
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_6FED
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuCursor]
    and a, $07
    ld [wMenuSaveByte34], a
    jr Jump_003_6FF1

Jump_003_6FED::
    bit 1, a
    jr z, Jump_003_6FF9

Jump_003_6FF1::
    xor a, a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

Jump_003_6FF9::
    ld a, [wJoypadPressedRepeat]
    bit 5, a
    jr z, Jump_003_7009
    call EraseMenuCursorMenuCursor
    ld a, [wMenuCursor]
    dec a
    jr Jump_003_7014

Jump_003_7009::
    bit 4, a
    jr z, Jump_003_702A
    call EraseMenuCursorMenuCursor
    ld a, [wMenuCursor]
    inc a

Jump_003_7014::
    and a, $07
    ld [wMenuCursor], a
    call DrawMenuCursorMenuCursor
    ld a, [wFrameCounterLo]
    and a, $F0
    ld [wFrameCounterLo], a
    ld a, $69
    call QueueSoundEffect
    ret

Jump_003_702A::
    ld a, [wFrameCounterLo]
    and a, $0F
    jr nz, Jump_003_7048
    ld a, [wFrameCounterLo]
    bit 4, a
    jr z, Jump_003_703D
    call DrawMenuCursorMenuCursor
    jr Jump_003_7048

Jump_003_703D::
    call EraseMenuCursorMenuCursor
    ld a, [wFrameCounterLo]
    set 3, a
    ld [wFrameCounterLo], a

Jump_003_7048::
    ret

; writes the cursor tile $BB at MenuCursorAddressMenuCursor (E-0114)
; 2 call sites from 1 routine (e.g. PauseMenu_State3_Case03_Case01)
DrawMenuCursorMenuCursor::
Func_003_7049:: ; address name
    call MenuCursorAddressMenuCursor
    ld a, $BB
    call WriteVRAMByte
    ret

; writes the blank tile $C3 at MenuCursorAddressMenuCursor (E-0114)
; 3 call sites from 1 routine (e.g. PauseMenu_State3_Case03_Case01)
EraseMenuCursorMenuCursor::
Func_003_7052:: ; address name
    call MenuCursorAddressMenuCursor
    ld a, $C3
    call WriteVRAMByte
    ret

; HL = the word at Data_003_4649 + 2 * wC46E (the cursor row's VRAM address) (E-0114)
; 2 call sites from 2 routines (e.g. DrawMenuCursorMenuCursor, EraseMenuCursorMenuCursor)
; reads: wMenuCursor
MenuCursorAddressMenuCursor::
Func_003_705B:: ; address name
    ld a, [wMenuCursor]
    ld hl, Data_003_4649
    add a, a
    add_a_to_hl
    deref_hl
    ret

; entry 4 of the `rst $00` table in PauseMenu_State3
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp1
PauseMenu_State3_Case04::
Jump_003_706B:: ; address name
    ld a, [wTemp1]
    rst $00
    dw PauseMenu_State3_Case04_Case00
    dw PauseMenu_State3_Case04_PauseMenu_State3_Shared01AndStep
    dw PauseMenu_State3_Case04_Case02
    dw PauseMenu_State3_Case04_LoadScreenBlock21AndStep
    dw PauseMenu_State3_Case04_Case04
    dw PauseMenu_State3_Case04_PauseMenu_State3_Shared05

; entry 0 of the `rst $00` table in PauseMenu_State3_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount
; writes: wWorkBuf, wMenuPageCount, wMenuPage, wPauseMenuStep
; points at: wTemp1
PauseMenu_State3_Case04_Case00::
Jump_003_707B:: ; address name
    ld a, [wPartyCount]
    dec a
    ld [wWorkBuf + $2], a
    ld c, $00
    ld a, c
    ld [wWorkBuf + $3], a
    ld a, [wPartyCount]
    cp a, $01
    jr z, Jump_003_7092
    inc c
    jr Jump_003_7094

Jump_003_7092::
    ld c, $FF

Jump_003_7094::
    ld a, c
    ld [wWorkBuf + $4], a
    ld a, [wPartyCount]
    cp a, $03
    jr nz, Jump_003_70A2
    inc c
    jr Jump_003_70A4

Jump_003_70A2::
    ld c, $FF

Jump_003_70A4::
    ld a, c
    ld [wWorkBuf + $5], a
    ld a, $FF
    ld [wWorkBuf + $6], a
    ld [wWorkBuf + $7], a
    ld [wWorkBuf + $8], a
    ld a, $01
    ld [wMenuPageCount], a
    xor a, a
    ld [wMenuPage], a
    ld [wPauseMenuStep], a
    call PauseMenu_State3_Shared05
    call CopyTileBufferToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_State3_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wMenuCursor
; points at: wTemp1
PauseMenu_State3_Case04_PauseMenu_State3_Shared01AndStep::
Jump_003_70CA:: ; address name
    call PauseMenu_State3_Shared01
    xor a, a
    ld [wMenuCursor], a
    call PauseMenu_State3_Shared02
    ld hl, wTemp1
    inc [hl]
    ret

; entry 2 of the `rst $00` table in PauseMenu_State3_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wMenuCursor, wPauseMenuStep, wPartyCount, wWorkBuf
; writes: wPauseMenuStep, wTemp0, wTemp1
; points at: wMenuCursor, wTemp1
PauseMenu_State3_Case04_Case02::
Jump_003_70D9:: ; address name
    ld hl, wMenuCursor
    ld de, Data_003_463F
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, Jump_003_70ED
    call PauseMenu_State3_Shared02
    ret

Jump_003_70ED::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_7134
    ld a, $69
    call QueueSoundEffect
    ld a, [wMenuCursor]
    and a, $03
    ld hl, wWorkBuf + $3
    add_a_to_hl
    ld c, [hl]
    ld [hl], $FF
    ld a, [wPauseMenuStep]
    ld hl, wWorkBuf + $6
    add_a_to_hl
    ld [hl], c
    call PauseMenu_State3_Shared08
    ld hl, wWorkBuf + $2
    dec [hl]
    ld a, [wPartyCount]
    ld b, a
    ld a, [wPauseMenuStep]
    inc a
    ld [wPauseMenuStep], a
    cp a, b
    jr z, Jump_003_712F
    ld hl, wTemp1
    dec [hl]
    ret

Jump_003_712F::
    ld hl, wTemp1
    inc [hl]
    ret

Jump_003_7134::
    bit 1, a
    ret z
    ld a, [wPauseMenuStep]
    or a, a
    jr nz, PauseMenu_State3_Case04_Case05_Sub01
    xor a, a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

; only called from PauseMenu_State3_Case04_Case05 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_State3_Case04_PauseMenu_State3_Shared05)
; reads: wPauseMenuStep, wWorkBuf
; writes: wPauseMenuStep
; points at: wTemp1
PauseMenu_State3_Case04_Case05_Sub01::
Func_003_7145:: ; address name
    ld hl, wWorkBuf + $2
    inc [hl]
    ld a, [wPauseMenuStep]
    dec a
    ld [wPauseMenuStep], a
    ld hl, wWorkBuf + $6
    add_a_to_hl
    ld c, [hl]
    ld [hl], $FF
    ld a, [wWorkBuf + $2]
    ld hl, wWorkBuf + $3
    add_a_to_hl
    ld [hl], c
    call PauseMenu_State3_Shared08
    ld hl, wTemp1
    dec [hl]
    ret

; entry 3 of the `rst $00` table in PauseMenu_State3_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuSelectedMember
; points at: wTemp1
PauseMenu_State3_Case04_LoadScreenBlock21AndStep::
Jump_003_716F:: ; address name
    call LoadScreenBlock21
    ld a, [wMenuSelectedMember]
    and a, $07
    ld hl, MenuCursorPositions_Bank03
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    call PauseMenu_State3_Shared01
    ld de, wScreenTileBuffer + $128
    ld hl, vBGMap0 + $128
    ld bc, $0C09
    call CopyRectToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

; entry 4 of the `rst $00` table in PauseMenu_State3_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed
; writes: wTemp0, wTemp1
; points at: wTemp1
PauseMenu_State3_Case04_Case04::
Jump_003_7191:: ; address name
    ld a, [wJoypadPressed]
    and a, $01
    jr z, Jump_003_71A3
    call PauseMenu_State3_Case04_Case04_Sub01
    xor a, a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

Jump_003_71A3::
    ld a, [wJoypadPressed]
    and a, $02
    ret z
    ld hl, wTemp1
    inc [hl]
    ret

; entry 5 of the `rst $00` table in PauseMenu_State3_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wMenuCursor
; points at: wTemp1
PauseMenu_State3_Case04_PauseMenu_State3_Shared05::
Jump_003_71AE:: ; address name
    call PauseMenu_State3_Shared05
    call PauseMenu_State3_Case04_Case05_Sub01
    call PauseMenu_State3_Shared01
    xor a, a
    ld [wMenuCursor], a
    call PauseMenu_State3_Shared02
    call CopyTileBufferToBGMap
    ld hl, wTemp1
    dec [hl]
    ld hl, wTemp1
    dec [hl]
    ret

; only called from PauseMenu_State3_Case04_Case04 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_State3_Case04_Case04)
; reads: wWorkBuf
; writes: wPartyList
; points at: wPartyList
PauseMenu_State3_Case04_Case04_Sub01::
Func_003_71CA:: ; address name
    ld a, [wWorkBuf + $6]
    ld hl, wPartyList
    add_a_to_hl
    ld c, [hl]
    ld a, [wWorkBuf + $7]
    cp a, $FF
    jr z, Jump_003_71FD
    ld hl, wPartyList
    add_a_to_hl
    ld b, [hl]
    ld a, [wWorkBuf + $8]
    cp a, $FF
    jr z, Jump_003_71F9
    ld hl, wPartyList
    add_a_to_hl
    ld a, [hl]
    ld [wPartyList + $2], a

Jump_003_71F9::
    ld a, b
    ld [wPartyList + $1], a

Jump_003_71FD::
    ld a, c
    ld [wPartyList], a
    ret

; only called from routines of PauseMenu_State3 (E-0098)
; 3 call sites from 3 routines (e.g. PauseMenu_State3_Case04_PauseMenu_State3_Shared05, PauseMenu_State3_Case04_LoadScreenBlock21AndStep, PauseMenu_State3_Case04_PauseMenu_State3_Shared01AndStep)
; reads: wWorkBuf
; writes: wMenuRowCount
PauseMenu_State3_Shared01::
Func_003_7202:: ; address name
    call LoadScreenBlock28
    ld a, [wWorkBuf + $2]
    inc a
    ld [wMenuRowCount], a
    ld de, wScreenTileBuffer + $63
    ld a, [wWorkBuf + $3]
    call PauseMenu_State3_Shared01_Sub01
    ld de, wScreenTileBuffer + $A3
    ld a, [wWorkBuf + $4]
    call PauseMenu_State3_Shared01_Sub01
    ld de, wScreenTileBuffer + $E3
    ld a, [wWorkBuf + $5]
    call PauseMenu_State3_Shared01_Sub01
    ld de, wScreenTileBuffer + $6C
    ld a, [wWorkBuf + $6]
    ld b, $E1
    call PauseMenu_State3_Shared01_Sub02
    ld de, wScreenTileBuffer + $AC
    ld a, [wWorkBuf + $7]
    ld b, $E2
    call PauseMenu_State3_Shared01_Sub02
    ld de, wScreenTileBuffer + $EC
    ld a, [wWorkBuf + $8]
    ld b, $E3
    call PauseMenu_State3_Shared01_Sub02
    ld de, wScreenTileBuffer + $63
    ld hl, vBGMap0 + $63
    ld bc, $1005
    call CopyRectToBGMap
    ret

Jump_003_7255::
    inc de
    inc de

; only called from PauseMenu_State3_Shared02 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_State3_Shared02)
PauseMenu_State3_Shared02_Sub01::
Func_003_7257:: ; address name
    ld hl, Data_003_7395
    add_a_to_hl
    ld a, [hl]
    ld [de], a
    inc a
    inc de
    ld [de], a
    inc a
    inc de
    ld [de], a
    inc a
    inc de
    ld [de], a
    inc a
    inc de
    ld [de], a
    ret

; only called from PauseMenu_State3_Shared01 (E-0047)
; 3 call sites from 1 routine (e.g. PauseMenu_State3_Shared01)
PauseMenu_State3_Shared01_Sub01::
Func_003_726E:: ; address name
    cp a, $FF
    ret z
    push af
    add a, $E1
    ld [de], a
    pop af
    jr Jump_003_7255

; only called from PauseMenu_State3_Shared01 (E-0047)
; 3 call sites from 1 routine (e.g. PauseMenu_State3_Shared01)
PauseMenu_State3_Shared01_Sub02::
Func_003_7278:: ; address name
    cp a, $FF
    ret z
    push af
    ld a, b
    ld [de], a
    pop af
    jr Jump_003_7255

; only called from routines of PauseMenu_State3 (E-0098)
; 3 call sites from 3 routines (e.g. PauseMenu_State3_Case04_PauseMenu_State3_Shared05, PauseMenu_State3_Case04_Case02, PauseMenu_State3_Case04_PauseMenu_State3_Shared01AndStep)
; reads: wMenuCursor
; writes: rRAMG, rRAMB, wStringIndex, wStringCategory, wScreenTileBuffer, wWindowTileBuffer
PauseMenu_State3_Shared02::
Func_003_7281:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wMenuCursor]
    and a, $03
    ld hl, wWorkBuf + $3
    add_a_to_hl
    ld a, [hl]
    push af
    ld c, $0B
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld [wStringIndex], a
    ld a, [hl+]
    push hl
    add a, $02
    ld [wStringCategory], a
    ld hl, vTiles2 + $200
    ld de, $0901
    call ShowStringBank08AtTilesHL_Bank03
    pop hl
    inc hl
    ld a, [hl]
    and a, $01
    add a, $CC
    ld [wScreenTileBuffer + $14E], a
    ld a, l
    add a, $48
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl]
    push hl
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld de, wScreenTileBuffer + $151
    call WriteTwoDigitTilesFromWC8C1
    pop hl
    ld a, l
    add a, $05
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $64
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $68
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $A4
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    deref_hl
    call HLToDecimalDigits
    ld de, wWindowTileBuffer + $A8
    call WriteDecimalDigitTiles
    pop af
    push af
    add a, $C7
    ld [wWindowTileBuffer + $21], a
    pop af
    ld de, wScreenTileBuffer + $149
    call PauseMenu_State3_Shared02_Sub01
    ld a, $00
    ld [rRAMG], a
    ld hl, vBGMap0 + $149
    ld de, wScreenTileBuffer + $149
    ld bc, $0A07
    call CopyRectToBGMap
    ret

; only called from routines of PauseMenu_State3 (E-0098)
; 2 call sites from 2 routines (e.g. PauseMenu_State3_Case04_Case05_Sub01, PauseMenu_State3_Case04_Case02)
; reads: wWorkBuf
; writes: wWorkBuf
PauseMenu_State3_Shared08::
Func_003_7335:: ; address name
    ld a, [wWorkBuf + $3]
    ld c, a
    ld a, [wWorkBuf + $4]
    ld b, a
    ld a, [wWorkBuf + $5]
    ld e, a
    cp a, b
    jr c, Jump_003_7360
    cp a, c
    jr c, Jump_003_7389
    ld [wWorkBuf + $5], a
    ld a, b
    cp a, c
    jr c, Jump_003_7357
    ld [wWorkBuf + $4], a
    ld a, c
    ld [wWorkBuf + $3], a
    jr Jump_003_7394

Jump_003_7357::
    ld [wWorkBuf + $3], a
    ld a, c
    ld [wWorkBuf + $4], a
    jr Jump_003_7394

Jump_003_7360::
    cp a, c
    jr c, Jump_003_7370
    ld [wWorkBuf + $4], a
    ld a, c
    ld [wWorkBuf + $3], a
    ld a, b
    ld [wWorkBuf + $5], a
    jr Jump_003_7394

Jump_003_7370::
    ld [wWorkBuf + $3], a
    ld a, b
    cp a, c
    jr c, Jump_003_7380
    ld [wWorkBuf + $5], a
    ld a, c
    ld [wWorkBuf + $4], a
    jr Jump_003_7394

Jump_003_7380::
    ld [wWorkBuf + $4], a
    ld a, c
    ld [wWorkBuf + $5], a
    jr Jump_003_7394

Jump_003_7389::
    ld [wWorkBuf + $4], a
    ld a, b
    ld [wWorkBuf + $3], a
    ld a, c
    ld [wWorkBuf + $5], a

Jump_003_7394::
    ret

; address loaded by PauseMenu_State3_Shared02_Sub01
Data_003_7395:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $D5, $DA

; entry 5 of the `rst $00` table in PauseMenu_State3
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp1
PauseMenu_State3_Case05::
Jump_003_7398:: ; address name
    ld a, [wTemp1]
    rst $00
    dw PauseMenu_State3_Case05_Case00
    dw PauseMenu_State3_Case05_Case01

; entry 0 of the `rst $00` table in PauseMenu_State3_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wPlayHoursLo, wPlayHoursHi, wPlayMinutes, wWorkBuf, wArg5
; writes: wWorkBuf
; points at: wPlayerName, wWorkBuf, wTemp1
PauseMenu_State3_Case05_Case00::
Jump_003_73A0:: ; address name
    call LoadScreenBlock2D
    ld a, $20
    ld [wWorkBuf + $1], a
    farcall LoadAllFamilyIconTiles
    ld hl, wPlayerName
    call CopyTenBytesToTextBuf0
    ld hl, vTiles2 + $300
    call SelectString5Category8ThenShow
    ld a, [wPlayHoursLo]
    ld l, a
    ld a, [wPlayHoursHi]
    ld h, a
    call HLToDecimalDigits
    ld de, wScreenTileBuffer + $68
    call WriteThreeDigitTilesDigits_Bank03
    ld a, [wPlayMinutes]
    call ByteAToDecimalDigits
    ld de, wScreenTileBuffer + $6C
    call WriteTwoDigitTilesWC8C1NoBlank_Bank03
    call PauseMenu_State3_Case05_Case00_Sub01
    ld a, [wWorkBuf]
    ld de, wScreenTileBuffer + $AB
    call WriteByteAAsTwoDigitTiles
    ld a, [wWorkBuf + $1]
    ld de, wScreenTileBuffer + $B1
    call WriteByteAAsTwoDigitTiles
    farcall CountFlaggedSRAMRecords
    ld a, [wArg5]
    ld de, wScreenTileBuffer + $EB
    call WriteByteAAsTwoDigitTiles
    farcall CountSpeciesPerFamilyFlaggedOrListed
    ld a, [wWorkBuf]
    ld de, wWindowTileBuffer + $1B
    call WriteByteAAsTwoDigitTiles
    ld a, [wWorkBuf + $1]
    ld de, wWindowTileBuffer + $1F
    call WriteByteAAsTwoDigitTiles
    ld a, [wWorkBuf + $2]
    ld de, wWindowTileBuffer + $23
    call WriteByteAAsTwoDigitTiles
    ld a, [wWorkBuf + $3]
    ld de, wWindowTileBuffer + $27
    call WriteByteAAsTwoDigitTiles
    ld a, [wWorkBuf + $4]
    ld de, wWindowTileBuffer + $5B
    call WriteByteAAsTwoDigitTiles
    ld a, [wWorkBuf + $5]
    ld de, wWindowTileBuffer + $5F
    call WriteByteAAsTwoDigitTiles
    ld a, [wWorkBuf + $6]
    ld de, wWindowTileBuffer + $63
    call WriteByteAAsTwoDigitTiles
    ld a, [wWorkBuf + $7]
    ld de, wWindowTileBuffer + $67
    call WriteByteAAsTwoDigitTiles
    ld a, [wWorkBuf + $8]
    ld de, wWindowTileBuffer + $9B
    call WriteByteAAsTwoDigitTiles
    ld a, [wWorkBuf + $9]
    ld de, wWindowTileBuffer + $9F
    call WriteByteAAsTwoDigitTiles
    ld a, [wWorkBuf + $A]
    ld de, wWindowTileBuffer + $A3
    call WriteByteAAsTwoDigitTiles
    ld hl, $0000
    ld de, wWorkBuf
    ld b, $0B

Jump_003_746C::
    ld a, [de]
    inc de
    add_a_to_hl
    dec b
    jr nz, Jump_003_746C
    call HLToDecimalDigits
    ld de, wScreenTileBuffer + $14E
    call WriteDecimalDigitTiles
    call CopyTileBufferToBGMap
    ld hl, wTemp1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_State3_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wPlayFrames, wPlaySeconds, wPlayMinutes, wPlayHoursLo, wPlayHoursHi
; writes: wTemp0, wTemp1
PauseMenu_State3_Case05_Case01::
Jump_003_7487:: ; address name
    ld a, [wJoypadPressed]
    and a, $03
    jr nz, Jump_003_74C2
    ld a, [wPlayFrames]
    or a, a
    ret nz
    ld a, [wPlaySeconds]
    or a, a
    ret nz
    ld a, [wPlayMinutes]
    call ByteAToDecimalDigits
    ld de, wScreenTileBuffer + $6C
    call WriteTwoDigitTilesWC8C1NoBlank_Bank03
    ld a, [wPlayHoursLo]
    ld l, a
    ld a, [wPlayHoursHi]
    ld h, a
    call HLToDecimalDigits
    ld de, wScreenTileBuffer + $68
    call WriteThreeDigitTilesDigits_Bank03
    ld de, wScreenTileBuffer + $68
    ld hl, vBGMap0 + $68
    ld bc, $0601
    call CopyRectToBGMap
    ret

Jump_003_74C2::
    xor a, a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

; HL = A (zero-extended), then HLToDecimalDigits (E-0101)
; 3 call sites from 3 routines (e.g. PauseMenu_State3_Case05_Case01, PauseMenu_State3_Case05_Case00, WriteByteAAsTwoDigitTiles)
ByteAToDecimalDigits::
Func_003_74CA:: ; address name
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ret

; ByteAToDecimalDigits, then WriteTwoDigitTilesFromWC8C1 at DE (leading zero blank); DE kept across the conversion (E-0114)
; 14 call sites from 1 routine (e.g. PauseMenu_State3_Case05_Case00)
WriteByteAAsTwoDigitTiles::
Func_003_74D1:: ; address name
    push de
    call ByteAToDecimalDigits
    pop de
    call WriteTwoDigitTilesFromWC8C1
    ret

; writes wC8C0 as a digit tile at DE and falls into WriteTwoDigitTilesWC8C1NoBlank_Bank03 (E-0126)
; 2 call sites from 2 routines (e.g. PauseMenu_State3_Case05_Case01, PauseMenu_State3_Case05_Case00)
; points at: wDigits
WriteThreeDigitTilesDigits_Bank03::
Func_003_74DA:: ; address name
    ld hl, wDigits
    ld a, [hl]
    add a, $E0
    ld [de], a
    inc de

; writes wC8C1 and wC8C2 as tiles $E0 + digit at DE and DE + 1 (no leading-zero blank) (E-0117) (the same 13 bytes appear in 2 banks)
; 2 call sites from 2 routines (e.g. PauseMenu_State3_Case05_Case01, PauseMenu_State3_Case05_Case00)
WriteTwoDigitTilesWC8C1NoBlank_Bank03::
Func_003_74E2:: ; address name
    ld hl, wDigits + $1
    ld a, [hl+]
    add a, $E0
    ld [de], a
    inc de
    ld a, [hl]
    add a, $E0
    ld [de], a
    ret

; entry 6 of the `rst $00` table in PauseMenu_State3
; no direct call (reached through a table, a jump or a vector)
; reads: wTemp1
PauseMenu_State3_Case06::
Jump_003_74EF:: ; address name
    ld a, [wTemp1]
    rst $00
    dw PauseMenu_State3_Case06_ShowMaster
    dw PauseMenu_State3_Case06_Case01
    dw PauseMenu_State3_Case06_Case02
    dw PauseMenu_State3_Case06_Case03
    dw PauseMenu_State3_Case06_ShowYourProgressHasBeen
    dw PauseMenu_State3_Case06_Case05
    dw PauseMenu_State3_Case06_Case06

; entry 0 of the `rst $00` table in PauseMenu_State3_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; writes: hSpriteWindowClipMode, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wScreenTileBuffer
; points at: wTemp1
PauseMenu_State3_Case06_ShowMaster::
Jump_003_7501:: ; address name
    xor a, a
    ldh [hSpriteWindowClipMode], a
    call PauseMenu_State3_Case06_Case00_Sub01
    ld a, [wTextWindowTileLo]
    ld l, a
    ld a, [wTextWindowTileHi]
    ld h, a
    push hl
    ld a, [wTextWindowRows]
    ld l, a
    ld a, [wTextWindowWidth]
    ld h, a
    push hl
    ld hl, vTiles2 + $50
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
    pop hl
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, $C3
    ld [wScreenTileBuffer + $61], a
    call CopyTileBufferToBGMap
    ld a, $00
    ld [wStringCategory], a
    ld a, $25
    ld [wStringIndex], a ; 'Want to record your journey?'
    farcall BeginStringDisplay_Bank37
    call PauseMenu_State3_Shared03
    ld hl, wTemp1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_State3_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wMenuRowCount, wMenuPageCount, wSubMenuCursor
; points at: wTemp1
PauseMenu_State3_Case06_Case01::
Jump_003_7571:: ; address name
    call PauseMenu_State3_Shared03
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld de, Tiles1Plus6F0Tiles_1F_4330
    ld hl, vTiles1 + $740
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $6C
    call QueueSoundEffect
    call LoadScreenBlock2B
    call CopyTileBufferToBGMap
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    xor a, a
    ld [wSubMenuCursor], a
    ld hl, wTemp1
    inc [hl]
    ret

; entry 2 of the `rst $00` table in PauseMenu_State3_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wSubMenuCursor, wModeState
; writes: wPauseMenuScreen, wTemp0, wTemp1
; points at: wSubMenuCursor, wTemp1, wScreenTileBuffer
PauseMenu_State3_Case06_Case02::
Jump_003_75A4:: ; address name
    ld hl, wSubMenuCursor
    ld de, Data_003_4645
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_75E6
    ld a, $69
    call QueueSoundEffect
    ld a, [wSubMenuCursor]
    and a, $01
    ld hl, Data_003_4645
    call WriteBCTileAtWordTableEntry_Bank03
    ld a, [wSubMenuCursor]
    and a, $01
    jr nz, Jump_003_75D7
    call PauseMenu_State3_Shared03
    xor a, a
    ld [wPauseMenuScreen], a
    ld hl, wTemp1
    inc [hl]
    ret

Jump_003_75D7::
    ld a, [wModeState]
    bit 3, a
    jr nz, Jump_003_7633
    xor a, a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

Jump_003_75E6::
    bit 1, a
    jr nz, Jump_003_75D7
    call PauseMenu_State3_Shared03
    ret

; entry 3 of the `rst $00` table in PauseMenu_State3_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wPauseMenuScreen
; points at: wTemp1
PauseMenu_State3_Case06_Case03::
Jump_003_75EE:: ; address name
    call PauseMenu_State3_Shared03
    call RunPauseMenuScreen
    ld a, [wPauseMenuScreen]
    cp a, $04
    ret nz
    ld hl, wTemp1
    inc [hl]
    ret

; entry 4 of the `rst $00` table in PauseMenu_State3_Case06
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wTemp1
PauseMenu_State3_Case06_ShowYourProgressHasBeen::
Jump_003_75FF:: ; address name
    call PauseMenu_State3_Shared03
    ld a, $00
    ld [wStringCategory], a
    ld a, $26
    ld [wStringIndex], a ; 'Your progress has been recorded.'
    farcall BeginStringDisplay_Bank37
    ld hl, wTemp1
    inc [hl]
    ret

; entry 5 of the `rst $00` table in PauseMenu_State3_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wModeState
; writes: wTemp0, wTemp1
; points at: wScreenTileBuffer
PauseMenu_State3_Case06_Case05::
Jump_003_7617:: ; address name
    ld a, [wTextFlags]
    or a, a
    jr z, Jump_003_7621
    call PauseMenu_State3_Shared03
    ret

Jump_003_7621::
    ld a, [wModeState]
    bit 3, a
    jr nz, Jump_003_7633
    xor a, a
    ld [wTemp0], a
    ld [wTemp1], a
    ret

; entry 6 of the `rst $00` table in PauseMenu_State3_Case06
; no direct call (reached through a table, a jump or a vector)
PauseMenu_State3_Case06_Case06::
Jump_003_7630:: ; address name
    jp Jump_000_015A

Jump_003_7633::
    ld bc, $0240
    ld hl, wScreenTileBuffer
    ld a, $C3
    call FillBytes
    call CopyTileBufferToBGMap
    ld a, $06
    ld [wTemp1], a
    ret

; only called from routines of PauseMenu_State3 (E-0098)
; 7 call sites from 6 routines (e.g. PauseMenu_State3_Case06_Case05, PauseMenu_State3_Case06_ShowYourProgressHasBeen, PauseMenu_State3_Case06_Case03, PauseMenu_State3_Case06_Case02, ...)
; reads: wBattlerRecords, wTitleByte0A
; writes: rRAMG, rRAMB, hSpriteSetIndex, hSpriteSubIndex, hSpriteTileOffset, hSpriteAttrXor, hSpriteOriginX, hSpriteOriginXHi, ...
PauseMenu_State3_Shared03::
Func_003_7647:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, $01
    ld [rRAMB], a
    ld a, [wBattlerRecords]
    or a, a
    jr z, Jump_003_7689
    ld a, [wTitleByte0A]
    or a, a
    jr z, Jump_003_7689
    ld a, $29
    ldh [hSpriteSetIndex], a
    xor a, a
    ldh [hSpriteSubIndex], a
    ldh [hSpriteTileOffset], a
    ldh [hSpriteAttrXor], a
    ld hl, $0080
    ld a, l
    ldh [hSpriteOriginX], a
    ld a, h
    ldh [hSpriteOriginXHi], a
    ld hl, $0030
    ld a, l
    ldh [hSpriteOriginY], a
    ld a, h
    ldh [hSpriteOriginYHi], a
    xor a, a
    ld [rRAMB], a
    xor a, a
    ld [rRAMG], a
    farcall DrawMetaSprite
    ret

Jump_003_7689::
    xor a, a
    ld [rRAMB], a
    xor a, a
    ld [rRAMG], a
    ret

; clears the screen tile buffer (ClearScreenTileBuffer_Bank03) and copies block $21 into it (CopyBlockToTileBuffer, E = $21) (E-0101)
; 4 call sites from 4 routines (e.g. PauseMenu_State4_Sub01_Case03, PauseMenu_State3_Case00_Case00, LoadScreenBlock21WithCursor, PauseMenu_State3_Case04_LoadScreenBlock21AndStep)
LoadScreenBlock21::
Func_003_7692:: ; address name
    call ClearScreenTileBuffer_Bank03
    ld e, $21
    farcall CopyBlockToTileBuffer
    ret

; LoadScreenBlock21, then writes tile $BC at MenuCursorPositions_Bank03[wC46D & 7] in the buffer (WriteBCTileToScreenBufferAtTableEntry_Bank03) (E-0101)
; 4 call sites from 4 routines (e.g. BuildScreenBlocks21To23, PauseMenu_State3_Case02_Case00_LoadScreenBlock21WithCursor, LoadScreenBlock21CursorAnd2C, PauseMenu_State3_Shared05)
; reads: wMenuSelectedMember
LoadScreenBlock21WithCursor::
Func_003_769E:: ; address name
    call LoadScreenBlock21
    ld a, [wMenuSelectedMember]
    and a, $07
    ld hl, MenuCursorPositions_Bank03
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ret

; loads block $21 with its cursor and block $23, adds block $22 when Func_003_7978 returns NZ, then runs Func_003_7A58 (E-0122)
; 2 call sites from 2 routines (e.g. BuildScreenBlocks21To24, PauseMenu_State3_Case01_Case00)
BuildScreenBlocks21To23::
Func_003_76AD:: ; address name
    call LoadScreenBlock21WithCursor
    ld e, $23
    farcall CopyBlockToTileBuffer
    call BuildScreenBlocks21To23_Sub01
    jr z, Jump_003_76C5
    ld e, $22
    farcall CopyBlockToTileBuffer

Jump_003_76C5::
    call ComputeMenuPagesForPauseListCountItems
    ret

; builds blocks $21-$23 and copies block $24 (E-0122)
; 4 call sites from 4 routines (e.g. PauseMenu_State3_Case01_Case0E, BuildScreenBlocks21To25WithCursor, PauseMenu_State3_Shared04, PauseMenu_State3_Case01_Case02)
BuildScreenBlocks21To24::
Func_003_76C9:: ; address name
    call BuildScreenBlocks21To23
    ld e, $24
    farcall CopyBlockToTileBuffer
    ret

; only called from routines of PauseMenu_State3 (E-0098)
; 3 call sites from 3 routines (e.g. PauseMenu_State3_Case01_PauseMenu_State3_Shared04AndStep, PauseMenu_State3_Case01_ToPauseMenu_State3_Shared04AndStep_Case07, PauseMenu_State3_Case01_ToPauseMenu_State3_Shared04AndStep)
; reads: wSubMenuCursor
PauseMenu_State3_Shared04::
Func_003_76D5:: ; address name
    call BuildScreenBlocks21To24
    call FillTilesFromRequest
    ld e, $10
    farcall CopyBlockToTileBuffer
    ld a, [wSubMenuCursor]
    and a, $07
    ld hl, Data_003_4633
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ld hl, vBGMap0 + $80
    ld de, wScreenTileBuffer + $80
    ld bc, $0609
    call CopyRectToBGMap
    ld hl, vBGMap0 + $1A0
    ld de, wWindowTileBuffer + $38
    ld bc, $1405
    call CopyRectToBGMap
    ret

; builds blocks $21-$24, draws the cursor for wC46F & 7 and copies blocks $25 and $10 (E-0122)
; 1 call site from 1 routine (e.g. PauseMenu_State3_Case01_Case0D)
; reads: wSubMenuCursor
BuildScreenBlocks21To25WithCursor::
Func_003_7707:: ; address name
    call BuildScreenBlocks21To24
    ld a, [wSubMenuCursor]
    and a, $07
    ld hl, Data_003_4633
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ld e, $25
    farcall CopyBlockToTileBuffer
    ld e, $10
    farcall CopyBlockToTileBuffer
    ret

; only called from PauseMenu_State3_Case02_Case00 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_State3_Case02_Case00_Sub01AndStep)
PauseMenu_State3_Case02_Case00_LoadScreenBlock21WithCursor::
Func_003_7726:: ; address name
    call LoadScreenBlock21WithCursor
    ld hl, TileCopyDestList_03_7B9F
    ld de, TileCopySrcList_03_7BAF
    call PauseMenu_State3_Case02_Case00_Sub01_Sub01
    ld e, $26
    farcall CopyBlockToTileBuffer
    ld e, $27
    farcall CopyBlockToTileBuffer
    ret

; LoadScreenBlock21WithCursor, then block $2C (E-0114)
; 1 call site from 1 routine (e.g. PauseMenu_State3_Case03_LoadScreenBlock21CursorAnd2CAndStep)
LoadScreenBlock21CursorAnd2C::
Func_003_7743:: ; address name
    call LoadScreenBlock21WithCursor
    ld e, $2C
    farcall CopyBlockToTileBuffer
    ret

; only called from routines of PauseMenu_State3 (E-0098)
; 2 call sites from 2 routines (e.g. PauseMenu_State3_Case04_PauseMenu_State3_Shared05, PauseMenu_State3_Case04_Case00)
PauseMenu_State3_Shared05::
Func_003_774F:: ; address name
    call LoadScreenBlock21WithCursor
    ld e, $29
    farcall CopyBlockToTileBuffer

; copies screen block $28 into the tile buffer (CopyBlockToTileBuffer) (E-0114)
; 1 call site from 1 routine (e.g. PauseMenu_State3_Shared01)
LoadScreenBlock28::
Func_003_775A:: ; address name
    ld e, $28
    farcall CopyBlockToTileBuffer
    ret

; copies screen block $2D into the tile buffer (E-0114)
; 1 call site from 1 routine (e.g. PauseMenu_State3_Case05_Case00)
LoadScreenBlock2D::
Func_003_7763:: ; address name
    ld e, $2D
    farcall CopyBlockToTileBuffer
    ret

; only called from PauseMenu_State3_Case06_Case00 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_State3_Case06_ShowMaster)
; reads: wMenuSelectedMember
PauseMenu_State3_Case06_Case00_Sub01::
Func_003_776C:: ; address name
    ld e, $2A
    farcall CopyBlockToTileBuffer
    ld a, [wMenuSelectedMember]
    and a, $07
    ld hl, MenuCursorPositions_Bank03
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    call FillTilesFromRequest
    ld e, $10
    farcall CopyBlockToTileBuffer
    farcall DecompressA4GraphicsAndContinue
    ret

; copies screen block $2B into the tile buffer (E-0114)
; 2 call sites from 2 routines (e.g. PauseMenu_State3_Case06_Case01, PauseMenu_Items_Case02_Case1C)
LoadScreenBlock2B::
Func_003_7791:: ; address name
    ld e, $2B
    farcall CopyBlockToTileBuffer
    ret

; only called from routines of PauseMenu_State3 (E-0098)
; 3 call sites from 3 routines (e.g. PauseMenu_State3_Case01_Case0E, PauseMenu_State3_Case01_Case01, PauseMenu_State3_Case01_Case00)
; reads: wMenuPage, wPauseListCount
; writes: wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi
; points at: wTextBuf0
PauseMenu_State3_Shared06::
Func_003_779A:: ; address name
    ld hl, $0C01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, [wMenuPage]
    ld b, a
    add a, a
    add a, a
    ld de, wWorkBuf + $A
    add a, e
    ld e, a
    jr nc, Jump_003_77B3
    inc d

Jump_003_77B3::
    ld bc, $0400
    ld a, [wPauseListCount]
    or a, a
    jr nz, Jump_003_77E0
    ld a, $08
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    ld hl, vTiles2 + $440
    ld de, $0C01
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    farcall ShowString_Bank08
    ld bc, $0301
    ld de, wWorkBuf + $B

Jump_003_77E0::
    push bc
    push de
    ld a, c
    ld hl, Data_003_78B9
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, [de]
    call PauseMenu_State3_Shared06_Sub01
    cp a, $FF
    jr z, Jump_003_7851
    and a, $3F
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    ld a, [hl]
    bit 7, a
    jr nz, Jump_003_783B
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    cp a, $FE
    jr z, Jump_003_781C
    ld a, [de]

Jump_003_781C::
    ld de, wTextBuf0
    call WriteKeyNameToDE
    ld a, $5B
    ld [de], a
    inc de
    ld a, $F0
    ld [de], a
    ld a, $08
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a
    farcall ShowString_Bank08
    jr Jump_003_7861

Jump_003_783B::
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    and a, $3F
    ld [wStringIndex], a
    ld a, $06
    ld [wStringCategory], a
    farcall ShowString_Bank09
    jr Jump_003_7861

Jump_003_7851::
    ld a, $06
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    farcall ShowString_Bank09

Jump_003_7861::
    pop de
    pop bc
    inc de
    inc c
    dec b
    jp nz, Jump_003_77E0
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

; only called from PauseMenu_State3_Shared06 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_State3_Shared06)
PauseMenu_State3_Shared06_Sub01::
Func_003_7880:: ; address name
    push af
    cp a, $FF
    jr z, Jump_003_7899
    and a, $3F
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
    and a, $F0
    cp a, $F0

Jump_003_7899::
    push af
    ld a, c
    ld hl, Data_003_78C3
    add a, a
    add_a_to_hl
    deref_hl
    pop af
    jr z, Jump_003_78B2
    bit 6, a
    jr z, Jump_003_78B2
    ld a, $1D
    jr Jump_003_78B4

Jump_003_78B2::
    ld a, $C3

Jump_003_78B4::
    call WriteVRAMByte
    pop af
    ret

; address loaded by PauseMenu_State3_Shared06
Data_003_78B9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $94, $00, $95, $C0, $95, $80, $96, $40, $97

; address loaded by PauseMenu_State3_Shared06_Sub01
Data_003_78C3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $46, $99, $86, $99, $C6, $99, $06, $9A

; only called from routines of PauseMenu_State3 (E-0098)
; 3 call sites from 2 routines (e.g. PauseMenu_State3_Case01_Case01, PauseMenu_State3_Case01_Case00)
; reads: wPauseListCount, wMenuPage, wMenuCursor
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringIndex, wStringCategory
; points at: wTextBuf0
PauseMenu_State3_Shared07::
Func_003_78CB:: ; address name
    ld a, [wPauseListCount]
    or a, a
    ret z
    ld hl, vTiles2 + $200
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0C03
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, [wMenuPage]
    ld b, a
    add a, a
    add a, a
    ld b, a
    ld hl, wWorkBuf + $A
    add_a_to_hl
    ld a, [wMenuCursor]
    and a, $07
    add_a_to_hl
    ld a, [hl]
    and a, $3F
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $C7
    ld h, a
    bit 7, [hl]
    jr nz, Jump_003_794D
    ld de, wWorkBuf + $A
    ld a, [wMenuPage]
    ld b, a
    add a, a
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_003_7921
    inc d

Jump_003_7921::
    ld a, [wMenuCursor]
    and a, $03
    add a, e
    ld e, a
    jr nc, Jump_003_792B
    inc d

Jump_003_792B::
    ld a, [de]
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
    cp a, $FE
    jr z, Jump_003_7949
    ld a, [de]
    ld de, wTextBuf0
    call WriteKeyNameToDE
    ld a, $0E
    jr Jump_003_7953

Jump_003_7949::
    ld a, $0D
    jr Jump_003_7953

Jump_003_794D::
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    and a, $3F

Jump_003_7953::
    ld [wStringIndex], a
    ld a, $07
    ld [wStringCategory], a
    farcall ShowString_Bank09
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

; only called from BuildScreenBlocks21To23 (E-0047)
; 1 call site from 1 routine (e.g. BuildScreenBlocks21To23)
; reads: wGameFlags836, wPauseListCount
; writes: wPauseListCount
; points at: wKeyList
BuildScreenBlocks21To23_Sub01::
Func_003_7978:: ; address name
    ld hl, wWorkBuf + $A
    ld bc, $0020
    ld a, $FF
    call FillBytes
    ld hl, wWorkBuf + $A
    ld de, wKeyList
    ld bc, $2000
    xor a, a
    ld [wPauseListCount], a
    ld a, [wGameFlags836]
    bit 1, a
    jr nz, Jump_003_79F6

Jump_003_7997::
    ld a, [de]
    cp a, $FF
    jr z, Jump_003_79B4
    push de
    ld a, e
    add a, $03
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, [de]
    pop de
    bit 7, a
    jr nz, Jump_003_79B4
    ld [hl], c
    inc hl
    ld a, [wPauseListCount]
    inc a
    ld [wPauseListCount], a

Jump_003_79B4::
    inc c
    ld a, e
    add a, $04
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, Jump_003_7997
    ld de, wKeyList
    ld bc, $2000

Jump_003_79C6::
    ld a, [de]
    or a, a
    jr z, Jump_003_79E8
    cp a, $FF
    jr z, Jump_003_79E8
    push de
    ld a, e
    add a, $03
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, [de]
    pop de
    bit 7, a
    jr z, Jump_003_79E8
    ld [hl], c
    set 7, [hl]
    inc hl
    ld a, [wPauseListCount]
    inc a
    ld [wPauseListCount], a

Jump_003_79E8::
    inc c
    ld a, e
    add a, $04
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, Jump_003_79C6
    jr Jump_003_7A53

Jump_003_79F6::
    ld a, [de]
    or a, a
    jr z, Jump_003_7A18
    cp a, $FF
    jr z, Jump_003_7A18
    push de
    ld a, e
    add a, $03
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, [de]
    pop de
    bit 7, a
    jr z, Jump_003_7A18
    ld [hl], c
    set 7, [hl]
    inc hl
    ld a, [wPauseListCount]
    inc a
    ld [wPauseListCount], a

Jump_003_7A18::
    inc c
    ld a, e
    add a, $04
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, Jump_003_79F6
    ld de, wKeyList
    ld bc, $2000

Jump_003_7A2A::
    ld a, [de]
    cp a, $FF
    jr z, Jump_003_7A47
    push de
    ld a, e
    add a, $03
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, [de]
    pop de
    bit 7, a
    jr nz, Jump_003_7A47
    ld [hl], c
    inc hl
    ld a, [wPauseListCount]
    inc a
    ld [wPauseListCount], a

Jump_003_7A47::
    inc c
    ld a, e
    add a, $04
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, Jump_003_7A2A

Jump_003_7A53::
    ld a, [wPauseListCount]
    or a, a
    ret

; from wD0C7 items computes wMenuPageCount (4 rows per page, up to 8 pages), wMenuLastPageRows and wMenuRowCount for wMenuPage, and draws the page indicator (E-0128)
; 2 call sites from 2 routines (e.g. BuildScreenBlocks21To23, PauseMenu_State3_Case01_Case01)
; reads: wPauseListCount, wMenuPage, wMenuLastPageRows, wMenuPageCount
; writes: wMenuLastPageRows, wMenuPageCount, wMenuRowCount, wWindowTileBuffer
ComputeMenuPagesForPauseListCountItems::
Func_003_7A58:: ; address name
    ld a, [wPauseListCount]
    or a, a
    jr z, Jump_003_7A80
    cp a, $05
    jr c, Jump_003_7A84
    cp a, $09
    jr c, Jump_003_7A88
    cp a, $0D
    jr c, Jump_003_7A8E
    cp a, $11
    jr c, Jump_003_7A94
    cp a, $15
    jr c, Jump_003_7A9A
    cp a, $19
    jr c, Jump_003_7AA0
    cp a, $1D
    jr c, Jump_003_7AA6
    ld b, $08
    sub a, $1C
    jr Jump_003_7AAC

Jump_003_7A80::
    ld b, $00
    jr Jump_003_7AAC

Jump_003_7A84::
    ld b, $01
    jr Jump_003_7AAC

Jump_003_7A88::
    ld b, $02
    sub a, $04
    jr Jump_003_7AAC

Jump_003_7A8E::
    ld b, $03
    sub a, $08
    jr Jump_003_7AAC

Jump_003_7A94::
    ld b, $04
    sub a, $0C
    jr Jump_003_7AAC

Jump_003_7A9A::
    ld b, $05
    sub a, $10
    jr Jump_003_7AAC

Jump_003_7AA0::
    ld b, $06
    sub a, $14
    jr Jump_003_7AAC

Jump_003_7AA6::
    ld b, $07
    sub a, $18
    jr Jump_003_7AAC

Jump_003_7AAC::
    ld [wMenuLastPageRows], a
    ld a, b
    ld [wMenuPageCount], a
    ld a, [wMenuPage]
    inc a
    cp a, b
    jr nz, Jump_003_7ABF
    ld a, [wMenuLastPageRows]
    jr Jump_003_7AC1

Jump_003_7ABF::
    ld a, $04

Jump_003_7AC1::
    ld [wMenuRowCount], a
    ld a, [wMenuPageCount]
    cp a, $02
    ret c
    add a, $E0
    ld [wWindowTileBuffer + $C9], a
    ld a, [wMenuPage]
    inc a
    add a, $E0
    ld [wWindowTileBuffer + $C7], a
    ld a, $C5
    ld [wWindowTileBuffer + $C6], a
    ld a, $BE
    ld [wWindowTileBuffer + $C8], a
    ld a, $C6
    ld [wWindowTileBuffer + $CA], a
    ret

; shows string 2 of category 0 (ShowString_Bank09) in a window at vTiles1 + $6E0 with size $1003, then restores the default window (vTiles1, $1202) (E-0120)
; 1 call site from 1 routine (e.g. PauseMenu_State4_Sub01_Case03)
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wStringCategory, wStringIndex
ShowString2Bank09InWindowThenDefault::
Func_003_7AE8:: ; address name
    ld hl, vTiles1 + $6E0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1003
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    ld a, $00
    ld [wStringCategory], a
    ld a, $02
    ld [wStringIndex], a ; 'RJadlnoprtuxy-fWATUCHPMDcgimhw Dcgimh'
    farcall ShowString_Bank09
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

; only called from PauseMenu_State3_Case05_Case00 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_State3_Case05_Case00)
; writes: rRAMG, rRAMB, wWorkBuf
; points at: sRecords, wWorkBuf
PauseMenu_State3_Case05_Case00_Sub01::
Func_003_7B25:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    xor a, a
    ld [wWorkBuf], a
    ld [wWorkBuf + $1], a
    ld de, sRecords
    ld b, $1E

Jump_003_7B3B::
    ld a, [de]
    cp a, $01
    jr nz, Jump_003_7B51
    ld hl, $006E
    add hl, de
    ld a, [hl]
    or a, a
    jr z, Jump_003_7B4D
    ld hl, wWorkBuf + $1
    jr Jump_003_7B50

Jump_003_7B4D::
    ld hl, wWorkBuf

Jump_003_7B50::
    inc [hl]

Jump_003_7B51::
    ld a, e
    add a, $A5
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, Jump_003_7B3B
    xor a, a
    ld [rRAMG], a
    ret

; fills the tiles at vTiles2 + $1E0 (size $0162) through FillTilesFromRequest, preserving the window settings wC52D-wC530 (E-0121)
; 1 call site from 1 routine (e.g. PauseMenu_State3_Case00_Case00)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
FillTiles21E0PreservingWindow::
Func_003_7B61:: ; address name
    ld a, [wTextWindowTileLo]
    ld l, a
    ld a, [wTextWindowTileHi]
    ld h, a
    push hl
    ld a, [wTextWindowRows]
    ld l, a
    ld a, [wTextWindowWidth]
    ld h, a
    push hl
    ld hl, vTiles2 + $1E0
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $6201
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
    pop hl
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ret

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: VRAM destinations, then $FFxx
TileCopyDestList_03_7B9F::
Data_003_7B9F:: ; address name
    dw vTiles2 + $50, vTiles2 + $60, vTiles2 + $70, vTiles2 + $80, vTiles2 + $90, vTiles2 + $A0, vTiles2 + $B0, rIE ; entry 0

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: bank-$1F tile sources
TileCopySrcList_03_7BAF::
Data_003_7BAF:: ; address name
    dw $40E0, $4370, $42B0, $42D0, $4310, $42C0, $43B0, $FFFF ; entry 0

; only called from PauseMenu_State3_Case02_Case00_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_State3_Case02_Case00_LoadScreenBlock21WithCursor)
PauseMenu_State3_Case02_Case00_Sub01_Sub01::
Func_003_7BBF:: ; address name
    ld b, $00

Jump_003_7BC1::
    push bc
    push hl
    push de
    ld a, b
    add a, a
    add_a_to_hl
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_003_7BF1
    ld e, a
    ld a, [hl]
    ld h, a
    ld l, e
    pop de
    push de
    push hl
    ld l, e
    ld h, d
    ld a, b
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    pop hl
    pop bc
    inc b
    jr Jump_003_7BC1

Jump_003_7BF1::
    pop de
    pop hl
    pop bc
    ret

; address loaded by PauseMenu_State4
Data_003_7BF5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $11, $20, $FF, $7F, $7D, $3D
    ds $405, $00
