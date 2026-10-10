SECTION "Bank 1D", ROMX[$4000], BANK[$1D]
    db $1D

; ld de, this bank's string table / BeginStringDisplay
; 1 call site from 1 routine (e.g. DebugMessageTest_Update_Case13)
BeginStringDisplay_Bank1D::
Func_01D_4001:: ; address name
    ld de, Data_01D_4016
    call BeginStringDisplay
    ret
    db $11, $16, $40, $CD, $FE, $25, $C9, $CD

Data_01D_4010:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $40, $CD, $11, $26, $C9

Data_01D_4016:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $18, $40, $48, $40, $48, $40, $69, $40, $8E, $40, $AF, $40, $D0, $40, $F4, $40
    db $13, $41, $33, $41, $4C, $41, $65, $41, $84, $41, $BD, $41, $D6, $41, $F3, $41
    db $12, $42, $37, $42, $59, $42, $76, $42, $95, $42, $B4, $42, $D2, $42, $10, $43
    db $10, $43, $EA, $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Which monster", $F1
    db "will hibernate?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Do you need me", $F1
    db "for anything else?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " So this one", $F1
    db "should hibernate?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " OK my friend,", $F1
    db "time to sleep!", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Huh? There's no", $F1
    db "one on the farm.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Uh-oh, the", $F1
    db "stable is full!", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Want to switch", $F1
    db "with someone?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Who should I", $F1
    db "wake up?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Wake this", $F1
    db "monster up?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Which one should", $F1
    db "hibernate?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " So switch ", $F9, "0", $F1
    db "and ", $F9, "G, huh?", $FA, $F7
    db $F2, "OK, I'll do that", $F1
    db "for you.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Who should I", $F1
    db "wake up?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " I'll send ", $F9, "G", $F1
    db "to the farm.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Huh? No one's", $F1
    db "sleeping now.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Huh? There's no", $F1
    db "room on the farm.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Should someone", $F1
    db "else hibernate?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Who do you want", $F1
    db "to check?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Who do you want", $F1
    db "to release?", $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " It'll disappear.", $F1
    db "Is that OK?", $F0, $F9, "G was released", $F1
    db "in the wild.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " Come see me if", $F1
    db "you get more", $FA, $F7
    db $EF, $EE, "monsters.", $EF, $EE, "I'll be waiting.", $F7
    db $F0, $EA
    db $45
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " No one else can", $F1
    db "hibernate,I see.", $F7
    db $F0, $EB, $EB
    INCBIN "dwm2-cobi-us.gbc", $074337, $183

; only called from ScriptCommandE5_Run_Case03_Case00 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case00)
; reads: wD780, wD781
; writes: wD781
ScriptCommandE5_Run_Case03_Case00_Sub01::
Func_01D_44BA:: ; address name
    ld a, [wD780]
    cp a, $03
    jr z, Jump_01D_44C6
    ld hl, Data_01D_4547
    jr Jump_01D_44C9

Jump_01D_44C6::
    ld hl, Data_01D_44E3

Jump_01D_44C9::
    ld de, vBGMap1 + $300

Jump_01D_44CC::
    ld a, [hl]
    cp a, $7F
    jr z, Jump_01D_44DB
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    jr Jump_01D_44CC

Jump_01D_44DB::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Data_01D_44E3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0744E3, $64

Data_01D_4547:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $074547, $64

; copies three tiles from bank $1F to vTiles2 + $7A0-$7C0, then draws the 4 x 1 rows Data_01D_4603, 4607 and 460B at scroll + $62, $A2 and $E2 (E-0121)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case02)
LoadThreeTilesAndDrawRows4603To460B::
Func_01D_45AB:: ; address name
    ld hl, vTiles2 + $7A0
    ld de, Data_01F_4130
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $7B0
    ld de, Data_01F_4310
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles2 + $7C0
    ld de, Data_01F_4300
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    call BGMapAddressAtScroll_Bank1D
    ld de, $0062
    add hl, de
    ld bc, $0401
    ld de, Data_01D_4603
    call ClearRectSetWC554Plus21_Bank1D
    call BGMapAddressAtScroll_Bank1D
    ld de, $00A2
    add hl, de
    ld bc, $0401
    ld de, Data_01D_4607
    call ClearRectSetWC554Plus21_Bank1D
    call BGMapAddressAtScroll_Bank1D
    ld de, $00E2
    add hl, de
    ld bc, $0401
    ld de, Data_01D_460B
    call ClearRectSetWC554Plus21_Bank1D
    ret

Data_01D_4603:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $7A, $AD, $CF, $7B

Data_01D_4607:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $BF, $A7, $7C, $EE

Data_01D_460B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A9, $A4, $EB, $AD

; only called from ScriptCommandE5_Run_Case04_Case03 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case04_Case03)
; reads: wD781, wD7ED, wC61C, wC61B, wC61A, wGoldHi, wGoldMid, wGoldLo, ...
; writes: wTwoChoiceCursor, wD781, wScriptCommandType, wScriptStartRequest
ScriptCommandE5_Run_Case04_Case03_Sub01::
Func_01D_460F:: ; address name
    call ScriptCommandE5_Run_Shared03
    and a, a
    ret z
    cp a, $01
    jr z, Jump_01D_462C
    cp a, $02
    jr z, Jump_01D_461D
    ret

Jump_01D_461D::
    ld a, $06
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    jp Jump_01D_4642

Jump_01D_462C::
    ld a, [wD7ED]
    and a, a
    jr z, Jump_01D_464C
    cp a, $01
    jr z, Jump_01D_4689
    ld a, $06
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a

Jump_01D_4642::
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_464C::
    call ScriptCommandE5_Run_Shared06
    ld a, [wD7BC]
    and a, a
    jr z, Jump_01D_466C
    ld a, [wD7B0]
    cp a, $18
    jr z, Jump_01D_467A
    ld a, $04
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    jp Jump_01D_4642

Jump_01D_466C::
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    jp Jump_01D_4642

Jump_01D_467A::
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    jp Jump_01D_4642

Jump_01D_4689::
    ld a, [wC61C]
    and a, a
    jr nz, Jump_01D_46AA
    ld a, [wC61B]
    and a, a
    jr nz, Jump_01D_46AA
    ld a, [wC61A]
    and a, a
    jr nz, Jump_01D_46AA
    ld a, $03
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    jp Jump_01D_4642

Jump_01D_46AA::
    ld a, [wGoldHi]
    cp a, $01
    jr c, Jump_01D_46D4
    jr nz, Jump_01D_46C5
    ld a, [wGoldMid]
    cp a, $86
    jr c, Jump_01D_46D4
    jr nz, Jump_01D_46C5
    ld a, [wGoldLo]
    cp a, $3B
    jr c, Jump_01D_46D4
    jr z, Jump_01D_46D4

Jump_01D_46C5::
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    jp Jump_01D_4642

Jump_01D_46D4::
    ld a, $05
    ld [wTwoChoiceCursor], a
    ld a, $11
    ld [wD781], a
    jp Jump_01D_4642

; only called from ScriptCommandE5_Run_Case03_Case03 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case03)
; reads: wD781, wD7ED, wGoldHi, wGoldMid, wGoldLo, wC61C, wC61B, wC61A, ...
; writes: wTwoChoiceCursor, wD781, wScriptCommandType, wScriptStartRequest
ScriptCommandE5_Run_Case03_Case03_Sub01::
Func_01D_46E1:: ; address name
    call ScriptCommandE5_Run_Shared03
    and a, a
    ret z
    cp a, $01
    jr z, Jump_01D_46FE
    cp a, $02
    jr z, Jump_01D_46EF
    ret

Jump_01D_46EF::
    ld a, $06
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    jp Jump_01D_4714

Jump_01D_46FE::
    ld a, [wD7ED]
    and a, a
    jr z, Jump_01D_471E
    cp a, $01
    jr z, Jump_01D_4758
    ld a, $06
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a

Jump_01D_4714::
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_471E::
    ld a, [wD7B0]
    and a, a
    jr z, Jump_01D_473B
    call ScriptCommandE5_Run_Case03_Case03_Sub01_Sub01
    cp a, $FF
    jr z, Jump_01D_4749
    ld a, $04
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    jp Jump_01D_4714

Jump_01D_473B::
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    jp Jump_01D_4714

Jump_01D_4749::
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    jp Jump_01D_4714

Jump_01D_4758::
    ld a, [wGoldHi]
    and a, a
    jr nz, Jump_01D_477A
    ld a, [wGoldMid]
    and a, a
    jr nz, Jump_01D_477A
    ld a, [wGoldLo]
    cp a, $64
    jr nc, Jump_01D_477A
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    jp Jump_01D_4714

Jump_01D_477A::
    ld a, [wC61C]
    cp a, $0F
    jr c, Jump_01D_47A2
    jr nz, Jump_01D_4793
    ld a, [wC61B]
    cp a, $41
    jr c, Jump_01D_47A2
    jr nz, Jump_01D_4793
    ld a, [wC61A]
    cp a, $DC
    jr c, Jump_01D_47A2

Jump_01D_4793::
    ld a, $03
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    jp Jump_01D_4714

Jump_01D_47A2::
    ld a, $05
    ld [wTwoChoiceCursor], a
    ld a, $11
    ld [wD781], a
    jp Jump_01D_4714

; only called from routines of ScriptCommandE5_Run (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommandE5_Run_Case04_Case03_Sub01, ScriptCommandE5_Run_Case03_Case03_Sub01)
; reads: wJoypadPressedRepeat, wD7ED
; writes: wD7ED
ScriptCommandE5_Run_Shared03::
Func_01D_47AF:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_01D_47C8
    bit 7, a
    jr nz, Jump_01D_47E3
    bit 0, a
    jr nz, Jump_01D_47F3
    bit 1, a
    jp nz, Jump_01D_47FE
    call BlinkCursorWD7EF_Bank1D_4801
    xor a, a
    ret

Jump_01D_47C8::
    call DrawBlankTileC3_481F_Bank1D
    ld a, [wD7ED]
    and a, a
    jr nz, Jump_01D_47D5
    ld a, $02
    jr Jump_01D_47D6

Jump_01D_47D5::
    dec a

Jump_01D_47D6::
    ld [wD7ED], a
    call DrawCursorTileBB_481B_Bank1D
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ret

Jump_01D_47E3::
    call DrawBlankTileC3_481F_Bank1D
    ld a, [wD7ED]
    cp a, $02
    jr c, Jump_01D_47F0
    xor a, a
    jr Jump_01D_47D6

Jump_01D_47F0::
    inc a
    jr Jump_01D_47D6

Jump_01D_47F3::
    call ScriptCommandE5_Run_Shared03_Sub01
    ld a, $69
    call QueueSoundEffect
    ld a, $01
    ret

Jump_01D_47FE::
    ld a, $02
    ret

; cycles wD7EF through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (after the joypad repeat timer reaches $14) (E-0122)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Shared03)
; reads: wJoypadRepeatTimer, wD7EF, wD7ED
; writes: wD7EF
BlinkCursorWD7EF_Bank1D_4801::
Func_01D_4801:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, DrawCursorTileBB_481B_Bank1D
    ld a, [wD7EF]
    inc a
    ld [wD7EF], a
    cp a, $10
    jr c, DrawCursorTileBB_481B_Bank1D
    cp a, $18
    jr c, DrawBlankTileC3_481F_Bank1D
    xor a, a
    ld [wD7EF], a

; B = $BB (cursor tile) and joins the cursor draw (E-0122)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Shared03)
; reads: wD7ED
DrawCursorTileBB_481B_Bank1D::
Func_01D_481B:: ; address name
    ld b, $BB
    jr Jump_01D_4825

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. ScriptCommandE5_Run_Shared03)
; reads: wD7ED
DrawBlankTileC3_481F_Bank1D::
Func_01D_481F:: ; address name
    ld b, $C3
    jr Jump_01D_4825

; only called from ScriptCommandE5_Run_Shared03 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Shared03)
; reads: wD7ED
ScriptCommandE5_Run_Shared03_Sub01::
Func_01D_4823:: ; address name
    ld b, $BC

Jump_01D_4825::
    ld a, [wD7ED]
    add a, a
    ld hl, Data_01D_4842
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_01D_4842:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $61, $00, $A1, $00, $E1, $00

; draws rect $0088 (9 x 12) at vBGMap1 + $370 (Func_01D_5917) and wD781 += 1 (E-0122)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case05)
; reads: wD781
; writes: wD781
DrawRect0088AtBGMap1370AndStep::
Func_01D_4848:: ; address name
    ld hl, $0088
    ld de, vBGMap1 + $370
    ld bc, $090C
    call SaveBGMapRectWithAttrs
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; draws rect $0140 (3 x 7) at vBGMap1 + $3E0; in state 3 also runs Func_01C_689A and Func_0F2_6449; wD781 += 1 (E-0122)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case06)
; reads: wD780, wD781
; writes: wD781
DrawRect0140AtBGMap13E0AndStep::
Func_01D_485C:: ; address name
    ld hl, $0140
    ld de, vBGMap1 + $3E0
    ld bc, $0307
    call SaveBGMapRectWithAttrs
    ld a, [wD780]
    cp a, $03
    jr nz, Jump_01D_487B
    farcall ListDistinctInventoryItemsToWD7D5
    farcall Run64C7UnlessWD780Is3

Jump_01D_487B::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; only called from ScriptCommandE5_Run_Case03_Case07 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case07)
; reads: wD7BB, wIsCGB, wD781
; writes: wD7F1, wD781
ScriptCommandE5_Run_Case03_Case07_Sub01::
Func_01D_4883:: ; address name
    ld a, $01
    ld [wD7F1], a
    call ScriptCommandE5_Run_Shared05
    ld a, [wD7BB]
    cp a, $02
    jr c, Jump_01D_48A5
    call BGMapAddressAtScroll_Bank1D
    ld de, $0088
    add hl, de
    ld bc, $0C09
    ld de, Data_01D_48FC
    push hl
    call ClearRectSetWC554Plus21_Bank1D
    jr Jump_01D_48B6

Jump_01D_48A5::
    call BGMapAddressAtScroll_Bank1D
    ld de, $0088
    add hl, de
    ld bc, $0C09
    ld de, Data_01D_4968
    push hl
    call ClearRectSetWC554Plus21_Bank1D

Jump_01D_48B6::
    pop hl
    ld a, [wIsCGB]
    and a, a
    jr nz, Jump_01D_48C5
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01D_48C5::
    ld bc, $0000

Jump_01D_48C8::
    push hl

Jump_01D_48C9::
    push bc
    ld c, $4F
    ld a, $01
    ldh [c], a
    pop bc
    di
    call WaitForVRAMAccess
    xor a, a
    ld [hl+], a
    ei
    push bc
    ld c, $4F
    xor a, a
    ldh [c], a
    pop bc
    inc c
    ld a, c
    cp a, $0C
    jr c, Jump_01D_48C9
    pop hl
    ld c, $00
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc b
    ld a, b
    cp a, $09
    jr c, Jump_01D_48C8
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Data_01D_48FC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0748FC, $6C

Data_01D_4968:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $074968, $6C

; only called from ScriptCommandE5_Run_Case03_Case08 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case08)
; reads: wC8C1, wD7BB, wC8C2, wD7B6, wD781
; writes: wD7F1, wC8C1, wD781, wD783, wD784
ScriptCommandE5_Run_Case03_Case08_Sub01::
Func_01D_49D4:: ; address name
    xor a, a
    ld [wD7F1], a
    call ScriptCommandE5_Run_Shared05
    call HLToDecimalDigits
    ld a, [wC8C1]
    and a, a
    jr nz, Jump_01D_49E9
    ld a, $E3
    ld [wC8C1], a

Jump_01D_49E9::
    ld a, [wD7BB]
    cp a, $02
    jr c, Jump_01D_4A3F
    call BGMapAddressAtScroll_Bank1D
    ld de, $0190
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, [wC8C1]
    add a, $E0
    ld [hl+], a
    ei
    di
    call WaitForVRAMAccess
    ld a, [wC8C2]
    add a, $E0
    ld [hl], a
    ei
    ld a, [wD7B6]
    ld l, a
    ld h, $00
    inc hl
    call HLToDecimalDigits
    ld a, [wC8C1]
    and a, a
    jr nz, Jump_01D_4A22
    ld a, $E3
    ld [wC8C1], a

Jump_01D_4A22::
    call BGMapAddressAtScroll_Bank1D
    ld de, $018D
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, [wC8C1]
    add a, $E0
    ld [hl+], a
    ei
    di
    call WaitForVRAMAccess
    ld a, [wC8C2]
    add a, $E0
    ld [hl], a
    ei

Jump_01D_4A3F::
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD783], a
    ld [wD784], a
    ret

; C = the number of non-zero bytes among the $18 bytes at wD7D5 (E-0122)
; 2 call sites from 1 routine (e.g. ScriptCommandE5_Run_Shared05)
; points at: wD7D5
CountNonZeroWD7D5Bytes::
Func_01D_4A4E:: ; address name
    ld hl, wD7D5
    ld b, $00
    ld c, $00

Jump_01D_4A55::
    ld a, [hl]
    and a, a
    jr z, Jump_01D_4A5A
    inc c

Jump_01D_4A5A::
    inc hl
    inc b
    ld a, b
    cp a, $18
    jr c, Jump_01D_4A55
    ret

; only called from routines of ScriptCommandE5_Run (E-0098)
; 5 call sites from 4 routines (e.g. ScriptCommandE5_Run_Case04_Case03_Sub01, ScriptCommandE5_Run_Shared05, ScriptCommandE5_Run_Case03_Case0E_Sub01, ScriptCommandE5_Run_Case01_Case02)
; writes: wD7BC, wD7B0
; points at: wC635, wInventory
ScriptCommandE5_Run_Shared06::
Func_01D_4A62:: ; address name
    ld hl, wC635
    ld c, $00
    ld b, $00

Jump_01D_4A69::
    ld a, [hl]
    and a, a
    jr z, Jump_01D_4A72
    cp a, $FF
    jr z, Jump_01D_4A72
    inc c

Jump_01D_4A72::
    inc hl
    inc hl
    inc b
    ld a, b
    cp a, $64
    jr c, Jump_01D_4A69
    ld a, c
    ld [wD7BC], a
    ld hl, wInventory
    ld c, $00
    ld b, $00

Jump_01D_4A85::
    ld a, [hl]
    and a, a
    jr z, Jump_01D_4A8E
    cp a, $FF
    jr z, Jump_01D_4A8E
    inc c

Jump_01D_4A8E::
    inc hl
    inc b
    ld a, b
    cp a, $18
    jr c, Jump_01D_4A85
    ld a, c
    ld [wD7B0], a
    ret

; cycles wD7B4 through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (E-0122)
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B4, wD7B5
; writes: wD7B4
BlinkCursorWD7B4_Bank1D_4A9A:: ; heuristic: follows a terminator; C0
Func_01D_4A9A:: ; address name
    ld a, [wD7B4]
    inc a
    ld [wD7B4], a
    cp a, $10
    jr c, Jump_01D_4AAD
    cp a, $18
    jr c, ScriptCommandE5_Run_Shared05_Sub01
    xor a, a
    ld [wD7B4], a

Jump_01D_4AAD::
    ld b, $BB
    jr Jump_01D_4AB7

; only called from ScriptCommandE5_Run_Shared05 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Shared05)
; reads: wD7B5
ScriptCommandE5_Run_Shared05_Sub01::
Func_01D_4AB1:: ; address name
    ld b, $C3
    jr Jump_01D_4AB7
    db $06, $BC

Jump_01D_4AB7::
    ld a, [wD7B5]
    add a, a
    ld hl, Data_01D_4AD4
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_01D_4AD4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A9, $00, $E9, $00, $29, $01, $69, $01

; only called from ScriptCommandE5_Run_Case03_Case0A (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case0A)
; reads: wD780, wD7B6, wD7B5, wC8C1, wC8C2, wIsCGB, wD781
; writes: wC8C1, wD793, wD794, wD781
; points at: wD788, wC635, wD7D5, wInventory
ScriptCommandE5_Run_Case03_Case0A_Sub01::
Func_01D_4ADC:: ; address name
    ld hl, Data_01D_4BE4
    ld de, wD788
    ld c, $00

Jump_01D_4AE4::
    ld a, [hl+]
    ld [de], a
    inc c
    inc de
    ld a, c
    cp a, $15
    jr c, Jump_01D_4AE4
    ld a, [wD780]
    cp a, $03
    jp z, Jump_01D_4B32
    ld hl, wC635
    ld a, [wD7B6]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wD7B5]
    add a, a
    add_a_to_hl
    ld e, [hl]
    ld hl, wC635
    ld bc, $0000

Jump_01D_4B1B::
    ld a, [hl]
    cp a, e
    jr nz, Jump_01D_4B26
    and a, a
    jr z, Jump_01D_4B26
    inc hl
    ld c, [hl]
    jr Jump_01D_4B66

Jump_01D_4B26::
    inc b
    inc hl
    inc hl
    ld a, b
    cp a, $64
    jr c, Jump_01D_4B1B
    ld c, $00
    jr Jump_01D_4B66

Jump_01D_4B32::
    ld hl, wD7D5
    ld a, [wD7B6]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wD7B5]
    add_a_to_hl
    ld e, [hl]
    ld hl, wInventory
    ld bc, $0000

Jump_01D_4B53::
    ld a, [hl]
    cp a, e
    jr nz, Jump_01D_4B5F
    and a, a
    jr z, Jump_01D_4B5F
    cp a, $FF
    jr z, Jump_01D_4B5F
    inc c

Jump_01D_4B5F::
    inc b
    inc hl
    ld a, b
    cp a, $18
    jr c, Jump_01D_4B53

Jump_01D_4B66::
    ld a, c
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld a, [wC8C1]
    and a, a
    jr nz, Jump_01D_4B78
    ld a, $E3
    ld [wC8C1], a

Jump_01D_4B78::
    ld a, [wC8C1]
    add a, $E0
    ld [wD793], a
    ld a, [wC8C2]
    add a, $E0
    ld [wD794], a
    call BGMapAddressAtScroll_Bank1D
    ld de, $0140
    add hl, de
    ld bc, $0703
    ld de, wD788
    call ClearRectSetWC554Plus21_Bank1D
    ld a, [wIsCGB]
    and a, a
    jr nz, Jump_01D_4BA6
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01D_4BA6::
    call BGMapAddressAtScroll_Bank1D
    ld de, $0140
    add hl, de
    ld bc, $0000

Jump_01D_4BB0::
    push hl

Jump_01D_4BB1::
    push bc
    ld c, $4F
    ld a, $01
    ldh [c], a
    pop bc
    di
    call WaitForVRAMAccess
    xor a, a
    ld [hl+], a
    ei
    push bc
    ld c, $4F
    xor a, a
    ldh [c], a
    pop bc
    inc c
    ld a, c
    cp a, $07
    jr c, Jump_01D_4BB1
    pop hl
    ld c, $00
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc b
    ld a, b
    cp a, $03
    jr c, Jump_01D_4BB0
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Data_01D_4BE4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $C3, $BE, $C3, $C3, $B7, $B3, $B4
    db $B4, $B4, $B4, $B4, $B5

; only called from ScriptCommandE5_Run_Case03_Case0B (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case0B)
; reads: wJoypadPressedRepeat, wD781, wD780, wD7B7, wD7B5, wD7BB, wD7B6
; writes: wD781, wD7B5, wD7B6, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wD7CA, wD7CB, ...
ScriptCommandE5_Run_Case03_Case0B_Sub01::
Func_01D_4BF9:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 2, a
    jr nz, Jump_01D_4C3D
    bit 4, a
    jr nz, Jump_01D_4C50
    bit 5, a
    jr nz, Jump_01D_4C75
    bit 6, a
    jp nz, Jump_01D_4C8D
    bit 7, a
    jp nz, Jump_01D_4CAF
    bit 0, a
    jp nz, Jump_01D_4CD3
    call BlinkCursorWD7B4_Bank1D_4D41
    ld a, [wJoypadPressedRepeat]
    bit 1, a
    ret z
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD7B5], a
    ld [wD7B6], a
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_4C3D::
    farcall Run64C7UnlessWD780Is3
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

