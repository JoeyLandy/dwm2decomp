SECTION "Bank F2", ROMX[$4000], BANK[$F2]
    db $F2

; start-up for wGameMode = 8; forcing this mode on the emulator shows: egg-received dialogue when forced (E-0029)
; 1 call site from 1 routine (e.g. RunGameModeInit_ToGameMode8_Init)
; reads: wSaveStep, wTextWindowState
; writes: wSaveStep, wSaveRecordIndex, hScrollY, hScrollX, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, ...
; points at: wScreenState
GameMode8_Init::
Func_0F2_4001:: ; address name
    ld hl, wScreenState
    ld bc, $006F

Jump_0F2_4007::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_0F2_4007
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a

Jump_0F2_4013::
    farcall RunSaveSteps
    ld a, [wSaveStep]
    bit 7, a
    jr z, Jump_0F2_4013
    ld b, $46
    ld de, Tiles1Gfx_46_4001
    ld hl, vTiles1
    call DecompressToVRAM
    farcall ClearScreenBufferAndAttributes_BankF1
    xor a, a
    ldh [hScrollY], a
    ldh [hScrollX], a
    call BGMapAddressAtScroll_BankF2
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1B_BankF2
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
    ld a, $01
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $00
    ldh [hSpriteWindowClipMode], a

Jump_0F2_4075::
    farcall StepTextWindowOpenClose
    ld a, [wTextWindowState]
    and a, $03
    jr nz, Jump_0F2_4075
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
    jp Jump_000_077A

; per-frame routine for wGameMode = 8
; 1 call site from 1 routine (e.g. RunGameModeUpdate_ToGameMode8_Update)
; reads: wFadeState, wScreenSubStep, wTextFlags
GameMode8_Update::
Func_0F2_40A2:: ; address name
    ld a, [wFadeState]
    and a, a
    ret nz
    ld a, [wScreenSubStep]
    and a, a
    jr z, Jump_0F2_40B0
    call GameMode8_Update_Sub01

Jump_0F2_40B0::
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wScreenSubStep]
    rst $00
    dw GameMode8_Update_Case00
    dw GameMode8_Update_Case01
    dw GameMode8_Update_Case02
    dw GameMode8_Update_Case01
    dw GameMode8_Update_Case04
    dw GameMode8_Update_Case05
    dw GameMode8_Update_Case01
    dw GameMode8_Update_Case01
    dw GameMode8_Update_Case08
    dw GameMode8_Update_Case01
    dw GameMode8_Update_Case01
    dw GameMode8_Update_Case0B
    dw GameMode8_Update_Case0C
    dw GameMode8_Update_Case0D

; entry 0 of the `rst $00` table in GameMode8_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
; writes: wScreenSubStep
GameMode8_Update_Case00::
Jump_0F2_40D5:: ; address name
    call GameMode8_Update_Case00_Sub01
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 1 of the `rst $00` table in GameMode8_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenCounter, wScreenSubStep
; writes: wScreenCounter, wScreenSubStep
GameMode8_Update_Case01::
Jump_0F2_40E0:: ; address name
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

; entry 2 of the `rst $00` table in GameMode8_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wObject1, wScreenSubStep
; writes: wObject1, wScreenSubStep
GameMode8_Update_Case02::
Jump_0F2_40F6:: ; address name
    ld a, [wObject1 + $9]
    and a, $03
    and a, a
    ret z
    ld a, [wObject1 + $B]
    dec a
    ld [wObject1 + $B], a
    cp a, $59
    ret nc
    ld a, $58
    ld [wObject1 + $B], a
    ld a, [wObject1 + $D]
    set 1, a
    ld [wObject1 + $D], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 4 of the `rst $00` table in GameMode8_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
; writes: wObject5, wArg1, wScreenSubStep
GameMode8_Update_Case04::
Jump_0F2_411C:: ; address name
    ld a, $80
    ld [wObject5], a
    ld a, $01
    ld [wArg1], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 5 of the `rst $00` table in GameMode8_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, wScreenSubStep
; writes: wSpriteSlots, wScreenSubStep
GameMode8_Update_Case05::
Jump_0F2_412E:: ; address name
    ld a, [wSpriteSlots + $9]
    and a, $03
    and a, a
    ret z
    ld a, [wSpriteSlots + $B]
    inc a
    ld [wSpriteSlots + $B], a
    cp a, $38
    ret nz
    ld a, [wSpriteSlots + $D]
    set 1, a
    ld [wSpriteSlots + $D], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 8 of the `rst $00` table in GameMode8_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenSubStep
; writes: wObject5, wArg1, wScreenSubStep
GameMode8_Update_Case08::
Jump_0F2_414F:: ; address name
    ld a, $00
    ld [wObject5], a
    ld [wArg1], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 11 of the `rst $00` table in GameMode8_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wSpriteSlots, wScreenSubStep
; writes: wSpriteSlots, wScreenSubStep
GameMode8_Update_Case0B::
Jump_0F2_415F:: ; address name
    ld a, [wSpriteSlots + $D]
    res 1, a
    ld [wSpriteSlots + $D], a
    ld a, $03
    ld [wSpriteSlots + $7], a
    ld a, [wSpriteSlots + $9]
    and a, $03
    and a, a
    ret z
    ld a, [wSpriteSlots + $B]
    dec a
    ld [wSpriteSlots + $B], a
    cp a, $E0
    ret nz
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

; entry 12 of the `rst $00` table in GameMode8_Update
; no direct call (reached through a table, a jump or a vector)
; writes: wStringIndex, wStringCategory
; points at: wPlayerName, wTextBuf0, wNameGlyphBuf, wTextBuf1, wScreenSubStep
GameMode8_Update_Case0C::
Jump_0F2_4185:: ; address name
    ld hl, wPlayerName
    ld de, wTextBuf0
    ld c, $0A
    call GameMode8_Update_Case0C_Sub01
    ld de, wChildRecord + $B
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call CopyMonsterNameToBuffer_BF2
    ld hl, wNameGlyphBuf
    ld de, wTextBuf1
    ld c, $10
    call GameMode8_Update_Case0C_Sub01
    ld a, $0E
    ld [wStringIndex], a ; '0 received G s egg. Please'
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_BankF0_48A0
    ld hl, wScreenSubStep
    inc [hl]
    ret

; only called from GameMode8_Update_Case0C (E-0047)
; 2 call sites from 1 routine (e.g. GameMode8_Update_Case0C)
GameMode8_Update_Case0C_Sub01::
Func_0F2_41BA:: ; address name
    ld a, [hl+]
    cp a, $F0
    jr z, Jump_0F2_41C4
    ld [de], a
    inc de
    dec c
    jr nz, GameMode8_Update_Case0C_Sub01

Jump_0F2_41C4::
    ld a, $F0
    ld [de], a
    ret

; entry 13 of the `rst $00` table in GameMode8_Update
; no direct call (reached through a table, a jump or a vector)
GameMode8_Update_Case0D::
Jump_0F2_41C8:: ; address name
    call GameMode8_Update_Case0D_Sub01
    ret

; HL = string number; copies 16 bytes of that string of StringTable_MonsterNames (bank $08, via wDataBank) to wC8CF; wDataBank is restored
; 1 call site from 1 routine (e.g. GameMode8_Update_Case0C)
; reads: wDataBank
; writes: wDataBank
; points at: wNameGlyphBuf
CopyMonsterNameToBuffer_BF2::
Func_0F2_41CC:: ; address name
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

; clears the default window, wC8CB = 1, wC8CC = 0, hFFB9 = 2, then repeatedly far-calls Func_002_69D0 until wC8CB & 3 = 0 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowState
; writes: wTextWindowState, wTextWindowStep, hSpriteWindowClipMode
RunTextUntilTextWindowStateDone_BankF2:: ; heuristic: follows a terminator; C0
Func_0F2_4202:: ; address name
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, $01
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a

Jump_0F2_4219::
    farcall StepTextWindowOpenClose
    ld a, [wTextWindowState]
    and a, $03
    jr nz, Jump_0F2_4219
    ret

; only called from GameMode8_Update_Case0D (E-0047)
; 1 call site from 1 routine (e.g. GameMode8_Update_Case0D)
; writes: wLinkSceneByte4B, wGameMode, wModeState, wModeChangeRequest
; points at: wScreenState
GameMode8_Update_Case0D_Sub01::
Func_0F2_4227:: ; address name
    ld hl, wScreenState
    ld bc, $006F

Jump_0F2_422D::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0F2_422D
    xor a, a
    ld [wLinkSceneByte4B], a
    ld a, $05
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    ld a, $01
    ld [wModeChangeRequest], a
    ret

; only called from GameMode8_Update_Case00 (E-0047)
; 1 call site from 1 routine (e.g. GameMode8_Update_Case00)
; reads: wBankF0BlockC7, wIsCGB
; writes: hTemp0, wObject5, wSpriteSlotCount, wOBJPaletteUploadRequest
; points at: wSpriteSlots, wObject1, hTemp0
GameMode8_Update_Case00_Sub01::
Func_0F2_4248:: ; address name
    ld de, $0000
    call TestFlagBit
    jr c, Jump_0F2_4255
    ld hl, Data_0F2_42FE
    jr Jump_0F2_4258

Jump_0F2_4255::
    ld hl, SpriteSlotsInit_F2_430E

Jump_0F2_4258::
    ld de, wSpriteSlots
    ld b, $10
    call CopyBytesDEFromHL_BankF2
    ld a, [wBankF0BlockC7]
    and a, a
    jr nz, Jump_0F2_426B
    ld hl, Data_0F2_431E
    jr Jump_0F2_426E

