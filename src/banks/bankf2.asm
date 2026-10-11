SECTION "Bank F2", ROMX[$4000], BANK[$F2]
    db $F2

; start-up for wGameMode = 8; forcing this mode on the emulator shows: egg-received dialogue when forced (E-0029)
; 1 call site from 1 routine (e.g. RunGameModeInit_Case08)
; reads: wSaveStep, wC8CB
; writes: wSaveStep, wSaveRecordIndex, hScrollY, hScrollX, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, ...
; points at: wD780
GameMode8_Init::
Func_0F2_4001:: ; address name
    ld hl, wD780
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
    ld de, Data_046_4001
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
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ld a, $00
    ldh [hSpriteWindowClipMode], a

Jump_0F2_4075::
    farcall StepTextWindowOpenClose
    ld a, [wC8CB]
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
; 1 call site from 1 routine (e.g. RunGameModeUpdate_Case08)
; reads: wFadeState, wD782, wTextFlags
GameMode8_Update::
Func_0F2_40A2:: ; address name
    ld a, [wFadeState]
    and a, a
    ret nz
    ld a, [wD782]
    and a, a
    jr z, Jump_0F2_40B0
    call GameMode8_Update_Sub01

Jump_0F2_40B0::
    ld a, [wTextFlags]
    and a, a
    ret nz
    ld a, [wD782]
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
; reads: wD782
; writes: wD782
GameMode8_Update_Case00::
Jump_0F2_40D5:: ; address name
    call GameMode8_Update_Case00_Sub01
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 1 of the `rst $00` table in GameMode8_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD783, wD782
; writes: wD783, wD782
GameMode8_Update_Case01::
Jump_0F2_40E0:: ; address name
    ld a, [wD783]
    inc a
    ld [wD783], a
    cp a, $10
    ret c
    xor a, a
    ld [wD783], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 2 of the `rst $00` table in GameMode8_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wCB98, wCB9A, wCB9C, wD782
; writes: wCB9A, wCB9C, wD782
GameMode8_Update_Case02::
Jump_0F2_40F6:: ; address name
    ld a, [wCB98]
    and a, $03
    and a, a
    ret z
    ld a, [wCB9A]
    dec a
    ld [wCB9A], a
    cp a, $59
    ret nc
    ld a, $58
    ld [wCB9A], a
    ld a, [wCB9C]
    set 1, a
    ld [wCB9C], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 4 of the `rst $00` table in GameMode8_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD782
; writes: wCBCF, wD7F1, wD782
GameMode8_Update_Case04::
Jump_0F2_411C:: ; address name
    ld a, $80
    ld [wCBCF], a
    ld a, $01
    ld [wD7F1], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 5 of the `rst $00` table in GameMode8_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wCB88, wCB8A, wCB8C, wD782
; writes: wCB8A, wCB8C, wD782
GameMode8_Update_Case05::
Jump_0F2_412E:: ; address name
    ld a, [wCB88]
    and a, $03
    and a, a
    ret z
    ld a, [wCB8A]
    inc a
    ld [wCB8A], a
    cp a, $38
    ret nz
    ld a, [wCB8C]
    set 1, a
    ld [wCB8C], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 8 of the `rst $00` table in GameMode8_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wD782
; writes: wCBCF, wD7F1, wD782
GameMode8_Update_Case08::
Jump_0F2_414F:: ; address name
    ld a, $00
    ld [wCBCF], a
    ld [wD7F1], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 11 of the `rst $00` table in GameMode8_Update
; no direct call (reached through a table, a jump or a vector)
; reads: wCB8C, wCB88, wCB8A, wD782
; writes: wCB8C, wCB86, wCB8A, wD782
GameMode8_Update_Case0B::
Jump_0F2_415F:: ; address name
    ld a, [wCB8C]
    res 1, a
    ld [wCB8C], a
    ld a, $03
    ld [wCB86], a
    ld a, [wCB88]
    and a, $03
    and a, a
    ret z
    ld a, [wCB8A]
    dec a
    ld [wCB8A], a
    cp a, $E0
    ret nz
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; entry 12 of the `rst $00` table in GameMode8_Update
; no direct call (reached through a table, a jump or a vector)
; writes: wStringIndex, wStringCategory
; points at: wPlayerName, wTextBuf0, wCADB, wC8CF, wTextBuf1, wD782
GameMode8_Update_Case0C::
Jump_0F2_4185:: ; address name
    ld hl, wPlayerName
    ld de, wTextBuf0
    ld c, $0A
    call GameMode8_Update_Case0C_Sub01
    ld de, wCADB
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call CopyMonsterNameToBuffer_BF2
    ld hl, wC8CF
    ld de, wTextBuf1
    ld c, $10
    call GameMode8_Update_Case0C_Sub01
    ld a, $0E
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_BankF0_48A0
    ld hl, wD782
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
; points at: wC8CF
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
    ld hl, wC8CF
    ld b, $08
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; clears the default window, wC8CB = 1, wC8CC = 0, hFFB9 = 2, then repeatedly far-calls Func_002_69D0 until wC8CB & 3 = 0 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wC8CB
; writes: wC8CB, wC8CC, hSpriteWindowClipMode
RunTextUntilWC8CBDone_BankF2:: ; heuristic: follows a terminator; C0
Func_0F2_4202:: ; address name
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    ld a, $01
    ld [wC8CB], a
    ld a, $00
    ld [wC8CC], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a

Jump_0F2_4219::
    farcall StepTextWindowOpenClose
    ld a, [wC8CB]
    and a, $03
    jr nz, Jump_0F2_4219
    ret

; only called from GameMode8_Update_Case0D (E-0047)
; 1 call site from 1 routine (e.g. GameMode8_Update_Case0D)
; writes: wC94B, wGameMode, wModeState, wModeChangeRequest
; points at: wD780
GameMode8_Update_Case0D_Sub01::
Func_0F2_4227:: ; address name
    ld hl, wD780
    ld bc, $006F

Jump_0F2_422D::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_0F2_422D
    xor a, a
    ld [wC94B], a
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
; writes: hTemp0, wCBCF, wCBD3, wCBD4, wSpriteSlotCount, wOBJPaletteUploadRequest
; points at: wSpriteSlots, wCB8F, hTemp0
GameMode8_Update_Case00_Sub01::
Func_0F2_4248:: ; address name
    ld de, $0000
    call TestFlagBit
    jr c, Jump_0F2_4255
    ld hl, Data_0F2_42FE
    jr Jump_0F2_4258

