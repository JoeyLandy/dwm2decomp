SECTION "Bank 03", ROMX[$4000], BANK[$03]
    db $03

; start-up for wGameMode = 2; forcing this mode on the emulator shows: monster status panel (incomplete when forced) (E-0029)
; 1 call site from 1 routine (e.g. RunGameModeInit_Case02)
; writes: wDataBankSave, wC554, wC555
GameMode2_Init::
Func_003_4001:: ; address name
    xor a, a
    ld [wDataBankSave], a
    ld hl, vBGMap0 + $1C1
    ld a, l
    ld [wC554], a
    ld a, h
    ld [wC555], a
    ld a, $01
    jp Jump_000_077A

; per-frame routine for wGameMode = 2
; 1 call site from 1 routine (e.g. RunGameModeUpdate_Case02)
; reads: wC5DD, wModeState, wIsCGB, hScrollY, hScrollX, wC933, wCC37, wSpriteSlotCount
; writes: wSpriteSlotCount, wC526, rVBK, hScrollX, hScrollY, wC46D, wC46E, wC46F, ...
; points at: wBGPaletteBuffer, wScreenTileBuffer, wC5DD, wC0A0, wD09D
GameMode2_Update::
Func_003_4015:: ; address name
    ld a, [wC5DD]
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
    ld a, [wC5DD]
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
    ld [wC526], a
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
    ld hl, wC5DD
    inc [hl]
    ret

Jump_003_40BE::
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld hl, vTiles2
    ld de, $1007
    call FillTilesRequest
    ld hl, wC0A0
    ld bc, $0020
    xor a, a
    call FillBytes
    ld hl, wD09D
    ld bc, $0028
    xor a, a
    call FillBytes
    xor a, a
    ld [wC46D], a
    ld [wC46E], a
    ld [wC46F], a
    ld [wC470], a
    ld [wC471], a
    ld [wC472], a
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    call PauseMenu_State4_Sub01
    xor a, a
    ld [rRAMG], a
    xor a, a
    ld [wD095], a
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
    ld [wC526], a
    call UploadBGPalettes

Jump_003_414C::
    ld a, $80
    ld [wC5DD], a
    xor a, a
    ld [wDataBankSave], a
    ld hl, vBGMap0 + $1C0
    ld a, l
    ld [wC554], a
    ld a, h
    ld [wC555], a
    ld de, $0025
    call TestFlagBit
    ret c
    ld de, $019F
    call TestFlagBit
    ret nc
    ld a, [wC933]
    ld [wC6FD], a
    ld de, $0025
    call SetFlagBit
    ld a, [wCC37]
    set 6, a
    ld [wCC37], a
    ld a, $02
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wC8F4], a
    ld [wC8F9], a
    ld a, $60
    ldh [hPlayerX], a
    ld [wC8F0], a
    ld [wC8F5], a
    ld [wC8FA], a
    ld a, $50
    ldh [hPlayerY], a
    ld [wC8F1], a
    ld [wC8F6], a
    ld [wC8FB], a
    ld a, [wSpriteSlotCount]
    ld [wC83A], a
    ld a, $00
    ld [wSpriteSlots], a
    ld a, $01
    ld [wCB80], a
    ld a, $05
    ld [wCB81], a
    ld a, $00
    ld [wCB82], a
    ld a, $40
    ld [wCB83], a
    ld [wCB8A], a
    ld a, $30
    ld [wCB84], a
    ld [wCB8B], a
    ld a, $05
    ld [wCB85], a
    ld a, $00
    ld [wCB86], a
    ld a, $50
    ld [wCB87], a
    ld a, $62
    ld [wCB88], a
    xor a, a
    ld [wCB89], a
    xor a, a
    ld [wCB8C], a
    ld a, $01
    ld [wCB8D], a
    ld a, $02
    ld [wCB8E], a
    ld a, $E0
    ld [wCB93], a
    ld [wCB9A], a
    ld [wCBA3], a
    ld [wCBAA], a
    ret

; only called from PauseMenu_State4 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_State4)
; reads: wModeState
PauseMenu_State4_Sub01::
Func_003_4208:: ; address name
    ld a, [wModeState]
    and a, $07
    rst $00
    dw Func_003_4208_Case00
    dw Func_003_4208_Case01
    dw Func_003_4208_Case02
    dw Func_003_4208_Case03
    dw Func_003_4208_Case01

; entry 0 of the `rst $00` table in Func_003_4208
; no direct call (reached through a table, a jump or a vector)
; reads: wC6FD
; writes: wMenuRowCount, wMenuPageCount, wMenuPage
Func_003_4208_Case00::
Jump_003_4218:: ; address name
    call LoadBlankedBlocks00To03WithCursor
    call DecompressMenuTilesTo16E0
    farcall LoadTilesForPartyRecords
    ld a, [wC6FD]
    ld [wMenuRowCount], a
    ld a, $00
    ld [wMenuPageCount], a
    ld a, $00
    ld [wMenuPage], a
    ret

; entry 1 of the `rst $00` table in Func_003_4208
; no direct call (reached through a table, a jump or a vector)
Func_003_4208_Case01::
Jump_003_4235:: ; address name
    call ResetInventoryMenuToFirstPage
    call BuildInventoryScreenBase
    call ShowString0Bank09AtTiles16E0ThenItemDescription
    ret

; entry 2 of the `rst $00` table in Func_003_4208
; no direct call (reached through a table, a jump or a vector)
; writes: wMenuPageCount, wMenuPage, wC0A7, wC46D, wC46E, wC46F
Func_003_4208_Case02::
Jump_003_423F:: ; address name
    call LoadScreenBlocks1CAnd0C
    call ShowString1Bank09AtTiles16E0ThenDetails
    xor a, a
    ld [wMenuPageCount], a
    ld [wMenuPage], a
    ld [wC0A7], a
    ld [wC46D], a
    ld [wC46E], a
    ld [wC46F], a
    ret

; entry 3 of the `rst $00` table in Func_003_4208
; no direct call (reached through a table, a jump or a vector)
; reads: wModeState
; writes: wC0A0
Func_003_4208_Case03::
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
    ld [wC0A0], a
    jr Jump_003_427D

Jump_003_4277::
    ld a, $06
    ld [wC0A0], a
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
; 36 call sites from 33 routines (e.g. PauseMenu_State4, Func_003_4FBB_Case02, ExitPauseMenuToField, PauseMenu_State3_Case00_Case00, ...)
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
; 4 call sites from 2 routines (e.g. DrawRecordMonsterPictureForWC46D, Func_003_4FBB_Case02)
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
    farcall RunFunc5E85Twice
    call LoadRecordListNameTiles
    ret

; clears the object flag bits, saves the player position to wC8C8/9, whitens the CGB palettes, blanks the screen and returns to game mode 1 through Func_002_4628 (E-0125)
; 12 call sites from 12 routines (e.g. PauseMenu_Main_Case04, PauseMenu_State3_Case00_Case01, PauseMenu_State3_Case01_Case06, PauseMenu_State3_Case01_Case01, ...)
; reads: hPlayerX, hPlayerY, wIsCGB
; writes: wC8C8, wC8C9, wC8CA, rRAMG, wC526, wC5E0, wGameMode
; points at: wBGPaletteBuffer, wScreenTileBuffer, wC5E0
ExitPauseMenuToField::
Func_003_4339:: ; address name
    call ClearBit1OfPlayerAndObjectFlags_Bank03
    ldh a, [hPlayerX]
    ld [wC8C8], a
    ldh a, [hPlayerY]
    ld [wC8C9], a
    xor a, a
    ld [wC8CA], a
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
    ld [wC526], a
    call UploadBGPalettes

Jump_003_4367::
    ld hl, wScreenTileBuffer
    ld bc, $0240
    ld a, $C3
    call FillBytes
    call CopyTileBufferToBGMap
    ld hl, wC5E0
    inc [hl]
    farcall Func_002_4628
    xor a, a
    ld [wC5E0], a
    ld a, $01
    ld [wGameMode], a
    ret

; clears bit 1 of hFF8C and of the flags byte of the five objects at wCB8C, wCB9C ... (stride $10) (E-0121)
; 1 call site from 1 routine (e.g. ExitPauseMenuToField)
; reads: hFF8C
; writes: hFF8C
; points at: wCB8C
ClearBit1OfPlayerAndObjectFlags_Bank03::
Func_003_4389:: ; address name
    ldh a, [hFF8C]
    and a, $FD
    ldh [hFF8C], a
    ld hl, wCB8C
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
; 2 call sites from 2 routines (e.g. WithSRAMRun4E02_Sub01_Sub03, WithSRAMRun4E02_Sub01_Sub02)
; reads: wC52D, wC52E, wC52F, wC530
; writes: wStringCategory, wStringIndex, wC52D, wC52E, wC52F, wC530
DerefWordTableEntryA_Bank03::
Func_003_43C3:: ; address name
    add a, a
    add_a_to_hl
    deref_hl

; wStringCategory = 8, wStringIndex = 5, then falls into the window setup and display (E-0122)
; 3 call sites from 3 routines (e.g. PauseMenu_State3_Case05_Case00, WithSRAMDraw4ACEAnd4BE8_Sub01, WithSRAMRun4E02_Sub01)
; reads: wC52D, wC52E, wC52F, wC530
; writes: wStringCategory, wStringIndex, wC52D, wC52E, wC52F, wC530
SelectString5Category8ThenShow::
Func_003_43CC:: ; address name
    ld a, $08
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a

; only called from WithSRAMRun4E02_Sub01 (E-0047)
; 3 call sites from 1 routine (e.g. WithSRAMRun4E02_Sub01)
; reads: wC52D, wC52E, wC52F, wC530
; writes: wC52D, wC52E, wC52F, wC530
WithSRAMRun4E02_Sub01_Sub01::
Func_003_43D6:: ; address name
    ld de, $0501

; saves the string window wC52D-wC530, sets the tile destination to HL and the size to DE, far-calls ShowString_Bank08, then restores the window (restores in a different register order from the bank-$31 copy, same effect) (E-0067) (the same 59 bytes appear in 2 banks)
; 11 call sites from 8 routines (e.g. ShowSelectedItemDescription, PauseMenu_State3_Shared02, PauseMenu_Skills_Shared02, Func_003_5AA7, ...)
; reads: wC52D, wC52E, wC52F, wC530
; writes: wC52D, wC52E, wC52F, wC530
ShowStringBank08AtTilesHL_Bank03::
Func_003_43D9:: ; address name
    ld a, [wC52D]
    ld c, a
    ld a, [wC52E]
    ld b, a
    push bc
    ld a, [wC52F]
    ld c, a
    ld a, [wC530]
    ld b, a
    push bc
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, e
    ld [wC52F], a
    ld a, d
    ld [wC530], a
    farcall ShowString_Bank08
    pop bc
    ld a, c
    ld [wC52F], a
    ld a, b
    ld [wC530], a
    pop bc
    ld a, c
    ld [wC52D], a
    ld a, b
    ld [wC52E], a
    ret

; copies 10 bytes from HL to wC130 and writes $F0 after them; HL advances; BC kept (E-0101)
; 4 call sites from 4 routines (e.g. PauseMenu_State3_Case05_Case00, WithSRAMDraw4ACEAnd4BE8_Sub01, WithSRAMRun4E02_Sub01_Sub03, WithSRAMRun4E02_Sub01_Sub02)
; points at: wC130
CopyTenBytesToWC130::
Func_003_4414:: ; address name
    ld de, wC130
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
; reads: wC46D
DrawMenuCursorTileInBuffer::
Func_003_451C:: ; address name
    ld a, [wC46D]
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
; 15 call sites from 14 routines (e.g. LoadScreenBlock21WithCursor, BuildScreenBlocks21To25WithCursor, PauseMenu_State3_Shared04, PauseMenu_State3_Case04_Case03, ...)
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
    db $FA, $2D, $C5, $4F, $FA, $2E, $C5, $47, $C5, $FA, $2F, $C5, $4F, $FA, $30, $C5
    db $47, $C5, $7D, $EA, $2D, $C5, $7C, $EA, $2E, $C5, $7B, $EA, $2F, $C5, $7A, $EA
    db $30, $C5, $21, $2B, $40, $06, $08, $D7, $E1, $7D, $EA, $2F, $C5, $7C, $EA, $30
    db $C5, $E1, $7D, $EA, $2D, $C5, $7C, $EA, $2E, $C5, $C9

; only called from GameMode2_Update (E-0047)
; 1 call site from 1 routine (e.g. GameMode2_Update)
; reads: wCE9B, wPlayHoursLo, wPlayHoursHi, wPlayMinutes, wCE9C, wCE9D
; writes: wCE9B, wCE9C, wCE9D
; points at: wPlayFrames
GameMode2_Update_Sub01::
Func_003_4596:: ; address name
    ld a, [wCE9B]
    inc a
    cp a, $3C
    jr nc, Jump_003_45A3
    ld [wCE9B], a
    jr Jump_003_45C9

Jump_003_45A3::
    xor a, a
    ld [wCE9B], a
    ld a, [wCE9C]
    inc a
    cp a, $3C
    jr nc, Jump_003_45B4
    ld [wCE9C], a
    jr Jump_003_45C9

Jump_003_45B4::
    xor a, a
    ld [wCE9C], a
    ld a, [wCE9D]
    inc a
    cp a, $3C
    jr nc, Jump_003_45C5
    ld [wCE9D], a
    jr Jump_003_45C9

Jump_003_45C5::
    xor a, a
    ld [wCE9D], a

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
MenuCursorPositions_Bank03:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_003_460B:: ; address name
    db $61, $98, $A1, $98, $E1, $98, $21, $99, $61, $99, $A1, $99

Data_003_4617:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $29, $98, $69, $98, $A9, $98, $E9, $98

Data_003_461F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A1, $98, $E1, $98

Data_003_4623:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $99, $61, $99

Data_003_4627:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $99, $41, $99

Data_003_462B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $47, $99, $87, $99, $C7, $99, $07, $9A

Data_003_4633:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $61, $98, $A1, $98

Data_003_4637:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $4A, $99, $8A, $99, $CA, $99, $0A, $9A

Data_003_463F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $64, $98, $A4, $98, $E4, $98

Data_003_4645:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2F, $99, $6F, $99

Data_003_4649:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $82, $99, $84, $99, $86, $99, $88, $99, $8A, $99, $8C, $99, $8E, $99, $90, $99

; runs the routine for wC0A4 (jump table of four screens) (E-0122)
; 2 call sites from 2 routines (e.g. PauseMenu_State3_Case06_Case03, PauseMenu_Items_Case02_Case1E)
; reads: wC0A4
RunWC0A4Screen::
Func_003_4659:: ; address name
    ld a, [wC0A4]
    rst $00
    dw RunWC0A4Screen_Case00
    dw RunWC0A4Screen_Case01
    dw RunWC0A4Screen_Case02
    dw RunWC0A4Screen_Case03

; entry 0 of the `rst $00` table in RunWC0A4Screen
; no direct call (reached through a table, a jump or a vector)
; reads: wC608
; writes: wMenuLastPageRows, wC8C3, wC8C4
; points at: wC0A4
RunWC0A4Screen_Case00::
Jump_003_4665:: ; address name
    ld a, [wC608]
    ld [wMenuLastPageRows], a
    xor a, a
    ld [wC8C3], a
    ld [wC8C4], a
    ld hl, wC0A4
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunWC0A4Screen
; no direct call (reached through a table, a jump or a vector)
; points at: wC0A4
RunWC0A4Screen_Case01::
Jump_003_4677:: ; address name
    ld hl, wC0A4
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunWC0A4Screen
; no direct call (reached through a table, a jump or a vector)
; reads: wC8C3
; points at: wC0A4
RunWC0A4Screen_Case02::
Jump_003_467C:: ; address name
    farcall RunSaveGameSteps_7347
    ld a, [wC8C3]
    bit 7, a
    ret z
    ld hl, wC0A4
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunWC0A4Screen
; no direct call (reached through a table, a jump or a vector)
; points at: wC0A4
RunWC0A4Screen_Case03::
Jump_003_468D:: ; address name
    ld hl, wC0A4
    inc [hl]
    ret

; GameMode2_Update, wModeState 0: the main pause menu: PLAN (Keys, Plan, Text Speed, Re-Order, Info, Journal) and, for the first monster, INFO with its level, ATK, DEF, AGL, INT, WLD, HP and MP (E-0046)
; no direct call (reached through a table, a jump or a vector)
; reads: wDataBankSave, wC0A0, wC0A1
PauseMenu_Main::
Jump_003_4692:: ; address name
    ld a, [wDataBankSave]
    or a, a
    jp nz, Jump_003_4FED
    ld a, [wC0A0]
    rst $00
    dw PauseMenu_Main_Case00
    dw PauseMenu_Main_Case01
    dw PauseMenu_Main_Case02
    dw PauseMenu_Main_Case03
    dw PauseMenu_Main_Case04

; entry 0 of the `rst $00` table in PauseMenu_Main
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A1
PauseMenu_Main_Case00::
Jump_003_46A7:: ; address name
    ld a, [wC0A1]
    rst $00
    dw PauseMenu_Main_Case00_Case00
    dw PauseMenu_Main_Case00_Case01
    dw PauseMenu_Main_Case00_Case02
    dw PauseMenu_Main_Case00_Case03

; entry 0 of the `rst $00` table in PauseMenu_Main_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A4
; points at: wC0A1
PauseMenu_Main_Case00_Case00::
Jump_003_46B3:: ; address name
    ld a, [wC0A4]
    or a, a
    jr nz, Jump_003_46BF
    call LoadBlankedBlocks00To03WithCursor
    call CopyTileBufferToBGMap

Jump_003_46BF::
    ld hl, wC0A1
    inc [hl]

; entry 3 of the `rst $00` table in PauseMenu_Main_Case00
; no direct call (reached through a table, a jump or a vector)
PauseMenu_Main_Case00_Case03::
Jump_003_46C3:: ; address name
    ret

; entry 1 of the `rst $00` table in PauseMenu_Main_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A4
; writes: rRAMG, rRAMB
; points at: wScreenTileBuffer, wC0A1
PauseMenu_Main_Case00_Case01::
Jump_003_46C4:: ; address name
    ld a, [wC0A4]
    or a, a
    jr nz, Jump_003_46CD
    call LoadScreenBlocks00To03

Jump_003_46CD::
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    call DrawRecordMonsterPictureForWC46D
    xor a, a
    ld [rRAMG], a
    call WithSRAMDraw4ACEAnd4B52
    ld hl, vBGMap0
    ld bc, $1412
    ld de, wScreenTileBuffer
    call CopyRectToBGMap
    ld hl, wC0A1
    inc [hl]
    ret

; entry 2 of the `rst $00` table in PauseMenu_Main_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed
; writes: wC0A1, wC0A4, wDataBankSave
; points at: wC46D, wC0A0
PauseMenu_Main_Case00_Case02::
Jump_003_46F1:: ; address name
    ld de, MenuCursorPositions_Bank03
    ld hl, wC46D
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, Jump_003_4706
    xor a, a
    ld [wC0A1], a
    ret

Jump_003_4706::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_471E
    ld a, $69
    call QueueSoundEffect
    ld hl, wC0A0
    inc [hl]
    xor a, a
    ld [wC0A1], a
    ld [wC0A4], a
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
    ld [wC0A1], a
    ret

Jump_003_4734::
    ret

; entry 1 of the `rst $00` table in PauseMenu_Main
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A1
PauseMenu_Main_Case01::
Jump_003_4735:: ; address name
    ld a, [wC0A1]
    rst $00
    dw PauseMenu_Main_Case01_Case00
    dw PauseMenu_Main_Case01_Case01
    dw PauseMenu_Main_Case01_Case02

; entry 0 of the `rst $00` table in PauseMenu_Main_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A4
; points at: wC0A1
PauseMenu_Main_Case01_Case00::
Jump_003_473F:: ; address name
    ld a, [wC0A4]
    or a, a
    jr nz, Jump_003_474B
    call LoadBlankedBlocks00And04To06WithCursor
    call CopyTileBufferToBGMap

Jump_003_474B::
    ld hl, wC0A1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_Main_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A4