Jump_0F2_426B::
    ld hl, Object1Init_F2_432E

Jump_0F2_426E::
    ld de, wObject1
    ld b, $10
    call CopyBytesDEFromHL_BankF2
    ld de, $0000
    call TestFlagBit
    jr c, Jump_0F2_4283
    ld hl, Data_0F2_42E0
    jr Jump_0F2_4286

Jump_0F2_4283::
    ld hl, Data_0F2_42E6

Jump_0F2_4286::
    ld de, hTemp0
    ld b, $06
    call CopyBytesDEFromHL_BankF2
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, [wBankF0BlockC7]
    and a, a
    jr nz, Jump_0F2_429F
    ld hl, Data_0F2_42EC
    jr Jump_0F2_42A2

Jump_0F2_429F::
    ld hl, Data_0F2_42F2

Jump_0F2_42A2::
    ld de, hTemp0
    ld b, $06
    call CopyBytesDEFromHL_BankF2
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, $0D
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    xor a, a
    ld [wObject5], a
    ld a, $48
    ld [wObject5 + $4], a
    ld a, $40
    ld [wObject5 + $5], a
    ld a, $02
    ld [wSpriteSlotCount], a
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_0F2_42D8
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a

Jump_0F2_42D8::
    ret

; the same 7 bytes as CopyBytesDEFromHL (34:406E)
; 4 call sites from 1 routine (e.g. GameMode8_Update_Case00_Sub01)
CopyBytesDEFromHL_BankF2::
Func_0F2_42D9:: ; address name
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, CopyBytesDEFromHL_BankF2
    ret

; address loaded by GameMode8_Update_Case00_Sub01
Data_0F2_42E0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $01, $04, $00, $80

; address loaded by GameMode8_Update_Case00_Sub01
Data_0F2_42E6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $00, $01, $01, $00, $80

; address loaded by GameMode8_Update_Case00_Sub01
Data_0F2_42EC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0C, $00, $01, $05, $00, $81

; address loaded by GameMode8_Update_Case00_Sub01
Data_0F2_42F2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0C, $00, $01, $05, $00, $81, $00, $00, $00, $02, $00, $82

; address loaded by GameMode8_Update_Case00_Sub01
Data_0F2_42FE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $00, $00, $F0, $40, $04, $01, $00, $00, $00, $F0, $40, $04, $00, $00

; E-0264 (derived: Func_0F2_42D9 copies these 16 bytes to wSpriteSlots)
; record: 16 bytes copied to wSpriteSlots
SpriteSlotsInit_F2_430E::
Data_0F2_430E:: ; address name
    db $00, $01, $01, $00, $F0, $40, $01, $01, $00, $00, $00, $F0, $40, $04, $00, $00 ; entry 0

; address loaded by GameMode8_Update_Case00_Sub01
Data_0F2_431E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $0C, $00, $F0, $40, $05, $03, $10, $00, $00, $F0, $40, $04, $00, $00

; E-0264 (derived: Func_0F2_42D9 copies these 16 bytes to wObject1)
; record: 16 bytes copied to wObject1
Object1Init_F2_432E::
Data_0F2_432E:: ; address name
    db $00, $01, $0C, $00, $F0, $40, $05, $03, $10, $00, $00, $F0, $40, $04, $00, $00 ; entry 0
    db $00, $00, $00, $00, $48, $40, $02, $00, $20, $00, $00, $48, $40, $04, $00, $00

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 1 call site from 1 routine (e.g. GameMode8_Init)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_BankF2::
Func_0F2_434E:: ; address name
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

; the same 84 bytes as DrawScreenBufferRectToBGMap_1B (1B:6277)
; 1 call site from 1 routine (e.g. GameMode8_Init)
; reads: wIsCGB
; writes: wTextCursorLo, wTextCursorHi, rSVBK
; points at: wScreenTileBuffer, wScreenAttrBuffer
DrawScreenBufferRectToBGMap_1B_BankF2::
Func_0F2_436F:: ; address name
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

; only called from GameMode8_Update (E-0047)
; 1 call site from 1 routine (e.g. GameMode8_Update)
GameMode8_Update_Sub01::
Func_0F2_43C3:: ; address name
    farcall UpdateAndDrawSpriteSlots
    farcall DrawFieldSprites
    ret

; ld de, this bank's string table / BeginStringDisplay
; 2 call sites from 2 routines (e.g. ShowString_BankF2, DebugMessageTest_Update_ToBeginStringDisplay_BankF2)
BeginStringDisplay_BankF2::
Func_0F2_43D0:: ; address name
    ld de, StringCategories_F2_43E5
    call BeginStringDisplay
    ret
    db $11, $E5, $43, $CD, $FE, $25, $C9

; Func_0F2_43D0 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 2 call sites from 2 routines (e.g. EggServiceMenu_Case0F_Case07, RenameMenu_Case06_Case03)
ShowString_BankF2::
Func_0F2_43DE:: ; address name
    call BeginStringDisplay_BankF2
    call RunStringDisplayToEnd
    ret

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_F2_43E5::
Data_0F2_43E5:: ; address name
    dw StringList_F2_43E7 ; id 0

; E-0217 (derived: category list of StringCategories_F2_43E5; one pointer per wStringIndex)
; record: string
StringList_F2_43E7::
Data_0F2_43E7:: ; address name
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

String_F2_00_00:: ; heuristic: string; C0
Data_0F2_442F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Hello, how may I", $F1
    db "serve you?", $F0

String_F2_00_02:: ; heuristic: string; C0
Data_0F2_444E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Which egg should", $F1
    db "I appraise?", $F0

String_F2_00_03:: ; heuristic: string; C0
Data_0F2_446E:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " It will cost", $F1
    db "20G. It that OK?", $F0

String_F2_00_04:: ; heuristic: string; C0
Data_0F2_448F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " How else may I", $F1
    db "serve you?", $F0

String_F2_00_05:: ; heuristic: string; C0
Data_0F2_44AC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Um", $A4, " You don't", $F1
    db "have enough gold", $A4, $F7
    db $F0

String_F2_00_06:: ; heuristic: string; C0
Data_0F2_44CF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Um", $A4, " You don't", $F1
    db "have any eggs", $A4, $F7
    db $F0

String_F2_00_07:: ; heuristic: string; C0
Data_0F2_44EF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Which egg should", $F1
    db "I bless?", $F0

String_F2_00_08:: ; heuristic: string; C0
Data_0F2_450C:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " It will cost", $F1
    db $F9, "0G. Is that OK?", $F0

String_F2_00_09:: ; heuristic: string; C0
Data_0F2_452D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Egg, egg, toss", $F1
    db "and scramble", $A4, $E5, "0", $E4, $D2, $FA, $F7
    db $EF, $EE, $E9, $FF, "There", $A4, $EF, $EE, "That did it.", $FA, $F7
    db $EF, $EE, "You just have to", $EF, $EE, "hatch it now.", $F7
    db $F0

String_F2_00_0A:: ; heuristic: string; C0
Data_0F2_458F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Please come see", $F1
    db "me when you get", $FA, $F7
    db $EF, $EE, "more eggs.", $EF, $EE, $F7
    db $F0

String_F2_00_0B:: ; heuristic: string; C0
Data_0F2_45C3:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " OK, I'll evaluate", $F1
    db "this egg now", $A4, $F7
    db $F0

String_F2_00_0C:: ; heuristic: string; C0
Data_0F2_45E6:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " It's fine. There's", $F1
    db "nothing wrong.", $F7
    db $F0

String_F2_00_0D:: ; heuristic: string; C0
Data_0F2_460A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " It's good, and", $F1
    db "growing healthy.", $F7
    db $F0

String_F2_00_0E:: ; heuristic: string; C0
Data_0F2_462D:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Wow, this egg is", $F1
    db "really vigorous.", $F7
    db $F0

String_F2_00_0F:: ; heuristic: string; C0
Data_0F2_4653:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Oh, my! This egg", $F1
    db "is incredible!", $F7
    db $F0

String_F2_00_10:: ; heuristic: string; C0
Data_0F2_4677:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Don't expect too", $F1
    db "many skills.", $F7
    db $F0

String_F2_00_11:: ; heuristic: string; C0
Data_0F2_4698:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " It has a fair", $F1
    db "number of skills.", $F7
    db $F0

String_F2_00_12:: ; heuristic: string; C0
Data_0F2_46BC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " It inherited its", $F1
    db "parents", $95, " skills.", $F7
    db $F0

String_F2_00_13:: ; heuristic: string; C0
Data_0F2_46E2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " It knows a great", $F1
    db "variety of skills!", $F7
    db $F0

String_F2_00_14:: ; heuristic: string; C0
Data_0F2_470A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Its growth may", $F1
    db "be a bit wanting.", $F7
    db $F0

String_F2_00_15:: ; heuristic: string; C0
Data_0F2_472F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " It will grow in", $F1
    db "an average way.", $F7
    db $F0

String_F2_00_16:: ; heuristic: string; C0
Data_0F2_4753:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " It will be hard", $F1
    db "to raise a little", $A4, $F7
    db $F0

String_F2_00_17:: ; heuristic: string; C0
Data_0F2_477A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Its growth can't", $F1
    db "be faulted.", $F7
    db $F0

String_F2_00_18:: ; heuristic: string; C0
Data_0F2_479A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " It appears to be", $F1
    db "a hard worker.", $F7
    db $F0

String_F2_00_19:: ; heuristic: string; C0
Data_0F2_47BE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " This one seems", $F1
    db "to be quite smart.", $F7
    db $F0

