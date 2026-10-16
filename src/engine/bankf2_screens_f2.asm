; ROM bank $F2: screens and game mode 8
; The annotated listing of this bank is build/listing/bankf2.asm.

SECTION "Bank F2", ROMX[$4000], BANK[$F2]
    db $f2

; Start-up of game mode 8 (the egg hand-over scene): the main loop runs it through
; RunGameModeInit_EggHandOver after LinkMessageEvent_FinishToMode8 sets wGameMode 8 and
; wModeChangeRequest 1. It clears 256 bytes from wScreenState (the count in B starts at 0 and wraps,
; so this is more than the $6F bytes GameMode8_Update_EndMode clears), then calls RunLoadGameSteps
; until bit 7 of wSaveStep is set, which reloads the saved game from SRAM. It decompresses
; LetterFrameIconDigitTiles (bank $46) to vTiles1, clears the screen buffers, draws 20 x 13 tiles
; from wScreenTileBuffer + $01CC to the BG map at the scroll position (0, so vBGMap0), loads the CGB
; and SGB palettes, blanks the text window tiles (wTextWindowTileLo/Hi = vTiles1, wTextWindowRows 2,
; wTextWindowWidth $12) and runs StepTextWindowOpenClose until the text window has opened. It then
; starts a palette fade (A = $FC), blanks those tiles again, sets wSpriteSlotCount 0,
; hSpriteWindowClipMode 2 and wLCDCShadow $03 and jumps to ResumeAfterModeChange with A = 1.
; GameMode8_Update takes over each frame, starting at wScreenSubStep 0 (cleared here). (C1, E-0386)
; start-up for wGameMode = 8; forcing this mode on the emulator shows: egg-received dialogue when
; forced (E-0029)
GameMode8_Init::
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

.loop2:
    farcall RunLoadGameSteps
    ld a, [wSaveStep]
    bit 7, a
    jr z, .loop2
    ld b, $46
    ld de, LetterFrameIconDigitTiles
    ld hl, vTiles1
    call DecompressToVRAM
    farcall ClearScreenBufferAndAttributes_BankF1
    xor a
    ldh [hScrollY], a
    ldh [hScrollX], a
    call BGMapAddressAtScroll_BankF2
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_1B_BankF2
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
    ld a, $01
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $00
    ldh [hSpriteWindowClipMode], a

.loop3:
    farcall StepTextWindowOpenClose
    ld a, [wTextWindowState]
    and $03
    jr nz, .loop3
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

; Per-frame routine of game mode 8 (the egg hand-over scene), run through
; RunGameModeUpdate_EggHandOver. It returns at once while wFadeState is non-zero. When
; wScreenSubStep is not 0 it first calls GameMode8_Update_DrawSprites, so the sprite slots and field
; sprites are redrawn every frame. It then returns while wTextFlags is non-zero (a message is still
; printing or waiting for a button) and otherwise jumps through a 14-entry table by wScreenSubStep
; (no range check): 0 GameMode8_Update_Start, 1 GameMode8_Update_Wait, 2
; GameMode8_Update_WalkObject1, 3 Wait, 4 GameMode8_Update_ShowEgg, 5 GameMode8_Update_WalkSprite0,
; 6 and 7 Wait, 8 GameMode8_Update_HideEgg, 9 and 10 Wait, 11 GameMode8_Update_WalkSprite0Off, 12
; GameMode8_Update_ShowHeroReceivedGsEgg, 13 GameMode8_Update_BackToTitleMenu. Each step adds 1 to
; wScreenSubStep itself when it is done. The scene ends in game mode 5 (the title menu), not in the
; field. (C1, E-0386)
; game mode 8, the egg hand-over scene: by wScreenSubStep it moves the scene's objects and sprite
; slots, shows '0 received G's egg' and returns to the game mode the link scene set (E-0354; was:
; per-frame routine for wGameMode = 8)
GameMode8_Update::
    ld a, [wFadeState]
    and a
    ret nz
    ld a, [wScreenSubStep]
    and a
    jr z, .check_text_flags
    call GameMode8_Update_DrawSprites

.check_text_flags:
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenSubStep]
    jumptable
    dw GameMode8_Update_Start
    dw GameMode8_Update_Wait
    dw GameMode8_Update_WalkObject1
    dw GameMode8_Update_Wait
    dw GameMode8_Update_ShowEgg
    dw GameMode8_Update_WalkSprite0
    dw GameMode8_Update_Wait
    dw GameMode8_Update_Wait
    dw GameMode8_Update_HideEgg
    dw GameMode8_Update_Wait
    dw GameMode8_Update_Wait
    dw GameMode8_Update_WalkSprite0Off
    dw GameMode8_Update_ShowHeroReceivedGsEgg
    dw GameMode8_Update_BackToTitleMenu

; Egg hand-over, step 0: sets up the figures and graphics (GameMode8_Update_SetUpScene); next step.
; (C1, E-0357)
GameMode8_Update_Start::
    call GameMode8_Update_SetUpScene
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Egg hand-over, steps 1, 3, 6, 7, 9 and 10 of the table in GameMode8_Update: a pause. It adds 1 to
; wScreenCounter and returns while the result is below $10; once it is $10 or more it clears
; wScreenCounter and adds 1 to wScreenSubStep. GameMode8_Update keeps redrawing the sprites while it
; waits, and it only reaches this routine on frames when no fade or text is active. (C2, E-0386)
GameMode8_Update_Wait::
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

; Egg hand-over, step 2: object 1 walks left, on three counts of every four, to X $58, where it
; stops (flag bit 1); next step. (C2, E-0357; probed E-0386)
GameMode8_Update_WalkObject1::
    ld a, [wObject1 + OBJ_ANIM_COUNTER]
    and $03
    and a
    ret z
    ld a, [wObject1 + OBJ_X]
    dec a
    ld [wObject1 + OBJ_X], a
    cp $59
    ret nc
    ld a, $58
    ld [wObject1 + OBJ_X], a
    ld a, [wObject1 + OBJ_FLAGS]
    set 1, a
    ld [wObject1 + OBJ_FLAGS], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Egg hand-over, step 4: shows object 5 and sets wArg1 to 1; next step. (C2, E-0357; probed E-0386)
GameMode8_Update_ShowEgg::
    ld a, $80
    ld [wObject5], a
    ld a, $01
    ld [wArg1], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Egg hand-over, step 5: sprite 0 walks right, on three counts of four, to X $38, where it stops;
; next step. (C2, E-0357; probed E-0386)
GameMode8_Update_WalkSprite0::
    ld a, [wSpriteSlots + $9]
    and $03
    and a
    ret z
    ld a, [wSpriteSlots + $b]
    inc a
    ld [wSpriteSlots + $b], a
    cp $38
    ret nz
    ld a, [wSpriteSlots + $d]
    set 1, a
    ld [wSpriteSlots + $d], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Egg hand-over, step 8: hides object 5 and clears wArg1; next step. (C2, E-0357; probed E-0386)
GameMode8_Update_HideEgg::
    ld a, $00
    ld [wObject5], a
    ld [wArg1], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Egg hand-over, step 11: sprite 0 turns left and walks off, on three counts of four, until X $E0;
; next step. (C2, E-0357; probed E-0386)
GameMode8_Update_WalkSprite0Off::
    ld a, [wSpriteSlots + $d]
    res 1, a
    ld [wSpriteSlots + $d], a
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld a, [wSpriteSlots + $9]
    and $03
    and a
    ret z
    ld a, [wSpriteSlots + $b]
    dec a
    ld [wSpriteSlots + $b], a
    cp $e0
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; Egg hand-over, step 12: '<player> received <monster>'s egg. Please raise ...' (string $0E), with
; the player's name and the egg's species from wChildRecord; next step. (C1, E-0357)
GameMode8_Update_ShowHeroReceivedGsEgg::
    ld hl, wPlayerName
    ld de, wTextBuf0
    ld c, $0a
    call GameMode8_Update_CopyStringMaxC
    ld de, wChildRecord + MON_SPECIES
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call CopyMonsterNameToBuffer_BF2
    ld hl, wNameGlyphBuf
    ld de, wTextBuf1
    ld c, $10
    call GameMode8_Update_CopyStringMaxC
    ld a, $0e
    ld [wStringIndex], a ; '0 received G's egg. Please raise'
    xor a
    ld [wStringCategory], a
    farcall BeginStringDisplay_BankF0_2
    ld hl, wScreenSubStep
    inc [hl]
    ret

; HL = source string, DE = destination, C = the most bytes to copy (0 counts as 256). Copies bytes
; from HL to DE until it reads a $F0 end byte (not copied) or has copied C bytes, then stores $F0 at
; DE, so the destination needs room for C + 1 bytes. It returns with A = $F0, HL after the last byte
; it read, DE at the $F0 it stored and C = the count left. GameMode8_Update_ShowHeroReceivedGsEgg
; uses it for the name of the player (C = $0A into wTextBuf0) and for the monster name (C = $10 into
; wTextBuf1). (C2, E-0386)
; copies a string from HL to DE, at most C bytes, ending it with $F0
GameMode8_Update_CopyStringMaxC::
    ld a, [hli]
    cp $f0
    jr z, .done
    ld [de], a
    inc de
    dec c
    jr nz, GameMode8_Update_CopyStringMaxC

.done:
    ld a, $f0
    ld [de], a
    ret

; Egg hand-over, step 13: calls GameMode8_Update_EndMode, which clears the screen variables and
; wLinkScene and requests game mode 5 with wModeState 1 (GameMode5_Init_TitleMenu), so the scene
; ends at the title menu, not in the field. (C2, E-0386)
GameMode8_Update_BackToTitleMenu::
    call GameMode8_Update_EndMode
    ret

; HL = monster id. Copies the 16 bytes of that monster name to wNameGlyphBuf: with wDataBank
; temporarily set to $08 it reads the pointer of entry 2 of StringDatabase
; (StringTable_MonsterNames) with ReadWordFromDataBank, adds 2 * HL to it, reads the name pointer
; there and copies 16 bytes from that address in bank $08 with CopyFromBankWaitVRAM. wDataBank is
; put back; HL, DE and BC are changed. There is no range check: ids of $100 and up read on into the
; list that follows (StringTable_MonsterNames2). Its only caller is
; GameMode8_Update_ShowHeroReceivedGsEgg, which passes the species word of wChildRecord. (C1,
; E-0386)
; HL = string number; copies 16 bytes of that string of StringTable_MonsterNames (bank $08, via
; wDataBank) to wNameGlyphBuf; wDataBank is restored
CopyMonsterNameToBuffer_BF2::
    push hl
    ld a, [wDataBank]
    push af
    ld a, $08
    ld [wDataBank], a
    ld hl, StringDatabase
    ld a, $04
    add_a_to_hl
    call ReadWordFromDataBank
    ld e, b
    ld b, c
    ld c, e
    pop af
    pop hl
    push af
    sla l
    rl h
    add hl, bc
    call ReadWordFromDataBank
    ld e, b
    ld d, c
    pop af
    ld [wDataBank], a
    ld hl, wNameGlyphBuf
    ld b, $08
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; Opens the default text window and waits for it: it blanks the window tiles (FillTilesRequest with
; HL = vTiles1, DE = $1202), sets wTextWindowState to 1 (opening), wTextWindowStep to 0 and
; hSpriteWindowClipMode to 2, then far-calls StepTextWindowOpenClose until the low two bits of
; wTextWindowState are clear. Nothing in the source calls or lists this bank-$F2 copy; the same code
; in bank $F0 is RunTextUntilTextWindowStateDone_BankF0, and GameMode8_Init contains its own inline
; version. (C1, E-0386)
; clears the default window, wTextWindowState = 1, wTextWindowStep = 0, hSpriteWindowClipMode = 2,
; then repeatedly far-calls StepTextWindowOpenClose until wTextWindowState & 3 = 0 (E-0122)
RunTextUntilTextWindowStateDone_BankF2::
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, $01
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a

.loop:
    farcall StepTextWindowOpenClose
    ld a, [wTextWindowState]
    and $03
    jr nz, .loop
    ret

; Clears the screen variables ($6F bytes from wScreenState) and wLinkScene and requests game mode 5,
; mode state 1. (C2, E-0357; probed E-0386)
GameMode8_Update_EndMode::
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
    ret

; Sets up the egg hand-over: sprite slot 0 and its graphics from one of two sets by EVENT_NEVER_SET
; (the other set is never used), object 1 from one of two sets by wLinkHatchData, field command $0D,
; object 5 hidden at ($48, $40), two sprite slots, and the object palettes on CGB. (C1, E-0357)
GameMode8_Update_SetUpScene::
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jr c, .skip
    ld hl, GameMode8_Update_SetUpScene_Data5
    jr .call_copy_bytes_de_from_hl_bank_f2

.skip:
    ld hl, GameMode8_Update_SetUpScene_SpriteSlotsInit

.call_copy_bytes_de_from_hl_bank_f2:
    ld de, wSpriteSlots
    ld b, $10
    call CopyBytesDEFromHL_BankF2
    ld a, [wLinkHatchData]
    and a
    jr nz, .skip2
    ld hl, GameMode8_Update_SetUpScene_Data
    jr .call_copy_bytes_de_from_hl_bank_f22

.skip2:
    ld hl, Object1Init_3

.call_copy_bytes_de_from_hl_bank_f22:
    ld de, wObject1
    ld b, $10
    call CopyBytesDEFromHL_BankF2
    ld de, EVENT_NEVER_SET
    call TestFlagBit
    jr c, .skip3
    ld hl, GameMode8_Update_SetUpScene_Data1
    jr .call_copy_bytes_de_from_hl_bank_f23

.skip3:
    ld hl, GameMode8_Update_SetUpScene_Data2

.call_copy_bytes_de_from_hl_bank_f23:
    ld de, hTemp0
    ld b, $06
    call CopyBytesDEFromHL_BankF2
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, [wLinkHatchData]
    and a
    jr nz, .skip4
    ld hl, GameMode8_Update_SetUpScene_Data3
    jr .call_copy_bytes_de_from_hl_bank_f24

.skip4:
    ld hl, GameMode8_Update_SetUpScene_Data4

.call_copy_bytes_de_from_hl_bank_f24:
    ld de, hTemp0
    ld b, $06
    call CopyBytesDEFromHL_BankF2
    farcall DecompressGraphicsTemp0ToTemp4
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
    ld a, [wIsCGB]
    and a
    jr z, .return
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a

.return:
    ret

; HL = source, DE = destination, B = number of bytes (0 counts as 256). Copies B bytes from HL to DE
; and returns with B = 0, HL and DE advanced by the count and A = the last byte copied.
; GameMode8_Update_SetUpScene uses it for the 16-byte records copied to wSpriteSlots and wObject1
; and for the 6-byte graphics records copied to hTemp0. (C2, E-0386)
; the same 7 bytes as CopyBytesDEFromHL (CopyBytesDEFromHL) (E-0353)
CopyBytesDEFromHL_BankF2::
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, CopyBytesDEFromHL_BankF2
    ret

; Six bytes copied into hTemp0-hTemp5 for DecompressGraphicsTemp0ToTemp4: graphics id word (hTemp0,
; hTemp1), hTemp2 (0 = monster sprite table, non-zero = field sprite table), hTemp3 (object palette
; slot) and the VRAM destination word (hTemp4, hTemp5). This copy is $0000, 1, 4, destination $8000:
; field sprite graphics 0 with palette slot 4 at $8000. GameMode8_Update_SetUpScene copies it when
; TestFlagBit on EVENT_NEVER_SET leaves carry clear. (C1, E-0381)
GameMode8_Update_SetUpScene_Data1::
    db $00, $00, $01, $04, $00, $80

; Six bytes copied into hTemp0-hTemp5 for DecompressGraphicsTemp0ToTemp4: graphics id word (hTemp0,
; hTemp1), hTemp2 (0 = monster sprite table, non-zero = field sprite table), hTemp3 (object palette
; slot) and the VRAM destination word (hTemp4, hTemp5). This copy is $0001, 1, 1, destination $8000:
; field sprite graphics 1 with palette slot 1 at $8000. GameMode8_Update_SetUpScene copies it
; instead of GameMode8_Update_SetUpScene_Data1 when TestFlagBit on EVENT_NEVER_SET sets carry. (C1,
; E-0381)
GameMode8_Update_SetUpScene_Data2::
    db $01, $00, $01, $01, $00, $80

; Six bytes copied into hTemp0-hTemp5 for DecompressGraphicsTemp0ToTemp4: graphics id word (hTemp0,
; hTemp1), hTemp2 (0 = monster sprite table, non-zero = field sprite table), hTemp3 (object palette
; slot) and the VRAM destination word (hTemp4, hTemp5). This copy is $000C, 1, 5, destination $8100:
; field sprite graphics $0C with palette slot 5 at $8100. GameMode8_Update_SetUpScene copies it for
; the second graphics load when wLinkHatchData is zero. (C1, E-0381)
GameMode8_Update_SetUpScene_Data3::
    db $0c, $00, $01, $05, $00, $81

; Twelve bytes, two 6-byte graphics argument records. GameMode8_Update_SetUpScene copies only the
; first six bytes ($000C, table 1, palette slot 5, destination $8100, the same as
; GameMode8_Update_SetUpScene_Data3) when wLinkHatchData is non-zero. The second record ($0000,
; table 0 = monster sprites, palette slot 2, destination $8200) is not copied by this reader. (C1,
; E-0381)
GameMode8_Update_SetUpScene_Data4::
    db $0c, $00, $01, $05, $00, $81, $00, $00, $00, $02, $00, $82

; One 16-byte field object record, copied by CopyBytesDEFromHL_BankF2 to wSpriteSlots when
; TestFlagBit on EVENT_NEVER_SET leaves carry clear (GameMode8_Update_SetUpScene_SpriteSlotsInit is
; used otherwise). Read with the OBJ_* offsets it holds behaviour type 0, OBJ_SET_MODE 1, sprite id
; 0, OBJ_ATTR 4, OBJ_STATE 1, OBJ_X $F0, OBJ_Y $40 and OBJ_FLAGS 4. (C1, E-0381)
GameMode8_Update_SetUpScene_Data5::
    db $00, $01, $00, $00, $f0, $40, $04, $01, $00, $00, $00, $f0, $40, $04, $00, $00

; CopyBytesDEFromHL_BankF2 copies these 16 bytes to wSpriteSlots (E-0264)
; record: 16 bytes copied to wSpriteSlots
GameMode8_Update_SetUpScene_SpriteSlotsInit::
    db $00, $01, $01, $00, $f0, $40, $01, $01, $00, $00, $00, $f0, $40, $04, $00, $00 ; entry 0

GameMode8_Update_SetUpScene_Data::
    db $00, $01, $0c, $00, $f0, $40, $05, $03, $10, $00, $00, $f0, $40, $04, $00, $00

; CopyBytesDEFromHL_BankF2 copies these 16 bytes to wObject1 (E-0264)
; record: 16 bytes copied to wObject1
Object1Init_3::
    db $00, $01, $0c, $00, $f0, $40, $05, $03, $10, $00, $00, $f0, $40, $04, $00, $00 ; entry 0
    db $00, $00, $00, $00, $48, $40, $02, $00, $20, $00, $00, $48, $40, $04, $00, $00

; Returns HL = vBGMap0 + (hScrollY / 8) * 32 + hScrollX / 8, the BG map entry at the top-left corner
; of the screen (rows are 32 entries wide; the sum is not wrapped). A and DE are changed.
; GameMode8_Init calls it after setting both scroll bytes to 0, so it gets vBGMap0. A second copy,
; BGMapAddressAtScroll_BankF2_2, lies later in this bank. (C1, E-0386)
; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX,
; hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
BGMapAddressAtScroll_BankF2::
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

; HL = BG map address, DE = offset into wScreenTileBuffer, B = width, C = rows. Copies the B x C
; rectangle from wScreenTileBuffer + DE to the BG map at HL with CopyRectToBGMapWrapped and sets
; wTextCursorLo/Hi to HL + $01C1. On a CGB (wIsCGB not 0) it then selects VRAM bank 1 and work RAM
; bank 2, copies the same rectangle from wScreenAttrBuffer + DE as the tile attributes and switches
; both banks back to 0. On a DMG BC, DE and HL are returned unchanged; on a CGB the attribute copy
; leaves DE past the source, HL at the start of the last row and C = 0. GameMode8_Init calls it with
; B = $14, C = $0D and DE = $01CC. (C1, E-0386)
; the same 84 bytes as DrawScreenBufferRectToBGMap_1B (DrawScreenBufferRectToBGMap_1B) (E-0127)
DrawScreenBufferRectToBGMap_1B_BankF2::
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

; Updates and draws the sprite slots, then the field sprites. (C1, E-0357)
GameMode8_Update_DrawSprites::
    farcall UpdateAndDrawSpriteSlots
    farcall DrawFieldSprites
    ret

