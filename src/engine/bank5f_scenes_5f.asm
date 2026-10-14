; ROM bank $5F: scene and message scripts; map data
; The annotated listing of this bank is build/listing/bank5f.asm.

SECTION "Bank 5F", ROMX[$4000], BANK[$5F]
    db $5f

; compressed tileset of map $30 (the first map record using it)
; LZSS-compressed: 1133 bytes that expand to 1664 (E-0016, E-0017)
Map30Tileset::
    INCBIN "maps/map30/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map30Palettes::
    dw $7c01, $7fff, $7fe1, $0000 ; entry 0
    dw $1154, $53de, $229a, $0084 ; entry 1
    dw $0180, $53de, $02c8, $0084 ; entry 2
    dw $10d6, $53de, $227d, $0084 ; entry 3
    dw $1129, $53de, $1996, $0ca5 ; entry 4
    dw $7cc0, $7fff, $5ad6, $0000 ; entry 5
    dw $218c, $4f18, $3a52, $0ca5 ; entry 6
    dw $218c, $4f18, $3a52, $0ca5 ; entry 7

; compressed tileset of map $31 (the first map record using it)
; LZSS-compressed: 1298 bytes that expand to 1440 (E-0016, E-0017)
Map31Tileset::
    INCBIN "maps/map31/tileset.lz"

Map31Palettes::
    dw $7c01, $7fff, $7fe1, $0000 ; entry 0
    dw $0192, $53de, $22ba, $0000 ; entry 1
    dw $0284, $53de, $034a, $0000 ; entry 2
    dw $44e8, $3f7f, $0216, $0000 ; entry 3
    dw $0192, $3f7f, $034a, $0000 ; entry 4
    dw $001b, $2bff, $023f, $0000 ; entry 5
    dw $7da0, $7fff, $5ad6, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 2 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map31Screens0::
    dfar Map31Screens0_Y0X0 ; entry 0
    dfar Map31Screens0_Y1X0 ; entry 1

Map31Attrs0::
    dfar Map31Attrs0_Y0X0 ; entry 0
    dfar Map31Attrs0_Y1X0 ; entry 1

; LZSS-compressed: 245 bytes that expand to 360 (E-0016, E-0017)
Map31Screens0_Y0X0::
    INCBIN "maps/map31/screens0_y0_x0.lz"

; LZSS-compressed: 222 bytes that expand to 360 (E-0016, E-0017)
Map31Screens0_Y1X0::
    INCBIN "maps/map31/screens0_y1_x0.lz"

; LZSS-compressed: 79 bytes that expand to 360 (E-0016, E-0017)
Map31Attrs0_Y0X0::
    INCBIN "maps/map31/attrs0_y0_x0.lz"

; LZSS-compressed: 85 bytes that expand to 360 (E-0016, E-0017)
Map31Attrs0_Y1X0::
    INCBIN "maps/map31/attrs0_y1_x0.lz"

; compressed tileset of map $36 (the first map record using it)
; LZSS-compressed: 393 bytes that expand to 768 (E-0016, E-0017)
Map36Tileset::
    INCBIN "maps/map36/tileset.lz"

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map36Screens0::
    dfar Map36Screens0_Y0X0 ; entry 0

Map36Attrs0::
    dfar Map36Attrs0_Y0X0 ; entry 0

; LZSS-compressed: 195 bytes that expand to 360 (E-0016, E-0017)
Map36Screens0_Y0X0::
    INCBIN "maps/map36/screens0_y0_x0.lz"

; LZSS-compressed: 103 bytes that expand to 360 (E-0016, E-0017)
Map36Attrs0_Y0X0::
    INCBIN "maps/map36/attrs0_y0_x0.lz"

; compressed tileset of map $3B (the first map record using it)
; LZSS-compressed: 929 bytes that expand to 1600 (E-0016, E-0017)
Map3BTileset::
    INCBIN "maps/map3_b/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map3BPalettes::
    dw $01c8, $7fff, $46ad, $0002 ; entry 0
    dw $46ad, $3f7f, $0216, $0002 ; entry 1
    dw $001b, $2bff, $023f, $0000 ; entry 2
    dw $0108, $3f7f, $0216, $0002 ; entry 3
    dw $001b, $3f7f, $0216, $0002 ; entry 4
    dw $4f18, $3a52, $218c, $0ca5 ; entry 5
    dw $4f18, $3a52, $218c, $0ca5 ; entry 6
    dw $4f18, $3a52, $218c, $0ca5 ; entry 7

; 1 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map3BScreens0::
    dfar Map3BScreens0_Y0X0 ; entry 0

Map3BAttrs0::
    dfar Map3BAttrs0_Y0X0 ; entry 0

Map3BScreens4::
    dfar Map3BScreens4_Y0X0 ; entry 0

Map3BAttrs4::
    dfar Map3BAttrs4_Y0X0 ; entry 0

; LZSS-compressed: 141 bytes that expand to 360 (E-0016, E-0017)
Map3BScreens0_Y0X0::
    INCBIN "maps/map3_b/screens0_y0_x0.lz"

; LZSS-compressed: 184 bytes that expand to 360 (E-0016, E-0017)
Map3BScreens4_Y0X0::
    INCBIN "maps/map3_b/screens4_y0_x0.lz"

; LZSS-compressed: 53 bytes that expand to 360 (E-0016, E-0017)
Map3BAttrs0_Y0X0::
    db $68, $01, $05, $00, $00, $03, $05, $02, $0b, $05, $fe, $ff, $4d, $05, $5e, $0f
    db $4d, $05, $96, $0f, $13, $02, $02, $05, $f6, $02, $05, $88, $05, $01, $04, $04
    db $05, $f8, $0e, $00, $04, $05, $fa, $04, $05, $88, $06, $05, $f8, $06, $05, $88
    db $02, $05, $41, $1f, $13

; LZSS-compressed: 49 bytes that expand to 360 (E-0016, E-0017)
Map3BAttrs4_Y0X0::
    db $68, $01, $01, $00, $00, $03, $01, $02, $0b, $01, $fe, $ff, $4d, $01, $22, $0f
    db $0d, $01, $28, $08, $01, $8a, $0f, $0b, $01, $fc, $f6, $01, $b2, $0f, $07, $01
    db $f6, $fa, $01, $da, $0c, $01, $d6, $0f, $01, $01, $ae, $0f, $1d, $01, $41, $1f
    db $13

; compressed tileset of map $3C (the first map record using it)
; LZSS-compressed: 1108 bytes that expand to 1536 (E-0016, E-0017)
Map3CTileset::
    INCBIN "maps/map3_c/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map3CPalettes::
    dw $7da0, $7fff, $7fe0, $0063 ; entry 0
    dw $7da0, $7fff, $5ad6, $0063 ; entry 1
    dw $2d91, $3fbf, $4698, $0000 ; entry 2
    dw $02c0, $3f7f, $03e2, $0000 ; entry 3
    dw $012f, $3f7f, $01d5, $0044 ; entry 4
    dw $1528, $3f7f, $2a10, $0044 ; entry 5
    dw $11d4, $53de, $22ba, $0000 ; entry 6
    dw $0044, $0044, $0044, $0044 ; entry 7

; 3 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map3CScreens0::
    dfar Map3CScreens0_Y0X0 ; entry 0
    dfar Map3CScreens0_Y0X1 ; entry 1
    dfar Map3CScreens0_Y0X2 ; entry 2

Map3CAttrs0::
    dfar Map3CAttrs0_Y0X0 ; entry 0
    dfar Map3CAttrs0_Y0X1 ; entry 1
    dfar Map3CAttrs0_Y0X2 ; entry 2

; LZSS-compressed: 230 bytes that expand to 360 (E-0016, E-0017)
Map3CScreens0_Y0X0::
    INCBIN "maps/map3_c/screens0_y0_x0.lz"

; LZSS-compressed: 222 bytes that expand to 360 (E-0016, E-0017)
Map3CScreens0_Y0X1::
    INCBIN "maps/map3_c/screens0_y0_x1.lz"

; LZSS-compressed: 259 bytes that expand to 360 (E-0016, E-0017)
Map3CScreens0_Y0X2::
    INCBIN "maps/map3_c/screens0_y0_x2.lz"

; LZSS-compressed: 118 bytes that expand to 360 (E-0016, E-0017)
Map3CAttrs0_Y0X0::
    INCBIN "maps/map3_c/attrs0_y0_x0.lz"

; LZSS-compressed: 103 bytes that expand to 360 (E-0016, E-0017)
Map3CAttrs0_Y0X1::
    INCBIN "maps/map3_c/attrs0_y0_x1.lz"

; LZSS-compressed: 123 bytes that expand to 360 (E-0016, E-0017)
Map3CAttrs0_Y0X2::
    INCBIN "maps/map3_c/attrs0_y0_x2.lz"

; compressed tileset of map $43 (the first map record using it)
; LZSS-compressed: 1291 bytes that expand to 1536 (E-0016, E-0017)
Map43Tileset::
    INCBIN "maps/map43/tileset.lz"

; the $40 bytes LoadBGPaletteBufferFromBank copies for a map record (E-0142)
; record: one CGB palette: 4 BGR555 colours
Map43Palettes::
    dw $7da0, $7fff, $7fe0, $0000 ; entry 0
    dw $7da0, $4f18, $260c, $0000 ; entry 1
    dw $7da0, $4f18, $7fe0, $0000 ; entry 2
    dw $0941, $4f18, $1627, $0000 ; entry 3
    dw $0941, $4f18, $260c, $0000 ; entry 4
    dw $012f, $4f3a, $01d5, $0000 ; entry 5
    dw $012f, $3fbf, $01d5, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; 3 screen far pointers, row by row (E-0142)
; record: compressed 20 x 18 screen; its ROM bank
Map43Screens0::
    dfar Map43Screens0_Y0X0 ; entry 0
    dfar Map43Screens0_Y0X1 ; entry 1
    dfar Map43Screens0_Y0X2 ; entry 2

Map43Attrs0::
    dfar Map43Attrs0_Y0X0 ; entry 0
    dfar Map43Attrs0_Y0X1 ; entry 1
    dfar Map43Attrs0_Y0X2 ; entry 2

Map43Screens1::
    dfar Map43Screens1_Y0X0 ; entry 0
    dfar Map43Screens0_Y0X1 ; entry 1
    dfar Map43Screens0_Y0X2 ; entry 2

Map43Attrs1::
    dfar Map43Attrs1_Y0X0 ; entry 0
    dfar Map43Attrs0_Y0X1 ; entry 1
    dfar Map43Attrs0_Y0X2 ; entry 2

; LZSS-compressed: 275 bytes that expand to 360 (E-0016, E-0017)
Map43Screens0_Y0X0::
    INCBIN "maps/map43/screens0_y0_x0.lz"

; LZSS-compressed: 274 bytes that expand to 360 (E-0016, E-0017)
Map43Screens1_Y0X0::
    INCBIN "maps/map43/screens1_y0_x0.lz"

; LZSS-compressed: 292 bytes that expand to 360 (E-0016, E-0017)
Map43Screens0_Y0X1::
    INCBIN "maps/map43/screens0_y0_x1.lz"