String_F2_00_1A:: ; heuristic: string; C0
Data_0F2_47E4:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " I can tell this", $F1
    db "one is kind.", $F7
    db $F0

String_F2_00_1B:: ; heuristic: string; C0
Data_0F2_4805:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " No doubt at", $F1
    db "all-it's male.", $F7
    db $F0

String_F2_00_1C:: ; heuristic: string; C0
Data_0F2_4823:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " No doubt at", $F1
    db "all-it's female.", $F7
    db $F0

String_F2_00_1D:: ; heuristic: string; C0
Data_0F2_4843:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " That's the best", $F1
    db "I could do now.", $FA, $F7
    db $EF, $EE, "Um", $A4, " I hope I was", $EF, $EE, "useful to you.", $F7
    db $F0

String_F2_00_1E:: ; heuristic: string; C0
Data_0F2_488A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Should I change", $F1
    db "someone's name?", $F0

String_F2_00_22:: ; heuristic: string; C0
Data_0F2_48AC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Come here for", $F1
    db "renaming monsters.", $F7
    db $F0

String_F2_00_23:: ; heuristic: string; C0
Data_0F2_48D1:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db $EB, $45, " Pick the monster", $F1
    db "to rename.", $F0, "Is ", $F9, "0 OK?", $F0, "Is ", $F9, "0 OK?", $F0, "That name is", $F1
    db "already in use.", $F7
    db $F0, "That name can't be", $F1
    db "used.", $FA, $F7
    db $F2, "Please use another", $F1
    db "name.", $F7
    db $F0, $EB
    db $45, $90, $12, $36, $90, $F9, $00, $90, $18, $14, $98, $F0, $EB, $45, $90, $12
    db $36, $90, $F9, $00, $90, $18, $14, $98, $F0, $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That name is", $F1
    db "already in use.", $F7
    db $F0, $EB
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That name can't", $F1
    db "be used.", $FA, $F7
    db $F2, "You'll have to use", $F1
    db "another name.", $F7
    db $F0

; shows string $10 of category 0 (ShowString_Bank0E) at vTiles2 + $20 with size $011E, then restores the default window (E-0121)
; 4 call sites from 4 routines (e.g. RunLinkSession5Exchange_Case01_Sub01_Case0D_Case01, RunLinkSession5Exchange_Case01_Sub01_Case0D_Case1C, RunScreenStateWhenNotFading_F1_Case0D_Case01, RunScreenStateWhenNotFading_F1_Case0D_Case1C)
; writes: wStringIndex, wStringCategory, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ShowString10Bank0EAtTiles2020ThenDefault::
Func_0F2_49CF:: ; address name
    ld a, $10
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld hl, vTiles2 + $20
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $1E01
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

; shows string $0E of category 0 (ShowString_Bank0E) at vTiles2 + $700 with size $0107, restores the default window and copies two tiles from bank $1F to vTiles1 + $6E0 and + $6F0 (E-0121)
; 2 call sites from 2 routines (e.g. ShowString0EAndStep_Bank37, ShowString0EAndStep_BankF1)
; writes: wStringIndex, wStringCategory, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ShowString0EBank0EAtTiles2700AndLoadTiles::
Func_0F2_4A0B:: ; address name
    ld a, $0E
    ld [wStringIndex], a
    xor a, a
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
    ld de, Tiles1Plus6E0Tiles_1F_4510
    ld hl, vTiles1 + $6E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles_1F_4450
    ld hl, vTiles1 + $6F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; clears five tiles at vTiles2 + $290 (copying $2940) and draws the name at wCA3A there (E-0121)
; 1 call site from 1 routine (e.g. ShowPersonalityNameAndWCA3AName)
; writes: wNameGlyphBuf
DrawWCA3ANameAtTiles2290::
Func_0F2_4A61:: ; address name
    ld hl, $2940
    ld de, vTiles2 + $290
    call CopyTileBytesToVRAMCounted_BankF2
    ld hl, $2940
    call CopyTileBytesToVRAMCounted_BankF2
    ld hl, $2940
    call CopyTileBytesToVRAMCounted_BankF2
    ld hl, $2940
    call CopyTileBytesToVRAMCounted_BankF2
    ld hl, $2940
    call CopyTileBytesToVRAMCounted_BankF2
    ld hl, wRecordBufB + $F
    call CopyShortStringToNameGlyphBuf_BankF2
    ld de, vTiles2 + $290
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    call CopyGlyphTilesToVRAM
    ret

; shows personality name CombinedPersonalityLevelIndex (category 7) at vTiles2 + $200 with size $0109, then restores the default window (E-0121)
; 1 call site from 1 routine (e.g. ShowPersonalityNameAndWCA3AName)
; writes: wStringIndex, wStringCategory, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ShowCombinedPersonalityName::
Func_0F2_4A94:: ; address name
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

; returns 9 * PersonalityLevelOfA(wCA9A) + 3 * PersonalityLevelOfA(wCA9D) + PersonalityLevelOfA(wCA9B) (E-0121)
; 1 call site from 1 routine (e.g. ShowCombinedPersonalityName)
; reads: wRecordBufB
CombinedPersonalityLevelIndex::
Func_0F2_4AD3:: ; address name
    ld a, [wRecordBufB + $6F]
    call PersonalityLevelOfA
    ld a, $09
    call Multiply8
    ld b, l
    ld a, [wRecordBufB + $72]
    call PersonalityLevelOfA
    ld a, c
    add a, a
    add a, c
    add a, b
    ld b, a
    ld a, [wRecordBufB + $70]
    call PersonalityLevelOfA
    ld a, c
    add a, b
    ret

; C = 0 when A >= $C0, 1 when A >= $40, else 2 (the g(v) of PersonalityIndexOfSlot) (E-0116)
; 3 call sites from 1 routine (e.g. CombinedPersonalityLevelIndex)
PersonalityLevelOfA::
Func_0F2_4AF3:: ; address name
    ld c, $00
    cp a, $C0
    ret nc
    inc c
    cp a, $40
    ret nc
    inc c
    ret

; ShowCombinedPersonalityName, then DrawWCA3ANameAtTiles2290 (E-0122)
; 2 call sites from 2 routines (e.g. RunLinkSession5Exchange_Case01_Sub01_Case0D_Case12, RunScreenStateWhenNotFading_F1_Case0D_Case12)
ShowPersonalityNameAndWCA3AName::
Func_0F2_4AFE:: ; address name
    call ShowCombinedPersonalityName
    call DrawWCA3ANameAtTiles2290
    ret

; writes the EXP wCA83-wCA85 as seven digits and, below the level cap, the EXP still needed for the next level (E-0129)
; 2 call sites from 2 routines (e.g. RunLinkSession5Exchange_Case01_Sub01_Case0D_Case13, RunScreenStateWhenNotFading_F1_Case0D_Case13)
; reads: wRecordBufB, hTemp0, wSpeciesExpCurve, hTemp1, hTemp2
; writes: wDigits, hTemp0, hTemp1, wSpeciesIdLo, wSpeciesIdHi, hTemp2, wArg1, wArg2, ...
; points at: hTemp2
DrawWCA83ExpAndToNextLevel::
Func_0F2_4B05:: ; address name
    ld a, [wRecordBufB + $58]
    ld [wDigits], a
    ld a, [wRecordBufB + $59]
    ld [wDigits + $1], a
    ld a, [wRecordBufB + $5A]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    farcall UnpackBCDToDigitsArg1_Bank1E
    call BGMapAddressAtScroll_BankF2_514D
    ld de, $018C
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    call DrawSevenDigitsFromArg1_BankF2
    ld a, [wRecordBufB + $56]
    ldh [hTemp0], a
    ld a, [wRecordBufB + $57]
    ldh [hTemp1], a
    ld b, a
    ldh a, [hTemp0]
    cp a, b
    jp nc, Jump_0F2_4BB6
    ldh a, [hTemp0]
    ld b, a
    push bc
    ld a, [wRecordBufB + $B]
    ld [wSpeciesIdLo], a
    ld a, [wRecordBufB + $C]
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
    ld a, [wRecordBufB + $58]
    ldh [hTemp0], a
    ld a, [wRecordBufB + $59]
    ldh [hTemp1], a
    ld a, [wRecordBufB + $5A]
    ldh [hTemp2], a
    pop de
    pop bc
    ldh a, [hTemp0]
    ld l, a
    ld a, c
    sub a, l
    ld c, a
    ldh a, [hTemp1]
    ld l, a
    ld a, b
    sbc a, l
    ld b, a
    ldh a, [hTemp2]
    ld l, a
    ld a, e
    sbc a, l
    ld e, a
    ld a, c
    ld [wDigits], a
    ld a, b
    ld [wDigits + $1], a
    ld a, e
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    farcall UnpackBCDToDigitsArg1_Bank1E

Jump_0F2_4BA8::
    call BGMapAddressAtScroll_BankF2_514D
    ld de, $020C
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    call DrawSevenDigitsFromArg1_BankF2
    ret

Jump_0F2_4BB6::
    ld a, $E3
    ld [wArg1], a
    ld [wArg2], a
    ld [wArg3], a
    ld [wArg4], a
    ld [wArg5], a
    ld [wArg6], a
    xor a, a
    ld [wArg7], a
    jr Jump_0F2_4BA8

; shows string wCACF of category $0B (ShowString_Bank08) at vTiles2 + $320 with size $0206 (E-0121)
; 2 call sites from 2 routines (e.g. RunLinkSession5Exchange_Case01_Sub01_Case0D_Case14, RunScreenStateWhenNotFading_F1_Case0D_Case14)
; reads: wRecordBufB
; writes: wStringIndex, wStringCategory, rRAMG2, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ShowWCACFCategory11StringAtTiles2320::
Func_0F2_4BD0:: ; address name
    ld a, [wRecordBufB + $A4]
    ld [wStringIndex], a
    ld a, $0B
    ld [wStringCategory], a
    xor a, a
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

