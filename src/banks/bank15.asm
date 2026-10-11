SECTION "Bank 15", ROMX[$4000], BANK[$15]
    db $15

; implements script command type EE; reached through ScriptCommandEE in bank $10 (E-0038)
; 4 call sites from 4 routines (e.g. ScriptCommandF1_Run_Case00, ScriptCommandEE, ScriptCommandE9_Run_Case01, ScriptCommandE9_Run_Case03)
; reads: wD788
ScriptCommandEE_Run::
Func_015_4001:: ; address name
    ld a, [wD788]
    rst $00
    dw ScriptCommandEE_Run_Case00
    dw ScriptCommandEE_Run_Case01
    dw ScriptCommandEE_Run_Case02
    dw ScriptCommandEE_Run_Case03

; entry 0 of the `rst $00` table in ScriptCommandEE_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wD788
; writes: wD788
; points at: wScreenTileBuffer, wD1CC, wD000
ScriptCommandEE_Run_Case00::
Jump_015_400D:: ; address name
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank15
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_015_402B
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank15

Jump_015_402B::
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, [wD788]
    inc a
    ld [wD788], a
    ret

; entry 1 of the `rst $00` table in ScriptCommandEE_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD788
; writes: wD784, wD785, wD780, wD781, wMenuState, wD788, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
ScriptCommandEE_Run_Case01::
Jump_015_403F:: ; address name
    ld hl, Data_015_72A9
    ld de, Data_015_72FF
    call CopyGlyphTileListFromBank1F_Bank15
    xor a, a
    ld [wD784], a
    ld [wD785], a
    ld [wD780], a
    ld [wD781], a
    ld [wMenuState], a
    ld a, [wD788]
    inc a
    ld [wD788], a
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ScriptCommandEE_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD788
; writes: wD788
ScriptCommandEE_Run_Case02::
Jump_015_4076:: ; address name
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call FillTilesBxC
    ld de, Data_01F_4230
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4290
    ld hl, vTiles1 + $4F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4370
    ld hl, vTiles1 + $5F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wD788]
    inc a
    ld [wD788], a
    ret

; entry 3 of the `rst $00` table in ScriptCommandEE_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wD7F0, wD788, hSpriteHideTile, wScriptCommandType, wScriptStartRequest
; points at: wD780, wTextBuf0, wTextWindowTileLo
ScriptCommandEE_Run_Case03::
Jump_015_40AE:: ; address name
    farcall DrawRecordListNameTiles_Bank1D
    farcall LoadTilesForPartyRecords
    xor a, a
    ld [wD7F0], a
    ld [wD788], a
    ld bc, $006F
    ld hl, wD780

Jump_015_40C7::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_015_40C7
    ld hl, wTextBuf0
    ld b, $10

Jump_015_40D3::
    ld a, $F0
    ld [hl+], a
    dec b
    jr nz, Jump_015_40D3
    farcall WritePlayerNameWithFlag0SuffixToWC130
    ld a, $80
    ldh [hSpriteHideTile], a
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type ED; reached through ScriptCommandED in bank $10 (E-0038)
; 27 call sites from 27 routines (e.g. ScriptCommandEF_Run_Case05_Case00, ScriptCommandF4_Run_Case04_Case00, ScriptCommandF4_Run_Case04_Case0C, ScriptCommandF4_Run_Case11_Case02, ...)
; reads: wD780
ScriptCommandED_Run::
Func_015_40FA:: ; address name
    ld a, [wD780]
    rst $00
    dw ScriptCommandED_Run_Case00
    dw ScriptCommandED_Run_Case01
    dw ScriptCommandED_Run_Case02
    dw ScriptCommandED_Run_Case03
    dw ScriptCommandED_Run_Case04
    dw ScriptCommandED_Run_Case05
    dw ScriptCommandED_Run_Case06
    dw ScriptCommandED_Run_Case07
    dw ScriptCommandED_Run_Case08
    dw ScriptCommandED_Run_Case09
    dw ScriptCommandED_Run_Case0A
    dw ScriptCommandED_Run_Case0B
    dw ScriptCommandED_Run_Case0C
    dw ScriptCommandED_Run_Case0D
    dw ScriptCommandED_Run_Case0D
    dw ScriptCommandED_Run_Case0F
    dw ScriptCommandED_Run_Case10
    dw ScriptCommandED_Run_Case11
    dw ScriptCommandED_Run_Case12

; entry 0 of the `rst $00` table in ScriptCommandED_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wD7F0, hSpriteHideTile, wScriptCommandType, wScriptStartRequest
; points at: wD780, wScreenTileBuffer, wD1CC, wD000
ScriptCommandED_Run_Case00::
Jump_015_4124:: ; address name
    ld hl, wD780
    ld bc, $006F

Jump_015_412A::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_015_412A
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank15
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_015_414F
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank15

Jump_015_414F::
    ld a, $05
    ld [wD7F0], a
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a, a
    ld hl, wD780
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in ScriptCommandED_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandED_Run_Case01::
Jump_015_4167:: ; address name
    ld a, [wD781]
    rst $00
    dw DrawPair72A9And72C5AndStep
    dw DrawGoldBoxAndStep_Bank15
    dw ScriptCommandED_Run_Case01_Case02

; runs Func_015_6374 for Data_015_72A9 and Data_015_72C5, then wD781 += 1 (E-0122)
; 4 call sites from 4 routines (e.g. ScriptCommandED_Run_Case04_Case3A, ScriptCommandED_Run_Case04_Case33, ScriptCommandED_Run_Case04_Case0A, ScriptCommandED_Run_Case0F_Case01)
; reads: wD781
; writes: wD781
DrawPair72A9And72C5AndStep::
Func_015_4171:: ; address name
    ld hl, Data_015_72A9
    ld de, Data_015_72C5
    call CopyGlyphTileListFromBank1F_Bank15
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; copies box Data_015_7291 to wC370 and writes the gold as five digit tiles at wC386, then wD781 += 1 (E-0125)
; 6 call sites from 6 routines (e.g. ScriptCommandED_Run_Case04_Case3A, ScriptCommandED_Run_Case04_Case33, ScriptCommandED_Run_Case04_Case1F, ScriptCommandED_Run_Case05_Case08, ...)
; reads: wD781
; writes: wD781
; points at: wGoldLo, wDigits, wD7F3
DrawGoldBoxAndStep_Bank15::
Func_015_4182:: ; address name
    ld de, Data_015_7291
    ld hl, wWindowTileBuffer + $70
    ld bc, $0803
    call CopyRectTo20ByteRows_Bank15
    ld hl, wGoldLo
    ld de, wDigits
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    call Number24ToPackedBCD
    call UnpackBCDToDigitsWD7F1
    ld hl, wWindowTileBuffer + $86
    ld de, wD7F3
    ld c, $00

Jump_015_41AA::
    ld a, [de]
    add a, $E0
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_015_41AA
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 2 of the `rst $00` table in ScriptCommandED_Run_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wD780
; writes: wD781, wD780
ScriptCommandED_Run_Case01_Case02::
Jump_015_41BD:: ; address name
    ld de, Data_015_6F6B
    ld hl, wWindowTileBuffer + $64
    ld bc, $0807
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    xor a, a
    ld [wD781], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; entry 2 of the `rst $00` table in ScriptCommandED_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommandED_Run_Case02::
Jump_015_41E1:: ; address name
    call HandleThreeOptionMenuInput_15
    ret

; entry 3 of the `rst $00` table in ScriptCommandED_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD786, wD7B9, wD780
; writes: wTwoChoiceCursor, wD780, wScriptCommandType, wScriptStartRequest
ScriptCommandED_Run_Case03::
Jump_015_41E5:: ; address name
    ld a, [wD786]
    and a, a
    jr z, Jump_015_41ED
    jr Jump_015_41F5

Jump_015_41ED::
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

Jump_015_41F5::
    farcall ListRecordsInUseWithByte6ESet
    ld a, [wD7B9]
    and a, a
    jr nz, Jump_015_4215
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_015_4215::
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD780]
    inc a
    inc a
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 4 of the `rst $00` table in ScriptCommandED_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandED_Run_Case04::
Jump_015_422B:: ; address name
    ld a, [wD781]
    rst $00
    dw ScriptCommandED_Run_Case04_Case00
    dw ScriptCommandED_Run_Case04_Case01
    dw ScriptCommandED_Run_Case04_Case02
    dw ScriptCommandED_Run_Case04_Case03
    dw ScriptCommandED_Run_Case04_Case04
    dw ScriptCommandED_Run_Case04_Case05
    dw ScriptCommandED_Run_Case04_Case06
    dw ScriptCommandED_Run_Case04_Case07
    dw ScriptCommandED_Run_Case04_Case08
    dw ScriptCommandED_Run_Case04_Case09
    dw ScriptCommandED_Run_Case04_Case0A
    dw ScriptCommandED_Run_Case04_Case0B
    dw ScriptCommandED_Run_Case04_Case0C
    dw ScriptCommandED_Run_Case04_Case0D
    dw ScriptCommandED_Run_Case04_Case0E
    dw ScriptCommandED_Run_Case04_Case0F
    dw ScriptCommandED_Run_Case04_Case10
    dw ScriptCommandED_Run_Case04_Case11
    dw ScriptCommandED_Run_Case04_Case12
    dw ScriptCommandED_Run_Case04_Case13
    dw ScriptCommandED_Run_Case04_Case14
    dw ScriptCommandED_Run_Case04_Case15
    dw ScriptCommandED_Run_Case04_Case16
    dw ScriptCommandED_Run_Case04_Case03
    dw DrawWD789Cell5IconAndLevelAndStep
    dw ScriptCommandED_Run_Case04_Case19
    dw DrawWD789Cell5RecordNamesAndStep
    dw ScriptCommandED_Run_Case04_Case1B
    dw ScriptCommandED_Run_Case04_Case1C
    dw DrawScreenBufferAtScrollAndIncWD781
    dw ScriptCommandED_Run_Case04_Case1E
    dw ScriptCommandED_Run_Case04_Case1F
    dw ScriptCommandED_Run_Case04_Case20
    dw ScriptCommandED_Run_Case04_Case0C
    dw ScriptCommandED_Run_Case04_Case0D
    dw ScriptCommandED_Run_Case04_Case0E
    dw ScriptCommandED_Run_Case04_Case24
    dw ScriptCommandED_Run_Case04_Case25
    dw ScriptCommandED_Run_Case04_Case26
    dw ScriptCommandED_Run_Case04_Case27
    dw ScriptCommandED_Run_Case04_Case28
    dw ScriptCommandED_Run_Case04_Case29
    dw DrawRect70C5IfWC58AAndStep
    dw ScriptCommandED_Run_Case04_Case2B
    dw ScriptCommandED_Run_Case04_Case2C
    dw ScriptCommandED_Run_Case04_Case2D
    dw ScriptCommandED_Run_Case04_Case2E
    dw ScriptCommandED_Run_Case04_Case2F
    dw ScriptCommandED_Run_Case04_Case30
    dw ScriptCommandED_Run_Case04_Case31
    dw ScriptCommandED_Run_Case04_Case32
    dw ScriptCommandED_Run_Case04_Case33
    dw ScriptCommandED_Run_Case04_Case34
    dw ScriptCommandED_Run_Case04_Case0B
    dw ScriptCommandED_Run_Case04_Case36
    dw ScriptCommandED_Run_Case04_Case30
    dw ScriptCommandED_Run_Case04_Case31
    dw ScriptCommandED_Run_Case04_Case32
    dw ScriptCommandED_Run_Case04_Case3A
    dw ScriptCommandED_Run_Case04_Case3B
    dw ScriptCommandED_Run_Case04_Case3C
    dw ScriptCommandED_Run_Case04_Case3D
    dw ScriptCommandED_Run_Case04_Case3E
    dw ScriptCommandED_Run_Case04_Case3F
    dw ScriptCommandED_Run_Case04_Case40
    dw ScriptCommandED_Run_Case04_Case41

; entry 0 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F1, wD7F2, wD7AB, wD7AF, wD7AE, wD7AD, wD781
ScriptCommandED_Run_Case04_Case00::
Jump_015_42B3:: ; address name
    ld c, $0B
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [wD7F1], a
    ld a, $08
    ld [wD7F2], a
    call ScriptCommandED_Run_Shared03
    ld de, Data_015_42F4
    ld hl, wWindowTileBuffer + $64
    ld bc, $080B
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    xor a, a
    ld [wD7AB], a
    ld [wD7AF], a
    ld [wD7AE], a
    ld [wD7AD], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Data_015_42F4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0542F4, $58

; entry 1 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
ScriptCommandED_Run_Case04_Case01::
Jump_015_434C:: ; address name
    call ClearTileAreas1240_1700_14E0
    ld de, Data_015_747D
    ld hl, wWindowTileBuffer + $64
    ld bc, $080B
    call CopyRectTo20ByteRows_Bank15
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 2 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B0, wD781
; writes: wD7F1, wD7F2, wD781
ScriptCommandED_Run_Case04_Case02::
Jump_015_4363:: ; address name
    farcall ListRecordsInUseWithByte6EClear

Jump_015_4369::
    farcall ClampRecordListPageCursor5
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_015_43A4
    ld de, $0142
    call DrawC5BEC6AtScrollOffsetDE_Bank15
    ld hl, wWindowTileBuffer + $12E
    call StoreC5BEC6AtHLStride2_Bank15
    ld de, $0143
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    farcall DrawPageOfPagesAtScrollOffset
    ld hl, wWindowTileBuffer + $12F
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    farcall DrawPageOfPagesAtWD7F1_Bank1E

Jump_015_43A4::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 3 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wD7F1
ScriptCommandED_Run_Case04_Case03::
Jump_015_43AC:: ; address name
    farcall DrawRecordListPageNames
    xor a, a
    ld [wD7F1], a
    farcall MarkPartyMembersInRecordListPage
    ret

; entry 4 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F1, wD7F2, wD7F3, wD781
ScriptCommandED_Run_Case04_Case04::
Jump_015_43BD:: ; address name
    farcall SetWD7F5ToWD789Cell5
    ld a, [hl]
    ld b, a
    push af
    ld a, $C7
    ld [wD7F1], a
    call LoadFamilyIconTileForRecordB_Bank15
    ld de, Data_015_74D5
    ld hl, wWindowTileBuffer + $BC
    ld bc, $0C09
    call CopyRectTo20ByteRows_Bank15
    pop af
    ld [wD7F1], a
    ld hl, wWindowTileBuffer + $D6
    ld a, l
    ld [wD7F2], a
    ld a, h
    ld [wD7F3], a
    call DrawRecordField0EMarkAndField56Digits
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 5 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; points at: wTextWindowTileLo, wD781
ScriptCommandED_Run_Case04_Case05::
Jump_015_43F4:: ; address name
    ld hl, vTiles1 + $270
    ld bc, $0901
    call FillTilesBxC
    ld hl, vTiles1 + $780
    ld bc, $0501
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld hl, wD781
    inc [hl]
    ret

; entry 6 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, wD781
; writes: wD7F1, wD781
ScriptCommandED_Run_Case04_Case06::
Jump_015_4418:: ; address name
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    ld [wD7F1], a
    farcall DrawRecordNameAndSpeciesNameTiles
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; DrawScreenBufferRect_Bank15 (20 x 13 from buffer offset $01CC at the scroll origin), then wD781 += 1 (E-0119)
; 1 call site from 1 routine (e.g. ScriptCommandED_Run_Case04_Case07)
; reads: wD781
; writes: wD781
DrawScreenBufferAtScrollAndIncWD781::
Func_015_4439:: ; address name
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 7 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD7AB
ScriptCommandED_Run_Case04_Case07::
Jump_015_444D:: ; address name
    ld a, [wD7AB]
    ld b, $BB
    ld hl, Data_015_73A1
    call StoreBAtWordTableEntry_Bank15
    call DrawScreenBufferAtScrollAndIncWD781
    ld a, [wD7AB]
    ld b, $C3
    ld hl, Data_015_73A1
    call StoreBAtWordTableEntry_Bank15
    ret

; entry 8 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wD781, wD7AB
; writes: wMenuInputResult, wD781, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
ScriptCommandED_Run_Case04_Case08::
Jump_015_4467:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_015_448B
    cp a, $FC
    jr z, Jump_015_448B
    cp a, $FD
    jr z, Jump_015_44CA
    cp a, $FE
    jr z, Jump_015_4494
    cp a, $FF
    jr z, Jump_015_449C
    ret

Jump_015_448B::
    ld a, [wD781]
    sub a, $07
    ld [wD781], a
    ret

Jump_015_4494::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_449C::
    ld a, [wD781]
    add a, $04
    ld [wD781], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_015_73A1
    call StoreBAtWordTableEntry_Bank15
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_015_44CA::
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

; entry 9 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F1, wD7F2, wD781
ScriptCommandED_Run_Case04_Case09::
Jump_015_44D3:: ; address name
    ld c, $0B
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [wD7F1], a
    ld a, $09
    ld [wD7F2], a
    call ScriptCommandED_Run_Shared03
    ld c, $09
    ld hl, $0224
    ld de, $0058
    xor a, a
    ld [wD7F1], a
    ld a, $0C
    ld [wD7F2], a
    call ScriptCommandED_Run_Shared03
    ld de, Data_015_6FA3
    ld hl, wWindowTileBuffer + $64
    ld bc, $0807
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 10 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD786
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
ScriptCommandED_Run_Case04_Case0A::
Jump_015_451B:: ; address name
    call DrawPair72A9And72C5AndStep
    ld de, Data_015_6F6B
    ld hl, wWindowTileBuffer + $64
    ld bc, $0807
    call CopyRectTo20ByteRows_Bank15
    ld a, [wD786]
    ld hl, Data_015_732D
    ld b, $BC
    call StoreBAtWordTableEntry_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 12 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
ScriptCommandED_Run_Case04_Case0C::
Jump_015_4550:: ; address name
    ld de, Data_015_7379
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 13 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wTwoChoiceCursor, wD7AD, wD781
ScriptCommandED_Run_Case04_Case0D::
Jump_015_4570:: ; address name
    ld a, $6C
    call QueueSoundEffect
    ld hl, Data_015_72E1
    ld de, Data_015_72F1
    call CopyGlyphTileListFromBank1F_Bank15
    ld de, Data_015_7351
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    xor a, a
    ld [wTwoChoiceCursor], a
    ld [wD7AD], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 15 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
ScriptCommandED_Run_Case04_Case0F::
Jump_015_45A5:: ; address name
    ld de, Data_015_7505
    ld hl, wWindowTileBuffer + $10C
    ld bc, $0C05
    call CopyRectTo20ByteRows_Bank15
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 16 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wD781, wScriptCommandType, wScriptStartRequest
ScriptCommandED_Run_Case04_Case10::
Jump_015_45B9:: ; address name
    ld c, $05
    ld hl, Data_015_73A1
    call BlankWordTableTargets
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, $08
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 17 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, hTemp0, wD7A9, wD781, wPartyCount, wPartyList, wD7AB, ...
; writes: rRAMG2, rRAMB, wD7F5, wTwoChoiceCursor, wD781, wScriptCommandType, wScriptStartRequest, wD7B4, ...
; points at: wD789
ScriptCommandED_Run_Case04_Case11::
Jump_015_45DC:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    push hl
    ld a, [hl]
    ld c, $0E
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $01
    ld [wD7F5], a
    ld hl, wD789
    ld c, $00

Jump_015_4606::
    push hl
    push bc
    ld a, [hl]
    ld c, $0E
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $01
    ld b, a
    ld a, [wD7F5]
    cp a, b
    jr nz, Jump_015_463F
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wD7A9]
    cp a, c
    jr nz, Jump_015_4606
    pop hl
    ld a, $03
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wD781]
    dec a
    dec a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_015_463F::
    pop bc
    pop hl
    pop hl
    push hl
    ld a, [hl]
    ld c, $56
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    cp a, $0A
    jr nc, Jump_015_466B
    pop hl
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wD781]
    dec a
    dec a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_015_466B::
    pop hl
    ld a, [wPartyCount]
    cp a, $02
    jr nc, Jump_015_4696
    ld a, [hl]
    ld b, a
    ld a, [wPartyList]
    cp a, b
    jr nz, Jump_015_4696
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wD781]
    dec a
    dec a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_015_4696::
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld [wD7B4], a
    ld a, [wD7AB]
    ld [wD7B5], a
    ld a, [wD7AF]
    ld [wD7B6], a
    xor a, a
    ld [rRAMG2], a
    xor a, a
    ld [wD7AB], a
    ld [wD7AF], a
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 18 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wWindowTileBuffer, wD781
ScriptCommandED_Run_Case04_Case12::
Jump_015_46D3:: ; address name
    ld a, $B6
    ld [wWindowTileBuffer + $78], a
    ld [wWindowTileBuffer + $A0], a
    ld [wWindowTileBuffer + $C8], a
    ld de, Data_015_7541
    ld hl, wWindowTileBuffer + $94
    ld bc, $0C03
    call CopyRectTo20ByteRows_Bank15
    ld de, Data_015_7505
    ld hl, wWindowTileBuffer + $10C
    ld bc, $0C05
    call CopyRectTo20ByteRows_Bank15
    ld c, $05
    ld hl, Data_015_73A1
    call BlankWordTableTargets
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 19 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
ScriptCommandED_Run_Case04_Case13::
Jump_015_4712:: ; address name
    call ScriptCommandED_Run_Case04_Case13_Sub01
    ret

; entry 20 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
ScriptCommandED_Run_Case04_Case14::
Jump_015_4716:: ; address name
    call ClearThreeTileRows
    ld de, Data_015_7565
    ld hl, wWindowTileBuffer + $94
    ld bc, $0C03
    call CopyRectTo20ByteRows_Bank15
    ld de, Data_015_7589
    ld hl, wWindowTileBuffer + $10C
    ld bc, $0C05
    call CopyRectTo20ByteRows_Bank15
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 21 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
ScriptCommandED_Run_Case04_Case15::
Jump_015_4739:: ; address name
    ld hl, vTiles1 + $240
    ld bc, $0301
    call FillTilesBxC
    ld hl, vTiles1 + $700
    ld bc, $0501
    call FillTilesBxC
    ld hl, vTiles1 + $4E0
    ld bc, $1101
    call FillTilesBxC
    ld de, Data_015_747D
    ld hl, wWindowTileBuffer + $64
    ld bc, $080B
    call CopyRectTo20ByteRows_Bank15
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 22 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B0, wD781
; writes: wD7F1, wD7F2, wD781
ScriptCommandED_Run_Case04_Case16::
Jump_015_4768:: ; address name
    call LoadRecordWD7B4Byte0EBit0
    call ScriptCommandED_Run_Shared05
    jp Jump_015_4369