; points at: wC1B9, wC0A1
PauseMenu_Main_Case01_Case01::
Jump_003_4750:: ; address name
    ld a, [wC0A4]
    or a, a
    jr nz, Jump_003_4759
    call LoadScreenBlocks00And04To06

Jump_003_4759::
    call WithSRAMDraw4ACEAnd4BE8
    ld hl, vBGMap0 + $21
    ld bc, $1311
    ld de, wC1B9
    call CopyRectToBGMap
    call DecompressRecordSpeciesGraphicsToTiles0
    ld hl, wC0A1
    inc [hl]
    ret

; entry 2 of the `rst $00` table in PauseMenu_Main_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed
; writes: wC0A1, wC0A4, wDataBankSave
; points at: wC46D, wC0A0
PauseMenu_Main_Case01_Case02::
Jump_003_4770:: ; address name
    farcall DrawMetaSpritePartC0
    ld de, MenuCursorPositions_Bank03
    ld hl, wC46D
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, Jump_003_478B
    xor a, a
    ld [wC0A1], a
    ret

Jump_003_478B::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_47A3
    ld a, $69
    call QueueSoundEffect
    ld hl, wC0A0
    inc [hl]
    xor a, a
    ld [wC0A1], a
    ld [wC0A4], a
    ret

Jump_003_47A3::
    bit 1, a
    jr z, Jump_003_47B3
    ld hl, wC0A0
    dec [hl]
    xor a, a
    ld [wC0A1], a
    ld [wC0A4], a
    ret

Jump_003_47B3::
    bit 2, a
    jr z, Jump_003_47C1
    ld a, $01
    ld [wDataBankSave], a
    xor a, a
    ld [wC0A1], a
    ret

Jump_003_47C1::
    ret

; entry 2 of the `rst $00` table in PauseMenu_Main
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A1
PauseMenu_Main_Case02::
Jump_003_47C2:: ; address name
    ld a, [wC0A1]
    rst $00
    dw PauseMenu_Main_Case02_Case00
    dw PauseMenu_Main_Case02_Case01
    dw PauseMenu_Main_Case02_Case02

; entry 0 of the `rst $00` table in PauseMenu_Main_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A4
; points at: wC0A1
PauseMenu_Main_Case02_Case00::
Jump_003_47CC:: ; address name
    ld a, [wC0A4]
    or a, a
    jr nz, Jump_003_47D8
    call LoadBlankedBlocks00_07_08WithCursor
    call CopyTileBufferToBGMap

Jump_003_47D8::
    ld hl, wC0A1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_Main_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A4
; points at: wC1B9, wC0A1
PauseMenu_Main_Case02_Case01::
Jump_003_47DD:: ; address name
    ld a, [wC0A4]
    or a, a
    jr nz, Jump_003_47E6
    call LoadScreenBlocks00_07_08

Jump_003_47E6::
    call WithSRAMShowRecordSpeciesAndSkillNames
    ld hl, vBGMap0 + $21
    ld bc, $1311
    ld de, wC1B9
    call CopyRectToBGMap
    ld hl, wC0A1
    inc [hl]
    ret

; entry 2 of the `rst $00` table in PauseMenu_Main_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed
; writes: wC0A1, wC0A4, wDataBankSave
; points at: wC46D, wC0A0
PauseMenu_Main_Case02_Case02::
Jump_003_47FA:: ; address name
    ld de, MenuCursorPositions_Bank03
    ld hl, wC46D
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, Jump_003_480F
    xor a, a
    ld [wC0A1], a
    ret

Jump_003_480F::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_4827
    ld a, $69
    call QueueSoundEffect
    ld hl, wC0A0
    inc [hl]
    xor a, a
    ld [wC0A1], a
    ld [wC0A4], a
    ret

Jump_003_4827::
    bit 1, a
    jr z, Jump_003_4837
    ld hl, wC0A0
    dec [hl]
    xor a, a
    ld [wC0A1], a
    ld [wC0A4], a
    ret

Jump_003_4837::
    bit 2, a
    jr z, Jump_003_4845
    ld a, $01
    ld [wDataBankSave], a
    xor a, a
    ld [wC0A1], a
    ret

Jump_003_4845::
    ret

; entry 3 of the `rst $00` table in PauseMenu_Main
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A1
PauseMenu_Main_Case03::
Jump_003_4846:: ; address name
    ld a, [wC0A1]
    rst $00
    dw PauseMenu_Main_Case03_Case00
    dw PauseMenu_Main_Case03_Case01
    dw PauseMenu_Main_Case03_Case02

; entry 0 of the `rst $00` table in PauseMenu_Main_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A4
; points at: wC0A1
PauseMenu_Main_Case03_Case00::
Jump_003_4850:: ; address name
    ld a, [wC0A4]
    or a, a
    jr nz, Jump_003_485C
    call LoadBlankedBlocks00_09_0AWithCursor
    call CopyTileBufferToBGMap

Jump_003_485C::
    ld hl, wC0A1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_Main_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A4
; points at: wC1B9, wC0A1
PauseMenu_Main_Case03_Case01::
Jump_003_4861:: ; address name
    ld a, [wC0A4]
    or a, a
    jr nz, Jump_003_486A
    call LoadScreenBlocks00_09_0A

Jump_003_486A::
    call WithSRAMRun4E02
    ld hl, vBGMap0 + $21
    ld bc, $1311
    ld de, wC1B9
    call CopyRectToBGMap
    call PauseMenu_Main_Case03_Case01_Sub01
    ld hl, wC0A1
    inc [hl]
    ret

; entry 2 of the `rst $00` table in PauseMenu_Main_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wD09D, wD09E
; writes: wC0A1, hOamNextEntry, wD7F1, wD7F2, wC0A4, wDataBankSave
; points at: wC46D, wC000, wC0A0
PauseMenu_Main_Case03_Case02::
Jump_003_4881:: ; address name
    ld de, MenuCursorPositions_Bank03
    ld hl, wC46D
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, Jump_003_4896
    xor a, a
    ld [wC0A1], a
    ret

Jump_003_4896::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_48B3
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ldh [hOamNextEntry], a
    ld hl, wC000
    ld bc, $00A0
    call FillBytes
    ld hl, wC0A0
    inc [hl]
    ret

Jump_003_48B3::
    ld a, [wD09D]
    ld l, a
    ld a, [wD09E]
    ld h, a
    ld a, l
    ld [wD7F1], a
    ld a, h
    ld [wD7F2], a
    farcall DrawPartySpeciesSprites
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, Jump_003_48DC
    ld hl, wC0A0
    dec [hl]
    xor a, a
    ld [wC0A1], a
    ld [wC0A4], a
    ret

Jump_003_48DC::
    bit 2, a
    jr z, Jump_003_48EA
    ld a, $01
    ld [wDataBankSave], a
    xor a, a
    ld [wC0A1], a
    ret

Jump_003_48EA::
    ret

; entry 4 of the `rst $00` table in PauseMenu_Main
; no direct call (reached through a table, a jump or a vector)
PauseMenu_Main_Case04::
Jump_003_48EB:: ; address name
    call ExitPauseMenuToField
    ret

; clears the screen tile buffer, copies blocks $00-$03 into it, then wC0A4 += 1 (E-0117)
; 1 call site from 1 routine (e.g. PauseMenu_Main_Case00_Case01)
; points at: wC0A4
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
    ld hl, wC0A4
    inc [hl]
    ret

; clears the screen tile buffer, copies blocks $00, $04, $05, $06, then wC0A4 += 1 (E-0117)
; 1 call site from 1 routine (e.g. PauseMenu_Main_Case01_Case01)
; points at: wC0A4
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
    ld hl, wC0A4
    inc [hl]
    ret

; clears the screen tile buffer, copies blocks $00, $07, $08, then wC0A4 += 1 (E-0117)
; 1 call site from 1 routine (e.g. PauseMenu_Main_Case02_Case01)
; points at: wC0A4
LoadScreenBlocks00_07_08::
Func_003_493F:: ; address name
    call ClearScreenTileBuffer_Bank03
    ld e, $00
    farcall CopyBlockToTileBuffer
    ld e, $07
    farcall CopyBlockToTileBuffer
    ld e, $08
    farcall CopyBlockToTileBuffer
    ld hl, wC0A4
    inc [hl]
    ret

; clears the screen tile buffer, copies blocks $00, $09, $0A, then wC0A4 += 1 (E-0117)
; 1 call site from 1 routine (e.g. PauseMenu_Main_Case03_Case01)
; points at: wC0A4
LoadScreenBlocks00_09_0A::
Func_003_495F:: ; address name
    call ClearScreenTileBuffer_Bank03
    ld e, $00
    farcall CopyBlockToTileBuffer
    ld e, $09
    farcall CopyBlockToTileBuffer
    ld e, $0A
    farcall CopyBlockToTileBuffer
    ld hl, wC0A4
    inc [hl]
    ret

; clears the screen tile buffer, copies block $2D + wC6FD and block $31, then wC0A4 += 1 (E-0117)
; 1 call site from 1 routine (e.g. Func_003_4FBB_Case01)
; reads: wC6FD
; points at: wC0A4
LoadScreenBlockForPartySize::
Func_003_497F:: ; address name
    call ClearScreenTileBuffer_Bank03
    ld a, [wC6FD]
    add a, $2D
    ld e, a
    farcall CopyBlockToTileBuffer
    ld e, $31
    farcall CopyBlockToTileBuffer
    ld hl, wC0A4
    inc [hl]
    ret

; clears the screen tile buffer, copies blocks $00-$03 with CopyBlockToTileBufferBlankingText, then DrawMenuCursorTileInBuffer (E-0117)
; 2 call sites from 2 routines (e.g. Func_003_4208_Case00, PauseMenu_Main_Case00_Case00)
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
; 1 call site from 1 routine (e.g. Func_003_4208_Case00)
DecompressMenuTilesTo16E0::
Func_003_4A27:: ; address name
    ld b, $16
    ld de, Data_016_7B7D
    ld hl, vTiles1 + $6E0
    call DecompressToVRAM
    call DrawRecordMonsterPictureForWC46D
    ret

; loads the picture of the species of record wC46D & $0F at vTiles2 + $5C0; on CGB also uploads palettes and copies its 6 x 6 attribute block to vBGMap0 + $161 (E-0125)
; 2 call sites from 2 routines (e.g. DecompressMenuTilesTo16E0, PauseMenu_Main_Case00_Case01)
; reads: wC46D, wIsCGB
; writes: wC526, hFFC6, rVBK, rSVBK
; points at: wD000
DrawRecordMonsterPictureForWC46D::
Func_003_4A36:: ; address name
    ld c, $0B
    ld a, [wC46D]
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
    ld [wC526], a
    call UploadBGPalettes
    pop de
    ld a, $01
    ldh [hFFC6], a
    ld hl, wD000
    call LoadMonsterPictureAttributeBlock
    ld a, $01
    ldh [rVBK], a
    ld a, $02
    ldh [rSVBK], a
    ld hl, vBGMap0 + $161
    ld de, wD000
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

; with SRAM bank 0 enabled runs Func_003_4E02 (E-0122)
; 1 call site from 1 routine (e.g. PauseMenu_Main_Case03_Case01)
; writes: rRAMG, rRAMB
WithSRAMRun4E02::
Func_003_4ABD:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    call WithSRAMRun4E02_Sub01
    xor a, a
    ld [rRAMG], a
    ret

; writes record wC46D's level (field $56, marked with tile $14 at the cap in field $57), status marks from field $55 and the field $0E mark into the row at wC1C1 (E-0127)
; 2 call sites from 2 routines (e.g. WithSRAMDraw4ACEAnd4B52, WithSRAMDraw4ACEAnd4BE8)
; reads: wC46D
; writes: wC1C1, wC1CA
; points at: wC1C1, wC1C4
BuildRecordLevelAndStatusRow::
Func_003_4ACE:: ; address name
    ld hl, wC1C1
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
    ld a, [wC46D]
    and a, $0F
    call SRAMRecordAddressMapped
    push hl
    ld a, [hl]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld de, wC1C4
    call WriteTwoDigitTilesFromWC8C1
    pop hl
    ld a, [hl+]
    cp a, [hl]
    jr c, Jump_003_4B0A
    ld a, $14
    ld [wC1C1], a

Jump_003_4B0A::
    ld c, $55
    ld a, [wC46D]
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
    ld a, [wC46D]
    and a, $0F
    call SRAMRecordAddressMapped
    ld a, [hl]
    and a, $01
    add a, $CC
    ld [wC1CA], a
    ret

; wC1C8 = $C2; AF kept (E-0119)
; 1 call site from 1 routine (e.g. BuildRecordLevelAndStatusRow)
; writes: wC1C8
SetWC1C8TileC2::
Func_003_4B3A:: ; address name
    push af
    ld a, $C2
    ld [wC1C8], a
    pop af
    ret

; wC1C6 = $C0; AF kept (E-0119)
; 1 call site from 1 routine (e.g. BuildRecordLevelAndStatusRow)
; writes: wC1C6
SetWC1C6TileC0::
Func_003_4B42:: ; address name
    push af
    ld a, $C0
    ld [wC1C6], a
    pop af
    ret

; wC1C7 = $C1; AF kept (E-0119)
; 1 call site from 1 routine (e.g. BuildRecordLevelAndStatusRow)
; writes: wC1C7
SetWC1C7TileC1::
Func_003_4B4A:: ; address name
    push af
    ld a, $C1
    ld [wC1C7], a
    pop af
    ret

; only called from WithSRAMDraw4ACEAnd4B52 (E-0047)
; 1 call site from 1 routine (e.g. WithSRAMDraw4ACEAnd4B52)
; reads: wC46D
; points at: wC208, wC248, wC288, wC2C8, wC308, wC364, wC368, wC3A4, ...
WithSRAMDraw4ACEAnd4B52_Sub01::
Func_003_4B52:: ; address name
    ld c, $63
    ld a, [wC46D]
    and a, $0F
    call SRAMRecordAddressMapped
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wC208
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wC248
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wC288
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wC2C8
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    push hl
    deref_hl
    call HLToDecimalDigits
    ld de, wC308
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
    ld de, wC364
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wC368
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wC3A4
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    deref_hl
    call HLToDecimalDigits
    ld de, wC3A8
    call WriteDecimalDigitTiles
    ret

; only called from WithSRAMDraw4ACEAnd4BE8 (E-0047)
; 1 call site from 1 routine (e.g. WithSRAMDraw4ACEAnd4BE8)
; reads: wC46D, wC8C1, wC8C2, wD00F, hFFC8, hFFC9, hFFCA
; writes: wStringIndex, wStringCategory, wC281, wC282, wC283, wC284, wC8C0, wC8C1, ...
; points at: wC283, wC324, wC3A4
WithSRAMDraw4ACEAnd4BE8_Sub01::
Func_003_4BE8:: ; address name
    ld c, $A4
    ld a, [wC46D]
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
    ld a, [wC46D]
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
    ld a, [wC46D]
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
    ld a, [wC46D]
    and a, $0F
    add a, $C7
    ld [wC281], a
    ld a, $C3
    ld [wC282], a
    ld [wC283], a
    ld [wC284], a
    ld c, $6D
    ld a, [wC46D]
    and a, $0F
    call SRAMRecordAddressMapped
    ld a, [hl]
    or a, a
    jr z, Jump_003_4CB8
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld hl, wC283
    ld a, [wC8C1]
    or a, a
    jr z, Jump_003_4CAD
    add a, $E0
    ld [hl+], a

Jump_003_4CAD::
    ld a, [wC8C2]
    add a, $E0
    ld [hl], a
    ld a, $FC
    ld [wC282], a

Jump_003_4CB8::
    ld c, $0F
    ld a, [wC46D]
    and a, $0F
    call SRAMRecordAddressMapped
    call CopyTenBytesToWC130
    ld hl, vTiles2 + $470
    call SelectString5Category8ThenShow
    ld c, $58
    ld a, [wC46D]
    and a, $0F
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld [wC8C0], a
    ld e, a
    ld a, [hl+]
    ld [wC8C1], a
    ld d, a
    ld a, [hl]
    ld [wC8C2], a
    ld c, a
    push bc
    push de
    call Number24ToPackedBCD
    ld de, wC324
    call WithSRAMDraw4ACEAnd4BE8_Sub01_Sub01
    ld c, $0B
    ld a, [wC46D]
    and a, $0F
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wD00F]
    ldh [hFFC6], a
    ld c, $56
    ld a, [wC46D]
    and a, $0F
    call SRAMRecordAddressMapped
    ld a, [hl]
    ldh [hFFC7], a
    farcall LoadTable4E60EntryToHFFC8
    ld c, $56
    ld a, [wC46D]
    and a, $0F
    call SRAMRecordAddressMapped
    pop de
    pop bc
    ld a, [hl+]
    cp a, [hl]
    jr nc, Jump_003_4D43
    ldh a, [hFFC8]
    sub a, e
    ld [wC8C0], a
    ldh a, [hFFC9]
    sbc a, d
    ld [wC8C1], a
    ldh a, [hFFCA]
    sbc a, c
    ld [wC8C2], a
    jr Jump_003_4D4D

Jump_003_4D43::
    xor a, a
    ld [wC8C0], a
    ld [wC8C1], a
    ld [wC8C2], a

Jump_003_4D4D::
    call Number24ToPackedBCD
    ld de, wC3A4
    call WithSRAMDraw4ACEAnd4BE8_Sub01_Sub01
    ret

; for SRAM record wC46D & $0F: shows the species category $0D string at vTiles2 + $2C0 and the eight skills of field $34 in slots 0-7 (E-0121)
; 1 call site from 1 routine (e.g. WithSRAMShowRecordSpeciesAndSkillNames)
; reads: wC46D, wD013
; writes: wSpeciesIdLo, wSpeciesIdHi, wStringIndex, wStringCategory
ShowRecordSpeciesAndSkillNames::
Func_003_4D57:: ; address name
    ld c, $0B
    ld a, [wC46D]
    and a, $0F
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wD013]
    ld [wStringIndex], a
    ld a, $0D
    ld [wStringCategory], a
    ld hl, vTiles2 + $2C0
    ld de, $0602
    call ShowStringBank08AtTilesHL_Bank03
    ld c, $34
    ld a, [wC46D]
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

Data_003_4DF2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $80, $93, $10, $94, $A0, $94, $30, $95, $C0, $95, $50, $96, $E0, $96, $70, $97

; only called from WithSRAMRun4E02 (E-0047)
; 1 call site from 1 routine (e.g. WithSRAMRun4E02)
; reads: wC46D, wMenuLastPageRows
; writes: wMenuLastPageRows, wC206, wC326
; points at: wC202, wC322, wC130
WithSRAMRun4E02_Sub01::
Func_003_4E02:: ; address name
    ld c, $0D
    ld a, [wC46D]
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
    call WithSRAMRun4E02_Sub01_Sub02
    ld a, [wMenuLastPageRows]
    xor a, $01
    ld b, a
    call WithSRAMRun4E02_Sub01_Sub02
    ld a, l
    add a, $5A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wMenuLastPageRows]
    ld b, a
    call WithSRAMRun4E02_Sub01_Sub03
    ld a, [wMenuLastPageRows]
    xor a, $01
    ld b, a
    call WithSRAMRun4E02_Sub01_Sub03
    ld a, [wMenuLastPageRows]
    add a, $CC
    ld [wC206], a
    xor a, $01
    ld [wC326], a
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
    ld hl, wC202
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    inc hl
    ld [hl], a
    ld hl, wC322
    ld [hl+], a
    ld [hl+], a
    ld [hl+], a
    inc hl
    ld [hl], a
    ld hl, wC130
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
    call WithSRAMRun4E02_Sub01_Sub01
    ld hl, vTiles2 + $6C0
    call WithSRAMRun4E02_Sub01_Sub01
    ld hl, vTiles2 + $7B0
    call WithSRAMRun4E02_Sub01_Sub01
    ret

; reads a species id at [HL] (HL += 2), shows its name (category id-high + 2) at the window from Data_003_4F5D[B], loads the species record, sets wD09D = family, wD09E = Data_003_4F61[B] and far-calls Func_016_7A48 (E-0121)
; 2 call sites from 1 routine (e.g. WithSRAMRun4E02_Sub01)
; reads: wSpeciesRecord
; writes: wSpeciesIdLo, wStringIndex, wSpeciesIdHi, wStringCategory, wD09D, wD09E
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
    ld [wD09D], a
    pop bc
    ld a, b
    ld hl, Data_003_4F61
    add_a_to_hl
    ld a, [hl]
    ld [wD09E], a
    farcall LoadFamilyIconTileForWD09D
    pop hl
    ret