; Starts the message wStringIndex of category wStringCategory from this bank string table
; (BeginStringDisplay_BankF2_StringCategories: the egg service and rename messages, such as 'Hello,
; how may I serve you?' and 'Pick the monster to rename.') by calling BeginStringDisplay with DE =
; that table; the text printer then prints it over the next frames while wTextFlags is non-zero.
; Called by ShowString_BankF2 and far-called by DebugMessageTest_Update_ShowBankF2. The seven bytes
; after its ret are an unused second copy of the same ld de, call and ret, kept as data. (C1,
; E-0386)
; ld de, this bank's string table / BeginStringDisplay
BeginStringDisplay_BankF2::
    ld de, BeginStringDisplay_BankF2_StringCategories
    call BeginStringDisplay
    ret
    db $11, $e5, $43, $cd, $fe, $25, $c9

; Draws a whole message of this bank table at once: BeginStringDisplay_BankF2 (message wStringIndex
; of category wStringCategory), then RunStringDisplayToEnd, which steps the text printer until
; wTextFlags is 0. Far-called by EggServiceMenu_DrawListAndPrice_ShowPrice (the price question of
; the egg service) and by RenameMenu_PickMonster_ShowPickTheMonsterTo ('Pick the monster to
; rename.'). (C1, E-0386)
; BeginStringDisplay_BankF2 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
ShowString_BankF2::
    call BeginStringDisplay_BankF2
    call RunStringDisplayToEnd
    ret

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
BeginStringDisplay_BankF2_StringCategories::
    dw StringList_BankF2_StringCategories_0 ; id 0

; category list of BeginStringDisplay_BankF2_StringCategories; one pointer per wStringIndex (E-0217)
; record: string
StringList_BankF2_StringCategories_0::
    dw String_F2_00_00 ; id 0
    dw String_F2_00_00 ; id 1
    dw String_F2_00_02 ; id 2
    dw String_F2_00_03 ; id 3
    dw String_F2_00_04 ; id 4
    dw String_F2_00_05 ; id 5
    dw String_F2_00_06 ; id 6
    dw String_F2_00_07 ; id 7
    dw String_F2_00_08 ; id 8
    dw String_F2_00_09 ; id 9
    dw String_F2_00_0A ; id 10
    dw String_F2_00_0B ; id 11
    dw String_F2_00_0C ; id 12
    dw String_F2_00_0D ; id 13
    dw String_F2_00_0E ; id 14
    dw String_F2_00_0F ; id 15
    dw String_F2_00_10 ; id 16
    dw String_F2_00_11 ; id 17
    dw String_F2_00_12 ; id 18
    dw String_F2_00_13 ; id 19
    dw String_F2_00_14 ; id 20
    dw String_F2_00_15 ; id 21
    dw String_F2_00_16 ; id 22
    dw String_F2_00_17 ; id 23
    dw String_F2_00_18 ; id 24
    dw String_F2_00_19 ; id 25
    dw String_F2_00_1A ; id 26
    dw String_F2_00_1B ; id 27
    dw String_F2_00_1C ; id 28
    dw String_F2_00_1D ; id 29
    dw String_F2_00_1E ; id 30
    dw String_F2_00_1E ; id 31
    dw String_F2_00_1E ; id 32
    dw String_F2_00_1E ; id 33
    dw String_F2_00_22 ; id 34
    dw String_F2_00_23 ; id 35

String_F2_00_00::
    db "<VOICE2>*: Hello, how may I<LINE>"
    db "serve you?@"

String_F2_00_02::
    db "<VOICE2>*: Which egg should<LINE>"
    db "I appraise?@"

String_F2_00_03::
    db "<VOICE2>*: It will cost<LINE>"
    db "20G. It that OK?@"

String_F2_00_04::
    db "<VOICE2>*: How else may I<LINE>"
    db "serve you?@"

String_F2_00_05::
    db "<VOICE2>*: Um… You don't<LINE>"
    db "have enough gold…<WAIT>"
    db "@"

String_F2_00_06::
    db "<VOICE2>*: Um… You don't<LINE>"
    db "have any eggs…<WAIT>"
    db "@"

String_F2_00_07::
    db "<VOICE2>*: Which egg should<LINE>"
    db "I bless?@"

String_F2_00_08::
    db "<VOICE2>*: It will cost<LINE>"
    db "<BUF0>G. Is that OK?@"

String_F2_00_09::
    db "<VOICE2>*: Egg, egg, toss<LINE>"
    db "and scramble…<MUSIC_WAIT>", $00, "<SFX_WAIT>", $d2, "<PROMPT>"
    db "<NEXT><MAP_MUSIC>There…"
    db "<NEXT>That did it.<PROMPT>"
    db "<NEXT>You just have to"
    db "<NEXT>hatch it now.<WAIT>"
    db "@"

String_F2_00_0A::
    db "<VOICE2>*: Please come see<LINE>"
    db "me when you get<PROMPT>"
    db "<NEXT>more eggs."
    db "<NEXT><WAIT>"
    db "@"

String_F2_00_0B::
    db "<VOICE2>*: OK, I'll evaluate<LINE>"
    db "this egg now…<WAIT>"
    db "@"

String_F2_00_0C::
    db "<VOICE2>*: It's fine. There's<LINE>"
    db "nothing wrong.<WAIT>"
    db "@"

String_F2_00_0D::
    db "<VOICE2>*: It's good, and<LINE>"
    db "growing healthy.<WAIT>"
    db "@"

String_F2_00_0E::
    db "<VOICE2>*: Wow, this egg is<LINE>"
    db "really vigorous.<WAIT>"
    db "@"

String_F2_00_0F::
    db "<VOICE2>*: Oh, my! This egg<LINE>"
    db "is incredible!<WAIT>"
    db "@"

String_F2_00_10::
    db "<VOICE2>*: Don't expect too<LINE>"
    db "many skills.<WAIT>"
    db "@"

String_F2_00_11::
    db "<VOICE2>*: It has a fair<LINE>"
    db "number of skills.<WAIT>"
    db "@"

String_F2_00_12::
    db "<VOICE2>*: It inherited its<LINE>"
    db "parents' skills.<WAIT>"
    db "@"

String_F2_00_13::
    db "<VOICE2>*: It knows a great<LINE>"
    db "variety of skills!<WAIT>"
    db "@"

String_F2_00_14::
    db "<VOICE2>*: Its growth may<LINE>"
    db "be a bit wanting.<WAIT>"
    db "@"

String_F2_00_15::
    db "<VOICE2>*: It will grow in<LINE>"
    db "an average way.<WAIT>"
    db "@"

String_F2_00_16::
    db "<VOICE2>*: It will be hard<LINE>"
    db "to raise a little…<WAIT>"
    db "@"

String_F2_00_17::
    db "<VOICE2>*: Its growth can't<LINE>"
    db "be faulted.<WAIT>"
    db "@"

String_F2_00_18::
    db "<VOICE2>*: It appears to be<LINE>"
    db "a hard worker.<WAIT>"
    db "@"

String_F2_00_19::
    db "<VOICE2>*: This one seems<LINE>"
    db "to be quite smart.<WAIT>"
    db "@"

String_F2_00_1A::
    db "<VOICE2>*: I can tell this<LINE>"
    db "one is kind.<WAIT>"
    db "@"

String_F2_00_1B::
    db "<VOICE2>*: No doubt at<LINE>"
    db "all-it's male.<WAIT>"
    db "@"

String_F2_00_1C::
    db "<VOICE2>*: No doubt at<LINE>"
    db "all-it's female.<WAIT>"
    db "@"

String_F2_00_1D::
    db "<VOICE2>*: That's the best<LINE>"
    db "I could do now.<PROMPT>"
    db "<NEXT>Um… I hope I was"
    db "<NEXT>useful to you.<WAIT>"
    db "@"

String_F2_00_1E::
    db "<VOICE2>*: Should I change<LINE>"
    db "someone's name?@"

String_F2_00_22::
    db "<VOICE2>*: Come here for<LINE>"
    db "renaming monsters.<WAIT>"
    db "@"

String_F2_00_23::
    db "<VOICE2>*: Pick the monster<LINE>"
    db "to rename.@"
    db "Is <BUF0> OK?@"
    db "Is <BUF0> OK?@"
    db "That name is<LINE>"
    db "already in use.<WAIT>"
    db "@"
    db "That name can't be<LINE>"
    db "used.<PROMPT>"
    db "<CLEAR>Please use another<LINE>"
    db "name.<WAIT>"
    db "@"
    db "<VOICE2>"
    db $45, $90, $12, $36, $90, $f9, $00, $90, $18, $14, $98, $f0, $eb, $45, $90, $12
    db $36, $90, $f9, $00, $90, $18, $14, $98, $f0, $eb, $45
    db " That name is<LINE>"
    db "already in use.<WAIT>"
    db "@"
    db "<VOICE2>"
    db $45
    db " That name can't<LINE>"
    db "be used.<PROMPT>"
    db "<CLEAR>You'll have to use<LINE>"
    db "another name.<WAIT>"
    db "@"

; Draws string $10 of category 0 of the bank $0E table (ShowString_Bank0E; its text begins 'ATKDEF'
; and is a 30-tile strip of stat heading text) as tiles at vTiles2 + $20, with a text window of
; wTextWindowRows 1 and wTextWindowWidth $1E, and then sets the window back to the default
; (wTextWindowTileLo/Hi = vTiles1, wTextWindowRows 2, wTextWindowWidth $12). It changes
; wStringIndex, wStringCategory and the text window variables. Far-called as the heading step of the
; partner and record stats screens (PartnerStats_ShowHeading, PartnerStats_DrawSummaryFrames and
; their bank $F1 twins). (C1, E-0386)
; shows string $10 of category 0 (ShowString_Bank0E) at vTiles2 + $20 with size $011E, then restores
; the default window (E-0121)
ShowStatsHeadingTiles::
    ld a, $10
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    ld hl, vTiles2 + $20
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1e01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank0E
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

; Draws string $0E of category 0 of the bank $0E table (the text 'InfoOK') as tiles at vTiles2 +
; $700, with a text window of wTextWindowRows 1 and wTextWindowWidth 7, then sets the window back to
; the default (vTiles1, rows 2, width $12) and copies 16 bytes from Tiles1Plus6E0Tiles_2 and 16 from
; Tiles1Plus6F0Tiles_2 (bank $1F) to vTiles1 + $6E0 and vTiles1 + $6F0. It changes wStringIndex,
; wStringCategory and the text window variables. Far-called by ShowString0EAndStep_Bank37 and
; ShowString0EAndStep_BankF1, steps of the link record screens. (C1, E-0386)
; shows string $0E of category 0 (ShowString_Bank0E) at vTiles2 + $700 with size $0107, restores the
; default window and copies two tiles from bank $1F to vTiles1 + $6E0 and + $6F0 (E-0121)
ShowInfoOKLabelTiles::
    ld a, $0e
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    ld hl, vTiles2 + $700
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0701
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank0E
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
    ld de, Tiles1Plus6E0Tiles_2
    ld hl, vTiles1 + $6e0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles_2
    ld hl, vTiles1 + $6f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; Draws the master name of the record in wRecordBufB as tiles. It copies the 16-byte plain tile
; pattern at SolidColor1Tile (the one FillTilesFromRequest uses) five times to vTiles2 + $290 onward
; with CopyTileBytesToVRAMCounted_BankF2, copies the up to 10 bytes at wRecordBufB + MON_MASTER_NAME
; into wNameGlyphBuf (CopyShortStringToNameGlyphBuf_BankF2), stores $F0 at wNameGlyphBuf + $A and
; draws its glyph tiles from vTiles2 + $290 with CopyGlyphTilesToVRAM. Called by
; ShowRecordBufBPersonalityAndMasterName after ShowCombinedPersonalityName. (C1, E-0386)
; clears five tiles at vTiles2 + $290 (copying $2940) and draws the name at wRecordBufB + $F there
; (E-0121) (E-0340: the address in its name read as its RAM name; was DrawRecordBufBMasterNameTiles)
DrawRecordBufBMasterNameTiles::
    ld hl, SolidColor1Tile
    ld de, vTiles2 + $290
    call CopyTileBytesToVRAMCounted_BankF2
    ld hl, SolidColor1Tile
    call CopyTileBytesToVRAMCounted_BankF2
    ld hl, SolidColor1Tile
    call CopyTileBytesToVRAMCounted_BankF2
    ld hl, SolidColor1Tile
    call CopyTileBytesToVRAMCounted_BankF2
    ld hl, SolidColor1Tile
    call CopyTileBytesToVRAMCounted_BankF2
    ld hl, wRecordBufB + MON_MASTER_NAME
    call CopyShortStringToNameGlyphBuf_BankF2
    ld de, vTiles2 + $290
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    call CopyGlyphTilesToVRAM
    ret

; Shows the combined personality name of the record in wRecordBufB: it calls
; CombinedPersonalityLevelIndex, stores the result (0 to 26) in wStringIndex and 7 in
; wStringCategory, sets a text window of wTextWindowRows 1 and wTextWindowWidth 9 at vTiles2 + $200
; and draws that string of bank $08 (StringTable_PersonalityNames, for example 'Hotblood' for index
; 0) with ShowString_Bank08. It then sets the text window back to the default (vTiles1, rows 2,
; width $12). Called by ShowRecordBufBPersonalityAndMasterName, a step of the stats pages. (C1,
; E-0386)
; shows personality name CombinedPersonalityLevelIndex (category 7) at vTiles2 + $200 with size
; $0109, then restores the default window (E-0121)
ShowCombinedPersonalityName::
    call CombinedPersonalityLevelIndex
    ld c, a
    ld [wStringIndex], a
    ld a, $07
    ld [wStringCategory], a
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
    farcall ShowString_Bank08
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

; A = 9 * L(MON_PERSONALITY) + 3 * L(MON_PERSONALITY + 3) + L(MON_PERSONALITY + 1), all bytes read
; from wRecordBufB, where L(v) is 0 for v of $C0 or more, 1 for v from $40 to $BF and 2 below $40
; (PersonalityGradeOfA). The result runs from 0 to 26 and is the index of the personality name that
; ShowCombinedPersonalityName shows. The byte at MON_PERSONALITY + 2 is not used. C ends as L of the
; MON_PERSONALITY + 1 byte; B and HL are changed by the multiply. (C2, E-0386)
; returns 9 * PersonalityGradeOfA(wRecordBufB + $6F) + 3 * PersonalityGradeOfA(wRecordBufB + $72) +
; PersonalityGradeOfA(wRecordBufB + $70) (E-0121)
CombinedPersonalityLevelIndex::
    ld a, [wRecordBufB + MON_PERSONALITY]
    call PersonalityGradeOfA
    ld a, $09
    call Multiply8
    ld b, l
    ld a, [wRecordBufB + MON_PERSONALITY + 3]
    call PersonalityGradeOfA
    ld a, c
    add a
    add c
    add b
    ld b, a
    ld a, [wRecordBufB + MON_PERSONALITY + 1]
    call PersonalityGradeOfA
    ld a, c
    add b
    ret

; Grades one personality byte: A = the byte; returns C = 0 when A >= $C0, C = 1 when A >= $40,
; otherwise C = 2 (A is unchanged; carry is set only in the last case).
; CombinedPersonalityLevelIndex applies it to the bytes MON_PERSONALITY, MON_PERSONALITY + 3 and
; MON_PERSONALITY + 1 of wRecordBufB and adds 9, 3 and 1 times the three grades, giving a number
; 0-26: the personality name that ShowCombinedPersonalityName shows (string category 7, 'Hotblood'
; first). (C2, E-0386)
; C = 0 when A >= $C0, 1 when A >= $40, else 2 (the g(v) of PersonalityIndexOfSlot) (E-0116)
PersonalityGradeOfA::
    ld c, $00
    cp $c0
    ret nc
    inc c
    cp $40
    ret nc
    inc c
    ret

; Draws the two name lines of the second record page for wRecordBufB. ShowCombinedPersonalityName
; shows the personality name (category 7 string CombinedPersonalityLevelIndex, one row of 9 tiles at
; vTiles2 + $200) and puts the default text window back; then DrawRecordBufBMasterNameTiles fills
; five tiles at vTiles2 + $290 with the plain pattern at SolidColor1Tile (bank 0) and draws the
; master name MON_MASTER_NAME there. No inputs; all registers are clobbered. Step 18 of the record
; stats screen (RunScreenStateWhenNotFading_F1_StatsPersonality) and PartnerStats_ShowPersonality
; use it. (C1, E-0386)
; ShowCombinedPersonalityName, then DrawRecordBufBMasterNameTiles (E-0122) (E-0340: the address in
; its name read as its RAM name; was ShowRecordBufBPersonalityAndMasterName)
ShowRecordBufBPersonalityAndMasterName::
    call ShowCombinedPersonalityName
    call DrawRecordBufBMasterNameTiles
    ret

; Draws the experience of wRecordBufB as two seven-digit numbers on the second record page. First
; MON_EXP (24 bits, low byte first) goes through wDigits, Number24ToPackedBCD and
; UnpackBCDToDigitsArg1_Bank1E (leading zeros become the blank $E3) and
; DrawSevenDigitsFromArg1_BankF2 draws it at the BG map address of the scroll position + $018C
; (stepped back by StepBGMapAddressBackOnScrollWrap). Then, when MON_LEVEL is below MON_MAX_LEVEL,
; it loads the species record, looks up the ExpTable entry for the species EXP curve and the current
; level (LoadExpTableEntryToTemp2, the EXP needed for the next level), subtracts MON_EXP from it as
; a 24-bit number (no check for a negative result) and draws that at + $020C the same way. At or
; above the level cap it draws six blank tiles and a '0' there instead (wArg1-wArg6 = $E3, wArg7 =
; 0). Changes wDigits, wArg1-wArg7, hTemp0-hTemp4, wSpeciesIdLo/Hi, wSpeciesRecord and the BG map;
; step 19 of the record stats screen (RunScreenStateWhenNotFading_F1_StatsFamilyIcon) and
; PartnerStats_DrawFamilyIcon call it. (C1, E-0386)
; writes the EXP wRecordBufB + $58-wRecordBufB + $5A as seven digits and, below the level cap, the
; EXP still needed for the next level (E-0129) (E-0340: the address in its name read as its RAM
; name; was DrawRecordBufBExpAndExpToNextLevel)
DrawRecordBufBExpAndExpToNextLevel::
    ld a, [wRecordBufB + MON_EXP]
    ld [wDigits], a
    ld a, [wRecordBufB + MON_EXP + 1]
    ld [wDigits + $1], a
    ld a, [wRecordBufB + MON_EXP + 2]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    farcall UnpackBCDToDigitsArg1_Bank1E
    call BGMapAddressAtScroll_BankF2_2
    ld de, $018c
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    call DrawSevenDigitsFromArg1_BankF2
    ld a, [wRecordBufB + MON_LEVEL]
    ldh [hTemp0], a
    ld a, [wRecordBufB + MON_MAX_LEVEL]
    ldh [hTemp1], a
    ld b, a
    ldh a, [hTemp0]
    cp b
    jp nc, .set_arg1_to_E3
    ldh a, [hTemp0]
    ld b, a
    push bc
    ld a, [wRecordBufB + MON_SPECIES]
    ld [wSpeciesIdLo], a
    ld a, [wRecordBufB + MON_SPECIES + 1]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesExpCurve]
    ldh [hTemp0], a
    pop bc
    ld a, b
    ldh [hTemp1], a
    farcall LoadExpTableEntryToTemp2
    ld de, hTemp2
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld a, [de]
    ld e, a
    push bc
    push de
    ld a, [wRecordBufB + MON_EXP]
    ldh [hTemp0], a
    ld a, [wRecordBufB + MON_EXP + 1]
    ldh [hTemp1], a
    ld a, [wRecordBufB + MON_EXP + 2]
    ldh [hTemp2], a
    pop de
    pop bc
    ldh a, [hTemp0]
    ld l, a
    ld a, c
    sub l
    ld c, a
    ldh a, [hTemp1]
    ld l, a
    ld a, b
    sbc l
    ld b, a
    ldh a, [hTemp2]
    ld l, a
    ld a, e
    sbc l
    ld e, a
    ld a, c
    ld [wDigits], a
    ld a, b
    ld [wDigits + $1], a
    ld a, e
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    farcall UnpackBCDToDigitsArg1_Bank1E

.call_bg_map_address_at_scroll_bank_f2_2:
    call BGMapAddressAtScroll_BankF2_2
    ld de, $020c
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    call DrawSevenDigitsFromArg1_BankF2
    ret

.set_arg1_to_E3:
    ld a, $e3
    ld [wArg1], a
    ld [wArg2], a
    ld [wArg3], a
    ld [wArg4], a
    ld [wArg5], a
    ld [wArg6], a
    xor a
    ld [wArg7], a
    jr .call_bg_map_address_at_scroll_bank_f2_2

; Shows the name of the item equipped by the monster of wRecordBufB: string number MON_ITEM of
; category $0B (StringTable95_Cat0B in bank $95: 'None', then names such as 'VIT Belt' and 'Life
; Ring') through ShowString_Bank08, in a window of 2 rows and 6 tiles at vTiles2 + $320. It writes 0
; to rRAMG2 (cartridge RAM off) and leaves wTextWindowTileLo/Hi, wTextWindowRows and
; wTextWindowWidth set to this window (no restore). Step 20 of the record stats screen
; (RunScreenStateWhenNotFading_F1_StatsLoadSprite) and PartnerStats_LoadSprite call it before
; drawing the item box. (C1, E-0386)
; shows string wRecordBufB + $A4 of category $0B (ShowString_Bank08) at vTiles2 + $320 with size
; $0206 (E-0121) (E-0340: the address in its name read as its RAM name; was
; ShowRecordBufBEquippedItemName)
ShowRecordBufBEquippedItemName::
    ld a, [wRecordBufB + MON_ITEM]
    ld [wStringIndex], a
    ld a, $0b
    ld [wStringCategory], a
    xor a
    ld [rRAMG2], a
    ld hl, vTiles2 + $320
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0602
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank08
    ret

; Shows the field ability name of the species of wRecordBufB: loads the species record of
; MON_SPECIES (LoadSpeciesRecord), takes the string number SPECIES_FIELD_ABILITY of category $0D
; (StringTable_FieldAbilities in bank $95: 'None', 'Call' over 'ship', and so on) and draws it with
; ShowString_Bank08 in a window of 2 rows and 6 tiles at vTiles2 + $680. Leaves
; wTextWindowTileLo/Hi, wTextWindowRows and wTextWindowWidth set to this window (no restore). Called
; by step 26 of the record stats screen (RunScreenStateWhenNotFading_F1_StatsDescription) and
; PartnerStats_ShowDescription, whose comments call the string the description of the species. (C1,
; E-0386)
; loads the species record of wRecordBufB + $B/7 and shows string [wSpeciesRecord + $B] of category
; $0D at vTiles2 + $680 with size $0206 (E-0121)
ShowSpeciesFieldAbilityName::
    ld a, [wRecordBufB + MON_SPECIES]
    ld [wSpeciesIdLo], a
    ld a, [wRecordBufB + MON_SPECIES + 1]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord + SPECIES_FIELD_ABILITY]
    ld [wStringIndex], a
    ld a, $0d
    ld [wStringCategory], a
    ld hl, vTiles2 + $680
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0602
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank08
    ret

; Draws the parents on the pedigree page of the record screens for wRecordBufB:
; DrawRecordBufBParents_DrawNames draws their names and master names, then
; DrawRecordBufBParents_DrawIcons their family icons, plus values and marks. No inputs; all
; registers are clobbered. Which parent comes first depends on bit 4 of MON_FAMILY in both. Step 31
; of the record stats screen (RunScreenStateWhenNotFading_F1_StatsDrawParents) and
; PartnerStats_DrawParents call it. (C1, E-0386)
; runs DrawRecordBufBParents_DrawNames and DrawRecordBufBParents_DrawIcons (E-0126) (E-0344: the
; address in its name dropped or read as the label there; was DrawRecordBufBParents)
DrawRecordBufBParents::
    call DrawRecordBufBParents_DrawNames
    call DrawRecordBufBParents_DrawIcons
    ret

; Draws record B's two parents, parent 1 first when wRecordBufB's MON_FAMILY bit 4 is clear and
; parent 2 first when it is set (two 4-byte tables after it: species offset, name offset, species
; offset, master offset). For the first, when the parent species word's high byte is $FF it puts
; three $98 glyphs ('???') at vTiles2 + $200, otherwise the parent's name glyphs there and its
; species name (ShowRecordBufBEntryStringAtArg1) at $9250; then its master's name glyphs at vTiles2
; + $2F0. The second goes the same way at vTiles2 + $340, $9390 and vTiles2 + $430. (C1, E-0371)
DrawRecordBufBParents_DrawNames::
    ld a, [wRecordBufB + MON_FAMILY]
    and $10
    and a
    jr nz, .skip
    ld de, DrawRecordBufBParents_DrawNames_Data1
    jr .call_load_temp0_word_from_record_buf_b

.skip:
    ld de, DrawRecordBufBParents_DrawNames_Data2

.call_load_temp0_word_from_record_buf_b:
    ld a, [de]
    push de
    call LoadTemp0WordFromRecordBufB
    pop de
    ldh a, [hTemp1]
    cp $ff
    jr nz, .next
    ld a, $98
    ld [wNameGlyphBuf], a
    ld a, $98
    ld [wNameGlyphBuf + $1], a
    ld a, $98
    ld [wNameGlyphBuf + $2], a
    ld a, $f0
    ld [wNameGlyphBuf + $3], a
    push de
    ld de, vTiles2 + $200
    call CopyGlyphTilesToVRAM
    pop de
    ld a, $03
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    jr .skip3

.next:
    inc de
    ld a, [de]
    inc de
    push de
    ld hl, wRecordBufB
    add_a_to_hl
    call CopyShortStringToNameGlyphBuf_BankF2
    ld de, vTiles2 + $200
    call CopyGlyphTilesToVRAM
    pop de
    ld a, $92
    ld [wArg1], a
    ld a, $50
    ld [wArg2], a
    ld a, [de]
    inc de
    push de
    ld [wArg3], a
    call ShowRecordBufBEntryStringAtArg1
    pop de

.skip3:
    ld a, [de]
    inc de
    push de
    ld hl, wRecordBufB
    add_a_to_hl
    call CopyShortStringToNameGlyphBuf_BankF2
    ld de, vTiles2 + $2f0
    call CopyGlyphTilesToVRAM
    pop de
    ld a, [de]
    push de
    call LoadTemp0WordFromRecordBufB
    pop de
    ldh a, [hTemp1]
    cp $ff
    jr nz, .next2
    ld a, $98
    ld [wNameGlyphBuf], a
    ld a, $98
    ld [wNameGlyphBuf + $1], a
    ld a, $98
    ld [wNameGlyphBuf + $2], a
    ld a, $f0
    ld [wNameGlyphBuf + $3], a
    push de
    ld de, vTiles2 + $340
    call CopyGlyphTilesToVRAM
    pop de
    ld a, $03
    add e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    jr .skip5

.next2:
    inc de
    ld a, [de]
    inc de
    push de
    ld hl, wRecordBufB
    add_a_to_hl
    call CopyShortStringToNameGlyphBuf_BankF2
    ld de, vTiles2 + $340
    call CopyGlyphTilesToVRAM
    pop de
    ld a, $93
    ld [wArg1], a
    ld a, $90
    ld [wArg2], a
    ld a, [de]
    inc de
    push de
    ld [wArg3], a
    call ShowRecordBufBEntryStringAtArg1
    pop de

.skip5:
    ld a, [de]
    ld hl, wRecordBufB
    add_a_to_hl
    call CopyShortStringToNameGlyphBuf_BankF2
    ld de, vTiles2 + $430
    call CopyGlyphTilesToVRAM
    ret

; Shows the name of one species word of wRecordBufB. wArg3 = the offset of the word in wRecordBufB
; and wArg1:wArg2 = the VRAM address (high:low) of the window. The string number is the low byte at
; that offset and the category is the high byte after it plus 2 (category 2 for ids below $100,
; category 3 from $100: the two monster-name lists), drawn by ShowString_Bank08 in a window of 1 row
; and 9 tiles. It leaves the text window registers (wTextWindowTileLo/Hi, wTextWindowRows,
; wTextWindowWidth) set to that window. Only DrawRecordBufBParents_DrawNames calls it, for the
; species name of each parent ($9250 and $9390). (C1, E-0386)
; shows string wRecordBufB[wArg3] of category wRecordBufB + $1[wArg3] + 2 at the address in wArg1/2
; with size $0109 (E-0121)
ShowRecordBufBEntryStringAtArg1::
    ld a, [wArg3]
    ld hl, wRecordBufB
    add_a_to_hl
    ld a, [hli]
    ld [wStringIndex], a
    ld a, [hl]
    add $02
    ld [wStringCategory], a
    ld a, [wArg1]
    ld h, a
    ld a, [wArg2]
    ld l, a
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0901
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    farcall ShowString_Bank08
    ret

; Eight bytes, two 4-byte records, one per parent, in the order parent 1 then parent 2: each is the
; wRecordBufB offsets of the species word, the name, the species word again (the species string
; source) and the master name. The bytes are $1A, $8E, $1A, $1E (MON_PARENT1_SPECIES,
; MON_PARENT1_NAME, MON_PARENT1_SPECIES, MON_PARENT1_MASTER) and $1C, $99, $1C, $29 (the same fields
; of parent 2). DrawRecordBufBParents_DrawNames uses this order when bit 4 of MON_FAMILY is clear.
; (C1, E-0381)
DrawRecordBufBParents_DrawNames_Data1::
    db $1a, $8e, $1a, $1e, $1c, $99, $1c, $29

; Eight bytes, the same two 4-byte parent records as DrawRecordBufBParents_DrawNames_Data1 in the
; opposite order: $1C, $99, $1C, $29 (parent 2: MON_PARENT2_SPECIES, MON_PARENT2_NAME,
; MON_PARENT2_SPECIES, MON_PARENT2_MASTER) then $1A, $8E, $1A, $1E (parent 1).
; DrawRecordBufBParents_DrawNames uses this order when bit 4 of MON_FAMILY is set. (C1, E-0381)
DrawRecordBufBParents_DrawNames_Data2::
    db $1c, $99, $1c, $29, $1a, $8e, $1a, $1e

; Draws the species icons of record B's parents (the layout by family bit 4): an unknown parent
; ($FFFF) gets a copy of tile $8430, otherwise its icon (DrawSpeciesIconForRecordBufBEntry) and a
; mark tile beside it. (C1, E-0357)
DrawRecordBufBParents_DrawIcons::
    ld a, [wRecordBufB + MON_FAMILY]
    and $10
    and a
    jr nz, .skip
    ld de, DrawRecordBufBParents_DrawIcons_Data1
    jr .call_load_temp0_word_from_record_buf_b

.skip:
    ld de, DrawRecordBufBParents_DrawIcons_Data2

.call_load_temp0_word_from_record_buf_b:
    ld a, [de]
    push de
    call LoadTemp0WordFromRecordBufB
    pop de
    ldh a, [hTemp1]
    cp $ff
    jr nz, .set_arg1
    push de
    ld hl, vTiles1 + $430
    ld de, vTiles2 + $6c0
    call CopyTileBytesToVRAMCounted_BankF2
    pop de
    inc de
    inc de
    inc de
    jr .call_load_temp0_word_from_record_buf_b2

.set_arg1:
    inc de
    ld a, [de]
    ld [wArg1], a
    inc de
    ld a, [de]
    dec de
    push de
    ld [wArg5], a
    xor a
    ld [wArg2], a
    ld a, $6a
    ld [wArg3], a
    ld a, $6c
    ld [wArg4], a
    call DrawSpeciesIconForRecordBufBEntry
    pop de
    call PickNameBufferForFirstByte_BankF2
    inc de
    inc de
    push de
    call BGMapAddressAtScroll_BankF2_2
    ld de, $006e
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    pop de

.call_load_temp0_word_from_record_buf_b2:
    ld a, [de]
    push de
    call LoadTemp0WordFromRecordBufB
    pop de
    ldh a, [hTemp1]
    cp $ff
    jr nz, .set_arg12
    push de
    ld hl, vTiles1 + $430
    ld de, vTiles2 + $6d0
    call CopyTileBytesToVRAMCounted_BankF2
    pop de
    inc de
    inc de
    inc de
    jr .return

.set_arg12:
    inc de
    ld a, [de]
    ld [wArg1], a
    inc de
    ld a, [de]
    dec de
    push de
    ld [wArg5], a
    ld a, $01
    ld [wArg2], a
    ld a, $8a
    ld [wArg3], a
    ld a, $6d
    ld [wArg4], a
    call DrawSpeciesIconForRecordBufBEntry
    pop de
    call PickNameBufferForFirstByte_BankF2
    push de
    call BGMapAddressAtScroll_BankF2_2
    ld de, $018e
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    pop de

.return:
    ret

; DE points at a byte: returns BC = wNameBufPlaceholder ($CCCD) when the byte is $98, otherwise BC =
; wNameBufAlt ($CDCC). DrawRecordBufBParents_DrawIcons calls it with DE at the plus-value offset of
; its parent table ($98 = MON_PARENT1_PLUS for parent 1, $A3 = MON_PARENT2_PLUS for parent 2) and
; uses only B, so B = $CC for parent 1 and $CD for parent 2; it writes B as a BG tile number beside
; the parent icon, the same two tile numbers as the sex mark $CC + sex bit of
; DrawLevelAndStatusRowForRecordBufBLevel. The buffers themselves are not used here. (C2, E-0386)
; BC = wNameBufPlaceholder when the byte at DE is $98 (the ??? placeholder), else wNameBufAlt
; (E-0122)
PickNameBufferForFirstByte_BankF2::
    ld a, [de]
    cp $98
    jr z, .done
    ld bc, wNameBufAlt
    jr .return

.done:
    ld bc, wNameBufPlaceholder

.return:
    ret

; Six bytes, two 3-byte records, parent 1 then parent 2: the wRecordBufB offset of the species word,
; of the plus value, and of the species word again for DrawSpeciesIconForRecordBufBEntry (wArg5).
; The bytes are $1A, $98, $1A (MON_PARENT1_SPECIES, MON_PARENT1_PLUS, MON_PARENT1_SPECIES) and $1C,
; $A3, $1C (MON_PARENT2_SPECIES, MON_PARENT2_PLUS, MON_PARENT2_SPECIES).
; DrawRecordBufBParents_DrawIcons uses this order when bit 4 of MON_FAMILY is clear. (C1, E-0381)
DrawRecordBufBParents_DrawIcons_Data1::
    db $1a, $98, $1a, $1c, $a3, $1c

; Six bytes, the same two 3-byte parent records as DrawRecordBufBParents_DrawIcons_Data1 in the
; opposite order: $1C, $A3, $1C (parent 2) then $1A, $98, $1A (parent 1).
; DrawRecordBufBParents_DrawIcons uses this order when bit 4 of MON_FAMILY is set. (C1, E-0381)
DrawRecordBufBParents_DrawIcons_Data2::
    db $1c, $a3, $1c, $1a, $98, $1a

; A = byte offset into wRecordBufB. Sets hTemp0 = the byte at wRecordBufB + A and hTemp1 = the next
; byte (a little-endian word, so hTemp1 is its high byte); returns with A = hTemp1 and DE = the
; address of that high byte. The pedigree routines (DrawRecordBufBParents_DrawNames,
; DrawRecordBufBParents_DrawIcons, DrawRecordBufBSpeciesSprites) use it to read species words, where
; a high byte of $FF marks an unknown parent. (C2, E-0386)
; A = byte offset: hTemp0/hTemp1 = the word at wRecordBufB + A (E-0079)
LoadTemp0WordFromRecordBufB::
    ld de, wRecordBufB
    add e
    ld e, a
    jr nc, .set_temp0
    inc d

.set_temp0:
    ld a, [de]
    ldh [hTemp0], a
    inc de
    ld a, [de]
    ldh [hTemp1], a
    ret

; HL = source string. Copies bytes to wNameGlyphBuf, at most 10, stopping before a $F0, then stores
; a $F0 terminator after them (so at wNameGlyphBuf + $0A when there is no $F0 in the first 10
; bytes). Returns with HL after the last byte read (after the $F0 when one stopped the copy), DE =
; the address of the terminator and C = 10 minus the number of bytes copied. CopyGlyphTilesToVRAM
; draws the result; the callers pass names inside wRecordBufB. (C2, E-0386)
; Copies up to 10 bytes from [HL] to wNameGlyphBuf, stopping at a $F0 byte, then stores a $F0
; terminator (the same 19 bytes appear in 2 banks)
CopyShortStringToNameGlyphBuf_BankF2::
    ld de, wNameGlyphBuf
    ld c, $0a

.loop:
    ld a, [hli]
    cp $f0
    jr z, .done
    ld [de], a
    inc de
    dec c
    jr nz, .loop

.done:
    ld a, $f0
    ld [de], a
    ret

; HL = a VRAM (BG map) address. Writes the seven bytes wArg1-wArg7 as tiles $E0 + digit at HL
; onward, each after WaitForVRAMAccess with interrupts off, and turns interrupts back on after each
; byte (they are left enabled). HL ends 7 past the start, C = 0. A digit of $E3 (a blanked leading
; zero) becomes the blank tile $C3. DrawRecordBufBExpAndExpToNextLevel uses it for the EXP and the
; EXP to the next level. (C1, E-0386)
; HL = VRAM address: writes the 7 bytes at wArg1 as tiles $E0 + digit to HL onward
; (WaitForVRAMAccess, interrupts off per byte) (E-0067) (the same 19 bytes appear in 2 banks)
DrawSevenDigitsFromArg1_BankF2::
    ld de, wArg1
    ld c, $07

.loop:
    di
    call WaitForVRAMAccess
    ld a, [de]
    add $e0
    ld [hli], a
    inc de
    ei
    dec c
    jr nz, .loop
    ret

; Loads the three monster pictures of the pedigree page of wRecordBufB. For picture c = 0, 1, 2 it
; reads the species word at the wRecordBufB offset DecompressRecordBufBSpeciesGraphics_Data2[c]
; (MON_SPECIES, MON_PARENT1_SPECIES, MON_PARENT2_SPECIES), or
; DecompressRecordBufBSpeciesGraphics_Data3[c] (the parents swapped) when bit 4 of MON_FAMILY is
; set. A word whose high byte is $FF (unknown parent) is skipped; otherwise wArg1:wArg2 = the word
; and wArg3-wArg5 = the three bytes of DecompressRecordBufBSpeciesGraphics_Data1 for c (palette
; offset $00, $08, $10 into wOBJPaletteBuffer; VRAM destination $8000, $8100, $8200), and
; DecompressGraphicsArg1ToArg4 decompresses the picture and, on CGB, loads its object palette. Step
; 30 of the record stats screen (RunScreenStateWhenNotFading_F1_StatsPedigreeFrame) and
; PartnerStats_DrawPedigreeFrame call it; DrawRecordBufBSpeciesSprites draws the sprites that use
; these tiles. (C1, E-0386)
; for the three species words of wRecordBufB (offsets DecompressRecordBufBSpeciesGraphics_Data2 or
; 4F44 by bit 4 of wRecordBufB + $D) decompresses their graphics to the targets in
; DecompressRecordBufBSpeciesGraphics_Data1 (E-0127)
DecompressRecordBufBSpeciesGraphics::
    ld c, $00

.loop:
    push bc
    ld a, [wRecordBufB + MON_FAMILY]
    and $10
    jr nz, .skip
    ld de, DecompressRecordBufBSpeciesGraphics_Data2
    jr .restore

.skip:
    ld de, DecompressRecordBufBSpeciesGraphics_Data3

.restore:
    pop bc
    push bc
    ld a, c
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    ld hl, wRecordBufB
    add_a_to_hl
    ld a, [hli]
    ldh [hTemp0], a
    ld a, [hl]
    ldh [hTemp1], a
    cp $ff
    jr z, .restore2
    pop bc
    push bc
    ldh a, [hTemp0]
    ld [wArg1], a
    ldh a, [hTemp1]
    ld [wArg2], a
    ld a, c
    ld b, a
    add a
    add b
    ld de, DecompressRecordBufBSpeciesGraphics_Data1
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld hl, wArg3
    ld c, $03

.loop2:
    ld a, [de]
    ld [hli], a
    inc de
    dec c
    jr nz, .loop2
    farcall DecompressGraphicsArg1ToArg4

.restore2:
    pop bc
    inc c
    ld a, c
    cp $03
    jr c, .loop
    ret

; Three 3-byte records for the three species pictures of record B: $00, $00, $80; $08, $00, $81;
; $10, $00, $82. DecompressRecordBufBSpeciesGraphics copies record c (c = 0-2) to wArg3-wArg5 for
; DecompressGraphicsArg1ToArg4: wArg3 is the offset into wOBJPaletteBuffer ($00, $08, $10, palette
; slots 0 to 2) and wArg4 and wArg5 the VRAM destination ($8000, $8100, $8200). (C1, E-0381)
DecompressRecordBufBSpeciesGraphics_Data1::
    db $00, $00, $80, $08, $00, $81, $10, $00, $82

; Draws the three monster sprites of the pedigree page, using the same species words and order as
; DecompressRecordBufBSpeciesGraphics (DecompressRecordBufBSpeciesGraphics_Data2 or _Data3 by bit 4
; of MON_FAMILY; a word with high byte $FF is skipped). For picture c it sets wArg1:wArg2 = the
; species word and wArg3-wArg6 from the 4-byte record c of DrawRecordBufBSpeciesSprites_Data (tile
; offset $00, $10, $20; X $10, $30, $30; Y $78, $68, $88; attribute 0, 1, 2) and far-calls
; DrawMetaSpritePartC0. It must run every frame: GameMode5_Update_LinkSession,
; GameMode5_Update_ExchangeJoypadOnRecords, GameMode5_Update_LinkSession_Breeding and
; ExchangeJoypadAndDrawMonsters call it while wScreenState is $0D and wScreenStep is $20 (the
; partner record pedigree page). (C1, E-0386)
; for the three species words of wRecordBufB draws their sprite parts at the positions in
; DrawRecordBufBSpeciesSprites_Data (E-0127)
DrawRecordBufBSpeciesSprites::
    ld c, $00

.loop:
    push bc
    ld a, [wRecordBufB + MON_FAMILY]
    ldh [hTemp0], a
    and $10
    jr nz, .skip
    ld de, DecompressRecordBufBSpeciesGraphics_Data2
    jr .restore

.skip:
    ld de, DecompressRecordBufBSpeciesGraphics_Data3

.restore:
    pop bc
    push bc
    ld a, c
    add e
    ld e, a
    jr nc, .call_load_temp0_word_from_record_buf_b
    inc d

.call_load_temp0_word_from_record_buf_b:
    ld a, [de]
    call LoadTemp0WordFromRecordBufB
    ldh a, [hTemp1]
    cp $ff
    jr z, .restore2
    pop bc
    push bc
    ldh a, [hTemp0]
    ld [wArg1], a
    ldh a, [hTemp1]
    ld [wArg2], a
    ld a, c
    add a
    add a
    ld de, DrawRecordBufBSpeciesSprites_Data
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld hl, wArg3
    ld c, $04

.loop2:
    ld a, [de]
    ld [hli], a
    inc de
    dec c
    jr nz, .loop2
    ld c, $00
    farcall DrawMetaSpritePartC0

.restore2:
    pop bc
    inc c
    ld a, c
    cp $03
    jr c, .loop
    ret

; Three 4-byte records, one per species picture of record B: $00, $10, $78, $00; $10, $30, $68, $01;
; $20, $30, $88, $02. DrawRecordBufBSpeciesSprites copies record c (c = 0-2) to wArg3-wArg6 for
; DrawMetaSpritePartC0: tile offset ($00, $10, $20), X on screen ($10, $30, $30), Y on screen ($78,
; $68, $88) and the attribute bits (palette 0, 1, 2). (C1, E-0381)
DrawRecordBufBSpeciesSprites_Data::
    db $00, $10, $78, $00, $10, $30, $68, $01, $20, $30, $88, $02

; Three wRecordBufB offsets of species words: $0B (MON_SPECIES), $1A (MON_PARENT1_SPECIES) and $1C
; (MON_PARENT2_SPECIES), indexed by the picture number c = 0-2. DecompressRecordBufBSpeciesGraphics
; and DrawRecordBufBSpeciesSprites use this order when bit 4 of MON_FAMILY is clear. (C1, E-0381)
DecompressRecordBufBSpeciesGraphics_Data2::
    db $0b, $1a, $1c

; Three wRecordBufB offsets of species words: $0B (MON_SPECIES), $1C (MON_PARENT2_SPECIES) and $1A
; (MON_PARENT1_SPECIES), the parents swapped relative to DecompressRecordBufBSpeciesGraphics_Data2.
; DecompressRecordBufBSpeciesGraphics and DrawRecordBufBSpeciesSprites use this order when bit 4 of
; MON_FAMILY is set. (C1, E-0381)
DecompressRecordBufBSpeciesGraphics_Data3::
    db $0b, $1c, $1a

; Draws the level and status row for wRecordBufB in the BG map, starting at the scroll position +
; $29 (stepped back on a wrap). Writes tile $C3 (blank) there when MON_LEVEL is below MON_MAX_LEVEL,
; otherwise the cap mark $6F; then the tiles $EA and $ED, then the tens and ones digits of the level
; (the hundreds digit is dropped and a zero tens digit is blank). After them it fills three tiles
; with $C3 and puts $C1 on the first when bit 0 of MON_STATUS is set, $C0 on the second for bit 2
; (poison) and $C2 on the third for bit 7 (dead); it skips one tile and writes the sex mark $CC +
; bit 0 of MON_SEX. Every write waits for VRAM access with interrupts off. Called by
; DrawRecordBufBStatsScreen and by the level row steps of both record screens
; (RunScreenStateWhenNotFading_F1_StatsPage2LevelRow, PartnerStats_DrawLevelRow,
; PartnerStats_DrawSummaryLevelRow). (C1, E-0386)
; writes the level wRecordBufB + $56 (marked $6F at the cap wRecordBufB + $57), its digits and the
; status marks from wRecordBufB + $55 into the BG map (E-0129) (E-0340: the address in its name read
; as its RAM name; was DrawLevelAndStatusRowForRecordBufBLevel)
DrawLevelAndStatusRowForRecordBufBLevel::
    ld hl, wRecordBufB + MON_LEVEL
    ld a, [hli]
    ldh [hTemp0], a
    ld a, [hl]
    ldh [hTemp1], a
    call BGMapAddressAtScroll_BankF2_2
    ld de, $0029
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ldh a, [hTemp1]
    ld b, a
    ldh a, [hTemp0]
    cp b
    jr c, .call_wait_for_vram_access
    di
    call WaitForVRAMAccess
    ld a, $6f
    ld [hl], a
    ei
    jr .call_wait_for_vram_access2

.call_wait_for_vram_access:
    di
    call WaitForVRAMAccess
    ld a, $c3
    ld [hl], a
    ei

.call_wait_for_vram_access2:
    inc hl
    di
    call WaitForVRAMAccess
    ld a, $ea
    ld [hli], a
    ld a, $ed
    ld [hli], a
    ei
    push hl
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigits_F
    pop hl
    ld a, [wDigits + $1]
    add $e0
    ld e, a
    di
    call WaitForVRAMAccess
    ld [hl], e
    ei
    inc hl
    ld a, [wDigits + $2]
    add $e0
    ld e, a
    di
    call WaitForVRAMAccess
    ld [hl], e
    ei
    inc hl
    call WriteThreeC3TilesAtHL_BankF2
    ld a, [wRecordBufB + MON_STATUS]
    push af
    bit 0, a
    call nz, WriteTileC1AtHL_BankF2
    pop af
    inc hl
    push af
    bit 2, a
    call nz, WriteTileC0AtHL_BankF2
    pop af
    inc hl
    bit 7, a
    call nz, WriteTileC2AtHL_BankF2
    inc hl
    inc hl
    ld a, [wRecordBufB + MON_SEX]
    and $01
    add $cc
    ld e, a
    di
    call WaitForVRAMAccess
    ld [hl], e
    ei
    ret

; HL = a VRAM address. Writes the blank tile $C3 to the three bytes from HL (each after
; WaitForVRAMAccess, interrupts off, enabled again after each). HL is unchanged; A, C and E are
; clobbered. Only DrawLevelAndStatusRowForRecordBufBLevel calls it, to blank the three status mark
; places before the marks are written. (C1, E-0386)
; writes tile $C3 to the 3 VRAM bytes from HL (WaitForVRAMAccess, interrupts off per byte); HL kept;
; clobbers C, E (E-0067) (the same 17 bytes appear in 2 banks)
WriteThreeC3TilesAtHL_BankF2::
    push hl
    ld e, $c3
    ld c, $03

.loop:
    di
    call WaitForVRAMAccess
    ld [hl], e
    ei
    inc hl
    dec c
    jr nz, .loop
    pop hl
    ret

; HL = a VRAM address. Writes tile $C1 there after WaitForVRAMAccess with interrupts off and leaves
; interrupts enabled; HL is unchanged and A = $C1. DrawLevelAndStatusRowForRecordBufBLevel calls it
; when bit 0 of MON_STATUS is set. (C1, E-0386)
; writes tile $C1 at VRAM address HL (WaitForVRAMAccess, interrupts off) (E-0067) (the same 9 bytes
; appear in 2 banks)
WriteTileC1AtHL_BankF2::
    di
    call WaitForVRAMAccess
    ld a, $c1
    ld [hl], a
    ei
    ret

; HL = a VRAM address. Writes tile $C0 there after WaitForVRAMAccess with interrupts off and leaves
; interrupts enabled; HL is unchanged and A = $C0. DrawLevelAndStatusRowForRecordBufBLevel calls it
; when bit 2 of MON_STATUS is set. (C1, E-0386)
; writes tile $C0 at VRAM address HL (WaitForVRAMAccess, interrupts off) (E-0067) (the same 9 bytes
; appear in 2 banks)
WriteTileC0AtHL_BankF2::
    di
    call WaitForVRAMAccess
    ld a, $c0
    ld [hl], a
    ei
    ret

; HL = a VRAM address. Writes tile $C2 there after WaitForVRAMAccess with interrupts off and leaves
; interrupts enabled; HL is unchanged and A = $C2. DrawLevelAndStatusRowForRecordBufBLevel calls it
; when bit 7 of MON_STATUS is set. (C1, E-0386)
; writes tile $C2 at VRAM address HL (WaitForVRAMAccess, interrupts off) (E-0067) (the same 9 bytes
; appear in 2 banks)
WriteTileC2AtHL_BankF2::
    di
    call WaitForVRAMAccess
    ld a, $c2
    ld [hl], a
    ei
    ret

; Draws the values of the first record page for wRecordBufB: the level and status row
; (DrawLevelAndStatusRowForRecordBufBLevel), the column of ATK, DEF, AGL, INT and WLD
; (DrawRecordBufBStatColumn) and the HP and MP numbers (DrawRecordBufBHpMpDigits). No inputs; all
; registers are clobbered. Step 4 of the record stats screen
; (RunScreenStateWhenNotFading_F1_StatsDrawValues) and PartnerStats_DrawStats call it. (C1, E-0386)
; runs DrawLevelAndStatusRowForRecordBufBLevel, DrawRecordBufBStatColumn and
; DrawRecordBufBHpMpDigits (E-0126)
DrawRecordBufBStatsScreen::
    call DrawLevelAndStatusRowForRecordBufBLevel
    call DrawRecordBufBStatColumn
    call DrawRecordBufBHpMpDigits
    ret

; Draws four numbers of wRecordBufB as three digits each: for c = 0-3 it reads the word at the
; wRecordBufB offset DrawRecordBufBHpMpDigits_Data1[c] (MON_HP, MON_MAX_HP, MON_MP, MON_MAX_MP),
; turns it into digits with HLToDecimalDigits (above 999 the first digit is HL / 100) and
; BlankLeadingZeroDigits_F, and writes them with WriteThreeDigitsAtHL at the BG map address of the
; scroll position plus the little-endian word DrawRecordBufBHpMpDigits_Data2[c] ($01CC, $01D0,
; $020C, $0210: rows 14 and 16, columns 12 and 16), stepped back by
; StepBGMapAddressBackOnScrollWrap. Changes wDigits and the BG map. (C1, E-0386)
; writes four stat words from wRecordBufB (offsets DrawRecordBufBHpMpDigits_Data1) as three digits
; at the scroll offsets DrawRecordBufBHpMpDigits_Data2 (E-0125)
DrawRecordBufBHpMpDigits::
    ld c, $00

.loop:
    push bc
    ld a, c
    ld hl, DrawRecordBufBHpMpDigits_Data1
    add_a_to_hl
    ld a, [hl]
    ld hl, wRecordBufB
    add_a_to_hl
    ld a, [hli]
    ld b, a
    ld a, [hl]
    ld h, a
    ld l, b
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigits_F
    pop bc
    ld a, c
    add a
    ld hl, DrawRecordBufBHpMpDigits_Data2
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_BankF2_2
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    call WriteThreeDigitsAtHL
    inc c
    ld a, c
    cp $04
    jr c, .loop
    ret

; Four wRecordBufB offsets of words: $5B (MON_HP), $5D (MON_MAX_HP), $5F (MON_MP) and $61
; (MON_MAX_MP). DrawRecordBufBHpMpDigits reads word c (c = 0-3), converts it to digits
; (HLToDecimalDigits) and writes three digit tiles at the place from
; DrawFourRecordBufBStatsDigits_Data2[c]. (C1, E-0381)
DrawRecordBufBHpMpDigits_Data1::
    db $5b, $5d, $5f, $61

; Four little-endian offsets, $01CC, $01D0, $020C and $0210 (rows 14 and 16, columns 12 and 16),
; added to the BG map address of the scroll position (BGMapAddressAtScroll_BankF2_2).
; DrawRecordBufBHpMpDigits writes the three digit tiles of HP, max HP, MP and max MP
; (DrawRecordBufBHpMpDigits_Data1 order) at them. (C1, E-0381)
DrawRecordBufBHpMpDigits_Data2::
    db $cc, $01, $d0, $01, $0c, $02, $10, $02

; Draws five numbers of wRecordBufB as a column of three-digit values: for c = 0-4 it reads the word
; at the wRecordBufB offset DrawRecordBufBStatColumn_Data[c] (MON_ATK, MON_DEF, MON_AGL, MON_INT,
; MON_WLD), converts it with HLToDecimalDigits (above 999 the first digit is HL / 100) and
; BlankLeadingZeroDigits_F and writes the digits with WriteThreeDigitsAtHL. The first goes at the BG
; map address of the scroll position + $70 (stepped back on a wrap) and each next one $40 further,
; two map rows down. Changes wDigits and the BG map. (C1, E-0386)
; writes five stat words from wRecordBufB (offsets DrawRecordBufBStatColumn_Data) as three digits
; down a column at scroll + $70 (E-0125)
DrawRecordBufBStatColumn::
    call BGMapAddressAtScroll_BankF2_2
    ld de, $0070
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld c, $00

.loop:
    push bc
    push hl
    ld a, c
    ld de, DrawRecordBufBStatColumn_Data
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld hl, wRecordBufB
    add_a_to_hl
    ld a, [hli]
    ld b, a
    ld a, [hl]
    ld h, a
    ld l, b
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigits_F
    pop hl
    push hl
    call WriteThreeDigitsAtHL
    pop hl
    ld a, $40
    add_a_to_hl
    pop bc
    inc c
    ld a, c
    cp $05
    jr c, .loop
    ret

; Five wRecordBufB offsets of word stats: $63 (MON_ATK), $65 (MON_DEF), $67 (MON_AGL), $69 (MON_INT)
; and $6B (MON_WLD). DrawRecordBufBStatColumn reads word c (c = 0-4) and writes its three digit
; tiles in a column that starts at the scroll position plus $70 and goes down two BG map rows ($40)
; per stat. (C1, E-0381)
DrawRecordBufBStatColumn_Data::
    db $63, $65, $67, $69, $6b

; HL = a VRAM (BG map) address. Writes wDigits, wDigits + 1 and wDigits + 2 as tiles $E0 + digit to
; HL, HL + 1 and HL + 2, each after WaitForVRAMAccess with interrupts off; interrupts are left
; enabled, HL ends 3 past the start and A is clobbered. DrawRecordBufBHpMpDigits and
; DrawRecordBufBStatColumn call it after HLToDecimalDigits and BlankLeadingZeroDigits_F. (C1,
; E-0386)
; writes wDigits, wDigits + $1, wDigits + $2 as digit tiles ($E0 + n) at HL (E-0121)
WriteThreeDigitsAtHL::
    di
    call WaitForVRAMAccess
    ld a, [wDigits]
    add $e0
    ld [hli], a
    ei
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $1]
    add $e0
    ld [hli], a
    ei
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $2]
    add $e0
    ld [hli], a
    ei
    ret