; for the record at WD789 cell 5 loads its family icon tile and draws its mark and level at wC426, then wD781 += 1 (E-0124)
; 2 call sites from 2 routines (e.g. ScriptCommandED_Run_Case04_Case29, ScriptCommandED_Run_Case04_Case24)
; reads: wD781
; writes: wD7F1, wD7F2, wD7F3, wD781
DrawWD789Cell5IconAndLevelAndStep::
Func_015_4771:: ; address name
    farcall SetWD7F5ToWD789Cell5
    ld a, [hl]
    ld b, a
    push af
    ld a, $FF
    ld [wD7F1], a
    call LoadFamilyIconTileForRecordB_Bank15
    pop af
    ld [wD7F1], a
    ld hl, wWindowTileBuffer + $126
    ld a, l
    ld [wD7F2], a
    ld a, h
    ld [wD7F3], a
    call DrawRecordField0EMarkAndField56Digits
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 25 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
ScriptCommandED_Run_Case04_Case19::
Jump_015_479C:: ; address name
    call ClearThreeTileRows
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; draws the name and species name of the record at WD789 cell 5, clears wCFA8 and wCFA9 and wD781 += 1 (E-0122)
; 3 call sites from 3 routines (e.g. ScriptCommandED_Run_Case04_Case29, ScriptCommandED_Run_Case04_Case24, ScriptCommandED_Run_Case12_Case04)
; reads: wD7F5, wD7F6, wD781
; writes: wD7F1, wCFA8, wCFA9, wD781
DrawWD789Cell5RecordNamesAndStep::
Func_015_47A7:: ; address name
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    ld [wD7F1], a
    farcall DrawRecordNameAndSpeciesName
    xor a, a
    ld [wCFA8], a
    ld [wCFA9], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 27 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wCFA8, wCFA9, wD781
ScriptCommandED_Run_Case04_Case1B::
Jump_015_47CF:: ; address name
    call ScriptCommandED_Run_Shared06
    xor a, a
    ld [wCFA8], a
    ld [wCFA9], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 28 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F7, wD7F6, wD781
; writes: wD7F1, wSpeciesIdLo, wD7F2, wSpeciesIdHi, wD7F3, wD7F4, wD7F5, wD781, ...
; points at: wMonsterLibraryBuf, wNameGlyphBuf
ScriptCommandED_Run_Case04_Case1C::
Jump_015_47E1:: ; address name
    xor a, a
    ld [wD7F1], a
    farcall ComputeBreedingChild
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    ld a, [wD7F7]
    cp a, $FF
    jr nz, Jump_015_47FF
    ld a, [wD7F6]
    cp a, $FF
    jr z, Jump_015_485A

Jump_015_47FF::
    ld a, [wD7F6]
    ld [wD7F1], a
    ld [wSpeciesIdLo], a
    ld a, [wD7F7]
    ld [wD7F2], a
    ld [wSpeciesIdHi], a
    ld de, Data_015_75C5
    ld a, e
    ld [wD7F3], a
    ld a, d
    ld [wD7F4], a
    call TestBitInFieldAtWD7F3
    ld a, [wD7F5]
    cp a, $FF
    jr z, Jump_015_487A
    ld a, [wD7F6]
    ld [wD7F1], a
    ld a, [wD7F7]
    ld [wD7F2], a
    ld hl, wMonsterLibraryBuf
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    call TestBitInFieldAtWD7F3
    cp a, $FF
    jr z, Jump_015_487A
    ld a, [wD7F6]
    ld [wSpeciesIdLo], a
    ld a, [wD7F7]
    ld [wSpeciesIdHi], a
    farcall TestSpeciesFlag
    ld a, c
    and a, a
    jr nz, Jump_015_487A

Jump_015_485A::
    ld c, $00
    ld hl, wNameGlyphBuf

Jump_015_485F::
    ld a, $98
    ld [hl+], a
    inc c
    ld a, c
    cp a, $09
    jr c, Jump_015_485F
    ld a, $F0
    ld [hl], a
    ld de, Data_01F_4990
    ld hl, vTiles1 + $490
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    jr Jump_015_4899

Jump_015_487A::
    ld a, [wD7F6]
    ld l, a
    ld a, [wD7F7]
    ld h, a
    call CopyMonsterNameToBuffer_B15
    ld hl, wChildRecord + $D
    ld a, [hl]
    and a, $0F
    ld [wD09D], a
    ld a, $C9
    ld [wD09E], a
    farcall LoadFamilyIconTileForWD09D

Jump_015_4899::
    ld c, $00
    ld a, $04
    ld [wD7F5], a
    farcall DrawWC8CFGlyphsOverlaying8DAnd8E_Bank1D
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 30 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wD781, wD7AB
; writes: wMenuInputResult, wD781, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
ScriptCommandED_Run_Case04_Case1E::
Jump_015_48AE:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_015_48D2
    cp a, $FC
    jr z, Jump_015_48D2
    cp a, $FD
    jr z, Jump_015_4911
    cp a, $FE
    jr z, Jump_015_48DB
    cp a, $FF
    jr z, Jump_015_48E3
    ret

Jump_015_48D2::
    ld a, [wD781]
    sub a, $09
    ld [wD781], a
    ret

Jump_015_48DB::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_48E3::
    ld a, [wD781]
    add a, $03
    ld [wD781], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_015_73A1
    call StoreBAtWordTableEntry_Bank15
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_015_4911::
    ld a, [wD781]
    sub a, $06
    ld [wD781], a
    ret

; entry 31 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wD7F1, wD7F2, wWindowTileBuffer, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
ScriptCommandED_Run_Case04_Case1F::
Jump_015_491A:: ; address name
    ld c, $03
    ld hl, $01FC
    ld de, $0030
    xor a, a
    ld [wD7F1], a
    ld a, $0C
    ld [wD7F2], a
    call ScriptCommandED_Run_Shared03
    ld a, $B7
    ld [wWindowTileBuffer + $93], a
    ld [wWindowTileBuffer + $A7], a
    call DrawGoldBoxAndStep_Bank15
    ld de, Data_015_74D5
    ld hl, wWindowTileBuffer + $BC
    ld bc, $0C01
    call CopyRectTo20ByteRows_Bank15
    ld de, Data_015_7511
    ld hl, wWindowTileBuffer + $120
    ld bc, $0C04
    call CopyRectTo20ByteRows_Bank15
    ld de, Data_015_4985
    ld hl, wWindowTileBuffer + $93
    ld bc, $0102
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Data_015_4985:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B7, $B7

; entry 32 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7B5, wD7B6
; writes: wD7F1, wD7F2, wD7F3, wD7F4, wD7AB, wD7AF, wTwoChoiceCursor, wD7AD, ...
ScriptCommandED_Run_Case04_Case20::
Jump_015_4987:: ; address name
    ld a, $9D
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    ld de, SRAMBank1RecordAddress
    ld a, d
    ld [wD7F3], a
    ld a, e
    ld [wD7F4], a
    farcall LoadTileListSixPerCall
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    ld a, [wD7B5]
    ld [wD7AB], a
    ld a, [wD7B6]
    ld [wD7AF], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld [wD7AD], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, $01
    ld [wD781], a
    ret

; entry 36 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wD781, wScriptCommandType, wScriptStartRequest
; points at: wTextWindowTileLo
ScriptCommandED_Run_Case04_Case24::
Jump_015_49C9:: ; address name
    ld de, Data_015_75F5
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    call ClearTileAreas2700_1750_17D0
    call DrawWD789Cell5RecordNamesAndStep
    ld de, Data_015_7589
    ld hl, wWindowTileBuffer + $10C
    ld bc, $0C05
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    call DrawWD789Cell5IconAndLevelAndStep
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, $25
    ld [wD781], a
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 37 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wD781, wScriptCommandType, wScriptStartRequest
ScriptCommandED_Run_Case04_Case25::
Jump_015_4A2A:: ; address name
    ld c, $05
    ld hl, Data_015_73A1
    call BlankWordTableTargets
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, $1E
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 38 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, hTemp0, wPartyCount, wD7B4, wPartyList, wD781
; writes: rRAMG2, rRAMB, wTwoChoiceCursor, wD781, wScriptCommandType, wScriptStartRequest
ScriptCommandED_Run_Case04_Case26::
Jump_015_4A4D:: ; address name
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $56
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG2], a
    ldh a, [hTemp0]
    cp a, $0A
    jr nc, Jump_015_4A88
    ld a, $03
    ld [wTwoChoiceCursor], a
    ld a, $24
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_015_4A88::
    ld a, [wPartyCount]
    cp a, $03
    jr z, Jump_015_4AED
    cp a, $01
    jr z, Jump_015_4AD6
    ld a, [wD7B4]
    ld b, a
    ld a, [wPartyList]
    cp a, b
    jr z, Jump_015_4AA5
    ld a, [wPartyList + $1]
    cp a, b
    jr z, Jump_015_4AA5
    jr Jump_015_4AED

Jump_015_4AA5::
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld b, [hl]
    ld a, [wPartyList]
    cp a, b
    jr z, Jump_015_4AC2
    ld a, [wPartyList + $1]
    cp a, b
    jr z, Jump_015_4AC2
    jr Jump_015_4AED

Jump_015_4AC2::
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, $24
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_015_4AD6::
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld b, [hl]
    ld a, [wPartyList]
    cp a, b
    jr nz, Jump_015_4AED
    jr Jump_015_4AC2

Jump_015_4AED::
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

; entry 39 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wDigits, wD781
; writes: wD7F1, wD7F2, wD7F3, wD7F4, wTwoChoiceCursor, wD781, wScriptCommandType, wScriptStartRequest, ...
; points at: wMonsterLibraryBuf, wNameGlyphBuf, wTextBuf0
ScriptCommandED_Run_Case04_Case27::
Jump_015_4B02:: ; address name
    ld hl, wChildRecord + $B
    ld a, [hl+]
    ld [wD7F1], a
    ld a, [hl]
    ld [wD7F2], a
    ld hl, wMonsterLibraryBuf
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    call TestBitInFieldAtWD7F3
    cp a, $FF
    jr nz, Jump_015_4B21
    jr Jump_015_4B55

Jump_015_4B21::
    ld hl, wChildRecord + $B
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall TestSpeciesFlag
    ld a, c
    and a, a
    jr z, Jump_015_4B38
    jr Jump_015_4B55

Jump_015_4B38::
    ld hl, wChildRecord + $B
    ld a, [hl+]
    ld [wD7F1], a
    ld a, [hl]
    ld [wD7F2], a
    ld hl, Data_015_75C5
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    call TestBitInFieldAtWD7F3
    cp a, $FF
    jr nz, Jump_015_4BA7

Jump_015_4B55::
    ld de, wChildRecord + $B
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call CopyMonsterNameToBuffer_B15
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0

Jump_015_4B66::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_015_4B70
    ld [de], a
    inc de
    inc hl
    jr Jump_015_4B66

Jump_015_4B70::
    ld a, $A2
    ld [de], a
    inc de
    ld hl, wChildRecord + $6D
    ld a, [hl]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigitsWC8C0_Bank15
    ld a, [wDigits + $1]
    cp a, $E3
    jr z, Jump_015_4B8A
    ld [de], a
    inc de

Jump_015_4B8A::
    ld a, [wDigits + $2]
    ld [de], a
    inc de
    ld a, $F0
    ld [de], a
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

Jump_015_4BA7::
    ld a, $01
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

; entry 40 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F1, wD7F2, wD7F3, wD7F4, wSpeciesIdLo, wSpeciesIdHi, wTwoChoiceCursor, wD781, ...
; points at: wMonsterLibraryBuf
ScriptCommandED_Run_Case04_Case28::
Jump_015_4BBE:: ; address name
    ld hl, wChildRecord + $B
    ld a, [hl+]
    ld [wD7F1], a
    ld a, [hl]
    ld [wD7F2], a
    ld de, wMonsterLibraryBuf
    ld a, e
    ld [wD7F3], a
    ld a, d
    ld [wD7F4], a
    call TestBitInFieldAtWD7F3
    cp a, $FF
    jr z, Jump_015_4BF7
    ld hl, wChildRecord + $B
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall TestSpeciesFlag
    ld a, c
    and a, a
    jr nz, Jump_015_4BF7
    ld a, $01
    ld [wTwoChoiceCursor], a
    jr Jump_015_4BFB

Jump_015_4BF7::
    xor a, a
    ld [wTwoChoiceCursor], a

Jump_015_4BFB::
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; if wC58A is set, copies and draws rectangle $70C5 at wC364; wD781 += 1 (E-0122)
; 1 call site from 1 routine (e.g. ScriptCommandED_Run_Case04_Case30)
; reads: wLinkMode, wD781
; writes: wD781
DrawRect70C5IfWC58AAndStep::
Func_015_4C0C:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr z, Jump_015_4C15
    call CopyRect70C5ToWC364AndDraw

Jump_015_4C15::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 43 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wD781
; writes: wD781
ScriptCommandED_Run_Case04_Case2B::
Jump_015_4C1D:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr z, Jump_015_4C26
    call ShowSaveFileInfoWindow

Jump_015_4C26::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 44 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD782, wTextFlags, wD781, wLinkMode
; writes: wD782, wD781, wScriptCommandType, wScriptStartRequest, wStringIndex
; points at: wTextWindowTileLo
ScriptCommandED_Run_Case04_Case2C::
Jump_015_4C2E:: ; address name
    call ScriptCommandED_Run_Shared02
    ld a, [wD782]
    cp a, $02
    jr z, Jump_015_4C4D
    cp a, $03
    jr z, Jump_015_4C66
    call DrawBottomBoxForLinkAndSetWD782
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ret

Jump_015_4C4D::
    ld a, [wLinkMode]
    and a, a
    jr z, Jump_015_4C5E
    ld a, $0D
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank1B_4C86

Jump_015_4C5E::
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_015_4C66::
    ld a, [wTextFlags]
    and a, a
    ret nz
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 41 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD782, wLinkMode
; writes: wD782, wD781, wTwoChoiceCursor
ScriptCommandED_Run_Case04_Case29::
Jump_015_4C80:: ; address name
    ld a, [wD782]
    and a, a
    jr nz, Jump_015_4C8A
    call PrepareWCF8BCountersAndRequestScript
    ret

Jump_015_4C8A::
    xor a, a
    ld [wD782], a
    ld a, [wLinkMode]
    and a, a
    jr z, Jump_015_4CD9
    ld de, Data_015_75F5
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    call ClearTileAreas2700_1750_17D0
    call DrawWD789Cell5RecordNamesAndStep
    ld de, Data_015_7589
    ld hl, wWindowTileBuffer + $10C
    ld bc, $0C05
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    call DrawWD789Cell5IconAndLevelAndStep
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15

Jump_015_4CD9::
    ld a, $2A
    ld [wD781], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ret

; entry 47 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wMenuInputResult, wTwoChoiceCursor, wD781
; writes: wD781, wD782, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
ScriptCommandED_Run_Case04_Case2F::
Jump_015_4CE3:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr z, Jump_015_4D1E
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    cp a, $FE
    jr z, Jump_015_4CFE
    cp a, $FF
    jr z, Jump_015_4D14
    call ScriptCommandED_Run_Shared02
    ret

Jump_015_4CFE::
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_015_4D14::
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, Jump_015_4CFE
    call ScriptCommandED_Run_Shared02

Jump_015_4D1E::
    ld a, [wD781]
    add a, $07
    ld [wD781], a
    xor a, a
    ld [wD782], a
    ret

; entry 48 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wOBJPaletteUploadRequest
ScriptCommandED_Run_Case04_Case30::
Jump_015_4D2B:: ; address name
    ld de, Data_015_761D
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank15
    call DrawRect70C5IfWC58AAndStep
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ret

; entry 50 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD781
; writes: wD7F1, wD7F2, wD7F3, wD7F4, wD781
ScriptCommandED_Run_Case04_Case32::
Jump_015_4D46:: ; address name
    ld a, $9D
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    ld de, SRAMBank1RecordAddress
    ld a, d
    ld [wD7F3], a
    ld a, e
    ld [wD7F4], a
    farcall LoadTileListSixPerCall
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 49 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F1, wD7F2, wD781
ScriptCommandED_Run_Case04_Case31::
Jump_015_4D6E:: ; address name
    ld c, $0D
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [wD7F1], a
    ld a, $14
    ld [wD7F2], a
    call ScriptCommandED_Run_Shared03
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 51 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
ScriptCommandED_Run_Case04_Case33::
Jump_015_4D96:: ; address name
    call DrawPair72A9And72C5AndStep
    call DrawGoldBoxAndStep_Bank15
    ld de, Data_015_6F6B
    ld hl, wWindowTileBuffer + $64
    ld bc, $0807
    call CopyRectTo20ByteRows_Bank15
    ld a, [wD781]
    dec a
    ld [wD781], a
    ret

; entry 52 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD786, wD781
; writes: wScriptCommandType, wScriptStartRequest, wD781
; points at: wTextWindowTileLo
ScriptCommandED_Run_Case04_Case34::
Jump_015_4DB0:: ; address name
    ld a, [wD786]
    ld hl, Data_015_732D
    ld b, $BC
    call StoreBAtWordTableEntry_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 58 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
ScriptCommandED_Run_Case04_Case3A::
Jump_015_4DE5:: ; address name
    call DrawPair72A9And72C5AndStep
    call DrawGoldBoxAndStep_Bank15
    ld a, [wD781]
    dec a
    ld [wD781], a
    ret

; entry 59 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wScriptCommandType, wScriptStartRequest, wD781
; points at: wTextWindowTileLo
ScriptCommandED_Run_Case04_Case3B::
Jump_015_4DF3:: ; address name
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 60 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: hTemp0, wScriptCommandType, wScriptStartRequest, wD781
; points at: wTextWindowTileLo
ScriptCommandED_Run_Case04_Case3C::
Jump_015_4E1D:: ; address name
    ld hl, wChildRecord + $6D
    ld a, [hl]
    ldh [hTemp0], a
    call TenTimesHFFC6PlusTenToDigits
    call ScriptCommandED_Run_Shared04
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 54 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD782, wTextFlags, wD781, wLinkMode, wSaveStep, wD7B4, wD7F5, wD7F6, ...
; writes: wD782, wD781, wStringIndex, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wD7F1, wD7F2, ...
; points at: wChildRecord, wMonsterLibraryBuf, wD7E0
ScriptCommandED_Run_Case04_Case36::
Jump_015_4E47:: ; address name
    ld a, [wD782]
    and a, a
    jr z, Jump_015_4EB1
    cp a, $01
    jr z, Jump_015_4E87
    cp a, $02
    jr z, Jump_015_4E6B
    ld a, [wTextFlags]
    and a, a
    jr z, Jump_015_4E5F
    call ScriptCommandED_Run_Shared02
    ret

Jump_015_4E5F::
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_4E6B::
    call ScriptCommandED_Run_Shared02
    ld a, [wLinkMode]
    and a, a
    jr z, Jump_015_4E7F
    ld a, $0E
    ld [wStringIndex], a
    farcall BeginStringDisplay_Bank1B_4C86

Jump_015_4E7F::
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_015_4E87::
    call ScriptCommandED_Run_Shared02
    ld a, [wLinkMode]
    and a, a
    jr z, Jump_015_4E9C
    farcall RunSaveGameSteps_7347
    ld a, [wSaveStep]
    bit 7, a
    ret z

Jump_015_4E9C::
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_015_4EB1::
    call ScriptCommandED_Run_Shared02
    ld a, [wD7B4]
    ld b, a
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld b, [hl]
    push bc
    ld a, b
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    farcall DeleteSRAMRecordAndCompact
    pop bc
    ld a, [wD7B4]
    cp a, b
    jr c, Jump_015_4EDE
    dec a

Jump_015_4EDE::
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    farcall DeleteSRAMRecordAndCompact
    ld a, [wD7F5]
    ld [wD7B4], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7F6]
    ld l, a
    ld a, [wD7F7]
    ld h, a
    ld de, wChildRecord
    ld b, $A5

Jump_015_4F07::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_015_4F07
    xor a, a
    ld [rRAMG2], a
    xor a, a
    ld [wSaveStep], a
    ld [wSaveRecordIndex], a
    ld hl, wChildRecord + $B
    ld a, [hl+]
    ld [wD7F1], a
    ld a, [hl]
    ld [wD7F2], a
    ld de, wMonsterLibraryBuf
    ld a, e
    ld [wD7F3], a
    ld a, d
    ld [wD7F4], a
    call SetBitInFieldAtWD7F3
    ld hl, wD7E0
    ld b, $07

Jump_015_4F36::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_015_4F36
    farcall SetSpeciesFlag
    call IncrementTwoCountersCappedAt99
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

; removes record B from the party list wC6FE (wC6FD -= 1), compacts the three entries and zeroes the unused ones (E-0127)
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount
; writes: wPartyCount
; points at: wPartyList
RemoveRecordBFromParty:: ; heuristic: follows a terminator; C0
Func_015_4F4C:: ; address name
    ld hl, wPartyList
    ld c, $00

Jump_015_4F51::
    ld a, [hl]
    cp a, b
    jr nz, Jump_015_4F61
    ld a, $FF
    ld [hl], a
    ld a, [wPartyCount]
    dec a
    ld [wPartyCount], a
    jr Jump_015_4F69

Jump_015_4F61::
    inc hl
    inc c
    ld a, [wPartyCount]
    cp a, c
    jr nz, Jump_015_4F51

Jump_015_4F69::
    ld hl, wPartyList
    ld de, wPartyList
    ld c, $00

Jump_015_4F71::
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_015_4F78
    jr Jump_015_4F7A

Jump_015_4F78::
    ld [de], a
    inc de

Jump_015_4F7A::
    inc hl
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_015_4F71
    ld hl, wPartyList
    ld c, $00

