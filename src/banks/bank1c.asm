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
    jr z, .skip
    ld hl, wScreenAttrBuffer
    ld de, wWindowAttrBuffer + $A0
    ld bc, $00A0
    call CopyLow3BitsToWRAMBank2_Bank1C

.skip:
    ld hl, wWindowTileBuffer
    ld de, wWindowTileBuffer + $A0
    ld bc, $00A0
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a, a
    jr z, .call_bg_map_address_at_scroll_bank1_c
    ld hl, wWindowAttrBuffer
    ld de, wWindowAttrBuffer + $A0
    ld bc, $00A0
    call CopyLow3BitsToWRAMBank2_Bank1C

.call_bg_map_address_at_scroll_bank1_c:
    call BGMapAddressAtScroll_Bank1C
    ld bc, $1408
    ld de, $0168
    call DrawScreenBufferRectToBGMap_1C
    ld bc, $001A
    ld hl, wScreenState

.loop:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
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

; implements script command type E0 (SCRIPT_INN): the inn: 'It's 0G a night. Will you...', 'Good morning and farewell!' (mode 1, bank $F0 strings); reached through ScriptCommandE0 in bank $10 (E-0038, E-0244) (C2 from E-0327: the Kalka inn's stay costs 10G and runs it)
; 1 call site from 1 routine (e.g. ScriptCommandE0)
; reads: wScreenState
InnMenu::
Func_01C_4075:: ; address name
    ld a, [wScreenState]
    rst $00
    dw InnMenu_Init
    dw InnMenu_ShowPrice
    dw InnMenu_Pay
    dw InnMenu_FadeOut
    dw InnMenu_WaitFade
    dw InnMenu_AdvanceScreenState
    dw InnMenu_RestoreParty
    dw InnMenu_Morning
    dw InnMenu_RestartMusic

; state 0 of InnMenu: clears the screen state (E-0276)
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wMessageMode, wScriptCommandType, wScriptStartRequest
; points at: wScreenState, wWindowTileBuffer, wScreenTileBuffer, wWindowAttrBuffer, wScreenAttrBuffer
InnMenu_Init::
Jump_01C_408B:: ; address name
    ld bc, $001A
    ld hl, wScreenState

.loop:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld hl, wWindowTileBuffer
    ld de, wScreenTileBuffer
    ld bc, $00A0
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a, a
    jr z, .skip
    ld hl, wWindowAttrBuffer
    ld de, wScreenAttrBuffer
    ld bc, $00A0
    call CopyLow3BitsToWRAMBank2_Bank1C

.skip:
    ld hl, wWindowTileBuffer + $A0
    ld de, wScreenTileBuffer
    ld bc, $00A0
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a, a
    jr z, .call_inn_menu_init_write_arg7_and_arg8_etc
    ld hl, wWindowAttrBuffer + $A0
    ld de, wScreenAttrBuffer
    ld bc, $00A0
    call CopyLow3BitsToWRAMBank2_Bank1C

.call_inn_menu_init_write_arg7_and_arg8_etc:
    call InnMenu_Init_WriteArg7AndArg8Etc
    ld a, $01
    ld [wMessageMode], a
    ld hl, wScreenState
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; draws the gold window (DrawGoldDigitsAtHLWrapped_1C) for 'It's 0G a night' (E-0276)
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowState
; writes: wMenuState, wScriptCommandType, wScriptStartRequest
; points at: wScreenSubStep, wScreenArea, wScreenState
InnMenu_ShowPrice::
Jump_01C_40EA:: ; address name
    ld hl, wScreenSubStep
    ld de, InnMenu_ShowPrice_Data
    ld c, $00

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $18
    jr c, .loop
    ld hl, wScreenArea
    call DrawGoldDigitsAtHLWrapped_1C
    ld a, [wTextWindowState]
    bit 7, a
    jr nz, .skip
    ld de, wScreenSubStep
    ld hl, wWindowTileBuffer + $C
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank1C
    ld de, wScreenSubStep
    ld hl, wScreenTileBuffer + $C
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank1C
    jr .call_bg_map_address_at_scroll_bank1_c

.skip:
    ld de, wScreenSubStep
    ld hl, wWindowTileBuffer + $70
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank1C
    ld de, wScreenSubStep
    ld hl, wScreenTileBuffer + $70
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank1C

.call_bg_map_address_at_scroll_bank1_c:
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

; address loaded by InnMenu_ShowPrice
InnMenu_ShowPrice_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01C_4158:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $BF, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; checks the price against the gold (IsAmountInArg1AboveGold) and redraws the gold (E-0276)
; no direct call (reached through a table, a jump or a vector)
; reads: wArg7, wArg8, wMenuInputResult, wArg1
; writes: wArg3, wArg2, wArg1, wTextYesNoResult, wMenuState, wScriptCommandType, wScriptStartRequest
; points at: wScreenState
InnMenu_Pay::
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
    jr z, .restore
    pop hl
    pop de
    xor a, a
    ld [wTextYesNoResult], a
    ld [wMenuState], a
    call InnMenu_Pay_WriteGoldHiAndGoldMidEtc
    call InnMenu_Pay_CopyBytesDEToHL_Bank1C
    call InnMenu_Pay_DrawGoldDigitsAtHLWrapped_1C
    ld hl, wScreenState
    inc [hl]
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.restore:
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

; starts a palette fade (StartPaletteFade) for the night (E-0276)
; no direct call (reached through a table, a jump or a vector)
; writes: wFadeMode
; points at: wScreenState
InnMenu_FadeOut::
Jump_01C_41CD:: ; address name
    ld a, $87
    ld [wFadeMode], a
    ld a, $04
    call StartPaletteFade
    ld hl, wScreenState
    inc [hl]
    ret

; waits until wFadeState is 0, then advances wScreenState (E-0276)
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; points at: wScreenState
InnMenu_WaitFade::
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
InnMenu_AdvanceScreenState::
Jump_01C_41E6:: ; address name
    ld hl, wScreenState
    inc [hl]
    ret

; for each wPartyList record whose byte $55 bit 7 is clear, copies max HP ($5D) to HP ($5B) and max MP ($61) to MP ($5F) (E-0276) (C2 from E-0327: a stay turns HP 5/21 and MP 7/35 into 21/21 and 35/35)
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount, hTemp0, wArg5, wArg6, wArg7, wArg8
; writes: rRAMG2, rRAMB, wArg5, wArg6, wArg7, wArg8
; points at: wPartyList, wScreenState
InnMenu_RestoreParty::
Jump_01C_41EB:: ; address name
    ld a, [wPartyCount]
    and a, a
    jp z, .skip
    ld c, a
    ld hl, wPartyList
    ld a, $0A
    ld [rRAMG2], a
    xor a, a
    ld [rRAMB], a

.loop:
    push bc
    push hl
    ld a, [hl]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .restore
    pop hl
    push hl
    ld a, [hl]
    ld c, MON_MAX_HP
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
    ld c, MON_HP
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

.restore:
    pop hl
    pop bc
    inc hl
    dec c
    ld a, c
    and a, a
    jp nz, .loop
    xor a, a
    ld [rRAMG2], a

.skip:
    ld hl, wScreenState
    inc [hl]
    ld a, $40
    call QueueMusic
    ret

; after $90 frames sends the SGB palette set, fades back in and refreshes the town/key-world objects (E-0276)
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep, wMapType
; writes: wScreenStep, wFadeMode, wGameMode2Byte50, wKeyWorldRefresh
; points at: wScreenStep, wScreenState
InnMenu_Morning::
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
    jr nz, .call_refresh_key_world_objects_on_entry
    farcall SetupTownObjectsForMap
    ret

.call_refresh_key_world_objects_on_entry:
    farcall RefreshKeyWorldObjectsOnEntry
    ret

; restarts the map music (RestartMapMusic) (E-0276)
; no direct call (reached through a table, a jump or a vector)
; reads: wFadeState
; writes: wFadeMode, wScriptCommandType, wScriptStartRequest
; points at: wScreenState
InnMenu_RestartMusic::
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

; when the Super Game Boy is active, sets the four palette numbers 4 * wSGBPaletteSet + 0-3, sends a PAL_SET ($B1) packet with attribute file wSGBAttrFile, waits, and loads the object palettes (E-0121)
; 3 call sites from 3 routines (e.g. InnMenu_Morning, BreedMenu_RestoreScreen_DrawGoldBoxAndStep_Bank15, GameMode5_Update_Case07_LinkExchangeJoypadPerFrame)
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
; 8 call sites from 6 routines (e.g. CloseInnMenu, VaultMenu_Init, CloseShopMenu_Case00_CopyBytesDEToHL_Bank1C, ShopMenu_Init, ...)
; writes: rSVBK
CopyLow3BitsToWRAMBank2_Bank1C::
Func_01C_4303:: ; address name
    ld a, $02
    ldh [rSVBK], a

.loop:
    ld a, [de]
    and a, $07
    inc de
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld a, $00
    ldh [rSVBK], a
    ret

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
; 8 call sites from 6 routines (e.g. CloseInnMenu, VaultMenu_Init, CloseShopMenu_Case00_CopyBytesDEToHL_Bank1C, ShopMenu_Init, ...)
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
; 11 call sites from 5 routines (e.g. InnMenu_Pay_DrawGoldDigitsAtHLWrapped_1C, InnMenu_ShowPrice, ShopMenu_Setup_DrawScreenListBoxAtWC370AndStep, DrawScreenListBoxAtWC370AndStep, ...)
; reads: wIsCGB
; writes: rSVBK
CopyRectTo20ByteRowsJp_Bank1C::
Func_01C_431F:: ; address name
    push hl
    push bc

.loop:
    push hl
    push bc

.loop2:
    ld a, [de]
    inc de
    ld [hl+], a
    dec b
    jr nz, .loop2
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jp nz, .loop
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

.loop3:
    push hl
    push bc

.loop4:
    xor a, a
    ld [hl+], a
    dec b
    jr nz, .loop4
    pop bc
    pop hl
    ld a, l
    add a, $14
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jp nz, .loop3
    ld a, $00
    ldh [rSVBK], a
    ret

; with story flag 2, no text, wFieldActionRequest bit 7 clear, a non-empty party and hPlayerStateFlags bit 0 clear: hSpriteWindowClipMode = 3, sets bit 1 of the player and object flags and returns A = $FF; otherwise 0 (E-0124)
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowState, wFieldActionRequest, wPartyCount, hPlayerStateFlags
; writes: hSpriteWindowClipMode
TryStartFieldMenu:: ; heuristic: follows a terminator; C0
Func_01C_4364:: ; address name
    ld de, $0002
    call TestFlagBit
    jr nc, .return_0
    ld a, [wTextWindowState]
    and a, $03
    jr nz, .return_0
    ld a, [wFieldActionRequest]
    bit 7, a
    jr nz, .return_0
    ld a, [wPartyCount]
    or a, a
    jr z, .return_0
    ldh a, [hPlayerStateFlags]
    bit 0, a
    jr nz, .return_0
    ld a, $03
    ldh [hSpriteWindowClipMode], a
    farcall SetBit1OfPlayerAndObjectFlags
    ld a, $FF
    ret

.return_0:
    xor a, a
    ret

; writes the gold as up to five decimal digit tiles without leading zeros at HL in VRAM, wrapping at the row end (E-0128)
; 7 call sites from 7 routines (e.g. InnMenu_Pay_DrawGoldDigitsAtHLWrapped_1C, InnMenu_ShowPrice, InitItemListScreenListAndCount, ShopMenu_Buy_SubtractArg1AmountFromGold, ...)
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
    jp .skip2

.loop:
    ld a, [de]
    srl a
    srl a
    srl a
    srl a
    or a, a
    jp nz, .call_write_vram_byte
    bit 0, c
    jp z, .next

.call_write_vram_byte:
    add a, $E0
    call WriteVRAMByte
    ld c, $01

.next:
    inc hl
    ld a, l
    and a, $1F
    jp nz, .skip
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

.skip:
    ld a, b
    dec a
    jp nz, .skip2
    ld c, $01

.skip2:
    ld a, [de]
    dec de
    and a, $0F
    jp nz, .call_write_vram_byte2
    bit 0, c
    jp z, .next2

.call_write_vram_byte2:
    add a, $E0
    call WriteVRAMByte
    ld c, $01

.next2:
    inc hl
    ld a, l
    and a, $1F
    jp nz, .next3
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

.next3:
    dec b
    jr nz, .loop
    ret

; compares the 24-bit value wArg3:wArg2:wArg1 (wArg3 most significant) with wGoldHi:wGoldMid:wGoldLo: wArg1 = $FF when it is greater, 0 when it is less or equal (the low byte is overwritten with the result) (E-0073)
; 10 call sites from 9 routines (e.g. InnMenu_Pay, ShopMenu_Buy_BlinkCursorBlinkD2_Bank1C_52A0, ArenaMenu_UpdateTwoChoiceCursor_Bank1D, ArenaMenu_UpdateTwoChoiceCursor_Bank1D_Case17, ...)
; reads: wGoldHi, wArg3, wGoldMid, wArg2, wGoldLo, wArg1
; writes: wArg1
IsAmountInArg1AboveGold::
Func_01C_440F:: ; address name
    ld a, [wGoldHi]
    ld b, a
    ld a, [wArg3]
    cp a, b
    jr z, .read_gold_mid
    jr c, .clear_arg1
    jr .set_arg1_to_FF

.read_gold_mid:
    ld a, [wGoldMid]
    ld b, a
    ld a, [wArg2]
    cp a, b
    jr z, .read_gold_lo
    jr c, .clear_arg1
    jr .set_arg1_to_FF

.read_gold_lo:
    ld a, [wGoldLo]
    ld b, a
    ld a, [wArg1]
    cp a, b
    jr z, .clear_arg1
    jr c, .clear_arg1

.set_arg1_to_FF:
    ld a, $FF
    ld [wArg1], a
    ret

.clear_arg1:
    xor a, a
    ld [wArg1], a
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 3 call sites from 3 routines (e.g. CloseInnMenu, InnMenu_Pay_DrawGoldDigitsAtHLWrapped_1C, InnMenu_ShowPrice)
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

; only called from InnMenu_Init (E-0047)
; 1 call site from 1 routine (e.g. InnMenu_Init)
; writes: wArg7, wArg8, wMenuInputResult
; points at: wDigits, wTextBuf0
InnMenu_Init_WriteArg7AndArg8Etc::
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
    jr nz, .skip
    inc hl
    dec c
    ld a, [hl]
    and a, a
    jr nz, .skip
    inc hl
    dec c

.skip:
    ld a, c
    and a, a
    jr z, .done
    ld a, [hl+]
    ld [de], a
    inc de
    dec c
    jr .skip

.done:
    ld a, $F0
    ld [de], a
    ret

; copies a rectangle of the screen buffer (offset DE) to the BG map at HL, sets wTextCursorLo = HL + $1C1, and on CGB copies its attributes (E-0127)
; 5 call sites from 5 routines (e.g. CloseInnMenu, CloseShopMenu_Case00_CopyBytesDEToHL_Bank1C, InnMenu_Pay_DrawGoldDigitsAtHLWrapped_1C, InnMenu_ShowPrice, ...)
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

; only called from InnMenu_Pay (E-0047)
; 1 call site from 1 routine (e.g. InnMenu_Pay)
; reads: wArg7, wArg8, wMenuInputResult, wGoldHi, wGoldMid, wGoldLo
; writes: wGoldHi, wGoldMid, wGoldLo
InnMenu_Pay_WriteGoldHiAndGoldMidEtc::
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

; only called from InnMenu_Pay (E-0047)
; 1 call site from 1 routine (e.g. InnMenu_Pay)
; reads: wIsCGB
; points at: wWindowTileBuffer, wWindowAttrBuffer
InnMenu_Pay_CopyBytesDEToHL_Bank1C::
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

; only called from InnMenu_Pay (E-0047)
; 1 call site from 1 routine (e.g. InnMenu_Pay)
; reads: wTextWindowState
; points at: wScreenSubStep, wScreenArea
InnMenu_Pay_DrawGoldDigitsAtHLWrapped_1C::
Func_01C_453B:: ; address name
    ld hl, wScreenSubStep
    ld de, InnMenu_Pay_DrawGoldDigitsAtHLWrapped_1C_Data
    ld c, $00

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    inc c
    ld a, c
    cp a, $18
    jr c, .loop
    ld hl, wScreenArea
    call DrawGoldDigitsAtHLWrapped_1C
    ld a, [wTextWindowState]
    bit 7, a
    jr nz, .skip
    ld de, wScreenSubStep
    ld hl, wWindowTileBuffer + $C
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank1C
    ld de, wScreenSubStep
    ld hl, wScreenTileBuffer + $C
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank1C
    jr .call_bg_map_address_at_scroll_bank1_c

.skip:
    ld de, wScreenSubStep
    ld hl, wWindowTileBuffer + $70
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank1C
    ld de, wScreenSubStep
    ld hl, wScreenTileBuffer + $70
    ld bc, $0803
    call CopyRectTo20ByteRowsJp_Bank1C

.call_bg_map_address_at_scroll_bank1_c:
    call BGMapAddressAtScroll_Bank1C
    ld bc, $1408
    ld de, $0168
    call DrawScreenBufferRectToBGMap_1C
    ret

; address loaded by InnMenu_Pay_DrawGoldDigitsAtHLWrapped_1C
InnMenu_Pay_DrawGoldDigitsAtHLWrapped_1C_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01C_4598:: ; address name
    db $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $BF, $C3, $C3, $C3, $C3, $C3, $B7
    db $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

; adds the 24-bit wArg1-wArg3 to the gold, capped at 99,999 ($01869F) (E-0127) (C2 from E-0327: selling a Herb at 99,999 gold leaves 99,999)
; 2 call sites from 2 routines (e.g. ShopMenu_Sell_AddArg1ToGoldCapped99999, ArenaMenu_AddArg1ToGoldCapped99999)
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
    jr nc, .set_gold_hi_to_01
    cp a, $01
    jr c, .set_gold_hi
    ld a, b
    cp a, $87
    jr nc, .set_gold_hi_to_01
    cp a, $86
    jr c, .set_gold_hi
    ld a, c
    cp a, $A1
    jr nc, .set_gold_hi_to_01
    cp a, $A0
    jr c, .set_gold_hi
    jr .set_gold_hi_to_01

.set_gold_hi:
    ld a, h
    ld [wGoldHi], a
    ld a, b
    ld [wGoldMid], a
    ld a, c
    ld [wGoldLo], a
    ret

.set_gold_hi_to_01:
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
    dw CloseShopMenu_ToCloseShopMenu_Case00_CopyBytesDEToHL_Bank1C
    dw CloseShopMenu_ToCloseShopMenu_Case01_SetGlyphListPos
    dw CloseShopMenu_DecompressToVRAM
    dw CloseShopMenu_DrawRecordListNameTiles_Bank1D

; entry 0 of the `rst $00` table in CloseShopMenu
; no direct call (reached through a table, a jump or a vector)
CloseShopMenu_ToCloseShopMenu_Case00_CopyBytesDEToHL_Bank1C::
Jump_01C_4611:: ; address name
    call CloseShopMenu_Case00_CopyBytesDEToHL_Bank1C
    ret

; entry 1 of the `rst $00` table in CloseShopMenu
; no direct call (reached through a table, a jump or a vector)
CloseShopMenu_ToCloseShopMenu_Case01_SetGlyphListPos::
Jump_01C_4615:: ; address name
    call CloseShopMenu_Case01_SetGlyphListPos
    ret

; entry 2 of the `rst $00` table in CloseShopMenu
; no direct call (reached through a table, a jump or a vector)
; reads: wGridCursorY
; writes: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wGridCursorY
CloseShopMenu_DecompressToVRAM::
Jump_01C_4619:: ; address name
    ld b, $46
    ld de, Tiles1Gfx_46_4001
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
CloseShopMenu_DrawRecordListNameTiles_Bank1D::
Jump_01C_465B:: ; address name
    farcall DrawRecordListNameTiles_Bank1D
    farcall LoadTilesForPartyRecords
    xor a, a
    ld [wMessageMode], a
    ld [wGridCursorY], a
    ld bc, $0070
    ld hl, wScreenState

.loop:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld hl, wTextBuf0
    ld b, $10