; LZSS-compressed: 250 bytes that expand to 360 (E-0016, E-0017)
Map43Screens0_Y0X2::
    INCBIN "maps/map43/screens0_y0_x2.lz"

; LZSS-compressed: 131 bytes that expand to 360 (E-0016, E-0017)
Map43Attrs0_Y0X0::
    INCBIN "maps/map43/attrs0_y0_x0.lz"

; LZSS-compressed: 128 bytes that expand to 360 (E-0016, E-0017)
Map43Attrs1_Y0X0::
    INCBIN "maps/map43/attrs1_y0_x0.lz"

; LZSS-compressed: 122 bytes that expand to 360 (E-0016, E-0017)
Map43Attrs0_Y0X1::
    INCBIN "maps/map43/attrs0_y0_x1.lz"

; LZSS-compressed: 110 bytes that expand to 360 (E-0016, E-0017)
Map43Attrs0_Y0X2::
    INCBIN "maps/map43/attrs0_y0_x2.lz"

; wMessageState ($FF = idle) steps a message: 0 opens the message window (unless wMessageGroup bit
; 7) at the bottom, or at the top when hPlayerY >= $48, with sound $69; 1 waits for the window, then
; ShowMessageFromMessageIndex starts the text; 2 waits until wTextFlags bit 0 clears (text done),
; then closes the window (unless wMessageGroup bit 6); 3 waits for the close. When wStepPtrLo is 0,
; state 0 also calls SetBit1OfPlayerAndObjectFlags and state 3 ClearBit1OfPlayerAndObjectFlags
; (probably freezing and releasing the player and objects). The steps after state 3 are not read
; (E-0079)
; code: branches on wMessageState; dispatches on wMessageState
RunMessageBox::
    ld a, [wMessageState]
    cp $ff
    jr nz, .skip
    ret

.skip:
    jumptable
    dw RunMessageBox_SetBit1OfPlayerAndObjectFlags
    dw RunMessageBox_ShowMessageFromMessageIndex
    dw RunMessageBox_QueueSoundEffect
    dw RunMessageBox_WriteMessageState

; step 0 of RunMessageBox: branches on wStepPtrLo; calls SetBit1OfPlayerAndObjectFlags; branches on
; wMessageGroup; calls FillTilesRequest; calls FillTilesFromRequest; plays sound $69; sets
; wTextWindowState to 1; ...
RunMessageBox_SetBit1OfPlayerAndObjectFlags::
    ld a, [wStepPtrLo]
    or a
    jr nz, .check_message_group
    farcall SetBit1OfPlayerAndObjectFlags

.check_message_group:
    ld a, [wMessageGroup]
    bit 7, a
    jr nz, .done
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    call FillTilesFromRequest
    ld a, $69
    call QueueSoundEffect
    ld a, $01
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a
    ldh a, [hPlayerY]
    cp $48
    jr c, .done
    ld a, $81
    ld [wTextWindowState], a
    ld a, $01
    ldh [hSpriteWindowClipMode], a

.done:
    ld hl, wMessageState
    inc [hl]
    ret

; step 1 of RunMessageBox: branches on wMessageGroup; returns if bit 7 of wMessageGroup is set;
; calls ShowMessageFromMessageIndex; advances wMessageState
RunMessageBox_ShowMessageFromMessageIndex::
    ld a, [wMessageGroup]
    bit 7, a
    jr nz, .call_show_message_from_message_index
    ld a, [wTextWindowState]
    and $03
    ret nz

.call_show_message_from_message_index:
    call ShowMessageFromMessageIndex
    ld hl, wMessageState
    inc [hl]
    ret

; step 2 of RunMessageBox: returns if bit 0 of wTextFlags is set; branches on wMessageGroup; plays
; sound $69; sets wTextWindowState to 2; sets wTextWindowStep to 0; sets hSpriteWindowClipMode to 0;
; branches on hPlayerY; ...
RunMessageBox_QueueSoundEffect::
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld a, [wMessageGroup]
    bit 6, a
    jr nz, .done
    ld a, $69
    call QueueSoundEffect
    ld a, $02
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $00
    ldh [hSpriteWindowClipMode], a
    ldh a, [hPlayerY]
    cp $48
    jr c, .done
    ld a, $82
    ld [wTextWindowState], a

.done:
    ld hl, wMessageState
    inc [hl]
    ret

; step 3 of RunMessageBox: branches on wMessageGroup; branches on wStepPtrLo; calls
; ClearBit1OfPlayerAndObjectFlags; sets wMessageState to $ff
RunMessageBox_WriteMessageState::
    ld a, [wMessageGroup]
    bit 6, a
    jr nz, .check_step_ptr_lo
    ld a, [wTextWindowState]
    and $03
    jr z, .check_step_ptr_lo
    ret

.check_step_ptr_lo:
    ld a, [wStepPtrLo]
    or a
    jr nz, .set_message_state_to_FF
    farcall ClearBit1OfPlayerAndObjectFlags

.set_message_state_to_FF:
    ld a, $ff
    ld [wMessageState], a
    ret

; HL = wMessageIndex/wMessageGroup, then ShowMessageHL (E-0079)
ShowMessageFromMessageIndex::
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a

; L = string index (wStringIndex, category 0), H & $3F = message group, which selects one of 12
; table entries (rst $00); when wMapType has bit 7 set and is not $80 another path is taken (not
; read) (E-0079)
ShowMessageHL::
    ld a, [wMapType]
    cp $80
    jr z, .skip
    bit 7, a
    jp nz, ShowMessageHL_ToBeginStringDisplay_Bank89_SetStringIndex

.skip:
    ld a, h
    and $3f
    ld h, a
    ld a, l
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    ld a, h
    jumptable
    dw ShowMessageHL_ToBeginStringDisplay_Bank28
    dw ShowMessageHL_ToBeginStringDisplay_Bank29
    dw ShowMessageHL_ToBeginStringDisplay_Bank2A
    dw ShowMessageHL_ToBeginStringDisplay_Bank2B
    dw ShowMessageHL_ToBeginStringDisplay_Bank2C
    dw ShowMessageHL_ToBeginStringDisplay_Bank2D
    dw ShowMessageHL_ToBeginStringDisplay_Bank2E
    dw ShowMessageHL_ToBeginStringDisplay_Bank2E
    dw ShowMessageHL_ToBeginStringDisplay_Bank7C
    dw ShowMessageHL_ToBeginStringDisplay_Bank80
    dw ShowMessageHL_ToBeginStringDisplay_Bank80
    dw ShowMessageHL_ToBeginStringDisplay_Bank82
    dw ShowMessageHL_ToBeginStringDisplay_Bank86
    dw ShowMessageHL_ToBeginStringDisplay_Bank89

; step 0 of ShowMessageHL: calls BeginStringDisplay_Bank28
ShowMessageHL_ToBeginStringDisplay_Bank28::
    farcall BeginStringDisplay_Bank28
    ret

; step 1 of ShowMessageHL: calls BeginStringDisplay_Bank29
ShowMessageHL_ToBeginStringDisplay_Bank29::
    farcall BeginStringDisplay_Bank29
    ret

; step 2 of ShowMessageHL: calls BeginStringDisplay_Bank2A
ShowMessageHL_ToBeginStringDisplay_Bank2A::
    farcall BeginStringDisplay_Bank2A
    ret

; step 3 of ShowMessageHL: calls BeginStringDisplay_Bank2B
ShowMessageHL_ToBeginStringDisplay_Bank2B::
    farcall BeginStringDisplay_Bank2B
    ret

; step 4 of ShowMessageHL: calls BeginStringDisplay_Bank2C
ShowMessageHL_ToBeginStringDisplay_Bank2C::
    farcall BeginStringDisplay_Bank2C
    ret

; step 5 of ShowMessageHL: calls BeginStringDisplay_Bank2D
ShowMessageHL_ToBeginStringDisplay_Bank2D::
    farcall BeginStringDisplay_Bank2D
    ret

; step 6 of ShowMessageHL: calls BeginStringDisplay_Bank2E
ShowMessageHL_ToBeginStringDisplay_Bank2E::
    farcall BeginStringDisplay_Bank2E
    ret

; step 8 of ShowMessageHL: calls BeginStringDisplay_Bank7C
ShowMessageHL_ToBeginStringDisplay_Bank7C::
    farcall BeginStringDisplay_Bank7C
    ret

; step 9 of ShowMessageHL: calls BeginStringDisplay_Bank80
ShowMessageHL_ToBeginStringDisplay_Bank80::
    farcall BeginStringDisplay_Bank80
    ret

; step 11 of ShowMessageHL: calls BeginStringDisplay_Bank82
ShowMessageHL_ToBeginStringDisplay_Bank82::
    farcall BeginStringDisplay_Bank82
    ret

; step 12 of ShowMessageHL: calls BeginStringDisplay_Bank86
ShowMessageHL_ToBeginStringDisplay_Bank86::
    farcall BeginStringDisplay_Bank86
    ret

; step 13 of ShowMessageHL: calls BeginStringDisplay_Bank89
ShowMessageHL_ToBeginStringDisplay_Bank89::
    farcall BeginStringDisplay_Bank89
    ret

; Copies L to wStringIndex; sets wStringCategory to 0; calls BeginStringDisplay_Bank28
ShowMessageHL_ToBeginStringDisplay_Bank89_SetStringIndex::
    ld a, l
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank28
    ret

; sets bit 2 of hPlayerStateFlags (moving) and hPlayerFacing = 0; calls UpdateFollowersOnStep_Bank5F
; with the coordinate; then hPlayerY += 1; when it equals wStepPtrLo bit 2 is cleared and
; wStepArrived = 1, else wStepArrived = 0 (E-0071) (E-0340: the address in its name read as its RAM
; name; was StepPlayerDownTowardStepPtrLo)
StepPlayerDownTowardStepPtrLo::
    ldh a, [hPlayerStateFlags]
    or $04
    ldh [hPlayerStateFlags], a
    xor a
    ldh [hPlayerFacing], a
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank5F
    ld a, [wStepPtrLo]
    ld c, a
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp c
    jr z, .check_player_state_flags
    xor a
    ld [wStepArrived], a
    ret

.check_player_state_flags:
    ldh a, [hPlayerStateFlags]
    and $fb
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wStepArrived], a
    ret

; sets bit 2 of hPlayerStateFlags (moving) and hPlayerFacing = 1; calls UpdateFollowersOnStep_Bank5F
; with the coordinate; then hPlayerX += 1; when it equals wStepPtrLo bit 2 is cleared and
; wStepArrived = 1, else wStepArrived = 0 (E-0071) (E-0340: the address in its name read as its RAM
; name; was StepPlayerRightTowardStepPtrLo)
StepPlayerRightTowardStepPtrLo::
    ldh a, [hPlayerStateFlags]
    or $04
    ldh [hPlayerStateFlags], a
    ld a, $01
    ldh [hPlayerFacing], a
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank5F
    ld a, [wStepPtrLo]
    ld c, a
    ldh a, [hPlayerX]
    inc a
    ldh [hPlayerX], a
    cp c
    jr z, .check_player_state_flags
    xor a
    ld [wStepArrived], a
    ret