; only called from WithSRAMRun4E02_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. WithSRAMRun4E02_Sub01)
WithSRAMRun4E02_Sub01_Sub02::
Func_003_4EFD:: ; address name
    call CopyTenBytesToWC130
    inc hl
    push hl
    push bc
    ld a, b
    ld hl, Data_003_4F63
    call DerefWordTableEntryA_Bank03
    pop bc
    pop hl
    ret

; only called from WithSRAMRun4E02_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. WithSRAMRun4E02_Sub01)
; reads: wC8C1, wC8C2
WithSRAMRun4E02_Sub01_Sub03::
Func_003_4F0D:: ; address name
    call CopyTenBytesToWC130
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
    ld a, [wC8C1]
    or a, a
    jr z, Jump_003_4F55
    add a, $E0
    ld [hl+], a

Jump_003_4F55::
    ld a, [wC8C2]
    add a, $E0
    ld [hl], a

Jump_003_4F5B::
    pop hl
    ret

Data_003_4F5D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E0, $95, $20, $97

Data_003_4F61:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $5D, $71

Data_003_4F63:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $70, $96, $B0, $97

Data_003_4F67:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $80, $95, $C0, $96

Data_003_4F6B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $02, $C2, $22, $C3

; reads field $0B of SRAM record wC46D & $0F and decompresses its graphics to vTiles0 (DecompressGraphicsWD7F1ToWD7F4); then sets wD7F3-wD7F6 = $00, $90, $40, $00 and hFFB9 = 0 (E-0121)
; 1 call site from 1 routine (e.g. PauseMenu_Main_Case01_Case01)
; reads: wC46D
; writes: rRAMG, rRAMB, wD7F1, wD7F2, wD7F3, wD7F4, wD7F5, wD7F6, ...
DecompressRecordSpeciesGraphicsToTiles0::
Func_003_4F6F:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld c, $0B
    ld a, [wC46D]
    and a, $0F
    call SRAMRecordAddressMapped
    ld a, [hl+]
    ld [wD7F1], a
    ld a, [hl]
    ld [wD7F2], a
    xor a, a
    ld [wD7F3], a
    ld hl, vTiles0
    ld a, l
    ld [wD7F4], a
    ld a, h
    ld [wD7F5], a
    farcall DecompressGraphicsWD7F1ToWD7F4
    xor a, a
    ld [rRAMG], a
    ld a, $00
    ld [wD7F3], a
    ld a, $90
    ld [wD7F4], a
    ld a, $40
    ld [wD7F5], a
    ld a, $00
    ld [wD7F6], a
    xor a, a
    ldh [hFFB9], a
    ret

; only called from PauseMenu_Main_Case03_Case01 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_Main_Case03_Case01)
; reads: wC46D
; writes: rRAMG, rRAMB, wD7F1, wD7F2, wD09D, wD09E, hFFB9
; points at: wC6FE
PauseMenu_Main_Case03_Case01_Sub01::
Func_003_4FBB:: ; address name
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wC46D]
    ld hl, wC6FE
    add_a_to_hl
    ld a, l
    ld [wD7F1], a
    ld a, h
    ld [wD7F2], a
    ld a, l
    ld [wD09D], a
    ld a, h
    ld [wD09E], a
    farcall LoadPartySpeciesSpriteGraphics
    xor a, a
    ld [rRAMG], a
    xor a, a
    ldh [hFFB9], a
    ret

Jump_003_4FED::
    ld a, [wC0A1]
    rst $00
    dw Func_003_4FBB_Case00
    dw Func_003_4FBB_Case01
    dw Func_003_4FBB_Case02
    dw Func_003_4FBB_Case03
    dw Func_003_4FBB_Case04

; entry 0 of the `rst $00` table in Func_003_4FBB
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: rVBK
; points at: wC0A1
Func_003_4FBB_Case00::
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
    ld hl, wC0A1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_003_4FBB
; no direct call (reached through a table, a jump or a vector)
; reads: wC6FD, wIsCGB
; writes: rRAMG, rRAMB, hFFC6, wC52D, wC52E, wC52F, wC530, wC526
; points at: wC0A1
Func_003_4FBB_Case01::
Jump_003_5042:: ; address name
    call LoadScreenBlockForPartySize
    call FillTilesFromRequest
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    ld a, [wC6FD]
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
    ldh [hFFC6], a
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
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, e
    ld [wC52F], a
    ld a, d
    ld [wC530], a
    xor a, a
    ld [rRAMG], a
    ld hl, wC0A1
    inc [hl]
    ld a, $7F
    ld [wC526], a
    ret

; for record C writes HP (field $5B), MP (field $5F) and level (field $56) as digits at the screen-buffer position Data_003_519E[C] (E-0127)
; 1 call site from 1 routine (e.g. Func_003_4FBB_Case01)
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
; 1 call site from 1 routine (e.g. Func_003_4FBB_Case01)
; writes: wC52D, wC52E, wC52F, wC530, wStringIndex, wStringCategory
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
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, e
    ld [wC52F], a
    ld a, d
    ld [wC530], a
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
; 1 call site from 1 routine (e.g. Func_003_4FBB_Case01)
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

Data_003_518F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $03, $05

Data_003_5192:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $91, $80, $93, $C0, $95

Data_003_5198:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $80, $00, $00, $01

Data_003_519E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FA, $C1, $00, $C2, $06, $C2

Data_003_51A4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $88, $90, $88, $20, $89

Data_003_51AA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $66, $C3, $86, $C3, $A6, $C3

; entry 2 of the `rst $00` table in Func_003_4FBB
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wC6FD
; writes: rVBK, rSVBK
; points at: wD000, wD080, wD100, wC0A1
Func_003_4FBB_Case02::
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
    ld de, wD000
    call CopyRectToVRAMSourceStrideBPlus14_Bank03
    ld a, [wC6FD]
    cp a, $01
    jr z, Jump_003_51F3
    ld hl, vBGMap0 + $E7
    ld de, wD080
    ld bc, $0606
    call CopyRectToVRAMSourceStrideBPlus14_Bank03
    ld a, [wC6FD]
    cp a, $02
    jr z, Jump_003_51F3
    ld hl, vBGMap0 + $ED
    ld de, wD100
    ld bc, $0606
    call CopyRectToVRAMSourceStrideBPlus14_Bank03

Jump_003_51F3::
    ld a, $00
    ldh [rSVBK], a
    ld a, $00
    ldh [rVBK], a

Jump_003_51FB::
    ld hl, wC0A1
    inc [hl]
    ret

; entry 3 of the `rst $00` table in Func_003_4FBB
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed
; points at: wC0A1
Func_003_4FBB_Case03::
Jump_003_5200:: ; address name
    ld a, [wJoypadPressed]
    and a, $04
    ret z
    ld hl, wC0A1
    inc [hl]
    ret

; entry 4 of the `rst $00` table in Func_003_4FBB
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: rVBK, wDataBankSave, wC0A1, wC0A4
Func_003_4FBB_Case04::
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
    ld [wC0A1], a
    xor a, a
    ld [wC0A4], a
    ret

; D = tile, B = first-row width, C = rows: writes D with WriteVRAMByteInc; after each row moves 12 entries on (to the next 32-entry row) and uses width 20 (E-0117)
; 2 call sites from 1 routine (e.g. Func_003_4FBB_Case04)
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
; 1 call site from 1 routine (e.g. Func_003_4FBB_Case04)
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

Data_003_5264:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $00, $FF, $10, $FF, $10, $FF, $FE, $FF, $7C, $FF, $38, $FF, $7C, $FF, $C6

; GameMode2_Update, wModeState 1: the ITEM list ('No items' at the start of a game) (E-0046)
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A0
PauseMenu_Items::
Jump_003_5274:: ; address name
    ld a, [wC0A0]
    rst $00
    dw PauseMenu_Items_Case00
    dw PauseMenu_Items_Case01
    dw PauseMenu_Items_Case02
    dw PauseMenu_Items_Case03

; entry 0 of the `rst $00` table in PauseMenu_Items
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A1
PauseMenu_Items_Case00::
Jump_003_5280:: ; address name
    ld a, [wC0A1]
    rst $00
    dw PauseMenu_Items_Case00_Case00
    dw PauseMenu_Items_Case00_Case01

; entry 0 of the `rst $00` table in PauseMenu_Items_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wD095
; points at: wC0A1
PauseMenu_Items_Case00_Case00::
Jump_003_5288:: ; address name
    ld a, [wD095]
    or a, a
    call nz, RefreshRecordListAndNameTiles
    call SetupInventoryMenuPages_Bank03
    call BuildInventoryScreenBase
    call SetMenuRowsForPage_Bank03_59DB
    call ShowSelectedItemDescription
    call CopyTileBufferToBGMap
    ld hl, wC0A1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_Items_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wInventory, wJoypadPressed, wJoypadPressedRepeat, wMenuRowCount, wMenuPage, wC46E
; writes: wD082, wItemId, wC0A1, wC46F
; points at: wC46E, wInventory, wC150, wC60C, wC130, wC0A0
PauseMenu_Items_Case00_Case01::
Jump_003_52A3:: ; address name
    ld a, [wInventory]
    or a, a
    jr nz, Jump_003_52AE
    ld a, [wJoypadPressed]
    jr Jump_003_5328

Jump_003_52AE::
    ld de, Data_003_4617
    ld hl, wC46E
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
    ld hl, wC46E
    bit 7, [hl]
    jr z, Jump_003_52DE
    res 7, [hl]
    call SetMenuRowsForPage_Bank03_59DB
    call ShowSelectedItemDescription
    call Func_003_592E
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
    ld a, [wC46E]
    add a, c
    ld [wD082], a
    ld hl, wInventory
    add_a_to_hl
    ld a, [hl]
    ld [wItemId], a
    ld l, a
    ld h, $05
    ld de, wC150
    call CopyStringHLToDE
    ld de, wC60C
    ld hl, wC130
    call CopyFiveGlyphsPlusMarks
    farcall LoadItemRecord
    ld hl, wC0A0
    inc [hl]
    xor a, a
    ld [wC0A1], a
    xor a, a
    ld [wC46F], a
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
    call Func_003_592E
    ret

; entry 1 of the `rst $00` table in PauseMenu_Items
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A1
PauseMenu_Items_Case01::
Jump_003_5340:: ; address name
    ld a, [wC0A1]
    rst $00
    dw PauseMenu_Items_Case01_Case00
    dw PauseMenu_Items_Case01_Case01

; entry 0 of the `rst $00` table in PauseMenu_Items_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wMenuRowCount, wMenuPageCount
; points at: wC0A1
PauseMenu_Items_Case01_Case00::
Jump_003_5348:: ; address name
    call BuildScreenBlock0EWithCursor
    call CopyTileBufferToBGMap
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    ld hl, wC0A1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_Items_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wC46F
; writes: wC0A0, wC0A1
; points at: wC46F, wC0A0
PauseMenu_Items_Case01_Case01::
Jump_003_535D:: ; address name
    ld de, Data_003_461F
    ld hl, wC46F
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_5381
    ld a, $69
    call QueueSoundEffect
    ld a, [wC46F]
    and a, $01
    add a, $02
    ld [wC0A0], a
    xor a, a
    ld [wC0A1], a
    ret

Jump_003_5381::
    bit 1, a
    ret z
    ld hl, wC0A0
    dec [hl]
    xor a, a
    ld [wC0A1], a
    ret

; entry 2 of the `rst $00` table in PauseMenu_Items
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A1
PauseMenu_Items_Case02::
Jump_003_538D:: ; address name
    ld a, [wC0A1]
    rst $00
    dw PauseMenu_Items_Case02_Case00
    dw PauseMenu_Items_Case02_Case01
    dw PauseMenu_Items_Case02_Case02
    dw PauseMenu_Items_Case02_Case03
    dw PauseMenu_Items_Case02_Case04
    dw PauseMenu_Items_Case02_Case05
    dw PauseMenu_Items_Case02_Case06
    dw PauseMenu_Items_Case02_Case07
    dw PauseMenu_Items_Case02_Case08
    dw PauseMenu_Items_Case02_Case09
    dw PauseMenu_Items_Case02_Case0A
    dw PauseMenu_Items_Case02_Case0B
    dw PauseMenu_Items_Case02_Case0A
    dw PauseMenu_Items_Case02_Case01
    dw PauseMenu_Items_Case02_Case07
    dw PauseMenu_Items_Case02_Case08
    dw PauseMenu_Items_Case02_Case09
    dw PauseMenu_Items_Case02_Case0A
    dw PauseMenu_Items_Case02_Case0B
    dw PauseMenu_Items_Case02_Case0A
    dw PauseMenu_Items_Case02_Case01
    dw PauseMenu_Items_Case02_Case07
    dw PauseMenu_Items_Case02_Case16
    dw PauseMenu_Items_Case02_Case17
    dw PauseMenu_Items_Case02_Case18
    dw PauseMenu_Items_Case02_Case19
    dw PauseMenu_Items_Case02_Case1A
    dw PauseMenu_Items_Case02_Case1B
    dw PauseMenu_Items_Case02_Case1C
    dw PauseMenu_Items_Case02_Case1D
    dw PauseMenu_Items_Case02_Case1E
    dw PauseMenu_Items_Case02_Case1F
    dw PauseMenu_Items_Case02_Case20
    dw PauseMenu_Items_Case02_Case21

; entry 0 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wD088, wD08A
; writes: wC0A1
; points at: wC0A1
PauseMenu_Items_Case02_Case00::
Jump_003_53D5:: ; address name
    ld a, [wD088]
    bit 1, a
    jr nz, Jump_003_53FC
    ld a, [wD08A]
    or a, a
    jr z, Jump_003_53F0
    cp a, $04
    jr z, Jump_003_53F0
    cp a, $07
    jr z, Jump_003_53F6
    ld a, $0D
    ld [wC0A1], a
    ret

Jump_003_53F0::
    ld a, $04
    ld [wC0A1], a
    ret

Jump_003_53F6::
    ld a, $14
    ld [wC0A1], a
    ret

Jump_003_53FC::
    ld hl, wC0A1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; points at: wC0A1
PauseMenu_Items_Case02_Case01::
Jump_003_5401:: ; address name
    call BuildScreenBlock0EWithWC46FCursor
    call CopyTileBufferToBGMap
    ld hl, wC0A1
    inc [hl]
    ret

; entry 2 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wC0A1
PauseMenu_Items_Case02_Case02::
Jump_003_540C:: ; address name
    ld a, $08
    ld [wStringCategory], a
    ld a, $06
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    ld hl, wC0A1
    inc [hl]
    ret

; entry 3 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wC0A0, wC0A1
PauseMenu_Items_Case02_Case03::
Jump_003_5421:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    xor a, a
    ld [wC0A0], a
    xor a, a
    ld [wC0A1], a
    ret

; entry 4 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wC6FD
; writes: wC46D, wMenuRowCount, wMenuPageCount
; points at: wC0A1
PauseMenu_Items_Case02_Case04::
Jump_003_542F:: ; address name
    xor a, a
    ld [wC46D], a
    call BuildItemScreenForWItemId
    call CopyTileBufferToBGMap
    ld a, [wC6FD]
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    ld hl, wC0A1
    inc [hl]
    ret

; entry 5 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wC46D
; writes: rRAMG, rRAMB, wD083, wC0A0, wC0A1
; points at: wC46D, wC2D9, wC140, wC0A1
PauseMenu_Items_Case02_Case05::
Jump_003_5449:: ; address name
    ld de, MenuCursorPositions_Bank03
    ld hl, wC46D
    call UpdateMenuCursor
    ld a, [wJoypadPressedRepeat]
    and a, $C0
    jr z, Jump_003_5469
    call Func_003_5AA7
    ld hl, vBGMap0 + $141
    ld bc, $0903
    ld de, wC2D9
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
    ld a, [wC46D]
    and a, $03
    ld [wD083], a
    ld c, $01
    call SRAMRecordAddressMapped
    ld e, l
    ld d, h
    ld hl, wC140
    call CopyFiveGlyphsPlusMarks
    xor a, a
    ld [rRAMG], a
    ld hl, wC0A1
    inc [hl]
    ret

Jump_003_549C::
    bit 1, a
    ret z
    ld a, $01
    ld [wC0A0], a
    xor a, a
    ld [wC0A1], a
    ret

; entry 6 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; points at: wC0A1
PauseMenu_Items_Case02_Case06::
Jump_003_54A9:: ; address name
    call BuildItemScreenWithRecordCursor
    call CopyTileBufferToBGMap
    ld hl, wC0A1
    inc [hl]
    ret

; entry 7 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wD08D
; writes: wStringCategory, wStringIndex, wC0A1
; points at: wC0A1
PauseMenu_Items_Case02_Case07::
Jump_003_54B4:: ; address name
    ld a, $00
    ld [wStringCategory], a
    ld a, [wD08D]
    ld [wStringIndex], a
    cp a, $25
    jr z, Jump_003_54CE
    farcall BeginStringDisplay_Bank37
    ld hl, wC0A1
    inc [hl]
    ret

Jump_003_54CE::
    ld a, $1B
    ld [wC0A1], a
    ret

; entry 8 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wItemId, wD08A
; writes: rRAMG, rRAMB, wC0A1
; points at: wC0A1
PauseMenu_Items_Case02_Case08::
Jump_003_54D4:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    farcall CheckItemUsable
    xor a, a
    ld [rRAMG], a
    ld hl, wC0A1
    inc [hl]
    ld a, [wItemId]
    cp a, $FF
    ret z
    ld a, [wD08A]
    cp a, $00
    jr z, Jump_003_550C
    cp a, $02
    jr z, Jump_003_550C
    cp a, $04
    jr z, Jump_003_550C
    ld a, $12
    ld [wC0A1], a
    ret

Jump_003_550C::
    ld a, $0B
    ld [wC0A1], a
    ret

; entry 9 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wD082
; writes: wStringIndex, wStringCategory
; points at: wInventory, wC0A1
PauseMenu_Items_Case02_Case09::
Jump_003_5512:: ; address name
    ld a, [wD082]
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
    ld [wStringIndex], a
    ld a, $00
    ld [wStringCategory], a

Jump_003_553C::
    farcall BeginStringDisplay_Bank37
    ld hl, wC0A1
    inc [hl]
    ret

; entry 10 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
PauseMenu_Items_Case02_Case0A::
Jump_003_5547:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    call ResetInventoryMenuToFirstPage
    ret

; entry 11 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wD08E, hFFC6
; writes: rRAMG, rRAMB, wStringIndex, wStringCategory, wMenuPage, wC46E
; points at: wC0A1
PauseMenu_Items_Case02_Case0B::
Jump_003_5550:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    farcall ApplyItemEffect
    xor a, a
    ld [rRAMG], a
    ld a, [wD08E]
    ld [wStringIndex], a
    cp a, $27
    jr z, Jump_003_5585

Jump_003_556E::
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37
    ld hl, wC0A1
    inc [hl]
    xor a, a
    ld [wMenuPage], a
    ld [wC46E], a
    ret

Jump_003_5585::
    ldh a, [hFFC6]
    or a, a
    jr z, Jump_003_556E
    ld a, $31
    ld [wStringIndex], a
    jr Jump_003_556E

; entry 22 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wItemId, wD08E
; writes: rRAMG, rRAMB
; points at: wC0A1
PauseMenu_Items_Case02_Case16::
Jump_003_5591:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    farcall CheckItemUsable
    xor a, a
    ld [rRAMG], a
    ld hl, wC0A1
    inc [hl]
    ld a, [wItemId]
    cp a, $FF
    ret z
    cp a, $FE
    ret z
    ld hl, wC0A1
    inc [hl]
    ld hl, wC0A1
    inc [hl]
    ld a, [wD08E]
    or a, a
    ret nz
    ld hl, wC0A1
    inc [hl]
    ret

; entry 23 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; writes: wStringIndex, wStringCategory
; points at: wC0A1
PauseMenu_Items_Case02_Case17::
Jump_003_55C9:: ; address name
    ld a, $02
    ld [wStringIndex], a
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37
    ld hl, wC0A1
    inc [hl]
    ret