Jump_015_4F86::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_015_4F90
    cp a, b
    jr z, Jump_015_4F90
    jr Jump_015_4F92

Jump_015_4F90::
    xor a, a
    ld [hl], a

Jump_015_4F92::
    inc hl
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_015_4F86
    ret

; entry 63 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wD7F1, wD781
; writes: hTemp0, wD7F3, wD7F2, wD7F1, wTwoChoiceCursor, wD781, wScriptCommandType, wScriptStartRequest, ...
ScriptCommandED_Run_Case04_Case3F::
Jump_015_4F9A:: ; address name
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_015_4FAE
    cp a, $FF
    jr z, Jump_015_4FC4
    ret

Jump_015_4FAE::
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_015_4FC4::
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, Jump_015_4FAE
    ld hl, wChildRecord + $6D
    ld a, [hl]
    ldh [hTemp0], a
    call TenTimesHFFC6PlusTen
    xor a, a
    ld [wD7F3], a
    ld a, h
    ld [wD7F2], a
    ld a, l
    ld [wD7F1], a
    farcall IsAmountInWD7F1AboveGold
    ld a, [wD7F1]
    cp a, $FF
    jr nz, Jump_015_5003
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_015_5003::
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    inc a
    ld [wD781], a
    xor a, a
    ld [wD782], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 64 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wD781, wD780, wScriptCommandType, wScriptStartRequest
ScriptCommandED_Run_Case04_Case40::
Jump_015_501D:: ; address name
    xor a, a
    ld [wD781], a
    ld a, $0A
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 65 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B4, wD7AB, wD7A9, wD7F5, wD7F6
; writes: hTemp0, wD7F3, wD7F2, wD7F1, wD7AB, wD7AF, wD7B1, wD7B0, ...
; points at: wD7BE, wD789
ScriptCommandED_Run_Case04_Case41::
Jump_015_5030:: ; address name
    ld hl, wChildRecord + $6D
    ld a, [hl]
    ldh [hTemp0], a
    call TenTimesHFFC6PlusTen
    xor a, a
    ld [wD7F3], a
    ld a, h
    ld [wD7F2], a
    ld a, l
    ld [wD7F1], a
    call SubtractWD7F1AmountFromGold
    ld hl, wD7BE
    ld c, $00

Jump_015_504D::
    xor a, a
    ld [hl+], a
    inc c
    ld a, c
    cp a, $1E
    jr c, Jump_015_504D
    farcall ListRecordsInUseWithByte6ESet
    xor a, a
    ld [wD7AB], a
    ld [wD7AF], a
    ld [wD7B1], a
    ld [wD7B0], a
    ld hl, wD789
    ld a, [wD7B4]
    ld b, a
    ld c, $00

Jump_015_5071::
    ld a, [hl]
    cp a, b
    jr z, Jump_015_5084
    inc c
    inc hl
    ld a, [wD7AB]
    inc a
    ld [wD7AB], a
    ld a, [wD7A9]
    cp a, c
    jr nz, Jump_015_5071

Jump_015_5084::
    ld a, [wD7AB]
    srl a
    srl a
    ld [wD7AF], a
    ld a, [wD7AB]

Jump_015_5091::
    cp a, $04
    jr c, Jump_015_5099
    sub a, $04
    jr Jump_015_5091

Jump_015_5099::
    ld [wD7AB], a
    farcall SetWD7F5ToWD789Cell4
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $6E
    call SRAMRecordAddress
    xor a, a
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    ld [wD781], a
    ld a, $08
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 5 of the `rst $00` table in ScriptCommandED_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandED_Run_Case05::
Jump_015_50D1:: ; address name
    ld a, [wD781]
    rst $00
    dw ScriptCommandED_Run_Case05_Case00
    dw ScriptCommandED_Run_Case05_Case01
    dw ClearTileRowsAndResetWindowAndStep
    dw ScriptCommandED_Run_Case05_Case03
    dw ScriptCommandED_Run_Case05_Case04
    dw ScriptCommandED_Run_Case05_Case05
    dw ScriptCommandED_Run_Case05_Case06
    dw ScriptCommandED_Run_Case05_Case07
    dw ScriptCommandED_Run_Case05_Case08
    dw ScriptCommandED_Run_Case04_Case0B
    dw ScriptCommandED_Run_Case05_Case0A
    dw ScriptCommandED_Run_Case05_Case0B
    dw ScriptCommandED_Run_Case04_Case0E
    dw ScriptCommandED_Run_Case05_Case0D
    dw ScriptCommandED_Run_Case05_Case0E
    dw ScriptCommandED_Run_Case05_Case0F
    dw ScriptCommandED_Run_Case05_Case10

; entry 0 of the `rst $00` table in ScriptCommandED_Run_Case05
; no direct call (reached through a table, a jump or a vector)
ScriptCommandED_Run_Case05_Case00::
Jump_015_50F7:: ; address name
    call ScriptCommandED_Run_Case05_Case00_Sub01
    ret

; entry 1 of the `rst $00` table in ScriptCommandED_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wD786, wD781
; writes: wD781
ScriptCommandED_Run_Case05_Case01::
Jump_015_50FB:: ; address name
    ld de, Data_015_6FDB
    ld hl, wWindowTileBuffer + $BB
    ld bc, $0D09
    call CopyRectTo20ByteRows_Bank15
    ld a, [wD786]
    ld hl, Data_015_732D
    ld b, $BC
    call StoreBAtWordTableEntry_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    farcall ListRecordsInUseWithByte6ESet
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; clears four tile rows, sets the default window ($8800, $1202) and wD781 += 1 (E-0124)
; 1 call site from 1 routine (e.g. ScriptCommandED_Run_Case0F_Case02)
; reads: wD781
; writes: wD781
; points at: wTextWindowTileLo
ClearTileRowsAndResetWindowAndStep::
Func_015_512C:: ; address name
    ld hl, vTiles1 + $400
    ld bc, $0301
    call FillTilesBxC
    ld hl, vTiles1 + $470
    ld bc, $0501
    call FillTilesBxC
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call FillTilesBxC
    ld hl, vTiles1 + $700
    ld bc, $0D01
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 3 of the `rst $00` table in ScriptCommandED_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B0, wD7AB, wD781
; writes: wD7F1, wD7F2, wD781
ScriptCommandED_Run_Case05_Case03::
Jump_015_5165:: ; address name
    ld de, Data_015_7050
    ld hl, wWindowTileBuffer + $BB
    ld bc, $0D09
    call CopyRectTo20ByteRows_Bank15
    farcall ClampRecordListPageCursor4
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_015_51AC
    ld de, $018E
    call DrawC5BEC6AtScrollOffsetDE_Bank15
    ld hl, wWindowTileBuffer + $162
    call StoreC5BEC6AtHLStride2_Bank15
    ld de, $018F
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    farcall DrawPageOfPagesAtScrollOffset
    ld hl, wWindowTileBuffer + $163
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    farcall DrawPageOfPagesAtWD7F1_Bank1E

Jump_015_51AC::
    ld a, [wD7AB]
    ld b, $BB
    ld hl, Data_015_7333
    call StoreBAtWordTableEntry_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, [wD7AB]
    ld b, $C3
    ld hl, Data_015_7333
    call StoreBAtWordTableEntry_Bank15
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 4 of the `rst $00` table in ScriptCommandED_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F5, wD781
ScriptCommandED_Run_Case05_Case04::
Jump_015_51D6:: ; address name
    ld a, $01
    ld [wD7F5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 5 of the `rst $00` table in ScriptCommandED_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F1, wD7F2, wD781
ScriptCommandED_Run_Case05_Case05::
Jump_015_51E9:: ; address name
    ld de, Data_01F_4990
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    xor a, a
    ld [wD7F1], a
    ld a, $01
    ld [wD7F2], a
    farcall DrawRecordListPageMarks
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 6 of the `rst $00` table in ScriptCommandED_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wD781, wD7AB, wD7F5, wD7F6
; writes: wMenuInputResult, wTwoChoiceCursor, wD781, rRAMG2, rRAMB, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, ...
ScriptCommandED_Run_Case05_Case06::
Jump_015_520D:: ; address name
    ld a, $02
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_015_5232
    cp a, $FC
    jr z, Jump_015_5232
    cp a, $FD
    jr z, Jump_015_523B
    cp a, $FE
    jr z, Jump_015_523C
    cp a, $FF
    jr z, Jump_015_525F
    ret

Jump_015_5232::
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

Jump_015_523B::
    ret

Jump_015_523C::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $01
    ld [wTwoChoiceCursor], a
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

Jump_015_525F::
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    add a, $04
    ld [wD781], a
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_015_7333
    call StoreBAtWordTableEntry_Bank15
    farcall SetWD7F5ToWD789Cell4
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $6D
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG2], a
    call TenTimesHFFC6PlusTenToDigits
    call ScriptCommandED_Run_Shared04
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
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 7 of the `rst $00` table in ScriptCommandED_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wThreeOptionResult, wD781
; writes: wD7F1, wD7F2, wD781
ScriptCommandED_Run_Case05_Case07::
Jump_015_52BD:: ; address name
    ld c, $09
    ld hl, $0223
    ld de, $0057
    xor a, a
    ld [wD7F1], a
    ld a, $0D
    ld [wD7F2], a
    call ScriptCommandED_Run_Shared03
    ld a, [wThreeOptionResult]
    or a, a
    jr z, Jump_015_52EB
    ld de, Data_015_7345
    ld hl, wWindowTileBuffer + $BB
    ld bc, $0403
    call CopyRectTo20ByteRows_Bank15
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Jump_015_52EB::
    ld de, Data_015_733F
    ld hl, wWindowTileBuffer + $BA
    ld bc, $0203
    call CopyRectTo20ByteRows_Bank15
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 8 of the `rst $00` table in ScriptCommandED_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wD782, wD781, wD7F5
; writes: wD781, wD782, wD7F1, wD7F2, wD7F3, wD7F4, wScriptCommandType, wScriptStartRequest
ScriptCommandED_Run_Case05_Case08::
Jump_015_52FF:: ; address name
    ld a, [wD782]
    and a, a
    jr nz, Jump_015_5323
    call DrawGoldBoxAndStep_Bank15
    ld a, [wD781]
    dec a
    ld [wD781], a
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, [wD782]
    inc a
    ld [wD782], a
    ret

Jump_015_5323::
    ld a, $9C
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    ld de, SRAMBank1RecordAddress
    ld a, d
    ld [wD7F3], a
    ld a, e
    ld [wD7F4], a
    farcall LoadTileListSixPerCall
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    xor a, a
    ld [wD782], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 11 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wD781, wD782, wD780, wScriptCommandType, wScriptStartRequest
ScriptCommandED_Run_Case04_Case0B::
Jump_015_5358:: ; address name
    ld c, $03
    ld hl, Data_015_732D
    call BlankWordTableTargets
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 10 of the `rst $00` table in ScriptCommandED_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
ScriptCommandED_Run_Case05_Case0A::
Jump_015_5376:: ; address name
    ld hl, Data_015_72E1
    ld de, Data_015_72F1
    call CopyGlyphTileListFromBank1F_Bank15
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 11 of the `rst $00` table in ScriptCommandED_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7B7, wD7AD, wD781
ScriptCommandED_Run_Case05_Case0B::
Jump_015_5387:: ; address name
    ld a, $6C
    call QueueSoundEffect
    ld de, Data_015_7351
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    xor a, a
    ld [wD7B7], a
    ld [wD7AD], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 14 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wD781, wD7AD, wD780
; writes: wTwoChoiceCursor, wD781, wScriptCommandType, wScriptStartRequest, wD7B2, wD7B3, wD780, wD782, ...
ScriptCommandED_Run_Case04_Case0E::
Jump_015_53B3:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_015_53CF
    bit 7, a
    jr nz, Jump_015_53E9
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_015_53F9
    bit 1, a
    jp nz, Jump_015_5488
    call BlinkCursorWD7AE_Bank15
    ret

Jump_015_53CF::
    call DrawBlankTileC3_Bank15
    ld a, [wD7AD]
    and a, a
    jr nz, Jump_015_53DC
    ld a, $01
    jr Jump_015_53DD

Jump_015_53DC::
    dec a

Jump_015_53DD::
    ld [wD7AD], a
    call BlinkCursorWD7AE_Bank15
    ld a, $69
    call QueueSoundEffect
    ret

Jump_015_53E9::
    call DrawBlankTileC3_Bank15
    ld a, [wD7AD]
    cp a, $01
    jr c, Jump_015_53F6
    xor a, a
    jr Jump_015_53DD

Jump_015_53F6::
    inc a
    jr Jump_015_53DD

Jump_015_53F9::
    ld a, $69
    call QueueSoundEffect
    call ScriptCommandED_Run_Case04_Case0E_Sub01
    ld a, [wD7AD]
    and a, a
    jp nz, Jump_015_5471
    ld a, [wD780]
    cp a, $04
    jr z, Jump_015_5415
    cp a, $05
    jr z, Jump_015_5438
    jr Jump_015_5446

Jump_015_5415::
    ld a, [wD781]
    cp a, $22
    jr c, Jump_015_542A
    ld a, $04
    ld [wD7B2], a
    ld a, $23
    ld [wD7B3], a
    ld a, $0C
    jr Jump_015_5454

Jump_015_542A::
    ld a, $04
    ld [wD7B2], a
    ld a, $0E
    ld [wD7B3], a
    ld a, $0C
    jr Jump_015_5454

Jump_015_5438::
    ld a, $05
    ld [wD7B2], a
    ld a, $0C
    ld [wD7B3], a
    ld a, $0D
    jr Jump_015_5454

Jump_015_5446::
    ld a, $07
    ld [wD7B2], a
    ld a, $18
    ld [wD7B3], a
    ld a, $0E
    jr Jump_015_5454

Jump_015_5454::
    ld [wD780], a
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld [wTwoChoiceCursor], a
    farcall SaveAndHideSpriteState_Bank1E
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_015_5471::
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    add a, $03
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_015_5488::
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; once the joypad repeat timer reaches $14, cycles wD7AE through 0-$17 and draws the cursor tile ($BB) or a blank ($C3) (E-0122)
; 2 call sites from 1 routine (e.g. ScriptCommandED_Run_Case04_Case0E)
; reads: wJoypadRepeatTimer, wD7AE, wD7AD
; writes: wD7AE
BlinkCursorWD7AE_Bank15::
Func_015_549E:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, Jump_015_54B8
    ld a, [wD7AE]
    inc a
    ld [wD7AE], a
    cp a, $10
    jr c, Jump_015_54B8
    cp a, $18
    jr c, DrawBlankTileC3_Bank15
    xor a, a
    ld [wD7AE], a

Jump_015_54B8::
    ld b, $BB
    jr Jump_015_54C2

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. ScriptCommandED_Run_Case04_Case0E)
; reads: wD7AD
DrawBlankTileC3_Bank15::
Func_015_54BC:: ; address name
    ld b, $C3
    jr Jump_015_54C2

; only called from ScriptCommandED_Run_Case04_Case0E (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandED_Run_Case04_Case0E)
; reads: wD7AD
ScriptCommandED_Run_Case04_Case0E_Sub01::
Func_015_54C0:: ; address name
    ld b, $BC

Jump_015_54C2::
    ld a, [wD7AD]
    add a, a
    ld hl, Data_015_54E2
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank15
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_015_54E2:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2D, $01, $6D, $01

; entry 14 of the `rst $00` table in ScriptCommandED_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; writes: wD781, wScriptCommandType, wScriptStartRequest
ScriptCommandED_Run_Case05_Case0E::
Jump_015_54E6:: ; address name
    call LoadTile4990AndRun6320
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, $06
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 15 of the `rst $00` table in ScriptCommandED_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, wD7F1, wD781
; writes: rRAMG2, rRAMB, wD7F3, wD7F2, wD7F1, wTwoChoiceCursor, wD781, wScriptCommandType, ...
ScriptCommandED_Run_Case05_Case0F::
Jump_015_5504:: ; address name
    farcall SetWD7F5ToWD789Cell4
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $6D
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG2], a
    call TenTimesHFFC6PlusTen
    xor a, a
    ld [wD7F3], a
    ld a, h
    ld [wD7F2], a
    ld a, l
    ld [wD7F1], a
    farcall IsAmountInWD7F1AboveGold
    ld a, [wD7F1]
    cp a, $FF
    jr nz, Jump_015_5555
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $07
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_015_5555::
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

; entry 16 of the `rst $00` table in ScriptCommandED_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6
; writes: rRAMG2, rRAMB, wD7F3, wD7F2, wD7F1, wD781, wD780, wScriptCommandType, ...
; points at: sA000, wD7BE
ScriptCommandED_Run_Case05_Case10::
Jump_015_556A:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    farcall SetWD7F5ToWD789Cell4
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    push hl
    ld a, [hl]
    ld c, $A5
    call Multiply8
    ld de, sA000
    add hl, de
    ld a, $6E
    add_a_to_hl
    xor a, a
    ld [hl], a
    pop hl
    ld a, [hl]
    ld c, $6D
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG2], a
    call TenTimesHFFC6PlusTen
    xor a, a
    ld [wD7F3], a
    ld a, h
    ld [wD7F2], a
    ld a, l
    ld [wD7F1], a
    call SubtractWD7F1AmountFromGold
    ld hl, wD7BE
    ld c, $00

Jump_015_55B7::
    xor a, a
    ld [hl+], a
    inc c
    ld a, c
    cp a, $1E
    jr c, Jump_015_55B7
    xor a, a
    ld [wD781], a
    ld a, $09
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 6 of the `rst $00` table in ScriptCommandED_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, hTemp0, hTemp1, wD7B4, wD7F7, wD780
; writes: rRAMG2, rRAMB, wD7F2, wD7F3, wD7F4, wD7F5, wD7B4, wD7F1, ...
; points at: wNameGlyphBuf, sA000, wRecordBufA
ScriptCommandED_Run_Case06::
Jump_015_55D2:: ; address name
    farcall SetWD7F5ToWD789Cell4
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    push hl
    ld a, [hl]
    ld c, $0E
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $01
    ld [wD7F2], a
    pop hl
    push hl
    ld a, [hl]
    ld c, $0D
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $1F
    ld [wD7F3], a
    pop hl
    push hl
    ld a, [hl]
    ld c, $0B
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld [wD7F4], a
    ldh a, [hTemp1]
    ld [wD7F5], a
    pop hl
    ld a, [hl]
    ld [wD7B4], a
    ld a, $01
    ld [wD7F1], a
    xor a, a
    ld [rRAMG2], a
    farcall RunWCFA8StateWhenNotFading
    ld a, [wD7F5]
    cp a, $FF
    ret nz
    ld a, [wD7B4]
    ld c, $01
    call SRAMRecordAddress
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld c, $0A
    ld de, wNameGlyphBuf

Jump_015_5648::
    ld a, [de]
    cp a, $F0
    jr z, Jump_015_5654
    ld [hl+], a
    inc de
    dec c
    jr nz, Jump_015_5648
    jr Jump_015_5657

Jump_015_5654::
    ld a, $F0
    ld [hl], a

Jump_015_5657::
    ld a, [wD7B4]
    ld c, $A5
    call Multiply8
    ld de, sA000
    add hl, de
    ld de, wRecordBufA
    ld b, $A5

Jump_015_5668::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_015_5668
    xor a, a
    ld [rRAMG2], a
    ld a, [wD7B4]
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    farcall DeleteSRAMRecordAndCompact
    ld a, [wD7F5]
    ld [wD7B4], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7F6]
    ld l, a
    ld a, [wD7F7]
    ld h, a
    ld de, wRecordBufA
    ld b, $A5

Jump_015_569E::
    ld a, [de]
    ld [hl+], a
    inc de
    dec b
    jr nz, Jump_015_569E
    xor a, a
    ld [rRAMG2], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    ret

; entry 7 of the `rst $00` table in ScriptCommandED_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandED_Run_Case07::
Jump_015_56B0:: ; address name
    ld a, [wD781]
    rst $00
    dw ScriptCommandED_Run_Case07_Case00
    dw DrawPair72A9And72C5AndStep_570C
    dw ScriptCommandED_Run_Case07_Case02
    dw ScriptCommandED_Run_Case07_Case03
    dw ScriptCommandED_Run_Case07_Case04
    dw ScriptCommandED_Run_Case04_Case3E
    dw ScriptCommandED_Run_Case07_Case06
    dw DrawGoldBoxAndStep_Bank15
    dw ScriptCommandED_Run_Case07_Case08
    dw ScriptCommandED_Run_Case07_Case09
    dw ScriptCommandED_Run_Case07_Case0A
    dw ScriptCommandED_Run_Case07_Case0B
    dw ScriptCommandED_Run_Case07_Case0C
    dw ScriptCommandED_Run_Case07_Case0D
    dw ScriptCommandED_Run_Case07_Case0E
    dw ScriptCommandED_Run_Case07_Case0F
    dw ScriptCommandED_Run_Case07_Case10
    dw ScriptCommandED_Run_Case07_Case11
    dw ScriptCommandED_Run_Case07_Case12
    dw ScriptCommandED_Run_Case07_Case13
    dw ScriptCommandED_Run_Case07_Case14
    dw ScriptCommandED_Run_Case07_Case15
    dw ScriptCommandED_Run_Case05_Case0A
    dw ScriptCommandED_Run_Case05_Case0B
    dw ScriptCommandED_Run_Case04_Case0E
    dw ScriptCommandED_Run_Case07_Case19
    dw ScriptCommandED_Run_Case07_Case1A
    dw ScriptCommandED_Run_Case07_Case1B
    dw ScriptCommandED_Run_Case07_Case1C
    dw ScriptCommandED_Run_Case07_Case1D
    dw ScriptCommandED_Run_Case07_Case1E
    dw ScriptCommandED_Run_Case07_Case1F
    dw ScriptCommandED_Run_Case04_Case0B

; entry 0 of the `rst $00` table in ScriptCommandED_Run_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
ScriptCommandED_Run_Case07_Case00::
Jump_015_56F6:: ; address name
    ld b, $46
    ld de, Data_046_4001
    ld hl, vTiles1
    call DecompressToVRAM
    ld a, [wD781]
    inc a
    ld [wD781], a
    call RestorePlayerPositionState
    ret