; loads the species record of wCA36/7 and shows string [wD013] of category $0D at vTiles2 + $680 with size $0206 (E-0121)
; 2 call sites from 2 routines (e.g. RunLinkSession5Exchange_Case01_Sub01_Case0D_Case1A, RunScreenStateWhenNotFading_F1_Case0D_Case1A)
; reads: wRecordBufB, wSpeciesRecord
; writes: wSpeciesIdLo, wSpeciesIdHi, wStringIndex, wStringCategory, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ShowSpeciesCategory13StringAtTiles2680::
Func_0F2_4BFC:: ; address name
    ld a, [wRecordBufB + $B]
    ld [wSpeciesIdLo], a
    ld a, [wRecordBufB + $C]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wSpeciesRecord + $B]
    ld [wStringIndex], a
    ld a, $0D
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

; runs Func_0F2_4C3D and Func_0F2_4D72 (E-0126)
; 2 call sites from 2 routines (e.g. RunLinkSession5Exchange_Case01_Sub01_Case0D_Case1F, RunScreenStateWhenNotFading_F1_Case0D_Case1F)
RunF24C3DAnd4D72::
Func_0F2_4C36:: ; address name
    call RunF24C3DAnd4D72_Sub01
    call RunF24C3DAnd4D72_Sub02
    ret

; only called from RunF24C3DAnd4D72 (E-0047)
; 1 call site from 1 routine (e.g. RunF24C3DAnd4D72)
; reads: wRecordBufB, hTemp1
; writes: wNameGlyphBuf, wArg1, wArg2, wArg3
; points at: wRecordBufB
RunF24C3DAnd4D72_Sub01::
Func_0F2_4C3D:: ; address name
    ld a, [wRecordBufB + $D]
    and a, $10
    and a, a
    jr nz, Jump_0F2_4C4A
    ld de, Data_0F2_4D62
    jr Jump_0F2_4C4D

Jump_0F2_4C4A::
    ld de, Data_0F2_4D6A

Jump_0F2_4C4D::
    ld a, [de]
    push de
    call LoadTemp0WordFromRecordBufB
    pop de
    ldh a, [hTemp1]
    cp a, $FF
    jr nz, Jump_0F2_4C7E
    ld a, $98
    ld [wNameGlyphBuf], a
    ld a, $98
    ld [wNameGlyphBuf + $1], a
    ld a, $98
    ld [wNameGlyphBuf + $2], a
    ld a, $F0
    ld [wNameGlyphBuf + $3], a
    push de
    ld de, vTiles2 + $200
    call CopyGlyphTilesToVRAM
    pop de
    ld a, $03
    add a, e
    ld e, a
    jr nc, Jump_0F2_4C7C
    inc d

Jump_0F2_4C7C::
    jr Jump_0F2_4CA8

Jump_0F2_4C7E::
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

Jump_0F2_4CA8::
    ld a, [de]
    inc de
    push de
    ld hl, wRecordBufB
    add_a_to_hl
    call CopyShortStringToNameGlyphBuf_BankF2
    ld de, vTiles2 + $2F0
    call CopyGlyphTilesToVRAM
    pop de
    ld a, [de]
    push de
    call LoadTemp0WordFromRecordBufB
    pop de
    ldh a, [hTemp1]
    cp a, $FF
    jr nz, Jump_0F2_4CEE
    ld a, $98
    ld [wNameGlyphBuf], a
    ld a, $98
    ld [wNameGlyphBuf + $1], a
    ld a, $98
    ld [wNameGlyphBuf + $2], a
    ld a, $F0
    ld [wNameGlyphBuf + $3], a
    push de
    ld de, vTiles2 + $340
    call CopyGlyphTilesToVRAM
    pop de
    ld a, $03
    add a, e
    ld e, a
    jr nc, Jump_0F2_4CEC
    inc d

Jump_0F2_4CEC::
    jr Jump_0F2_4D18

Jump_0F2_4CEE::
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

Jump_0F2_4D18::
    ld a, [de]
    ld hl, wRecordBufB
    add_a_to_hl
    call CopyShortStringToNameGlyphBuf_BankF2
    ld de, vTiles2 + $430
    call CopyGlyphTilesToVRAM
    ret

; shows string wCA2B[wD7F3] of category wCA2C[wD7F3] + 2 at the address in wD7F1/2 with size $0109 (E-0121)
; 2 call sites from 1 routine (e.g. RunF24C3DAnd4D72_Sub01)
; reads: wArg3, wArg1, wArg2
; writes: wStringIndex, wStringCategory, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; points at: wRecordBufB
ShowRecordBufBEntryStringAtArg1::
Func_0F2_4D2B:: ; address name
    ld a, [wArg3]
    ld hl, wRecordBufB
    add_a_to_hl
    ld a, [hl+]
    ld [wStringIndex], a
    ld a, [hl]
    add a, $02
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

; address loaded by RunF24C3DAnd4D72_Sub01
Data_0F2_4D62:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1A, $8E, $1A, $1E, $1C, $99, $1C, $29

; address loaded by RunF24C3DAnd4D72_Sub01
Data_0F2_4D6A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1C, $99, $1C, $29, $1A, $8E, $1A, $1E

; only called from RunF24C3DAnd4D72 (E-0047)
; 1 call site from 1 routine (e.g. RunF24C3DAnd4D72)
; reads: wRecordBufB, hTemp1
; writes: wArg1, wArg5, wArg2, wArg3, wArg4
RunF24C3DAnd4D72_Sub02::
Func_0F2_4D72:: ; address name
    ld a, [wRecordBufB + $D]
    and a, $10
    and a, a
    jr nz, Jump_0F2_4D7F
    ld de, Data_0F2_4E34
    jr Jump_0F2_4D82

Jump_0F2_4D7F::
    ld de, Data_0F2_4E3A

Jump_0F2_4D82::
    ld a, [de]
    push de
    call LoadTemp0WordFromRecordBufB
    pop de
    ldh a, [hTemp1]
    cp a, $FF
    jr nz, Jump_0F2_4D9E
    push de
    ld hl, vTiles1 + $430
    ld de, vTiles2 + $6C0
    call CopyTileBytesToVRAMCounted_BankF2
    pop de
    inc de
    inc de
    inc de
    jr Jump_0F2_4DD4

Jump_0F2_4D9E::
    inc de
    ld a, [de]
    ld [wArg1], a
    inc de
    ld a, [de]
    dec de
    push de
    ld [wArg5], a
    xor a, a
    ld [wArg2], a
    ld a, $6A
    ld [wArg3], a
    ld a, $6C
    ld [wArg4], a
    call DrawSpeciesIconForRecordBufBEntry
    pop de
    call PickNameBufferForFirstByte_BankF2
    inc de
    inc de
    push de
    call BGMapAddressAtScroll_BankF2_514D
    ld de, $006E
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    pop de

Jump_0F2_4DD4::
    ld a, [de]
    push de
    call LoadTemp0WordFromRecordBufB
    pop de
    ldh a, [hTemp1]
    cp a, $FF
    jr nz, Jump_0F2_4DF0
    push de
    ld hl, vTiles1 + $430
    ld de, vTiles2 + $6D0
    call CopyTileBytesToVRAMCounted_BankF2
    pop de
    inc de
    inc de
    inc de
    jr Jump_0F2_4E25

Jump_0F2_4DF0::
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
    ld a, $8A
    ld [wArg3], a
    ld a, $6D
    ld [wArg4], a
    call DrawSpeciesIconForRecordBufBEntry
    pop de
    call PickNameBufferForFirstByte_BankF2
    push de
    call BGMapAddressAtScroll_BankF2_514D
    ld de, $018E
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    pop de

Jump_0F2_4E25::
    ret

; BC = wCCCD when the byte at DE is $98 (the ??? placeholder), else wCDCC (E-0122)
; 2 call sites from 1 routine (e.g. RunF24C3DAnd4D72_Sub02)
; points at: wNameBufAlt, wNameBufUnknown
PickNameBufferForFirstByte_BankF2::
Func_0F2_4E26:: ; address name
    ld a, [de]
    cp a, $98
    jr z, Jump_0F2_4E30
    ld bc, wNameBufAlt
    jr Jump_0F2_4E33

Jump_0F2_4E30::
    ld bc, wNameBufUnknown

Jump_0F2_4E33::
    ret

; address loaded by RunF24C3DAnd4D72_Sub02
Data_0F2_4E34:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1A, $98, $1A, $1C, $A3, $1C

; address loaded by RunF24C3DAnd4D72_Sub02
Data_0F2_4E3A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1C, $A3, $1C, $1A, $98, $1A

; A = byte offset: hFFC6/hFFC7 = the word at wCA2B + A (E-0079)
; 5 call sites from 3 routines (e.g. DrawRecordBufBSpeciesSprites, RunF24C3DAnd4D72_Sub02, RunF24C3DAnd4D72_Sub01)
; writes: hTemp0, hTemp1
; points at: wRecordBufB
LoadTemp0WordFromRecordBufB::
Func_0F2_4E40:: ; address name
    ld de, wRecordBufB
    add a, e
    ld e, a
    jr nc, Jump_0F2_4E48
    inc d

Jump_0F2_4E48::
    ld a, [de]
    ldh [hTemp0], a
    inc de
    ld a, [de]
    ldh [hTemp1], a
    ret