.check_player_state_flags:
    ldh a, [hPlayerStateFlags]
    and $fb
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wStepArrived], a
    ret

; sets bit 2 of hPlayerStateFlags (moving) and hPlayerFacing = 2; calls UpdateFollowersOnStep_Bank5F
; with the coordinate; then hPlayerY -= 1; when it equals wStepPtrLo bit 2 is cleared and
; wStepArrived = 1, else wStepArrived = 0 (E-0071) (E-0340: the address in its name read as its RAM
; name; was StepPlayerUpTowardStepPtrLo)
StepPlayerUpTowardStepPtrLo::
    ldh a, [hPlayerStateFlags]
    or $04
    ldh [hPlayerStateFlags], a
    ld a, $02
    ldh [hPlayerFacing], a
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank5F
    ld a, [wStepPtrLo]
    ld c, a
    ldh a, [hPlayerY]
    dec a
    ldh [hPlayerY], a
    cp c
    jr z, .check_player_state_flags
    xor a
    ld [wStepArrived], a
    ret

.check_player_state_flags:
    ldh a, [hPlayerStateFlags]
    and $fb
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wStepArrived], a
    ret

; sets bit 2 of hPlayerStateFlags (moving) and hPlayerFacing = 3; calls UpdateFollowersOnStep_Bank5F
; with the coordinate; then hPlayerX -= 1; when it equals wStepPtrLo bit 2 is cleared and
; wStepArrived = 1, else wStepArrived = 0 (E-0071) (E-0340: the address in its name read as its RAM
; name; was StepPlayerLeftTowardStepPtrLo)
StepPlayerLeftTowardStepPtrLo::
    ldh a, [hPlayerStateFlags]
    or $04
    ldh [hPlayerStateFlags], a
    ld a, $03
    ldh [hPlayerFacing], a
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank5F
    ld a, [wStepPtrLo]
    ld c, a
    ldh a, [hPlayerX]
    dec a
    ldh [hPlayerX], a
    cp c
    jr z, .check_player_state_flags
    xor a
    ld [wStepArrived], a
    ret

.check_player_state_flags:
    ldh a, [hPlayerStateFlags]
    and $fb
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wStepArrived], a
    ret

; A = the player's moving coordinate: when A & $0F = 0 (a 16-pixel tile boundary) far-calls
; SetFollowerTargetsFromLeader; then always far-calls StepFollowersTowardTargets (E-0093) (the same
; 17 bytes appear in 3 banks)
UpdateFollowersOnStep_Bank5F::
    and $0f
    jr nz, .call_step_followers_toward_targets
    farcall SetFollowerTargetsFromLeader

.call_step_followers_toward_targets:
    farcall StepFollowersTowardTargets
    ret

; wStepPtrHi = object number (16-byte entries): sets bit 2 of wSpriteSlots + $D + 16n, stores
; direction wStepTarget & 3 at wSpriteSlots + $7 + 16n and moves the object one pixel, two when
; wStepTarget bit 7 is set: direction 0 adds the step to Y (wSpriteSlots + $C + 16n), 1 adds it to X
; (wSpriteSlots + $B + 16n), 2 subtracts it from Y, 3 from X. When the moved coordinate equals
; wStepPtrLo it clears bit 2 and sets wStepArrived = 1, else wStepArrived = 0 (E-0061)
StepObjectTowardCoord::
    ld a, [wStepPtrHi]
    swap a
    ld hl, wSpriteSlots + $d
    add_a_to_hl
    ld a, [hl]
    or $04
    ld [hl], a
    push hl
    push hl
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    dec hl
    ld a, [wStepTarget]
    ld b, a
    and $03
    jr nz, .skip2
    ld [hl], $00
    pop hl
    dec hl
    ld a, [hl]
    inc a
    bit 7, b
    jr z, .skip
    inc a

.skip:
    ld [hl], a
    jr .read_step_ptr_lo2

.skip2:
    dec a
    jr nz, .skip4
    ld [hl], $01
    pop hl
    dec hl
    dec hl
    ld a, [hl]
    inc a
    bit 7, b
    jr z, .skip3
    inc a

.skip3:
    ld [hl], a
    jr .read_step_ptr_lo2

.skip4:
    dec a
    jr nz, .skip6
    ld [hl], $02
    pop hl
    dec hl
    ld a, [hl]
    dec a
    bit 7, b
    jr z, .skip5
    dec a

.skip5:
    ld [hl], a
    jr .read_step_ptr_lo2

.skip6:
    ld [hl], $03
    pop hl
    dec hl
    dec hl
    ld a, [hl]
    dec a
    bit 7, b
    jr z, .read_step_ptr_lo
    dec a

.read_step_ptr_lo:
    ld [hl], a

.read_step_ptr_lo2:
    push af
    ld a, [wStepPtrLo]
    ld c, a
    pop af
    cp c
    jr z, .restore
    xor a
    ld [wStepArrived], a
    pop hl
    ret

.restore:
    pop hl
    ld a, [hl]
    and $fb
    ld [hl], a
    ld a, $01
    ld [wStepArrived], a
    ret

; the byte at the address in wStepPtrLo/wStepPtrHi += the byte at AddStepDeltaToPointedByte_Data +
; wScriptParam0 / 2
AddStepDeltaToPointedByte::
    ld a, [wStepPtrLo]
    ld e, a
    ld a, [wStepPtrHi]
    ld d, a
    ld a, [wScriptParam0]
    srl a
    ld hl, AddStepDeltaToPointedByte_Data
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ld a, [de]
    add c
    ld [de], a
    ret

; data read by AddStepDeltaToPointedByte (16 bytes)
AddStepDeltaToPointedByte_Data::
    db $fe, $ff, $ff, $00, $ff, $00, $ff, $00, $00, $01, $00, $01, $00, $01, $01, $02

; for $78 frames blinks object hTemp0 by alternating byte wSpriteSlots + $C[16 * obj] between hTemp1
; and $E0 (hidden) at a slowing rate; hTemp0 = 1 when done (E-0127)
ScriptStepBlinkObjectTemp0::
    ld a, [wScriptParam0]
    cp $1e
    jr nc, .cp_3C
    bit 3, a
    jr z, .read_temp0
    jr .read_temp02

.cp_3C:
    cp $3c
    jr nc, .check_bit1
    bit 2, a
    jr z, .read_temp0
    jr .read_temp02

.check_bit1:
    bit 1, a
    jr z, .read_temp0
    jr .read_temp02

.read_temp0:
    ldh a, [hTemp0]
    swap a
    ld hl, wSpriteSlots + $c
    add_a_to_hl
    ldh a, [hTemp1]
    ld [hl], a
    jr .check_script_param0

.read_temp02:
    ldh a, [hTemp0]
    swap a
    ld hl, wSpriteSlots + $c
    add_a_to_hl
    ld [hl], $e0

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $78
    jr z, .read_temp03
    xor a
    ldh [hTemp0], a
    ret

.read_temp03:
    ldh a, [hTemp0]
    swap a
    ld hl, wSpriteSlots + $c
    add_a_to_hl
    ld [hl], $e0
    xor a
    ld [wScriptParam0], a
    ld a, $01
    ldh [hTemp0], a
    ret

; StartPaletteFade with A = $0F, wModeState = 4, wFieldTransitionStep = 0, wScriptParam0 = 0, then
; wScriptStep += 1 (E-0061)
ScriptStartFadeAndAdvanceStep::
    ld a, $0f
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a
    ld [wFieldTransitionStep], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; wModeState = 3, wBattleTransitionStep = 0, wFieldReturnPhase = 2, far-calls
; SaveScreenBufferToBGMap1, then PickRandomEncounterCountdownFromTable (E-0078)
SetModeState3AndSaveScreen::
    ld a, $03
    ld [wModeState], a
    xor a
    ld [wBattleTransitionStep], a
    ld a, $02
    ld [wFieldReturnPhase], a
    farcall SaveScreenBufferToBGMap1
    farcall PickRandomEncounterCountdownFromTable
    ret

; stores wStepPtrLo in the first wInventory slot that is $00 or $FF (no bound check), then sets bit
; 6 of wInventorySortFlags; HL kept (E-0071) (E-0340: the address in its name read as its RAM name;
; was AppendItemStepPtrLoToInventory)
AppendItemStepPtrLoToInventory::
    push hl
    ld hl, wInventory

.skip:
    ld a, [hl]
    or a
    jr z, .read_step_ptr_lo
    cp $ff
    jr z, .read_step_ptr_lo
    inc hl
    jr .skip

.read_step_ptr_lo:
    ld a, [wStepPtrLo]
    ld [hl], a
    pop hl
    ld a, [wInventorySortFlags]
    set 6, a
    ld [wInventorySortFlags], a
    ret

; wStepArrived = 1 when a party record has bit 7 of field $55 set, else 0 (E-0124)
SetWStepArrivedIfPartyHasField55Bit7::
    ld a, $0a
    ld [rRAMG], a
    ld a, [wPartyCount]
    or a
    jr z, .clear_step_arrived
    ld b, a
    ld hl, wPartyList

.loop:
    ld a, [hl]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    bit 7, a
    jr nz, .set_step_arrived_to_01
    inc hl
    dec b
    jr nz, .loop

.clear_step_arrived:
    xor a
    ld [wStepArrived], a
    xor a
    ld [rRAMG], a
    ret

.set_step_arrived_to_01:
    ld a, $01
    ld [wStepArrived], a
    xor a
    ld [rRAMG], a
    ret

; Sets rRAMG to $0a; branches on wPartyCount; calls LoadSRAMRecordByte; branches on hTemp0; sets
; wStepArrived to 0; sets rRAMG to 0; sets wStepArrived to 1; ...
GreatLogFieldEvents_LoadSRAMRecordByte::
    ld a, $0a
    ld [rRAMG], a
    ld a, [wPartyCount]
    or a
    jr z, .clear_step_arrived
    ld b, a
    ld hl, wPartyList

.loop:
    ld a, [hl]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    bit 2, a
    jr nz, .set_step_arrived_to_01
    inc hl
    dec b
    jr nz, .loop

.clear_step_arrived:
    xor a
    ld [wStepArrived], a
    xor a
    ld [rRAMG], a
    ret

.set_step_arrived_to_01:
    ld a, $01
    ld [wStepArrived], a
    xor a
    ld [rRAMG], a
    ret

; Sets rRAMG to $0a; branches on wPartyCount; calls LoadSRAMRecordByte; branches on hTemp0; sets
; wStepArrived to 0; sets rRAMG to 0; sets wStepArrived to 1; ...
GreatLogFieldEvents_LoadSRAMRecordByte_2::
    ld a, $0a
    ld [rRAMG], a
    ld a, [wPartyCount]
    or a
    jr z, .clear_step_arrived
    ld b, a
    ld hl, wPartyList

.loop:
    ld a, [hl]
    ld c, MON_STATUS
    call LoadSRAMRecordByte
    ldh a, [hTemp0]
    bit 0, a
    jr nz, .set_step_arrived_to_01
    inc hl
    dec b
    jr nz, .loop