; entry 24 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wC0A0, wC0A1
PauseMenu_Items_Case02_Case18::
Jump_003_55DE:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    xor a, a
    ld [wC0A0], a
    ld [wC0A1], a
    ret

; entry 25 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wD08E
; writes: rRAMG, rRAMB, wStringIndex, wStringCategory
; points at: wC0A1
PauseMenu_Items_Case02_Case19::
Jump_003_55EB:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    farcall ApplyItemEffect
    xor a, a
    ld [rRAMG], a
    ld a, [wD08E]
    ld [wStringIndex], a
    cp a, $FF
    jr z, Jump_003_5614
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37

Jump_003_5614::
    ld hl, wC0A1
    inc [hl]
    ret

; entry 26 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
PauseMenu_Items_Case02_Case1A::
Jump_003_5619:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    call ExitPauseMenuToField
    ret

; entry 27 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wItemId
; writes: wStringCategory, wStringIndex
; points at: wC0A1
PauseMenu_Items_Case02_Case1B::
Jump_003_5622:: ; address name
    farcall CheckItemUsable
    ld hl, wC0A1
    inc [hl]
    ld a, [wItemId]
    cp a, $FF
    jr nz, Jump_003_5643
    ld a, $01
    ld [wStringCategory], a
    ld a, $14
    ld [wStringIndex], a
    ld hl, wC0A1
    inc [hl]
    inc [hl]
    inc [hl]

Jump_003_5643::
    farcall BeginStringDisplay_Bank37
    ret

; entry 28 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wMenuRowCount, wMenuPageCount, wC46F
; points at: wC0A1
PauseMenu_Items_Case02_Case1C::
Jump_003_564A:: ; address name
    ld a, [wC52B]
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
    ld [wC46F], a
    ld hl, wC0A1
    inc [hl]
    ret

; entry 29 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wC46F, wCC44, wC935, wSpriteSlotCount, wCB7E
; writes: wC96D, wC96E, wSpriteSlotCount, wCB7E, rRAMG, rRAMB, wC0A4, wC0A0, ...
; points at: wC46F, wC0A1
PauseMenu_Items_Case02_Case1D::
Jump_003_566D:: ; address name
    ld hl, wC46F
    ld de, Data_003_4645
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_56C7
    ld a, $69
    call QueueSoundEffect
    ld a, [wC46F]
    and a, $01
    jr nz, Jump_003_56CA
    ld a, [wCC44]
    cp a, $80
    jr nz, Jump_003_56AA
    ld a, [wC935]
    bit 7, a
    jr z, Jump_003_56AA
    ld a, [wSpriteSlotCount]
    ld [wC96D], a
    ld a, [wCB7E]
    ld [wC96E], a
    xor a, a
    ld [wSpriteSlotCount], a
    ld [wCB7E], a

Jump_003_56AA::
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    farcall ApplyItemEffect
    xor a, a
    ld [rRAMG], a
    xor a, a
    ld [wC0A4], a
    ld hl, wC0A1
    inc [hl]
    ret

Jump_003_56C7::
    bit 1, a
    ret z

Jump_003_56CA::
    xor a, a
    ld [wC0A0], a
    ld [wC0A1], a
    ret

; entry 30 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A4
; points at: wC0A1
PauseMenu_Items_Case02_Case1E::
Jump_003_56D2:: ; address name
    call RunWC0A4Screen
    ld a, [wC0A4]
    cp a, $04
    ret nz
    ld hl, wC0A1
    inc [hl]
    ld hl, wC0A1
    inc [hl]
    ret

; entry 31 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wC0A0, wC0A1
PauseMenu_Items_Case02_Case1F::
Jump_003_56E4:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    jr Jump_003_56CA

; entry 32 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; writes: wStringIndex, wStringCategory
; points at: wC0A1
PauseMenu_Items_Case02_Case20::
Jump_003_56EB:: ; address name
    ld a, $26
    ld [wStringIndex], a
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37
    ld hl, wC0A1
    inc [hl]
    ret

; entry 33 of the `rst $00` table in PauseMenu_Items_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wCC44, wC935, wC96D, wC96E
; writes: wSpriteSlotCount, wCB7E, wC0A0, wC0A1, wC0A4
PauseMenu_Items_Case02_Case21::
Jump_003_5700:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, [wCC44]
    cp a, $80
    jr nz, Jump_003_571F
    ld a, [wC935]
    bit 7, a
    jr z, Jump_003_571F
    ld a, [wC96D]
    ld [wSpriteSlotCount], a
    ld a, [wC96E]
    ld [wCB7E], a

Jump_003_571F::
    call ResetInventoryMenuToFirstPage
    xor a, a
    ld [wC0A0], a
    ld [wC0A1], a
    ld [wC0A4], a
    ret

; entry 3 of the `rst $00` table in PauseMenu_Items
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A1
PauseMenu_Items_Case03::
Jump_003_572D:: ; address name
    ld a, [wC0A1]
    rst $00
    dw PauseMenu_Items_Case03_Case00
    dw PauseMenu_Items_Case03_Case01
    dw PauseMenu_Items_Case03_Case02
    dw PauseMenu_Items_Case03_Case03
    dw PauseMenu_Items_Case03_Case04
    dw PauseMenu_Items_Case03_Case05
    dw PauseMenu_Items_Case03_Case06

; entry 0 of the `rst $00` table in PauseMenu_Items_Case03
; no direct call (reached through a table, a jump or a vector)
; points at: wC0A1
PauseMenu_Items_Case03_Case00::
Jump_003_573F:: ; address name
    call BuildScreenBlock0EWithWC46FCursor
    call CopyTileBufferToBGMap
    ld hl, wC0A1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_Items_Case03
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wC0A1
PauseMenu_Items_Case03_Case01::
Jump_003_574A:: ; address name
    ld a, $08
    ld [wStringCategory], a
    ld a, $01
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    ld hl, wC0A1
    inc [hl]
    ret

; entry 2 of the `rst $00` table in PauseMenu_Items_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wC470, wMenuRowCount, wMenuPageCount
; points at: wC0A1
PauseMenu_Items_Case03_Case02::
Jump_003_575F:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    xor a, a
    ld [wC470], a
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    call BuildScreenBlocks0EAnd0FWithCursor
    call CopyTileBufferToBGMap
    ld a, $6C
    call QueueSoundEffect
    ld hl, wC0A1
    inc [hl]
    ret

; entry 3 of the `rst $00` table in PauseMenu_Items_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wC470
; writes: wC0A1, wC0A0
; points at: wC470
PauseMenu_Items_Case03_Case03::
Jump_003_5782:: ; address name
    ld de, Data_003_4623
    ld hl, wC470
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_57B9
    ld a, $69
    call QueueSoundEffect
    ld a, [wC470]
    and a, $01
    ld hl, Data_003_4623
    add a, a
    add_a_to_hl
    deref_hl
    ld a, $BC
    call WriteVRAMByte
    ld a, [wC470]
    and a, $01
    add a, a
    add a, $04
    ld [wC0A1], a
    ret

Jump_003_57B9::
    bit 1, a
    ret z
    ld a, $01
    ld [wC0A0], a
    xor a, a
    ld [wC0A1], a
    ret

; entry 4 of the `rst $00` table in PauseMenu_Items_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wD08C, wD082
; writes: wStringCategory, wStringIndex
; points at: wC0A1, wInventory
PauseMenu_Items_Case03_Case04::
Jump_003_57C6:: ; address name
    ld a, [wD08C]
    bit 1, a
    jr z, Jump_003_57E2
    ld a, $08
    ld [wStringCategory], a
    ld a, $02
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    ld hl, wC0A1
    inc [hl]
    ret

Jump_003_57E2::
    ld a, [wD082]
    ld hl, wInventory
    add_a_to_hl
    ld [hl], $00
    ld a, $08
    ld [wStringCategory], a
    ld a, $04
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    farcall CompactInventory
    ld hl, wC0A1
    inc [hl]
    ret

; entry 5 of the `rst $00` table in PauseMenu_Items_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wMenuPage, wC46E
PauseMenu_Items_Case03_Case05::
Jump_003_580A:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    xor a, a
    ld [wMenuPage], a
    ld [wC46E], a
    call ResetInventoryMenuToFirstPage
    ret

; entry 6 of the `rst $00` table in PauseMenu_Items_Case03
; no direct call (reached through a table, a jump or a vector)
PauseMenu_Items_Case03_Case06::
Jump_003_581A:: ; address name
    call ResetInventoryMenuToFirstPage
    ret

; clears the screen buffer, copies blocks $0B and $0C and, with items, block $0D and the page indicator (page wMenuPage of wC0A7) (E-0124)
; 3 call sites from 3 routines (e.g. Func_003_4208_Case01, PauseMenu_Items_Case00_Case00, BuildScreenBlock0EWithCursor)
; reads: wInventory, wC0A7, wMenuPage
; points at: wC2A6
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
    ld a, [wC0A7]
    cp a, $02
    jr c, Jump_003_585C
    ld hl, wC2A6
    ld a, $C5
    ld [hl+], a
    ld a, [wMenuPage]
    add a, $E1
    ld [hl+], a
    ld a, $BE
    ld [hl+], a
    ld a, [wC0A7]
    add a, $E0
    ld [hl+], a
    ld [hl], $C6

Jump_003_585C::
    ret

; runs Func_003_581E, copies screen block $0E to the tile buffer and draws the cursor for wC46E & 7 (E-0122)
; 4 call sites from 4 routines (e.g. PauseMenu_Items_Case01_Case00, BuildItemScreenForWItemId, BuildScreenBlock0EWithWC46FCursor, BuildScreenBlocks0EAnd0F)
; reads: wC46E
BuildScreenBlock0EWithCursor::
Func_003_585D:: ; address name
    call BuildInventoryScreenBase
    ld e, $0E
    farcall CopyBlockToTileBuffer
    ld a, [wC46E]
    and a, $07
    ld hl, Data_003_4617
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ret

; builds block $0E with the cursor, blocks $11 and $1B, and the rectangle chosen by wItemId (Data_003_5C8B to Data_003_5CEE), then runs Func_003_5AA7 (E-0122)
; 2 call sites from 2 routines (e.g. BuildItemScreenWithRecordCursor, PauseMenu_Items_Case02_Case04)
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
    call Func_003_5AA7
    ret

; fills tiles, builds the item screen, copies block $10 and draws the cursor for wC46D & 3 (E-0122)
; 1 call site from 1 routine (e.g. PauseMenu_Items_Case02_Case06)
; reads: wC46D
BuildItemScreenWithRecordCursor::
Func_003_58A6:: ; address name
    call FillTilesFromRequest
    call BuildItemScreenForWItemId
    ld e, $10
    farcall CopyBlockToTileBuffer
    ld a, [wC46D]
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
; reads: wC46F
BuildScreenBlocks0EAnd0FWithCursor::
Func_003_58CF:: ; address name
    call BuildScreenBlocks0EAnd0F
    ld e, $10
    farcall CopyBlockToTileBuffer
    ld a, [wC46F]
    and a, $03
    ld hl, Data_003_461F
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ret

; fills tiles, builds block $0E with the cursor, copies block $10 and draws the cursor for wC46F & 3 (E-0122)
; 2 call sites from 2 routines (e.g. PauseMenu_Items_Case02_Case01, PauseMenu_Items_Case03_Case00)
; reads: wC46F
BuildScreenBlock0EWithWC46FCursor::
Func_003_58E6:: ; address name
    call FillTilesFromRequest
    call BuildScreenBlock0EWithCursor
    ld e, $10
    farcall CopyBlockToTileBuffer
    ld a, [wC46F]
    and a, $03
    ld hl, Data_003_461F
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ret

; inventory slot = (wMenuPage & $0F) * 4 + (wC46E & $0F): shows that item's string of category 6 (the item descriptions of the bank-$08 database; item $1F uses string $6F) at vTiles2 + $230 with size $1203 (ShowStringBank08AtTilesHL_Bank03) (E-0101)
; 5 call sites from 3 routines (e.g. ShowString0Bank09AtTiles16E0ThenItemDescription, PauseMenu_Items_Case00_Case01, PauseMenu_Items_Case00_Case00)
; reads: wMenuPage, wC46E
; writes: wStringIndex, wStringCategory
; points at: wInventory
ShowSelectedItemDescription::
Func_003_5900:: ; address name
    ld a, [wMenuPage]
    and a, $0F
    add a, a
    add a, a
    ld c, a
    ld a, [wC46E]
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

; 4 call sites from 3 routines (e.g. ShowString0Bank09AtTiles16E0ThenItemDescription, ResetInventoryMenuToFirstPage, PauseMenu_Items_Case00_Case01)
; reads: wC52D, wC52E, wC52F, wC530, wInventory, wMenuPage
; writes: wC52F, wC530, wStringCategory, wStringIndex, wC52D, wC52E
; points at: wC61E, wInventory
Func_003_592E::
    ld a, [wC52D]
    ld l, a
    ld a, [wC52E]
    ld h, a
    push hl
    ld a, [wC52F]
    ld l, a
    ld a, [wC530]
    ld h, a
    push hl
    ld hl, $0901
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, [wInventory]
    or a, a
    jr nz, Jump_003_5976
    ld a, $08
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    ld hl, vTiles2 + $5C0
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    farcall ShowString_Bank08
    ld de, wC61E
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
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
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
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    pop hl
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
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
; reads: wC0A7, wMenuPage, wMenuLastPageRows, wC46E
; writes: wMenuRowCount, wC46E
; points at: wMenuPage
SetMenuRowsForPage_Bank03_59DB::
Func_003_59DB:: ; address name
    ld a, [wC0A7]
    dec a
    ld c, a
    ld a, [wMenuPage]
    and a, $0F
    cp a, c
    jr nz, Jump_003_59FC
    ld a, [wMenuLastPageRows]
    ld [wMenuRowCount], a
    ld c, a
    ld a, [wC46E]
    cp a, c
    jr c, Jump_003_5A01
    dec c
    ld a, c
    ld [wC46E], a
    jr Jump_003_5A01

Jump_003_59FC::
    ld a, $04
    ld [wMenuRowCount], a

Jump_003_5A01::
    ld hl, wMenuPage
    res 7, [hl]
    ret

; shows string 0 of category 0 (ShowString_Bank09) at vTiles1 + $6E0 with size $0127, preserving the window, then ShowSelectedItemDescription and Func_003_592E (E-0121)
; 1 call site from 1 routine (e.g. Func_003_4208_Case01)
; reads: wC52D, wC52E, wC52F, wC530
; writes: wC52D, wC52E, wC52F, wC530, wStringCategory, wStringIndex
ShowString0Bank09AtTiles16E0ThenItemDescription::
Func_003_5A07:: ; address name
    ld a, [wC52D]
    ld l, a
    ld a, [wC52E]
    ld h, a
    push hl
    ld a, [wC52F]
    ld l, a
    ld a, [wC530]
    ld h, a
    push hl
    ld hl, vTiles1 + $6E0
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $2701
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, $00
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    farcall ShowString_Bank09
    pop hl
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    pop hl
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    call ShowSelectedItemDescription
    call Func_003_592E
    ret

; counts wInventory items until a $00 or $FF byte (24 slots); a $FF ends the list and that slot and the rest are rewritten as $00. Pages of 4: wMenuPageCount = wC0A7 = ceil(count / 4), at least 1; wMenuLastPageRows = count mod 4, or 4; wMenuRowCount = wMenuLastPageRows when wMenuPage equals the page count, else 4 (E-0067) (the same 79 bytes appear in 2 banks)
; 2 call sites from 2 routines (e.g. ResetInventoryMenuToFirstPage, PauseMenu_Items_Case00_Case00)
; reads: wMenuPage, wMenuLastPageRows
; writes: wMenuPageCount, wC0A7, wMenuLastPageRows, wMenuRowCount
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
    ld [wC0A7], a
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

; 2 call sites from 2 routines (e.g. BuildItemScreenForWItemId, PauseMenu_Items_Case02_Case05)
; reads: wC46D, wItemId, hFFC6, hFFC7
; writes: rRAMG, rRAMB, wStringIndex, wStringCategory, hFFC6, hFFC7, wC2DE, wC2DF, ...
; points at: wC2D9, wC319, wC31D
Func_003_5AA7::
    ld a, [wC46D]
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
    ld de, wC319
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
    ld de, wC31D
    call WriteDecimalDigitTiles
    ld a, $C3
    ld [wC2DE], a
    ld [wC2DF], a
    jp Jump_003_5BFA

Jump_003_5B32::
    ld a, c
    call MapIndexViaWC6FE
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
    ld hl, wC319
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
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
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
    ld hl, Data_003_5C43
    add a, a
    add_a_to_hl
    ld b, [hl]
    ld a, l
    ldh [hFFC6], a
    ld a, h
    ldh [hFFC7], a
    ld hl, wC2D9
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
    ld hl, wC319
    ld b, $07
    ld a, c
    or a, a
    jr z, Jump_003_5BF2
    push hl
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
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
    ld a, [wC46D]
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
; 1 call site from 1 routine (e.g. Func_003_5AA7)
; writes: wC2DF
SetWC2DFTileC2_Bank03_5C16::
Func_003_5C16:: ; address name
    ld a, $C2
    ld [wC2DF], a
    ret

; wC2DF = $C1 (E-0114) (the same 6 bytes appear in 3 banks)
; 1 call site from 1 routine (e.g. Func_003_5AA7)
; writes: wC2DF
SetWC2DFTileC1_Bank03_5C1C::
Func_003_5C1C:: ; address name
    ld a, $C1
    ld [wC2DF], a
    ret

; wC2DE = $C0 (E-0114) (the same 6 bytes appear in 3 banks)
; 1 call site from 1 routine (e.g. Func_003_5AA7)
; writes: wC2DE
SetWC2DETileC0_Bank03_5C22::
Func_003_5C22:: ; address name
    ld a, $C0
    ld [wC2DE], a
    ret

Data_003_5C28:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $08, $05, $04, $07, $05, $06, $08, $06, $09, $09, $07, $07, $06, $08, $08, $05
    db $06, $07, $05, $03, $05, $03, $07, $05, $08, $08, $04

Data_003_5C43:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $00DC43, $48

Data_003_5C8B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $01, $01, $00, $00, $00, $00, $00, $00, $00, $04, $05, $06
    db $07, $00, $01, $02, $02, $02, $02, $02, $02, $03, $03, $03, $03, $03
    ds $22, $00
    ds $23, $08

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
; 5 call sites from 5 routines (e.g. Func_003_4208_Case01, PauseMenu_Items_Case02_Case21, PauseMenu_Items_Case02_Case0A, PauseMenu_Items_Case03_Case06, ...)
; writes: wMenuPage, wC46E, wC0A0, wC0A1
; points at: wMenuPage
ResetInventoryMenuToFirstPage::
Func_003_5E68:: ; address name
    xor a, a
    ld [wMenuPage], a
    xor a, a
    ld [wC46E], a
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
    call Func_003_592E
    xor a, a
    ld [wC0A0], a
    ld [wC0A1], a
    ret

; GameMode2_Update, wModeState 2: the SKILLS list ('No skills' at the start) (E-0046)
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A0
PauseMenu_Skills::
Jump_003_5E89:: ; address name
    ld a, [wC0A0]
    rst $00
    dw PauseMenu_Skills_Case00
    dw PauseMenu_Skills_Case01
    dw PauseMenu_Skills_Case02
    dw PauseMenu_Skills_Case03

; entry 0 of the `rst $00` table in PauseMenu_Skills
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A1
PauseMenu_Skills_Case00::
Jump_003_5E95:: ; address name
    ld a, [wC0A1]
    rst $00
    dw PauseMenu_Skills_Case00_Case00
    dw PauseMenu_Skills_Case00_Case01
    dw PauseMenu_Skills_Case00_Case02
    dw PauseMenu_Skills_Case00_Case03
    dw PauseMenu_Skills_Case00_Case04

; entry 0 of the `rst $00` table in PauseMenu_Skills_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wD095, wMenuPageCount, wC6FD
; writes: rRAMG, rRAMB, wMenuRowCount, wMenuPageCount
; points at: wC0A1
PauseMenu_Skills_Case00_Case00::
Jump_003_5EA3:: ; address name
    ld a, [wD095]
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
    call Func_003_67B0
    ld a, $00
    ld [rRAMG], a
    call CopyTileBufferToBGMap