; Copies up to 10 bytes from [HL] to wC8CF, stopping at a $F0 byte, then stores a $F0 terminator (the same 19 bytes appear in 2 banks)
; 5 call sites from 2 routines (e.g. DrawWCA3ANameAtTiles2290, RunF24C3DAnd4D72_Sub01)
; points at: wNameGlyphBuf
CopyShortStringToNameGlyphBuf_BankF2::
Func_0F2_4E50:: ; address name
    ld de, wNameGlyphBuf
    ld c, $0A

Jump_0F2_4E55::
    ld a, [hl+]
    cp a, $F0
    jr z, Jump_0F2_4E5F
    ld [de], a
    inc de
    dec c
    jr nz, Jump_0F2_4E55

Jump_0F2_4E5F::
    ld a, $F0
    ld [de], a
    ret

; HL = VRAM address: writes the 7 bytes at wD7F1 as tiles $E0 + digit to HL onward (WaitForVRAMAccess, interrupts off per byte) (E-0067) (the same 19 bytes appear in 2 banks)
; 2 call sites from 1 routine (e.g. DrawWCA83ExpAndToNextLevel)
; points at: wArg1
DrawSevenDigitsFromArg1_BankF2::
Func_0F2_4E63:: ; address name
    ld de, wArg1
    ld c, $07

Jump_0F2_4E68::
    di
    call WaitForVRAMAccess
    ld a, [de]
    add a, $E0
    ld [hl+], a
    inc de
    ei
    dec c
    jr nz, Jump_0F2_4E68
    ret

; for the three species words of wCA2B (offsets Data_0F2_4F41 or 4F44 by bit 4 of wCA38) decompresses their graphics to the targets in Data_0F2_4ED4 (E-0127)
; 2 call sites from 2 routines (e.g. RunLinkSession5Exchange_Case01_Sub01_Case0D_Case1E, RunScreenStateWhenNotFading_F1_Case0D_Case1E)
; reads: wRecordBufB, hTemp0, hTemp1
; writes: hTemp0, hTemp1, wArg1, wArg2
; points at: wRecordBufB, wArg3
DecompressRecordBufBSpeciesGraphics::
Func_0F2_4E76:: ; address name
    ld c, $00

Jump_0F2_4E78::
    push bc
    ld a, [wRecordBufB + $D]
    and a, $10
    jr nz, Jump_0F2_4E85
    ld de, Data_0F2_4F41
    jr Jump_0F2_4E88

Jump_0F2_4E85::
    ld de, Data_0F2_4F44

Jump_0F2_4E88::
    pop bc
    push bc
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_0F2_4E90
    inc d

Jump_0F2_4E90::
    ld a, [de]
    ld hl, wRecordBufB
    add_a_to_hl
    ld a, [hl+]
    ldh [hTemp0], a
    ld a, [hl]
    ldh [hTemp1], a
    cp a, $FF
    jr z, Jump_0F2_4ECC
    pop bc
    push bc
    ldh a, [hTemp0]
    ld [wArg1], a
    ldh a, [hTemp1]
    ld [wArg2], a
    ld a, c
    ld b, a
    add a, a
    add a, b
    ld de, Data_0F2_4ED4
    add a, e
    ld e, a
    jr nc, Jump_0F2_4EBB
    inc d

Jump_0F2_4EBB::
    ld hl, wArg3
    ld c, $03

Jump_0F2_4EC0::
    ld a, [de]
    ld [hl+], a
    inc de
    dec c
    jr nz, Jump_0F2_4EC0
    farcall DecompressGraphicsArg1ToArg4

Jump_0F2_4ECC::
    pop bc
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_0F2_4E78
    ret

; address loaded by DecompressRecordBufBSpeciesGraphics
Data_0F2_4ED4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $80, $08, $00, $81, $10, $00, $82

; for the three species words of wCA2B draws their sprite parts at the positions in Data_0F2_4F35 (E-0127)
; 4 call sites from 4 routines (e.g. GameMode5_Update_Case02, GameMode5_Update_Case04, RunLinkSession4ScreenState_Case08_Case04, GameMode5_Update_Case05_Sub01)
; reads: wRecordBufB, hTemp1, hTemp0
; writes: hTemp0, wArg1, wArg2
; points at: wArg3
DrawRecordBufBSpeciesSprites::
Func_0F2_4EDD:: ; address name
    ld c, $00

Jump_0F2_4EDF::
    push bc
    ld a, [wRecordBufB + $D]
    ldh [hTemp0], a
    and a, $10
    jr nz, Jump_0F2_4EEE
    ld de, Data_0F2_4F41
    jr Jump_0F2_4EF1

Jump_0F2_4EEE::
    ld de, Data_0F2_4F44

Jump_0F2_4EF1::
    pop bc
    push bc
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_0F2_4EF9
    inc d

Jump_0F2_4EF9::
    ld a, [de]
    call LoadTemp0WordFromRecordBufB
    ldh a, [hTemp1]
    cp a, $FF
    jr z, Jump_0F2_4F2D
    pop bc
    push bc
    ldh a, [hTemp0]
    ld [wArg1], a
    ldh a, [hTemp1]
    ld [wArg2], a
    ld a, c
    add a, a
    add a, a
    ld de, Data_0F2_4F35
    add a, e
    ld e, a
    jr nc, Jump_0F2_4F1A
    inc d

Jump_0F2_4F1A::
    ld hl, wArg3
    ld c, $04

Jump_0F2_4F1F::
    ld a, [de]
    ld [hl+], a
    inc de
    dec c
    jr nz, Jump_0F2_4F1F
    ld c, $00
    farcall DrawMetaSpritePartC0

Jump_0F2_4F2D::
    pop bc
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_0F2_4EDF
    ret

; address loaded by DrawRecordBufBSpeciesSprites
Data_0F2_4F35:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $10, $78, $00, $10, $30, $68, $01, $20, $30, $88, $02

; address loaded by DecompressRecordBufBSpeciesGraphics, DrawRecordBufBSpeciesSprites
Data_0F2_4F41:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0B, $1A, $1C

; address loaded by DecompressRecordBufBSpeciesGraphics, DrawRecordBufBSpeciesSprites
Data_0F2_4F44:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0B, $1C, $1A

; writes the level wCA81 (marked $6F at the cap wCA82), its digits and the status marks from wCA80 into the BG map (E-0129)
; 5 call sites from 5 routines (e.g. DrawRecordBufBStatsScreen, RunLinkSession5Exchange_Case01_Sub01_Case0D_Case16, RunLinkSession5Exchange_Case01_Sub01_Case0D_Case1D, RunScreenStateWhenNotFading_F1_Case0D_Case16, ...)
; reads: hTemp1, hTemp0, wDigits, wRecordBufB
; writes: hTemp0, hTemp1
DrawLevelAndStatusRowForWCA81::
Func_0F2_4F47:: ; address name
    ld hl, wRecordBufB + $56
    ld a, [hl+]
    ldh [hTemp0], a
    ld a, [hl]
    ldh [hTemp1], a
    call BGMapAddressAtScroll_BankF2_514D
    ld de, $0029
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ldh a, [hTemp1]
    ld b, a
    ldh a, [hTemp0]
    cp a, b
    jr c, Jump_0F2_4F6C
    di
    call WaitForVRAMAccess
    ld a, $6F
    ld [hl], a
    ei
    jr Jump_0F2_4F74

Jump_0F2_4F6C::
    di
    call WaitForVRAMAccess
    ld a, $C3
    ld [hl], a
    ei

Jump_0F2_4F74::
    inc hl
    di
    call WaitForVRAMAccess
    ld a, $EA
    ld [hl+], a
    ld a, $ED
    ld [hl+], a
    ei
    push hl
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigits_F
    pop hl
    ld a, [wDigits + $1]
    add a, $E0
    ld e, a
    di
    call WaitForVRAMAccess
    ld [hl], e
    ei
    inc hl
    ld a, [wDigits + $2]
    add a, $E0
    ld e, a
    di
    call WaitForVRAMAccess
    ld [hl], e
    ei
    inc hl
    call WriteThreeC3TilesAtHL_BankF2
    ld a, [wRecordBufB + $55]
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
    ld a, [wRecordBufB + $E]
    and a, $01
    add a, $CC
    ld e, a
    di
    call WaitForVRAMAccess
    ld [hl], e
    ei
    ret

; writes tile $C3 to the 3 VRAM bytes from HL (WaitForVRAMAccess, interrupts off per byte); HL kept; clobbers C, E (E-0067) (the same 17 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. DrawLevelAndStatusRowForWCA81)
WriteThreeC3TilesAtHL_BankF2::
Func_0F2_4FD6:: ; address name
    push hl
    ld e, $C3
    ld c, $03

Jump_0F2_4FDB::
    di
    call WaitForVRAMAccess
    ld [hl], e
    ei
    inc hl
    dec c
    jr nz, Jump_0F2_4FDB
    pop hl
    ret

; writes tile $C1 at VRAM address HL (WaitForVRAMAccess, interrupts off) (E-0067) (the same 9 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. DrawLevelAndStatusRowForWCA81)
WriteTileC1AtHL_BankF2::
Func_0F2_4FE7:: ; address name
    di
    call WaitForVRAMAccess
    ld a, $C1
    ld [hl], a
    ei
    ret

; writes tile $C0 at VRAM address HL (WaitForVRAMAccess, interrupts off) (E-0067) (the same 9 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. DrawLevelAndStatusRowForWCA81)
WriteTileC0AtHL_BankF2::
Func_0F2_4FF0:: ; address name
    di
    call WaitForVRAMAccess
    ld a, $C0
    ld [hl], a
    ei
    ret