Jump_0F2_4255::
    ld hl, Data_0F2_430E

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
    ld hl, Data_0F2_432E

Jump_0F2_426E::
    ld de, wCB8F
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
    farcall DecompressGraphicsHFFC6ToHFFCA
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
    farcall DecompressGraphicsHFFC6ToHFFCA
    ld a, $0D
    ldh [hTemp0], a
    farcall RunFieldCommandHFFC6
    xor a, a
    ld [wCBCF], a
    ld a, $48
    ld [wCBD3], a
    ld a, $40
    ld [wCBD4], a
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

Data_0F2_42E0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $01, $04, $00, $80

Data_0F2_42E6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $00, $01, $01, $00, $80

Data_0F2_42EC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0C, $00, $01, $05, $00, $81

Data_0F2_42F2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0C, $00, $01, $05, $00, $81, $00, $00, $00, $02, $00, $82

Data_0F2_42FE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $00, $00, $F0, $40, $04, $01, $00, $00, $00, $F0, $40, $04, $00, $00

Data_0F2_430E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $01, $00, $F0, $40, $01, $01, $00, $00, $00, $F0, $40, $04, $00, $00

Data_0F2_431E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $0C, $00, $F0, $40, $05, $03, $10, $00, $00, $F0, $40, $04, $00, $00

Data_0F2_432E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $01, $0C, $00, $F0, $40, $05, $03, $10, $00, $00, $F0, $40, $04, $00, $00
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
; points at: wScreenTileBuffer, wD000
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
    ld hl, wD000
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
; 2 call sites from 2 routines (e.g. ShowString_BankF2, DebugMessageTest_Update_Case1E)
BeginStringDisplay_BankF2::
Func_0F2_43D0:: ; address name
    ld de, Data_0F2_43E5
    call BeginStringDisplay
    ret
    db $11, $E5, $43, $CD, $FE, $25, $C9

; Func_0F2_43D0 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
; 2 call sites from 2 routines (e.g. ScriptCommandEF_Run_Case0F_Case07, ScriptCommandF0_Run_Case06_Case03)
ShowString_BankF2::
Func_0F2_43DE:: ; address name
    call BeginStringDisplay_BankF2
    call RunStringDisplayToEnd
    ret

Data_0F2_43E5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_0F2_43E7

Data_0F2_43E7:: ; heuristic: target of a monotone pointer table; C0
    dw Data_0F2_442F
    dw Data_0F2_442F
    dw Data_0F2_444E
    dw Data_0F2_446E
    dw Data_0F2_448F
    dw Data_0F2_44AC
    dw Data_0F2_44CF
    dw Data_0F2_44EF
    dw Data_0F2_450C
    dw Data_0F2_452D
    dw Data_0F2_458F
    dw Data_0F2_45C3
    dw Data_0F2_45E6
    dw Data_0F2_460A
    dw Data_0F2_462D
    dw Data_0F2_4653
    dw Data_0F2_4677
    dw Data_0F2_4698
    dw Data_0F2_46BC
    dw Data_0F2_46E2
    dw Data_0F2_470A
    dw Data_0F2_472F
    dw Data_0F2_4753
    dw Data_0F2_477A
    dw Data_0F2_479A
    dw Data_0F2_47BE
    dw Data_0F2_47E4
    dw Data_0F2_4805
    dw Data_0F2_4823
    dw Data_0F2_4843
    dw Data_0F2_488A
    dw Data_0F2_488A
    dw Data_0F2_488A
    dw Data_0F2_488A
    dw Data_0F2_48AC
    dw Data_0F2_48D1

Data_0F2_442F:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Hello, how may I", $F1
    db "serve you?", $F0

Data_0F2_444E:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Which egg should", $F1
    db "I appraise?", $F0

Data_0F2_446E:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It will cost", $F1
    db "20G. It that OK?", $F0

Data_0F2_448F:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " How else may I", $F1
    db "serve you?", $F0

Data_0F2_44AC:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Um", $A4, " You don't", $F1
    db "have enough gold", $A4, $F7
    db $F0

Data_0F2_44CF:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Um", $A4, " You don't", $F1
    db "have any eggs", $A4, $F7
    db $F0

Data_0F2_44EF:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Which egg should", $F1
    db "I bless?", $F0

Data_0F2_450C:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It will cost", $F1
    db $F9, "0G. Is that OK?", $F0

Data_0F2_452D:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Egg, egg, toss", $F1
    db "and scramble", $A4
    db $E5, $00, $E4, $D2, $FA, $F7, $EF, $EE, $E9, $FF
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "There", $A4, $EF, $EE, "That did it.", $FA, $F7
    db $EF, $EE, "You just have to", $EF, $EE, "hatch it now.", $F7
    db $F0

Data_0F2_458F:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Please come see", $F1
    db "me when you get", $FA, $F7
    db $EF, $EE, "more eggs.", $EF, $EE, $F7
    db $F0

Data_0F2_45C3:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " OK, I'll evaluate", $F1
    db "this egg now", $A4, $F7
    db $F0

Data_0F2_45E6:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It's fine. There's", $F1
    db "nothing wrong.", $F7
    db $F0

Data_0F2_460A:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It's good, and", $F1
    db "growing healthy.", $F7
    db $F0

Data_0F2_462D:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Wow, this egg is", $F1
    db "really vigorous.", $F7
    db $F0

Data_0F2_4653:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Oh, my! This egg", $F1
    db "is incredible!", $F7
    db $F0

Data_0F2_4677:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Don't expect too", $F1
    db "many skills.", $F7
    db $F0

Data_0F2_4698:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It has a fair", $F1
    db "number of skills.", $F7
    db $F0

Data_0F2_46BC:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It inherited its", $F1
    db "parents", $95, " skills.", $F7
    db $F0

Data_0F2_46E2:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It knows a great", $F1
    db "variety of skills!", $F7
    db $F0

Data_0F2_470A:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Its growth may", $F1
    db "be a bit wanting.", $F7
    db $F0

Data_0F2_472F:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It will grow in", $F1
    db "an average way.", $F7
    db $F0

Data_0F2_4753:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It will be hard", $F1
    db "to raise a little", $A4, $F7
    db $F0

Data_0F2_477A:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Its growth can't", $F1
    db "be faulted.", $F7
    db $F0