; runs Func_015_6374 for Data_015_72A9 and Data_015_72C5, then wD781 += 1 (E-0122)
; 2 call sites from 2 routines (e.g. ScriptCommandED_Run_Case07_Case1F, ScriptCommandED_Run_Case07_Case15)
; reads: wD781
; writes: wD781
DrawPair72A9And72C5AndStep_570C::
Func_015_570C:: ; address name
    ld hl, Data_015_72A9
    ld de, Data_015_72C5
    call CopyGlyphTileListFromBank1F_Bank15
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 2 of the `rst $00` table in ScriptCommandED_Run_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: hMapId, hFieldDrawFlags, wOBJPaletteUploadRequest, wD781
ScriptCommandED_Run_Case07_Case02::
Jump_015_571D:: ; address name
    ld a, $0D
    ldh [hMapId], a
    call LoadMapHeader
    call LoadMapScreen
    farcall LoadPlayerAndFollowerSpriteGraphics
    farcall LoadMapObjectsForScreen
    call RestorePlayerPositionState
    xor a, a
    ldh [hFieldDrawFlags], a
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 3 of the `rst $00` table in ScriptCommandED_Run_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wD781
; writes: hSpriteHideTile, wD781
; points at: wScreenTileBuffer, wWindowTileBuffer, wD1CC, wD000, wD168, wD104
ScriptCommandED_Run_Case07_Case03::
Jump_015_5746:: ; address name
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank15
    ld hl, wWindowTileBuffer
    ld de, wScreenTileBuffer + $104
    ld bc, $0064
    call CopyBytesDEToHL_Bank15
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_015_577C
    ld hl, wD1CC
    ld de, wD000
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank15
    ld hl, wD168
    ld de, wD104
    ld bc, $0064
    call CopyLow3BitsToWRAMBank2_Bank15

Jump_015_577C::
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    call BGMapAddressAtScroll_Bank15
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRect_Bank15
    ld a, $70
    ldh [hSpriteHideTile], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 4 of the `rst $00` table in ScriptCommandED_Run_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781, wScriptCommandType, wScriptStartRequest
; points at: wNameGlyphBuf, wTextBuf0
ScriptCommandED_Run_Case07_Case04::
Jump_015_57A4:: ; address name
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
    ld c, $0A

Jump_015_57AC::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_015_57B7
    ld [de], a
    inc hl
    inc de
    dec c
    jr nz, Jump_015_57AC

Jump_015_57B7::
    ld a, $F0
    ld [de], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 62 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781, wTwoChoiceCursor
ScriptCommandED_Run_Case04_Case3E::
Jump_015_57CB:: ; address name
    ld de, Data_01F_4180
    ld hl, vTiles2 + $770
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4330
    ld hl, vTiles2 + $730
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    call ScriptCommandED_Run_Shared02
    ld a, $6C
    call QueueSoundEffect
    ld de, Data_015_73AB
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ret

; entry 46 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wD781
; writes: wD781, wTwoChoiceCursor
ScriptCommandED_Run_Case04_Case2E::
Jump_015_5811:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr nz, ScriptCommandED_Run_Case04_Case3E
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ret

; entry 6 of the `rst $00` table in ScriptCommandED_Run_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wTwoChoiceCursor, wD781
; writes: wD781, wD782, wScriptCommandType, wScriptStartRequest, wTwoChoiceCursor
ScriptCommandED_Run_Case07_Case06::
Jump_015_5823:: ; address name
    farcall UpdateTwoChoiceCursor_Bank1D
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FE
    jr z, Jump_015_5837
    cp a, $FF
    jr z, Jump_015_5850
    ret

Jump_015_5837::
    call ScriptCommandED_Run_Shared01
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_015_5850::
    ld a, [wTwoChoiceCursor]
    cp a, $01
    jr z, Jump_015_5837
    ld a, [wD781]
    add a, $04
    ld [wD781], a
    xor a, a
    ld [wD782], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from routines of ScriptCommandED_Run (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommandED_Run_Case07_Case0A, ScriptCommandED_Run_Case07_Case06)
; reads: wIsCGB
; points at: wD27A, wD0AE
ScriptCommandED_Run_Shared01::
Func_015_586D:: ; address name
    ld hl, wWindowTileBuffer + $112
    ld de, wScreenTileBuffer + $AE
    ld c, $05
    call ScriptCommandED_Run_Shared01_Sub01
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_015_5889
    ld hl, wD27A
    ld de, wD0AE
    ld c, $05
    call ScriptCommandED_Run_Shared01_Sub02

Jump_015_5889::
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ret

; only called from ScriptCommandED_Run_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandED_Run_Shared01)
ScriptCommandED_Run_Shared01_Sub01::
Func_015_5896:: ; address name
    push hl
    push de
    push bc
    ld bc, $0006
    call CopyBytesDEToHL_Bank15
    pop bc
    pop de
    pop hl
    ld a, $14
    add_a_to_hl
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_015_58B0
    inc d

Jump_015_58B0::
    dec c
    jr nz, ScriptCommandED_Run_Shared01_Sub01
    ret

; only called from ScriptCommandED_Run_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandED_Run_Shared01)
ScriptCommandED_Run_Shared01_Sub02::
Func_015_58B4:: ; address name
    push hl
    push de
    push bc
    ld bc, $0006
    call CopyLow3BitsToWRAMBank2_Bank15
    pop bc
    pop de
    pop hl
    ld a, $14
    add_a_to_hl
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_015_58CE
    inc d

Jump_015_58CE::
    dec c
    jr nz, ScriptCommandED_Run_Shared01_Sub02
    ret

; entry 8 of the `rst $00` table in ScriptCommandED_Run_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wD786, wD781
; writes: wD781, wScriptCommandType, wScriptStartRequest
ScriptCommandED_Run_Case07_Case08::
Jump_015_58D2:: ; address name
    ld de, Data_01F_43C0
    ld hl, vTiles1 + $2D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_42D0
    ld hl, vTiles1 + $2E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_015_6F6B
    ld hl, wWindowTileBuffer + $64
    ld bc, $0807
    call CopyRectTo20ByteRows_Bank15
    ld a, [wD786]
    ld hl, Data_015_732D
    ld b, $BC
    call StoreBAtWordTableEntry_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 9 of the `rst $00` table in ScriptCommandED_Run_Case07
; no direct call (reached through a table, a jump or a vector)
; writes: wD781, wD782, wD780, wScriptCommandType, wScriptStartRequest
ScriptCommandED_Run_Case07_Case09::
Jump_015_5920:: ; address name
    ld c, $03
    ld hl, Data_015_732D
    call BlankWordTableTargets
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $02
    ld [wD780], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 10 of the `rst $00` table in ScriptCommandED_Run_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount, wD7B4, wD781, wTwoChoiceCursor
; writes: wPartyCount, rRAMG2, rRAMB, wOBJPaletteUploadRequest, wTwoChoiceCursor, wD781, wScriptCommandType, wScriptStartRequest
; points at: wPartyList
ScriptCommandED_Run_Case07_Case0A::
Jump_015_593E:: ; address name
    ld a, [wPartyCount]
    cp a, $03
    jr nc, Jump_015_5998
    ld hl, wPartyList
    ld a, [wPartyCount]
    add_a_to_hl
    ld a, [wD7B4]
    ld [hl], a
    ld a, [wPartyCount]
    inc a
    ld [wPartyCount], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7B4]
    ld c, $00
    call SRAMRecordAddress
    ld a, $02
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wD781]
    sub a, $03
    ld [wD781], a
    call ScriptCommandED_Run_Shared01
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_015_5998::
    ld a, [wTwoChoiceCursor]
    ld b, $BC
    ld hl, Data_015_733B
    call StoreBAtWordTableEntry_Bank15
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

; entry 11 of the `rst $00` table in ScriptCommandED_Run_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7AF, wD7AB, wD7AE, wD781
ScriptCommandED_Run_Case07_Case0B::
Jump_015_59B8:: ; address name
    ld de, Data_015_59E5
    ld hl, wWindowTileBuffer + $64
    ld bc, $0809
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    call ScriptCommandED_Run_Case07_Case0B_Sub01
    xor a, a
    ld [wD7AF], a
    ld [wD7AB], a
    ld [wD7AE], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Data_015_59E5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0559E5, $48

; only called from ScriptCommandED_Run_Case07_Case0B (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandED_Run_Case07_Case0B)
ScriptCommandED_Run_Case07_Case0B_Sub01::
Func_015_5A2D:: ; address name
    ld c, $10

Jump_015_5A2F::
    push bc
    ld a, c
    ld de, Data_015_5A67
    add a, e
    ld e, a
    jr nc, Jump_015_5A39
    inc d

Jump_015_5A39::
    ld a, [de]
    swap a
    ld d, a
    and a, $F0
    ld e, a
    ld a, d
    and a, $0F
    ld d, a
    ld hl, $4010
    add hl, de
    ld e, l
    ld d, h
    push de
    ld a, c
    add a, a
    ld de, Data_015_5A77
    add a, e
    ld e, a
    jr nc, Jump_015_5A55
    inc d

Jump_015_5A55::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    pop de
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop bc
    dec c
    jr nz, Jump_015_5A2F
    ret

Data_015_5A67:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A3, $50, $44, $11, $16, $19, $48, $24, $A6, $12, $31, $29, $32, $18, $14, $25

Data_015_5A77:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $8E, $E0, $8E, $F0, $8E, $50, $8F, $60, $8F, $70, $8F, $D0, $8F, $E0, $8F
    db $F0, $8F, $00, $97, $10, $97, $20, $97, $30, $97, $40, $97, $50, $97, $60, $97

; entry 12 of the `rst $00` table in ScriptCommandED_Run_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
; points at: wTextWindowTileLo
ScriptCommandED_Run_Case07_Case0C::
Jump_015_5A97:: ; address name
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call FillTilesBxC
    ld hl, vTiles1 + $700
    ld bc, $0501
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld de, Data_015_73C9
    ld hl, wWindowTileBuffer + $64
    ld bc, $0809
    call CopyRectTo20ByteRows_Bank15
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 13 of the `rst $00` table in ScriptCommandED_Run_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyList, wD7B4, wD781
; writes: wD789, wD78A, wD78B, wD78C, wD7A9, wD781
ScriptCommandED_Run_Case07_Case0D::
Jump_015_5ACA:: ; address name
    ld a, [wPartyList]
    ld [wD789], a
    ld a, [wPartyList + $1]
    ld [wD78A], a
    ld a, [wPartyList + $2]
    ld [wD78B], a
    ld a, [wD7B4]
    ld [wD78C], a
    ld a, $04
    ld [wD7A9], a
    farcall ClampRecordListPageCursor5
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 14 of the `rst $00` table in ScriptCommandED_Run_Case07
; no direct call (reached through a table, a jump or a vector)
ScriptCommandED_Run_Case07_Case0E::
Jump_015_5AF5:: ; address name
    farcall DrawRecordListPageNames
    ret

; entry 15 of the `rst $00` table in ScriptCommandED_Run_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, wD781
; writes: wD7F1, wD781
ScriptCommandED_Run_Case07_Case0F::
Jump_015_5AFC:: ; address name
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    ld a, $C7
    ld [wD7F1], a
    call LoadFamilyIconTileForRecordB_Bank15
    ld de, Data_015_7411
    ld hl, wWindowTileBuffer + $6C
    ld bc, $0C09
    call CopyRectTo20ByteRows_Bank15
    pop af
    ld [wD7F1], a
    farcall DrawRecordStatsBoxForWD7F1
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 16 of the `rst $00` table in ScriptCommandED_Run_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
; points at: wTextWindowTileLo
ScriptCommandED_Run_Case07_Case10::
Jump_015_5B33:: ; address name
    ld hl, vTiles1 + $270
    ld bc, $0901
    call FillTilesBxC
    ld hl, vTiles1 + $780
    ld bc, $0501
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld hl, wWindowTileBuffer + $78
    ld c, $28
    call ScriptCommandED_Run_Case07_Case10_Sub01
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 17 of the `rst $00` table in ScriptCommandED_Run_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, wD781
; writes: wD7F1, wD781
ScriptCommandED_Run_Case07_Case11::
Jump_015_5B62:: ; address name
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld [wD7F1], a
    farcall DrawRecordNameAndSpeciesNameTiles
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 18 of the `rst $00` table in ScriptCommandED_Run_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
ScriptCommandED_Run_Case07_Case12::
Jump_015_5B82:: ; address name
    call BGMapAddressAtScroll_Bank15
    ld bc, $140B
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 19 of the `rst $00` table in ScriptCommandED_Run_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wMenuInputResult, wD781, wD7AB
; writes: wMenuInputResult, wD781, wTwoChoiceCursor, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScriptCommandType, ...
ScriptCommandED_Run_Case07_Case13::
Jump_015_5B96:: ; address name
    xor a, a
    ld [wMenuInputResult], a
    farcall UpdatePagedListCursor
    ld a, [wMenuInputResult]
    and a, a
    ret z
    cp a, $FB
    jr z, Jump_015_5BBA
    cp a, $FC
    jr z, Jump_015_5BBA
    cp a, $FD
    jr z, Jump_015_5C10
    cp a, $FE
    jr z, Jump_015_5BC3
    cp a, $FF
    jr z, Jump_015_5BD9
    ret

Jump_015_5BBA::
    ld a, [wD781]
    sub a, $07
    ld [wD781], a
    ret

Jump_015_5BC3::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_015_5BD9::
    ld a, [wD781]
    add a, $03
    ld [wD781], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_015_73A1
    call StoreBAtWordTableEntry_Bank15
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
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_015_5C10::
    ld a, [wD781]
    sub a, $04
    ld [wD781], a
    ret

; entry 20 of the `rst $00` table in ScriptCommandED_Run_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F1, wD7F2, wD781
ScriptCommandED_Run_Case07_Case14::
Jump_015_5C19:: ; address name
    ld de, Data_01F_4180
    ld hl, vTiles2 + $770
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4330
    ld hl, vTiles2 + $730
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld c, $09
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [wD7F1], a
    ld a, $14
    ld [wD7F2], a
    call ScriptCommandED_Run_Shared03
    ld de, Data_015_73AB
    ld hl, wWindowTileBuffer + $112
    ld bc, $0601
    call CopyRectTo20ByteRows_Bank15
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 21 of the `rst $00` table in ScriptCommandED_Run_Case07
; no direct call (reached through a table, a jump or a vector)
; writes: wD781, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
ScriptCommandED_Run_Case07_Case15::
Jump_015_5C5B:: ; address name
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    call DrawPair72A9And72C5AndStep_570C
    ld a, $06
    ld [wD781], a
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 25 of the `rst $00` table in ScriptCommandED_Run_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F1, wD7F2, wD781
ScriptCommandED_Run_Case07_Case19::
Jump_015_5C7D:: ; address name
    ld de, Data_01F_4180
    ld hl, vTiles2 + $770
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4330
    ld hl, vTiles2 + $730
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld c, $05
    ld hl, $0278
    ld de, $00AC
    xor a, a
    ld [wD7F1], a
    ld a, $08
    ld [wD7F2], a
    call ScriptCommandED_Run_Shared03
    ld de, Data_015_73AB
    ld hl, wWindowTileBuffer + $112
    ld bc, $0605
    call CopyRectTo20ByteRows_Bank15
    ld de, Data_015_7471
    ld hl, wWindowTileBuffer + $10C
    ld bc, $0C01
    call CopyRectTo20ByteRows_Bank15
    xor a, a
    ld b, $BC
    ld hl, Data_015_733B
    call StoreBAtWordTableEntry_Bank15
    ld c, $04
    ld hl, Data_015_73A1
    call BlankWordTableTargets
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 26 of the `rst $00` table in ScriptCommandED_Run_Case07
; no direct call (reached through a table, a jump or a vector)
; writes: wD781, wScriptCommandType, wScriptStartRequest
ScriptCommandED_Run_Case07_Case1A::
Jump_015_5CDC:: ; address name
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ld a, $13
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 27 of the `rst $00` table in ScriptCommandED_Run_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wD7AB, wD781
; writes: rRAMG2, rRAMB, wNameGlyphBuf, wD781, wScriptCommandType, wScriptStartRequest
; points at: wD789, wNameGlyphBuf, wTextBuf0
ScriptCommandED_Run_Case07_Case1B::
Jump_015_5CF7:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wD789
    ld a, [wD7AB]
    add_a_to_hl
    ld a, [hl]
    ld c, $01
    call CopyRecordNameToWC8CF
    xor a, a
    ld [rRAMG2], a
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0

Jump_015_5D20::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_015_5D2A
    ld [de], a
    inc hl
    inc de
    jr Jump_015_5D20

Jump_015_5D2A::
    ld a, $F0
    ld [de], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 28 of the `rst $00` table in ScriptCommandED_Run_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wD7AB, wD781
; writes: rRAMG2, rRAMB, wD781
; points at: wD789, wPartyList
ScriptCommandED_Run_Case07_Case1C::
Jump_015_5D3E:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wD789
    ld a, [wD7AB]
    add_a_to_hl
    ld a, [hl]
    ld c, $00
    call SRAMRecordAddress
    ld a, $01
    ld [hl], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wD7AB]
    cp a, $03
    jr z, Jump_015_5DB3
    ld hl, wD789
    ld a, [wD7AB]
    add_a_to_hl
    ld a, $FF
    ld [hl], a
    ld hl, wD789
    ld de, wPartyList
    ld c, $00

Jump_015_5D7C::
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_015_5D84
    inc hl
    jr Jump_015_5D88

Jump_015_5D84::
    ld [de], a
    inc hl
    inc de
    inc c

Jump_015_5D88::
    ld a, c
    cp a, $03
    jr c, Jump_015_5D7C
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wPartyList
    ld c, $00

Jump_015_5D9B::
    push bc
    push hl
    ld a, [hl]
    ld c, $00
    call SRAMRecordAddress
    ld a, $02
    ld [hl], a
    pop hl
    pop bc
    inc hl
    inc c
    ld a, c
    cp a, $03
    jr c, Jump_015_5D9B
    xor a, a
    ld [rRAMG2], a

Jump_015_5DB3::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 29 of the `rst $00` table in ScriptCommandED_Run_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wOBJPaletteUploadRequest, wD781
ScriptCommandED_Run_Case07_Case1D::
Jump_015_5DBB:: ; address name
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 30 of the `rst $00` table in ScriptCommandED_Run_Case07
; no direct call (reached through a table, a jump or a vector)
; writes: wD7F1, wD7F2
ScriptCommandED_Run_Case07_Case1E::
Jump_015_5DCE:: ; address name
    ld c, $0D
    ld hl, $01CC
    ld de, $0000
    xor a, a
    ld [wD7F1], a
    ld a, $14
    ld [wD7F2], a
    call ScriptCommandED_Run_Shared03
    ld de, Data_01F_43C0
    ld hl, vTiles1 + $2D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_42D0
    ld hl, vTiles1 + $2E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_015_6F6B
    ld hl, wWindowTileBuffer + $64
    ld bc, $0807
    call CopyRectTo20ByteRows_Bank15
    call DrawGoldBoxAndStep_Bank15
    ret

; entry 31 of the `rst $00` table in ScriptCommandED_Run_Case07
; no direct call (reached through a table, a jump or a vector)
; reads: wD786
; writes: wScriptCommandType, wScriptStartRequest
ScriptCommandED_Run_Case07_Case1F::
Jump_015_5E0C:: ; address name
    call DrawPair72A9And72C5AndStep_570C
    ld a, [wD786]
    ld hl, Data_015_732D
    ld b, $BC
    call StoreBAtWordTableEntry_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 8 of the `rst $00` table in ScriptCommandED_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStartRequest, wScriptPointerLo, wScriptPointerHi
; writes: wScriptReturnBank, wScriptReturnLo, wScriptReturnHi, wTalkEventIndex, wTalkEventGroup, wScriptInDataBank, wD780, wCFA8, ...
ScriptCommandED_Run_Case08::
Jump_015_5E30:: ; address name
    ld a, [wScriptStartRequest]
    ld [wScriptReturnBank], a
    ld a, [wScriptPointerLo]
    ld [wScriptReturnLo], a
    ld a, [wScriptPointerHi]
    ld [wScriptReturnHi], a
    xor a, a
    ld [wTalkEventIndex], a
    ld a, $17
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wScriptInDataBank], a
    ld a, $06
    ld [wD780], a
    xor a, a
    ld [wCFA8], a
    ld [wCFA9], a
    ret

; entry 9 of the `rst $00` table in ScriptCommandED_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, hTemp0, hTemp1, wScriptStartRequest, wScriptPointerLo, wScriptPointerHi
; writes: rRAMG2, rRAMB, wChildRecord, wScriptReturnBank, wScriptReturnLo, wScriptReturnHi, wTalkEventIndex, wTalkEventGroup, ...
ScriptCommandED_Run_Case09::
Jump_015_5E62:: ; address name
    farcall SetWD7F5ToWD789Cell4
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    push hl
    ld c, $0B
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld [wChildRecord + $B], a
    ldh a, [hTemp1]
    ld [wChildRecord + $C], a
    pop hl
    ld a, [hl]
    ld c, $6D
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    ld [wChildRecord + $6D], a
    xor a, a
    ld [rRAMG2], a
    ld a, [wScriptStartRequest]
    ld [wScriptReturnBank], a
    ld a, [wScriptPointerLo]
    ld [wScriptReturnLo], a
    ld a, [wScriptPointerHi]
    ld [wScriptReturnHi], a
    xor a, a
    ld [wTalkEventIndex], a
    ld a, $16
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wScriptInDataBank], a
    ld a, $06
    ld [wD780], a
    xor a, a
    ld [wCFA8], a
    ld [wCFA9], a
    ret

; entry 10 of the `rst $00` table in ScriptCommandED_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptStartRequest, wScriptPointerLo, wScriptPointerHi
; writes: wScriptReturnBank, wScriptReturnLo, wScriptReturnHi, wTalkEventIndex, wTalkEventGroup, wScriptInDataBank
; points at: wD780
ScriptCommandED_Run_Case0A::
Jump_015_5ECC:: ; address name
    ld a, [wScriptStartRequest]
    ld [wScriptReturnBank], a
    ld a, [wScriptPointerLo]
    ld [wScriptReturnLo], a
    ld a, [wScriptPointerHi]
    ld [wScriptReturnHi], a
    xor a, a
    ld [wTalkEventIndex], a
    ld a, $15
    ld [wTalkEventGroup], a
    farcall DispatchTalkEvent
    xor a, a
    ld [wScriptInDataBank], a
    ld hl, wD780
    inc [hl]
    ret

