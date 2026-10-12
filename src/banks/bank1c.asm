SECTION "Bank 1C", ROMX[$4000], BANK[$1C]
    db $1C

; implements script command type E1 (SCRIPT_INN_CLOSE): ends the inn session and clears wMessageMode; reached through ScriptCommandE1 in bank $10 (E-0038, E-0244)
; 1 call site from 1 routine (e.g. ScriptCommandE1)
; reads: wIsCGB
; writes: wMessageMode, wScreenState, wMenuState, wFadeMode, wScriptCommandType, wScriptStartRequest
; points at: wScreenTileBuffer, wScreenAttrBuffer, wWindowTileBuffer, wWindowAttrBuffer, wScreenState
CloseInnMenu::
Func_01C_4001:: ; address name
    ld hl, wScreenTileBuffer
    ld de, wWindowTileBuffer + $A0
    ld bc, $00A0
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01C_401F
    ld hl, wScreenAttrBuffer
    ld de, wWindowAttrBuffer + $A0
    ld bc, $00A0
    call CopyLow3BitsToWRAMBank2_Bank1C

Jump_01C_401F::
    ld hl, wWindowTileBuffer
    ld de, wWindowTileBuffer + $A0
    ld bc, $00A0
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01C_403D
    ld hl, wWindowAttrBuffer
    ld de, wWindowAttrBuffer + $A0
    ld bc, $00A0
    call CopyLow3BitsToWRAMBank2_Bank1C

Jump_01C_403D::
    call BGMapAddressAtScroll_Bank1C
    ld bc, $1408
    ld de, $0168
    call DrawScreenBufferRectToBGMap_1C
    ld bc, $001A
    ld hl, wScreenState

Jump_01C_404F::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01C_404F
    farcall WritePlayerNameWithFlag0SuffixToTextBuf0
    xor a, a
    ld [wMessageMode], a
    ld [wScreenState], a
    ld [wMenuState], a
    ld a, $07
    ld [wFadeMode], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type E0 (SCRIPT_INN): the inn: 'It's 0G a night. Will you...', 'Good morning and farewell!' (mode 1, bank $F0 strings); reached through ScriptCommandE0 in bank $10 (E-0038, E-0244)
; 1 call site from 1 routine (e.g. ScriptCommandE0)
; reads: wScreenState
InnMenu::
Func_01C_4075:: ; address name
    ld a, [wScreenState]
    rst $00
    dw InnMenu_Case00
    dw InnMenu_Case01
    dw InnMenu_Case02
    dw InnMenu_Case03
    dw InnMenu_Case04
    dw InnMenu_Case05
    dw InnMenu_Case06
    dw InnMenu_Case07
    dw InnMenu_Case08

; entry 0 of the `rst $00` table in InnMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wMessageMode, wScriptCommandType, wScriptStartRequest
; points at: wScreenState, wWindowTileBuffer, wScreenTileBuffer, wWindowAttrBuffer, wScreenAttrBuffer
InnMenu_Case00::
Jump_01C_408B:: ; address name
    ld bc, $001A
    ld hl, wScreenState

Jump_01C_4091::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01C_4091
    ld hl, wWindowTileBuffer
    ld de, wScreenTileBuffer
    ld bc, $00A0
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01C_40B6
    ld hl, wWindowAttrBuffer
    ld de, wScreenAttrBuffer
    ld bc, $00A0
    call CopyLow3BitsToWRAMBank2_Bank1C

Jump_01C_40B6::
    ld hl, wWindowTileBuffer + $A0
    ld de, wScreenTileBuffer
    ld bc, $00A0
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01C_40D4
    ld hl, wWindowAttrBuffer + $A0
    ld de, wScreenAttrBuffer
    ld bc, $00A0
    call CopyLow3BitsToWRAMBank2_Bank1C

Jump_01C_40D4::
    call InnMenu_Case00_Sub01
    ld a, $01
    ld [wMessageMode], a
    ld hl, wScreenState
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in InnMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowState
; writes: wMenuState, wScriptCommandType, wScriptStartRequest
; points at: wScreenSubStep, wScreenArea, wScreenState
InnMenu_Case01::
Jump_01C_40EA:: ; address name
    ld hl, wScreenSubStep
    ld de, Data_01C_4158
    ld c, $00

Jump_01C_40F2::
    ld a, [de]
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $18
    jr c, Jump_01C_40F2
    ld hl, wScreenArea
    call DrawGoldDigitsAtHLWrapped_1C
    ld a, [wTextWindowState]
    bit 7, a
    jr nz, Jump_01C_4122
    ld de, wScreenSubStep
    ld hl, wWindowTileBuffer + $C
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank1C
    ld de, wScreenSubStep
    ld hl, wScreenTileBuffer + $C
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank1C
    jr Jump_01C_413A

Jump_01C_4122::
    ld de, wScreenSubStep
    ld hl, wWindowTileBuffer + $70
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank1C
    ld de, wScreenSubStep
    ld hl, wScreenTileBuffer + $70
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank1C

Jump_01C_413A::
    call BGMapAddressAtScroll_Bank1C
    ld bc, $1408
    ld de, $0168
    call DrawScreenBufferRectToBGMap_1C
    xor a, a
    ld [wMenuState], a
    ld hl, wScreenState
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; address loaded by InnMenu_Case01
Data_01C_4158:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $BF, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; entry 2 of the `rst $00` table in InnMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wArg7, wArg8, wMenuInputResult, wArg1
; writes: wArg3, wArg2, wArg1, wTextYesNoResult, wMenuState, wScriptCommandType, wScriptStartRequest
; points at: wScreenState
InnMenu_Case02::
Jump_01C_4170:: ; address name
    ld a, [wArg7]
    ld e, a
    ld a, [wArg8]
    ld h, a
    ld a, [wMenuInputResult]
    ld l, a
    push de
    push hl
    ld a, e
    ld [wArg3], a
    ld a, h
    ld [wArg2], a
    ld a, l
    ld [wArg1], a
    call IsAmountInArg1AboveGold
    ld a, [wArg1]
    cp a, $FF
    jr z, Jump_01C_41B4
    pop hl
    pop de
    xor a, a
    ld [wTextYesNoResult], a
    ld [wMenuState], a
    call InnMenu_Case02_Sub01
    call InnMenu_Case02_Sub02
    call InnMenu_Case02_Sub03
    ld hl, wScreenState
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_41B4::
    pop hl
    pop de
    ld a, $01
    ld [wTextYesNoResult], a
    xor a, a
    ld [wMenuState], a
    ld hl, wScreenState
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 3 of the `rst $00` table in InnMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wFadeMode
; points at: wScreenState
InnMenu_Case03::
Jump_01C_41CD:: ; address name
    ld a, $87
    ld [wFadeMode], a
    ld a, $04
    call StartPaletteFade
    ld hl, wScreenState
    inc [hl]
    ret

; entry 4 of the `rst $00` table in InnMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; points at: wScreenState
InnMenu_Case04::
Jump_01C_41DC:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    ld hl, wScreenState
    inc [hl]
    ret

; entry 5 of the `rst $00` table in InnMenu
; no direct call (reached through a table, a jump or a vector)
; points at: wScreenState
InnMenu_Case05::
Jump_01C_41E6:: ; address name
    ld hl, wScreenState
    inc [hl]
    ret

; entry 6 of the `rst $00` table in InnMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount, hTemp0, wArg5, wArg6, wArg7, wArg8
; writes: rRAMG2, rRAMB, wArg5, wArg6, wArg7, wArg8
; points at: wPartyList, wScreenState
InnMenu_Case06::
Jump_01C_41EB:: ; address name
    ld a, [wPartyCount]
    and a, a
    jp z, Jump_01C_424E
    ld c, a
    ld hl, wPartyList
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a

Jump_01C_41FF::
    push bc
    push hl
    ld a, [hl]
    ld c, $55
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    bit 7, a
    jr nz, Jump_01C_4241
    pop hl
    push hl
    ld a, [hl]
    ld c, $5D
    call SRAMRecordAddress
    ld a, [hl+]
    ld [wArg5], a
    ld a, [hl+]
    ld [wArg6], a
    inc hl
    inc hl
    ld a, [hl+]
    ld [wArg7], a
    ld a, [hl]
    ld [wArg8], a
    pop hl
    push hl
    ld a, [hl]
    ld c, $5B
    call SRAMRecordAddress
    ld a, [wArg5]
    ld [hl+], a
    ld a, [wArg6]
    ld [hl+], a
    inc hl
    inc hl
    ld a, [wArg7]
    ld [hl+], a
    ld a, [wArg8]
    ld [hl], a

Jump_01C_4241::
    pop hl
    pop bc
    inc hl
    dec c
    ld a, c
    and a, a
    jp nz, Jump_01C_41FF
    xor a, a
    ld [rRAMG2], a

Jump_01C_424E::
    ld hl, wScreenState
    inc [hl]
    ld a, $40
    call QueueMusic
    ret

; entry 7 of the `rst $00` table in InnMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wMapType
; writes: wScreenStep, wFadeMode, wGameMode2Byte50, wKeyWorldRefresh
; points at: wScreenStep, wScreenState
InnMenu_Case07::
Jump_01C_4258:: ; address name
    ld hl, wScreenStep
    inc [hl]
    ld a, [wScreenStep]
    cp a, $90
    ret c
    xor a, a
    ld [wScreenStep], a
    call SendSGBPaletteSetForSGBPaletteSet
    ld a, $87
    ld [wFadeMode], a
    ld a, $F8
    call StartPaletteFade
    ld hl, wScreenState
    inc [hl]
    xor a, a
    ld [wGameMode2Byte50], a
    ld a, $80
    ld [wKeyWorldRefresh], a
    ld a, [wMapType]
    bit 7, a
    jr nz, Jump_01C_428E
    farcall SetupTownObjectsForMap
    ret

Jump_01C_428E::
    farcall RefreshKeyWorldObjectsOnEntry
    ret

; entry 8 of the `rst $00` table in InnMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; writes: wFadeMode, wScriptCommandType, wScriptStartRequest
; points at: wScreenState
InnMenu_Case08::
Jump_01C_4295:: ; address name
    ld a, [wFadeState]
    or a, a
    ret nz
    farcall RestartMapMusic
    ld a, $07
    ld [wFadeMode], a
    ld hl, wScreenState
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; when the Super Game Boy is active, sets the four palette numbers 4 * wC51F + 0-3, sends a PAL_SET ($B1) packet with attribute file wC520, waits, and loads the object palettes (E-0121)
; 3 call sites from 3 routines (e.g. InnMenu_Case07, BreedMenu_Case0B_Case05, GameMode5_Update_Case07_Sub01)
; reads: wSGBActive, wSGBPaletteSet, wSGBAttrFile
; writes: wSGBPaletteNum0Lo, wSGBPaletteNum0Hi, wSGBPaletteNum1Lo, wSGBPaletteNum1Hi, wSGBPaletteNum2Lo, wSGBPaletteNum2Hi, wSGBPaletteNum3Lo, wSGBPaletteNum3Hi, ...
SendSGBPaletteSetForSGBPaletteSet::
Func_01C_42B3:: ; address name
    ld a, [wSGBActive]
    and a, a
    ret z
    ld a, [wSGBPaletteSet]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, l
    ld [wSGBPaletteNum0Lo], a
    ld a, h
    ld [wSGBPaletteNum0Hi], a
    inc hl
    ld a, l
    ld [wSGBPaletteNum1Lo], a
    ld a, h
    ld [wSGBPaletteNum1Hi], a
    inc hl
    ld a, l
    ld [wSGBPaletteNum2Lo], a
    ld a, h
    ld [wSGBPaletteNum2Hi], a
    inc hl
    ld a, l
    ld [wSGBPaletteNum3Lo], a
    ld a, h
    ld [wSGBPaletteNum3Hi], a
    ld a, $B1
    ld [wSGBPacketBuffer], a
    ld a, [wSGBAttrFile]
    ld [wSGBPacketBuffer + $1], a
    ld a, $FF
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    farcall LoadSGBObjectPalettesFromPointers
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same 19 bytes appear in 5 banks)
; 8 call sites from 6 routines (e.g. CloseInnMenu, VaultMenu_Case00, CloseShopMenu_Case00_Sub01, ShopMenu_Case00, ...)
; writes: rSVBK
CopyLow3BitsToWRAMBank2_Bank1C::
Func_01C_4303:: ; address name
    ld a, $02
    ldh [rSVBK], a

Jump_01C_4307::
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01C_4307
    ld a, $00
    ldh [rSVBK], a
    ret

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
; 8 call sites from 6 routines (e.g. CloseInnMenu, VaultMenu_Case00, CloseShopMenu_Case00_Sub01, ShopMenu_Case00, ...)
CopyBytesDEToHL_Bank1C::
Func_01C_4316:: ; address name
    ld a, [de]
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, CopyBytesDEToHL_Bank1C
    ret

; the same instructions as CopyRectTo20ByteRowsJp_Bank24: copies a B x C rectangle from DE to HL with rows 20 bytes apart; on CGB zero-fills the same rectangle at HL + $0E68 with rSVBK = 2 (E-0073)
; 11 call sites from 5 routines (e.g. InnMenu_Case02_Sub03, InnMenu_Case01, ShopMenu_Case01_Case03, DrawScreenListBoxAtWC370AndStep, ...)
; reads: wIsCGB
; writes: rSVBK
CopyRectTo20ByteRowsJp_Bank1C::
Func_01C_431F:: ; address name
    push hl
    push bc

Jump_01C_4321::
    push hl
    push bc

Jump_01C_4323::
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, Jump_01C_4323
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jp nz, Jump_01C_4321
    pop bc
    pop hl
    ld a, [wIsCGB]
    or a, a
    ret z
    ld a, l
    add a, $68
    ld l, a
    ld a, h
    adc a, $0E
    ld h, a
    ld a, $02
    ldh [rSVBK], a

Jump_01C_434A::
    push hl
    push bc

Jump_01C_434C::
    xor a, a
    ld [hl+], a
    dec b
    jr nz, Jump_01C_434C
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jp nz, Jump_01C_434A
    ld a, $00
    ldh [rSVBK], a
    ret

; with story flag 2, no text, wC468 bit 7 clear, a non-empty party and hFF8C bit 0 clear: hFFB9 = 3, sets bit 1 of the player and object flags and returns A = $FF; otherwise 0 (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowState, wFieldActionRequest, wPartyCount, hPlayerStateFlags
; writes: hSpriteWindowClipMode
TryStartFieldMenu:: ; heuristic: follows a terminator; C0
Func_01C_4364:: ; address name
    ld de, $0002
    call TestFlagBit
    jr nc, Jump_01C_4393
    ld a, [wTextWindowState]
    and a, $03
    jr nz, Jump_01C_4393
    ld a, [wFieldActionRequest]
    bit 7, a
    jr nz, Jump_01C_4393
    ld a, [wPartyCount]
    or a, a
    jr z, Jump_01C_4393
    ldh a, [hPlayerStateFlags]
    bit 0, a
    jr nz, Jump_01C_4393
    ld a, $03
    ldh [hSpriteWindowClipMode], a
    farcall SetBit1OfPlayerAndObjectFlags
    ld a, $FF
    ret

Jump_01C_4393::
    xor a, a
    ret

; writes the gold as up to five decimal digit tiles without leading zeros at HL in VRAM, wrapping at the row end (E-0128)
; 7 call sites from 7 routines (e.g. InnMenu_Case02_Sub03, InnMenu_Case01, InitItemListScreenListAndCount, ShopMenu_Case03_Case0E, ...)
; reads: wGoldLo, wGoldMid, wGoldHi
; writes: wDigits
; points at: hTemp2
DrawGoldDigitsAtHLWrapped_1C::
Func_01C_4395:: ; address name
    push hl
    ld a, [wGoldLo]
    ld l, a
    ld a, [wGoldMid]
    ld h, a
    ld a, l
    ld [wDigits], a
    ld a, h
    ld [wDigits + $1], a
    ld a, [wGoldHi]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    pop hl
    ld c, $00
    ld b, $03
    ld de, hTemp2
    jp Jump_01C_43E9

Jump_01C_43BA::
    ld a, [de]
    srl a
    srl a
    srl a
    srl a
    or a, a
    jp nz, Jump_01C_43CC
    bit 0, c
    jp z, Jump_01C_43D3

Jump_01C_43CC::
    add a, $E0
    call WriteVRAMByte
    ld c, $01

Jump_01C_43D3::
    inc hl
    ld a, l
    and a, $1F
    jp nz, Jump_01C_43E2
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_01C_43E2::
    ld a, b
    dec a
    jp nz, Jump_01C_43E9
    ld c, $01

Jump_01C_43E9::
    ld a, [de]
    dec de
    and a, $0F
    jp nz, Jump_01C_43F5
    bit 0, c
    jp z, Jump_01C_43FC

Jump_01C_43F5::
    add a, $E0
    call WriteVRAMByte
    ld c, $01

Jump_01C_43FC::
    inc hl
    ld a, l
    and a, $1F
    jp nz, Jump_01C_440B
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_01C_440B::
    dec b
    jr nz, Jump_01C_43BA
    ret

; compares the 24-bit value wD7F3:wD7F2:wD7F1 (wD7F3 most significant) with wGoldHi:wGoldMid:wGoldLo: wD7F1 = $FF when it is greater, 0 when it is less or equal (the low byte is overwritten with the result) (E-0073)
; 10 call sites from 9 routines (e.g. InnMenu_Case02, ShopMenu_Case03_Case0C, ArenaMenu_Case04, ArenaMenu_Case17, ...)
; reads: wGoldHi, wArg3, wGoldMid, wArg2, wGoldLo, wArg1
; writes: wArg1
IsAmountInArg1AboveGold::
Func_01C_440F:: ; address name
    ld a, [wGoldHi]
    ld b, a
    ld a, [wArg3]
    cp a, b
    jr z, Jump_01C_441D
    jr c, Jump_01C_443D
    jr Jump_01C_4437

Jump_01C_441D::
    ld a, [wGoldMid]
    ld b, a
    ld a, [wArg2]
    cp a, b
    jr z, Jump_01C_442B
    jr c, Jump_01C_443D
    jr Jump_01C_4437

Jump_01C_442B::
    ld a, [wGoldLo]
    ld b, a
    ld a, [wArg1]
    cp a, b
    jr z, Jump_01C_443D
    jr c, Jump_01C_443D

Jump_01C_4437::
    ld a, $FF
    ld [wArg1], a
    ret

Jump_01C_443D::
    xor a, a
    ld [wArg1], a
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 3 call sites from 3 routines (e.g. CloseInnMenu, InnMenu_Case02_Sub03, InnMenu_Case01)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank1C::
Func_01C_4442:: ; address name
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

; only called from InnMenu_Case00 (E-0047)
; 1 call site from 1 routine (e.g. InnMenu_Case00)
; writes: wArg7, wArg8, wMenuInputResult
; points at: wDigits, wTextBuf0
InnMenu_Case00_Sub01::
Func_01C_4463:: ; address name
    ld hl, wDigits
    xor a, a
    ld [hl+], a
    ld a, $01
    ld [hl+], a
    xor a, a
    ld [hl], a
    ld l, $0A
    ld h, $00
    xor a, a
    ld [wArg7], a
    ld a, h
    ld [wArg8], a
    ld a, l
    ld [wMenuInputResult], a
    ld hl, wDigits
    ld de, wTextBuf0
    ld c, $03
    ld a, [hl]
    and a, a
    jr nz, Jump_01C_4491
    inc hl
    dec c
    ld a, [hl]
    and a, a
    jr nz, Jump_01C_4491
    inc hl
    dec c

Jump_01C_4491::
    ld a, c
    and a, a
    jr z, Jump_01C_449B
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr Jump_01C_4491

Jump_01C_449B::
    ld a, $F0
    ld [de], a
    ret

; copies a rectangle of the screen buffer (offset DE) to the BG map at HL, sets wC554 = HL + $1C1, and on CGB copies its attributes (E-0127)
; 5 call sites from 5 routines (e.g. CloseInnMenu, CloseShopMenu_Case00_Sub01, InnMenu_Case02_Sub03, InnMenu_Case01, ...)
; reads: wIsCGB
; writes: wTextCursorLo, wTextCursorHi, rSVBK
; points at: wScreenTileBuffer, wScreenAttrBuffer
DrawScreenBufferRectToBGMap_1C::
Func_01C_449F:: ; address name
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

; only called from InnMenu_Case02 (E-0047)
; 1 call site from 1 routine (e.g. InnMenu_Case02)
; reads: wArg7, wArg8, wMenuInputResult, wGoldHi, wGoldMid, wGoldLo
; writes: wGoldHi, wGoldMid, wGoldLo
InnMenu_Case02_Sub01::
Func_01C_44F3:: ; address name
    ld a, [wArg7]
    ld e, a
    ld a, [wArg8]
    ld h, a
    ld a, [wMenuInputResult]
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

; only called from InnMenu_Case02 (E-0047)
; 1 call site from 1 routine (e.g. InnMenu_Case02)
; reads: wIsCGB
; points at: wWindowTileBuffer, wWindowAttrBuffer
InnMenu_Case02_Sub02::
Func_01C_451D:: ; address name
    ld hl, wWindowTileBuffer
    ld de, wWindowTileBuffer + $A0
    ld bc, $00A0
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a, a
    ret z
    ld hl, wWindowAttrBuffer
    ld de, wWindowAttrBuffer + $A0
    ld bc, $00A0
    call CopyLow3BitsToWRAMBank2_Bank1C
    ret

; only called from InnMenu_Case02 (E-0047)
; 1 call site from 1 routine (e.g. InnMenu_Case02)
; reads: wTextWindowState
; points at: wScreenSubStep, wScreenArea
InnMenu_Case02_Sub03::
Func_01C_453B:: ; address name
    ld hl, wScreenSubStep
    ld de, Data_01C_4598
    ld c, $00

Jump_01C_4543::
    ld a, [de]
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $18
    jr c, Jump_01C_4543
    ld hl, wScreenArea
    call DrawGoldDigitsAtHLWrapped_1C
    ld a, [wTextWindowState]
    bit 7, a
    jr nz, Jump_01C_4573
    ld de, wScreenSubStep
    ld hl, wWindowTileBuffer + $C
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank1C
    ld de, wScreenSubStep
    ld hl, wScreenTileBuffer + $C
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank1C
    jr Jump_01C_458B

Jump_01C_4573::
    ld de, wScreenSubStep
    ld hl, wWindowTileBuffer + $70
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank1C
    ld de, wScreenSubStep
    ld hl, wScreenTileBuffer + $70
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank1C

Jump_01C_458B::
    call BGMapAddressAtScroll_Bank1C
    ld bc, $1408
    ld de, $0168
    call DrawScreenBufferRectToBGMap_1C
    ret

; address loaded by InnMenu_Case02_Sub03
Data_01C_4598:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $BF, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; adds the 24-bit wD7F1-wD7F3 to the gold, capped at 99,999 ($01869F) (E-0127)
; 2 call sites from 2 routines (e.g. ShopMenu_Case04_Case0D, ArenaMenu_Shared06)
; reads: wGoldLo, wGoldMid, wGoldHi, wArg1, wArg2, wArg3
; writes: wGoldHi, wGoldMid, wGoldLo
AddArg1ToGoldCapped99999::
Func_01C_45B0:: ; address name
    ld a, [wGoldLo]
    ld e, a
    ld a, [wGoldMid]
    ld d, a
    ld a, [wGoldHi]
    ld h, a
    ld a, [wArg1]
    add a, e
    ld c, a
    ld a, [wArg2]
    adc a, d
    ld b, a
    ld a, [wArg3]
    adc a, h
    ld h, a
    ld a, h
    cp a, $02
    jr nc, Jump_01C_45F5
    cp a, $01
    jr c, Jump_01C_45E8
    ld a, b
    cp a, $87
    jr nc, Jump_01C_45F5
    cp a, $86
    jr c, Jump_01C_45E8
    ld a, c
    cp a, $A1
    jr nc, Jump_01C_45F5
    cp a, $A0
    jr c, Jump_01C_45E8
    jr Jump_01C_45F5

Jump_01C_45E8::
    ld a, h
    ld [wGoldHi], a
    ld a, b
    ld [wGoldMid], a
    ld a, c
    ld [wGoldLo], a
    ret

Jump_01C_45F5::
    ld a, $01
    ld [wGoldHi], a
    ld a, $86
    ld [wGoldMid], a
    ld a, $9F
    ld [wGoldLo], a
    ret

; implements script command type E3 (SCRIPT_SHOP_CLOSE): ends the shop session ('Thank you! Please come again.' between its two calls) and clears wMessageMode; reached through ScriptCommandE3 in bank $10 (E-0038, E-0244)
; 2 call sites from 2 routines (e.g. CloseVaultMenu, ScriptCommandE3)
; reads: wGridCursorY
CloseShopMenu::
Func_01C_4605:: ; address name
    ld a, [wGridCursorY]
    rst $00
    dw CloseShopMenu_Case00
    dw CloseShopMenu_Case01
    dw CloseShopMenu_Case02
    dw CloseShopMenu_Case03

; entry 0 of the `rst $00` table in CloseShopMenu
; no direct call (reached through a table, a jump or a vector)
CloseShopMenu_Case00::
Jump_01C_4611:: ; address name
    call CloseShopMenu_Case00_Sub01
    ret

; entry 1 of the `rst $00` table in CloseShopMenu
; no direct call (reached through a table, a jump or a vector)
CloseShopMenu_Case01::
Jump_01C_4615:: ; address name
    call CloseShopMenu_Case01_Sub01
    ret

; entry 2 of the `rst $00` table in CloseShopMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorY
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wGridCursorY
CloseShopMenu_Case02::
Jump_01C_4619:: ; address name
    ld b, $46
    ld de, Data_046_4001
    ld hl, vTiles1
    call DecompressToVRAM
    ld hl, vTiles1 + $500
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0F01
    ld a, l
    ld [wTextWindowRows], a
    ld a, h
    ld [wTextWindowWidth], a
    call FillTilesFromRequest
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
    ld a, [wGridCursorY]
    inc a
    ld [wGridCursorY], a
    ret

; entry 3 of the `rst $00` table in CloseShopMenu
; no direct call (reached through a table, a jump or a vector)
; writes: wMessageMode, wGridCursorY, wScriptCommandType, wScriptStartRequest
; points at: wScreenState, wTextBuf0
CloseShopMenu_Case03::
Jump_01C_465B:: ; address name
    farcall DrawRecordListNameTiles_Bank1D
    farcall LoadTilesForPartyRecords
    xor a, a
    ld [wMessageMode], a
    ld [wGridCursorY], a
    ld bc, $0070
    ld hl, wScreenState

Jump_01C_4674::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01C_4674
    ld hl, wTextBuf0
    ld b, $10

Jump_01C_4680::
    ld a, $F0
    ld [hl+], a
    dec b
    jr nz, Jump_01C_4680
    farcall WritePlayerNameWithFlag0SuffixToTextBuf0
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type E2 (SCRIPT_SHOP): the shop: 'What would you like to buy?', 'That comes to 0G. OK?'; reads ShopItemListTable and ItemValueTable (mode 2); reached through ScriptCommandE2 in bank $10 (E-0038, E-0244)
; 1 call site from 1 routine (e.g. ScriptCommandE2)
; reads: wScreenState
ShopMenu::
Func_01C_4696:: ; address name
    ld a, [wScreenState]
    rst $00
    dw ShopMenu_Case00
    dw ShopMenu_Case01
    dw ShopMenu_Case02
    dw ShopMenu_Case03
    dw ShopMenu_Case04

; entry 0 of the `rst $00` table in ShopMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wMessageMode, wGlyphListPos, wScreenCounter, wNumberTens, wNumberOnes, wNumberEditPos, wScriptCommandType, wScriptStartRequest
; points at: wScreenState, wScreenTileBuffer, wScreenAttrBuffer
ShopMenu_Case00::
Jump_01C_46A4:: ; address name
    ld bc, $0070
    ld hl, wScreenState

Jump_01C_46AA::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01C_46AA
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01C_46CF
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank1C

Jump_01C_46CF::
    ld a, $02
    ld [wMessageMode], a
    xor a, a
    ld [wGlyphListPos], a
    ld [wScreenCounter], a
    ld [wNumberTens], a
    ld a, $01
    ld [wNumberOnes], a
    ld [wNumberEditPos], a
    ld hl, wScreenState
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in ShopMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
ShopMenu_Case01::
Jump_01C_46F4:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw ShopMenu_Case01_Case00
    dw ShopMenu_Case01_Case01
    dw ShopMenu_Case01_Case02
    dw ShopMenu_Case01_Case03
    dw ShopMenu_Case01_Case04

; entry 0 of the `rst $00` table in ShopMenu_Case01
; no direct call (reached through a table, a jump or a vector)
; points at: wScreenStep
ShopMenu_Case01_Case00::
Jump_01C_4702:: ; address name
    ld hl, wScreenStep
    inc [hl]

; entry 1 of the `rst $00` table in ShopMenu_Case01
; no direct call (reached through a table, a jump or a vector)
ShopMenu_Case01_Case01::
Jump_01C_4706:: ; address name
    ld hl, TileCopyDestList_1C_5F86
    ld de, TileCopySrcList_1C_5FE8
    call CopyTileListFromBank1F_1C
    ret

; entry 2 of the `rst $00` table in ShopMenu_Case01
; no direct call (reached through a table, a jump or a vector)
ShopMenu_Case01_Case02::
Jump_01C_4710:: ; address name
    call InitItemListScreenListAndCount
    ret

; entry 3 of the `rst $00` table in ShopMenu_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wScreenState
ShopMenu_Case01_Case03::
Jump_01C_4714:: ; address name
    ld de, TileRect_1C_4738
    ld hl, wWindowTileBuffer + $64
    ld bc, $0807
    call CopyRectTo20ByteRowsJp_Bank1C
    call DrawScreenListBoxAtWC370AndStep
    xor a, a
    ld [wScreenStep], a
    ld [wTwoChoiceCursor], a
    ld hl, wScreenState
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 8 x 7 tiles, one row per line
TileRect_1C_4738::
Data_01C_4738:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $EA, $EB, $EC, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $ED, $CF, $EF, $EF, $C3, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $A9, $AB, $AC, $AD, $C3, $B7 ; id 5
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 6

; entry 4 of the `rst $00` table in ShopMenu_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wScreenState
ShopMenu_Case01_Case04::
Jump_01C_4770:: ; address name
    xor a, a
    ld [wScreenStep], a
    ld [wTwoChoiceCursor], a
    ld hl, wScreenState
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 2 of the `rst $00` table in ShopMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wListLastRow, wScreenByteB2, wListPages, wScreenState
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wItemGridX, wItemGridY, wScreenByteB2, wScreenState, wTextTimer, ...
ShopMenu_Case02::
Jump_01C_4785:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_01C_47A0
    bit 7, a
    jr nz, Jump_01C_47BE
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, Jump_01C_47CE
    bit 1, a
    jp nz, Jump_01C_483D
    call ShopMenu_Case02_Sub01
    ret

Jump_01C_47A0::
    call ShopMenu_Case02_Sub03
    ld a, [wListLastRow]
    and a, a
    jr nz, Jump_01C_47BB
    ld a, $02

Jump_01C_47AB::
    ld [wListLastRow], a
    xor a, a
    ld [wScreenByteB3], a
    call ShopMenu_Case02_Sub02
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01C_47BB::
    dec a
    jr Jump_01C_47AB

Jump_01C_47BE::
    call ShopMenu_Case02_Sub03
    ld a, [wListLastRow]
    cp a, $02
    jr c, Jump_01C_47CB
    xor a, a
    jr Jump_01C_47AB

Jump_01C_47CB::
    inc a
    jr Jump_01C_47AB

Jump_01C_47CE::
    call ShopMenu_Case02_Sub04
    ld a, $69
    call QueueSoundEffect
    ld a, [wListLastRow]
    ld [wTwoChoiceCursor], a
    ld b, a
    ld a, [wScreenByteB2]
    cp a, b
    jr z, Jump_01C_47EE
    ld a, [wListLastRow]
    ld b, a
    xor a, a
    ld [wItemGridX], a
    ld [wItemGridY], a

Jump_01C_47EE::
    ld a, b
    ld [wScreenByteB2], a
    ld a, [wListLastRow]
    and a, a
    jr z, Jump_01C_4806
    cp a, $01
    jr z, Jump_01C_481B

Jump_01C_47FC::
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_4806::
    ld a, [wListPages]
    cp a, $18
    jr c, Jump_01C_480D

Jump_01C_480D::
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wTextTimer], a
    jp Jump_01C_47FC