Data_0F2_479A:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It appears to be", $F1
    db "a hard worker.", $F7
    db $F0

Data_0F2_47BE:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " This one seems", $F1
    db "to be quite smart.", $F7
    db $F0

Data_0F2_47E4:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I can tell this", $F1
    db "one is kind.", $F7
    db $F0

Data_0F2_4805:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " No doubt at", $F1
    db "all-it's male.", $F7
    db $F0

Data_0F2_4823:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " No doubt at", $F1
    db "all-it's female.", $F7
    db $F0

Data_0F2_4843:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " That's the best", $F1
    db "I could do now.", $FA, $F7
    db $EF, $EE, "Um", $A4, " I hope I was", $EF, $EE, "useful to you.", $F7
    db $F0

Data_0F2_488A:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Should I change", $F1
    db "someone's name?", $F0

Data_0F2_48AC:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Come here for", $F1
    db "renaming monsters.", $F7
    db $F0

Data_0F2_48D1:: ; heuristic: target of a monotone pointer table; C0
    db $EB, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Pick the monster", $F1
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
; 4 call sites from 4 routines (e.g. Func_037_4AFD_Case0D_Case01, Func_037_4AFD_Case0D_Case1C, RunWD780StateWhenNotFading_F1_Case0D_Case01, RunWD780StateWhenNotFading_F1_Case0D_Case1C)
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
    ld de, Data_01F_4510
    ld hl, vTiles1 + $6E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4450
    ld hl, vTiles1 + $6F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; clears five tiles at vTiles2 + $290 (copying $2940) and draws the name at wCA3A there (E-0121)
; 1 call site from 1 routine (e.g. ShowPersonalityNameAndWCA3AName)
; writes: wC8D9
; points at: wCA3A
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
    ld hl, wCA3A
    call CopyShortStringToWC8CF_BankF2
    ld de, vTiles2 + $290
    ld a, $F0
    ld [wC8D9], a
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
; reads: wCA9A, wCA9D, wCA9B
CombinedPersonalityLevelIndex::
Func_0F2_4AD3:: ; address name
    ld a, [wCA9A]
    call PersonalityLevelOfA
    ld a, $09
    call Multiply8
    ld b, l
    ld a, [wCA9D]
    call PersonalityLevelOfA
    ld a, c
    add a, a
    add a, c
    add a, b
    ld b, a
    ld a, [wCA9B]
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
; 2 call sites from 2 routines (e.g. Func_037_4AFD_Case0D_Case12, RunWD780StateWhenNotFading_F1_Case0D_Case12)
ShowPersonalityNameAndWCA3AName::
Func_0F2_4AFE:: ; address name
    call ShowCombinedPersonalityName
    call DrawWCA3ANameAtTiles2290
    ret

; writes the EXP wCA83-wCA85 as seven digits and, below the level cap, the EXP still needed for the next level (E-0129)
; 2 call sites from 2 routines (e.g. Func_037_4AFD_Case0D_Case13, RunWD780StateWhenNotFading_F1_Case0D_Case13)
; reads: wCA83, wCA84, wCA85, wCA81, wCA82, hTemp0, wCA36, wCA37, ...
; writes: wDigits, hTemp0, hTemp1, wSpeciesIdLo, wSpeciesIdHi, hTemp2, wD7F1, wD7F2, ...
; points at: hTemp2
DrawWCA83ExpAndToNextLevel::
Func_0F2_4B05:: ; address name
    ld a, [wCA83]
    ld [wDigits], a
    ld a, [wCA84]
    ld [wDigits + $1], a
    ld a, [wCA85]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    farcall UnpackBCDToDigitsWD7F1_Bank1E
    call BGMapAddressAtScroll_BankF2_514D
    ld de, $018C
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    call DrawSevenDigitsFromWD7F1_BankF2
    ld a, [wCA81]
    ldh [hTemp0], a
    ld a, [wCA82]
    ldh [hTemp1], a
    ld b, a
    ldh a, [hTemp0]
    cp a, b
    jp nc, Jump_0F2_4BB6
    ldh a, [hTemp0]
    ld b, a
    push bc
    ld a, [wCA36]
    ld [wSpeciesIdLo], a
    ld a, [wCA37]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wD00F]
    ldh [hTemp0], a
    pop bc
    ld a, b
    ldh [hTemp1], a
    farcall LoadTable4E60EntryToHFFC8
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
    ld a, [wCA83]
    ldh [hTemp0], a
    ld a, [wCA84]
    ldh [hTemp1], a
    ld a, [wCA85]
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
    farcall UnpackBCDToDigitsWD7F1_Bank1E

Jump_0F2_4BA8::
    call BGMapAddressAtScroll_BankF2_514D
    ld de, $020C
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    call DrawSevenDigitsFromWD7F1_BankF2
    ret

Jump_0F2_4BB6::
    ld a, $E3
    ld [wD7F1], a
    ld [wD7F2], a
    ld [wD7F3], a
    ld [wD7F4], a
    ld [wD7F5], a
    ld [wD7F6], a
    xor a, a
    ld [wD7F7], a
    jr Jump_0F2_4BA8

; shows string wCACF of category $0B (ShowString_Bank08) at vTiles2 + $320 with size $0206 (E-0121)
; 2 call sites from 2 routines (e.g. Func_037_4AFD_Case0D_Case14, RunWD780StateWhenNotFading_F1_Case0D_Case14)
; reads: wCACF
; writes: wStringIndex, wStringCategory, rRAMG2, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ShowWCACFCategory11StringAtTiles2320::
Func_0F2_4BD0:: ; address name
    ld a, [wCACF]
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
; 2 call sites from 2 routines (e.g. Func_037_4AFD_Case0D_Case1A, RunWD780StateWhenNotFading_F1_Case0D_Case1A)
; reads: wCA36, wCA37, wD013
; writes: wSpeciesIdLo, wSpeciesIdHi, wStringIndex, wStringCategory, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
ShowSpeciesCategory13StringAtTiles2680::
Func_0F2_4BFC:: ; address name
    ld a, [wCA36]
    ld [wSpeciesIdLo], a
    ld a, [wCA37]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wD013]
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
; 2 call sites from 2 routines (e.g. Func_037_4AFD_Case0D_Case1F, RunWD780StateWhenNotFading_F1_Case0D_Case1F)
RunF24C3DAnd4D72::
Func_0F2_4C36:: ; address name
    call RunF24C3DAnd4D72_Sub01
    call RunF24C3DAnd4D72_Sub02
    ret