Jump_01D_4C4C::
    call BlinkCursorWD7B4_Bank1D_4D41
    ret

Jump_01D_4C50::
    ld a, [wD7BB]
    cp a, $02
    jr c, Jump_01D_4C4C
    ld a, [wD7BB]
    ld b, a
    ld a, [wD7B6]
    inc a
    cp a, b
    jr c, Jump_01D_4C63
    xor a, a

Jump_01D_4C63::
    ld [wD7B6], a
    ld a, [wD781]
    dec a
    dec a
    dec a
    ld [wD781], a
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01D_4C75::
    ld a, [wD7BB]
    cp a, $02
    jr c, Jump_01D_4C4C
    ld a, [wD7B6]
    and a, a
    jr nz, Jump_01D_4C89
    ld a, [wD7BB]
    dec a
    jp Jump_01D_4C63

Jump_01D_4C89::
    dec a
    jp Jump_01D_4C63

Jump_01D_4C8D::
    call DrawBlankTileC3_4D5F_Bank1D
    ld a, [wD7B5]
    and a, a
    jr nz, Jump_01D_4C9B
    ld a, [wD7B7]
    jr Jump_01D_4C9C

Jump_01D_4C9B::
    dec a

Jump_01D_4C9C::
    ld [wD7B5], a
    call DrawCursorTileBB_4D5B_Bank1D
    ld a, [wD781]
    dec a
    ld [wD781], a
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01D_4CAF::
    call DrawBlankTileC3_4D5F_Bank1D
    ld a, [wD7B7]
    ld b, a
    ld a, [wD7B5]
    cp a, b
    jr c, Jump_01D_4CBF
    xor a, a
    jr Jump_01D_4CC0

Jump_01D_4CBF::
    inc a

Jump_01D_4CC0::
    ld [wD7B5], a
    call DrawCursorTileBB_4D5B_Bank1D
    ld a, [wD781]
    dec a
    ld [wD781], a
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01D_4CD3::
    ld a, $69
    call QueueSoundEffect
    call ScriptCommandE5_Run_Case03_Case0B_Sub01_Sub01
    ld a, [wD780]
    cp a, $04
    jr z, Jump_01D_4D0A
    call ScriptCommandE5_Run_Case03_Case0B_Sub01_Sub02
    and a, a
    jr z, Jump_01D_4D0A
    cp a, $FE
    jr z, Jump_01D_4CFB
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_4CFB::
    ld a, $03
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_4D0A::
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    xor a, a
    ld [wD7CA], a
    ld a, $01
    ld [wD7CB], a
    ld [wD7CC], a
    ld a, [wD780]
    cp a, $04
    jr z, Jump_01D_4D2D
    farcall CountItemInInventoryToDigits
    jr Jump_01D_4D30

Jump_01D_4D2D::
    call SplitWC635EntryIntoDigits

Jump_01D_4D30::
    call DrawWD7CAWD7CBDigitsAtScroll161
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; cycles wD7B4 through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (after the joypad repeat timer reaches $14) (E-0122)
; 2 call sites from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case0B_Sub01)
; reads: wJoypadRepeatTimer, wD7B4, wD7B5
; writes: wD7B4
BlinkCursorWD7B4_Bank1D_4D41::
Func_01D_4D41:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, DrawCursorTileBB_4D5B_Bank1D
    ld a, [wD7B4]
    inc a
    ld [wD7B4], a
    cp a, $10
    jr c, DrawCursorTileBB_4D5B_Bank1D
    cp a, $18
    jr c, DrawBlankTileC3_4D5F_Bank1D
    xor a, a
    ld [wD7B4], a

; B = $BB (cursor tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case0B_Sub01)
; reads: wD7B5
DrawCursorTileBB_4D5B_Bank1D::
Func_01D_4D5B:: ; address name
    ld b, $BB
    jr Jump_01D_4D65

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case0B_Sub01)
; reads: wD7B5
DrawBlankTileC3_4D5F_Bank1D::
Func_01D_4D5F:: ; address name
    ld b, $C3
    jr Jump_01D_4D65

; only called from ScriptCommandE5_Run_Case03_Case0B_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case0B_Sub01)
; reads: wD7B5
ScriptCommandE5_Run_Case03_Case0B_Sub01_Sub01::
Func_01D_4D63:: ; address name
    ld b, $BC

Jump_01D_4D65::
    ld a, [wD7B5]
    add a, a
    ld hl, Data_01D_4D82
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_01D_4D82:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A9, $00, $E9, $00, $29, $01, $69, $01

; only called from ScriptCommandE5_Run_Case03_Case0B_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case0B_Sub01)
; reads: wD7B6, wD7B5
; points at: wD7D5, wC635
ScriptCommandE5_Run_Case03_Case0B_Sub01_Sub02::
Func_01D_4D8A:: ; address name
    ld hl, wD7D5
    ld a, [wD7B6]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wD7B5]
    add_a_to_hl
    ld b, [hl]
    ld hl, wC635
    ld c, $00

Jump_01D_4DAA::
    ld a, [hl]
    cp a, b
    jr z, Jump_01D_4DBC
    and a, a
    jr z, Jump_01D_4DC5
    inc hl
    inc hl
    inc c
    ld a, c
    cp a, $64
    jr c, Jump_01D_4DAA
    ld a, $FF
    ret

Jump_01D_4DBC::
    inc hl
    ld a, [hl]
    cp a, $63
    jr c, Jump_01D_4DC5
    ld a, $FE
    ret

Jump_01D_4DC5::
    xor a, a
    ret

; only called from ScriptCommandE5_Run_Case03_Case0D (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case0D)
; reads: wJoypadPressedRepeat, wD7CA, wD7CB, wD780, wD781, wD7CC, wD7D4, wD7D3
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wD781, wD7CA, wD7CB, wD7CC
ScriptCommandE5_Run_Case03_Case0D_Sub01::
Func_01D_4DC7:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 1, a
    jr nz, Jump_01D_4DE9
    bit 4, a
    jr nz, Jump_01D_4E0D
    bit 5, a
    jr nz, Jump_01D_4E27
    bit 6, a
    jp nz, Jump_01D_4E37
    bit 7, a
    jp nz, Jump_01D_4EC0
    bit 0, a
    jp nz, Jump_01D_4F4D
    call BlinkCursorWD7CD_Bank1D_4F99
    ret

Jump_01D_4DE9::
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, $0B
    ld [wD781], a
    call BGMapAddressAtScroll_Bank1D
    ld de, $0161
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, $C3
    ld [hl+], a
    ld [hl], a
    ei
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_4E0D::
    call ScriptCommandE5_Run_Case03_Case0D_Sub01_Sub01
    ld a, [wD7CC]
    cp a, $01
    jr nz, Jump_01D_4E1A
    xor a, a
    jr Jump_01D_4E1B

Jump_01D_4E1A::
    inc a

Jump_01D_4E1B::
    ld [wD7CC], a
    call BlinkCursorWD7CD_Bank1D_4F99
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01D_4E27::
    call ScriptCommandE5_Run_Case03_Case0D_Sub01_Sub01
    ld a, [wD7CC]
    and a, a
    jr nz, Jump_01D_4E34
    ld a, $01
    jr Jump_01D_4E1B

Jump_01D_4E34::
    dec a
    jr Jump_01D_4E1B

Jump_01D_4E37::
    ld a, $69
    call QueueSoundEffect
    ld a, [wD7CC]
    and a, a
    jr nz, Jump_01D_4E84
    ld a, [wD7D3]
    ld b, a
    ld a, [wD7CA]
    cp a, b
    jr c, Jump_01D_4E72
    ld a, b
    ld [wD7CA], a
    ld a, [wD7D3]
    ld [wD7CA], a
    ld a, [wD7D4]
    ld [wD7CB], a
    call DrawWD7CAWD7CBDigitsAtScroll161
    ret

Jump_01D_4E60::
    ld a, [wD7D4]
    ld b, a
    ld a, [wD7CB]
    cp a, b
    jr c, Jump_01D_4E6E
    ld a, b
    ld [wD7CB], a

Jump_01D_4E6E::
    call DrawWD7CAWD7CBDigitsAtScroll161
    ret

Jump_01D_4E72::
    inc a
    ld [wD7CA], a
    push af
    ld a, [wD7D3]
    ld b, a
    pop af
    cp a, b
    jp nc, Jump_01D_4E60
    call BlinkCursorWD7CD_Bank1D_4F99
    ret

Jump_01D_4E84::
    ld a, [wD7D3]
    ld b, a
    ld a, [wD7CA]
    cp a, b
    jr c, Jump_01D_4E94
    ld a, [wD7D4]
    ld b, a
    jr Jump_01D_4E96

Jump_01D_4E94::
    ld b, $09

Jump_01D_4E96::
    ld a, [wD7CB]
    cp a, b
    jr c, Jump_01D_4EB8
    ld a, [wD7D4]
    cp a, b
    jr nz, Jump_01D_4EA6
    call BlinkCursorWD7CD_Bank1D_4F99
    ret

Jump_01D_4EA6::
    ld a, [wD7CA]
    and a, a
    jr nz, Jump_01D_4EB0
    ld a, $01
    jr Jump_01D_4EB1

Jump_01D_4EB0::
    xor a, a

Jump_01D_4EB1::
    ld [wD7CB], a
    call BlinkCursorWD7CD_Bank1D_4F99
    ret

Jump_01D_4EB8::
    inc a
    ld [wD7CB], a
    call BlinkCursorWD7CD_Bank1D_4F99
    ret

Jump_01D_4EC0::
    ld a, $69
    call QueueSoundEffect
    ld a, [wD7CC]
    and a, a
    jr nz, Jump_01D_4F0D
    ld a, [wD7CA]
    and a, a
    jr nz, Jump_01D_4EF5
    ld a, [wD7D4]
    ld b, a
    ld a, [wD7CB]
    cp a, b
    jr c, Jump_01D_4EEB
    ld a, [wD7D3]
    ld [wD7CA], a
    ld a, [wD7D4]
    ld [wD7CB], a
    call DrawWD7CAWD7CBDigitsAtScroll161
    ret

Jump_01D_4EEB::
    ld a, [wD7D3]
    ld [wD7CA], a
    call BlinkCursorWD7CD_Bank1D_4F99
    ret

Jump_01D_4EF5::
    dec a
    ld [wD7CA], a
    ld b, a
    ld a, [wD7CB]
    or a, b
    jr nz, Jump_01D_4F09
    ld a, $01
    ld [wD7CB], a
    call DrawWD7CAWD7CBDigitsAtScroll161
    ret

Jump_01D_4F09::
    call BlinkCursorWD7CD_Bank1D_4F99
    ret

Jump_01D_4F0D::
    ld a, [wD7CA]
    and a, a
    jr nz, Jump_01D_4F1C
    ld a, [wD7CB]
    cp a, $01
    jr nz, Jump_01D_4F45
    jr Jump_01D_4F22

Jump_01D_4F1C::
    ld a, [wD7CB]
    and a, a
    jr nz, Jump_01D_4F45

Jump_01D_4F22::
    ld a, [wD7D3]
    ld b, a
    ld a, [wD7CA]
    cp a, b
    jr c, Jump_01D_4F3C
    ld a, [wD7D3]
    ld [wD7CA], a
    ld a, [wD7D4]
    ld [wD7CB], a
    call DrawWD7CAWD7CBDigitsAtScroll161
    ret

Jump_01D_4F3C::
    ld a, $09
    ld [wD7CB], a
    call BlinkCursorWD7CD_Bank1D_4F99
    ret

Jump_01D_4F45::
    dec a
    ld [wD7CB], a
    call BlinkCursorWD7CD_Bank1D_4F99
    ret

Jump_01D_4F4D::
    call ScriptCommandE5_Run_Case03_Case0D_Sub01_Sub01
    ld a, [wD7CA]
    and a, a
    jr nz, Jump_01D_4F5B
    ld a, [wD7CB]
    and a, a
    ret z

Jump_01D_4F5B::
    ld a, $69
    call QueueSoundEffect
    ld a, [wD780]
    cp a, $03
    jr z, Jump_01D_4F6F
    call CheckWD7B0PlusNumberAtMost18
    and a, a
    jr z, Jump_01D_4F84
    jr Jump_01D_4F75

Jump_01D_4F6F::
    call ScriptCommandE5_Run_Case03_Case0D_Sub01_Sub02
    and a, a
    jr z, Jump_01D_4F84

Jump_01D_4F75::
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_4F84::
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; cycles wD7CD through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (after the joypad repeat timer reaches $14) (E-0122)
; 10 call sites from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case0D_Sub01)
; reads: wJoypadRepeatTimer, wD7CD, wD7CC, wD7CA, wD7CB
; writes: wD7CD
BlinkCursorWD7CD_Bank1D_4F99::
Func_01D_4F99:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, ScriptCommandE5_Run_Case03_Case0D_Sub01_Sub01
    ld a, [wD7CD]
    inc a
    ld [wD7CD], a
    cp a, $10
    jr c, ScriptCommandE5_Run_Case03_Case0D_Sub01_Sub01
    cp a, $18
    jr c, Jump_01D_4FC6
    xor a, a
    ld [wD7CD], a

; only called from ScriptCommandE5_Run_Case03_Case0D_Sub01 (E-0047)
; 3 call sites from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case0D_Sub01)
; reads: wD7CC, wD7CA, wD7CB
ScriptCommandE5_Run_Case03_Case0D_Sub01_Sub01::
Func_01D_4FB3:: ; address name
    ld a, [wD7CC]
    and a, a
    jr nz, Jump_01D_4FBE
    ld a, [wD7CA]
    jr Jump_01D_4FC1

Jump_01D_4FBE::
    ld a, [wD7CB]

Jump_01D_4FC1::
    add a, $E0
    ld b, a
    jr Jump_01D_4FC8

Jump_01D_4FC6::
    ld b, $CB

Jump_01D_4FC8::
    ld a, [wD7CC]
    add a, a
    ld hl, Data_01D_4FE5
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_01D_4FE5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $61, $01, $62, $01

; writes wD7CA and wD7CB as digit tiles ($E0 + n) at BGMapAddressAtScroll + $161 and + $162 (E-0120)
; 6 call sites from 2 routines (e.g. ScriptCommandE5_Run_Case03_Case0B_Sub01, ScriptCommandE5_Run_Case03_Case0D_Sub01)
; reads: wD7CA, wD7CB
DrawWD7CAWD7CBDigitsAtScroll161::
Func_01D_4FE9:: ; address name
    call BGMapAddressAtScroll_Bank1D
    ld de, $0161
    add hl, de
    ld a, [wD7CA]
    add a, $E0
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    call BGMapAddressAtScroll_Bank1D
    ld de, $0162
    add hl, de
    ld a, [wD7CB]
    add a, $E0
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; A = $FF when wD7B0 + TenTimesWD7CAPlusWD7CB exceeds $18, else 0 (E-0122)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case0D_Sub01)
; reads: wD7B0
CheckWD7B0PlusNumberAtMost18::
Func_01D_5012:: ; address name
    call TenTimesWD7CAPlusWD7CB
    ld a, [wD7B0]
    add a, l
    cp a, $18
    jr c, Jump_01D_5022
    jr z, Jump_01D_5022
    ld a, $FF
    ret

Jump_01D_5022::
    xor a, a
    ret

; only called from ScriptCommandE5_Run_Case03_Case0D_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case0D_Sub01)
; reads: wD7B6, wD7B5, wD7C3
; writes: wD7C3, wD7C5
; points at: wD7D5, wC635
ScriptCommandE5_Run_Case03_Case0D_Sub01_Sub02::
Func_01D_5024:: ; address name
    ld hl, wD7D5
    ld a, [wD7B6]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wD7B5]
    add_a_to_hl
    ld b, [hl]
    ld hl, wC635
    xor a, a
    ld [wD7C3], a
    ld c, $00

Jump_01D_5048::
    ld a, [hl+]
    cp a, b
    jr z, Jump_01D_506B
    and a, a
    jr z, Jump_01D_5056
    ld a, [wD7C3]
    inc a
    ld [wD7C3], a

Jump_01D_5056::
    inc hl
    inc c
    ld a, c
    cp a, $64
    jr c, Jump_01D_5048
    ld hl, wC635
    ld a, [wD7C3]
    add a, a
    add_a_to_hl
    ld a, b
    ld [hl+], a

Jump_01D_506B::
    ld a, [hl]
    push hl
    ld b, a
    call TenTimesWD7CAPlusWD7CB
    ld a, l
    add a, b
    cp a, $64
    jr nc, Jump_01D_5083
    pop hl
    ld [hl], a
    dec hl
    ld a, [hl]
    ld [wD7C5], a
    xor a, a
    ld [wD7C3], a
    ret

Jump_01D_5083::
    pop hl
    xor a, a
    ld [wD7C3], a
    ld a, $FF
    ret

; only called from ScriptCommandE5_Run_Case03_Case0E (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case0E)
; reads: wD7B6, wD7B5, wD7B0, wCF8B, wD781, wD7BC
; writes: wTwoChoiceCursor, wD7C3, wD7C5, wCF8B, wD781
; points at: wC635, wInventory
ScriptCommandE5_Run_Case03_Case0E_Sub01::
Func_01D_508B:: ; address name
    ld hl, wC635
    ld a, [wD7B6]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wD7B5]
    add a, a
    add_a_to_hl
    ld a, [hl+]
    ld b, a
    push hl
    call TenTimesWD7CAPlusWD7CB
    ld e, l
    pop hl
    push de
    ld a, [hl]
    sub a, e
    ld [hl], a
    pop de
    and a, a
    jr nz, Jump_01D_50BD
    dec hl
    xor a, a
    ld [hl], a

Jump_01D_50BD::
    ld hl, wInventory
    ld c, $00

Jump_01D_50C2::
    ld a, [hl]
    and a, a
    jr z, Jump_01D_50CC
    cp a, $FF
    jr z, Jump_01D_50CC
    jr Jump_01D_50CF

Jump_01D_50CC::
    ld a, b
    ld [hl], a
    dec e

Jump_01D_50CF::
    inc hl
    inc c
    ld a, e
    and a, a
    jr z, Jump_01D_50DA
    ld a, c
    cp a, $18
    jr c, Jump_01D_50C2

Jump_01D_50DA::
    call ScriptCommandE5_Run_Shared06
    ld a, [wD7B0]
    cp a, $18
    jr c, Jump_01D_50EB
    xor a, a
    ld [wTwoChoiceCursor], a
    jp Jump_01D_5168

Jump_01D_50EB::
    ld a, [wD7BC]
    and a, a
    jr nz, Jump_01D_50F9
    ld a, $01
    ld [wTwoChoiceCursor], a
    jp Jump_01D_5168

Jump_01D_50F9::
    ld a, $02
    ld [wTwoChoiceCursor], a
    jp Jump_01D_5168

; only called from ScriptCommandE5_Run_Case03_Case0E (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case0E)
; reads: wCF8B, wD781, wD7C5
; writes: wTwoChoiceCursor, wD7C3, wD7C5, wCF8B, wD781
; points at: wInventory, wC635
ScriptCommandE5_Run_Case03_Case0E_Sub02::
Func_01D_5101:: ; address name
    ld hl, wInventory
    ld c, $00

Jump_01D_5106::
    ld a, [hl]
    and a, a
    jr z, Jump_01D_5110
    cp a, $FF
    jr z, Jump_01D_5110
    jr Jump_01D_511E

Jump_01D_5110::
    inc hl
    inc c
    ld a, c
    cp a, $18
    jr c, Jump_01D_5106
    xor a, a
    ld [wTwoChoiceCursor], a
    jp Jump_01D_5168

Jump_01D_511E::
    ld hl, wC635
    ld de, $0000
    ld c, $00

Jump_01D_5126::
    inc hl
    ld a, [hl]
    add a, e
    ld e, a
    jr nc, Jump_01D_512D
    inc d

Jump_01D_512D::
    inc hl
    inc c
    ld a, c
    cp a, $64
    jr c, Jump_01D_5126
    ld a, d
    cp a, $26
    jr c, Jump_01D_5145
    ld a, e
    cp a, $AC
    jr c, Jump_01D_5145
    ld a, $01
    ld [wTwoChoiceCursor], a
    jr Jump_01D_5168

Jump_01D_5145::
    ld hl, wC635
    ld c, $00

Jump_01D_514A::
    ld a, [hl]
    and a, a
    jr z, Jump_01D_5163
    ld b, a
    ld a, [wD7C5]
    cp a, b
    jr nz, Jump_01D_515B
    inc hl
    ld a, [hl]
    cp a, $63
    jr c, Jump_01D_5163

Jump_01D_515B::
    inc hl
    inc hl
    inc c
    ld a, c
    cp a, $64
    jr c, Jump_01D_514A

Jump_01D_5163::
    ld a, $02
    ld [wTwoChoiceCursor], a

Jump_01D_5168::
    xor a, a
    ld [wD7C3], a
    ld [wD7C5], a
    ld a, [wCF8B]
    inc a
    and a, $01
    ld [wCF8B], a
    farcall Run64C7UnlessWD780Is3
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret
    INCBIN "dwm2-cobi-us.gbc", $075186, $D3

; only called from ScriptCommandE5_Run_Case03_Case0F (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case0F)
; reads: wTwoChoiceCursor, wD781
; writes: wD781, wScriptCommandType, wScriptStartRequest, wD7B5, wD7B6
ScriptCommandE5_Run_Case03_Case0F_Sub01::
Func_01D_5259:: ; address name
    ld a, [wTwoChoiceCursor]
    cp a, $02
    jr z, Jump_01D_5271
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_5271::
    ld a, $07
    ld [wD781], a
    call BGMapAddressAtScroll_Bank1D
    ld de, $0161
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, $C3
    ld [hl+], a
    ld [hl], a
    ei
    xor a, a
    ld [wD7B5], a
    ld [wD7B6], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; draws rect $0147 (3 x 13) at vBGMap1 + $370, wD781 += 1, clears wD7CD-wD7D0 and sets wD7CC = 2 (E-0122)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case11)
; reads: wD781
; writes: wD781, wD7CD, wD7CE, wD7CF, wD7D0, wD7CC
DrawRect0147AndResetWD7CC::
Func_01D_5297:: ; address name
    ld hl, $0147
    ld de, vBGMap1 + $370
    ld bc, $030D
    call SaveBGMapRectWithAttrs
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wD7CD], a
    ld [wD7CE], a
    ld [wD7CF], a
    ld [wD7D0], a
    ld a, $02
    ld [wD7CC], a
    ret

; only called from routines of ScriptCommandE5_Run (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommandE5_Run_Case03_Case13, ScriptCommandE5_Run_Case03_Case17)
; reads: hFFC8, hFFC7, hFFC6, wIsCGB, wD781
; writes: wC8C0, wC8C1, wC8C2, wD7BD, wD7BE, wD7BF, wD7C0, wD7C1, ...
; points at: wD788, wC61A, wD7BD, wD793
ScriptCommandE5_Run_Shared02::
Func_01D_52BD:: ; address name
    ld hl, wD788
    ld de, Data_01D_53A2
    ld c, $00