.loop2:
    ld a, $F0
    ld [hl+], a
    dec b
    jr nz, .loop2
    farcall WritePlayerNameWithFlag0SuffixToTextBuf0
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type E2 (SCRIPT_SHOP): the shop: 'What would you like to buy?', 'That comes to 0G. OK?'; reads ShopItemListTable and ItemValueTable (mode 2); reached through ScriptCommandE2 in bank $10 (E-0038, E-0244) (C2 from E-0327: GreatLog's merchant opens it with Buy / Sell / Exit)
; 1 call site from 1 routine (e.g. ScriptCommandE2)
; reads: wScreenState
ShopMenu::
Func_01C_4696:: ; address name
    ld a, [wScreenState]
    rst $00
    dw ShopMenu_Init
    dw ShopMenu_Setup
    dw ShopMenu_ChooseAction
    dw ShopMenu_Buy
    dw ShopMenu_Sell

; clears $70 bytes from wScreenState (state 0 of ShopMenu) (E-0276)
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wMessageMode, wGlyphListPos, wScreenCounter, wNumberTens, wNumberOnes, wNumberEditPos, wScriptCommandType, wScriptStartRequest
; points at: wScreenState, wScreenTileBuffer, wScreenAttrBuffer
ShopMenu_Init::
Jump_01C_46A4:: ; address name
    ld bc, $0070
    ld hl, wScreenState

.loop:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a, a
    jr z, .set_message_mode_to_02
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank1C

.set_message_mode_to_02:
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

; screen setup steps (tile lists, item list screen) (E-0276)
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
ShopMenu_Setup::
Jump_01C_46F4:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw ShopMenu_Setup_AdvanceScreenStep
    dw ShopMenu_Setup_ToCopyTileListFromBank1F_1C
    dw ShopMenu_Setup_ToInitItemListScreenListAndCount
    dw ShopMenu_Setup_DrawScreenListBoxAtWC370AndStep
    dw ShopMenu_Setup_SetScreenStep

; increments wScreenStep
; no direct call (reached through a table, a jump or a vector)
; points at: wScreenStep
ShopMenu_Setup_AdvanceScreenStep::
Jump_01C_4702:: ; address name
    ld hl, wScreenStep
    inc [hl]

; entry 1 of the `rst $00` table in ShopMenu_Setup
; no direct call (reached through a table, a jump or a vector)
ShopMenu_Setup_ToCopyTileListFromBank1F_1C::
Jump_01C_4706:: ; address name
    ld hl, TileCopyDestList_1C_5F86
    ld de, TileCopySrcList_1C_5FE8
    call CopyTileListFromBank1F_1C
    ret

; entry 2 of the `rst $00` table in ShopMenu_Setup
; no direct call (reached through a table, a jump or a vector)
ShopMenu_Setup_ToInitItemListScreenListAndCount::
Jump_01C_4710:: ; address name
    call InitItemListScreenListAndCount
    ret

; entry 3 of the `rst $00` table in ShopMenu_Setup
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wScreenState
ShopMenu_Setup_DrawScreenListBoxAtWC370AndStep::
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

; entry 4 of the `rst $00` table in ShopMenu_Setup
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wScreenState
ShopMenu_Setup_SetScreenStep::
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

; the shop's choice menu: Up/Down move the cursor, A selects, B leaves (E-0276)
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wListLastRow, wScreenByteB2, wListPages, wScreenState
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wItemGridX, wItemGridY, wScreenByteB2, wScreenState, wTextTimer, ...
ShopMenu_ChooseAction::
Jump_01C_4785:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_shop_menu_choose_action_read_list_last
    bit 7, a
    jr nz, .call_shop_menu_choose_action_read_list_last2
    ld a, [wJoypadPressed]
    bit 0, a
    jr nz, .call_shop_menu_choose_action_step_bg_map
    bit 1, a
    jp nz, .set_two_choice_cursor_to_02
    call ShopMenu_ChooseAction_WriteScreenByteB3
    ret

.call_shop_menu_choose_action_read_list_last:
    call ShopMenu_ChooseAction_ReadListLastRow_Sub03
    ld a, [wListLastRow]
    and a, a
    jr nz, .skip
    ld a, $02

.set_list_last_row:
    ld [wListLastRow], a
    xor a, a
    ld [wScreenByteB3], a
    call ShopMenu_ChooseAction_ReadListLastRow
    ld a, $69
    call QueueSoundEffect
    ret

.skip:
    dec a
    jr .set_list_last_row

.call_shop_menu_choose_action_read_list_last2:
    call ShopMenu_ChooseAction_ReadListLastRow_Sub03
    ld a, [wListLastRow]
    cp a, $02
    jr c, .skip2
    xor a, a
    jr .set_list_last_row

.skip2:
    inc a
    jr .set_list_last_row

.call_shop_menu_choose_action_step_bg_map:
    call ShopMenu_ChooseAction_StepBGMapAddressBackOnScrollWrap
    ld a, $69
    call QueueSoundEffect
    ld a, [wListLastRow]
    ld [wTwoChoiceCursor], a
    ld b, a
    ld a, [wScreenByteB2]
    cp a, b
    jr z, .set_screen_byte_b2
    ld a, [wListLastRow]
    ld b, a
    xor a, a
    ld [wItemGridX], a
    ld [wItemGridY], a

.set_screen_byte_b2:
    ld a, b
    ld [wScreenByteB2], a
    ld a, [wListLastRow]
    and a, a
    jr z, .check_list_pages
    cp a, $01
    jr z, .check_list_pages2

.clear_script_command_type:
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_list_pages:
    ld a, [wListPages]
    cp a, $18
    jr c, .check_screen_state

.check_screen_state:
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wTextTimer], a
    jp .clear_script_command_type

.check_list_pages2:
    ld a, [wListPages]
    and a, a
    jr nz, .set_two_choice_cursor_to_01
    ld a, $04
    ld [wTwoChoiceCursor], a
    jp .clear_script_command_type

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    add a, $02
    ld [wScreenState], a
    xor a, a
    ld [wTextTimer], a
    jp .clear_script_command_type

.set_two_choice_cursor_to_02:
    ld a, $02
    ld [wTwoChoiceCursor], a
    jp .clear_script_command_type

; only called from ShopMenu_ChooseAction (E-0047)
; 1 call site from 1 routine (e.g. ShopMenu_ChooseAction)
; reads: wJoypadRepeatTimer, wScreenByteB3, wListLastRow
; writes: wScreenByteB3
ShopMenu_ChooseAction_WriteScreenByteB3::
Func_01C_4845:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, ShopMenu_ChooseAction_ReadListLastRow
    ld a, [wScreenByteB3]
    inc a
    ld [wScreenByteB3], a
    cp a, $10
    jr c, ShopMenu_ChooseAction_ReadListLastRow
    cp a, $18
    jr c, ShopMenu_ChooseAction_ReadListLastRow_Sub03
    xor a, a
    ld [wScreenByteB3], a

; only called from ShopMenu_ChooseAction (E-0047)
; 1 call site from 1 routine (e.g. ShopMenu_ChooseAction)
; reads: wListLastRow
ShopMenu_ChooseAction_ReadListLastRow::
Func_01C_485F:: ; address name
    ld b, $BB
    jr ShopMenu_ChooseAction_StepBGMapAddressBackOnScrollWrap_ReadListLastRow

; only called from ShopMenu_ChooseAction (E-0047)
; 2 call sites from 1 routine (e.g. ShopMenu_ChooseAction)
; reads: wListLastRow
ShopMenu_ChooseAction_ReadListLastRow_Sub03::
Func_01C_4863:: ; address name
    ld b, $C3
    jr ShopMenu_ChooseAction_StepBGMapAddressBackOnScrollWrap_ReadListLastRow

; only called from ShopMenu_ChooseAction (E-0047)
; 1 call site from 1 routine (e.g. ShopMenu_ChooseAction)
; reads: wListLastRow
ShopMenu_ChooseAction_StepBGMapAddressBackOnScrollWrap::
Func_01C_4867:: ; address name
    ld b, $BC

ShopMenu_ChooseAction_StepBGMapAddressBackOnScrollWrap_ReadListLastRow::
Jump_01C_4869:: ; address name
    ld a, [wListLastRow]
    add a, a
    ld hl, ShopMenu_ChooseAction_StepBGMapAddressBackOnScrollWrap_Data
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

; address loaded by ShopMenu_ChooseAction_StepBGMapAddressBackOnScrollWrap
ShopMenu_ChooseAction_StepBGMapAddressBackOnScrollWrap_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01C_4888:: ; address name
    db $21, $00, $61, $00, $A1, $00

; buying: items from ShopItemListTable for wScreenTableIndex, a gold check (IsAmountInArg1AboveGold) and SubtractArg1AmountFromGold (E-0276)
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
ShopMenu_Buy::
Jump_01C_488E:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw ShopMenu_Buy_WriteVBKAndScreenStep
    dw ShopMenu_Buy_DrawRectBothBanksSetTextCursorLoPlus1C1
    dw ShopMenu_Buy_LoadArg1PointerForScreenTableIndex
    dw ShopMenu_Buy_WriteGlyphListPosAndCursorBlinkB8Etc
    dw ShopMenu_Buy_AdvanceScreenStep
    dw ShopMenu_Buy_LoadArg1PointerForScreenTableIndex_Case05
    dw ShopMenu_Buy_BlinkCursorSelectedRecord_Bank1C
    dw ShopMenu_Buy_ResetTextCounter0Counters
    dw ShopMenu_Buy_StepBGMapAddressBackOnScrollWrap_Case08
    dw ShopMenu_Buy_BlinkCursorBlinkCD_Bank1C_4F87
    dw ShopMenu_Buy_LoadArg1PointerForScreenTableIndex_Case0A
    dw ShopMenu_Buy_StepBGMapAddressBackOnScrollWrap
    dw ShopMenu_Buy_BlinkCursorBlinkD2_Bank1C_52A0
    dw DrawTwoBoxesAndRequestScript80
    dw ShopMenu_Buy_SubtractArg1AmountFromGold
    dw ShopMenu_Buy_DrawTwoBoxesAndRequestScript80
    dw ShopMenu_Buy_StepBGMapAddressBackOnScrollWrap_Case10

; entry 0 of the `rst $00` table in ShopMenu_Buy; also entry 0 of the table in ShopMenu_Sell
; no direct call (reached through a table, a jump or a vector)
; reads: rSTAT, wIsCGB, wScreenStep
; writes: rVBK, wScreenStep
ShopMenu_Buy_WriteVBKAndScreenStep::
Jump_01C_48B4:: ; address name
    ld hl, ShopMenu_Buy_WriteVBKAndScreenStep_Data
    ld de, vBGMap1 + $300

.skip:
    ld a, [hl]
    cp a, $7F
    jr z, .check_is_cgb
    di

.loop:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop
    ld a, [hl+]
    ld [de], a
    ei
    inc de
    jr .skip

.check_is_cgb:
    ld a, [wIsCGB]
    and a, a
    jr z, .check_screen_step
    ld a, $01
    ldh [rVBK], a
    ld hl, vBGMap1 + $300
    ld b, $56

.loop2:
    di

.loop3:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop3
    xor a, a
    ld [hl+], a
    ld [hl+], a
    ei
    dec b
    jr nz, .loop2
    ld a, $00
    ldh [rVBK], a

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 1 of the `rst $00` table in ShopMenu_Buy; also entry 1 of the table in ShopMenu_Sell
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
ShopMenu_Buy_DrawRectBothBanksSetTextCursorLoPlus1C1::
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

; entry 2 of the `rst $00` table in ShopMenu_Buy
; no direct call (reached through a table, a jump or a vector)
; reads: wItemGridY, wSavedFieldDrawFlags, wDigits, wScreenStep, wItemGridX
; writes: wSavedSpriteClipMode, wSavedFieldDrawFlags, wItemGridY, wChoiceCursorF0, wScreenStep, wScreenCounter, wGlyphListPos, wItemGridX
ShopMenu_Buy_LoadArg1PointerForScreenTableIndex::
Jump_01C_490D:: ; address name
    call LoadArg1PointerForScreenTableIndex
    ld c, $00

.skip:
    ld a, [hl]
    cp a, $FF
    jr z, .set_saved_sprite_clip_mode
    inc hl
    inc c
    jr .skip

.set_saved_sprite_clip_mode:
    ld a, c
    ld [wSavedSpriteClipMode], a
    ld l, a
    ld h, $00
    ld a, $04
    call DivideHLByA
    push af
    and a, a
    jr z, .set_saved_field_draw_flags
    inc l

.set_saved_field_draw_flags:
    ld a, l
    ld [wSavedFieldDrawFlags], a
    ld a, [wItemGridY]
    inc a
    cp a, l
    jr c, .set_choice_cursor_f0_to_03
    pop af
    push af
    and a, a
    jr nz, .set_choice_cursor_f0
    ld a, [wItemGridY]
    inc a
    cp a, l
    jr z, .set_choice_cursor_f0_to_03
    ld a, [wItemGridY]
    dec a
    ld [wItemGridY], a
    jr .set_choice_cursor_f0_to_03

.set_choice_cursor_f0:
    pop af
    dec a
    ld [wChoiceCursorF0], a
    ld b, a
    ld a, [wItemGridX]
    cp a, b
    jr c, .check_saved_field_draw_flags
    jr z, .check_saved_field_draw_flags
    push bc
    push hl
    call EraseItemGridXCursor
    pop hl
    pop bc
    ld a, b
    ld [wItemGridX], a
    jr .check_saved_field_draw_flags

.set_choice_cursor_f0_to_03:
    pop af
    ld a, $03
    ld [wChoiceCursorF0], a

.check_saved_field_draw_flags:
    ld a, [wSavedFieldDrawFlags]
    cp a, $02
    jr c, .check_screen_step
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

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenCounter], a
    ld [wGlyphListPos], a
    ret

; entry 3 of the `rst $00` table in ShopMenu_Buy
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenCounter, wGlyphListPos, wItemGridY, wCursorBlinkB8, wScreenStep
; writes: wGlyphListPos, wCursorBlinkB8, wScreenCounter, wScreenStep
ShopMenu_Buy_WriteGlyphListPosAndCursorBlinkB8Etc::
Jump_01C_49BC:: ; address name
    ld a, [wScreenCounter]
    add a, a
    ld hl, TileDestTable_1C_6289
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]

.loop:
    push de
    ld a, [wGlyphListPos]
    add a, a
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
    ld de, Tiles2Plus710Tiles_1F_4910
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    cp a, $09
    jr c, .loop
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
    jp z, .clear_glyph_list_pos
    ld e, a
    ld d, $00
    sla e
    rl d
    ld hl, ItemNamesCopy_1C
    add hl, de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e

.skip2:
    ld a, [hl]
    cp a, $F0
    jp z, .clear_glyph_list_pos
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
    jr nc, .skip3
    inc d

.skip3:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [wCursorBlinkB8]
    cp a, $8D
    jr z, .check_glyph_list_pos
    cp a, $8E
    jr z, .check_glyph_list_pos
    jr .read_glyph_list_pos

.check_glyph_list_pos:
    ld a, [wGlyphListPos]
    dec a
    ld [wGlyphListPos], a

.read_glyph_list_pos:
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
    jr z, .call_or_from_bank_wait_vram
    cp a, $8E
    jr z, .call_or_from_bank_wait_vram
    call CopyFromBankWaitVRAM
    jr .check_glyph_list_pos2

.call_or_from_bank_wait_vram:
    call OrFromBankWaitVRAM

.check_glyph_list_pos2:
    pop hl
    inc hl
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    jp .skip2

.clear_glyph_list_pos:
    xor a, a
    ld [wGlyphListPos], a
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp a, $04
    jr c, .return
    xor a, a
    ld [wScreenCounter], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    ret

.return:
    ret

; entry 4 of the `rst $00` table in ShopMenu_Buy
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
ShopMenu_Buy_AdvanceScreenStep::
Jump_01C_4ABC:: ; address name
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in ShopMenu_Buy
; no direct call (reached through a table, a jump or a vector)
; reads: wItemGridY, wScreenCounter, wScreenByteEE, wScreenStep
; writes: wArg3, wArg4, wArg5, wArg6, wArg7, wArg8, wScreenByteEE, wScreenCounter, ...
; points at: wArg3
ShopMenu_Buy_LoadArg1PointerForScreenTableIndex_Case05::
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

.loop:
    push hl
    ld a, [wScreenCounter]
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jr nz, .skip
    ld a, $E3
    ld [wArg3], a
    ld [wArg4], a
    ld [wArg5], a
    ld [wArg6], a
    ld [wArg7], a
    ld [wArg8], a
    jr .read_screen_counter

.skip:
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
    call ShopMenu_Buy_ReadFarPointerAtDEInBankB
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

.read_screen_counter:
    ld hl, ShopMenu_Buy_LoadArg1PointerForScreenTableIndex_Case05_Data
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

.loop2:
    ld a, [wScreenByteEE]
    and a, a
    jr nz, .call_wait_for_vram_access
    push hl
    ld l, e
    ld h, d
    call StepBGMapAddressBackOnScrollWrap
    cp a, $FF
    jr nz, .skip2
    ld a, $01
    ld [wScreenByteEE], a

.skip2:
    ld e, l
    ld d, h
    pop hl

.call_wait_for_vram_access:
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
    jr c, .loop2
    xor a, a
    pop hl
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp a, $04
    jp c, .loop
    xor a, a
    ld [wScreenCounter], a
    ld [wGlyphListPos], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 6 of the `rst $00` table in ShopMenu_Buy
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wTextCounter0, wScreenStep, wChoiceCursorF0, wItemGridX, wSavedFieldDrawFlags, wItemGridY
; writes: wTextTimer, wScreenState, wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wItemGridX, wSelectedRecord, ...
ShopMenu_Buy_BlinkCursorSelectedRecord_Bank1C::
Jump_01C_4B95:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 4, a
    jr nz, .check_saved_field_draw_flags
    bit 5, a
    jr nz, .check_saved_field_draw_flags2
    bit 6, a
    jp nz, .check_choice_cursor_f0
    bit 7, a
    jp nz, .check_choice_cursor_f02
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, .call_draw_item_grid_x_cursor_confirmed
    call BlinkCursorSelectedRecord_Bank1C
    call ShopMenu_WriteTextCounter6AndTextTimerEtc
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

.check_saved_field_draw_flags:
    ld a, [wSavedFieldDrawFlags]
    cp a, $02
    jr c, .loop
    call EraseItemGridXCursor
    call ResetTextCounter0Counters
    ld a, [wSavedFieldDrawFlags]
    ld b, a
    ld a, [wItemGridY]
    inc a
    cp a, b
    jr c, .set_item_grid_y
    xor a, a

.set_item_grid_y:
    ld [wItemGridY], a
    ld a, $02
    ld [wScreenStep], a

.loop:
    xor a, a
    ld [wSelectedRecord], a
    call DrawItemGridXCursor
    ld a, $69
    call QueueSoundEffect
    ret

.check_saved_field_draw_flags2:
    ld a, [wSavedFieldDrawFlags]
    cp a, $02
    jr c, .loop
    call EraseItemGridXCursor
    call ResetTextCounter0Counters
    ld a, [wItemGridY]
    and a, a
    jr nz, .skip
    ld a, [wSavedFieldDrawFlags]
    dec a
    jp .set_item_grid_y

.skip:
    dec a
    jp .set_item_grid_y

.check_choice_cursor_f0:
    ld a, [wChoiceCursorF0]
    and a, a
    jr z, .loop2
    call ResetTextCounter0Counters
    call EraseItemGridXCursor
    ld a, [wItemGridX]
    and a, a
    jr nz, .set_item_grid_x
    ld a, [wChoiceCursorF0]
    jr .set_item_grid_x2

.set_item_grid_x:
    dec a

.set_item_grid_x2:
    ld [wItemGridX], a

.loop2:
    xor a, a
    ld [wSelectedRecord], a
    call DrawItemGridXCursor
    ld a, $69
    call QueueSoundEffect
    ret

.check_choice_cursor_f02:
    ld a, [wChoiceCursorF0]
    and a, a
    jr z, .loop2
    call ResetTextCounter0Counters
    call EraseItemGridXCursor
    ld a, [wChoiceCursorF0]
    ld b, a
    ld a, [wItemGridX]
    cp a, b
    jr c, .skip2
    xor a, a
    jr .set_item_grid_x2

.skip2:
    inc a
    jr .set_item_grid_x2

.call_draw_item_grid_x_cursor_confirmed:
    call DrawItemGridXCursorConfirmed
    ld a, $69
    call QueueSoundEffect
    call ResetTextCounter0Counters
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; cycles wSelectedRecord through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (cursor drawn by DrawItemGridXCursor / EraseItemGridXCursor) (E-0122)
; 2 call sites from 2 routines (e.g. ShopMenu_Buy_BlinkCursorSelectedRecord_Bank1C, ShopMenu_Sell_BlinkCursorSelectedRecord_Bank1C)
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