; entry 11 of the `rst $00` table in ScriptCommandED_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandED_Run_Case0B::
Jump_015_5EF6:: ; address name
    ld a, [wD781]
    rst $00
    dw ScriptCommandED_Run_Case0B_Case00
    dw ScriptCommandED_Run_Case07_Case00
    dw DrawPair72A9And72C5AndStep_570C
    dw ScriptCommandED_Run_Case07_Case02
    dw ScriptCommandED_Run_Case07_Case03
    dw ScriptCommandED_Run_Case0B_Case05
    dw ScriptCommandED_Run_Case0B_Case06
    dw ScriptCommandED_Run_Case0B_Case07

; entry 5 of the `rst $00` table in ScriptCommandED_Run_Case0B
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
ScriptCommandED_Run_Case0B_Case05::
Jump_015_5F0A:: ; address name
    call DrawGoldBoxAndStep_Bank15
    ld a, [wIsCGB]
    and a, a
    jr nz, Jump_015_5F1E
    farcall SendSGBPaletteSetForWC51F
    ld a, $FC
    call StartPaletteFade

Jump_015_5F1E::
    ret

; entry 0 of the `rst $00` table in ScriptCommandED_Run_Case0B
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F5, wD7F6, wD7F1, wD7F2, wD7F3, wD7F4, wD7F7, wD781
ScriptCommandED_Run_Case0B_Case00::
Jump_015_5F1F:: ; address name
    call BGMapAddressAtScroll_Bank15
    ld a, h
    ld [wD7F5], a
    ld a, l
    ld [wD7F6], a
    ld de, $5E12
    ld a, d
    ld [wD7F1], a
    ld a, e
    ld [wD7F2], a
    ld a, $20
    ld [wD7F3], a
    ld a, $20
    ld [wD7F4], a
    xor a, a
    ld [wD7F7], a
    farcall DrawTileRectAndClearAttrs_5D9A
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 6 of the `rst $00` table in ScriptCommandED_Run_Case0B
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState, wD781
; writes: wD781, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScriptCommandType, wScriptStartRequest
; points at: wNameGlyphBuf, wTextBuf0
ScriptCommandED_Run_Case0B_Case06::
Jump_015_5F51:: ; address name
    ld a, [wFadeState]
    and a, a
    ret nz
    ld de, wChildRecord + $B
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call CopyMonsterNameToBuffer_B15
    ld hl, wNameGlyphBuf
    ld de, wTextBuf0
    ld c, $00

Jump_015_5F69::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_015_5F77
    ld [de], a
    inc de
    inc hl
    inc c
    ld a, c
    cp a, $10
    jr c, Jump_015_5F69

Jump_015_5F77::
    ld a, $F0
    ld [de], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
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
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 7 of the `rst $00` table in ScriptCommandED_Run_Case0B
; no direct call (reached through a table, a jump or a vector)
; writes: wD781, wD782, wD780, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wScriptCommandType, ...
ScriptCommandED_Run_Case0B_Case07::
Jump_015_5FAD:: ; address name
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, $01
    ld [wD780], a
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
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 12 of the `rst $00` table in ScriptCommandED_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781, wD7B3, wD780
; writes: wD781, wD782, wD780
ScriptCommandED_Run_Case0C::
Jump_015_5FD9:: ; address name
    farcall ScriptCommandE8_Run
    ld a, [wD781]
    cp a, $0A
    ret nz
    ld a, [wD7B3]
    cp a, $23
    jr nz, Jump_015_5FFC
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, [wD780]
    add a, $06
    ld [wD780], a
    ret

Jump_015_5FFC::
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, [wD780]
    add a, $05
    ld [wD780], a
    ret

; entry 13 of the `rst $00` table in ScriptCommandED_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781, wD780
; writes: wD781, wD782, wD780
ScriptCommandED_Run_Case0D::
Jump_015_600C:: ; address name
    farcall ScriptCommandE8_Run
    ld a, [wD781]
    cp a, $0A
    ret nz
    xor a, a
    ld [wD781], a
    ld [wD782], a
    ld a, [wD780]
    inc a
    inc a
    ld [wD780], a
    ret

; entry 15 of the `rst $00` table in ScriptCommandED_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandED_Run_Case0F::
Jump_015_6028:: ; address name
    ld a, [wD781]
    rst $00
    dw ScriptCommandED_Run_Case0F_Case00
    dw ScriptCommandED_Run_Case0F_Case01
    dw ScriptCommandED_Run_Case0F_Case02
    dw ScriptCommandED_Run_Case05_Case0D
    dw ScriptCommandED_Run_Case0F_Case04
    dw LoadTile4990AndRun6320
    dw ScriptCommandED_Run_Case0F_Case06
    dw ScriptCommandED_Run_Case0F_Case07
    dw ScriptCommandED_Run_Case0F_Case08

; entry 0 of the `rst $00` table in ScriptCommandED_Run_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wBGPaletteUploadRequest, wD781
; points at: wBGPaletteBuffer
ScriptCommandED_Run_Case0F_Case00::
Jump_015_603E:: ; address name
    ld hl, vTiles2
    ld de, Data_047_629A
    ld b, $47
    call DecompressToVRAM
    ld hl, wBGPaletteBuffer
    ld de, Data_047_67E2
    ld b, $47
    ld c, $40
    call CopyFromBankWaitVRAM
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 1 of the `rst $00` table in ScriptCommandED_Run_Case0F
; no direct call (reached through a table, a jump or a vector)
ScriptCommandED_Run_Case0F_Case01::
Jump_015_6063:: ; address name
    ld hl, Data_015_72E1
    ld de, Data_015_72F1
    call CopyGlyphTileListFromBank1F_Bank15
    call DrawPair72A9And72C5AndStep
    ret

; entry 2 of the `rst $00` table in ScriptCommandED_Run_Case0F
; no direct call (reached through a table, a jump or a vector)
ScriptCommandED_Run_Case0F_Case02::
Jump_015_6070:: ; address name
    call ClearTileRowsAndResetWindowAndStep
    ret

; entry 13 of the `rst $00` table in ScriptCommandED_Run_Case05
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B0, wD781
; writes: wD7F1, wD7F2, wD781
ScriptCommandED_Run_Case05_Case0D::
Jump_015_6074:: ; address name
    ld de, Data_015_7050
    ld hl, wWindowTileBuffer + $BB
    ld bc, $0D09
    call CopyRectTo20ByteRows_Bank15
    farcall ClampRecordListPageCursor4
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_015_60A4
    ld hl, wWindowTileBuffer + $162
    call StoreC5BEC6AtHLStride2_Bank15
    ld hl, wWindowTileBuffer + $163
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    farcall DrawPageOfPagesAtWD7F1_Bank1E

Jump_015_60A4::
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 4 of the `rst $00` table in ScriptCommandED_Run_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD7F5, wD781
ScriptCommandED_Run_Case0F_Case04::
Jump_015_60AC:: ; address name
    ld a, $01
    ld [wD7F5], a
    farcall DrawRecordListPageSpeciesNames
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; copies a tile from bank $1F to vTiles1 + $4E0, runs Func_01D_6320 with wD7F1 = wD7F2 = 1, then wD781 += 1 (E-0122)
; 1 call site from 1 routine (e.g. ScriptCommandED_Run_Case05_Case0E)
; reads: wD781
; writes: wD7F1, wD7F2, wD781
LoadTile4990AndRun6320::
Func_015_60BF:: ; address name
    ld de, Data_01F_4990
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, $01
    ld [wD7F1], a
    ld [wD7F2], a
    farcall DrawRecordListPageMarks
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 6 of the `rst $00` table in ScriptCommandED_Run_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wD7AB, wD781
; writes: wD781
ScriptCommandED_Run_Case0F_Case06::
Jump_015_60E2:: ; address name
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_015_7333
    call StoreBAtWordTableEntry_Bank15
    ld de, Data_015_7351
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank15
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 7 of the `rst $00` table in ScriptCommandED_Run_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wD7F5, wD7F6, wD781
; writes: rRAMG2, rRAMB, wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, ...
ScriptCommandED_Run_Case0F_Case07::
Jump_015_6101:: ; address name
    farcall SetWD7F5ToWD789Cell4
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [hl]
    ld c, $6D
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMG2], a
    call TenTimesHFFC6PlusTenToDigits
    call ScriptCommandED_Run_Shared04
    xor a, a
    ld [wStringCategory], a
    ld a, $1B
    ld [wStringIndex], a
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
    farcall ShowString_Bank1B_4C94
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 8 of the `rst $00` table in ScriptCommandED_Run_Case0F
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B2, wD7B3
; writes: wOBJPaletteUploadRequest, hSpriteHideTile, wD782, wD780, wD781, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, ...
ScriptCommandED_Run_Case0F_Case08::
Jump_015_6155:: ; address name
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    call BGMapAddressAtScroll_Bank15
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, $0168
    call DrawScreenBufferRect_Bank15
    farcall RestoreSpriteStateFromWD7BA
    ld a, $70
    ldh [hSpriteHideTile], a
    xor a, a
    ld [wD782], a
    ld a, [wD7B2]
    ld [wD780], a
    ld a, [wD7B3]
    ld [wD781], a
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
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 16 of the `rst $00` table in ScriptCommandED_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandED_Run_Case10::
Jump_015_61B6:: ; address name
    ld a, [wD781]
    rst $00
    dw ScriptCommandED_Run_Case0F_Case00
    dw ScriptCommandED_Run_Case0F_Case01
    dw ScriptCommandED_Run_Case10_Case02
    dw ScriptCommandED_Run_Case07_Case0E
    dw ScriptCommandED_Run_Case07_Case0F
    dw ScriptCommandED_Run_Case07_Case10
    dw ScriptCommandED_Run_Case07_Case11
    dw ScriptCommandED_Run_Case04_Case3D
    dw ScriptCommandED_Run_Case10_Case08
    dw ScriptCommandED_Run_Case0F_Case08

; entry 2 of the `rst $00` table in ScriptCommandED_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
; points at: wTextWindowTileLo
ScriptCommandED_Run_Case10_Case02::
Jump_015_61CE:: ; address name
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call FillTilesBxC
    ld hl, vTiles1 + $700
    ld bc, $0501
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 45 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wD781
; writes: wD781
ScriptCommandED_Run_Case04_Case2D::
Jump_015_61F5:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr nz, ScriptCommandED_Run_Case04_Case3D
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 61 of the `rst $00` table in ScriptCommandED_Run_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
ScriptCommandED_Run_Case04_Case3D::
Jump_015_6203:: ; address name
    call ScriptCommandED_Run_Shared02
    ld de, Data_01F_4230
    ld hl, vTiles1 + $4E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4290
    ld hl, vTiles1 + $4F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld de, Data_01F_4370
    ld hl, vTiles1 + $5F0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 8 of the `rst $00` table in ScriptCommandED_Run_Case10
; no direct call (reached through a table, a jump or a vector)
; reads: wD7AB, wD781
; writes: wD781
ScriptCommandED_Run_Case10_Case08::
Jump_015_6235:: ; address name
    ld c, $04
    ld hl, Data_015_73A1
    call BlankWordTableTargets
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_015_73A1
    call StoreBAtWordTableEntry_Bank15
    ld de, Data_015_7351
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank15
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 18 of the `rst $00` table in ScriptCommandED_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandED_Run_Case12::
Jump_015_625C:: ; address name
    ld a, [wD781]
    rst $00
    dw ScriptCommandED_Run_Case0F_Case00
    dw ScriptCommandED_Run_Case12_Case01
    dw DrawPair72A9And72C5AndStep
    dw ScriptCommandED_Run_Case12_Case03
    dw ScriptCommandED_Run_Case12_Case04
    dw ScriptCommandED_Run_Case05_Case0A
    dw ScriptCommandED_Run_Case12_Case06
    dw ScriptCommandED_Run_Case12_Case07
    dw ScriptCommandED_Run_Case04_Case1C
    dw ScriptCommandED_Run_Case12_Case09
    dw ScriptCommandED_Run_Case0F_Case08

; entry 7 of the `rst $00` table in ScriptCommandED_Run_Case12
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B4, wD781
; writes: wD7F1, wD781
ScriptCommandED_Run_Case12_Case07::
Jump_015_6276:: ; address name
    ld hl, vTiles1 + $270
    ld bc, $0901
    call FillTilesBxC
    ld hl, vTiles1 + $780
    ld bc, $0501
    call FillTilesBxC
    ld a, [wD7B4]
    ld [wD7F1], a
    farcall DrawRecordNameAndSpeciesNameTiles
    call ScriptCommandED_Run_Shared06
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 9 of the `rst $00` table in ScriptCommandED_Run_Case12
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B4, wD7F5, wD7F6
; writes: wD7F1
ScriptCommandED_Run_Case12_Case09::
Jump_015_629F:: ; address name
    ld a, $C7
    ld [wD7F1], a
    ld a, [wD7B4]
    ld b, a
    call LoadFamilyIconTileForRecordB_Bank15
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld b, a
    push af
    ld a, $FF
    ld [wD7F1], a
    call LoadFamilyIconTileForRecordB_Bank15
    pop af
    call CopyRect7351ToWC410AndIncWD781
    ret

; entry 1 of the `rst $00` table in ScriptCommandED_Run_Case12
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B0, wD7AB, wD781
; writes: wD7F1, wD7F2, wD781
ScriptCommandED_Run_Case12_Case01::
Jump_015_62C9:: ; address name
    call LoadRecordWD7B4Byte0EBit0
    call ScriptCommandED_Run_Shared05
    jp Jump_015_62F7

; entry 4 of the `rst $00` table in ScriptCommandED_Run_Case12
; no direct call (reached through a table, a jump or a vector)
ScriptCommandED_Run_Case12_Case04::
Jump_015_62D2:: ; address name
    call ClearThreeTileRows
    call DrawWD789Cell5RecordNamesAndStep
    ret

; entry 17 of the `rst $00` table in ScriptCommandED_Run
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
ScriptCommandED_Run_Case11::
Jump_015_62D9:: ; address name
    ld a, [wD781]
    rst $00
    dw ScriptCommandED_Run_Case0F_Case00
    dw ScriptCommandED_Run_Case0F_Case01
    dw ScriptCommandED_Run_Case11_Case02
    dw ScriptCommandED_Run_Case12_Case03
    dw ScriptCommandED_Run_Case12_Case06
    dw ScriptCommandED_Run_Case04_Case04
    dw ScriptCommandED_Run_Case04_Case05
    dw ScriptCommandED_Run_Case04_Case06
    dw CopyRect7351ToWC410AndIncWD781
    dw ScriptCommandED_Run_Case0F_Case08

; entry 2 of the `rst $00` table in ScriptCommandED_Run_Case11
; no direct call (reached through a table, a jump or a vector)
; reads: wD7B0, wD7AB, wD781
; writes: wD7F1, wD7F2, wD781
ScriptCommandED_Run_Case11_Case02::
Jump_015_62F1:: ; address name
    farcall ListRecordsInUseWithByte6EClear

Jump_015_62F7::
    farcall ClampRecordListPageCursor5
    ld a, [wD7B0]
    cp a, $02
    jr c, Jump_015_631B
    ld hl, wWindowTileBuffer + $12E
    call StoreC5BEC6AtHLStride2_Bank15
    ld hl, wWindowTileBuffer + $12F
    ld a, h
    ld [wD7F1], a
    ld a, l
    ld [wD7F2], a
    farcall DrawPageOfPagesAtWD7F1_Bank1E

Jump_015_631B::
    ld c, $05
    ld hl, Data_015_73A1
    call BlankWordTableTargets
    ld a, [wD7AB]
    ld b, $BC
    ld hl, Data_015_73A1
    call StoreBAtWordTableEntry_Bank15
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 3 of the `rst $00` table in ScriptCommandED_Run_Case12
; no direct call (reached through a table, a jump or a vector)
; reads: wD781
; writes: wD781
ScriptCommandED_Run_Case12_Case03::
Jump_015_6336:: ; address name
    ld hl, vTiles1 + $240
    ld bc, $0C01
    call FillTilesBxC
    ld hl, vTiles1 + $700
    ld bc, $0D01
    call FillTilesBxC
    ld hl, vTiles1 + $4E0
    ld bc, $1101
    call FillTilesBxC
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; entry 6 of the `rst $00` table in ScriptCommandED_Run_Case12
; no direct call (reached through a table, a jump or a vector)
ScriptCommandED_Run_Case12_Case06::
Jump_015_6359:: ; address name
    farcall DrawRecordListPageNames
    ret

; copies the 8 x 5 rectangle Data_015_7351 into wC410 (CopyRectTo20ByteRows_Bank15), then wD781 += 1 (E-0119)
; 1 call site from 1 routine (e.g. ScriptCommandED_Run_Case12_Case09)
; reads: wD781
; writes: wD781
CopyRect7351ToWC410AndIncWD781::
Func_015_6360:: ; address name
    ld de, Data_015_7351
    ld hl, wWindowTileBuffer + $110
    ld bc, $0805
    call CopyRectTo20ByteRows_Bank15
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

; for each entry from wD785 of the destination list at HL and the source list at DE copies a 16-byte tile from bank $1F, until $FF; then clears wD784/5 (E-0125)
; 6 call sites from 6 routines (e.g. ScriptCommandEE_Run_Case01, ScriptCommandED_Run_Case04_Case0D, DrawPair72A9And72C5AndStep_570C, ScriptCommandED_Run_Case0F_Case01, ...)
; reads: wD785
; writes: wD785, wD784
CopyGlyphTileListFromBank1F_Bank15::
Func_015_6374:: ; address name
    push hl
    push de
    ld a, [wD785]
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jp z, Jump_015_63AE
    ld e, a
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    push de
    push hl
    ld a, [wD785]
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_015_6395
    inc d

Jump_015_6395::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld d, a
    ld e, l
    pop hl
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    pop hl
    ld a, [wD785]
    inc a
    ld [wD785], a
    jr CopyGlyphTileListFromBank1F_Bank15

Jump_015_63AE::
    pop de
    pop hl
    xor a, a
    ld [wD785], a
    ld [wD784], a
    ret

; DecompressGraphicsWD7F1ToWD7F4 with graphics number $00A4 and destination $8000 (vTiles0) (E-0117)
; 2 call sites from 2 routines (e.g. ShowSaveFileInfoWindow, DecompressA4GraphicsAndContinue)
; writes: wD7F1, wD7F2, wD7F3, wD7F4, wD7F5
DecompressGraphicsA4ToTiles0::
Func_015_63B8:: ; address name
    ld a, $A4
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    ld [wD7F3], a
    ld [wD7F4], a
    ld a, $80
    ld [wD7F5], a
    farcall DecompressGraphicsWD7F1ToWD7F4
    ret

; only called from routines of ScriptCommandED_Run (E-0098)
; 9 call sites from 5 routines (e.g. ScriptCommandED_Run_Case04_Case36, ScriptCommandED_Run_Case04_Case2F, ScriptCommandED_Run_Case04_Case2C, ScriptCommandED_Run_Case04_Case3E, ...)
; reads: wLinkMode, wD780, wD781
; writes: rRAMG2, rRAMB, wD7F1, wD7F2, wD7F3, wD7F4, wD7F5, wD7F6
; points at: sBB0F
ScriptCommandED_Run_Shared02::
Func_015_63D3:: ; address name
    ld a, [wLinkMode]
    and a, a
    ret z
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld hl, sBB0F
    ld de, $022B
    add hl, de
    ld a, [hl]
    and a, a
    jr nz, Jump_015_63F5

Jump_015_63ED::
    xor a, a
    ld [rRAMB], a
    ld [rRAMG2], a
    ret

Jump_015_63F5::
    ld a, [wD780]
    cp a, $04
    jr nz, Jump_015_63ED
    ld a, [wD781]
    cp a, $37
    jr nc, Jump_015_63ED

; with SRAM disabled draws sprite part $0090 at ($88, $28) (Func_01D_6A3F, C = 1) (E-0124)
; 2 call sites from 2 routines (e.g. ScriptCommandF2_Run_Shared02, GameMode5_Update_Case07_Sub01_Sub01)
; writes: rRAMB, rRAMG2, wD7F1, wD7F2, wD7F3, wD7F4, wD7F5, wD7F6
DrawSpritePart9000At88_28::
Func_015_6403:: ; address name
    xor a, a
    ld [rRAMB], a
    ld [rRAMG2], a
    ld a, $90
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    ld [wD7F3], a
    ld a, $88
    ld [wD7F4], a
    ld a, $28
    ld [wD7F5], a
    xor a, a
    ld [wD7F6], a
    ld c, $01
    farcall DrawSpritePart9000At88_28_Sub01
    ret

; outside link battles only sets wD782 = 2; otherwise copies the row Data_015_727D when wD782 is set, sets wD782 = 2 and draws the box at scroll + $1CC (E-0124)
; 3 call sites from 3 routines (e.g. ScriptCommandED_Run_Case04_Case2C, ScriptCommandF2_Run_Case03_Case0B, Func_0F0_4CA0_Table4_Case03)
; reads: wLinkMode, wD782
; writes: wD782
DrawBottomBoxForLinkAndSetWD782::
Func_015_642D:: ; address name
    ld a, [wLinkMode]
    and a, a
    jr nz, Jump_015_6439
    ld a, $02
    ld [wD782], a
    ret

Jump_015_6439::
    ld a, [wD782]
    and a, a
    jr nz, Jump_015_6441
    jr Jump_015_644D

Jump_015_6441::
    ld de, Data_015_727D
    ld hl, wWindowTileBuffer + $C8
    ld bc, $1401
    call CopyRectTo20ByteRows_Bank15

Jump_015_644D::
    ld a, $02
    ld [wD782], a
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ret