.clear_step_arrived:
    xor a
    ld [wStepArrived], a
    xor a
    ld [rRAMG], a
    ret

.set_step_arrived_to_01:
    ld a, $01
    ld [wStepArrived], a
    xor a
    ld [rRAMG], a
    ret

; with hFieldDrawFlags bits 1-3 set: wArg1 = wPartyList[hTemp0] (bank 0 record), far-calls
; DeleteSRAMRecordAndCompact, LoadRecordListNameTiles and LoadPlayerAndFollowerSpriteGraphics,
; wOBJPaletteUploadRequest = $7F, then clears hFieldDrawFlags bits 1-3 (E-0121)
LoadListedRecordNameTilesForTemp0::
    farcall FindPartyIndexOfSpeciesTemp0
    ldh a, [hFieldDrawFlags]
    or $0e
    ldh [hFieldDrawFlags], a
    ldh a, [hTemp0]
    ld hl, wPartyList
    add_a_to_hl
    ld a, [hl]
    ld [wArg1], a
    xor a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    call LoadRecordListNameTiles
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    ldh a, [hFieldDrawFlags]
    and $f1
    ldh [hFieldDrawFlags], a
    ret

; for record $FF in bank 1 (DeleteSRAMRecordAndCompact): if wArg5 is not $FF and is >=
; ClearArg5IfAtOrAboveLimitForFarmLevel_Data[wFarmLevel & 3], sets wArg5 = $FF (E-0121)
ClearArg5IfAtOrAboveLimitForFarmLevel::
    ld a, $ff
    ld [wArg1], a
    ld a, $01
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    ld a, [wArg5]
    cp $ff
    ret z
    ld a, [wFarmLevel]
    and $03
    ld hl, ClearArg5IfAtOrAboveLimitForFarmLevel_Data
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ld a, [wArg5]
    cp c
    ret c
    ld a, $ff
    ld [wArg5], a
    ret

; data read by ClearArg5IfAtOrAboveLimitForFarmLevel (4 bytes)
ClearArg5IfAtOrAboveLimitForFarmLevel_Data::
    db $0a, $14, $1e, $1e

; sets bit 6 of the first used key entry (byte 3 bit 7) whose kind (byte 0 & $3F) equals hTemp0
; (E-0125)
MarkKeyEntryKindTemp0Bit6::
    ldh a, [hTemp0]
    ld c, a
    ld hl, wKeyList

.skip:
    push hl
    ld a, [hl]
    cp $fe
    jr z, .restore
    cp $ff
    jr nz, .next
    pop hl
    ret

.next:
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    bit 7, a
    jr z, .restore
    dec hl
    dec hl
    dec hl
    ld a, [hl]
    and $3f
    cp c
    jr z, .skip2

.restore:
    pop hl
    inc hl
    inc hl
    inc hl
    inc hl
    jr .skip

.skip2:
    set 6, a
    ld [hl], a
    pop hl
    ret

; HL = the BG map entry at the scroll origin ((hScrollY & $F8) * 4 + $9800, rows wrapped by & $9B, +
; hScrollX / 8), then DrawFullScreenBufferToBGMap (E-0093)
DrawFullScreenBufferAtScroll::
    ldh a, [hScrollY]
    and $f8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add $00
    ld e, a
    ld a, d
    adc $98
    ld d, a
    ld a, d
    and $9b
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add e
    ld e, a
    jr nc, .call_draw_full_screen_buffer_to_bg_map
    inc d

.call_draw_full_screen_buffer_to_bg_map:
    ld l, e
    ld h, d
    call DrawFullScreenBufferToBGMap
    ret

; DE = the BG map row at hScrollY (& $F8); calls RedrawColumnsBesideScreen_WriteVRAMByte for the
; columns at hScrollX - 8 and hScrollX + $A0, just off the left and right edges (E-0121)
RedrawColumnsBesideScreen::
    ldh a, [hScrollY]
    and $f8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add $00
    ld e, a
    ld a, d
    adc $98
    ld d, a
    ld a, d
    and $9b
    ld d, a
    push de
    ldh a, [hScrollX]
    sub $08
    call RedrawColumnsBesideScreen_WriteVRAMByte
    pop de
    ldh a, [hScrollX]
    add $a0
    call RedrawColumnsBesideScreen_WriteVRAMByte
    ret

; called from RedrawColumnsBesideScreen: calls WriteVRAMByte
RedrawColumnsBesideScreen_WriteVRAMByte::
    srl a
    srl a
    srl a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld l, e
    ld h, d
    ld b, $12

.loop:
    ld a, $c4
    call WriteVRAMByte
    ld a, $20
    add_a_to_hl
    ld a, h
    and $9b
    ld h, a
    dec b
    jr nz, .loop
    ret

; by its step: changes the player's facing and the follower records between short waits
; (wScriptParam0)
SceneDancing_DanceSteps::
    ld a, [wScriptSubStep]
    jumptable
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_WritePlayerFacingAndFollowerRecordsEtc
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_WritePlayerFacingAndFollowerRecordsEtc_3
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_WritePlayerFacingAndFollowerRecordsEtc_2
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_WritePlayerFacingAndFollowerRecords
    dw SceneDancing_DanceSteps_AddStepDeltaToPointedByte
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_WritePlayerStateFlags

; step 11 of SceneDancing_DanceSteps: sets hPlayerFacing to 0; sets wFollowerRecords to 0; advances
; wScriptSubStep
SceneDancing_DanceSteps_WritePlayerFacingAndFollowerRecords::
    xor a
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; step 8 of SceneDancing_DanceSteps: changes A; continues in
; SceneDancing_DanceSteps_WritePlayerFacingAndFollowerRecordsEtc_SetPlayerFacing
SceneDancing_DanceSteps_WritePlayerFacingAndFollowerRecordsEtc_2::
    ld a, $02
    jr SceneDancing_DanceSteps_WritePlayerFacingAndFollowerRecordsEtc_SetPlayerFacing

; step 5 of SceneDancing_DanceSteps: changes A; continues in
; SceneDancing_DanceSteps_WritePlayerFacingAndFollowerRecordsEtc_SetPlayerFacing
SceneDancing_DanceSteps_WritePlayerFacingAndFollowerRecordsEtc_3::
    ld a, $01
    jr SceneDancing_DanceSteps_WritePlayerFacingAndFollowerRecordsEtc_SetPlayerFacing

; step 2 of SceneDancing_DanceSteps: changes A
SceneDancing_DanceSteps_WritePlayerFacingAndFollowerRecordsEtc::
    ld a, $03

; Sets hPlayerFacing; sets wFollowerRecords; copies hPlayerStateFlags & $fd to hPlayerStateFlags;
; increments wScriptParam0; returns unless wScriptParam0 is $40; sets hPlayerStateFlags; sets
; wScriptParam0 to 0; ...
SceneDancing_DanceSteps_WritePlayerFacingAndFollowerRecordsEtc_SetPlayerFacing::
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    ldh a, [hPlayerStateFlags]
    and $fd
    ldh [hPlayerStateFlags], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $40
    ret nz
    ldh a, [hPlayerStateFlags]
    or $02
    ldh [hPlayerStateFlags], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; by its step: waits, moves two objects by table and changes the player's facing and followers
SceneMermaidSong2_MoveSteps::
    ld a, [wScriptSubStep]
    jumptable
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneMermaidSong2_MoveSteps_ScriptStepMoveTwoObjectsByTable
    dw SceneMermaidSong2_MoveSteps_AddStepDeltaToPointedByte
    dw SceneMermaidSong2_MoveSteps_WritePlayerFacingAndFollowerRecordsEtc
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneMermaidSong2_MoveSteps_WriteScriptParam0AndPlayerFacingEtc
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_AddStepDeltaToPointedByte
    dw SceneMermaidSong2_MoveSteps_WriteScriptParam0AndPlayerFacingEtc
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_WritePlayerStateFlags