Jump_01C_481B::
    ld a, [wListPages]
    and a, a
    jr nz, Jump_01C_4829
    ld a, $04
    ld [wTwoChoiceCursor], a
    jp Jump_01C_47FC

Jump_01C_4829::
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    add a, $02
    ld [wScreenState], a
    xor a, a
    ld [wTextTimer], a
    jp Jump_01C_47FC

Jump_01C_483D::
    ld a, $02
    ld [wTwoChoiceCursor], a
    jp Jump_01C_47FC

; only called from ShopMenu_Case02 (E-0047)
; 1 call site from 1 routine (e.g. ShopMenu_Case02)
; reads: wJoypadRepeatTimer, wScreenByteB3, wListLastRow
; writes: wScreenByteB3
ShopMenu_Case02_Sub01::
Func_01C_4845:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, ShopMenu_Case02_Sub02
    ld a, [wScreenByteB3]
    inc a
    ld [wScreenByteB3], a
    cp a, $10
    jr c, ShopMenu_Case02_Sub02
    cp a, $18
    jr c, ShopMenu_Case02_Sub03
    xor a, a
    ld [wScreenByteB3], a

; only called from ShopMenu_Case02 (E-0047)
; 1 call site from 1 routine (e.g. ShopMenu_Case02)
; reads: wListLastRow
ShopMenu_Case02_Sub02::
Func_01C_485F:: ; address name
    ld b, $BB
    jr Jump_01C_4869

; only called from ShopMenu_Case02 (E-0047)
; 2 call sites from 1 routine (e.g. ShopMenu_Case02)
; reads: wListLastRow
ShopMenu_Case02_Sub03::
Func_01C_4863:: ; address name
    ld b, $C3
    jr Jump_01C_4869

; only called from ShopMenu_Case02 (E-0047)
; 1 call site from 1 routine (e.g. ShopMenu_Case02)
; reads: wListLastRow
ShopMenu_Case02_Sub04::
Func_01C_4867:: ; address name
    ld b, $BC

Jump_01C_4869::
    ld a, [wListLastRow]
    add a, a
    ld hl, Data_01C_4888
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1C_67AF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld [hl], b
    ei
    ret

; address loaded by ShopMenu_Case02_Sub04
Data_01C_4888:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $00, $61, $00, $A1, $00

; entry 3 of the `rst $00` table in ShopMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
ShopMenu_Case03::
Jump_01C_488E:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw ShopMenu_Case03_Case00
    dw ShopMenu_Case03_Case01
    dw ShopMenu_Case03_Case02
    dw ShopMenu_Case03_Case03
    dw ShopMenu_Case03_Case04
    dw ShopMenu_Case03_Case05
    dw ShopMenu_Case03_Case06
    dw ShopMenu_Case03_Case07
    dw ShopMenu_Case03_Case08
    dw ShopMenu_Case03_Case09
    dw ShopMenu_Case03_Case0A
    dw ShopMenu_Case03_Case0B
    dw ShopMenu_Case03_Case0C
    dw DrawTwoBoxesAndRequestScript80
    dw ShopMenu_Case03_Case0E
    dw ShopMenu_Case03_Case0F
    dw ShopMenu_Case03_Case10

; entry 0 of the `rst $00` table in ShopMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: rSTAT, wIsCGB, wScreenStep
; writes: rVBK, wScreenStep
ShopMenu_Case03_Case00::
Jump_01C_48B4:: ; address name
    ld hl, Data_01C_60AC
    ld de, vBGMap1 + $300

Jump_01C_48BA::
    ld a, [hl]
    cp a, $7F
    jr z, Jump_01C_48CC
    di

Jump_01C_48C0::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01C_48C0
    ld a, [hl+]
    ld [de], a
    ei
    inc de
    jr Jump_01C_48BA

Jump_01C_48CC::
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01C_48ED
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap1 + $300
    ld b, $56

Jump_01C_48DB::
    di

Jump_01C_48DC::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01C_48DC
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ei
    dec b
    jr nz, Jump_01C_48DB
    ld a, $00
    ldh [rVBK], a

Jump_01C_48ED::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in ShopMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
ShopMenu_Case03_Case01::
Jump_01C_48F5:: ; address name
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0081
    add hl, de
    ld bc, $1309
    ld de, vBGMap1 + $300
    call DrawRectBothBanksSetTextCursorLoPlus1C1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in ShopMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wItemGridY, wSavedFieldDrawFlags, wDigits, wScreenStep, wItemGridX
; writes: wSavedSpriteClipMode, wSavedFieldDrawFlags, wItemGridY, wChoiceCursorF0, wScreenStep, wScreenCounter, wGlyphListPos, wItemGridX
ShopMenu_Case03_Case02::
Jump_01C_490D:: ; address name
    call LoadArg1PointerForScreenTableIndex
    ld c, $00

Jump_01C_4912::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_01C_491B
    inc hl
    inc c
    jr Jump_01C_4912

Jump_01C_491B::
    ld a, c
    ld [wSavedSpriteClipMode], a
    ld l, a
    ld h, $00
    ld a, $04
    call DivideHLByA
    push af
    and a, a
    jr z, Jump_01C_492C
    inc l

Jump_01C_492C::
    ld a, l
    ld [wSavedFieldDrawFlags], a
    ld a, [wItemGridY]
    inc a
    cp a, l
    jr c, Jump_01C_4967
    pop af
    push af
    and a, a
    jr nz, Jump_01C_494C
    ld a, [wItemGridY]
    inc a
    cp a, l
    jr z, Jump_01C_4967
    ld a, [wItemGridY]
    dec a
    ld [wItemGridY], a
    jr Jump_01C_4967

Jump_01C_494C::
    pop af
    dec a
    ld [wChoiceCursorF0], a
    ld b, a
    ld a, [wItemGridX]
    cp a, b
    jr c, Jump_01C_496D
    jr z, Jump_01C_496D
    push bc
    push hl
    call EraseItemGridXCursor
    pop hl
    pop bc
    ld a, b
    ld [wItemGridX], a
    jr Jump_01C_496D

Jump_01C_4967::
    pop af
    ld a, $03
    ld [wChoiceCursorF0], a

Jump_01C_496D::
    ld a, [wSavedFieldDrawFlags]
    cp a, $02
    jr c, Jump_01C_49AD
    call DrawC5BEC6AtScroll18E_Bank1C
    call HLToDecimalDigits
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0191
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    ei
    ld a, [wItemGridY]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $018F
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $2]
    add a, $E1
    ld [hl], a
    ei

Jump_01C_49AD::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenCounter], a
    ld [wGlyphListPos], a
    ret

; entry 3 of the `rst $00` table in ShopMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenCounter, wGlyphListPos, wItemGridY, wCursorBlinkB8, wScreenStep
; writes: wGlyphListPos, wCursorBlinkB8, wScreenCounter, wScreenStep
ShopMenu_Case03_Case03::
Jump_01C_49BC:: ; address name
    ld a, [wScreenCounter]
    add a, a
    ld hl, TileDestTable_1C_6289
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]

Jump_01C_49CB::
    push de
    ld a, [wGlyphListPos]
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_01C_49D5
    inc d

Jump_01C_49D5::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld de, Data_01F_4910
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    cp a, $09
    jr c, Jump_01C_49CB
    xor a, a
    ld [wGlyphListPos], a
    call LoadArg1PointerForScreenTableIndex
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wScreenCounter]
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jp z, Jump_01C_4A9F
    ld e, a
    ld d, $00
    sla e
    rl d
    ld hl, Data_01C_63FE
    add hl, de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e

Jump_01C_4A23::
    ld a, [hl]
    cp a, $F0
    jp z, Jump_01C_4A9F
    ld [wCursorBlinkB8], a
    push hl
    ld hl, $4010
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
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    push de
    ld a, [wScreenCounter]
    add a, a
    ld de, TileDestTable_1C_6289
    add a, e
    ld e, a
    jr nc, Jump_01C_4A55
    inc d

Jump_01C_4A55::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [wCursorBlinkB8]
    cp a, $8D
    jr z, Jump_01C_4A67
    cp a, $8E
    jr z, Jump_01C_4A67
    jr Jump_01C_4A6E

Jump_01C_4A67::
    ld a, [wGlyphListPos]
    dec a
    ld [wGlyphListPos], a

Jump_01C_4A6E::
    ld a, [wGlyphListPos]
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    ld b, $1F
    ld c, $10
    ld a, [wCursorBlinkB8]
    cp a, $8D
    jr z, Jump_01C_4A90
    cp a, $8E
    jr z, Jump_01C_4A90
    call CopyFromBankWaitVRAM
    jr Jump_01C_4A93

Jump_01C_4A90::
    call OrFromBankWaitVRAM

Jump_01C_4A93::
    pop hl
    inc hl
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    jp Jump_01C_4A23

Jump_01C_4A9F::
    xor a, a
    ld [wGlyphListPos], a
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp a, $04
    jr c, Jump_01C_4ABB
    xor a, a
    ld [wScreenCounter], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    ret

Jump_01C_4ABB::
    ret

; entry 4 of the `rst $00` table in ShopMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
ShopMenu_Case03_Case04::
Jump_01C_4ABC:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in ShopMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wItemGridY, wScreenCounter, wScreenByteEE, wScreenStep
; writes: wArg3, wArg4, wArg5, wArg6, wArg7, wArg8, wScreenByteEE, wScreenCounter, ...
; points at: wArg3
ShopMenu_Case03_Case05::
Jump_01C_4AC4:: ; address name
    call LoadArg1PointerForScreenTableIndex
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de

Jump_01C_4AD6::
    push hl
    ld a, [wScreenCounter]
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jr nz, Jump_01C_4AFA
    ld a, $E3
    ld [wArg3], a
    ld [wArg4], a
    ld [wArg5], a
    ld [wArg6], a
    ld [wArg7], a
    ld [wArg8], a
    jr Jump_01C_4B2F

Jump_01C_4AFA::
    ld e, a
    ld l, a
    ld h, $00
    ld d, $00
    sla e
    rl d
    add hl, de
    ld e, l
    ld d, h
    call ReadF2FarPointerForScreenTableIndex
    add hl, de
    call ShopMenu_Shared02
    ld e, l
    ld d, h
    ld b, $F2
    call ReadFarPointerAtDEInBankB
    ld a, l
    ld [wDigits], a
    ld a, h
    ld [wDigits + $1], a
    ld a, b
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    farcall UnpackBCDToDigitsArg1_Bank1E
    ld a, $DF
    ld [wArg8], a

Jump_01C_4B2F::
    ld hl, Data_01C_62D9
    ld a, [wScreenCounter]
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1C_67AF
    pop de
    add hl, de
    dec hl
    ld e, l
    ld d, h
    xor a, a
    ld [wScreenByteEE], a
    ld hl, wArg3
    ld c, $00

Jump_01C_4B50::
    ld a, [wScreenByteEE]
    and a, a
    jr nz, Jump_01C_4B68
    push hl
    ld l, e
    ld h, d
    call StepBGMapAddressBackOnScrollWrap
    cp a, $FF
    jr nz, Jump_01C_4B65
    ld a, $01
    ld [wScreenByteEE], a

Jump_01C_4B65::
    ld e, l
    ld d, h
    pop hl

Jump_01C_4B68::
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    add a, $E0
    ld [de], a
    inc de
    ei
    inc c
    ld a, c
    cp a, $06
    jr c, Jump_01C_4B50
    xor a, a
    pop hl
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp a, $04
    jp c, Jump_01C_4AD6
    xor a, a
    ld [wScreenCounter], a
    ld [wGlyphListPos], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 6 of the `rst $00` table in ShopMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wTextCounter0, wScreenStep, wChoiceCursorF0, wItemGridX, wSavedFieldDrawFlags, wItemGridY
; writes: wTextTimer, wScreenState, wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wItemGridX, wSelectedRecord, ...
ShopMenu_Case03_Case06::
Jump_01C_4B95:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 4, a
    jr nz, Jump_01C_4BE4
    bit 5, a
    jr nz, Jump_01C_4C12
    bit 6, a
    jp nz, Jump_01C_4C30
    bit 7, a
    jp nz, Jump_01C_4C58
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_01C_4C74
    call BlinkCursorSelectedRecord_Bank1C
    call ShopMenu_Shared01
    ld a, [wTextCounter0]
    cp a, $03
    ret c
    ld a, [wJoypadPressed]
    bit 1, a
    ret z
    call ResetTextCounter0Counters
    xor a, a
    ld [wTextTimer], a
    ld a, $01
    ld [wScreenState], a
    ld a, $01
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_4BE4::
    ld a, [wSavedFieldDrawFlags]
    cp a, $02
    jr c, Jump_01C_4C05
    call EraseItemGridXCursor
    call ResetTextCounter0Counters
    ld a, [wSavedFieldDrawFlags]
    ld b, a
    ld a, [wItemGridY]
    inc a
    cp a, b
    jr c, Jump_01C_4BFD
    xor a, a

Jump_01C_4BFD::
    ld [wItemGridY], a
    ld a, $02
    ld [wScreenStep], a

Jump_01C_4C05::
    xor a, a
    ld [wSelectedRecord], a
    call DrawItemGridXCursor
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01C_4C12::
    ld a, [wSavedFieldDrawFlags]
    cp a, $02
    jr c, Jump_01C_4C05
    call EraseItemGridXCursor
    call ResetTextCounter0Counters
    ld a, [wItemGridY]
    and a, a
    jr nz, Jump_01C_4C2C
    ld a, [wSavedFieldDrawFlags]
    dec a
    jp Jump_01C_4BFD

Jump_01C_4C2C::
    dec a
    jp Jump_01C_4BFD

Jump_01C_4C30::
    ld a, [wChoiceCursorF0]
    and a, a
    jr z, Jump_01C_4C4B
    call ResetTextCounter0Counters
    call EraseItemGridXCursor
    ld a, [wItemGridX]
    and a, a
    jr nz, Jump_01C_4C47
    ld a, [wChoiceCursorF0]
    jr Jump_01C_4C48

Jump_01C_4C47::
    dec a

Jump_01C_4C48::
    ld [wItemGridX], a

Jump_01C_4C4B::
    xor a, a
    ld [wSelectedRecord], a
    call DrawItemGridXCursor
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01C_4C58::
    ld a, [wChoiceCursorF0]
    and a, a
    jr z, Jump_01C_4C4B
    call ResetTextCounter0Counters
    call EraseItemGridXCursor
    ld a, [wChoiceCursorF0]
    ld b, a
    ld a, [wItemGridX]
    cp a, b
    jr c, Jump_01C_4C71
    xor a, a
    jr Jump_01C_4C48