; only called from RunF24C3DAnd4D72 (E-0047)
; 1 call site from 1 routine (e.g. RunF24C3DAnd4D72)
; reads: wCA38, hTemp1
; writes: wC8CF, wC8D0, wC8D1, wC8D2, wD7F1, wD7F2, wD7F3
; points at: wCA2B
RunF24C3DAnd4D72_Sub01::
Func_0F2_4C3D:: ; address name
    ld a, [wCA38]
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
    call LoadHFFC6WordFromWCA2B
    pop de
    ldh a, [hTemp1]
    cp a, $FF
    jr nz, Jump_0F2_4C7E
    ld a, $98
    ld [wC8CF], a
    ld a, $98
    ld [wC8D0], a
    ld a, $98
    ld [wC8D1], a
    ld a, $F0
    ld [wC8D2], a
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
    ld hl, wCA2B
    add_a_to_hl
    call CopyShortStringToWC8CF_BankF2
    ld de, vTiles2 + $200
    call CopyGlyphTilesToVRAM
    pop de
    ld a, $92
    ld [wD7F1], a
    ld a, $50
    ld [wD7F2], a
    ld a, [de]
    inc de
    push de
    ld [wD7F3], a
    call ShowWCA2BEntryStringAtWD7F1
    pop de

Jump_0F2_4CA8::
    ld a, [de]
    inc de
    push de
    ld hl, wCA2B
    add_a_to_hl
    call CopyShortStringToWC8CF_BankF2
    ld de, vTiles2 + $2F0
    call CopyGlyphTilesToVRAM
    pop de
    ld a, [de]
    push de
    call LoadHFFC6WordFromWCA2B
    pop de
    ldh a, [hTemp1]
    cp a, $FF
    jr nz, Jump_0F2_4CEE
    ld a, $98
    ld [wC8CF], a
    ld a, $98
    ld [wC8D0], a
    ld a, $98
    ld [wC8D1], a
    ld a, $F0
    ld [wC8D2], a
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
    ld hl, wCA2B
    add_a_to_hl
    call CopyShortStringToWC8CF_BankF2
    ld de, vTiles2 + $340
    call CopyGlyphTilesToVRAM
    pop de
    ld a, $93
    ld [wD7F1], a
    ld a, $90
    ld [wD7F2], a
    ld a, [de]
    inc de
    push de
    ld [wD7F3], a
    call ShowWCA2BEntryStringAtWD7F1
    pop de

Jump_0F2_4D18::
    ld a, [de]
    ld hl, wCA2B
    add_a_to_hl
    call CopyShortStringToWC8CF_BankF2
    ld de, vTiles2 + $430
    call CopyGlyphTilesToVRAM
    ret

; shows string wCA2B[wD7F3] of category wCA2C[wD7F3] + 2 at the address in wD7F1/2 with size $0109 (E-0121)
; 2 call sites from 1 routine (e.g. RunF24C3DAnd4D72_Sub01)
; reads: wD7F3, wD7F1, wD7F2
; writes: wStringIndex, wStringCategory, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; points at: wCA2B
ShowWCA2BEntryStringAtWD7F1::
Func_0F2_4D2B:: ; address name
    ld a, [wD7F3]
    ld hl, wCA2B
    add_a_to_hl
    ld a, [hl+]
    ld [wStringIndex], a
    ld a, [hl]
    add a, $02
    ld [wStringCategory], a
    ld a, [wD7F1]
    ld h, a
    ld a, [wD7F2]
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

Data_0F2_4D62:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1A, $8E, $1A, $1E, $1C, $99, $1C, $29

Data_0F2_4D6A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1C, $99, $1C, $29, $1A, $8E, $1A, $1E

; only called from RunF24C3DAnd4D72 (E-0047)
; 1 call site from 1 routine (e.g. RunF24C3DAnd4D72)
; reads: wCA38, hTemp1
; writes: wD7F1, wD7F5, wD7F2, wD7F3, wD7F4
RunF24C3DAnd4D72_Sub02::
Func_0F2_4D72:: ; address name
    ld a, [wCA38]
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
    call LoadHFFC6WordFromWCA2B
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
    ld [wD7F1], a
    inc de
    ld a, [de]
    dec de
    push de
    ld [wD7F5], a
    xor a, a
    ld [wD7F2], a
    ld a, $6A
    ld [wD7F3], a
    ld a, $6C
    ld [wD7F4], a
    call DrawSpeciesIconForWCA2BEntry
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
    call LoadHFFC6WordFromWCA2B
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
    ld [wD7F1], a
    inc de
    ld a, [de]
    dec de
    push de
    ld [wD7F5], a
    ld a, $01
    ld [wD7F2], a
    ld a, $8A
    ld [wD7F3], a
    ld a, $6D
    ld [wD7F4], a
    call DrawSpeciesIconForWCA2BEntry
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
; points at: wCDCC, wCCCD
PickNameBufferForFirstByte_BankF2::
Func_0F2_4E26:: ; address name
    ld a, [de]
    cp a, $98
    jr z, Jump_0F2_4E30
    ld bc, wCDCC
    jr Jump_0F2_4E33

Jump_0F2_4E30::
    ld bc, wCCCD

Jump_0F2_4E33::
    ret

Data_0F2_4E34:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1A, $98, $1A, $1C, $A3, $1C

Data_0F2_4E3A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $1C, $A3, $1C, $1A, $98, $1A

; A = byte offset: hFFC6/hFFC7 = the word at wCA2B + A (E-0079)
; 5 call sites from 3 routines (e.g. DrawWCA2BSpeciesSprites, RunF24C3DAnd4D72_Sub02, RunF24C3DAnd4D72_Sub01)
; writes: hTemp0, hTemp1
; points at: wCA2B
LoadHFFC6WordFromWCA2B::
Func_0F2_4E40:: ; address name
    ld de, wCA2B
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
; points at: wC8CF
CopyShortStringToWC8CF_BankF2::
Func_0F2_4E50:: ; address name
    ld de, wC8CF
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
; points at: wD7F1
DrawSevenDigitsFromWD7F1_BankF2::
Func_0F2_4E63:: ; address name
    ld de, wD7F1
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
; 2 call sites from 2 routines (e.g. Func_037_4AFD_Case0D_Case1E, RunWD780StateWhenNotFading_F1_Case0D_Case1E)
; reads: wCA38, hTemp0, hTemp1
; writes: hTemp0, hTemp1, wD7F1, wD7F2
; points at: wCA2B, wD7F3
DecompressWCA2BSpeciesGraphics::
Func_0F2_4E76:: ; address name
    ld c, $00

