; ROM bank $1C: shops, the vault and the inn; item names
; The annotated listing of this bank is build/listing/bank1c.asm.

SECTION "Bank 1C", ROMX[$4000], BANK[$1C]
    db $1c

; implements script command type E1 (SCRIPT_INN_CLOSE): ends the inn session and clears
; wMessageMode; reached through ScriptCommandE1 in bank $10 (E-0038, E-0244)
CloseInnMenu::
    ld hl, wScreenTileBuffer
    ld de, wWindowTileBuffer + $a0
    ld bc, $00a0
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a
    jr z, .skip
    ld hl, wScreenAttrBuffer
    ld de, wWindowAttrBuffer + $a0
    ld bc, $00a0
    call CopyLow3BitsToWRAMBank2_Bank1C

.skip:
    ld hl, wWindowTileBuffer
    ld de, wWindowTileBuffer + $a0
    ld bc, $00a0
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a
    jr z, .call_bg_map_address_at_scroll_bank1_c
    ld hl, wWindowAttrBuffer
    ld de, wWindowAttrBuffer + $a0
    ld bc, $00a0
    call CopyLow3BitsToWRAMBank2_Bank1C

.call_bg_map_address_at_scroll_bank1_c:
    call BGMapAddressAtScroll_Bank1C
    lb bc, $14, $08
    ld de, $0168
    call DrawScreenBufferRectToBGMap_1C
    ld bc, $001a
    ld hl, wScreenState

.loop:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    farcall WritePlayerNameWithFlag0SuffixToTextBuf0
    xor a
    ld [wMessageMode], a
    ld [wScreenState], a
    ld [wMenuState], a
    ld a, $07
    ld [wFadeMode], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type E0 (SCRIPT_INN): the inn: 'It's 0G a night. Will you...', 'Good
; morning and farewell!' (mode 1, bank $F0 strings); reached through ScriptCommandE0 in bank $10
; (E-0038, E-0244) (C2 from E-0327: the Kalka inn's stay costs 10G and runs it)
InnMenu::
    ld a, [wScreenState]
    jumptable
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
InnMenu_Init::
    ld bc, $001a
    ld hl, wScreenState

.loop:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld hl, wWindowTileBuffer
    ld de, wScreenTileBuffer
    ld bc, $00a0
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a
    jr z, .skip
    ld hl, wWindowAttrBuffer
    ld de, wScreenAttrBuffer
    ld bc, $00a0
    call CopyLow3BitsToWRAMBank2_Bank1C

.skip:
    ld hl, wWindowTileBuffer + $a0
    ld de, wScreenTileBuffer
    ld bc, $00a0
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a
    jr z, .call_inn_menu_init_write_arg7_and_arg8_etc
    ld hl, wWindowAttrBuffer + $a0
    ld de, wScreenAttrBuffer
    ld bc, $00a0
    call CopyLow3BitsToWRAMBank2_Bank1C

.call_inn_menu_init_write_arg7_and_arg8_etc:
    call InnMenu_Init_WriteArg7AndArg8Etc
    ld a, $01
    ld [wMessageMode], a
    ld hl, wScreenState
    inc [hl]
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; draws the gold window (DrawGoldDigitsAtHLWrapped_1C) for 'It's 0G a night' (E-0276)
InnMenu_ShowPrice::
    ld hl, wScreenSubStep
    ld de, InnMenu_ShowPrice_Data
    ld c, $00

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    inc c
    ld a, c
    cp $18
    jr c, .loop
    ld hl, wScreenArea
    call DrawGoldDigitsAtHLWrapped_1C
    ld a, [wTextWindowState]
    bit 7, a
    jr nz, .skip
    ld de, wScreenSubStep
    ld hl, wWindowTileBuffer + $c
    lb bc, $08, $03
    call CopyRectTo20ByteRowsJp_Bank1C
    ld de, wScreenSubStep
    ld hl, wScreenTileBuffer + $c
    lb bc, $08, $03
    call CopyRectTo20ByteRowsJp_Bank1C
    jr .call_bg_map_address_at_scroll_bank1_c

.skip:
    ld de, wScreenSubStep
    ld hl, wWindowTileBuffer + $70
    lb bc, $08, $03
    call CopyRectTo20ByteRowsJp_Bank1C
    ld de, wScreenSubStep
    ld hl, wScreenTileBuffer + $70
    lb bc, $08, $03
    call CopyRectTo20ByteRowsJp_Bank1C

.call_bg_map_address_at_scroll_bank1_c:
    call BGMapAddressAtScroll_Bank1C
    lb bc, $14, $08
    ld de, $0168
    call DrawScreenBufferRectToBGMap_1C
    xor a
    ld [wMenuState], a
    ld hl, wScreenState
    inc [hl]
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

InnMenu_ShowPrice_Data::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2, $b6, $bf, $c3, $c3, $c3, $c3, $c3, $b7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5

; checks the price against the gold (IsAmountInArg1AboveGold) and redraws the gold (E-0276)
InnMenu_Pay::
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
    cp $ff
    jr z, .restore
    pop hl
    pop de
    xor a
    ld [wTextYesNoResult], a
    ld [wMenuState], a
    call InnMenu_Pay_WriteGoldHiAndGoldMidEtc
    call InnMenu_Pay_CopyBytesDEToHL_Bank1C
    call InnMenu_Pay_DrawGoldDigitsAtHLWrapped_1C
    ld hl, wScreenState
    inc [hl]
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.restore:
    pop hl
    pop de
    ld a, $01
    ld [wTextYesNoResult], a
    xor a
    ld [wMenuState], a
    ld hl, wScreenState
    inc [hl]
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; starts a palette fade (StartPaletteFade) for the night (E-0276)
InnMenu_FadeOut::
    ld a, $87
    ld [wFadeMode], a
    ld a, $04
    call StartPaletteFade
    ld hl, wScreenState
    inc [hl]
    ret

; waits until wFadeState is 0, then advances wScreenState (E-0276)
InnMenu_WaitFade::
    ld a, [wFadeState]
    or a
    ret nz
    ld hl, wScreenState
    inc [hl]
    ret

InnMenu_AdvanceScreenState::
    ld hl, wScreenState
    inc [hl]
    ret

; for each wPartyList record whose byte $55 bit 7 is clear, copies max HP ($5D) to HP ($5B) and max
; MP ($61) to MP ($5F) (E-0276) (C2 from E-0327: a stay turns HP 5/21 and MP 7/35 into 21/21 and
; 35/35)
InnMenu_RestoreParty::
    ld a, [wPartyCount]
    and a
    jp z, .skip
    ld c, a
    ld hl, wPartyList
    ld a, $0a
    ld [rRAMG2], a
    xor a
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
    ld a, [hli]
    ld [wArg5], a
    ld a, [hli]
    ld [wArg6], a
    inc hl
    inc hl
    ld a, [hli]
    ld [wArg7], a
    ld a, [hl]
    ld [wArg8], a
    pop hl
    push hl
    ld a, [hl]
    ld c, MON_HP
    call SRAMRecordAddress
    ld a, [wArg5]
    ld [hli], a
    ld a, [wArg6]
    ld [hli], a
    inc hl
    inc hl
    ld a, [wArg7]
    ld [hli], a
    ld a, [wArg8]
    ld [hl], a

.restore:
    pop hl
    pop bc
    inc hl
    dec c
    ld a, c
    and a
    jp nz, .loop
    xor a
    ld [rRAMG2], a

.skip:
    ld hl, wScreenState
    inc [hl]
    ld a, $40
    call QueueMusic
    ret

; after $90 frames sends the SGB palette set, fades back in and refreshes the town/key-world objects
; (E-0276)
InnMenu_Morning::
    ld hl, wScreenStep
    inc [hl]
    ld a, [wScreenStep]
    cp $90
    ret c
    xor a
    ld [wScreenStep], a
    call SendSGBPaletteSetForSGBPaletteSet
    ld a, $87
    ld [wFadeMode], a
    ld a, $f8
    call StartPaletteFade
    ld hl, wScreenState
    inc [hl]
    xor a
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
InnMenu_RestartMusic::
    ld a, [wFadeState]
    or a
    ret nz
    farcall RestartMapMusic
    ld a, $07
    ld [wFadeMode], a
    ld hl, wScreenState
    inc [hl]
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; when the Super Game Boy is active, sets the four palette numbers 4 * wSGBPaletteSet + 0-3, sends a
; PAL_SET ($B1) packet with attribute file wSGBAttrFile, waits, and loads the object palettes
; (E-0121)
SendSGBPaletteSetForSGBPaletteSet::
    ld a, [wSGBActive]
    and a
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
    ld a, $b1
    ld [wSGBPacketBuffer], a
    ld a, [wSGBAttrFile]
    ld [wSGBPacketBuffer + $1], a
    ld a, $ff
    ld [wSGBPacketIndex], a
    farcall_b SendSGBPacketSet
    call SpinDelay
    farcall LoadSGBObjectPalettesFromPointers
    ret

; With rSVBK = 2, copies BC bytes from [DE] to [HL], each ANDed with $07; then rSVBK = 0 (the same
; 19 bytes appear in 5 banks)
CopyLow3BitsToWRAMBank2_Bank1C::
    ld a, $02
    ldh [rSVBK], a

.loop:
    ld a, [de]
    and $07
    inc de
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld a, $00
    ldh [rSVBK], a
    ret

; DE = source, HL = destination, BC = count: copies BC bytes (BC = 0 copies 65536); DE and HL end
; past the copy; clobbers A, BC = 0 (E-0064) (the same 9 bytes appear in 13 banks)
CopyBytesDEToHL_Bank1C::
    ld a, [de]
    inc de
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, CopyBytesDEToHL_Bank1C
    ret

; the same instructions as CopyRectTo20ByteRowsJp_Bank24: copies a B x C rectangle from DE to HL
; with rows 20 bytes apart; on CGB zero-fills the same rectangle at HL + $0E68 with rSVBK = 2
; (E-0073)
CopyRectTo20ByteRowsJp_Bank1C::
    push hl
    push bc

.loop:
    push hl
    push bc

.loop2:
    ld a, [de]
    inc de
    ld [hli], a
    dec b
    jr nz, .loop2
    pop bc
    pop hl
    ld a, l
    add $14
    ld l, a
    ld a, h
    adc $00
    ld h, a
    dec c
    jp nz, .loop
    pop bc
    pop hl
    ld a, [wIsCGB]
    or a
    ret z
    ld a, l
    add $68
    ld l, a
    ld a, h
    adc $0e
    ld h, a
    ld a, $02
    ldh [rSVBK], a

.loop3:
    push hl
    push bc

.loop4:
    xor a
    ld [hli], a
    dec b
    jr nz, .loop4
    pop bc
    pop hl
    ld a, l
    add $14
    ld l, a
    ld a, h
    adc $00
    ld h, a
    dec c
    jp nz, .loop3
    ld a, $00
    ldh [rSVBK], a
    ret

; with story flag 2, no text, wFieldActionRequest bit 7 clear, a non-empty party and
; hPlayerStateFlags bit 0 clear: hSpriteWindowClipMode = 3, sets bit 1 of the player and object
; flags and returns A = $FF; otherwise 0 (E-0124)
TryStartFieldMenu::
    ld de, $0002
    call TestFlagBit
    jr nc, .return_0
    ld a, [wTextWindowState]
    and $03
    jr nz, .return_0
    ld a, [wFieldActionRequest]
    bit 7, a
    jr nz, .return_0
    ld a, [wPartyCount]
    or a
    jr z, .return_0
    ldh a, [hPlayerStateFlags]
    bit 0, a
    jr nz, .return_0
    ld a, $03
    ldh [hSpriteWindowClipMode], a
    farcall SetBit1OfPlayerAndObjectFlags
    ld a, $ff
    ret

.return_0:
    xor a
    ret

; writes the gold as up to five decimal digit tiles without leading zeros at HL in VRAM, wrapping at
; the row end (E-0128)
DrawGoldDigitsAtHLWrapped_1C::
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
    or a
    jp nz, .call_write_vram_byte
    bit 0, c
    jp z, .next

.call_write_vram_byte:
    add $e0
    call WriteVRAMByte
    ld c, $01

.next:
    inc hl
    ld a, l
    and $1f
    jp nz, .skip
    ld a, l
    sub $20
    ld l, a
    ld a, h
    sbc $00
    ld h, a

.skip:
    ld a, b
    dec a
    jp nz, .skip2
    ld c, $01

.skip2:
    ld a, [de]
    dec de
    and $0f
    jp nz, .call_write_vram_byte2
    bit 0, c
    jp z, .next2

.call_write_vram_byte2:
    add $e0
    call WriteVRAMByte
    ld c, $01

.next2:
    inc hl
    ld a, l
    and $1f
    jp nz, .next3
    ld a, l
    sub $20
    ld l, a
    ld a, h
    sbc $00
    ld h, a

.next3:
    dec b
    jr nz, .loop
    ret

; compares the 24-bit value wArg3:wArg2:wArg1 (wArg3 most significant) with
; wGoldHi:wGoldMid:wGoldLo: wArg1 = $FF when it is greater, 0 when it is less or equal (the low byte
; is overwritten with the result) (E-0073)
IsAmountInArg1AboveGold::
    ld a, [wGoldHi]
    ld b, a
    ld a, [wArg3]
    cp b
    jr z, .read_gold_mid
    jr c, .clear_arg1
    jr .set_arg1_to_FF

.read_gold_mid:
    ld a, [wGoldMid]
    ld b, a
    ld a, [wArg2]
    cp b
    jr z, .read_gold_lo
    jr c, .clear_arg1
    jr .set_arg1_to_FF

.read_gold_lo:
    ld a, [wGoldLo]
    ld b, a
    ld a, [wArg1]
    cp b
    jr z, .clear_arg1
    jr c, .clear_arg1

.set_arg1_to_FF:
    ld a, $ff
    ld [wArg1], a
    ret

.clear_arg1:
    xor a
    ld [wArg1], a
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX,
; hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
BGMapAddressAtScroll_Bank1C::
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

InnMenu_Init_WriteArg7AndArg8Etc::
    ld hl, wDigits
    xor a
    ld [hli], a
    ld a, $01
    ld [hli], a
    xor a
    ld [hl], a
    ld l, $0a
    ld h, $00
    xor a
    ld [wArg7], a
    ld a, h
    ld [wArg8], a
    ld a, l
    ld [wMenuInputResult], a
    ld hl, wDigits
    ld de, wTextBuf0
    ld c, $03
    ld a, [hl]
    and a
    jr nz, .skip
    inc hl
    dec c
    ld a, [hl]
    and a
    jr nz, .skip
    inc hl
    dec c

.skip:
    ld a, c
    and a
    jr z, .done
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr .skip

.done:
    ld a, $f0
    ld [de], a
    ret

; copies a rectangle of the screen buffer (offset DE) to the BG map at HL, sets wTextCursorLo = HL +
; $1C1, and on CGB copies its attributes (E-0127)
DrawScreenBufferRectToBGMap_1C::
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

InnMenu_Pay_WriteGoldHiAndGoldMidEtc::
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
    sub l
    ld c, a
    ld a, b
    sbc h
    ld b, a
    ld a, d
    sbc e
    ld [wGoldHi], a
    ld a, b
    ld [wGoldMid], a
    ld a, c
    ld [wGoldLo], a
    ret

InnMenu_Pay_CopyBytesDEToHL_Bank1C::
    ld hl, wWindowTileBuffer
    ld de, wWindowTileBuffer + $a0
    ld bc, $00a0
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a
    ret z
    ld hl, wWindowAttrBuffer
    ld de, wWindowAttrBuffer + $a0
    ld bc, $00a0
    call CopyLow3BitsToWRAMBank2_Bank1C
    ret

InnMenu_Pay_DrawGoldDigitsAtHLWrapped_1C::
    ld hl, wScreenSubStep
    ld de, InnMenu_Pay_DrawGoldDigitsAtHLWrapped_1C_Data
    ld c, $00

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    inc c
    ld a, c
    cp $18
    jr c, .loop
    ld hl, wScreenArea
    call DrawGoldDigitsAtHLWrapped_1C
    ld a, [wTextWindowState]
    bit 7, a
    jr nz, .skip
    ld de, wScreenSubStep
    ld hl, wWindowTileBuffer + $c
    lb bc, $08, $03
    call CopyRectTo20ByteRowsJp_Bank1C
    ld de, wScreenSubStep
    ld hl, wScreenTileBuffer + $c
    lb bc, $08, $03
    call CopyRectTo20ByteRowsJp_Bank1C
    jr .call_bg_map_address_at_scroll_bank1_c

.skip:
    ld de, wScreenSubStep
    ld hl, wWindowTileBuffer + $70
    lb bc, $08, $03
    call CopyRectTo20ByteRowsJp_Bank1C
    ld de, wScreenSubStep
    ld hl, wScreenTileBuffer + $70
    lb bc, $08, $03
    call CopyRectTo20ByteRowsJp_Bank1C

.call_bg_map_address_at_scroll_bank1_c:
    call BGMapAddressAtScroll_Bank1C
    lb bc, $14, $08
    ld de, $0168
    call DrawScreenBufferRectToBGMap_1C
    ret

InnMenu_Pay_DrawGoldDigitsAtHLWrapped_1C_Data::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2, $b6, $bf, $c3, $c3, $c3, $c3, $c3, $b7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5

; adds the 24-bit wArg1-wArg3 to the gold, capped at 99,999 ($01869F) (E-0127) (C2 from E-0327:
; selling a Herb at 99,999 gold leaves 99,999)
AddArg1ToGoldCapped99999::
    ld a, [wGoldLo]
    ld e, a
    ld a, [wGoldMid]
    ld d, a
    ld a, [wGoldHi]
    ld h, a
    ld a, [wArg1]
    add e
    ld c, a
    ld a, [wArg2]
    adc d
    ld b, a
    ld a, [wArg3]
    adc h
    ld h, a
    ld a, h
    cp $02
    jr nc, .set_gold_hi_to_01
    cp $01
    jr c, .set_gold_hi
    ld a, b
    cp $87
    jr nc, .set_gold_hi_to_01
    cp $86
    jr c, .set_gold_hi
    ld a, c
    cp $a1
    jr nc, .set_gold_hi_to_01
    cp $a0
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
    ld a, $9f
    ld [wGoldLo], a
    ret

; implements script command type E3 (SCRIPT_SHOP_CLOSE): ends the shop session ('Thank you! Please
; come again.' between its two calls) and clears wMessageMode; reached through ScriptCommandE3 in
; bank $10 (E-0038, E-0244)
CloseShopMenu::
    ld a, [wGridCursorY]
    jumptable
    dw CloseShopMenu_ToCloseShopMenu_Case00_CopyBytesDEToHL_Bank1C
    dw CloseShopMenu_ToCloseShopMenu_Case01_SetGlyphListPos
    dw CloseShopMenu_DecompressToVRAM
    dw CloseShopMenu_DrawRecordListNameTiles_Bank1D

CloseShopMenu_ToCloseShopMenu_Case00_CopyBytesDEToHL_Bank1C::
    call CloseShopMenu_Case00_CopyBytesDEToHL_Bank1C
    ret

CloseShopMenu_ToCloseShopMenu_Case01_SetGlyphListPos::
    call CloseShopMenu_Case01_SetGlyphListPos
    ret

CloseShopMenu_DecompressToVRAM::
    ld b, $46
    ld de, Tiles1Gfx_46_4001
    ld hl, vTiles1
    call DecompressToVRAM
    ld hl, vTiles1 + $500
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld hl, $0f01
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

CloseShopMenu_DrawRecordListNameTiles_Bank1D::
    farcall DrawRecordListNameTiles_Bank1D
    farcall LoadTilesForPartyRecords
    xor a
    ld [wMessageMode], a
    ld [wGridCursorY], a
    ld bc, $0070
    ld hl, wScreenState

.loop:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld hl, wTextBuf0
    ld b, $10

.loop2:
    ld a, $f0
    ld [hli], a
    dec b
    jr nz, .loop2
    farcall WritePlayerNameWithFlag0SuffixToTextBuf0
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type E2 (SCRIPT_SHOP): the shop: 'What would you like to buy?', 'That
; comes to 0G. OK?'; reads ShopItemListTable and ItemValueTable (mode 2); reached through
; ScriptCommandE2 in bank $10 (E-0038, E-0244) (C2 from E-0327: GreatLog's merchant opens it with
; Buy / Sell / Exit)
ShopMenu::
    ld a, [wScreenState]
    jumptable
    dw ShopMenu_Init
    dw ShopMenu_Setup
    dw ShopMenu_ChooseAction
    dw ShopMenu_Buy
    dw ShopMenu_Sell

; clears $70 bytes from wScreenState (state 0 of ShopMenu) (E-0276)
ShopMenu_Init::
    ld bc, $0070
    ld hl, wScreenState

.loop:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a
    jr z, .set_message_mode_to_02
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank1C

.set_message_mode_to_02:
    ld a, $02
    ld [wMessageMode], a
    xor a
    ld [wGlyphListPos], a
    ld [wScreenCounter], a
    ld [wNumberTens], a
    ld a, $01
    ld [wNumberOnes], a
    ld [wNumberEditPos], a
    ld hl, wScreenState
    inc [hl]
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; screen setup steps (tile lists, item list screen) (E-0276)
ShopMenu_Setup::
    ld a, [wScreenStep]
    jumptable
    dw ShopMenu_Setup_AdvanceScreenStep
    dw ShopMenu_Setup_ToCopyTileListFromBank1F_1C
    dw ShopMenu_Setup_ToInitItemListScreenListAndCount
    dw ShopMenu_Setup_DrawScreenListBoxAtWC370AndStep
    dw ShopMenu_Setup_SetScreenStep

; increments wScreenStep
ShopMenu_Setup_AdvanceScreenStep::
    ld hl, wScreenStep
    inc [hl]

ShopMenu_Setup_ToCopyTileListFromBank1F_1C::
    ld hl, TileCopyDestList_1C_5F86
    ld de, TileCopySrcList_1C_5FE8
    call CopyTileListFromBank1F_1C
    ret

ShopMenu_Setup_ToInitItemListScreenListAndCount::
    call InitItemListScreenListAndCount
    ret

ShopMenu_Setup_DrawScreenListBoxAtWC370AndStep::
    ld de, TileRect_1C_4738
    ld hl, wWindowTileBuffer + $64
    lb bc, $08, $07
    call CopyRectTo20ByteRowsJp_Bank1C
    call DrawScreenListBoxAtWC370AndStep
    xor a
    ld [wScreenStep], a
    ld [wTwoChoiceCursor], a
    ld hl, wScreenState
    inc [hl]
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 8 x 7 tiles, one row per line
TileRect_1C_4738::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $ea, $eb, $ec, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $ed, $cf, $ef, $ef, $c3, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $a9, $ab, $ac, $ad, $c3, $b7 ; id 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 6

ShopMenu_Setup_SetScreenStep::
    xor a
    ld [wScreenStep], a
    ld [wTwoChoiceCursor], a
    ld hl, wScreenState
    inc [hl]
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; the shop's choice menu: Up/Down move the cursor, A selects, B leaves (E-0276)
ShopMenu_ChooseAction::
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
    and a
    jr nz, .skip
    ld a, $02

.set_list_last_row:
    ld [wListLastRow], a
    xor a
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
    cp $02
    jr c, .skip2
    xor a
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
    cp b
    jr z, .set_screen_byte_b2
    ld a, [wListLastRow]
    ld b, a
    xor a
    ld [wItemGridX], a
    ld [wItemGridY], a

.set_screen_byte_b2:
    ld a, b
    ld [wScreenByteB2], a
    ld a, [wListLastRow]
    and a
    jr z, .check_list_pages
    cp $01
    jr z, .check_list_pages2

.clear_script_command_type:
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_list_pages:
    ld a, [wListPages]
    cp $18
    jr c, .check_screen_state

.check_screen_state:
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a
    ld [wTextTimer], a
    jp .clear_script_command_type

.check_list_pages2:
    ld a, [wListPages]
    and a
    jr nz, .set_two_choice_cursor_to_01
    ld a, $04
    ld [wTwoChoiceCursor], a
    jp .clear_script_command_type

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, [wScreenState]
    add $02
    ld [wScreenState], a
    xor a
    ld [wTextTimer], a
    jp .clear_script_command_type

.set_two_choice_cursor_to_02:
    ld a, $02
    ld [wTwoChoiceCursor], a
    jp .clear_script_command_type

ShopMenu_ChooseAction_WriteScreenByteB3::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, ShopMenu_ChooseAction_ReadListLastRow
    ld a, [wScreenByteB3]
    inc a
    ld [wScreenByteB3], a
    cp $10
    jr c, ShopMenu_ChooseAction_ReadListLastRow
    cp $18
    jr c, ShopMenu_ChooseAction_ReadListLastRow_Sub03
    xor a
    ld [wScreenByteB3], a

ShopMenu_ChooseAction_ReadListLastRow::
    ld b, $bb
    jr ShopMenu_ChooseAction_StepBGMapAddressBackOnScrollWrap_ReadListLastRow

ShopMenu_ChooseAction_ReadListLastRow_Sub03::
    ld b, $c3
    jr ShopMenu_ChooseAction_StepBGMapAddressBackOnScrollWrap_ReadListLastRow

ShopMenu_ChooseAction_StepBGMapAddressBackOnScrollWrap::
    ld b, $bc

ShopMenu_ChooseAction_StepBGMapAddressBackOnScrollWrap_ReadListLastRow::
    ld a, [wListLastRow]
    add a
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

ShopMenu_ChooseAction_StepBGMapAddressBackOnScrollWrap_Data::
    db $21, $00, $61, $00, $a1, $00

; buying: items from ShopItemListTable for wScreenTableIndex, a gold check (IsAmountInArg1AboveGold)
; and SubtractArg1AmountFromGold (E-0276)
ShopMenu_Buy::
    ld a, [wScreenStep]
    jumptable
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

ShopMenu_Buy_WriteVBKAndScreenStep::
    ld hl, ShopMenu_Buy_WriteVBKAndScreenStep_Data
    ld de, vBGMap1 + $300

.skip:
    ld a, [hl]
    cp $7f
    jr z, .check_is_cgb
    di

.loop:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop
    ld a, [hli]
    ld [de], a
    ei
    inc de
    jr .skip

.check_is_cgb:
    ld a, [wIsCGB]
    and a
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
    xor a
    ld [hli], a
    ld [hli], a
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

ShopMenu_Buy_DrawRectBothBanksSetTextCursorLoPlus1C1::
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0081
    add hl, de
    lb bc, $13, $09
    ld de, vBGMap1 + $300
    call DrawRectBothBanksSetTextCursorLoPlus1C1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

ShopMenu_Buy_LoadArg1PointerForScreenTableIndex::
    call LoadArg1PointerForScreenTableIndex
    ld c, $00

.skip:
    ld a, [hl]
    cp $ff
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
    and a
    jr z, .set_saved_field_draw_flags
    inc l

.set_saved_field_draw_flags:
    ld a, l
    ld [wSavedFieldDrawFlags], a
    ld a, [wItemGridY]
    inc a
    cp l
    jr c, .set_choice_cursor_f0_to_03
    pop af
    push af
    and a
    jr nz, .set_choice_cursor_f0
    ld a, [wItemGridY]
    inc a
    cp l
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
    cp b
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
    cp $02
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
    add $e0
    ld [hl], a
    ei
    ld a, [wItemGridY]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $018f
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $2]
    add $e1
    ld [hl], a
    ei

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScreenCounter], a
    ld [wGlyphListPos], a
    ret