; copies the 20 x 11 rectangle Data_015_70C5 into wC364, then DrawScreenBufferRect_Bank15 (20 x 13 at the scroll origin) (E-0119)
; 3 call sites from 3 routines (e.g. DrawRect70C5IfWC58AAndStep, ScriptCommandF2_Run_Case03_Case09, Func_0F0_4CA0_Table4_Case01)
CopyRect70C5ToWC364AndDraw::
Func_015_645F:: ; address name
    ld de, Data_015_70C5
    ld hl, wWindowTileBuffer + $64
    ld bc, $140B
    call CopyRectTo20ByteRows_Bank15
    call BGMapAddressAtScroll_Bank15
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRect_Bank15
    ret

; up/down moves wD786 over three options with sound $69; A chooses (option 2 cancels), sets wTwoChoiceCursor and requests script $80; B cancels (E-0129)
; 2 call sites from 2 routines (e.g. ScriptCommandED_Run_Case02, ScriptCommandEF_Run_Case02)
; reads: wJoypadPressedRepeat, wJoypadPressed, wD786, wD780
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wThreeOptionResult, wD780, wD7AB, wD7AD, wD7AF, ...
HandleThreeOptionMenuInput_15::
Func_015_6478:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_015_6494
    bit 7, a
    jr nz, Jump_015_64C2
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_015_64DC
    bit 1, a
    jp nz, Jump_015_6511
    call BlinkCursorWD787_Bank15
    ret

Jump_015_6494::
    call DrawBlankTileC3_6542
    ld a, [wD786]
    and a, a
    jr nz, Jump_015_64AB
    ld a, $02
    ld [wD786], a
    call BlinkCursorWD787_Bank15
    ld a, $69
    call QueueSoundEffect
    ret

Jump_015_64AB::
    dec a

Jump_015_64AC::
    ld [wD786], a
    xor a, a
    ld [wD7AB], a
    ld [wD7AD], a
    ld [wD7AF], a
    call BlinkCursorWD787_Bank15
    ld a, $69
    call QueueSoundEffect
    ret

Jump_015_64C2::
    call DrawBlankTileC3_6542
    ld a, [wD786]
    cp a, $02
    jr c, Jump_015_64D9
    xor a, a
    ld [wD786], a
    call BlinkCursorWD787_Bank15
    ld a, $69
    call QueueSoundEffect
    ret

Jump_015_64D9::
    inc a
    jr Jump_015_64AC

Jump_015_64DC::
    ld a, $69
    call QueueSoundEffect
    call DrawArrowTileBCAtWD786Entry_Bank15
    ld c, $03
    ld hl, Data_015_732D
    call BlankWordTableTargets
    ld a, [wD786]
    cp a, $02
    jr z, Jump_015_6511
    ld [wTwoChoiceCursor], a
    ld a, [wD780]
    inc a
    ld [wD780], a
    xor a, a
    ld [wD7AB], a
    ld [wD7AD], a
    ld [wD7AF], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_015_6511::
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    xor a, a
    ld [wThreeOptionResult], a
    ret

; once the joypad repeat timer reaches $14, cycles wD787 through 0-$17 and draws the cursor tile ($BB) or a blank ($C3) (E-0122)
; 4 call sites from 1 routine (e.g. HandleThreeOptionMenuInput_15)
; reads: wJoypadRepeatTimer, wD787, wD786
; writes: wD787
BlinkCursorWD787_Bank15::
Func_015_6524:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, Jump_015_653E
    ld a, [wD787]
    inc a
    ld [wD787], a
    cp a, $10
    jr c, Jump_015_653E
    cp a, $18
    jr c, DrawBlankTileC3_6542
    xor a, a
    ld [wD787], a

Jump_015_653E::
    ld b, $BB
    jr Jump_015_6548

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. HandleThreeOptionMenuInput_15)
; reads: wD786
DrawBlankTileC3_6542::
Func_015_6542:: ; address name
    ld b, $C3
    jr Jump_015_6548

; B = $BC, then writes B at the scroll position + Data_015_6566[wD786] (E-0124)
; 1 call site from 1 routine (e.g. HandleThreeOptionMenuInput_15)
; reads: wD786
DrawArrowTileBCAtWD786Entry_Bank15::
Func_015_6546:: ; address name
    ld b, $BC

Jump_015_6548::
    ld a, [wD786]
    add a, a
    ld hl, Data_015_6566
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    push de
    call BGMapAddressAtScroll_Bank15
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

Data_015_6566:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $00, $61, $00, $A1, $00

; only called from ScriptCommandED_Run_Case07_Case10 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandED_Run_Case07_Case10)
; reads: hTemp0, rSTAT, wPartyCount
; writes: rRAMG2, rRAMB
; points at: wD789
ScriptCommandED_Run_Case07_Case10_Sub01::
Func_015_656C:: ; address name
    ld b, $00

Jump_015_656E::
    push bc
    push hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wD789
    ld a, b
    add_a_to_hl
    ld a, [hl]
    ld c, $00
    ld b, $01
    call LoadSRAMRecordByte
    xor a, a
    ld [rRAMB], a
    ld [rRAMG2], a
    ldh a, [hTemp0]
    cp a, $02
    jr nz, Jump_015_65AD
    pop hl
    pop bc
    push bc
    di

Jump_015_659B::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_015_659B
    ld a, b
    add a, $E1
    ld [hl], a
    ei
    ld a, c
    add_a_to_hl
    push hl

Jump_015_65AD::
    pop hl
    pop bc
    inc b
    ld a, [wPartyCount]
    cp a, b
    jr nz, Jump_015_656E
    ret

; Copies a rectangle of B bytes by C rows from [DE] to [HL], rows 20 ($14) bytes apart; on CGB it then zero-fills the same-shaped rectangle at HL + $0E68 with rSVBK = 2 and restores rSVBK = 0 (the same 58 bytes appear in 8 banks)
; 45 call sites from 37 routines (e.g. ScriptCommandED_Run_Case01_Case02, ScriptCommandED_Run_Case04_Case33, ScriptCommandED_Run_Case04_Case30, DrawBottomBoxForLinkAndSetWD782, ...)
; reads: wIsCGB
; writes: rSVBK
CopyRectTo20ByteRows_Bank15::
Func_015_65B7:: ; address name
    push hl
    push bc

Jump_015_65B9::
    push bc
    push hl

Jump_015_65BB::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_015_65BB
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_015_65B9
    pop bc
    pop hl
    ld a, [wIsCGB]
    and a, a
    ret z
    ld a, l
    add a, $68
    ld l, a
    ld a, h
    adc a, $0E
    ld h, a
    ld a, $02
    ldh [rSVBK], a

Jump_015_65DD::
    push bc
    push hl

Jump_015_65DF::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_015_65DF
    pop hl
    ld bc, $0014
    add hl, bc
    pop bc
    dec c
    jr nz, Jump_015_65DD
    xor a, a
    ldh [rSVBK], a
    ret

; DE = offset into wScreenTileBuffer, B = width, C = rows, HL = BG map address: CopyRectToBGMapWrapped from wScreenTileBuffer + DE; on CGB the same rectangle is then copied from wD000 + DE (rSVBK = 2) into VRAM bank 1, the attributes; on DMG BC, DE and HL are kept. wC554/wC555 unchanged when wStringIndex is $10-$12; otherwise HL + $1C1, replaced by $99C1 when that is $9B61 (E-0062)
; 41 call sites from 35 routines (e.g. ScriptCommandEE_Run_Case00, ScriptCommandED_Run_Case01_Case02, ScriptCommandED_Run_Case04_Case3B, ScriptCommandED_Run_Case04_Case34, ...)
; reads: wStringIndex, wTextCursorHi, wTextCursorLo, wIsCGB
; writes: wTextCursorLo, wTextCursorHi, rVBK, rSVBK
; points at: wScreenTileBuffer, wD000
DrawScreenBufferRect_Bank15::
Func_015_65F1:: ; address name
    push de
    push bc
    push hl
    ld hl, wScreenTileBuffer
    add hl, de
    ld e, l
    ld d, h
    pop hl
    push hl
    call CopyRectToBGMapWrapped
    pop hl
    push hl
    ld a, [wStringIndex]
    cp a, $10
    jr z, Jump_015_6634
    cp a, $11
    jr z, Jump_015_6634
    cp a, $12
    jr z, Jump_015_6634
    ld a, l
    add a, $C1
    ld [wTextCursorLo], a
    ld a, h
    adc a, $01
    ld [wTextCursorHi], a
    ld a, [wTextCursorHi]
    cp a, $9B
    jr nz, Jump_015_6634
    ld a, [wTextCursorLo]
    cp a, $61
    jr nz, Jump_015_6634
    ld a, $C1
    ld [wTextCursorLo], a
    ld a, $99
    ld [wTextCursorHi], a

Jump_015_6634::
    pop hl
    pop bc
    pop de
    ld a, [wIsCGB]
    and a, a
    ret z
    ld a, $01
    ldh [rVBK], a
    ld a, $02
    ldh [rSVBK], a
    push hl
    ld hl, wD000
    add hl, de
    ld e, l
    ld d, h
    pop hl
    call CopyRectToBGMapWrapped
    xor a, a
    ldh [rSVBK], a
    ldh [rVBK], a
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 45 call sites from 39 routines (e.g. ScriptCommandEE_Run_Case00, DrawArrowTileBCAtWD786Entry_Bank15, ScriptCommandED_Run_Case01_Case02, ScriptCommandED_Run_Case04_Case3B, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank15::
Func_015_6655:: ; address name
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

; wD7F1 = hFFC9, then the high and low digits of hFFC8, hFFC7 and hFFC6 go to wD7F2-wD7F7 (seven digits of a packed-BCD number, most significant first); the loop that follows (C = 6) is not read (E-0106)
; 9 call sites from 9 routines (e.g. TenTimesHFFC6PlusTenToDigits, DrawGoldBoxAndStep_Bank15, ScriptCommandEF_Run_Case01_Case01, ScriptCommandEF_Run_Case05_Case06, ...)
; points at: hTemp3, wD7F1
UnpackBCDToDigitsWD7F1::
Func_015_6676:: ; address name
    ld de, hTemp3
    ld hl, wD7F1
    ld a, [de]
    ld [hl+], a
    dec de
    ld a, [de]
    and a, $F0
    swap a
    ld [hl+], a
    ld a, [de]
    and a, $0F
    ld [hl+], a
    dec de
    ld a, [de]
    and a, $F0
    swap a
    ld [hl+], a
    ld a, [de]
    and a, $0F
    ld [hl+], a
    dec de
    ld a, [de]
    and a, $F0
    swap a
    ld [hl+], a
    ld a, [de]
    and a, $0F
    ld [hl], a
    ld c, $06
    ld hl, wD7F1

Jump_015_66A4::
    ld a, [hl]
    and a, a
    jr nz, Jump_015_66AE
    add a, $E3
    ld [hl+], a
    dec c
    jr nz, Jump_015_66A4

Jump_015_66AE::
    ret

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
; 6 call sites from 5 routines (e.g. ScriptCommandEE_Run_Case00, ScriptCommandED_Run_Case00, ScriptCommandED_Run_Shared03, ScriptCommandED_Run_Shared01_Sub01, ...)
CopyBytesDEToHL_Bank15::
Func_015_66AF:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, CopyBytesDEToHL_Bank15
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same 18 bytes appear in 7 banks)
; 6 call sites from 5 routines (e.g. ScriptCommandEE_Run_Case00, ScriptCommandED_Run_Case00, ScriptCommandED_Run_Shared03, ScriptCommandED_Run_Shared01_Sub02, ...)
; writes: rSVBK
CopyLow3BitsToWRAMBank2_Bank15::
Func_015_66B8:: ; address name
    ld a, $02
    ldh [rSVBK], a

Jump_015_66BC::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_015_66BC
    xor a, a
    ldh [rSVBK], a
    ret

; HL = table of 16-bit addresses, A = index: stores B at the address in entry A; keeps BC; clobbers A, DE, HL (the same 14 bytes appear in 8 banks)
; 19 call sites from 17 routines (e.g. BlankWordTableTargets, ScriptCommandED_Run_Case04_Case34, ScriptCommandED_Run_Case04_Case1E, ScriptCommandED_Run_Case04_Case0A, ...)
StoreBAtWordTableEntry_Bank15::
Func_015_66CA:: ; address name
    push bc
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    pop bc
    ld a, b
    ld [de], a
    ret

; only called from ScriptCommandED_Run_Case04_Case13 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandED_Run_Case04_Case13)
; reads: wD785, wD7F1, wD7F2, wD784
; writes: wD7F1, wD7F2, wD784, wD785
; points at: wD781
ScriptCommandED_Run_Case04_Case13_Sub01::
Func_015_66D8:: ; address name
    ld hl, Data_015_731B
    ld a, $9D
    jr Jump_015_66E4

; only called from ScriptCommandED_Run_Case05_Case00 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandED_Run_Case05_Case00)
; reads: wD785, wD7F1, wD7F2, wD784
; writes: wD7F1, wD7F2, wD784, wD785
; points at: wD781
ScriptCommandED_Run_Case05_Case00_Sub01::
Func_015_66DF:: ; address name
    ld hl, Data_015_731B
    ld a, $9C

Jump_015_66E4::
    ld [wD7F1], a
    xor a, a
    ld [wD7F2], a
    xor a, a
    ld [wD784], a

Jump_015_66EF::
    push hl
    ld a, [wD785]
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jp z, Jump_015_6734
    ld e, [hl]
    inc hl
    ld h, [hl]
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
    call CopyTileBytesToVRAM_Bank15
    pop hl
    ld a, [wD785]
    inc a
    ld [wD785], a
    ld a, [wD784]
    inc a
    ld [wD784], a
    cp a, $06
    jr c, Jump_015_66EF
    ret

Jump_015_6734::
    pop de
    pop hl
    xor a, a
    ld [wD784], a
    ld [wD785], a
    ld hl, wD781
    inc [hl]
    ret

; draws tiles $C5, $BE, $C6 at BGMapAddressAtScroll + DE, two entries apart (E-0121)
; 2 call sites from 2 routines (e.g. ScriptCommandED_Run_Case04_Case02, ScriptCommandED_Run_Case05_Case03)
DrawC5BEC6AtScrollOffsetDE_Bank15::
Func_015_6742:: ; address name
    push de
    call BGMapAddressAtScroll_Bank15
    pop de
    add hl, de
    push hl
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, $C5
    ld [hl], a
    ei
    pop hl
    inc hl
    inc hl
    push hl
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, $BE
    ld [hl], a
    ei
    pop hl
    inc hl
    inc hl
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, $C6
    ld [hl], a
    ei
    ret

; [HL] = $C5, [HL+2] = $BE, [HL+4] = $C6; HL ends at HL+4; clobbers A (the same 14 bytes appear in 8 banks)
; 4 call sites from 4 routines (e.g. ScriptCommandED_Run_Case04_Case02, ScriptCommandED_Run_Case05_Case03, ScriptCommandED_Run_Case05_Case0D, ScriptCommandED_Run_Case11_Case02)
StoreC5BEC6AtHLStride2_Bank15::
Func_015_6772:: ; address name
    ld a, $C5
    ld [hl], a
    inc hl
    inc hl
    ld a, $BE
    ld [hl], a
    inc hl
    inc hl
    ld a, $C6
    ld [hl], a
    ret

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (the same 17 bytes appear in 7 banks)
; 2 call sites from 2 routines (e.g. ShowSaveFileInfoWindow, ScriptCommandED_Run_Case05_Case00_Sub01)
; reads: rSTAT
CopyTileBytesToVRAM_Bank15::
Func_015_6780:: ; address name
    ld c, $10

Jump_015_6782::
    di

Jump_015_6783::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_015_6783
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    dec c
    jr nz, Jump_015_6782
    ret

; only called from routines of ScriptCommandED_Run (E-0098)
; 9 call sites from 8 routines (e.g. ScriptCommandED_Run_Case04_Case31, ScriptCommandED_Run_Case04_Case1F, ScriptCommandED_Run_Case04_Case09, ScriptCommandED_Run_Case04_Case00, ...)
; reads: wD7F1, wD7F2, wIsCGB
; points at: wScreenTileBuffer, wD000
ScriptCommandED_Run_Shared03::
Func_015_6791:: ; address name
    push bc
    push hl
    push de
    ld de, wScreenTileBuffer
    add hl, de
    pop de
    push de
    push hl
    ld hl, wScreenTileBuffer
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld a, [wD7F1]
    ld b, a
    ld a, [wD7F2]
    ld c, a
    call CopyBytesDEToHL_Bank15
    pop de
    pop hl
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_015_67D2
    push hl
    push de
    ld de, wD000
    add hl, de
    pop de
    push de
    push hl
    ld hl, wD000
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ld a, [wD7F1]
    ld b, a
    ld a, [wD7F2]
    ld c, a
    call CopyLow3BitsToWRAMBank2_Bank15
    pop de
    pop hl

Jump_015_67D2::
    pop bc
    ld a, $14
    add_a_to_hl
    ld a, $14
    add a, e
    ld e, a
    jr nc, Jump_015_67E1
    inc d

Jump_015_67E1::
    dec c
    jr nz, ScriptCommandED_Run_Shared03
    ret

; HL = table of addresses, C = count: stores tile $C3 at the address in each of the first C entries (StoreBAtWordTableEntry_Bank15) (E-0074)
; 9 call sites from 9 routines (e.g. HandleThreeOptionMenuInput_15, ScriptCommandED_Run_Case04_Case25, ScriptCommandED_Run_Case04_Case12, ScriptCommandED_Run_Case04_Case10, ...)
BlankWordTableTargets::
Func_015_67E5:: ; address name
    ld a, c
    ld b, a
    ld c, $00

Jump_015_67E9::
    ld a, c
    push bc
    ld b, $C3
    push hl
    call StoreBAtWordTableEntry_Bank15
    pop hl
    pop bc
    inc c
    ld a, c
    cp a, b
    jr c, Jump_015_67E9
    ret

; TenTimesHFFC6PlusTen, then converts it to packed BCD (Number24ToPackedBCD) and unpacks the digits to wD7F1 onward (E-0117)
; 3 call sites from 3 routines (e.g. ScriptCommandED_Run_Case04_Case3C, ScriptCommandED_Run_Case05_Case06, ScriptCommandED_Run_Case0F_Case07)
; writes: wDigits
TenTimesHFFC6PlusTenToDigits::
Func_015_67F9:: ; address name
    call TenTimesHFFC6PlusTen
    ld a, l
    ld [wDigits], a
    ld a, h
    ld [wDigits + $1], a
    xor a, a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    call UnpackBCDToDigitsWD7F1
    ret

; HL = 10 * hFFC6 + 10 (E-0117)
; 5 call sites from 5 routines (e.g. ScriptCommandED_Run_Case04_Case41, ScriptCommandED_Run_Case04_Case3F, TenTimesHFFC6PlusTenToDigits, ScriptCommandED_Run_Case05_Case10, ...)
; reads: hTemp0
TenTimesHFFC6PlusTen::
Func_015_680F:: ; address name
    ldh a, [hTemp0]
    ld c, $0A
    ld hl, $0000
    call Multiply8
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

; only called from routines of ScriptCommandED_Run (E-0098)
; 3 call sites from 3 routines (e.g. ScriptCommandED_Run_Case04_Case3C, ScriptCommandED_Run_Case05_Case06, ScriptCommandED_Run_Case0F_Case07)
; points at: wD7F4, wTextBuf0
ScriptCommandED_Run_Shared04::
Func_015_6822:: ; address name
    ld hl, wD7F4
    ld de, wTextBuf0
    ld c, $00

Jump_015_682A::
    ld a, [hl]
    cp a, $E3
    jr z, Jump_015_6831
    ld [de], a
    inc de

Jump_015_6831::
    inc hl
    inc c
    ld a, c
    cp a, $04
    jr c, Jump_015_682A
    ld a, $F0
    ld [de], a
    ret

; wGold -= the 24-bit amount wD7F3:wD7F2:wD7F1 (no floor; callers check first, for example with IsAmountInWD7F1AboveGold) (E-0106)
; 9 call sites from 9 routines (e.g. ScriptCommandED_Run_Case04_Case41, ScriptCommandED_Run_Case05_Case10, ScriptCommandF7_Run_Case07, ScriptCommandF7_Run_Case19, ...)
; reads: wD7F3, wD7F2, wD7F1, wGoldHi, wGoldMid, wGoldLo
; writes: wGoldHi, wGoldMid, wGoldLo
SubtractWD7F1AmountFromGold::
Func_015_683C:: ; address name
    ld a, [wD7F3]
    ld e, a
    ld a, [wD7F2]
    ld h, a
    ld a, [wD7F1]
    ld l, a
    ld a, [wGoldHi]
    ld d, a
    ld a, [wGoldMid]
    ld b, a
    ld a, [wGoldLo]
    sub a, l
    ld c, a
    ld a, b
    sbc a, h
    ld b, a
    ld a, d
    sbc a, e
    ld [wGoldHi], a
    ld a, b
    ld [wGoldMid], a
    ld a, c
    ld [wGoldLo], a
    ret

; wD09D = field $0D of SRAM record B & $0F (its family), wD09E = wD7F1, then LoadFamilyIconTileForWD09D (E-0122)
; 5 call sites from 4 routines (e.g. DrawWD789Cell5IconAndLevelAndStep, ScriptCommandED_Run_Case07_Case0F, ScriptCommandED_Run_Case04_Case04, ScriptCommandED_Run_Case12_Case09)
; reads: hTemp0, wD7F1
; writes: rRAMG2, rRAMB, wD09D, wD09E
LoadFamilyIconTileForRecordB_Bank15::
Func_015_6866:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, b
    ld c, $0D
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $0F
    ld [wD09D], a
    ld a, [wD7F1]
    ld [wD09E], a
    farcall LoadFamilyIconTileForWD09D
    xor a, a
    ld [rRAMG2], a
    ret