Jump_0F2_4E78::
    push bc
    ld a, [wCA38]
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
    ld hl, wCA2B
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
    ld [wD7F1], a
    ldh a, [hTemp1]
    ld [wD7F2], a
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
    ld hl, wD7F3
    ld c, $03

Jump_0F2_4EC0::
    ld a, [de]
    ld [hl+], a
    inc de
    dec c
    jr nz, Jump_0F2_4EC0
    farcall DecompressGraphicsWD7F1ToWD7F4

Jump_0F2_4ECC::
    pop bc
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_0F2_4E78
    ret

Data_0F2_4ED4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $80, $08, $00, $81, $10, $00, $82

; for the three species words of wCA2B draws their sprite parts at the positions in Data_0F2_4F35 (E-0127)
; 4 call sites from 4 routines (e.g. GameMode5_Update_Case02, GameMode5_Update_Case04, RunWD06AState_6C12_Case08_Case04, GameMode5_Update_Case05_Sub01)
; reads: wCA38, hTemp1, hTemp0
; writes: hTemp0, wD7F1, wD7F2
; points at: wD7F3
DrawWCA2BSpeciesSprites::
Func_0F2_4EDD:: ; address name
    ld c, $00

Jump_0F2_4EDF::
    push bc
    ld a, [wCA38]
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
    call LoadHFFC6WordFromWCA2B
    ldh a, [hTemp1]
    cp a, $FF
    jr z, Jump_0F2_4F2D
    pop bc
    push bc
    ldh a, [hTemp0]
    ld [wD7F1], a
    ldh a, [hTemp1]
    ld [wD7F2], a
    ld a, c
    add a, a
    add a, a
    ld de, Data_0F2_4F35
    add a, e
    ld e, a
    jr nc, Jump_0F2_4F1A
    inc d

Jump_0F2_4F1A::
    ld hl, wD7F3
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

Data_0F2_4F35:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $10, $78, $00, $10, $30, $68, $01, $20, $30, $88, $02

Data_0F2_4F41:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0B, $1A, $1C

Data_0F2_4F44:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0B, $1C, $1A

; writes the level wCA81 (marked $6F at the cap wCA82), its digits and the status marks from wCA80 into the BG map (E-0129)
; 5 call sites from 5 routines (e.g. DrawWCA2BStatsScreen, Func_037_4AFD_Case0D_Case16, Func_037_4AFD_Case0D_Case1D, RunWD780StateWhenNotFading_F1_Case0D_Case16, ...)
; reads: hTemp1, hTemp0, wDigits, wCA80, wCA39
; writes: hTemp0, hTemp1
; points at: wCA81
DrawLevelAndStatusRowForWCA81::
Func_0F2_4F47:: ; address name
    ld hl, wCA81
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
    farcall BlankLeadingZeroDigitsWC8C0
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
    ld a, [wCA80]
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
    ld a, [wCA39]
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

; runs Func_0F2_4F47, DrawFiveWCA2BStatsColumn and DrawFourWCA2BStatsDigits (E-0126)
; 2 call sites from 2 routines (e.g. Func_037_4AFD_Case0D_Case04, RunWD780StateWhenNotFading_F1_Case0D_Case04)
DrawWCA2BStatsScreen::
Func_0F2_5002:: ; address name
    call DrawLevelAndStatusRowForWCA81
    call DrawFiveWCA2BStatsColumn
    call DrawFourWCA2BStatsDigits
    ret

; writes four stat words from wCA2B (offsets Data_0F2_5050) as three digits at the scroll offsets Data_0F2_5054 (E-0125)
; 1 call site from 1 routine (e.g. DrawWCA2BStatsScreen)
; points at: wCA2B
DrawFourWCA2BStatsDigits::
Func_0F2_500C:: ; address name
    ld c, $00

Jump_0F2_500E::
    push bc
    ld a, c
    ld hl, Data_0F2_5050
    add_a_to_hl
    ld a, [hl]
    ld hl, wCA2B
    add_a_to_hl
    ld a, [hl+]
    ld b, a
    ld a, [hl]
    ld h, a
    ld l, b
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigitsWC8C0
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
    call WriteThreeDigitsWC8C0AtHL
    inc c
    ld a, c
    cp a, $04
    jr c, Jump_0F2_500E
    ret

Data_0F2_5050:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $5B, $5D, $5F, $61

Data_0F2_5054:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $CC, $01, $D0, $01, $0C, $02, $10, $02

; writes five stat words from wCA2B (offsets Data_0F2_509F) as three digits down a column at scroll + $70 (E-0125)
; 1 call site from 1 routine (e.g. DrawWCA2BStatsScreen)
; points at: wCA2B
DrawFiveWCA2BStatsColumn::
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
    ld hl, wCA2B
    add_a_to_hl
    ld a, [hl+]
    ld b, a
    ld a, [hl]
    ld h, a
    ld l, b
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigitsWC8C0
    pop hl
    push hl
    call WriteThreeDigitsWC8C0AtHL
    pop hl
    ld a, $40
    add_a_to_hl
    pop bc
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_0F2_5068
    ret

Data_0F2_509F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $63, $65, $67, $69, $6B

; writes wC8C0, wC8C1, wC8C2 as digit tiles ($E0 + n) at HL (E-0121)
; 2 call sites from 2 routines (e.g. DrawFourWCA2BStatsDigits, DrawFiveWCA2BStatsColumn)
; reads: wDigits
WriteThreeDigitsWC8C0AtHL::
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

; hFFC6/7 = the word wCA2B[wD7F5], far-calls DrawSpeciesAndFamilyIconForHFFC6 and continues at Jump_0F2_50F8 (E-0126)
; 2 call sites from 1 routine (e.g. RunF24C3DAnd4D72_Sub02)
; reads: wD7F5, wD7F1, wD7F2, wD7F3, wDigits
; writes: hTemp0, hTemp1
; points at: wCA2B
DrawSpeciesIconForWCA2BEntry::
Func_0F2_50C6:: ; address name
    push bc
    ld hl, wCA2B
    ld a, [wD7F5]
    add_a_to_hl
    ld a, [hl+]
    ldh [hTemp0], a
    ld a, [hl]
    ldh [hTemp1], a
    farcall DrawSpeciesAndFamilyIconForHFFC6
    pop bc
    jp Jump_0F2_50F8