Jump_01C_4C71::
    inc a
    jr Jump_01C_4C48

Jump_01C_4C74::
    call DrawItemGridXCursorConfirmed
    ld a, $69
    call QueueSoundEffect
    call ResetTextCounter0Counters
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; cycles wD7B4 through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (cursor drawn by DrawItemGridXCursor / EraseItemGridXCursor) (E-0122)
; 2 call sites from 2 routines (e.g. ShopMenu_Case03_Case06, ShopMenu_Case04_Case05)
; reads: wSelectedRecord, wItemGridX
; writes: wSelectedRecord
BlinkCursorSelectedRecord_Bank1C::
Func_01C_4C87:: ; address name
    ld a, [wSelectedRecord]
    inc a
    ld [wSelectedRecord], a
    cp a, $10
    jr c, DrawItemGridXCursor
    cp a, $18
    jr c, EraseItemGridXCursor
    xor a, a
    ld [wSelectedRecord], a

; writes the cursor tile $BB at the position for wD7B5 (0-3; BG map offsets $00A2, $00E2, $0122, $0162 from the scroll origin, Data_01C_4CC4), via StepBGMapAddressBackOnScrollWrap and WaitForVRAMAccess (E-0074)
; 4 call sites from 2 routines (e.g. ShopMenu_Case03_Case06, ShopMenu_Case04_Case05)
; reads: wItemGridX
DrawItemGridXCursor::
Func_01C_4C9A:: ; address name
    ld b, $BB
    jr Jump_01C_4CA4

; writes the blank tile $C3 at the position for wD7B5 (0-3; BG map offsets $00A2, $00E2, $0122, $0162 from the scroll origin, Data_01C_4CC4), via StepBGMapAddressBackOnScrollWrap and WaitForVRAMAccess (E-0074)
; 8 call sites from 4 routines (e.g. ShopMenu_Case03_Case06, ShopMenu_Case03_Case02, ShopMenu_Case04_Case05, ShopMenu_Case04_Case02)
; reads: wItemGridX
EraseItemGridXCursor::
Func_01C_4C9E:: ; address name
    ld b, $C3
    jr Jump_01C_4CA4

; writes the confirmed-cursor tile $BC at the position for wD7B5 (0-3; BG map offsets $00A2, $00E2, $0122, $0162 from the scroll origin, Data_01C_4CC4), via StepBGMapAddressBackOnScrollWrap and WaitForVRAMAccess (E-0074)
; 2 call sites from 2 routines (e.g. ShopMenu_Case03_Case06, ShopMenu_Case04_Case05)
; reads: wItemGridX
DrawItemGridXCursorConfirmed::
Func_01C_4CA2:: ; address name
    ld b, $BC

Jump_01C_4CA4::
    ld a, [wItemGridX]
    add a, a
    ld hl, Data_01C_4CC4
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1C_67AF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; address loaded by DrawItemGridXCursorConfirmed
Data_01C_4CC4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A2, $00, $E2, $00, $22, $01, $62, $01

; entry 7 of the `rst $00` table in ShopMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wScreenStep
; writes: wTextTimer, wScreenState, wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wNumberTens, wNumberOnes, ...
ShopMenu_Case03_Case07::
Jump_01C_4CCC:: ; address name
    call ResetTextCounter0Counters
    ld a, [wListPages]
    cp a, $18
    jr c, Jump_01C_4CF3
    xor a, a
    ld [wTextTimer], a
    ld a, $01
    ld [wScreenState], a
    ld a, $01
    ld [wScreenStep], a
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_4CF3::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld [wNumberTens], a
    ld a, $01
    ld [wNumberOnes], a
    ld [wNumberEditPos], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 8 of the `rst $00` table in ShopMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wNumberTens, wNumberOnes, wScreenStep
; writes: wNumberTens, wNumberOnes, wScreenByte8D, wScreenCountPlusOne, wScreenStep
; points at: wScreenList
ShopMenu_Case03_Case08::
Jump_01C_4D13:: ; address name
    xor a, a
    ld [wNumberTens], a
    ld a, $01
    ld [wNumberOnes], a
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld de, vBGMap1 + $3B0
    ld b, $00
    ld c, $00
    push hl
    push hl

Jump_01C_4D2F::
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ld [de], a
    ei
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_01C_4D50
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

Jump_01C_4D50::
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $04
    jp c, Jump_01C_4D2F
    xor a, a
    ld c, a
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    push hl
    inc b
    ld a, b
    cp a, $03
    jp c, Jump_01C_4D2F
    pop hl
    pop hl
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_01C_4DA7
    push bc
    ld c, $4F
    ld a, $01
    ldh [c], a
    pop bc
    di
    call WaitForVRAMAccess
    xor a, a
    ld [hl], a
    ei
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    di
    call WaitForVRAMAccess
    xor a, a
    ld [hl], a
    ei
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    di
    call WaitForVRAMAccess
    xor a, a
    ld [hl], a
    ei
    push bc
    ld c, $4F
    ld a, $00
    ldh [c], a
    pop bc

Jump_01C_4DA7::
    ld hl, wScreenList
    ld de, Data_01C_62E1
    ld bc, $000C

Jump_01C_4DB0::
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01C_4DB0
    ld a, [wNumberTens]
    add a, $E0
    ld [wScreenByte8D], a
    ld a, [wNumberOnes]
    add a, $E0
    ld [wScreenCountPlusOne], a
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    ld bc, $0403
    ld de, wScreenList
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 9 of the `rst $00` table in ShopMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wNumberTens, wNumberOnes, wScreenStep, wNumberEditPos
; writes: wTextTimer, wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest, wNumberTens, wNumberOnes, wNumberEditPos
ShopMenu_Case03_Case09::
Jump_01C_4DE0:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 1, a
    jr nz, Jump_01C_4E05
    bit 4, a
    jr nz, Jump_01C_4E2D
    bit 5, a
    jr nz, Jump_01C_4E47
    bit 6, a
    jp nz, Jump_01C_4E57
    bit 7, a
    jp nz, Jump_01C_4ECE
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_01C_4F53
    call BlinkCursorBlinkCD_Bank1C_4F87
    ret

Jump_01C_4E05::
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    ld bc, $0403
    ld de, vBGMap1 + $3B0
    call DrawRectBothBanksSetTextCursorLoPlus1C1
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $06
    ld [wScreenStep], a
    xor a, a
    ld [wTextTimer], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_4E2D::
    call ShopMenu_Case03_Case09_Sub01
    ld a, [wNumberEditPos]
    cp a, $01
    jr nz, Jump_01C_4E3A
    xor a, a
    jr Jump_01C_4E3B

Jump_01C_4E3A::
    inc a

Jump_01C_4E3B::
    ld [wNumberEditPos], a
    call BlinkCursorBlinkCD_Bank1C_4F87
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01C_4E47::
    call ShopMenu_Case03_Case09_Sub01
    ld a, [wNumberEditPos]
    and a, a
    jr nz, Jump_01C_4E54
    ld a, $01
    jr Jump_01C_4E3B

Jump_01C_4E54::
    dec a
    jr Jump_01C_4E3B

Jump_01C_4E57::
    ld a, $69
    call QueueSoundEffect
    ld a, [wNumberEditPos]
    and a, a
    jr nz, Jump_01C_4E98
    ld a, [wNumberTens]
    cp a, $02
    jr c, Jump_01C_4E8B
    ld a, $02
    ld [wNumberTens], a
    ld a, $04
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtTable5008
    ret

Jump_01C_4E77::
    ld a, [wNumberOnes]
    cp a, $04
    jr c, Jump_01C_4E87
    ld a, $04
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtTable5008
    ret

Jump_01C_4E87::
    call DrawNumberTensNumberOnesDigitsAtTable5008
    ret

Jump_01C_4E8B::
    inc a
    ld [wNumberTens], a
    cp a, $02
    jp nc, Jump_01C_4E77
    call BlinkCursorBlinkCD_Bank1C_4F87
    ret

Jump_01C_4E98::
    ld a, [wNumberTens]
    cp a, $02
    jr c, Jump_01C_4EA3
    ld b, $04
    jr Jump_01C_4EA5

Jump_01C_4EA3::
    ld b, $09

Jump_01C_4EA5::
    ld a, [wNumberOnes]
    cp a, b
    jr c, Jump_01C_4EC6
    ld a, b
    cp a, $04
    jr nz, Jump_01C_4EB4
    call BlinkCursorBlinkCD_Bank1C_4F87
    ret

Jump_01C_4EB4::
    ld a, [wNumberTens]
    and a, a
    jr nz, Jump_01C_4EBE
    ld a, $01
    jr Jump_01C_4EBF

Jump_01C_4EBE::
    xor a, a

Jump_01C_4EBF::
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1C_4F87
    ret

Jump_01C_4EC6::
    inc a
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1C_4F87
    ret

Jump_01C_4ECE::
    ld a, $69
    call QueueSoundEffect
    ld a, [wNumberEditPos]
    and a, a
    jr nz, Jump_01C_4F18
    ld a, [wNumberTens]
    and a, a
    jr nz, Jump_01C_4EFD
    ld a, [wNumberOnes]
    cp a, $04
    jr c, Jump_01C_4EF4
    ld a, $02
    ld [wNumberTens], a
    ld a, $04
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtTable5008
    ret

Jump_01C_4EF4::
    ld a, $02
    ld [wNumberTens], a
    call BlinkCursorBlinkCD_Bank1C_4F87
    ret

Jump_01C_4EFD::
    dec a
    ld [wNumberTens], a
    ld a, [wNumberTens]
    ld b, a
    ld a, [wNumberOnes]
    or a, b
    jr nz, Jump_01C_4F14
    ld a, $01
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtTable5008
    ret

Jump_01C_4F14::
    call BlinkCursorBlinkCD_Bank1C_4F87
    ret

Jump_01C_4F18::
    ld a, [wNumberTens]
    and a, a
    jr nz, Jump_01C_4F27
    ld a, [wNumberOnes]
    cp a, $01
    jr nz, Jump_01C_4F4B
    jr Jump_01C_4F2D

Jump_01C_4F27::
    ld a, [wNumberOnes]
    and a, a
    jr nz, Jump_01C_4F4B

Jump_01C_4F2D::
    ld a, [wNumberTens]
    cp a, $02
    jr c, Jump_01C_4F42
    ld a, $02
    ld [wNumberTens], a
    ld a, $04
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtTable5008
    ret

Jump_01C_4F42::
    ld a, $09
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1C_4F87
    ret

Jump_01C_4F4B::
    dec a
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1C_4F87
    ret

Jump_01C_4F53::
    xor a, a
    ld [wTextTimer], a
    ld a, [wNumberTens]
    and a, a
    jr nz, Jump_01C_4F67
    ld a, [wNumberOnes]
    and a, a
    jr nz, Jump_01C_4F67
    call BlinkCursorBlinkCD_Bank1C_4F87
    ret

Jump_01C_4F67::
    ld a, $69
    call QueueSoundEffect
    call ShopMenu_Case03_Case09_Sub01
    call ShopMenu_Case03_Case09_Sub02
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; cycles wD7CD through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (E-0122)
; 11 call sites from 1 routine (e.g. ShopMenu_Case03_Case09)
; reads: wCursorBlinkCD, wNumberEditPos, wNumberTens, wNumberOnes
; writes: wCursorBlinkCD
BlinkCursorBlinkCD_Bank1C_4F87::
Func_01C_4F87:: ; address name
    ld a, [wCursorBlinkCD]
    inc a
    ld [wCursorBlinkCD], a
    cp a, $10
    jr c, ShopMenu_Case03_Case09_Sub01
    cp a, $18
    jr c, Jump_01C_4FAD
    xor a, a
    ld [wCursorBlinkCD], a

; only called from ShopMenu_Case03_Case09 (E-0047)
; 3 call sites from 1 routine (e.g. ShopMenu_Case03_Case09)
; reads: wNumberEditPos, wNumberTens, wNumberOnes
ShopMenu_Case03_Case09_Sub01::
Func_01C_4F9A:: ; address name
    ld a, [wNumberEditPos]
    and a, a
    jr nz, Jump_01C_4FA5
    ld a, [wNumberTens]
    jr Jump_01C_4FA8

Jump_01C_4FA5::
    ld a, [wNumberOnes]

Jump_01C_4FA8::
    add a, $E0
    ld b, a
    jr Jump_01C_4FAF

Jump_01C_4FAD::
    ld b, $CB

Jump_01C_4FAF::
    ld a, [wNumberEditPos]
    add a, a
    ld hl, Data_01C_5008
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1C_67AF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; writes wD7CA and wD7CB as digit tiles at the scroll offsets in Data_01C_5008 and Data_01C_500A (E-0121)
; 6 call sites from 1 routine (e.g. ShopMenu_Case03_Case09)
; reads: wNumberTens, wNumberOnes
DrawNumberTensNumberOnesDigitsAtTable5008::
Func_01C_4FCF:: ; address name
    ld hl, Data_01C_5008
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1C_67AF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld a, [wNumberTens]
    add a, $E0
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ld hl, Data_01C_500A
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1C_67AF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld a, [wNumberOnes]
    add a, $E0
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; address loaded by ShopMenu_Case03_Case09_Sub01, DrawNumberTensNumberOnesDigitsAtTable5008, ShopMenu_Case04_Case08_Sub01, DrawNumberTensNumberOnesDigitsAtTable5008And5BE4
Data_01C_5008:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $61, $01

; address loaded by DrawNumberTensNumberOnesDigitsAtTable5008
Data_01C_500A:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $62, $01

; only called from ShopMenu_Case03_Case09 (E-0047)
; 1 call site from 1 routine (e.g. ShopMenu_Case03_Case09)
; reads: wNumberTens, wNumberOnes, wItemGridY, wItemGridX
; writes: wThreeDigits
ShopMenu_Case03_Case09_Sub02::
Func_01C_500C:: ; address name
    ld a, [wNumberTens]
    ld e, a
    ld d, $00
    ld l, a
    ld h, $00
    sla l
    rl h
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    ld a, [wNumberOnes]
    add a, e
    ld e, a
    jr nc, Jump_01C_5032
    inc d

Jump_01C_5032::
    push de
    call LoadArg1PointerForScreenTableIndex
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wItemGridX]
    add_a_to_hl
    ld a, [hl]
    ld e, a
    ld l, a
    ld h, $00
    ld d, $00
    sla e
    rl d
    add hl, de
    ld e, l
    ld d, h
    call ReadF2FarPointerForScreenTableIndex
    add hl, de
    call ShopMenu_Shared02
    ld e, l
    ld d, h
    ld b, $F2
    call ReadFarPointerAtDEInBankB
    ld e, b
    pop bc
    ld a, c
    call Multiply24By8_Bank1C
    ld a, e
    ld [wThreeDigits + $2], a
    ld a, h
    ld [wThreeDigits + $1], a
    ld a, l
    ld [wThreeDigits], a
    ret

; entry 10 of the `rst $00` table in ShopMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wItemGridY, wItemGridX, hTemp3, hTemp2, hTemp1, hTemp0, wScreenList, wListEntries, ...
; writes: wCursorBlinkB8, wDigits, wScreenList, wListEntries, wGrid2CursorX, wGrid2CursorY, wScreenArea, wScreenByte8D, ...
; points at: wTextBuf0, wThreeDigits, wScreenList
ShopMenu_Case03_Case0A::
Jump_01C_507C:: ; address name
    call LoadArg1PointerForScreenTableIndex
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wItemGridX]
    add_a_to_hl
    ld a, [hl]
    ld [wCursorBlinkB8], a
    ld de, wTextBuf0
    push de
    ld hl, wThreeDigits
    ld a, [hl+]
    ld [wDigits], a
    ld a, [hl+]
    ld [wDigits + $1], a
    ld a, [hl]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ldh a, [hTemp3]
    and a, $0F
    ld [wScreenList], a
    ldh a, [hTemp2]
    and a, $F0
    swap a
    ld [wListEntries], a
    ldh a, [hTemp2]
    and a, $0F
    ld [wGrid2CursorX], a
    ldh a, [hTemp1]
    and a, $F0
    swap a
    ld [wGrid2CursorY], a
    ldh a, [hTemp1]
    and a, $0F
    ld [wScreenArea], a
    ldh a, [hTemp0]
    and a, $F0
    swap a
    ld [wScreenByte8D], a
    ldh a, [hTemp0]
    and a, $0F
    ld [wScreenCountPlusOne], a
    ld c, $00
    ld a, [wScreenList]
    and a, a
    jr nz, Jump_01C_512B
    ld a, $90
    ld [wScreenList], a
    ld a, [wListEntries]
    and a, a
    jr nz, Jump_01C_512B
    ld a, $90
    ld [wListEntries], a
    ld a, [wGrid2CursorX]
    and a, a
    jr nz, Jump_01C_512B
    ld a, $90
    ld [wGrid2CursorX], a
    ld a, [wGrid2CursorY]
    and a, a
    jr nz, Jump_01C_512B
    ld a, $90
    ld [wGrid2CursorY], a
    ld a, [wScreenArea]
    and a, a
    jr nz, Jump_01C_512B
    ld a, $90
    ld [wScreenArea], a
    ld a, [wScreenByte8D]
    and a, a
    jr nz, Jump_01C_512B
    ld a, $90
    ld [wScreenByte8D], a

Jump_01C_512B::
    pop de
    ld hl, wScreenList

Jump_01C_512F::
    ld a, [hl]
    cp a, $90
    jr nz, Jump_01C_5138
    inc c
    inc hl
    jr Jump_01C_512F

Jump_01C_5138::
    ld a, [hl+]
    ld [de], a
    inc de
    inc c
    ld a, c
    cp a, $07
    jr c, Jump_01C_512F
    ld a, $F0
    ld [de], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenByteD1], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 11 of the `rst $00` table in ShopMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
ShopMenu_Case03_Case0B::
Jump_01C_5159:: ; address name
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $010E
    add hl, de
    push hl
    call StepBGMapAddressBackOnScrollWrap
    ld de, vBGMap1 + $3D0
    ld b, $00
    ld c, $00
    push hl

Jump_01C_516C::
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ld [de], a
    ei
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $06
    jp c, Jump_01C_516C
    xor a, a
    ld c, a
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    push hl
    inc b
    ld a, b
    cp a, $05
    jp c, Jump_01C_516C
    pop hl
    pop hl
    ld de, TileRect_1C_6302
    ld bc, $0605
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    ld a, $6C
    call QueueSoundEffect
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 12 of the `rst $00` table in ShopMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wScreenStep, wScreenByteD1, wThreeDigits, wArg1, wNumberTens, wNumberOnes, ...
; writes: wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wArg3, wArg2, wArg1, wScreenByteD1
ShopMenu_Case03_Case0C::
Jump_01C_51A7:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_01C_51C3
    bit 7, a
    jr nz, Jump_01C_51DD
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_01C_51ED
    bit 1, a
    jp nz, Jump_01C_5279
    call BlinkCursorBlinkD2_Bank1C_52A0
    ret

Jump_01C_51C3::
    call DrawBlankTileC3_52BE_Bank1C
    ld a, [wScreenByteD1]
    and a, a
    jr nz, Jump_01C_51D0
    ld a, $01
    jr Jump_01C_51D1

Jump_01C_51D0::
    dec a

Jump_01C_51D1::
    ld [wScreenByteD1], a
    call BlinkCursorBlinkD2_Bank1C_52A0
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01C_51DD::
    call DrawBlankTileC3_52BE_Bank1C
    ld a, [wScreenByteD1]
    cp a, $01
    jr c, Jump_01C_51EA
    xor a, a
    jr Jump_01C_51D1

Jump_01C_51EA::
    inc a
    jr Jump_01C_51D1

Jump_01C_51ED::
    ld a, $69
    call QueueSoundEffect
    call ShopMenu_Case03_Case0C_Sub01
    ld a, [wScreenByteD1]
    and a, a
    jr nz, Jump_01C_5279
    ld a, [wThreeDigits + $2]
    ld [wArg3], a
    ld a, [wThreeDigits + $1]
    ld [wArg2], a
    ld a, [wThreeDigits]
    ld [wArg1], a
    call IsAmountInArg1AboveGold
    ld a, [wArg1]
    cp a, $FF
    jp z, Jump_01C_525D
    ld a, [wNumberTens]
    ld e, a
    ld d, $00
    ld l, a
    ld h, $00
    sla l
    rl h
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    ld a, [wNumberOnes]
    add a, e
    ld e, a
    jr nc, Jump_01C_523E
    inc d

Jump_01C_523E::
    ld a, [wListPages]
    add a, e
    cp a, $19
    jr nc, Jump_01C_5263
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_525D::
    xor a, a
    ld [wTwoChoiceCursor], a
    jr Jump_01C_5268

Jump_01C_5263::
    ld a, $01
    ld [wTwoChoiceCursor], a

Jump_01C_5268::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_5279::
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $010E
    add hl, de
    ld bc, $0605
    ld de, vBGMap1 + $3D0
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    ld a, [wScreenStep]
    sub a, $03
    ld [wScreenStep], a
    ld a, $03
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; cycles wD7D2 through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (after the joypad repeat timer reaches $14) (E-0122)
; 2 call sites from 1 routine (e.g. ShopMenu_Case03_Case0C)
; reads: wJoypadRepeatTimer, wCursorBlinkD2, wScreenByteD1
; writes: wCursorBlinkD2
BlinkCursorBlinkD2_Bank1C_52A0::
Func_01C_52A0:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, Jump_01C_52BA
    ld a, [wCursorBlinkD2]
    inc a
    ld [wCursorBlinkD2], a
    cp a, $10
    jr c, Jump_01C_52BA
    cp a, $18
    jr c, DrawBlankTileC3_52BE_Bank1C
    xor a, a
    ld [wCursorBlinkD2], a

Jump_01C_52BA::
    ld b, $BB
    jr Jump_01C_52C4

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. ShopMenu_Case03_Case0C)
; reads: wScreenByteD1
DrawBlankTileC3_52BE_Bank1C::
Func_01C_52BE:: ; address name
    ld b, $C3
    jr Jump_01C_52C4

; only called from ShopMenu_Case03_Case0C (E-0047)
; 1 call site from 1 routine (e.g. ShopMenu_Case03_Case0C)
; reads: wScreenByteD1
ShopMenu_Case03_Case0C_Sub01::
Func_01C_52C2:: ; address name
    ld b, $BC

Jump_01C_52C4::
    ld a, [wScreenByteD1]
    add a, a
    ld hl, Data_01C_52E4
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1C_67AF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; address loaded by ShopMenu_Case03_Case0C_Sub01
Data_01C_52E4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2F, $01, $6F, $01

; clears two rectangles at scroll + $10E and + $140, wD781 = 6, clears wScriptCommandType and requests script $80 (E-0124)
; 1 call site from 1 routine (e.g. ShopMenu_Case03_Case0F)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
DrawTwoBoxesAndRequestScript80::
Func_01C_52E8:: ; address name
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $010E
    add hl, de
    ld bc, $0605
    ld de, vBGMap1 + $3D0
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    ld bc, $0403
    ld de, vBGMap1 + $3B0
    call DrawRectBothBanksSetTextCursorLoPlus1C1
    ld a, $06
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 15 of the `rst $00` table in ShopMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep
ShopMenu_Case03_Case0F::
Jump_01C_5317:: ; address name
    call DrawTwoBoxesAndRequestScript80
    ld a, $10
    ld [wScreenStep], a
    ret

; entry 16 of the `rst $00` table in ShopMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wItemGridY
; writes: wScreenStep, wItemGridX, wItemGridY
ShopMenu_Case03_Case10::
Jump_01C_5320:: ; address name
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $00A2
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld b, $04