; wArg5 = the offset in wRecordBufB of a species word. Reads the word into hTemp0/hTemp1 and
; far-calls DrawSpeciesAndFamilyIconForTemp0, which loads the family icon of that species into tile
; number wArg4 (it overwrites wArg5-wArg7 and wWorkBuf), then jumps to DrawRecordBufBPlusValue,
; which draws the plus value at the wRecordBufB offset wArg1 at the BG map address of the scroll
; position + wArg2:wArg3 and returns to the caller. BC is saved around the icon load. Only
; DrawRecordBufBParents_DrawIcons calls it, once for each parent. (C1, E-0386)
; hTemp0/7 = the word wRecordBufB[wArg5], far-calls DrawSpeciesAndFamilyIconForTemp0 and continues
; at DrawRecordBufBPlusValue (E-0126)
DrawSpeciesIconForRecordBufBEntry::
    push bc
    ld hl, wRecordBufB
    ld a, [wArg5]
    add_a_to_hl
    ld a, [hli]
    ldh [hTemp0], a
    ld a, [hl]
    ldh [hTemp1], a
    farcall DrawSpeciesAndFamilyIconForTemp0
    pop bc
    jp DrawRecordBufBPlusValue

; Draws the family icon and the plus value of the monster in wRecordBufB. Sets wWorkBuf to the low
; nibble of wRecordBufB + MON_FAMILY and wWorkBuf + 1 to wArg4, then far-calls
; LoadFamilyIconTileForWorkBuf, which writes that family icon (16 bytes) to VRAM tile number wArg4.
; It then falls into DrawRecordBufBPlusValue, which writes tile $1E and the decimal value of
; wRecordBufB[wArg1] (nothing at all when that byte is 0) at the BG map cell of the scroll origin
; plus the offset wArg2:wArg3, with the tens digit left out when it is a leading zero; the hundreds
; digit is never drawn. Inputs: wArg1 = a record offset, wArg2:wArg3 = the cell offset (high byte
; first), wArg4 = the tile number. The two callers, PartnerStats_DrawFamilyIcon and
; RunScreenStateWhenNotFading_F1_StatsFamilyIcon, set wArg1-wArg4 = MON_PLUS ($6D), 0, $EA, $C7 on
; the second stats page. (C1, E-0386)
; loads the family icon of wRecordBufB + $D & $0F into tile wArg4; the next entry draws tile $1E and
; the count wRecordBufB[wArg1] at the scroll offset wArg2/3 (E-0127) (E-0340: the address in its
; name read as its RAM name; was DrawRecordBufBFamilyIconAndPlus)
DrawRecordBufBFamilyIconAndPlus::
    push bc
    ld a, [wRecordBufB + MON_FAMILY]
    and $0f
    ld [wWorkBuf], a
    ld a, [wArg4]
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    pop bc