Jump_01D_52C5::
    ld a, [de]
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $27
    jr c, Jump_01D_52C5
    ld hl, wC61A
    ld a, [hl+]
    ld [wC8C0], a
    ld a, [hl+]
    ld [wC8C1], a
    ld a, [hl]
    ld [wC8C2], a
    call Number24ToPackedBCD
    ldh a, [hFFC8]
    and a, $F0
    swap a
    ld [wD7BD], a
    ldh a, [hFFC8]
    and a, $0F
    ld [wD7BE], a
    ldh a, [hFFC7]
    and a, $F0
    swap a
    ld [wD7BF], a
    ldh a, [hFFC7]
    and a, $0F
    ld [wD7C0], a
    ldh a, [hFFC6]
    and a, $F0
    swap a
    ld [wD7C1], a
    ldh a, [hFFC6]
    and a, $0F
    ld [wD7C2], a
    ld hl, wD7BD
    ld c, $00

Jump_01D_5315::
    ld a, [hl]
    and a, a
    jr nz, Jump_01D_5323
    add a, $E3
    ld [hl], a
    inc c
    inc hl
    ld a, c
    cp a, $05
    jr c, Jump_01D_5315

Jump_01D_5323::
    ld hl, wD7BD
    ld de, wD793
    ld a, [hl+]
    add a, $E0
    ld [de], a
    inc de
    ld a, [hl+]
    add a, $E0
    ld [de], a
    inc de
    ld a, [hl+]
    add a, $E0
    ld [de], a
    inc de
    ld a, [hl+]
    add a, $E0
    ld [de], a
    inc de
    ld a, [hl+]
    add a, $E0
    ld [de], a
    inc de
    ld a, [hl]
    add a, $E0
    ld [de], a
    call BGMapAddressAtScroll_Bank1D
    ld de, $014B
    add hl, de
    ld de, wD788
    ld bc, $0903
    call ClearRectSetWC554Plus21_Bank1D
    ld a, [wIsCGB]
    and a, a
    jr nz, Jump_01D_5364
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01D_5364::
    call BGMapAddressAtScroll_Bank1D
    ld de, $014B
    add hl, de
    ld bc, $0000

Jump_01D_536E::
    push hl

Jump_01D_536F::
    push bc
    ld c, $4F
    ld a, $01
    ldh [c], a
    pop bc
    di
    call WaitForVRAMAccess
    xor a, a
    ld [hl+], a
    ei
    push bc
    ld c, $4F
    xor a, a
    ldh [c], a
    pop bc
    inc c
    ld a, c
    cp a, $09
    jr c, Jump_01D_536F
    pop hl
    ld c, $00
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc b
    ld a, b
    cp a, $03
    jr c, Jump_01D_536E
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Data_01D_53A2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $BF, $C3, $C3, $C3, $C3, $C3
    db $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; only called from ScriptCommandE5_Run_Case03_Case14 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case14)
; reads: wD7CE, wD7CF, wD7D0, wD780, hFFC8, hFFC7, wD781, wC61C, ...
; writes: wD78A, wD78B, wD78C, wC8C0, wC8C1, wC8C2, wD7D3, wD7D4, ...
; points at: wD788, wGoldLo, wC61A
ScriptCommandE5_Run_Case03_Case14_Sub01::
Func_01D_53BD:: ; address name
    ld hl, wD788
    ld de, Data_01D_548D
    ld c, $00

Jump_01D_53C5::
    ld a, [de]
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $10
    jr c, Jump_01D_53C5
    ld a, [wD7CE]
    add a, $E0
    ld [wD78A], a
    ld a, [wD7CF]
    add a, $E0
    ld [wD78B], a
    ld a, [wD7D0]
    add a, $E0
    ld [wD78C], a
    call BGMapAddressAtScroll_Bank1D
    ld de, $006C
    add hl, de
    ld de, wD788
    ld bc, $0802
    call ClearRectSetWC554Plus21_Bank1D
    ld a, [wD780]
    cp a, $03
    jp nz, Jump_01D_5438
    ld hl, wGoldLo
    ld a, [hl+]
    ld [wC8C0], a
    ld a, [hl+]
    ld [wC8C1], a
    ld a, [hl]
    ld [wC8C2], a
    call Number24ToPackedBCD
    ldh a, [hFFC8]
    and a, $0F
    ld [wD7D3], a
    ldh a, [hFFC7]
    and a, $F0
    swap a
    ld [wD7D4], a
    ldh a, [hFFC7]
    and a, $0F
    ld [wD7D5], a

Jump_01D_5427::
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_5438::
    ld a, [wC61C]
    cp a, $01
    jr c, Jump_01D_5461
    jr nz, Jump_01D_5453
    ld a, [wC61B]
    cp a, $86
    jr c, Jump_01D_5461
    jr nz, Jump_01D_5453
    ld a, [wC61A]
    cp a, $3C
    jr c, Jump_01D_5461
    jr z, Jump_01D_5461

Jump_01D_5453::
    ld a, $09
    ld [wD7D3], a
    ld [wD7D4], a
    ld [wD7D5], a
    jp Jump_01D_5427

Jump_01D_5461::
    ld hl, wC61A
    ld a, [hl+]
    ld [wC8C0], a
    ld a, [hl+]
    ld [wC8C1], a
    ld a, [hl]
    ld [wC8C2], a
    call Number24ToPackedBCD
    ldh a, [hFFC8]
    and a, $0F
    ld [wD7D3], a
    ldh a, [hFFC7]
    and a, $F0
    swap a
    ld [wD7D4], a
    ldh a, [hFFC7]
    and a, $0F
    ld [wD7D5], a
    jp Jump_01D_5427

Data_01D_548D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B6, $BF, $C3, $C3, $C3, $E0, $E0, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; only called from ScriptCommandE5_Run_Case03_Case15 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case15)
; reads: wD781, wD7CE, wD7CF, wD7D0, wC61A, wC61B, wC61C, wGoldLo, ...
; writes: wD781, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wC61C, wC61B, wC61A, wGoldHi, ...
ScriptCommandE5_Run_Case03_Case15_Sub01::
Func_01D_549D:: ; address name
    call ScriptCommandE5_Run_Shared04
    and a, a
    ret z
    cp a, $01
    jr z, Jump_01D_54B3
    cp a, $02
    jr z, Jump_01D_54AB
    ret

Jump_01D_54AB::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01D_54B3::
    call DrawThreeDigitsAtScrollOffset6E
    ld a, [wD7CE]
    and a, a
    jr nz, Jump_01D_54C9
    ld a, [wD7CF]
    and a, a
    jr nz, Jump_01D_54C9
    ld a, [wD7D0]
    and a, a
    jr nz, Jump_01D_54C9
    ret

Jump_01D_54C9::
    ld a, [wD7CE]
    ld bc, $2710
    call Multiply8By16
    ld d, $00
    push de
    push hl
    ld a, [wD7CF]
    ld bc, $03E8
    call Multiply8By16

Jump_01D_54DF::
    ld a, h
    ld c, a
    ld a, e
    ld b, a
    ld a, l
    pop hl
    pop de
    add a, l
    ld l, a
    ld a, h
    adc a, c
    ld h, a
    ld a, b
    adc a, e
    ld e, a
    inc d
    ld a, d
    cp a, $02
    jr nc, Jump_01D_5501
    push de
    push hl
    ld a, [wD7D0]
    ld bc, $0064
    call Multiply8By16
    jr Jump_01D_54DF

Jump_01D_5501::
    push de
    push hl
    ld a, [wC61A]
    add a, l
    ld l, a
    ld a, [wC61B]
    adc a, h
    ld h, a
    ld a, [wC61C]
    adc a, e
    ld e, a
    ld a, e
    cp a, $0F
    jr c, Jump_01D_5536
    jr nz, Jump_01D_5525
    ld a, h
    cp a, $41
    jr c, Jump_01D_5536
    jr nz, Jump_01D_5525
    ld a, l
    cp a, $DD
    jr c, Jump_01D_5536

Jump_01D_5525::
    pop hl
    pop de
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_5536::
    ld a, e
    ld [wC61C], a
    ld a, h
    ld [wC61B], a
    ld a, l
    ld [wC61A], a
    pop hl
    pop de
    ld a, [wGoldLo]
    sub a, l
    ld l, a
    ld a, [wGoldMid]
    sbc a, h
    ld h, a
    ld a, [wGoldHi]
    sbc a, e
    ld [wGoldHi], a
    ld a, h
    ld [wGoldMid], a
    ld a, l
    ld [wGoldLo], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from ScriptCommandE5_Run_Case04_Case15 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case04_Case15)
; reads: wD781, wD7CE, wD7CF, wD7D0, wGoldLo, wGoldMid, wGoldHi, wC61A, ...
; writes: wD781, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wGoldHi, wGoldMid, wGoldLo, wC61C, ...
ScriptCommandE5_Run_Case04_Case15_Sub01::
Func_01D_5573:: ; address name
    call ScriptCommandE5_Run_Shared04
    and a, a
    ret z
    cp a, $01
    jr z, Jump_01D_5589
    cp a, $02
    jr z, Jump_01D_5581
    ret

Jump_01D_5581::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_01D_5589::
    call DrawThreeDigitsAtScrollOffset6E
    ld a, [wD7CE]
    and a, a
    jr nz, Jump_01D_559F
    ld a, [wD7CF]
    and a, a
    jr nz, Jump_01D_559F
    ld a, [wD7D0]
    and a, a
    jr nz, Jump_01D_559F
    ret

Jump_01D_559F::
    ld a, [wD7CE]
    ld bc, $2710
    call Multiply8By16
    ld d, $00
    push de
    push hl
    ld a, [wD7CF]
    ld bc, $03E8
    call Multiply8By16

Jump_01D_55B5::
    ld a, h
    ld c, a
    ld a, e
    ld b, a
    ld a, l
    pop hl
    pop de
    add a, l
    ld l, a
    ld a, h
    adc a, c
    ld h, a
    ld a, b
    adc a, e
    ld e, a
    inc d
    ld a, d
    cp a, $02
    jr nc, Jump_01D_55D7
    push de
    push hl
    ld a, [wD7D0]
    ld bc, $0064
    call Multiply8By16
    jr Jump_01D_55B5

Jump_01D_55D7::
    push de
    push hl
    ld a, [wGoldLo]
    add a, l
    ld l, a
    ld a, [wGoldMid]
    adc a, h
    ld h, a
    ld a, [wGoldHi]
    adc a, e
    ld e, a
    ld a, e
    cp a, $01
    jr c, Jump_01D_560E
    jr nz, Jump_01D_55FD
    ld a, h
    cp a, $86
    jr c, Jump_01D_560E
    jr nz, Jump_01D_55FD
    ld a, l
    cp a, $9F
    jr c, Jump_01D_560E
    jr z, Jump_01D_560E

Jump_01D_55FD::
    pop hl
    pop de
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_560E::
    ld a, e
    ld [wGoldHi], a
    ld a, h
    ld [wGoldMid], a
    ld a, l
    ld [wGoldLo], a
    pop hl
    pop de
    ld a, [wC61A]
    sub a, l
    ld l, a
    ld a, [wC61B]
    sbc a, h
    ld h, a
    ld a, [wC61C]
    sbc a, e
    ld [wC61C], a
    ld a, h
    ld [wC61B], a
    ld a, l
    ld [wC61A], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from routines of ScriptCommandE5_Run (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommandE5_Run_Case04_Case15_Sub01, ScriptCommandE5_Run_Case03_Case15_Sub01)
; reads: wJoypadPressed, wJoypadPressedRepeat, wD7CC, wD7D3, wD7CE, wD7D4, wD7CF, wD7D5, ...
; writes: wD7CC, wD7CE, wD7CF, wD7D0, wD7D4
ScriptCommandE5_Run_Shared04::
Func_01D_564B:: ; address name
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, Jump_01D_5671
    bit 1, a
    jr nz, Jump_01D_5679
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jp nz, Jump_01D_567C
    bit 7, a
    jp nz, Jump_01D_5765
    bit 4, a
    jp nz, Jump_01D_5822
    bit 5, a
    jp nz, Jump_01D_5834
    call ScriptCommandE5_Run_Shared04_Sub01
    ret

Jump_01D_5671::
    ld a, $69
    call QueueSoundEffect
    ld a, $01
    ret

Jump_01D_5679::
    ld a, $02
    ret

Jump_01D_567C::
    ld a, $69
    call QueueSoundEffect
    ld a, [wD7CC]
    and a, a
    jr z, Jump_01D_568F
    cp a, $01
    jp z, Jump_01D_56E4
    jp Jump_01D_5725

Jump_01D_568F::
    ld a, [wD7D3]
    ld b, a
    ld a, [wD7CE]
    cp a, b
    jr c, Jump_01D_56D8
    jr z, Jump_01D_56C0
    ld a, [wD7D3]
    ld [wD7CE], a
    ld a, [wD7CF]
    ld b, a
    ld a, [wD7D4]
    cp a, b
    jr nc, Jump_01D_56BB
    ld [wD7CF], a
    ld a, [wD7D0]
    ld b, a
    ld a, [wD7D5]
    cp a, b
    jr nc, Jump_01D_56BB
    ld [wD7D0], a

Jump_01D_56BB::
    call DrawThreeDigitsAtScrollOffset6E
    xor a, a
    ret

Jump_01D_56C0::
    ld a, [wD7D4]
    ld b, a
    ld a, [wD7CF]
    cp a, b
    jr nc, Jump_01D_56CA

Jump_01D_56CA::
    ld a, [wD7D4]
    ld [wD7CF], a
    ld a, [wD7D5]
    ld [wD7D0], a
    jr Jump_01D_56BB

Jump_01D_56D8::
    inc a
    ld [wD7CE], a
    call ScriptCommandE5_Run_Shared04_Sub02
    call ScriptCommandE5_Run_Shared04_Sub01
    xor a, a
    ret

Jump_01D_56E4::
    ld a, [wD7D3]
    ld b, a
    ld a, [wD7CE]
    cp a, b
    jr nc, Jump_01D_570A
    ld a, [wD7CF]
    cp a, $09
    jr c, Jump_01D_56FE
    xor a, a
    ld [wD7CF], a
    call ScriptCommandE5_Run_Shared04_Sub01
    xor a, a
    ret

Jump_01D_56FE::
    inc a
    ld [wD7CF], a
    call ScriptCommandE5_Run_Shared04_Sub02
    call ScriptCommandE5_Run_Shared04_Sub01
    xor a, a
    ret

Jump_01D_570A::
    ld a, [wD7D4]
    ld b, a
    ld a, [wD7CF]
    cp a, b
    jr c, Jump_01D_56FE
    ld [wD7D4], a
    ld [wD7CF], a
    ld a, [wD7D5]
    ld [wD7D0], a
    call DrawThreeDigitsAtScrollOffset6E
    xor a, a
    ret

Jump_01D_5725::
    ld a, [wD7D3]
    ld b, a
    ld a, [wD7CE]
    cp a, b
    jr c, Jump_01D_574C
    ld a, [wD7D4]
    ld b, a
    ld a, [wD7CF]
    cp a, b
    jr c, Jump_01D_574C
    ld a, [wD7D5]
    ld b, a
    ld a, [wD7D0]
    cp a, b
    jr c, Jump_01D_575C
    ld a, b
    ld [wD7D0], a
    call ScriptCommandE5_Run_Shared04_Sub01
    xor a, a
    ret

Jump_01D_574C::
    ld a, [wD7D0]
    cp a, $09
    jr c, Jump_01D_575C
    xor a, a
    ld [wD7D0], a
    call ScriptCommandE5_Run_Shared04_Sub01
    xor a, a
    ret

Jump_01D_575C::
    inc a
    ld [wD7D0], a
    call ScriptCommandE5_Run_Shared04_Sub01
    xor a, a
    ret

Jump_01D_5765::
    ld a, $69
    call QueueSoundEffect
    ld a, [wD7CC]
    and a, a
    jr z, Jump_01D_5778
    cp a, $01
    jp z, Jump_01D_579E
    jp Jump_01D_57E4

Jump_01D_5778::
    ld a, [wD7CE]
    and a, a
    jr nz, Jump_01D_5795
    ld a, [wD7D3]
    ld [wD7CE], a
    ld a, [wD7D4]
    ld [wD7CF], a
    ld a, [wD7D5]
    ld [wD7D0], a
    call DrawThreeDigitsAtScrollOffset6E
    xor a, a
    ret

Jump_01D_5795::
    dec a
    ld [wD7CE], a
    call ScriptCommandE5_Run_Shared04_Sub01
    xor a, a
    ret

Jump_01D_579E::
    ld a, [wD7D3]
    ld b, a
    ld a, [wD7CE]
    cp a, b
    jr c, Jump_01D_57CB
    ld a, [wD7CF]
    and a, a
    jr nz, Jump_01D_57DB
    ld a, [wD7D4]
    ld [wD7CF], a
    ld a, [wD7D5]
    ld b, a
    ld a, [wD7D0]
    cp a, b
    jr c, Jump_01D_57C6
    jr z, Jump_01D_57C6
    ld a, [wD7D5]
    ld [wD7D0], a

Jump_01D_57C6::
    call DrawThreeDigitsAtScrollOffset6E
    xor a, a
    ret

Jump_01D_57CB::
    ld a, [wD7CF]
    and a, a
    jr nz, Jump_01D_57DB
    ld a, $09
    ld [wD7CF], a
    call ScriptCommandE5_Run_Shared04_Sub01
    xor a, a
    ret

Jump_01D_57DB::
    dec a
    ld [wD7CF], a
    call ScriptCommandE5_Run_Shared04_Sub01
    xor a, a
    ret

Jump_01D_57E4::
    ld a, [wD7D3]
    ld b, a
    ld a, [wD7CE]
    cp a, b
    jr c, Jump_01D_5809
    ld a, [wD7D4]
    ld b, a
    ld a, [wD7CF]
    cp a, b
    jr c, Jump_01D_5809
    ld a, [wD7D0]
    and a, a
    jr nz, Jump_01D_5819
    ld a, [wD7D5]
    ld [wD7D0], a
    call ScriptCommandE5_Run_Shared04_Sub01
    xor a, a
    ret

Jump_01D_5809::
    ld a, [wD7D0]
    and a, a
    jr nz, Jump_01D_5819
    ld a, $09
    ld [wD7D0], a
    call ScriptCommandE5_Run_Shared04_Sub01
    xor a, a
    ret

Jump_01D_5819::
    dec a
    ld [wD7D0], a
    call ScriptCommandE5_Run_Shared04_Sub01
    xor a, a
    ret

Jump_01D_5822::
    ld a, $69
    call QueueSoundEffect
    ld a, [wD7CC]
    cp a, $02
    jr nc, Jump_01D_5843
    inc a
    ld [wD7CC], a
    jr Jump_01D_5843

Jump_01D_5834::
    ld a, $69
    call QueueSoundEffect
    ld a, [wD7CC]
    and a, a
    jr z, Jump_01D_5843
    dec a
    ld [wD7CC], a

Jump_01D_5843::
    ld a, [wD7D3]
    ld b, a
    ld a, [wD7CE]
    cp a, b
    jr c, Jump_01D_5873
    ld a, [wD7D4]
    ld b, a
    ld a, [wD7CF]
    cp a, b
    jr c, Jump_01D_5873
    ld a, [wD7D5]
    ld b, a
    ld a, [wD7D0]
    cp a, b
    jr c, Jump_01D_5873
    ld a, [wD7D3]
    ld [wD7CE], a
    ld a, [wD7D4]
    ld [wD7CF], a
    ld a, [wD7D5]
    ld [wD7D0], a

Jump_01D_5873::
    call DrawThreeDigitsAtScrollOffset6E
    xor a, a
    ret

; only called from ScriptCommandE5_Run_Shared04 (E-0047)
; 13 call sites from 1 routine (e.g. ScriptCommandE5_Run_Shared04)
; reads: wJoypadRepeatTimer, wD7CD, wD7CC
; writes: wD7CD
; points at: wD7CE
ScriptCommandE5_Run_Shared04_Sub01::
Func_01D_5878:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, Jump_01D_5892
    ld a, [wD7CD]
    inc a
    ld [wD7CD], a
    cp a, $10
    jr c, Jump_01D_5892
    cp a, $18
    jr c, Jump_01D_58A3
    xor a, a
    ld [wD7CD], a

Jump_01D_5892::
    ld hl, wD7CE
    ld a, [wD7CC]
    add_a_to_hl
    ld a, [hl]
    add a, $E0
    ld b, a
    jr Jump_01D_58A5

Jump_01D_58A3::
    ld b, $CB

Jump_01D_58A5::
    ld a, [wD7CC]
    add a, a
    ld hl, Data_01D_58C2
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_01D_58C2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $6E, $00, $6F, $00, $70, $00

; writes the three bytes at wD7CE as digit tiles ($E0 + digit) at the BG map entry BGMapAddressAtScroll + $6E (row 3, column 14 of the view), one per byte with WaitForVRAMAccess (E-0104)
; 8 call sites from 4 routines (e.g. ScriptCommandE5_Run_Case04_Case15_Sub01, ScriptCommandE5_Run_Shared04, ScriptCommandE5_Run_Shared04_Sub02, ScriptCommandE5_Run_Case03_Case15_Sub01)
; points at: wD7CE
DrawThreeDigitsAtScrollOffset6E::
Func_01D_58C8:: ; address name
    call BGMapAddressAtScroll_Bank1D
    ld de, $006E
    add hl, de
    ld de, wD7CE
    ld c, $00

Jump_01D_58D4::
    ld a, [de]
    add a, $E0
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl+], a
    ei
    inc de
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_01D_58D4
    ret

; takes the byte at wC635 + 8 * wD7B6 + 2 * wD7B5 + 1 and stores its value / 10 in wD7D3 and value mod 10 in wD7D4 (E-0120)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case0B_Sub01)
; reads: wD7B6, wD7B5
; writes: wD7D4, wD7D3
; points at: wC635
SplitWC635EntryIntoDigits::
Func_01D_58E7:: ; address name
    ld hl, wC635
    ld a, [wD7B6]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wD7B5]
    add a, a
    add_a_to_hl
    inc hl
    ld l, [hl]
    ld h, $00
    ld a, $0A
    call DivideHLByA
    ld [wD7D4], a
    ld a, l
    ld [wD7D3], a
    ret

; copies a B x C rectangle of the BG map at scroll + HL (and its CGB attributes) to DE (E-0127)
; 3 call sites from 3 routines (e.g. DrawRect0088AtBGMap1370AndStep, DrawRect0140AtBGMap13E0AndStep, DrawRect0147AndResetWD7CC)
; reads: wIsCGB, wD7B8
; writes: wD7B8
SaveBGMapRectWithAttrs::
Func_01D_5917:: ; address name
    push bc
    push de
    push hl
    call BGMapAddressAtScroll_Bank1D
    ld e, l
    ld d, h
    pop hl
    add hl, de
    pop de
    pop bc
    ld a, c
    ld [wD7B8], a
    push hl
    push hl

Jump_01D_5929::
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ld [de], a
    ei
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_01D_594A
    push bc
    ld c, $4F
    ld a, $01
    ldh [c], a
    pop bc
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ld [de], a
    ei
    push bc
    ld c, $4F
    xor a, a
    ldh [c], a
    pop bc

Jump_01D_594A::
    inc hl
    inc de
    dec c
    jp nz, Jump_01D_5929
    ld a, [wD7B8]
    ld c, a
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    push hl
    dec b
    jp nz, Jump_01D_5929
    pop hl
    pop hl
    ret

; only called from ScriptCommandE5_Run_Case03_Case03_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE5_Run_Case03_Case03_Sub01)
; points at: wC635, wInventory
ScriptCommandE5_Run_Case03_Case03_Sub01_Sub01::
Func_01D_5965:: ; address name
    ld hl, wC635
    ld de, wInventory
    ld bc, $0000

Jump_01D_596E::
    ld a, [de]
    and a, a
    jr z, Jump_01D_598E
    cp a, $FF
    jr z, Jump_01D_598E
    push bc
    ld b, a
    ld c, $00
    ld a, [hl]
    cp a, b
    jr z, Jump_01D_599A
    and a, a
    jp z, Jump_01D_59B6
    pop bc
    inc hl
    inc hl
    inc c
    ld a, c
    cp a, $64
    jr c, Jump_01D_596E
    ld hl, wC635

