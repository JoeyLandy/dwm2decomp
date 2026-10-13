; ROM bank $F2: screens and game mode 8
; The annotated listing of this bank is build/listing/bankf2.asm.

SECTION "Bank F2", ROMX[$4000], BANK[$F2]
    db $f2

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
    farcall RunSaveSteps
    ld a, [wSaveStep]
    bit 7, a
    jr z, .loop2
    ld b, $46
    ld de, Tiles1Gfx_46_4001
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
    jp ClearSGBPacketBuffer_CheckLinkMode

; per-frame routine for wGameMode = 8
GameMode8_Update::
    ld a, [wFadeState]
    and a
    ret nz
    ld a, [wScreenSubStep]
    and a
    jr z, .check_text_flags
    call GameMode8_Update_UpdateAndDrawSpriteSlots

.check_text_flags:
    ld a, [wTextFlags]
    and a
    ret nz
    ld a, [wScreenSubStep]
    jumptable
    dw GameMode8_Update_WriteScreenSubStep
    dw GameMode8_Update_WriteScreenCounterAndScreenSubStep
    dw GameMode8_Update_WriteObject1AndScreenSubStep
    dw GameMode8_Update_WriteScreenCounterAndScreenSubStep
    dw GameMode8_Update_SetObject5
    dw GameMode8_Update_WriteSpriteSlotsAndScreenSubStep
    dw GameMode8_Update_WriteScreenCounterAndScreenSubStep
    dw GameMode8_Update_WriteScreenCounterAndScreenSubStep
    dw GameMode8_Update_SetObject5_Case08
    dw GameMode8_Update_WriteScreenCounterAndScreenSubStep
    dw GameMode8_Update_WriteScreenCounterAndScreenSubStep
    dw GameMode8_Update_WriteSpriteSlotsAndScreenSubStep_Case0B
    dw GameMode8_Update_ShowHeroReceivedGsEgg
    dw GameMode8_Update_ToGameMode8_Update_Case0D_WriteLinkSceneByte4BAndGameModeEtc

GameMode8_Update_WriteScreenSubStep::
    call GameMode8_Update_Case00_TestFlagBit
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

GameMode8_Update_WriteScreenCounterAndScreenSubStep::
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

GameMode8_Update_WriteObject1AndScreenSubStep::
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

GameMode8_Update_SetObject5::
    ld a, $80
    ld [wObject5], a
    ld a, $01
    ld [wArg1], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

GameMode8_Update_WriteSpriteSlotsAndScreenSubStep::
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

GameMode8_Update_SetObject5_Case08::
    ld a, $00
    ld [wObject5], a
    ld [wArg1], a
    ld a, [wScreenSubStep]
    inc a
    ld [wScreenSubStep], a
    ret

GameMode8_Update_WriteSpriteSlotsAndScreenSubStep_Case0B::
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
    farcall BeginStringDisplay_BankF0_48A0
    ld hl, wScreenSubStep
    inc [hl]
    ret

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

GameMode8_Update_ToGameMode8_Update_Case0D_WriteLinkSceneByte4BAndGameModeEtc::
    call GameMode8_Update_Case0D_WriteLinkSceneByte4BAndGameModeEtc
    ret

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

GameMode8_Update_Case0D_WriteLinkSceneByte4BAndGameModeEtc::
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
    ld [wLinkSceneByte4B], a
    ld a, $05
    ld [wGameMode], a
    ld a, $01
    ld [wModeState], a
    ld a, $01
    ld [wModeChangeRequest], a
    ret

GameMode8_Update_Case00_TestFlagBit::
    ld de, $0000
    call TestFlagBit
    jr c, .skip
    ld hl, GameMode8_Update_Case00_TestFlagBit_Data5
    jr .call_copy_bytes_de_from_hl_bank_f2

.skip:
    ld hl, SpriteSlotsInit_F2_430E