ShopMenu_Buy_WriteGlyphListPosAndCursorBlinkB8Etc::
    ld a, [wScreenCounter]
    add a
    ld hl, TileDestTable_1C_6289
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]

.loop:
    push de
    ld a, [wGlyphListPos]
    add a
    add e
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
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    cp $09
    jr c, .loop
    xor a
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
    cp $ff
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
    cp $f0
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
    add a
    ld de, TileDestTable_1C_6289
    add e
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
    cp $8d
    jr z, .check_glyph_list_pos
    cp $8e
    jr z, .check_glyph_list_pos
    jr .read_glyph_list_pos

.check_glyph_list_pos:
    ld a, [wGlyphListPos]
    dec a
    ld [wGlyphListPos], a

.read_glyph_list_pos:
    ld a, [wGlyphListPos]
    add a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    ld b, $1f
    ld c, $10
    ld a, [wCursorBlinkB8]
    cp $8d
    jr z, .call_or_from_bank_wait_vram
    cp $8e
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
    xor a
    ld [wGlyphListPos], a
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp $04
    jr c, .return
    xor a
    ld [wScreenCounter], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    ret

.return:
    ret

ShopMenu_Buy_AdvanceScreenStep::
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

ShopMenu_Buy_LoadArg1PointerForScreenTableIndex_Case05::
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
    cp $ff
    jr nz, .skip
    ld a, $e3
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
    ld b, $f2
    call ReadFarPointerAtDEInBankB
    ld a, l
    ld [wDigits], a
    ld a, h
    ld [wDigits + $1], a
    ld a, b
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    farcall UnpackBCDToDigitsArg1_Bank1E
    ld a, $df
    ld [wArg8], a

.read_screen_counter:
    ld hl, ShopMenu_Buy_LoadArg1PointerForScreenTableIndex_Case05_Data
    ld a, [wScreenCounter]
    add a
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
    xor a
    ld [wScreenByteEE], a
    ld hl, wArg3
    ld c, $00

.loop2:
    ld a, [wScreenByteEE]
    and a
    jr nz, .call_wait_for_vram_access
    push hl
    ld l, e
    ld h, d
    call StepBGMapAddressBackOnScrollWrap
    cp $ff
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
    ld a, [hli]
    add $e0
    ld [de], a
    inc de
    ei
    inc c
    ld a, c
    cp $06
    jr c, .loop2
    xor a
    pop hl
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp $04
    jp c, .loop
    xor a
    ld [wScreenCounter], a
    ld [wGlyphListPos], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

ShopMenu_Buy_BlinkCursorSelectedRecord_Bank1C::
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
    cp $03
    ret c
    ld a, [wJoypadPressed]
    bit 1, a
    ret z
    call ResetTextCounter0Counters
    xor a
    ld [wTextTimer], a
    ld a, $01
    ld [wScreenState], a
    ld a, $01
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_saved_field_draw_flags:
    ld a, [wSavedFieldDrawFlags]
    cp $02
    jr c, .loop
    call EraseItemGridXCursor
    call ResetTextCounter0Counters
    ld a, [wSavedFieldDrawFlags]
    ld b, a
    ld a, [wItemGridY]
    inc a
    cp b
    jr c, .set_item_grid_y
    xor a

.set_item_grid_y:
    ld [wItemGridY], a
    ld a, $02
    ld [wScreenStep], a

.loop:
    xor a
    ld [wSelectedRecord], a
    call DrawItemGridXCursor
    ld a, $69
    call QueueSoundEffect
    ret

.check_saved_field_draw_flags2:
    ld a, [wSavedFieldDrawFlags]
    cp $02
    jr c, .loop
    call EraseItemGridXCursor
    call ResetTextCounter0Counters
    ld a, [wItemGridY]
    and a
    jr nz, .skip
    ld a, [wSavedFieldDrawFlags]
    dec a
    jp .set_item_grid_y

.skip:
    dec a
    jp .set_item_grid_y

.check_choice_cursor_f0:
    ld a, [wChoiceCursorF0]
    and a
    jr z, .loop2
    call ResetTextCounter0Counters
    call EraseItemGridXCursor
    ld a, [wItemGridX]
    and a
    jr nz, .set_item_grid_x
    ld a, [wChoiceCursorF0]
    jr .set_item_grid_x2

.set_item_grid_x:
    dec a

.set_item_grid_x2:
    ld [wItemGridX], a