Jump_01D_598E::
    inc de
    ld c, $00
    inc b
    ld a, b
    cp a, $18
    jr c, Jump_01D_596E

Jump_01D_5997::
    ld a, $FF
    ret

Jump_01D_599A::
    inc hl
    ld a, [hl]
    cp a, $63
    jr c, Jump_01D_59B6
    pop bc
    inc hl
    inc c
    ld a, c
    cp a, $64
    jr c, Jump_01D_596E
    ld hl, wC635
    inc de
    ld c, $00
    inc b
    ld a, b
    cp a, $18
    jr c, Jump_01D_596E
    jr Jump_01D_5997

Jump_01D_59B6::
    pop bc
    xor a, a
    ret

; A = 0 when one of the 100 two-byte entries at wC635 has a non-zero first byte, else $FF (E-0124)
; no direct call (reached through a table, a jump or a vector)
; points at: wC635
WC635HasNonZeroEntry:: ; heuristic: follows a terminator; C0
Func_01D_59B9:: ; address name
    ld hl, wC635
    ld c, $00

Jump_01D_59BE::
    ld a, [hl]
    and a, a
    jr nz, Jump_01D_59CD
    inc hl
    inc hl
    inc c
    ld a, c
    cp a, $64
    jr c, Jump_01D_59BE
    ld a, $FF
    ret

Jump_01D_59CD::
    xor a, a
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 23 call sites from 16 routines (e.g. LoadThreeTilesAndDrawRows4603To460B, ScriptCommandE5_Run_Shared03_Sub01, SaveBGMapRectWithAttrs, ScriptCommandE5_Run_Case03_Case07_Sub01, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank1D::
Func_01D_59CF:: ; address name
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

; clears a rectangle (Func_01D_5A4F with A = 0) and sets wC554 = HL + $1C1; on CGB also clears the attribute map in VRAM bank 1 (E-0121)
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wC554, wC555, rSVBK
ClearRectBothBanksSetWC554Plus1C1_Bank1D:: ; heuristic: follows a terminator; C0
Func_01D_59F0:: ; address name
    push de
    push bc
    push hl
    xor a, a
    call CopyRectToBGMapWrapped_Bank1D
    pop hl
    push hl
    ld a, l
    add a, $C1
    ld l, a
    ld a, h
    adc a, $01
    ld h, a
    ld a, l
    ld [wC554], a
    ld a, h
    ld [wC555], a
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
    xor a, a
    call CopyRectToBGMapWrapped_Bank1D
    call WaitForVRAMAccess
    ld a, $00
    ldh [rSVBK], a
    ld c, $4F
    ld a, $00
    ldh [c], a
    ret

; clears a rectangle (Func_01D_5A4F with A = 0) and sets wC554 = HL + $21 (E-0124)
; 8 call sites from 5 routines (e.g. LoadThreeTilesAndDrawRows4603To460B, ScriptCommandE5_Run_Case03_Case07_Sub01, ScriptCommandE5_Run_Case03_Case0A_Sub01, ScriptCommandE5_Run_Case03_Case14_Sub01, ...)
; writes: wC554, wC555
ClearRectSetWC554Plus21_Bank1D::
Func_01D_5A32:: ; address name
    push de
    push bc
    push hl
    xor a, a
    call CopyRectToBGMapWrapped_Bank1D
    pop hl
    push hl
    ld a, l
    add a, $21
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, l
    ld [wC554], a
    ld a, h
    ld [wC555], a
    pop hl
    pop bc
    pop de
    ret

; copies a B x C rectangle from DE to the BG map at HL, wrapping at the row and map edges (E-0125)
; 3 call sites from 2 routines (e.g. ClearRectSetWC554Plus21_Bank1D, ClearRectBothBanksSetWC554Plus1C1_Bank1D)
CopyRectToBGMapWrapped_Bank1D::
Func_01D_5A4F:: ; address name
    push hl
    push bc

Jump_01D_5A51::
    di
    call WaitForVRAMAccess
    ld a, [de]
    ei
    call WriteVRAMByteInc
    ld a, l
    and a, $1F
    jp nz, Jump_01D_5A68
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_01D_5A68::
    inc de
    dec b
    jr nz, Jump_01D_5A51
    pop bc
    pop hl
    dec c
    jr z, Jump_01D_5A7F
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, h
    and a, $9B
    ld h, a
    jr CopyRectToBGMapWrapped_Bank1D

Jump_01D_5A7F::
    ret

; HL = 10 * wD7CA + wD7CB (E-0120)
; 3 call sites from 3 routines (e.g. CheckWD7B0PlusNumberAtMost18, ScriptCommandE5_Run_Case03_Case0D_Sub01_Sub02, ScriptCommandE5_Run_Case03_Case0E_Sub01)
; reads: wD7CA, wD7CB
TenTimesWD7CAPlusWD7CB::
Func_01D_5A80:: ; address name
    ld a, [wD7CA]
    ld e, a
    ld l, a
    ld h, $00
    ld d, $00
    sla l
    rl h
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wD7CB]
    add_a_to_hl
    ret

; only called from ScriptCommandE5_Run_Shared04 (E-0047)
; 2 call sites from 1 routine (e.g. ScriptCommandE5_Run_Shared04)
; reads: wD7D3, wD7CE, wD7D4, wD7CF, wD7D5, wD7D0
; writes: wD7CE, wD7CF, wD7D0
ScriptCommandE5_Run_Shared04_Sub02::
Func_01D_5AA3:: ; address name
    ld a, [wD7D3]
    ld b, a
    ld a, [wD7CE]
    cp a, b
    jr c, Jump_01D_5ADE
    jr nz, Jump_01D_5AC9
    ld a, [wD7D4]
    ld b, a
    ld a, [wD7CF]
    cp a, b
    jr c, Jump_01D_5ADE
    jr nz, Jump_01D_5AC9
    ld a, [wD7D5]
    ld b, a
    ld a, [wD7D0]
    cp a, b
    jr c, Jump_01D_5ADE
    jr nz, Jump_01D_5AC9
    jr Jump_01D_5ADE

Jump_01D_5AC9::
    ld a, [wD7D3]
    ld [wD7CE], a
    ld a, [wD7D4]
    ld [wD7CF], a
    ld a, [wD7D5]
    ld [wD7D0], a
    call DrawThreeDigitsAtScrollOffset6E

Jump_01D_5ADE::
    ret

; only called from routines of ScriptCommandE5_Run (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommandE5_Run_Case03_Case07_Sub01, ScriptCommandE5_Run_Case03_Case08_Sub01)
; reads: wD780, wD7BC, wD7B6, wD7B5, wD7F1
; writes: wD7BB, wD7B6, wD7B7, wD7B5
ScriptCommandE5_Run_Shared05::
Func_01D_5ADF:: ; address name
    ld a, [wD780]
    cp a, $03
    jr z, Jump_01D_5AF1
    call ScriptCommandE5_Run_Shared06
    call CountNonZeroWD7D5Bytes
    ld a, [wD7BC]
    jr Jump_01D_5AF8

Jump_01D_5AF1::
    call ScriptCommandE5_Run_Shared06
    call CountNonZeroWD7D5Bytes
    ld a, c

Jump_01D_5AF8::
    ld l, a
    ld h, $00
    ld a, $04
    call DivideHLByA
    push af
    and a, a
    jr z, Jump_01D_5B05
    inc l

Jump_01D_5B05::
    ld a, l
    ld [wD7BB], a
    ld a, [wD7B6]
    inc a
    cp a, l
    jr c, Jump_01D_5B46
    pop af
    push af
    and a, a
    jr nz, Jump_01D_5B25
    ld a, [wD7B6]
    inc a
    cp a, l
    jr z, Jump_01D_5B46
    ld a, [wD7B6]
    dec a
    ld [wD7B6], a
    jr Jump_01D_5B46

Jump_01D_5B25::
    pop af
    dec a
    ld [wD7B7], a
    ld b, a
    ld a, [wD7B5]
    cp a, b
    jr c, Jump_01D_5B4C
    jr z, Jump_01D_5B4C
    push bc
    push hl
    ld a, [wD7F1]
    and a, a
    jr nz, Jump_01D_5B3E
    call ScriptCommandE5_Run_Shared05_Sub01

Jump_01D_5B3E::
    pop hl
    pop bc
    ld a, b
    ld [wD7B5], a
    jr Jump_01D_5B4C

Jump_01D_5B46::
    pop af
    ld a, $03
    ld [wD7B7], a

Jump_01D_5B4C::
    ret

; 4 call sites from 4 routines (e.g. ScriptCommandEB_Run_Case05_Case21, ScriptCommandEB_Run_Case06_Case04, ScriptCommandED_Run_Case07_Case0F, CallFunc5B4DInBank1D)
; reads: wD7F1, hFFC6, wC8C1, wC8C2, hFFC7, wC8C0
; writes: rRAMG2, rRAMB, wC386, wC389, wC38A
Func_01D_5B4D::
    ld a, [wD7F1]
    ld b, a
    push bc
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, b
    ld c, $0E
    ld b, $01
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    and a, $01
    add a, $CC
    ld [wC386], a
    pop bc
    push bc
    ld a, b
    ld c, $56
    ld b, $01
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigitsWC8C0
    ld a, [wC8C1]
    add a, $E0
    ld [wC389], a
    ld a, [wC8C2]
    add a, $E0
    ld [wC38A], a
    pop bc
    push bc
    ld c, $00

Jump_01D_5B98::
    push bc
    ld a, c
    ld hl, Data_01D_5BE6
    add_a_to_hl
    ld c, [hl]
    ld a, b
    ld b, $02
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
    call HLToDecimalDigits
    farcall BlankLeadingZeroDigitsWC8C0
    pop bc
    ld a, c
    add a, a
    ld hl, Data_01D_5BEA
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wC8C0]
    add a, $E0
    ld [de], a
    inc de
    ld a, [wC8C1]
    add a, $E0
    ld [de], a
    inc de
    ld a, [wC8C2]
    add a, $E0
    ld [de], a
    inc c
    ld a, c
    cp a, $04
    jr c, Jump_01D_5B98
    pop bc
    xor a, a
    ld [rRAMG2], a
    ret

Data_01D_5BE6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $5B, $5D, $5F, $61

Data_01D_5BEA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D4, $C3, $D8, $C3, $FC, $C3, $00, $C4

; saves wD7F1-wD7F9 and hFFC6-hFFD2, runs Func_01D_6899 for the record at WD789 cell 5, then restores them (E-0125)
; 6 call sites from 6 routines (e.g. GameMode5_Update_Case02, GameMode5_Update_Case04, RunWD06AState_6C12_Case08_Case04, ScriptCommandE8_Run_Case09_Case20_Case00, ...)
; writes: wD7F1, wD7F2
; points at: wRecordBuffer, wD7F1, hFFC6
CallFunc6899PreservingWD7F1AndHFFC6::
Func_01D_5BF2:: ; address name
    ld hl, wRecordBuffer
    ld de, wD7F1
    ld b, $09

Jump_01D_5BFA::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_01D_5BFA
    ld de, hFFC6
    ld b, $0D

Jump_01D_5C05::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_01D_5C05
    call SetWD7F5ToWD789Cell5
    ld c, $00
    ld a, l
    ld [wD7F1], a
    ld a, h
    ld [wD7F2], a
    call Func_01D_6899
    ld hl, wRecordBuffer
    ld de, wD7F1
    ld b, $09

Jump_01D_5C23::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_01D_5C23
    ld de, hFFC6
    ld b, $0D

Jump_01D_5C2E::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_01D_5C2E
    ret

; saves wD7F1-wD7F9 and hFFC6-hFFD2, draws the species sprite of the record at WD789 cell 5 at ($90, $40) (Func_01D_69DA), then restores them (E-0127)
; 6 call sites from 6 routines (e.g. GameMode5_Update_Case02, GameMode5_Update_Case04, RunWD06AState_6C12_Case08_Case04, ScriptCommandE8_Run_Case09_Case15_Case00, ...)
; reads: hFFC6, hFFC7
; writes: rRAMG2, rRAMB, wD7F1, wD7F2
; points at: wRecordBuffer, wD7F1, hFFC6
DrawWD789Cell5SpeciesSprite::
Func_01D_5C35:: ; address name
    ld hl, wRecordBuffer
    ld de, wD7F1
    ld b, $09

Jump_01D_5C3D::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_01D_5C3D
    ld de, hFFC6
    ld b, $0D

Jump_01D_5C48::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_01D_5C48
    call SetWD7F5ToWD789Cell5
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $0B
    call LoadSRAMRecordWord
    xor a, a
    ld [rRAMG2], a
    ldh a, [hFFC6]
    ld [wD7F1], a
    ldh a, [hFFC7]
    ld [wD7F2], a
    xor a, a
    ld h, a
    ld e, a
    ld l, $90
    ld d, $40
    ld c, $00
    call DrawSpeciesMetaSpriteAtScrollOffset
    ld hl, wRecordBuffer
    ld de, wD7F1
    ld b, $09

Jump_01D_5C82::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_01D_5C82
    ld de, hFFC6
    ld b, $0D

Jump_01D_5C8D::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_01D_5C8D
    ret

; with SRAM bank 0 enabled reads the record at WD789 cell 5 and continues at Jump_01D_5CAF (E-0126)
; no direct call (reached through a table, a jump or a vector)
; writes: rRAMG2, rRAMB, wC8D9
; points at: wC8CF, wC130
LoadWD789Cell5RecordAndContinue5CAF:: ; heuristic: follows a terminator; C0
Func_01D_5C94:: ; address name
    call SetWD7F5ToWD789Cell5
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    jr Jump_01D_5CAF

; only called from ScriptCommandEB_Run_Case05_Case3E (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandEB_Run_Case05_Case3E)
; reads: wD7B4
; writes: rRAMG2, rRAMB, wC8D9
; points at: wC8CF, wC130
ScriptCommandEB_Run_Case05_Case3E_Sub01::
Func_01D_5CA3:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7B4]

Jump_01D_5CAF::
    ld c, $01
    call CopyRecordNameToWC8CF
    ld a, $F0
    ld [wC8D9], a
    xor a, a
    ld [rRAMG2], a
    ld hl, wC8CF
    ld de, wC130
    ld c, $00

Jump_01D_5CC5::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_01D_5CD3
    ld [de], a
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_01D_5CC5

Jump_01D_5CD3::
    ld a, $F0
    ld [de], a
    ret

; record wD7F1: draws its name at vTiles1 + $780 and the name of its species (field $0B) at vTiles1 + $270 (E-0127)
; 11 call sites from 11 routines (e.g. ScriptCommandF4_Run_Case11_Case07, ScriptCommandEB_Run_Case05_Case23, ScriptCommandED_Run_Case04_Case06, ScriptCommandED_Run_Case07_Case11, ...)
; reads: wD7F1, hFFC6, hFFC7, wDataBank
; writes: rRAMG2, rRAMB, wC8D9, wDataBank
; points at: wC8CF
DrawRecordNameAndSpeciesNameTiles::
Func_01D_5CD7:: ; address name
    ld a, [wD7F1]
    ld b, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    push bc
    ld a, b
    ld c, $01
    call CopyRecordNameToWC8CF
    ld a, $F0
    ld [wC8D9], a
    ld de, vTiles1 + $780
    call CopyGlyphTilesToVRAM
    pop bc
    push bc
    ld a, b
    ld c, $0B
    ld b, $02
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
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
    ld de, vTiles1 + $270
    call CopyGlyphTilesToVRAM
    pop bc
    xor a, a
    ld [rRAMG2], a
    ret

; entry wD7FC (3 bytes per entry): decompresses the tiles named at Data_01D_5D78 to vTiles2 and copies the $40-byte palette named at Data_01D_5D7E into wBGPaletteBuffer (E-0120)
; 1 call site from 1 routine (e.g. ScriptCommandE8_Run_Case09_Case08)
; reads: wD7FC
; points at: wBGPaletteBuffer
LoadAreaGraphicsForWD7FC::
Func_01D_5D47:: ; address name
    ld a, [wD7FC]
    ld c, a
    add a, a
    add a, c
    push af
    ld hl, Data_01D_5D78
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld b, [hl]
    ld hl, vTiles2
    call DecompressToVRAM
    pop af
    ld hl, Data_01D_5D7E
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld b, [hl]
    ld hl, wBGPaletteBuffer
    ld c, $40
    call CopyFromBankWaitVRAM
    ret

Data_01D_5D78:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $40, $93, $DE, $4D, $47

Data_01D_5D7E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $40, $48, $46, $52, $47

; wD7F5/wD7F6 (big-endian pointer) = wD789 + 5 * wD7AF + wD7AB
; 67 call sites from 58 routines (e.g. CallFunc6899PreservingWD7F1AndHFFC6, DrawWD789Cell5SpeciesSprite, ShowCategory11StringOfWD789Cell5Record, ShowSpeciesCategory13StringOfWD789Cell5Record, ...)
; reads: wD7AF, wD7AB
; writes: wD7F5, wD7F6
; points at: wD789
SetWD7F5ToWD789Cell5::
Func_01D_5D84:: ; address name
    ld a, [wD7AF]
    ld b, a
    add a, a
    add a, a
    add a, b
    ld b, a
    ld a, [wD7AB]
    add a, b
    ld hl, wD789
    add_a_to_hl
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ret

; wD7F5/wD7F6 (big-endian pointer) = wD789 + 4 * wD7AF + wD7AB
; 28 call sites from 28 routines (e.g. ScriptCommandEF_Run_Case05_Case0F, ScriptCommandEF_Run_Case05_Case12_Case06, GetWD789Cell4AddressWithSRAM, ScriptCommandEF_Run_Shared01, ...)
; reads: wD7AF, wD7AB
; writes: wD7F5, wD7F6
; points at: wD789
SetWD7F5ToWD789Cell4::
Func_01D_5DA1:: ; address name
    ld a, [wD7AF]
    add a, a
    add a, a
    ld b, a
    ld a, [wD7AB]
    add a, b
    ld hl, wD789
    add_a_to_hl
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ret

; shows string (field $A4 of the record at WD789 cell 5) of category $0B at $9320 with size $0602 (E-0121)
; 1 call site from 1 routine (e.g. ScriptCommandE8_Run_Case09_Case14)
; reads: wD7F5, wD7F6, hFFC6
; writes: rRAMG2, rRAMB, wStringIndex, wStringCategory
; points at: wC52D
ShowCategory11StringOfWD789Cell5Record::
Func_01D_5DBC:: ; address name
    call SetWD7F5ToWD789Cell5
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld c, $A4
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    ld [wStringIndex], a
    ld a, $0B
    ld [wStringCategory], a
    xor a, a
    ld [rRAMG2], a
    ld hl, wC52D
    ld a, $20
    ld [hl+], a
    ld a, $93
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $06
    farcall ShowString_Bank08
    ret

; loads the species of the record at WD789 cell 5 (field $0B) and shows string [wD013] of category $0D at $9680 with size $0602 (E-0121)
; 1 call site from 1 routine (e.g. ScriptCommandE8_Run_Case09_Case1A)
; reads: hFFC6, hFFC7, wD013
; writes: rRAMG2, rRAMB, wSpeciesIdLo, wSpeciesIdHi, wStringIndex, wStringCategory
; points at: wC52D
ShowSpeciesCategory13StringOfWD789Cell5Record::
Func_01D_5DF9:: ; address name
    call SetWD7F5ToWD789Cell5
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $0B
    call LoadSRAMRecordWord
    xor a, a
    ld [rRAMG2], a
    ldh a, [hFFC6]
    ld [wSpeciesIdLo], a
    ldh a, [hFFC7]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld a, [wD013]
    ld [wStringIndex], a
    ld a, $0D
    ld [wStringCategory], a
    ld hl, wC52D
    ld a, $80
    ld [hl+], a
    ld a, $96
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $06
    farcall ShowString_Bank08
    ret

; over the first wD7FF SRAM records ($A5 bytes each from sA000; wD7FF is set by LoadWD7FFFromWC7C7Table): wD7AA = how many have byte 0 equal to 1 or 2 (in use) (E-0104)
; 13 call sites from 13 routines (e.g. ScriptCommandEB_Run_Case01_Case03, ScriptCommandEB_Run_Case05_Case2C, ScriptCommandEB_Run_Case05_Case0F, ScriptCommandEB_Run_Case04_Case2F, ...)
; reads: wD7AA
; writes: wD7AA, rRAMG2, rRAMB
; points at: sA000
CountRecordsInUse::
Func_01D_5E3F:: ; address name
    call LoadWD7FFFromWC7C7Table
    ld d, c
    xor a, a
    ld [wD7AA], a
    ld hl, sA000
    ld b, $00
    ld c, $A5

Jump_01D_5E4E::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    cp a, $01
    jr z, Jump_01D_5E62
    cp a, $02
    jr z, Jump_01D_5E62
    jr Jump_01D_5E69

Jump_01D_5E62::
    ld a, [wD7AA]
    inc a
    ld [wD7AA], a

Jump_01D_5E69::
    inc b
    ld a, c
    add_a_to_hl
    ld a, b
    cp a, d
    jr c, Jump_01D_5E4E
    xor a, a
    ld [rRAMG2], a
    ret

; clears the wD789 list, then lists the party records whose SRAM record byte 0 is 2 and counts them in wD7A9 (E-0127)
; 19 call sites from 19 routines (e.g. ScriptCommandE8_Run_Case03_Sub01, ScriptCommandEB_Run_Case01_Case02, ScriptCommandEB_Run_Case05_Case40, ScriptCommandEB_Run_Case05_Case0E, ...)
; reads: wD7A9, wC6FD
; writes: wD7A9, rRAMG2, rRAMB
; points at: wD789, wC6FE, sA000
ListPartyRecordsWithState2ToWD789::
Func_01D_5E79:: ; address name
    call LoadWD7FFFromWC7C7Table
    ld b, c
    ld hl, wD789

Jump_01D_5E80::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_01D_5E80
    xor a, a
    ld [wD7A9], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld de, wC6FE
    ld b, $00

Jump_01D_5E97::
    ld a, [de]
    ld c, a
    ld a, $A5
    push bc
    push de
    call Multiply8
    ld de, sA000
    add hl, de
    ld a, [hl]
    cp a, $02
    jr nz, Jump_01D_5EC0
    pop de
    pop bc
    ld hl, wD789
    ld a, b
    add_a_to_hl
    ld a, [de]
    ld [hl], a
    inc b
    ld a, [wD7A9]
    inc a
    ld [wD7A9], a
    jr Jump_01D_5EC2

Jump_01D_5EC0::
    pop de
    pop bc

Jump_01D_5EC2::
    inc de
    ld a, [wC6FD]
    cp a, b
    jr nz, Jump_01D_5E97
    xor a, a
    ld [rRAMG2], a
    ret

; over the first wD7FF SRAM records ($A5 bytes each from sA000; wD7FF is set by LoadWD7FFFromWC7C7Table): clears the 30-byte list wD789, then appends the number of every record whose byte 0 is 1 and byte $6E is 0; wD7A9 = the list length, wD7B9 = how many state-1 records had byte $6E set (E-0104)
; 12 call sites from 11 routines (e.g. ScriptCommandEB_Run_Case03, StartRecordListOrNoneMessage, ScriptCommandEB_Run_Case05_Case32, ScriptCommandEB_Run_Case05_Case3C, ...)
; reads: wD7FF, wD7B9
; writes: wD7A9, rRAMG2, rRAMB, wD7B9
; points at: wD789, sA000
ListRecordsState1WithByte6EClear::
Func_01D_5ECE:: ; address name
    call LoadWD7FFFromWC7C7Table
    ld hl, wD789
    ld b, $1E