.call_copy_bytes_de_from_hl_bank_f2:
    ld de, wSpriteSlots
    ld b, $10
    call CopyBytesDEFromHL_BankF2
    ld a, [wBankF0BlockC7]
    and a
    jr nz, .skip2
    ld hl, GameMode8_Update_Case00_TestFlagBit_Data6
    jr .call_copy_bytes_de_from_hl_bank_f22

.skip2:
    ld hl, Object1Init_F2_432E

.call_copy_bytes_de_from_hl_bank_f22:
    ld de, wObject1
    ld b, $10
    call CopyBytesDEFromHL_BankF2
    ld de, $0000
    call TestFlagBit
    jr c, .skip3
    ld hl, GameMode8_Update_Case00_TestFlagBit_Data1
    jr .call_copy_bytes_de_from_hl_bank_f23

.skip3:
    ld hl, GameMode8_Update_Case00_TestFlagBit_Data2

.call_copy_bytes_de_from_hl_bank_f23:
    ld de, hTemp0
    ld b, $06
    call CopyBytesDEFromHL_BankF2
    farcall DecompressGraphicsTemp0ToTemp4
    ld a, [wBankF0BlockC7]
    and a
    jr nz, .skip4
    ld hl, GameMode8_Update_Case00_TestFlagBit_Data3
    jr .call_copy_bytes_de_from_hl_bank_f24

.skip4:
    ld hl, GameMode8_Update_Case00_TestFlagBit_Data4

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

; the same 7 bytes as CopyBytesDEFromHL (CopyBytesDEFromHL)
CopyBytesDEFromHL_BankF2::
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, CopyBytesDEFromHL_BankF2
    ret

GameMode8_Update_Case00_TestFlagBit_Data1::
    db $00, $00, $01, $04, $00, $80

GameMode8_Update_Case00_TestFlagBit_Data2::
    db $01, $00, $01, $01, $00, $80

GameMode8_Update_Case00_TestFlagBit_Data3::
    db $0c, $00, $01, $05, $00, $81

GameMode8_Update_Case00_TestFlagBit_Data4::
    db $0c, $00, $01, $05, $00, $81, $00, $00, $00, $02, $00, $82

GameMode8_Update_Case00_TestFlagBit_Data5::
    db $00, $01, $00, $00, $f0, $40, $04, $01, $00, $00, $00, $f0, $40, $04, $00, $00

; CopyBytesDEFromHL_BankF2 copies these 16 bytes to wSpriteSlots (E-0264)
; record: 16 bytes copied to wSpriteSlots
SpriteSlotsInit_F2_430E::
    db $00, $01, $01, $00, $f0, $40, $01, $01, $00, $00, $00, $f0, $40, $04, $00, $00 ; entry 0

GameMode8_Update_Case00_TestFlagBit_Data6::
    db $00, $01, $0c, $00, $f0, $40, $05, $03, $10, $00, $00, $f0, $40, $04, $00, $00

; CopyBytesDEFromHL_BankF2 copies these 16 bytes to wObject1 (E-0264)
; record: 16 bytes copied to wObject1
Object1Init_F2_432E::
    db $00, $01, $0c, $00, $f0, $40, $05, $03, $10, $00, $00, $f0, $40, $04, $00, $00 ; entry 0
    db $00, $00, $00, $00, $48, $40, $02, $00, $20, $00, $00, $48, $40, $04, $00, $00

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

; the same 84 bytes as DrawScreenBufferRectToBGMap_1B (DrawScreenBufferRectToBGMap_1B)
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

GameMode8_Update_UpdateAndDrawSpriteSlots::
    farcall UpdateAndDrawSpriteSlots
    farcall DrawFieldSprites
    ret

; ld de, this bank's string table / BeginStringDisplay
BeginStringDisplay_BankF2::
    ld de, StringCategories_F2_43E5
    call BeginStringDisplay
    ret
    db $11, $e5, $43, $cd, $fe, $25, $c9