; writes the cursor tile $BB at the position for wItemGridX (0-3; BG map offsets $00A2, $00E2, $0122, $0162 from the scroll origin, Data_01C_4CC4), via StepBGMapAddressBackOnScrollWrap and WaitForVRAMAccess (E-0074)
; 4 call sites from 2 routines (e.g. ShopMenu_Buy_BlinkCursorSelectedRecord_Bank1C, ShopMenu_Sell_BlinkCursorSelectedRecord_Bank1C)
; reads: wItemGridX
DrawItemGridXCursor::
Func_01C_4C9A:: ; address name
    ld b, $BB
    jr DrawItemGridXCursorConfirmed_ReadItemGridX

; writes the blank tile $C3 at the position for wItemGridX (0-3; BG map offsets $00A2, $00E2, $0122, $0162 from the scroll origin, Data_01C_4CC4), via StepBGMapAddressBackOnScrollWrap and WaitForVRAMAccess (E-0074)
; 8 call sites from 4 routines (e.g. ShopMenu_Buy_BlinkCursorSelectedRecord_Bank1C, ShopMenu_Buy_LoadArg1PointerForScreenTableIndex, ShopMenu_Sell_BlinkCursorSelectedRecord_Bank1C, ShopMenu_Sell_ListDistinctInventoryItemsToItemGrid)
; reads: wItemGridX
EraseItemGridXCursor::
Func_01C_4C9E:: ; address name
    ld b, $C3
    jr DrawItemGridXCursorConfirmed_ReadItemGridX

; writes the confirmed-cursor tile $BC at the position for wItemGridX (0-3; BG map offsets $00A2, $00E2, $0122, $0162 from the scroll origin, Data_01C_4CC4), via StepBGMapAddressBackOnScrollWrap and WaitForVRAMAccess (E-0074)
; 2 call sites from 2 routines (e.g. ShopMenu_Buy_BlinkCursorSelectedRecord_Bank1C, ShopMenu_Sell_BlinkCursorSelectedRecord_Bank1C)
; reads: wItemGridX
DrawItemGridXCursorConfirmed::
Func_01C_4CA2:: ; address name
    ld b, $BC

DrawItemGridXCursorConfirmed_ReadItemGridX::
Jump_01C_4CA4:: ; address name
    ld a, [wItemGridX]
    add a, a
    ld hl, DrawItemGridXCursorConfirmed_Data
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
DrawItemGridXCursorConfirmed_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01C_4CC4:: ; address name
    db $A2, $00, $E2, $00, $22, $01, $62, $01

; entry 7 of the `rst $00` table in ShopMenu_Buy
; no direct call (reached through a table, a jump or a vector)
; reads: wListPages, wScreenStep
; writes: wTextTimer, wScreenState, wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wNumberTens, wNumberOnes, ...
ShopMenu_Buy_ResetTextCounter0Counters::
Jump_01C_4CCC:: ; address name
    call ResetTextCounter0Counters
    ld a, [wListPages]
    cp a, $18
    jr c, .check_screen_step
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

.check_screen_step:
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

; entry 8 of the `rst $00` table in ShopMenu_Buy
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wNumberTens, wNumberOnes, wScreenStep
; writes: wNumberTens, wNumberOnes, wScreenByte8D, wScreenCountPlusOne, wScreenStep
; points at: wScreenList
ShopMenu_Buy_StepBGMapAddressBackOnScrollWrap_Case08::
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

.loop:
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ld [de], a
    ei
    ld a, [wIsCGB]
    or a, a
    jr z, .next
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

.next:
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $04
    jp c, .loop
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
    jp c, .loop
    pop hl
    pop hl
    ld a, [wIsCGB]
    or a, a
    jr z, .skip
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

.skip:
    ld hl, wScreenList
    ld de, ShopMenu_Buy_StepBGMapAddressBackOnScrollWrap_Case08_Data
    ld bc, $000C

.loop2:
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, .loop2
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

; entry 9 of the `rst $00` table in ShopMenu_Buy
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wNumberTens, wNumberOnes, wScreenStep, wNumberEditPos
; writes: wTextTimer, wTwoChoiceCursor, wScreenStep, wScriptCommandType, wScriptStartRequest, wNumberTens, wNumberOnes, wNumberEditPos
ShopMenu_Buy_BlinkCursorBlinkCD_Bank1C_4F87::
Jump_01C_4DE0:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 1, a
    jr nz, .call_bg_map_address_at_scroll_bank1_c_67_af
    bit 4, a
    jr nz, .call_shop_menu_buy_case09_bg_map_address_at
    bit 5, a
    jr nz, .call_shop_menu_buy_case09_bg_map_address_at2
    bit 6, a
    jp nz, .call_queue_sound_effect
    bit 7, a
    jp nz, .call_queue_sound_effect2
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, .clear_text_timer
    call BlinkCursorBlinkCD_Bank1C_4F87
    ret

.call_bg_map_address_at_scroll_bank1_c_67_af:
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

.call_shop_menu_buy_case09_bg_map_address_at:
    call ShopMenu_Buy_Case09_BGMapAddressAtScroll_Bank1C_67AF
    ld a, [wNumberEditPos]
    cp a, $01
    jr nz, .set_number_edit_pos
    xor a, a
    jr .set_number_edit_pos2

.set_number_edit_pos:
    inc a

.set_number_edit_pos2:
    ld [wNumberEditPos], a
    call BlinkCursorBlinkCD_Bank1C_4F87
    ld a, $69
    call QueueSoundEffect
    ret

.call_shop_menu_buy_case09_bg_map_address_at2:
    call ShopMenu_Buy_Case09_BGMapAddressAtScroll_Bank1C_67AF
    ld a, [wNumberEditPos]
    and a, a
    jr nz, .skip
    ld a, $01
    jr .set_number_edit_pos2

.skip:
    dec a
    jr .set_number_edit_pos2

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    ld a, [wNumberEditPos]
    and a, a
    jr nz, .check_number_tens
    ld a, [wNumberTens]
    cp a, $02
    jr c, .set_number_tens
    ld a, $02
    ld [wNumberTens], a
    ld a, $04
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtTable5008
    ret

.loop:
    ld a, [wNumberOnes]
    cp a, $04
    jr c, .call_draw_number_tens_number_ones_digits_at
    ld a, $04
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtTable5008
    ret

.call_draw_number_tens_number_ones_digits_at:
    call DrawNumberTensNumberOnesDigitsAtTable5008
    ret

.set_number_tens:
    inc a
    ld [wNumberTens], a
    cp a, $02
    jp nc, .loop
    call BlinkCursorBlinkCD_Bank1C_4F87
    ret

.check_number_tens:
    ld a, [wNumberTens]
    cp a, $02
    jr c, .check_number_ones
    ld b, $04
    jr .check_number_ones2

.check_number_ones:
    ld b, $09

.check_number_ones2:
    ld a, [wNumberOnes]
    cp a, b
    jr c, .set_number_ones2
    ld a, b
    cp a, $04
    jr nz, .check_number_tens2
    call BlinkCursorBlinkCD_Bank1C_4F87
    ret

.check_number_tens2:
    ld a, [wNumberTens]
    and a, a
    jr nz, .clear_number_ones
    ld a, $01
    jr .set_number_ones

.clear_number_ones:
    xor a, a

.set_number_ones:
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1C_4F87
    ret

.set_number_ones2:
    inc a
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1C_4F87
    ret

.call_queue_sound_effect2:
    ld a, $69
    call QueueSoundEffect
    ld a, [wNumberEditPos]
    and a, a
    jr nz, .check_number_tens3
    ld a, [wNumberTens]
    and a, a
    jr nz, .set_number_tens2
    ld a, [wNumberOnes]
    cp a, $04
    jr c, .set_number_tens_to_02
    ld a, $02
    ld [wNumberTens], a
    ld a, $04
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtTable5008
    ret

.set_number_tens_to_02:
    ld a, $02
    ld [wNumberTens], a
    call BlinkCursorBlinkCD_Bank1C_4F87
    ret

.set_number_tens2:
    dec a
    ld [wNumberTens], a
    ld a, [wNumberTens]
    ld b, a
    ld a, [wNumberOnes]
    or a, b
    jr nz, .call_blink_cursor_blink_cd_bank1_c_4_f87
    ld a, $01
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtTable5008
    ret

.call_blink_cursor_blink_cd_bank1_c_4_f87:
    call BlinkCursorBlinkCD_Bank1C_4F87
    ret

.check_number_tens3:
    ld a, [wNumberTens]
    and a, a
    jr nz, .check_number_ones3
    ld a, [wNumberOnes]
    cp a, $01
    jr nz, .set_number_ones3
    jr .check_number_tens4

.check_number_ones3:
    ld a, [wNumberOnes]
    and a, a
    jr nz, .set_number_ones3

.check_number_tens4:
    ld a, [wNumberTens]
    cp a, $02
    jr c, .set_number_ones_to_09
    ld a, $02
    ld [wNumberTens], a
    ld a, $04
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtTable5008
    ret

.set_number_ones_to_09:
    ld a, $09
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1C_4F87
    ret

.set_number_ones3:
    dec a
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1C_4F87
    ret

.clear_text_timer:
    xor a, a
    ld [wTextTimer], a
    ld a, [wNumberTens]
    and a, a
    jr nz, .call_queue_sound_effect3
    ld a, [wNumberOnes]
    and a, a
    jr nz, .call_queue_sound_effect3
    call BlinkCursorBlinkCD_Bank1C_4F87
    ret

.call_queue_sound_effect3:
    ld a, $69
    call QueueSoundEffect
    call ShopMenu_Buy_Case09_BGMapAddressAtScroll_Bank1C_67AF
    call ShopMenu_Buy_Case09_WriteThreeDigits
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

; cycles wCursorBlinkCD through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (E-0122)
; 11 call sites from 1 routine (e.g. ShopMenu_Buy_BlinkCursorBlinkCD_Bank1C_4F87)
; reads: wCursorBlinkCD, wNumberEditPos, wNumberTens, wNumberOnes
; writes: wCursorBlinkCD
BlinkCursorBlinkCD_Bank1C_4F87::
Func_01C_4F87:: ; address name
    ld a, [wCursorBlinkCD]
    inc a
    ld [wCursorBlinkCD], a
    cp a, $10
    jr c, ShopMenu_Buy_Case09_BGMapAddressAtScroll_Bank1C_67AF
    cp a, $18
    jr c, ShopMenu_Buy_Case09_BGMapAddressAtScroll_Bank1C_67AF_Skip
    xor a, a
    ld [wCursorBlinkCD], a

; only called from ShopMenu_Buy_Case09 (E-0047)
; 3 call sites from 1 routine (e.g. ShopMenu_Buy_BlinkCursorBlinkCD_Bank1C_4F87)
; reads: wNumberEditPos, wNumberTens, wNumberOnes
ShopMenu_Buy_Case09_BGMapAddressAtScroll_Bank1C_67AF::
Func_01C_4F9A:: ; address name
    ld a, [wNumberEditPos]
    and a, a
    jr nz, .read_number_ones
    ld a, [wNumberTens]
    jr .skip

.read_number_ones:
    ld a, [wNumberOnes]

.skip:
    add a, $E0
    ld b, a
    jr ShopMenu_Buy_Case09_BGMapAddressAtScroll_Bank1C_67AF_ReadNumberEditPos

ShopMenu_Buy_Case09_BGMapAddressAtScroll_Bank1C_67AF_Skip::
Jump_01C_4FAD:: ; address name
    ld b, $CB

ShopMenu_Buy_Case09_BGMapAddressAtScroll_Bank1C_67AF_ReadNumberEditPos::
Jump_01C_4FAF:: ; address name
    ld a, [wNumberEditPos]
    add a, a
    ld hl, ShopMenu_Buy_Case09_BGMapAddressAtScroll_Bank1C_67AF_Data
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

; writes wNumberTens and wNumberOnes as digit tiles at the scroll offsets in Data_01C_5008 and Data_01C_500A (E-0121)
; 6 call sites from 1 routine (e.g. ShopMenu_Buy_BlinkCursorBlinkCD_Bank1C_4F87)
; reads: wNumberTens, wNumberOnes
DrawNumberTensNumberOnesDigitsAtTable5008::
Func_01C_4FCF:: ; address name
    ld hl, ShopMenu_Buy_Case09_BGMapAddressAtScroll_Bank1C_67AF_Data
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
    ld hl, DrawNumberTensNumberOnesDigitsAtTable5008_Data
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

; address loaded by ShopMenu_Buy_Case09_BGMapAddressAtScroll_Bank1C_67AF, DrawNumberTensNumberOnesDigitsAtTable5008, ShopMenu_Sell_Case08_BGMapAddressAtScroll_Bank1C_67AF, DrawNumberTensNumberOnesDigitsAtTable5008And5BE4
ShopMenu_Buy_Case09_BGMapAddressAtScroll_Bank1C_67AF_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01C_5008:: ; address name
    db $61, $01

; address loaded by DrawNumberTensNumberOnesDigitsAtTable5008
DrawNumberTensNumberOnesDigitsAtTable5008_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01C_500A:: ; address name
    db $62, $01

; only called from ShopMenu_Buy_Case09 (E-0047)
; 1 call site from 1 routine (e.g. ShopMenu_Buy_BlinkCursorBlinkCD_Bank1C_4F87)
; reads: wNumberTens, wNumberOnes, wItemGridY, wItemGridX
; writes: wThreeDigits
ShopMenu_Buy_Case09_WriteThreeDigits::
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
    jr nc, .call_load_arg1_pointer_for_screen_table_index
    inc d

.call_load_arg1_pointer_for_screen_table_index:
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
    call ShopMenu_Buy_ReadFarPointerAtDEInBankB
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

; entry 10 of the `rst $00` table in ShopMenu_Buy
; no direct call (reached through a table, a jump or a vector)
; reads: wItemGridY, wItemGridX, hTemp3, hTemp2, hTemp1, hTemp0, wScreenList, wListEntries, ...
; writes: wCursorBlinkB8, wDigits, wScreenList, wListEntries, wGrid2CursorX, wGrid2CursorY, wScreenArea, wScreenByte8D, ...
; points at: wTextBuf0, wThreeDigits, wScreenList
ShopMenu_Buy_LoadArg1PointerForScreenTableIndex_Case0A::
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
    jr nz, .restore
    ld a, $90
    ld [wScreenList], a
    ld a, [wListEntries]
    and a, a
    jr nz, .restore
    ld a, $90
    ld [wListEntries], a
    ld a, [wGrid2CursorX]
    and a, a
    jr nz, .restore
    ld a, $90
    ld [wGrid2CursorX], a
    ld a, [wGrid2CursorY]
    and a, a
    jr nz, .restore
    ld a, $90
    ld [wGrid2CursorY], a
    ld a, [wScreenArea]
    and a, a
    jr nz, .restore
    ld a, $90
    ld [wScreenArea], a
    ld a, [wScreenByte8D]
    and a, a
    jr nz, .restore
    ld a, $90
    ld [wScreenByte8D], a

.restore:
    pop de
    ld hl, wScreenList

.loop:
    ld a, [hl]
    cp a, $90
    jr nz, .skip
    inc c
    inc hl
    jr .loop

.skip:
    ld a, [hl+]
    ld [de], a
    inc de
    inc c
    ld a, c
    cp a, $07
    jr c, .loop
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

; entry 11 of the `rst $00` table in ShopMenu_Buy; also entry 10 of the table in ShopMenu_Sell
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
ShopMenu_Buy_StepBGMapAddressBackOnScrollWrap::
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

.loop:
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
    jp c, .loop
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
    jp c, .loop
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

; entry 12 of the `rst $00` table in ShopMenu_Buy
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wScreenStep, wScreenByteD1, wThreeDigits, wArg1, wNumberTens, wNumberOnes, ...
; writes: wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wArg3, wArg2, wArg1, wScreenByteD1
ShopMenu_Buy_BlinkCursorBlinkD2_Bank1C_52A0::
Jump_01C_51A7:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_draw_blank_tile_c3_52_be_bank1_c
    bit 7, a
    jr nz, .call_draw_blank_tile_c3_52_be_bank1_c2
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, .call_queue_sound_effect
    bit 1, a
    jp nz, .call_bg_map_address_at_scroll_bank1_c_67_af
    call BlinkCursorBlinkD2_Bank1C_52A0
    ret

.call_draw_blank_tile_c3_52_be_bank1_c:
    call DrawBlankTileC3_52BE_Bank1C
    ld a, [wScreenByteD1]
    and a, a
    jr nz, .set_screen_byte_d1
    ld a, $01
    jr .set_screen_byte_d12

.set_screen_byte_d1:
    dec a

.set_screen_byte_d12:
    ld [wScreenByteD1], a
    call BlinkCursorBlinkD2_Bank1C_52A0
    ld a, $69
    call QueueSoundEffect
    ret

.call_draw_blank_tile_c3_52_be_bank1_c2:
    call DrawBlankTileC3_52BE_Bank1C
    ld a, [wScreenByteD1]
    cp a, $01
    jr c, .skip
    xor a, a
    jr .set_screen_byte_d12

.skip:
    inc a
    jr .set_screen_byte_d12

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call ShopMenu_Buy_Case0C_StepBGMapAddressBackOnScrollWrap
    ld a, [wScreenByteD1]
    and a, a
    jr nz, .call_bg_map_address_at_scroll_bank1_c_67_af
    ld a, [wThreeDigits + $2]
    ld [wArg3], a
    ld a, [wThreeDigits + $1]
    ld [wArg2], a
    ld a, [wThreeDigits]
    ld [wArg1], a
    call IsAmountInArg1AboveGold
    ld a, [wArg1]
    cp a, $FF
    jp z, .clear_two_choice_cursor
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
    jr nc, .read_list_pages
    inc d

.read_list_pages:
    ld a, [wListPages]
    add a, e
    cp a, $19
    jr nc, .set_two_choice_cursor_to_01
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

.clear_two_choice_cursor:
    xor a, a
    ld [wTwoChoiceCursor], a
    jr .check_screen_step

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_bg_map_address_at_scroll_bank1_c_67_af:
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

; cycles wCursorBlinkD2 through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (after the joypad repeat timer reaches $14) (E-0122)
; 2 call sites from 1 routine (e.g. ShopMenu_Buy_BlinkCursorBlinkD2_Bank1C_52A0)
; reads: wJoypadRepeatTimer, wCursorBlinkD2, wScreenByteD1
; writes: wCursorBlinkD2
BlinkCursorBlinkD2_Bank1C_52A0::
Func_01C_52A0:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, .skip
    ld a, [wCursorBlinkD2]
    inc a
    ld [wCursorBlinkD2], a
    cp a, $10
    jr c, .skip
    cp a, $18
    jr c, DrawBlankTileC3_52BE_Bank1C
    xor a, a
    ld [wCursorBlinkD2], a

.skip:
    ld b, $BB
    jr ShopMenu_Buy_Case0C_StepBGMapAddressBackOnScrollWrap_ReadScreenByteD1

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. ShopMenu_Buy_BlinkCursorBlinkD2_Bank1C_52A0)
; reads: wScreenByteD1
DrawBlankTileC3_52BE_Bank1C::
Func_01C_52BE:: ; address name
    ld b, $C3
    jr ShopMenu_Buy_Case0C_StepBGMapAddressBackOnScrollWrap_ReadScreenByteD1

; only called from ShopMenu_Buy_Case0C (E-0047)
; 1 call site from 1 routine (e.g. ShopMenu_Buy_BlinkCursorBlinkD2_Bank1C_52A0)
; reads: wScreenByteD1
ShopMenu_Buy_Case0C_StepBGMapAddressBackOnScrollWrap::
Func_01C_52C2:: ; address name
    ld b, $BC

ShopMenu_Buy_Case0C_StepBGMapAddressBackOnScrollWrap_ReadScreenByteD1::
Jump_01C_52C4:: ; address name
    ld a, [wScreenByteD1]
    add a, a
    ld hl, ShopMenu_Buy_Case0C_StepBGMapAddressBackOnScrollWrap_Data
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

; address loaded by ShopMenu_Buy_Case0C_StepBGMapAddressBackOnScrollWrap
ShopMenu_Buy_Case0C_StepBGMapAddressBackOnScrollWrap_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01C_52E4:: ; address name
    db $2F, $01, $6F, $01