; wArg1 = a record offset (MON_PLUS from the bank-$F1 and bank-$37 callers, MON_PARENT1_PLUS or
; MON_PARENT2_PLUS from RunF2_DrawParentIcons): when wRecordBufB's byte there is non-zero, writes
; tile $1E at the BG map address of the scroll position plus wArg2:wArg3 (stepping back on a scroll
; wrap), then the value's tens digit (skipped when it is a leading zero, BlankLeadingZeroDigits_F)
; and ones digit as tiles $E0 + digit right after it. The tail of DrawRecordBufBFamilyIconAndPlus,
; also jumped to by DrawSpeciesIconForRecordBufBEntry. (C1, E-0371)
DrawRecordBufBPlusValue::
    ld a, [wArg1]
    ld hl, wRecordBufB
    add_a_to_hl
    ld a, [hl]
    and a
    jr nz, .call_bg_map_address_at_scroll_bank_f2_2
    ret

.call_bg_map_address_at_scroll_bank_f2_2:
    push af
    call BGMapAddressAtScroll_BankF2_2
    ld a, [wArg2]
    ld d, a
    ld a, [wArg3]
    ld e, a
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, $1e
    ld [hli], a
    ei
    pop af
    push hl
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigits_F
    pop hl
    ld a, [wDigits + $1]
    cp $e3
    jr z, .call_wait_for_vram_access
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $1]
    add $e0
    ld [hli], a
    ei

.call_wait_for_vram_access:
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $2]
    add $e0
    ld [hli], a
    ei
    ret

; HL = the BG map 0 cell at the scroll origin: vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8 (32
; cells per tile row, so the pixel row divided by 8 times 32, plus the tile column). Clobbers A and
; DE. The callers add a cell offset to it before drawing tiles (DrawRecordBufBPlusValue adds
; wArg2:wArg3; DrawRecordBufBExpAndExpToNextLevel, DrawLevelAndStatusRowForRecordBufBLevel,
; DrawRecordBufBHpMpDigits and DrawRecordBufBStatColumn use it the same way). A copy of a helper
; that other banks also carry. (C1, E-0386)
; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX,
; hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
BGMapAddressAtScroll_BankF2_2::
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

; Copies one tile, 16 bytes, from [HL] to [DE]. For each byte it disables interrupts, waits until
; bit 1 of rSTAT is clear (the screen is not in OAM scan or drawing, so VRAM is open), writes the
; byte and enables interrupts again, so interrupts are on when it returns. HL and DE advance by 16;
; A ends 0. Callers: DrawRecordBufBMasterNameTiles (five tiles from ROM address $2940 to vTiles2 +
; $290) and DrawRecordBufBParents_DrawIcons (the tile at vTiles1 + $430 to vTiles2 + $6C0 or + $6D0
; when hTemp1 is $FF). (C1, E-0386)
; copies 16 bytes from HL to DE, each written with interrupts off after rSTAT bit 1 clears (the same
; effect as CopyTileBytesToVRAM, with a counter kept on the stack); HL and DE advance (E-0076)
CopyTileBytesToVRAMCounted_BankF2::
    ld a, $10

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
    dec a
    jr nz, .loop
    ret