Jump_01C_532C::
    di
    call WaitForVRAMAccess
    ld a, $C3
    ld [hl], a
    ei
    ld a, l
    add a, $40
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Jump_01C_532C
    ld a, [wItemGridY]
    and a, a
    jr nz, Jump_01C_5349
    ld a, $06
    jr Jump_01C_534A

Jump_01C_5349::
    xor a, a

Jump_01C_534A::
    ld [wScreenStep], a
    xor a, a
    ld [wItemGridX], a
    ld [wItemGridY], a
    ret

; entry 14 of the `rst $00` table in ShopMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wThreeDigits, wNumberTens, wNumberOnes, wItemGridY, wItemGridX, wListPages, wScreenStep, wDigits, ...
; writes: wArg3, wArg2, wArg1, wCursorBlinkB8, wScreenState, wScreenStep, wItemGridX, wItemGridY, ...
; points at: wInventory, wScreenList, wScreenBlock92
ShopMenu_Case03_Case0E::
Jump_01C_5355:: ; address name
    ld a, [wThreeDigits + $2]
    ld [wArg3], a
    ld a, [wThreeDigits + $1]
    ld [wArg2], a
    ld a, [wThreeDigits]
    ld [wArg1], a
    farcall SubtractArg1AmountFromGold
    ld a, [wNumberTens]
    ld e, a
    ld d, $00
    ld l, a
    ld h, $00
    sla l
    rl h
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    ld a, [wNumberOnes]
    add a, e
    ld e, a
    jr nc, Jump_01C_5393
    inc d

Jump_01C_5393::
    push de
    call LoadArg1PointerForScreenTableIndex
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wItemGridX]
    add_a_to_hl
    ld a, [hl]
    ld [wCursorBlinkB8], a
    pop de
    push de
    ld a, e
    ld c, a
    ld hl, wInventory
    ld b, $00

Jump_01C_53BB::
    ld a, [hl]
    and a, a
    jr z, Jump_01C_53CC
    cp a, $FF
    jr z, Jump_01C_53CC
    inc hl
    inc b

Jump_01C_53C5::
    ld a, b
    cp a, $18
    jr c, Jump_01C_53BB
    jr Jump_01C_53D9

Jump_01C_53CC::
    ld a, [wCursorBlinkB8]
    ld [hl], a
    inc hl
    inc b
    dec c
    ld a, c
    and a, a
    jr z, Jump_01C_53D9
    jr Jump_01C_53C5

Jump_01C_53D9::
    pop de
    ld a, [wListPages]
    add a, e
    cp a, $18
    jr c, Jump_01C_5400
    ld a, $01
    ld [wScreenState], a
    ld a, $01
    ld [wScreenStep], a
    xor a, a
    ld [wItemGridX], a
    ld [wItemGridY], a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_5400::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld hl, wScreenList
    ld de, Data_01C_5F5E
    ld bc, $0020

Jump_01C_5415::
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01C_5415
    ld hl, wScreenBlock92
    call DrawGoldDigitsAtHLWrapped_1C
    ld hl, wInventory
    ld c, $00
    ld b, $00

Jump_01C_542A::
    ld a, [hl+]
    and a, a
    jr z, Jump_01C_5433
    cp a, $FF
    jr z, Jump_01C_5433
    inc b

Jump_01C_5433::
    inc c
    ld a, c
    cp a, $18
    jr c, Jump_01C_542A
    ld a, b
    ld [wListPages], a
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld a, [wDigits + $1]
    and a, a
    jr z, Jump_01C_5451
    ld a, [wDigits + $1]
    add a, $E0
    ld [wItemCountTens], a

Jump_01C_5451::
    ld a, [wDigits + $2]
    add a, $E0
    ld [wItemCountOnes], a
    call BGMapAddressAtScroll_Bank1C_67AF
    ld a, $0C
    add_a_to_hl
    ld de, wScreenList
    ld bc, $0804
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 4 of the `rst $00` table in ShopMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
ShopMenu_Case04::
Jump_01C_5476:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw ShopMenu_Case03_Case00
    dw ShopMenu_Case03_Case01
    dw ShopMenu_Case04_Case02
    dw ShopMenu_Case04_Case03
    dw ShopMenu_Case04_Case04
    dw ShopMenu_Case04_Case05
    dw ShopMenu_Case04_Case06
    dw ShopMenu_Case04_Case07
    dw ShopMenu_Case04_Case08
    dw ShopMenu_Case04_Case09
    dw ShopMenu_Case03_Case0B
    dw ShopMenu_Case04_Case0B
    dw ShopMenu_Case04_Case0C
    dw ShopMenu_Case04_Case0D

; entry 2 of the `rst $00` table in ShopMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wItemGridY, wSavedSpriteSlotCount, wDigits, wScreenStep, wItemGridX
; writes: wListPages, wSavedSpriteSlotCount, wItemGridY, wChoiceCursorF0, wDigits, wScreenStep, wScreenCounter, wGlyphListPos, ...
; points at: wInventory, wItemGrid
ShopMenu_Case04_Case02::
Jump_01C_5496:: ; address name
    ld hl, wInventory
    ld b, $00
    ld c, $00

Jump_01C_549D::
    ld a, [hl]
    and a, a
    jr z, Jump_01C_54A6
    cp a, $FF
    jr z, Jump_01C_54A6
    inc c

Jump_01C_54A6::
    inc hl
    inc b
    ld a, b
    cp a, $18
    jr c, Jump_01C_549D
    ld a, c
    ld [wListPages], a
    call ListDistinctInventoryItemsToItemGrid
    ld hl, wItemGrid
    ld b, $00
    ld c, $00

Jump_01C_54BB::
    ld a, [hl]
    and a, a
    jr z, Jump_01C_54C0
    inc c

Jump_01C_54C0::
    inc hl
    inc b
    ld a, b
    cp a, $18
    jr c, Jump_01C_54BB
    ld a, c
    ld l, a
    ld h, $00
    ld a, $04
    call DivideHLByA
    push af
    and a, a
    jr z, Jump_01C_54D5
    inc l

Jump_01C_54D5::
    ld a, l
    ld [wSavedSpriteSlotCount], a
    ld a, [wItemGridY]
    inc a
    cp a, l
    jr c, Jump_01C_5510
    pop af
    push af
    and a, a
    jr nz, Jump_01C_54F5
    ld a, [wItemGridY]
    inc a
    cp a, l
    jr z, Jump_01C_5510
    ld a, [wItemGridY]
    dec a
    ld [wItemGridY], a
    jr Jump_01C_5510

Jump_01C_54F5::
    pop af
    dec a
    ld [wChoiceCursorF0], a
    ld b, a
    ld a, [wItemGridX]
    cp a, b
    jr c, Jump_01C_5516
    jr z, Jump_01C_5516
    push bc
    push hl
    call EraseItemGridXCursor
    pop hl
    pop bc
    ld a, b
    ld [wItemGridX], a
    jr Jump_01C_5516

Jump_01C_5510::
    pop af
    ld a, $03
    ld [wChoiceCursorF0], a

Jump_01C_5516::
    ld a, [wSavedSpriteSlotCount]
    cp a, $02
    jr c, Jump_01C_5561
    call DrawC5BEC6AtScroll18E_Bank1C
    call HLToDecimalDigits
    ld a, [wDigits + $1]
    and a, a
    jr nz, Jump_01C_552E
    ld a, $E3
    ld [wDigits + $1], a

Jump_01C_552E::
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0191
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $2]
    add a, $E0
    ld [hl], a
    ei
    ld a, [wItemGridY]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $018F
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $2]
    add a, $E1
    ld [hl], a
    ei

Jump_01C_5561::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenCounter], a
    ld [wGlyphListPos], a
    ret

; entry 3 of the `rst $00` table in ShopMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenCounter, wGlyphListPos, wItemGridY, wCursorBlinkB8, wScreenStep
; writes: wGlyphListPos, wCursorBlinkB8, wScreenCounter, wScreenStep
; points at: wItemGrid
ShopMenu_Case04_Case03::
Jump_01C_5570:: ; address name
    ld a, [wScreenCounter]
    add a, a
    ld hl, TileDestTable_1C_6289
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]

Jump_01C_557F::
    push de
    ld a, [wGlyphListPos]
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_01C_5589
    inc d

Jump_01C_5589::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld de, Data_01F_4910
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    cp a, $09
    jr c, Jump_01C_557F
    xor a, a
    ld [wGlyphListPos], a
    ld hl, wItemGrid
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wScreenCounter]
    add_a_to_hl
    ld a, [hl]
    ld e, a
    ld d, $00
    sla e
    rl d
    ld hl, Data_01C_63FE
    add hl, de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e

Jump_01C_55D2::
    ld a, [hl]
    cp a, $F0
    jp z, Jump_01C_564E
    ld [wCursorBlinkB8], a
    push hl
    ld hl, $4010
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
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    push de
    ld a, [wScreenCounter]
    add a, a
    ld de, TileDestTable_1C_6289
    add a, e
    ld e, a
    jr nc, Jump_01C_5604
    inc d

Jump_01C_5604::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [wCursorBlinkB8]
    cp a, $8D
    jr z, Jump_01C_5616
    cp a, $8E
    jr z, Jump_01C_5616
    jr Jump_01C_561D

Jump_01C_5616::
    ld a, [wGlyphListPos]
    dec a
    ld [wGlyphListPos], a

Jump_01C_561D::
    ld a, [wGlyphListPos]
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    ld b, $1F
    ld c, $10
    ld a, [wCursorBlinkB8]
    cp a, $8D
    jr z, Jump_01C_563F
    cp a, $8E
    jr z, Jump_01C_563F
    call CopyFromBankWaitVRAM
    jr Jump_01C_5642

Jump_01C_563F::
    call OrFromBankWaitVRAM

Jump_01C_5642::
    pop hl
    inc hl
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    jp Jump_01C_55D2

Jump_01C_564E::
    xor a, a
    ld [wGlyphListPos], a
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp a, $04
    jr c, Jump_01C_5669
    xor a, a
    ld [wScreenCounter], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_01C_5669::
    ret

; entry 4 of the `rst $00` table in ShopMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wItemGridY, wScreenCounter, hTemp1, hTemp0, wScreenByteBD, wListEntries2, wScreenByteBF, wScreenByteC0, ...
; writes: wDigits, wScreenByteBD, wListEntries2, wScreenByteBF, wScreenByteC0, wScreenByteC1, wScreenByteEE, wScreenCounter, ...
; points at: wItemGrid, wScreenByteBD
ShopMenu_Case04_Case04::
Jump_01C_566A:: ; address name
    ld hl, wItemGrid
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de

Jump_01C_567C::
    push hl
    ld a, [wScreenCounter]
    add_a_to_hl
    ld a, [hl]
    ld e, a
    ld d, $00
    sla e
    rl d
    call ShopMenu_Shared03
    ld a, l
    ld [wDigits], a
    ld a, h
    ld [wDigits + $1], a
    xor a, a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ldh a, [hTemp1]
    and a, $F0
    swap a
    ld [wScreenByteBD], a
    ldh a, [hTemp1]
    and a, $0F
    ld [wListEntries2], a
    ldh a, [hTemp0]
    and a, $F0
    swap a
    ld [wScreenByteBF], a
    ldh a, [hTemp0]
    and a, $0F
    ld [wScreenByteC0], a
    ld a, [wScreenByteBD]
    and a, a
    jr nz, Jump_01C_56F2
    add a, $E3
    ld [wScreenByteBD], a
    ld a, [wListEntries2]
    and a, a
    jr nz, Jump_01C_56F2
    add a, $E3
    ld [wListEntries2], a
    ld a, [wScreenByteBF]
    and a, a
    jr nz, Jump_01C_56F2
    add a, $E3
    ld [wScreenByteBF], a
    ld a, [wScreenByteC0]
    and a, a
    jr nz, Jump_01C_56F2
    add a, $E3
    ld [wScreenByteC0], a
    ld a, $E3
    ld [wScreenByteC1], a
    jr Jump_01C_56F7

Jump_01C_56F2::
    ld a, $DF
    ld [wScreenByteC1], a

Jump_01C_56F7::
    ld hl, Data_01C_62D9
    ld a, [wScreenCounter]
    add a, a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1C_67AF
    pop de
    add hl, de
    ld e, l
    ld d, h
    xor a, a
    ld [wScreenByteEE], a
    ld hl, wScreenByteBD
    ld c, $00

Jump_01C_5717::
    ld a, [wScreenByteEE]
    and a, a
    jr nz, Jump_01C_572F
    push hl
    ld l, e
    ld h, d
    call StepBGMapAddressBackOnScrollWrap
    cp a, $FF
    jr nz, Jump_01C_572C
    ld a, $01
    ld [wScreenByteEE], a

Jump_01C_572C::
    ld e, l
    ld d, h
    pop hl

Jump_01C_572F::
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    add a, $E0
    ld [de], a
    inc de
    ei
    inc c
    ld a, c
    cp a, $05
    jr c, Jump_01C_5717
    pop hl
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp a, $04
    jp c, Jump_01C_567C
    xor a, a
    ld [wScreenCounter], a
    ld [wGlyphListPos], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in ShopMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wTextCounter0, wScreenStep, wChoiceCursorF0, wItemGridX, wSavedSpriteSlotCount, wItemGridY
; writes: wTextTimer, wScreenState, wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wSelectedRecord, wItemGridX, ...
ShopMenu_Case04_Case05::
Jump_01C_575B:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 4, a
    jr nz, Jump_01C_57AA
    bit 5, a
    jr nz, Jump_01C_57D5
    bit 6, a
    jp nz, Jump_01C_57F0
    bit 7, a
    jp nz, Jump_01C_581C
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_01C_583C
    call BlinkCursorSelectedRecord_Bank1C
    call ShopMenu_Shared01
    ld a, [wTextCounter0]
    cp a, $03
    ret c
    ld a, [wJoypadPressedRepeat]
    bit 1, a
    ret z
    call ResetTextCounter0Counters
    xor a, a
    ld [wTextTimer], a
    ld a, $01
    ld [wScreenState], a
    ld a, $01
    ld [wScreenStep], a
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_57AA::
    ld a, [wSavedSpriteSlotCount]
    cp a, $02
    jr c, Jump_01C_57C8
    call ResetTextCounter0Counters
    ld a, [wSavedSpriteSlotCount]
    ld b, a
    ld a, [wItemGridY]
    inc a
    cp a, b
    jr c, Jump_01C_57C0
    xor a, a

Jump_01C_57C0::
    ld [wItemGridY], a
    ld a, $02
    ld [wScreenStep], a

Jump_01C_57C8::
    xor a, a
    ld [wSelectedRecord], a
    call DrawItemGridXCursor
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01C_57D5::
    ld a, [wSavedSpriteSlotCount]
    cp a, $02
    jr c, Jump_01C_57C8
    call ResetTextCounter0Counters
    ld a, [wItemGridY]
    and a, a
    jr nz, Jump_01C_57EC
    ld a, [wSavedSpriteSlotCount]
    dec a
    jp Jump_01C_57C0

Jump_01C_57EC::
    dec a
    jp Jump_01C_57C0

Jump_01C_57F0::
    xor a, a
    ld [wSelectedRecord], a
    ld a, [wChoiceCursorF0]
    and a, a
    jr z, Jump_01C_580F
    call ResetTextCounter0Counters
    call EraseItemGridXCursor
    ld a, [wItemGridX]
    and a, a
    jr nz, Jump_01C_580B
    ld a, [wChoiceCursorF0]
    jr Jump_01C_580C

Jump_01C_580B::
    dec a

Jump_01C_580C::
    ld [wItemGridX], a

Jump_01C_580F::
    xor a, a
    ld [wSelectedRecord], a
    call DrawItemGridXCursor
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01C_581C::
    xor a, a
    ld [wSelectedRecord], a
    ld a, [wChoiceCursorF0]
    and a, a
    jr z, Jump_01C_580F
    call ResetTextCounter0Counters
    call EraseItemGridXCursor
    ld a, [wChoiceCursorF0]
    ld b, a
    ld a, [wItemGridX]
    cp a, b
    jr c, Jump_01C_5839
    xor a, a
    jr Jump_01C_580C

Jump_01C_5839::
    inc a
    jr Jump_01C_580C

Jump_01C_583C::
    ld a, $69
    call QueueSoundEffect
    call DrawItemGridXCursorConfirmed
    call ResetTextCounter0Counters
    xor a, a
    ld [wTextTimer], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 6 of the `rst $00` table in ShopMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wItemGridY, wItemGridX, wScreenStep
; writes: wScreenStep, wTextTimer, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wCursorBlinkCD, wNumberTens, wNumberOnes, ...
; points at: wItemGrid
ShopMenu_Case04_Case06::
Jump_01C_5853:: ; address name
    call ResetTextCounter0Counters
    ld hl, wItemGrid
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wItemGridX]
    add_a_to_hl
    ld a, [hl]
    ld e, a
    ld d, $00
    sla e
    rl d
    call ShopMenu_Shared03
    ld a, l
    and a, a
    jr nz, Jump_01C_589D
    ld a, h
    and a, a
    jr nz, Jump_01C_589D
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    xor a, a
    ld [wTextTimer], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_589D::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld [wCursorBlinkCD], a
    ld [wNumberTens], a
    ld a, $01
    ld [wNumberOnes], a
    ld [wNumberEditPos], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 7 of the `rst $00` table in ShopMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wNumberTens, wNumberOnes, wCountTens, wCountOnes, wScreenStep
; writes: wNumberTens, wNumberOnes, wScreenByte90, wScreenByte91, wScreenByte93, wScreenByte94, wScreenStep
; points at: wScreenList
ShopMenu_Case04_Case07::
Jump_01C_58C0:: ; address name
    xor a, a
    ld [wNumberTens], a
    ld a, $01
    ld [wNumberOnes], a
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld de, vBGMap1 + $3B0
    ld b, $00
    ld c, $00
    push hl
    push hl

Jump_01C_58DC::
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ld [de], a
    ei
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_01C_58FD
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

Jump_01C_58FD::
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $07
    jp c, Jump_01C_58DC
    xor a, a
    ld c, a
    pop hl
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    push hl
    inc b
    ld a, b
    cp a, $03
    jp c, Jump_01C_58DC
    pop hl
    pop hl
    ld a, [wIsCGB]
    or a, a
    jr z, Jump_01C_5954
    push bc
    ld c, $4F
    ld a, $01
    ldh [c], a
    pop bc
    di
    call WaitForVRAMAccess
    xor a, a
    ld [hl], a
    ei
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    di
    call WaitForVRAMAccess
    xor a, a
    ld [hl], a
    ei
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    di
    call WaitForVRAMAccess
    xor a, a
    ld [hl], a
    ei
    push bc
    ld c, $4F
    ld a, $00
    ldh [c], a
    pop bc

Jump_01C_5954::
    ld hl, wScreenList
    ld de, Data_01C_62ED
    ld bc, $0015

Jump_01C_595D::
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01C_595D
    ld a, [wNumberTens]
    add a, $E0
    ld [wScreenByte90], a
    ld a, [wNumberOnes]
    add a, $E0
    ld [wScreenByte91], a
    call CountItemInInventoryToDigits
    ld a, [wCountTens]
    and a, a
    jr nz, Jump_01C_5985
    ld a, $C3
    ld [wScreenByte93], a
    jr Jump_01C_598D

Jump_01C_5985::
    ld a, [wCountTens]
    add a, $E0
    ld [wScreenByte93], a

Jump_01C_598D::
    ld a, [wCountOnes]
    add a, $E0
    ld [wScreenByte94], a
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    ld bc, $0703
    ld de, wScreenList
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 8 of the `rst $00` table in ShopMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wNumberTens, wNumberOnes, wScreenStep, wNumberEditPos, wCountOnes, wCountTens
; writes: wTwoChoiceCursor, wTextTimer, wScreenStep, wNumberTens, wNumberOnes, wNumberEditPos, wScriptCommandType, wScriptStartRequest
ShopMenu_Case04_Case08::
Jump_01C_59AD:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 1, a
    jr nz, Jump_01C_59D2
    bit 4, a
    jr nz, Jump_01C_59FA
    bit 5, a
    jr nz, Jump_01C_5A0F
    bit 6, a
    jp nz, Jump_01C_5A1F
    bit 7, a
    jp nz, Jump_01C_5AA6
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_01C_5B36
    call BlinkCursorBlinkCD_Bank1C_5B61
    ret

Jump_01C_59D2::
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    ld bc, $0703
    ld de, vBGMap1 + $3B0
    call DrawRectBothBanksSetTextCursorLoPlus1C1
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $05
    ld [wScreenStep], a
    xor a, a
    ld [wTextTimer], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_59FA::
    call ShopMenu_Case04_Case08_Sub01
    ld a, [wNumberEditPos]
    cp a, $01
    jr nz, Jump_01C_5A07
    xor a, a
    jr Jump_01C_5A08

Jump_01C_5A07::
    inc a

Jump_01C_5A08::
    ld [wNumberEditPos], a
    call BlinkCursorBlinkCD_Bank1C_5B61
    ret

Jump_01C_5A0F::
    call ShopMenu_Case04_Case08_Sub01
    ld a, [wNumberEditPos]
    and a, a
    jr nz, Jump_01C_5A1C
    ld a, $01
    jr Jump_01C_5A08

Jump_01C_5A1C::
    dec a
    jr Jump_01C_5A08

Jump_01C_5A1F::
    ld a, $69
    call QueueSoundEffect
    ld a, [wNumberEditPos]
    and a, a
    jr nz, Jump_01C_5A6A
    ld a, [wCountTens]
    ld b, a
    ld a, [wNumberTens]
    cp a, b
    jr c, Jump_01C_5A58
    ld a, b
    ld [wNumberTens], a
    ld a, [wCountOnes]
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtTable5008And5BE4
    ret

Jump_01C_5A42::
    ld a, [wCountOnes]
    ld b, a
    ld a, [wNumberOnes]
    cp a, b
    jr c, Jump_01C_5A54
    ld a, b
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtTable5008And5BE4
    ret

Jump_01C_5A54::
    call DrawNumberTensNumberOnesDigitsAtTable5008And5BE4
    ret

Jump_01C_5A58::
    inc a
    ld [wNumberTens], a
    push af
    ld a, [wCountTens]
    ld b, a
    pop af
    cp a, b
    jp nc, Jump_01C_5A42
    call BlinkCursorBlinkCD_Bank1C_5B61
    ret

Jump_01C_5A6A::
    ld a, [wCountTens]
    ld b, a
    ld a, [wNumberTens]
    cp a, b
    jr c, Jump_01C_5A7A
    ld a, [wCountOnes]
    ld b, a
    jr Jump_01C_5A7C

Jump_01C_5A7A::
    ld b, $09

Jump_01C_5A7C::
    ld a, [wNumberOnes]
    cp a, b
    jr c, Jump_01C_5A9E
    ld a, [wCountOnes]
    cp a, b
    jr nz, Jump_01C_5A8C
    call BlinkCursorBlinkCD_Bank1C_5B61
    ret

Jump_01C_5A8C::
    ld a, [wNumberTens]
    and a, a
    jr nz, Jump_01C_5A96
    ld a, $01
    jr Jump_01C_5A97

Jump_01C_5A96::
    xor a, a

Jump_01C_5A97::
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1C_5B61
    ret

Jump_01C_5A9E::
    inc a
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1C_5B61
    ret