; loads the family icon of wCA38 & $0F into tile wD7F4; the next entry draws tile $1E and the count wCA2B[wD7F1] at the scroll offset wD7F2/3 (E-0127)
; 2 call sites from 2 routines (e.g. Func_037_4AFD_Case0D_Case13, RunWD780StateWhenNotFading_F1_Case0D_Case13)
; reads: wCA38, wD7F4, wD7F1, wD7F2, wD7F3, wDigits
; writes: wD09D, wD09E
; points at: wCA2B
DrawFamilyIconAndCountForWCA38::
Func_0F2_50E2:: ; address name
    push bc
    ld a, [wCA38]
    and a, $0F
    ld [wD09D], a
    ld a, [wD7F4]
    ld [wD09E], a
    farcall LoadFamilyIconTileForWD09D
    pop bc

Jump_0F2_50F8::
    ld a, [wD7F1]
    ld hl, wCA2B
    add_a_to_hl
    ld a, [hl]
    and a, a
    jr nz, Jump_0F2_5108
    ret

Jump_0F2_5108::
    push af
    call BGMapAddressAtScroll_BankF2_514D
    ld a, [wD7F2]
    ld d, a
    ld a, [wD7F3]
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
    farcall BlankLeadingZeroDigitsWC8C0
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
; 8 call sites from 6 routines (e.g. DrawFourWCA2BStatsDigits, DrawFiveWCA2BStatsColumn, DrawWCA83ExpAndToNextLevel, DrawFamilyIconAndCountForWCA38, ...)
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

; only called from ScriptCommandF6_Run_Case10_Case04 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF6_Run_Case10_Case04)
; reads: wD7F1, wD7F2, wD7F3
; writes: wD7F5, wD7F6, wD7F7
; points at: wD7F1, wD7F5
ScriptCommandF6_Run_Case10_Case04_Sub01::
Func_0F2_5181:: ; address name
    ld a, [wD7F1]
    ld c, a
    ld a, [wD7F2]
    ld b, a
    ld a, $03
    call Multiply8By16
    ld de, Data_0F2_51C3
    add hl, de
    ld c, $03
    ld b, $00

Jump_0F2_5196::
    ld a, [hl+]
    ld de, wD7F1
    add a, e
    ld e, a
    jr nc, Jump_0F2_519F
    inc d

Jump_0F2_519F::
    push hl
    ld a, b
    ld hl, wD7F5
    add_a_to_hl
    ld a, [hl]
    pop hl
    ld [de], a
    inc b
    dec c
    jr nz, Jump_0F2_5196
    ld a, [wD7F1]
    ld [wD7F5], a
    ld a, [wD7F2]
    ld [wD7F6], a
    ld a, [wD7F3]
    ld [wD7F7], a
    ret

Data_0F2_51C3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $3C91C3, $480

Data_0F2_5643:: ; heuristic: argument of a bank-switching copy helper; C0
    dw Data_0F2_5673
    dw Data_0F2_577B
    dw Data_0F2_580B
    dw Data_0F2_589B
    dw Data_0F2_592B
    dw Data_0F2_59BB
    dw Data_0F2_5A4B
    dw Data_0F2_5ADB
    dw Data_0F2_5B6B
    dw Data_0F2_5BFB
    dw Data_0F2_5C8B
    dw Data_0F2_5CEB
    dw Data_0F2_5D7B
    dw Data_0F2_5E0B
    dw Data_0F2_5E9B
    dw Data_0F2_5F2B
    dw Data_0F2_5FBB
    dw Data_0F2_604B
    dw Data_0F2_60DB
    dw Data_0F2_616B
    db $BB, $59, $BB, $59, $BB, $59, $FB, $61

Data_0F2_5673:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $0A, $00, $00, $32, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $04
    ds $38, $00
    db $0A, $00, $00, $28
    ds $2C, $00
    db $19, $00, $00, $00, $00, $00, $32
    ds $77, $00
    db $14, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_0F2_577B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $F4, $01, $00, $C8, $00, $00, $00
    db $00, $00, $00, $00, $00, $14, $00, $00, $14, $00, $00, $14, $00, $00, $14
    ds $32, $00
    db $C8
    ds $2F, $00
    db $32, $00, $00, $00, $00, $00, $00, $00, $00, $32, $00, $00, $00, $00, $00

Data_0F2_580B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $D0
    db $07
    ds $10, $00
    db $E8, $03, $00, $E8, $03
    ds $2E, $00
    db $E8, $03, $00, $00, $00, $00, $00, $00, $00, $20, $03, $00, $00, $00, $00, $E8
    db $03, $00, $BC, $02, $00, $20, $03, $00, $DC, $05, $00, $B8, $0B
    ds $16, $00
    db $20, $4E, $00, $00, $00, $00, $00, $00, $00

Data_0F2_589B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $0A, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $04, $00, $00, $00, $00, $00, $00, $00, $00, $14
    ds $2F, $00
    db $0A
    ds $2F, $00
    db $1E
    ds $14, $00

Data_0F2_592B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $0A, $00, $00, $32, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $04, $00, $00, $00, $00, $00, $00, $00, $00, $14
    ds $32, $00
    db $28
    ds $2C, $00
    db $1E, $00, $00, $00, $00, $00, $32, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00

Data_0F2_59BB:: ; heuristic: target of a monotone pointer table; C0
    ds $90, $00

Data_0F2_5A4B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $32, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $04, $00, $00, $00, $00, $00, $00, $00, $00, $14
    ds $32, $00
    db $28, $00, $00, $C8
    ds $26, $00
    db $32, $00, $00, $00, $00, $00, $32, $00, $00, $32, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00

Data_0F2_5ADB:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $41, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $05, $00, $00, $14, $00, $00, $14
    ds $35, $00
    db $32, $00, $00, $FA
    ds $26, $00
    db $32, $00, $00, $00, $00, $00, $64, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $32, $00, $00, $00, $00, $00

Data_0F2_5B6B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $41, $00, $00, $EE, $02, $00, $2C, $01
    ds $10, $00
    db $1E
    ds $2F, $00
    db $32
    ds $29, $00
    db $32, $00, $00, $00, $00, $00, $64
    ds $11, $00