; Reorders the three bytes wArg5-wArg7 for one monster. Input: wArg2:wArg1 = a monster id (wArg1 the
; low byte; MonsterArgOrderTable has 384 rows). It reads the 3-byte row MonsterArgOrderTable + 3 *
; id; byte k of the row says where wArg5 + k goes among wArg1-wArg3, so it stores wArg5, wArg6 and
; wArg7 at wArg1 + row[0], + row[1] and + row[2], then copies wArg1-wArg3 over wArg5-wArg7. Output:
; wArg5-wArg7 and wArg1-wArg3 both hold the reordered bytes (the id in wArg1/wArg2 is gone); wArg4
; is untouched. The only caller, LibraryMenu_ShowMonsterEntry_DrawEntry, runs it after
; LoadSpeciesBytes8To10ToArg5 has put the three natural skills of the monster in wArg5-wArg7, and
; then prints them as skill names, so each monster lists its three skills in the order of its row.
; (C2, E-0386)
; reorders the three bytes wArg5-7 by the permutation MonsterArgOrderTable[wArg2:wArg1] (byte k says
; where wArg5 + k goes among wArg1-3), then copies the result back to wArg5-7 (E-0171)
PermuteArg5To7ByMonster::
    ld a, [wArg1]
    ld c, a
    ld a, [wArg2]
    ld b, a
    ld a, $03
    call Multiply8By16
    ld de, MonsterArgOrderTable
    add hl, de
    ld c, $03
    ld b, $00

.loop:
    ld a, [hli]
    ld de, wArg1
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    push hl
    ld a, b
    ld hl, wArg5
    add_a_to_hl
    ld a, [hl]
    pop hl
    ld [de], a
    inc b
    dec c
    jr nz, .loop
    ld a, [wArg1]
    ld [wArg5], a
    ld a, [wArg2]
    ld [wArg6], a
    ld a, [wArg3]
    ld [wArg7], a
    ret

; PermuteArg5To7ByMonster reads the 3 bytes at $51C3 + 3 * (wArg2:wArg1), stores wArg5 + k at wArg1
; + byte k, then copies wArg1-3 back to wArg5-7; all 384 entries are permutations; the caller,
; script command $F6 case $10/4, indexes it with the id it shows as a monster name (E-0171, C1)
; record: destination offsets of wArg5-7 among wArg1-3 (always a permutation of 0, 1, 2)
MonsterArgOrderTable::
    db $00, $01, $02 ; id 0
    db $02, $00, $01 ; id 1 DrakSlime
    db $01, $00, $02 ; id 2 SpotSlime
    db $00, $01, $02 ; id 3 WingSlime
    db $01, $02, $00 ; id 4 TreeSlime
    db $00, $01, $02 ; id 5 Snaily
    db $00, $01, $02 ; id 6 SlimeNite
    db $00, $01, $02 ; id 7 Babble
    db $00, $01, $02 ; id 8 BoxSlime
    db $00, $01, $02 ; id 9 PearlGel
    db $00, $02, $01 ; id 10 Slime
    db $00, $02, $01 ; id 11 Healer
    db $00, $01, $02 ; id 12 FangSlime
    db $00, $01, $02 ; id 13 RockSlime
    db $01, $02, $00 ; id 14 SlimeBorg
    db $01, $00, $02 ; id 15 Slabbit
    db $00, $01, $02 ; id 16 KingSlime
    db $00, $01, $02 ; id 17 Metaly
    db $00, $01, $02 ; id 18 Metabble
    db $02, $00, $01 ; id 19 SpotKing
    db $02, $00, $01 ; id 20 TropicGel
    db $00, $01, $02 ; id 21 MimeSlime
    db $00, $01, $02 ; id 22 HaloSlime
    db $00, $01, $02 ; id 23 MetalKing
    db $00, $01, $02 ; id 24 GoldSlime
    db $01, $02, $00 ; id 25 GranSlime
    db $01, $00, $02 ; id 26 WonderEgg
    db $00, $01, $02 ; id 27 Butch
    db $00, $01, $02 ; id 28 ?
    db $00, $01, $02 ; id 29 ?
    db $00, $01, $02 ; id 30 ?
    db $00, $01, $02 ; id 31 ?
    db $00, $01, $02 ; id 32 ?
    db $00, $01, $02 ; id 33 ?
    db $00, $01, $02 ; id 34 ?
    db $00, $01, $02 ; id 35 ?
    db $01, $00, $02 ; id 36 DragonKid
    db $02, $00, $01 ; id 37 Tortragon
    db $00, $02, $01 ; id 38 Pteranod
    db $02, $01, $00 ; id 39 Gasgon
    db $02, $00, $01 ; id 40 FairyDrak
    db $00, $02, $01 ; id 41 LizardMan
    db $00, $02, $01 ; id 42 Poisongon
    db $01, $02, $00 ; id 43 Swordgon
    db $00, $02, $01 ; id 44 Drygon
    db $00, $01, $02 ; id 45 Dragon
    db $02, $01, $00 ; id 46 MiniDrak
    db $01, $02, $00 ; id 47 MadDragon
    db $01, $02, $00 ; id 48 Rayburn
    db $01, $00, $02 ; id 49 Chamelgon
    db $00, $01, $02 ; id 50 LizardFly
    db $00, $01, $02 ; id 51 Andreal
    db $00, $01, $02 ; id 52 KingCobra
    db $00, $01, $02 ; id 53 Vampirus
    db $02, $00, $01 ; id 54 SnakeBat
    db $01, $00, $02 ; id 55 Spikerous
    db $00, $01, $02 ; id 56 GreatDrak
    db $00, $02, $01 ; id 57 Crestpent
    db $01, $00, $02 ; id 58 WingSnake
    db $00, $01, $02 ; id 59 Coatol
    db $00, $01, $02 ; id 60 Orochi
    db $00, $01, $02 ; id 61 BattleRex
    db $00, $02, $01 ; id 62 SkyDragon
    db $00, $01, $02 ; id 63 Serpentia
    db $01, $00, $02 ; id 64 Divinegon
    db $01, $00, $02 ; id 65 Orligon
    db $00, $01, $02 ; id 66 GigaDraco
    db $00, $01, $02 ; id 67 ?
    db $00, $01, $02 ; id 68 ?
    db $00, $01, $02 ; id 69 ?
    db $00, $01, $02 ; id 70 ?
    db $01, $00, $02 ; id 71 Tonguella
    db $00, $01, $02 ; id 72 Almiraj
    db $01, $00, $02 ; id 73 CatFly
    db $00, $01, $02 ; id 74 PillowRat
    db $00, $01, $02 ; id 75 Saccer
    db $02, $00, $01 ; id 76 GulpBeast
    db $01, $02, $00 ; id 77 Skullroo
    db $00, $01, $02 ; id 78 WindBeast
    db $00, $02, $01 ; id 79 Beavern
    db $02, $01, $00 ; id 80 Antbear
    db $00, $02, $01 ; id 81 SuperTen
    db $00, $02, $01 ; id 82 IronTurt
    db $00, $01, $02 ; id 83 Mommonja
    db $00, $01, $02 ; id 84 HammerMan
    db $00, $02, $01 ; id 85 Grizzly
    db $00, $01, $02 ; id 86 Yeti
    db $00, $01, $02 ; id 87 ArrowDog
    db $01, $00, $02 ; id 88 NoctoKing
    db $00, $01, $02 ; id 89 BeastNite
    db $00, $02, $01 ; id 90 MadGopher
    db $01, $00, $02 ; id 91 FairyRat
    db $00, $02, $01 ; id 92 Unicorn
    db $00, $02, $01 ; id 93 Goategon
    db $02, $00, $01 ; id 94 WildApe
    db $02, $00, $01 ; id 95 Trumpeter
    db $00, $01, $02 ; id 96 KingLeo
    db $00, $01, $02 ; id 97 DarkHorn
    db $00, $01, $02 ; id 98 MadCat
    db $00, $01, $02 ; id 99 BigEye
    db $00, $01, $02 ; id 100 Gorago
    db $00, $01, $02 ; id 101 CatMage
    db $00, $02, $01 ; id 102 Dumbira
    db $00, $01, $02 ; id 103 ?
    db $00, $01, $02 ; id 104 ?
    db $00, $01, $02 ; id 105 ?
    db $00, $01, $02 ; id 106 Picky
    db $00, $01, $02 ; id 107 Wyvern
    db $00, $01, $02 ; id 108 BullBird
    db $00, $01, $02 ; id 109 Florajay
    db $00, $01, $02 ; id 110 DuckKite
    db $00, $01, $02 ; id 111 MadPecker
    db $00, $01, $02 ; id 112 MadRaven
    db $00, $02, $01 ; id 113 MistyWing
    db $02, $00, $01 ; id 114 AquaHawk
    db $01, $00, $02 ; id 115 Dracky
    db $02, $00, $01 ; id 116 KiteHawk
    db $01, $00, $02 ; id 117 BigRoost
    db $01, $00, $02 ; id 118 StubBird
    db $00, $01, $02 ; id 119 LandOwl
    db $00, $01, $02 ; id 120 MadGoose
    db $00, $01, $02 ; id 121 MadCondor
    db $00, $01, $02 ; id 122 Emyu
    db $02, $00, $01 ; id 123 Blizzardy
    db $00, $02, $01 ; id 124 Phoenix
    db $02, $01, $00 ; id 125 ZapBird
    db $00, $02, $01 ; id 126 Garudian
    db $00, $01, $02 ; id 127 WhipBird
    db $00, $01, $02 ; id 128 FunkyBird
    db $02, $01, $00 ; id 129 RainHawk
    db $02, $00, $01 ; id 130 Azurile
    db $02, $00, $01 ; id 131 Shantak
    db $00, $01, $02 ; id 132 CragDevil
    db $00, $01, $02 ; id 133 ?
    db $00, $01, $02 ; id 134 ?
    db $00, $01, $02 ; id 135 ?
    db $00, $01, $02 ; id 136 ?
    db $00, $01, $02 ; id 137 ?
    db $00, $01, $02 ; id 138 ?
    db $00, $01, $02 ; id 139 ?
    db $00, $01, $02 ; id 140 ?
    db $00, $01, $02 ; id 141 MadPlant
    db $00, $01, $02 ; id 142 FireWeed
    db $00, $01, $02 ; id 143 FloraMan
    db $02, $00, $01 ; id 144 WingTree
    db $01, $00, $02 ; id 145 CactiBall
    db $02, $01, $00 ; id 146 Gulpple
    db $02, $00, $01 ; id 147 Toadstool
    db $02, $00, $01 ; id 148 AmberWeed
    db $00, $02, $01 ; id 149 Slurperon
    db $00, $01, $02 ; id 150 Stubsuck
    db $01, $02, $00 ; id 151 Oniono
    db $02, $00, $01 ; id 152 DanceVegi
    db $00, $01, $02 ; id 153 TreeBoy
    db $02, $00, $01 ; id 154 Devipine
    db $00, $02, $01 ; id 155 FaceTree
    db $00, $01, $02 ; id 156 HerbMan
    db $02, $00, $01 ; id 157 BeanMan
    db $02, $01, $00 ; id 158 EvilSeed
    db $02, $01, $00 ; id 159 ManEater
    db $00, $01, $02 ; id 160 Snapper
    db $00, $01, $02 ; id 161 GhosTree
    db $01, $00, $02 ; id 162 Rosevine
    db $01, $00, $02 ; id 163 Egdracil
    db $00, $02, $01 ; id 164 Warubou
    db $02, $01, $00 ; id 165 Watabou
    db $00, $01, $02 ; id 166 Eggplaton
    db $01, $00, $02 ; id 167 FooHero
    db $00, $01, $02 ; id 168 ?
    db $00, $01, $02 ; id 169 ?
    db $00, $01, $02 ; id 170 ?
    db $00, $01, $02 ; id 171 ?
    db $00, $01, $02 ; id 172 ?
    db $00, $01, $02 ; id 173 ?
    db $00, $01, $02 ; id 174 ?
    db $00, $01, $02 ; id 175 ?
    db $00, $01, $02 ; id 176 GiantSlug
    db $00, $01, $02 ; id 177 Catapila
    db $02, $00, $01 ; id 178 Gophecada
    db $00, $01, $02 ; id 179 Butterfly
    db $00, $01, $02 ; id 180 WeedBug
    db $00, $01, $02 ; id 181 GiantWorm
    db $00, $01, $02 ; id 182 Lipsy
    db $00, $01, $02 ; id 183 StagBug
    db $00, $02, $01 ; id 184 Pyuro
    db $01, $00, $02 ; id 185 ArmyAnt
    db $00, $01, $02 ; id 186 GoHopper
    db $00, $01, $02 ; id 187 TailEater
    db $00, $02, $01 ; id 188 ArmorPede
    db $00, $01, $02 ; id 189 Eyeder
    db $02, $00, $01 ; id 190 GiantMoth
    db $00, $01, $02 ; id 191 Droll
    db $00, $01, $02 ; id 192 ArmyCrab
    db $00, $02, $01 ; id 193 MadHornet
    db $00, $02, $01 ; id 194 Belzebub
    db $01, $00, $02 ; id 195 WarMantis
    db $02, $00, $01 ; id 196 HornBeet
    db $00, $01, $02 ; id 197 Sickler
    db $00, $01, $02 ; id 198 Armorpion
    db $01, $00, $02 ; id 199 Digster
    db $01, $02, $00 ; id 200 Skularach
    db $00, $01, $02 ; id 201 MultiEyes
    db $00, $01, $02 ; id 202 ?
    db $00, $01, $02 ; id 203 ?
    db $00, $01, $02 ; id 204 ?
    db $00, $01, $02 ; id 205 ?
    db $00, $01, $02 ; id 206 ?
    db $00, $01, $02 ; id 207 ?
    db $00, $01, $02 ; id 208 ?
    db $00, $01, $02 ; id 209 ?
    db $00, $01, $02 ; id 210 ?
    db $00, $01, $02 ; id 211 Pixy
    db $00, $01, $02 ; id 212 MedusaEye
    db $01, $02, $00 ; id 213 AgDevil
    db $00, $01, $02 ; id 214 Demonite
    db $00, $02, $01 ; id 215 DarkEye
    db $00, $01, $02 ; id 216 EyeBall
    db $00, $02, $01 ; id 217 SkulRider
    db $00, $02, $01 ; id 218 EvilBeast
    db $00, $01, $02 ; id 219 Bubblemon
    db $00, $01, $02 ; id 220 1EyeClown
    db $01, $00, $02 ; id 221 Gremlin
    db $00, $01, $02 ; id 222 ArcDemon
    db $00, $02, $01 ; id 223 Lionex
    db $00, $01, $02 ; id 224 GoatHorn
    db $02, $00, $01 ; id 225 Orc
    db $01, $00, $02 ; id 226 Ogre
    db $00, $01, $02 ; id 227 GateGuard
    db $02, $00, $01 ; id 228 ChopClown
    db $02, $00, $01 ; id 229 BossTroll
    db $00, $01, $02 ; id 230 Grendal
    db $00, $01, $02 ; id 231 Akubar
    db $00, $02, $01 ; id 232 MadKnight
    db $00, $01, $02 ; id 233 EvilWell
    db $00, $01, $02 ; id 234 Gigantes
    db $00, $01, $02 ; id 235 Centasaur
    db $00, $01, $02 ; id 236 EvilArmor
    db $02, $00, $01 ; id 237 Jamirus
    db $02, $01, $00 ; id 238 Durran
    db $00, $01, $02 ; id 239 Titanis
    db $00, $01, $02 ; id 240 LampGenie
    db $00, $01, $02 ; id 241 ?
    db $00, $01, $02 ; id 242 ?
    db $00, $01, $02 ; id 243 ?
    db $00, $01, $02 ; id 244 ?
    db $00, $01, $02 ; id 245 ?
    db $00, $01, $02 ; id 246 Spooky
    db $00, $01, $02 ; id 247 Skullgon
    db $00, $01, $02 ; id 248 PutrePup
    db $00, $01, $02 ; id 249 RotRaven
    db $01, $00, $02 ; id 250 Mummy
    db $02, $00, $01 ; id 251 DarkCrab
    db $00, $01, $02 ; id 252 DeadNite
    db $00, $01, $02 ; id 253 Shadow
    db $02, $00, $01 ; id 254 Skulpent
    db $01, $02, $00 ; id 255 Hork
    db $01, $00, $02 ; id 256 Mudron
    db $00, $01, $02 ; id 257 NiteWhip
    db $00, $01, $02 ; id 258 WindMerge
    db $00, $01, $02 ; id 259 Reaper
    db $00, $01, $02 ; id 260 Inverzon
    db $00, $01, $02 ; id 261 FoxFire
    db $01, $00, $02 ; id 262 CaptDead
    db $02, $00, $01 ; id 263 DeadNoble
    db $00, $01, $02 ; id 264 WhiteKing
    db $00, $01, $02 ; id 265 BoneSlave
    db $00, $01, $02 ; id 266 Skeletor
    db $00, $01, $02 ; id 267 Servant
    db $00, $01, $02 ; id 268 Lazamanus
    db $00, $01, $02 ; id 269 Copycat
    db $00, $01, $02 ; id 270 MadSpirit
    db $00, $01, $02 ; id 271 PomPomBom
    db $00, $02, $01 ; id 272 Niterich
    db $00, $01, $02 ; id 273 ?
    db $00, $01, $02 ; id 274 ?
    db $00, $01, $02 ; id 275 ?
    db $00, $01, $02 ; id 276 ?
    db $00, $01, $02 ; id 277 ?
    db $00, $01, $02 ; id 278 ?
    db $00, $01, $02 ; id 279 ?
    db $00, $01, $02 ; id 280 ?
    db $00, $01, $02 ; id 281 JewelBag
    db $01, $00, $02 ; id 282 EvilWand
    db $00, $01, $02 ; id 283 MadCandle
    db $00, $01, $02 ; id 284 CoilBird
    db $00, $01, $02 ; id 285 Facer
    db $02, $01, $00 ; id 286 SpikyBoy
    db $00, $02, $01 ; id 287 MadMirror
    db $00, $01, $02 ; id 288 RogueNite
    db $00, $01, $02 ; id 289 Puppetor
    db $00, $01, $02 ; id 290 Goopi
    db $00, $01, $02 ; id 291 Voodoll
    db $00, $02, $01 ; id 292 MetalDrak
    db $00, $01, $02 ; id 293 Balzak
    db $00, $01, $02 ; id 294 SabreMan
    db $00, $01, $02 ; id 295 CurseLamp
    db $00, $01, $02 ; id 296 Brushead
    db $00, $01, $02 ; id 297 Roboster
    db $00, $01, $02 ; id 298 Roboster2
    db $00, $02, $01 ; id 299 EvilPot
    db $00, $01, $02 ; id 300 Gismo
    db $00, $01, $02 ; id 301 LavaMan
    db $00, $01, $02 ; id 302 IceMan
    db $00, $02, $01 ; id 303 Mimic
    db $00, $01, $02 ; id 304 Exaucers
    db $00, $02, $01 ; id 305 MudDoll
    db $00, $01, $02 ; id 306 Golem
    db $02, $01, $00 ; id 307 StoneMan
    db $01, $02, $00 ; id 308 BombCrag
    db $02, $01, $00 ; id 309 GoldGolem
    db $00, $02, $01 ; id 310 DarkMate
    db $01, $00, $02 ; id 311 ProtoMech
    db $00, $01, $02 ; id 312 CloudKing
    db $00, $01, $02 ; id 313 ?
    db $00, $01, $02 ; id 314 ?
    db $00, $01, $02 ; id 315 ?
    db $00, $02, $01 ; id 316 Petiteel
    db $00, $01, $02 ; id 317 Moray
    db $00, $01, $02 ; id 318 WalrusMan
    db $00, $01, $02 ; id 319 RayGigas
    db $00, $01, $02 ; id 320 Anemon
    db $00, $02, $01 ; id 321 Aquarella
    db $02, $00, $01 ; id 322 Merman
    db $00, $01, $02 ; id 323 Octokid
    db $02, $00, $01 ; id 324 PutreFish
    db $00, $01, $02 ; id 325 Octoreach
    db $02, $01, $00 ; id 326 Angleron
    db $00, $01, $02 ; id 327 FishRider
    db $00, $02, $01 ; id 328 RushFish
    db $00, $01, $02 ; id 329 Gamanian
    db $00, $01, $02 ; id 330 Clawster
    db $00, $01, $02 ; id 331 CancerMan
    db $00, $02, $01 ; id 332 RogueWave
    db $00, $02, $01 ; id 333 Scallopa
    db $00, $01, $02 ; id 334 SeaHorse
    db $00, $02, $01 ; id 335 HoodSquid
    db $00, $01, $02 ; id 336 MerTiger
    db $00, $02, $01 ; id 337 AxeShark
    db $00, $01, $02 ; id 338 Octogon
    db $00, $02, $01 ; id 339 KingSquid
    db $00, $01, $02 ; id 340 Digong
    db $00, $01, $02 ; id 341 WhaleMage
    db $00, $01, $02 ; id 342 Aquadon
    db $00, $01, $02 ; id 343 Octoraid
    db $02, $01, $00 ; id 344 Grakos
    db $00, $01, $02 ; id 345 Poseidon
    db $00, $01, $02 ; id 346 Pumpoise
    db $00, $01, $02 ; id 347 Starfish
    db $00, $01, $02 ; id 348 ?
    db $00, $01, $02 ; id 349 ?
    db $00, $01, $02 ; id 350 ?
    db $00, $01, $02 ; id 351 DracoLord
    db $00, $01, $02 ; id 352 DracoLord
    db $00, $02, $01 ; id 353 LordDraco
    db $00, $01, $02 ; id 354 Hargon
    db $02, $00, $01 ; id 355 Sidoh
    db $00, $01, $02 ; id 356 Genosidoh
    db $00, $02, $01 ; id 357 Baramos
    db $02, $00, $01 ; id 358 Zoma
    db $00, $02, $01 ; id 359 AsuraZoma
    db $02, $00, $01 ; id 360 Pizzaro
    db $02, $00, $01 ; id 361 PsychoPiz
    db $00, $01, $02 ; id 362 Esterk
    db $00, $01, $02 ; id 363 Mirudraas
    db $00, $02, $01 ; id 364 Mirudraas
    db $00, $01, $02 ; id 365 Mudou
    db $00, $02, $01 ; id 366 DeathMore
    db $00, $01, $02 ; id 367 DeathMore
    db $02, $00, $01 ; id 368 DeathMore
    db $02, $00, $01 ; id 369 Darkdrium
    db $00, $01, $02 ; id 370 Orgodemir
    db $02, $00, $01 ; id 371 Orgodemir
    db $00, $01, $02 ; id 372 Darck
    db $00, $01, $02 ; id 373 Tatsu
    db $00, $01, $02 ; id 374 Diago
    db $00, $01, $02 ; id 375 Samsi
    db $00, $01, $02 ; id 376 Bazoo
    db $00, $01, $02 ; id 377 ?
    db $00, $01, $02 ; id 378 ?
    db $00, $01, $02 ; id 379 ?
    db $00, $01, $02 ; id 380 Lamia
    db $00, $01, $02 ; id 381 Dimensaur
    db $00, $01, $02 ; id 382 Kagebou
    db $00, $01, $02 ; id 383 ?