Jump_01C_5AA6::
    ld a, $69
    call QueueSoundEffect
    ld a, [wNumberEditPos]
    and a, a
    jr nz, Jump_01C_5AF6
    ld a, [wNumberTens]
    and a, a
    jr nz, Jump_01C_5ADB
    ld a, [wCountOnes]
    ld b, a
    ld a, [wNumberOnes]
    cp a, b
    jr c, Jump_01C_5AD1
    ld a, [wCountTens]
    ld [wNumberTens], a
    ld a, [wCountOnes]
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtTable5008And5BE4
    ret

Jump_01C_5AD1::
    ld a, [wCountTens]
    ld [wNumberTens], a
    call BlinkCursorBlinkCD_Bank1C_5B61
    ret

Jump_01C_5ADB::
    dec a
    ld [wNumberTens], a
    ld a, [wNumberTens]
    ld b, a
    ld a, [wNumberOnes]
    or a, b
    jr nz, Jump_01C_5AF2
    ld a, $01
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtTable5008And5BE4
    ret

Jump_01C_5AF2::
    call BlinkCursorBlinkCD_Bank1C_5B61
    ret

Jump_01C_5AF6::
    ld a, [wNumberTens]
    and a, a
    jr nz, Jump_01C_5B05
    ld a, [wNumberOnes]
    cp a, $01
    jr nz, Jump_01C_5B2E
    jr Jump_01C_5B0B

Jump_01C_5B05::
    ld a, [wNumberOnes]
    and a, a
    jr nz, Jump_01C_5B2E

Jump_01C_5B0B::
    ld a, [wCountTens]
    ld b, a
    ld a, [wNumberTens]
    cp a, b
    jr c, Jump_01C_5B25
    ld a, [wCountTens]
    ld [wNumberTens], a
    ld a, [wCountOnes]
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtTable5008And5BE4
    ret

Jump_01C_5B25::
    ld a, $09
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1C_5B61
    ret

Jump_01C_5B2E::
    dec a
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1C_5B61
    ret

Jump_01C_5B36::
    ld a, [wNumberTens]
    and a, a
    jr nz, Jump_01C_5B46
    ld a, [wNumberOnes]
    and a, a
    jr nz, Jump_01C_5B46
    call ShopMenu_Case04_Case08_Sub01
    ret

Jump_01C_5B46::
    ld a, $69
    call QueueSoundEffect
    call ShopMenu_Case04_Case08_Sub01
    call ShopMenu_Case04_Case08_Sub02
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wTextTimer], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; cycles wD7CD through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (E-0122)
; 10 call sites from 1 routine (e.g. ShopMenu_Case04_Case08)
; reads: wCursorBlinkCD, wNumberEditPos, wNumberTens, wNumberOnes
; writes: wCursorBlinkCD
BlinkCursorBlinkCD_Bank1C_5B61::
Func_01C_5B61:: ; address name
    ld a, [wCursorBlinkCD]
    inc a
    ld [wCursorBlinkCD], a
    cp a, $10
    jr c, ShopMenu_Case04_Case08_Sub01
    cp a, $18
    jr c, Jump_01C_5B87
    xor a, a
    ld [wCursorBlinkCD], a

; only called from ShopMenu_Case04_Case08 (E-0047)
; 4 call sites from 1 routine (e.g. ShopMenu_Case04_Case08)
; reads: wNumberEditPos, wNumberTens, wNumberOnes
ShopMenu_Case04_Case08_Sub01::
Func_01C_5B74:: ; address name
    ld a, [wNumberEditPos]
    and a, a
    jr nz, Jump_01C_5B7F
    ld a, [wNumberTens]
    jr Jump_01C_5B82

Jump_01C_5B7F::
    ld a, [wNumberOnes]

Jump_01C_5B82::
    add a, $E0
    ld b, a
    jr Jump_01C_5B89

Jump_01C_5B87::
    ld b, $CB

Jump_01C_5B89::
    ld a, [wNumberEditPos]
    add a, a
    ld hl, Data_01C_5008
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1C_67AF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; writes wD7CA and wD7CB as digit tiles at the scroll offsets in Data_01C_5008 and Data_01C_5BE4 (E-0121)
; 6 call sites from 1 routine (e.g. ShopMenu_Case04_Case08)
; reads: wNumberTens, wNumberOnes
DrawNumberTensNumberOnesDigitsAtTable5008And5BE4::
Func_01C_5BA9:: ; address name
    ld hl, Data_01C_5008
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1C_67AF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld a, [wNumberTens]
    add a, $E0
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ld hl, Data_01C_5BE4
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1C_67AF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld a, [wNumberOnes]
    add a, $E0
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret
    db $61, $01

; address loaded by DrawNumberTensNumberOnesDigitsAtTable5008And5BE4
Data_01C_5BE4:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $62, $01

; only called from ShopMenu_Case04_Case08 (E-0047)
; 1 call site from 1 routine (e.g. ShopMenu_Case04_Case08)
; reads: wNumberTens, wNumberOnes, wItemGridY, wItemGridX
; writes: wThreeDigits
; points at: wItemGrid
ShopMenu_Case04_Case08_Sub02::
Func_01C_5BE6:: ; address name
    ld a, [wNumberTens]
    ld e, a
    ld d, $00
    ld l, a
    ld h, $00
    sla l
    rl h
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    ld a, [wNumberOnes]
    add a, e
    ld e, a
    jr nc, Jump_01C_5C0C
    inc d

Jump_01C_5C0C::
    push de
    ld hl, wItemGrid
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wItemGridX]
    add_a_to_hl
    ld a, [hl]
    ld e, a
    ld d, $00
    sla e
    rl d
    call ShopMenu_Shared03
    ld c, l
    ld b, h
    pop de
    ld a, e
    call Multiply8By16
    ld a, e
    ld [wThreeDigits + $2], a
    ld a, h
    ld [wThreeDigits + $1], a
    ld a, l
    ld [wThreeDigits], a
    ret

; entry 9 of the `rst $00` table in ShopMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wItemGridY, wItemGridX, hTemp2, hTemp1, hTemp0, wScreenList, wListEntries, wGrid2CursorX, ...
; writes: wCursorBlinkB8, wDigits, wScreenList, wListEntries, wGrid2CursorX, wGrid2CursorY, wScreenArea, wScreenByte8D, ...
; points at: wItemGrid, wTextBuf0, wThreeDigits, wScreenList
ShopMenu_Case04_Case09::
Jump_01C_5C46:: ; address name
    ld hl, wItemGrid
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wItemGridX]
    add_a_to_hl
    ld a, [hl]
    ld [wCursorBlinkB8], a
    ld de, wTextBuf0
    push de
    ld hl, wThreeDigits
    ld a, [hl+]
    ld [wDigits], a
    ld a, [hl+]
    ld [wDigits + $1], a
    ld a, [hl]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ldh a, [hTemp2]
    and a, $F0
    swap a
    ld [wScreenList], a
    ldh a, [hTemp2]
    and a, $0F
    ld [wListEntries], a
    ldh a, [hTemp1]
    and a, $F0
    swap a
    ld [wGrid2CursorX], a
    ldh a, [hTemp1]
    and a, $0F
    ld [wGrid2CursorY], a
    ldh a, [hTemp0]
    and a, $F0
    swap a
    ld [wScreenArea], a
    ldh a, [hTemp0]
    and a, $0F
    ld [wScreenByte8D], a
    ld c, $00
    ld a, [wScreenList]
    and a, a
    jr nz, Jump_01C_5CE3
    ld a, $90
    ld [wScreenList], a
    ld a, [wListEntries]
    and a, a
    jr nz, Jump_01C_5CE3
    ld a, $90
    ld [wListEntries], a
    ld a, [wGrid2CursorX]
    and a, a
    jr nz, Jump_01C_5CE3
    ld a, $90
    ld [wGrid2CursorX], a
    ld a, [wGrid2CursorY]
    and a, a
    jr nz, Jump_01C_5CE3
    ld a, $90
    ld [wGrid2CursorY], a
    ld a, [wScreenArea]
    and a, a
    jr nz, Jump_01C_5CE3
    ld a, $90
    ld [wScreenArea], a

Jump_01C_5CE3::
    pop de
    ld hl, wScreenList
    ld c, $00

Jump_01C_5CE9::
    ld a, [hl]
    cp a, $90
    jr nz, Jump_01C_5CF2
    inc c
    inc hl
    jr Jump_01C_5CE9

Jump_01C_5CF2::
    ld a, [hl+]
    ld [de], a
    inc de
    inc c
    ld a, c
    cp a, $06
    jr c, Jump_01C_5CE9
    ld a, $F0
    ld [de], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenByteD1], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 11 of the `rst $00` table in ShopMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wScreenStep, wScreenByteD1
; writes: wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wScreenByteD1
ShopMenu_Case04_Case0B::
Jump_01C_5D13:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_01C_5D2F
    bit 7, a
    jr nz, Jump_01C_5D49
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, Jump_01C_5D59
    bit 1, a
    jp nz, Jump_01C_5D7D
    call BlinkCursorBlinkD2_Bank1C_5DA4
    ret

Jump_01C_5D2F::
    call DrawBlankTileC3_5DC2_Bank1C
    ld a, [wScreenByteD1]
    and a, a
    jr nz, Jump_01C_5D3C
    ld a, $01
    jr Jump_01C_5D3D

Jump_01C_5D3C::
    dec a

Jump_01C_5D3D::
    ld [wScreenByteD1], a
    call BlinkCursorBlinkD2_Bank1C_5DA4
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01C_5D49::
    call DrawBlankTileC3_5DC2_Bank1C
    ld a, [wScreenByteD1]
    cp a, $01
    jr c, Jump_01C_5D56
    xor a, a
    jr Jump_01C_5D3D

Jump_01C_5D56::
    inc a
    jr Jump_01C_5D3D

Jump_01C_5D59::
    ld a, $69
    call QueueSoundEffect
    call ShopMenu_Case04_Case0B_Sub01
    ld a, [wScreenByteD1]
    and a, a
    jr nz, Jump_01C_5D7D
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_5D7D::
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $010E
    add hl, de
    ld bc, $0605
    ld de, vBGMap1 + $3D0
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    ld a, [wScreenStep]
    sub a, $03
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; cycles wD7D2 through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (after the joypad repeat timer reaches $14) (E-0122)
; 2 call sites from 1 routine (e.g. ShopMenu_Case04_Case0B)
; reads: wJoypadRepeatTimer, wCursorBlinkD2, wScreenByteD1
; writes: wCursorBlinkD2
BlinkCursorBlinkD2_Bank1C_5DA4::
Func_01C_5DA4:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, Jump_01C_5DBE
    ld a, [wCursorBlinkD2]
    inc a
    ld [wCursorBlinkD2], a
    cp a, $10
    jr c, Jump_01C_5DBE
    cp a, $18
    jr c, DrawBlankTileC3_5DC2_Bank1C
    xor a, a
    ld [wCursorBlinkD2], a

Jump_01C_5DBE::
    ld b, $BB
    jr Jump_01C_5DC8

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. ShopMenu_Case04_Case0B)
; reads: wScreenByteD1
DrawBlankTileC3_5DC2_Bank1C::
Func_01C_5DC2:: ; address name
    ld b, $C3
    jr Jump_01C_5DC8

; only called from ShopMenu_Case04_Case0B (E-0047)
; 1 call site from 1 routine (e.g. ShopMenu_Case04_Case0B)
; reads: wScreenByteD1
ShopMenu_Case04_Case0B_Sub01::
Func_01C_5DC6:: ; address name
    ld b, $BC

Jump_01C_5DC8::
    ld a, [wScreenByteD1]
    add a, a
    ld hl, Data_01C_5DE8
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    push de
    call BGMapAddressAtScroll_Bank1C_67AF
    pop de
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; address loaded by ShopMenu_Case04_Case0B_Sub01
Data_01C_5DE8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $2F, $01, $6F, $01

; entry 12 of the `rst $00` table in ShopMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
ShopMenu_Case04_Case0C::
Jump_01C_5DEC:: ; address name
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $010E
    add hl, de
    ld bc, $0605
    ld de, vBGMap1 + $3D0
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    ld bc, $0703
    ld de, vBGMap1 + $3B0
    call DrawRectBothBanksSetTextCursorLoPlus1C1
    ld a, $01
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 13 of the `rst $00` table in ShopMenu_Case04
; no direct call (reached through a table, a jump or a vector)
; reads: wThreeDigits, wScreenStep, wDigits
; writes: wArg3, wArg2, wArg1, wListPages, wScreenState, wScreenStep, wTwoChoiceCursor, wItemGridX, ...
; points at: wInventory, wScreenList, wScreenBlock92
ShopMenu_Case04_Case0D::
Jump_01C_5E1B:: ; address name
    ld a, [wThreeDigits + $2]
    ld [wArg3], a
    ld a, [wThreeDigits + $1]
    ld [wArg2], a
    ld a, [wThreeDigits]
    ld [wArg1], a
    call AddArg1ToGoldCapped99999
    call RemoveItemCountFromInventory
    ld hl, wInventory
    ld b, $00
    ld c, $00

Jump_01C_5E3A::
    ld a, [hl]
    and a, a
    jr z, Jump_01C_5E43
    cp a, $FF
    jr z, Jump_01C_5E43
    inc c

Jump_01C_5E43::
    inc hl
    inc b
    ld a, b
    cp a, $18
    jr c, Jump_01C_5E3A
    ld a, c
    ld [wListPages], a
    and a, a
    jr nz, Jump_01C_5E6F
    ld a, $01
    ld [wScreenState], a
    ld a, $01
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld [wItemGridX], a
    ld [wItemGridY], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_5E6F::
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld hl, wScreenList
    ld de, Data_01C_5F5E
    ld bc, $0020

Jump_01C_5E84::
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01C_5E84
    ld hl, wScreenBlock92
    call DrawGoldDigitsAtHLWrapped_1C
    ld hl, wInventory
    ld c, $00
    ld b, $00

Jump_01C_5E99::
    ld a, [hl+]
    and a, a
    jr z, Jump_01C_5EA2
    cp a, $FF
    jr z, Jump_01C_5EA2
    inc b

Jump_01C_5EA2::
    inc c
    ld a, c
    cp a, $18
    jr c, Jump_01C_5E99
    ld a, b
    ld [wListPages], a
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld a, [wDigits + $1]
    and a, a
    jr z, Jump_01C_5EC0
    ld a, [wDigits + $1]
    add a, $E0
    ld [wItemCountTens], a

Jump_01C_5EC0::
    ld a, [wDigits + $2]
    add a, $E0
    ld [wItemCountOnes], a
    call BGMapAddressAtScroll_Bank1C_67AF
    ld a, $0C
    add_a_to_hl
    ld de, wScreenList
    ld bc, $0804
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    xor a, a
    ld [wItemGridX], a
    ld [wItemGridY], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from routines of ShopMenu (E-0098)
; 2 call sites from 2 routines (e.g. ShopMenu_Case03_Case09_Sub02, ShopMenu_Case03_Case05)
; points at: wInventory, wArg1
ShopMenu_Shared02::
Func_01C_5EEC:: ; address name
    push hl
    ld hl, wInventory
    ld b, $18

Jump_01C_5EF2::
    ld a, [hl]
    and a, a
    jr z, Jump_01C_5EFA
    cp a, $2D
    jr z, Jump_01C_5F00

Jump_01C_5EFA::
    inc hl
    dec b
    jr nz, Jump_01C_5EF2
    jr Jump_01C_5F24

Jump_01C_5F00::
    pop hl
    push hl
    ld e, l
    ld d, h
    ld b, $F2
    call ReadFarPointerAtDEInBankB
    ld e, b
    ld a, $09
    call Multiply24By8_Bank1C
    ld a, $0A
    call Divide24ByA
    ld bc, wArg1
    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    inc bc
    ld a, e
    ld [bc], a
    pop hl
    ld hl, wArg1
    ret

Jump_01C_5F24::
    pop hl
    ret

; HL and B = the 3-byte far pointer entry wD7FB of Data_0F2_5643 in bank $F2 (ReadFarPointerAtDEInBankB); DE kept (E-0118)
; 2 call sites from 2 routines (e.g. ShopMenu_Case03_Case09_Sub02, ShopMenu_Case03_Case05)
; reads: wScreenTableIndex
ReadF2FarPointerForScreenTableIndex::
Func_01C_5F26:: ; address name
    push de
    ld a, [wScreenTableIndex]
    ld e, a
    ld d, $00
    sla e
    rl d
    ld hl, ScreenNumberListTable
    add hl, de
    ld e, l
    ld d, h
    ld b, $F2
    call ReadFarPointerAtDEInBankB
    pop de
    ret

; only called from routines of ShopMenu (E-0098)
; 3 call sites from 3 routines (e.g. ShopMenu_Case04_Case08_Sub02, ShopMenu_Case04_Case06, ShopMenu_Case04_Case04)
; reads: wScreenTableIndex
ShopMenu_Shared03::
Func_01C_5F3E:: ; address name
    push bc
    ld hl, ShopPercentTable
    ld a, [wScreenTableIndex]
    add_a_to_hl
    ld a, [hl]
    push af
    ld hl, ItemValueTable
    add hl, de
    ld c, [hl]
    inc hl
    ld b, [hl]
    pop af
    call Multiply8By16
    ld a, $64
    call Divide24ByA
    pop bc
    ret

; address loaded by ShopMenu_Case03_Case0E, ShopMenu_Case04_Case0D, InitItemListScreenListAndCount, VaultMenu_Case03_Case17 and 1 more
Data_01C_5F5E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $BF, $C3, $C3, $C3, $C3, $C3, $B7
    db $B8, $B9, $B9, $B9, $B9, $B9, $B9, $BA, $B6, $AE, $AD, $EC, $AF, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: VRAM destinations, then $FFxx
TileCopyDestList_1C_5F86::
Data_01C_5F86:: ; address name
    dw vTiles1 + $6A0, vTiles1 + $6B0, vTiles1 + $6C0, vTiles1 + $6D0, vTiles1 + $6E0, vTiles1 + $6F0, vTiles1 + $700, vTiles1 + $710 ; entry 0
    dw vTiles1 + $720, vTiles1 + $730, vTiles1 + $740, vTiles1 + $750, vTiles1 + $760, vTiles1 + $770, vTiles1 + $780, vTiles1 + $790
    dw vTiles1 + $7A0, vTiles1 + $7B0, vTiles1 + $7C0, vTiles1 + $7D0, vTiles1 + $7E0, vTiles1 + $7F0, vTiles1 + $500, vTiles1 + $510
    dw vTiles1 + $520, vTiles1 + $530, vTiles1 + $540, vTiles1 + $550, vTiles1 + $560, vTiles1 + $570, vTiles1 + $580, vTiles1 + $590
    dw vTiles1 + $5A0, vTiles1 + $5B0, vTiles1 + $5C0, vTiles1 + $5D0, vTiles1 + $5E0, vTiles1 + $2A0, vTiles1 + $2B0, vTiles1 + $2C0
    dw vTiles1 + $2D0, vTiles1 + $2E0, vTiles1 + $2F0, vTiles1 + $470, vTiles1 + $480, vTiles1 + $490, vTiles1 + $4A0, vTiles1 + $4B0
    dw rIE

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: bank-$1F tile sources
TileCopySrcList_1C_5FE8::
Data_01C_5FE8:: ; address name
    dw $40C0, $4390, $43D0, $41D0, $4330, $4300, $4910, $4910 ; entry 0
    dw $4910, $4910, $4910, $4910, $4910, $4910, $4910, $4910
    dw $4910, $4910, $4910, $4910, $4910, $4910, $4910, $4910
    dw $4910, $4910, $4910, $4910, $4910, $4910, $4910, $4910
    dw $4910, $4910, $4910, $4910, $4910, $4910, $43C0, $42D0
    dw $4380, $41B0, $4A40, $4910, $4910, $4910, $4910, $4A00
    dw $FFFF

; E-0225 (derived: a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a low byte of $FF)
; record: bank-$1F tile sources
TileCopySrcList_1C_604A::
Data_01C_604A:: ; address name
    dw $4210, $42D0, $43D0, $42C0, $4280, $4360, $4910, $4910 ; entry 0
    dw $4910, $4910, $4910, $4910, $4910, $4910, $4910, $4910
    dw $4910, $4910, $4910, $4910, $4910, $4910, $4910, $4910
    dw $4910, $4910, $4910, $4910, $4910, $4910, $4910, $4910
    dw $4910, $4910, $4910, $4910, $4910, $4910, $4250, $43B0
    dw $4380, $41B0, $4A40, $4910, $4910, $4910, $4910, $4A00
    dw $FFFF

; address loaded by ShopMenu_Case03_Case00
Data_01C_60AC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0
    ds $11, $B1
    db $B2, $B6, $C3, $F0, $F1, $F2, $F3, $F4, $F5, $F6, $F7, $C7, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $B7, $B6
    ds $11, $C3
    db $B7, $B6, $C3, $F8, $F9, $FA, $FB, $FC, $FD, $FE, $FF, $C8, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $B7, $B6
    ds $11, $C3
    db $B7, $B6, $C3, $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $C9, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $B7, $B6
    ds $11, $C3
    db $B7, $B6, $C3, $D8, $D9, $DA, $DB, $DC, $DD, $DE, $AA, $CA, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $B7, $B3
    ds $11, $B4
    db $B5, $7F

; E-0238 (C1: LoadArg1PointerForScreenTableIndex loads wArg1/wArg2 with the word at $6158 + 2 * wScreenTableIndex, and LoadArg1ByteForItemGridXItemGridY reads the byte at that pointer + 4 * wItemGridY + wItemGridX; 24 words, several sharing a list; the lists run to $6289).
; record: item list ($FF ends)
ShopItemListTable::
Data_01C_6158:: ; address name
    dw ShopItems000 ; id 0
    dw ShopItems001 ; id 1
    dw ShopItems002 ; id 2
    dw ShopItems003 ; id 3
    dw ShopItems004 ; id 4
    dw ShopItems005 ; id 5
    dw ShopItems006 ; id 6
    dw ShopItems007 ; id 7
    dw ShopItems008 ; id 8
    dw ShopItems009 ; id 9
    dw ShopItems00A ; id 10
    dw ShopItems00B ; id 11
    dw ShopItems00C ; id 12
    dw ShopItems00D ; id 13
    dw ShopItems00E ; id 14
    dw ShopItems00F ; id 15
    dw ShopItems010 ; id 16
    dw ShopItems011 ; id 17
    dw ShopItems012 ; id 18
    dw ShopItems013 ; id 19
    dw ShopItems005 ; id 20
    dw ShopItems005 ; id 21
    dw ShopItems005 ; id 22
    dw ShopItems017 ; id 23

; E-0199 (derived: list for entry $00 of ShopItemListTable; it runs to the next list)
; record: item numbers, then $FF
ShopItems000::
Data_01C_6188:: ; address name
    db $01, $02, $06, $19, $1A, $29, $2B, $53, $FF ; id 0

; E-0199 (derived: list for entry $01 of ShopItemListTable; it runs to the next list)
; record: item numbers, then $FF
ShopItems001::
Data_01C_6191:: ; address name
    db $03, $04, $07, $08, $09, $0A, $1B, $2E, $2B, $FF, $FF, $FF ; id 0

; E-0199 (derived: list for entry $02 of ShopItemListTable; it runs to the next list)
; record: item numbers, then $FF
ShopItems002::
Data_01C_619D:: ; address name
    db $05, $0C, $1C, $22, $23, $24, $25, $1F, $21, $2D, $FF, $FF ; id 0

; E-0199 (derived: list for entry $03 of ShopItemListTable; it runs to the next list)
; record: item numbers, then $FF
ShopItems003::
Data_01C_61A9:: ; address name
    db $01, $06, $09, $19, $29, $FF, $FF, $FF ; id 0