.loop2:
    xor a
    ld [wSelectedRecord], a
    call DrawItemGridXCursor
    ld a, $69
    call QueueSoundEffect
    ret

.check_choice_cursor_f02:
    ld a, [wChoiceCursorF0]
    and a
    jr z, .loop2
    call ResetTextCounter0Counters
    call EraseItemGridXCursor
    ld a, [wChoiceCursorF0]
    ld b, a
    ld a, [wItemGridX]
    cp b
    jr c, .skip2
    xor a
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

; cycles wSelectedRecord through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3)
; for $10-$17 (cursor drawn by DrawItemGridXCursor / EraseItemGridXCursor) (E-0122)
BlinkCursorSelectedRecord_Bank1C::
    ld a, [wSelectedRecord]
    inc a
    ld [wSelectedRecord], a
    cp $10
    jr c, DrawItemGridXCursor
    cp $18
    jr c, EraseItemGridXCursor
    xor a
    ld [wSelectedRecord], a

; writes the cursor tile $BB at the position for wItemGridX (0-3; BG map offsets $00A2, $00E2,
; $0122, $0162 from the scroll origin, DrawItemGridXCursorConfirmed_Data), via
; StepBGMapAddressBackOnScrollWrap and WaitForVRAMAccess (E-0074)
DrawItemGridXCursor::
    ld b, $bb
    jr DrawItemGridXCursorConfirmed_ReadItemGridX

; writes the blank tile $C3 at the position for wItemGridX (0-3; BG map offsets $00A2, $00E2, $0122,
; $0162 from the scroll origin, DrawItemGridXCursorConfirmed_Data), via
; StepBGMapAddressBackOnScrollWrap and WaitForVRAMAccess (E-0074)
EraseItemGridXCursor::
    ld b, $c3
    jr DrawItemGridXCursorConfirmed_ReadItemGridX

; writes the confirmed-cursor tile $BC at the position for wItemGridX (0-3; BG map offsets $00A2,
; $00E2, $0122, $0162 from the scroll origin, DrawItemGridXCursorConfirmed_Data), via
; StepBGMapAddressBackOnScrollWrap and WaitForVRAMAccess (E-0074)
DrawItemGridXCursorConfirmed::
    ld b, $bc

DrawItemGridXCursorConfirmed_ReadItemGridX::
    ld a, [wItemGridX]
    add a
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

DrawItemGridXCursorConfirmed_Data::
    db $a2, $00, $e2, $00, $22, $01, $62, $01

ShopMenu_Buy_ResetTextCounter0Counters::
    call ResetTextCounter0Counters
    ld a, [wListPages]
    cp $18
    jr c, .check_screen_step
    xor a
    ld [wTextTimer], a
    ld a, $01
    ld [wScreenState], a
    ld a, $01
    ld [wScreenStep], a
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    ld [wNumberTens], a
    ld a, $01
    ld [wNumberOnes], a
    ld [wNumberEditPos], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

ShopMenu_Buy_StepBGMapAddressBackOnScrollWrap_Case08::
    xor a
    ld [wNumberTens], a
    ld a, $01
    ld [wNumberOnes], a
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld de, vBGMap1 + $3b0
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
    or a
    jr z, .next
    push bc
    ld c, $4f
    ld a, $01
    ldh [c], a
    pop bc
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ld [de], a
    ei
    push bc
    ld c, $4f
    xor a
    ldh [c], a
    pop bc

.next:
    inc hl
    inc de
    inc c
    ld a, c
    cp $04
    jp c, .loop
    xor a
    ld c, a
    pop hl
    ld a, l
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    push hl
    inc b
    ld a, b
    cp $03
    jp c, .loop
    pop hl
    pop hl
    ld a, [wIsCGB]
    or a
    jr z, .skip
    push bc
    ld c, $4f
    ld a, $01
    ldh [c], a
    pop bc
    di
    call WaitForVRAMAccess
    xor a
    ld [hl], a
    ei
    ld a, l
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    di
    call WaitForVRAMAccess
    xor a
    ld [hl], a
    ei
    ld a, l
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    di
    call WaitForVRAMAccess
    xor a
    ld [hl], a
    ei
    push bc
    ld c, $4f
    ld a, $00
    ldh [c], a
    pop bc

.skip:
    ld hl, wScreenList
    ld de, ShopMenu_Buy_StepBGMapAddressBackOnScrollWrap_Case08_Data
    ld bc, $000c

.loop2:
    ld a, [de]
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, .loop2
    ld a, [wNumberTens]
    add $e0
    ld [wScreenByte8D], a
    ld a, [wNumberOnes]
    add $e0
    ld [wScreenCountPlusOne], a
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    lb bc, $04, $03
    ld de, wScreenList
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

ShopMenu_Buy_BlinkCursorBlinkCD_Bank1C_4F87::
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
    lb bc, $04, $03
    ld de, vBGMap1 + $3b0
    call DrawRectBothBanksSetTextCursorLoPlus1C1
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $06
    ld [wScreenStep], a
    xor a
    ld [wTextTimer], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_shop_menu_buy_case09_bg_map_address_at:
    call ShopMenu_Buy_Case09_BGMapAddressAtScroll_Bank1C_67AF
    ld a, [wNumberEditPos]
    cp $01
    jr nz, .set_number_edit_pos
    xor a
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
    and a
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
    and a
    jr nz, .check_number_tens
    ld a, [wNumberTens]
    cp $02
    jr c, .set_number_tens
    ld a, $02
    ld [wNumberTens], a
    ld a, $04
    ld [wNumberOnes], a
    call DrawNumberTensNumberOnesDigitsAtTable5008
    ret

.loop:
    ld a, [wNumberOnes]
    cp $04
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
    cp $02
    jp nc, .loop
    call BlinkCursorBlinkCD_Bank1C_4F87
    ret

.check_number_tens:
    ld a, [wNumberTens]
    cp $02
    jr c, .check_number_ones
    ld b, $04
    jr .check_number_ones2

.check_number_ones:
    ld b, $09

.check_number_ones2:
    ld a, [wNumberOnes]
    cp b
    jr c, .set_number_ones2
    ld a, b
    cp $04
    jr nz, .check_number_tens2
    call BlinkCursorBlinkCD_Bank1C_4F87
    ret

.check_number_tens2:
    ld a, [wNumberTens]
    and a
    jr nz, .clear_number_ones
    ld a, $01
    jr .set_number_ones

.clear_number_ones:
    xor a

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
    and a
    jr nz, .check_number_tens3
    ld a, [wNumberTens]
    and a
    jr nz, .set_number_tens2
    ld a, [wNumberOnes]
    cp $04
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
    or b
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
    and a
    jr nz, .check_number_ones3
    ld a, [wNumberOnes]
    cp $01
    jr nz, .set_number_ones3
    jr .check_number_tens4

.check_number_ones3:
    ld a, [wNumberOnes]
    and a
    jr nz, .set_number_ones3

.check_number_tens4:
    ld a, [wNumberTens]
    cp $02
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
    xor a
    ld [wTextTimer], a
    ld a, [wNumberTens]
    and a
    jr nz, .call_queue_sound_effect3
    ld a, [wNumberOnes]
    and a
    jr nz, .call_queue_sound_effect3
    call BlinkCursorBlinkCD_Bank1C_4F87
    ret

.call_queue_sound_effect3:
    ld a, $69
    call QueueSoundEffect
    call ShopMenu_Buy_Case09_BGMapAddressAtScroll_Bank1C_67AF
    call ShopMenu_Buy_Case09_WriteThreeDigits
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; cycles wCursorBlinkCD through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for
; $10-$17 (E-0122)
BlinkCursorBlinkCD_Bank1C_4F87::
    ld a, [wCursorBlinkCD]
    inc a
    ld [wCursorBlinkCD], a
    cp $10
    jr c, ShopMenu_Buy_Case09_BGMapAddressAtScroll_Bank1C_67AF
    cp $18
    jr c, ShopMenu_Buy_Case09_BGMapAddressAtScroll_Bank1C_67AF_Skip
    xor a
    ld [wCursorBlinkCD], a

ShopMenu_Buy_Case09_BGMapAddressAtScroll_Bank1C_67AF::
    ld a, [wNumberEditPos]
    and a
    jr nz, .read_number_ones
    ld a, [wNumberTens]
    jr .skip

.read_number_ones:
    ld a, [wNumberOnes]

.skip:
    add $e0
    ld b, a
    jr ShopMenu_Buy_Case09_BGMapAddressAtScroll_Bank1C_67AF_ReadNumberEditPos

ShopMenu_Buy_Case09_BGMapAddressAtScroll_Bank1C_67AF_Skip::
    ld b, $cb

ShopMenu_Buy_Case09_BGMapAddressAtScroll_Bank1C_67AF_ReadNumberEditPos::
    ld a, [wNumberEditPos]
    add a
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

; writes wNumberTens and wNumberOnes as digit tiles at the scroll offsets in
; ShopMenu_Buy_Case09_BGMapAddressAtScroll_Bank1C_67AF_Data and
; DrawNumberTensNumberOnesDigitsAtTable5008_Data (E-0121)
DrawNumberTensNumberOnesDigitsAtTable5008::
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
    add $e0
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
    add $e0
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret

ShopMenu_Buy_Case09_BGMapAddressAtScroll_Bank1C_67AF_Data::
    db $61, $01

DrawNumberTensNumberOnesDigitsAtTable5008_Data::
    db $62, $01

ShopMenu_Buy_Case09_WriteThreeDigits::
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
    add e
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
    ld b, $f2
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

ShopMenu_Buy_LoadArg1PointerForScreenTableIndex_Case0A::
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
    ld a, [hli]
    ld [wDigits], a
    ld a, [hli]
    ld [wDigits + $1], a
    ld a, [hl]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ldh a, [hTemp3]
    and $0f
    ld [wScreenList], a
    ldh a, [hTemp2]
    and $f0
    swap a
    ld [wListEntries], a
    ldh a, [hTemp2]
    and $0f
    ld [wGrid2CursorX], a
    ldh a, [hTemp1]
    and $f0
    swap a
    ld [wGrid2CursorY], a
    ldh a, [hTemp1]
    and $0f
    ld [wScreenArea], a
    ldh a, [hTemp0]
    and $f0
    swap a
    ld [wScreenByte8D], a
    ldh a, [hTemp0]
    and $0f
    ld [wScreenCountPlusOne], a
    ld c, $00
    ld a, [wScreenList]
    and a
    jr nz, .restore
    ld a, $90
    ld [wScreenList], a
    ld a, [wListEntries]
    and a
    jr nz, .restore
    ld a, $90
    ld [wListEntries], a
    ld a, [wGrid2CursorX]
    and a
    jr nz, .restore
    ld a, $90
    ld [wGrid2CursorX], a
    ld a, [wGrid2CursorY]
    and a
    jr nz, .restore
    ld a, $90
    ld [wGrid2CursorY], a
    ld a, [wScreenArea]
    and a
    jr nz, .restore
    ld a, $90
    ld [wScreenArea], a
    ld a, [wScreenByte8D]
    and a
    jr nz, .restore
    ld a, $90
    ld [wScreenByte8D], a

.restore:
    pop de
    ld hl, wScreenList

.loop:
    ld a, [hl]
    cp $90
    jr nz, .skip
    inc c
    inc hl
    jr .loop

.skip:
    ld a, [hli]
    ld [de], a
    inc de
    inc c
    ld a, c
    cp $07
    jr c, .loop
    ld a, $f0
    ld [de], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScreenByteD1], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

ShopMenu_Buy_StepBGMapAddressBackOnScrollWrap::
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $010e
    add hl, de
    push hl
    call StepBGMapAddressBackOnScrollWrap
    ld de, vBGMap1 + $3d0
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
    cp $06
    jp c, .loop
    xor a
    ld c, a
    pop hl
    ld a, l
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    push hl
    inc b
    ld a, b
    cp $05
    jp c, .loop
    pop hl
    pop hl
    ld de, TileRect_1C_6302
    lb bc, $06, $05
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    ld a, $6c
    call QueueSoundEffect
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

ShopMenu_Buy_BlinkCursorBlinkD2_Bank1C_52A0::
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
    and a
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
    cp $01
    jr c, .skip
    xor a
    jr .set_screen_byte_d12

.skip:
    inc a
    jr .set_screen_byte_d12

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call ShopMenu_Buy_Case0C_StepBGMapAddressBackOnScrollWrap
    ld a, [wScreenByteD1]
    and a
    jr nz, .call_bg_map_address_at_scroll_bank1_c_67_af
    ld a, [wThreeDigits + $2]
    ld [wArg3], a
    ld a, [wThreeDigits + $1]
    ld [wArg2], a
    ld a, [wThreeDigits]
    ld [wArg1], a
    call IsAmountInArg1AboveGold
    ld a, [wArg1]
    cp $ff
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
    add e
    ld e, a
    jr nc, .read_list_pages
    inc d

.read_list_pages:
    ld a, [wListPages]
    add e
    cp $19
    jr nc, .set_two_choice_cursor_to_01
    ld a, $02
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.clear_two_choice_cursor:
    xor a
    ld [wTwoChoiceCursor], a
    jr .check_screen_step

.set_two_choice_cursor_to_01:
    ld a, $01
    ld [wTwoChoiceCursor], a

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_bg_map_address_at_scroll_bank1_c_67_af:
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $010e
    add hl, de
    lb bc, $06, $05
    ld de, vBGMap1 + $3d0
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    ld a, [wScreenStep]
    sub $03
    ld [wScreenStep], a
    ld a, $03
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; cycles wCursorBlinkD2 through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for
; $10-$17 (after the joypad repeat timer reaches $14) (E-0122)
BlinkCursorBlinkD2_Bank1C_52A0::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, .skip
    ld a, [wCursorBlinkD2]
    inc a
    ld [wCursorBlinkD2], a
    cp $10
    jr c, .skip
    cp $18
    jr c, DrawBlankTileC3_52BE_Bank1C
    xor a
    ld [wCursorBlinkD2], a

.skip:
    ld b, $bb
    jr ShopMenu_Buy_Case0C_StepBGMapAddressBackOnScrollWrap_ReadScreenByteD1

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
DrawBlankTileC3_52BE_Bank1C::
    ld b, $c3
    jr ShopMenu_Buy_Case0C_StepBGMapAddressBackOnScrollWrap_ReadScreenByteD1

ShopMenu_Buy_Case0C_StepBGMapAddressBackOnScrollWrap::
    ld b, $bc

ShopMenu_Buy_Case0C_StepBGMapAddressBackOnScrollWrap_ReadScreenByteD1::
    ld a, [wScreenByteD1]
    add a
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

ShopMenu_Buy_Case0C_StepBGMapAddressBackOnScrollWrap_Data::
    db $2f, $01, $6f, $01

; clears two rectangles at scroll + $10E and + $140, wScreenStep = 6, clears wScriptCommandType and
; requests script $80 (E-0124)
DrawTwoBoxesAndRequestScript80::
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $010e
    add hl, de
    lb bc, $06, $05
    ld de, vBGMap1 + $3d0
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    lb bc, $04, $03
    ld de, vBGMap1 + $3b0
    call DrawRectBothBanksSetTextCursorLoPlus1C1
    ld a, $06
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

ShopMenu_Buy_DrawTwoBoxesAndRequestScript80::
    call DrawTwoBoxesAndRequestScript80
    ld a, $10
    ld [wScreenStep], a
    ret

ShopMenu_Buy_StepBGMapAddressBackOnScrollWrap_Case10::
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $00a2
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld b, $04

.loop:
    di
    call WaitForVRAMAccess
    ld a, $c3
    ld [hl], a
    ei
    ld a, l
    add $40
    ld l, a
    ld a, h
    adc $00
    ld h, a
    dec b
    jr nz, .loop
    ld a, [wItemGridY]
    and a
    jr nz, .clear_screen_step
    ld a, $06
    jr .set_screen_step

.clear_screen_step:
    xor a

.set_screen_step:
    ld [wScreenStep], a
    xor a
    ld [wItemGridX], a
    ld [wItemGridY], a
    ret