Data_0F2_5BFB:: ; heuristic: target of a monotone pointer table; C0
    ds $18, $00
    db $14, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $DC, $05
    ds $2B, $00
    db $C8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $20, $03, $00, $00
    db $00, $00, $B0, $04
    ds $1C, $00
    db $64, $00, $00, $00, $00, $00, $20, $4E, $00, $64, $00, $00, $00, $00, $00

Data_0F2_5C8B:: ; heuristic: target of a monotone pointer table; C0
    ds $39, $00
    db $10, $27, $00, $10, $27, $00, $10, $27, $00, $10, $27, $00, $10, $27, $00, $10
    db $27
    ds $16, $00

Data_0F2_5CEB:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $4B, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $2D, $00, $00, $00, $00, $00, $00, $00, $00, $1E
    ds $32, $00
    db $2C, $01
    ds $28, $00
    db $1E, $00, $00, $96, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $32
    db $00, $00, $00, $00, $00

Data_0F2_5D7B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $32, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $2D, $00, $00, $00, $00, $00, $00, $00, $00, $1E
    ds $32, $00
    db $C8
    ds $26, $00
    db $64, $00, $00, $00, $00, $00, $64, $00, $00, $64, $00, $00, $00, $00, $00, $00
    db $00, $00, $32, $00, $00, $00, $00, $00

Data_0F2_5E0B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $3C, $00, $00, $58, $02, $00, $FA
    ds $44, $00
    db $C8, $00, $00, $DC, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $78
    ds $17, $00
    db $64, $00, $00, $00, $00, $00, $64
    ds $11, $00

Data_0F2_5E9B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $4B, $00, $00, $EE, $02, $00, $2C, $01
    ds $16, $00
    db $E8, $03
    ds $2E, $00
    db $DC, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $2C, $01
    ds $16, $00
    db $96, $00, $00, $00, $00, $00, $96, $00, $00, $64, $00, $00, $00, $00, $00, $00
    db $00, $00, $32, $00, $00, $00, $00, $00

Data_0F2_5F2B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $0F, $00, $00, $4B, $00, $00, $EE, $02, $00, $2C, $01, $00, $00
    db $00, $00, $0F, $00, $00, $2D, $00, $00, $4B, $00, $00, $00, $00, $00, $1E
    ds $32, $00
    db $2C, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $64
    ds $17, $00
    db $96, $00, $00, $00, $00, $00, $96
    ds $11, $00

Data_0F2_5FBB:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $0F, $00, $00, $4B, $00, $00, $EE, $02, $00, $00, $00, $00, $B8
    db $0B, $00, $0F, $00, $00, $2D, $00, $00, $4B
    ds $5C, $00
    db $4C, $1D
    ds $19, $00

Data_0F2_604B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $4B, $00, $00, $00, $00, $00, $2C, $01
    ds $13, $00
    db $DC, $05
    ds $31, $00
    db $DC, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $2C, $01, $00, $DC
    db $05
    ds $2B, $00

Data_0F2_60DB:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $00, $00, $00, $4B, $00, $00, $EE, $02, $00, $00, $00, $00, $D0
    db $07
    ds $43, $00
    db $DC, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $2C, $01, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $DC, $05, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $96, $00, $00, $00, $00, $00, $96
    ds $11, $00

Data_0F2_616B:: ; heuristic: target of a monotone pointer table; C0
    db $00, $00, $00, $0F, $00, $00, $4B, $00, $00, $00, $00, $00, $2C, $01, $00, $00
    db $00, $00, $0F
    ds $3E, $00
    db $2C, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $2C
    db $01
    ds $16, $00
    db $96, $00, $00, $00, $00, $00, $96
    ds $11, $00
    INCBIN "dwm2-cobi-us.gbc", $3CA1FB, $138

; a bare ret (E-0116)
; 1 call site from 1 routine (e.g. RunWD780StateWhenNotFading_1B_Case01_Case05)
ReturnStub_6333::
Func_0F2_6333:: ; address name
    ret
    db $CD, $55, $63, $CD, $46, $63, $C9

; only called from ScriptCommandF2_Run_Case03_Case05 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF2_Run_Case03_Case05)
; writes: wD781
ScriptCommandF2_Run_Case03_Case05_Sub01::
Func_0F2_633B:: ; address name
    call ScriptCommandF2_Run_Case03_Case05_Sub01_Sub01
    call CopyWD09EToKeyList
    xor a, a
    ld [wD781], a
    ret

; copies $C0 bytes from wD09E to wKeyList (E-0122)
; 1 call site from 1 routine (e.g. ScriptCommandF2_Run_Case03_Case05_Sub01)
; points at: wD09E, wKeyList
CopyWD09EToKeyList::
Func_0F2_6346:: ; address name
    ld hl, wD09E
    ld de, wKeyList
    ld c, $C0

Jump_0F2_634E::
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr nz, Jump_0F2_634E
    ret

; only called from ScriptCommandF2_Run_Case03_Case05_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandF2_Run_Case03_Case05_Sub01)
; reads: wD09D
; writes: wD15E, wD09D
; points at: wD09E, wKeyList
ScriptCommandF2_Run_Case03_Case05_Sub01_Sub01::
Func_0F2_6355:: ; address name
    ld hl, wD09E
    ld c, $C0

Jump_0F2_635A::
    ld a, $FF
    ld [hl+], a
    dec c
    jr nz, Jump_0F2_635A
    xor a, a
    ld [wD15E], a
    ld a, [wD09D]
    and a, a
    jr nz, Jump_0F2_637F
    ld a, $01
    ld [wD09D], a
    ld hl, wKeyList
    ld de, wD09E
    call ScriptCommandF2_Run_Case03_Case05_Sub01_Sub01_Sub02
    ld hl, wKeyList
    call ScriptCommandF2_Run_Case03_Case05_Sub01_Sub01_Sub01
    ret

Jump_0F2_637F::
    xor a, a
    ld [wD09D], a
    ld hl, wKeyList
    ld de, wD09E
    call ScriptCommandF2_Run_Case03_Case05_Sub01_Sub01_Sub01
    ld hl, wKeyList
    call ScriptCommandF2_Run_Case03_Case05_Sub01_Sub01_Sub02
    ret