; E-0199 (derived: list for entry $04 of ShopItemListTable; it runs to the next list)
; record: item numbers, then $FF
ShopItems004::
Data_01C_61B1:: ; address name
    db $01, $02, $06, $09, $1A, $29, $2B, $FF ; id 0

; E-0199 (derived: list for entry $05 of ShopItemListTable; it runs to the next list)
; record: item numbers, then $FF
ShopItems005::
Data_01C_61B9:: ; address name
    db $FF ; id 0

; E-0199 (derived: list for entry $06 of ShopItemListTable; it runs to the next list)
; record: item numbers, then $FF
ShopItems006::
Data_01C_61BA:: ; address name
    db $02, $06, $09, $1A, $1B, $28, $2A, $FF ; id 0

; E-0199 (derived: list for entry $07 of ShopItemListTable; it runs to the next list)
; record: item numbers, then $FF
ShopItems007::
Data_01C_61C2:: ; address name
    db $02, $06, $07, $08, $1A, $1B, $28, $2A, $2E, $FF, $FF, $FF ; id 0

; E-0199 (derived: list for entry $08 of ShopItemListTable; it runs to the next list)
; record: item numbers, then $FF
ShopItems008::
Data_01C_61CE:: ; address name
    db $02, $03, $04, $0A, $1A, $28, $2A, $FF ; id 0

; E-0199 (derived: list for entry $09 of ShopItemListTable; it runs to the next list)
; record: item numbers, then $FF
ShopItems009::
Data_01C_61D6:: ; address name
    db $08, $0C, $1B, $2B, $2E, $1F, $21, $2D, $FF ; id 0

; E-0199 (derived: list for entry $0A of ShopItemListTable; it runs to the next list)
; record: item numbers, then $FF
ShopItems00A::
Data_01C_61DF:: ; address name
    db $13, $14, $15, $16, $17, $18, $FF, $FF ; id 0

; E-0199 (derived: list for entry $0B of ShopItemListTable; it runs to the next list)
; record: item numbers, then $FF
ShopItems00B::
Data_01C_61E7:: ; address name
    db $02, $07, $0A, $1B, $29, $2A, $2E, $FF ; id 0

; E-0199 (derived: list for entry $0C of ShopItemListTable; it runs to the next list)
; record: item numbers, then $FF
ShopItems00C::
Data_01C_61EF:: ; address name
    db $02, $07, $0A, $1B, $28, $2A, $2B, $2E, $FF ; id 0

; E-0199 (derived: list for entry $0D of ShopItemListTable; it runs to the next list)
; record: item numbers, then $FF
ShopItems00D::
Data_01C_61F8:: ; address name
    db $02, $03, $04, $1B, $1C, $20, $28, $2A, $FF ; id 0

; E-0199 (derived: list for entry $0E of ShopItemListTable; it runs to the next list)
; record: item numbers, then $FF
ShopItems00E::
Data_01C_6201:: ; address name
    db $02, $03, $04, $0C, $1C, $20, $28, $2A, $2B, $2E, $FF, $FF ; id 0

; E-0199 (derived: list for entry $0F of ShopItemListTable; it runs to the next list)
; record: item numbers, then $FF
ShopItems00F::
Data_01C_620D:: ; address name
    db $01, $02, $03, $04, $06, $07, $08, $0A, $1B, $20, $28, $2A, $FF ; id 0

; E-0199 (derived: list for entry $10 of ShopItemListTable; it runs to the next list)
; record: item numbers, then $FF
ShopItems010::
Data_01C_621A:: ; address name
    db $01, $02, $03, $05, $06, $07, $08, $27, $FF ; id 0

; E-0199 (derived: list for entry $11 of ShopItemListTable; it runs to the next list)
; record: item numbers, then $FF
ShopItems011::
Data_01C_6223:: ; address name
    db $02, $04, $0B, $1C, $20, $21, $FF, $FF ; id 0

; E-0199 (derived: list for entry $12 of ShopItemListTable; it runs to the next list)
; record: item numbers, then $FF
ShopItems012::
Data_01C_622B:: ; address name
    db $02, $03, $05, $1C, $20, $24, $28, $2A, $FF ; id 0

; E-0199 (derived: list for entry $13 of ShopItemListTable; it runs to the next list)
; record: item numbers, then $FF
ShopItems013::
Data_01C_6234:: ; address name
    db $01, $02, $04, $06, $1B, $20, $28, $2A, $FF ; id 0

; E-0199 (derived: list for entry $17 of ShopItemListTable; it runs to the next list)
; record: item numbers, then $FF
ShopItems017::
Data_01C_623D:: ; address name
    db $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F, $50, $51, $52, $53, $5A, $5B, $5C, $5D, $5E, $5F, $60, $61, $FF, $FF ; id 0

; E-0238 (C1: ShopMenu_Case03_Case03 and four other sites read the word at $6289 + 2 * wScreenCounter, then the word at 2 * wGlyphListPos of that list, and copy the bank-$1F tile at $4910 there (CopyFromBankWaitVRAM, 16 bytes)).
; record: list of VRAM tile addresses
TileDestTable_1C_6289::
Data_01C_6289:: ; address name
    dw TileDests_1C_0 ; id 0
    dw TileDests_1C_1 ; id 1
    dw TileDests_1C_2 ; id 2
    dw TileDests_1C_3 ; id 3

; E-0238 (C1: list 0 of TileDestTable_1C_6289; 9 words).
; record: VRAM tile addresses, indexed by wGlyphListPos
TileDests_1C_0::
Data_01C_6291:: ; address name
    dw vTiles1 + $700, vTiles1 + $710, vTiles1 + $720, vTiles1 + $730, vTiles1 + $740, vTiles1 + $750 ; entry 0
    dw vTiles1 + $760, vTiles1 + $770, vTiles1 + $470

; E-0238 (C1: list 1 of TileDestTable_1C_6289; 9 words).
; record: VRAM tile addresses, indexed by wGlyphListPos
TileDests_1C_1::
Data_01C_62A3:: ; address name
    dw vTiles1 + $780, vTiles1 + $790, vTiles1 + $7A0, vTiles1 + $7B0, vTiles1 + $7C0, vTiles1 + $7D0 ; entry 0
    dw vTiles1 + $7E0, vTiles1 + $7F0, vTiles1 + $480

; E-0238 (C1: list 2 of TileDestTable_1C_6289; 9 words).
; record: VRAM tile addresses, indexed by wGlyphListPos
TileDests_1C_2::
Data_01C_62B5:: ; address name
    dw vTiles1 + $500, vTiles1 + $510, vTiles1 + $520, vTiles1 + $530, vTiles1 + $540, vTiles1 + $550 ; entry 0
    dw vTiles1 + $560, vTiles1 + $570, vTiles1 + $490

; E-0238 (C1: list 3 of TileDestTable_1C_6289; 9 words).
; record: VRAM tile addresses, indexed by wGlyphListPos
TileDests_1C_3::
Data_01C_62C7:: ; address name
    dw vTiles1 + $580, vTiles1 + $590, vTiles1 + $5A0, vTiles1 + $5B0, vTiles1 + $5C0, vTiles1 + $5D0 ; entry 0
    dw vTiles1 + $5E0, vTiles1 + $2A0, vTiles1 + $4A0

; address loaded by ShopMenu_Case03_Case05, ShopMenu_Case04_Case04
Data_01C_62D9:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $AE, $00, $EE, $00, $2E, $01, $6E, $01

; address loaded by ShopMenu_Case03_Case08
Data_01C_62E1:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B2, $B6, $C3, $C3, $B7, $B3, $B4, $B4, $B5

; address loaded by ShopMenu_Case04_Case07
Data_01C_62ED:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $B0, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $C3, $BE, $C3, $C3, $B7, $B3, $B4
    db $B4, $B4, $B4, $B4, $B5

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 6 x 5 tiles, one row per line
TileRect_1C_6302::
Data_01C_6302:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $CE, $CF, $DF, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $A5, $EE, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0237 (C1: ShopMenu_Shared03 reads the byte at $6320 + wScreenTableIndex, multiplies the ItemValueTable word by it (Multiply8By16) and divides by 100 (Divide24ByA); values 75 and 80, one 0).
; record: percentage
ShopPercentTable::
Data_01C_6320:: ; address name
    db $4B ; id 0
    db $4B ; id 1
    db $4B ; id 2
    db $50 ; id 3
    db $50 ; id 4
    db $00 ; id 5
    db $50 ; id 6
    db $50 ; id 7
    db $50 ; id 8
    db $50 ; id 9
    db $50 ; id 10
    db $50 ; id 11
    db $50 ; id 12
    db $50 ; id 13
    db $50 ; id 14
    db $4B ; id 15
    db $50 ; id 16
    db $50 ; id 17
    db $50 ; id 18
    db $50 ; id 19
    db $50 ; id 20
    db $50 ; id 21
    db $50 ; id 22
    db $50 ; id 23

; E-0237 (C1: ShopMenu_Shared03 reads the word at $6338 + DE, where its three callers pass DE = 2 * a byte of wItemGrid; the word is scaled by ShopPercentTable; 99 words up to the table at $63FE).
; record: value
ItemValueTable::
Data_01C_6338:: ; address name
    dw $0000 ; id 0
    dw $000A ; id 1
    dw $0032 ; id 2
    dw $01F4 ; id 3
    dw $00C8 ; id 4
    dw $07D0 ; id 5
    dw $0004 ; id 6
    dw $0014 ; id 7
    dw $0014 ; id 8
    dw $0014 ; id 9
    dw $0014 ; id 10
    dw $03E8 ; id 11
    dw $03E8 ; id 12
    dw $0014 ; id 13
    dw $0014 ; id 14
    dw $0014 ; id 15
    dw $0014 ; id 16
    dw $0014 ; id 17
    dw $0014 ; id 18
    dw $2710 ; id 19
    dw $2710 ; id 20
    dw $2710 ; id 21
    dw $2710 ; id 22
    dw $2710 ; id 23
    dw $2710 ; id 24
    dw $000A ; id 25
    dw $0028 ; id 26
    dw $00C8 ; id 27
    dw $03E8 ; id 28
    dw $0014 ; id 29
    dw $1388 ; id 30
    dw $0320 ; id 31
    dw $0064 ; id 32
    dw $04B0 ; id 33
    dw $02BC ; id 34
    dw $0320 ; id 35
    dw $05DC ; id 36
    dw $0BB8 ; id 37
    dw $0FA0 ; id 38
    dw $1388 ; id 39
    dw $0032 ; id 40
    dw $0019 ; id 41
    dw $0032 ; id 42
    dw $0032 ; id 43
    dw $0001 ; id 44
    dw $0001 ; id 45
    dw $0032 ; id 46
    dw $0000 ; id 47
    dw $0000 ; id 48
    dw $0000 ; id 49
    dw $0000 ; id 50
    dw $0000 ; id 51
    dw $0000 ; id 52
    dw $0000 ; id 53
    dw $0000 ; id 54
    dw $0000 ; id 55
    dw $0000 ; id 56
    dw $0000 ; id 57
    dw $0000 ; id 58
    dw $0000 ; id 59
    dw $0000 ; id 60
    dw $0000 ; id 61
    dw $0000 ; id 62
    dw $0000 ; id 63
    dw $00C8 ; id 64
    dw $01F4 ; id 65
    dw $00C8 ; id 66
    dw $01F4 ; id 67
    dw $00C8 ; id 68
    dw $01F4 ; id 69
    dw $00C8 ; id 70
    dw $01F4 ; id 71
    dw $00C8 ; id 72
    dw $01F4 ; id 73
    dw $00C8 ; id 74
    dw $01F4 ; id 75
    dw $03E8 ; id 76
    dw $03E8 ; id 77
    dw $03E8 ; id 78
    dw $07D0 ; id 79
    dw $1388 ; id 80
    dw $03E8 ; id 81
    dw $03E8 ; id 82
    dw $0014 ; id 83
    dw $0000 ; id 84
    dw $0000 ; id 85
    dw $0000 ; id 86
    dw $0000 ; id 87
    dw $0000 ; id 88
    dw $0000 ; id 89
    dw $03E8 ; id 90
    dw $03E8 ; id 91
    dw $07D0 ; id 92
    dw $07D0 ; id 93
    dw $07D0 ; id 94
    dw $07D0 ; id 95
    dw $07D0 ; id 96
    dw $07D0 ; id 97
    dw $0000 ; id 98

; address loaded by ShopMenu_Case03_Case03, ShopMenu_Case04_Case03, VaultMenu_Case03_Case09
Data_01C_63FE:: ; heuristic: pointer load in the same bank (bank assumed); C0
    dw Data_01C_64C4
    dw Data_01C_64C5
    dw Data_01C_64CA
    dw Data_01C_64D4
    dw Data_01C_64DD
    dw Data_01C_64E4
    dw Data_01C_64ED
    dw Data_01C_64F6
    dw Data_01C_64FF
    dw Data_01C_6506
    dw Data_01C_6510
    dw Data_01C_6518
    dw Data_01C_6521
    dw Data_01C_652B
    dw Data_01C_6533
    dw Data_01C_653B
    dw Data_01C_6543
    dw Data_01C_654B
    dw Data_01C_6555
    dw Data_01C_655F
    dw Data_01C_6566
    dw Data_01C_656E
    dw Data_01C_6576
    dw Data_01C_657F
    dw Data_01C_6586
    dw Data_01C_658E
    dw Data_01C_6598
    dw Data_01C_65A1
    dw Data_01C_65A5
    dw Data_01C_65AD
    dw Data_01C_65B5
    dw Data_01C_65BD
    dw Data_01C_65C7
    dw Data_01C_65D1
    dw Data_01C_65DB
    dw Data_01C_65E1
    dw Data_01C_65E9
    dw Data_01C_65EF
    dw Data_01C_65F5
    dw Data_01C_65FB
    dw Data_01C_6601
    dw Data_01C_6607
    dw Data_01C_6610
    dw Data_01C_6619
    dw Data_01C_6622
    dw Data_01C_662C
    dw Data_01C_6635
    dw Data_01C_663D
    dw Data_01C_663E
    dw Data_01C_6648
    dw Data_01C_6651
    dw Data_01C_6657
    dw Data_01C_6660
    dw Data_01C_666A
    dw Data_01C_6672
    dw Data_01C_667C
    dw Data_01C_6686
    dw Data_01C_668B
    dw Data_01C_6693
    dw Data_01C_669B
    dw Data_01C_66A3
    dw Data_01C_66AC
    dw Data_01C_66B4
    dw Data_01C_66B4
    dw Data_01C_66B4
    dw Data_01C_66BC
    dw Data_01C_66C6
    dw Data_01C_66D0
    dw Data_01C_66D8
    dw Data_01C_66E2
    dw Data_01C_66EC
    dw Data_01C_66F6
    dw Data_01C_6700
    dw Data_01C_6705
    dw Data_01C_670D
    dw Data_01C_6714
    dw Data_01C_671A
    dw Data_01C_6724
    dw Data_01C_672E
    dw Data_01C_6738
    dw Data_01C_6741
    dw Data_01C_674B
    dw Data_01C_6754
    dw Data_01C_675E
    dw Data_01C_6766
    dw Data_01C_6766
    dw Data_01C_6766
    dw Data_01C_6766
    dw Data_01C_6766
    dw Data_01C_6766
    dw Data_01C_6766
    dw Data_01C_676C
    dw Data_01C_6774
    dw Data_01C_6779
    dw Data_01C_677F
    dw Data_01C_6786
    dw Data_01C_678E
    dw Data_01C_6795
    dw Data_01C_679D

Data_01C_64C4:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_01C_64C5:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $35, $25, $F0

Data_01C_64CA:: ; heuristic: target of a monotone pointer table; C0
    db $15, $32, $39, $28, $20, $24, $37, $28, $35, $F0

Data_01C_64D4:: ; heuristic: target of a monotone pointer table; C0
    db $20, $32, $35, $2F, $27, $0D, $28, $3A, $F0

Data_01C_64DD:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $37, $2C, $32, $31, $F0

Data_01C_64E4:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $2F, $29, $20, $24, $37, $28, $35, $F0

Data_01C_64ED:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $31, $37, $2C, $27, $32, $37, $28, $F0

Data_01C_64F6:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $32, $31, $11, $28, $35, $25, $F0

Data_01C_64FF:: ; heuristic: target of a monotone pointer table; C0
    db $15, $24, $38, $35, $28, $2F, $F0

Data_01C_6506:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $3A, $24, $2E, $28, $1C, $24, $31, $27, $F0

Data_01C_6510:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $3C, $0B, $28, $2F, $2F, $F0

Data_01C_6518:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $2A, $28, $1B, $32, $26, $2E, $F0

Data_01C_6521:: ; heuristic: target of a monotone pointer table; C0
    db $20, $32, $35, $2F, $27, $15, $28, $24, $29, $F0

Data_01C_652B:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $1D, $14, $36, $28, $28, $27, $F0

Data_01C_6533:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $0E, $0F, $36, $28, $28, $27, $F0

Data_01C_653B:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $10, $15, $36, $28, $28, $27, $F0

Data_01C_6543:: ; heuristic: target of a monotone pointer table; C0
    db $12, $17, $1D, $36, $28, $28, $27, $F0

Data_01C_654B:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $29, $28, $0A, $26, $32, $35, $31, $F0

Data_01C_6555:: ; heuristic: target of a monotone pointer table; C0
    db $16, $3C, $36, $37, $2C, $26, $17, $38, $37, $F0

Data_01C_655F:: ; heuristic: target of a monotone pointer table; C0
    db $1A, $38, $28, $36, $37, $50, $F0

Data_01C_6566:: ; heuristic: target of a monotone pointer table; C0
    db $11, $32, $35, $35, $32, $35, $50, $F0

Data_01C_656E:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $17, $2C, $26, $28, $50, $F0

Data_01C_6576:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $28, $24, $37, $28, $35, $50, $F0

Data_01C_657F:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $30, $24, $35, $37, $50, $F0

Data_01C_6586:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $32, $30, $28, $27, $3C, $50, $F0

Data_01C_658E:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $28, $29, $13, $28, $35, $2E, $3C, $F0

Data_01C_6598:: ; heuristic: target of a monotone pointer table; C0
    db $19, $32, $35, $2E, $0C, $2B, $32, $33, $F0

Data_01C_65A1:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $2C, $25, $F0

Data_01C_65A5:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2C, $35, $2F, $32, $2C, $31, $F0

Data_01C_65AD:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $24, $27, $16, $28, $24, $37, $F0

Data_01C_65B5:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $37, $28, $18, $35, $25, $F0

Data_01C_65BD:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $28, $24, $36, $37, $1D, $24, $2C, $2F, $F0

Data_01C_65C7:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $28, $33, $28, $2F, $2F, $28, $31, $37, $F0

Data_01C_65D1:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2B, $2C, $31, $3C, $11, $24, $35, $33, $F0

Data_01C_65DB:: ; heuristic: target of a monotone pointer table; C0
    db $16, $2C, $36, $37, $51, $F0

Data_01C_65E1:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $35, $2C, $28, $31, $27, $51, $F0

Data_01C_65E9:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $31, $27, $51, $F0

Data_01C_65EF:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $2F, $37, $51, $F0

Data_01C_65F5:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $31, $32, $3A, $51, $F0

Data_01C_65FB:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $35, $28, $51, $F0

Data_01C_6601:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $35, $33, $51, $F0

Data_01C_6607:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $35, $33, $20, $2C, $31, $2A, $F0

Data_01C_6610:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $3B, $2C, $37, $0B, $28, $2F, $2F, $F0

Data_01C_6619:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $32, $32, $2E, $30, $24, $35, $2E, $F0

Data_01C_6622:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2C, $31, $3C, $16, $28, $27, $24, $2F, $F0

Data_01C_662C:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $2F, $27, $19, $24, $36, $36, $F0

Data_01C_6635:: ; heuristic: target of a monotone pointer table; C0
    db $15, $32, $2A, $1D, $3A, $2C, $2A, $F0

Data_01C_663D:: ; heuristic: target of a monotone pointer table; C0
    db $F0

Data_01C_663E:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $37, $28, $35, $0C, $24, $2F, $2F, $F0

Data_01C_6648:: ; heuristic: target of a monotone pointer table; C0
    db $16, $32, $32, $31, $1B, $32, $26, $2E, $F0

Data_01C_6651:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $35, $28, $36, $37, $F0

Data_01C_6657:: ; heuristic: target of a monotone pointer table; C0
    db $22, $38, $31, $24, $1C, $32, $38, $2F, $F0

Data_01C_6660:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2F, $28, $28, $33, $11, $28, $35, $25, $F0

Data_01C_666A:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2B, $24, $31, $2A, $28, $51, $F0

Data_01C_6672:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2C, $27, $24, $2F, $0B, $28, $2F, $2F, $F0

Data_01C_667C:: ; heuristic: target of a monotone pointer table; C0
    db $11, $24, $35, $16, $2C, $35, $35, $32, $35, $F0

Data_01C_6686:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2E, $3C, $5E, $F0

Data_01C_668B:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $24, $39, $28, $31, $52, $F0

Data_01C_6693:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $24, $39, $28, $31, $54, $F0

Data_01C_669B:: ; heuristic: target of a monotone pointer table; C0
    db $11, $28, $24, $39, $28, $31, $53, $F0

Data_01C_66A3:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $3D, $1C, $37, $32, $31, $28, $F0

Data_01C_66AC:: ; heuristic: target of a monotone pointer table; C0
    db $19, $35, $28, $37, $37, $3C, $55, $F0

Data_01C_66B4:: ; heuristic: target of a monotone pointer table; C0
    db $1F, $12, $1D, $25, $28, $2F, $37, $F0

Data_01C_66BC:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $26, $32, $0B, $28, $2F, $37, $F0

Data_01C_66C6:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2A, $2C, $26, $0B, $28, $2F, $37, $F0

Data_01C_66D0:: ; heuristic: target of a monotone pointer table; C0
    db $18, $27, $27, $0B, $28, $2F, $37, $F0

Data_01C_66D8:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $32, $31, $28, $0F, $24, $31, $2A, $F0

Data_01C_66E2:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $28, $28, $2F, $0F, $24, $31, $2A, $F0

Data_01C_66EC:: ; heuristic: target of a monotone pointer table; C0
    db $16, $28, $35, $30, $1C, $26, $24, $2F, $28, $F0

Data_01C_66F6:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $2E, $1C, $26, $24, $2F, $28, $F0

Data_01C_6700:: ; heuristic: target of a monotone pointer table; C0
    db $0A, $10, $15, $55, $F0

Data_01C_6705:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $37, $24, $35, $35, $3C, $55, $F0

Data_01C_670D:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $30, $24, $35, $37, $56, $F0

Data_01C_6714:: ; heuristic: target of a monotone pointer table; C0
    db $20, $2C, $36, $28, $56, $F0

Data_01C_671A:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2A, $2C, $26, $0C, $24, $33, $28, $F0

Data_01C_6724:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $35, $24, $26, $32, $0C, $24, $33, $28, $F0

Data_01C_672E:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $2C, $2F, $39, $35, $0C, $24, $33, $28, $F0

Data_01C_6738:: ; heuristic: target of a monotone pointer table; C0
    db $10, $32, $2F, $27, $0C, $24, $33, $28, $F0

Data_01C_6741:: ; heuristic: target of a monotone pointer table; C0
    db $19, $2F, $37, $31, $30, $0C, $24, $33, $28, $F0

Data_01C_674B:: ; heuristic: target of a monotone pointer table; C0
    db $18, $35, $26, $24, $0C, $24, $33, $28, $F0