; clears two rectangles at scroll + $10E and + $140, wScreenStep = 6, clears wScriptCommandType and requests script $80 (E-0124)
; 1 call site from 1 routine (e.g. ShopMenu_Buy_DrawTwoBoxesAndRequestScript80)
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

; entry 15 of the `rst $00` table in ShopMenu_Buy
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep
ShopMenu_Buy_DrawTwoBoxesAndRequestScript80::
Jump_01C_5317:: ; address name
    call DrawTwoBoxesAndRequestScript80
    ld a, $10
    ld [wScreenStep], a
    ret

; entry 16 of the `rst $00` table in ShopMenu_Buy
; no direct call (reached through a table, a jump or a vector)
; reads: wItemGridY
; writes: wScreenStep, wItemGridX, wItemGridY
ShopMenu_Buy_StepBGMapAddressBackOnScrollWrap_Case10::
Jump_01C_5320:: ; address name
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $00A2
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld b, $04

.loop:
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
    jr nz, .loop
    ld a, [wItemGridY]
    and a, a
    jr nz, .clear_screen_step
    ld a, $06
    jr .set_screen_step

.clear_screen_step:
    xor a, a

.set_screen_step:
    ld [wScreenStep], a
    xor a, a
    ld [wItemGridX], a
    ld [wItemGridY], a
    ret

; entry 14 of the `rst $00` table in ShopMenu_Buy
; no direct call (reached through a table, a jump or a vector)
; reads: wThreeDigits, wNumberTens, wNumberOnes, wItemGridY, wItemGridX, wListPages, wScreenStep, wDigits, ...
; writes: wArg3, wArg2, wArg1, wCursorBlinkB8, wScreenState, wScreenStep, wItemGridX, wItemGridY, ...
; points at: wInventory, wScreenList, wScreenBlock92
ShopMenu_Buy_SubtractArg1AmountFromGold::
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
    jr nc, .call_load_arg1_pointer_for_screen_table_index
    inc d

.call_load_arg1_pointer_for_screen_table_index:
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

.loop:
    ld a, [hl]
    and a, a
    jr z, .read_cursor_blink_b8
    cp a, $FF
    jr z, .read_cursor_blink_b8
    inc hl
    inc b

.skip:
    ld a, b
    cp a, $18
    jr c, .loop
    jr .read_list_pages

.read_cursor_blink_b8:
    ld a, [wCursorBlinkB8]
    ld [hl], a
    inc hl
    inc b
    dec c
    ld a, c
    and a, a
    jr z, .read_list_pages
    jr .skip

.read_list_pages:
    pop de
    ld a, [wListPages]
    add a, e
    cp a, $18
    jr c, .check_screen_step
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

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld hl, wScreenList
    ld de, ShopMenu_Buy_SubtractArg1AmountFromGold_Data
    ld bc, $0020

.loop2:
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, .loop2
    ld hl, wScreenBlock92
    call DrawGoldDigitsAtHLWrapped_1C
    ld hl, wInventory
    ld c, $00
    ld b, $00

.loop3:
    ld a, [hl+]
    and a, a
    jr z, .next
    cp a, $FF
    jr z, .next
    inc b

.next:
    inc c
    ld a, c
    cp a, $18
    jr c, .loop3
    ld a, b
    ld [wListPages], a
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld a, [wDigits + $1]
    and a, a
    jr z, .read_digits
    ld a, [wDigits + $1]
    add a, $E0
    ld [wItemCountTens], a

.read_digits:
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

; selling: items from the inventory, priced by ComputeSellPrice, paid with AddArg1ToGoldCapped99999 (E-0276)
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
ShopMenu_Sell::
Jump_01C_5476:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw ShopMenu_Buy_WriteVBKAndScreenStep
    dw ShopMenu_Buy_DrawRectBothBanksSetTextCursorLoPlus1C1
    dw ShopMenu_Sell_ListDistinctInventoryItemsToItemGrid
    dw ShopMenu_Sell_WriteGlyphListPosAndCursorBlinkB8Etc
    dw ShopMenu_Sell_ComputeSellPrice
    dw ShopMenu_Sell_BlinkCursorSelectedRecord_Bank1C
    dw ShopMenu_Sell_ResetTextCounter0Counters
    dw ShopMenu_Sell_StepBGMapAddressBackOnScrollWrap
    dw ShopMenu_Sell_BlinkCursorBlinkCD_Bank1C_5B61
    dw ShopMenu_Sell_WriteCursorBlinkB8AndDigitsEtc
    dw ShopMenu_Buy_StepBGMapAddressBackOnScrollWrap
    dw ShopMenu_Sell_BlinkCursorBlinkD2_Bank1C_5DA4
    dw ShopMenu_Sell_ClearRectSetTextCursorLoPlus1C1_Bank1C
    dw ShopMenu_Sell_AddArg1ToGoldCapped99999

; entry 2 of the `rst $00` table in ShopMenu_Sell
; no direct call (reached through a table, a jump or a vector)
; reads: wItemGridY, wSavedSpriteSlotCount, wDigits, wScreenStep, wItemGridX
; writes: wListPages, wSavedSpriteSlotCount, wItemGridY, wChoiceCursorF0, wDigits, wScreenStep, wScreenCounter, wGlyphListPos, ...
; points at: wInventory, wItemGrid
ShopMenu_Sell_ListDistinctInventoryItemsToItemGrid::
Jump_01C_5496:: ; address name
    ld hl, wInventory
    ld b, $00
    ld c, $00

.loop:
    ld a, [hl]
    and a, a
    jr z, .next
    cp a, $FF
    jr z, .next
    inc c

.next:
    inc hl
    inc b
    ld a, b
    cp a, $18
    jr c, .loop
    ld a, c
    ld [wListPages], a
    call ListDistinctInventoryItemsToItemGrid
    ld hl, wItemGrid
    ld b, $00
    ld c, $00

.loop2:
    ld a, [hl]
    and a, a
    jr z, .next2
    inc c

.next2:
    inc hl
    inc b
    ld a, b
    cp a, $18
    jr c, .loop2
    ld a, c
    ld l, a
    ld h, $00
    ld a, $04
    call DivideHLByA
    push af
    and a, a
    jr z, .set_saved_sprite_slot_count
    inc l

.set_saved_sprite_slot_count:
    ld a, l
    ld [wSavedSpriteSlotCount], a
    ld a, [wItemGridY]
    inc a
    cp a, l
    jr c, .set_choice_cursor_f0_to_03
    pop af
    push af
    and a, a
    jr nz, .set_choice_cursor_f0
    ld a, [wItemGridY]
    inc a
    cp a, l
    jr z, .set_choice_cursor_f0_to_03
    ld a, [wItemGridY]
    dec a
    ld [wItemGridY], a
    jr .set_choice_cursor_f0_to_03

.set_choice_cursor_f0:
    pop af
    dec a
    ld [wChoiceCursorF0], a
    ld b, a
    ld a, [wItemGridX]
    cp a, b
    jr c, .check_saved_sprite_slot_count
    jr z, .check_saved_sprite_slot_count
    push bc
    push hl
    call EraseItemGridXCursor
    pop hl
    pop bc
    ld a, b
    ld [wItemGridX], a
    jr .check_saved_sprite_slot_count

.set_choice_cursor_f0_to_03:
    pop af
    ld a, $03
    ld [wChoiceCursorF0], a

.check_saved_sprite_slot_count:
    ld a, [wSavedSpriteSlotCount]
    cp a, $02
    jr c, .check_screen_step
    call DrawC5BEC6AtScroll18E_Bank1C
    call HLToDecimalDigits
    ld a, [wDigits + $1]
    and a, a
    jr nz, .call_bg_map_address_at_scroll_bank1_c_67_af
    ld a, $E3
    ld [wDigits + $1], a

.call_bg_map_address_at_scroll_bank1_c_67_af:
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

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a, a
    ld [wScreenCounter], a
    ld [wGlyphListPos], a
    ret

; entry 3 of the `rst $00` table in ShopMenu_Sell
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenCounter, wGlyphListPos, wItemGridY, wCursorBlinkB8, wScreenStep
; writes: wGlyphListPos, wCursorBlinkB8, wScreenCounter, wScreenStep
; points at: wItemGrid
ShopMenu_Sell_WriteGlyphListPosAndCursorBlinkB8Etc::
Jump_01C_5570:: ; address name
    ld a, [wScreenCounter]
    add a, a
    ld hl, TileDestTable_1C_6289
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]

.loop:
    push de
    ld a, [wGlyphListPos]
    add a, a
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
    ld de, Tiles2Plus710Tiles_1F_4910
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    cp a, $09
    jr c, .loop
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
    ld hl, ItemNamesCopy_1C
    add hl, de
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e

.skip2:
    ld a, [hl]
    cp a, $F0
    jp z, .clear_glyph_list_pos
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
    jr nc, .skip3
    inc d

.skip3:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [wCursorBlinkB8]
    cp a, $8D
    jr z, .check_glyph_list_pos
    cp a, $8E
    jr z, .check_glyph_list_pos
    jr .read_glyph_list_pos

.check_glyph_list_pos:
    ld a, [wGlyphListPos]
    dec a
    ld [wGlyphListPos], a

.read_glyph_list_pos:
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
    jr z, .call_or_from_bank_wait_vram
    cp a, $8E
    jr z, .call_or_from_bank_wait_vram
    call CopyFromBankWaitVRAM
    jr .check_glyph_list_pos2

.call_or_from_bank_wait_vram:
    call OrFromBankWaitVRAM

.check_glyph_list_pos2:
    pop hl
    inc hl
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    jp .skip2

.clear_glyph_list_pos:
    xor a, a
    ld [wGlyphListPos], a
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp a, $04
    jr c, .return
    xor a, a
    ld [wScreenCounter], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.return:
    ret

; entry 4 of the `rst $00` table in ShopMenu_Sell
; no direct call (reached through a table, a jump or a vector)
; reads: wItemGridY, wScreenCounter, hTemp1, hTemp0, wScreenByteBD, wListEntries2, wScreenByteBF, wScreenByteC0, ...
; writes: wDigits, wScreenByteBD, wListEntries2, wScreenByteBF, wScreenByteC0, wScreenByteC1, wScreenByteEE, wScreenCounter, ...
; points at: wItemGrid, wScreenByteBD
ShopMenu_Sell_ComputeSellPrice::
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

.loop:
    push hl
    ld a, [wScreenCounter]
    add_a_to_hl
    ld a, [hl]
    ld e, a
    ld d, $00
    sla e
    rl d
    call ComputeSellPrice
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
    jr nz, .set_screen_byte_c1_to_DF
    add a, $E3
    ld [wScreenByteBD], a
    ld a, [wListEntries2]
    and a, a
    jr nz, .set_screen_byte_c1_to_DF
    add a, $E3
    ld [wListEntries2], a
    ld a, [wScreenByteBF]
    and a, a
    jr nz, .set_screen_byte_c1_to_DF
    add a, $E3
    ld [wScreenByteBF], a
    ld a, [wScreenByteC0]
    and a, a
    jr nz, .set_screen_byte_c1_to_DF
    add a, $E3
    ld [wScreenByteC0], a
    ld a, $E3
    ld [wScreenByteC1], a
    jr .read_screen_counter

.set_screen_byte_c1_to_DF:
    ld a, $DF
    ld [wScreenByteC1], a

.read_screen_counter:
    ld hl, ShopMenu_Buy_LoadArg1PointerForScreenTableIndex_Case05_Data
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

.loop2:
    ld a, [wScreenByteEE]
    and a, a
    jr nz, .call_wait_for_vram_access
    push hl
    ld l, e
    ld h, d
    call StepBGMapAddressBackOnScrollWrap
    cp a, $FF
    jr nz, .skip
    ld a, $01
    ld [wScreenByteEE], a

.skip:
    ld e, l
    ld d, h
    pop hl

.call_wait_for_vram_access:
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
    jr c, .loop2
    pop hl
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp a, $04
    jp c, .loop
    xor a, a
    ld [wScreenCounter], a
    ld [wGlyphListPos], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 5 of the `rst $00` table in ShopMenu_Sell
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wTextCounter0, wScreenStep, wChoiceCursorF0, wItemGridX, wSavedSpriteSlotCount, wItemGridY
; writes: wTextTimer, wScreenState, wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wSelectedRecord, wItemGridX, ...
ShopMenu_Sell_BlinkCursorSelectedRecord_Bank1C::
Jump_01C_575B:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 4, a
    jr nz, .check_saved_sprite_slot_count
    bit 5, a
    jr nz, .check_saved_sprite_slot_count2
    bit 6, a
    jp nz, .clear_selected_record
    bit 7, a
    jp nz, .clear_selected_record2
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, .call_queue_sound_effect
    call BlinkCursorSelectedRecord_Bank1C
    call ShopMenu_WriteTextCounter6AndTextTimerEtc
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

.check_saved_sprite_slot_count:
    ld a, [wSavedSpriteSlotCount]
    cp a, $02
    jr c, .loop
    call ResetTextCounter0Counters
    ld a, [wSavedSpriteSlotCount]
    ld b, a
    ld a, [wItemGridY]
    inc a
    cp a, b
    jr c, .set_item_grid_y
    xor a, a

.set_item_grid_y:
    ld [wItemGridY], a
    ld a, $02
    ld [wScreenStep], a

.loop:
    xor a, a
    ld [wSelectedRecord], a
    call DrawItemGridXCursor
    ld a, $69
    call QueueSoundEffect
    ret

.check_saved_sprite_slot_count2:
    ld a, [wSavedSpriteSlotCount]
    cp a, $02
    jr c, .loop
    call ResetTextCounter0Counters
    ld a, [wItemGridY]
    and a, a
    jr nz, .skip
    ld a, [wSavedSpriteSlotCount]
    dec a
    jp .set_item_grid_y

.skip:
    dec a
    jp .set_item_grid_y

.clear_selected_record:
    xor a, a
    ld [wSelectedRecord], a
    ld a, [wChoiceCursorF0]
    and a, a
    jr z, .loop2
    call ResetTextCounter0Counters
    call EraseItemGridXCursor
    ld a, [wItemGridX]
    and a, a
    jr nz, .set_item_grid_x
    ld a, [wChoiceCursorF0]
    jr .set_item_grid_x2

.set_item_grid_x:
    dec a

.set_item_grid_x2:
    ld [wItemGridX], a

.loop2:
    xor a, a
    ld [wSelectedRecord], a
    call DrawItemGridXCursor
    ld a, $69
    call QueueSoundEffect
    ret

.clear_selected_record2:
    xor a, a
    ld [wSelectedRecord], a
    ld a, [wChoiceCursorF0]
    and a, a
    jr z, .loop2
    call ResetTextCounter0Counters
    call EraseItemGridXCursor
    ld a, [wChoiceCursorF0]
    ld b, a
    ld a, [wItemGridX]
    cp a, b
    jr c, .skip2
    xor a, a
    jr .set_item_grid_x2

.skip2:
    inc a
    jr .set_item_grid_x2

.call_queue_sound_effect:
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

; entry 6 of the `rst $00` table in ShopMenu_Sell
; no direct call (reached through a table, a jump or a vector)
; reads: wItemGridY, wItemGridX, wScreenStep
; writes: wScreenStep, wTextTimer, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wCursorBlinkCD, wNumberTens, wNumberOnes, ...
; points at: wItemGrid
ShopMenu_Sell_ResetTextCounter0Counters::
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
    call ComputeSellPrice
    ld a, l
    and a, a
    jr nz, .check_screen_step
    ld a, h
    and a, a
    jr nz, .check_screen_step
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

.check_screen_step:
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

; entry 7 of the `rst $00` table in ShopMenu_Sell
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB, wNumberTens, wNumberOnes, wCountTens, wCountOnes, wScreenStep
; writes: wNumberTens, wNumberOnes, wScreenByte90, wScreenByte91, wScreenByte93, wScreenByte94, wScreenStep
; points at: wScreenList
ShopMenu_Sell_StepBGMapAddressBackOnScrollWrap::
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

.loop:
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ld [de], a
    ei
    ld a, [wIsCGB]
    or a, a
    jr z, .next
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

.next:
    inc hl
    inc de
    inc c
    ld a, c
    cp a, $07
    jp c, .loop
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
    jp c, .loop
    pop hl
    pop hl
    ld a, [wIsCGB]
    or a, a
    jr z, .skip
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

.skip:
    ld hl, wScreenList
    ld de, ShopMenu_Sell_StepBGMapAddressBackOnScrollWrap_Data
    ld bc, $0015

.loop2:
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, .loop2
    ld a, [wNumberTens]
    add a, $E0
    ld [wScreenByte90], a
    ld a, [wNumberOnes]
    add a, $E0
    ld [wScreenByte91], a
    call CountItemInInventoryToDigits
    ld a, [wCountTens]
    and a, a
    jr nz, .read_count_tens
    ld a, $C3
    ld [wScreenByte93], a
    jr .read_count_ones

.read_count_tens:
    ld a, [wCountTens]
    add a, $E0
    ld [wScreenByte93], a

.read_count_ones:
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

; entry 8 of the `rst $00` table in ShopMenu_Sell
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wNumberTens, wNumberOnes, wScreenStep, wNumberEditPos, wCountOnes, wCountTens
; writes: wTwoChoiceCursor, wTextTimer, wScreenStep, wNumberTens, wNumberOnes, wNumberEditPos, wScriptCommandType, wScriptStartRequest
ShopMenu_Sell_BlinkCursorBlinkCD_Bank1C_5B61::
Jump_01C_59AD:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 1, a
    jr nz, .call_bg_map_address_at_scroll_bank1_c_67_af
    bit 4, a
    jr nz, .call_shop_menu_sell_case08_bg_map_address_at
    bit 5, a
    jr nz, .call_shop_menu_sell_case08_bg_map_address_at2
    bit 6, a
    jp nz, .call_queue_sound_effect
    bit 7, a
    jp nz, .call_queue_sound_effect2
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, .check_number_tens3
    call BlinkCursorBlinkCD_Bank1C_5B61
    ret

.call_bg_map_address_at_scroll_bank1_c_67_af:
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

.call_shop_menu_sell_case08_bg_map_address_at:
    call ShopMenu_Sell_Case08_BGMapAddressAtScroll_Bank1C_67AF
    ld a, [wNumberEditPos]
    cp a, $01
    jr nz, .set_number_edit_pos
    xor a, a
    jr .set_number_edit_pos2

.set_number_edit_pos:
    inc a

.set_number_edit_pos2:
    ld [wNumberEditPos], a
    call BlinkCursorBlinkCD_Bank1C_5B61
    ret

.call_shop_menu_sell_case08_bg_map_address_at2:
    call ShopMenu_Sell_Case08_BGMapAddressAtScroll_Bank1C_67AF
    ld a, [wNumberEditPos]
    and a, a
    jr nz, .skip
    ld a, $01
    jr .set_number_edit_pos2

.skip:
    dec a
    jr .set_number_edit_pos2

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    ld a, [wNumberEditPos]
    and a, a
    jr nz, .read_count_tens
    ld a, [wCountTens]
    ld b, a
    ld a, [wNumberTens]
    cp a, b
    jr c, .set_number_tens
    ld a, b
    ld [wNumberTens], a
    ld a, [wCountOnes]
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtTable5008And5BE4
    ret

.loop:
    ld a, [wCountOnes]
    ld b, a
    ld a, [wNumberOnes]
    cp a, b
    jr c, .call_draw_number_tens_number_ones_digits_at
    ld a, b
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtTable5008And5BE4
    ret

.call_draw_number_tens_number_ones_digits_at:
    call DrawNumberTensNumberOnesDigitsAtTable5008And5BE4
    ret

.set_number_tens:
    inc a
    ld [wNumberTens], a
    push af
    ld a, [wCountTens]
    ld b, a
    pop af
    cp a, b
    jp nc, .loop
    call BlinkCursorBlinkCD_Bank1C_5B61
    ret

.read_count_tens:
    ld a, [wCountTens]
    ld b, a
    ld a, [wNumberTens]
    cp a, b
    jr c, .check_number_ones
    ld a, [wCountOnes]
    ld b, a
    jr .check_number_ones2

.check_number_ones:
    ld b, $09

.check_number_ones2:
    ld a, [wNumberOnes]
    cp a, b
    jr c, .set_number_ones2
    ld a, [wCountOnes]
    cp a, b
    jr nz, .check_number_tens
    call BlinkCursorBlinkCD_Bank1C_5B61
    ret

.check_number_tens:
    ld a, [wNumberTens]
    and a, a
    jr nz, .clear_number_ones
    ld a, $01
    jr .set_number_ones