; record wD7F1 (bank 0): writes tile $CC + (field $0E & 1) at the address in wD7F2/3 and, three tiles on, field $56 as two digits with leading blanks (E-0121)
; 5 call sites from 5 routines (e.g. DrawWD789Cell5IconAndLevelAndStep, ScriptCommandED_Run_Case04_Case04, ScriptCommandF4_Run_Case04_Case04, Func_037_4AFD_Case04_Case04, ...)
; reads: wD7F1, wD7F2, wD7F3, hTemp0, wDigits
; writes: rRAMG2, rRAMB
DrawRecordField0EMarkAndField56Digits::
Func_015_688D:: ; address name
    ld a, [wD7F1]
    ld b, a
    ld a, [wD7F2]
    ld l, a
    ld a, [wD7F3]
    ld h, a
    push bc
    push hl
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, b
    ld c, $0E
    ld b, $01
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $01
    add a, $CC
    pop hl
    ld [hl], a
    pop bc
    push bc
    inc hl
    inc hl
    inc hl
    push hl
    ld a, b
    ld c, $56
    ld b, $01
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigitsWC8C0_Bank15
    ld a, [wDigits + $1]
    add a, $E0
    pop hl
    ld [hl+], a
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl+], a
    pop bc
    ret

; when wC8C0 is 0 it becomes $E3, and then when wC8C1 is 0 too it becomes $E3: a digit byte of $E3 turns into the blank tile $C3 once the usual $E0 digit-tile base is added, so leading zeros are blanked (E-0093) (the same 23 bytes appear in 2 banks)
; 7 call sites from 7 routines (e.g. ScriptCommandED_Run_Case04_Case27, DrawRecordField0EMarkAndField56Digits, ScriptCommandF3_Run_Case02, DrawWC838CountBoxAndStep, ...)
; reads: wDigits
; writes: wDigits
BlankLeadingZeroDigitsWC8C0_Bank15::
Func_015_68DC:: ; address name
    ld a, [wDigits]
    and a, a
    jr nz, Jump_015_68F2
    add a, $E3
    ld [wDigits], a
    ld a, [wDigits + $1]
    and a, a
    jr nz, Jump_015_68F2
    add a, $E3
    ld [wDigits + $1], a

Jump_015_68F2::
    ret

; TestBitInFieldAtWD7F3, then ORs its mask into the byte, setting bit wD7F1/wD7F2 of the field at wD7F3/wD7F4 (E-0114)
; 5 call sites from 5 routines (e.g. ScriptCommandED_Run_Case04_Case36, RunWD06AState_6C12_Case08_Case04_Sub01, ScriptCommandF4_Run_Case04_Case17, StoreReceivedRecordIntoSRAM, ...)
SetBitInFieldAtWD7F3::
Func_015_68F3:: ; address name
    call TestBitInFieldAtWD7F3
    ld a, [hl]
    or a, b
    ld [hl], a
    ret

; index = the word wD7F1/wD7F2, field = the address in wD7F3/wD7F4: wD7F5 = $FF when bit index of the field is set (bit order $80 first within each byte), else 0 (E-0074)
; 12 call sites from 9 routines (e.g. SetBitInFieldAtWD7F3, ScriptCommandED_Run_Case04_Case28, ScriptCommandED_Run_Case04_Case27, ScriptCommandED_Run_Case04_Case1C, ...)
; reads: wD7F1, wD7F2, wD7F3, wD7F4
; writes: wD7F5
TestBitInFieldAtWD7F3::
Func_015_68FA:: ; address name
    ld a, [wD7F1]
    ld e, a
    ld a, [wD7F2]
    ld d, a
    push de
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ld a, [wD7F3]
    ld l, a
    ld a, [wD7F4]
    ld h, a
    add hl, de
    pop de
    push hl
    ld a, e
    and a, $07
    ld hl, Data_015_6937
    add_a_to_hl
    ld a, [hl]
    ld b, a
    pop hl
    ld a, [hl]
    and a, b
    jr nz, Jump_015_6931
    xor a, a
    ld [wD7F5], a
    ret

Jump_015_6931::
    ld a, $FF
    ld [wD7F5], a
    ret

Data_015_6937:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $80, $40, $20, $10, $08, $04, $02, $01

; only called from routines of ScriptCommandED_Run (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommandED_Run_Case04_Case16, ScriptCommandED_Run_Case12_Case01)
; reads: wD7B9
; writes: wD7A9, rRAMG2, rRAMB, wD7B9
; points at: wD789, wD7BE, sA000, wD7F1
ScriptCommandED_Run_Shared05::
Func_015_693F:: ; address name
    ld hl, wD789
    ld b, $1E

Jump_015_6944::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_015_6944
    ld hl, wD7BE
    ld b, $1E

Jump_015_694E::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_015_694E
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

Jump_015_696D::
    ld a, [de]
    cp a, $01
    jr z, Jump_015_6978
    cp a, $02
    jr z, Jump_015_6978
    jr Jump_015_69AA

Jump_015_6978::
    push de
    ld a, $6E
    add a, e
    ld e, a
    jr nc, Jump_015_6980
    inc d

Jump_015_6980::
    ld a, [de]
    and a, a
    jr nz, Jump_015_69A2
    pop de
    push de
    ld a, $0E
    add a, e
    ld e, a
    jr nc, Jump_015_698D
    inc d

Jump_015_698D::
    ld a, [de]
    and a, $01
    push hl
    ld hl, wD7F1
    cp a, [hl]
    jr nz, Jump_015_699B
    pop hl
    pop de
    jr Jump_015_69AA

Jump_015_699B::
    pop hl
    pop de
    inc c
    ld a, b
    ld [hl+], a
    jr Jump_015_69AA

Jump_015_69A2::
    pop de
    ld a, [wD7B9]
    inc a
    ld [wD7B9], a

Jump_015_69AA::
    ld a, $A5
    add a, e
    ld e, a
    jr nc, Jump_015_69B1
    inc d

Jump_015_69B1::
    inc b
    ld a, b
    cp a, $1E
    jr c, Jump_015_696D
    ld a, c
    ld [wD7A9], a
    xor a, a
    ld [rRAMG2], a
    farcall MovePartyRecordsToFrontOfList
    ret

; with SRAM bank 0 enabled: wD7F1 = bit 0 of byte $0E of record wD7B4 (LoadSRAMRecordByte) (E-0119)
; 2 call sites from 2 routines (e.g. ScriptCommandED_Run_Case04_Case16, ScriptCommandED_Run_Case12_Case01)
; reads: wD7B4, hTemp0
; writes: rRAMG2, rRAMB, wD7F1
LoadRecordWD7B4Byte0EBit0::
Func_015_69C6:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7B4]
    ld c, $0E
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    and a, $01
    ld [wD7F1], a
    xor a, a
    ld [rRAMG2], a
    ret

; clears 4 tiles at vTiles2 + $7C0, 3 at vTiles1 + $400 and 2 at vTiles1 + $4A0 (FillTilesBxC); falls through (E-0122)
; 3 call sites from 3 routines (e.g. ScriptCommandED_Run_Case04_Case19, ScriptCommandED_Run_Case04_Case14, ScriptCommandED_Run_Case12_Case04)
ClearThreeTileRows::
Func_015_69E3:: ; address name
    ld hl, vTiles2 + $7C0
    ld bc, $0401
    call FillTilesBxC
    ld hl, vTiles1 + $400
    ld bc, $0301
    call FillTilesBxC
    ld hl, vTiles1 + $4A0
    ld bc, $0201
    call FillTilesBxC

; clears tile areas with FillTilesBxC: 9 x 1 at vTiles2 + $700, 3 x 1 at vTiles1 + $750, 2 x 1 at vTiles1 + $7D0 (E-0117)
; 2 call sites from 2 routines (e.g. ScriptCommandED_Run_Case04_Case29, ScriptCommandED_Run_Case04_Case24)
ClearTileAreas2700_1750_17D0::
Func_015_69FE:: ; address name
    ld hl, vTiles2 + $700
    ld bc, $0901
    call FillTilesBxC
    ld hl, vTiles1 + $750
    ld bc, $0301
    call FillTilesBxC
    ld hl, vTiles1 + $7D0
    ld bc, $0201
    call FillTilesBxC
    ret

; clears tile areas: 12 x 1 at vTiles1 + $240, 13 x 1 at vTiles1 + $700, 17 x 1 at vTiles1 + $4E0 (E-0117)
; 1 call site from 1 routine (e.g. ScriptCommandED_Run_Case04_Case01)
ClearTileAreas1240_1700_14E0::
Func_015_6A1A:: ; address name
    ld hl, vTiles1 + $240
    ld bc, $0C01
    call FillTilesBxC
    ld hl, vTiles1 + $700
    ld bc, $0D01
    call FillTilesBxC
    ld hl, vTiles1 + $4E0
    ld bc, $1101
    call FillTilesBxC
    ret

; record wD7F1: draws its name (field 1) as text line 2 and the name of its species (field $0B) as line 3 (Func_01D_6129) (E-0121)
; 1 call site from 1 routine (e.g. DrawWD789Cell5RecordNamesAndStep)
; reads: wD7F1, hTemp0, hTemp1
; writes: rRAMG2, rRAMB, wNameGlyphBuf, wD7F5
DrawRecordNameAndSpeciesName::
Func_015_6A36:: ; address name
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
    ld [wNameGlyphBuf + $A], a
    xor a, a
    ld c, a
    ld a, $02
    ld [wD7F5], a
    farcall DrawWC8CFGlyphsOverlaying8DAnd8E_Bank1D
    pop bc
    push bc
    ld a, b
    ld c, $0B
    ld b, $02
    call LoadSRAMRecordWord
    ldh a, [hTemp0]
    ld l, a
    ldh a, [hTemp1]
    ld h, a
    call CopyMonsterNameToBuffer_B15
    xor a, a
    ld c, a
    ld a, $03
    ld [wD7F5], a
    farcall DrawWC8CFGlyphsOverlaying8DAnd8E_Bank1D
    pop bc
    xor a, a
    ld [rRAMG2], a
    ret

; only called from routines of ScriptCommandED_Run (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommandED_Run_Case04_Case1B, ScriptCommandED_Run_Case12_Case07)
; reads: wD7B4, wD7F5, wD7F6
; writes: rRAMG2, rRAMB
; points at: sA000, wRecordBufA, wRecordBufB
ScriptCommandED_Run_Shared06::
Func_015_6A82:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld a, [wD7B4]
    ld c, $A5
    call Multiply8
    ld de, sA000
    add hl, de
    ld de, wRecordBufA
    ld b, $A5

Jump_015_6A9C::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_015_6A9C
    farcall SetWD7F5ToWD789Cell5
    ld a, [wD7F5]
    ld h, a
    ld a, [wD7F6]
    ld l, a
    ld a, [hl]
    ld c, $A5
    call Multiply8
    ld de, sA000
    add hl, de
    ld de, wRecordBufB
    ld b, $A5

Jump_015_6ABF::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_015_6ABF
    xor a, a
    ld [rRAMG2], a
    ret

; HL = string number; copies 16 bytes of that string of StringTable_MonsterNames (bank $08, via wDataBank) to wC8CF; wDataBank is restored
; 4 call sites from 4 routines (e.g. ScriptCommandED_Run_Case04_Case27, DrawRecordNameAndSpeciesName, ScriptCommandED_Run_Case0B_Case06, ScriptCommandED_Run_Case04_Case1C)
; reads: wDataBank
; writes: wDataBank
; points at: wNameGlyphBuf
CopyMonsterNameToBuffer_B15::
Func_015_6ACA:: ; address name
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

; clears the text tiles and, when the save is valid, shows the save details (player name, play time, party) from SRAM in the window (E-0131)
; 3 call sites from 3 routines (e.g. ScriptCommandED_Run_Case04_Case2B, ScriptCommandF2_Run_Case03_Case0A, Func_0F0_4CA0_Table4_Case02)
; reads: hTemp0, wDigits
; writes: wStringCategory, wStringIndex, wD782, rRAMG2, rRAMB, wNameGlyphBuf, wD7F3, wD7F4, ...
; points at: wTextWindowTileLo, sBB0F, wNameGlyphBuf, wDigits, sBB01, sBE0D, sBD36, sBC0A, ...
ShowSaveFileInfoWindow::
Func_015_6B00:: ; address name
    ld hl, vTiles1 + $240
    ld bc, $0901
    call FillTilesBxC
    ld hl, vTiles1 + $470
    ld bc, $0301
    call FillTilesBxC
    ld hl, vTiles1 + $500
    ld bc, $0F01
    call FillTilesBxC
    ld hl, vTiles1 + $700
    ld bc, $0D01
    call FillTilesBxC
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    farcall CheckSaveData
    ldh a, [hTemp0]
    or a, a
    jr z, Jump_015_6B6B
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $8D
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $0F
    xor a, a
    ld [wStringCategory], a
    ld a, $28
    ld [wStringIndex], a
    farcall ShowString_Bank1B_4C94
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    ld a, $01
    ld [wD782], a
    ret

Jump_015_6B6B::
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld de, Data_015_71A1
    ld hl, wWindowTileBuffer + $64
    ld bc, $140B
    call CopyRectTo20ByteRows_Bank15
    ld hl, sBB0F
    ld de, $022B
    add hl, de
    ld a, [hl]
    and a, a
    jr z, Jump_015_6BA1
    ld hl, Data_015_763B
    ld de, vTiles2 + $6F0
    call CopyTileBytesToVRAM_Bank15
    ld a, $6F
    ld hl, wWindowTileBuffer + $B0
    ld [hl+], a
    ld [hl], a
    ld hl, wWindowTileBuffer + $C4
    ld [hl+], a
    ld [hl], a

Jump_015_6BA1::
    ld hl, sBB0F
    ld de, wNameGlyphBuf
    ld c, $0A

Jump_015_6BA9::
    ld a, [hl]
    cp a, $F0
    jr z, Jump_015_6BB4
    ld [de], a
    inc hl
    inc de
    dec c
    jr nz, Jump_015_6BA9

Jump_015_6BB4::
    ld a, $F0
    ld [de], a
    ld de, vTiles1 + $280
    call CopyGlyphTilesToVRAM
    ld a, $16
    ld [wNameGlyphBuf], a
    ld a, $24
    ld [wNameGlyphBuf + $1], a
    ld a, $36
    ld [wNameGlyphBuf + $2], a
    ld a, $37
    ld [wNameGlyphBuf + $3], a
    ld a, $F0
    ld [wNameGlyphBuf + $4], a
    ld de, vTiles1 + $240
    call CopyGlyphTilesToVRAM
    ld a, $28
    ld [wNameGlyphBuf], a
    ld a, $35
    ld [wNameGlyphBuf + $1], a
    ld a, $F0
    ld [wNameGlyphBuf + $2], a
    ld de, vTiles2 + $780
    call CopyGlyphTilesToVRAM
    ld hl, sBB0F
    ld a, $F1
    add_a_to_hl
    ld b, [hl]
    ld hl, sBB0F
    ld a, $F2
    add_a_to_hl
    ld c, $00
    xor a, a
    ld [rRAMG2], a

Jump_015_6C0C::
    push hl
    push bc
    call SRAMBank1RecordAddress
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    ld a, $01
    ld [wD7F2], a
    farcall LoadRecordNameEntry0
    pop bc
    push bc
    ld a, c
    add a, a
    ld hl, Data_015_6E0E
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    call CopyGlyphTilesToVRAM
    pop bc
    pop hl
    inc c
    ld a, c
    cp a, b
    jr c, Jump_015_6C0C
    ld c, $00

Jump_015_6C3F::
    push hl
    push bc
    call SRAMBank1RecordAddress
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld a, [hl]
    and a, $0F
    ld [wD09D], a
    xor a, a
    ld [rRAMG2], a
    pop bc
    push bc
    ld a, c
    add a, $C7
    ld [wD09E], a
    farcall LoadFamilyIconTileForWD09D
    pop bc
    pop hl
    inc c
    ld a, c
    cp a, b
    jr c, Jump_015_6C3F
    ld c, $00

Jump_015_6C6F::
    push hl
    push bc
    call SRAMBank1RecordAddress
    ld a, $62
    add_a_to_hl
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld a, [hl]
    and a, $7F
    ld l, a
    ld h, $00
    xor a, a
    ld [rRAMG2], a
    call HLToDecimalDigits
    pop bc
    push bc
    ld a, c
    add a, a
    ld hl, Data_015_6E08
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    ld a, [wDigits + $1]
    and a, a
    jr z, Jump_015_6CB4
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $1]
    add a, $E0
    ld [hl], a
    ei
    inc hl

Jump_015_6CB4::
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    ei
    pop bc
    pop hl
    inc c
    ld a, c
    cp a, b
    jr c, Jump_015_6C6F
    ld c, $00

Jump_015_6CC8::
    push hl
    push bc
    ld hl, Data_015_6DD0
    ld a, c
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    di
    call WaitForVRAMAccess
    ld a, $EA
    ld [de], a
    ei
    inc de
    di
    call WaitForVRAMAccess
    ld a, $ED
    ld [de], a
    ei
    pop bc
    pop hl
    inc c
    ld a, c
    cp a, b
    jr c, Jump_015_6CC8
    ld hl, sBB0F
    ld de, $0221
    add hl, de
    push hl
    inc hl
    inc hl
    inc hl
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    call HLToDecimalDigits
    ld hl, wWindowTileBuffer + $85
    ld c, $00
    ld de, wDigits
    ld b, $03
    call WriteDigitTilesFromDEToVRAM
    pop hl
    inc hl
    inc hl
    ld a, [hl]
    ld l, a
    ld h, $00
    xor a, a
    ld [rRAMG2], a
    call HLToDecimalDigits
    ld hl, wWindowTileBuffer + $89
    ld c, $00
    ld de, wDigits + $1
    ld b, $02
    call WriteDigitTilesFromDEToVRAM
    ld hl, sBB01
    ld a, $06
    add_a_to_hl
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld a, [hl]
    add a, $0A
    cp a, $0D
    jr nz, Jump_015_6D9A
    ld hl, sBE0D
    ld a, [hl]
    bit 7, a
    jr z, Jump_015_6D98
    ld hl, sBD36
    ld a, [hl]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld de, sBC0A
    add hl, de
    inc hl
    ld de, wTextBuf0
    ld a, [hl+]
    inc a
    push hl
    call CopyKeyNameWordToDE
    pop hl
    dec de
    ld a, [hl]
    add a, $11
    call CopyKeyNameWordToDE
    dec de
    ld a, $F0
    ld [de], a
    ld a, $08
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $8F
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $0D
    farcall ShowString_Bank08
    jr Jump_015_6DB4

Jump_015_6D98::
    ld a, $0D

Jump_015_6D9A::
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $8F
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    ld [hl], $0D
    farcall ShowString_Bank08

Jump_015_6DB4::
    xor a, a
    ld [rRAMB], a
    ld [rRAMG2], a
    call DecompressGraphicsA4ToTiles0
    ld hl, wTextWindowTileLo
    xor a, a
    ld [hl+], a
    ld a, $88
    ld [hl+], a
    ld a, $02
    ld [hl+], a
    ld [hl], $12
    xor a, a
    ld [wD782], a
    ret

Data_015_6DD0:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A8, $C3, $D0, $C3, $F8, $C3

; writes the digits at DE as tiles $E0 + digit to HL (WaitForVRAMAccess, interrupts off), counting C up to B (E-0117)
; 2 call sites from 1 routine (e.g. ShowSaveFileInfoWindow)
WriteDigitTilesFromDEToVRAM::
Func_015_6DD6:: ; address name
    di
    call WaitForVRAMAccess
    ld a, [de]
    add a, $E0
    ld [hl+], a
    ei
    inc de
    inc c
    ld a, c
    cp a, b
    jr c, WriteDigitTilesFromDEToVRAM
    ret

; with SRAM bank 1 selected, HL = sA06F + $6F * [HL + C] (a $6F-byte record in bank 1); then selects bank 0 and disables SRAM (E-0117)
; 3 call sites from 1 routine (e.g. ShowSaveFileInfoWindow)
; writes: rRAMG2, rRAMB
; points at: sA06F
SRAMBank1RecordAddress::
Func_015_6DE6:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    ld a, $01
    ld [rRAMB], a
    ld a, c
    add_a_to_hl
    ld a, [hl]
    ld c, $6F
    call Multiply8
    ld de, sA06F
    add hl, de
    xor a, a
    ld [rRAMB], a
    ld [rRAMG2], a
    ret

Data_015_6E08:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $AA, $C3, $D2, $C3, $FA, $C3

Data_015_6E0E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $8D, $50, $8D, $A0, $8D

; restores the player position, facing, wFollowerRecords, wC8F0-wC8FB and wCB86 from wC937-wC943 and clears wC936 (E-0121)
; 2 call sites from 2 routines (e.g. ScriptCommandED_Run_Case07_Case02, ScriptCommandED_Run_Case07_Case00)
; reads: wSavedPlayerState
; writes: hPlayerX, hPlayerY, hPlayerFacing, wFollowerRecords, wSpriteSlots, wSavedPositionValid
RestorePlayerPositionState::
Func_015_6E14:: ; address name
    ld a, [wSavedPlayerState + $1]
    ldh [hPlayerX], a
    ld a, [wSavedPlayerState + $2]
    ldh [hPlayerY], a
    ld a, [wSavedPlayerState + $3]
    ldh [hPlayerFacing], a
    ld a, [wSavedPlayerState + $4]
    ld [wFollowerRecords], a
    ld a, [wSavedPlayerState + $5]
    ld [wFollowerRecords + $1], a
    ld a, [wSavedPlayerState + $6]
    ld [wFollowerRecords + $2], a
    ld a, [wSavedPlayerState + $7]
    ld [wFollowerRecords + $5], a
    ld a, [wSavedPlayerState + $8]
    ld [wFollowerRecords + $6], a
    ld a, [wSavedPlayerState + $9]
    ld [wFollowerRecords + $7], a
    ld a, [wSavedPlayerState + $A]
    ld [wFollowerRecords + $A], a
    ld a, [wSavedPlayerState + $B]
    ld [wFollowerRecords + $B], a
    ld a, [wSavedPlayerState + $C]
    ld [wFollowerRecords + $C], a
    ld a, [wSavedPlayerState]
    ld [wSpriteSlots + $7], a
    xor a, a
    ld [wSavedPositionValid], a
    ret