; step 16 of SceneDancing_DanceSteps: copies hPlayerStateFlags & $fd to hPlayerStateFlags; advances
; wScriptStep
SceneDancing_DanceSteps_WritePlayerStateFlags::
    ldh a, [hPlayerStateFlags]
    and $fd
    ldh [hPlayerStateFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 12 of SceneDancing_DanceSteps: copies E to wStepPtrLo; copies D to wStepPtrHi; calls
; AddStepDeltaToPointedByte; copies E to wStepPtrLo; copies D to wStepPtrHi; calls
; AddStepDeltaToPointedByte; copies E to wStepPtrLo; ...
SceneDancing_DanceSteps_AddStepDeltaToPointedByte::
    ld de, hPlayerY
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld de, wFollowerRecords + $2
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld de, wFollowerRecords + $7
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld de, wFollowerRecords + $c
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    cp $20
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; step 7 of SceneMermaidSong2_MoveSteps: increments wScriptParam0; may return early; copies
; hPlayerFacing & $03 to hPlayerFacing; copies hPlayerFacing & $03 to wFollowerRecords; returns
; unless hPlayerFacing & $03 is 0; sets wScriptParam0 to 0; advances wScriptSubStep
SceneMermaidSong2_MoveSteps_WriteScriptParam0AndPlayerFacingEtc::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and $03
    ret nz
    ldh a, [hPlayerFacing]
    inc a
    and $03
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    or a
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; step 4 of SceneMermaidSong2_MoveSteps: copies hPlayerFacing & $03 to hPlayerFacing; branches on
; hPlayerFacing & $03; copies hPlayerFacing & $03 & $03 to wFollowerRecords; decrements
; wFollowerRecords + $1; increments hPlayerX; branches on hPlayerFacing & $03; branches on
; wScriptParam0; ...
SceneMermaidSong2_MoveSteps_WritePlayerFacingAndFollowerRecordsEtc::
    ld a, [wScriptParam0]
    and $07
    jr nz, .check_script_param0
    ldh a, [hPlayerFacing]
    dec a
    and $03
    ldh [hPlayerFacing], a
    bit 0, a
    jr z, .set_follower_records
    inc a
    inc a
    and $03

.set_follower_records:
    ld [wFollowerRecords], a
    ld hl, wFollowerRecords + $1
    dec [hl]
    ld hl, hPlayerX
    inc [hl]

.check_script_param0:
    ld a, [wScriptParam0]
    and $03
    jr nz, .check_player_state_flags
    ld a, [wScriptParam0]
    srl a
    srl a
    ld c, a
    ld a, $1f
    sub c
    sla a
    ld hl, SceneMermaidSong2_MoveSteps_WritePlayerFacingAndFollowerRecordsEtc_Data
    add_a_to_hl
    ld a, [hli]
    ld c, a
    ld a, [wFollowerRecords + $b]
    add c
    ld [wFollowerRecords + $b], a
    ld a, [wFollowerRecords + $6]
    sub c
    ld [wFollowerRecords + $6], a
    ld a, [hl]
    ld c, a
    ld a, [wFollowerRecords + $c]
    add c
    ld [wFollowerRecords + $c], a
    ld a, [wFollowerRecords + $7]
    sub c
    ld [wFollowerRecords + $7], a
    ld a, [wScriptParam0]
    srl a
    srl a
    cp $1f
    jr nz, .check_player_state_flags
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

.check_player_state_flags:
    ldh a, [hPlayerStateFlags]
    or $02
    ldh [hPlayerStateFlags], a
    ld hl, wScriptParam0
    inc [hl]
    ret

; step 3 of SceneMermaidSong2_MoveSteps: copies E to wStepPtrLo; copies D to wStepPtrHi; calls
; AddStepDeltaToPointedByte; copies E to wStepPtrLo; copies D to wStepPtrHi; calls
; AddStepDeltaToPointedByte
SceneMermaidSong2_MoveSteps_AddStepDeltaToPointedByte::
    ld de, wFollowerRecords + $7
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld de, wFollowerRecords + $c
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte

; step 0 of SceneDancing_DanceSteps: increments wScriptParam0; returns unless wScriptParam0 is $20;
; sets wScriptParam0 to 0; advances wScriptSubStep
SceneDancing_DanceSteps_WriteScriptParam0::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $20
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; step 2 of SceneMermaidSong2_MoveSteps: copies hPlayerFacing & $03 to hPlayerFacing; branches on
; hPlayerFacing & $03; copies hPlayerFacing & $03 & $03 to wFollowerRecords; increments
; wFollowerRecords + $1; decrements hPlayerX; calls ScriptStepMoveTwoObjectsByTable
SceneMermaidSong2_MoveSteps_ScriptStepMoveTwoObjectsByTable::
    ld a, [wScriptParam0]
    and $07
    jr nz, .call_script_step_move_two_objects_by_table
    ldh a, [hPlayerFacing]
    inc a
    and $03
    ldh [hPlayerFacing], a
    bit 0, a
    jr z, .set_follower_records
    inc a
    inc a
    and $03

.set_follower_records:
    ld [wFollowerRecords], a
    ld hl, wFollowerRecords + $1
    inc [hl]
    ld hl, hPlayerX
    dec [hl]

.call_script_step_move_two_objects_by_table:
    ld hl, SceneMermaidSong2_MoveSteps_WritePlayerFacingAndFollowerRecordsEtc_Data
    call ScriptStepMoveTwoObjectsByTable
    ret

; every fourth step moves wFollowerRecords + $6/wFollowerRecords + $7 and wFollowerRecords +
; $B/wFollowerRecords + $C in opposite directions by the table at HL; after 32 steps advances
; wScriptSubStep (E-0125)
ScriptStepMoveTwoObjectsByTable::
    ld a, [wScriptParam0]
    and $03
    jr nz, .done
    ld a, [wScriptParam0]
    srl a
    srl a
    sla a
    add_a_to_hl
    ld a, [hli]
    ld c, a
    ld a, [wFollowerRecords + $6]
    add c
    ld [wFollowerRecords + $6], a
    ld a, [wFollowerRecords + $b]
    sub c
    ld [wFollowerRecords + $b], a
    ld a, [hl]
    ld c, a
    ld a, [wFollowerRecords + $7]
    add c
    ld [wFollowerRecords + $7], a
    ld a, [wFollowerRecords + $c]
    sub c
    ld [wFollowerRecords + $c], a
    ld a, [wScriptParam0]
    srl a
    srl a
    cp $1f
    jr nz, .done
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

.done:
    ld hl, wScriptParam0
    inc [hl]
    ret

; data read by SceneMermaidSong2 (64 bytes)
SceneMermaidSong2_MoveSteps_WritePlayerFacingAndFollowerRecordsEtc_Data::
    db $fe, $00, $ff, $00, $fe, $ff, $ff, $ff, $ff, $ff, $ff, $fe, $00, $ff, $00, $fe
    db $00, $fe, $00, $ff, $01, $fe, $01, $ff, $01, $ff, $02, $ff, $01, $00, $02, $00
    db $02, $00, $01, $00, $02, $01, $01, $01, $01, $01, $01, $02, $00, $01, $00, $02
    db $00, $02, $00, $01, $ff, $02, $ff, $01, $ff, $01, $fe, $01, $ff, $00, $fe, $00

; runs the routine for wScriptSubStep (jump table of eight) (E-0122)
RunScriptSubStep::
    ld a, [wScriptSubStep]
    jumptable
    dw RunScriptSubStep_UpdateFollowersOnStep_Bank5F
    dw RunScriptSubStep_WriteFollowerRecordsAndPlayerFacingEtc
    dw RunScriptSubStep_AddStepDeltaToPointedByte
    dw RunScriptSubStep_WriteScriptParam0AndPlayerStateFlagsEtc
    dw RunScriptSubStep_WriteScriptTemp2AndScriptTemp3Etc
    dw RunScriptSubStep_WritePlayerStateFlagsAndFollowerRecordsEtc
    dw RunScriptSubStep_AddStepDeltaToPointedByte_SetStepPtrLo
    dw RunScriptSubStep_WriteFollowerRecordsAndPlayerFacingEtc_SetFollowerRecords

; step 7 of RunScriptSubStep: sets wFollowerRecords to 1; increments wScriptParam0; may return
; early; sets hPlayerFacing to 0; sets wFollowerRecords to 0; copies hPlayerStateFlags & $fb to
; hPlayerStateFlags; sets wScriptParam0 to 0; ...
RunScriptSubStep_WriteFollowerRecordsAndPlayerFacingEtc_SetFollowerRecords::
    ld a, $01
    ld [wFollowerRecords], a
    ld a, [wFollowerRecords + $1]
    inc a
    ld [wFollowerRecords + $1], a
    ld a, [wScriptParam0]
    and $01
    jr nz, .skip
    ld a, $02
    ld [wFollowerRecords + $5], a
    ld a, [wFollowerRecords + $7]
    dec a
    ld [wFollowerRecords + $7], a

.skip:
    ld hl, wScriptParam0
    inc [hl]
    ld a, $03
    ld [wFollowerRecords + $a], a
    ld a, [wFollowerRecords + $b]
    dec a
    ld [wFollowerRecords + $b], a
    ldh a, [hPlayerX]
    ld c, a
    ld a, [wFollowerRecords + $b]
    cp c
    ret nz
    xor a
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    ldh a, [hPlayerStateFlags]
    and $fb
    ldh [hPlayerStateFlags], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; step 6 of RunScriptSubStep: copies E to wStepPtrLo; copies D to wStepPtrHi; calls
; AddStepDeltaToPointedByte; increments wObject5 + SCRIPTOBJ_Y; increments wScriptParam0; returns
; unless wScriptParam0 is $20; sets wObject5 to 0; ...
RunScriptSubStep_AddStepDeltaToPointedByte_SetStepPtrLo::
    ld de, wObject5 + SCRIPTOBJ_Y
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wObject5 + SCRIPTOBJ_Y]
    inc a
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    cp $20
    ret nz
    xor a
    ld [wObject5], a
    ldh a, [hPlayerStateFlags]
    and $fd
    ldh [hPlayerStateFlags], a
    ld a, $02
    ldh [hPlayerFacing], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; step 5 of RunScriptSubStep: sets hPlayerStateFlags; sets wFollowerRecords to 0; increments
; wScriptParam0; returns unless wScriptParam0 is $3c; sets wScriptParam0 to 0; advances
; wScriptSubStep
RunScriptSubStep_WritePlayerStateFlagsAndFollowerRecordsEtc::
    ldh a, [hPlayerStateFlags]
    or $02
    ldh [hPlayerStateFlags], a
    xor a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $a], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $3c
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; step 4 of RunScriptSubStep: copies L to wScriptTemp2; copies H to wScriptTemp3; sets wScriptParam0
; to 0; advances wScriptSubStep; branches on the byte at wScriptMsgSelect; branches on hPlayerY
RunScriptSubStep_WriteScriptTemp2AndScriptTemp3Etc::
    ld a, [wScriptTemp2]
    ld l, a
    ld a, [wScriptTemp3]
    ld h, a
    dec hl
    ld a, l
    ld [wScriptTemp2], a
    ld a, h
    ld [wScriptTemp3], a
    ld a, l
    or h
    jr nz, .skip
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]

.skip:
    ld b, $03
    ld hl, wFollowerRecords
    ld de, wScriptMsgSelect

.loop:
    push hl
    push de
    ld a, [de]
    or a
    jr nz, .skip2
    xor a
    ld [hl], a
    inc hl
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    ld c, a
    ldh a, [hPlayerY]
    add $10
    cp c
    jr nz, .restore
    ld a, $01
    ld [de], a
    jr .restore

.skip2:
    dec a
    jr nz, .skip3
    ld a, [wFrameCounterLo]
    srl a
    srl a
    srl a
    and $03
    ld [hl], a
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    ld c, a
    ldh a, [hPlayerX]
    add $20
    cp c
    jr nz, .restore
    ld a, $02
    ld [de], a
    jr .restore

.skip3:
    dec a
    jr nz, .skip4
    ld a, $02
    ld [hl], a
    inc hl
    inc hl
    ld a, [hl]
    dec a
    ld [hl], a
    ld c, a
    ldh a, [hPlayerY]
    cp c
    jr nz, .restore
    ld a, $03
    ld [de], a
    jr .restore

.skip4:
    ld a, $03
    ld [hl], a
    inc hl
    ld a, [hl]
    dec a
    ld [hl], a
    ld c, a
    ldh a, [hPlayerX]
    sub $20
    cp c
    jr nz, .read_player_x
    xor a
    ld [de], a

.read_player_x:
    ldh a, [hPlayerX]
    sub $20
    ld c, a
    ld a, [hl]
    sub c
    ld de, RunScriptSubStep_WriteScriptTemp2AndScriptTemp3Etc_Data
    add e
    ld e, a
    jr nc, .read_player_y
    inc d

.read_player_y:
    ld a, [de]
    ld c, a
    ldh a, [hPlayerY]
    sub c
    inc hl
    ld [hl], a

.restore:
    pop de
    inc de
    pop hl
    ld a, $05
    add_a_to_hl
    dec b
    jp nz, .loop
    ret

; data read by RunScriptSubStep (30 bytes)
RunScriptSubStep_WriteScriptTemp2AndScriptTemp3Etc_Data::
    ds $11, $00
    db $01, $05, $08, $0a, $0c, $0d, $0e, $0e, $0f, $0f, $10, $10, $10, $11, $11, $11
    db $11, $10, $10, $10, $0f, $0f, $0e, $0e, $0d, $0c, $0a, $08, $05, $01
    ds $11, $00

; step 3 of RunScriptSubStep: increments wScriptParam0; returns unless wScriptParam0 is $78; sets
; wScriptParam0 to 0; sets hPlayerStateFlags; sets wScriptMsgSelect to 0; sets wScriptTemp0 to 1;
; sets wScriptTemp1 to 3; ...
RunScriptSubStep_WriteScriptParam0AndPlayerStateFlagsEtc::
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $78
    ret nz
    xor a
    ld [wScriptParam0], a
    ldh a, [hPlayerStateFlags]
    or $04
    ldh [hPlayerStateFlags], a
    ld a, $00
    ld [wScriptMsgSelect], a
    ld a, $01
    ld [wScriptTemp0], a
    ld a, $03
    ld [wScriptTemp1], a
    ld hl, $0320
    ld a, l
    ld [wScriptTemp2], a
    ld a, h
    ld [wScriptTemp3], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; step 2 of RunScriptSubStep: sets wObject5 to $80; copies E to wStepPtrLo; copies D to wStepPtrHi;