.clear_number_ones:
    xor a, a

.set_number_ones:
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1C_5B61
    ret

.set_number_ones2:
    inc a
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1C_5B61
    ret

.call_queue_sound_effect2:
    ld a, $69
    call QueueSoundEffect
    ld a, [wNumberEditPos]
    and a, a
    jr nz, .check_number_tens2
    ld a, [wNumberTens]
    and a, a
    jr nz, .set_number_tens2
    ld a, [wCountOnes]
    ld b, a
    ld a, [wNumberOnes]
    cp a, b
    jr c, .read_count_tens2
    ld a, [wCountTens]
    ld [wNumberTens], a
    ld a, [wCountOnes]
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtTable5008And5BE4
    ret

.read_count_tens2:
    ld a, [wCountTens]
    ld [wNumberTens], a
    call BlinkCursorBlinkCD_Bank1C_5B61
    ret

.set_number_tens2:
    dec a
    ld [wNumberTens], a
    ld a, [wNumberTens]
    ld b, a
    ld a, [wNumberOnes]
    or a, b
    jr nz, .call_blink_cursor_blink_cd_bank1_c_5_b61
    ld a, $01
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtTable5008And5BE4
    ret

.call_blink_cursor_blink_cd_bank1_c_5_b61:
    call BlinkCursorBlinkCD_Bank1C_5B61
    ret

.check_number_tens2:
    ld a, [wNumberTens]
    and a, a
    jr nz, .check_number_ones3
    ld a, [wNumberOnes]
    cp a, $01
    jr nz, .set_number_ones3
    jr .read_count_tens3

.check_number_ones3:
    ld a, [wNumberOnes]
    and a, a
    jr nz, .set_number_ones3

.read_count_tens3:
    ld a, [wCountTens]
    ld b, a
    ld a, [wNumberTens]
    cp a, b
    jr c, .set_number_ones_to_09
    ld a, [wCountTens]
    ld [wNumberTens], a
    ld a, [wCountOnes]
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtTable5008And5BE4
    ret

.set_number_ones_to_09:
    ld a, $09
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1C_5B61
    ret

.set_number_ones3:
    dec a
    ld [wNumberOnes], a
    call BlinkCursorBlinkCD_Bank1C_5B61
    ret

.check_number_tens3:
    ld a, [wNumberTens]
    and a, a
    jr nz, .call_queue_sound_effect3
    ld a, [wNumberOnes]
    and a, a
    jr nz, .call_queue_sound_effect3
    call ShopMenu_Sell_Case08_BGMapAddressAtScroll_Bank1C_67AF
    ret

.call_queue_sound_effect3:
    ld a, $69
    call QueueSoundEffect
    call ShopMenu_Sell_Case08_BGMapAddressAtScroll_Bank1C_67AF
    call ShopMenu_Sell_Case08_WriteThreeDigits
    xor a, a
    ld [wTwoChoiceCursor], a
    xor a, a
    ld [wTextTimer], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; cycles wCursorBlinkCD through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (E-0122)
; 10 call sites from 1 routine (e.g. ShopMenu_Sell_BlinkCursorBlinkCD_Bank1C_5B61)
; reads: wCursorBlinkCD, wNumberEditPos, wNumberTens, wNumberOnes
; writes: wCursorBlinkCD
BlinkCursorBlinkCD_Bank1C_5B61::
Func_01C_5B61:: ; address name
    ld a, [wCursorBlinkCD]
    inc a
    ld [wCursorBlinkCD], a
    cp a, $10
    jr c, ShopMenu_Sell_Case08_BGMapAddressAtScroll_Bank1C_67AF
    cp a, $18
    jr c, ShopMenu_Sell_Case08_BGMapAddressAtScroll_Bank1C_67AF_Skip
    xor a, a
    ld [wCursorBlinkCD], a

; only called from ShopMenu_Sell_Case08 (E-0047)
; 4 call sites from 1 routine (e.g. ShopMenu_Sell_BlinkCursorBlinkCD_Bank1C_5B61)
; reads: wNumberEditPos, wNumberTens, wNumberOnes
ShopMenu_Sell_Case08_BGMapAddressAtScroll_Bank1C_67AF::
Func_01C_5B74:: ; address name
    ld a, [wNumberEditPos]
    and a, a
    jr nz, .read_number_ones
    ld a, [wNumberTens]
    jr .skip

.read_number_ones:
    ld a, [wNumberOnes]

.skip:
    add a, $E0
    ld b, a
    jr ShopMenu_Sell_Case08_BGMapAddressAtScroll_Bank1C_67AF_ReadNumberEditPos

ShopMenu_Sell_Case08_BGMapAddressAtScroll_Bank1C_67AF_Skip::
Jump_01C_5B87:: ; address name
    ld b, $CB

ShopMenu_Sell_Case08_BGMapAddressAtScroll_Bank1C_67AF_ReadNumberEditPos::
Jump_01C_5B89:: ; address name
    ld a, [wNumberEditPos]
    add a, a
    ld hl, ShopMenu_Buy_Case09_BGMapAddressAtScroll_Bank1C_67AF_Data
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

; writes wNumberTens and wNumberOnes as digit tiles at the scroll offsets in Data_01C_5008 and Data_01C_5BE4 (E-0121)
; 6 call sites from 1 routine (e.g. ShopMenu_Sell_BlinkCursorBlinkCD_Bank1C_5B61)
; reads: wNumberTens, wNumberOnes
DrawNumberTensNumberOnesDigitsAtTable5008And5BE4::
Func_01C_5BA9:: ; address name
    ld hl, ShopMenu_Buy_Case09_BGMapAddressAtScroll_Bank1C_67AF_Data
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
    ld hl, DrawNumberTensNumberOnesDigitsAtTable5008And5BE4_Data
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
DrawNumberTensNumberOnesDigitsAtTable5008And5BE4_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01C_5BE4:: ; address name
    db $62, $01

; only called from ShopMenu_Sell_Case08 (E-0047)
; 1 call site from 1 routine (e.g. ShopMenu_Sell_BlinkCursorBlinkCD_Bank1C_5B61)
; reads: wNumberTens, wNumberOnes, wItemGridY, wItemGridX
; writes: wThreeDigits
; points at: wItemGrid
ShopMenu_Sell_Case08_WriteThreeDigits::
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
    jr nc, .read_item_grid_y
    inc d

.read_item_grid_y:
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
    call ComputeSellPrice
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

; entry 9 of the `rst $00` table in ShopMenu_Sell
; no direct call (reached through a table, a jump or a vector)
; reads: wItemGridY, wItemGridX, hTemp2, hTemp1, hTemp0, wScreenList, wListEntries, wGrid2CursorX, ...
; writes: wCursorBlinkB8, wDigits, wScreenList, wListEntries, wGrid2CursorX, wGrid2CursorY, wScreenArea, wScreenByte8D, ...
; points at: wItemGrid, wTextBuf0, wThreeDigits, wScreenList
ShopMenu_Sell_WriteCursorBlinkB8AndDigitsEtc::
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
    jr nz, .restore
    ld a, $90
    ld [wScreenList], a
    ld a, [wListEntries]
    and a, a
    jr nz, .restore
    ld a, $90
    ld [wListEntries], a
    ld a, [wGrid2CursorX]
    and a, a
    jr nz, .restore
    ld a, $90
    ld [wGrid2CursorX], a
    ld a, [wGrid2CursorY]
    and a, a
    jr nz, .restore
    ld a, $90
    ld [wGrid2CursorY], a
    ld a, [wScreenArea]
    and a, a
    jr nz, .restore
    ld a, $90
    ld [wScreenArea], a

.restore:
    pop de
    ld hl, wScreenList
    ld c, $00

.loop:
    ld a, [hl]
    cp a, $90
    jr nz, .skip
    inc c
    inc hl
    jr .loop

.skip:
    ld a, [hl+]
    ld [de], a
    inc de
    inc c
    ld a, c
    cp a, $06
    jr c, .loop
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

; entry 11 of the `rst $00` table in ShopMenu_Sell
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wJoypadPressed, wScreenStep, wScreenByteD1
; writes: wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wScreenByteD1
ShopMenu_Sell_BlinkCursorBlinkD2_Bank1C_5DA4::
Jump_01C_5D13:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_draw_blank_tile_c3_5_dc2_bank1_c
    bit 7, a
    jr nz, .call_draw_blank_tile_c3_5_dc2_bank1_c2
    ld a, [wJoypadPressed]
    bit 0, a
    jp nz, .call_queue_sound_effect
    bit 1, a
    jp nz, .call_bg_map_address_at_scroll_bank1_c_67_af
    call BlinkCursorBlinkD2_Bank1C_5DA4
    ret

.call_draw_blank_tile_c3_5_dc2_bank1_c:
    call DrawBlankTileC3_5DC2_Bank1C
    ld a, [wScreenByteD1]
    and a, a
    jr nz, .set_screen_byte_d1
    ld a, $01
    jr .set_screen_byte_d12

.set_screen_byte_d1:
    dec a

.set_screen_byte_d12:
    ld [wScreenByteD1], a
    call BlinkCursorBlinkD2_Bank1C_5DA4
    ld a, $69
    call QueueSoundEffect
    ret

.call_draw_blank_tile_c3_5_dc2_bank1_c2:
    call DrawBlankTileC3_5DC2_Bank1C
    ld a, [wScreenByteD1]
    cp a, $01
    jr c, .skip
    xor a, a
    jr .set_screen_byte_d12

.skip:
    inc a
    jr .set_screen_byte_d12

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call ShopMenu_Sell_Case0B_StepBGMapAddressBackOnScrollWrap
    ld a, [wScreenByteD1]
    and a, a
    jr nz, .call_bg_map_address_at_scroll_bank1_c_67_af
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

.call_bg_map_address_at_scroll_bank1_c_67_af:
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

; cycles wCursorBlinkD2 through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for $10-$17 (after the joypad repeat timer reaches $14) (E-0122)
; 2 call sites from 1 routine (e.g. ShopMenu_Sell_BlinkCursorBlinkD2_Bank1C_5DA4)
; reads: wJoypadRepeatTimer, wCursorBlinkD2, wScreenByteD1
; writes: wCursorBlinkD2
BlinkCursorBlinkD2_Bank1C_5DA4::
Func_01C_5DA4:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, .skip
    ld a, [wCursorBlinkD2]
    inc a
    ld [wCursorBlinkD2], a
    cp a, $10
    jr c, .skip
    cp a, $18
    jr c, DrawBlankTileC3_5DC2_Bank1C
    xor a, a
    ld [wCursorBlinkD2], a

.skip:
    ld b, $BB
    jr ShopMenu_Sell_Case0B_StepBGMapAddressBackOnScrollWrap_ReadScreenByteD1

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
; 2 call sites from 1 routine (e.g. ShopMenu_Sell_BlinkCursorBlinkD2_Bank1C_5DA4)
; reads: wScreenByteD1
DrawBlankTileC3_5DC2_Bank1C::
Func_01C_5DC2:: ; address name
    ld b, $C3
    jr ShopMenu_Sell_Case0B_StepBGMapAddressBackOnScrollWrap_ReadScreenByteD1

; only called from ShopMenu_Sell_Case0B (E-0047)
; 1 call site from 1 routine (e.g. ShopMenu_Sell_BlinkCursorBlinkD2_Bank1C_5DA4)
; reads: wScreenByteD1
ShopMenu_Sell_Case0B_StepBGMapAddressBackOnScrollWrap::
Func_01C_5DC6:: ; address name
    ld b, $BC

ShopMenu_Sell_Case0B_StepBGMapAddressBackOnScrollWrap_ReadScreenByteD1::
Jump_01C_5DC8:: ; address name
    ld a, [wScreenByteD1]
    add a, a
    ld hl, ShopMenu_Sell_Case0B_StepBGMapAddressBackOnScrollWrap_Data
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

; address loaded by ShopMenu_Sell_Case0B_StepBGMapAddressBackOnScrollWrap
ShopMenu_Sell_Case0B_StepBGMapAddressBackOnScrollWrap_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01C_5DE8:: ; address name
    db $2F, $01, $6F, $01

; entry 12 of the `rst $00` table in ShopMenu_Sell
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
ShopMenu_Sell_ClearRectSetTextCursorLoPlus1C1_Bank1C::
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

; entry 13 of the `rst $00` table in ShopMenu_Sell
; no direct call (reached through a table, a jump or a vector)
; reads: wThreeDigits, wScreenStep, wDigits
; writes: wArg3, wArg2, wArg1, wListPages, wScreenState, wScreenStep, wTwoChoiceCursor, wItemGridX, ...
; points at: wInventory, wScreenList, wScreenBlock92
ShopMenu_Sell_AddArg1ToGoldCapped99999::
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

.loop:
    ld a, [hl]
    and a, a
    jr z, .next
    cp a, $FF
    jr z, .next
    inc c

.next:
    inc hl
    inc b
    ld a, b
    cp a, $18
    jr c, .loop
    ld a, c
    ld [wListPages], a
    and a, a
    jr nz, .check_screen_step
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

.check_screen_step:
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld hl, wScreenList
    ld de, ShopMenu_Buy_SubtractArg1AmountFromGold_Data
    ld bc, $0020

.loop2:
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, .loop2
    ld hl, wScreenBlock92
    call DrawGoldDigitsAtHLWrapped_1C
    ld hl, wInventory
    ld c, $00
    ld b, $00

.loop3:
    ld a, [hl+]
    and a, a
    jr z, .next2
    cp a, $FF
    jr z, .next2
    inc b

.next2:
    inc c
    ld a, c
    cp a, $18
    jr c, .loop3
    ld a, b
    ld [wListPages], a
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld a, [wDigits + $1]
    and a, a
    jr z, .read_digits
    ld a, [wDigits + $1]
    add a, $E0
    ld [wItemCountTens], a

.read_digits:
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

; only called from routines of ShopMenu_Buy (E-0098)
; 2 call sites from 2 routines (e.g. ShopMenu_Buy_Case09_WriteThreeDigits, ShopMenu_Buy_LoadArg1PointerForScreenTableIndex_Case05)
; points at: wInventory, wArg1
ShopMenu_Buy_ReadFarPointerAtDEInBankB::
Func_01C_5EEC:: ; address name
    push hl
    ld hl, wInventory
    ld b, $18

.loop:
    ld a, [hl]
    and a, a
    jr z, .next
    cp a, $2D
    jr z, .restore

.next:
    inc hl
    dec b
    jr nz, .loop
    jr .done

.restore:
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

.done:
    pop hl
    ret

; HL and B = the 3-byte far pointer entry wScreenTableIndex of Data_0F2_5643 in bank $F2 (ReadFarPointerAtDEInBankB); DE kept (E-0118)
; 2 call sites from 2 routines (e.g. ShopMenu_Buy_Case09_WriteThreeDigits, ShopMenu_Buy_LoadArg1PointerForScreenTableIndex_Case05)
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

; BC = the ItemValueTable word at DE (DE = 2 * item) times ShopPercentTable[wScreenTableIndex], divided by 100 (E-0237, E-0276) (C2 from E-0327: the sell list shows Herb 7G, LoveWater 37G, WorldDew 375G and Potion 150G for values 10, 50, 500 and 200 at 75%)
; 3 call sites from 3 routines (e.g. ShopMenu_Sell_Case08_WriteThreeDigits, ShopMenu_Sell_ResetTextCounter0Counters, ShopMenu_Sell_ComputeSellPrice)
; reads: wScreenTableIndex
ComputeSellPrice::
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

; address loaded by ShopMenu_Buy_SubtractArg1AmountFromGold, ShopMenu_Sell_AddArg1ToGoldCapped99999, InitItemListScreenListAndCount, VaultMenu_Store_DrawGoldDigitsAtHLWrapped_1C and 1 more
ShopMenu_Buy_SubtractArg1AmountFromGold_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01C_5F5E:: ; address name
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

; address loaded by ShopMenu_Buy_WriteVBKAndScreenStep
ShopMenu_Buy_WriteVBKAndScreenStep_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01C_60AC:: ; address name
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

; address loaded by ShopMenu_Buy_LoadArg1PointerForScreenTableIndex_Case05, ShopMenu_Sell_ComputeSellPrice
ShopMenu_Buy_LoadArg1PointerForScreenTableIndex_Case05_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01C_62D9:: ; address name
    db $AE, $00, $EE, $00, $2E, $01, $6E, $01

; address loaded by ShopMenu_Buy_StepBGMapAddressBackOnScrollWrap_Case08
ShopMenu_Buy_StepBGMapAddressBackOnScrollWrap_Case08_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01C_62E1:: ; address name
    db $B0, $B1, $B1, $B2, $B6, $C3, $C3, $B7, $B3, $B4, $B4, $B5

; address loaded by ShopMenu_Sell_StepBGMapAddressBackOnScrollWrap
ShopMenu_Sell_StepBGMapAddressBackOnScrollWrap_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01C_62ED:: ; address name
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

; E-0237 (C1: ShopMenu_Shared03 reads the byte at $6320 + wScreenTableIndex, multiplies the ItemValueTable word by it (Multiply8By16) and divides by 100 (Divide24ByA); values 75 and 80, one 0). C2 from E-0327: the sell price, by the shop's index (GreatLog's merchant sets 0, 75%); the buy price is the ItemValueTable word itself.
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

; E-0237 (C1: ShopMenu_Shared03 reads the word at $6338 + DE, where its three callers pass DE = 2 * a byte of wItemGrid; the word is scaled by ShopPercentTable; 99 words up to the table at $63FE). C2 from E-0327: the value of each item id: a shop buys at it (Herb 10G, LoveWater 50G, Antidote 4G) and sells at value * ShopPercentTable / 100 (Herb 7G, LoveWater 37G, WorldDew 375G, Potion 150G at 75%).
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

; E-0261 (C1: ShopMenu_Case03_Case03, ShopMenu_Case04_Case03 and VaultMenu_Case03_Case09 read the word at $63FE + 2 * item number and draw the $F0-terminated name as bank-$1F glyph tiles ($4010 + 16 * character); the names equal StringTable_ItemNames (08:$4716) for the 99 items).
; record: item name
ItemNamesCopy_1C::
Data_01C_63FE:: ; address name
    dw ItemName1C_00 ; id 0
    dw ItemName1C_Herb ; id 1
    dw ItemName1C_LoveWater ; id 2
    dw ItemName1C_WorldDew ; id 3
    dw ItemName1C_Potion ; id 4
    dw ItemName1C_ElfWater ; id 5
    dw ItemName1C_Antidote ; id 6
    dw ItemName1C_MoonHerb ; id 7
    dw ItemName1C_Laurel ; id 8
    dw ItemName1C_AwakeSand ; id 9
    dw ItemName1C_SkyBell ; id 10
    dw ItemName1C_SageRock ; id 11
    dw ItemName1C_WorldLeaf ; id 12
    dw ItemName1C_ATKseed ; id 13
    dw ItemName1C_DEFseed ; id 14
    dw ItemName1C_AGLseed ; id 15
    dw ItemName1C_INTseed ; id 16
    dw ItemName1C_LifeAcorn ; id 17
    dw ItemName1C_MysticNut ; id 18
    dw ItemName1C_Quest ; id 19
    dw ItemName1C_Horror ; id 20
    dw ItemName1C_BeNice ; id 21
    dw ItemName1C_Cheater ; id 22
    dw ItemName1C_Smart ; id 23
    dw ItemName1C_Comedy ; id 24
    dw ItemName1C_BeefJerky ; id 25
    dw ItemName1C_PorkChop ; id 26
    dw ItemName1C_Rib ; id 27
    dw ItemName1C_Sirloin ; id 28
    dw ItemName1C_BadMeat ; id 29
    dw ItemName1C_MeteOrb ; id 30
    dw ItemName1C_BeastTail ; id 31
    dw ItemName1C_Repellent ; id 32
    dw ItemName1C_ShinyHarp ; id 33
    dw ItemName1C_Mist ; id 34
    dw ItemName1C_Friend ; id 35
    dw ItemName1C_Wind ; id 36
    dw ItemName1C_Bolt ; id 37
    dw ItemName1C_Snow ; id 38
    dw ItemName1C_Fire ; id 39
    dw ItemName1C_Warp ; id 40
    dw ItemName1C_WarpWing ; id 41
    dw ItemName1C_ExitBell ; id 42
    dw ItemName1C_Bookmark ; id 43
    dw ItemName1C_TinyMedal ; id 44
    dw ItemName1C_GoldPass ; id 45
    dw ItemName1C_LogTwig ; id 46
    dw ItemName1C_2F ; id 47
    dw ItemName1C_WaterCall ; id 48
    dw ItemName1C_MoonRock ; id 49
    dw ItemName1C_Crest ; id 50
    dw ItemName1C_YunaSoul ; id 51
    dw ItemName1C_SleepHerb ; id 52
    dw ItemName1C_Change ; id 53
    dw ItemName1C_TidalBell ; id 54
    dw ItemName1C_HarMirror ; id 55
    dw ItemName1C_Sky ; id 56
    dw ItemName1C_Heaven ; id 57
    dw ItemName1C_Heaven_6693 ; id 58
    dw ItemName1C_Heaven_669B ; id 59
    dw ItemName1C_WizStone ; id 60
    dw ItemName1C_Pretty ; id 61
    dw ItemName1C_Accessory ; id 62
    dw ItemName1C_Accessory ; id 63
    dw ItemName1C_Accessory ; id 64
    dw ItemName1C_DracoBelt ; id 65
    dw ItemName1C_MagicBelt ; id 66
    dw ItemName1C_OddBelt ; id 67
    dw ItemName1C_StoneFang ; id 68
    dw ItemName1C_SteelFang ; id 69
    dw ItemName1C_MermScale ; id 70
    dw ItemName1C_DrakScale ; id 71
    dw ItemName1C_AGL ; id 72
    dw ItemName1C_Starry ; id 73
    dw ItemName1C_Smart_670D ; id 74
    dw ItemName1C_Wise ; id 75
    dw ItemName1C_MagicCape ; id 76
    dw ItemName1C_DracoCape ; id 77
    dw ItemName1C_SilvrCape ; id 78
    dw ItemName1C_GoldCape ; id 79
    dw ItemName1C_PltnmCape ; id 80
    dw ItemName1C_OrcaCape ; id 81
    dw ItemName1C_BraveCape ; id 82
    dw ItemName1C_DScale ; id 83
    dw ItemName1C_None ; id 84
    dw ItemName1C_None ; id 85
    dw ItemName1C_None ; id 86
    dw ItemName1C_None ; id 87
    dw ItemName1C_None ; id 88
    dw ItemName1C_None ; id 89
    dw ItemName1C_None ; id 90
    dw ItemName1C_Divine ; id 91
    dw ItemName1C_War ; id 92
    dw ItemName1C_Mage ; id 93
    dw ItemName1C_Fight ; id 94
    dw ItemName1C_Sailor ; id 95
    dw ItemName1C_Thief ; id 96
    dw ItemName1C_Cleric ; id 97
    dw ItemName1C_62 ; id 98