Jump_01D_5ED6::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_01D_5ED6
    xor a, a
    ld [wD7A9], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld [wD7B9], a
    ld de, sA000
    ld hl, wD789
    ld b, $00
    ld c, $00

Jump_01D_5EF5::
    ld a, [de]
    cp a, $01
    jr nz, Jump_01D_5F14
    push de
    ld a, $6E
    add a, e
    ld e, a
    jr nc, Jump_01D_5F02
    inc d

Jump_01D_5F02::
    ld a, [de]
    and a, a
    jr nz, Jump_01D_5F0C
    pop de
    inc c
    ld a, b
    ld [hl+], a
    jr Jump_01D_5F14

Jump_01D_5F0C::
    pop de
    ld a, [wD7B9]
    inc a
    ld [wD7B9], a

Jump_01D_5F14::
    ld a, $A5
    add a, e
    ld e, a
    jr nc, Jump_01D_5F1B
    inc d

Jump_01D_5F1B::
    inc b
    ld a, [wD7FF]
    cp a, b
    jr nz, Jump_01D_5EF5
    jr c, Jump_01D_5EF5
    ld a, c
    ld [wD7A9], a
    xor a, a
    ld [rRAMG2], a
    ret

; over the first wD7FF SRAM records ($A5 bytes each from sA000; wD7FF is set by LoadWD7FFFromWC7C7Table): clears wD789 and wD7BE (30 bytes each), then appends every record whose byte 0 is 1 or 2 and byte $6E is 0; wD7A9 = the list length, wD7B9 = how many in-use records had byte $6E set (E-0104)
; 13 call sites from 13 routines (e.g. ScriptCommandEB_Run_Case03, ScriptCommandED_Run_Case04_Case02, ScriptCommandED_Run_Case11_Case02, Func_016_5D13_Case10, ...)
; reads: wD7FF, wD7A9, wC6FD, wD7B9
; writes: wD7A9, rRAMG2, rRAMB, wD7B9
; points at: wD789, wD7BE, sA000, wC6FE
ListRecordsInUseWithByte6EClear::
Func_01D_5F2D:: ; address name
    call LoadWD7FFFromWC7C7Table
    ld hl, wD789
    ld b, $1E

Jump_01D_5F35::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_01D_5F35
    ld hl, wD7BE
    ld b, $1E

Jump_01D_5F3F::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_01D_5F3F
    xor a, a
    ld [wD7A9], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld [wD7B9], a
    ld de, sA000
    ld hl, wD789
    ld b, $00
    ld c, $00

Jump_01D_5F5E::
    ld a, [de]
    and a, a
    jr z, Jump_01D_5F86
    cp a, $01
    jr z, Jump_01D_5F6C
    cp a, $02
    jr z, Jump_01D_5F6C
    jr Jump_01D_5F86

Jump_01D_5F6C::
    push de
    ld a, $6E
    add a, e
    ld e, a
    jr nc, Jump_01D_5F74
    inc d

Jump_01D_5F74::
    ld a, [de]
    and a, a
    jr nz, Jump_01D_5F7E
    pop de
    inc c
    ld a, b
    ld [hl+], a
    jr Jump_01D_5F86

Jump_01D_5F7E::
    pop de
    ld a, [wD7B9]
    inc a
    ld [wD7B9], a

Jump_01D_5F86::
    ld a, $A5
    add a, e
    ld e, a
    jr nc, Jump_01D_5F8D
    inc d

Jump_01D_5F8D::
    inc b
    ld a, [wD7FF]
    cp a, b
    jr nz, Jump_01D_5F5E
    ld a, c
    ld [wD7A9], a
    xor a, a
    ld [rRAMG2], a

; 3 call sites from 3 routines (e.g. ScriptCommandED_Run_Shared05, Func_01B_7399, Func_033_5F99)
; reads: wD7A9, wC6FD
; points at: wD789, wC6FE, wD7BE
Func_01D_5F9C::
    ld a, [wD7A9]
    and a, a
    ret z
    ld hl, wD789
    ld de, wC6FE
    ld bc, $0000

Jump_01D_5FAA::
    push hl
    push de
    push bc
    ld b, $00

Jump_01D_5FAF::
    ld a, [de]
    ld c, a
    ld a, [hl]
    cp a, c
    jr z, Jump_01D_5FC4
    inc b
    inc hl
    ld a, [wD7A9]
    ld c, a
    ld a, b
    cp a, c
    jr c, Jump_01D_5FAF
    pop bc
    pop de
    pop hl
    jr Jump_01D_5FD6

Jump_01D_5FC4::
    ld a, $FF
    ld [hl], a
    pop bc
    ld hl, wD7BE
    ld a, b
    add_a_to_hl
    ld a, [de]
    ld [hl], a
    pop de
    pop hl
    inc b

Jump_01D_5FD6::
    inc c
    inc de
    ld a, [wC6FD]
    cp a, c
    jr nz, Jump_01D_5FAA
    ld hl, wD7BE
    ld a, b
    add_a_to_hl
    ld de, wD789
    ld a, [wD7A9]
    ld c, a

Jump_01D_5FEE::
    ld a, [de]
    cp a, $FF
    jr z, Jump_01D_5FF4
    ld [hl+], a

Jump_01D_5FF4::
    inc de
    dec c
    jr nz, Jump_01D_5FEE
    ld hl, wD7BE
    ld de, wD789
    ld a, [wD7A9]
    ld b, a

Jump_01D_6002::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_01D_6002
    ld a, [wD7A9]
    cp a, $1E
    jr nc, Jump_01D_6025
    ld hl, wD789
    add_a_to_hl
    ld a, [wD7A9]
    ld b, a
    ld a, $1E
    sub a, b
    ld b, a

Jump_01D_601F::
    ld a, $FF
    ld [hl+], a
    dec b
    jr nz, Jump_01D_601F

Jump_01D_6025::
    ret

; over the first wD7FF SRAM records ($A5 bytes each from sA000; wD7FF is set by LoadWD7FFFromWC7C7Table): clears wD789, then appends every record whose byte 0 is 1 or 2 and byte $6E is non-zero; wD7A9 = the list length (E-0104)
; 10 call sites from 10 routines (e.g. ScriptCommandEF_Run_Case03, ScriptCommandED_Run_Case03, ScriptCommandED_Run_Case04_Case41, ScriptCommandED_Run_Case05_Case01, ...)
; reads: wD7FF
; writes: wD7A9, rRAMG2, rRAMB, wD7B9
; points at: wD789, sA000
ListRecordsInUseWithByte6ESet::
Func_01D_6026:: ; address name
    call LoadWD7FFFromWC7C7Table
    ld hl, wD789
    ld b, $1E

Jump_01D_602E::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_01D_602E
    xor a, a
    ld [wD7A9], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld [wD7B9], a
    ld de, sA000
    ld hl, wD789
    ld b, $00
    ld c, $00

Jump_01D_604D::
    ld a, [de]
    and a, a
    jr z, Jump_01D_606E
    cp a, $01
    jr z, Jump_01D_605B
    cp a, $02
    jr z, Jump_01D_605B
    jr Jump_01D_606E

Jump_01D_605B::
    push de
    ld a, $6E
    add a, e
    ld e, a
    jr nc, Jump_01D_6063
    inc d

Jump_01D_6063::
    ld a, [de]
    and a, a
    jr z, Jump_01D_606D
    pop de
    inc c
    ld a, b
    ld [hl+], a
    jr Jump_01D_606E

Jump_01D_606D::
    pop de

Jump_01D_606E::
    ld a, $A5
    add a, e
    ld e, a
    jr nc, Jump_01D_6075
    inc d

Jump_01D_6075::
    inc b
    ld a, [wD7FF]
    cp a, b
    jr nz, Jump_01D_604D
    ld a, c
    ld [wD7A9], a
    ld [wD7B9], a
    xor a, a
    ld [rRAMG2], a
    ret

; 8 call sites from 8 routines (e.g. ScriptCommandEF_Run_Case0F_Case04, ScriptCommandED_Run_Case05_Case04, ScriptCommandED_Run_Case0F_Case04, ScriptCommandE8_Run_Case06_Case19, ...)
; reads: wD7AF, wD7B1, wD7A9, hFFC6, hFFC7, wDataBank, wD7B0
; writes: rRAMG2, rRAMB, wDataBank, wC8DE
; points at: wD789, wC8CF
Func_01D_6088::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wD789
    ld a, [wD7AF]
    add a, a
    add a, a
    add_a_to_hl
    ld c, $00

Jump_01D_60A0::
    ld a, [wD7B1]
    cp a, $03
    jr c, Jump_01D_60AC
    ld a, [wD7A9]
    jr Jump_01D_60BB

Jump_01D_60AC::
    ld a, [wD7B0]
    cp a, $01
    jr nz, Jump_01D_60B8
    ld a, [wD7A9]
    jr Jump_01D_60BB

Jump_01D_60B8::
    ld a, [wD7A9]

Jump_01D_60BB::
    ld b, a
    ld a, [wD7AF]
    add a, a
    add a, a
    add a, c
    cp a, b
    jr nc, Jump_01D_6124
    push hl
    push bc
    ld a, [hl]
    ld c, $0B
    ld b, $02
    call LoadSRAMRecordWord
    ldh a, [hFFC6]
    ld l, a
    ldh a, [hFFC7]
    ld h, a
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
    ld a, $F0
    ld [wC8DE], a
    pop bc
    push bc
    call DrawWC8CFGlyphsOverlaying8DAnd8E_Bank1D
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wD7A9]
    cp a, c
    jr z, Jump_01D_6124
    ld a, c
    cp a, $04
    jp c, Jump_01D_60A0

Jump_01D_6124::
    xor a, a
    ld [rRAMG2], a
    ret

; draws the $F0-terminated text at wC8CF glyph by glyph; marks $8D and $8E are ORed onto the previous tile (E-0125)
; 4 call sites from 3 routines (e.g. Func_01D_6088, ScriptCommandED_Run_Case04_Case1C, DrawRecordNameAndSpeciesName)
; reads: wD784, wD785
; writes: wD784, wD785
; points at: wC8CF
DrawWC8CFGlyphsOverlaying8DAnd8E_Bank1D::
Func_01D_6129:: ; address name
    xor a, a
    ld [wD784], a
    ld [wD785], a
    ld hl, wC8CF

Jump_01D_6133::
    ld a, [wD784]
    push hl
    add_a_to_hl
    ld a, [hl]
    cp a, $F0
    jp z, Jump_01D_6176
    cp a, $8D
    jr z, Jump_01D_6154
    cp a, $8E
    jr z, Jump_01D_6154
    push bc
    call DrawWC8CFGlyphsOverlaying8DAnd8E_Bank1D_Sub01
    call CopyFromBankWaitVRAM
    pop bc
    jr Jump_01D_6165

Jump_01D_6154::
    push af
    ld a, [wD785]
    dec a
    ld [wD785], a
    pop af
    push bc
    call DrawWC8CFGlyphsOverlaying8DAnd8E_Bank1D_Sub01
    call OrFromBankWaitVRAM
    pop bc

Jump_01D_6165::
    pop hl
    ld a, [wD785]
    inc a
    ld [wD785], a
    ld a, [wD784]
    inc a
    ld [wD784], a
    jr Jump_01D_6133

Jump_01D_6176::
    pop hl
    xor a, a
    ld [wD785], a
    ld [wD784], a
    ret

; only called from DrawWC8CFGlyphsOverlaying8DAnd8E_Bank1D (E-0047)
; 2 call sites from 1 routine (e.g. DrawWC8CFGlyphsOverlaying8DAnd8E_Bank1D)
; reads: wD7F5, wD785
DrawWC8CFGlyphsOverlaying8DAnd8E_Bank1D_Sub01::
Func_01D_617F:: ; address name
    swap a
    ld d, a
    and a, $F0
    ld e, a
    ld a, d
    and a, $0F
    ld d, a
    ld hl, Data_01D_4010
    add hl, de
    ld e, l
    ld d, h
    push de
    ld a, [wD7F5]
    and a, a
    jr z, Jump_01D_61B6
    cp a, $01
    jr z, Jump_01D_61B1
    cp a, $02
    jr z, Jump_01D_61AC
    cp a, $03
    jr z, Jump_01D_61A7
    ld de, Data_01D_6299
    jr Jump_01D_61B9

Jump_01D_61A7::
    ld de, Data_01D_6285
    jr Jump_01D_61B9

Jump_01D_61AC::
    ld de, Data_01D_6279
    jr Jump_01D_61B9

Jump_01D_61B1::
    ld de, Data_01D_6229
    jr Jump_01D_61B9

Jump_01D_61B6::
    ld de, Data_01D_61D9

Jump_01D_61B9::
    ld a, c
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_01D_61C0
    inc d

Jump_01D_61C0::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [wD785]
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld h, d
    ld l, e
    pop de
    ld b, $1F
    ld c, $10
    ret

Data_01D_61D9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0761D9, $50

Data_01D_6229:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $076229, $50

Data_01D_6279:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $7B, $62, $50, $8F, $60, $8F, $70, $8F, $D0, $8F, $E0, $8F

Data_01D_6285:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $87, $62, $70, $97, $80, $97, $00, $97, $10, $97, $20, $97, $30, $97, $40, $97
    db $50, $97, $60, $97

Data_01D_6299:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $9B, $62, $C0, $97, $D0, $97, $E0, $97, $F0, $97, $00, $8C, $10, $8C, $20, $8C
    db $A0, $8C, $B0, $8C

; with SRAM enabled, for each of the wC6FD record numbers in wC6FE copies the record's name (CopyRecordNameToWC8CF, C = 1) and draws it as glyph tiles at the VRAM address from Data_01D_62F9 (CopyGlyphTilesToVRAM); then disables SRAM (E-0106)
; 6 call sites from 6 routines (e.g. ScriptCommandF6_Run_Case08, ScriptCommandEC_Run_Case03, ScriptCommandEB_Run_Case05_Case0E, ScriptCommandEE_Run_Case03, ...)
; reads: wC6FD
; writes: rRAMG2, rRAMB, wC8D9
; points at: wC6FE, wC52D
DrawRecordListNameTiles_Bank1D::
Func_01D_62AD:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld c, $00

Jump_01D_62B8::
    push bc
    ld hl, wC6FE
    ld a, c
    add_a_to_hl
    ld a, [hl]
    ld c, $01
    call CopyRecordNameToWC8CF
    ld a, $F0
    ld [wC8D9], a
    ld hl, Data_01D_62F9
    pop bc
    push bc
    ld a, c
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    call CopyGlyphTilesToVRAM
    pop bc
    inc c
    ld a, [wC6FD]
    cp a, c
    jr nz, Jump_01D_62B8
    xor a, a
    ld [rRAMG2], a
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ret

Data_01D_62F9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $8D, $50, $8D, $A0, $8D

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 6 call sites from 6 routines (e.g. Func_01D_6320, Func_01D_6AA5, UpdatePagedListCursor_Sub04, DrawTwoChoiceCursorConfirmed, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank1D_62FF::
Func_01D_62FF:: ; address name
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

; 10 call sites from 10 routines (e.g. ScriptCommandEF_Run_Case05_Case11, ScriptCommandEF_Run_Case0F_Case05, ScriptCommandED_Run_Case05_Case05, LoadTile4990AndRun6320, ...)
; reads: wD7AF, wD7B1, wD7A9, hFFC6, wD7F2, wD7F1, wD7B0
; writes: rRAMG2, rRAMB
; points at: wD789
Func_01D_6320::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wD789
    ld a, [wD7AF]
    add a, a
    add a, a
    add_a_to_hl
    ld c, $00

Jump_01D_6338::
    ld a, [wD7B1]
    cp a, $03
    jr c, Jump_01D_6344
    ld a, [wD7A9]
    jr Jump_01D_6353

Jump_01D_6344::
    ld a, [wD7B0]
    cp a, $01
    jr nz, Jump_01D_6350
    ld a, [wD7A9]
    jr Jump_01D_6353

Jump_01D_6350::
    ld a, [wD7A9]

Jump_01D_6353::
    ld b, a
    ld a, [wD7AF]
    add a, a
    add a, a
    add a, c
    cp a, b
    jp nc, Jump_01D_63F5
    push hl
    push bc
    ld a, [hl]
    ld c, $6E
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    cp a, $02
    jr nz, Jump_01D_637F
    pop bc
    pop hl
    push hl
    push bc
    ld a, [hl]
    ld c, $0E
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    and a, $01
    add a, $CC
    ld e, a
    jr Jump_01D_6381

Jump_01D_637F::
    ld e, $CE

Jump_01D_6381::
    pop bc
    push bc
    push de
    call BGMapAddressAtScroll_Bank1D_62FF
    push hl
    ld a, [wD7F2]
    and a, a
    jr z, Jump_01D_639C
    cp a, $01
    jr z, Jump_01D_6397
    ld hl, Data_01D_640A
    jr Jump_01D_639F

Jump_01D_6397::
    ld hl, Data_01D_6402
    jr Jump_01D_639F

Jump_01D_639C::
    ld hl, Data_01D_63FA

Jump_01D_639F::
    ld a, c
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop hl
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    pop de
    ld a, [wD7F1]
    and a, a
    jr nz, Jump_01D_63BC
    di
    call WaitForVRAMAccess
    ld a, e
    ld [hl], a
    ei

Jump_01D_63BC::
    pop bc
    push bc
    push de
    ld a, [wD7F2]
    and a, a
    jr z, Jump_01D_63D3
    cp a, $01
    jr z, Jump_01D_63CE
    ld de, Data_01D_6422
    jr Jump_01D_63D6

Jump_01D_63CE::
    ld de, Data_01D_641A
    jr Jump_01D_63D6

Jump_01D_63D3::
    ld de, Data_01D_6412

Jump_01D_63D6::
    ld a, c
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_01D_63DD
    inc d

Jump_01D_63DD::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    pop de
    ld a, e
    ld [hl], a
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wD7A9]
    cp a, c
    jr z, Jump_01D_63F5
    ld a, c
    cp a, $04
    jp c, Jump_01D_6338

Jump_01D_63F5::
    xor a, a
    ld [rRAMG2], a
    ret

Data_01D_63FA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $32, $00, $72, $00, $B2, $00, $F2, $00

Data_01D_6402:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B2, $00, $F2, $00, $32, $01, $72, $01

Data_01D_640A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2B, $00, $6B, $00, $AB, $00, $EB, $00

Data_01D_6412:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $8A, $C3, $B2, $C3, $DA, $C3, $02, $C4

Data_01D_641A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $DA, $C3, $02, $C4, $2A, $C4, $52, $C4

Data_01D_6422:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $83, $C3, $AB, $C3, $D3, $C3, $FB, $C3

; only called from routines of ScriptCommandE8_Run (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommandE8_Run_Case06_Case02, ScriptCommandE8_Run_Case07_Case02)
; reads: wJoypadPressedRepeat, wJoypadPressed, wD7B7
; writes: wMenuInputResult, wD7B7
ScriptCommandE8_Run_Shared01::
Func_01D_642A:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_01D_645F
    bit 7, a
    jr nz, Jump_01D_646F
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, Jump_01D_6448
    bit 1, a
    jr nz, Jump_01D_6456
    call BlinkCursorWD7B8_Bank1D_648E
    xor a, a
    ld [wMenuInputResult], a
    ret

Jump_01D_6448::
    ld a, $69
    call QueueSoundEffect
    call ScriptCommandE8_Run_Shared01_Sub01
    ld a, $FF
    ld [wMenuInputResult], a
    ret

Jump_01D_6456::
    call DrawBlankTileC3_64AC_Bank1D
    ld a, $FE
    ld [wMenuInputResult], a
    ret

Jump_01D_645F::
    call DrawBlankTileC3_64AC_Bank1D
    ld a, [wD7B7]
    and a, a
    jr nz, Jump_01D_646C
    ld a, $01
    jr Jump_01D_647D

Jump_01D_646C::
    dec a
    jr Jump_01D_647D

Jump_01D_646F::
    call DrawBlankTileC3_64AC_Bank1D
    ld a, [wD7B7]
    cp a, $01
    jr c, Jump_01D_647C
    xor a, a
    jr Jump_01D_647D

Jump_01D_647C::
    inc a

Jump_01D_647D::
    ld [wD7B7], a
    call DrawCursorTileBB_64A8_Bank1D
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

; cycles wD7B8 through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (after the joypad repeat timer reaches $14) (E-0122)
; 1 call site from 1 routine (e.g. ScriptCommandE8_Run_Shared01)
; reads: wJoypadRepeatTimer, wD7B8, wD7B7
; writes: wD7B8
BlinkCursorWD7B8_Bank1D_648E::
Func_01D_648E:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, DrawCursorTileBB_64A8_Bank1D
    ld a, [wD7B8]
    inc a
    ld [wD7B8], a
    cp a, $10
    jr c, DrawCursorTileBB_64A8_Bank1D
    cp a, $18
    jr c, DrawBlankTileC3_64AC_Bank1D
    xor a, a
    ld [wD7B8], a

; B = $BB (cursor tile) and joins the cursor draw (E-0122)
; 1 call site from 1 routine (e.g. ScriptCommandE8_Run_Shared01)
; reads: wD7B7
DrawCursorTileBB_64A8_Bank1D::
Func_01D_64A8:: ; address name
    ld b, $BB
    jr Jump_01D_64B2

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 3 call sites from 1 routine (e.g. ScriptCommandE8_Run_Shared01)
; reads: wD7B7
DrawBlankTileC3_64AC_Bank1D::
Func_01D_64AC:: ; address name
    ld b, $C3
    jr Jump_01D_64B2

; only called from ScriptCommandE8_Run_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE8_Run_Shared01)
; reads: wD7B7
ScriptCommandE8_Run_Shared01_Sub01::
Func_01D_64B0:: ; address name
    ld b, $BC

Jump_01D_64B2::
    ld a, [wD7B7]
    add a, a
    ld hl, Data_01D_64D2
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D_62FF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_01D_64D2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $28, $01, $68, $01

; 2 call sites from 2 routines (e.g. ScriptCommandE8_Run_Case0D_Case07, RunWD781Step_F0_5DE8_Case07)
; reads: wJoypadPressedRepeat, wJoypadPressed, wD7A9, wD7AB
; writes: wD7AF, wMenuInputResult, wD7AB
Func_01D_64D6::
    xor a, a
    ld [wD7AF], a
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_01D_6506
    bit 7, a
    jr nz, Jump_01D_651B
    ld a, [wJoypadPressed]
    bit 1, a
    jr nz, Jump_01D_64F5
    bit 0, a
    jr nz, Jump_01D_64FB
    xor a, a
    ld [wMenuInputResult], a
    ret

Jump_01D_64F5::
    ld a, $FE
    ld [wMenuInputResult], a
    ret

Jump_01D_64FB::
    ld a, $69
    call QueueSoundEffect
    ld a, $FF
    ld [wMenuInputResult], a
    ret

Jump_01D_6506::
    ld a, [wD7AB]
    and a, a
    jr nz, Jump_01D_6518
    ld a, [wD7A9]
    dec a
    jr nz, Jump_01D_6532
    ld a, $FD
    ld [wMenuInputResult], a
    ret

Jump_01D_6518::
    dec a
    jr Jump_01D_6532

Jump_01D_651B::
    ld a, [wD7A9]
    dec a
    jr nz, Jump_01D_6527
    ld a, $FD
    ld [wMenuInputResult], a
    ret

Jump_01D_6527::
    ld b, a
    ld a, [wD7AB]
    cp a, b
    jr c, Jump_01D_6531
    xor a, a
    jr Jump_01D_6532

Jump_01D_6531::
    inc a

Jump_01D_6532::
    ld [wD7AB], a
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