ShopMenu_Buy_SubtractArg1AmountFromGold::
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
    add e
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
    and a
    jr z, .read_cursor_blink_b8
    cp $ff
    jr z, .read_cursor_blink_b8
    inc hl
    inc b

.skip:
    ld a, b
    cp $18
    jr c, .loop
    jr .read_list_pages

.read_cursor_blink_b8:
    ld a, [wCursorBlinkB8]
    ld [hl], a
    inc hl
    inc b
    dec c
    ld a, c
    and a
    jr z, .read_list_pages
    jr .skip

.read_list_pages:
    pop de
    ld a, [wListPages]
    add e
    cp $18
    jr c, .check_screen_step
    ld a, $01
    ld [wScreenState], a
    ld a, $01
    ld [wScreenStep], a
    xor a
    ld [wItemGridX], a
    ld [wItemGridY], a
    ld [wTwoChoiceCursor], a
    xor a
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
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, .loop2
    ld hl, wScreenBlock92
    call DrawGoldDigitsAtHLWrapped_1C
    ld hl, wInventory
    ld c, $00
    ld b, $00

.loop3:
    ld a, [hli]
    and a
    jr z, .next
    cp $ff
    jr z, .next
    inc b

.next:
    inc c
    ld a, c
    cp $18
    jr c, .loop3
    ld a, b
    ld [wListPages], a
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld a, [wDigits + $1]
    and a
    jr z, .read_digits
    ld a, [wDigits + $1]
    add $e0
    ld [wItemCountTens], a

.read_digits:
    ld a, [wDigits + $2]
    add $e0
    ld [wItemCountOnes], a
    call BGMapAddressAtScroll_Bank1C_67AF
    ld a, $0c
    add_a_to_hl
    ld de, wScreenList
    lb bc, $08, $04
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; selling: items from the inventory, priced by ComputeSellPrice, paid with AddArg1ToGoldCapped99999
; (E-0276)
ShopMenu_Sell::
    ld a, [wScreenStep]
    jumptable
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

ShopMenu_Sell_ListDistinctInventoryItemsToItemGrid::
    ld hl, wInventory
    ld b, $00
    ld c, $00

.loop:
    ld a, [hl]
    and a
    jr z, .next
    cp $ff
    jr z, .next
    inc c

.next:
    inc hl
    inc b
    ld a, b
    cp $18
    jr c, .loop
    ld a, c
    ld [wListPages], a
    call ListDistinctInventoryItemsToItemGrid
    ld hl, wItemGrid
    ld b, $00
    ld c, $00

.loop2:
    ld a, [hl]
    and a
    jr z, .next2
    inc c

.next2:
    inc hl
    inc b
    ld a, b
    cp $18
    jr c, .loop2
    ld a, c
    ld l, a
    ld h, $00
    ld a, $04
    call DivideHLByA
    push af
    and a
    jr z, .set_saved_sprite_slot_count
    inc l

.set_saved_sprite_slot_count:
    ld a, l
    ld [wSavedSpriteSlotCount], a
    ld a, [wItemGridY]
    inc a
    cp l
    jr c, .set_choice_cursor_f0_to_03
    pop af
    push af
    and a
    jr nz, .set_choice_cursor_f0
    ld a, [wItemGridY]
    inc a
    cp l
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
    cp b
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
    cp $02
    jr c, .check_screen_step
    call DrawC5BEC6AtScroll18E_Bank1C
    call HLToDecimalDigits
    ld a, [wDigits + $1]
    and a
    jr nz, .call_bg_map_address_at_scroll_bank1_c_67_af
    ld a, $e3
    ld [wDigits + $1], a

.call_bg_map_address_at_scroll_bank1_c_67_af:
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0191
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $2]
    add $e0
    ld [hl], a
    ei
    ld a, [wItemGridY]
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $018f
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, [wDigits + $2]
    add $e1
    ld [hl], a
    ei

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScreenCounter], a
    ld [wGlyphListPos], a
    ret

ShopMenu_Sell_WriteGlyphListPosAndCursorBlinkB8Etc::
    ld a, [wScreenCounter]
    add a
    ld hl, TileDestTable_1C_6289
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld d, [hl]

.loop:
    push de
    ld a, [wGlyphListPos]
    add a
    add e
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
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    cp $09
    jr c, .loop
    xor a
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
    cp $f0
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
    add a
    ld de, TileDestTable_1C_6289
    add e
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
    cp $8d
    jr z, .check_glyph_list_pos
    cp $8e
    jr z, .check_glyph_list_pos
    jr .read_glyph_list_pos

.check_glyph_list_pos:
    ld a, [wGlyphListPos]
    dec a
    ld [wGlyphListPos], a

.read_glyph_list_pos:
    ld a, [wGlyphListPos]
    add a
    add_a_to_hl
    ld e, [hl]
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    ld b, $1f
    ld c, $10
    ld a, [wCursorBlinkB8]
    cp $8d
    jr z, .call_or_from_bank_wait_vram
    cp $8e
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
    xor a
    ld [wGlyphListPos], a
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp $04
    jr c, .return
    xor a
    ld [wScreenCounter], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.return:
    ret

ShopMenu_Sell_ComputeSellPrice::
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
    xor a
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ldh a, [hTemp1]
    and $f0
    swap a
    ld [wScreenByteBD], a
    ldh a, [hTemp1]
    and $0f
    ld [wListEntries2], a
    ldh a, [hTemp0]
    and $f0
    swap a
    ld [wScreenByteBF], a
    ldh a, [hTemp0]
    and $0f
    ld [wScreenByteC0], a
    ld a, [wScreenByteBD]
    and a
    jr nz, .set_screen_byte_c1_to_DF
    add $e3
    ld [wScreenByteBD], a
    ld a, [wListEntries2]
    and a
    jr nz, .set_screen_byte_c1_to_DF
    add $e3
    ld [wListEntries2], a
    ld a, [wScreenByteBF]
    and a
    jr nz, .set_screen_byte_c1_to_DF
    add $e3
    ld [wScreenByteBF], a
    ld a, [wScreenByteC0]
    and a
    jr nz, .set_screen_byte_c1_to_DF
    add $e3
    ld [wScreenByteC0], a
    ld a, $e3
    ld [wScreenByteC1], a
    jr .read_screen_counter

.set_screen_byte_c1_to_DF:
    ld a, $df
    ld [wScreenByteC1], a

.read_screen_counter:
    ld hl, ShopMenu_Buy_LoadArg1PointerForScreenTableIndex_Case05_Data
    ld a, [wScreenCounter]
    add a
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
    xor a
    ld [wScreenByteEE], a
    ld hl, wScreenByteBD
    ld c, $00

.loop2:
    ld a, [wScreenByteEE]
    and a
    jr nz, .call_wait_for_vram_access
    push hl
    ld l, e
    ld h, d
    call StepBGMapAddressBackOnScrollWrap
    cp $ff
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
    ld a, [hli]
    add $e0
    ld [de], a
    inc de
    ei
    inc c
    ld a, c
    cp $05
    jr c, .loop2
    pop hl
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp $04
    jp c, .loop
    xor a
    ld [wScreenCounter], a
    ld [wGlyphListPos], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

ShopMenu_Sell_BlinkCursorSelectedRecord_Bank1C::
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
    cp $03
    ret c
    ld a, [wJoypadPressedRepeat]
    bit 1, a
    ret z
    call ResetTextCounter0Counters
    xor a
    ld [wTextTimer], a
    ld a, $01
    ld [wScreenState], a
    ld a, $01
    ld [wScreenStep], a
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_saved_sprite_slot_count:
    ld a, [wSavedSpriteSlotCount]
    cp $02
    jr c, .loop
    call ResetTextCounter0Counters
    ld a, [wSavedSpriteSlotCount]
    ld b, a
    ld a, [wItemGridY]
    inc a
    cp b
    jr c, .set_item_grid_y
    xor a

.set_item_grid_y:
    ld [wItemGridY], a
    ld a, $02
    ld [wScreenStep], a

.loop:
    xor a
    ld [wSelectedRecord], a
    call DrawItemGridXCursor
    ld a, $69
    call QueueSoundEffect
    ret

.check_saved_sprite_slot_count2:
    ld a, [wSavedSpriteSlotCount]
    cp $02
    jr c, .loop
    call ResetTextCounter0Counters
    ld a, [wItemGridY]
    and a
    jr nz, .skip
    ld a, [wSavedSpriteSlotCount]
    dec a
    jp .set_item_grid_y

.skip:
    dec a
    jp .set_item_grid_y

.clear_selected_record:
    xor a
    ld [wSelectedRecord], a
    ld a, [wChoiceCursorF0]
    and a
    jr z, .loop2
    call ResetTextCounter0Counters
    call EraseItemGridXCursor
    ld a, [wItemGridX]
    and a
    jr nz, .set_item_grid_x
    ld a, [wChoiceCursorF0]
    jr .set_item_grid_x2

.set_item_grid_x:
    dec a

.set_item_grid_x2:
    ld [wItemGridX], a

.loop2:
    xor a
    ld [wSelectedRecord], a
    call DrawItemGridXCursor
    ld a, $69
    call QueueSoundEffect
    ret

.clear_selected_record2:
    xor a
    ld [wSelectedRecord], a
    ld a, [wChoiceCursorF0]
    and a
    jr z, .loop2
    call ResetTextCounter0Counters
    call EraseItemGridXCursor
    ld a, [wChoiceCursorF0]
    ld b, a
    ld a, [wItemGridX]
    cp b
    jr c, .skip2
    xor a
    jr .set_item_grid_x2

.skip2:
    inc a
    jr .set_item_grid_x2

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call DrawItemGridXCursorConfirmed
    call ResetTextCounter0Counters
    xor a
    ld [wTextTimer], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

ShopMenu_Sell_ResetTextCounter0Counters::
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
    and a
    jr nz, .check_screen_step
    ld a, h
    and a
    jr nz, .check_screen_step
    ld a, [wScreenStep]
    dec a
    ld [wScreenStep], a
    xor a
    ld [wTextTimer], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_screen_step:
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    ld [wCursorBlinkCD], a
    ld [wNumberTens], a
    ld a, $01
    ld [wNumberOnes], a
    ld [wNumberEditPos], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

ShopMenu_Sell_StepBGMapAddressBackOnScrollWrap::
    xor a
    ld [wNumberTens], a
    ld a, $01
    ld [wNumberOnes], a
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    call StepBGMapAddressBackOnScrollWrap
    ld de, vBGMap1 + $3b0
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
    or a
    jr z, .next
    push bc
    ld c, $4f
    ld a, $01
    ldh [c], a
    pop bc
    di
    call WaitForVRAMAccess
    ld a, [hl]
    ld [de], a
    ei
    push bc
    ld c, $4f
    xor a
    ldh [c], a
    pop bc

.next:
    inc hl
    inc de
    inc c
    ld a, c
    cp $07
    jp c, .loop
    xor a
    ld c, a
    pop hl
    ld a, l
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    push hl
    inc b
    ld a, b
    cp $03
    jp c, .loop
    pop hl
    pop hl
    ld a, [wIsCGB]
    or a
    jr z, .skip
    push bc
    ld c, $4f
    ld a, $01
    ldh [c], a
    pop bc
    di
    call WaitForVRAMAccess
    xor a
    ld [hl], a
    ei
    ld a, l
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    di
    call WaitForVRAMAccess
    xor a
    ld [hl], a
    ei
    ld a, l
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    di
    call WaitForVRAMAccess
    xor a
    ld [hl], a
    ei
    push bc
    ld c, $4f
    ld a, $00
    ldh [c], a
    pop bc

.skip:
    ld hl, wScreenList
    ld de, ShopMenu_Sell_StepBGMapAddressBackOnScrollWrap_Data
    ld bc, $0015

.loop2:
    ld a, [de]
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, .loop2
    ld a, [wNumberTens]
    add $e0
    ld [wScreenByte90], a
    ld a, [wNumberOnes]
    add $e0
    ld [wScreenByte91], a
    call CountItemInInventoryToDigits
    ld a, [wCountTens]
    and a
    jr nz, .read_count_tens
    ld a, $c3
    ld [wScreenByte93], a
    jr .read_count_ones

.read_count_tens:
    ld a, [wCountTens]
    add $e0
    ld [wScreenByte93], a

.read_count_ones:
    ld a, [wCountOnes]
    add $e0
    ld [wScreenByte94], a
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    lb bc, $07, $03
    ld de, wScreenList
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

ShopMenu_Sell_BlinkCursorBlinkCD_Bank1C_5B61::
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
    lb bc, $07, $03
    ld de, vBGMap1 + $3b0
    call DrawRectBothBanksSetTextCursorLoPlus1C1
    ld a, $01
    ld [wTwoChoiceCursor], a
    ld a, $05
    ld [wScreenStep], a
    xor a
    ld [wTextTimer], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_shop_menu_sell_case08_bg_map_address_at:
    call ShopMenu_Sell_Case08_BGMapAddressAtScroll_Bank1C_67AF
    ld a, [wNumberEditPos]
    cp $01
    jr nz, .set_number_edit_pos
    xor a
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
    and a
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
    and a
    jr nz, .read_count_tens
    ld a, [wCountTens]
    ld b, a
    ld a, [wNumberTens]
    cp b
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
    cp b
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
    cp b
    jp nc, .loop
    call BlinkCursorBlinkCD_Bank1C_5B61
    ret

.read_count_tens:
    ld a, [wCountTens]
    ld b, a
    ld a, [wNumberTens]
    cp b
    jr c, .check_number_ones
    ld a, [wCountOnes]
    ld b, a
    jr .check_number_ones2

.check_number_ones:
    ld b, $09

.check_number_ones2:
    ld a, [wNumberOnes]
    cp b
    jr c, .set_number_ones2
    ld a, [wCountOnes]
    cp b
    jr nz, .check_number_tens
    call BlinkCursorBlinkCD_Bank1C_5B61
    ret

.check_number_tens:
    ld a, [wNumberTens]
    and a
    jr nz, .clear_number_ones
    ld a, $01
    jr .set_number_ones

.clear_number_ones:
    xor a

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
    and a
    jr nz, .check_number_tens2
    ld a, [wNumberTens]
    and a
    jr nz, .set_number_tens2
    ld a, [wCountOnes]
    ld b, a
    ld a, [wNumberOnes]
    cp b
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
    or b
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
    and a
    jr nz, .check_number_ones3
    ld a, [wNumberOnes]
    cp $01
    jr nz, .set_number_ones3
    jr .read_count_tens3

.check_number_ones3:
    ld a, [wNumberOnes]
    and a
    jr nz, .set_number_ones3

.read_count_tens3:
    ld a, [wCountTens]
    ld b, a
    ld a, [wNumberTens]
    cp b
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
    and a
    jr nz, .call_queue_sound_effect3
    ld a, [wNumberOnes]
    and a
    jr nz, .call_queue_sound_effect3
    call ShopMenu_Sell_Case08_BGMapAddressAtScroll_Bank1C_67AF
    ret

.call_queue_sound_effect3:
    ld a, $69
    call QueueSoundEffect
    call ShopMenu_Sell_Case08_BGMapAddressAtScroll_Bank1C_67AF
    call ShopMenu_Sell_Case08_WriteThreeDigits
    xor a
    ld [wTwoChoiceCursor], a
    xor a
    ld [wTextTimer], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

; cycles wCursorBlinkCD through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for
; $10-$17 (E-0122)
BlinkCursorBlinkCD_Bank1C_5B61::
    ld a, [wCursorBlinkCD]
    inc a
    ld [wCursorBlinkCD], a
    cp $10
    jr c, ShopMenu_Sell_Case08_BGMapAddressAtScroll_Bank1C_67AF
    cp $18
    jr c, ShopMenu_Sell_Case08_BGMapAddressAtScroll_Bank1C_67AF_Skip
    xor a
    ld [wCursorBlinkCD], a