Data_01C_6754:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $35, $24, $39, $28, $0C, $24, $33, $28, $F0

Data_01C_675E:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $9C, $1C, $26, $24, $2F, $28, $F0

Data_01C_6766:: ; heuristic: target of a monotone pointer table; C0
    db $15, $2C, $29, $28, $55, $F0

Data_01C_676C:: ; heuristic: target of a monotone pointer table; C0
    db $0D, $2C, $39, $2C, $31, $28, $55, $F0

Data_01C_6774:: ; heuristic: target of a monotone pointer table; C0
    db $20, $24, $35, $55, $F0

Data_01C_6779:: ; heuristic: target of a monotone pointer table; C0
    db $16, $24, $2A, $28, $55, $F0

Data_01C_677F:: ; heuristic: target of a monotone pointer table; C0
    db $0F, $2C, $2A, $2B, $37, $55, $F0

Data_01C_6786:: ; heuristic: target of a monotone pointer table; C0
    db $1C, $24, $2C, $2F, $32, $35, $55, $F0

Data_01C_678E:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $2B, $2C, $28, $29, $55, $F0

Data_01C_6795:: ; heuristic: target of a monotone pointer table; C0
    db $0C, $2F, $28, $35, $2C, $26, $55, $F0

Data_01C_679D:: ; heuristic: target of a monotone pointer table; C0
    db $F0

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (the same 17 bytes appear in 7 banks)
; 6 call sites from 4 routines (e.g. VaultMenu_Case01_Case00, ClearRect147AndAskTwoChoice, VaultMenu_Case03_Case12, ShopMenu_Shared01_Case00)
; reads: rSTAT
CopyTileBytesToVRAM_Bank1C::
Func_01C_679E:: ; address name
    ld c, $10

Jump_01C_67A0::
    di

Jump_01C_67A1::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01C_67A1
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    dec c
    jr nz, Jump_01C_67A0
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 47 call sites from 37 routines (e.g. VaultMenu_Case02_Sub03, CloseShopMenu_Case00_Sub01, ShopMenu_Case02_Sub04, DrawScreenListBoxAtWC370AndStep, ...)
; reads: hScrollY, hScrollX
BGMapAddressAtScroll_Bank1C_67AF::
Func_01C_67AF:: ; address name
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

; copies the B x C rectangle at DE to the BG map at HL (Func_01C_6823 with A = 0) and sets wC554 = HL + $1C1; on CGB copies it again with VRAM bank 1 selected and WRAM bank 2 switched in (E-0121; a copy, not a clear: E-0226)
; 11 call sites from 9 routines (e.g. DrawTwoBoxesAndRequestScript80, ShopMenu_Case03_Case09, ShopMenu_Case04_Case0C, ShopMenu_Case04_Case08, ...)
; reads: wIsCGB
; writes: wTextCursorLo, wTextCursorHi, rVBK, rSVBK
DrawRectBothBanksSetTextCursorLoPlus1C1::
Func_01C_67D0:: ; address name
    push de
    push bc
    push hl
    xor a, a
    call CopyRectToBGMapWrapped_1C
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
    ld a, $01
    ldh [rVBK], a
    ld a, $02
    ldh [rSVBK], a
    xor a, a
    call CopyRectToBGMapWrapped_1C
    ld a, $00
    ldh [rSVBK], a
    ld a, $00
    ldh [rVBK], a
    ret

; clears a rectangle (Func_01C_6823 with A = 0) and sets wC554 = HL + $1C1 (E-0124)
; 13 call sites from 13 routines (e.g. ShopMenu_Case03_Case0E, DrawTwoBoxesAndRequestScript80, ShopMenu_Case03_Case0C, ShopMenu_Case03_Case08, ...)
; writes: wTextCursorLo, wTextCursorHi
ClearRectSetTextCursorLoPlus1C1_Bank1C::
Func_01C_6806:: ; address name
    push de
    push bc
    push hl
    xor a, a
    call CopyRectToBGMapWrapped_1C
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
    ret

; copies a B x C rectangle from DE to the BG map at HL, wrapping at the screen and map edges (E-0129)
; 3 call sites from 2 routines (e.g. ClearRectSetTextCursorLoPlus1C1_Bank1C, DrawRectBothBanksSetTextCursorLoPlus1C1)
; reads: hScrollX, rSTAT, hVRAMByteTemp
; writes: hVRAMByteTemp
CopyRectToBGMapWrapped_1C::
Func_01C_6823:: ; address name
    push hl
    push bc
    push de
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    and a, $1F
    ld b, a
    ld a, $20
    sub a, b
    ld b, a
    ld a, $14
    sub a, b
    bit 7, a
    jr nz, Jump_01C_6858
    pop de
    pop bc
    pop hl
    push hl
    push bc
    push de
    ld d, a
    ld a, l
    and a, $1F
    cp a, d
    jr nc, Jump_01C_685D
    pop de
    pop bc
    pop hl
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_01C_6854::
    push hl
    push bc
    jr Jump_01C_685E

Jump_01C_6858::
    pop de
    pop bc
    pop hl
    jr Jump_01C_6854

Jump_01C_685D::
    pop de

Jump_01C_685E::
    di

Jump_01C_685F::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01C_685F
    ld a, [de]
    ei
    ldh [hVRAMByteTemp], a
    di

Jump_01C_686A::
    ldh a, [rSTAT]
    bit 1, a
    jr nz, Jump_01C_686A
    ldh a, [hVRAMByteTemp]
    ld [hl+], a
    ei
    ld a, l
    and a, $1F
    jr nz, Jump_01C_6881
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

Jump_01C_6881::
    inc de
    dec b
    jr nz, Jump_01C_685E
    pop bc
    pop hl
    dec c
    jr z, Jump_01C_6899
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, h
    and a, $9B
    ld h, a
    jp Jump_01C_6854

Jump_01C_6899::
    ret

; clears wD7D5 ($18 bytes) and lists each item id 1-$62 present in the inventory, counting them in wD785 (E-0127)
; 2 call sites from 2 routines (e.g. ShopMenu_Case04_Case02, DrawRect0140AtBGMap13E0AndStep)
; reads: wGlyphListStart
; writes: wGlyphListStart, wGridCursorX
; points at: wItemGrid, wInventory
ListDistinctInventoryItemsToItemGrid::
Func_01C_689A:: ; address name
    push af
    push bc
    push de
    push hl
    ld hl, wItemGrid
    ld c, $18

Jump_01C_68A3::
    xor a, a
    ld [hl+], a
    dec c
    jr nz, Jump_01C_68A3
    xor a, a
    ld [wGlyphListStart], a
    ld [wGridCursorX], a
    ld b, $01

Jump_01C_68B1::
    ld hl, wInventory
    ld c, $18

Jump_01C_68B6::
    ld a, [hl]
    cp a, b
    jr z, Jump_01C_68C9
    inc hl
    dec c
    jr nz, Jump_01C_68B6

Jump_01C_68BE::
    inc b
    ld a, b
    cp a, $63
    jr c, Jump_01C_68B1
    pop hl
    pop de
    pop bc
    pop af
    ret

Jump_01C_68C9::
    ld a, [wGlyphListStart]
    ld de, wItemGrid
    add a, e
    ld e, a
    jr nc, Jump_01C_68D4
    inc d

Jump_01C_68D4::
    ld a, b
    ld [de], a
    ld a, [wGlyphListStart]
    inc a
    ld [wGlyphListStart], a
    jr Jump_01C_68BE

; HL = wD7F1/wD7F2 = the word at Data_01C_6158 + 2 * wD7FB (E-0118)
; 7 call sites from 7 routines (e.g. ShopMenu_Case03_Case0E, ShopMenu_Case03_Case0A, ShopMenu_Case03_Case09_Sub02, ShopMenu_Case03_Case05, ...)
; reads: wScreenTableIndex
; writes: wArg2, wArg1
LoadArg1PointerForScreenTableIndex::
Func_01C_68DF:: ; address name
    ld hl, ShopItemListTable
    ld a, [wScreenTableIndex]
    ld e, a
    ld d, $00
    sla e
    rl d
    add hl, de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld a, h
    ld [wArg2], a
    ld l, e
    ld a, l
    ld [wArg1], a
    ret

; LoadArg1PointerForScreenTableIndex, then wD7F1 = the byte at that pointer + 4 * wD7B6 + wD7B5 (E-0119)
; 1 call site from 1 routine (e.g. StepItemDescriptionText)
; reads: wItemGridY, wItemGridX
; writes: wArg1
LoadArg1ByteForItemGridXItemGridY::
Func_01C_68FA:: ; address name
    call LoadArg1PointerForScreenTableIndex
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wItemGridX]
    add_a_to_hl
    ld a, [hl]
    ld [wArg1], a
    ret

; removes 10 * wD7CA + wD7CB copies of the selected item (wD7D5[4 * wD7B6 + wD7B5]) from the inventory and compacts it (E-0128)
; 2 call sites from 2 routines (e.g. ShopMenu_Case04_Case0D, VaultMenu_Case03_Case0E)
; reads: wNumberTens, wNumberOnes, wItemGridY, wItemGridX, wCursorBlinkB8, wRecordsFlagged
; writes: wRecordsFlagged, wCursorBlinkB8
; points at: wItemGrid, wInventory
RemoveItemCountFromInventory::
Func_01C_6919:: ; address name
    ld a, [wNumberTens]
    ld e, a
    ld d, $00
    ld l, a
    ld h, $00
    sla l
    rl h
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, l
    ld e, a
    ld a, h
    ld d, a
    ld a, [wNumberOnes]
    add a, e
    ld e, a
    jr nc, Jump_01C_693F
    inc d

Jump_01C_693F::
    ld a, e
    ld [wRecordsFlagged], a
    ld hl, wItemGrid
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wItemGridX]
    add_a_to_hl
    ld a, [hl]
    ld [wCursorBlinkB8], a
    ld de, wInventory
    ld hl, wInventory
    ld b, $00
    ld c, $00

Jump_01C_696B::
    ld a, [wCursorBlinkB8]
    cp a, [hl]
    jr nz, Jump_01C_6984
    ld a, [wRecordsFlagged]
    and a, a
    jr z, Jump_01C_6984
    dec a
    ld [wRecordsFlagged], a
    inc hl
    inc c
    ld a, c
    cp a, $18
    jr nc, Jump_01C_698F
    jr Jump_01C_696B

Jump_01C_6984::
    ld a, [hl]
    ld [de], a
    inc hl
    inc de
    inc b
    inc c
    ld a, c
    cp a, $18
    jr c, Jump_01C_696B

Jump_01C_698F::
    xor a, a
    ld [de], a
    inc de
    inc b
    ld a, b
    cp a, $18
    jr c, Jump_01C_698F
    ret

; counts the inventory slots holding the item at wD7D5[4 * wD7B6 + wD7B5]; wD7D3 = count / 10, wD7D4 = count mod 10 (E-0125)
; 2 call sites from 2 routines (e.g. ShopMenu_Case04_Case07, VaultMenu_Case03_Case0B_Sub01)
; reads: wItemGridY, wItemGridX
; writes: wCountOnes, wCountTens
; points at: wItemGrid, wInventory
CountItemInInventoryToDigits::
Func_01C_6999:: ; address name
    ld hl, wItemGrid
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wItemGridX]
    add_a_to_hl
    ld a, [hl]
    ld b, a
    ld hl, wInventory
    ld d, $18
    ld c, $00

Jump_01C_69BC::
    ld a, [hl]
    cp a, b
    jr nz, Jump_01C_69C1
    inc c

Jump_01C_69C1::
    inc hl
    dec d
    jr nz, Jump_01C_69BC
    ld l, c
    ld h, $00
    ld a, $0A
    call DivideHLByA
    ld [wCountOnes], a
    ld a, l
    ld [wCountTens], a
    ret

; for each entry from wD783 of the destination list at HL and the source list at DE copies a 16-byte tile from bank $1F, until $FF; then wD781 += 1 (E-0127)
; 2 call sites from 2 routines (e.g. ShopMenu_Case01_Case01, VaultMenu_Case01_Case01)
; reads: wScreenCounter
; writes: wGlyphListPos, wScreenCounter
; points at: wScreenStep
CopyTileListFromBank1F_1C::
Func_01C_69D5:: ; address name
    xor a, a
    ld [wGlyphListPos], a

Jump_01C_69D9::
    push hl
    push de
    ld a, [wScreenCounter]
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jp z, Jump_01C_6A14
    ld e, a
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    push de
    push hl
    ld a, [wScreenCounter]
    add a, a
    add a, e
    ld e, a
    jr nc, Jump_01C_69FA
    inc d

Jump_01C_69FA::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld d, a
    ld a, l
    ld e, a
    pop hl
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    pop hl
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    jr Jump_01C_69D9

Jump_01C_6A14::
    pop de
    pop hl
    xor a, a
    ld [wScreenCounter], a
    ld [wGlyphListPos], a
    ld hl, wScreenStep
    inc [hl]
    ret

; copies $28 bytes from Data_01C_5F5E to wD788, runs Func_01C_4395, counts the inventory items into wD7B0 and its digits into wD7A5/6, wD781 += 1 (E-0125)
; 2 call sites from 2 routines (e.g. ShopMenu_Case01_Case02, VaultMenu_Case01_Case04)
; reads: wDigits
; writes: wListPages, wItemCountTens, wItemCountOnes
; points at: wScreenList, wScreenBlock92, wInventory, wScreenStep
InitItemListScreenListAndCount::
Func_01C_6A22:: ; address name
    ld hl, wScreenList
    ld de, Data_01C_5F5E
    ld bc, $0028

Jump_01C_6A2B::
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01C_6A2B
    ld hl, wScreenBlock92
    call DrawGoldDigitsAtHLWrapped_1C
    ld hl, wInventory
    ld c, $18
    ld b, $00

Jump_01C_6A40::
    ld a, [hl+]
    and a, a
    jr z, Jump_01C_6A49
    cp a, $FF
    jr z, Jump_01C_6A49
    inc b

Jump_01C_6A49::
    dec c
    jr nz, Jump_01C_6A40
    ld a, b
    ld [wListPages], a
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld a, [wDigits + $1]
    and a, a
    jr z, Jump_01C_6A64
    ld a, [wDigits + $1]
    add a, $E0
    ld [wItemCountTens], a

Jump_01C_6A64::
    ld a, [wDigits + $2]
    add a, $E0
    ld [wItemCountOnes], a
    ld hl, wScreenStep
    inc [hl]
    ret

; copies the 8 x 5 box at wD788 to wC370, draws it at scroll + $1CC and wD781 += 1 (E-0122)
; 2 call sites from 2 routines (e.g. ShopMenu_Case01_Case03, VaultMenu_Case01_Case05)
; points at: wScreenList, wScreenStep
DrawScreenListBoxAtWC370AndStep::
Func_01C_6A71:: ; address name
    ld de, wScreenList
    ld hl, wWindowTileBuffer + $70
    ld bc, $0805
    call CopyRectTo20ByteRowsJp_Bank1C
    call BGMapAddressAtScroll_Bank1C_67AF
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1C
    ld hl, wScreenStep
    inc [hl]
    ret

; only called from CloseShopMenu_Case01 (E-0047)
; 1 call site from 1 routine (e.g. CloseShopMenu_Case01)
; writes: wGlyphListPos, wScreenCounter, wScreenState, wScreenStep, wMenuState, wScriptCommandType, wScriptStartRequest
; points at: wGridCursorY
CloseShopMenu_Case01_Sub01::
Func_01C_6A8E:: ; address name
    xor a, a
    ld [wGlyphListPos], a
    ld [wScreenCounter], a
    ld [wScreenState], a
    ld [wScreenStep], a
    ld [wMenuState], a
    ld hl, wGridCursorY
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; only called from CloseShopMenu_Case00 (E-0047)
; 1 call site from 1 routine (e.g. CloseShopMenu_Case00)
; reads: wIsCGB
; points at: wScreenTileBuffer, wScreenAttrBuffer, wGridCursorY
CloseShopMenu_Case00_Sub01::
Func_01C_6AAC:: ; address name
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01C_6ACA
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank1C

Jump_01C_6ACA::
    call BGMapAddressAtScroll_Bank1C_67AF
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1C
    ld hl, wGridCursorY
    inc [hl]
    ret

; clears wD7C2-wD7C6, wD7C8 and wD7C9, and sets wD7C7 = $3C (60) (E-0072)
; 14 call sites from 4 routines (e.g. ShopMenu_Case03_Case07, ShopMenu_Case03_Case06, ShopMenu_Case04_Case06, ShopMenu_Case04_Case05)
; writes: wTextCounter0, wTextCounter1, wTextCounter2, wTextCounter3, wTextCounter4, wTextCounter5, wTextCounter6, wTextTimer
ResetTextCounter0Counters::
Func_01C_6ADB:: ; address name
    xor a, a
    ld [wTextCounter0], a
    ld [wTextCounter1], a
    ld [wTextCounter2], a
    ld [wTextCounter3], a
    ld [wTextCounter4], a
    ld [wTextCounter5], a
    ld [wTextCounter6], a
    ld a, $3C
    ld [wTextTimer], a
    ret

; only called from routines of ShopMenu (E-0098)
; 2 call sites from 2 routines (e.g. ShopMenu_Case03_Case06, ShopMenu_Case04_Case05)
; reads: wJoypadPressedRepeat, wScreenState, wTextTimer, wTextCounter0, wScreenStep
; writes: wTextCounter6, wTextTimer, wTextCounter0
ShopMenu_Shared01::
Func_01C_6AF7:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 0, a
    jr nz, Jump_01C_6B38
    and a, a
    jr z, Jump_01C_6B38
    ld a, [wScreenState]
    cp a, $03
    jr z, Jump_01C_6B1A
    ld a, [wScreenState]
    cp a, $04
    jr z, Jump_01C_6B11
    jr Jump_01C_6B2E

Jump_01C_6B11::
    ld a, [wScreenStep]
    cp a, $05
    jr nz, Jump_01C_6B2E
    jr Jump_01C_6B21

Jump_01C_6B1A::
    ld a, [wScreenStep]
    cp a, $06
    jr nz, Jump_01C_6B2E

Jump_01C_6B21::
    ld a, [wJoypadPressedRepeat]
    bit 1, a
    jr z, Jump_01C_6B2E
    ld a, $03
    ld [wTextCounter0], a
    ret

Jump_01C_6B2E::
    ld a, $01
    ld [wTextCounter6], a
    ld a, $3C
    ld [wTextTimer], a

Jump_01C_6B38::
    ld a, [wTextTimer]
    inc a
    ld [wTextTimer], a
    cp a, $3C
    ret c
    ld a, $3C
    ld [wTextTimer], a
    ld a, [wTextCounter0]
    rst $00
    dw ShopMenu_Shared01_Case00
    dw ShopMenu_Shared01_Case01
    dw ShopMenu_Shared01_Case02
    dw ShopMenu_Shared01_Case03

; entry 0 of the `rst $00` table in Func_01C_6AF7
; no direct call (reached through a table, a jump or a vector)
; reads: wTextCounter0
; writes: wTextCounter0
ShopMenu_Shared01_Case00::
Jump_01C_6B53:: ; address name
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, TileRect_1C_6B7D
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    ld c, $24
    ld de, vTiles1

Jump_01C_6B68::
    push bc
    ld hl, Tiles_1C_6BE1
    call CopyTileBytesToVRAM_Bank1C
    pop bc
    dec c
    jr nz, Jump_01C_6B68
    ld a, [wTextCounter0]
    inc a
    ld [wTextCounter0], a
    jp ShopMenu_Shared01_Case01

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 20 x 5 tiles, one row per line
TileRect_1C_6B7D::
Data_01C_6B7D:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; E-0238 (derived: HL = $6BE1 and 1 calls to a 16-byte VRAM copier (CopyTileBytesToVRAM_*), one tile each)
; record: tile (16 bytes, 2 bits per pixel)
Tiles_1C_6BE1::
Data_01C_6BE1:: ; address name
    db $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00, $FF, $00 ; entry 0

; entry 1 of the `rst $00` table in Func_01C_6AF7
; no direct call (reached through a table, a jump or a vector)
; reads: wTextCounter0
; writes: wTextCounter0
ShopMenu_Shared01_Case01::
Jump_01C_6BF1:: ; address name
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, TileRect_1C_6C0C
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    ld a, [wTextCounter0]
    inc a
    ld [wTextCounter0], a
    jp ShopMenu_Shared01_Case02
    db $C9

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 20 x 5 tiles, one row per line
TileRect_1C_6C0C::
Data_01C_6C0C:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $8B, $8C, $8D, $8E, $8F, $90, $91, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F, $A0, $A1, $A2, $A3, $B7 ; id 3
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 4

; entry 2 of the `rst $00` table in Func_01C_6AF7
; no direct call (reached through a table, a jump or a vector)
ShopMenu_Shared01_Case02::
Jump_01C_6C70:: ; address name
    farcall StepItemDescriptionText
    ret

; entry 3 of the `rst $00` table in Func_01C_6AF7
; no direct call (reached through a table, a jump or a vector)
ShopMenu_Shared01_Case03::
Jump_01C_6C77:: ; address name
    ret

; draws tiles $C5, $BE, $C6 at BGMapAddressAtScroll + $18E, two entries apart (E-0121)
; 2 call sites from 2 routines (e.g. ShopMenu_Case03_Case02, ShopMenu_Case04_Case02)
DrawC5BEC6AtScroll18E_Bank1C::
Func_01C_6C78:: ; address name
    push hl
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $018E
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
    pop hl
    ret

; DEHL = A * EHL (24-bit by 8-bit multiply through wD7F1-wD7F4) (E-0121)
; 2 call sites from 2 routines (e.g. ShopMenu_Case03_Case09_Sub02, ShopMenu_Shared02)
; reads: wArg1, wArg2, wArg3, wArg4
; writes: wArg1, wArg2, wArg3, wArg4
Multiply24By8_Bank1C::
Func_01C_6CAB:: ; address name
    push af
    push de
    push hl
    ld c, l
    call Multiply8
    ld a, l
    ld [wArg1], a
    ld a, h
    ld [wArg2], a
    pop hl
    pop de
    pop af
    push af
    push de
    ld c, h
    call Multiply8
    ld a, l
    ld [wArg3], a
    ld a, h
    ld [wArg4], a
    pop de
    pop af
    ld c, e
    call Multiply8
    push hl
    pop bc
    ld a, [wArg1]
    ld l, a
    ld a, [wArg2]
    ld e, a
    ld a, [wArg3]
    add a, e
    ld h, a
    ld a, [wArg4]
    ld e, a
    adc a, c
    ld e, a
    ld a, b
    adc a, $00
    ld d, a
    ret