; wTwoChoiceCursor (0 or 1): Up and Down each toggle it, erase the old cursor (tile $C3), draw the new one (tile $BB), play sound $69 and set wMenuInputResult = $FD; A draws the confirmed cursor (tile $BC), plays sound $69 and sets $FF; B sets $FE; with no input the cursor blinks (wD783 counts frames once wJoypadRepeatTimer reaches $14) and the result is 0. Cursor positions are BG map offsets $012F and $016F from the scroll origin (E-0068)
; 27 call sites from 27 routines (e.g. ScriptCommandF7_Run_Case26, ScriptCommandF7_Run_Case04, ScriptCommandF7_Run_Case0C, ScriptCommandF7_Run_Case17, ...)
; reads: wJoypadPressedRepeat, wJoypadPressed, wTwoChoiceCursor
; writes: wMenuInputResult, wTwoChoiceCursor, wD783
UpdateTwoChoiceCursor_Bank1D::
Func_01D_6540:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_01D_655E
    bit 7, a
    jr nz, Jump_01D_6574
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, Jump_01D_659A
    bit 1, a
    jr nz, Jump_01D_65A8
    call BlinkTwoChoiceCursor
    xor a, a
    ld [wMenuInputResult], a
    ret

Jump_01D_655E::
    call EraseTwoChoiceCursor
    ld a, [wTwoChoiceCursor]
    and a, a
    jr nz, Jump_01D_656E
    ld a, $01
    ld [wTwoChoiceCursor], a
    jr Jump_01D_6588

Jump_01D_656E::
    dec a
    ld [wTwoChoiceCursor], a
    jr Jump_01D_6588

Jump_01D_6574::
    call EraseTwoChoiceCursor
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr c, Jump_01D_6584
    xor a, a
    ld [wTwoChoiceCursor], a
    jr Jump_01D_6588

Jump_01D_6584::
    inc a
    ld [wTwoChoiceCursor], a

Jump_01D_6588::
    xor a, a
    ld [wD783], a
    call DrawTwoChoiceCursor
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

Jump_01D_659A::
    call DrawTwoChoiceCursorConfirmed
    ld a, $69
    call QueueSoundEffect
    ld a, $FF
    ld [wMenuInputResult], a
    ret

Jump_01D_65A8::
    ld a, $FE
    ld [wMenuInputResult], a
    ret

; once wJoypadRepeatTimer >= $14, counts wD783 up: frames 0-$0F draw the cursor, $10-$17 erase it, then the count restarts (E-0068)
; 1 call site from 1 routine (e.g. UpdateTwoChoiceCursor_Bank1D)
; reads: wJoypadRepeatTimer, wD783, wTwoChoiceCursor
; writes: wD783
BlinkTwoChoiceCursor::
Func_01D_65AE:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, DrawTwoChoiceCursor
    ld a, [wD783]
    inc a
    ld [wD783], a
    cp a, $10
    jr c, DrawTwoChoiceCursor
    cp a, $18
    jr c, EraseTwoChoiceCursor
    xor a, a
    ld [wD783], a

; writes tile $BB at the position of wTwoChoiceCursor (Data_01D_65F2 offset from BGMapAddressAtScroll, StepBGMapAddressBackOnScrollWrap) (E-0068)
; 1 call site from 1 routine (e.g. UpdateTwoChoiceCursor_Bank1D)
; reads: wTwoChoiceCursor
DrawTwoChoiceCursor::
Func_01D_65C8:: ; address name
    ld b, $BB
    jr Jump_01D_65D2

; writes tile $C3 at the position of wTwoChoiceCursor (E-0068)
; 2 call sites from 1 routine (e.g. UpdateTwoChoiceCursor_Bank1D)
; reads: wTwoChoiceCursor
EraseTwoChoiceCursor::
Func_01D_65CC:: ; address name
    ld b, $C3
    jr Jump_01D_65D2

; writes tile $BC at the position of wTwoChoiceCursor (E-0068)
; 1 call site from 1 routine (e.g. UpdateTwoChoiceCursor_Bank1D)
; reads: wTwoChoiceCursor
DrawTwoChoiceCursorConfirmed::
Func_01D_65D0:: ; address name
    ld b, $BC

Jump_01D_65D2::
    ld a, [wTwoChoiceCursor]
    add a, a
    ld hl, Data_01D_65F2
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D_62FF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_01D_65F2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2F, $01, $6F, $01

; list cursor over wD7A9 entries: Up/Down move wD7AB with wrap, erase and redraw the cursor, play sound $69 and set wMenuInputResult = $FD; A draws the confirmed cursor, plays sound $69 and sets $FF; B sets $FE; with no input the cursor blinks and the result is 0 (the codes of UpdatePagedListCursor) (E-0106)
; 7 call sites from 7 routines (e.g. ScriptCommandE8_Run_Case04_Case05, ScriptCommandE8_Run_Case05_Case25, ScriptCommandE8_Run_Case08_Case06, ScriptCommandE8_Run_Case08_Case15, ...)
; reads: wJoypadPressedRepeat, wJoypadPressed, wD7A9, wD7AB
; writes: wMenuInputResult, wD7AB, wD7AC
UpdateListCursorWD7AB::
Func_01D_65F6:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_01D_6614
    bit 7, a
    jr nz, Jump_01D_662C
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, Jump_01D_6656
    bit 1, a
    jr nz, Jump_01D_6664
    call UpdateListCursorWD7AB_Sub01
    xor a, a
    ld [wMenuInputResult], a
    ret

Jump_01D_6614::
    call UpdateListCursorWD7AB_Sub03
    ld a, [wD7AB]
    and a, a
    jr nz, Jump_01D_6626
    ld a, [wD7A9]
    dec a
    ld [wD7AB], a
    jr Jump_01D_6644

Jump_01D_6626::
    dec a
    ld [wD7AB], a
    jr Jump_01D_6644

Jump_01D_662C::
    call UpdateListCursorWD7AB_Sub03
    ld a, [wD7A9]
    dec a
    ld b, a
    ld a, [wD7AB]
    cp a, b
    jr c, Jump_01D_6640
    xor a, a
    ld [wD7AB], a
    jr Jump_01D_6644

Jump_01D_6640::
    inc a
    ld [wD7AB], a

Jump_01D_6644::
    xor a, a
    ld [wD7AC], a
    call UpdateListCursorWD7AB_Sub02
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

Jump_01D_6656::
    ld a, $69
    call QueueSoundEffect
    call UpdateListCursorWD7AB_Sub04
    ld a, $FF
    ld [wMenuInputResult], a
    ret

Jump_01D_6664::
    ld a, $FE
    ld [wMenuInputResult], a
    ret

; only called from UpdateListCursorWD7AB (E-0047)
; 1 call site from 1 routine (e.g. UpdateListCursorWD7AB)
; reads: wJoypadRepeatTimer, wD7AC, wD7AB
; writes: wD7AC
UpdateListCursorWD7AB_Sub01::
Func_01D_666A:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, UpdateListCursorWD7AB_Sub02
    ld a, [wD7AC]
    inc a
    ld [wD7AC], a
    cp a, $10
    jr c, UpdateListCursorWD7AB_Sub02
    cp a, $18
    jr c, UpdateListCursorWD7AB_Sub03
    xor a, a
    ld [wD7AC], a

; only called from UpdateListCursorWD7AB (E-0047)
; 1 call site from 1 routine (e.g. UpdateListCursorWD7AB)
; reads: wD7AB
UpdateListCursorWD7AB_Sub02::
Func_01D_6684:: ; address name
    ld b, $BB
    jr Jump_01D_668E

; only called from UpdateListCursorWD7AB (E-0047)
; 2 call sites from 1 routine (e.g. UpdateListCursorWD7AB)
; reads: wD7AB
UpdateListCursorWD7AB_Sub03::
Func_01D_6688:: ; address name
    ld b, $C3
    jr Jump_01D_668E

; only called from UpdateListCursorWD7AB (E-0047)
; 1 call site from 1 routine (e.g. UpdateListCursorWD7AB)
; reads: wD7AB
UpdateListCursorWD7AB_Sub04::
Func_01D_668C:: ; address name
    ld b, $BC

Jump_01D_668E::
    ld a, [wD7AB]
    add a, a
    ld hl, Data_01D_66AE
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D_62FF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_01D_66AE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $00, $61, $00, $A1, $00, $E1, $00

; row wD7AB runs 0..wD7B1 and page wD7AF runs 0..wD7B0 - 1, both wrapping; Up/Down move the row (wMenuInputResult = $FD), Left/Right move the page ($FB); a move erases the old cursor (tile $C3) and draws the new one (tile $BB) with sound $69; A draws tile $BC, plays sound $69 and sets $FF; B sets $FE. When the range is a single entry the press only blinks the cursor and the result is 0, as with no input (E-0068)
; 34 call sites from 34 routines (e.g. ScriptCommandEF_Run_Case05_Case06, ScriptCommandF2_Run_Case03_Case05, ScriptCommandF3_Run_Case05_Case07, ScriptCommandEB_Run_Case05_Case25, ...)
; reads: wJoypadPressedRepeat, wJoypadPressed, wD7B1, wD7AB, wD7AF, wD7B0
; writes: wMenuInputResult, wD7AB, wD7AC, wD7AF
UpdatePagedListCursor::
Func_01D_66B6:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 4, a
    jr nz, Jump_01D_66E3
    bit 5, a
    jr nz, Jump_01D_6713
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jp nz, Jump_01D_6730
    bit 7, a
    jp nz, Jump_01D_6752
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_01D_6789
    bit 1, a
    jp nz, Jump_01D_6797
    call UpdatePagedListCursor_Sub01
    xor a, a
    ld [wMenuInputResult], a
    ret

Jump_01D_66E3::
    ld a, [wD7B0]
    ld b, a
    ld a, [wD7AF]
    inc a
    cp a, b
    jr c, Jump_01D_66FE
    ld a, [wD7B0]
    cp a, $01
    jr nz, Jump_01D_66FD
    call UpdatePagedListCursor_Sub01
    xor a, a
    ld [wMenuInputResult], a
    ret

Jump_01D_66FD::
    xor a, a

Jump_01D_66FE::
    ld [wD7AF], a
    xor a, a
    ld [wD7AC], a
    call UpdatePagedListCursor_Sub02
    ld a, $69
    call QueueSoundEffect
    ld a, $FB
    ld [wMenuInputResult], a
    ret

Jump_01D_6713::
    ld a, [wD7AF]
    and a, a
    jr nz, Jump_01D_672C
    ld a, [wD7B0]
    cp a, $01
    jr nz, Jump_01D_6728
    call UpdatePagedListCursor_Sub01
    xor a, a
    ld [wMenuInputResult], a
    ret

Jump_01D_6728::
    dec a
    jp Jump_01D_66FE

Jump_01D_672C::
    dec a
    jp Jump_01D_66FE

Jump_01D_6730::
    call UpdatePagedListCursor_Sub03
    ld a, [wD7AB]
    and a, a
    jr nz, Jump_01D_674C
    ld a, [wD7B1]
    and a, a
    jr nz, Jump_01D_6747
    call UpdatePagedListCursor_Sub01
    xor a, a
    ld [wMenuInputResult], a
    ret

Jump_01D_6747::
    ld [wD7AB], a
    jr Jump_01D_6777

Jump_01D_674C::
    dec a
    ld [wD7AB], a
    jr Jump_01D_6777

Jump_01D_6752::
    call UpdatePagedListCursor_Sub03
    ld a, [wD7B1]
    ld b, a
    ld a, [wD7AB]
    cp a, b
    jr c, Jump_01D_6773
    ld a, [wD7B1]
    and a, a
    jr nz, Jump_01D_676D
    call UpdatePagedListCursor_Sub01
    xor a, a
    ld [wMenuInputResult], a
    ret

Jump_01D_676D::
    xor a, a
    ld [wD7AB], a
    jr Jump_01D_6777

Jump_01D_6773::
    inc a
    ld [wD7AB], a

Jump_01D_6777::
    xor a, a
    ld [wD7AC], a
    call UpdatePagedListCursor_Sub02
    ld a, $69
    call QueueSoundEffect
    ld a, $FD
    ld [wMenuInputResult], a
    ret

Jump_01D_6789::
    call UpdatePagedListCursor_Sub04
    ld a, $69
    call QueueSoundEffect
    ld a, $FF
    ld [wMenuInputResult], a
    ret

Jump_01D_6797::
    ld a, $FE
    ld [wMenuInputResult], a
    ret

; only called from UpdatePagedListCursor (E-0047)
; 5 call sites from 1 routine (e.g. UpdatePagedListCursor)
; reads: wJoypadRepeatTimer, wD7AC, wMenuInputResult, wD7AB
; writes: wD7AC
UpdatePagedListCursor_Sub01::
Func_01D_679D:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, UpdatePagedListCursor_Sub02
    ld a, [wD7AC]
    inc a
    ld [wD7AC], a
    cp a, $10
    jr c, UpdatePagedListCursor_Sub02
    cp a, $18
    jr c, UpdatePagedListCursor_Sub03
    xor a, a
    ld [wD7AC], a

; only called from UpdatePagedListCursor (E-0047)
; 2 call sites from 1 routine (e.g. UpdatePagedListCursor)
; reads: wMenuInputResult, wD7AB
UpdatePagedListCursor_Sub02::
Func_01D_67B7:: ; address name
    ld b, $BB
    jr Jump_01D_67C1

; only called from UpdatePagedListCursor (E-0047)
; 2 call sites from 1 routine (e.g. UpdatePagedListCursor)
; reads: wMenuInputResult, wD7AB
UpdatePagedListCursor_Sub03::
Func_01D_67BB:: ; address name
    ld b, $C3
    jr Jump_01D_67C1

; only called from UpdatePagedListCursor (E-0047)
; 1 call site from 1 routine (e.g. UpdatePagedListCursor)
; reads: wMenuInputResult, wD7AB
UpdatePagedListCursor_Sub04::
Func_01D_67BF:: ; address name
    ld b, $BC

Jump_01D_67C1::
    ld a, [wMenuInputResult]
    ld c, a
    add a, a
    add a, a
    add a, c
    add a, a
    ld hl, Data_01D_67EE
    add_a_to_hl
    ld a, [wD7AB]
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D_62FF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_01D_67EE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $00, $61, $00, $A1, $00, $E1, $00, $21, $01, $28, $00, $68, $00, $A8, $00
    db $E8, $00, $28, $01, $A8, $00, $E8, $00, $28, $01, $68, $01, $A8, $01, $A6, $00
    db $E6, $00, $26, $01, $66, $01, $A6, $01, $A4, $00, $E4, $00, $24, $01, $64, $01
    db $A4, $01, $A2, $00, $E2, $00, $22, $01, $62, $01, $A2, $01

; 4 call sites from 4 routines (e.g. PauseMenu_Main_Case03_Case01_Sub01, ScriptCommandE8_Run_Case0D_Case04, ScriptCommandE8_Run_Case09_Case1E, RunWD781Step_F0_5DE8_Case04)
; reads: wD7F1, wD7F2, hFFC6, hFFC7
; writes: rRAMG2, rRAMB, rRAMG
; points at: wD7F3
Func_01D_682A::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7F1]
    ld l, a
    ld a, [wD7F2]
    ld h, a
    ld bc, $0300

Jump_01D_683E::
    push hl
    push bc
    ld a, [hl]
    ld c, $0D
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    and a, $10
    jr nz, Jump_01D_6851
    ld de, Data_01D_6DE0
    jr Jump_01D_6854

Jump_01D_6851::
    ld de, Data_01D_6DE3

Jump_01D_6854::
    pop bc
    pop hl
    push hl
    push bc
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_01D_685E
    inc d

Jump_01D_685E::
    ld a, [de]
    ld c, a
    ld a, [hl]
    call LoadSRAMRecordWord
    ldh a, [hFFC7]
    cp a, $FF
    jr z, Jump_01D_6885
    pop bc
    push bc
    ld a, c
    add a, a
    add a, c
    ld de, Data_01D_6890
    add a, e
    ld e, a
    jr nc, Jump_01D_6877
    inc d

Jump_01D_6877::
    ld hl, wD7F3
    ld c, $03

Jump_01D_687C::
    ld a, [de]
    ld [hl+], a
    inc de
    dec c
    jr nz, Jump_01D_687C
    call LoadSpeciesSpriteGraphicsAndPalette

Jump_01D_6885::
    pop bc
    pop hl
    inc c
    dec b
    jr nz, Jump_01D_683E
    xor a, a
    ld [rRAMG], a
    ret

Data_01D_6890:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $80, $08, $00, $81, $10, $00, $82

; 5 call sites from 5 routines (e.g. CallFunc6899PreservingWD7F1AndHFFC6, PauseMenu_Main_Case03_Case02, ScriptCommandE8_Run_Case0D_Case07, ScriptCommandE8_Run_Case08_Case20, ...)
; reads: wD7F1, wD7F2, hFFC6, hFFC7
; writes: rRAMG2, rRAMB, wD7F1, wD7F2
Func_01D_6899::
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7F1]
    ld l, a
    ld a, [wD7F2]
    ld h, a
    ld bc, $0300

Jump_01D_68AD::
    push hl
    push bc
    ld a, [hl]
    ld c, $0D
    call LoadSRAMRecordByte
    ldh a, [hFFC6]
    and a, $10
    jr nz, Jump_01D_68C0
    ld de, Data_01D_6DE0
    jr Jump_01D_68C3

Jump_01D_68C0::
    ld de, Data_01D_6DE3

Jump_01D_68C3::
    pop bc
    pop hl
    push hl
    push bc
    ld a, c
    add a, e
    ld e, a
    jr nc, Jump_01D_68CD
    inc d

Jump_01D_68CD::
    ld a, [de]
    ld c, a
    ld a, [hl]
    call LoadSRAMRecordWord
    ldh a, [hFFC7]
    cp a, $FF
    jr z, Jump_01D_68FE
    pop bc
    push bc
    ldh a, [hFFC6]
    ld [wD7F1], a
    ldh a, [hFFC7]
    ld [wD7F2], a
    ld a, c
    add a, a
    add a, a
    ld hl, Data_01D_6909
    add_a_to_hl
    ld b, [hl]
    inc hl
    ld c, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld e, [hl]
    ld l, c
    ld h, b
    ld c, $00
    call DrawSpeciesMetaSpriteAtScrollOffset

Jump_01D_68FE::
    pop bc
    pop hl
    inc c
    dec b
    jr nz, Jump_01D_68AD
    xor a, a
    ld [rRAMG2], a
    ret

Data_01D_6909:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $10, $78, $00, $10, $30, $68, $01, $20, $30, $88, $02

; decompresses the sprite graphics of species hFFC6/7 (far pointer Data_004_4EAA + 3 * id) to the VRAM address in wD7F4/5; on CGB copies its 8-byte palette from bank $27 into wOBJPaletteBuffer + wD7F3 (E-0127)
; 1 call site from 1 routine (e.g. Func_01D_682A)
; reads: hFFC6, hFFC7, wD7F4, wD7F5, wIsCGB, wD7F3, rSTAT
; writes: wC527
; points at: wOBJPaletteBuffer
LoadSpeciesSpriteGraphicsAndPalette::
Func_01D_6915:: ; address name
    ldh a, [hFFC6]
    ld l, a
    ld e, a
    ldh a, [hFFC7]
    ld h, a
    ld d, a
    push hl
    add hl, hl
    add hl, de
    ld de, Data_004_4EAA
    add hl, de
    ld e, l
    ld d, h
    ld b, $04
    call ReadFarPointerAtDEInBankB
    ld e, l
    ld d, h
    ld a, [wD7F4]
    ld l, a
    ld a, [wD7F5]
    ld h, a
    call DecompressToVRAM
    pop hl
    ld a, [wIsCGB]
    and a, a
    ret z
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
    ld a, [wD7F3]
    add_a_to_hl
    ld c, $08

Jump_01D_695A::
    push bc
    call ReadByteInBank
    di

Jump_01D_695F::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01D_695F
    ld a, c
    ld [hl+], a
    ei
    pop bc
    inc de
    dec c
    jr nz, Jump_01D_695A
    ld a, $7F
    ld [wC527], a
    ret

; graphics number = the word wD7F1/wD7F2: reads its far pointer (3 bytes per entry) from Data_004_4EAA in bank $04 (ReadFarPointerAtDEInBankB) and DecompressToVRAM to the address in wD7F4/wD7F5; on CGB it continues with the palette (not read) (E-0104)
; 8 call sites from 8 routines (e.g. DecompressRecordSpeciesGraphicsToTiles0, ScriptCommandF6_Run_Case10_Case03, RunWCFA8StateWhenNotFading_Case00_Case03, DecompressGraphicsA4ToTiles0, ...)
; reads: wD7F1, wD7F2, wD7F4, wD7F5, wIsCGB, wD7F3, rSTAT
; writes: wC527
; points at: wOBJPaletteBuffer
DecompressGraphicsWD7F1ToWD7F4::
Func_01D_6973:: ; address name
    ld a, [wD7F1]
    ld l, a
    ld e, a
    ld a, [wD7F2]
    ld h, a
    ld d, a
    add hl, hl
    add hl, de
    ld de, Data_004_4EAA
    add hl, de
    ld e, l
    ld d, h
    ld b, $04
    call ReadFarPointerAtDEInBankB
    ld e, l
    ld d, h
    ld a, [wD7F4]
    ld l, a
    ld a, [wD7F5]
    ld h, a
    call DecompressToVRAM
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_01D_69D9
    ld a, [wD7F1]
    ld l, a
    ld a, [wD7F2]
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
    ld a, [wD7F3]
    add_a_to_hl
    ld c, $08

Jump_01D_69C1::
    push bc
    call ReadByteInBank
    di

Jump_01D_69C6::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01D_69C6
    ld a, c
    ld [hl+], a
    ei
    pop bc
    inc de
    dec c
    jr nz, Jump_01D_69C1
    ld a, $7F
    ld [wC527], a

Jump_01D_69D9::
    ret

; draws sprite set wD7F1 & $7F (from bank $25, $26 or $27 by wD7F2 and bit 7 of wD7F1) at the scroll position + (L, D), tile offset H, attribute E, alternating two frames (E-0127)
; 2 call sites from 2 routines (e.g. Func_01D_6899, DrawWD789Cell5SpeciesSprite)
; reads: wFrameCounterLo, hScrollX, hScrollXHi, hScrollY, hScrollYHi, wD7F1, wD7F2
; writes: hSpriteAttrXor, hSpriteSubIndex, hSpriteTileOffset, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteSetIndex
DrawSpeciesMetaSpriteAtScrollOffset::
Func_01D_69DA:: ; address name
    ld c, $00
    ld a, e
    ldh [hSpriteAttrXor], a
    ld a, c
    and a, a
    jr nz, Jump_01D_69F1
    ld c, $00
    ld a, [wFrameCounterLo]
    swap a
    and a, $01
    add a, c
    ldh [hSpriteSubIndex], a
    jr Jump_01D_69F4

Jump_01D_69F1::
    xor a, a
    ldh [hSpriteSubIndex], a

Jump_01D_69F4::
    ld a, h
    ldh [hSpriteTileOffset], a
    ldh a, [hScrollX]
    add a, l
    ldh [hSpriteOriginX], a
    ldh a, [hScrollXHi]
    adc a, $00
    ldh [hSpriteOriginXHi], a
    ldh a, [hScrollY]
    add a, d
    ldh [hSpriteOriginY], a
    ldh a, [hScrollYHi]
    adc a, $00
    ldh [hSpriteOriginYHi], a
    ld a, [wD7F1]
    and a, $7F
    ldh [hSpriteSetIndex], a
    ld a, [wD7F2]
    or a, a
    jr nz, Jump_01D_6A2F
    ld a, [wD7F1]
    bit 7, a
    jr nz, Jump_01D_6A28
    farcall DrawMetaSpriteSet_Bank25
    ret