; writes tile $C2 at VRAM address HL (WaitForVRAMAccess, interrupts off) (E-0067) (the same 9 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. DrawLevelAndStatusRowForWCA81)
WriteTileC2AtHL_BankF2::
Func_0F2_4FF9:: ; address name
    di
    call WaitForVRAMAccess
    ld a, $C2
    ld [hl], a
    ei
    ret

; runs Func_0F2_4F47, DrawFiveRecordBufBStatsColumn and DrawFourRecordBufBStatsDigits (E-0126)
; 2 call sites from 2 routines (e.g. RunLinkSession5Exchange_Case01_Sub01_Case0D_Case04, RunScreenStateWhenNotFading_F1_Case0D_Case04)
DrawRecordBufBStatsScreen::
Func_0F2_5002:: ; address name
    call DrawLevelAndStatusRowForWCA81
    call DrawFiveRecordBufBStatsColumn
    call DrawFourRecordBufBStatsDigits
    ret

; writes four stat words from wCA2B (offsets Data_0F2_5050) as three digits at the scroll offsets Data_0F2_5054 (E-0125)
; 1 call site from 1 routine (e.g. DrawRecordBufBStatsScreen)
; points at: wRecordBufB
DrawFourRecordBufBStatsDigits::
Func_0F2_500C:: ; address name
    ld c, $00

Jump_0F2_500E::
    push bc
    ld a, c
    ld hl, Data_0F2_5050
    add_a_to_hl
    ld a, [hl]
    ld hl, wRecordBufB
    add_a_to_hl
    ld a, [hl+]
    ld b, a
    ld a, [hl]
    ld h, a
    ld l, b
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigits_F
    pop bc
    ld a, c
    add a, a
    ld hl, Data_0F2_5054
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_BankF2_514D
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    call WriteThreeDigitsAtHL
    inc c
    ld a, c
    cp a, $04
    jr c, Jump_0F2_500E
    ret

; address loaded by DrawFourRecordBufBStatsDigits
Data_0F2_5050:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $5B, $5D, $5F, $61

; address loaded by DrawFourRecordBufBStatsDigits
Data_0F2_5054:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $CC, $01, $D0, $01, $0C, $02, $10, $02

; writes five stat words from wCA2B (offsets Data_0F2_509F) as three digits down a column at scroll + $70 (E-0125)
; 1 call site from 1 routine (e.g. DrawRecordBufBStatsScreen)
; points at: wRecordBufB
DrawFiveRecordBufBStatsColumn::
Func_0F2_505C:: ; address name
    call BGMapAddressAtScroll_BankF2_514D
    ld de, $0070
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld c, $00

Jump_0F2_5068::
    push bc
    push hl
    ld a, c
    ld de, Data_0F2_509F
    add a, e
    ld e, a
    jr nc, Jump_0F2_5073
    inc d

Jump_0F2_5073::
    ld a, [de]
    ld hl, wRecordBufB
    add_a_to_hl
    ld a, [hl+]
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
    cp a, $05
    jr c, Jump_0F2_5068
    ret

; address loaded by DrawFiveRecordBufBStatsColumn
Data_0F2_509F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $63, $65, $67, $69, $6B

; writes wC8C0, wC8C1, wC8C2 as digit tiles ($E0 + n) at HL (E-0121)
; 2 call sites from 2 routines (e.g. DrawFourRecordBufBStatsDigits, DrawFiveRecordBufBStatsColumn)
; reads: wDigits
WriteThreeDigitsAtHL::
Func_0F2_50A4:: ; address name
    di
    call WaitForVRAMAccess
    ld a, [wDigits]
    add a, $E0
    ld [hl+], a
    ei
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $1]
    add a, $E0
    ld [hl+], a
    ei
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl+], a
    ei
    ret

; hFFC6/7 = the word wCA2B[wD7F5], far-calls DrawSpeciesAndFamilyIconForTemp0 and continues at Jump_0F2_50F8 (E-0126)
; 2 call sites from 1 routine (e.g. RunF24C3DAnd4D72_Sub02)
; reads: wArg5, wArg1, wArg2, wArg3, wDigits
; writes: hTemp0, hTemp1
; points at: wRecordBufB
DrawSpeciesIconForRecordBufBEntry::
Func_0F2_50C6:: ; address name
    push bc
    ld hl, wRecordBufB
    ld a, [wArg5]
    add_a_to_hl
    ld a, [hl+]
    ldh [hTemp0], a
    ld a, [hl]
    ldh [hTemp1], a
    farcall DrawSpeciesAndFamilyIconForTemp0
    pop bc
    jp Jump_0F2_50F8

; loads the family icon of wCA38 & $0F into tile wD7F4; the next entry draws tile $1E and the count wCA2B[wD7F1] at the scroll offset wD7F2/3 (E-0127)
; 2 call sites from 2 routines (e.g. RunLinkSession5Exchange_Case01_Sub01_Case0D_Case13, RunScreenStateWhenNotFading_F1_Case0D_Case13)
; reads: wRecordBufB, wArg4, wArg1, wArg2, wArg3, wDigits
; writes: wWorkBuf
; points at: wRecordBufB
DrawFamilyIconAndCountForWCA38::
Func_0F2_50E2:: ; address name
    push bc
    ld a, [wRecordBufB + $D]
    and a, $0F
    ld [wWorkBuf], a
    ld a, [wArg4]
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    pop bc

Jump_0F2_50F8::
    ld a, [wArg1]
    ld hl, wRecordBufB
    add_a_to_hl
    ld a, [hl]
    and a, a
    jr nz, Jump_0F2_5108
    ret

Jump_0F2_5108::
    push af
    call BGMapAddressAtScroll_BankF2_514D
    ld a, [wArg2]
    ld d, a
    ld a, [wArg3]
    ld e, a
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, $1E
    ld [hl+], a
    ei
    pop af
    push hl
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigits_F
    pop hl
    ld a, [wDigits + $1]
    cp a, $E3
    jr z, Jump_0F2_5141
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $1]
    add a, $E0
    ld [hl+], a
    ei