ShopMenu_Sell_Case08_BGMapAddressAtScroll_Bank1C_67AF::
    ld a, [wNumberEditPos]
    and a
    jr nz, .read_number_ones
    ld a, [wNumberTens]
    jr .skip

.read_number_ones:
    ld a, [wNumberOnes]

.skip:
    add $e0
    ld b, a
    jr ShopMenu_Sell_Case08_BGMapAddressAtScroll_Bank1C_67AF_ReadNumberEditPos

ShopMenu_Sell_Case08_BGMapAddressAtScroll_Bank1C_67AF_Skip::
    ld b, $cb

ShopMenu_Sell_Case08_BGMapAddressAtScroll_Bank1C_67AF_ReadNumberEditPos::
    ld a, [wNumberEditPos]
    add a
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

; writes wNumberTens and wNumberOnes as digit tiles at the scroll offsets in
; ShopMenu_Buy_Case09_BGMapAddressAtScroll_Bank1C_67AF_Data and
; DrawNumberTensNumberOnesDigitsAtTable5008And5BE4_Data (E-0121)
DrawNumberTensNumberOnesDigitsAtTable5008And5BE4::
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
    add $e0
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
    add $e0
    ld b, a
    di
    call WaitForVRAMAccess
    ld a, b
    ld [hl], a
    ei
    ret
    db $61, $01

DrawNumberTensNumberOnesDigitsAtTable5008And5BE4_Data::
    db $62, $01

ShopMenu_Sell_Case08_WriteThreeDigits::
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
    add e
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

ShopMenu_Sell_WriteCursorBlinkB8AndDigitsEtc::
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
    ld a, [hli]
    ld [wDigits], a
    ld a, [hli]
    ld [wDigits + $1], a
    ld a, [hl]
    ld [wDigits + $2], a
    call Number24ToPackedBCD
    ldh a, [hTemp2]
    and $f0
    swap a
    ld [wScreenList], a
    ldh a, [hTemp2]
    and $0f
    ld [wListEntries], a
    ldh a, [hTemp1]
    and $f0
    swap a
    ld [wGrid2CursorX], a
    ldh a, [hTemp1]
    and $0f
    ld [wGrid2CursorY], a
    ldh a, [hTemp0]
    and $f0
    swap a
    ld [wScreenArea], a
    ldh a, [hTemp0]
    and $0f
    ld [wScreenByte8D], a
    ld c, $00
    ld a, [wScreenList]
    and a
    jr nz, .restore
    ld a, $90
    ld [wScreenList], a
    ld a, [wListEntries]
    and a
    jr nz, .restore
    ld a, $90
    ld [wListEntries], a
    ld a, [wGrid2CursorX]
    and a
    jr nz, .restore
    ld a, $90
    ld [wGrid2CursorX], a
    ld a, [wGrid2CursorY]
    and a
    jr nz, .restore
    ld a, $90
    ld [wGrid2CursorY], a
    ld a, [wScreenArea]
    and a
    jr nz, .restore
    ld a, $90
    ld [wScreenArea], a

.restore:
    pop de
    ld hl, wScreenList
    ld c, $00

.loop:
    ld a, [hl]
    cp $90
    jr nz, .skip
    inc c
    inc hl
    jr .loop

.skip:
    ld a, [hli]
    ld [de], a
    inc de
    inc c
    ld a, c
    cp $06
    jr c, .loop
    ld a, $f0
    ld [de], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScreenByteD1], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

ShopMenu_Sell_BlinkCursorBlinkD2_Bank1C_5DA4::
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
    and a
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
    cp $01
    jr c, .skip
    xor a
    jr .set_screen_byte_d12

.skip:
    inc a
    jr .set_screen_byte_d12

.call_queue_sound_effect:
    ld a, $69
    call QueueSoundEffect
    call ShopMenu_Sell_Case0B_StepBGMapAddressBackOnScrollWrap
    ld a, [wScreenByteD1]
    and a
    jr nz, .call_bg_map_address_at_scroll_bank1_c_67_af
    xor a
    ld [wTwoChoiceCursor], a
    ld a, [wScreenStep]
    inc a
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.call_bg_map_address_at_scroll_bank1_c_67_af:
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $010e
    add hl, de
    lb bc, $06, $05
    ld de, vBGMap1 + $3d0
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    ld a, [wScreenStep]
    sub $03
    ld [wScreenStep], a
    ld a, $01
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; cycles wCursorBlinkD2 through 0-$17 and draws the cursor tile ($BB) for 0-$0F or a blank ($C3) for
; $10-$17 (after the joypad repeat timer reaches $14) (E-0122)
BlinkCursorBlinkD2_Bank1C_5DA4::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, .skip
    ld a, [wCursorBlinkD2]
    inc a
    ld [wCursorBlinkD2], a
    cp $10
    jr c, .skip
    cp $18
    jr c, DrawBlankTileC3_5DC2_Bank1C
    xor a
    ld [wCursorBlinkD2], a

.skip:
    ld b, $bb
    jr ShopMenu_Sell_Case0B_StepBGMapAddressBackOnScrollWrap_ReadScreenByteD1

; B = $C3 (blank tile) and joins the cursor draw (E-0122)
DrawBlankTileC3_5DC2_Bank1C::
    ld b, $c3
    jr ShopMenu_Sell_Case0B_StepBGMapAddressBackOnScrollWrap_ReadScreenByteD1

ShopMenu_Sell_Case0B_StepBGMapAddressBackOnScrollWrap::
    ld b, $bc

ShopMenu_Sell_Case0B_StepBGMapAddressBackOnScrollWrap_ReadScreenByteD1::
    ld a, [wScreenByteD1]
    add a
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

ShopMenu_Sell_Case0B_StepBGMapAddressBackOnScrollWrap_Data::
    db $2f, $01, $6f, $01

ShopMenu_Sell_ClearRectSetTextCursorLoPlus1C1_Bank1C::
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $010e
    add hl, de
    lb bc, $06, $05
    ld de, vBGMap1 + $3d0
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    lb bc, $07, $03
    ld de, vBGMap1 + $3b0
    call DrawRectBothBanksSetTextCursorLoPlus1C1
    ld a, $01
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

ShopMenu_Sell_AddArg1ToGoldCapped99999::
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
    and a
    jr z, .next
    cp $ff
    jr z, .next
    inc c

.next:
    inc hl
    inc b
    ld a, b
    cp $18
    jr c, .loop
    ld a, c
    ld [wListPages], a
    and a
    jr nz, .check_screen_step
    ld a, $01
    ld [wScreenState], a
    ld a, $01
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    ld [wItemGridX], a
    ld [wItemGridY], a
    xor a
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
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, .loop2
    ld hl, wScreenBlock92
    call DrawGoldDigitsAtHLWrapped_1C
    ld hl, wInventory
    ld c, $00
    ld b, $00

.loop3:
    ld a, [hli]
    and a
    jr z, .next2
    cp $ff
    jr z, .next2
    inc b

.next2:
    inc c
    ld a, c
    cp $18
    jr c, .loop3
    ld a, b
    ld [wListPages], a
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld a, [wDigits + $1]
    and a
    jr z, .read_digits
    ld a, [wDigits + $1]
    add $e0
    ld [wItemCountTens], a

.read_digits:
    ld a, [wDigits + $2]
    add $e0
    ld [wItemCountOnes], a
    call BGMapAddressAtScroll_Bank1C_67AF
    ld a, $0c
    add_a_to_hl
    ld de, wScreenList
    lb bc, $08, $04
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    xor a
    ld [wItemGridX], a
    ld [wItemGridY], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

ShopMenu_Buy_ReadFarPointerAtDEInBankB::
    push hl
    ld hl, wInventory
    ld b, $18

.loop:
    ld a, [hl]
    and a
    jr z, .next
    cp $2d
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
    ld b, $f2
    call ReadFarPointerAtDEInBankB
    ld e, b
    ld a, $09
    call Multiply24By8_Bank1C
    ld a, $0a
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

; HL and B = the 3-byte far pointer entry wScreenTableIndex of ScreenNumberListTable in bank $F2
; (ReadFarPointerAtDEInBankB); DE kept (E-0118)
ReadF2FarPointerForScreenTableIndex::
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
    ld b, $f2
    call ReadFarPointerAtDEInBankB
    pop de
    ret

; BC = the ItemValueTable word at DE (DE = 2 * item) times ShopPercentTable[wScreenTableIndex],
; divided by 100 (E-0237, E-0276) (C2 from E-0327: the sell list shows Herb 7G, LoveWater 37G,
; WorldDew 375G and Potion 150G for values 10, 50, 500 and 200 at 75%)
ComputeSellPrice::
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

ShopMenu_Buy_SubtractArg1AmountFromGold_Data::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b2, $b6, $bf, $c3, $c3, $c3, $c3, $c3, $b7
    db $b8, $b9, $b9, $b9, $b9, $b9, $b9, $ba, $b6, $ae, $ad, $ec, $af, $c3, $c3, $b7
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b5

; a list passed to a tile-list copier, which copies 16 bytes from bank $1F per destination until a
; low byte of $FF (E-0225)
; record: VRAM destinations, then $FFxx
TileCopyDestList_1C_5F86::
    dw vTiles1 + $6a0, vTiles1 + $6b0, vTiles1 + $6c0, vTiles1 + $6d0, vTiles1 + $6e0, vTiles1 + $6f0, vTiles1 + $700, vTiles1 + $710 ; entry 0
    dw vTiles1 + $720, vTiles1 + $730, vTiles1 + $740, vTiles1 + $750, vTiles1 + $760, vTiles1 + $770, vTiles1 + $780, vTiles1 + $790
    dw vTiles1 + $7a0, vTiles1 + $7b0, vTiles1 + $7c0, vTiles1 + $7d0, vTiles1 + $7e0, vTiles1 + $7f0, vTiles1 + $500, vTiles1 + $510
    dw vTiles1 + $520, vTiles1 + $530, vTiles1 + $540, vTiles1 + $550, vTiles1 + $560, vTiles1 + $570, vTiles1 + $580, vTiles1 + $590
    dw vTiles1 + $5a0, vTiles1 + $5b0, vTiles1 + $5c0, vTiles1 + $5d0, vTiles1 + $5e0, vTiles1 + $2a0, vTiles1 + $2b0, vTiles1 + $2c0
    dw vTiles1 + $2d0, vTiles1 + $2e0, vTiles1 + $2f0, vTiles1 + $470, vTiles1 + $480, vTiles1 + $490, vTiles1 + $4a0, vTiles1 + $4b0
    dw rIE

; record: bank-$1F tile sources
TileCopySrcList_1C_5FE8::
    dw $40c0, $4390, $43d0, $41d0, $4330, $4300, $4910, $4910 ; entry 0
    dw $4910, $4910, $4910, $4910, $4910, $4910, $4910, $4910
    dw $4910, $4910, $4910, $4910, $4910, $4910, $4910, $4910
    dw $4910, $4910, $4910, $4910, $4910, $4910, $4910, $4910
    dw $4910, $4910, $4910, $4910, $4910, $4910, $43c0, $42d0
    dw $4380, $41b0, $4a40, $4910, $4910, $4910, $4910, $4a00
    dw $ffff

TileCopySrcList_1C_604A::
    dw $4210, $42d0, $43d0, $42c0, $4280, $4360, $4910, $4910 ; entry 0
    dw $4910, $4910, $4910, $4910, $4910, $4910, $4910, $4910
    dw $4910, $4910, $4910, $4910, $4910, $4910, $4910, $4910
    dw $4910, $4910, $4910, $4910, $4910, $4910, $4910, $4910
    dw $4910, $4910, $4910, $4910, $4910, $4910, $4250, $43b0
    dw $4380, $41b0, $4a40, $4910, $4910, $4910, $4910, $4a00
    dw $ffff

ShopMenu_Buy_WriteVBKAndScreenStep_Data::
    db $b0
    ds $11, $b1
    db $b2, $b6, $c3, $f0, $f1, $f2, $f3, $f4, $f5, $f6, $f7, $c7, $c3, $c3, $c3, $c3
    db $c3, $c3, $c3, $b7, $b6
    ds $11, $c3
    db $b7, $b6, $c3, $f8, $f9, $fa, $fb, $fc, $fd, $fe, $ff, $c8, $c3, $c3, $c3, $c3
    db $c3, $c3, $c3, $b7, $b6
    ds $11, $c3
    db $b7, $b6, $c3, $d0, $d1, $d2, $d3, $d4, $d5, $d6, $d7, $c9, $c3, $c3, $c3, $c3
    db $c3, $c3, $c3, $b7, $b6
    ds $11, $c3
    db $b7, $b6, $c3, $d8, $d9, $da, $db, $dc, $dd, $de, $aa, $ca, $c3, $c3, $c3, $c3
    db $c3, $c3, $c3, $b7, $b3
    ds $11, $b4
    db $b5, $7f

; LoadArg1PointerForScreenTableIndex loads wArg1/wArg2 with the word at $6158 + 2 *
; wScreenTableIndex, and LoadArg1ByteForItemGridXItemGridY reads the byte at that pointer + 4 *
; wItemGridY + wItemGridX; 24 words, several sharing a list; the lists run to $6289 (E-0238, C1)
; record: item list ($FF ends)
ShopItemListTable::
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

; list for entry $00 of ShopItemListTable; it runs to the next list (E-0199)
; record: item numbers, then $FF
ShopItems000::
    db $01, $02, $06, $19, $1a, $29, $2b, $53, $ff ; id 0

; list for entry $01 of ShopItemListTable; it runs to the next list (E-0199)
ShopItems001::
    db $03, $04, $07, $08, $09, $0a, $1b, $2e, $2b, $ff, $ff, $ff ; id 0

; list for entry $02 of ShopItemListTable; it runs to the next list (E-0199)
ShopItems002::
    db $05, $0c, $1c, $22, $23, $24, $25, $1f, $21, $2d, $ff, $ff ; id 0

; list for entry $03 of ShopItemListTable; it runs to the next list (E-0199)
ShopItems003::
    db $01, $06, $09, $19, $29, $ff, $ff, $ff ; id 0

; list for entry $04 of ShopItemListTable; it runs to the next list (E-0199)
; record: item numbers, then $FF
ShopItems004::
    db $01, $02, $06, $09, $1a, $29, $2b, $ff ; id 0

; list for entry $05 of ShopItemListTable; it runs to the next list (E-0199)
ShopItems005::
    db $ff ; id 0

; list for entry $06 of ShopItemListTable; it runs to the next list (E-0199)
ShopItems006::
    db $02, $06, $09, $1a, $1b, $28, $2a, $ff ; id 0

; list for entry $07 of ShopItemListTable; it runs to the next list (E-0199)
ShopItems007::
    db $02, $06, $07, $08, $1a, $1b, $28, $2a, $2e, $ff, $ff, $ff ; id 0

; list for entry $08 of ShopItemListTable; it runs to the next list (E-0199)
; record: item numbers, then $FF
ShopItems008::
    db $02, $03, $04, $0a, $1a, $28, $2a, $ff ; id 0

; list for entry $09 of ShopItemListTable; it runs to the next list (E-0199)
ShopItems009::
    db $08, $0c, $1b, $2b, $2e, $1f, $21, $2d, $ff ; id 0

; list for entry $0A of ShopItemListTable; it runs to the next list (E-0199)
ShopItems00A::
    db $13, $14, $15, $16, $17, $18, $ff, $ff ; id 0

; list for entry $0B of ShopItemListTable; it runs to the next list (E-0199)
ShopItems00B::
    db $02, $07, $0a, $1b, $29, $2a, $2e, $ff ; id 0

; list for entry $0C of ShopItemListTable; it runs to the next list (E-0199)
; record: item numbers, then $FF
ShopItems00C::
    db $02, $07, $0a, $1b, $28, $2a, $2b, $2e, $ff ; id 0

; list for entry $0D of ShopItemListTable; it runs to the next list (E-0199)
ShopItems00D::
    db $02, $03, $04, $1b, $1c, $20, $28, $2a, $ff ; id 0