; calls AddStepDeltaToPointedByte; decrements wObject5 + SCRIPTOBJ_Y; increments wScriptParam0;
; returns unless wScriptParam0 is $20; ...
RunScriptSubStep_AddStepDeltaToPointedByte::
    ld a, $80
    ld [wObject5], a
    ld de, wObject5 + SCRIPTOBJ_Y
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wObject5 + SCRIPTOBJ_Y]
    dec a
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    cp $20
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; step 1 of RunScriptSubStep: sets wFollowerRecords to 3; increments wScriptParam0; may return
; early; sets hPlayerFacing to 0; sets wFollowerRecords to 0; sets hTemp0 to $0b; calls
; RunFieldCommandTemp0; ...
RunScriptSubStep_WriteFollowerRecordsAndPlayerFacingEtc::
    ld a, $03
    ld [wFollowerRecords], a
    ld a, [wFollowerRecords + $1]
    dec a
    ld [wFollowerRecords + $1], a
    ld a, [wScriptParam0]
    and $01
    jr nz, .skip
    ld a, $00
    ld [wFollowerRecords + $5], a
    ld a, [wFollowerRecords + $7]
    inc a
    ld [wFollowerRecords + $7], a

.skip:
    ld hl, wScriptParam0
    inc [hl]
    ld a, $01
    ld [wFollowerRecords + $a], a
    ld a, [wFollowerRecords + $b]
    inc a
    ld [wFollowerRecords + $b], a
    ldh a, [hPlayerX]
    ld c, a
    ld a, [wFollowerRecords + $b]
    sub c
    cp $20
    ret nz
    xor a
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    inc a
    ld [wFollowerRecords + $5], a
    ld a, $03
    ld [wFollowerRecords + $a], a
    ld a, $0b
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ldh a, [hPlayerStateFlags]
    or $02
    ldh [hPlayerStateFlags], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; step 0 of RunScriptSubStep: sets hPlayerStateFlags; calls UpdateFollowersOnStep_Bank5F; increments
; wScriptParam0; returns unless wScriptParam0 is $3c; sets wScriptParam0 to 0; advances
; wScriptSubStep
RunScriptSubStep_UpdateFollowersOnStep_Bank5F::
    ldh a, [hPlayerStateFlags]
    or $04
    ldh [hPlayerStateFlags], a
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank5F
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $3c
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; runs the routine for wScriptSubStep (jump table of eighteen) (E-0124)
RunSceneScriptSubStep::
    ld a, [wScriptSubStep]
    jumptable
    dw RunSceneScriptSubStep_LoadSpriteGraphics7EToTiles0
    dw RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F
    dw RunSceneScriptSubStep_CopyBytes
    dw RunSceneScriptSubStep_FullyHealParty
    dw RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F_SetObject5
    dw RunSceneScriptSubStep_AddStepDeltaToPointedByte
    dw RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F_DecompressToVRAM
    dw RunSceneScriptSubStep_CycleSpriteFloatYDown
    dw RunSceneScriptSubStep_CycleSpriteFloatYDown_DrawAnimatedMetaSprite1B_4
    dw RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F_TestFlagBit
    dw RunSceneScriptSubStep_NextTableByte
    dw RunSceneScriptSubStep_CycleSpriteFloatYDown_DrawAnimatedMetaSprite1B_3
    dw RunSceneScriptSubStep_CycleSpriteFloatYDown_DrawAnimatedMetaSprite1B_2
    dw RunSceneScriptSubStep_CycleSpriteFloatYDown_DrawAnimatedMetaSprite1B
    dw RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F_SetScriptParam0
    dw RunSceneScriptSubStep_AddStepDeltaToPointedByte_2
    dw RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F_TestFlagBit
    dw RunSceneScriptSubStep_AdvanceScriptStep

; step 17 of RunSceneScriptSubStep: advances wScriptStep
RunSceneScriptSubStep_AdvanceScriptStep::
    ld hl, wScriptStep
    inc [hl]
    ret

; starts message 6 and advances wScriptSubStep when wTextYesNoResult is 0, otherwise message 7 and
; steps wScriptSubStep back (E-0126)
StartChoiceMessageByTextYesNoResult::
    ld a, [wTextYesNoResult]
    or a
    jr nz, .skip
    ld a, $06
    ld hl, wScriptSubStep
    inc [hl]
    jr .call_start_message_from_table

.skip:
    ld a, $07
    ld hl, wScriptSubStep
    dec [hl]

.call_start_message_from_table:
    call StartMessageFromTable
    ret

; starts message 5 from StartMessageFromTable_Data and advances wScriptSubStep (E-0126)
StartMessage5AndAdvanceScriptSubStep::
    ld a, $05
    call StartMessageFromTable
    ld hl, wScriptSubStep
    inc [hl]
    ret

; step 15 of RunSceneScriptSubStep: branches on wScriptParam0; plays sound $65; copies E to
; wStepPtrLo; copies D to wStepPtrHi; calls AddStepDeltaToPointedByte; increments wSpriteSlots + $b;
; increments wScriptParam0; ...
RunSceneScriptSubStep_AddStepDeltaToPointedByte_2::
    ld a, [wScriptParam0]
    or a
    jr nz, .set_step_ptr_lo
    ld a, $65
    call QueueSoundEffect

.set_step_ptr_lo:
    ld de, wSpriteSlots + $c
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    call AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and $01
    jr nz, .check_script_param0
    ld hl, wSpriteSlots + $b
    inc [hl]

.check_script_param0:
    ld a, [wScriptParam0]
    and $01
    jr nz, .check_script_param02
    ld a, [wSpriteSlots + $7]
    inc a
    and $03
    ld [wSpriteSlots + $7], a

.check_script_param02:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $20
    jr z, .call_queue_sound_effect
    farcall CycleSpriteFloatYDown
    ld a, $01
    ldh [hTemp0], a
    farcall DrawAnimatedMetaSprite1B
    ret

.call_queue_sound_effect:
    ld a, $72
    call QueueSoundEffect
    ld de, FieldSpriteGfx49
    ld b, $7d
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $49
    ld [wSpriteSlots + $2], a
    xor a
    ld [wSpriteSlots + $7], a
    ld a, $04
    call StartMessageFromTable
    ld a, [wScriptTemp4]
    ld [wPartyCount], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; step 14 of RunSceneScriptSubStep: calls RunMessageBoxCarryWhenIdle_Bank5F; may return early; sets
; wScriptParam0 to 0; advances wScriptSubStep
RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F_SetScriptParam0::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank5F
    ret nc
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; step 13 of RunSceneScriptSubStep: calls CycleSpriteFloatYDown; sets hTemp0 to 1; calls
; DrawAnimatedMetaSprite1B; copies E to wStepPtrLo; copies D to wStepPtrHi; calls
; AddStepDeltaToPointedByte; increments wScriptParam0; ...
RunSceneScriptSubStep_CycleSpriteFloatYDown_DrawAnimatedMetaSprite1B::
    farcall CycleSpriteFloatYDown
    ld a, $01
    ldh [hTemp0], a
    farcall DrawAnimatedMetaSprite1B
    ld de, wSpriteSlots + $c
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    call AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $20
    ret nz
    ld a, $03
    call StartMessageFromTable
    ld hl, wScriptSubStep
    inc [hl]
    ret

; step 12 of RunSceneScriptSubStep: calls CycleSpriteFloatYDown; sets hTemp0 to 1; calls
; DrawAnimatedMetaSprite1B; sets wScriptParam1; sets wScriptParam0; sets wScriptParam0 to 0; sets
; wObject5 to 0; ...
RunSceneScriptSubStep_CycleSpriteFloatYDown_DrawAnimatedMetaSprite1B_2::
    farcall CycleSpriteFloatYDown
    ld a, $01
    ldh [hTemp0], a
    farcall DrawAnimatedMetaSprite1B
    ld a, [wScriptParam1]
    add $01
    ld [wScriptParam1], a
    sra a
    sra a
    sra a
    sra a
    ld c, a
    ld a, [wScriptParam0]
    add c
    ld [wScriptParam0], a
    cp $18
    jr c, .set_object5_to_80
    xor a
    ld [wScriptParam0], a
    xor a
    ld [wObject5], a
    jr .read_script_param1

.set_object5_to_80:
    ld a, $80
    ld [wObject5], a

.read_script_param1:
    ld a, [wScriptParam1]
    sra a
    sra a
    sra a
    sra a
    cp $30
    ret c
    xor a
    ld [wObject5], a
    ld a, $30
    ld [wObject5 + SCRIPTOBJ_Y], a
    xor a
    ld [wScriptParam0], a
    ld [wScriptParam1], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; step 11 of RunSceneScriptSubStep: calls CycleSpriteFloatYDown; sets hTemp0 to 1; calls
; DrawAnimatedMetaSprite1B; copies E to wStepPtrLo; copies D to wStepPtrHi; calls
; AddStepDeltaToPointedByte; branches on wScriptParam0; ...
RunSceneScriptSubStep_CycleSpriteFloatYDown_DrawAnimatedMetaSprite1B_3::
    farcall CycleSpriteFloatYDown
    ld a, $01
    ldh [hTemp0], a
    farcall DrawAnimatedMetaSprite1B
    ld de, wObject5 + SCRIPTOBJ_Y
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    call AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    bit 0, a
    jr nz, .check_script_param0
    ld hl, wObject5 + SCRIPTOBJ_Y
    inc [hl]

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $20
    ret nz
    xor a
    ld [wScriptParam0], a
    ld [wScriptParam1], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; step 10 of RunSceneScriptSubStep: calls NextTableByte; may continue in
; RunSceneScriptSubStep_NextTableByte; sets wObject5 + SCRIPTOBJ_X; increments wScriptParam0;
; returns unless wScriptParam0 is $b4; sets wObject5 + SCRIPTOBJ_X to $40; plays sound $72; ...
RunSceneScriptSubStep_NextTableByte::
    call NextTableByte
    ld a, [wRandomLo]
    and $03
    jr z, RunSceneScriptSubStep_NextTableByte
    dec a
    dec a
    add $40
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $b4
    ret nz
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $72
    call QueueSoundEffect
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; step 9 of RunSceneScriptSubStep: calls RunMessageBoxCarryWhenIdle_Bank5F; may return early; sets
; wScriptParam0 to 0; advances wScriptSubStep; checks EVENT_SCENE_DARCK_DEFEATED; may return early;
; sets wScriptSubStep to $11
RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F_TestFlagBit::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank5F
    ret nc
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ld de, EVENT_SCENE_DARCK_DEFEATED
    call TestFlagBit
    ret nc
    ld a, $11
    ld [wScriptSubStep], a
    ret