; BeginStringDisplay_BankF2 (this bank's BeginStringDisplay entry), then RunStringDisplayToEnd
ShowString_BankF2::
    call BeginStringDisplay_BankF2
    call RunStringDisplayToEnd
    ret

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_F2_43E5::
    dw StringList_F2_43E7 ; id 0

; category list of StringCategories_F2_43E5; one pointer per wStringIndex (E-0217)
; record: string
StringList_F2_43E7::
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

; shows string $10 of category 0 (ShowString_Bank0E) at vTiles2 + $20 with size $011E, then restores
; the default window (E-0121)
ShowString10Bank0EAtTiles2020ThenDefault::
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

; shows string $0E of category 0 (ShowString_Bank0E) at vTiles2 + $700 with size $0107, restores the
; default window and copies two tiles from bank $1F to vTiles1 + $6E0 and + $6F0 (E-0121)
ShowString0EBank0EAtTiles2700AndLoadTiles::
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
    ld de, Tiles1Plus6E0Tiles_1F_4510
    ld hl, vTiles1 + $6e0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Tiles1Plus6F0Tiles_1F_4450
    ld hl, vTiles1 + $6f0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ret

; clears five tiles at vTiles2 + $290 (copying $2940) and draws the name at wRecordBufB + $F there
; (E-0121)
DrawWCA3ANameAtTiles2290::
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
    ld hl, wRecordBufB + MON_MASTER_NAME
    call CopyShortStringToNameGlyphBuf_BankF2
    ld de, vTiles2 + $290
    ld a, $f0
    ld [wNameGlyphBuf + $a], a
    call CopyGlyphTilesToVRAM
    ret

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

; returns 9 * PersonalityLevelOfA(wRecordBufB + $6F) + 3 * PersonalityLevelOfA(wRecordBufB + $72) +
; PersonalityLevelOfA(wRecordBufB + $70) (E-0121)
CombinedPersonalityLevelIndex::
    ld a, [wRecordBufB + MON_PERSONALITY]
    call PersonalityLevelOfA
    ld a, $09
    call Multiply8
    ld b, l
    ld a, [wRecordBufB + MON_PERSONALITY + 3]
    call PersonalityLevelOfA
    ld a, c
    add a
    add c
    add b
    ld b, a
    ld a, [wRecordBufB + MON_PERSONALITY + 1]
    call PersonalityLevelOfA
    ld a, c
    add b
    ret

; C = 0 when A >= $C0, 1 when A >= $40, else 2 (the g(v) of PersonalityIndexOfSlot) (E-0116)
PersonalityLevelOfA::
    ld c, $00
    cp $c0
    ret nc
    inc c
    cp $40
    ret nc
    inc c
    ret

; ShowCombinedPersonalityName, then DrawWCA3ANameAtTiles2290 (E-0122)
ShowPersonalityNameAndWCA3AName::
    call ShowCombinedPersonalityName
    call DrawWCA3ANameAtTiles2290
    ret

; writes the EXP wRecordBufB + $58-wRecordBufB + $5A as seven digits and, below the level cap, the
; EXP still needed for the next level (E-0129)
DrawWCA83ExpAndToNextLevel::
    ld a, [wRecordBufB + MON_EXP]
    ld [wDigits], a
    ld a, [wRecordBufB + MON_EXP + 1]
    ld [wDigits + $1], a
    ld a, [wRecordBufB + MON_EXP + 2]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    farcall UnpackBCDToDigitsArg1_Bank1E
    call BGMapAddressAtScroll_BankF2_514D
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

.call_bg_map_address_at_scroll_bank_f2_514_d:
    call BGMapAddressAtScroll_BankF2_514D
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
    jr .call_bg_map_address_at_scroll_bank_f2_514_d

; shows string wRecordBufB + $A4 of category $0B (ShowString_Bank08) at vTiles2 + $320 with size
; $0206 (E-0121)
ShowWCACFCategory11StringAtTiles2320::
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

; loads the species record of wRecordBufB + $B/7 and shows string [wSpeciesRecord + $B] of category
; $0D at vTiles2 + $680 with size $0206 (E-0121)
ShowSpeciesCategory13StringAtTiles2680::
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

; runs RunF24C3DAnd4D72_LoadTemp0WordFromRecordBufB and
; RunF24C3DAnd4D72_LoadTemp0WordFromRecordBufB_Sub02 (E-0126)
RunF24C3DAnd4D72::
    call RunF24C3DAnd4D72_LoadTemp0WordFromRecordBufB
    call RunF24C3DAnd4D72_LoadTemp0WordFromRecordBufB_Sub02
    ret

RunF24C3DAnd4D72_LoadTemp0WordFromRecordBufB::
    ld a, [wRecordBufB + MON_FAMILY]
    and $10
    and a
    jr nz, .skip
    ld de, RunF24C3DAnd4D72_LoadTemp0WordFromRecordBufB_Data1
    jr .call_load_temp0_word_from_record_buf_b

.skip:
    ld de, RunF24C3DAnd4D72_LoadTemp0WordFromRecordBufB_Data2

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

RunF24C3DAnd4D72_LoadTemp0WordFromRecordBufB_Data1::
    db $1a, $8e, $1a, $1e, $1c, $99, $1c, $29

RunF24C3DAnd4D72_LoadTemp0WordFromRecordBufB_Data2::
    db $1c, $99, $1c, $29, $1a, $8e, $1a, $1e

RunF24C3DAnd4D72_LoadTemp0WordFromRecordBufB_Sub02::
    ld a, [wRecordBufB + MON_FAMILY]
    and $10
    and a
    jr nz, .skip
    ld de, RunF24C3DAnd4D72_LoadTemp0WordFromRecordBufB_Sub02_Data1
    jr .call_load_temp0_word_from_record_buf_b

.skip:
    ld de, RunF24C3DAnd4D72_LoadTemp0WordFromRecordBufB_Sub02_Data2

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
    call BGMapAddressAtScroll_BankF2_514D
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
    call BGMapAddressAtScroll_BankF2_514D
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

; BC = wNameBufUnknown when the byte at DE is $98 (the ??? placeholder), else wNameBufAlt (E-0122)
PickNameBufferForFirstByte_BankF2::
    ld a, [de]
    cp $98
    jr z, .done
    ld bc, wNameBufAlt
    jr .return

.done:
    ld bc, wNameBufUnknown

.return:
    ret

RunF24C3DAnd4D72_LoadTemp0WordFromRecordBufB_Sub02_Data1::
    db $1a, $98, $1a, $1c, $a3, $1c

RunF24C3DAnd4D72_LoadTemp0WordFromRecordBufB_Sub02_Data2::
    db $1c, $a3, $1c, $1a, $98, $1a

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

DecompressRecordBufBSpeciesGraphics_Data1::
    db $00, $00, $80, $08, $00, $81, $10, $00, $82

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

DrawRecordBufBSpeciesSprites_Data::
    db $00, $10, $78, $00, $10, $30, $68, $01, $20, $30, $88, $02

DecompressRecordBufBSpeciesGraphics_Data2::
    db $0b, $1a, $1c

DecompressRecordBufBSpeciesGraphics_Data3::
    db $0b, $1c, $1a

; writes the level wRecordBufB + $56 (marked $6F at the cap wRecordBufB + $57), its digits and the
; status marks from wRecordBufB + $55 into the BG map (E-0129)
DrawLevelAndStatusRowForWCA81::
    ld hl, wRecordBufB + MON_LEVEL
    ld a, [hli]
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

; writes tile $C1 at VRAM address HL (WaitForVRAMAccess, interrupts off) (E-0067) (the same 9 bytes
; appear in 2 banks)
WriteTileC1AtHL_BankF2::
    di
    call WaitForVRAMAccess
    ld a, $c1
    ld [hl], a
    ei
    ret

; writes tile $C0 at VRAM address HL (WaitForVRAMAccess, interrupts off) (E-0067) (the same 9 bytes
; appear in 2 banks)
WriteTileC0AtHL_BankF2::
    di
    call WaitForVRAMAccess
    ld a, $c0
    ld [hl], a
    ei
    ret

; writes tile $C2 at VRAM address HL (WaitForVRAMAccess, interrupts off) (E-0067) (the same 9 bytes
; appear in 2 banks)
WriteTileC2AtHL_BankF2::
    di
    call WaitForVRAMAccess
    ld a, $c2
    ld [hl], a
    ei
    ret

; runs DrawLevelAndStatusRowForWCA81, DrawFiveRecordBufBStatsColumn and
; DrawFourRecordBufBStatsDigits (E-0126)
DrawRecordBufBStatsScreen::
    call DrawLevelAndStatusRowForWCA81
    call DrawFiveRecordBufBStatsColumn
    call DrawFourRecordBufBStatsDigits
    ret

; writes four stat words from wRecordBufB (offsets DrawFourRecordBufBStatsDigits_Data1) as three
; digits at the scroll offsets DrawFourRecordBufBStatsDigits_Data2 (E-0125)
DrawFourRecordBufBStatsDigits::
    ld c, $00

.loop:
    push bc
    ld a, c
    ld hl, DrawFourRecordBufBStatsDigits_Data1
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
    ld hl, DrawFourRecordBufBStatsDigits_Data2
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
    cp $04
    jr c, .loop
    ret

DrawFourRecordBufBStatsDigits_Data1::
    db $5b, $5d, $5f, $61

DrawFourRecordBufBStatsDigits_Data2::
    db $cc, $01, $d0, $01, $0c, $02, $10, $02

; writes five stat words from wRecordBufB (offsets DrawFiveRecordBufBStatsColumn_Data) as three
; digits down a column at scroll + $70 (E-0125)
DrawFiveRecordBufBStatsColumn::
    call BGMapAddressAtScroll_BankF2_514D
    ld de, $0070
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld c, $00

.loop:
    push bc
    push hl
    ld a, c
    ld de, DrawFiveRecordBufBStatsColumn_Data
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

DrawFiveRecordBufBStatsColumn_Data::
    db $63, $65, $67, $69, $6b

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

; hTemp0/7 = the word wRecordBufB[wArg5], far-calls DrawSpeciesAndFamilyIconForTemp0 and continues
; at DrawFamilyIconAndCountForWCA38_ReadArg1 (E-0126)
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
    jp DrawFamilyIconAndCountForWCA38_ReadArg1

; loads the family icon of wRecordBufB + $D & $0F into tile wArg4; the next entry draws tile $1E and
; the count wRecordBufB[wArg1] at the scroll offset wArg2/3 (E-0127)
DrawFamilyIconAndCountForWCA38::
    push bc
    ld a, [wRecordBufB + MON_FAMILY]
    and $0f
    ld [wWorkBuf], a
    ld a, [wArg4]
    ld [wWorkBuf + $1], a
    farcall LoadFamilyIconTileForWorkBuf
    pop bc

DrawFamilyIconAndCountForWCA38_ReadArg1::
    ld a, [wArg1]
    ld hl, wRecordBufB
    add_a_to_hl
    ld a, [hl]
    and a
    jr nz, .call_bg_map_address_at_scroll_bank_f2_514_d
    ret

.call_bg_map_address_at_scroll_bank_f2_514_d:
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

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX,
; hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
BGMapAddressAtScroll_BankF2_514D::
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

; ReadF2FarPointerForScreenTableIndex (bank $1C) reads the word at $5643 + 2 * wScreenTableIndex;
; ShopMenu_Buy_LoadArg1PointerForScreenTableIndex_Case05.skip adds 3 * entry (after
; ShopMenu_Shared02) and shows the 24-bit number there in digits (wDigits, Number24ToPackedBCD); the
; lists run contiguously to ReturnStub_6333; read as prices, which is not confirmed (E-0208, C1)
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

; a bare ret (E-0116)
ReturnStub_6333::
    ret
    db $cd, $55, $63, $cd, $46, $63, $c9

KeyAppraisalMenu_ChooseKey_Case05_CopyWD09EToKeyList::
    call KeyAppraisalMenu_ChooseKey_Case05_Sub01_WriteKeyGenCountAndWorkBuf
    call CopyWD09EToKeyList
    xor a
    ld [wScreenStep], a
    ret

; copies $C0 bytes from wWorkBuf + $1 to wKeyList (E-0122)
CopyWD09EToKeyList::
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

KeyAppraisalMenu_ChooseKey_Case05_Sub01_WriteKeyGenCountAndWorkBuf::
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
    call KeyAppraisalMenu_ChooseKey_Case05_Sub01_Sub01_WriteKeyGenCount
    ld hl, wKeyList
    call KeyAppraisalMenu_ChooseKey_Case05_Sub01_Sub01_WriteKeyGenCount_Sub01
    ret

.clear_work_buf:
    xor a
    ld [wWorkBuf], a
    ld hl, wKeyList
    ld de, wWorkBuf + $1
    call KeyAppraisalMenu_ChooseKey_Case05_Sub01_Sub01_WriteKeyGenCount_Sub01
    ld hl, wKeyList
    call KeyAppraisalMenu_ChooseKey_Case05_Sub01_Sub01_WriteKeyGenCount
    ret

KeyAppraisalMenu_ChooseKey_Case05_Sub01_Sub01_WriteKeyGenCount_Sub01::
    ld b, $00
    ld c, $20

KeyAppraisalMenu_ChooseKey_Case05_Sub01_Sub01_WriteKeyGenCount_Sub01_Loop::
    ld a, [hl]
    cp $ff
    jr z, KeyAppraisalMenu_ChooseKey_Case05_Sub01_Sub01_WriteKeyGenCount_Sub01_Skip
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

KeyAppraisalMenu_ChooseKey_Case05_Sub01_Sub01_WriteKeyGenCount_Sub01_Skip::
    ld a, $04
    add_a_to_hl
    inc b
    dec c
    jr nz, KeyAppraisalMenu_ChooseKey_Case05_Sub01_Sub01_WriteKeyGenCount_Sub01_Loop
    ret

KeyAppraisalMenu_ChooseKey_Case05_Sub01_Sub01_WriteKeyGenCount::
    ld b, $00
    ld c, $20

.loop:
    ld a, [hl]
    cp $ff
    jr z, KeyAppraisalMenu_ChooseKey_Case05_Sub01_Sub01_WriteKeyGenCount_Sub01_Skip
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

; in state 3 continues at VaultMenu_Store_Case0E_VaultMenu_Store_MapItemsToInventory_Skip; otherwise
; runs Run64C7UnlessScreenStateIs3_WriteCounterPtr0Lo (E-0126)
Run64C7UnlessScreenStateIs3::
    ld a, [wScreenState]
    cp $03
    jr z, VaultMenu_Store_Case0E_VaultMenu_Store_MapItemsToInventory_Skip
    call Run64C7UnlessScreenStateIs3_WriteCounterPtr0Lo
    ret

VaultMenu_Store_Case0E_VaultMenu_Store_MapItemsToInventory::
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

VaultMenu_Store_Case0E_VaultMenu_Store_MapItemsToInventory_Skip::
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

Run64C7UnlessScreenStateIs3_WriteCounterPtr0Lo::
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
; VaultMenu_Case03_Case0E_Sub03_Sub01, which walks the list up to $FF and, for each byte found among
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
; VaultMenu_Case03_Case0E_Sub03_Sub01, which walks the list up to $FF and, for each byte found among
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

; the same 21 bytes as CompareHLWithDE (CompareHLWithDE)
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