Jump_0F2_5141::
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl+], a
    ei
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 8 call sites from 6 routines (e.g. DrawFourRecordBufBStatsDigits, DrawFiveRecordBufBStatsColumn, DrawWCA83ExpAndToNextLevel, DrawFamilyIconAndCountForWCA38, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_BankF2_514D::
Func_0F2_514D:: ; address name
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

; copies 16 bytes from HL to DE, each written with interrupts off after rSTAT bit 1 clears (the same effect as CopyTileBytesToVRAM, with a counter kept on the stack); HL and DE advance (E-0076)
; 7 call sites from 2 routines (e.g. DrawWCA3ANameAtTiles2290, RunF24C3DAnd4D72_Sub02)
; reads: rSTAT
CopyTileBytesToVRAMCounted_BankF2::
Func_0F2_516E:: ; address name
    ld a, $10

Jump_0F2_5170::
    push af
    di

Jump_0F2_5172::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_0F2_5172
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    pop af
    dec a
    jr nz, Jump_0F2_5170
    ret

; reorders the three bytes wArg5-7 by the permutation MonsterArgOrderTable[wArg2:wArg1] (byte k says where wArg5 + k goes among wArg1-3), then copies the result back to wArg5-7 (E-0171)
; 1 call site from 1 routine (e.g. LibraryMenu_Case10_Case04)
; reads: wArg1, wArg2, wArg3
; writes: wArg5, wArg6, wArg7
; points at: wArg1, wArg5
PermuteArg5To7ByMonster::
Func_0F2_5181:: ; address name
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

Jump_0F2_5196::
    ld a, [hl+]
    ld de, wArg1
    add a, e
    ld e, a
    jr nc, Jump_0F2_519F
    inc d

Jump_0F2_519F::
    push hl
    ld a, b
    ld hl, wArg5
    add_a_to_hl
    ld a, [hl]
    pop hl
    ld [de], a
    inc b
    dec c
    jr nz, Jump_0F2_5196
    ld a, [wArg1]
    ld [wArg5], a
    ld a, [wArg2]
    ld [wArg6], a
    ld a, [wArg3]
    ld [wArg7], a
    ret

; E-0171 (C1: PermuteArg5To7ByMonster reads the 3 bytes at $51C3 + 3 * (wArg2:wArg1), stores wArg5 + k at wArg1 + byte k, then copies wArg1-3 back to wArg5-7; all 384 entries are permutations; the caller, script command $F6 case $10/4, indexes it with the id it shows as a monster name).
; record: destination offsets of wArg5-7 among wArg1-3 (always a permutation of 0, 1, 2)
MonsterArgOrderTable::
Data_0F2_51C3:: ; address name
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

; E-0208 (C1: ReadF2FarPointerForScreenTableIndex (bank $1C) reads the word at $5643 + 2 * wScreenTableIndex; Jump_01C_4AFA adds 3 * entry (after ShopMenu_Shared02) and shows the 24-bit number there in digits (wDigits, Number24ToPackedBCD); the lists run contiguously to ReturnStub_6333; read as prices, which is not confirmed).
; record: list of 24-bit numbers for this wScreenTableIndex
ScreenNumberListTable::
Data_0F2_5643:: ; address name
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

; E-0199 (derived: list for entry $00 of ScreenNumberListTable; it runs to the next list)
; record: 24-bit number
ScreenNumberList000::
Data_0F2_5673:: ; address name
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

; E-0199 (derived: list for entry $01 of ScreenNumberListTable; it runs to the next list)
; record: 24-bit number
ScreenNumberList001::
Data_0F2_577B:: ; address name
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

; E-0199 (derived: list for entry $02 of ScreenNumberListTable; it runs to the next list)
; record: 24-bit number
ScreenNumberList002::
Data_0F2_580B:: ; address name
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

; E-0199 (derived: list for entry $03 of ScreenNumberListTable; it runs to the next list)
; record: 24-bit number
ScreenNumberList003::
Data_0F2_589B:: ; address name
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

; E-0199 (derived: list for entry $04 of ScreenNumberListTable; it runs to the next list)
; record: 24-bit number
ScreenNumberList004::
Data_0F2_592B:: ; address name
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

; E-0199 (derived: list for entry $05 of ScreenNumberListTable; it runs to the next list)
; record: 24-bit number
ScreenNumberList005::
Data_0F2_59BB:: ; address name
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

; E-0199 (derived: list for entry $06 of ScreenNumberListTable; it runs to the next list)
; record: 24-bit number
ScreenNumberList006::
Data_0F2_5A4B:: ; address name
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

; E-0199 (derived: list for entry $07 of ScreenNumberListTable; it runs to the next list)
; record: 24-bit number
ScreenNumberList007::
Data_0F2_5ADB:: ; address name
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

; E-0199 (derived: list for entry $08 of ScreenNumberListTable; it runs to the next list)
; record: 24-bit number
ScreenNumberList008::
Data_0F2_5B6B:: ; address name
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

; E-0199 (derived: list for entry $09 of ScreenNumberListTable; it runs to the next list)
; record: 24-bit number
ScreenNumberList009::
Data_0F2_5BFB:: ; address name
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

; E-0199 (derived: list for entry $0A of ScreenNumberListTable; it runs to the next list)
; record: 24-bit number
ScreenNumberList00A::
Data_0F2_5C8B:: ; address name
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

; E-0199 (derived: list for entry $0B of ScreenNumberListTable; it runs to the next list)
; record: 24-bit number
ScreenNumberList00B::
Data_0F2_5CEB:: ; address name
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

; E-0199 (derived: list for entry $0C of ScreenNumberListTable; it runs to the next list)
; record: 24-bit number
ScreenNumberList00C::
Data_0F2_5D7B:: ; address name
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

; E-0199 (derived: list for entry $0D of ScreenNumberListTable; it runs to the next list)
; record: 24-bit number
ScreenNumberList00D::
Data_0F2_5E0B:: ; address name
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

; E-0199 (derived: list for entry $0E of ScreenNumberListTable; it runs to the next list)
; record: 24-bit number
ScreenNumberList00E::
Data_0F2_5E9B:: ; address name
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

; E-0199 (derived: list for entry $0F of ScreenNumberListTable; it runs to the next list)
; record: 24-bit number
ScreenNumberList00F::
Data_0F2_5F2B:: ; address name
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

; E-0199 (derived: list for entry $10 of ScreenNumberListTable; it runs to the next list)
; record: 24-bit number
ScreenNumberList010::
Data_0F2_5FBB:: ; address name
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

; E-0199 (derived: list for entry $11 of ScreenNumberListTable; it runs to the next list)
; record: 24-bit number
ScreenNumberList011::
Data_0F2_604B:: ; address name
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

; E-0199 (derived: list for entry $12 of ScreenNumberListTable; it runs to the next list)
; record: 24-bit number
ScreenNumberList012::
Data_0F2_60DB:: ; address name
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

; E-0199 (derived: list for entry $13 of ScreenNumberListTable; it runs to the next list)
; record: 24-bit number
ScreenNumberList013::
Data_0F2_616B:: ; address name
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

; E-0199 (derived: list for entry $17 of ScreenNumberListTable; it runs to the next list)
; record: 24-bit number
ScreenNumberList017::
Data_0F2_61FB:: ; address name
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

; a bare ret (E-0116)
; 1 call site from 1 routine (e.g. RunScreenStateWhenNotFading_1B_Case01_Case05)
ReturnStub_6333::
Func_0F2_6333:: ; address name
    ret
    db $CD, $55, $63, $CD, $46, $63, $C9

; only called from KeyAppraisalMenu_Case03_Case05 (E-0047)
; 1 call site from 1 routine (e.g. KeyAppraisalMenu_Case03_Case05)
; writes: wScreenStep
KeyAppraisalMenu_Case03_Case05_Sub01::
Func_0F2_633B:: ; address name
    call KeyAppraisalMenu_Case03_Case05_Sub01_Sub01
    call CopyWD09EToKeyList
    xor a, a
    ld [wScreenStep], a
    ret

; copies $C0 bytes from wD09E to wKeyList (E-0122)
; 1 call site from 1 routine (e.g. KeyAppraisalMenu_Case03_Case05_Sub01)
; points at: wKeyList
CopyWD09EToKeyList::
Func_0F2_6346:: ; address name
    ld hl, wWorkBuf + $1
    ld de, wKeyList
    ld c, $C0

Jump_0F2_634E::
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, Jump_0F2_634E
    ret

; only called from KeyAppraisalMenu_Case03_Case05_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. KeyAppraisalMenu_Case03_Case05_Sub01)
; reads: wWorkBuf
; writes: wKeyGenCount, wWorkBuf
; points at: wKeyList
KeyAppraisalMenu_Case03_Case05_Sub01_Sub01::
Func_0F2_6355:: ; address name
    ld hl, wWorkBuf + $1
    ld c, $C0

Jump_0F2_635A::
    ld a, $FF
    ld [hl+], a
    dec c
    jr nz, Jump_0F2_635A
    xor a, a
    ld [wKeyGenCount], a
    ld a, [wWorkBuf]
    and a, a
    jr nz, Jump_0F2_637F
    ld a, $01
    ld [wWorkBuf], a
    ld hl, wKeyList
    ld de, wWorkBuf + $1
    call KeyAppraisalMenu_Case03_Case05_Sub01_Sub01_Sub02
    ld hl, wKeyList
    call KeyAppraisalMenu_Case03_Case05_Sub01_Sub01_Sub01
    ret

Jump_0F2_637F::
    xor a, a
    ld [wWorkBuf], a
    ld hl, wKeyList
    ld de, wWorkBuf + $1
    call KeyAppraisalMenu_Case03_Case05_Sub01_Sub01_Sub01
    ld hl, wKeyList
    call KeyAppraisalMenu_Case03_Case05_Sub01_Sub01_Sub02
    ret

; only called from KeyAppraisalMenu_Case03_Case05_Sub01_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. KeyAppraisalMenu_Case03_Case05_Sub01_Sub01)
; reads: wKeyGenCount
; writes: wKeyGenCount
; points at: wKeySeeds, wKeyGenList
KeyAppraisalMenu_Case03_Case05_Sub01_Sub01_Sub01::
Func_0F2_6393:: ; address name
    ld b, $00
    ld c, $20

Jump_0F2_6397::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_0F2_63E3
    push hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr z, Jump_0F2_63B0
    pop hl
    push hl
    ld a, [hl]
    and a, $3F
    cp a, $07
    jr nc, Jump_0F2_63B0
    jr Jump_0F2_63E2

Jump_0F2_63B0::
    pop hl
    push hl
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    inc de
    push de
    ld a, b
    add a, a
    ld hl, wKeySeeds
    add_a_to_hl
    ld a, [wKeyGenCount]
    add a, a
    ld de, wKeyGenList
    add a, e
    ld e, a
    jr nc, Jump_0F2_63D5
    inc d

Jump_0F2_63D5::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ld a, [wKeyGenCount]
    inc a
    ld [wKeyGenCount], a
    pop de

Jump_0F2_63E2::
    pop hl

Jump_0F2_63E3::
    ld a, $04
    add_a_to_hl
    inc b
    dec c
    jr nz, Jump_0F2_6397
    ret

; only called from KeyAppraisalMenu_Case03_Case05_Sub01_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. KeyAppraisalMenu_Case03_Case05_Sub01_Sub01)
; reads: wKeyGenCount
; writes: wKeyGenCount
; points at: wKeySeeds, wKeyGenList
KeyAppraisalMenu_Case03_Case05_Sub01_Sub01_Sub02::
Func_0F2_63EF:: ; address name
    ld b, $00
    ld c, $20

Jump_0F2_63F3::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_0F2_63E3
    push hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr z, Jump_0F2_643C
    pop hl
    push hl
    ld a, [hl]
    and a, $3F
    cp a, $07
    jr nc, Jump_0F2_643C
    pop hl
    push hl
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    inc de
    push de
    ld a, b
    add a, a
    ld hl, wKeySeeds
    add_a_to_hl
    ld a, [wKeyGenCount]
    add a, a
    ld de, wKeyGenList
    add a, e
    ld e, a
    jr nc, Jump_0F2_642F
    inc d

Jump_0F2_642F::
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    ld a, [wKeyGenCount]
    inc a
    ld [wKeyGenCount], a
    pop de

Jump_0F2_643C::
    pop hl
    ld a, $04
    add_a_to_hl
    inc b
    dec c
    jr nz, Jump_0F2_63F3
    ret

; in state 3 continues at Jump_0F2_6470; otherwise runs Func_0F2_64C7 (E-0126)
; 3 call sites from 3 routines (e.g. DrawRect0140AtBGMap13E0AndStep, VaultMenu_Case03_Case0B_Sub01, VaultMenu_Case03_Case0E_Sub02)
; reads: wScreenState, wCounterPtr0Lo
; writes: wCounterPtr0Lo
; points at: wWorkBuf, wInventory, wItemGrid
Run64C7UnlessScreenStateIs3::
Func_0F2_6449:: ; address name
    ld a, [wScreenState]
    cp a, $03
    jr z, Jump_0F2_6470
    call Run64C7UnlessScreenStateIs3_Sub01
    ret