; implements script command type E6 (SCRIPT_VAULT_CLOSE): ends the Vault session (runs CloseShopMenu's code); reached through ScriptCommandE6 in bank $10 (E-0038, E-0244)
; 1 call site from 1 routine (e.g. ScriptCommandE6)
CloseVaultMenu::
Func_01C_6CEB:: ; address name
    call CloseShopMenu
    ret

; implements script command type E5 (SCRIPT_VAULT): the item Vault: 'What item should I store for...', 'What will you be taking out?' (mode 2); reached through ScriptCommandE5 in bank $10 (E-0038, E-0244)
; 1 call site from 1 routine (e.g. ScriptCommandE5)
; reads: wScreenState
VaultMenu::
Func_01C_6CEF:: ; address name
    ld a, [wScreenState]
    rst $00
    dw VaultMenu_Case00
    dw VaultMenu_Case01
    dw VaultMenu_Case02
    dw VaultMenu_Case03
    dw VaultMenu_Case04

; entry 0 of the `rst $00` table in VaultMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wMessageMode, wGlyphListPos, wScreenCounter, wNumberTens, wNumberOnes, wNumberEditPos, wScriptCommandType, wScriptStartRequest
; points at: wScreenState, wScreenTileBuffer, wScreenAttrBuffer
VaultMenu_Case00::
Jump_01C_6CFD:: ; address name
    ld bc, $0070
    ld hl, wScreenState

Jump_01C_6D03::
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01C_6D03
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a, a
    jr z, Jump_01C_6D28
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank1C

Jump_01C_6D28::
    ld a, $02
    ld [wMessageMode], a
    xor a, a
    ld [wGlyphListPos], a
    ld [wScreenCounter], a
    ld [wNumberTens], a
    ld a, $01
    ld [wNumberOnes], a
    ld [wNumberEditPos], a
    ld hl, wScreenState
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 1 of the `rst $00` table in VaultMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
VaultMenu_Case01::
Jump_01C_6D4D:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw VaultMenu_Case01_Case00
    dw VaultMenu_Case01_Case01
    dw VaultMenu_Case01_Case02
    dw VaultMenu_Case01_Case03
    dw VaultMenu_Case01_Case04
    dw VaultMenu_Case01_Case05

; entry 0 of the `rst $00` table in VaultMenu_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
VaultMenu_Case01_Case00::
Jump_01C_6D5D:: ; address name
    ld hl, vTiles1 + $240
    ld de, vTiles2 + $7D0
    call CopyTileBytesToVRAM_Bank1C
    call CopyTileBytesToVRAM_Bank1C
    call CopyTileBytesToVRAM_Bank1C
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

; entry 1 of the `rst $00` table in VaultMenu_Case01
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Case01_Case01::
Jump_01C_6D73:: ; address name
    ld hl, TileCopyDestList_1C_5F86
    ld de, TileCopySrcList_1C_604A
    call CopyTileListFromBank1F_1C
    ret

; entry 2 of the `rst $00` table in VaultMenu_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
VaultMenu_Case01_Case02::
Jump_01C_6D7D:: ; address name
    farcall VaultMenu_Shared06
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in VaultMenu_Case01
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
VaultMenu_Case01_Case03::
Jump_01C_6D8B:: ; address name
    ld hl, vTiles1 + $240
    ld de, Data_01F_43C0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles1 + $250
    ld de, Data_01F_4340
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles1 + $260
    ld de, Data_01F_40E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles1 + $270
    ld de, Data_01F_4330
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 4 of the `rst $00` table in VaultMenu_Case01
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Case01_Case04::
Jump_01C_6DC7:: ; address name
    call InitItemListScreenListAndCount
    ret

; entry 5 of the `rst $00` table in VaultMenu_Case01
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wScreenState
VaultMenu_Case01_Case05::
Jump_01C_6DCB:: ; address name
    ld de, TileRect_1C_6DEF
    ld hl, wWindowTileBuffer + $64
    ld bc, $0B07
    call CopyRectTo20ByteRowsJp_Bank1C
    call DrawScreenListBoxAtWC370AndStep
    xor a, a
    ld [wScreenStep], a
    ld [wTwoChoiceCursor], a
    ld hl, wScreenState
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; E-0161, E-0177, E-0187 (derived: a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as wArg1/wArg2 with wArg3 = width and wArg4 = rows)
; record: 11 x 7 tiles, one row per line
TileRect_1C_6DEF::
Data_01C_6DEF:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2 ; id 0
    db $B6, $C3, $A6, $CF, $A5, $A7, $DF, $EB, $AD, $C3, $B7 ; id 1
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 2
    db $B6, $C3, $EA, $EB, $AD, $ED, $EE, $EF, $AB, $AC, $B7 ; id 3
    db $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $B7 ; id 4
    db $B6, $C3, $A9, $A4, $EB, $AD, $C3, $C3, $C3, $C3, $B7 ; id 5
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5 ; id 6

; entry 2 of the `rst $00` table in VaultMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wListLastRow, wScreenByteB2, wScreenState
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wItemGridX, wItemGridY, wScreenByteB2, wScreenState, wListLastRow
VaultMenu_Case02::
Jump_01C_6E3C:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, Jump_01C_6E54
    bit 7, a
    jr nz, Jump_01C_6E6E
    bit 0, a
    jr nz, Jump_01C_6E7E
    bit 1, a
    jp nz, Jump_01C_6ED6
    call VaultMenu_Case02_Sub01
    ret

Jump_01C_6E54::
    call VaultMenu_Case02_Sub02
    ld a, [wListLastRow]
    and a, a
    jr nz, Jump_01C_6E61
    ld a, $02
    jr Jump_01C_6E62

Jump_01C_6E61::
    dec a

Jump_01C_6E62::
    ld [wListLastRow], a
    call VaultMenu_Case02_Sub01
    ld a, $69
    call QueueSoundEffect
    ret

Jump_01C_6E6E::
    call VaultMenu_Case02_Sub02
    ld a, [wListLastRow]
    cp a, $02
    jr c, Jump_01C_6E7B
    xor a, a
    jr Jump_01C_6E62

Jump_01C_6E7B::
    inc a
    jr Jump_01C_6E62

Jump_01C_6E7E::
    ld a, $69
    call QueueSoundEffect
    call VaultMenu_Case02_Sub03
    ld a, [wListLastRow]
    ld b, a
    ld a, [wScreenByteB2]
    cp a, b
    jr z, Jump_01C_6E9B
    ld a, [wListLastRow]
    ld b, a
    xor a, a
    ld [wItemGridX], a
    ld [wItemGridY], a

Jump_01C_6E9B::
    ld a, b
    ld [wScreenByteB2], a
    ld a, [wListLastRow]
    and a, a
    jr z, Jump_01C_6EB8
    cp a, $01
    jr z, Jump_01C_6EC6
    ld a, $02
    ld [wTwoChoiceCursor], a

Jump_01C_6EAE::
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

Jump_01C_6EB8::
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wTwoChoiceCursor], a
    jp Jump_01C_6EAE

Jump_01C_6EC6::
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    jp Jump_01C_6EAE

Jump_01C_6ED6::
    ld a, $02
    ld [wTwoChoiceCursor], a
    jp Jump_01C_6EAE

; only called from VaultMenu_Case02 (E-0047)
; 2 call sites from 1 routine (e.g. VaultMenu_Case02)
; reads: wJoypadRepeatTimer, wScreenByteB3, wListLastRow
; writes: wScreenByteB3
VaultMenu_Case02_Sub01::
Func_01C_6EDE:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, Jump_01C_6EF8
    ld a, [wScreenByteB3]
    inc a
    ld [wScreenByteB3], a
    cp a, $10
    jr c, Jump_01C_6EF8
    cp a, $18
    jr c, VaultMenu_Case02_Sub02
    xor a, a
    ld [wScreenByteB3], a

Jump_01C_6EF8::
    ld b, $BB
    jr Jump_01C_6F02

; only called from VaultMenu_Case02 (E-0047)
; 2 call sites from 1 routine (e.g. VaultMenu_Case02)
; reads: wListLastRow
VaultMenu_Case02_Sub02::
Func_01C_6EFC:: ; address name
    ld b, $C3
    jr Jump_01C_6F02

; only called from VaultMenu_Case02 (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_Case02)
; reads: wListLastRow
VaultMenu_Case02_Sub03::
Func_01C_6F00:: ; address name
    ld b, $BC

Jump_01C_6F02::
    ld a, [wListLastRow]
    sla a
    ld hl, Data_01C_6F21
    add_a_to_hl
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld d, a
    push de
    call BGMapAddressAtScroll_Bank1C_67AF
    pop de
    add hl, de
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

; address loaded by VaultMenu_Case02_Sub03
Data_01C_6F21:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $21, $00, $61, $00, $A1, $00

; entry 3 of the `rst $00` table in VaultMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
VaultMenu_Case03::
Jump_01C_6F27:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw VaultMenu_Case03_Case00
    dw VaultMenu_Case03_Case01
    dw VaultMenu_Case03_Case02
    dw VaultMenu_Case03_Case03
    dw VaultMenu_Case03_Case04
    dw VaultMenu_Case03_Case05
    dw VaultMenu_Case03_Case06
    dw VaultMenu_Case03_Case07
    dw VaultMenu_Case03_Case08
    dw VaultMenu_Case03_Case09
    dw VaultMenu_Case03_Case0A
    dw VaultMenu_Case03_Case0B
    dw VaultMenu_Case03_Case0C
    dw VaultMenu_Case03_Case0D
    dw VaultMenu_Case03_Case0E
    dw VaultMenu_Case03_Case0F
    dw VaultMenu_Case03_Case10
    dw VaultMenu_Case03_Case11
    dw VaultMenu_Case03_Case12
    dw VaultMenu_Case03_Case13
    dw VaultMenu_Case03_Case14
    dw VaultMenu_Case03_Case15
    dw ClearRect147AndAskTwoChoice
    dw VaultMenu_Case03_Case17
    dw VaultMenu_Case03_Case18

; entry 0 of the `rst $00` table in VaultMenu_Case03
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Case03_Case00::
Jump_01C_6F5D:: ; address name
    farcall VaultMenu_Case03_Case00_Sub01
    ret

; entry 1 of the `rst $00` table in VaultMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
VaultMenu_Case03_Case01::
Jump_01C_6F64:: ; address name
    call BGMapAddressAtScroll_Bank1C_67AF
    ld bc, $0B09
    ld de, vBGMap1 + $300
    call DrawRectBothBanksSetTextCursorLoPlus1C1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in VaultMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenByteED, wScreenStep, wScriptCommandType, wScriptStartRequest
VaultMenu_Case03_Case02::
Jump_01C_6F78:: ; address name
    farcall LoadThreeTilesAndDrawRows4603To460B
    xor a, a
    ld [wScreenByteED], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 3 of the `rst $00` table in VaultMenu_Case03
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Case03_Case03::
Jump_01C_6F93:: ; address name
    farcall VaultMenu_Case03_Case03_Sub01
    ret

; entry 4 of the `rst $00` table in VaultMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenState, wScreenStep, wTwoChoiceCursor, wScreenByteED, wScriptCommandType, wScriptStartRequest
VaultMenu_Case03_Case04::
Jump_01C_6F9A:: ; address name
    ld a, $01
    ld [wScreenState], a
    ld a, $02
    ld [wScreenStep], a
    xor a, a
    ld [wTwoChoiceCursor], a
    ld [wScreenByteED], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 5 of the `rst $00` table in VaultMenu_Case03
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Case03_Case05::
Jump_01C_6FB5:: ; address name
    farcall DrawRect0088AtBGMap1370AndStep
    ret

; entry 6 of the `rst $00` table in VaultMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenCounter
; writes: wScreenCounter
VaultMenu_Case03_Case06::
Jump_01C_6FBC:: ; address name
    call VaultMenu_Shared01
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp a, $04
    jr c, VaultMenu_Case03_Case06
    xor a, a
    ld [wScreenCounter], a
    farcall DrawRect0140AtBGMap13E0AndStep
    ret

; entry 9 of the `rst $00` table in VaultMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState, wItemGridY, wScreenCounter, wCursorBlinkB8, wGlyphListPos, wScreenStep
; writes: wCursorBlinkB8, wGlyphListPos, wScreenCounter, wScreenStep
; points at: wItemStorage, wItemGrid
VaultMenu_Case03_Case09::
Jump_01C_6FD5:: ; address name
    call VaultMenu_Shared01
    ld a, [wScreenState]
    cp a, $03
    jr z, Jump_01C_6FFC
    ld hl, wItemStorage
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wScreenCounter]
    sla a
    jr Jump_01C_7011

Jump_01C_6FFC::
    ld hl, wItemGrid
    ld a, [wItemGridY]
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    add hl, de
    ld a, [wScreenCounter]

Jump_01C_7011::
    add_a_to_hl
    ld e, [hl]
    ld d, $00
    sla e
    rl d
    ld hl, Data_01C_63FE
    add hl, de
    ld e, [hl]
    inc hl
    ld a, [hl]
    ld h, a
    ld l, e

Jump_01C_7026::
    ld a, [hl]
    cp a, $F0
    jp z, Jump_01C_709C
    ld [wCursorBlinkB8], a
    push hl
    ld hl, $4010
    swap a
    ld d, a
    and a, $F0
    ld e, a
    ld a, d
    and a, $0F
    ld d, a
    add hl, de
    ld e, l
    ld d, h
    push de
    ld a, [wScreenCounter]
    sla a
    ld de, TileDestTable_1C_6289
    add a, e
    ld e, a
    jr nc, Jump_01C_704E
    inc d

Jump_01C_704E::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [wCursorBlinkB8]
    cp a, $8D
    jr z, Jump_01C_7060
    cp a, $8E
    jr z, Jump_01C_7060
    jr Jump_01C_7067

Jump_01C_7060::
    ld a, [wGlyphListPos]
    dec a
    ld [wGlyphListPos], a

Jump_01C_7067::
    ld a, [wGlyphListPos]
    sla a
    add_a_to_hl
    ld a, [hl]
    ld e, a
    inc hl
    ld a, [hl]
    ld h, a
    ld a, e
    ld l, a
    pop de
    ld b, $1F
    ld c, $10
    ld a, [wCursorBlinkB8]
    cp a, $8D
    jr z, Jump_01C_708D
    cp a, $8E
    jr z, Jump_01C_708D
    call CopyFromBankWaitVRAM
    jr Jump_01C_7090

Jump_01C_708D::
    call OrFromBankWaitVRAM

Jump_01C_7090::
    pop hl
    inc hl
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    jp Jump_01C_7026

Jump_01C_709C::
    xor a, a
    ld [wGlyphListPos], a
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp a, $04
    jr c, Jump_01C_70B7
    xor a, a
    ld [wScreenCounter], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

Jump_01C_70B7::
    ret

; entry 7 of the `rst $00` table in VaultMenu_Case03
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Case03_Case07::
Jump_01C_70B8:: ; address name
    farcall VaultMenu_Case03_Case07_Sub01
    ret

; entry 8 of the `rst $00` table in VaultMenu_Case03
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Case03_Case08::
Jump_01C_70BF:: ; address name
    farcall VaultMenu_Case03_Case08_Sub01
    ret

; entry 10 of the `rst $00` table in VaultMenu_Case03
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Case03_Case0A::
Jump_01C_70C6:: ; address name
    farcall VaultMenu_Case03_Case0A_Sub01
    ret

; entry 11 of the `rst $00` table in VaultMenu_Case03
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Case03_Case0B::
Jump_01C_70CD:: ; address name
    farcall VaultMenu_Case03_Case0B_Sub01
    ret

; entry 12 of the `rst $00` table in VaultMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
VaultMenu_Case03_Case0C::
Jump_01C_70D4:: ; address name
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0088
    add hl, de
    ld bc, $0C09
    ld de, vBGMap1 + $370
    call DrawRectBothBanksSetTextCursorLoPlus1C1
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    ld bc, $0703
    ld de, vBGMap1 + $3E0
    call DrawRectBothBanksSetTextCursorLoPlus1C1
    ld a, $03
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 13 of the `rst $00` table in VaultMenu_Case03
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Case03_Case0D::
Jump_01C_7103:: ; address name
    farcall VaultMenu_Case03_Case0D_Sub01
    ret

; entry 14 of the `rst $00` table in VaultMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
VaultMenu_Case03_Case0E::
Jump_01C_710A:: ; address name
    ld a, [wScreenState]
    cp a, $03
    jr z, Jump_01C_7118
    farcall VaultMenu_Case03_Case0E_Sub01
    ret

Jump_01C_7118::
    call RemoveItemCountFromInventory
    farcall VaultMenu_Case03_Case0E_Sub02
    farcall VaultMenu_Case03_Case0E_Sub03
    ret

; entry 15 of the `rst $00` table in VaultMenu_Case03
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Case03_Case0F::
Jump_01C_7128:: ; address name
    call InitItemListScreenListAndDraw
    farcall VaultMenu_Case03_Case0F_Sub01
    ret

; entry 16 of the `rst $00` table in VaultMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; writes: wTwoChoiceCursor, wScreenStep
VaultMenu_Case03_Case10::
Jump_01C_7132:: ; address name
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0088
    add hl, de
    ld bc, $0C09
    ld de, vBGMap1 + $370
    call DrawRectBothBanksSetTextCursorLoPlus1C1
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    ld bc, $0703
    ld de, vBGMap1 + $3E0
    call DrawRectBothBanksSetTextCursorLoPlus1C1
    xor a, a
    ld [wTwoChoiceCursor], a
    ld a, $04
    ld [wScreenStep], a
    ret

; entry 17 of the `rst $00` table in VaultMenu_Case03
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Case03_Case11::
Jump_01C_715C:: ; address name
    farcall DrawRect0147AndResetNumberEditPos
    ret

; entry 19 of the `rst $00` table in VaultMenu_Case03
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Case03_Case13::
Jump_01C_7163:: ; address name
    farcall VaultMenu_Shared02
    ret

; entry 18 of the `rst $00` table in VaultMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
VaultMenu_Case03_Case12::
Jump_01C_716A:: ; address name
    ld hl, vTiles1 + $4C0
    ld de, vTiles2 + $700
    call CopyTileBytesToVRAM_Bank1C
    ld hl, vTiles1 + $4C0
    ld de, Data_01F_4500
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 20 of the `rst $00` table in VaultMenu_Case03
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Case03_Case14::
Jump_01C_7188:: ; address name
    farcall VaultMenu_Case03_Case14_Sub01
    ret

; entry 21 of the `rst $00` table in VaultMenu_Case03
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Case03_Case15::
Jump_01C_718F:: ; address name
    farcall VaultMenu_Case03_Case15_Sub01
    ret

; clears the rectangle at scroll + $147, copies a tile, runs Func_01C_7252, wD781 = 3, wTwoChoiceCursor = 2 and requests script $80 (E-0124)
; 1 call site from 1 routine (e.g. VaultMenu_Case03_Case18)
; writes: wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
ClearRect147AndAskTwoChoice::
Func_01C_7196:: ; address name
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0147
    add hl, de
    ld de, vBGMap1 + $370
    ld bc, $0D03
    call DrawRectBothBanksSetTextCursorLoPlus1C1
    ld hl, vTiles2 + $700
    ld de, vTiles1 + $4C0
    call CopyTileBytesToVRAM_Bank1C
    call InitItemListScreenListAndDraw
    ld a, $03
    ld [wScreenStep], a
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 23 of the `rst $00` table in VaultMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType, wScriptStartRequest
; points at: wScreenList, wScreenBlock92
VaultMenu_Case03_Case17::
Jump_01C_71C6:: ; address name
    ld hl, wScreenList
    ld de, Data_01C_5F5E
    ld bc, $0020

Jump_01C_71CF::
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01C_71CF
    ld hl, wScreenBlock92
    call DrawGoldDigitsAtHLWrapped_1C
    call BGMapAddressAtScroll_Bank1C_67AF
    ld a, $0C
    add_a_to_hl
    ld de, wScreenList
    ld bc, $0802
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    farcall VaultMenu_Shared02
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 24 of the `rst $00` table in VaultMenu_Case03
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenState, wScreenStep
VaultMenu_Case03_Case18::
Jump_01C_7200:: ; address name
    call ClearRect147AndAskTwoChoice
    ld a, $01
    ld [wScreenState], a
    ld a, $02
    ld [wScreenStep], a
    ret

; entry 4 of the `rst $00` table in VaultMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
VaultMenu_Case04::
Jump_01C_720E:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw VaultMenu_Case03_Case00
    dw VaultMenu_Case03_Case01
    dw VaultMenu_Case03_Case02
    dw VaultMenu_Case04_Case03
    dw VaultMenu_Case03_Case04
    dw VaultMenu_Case03_Case05
    dw VaultMenu_Case03_Case06
    dw VaultMenu_Case03_Case07
    dw VaultMenu_Case03_Case08
    dw VaultMenu_Case03_Case09
    dw VaultMenu_Case03_Case0A
    dw VaultMenu_Case03_Case0B
    dw VaultMenu_Case03_Case0C
    dw VaultMenu_Case03_Case0D
    dw VaultMenu_Case03_Case0E
    dw VaultMenu_Case03_Case0F
    dw VaultMenu_Case03_Case10
    dw VaultMenu_Case03_Case11
    dw VaultMenu_Case03_Case12
    dw VaultMenu_Case03_Case13
    dw VaultMenu_Case03_Case14
    dw VaultMenu_Case04_Case15
    dw ClearRect147AndAskTwoChoice
    dw VaultMenu_Case03_Case17
    dw VaultMenu_Case03_Case18

; entry 3 of the `rst $00` table in VaultMenu_Case04
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Case04_Case03::
Jump_01C_7244:: ; address name
    farcall VaultMenu_Case04_Case03_Sub01
    ret

; entry 21 of the `rst $00` table in VaultMenu_Case04
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Case04_Case15::
Jump_01C_724B:: ; address name
    farcall VaultMenu_Case04_Case15_Sub01
    ret

; copies $20 bytes from Data_01C_5F5E to wD788, counts the inventory items into wD7B0 and its digits, and draws the 8 x 4 list at scroll + $0C (E-0127)
; 2 call sites from 2 routines (e.g. ClearRect147AndAskTwoChoice, VaultMenu_Case03_Case0F)
; reads: wDigits
; writes: wListPages, wItemCountTens, wItemCountOnes
; points at: wScreenList, wScreenBlock92, wInventory
InitItemListScreenListAndDraw::
Func_01C_7252:: ; address name
    ld hl, wScreenList
    ld de, Data_01C_5F5E
    ld bc, $0020

Jump_01C_725B::
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Jump_01C_725B
    ld hl, wScreenBlock92
    call DrawGoldDigitsAtHLWrapped_1C
    ld hl, wInventory
    ld c, $00
    ld b, $00

Jump_01C_7270::
    ld a, [hl+]
    and a, a
    jr z, Jump_01C_7279
    cp a, $FF
    jr z, Jump_01C_7279
    inc b

Jump_01C_7279::
    inc c
    ld a, c
    cp a, $18
    jr c, Jump_01C_7270
    ld a, b
    ld [wListPages], a
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld a, [wDigits + $1]
    and a, a
    jr z, Jump_01C_7297
    ld a, [wDigits + $1]
    add a, $E0
    ld [wItemCountTens], a

Jump_01C_7297::
    ld a, [wDigits + $2]
    add a, $E0
    ld [wItemCountOnes], a
    call BGMapAddressAtScroll_Bank1C_67AF
    ld a, $0C
    add_a_to_hl
    ld de, wScreenList
    ld bc, $0804
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    ret

; only called from routines of VaultMenu (E-0098)
; 2 call sites from 2 routines (e.g. VaultMenu_Case03_Case09, VaultMenu_Case03_Case06)
; reads: wScreenCounter, wGlyphListPos
; writes: wGlyphListPos
VaultMenu_Shared01::
Func_01C_72B3:: ; address name
    ld a, [wScreenCounter]
    sla a
    ld hl, TileDestTable_1C_6289
    add_a_to_hl
    ld a, [hl]
    ld e, a
    inc hl
    ld a, [hl]
    ld d, a

Jump_01C_72C5::
    push de
    ld a, [wGlyphListPos]
    sla a
    add a, e
    ld e, a
    jr nc, Jump_01C_72D0
    inc d

Jump_01C_72D0::
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld de, Data_01F_4910
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    cp a, $09
    jr c, Jump_01C_72C5
    xor a, a
    ld [wGlyphListPos], a
    ret
    ds $D10, $00