Jump_01D_6A28::
    farcall DrawMetaSpriteSet_Bank26
    ret

Jump_01D_6A2F::
    farcall DrawMetaSpriteSet_Bank27
    ret

; only called from DrawThreeMetaSpritePartsFor5050 (E-0047)
; 3 call sites from 1 routine (e.g. DrawThreeMetaSpritePartsFor5050)
; reads: wD7F6, wD7F3, wD7F4, hScrollX, hScrollXHi, wD7F5, hScrollY, hScrollYHi, ...
; writes: hSpriteAttrXor, hSpriteTileOffset, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteSetIndex
DrawThreeMetaSpritePartsFor5050_Sub01::
Func_01D_6A36:: ; address name
    ld a, [wD7F6]
    ldh [hSpriteAttrXor], a
    jr Jump_01D_6A59

; C = 0, then falls into the sprite part draw (Func_01D_6A36 body) (E-0122)
; 6 call sites from 6 routines (e.g. PauseMenu_Main_Case01_Case02, RunWCFA8StateWhenNotFading_Shared01, ScriptCommandE8_Run_Case08_Case15, DrawWCA36SpritePart, ...)
; reads: wD7F6, wFrameCounterLo, wD7F3, wD7F4, hScrollX, hScrollXHi, wD7F5, hScrollY, ...
; writes: hSpriteAttrXor, hSpriteSubIndex, hSpriteTileOffset, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteSetIndex
DrawMetaSpritePartC0::
Func_01D_6A3D:: ; address name
    ld c, $00

; only called from DrawSpritePart9000At88_28 (E-0047)
; 1 call site from 1 routine (e.g. DrawSpritePart9000At88_28)
; reads: wD7F6, wFrameCounterLo, wD7F3, wD7F4, hScrollX, hScrollXHi, wD7F5, hScrollY, ...
; writes: hSpriteAttrXor, hSpriteSubIndex, hSpriteTileOffset, hSpriteOriginX, hSpriteOriginXHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteSetIndex
DrawSpritePart9000At88_28_Sub01::
Func_01D_6A3F:: ; address name
    ld a, [wD7F6]
    ldh [hSpriteAttrXor], a
    ld a, c
    and a, a
    jr nz, Jump_01D_6A56
    ld c, $00
    ld a, [wFrameCounterLo]
    swap a
    and a, $01
    add a, c
    ldh [hSpriteSubIndex], a
    jr Jump_01D_6A59

Jump_01D_6A56::
    xor a, a
    ldh [hSpriteSubIndex], a

Jump_01D_6A59::
    ld a, [wD7F3]
    ldh [hSpriteTileOffset], a
    ld a, [wD7F4]
    ld b, a
    ldh a, [hScrollX]
    add a, b
    ldh [hSpriteOriginX], a
    ldh a, [hScrollXHi]
    adc a, $00
    ldh [hSpriteOriginXHi], a
    ld a, [wD7F5]
    ld b, a
    ldh a, [hScrollY]
    add a, b
    ldh [hSpriteOriginY], a
    ldh a, [hScrollYHi]
    adc a, $00
    ldh [hSpriteOriginYHi], a
    ld a, [wD7F1]
    and a, $7F
    ldh [hSpriteSetIndex], a
    ld a, [wD7F2]
    or a, a
    jr nz, Jump_01D_6A9E
    ld a, [wD7F1]
    bit 7, a
    jr nz, Jump_01D_6A97
    farcall DrawMetaSpriteSet_Bank25
    ret

Jump_01D_6A97::
    farcall DrawMetaSpriteSet_Bank26
    ret

Jump_01D_6A9E::
    farcall DrawMetaSpriteSet_Bank27
    ret

; 14 call sites from 10 routines (e.g. ScriptCommandEB_Run_Case06_Case04, ScriptCommandED_Run_Case04_Case03, ScriptCommandEF_Run_Bank1B_Case0E_Case02, ScriptCommandE8_Run_Case06_Case08, ...)
; reads: wD7AF, wD7B1, wC6FD, wD7F1
; writes: rRAMG2, rRAMB
; points at: wC6FE, wD789
Func_01D_6AA5::
    ld hl, wC6FE
    ld bc, $0000
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a

Jump_01D_6AB4::
    push bc
    push hl
    ld b, [hl]
    ld a, [wD7AF]
    ld c, a
    add a, a
    add a, a
    add a, c
    ld hl, wD789
    add_a_to_hl
    ld c, $00

Jump_01D_6AC8::
    ld a, [hl]
    cp a, b
    jr z, Jump_01D_6AE3
    inc hl
    inc c
    ld a, [wD7B1]
    cp a, c
    jr nc, Jump_01D_6AC8
    pop hl
    pop bc

Jump_01D_6AD6::
    inc hl
    inc b
    ld a, [wC6FD]
    cp a, b
    jr nz, Jump_01D_6AB4
    xor a, a
    ld [rRAMG2], a
    ret

Jump_01D_6AE3::
    ld a, [wD7F1]
    and a, a
    jr z, Jump_01D_6B03
    ld hl, Data_01D_6B28
    ld a, c
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1D_62FF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld e, l
    ld d, h
    jr Jump_01D_6B10

Jump_01D_6B03::
    ld a, c
    add a, a
    ld hl, Data_01D_6B1E
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]

Jump_01D_6B10::
    pop hl
    pop bc
    di
    call WaitForVRAMAccess
    ld a, b
    add a, $E1
    ld [de], a
    ei
    jp Jump_01D_6AD6

Data_01D_6B1E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $78, $C3, $A0, $C3, $C8, $C3, $F0, $C3, $18, $C4

Data_01D_6B28:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $00, $60, $00, $A0, $00, $E0, $00, $20, $01

; only called from ScriptCommandE8_Run_Case03 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandE8_Run_Case03)
; reads: wD786, wD780, wD7A9, wC6FD
; writes: wD780, wD781, wTwoChoiceCursor, wD7AF, wScriptCommandType, wScriptStartRequest, wD782
; points at: wC52D
ScriptCommandE8_Run_Case03_Sub01::
Func_01D_6B32:: ; address name
    ld hl, wC52D
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [wD786]
    and a, a
    jr z, Jump_01D_6B54
    cp a, $01
    jp z, Jump_01D_6B93
    cp a, $02
    jp z, Jump_01D_6BF0
    cp a, $03
    jp z, Jump_01D_6C02

Jump_01D_6B54::
    call ListPartyRecordsWithState2ToWD789
    ld a, [wD780]
    inc a
    ld [wD780], a
    ld a, [wD7A9]
    cp a, $02
    jr c, Jump_01D_6B7C
    xor a, a
    ld [wD781], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wD7AF], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_6B7C::
    ld a, $10
    ld [wD781], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wD7AF], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_6B93::
    farcall ListRecordsState1WithByte6EClear
    ld a, [wD7A9]
    and a, a
    jr nz, Jump_01D_6BBA
    xor a, a
    ld [wTwoChoiceCursor], a
    ld [wD782], a
    ld a, $03
    ld [wD781], a
    ld a, $01
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_6BBA::
    ld a, [wD780]
    add a, $02
    ld [wD780], a
    ld a, [wC6FD]
    cp a, $03
    jr c, Jump_01D_6BDD
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $1E
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_6BDD::
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_6BF0::
    ld a, [wD780]
    add a, $03
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01D_6C02::
    ld a, [wD780]
    add a, $04
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; 7 call sites from 7 routines (e.g. ScriptCommandEC_Run_Case01, ScriptCommandED_Run_Case04_Case20, ScriptCommandED_Run_Case04_Case32, ScriptCommandED_Run_Case05_Case08, ...)
; reads: wD7F3, wD7F4, wD785, wD7F1, wD7F2, wD784
; writes: wD784, wD785, wD7F5
Func_01D_6C14::
    ld a, [wD7F3]
    ld d, a
    ld a, [wD7F4]
    ld e, a
    xor a, a
    ld [wD784], a

Jump_01D_6C20::
    push hl
    push de
    ld a, [wD785]
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_01D_6C2B
    inc d

Jump_01D_6C2B::
    ld a, [de]
    cp a, $FF
    jr z, Jump_01D_6C6A
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld d, a
    ld e, l
    push de
    ld a, [wD785]
    swap a
    ld h, a
    and a, $F0
    ld l, a
    ld a, h
    and a, $0F
    ld h, a
    ld a, [wD7F1]
    ld d, a
    ld a, [wD7F2]
    ld e, a
    add hl, de
    pop de
    call CopyTileBytesToVRAM_Bank1D
    pop de
    pop hl
    ld a, [wD785]
    inc a
    ld [wD785], a
    ld a, [wD784]
    inc a
    ld [wD784], a
    cp a, $06
    jr c, Jump_01D_6C20
    xor a, a
    ld [wD7F5], a
    ret

Jump_01D_6C6A::
    pop de
    pop hl
    xor a, a
    ld [wD785], a
    ld [wD784], a
    ld a, $FF
    ld [wD7F5], a
    ret

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (the same 17 bytes appear in 7 banks)
; 7 call sites from 3 routines (e.g. Func_01D_6C14, LoadTileList6DC4SixPerFrame, UploadTilesFromData6D20)
; reads: rSTAT
CopyTileBytesToVRAM_Bank1D::
Func_01D_6C79:: ; address name
    ld c, $10

Jump_01D_6C7B::
    di

Jump_01D_6C7C::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01D_6C7C
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    dec c
    jr nz, Jump_01D_6C7B
    ret

; HL = Data_01D_6D84, wD7F1/2 = $9C/0, DE = vBGMap1, wD784 = 0, then continues at Jump_01D_6CB2 (E-0126)
; 2 call sites from 2 routines (e.g. ScriptCommandEB_Run_Case01_Case00, ScriptCommandE8_Run_Case01_Case00)
; reads: wD785, wD7F1, wD7F2, wD784
; writes: wD7F1, wD7F2, wD784, wD785
; points at: wD781
SetupTileMap6D84AtBGMap1::
Func_01D_6C8A:: ; address name
    ld hl, Data_01D_6D84
    ld a, $9C
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    ld de, vBGMap1
    xor a, a
    ld [wD784], a
    jr Jump_01D_6CB2

; copies tiles listed in Data_01D_6DC4 to vBGMap1 + $200 onward six per call; at the $FF end resets the counters and wD781 += 1 (E-0127)
; 2 call sites from 2 routines (e.g. ScriptCommandE8_Run_Case06_Case15, RunWD781Step_F0_5B50_Case00)
; reads: wD785, wD7F1, wD7F2, wD784
; writes: wD7F1, wD7F2, wD784, wD785
; points at: wD781
LoadTileList6DC4SixPerFrame::
Func_01D_6C9F:: ; address name
    ld hl, Data_01D_6DC4
    ld a, $9E
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    ld de, vBGMap1 + $200
    xor a, a
    ld [wD784], a

Jump_01D_6CB2::
    push hl
    push de
    ld a, [wD785]
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_01D_6CF9
    ld e, [hl]
    inc hl
    ld a, [hl]
    ld h, a
    ld l, e
    push hl
    ld a, [wD785]
    swap a
    ld h, a
    and a, $F0
    ld l, a
    ld a, h
    and a, $0F
    ld h, a
    ld a, [wD7F1]
    ld d, a
    ld a, [wD7F2]
    ld e, a
    add hl, de
    ld e, l
    ld d, h
    pop hl
    call CopyTileBytesToVRAM_Bank1D
    pop de
    pop hl
    ld a, [wD785]
    inc a
    ld [wD785], a
    ld a, [wD784]
    inc a
    ld [wD784], a
    cp a, $06
    jr c, Jump_01D_6CB2
    ret

Jump_01D_6CF9::
    pop de
    pop hl
    xor a, a
    ld [wD784], a
    ld [wD785], a
    ld hl, wD781
    inc [hl]
    ret

; copies tiles from Data_01D_6D20: two to vTiles2 + $6E0 and three to vTiles2 + $7C0 (CopyTileBytesToVRAM_Bank1D) (E-0118)
; 4 call sites from 4 routines (e.g. ScriptCommandE8_Run_Case09_Case1B_Case00, ScriptCommandE8_Run_Case0D_Case04, ScriptCommandE8_Run_Case08_Case1B, RunWD781Step_F0_5DE8_Case04)
UploadTilesFromData6D20::
Func_01D_6D07:: ; address name
    ld hl, Data_01D_6D20
    ld de, vTiles2 + $6E0
    call CopyTileBytesToVRAM_Bank1D
    call CopyTileBytesToVRAM_Bank1D
    ld de, vTiles2 + $7C0
    call CopyTileBytesToVRAM_Bank1D
    call CopyTileBytesToVRAM_Bank1D
    call CopyTileBytesToVRAM_Bank1D
    ret

Data_01D_6D20:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $076D20, $50

; C = wD7FF = Data_01D_6D81[wC7C7] (E-0073)
; 10 call sites from 9 routines (e.g. ListRecordsInUseWithByte6ESet, ListRecordsState1WithByte6EClear, ListRecordsInUseWithByte6EClear, ListPartyRecordsWithState2ToWD789, ...)
; reads: wC7C7
; writes: wD7FF
LoadWD7FFFromWC7C7Table::
Func_01D_6D70:: ; address name
    ld a, [wC7C7]
    ld de, Data_01D_6D81
    add a, e
    ld e, a
    jr nc, Jump_01D_6D7B
    inc d

Jump_01D_6D7B::
    ld a, [de]
    ld c, a
    ld [wD7FF], a
    ret

Data_01D_6D81:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0A, $14, $1E

Data_01D_6D84:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $8A, $50, $8A, $60, $8A, $70, $8A, $80, $8A, $90, $8A, $A0, $8A, $B0, $8A
    db $C0, $8A, $D0, $8A, $E0, $8A, $F0, $8A, $E0, $8E, $F0, $8E, $00, $8F, $10, $8F
    db $20, $8F, $30, $8F, $40, $8F, $50, $8F, $60, $8F, $70, $8F, $80, $8F, $90, $8F
    db $A0, $8F, $B0, $8F, $C0, $8F, $D0, $8F, $E0, $8F, $F0, $8F, $B0, $8E, $FF, $FF

Data_01D_6DC4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $8C, $10, $8C, $20, $8C, $70, $8C, $80, $8C, $90, $8C, $A0, $8C, $B0, $8C
    db $F0, $8B, $A0, $8E, $B0, $8E, $C0, $8E, $D0, $8E, $FF, $FF

Data_01D_6DE0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0B, $1A, $1C

Data_01D_6DE3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0B, $1C, $1A, $00, $8C, $10, $8C, $20, $8C, $70, $8C, $80, $8C, $90, $8C, $A0
    db $8C, $B0, $8C, $FF, $FF

; wD7F5 = the number of SRAM records (29 in bank 0 from sB356 plus one in bank 1) with bit 7 of byte 0 set (E-0125)
; 4 call sites from 3 routines (e.g. PauseMenu_State3_Case05_Case00, ScriptCommandEB_Run_Case03, StartRecordListOrNoneMessage)
; writes: rRAMG2, rRAMB, wD7F5
; points at: sB356, sA000
CountFlaggedSRAMRecords::
Func_01D_6DF8:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    xor a, a
    ld [wD7F5], a
    ld hl, sB356
    ld c, $00
    ld b, $00

Jump_01D_6E0C::
    ld a, [hl]
    bit 7, a
    jr z, Jump_01D_6E12
    inc c

Jump_01D_6E12::
    inc b
    ld a, $6F
    add_a_to_hl
    ld a, b
    cp a, $1D
    jr c, Jump_01D_6E0C
    ld a, $01
    ld [rRAMB], a
    ld hl, sA000
    ld a, [hl]
    bit 7, a
    jr z, Jump_01D_6E2D
    inc c

Jump_01D_6E2D::
    ld a, c
    ld [wD7F5], a
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ret

; 4 call sites from 4 routines (e.g. SaveStepCopyBank1RecordWC8C4, ScriptCommandEB_Run_Case05_Case3F, ScriptCommandEB_Run_Case04_Case16, ScriptCommandEB_Run_Case04_Case42)
; reads: wD7F2, wD7E1, wD7E6
; writes: rRAMB, rRAMG2, wD7E1, wD7E2, wD7E3, wD7E4, wD7E5, wD7E0, ...
; points at: wD7E0, wD7E2
Func_01D_6E39::
    ld bc, $0007
    ld hl, wD7E0

Jump_01D_6E3F::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01D_6E3F
    call SRAMRecordAddressOfWD7F1
    call EnableSRAMBank0
    push hl
    push de
    ld a, [de]
    and a, $03
    swap a
    sla a
    set 7, a
    ld c, a
    pop de
    push de
    ld a, $0D
    add a, e
    ld e, a
    jr nc, Jump_01D_6E61
    inc d

Jump_01D_6E61::
    ld a, [de]
    and a, $1F
    or a, c
    pop de
    pop hl
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    push hl
    push de
    ld a, $0E
    add a, e
    ld e, a
    jr nc, Jump_01D_6E7F
    inc d

Jump_01D_6E7F::
    ld a, [de]
    and a, $01
    sla a
    sla a
    sla a
    ld c, a
    ld a, [de]
    and a, $F0
    or a, c
    ld c, a
    pop de
    push de
    ld a, $6E
    add a, e
    ld e, a
    jr nc, Jump_01D_6E97
    inc d

Jump_01D_6E97::
    ld a, [de]
    and a, $03
    sla a
    or a, c
    ld c, a
    pop de
    push de
    ld a, $0B
    add a, e
    ld e, a
    jr nc, Jump_01D_6EA7
    inc d

Jump_01D_6EA7::
    inc de
    ld a, [de]
    and a, $01
    or a, c
    ld c, a
    dec de
    ld a, [de]
    pop de
    pop hl
    ld b, a
    ld a, c
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    ld a, b
    ld [hl+], a
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a

Jump_01D_6EC5::
    ld hl, wD7E2
    ld c, $00

Jump_01D_6ECA::
    xor a, a
    ld [hl+], a
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_01D_6ECA
    call SRAMRecordAddressOfWD7F1
    ld a, $03
    add_a_to_hl
    ld a, [wD7E1]
    ld b, a
    sla a
    sla a
    add a, b
    add_a_to_hl
    ld bc, $0000
    call EnableSRAMBank0
    push hl
    ld a, [wD7E1]
    ld hl, Data_01D_6F9A
    add_a_to_hl
    ld a, [hl]
    pop hl
    add a, e
    ld e, a
    jr nc, Jump_01D_6F03
    inc d

Jump_01D_6F03::
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    push de
    push hl
    push bc
    ld a, [de]
    cp a, $8D
    jr z, Jump_01D_6F36
    cp a, $8E
    jr z, Jump_01D_6F36
    cp a, $F0
    jr z, Jump_01D_6F69
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl], a
    pop bc
    push bc
    ld a, c
    ld hl, wD7E2
    add_a_to_hl
    xor a, a
    ld [hl], a
    pop bc
    pop hl
    inc hl
    inc c
    inc b
    jr Jump_01D_6F5B

Jump_01D_6F36::
    pop bc
    dec c
    push bc
    ld b, a
    ld a, c
    ld hl, wD7E2
    add_a_to_hl
    ld a, b
    cp a, $8D
    jr z, Jump_01D_6F4C
    ld a, $02
    jr Jump_01D_6F4E

Jump_01D_6F4C::
    ld a, $01

Jump_01D_6F4E::
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl], a
    pop bc
    inc b
    inc c
    pop hl

Jump_01D_6F5B::
    pop de
    inc de
    ld a, c
    cp a, $05
    jr c, Jump_01D_6F03
    ld a, b
    cp a, $0A
    jr c, Jump_01D_6F03
    jr Jump_01D_6F7C

Jump_01D_6F69::
    pop bc
    pop hl
    pop de
    ld a, c
    cp a, $05
    jr nc, Jump_01D_6F7C
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, $F0
    ld [hl], a

Jump_01D_6F7C::
    ld a, [wD7E1]
    and a, a
    jp z, Jump_01D_6FA0
    cp a, $01
    jp z, Jump_01D_6FDD
    cp a, $02
    jp z, Jump_01D_7019
    cp a, $03
    jp z, Jump_01D_7057
    cp a, $04
    jp z, Jump_01D_708D
    jp Jump_01D_70C6

Data_01D_6F9A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $0F, $1E, $29, $8E, $99

Jump_01D_6FA0::
    call SRAMRecordAddressOfWD7F1
    ld a, $21
    add_a_to_hl
    push hl
    call Pack2BitFieldsFromWD7E2
    pop hl
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, b
    ld [hl], a
    ld a, $06
    add_a_to_hl
    ld a, [wD7E6]
    and a, $03
    swap a
    sla a
    sla a
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ld a, [wD7E1]
    inc a
    ld [wD7E1], a
    jp Jump_01D_6EC5

Jump_01D_6FDD::
    call SRAMRecordAddressOfWD7F1
    ld a, $22
    add_a_to_hl
    push hl
    call Pack2BitFieldsFromWD7E2
    pop hl
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, b
    ld [hl], a
    ld a, $05
    add_a_to_hl
    ld a, [wD7E6]
    and a, $03
    swap a
    ld b, a
    ld a, [hl]
    or a, b
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ld a, [wD7E1]
    inc a
    ld [wD7E1], a
    jp Jump_01D_6EC5

Jump_01D_7019::
    call SRAMRecordAddressOfWD7F1
    ld a, $23
    add_a_to_hl
    push hl
    call Pack2BitFieldsFromWD7E2
    pop hl
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, b
    ld [hl], a
    ld a, $04
    add_a_to_hl
    ld a, [wD7E6]
    and a, $03
    sla a
    sla a
    ld b, a
    ld a, [hl]
    or a, b
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ld a, [wD7E1]
    inc a
    ld [wD7E1], a
    jp Jump_01D_6EC5

Jump_01D_7057::
    call SRAMRecordAddressOfWD7F1
    ld a, $24
    add_a_to_hl
    push hl
    call Pack2BitFieldsFromWD7E2
    pop hl
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, b
    ld [hl], a
    inc hl
    inc hl
    inc hl
    ld a, [wD7E6]
    and a, $03
    ld b, a
    ld a, [hl]
    or a, b
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ld a, [wD7E1]
    inc a
    ld [wD7E1], a
    jp Jump_01D_6EC5

Jump_01D_708D::
    call SRAMRecordAddressOfWD7F1
    ld a, $25
    add_a_to_hl
    push hl
    call Pack2BitFieldsFromWD7E2
    pop hl
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, b
    ld [hl], a
    inc hl
    inc hl
    inc hl
    ld a, [wD7E6]
    and a, $03
    swap a
    sla a
    sla a
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ld a, [wD7E1]
    inc a
    ld [wD7E1], a
    jp Jump_01D_6EC5

Jump_01D_70C6::
    call SRAMRecordAddressOfWD7F1
    ld a, $26
    add_a_to_hl
    push hl
    call Pack2BitFieldsFromWD7E2
    pop hl
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, b
    ld [hl], a
    inc hl
    inc hl
    ld a, [wD7E6]
    and a, $03
    swap a
    ld b, a
    ld a, [hl]
    or a, b
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ld [wD7E1], a
    jp Jump_01D_7121

; B = (wD7E2 & 3) << 6 | (wD7E3 & 3) << 4 | (wD7E4 & 3) << 2 | (wD7E5 & 3), the opposite of unpacking a byte into four 2-bit fields (E-0104)
; 7 call sites from 2 routines (e.g. Func_01D_6E39, Pack2BitFieldsFromWD7E2)
; reads: wD7E2, wD7E3, wD7E4, wD7E5
Pack2BitFieldsFromWD7E2::
Func_01D_70F9:: ; address name
    ld a, [wD7E2]
    and a, $03
    swap a
    sla a
    sla a
    ld b, a
    ld a, [wD7E3]
    and a, $03
    swap a
    or a, b
    ld b, a
    ld a, [wD7E4]
    and a, $03
    sla a
    sla a
    or a, b
    ld b, a
    ld a, [wD7E5]
    and a, $03
    or a, b
    ld b, a
    ret