; list for entry $0E of ShopItemListTable; it runs to the next list (E-0199)
ShopItems00E::
    db $02, $03, $04, $0c, $1c, $20, $28, $2a, $2b, $2e, $ff, $ff ; id 0

; list for entry $0F of ShopItemListTable; it runs to the next list (E-0199)
ShopItems00F::
    db $01, $02, $03, $04, $06, $07, $08, $0a, $1b, $20, $28, $2a, $ff ; id 0

; list for entry $10 of ShopItemListTable; it runs to the next list (E-0199)
; record: item numbers, then $FF
ShopItems010::
    db $01, $02, $03, $05, $06, $07, $08, $27, $ff ; id 0

; list for entry $11 of ShopItemListTable; it runs to the next list (E-0199)
ShopItems011::
    db $02, $04, $0b, $1c, $20, $21, $ff, $ff ; id 0

; list for entry $12 of ShopItemListTable; it runs to the next list (E-0199)
ShopItems012::
    db $02, $03, $05, $1c, $20, $24, $28, $2a, $ff ; id 0

; list for entry $13 of ShopItemListTable; it runs to the next list (E-0199)
ShopItems013::
    db $01, $02, $04, $06, $1b, $20, $28, $2a, $ff ; id 0

; list for entry $17 of ShopItemListTable; it runs to the next list (E-0199)
; record: item numbers, then $FF
ShopItems017::
    db $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1a, $1b, $1c, $1d, $1e, $1f, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2a, $2b, $2c, $2d, $2e, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4a, $4b, $4c, $4d, $4e, $4f, $50, $51, $52, $53, $5a, $5b, $5c, $5d, $5e, $5f, $60, $61, $ff, $ff ; id 0

; ShopMenu_Case03_Case03 and four other sites read the word at $6289 + 2 * wScreenCounter, then the
; word at 2 * wGlyphListPos of that list, and copy the bank-$1F tile at $4910 there
; (CopyFromBankWaitVRAM, 16 bytes) (E-0238, C1)
; record: list of VRAM tile addresses
TileDestTable_1C_6289::
    dw TileDests_1C_0 ; id 0
    dw TileDests_1C_1 ; id 1
    dw TileDests_1C_2 ; id 2
    dw TileDests_1C_3 ; id 3

; list 0 of TileDestTable_1C_6289; 9 words (E-0238, C1)
; record: VRAM tile addresses, indexed by wGlyphListPos
TileDests_1C_0::
    dw vTiles1 + $700, vTiles1 + $710, vTiles1 + $720, vTiles1 + $730, vTiles1 + $740, vTiles1 + $750 ; entry 0
    dw vTiles1 + $760, vTiles1 + $770, vTiles1 + $470

; list 1 of TileDestTable_1C_6289; 9 words (E-0238, C1)
TileDests_1C_1::
    dw vTiles1 + $780, vTiles1 + $790, vTiles1 + $7a0, vTiles1 + $7b0, vTiles1 + $7c0, vTiles1 + $7d0 ; entry 0
    dw vTiles1 + $7e0, vTiles1 + $7f0, vTiles1 + $480

; list 2 of TileDestTable_1C_6289; 9 words (E-0238, C1)
TileDests_1C_2::
    dw vTiles1 + $500, vTiles1 + $510, vTiles1 + $520, vTiles1 + $530, vTiles1 + $540, vTiles1 + $550 ; entry 0
    dw vTiles1 + $560, vTiles1 + $570, vTiles1 + $490

; list 3 of TileDestTable_1C_6289; 9 words (E-0238, C1)
TileDests_1C_3::
    dw vTiles1 + $580, vTiles1 + $590, vTiles1 + $5a0, vTiles1 + $5b0, vTiles1 + $5c0, vTiles1 + $5d0 ; entry 0
    dw vTiles1 + $5e0, vTiles1 + $2a0, vTiles1 + $4a0

ShopMenu_Buy_LoadArg1PointerForScreenTableIndex_Case05_Data::
    db $ae, $00, $ee, $00, $2e, $01, $6e, $01

ShopMenu_Buy_StepBGMapAddressBackOnScrollWrap_Case08_Data::
    db $b0, $b1, $b1, $b2, $b6, $c3, $c3, $b7, $b3, $b4, $b4, $b5

ShopMenu_Sell_StepBGMapAddressBackOnScrollWrap_Data::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b2, $b6, $c3, $c3, $be, $c3, $c3, $b7, $b3, $b4
    db $b4, $b4, $b4, $b4, $b5

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 6 x 5 tiles, one row per line
TileRect_1C_6302::
    db $b0, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $ce, $cf, $df, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $a5, $ee, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b5 ; id 4

; E-0237 (C1: ShopMenu_Shared03 reads the byte at $6320 + wScreenTableIndex, multiplies the
; ItemValueTable word by it (Multiply8By16) and divides by 100 (Divide24ByA); values 75 and 80, one
; 0). C2 from E-0327: the sell price, by the shop's index (GreatLog's merchant sets 0, 75%); the buy
; price is the ItemValueTable word itself.
; record: percentage
ShopPercentTable::
    db $4b ; id 0
    db $4b ; id 1
    db $4b ; id 2
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
    db $4b ; id 15
    db $50 ; id 16
    db $50 ; id 17
    db $50 ; id 18
    db $50 ; id 19
    db $50 ; id 20
    db $50 ; id 21
    db $50 ; id 22
    db $50 ; id 23