Jump_003_5EC8::
    ld a, [wC6FD]
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    ld hl, wC0A1
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
; reads: wJoypadPressedRepeat, wJoypadPressed, wC46D
; writes: wMenuPage, rRAMG, rRAMB, wC0A0, wC0A1, wC46E
; points at: wC46D
PauseMenu_Skills_Case00_Case01::
Jump_003_5EF0:: ; address name
    ld de, MenuCursorPositions_Bank03
    ld hl, wC46D
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
    call Func_003_67B0
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
    ld a, [wC46D]
    and a, $03
    ld c, $34
    call SRAMRecordAddressMapped
    ld a, [hl]
    or a, a
    jr z, Jump_003_5F6F
    cp a, $FF
    jr z, Jump_003_5F6F
    ld a, [wC46D]
    ld c, $55
    call SRAMRecordAddressMapped
    bit 7, [hl]
    jr nz, Jump_003_5F6A
    ld a, $01
    ld [wC0A0], a
    xor a, a
    ld [wC0A1], a
    xor a, a
    ld [wMenuPage], a
    xor a, a
    ld [wC46E], a
    jr Jump_003_5F6F

Jump_003_5F6A::
    ld a, $02
    ld [wC0A1], a

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
; points at: wC338, wC0A1
PauseMenu_Skills_Case00_Case02::
Jump_003_5F7C:: ; address name
    call BuildScreenBlocks1CAnd0CWithCursor
    ld hl, vBGMap0 + $1A0
    ld bc, $1405
    ld de, wC338
    call CopyRectToBGMap
    ld hl, wC0A1
    inc [hl]
    ret

; entry 3 of the `rst $00` table in PauseMenu_Skills_Case00
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wC0A1
PauseMenu_Skills_Case00_Case03::
Jump_003_5F90:: ; address name
    ld a, $01
    ld [wStringCategory], a
    ld a, $1A
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank37
    ld hl, wC0A1
    inc [hl]
    ret

; entry 4 of the `rst $00` table in PauseMenu_Skills_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wC0A1
PauseMenu_Skills_Case00_Case04::
Jump_003_5FA5:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    xor a, a
    ld [wC0A1], a
    ret

; entry 1 of the `rst $00` table in PauseMenu_Skills
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A1
PauseMenu_Skills_Case01::
Jump_003_5FAF:: ; address name
    ld a, [wC0A1]
    rst $00
    dw PauseMenu_Skills_Case01_Case00
    dw PauseMenu_Skills_Case01_Case01
    dw PauseMenu_Skills_Case01_Case02
    dw PauseMenu_Skills_Case01_Case03
    dw PauseMenu_Skills_Case01_Case04

; entry 0 of the `rst $00` table in PauseMenu_Skills_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wC46D
; writes: rRAMG, rRAMB, wMenuRowCount
; points at: wC0A1
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
    ld a, [wC46D]
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
    call Func_003_67B0
    call PauseMenu_Skills_Shared05
    ld a, $00
    ld [rRAMG], a
    call CopyTileBufferToBGMap
    ld hl, wC0A1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_Skills_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wMenuRowCount, wJoypadPressed
; writes: rRAMG, rRAMB, wC0A0, wC46F, wC0A1, wStringIndex, wMenuPage
; points at: wC46E, wC39E, wC0A1
PauseMenu_Skills_Case01_Case01::
Jump_003_601D:: ; address name
    ld de, Data_003_4617
    ld hl, wC46E
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
    ld de, wC39E
    call CopyRectToBGMap
    ret

Jump_003_6052::
    ld hl, wC46E
    bit 7, [hl]
    jr z, Jump_003_6083
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    res 7, [hl]
    call SetMenuRowsForPage_Bank03
    call PauseMenu_Skills_Shared02
    call Func_003_67B0
    call PauseMenu_Skills_Shared05
    ld hl, vBGMap0 + $206
    ld bc, $0301
    ld de, wC39E
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
    call LookupWD082ForRecordBuffer
    jr z, Jump_003_60A7
    call PauseMenu_Skills_Case01_Case01_Sub01
    jr nz, Jump_003_60AE
    ld a, $02
    ld [wC0A0], a
    xor a, a
    ld [wC46F], a
    xor a, a
    ld [wC0A1], a
    ret

Jump_003_60A7::
    ld a, $1B
    ld [wStringIndex], a
    jr Jump_003_60B3

Jump_003_60AE::
    ld a, $19
    ld [wStringIndex], a

Jump_003_60B3::
    ld hl, wC0A1
    inc [hl]
    ret

Jump_003_60B8::
    bit 1, a
    ret z
    xor a, a
    ld [wC0A0], a
    ld [wC0A1], a
    ld [wMenuPage], a
    ret

; entry 2 of the `rst $00` table in PauseMenu_Skills_Case01
; no direct call (reached through a table, a jump or a vector)
; points at: wC0A1
PauseMenu_Skills_Case01_Case02::
Jump_003_60C6:: ; address name
    call BuildRecordField5FValueScreenWithCursor
    call PauseMenu_Skills_Shared01
    call PauseMenu_Skills_Shared05
    call CopyTileBufferToBGMap
    ld hl, wC0A1
    inc [hl]
    ret

; entry 3 of the `rst $00` table in PauseMenu_Skills_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory
; points at: wC0A1
PauseMenu_Skills_Case01_Case03::
Jump_003_60D7:: ; address name
    ld a, $01
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37
    ld hl, wC0A1
    inc [hl]
    ret

; entry 4 of the `rst $00` table in PauseMenu_Skills_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wC0A0, wC0A1, wMenuPage
PauseMenu_Skills_Case01_Case04::
Jump_003_60E7:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    xor a, a
    ld [wC0A0], a
    xor a, a
    ld [wC0A1], a
    xor a, a
    ld [wMenuPage], a
    ret

; entry 2 of the `rst $00` table in PauseMenu_Skills
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A1
PauseMenu_Skills_Case02::
Jump_003_60F9:: ; address name
    ld a, [wC0A1]
    rst $00
    dw PauseMenu_Skills_Case02_Case00
    dw PauseMenu_Skills_Case02_Case01
    dw PauseMenu_Skills_Case02_Case02

; entry 0 of the `rst $00` table in PauseMenu_Skills_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wCFF2
; points at: wC0A0, wC0A1
PauseMenu_Skills_Case02_Case00::
Jump_003_6103:: ; address name
    ld a, [wCFF2]
    cp a, $21
    jr z, Jump_003_611B
    call BuildRecordField5FValueScreenWithCursor
    call PauseMenu_Skills_Shared01
    call PauseMenu_Skills_Shared05
    call CopyTileBufferToBGMap
    ld hl, wC0A0
    inc [hl]
    ret

Jump_003_611B::
    ld hl, wC0A1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_Skills_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wC6FD
; writes: rRAMG, rRAMB, wMenuRowCount
; points at: wC0A1
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
    ld a, [wC6FD]
    ld [wMenuRowCount], a
    ld hl, wC0A1
    inc [hl]
    ret

; entry 2 of the `rst $00` table in PauseMenu_Skills_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wC46F, wD083
; writes: rRAMG, rRAMB, wD083, wC0A1, wC0A0, wMenuPage
; points at: wC46F, wC2D9, wC140, wC0A0
PauseMenu_Skills_Case02_Case02::
Jump_003_6149:: ; address name
    ld de, MenuCursorPositions_Bank03
    ld hl, wC46F
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
    ld de, wC2D9
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
    ld a, [wC46F]
    and a, $03
    ld [wD083], a
    call BuildSkillScreenTileBuffer
    call PauseMenu_Skills_Shared03
    call CopyTileBufferToBGMap
    ld a, [wD083]
    ld c, $01
    call SRAMRecordAddressMapped
    ld e, l
    ld d, h
    ld hl, wC140
    call CopyFiveGlyphsPlusMarks
    ld a, $00
    ld [rRAMG], a
    ld hl, wC0A0
    inc [hl]
    xor a, a
    ld [wC0A1], a
    ret

Jump_003_61BD::
    bit 1, a
    ret z
    ld a, $01
    ld [wC0A0], a
    xor a, a
    ld [wC0A1], a
    xor a, a
    ld [wMenuPage], a
    ret

; entry 3 of the `rst $00` table in PauseMenu_Skills
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A1
PauseMenu_Skills_Case03::
Jump_003_61CE:: ; address name
    ld a, [wC0A1]
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
    dw PauseMenu_Skills_Case03_Case0A
    dw PauseMenu_Skills_Case03_Case0B

; entry 0 of the `rst $00` table in PauseMenu_Skills_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wC46D, wRecordBuffer
; writes: rRAMG, rRAMB
; points at: wC130, wC150, wC0A1
PauseMenu_Skills_Case03_Case00::
Jump_003_61EA:: ; address name
    call PauseMenu_Skills_Shared01
    call PauseMenu_Skills_Shared05
    call CopyTileBufferToBGMap
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wC46D]
    ld c, $01
    call SRAMRecordAddressMapped
    ld e, l
    ld d, h
    ld hl, wC130
    call CopyFiveGlyphsPlusMarks
    ld a, [wRecordBuffer]
    ld l, a
    ld h, $04
    ld de, wC150
    call CopyStringHLToDE
    ld a, $00
    ld [rRAMG], a
    ld hl, wC0A1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_Skills_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wD082
; writes: wStringIndex, wStringCategory
; points at: wC0A1
PauseMenu_Skills_Case03_Case01::
Jump_003_6223:: ; address name
    ld a, [wD082]
    ld hl, Data_003_6987
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    call nz, QueueSoundEffect
    ld a, [wD082]
    ld hl, Data_003_69AF
    add_a_to_hl
    ld a, [hl]
    ld [wStringIndex], a
    ld a, $01
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37
    ld hl, wC0A1
    inc [hl]
    ret

; entry 2 of the `rst $00` table in PauseMenu_Skills_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wC46F, wItemId
; writes: wD083, rRAMG, rRAMB
; points at: wC0A1
PauseMenu_Skills_Case03_Case02::
Jump_003_6253:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, [wC46F]
    ld [wD083], a
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    farcall PauseMenu_Skills_Case03_Case02_Sub01
    ld a, $00
    ld [rRAMG], a
    ld hl, wC0A1
    inc [hl]
    ld a, [wItemId]
    cp a, $FF
    ret z
    ld hl, wC0A1
    inc [hl]
    ld hl, wC0A1
    inc [hl]
    ret

; entry 3 of the `rst $00` table in PauseMenu_Skills_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wD08D
; writes: wStringIndex, wStringCategory
; points at: wC0A1
PauseMenu_Skills_Case03_Case03::
Jump_003_6286:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, [wD08D]
    ld [wStringIndex], a
    ld a, $01
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37
    ld hl, wC0A1
    inc [hl]
    ret

; entry 4 of the `rst $00` table in PauseMenu_Skills_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wC0A0, wC0A1, wMenuPage
PauseMenu_Skills_Case03_Case04::
Jump_003_62A1:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    xor a, a
    ld [wC0A0], a
    ld [wC0A1], a
    xor a, a
    ld [wMenuPage], a
    ret

; entry 5 of the `rst $00` table in PauseMenu_Skills_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wRecordBufferData, wC46D, wItemId, wC5E7
; writes: rRAMG, rRAMB, wD08F, wD090, wD08D, wC0A1
; points at: wC0A1
PauseMenu_Skills_Case03_Case05::
Jump_003_62B2:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wRecordBufferData]
    cp a, $FF
    jr nz, Jump_003_62D8
    ld a, [wC46D]
    ld c, $5F
    call SRAMRecordAddressMapped
    deref_hl
    ld a, l
    ld [wD08F], a
    ld a, h
    ld [wD090], a
    jr Jump_003_62DB

Jump_003_62D8::
    ld l, a
    ld h, $00

Jump_003_62DB::
    push hl
    ld a, [wC46D]
    ld c, $5F
    call SRAMRecordAddressMapped
    pop bc
    ld a, [hl]
    sub a, c
    ld [hl+], a
    ld a, [hl]
    sbc a, b
    ld [hl], a
    ld hl, wC0A1
    inc [hl]
    ld a, $00
    ld [rRAMG], a
    ld a, [wItemId]
    cp a, $1E
    ret nz
    call NextTableByte
    ld a, [wC5E7]
    bit 7, a
    ret z
    ld a, $13
    ld [wD08D], a
    ld a, $03
    ld [wC0A1], a
    ret

; entry 6 of the `rst $00` table in PauseMenu_Skills_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wD082
; points at: wC0A1
PauseMenu_Skills_Case03_Case06::
Jump_003_630E:: ; address name
    ld a, [wD082]
    ld hl, Data_003_699B
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    call nz, QueueSoundEffect
    ld hl, wC0A1
    inc [hl]
    ret

; entry 7 of the `rst $00` table in PauseMenu_Skills_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wItemId, wD08D
; writes: rRAMG, rRAMB, wStringCategory, wStringIndex
; points at: wC0A1
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
    ld a, [wD08D]
    ld [wStringIndex], a
    cp a, $FF
    jr z, Jump_003_6364
    farcall BeginStringDisplay_Bank37

Jump_003_6364::
    ld hl, wC0A1
    inc [hl]
    ret

; entry 8 of the `rst $00` table in PauseMenu_Skills_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wD082
; points at: wC0A1
PauseMenu_Skills_Case03_Case08::
Jump_003_6369:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    ld hl, wC0A1
    inc [hl]
    ld a, [wD082]
    cp a, $10
    ret z
    ld hl, wC0A1
    inc [hl]
    ld a, [wD082]
    cp a, $11
    ret z
    ld hl, wC0A1
    inc [hl]
    ret

; entry 9 of the `rst $00` table in PauseMenu_Skills_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wItemId, wD09E
; writes: wStringCategory, wStringIndex, wItemId, wC0A1
; points at: wD09F, wC160, wD09E
PauseMenu_Skills_Case03_Case09::
Jump_003_6387:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, [wItemId]
    cp a, $FF
    jr z, Jump_003_63CA
    ld a, [wD09E]
    ld hl, wD09F
    add a, a
    add_a_to_hl
    deref_hl
    ld a, h
    add a, $02
    ld h, a
    ld de, wC160
    call CopyStringHLToDE
    ld a, $01
    ld [wStringCategory], a
    ld a, $0C
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank37
    ld hl, wD09E
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
    ld [wC0A1], a
    ret

; entry 10 of the `rst $00` table in PauseMenu_Skills_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wItemId
; writes: wStringIndex, wStringCategory, wC0A1
PauseMenu_Skills_Case03_Case0A::
Jump_003_63D0:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    ld a, [wItemId]
    cp a, $FF
    jr z, Jump_003_63E3
    ld a, $0F
    ld [wStringIndex], a
    jr Jump_003_63E8

Jump_003_63E3::
    ld a, $10
    ld [wStringIndex], a

Jump_003_63E8::
    ld a, $01
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank37
    ld a, $0B
    ld [wC0A1], a
    ret

; entry 11 of the `rst $00` table in PauseMenu_Skills_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wDataBankSave, wItemId
; writes: wC0A0, wC0A1, wMenuPage, wC46E
PauseMenu_Skills_Case03_Case0B::
Jump_003_63F9:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    xor a, a
    ld [wC0A0], a
    ld [wC0A1], a
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
    ld [wC46E], a
    ret

; clears the screen tile buffer and copies blocks $1C and $0C into it (CopyBlockToTileBuffer) (E-0101)
; 4 call sites from 4 routines (e.g. Func_003_4208_Case02, BuildScreenBlocks1CAnd0CWithCursor, PauseMenu_Skills_Case00_Case00, BuildRecordField5FValueScreen)
LoadScreenBlocks1CAnd0C::
Func_003_641E:: ; address name
    call ClearScreenTileBuffer_Bank03
    ld e, $1C
    farcall CopyBlockToTileBuffer
    ld e, $0C
    farcall CopyBlockToTileBuffer
    ret

; only called from routines of PauseMenu_Skills (E-0098)
; 8 call sites from 7 routines (e.g. PauseMenu_Skills_Case00_Case01, PauseMenu_Skills_Case00_Case00, PauseMenu_Skills_Case01_Case02, PauseMenu_Skills_Case01_Case00, ...)
; reads: wC46D, wC0A7, wMenuPage
; points at: wC2A6
PauseMenu_Skills_Shared01::
Func_003_6432:: ; address name
    ld a, [wC46D]
    and a, $03
    ld c, $34
    call SRAMRecordAddressMapped
    ld d, h
    ld e, l
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_003_6450

Jump_003_6443::
    ld de, Data_003_6A98
    ld bc, $0501
    ld hl, wC2A6
    call CopyRectToBGMap
    ret

Jump_003_6450::
    ld a, [wC0A7]
    cp a, $01
    jr z, Jump_003_6443
    ld hl, wC2A6
    ld a, $C5
    ld [hl+], a
    ld a, [wMenuPage]
    add a, $E1
    ld [hl+], a
    ld a, $BE
    ld [hl+], a
    ld a, [wC0A7]
    add a, $E0
    ld [hl+], a
    ld [hl], $C6
    ret

; loads blocks $1C, $0C and $1D, writes field $5F of record wC46D & 3 as decimal digits at wC3A2 and draws the cursor for wC46D & 3 (E-0122)
; 2 call sites from 2 routines (e.g. BuildRecordField5FValueScreenWithCursor, PauseMenu_Skills_Case01_Case00)
; reads: wC46D
; points at: wC3A2
BuildRecordField5FValueScreen::
Func_003_646F:: ; address name
    call LoadScreenBlocks1CAnd0C
    ld e, $1D
    farcall CopyBlockToTileBuffer
    ld a, [wC46D]
    and a, $03
    ld c, $5F
    call SRAMRecordAddressMapped
    deref_hl
    call HLToDecimalDigits
    ld de, wC3A2
    call WriteDecimalDigitTiles
    ld a, [wC46D]
    and a, $03
    ld hl, MenuCursorPositions_Bank03
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ret

; only called from PauseMenu_Skills_Case02_Case01 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Case02_Case01)
; reads: wC46D, wRecordBufferData, wC46E, wRecordBuffer, wCFED
; points at: wC3A2, wC39E
PauseMenu_Skills_Case02_Case01_Sub01::
Func_003_649C:: ; address name
    call ClearScreenTileBuffer_Bank03
    ld e, $20
    farcall CopyBlockToTileBuffer
    ld e, $0C
    farcall CopyBlockToTileBuffer
    ld e, $1D
    farcall CopyBlockToTileBuffer
    ld a, [wC46D]
    and a, $03
    ld c, $5F
    call SRAMRecordAddressMapped
    deref_hl
    call HLToDecimalDigits
    ld de, wC3A2
    call WriteDecimalDigitTiles
    ld a, [wRecordBufferData]
    cp a, $FF
    jr z, Jump_003_64DA
    ld l, a
    ld h, $00
    call HLToDecimalDigits

Jump_003_64DA::
    ld de, wC39E
    call WriteDecimalDigitTiles
    ld a, [wC46E]
    and a, $07
    ld hl, Data_003_4617
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ld a, [wRecordBuffer]
    ld l, a
    ld a, [wCFED]
    ld h, a
    ld a, l
    add a, $51
    ld l, a
    ld a, h
    adc a, $68
    ld h, a
    ld a, [hl]
    ld hl, Data_003_6921
    add a, a
    add_a_to_hl
    deref_hl
    call CopyRecordRectToScreenBuffer_Bank03
    ret

; fills tiles, builds the field-$5F screen, draws the cursor for wC46E & 7 and copies block $10 (E-0122)
; 2 call sites from 2 routines (e.g. PauseMenu_Skills_Case01_Case02, PauseMenu_Skills_Case02_Case00)
; reads: wC46E
BuildRecordField5FValueScreenWithCursor::
Func_003_650C:: ; address name
    call FillTilesFromRequest
    call BuildRecordField5FValueScreen
    ld a, [wC46E]
    and a, $07
    ld hl, Data_003_4617
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ld e, $10
    farcall CopyBlockToTileBuffer
    ret