ItemName1C_00:: ; heuristic: item name; C0
Data_01C_64C4:: ; address name
    db $F0

ItemName1C_Herb:: ; heuristic: item name; C0
Data_01C_64C5:: ; address name
    db $11, $28, $35, $25, $F0

ItemName1C_LoveWater:: ; heuristic: item name; C0
Data_01C_64CA:: ; address name
    db $15, $32, $39, $28, $20, $24, $37, $28, $35, $F0

ItemName1C_WorldDew:: ; heuristic: item name; C0
Data_01C_64D4:: ; address name
    db $20, $32, $35, $2F, $27, $0D, $28, $3A, $F0

ItemName1C_Potion:: ; heuristic: item name; C0
Data_01C_64DD:: ; address name
    db $19, $32, $37, $2C, $32, $31, $F0

ItemName1C_ElfWater:: ; heuristic: item name; C0
Data_01C_64E4:: ; address name
    db $0E, $2F, $29, $20, $24, $37, $28, $35, $F0

ItemName1C_Antidote:: ; heuristic: item name; C0
Data_01C_64ED:: ; address name
    db $0A, $31, $37, $2C, $27, $32, $37, $28, $F0

ItemName1C_MoonHerb:: ; heuristic: item name; C0
Data_01C_64F6:: ; address name
    db $16, $32, $32, $31, $11, $28, $35, $25, $F0

ItemName1C_Laurel:: ; heuristic: item name; C0
Data_01C_64FF:: ; address name
    db $15, $24, $38, $35, $28, $2F, $F0

ItemName1C_AwakeSand:: ; heuristic: item name; C0
Data_01C_6506:: ; address name
    db $0A, $3A, $24, $2E, $28, $1C, $24, $31, $27, $F0

ItemName1C_SkyBell:: ; heuristic: item name; C0
Data_01C_6510:: ; address name
    db $1C, $2E, $3C, $0B, $28, $2F, $2F, $F0

ItemName1C_SageRock:: ; heuristic: item name; C0
Data_01C_6518:: ; address name
    db $1C, $24, $2A, $28, $1B, $32, $26, $2E, $F0

ItemName1C_WorldLeaf:: ; heuristic: item name; C0
Data_01C_6521:: ; address name
    db $20, $32, $35, $2F, $27, $15, $28, $24, $29, $F0

ItemName1C_ATKseed:: ; heuristic: item name; C0
Data_01C_652B:: ; address name
    db $0A, $1D, $14, $36, $28, $28, $27, $F0

ItemName1C_DEFseed:: ; heuristic: item name; C0
Data_01C_6533:: ; address name
    db $0D, $0E, $0F, $36, $28, $28, $27, $F0

ItemName1C_AGLseed:: ; heuristic: item name; C0
Data_01C_653B:: ; address name
    db $0A, $10, $15, $36, $28, $28, $27, $F0

ItemName1C_INTseed:: ; heuristic: item name; C0
Data_01C_6543:: ; address name
    db $12, $17, $1D, $36, $28, $28, $27, $F0

ItemName1C_LifeAcorn:: ; heuristic: item name; C0
Data_01C_654B:: ; address name
    db $15, $2C, $29, $28, $0A, $26, $32, $35, $31, $F0

ItemName1C_MysticNut:: ; heuristic: item name; C0
Data_01C_6555:: ; address name
    db $16, $3C, $36, $37, $2C, $26, $17, $38, $37, $F0

ItemName1C_Quest:: ; heuristic: item name; C0
Data_01C_655F:: ; address name
    db $1A, $38, $28, $36, $37, $50, $F0

ItemName1C_Horror:: ; heuristic: item name; C0
Data_01C_6566:: ; address name
    db $11, $32, $35, $35, $32, $35, $50, $F0

ItemName1C_BeNice:: ; heuristic: item name; C0
Data_01C_656E:: ; address name
    db $0B, $28, $17, $2C, $26, $28, $50, $F0

ItemName1C_Cheater:: ; heuristic: item name; C0
Data_01C_6576:: ; address name
    db $0C, $2B, $28, $24, $37, $28, $35, $50, $F0

ItemName1C_Smart:: ; heuristic: item name; C0
Data_01C_657F:: ; address name
    db $1C, $30, $24, $35, $37, $50, $F0

ItemName1C_Comedy:: ; heuristic: item name; C0
Data_01C_6586:: ; address name
    db $0C, $32, $30, $28, $27, $3C, $50, $F0

ItemName1C_BeefJerky:: ; heuristic: item name; C0
Data_01C_658E:: ; address name
    db $0B, $28, $28, $29, $13, $28, $35, $2E, $3C, $F0

ItemName1C_PorkChop:: ; heuristic: item name; C0
Data_01C_6598:: ; address name
    db $19, $32, $35, $2E, $0C, $2B, $32, $33, $F0

ItemName1C_Rib:: ; heuristic: item name; C0
Data_01C_65A1:: ; address name
    db $1B, $2C, $25, $F0

ItemName1C_Sirloin:: ; heuristic: item name; C0
Data_01C_65A5:: ; address name
    db $1C, $2C, $35, $2F, $32, $2C, $31, $F0

ItemName1C_BadMeat:: ; heuristic: item name; C0
Data_01C_65AD:: ; address name
    db $0B, $24, $27, $16, $28, $24, $37, $F0

ItemName1C_MeteOrb:: ; heuristic: item name; C0
Data_01C_65B5:: ; address name
    db $16, $28, $37, $28, $18, $35, $25, $F0

ItemName1C_BeastTail:: ; heuristic: item name; C0
Data_01C_65BD:: ; address name
    db $0B, $28, $24, $36, $37, $1D, $24, $2C, $2F, $F0

ItemName1C_Repellent:: ; heuristic: item name; C0
Data_01C_65C7:: ; address name
    db $1B, $28, $33, $28, $2F, $2F, $28, $31, $37, $F0

ItemName1C_ShinyHarp:: ; heuristic: item name; C0
Data_01C_65D1:: ; address name
    db $1C, $2B, $2C, $31, $3C, $11, $24, $35, $33, $F0

ItemName1C_Mist:: ; heuristic: item name; C0
Data_01C_65DB:: ; address name
    db $16, $2C, $36, $37, $51, $F0

ItemName1C_Friend:: ; heuristic: item name; C0
Data_01C_65E1:: ; address name
    db $0F, $35, $2C, $28, $31, $27, $51, $F0

ItemName1C_Wind:: ; heuristic: item name; C0
Data_01C_65E9:: ; address name
    db $20, $2C, $31, $27, $51, $F0

ItemName1C_Bolt:: ; heuristic: item name; C0
Data_01C_65EF:: ; address name
    db $0B, $32, $2F, $37, $51, $F0

ItemName1C_Snow:: ; heuristic: item name; C0
Data_01C_65F5:: ; address name
    db $1C, $31, $32, $3A, $51, $F0

ItemName1C_Fire:: ; heuristic: item name; C0
Data_01C_65FB:: ; address name
    db $0F, $2C, $35, $28, $51, $F0

ItemName1C_Warp:: ; heuristic: item name; C0
Data_01C_6601:: ; address name
    db $20, $24, $35, $33, $51, $F0

ItemName1C_WarpWing:: ; heuristic: item name; C0
Data_01C_6607:: ; address name
    db $20, $24, $35, $33, $20, $2C, $31, $2A, $F0

ItemName1C_ExitBell:: ; heuristic: item name; C0
Data_01C_6610:: ; address name
    db $0E, $3B, $2C, $37, $0B, $28, $2F, $2F, $F0

ItemName1C_Bookmark:: ; heuristic: item name; C0
Data_01C_6619:: ; address name
    db $0B, $32, $32, $2E, $30, $24, $35, $2E, $F0

ItemName1C_TinyMedal:: ; heuristic: item name; C0
Data_01C_6622:: ; address name
    db $1D, $2C, $31, $3C, $16, $28, $27, $24, $2F, $F0

ItemName1C_GoldPass:: ; heuristic: item name; C0
Data_01C_662C:: ; address name
    db $10, $32, $2F, $27, $19, $24, $36, $36, $F0

ItemName1C_LogTwig:: ; heuristic: item name; C0
Data_01C_6635:: ; address name
    db $15, $32, $2A, $1D, $3A, $2C, $2A, $F0

ItemName1C_2F:: ; heuristic: item name; C0
Data_01C_663D:: ; address name
    db $F0

ItemName1C_WaterCall:: ; heuristic: item name; C0
Data_01C_663E:: ; address name
    db $20, $24, $37, $28, $35, $0C, $24, $2F, $2F, $F0

ItemName1C_MoonRock:: ; heuristic: item name; C0
Data_01C_6648:: ; address name
    db $16, $32, $32, $31, $1B, $32, $26, $2E, $F0

ItemName1C_Crest:: ; heuristic: item name; C0
Data_01C_6651:: ; address name
    db $0C, $35, $28, $36, $37, $F0

ItemName1C_YunaSoul:: ; heuristic: item name; C0
Data_01C_6657:: ; address name
    db $22, $38, $31, $24, $1C, $32, $38, $2F, $F0

ItemName1C_SleepHerb:: ; heuristic: item name; C0
Data_01C_6660:: ; address name
    db $1C, $2F, $28, $28, $33, $11, $28, $35, $25, $F0

ItemName1C_Change:: ; heuristic: item name; C0
Data_01C_666A:: ; address name
    db $0C, $2B, $24, $31, $2A, $28, $51, $F0

ItemName1C_TidalBell:: ; heuristic: item name; C0
Data_01C_6672:: ; address name
    db $1D, $2C, $27, $24, $2F, $0B, $28, $2F, $2F, $F0

ItemName1C_HarMirror:: ; heuristic: item name; C0
Data_01C_667C:: ; address name
    db $11, $24, $35, $16, $2C, $35, $35, $32, $35, $F0

ItemName1C_Sky:: ; heuristic: item name; C0
Data_01C_6686:: ; address name
    db $1C, $2E, $3C, $5E, $F0

ItemName1C_Heaven:: ; heuristic: item name; C0
Data_01C_668B:: ; address name
    db $11, $28, $24, $39, $28, $31, $52, $F0

ItemName1C_Heaven_6693:: ; heuristic: item name; C0
Data_01C_6693:: ; address name
    db $11, $28, $24, $39, $28, $31, $54, $F0

ItemName1C_Heaven_669B:: ; heuristic: item name; C0
Data_01C_669B:: ; address name
    db $11, $28, $24, $39, $28, $31, $53, $F0

ItemName1C_WizStone:: ; heuristic: item name; C0
Data_01C_66A3:: ; address name
    db $20, $2C, $3D, $1C, $37, $32, $31, $28, $F0

ItemName1C_Pretty:: ; heuristic: item name; C0
Data_01C_66AC:: ; address name
    db $19, $35, $28, $37, $37, $3C, $55, $F0

ItemName1C_Accessory:: ; heuristic: item name; C0
Data_01C_66B4:: ; address name
    db $1F, $12, $1D, $25, $28, $2F, $37, $F0

ItemName1C_DracoBelt:: ; heuristic: item name; C0
Data_01C_66BC:: ; address name
    db $0D, $35, $24, $26, $32, $0B, $28, $2F, $37, $F0

ItemName1C_MagicBelt:: ; heuristic: item name; C0
Data_01C_66C6:: ; address name
    db $16, $24, $2A, $2C, $26, $0B, $28, $2F, $37, $F0

ItemName1C_OddBelt:: ; heuristic: item name; C0
Data_01C_66D0:: ; address name
    db $18, $27, $27, $0B, $28, $2F, $37, $F0

ItemName1C_StoneFang:: ; heuristic: item name; C0
Data_01C_66D8:: ; address name
    db $1C, $37, $32, $31, $28, $0F, $24, $31, $2A, $F0

ItemName1C_SteelFang:: ; heuristic: item name; C0
Data_01C_66E2:: ; address name
    db $1C, $37, $28, $28, $2F, $0F, $24, $31, $2A, $F0

ItemName1C_MermScale:: ; heuristic: item name; C0
Data_01C_66EC:: ; address name
    db $16, $28, $35, $30, $1C, $26, $24, $2F, $28, $F0

ItemName1C_DrakScale:: ; heuristic: item name; C0
Data_01C_66F6:: ; address name
    db $0D, $35, $24, $2E, $1C, $26, $24, $2F, $28, $F0

ItemName1C_AGL:: ; heuristic: item name; C0
Data_01C_6700:: ; address name
    db $0A, $10, $15, $55, $F0

ItemName1C_Starry:: ; heuristic: item name; C0
Data_01C_6705:: ; address name
    db $1C, $37, $24, $35, $35, $3C, $55, $F0

ItemName1C_Smart_670D:: ; heuristic: item name; C0
Data_01C_670D:: ; address name
    db $1C, $30, $24, $35, $37, $56, $F0

ItemName1C_Wise:: ; heuristic: item name; C0
Data_01C_6714:: ; address name
    db $20, $2C, $36, $28, $56, $F0

ItemName1C_MagicCape:: ; heuristic: item name; C0
Data_01C_671A:: ; address name
    db $16, $24, $2A, $2C, $26, $0C, $24, $33, $28, $F0

ItemName1C_DracoCape:: ; heuristic: item name; C0
Data_01C_6724:: ; address name
    db $0D, $35, $24, $26, $32, $0C, $24, $33, $28, $F0

ItemName1C_SilvrCape:: ; heuristic: item name; C0
Data_01C_672E:: ; address name
    db $1C, $2C, $2F, $39, $35, $0C, $24, $33, $28, $F0

ItemName1C_GoldCape:: ; heuristic: item name; C0
Data_01C_6738:: ; address name
    db $10, $32, $2F, $27, $0C, $24, $33, $28, $F0

ItemName1C_PltnmCape:: ; heuristic: item name; C0
Data_01C_6741:: ; address name
    db $19, $2F, $37, $31, $30, $0C, $24, $33, $28, $F0

ItemName1C_OrcaCape:: ; heuristic: item name; C0
Data_01C_674B:: ; address name
    db $18, $35, $26, $24, $0C, $24, $33, $28, $F0

ItemName1C_BraveCape:: ; heuristic: item name; C0
Data_01C_6754:: ; address name
    db $0B, $35, $24, $39, $28, $0C, $24, $33, $28, $F0

ItemName1C_DScale:: ; heuristic: item name; C0
Data_01C_675E:: ; address name
    db $0D, $9C, $1C, $26, $24, $2F, $28, $F0

ItemName1C_None:: ; heuristic: item name; C0
Data_01C_6766:: ; address name
    db $15, $2C, $29, $28, $55, $F0

ItemName1C_Divine:: ; heuristic: item name; C0
Data_01C_676C:: ; address name
    db $0D, $2C, $39, $2C, $31, $28, $55, $F0

ItemName1C_War:: ; heuristic: item name; C0
Data_01C_6774:: ; address name
    db $20, $24, $35, $55, $F0

ItemName1C_Mage:: ; heuristic: item name; C0
Data_01C_6779:: ; address name
    db $16, $24, $2A, $28, $55, $F0

ItemName1C_Fight:: ; heuristic: item name; C0
Data_01C_677F:: ; address name
    db $0F, $2C, $2A, $2B, $37, $55, $F0

ItemName1C_Sailor:: ; heuristic: item name; C0
Data_01C_6786:: ; address name
    db $1C, $24, $2C, $2F, $32, $35, $55, $F0

ItemName1C_Thief:: ; heuristic: item name; C0
Data_01C_678E:: ; address name
    db $1D, $2B, $2C, $28, $29, $55, $F0

ItemName1C_Cleric:: ; heuristic: item name; C0
Data_01C_6795:: ; address name
    db $0C, $2F, $28, $35, $2C, $26, $55, $F0

ItemName1C_62:: ; heuristic: item name; C0
Data_01C_679D:: ; address name
    db $F0

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (the same 17 bytes appear in 7 banks)
; 6 call sites from 4 routines (e.g. VaultMenu_Setup_CopyTileBytesToVRAM_Bank1C, ClearRect147AndAskTwoChoice, VaultMenu_Store_CopyTileBytesToVRAM_Bank1C, ShopMenu_Shared01_ClearRectSetTextCursorLoPlus1C1_Bank1C)
; reads: rSTAT
CopyTileBytesToVRAM_Bank1C::
Func_01C_679E:: ; address name
    ld c, $10

.loop:
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [hl+]
    ld [de], a
    inc de
    ei
    dec c
    jr nz, .loop
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX, hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
; 47 call sites from 37 routines (e.g. VaultMenu_ChooseAction_BGMapAddressAtScroll_Bank1C_67AF, CloseShopMenu_Case00_CopyBytesDEToHL_Bank1C, ShopMenu_ChooseAction_StepBGMapAddressBackOnScrollWrap, DrawScreenListBoxAtWC370AndStep, ...)
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

; copies the B x C rectangle at DE to the BG map at HL (Func_01C_6823 with A = 0) and sets wTextCursorLo = HL + $1C1; on CGB copies it again with VRAM bank 1 selected and WRAM bank 2 switched in (E-0121; a copy, not a clear: E-0226)
; 11 call sites from 9 routines (e.g. DrawTwoBoxesAndRequestScript80, ShopMenu_Buy_BlinkCursorBlinkCD_Bank1C_4F87, ShopMenu_Sell_ClearRectSetTextCursorLoPlus1C1_Bank1C, ShopMenu_Sell_BlinkCursorBlinkCD_Bank1C_5B61, ...)
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

; clears a rectangle (Func_01C_6823 with A = 0) and sets wTextCursorLo = HL + $1C1 (E-0124)
; 13 call sites from 13 routines (e.g. ShopMenu_Buy_SubtractArg1AmountFromGold, DrawTwoBoxesAndRequestScript80, ShopMenu_Buy_BlinkCursorBlinkD2_Bank1C_52A0, ShopMenu_Buy_StepBGMapAddressBackOnScrollWrap_Case08, ...)
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
    jr nz, .restore
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
    jr nc, .restore2
    pop de
    pop bc
    pop hl
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

.skip:
    push hl
    push bc
    jr .loop