; LoadScreenNumberListPointer (bank $1C) reads the word at $5643 + 2 * wScreenTableIndex;
; ShopMenu_Buy_DrawPrices.skip adds 3 * entry (after ShopMenu_Buy_ApplyGoldPass) and shows the
; 24-bit number there in digits (wDigits, Number24ToPackedBCD); the lists run contiguously to
; ReturnStub_3; read as prices, which is not confirmed (E-0208, C1)
; record: list of 24-bit numbers for this wScreenTableIndex
ScreenNumberListTable::
    dw ScreenNumberList000 ; id 0
    dw ScreenNumberList001 ; id 1
    dw ScreenNumberList002 ; id 2
    dw ScreenNumberList003 ; id 3
    dw ScreenNumberList004 ; id 4
    dw ScreenNumberList005 ; id 5
    dw ScreenNumberList006 ; id 6
    dw ScreenNumberList007 ; id 7
    dw ScreenNumberList008 ; id 8
    dw ScreenNumberList009 ; id 9
    dw ScreenNumberList00A ; id 10
    dw ScreenNumberList00B ; id 11
    dw ScreenNumberList00C ; id 12
    dw ScreenNumberList00D ; id 13
    dw ScreenNumberList00E ; id 14
    dw ScreenNumberList00F ; id 15
    dw ScreenNumberList010 ; id 16
    dw ScreenNumberList011 ; id 17
    dw ScreenNumberList012 ; id 18
    dw ScreenNumberList013 ; id 19
    dw ScreenNumberList005 ; id 20
    dw ScreenNumberList005 ; id 21
    dw ScreenNumberList005 ; id 22
    dw ScreenNumberList017 ; id 23

; list for entry $00 of ScreenNumberListTable; it runs to the next list (E-0199)
; record: 24-bit number
ScreenNumberList000::
    d24 0 ; id 0
    d24 10 ; id 1
    d24 50 ; id 2
    d24 0 ; id 3
    d24 0 ; id 4
    d24 0 ; id 5
    d24 4 ; id 6
    d24 0 ; id 7
    d24 0 ; id 8
    d24 0 ; id 9
    d24 0 ; id 10
    d24 0 ; id 11
    d24 0 ; id 12
    d24 0 ; id 13
    d24 0 ; id 14
    d24 0 ; id 15
    d24 0 ; id 16
    d24 0 ; id 17
    d24 0 ; id 18
    d24 0 ; id 19
    d24 0 ; id 20
    d24 0 ; id 21
    d24 0 ; id 22
    d24 0 ; id 23
    d24 0 ; id 24
    d24 10 ; id 25
    d24 40 ; id 26
    d24 0 ; id 27
    d24 0 ; id 28
    d24 0 ; id 29
    d24 0 ; id 30
    d24 0 ; id 31
    d24 0 ; id 32
    d24 0 ; id 33
    d24 0 ; id 34
    d24 0 ; id 35
    d24 0 ; id 36
    d24 0 ; id 37
    d24 0 ; id 38
    d24 0 ; id 39
    d24 0 ; id 40
    d24 25 ; id 41
    d24 0 ; id 42
    d24 50 ; id 43
    d24 0 ; id 44
    d24 0 ; id 45
    d24 0 ; id 46
    d24 0 ; id 47
    d24 0 ; id 48
    d24 0 ; id 49
    d24 0 ; id 50
    d24 0 ; id 51
    d24 0 ; id 52
    d24 0 ; id 53
    d24 0 ; id 54
    d24 0 ; id 55
    d24 0 ; id 56
    d24 0 ; id 57
    d24 0 ; id 58
    d24 0 ; id 59
    d24 0 ; id 60
    d24 0 ; id 61
    d24 0 ; id 62
    d24 0 ; id 63
    d24 0 ; id 64
    d24 0 ; id 65
    d24 0 ; id 66
    d24 0 ; id 67
    d24 0 ; id 68
    d24 0 ; id 69
    d24 0 ; id 70
    d24 0 ; id 71
    d24 0 ; id 72
    d24 0 ; id 73
    d24 0 ; id 74
    d24 0 ; id 75
    d24 0 ; id 76
    d24 0 ; id 77
    d24 0 ; id 78
    d24 0 ; id 79
    d24 0 ; id 80
    d24 0 ; id 81
    d24 0 ; id 82
    d24 20 ; id 83
    d24 0 ; id 84
    d24 0 ; id 85
    d24 0 ; id 86
    d24 0 ; id 87

; list for entry $01 of ScreenNumberListTable; it runs to the next list (E-0199)
ScreenNumberList001::
    d24 0 ; id 0
    d24 0 ; id 1
    d24 0 ; id 2
    d24 500 ; id 3
    d24 200 ; id 4
    d24 0 ; id 5
    d24 0 ; id 6
    d24 20 ; id 7
    d24 20 ; id 8
    d24 20 ; id 9
    d24 20 ; id 10
    d24 0 ; id 11
    d24 0 ; id 12
    d24 0 ; id 13
    d24 0 ; id 14
    d24 0 ; id 15
    d24 0 ; id 16
    d24 0 ; id 17
    d24 0 ; id 18
    d24 0 ; id 19
    d24 0 ; id 20
    d24 0 ; id 21
    d24 0 ; id 22
    d24 0 ; id 23
    d24 0 ; id 24
    d24 0 ; id 25
    d24 0 ; id 26
    d24 200 ; id 27
    d24 0 ; id 28
    d24 0 ; id 29
    d24 0 ; id 30
    d24 0 ; id 31
    d24 0 ; id 32
    d24 0 ; id 33
    d24 0 ; id 34
    d24 0 ; id 35
    d24 0 ; id 36
    d24 0 ; id 37
    d24 0 ; id 38
    d24 0 ; id 39
    d24 0 ; id 40
    d24 0 ; id 41
    d24 0 ; id 42
    d24 50 ; id 43
    d24 0 ; id 44
    d24 0 ; id 45
    d24 50 ; id 46
    d24 0 ; id 47

; list for entry $02 of ScreenNumberListTable; it runs to the next list (E-0199)
ScreenNumberList002::
    d24 0 ; id 0
    d24 0 ; id 1
    d24 0 ; id 2
    d24 0 ; id 3
    d24 0 ; id 4
    d24 2000 ; id 5
    d24 0 ; id 6
    d24 0 ; id 7
    d24 0 ; id 8
    d24 0 ; id 9
    d24 0 ; id 10
    d24 1000 ; id 11
    d24 1000 ; id 12
    d24 0 ; id 13
    d24 0 ; id 14
    d24 0 ; id 15
    d24 0 ; id 16
    d24 0 ; id 17
    d24 0 ; id 18
    d24 0 ; id 19
    d24 0 ; id 20
    d24 0 ; id 21
    d24 0 ; id 22
    d24 0 ; id 23
    d24 0 ; id 24
    d24 0 ; id 25
    d24 0 ; id 26
    d24 0 ; id 27
    d24 1000 ; id 28
    d24 0 ; id 29
    d24 0 ; id 30
    d24 800 ; id 31
    d24 0 ; id 32
    d24 1000 ; id 33
    d24 700 ; id 34
    d24 800 ; id 35
    d24 1500 ; id 36
    d24 3000 ; id 37
    d24 0 ; id 38
    d24 0 ; id 39
    d24 0 ; id 40
    d24 0 ; id 41
    d24 0 ; id 42
    d24 0 ; id 43
    d24 0 ; id 44
    d24 20000 ; id 45
    d24 0 ; id 46
    d24 0 ; id 47

; list for entry $03 of ScreenNumberListTable; it runs to the next list (E-0199)
ScreenNumberList003::
    d24 0 ; id 0
    d24 10 ; id 1
    d24 0 ; id 2
    d24 0 ; id 3
    d24 0 ; id 4
    d24 0 ; id 5
    d24 4 ; id 6
    d24 0 ; id 7
    d24 0 ; id 8
    d24 20 ; id 9
    d24 0 ; id 10
    d24 0 ; id 11
    d24 0 ; id 12
    d24 0 ; id 13
    d24 0 ; id 14
    d24 0 ; id 15
    d24 0 ; id 16
    d24 0 ; id 17
    d24 0 ; id 18
    d24 0 ; id 19
    d24 0 ; id 20
    d24 0 ; id 21
    d24 0 ; id 22
    d24 0 ; id 23
    d24 0 ; id 24
    d24 10 ; id 25
    d24 0 ; id 26
    d24 0 ; id 27
    d24 0 ; id 28
    d24 0 ; id 29
    d24 0 ; id 30
    d24 0 ; id 31
    d24 0 ; id 32
    d24 0 ; id 33
    d24 0 ; id 34
    d24 0 ; id 35
    d24 0 ; id 36
    d24 0 ; id 37
    d24 0 ; id 38
    d24 0 ; id 39
    d24 0 ; id 40
    d24 30 ; id 41
    d24 0 ; id 42
    d24 0 ; id 43
    d24 0 ; id 44
    d24 0 ; id 45
    d24 0 ; id 46
    d24 0 ; id 47

; list for entry $04 of ScreenNumberListTable; it runs to the next list (E-0199)
; record: 24-bit number
ScreenNumberList004::
    d24 0 ; id 0
    d24 10 ; id 1
    d24 50 ; id 2
    d24 0 ; id 3
    d24 0 ; id 4
    d24 0 ; id 5
    d24 4 ; id 6
    d24 0 ; id 7
    d24 0 ; id 8
    d24 20 ; id 9
    d24 0 ; id 10
    d24 0 ; id 11
    d24 0 ; id 12
    d24 0 ; id 13
    d24 0 ; id 14
    d24 0 ; id 15
    d24 0 ; id 16
    d24 0 ; id 17
    d24 0 ; id 18
    d24 0 ; id 19
    d24 0 ; id 20
    d24 0 ; id 21
    d24 0 ; id 22
    d24 0 ; id 23
    d24 0 ; id 24
    d24 0 ; id 25
    d24 40 ; id 26
    d24 0 ; id 27
    d24 0 ; id 28
    d24 0 ; id 29
    d24 0 ; id 30
    d24 0 ; id 31
    d24 0 ; id 32
    d24 0 ; id 33
    d24 0 ; id 34
    d24 0 ; id 35
    d24 0 ; id 36
    d24 0 ; id 37
    d24 0 ; id 38
    d24 0 ; id 39
    d24 0 ; id 40
    d24 30 ; id 41
    d24 0 ; id 42
    d24 50 ; id 43
    d24 0 ; id 44
    d24 0 ; id 45
    d24 0 ; id 46
    d24 0 ; id 47

; list for entry $05 of ScreenNumberListTable; it runs to the next list (E-0199)
ScreenNumberList005::
    d24 0 ; id 0
    d24 0 ; id 1
    d24 0 ; id 2
    d24 0 ; id 3
    d24 0 ; id 4
    d24 0 ; id 5
    d24 0 ; id 6
    d24 0 ; id 7
    d24 0 ; id 8
    d24 0 ; id 9
    d24 0 ; id 10
    d24 0 ; id 11
    d24 0 ; id 12
    d24 0 ; id 13
    d24 0 ; id 14
    d24 0 ; id 15
    d24 0 ; id 16
    d24 0 ; id 17
    d24 0 ; id 18
    d24 0 ; id 19
    d24 0 ; id 20
    d24 0 ; id 21
    d24 0 ; id 22
    d24 0 ; id 23
    d24 0 ; id 24
    d24 0 ; id 25
    d24 0 ; id 26
    d24 0 ; id 27
    d24 0 ; id 28
    d24 0 ; id 29
    d24 0 ; id 30
    d24 0 ; id 31
    d24 0 ; id 32
    d24 0 ; id 33
    d24 0 ; id 34
    d24 0 ; id 35
    d24 0 ; id 36
    d24 0 ; id 37
    d24 0 ; id 38
    d24 0 ; id 39
    d24 0 ; id 40
    d24 0 ; id 41
    d24 0 ; id 42
    d24 0 ; id 43
    d24 0 ; id 44
    d24 0 ; id 45
    d24 0 ; id 46
    d24 0 ; id 47

; list for entry $06 of ScreenNumberListTable; it runs to the next list (E-0199)
ScreenNumberList006::
    d24 0 ; id 0
    d24 0 ; id 1
    d24 50 ; id 2
    d24 0 ; id 3
    d24 0 ; id 4
    d24 0 ; id 5
    d24 4 ; id 6
    d24 0 ; id 7
    d24 0 ; id 8
    d24 20 ; id 9
    d24 0 ; id 10
    d24 0 ; id 11
    d24 0 ; id 12
    d24 0 ; id 13
    d24 0 ; id 14
    d24 0 ; id 15
    d24 0 ; id 16
    d24 0 ; id 17
    d24 0 ; id 18
    d24 0 ; id 19
    d24 0 ; id 20
    d24 0 ; id 21
    d24 0 ; id 22
    d24 0 ; id 23
    d24 0 ; id 24
    d24 0 ; id 25
    d24 40 ; id 26
    d24 200 ; id 27
    d24 0 ; id 28
    d24 0 ; id 29
    d24 0 ; id 30
    d24 0 ; id 31
    d24 0 ; id 32
    d24 0 ; id 33
    d24 0 ; id 34
    d24 0 ; id 35
    d24 0 ; id 36
    d24 0 ; id 37
    d24 0 ; id 38
    d24 0 ; id 39
    d24 50 ; id 40
    d24 0 ; id 41
    d24 50 ; id 42
    d24 50 ; id 43
    d24 0 ; id 44
    d24 0 ; id 45
    d24 0 ; id 46
    d24 0 ; id 47

; list for entry $07 of ScreenNumberListTable; it runs to the next list (E-0199)
ScreenNumberList007::
    d24 0 ; id 0
    d24 0 ; id 1
    d24 65 ; id 2
    d24 0 ; id 3
    d24 0 ; id 4
    d24 0 ; id 5
    d24 5 ; id 6
    d24 20 ; id 7
    d24 20 ; id 8
    d24 0 ; id 9
    d24 0 ; id 10
    d24 0 ; id 11
    d24 0 ; id 12
    d24 0 ; id 13
    d24 0 ; id 14
    d24 0 ; id 15
    d24 0 ; id 16
    d24 0 ; id 17
    d24 0 ; id 18
    d24 0 ; id 19
    d24 0 ; id 20
    d24 0 ; id 21
    d24 0 ; id 22
    d24 0 ; id 23
    d24 0 ; id 24
    d24 0 ; id 25
    d24 50 ; id 26
    d24 250 ; id 27
    d24 0 ; id 28
    d24 0 ; id 29
    d24 0 ; id 30
    d24 0 ; id 31
    d24 0 ; id 32
    d24 0 ; id 33
    d24 0 ; id 34
    d24 0 ; id 35
    d24 0 ; id 36
    d24 0 ; id 37
    d24 0 ; id 38
    d24 0 ; id 39
    d24 50 ; id 40
    d24 0 ; id 41
    d24 100 ; id 42
    d24 0 ; id 43
    d24 0 ; id 44
    d24 0 ; id 45
    d24 50 ; id 46
    d24 0 ; id 47

; list for entry $08 of ScreenNumberListTable; it runs to the next list (E-0199)
; record: 24-bit number
ScreenNumberList008::
    d24 0 ; id 0
    d24 0 ; id 1
    d24 65 ; id 2
    d24 750 ; id 3
    d24 300 ; id 4
    d24 0 ; id 5
    d24 0 ; id 6
    d24 0 ; id 7
    d24 0 ; id 8
    d24 0 ; id 9
    d24 30 ; id 10
    d24 0 ; id 11
    d24 0 ; id 12
    d24 0 ; id 13
    d24 0 ; id 14
    d24 0 ; id 15
    d24 0 ; id 16
    d24 0 ; id 17
    d24 0 ; id 18
    d24 0 ; id 19
    d24 0 ; id 20
    d24 0 ; id 21
    d24 0 ; id 22
    d24 0 ; id 23
    d24 0 ; id 24
    d24 0 ; id 25
    d24 50 ; id 26
    d24 0 ; id 27
    d24 0 ; id 28
    d24 0 ; id 29
    d24 0 ; id 30
    d24 0 ; id 31
    d24 0 ; id 32
    d24 0 ; id 33
    d24 0 ; id 34
    d24 0 ; id 35
    d24 0 ; id 36
    d24 0 ; id 37
    d24 0 ; id 38
    d24 0 ; id 39
    d24 50 ; id 40
    d24 0 ; id 41
    d24 100 ; id 42
    d24 0 ; id 43
    d24 0 ; id 44
    d24 0 ; id 45
    d24 0 ; id 46
    d24 0 ; id 47

; list for entry $09 of ScreenNumberListTable; it runs to the next list (E-0199)
ScreenNumberList009::
    d24 0 ; id 0
    d24 0 ; id 1
    d24 0 ; id 2
    d24 0 ; id 3
    d24 0 ; id 4
    d24 0 ; id 5
    d24 0 ; id 6
    d24 0 ; id 7
    d24 20 ; id 8
    d24 0 ; id 9
    d24 0 ; id 10
    d24 0 ; id 11
    d24 1500 ; id 12
    d24 0 ; id 13
    d24 0 ; id 14
    d24 0 ; id 15
    d24 0 ; id 16
    d24 0 ; id 17
    d24 0 ; id 18
    d24 0 ; id 19
    d24 0 ; id 20
    d24 0 ; id 21
    d24 0 ; id 22
    d24 0 ; id 23
    d24 0 ; id 24
    d24 0 ; id 25
    d24 0 ; id 26
    d24 200 ; id 27
    d24 0 ; id 28
    d24 0 ; id 29
    d24 0 ; id 30
    d24 800 ; id 31
    d24 0 ; id 32
    d24 1200 ; id 33
    d24 0 ; id 34
    d24 0 ; id 35
    d24 0 ; id 36
    d24 0 ; id 37
    d24 0 ; id 38
    d24 0 ; id 39
    d24 0 ; id 40
    d24 0 ; id 41
    d24 0 ; id 42
    d24 100 ; id 43
    d24 0 ; id 44
    d24 20000 ; id 45
    d24 100 ; id 46
    d24 0 ; id 47