; fills the screen tile buffer: blocks $20 and $0C, cursor marks for wC46E and wC46F, the rectangle chosen by the skill wRecordBuffer (table $6851 to Data_003_6921), then block $10 (E-0121)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Case02_Case02)
; reads: wC46E, wC46F, wRecordBuffer, wCFED
BuildSkillScreenTileBuffer::
Func_003_6526:: ; address name
    call FillTilesFromRequest
    call ClearScreenTileBuffer_Bank03
    ld e, $20
    farcall CopyBlockToTileBuffer
    ld e, $0C
    farcall CopyBlockToTileBuffer
    ld a, [wC46E]
    and a, $07
    ld hl, Data_003_4617
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ld a, [wC46F]
    and a, $03
    ld hl, MenuCursorPositions_Bank03
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ld a, [wRecordBuffer]
    ld l, a
    ld a, [wCFED]
    ld h, a
    ld a, l
    add a, $51
    ld l, a
    ld a, h
    adc a, $68
    ld h, a
    ld a, [hl]
    ld hl, Data_003_6921
    add a, a
    add_a_to_hl
    deref_hl
    call CopyRecordRectToScreenBuffer_Bank03
    ld e, $10
    farcall CopyBlockToTileBuffer
    ret

; fills tiles, loads blocks $1C and $0C, draws the cursor for wC46D & 3 and copies block $10 (E-0122)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Case00_Case02)
; reads: wC46D
BuildScreenBlocks1CAnd0CWithCursor::
Func_003_657B:: ; address name
    call FillTilesFromRequest
    call LoadScreenBlocks1CAnd0C
    ld a, [wC46D]
    and a, $03
    ld hl, MenuCursorPositions_Bank03
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ld e, $10
    farcall CopyBlockToTileBuffer
    ret

; shows string 1 of category 0 (ShowString_Bank09) at vTiles1 + $6E0 with size $0107, preserving the window, then Func_003_67B0 (E-0121)
; 1 call site from 1 routine (e.g. Func_003_4208_Case02)
; reads: wC52D, wC52E, wC52F, wC530
; writes: wC52D, wC52E, wC52F, wC530, wStringCategory, wStringIndex
ShowString1Bank09AtTiles16E0ThenDetails::
Func_003_6595:: ; address name
    ld a, [wC52D]
    ld l, a
    ld a, [wC52E]
    ld h, a
    push hl
    ld a, [wC52F]
    ld l, a
    ld a, [wC530]
    ld h, a
    push hl
    ld hl, vTiles1 + $6E0
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0701
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, $00
    ld [wStringCategory], a
    ld a, $01
    ld [wStringIndex], a
    farcall ShowString_Bank09
    pop hl
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    pop hl
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    call Func_003_67B0
    ret

; only called from routines of PauseMenu_Skills (E-0098)
; 3 call sites from 2 routines (e.g. PauseMenu_Skills_Case01_Case01, PauseMenu_Skills_Case01_Case00)
; reads: wC46D, wC46E, wMenuPage, wRecordBufferData
; writes: wStringIndex, wRecordBuffer, wItemId, wCFED, wStringCategory
; points at: wC39E
PauseMenu_Skills_Shared02::
Func_003_65E3:: ; address name
    ld a, [wC46D]
    and a, $03
    ld c, $34
    call SRAMRecordAddressMapped
    ld a, [wC46E]
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
    ld [wCFED], a
    farcall LoadSkillRecord
    ld a, [wRecordBufferData]
    cp a, $FF
    jr z, Jump_003_6625
    ld l, a
    ld h, $00
    jr Jump_003_6632

Jump_003_6625::
    ld a, [wC46D]
    and a, $03
    ld c, $5F
    call SRAMRecordAddressMapped
    deref_hl

Jump_003_6632::
    call HLToDecimalDigits
    ld de, wC39E
    call WriteDecimalDigitTiles
    ld a, $09
    ld [wStringCategory], a
    ld hl, vTiles2 + $230
    ld de, $1203
    call ShowStringBank08AtTilesHL_Bank03
    ret

; only called from routines of PauseMenu_Skills (E-0098)
; 3 call sites from 2 routines (e.g. PauseMenu_Skills_Case02_Case02, PauseMenu_Skills_Case02_Case01)
; reads: wRecordBuffer, wCFED, wC46F
; writes: wC2DE, wC2DF
; points at: wC319, wC31D
PauseMenu_Skills_Shared03::
Func_003_664A:: ; address name
    ld a, [wRecordBuffer]
    ld l, a
    ld a, [wCFED]
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
    ld a, [wC46F]
    and a, $03
    call SRAMRecordAddressMapped
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wC319
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    deref_hl
    call HLToDecimalDigits
    ld de, wC31D
    call WriteDecimalDigitTiles
    ld a, [wC46F]
    and a, $03
    ld c, $55
    call SRAMRecordAddressMapped
    ld a, $C3
    ld [wC2DE], a
    ld [wC2DF], a
    bit 7, [hl]
    call nz, SetWC2DFTileC2_Bank03
    bit 2, [hl]
    call nz, SetWC2DFTileC1_Bank03
    bit 0, [hl]
    call nz, SetWC2DETileC0_Bank03
    ret

; wC2DF = $C2 (E-0114) (the same 6 bytes appear in 3 banks)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Shared03)
; writes: wC2DF
SetWC2DFTileC2_Bank03::
Func_003_66A9:: ; address name
    ld a, $C2
    ld [wC2DF], a
    ret

; wC2DF = $C1 (E-0114) (the same 6 bytes appear in 3 banks)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Shared03)
; writes: wC2DF
SetWC2DFTileC1_Bank03::
Func_003_66AF:: ; address name
    ld a, $C1
    ld [wC2DF], a
    ret

; wC2DE = $C0 (E-0114) (the same 6 bytes appear in 3 banks)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Shared03)
; writes: wC2DE
SetWC2DETileC0_Bank03::
Func_003_66B5:: ; address name
    ld a, $C0
    ld [wC2DE], a
    ret

; only called from PauseMenu_Skills_Case01_Case01 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_Skills_Case01_Case01)
; reads: wC46D, wRecordBufferData
; writes: rRAMG, rRAMB
PauseMenu_Skills_Case01_Case01_Sub01::
Func_003_66BB:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wC46D]
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
; writes: wD082
LookupWD082ForRecordBuffer::
Func_003_66EE:: ; address name
    ld a, [wRecordBuffer]
    ld hl, Data_003_6700
    add_a_to_hl
    ld a, [hl]
    ld [wD082], a
    cp a, $FF
    ret

Data_003_6700:: ; heuristic: pointer load in the same bank (bank assumed); C0
    ds $16, $FF
    db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $FF, $0A, $FF, $FF, $0B
    ds $7D, $FF
    db $0C, $0D, $0E, $0F, $10, $11, $12, $13, $FF, $FF, $FF, $FF, $FF, $FF

; 5 call sites from 5 routines (e.g. ShowString1Bank09AtTiles16E0ThenDetails, PauseMenu_Skills_Case00_Case01, PauseMenu_Skills_Case00_Case00, PauseMenu_Skills_Case01_Case01, ...)
; reads: wC52D, wC52E, wC52F, wC530, wC46D, wMenuPage
; writes: wC52F, wC530, wStringCategory, wStringIndex, wC52D, wC52E
Func_003_67B0::
    ld a, [wC52D]
    ld l, a
    ld a, [wC52E]
    ld h, a
    push hl
    ld a, [wC52F]
    ld l, a
    ld a, [wC530]
    ld h, a
    push hl
    ld hl, $0901
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, [wC46D]
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
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
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
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
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
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    pop hl
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ret
    ds $1B, $00
    db $01, $01, $01
    ds $B2, $00

Data_003_6921:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $00E921, $66

Data_003_6987:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $7A, $7A, $7A, $7A, $7A, $7A, $7A, $7A, $7A, $7A, $7A, $7A, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF

Data_003_699B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $85, $85, $85, $85, $85, $85, $85, $85, $85, $85, $85, $85, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF

Data_003_69AF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $02, $00, $00
    db $03, $04, $05, $00

; only called from routines of PauseMenu_Skills (E-0098)
; 2 call sites from 2 routines (e.g. PauseMenu_Skills_Case00_Case01, PauseMenu_Skills_Case00_Case00)
; reads: wC46D
; writes: wMenuPageCount, wC0A7, wMenuLastPageRows
PauseMenu_Skills_Shared04::
Func_003_69C3:: ; address name
    ld a, [wC46D]
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
    ld [wC0A7], a
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
; writes: wMenuPageCount, wC0A7, wMenuLastPageRows
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
    ld [wC0A7], a
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
; reads: wC0A7, wMenuPage, wMenuLastPageRows, wC46E
; writes: wMenuRowCount, wC46E
; points at: wMenuPage
SetMenuRowsForPage_Bank03::
Func_003_6A34:: ; address name
    ld a, [wC0A7]
    dec a
    ld c, a
    ld a, [wMenuPage]
    and a, $0F
    cp a, c
    jr nz, Jump_003_6A55
    ld a, [wMenuLastPageRows]
    ld [wMenuRowCount], a
    ld c, a
    ld a, [wC46E]
    cp a, c
    jr c, Jump_003_6A5A
    dec c
    ld a, c
    ld [wC46E], a
    jr Jump_003_6A5A

Jump_003_6A55::
    ld a, $04
    ld [wMenuRowCount], a

Jump_003_6A5A::
    ld hl, wMenuPage
    res 7, [hl]
    ret

; only called from routines of PauseMenu_Skills (E-0098)
; 8 call sites from 7 routines (e.g. PauseMenu_Skills_Case00_Case01, PauseMenu_Skills_Case01_Case02, PauseMenu_Skills_Case01_Case01, PauseMenu_Skills_Case01_Case00, ...)
; reads: wC46D, wC0A7, wMenuPageCount, wMenuPage
; points at: wC2A6
PauseMenu_Skills_Shared05::
Func_003_6A60:: ; address name
    ld a, [wC46D]
    and a, $03
    ld c, $34
    call SRAMRecordAddressMapped
    ld d, h
    ld e, l
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_003_6A7E

Jump_003_6A71::
    ld de, Data_003_6A98
    ld bc, $0501
    ld hl, wC2A6
    call CopyRectToBGMap
    ret

Jump_003_6A7E::
    ld a, [wC0A7]
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

Data_003_6A98:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B4, $B4, $B4, $B4, $B4

; GameMode2_Update, wModeState 3: an item list screen (state 3) (E-0046)
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A0
PauseMenu_State3::
Jump_003_6A9D:: ; address name
    ld a, [wC0A0]
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
; reads: wC0A1
PauseMenu_State3_Case00::
Jump_003_6AAF:: ; address name
    ld a, [wC0A1]
    rst $00
    dw PauseMenu_State3_Case00_Case00
    dw PauseMenu_State3_Case00_Case01
    dw PauseMenu_State3_Case00_Case02
    dw PauseMenu_State3_Case00_Case03

; entry 0 of the `rst $00` table in PauseMenu_State3_Case00
; no direct call (reached through a table, a jump or a vector)
; writes: wMenuRowCount, wMenuPageCount
; points at: wC0A1
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
    ld hl, wC0A1
    inc [hl]
    call FillTiles21E0PreservingWindow
    ret

; entry 1 of the `rst $00` table in PauseMenu_State3_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wC46D
; writes: wC0A0, wC0A1, wMenuPage, wC46E
; points at: wC46D, wC0A1
PauseMenu_State3_Case00_Case01::
Jump_003_6ADC:: ; address name
    ld hl, wC46D
    ld de, MenuCursorPositions_Bank03
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_6B2C
    ld a, $69
    call QueueSoundEffect
    ld a, [wC46D]
    and a, $07
    ld hl, MenuCursorPositions_Bank03
    call WriteBCTileAtWordTableEntry_Bank03
    ld a, [wC46D]
    and a, $07
    inc a
    ld [wC0A0], a
    cp a, $06
    jr nz, Jump_003_6B1F
    call Bank16Func4645ResultTest
    jr z, Jump_003_6B1F
    ld e, $10
    farcall CopyBlockToTileBuffer
    xor a, a
    ld [wC0A0], a
    ld hl, wC0A1
    inc [hl]
    ret

Jump_003_6B1F::
    xor a, a
    ld [wC0A1], a
    xor a, a
    ld [wMenuPage], a
    xor a, a
    ld [wC46E], a
    ret

Jump_003_6B2C::
    bit 1, a
    ret z
    call ExitPauseMenuToField
    ret

; entry 2 of the `rst $00` table in PauseMenu_State3_Case00
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wC338, wC0A1
PauseMenu_State3_Case00_Case02::
Jump_003_6B33:: ; address name
    ld hl, vBGMap0 + $1A0
    ld de, wC338
    ld bc, $1405
    call CopyRectToBGMap
    ld a, $08
    ld [wStringCategory], a
    ld a, $0D
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    ld hl, wC0A1
    inc [hl]
    ret

; entry 3 of the `rst $00` table in PauseMenu_State3_Case00
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wC0A1
PauseMenu_State3_Case00_Case03::
Jump_003_6B54:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    xor a, a
    ld [wC0A1], a
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
; reads: wC0A1
PauseMenu_State3_Case01::
Jump_003_6B67:: ; address name
    ld a, [wC0A1]
    rst $00
    dw PauseMenu_State3_Case01_Case00
    dw PauseMenu_State3_Case01_Case01
    dw PauseMenu_State3_Case01_Case02
    dw PauseMenu_State3_Case01_Case03
    dw PauseMenu_State3_Case01_Case04
    dw PauseMenu_State3_Case01_Case05
    dw PauseMenu_State3_Case01_Case06
    dw PauseMenu_State3_Case01_Case07
    dw PauseMenu_State3_Case01_Case08
    dw PauseMenu_State3_Case01_Case09
    dw PauseMenu_State3_Case01_Case0A
    dw PauseMenu_State3_Case01_Case0B
    dw PauseMenu_State3_Case01_Case0C
    dw PauseMenu_State3_Case01_Case0D
    dw PauseMenu_State3_Case01_Case0E
    dw PauseMenu_State3_Case01_Case0F
    dw PauseMenu_State3_Case01_Case10

; entry 0 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; points at: wC52D, wC0A1
PauseMenu_State3_Case01_Case00::
Jump_003_6B8D:: ; address name
    ld hl, vTiles2 + $710
    ld de, Data_01F_4910
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $720
    ld de, Data_01F_4910
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $730
    ld de, Data_01F_4910
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    call BuildScreenBlocks21To23
    ld hl, wC52D
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
    ld hl, wC0A1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wD0C7, wJoypadPressed, wC836, wJoypadPressedRepeat, wMenuPageCount, wC3C7, wC46E, wModeState
; writes: wC836, wC0A1, wC0A0, wDataBankSave
; points at: wC46E, wC0A1
PauseMenu_State3_Case01_Case01::
Jump_003_6BD7:: ; address name
    ld a, [wD0C7]
    or a, a
    jr z, Jump_003_6C52
    ld hl, wC46E
    ld de, Data_003_462B
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    and a, $04
    jr z, Jump_003_6C05
    ld a, $69
    call QueueSoundEffect
    ld a, [wC836]
    bit 7, a
    jr nz, Jump_003_6BFB
    xor a, $02

Jump_003_6BFB::
    res 7, a
    ld [wC836], a
    xor a, a
    ld [wC0A1], a
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
    call ComputeMenuPagesForWD0C7Items
    ld hl, vBGMap0 + $22F
    ld a, [wC3C7]
    call WriteVRAMByte
    ret

Jump_003_6C36::
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_6C52
    ld a, $69
    call QueueSoundEffect
    ld a, [wC46E]
    and a, $07
    ld hl, Data_003_462B
    call WriteBCTileAtWordTableEntry_Bank03
    ld hl, wC0A1
    inc [hl]
    ret

Jump_003_6C52::
    ld a, [wJoypadPressed]
    bit 1, a
    ret z
    xor a, a
    ld [wC0A0], a
    ld [wC0A1], a
    ld a, [wModeState]
    bit 3, a
    ret z
    ld a, $40
    ld [wDataBankSave], a
    call ExitPauseMenuToField
    ret

; entry 2 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wMenuRowCount, wMenuPageCount, wC46F
; points at: wScreenTileBuffer, wC0A1
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
    ld [wC46F], a
    ld hl, wC0A1
    inc [hl]
    ret

; entry 3 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wC46F, wC833, wCC44
; writes: wC0A1, wStringIndex, wStringCategory, wStringDestLo, wStringDestHi
; points at: wC46F, wC0A1, wC150
PauseMenu_State3_Case01_Case03::
Jump_003_6C90:: ; address name
    ld hl, wC46F
    ld de, Data_003_4633
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jp z, Jump_003_6D29
    ld a, $69
    call QueueSoundEffect
    ld a, [wC46F]
    and a, $01
    jr nz, Jump_003_6CB2
    ld hl, wC0A1
    inc [hl]
    ret

Jump_003_6CB2::
    call TestListEntryBit7
    jr nz, Jump_003_6CEE
    push af
    ld c, a
    ld a, [wC833]
    cp a, c
    jr nz, Jump_003_6CC9
    ld a, [wCC44]
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
    ld de, wC150
    call WriteKeyNameToDE
    ld a, $0A
    ld [wC0A1], a
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
    ld hl, wC150
    ld a, l
    ld [wStringDestLo], a
    ld a, h
    ld [wStringDestHi], a
    farcall CopyStringToBuffer_Bank09
    ld a, $0A
    ld [wC0A1], a
    ret

Jump_003_6D23::
    ld a, $07
    ld [wC0A1], a
    ret

Jump_003_6D29::
    bit 1, a
    ret z
    xor a, a
    ld [wC0A1], a
    ret

; entry 4 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; points at: wC0A1
PauseMenu_State3_Case01_Case04::
Jump_003_6D31:: ; address name
    call PauseMenu_State3_Shared04
    ld hl, wC0A1
    inc [hl]
    ret

; entry 5 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wModeState
; writes: wDataBankSave, wStringIndex, wStringCategory
; points at: wC0A1
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
    ld hl, wC0A1
    inc [hl]
    ret

; entry 6 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wModeState
; writes: wC0A1
PauseMenu_State3_Case01_Case06::
Jump_003_6D90:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    xor a, a
    ld [wC0A1], a
    ld a, [wModeState]
    bit 3, a
    ret z
    call ExitPauseMenuToField
    ret

; entry 7 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; points at: wC0A1
PauseMenu_State3_Case01_Case07::
Jump_003_6DA3:: ; address name
    call PauseMenu_State3_Shared04
    ld hl, wC0A1
    inc [hl]
    ret

; entry 8 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wC0A1
PauseMenu_State3_Case01_Case08::
Jump_003_6DAB:: ; address name
    ld a, $08
    ld [wStringCategory], a
    ld a, $08
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    ld hl, wC0A1
    inc [hl]
    ret

; entry 9 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wC0A1
PauseMenu_State3_Case01_Case09::
Jump_003_6DC0:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    xor a, a
    ld [wC0A1], a
    ret

; entry 10 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wMenuRowCount, wMenuPageCount
; points at: wC0A1
PauseMenu_State3_Case01_Case0A::
Jump_003_6DCA:: ; address name
    call PauseMenu_State3_Shared04
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    ld hl, wC0A1
    inc [hl]
    ret

; entry 11 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wC0A1
PauseMenu_State3_Case01_Case0B::
Jump_003_6DDC:: ; address name
    ld a, $08
    ld [wStringCategory], a
    ld a, $07
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank08
    ld hl, wC0A1
    inc [hl]
    ret

; entry 12 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; points at: wC0A1
PauseMenu_State3_Case01_Case0C::
Jump_003_6DF1:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    ld hl, wC0A1
    inc [hl]
    ret

; entry 13 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wMenuRowCount, wMenuPageCount, wC470
; points at: wC278, wC0A1
PauseMenu_State3_Case01_Case0D::
Jump_003_6DFB:: ; address name
    call BuildScreenBlocks21To25WithCursor
    ld hl, vBGMap0 + $E0
    ld de, wC278
    ld bc, $0605
    call CopyRectToBGMap
    ld a, $6C
    call QueueSoundEffect
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    xor a, a
    ld [wC470], a
    ld a, $01
    ld [wC470], a
    ld hl, wC0A1
    inc [hl]
    ret