; ShopMenu_Shared03 reads the word at $6338 + DE, where its three callers pass DE = 2 * a byte of
; wItemGrid; the word is scaled by ShopPercentTable; 99 words up to the table at $63FE). C2 from
; E-0327: the value of each item id: a shop buys at it (Herb 10G, LoveWater 50G, Antidote 4G) and
; sells at value * ShopPercentTable / 100 (Herb 7G, LoveWater 37G, WorldDew 375G, Potion 150G at 75%
; (E-0237, C1)
; record: value
ItemValueTable::
    dw $0000 ; id 0
    dw $000a ; id 1
    dw $0032 ; id 2
    dw $01f4 ; id 3
    dw $00c8 ; id 4
    dw $07d0 ; id 5
    dw $0004 ; id 6
    dw $0014 ; id 7
    dw $0014 ; id 8
    dw $0014 ; id 9
    dw $0014 ; id 10
    dw $03e8 ; id 11
    dw $03e8 ; id 12
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
    dw $000a ; id 25
    dw $0028 ; id 26
    dw $00c8 ; id 27
    dw $03e8 ; id 28
    dw $0014 ; id 29
    dw $1388 ; id 30
    dw $0320 ; id 31
    dw $0064 ; id 32
    dw $04b0 ; id 33
    dw $02bc ; id 34
    dw $0320 ; id 35
    dw $05dc ; id 36
    dw $0bb8 ; id 37
    dw $0fa0 ; id 38
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
    dw $00c8 ; id 64
    dw $01f4 ; id 65
    dw $00c8 ; id 66
    dw $01f4 ; id 67
    dw $00c8 ; id 68
    dw $01f4 ; id 69
    dw $00c8 ; id 70
    dw $01f4 ; id 71
    dw $00c8 ; id 72
    dw $01f4 ; id 73
    dw $00c8 ; id 74
    dw $01f4 ; id 75
    dw $03e8 ; id 76
    dw $03e8 ; id 77
    dw $03e8 ; id 78
    dw $07d0 ; id 79
    dw $1388 ; id 80
    dw $03e8 ; id 81
    dw $03e8 ; id 82
    dw $0014 ; id 83
    dw $0000 ; id 84
    dw $0000 ; id 85
    dw $0000 ; id 86
    dw $0000 ; id 87
    dw $0000 ; id 88
    dw $0000 ; id 89
    dw $03e8 ; id 90
    dw $03e8 ; id 91
    dw $07d0 ; id 92
    dw $07d0 ; id 93
    dw $07d0 ; id 94
    dw $07d0 ; id 95
    dw $07d0 ; id 96
    dw $07d0 ; id 97
    dw $0000 ; id 98

; ShopMenu_Case03_Case03, ShopMenu_Case04_Case03 and VaultMenu_Case03_Case09 read the word at $63FE
; + 2 * item number and draw the $F0-terminated name as bank-$1F glyph tiles ($4010 + 16 *
; character); the names equal StringTable_ItemNames (08:$4716) for the 99 items (E-0261, C1)
; record: item name
ItemNamesCopy_1C::
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

ItemName1C_00::
    db $f0

ItemName1C_Herb::
    db $11, $28, $35, $25, $f0

ItemName1C_LoveWater::
    db $15, $32, $39, $28, $20, $24, $37, $28, $35, $f0

ItemName1C_WorldDew::
    db $20, $32, $35, $2f, $27, $0d, $28, $3a, $f0

ItemName1C_Potion::
    db $19, $32, $37, $2c, $32, $31, $f0

ItemName1C_ElfWater::
    db $0e, $2f, $29, $20, $24, $37, $28, $35, $f0

ItemName1C_Antidote::
    db $0a, $31, $37, $2c, $27, $32, $37, $28, $f0

ItemName1C_MoonHerb::
    db $16, $32, $32, $31, $11, $28, $35, $25, $f0

ItemName1C_Laurel::
    db $15, $24, $38, $35, $28, $2f, $f0

ItemName1C_AwakeSand::
    db $0a, $3a, $24, $2e, $28, $1c, $24, $31, $27, $f0

ItemName1C_SkyBell::
    db $1c, $2e, $3c, $0b, $28, $2f, $2f, $f0

ItemName1C_SageRock::
    db $1c, $24, $2a, $28, $1b, $32, $26, $2e, $f0

ItemName1C_WorldLeaf::
    db $20, $32, $35, $2f, $27, $15, $28, $24, $29, $f0

ItemName1C_ATKseed::
    db $0a, $1d, $14, $36, $28, $28, $27, $f0

ItemName1C_DEFseed::
    db $0d, $0e, $0f, $36, $28, $28, $27, $f0

ItemName1C_AGLseed::
    db $0a, $10, $15, $36, $28, $28, $27, $f0

ItemName1C_INTseed::
    db $12, $17, $1d, $36, $28, $28, $27, $f0

ItemName1C_LifeAcorn::
    db $15, $2c, $29, $28, $0a, $26, $32, $35, $31, $f0

ItemName1C_MysticNut::
    db $16, $3c, $36, $37, $2c, $26, $17, $38, $37, $f0

ItemName1C_Quest::
    db $1a, $38, $28, $36, $37, $50, $f0

ItemName1C_Horror::
    db $11, $32, $35, $35, $32, $35, $50, $f0

ItemName1C_BeNice::
    db $0b, $28, $17, $2c, $26, $28, $50, $f0

ItemName1C_Cheater::
    db $0c, $2b, $28, $24, $37, $28, $35, $50, $f0

ItemName1C_Smart::
    db $1c, $30, $24, $35, $37, $50, $f0

ItemName1C_Comedy::
    db $0c, $32, $30, $28, $27, $3c, $50, $f0

ItemName1C_BeefJerky::
    db $0b, $28, $28, $29, $13, $28, $35, $2e, $3c, $f0

ItemName1C_PorkChop::
    db $19, $32, $35, $2e, $0c, $2b, $32, $33, $f0

ItemName1C_Rib::
    db $1b, $2c, $25, $f0

ItemName1C_Sirloin::
    db $1c, $2c, $35, $2f, $32, $2c, $31, $f0

ItemName1C_BadMeat::
    db $0b, $24, $27, $16, $28, $24, $37, $f0

ItemName1C_MeteOrb::
    db $16, $28, $37, $28, $18, $35, $25, $f0

ItemName1C_BeastTail::
    db $0b, $28, $24, $36, $37, $1d, $24, $2c, $2f, $f0

ItemName1C_Repellent::
    db $1b, $28, $33, $28, $2f, $2f, $28, $31, $37, $f0

ItemName1C_ShinyHarp::
    db $1c, $2b, $2c, $31, $3c, $11, $24, $35, $33, $f0

ItemName1C_Mist::
    db $16, $2c, $36, $37, $51, $f0

ItemName1C_Friend::
    db $0f, $35, $2c, $28, $31, $27, $51, $f0

ItemName1C_Wind::
    db $20, $2c, $31, $27, $51, $f0

ItemName1C_Bolt::
    db $0b, $32, $2f, $37, $51, $f0

ItemName1C_Snow::
    db $1c, $31, $32, $3a, $51, $f0

ItemName1C_Fire::
    db $0f, $2c, $35, $28, $51, $f0

ItemName1C_Warp::
    db $20, $24, $35, $33, $51, $f0

ItemName1C_WarpWing::
    db $20, $24, $35, $33, $20, $2c, $31, $2a, $f0

ItemName1C_ExitBell::
    db $0e, $3b, $2c, $37, $0b, $28, $2f, $2f, $f0

ItemName1C_Bookmark::
    db $0b, $32, $32, $2e, $30, $24, $35, $2e, $f0

ItemName1C_TinyMedal::
    db $1d, $2c, $31, $3c, $16, $28, $27, $24, $2f, $f0

ItemName1C_GoldPass::
    db $10, $32, $2f, $27, $19, $24, $36, $36, $f0

ItemName1C_LogTwig::
    db $15, $32, $2a, $1d, $3a, $2c, $2a, $f0

ItemName1C_2F::
    db $f0

ItemName1C_WaterCall::
    db $20, $24, $37, $28, $35, $0c, $24, $2f, $2f, $f0

ItemName1C_MoonRock::
    db $16, $32, $32, $31, $1b, $32, $26, $2e, $f0

ItemName1C_Crest::
    db $0c, $35, $28, $36, $37, $f0

ItemName1C_YunaSoul::
    db $22, $38, $31, $24, $1c, $32, $38, $2f, $f0

ItemName1C_SleepHerb::
    db $1c, $2f, $28, $28, $33, $11, $28, $35, $25, $f0

ItemName1C_Change::
    db $0c, $2b, $24, $31, $2a, $28, $51, $f0

ItemName1C_TidalBell::
    db $1d, $2c, $27, $24, $2f, $0b, $28, $2f, $2f, $f0

ItemName1C_HarMirror::
    db $11, $24, $35, $16, $2c, $35, $35, $32, $35, $f0

ItemName1C_Sky::
    db $1c, $2e, $3c, $5e, $f0

ItemName1C_Heaven::
    db $11, $28, $24, $39, $28, $31, $52, $f0

ItemName1C_Heaven_6693::
    db $11, $28, $24, $39, $28, $31, $54, $f0

ItemName1C_Heaven_669B::
    db $11, $28, $24, $39, $28, $31, $53, $f0

ItemName1C_WizStone::
    db $20, $2c, $3d, $1c, $37, $32, $31, $28, $f0

ItemName1C_Pretty::
    db $19, $35, $28, $37, $37, $3c, $55, $f0

ItemName1C_Accessory::
    db $1f, $12, $1d, $25, $28, $2f, $37, $f0

ItemName1C_DracoBelt::
    db $0d, $35, $24, $26, $32, $0b, $28, $2f, $37, $f0

ItemName1C_MagicBelt::
    db $16, $24, $2a, $2c, $26, $0b, $28, $2f, $37, $f0

ItemName1C_OddBelt::
    db $18, $27, $27, $0b, $28, $2f, $37, $f0

ItemName1C_StoneFang::
    db $1c, $37, $32, $31, $28, $0f, $24, $31, $2a, $f0

ItemName1C_SteelFang::
    db $1c, $37, $28, $28, $2f, $0f, $24, $31, $2a, $f0

ItemName1C_MermScale::
    db $16, $28, $35, $30, $1c, $26, $24, $2f, $28, $f0

ItemName1C_DrakScale::
    db $0d, $35, $24, $2e, $1c, $26, $24, $2f, $28, $f0

ItemName1C_AGL::
    db $0a, $10, $15, $55, $f0

ItemName1C_Starry::
    db $1c, $37, $24, $35, $35, $3c, $55, $f0

ItemName1C_Smart_670D::
    db $1c, $30, $24, $35, $37, $56, $f0

ItemName1C_Wise::
    db $20, $2c, $36, $28, $56, $f0

ItemName1C_MagicCape::
    db $16, $24, $2a, $2c, $26, $0c, $24, $33, $28, $f0

ItemName1C_DracoCape::
    db $0d, $35, $24, $26, $32, $0c, $24, $33, $28, $f0

ItemName1C_SilvrCape::
    db $1c, $2c, $2f, $39, $35, $0c, $24, $33, $28, $f0

ItemName1C_GoldCape::
    db $10, $32, $2f, $27, $0c, $24, $33, $28, $f0

ItemName1C_PltnmCape::
    db $19, $2f, $37, $31, $30, $0c, $24, $33, $28, $f0

ItemName1C_OrcaCape::
    db $18, $35, $26, $24, $0c, $24, $33, $28, $f0

ItemName1C_BraveCape::
    db $0b, $35, $24, $39, $28, $0c, $24, $33, $28, $f0

ItemName1C_DScale::
    db $0d, $9c, $1c, $26, $24, $2f, $28, $f0

ItemName1C_None::
    db $15, $2c, $29, $28, $55, $f0

ItemName1C_Divine::
    db $0d, $2c, $39, $2c, $31, $28, $55, $f0

ItemName1C_War::
    db $20, $24, $35, $55, $f0

ItemName1C_Mage::
    db $16, $24, $2a, $28, $55, $f0

ItemName1C_Fight::
    db $0f, $2c, $2a, $2b, $37, $55, $f0

ItemName1C_Sailor::
    db $1c, $24, $2c, $2f, $32, $35, $55, $f0

ItemName1C_Thief::
    db $1d, $2b, $2c, $28, $29, $55, $f0

ItemName1C_Cleric::
    db $0c, $2f, $28, $35, $2c, $26, $55, $f0

ItemName1C_62::
    db $f0

; Copies 16 bytes from [HL] to [DE]; each byte is written with interrupts off after waiting for
; rSTAT bit 1 to clear; clobbers A, C; HL and DE advance (the same 17 bytes appear in 7 banks)
CopyTileBytesToVRAM_Bank1C::
    ld c, $10

.loop:
    di

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [hli]
    ld [de], a
    inc de
    ei
    dec c
    jr nz, .loop
    ret

; HL = vBGMap0 + (hScrollY & $F8) * 4 + hScrollX / 8, the BG map entry for pixel (hScrollX,
; hScrollY); clobbers A, DE (the same 33 bytes appear in 18 banks)
BGMapAddressAtScroll_Bank1C_67AF::
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

; copies the B x C rectangle at DE to the BG map at HL (CopyRectToBGMapWrapped_1C with A = 0) and
; sets wTextCursorLo = HL + $1C1; on CGB copies it again with VRAM bank 1 selected and WRAM bank 2
; switched in (E-0121; a copy, not a clear: E-0226)
DrawRectBothBanksSetTextCursorLoPlus1C1::
    push de
    push bc
    push hl
    xor a
    call CopyRectToBGMapWrapped_1C
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
    ld a, $01
    ldh [rVBK], a
    ld a, $02
    ldh [rSVBK], a
    xor a
    call CopyRectToBGMapWrapped_1C
    ld a, $00
    ldh [rSVBK], a
    ld a, $00
    ldh [rVBK], a
    ret

; clears a rectangle (CopyRectToBGMapWrapped_1C with A = 0) and sets wTextCursorLo = HL + $1C1
; (E-0124)
ClearRectSetTextCursorLoPlus1C1_Bank1C::
    push de
    push bc
    push hl
    xor a
    call CopyRectToBGMapWrapped_1C
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
    ret

; copies a B x C rectangle from DE to the BG map at HL, wrapping at the screen and map edges
; (E-0129)
CopyRectToBGMapWrapped_1C::
    push hl
    push bc
    push de
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    and $1f
    ld b, a
    ld a, $20
    sub b
    ld b, a
    ld a, $14
    sub b
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
    and $1f
    cp d
    jr nc, .restore2
    pop de
    pop bc
    pop hl
    ld a, l
    sub $20
    ld l, a
    ld a, h
    sbc $00
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
    ld [hli], a
    ei
    ld a, l
    and $1f
    jr nz, .next
    ld a, l
    sub $20
    ld l, a
    ld a, h
    sbc $00
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
    add $20
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ld a, h
    and $9b
    ld h, a
    jp .skip

.return:
    ret

; clears wItemGrid ($18 bytes) and lists each item id 1-$62 present in the inventory, counting them
; in wGlyphListStart (E-0127)
ListDistinctInventoryItemsToItemGrid::
    push af
    push bc
    push de
    push hl
    ld hl, wItemGrid
    ld c, $18

.loop:
    xor a
    ld [hli], a
    dec c
    jr nz, .loop
    xor a
    ld [wGlyphListStart], a
    ld [wGridCursorX], a
    ld b, $01

.loop2:
    ld hl, wInventory
    ld c, $18

.loop3:
    ld a, [hl]
    cp b
    jr z, .read_glyph_list_start
    inc hl
    dec c
    jr nz, .loop3

.next:
    inc b
    ld a, b
    cp $63
    jr c, .loop2
    pop hl
    pop de
    pop bc
    pop af
    ret

.read_glyph_list_start:
    ld a, [wGlyphListStart]
    ld de, wItemGrid
    add e
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

; HL = wArg1/wArg2 = the word at ShopItemListTable + 2 * wScreenTableIndex (E-0118)
LoadArg1PointerForScreenTableIndex::
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

; LoadArg1PointerForScreenTableIndex, then wArg1 = the byte at that pointer + 4 * wItemGridY +
; wItemGridX (E-0119)
LoadArg1ByteForItemGridXItemGridY::
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

; removes 10 * wNumberTens + wNumberOnes copies of the selected item (wItemGrid[4 * wItemGridY +
; wItemGridX]) from the inventory and compacts it (E-0128) (C2 from E-0325: depositing one item at
; the Vault removes it and closes up the bag, a 0 at its end)
RemoveItemCountFromInventory::
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
    add e
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
    cp [hl]
    jr nz, .skip
    ld a, [wRecordsFlagged]
    and a
    jr z, .skip
    dec a
    ld [wRecordsFlagged], a
    inc hl
    inc c
    ld a, c
    cp $18
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
    cp $18
    jr c, .loop

.loop2:
    xor a
    ld [de], a
    inc de
    inc b
    ld a, b
    cp $18
    jr c, .loop2
    ret

; counts the inventory slots holding the item at wItemGrid[4 * wItemGridY + wItemGridX]; wCountTens
; = count / 10, wCountOnes = count mod 10 (E-0125)
CountItemInInventoryToDigits::
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
    cp b
    jr nz, .next
    inc c

.next:
    inc hl
    dec d
    jr nz, .loop
    ld l, c
    ld h, $00
    ld a, $0a
    call DivideHLByA
    ld [wCountOnes], a
    ld a, l
    ld [wCountTens], a
    ret

; for each entry from wScreenCounter of the destination list at HL and the source list at DE copies
; a 16-byte tile from bank $1F, until $FF; then wScreenStep += 1 (E-0127)
CopyTileListFromBank1F_1C::
    xor a
    ld [wGlyphListPos], a

.read_screen_counter:
    push hl
    push de
    ld a, [wScreenCounter]
    add a
    add_a_to_hl
    ld a, [hl]
    cp $ff
    jp z, .restore
    ld e, a
    inc hl
    ld h, [hl]
    ld l, e
    pop de
    push de
    push hl
    ld a, [wScreenCounter]
    add a
    add e
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
    ld b, $1f
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
    xor a
    ld [wScreenCounter], a
    ld [wGlyphListPos], a
    ld hl, wScreenStep
    inc [hl]
    ret

; copies $28 bytes from ShopMenu_Buy_SubtractArg1AmountFromGold_Data to wScreenList, runs
; DrawGoldDigitsAtHLWrapped_1C, counts the inventory items into wListPages and its digits into
; wItemCountTens/6, wScreenStep += 1 (E-0125)
InitItemListScreenListAndCount::
    ld hl, wScreenList
    ld de, ShopMenu_Buy_SubtractArg1AmountFromGold_Data
    ld bc, $0028

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld hl, wScreenBlock92
    call DrawGoldDigitsAtHLWrapped_1C
    ld hl, wInventory
    ld c, $18
    ld b, $00

.loop2:
    ld a, [hli]
    and a
    jr z, .next
    cp $ff
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
    and a
    jr z, .read_digits
    ld a, [wDigits + $1]
    add $e0
    ld [wItemCountTens], a

.read_digits:
    ld a, [wDigits + $2]
    add $e0
    ld [wItemCountOnes], a
    ld hl, wScreenStep
    inc [hl]
    ret

; copies the 8 x 5 box at wScreenList to wWindowTileBuffer + $70, draws it at scroll + $1CC and
; wScreenStep += 1 (E-0122)
DrawScreenListBoxAtWC370AndStep::
    ld de, wScreenList
    ld hl, wWindowTileBuffer + $70
    lb bc, $08, $05
    call CopyRectTo20ByteRowsJp_Bank1C
    call BGMapAddressAtScroll_Bank1C_67AF
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_1C
    ld hl, wScreenStep
    inc [hl]
    ret

CloseShopMenu_Case01_SetGlyphListPos::
    xor a
    ld [wGlyphListPos], a
    ld [wScreenCounter], a
    ld [wScreenState], a
    ld [wScreenStep], a
    ld [wMenuState], a
    ld hl, wGridCursorY
    inc [hl]
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

CloseShopMenu_Case00_CopyBytesDEToHL_Bank1C::
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a
    jr z, .call_bg_map_address_at_scroll_bank1_c_67_af
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank1C

.call_bg_map_address_at_scroll_bank1_c_67_af:
    call BGMapAddressAtScroll_Bank1C_67AF
    lb bc, $14, $0d
    ld de, $01cc
    call DrawScreenBufferRectToBGMap_1C
    ld hl, wGridCursorY
    inc [hl]
    ret

; clears wTextCounter0-wTextCounter4, wTextCounter5 and wTextCounter6, and sets wTextTimer = $3C
; (60) (E-0072)
ResetTextCounter0Counters::
    xor a
    ld [wTextCounter0], a
    ld [wTextCounter1], a
    ld [wTextCounter2], a
    ld [wTextCounter3], a
    ld [wTextCounter4], a
    ld [wTextCounter5], a
    ld [wTextCounter6], a
    ld a, $3c
    ld [wTextTimer], a
    ret

ShopMenu_WriteTextCounter6AndTextTimerEtc::
    ld a, [wJoypadPressedRepeat]
    bit 0, a
    jr nz, .check_text_timer
    and a
    jr z, .check_text_timer
    ld a, [wScreenState]
    cp $03
    jr z, .check_screen_step2
    ld a, [wScreenState]
    cp $04
    jr z, .check_screen_step
    jr .set_text_counter6_to_01

.check_screen_step:
    ld a, [wScreenStep]
    cp $05
    jr nz, .set_text_counter6_to_01
    jr .check_joypad_pressed_repeat

.check_screen_step2:
    ld a, [wScreenStep]
    cp $06
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
    ld a, $3c
    ld [wTextTimer], a

.check_text_timer:
    ld a, [wTextTimer]
    inc a
    ld [wTextTimer], a
    cp $3c
    ret c
    ld a, $3c
    ld [wTextTimer], a
    ld a, [wTextCounter0]
    jumptable
    dw ShopMenu_Shared01_ClearRectSetTextCursorLoPlus1C1_Bank1C
    dw ShopMenu_Shared01_ClearRectSetTextCursorLoPlus1C1_Bank1C_Case01
    dw ShopMenu_Shared01_ToStepItemDescriptionText
    dw ShopMenu_Shared01_Return

ShopMenu_Shared01_ClearRectSetTextCursorLoPlus1C1_Bank1C::
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $01a0
    add hl, de
    lb bc, $14, $05
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

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 20 x 5 tiles, one row per line
TileRect_1C_6B7D::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

; HL = $6BE1 and 1 calls to a 16-byte VRAM copier (CopyTileBytesToVRAM_*), one tile each (E-0238)
; record: tile (16 bytes, 2 bits per pixel)
Tiles_1C_6BE1::
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00 ; entry 0

ShopMenu_Shared01_ClearRectSetTextCursorLoPlus1C1_Bank1C_Case01::
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $01a0
    add hl, de
    lb bc, $14, $05
    ld de, TileRect_1C_6C0C
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    ld a, [wTextCounter0]
    inc a
    ld [wTextCounter0], a
    jp ShopMenu_Shared01_ToStepItemDescriptionText
    db $c9

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 20 x 5 tiles, one row per line
TileRect_1C_6C0C::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8a, $8b, $8c, $8d, $8e, $8f, $90, $91, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $92, $93, $94, $95, $96, $97, $98, $99, $9a, $9b, $9c, $9d, $9e, $9f, $a0, $a1, $a2, $a3, $b7 ; id 3
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 4

ShopMenu_Shared01_ToStepItemDescriptionText::
    farcall StepItemDescriptionText
    ret

ShopMenu_Shared01_Return::
    ret

; draws tiles $C5, $BE, $C6 at BGMapAddressAtScroll + $18E, two entries apart (E-0121)
DrawC5BEC6AtScroll18E_Bank1C::
    push hl
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $018e
    add hl, de
    push hl
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, $c5
    ld [hl], a
    ei
    pop hl
    inc hl
    inc hl
    push hl
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, $be
    ld [hl], a
    ei
    pop hl
    inc hl
    inc hl
    call StepBGMapAddressBackOnScrollWrap
    di
    call WaitForVRAMAccess
    ld a, $c6
    ld [hl], a
    ei
    pop hl
    ret

; DEHL = A * EHL (24-bit by 8-bit multiply through wArg1-wArg4) (E-0121)
Multiply24By8_Bank1C::
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
    add e
    ld h, a
    ld a, [wArg4]
    ld e, a
    adc c
    ld e, a
    ld a, b
    adc $00
    ld d, a
    ret

; implements script command type E6 (SCRIPT_VAULT_CLOSE): ends the Vault session (runs
; CloseShopMenu's code); reached through ScriptCommandE6 in bank $10 (E-0038, E-0244)
CloseVaultMenu::
    call CloseShopMenu
    ret

; implements script command type E5 (SCRIPT_VAULT): the item Vault: 'What item should I store
; for...', 'What will you be taking out?' (mode 2); reached through ScriptCommandE5 in bank $10
; (E-0038, E-0244) (C2 from E-0325: talking to the Vault clerk runs it with 'Deposit: Item / Gold /
; Exit')
VaultMenu::
    ld a, [wScreenState]
    jumptable
    dw VaultMenu_Init
    dw VaultMenu_Setup
    dw VaultMenu_ChooseAction
    dw VaultMenu_Store
    dw VaultMenu_TakeOut

; state 0 of VaultMenu: clears the screen state (E-0276)
VaultMenu_Init::
    ld bc, $0070
    ld hl, wScreenState

.loop:
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld hl, wWindowTileBuffer + $64
    ld de, wScreenTileBuffer
    ld bc, $0104
    call CopyBytesDEToHL_Bank1C
    ld a, [wIsCGB]
    and a
    jr z, .set_message_mode_to_02
    ld hl, wWindowAttrBuffer + $64
    ld de, wScreenAttrBuffer
    ld bc, $0104
    call CopyLow3BitsToWRAMBank2_Bank1C

.set_message_mode_to_02:
    ld a, $02
    ld [wMessageMode], a
    xor a
    ld [wGlyphListPos], a
    ld [wScreenCounter], a
    ld [wNumberTens], a
    ld a, $01
    ld [wNumberOnes], a
    ld [wNumberEditPos], a
    ld hl, wScreenState
    inc [hl]
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; screen setup: tile lists, the item list screen and its box (E-0276)
VaultMenu_Setup::
    ld a, [wScreenStep]
    jumptable
    dw VaultMenu_Setup_CopyTileBytesToVRAM_Bank1C
    dw VaultMenu_Setup_ToCopyTileListFromBank1F_1C
    dw VaultMenu_Setup_ToVaultMenu_WriteSavedSpriteClipModeAndListPagesAndStep
    dw VaultMenu_Setup_CopyFromBankWaitVRAM
    dw VaultMenu_Setup_ToInitItemListScreenListAndCount
    dw VaultMenu_Setup_DrawScreenListBoxAtWC370AndStep

VaultMenu_Setup_CopyTileBytesToVRAM_Bank1C::
    ld hl, vTiles1 + $240
    ld de, vTiles2 + $7d0
    call CopyTileBytesToVRAM_Bank1C
    call CopyTileBytesToVRAM_Bank1C
    call CopyTileBytesToVRAM_Bank1C
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a

VaultMenu_Setup_ToCopyTileListFromBank1F_1C::
    ld hl, TileCopyDestList_1C_5F86
    ld de, TileCopySrcList_1C_604A
    call CopyTileListFromBank1F_1C
    ret

VaultMenu_Setup_ToVaultMenu_WriteSavedSpriteClipModeAndListPagesAndStep::
    farcall VaultMenu_WriteSavedSpriteClipModeAndListPages
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

VaultMenu_Setup_CopyFromBankWaitVRAM::
    ld hl, vTiles1 + $240
    ld de, Tiles1Plus2D0Tiles_1F_43C0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles1 + $250
    ld de, Tiles1Plus250Tiles_1F_4340
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles1 + $260
    ld de, Tiles1Plus260Tiles_1F_40E0
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, vTiles1 + $270
    ld de, Tiles1Plus6F0Tiles_1F_4330
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

VaultMenu_Setup_ToInitItemListScreenListAndCount::
    call InitItemListScreenListAndCount
    ret

VaultMenu_Setup_DrawScreenListBoxAtWC370AndStep::
    ld de, TileRect_1C_6DEF
    ld hl, wWindowTileBuffer + $64
    lb bc, $0b, $07
    call CopyRectTo20ByteRowsJp_Bank1C
    call DrawScreenListBoxAtWC370AndStep
    xor a
    ld [wScreenStep], a
    ld [wTwoChoiceCursor], a
    ld hl, wScreenState
    inc [hl]
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; a packed tile rectangle given to a rectangle copier, as DE with B = width and C = rows, or as
; wArg1/wArg2 with wArg3 = width and wArg4 = rows (E-0161, E-0177, E-0187)
; record: 11 x 7 tiles, one row per line
TileRect_1C_6DEF::
    db $b0, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b1, $b2 ; id 0
    db $b6, $c3, $a6, $cf, $a5, $a7, $df, $eb, $ad, $c3, $b7 ; id 1
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 2
    db $b6, $c3, $ea, $eb, $ad, $ed, $ee, $ef, $ab, $ac, $b7 ; id 3
    db $b6, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $c3, $b7 ; id 4
    db $b6, $c3, $a9, $a4, $eb, $ad, $c3, $c3, $c3, $c3, $b7 ; id 5
    db $b3, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b4, $b5 ; id 6

; the Vault's choice menu: Up/Down move the cursor, A selects, B leaves (E-0276)
VaultMenu_ChooseAction::
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
    and a
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
    cp $02
    jr c, .skip
    xor a
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
    cp b
    jr z, .set_screen_byte_b2
    ld a, [wListLastRow]
    ld b, a
    xor a
    ld [wItemGridX], a
    ld [wItemGridY], a

.set_screen_byte_b2:
    ld a, b
    ld [wScreenByteB2], a
    ld a, [wListLastRow]
    and a
    jr z, .check_screen_state
    cp $01
    jr z, .check_screen_state2
    ld a, $02
    ld [wTwoChoiceCursor], a

.clear_script_command_type:
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.check_screen_state:
    ld a, [wScreenState]
    inc a
    ld [wScreenState], a
    xor a
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

VaultMenu_ChooseAction_WriteScreenByteB3::
    ld a, [wJoypadRepeatTimer]
    cp $14
    jr c, .skip
    ld a, [wScreenByteB3]
    inc a
    ld [wScreenByteB3], a
    cp $10
    jr c, .skip
    cp $18
    jr c, VaultMenu_ChooseAction_ReadListLastRow
    xor a
    ld [wScreenByteB3], a

.skip:
    ld b, $bb
    jr VaultMenu_ChooseAction_BGMapAddressAtScroll_Bank1C_67AF_ReadListLastRow

VaultMenu_ChooseAction_ReadListLastRow::
    ld b, $c3
    jr VaultMenu_ChooseAction_BGMapAddressAtScroll_Bank1C_67AF_ReadListLastRow

VaultMenu_ChooseAction_BGMapAddressAtScroll_Bank1C_67AF::
    ld b, $bc

VaultMenu_ChooseAction_BGMapAddressAtScroll_Bank1C_67AF_ReadListLastRow::
    ld a, [wListLastRow]
    sla a
    ld hl, VaultMenu_ChooseAction_BGMapAddressAtScroll_Bank1C_67AF_Data
    add_a_to_hl
    ld a, [hli]
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

VaultMenu_ChooseAction_BGMapAddressAtScroll_Bank1C_67AF_Data::
    db $21, $00, $61, $00, $a1, $00

; storing: moves items from wInventory into wItemStorage (RemoveItemCountFromInventory) (E-0276)
VaultMenu_Store::
    ld a, [wScreenStep]
    jumptable
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

VaultMenu_Store_ToVaultMenu_Store_Case00_WaitForVRAMAccess::
    farcall VaultMenu_Store_Case00_WaitForVRAMAccess
    ret

VaultMenu_Store_DrawRectBothBanksSetTextCursorLoPlus1C1::
    call BGMapAddressAtScroll_Bank1C_67AF
    lb bc, $0b, $09
    ld de, vBGMap1 + $300
    call DrawRectBothBanksSetTextCursorLoPlus1C1
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

VaultMenu_Store_LoadThreeTilesAndDrawRows4603To460B::
    farcall LoadThreeTilesAndDrawRows4603To460B
    xor a
    ld [wScreenByteED], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

VaultMenu_Store_ToVaultMenu_Store_Case03_WriteTwoChoiceCursorAndScreenStepEtc::
    farcall VaultMenu_Store_Case03_WriteTwoChoiceCursorAndScreenStepEtc
    ret

VaultMenu_Store_SetScreenState::
    ld a, $01
    ld [wScreenState], a
    ld a, $02
    ld [wScreenStep], a
    xor a
    ld [wTwoChoiceCursor], a
    ld [wScreenByteED], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

VaultMenu_Store_ToDrawRect0088AtBGMap1370AndStep::
    farcall DrawRect0088AtBGMap1370AndStep
    ret

VaultMenu_Store_DrawRect0140AtBGMap13E0AndStep::
    call VaultMenu_Store_WriteGlyphListPos
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp $04
    jr c, VaultMenu_Store_DrawRect0140AtBGMap13E0AndStep
    xor a
    ld [wScreenCounter], a
    farcall DrawRect0140AtBGMap13E0AndStep
    ret

VaultMenu_Store_WriteCursorBlinkB8AndGlyphListPosEtc::
    call VaultMenu_Store_WriteGlyphListPos
    ld a, [wScreenState]
    cp $03
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
    cp $f0
    jp z, .clear_glyph_list_pos
    ld [wCursorBlinkB8], a
    push hl
    ld hl, $4010
    swap a
    ld d, a
    and $f0
    ld e, a
    ld a, d
    and $0f
    ld d, a
    add hl, de
    ld e, l
    ld d, h
    push de
    ld a, [wScreenCounter]
    sla a
    ld de, TileDestTable_1C_6289
    add e
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
    cp $8d
    jr z, .check_glyph_list_pos
    cp $8e
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
    ld b, $1f
    ld c, $10
    ld a, [wCursorBlinkB8]
    cp $8d
    jr z, .call_or_from_bank_wait_vram
    cp $8e
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
    xor a
    ld [wGlyphListPos], a
    ld a, [wScreenCounter]
    inc a
    ld [wScreenCounter], a
    cp $04
    jr c, .return
    xor a
    ld [wScreenCounter], a
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

.return:
    ret

VaultMenu_Store_ToVaultMenu_Store_Case07_DrawRectSetTextCursorLoPlus21_Bank1D::
    farcall VaultMenu_Store_Case07_DrawRectSetTextCursorLoPlus21_Bank1D
    ret

VaultMenu_Store_ToVaultMenu_Store_Case08_HLToDecimalDigits::
    farcall VaultMenu_Store_Case08_HLToDecimalDigits
    ret

VaultMenu_Store_ToVaultMenu_Store_Case0A_WriteDigitsAndScreenByte93Etc::
    farcall VaultMenu_Store_Case0A_WriteDigitsAndScreenByte93Etc
    ret

VaultMenu_Store_ToVaultMenu_Store_Case0B_BlinkCursorSelectedRecord_Bank1D_4D41::
    farcall VaultMenu_Store_Case0B_BlinkCursorSelectedRecord_Bank1D_4D41
    ret

VaultMenu_Store_DrawRectBothBanksSetTextCursorLoPlus1C1_Case0C::
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0088
    add hl, de
    lb bc, $0c, $09
    ld de, vBGMap1 + $370
    call DrawRectBothBanksSetTextCursorLoPlus1C1
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    lb bc, $07, $03
    ld de, vBGMap1 + $3e0
    call DrawRectBothBanksSetTextCursorLoPlus1C1
    ld a, $03
    ld [wScreenStep], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

VaultMenu_Store_ToVaultMenu_Store_Case0D_BlinkCursorBlinkCD_Bank1D_4F99::
    farcall VaultMenu_Store_Case0D_BlinkCursorBlinkCD_Bank1D_4F99
    ret

VaultMenu_Store_ReadScreenState::
    ld a, [wScreenState]
    cp $03
    jr z, .call_remove_item_count_from_inventory
    farcall VaultMenu_Store_Case0E_TenTimesNumberTensPlusNumberOnes
    ret

.call_remove_item_count_from_inventory:
    call RemoveItemCountFromInventory
    farcall VaultMenu_Store_Case0E_WriteTwoChoiceCursorAndTextCounter1Etc
    farcall VaultMenu_Store_Case0E_VaultMenu_Store_MapItemsToInventory
    ret

VaultMenu_Store_InitItemListScreenListAndDraw::
    call InitItemListScreenListAndDraw
    farcall VaultMenu_Store_Case0F_WriteScreenStepAndScriptCommandTypeEtc
    ret

VaultMenu_Store_DrawRectBothBanksSetTextCursorLoPlus1C1_Case10::
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0088
    add hl, de
    lb bc, $0c, $09
    ld de, vBGMap1 + $370
    call DrawRectBothBanksSetTextCursorLoPlus1C1
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0140
    add hl, de
    lb bc, $07, $03
    ld de, vBGMap1 + $3e0
    call DrawRectBothBanksSetTextCursorLoPlus1C1
    xor a
    ld [wTwoChoiceCursor], a
    ld a, $04
    ld [wScreenStep], a
    ret

VaultMenu_Store_ToDrawRect0147AndResetNumberEditPos::
    farcall DrawRect0147AndResetNumberEditPos
    ret

VaultMenu_Store_ToVaultMenu_Store_Number24ToPackedBCD::
    farcall VaultMenu_Store_Number24ToPackedBCD
    ret

VaultMenu_Store_CopyTileBytesToVRAM_Bank1C::
    ld hl, vTiles1 + $4c0
    ld de, vTiles2 + $700
    call CopyTileBytesToVRAM_Bank1C
    ld hl, vTiles1 + $4c0
    ld de, Tiles1Plus4C0Tiles_1F_4500
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    ld a, [wScreenStep]
    inc a
    ld [wScreenStep], a
    ret

VaultMenu_Store_ToVaultMenu_Store_Case14_BGMapAddressAtScroll_Bank1D::
    farcall VaultMenu_Store_Case14_BGMapAddressAtScroll_Bank1D
    ret

VaultMenu_Store_ToVaultMenu_Store_Case15_WriteScreenStepAndTwoChoiceCursorEtc::
    farcall VaultMenu_Store_Case15_WriteScreenStepAndTwoChoiceCursorEtc
    ret

; clears the rectangle at scroll + $147, copies a tile, runs InitItemListScreenListAndDraw,
; wScreenStep = 3, wTwoChoiceCursor = 2 and requests script $80 (E-0124)
ClearRect147AndAskTwoChoice::
    call BGMapAddressAtScroll_Bank1C_67AF
    ld de, $0147
    add hl, de
    ld de, vBGMap1 + $370
    lb bc, $0d, $03
    call DrawRectBothBanksSetTextCursorLoPlus1C1
    ld hl, vTiles2 + $700
    ld de, vTiles1 + $4c0
    call CopyTileBytesToVRAM_Bank1C
    call InitItemListScreenListAndDraw
    ld a, $03
    ld [wScreenStep], a
    ld a, $02
    ld [wTwoChoiceCursor], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

VaultMenu_Store_DrawGoldDigitsAtHLWrapped_1C::
    ld hl, wScreenList
    ld de, ShopMenu_Buy_SubtractArg1AmountFromGold_Data
    ld bc, $0020

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld hl, wScreenBlock92
    call DrawGoldDigitsAtHLWrapped_1C
    call BGMapAddressAtScroll_Bank1C_67AF
    ld a, $0c
    add_a_to_hl
    ld de, wScreenList
    lb bc, $08, $02
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    farcall VaultMenu_Store_Number24ToPackedBCD
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

VaultMenu_Store_ClearRect147AndAskTwoChoice::
    call ClearRect147AndAskTwoChoice
    ld a, $01
    ld [wScreenState], a
    ld a, $02
    ld [wScreenStep], a
    ret

; taking out: lists wItemStorage and moves items back into wInventory (E-0276)
VaultMenu_TakeOut::
    ld a, [wScreenStep]
    jumptable
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

VaultMenu_TakeOut_Case03_WriteTwoChoiceCursorAndScreenStepEtc_Case03::
    farcall VaultMenu_TakeOut_Case03_WriteTwoChoiceCursorAndScreenStepEtc
    ret

VaultMenu_TakeOut_Case15_WriteScreenStepAndTwoChoiceCursorEtc_Case15::
    farcall VaultMenu_TakeOut_Case15_WriteScreenStepAndTwoChoiceCursorEtc
    ret

; copies $20 bytes from ShopMenu_Buy_SubtractArg1AmountFromGold_Data to wScreenList, counts the
; inventory items into wListPages and its digits, and draws the 8 x 4 list at scroll + $0C (E-0127)
InitItemListScreenListAndDraw::
    ld hl, wScreenList
    ld de, ShopMenu_Buy_SubtractArg1AmountFromGold_Data
    ld bc, $0020

.loop:
    ld a, [de]
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ld hl, wScreenBlock92
    call DrawGoldDigitsAtHLWrapped_1C
    ld hl, wInventory
    ld c, $00
    ld b, $00

.loop2:
    ld a, [hli]
    and a
    jr z, .next
    cp $ff
    jr z, .next
    inc b

.next:
    inc c
    ld a, c
    cp $18
    jr c, .loop2
    ld a, b
    ld [wListPages], a
    ld l, a
    ld h, $00
    call HLToDecimalDigits
    ld a, [wDigits + $1]
    and a
    jr z, .read_digits
    ld a, [wDigits + $1]
    add $e0
    ld [wItemCountTens], a

.read_digits:
    ld a, [wDigits + $2]
    add $e0
    ld [wItemCountOnes], a
    call BGMapAddressAtScroll_Bank1C_67AF
    ld a, $0c
    add_a_to_hl
    ld de, wScreenList
    lb bc, $08, $04
    call ClearRectSetTextCursorLoPlus1C1_Bank1C
    ret

VaultMenu_Store_WriteGlyphListPos::
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
    add e
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
    ld b, $1f
    ld c, $10
    call CopyFromBankWaitVRAM
    pop de
    ld a, [wGlyphListPos]
    inc a
    ld [wGlyphListPos], a
    cp $09
    jr c, .loop
    xor a
    ld [wGlyphListPos], a
    ret
    ds $d10, $00