; list for entry $0A of ScreenNumberListTable; it runs to the next list (E-0199)
ScreenNumberList00A::
    d24 0 ; id 0
    d24 0 ; id 1
    d24 0 ; id 2
    d24 0 ; id 3
    d24 0 ; id 4
    d24 0 ; id 5
    d24 0 ; id 6
    d24 0 ; id 7
    d24 0 ; id 8
    d24 0 ; id 9
    d24 0 ; id 10
    d24 0 ; id 11
    d24 0 ; id 12
    d24 0 ; id 13
    d24 0 ; id 14
    d24 0 ; id 15
    d24 0 ; id 16
    d24 0 ; id 17
    d24 0 ; id 18
    d24 10000 ; id 19
    d24 10000 ; id 20
    d24 10000 ; id 21
    d24 10000 ; id 22
    d24 10000 ; id 23
    d24 10000 ; id 24
    d24 0 ; id 25
    d24 0 ; id 26
    d24 0 ; id 27
    d24 0 ; id 28
    d24 0 ; id 29
    d24 0 ; id 30
    d24 0 ; id 31

; list for entry $0B of ScreenNumberListTable; it runs to the next list (E-0199)
ScreenNumberList00B::
    d24 0 ; id 0
    d24 0 ; id 1
    d24 75 ; id 2
    d24 0 ; id 3
    d24 0 ; id 4
    d24 0 ; id 5
    d24 0 ; id 6
    d24 45 ; id 7
    d24 0 ; id 8
    d24 0 ; id 9
    d24 30 ; id 10
    d24 0 ; id 11
    d24 0 ; id 12
    d24 0 ; id 13
    d24 0 ; id 14
    d24 0 ; id 15
    d24 0 ; id 16
    d24 0 ; id 17
    d24 0 ; id 18
    d24 0 ; id 19
    d24 0 ; id 20
    d24 0 ; id 21
    d24 0 ; id 22
    d24 0 ; id 23
    d24 0 ; id 24
    d24 0 ; id 25
    d24 0 ; id 26
    d24 300 ; id 27
    d24 0 ; id 28
    d24 0 ; id 29
    d24 0 ; id 30
    d24 0 ; id 31
    d24 0 ; id 32
    d24 0 ; id 33
    d24 0 ; id 34
    d24 0 ; id 35
    d24 0 ; id 36
    d24 0 ; id 37
    d24 0 ; id 38
    d24 0 ; id 39
    d24 0 ; id 40
    d24 30 ; id 41
    d24 150 ; id 42
    d24 0 ; id 43
    d24 0 ; id 44
    d24 0 ; id 45
    d24 50 ; id 46
    d24 0 ; id 47

; list for entry $0C of ScreenNumberListTable; it runs to the next list (E-0199)
; record: 24-bit number
ScreenNumberList00C::
    d24 0 ; id 0
    d24 0 ; id 1
    d24 50 ; id 2
    d24 0 ; id 3
    d24 0 ; id 4
    d24 0 ; id 5
    d24 0 ; id 6
    d24 45 ; id 7
    d24 0 ; id 8
    d24 0 ; id 9
    d24 30 ; id 10
    d24 0 ; id 11
    d24 0 ; id 12
    d24 0 ; id 13
    d24 0 ; id 14
    d24 0 ; id 15
    d24 0 ; id 16
    d24 0 ; id 17
    d24 0 ; id 18
    d24 0 ; id 19
    d24 0 ; id 20
    d24 0 ; id 21
    d24 0 ; id 22
    d24 0 ; id 23
    d24 0 ; id 24
    d24 0 ; id 25
    d24 0 ; id 26
    d24 200 ; id 27
    d24 0 ; id 28
    d24 0 ; id 29
    d24 0 ; id 30
    d24 0 ; id 31
    d24 0 ; id 32
    d24 0 ; id 33
    d24 0 ; id 34
    d24 0 ; id 35
    d24 0 ; id 36
    d24 0 ; id 37
    d24 0 ; id 38
    d24 0 ; id 39
    d24 100 ; id 40
    d24 0 ; id 41
    d24 100 ; id 42
    d24 100 ; id 43
    d24 0 ; id 44
    d24 0 ; id 45
    d24 50 ; id 46
    d24 0 ; id 47

; list for entry $0D of ScreenNumberListTable; it runs to the next list (E-0199)
ScreenNumberList00D::
    d24 0 ; id 0
    d24 0 ; id 1
    d24 60 ; id 2
    d24 600 ; id 3
    d24 250 ; id 4
    d24 0 ; id 5
    d24 0 ; id 6
    d24 0 ; id 7
    d24 0 ; id 8
    d24 0 ; id 9
    d24 0 ; id 10
    d24 0 ; id 11
    d24 0 ; id 12
    d24 0 ; id 13
    d24 0 ; id 14
    d24 0 ; id 15
    d24 0 ; id 16
    d24 0 ; id 17
    d24 0 ; id 18
    d24 0 ; id 19
    d24 0 ; id 20
    d24 0 ; id 21
    d24 0 ; id 22
    d24 0 ; id 23
    d24 0 ; id 24
    d24 0 ; id 25
    d24 0 ; id 26
    d24 200 ; id 27
    d24 1500 ; id 28
    d24 0 ; id 29
    d24 0 ; id 30
    d24 0 ; id 31
    d24 120 ; id 32
    d24 0 ; id 33
    d24 0 ; id 34
    d24 0 ; id 35
    d24 0 ; id 36
    d24 0 ; id 37
    d24 0 ; id 38
    d24 0 ; id 39
    d24 100 ; id 40
    d24 0 ; id 41
    d24 100 ; id 42
    d24 0 ; id 43
    d24 0 ; id 44
    d24 0 ; id 45
    d24 0 ; id 46
    d24 0 ; id 47

; list for entry $0E of ScreenNumberListTable; it runs to the next list (E-0199)
ScreenNumberList00E::
    d24 0 ; id 0
    d24 0 ; id 1
    d24 75 ; id 2
    d24 750 ; id 3
    d24 300 ; id 4
    d24 0 ; id 5
    d24 0 ; id 6
    d24 0 ; id 7
    d24 0 ; id 8
    d24 0 ; id 9
    d24 0 ; id 10
    d24 0 ; id 11
    d24 1000 ; id 12
    d24 0 ; id 13
    d24 0 ; id 14
    d24 0 ; id 15
    d24 0 ; id 16
    d24 0 ; id 17
    d24 0 ; id 18
    d24 0 ; id 19
    d24 0 ; id 20
    d24 0 ; id 21
    d24 0 ; id 22
    d24 0 ; id 23
    d24 0 ; id 24
    d24 0 ; id 25
    d24 0 ; id 26
    d24 0 ; id 27
    d24 1500 ; id 28
    d24 0 ; id 29
    d24 0 ; id 30
    d24 0 ; id 31
    d24 300 ; id 32
    d24 0 ; id 33
    d24 0 ; id 34
    d24 0 ; id 35
    d24 0 ; id 36
    d24 0 ; id 37
    d24 0 ; id 38
    d24 0 ; id 39
    d24 150 ; id 40
    d24 0 ; id 41
    d24 150 ; id 42
    d24 100 ; id 43
    d24 0 ; id 44
    d24 0 ; id 45
    d24 50 ; id 46
    d24 0 ; id 47

; list for entry $0F of ScreenNumberListTable; it runs to the next list (E-0199)
ScreenNumberList00F::
    d24 0 ; id 0
    d24 15 ; id 1
    d24 75 ; id 2
    d24 750 ; id 3
    d24 300 ; id 4
    d24 0 ; id 5
    d24 15 ; id 6
    d24 45 ; id 7
    d24 75 ; id 8
    d24 0 ; id 9
    d24 30 ; id 10
    d24 0 ; id 11
    d24 0 ; id 12
    d24 0 ; id 13
    d24 0 ; id 14
    d24 0 ; id 15
    d24 0 ; id 16
    d24 0 ; id 17
    d24 0 ; id 18
    d24 0 ; id 19
    d24 0 ; id 20
    d24 0 ; id 21
    d24 0 ; id 22
    d24 0 ; id 23
    d24 0 ; id 24
    d24 0 ; id 25
    d24 0 ; id 26
    d24 300 ; id 27
    d24 0 ; id 28
    d24 0 ; id 29
    d24 0 ; id 30
    d24 0 ; id 31
    d24 100 ; id 32
    d24 0 ; id 33
    d24 0 ; id 34
    d24 0 ; id 35
    d24 0 ; id 36
    d24 0 ; id 37
    d24 0 ; id 38
    d24 0 ; id 39
    d24 150 ; id 40
    d24 0 ; id 41
    d24 150 ; id 42
    d24 0 ; id 43
    d24 0 ; id 44
    d24 0 ; id 45
    d24 0 ; id 46
    d24 0 ; id 47

; list for entry $10 of ScreenNumberListTable; it runs to the next list (E-0199)
; record: 24-bit number
ScreenNumberList010::
    d24 0 ; id 0
    d24 15 ; id 1
    d24 75 ; id 2
    d24 750 ; id 3
    d24 0 ; id 4
    d24 3000 ; id 5
    d24 15 ; id 6
    d24 45 ; id 7
    d24 75 ; id 8
    d24 0 ; id 9
    d24 0 ; id 10
    d24 0 ; id 11
    d24 0 ; id 12
    d24 0 ; id 13
    d24 0 ; id 14
    d24 0 ; id 15
    d24 0 ; id 16
    d24 0 ; id 17
    d24 0 ; id 18
    d24 0 ; id 19
    d24 0 ; id 20
    d24 0 ; id 21
    d24 0 ; id 22
    d24 0 ; id 23
    d24 0 ; id 24
    d24 0 ; id 25
    d24 0 ; id 26
    d24 0 ; id 27
    d24 0 ; id 28
    d24 0 ; id 29
    d24 0 ; id 30
    d24 0 ; id 31
    d24 0 ; id 32
    d24 0 ; id 33
    d24 0 ; id 34
    d24 0 ; id 35
    d24 0 ; id 36
    d24 0 ; id 37
    d24 0 ; id 38
    d24 7500 ; id 39
    d24 0 ; id 40
    d24 0 ; id 41
    d24 0 ; id 42
    d24 0 ; id 43
    d24 0 ; id 44
    d24 0 ; id 45
    d24 0 ; id 46
    d24 0 ; id 47

; list for entry $11 of ScreenNumberListTable; it runs to the next list (E-0199)
ScreenNumberList011::
    d24 0 ; id 0
    d24 0 ; id 1
    d24 75 ; id 2
    d24 0 ; id 3
    d24 300 ; id 4
    d24 0 ; id 5
    d24 0 ; id 6
    d24 0 ; id 7
    d24 0 ; id 8
    d24 0 ; id 9
    d24 0 ; id 10
    d24 1500 ; id 11
    d24 0 ; id 12
    d24 0 ; id 13
    d24 0 ; id 14
    d24 0 ; id 15
    d24 0 ; id 16
    d24 0 ; id 17
    d24 0 ; id 18
    d24 0 ; id 19
    d24 0 ; id 20
    d24 0 ; id 21
    d24 0 ; id 22
    d24 0 ; id 23
    d24 0 ; id 24
    d24 0 ; id 25
    d24 0 ; id 26
    d24 0 ; id 27
    d24 1500 ; id 28
    d24 0 ; id 29
    d24 0 ; id 30
    d24 0 ; id 31
    d24 300 ; id 32
    d24 1500 ; id 33
    d24 0 ; id 34
    d24 0 ; id 35
    d24 0 ; id 36
    d24 0 ; id 37
    d24 0 ; id 38
    d24 0 ; id 39
    d24 0 ; id 40
    d24 0 ; id 41
    d24 0 ; id 42
    d24 0 ; id 43
    d24 0 ; id 44
    d24 0 ; id 45
    d24 0 ; id 46
    d24 0 ; id 47

; list for entry $12 of ScreenNumberListTable; it runs to the next list (E-0199)
ScreenNumberList012::
    d24 0 ; id 0
    d24 0 ; id 1
    d24 75 ; id 2
    d24 750 ; id 3
    d24 0 ; id 4
    d24 2000 ; id 5
    d24 0 ; id 6
    d24 0 ; id 7
    d24 0 ; id 8
    d24 0 ; id 9
    d24 0 ; id 10
    d24 0 ; id 11
    d24 0 ; id 12
    d24 0 ; id 13
    d24 0 ; id 14
    d24 0 ; id 15
    d24 0 ; id 16
    d24 0 ; id 17
    d24 0 ; id 18
    d24 0 ; id 19
    d24 0 ; id 20
    d24 0 ; id 21
    d24 0 ; id 22
    d24 0 ; id 23
    d24 0 ; id 24
    d24 0 ; id 25
    d24 0 ; id 26
    d24 0 ; id 27
    d24 1500 ; id 28
    d24 0 ; id 29
    d24 0 ; id 30
    d24 0 ; id 31
    d24 300 ; id 32
    d24 0 ; id 33
    d24 0 ; id 34
    d24 0 ; id 35
    d24 1500 ; id 36
    d24 0 ; id 37
    d24 0 ; id 38
    d24 0 ; id 39
    d24 150 ; id 40
    d24 0 ; id 41
    d24 150 ; id 42
    d24 0 ; id 43
    d24 0 ; id 44
    d24 0 ; id 45
    d24 0 ; id 46
    d24 0 ; id 47

; list for entry $13 of ScreenNumberListTable; it runs to the next list (E-0199)
ScreenNumberList013::
    d24 0 ; id 0
    d24 15 ; id 1
    d24 75 ; id 2
    d24 0 ; id 3
    d24 300 ; id 4
    d24 0 ; id 5
    d24 15 ; id 6
    d24 0 ; id 7
    d24 0 ; id 8
    d24 0 ; id 9
    d24 0 ; id 10
    d24 0 ; id 11
    d24 0 ; id 12
    d24 0 ; id 13
    d24 0 ; id 14
    d24 0 ; id 15
    d24 0 ; id 16
    d24 0 ; id 17
    d24 0 ; id 18
    d24 0 ; id 19
    d24 0 ; id 20
    d24 0 ; id 21
    d24 0 ; id 22
    d24 0 ; id 23
    d24 0 ; id 24
    d24 0 ; id 25
    d24 0 ; id 26
    d24 300 ; id 27
    d24 0 ; id 28
    d24 0 ; id 29
    d24 0 ; id 30
    d24 0 ; id 31
    d24 300 ; id 32
    d24 0 ; id 33
    d24 0 ; id 34
    d24 0 ; id 35
    d24 0 ; id 36
    d24 0 ; id 37
    d24 0 ; id 38
    d24 0 ; id 39
    d24 150 ; id 40
    d24 0 ; id 41
    d24 150 ; id 42
    d24 0 ; id 43
    d24 0 ; id 44
    d24 0 ; id 45
    d24 0 ; id 46
    d24 0 ; id 47

; list for entry $17 of ScreenNumberListTable; it runs to the next list (E-0199)
; record: 24-bit number
ScreenNumberList017::
    d24 1 ; id 0
    d24 1 ; id 1
    d24 1 ; id 2
    d24 1 ; id 3
    d24 1 ; id 4
    d24 1 ; id 5
    d24 1 ; id 6
    d24 1 ; id 7
    d24 1 ; id 8
    d24 1 ; id 9
    d24 1 ; id 10
    d24 1 ; id 11
    d24 1 ; id 12
    d24 1 ; id 13
    d24 1 ; id 14
    d24 1 ; id 15
    d24 1 ; id 16
    d24 1 ; id 17
    d24 1 ; id 18
    d24 1 ; id 19
    d24 1 ; id 20
    d24 1 ; id 21
    d24 1 ; id 22
    d24 1 ; id 23
    d24 1 ; id 24
    d24 1 ; id 25
    d24 1 ; id 26
    d24 1 ; id 27
    d24 1 ; id 28
    d24 1 ; id 29
    d24 1 ; id 30
    d24 1 ; id 31
    d24 1 ; id 32
    d24 1 ; id 33
    d24 1 ; id 34
    d24 1 ; id 35
    d24 1 ; id 36
    d24 1 ; id 37
    d24 1 ; id 38
    d24 1 ; id 39
    d24 1 ; id 40
    d24 1 ; id 41
    d24 1 ; id 42
    d24 1 ; id 43
    d24 1 ; id 44
    d24 1 ; id 45
    d24 1 ; id 46
    d24 1 ; id 47
    d24 1 ; id 48
    d24 1 ; id 49
    d24 1 ; id 50
    d24 1 ; id 51
    d24 1 ; id 52
    d24 1 ; id 53
    d24 1 ; id 54
    d24 1 ; id 55
    d24 1 ; id 56
    d24 1 ; id 57
    d24 1 ; id 58
    d24 1 ; id 59
    d24 1 ; id 60
    d24 1 ; id 61
    d24 1 ; id 62
    d24 1 ; id 63
    d24 1 ; id 64
    d24 1 ; id 65
    d24 1 ; id 66
    d24 1 ; id 67
    d24 1 ; id 68
    d24 1 ; id 69
    d24 1 ; id 70
    d24 1 ; id 71
    d24 1 ; id 72
    d24 1 ; id 73
    d24 1 ; id 74
    d24 1 ; id 75
    d24 1 ; id 76
    d24 1 ; id 77
    d24 1 ; id 78
    d24 1 ; id 79
    d24 1 ; id 80
    d24 1 ; id 81
    d24 1 ; id 82
    d24 1 ; id 83
    d24 1 ; id 84
    d24 1 ; id 85
    d24 1 ; id 86
    d24 1 ; id 87
    d24 1 ; id 88
    d24 1 ; id 89
    d24 1 ; id 90
    d24 1 ; id 91
    d24 1 ; id 92
    d24 1 ; id 93
    d24 1 ; id 94
    d24 1 ; id 95
    d24 1 ; id 96
    d24 1 ; id 97
    d24 1 ; id 98
    d24 1 ; id 99
    d24 1 ; id 100
    d24 1 ; id 101
    d24 1 ; id 102
    d24 1 ; id 103

; A single ret: registers, flags and memory are unchanged. LinkKeyTrade_KeyCursor far-calls it when
; Select is pressed (bit 2 of wJoypadPressedRepeat) and then falls into its page-change code, which
; takes 4 off wScreenStep; so in the link key trade Select does nothing of its own beyond going back
; those steps, and the key sort of KeyAppraisalMenu_ChooseKey_ListCursor_SortKeys is not used there.
; The 7 bytes right behind it ($CD $55 $63 $CD $46 $63 $C9) encode call ReorderKeyList, call
; CopyWorkBuf1ToKeyList, ret; nothing found jumps to them. (C2, E-0386)
; a bare ret (E-0116) (E-0344: the address in its name dropped or read as the label there; was
; ReturnStub_3)
ReturnStub_3::
    ret
    db $cd, $55, $63, $cd, $46, $63, $c9

; Choosing a key, Select: reorders the key list (ReorderKeyList), copies it back
; (CopyWorkBuf1ToKeyList) and returns to step 0. (C2, E-0357; probed E-0386)
KeyAppraisalMenu_ChooseKey_ListCursor_SortKeys::
    call ReorderKeyList
    call CopyWorkBuf1ToKeyList
    xor a
    ld [wScreenStep], a
    ret

; Copies $C0 bytes from wWorkBuf + 1 to wKeyList. The first $80 bytes are the 32 four-byte key
; entries; the next $40 bytes land on wKeySeeds (the 32 seed words) and come from wKeyGenList, which
; sits right behind the first $80 bytes of wWorkBuf + 1. So one copy puts back both the reordered
; keys and their seeds. On return HL and DE are just past the two ranges and C = 0.
; KeyAppraisalMenu_ChooseKey_ListCursor_SortKeys calls it after ReorderKeyList. (C2, E-0386)
; copies $C0 bytes from wWorkBuf + $1 to wKeyList (E-0122) (E-0340: the address in its name read as
; its RAM name; was CopyWorkBuf1ToKeyList)
CopyWorkBuf1ToKeyList::
    ld hl, wWorkBuf + $1
    ld de, wKeyList
    ld c, $c0

.loop:
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .loop
    ret

; Rebuilds the key list in wWorkBuf + 1 in a new order, alternating on each call by the byte
; wWorkBuf (0 or 1, flipped here). It first fills the $C0 bytes from wWorkBuf + 1 with $FF and sets
; wKeyGenCount to 0. When wWorkBuf is 0 it becomes 1 and the flagged keys (byte 3 bit 7 set and byte
; 0 & $3F below 7) are copied first (CopyFlaggedKeys), then the others (CopyUnflaggedKeys); when it
; is 1 it becomes 0 and the order is the other way round. Each 4-byte key goes to wWorkBuf + 1 on,
; and its seed word from wKeySeeds goes to wKeyGenList in the same order, with wKeyGenCount counting
; the keys; wKeyGenList is the $40 bytes behind the $80 key bytes, so CopyWorkBuf1ToKeyList can put
; keys and seeds back together. wKeyList itself is not changed here. It assumes no $FF entry before
; the last key: after an $FF hole the flagged pass carries on with the unflagged test (see
; CopyUnflaggedKeys_NextEntry), and a key can then be copied twice. (C2, E-0386)
ReorderKeyList::
    ld hl, wWorkBuf + $1
    ld c, $c0