Jump_01D_7121::
    call SRAMRecordAddressOfWD7F1
    ld a, $28
    add_a_to_hl
    ld a, $73
    add a, e
    ld e, a
    jr nc, Jump_01D_7132
    inc d

Jump_01D_7132::
    call EnableSRAMBank0
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and a, $03
    sla a
    sla a
    ld b, a
    inc de
    ld a, [de]
    and a, $03
    or a, b
    ld b, a
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    or a, b
    ld [hl+], a
    inc de
    ld c, $00

Jump_01D_7157::
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and a, $03
    swap a
    sla a
    sla a
    ld b, a
    inc de
    ld a, [de]
    and a, $03
    swap a
    or a, b
    ld b, a
    inc de
    ld a, [de]
    and a, $03
    sla a
    sla a
    or a, b
    ld b, a
    inc de
    ld a, [de]
    and a, $03
    or a, b
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $06
    jr c, Jump_01D_7157
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and a, $03
    swap a
    sla a
    sla a
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl], a
    push hl
    call SRAMRecordAddressOfWD7F1
    pop hl
    ld a, $1A
    add a, e
    ld e, a
    jr nc, Jump_01D_71B2
    inc d

Jump_01D_71B2::
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and a, $01
    sla a
    ld b, a
    inc de
    inc de
    ld a, [de]
    and a, $01
    or a, b
    ld b, a
    dec de
    dec de
    dec de
    ld a, [de]
    ld c, a
    inc de
    inc de
    ld a, [de]
    ld e, a
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    or a, b
    ld [hl+], a
    ld a, c
    ld [hl+], a
    ld a, e
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ld [wD7E1], a
    call SRAMRecordAddressOfWD7F1
    call EnableSRAMBank0
    push hl
    push de
    ld a, $19
    add a, e
    ld e, a
    jr nc, Jump_01D_71F7
    inc d

Jump_01D_71F7::
    ld a, $32
    add_a_to_hl
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl], a
    pop de
    pop hl
    ld a, $28
    add a, e
    ld e, a
    jr nc, Jump_01D_7217
    inc d

Jump_01D_7217::
    ld a, $33
    add_a_to_hl
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    ld a, $0B
    add a, e
    ld e, a
    jr nc, Jump_01D_7235
    inc d

Jump_01D_7235::
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    ld c, $00

Jump_01D_7248::
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $22
    jr c, Jump_01D_7248
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    call SRAMRecordAddressOfWD7F1
    ld a, $5B
    add a, e
    ld e, a
    jr nc, Jump_01D_7270
    inc d

Jump_01D_7270::
    ld a, $57
    add_a_to_hl
    call EnableSRAMBank0
    ld c, $00

Jump_01D_727C::
    push bc
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and a, $03
    ld [wD7E2], a
    inc de
    ld a, [de]
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and a, $03
    ld [wD7E3], a
    inc de
    ld a, [de]
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and a, $03
    ld [wD7E4], a
    inc de
    ld a, [de]
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and a, $03
    ld [wD7E5], a
    inc de
    call Pack2BitFieldsFromWD7E2
    ld a, b
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    pop bc
    inc c
    ld a, c
    cp a, $02
    jr c, Jump_01D_727C
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    call SRAMRecordAddressOfWD7F1
    call EnableSRAMBank0
    push de
    ld a, $6B
    add a, e
    ld e, a
    jr nc, Jump_01D_730C
    inc d

Jump_01D_730C::
    ld a, $61
    add_a_to_hl
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and a, $02
    sla a
    sla a
    swap a
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and a, $01
    swap a
    sla a
    sla a
    sla a
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl-], a
    pop de
    ld a, $56
    add a, e
    ld e, a
    jr nc, Jump_01D_735E
    inc d

Jump_01D_735E::
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and a, $7F
    ld b, a
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    or a, b
    ld [hl+], a
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    and a, $7F
    ld b, a
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    or a, b
    ld [hl+], a
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    call SRAMRecordAddressOfWD7F1
    call EnableSRAMBank0
    push de
    ld a, $6F
    add a, e
    ld e, a
    jr nc, Jump_01D_73D2
    inc d

Jump_01D_73D2::
    ld a, $67
    add_a_to_hl
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    pop de
    push de
    ld a, $6D
    add a, e
    ld e, a
    jr nc, Jump_01D_7425
    inc d

Jump_01D_7425::
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    pop de
    push de
    ld a, $98
    add a, e
    ld e, a
    jr nc, Jump_01D_743E
    inc d

Jump_01D_743E::
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    pop de
    push de
    ld a, $A3
    add a, e
    ld e, a
    jr nc, Jump_01D_7457
    inc d

Jump_01D_7457::
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    pop de
    push de
    ld a, $A4
    add a, e
    ld e, a
    jr nc, Jump_01D_7470
    inc d

Jump_01D_7470::
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld a, [de]
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld [hl+], a
    pop de
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    xor a, a
    ld [wD7E0], a
    ld a, $FF
    ld [wD7F5], a
    ret

; 4 call sites from 4 routines (e.g. ScanBank1RecordStepWC8C4, ScriptCommandEB_Run_Case05_Case3F, ScriptCommandEB_Run_Case05_Case13, ScriptCommandEB_Run_Case04_Case42)
; reads: wD7F2, wD7F5, wD7F6, wD7F7, wD7F8
; writes: rRAMB, rRAMG2, wD7E0, wD7F5
; points at: wC8CF
Func_01D_7492::
    call SRAMRecordAddressOfWD7F1
    call EnableSRAMBank0
    push de
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and a, $60
    srl a
    swap a
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    ld a, $0D
    add a, e
    ld e, a
    jr nc, Jump_01D_74B6
    inc d

Jump_01D_74B6::
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and a, $1F
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    push de
    inc hl
    ld a, $0E
    add a, e
    ld e, a
    jr nc, Jump_01D_74D2
    inc d

Jump_01D_74D2::
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and a, $08
    srl a
    srl a
    srl a
    ld b, a
    ld a, [hl]
    and a, $F0
    or a, b
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    push de
    ld a, $6E
    add a, e
    ld e, a
    jr nc, Jump_01D_74F8
    inc d

Jump_01D_74F8::
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and a, $06
    srl a
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    ld a, $0B
    add a, e
    ld e, a
    jr nc, Jump_01D_7514
    inc d

Jump_01D_7514::
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    and a, $01
    inc de
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    dec de
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    call SRAMRecordAddressOfWD7F1
    call EnableSRAMBank0
    push de
    call LoadRecordNameEntry0
    pop de
    push de
    ld a, $01
    add a, e
    ld e, a
    jr nc, Jump_01D_7552
    inc d

Jump_01D_7552::
    ld hl, wC8CF
    call CopyTenBytesThenSelectSRAMBank0
    pop de
    push de
    call LoadRecordNameEntry1
    pop de
    push de
    ld a, $0F
    add a, e
    ld e, a
    jr nc, Jump_01D_7566
    inc d

Jump_01D_7566::
    ld hl, wC8CF
    call CopyTenBytesThenSelectSRAMBank0
    pop de
    push de
    call LoadRecordNameEntry2
    pop de
    push de
    ld a, $1E
    add a, e
    ld e, a
    jr nc, Jump_01D_757A
    inc d

Jump_01D_757A::
    ld hl, wC8CF
    call CopyTenBytesThenSelectSRAMBank0
    pop de
    push de
    call LoadRecordNameEntry3
    pop de
    push de
    ld a, $29
    add a, e
    ld e, a
    jr nc, Jump_01D_758E
    inc d

Jump_01D_758E::
    ld hl, wC8CF
    call CopyTenBytesThenSelectSRAMBank0
    pop de
    push de
    call LoadRecordNameEntry4
    pop de
    push de
    ld a, $8E
    add a, e
    ld e, a
    jr nc, Jump_01D_75A2
    inc d

Jump_01D_75A2::
    ld hl, wC8CF
    call CopyTenBytesThenSelectSRAMBank0
    pop de
    push de
    call LoadRecordNameEntry5
    pop de
    push de
    ld a, $99
    add a, e
    ld e, a
    jr nc, Jump_01D_75B6
    inc d

Jump_01D_75B6::
    ld hl, wC8CF
    call CopyTenBytesThenSelectSRAMBank0
    pop de
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    jp Jump_01D_75DA

; copies 10 bytes from HL to DE, selecting SRAM bank 0 (rRAMB = 0) after each byte is read; HL and DE advance (E-0106)
; 6 call sites from 1 routine (e.g. Func_01D_7492)
; writes: rRAMB
CopyTenBytesThenSelectSRAMBank0::
Func_01D_75C7:: ; address name
    ld c, $00

Jump_01D_75C9::
    ld a, [hl]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    inc hl
    inc c
    ld a, c
    cp a, $0A
    jr c, Jump_01D_75C9
    ret

Jump_01D_75DA::
    call SRAMRecordAddressOfWD7F1
    call EnableSRAMBank0
    ld a, $28
    add_a_to_hl
    push de
    ld a, $73
    add a, e
    ld e, a
    jr nc, Jump_01D_75EF
    inc d

Jump_01D_75EF::
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and a, $0C
    srl a
    srl a
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    and a, $03
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    ld c, $00

Jump_01D_761B::
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and a, $C0
    srl a
    srl a
    swap a
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and a, $30
    swap a
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and a, $0C
    srl a
    srl a
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    and a, $03
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    inc c
    ld a, c
    cp a, $06
    jr c, Jump_01D_761B
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and a, $C0
    srl a
    srl a
    swap a
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    ld a, $1A
    add a, e
    ld e, a
    jr nc, Jump_01D_7699
    inc d

Jump_01D_7699::
    inc hl
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    dec hl
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and a, $02
    srl a
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    cp a, $01
    jr nz, Jump_01D_76CE
    dec de
    ld a, [de]
    inc de
    cp a, $FF
    jr nz, Jump_01D_76CE
    ld a, $FF
    ld [de], a

Jump_01D_76CE::
    inc de
    inc de
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and a, $01
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    dec de
    inc hl
    inc hl
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    cp a, $FF
    jr nz, Jump_01D_7702
    inc de
    ld a, [de]
    cp a, $01
    jr nz, Jump_01D_7702
    ld a, $FF
    ld [de], a

Jump_01D_7702::
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    call SRAMRecordAddressOfWD7F1
    call EnableSRAMBank0
    ld a, $32
    add_a_to_hl
    push de
    ld a, $19
    add a, e
    ld e, a
    jr nc, Jump_01D_771E
    inc d

Jump_01D_771E::
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    push de
    ld a, $28
    add a, e
    ld e, a
    jr nc, Jump_01D_7737
    inc d

Jump_01D_7737::
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    ld a, $0B
    add a, e
    ld e, a
    jr nc, Jump_01D_774E
    inc d

Jump_01D_774E::
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    ld a, $34
    add a, e
    ld e, a
    jr nc, Jump_01D_7766
    inc d

Jump_01D_7766::
    ld c, $00

Jump_01D_7768::
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    inc c
    ld a, c
    cp a, $22
    jr c, Jump_01D_7768
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    call SRAMRecordAddressOfWD7F1
    call EnableSRAMBank0
    ld a, $57
    add_a_to_hl
    push de
    ld a, $5B
    add a, e
    ld e, a
    jr nc, Jump_01D_779B
    inc d

Jump_01D_779B::
    ld c, $00

Jump_01D_779D::
    push de
    push hl
    ld a, $04
    add_a_to_hl
    call UnpackByteAtHLTo2BitFieldsWD7F5
    pop hl
    pop de
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    ld a, [wD7F5]
    ld [de], a
    inc de
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    ld a, [wD7F6]
    ld [de], a
    inc de
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    ld a, [wD7F7]
    ld [de], a
    inc de
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    ld a, [wD7F8]
    ld [de], a
    inc de
    inc hl
    inc c
    ld a, c
    cp a, $02
    jr c, Jump_01D_779D
    pop de
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    call SRAMRecordAddressOfWD7F1
    call EnableSRAMBank0
    ld a, $61
    add_a_to_hl
    push de
    ld a, $6B
    add a, e
    ld e, a
    jr nc, Jump_01D_7827
    inc d

Jump_01D_7827::
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    ld c, a
    ld a, [hl+]
    and a, $80
    srl a
    srl a
    swap a
    ld b, a
    ld a, [hl-]
    and a, $80
    srl a
    srl a
    srl a
    swap a
    or a, b
    ld b, a
    ld a, c
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    pop de
    ld a, $56
    add a, e
    ld e, a
    jr nc, Jump_01D_785B
    inc d

Jump_01D_785B::
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    and a, $7F
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    and a, $7F
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    call SRAMRecordAddressOfWD7F1
    call EnableSRAMBank0
    ld a, $67
    add_a_to_hl
    push de
    ld a, $6F
    add a, e
    ld e, a
    jr nc, Jump_01D_78CF
    inc d

Jump_01D_78CF::
    ld c, $00

Jump_01D_78D1::
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    inc de
    inc c
    ld a, c
    cp a, $04
    jr c, Jump_01D_78D1
    pop de
    push de
    ld a, $6D
    add a, e
    ld e, a
    jr nc, Jump_01D_78F1
    inc d

Jump_01D_78F1::
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    push de
    ld a, $98
    add a, e
    ld e, a
    jr nc, Jump_01D_790A
    inc d

Jump_01D_790A::
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    push de
    ld a, $A3
    add a, e
    ld e, a
    jr nc, Jump_01D_7923
    inc d

Jump_01D_7923::
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    push de
    ld a, $A4
    add a, e
    ld e, a
    jr nc, Jump_01D_793C
    inc d

Jump_01D_793C::
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl+]
    push af
    xor a, a
    ld [rRAMB], a
    pop af
    ld [de], a
    pop de
    xor a, a
    ld [rRAMG2], a
    ld [rRAMB], a
    ld [wD7E0], a
    ld a, $FF
    ld [wD7F5], a
    ret

; record wD7F1 (SRAM bank wD7F2): unpacks byte $21 into the four 2-bit fields wD7F5-wD7F8, sets wMenuInputResult = bits 7-6 of byte $27, and copies the 5-glyph name entry at offset 3 (Func_01D_7A90); one of six name entries in the record (E-0120)
; 6 call sites from 6 routines (e.g. Func_01D_7492, ScriptCommandEB_Run_Shared03, ScriptCommandEB_Run_Case05_Case2F_Sub03, Func_015_6B00, ...)
; reads: wD7F2
; writes: rRAMB, wMenuInputResult
LoadRecordNameEntry0::
Func_01D_795D:: ; address name
    call SRAMRecordAddressOfWD7F1
    call EnableSRAMBank0
    push hl
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, $21
    add_a_to_hl
    call UnpackByteAtHLTo2BitFieldsWD7F5
    ld a, $06
    add_a_to_hl
    ld a, [hl]
    and a, $C0
    srl a
    srl a
    swap a
    ld [wMenuInputResult], a
    pop hl
    inc hl
    inc hl
    inc hl
    call BuildFiveGlyphNameWithMarksToWC8CF
    ret

; record wD7F1 (SRAM bank wD7F2): unpacks byte $22 into the four 2-bit fields wD7F5-wD7F8, sets wMenuInputResult = bits 5-4 of byte $27, and copies the 5-glyph name entry at offset 8 (Func_01D_7A90); one of six name entries in the record (E-0120)
; 1 call site from 1 routine (e.g. Func_01D_7492)
; reads: wD7F2
; writes: rRAMB, wMenuInputResult
LoadRecordNameEntry1::
Func_01D_7991:: ; address name
    call SRAMRecordAddressOfWD7F1
    call EnableSRAMBank0
    push hl
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, $22
    add_a_to_hl
    call UnpackByteAtHLTo2BitFieldsWD7F5
    ld a, $05
    add_a_to_hl
    ld a, [hl]
    and a, $30
    swap a
    ld [wMenuInputResult], a
    pop hl
    ld a, $08
    add_a_to_hl
    call BuildFiveGlyphNameWithMarksToWC8CF
    ret

; record wD7F1 (SRAM bank wD7F2): unpacks byte $23 into the four 2-bit fields wD7F5-wD7F8, sets wMenuInputResult = bits 3-2 of byte $27, and copies the 5-glyph name entry at offset $0D (Func_01D_7A90); one of six name entries in the record (E-0120)
; 1 call site from 1 routine (e.g. Func_01D_7492)
; reads: wD7F2
; writes: rRAMB, wMenuInputResult
LoadRecordNameEntry2::
Func_01D_79C5:: ; address name
    call SRAMRecordAddressOfWD7F1
    call EnableSRAMBank0
    push hl
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, $23
    add_a_to_hl
    call UnpackByteAtHLTo2BitFieldsWD7F5
    ld a, $04
    add_a_to_hl
    ld a, [hl]
    and a, $0C
    srl a
    srl a
    ld [wMenuInputResult], a
    pop hl
    ld a, $0D
    add_a_to_hl
    call BuildFiveGlyphNameWithMarksToWC8CF
    ret

; record wD7F1 (SRAM bank wD7F2): unpacks byte $24 into the four 2-bit fields wD7F5-wD7F8, sets wMenuInputResult = bits 1-0 of byte $27, and copies the 5-glyph name entry at offset $12 (Func_01D_7A90); one of six name entries in the record (E-0120)
; 1 call site from 1 routine (e.g. Func_01D_7492)
; reads: wD7F2
; writes: rRAMB, wMenuInputResult
LoadRecordNameEntry3::
Func_01D_79FB:: ; address name
    call SRAMRecordAddressOfWD7F1
    call EnableSRAMBank0
    push hl
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, $24
    add_a_to_hl
    call UnpackByteAtHLTo2BitFieldsWD7F5
    ld a, $03
    add_a_to_hl
    ld a, [hl]
    and a, $03
    ld [wMenuInputResult], a
    pop hl
    ld a, $12
    add_a_to_hl
    call BuildFiveGlyphNameWithMarksToWC8CF
    ret

; record wD7F1 (SRAM bank wD7F2): unpacks byte $25 into the four 2-bit fields wD7F5-wD7F8, sets wMenuInputResult = bits 7-6 of byte $28, and copies the 5-glyph name entry at offset $17 (Func_01D_7A90); one of six name entries in the record (E-0120)
; 1 call site from 1 routine (e.g. Func_01D_7492)
; reads: wD7F2
; writes: rRAMB, wMenuInputResult
LoadRecordNameEntry4::
Func_01D_7A2D:: ; address name
    call SRAMRecordAddressOfWD7F1
    call EnableSRAMBank0
    push hl
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, $25
    add_a_to_hl
    call UnpackByteAtHLTo2BitFieldsWD7F5
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    and a, $C0
    srl a
    srl a
    swap a
    ld [wMenuInputResult], a
    pop hl
    ld a, $17
    add_a_to_hl
    call BuildFiveGlyphNameWithMarksToWC8CF
    ret

; record wD7F1 (SRAM bank wD7F2): unpacks byte $26 into the four 2-bit fields wD7F5-wD7F8, sets wMenuInputResult = bits 5-4 of byte $28, and copies the 5-glyph name entry at offset $1C (Func_01D_7A90); one of six name entries in the record (E-0120)
; 1 call site from 1 routine (e.g. Func_01D_7492)
; reads: wD7F2
; writes: rRAMB, wMenuInputResult
LoadRecordNameEntry5::
Func_01D_7A61:: ; address name
    call SRAMRecordAddressOfWD7F1
    call EnableSRAMBank0
    push hl
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, $26
    add_a_to_hl
    call UnpackByteAtHLTo2BitFieldsWD7F5
    inc hl
    inc hl
    ld a, [hl]
    and a, $30
    swap a
    ld [wMenuInputResult], a
    pop hl
    ld a, $1C
    add_a_to_hl
    call BuildFiveGlyphNameWithMarksToWC8CF
    ret

; fills wC8CF with $F0 and copies up to five glyphs from HL, adding mark $8D or $8E after each glyph whose wD7F5 field is 1 or 2 (E-0127)
; 6 call sites from 6 routines (e.g. LoadRecordNameEntry5, LoadRecordNameEntry4, LoadRecordNameEntry3, LoadRecordNameEntry2, ...)
; points at: wC8CF, wD7F5
BuildFiveGlyphNameWithMarksToWC8CF::
Func_01D_7A90:: ; address name
    ld de, wC8CF
    ld c, $00

Jump_01D_7A95::
    ld a, $F0
    ld [de], a
    inc de
    inc c
    ld a, c
    cp a, $0B
    jr c, Jump_01D_7A95
    ld bc, $0000
    ld de, wC8CF

Jump_01D_7AA5::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_01D_7AD6
    ld [de], a
    inc de
    push hl
    ld a, c
    ld hl, wD7F5
    add_a_to_hl
    ld a, [hl]
    and a, a
    jr z, Jump_01D_7ACC
    cp a, $01
    jr z, Jump_01D_7AC8
    cp a, $02
    jr z, Jump_01D_7AC4
    jr Jump_01D_7ACC

Jump_01D_7AC4::
    ld a, $8E
    jr Jump_01D_7ACA

Jump_01D_7AC8::
    ld a, $8D

Jump_01D_7ACA::
    ld [de], a
    inc de

Jump_01D_7ACC::
    pop hl
    inc hl
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_01D_7AA5
    ld a, $F0

Jump_01D_7AD6::
    ld [de], a
    ret

; with SRAM bank wD7F2 selected, splits the byte at HL into four 2-bit fields: wD7F5 = bits 7-6, wD7F6 = bits 5-4, wD7F7 = bits 3-2, wD7F8 = bits 1-0 (E-0104)
; 7 call sites from 7 routines (e.g. CopyTenBytesThenSelectSRAMBank0, LoadRecordNameEntry5, LoadRecordNameEntry4, LoadRecordNameEntry3, ...)
; reads: wD7F2
; writes: rRAMB, wD7F5, wD7F6, wD7F7, wD7F8
UnpackByteAtHLTo2BitFieldsWD7F5::
Func_01D_7AD8:: ; address name
    push af
    ld a, [wD7F2]
    ld [rRAMB], a
    pop af
    ld a, [hl]
    and a, $C0
    srl a
    srl a
    swap a
    ld [wD7F5], a
    ld a, [hl]
    and a, $30
    swap a
    ld [wD7F6], a
    ld a, [hl]
    and a, $0C
    srl a
    srl a
    ld [wD7F7], a
    ld a, [hl]
    and a, $03
    ld [wD7F8], a
    ret

; writes $0A to the RAM-enable register (rRAMG2 alias) and selects SRAM bank 0 (rRAMB = 0); clobbers A (E-0066)
; 20 call sites from 10 routines (e.g. Func_01D_7492, CopyTenBytesThenSelectSRAMBank0, LoadRecordNameEntry5, LoadRecordNameEntry4, ...)
; writes: rRAMG2, rRAMB
EnableSRAMBank0::
Func_01D_7B05:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ret

; HL = the word at wD7F3/wD7F4; DE = sA000 + $A5 * wD7F1, the start of SRAM record wD7F1 (records are $A5 bytes, as in SRAMRecordAddress); clobbers A, BC (E-0063)
; 27 call sites from 10 routines (e.g. Func_01D_7492, CopyTenBytesThenSelectSRAMBank0, LoadRecordNameEntry5, LoadRecordNameEntry4, ...)
; reads: wD7F3, wD7F4, wD7F1
; points at: sA000
SRAMRecordAddressOfWD7F1::
Func_01D_7B0F:: ; address name
    ld a, [wD7F3]
    ld l, a
    ld a, [wD7F4]
    ld h, a
    push hl
    ld a, [wD7F1]
    ld c, $A5
    call Multiply8
    ld de, sA000
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ret
    ds $4D8, $00