; step 8 of RunSceneScriptSubStep: calls CycleSpriteFloatYDown; sets hTemp0 to 1; calls
; DrawAnimatedMetaSprite1B; copies E to wStepPtrLo; copies D to wStepPtrHi; calls
; AddStepDeltaToPointedByte; decrements wObject5 + SCRIPTOBJ_X; ...
RunSceneScriptSubStep_CycleSpriteFloatYDown_DrawAnimatedMetaSprite1B_4::
    farcall CycleSpriteFloatYDown
    ld a, $01
    ldh [hTemp0], a
    farcall DrawAnimatedMetaSprite1B
    ld de, wObject5 + SCRIPTOBJ_Y
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    call AddStepDeltaToPointedByte
    ld hl, wObject5 + SCRIPTOBJ_X
    dec [hl]
    ld hl, wObject5 + SCRIPTOBJ_Y
    inc [hl]
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    cp $20
    ret nz
    ld a, $02
    call StartMessageFromTable
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; step 7 of RunSceneScriptSubStep: calls CycleSpriteFloatYDown; sets hTemp0 to 1; calls
; DrawAnimatedMetaSprite1B; copies E to wStepPtrLo; copies D to wStepPtrHi; calls
; AddStepDeltaToPointedByte; increments wScriptParam0; ...
RunSceneScriptSubStep_CycleSpriteFloatYDown::
    farcall CycleSpriteFloatYDown
    ld a, $01
    ldh [hTemp0], a
    farcall DrawAnimatedMetaSprite1B
    ld de, wSpriteSlots + $c
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    call AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and $01
    jr nz, .check_script_param0
    ld a, [wSpriteSlots + $b]
    dec a
    ld [wSpriteSlots + $b], a

.check_script_param0:
    ld a, [wScriptParam0]
    cp $20
    ret nz
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; step 6 of RunSceneScriptSubStep: calls RunMessageBoxCarryWhenIdle_Bank5F; may return early; calls
; DecompressToVRAM; advances wScriptSubStep
RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F_DecompressToVRAM::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank5F
    ret nc
    ld de, FieldSpriteGfx02
    ld b, $7d
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $02
    ld [wSpriteSlots + $2], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; step 5 of RunSceneScriptSubStep: copies E to wStepPtrLo; copies D to wStepPtrHi; calls
; AddStepDeltaToPointedByte; decrements wObject5 + SCRIPTOBJ_Y; increments wScriptParam0; returns
; unless wScriptParam0 is $20; calls StartMessageFromTable; ...
RunSceneScriptSubStep_AddStepDeltaToPointedByte::
    ld de, wObject5 + SCRIPTOBJ_Y
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    call AddStepDeltaToPointedByte
    ld hl, wObject5 + SCRIPTOBJ_Y
    dec [hl]
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    cp $20
    ret nz
    ld a, $01
    call StartMessageFromTable
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; step 4 of RunSceneScriptSubStep: calls RunMessageBoxCarryWhenIdle_Bank5F; may return early; sets
; wObject5 to $80; copies wPartyCount to wScriptTemp4; sets wPartyCount to 1; advances
; wScriptSubStep
RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F_SetObject5::
    xor a
    call RunMessageBoxCarryWhenIdle_Bank5F
    ret nc
    ld a, $80
    ld [wObject5], a
    ld a, [wPartyCount]
    ld [wScriptTemp4], a
    ld a, $01
    ld [wPartyCount], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; step 3 of RunSceneScriptSubStep: branches on wScriptParam0; increments wScriptParam0; sets
; hFieldDrawFlags to $0e; calls FullyHealParty; calls MoveIncapacitatedPartyMembersBack; calls
; LoadRecordListNameTiles; calls LoadPlayerAndFollowerSpriteGraphics; ...
RunSceneScriptSubStep_FullyHealParty::
    ld a, [wScriptParam0]
    or a
    jr nz, .call_move_incapacitated_party_members_back
    inc a
    ld [wScriptParam0], a
    ld a, $0e
    ldh [hFieldDrawFlags], a
    farcall FullyHealParty
    ret

.call_move_incapacitated_party_members_back:
    farcall MoveIncapacitatedPartyMembersBack
    farcall MoveIncapacitatedPartyMembersBack
    call LoadRecordListNameTiles
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7f
    ld [wOBJPaletteUploadRequest], a
    xor a
    ldh [hFieldDrawFlags], a
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; step 2 of RunSceneScriptSubStep: branches on wIsCGB; calls CopyBytes; branches on wIsCGB; sets
; wBGPaletteUploadRequest to $7f; increments wScriptParam0; returns unless wScriptParam0 is $1e;
; calls StartMessageFromTable; ...
RunSceneScriptSubStep_CopyBytes::
    ld a, [wScriptParam0]
    srl a
    srl a
    and $01
    jr z, .skip
    ld hl, wDMGPaletteBGP
    ld a, $d2
    ld [hli], a
    ld a, $d2
    ld [hli], a
    ld a, $e2
    ld [hl], a
    ld a, [wIsCGB]
    or a
    jr z, .check_script_param0
    ld hl, wBGPaletteCopy
    ld de, wBGPaletteBuffer
    ld bc, $0040
    call CopyBytes
    jr .set_bg_palette_upload_request_to_7F

.skip:
    ld hl, wDMGPaletteBGP
    ld a, $2d
    ld [hli], a
    ld a, $2d
    ld [hli], a
    ld a, $1d
    ld [hl], a
    ld a, [wIsCGB]
    or a
    jr z, .check_script_param0
    ld b, $40
    ld hl, wBGPaletteCopy
    ld de, wBGPaletteBuffer

.loop:
    ld a, [hli]
    xor $ff
    ld [de], a
    inc de
    dec b
    jr nz, .loop

.set_bg_palette_upload_request_to_7F:
    ld a, $7f
    ld [wBGPaletteUploadRequest], a

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $1e
    ret nz
    ld a, $00
    call StartMessageFromTable
    xor a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; step 1 of RunSceneScriptSubStep: sets hPlayerFacing to 3; calls RunMessageBoxCarryWhenIdle_Bank5F;
; may return early; branches on wIsCGB; calls CopyBytes; plays sound $7a; advances wScriptSubStep
RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F::
    ld a, $03
    ldh [hPlayerFacing], a
    ld a, $01
    ld [wSpriteSlots + $7], a
    xor a
    call RunMessageBoxCarryWhenIdle_Bank5F
    ret nc
    ld a, [wIsCGB]
    or a
    jr z, .call_queue_sound_effect
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes

.call_queue_sound_effect:
    ld a, $7a
    call QueueSoundEffect
    ld hl, wScriptSubStep
    inc [hl]
    ret

; step 0 of RunSceneScriptSubStep: sets hTemp0 to 1; calls LoadSpriteGraphics7EToTiles0; checks
; EVENT_SCENE_RIVAL_DEFEATED_021; sets wScriptMsgSelect to 0; sets hTemp0 to 3; checks
; EVENT_SCENE_MERMAID_KINGDOM_022; sets wScriptMsgSelect to 1; ...
RunSceneScriptSubStep_LoadSpriteGraphics7EToTiles0::
    ld a, $01
    ldh [hTemp0], a
    farcall LoadSpriteGraphics7EToTiles0
    ld de, EVENT_SCENE_RIVAL_DEFEATED_021
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld a, $00
    ld [wScriptMsgSelect], a
    ld a, $03
    ldh [hTemp0], a
    jr .call_run_field_command_temp0

.call_test_flag_bit:
    ld de, EVENT_SCENE_MERMAID_KINGDOM_022
    call TestFlagBit
    jr c, .call_test_flag_bit2
    ld a, $01
    ld [wScriptMsgSelect], a
    ld a, $08
    ldh [hTemp0], a
    jr .call_run_field_command_temp0

.call_test_flag_bit2:
    ld de, EVENT_SCENE_SHIELD2_023
    call TestFlagBit
    jr c, .set_script_msg_select_to_03
    ld a, $02
    ld [wScriptMsgSelect], a
    ld a, $0a
    ldh [hTemp0], a
    jr .call_run_field_command_temp0

.set_script_msg_select_to_03:
    ld a, $03
    ld [wScriptMsgSelect], a
    ld a, $0f
    ldh [hTemp0], a

.call_run_field_command_temp0:
    farcall RunFieldCommandTemp0
    ld a, $50
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $30
    ld [wObject5 + SCRIPTOBJ_Y], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; starts the message whose index and group are at StartMessageFromTable_Data + 2 * A + 16 *
; wScriptMsgSelect (wMessageState = 0) (E-0124) (E-0344: the address in its name dropped or read as
; the label there; was StartMessageFromTable)
StartMessageFromTable::
    sla a
    ld de, StartMessageFromTable_Data
    add e
    ld e, a
    jr nc, .read_script_msg_select
    inc d

.read_script_msg_select:
    ld a, [wScriptMsgSelect]
    swap a
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
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a
    ld [wMessageState], a
    ret

; data read by StartMessageFromTable (64 bytes)
StartMessageFromTable_Data::
    db $26, $01, $27, $01, $28, $01, $29, $01, $2a, $01, $00, $00, $00, $00, $00, $00
    db $a8, $02, $a9, $02, $aa, $02, $ab, $02, $ac, $02, $00, $00, $00, $00, $00, $00
    db $a8, $02, $e9, $02, $aa, $02, $ab, $02, $ec, $02, $00, $00, $00, $00, $00, $00
    db $34, $05, $35, $05, $36, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; wStepPtrLo = A, RunMessageBox, then carry set when wMessageState = $FF (idle), else A = 0 and
; carry clear (E-0079)
RunMessageBoxCarryWhenIdle_Bank5F::
    ld [wStepPtrLo], a
    call RunMessageBox
    ld a, [wMessageState]
    cp $ff
    jr z, .return_carry
    sub a
    ret

.return_carry:
    scf
    ret

; script commands 02 and 03 (and 05 through ScriptCommand05_Run): wScriptParam0 low nibble is an
; object number (16-byte entries from wSpriteSlots), its high nibble a direction 0-3; sets bit 2 of
; the object's flag byte and moves the object's position by one unit in that direction
ScriptStepObject::
    ld c, $10
    ld a, [wScriptParam0]
    and $0f
    call Multiply8
    ld a, l
    add $7f
    ld l, a
    ld a, h
    adc $cb
    ld h, a
    push hl
    ld a, $0d
    add_a_to_hl
    ld a, [hl]
    or $04
    ld [hl], a
    dec hl
    dec hl
    ld a, [wScriptParam0]
    swap a
    and $0f
    jr z, .next
    dec a
    jr z, .skip
    dec a
    jr z, .next2
    jr .skip2

.next:
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    jr .restore

.skip:
    ld a, [hl]
    inc a
    ld [hl], a
    jr .restore

.next2:
    inc hl
    ld a, [hl]
    dec a
    ld [hl], a
    jr .restore

.skip2:
    ld a, [hl]
    dec a
    ld [hl], a
    jr .restore

.restore:
    pop hl
    ld a, $07
    add_a_to_hl
    ld a, [wScriptParam0]
    swap a
    and $0f
    ld [hl], a
    ld a, [wScriptStep]
    inc a
    cp $10
    jr z, .clear_script_step
    ld [wScriptStep], a
    ret