; only called from ScriptCommandF2_Run_Case03_Case05_Sub01_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF2_Run_Case03_Case05_Sub01_Sub01)
; reads: wD15E
; writes: wD15E
; points at: wKeySeeds, wD11E
ScriptCommandF2_Run_Case03_Case05_Sub01_Sub01_Sub01::
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
    ld a, [wD15E]
    add a, a
    ld de, wD11E
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
    ld a, [wD15E]
    inc a
    ld [wD15E], a
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

; only called from ScriptCommandF2_Run_Case03_Case05_Sub01_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandF2_Run_Case03_Case05_Sub01_Sub01)
; reads: wD15E
; writes: wD15E
; points at: wKeySeeds, wD11E
ScriptCommandF2_Run_Case03_Case05_Sub01_Sub01_Sub02::
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
    ld a, [wD15E]
    add a, a
    ld de, wD11E
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
    ld a, [wD15E]
    inc a
    ld [wD15E], a
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
; 3 call sites from 3 routines (e.g. DrawRect0140AtBGMap13E0AndStep, ScriptCommandE5_Run_Case03_Case0B_Sub01, ScriptCommandE5_Run_Case03_Case0E_Sub02)
; reads: wD780, wCF8B
; writes: wCF8B
; points at: wD09D, wInventory, wD7D5
Run64C7UnlessWD780Is3::
Func_0F2_6449:: ; address name
    ld a, [wD780]
    cp a, $03
    jr z, Jump_0F2_6470
    call Run64C7UnlessWD780Is3_Sub01
    ret

; only called from ScriptCommandE5_Run_Case03_Case0E (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case0E)
; reads: wCF8B
; points at: wD09D
ScriptCommandE5_Run_Case03_Case0E_Sub03::
Func_0F2_6454:: ; address name
    ld hl, wD09D
    ld b, $18

Jump_0F2_6459::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_0F2_6459
    ld a, [wCF8B]
    and a, a
    jr nz, Jump_0F2_6469
    ld de, Data_0F2_6586
    jr Jump_0F2_646C

Jump_0F2_6469::
    ld de, Data_0F2_6526

Jump_0F2_646C::
    call ScriptCommandE5_Run_Case03_Case0E_Sub03_Sub01
    ret

Jump_0F2_6470::
    ld hl, wD09D
    ld b, $18

Jump_0F2_6475::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_0F2_6475
    ld a, [wCF8B]
    and a, a
    jr nz, Jump_0F2_6487
    ld de, Data_0F2_6526
    ld a, $01
    jr Jump_0F2_648B

Jump_0F2_6487::
    ld de, Data_0F2_6586
    xor a, a

Jump_0F2_648B::
    ld [wCF8B], a

; only called from ScriptCommandE5_Run_Case03_Case0E_Sub03 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case0E_Sub03)
; points at: wInventory, wD09D, wD7D5
ScriptCommandE5_Run_Case03_Case0E_Sub03_Sub01::
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
    ld hl, wD09D
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld a, [hl+]
    ld [de], a
    inc b
    jr Jump_0F2_64A4

Jump_0F2_64B8::
    ld hl, wD09D
    ld de, wD7D5
    ld b, $18

Jump_0F2_64C0::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_0F2_64C0
    ret

; only called from Run64C7UnlessWD780Is3 (E-0047)
; 1 call site from 1 routine (e.g. Run64C7UnlessWD780Is3)
; reads: wCF8B
; writes: wCF8B
; points at: wD09D, wItemStorage
Run64C7UnlessWD780Is3_Sub01::
Func_0F2_64C7:: ; address name
    ld hl, wD09D
    ld b, $C8

Jump_0F2_64CC::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_0F2_64CC
    ld a, [wCF8B]
    and a, a
    jr nz, Jump_0F2_64DE
    ld de, Data_0F2_6526
    ld a, $01
    jr Jump_0F2_64E2

Jump_0F2_64DE::
    ld de, Data_0F2_6586
    xor a, a

Jump_0F2_64E2::
    ld [wCF8B], a
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
    ld hl, wD09D
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
    ld hl, wD09D
    ld de, wItemStorage
    ld b, $C8

Jump_0F2_651F::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_0F2_651F
    ret

Data_0F2_6526:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $3CA526, $60

Data_0F2_6586:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $3CA586, $60

; for each party record sets HP (field $5B) and MP (field $5F) down to their maxima when they exceed them (E-0129)
; 2 call sites from 2 routines (e.g. RunBattlePhaseWhenTextIdle_A0_Case03_Case00_Sub01, BattleEnd_Step7_Case02_Sub01)
; reads: wPartyCount, wCF8B, wCF8C
; writes: wCF8B, wCF8C
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
    ld [wCF8B], a
    ld a, [hl]
    ld [wCF8C], a
    pop hl
    push hl
    ld a, [hl]
    ld c, $5D
    call SRAMRecordAddress
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    ld a, [wCF8B]
    ld e, a
    ld a, [wCF8C]
    ld d, a
    ld a, l
    ld [wCF8B], a
    ld a, h
    ld [wCF8C], a
    call CompareHLWithDE_BankF2
    ld a, c
    and a, a
    jr nz, Jump_0F2_6632
    pop hl
    push hl
    ld a, [hl]
    ld c, $5B
    call SRAMRecordAddress
    ld a, [wCF8B]
    ld [hl+], a
    ld a, [wCF8C]
    ld [hl], a

Jump_0F2_6632::
    pop hl
    push hl
    ld a, [hl]
    ld c, $5F
    call SRAMRecordAddress
    ld a, [hl+]
    ld [wCF8B], a
    ld a, [hl]
    ld [wCF8C], a
    pop hl
    push hl
    ld a, [hl]
    ld c, $61
    call SRAMRecordAddress
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    ld a, [wCF8B]
    ld e, a
    ld a, [wCF8C]
    ld d, a
    ld a, l
    ld [wCF8B], a
    ld a, h
    ld [wCF8C], a
    call CompareHLWithDE_BankF2
    ld a, c
    and a, a
    jr nz, Jump_0F2_6675
    pop hl
    push hl
    ld a, [hl]
    ld c, $5F
    call SRAMRecordAddress
    ld a, [wCF8B]
    ld [hl+], a
    ld a, [wCF8C]
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
; points at: wD580
DispatchTalkEvent_Case01_Case65_Sub01::
Func_0F2_6692:: ; address name
    ld hl, wD580
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