; for each of the pointers wCF8B and wCF8E (when set): increments the byte it points to, up to 99, and stores wCF8D / wCF90 in the byte before (E-0125)
; 3 call sites from 3 routines (e.g. ScriptCommandED_Run_Case04_Case36, ScriptCommandF4_Run_Case04_Case17, RunWD780StateWhenNotFading_F1_Case04_Case1E)
; reads: wCF8C, wCF8B, wCF8D, wCF8F, wCF8E, wCF90
; points at: wCF8B, wCF8E
IncrementTwoCountersCappedAt99::
Func_015_6E64:: ; address name
    ld a, [wCF8C]
    cp a, $FF
    jr z, Jump_015_6E86
    ld b, a
    ld a, [wCF8B]
    or a, b
    and a, a
    jr z, Jump_015_6E86
    ld de, wCF8B
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [hl]
    cp a, $63
    jr nc, Jump_015_6E86
    inc a
    ld [hl-], a
    ld a, [wCF8D]
    ld [hl], a

Jump_015_6E86::
    ld a, [wCF8F]
    cp a, $FF
    ret z
    ld b, a
    ld a, [wCF8E]
    or a, b
    ret z
    ld de, wCF8E
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [hl]
    cp a, $63
    ret nc
    inc a
    ld [hl-], a
    ld a, [wCF90]
    ld [hl], a
    ret

; clears wCF8B-wCF90, fills them through Func_015_6EFD for wCA2A and (outside link battles) wCACF, wTwoChoiceCursor = wD7F1, wD782 += 1 and requests script $80 (E-0125)
; 3 call sites from 3 routines (e.g. ScriptCommandED_Run_Case04_Case29, ScriptCommandF4_Run_Case04_Case12, RunWD780StateWhenNotFading_F1_Case04_Case19)
; reads: wRecordBufA, wLinkMode, wRecordBufB, wD7F1, wD782
; writes: wCF8B, wCF8C, wCF8D, wCF8E, wCF8F, wCF90, rRAMG, rRAMB, ...
; points at: wCF8B, wCF8E
PrepareWCF8BCountersAndRequestScript::
Func_015_6EA5:: ; address name
    xor a, a
    ld [wCF8B], a
    ld [wCF8C], a
    ld [wCF8D], a
    ld [wCF8E], a
    ld [wCF8F], a
    ld [wCF90], a
    ld a, $0A
    ld [rRAMG], a
    xor a, a
    ld [rRAMB], a
    xor a, a
    ld [wD7F1], a
    ld de, wCF8B
    ld a, [wRecordBufA + $A4]
    and a, a
    call nz, PrepareWCF8BCountersAndRequestScript_Sub01
    ld a, [wLinkMode]
    and a, a
    jr nz, Jump_015_6EDF
    ld de, wCF8E
    ld a, [wRecordBufB + $A4]
    and a, a
    call nz, PrepareWCF8BCountersAndRequestScript_Sub01

Jump_015_6EDF::
    xor a, a
    ld [rRAMG], a
    ld [rRAMB], a
    ld a, [wD7F1]
    ld [wTwoChoiceCursor], a
    ld a, [wD782]
    inc a
    ld [wD782], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from PrepareWCF8BCountersAndRequestScript (E-0047)
; 2 call sites from 1 routine (e.g. PrepareWCF8BCountersAndRequestScript)
; reads: wD7F1, hTemp0, wCF8D, wCF8B, wCF8C
; writes: hTemp0, wD7F1
; points at: wItemStorage, wCF8B
PrepareWCF8BCountersAndRequestScript_Sub01::
Func_015_6EFD:: ; address name
    add a, $3F
    ldh [hTemp0], a
    ld c, a
    ld hl, wItemStorage
    ld b, $64

Jump_015_6F07::
    ld a, [hl+]
    cp a, c
    jr z, Jump_015_6F14
    and a, a
    jr z, Jump_015_6F1B

Jump_015_6F0E::
    inc hl
    dec b
    jr nz, Jump_015_6F07
    jr Jump_015_6F5C

Jump_015_6F14::
    ld a, [hl]
    cp a, $63
    jr c, Jump_015_6F45
    jr Jump_015_6F5C

Jump_015_6F1B::
    push hl
    ld hl, wCF8B
    ld a, l
    cp a, e
    jr nz, Jump_015_6F2A
    ld a, h
    cp a, d
    jr nz, Jump_015_6F2A
    pop hl
    jr Jump_015_6F45

Jump_015_6F2A::
    ld a, [wCF8D]
    ld l, a
    ldh a, [hTemp0]
    cp a, l
    jr z, Jump_015_6F44
    pop hl
    push hl
    ld a, [wCF8B]
    cp a, l
    jr nz, Jump_015_6F44
    ld a, [wCF8C]
    cp a, h
    jr nz, Jump_015_6F44
    pop hl
    jr Jump_015_6F0E

Jump_015_6F44::
    pop hl

Jump_015_6F45::
    ldh a, [hTemp0]
    push af
    push de
    push hl
    pop hl
    pop de
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    inc de
    pop af
    ld [de], a
    jr Jump_015_6F56

Jump_015_6F56::
    ld a, $01
    ld [wD7F1], a
    ret

Jump_015_6F5C::
    ld a, $FF
    ld [de], a
    inc de
    ld [de], a
    ld a, [wD7F1]
    and a, a
    ret nz
    xor a, a
    ld [wD7F1], a
    ret

Data_015_6F6B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $A4, $A5, $EE, $EE, $A6, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $A7, $A8, $A9, $AA, $AB, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $AC, $AD, $AE, $A9, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_015_6FA3:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_015_6FDB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $056FDB, $75

Data_015_7050:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $057050, $75

Data_015_70C5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0
    ds $12, $B1
    db $B2, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B6
    ds $12, $C3
    db $B7, $B3
    ds $12, $B4
    db $B5

Data_015_71A1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0
    ds $12, $B1
    db $B2, $B6, $A4, $A5, $A6, $A7, $78, $79, $ED, $A8, $A9, $AA, $AB, $AC, $C3, $C3
    db $C3, $ED, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C7, $D0, $D1, $D2, $D3, $D4, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C8, $D5, $D6, $D7, $D8, $D9, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C9, $DA, $DB, $DC, $DD, $DE, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $F8, $F9, $FA, $FB, $FC, $C3
    db $C3, $C3, $C3, $C3, $B7, $B3
    ds $12, $B4
    db $B5

Data_015_727D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B6, $C3, $C3, $C3, $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $D9, $DA, $DB
    db $DC, $DD, $DE, $B7

Data_015_7291:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $BF, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_015_72A9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $8A, $50, $8A, $60, $8A, $70, $8A, $80, $8A, $90, $8A, $A0, $8A, $B0, $8A
    db $C0, $8A, $D0, $8A, $E0, $8A, $E0, $8E, $F0, $8E, $FF, $FF

Data_015_72C5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C0, $40, $60, $43, $80, $42, $20, $41, $50, $42, $80, $43, $70, $42, $C0, $42
    db $F0, $40, $C0, $43, $D0, $42, $90, $42, $10, $49, $FF, $FF

Data_015_72E1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $97, $10, $97, $20, $97, $30, $97, $40, $97, $50, $97, $60, $97, $FF, $FF

Data_015_72F1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $30, $41, $20, $43, $A0, $42, $30, $43, $90, $41, $50, $41, $FF, $FF

Data_015_72FF:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $30, $41, $80, $41, $00, $41, $90, $41, $E0, $41, $F0, $40, $D0, $41, $50, $41
    db $60, $41, $A0, $41, $B0, $40, $10, $49, $10, $49, $FF, $FF

Data_015_731B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $8C, $10, $8C, $20, $8C, $70, $8C, $80, $8C, $90, $8C, $A0, $8C, $B0, $8C
    db $FF, $FF

Data_015_732D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $79, $C3, $A1, $C3, $C9, $C3

Data_015_7333:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D0, $C3, $F8, $C3, $20, $C4, $48, $C4

Data_015_733B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $27, $C4, $4F, $C4

Data_015_733F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $B7, $C3, $B7, $B4, $B5

Data_015_7345:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $C3, $B7, $C3, $C3, $C3, $B7, $B4, $B4, $B4, $B5

Data_015_7351:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $C3, $70, $71, $72, $73, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $74, $75, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_015_7379:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_015_73A1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $79, $C3, $A1, $C3, $C9, $C3, $F1, $C3, $19, $C4

Data_015_73AB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $CE, $CF, $DF, $B7, $B6, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $77, $73, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B5

Data_015_73C9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $0573C9, $48

Data_015_7411:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $057411, $60

Data_015_7471:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_015_747D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $05747D, $58

Data_015_74D5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $F8, $F9, $FA
    db $FB, $FC, $C3, $EA, $ED, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $B7, $B6, $C7, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B7

Data_015_7505:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA

Data_015_7511:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_015_7541:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9
    db $B9, $B9, $B9, $BA

Data_015_7565:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C9, $7C, $7D
    db $7E, $7F, $C0, $C1, $C2, $CA, $CB, $B7, $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9
    db $B9, $B9, $B9, $BA

Data_015_7589:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA, $B6, $F5, $F6, $F7
    db $FD, $FE, $C3, $EA, $ED, $C3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $B7, $B6, $FF, $77, $78, $70, $71, $72, $73, $74, $75, $76, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_015_75C5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $FF, $FF, $DC, $00, $0F, $FF, $FF, $F1, $01, $FF, $FF, $3F, $36, $3F, $FF, $E2
    db $88, $07, $FF, $FF, $C3, $00, $FF, $FF, $FC, $40, $1F, $FF, $FE, $F8, $83, $FF
    db $FE, $63, $00, $7F, $FB, $F9, $F9, $0F, $FF, $FF, $C4, $30, $00, $00, $00, $00

Data_015_75F5:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B9, $B9, $B9, $B9, $B9, $B9, $B9, $BA, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7
    db $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_015_761D:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $C3, $C3, $C3, $C3, $C3, $B7, $C3, $C3, $C3, $C3, $C3, $B7, $B4, $B4, $B4, $B4
    db $B4, $B5, $72, $73, $74, $75, $76, $B7, $B4, $B4, $B4, $B4, $B4, $B5

Data_015_763B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $05763B, $171

; only called from routines of ScriptCommandEB_Run (E-0098)
; 2 call sites from 2 routines (e.g. ScriptCommandEB_Run_Case05_Case02, ScriptCommandEB_Run_Case04_Case3C)
; writes: wD7A9, rRAMG2, rRAMB
; points at: wD789, sB356, sA000
ScriptCommandEB_Run_Shared06::
Func_015_77AC:: ; address name
    ld hl, wD789
    ld b, $1E

Jump_015_77B1::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_015_77B1
    xor a, a
    ld [wD7A9], a
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld de, sB356
    ld hl, wD789
    ld b, $00
    ld c, $00

Jump_015_77CD::
    ld a, [de]
    bit 7, a
    jr z, Jump_015_77D5
    inc c
    ld a, b
    ld [hl+], a

Jump_015_77D5::
    ld a, $6F
    add a, e
    ld e, a
    jr nc, Jump_015_77DC
    inc d

Jump_015_77DC::
    inc b
    ld a, b
    cp a, $1D
    jr c, Jump_015_77CD
    ld de, sA000
    ld a, $01
    ld [rRAMB], a
    ld a, [de]
    bit 7, a
    jr z, Jump_015_77F2
    inc c
    ld a, b
    ld [hl+], a

Jump_015_77F2::
    ld a, c
    ld [wD7A9], a
    xor a, a
    ld [rRAMG2], a
    ret

; only called from ScriptCommandEB_Run_Case05_Case03 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandEB_Run_Case05_Case03)
; reads: wD7AF, wD7B1, wD7A9, wD781, wD7B0
; writes: rRAMG2, rRAMB, wD7F1, wD7F2, wD7F3, wD7F4, wNameGlyphBuf, wD781
; points at: wD789, sB356, sA000
ScriptCommandEB_Run_Case05_Case03_Sub01::
Func_015_77FB:: ; address name
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a
    ld hl, wD789
    ld a, [wD7AF]
    ld b, a
    sla a
    sla a
    add a, b
    add_a_to_hl
    ld c, $00

Jump_015_7817::
    ld a, [wD7B1]
    cp a, $04
    jr c, Jump_015_7823
    ld a, [wD7A9]
    jr Jump_015_7832

Jump_015_7823::
    ld a, [wD7B0]
    cp a, $01
    jr nz, Jump_015_782F
    ld a, [wD7A9]
    jr Jump_015_7832

Jump_015_782F::
    ld a, [wD7A9]

Jump_015_7832::
    ld b, a
    ld a, [wD7AF]
    push bc
    ld c, a
    sla a
    sla a
    add a, c
    pop bc
    add a, c
    cp a, b
    jr nc, Jump_015_78AF
    push hl
    push bc
    xor a, a
    ld [wD7F1], a
    ld a, [hl]
    cp a, $1D
    jr z, Jump_015_7864
    ld c, $6F
    call Multiply8
    ld de, sB356
    add hl, de
    xor a, a
    ld [wD7F2], a

Jump_015_785A::
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    jr Jump_015_7876

Jump_015_7864::
    ld a, $01
    ld [wD7F2], a
    ld hl, sA000
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    jr Jump_015_785A

Jump_015_7876::
    farcall LoadRecordNameEntry0
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    pop bc
    push bc
    ld a, c
    cp a, $04
    jr nz, Jump_015_788D
    call ScriptCommandEB_Run_Case05_Case03_Sub01_Sub01
    jr Jump_015_789F

Jump_015_788D::
    ld a, c
    sla a
    ld hl, Data_015_78BB
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    call CopyGlyphTilesToVRAM

Jump_015_789F::
    pop bc
    pop hl
    inc hl
    inc c
    ld a, [wD7A9]
    cp a, c
    jr z, Jump_015_78AF
    ld a, c
    cp a, $05
    jp c, Jump_015_7817

Jump_015_78AF::
    xor a, a
    ld [rRAMG2], a
    ld a, [wD781]
    inc a
    ld [wD781], a
    ret

Data_015_78BB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $8D, $50, $8D, $A0, $8D, $00, $8F, $40, $8A

; only called from ScriptCommandEB_Run_Case05_Case03_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandEB_Run_Case05_Case03_Sub01)
; reads: wD784, wD785
; writes: wD784, wD785
; points at: wNameGlyphBuf
ScriptCommandEB_Run_Case05_Case03_Sub01_Sub01::
Func_015_78C5:: ; address name
    xor a, a
    ld [wD784], a
    ld [wD785], a
    ld hl, wNameGlyphBuf

Jump_015_78CF::
    ld a, [wD784]
    push hl
    add_a_to_hl
    ld a, [hl]
    cp a, $F0
    jp z, Jump_015_790E
    cp a, $8D
    jr z, Jump_015_78EE
    cp a, $8E
    jr z, Jump_015_78EE
    call GlyphCopyArgsForA_Bank15
    call CopyFromBankWaitVRAM
    jr Jump_015_78FD

Jump_015_78EE::
    push af
    ld a, [wD785]
    dec a
    ld [wD785], a
    pop af
    call GlyphCopyArgsForA_Bank15
    call OrFromBankWaitVRAM

Jump_015_78FD::
    pop hl
    ld a, [wD785]
    inc a
    ld [wD785], a
    ld a, [wD784]
    inc a
    ld [wD784], a
    jr Jump_015_78CF

Jump_015_790E::
    pop hl
    xor a, a
    ld [wD785], a
    ld [wD784], a
    ret

; DE = $4010 + 16 * A (the glyph's tile), HL = the VRAM address from Data_015_794A + 2 * wD785, B = $1F (bank), C = 16 (bytes) (E-0121)
; 2 call sites from 1 routine (e.g. ScriptCommandEB_Run_Case05_Case03_Sub01_Sub01)
; reads: wD785
GlyphCopyArgsForA_Bank15::
Func_015_7917:: ; address name
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    ld hl, $4010
    add hl, de
    ld e, l
    ld d, h
    push de
    ld hl, Data_015_794A
    ld a, [wD785]
    sla a
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld h, d
    ld l, e
    pop de
    ld b, $1F
    ld c, $10
    ret

Data_015_794A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $8A, $50, $8A, $60, $8A, $E0, $8C, $F0, $8C

; wD09D = the family nibble of the record selected by wD7F1 (Func_015_7A43), wD09E = $C7, then LoadFamilyIconTileForWD09D (E-0122)
; 1 call site from 1 routine (e.g. ScriptCommandEB_Run_Case05_Case04)
; reads: wD7F1
; writes: rRAMG2, wD09D, wD09E
LoadFamilyIconTileForWD7F1Record::
Func_015_7954:: ; address name
    ld a, [wD7F1]
    ld b, a
    ld a, $0A
    ld [rRAMG2], a
    call RecordAddressWithBank1Slot1D
    ld a, [hl]
    and a, $0F
    ld [wD09D], a
    ld a, $C7
    ld [wD09E], a
    farcall LoadFamilyIconTileForWD09D
    xor a, a
    ld [rRAMG2], a
    ret

; only called from ScriptCommandEB_Run_Case05_Case04 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandEB_Run_Case05_Case04)
; reads: wD7F1, wDigits
; writes: rRAMG2, wWindowTileBuffer, wD7F1, wD7F3, wD7F5, wD7F7, wD7F2, wD7F4, ...
; points at: wD7F1
ScriptCommandEB_Run_Case05_Case04_Sub01::
Func_015_7976:: ; address name
    ld a, [wD7F1]
    ld b, a
    ld a, $0A
    ld [rRAMG2], a
    call RecordAddressWithBank1Slot1D
    push hl
    inc hl
    ld a, [hl]
    and a, $08
    sla a
    swap a
    pop hl
    add a, $CC
    ld [wWindowTileBuffer + $86], a
    push hl
    ld a, $62
    add_a_to_hl
    ld a, [hl]
    and a, $7F
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BlankLeadingZeroDigitsWC8C0_Bank15_7ADB
    ld a, [wDigits + $1]
    add a, $E0
    ld [wWindowTileBuffer + $89], a
    ld a, [wDigits + $2]
    add a, $E0
    ld [wWindowTileBuffer + $8A], a
    pop hl
    push hl
    ld a, $57
    add_a_to_hl
    ld a, [hl+]
    ld [wD7F1], a
    ld a, [hl+]
    ld [wD7F3], a
    ld a, [hl+]
    ld [wD7F5], a
    ld a, [hl+]
    ld [wD7F7], a
    ld a, [hl]
    and a, $C0
    srl a
    srl a
    swap a
    ld [wD7F2], a
    ld a, [hl]
    and a, $30
    swap a
    ld [wD7F4], a
    ld a, [hl]
    and a, $0C
    srl a
    srl a
    ld [wD7F6], a
    ld a, [hl]
    and a, $03
    ld [wD7F8], a
    pop hl
    ld c, $00

Jump_015_79F5::
    push bc
    ld a, c
    sla a
    ld de, wD7F1
    add a, e
    ld e, a
    jr nc, Jump_015_7A01
    inc d

Jump_015_7A01::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    call HLToDecimalDigits
    call BlankLeadingZeroDigitsWC8C0_Bank15_7ADB
    pop bc
    ld a, c
    sla a
    ld hl, Data_015_7A3B
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    ld a, [wDigits]
    add a, $E0
    ld [de], a
    inc de
    ld a, [wDigits + $1]
    add a, $E0
    ld [de], a
    inc de
    ld a, [wDigits + $2]
    add a, $E0
    ld [de], a
    inc c
    ld a, c
    cp a, $04
    jr c, Jump_015_79F5
    xor a, a
    ld [rRAMG2], a
    ret

Data_015_7A3B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $D4, $C3, $D8, $C3, $FC, $C3, $00, $C4

; HL = sB356 + $6F * B in SRAM bank 0, except record $1D, which is at sA000 in SRAM bank 1 (E-0122)
; 3 call sites from 3 routines (e.g. ScriptCommandEB_Run_Case05_Case04_Sub01, LoadFamilyIconTileForWD7F1Record, ScriptCommandEB_Run_Case05_Case06_Sub01)
; writes: rRAMB
; points at: sB356, sA000
RecordAddressWithBank1Slot1D::
Func_015_7A43:: ; address name
    ld a, b
    cp a, $1D
    jr z, Jump_015_7A56
    ld c, $6F
    call Multiply8
    ld de, sB356
    add hl, de
    xor a, a
    ld [rRAMB], a
    ret

Jump_015_7A56::
    ld hl, sA000
    ld a, $01
    ld [rRAMB], a
    ret

; only called from ScriptCommandEB_Run_Case05_Case06 (E-0047)
; 1 call site from 1 routine (e.g. ScriptCommandEB_Run_Case05_Case06)
; reads: wD7F1, wDataBank
; writes: rRAMG2, wD7F2, wD7F1, wD7F3, wD7F4, wNameGlyphBuf, wDataBank
; points at: wNameGlyphBuf
ScriptCommandEB_Run_Case05_Case06_Sub01::
Func_015_7A5F:: ; address name
    ld a, [wD7F1]
    ld b, a
    ld a, $0A
    ld [rRAMG2], a
    call RecordAddressWithBank1Slot1D
    push hl
    ld [wD7F2], a
    xor a, a
    ld [wD7F1], a
    ld a, l
    ld [wD7F3], a
    ld a, h
    ld [wD7F4], a
    farcall LoadRecordNameEntry0
    ld a, $F0
    ld [wNameGlyphBuf + $A], a
    ld de, vTiles1 + $780
    call CopyGlyphTilesToVRAM
    pop hl
    inc hl
    ld a, [hl+]
    and a, $01
    ld e, a
    ld a, [hl]
    ld l, a
    ld a, e
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
    ld de, vTiles1 + $270
    call CopyGlyphTilesToVRAM
    xor a, a
    ld [rRAMG2], a
    ret

; when wC8C0 is 0 it becomes $E3, and then when wC8C1 is 0 too it becomes $E3: a digit byte of $E3 turns into the blank tile $C3 once the usual $E0 digit-tile base is added, so leading zeros are blanked (E-0093) (the same 23 bytes appear in 2 banks)
; 2 call sites from 1 routine (e.g. ScriptCommandEB_Run_Case05_Case04_Sub01)
; reads: wDigits
; writes: wDigits
BlankLeadingZeroDigitsWC8C0_Bank15_7ADB::
Func_015_7ADB:: ; address name
    ld a, [wDigits]
    and a, a
    jr nz, Jump_015_7AF1
    add a, $E3
    ld [wDigits], a
    ld a, [wDigits + $1]
    and a, a
    jr nz, Jump_015_7AF1
    add a, $E3
    ld [wDigits + $1], a

Jump_015_7AF1::
    ret
    ds $50E, $00