.restore:
    pop de
    pop bc
    pop hl
    jr .skip

.restore2:
    pop de

.loop:
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [de]
    ei
    ldh [hVRAMByteTemp], a
    di

.loop3:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop3
    ldh a, [hVRAMByteTemp]
    ld [hl+], a
    ei
    ld a, l
    and a, $1F
    jr nz, .next
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a

.next:
    inc de
    dec b
    jr nz, .loop
    pop bc
    pop hl
    dec c
    jr z, .return
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, h
    and a, $9B
    ld h, a
    jp .skip

.return:
    ret

; clears wItemGrid ($18 bytes) and lists each item id 1-$62 present in the inventory, counting them in wGlyphListStart (E-0127)
; 2 call sites from 2 routines (e.g. ShopMenu_Sell_ListDistinctInventoryItemsToItemGrid, DrawRect0140AtBGMap13E0AndStep)
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

.loop:
    xor a, a
    ld [hl+], a
    dec c
    jr nz, .loop
    xor a, a
    ld [wGlyphListStart], a
    ld [wGridCursorX], a
    ld b, $01

.loop2:
    ld hl, wInventory
    ld c, $18

.loop3:
    ld a, [hl]
    cp a, b
    jr z, .read_glyph_list_start
    inc hl
    dec c
    jr nz, .loop3

.next:
    inc b
    ld a, b
    cp a, $63
    jr c, .loop2
    pop hl
    pop de
    pop bc
    pop af
    ret

.read_glyph_list_start:
    ld a, [wGlyphListStart]
    ld de, wItemGrid
    add a, e
    ld e, a
    jr nc, .check_glyph_list_start
    inc d

.check_glyph_list_start:
    ld a, b
    ld [de], a
    ld a, [wGlyphListStart]
    inc a
    ld [wGlyphListStart], a
    jr .next

; HL = wArg1/wArg2 = the word at Data_01C_6158 + 2 * wScreenTableIndex (E-0118)
; 7 call sites from 7 routines (e.g. ShopMenu_Buy_SubtractArg1AmountFromGold, ShopMenu_Buy_LoadArg1PointerForScreenTableIndex_Case0A, ShopMenu_Buy_Case09_WriteThreeDigits, ShopMenu_Buy_LoadArg1PointerForScreenTableIndex_Case05, ...)
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

; LoadArg1PointerForScreenTableIndex, then wArg1 = the byte at that pointer + 4 * wItemGridY + wItemGridX (E-0119)
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

; removes 10 * wNumberTens + wNumberOnes copies of the selected item (wItemGrid[4 * wItemGridY + wItemGridX]) from the inventory and compacts it (E-0128) (C2 from E-0325: depositing one item at the Vault removes it and closes up the bag, a 0 at its end)
; 2 call sites from 2 routines (e.g. ShopMenu_Sell_AddArg1ToGoldCapped99999, VaultMenu_Store_ReadScreenState)
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
    jr nc, .set_records_flagged
    inc d

.set_records_flagged:
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

.loop:
    ld a, [wCursorBlinkB8]
    cp a, [hl]
    jr nz, .skip
    ld a, [wRecordsFlagged]
    and a, a
    jr z, .skip
    dec a
    ld [wRecordsFlagged], a
    inc hl
    inc c
    ld a, c
    cp a, $18
    jr nc, .loop2
    jr .loop

.skip:
    ld a, [hl]
    ld [de], a
    inc hl
    inc de
    inc b
    inc c
    ld a, c
    cp a, $18
    jr c, .loop

.loop2:
    xor a, a
    ld [de], a
    inc de
    inc b
    ld a, b
    cp a, $18
    jr c, .loop2
    ret

; counts the inventory slots holding the item at wItemGrid[4 * wItemGridY + wItemGridX]; wCountTens = count / 10, wCountOnes = count mod 10 (E-0125)
; 2 call sites from 2 routines (e.g. ShopMenu_Sell_StepBGMapAddressBackOnScrollWrap, VaultMenu_Store_Case0B_BlinkCursorSelectedRecord_Bank1D_4D41)
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

.loop:
    ld a, [hl]
    cp a, b
    jr nz, .next
    inc c

.next:
    inc hl
    dec d
    jr nz, .loop
    ld l, c
    ld h, $00
    ld a, $0A
    call DivideHLByA
    ld [wCountOnes], a
    ld a, l
    ld [wCountTens], a
    ret

; for each entry from wScreenCounter of the destination list at HL and the source list at DE copies a 16-byte tile from bank $1F, until $FF; then wScreenStep += 1 (E-0127)
; 2 call sites from 2 routines (e.g. ShopMenu_Setup_ToCopyTileListFromBank1F_1C, VaultMenu_Setup_ToCopyTileListFromBank1F_1C)
; reads: wScreenCounter
; writes: wGlyphListPos, wScreenCounter
; points at: wScreenStep
CopyTileListFromBank1F_1C::
Func_01C_69D5:: ; address name
    xor a, a
    ld [wGlyphListPos], a

.read_screen_counter:
    push hl
    push de
    ld a, [wScreenCounter]
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jp z, .restore
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
    jr nc, .skip
    inc d

.skip:
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
    jr .read_screen_counter

.restore:
    pop de
    pop hl
    xor a, a
    ld [wScreenCounter], a
    ld [wGlyphListPos], a
    ld hl, wScreenStep
    inc [hl]
    ret

; copies $28 bytes from Data_01C_5F5E to wScreenList, runs Func_01C_4395, counts the inventory items into wListPages and its digits into wItemCountTens/6, wScreenStep += 1 (E-0125)
; 2 call sites from 2 routines (e.g. ShopMenu_Setup_ToInitItemListScreenListAndCount, VaultMenu_Setup_ToInitItemListScreenListAndCount)
; reads: wDigits
; writes: wListPages, wItemCountTens, wItemCountOnes
; points at: wScreenList, wScreenBlock92, wInventory, wScreenStep
InitItemListScreenListAndCount::
Func_01C_6A22:: ; address name
    ld hl, wScreenList
    ld de, ShopMenu_Buy_SubtractArg1AmountFromGold_Data
    ld bc, $0028

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld hl, wScreenBlock92
    call DrawGoldDigitsAtHLWrapped_1C
    ld hl, wInventory
    ld c, $18
    ld b, $00

.loop2:
    ld a, [hl+]
    and a, a
    jr z, .next
    cp a, $FF
    jr z, .next
    inc b

.next:
    dec c
    jr nz, .loop2
    ld a, b
    ld [wListPages], a
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld a, [wDigits + $1]
    and a, a
    jr z, .read_digits
    ld a, [wDigits + $1]
    add a, $E0
    ld [wItemCountTens], a

.read_digits:
    ld a, [wDigits + $2]
    add a, $E0
    ld [wItemCountOnes], a
    ld hl, wScreenStep
    inc [hl]
    ret

; copies the 8 x 5 box at wScreenList to wWindowTileBuffer + $70, draws it at scroll + $1CC and wScreenStep += 1 (E-0122)
; 2 call sites from 2 routines (e.g. ShopMenu_Setup_DrawScreenListBoxAtWC370AndStep, VaultMenu_Setup_DrawScreenListBoxAtWC370AndStep)
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
; 1 call site from 1 routine (e.g. CloseShopMenu_ToCloseShopMenu_Case01_SetGlyphListPos)
; writes: wGlyphListPos, wScreenCounter, wScreenState, wScreenStep, wMenuState, wScriptCommandType, wScriptStartRequest
; points at: wGridCursorY
CloseShopMenu_Case01_SetGlyphListPos::
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
; 1 call site from 1 routine (e.g. CloseShopMenu_ToCloseShopMenu_Case00_CopyBytesDEToHL_Bank1C)
; reads: wIsCGB
; points at: wScreenTileBuffer, wScreenAttrBuffer, wGridCursorY
CloseShopMenu_Case00_CopyBytesDEToHL_Bank1C::
Func_01C_6AAC:: ; address name
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a, a
    jr z, .call_bg_map_address_at_scroll_bank1_c_67_af
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank1C

.call_bg_map_address_at_scroll_bank1_c_67_af:
    call BGMapAddressAtScroll_Bank1C_67AF
    ld bc, $140D
    ld de, $01CC
    call DrawScreenBufferRectToBGMap_1C
    ld hl, wGridCursorY
    inc [hl]
    ret

; clears wTextCounter0-wTextCounter4, wTextCounter5 and wTextCounter6, and sets wTextTimer = $3C (60) (E-0072)
; 14 call sites from 4 routines (e.g. ShopMenu_Buy_ResetTextCounter0Counters, ShopMenu_Buy_BlinkCursorSelectedRecord_Bank1C, ShopMenu_Sell_ResetTextCounter0Counters, ShopMenu_Sell_BlinkCursorSelectedRecord_Bank1C)
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
; 2 call sites from 2 routines (e.g. ShopMenu_Buy_BlinkCursorSelectedRecord_Bank1C, ShopMenu_Sell_BlinkCursorSelectedRecord_Bank1C)
; reads: wJoypadPressedRepeat, wScreenState, wTextTimer, wTextCounter0, wScreenStep
; writes: wTextCounter6, wTextTimer, wTextCounter0
ShopMenu_WriteTextCounter6AndTextTimerEtc::
Func_01C_6AF7:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 0, a
    jr nz, .check_text_timer
    and a, a
    jr z, .check_text_timer
    ld a, [wScreenState]
    cp a, $03
    jr z, .check_screen_step2
    ld a, [wScreenState]
    cp a, $04
    jr z, .check_screen_step
    jr .set_text_counter6_to_01

.check_screen_step:
    ld a, [wScreenStep]
    cp a, $05
    jr nz, .set_text_counter6_to_01
    jr .check_joypad_pressed_repeat

.check_screen_step2:
    ld a, [wScreenStep]
    cp a, $06
    jr nz, .set_text_counter6_to_01

.check_joypad_pressed_repeat:
    ld a, [wJoypadPressedRepeat]
    bit 1, a
    jr z, .set_text_counter6_to_01
    ld a, $03
    ld [wTextCounter0], a
    ret

.set_text_counter6_to_01:
    ld a, $01
    ld [wTextCounter6], a
    ld a, $3C
    ld [wTextTimer], a

.check_text_timer:
    ld a, [wTextTimer]
    inc a
    ld [wTextTimer], a
    cp a, $3C
    ret c
    ld a, $3C
    ld [wTextTimer], a
    ld a, [wTextCounter0]
    rst $00
    dw ShopMenu_Shared01_ClearRectSetTextCursorLoPlus1C1_Bank1C
    dw ShopMenu_Shared01_ClearRectSetTextCursorLoPlus1C1_Bank1C_Case01
    dw ShopMenu_Shared01_ToStepItemDescriptionText
    dw ShopMenu_Shared01_Return

; entry 0 of the `rst $00` table in Func_01C_6AF7
; no direct call (reached through a table, a jump or a vector)
; reads: wTextCounter0
; writes: wTextCounter0
ShopMenu_Shared01_ClearRectSetTextCursorLoPlus1C1_Bank1C::
Jump_01C_6B53:: ; address name
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $01A0
    add hl, de
    ld bc, $1405
    ld de, TileRect_1C_6B7D
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    ld c, $24
    ld de, vTiles1

.loop:
    push bc
    ld hl, Tiles_1C_6BE1
    call CopyTileBytesToVRAM_Bank1C
    pop bc
    dec c
    jr nz, .loop
    ld a, [wTextCounter0]
    inc a
    ld [wTextCounter0], a
    jp ShopMenu_Shared01_ClearRectSetTextCursorLoPlus1C1_Bank1C_Case01

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
ShopMenu_Shared01_ClearRectSetTextCursorLoPlus1C1_Bank1C_Case01::
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
    jp ShopMenu_Shared01_ToStepItemDescriptionText
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
ShopMenu_Shared01_ToStepItemDescriptionText::
Jump_01C_6C70:: ; address name
    farcall StepItemDescriptionText
    ret

; entry 3 of the `rst $00` table in Func_01C_6AF7
; no direct call (reached through a table, a jump or a vector)
ShopMenu_Shared01_Return::
Jump_01C_6C77:: ; address name
    ret

; draws tiles $C5, $BE, $C6 at BGMapAddressAtScroll + $18E, two entries apart (E-0121)
; 2 call sites from 2 routines (e.g. ShopMenu_Buy_LoadArg1PointerForScreenTableIndex, ShopMenu_Sell_ListDistinctInventoryItemsToItemGrid)
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

; DEHL = A * EHL (24-bit by 8-bit multiply through wArg1-wArg4) (E-0121)
; 2 call sites from 2 routines (e.g. ShopMenu_Buy_Case09_WriteThreeDigits, ShopMenu_Buy_ReadFarPointerAtDEInBankB)
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

; implements script command type E5 (SCRIPT_VAULT): the item Vault: 'What item should I store for...', 'What will you be taking out?' (mode 2); reached through ScriptCommandE5 in bank $10 (E-0038, E-0244) (C2 from E-0325: talking to the Vault clerk runs it with 'Deposit: Item / Gold / Exit')
; 1 call site from 1 routine (e.g. ScriptCommandE5)
; reads: wScreenState
VaultMenu::
Func_01C_6CEF:: ; address name
    ld a, [wScreenState]
    rst $00
    dw VaultMenu_Init
    dw VaultMenu_Setup
    dw VaultMenu_ChooseAction
    dw VaultMenu_Store
    dw VaultMenu_TakeOut

; state 0 of VaultMenu: clears the screen state (E-0276)
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: wMessageMode, wGlyphListPos, wScreenCounter, wNumberTens, wNumberOnes, wNumberEditPos, wScriptCommandType, wScriptStartRequest
; points at: wScreenState, wScreenTileBuffer, wScreenAttrBuffer
VaultMenu_Init::
Jump_01C_6CFD:: ; address name
    ld bc, $0070
    ld hl, wScreenState

.loop:
    xor a, a
    ld [hl+], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a, a
    jr z, .set_message_mode_to_02
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank1C

.set_message_mode_to_02:
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

; screen setup: tile lists, the item list screen and its box (E-0276)
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
VaultMenu_Setup::
Jump_01C_6D4D:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw VaultMenu_Setup_CopyTileBytesToVRAM_Bank1C
    dw VaultMenu_Setup_ToCopyTileListFromBank1F_1C
    dw VaultMenu_Setup_ToVaultMenu_WriteSavedSpriteClipModeAndListPagesAndStep
    dw VaultMenu_Setup_CopyFromBankWaitVRAM
    dw VaultMenu_Setup_ToInitItemListScreenListAndCount
    dw VaultMenu_Setup_DrawScreenListBoxAtWC370AndStep

; entry 0 of the `rst $00` table in VaultMenu_Setup
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
VaultMenu_Setup_CopyTileBytesToVRAM_Bank1C::
Jump_01C_6D5D:: ; address name
    ld hl, vTiles1 + $240
    ld de, vTiles2 + $7D0
    call CopyTileBytesToVRAM_Bank1C
    call CopyTileBytesToVRAM_Bank1C
    call CopyTileBytesToVRAM_Bank1C
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

; entry 1 of the `rst $00` table in VaultMenu_Setup
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Setup_ToCopyTileListFromBank1F_1C::
Jump_01C_6D73:: ; address name
    ld hl, TileCopyDestList_1C_5F86
    ld de, TileCopySrcList_1C_604A
    call CopyTileListFromBank1F_1C
    ret

; entry 2 of the `rst $00` table in VaultMenu_Setup
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
VaultMenu_Setup_ToVaultMenu_WriteSavedSpriteClipModeAndListPagesAndStep::
Jump_01C_6D7D:: ; address name
    farcall VaultMenu_WriteSavedSpriteClipModeAndListPages
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 3 of the `rst $00` table in VaultMenu_Setup
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
VaultMenu_Setup_CopyFromBankWaitVRAM::
Jump_01C_6D8B:: ; address name
    ld hl, vTiles1 + $240
    ld de, Tiles1Plus2D0Tiles_1F_43C0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles1 + $250
    ld de, Tiles1Plus250Tiles_1F_4340
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles1 + $260
    ld de, Tiles1Plus260Tiles_1F_40E0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles1 + $270
    ld de, Tiles1Plus6F0Tiles_1F_4330
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 4 of the `rst $00` table in VaultMenu_Setup
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Setup_ToInitItemListScreenListAndCount::
Jump_01C_6DC7:: ; address name
    call InitItemListScreenListAndCount
    ret

; entry 5 of the `rst $00` table in VaultMenu_Setup
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest
; points at: wScreenState
VaultMenu_Setup_DrawScreenListBoxAtWC370AndStep::
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

; the Vault's choice menu: Up/Down move the cursor, A selects, B leaves (E-0276)
; no direct call (reached through a table, a jump or a vector)
; reads: wJoypadPressedRepeat, wListLastRow, wScreenByteB2, wScreenState
; writes: wTwoChoiceCursor, wScriptCommandType, wScriptStartRequest, wItemGridX, wItemGridY, wScreenByteB2, wScreenState, wListLastRow
VaultMenu_ChooseAction::
Jump_01C_6E3C:: ; address name
    ld a, [wJoypadPressedRepeat]
    bit 6, a
    jr nz, .call_vault_menu_choose_action_read_list_last
    bit 7, a
    jr nz, .call_vault_menu_choose_action_read_list_last2
    bit 0, a
    jr nz, .call_queue_sound_effect
    bit 1, a
    jp nz, .set_two_choice_cursor_to_02
    call VaultMenu_ChooseAction_WriteScreenByteB3
    ret

.call_vault_menu_choose_action_read_list_last:
    call VaultMenu_ChooseAction_ReadListLastRow
    ld a, [wListLastRow]
    and a, a
    jr nz, .set_list_last_row
    ld a, $02
    jr .set_list_last_row2

.set_list_last_row:
    dec a

.set_list_last_row2:
    ld [wListLastRow], a
    call VaultMenu_ChooseAction_WriteScreenByteB3
    ld a, $69
    call QueueSoundEffect
    ret

.call_vault_menu_choose_action_read_list_last2:
    call VaultMenu_ChooseAction_ReadListLastRow
    ld a, [wListLastRow]
    cp a, $02
    jr c, .skip
    xor a, a
    jr .set_list_last_row2

.skip:
    inc a
    jr .set_list_last_row2

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call VaultMenu_ChooseAction_BGMapAddressAtScroll_Bank1C_67AF
    ld a, [wListLastRow]
    ld b, a
    ld a, [wScreenByteB2]
    cp a, b
    jr z, .set_screen_byte_b2
    ld a, [wListLastRow]
    ld b, a
    xor a, a
    ld [wItemGridX], a
    ld [wItemGridY], a

.set_screen_byte_b2:
    ld a, b
    ld [wScreenByteB2], a
    ld a, [wListLastRow]
    and a, a
    jr z, .check_screen_state
    cp a, $01
    jr z, .check_screen_state2
    ld a, $02
    ld [wTwoChoiceCursor], a

.clear_script_command_type:
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_screen_state:
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a, a
    ld [wTwoChoiceCursor], a
    jp .clear_script_command_type

.check_screen_state2:
    ld a, [wScreenState]
    inc a
    inc a
    ld [wScreenState], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    jp .clear_script_command_type

.set_two_choice_cursor_to_02:
    ld a, $02
    ld [wTwoChoiceCursor], a
    jp .clear_script_command_type

; only called from VaultMenu_ChooseAction (E-0047)
; 2 call sites from 1 routine (e.g. VaultMenu_ChooseAction)
; reads: wJoypadRepeatTimer, wScreenByteB3, wListLastRow
; writes: wScreenByteB3
VaultMenu_ChooseAction_WriteScreenByteB3::
Func_01C_6EDE:: ; address name
    ld a, [wJoypadRepeatTimer]
    cp a, $14
    jr c, .skip
    ld a, [wScreenByteB3]
    inc a
    ld [wScreenByteB3], a
    cp a, $10
    jr c, .skip
    cp a, $18
    jr c, VaultMenu_ChooseAction_ReadListLastRow
    xor a, a
    ld [wScreenByteB3], a

.skip:
    ld b, $BB
    jr VaultMenu_ChooseAction_BGMapAddressAtScroll_Bank1C_67AF_ReadListLastRow

; only called from VaultMenu_ChooseAction (E-0047)
; 2 call sites from 1 routine (e.g. VaultMenu_ChooseAction)
; reads: wListLastRow
VaultMenu_ChooseAction_ReadListLastRow::
Func_01C_6EFC:: ; address name
    ld b, $C3
    jr VaultMenu_ChooseAction_BGMapAddressAtScroll_Bank1C_67AF_ReadListLastRow