; entry 14 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wC470
; writes: wMenuRowCount, wMenuPageCount, wC46F, wC0A1
; points at: wC470, wC0A1, wC218, wC338
PauseMenu_State3_Case01_Case0E::
Jump_003_6E27:: ; address name
    ld hl, wC470
    ld de, Data_003_4627
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_6E53
    ld a, $69
    call QueueSoundEffect
    ld a, [wC470]
    and a, $01
    ld hl, Data_003_4627
    call WriteBCTileAtWordTableEntry_Bank03
    ld a, [wC470]
    and a, $01
    jr nz, Jump_003_6E56
    ld hl, wC0A1
    inc [hl]
    ret

Jump_003_6E53::
    bit 1, a
    ret z

Jump_003_6E56::
    call BuildScreenBlocks21To24
    ld hl, vBGMap0 + $80
    ld de, wC218
    ld bc, $0609
    call CopyRectToBGMap
    ld hl, vBGMap0 + $1A0
    ld de, wC338
    ld bc, $1405
    call CopyRectToBGMap
    call PauseMenu_State3_Shared06
    ld a, $02
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    xor a, a
    ld [wC46F], a
    ld a, $03
    ld [wC0A1], a
    ret

; entry 15 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wStringIndex, wStringCategory
; points at: wC0A1
PauseMenu_State3_Case01_Case0F::
Jump_003_6E88:: ; address name
    ld a, $04
    ld [wStringIndex], a
    ld a, $08
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank08
    ld hl, wC0A1
    inc [hl]
    ret

; entry 16 of the `rst $00` table in PauseMenu_State3_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wC0A1, hFFC6, wMenuPage, wC46E
PauseMenu_State3_Case01_Case10::
Jump_003_6E9D:: ; address name
    ld a, [wC52B]
    or a, a
    ret nz
    xor a, a
    ld [wC0A1], a
    call TestListEntryBit7
    jr z, Jump_003_6EAF
    res 7, a
    and a, $3F

Jump_003_6EAF::
    ldh [hFFC6], a
    farcall Func_012_69B0
    xor a, a
    ld [wMenuPage], a
    ld [wC46E], a
    ret

; index = wMenuPage * 4 + (wC46E & 7): A = wD0A7[index], Z clear when its bit 7 is set (E-0117)
; 4 call sites from 3 routines (e.g. PauseMenu_State3_Case01_Case10, PauseMenu_State3_Case01_Case05, PauseMenu_State3_Case01_Case03)
; reads: wMenuPage, wC46E
; points at: wD0A7
TestListEntryBit7::
Func_003_6EBF:: ; address name
    ld a, [wMenuPage]
    ld b, a
    add a, a
    add a, a
    ld b, a
    ld a, [wC46E]
    and a, $07
    add a, b
    ld hl, wD0A7
    add_a_to_hl
    ld a, [hl]
    bit 7, a
    ret

; entry 2 of the `rst $00` table in PauseMenu_State3
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A1
PauseMenu_State3_Case02::
Jump_003_6ED8:: ; address name
    ld a, [wC0A1]
    rst $00
    dw PauseMenu_State3_Case02_Case00
    dw PauseMenu_State3_Case02_Case01
    dw PauseMenu_State3_Case02_Case02

; entry 0 of the `rst $00` table in PauseMenu_State3_Case02
; no direct call (reached through a table, a jump or a vector)
; writes: wC0A8, wMenuRowCount, wMenuPageCount, wMenuPage
; points at: wC0A1
PauseMenu_State3_Case02_Case00::
Jump_003_6EE2:: ; address name
    xor a, a
    ld [wC0A8], a
    call PauseMenu_State3_Case02_Case00_Sub01
    call CopyTileBufferToBGMap
    ld a, $04
    ld [wMenuRowCount], a
    ld a, $01
    ld [wMenuPageCount], a
    ld a, $00
    ld [wMenuPage], a
    ld hl, wC0A1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_State3_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A8
; writes: rRAMG, rRAMB, wC46E
; points at: wC286, wC282, wC0A1
PauseMenu_State3_Case02_Case01::
Jump_003_6F00:: ; address name
    ld a, [wC0A8]
    ld hl, Data_003_6FBB
    add_a_to_hl
    ld a, [hl]
    ld hl, wC286
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
    ld de, wC282
    ld bc, $090A
    call CopyRectToBGMap
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wC0A8]
    ld c, $0E
    call SRAMRecordAddressMapped
    ld a, [hl]
    swap a
    and a, $03
    ld [wC46E], a
    ld a, $00
    ld [rRAMG], a
    ld hl, wC0A1
    inc [hl]
    ret

; entry 2 of the `rst $00` table in PauseMenu_State3_Case02
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wC0A8, wC46E, wC6FD
; writes: wC0A8, wC0A0, wC0A1, rRAMG, rRAMB
; points at: wC46E, wC0A1
PauseMenu_State3_Case02_Case02::
Jump_003_6F48:: ; address name
    ld hl, wC46E
    ld de, Data_003_4637
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 1, a
    jr z, Jump_003_6F6F
    ld a, [wC0A8]
    or a, a
    jr z, Jump_003_6F67
    dec a
    ld [wC0A8], a
    ld hl, wC0A1
    dec [hl]
    ret

Jump_003_6F67::
    xor a, a
    ld [wC0A0], a
    ld [wC0A1], a
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
    ld a, [wC0A8]
    ld c, $0E
    call SRAMRecordAddressMapped
    ld a, [wC46E]
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
    ld a, [wC6FD]
    ld c, a
    ld a, [wC0A8]
    inc a
    ld [wC0A8], a
    cp a, c
    jr z, Jump_003_6F67
    ld hl, wC0A1
    dec [hl]
    ret

Data_003_6FBB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $D5, $DA

; entry 3 of the `rst $00` table in PauseMenu_State3
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A1
PauseMenu_State3_Case03::
Jump_003_6FBE:: ; address name
    ld a, [wC0A1]
    rst $00
    dw PauseMenu_State3_Case03_Case00
    dw PauseMenu_State3_Case03_Case01

; entry 0 of the `rst $00` table in PauseMenu_State3_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wC834
; writes: wC46E
; points at: wC0A1
PauseMenu_State3_Case03_Case00::
Jump_003_6FC6:: ; address name
    call LoadScreenBlock21CursorAnd2C
    call CopyTileBufferToBGMap
    ld a, [wC834]
    ld [wC46E], a
    ld hl, wC0A1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_State3_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wC46E, wJoypadPressedRepeat, wFrameCounterLo
; writes: wC834, wC0A0, wC0A1, wC46E, wFrameCounterLo
PauseMenu_State3_Case03_Case01::
Jump_003_6FD7:: ; address name
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_6FED
    ld a, $69
    call QueueSoundEffect
    ld a, [wC46E]
    and a, $07
    ld [wC834], a
    jr Jump_003_6FF1

Jump_003_6FED::
    bit 1, a
    jr z, Jump_003_6FF9

Jump_003_6FF1::
    xor a, a
    ld [wC0A0], a
    ld [wC0A1], a
    ret

Jump_003_6FF9::
    ld a, [wJoypadPressedRepeat]
    bit 5, a
    jr z, Jump_003_7009
    call EraseMenuCursorWC46E
    ld a, [wC46E]
    dec a
    jr Jump_003_7014

Jump_003_7009::
    bit 4, a
    jr z, Jump_003_702A
    call EraseMenuCursorWC46E
    ld a, [wC46E]
    inc a

Jump_003_7014::
    and a, $07
    ld [wC46E], a
    call DrawMenuCursorWC46E
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
    call DrawMenuCursorWC46E
    jr Jump_003_7048

Jump_003_703D::
    call EraseMenuCursorWC46E
    ld a, [wFrameCounterLo]
    set 3, a
    ld [wFrameCounterLo], a

Jump_003_7048::
    ret

; writes the cursor tile $BB at MenuCursorAddressWC46E (E-0114)
; 2 call sites from 1 routine (e.g. PauseMenu_State3_Case03_Case01)
DrawMenuCursorWC46E::
Func_003_7049:: ; address name
    call MenuCursorAddressWC46E
    ld a, $BB
    call WriteVRAMByte
    ret

; writes the blank tile $C3 at MenuCursorAddressWC46E (E-0114)
; 3 call sites from 1 routine (e.g. PauseMenu_State3_Case03_Case01)
EraseMenuCursorWC46E::
Func_003_7052:: ; address name
    call MenuCursorAddressWC46E
    ld a, $C3
    call WriteVRAMByte
    ret

; HL = the word at Data_003_4649 + 2 * wC46E (the cursor row's VRAM address) (E-0114)
; 2 call sites from 2 routines (e.g. DrawMenuCursorWC46E, EraseMenuCursorWC46E)
; reads: wC46E
MenuCursorAddressWC46E::
Func_003_705B:: ; address name
    ld a, [wC46E]
    ld hl, Data_003_4649
    add a, a
    add_a_to_hl
    deref_hl
    ret

; entry 4 of the `rst $00` table in PauseMenu_State3
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A1
PauseMenu_State3_Case04::
Jump_003_706B:: ; address name
    ld a, [wC0A1]
    rst $00
    dw PauseMenu_State3_Case04_Case00
    dw PauseMenu_State3_Case04_Case01
    dw PauseMenu_State3_Case04_Case02
    dw PauseMenu_State3_Case04_Case03
    dw PauseMenu_State3_Case04_Case04
    dw PauseMenu_State3_Case04_Case05

; entry 0 of the `rst $00` table in PauseMenu_State3_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wC6FD
; writes: wD09F, wD0A0, wD0A1, wD0A2, wD0A3, wD0A4, wD0A5, wMenuPageCount, ...
; points at: wC0A1
PauseMenu_State3_Case04_Case00::
Jump_003_707B:: ; address name
    ld a, [wC6FD]
    dec a
    ld [wD09F], a
    ld c, $00
    ld a, c
    ld [wD0A0], a
    ld a, [wC6FD]
    cp a, $01
    jr z, Jump_003_7092
    inc c
    jr Jump_003_7094

Jump_003_7092::
    ld c, $FF

Jump_003_7094::
    ld a, c
    ld [wD0A1], a
    ld a, [wC6FD]
    cp a, $03
    jr nz, Jump_003_70A2
    inc c
    jr Jump_003_70A4

Jump_003_70A2::
    ld c, $FF

Jump_003_70A4::
    ld a, c
    ld [wD0A2], a
    ld a, $FF
    ld [wD0A3], a
    ld [wD0A4], a
    ld [wD0A5], a
    ld a, $01
    ld [wMenuPageCount], a
    xor a, a
    ld [wMenuPage], a
    ld [wC0A8], a
    call PauseMenu_State3_Shared05
    call CopyTileBufferToBGMap
    ld hl, wC0A1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_State3_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wC46E
; points at: wC0A1
PauseMenu_State3_Case04_Case01::
Jump_003_70CA:: ; address name
    call PauseMenu_State3_Shared01
    xor a, a
    ld [wC46E], a
    call PauseMenu_State3_Shared02
    ld hl, wC0A1
    inc [hl]
    ret

; entry 2 of the `rst $00` table in PauseMenu_State3_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wC46E, wC0A8, wC6FD, wD09F
; writes: wC0A8, wC0A0, wC0A1
; points at: wC46E, wD0A0, wD0A3, wD09F, wC0A1
PauseMenu_State3_Case04_Case02::
Jump_003_70D9:: ; address name
    ld hl, wC46E
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
    ld a, [wC46E]
    and a, $03
    ld hl, wD0A0
    add_a_to_hl
    ld c, [hl]
    ld [hl], $FF
    ld a, [wC0A8]
    ld hl, wD0A3
    add_a_to_hl
    ld [hl], c
    call PauseMenu_State3_Shared08
    ld hl, wD09F
    dec [hl]
    ld a, [wC6FD]
    ld b, a
    ld a, [wC0A8]
    inc a
    ld [wC0A8], a
    cp a, b
    jr z, Jump_003_712F
    ld hl, wC0A1
    dec [hl]
    ret

Jump_003_712F::
    ld hl, wC0A1
    inc [hl]
    ret

Jump_003_7134::
    bit 1, a
    ret z
    ld a, [wC0A8]
    or a, a
    jr nz, PauseMenu_State3_Case04_Case05_Sub01
    xor a, a
    ld [wC0A0], a
    ld [wC0A1], a
    ret

; only called from PauseMenu_State3_Case04_Case05 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_State3_Case04_Case05)
; reads: wC0A8, wD09F
; writes: wC0A8
; points at: wD09F, wD0A3, wD0A0, wC0A1
PauseMenu_State3_Case04_Case05_Sub01::
Func_003_7145:: ; address name
    ld hl, wD09F
    inc [hl]
    ld a, [wC0A8]
    dec a
    ld [wC0A8], a
    ld hl, wD0A3
    add_a_to_hl
    ld c, [hl]
    ld [hl], $FF
    ld a, [wD09F]
    ld hl, wD0A0
    add_a_to_hl
    ld [hl], c
    call PauseMenu_State3_Shared08
    ld hl, wC0A1
    dec [hl]
    ret

; entry 3 of the `rst $00` table in PauseMenu_State3_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wC46D
; points at: wC2C0, wC0A1
PauseMenu_State3_Case04_Case03::
Jump_003_716F:: ; address name
    call LoadScreenBlock21
    ld a, [wC46D]
    and a, $07
    ld hl, MenuCursorPositions_Bank03
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    call PauseMenu_State3_Shared01
    ld de, wC2C0
    ld hl, vBGMap0 + $128
    ld bc, $0C09
    call CopyRectToBGMap
    ld hl, wC0A1
    inc [hl]
    ret

; entry 4 of the `rst $00` table in PauseMenu_State3_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed
; writes: wC0A0, wC0A1
; points at: wC0A1
PauseMenu_State3_Case04_Case04::
Jump_003_7191:: ; address name
    ld a, [wJoypadPressed]
    and a, $01
    jr z, Jump_003_71A3
    call PauseMenu_State3_Case04_Case04_Sub01
    xor a, a
    ld [wC0A0], a
    ld [wC0A1], a
    ret

Jump_003_71A3::
    ld a, [wJoypadPressed]
    and a, $02
    ret z
    ld hl, wC0A1
    inc [hl]
    ret

; entry 5 of the `rst $00` table in PauseMenu_State3_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wC46E
; points at: wC0A1
PauseMenu_State3_Case04_Case05::
Jump_003_71AE:: ; address name
    call PauseMenu_State3_Shared05
    call PauseMenu_State3_Case04_Case05_Sub01
    call PauseMenu_State3_Shared01
    xor a, a
    ld [wC46E], a
    call PauseMenu_State3_Shared02
    call CopyTileBufferToBGMap
    ld hl, wC0A1
    dec [hl]
    ld hl, wC0A1
    dec [hl]
    ret

; only called from PauseMenu_State3_Case04_Case04 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_State3_Case04_Case04)
; reads: wD0A3, wD0A4, wD0A5
; writes: wC700, wC6FF, wC6FE
; points at: wC6FE
PauseMenu_State3_Case04_Case04_Sub01::
Func_003_71CA:: ; address name
    ld a, [wD0A3]
    ld hl, wC6FE
    add_a_to_hl
    ld c, [hl]
    ld a, [wD0A4]
    cp a, $FF
    jr z, Jump_003_71FD
    ld hl, wC6FE
    add_a_to_hl
    ld b, [hl]
    ld a, [wD0A5]
    cp a, $FF
    jr z, Jump_003_71F9
    ld hl, wC6FE
    add_a_to_hl
    ld a, [hl]
    ld [wC700], a

Jump_003_71F9::
    ld a, b
    ld [wC6FF], a

Jump_003_71FD::
    ld a, c
    ld [wC6FE], a
    ret

; only called from routines of PauseMenu_State3 (E-0098)
; 3 call sites from 3 routines (e.g. PauseMenu_State3_Case04_Case05, PauseMenu_State3_Case04_Case03, PauseMenu_State3_Case04_Case01)
; reads: wD09F, wD0A0, wD0A1, wD0A2, wD0A3, wD0A4, wD0A5
; writes: wMenuRowCount
; points at: wC1FB, wC23B, wC27B, wC204, wC244, wC284
PauseMenu_State3_Shared01::
Func_003_7202:: ; address name
    call LoadScreenBlock28
    ld a, [wD09F]
    inc a
    ld [wMenuRowCount], a
    ld de, wC1FB
    ld a, [wD0A0]
    call PauseMenu_State3_Shared01_Sub01
    ld de, wC23B
    ld a, [wD0A1]
    call PauseMenu_State3_Shared01_Sub01
    ld de, wC27B
    ld a, [wD0A2]
    call PauseMenu_State3_Shared01_Sub01
    ld de, wC204
    ld a, [wD0A3]
    ld b, $E1
    call PauseMenu_State3_Shared01_Sub02
    ld de, wC244
    ld a, [wD0A4]
    ld b, $E2
    call PauseMenu_State3_Shared01_Sub02
    ld de, wC284
    ld a, [wD0A5]
    ld b, $E3
    call PauseMenu_State3_Shared01_Sub02
    ld de, wC1FB
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
; 3 call sites from 3 routines (e.g. PauseMenu_State3_Case04_Case05, PauseMenu_State3_Case04_Case02, PauseMenu_State3_Case04_Case01)
; reads: wC46E
; writes: rRAMG, rRAMB, wStringIndex, wStringCategory, wC2E6, wC321
; points at: wD0A0, wC2E9, wC364, wC368, wC3A4, wC3A8, wC2E1
PauseMenu_State3_Shared02::
Func_003_7281:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    ld a, [wC46E]
    and a, $03
    ld hl, wD0A0
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
    ld [wC2E6], a
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
    ld de, wC2E9
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
    ld de, wC364
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wC368
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    ld a, [hl+]
    push hl
    ld h, [hl]
    ld l, a
    call HLToDecimalDigits
    ld de, wC3A4
    call WriteDecimalDigitTiles
    pop hl
    inc hl
    deref_hl
    call HLToDecimalDigits
    ld de, wC3A8
    call WriteDecimalDigitTiles
    pop af
    push af
    add a, $C7
    ld [wC321], a
    pop af
    ld de, wC2E1
    call PauseMenu_State3_Shared02_Sub01
    ld a, $00
    ld [rRAMG], a
    ld hl, vBGMap0 + $149
    ld de, wC2E1
    ld bc, $0A07
    call CopyRectToBGMap
    ret

; only called from routines of PauseMenu_State3 (E-0098)
; 2 call sites from 2 routines (e.g. PauseMenu_State3_Case04_Case05_Sub01, PauseMenu_State3_Case04_Case02)
; reads: wD0A0, wD0A1, wD0A2
; writes: wD0A2, wD0A1, wD0A0
PauseMenu_State3_Shared08::
Func_003_7335:: ; address name
    ld a, [wD0A0]
    ld c, a
    ld a, [wD0A1]
    ld b, a
    ld a, [wD0A2]
    ld e, a
    cp a, b
    jr c, Jump_003_7360
    cp a, c
    jr c, Jump_003_7389
    ld [wD0A2], a
    ld a, b
    cp a, c
    jr c, Jump_003_7357
    ld [wD0A1], a
    ld a, c
    ld [wD0A0], a
    jr Jump_003_7394

Jump_003_7357::
    ld [wD0A0], a
    ld a, c
    ld [wD0A1], a
    jr Jump_003_7394

Jump_003_7360::
    cp a, c
    jr c, Jump_003_7370
    ld [wD0A1], a
    ld a, c
    ld [wD0A0], a
    ld a, b
    ld [wD0A2], a
    jr Jump_003_7394

Jump_003_7370::
    ld [wD0A0], a
    ld a, b
    cp a, c
    jr c, Jump_003_7380
    ld [wD0A2], a
    ld a, c
    ld [wD0A1], a
    jr Jump_003_7394

Jump_003_7380::
    ld [wD0A1], a
    ld a, c
    ld [wD0A2], a
    jr Jump_003_7394

Jump_003_7389::
    ld [wD0A1], a
    ld a, b
    ld [wD0A0], a
    ld a, c
    ld [wD0A2], a

Jump_003_7394::
    ret

Data_003_7395:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $D5, $DA