.clear_script_step:
    xor a
    ld [wScriptStep], a
    ld a, [wScriptParam1]
    dec a
    ld [wScriptParam1], a
    ret nz
    ld a, $06
    add_a_to_hl
    ld a, [hl]
    and $fb
    ld [hl], a
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; script command 04: wScriptParam0/1 is a 16-bit counter that falls by one each frame; at zero it
; clears wScriptCommandType and sets wScriptStartRequest = $80 so the next script byte is fetched
; (the opening's waits of 30, 60 and 90 frames showed the counter at 29, 59 and 89)
ScriptWaitFrames::
    ld a, [wScriptParam0]
    ld l, a
    ld a, [wScriptParam1]
    ld h, a
    dec hl
    ld a, l
    ld [wScriptParam0], a
    ld a, h
    ld [wScriptParam1], a
    ld a, l
    or a
    ret nz
    cp h
    ret nz
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 05; reached through ScriptCommand05 in bank $10 (E-0038)
ScriptCommand05_Run::
    xor a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ldh a, [hPlayerStateFlags]
    bit 0, a
    ret nz
    ld a, [wScriptParam1]
    or a
    jr nz, .set_script_param1
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_script_param1:
    dec a
    ld [wScriptParam1], a
    ld a, [wScriptParam0]
    or a
    jr nz, .skip
    ld a, [wJoypadHeld]
    set 7, a
    ld [wJoypadHeld], a
    ret

.skip:
    dec a
    jr nz, .skip2
    ld a, [wJoypadHeld]
    set 4, a
    ld [wJoypadHeld], a
    ret

.skip2:
    dec a
    jr nz, .read_joypad_held
    ld a, [wJoypadHeld]
    set 6, a
    ld [wJoypadHeld], a
    ret

.read_joypad_held:
    ld a, [wJoypadHeld]
    set 5, a
    ld [wJoypadHeld], a
    ret

; script command 06: wScriptParam0 picks the target (0 = the player's hPlayerFacing, 1-n = the first
; byte of the n-th 5-byte record at wFollowerRecords, bit 7 set = byte 7 of the 16-byte object entry
; numbered by the low bits); wScriptParam1 is stored there; then wScriptStartRequest = $80 so the
; next script byte is fetched (the opening used it with parameters 129/130 and 2/1)
ScriptSetDirection::
    ld a, [wScriptParam0]
    bit 7, a
    jr nz, .call_multiply8
    or a
    jr nz, .skip
    ld hl, hPlayerFacing
    jr .read_script_param1

.skip:
    dec a
    ld c, a
    sla a
    sla a
    add c
    ld hl, wFollowerRecords
    add_a_to_hl
    jr .read_script_param1

.call_multiply8:
    and $7f
    ld c, $10
    call Multiply8
    ld a, l
    add $86
    ld l, a
    ld a, h
    adc $cb
    ld h, a

.read_script_param1:
    ld a, [wScriptParam1]
    ld [hl], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; script command 0C: for 32 frames adds the per-frame step from the table at ScriptSlideObjectY_Data
; (indexed by wScriptParam0 / 2) to a Y coordinate chosen by wScriptParam1 (0 = hPlayerY, 1-n = the
; n-th 5-byte record from wFollowerRecords + $2, bit 7 = an object entry's byte at wSpriteSlots + $C
; + 16 * number), counting wScriptParam0 up; at $20 it ends the command
ScriptSlideObjectY::
    ld a, [wScriptParam1]
    bit 7, a
    jr nz, .skip3
    or a
    jr nz, .skip
    ld de, hPlayerY
    jr .read_script_param0

.skip:
    dec a
    ld c, a
    sla a
    sla a
    add c
    ld de, wFollowerRecords + $2
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    jr .read_script_param0

.skip3:
    and $7f
    swap a
    ld de, wSpriteSlots + $c
    add e
    ld e, a
    jr nc, .read_script_param0
    inc d

.read_script_param0:
    ld a, [wScriptParam0]
    srl a
    ld hl, ScriptSlideObjectY_Data
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ld a, [de]
    add c
    ld [de], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp $20
    ret nz
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; data read by ScriptSlideObjectY (16 bytes)
ScriptSlideObjectY_Data::
    db $fe, $ff, $ff, $00, $ff, $00, $ff, $00, $00, $01, $00, $01, $00, $01, $01, $02

; implements script command type 0A, a one-time treasure: wScriptParam0 = kind (0 chest, 1 vase, 2
; barrel, 3 chest with a Magic Key), wScriptParam1 = item, wMessageIndex/Group = story flag. If the
; flag is set it shows group-0 message $A1 + 3 * kind (empty); otherwise it adds the item (or a key
; entry for kind 3) and sets the flag, showing $A0 + 3 * kind, or $A2 + 3 * kind when there is no
; room (E-0038, E-0269)
RunOneTimeTreasure::
    ld a, [wScriptStep]
    jumptable
    dw RunOneTimeTreasure_CopyItemNameToDE
    dw RunOneTimeTreasure_SetBit1OfPlayerAndObjectFlags
    dw RunOneTimeTreasure_ShowMessageHL
    dw RunOneTimeTreasure_QueueSoundEffect
    dw RunOneTimeTreasure_ApplyMapScreenFlagEvents

; step 0 of RunOneTimeTreasure: branches on wScriptParam0; calls CopyItemNameToDE; advances
; wScriptStep; sets wScriptParam0; calls TestFlagBit; increments wScriptParam0; sets wScriptParam1
; to 0; ...
RunOneTimeTreasure_CopyItemNameToDE::
    ld a, [wScriptParam0]
    cp $03
    jr z, .read_script_param0
    ld a, [wScriptParam1]
    ld de, wTextBuf2 + $2
    call CopyItemNameToDE

.read_script_param0:
    ld hl, wScriptStep
    inc [hl]
    ld a, [wScriptParam0]
    push af
    ld c, a
    add a
    add c
    add $a0
    ld [wScriptParam0], a
    ld a, [wMessageIndex]
    ld e, a
    ld a, [wMessageGroup]
    ld d, a
    call TestFlagBit
    jr nc, .restore
    pop af
    ld hl, wScriptParam0
    inc [hl]
    xor a
    ld [wScriptParam1], a
    ret

.restore:
    pop af
    cp $03
    jr z, .call_generate_new_key_entry
    ld a, [wInventory + $17]
    cp $ff
    jr z, .skip
    cp $00
    jr nz, .loop

.skip:
    ld hl, wInventory

.skip2:
    ld a, [hl]
    or a
    jr z, .read_script_param1
    cp $ff
    jr z, .read_script_param1
    inc hl
    jr .skip2

.read_script_param1:
    ld a, [wScriptParam1]
    ld [hl], a
    ld a, [wInventorySortFlags]
    set 6, a
    ld [wInventorySortFlags], a

.read_message_index:
    ld a, [wMessageIndex]
    ld e, a
    ld a, [wMessageGroup]
    ld d, a
    call SetFlagBit
    xor a
    ld [wScriptParam1], a
    ret

.loop:
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    xor a
    ld [wScriptParam1], a
    ret

.call_generate_new_key_entry:
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    or a
    jr z, .loop
    jr .read_message_index

; step 1 of RunOneTimeTreasure: branches on wScriptParam1; calls SetBit1OfPlayerAndObjectFlags;
; calls FillTilesRequest; calls FillTilesFromRequest; plays sound $69; sets wTextWindowState to 1;
; sets wTextWindowStep to 0; ...
RunOneTimeTreasure_SetBit1OfPlayerAndObjectFlags::
    ld a, [wScriptParam1]
    bit 7, a
    jr nz, .done
    farcall SetBit1OfPlayerAndObjectFlags
    ld hl, vTiles1
    ld de, $1202
    call FillTilesRequest
    call FillTilesFromRequest
    ld a, $69
    call QueueSoundEffect
    ld a, $01
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ld a, $02
    ldh [hSpriteWindowClipMode], a
    ldh a, [hPlayerY]
    cp $48
    jr c, .done
    ld a, $81
    ld [wTextWindowState], a
    ld a, $01
    ldh [hSpriteWindowClipMode], a

.done:
    ld hl, wScriptStep
    inc [hl]
    ret

; step 2 of RunOneTimeTreasure: branches on wScriptParam1; returns if bit 7 of wScriptParam1 is set;
; calls ShowMessageHL; advances wScriptStep
RunOneTimeTreasure_ShowMessageHL::
    ld a, [wScriptParam1]
    bit 7, a
    jr nz, .read_script_param0
    ld a, [wTextWindowState]
    and $03
    ret nz

.read_script_param0:
    ld a, [wScriptParam0]
    ld l, a
    ld h, $00
    call ShowMessageHL
    ld hl, wScriptStep
    inc [hl]
    ret

; step 3 of RunOneTimeTreasure: returns if bit 0 of wTextFlags is set; branches on wScriptParam1;
; plays sound $69; sets hSpriteWindowClipMode to 0; sets wTextWindowState to 2; sets wTextWindowStep
; to 0; branches on hPlayerY; ...
RunOneTimeTreasure_QueueSoundEffect::
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld a, [wScriptParam1]
    bit 6, a
    jr nz, .done
    ld a, $69
    call QueueSoundEffect
    xor a
    ldh [hSpriteWindowClipMode], a
    ld a, $02
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ldh a, [hPlayerY]
    cp $48
    jr c, .done
    ld a, $82
    ld [wTextWindowState], a

.done:
    ld hl, wScriptStep
    inc [hl]
    ret

; step 4 of RunOneTimeTreasure: may return early; calls ApplyMapScreenFlagEvents; calls
; DrawFullScreenBufferAtScroll; calls ClearBit1OfPlayerAndObjectFlags; sets wScriptCommandType to 0;
; sets wScriptRunning to 0; sets wModeState to 0
RunOneTimeTreasure_ApplyMapScreenFlagEvents::
    ld a, [wTextWindowState]
    and $03
    ret nz
    farcall ApplyMapScreenFlagEvents
    farcall DrawFullScreenBufferAtScroll
    farcall ClearBit1OfPlayerAndObjectFlags
    xor a
    ld [wScriptCommandType], a
    xor a
    ld [wScriptRunning], a
    ld a, $00
    ld [wModeState], a
    ret

; implements script command type 0E; reached through ScriptCommand0E in bank $10 (E-0038)
ScriptCommand0E_Run::
    ld a, [wScriptStep]
    or a
    jr nz, .clear_script_command_type
    ld a, [wScriptParam0]
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

.clear_script_command_type:
    xor a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, [wScriptParam0]
    jumptable
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_SetSpriteSlotCount
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return
    dw ScriptCommand0E_Run_Return

; step 30 of ScriptCommand0E_Run: sets wSpriteSlotCount to 0
ScriptCommand0E_Run_SetSpriteSlotCount::
    xor a
    ld [wSpriteSlotCount], a
    ret

; step 0 of ScriptCommand0E_Run: returns at once
ScriptCommand0E_Run_Return::
    ret
    ds $4bf, $00