; only called from VaultMenu_Case03_Case0E (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Case03_Case0E)
; reads: wCounterPtr0Lo
; points at: wWorkBuf
VaultMenu_Case03_Case0E_Sub03::
Func_0F2_6454:: ; address name
    ld hl, wWorkBuf
    ld b, $18

Jump_0F2_6459::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_0F2_6459
    ld a, [wCounterPtr0Lo]
    and a, a
    jr nz, Jump_0F2_6469
    ld de, ItemOrderListB
    jr Jump_0F2_646C

Jump_0F2_6469::
    ld de, ItemOrderListA

Jump_0F2_646C::
    call VaultMenu_Case03_Case0E_Sub03_Sub01
    ret

Jump_0F2_6470::
    ld hl, wWorkBuf
    ld b, $18

Jump_0F2_6475::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_0F2_6475
    ld a, [wCounterPtr0Lo]
    and a, a
    jr nz, Jump_0F2_6487
    ld de, ItemOrderListA
    ld a, $01
    jr Jump_0F2_648B

Jump_0F2_6487::
    ld de, ItemOrderListB
    xor a, a

Jump_0F2_648B::
    ld [wCounterPtr0Lo], a

; only called from VaultMenu_Case03_Case0E_Sub03 (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Case03_Case0E_Sub03)
; points at: wInventory, wWorkBuf, wItemGrid
VaultMenu_Case03_Case0E_Sub03_Sub01::
Func_0F2_648E:: ; address name
    ld b, $00

Jump_0F2_6490::
    ld a, [de]
    cp a, $FF
    jr z, Jump_0F2_64B8
    ld c, a
    push de
    ld hl, wInventory
    ld d, $18

Jump_0F2_649C::
    ld a, [hl]
    cp a, c
    jr z, Jump_0F2_64A8
    inc hl
    dec d
    jr nz, Jump_0F2_649C

Jump_0F2_64A4::
    pop de
    inc de
    jr Jump_0F2_6490

Jump_0F2_64A8::
    ld e, b
    ld d, $00
    push hl
    ld hl, wWorkBuf
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld a, [hl+]
    ld [de], a
    inc b
    jr Jump_0F2_64A4

Jump_0F2_64B8::
    ld hl, wWorkBuf
    ld de, wItemGrid
    ld b, $18

Jump_0F2_64C0::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_0F2_64C0
    ret

; only called from Run64C7UnlessScreenStateIs3 (E-0047)
; 1 call site from 1 routine (e.g. Run64C7UnlessScreenStateIs3)
; reads: wCounterPtr0Lo
; writes: wCounterPtr0Lo
; points at: wWorkBuf, wItemStorage
Run64C7UnlessScreenStateIs3_Sub01::
Func_0F2_64C7:: ; address name
    ld hl, wWorkBuf
    ld b, $C8

Jump_0F2_64CC::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_0F2_64CC
    ld a, [wCounterPtr0Lo]
    and a, a
    jr nz, Jump_0F2_64DE
    ld de, ItemOrderListA
    ld a, $01
    jr Jump_0F2_64E2

Jump_0F2_64DE::
    ld de, ItemOrderListB
    xor a, a

Jump_0F2_64E2::
    ld [wCounterPtr0Lo], a
    ld b, $00

Jump_0F2_64E7::
    ld a, [de]
    cp a, $FF
    jr z, Jump_0F2_6517
    ld c, a
    push de
    ld hl, wItemStorage
    ld d, $64

Jump_0F2_64F3::
    ld a, [hl]
    cp a, c
    jr z, Jump_0F2_6500
    inc hl
    inc hl
    dec d
    jr nz, Jump_0F2_64F3

Jump_0F2_64FC::
    pop de
    inc de
    jr Jump_0F2_64E7

Jump_0F2_6500::
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
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc b
    jr Jump_0F2_64FC

Jump_0F2_6517::
    ld hl, wWorkBuf
    ld de, wItemStorage
    ld b, $C8

Jump_0F2_651F::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_0F2_651F
    ret

; E-0237 (C1: passed in DE (when wCounterPtr0Lo is not zero at one of the two choices) to VaultMenu_Case03_Case0E_Sub03_Sub01, which walks the list up to $FF and, for each byte found among the 24 wInventory bytes, appends that inventory byte to wWorkBuf; 95 item numbers and $FF).
; record: item numbers in order, $FF ends the list
ItemOrderListA::
Data_0F2_6526:: ; address name
    db $21, $28, $29, $2A, $2E, $1F, $20, $2B, $01, $02, $03, $04 ; id 0
    db $05, $06, $07, $08, $09, $0A, $0B, $0C, $19, $1A, $1B, $1C ; id 1
    db $1D, $1E, $13, $14, $15, $16, $17, $18, $0D, $0E, $0F, $10 ; id 2
    db $11, $12, $2C, $2D, $40, $41, $42, $43, $44, $45, $46, $47 ; id 3
    db $48, $49, $4A, $4B, $4C, $4D, $4E, $4F, $50, $51, $52, $53 ; id 4
    db $54, $55, $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F ; id 5
    db $60, $61, $62, $22, $23, $24, $25, $26, $27, $30, $31, $32 ; id 6
    db $33, $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $FF ; id 7

; E-0237 (C1: passed in DE (when wCounterPtr0Lo is zero at one of the two choices) to VaultMenu_Case03_Case0E_Sub03_Sub01, which walks the list up to $FF and, for each byte found among the 24 wInventory bytes, appends that inventory byte to wWorkBuf; 95 item numbers and $FF).
; record: item numbers in order, $FF ends the list
ItemOrderListB::
Data_0F2_6586:: ; address name
    db $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C ; id 0
    db $22, $23, $24, $25, $26, $27, $19, $1A, $1B, $1C, $1D, $1E ; id 1
    db $13, $14, $15, $16, $17, $18, $0D, $0E, $0F, $10, $11, $12 ; id 2
    db $2C, $2D, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49 ; id 3
    db $4A, $4B, $4C, $4D, $4E, $4F, $50, $51, $52, $53, $54, $55 ; id 4
    db $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F, $60, $61 ; id 5
    db $62, $21, $28, $29, $2A, $2E, $1F, $20, $2B, $30, $31, $32 ; id 6
    db $33, $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $FF ; id 7

; for each party record sets HP (field $5B) and MP (field $5F) down to their maxima when they exceed them (E-0129)
; 2 call sites from 2 routines (e.g. RunBattlePhaseWhenTextIdle_A0_Case03_Case00_Sub01, BattleEnd_Step7_Case02_Sub01)
; reads: wPartyCount, wCounterPtr0Lo, wCounterPtr0Hi
; writes: wCounterPtr0Lo, wCounterPtr0Hi
; points at: wPartyList
ClampPartyHPAndMPToMax::
Func_0F2_65E6:: ; address name
    ld a, [wPartyCount]
    and a, a
    ret z
    ld b, a
    ld hl, wPartyList

Jump_0F2_65EF::
    push bc
    push hl
    ld a, [hl]
    ld c, $5B
    call SRAMRecordAddress
    ld a, [hl+]
    ld [wCounterPtr0Lo], a
    ld a, [hl]
    ld [wCounterPtr0Hi], a
    pop hl
    push hl
    ld a, [hl]
    ld c, $5D
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
    and a, a
    jr nz, Jump_0F2_6632
    pop hl
    push hl
    ld a, [hl]
    ld c, $5B
    call SRAMRecordAddress
    ld a, [wCounterPtr0Lo]
    ld [hl+], a
    ld a, [wCounterPtr0Hi]
    ld [hl], a

Jump_0F2_6632::
    pop hl
    push hl
    ld a, [hl]
    ld c, $5F
    call SRAMRecordAddress
    ld a, [hl+]
    ld [wCounterPtr0Lo], a
    ld a, [hl]
    ld [wCounterPtr0Hi], a
    pop hl
    push hl
    ld a, [hl]
    ld c, $61
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
    and a, a
    jr nz, Jump_0F2_6675
    pop hl
    push hl
    ld a, [hl]
    ld c, $5F
    call SRAMRecordAddress
    ld a, [wCounterPtr0Lo]
    ld [hl+], a
    ld a, [wCounterPtr0Hi]
    ld [hl], a

Jump_0F2_6675::
    pop hl
    inc hl
    pop bc
    dec b
    jp nz, Jump_0F2_65EF
    ret

; the same 21 bytes as CompareHLWithDE (F0:7C81)
; 2 call sites from 1 routine (e.g. ClampPartyHPAndMPToMax)
CompareHLWithDE_BankF2::
Func_0F2_667D:: ; address name
    ld a, h
    cp a, d
    jr c, Jump_0F2_668C
    jr nz, Jump_0F2_6689
    ld a, l
    cp a, e
    jr c, Jump_0F2_668C
    jr z, Jump_0F2_668F

Jump_0F2_6689::
    ld c, $FF
    ret

Jump_0F2_668C::
    ld c, $00
    ret

Jump_0F2_668F::
    ld c, $01
    ret

; only called from DispatchTalkEvent_Case01_Case65 (E-0047)
; 1 call site from 1 routine (e.g. DispatchTalkEvent_Case01_Case65)
; points at: wArenaEntry
DispatchTalkEvent_Case01_Case65_Sub01::
Func_0F2_6692:: ; address name
    ld hl, wArenaEntry
    ld bc, $020F

Jump_0F2_6698::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0F2_6698
    ret
    ds $1960, $00