; only called from VaultMenu_ChooseAction (E-0047)
; 1 call site from 1 routine (e.g. VaultMenu_ChooseAction)
; reads: wListLastRow
VaultMenu_ChooseAction_BGMapAddressAtScroll_Bank1C_67AF::
Func_01C_6F00:: ; address name
    ld b, $BC

VaultMenu_ChooseAction_BGMapAddressAtScroll_Bank1C_67AF_ReadListLastRow::
Jump_01C_6F02:: ; address name
    ld a, [wListLastRow]
    sla a
    ld hl, VaultMenu_ChooseAction_BGMapAddressAtScroll_Bank1C_67AF_Data
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

; address loaded by VaultMenu_ChooseAction_BGMapAddressAtScroll_Bank1C_67AF
VaultMenu_ChooseAction_BGMapAddressAtScroll_Bank1C_67AF_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_01C_6F21:: ; address name
    db $21, $00, $61, $00, $A1, $00

; storing: moves items from wInventory into wItemStorage (RemoveItemCountFromInventory) (E-0276)
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
VaultMenu_Store::
Jump_01C_6F27:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw VaultMenu_Store_ToVaultMenu_Store_Case00_WaitForVRAMAccess
    dw VaultMenu_Store_DrawRectBothBanksSetTextCursorLoPlus1C1
    dw VaultMenu_Store_LoadThreeTilesAndDrawRows4603To460B
    dw VaultMenu_Store_ToVaultMenu_Store_Case03_WriteTwoChoiceCursorAndScreenStepEtc
    dw VaultMenu_Store_SetScreenState
    dw VaultMenu_Store_ToDrawRect0088AtBGMap1370AndStep
    dw VaultMenu_Store_DrawRect0140AtBGMap13E0AndStep
    dw VaultMenu_Store_ToVaultMenu_Store_Case07_DrawRectSetTextCursorLoPlus21_Bank1D
    dw VaultMenu_Store_ToVaultMenu_Store_Case08_HLToDecimalDigits
    dw VaultMenu_Store_WriteCursorBlinkB8AndGlyphListPosEtc
    dw VaultMenu_Store_ToVaultMenu_Store_Case0A_WriteDigitsAndScreenByte93Etc
    dw VaultMenu_Store_ToVaultMenu_Store_Case0B_BlinkCursorSelectedRecord_Bank1D_4D41
    dw VaultMenu_Store_DrawRectBothBanksSetTextCursorLoPlus1C1_Case0C
    dw VaultMenu_Store_ToVaultMenu_Store_Case0D_BlinkCursorBlinkCD_Bank1D_4F99
    dw VaultMenu_Store_ReadScreenState
    dw VaultMenu_Store_InitItemListScreenListAndDraw
    dw VaultMenu_Store_DrawRectBothBanksSetTextCursorLoPlus1C1_Case10
    dw VaultMenu_Store_ToDrawRect0147AndResetNumberEditPos
    dw VaultMenu_Store_CopyTileBytesToVRAM_Bank1C
    dw VaultMenu_Store_ToVaultMenu_Store_Number24ToPackedBCD
    dw VaultMenu_Store_ToVaultMenu_Store_Case14_BGMapAddressAtScroll_Bank1D
    dw VaultMenu_Store_ToVaultMenu_Store_Case15_WriteScreenStepAndTwoChoiceCursorEtc
    dw ClearRect147AndAskTwoChoice
    dw VaultMenu_Store_DrawGoldDigitsAtHLWrapped_1C
    dw VaultMenu_Store_ClearRect147AndAskTwoChoice

; entry 0 of the `rst $00` table in VaultMenu_Store; also entry 0 of the table in VaultMenu_TakeOut
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Store_ToVaultMenu_Store_Case00_WaitForVRAMAccess::
Jump_01C_6F5D:: ; address name
    farcall VaultMenu_Store_Case00_WaitForVRAMAccess
    ret

; entry 1 of the `rst $00` table in VaultMenu_Store; also entry 1 of the table in VaultMenu_TakeOut
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
VaultMenu_Store_DrawRectBothBanksSetTextCursorLoPlus1C1::
Jump_01C_6F64:: ; address name
    call BGMapAddressAtScroll_Bank1C_67AF
    ld bc, $0B09
    ld de, vBGMap1 + $300
    call DrawRectBothBanksSetTextCursorLoPlus1C1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 2 of the `rst $00` table in VaultMenu_Store; also entry 2 of the table in VaultMenu_TakeOut
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenByteED, wScreenStep, wScriptCommandType, wScriptStartRequest
VaultMenu_Store_LoadThreeTilesAndDrawRows4603To460B::
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

; entry 3 of the `rst $00` table in VaultMenu_Store
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Store_ToVaultMenu_Store_Case03_WriteTwoChoiceCursorAndScreenStepEtc::
Jump_01C_6F93:: ; address name
    farcall VaultMenu_Store_Case03_WriteTwoChoiceCursorAndScreenStepEtc
    ret

; entry 4 of the `rst $00` table in VaultMenu_Store; also entry 4 of the table in VaultMenu_TakeOut
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenState, wScreenStep, wTwoChoiceCursor, wScreenByteED, wScriptCommandType, wScriptStartRequest
VaultMenu_Store_SetScreenState::
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

; entry 5 of the `rst $00` table in VaultMenu_Store; also entry 5 of the table in VaultMenu_TakeOut
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Store_ToDrawRect0088AtBGMap1370AndStep::
Jump_01C_6FB5:: ; address name
    farcall DrawRect0088AtBGMap1370AndStep
    ret

; entry 6 of the `rst $00` table in VaultMenu_Store; also entry 6 of the table in VaultMenu_TakeOut
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenCounter
; writes: wScreenCounter
VaultMenu_Store_DrawRect0140AtBGMap13E0AndStep::
Jump_01C_6FBC:: ; address name
    call VaultMenu_Store_WriteGlyphListPos
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp a, $04
    jr c, VaultMenu_Store_DrawRect0140AtBGMap13E0AndStep
    xor a, a
    ld [wScreenCounter], a
    farcall DrawRect0140AtBGMap13E0AndStep
    ret

; entry 9 of the `rst $00` table in VaultMenu_Store; also entry 9 of the table in VaultMenu_TakeOut
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState, wItemGridY, wScreenCounter, wCursorBlinkB8, wGlyphListPos, wScreenStep
; writes: wCursorBlinkB8, wGlyphListPos, wScreenCounter, wScreenStep
; points at: wItemStorage, wItemGrid
VaultMenu_Store_WriteCursorBlinkB8AndGlyphListPosEtc::
Jump_01C_6FD5:: ; address name
    call VaultMenu_Store_WriteGlyphListPos
    ld a, [wScreenState]
    cp a, $03
    jr z, .read_item_grid_y
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
    jr .skip

.read_item_grid_y:
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

.skip:
    add_a_to_hl
    ld e, [hl]
    ld d, $00
    sla e
    rl d
    ld hl, ItemNamesCopy_1C
    add hl, de
    ld e, [hl]
    inc hl
    ld a, [hl]
    ld h, a
    ld l, e

.skip2:
    ld a, [hl]
    cp a, $F0
    jp z, .clear_glyph_list_pos
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
    jr nc, .skip3
    inc d

.skip3:
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    ld a, [wCursorBlinkB8]
    cp a, $8D
    jr z, .check_glyph_list_pos
    cp a, $8E
    jr z, .check_glyph_list_pos
    jr .read_glyph_list_pos

.check_glyph_list_pos:
    ld a, [wGlyphListPos]
    dec a
    ld [wGlyphListPos], a

.read_glyph_list_pos:
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
    jr z, .call_or_from_bank_wait_vram
    cp a, $8E
    jr z, .call_or_from_bank_wait_vram
    call CopyFromBankWaitVRAM
    jr .check_glyph_list_pos2

.call_or_from_bank_wait_vram:
    call OrFromBankWaitVRAM

.check_glyph_list_pos2:
    pop hl
    inc hl
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    jp .skip2

.clear_glyph_list_pos:
    xor a, a
    ld [wGlyphListPos], a
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp a, $04
    jr c, .return
    xor a, a
    ld [wScreenCounter], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.return:
    ret

; entry 7 of the `rst $00` table in VaultMenu_Store; also entry 7 of the table in VaultMenu_TakeOut
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Store_ToVaultMenu_Store_Case07_DrawRectSetTextCursorLoPlus21_Bank1D::
Jump_01C_70B8:: ; address name
    farcall VaultMenu_Store_Case07_DrawRectSetTextCursorLoPlus21_Bank1D
    ret

; entry 8 of the `rst $00` table in VaultMenu_Store; also entry 8 of the table in VaultMenu_TakeOut
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Store_ToVaultMenu_Store_Case08_HLToDecimalDigits::
Jump_01C_70BF:: ; address name
    farcall VaultMenu_Store_Case08_HLToDecimalDigits
    ret

; entry 10 of the `rst $00` table in VaultMenu_Store; also entry 10 of the table in VaultMenu_TakeOut
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Store_ToVaultMenu_Store_Case0A_WriteDigitsAndScreenByte93Etc::
Jump_01C_70C6:: ; address name
    farcall VaultMenu_Store_Case0A_WriteDigitsAndScreenByte93Etc
    ret

; entry 11 of the `rst $00` table in VaultMenu_Store; also entry 11 of the table in VaultMenu_TakeOut
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Store_ToVaultMenu_Store_Case0B_BlinkCursorSelectedRecord_Bank1D_4D41::
Jump_01C_70CD:: ; address name
    farcall VaultMenu_Store_Case0B_BlinkCursorSelectedRecord_Bank1D_4D41
    ret

; entry 12 of the `rst $00` table in VaultMenu_Store; also entry 12 of the table in VaultMenu_TakeOut
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenStep, wScriptCommandType, wScriptStartRequest
VaultMenu_Store_DrawRectBothBanksSetTextCursorLoPlus1C1_Case0C::
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

; entry 13 of the `rst $00` table in VaultMenu_Store; also entry 13 of the table in VaultMenu_TakeOut
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Store_ToVaultMenu_Store_Case0D_BlinkCursorBlinkCD_Bank1D_4F99::
Jump_01C_7103:: ; address name
    farcall VaultMenu_Store_Case0D_BlinkCursorBlinkCD_Bank1D_4F99
    ret

; entry 14 of the `rst $00` table in VaultMenu_Store; also entry 14 of the table in VaultMenu_TakeOut
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenState
VaultMenu_Store_ReadScreenState::
Jump_01C_710A:: ; address name
    ld a, [wScreenState]
    cp a, $03
    jr z, .call_remove_item_count_from_inventory
    farcall VaultMenu_Store_Case0E_TenTimesNumberTensPlusNumberOnes
    ret

.call_remove_item_count_from_inventory:
    call RemoveItemCountFromInventory
    farcall VaultMenu_Store_Case0E_WriteTwoChoiceCursorAndTextCounter1Etc
    farcall VaultMenu_Store_Case0E_VaultMenu_Store_MapItemsToInventory
    ret

; entry 15 of the `rst $00` table in VaultMenu_Store; also entry 15 of the table in VaultMenu_TakeOut
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Store_InitItemListScreenListAndDraw::
Jump_01C_7128:: ; address name
    call InitItemListScreenListAndDraw
    farcall VaultMenu_Store_Case0F_WriteScreenStepAndScriptCommandTypeEtc
    ret

; entry 16 of the `rst $00` table in VaultMenu_Store; also entry 16 of the table in VaultMenu_TakeOut
; no direct call (reached through a table, a jump or a vector)
; writes: wTwoChoiceCursor, wScreenStep
VaultMenu_Store_DrawRectBothBanksSetTextCursorLoPlus1C1_Case10::
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

; entry 17 of the `rst $00` table in VaultMenu_Store; also entry 17 of the table in VaultMenu_TakeOut
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Store_ToDrawRect0147AndResetNumberEditPos::
Jump_01C_715C:: ; address name
    farcall DrawRect0147AndResetNumberEditPos
    ret

; entry 19 of the `rst $00` table in VaultMenu_Store; also entry 19 of the table in VaultMenu_TakeOut
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Store_ToVaultMenu_Store_Number24ToPackedBCD::
Jump_01C_7163:: ; address name
    farcall VaultMenu_Store_Number24ToPackedBCD
    ret

; entry 18 of the `rst $00` table in VaultMenu_Store; also entry 18 of the table in VaultMenu_TakeOut
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
; writes: wScreenStep
VaultMenu_Store_CopyTileBytesToVRAM_Bank1C::
Jump_01C_716A:: ; address name
    ld hl, vTiles1 + $4C0
    ld de, vTiles2 + $700
    call CopyTileBytesToVRAM_Bank1C
    ld hl, vTiles1 + $4C0
    ld de, Tiles1Plus4C0Tiles_1F_4500
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; entry 20 of the `rst $00` table in VaultMenu_Store; also entry 20 of the table in VaultMenu_TakeOut
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Store_ToVaultMenu_Store_Case14_BGMapAddressAtScroll_Bank1D::
Jump_01C_7188:: ; address name
    farcall VaultMenu_Store_Case14_BGMapAddressAtScroll_Bank1D
    ret

; entry 21 of the `rst $00` table in VaultMenu_Store
; no direct call (reached through a table, a jump or a vector)
VaultMenu_Store_ToVaultMenu_Store_Case15_WriteScreenStepAndTwoChoiceCursorEtc::
Jump_01C_718F:: ; address name
    farcall VaultMenu_Store_Case15_WriteScreenStepAndTwoChoiceCursorEtc
    ret

; clears the rectangle at scroll + $147, copies a tile, runs Func_01C_7252, wScreenStep = 3, wTwoChoiceCursor = 2 and requests script $80 (E-0124)
; 1 call site from 1 routine (e.g. VaultMenu_Store_ClearRect147AndAskTwoChoice)
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

; entry 23 of the `rst $00` table in VaultMenu_Store; also entry 23 of the table in VaultMenu_TakeOut
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptCommandType, wScriptStartRequest
; points at: wScreenList, wScreenBlock92
VaultMenu_Store_DrawGoldDigitsAtHLWrapped_1C::
Jump_01C_71C6:: ; address name
    ld hl, wScreenList
    ld de, ShopMenu_Buy_SubtractArg1AmountFromGold_Data
    ld bc, $0020

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld hl, wScreenBlock92
    call DrawGoldDigitsAtHLWrapped_1C
    call BGMapAddressAtScroll_Bank1C_67AF
    ld a, $0C
    add_a_to_hl
    ld de, wScreenList
    ld bc, $0802
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    farcall VaultMenu_Store_Number24ToPackedBCD
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; entry 24 of the `rst $00` table in VaultMenu_Store; also entry 24 of the table in VaultMenu_TakeOut
; no direct call (reached through a table, a jump or a vector)
; writes: wScreenState, wScreenStep
VaultMenu_Store_ClearRect147AndAskTwoChoice::
Jump_01C_7200:: ; address name
    call ClearRect147AndAskTwoChoice
    ld a, $01
    ld [wScreenState], a
    ld a, $02
    ld [wScreenStep], a
    ret

; taking out: lists wItemStorage and moves items back into wInventory (E-0276)
; no direct call (reached through a table, a jump or a vector)
; reads: wScreenStep
VaultMenu_TakeOut::
Jump_01C_720E:: ; address name
    ld a, [wScreenStep]
    rst $00
    dw VaultMenu_Store_ToVaultMenu_Store_Case00_WaitForVRAMAccess
    dw VaultMenu_Store_DrawRectBothBanksSetTextCursorLoPlus1C1
    dw VaultMenu_Store_LoadThreeTilesAndDrawRows4603To460B
    dw VaultMenu_TakeOut_Case03_WriteTwoChoiceCursorAndScreenStepEtc_Case03
    dw VaultMenu_Store_SetScreenState
    dw VaultMenu_Store_ToDrawRect0088AtBGMap1370AndStep
    dw VaultMenu_Store_DrawRect0140AtBGMap13E0AndStep
    dw VaultMenu_Store_ToVaultMenu_Store_Case07_DrawRectSetTextCursorLoPlus21_Bank1D
    dw VaultMenu_Store_ToVaultMenu_Store_Case08_HLToDecimalDigits
    dw VaultMenu_Store_WriteCursorBlinkB8AndGlyphListPosEtc
    dw VaultMenu_Store_ToVaultMenu_Store_Case0A_WriteDigitsAndScreenByte93Etc
    dw VaultMenu_Store_ToVaultMenu_Store_Case0B_BlinkCursorSelectedRecord_Bank1D_4D41
    dw VaultMenu_Store_DrawRectBothBanksSetTextCursorLoPlus1C1_Case0C
    dw VaultMenu_Store_ToVaultMenu_Store_Case0D_BlinkCursorBlinkCD_Bank1D_4F99
    dw VaultMenu_Store_ReadScreenState
    dw VaultMenu_Store_InitItemListScreenListAndDraw
    dw VaultMenu_Store_DrawRectBothBanksSetTextCursorLoPlus1C1_Case10
    dw VaultMenu_Store_ToDrawRect0147AndResetNumberEditPos
    dw VaultMenu_Store_CopyTileBytesToVRAM_Bank1C
    dw VaultMenu_Store_ToVaultMenu_Store_Number24ToPackedBCD
    dw VaultMenu_Store_ToVaultMenu_Store_Case14_BGMapAddressAtScroll_Bank1D
    dw VaultMenu_TakeOut_Case15_WriteScreenStepAndTwoChoiceCursorEtc_Case15
    dw ClearRect147AndAskTwoChoice
    dw VaultMenu_Store_DrawGoldDigitsAtHLWrapped_1C
    dw VaultMenu_Store_ClearRect147AndAskTwoChoice

; entry 3 of the `rst $00` table in VaultMenu_TakeOut
; no direct call (reached through a table, a jump or a vector)
VaultMenu_TakeOut_Case03_WriteTwoChoiceCursorAndScreenStepEtc_Case03::
Jump_01C_7244:: ; address name
    farcall VaultMenu_TakeOut_Case03_WriteTwoChoiceCursorAndScreenStepEtc
    ret

; entry 21 of the `rst $00` table in VaultMenu_TakeOut
; no direct call (reached through a table, a jump or a vector)
VaultMenu_TakeOut_Case15_WriteScreenStepAndTwoChoiceCursorEtc_Case15::
Jump_01C_724B:: ; address name
    farcall VaultMenu_TakeOut_Case15_WriteScreenStepAndTwoChoiceCursorEtc
    ret

; copies $20 bytes from Data_01C_5F5E to wScreenList, counts the inventory items into wListPages and its digits, and draws the 8 x 4 list at scroll + $0C (E-0127)
; 2 call sites from 2 routines (e.g. ClearRect147AndAskTwoChoice, VaultMenu_Store_InitItemListScreenListAndDraw)
; reads: wDigits
; writes: wListPages, wItemCountTens, wItemCountOnes
; points at: wScreenList, wScreenBlock92, wInventory
InitItemListScreenListAndDraw::
Func_01C_7252:: ; address name
    ld hl, wScreenList
    ld de, ShopMenu_Buy_SubtractArg1AmountFromGold_Data
    ld bc, $0020

.loop:
    ld a, [de]
    ld [hl+], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, .loop
    ld hl, wScreenBlock92
    call DrawGoldDigitsAtHLWrapped_1C
    ld hl, wInventory
    ld c, $00
    ld b, $00

.loop2:
    ld a, [hl+]
    and a, a
    jr z, .next
    cp a, $FF
    jr z, .next
    inc b

.next:
    inc c
    ld a, c
    cp a, $18
    jr c, .loop2
    ld a, b
    ld [wListPages], a
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld a, [wDigits + $1]
    and a, a
    jr z, .read_digits
    ld a, [wDigits + $1]
    add a, $E0
    ld [wItemCountTens], a

.read_digits:
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

; only called from routines of VaultMenu_Store (E-0098)
; 2 call sites from 2 routines (e.g. VaultMenu_Store_WriteCursorBlinkB8AndGlyphListPosEtc, VaultMenu_Store_DrawRect0140AtBGMap13E0AndStep)
; reads: wScreenCounter, wGlyphListPos
; writes: wGlyphListPos
VaultMenu_Store_WriteGlyphListPos::
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

.loop:
    push de
    ld a, [wGlyphListPos]
    sla a
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
    ld de, Tiles2Plus710Tiles_1F_4910
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    cp a, $09
    jr c, .loop
    xor a, a
    ld [wGlyphListPos], a
    ret
    ds $D10, $00