; entry 5 of the `rst $00` table in PauseMenu_State3
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A1
PauseMenu_State3_Case05::
Jump_003_7398:: ; address name
    ld a, [wC0A1]
    rst $00
    dw PauseMenu_State3_Case05_Case00
    dw PauseMenu_State3_Case05_Case01

; entry 0 of the `rst $00` table in PauseMenu_State3_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wPlayHoursLo, wPlayHoursHi, wPlayMinutes, wD09D, wD09E, wD7F5, wD09F, wD0A0, ...
; writes: wD09E
; points at: wC60C, wC200, wC204, wC243, wC249, wC283, wC31B, wC31F, ...
PauseMenu_State3_Case05_Case00::
Jump_003_73A0:: ; address name
    call LoadScreenBlock2D
    ld a, $20
    ld [wD09E], a
    farcall LoadAllFamilyIconTiles
    ld hl, wC60C
    call CopyTenBytesToWC130
    ld hl, vTiles2 + $300
    call SelectString5Category8ThenShow
    ld a, [wPlayHoursLo]
    ld l, a
    ld a, [wPlayHoursHi]
    ld h, a
    call HLToDecimalDigits
    ld de, wC200
    call WriteThreeDigitTilesWC8C0_Bank03
    ld a, [wPlayMinutes]
    call ByteAToDecimalDigits
    ld de, wC204
    call WriteTwoDigitTilesWC8C1NoBlank_Bank03
    call PauseMenu_State3_Case05_Case00_Sub01
    ld a, [wD09D]
    ld de, wC243
    call WriteByteAAsTwoDigitTiles
    ld a, [wD09E]
    ld de, wC249
    call WriteByteAAsTwoDigitTiles
    farcall CountFlaggedSRAMRecords
    ld a, [wD7F5]
    ld de, wC283
    call WriteByteAAsTwoDigitTiles
    farcall CountSpeciesPerFamilyFlaggedOrListed
    ld a, [wD09D]
    ld de, wC31B
    call WriteByteAAsTwoDigitTiles
    ld a, [wD09E]
    ld de, wC31F
    call WriteByteAAsTwoDigitTiles
    ld a, [wD09F]
    ld de, wC323
    call WriteByteAAsTwoDigitTiles
    ld a, [wD0A0]
    ld de, wC327
    call WriteByteAAsTwoDigitTiles
    ld a, [wD0A1]
    ld de, wC35B
    call WriteByteAAsTwoDigitTiles
    ld a, [wD0A2]
    ld de, wC35F
    call WriteByteAAsTwoDigitTiles
    ld a, [wD0A3]
    ld de, wC363
    call WriteByteAAsTwoDigitTiles
    ld a, [wD0A4]
    ld de, wC367
    call WriteByteAAsTwoDigitTiles
    ld a, [wD0A5]
    ld de, wC39B
    call WriteByteAAsTwoDigitTiles
    ld a, [wD0A6]
    ld de, wC39F
    call WriteByteAAsTwoDigitTiles
    ld a, [wD0A7]
    ld de, wC3A3
    call WriteByteAAsTwoDigitTiles
    ld hl, $0000
    ld de, wD09D
    ld b, $0B

Jump_003_746C::
    ld a, [de]
    inc de
    add_a_to_hl
    dec b
    jr nz, Jump_003_746C
    call HLToDecimalDigits
    ld de, wC2E6
    call WriteDecimalDigitTiles
    call CopyTileBufferToBGMap
    ld hl, wC0A1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_State3_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wPlayFrames, wPlaySeconds, wPlayMinutes, wPlayHoursLo, wPlayHoursHi
; writes: wC0A0, wC0A1
; points at: wC204, wC200
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
    ld de, wC204
    call WriteTwoDigitTilesWC8C1NoBlank_Bank03
    ld a, [wPlayHoursLo]
    ld l, a
    ld a, [wPlayHoursHi]
    ld h, a
    call HLToDecimalDigits
    ld de, wC200
    call WriteThreeDigitTilesWC8C0_Bank03
    ld de, wC200
    ld hl, vBGMap0 + $68
    ld bc, $0601
    call CopyRectToBGMap
    ret

Jump_003_74C2::
    xor a, a
    ld [wC0A0], a
    ld [wC0A1], a
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
; points at: wC8C0, wC8C1
WriteThreeDigitTilesWC8C0_Bank03::
Func_003_74DA:: ; address name
    ld hl, wC8C0
    ld a, [hl]
    add a, $E0
    ld [de], a
    inc de

; writes wC8C1 and wC8C2 as tiles $E0 + digit at DE and DE + 1 (no leading-zero blank) (E-0117) (the same 13 bytes appear in 2 banks)
; 2 call sites from 2 routines (e.g. PauseMenu_State3_Case05_Case01, PauseMenu_State3_Case05_Case00)
; points at: wC8C1
WriteTwoDigitTilesWC8C1NoBlank_Bank03::
Func_003_74E2:: ; address name
    ld hl, wC8C1
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
; reads: wC0A1
PauseMenu_State3_Case06::
Jump_003_74EF:: ; address name
    ld a, [wC0A1]
    rst $00
    dw PauseMenu_State3_Case06_Case00
    dw PauseMenu_State3_Case06_Case01
    dw PauseMenu_State3_Case06_Case02
    dw PauseMenu_State3_Case06_Case03
    dw PauseMenu_State3_Case06_Case04
    dw PauseMenu_State3_Case06_Case05
    dw PauseMenu_State3_Case06_Case06

; entry 0 of the `rst $00` table in PauseMenu_State3_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wC52D, wC52E, wC52F, wC530
; writes: hFFB9, wC52D, wC52E, wC52F, wC530, wStringCategory, wStringIndex, wC1F9
; points at: wC0A1
PauseMenu_State3_Case06_Case00::
Jump_003_7501:: ; address name
    xor a, a
    ldh [hFFB9], a
    call PauseMenu_State3_Case06_Case00_Sub01
    ld a, [wC52D]
    ld l, a
    ld a, [wC52E]
    ld h, a
    push hl
    ld a, [wC52F]
    ld l, a
    ld a, [wC530]
    ld h, a
    push hl
    ld hl, vTiles2 + $50
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0401
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, $00
    ld [wStringCategory], a
    ld a, $04
    ld [wStringIndex], a
    farcall ShowString_Bank07
    pop hl
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    pop hl
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld a, $C3
    ld [wC1F9], a
    call CopyTileBufferToBGMap
    ld a, $00
    ld [wStringCategory], a
    ld a, $25
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank37
    call PauseMenu_State3_Shared03
    ld hl, wC0A1
    inc [hl]
    ret

; entry 1 of the `rst $00` table in PauseMenu_State3_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B
; writes: wMenuRowCount, wMenuPageCount, wC46F
; points at: wC0A1
PauseMenu_State3_Case06_Case01::
Jump_003_7571:: ; address name
    call PauseMenu_State3_Shared03
    ld a, [wC52B]
    or a, a
    ret nz
    ld de, Data_01F_4330
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
    ld [wC46F], a
    ld hl, wC0A1
    inc [hl]
    ret

; entry 2 of the `rst $00` table in PauseMenu_State3_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressed, wC46F, wModeState
; writes: wC0A4, wC0A0, wC0A1
; points at: wC46F, wC0A1, wScreenTileBuffer
PauseMenu_State3_Case06_Case02::
Jump_003_75A4:: ; address name
    ld hl, wC46F
    ld de, Data_003_4645
    call UpdateMenuCursor
    ld a, [wJoypadPressed]
    bit 0, a
    jr z, Jump_003_75E6
    ld a, $69
    call QueueSoundEffect
    ld a, [wC46F]
    and a, $01
    ld hl, Data_003_4645
    call WriteBCTileAtWordTableEntry_Bank03
    ld a, [wC46F]
    and a, $01
    jr nz, Jump_003_75D7
    call PauseMenu_State3_Shared03
    xor a, a
    ld [wC0A4], a
    ld hl, wC0A1
    inc [hl]
    ret

Jump_003_75D7::
    ld a, [wModeState]
    bit 3, a
    jr nz, Jump_003_7633
    xor a, a
    ld [wC0A0], a
    ld [wC0A1], a
    ret

Jump_003_75E6::
    bit 1, a
    jr nz, Jump_003_75D7
    call PauseMenu_State3_Shared03
    ret

; entry 3 of the `rst $00` table in PauseMenu_State3_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wC0A4
; points at: wC0A1
PauseMenu_State3_Case06_Case03::
Jump_003_75EE:: ; address name
    call PauseMenu_State3_Shared03
    call RunWC0A4Screen
    ld a, [wC0A4]
    cp a, $04
    ret nz
    ld hl, wC0A1
    inc [hl]
    ret

; entry 4 of the `rst $00` table in PauseMenu_State3_Case06
; no direct call (reached through a table, a jump or a vector)
; writes: wStringCategory, wStringIndex
; points at: wC0A1
PauseMenu_State3_Case06_Case04::
Jump_003_75FF:: ; address name
    call PauseMenu_State3_Shared03
    ld a, $00
    ld [wStringCategory], a
    ld a, $26
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank37
    ld hl, wC0A1
    inc [hl]
    ret

; entry 5 of the `rst $00` table in PauseMenu_State3_Case06
; no direct call (reached through a table, a jump or a vector)
; reads: wC52B, wModeState
; writes: wC0A0, wC0A1
; points at: wScreenTileBuffer
PauseMenu_State3_Case06_Case05::
Jump_003_7617:: ; address name
    ld a, [wC52B]
    or a, a
    jr z, Jump_003_7621
    call PauseMenu_State3_Shared03
    ret

Jump_003_7621::
    ld a, [wModeState]
    bit 3, a
    jr nz, Jump_003_7633
    xor a, a
    ld [wC0A0], a
    ld [wC0A1], a
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
    ld [wC0A1], a
    ret

; only called from routines of PauseMenu_State3 (E-0098)
; 7 call sites from 6 routines (e.g. PauseMenu_State3_Case06_Case05, PauseMenu_State3_Case06_Case04, PauseMenu_State3_Case06_Case03, PauseMenu_State3_Case06_Case02, ...)
; reads: wBattlerRecords, wD10A
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
    ld a, [wD10A]
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
; 4 call sites from 4 routines (e.g. Func_003_4208_Case03, PauseMenu_State3_Case00_Case00, LoadScreenBlock21WithCursor, PauseMenu_State3_Case04_Case03)
LoadScreenBlock21::
Func_003_7692:: ; address name
    call ClearScreenTileBuffer_Bank03
    ld e, $21
    farcall CopyBlockToTileBuffer
    ret

; LoadScreenBlock21, then writes tile $BC at MenuCursorPositions_Bank03[wC46D & 7] in the buffer (WriteBCTileToScreenBufferAtTableEntry_Bank03) (E-0101)
; 4 call sites from 4 routines (e.g. BuildScreenBlocks21To23, PauseMenu_State3_Case02_Case00_Sub01, LoadScreenBlock21CursorAnd2C, PauseMenu_State3_Shared05)
; reads: wC46D
LoadScreenBlock21WithCursor::
Func_003_769E:: ; address name
    call LoadScreenBlock21
    ld a, [wC46D]
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
    call ComputeMenuPagesForWD0C7Items
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
; 3 call sites from 3 routines (e.g. PauseMenu_State3_Case01_Case0A, PauseMenu_State3_Case01_Case07, PauseMenu_State3_Case01_Case04)
; reads: wC46F
; points at: wC218, wC338
PauseMenu_State3_Shared04::
Func_003_76D5:: ; address name
    call BuildScreenBlocks21To24
    call FillTilesFromRequest
    ld e, $10
    farcall CopyBlockToTileBuffer
    ld a, [wC46F]
    and a, $07
    ld hl, Data_003_4633
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ld hl, vBGMap0 + $80
    ld de, wC218
    ld bc, $0609
    call CopyRectToBGMap
    ld hl, vBGMap0 + $1A0
    ld de, wC338
    ld bc, $1405
    call CopyRectToBGMap
    ret

; builds blocks $21-$24, draws the cursor for wC46F & 7 and copies blocks $25 and $10 (E-0122)
; 1 call site from 1 routine (e.g. PauseMenu_State3_Case01_Case0D)
; reads: wC46F
BuildScreenBlocks21To25WithCursor::
Func_003_7707:: ; address name
    call BuildScreenBlocks21To24
    ld a, [wC46F]
    and a, $07
    ld hl, Data_003_4633
    call WriteBCTileToScreenBufferAtTableEntry_Bank03
    ld e, $25
    farcall CopyBlockToTileBuffer
    ld e, $10
    farcall CopyBlockToTileBuffer
    ret

; only called from PauseMenu_State3_Case02_Case00 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_State3_Case02_Case00)
PauseMenu_State3_Case02_Case00_Sub01::
Func_003_7726:: ; address name
    call LoadScreenBlock21WithCursor
    ld hl, Data_003_7B9F
    ld de, Data_003_7BAF
    call PauseMenu_State3_Case02_Case00_Sub01_Sub01
    ld e, $26
    farcall CopyBlockToTileBuffer
    ld e, $27
    farcall CopyBlockToTileBuffer
    ret

; LoadScreenBlock21WithCursor, then block $2C (E-0114)
; 1 call site from 1 routine (e.g. PauseMenu_State3_Case03_Case00)
LoadScreenBlock21CursorAnd2C::
Func_003_7743:: ; address name
    call LoadScreenBlock21WithCursor
    ld e, $2C
    farcall CopyBlockToTileBuffer
    ret

; only called from routines of PauseMenu_State3 (E-0098)
; 2 call sites from 2 routines (e.g. PauseMenu_State3_Case04_Case05, PauseMenu_State3_Case04_Case00)
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
; 1 call site from 1 routine (e.g. PauseMenu_State3_Case06_Case00)
; reads: wC46D
PauseMenu_State3_Case06_Case00_Sub01::
Func_003_776C:: ; address name
    ld e, $2A
    farcall CopyBlockToTileBuffer
    ld a, [wC46D]
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
; reads: wMenuPage, wD0C7
; writes: wC52F, wC530, wStringCategory, wStringIndex, wC52D, wC52E
; points at: wD0A7, wD0A8, wC130
PauseMenu_State3_Shared06::
Func_003_779A:: ; address name
    ld hl, $0C01
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, [wMenuPage]
    ld b, a
    add a, a
    add a, a
    ld de, wD0A7
    add a, e
    ld e, a
    jr nc, Jump_003_77B3
    inc d

Jump_003_77B3::
    ld bc, $0400
    ld a, [wD0C7]
    or a, a
    jr nz, Jump_003_77E0
    ld a, $08
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a
    ld hl, vTiles2 + $440
    ld de, $0C01
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    farcall ShowString_Bank08
    ld bc, $0301
    ld de, wD0A8

Jump_003_77E0::
    push bc
    push de
    ld a, c
    ld hl, Data_003_78B9
    add a, a
    add_a_to_hl
    deref_hl
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
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
    ld de, wC130
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
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
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

Data_003_78B9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $94, $00, $95, $C0, $95, $80, $96, $40, $97

Data_003_78C3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $46, $99, $86, $99, $C6, $99, $06, $9A

; only called from routines of PauseMenu_State3 (E-0098)
; 3 call sites from 2 routines (e.g. PauseMenu_State3_Case01_Case01, PauseMenu_State3_Case01_Case00)
; reads: wD0C7, wMenuPage, wC46E
; writes: wC52D, wC52E, wC52F, wC530, wStringIndex, wStringCategory
; points at: wD0A7, wC130
PauseMenu_State3_Shared07::
Func_003_78CB:: ; address name
    ld a, [wD0C7]
    or a, a
    ret z
    ld hl, vTiles2 + $200
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $0C03
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, [wMenuPage]
    ld b, a
    add a, a
    add a, a
    ld b, a
    ld hl, wD0A7
    add_a_to_hl
    ld a, [wC46E]
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
    ld de, wD0A7
    ld a, [wMenuPage]
    ld b, a
    add a, a
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_003_7921
    inc d

Jump_003_7921::
    ld a, [wC46E]
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
    ld de, wC130
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
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ret

; only called from BuildScreenBlocks21To23 (E-0047)
; 1 call site from 1 routine (e.g. BuildScreenBlocks21To23)
; reads: wC836, wD0C7
; writes: wD0C7
; points at: wD0A7, wKeyList
BuildScreenBlocks21To23_Sub01::
Func_003_7978:: ; address name
    ld hl, wD0A7
    ld bc, $0020
    ld a, $FF
    call FillBytes
    ld hl, wD0A7
    ld de, wKeyList
    ld bc, $2000
    xor a, a
    ld [wD0C7], a
    ld a, [wC836]
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
    ld a, [wD0C7]
    inc a
    ld [wD0C7], a

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
    ld a, [wD0C7]
    inc a
    ld [wD0C7], a

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
    ld a, [wD0C7]
    inc a
    ld [wD0C7], a

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
    ld a, [wD0C7]
    inc a
    ld [wD0C7], a

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
    ld a, [wD0C7]
    or a, a
    ret

; from wD0C7 items computes wMenuPageCount (4 rows per page, up to 8 pages), wMenuLastPageRows and wMenuRowCount for wMenuPage, and draws the page indicator (E-0128)
; 2 call sites from 2 routines (e.g. BuildScreenBlocks21To23, PauseMenu_State3_Case01_Case01)
; reads: wD0C7, wMenuPage, wMenuLastPageRows, wMenuPageCount
; writes: wMenuLastPageRows, wMenuPageCount, wMenuRowCount, wC3C9, wC3C7, wC3C6, wC3C8, wC3CA
ComputeMenuPagesForWD0C7Items::
Func_003_7A58:: ; address name
    ld a, [wD0C7]
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
    ld [wC3C9], a
    ld a, [wMenuPage]
    inc a
    add a, $E0
    ld [wC3C7], a
    ld a, $C5
    ld [wC3C6], a
    ld a, $BE
    ld [wC3C8], a
    ld a, $C6
    ld [wC3CA], a
    ret

; shows string 2 of category 0 (ShowString_Bank09) in a window at vTiles1 + $6E0 with size $1003, then restores the default window (vTiles1, $1202) (E-0120)
; 1 call site from 1 routine (e.g. Func_003_4208_Case03)
; writes: wC52D, wC52E, wC52F, wC530, wStringCategory, wStringIndex
ShowString2Bank09InWindowThenDefault::
Func_003_7AE8:: ; address name
    ld hl, vTiles1 + $6E0
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1003
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ld a, $00
    ld [wStringCategory], a
    ld a, $02
    ld [wStringIndex], a
    farcall ShowString_Bank09
    ld hl, vTiles1
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $1202
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    ret

; only called from PauseMenu_State3_Case05_Case00 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_State3_Case05_Case00)
; writes: rRAMG, rRAMB, wD09D, wD09E
; points at: sA000, wD09E, wD09D
PauseMenu_State3_Case05_Case00_Sub01::
Func_003_7B25:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, $00
    ld [rRAMB], a
    xor a, a
    ld [wD09D], a
    ld [wD09E], a
    ld de, sA000
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
    ld hl, wD09E
    jr Jump_003_7B50

Jump_003_7B4D::
    ld hl, wD09D

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
; reads: wC52D, wC52E, wC52F, wC530
; writes: wC52D, wC52E, wC52F, wC530
FillTiles21E0PreservingWindow::
Func_003_7B61:: ; address name
    ld a, [wC52D]
    ld l, a
    ld a, [wC52E]
    ld h, a
    push hl
    ld a, [wC52F]
    ld l, a
    ld a, [wC530]
    ld h, a
    push hl
    ld hl, vTiles2 + $1E0
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ld hl, $6201
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    call FillTilesFromRequest
    pop hl
    ld a, l
    ld [wC52F], a
    ld a, h
    ld [wC530], a
    pop hl
    ld a, l
    ld [wC52D], a
    ld a, h
    ld [wC52E], a
    ret

Data_003_7B9F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $50, $90, $60, $90, $70, $90, $80, $90, $90, $90, $A0, $90, $B0, $90, $FF, $FF

Data_003_7BAF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E0, $40, $70, $43, $B0, $42, $D0, $42, $10, $43, $C0, $42, $B0, $43, $FF, $FF

; only called from PauseMenu_State3_Case02_Case00_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. PauseMenu_State3_Case02_Case00_Sub01)
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

Data_003_7BF5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $11, $20, $FF, $7F, $7D, $3D
    ds $405, $00