.loop:
    ld a, $ff
    ld [hli], a
    dec c
    jr nz, .loop
    xor a
    ld [wKeyGenCount], a
    ld a, [wWorkBuf]
    and a
    jr nz, .clear_work_buf
    ld a, $01
    ld [wWorkBuf], a
    ld hl, wKeyList
    ld de, wWorkBuf + $1
    call CopyFlaggedKeys
    ld hl, wKeyList
    call CopyUnflaggedKeys
    ret

.clear_work_buf:
    xor a
    ld [wWorkBuf], a
    ld hl, wKeyList
    ld de, wWorkBuf + $1
    call CopyUnflaggedKeys
    ld hl, wKeyList
    call CopyFlaggedKeys
    ret

; Copies the keys that do not have byte 3 bit 7 with a kind below 7 (CopyUnflaggedKeys_CheckEntry
; loop over 32 entries). (C2, E-0357; probed E-0386)
CopyUnflaggedKeys::
    ld b, $00
    ld c, $20

; For each of the 32 key entries ($FF skips): copies it and its seed (wKeySeeds) onward unless byte
; 3 bit 7 is set with a kind (byte 0 & $3F) below 7. (C2, E-0357; probed E-0386)
CopyUnflaggedKeys_CheckEntry::
    ld a, [hl]
    cp $ff
    jr z, CopyUnflaggedKeys_NextEntry
    push hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr z, .restore
    pop hl
    push hl
    ld a, [hl]
    and $3f
    cp $07
    jr nc, .restore
    jr .restore2

.restore:
    pop hl
    push hl
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    inc de
    push de
    ld a, b
    add a
    ld hl, wKeySeeds
    add_a_to_hl
    ld a, [wKeyGenCount]
    add a
    ld de, wKeyGenList
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ld a, [wKeyGenCount]
    inc a
    ld [wKeyGenCount], a
    pop de

.restore2:
    pop hl

; HL += 4 (the next 4-byte key entry), B += 1 (its index into wKeySeeds); loops back to
; CopyUnflaggedKeys_CheckEntry until C, the remaining count of the 32 entries, reaches 0. Also the
; $FF-entry skip of CopyFlaggedKeys, which then continues in this loop of the unflagged copy. (C2,
; E-0371; probed E-0386)
CopyUnflaggedKeys_NextEntry::
    ld a, $04
    add_a_to_hl
    inc b
    dec c
    jr nz, CopyUnflaggedKeys_CheckEntry
    ret

; Copies the keys whose byte 3 has bit 7 set and kind below 7, with their seeds. (C2, E-0357; probed
; E-0386)
CopyFlaggedKeys::
    ld b, $00
    ld c, $20

.loop:
    ld a, [hl]
    cp $ff
    jr z, CopyUnflaggedKeys_NextEntry
    push hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr z, .restore
    pop hl
    push hl
    ld a, [hl]
    and $3f
    cp $07
    jr nc, .restore
    pop hl
    push hl
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    inc de
    push de
    ld a, b
    add a
    ld hl, wKeySeeds
    add_a_to_hl
    ld a, [wKeyGenCount]
    add a
    ld de, wKeyGenList
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ld a, [wKeyGenCount]
    inc a
    ld [wKeyGenCount], a
    pop de

.restore:
    pop hl
    ld a, $04
    add_a_to_hl
    inc b
    dec c
    jr nz, .loop
    ret

; Reorders either the bag grid or the Vault storage by the current order list. When wScreenState is
; 3 (storing) it jumps to VaultMenu_ReorderBagOrStorage_ToggleBagOrder, which rebuilds wItemGrid
; from the bag; in every other state it calls VaultMenu_ReorderBagOrStorage_SortStorage, which
; rebuilds wItemStorage. Both branches first flip the order flag wCounterPtr0Lo (0 becomes 1 and
; uses ItemOrderListA; nonzero becomes 0 and uses ItemOrderListB). Far-called by
; VaultMenu_SaveQuantityAreaToBGMap1 (in state 3 only), by VaultMenu_Store_ItemCursor when Select is
; pressed (which then goes back four steps), and by VaultMenu_Store_AfterStoring_Finish, which flips
; the flag first so that the order ends as it began. (C2, E-0386)
; in state 3 continues at VaultMenu_ReorderBagOrStorage_ToggleBagOrder; otherwise runs
; VaultMenu_ReorderBagOrStorage_SortStorage (E-0126) (E-0344: the address in its name dropped or
; read as the label there; was VaultMenu_ReorderBagOrStorage)
VaultMenu_ReorderBagOrStorage::
    ld a, [wScreenState]
    cp $03
    jr z, VaultMenu_ReorderBagOrStorage_ToggleBagOrder
    call VaultMenu_ReorderBagOrStorage_SortStorage
    ret

; Far-called by VaultMenu_Store_MoveItems after an item has been stored (wScreenState 3): clears 24
; bytes of wWorkBuf and rebuilds wItemGrid in the current order, ItemOrderListA when wCounterPtr0Lo
; is nonzero and ItemOrderListB when it is 0, through VaultMenu_Store_MapItemsToInventory. That
; routine walks the list up to its $FF and appends each id found among the 24 wInventory bytes, so
; wItemGrid holds each item id in the bag once, in list order, padded with 0. (C2, E-0370; probed
; E-0386)
VaultMenu_Store_MoveItems_RebuildBagGrid::
    ld hl, wWorkBuf
    ld b, $18

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop
    ld a, [wCounterPtr0Lo]
    and a
    jr nz, .call_vault_menu_store_map_items_to_inventory
    ld de, ItemOrderListB
    jr .call_vault_menu_store_map_items_to_inventory2

.call_vault_menu_store_map_items_to_inventory:
    ld de, ItemOrderListA

.call_vault_menu_store_map_items_to_inventory2:
    call VaultMenu_Store_MapItemsToInventory
    ret

; The storing branch of VaultMenu_ReorderBagOrStorage (reached by jr when wScreenState is 3): clears
; 24 bytes of wWorkBuf, switches the item order (ItemOrderListA with wCounterPtr0Lo = 1 when it was
; 0, otherwise ItemOrderListB with wCounterPtr0Lo = 0) and falls through into
; VaultMenu_Store_MapItemsToInventory, which rebuilds wItemGrid as the item ids in the bag
; (wInventory), each once, in that list's order, padded with 0. Select on the storing item cursor
; (VaultMenu_Store_ItemCursor) toggles the order this way; VaultMenu_Store_AfterStoring_Finish flips
; wCounterPtr0Lo first, so its call keeps the order. (C2, E-0370; probed E-0386)
VaultMenu_ReorderBagOrStorage_ToggleBagOrder::
    ld hl, wWorkBuf
    ld b, $18

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop
    ld a, [wCounterPtr0Lo]
    and a
    jr nz, .clear_counter_ptr0_lo
    ld de, ItemOrderListA
    ld a, $01
    jr .set_counter_ptr0_lo

.clear_counter_ptr0_lo:
    ld de, ItemOrderListB
    xor a

.set_counter_ptr0_lo:
    ld [wCounterPtr0Lo], a

; Input: DE = a list of item ids ending in $FF (ItemOrderListA or ItemOrderListB, chosen by the
; caller). For each id in the list it searches the 24 bytes of wInventory and, when it finds the id,
; appends that byte to wWorkBuf (B counts the bytes appended, starting at 0); ids not in the bag are
; skipped, only the first matching slot counts, and an id listed twice is appended twice. At the $FF
; it copies the first 24 bytes of wWorkBuf to wItemGrid. It does not clear wWorkBuf:
; VaultMenu_Store_MoveItems_RebuildBagGrid and VaultMenu_ReorderBagOrStorage_ToggleBagOrder (which
; falls into it) clear 24 bytes first, so wItemGrid ends as the item ids in the bag in list order,
; padded with 0. Clobbers A, B, C, D, E, H and L. (C2, E-0386)
; for each item in the list at DE finds its inventory slot and records it in wWorkBuf
VaultMenu_Store_MapItemsToInventory::
    ld b, $00

.skip:
    ld a, [de]
    cp $ff
    jr z, .skip3
    ld c, a
    push de
    ld hl, wInventory
    ld d, $18

.loop:
    ld a, [hl]
    cp c
    jr z, .skip2
    inc hl
    dec d
    jr nz, .loop

.restore:
    pop de
    inc de
    jr .skip

.skip2:
    ld e, b
    ld d, $00
    push hl
    ld hl, wWorkBuf
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld a, [hli]
    ld [de], a
    inc b
    jr .restore

.skip3:
    ld hl, wWorkBuf
    ld de, wItemGrid
    ld b, $18

.loop2:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop2
    ret

; Sorts storage: switches the order list as VaultMenu_ReorderBagOrStorage_ToggleBagOrder, rebuilds
; the 100 two-byte entries of wItemStorage in the list's order in wWorkBuf (entries whose item is
; not in the list are not copied) and copies them back. (C2, E-0357; probed E-0386)
VaultMenu_ReorderBagOrStorage_SortStorage::
    ld hl, wWorkBuf
    ld b, $c8

.loop:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop
    ld a, [wCounterPtr0Lo]
    and a
    jr nz, .clear_counter_ptr0_lo
    ld de, ItemOrderListA
    ld a, $01
    jr .set_counter_ptr0_lo

.clear_counter_ptr0_lo:
    ld de, ItemOrderListB
    xor a

.set_counter_ptr0_lo:
    ld [wCounterPtr0Lo], a
    ld b, $00

.skip:
    ld a, [de]
    cp $ff
    jr z, .skip3
    ld c, a
    push de
    ld hl, wItemStorage
    ld d, $64

.loop2:
    ld a, [hl]
    cp c
    jr z, .skip2
    inc hl
    inc hl
    dec d
    jr nz, .loop2

.restore:
    pop de
    inc de
    jr .skip

.skip2:
    ld e, b
    ld d, $00
    sla e
    rl d
    push hl
    ld hl, wWorkBuf
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc b
    jr .restore

.skip3:
    ld hl, wWorkBuf
    ld de, wItemStorage
    ld b, $c8

.loop3:
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop3
    ret

; passed in DE (when wCounterPtr0Lo is not zero at one of the two choices) to
; VaultMenu_Store_MapItemsToInventory, which walks the list up to $FF and, for each byte found among
; the 24 wInventory bytes, appends that inventory byte to wWorkBuf; 95 item numbers and $FF (E-0237,
; C1)
; record: item numbers in order, $FF ends the list
ItemOrderListA::
    db ITEM_SHINYHARP, ITEM_WARP, ITEM_WARPWING, ITEM_EXITBELL, ITEM_LOGTWIG, ITEM_BEASTTAIL, ITEM_REPELLENT, ITEM_BOOKMARK, ITEM_HERB, ITEM_LOVEWATER, ITEM_WORLDDEW, ITEM_POTION ; id 0
    db ITEM_ELFWATER, ITEM_ANTIDOTE, ITEM_MOONHERB, ITEM_LAUREL, ITEM_AWAKESAND, ITEM_SKYBELL, ITEM_SAGEROCK, ITEM_WORLDLEAF, ITEM_BEEFJERKY, ITEM_PORKCHOP, ITEM_RIB, ITEM_SIRLOIN ; id 1
    db ITEM_BADMEAT, ITEM_METEORB, ITEM_QUEST, ITEM_HORROR, ITEM_BENICE, ITEM_CHEATER, ITEM_SMART, ITEM_COMEDY, ITEM_ATKSEED, ITEM_DEFSEED, ITEM_AGLSEED, ITEM_INTSEED ; id 2
    db ITEM_LIFEACORN, ITEM_MYSTICNUT, ITEM_TINYMEDAL, ITEM_GOLDPASS, ITEM_VITBELT, ITEM_DRACOBELT, ITEM_MAGICBELT, ITEM_ODDBELT, ITEM_STONEFANG, ITEM_STEELFANG, ITEM_MERMSCALE, ITEM_DRAKSCALE ; id 3
    db ITEM_AGL, ITEM_STARRY, ITEM_SMART_4A, ITEM_WISE, ITEM_MAGICCAPE, ITEM_DRACOCAPE, ITEM_SILVRCAPE, ITEM_GOLDCAPE, ITEM_PLTNMCAPE, ITEM_ORCACAPE, ITEM_BRAVECAPE, ITEM_DSCALE ; id 4
    db ITEM_NONE, ITEM_NONE_55, ITEM_NONE_56, ITEM_NONE_57, ITEM_NONE_58, ITEM_NONE_59, ITEM_LIFE, ITEM_DIVINE, ITEM_WAR, ITEM_MAGE, ITEM_FIGHT, ITEM_SAILOR ; id 5
    db ITEM_THIEF, ITEM_CLERIC, ITEM_62, ITEM_MIST, ITEM_FRIEND, ITEM_WIND, ITEM_BOLT, ITEM_SNOW, ITEM_FIRE, ITEM_WATERCALL, ITEM_MOONROCK, ITEM_CREST ; id 6
    db ITEM_YUNASOUL, ITEM_SLEEPHERB, ITEM_CHANGE, ITEM_TIDALBELL, ITEM_HARMIRROR, ITEM_SKY, ITEM_HEAVEN, ITEM_HEAVEN_3A, ITEM_HEAVEN_3B, ITEM_WIZSTONE, ITEM_PRETTY, $ff ; id 7

; passed in DE (when wCounterPtr0Lo is zero at one of the two choices) to
; VaultMenu_Store_MapItemsToInventory, which walks the list up to $FF and, for each byte found among
; the 24 wInventory bytes, appends that inventory byte to wWorkBuf; 95 item numbers and $FF (E-0237,
; C1)
ItemOrderListB::
    db ITEM_HERB, ITEM_LOVEWATER, ITEM_WORLDDEW, ITEM_POTION, ITEM_ELFWATER, ITEM_ANTIDOTE, ITEM_MOONHERB, ITEM_LAUREL, ITEM_AWAKESAND, ITEM_SKYBELL, ITEM_SAGEROCK, ITEM_WORLDLEAF ; id 0
    db ITEM_MIST, ITEM_FRIEND, ITEM_WIND, ITEM_BOLT, ITEM_SNOW, ITEM_FIRE, ITEM_BEEFJERKY, ITEM_PORKCHOP, ITEM_RIB, ITEM_SIRLOIN, ITEM_BADMEAT, ITEM_METEORB ; id 1
    db ITEM_QUEST, ITEM_HORROR, ITEM_BENICE, ITEM_CHEATER, ITEM_SMART, ITEM_COMEDY, ITEM_ATKSEED, ITEM_DEFSEED, ITEM_AGLSEED, ITEM_INTSEED, ITEM_LIFEACORN, ITEM_MYSTICNUT ; id 2
    db ITEM_TINYMEDAL, ITEM_GOLDPASS, ITEM_VITBELT, ITEM_DRACOBELT, ITEM_MAGICBELT, ITEM_ODDBELT, ITEM_STONEFANG, ITEM_STEELFANG, ITEM_MERMSCALE, ITEM_DRAKSCALE, ITEM_AGL, ITEM_STARRY ; id 3
    db ITEM_SMART_4A, ITEM_WISE, ITEM_MAGICCAPE, ITEM_DRACOCAPE, ITEM_SILVRCAPE, ITEM_GOLDCAPE, ITEM_PLTNMCAPE, ITEM_ORCACAPE, ITEM_BRAVECAPE, ITEM_DSCALE, ITEM_NONE, ITEM_NONE_55 ; id 4
    db ITEM_NONE_56, ITEM_NONE_57, ITEM_NONE_58, ITEM_NONE_59, ITEM_LIFE, ITEM_DIVINE, ITEM_WAR, ITEM_MAGE, ITEM_FIGHT, ITEM_SAILOR, ITEM_THIEF, ITEM_CLERIC ; id 5
    db ITEM_62, ITEM_SHINYHARP, ITEM_WARP, ITEM_WARPWING, ITEM_EXITBELL, ITEM_LOGTWIG, ITEM_BEASTTAIL, ITEM_REPELLENT, ITEM_BOOKMARK, ITEM_WATERCALL, ITEM_MOONROCK, ITEM_CREST ; id 6
    db ITEM_YUNASOUL, ITEM_SLEEPHERB, ITEM_CHANGE, ITEM_TIDALBELL, ITEM_HARMIRROR, ITEM_SKY, ITEM_HEAVEN, ITEM_HEAVEN_3A, ITEM_HEAVEN_3B, ITEM_WIZSTONE, ITEM_PRETTY, $ff ; id 7

; For each of the wPartyCount party members (record numbers in wPartyList) lowers the current HP
; word (MON_HP) to the maximum (MON_MAX_HP) when it is above it, and does the same for MP (MON_MP,
; MON_MAX_MP). Words are compared as unsigned 16-bit numbers with CompareHLWithDE_BankF2, high byte
; first; a value equal to or below its maximum is left alone. It returns at once when wPartyCount is
; 0. The records are in save RAM and reached with SRAMRecordAddress, which neither enables SRAM nor
; picks its bank, so the caller must already have save RAM enabled (bank 0). Uses wCounterPtr0Lo/Hi
; as scratch; they end holding the maximum MP of the last member. Far-called by
; StoreBattleStateToPartyRecords and StoreBattleStateToPartyRecords_BankA3 right after they write
; the HP, MP and status of the battle back into the records. (C2, E-0386)
; for each party record sets HP (field $5B) and MP (field $5F) down to their maxima when they exceed
; them (E-0129)
ClampPartyHPAndMPToMax::
    ld a, [wPartyCount]
    and a
    ret z
    ld b, a
    ld hl, wPartyList

.loop:
    push bc
    push hl
    ld a, [hl]
    ld c, MON_HP
    call SRAMRecordAddress
    ld a, [hli]
    ld [wCounterPtr0Lo], a
    ld a, [hl]
    ld [wCounterPtr0Hi], a
    pop hl
    push hl
    ld a, [hl]
    ld c, MON_MAX_HP
    call SRAMRecordAddress
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    ld a, [wCounterPtr0Lo]
    ld e, a
    ld a, [wCounterPtr0Hi]
    ld d, a
    ld a, l
    ld [wCounterPtr0Lo], a
    ld a, h
    ld [wCounterPtr0Hi], a
    call CompareHLWithDE_BankF2
    ld a, c
    and a
    jr nz, .restore
    pop hl
    push hl
    ld a, [hl]
    ld c, MON_HP
    call SRAMRecordAddress
    ld a, [wCounterPtr0Lo]
    ld [hli], a
    ld a, [wCounterPtr0Hi]
    ld [hl], a

.restore:
    pop hl
    push hl
    ld a, [hl]
    ld c, MON_MP
    call SRAMRecordAddress
    ld a, [hli]
    ld [wCounterPtr0Lo], a
    ld a, [hl]
    ld [wCounterPtr0Hi], a
    pop hl
    push hl
    ld a, [hl]
    ld c, MON_MAX_MP
    call SRAMRecordAddress
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    ld a, [wCounterPtr0Lo]
    ld e, a
    ld a, [wCounterPtr0Hi]
    ld d, a
    ld a, l
    ld [wCounterPtr0Lo], a
    ld a, h
    ld [wCounterPtr0Hi], a
    call CompareHLWithDE_BankF2
    ld a, c
    and a
    jr nz, .restore2
    pop hl
    push hl
    ld a, [hl]
    ld c, MON_MP
    call SRAMRecordAddress
    ld a, [wCounterPtr0Lo]
    ld [hli], a
    ld a, [wCounterPtr0Hi]
    ld [hl], a

.restore2:
    pop hl
    inc hl
    pop bc
    dec b
    jp nz, .loop
    ret

; Compares HL with DE as unsigned 16-bit numbers, high bytes first. C = 0 when HL < DE, C = 1 when
; they are equal, C = $FF when HL > DE; HL, DE and B are kept (A ends as the last byte compared). A
; copy of CompareHLWithDE for this bank. ClampPartyHPAndMPToMax calls it with HL = the maximum and
; DE = the current value, so C = 0 means the current value is above its maximum. (C2, E-0386)
; the same 21 bytes as CompareHLWithDE (CompareHLWithDE) (E-0061)
CompareHLWithDE_BankF2::
    ld a, h
    cp d
    jr c, .done2
    jr nz, .done
    ld a, l
    cp e
    jr c, .done2
    jr z, .done3

.done:
    ld c, $ff
    ret

.done2:
    ld c, $00
    ret

.done3:
    ld c, $01
    ret

; Clears $20F bytes to 0, from wArenaEntry through wArenaEntry + $20E (HL walks up, BC counts down).
; The range includes wScreenState and wScreenStep (wArenaEntry + $200 and + $201). Far-called by
; GreatLogTalkEvents_ArenaClassChoice (the arena desk talk), after it sets wDataBank and
; wScreenTableIndex and before it reads wArenaRank to start the arena scripts. On return HL =
; wArenaEntry + $20F, BC = 0, A = 0. (C2, E-0386)
; clears $20F bytes from wArenaEntry
GreatLogTalkEvents_ClearArenaData::
    ld hl, wArenaEntry
    ld bc, $020f

.loop:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ret
    ds $1960, $00
