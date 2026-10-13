SECTION "Bank 5F", ROMX[$4000], BANK[$5F]
    db $5F

; compressed tileset of map $30 (the first map record using it)
; LZSS-compressed asset: 1133 bytes expand to 1664 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map30Tileset:: ; heuristic: map tileset stream; C0
Data_05F_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17C001, $46D

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map30Palettes::
Data_05F_446E:: ; address name
    dw $7C01, $7FFF, $7FE1, $0000 ; entry 0
    dw $1154, $53DE, $229A, $0084 ; entry 1
    dw $0180, $53DE, $02C8, $0084 ; entry 2
    dw $10D6, $53DE, $227D, $0084 ; entry 3
    dw $1129, $53DE, $1996, $0CA5 ; entry 4
    dw $7CC0, $7FFF, $5AD6, $0000 ; entry 5
    dw $218C, $4F18, $3A52, $0CA5 ; entry 6
    dw $218C, $4F18, $3A52, $0CA5 ; entry 7

; compressed tileset of map $31 (the first map record using it)
; LZSS-compressed asset: 1298 bytes expand to 1440 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map31Tileset:: ; heuristic: map tileset stream; C0
Data_05F_44AE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17C4AE, $512

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map31Palettes::
Data_05F_49C0:: ; address name
    dw $7C01, $7FFF, $7FE1, $0000 ; entry 0
    dw $0192, $53DE, $22BA, $0000 ; entry 1
    dw $0284, $53DE, $034A, $0000 ; entry 2
    dw $44E8, $3F7F, $0216, $0000 ; entry 3
    dw $0192, $3F7F, $034A, $0000 ; entry 4
    dw $001B, $2BFF, $023F, $0000 ; entry 5
    dw $7DA0, $7FFF, $5AD6, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map31Screens0::
Data_05F_4A00:: ; address name
    dfar Map31Screens0_Y0X0 ; entry 0
    dfar Map31Screens0_Y1X0 ; entry 1

; E-0142 (derived: 2 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map31Attrs0::
Data_05F_4A06:: ; address name
    dfar Map31Attrs0_Y0X0 ; entry 0
    dfar Map31Attrs0_Y1X0 ; entry 1

; LZSS-compressed asset: 245 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map31Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_05F_4A0C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17CA0C, $F5

; LZSS-compressed asset: 222 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map31Screens0_Y1X0:: ; heuristic: map screen stream; C0
Data_05F_4B01:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17CB01, $DE

; LZSS-compressed asset: 79 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map31Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_05F_4BDF:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17CBDF, $4F

; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map31Attrs0_Y1X0:: ; heuristic: map screen stream; C0
Data_05F_4C2E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17CC2E, $55

; compressed tileset of map $36 (the first map record using it)
; LZSS-compressed asset: 393 bytes expand to 768 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map36Tileset:: ; heuristic: map tileset stream; C0
Data_05F_4C83:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17CC83, $189

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map36Screens0::
Data_05F_4E0C:: ; address name
    dfar Map36Screens0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map36Attrs0::
Data_05F_4E0F:: ; address name
    dfar Map36Attrs0_Y0X0 ; entry 0

; LZSS-compressed asset: 195 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map36Screens0_Y0X0:: ; heuristic: map screen stream; C0
Data_05F_4E12:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17CE12, $C3

; LZSS-compressed asset: 103 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map36Attrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_05F_4ED5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17CED5, $67

; compressed tileset of map $3B (the first map record using it)
; LZSS-compressed asset: 929 bytes expand to 1600 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3BTileset:: ; heuristic: map tileset stream; C0
Data_05F_4F3C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17CF3C, $3A1

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map3BPalettes::
Data_05F_52DD:: ; address name
    dw $01C8, $7FFF, $46AD, $0002 ; entry 0
    dw $46AD, $3F7F, $0216, $0002 ; entry 1
    dw $001B, $2BFF, $023F, $0000 ; entry 2
    dw $0108, $3F7F, $0216, $0002 ; entry 3
    dw $001B, $3F7F, $0216, $0002 ; entry 4
    dw $4F18, $3A52, $218C, $0CA5 ; entry 5
    dw $4F18, $3A52, $218C, $0CA5 ; entry 6
    dw $4F18, $3A52, $218C, $0CA5 ; entry 7

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map3BScreens0::
Data_05F_531D:: ; address name
    dfar Map3BScreens0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map3BAttrs0::
Data_05F_5320:: ; address name
    dfar Map3BAttrs0_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map3BScreens4::
Data_05F_5323:: ; address name
    dfar Map3BScreens4_Y0X0 ; entry 0

; E-0142 (derived: 1 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map3BAttrs4::
Data_05F_5326:: ; address name
    dfar Map3BAttrs4_Y0X0 ; entry 0

; LZSS-compressed asset: 141 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3BScreens0_Y0X0:: ; heuristic: map screen stream; C0
Data_05F_5329:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17D329, $8D

; LZSS-compressed asset: 184 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3BScreens4_Y0X0:: ; heuristic: map screen stream; C0
Data_05F_53B6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17D3B6, $B8

; LZSS-compressed asset: 53 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3BAttrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_05F_546E:: ; address name
    db $68, $01, $05, $00, $00, $03, $05, $02, $0B, $05, $FE, $FF, $4D, $05, $5E, $0F
    db $4D, $05, $96, $0F, $13, $02, $02, $05, $F6, $02, $05, $88, $05, $01, $04, $04
    db $05, $F8, $0E, $00, $04, $05, $FA, $04, $05, $88, $06, $05, $F8, $06, $05, $88
    db $02, $05, $41, $1F, $13

; LZSS-compressed asset: 49 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3BAttrs4_Y0X0:: ; heuristic: map screen stream; C0
Data_05F_54A3:: ; address name
    db $68, $01, $01, $00, $00, $03, $01, $02, $0B, $01, $FE, $FF, $4D, $01, $22, $0F
    db $0D, $01, $28, $08, $01, $8A, $0F, $0B, $01, $FC, $F6, $01, $B2, $0F, $07, $01
    db $F6, $FA, $01, $DA, $0C, $01, $D6, $0F, $01, $01, $AE, $0F, $1D, $01, $41, $1F
    db $13

; compressed tileset of map $3C (the first map record using it)
; LZSS-compressed asset: 1108 bytes expand to 1536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3CTileset:: ; heuristic: map tileset stream; C0
Data_05F_54D4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17D4D4, $454

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map3CPalettes::
Data_05F_5928:: ; address name
    dw $7DA0, $7FFF, $7FE0, $0063 ; entry 0
    dw $7DA0, $7FFF, $5AD6, $0063 ; entry 1
    dw $2D91, $3FBF, $4698, $0000 ; entry 2
    dw $02C0, $3F7F, $03E2, $0000 ; entry 3
    dw $012F, $3F7F, $01D5, $0044 ; entry 4
    dw $1528, $3F7F, $2A10, $0044 ; entry 5
    dw $11D4, $53DE, $22BA, $0000 ; entry 6
    dw $0044, $0044, $0044, $0044 ; entry 7

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map3CScreens0::
Data_05F_5968:: ; address name
    dfar Map3CScreens0_Y0X0 ; entry 0
    dfar Map3CScreens0_Y0X1 ; entry 1
    dfar Map3CScreens0_Y0X2 ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map3CAttrs0::
Data_05F_5971:: ; address name
    dfar Map3CAttrs0_Y0X0 ; entry 0
    dfar Map3CAttrs0_Y0X1 ; entry 1
    dfar Map3CAttrs0_Y0X2 ; entry 2

; LZSS-compressed asset: 230 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3CScreens0_Y0X0:: ; heuristic: map screen stream; C0
Data_05F_597A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17D97A, $E6

; LZSS-compressed asset: 222 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3CScreens0_Y0X1:: ; heuristic: map screen stream; C0
Data_05F_5A60:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17DA60, $DE

; LZSS-compressed asset: 259 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3CScreens0_Y0X2:: ; heuristic: map screen stream; C0
Data_05F_5B3E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17DB3E, $103

; LZSS-compressed asset: 118 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3CAttrs0_Y0X0:: ; heuristic: map screen stream; C0
Data_05F_5C41:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17DC41, $76

; LZSS-compressed asset: 103 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3CAttrs0_Y0X1:: ; heuristic: map screen stream; C0
Data_05F_5CB7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17DCB7, $67

; LZSS-compressed asset: 123 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map3CAttrs0_Y0X2:: ; heuristic: map screen stream; C0
Data_05F_5D1E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17DD1E, $7B

; compressed tileset of map $43 (the first map record using it)
; LZSS-compressed asset: 1291 bytes expand to 1536 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map43Tileset:: ; heuristic: map tileset stream; C0
Data_05F_5D99:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17DD99, $50B

; E-0142 (derived: the $40 bytes LoadBGPaletteBufferFromBank copies for a map record)
; record: one CGB palette: 4 BGR555 colours
Map43Palettes::
Data_05F_62A4:: ; address name
    dw $7DA0, $7FFF, $7FE0, $0000 ; entry 0
    dw $7DA0, $4F18, $260C, $0000 ; entry 1
    dw $7DA0, $4F18, $7FE0, $0000 ; entry 2
    dw $0941, $4F18, $1627, $0000 ; entry 3
    dw $0941, $4F18, $260C, $0000 ; entry 4
    dw $012F, $4F3A, $01D5, $0000 ; entry 5
    dw $012F, $3FBF, $01D5, $0000 ; entry 6
    dw $0000, $0000, $0000, $0000 ; entry 7

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map43Screens0::
Data_05F_62E4:: ; address name
    dfar Map43Screens0_Y0X0 ; entry 0
    dfar Map43Screens0_Y0X1 ; entry 1
    dfar Map43Screens0_Y0X2 ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map43Attrs0::
Data_05F_62ED:: ; address name
    dfar Map43Attrs0_Y0X0 ; entry 0
    dfar Map43Attrs0_Y0X1 ; entry 1
    dfar Map43Attrs0_Y0X2 ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map43Screens1::
Data_05F_62F6:: ; address name
    dfar Map43Screens1_Y0X0 ; entry 0
    dfar Map43Screens0_Y0X1 ; entry 1
    dfar Map43Screens0_Y0X2 ; entry 2

; E-0142 (derived: 3 screen far pointers, row by row)
; record: compressed 20 x 18 screen; its ROM bank
Map43Attrs1::
Data_05F_62FF:: ; address name
    dfar Map43Attrs1_Y0X0 ; entry 0
    dfar Map43Attrs0_Y0X1 ; entry 1
    dfar Map43Attrs0_Y0X2 ; entry 2

; LZSS-compressed asset: 275 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map43Screens0_Y0X0:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_05F_6308:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17E308, $113

; LZSS-compressed asset: 274 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map43Screens1_Y0X0:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_05F_641B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17E41B, $112

; LZSS-compressed asset: 292 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map43Screens0_Y0X1:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_05F_652D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17E52D, $124

; LZSS-compressed asset: 250 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map43Screens0_Y0X2:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_05F_6651:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17E651, $FA

; LZSS-compressed asset: 131 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map43Attrs0_Y0X0:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_05F_674B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17E74B, $83

; LZSS-compressed asset: 128 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map43Attrs1_Y0X0:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_05F_67CE:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17E7CE, $80

; LZSS-compressed asset: 122 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map43Attrs0_Y0X1:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_05F_684E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17E84E, $7A

; LZSS-compressed asset: 110 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Map43Attrs0_Y0X2:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_05F_68C8:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $17E8C8, $6E

; wMessageState ($FF = idle) steps a message: 0 opens the message window (unless wMessageGroup bit 7) at the bottom, or at the top when hPlayerY >= $48, with sound $69; 1 waits for the window, then ShowMessageFromMessageIndex starts the text; 2 waits until wTextFlags bit 0 clears (text done), then closes the window (unless wMessageGroup bit 6); 3 waits for the close. When wStepPtrLo is 0, state 0 also calls Func_004_4470 and state 3 ClearBit1OfPlayerAndObjectFlags (probably freezing and releasing the player and objects). The steps after state 3 are not read (E-0079)
; 6 call sites from 6 routines (e.g. RunMessageBoxCarryWhenIdle_Bank5F, RunMessageBoxFar_Bank0F, RunMessageBoxFar_Bank12, SceneWarubouFood2_RunMessageBox, ...)
; reads: wMessageState
RunMessageBox::
Func_05F_6936:: ; address name
    ld a, [wMessageState]
    cp a, $FF
    jr nz, .skip
    ret

.skip:
    rst $00
    dw RunMessageBox_SetBit1OfPlayerAndObjectFlags
    dw RunMessageBox_ShowMessageFromMessageIndex
    dw RunMessageBox_QueueSoundEffect
    dw RunMessageBox_WriteMessageState

; entry 0 of the `rst $00` table in RunMessageBox
; no direct call (reached through a table, a jump or a vector)
; reads: wStepPtrLo, wMessageGroup, hPlayerY
; writes: wTextWindowState, wTextWindowStep, hSpriteWindowClipMode
; points at: wMessageState
RunMessageBox_SetBit1OfPlayerAndObjectFlags::
Jump_05F_6947:: ; address name
    ld a, [wStepPtrLo]
    or a, a
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
    cp a, $48
    jr c, .done
    ld a, $81
    ld [wTextWindowState], a
    ld a, $01
    ldh [hSpriteWindowClipMode], a

.done:
    ld hl, wMessageState
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunMessageBox
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageGroup, wTextWindowState
; points at: wMessageState
RunMessageBox_ShowMessageFromMessageIndex::
Jump_05F_698D:: ; address name
    ld a, [wMessageGroup]
    bit 7, a
    jr nz, .call_show_message_from_message_index
    ld a, [wTextWindowState]
    and a, $03
    ret nz

.call_show_message_from_message_index:
    call ShowMessageFromMessageIndex
    ld hl, wMessageState
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunMessageBox
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wMessageGroup, hPlayerY
; writes: wTextWindowState, wTextWindowStep, hSpriteWindowClipMode
; points at: wMessageState
RunMessageBox_QueueSoundEffect::
Jump_05F_69A2:: ; address name
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
    cp a, $48
    jr c, .done
    ld a, $82
    ld [wTextWindowState], a

.done:
    ld hl, wMessageState
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunMessageBox
; no direct call (reached through a table, a jump or a vector)
; reads: wMessageGroup, wTextWindowState, wStepPtrLo
; writes: wMessageState
RunMessageBox_WriteMessageState::
Jump_05F_69D2:: ; address name
    ld a, [wMessageGroup]
    bit 6, a
    jr nz, .check_step_ptr_lo
    ld a, [wTextWindowState]
    and a, $03
    jr z, .check_step_ptr_lo
    ret

.check_step_ptr_lo:
    ld a, [wStepPtrLo]
    or a, a
    jr nz, .set_message_state_to_FF
    farcall ClearBit1OfPlayerAndObjectFlags

.set_message_state_to_FF:
    ld a, $FF
    ld [wMessageState], a
    ret

; HL = wMessageIndex/wMessageGroup, then ShowMessageHL (E-0079)
; 1 call site from 1 routine (e.g. RunMessageBox_ShowMessageFromMessageIndex)
; reads: wMessageIndex, wMessageGroup, wMapType
; writes: wStringIndex, wStringCategory
ShowMessageFromMessageIndex::
Func_05F_69F3:: ; address name
    ld a, [wMessageIndex]
    ld l, a
    ld a, [wMessageGroup]
    ld h, a

; L = string index (wStringIndex, category 0), H & $3F = message group, which selects one of 12 table entries (rst $00); when wMapType has bit 7 set and is not $80 another path is taken (not read) (E-0079)
; 1 call site from 1 routine (e.g. RunOneTimeTreasure_ShowMessageHL)
; reads: wMapType
; writes: wStringIndex, wStringCategory
ShowMessageHL::
Func_05F_69FB:: ; address name
    ld a, [wMapType]
    cp a, $80
    jr z, .skip
    bit 7, a
    jp nz, ShowMessageHL_ToBeginStringDisplay_Bank89_SetStringIndex

.skip:
    ld a, h
    and a, $3F
    ld h, a
    ld a, l
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    ld a, h
    rst $00
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

; entry 0 of the `rst $00` table in ShowMessageHL
; no direct call (reached through a table, a jump or a vector)
ShowMessageHL_ToBeginStringDisplay_Bank28::
Jump_05F_6A31:: ; address name
    farcall BeginStringDisplay_Bank28
    ret

; entry 1 of the `rst $00` table in ShowMessageHL
; no direct call (reached through a table, a jump or a vector)
ShowMessageHL_ToBeginStringDisplay_Bank29::
Jump_05F_6A38:: ; address name
    farcall BeginStringDisplay_Bank29
    ret

; entry 2 of the `rst $00` table in ShowMessageHL
; no direct call (reached through a table, a jump or a vector)
ShowMessageHL_ToBeginStringDisplay_Bank2A::
Jump_05F_6A3F:: ; address name
    farcall BeginStringDisplay_Bank2A
    ret

; entry 3 of the `rst $00` table in ShowMessageHL
; no direct call (reached through a table, a jump or a vector)
ShowMessageHL_ToBeginStringDisplay_Bank2B::
Jump_05F_6A46:: ; address name
    farcall BeginStringDisplay_Bank2B
    ret

; entry 4 of the `rst $00` table in ShowMessageHL
; no direct call (reached through a table, a jump or a vector)
ShowMessageHL_ToBeginStringDisplay_Bank2C::
Jump_05F_6A4D:: ; address name
    farcall BeginStringDisplay_Bank2C
    ret

; entry 5 of the `rst $00` table in ShowMessageHL
; no direct call (reached through a table, a jump or a vector)
ShowMessageHL_ToBeginStringDisplay_Bank2D::
Jump_05F_6A54:: ; address name
    farcall BeginStringDisplay_Bank2D
    ret

; entry 6 of the `rst $00` table in ShowMessageHL
; no direct call (reached through a table, a jump or a vector)
ShowMessageHL_ToBeginStringDisplay_Bank2E::
Jump_05F_6A5B:: ; address name
    farcall BeginStringDisplay_Bank2E
    ret

; entry 8 of the `rst $00` table in ShowMessageHL
; no direct call (reached through a table, a jump or a vector)
ShowMessageHL_ToBeginStringDisplay_Bank7C::
Jump_05F_6A62:: ; address name
    farcall BeginStringDisplay_Bank7C
    ret

; entry 9 of the `rst $00` table in ShowMessageHL
; no direct call (reached through a table, a jump or a vector)
ShowMessageHL_ToBeginStringDisplay_Bank80::
Jump_05F_6A69:: ; address name
    farcall BeginStringDisplay_Bank80
    ret

; entry 11 of the `rst $00` table in ShowMessageHL
; no direct call (reached through a table, a jump or a vector)
ShowMessageHL_ToBeginStringDisplay_Bank82::
Jump_05F_6A70:: ; address name
    farcall BeginStringDisplay_Bank82
    ret

; entry 12 of the `rst $00` table in ShowMessageHL
; no direct call (reached through a table, a jump or a vector)
ShowMessageHL_ToBeginStringDisplay_Bank86::
Jump_05F_6A77:: ; address name
    farcall BeginStringDisplay_Bank86
    ret

; entry 13 of the `rst $00` table in ShowMessageHL
; no direct call (reached through a table, a jump or a vector)
ShowMessageHL_ToBeginStringDisplay_Bank89::
Jump_05F_6A7E:: ; address name
    farcall BeginStringDisplay_Bank89
    ret

ShowMessageHL_ToBeginStringDisplay_Bank89_SetStringIndex::
Jump_05F_6A85:: ; address name
    ld a, l
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank28
    ret

; sets bit 2 of hPlayerStateFlags (moving) and hPlayerFacing = 0; calls Func_05F_6B43 with the coordinate; then hPlayerY += 1; when it equals wStepPtrLo bit 2 is cleared and wStepArrived = 1, else wStepArrived = 0 (E-0071)
; 11 call sites from 9 routines (e.g. SceneDarckDefeated_StepPlayerDownTowardWC928, SceneSpiritEnvoy_StepPlayerDownTowardWC928_Case06, SceneSpiritEnvoy_StepPlayerDownTowardWC928, SceneMermaidKingdom_StepPlayerDownTowardWC928, ...)
; reads: hPlayerStateFlags, hPlayerY, wStepPtrLo
; writes: hPlayerStateFlags, hPlayerFacing, hPlayerY, wStepArrived
StepPlayerDownTowardWC928::
Func_05F_6A94:: ; address name
    ldh a, [hPlayerStateFlags]
    or a, $04
    ldh [hPlayerStateFlags], a
    xor a, a
    ldh [hPlayerFacing], a
    ldh a, [hPlayerY]
    call UpdateFollowersOnStep_Bank5F
    ld a, [wStepPtrLo]
    ld c, a
    ldh a, [hPlayerY]
    inc a
    ldh [hPlayerY], a
    cp a, c
    jr z, .check_player_state_flags
    xor a, a
    ld [wStepArrived], a
    ret

.check_player_state_flags:
    ldh a, [hPlayerStateFlags]
    and a, $FB
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wStepArrived], a
    ret

; sets bit 2 of hPlayerStateFlags (moving) and hPlayerFacing = 1; calls Func_05F_6B43 with the coordinate; then hPlayerX += 1; when it equals wStepPtrLo bit 2 is cleared and wStepArrived = 1, else wStepArrived = 0 (E-0071)
; 7 call sites from 6 routines (e.g. SceneDarckDefeated_StepPlayerDownTowardWC928, SceneMedicineGiven_StepObjectTowardCoord_Case03, SceneMermaidKingdom_StepPlayerDownTowardWC928, SceneHorsingAround_StepPlayerLeftTowardWC928, ...)
; reads: hPlayerStateFlags, hPlayerX, wStepPtrLo
; writes: hPlayerStateFlags, hPlayerFacing, hPlayerX, wStepArrived
StepPlayerRightTowardWC928::
Func_05F_6ABF:: ; address name
    ldh a, [hPlayerStateFlags]
    or a, $04
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
    cp a, c
    jr z, .check_player_state_flags
    xor a, a
    ld [wStepArrived], a
    ret

.check_player_state_flags:
    ldh a, [hPlayerStateFlags]
    and a, $FB
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wStepArrived], a
    ret

; sets bit 2 of hPlayerStateFlags (moving) and hPlayerFacing = 2; calls Func_05F_6B43 with the coordinate; then hPlayerY -= 1; when it equals wStepPtrLo bit 2 is cleared and wStepArrived = 1, else wStepArrived = 0 (E-0071)
; 15 call sites from 12 routines (e.g. SceneDarckDefeated_StepPlayerLeftTowardWC928, SceneMedicineGiven_StepObjectTowardCoord_Case03, SceneMedicineGiven_StepObjectTowardCoord_Case02, SceneMedicineGiven_StepObjectTowardCoord, ...)
; reads: hPlayerStateFlags, hPlayerY, wStepPtrLo
; writes: hPlayerStateFlags, hPlayerFacing, hPlayerY, wStepArrived
StepPlayerUpTowardWC928::
Func_05F_6AEB:: ; address name
    ldh a, [hPlayerStateFlags]
    or a, $04
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
    cp a, c
    jr z, .check_player_state_flags
    xor a, a
    ld [wStepArrived], a
    ret

.check_player_state_flags:
    ldh a, [hPlayerStateFlags]
    and a, $FB
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wStepArrived], a
    ret

; sets bit 2 of hPlayerStateFlags (moving) and hPlayerFacing = 3; calls Func_05F_6B43 with the coordinate; then hPlayerX -= 1; when it equals wStepPtrLo bit 2 is cleared and wStepArrived = 1, else wStepArrived = 0 (E-0071)
; 16 call sites from 13 routines (e.g. SceneHomecoming_ClearBit2AtHL_Bank0F, SceneDarckDefeated_StepPlayerLeftTowardWC928, SceneMedicineGiven_StepObjectTowardCoord_Case02, SceneMedicineGiven_StepObjectTowardCoord, ...)
; reads: hPlayerStateFlags, hPlayerX, wStepPtrLo
; writes: hPlayerStateFlags, hPlayerFacing, hPlayerX, wStepArrived
StepPlayerLeftTowardWC928::
Func_05F_6B17:: ; address name
    ldh a, [hPlayerStateFlags]
    or a, $04
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
    cp a, c
    jr z, .check_player_state_flags
    xor a, a
    ld [wStepArrived], a
    ret

.check_player_state_flags:
    ldh a, [hPlayerStateFlags]
    and a, $FB
    ldh [hPlayerStateFlags], a
    ld a, $01
    ld [wStepArrived], a
    ret

; A = the player's moving coordinate: when A & $0F = 0 (a 16-pixel tile boundary) far-calls SetFollowerTargetsFromLeader; then always far-calls StepFollowersTowardTargets (E-0093) (the same 17 bytes appear in 3 banks)
; 5 call sites from 5 routines (e.g. StepPlayerLeftTowardWC928, StepPlayerRightTowardWC928, StepPlayerDownTowardWC928, StepPlayerUpTowardWC928, ...)
UpdateFollowersOnStep_Bank5F::
Func_05F_6B43:: ; address name
    and a, $0F
    jr nz, .call_step_followers_toward_targets
    farcall SetFollowerTargetsFromLeader

.call_step_followers_toward_targets:
    farcall StepFollowersTowardTargets
    ret

; wStepPtrHi = object number (16-byte entries): sets bit 2 of wSpriteSlots + $D + 16n, stores direction wStepTarget & 3 at wSpriteSlots + $7 + 16n and moves the object one pixel, two when wStepTarget bit 7 is set: direction 0 adds the step to Y (wSpriteSlots + $C + 16n), 1 adds it to X (wSpriteSlots + $B + 16n), 2 subtracts it from Y, 3 from X. When the moved coordinate equals wStepPtrLo it clears bit 2 and sets wStepArrived = 1, else wStepArrived = 0 (E-0061)
; 145 call sites from 78 routines (e.g. ScenePendantSeller_StepObjectTowardCoord, SceneHomecoming_StepObjectTowardCoord, ScriptStepMoveObjects2And3To81B0, ScriptStepMoveObjects2And3To0340, ...)
; reads: wStepPtrHi, wStepTarget, wStepPtrLo
; writes: wStepArrived
StepObjectTowardCoord::
Func_05F_6B54:: ; address name
    ld a, [wStepPtrHi]
    swap a
    ld hl, wSpriteSlots + $D
    add_a_to_hl
    ld a, [hl]
    or a, $04
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
    and a, $03
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
    cp a, c
    jr z, .restore
    xor a, a
    ld [wStepArrived], a
    pop hl
    ret

.restore:
    pop hl
    ld a, [hl]
    and a, $FB
    ld [hl], a
    ld a, $01
    ld [wStepArrived], a
    ret

; the byte at the address in wStepPtrLo/wStepPtrHi += the byte at Func_05F_6BE8 + wScriptParam0 / 2
; 66 call sites from 54 routines (e.g. RunSceneScriptSubStep_AddStepDeltaToPointedByte_Case0F, RunSceneScriptSubStep_CycleSpriteFloatYDown_Case0D, RunSceneScriptSubStep_CycleSpriteFloatYDown_Case0B, RunSceneScriptSubStep_CycleSpriteFloatYDown_Case08, ...)
; reads: wStepPtrLo, wStepPtrHi, wScriptParam0
AddStepDeltaToPointedByte::
Func_05F_6BCD:: ; address name
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
    add a, c
    ld [de], a
    ret

; address loaded by AddStepDeltaToPointedByte
AddStepDeltaToPointedByte_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_05F_6BE8:: ; address name
    db $FE, $FF, $FF, $00, $FF, $00, $FF, $00, $00, $01, $00, $01, $00, $01, $01, $02

; for $78 frames blinks object hTemp0 by alternating byte wSpriteSlots + $C[16 * obj] between hTemp1 and $E0 (hidden) at a slowing rate; hTemp0 = 1 when done (E-0127)
; 20 call sites from 19 routines (e.g. SceneDarckDefeated_ScriptStepBlinkObjectTemp0, SceneGrave_ScriptStepBlinkObjectTemp0, SceneShield_ShowABeautifulVoiceEchoed, SceneShieldGuardian_ShowOhMyGoodnessThank, ...)
; reads: wScriptParam0, hTemp0, hTemp1
; writes: wScriptParam0, hTemp0
ScriptStepBlinkObjectTemp0::
Func_05F_6BF8:: ; address name
    ld a, [wScriptParam0]
    cp a, $1E
    jr nc, .cp_3C
    bit 3, a
    jr z, .read_temp0
    jr .read_temp02

.cp_3C:
    cp a, $3C
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
    ld hl, wSpriteSlots + $C
    add_a_to_hl
    ldh a, [hTemp1]
    ld [hl], a
    jr .check_script_param0

.read_temp02:
    ldh a, [hTemp0]
    swap a
    ld hl, wSpriteSlots + $C
    add_a_to_hl
    ld [hl], $E0

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $78
    jr z, .read_temp03
    xor a, a
    ldh [hTemp0], a
    ret

.read_temp03:
    ldh a, [hTemp0]
    swap a
    ld hl, wSpriteSlots + $C
    add_a_to_hl
    ld [hl], $E0
    xor a, a
    ld [wScriptParam0], a
    ld a, $01
    ldh [hTemp0], a
    ret

; StartPaletteFade with A = $0F, wModeState = 4, wFieldTransitionStep = 0, wScriptParam0 = 0, then wScriptStep += 1 (E-0061)
; 53 call sites from 50 routines (e.g. SceneDarckDefeated_ScriptStartFadeAndAdvanceStep_Case8F, SceneDarckDefeated_ScriptStartFadeAndAdvanceStep, SceneDarckDefeated_ShowWarubouWaheyYouDid, SceneThreeItems_ShowWarubouWaheyHeroAnd, ...)
; writes: wModeState, wFieldTransitionStep, wScriptParam0
; points at: wScriptStep
ScriptStartFadeAndAdvanceStep::
Func_05F_6C5A:: ; address name
    ld a, $0F
    call StartPaletteFade
    ld a, $04
    ld [wModeState], a
    xor a, a
    ld [wFieldTransitionStep], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; wModeState = 3, wBattleTransitionStep = 0, wFieldReturnPhase = 2, far-calls SaveScreenBufferToBGMap1, then Func_00A_476E (E-0078)
; 5 call sites from 5 routines (e.g. RandomBattleEvent, ArenaRounds_StepScriptParam0Counter_Bank12, KeyWorldBossBattle_RunMessageBoxFar_Bank12, KeyWorldFloorBattle_RunMessageBoxFar_Bank12, ...)
; writes: wModeState, wBattleTransitionStep, wFieldReturnPhase
SetModeState3AndSaveScreen::
Func_05F_6C71:: ; address name
    ld a, $03
    ld [wModeState], a
    xor a, a
    ld [wBattleTransitionStep], a
    ld a, $02
    ld [wFieldReturnPhase], a
    farcall SaveScreenBufferToBGMap1
    farcall PickRandomEncounterCountdownFromTable478F
    ret

; stores wStepPtrLo in the first wInventory slot that is $00 or $FF (no bound check), then sets bit 6 of wGameFlags836; HL kept (E-0071)
; 19 call sites from 18 routines (e.g. GiveItemBlink_TestFlagBit, RandomGoldOrItem_AddGoldCapped, KeyWorldDoorItem_WriteScriptStartRequestAndStepPtrLo, AreaItemEvent_WriteScriptStartRequestAndStepPtrLo, ...)
; reads: wStepPtrLo, wGameFlags836
; writes: wGameFlags836
; points at: wInventory
AppendItemWC928ToInventory::
Func_05F_6C8C:: ; address name
    push hl
    ld hl, wInventory

.skip:
    ld a, [hl]
    or a, a
    jr z, .read_step_ptr_lo
    cp a, $FF
    jr z, .read_step_ptr_lo
    inc hl
    jr .skip

.read_step_ptr_lo:
    ld a, [wStepPtrLo]
    ld [hl], a
    pop hl
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a
    ret

; wStepArrived = 1 when a party record has bit 7 of field $55 set, else 0 (E-0124)
; 5 call sites from 4 routines (e.g. YoldTalkEvents_TestFlagBit_Case13, KalkaTalkEvents_TestFlagBit_Case18, NordenTalkEvents_ShowYoureHereToCheer, GreatLogFieldEvents_SetWStepArrivedIfPartyHasField55Bit7)
; reads: wPartyCount, hTemp0
; writes: rRAMG, wStepArrived
; points at: wPartyList
SetWStepArrivedIfPartyHasField55Bit7::
Func_05F_6CA9:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyCount]
    or a, a
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
    xor a, a
    ld [wStepArrived], a
    xor a, a
    ld [rRAMG], a
    ret

.set_step_arrived_to_01:
    ld a, $01
    ld [wStepArrived], a
    xor a, a
    ld [rRAMG], a
    ret

; only called from GreatLogFieldEvents_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. GreatLogFieldEvents_SetWStepArrivedIfPartyHasField55Bit7)
; reads: wPartyCount, hTemp0
; writes: rRAMG, wStepArrived
; points at: wPartyList
GreatLogFieldEvents_Shared01_LoadSRAMRecordByte_Sub01::
Func_05F_6CDB:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyCount]
    or a, a
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
    xor a, a
    ld [wStepArrived], a
    xor a, a
    ld [rRAMG], a
    ret

.set_step_arrived_to_01:
    ld a, $01
    ld [wStepArrived], a
    xor a, a
    ld [rRAMG], a
    ret

; only called from GreatLogFieldEvents_Shared01 (E-0047)
; 1 call site from 1 routine (e.g. GreatLogFieldEvents_SetWStepArrivedIfPartyHasField55Bit7)
; reads: wPartyCount, hTemp0
; writes: rRAMG, wStepArrived
; points at: wPartyList
GreatLogFieldEvents_Shared01_LoadSRAMRecordByte::
Func_05F_6D0D:: ; address name
    ld a, $0A
    ld [rRAMG], a
    ld a, [wPartyCount]
    or a, a
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
    xor a, a
    ld [wStepArrived], a
    xor a, a
    ld [rRAMG], a
    ret

.set_step_arrived_to_01:
    ld a, $01
    ld [wStepArrived], a
    xor a, a
    ld [rRAMG], a
    ret

; with hFieldDrawFlags bits 1-3 set: wArg1 = wPartyList[hTemp0] (bank 0 record), far-calls Func_014_7E96, LoadRecordListNameTiles and Func_004_4AA8, wOBJPaletteUploadRequest = $7F, then clears hFieldDrawFlags bits 1-3 (E-0121)
; 3 call sites from 3 routines (e.g. RewardItemOrKey2_LoadListedRecordNameTilesForTemp0, RewardItemOrKey_LoadListedRecordNameTilesForTemp0, SceneMasterThanks_LoadListedRecordNameTilesForTemp0)
; reads: hFieldDrawFlags, hTemp0
; writes: hFieldDrawFlags, wArg1, wArg2, wOBJPaletteUploadRequest
; points at: wPartyList
LoadListedRecordNameTilesForTemp0::
Func_05F_6D3F:: ; address name
    farcall FindPartyIndexOfSpeciesTemp0
    ldh a, [hFieldDrawFlags]
    or a, $0E
    ldh [hFieldDrawFlags], a
    ldh a, [hTemp0]
    ld hl, wPartyList
    add_a_to_hl
    ld a, [hl]
    ld [wArg1], a
    xor a, a
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    call LoadRecordListNameTiles
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    ldh a, [hFieldDrawFlags]
    and a, $F1
    ldh [hFieldDrawFlags], a
    ret

; for record $FF in bank 1 (Func_014_7E96): if wArg5 is not $FF and is >= Data_05F_6DA8[wFarmLevel & 3], sets wArg5 = $FF (E-0121)
; 9 call sites from 9 routines (e.g. GreatLogTalkEvents_ShowTheFarmIsFull, GreatLogTalkEvents_TestFlagBit_Case42, Talk08D1_TheEvaluatorSaidI, UnreferencedScriptStepDispatch_73_6D52_ClearArg5IfAtOrAboveLimitForFarmLevel, ...)
; reads: wArg5, wFarmLevel
; writes: wArg1, wArg2, wArg5
ClearArg5IfAtOrAboveLimitForFarmLevel::
Func_05F_6D78:: ; address name
    ld a, $FF
    ld [wArg1], a
    ld a, $01
    ld [wArg2], a
    farcall DeleteSRAMRecordAndCompact
    ld a, [wArg5]
    cp a, $FF
    ret z
    ld a, [wFarmLevel]
    and a, $03
    ld hl, ClearArg5IfAtOrAboveLimitForFarmLevel_Data
    add_a_to_hl
    ld a, [hl]
    ld c, a
    ld a, [wArg5]
    cp a, c
    ret c
    ld a, $FF
    ld [wArg5], a
    ret

; address loaded by ClearArg5IfAtOrAboveLimitForFarmLevel
ClearArg5IfAtOrAboveLimitForFarmLevel_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_05F_6DA8:: ; address name
    db $0A, $14, $1E, $1E

; sets bit 6 of the first used key entry (byte 3 bit 7) whose kind (byte 0 & $3F) equals hTemp0 (E-0125)
; 11 call sites from 9 routines (e.g. Talk075F_KiralFetchMeMy, SceneDarckDefeated_ShowKingEvenThoughThe, SceneThreeItems_RunMessageBoxFar_Bank0F, SceneShield2_SetFlagBit, ...)
; reads: hTemp0
; points at: wKeyList
MarkKeyEntryKindTemp0Bit6::
Func_05F_6DAC:: ; address name
    ldh a, [hTemp0]
    ld c, a
    ld hl, wKeyList

.skip:
    push hl
    ld a, [hl]
    cp a, $FE
    jr z, .restore
    cp a, $FF
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
    and a, $3F
    cp a, c
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

; HL = the BG map entry at the scroll origin ((hScrollY & $F8) * 4 + $9800, rows wrapped by & $9B, + hScrollX / 8), then DrawFullScreenBufferToBGMap (E-0093)
; 23 call sites from 23 routines (e.g. SceneHomecoming_ShowTHEEND, SceneDarckDefeated_StepPlayerLeftTowardWC928, SceneWallExit_ShowKamehaHeroThatWasnt, SceneReportToKing_DrawFullScreenBufferAtScroll, ...)
; reads: hScrollY, hScrollX
DrawFullScreenBufferAtScroll::
Func_05F_6DDB:: ; address name
    ldh a, [hScrollY]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $98
    ld d, a
    ld a, d
    and a, $9B
    ld d, a
    ldh a, [hScrollX]
    srl a
    srl a
    srl a
    add a, e
    ld e, a
    jr nc, .call_draw_full_screen_buffer_to_bg_map
    inc d

.call_draw_full_screen_buffer_to_bg_map:
    ld l, e
    ld h, d
    call DrawFullScreenBufferToBGMap
    ret

; DE = the BG map row at hScrollY (& $F8); calls Func_05F_6E35 for the columns at hScrollX - 8 and hScrollX + $A0, just off the left and right edges (E-0121)
; 9 call sites from 9 routines (e.g. SceneDarckDefeated_RedrawColumnsBesideScreenAndStep, SceneThreeItems_ToRedrawColumnsBesideScreenAndStep, SceneExplosion_TestFlagBit, SceneWallExit_RedrawColumnsBesideScreen, ...)
; reads: hScrollY, hScrollX
RedrawColumnsBesideScreen::
Func_05F_6E09:: ; address name
    ldh a, [hScrollY]
    and a, $F8
    ld e, a
    ld d, $00
    sla e
    rl d
    sla e
    rl d
    ld a, e
    add a, $00
    ld e, a
    ld a, d
    adc a, $98
    ld d, a
    ld a, d
    and a, $9B
    ld d, a
    push de
    ldh a, [hScrollX]
    sub a, $08
    call RedrawColumnsBesideScreen_WriteVRAMByte
    pop de
    ldh a, [hScrollX]
    add a, $A0
    call RedrawColumnsBesideScreen_WriteVRAMByte
    ret

; only called from RedrawColumnsBesideScreen (E-0047)
; 2 call sites from 1 routine (e.g. RedrawColumnsBesideScreen)
RedrawColumnsBesideScreen_WriteVRAMByte::
Func_05F_6E35:: ; address name
    srl a
    srl a
    srl a
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld l, e
    ld h, d
    ld b, $12

.loop:
    ld a, $C4
    call WriteVRAMByte
    ld a, $20
    add_a_to_hl
    ld a, h
    and a, $9B
    ld h, a
    dec b
    jr nz, .loop
    ret

; by its step: changes the player's facing and the follower records between short waits (wScriptParam0)
; 1 call site from 1 routine (e.g. SceneDancing_ToSceneDancing_DanceSteps)
; reads: wScriptSubStep
SceneDancing_DanceSteps::
Func_05F_6E58:: ; address name
    ld a, [wScriptSubStep]
    rst $00
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_WritePlayerFacingAndFollowerRecordsEtc
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_WritePlayerFacingAndFollowerRecordsEtc_Case05
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_WritePlayerFacingAndFollowerRecordsEtc_Case08
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_WritePlayerFacingAndFollowerRecords
    dw SceneDancing_DanceSteps_AddStepDeltaToPointedByte
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_WriteScriptParam0
    dw SceneDancing_DanceSteps_WritePlayerStateFlags

; entry 11 of the `rst $00` table in SceneDancing_DanceSteps
; no direct call (reached through a table, a jump or a vector)
; writes: hPlayerFacing, wFollowerRecords
; points at: wScriptSubStep
SceneDancing_DanceSteps_WritePlayerFacingAndFollowerRecords::
Jump_05F_6E7E:: ; address name
    xor a, a
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 8 of the `rst $00` table in SceneDancing_DanceSteps
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerStateFlags, wScriptParam0
; writes: hPlayerFacing, wFollowerRecords, hPlayerStateFlags, wScriptParam0
; points at: wScriptSubStep
SceneDancing_DanceSteps_WritePlayerFacingAndFollowerRecordsEtc_Case08::
Jump_05F_6E8F:: ; address name
    ld a, $02
    jr SceneDancing_DanceSteps_WritePlayerFacingAndFollowerRecordsEtc_SetPlayerFacing

; entry 5 of the `rst $00` table in SceneDancing_DanceSteps
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerStateFlags, wScriptParam0
; writes: hPlayerFacing, wFollowerRecords, hPlayerStateFlags, wScriptParam0
; points at: wScriptSubStep
SceneDancing_DanceSteps_WritePlayerFacingAndFollowerRecordsEtc_Case05::
Jump_05F_6E93:: ; address name
    ld a, $01
    jr SceneDancing_DanceSteps_WritePlayerFacingAndFollowerRecordsEtc_SetPlayerFacing

; entry 2 of the `rst $00` table in SceneDancing_DanceSteps
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerStateFlags, wScriptParam0
; writes: hPlayerFacing, wFollowerRecords, hPlayerStateFlags, wScriptParam0
; points at: wScriptSubStep
SceneDancing_DanceSteps_WritePlayerFacingAndFollowerRecordsEtc::
Jump_05F_6E97:: ; address name
    ld a, $03

SceneDancing_DanceSteps_WritePlayerFacingAndFollowerRecordsEtc_SetPlayerFacing::
Jump_05F_6E99:: ; address name
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ldh a, [hPlayerStateFlags]
    and a, $FD
    ldh [hPlayerStateFlags], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $40
    ret nz
    ldh a, [hPlayerStateFlags]
    or a, $02
    ldh [hPlayerStateFlags], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; by its step: waits, moves two objects by table and changes the player's facing and followers
; 1 call site from 1 routine (e.g. SceneMermaidSong2_ToSceneMermaidSong2_MoveSteps)
; reads: wScriptSubStep
SceneMermaidSong2_MoveSteps::
Func_05F_6EC3:: ; address name
    ld a, [wScriptSubStep]
    rst $00
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

; entry 16 of the `rst $00` table in SceneDancing_DanceSteps
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerStateFlags
; writes: hPlayerStateFlags
; points at: wScriptStep
SceneDancing_DanceSteps_WritePlayerStateFlags::
Jump_05F_6EE3:: ; address name
    ldh a, [hPlayerStateFlags]
    and a, $FD
    ldh [hPlayerStateFlags], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in SceneDancing_DanceSteps
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: hPlayerY, wScriptSubStep
SceneDancing_DanceSteps_AddStepDeltaToPointedByte::
Jump_05F_6EEE:: ; address name
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
    ld de, wFollowerRecords + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in SceneMermaidSong2_MoveSteps
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerFacing
; writes: wScriptParam0, hPlayerFacing, wFollowerRecords
; points at: wScriptSubStep
SceneMermaidSong2_MoveSteps_WriteScriptParam0AndPlayerFacingEtc::
Jump_05F_6F46:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $03
    ret nz
    ldh a, [hPlayerFacing]
    inc a
    and a, $03
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    or a, a
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in SceneMermaidSong2_MoveSteps
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerFacing, wFollowerRecords, hPlayerStateFlags
; writes: hPlayerFacing, wFollowerRecords, wScriptParam0, hPlayerStateFlags
; points at: hPlayerX, wScriptSubStep, wScriptParam0
SceneMermaidSong2_MoveSteps_WritePlayerFacingAndFollowerRecordsEtc::
Jump_05F_6F6B:: ; address name
    ld a, [wScriptParam0]
    and a, $07
    jr nz, .check_script_param0
    ldh a, [hPlayerFacing]
    dec a
    and a, $03
    ldh [hPlayerFacing], a
    bit 0, a
    jr z, .set_follower_records
    inc a
    inc a
    and a, $03

.set_follower_records:
    ld [wFollowerRecords], a
    ld hl, wFollowerRecords + $1
    dec [hl]
    ld hl, hPlayerX
    inc [hl]

.check_script_param0:
    ld a, [wScriptParam0]
    and a, $03
    jr nz, .check_player_state_flags
    ld a, [wScriptParam0]
    srl a
    srl a
    ld c, a
    ld a, $1F
    sub a, c
    sla a
    ld hl, SceneMermaidSong2_MoveSteps_WritePlayerFacingAndFollowerRecordsEtc_Data
    add_a_to_hl
    ld a, [hl+]
    ld c, a
    ld a, [wFollowerRecords + $B]
    add a, c
    ld [wFollowerRecords + $B], a
    ld a, [wFollowerRecords + $6]
    sub a, c
    ld [wFollowerRecords + $6], a
    ld a, [hl]
    ld c, a
    ld a, [wFollowerRecords + $C]
    add a, c
    ld [wFollowerRecords + $C], a
    ld a, [wFollowerRecords + $7]
    sub a, c
    ld [wFollowerRecords + $7], a
    ld a, [wScriptParam0]
    srl a
    srl a
    cp a, $1F
    jr nz, .check_player_state_flags
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

.check_player_state_flags:
    ldh a, [hPlayerStateFlags]
    or a, $02
    ldh [hPlayerStateFlags], a
    ld hl, wScriptParam0
    inc [hl]
    ret

; entry 3 of the `rst $00` table in SceneMermaidSong2_MoveSteps
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: wScriptSubStep
SceneMermaidSong2_MoveSteps_AddStepDeltaToPointedByte::
Jump_05F_6FE7:: ; address name
    ld de, wFollowerRecords + $7
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte
    ld de, wFollowerRecords + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    farcall AddStepDeltaToPointedByte

; entry 0 of the `rst $00` table in SceneDancing_DanceSteps
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0
; points at: wScriptSubStep
SceneDancing_DanceSteps_WriteScriptParam0::
Jump_05F_7009:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in SceneMermaidSong2_MoveSteps
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerFacing
; writes: hPlayerFacing, wFollowerRecords
; points at: hPlayerX
SceneMermaidSong2_MoveSteps_ScriptStepMoveTwoObjectsByTable::
Jump_05F_701C:: ; address name
    ld a, [wScriptParam0]
    and a, $07
    jr nz, .call_script_step_move_two_objects_by_table
    ldh a, [hPlayerFacing]
    inc a
    and a, $03
    ldh [hPlayerFacing], a
    bit 0, a
    jr z, .set_follower_records
    inc a
    inc a
    and a, $03

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

; every fourth step moves wFollowerRecords + $6/wFollowerRecords + $7 and wFollowerRecords + $B/wFollowerRecords + $C in opposite directions by the table at HL; after 32 steps advances wScriptSubStep (E-0125)
; 1 call site from 1 routine (e.g. SceneMermaidSong2_MoveSteps_ScriptStepMoveTwoObjectsByTable)
; reads: wScriptParam0, wFollowerRecords
; writes: wFollowerRecords, wScriptParam0
; points at: wScriptSubStep, wScriptParam0
ScriptStepMoveTwoObjectsByTable::
Func_05F_7044:: ; address name
    ld a, [wScriptParam0]
    and a, $03
    jr nz, .done
    ld a, [wScriptParam0]
    srl a
    srl a
    sla a
    add_a_to_hl
    ld a, [hl+]
    ld c, a
    ld a, [wFollowerRecords + $6]
    add a, c
    ld [wFollowerRecords + $6], a
    ld a, [wFollowerRecords + $B]
    sub a, c
    ld [wFollowerRecords + $B], a
    ld a, [hl]
    ld c, a
    ld a, [wFollowerRecords + $7]
    add a, c
    ld [wFollowerRecords + $7], a
    ld a, [wFollowerRecords + $C]
    sub a, c
    ld [wFollowerRecords + $C], a
    ld a, [wScriptParam0]
    srl a
    srl a
    cp a, $1F
    jr nz, .done
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

.done:
    ld hl, wScriptParam0
    inc [hl]
    ret

; address loaded by SceneMermaidSong2_MoveSteps_WritePlayerFacingAndFollowerRecordsEtc, SceneMermaidSong2_MoveSteps_ScriptStepMoveTwoObjectsByTable
SceneMermaidSong2_MoveSteps_WritePlayerFacingAndFollowerRecordsEtc_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_05F_7092:: ; address name
    db $FE, $00, $FF, $00, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FE, $00, $FF, $00, $FE
    db $00, $FE, $00, $FF, $01, $FE, $01, $FF, $01, $FF, $02, $FF, $01, $00, $02, $00
    db $02, $00, $01, $00, $02, $01, $01, $01, $01, $01, $01, $02, $00, $01, $00, $02
    db $00, $02, $00, $01, $FF, $02, $FF, $01, $FF, $01, $FE, $01, $FF, $00, $FE, $00

; runs the routine for wScriptSubStep (jump table of eight) (E-0122)
; 2 call sites from 2 routines (e.g. SceneCheerYuna_ToRunScriptSubStep, SceneMonsterInspection_ToRunScriptSubStep)
; reads: wScriptSubStep
RunScriptSubStep::
Func_05F_70D2:: ; address name
    ld a, [wScriptSubStep]
    rst $00
    dw RunScriptSubStep_UpdateFollowersOnStep_Bank5F
    dw RunScriptSubStep_WriteFollowerRecordsAndPlayerFacingEtc
    dw RunScriptSubStep_AddStepDeltaToPointedByte
    dw RunScriptSubStep_WriteScriptParam0AndPlayerStateFlagsEtc
    dw RunScriptSubStep_WriteScriptTemp2AndScriptTemp3Etc
    dw RunScriptSubStep_WritePlayerStateFlagsAndFollowerRecordsEtc
    dw RunScriptSubStep_AddStepDeltaToPointedByte_Case06
    dw RunScriptSubStep_WriteFollowerRecordsAndPlayerFacingEtc_Case07

; entry 7 of the `rst $00` table in RunScriptSubStep
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerRecords, wScriptParam0, hPlayerX, hPlayerStateFlags
; writes: wFollowerRecords, hPlayerFacing, hPlayerStateFlags, wScriptParam0
; points at: wScriptParam0, wScriptStep
RunScriptSubStep_WriteFollowerRecordsAndPlayerFacingEtc_Case07::
Jump_05F_70E6:: ; address name
    ld a, $01
    ld [wFollowerRecords], a
    ld a, [wFollowerRecords + $1]
    inc a
    ld [wFollowerRecords + $1], a
    ld a, [wScriptParam0]
    and a, $01
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
    ld [wFollowerRecords + $A], a
    ld a, [wFollowerRecords + $B]
    dec a
    ld [wFollowerRecords + $B], a
    ldh a, [hPlayerX]
    ld c, a
    ld a, [wFollowerRecords + $B]
    cp a, c
    ret nz
    xor a, a
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ldh a, [hPlayerStateFlags]
    and a, $FB
    ldh [hPlayerStateFlags], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunScriptSubStep
; no direct call (reached through a table, a jump or a vector)
; reads: wObject5, wScriptParam0, hPlayerStateFlags
; writes: wStepPtrLo, wStepPtrHi, wObject5, wScriptParam0, hPlayerStateFlags, hPlayerFacing
; points at: wScriptSubStep
RunScriptSubStep_AddStepDeltaToPointedByte_Case06::
Jump_05F_7138:: ; address name
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
    cp a, $20
    ret nz
    xor a, a
    ld [wObject5], a
    ldh a, [hPlayerStateFlags]
    and a, $FD
    ldh [hPlayerStateFlags], a
    ld a, $02
    ldh [hPlayerFacing], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunScriptSubStep
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerStateFlags, wScriptParam0
; writes: hPlayerStateFlags, wFollowerRecords, wScriptParam0
; points at: wScriptSubStep
RunScriptSubStep_WritePlayerStateFlagsAndFollowerRecordsEtc::
Jump_05F_7172:: ; address name
    ldh a, [hPlayerStateFlags]
    or a, $02
    ldh [hPlayerStateFlags], a
    xor a, a
    ld [wFollowerRecords], a
    ld [wFollowerRecords + $5], a
    ld [wFollowerRecords + $A], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $3C
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in RunScriptSubStep
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptTemp2, wScriptTemp3, hPlayerY, wFrameCounterLo, hPlayerX
; writes: wScriptTemp2, wScriptTemp3, wScriptParam0
; points at: wScriptSubStep, wFollowerRecords, wScriptMsgSelect
RunScriptSubStep_WriteScriptTemp2AndScriptTemp3Etc::
Jump_05F_7195:: ; address name
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
    or a, h
    jr nz, .skip
    xor a, a
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
    or a, a
    jr nz, .skip2
    xor a, a
    ld [hl], a
    inc hl
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    ld c, a
    ldh a, [hPlayerY]
    add a, $10
    cp a, c
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
    and a, $03
    ld [hl], a
    inc hl
    ld a, [hl]
    inc a
    ld [hl], a
    ld c, a
    ldh a, [hPlayerX]
    add a, $20
    cp a, c
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
    cp a, c
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
    sub a, $20
    cp a, c
    jr nz, .read_player_x
    xor a, a
    ld [de], a

.read_player_x:
    ldh a, [hPlayerX]
    sub a, $20
    ld c, a
    ld a, [hl]
    sub a, c
    ld de, RunScriptSubStep_WriteScriptTemp2AndScriptTemp3Etc_Data
    add a, e
    ld e, a
    jr nc, .read_player_y
    inc d

.read_player_y:
    ld a, [de]
    ld c, a
    ldh a, [hPlayerY]
    sub a, c
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

; address loaded by RunScriptSubStep_WriteScriptTemp2AndScriptTemp3Etc
RunScriptSubStep_WriteScriptTemp2AndScriptTemp3Etc_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_05F_7240:: ; address name
    ds $11, $00
    db $01, $05, $08, $0A, $0C, $0D, $0E, $0E, $0F, $0F, $10, $10, $10, $11, $11, $11
    db $11, $10, $10, $10, $0F, $0F, $0E, $0E, $0D, $0C, $0A, $08, $05, $01
    ds $11, $00

; entry 3 of the `rst $00` table in RunScriptSubStep
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, hPlayerStateFlags
; writes: wScriptParam0, hPlayerStateFlags, wScriptMsgSelect, wScriptTemp0, wScriptTemp1, wScriptTemp2, wScriptTemp3
; points at: wScriptSubStep
RunScriptSubStep_WriteScriptParam0AndPlayerStateFlagsEtc::
Jump_05F_7280:: ; address name
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $78
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ldh a, [hPlayerStateFlags]
    or a, $04
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

; entry 2 of the `rst $00` table in RunScriptSubStep
; no direct call (reached through a table, a jump or a vector)
; reads: wObject5, wScriptParam0
; writes: wObject5, wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: wScriptSubStep
RunScriptSubStep_AddStepDeltaToPointedByte::
Jump_05F_72B3:: ; address name
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
    cp a, $20
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunScriptSubStep
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowerRecords, wScriptParam0, hPlayerX, hPlayerStateFlags
; writes: wFollowerRecords, hPlayerFacing, hTemp0, hPlayerStateFlags, wScriptParam0
; points at: wScriptParam0, wScriptSubStep
RunScriptSubStep_WriteFollowerRecordsAndPlayerFacingEtc::
Jump_05F_72E4:: ; address name
    ld a, $03
    ld [wFollowerRecords], a
    ld a, [wFollowerRecords + $1]
    dec a
    ld [wFollowerRecords + $1], a
    ld a, [wScriptParam0]
    and a, $01
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
    ld [wFollowerRecords + $A], a
    ld a, [wFollowerRecords + $B]
    inc a
    ld [wFollowerRecords + $B], a
    ldh a, [hPlayerX]
    ld c, a
    ld a, [wFollowerRecords + $B]
    sub a, c
    cp a, $20
    ret nz
    xor a, a
    ldh [hPlayerFacing], a
    ld [wFollowerRecords], a
    inc a
    ld [wFollowerRecords + $5], a
    ld a, $03
    ld [wFollowerRecords + $A], a
    ld a, $0B
    ldh [hTemp0], a
    farcall RunFieldCommandTemp0
    ldh a, [hPlayerStateFlags]
    or a, $02
    ldh [hPlayerStateFlags], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in RunScriptSubStep
; no direct call (reached through a table, a jump or a vector)
; reads: hPlayerStateFlags, hPlayerX, wScriptParam0
; writes: hPlayerStateFlags, wScriptParam0
; points at: wScriptSubStep
RunScriptSubStep_UpdateFollowersOnStep_Bank5F::
Jump_05F_7345:: ; address name
    ldh a, [hPlayerStateFlags]
    or a, $04
    ldh [hPlayerStateFlags], a
    ldh a, [hPlayerX]
    call UpdateFollowersOnStep_Bank5F
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $3C
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; runs the routine for wScriptSubStep (jump table of eighteen) (E-0124)
; 4 call sites from 4 routines (e.g. SceneDarckDefeated_ToRunSceneScriptSubStep, SceneShield2_ToRunSceneScriptSubStep, SceneMermaidKingdom_ToRunSceneScriptSubStep, SceneRivalDefeated_ToRunSceneScriptSubStep)
; reads: wScriptSubStep
RunSceneScriptSubStep::
Func_05F_7363:: ; address name
    ld a, [wScriptSubStep]
    rst $00
    dw RunSceneScriptSubStep_LoadSpriteGraphics7E5595ToTiles0
    dw RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F
    dw RunSceneScriptSubStep_CopyBytes
    dw RunSceneScriptSubStep_FullyHealParty
    dw RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F_Case04
    dw RunSceneScriptSubStep_AddStepDeltaToPointedByte
    dw RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F_Case06
    dw RunSceneScriptSubStep_CycleSpriteFloatYDown
    dw RunSceneScriptSubStep_CycleSpriteFloatYDown_Case08
    dw RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F_Case09
    dw RunSceneScriptSubStep_NextTableByte
    dw RunSceneScriptSubStep_CycleSpriteFloatYDown_Case0B
    dw RunSceneScriptSubStep_CycleSpriteFloatYDown_Case0C
    dw RunSceneScriptSubStep_CycleSpriteFloatYDown_Case0D
    dw RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F_Case0E
    dw RunSceneScriptSubStep_AddStepDeltaToPointedByte_Case0F
    dw RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F_Case09
    dw RunSceneScriptSubStep_AdvanceScriptStep

; entry 17 of the `rst $00` table in RunSceneScriptSubStep
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptStep
RunSceneScriptSubStep_AdvanceScriptStep::
Jump_05F_738B:: ; address name
    ld hl, wScriptStep
    inc [hl]
    ret

; starts message 6 and advances wScriptSubStep when wTextYesNoResult is 0, otherwise message 7 and steps wScriptSubStep back (E-0126)
; no direct call (reached through a table, a jump or a vector)
; reads: wTextYesNoResult
; points at: wScriptSubStep
StartChoiceMessageByTextYesNoResult:: ; heuristic: follows a terminator; C0
Func_05F_7390:: ; address name
    ld a, [wTextYesNoResult]
    or a, a
    jr nz, .skip
    ld a, $06
    ld hl, wScriptSubStep
    inc [hl]
    jr .call_start_message_from_table7787

.skip:
    ld a, $07
    ld hl, wScriptSubStep
    dec [hl]

.call_start_message_from_table7787:
    call StartMessageFromTable7787
    ret

; starts message 5 from Data_05F_7787 and advances wScriptSubStep (E-0126)
; no direct call (reached through a table, a jump or a vector)
; points at: wScriptSubStep
StartMessage5AndAdvanceScriptSubStep:: ; heuristic: follows a terminator; C0
Func_05F_73A8:: ; address name
    ld a, $05
    call StartMessageFromTable7787
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 15 of the `rst $00` table in RunSceneScriptSubStep
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wSpriteSlots, wScriptTemp4
; writes: wStepPtrLo, wStepPtrHi, wSpriteSlots, wScriptParam0, hTemp0, wPartyCount
; points at: wScriptSubStep
RunSceneScriptSubStep_AddStepDeltaToPointedByte_Case0F::
Jump_05F_73B2:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, .set_step_ptr_lo
    ld a, $65
    call QueueSoundEffect

.set_step_ptr_lo:
    ld de, wSpriteSlots + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    call AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    and a, $01
    jr nz, .check_script_param0
    ld hl, wSpriteSlots + $B
    inc [hl]

.check_script_param0:
    ld a, [wScriptParam0]
    and a, $01
    jr nz, .check_script_param02
    ld a, [wSpriteSlots + $7]
    inc a
    and a, $03
    ld [wSpriteSlots + $7], a

.check_script_param02:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
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
    ld b, $7D
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $49
    ld [wSpriteSlots + $2], a
    xor a, a
    ld [wSpriteSlots + $7], a
    ld a, $04
    call StartMessageFromTable7787
    ld a, [wScriptTemp4]
    ld [wPartyCount], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 14 of the `rst $00` table in RunSceneScriptSubStep
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0
; points at: wScriptSubStep
RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F_Case0E::
Jump_05F_742F:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank5F
    ret nc
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 13 of the `rst $00` table in RunSceneScriptSubStep
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: hTemp0, wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: wScriptSubStep
RunSceneScriptSubStep_CycleSpriteFloatYDown_Case0D::
Jump_05F_743D:: ; address name
    farcall CycleSpriteFloatYDown
    ld a, $01
    ldh [hTemp0], a
    farcall DrawAnimatedMetaSprite1B
    ld de, wSpriteSlots + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    call AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    ld a, $03
    call StartMessageFromTable7787
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 12 of the `rst $00` table in RunSceneScriptSubStep
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, wScriptParam0
; writes: hTemp0, wScriptParam1, wScriptParam0, wObject5
; points at: wScriptSubStep
RunSceneScriptSubStep_CycleSpriteFloatYDown_Case0C::
Jump_05F_746F:: ; address name
    farcall CycleSpriteFloatYDown
    ld a, $01
    ldh [hTemp0], a
    farcall DrawAnimatedMetaSprite1B
    ld a, [wScriptParam1]
    add a, $01
    ld [wScriptParam1], a
    sra a
    sra a
    sra a
    sra a
    ld c, a
    ld a, [wScriptParam0]
    add a, c
    ld [wScriptParam0], a
    cp a, $18
    jr c, .set_object5_to_80
    xor a, a
    ld [wScriptParam0], a
    xor a, a
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
    cp a, $30
    ret c
    xor a, a
    ld [wObject5], a
    ld a, $30
    ld [wObject5 + SCRIPTOBJ_Y], a
    xor a, a
    ld [wScriptParam0], a
    ld [wScriptParam1], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 11 of the `rst $00` table in RunSceneScriptSubStep
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: hTemp0, wStepPtrLo, wStepPtrHi, wScriptParam0, wScriptParam1
; points at: wScriptSubStep
RunSceneScriptSubStep_CycleSpriteFloatYDown_Case0B::
Jump_05F_74CD:: ; address name
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
    cp a, $20
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld [wScriptParam1], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 10 of the `rst $00` table in RunSceneScriptSubStep
; no direct call (reached through a table, a jump or a vector)
; reads: wRandomLo, wScriptParam0
; writes: wObject5, wScriptParam0
; points at: wScriptSubStep
RunSceneScriptSubStep_NextTableByte::
Jump_05F_750C:: ; address name
    call NextTableByte
    ld a, [wRandomLo]
    and a, $03
    jr z, RunSceneScriptSubStep_NextTableByte
    dec a
    dec a
    add a, $40
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $B4
    ret nz
    ld a, $40
    ld [wObject5 + SCRIPTOBJ_X], a
    ld a, $72
    call QueueSoundEffect
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 9 of the `rst $00` table in RunSceneScriptSubStep
; no direct call (reached through a table, a jump or a vector)
; writes: wScriptParam0, wScriptSubStep
; points at: wScriptSubStep
RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F_Case09::
Jump_05F_753A:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank5F
    ret nc
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ld de, $00D1
    call TestFlagBit
    ret nc
    ld a, $11
    ld [wScriptSubStep], a
    ret

; entry 8 of the `rst $00` table in RunSceneScriptSubStep
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: hTemp0, wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: wScriptSubStep
RunSceneScriptSubStep_CycleSpriteFloatYDown_Case08::
Jump_05F_7554:: ; address name
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
    cp a, $20
    ret nz
    ld a, $02
    call StartMessageFromTable7787
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 7 of the `rst $00` table in RunSceneScriptSubStep
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wSpriteSlots
; writes: hTemp0, wStepPtrLo, wStepPtrHi, wScriptParam0, wSpriteSlots
; points at: wScriptSubStep
RunSceneScriptSubStep_CycleSpriteFloatYDown::
Jump_05F_7593:: ; address name
    farcall CycleSpriteFloatYDown
    ld a, $01
    ldh [hTemp0], a
    farcall DrawAnimatedMetaSprite1B
    ld de, wSpriteSlots + $C
    ld a, e
    ld [wStepPtrLo], a
    ld a, d
    ld [wStepPtrHi], a
    call AddStepDeltaToPointedByte
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    and a, $01
    jr nz, .check_script_param0
    ld a, [wSpriteSlots + $B]
    dec a
    ld [wSpriteSlots + $B], a

.check_script_param0:
    ld a, [wScriptParam0]
    cp a, $20
    ret nz
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunSceneScriptSubStep
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlots
; points at: wScriptSubStep
RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F_Case06::
Jump_05F_75D2:: ; address name
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank5F
    ret nc
    ld de, FieldSpriteGfx02
    ld b, $7D
    ld hl, vTiles0 + $500
    call DecompressToVRAM
    ld a, $02
    ld [wSpriteSlots + $2], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunSceneScriptSubStep
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wStepPtrLo, wStepPtrHi, wScriptParam0
; points at: wScriptSubStep
RunSceneScriptSubStep_AddStepDeltaToPointedByte::
Jump_05F_75EC:: ; address name
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
    cp a, $20
    ret nz
    ld a, $01
    call StartMessageFromTable7787
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in RunSceneScriptSubStep
; no direct call (reached through a table, a jump or a vector)
; reads: wPartyCount
; writes: wObject5, wScriptTemp4, wPartyCount
; points at: wScriptSubStep
RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F_Case04::
Jump_05F_7617:: ; address name
    xor a, a
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

; entry 3 of the `rst $00` table in RunSceneScriptSubStep
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0
; writes: wScriptParam0, hFieldDrawFlags, wOBJPaletteUploadRequest
; points at: wScriptSubStep
RunSceneScriptSubStep_FullyHealParty::
Jump_05F_7631:: ; address name
    ld a, [wScriptParam0]
    or a, a
    jr nz, .call_move_incapacitated_party_members_back
    inc a
    ld [wScriptParam0], a
    ld a, $0E
    ldh [hFieldDrawFlags], a
    farcall FullyHealParty
    ret

.call_move_incapacitated_party_members_back:
    farcall MoveIncapacitatedPartyMembersBack
    farcall MoveIncapacitatedPartyMembersBack
    call LoadRecordListNameTiles
    farcall LoadPlayerAndFollowerSpriteGraphics
    ld a, $7F
    ld [wOBJPaletteUploadRequest], a
    xor a, a
    ldh [hFieldDrawFlags], a
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunSceneScriptSubStep
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wIsCGB
; writes: wBGPaletteUploadRequest, wScriptParam0
; points at: wDMGPaletteBGP, wBGPaletteCopy, wBGPaletteBuffer, wScriptSubStep
RunSceneScriptSubStep_CopyBytes::
Jump_05F_766C:: ; address name
    ld a, [wScriptParam0]
    srl a
    srl a
    and a, $01
    jr z, .skip
    ld hl, wDMGPaletteBGP
    ld a, $D2
    ld [hl+], a
    ld a, $D2
    ld [hl+], a
    ld a, $E2
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, .check_script_param0
    ld hl, wBGPaletteCopy
    ld de, wBGPaletteBuffer
    ld bc, $0040
    call CopyBytes
    jr .set_bg_palette_upload_request_to_7F

.skip:
    ld hl, wDMGPaletteBGP
    ld a, $2D
    ld [hl+], a
    ld a, $2D
    ld [hl+], a
    ld a, $1D
    ld [hl], a
    ld a, [wIsCGB]
    or a, a
    jr z, .check_script_param0
    ld b, $40
    ld hl, wBGPaletteCopy
    ld de, wBGPaletteBuffer

.loop:
    ld a, [hl+]
    xor a, $FF
    ld [de], a
    inc de
    dec b
    jr nz, .loop

.set_bg_palette_upload_request_to_7F:
    ld a, $7F
    ld [wBGPaletteUploadRequest], a

.check_script_param0:
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $1E
    ret nz
    ld a, $00
    call StartMessageFromTable7787
    xor a, a
    ld [wScriptParam0], a
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunSceneScriptSubStep
; no direct call (reached through a table, a jump or a vector)
; reads: wIsCGB
; writes: hPlayerFacing, wSpriteSlots
; points at: wBGPaletteBuffer, wBGPaletteCopy, wScriptSubStep
RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F::
Jump_05F_76D6:: ; address name
    ld a, $03
    ldh [hPlayerFacing], a
    ld a, $01
    ld [wSpriteSlots + $7], a
    xor a, a
    call RunMessageBoxCarryWhenIdle_Bank5F
    ret nc
    ld a, [wIsCGB]
    or a, a
    jr z, .call_queue_sound_effect
    ld hl, wBGPaletteBuffer
    ld de, wBGPaletteCopy
    ld bc, $0040
    call CopyBytes

.call_queue_sound_effect:
    ld a, $7A
    call QueueSoundEffect
    ld hl, wScriptSubStep
    inc [hl]
    ret

; entry 0 of the `rst $00` table in RunSceneScriptSubStep
; no direct call (reached through a table, a jump or a vector)
; writes: hTemp0, wScriptMsgSelect, wObject5
; points at: wScriptSubStep
RunSceneScriptSubStep_LoadSpriteGraphics7E5595ToTiles0::
Jump_05F_7700:: ; address name
    ld a, $01
    ldh [hTemp0], a
    farcall LoadSpriteGraphics7E5595ToTiles0
    ld de, $0021
    call TestFlagBit
    jr c, .call_test_flag_bit
    ld a, $00
    ld [wScriptMsgSelect], a
    ld a, $03
    ldh [hTemp0], a
    jr .call_run_field_command_temp0

.call_test_flag_bit:
    ld de, $0022
    call TestFlagBit
    jr c, .call_test_flag_bit2
    ld a, $01
    ld [wScriptMsgSelect], a
    ld a, $08
    ldh [hTemp0], a
    jr .call_run_field_command_temp0

.call_test_flag_bit2:
    ld de, $0023
    call TestFlagBit
    jr c, .set_script_msg_select_to_03
    ld a, $02
    ld [wScriptMsgSelect], a
    ld a, $0A
    ldh [hTemp0], a
    jr .call_run_field_command_temp0

.set_script_msg_select_to_03:
    ld a, $03
    ld [wScriptMsgSelect], a
    ld a, $0F
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

; starts the message whose index and group are at Data_05F_7787 + 2 * A + 16 * wScriptMsgSelect (wMessageState = 0) (E-0124)
; 7 call sites from 7 routines (e.g. RunSceneScriptSubStep_AddStepDeltaToPointedByte_Case0F, RunSceneScriptSubStep_CycleSpriteFloatYDown_Case0D, RunSceneScriptSubStep_CycleSpriteFloatYDown_Case08, RunSceneScriptSubStep_AddStepDeltaToPointedByte, ...)
; reads: wScriptMsgSelect
; writes: wMessageIndex, wMessageGroup, wMessageState
StartMessageFromTable7787::
Func_05F_7761:: ; address name
    sla a
    ld de, StartMessageFromTable7787_Data
    add a, e
    ld e, a
    jr nc, .read_script_msg_select
    inc d

.read_script_msg_select:
    ld a, [wScriptMsgSelect]
    swap a
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
    ld a, l
    ld [wMessageIndex], a
    ld a, h
    ld [wMessageGroup], a
    xor a, a
    ld [wMessageState], a
    ret

; address loaded by StartMessageFromTable7787
StartMessageFromTable7787_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_05F_7787:: ; address name
    db $26, $01, $27, $01, $28, $01, $29, $01, $2A, $01, $00, $00, $00, $00, $00, $00
    db $A8, $02, $A9, $02, $AA, $02, $AB, $02, $AC, $02, $00, $00, $00, $00, $00, $00
    db $A8, $02, $E9, $02, $AA, $02, $AB, $02, $EC, $02, $00, $00, $00, $00, $00, $00
    db $34, $05, $35, $05, $36, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

; wStepPtrLo = A, RunMessageBox, then carry set when wMessageState = $FF (idle), else A = 0 and carry clear (E-0079)
; 5 call sites from 5 routines (e.g. RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F_Case0E, RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F_Case09, RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F_Case06, RunSceneScriptSubStep_RunMessageBoxCarryWhenIdle_Bank5F_Case04, ...)
; reads: wMessageState
; writes: wStepPtrLo
RunMessageBoxCarryWhenIdle_Bank5F::
Func_05F_77C7:: ; address name
    ld [wStepPtrLo], a
    call RunMessageBox
    ld a, [wMessageState]
    cp a, $FF
    jr z, .return_carry
    sub a, a
    ret

.return_carry:
    scf
    ret

; script commands 02 and 03 (and 05 through Func_05F_787C): wScriptParam0 low nibble is an object number (16-byte entries from wSpriteSlots), its high nibble a direction 0-3; sets bit 2 of the object's flag byte and moves the object's position by one unit in that direction
; 2 call sites from 2 routines (e.g. ScriptCommand03, ScriptCommand02)
; reads: wScriptParam0, wScriptStep, wScriptParam1
; writes: wScriptStep, wScriptParam1, wScriptCommandType, wScriptStartRequest
ScriptStepObject::
Func_05F_77D8:: ; address name
    ld c, $10
    ld a, [wScriptParam0]
    and a, $0F
    call Multiply8
    ld a, l
    add a, $7F
    ld l, a
    ld a, h
    adc a, $CB
    ld h, a
    push hl
    ld a, $0D
    add_a_to_hl
    ld a, [hl]
    or a, $04
    ld [hl], a
    dec hl
    dec hl
    ld a, [wScriptParam0]
    swap a
    and a, $0F
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
    and a, $0F
    ld [hl], a
    ld a, [wScriptStep]
    inc a
    cp a, $10
    jr z, .clear_script_step
    ld [wScriptStep], a
    ret

.clear_script_step:
    xor a, a
    ld [wScriptStep], a
    ld a, [wScriptParam1]
    dec a
    ld [wScriptParam1], a
    ret nz
    ld a, $06
    add_a_to_hl
    ld a, [hl]
    and a, $FB
    ld [hl], a
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; script command 04: wScriptParam0/1 is a 16-bit counter that falls by one each frame; at zero it clears wScriptCommandType and sets wScriptStartRequest = $80 so the next script byte is fetched (the opening's waits of 30, 60 and 90 frames showed the counter at 29, 59 and 89)
; 1 call site from 1 routine (e.g. ScriptCommand04)
; reads: wScriptParam0, wScriptParam1
; writes: wScriptParam0, wScriptParam1, wScriptCommandType, wScriptStartRequest
ScriptWaitFrames::
Func_05F_785C:: ; address name
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
    or a, a
    ret nz
    cp a, h
    ret nz
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; implements script command type 05; reached through ScriptCommand05 in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand05)
; reads: wFieldActionRequest, hPlayerStateFlags, wScriptParam1, wScriptParam0, wJoypadHeld
; writes: wJoypadHeld, wJoypadPressed, wScriptStartRequest, wScriptParam1
ScriptCommand05_Run::
Func_05F_787C:: ; address name
    xor a, a
    ld [wJoypadHeld], a
    ld [wJoypadPressed], a
    ld a, [wFieldActionRequest]
    bit 7, a
    ret nz
    ldh a, [hPlayerStateFlags]
    bit 0, a
    ret nz
    ld a, [wScriptParam1]
    or a, a
    jr nz, .set_script_param1
    ld a, $80
    ld [wScriptStartRequest], a
    ret

.set_script_param1:
    dec a
    ld [wScriptParam1], a
    ld a, [wScriptParam0]
    or a, a
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

; script command 06: wScriptParam0 picks the target (0 = the player's hPlayerFacing, 1-n = the first byte of the n-th 5-byte record at wFollowerRecords, bit 7 set = byte 7 of the 16-byte object entry numbered by the low bits); wScriptParam1 is stored there; then wScriptStartRequest = $80 so the next script byte is fetched (the opening used it with parameters 129/130 and 2/1)
; 1 call site from 1 routine (e.g. ScriptCommand06)
; reads: wScriptParam0, wScriptParam1
; writes: wScriptStartRequest
; points at: hPlayerFacing, wFollowerRecords
ScriptSetDirection::
Func_05F_78CE:: ; address name
    ld a, [wScriptParam0]
    bit 7, a
    jr nz, .call_multiply8
    or a, a
    jr nz, .skip
    ld hl, hPlayerFacing
    jr .read_script_param1

.skip:
    dec a
    ld c, a
    sla a
    sla a
    add a, c
    ld hl, wFollowerRecords
    add_a_to_hl
    jr .read_script_param1

.call_multiply8:
    and a, $7F
    ld c, $10
    call Multiply8
    ld a, l
    add a, $86
    ld l, a
    ld a, h
    adc a, $CB
    ld h, a

.read_script_param1:
    ld a, [wScriptParam1]
    ld [hl], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; script command 0C: for 32 frames adds the per-frame step from the table at Data_05F_7959 (indexed by wScriptParam0 / 2) to a Y coordinate chosen by wScriptParam1 (0 = hPlayerY, 1-n = the n-th 5-byte record from wFollowerRecords + $2, bit 7 = an object entry's byte at wSpriteSlots + $C + 16 * number), counting wScriptParam0 up; at $20 it ends the command
; 1 call site from 1 routine (e.g. ScriptCommand0C)
; reads: wScriptParam1, wScriptParam0
; writes: wScriptParam0, wScriptCommandType, wScriptStartRequest
; points at: hPlayerY
ScriptSlideObjectY::
Func_05F_7907:: ; address name
    ld a, [wScriptParam1]
    bit 7, a
    jr nz, .skip3
    or a, a
    jr nz, .skip
    ld de, hPlayerY
    jr .read_script_param0

.skip:
    dec a
    ld c, a
    sla a
    sla a
    add a, c
    ld de, wFollowerRecords + $2
    add a, e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    jr .read_script_param0

.skip3:
    and a, $7F
    swap a
    ld de, wSpriteSlots + $C
    add a, e
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
    add a, c
    ld [de], a
    ld a, [wScriptParam0]
    inc a
    ld [wScriptParam0], a
    cp a, $20
    ret nz
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ret

; address loaded by ScriptSlideObjectY
ScriptSlideObjectY_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_05F_7959:: ; address name
    db $FE, $FF, $FF, $00, $FF, $00, $FF, $00, $00, $01, $00, $01, $00, $01, $01, $02

; implements script command type 0A, a one-time treasure: wScriptParam0 = kind (0 chest, 1 vase, 2 barrel, 3 chest with a Magic Key), wScriptParam1 = item, wMessageIndex/Group = story flag. If the flag is set it shows group-0 message $A1 + 3 * kind (empty); otherwise it adds the item (or a key entry for kind 3) and sets the flag, showing $A0 + 3 * kind, or $A2 + 3 * kind when there is no room (E-0038, E-0269)
; 1 call site from 1 routine (e.g. ScriptCommand0A)
; reads: wScriptStep
RunOneTimeTreasure::
Func_05F_7969:: ; address name
    ld a, [wScriptStep]
    rst $00
    dw RunOneTimeTreasure_CopyItemNameToDE
    dw RunOneTimeTreasure_SetBit1OfPlayerAndObjectFlags
    dw RunOneTimeTreasure_ShowMessageHL
    dw RunOneTimeTreasure_QueueSoundEffect
    dw RunOneTimeTreasure_ApplyMapScreenFlagEvents

; entry 0 of the `rst $00` table in RunOneTimeTreasure
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam0, wScriptParam1, wMessageIndex, wMessageGroup, wInventory, wGameFlags836, hTemp0
; writes: wScriptParam0, wScriptParam1, wGameFlags836
; points at: wScriptStep, wScriptParam0, wInventory
RunOneTimeTreasure_CopyItemNameToDE::
Jump_05F_7977:: ; address name
    ld a, [wScriptParam0]
    cp a, $03
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
    add a, a
    add a, c
    add a, $A0
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
    xor a, a
    ld [wScriptParam1], a
    ret

.restore:
    pop af
    cp a, $03
    jr z, .call_generate_new_key_entry
    ld a, [wInventory + $17]
    cp a, $FF
    jr z, .skip
    cp a, $00
    jr nz, .loop

.skip:
    ld hl, wInventory

.skip2:
    ld a, [hl]
    or a, a
    jr z, .read_script_param1
    cp a, $FF
    jr z, .read_script_param1
    inc hl
    jr .skip2

.read_script_param1:
    ld a, [wScriptParam1]
    ld [hl], a
    ld a, [wGameFlags836]
    set 6, a
    ld [wGameFlags836], a

.read_message_index:
    ld a, [wMessageIndex]
    ld e, a
    ld a, [wMessageGroup]
    ld d, a
    call SetFlagBit
    xor a, a
    ld [wScriptParam1], a
    ret

.loop:
    ld a, [wScriptParam0]
    inc a
    inc a
    ld [wScriptParam0], a
    xor a, a
    ld [wScriptParam1], a
    ret

.call_generate_new_key_entry:
    farcall GenerateNewKeyEntry
    ldh a, [hTemp0]
    or a, a
    jr z, .loop
    jr .read_message_index

; entry 1 of the `rst $00` table in RunOneTimeTreasure
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, hPlayerY
; writes: wTextWindowState, wTextWindowStep, hSpriteWindowClipMode
; points at: wScriptStep
RunOneTimeTreasure_SetBit1OfPlayerAndObjectFlags::
Jump_05F_7A02:: ; address name
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
    cp a, $48
    jr c, .done
    ld a, $81
    ld [wTextWindowState], a
    ld a, $01
    ldh [hSpriteWindowClipMode], a

.done:
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunOneTimeTreasure
; no direct call (reached through a table, a jump or a vector)
; reads: wScriptParam1, wTextWindowState, wScriptParam0
; points at: wScriptStep
RunOneTimeTreasure_ShowMessageHL::
Jump_05F_7A42:: ; address name
    ld a, [wScriptParam1]
    bit 7, a
    jr nz, .read_script_param0
    ld a, [wTextWindowState]
    and a, $03
    ret nz

.read_script_param0:
    ld a, [wScriptParam0]
    ld l, a
    ld h, $00
    call ShowMessageHL
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunOneTimeTreasure
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags, wScriptParam1, hPlayerY
; writes: hSpriteWindowClipMode, wTextWindowState, wTextWindowStep
; points at: wScriptStep
RunOneTimeTreasure_QueueSoundEffect::
Jump_05F_7A5D:: ; address name
    ld a, [wTextFlags]
    bit 0, a
    ret nz
    ld a, [wScriptParam1]
    bit 6, a
    jr nz, .done
    ld a, $69
    call QueueSoundEffect
    xor a, a
    ldh [hSpriteWindowClipMode], a
    ld a, $02
    ld [wTextWindowState], a
    ld a, $00
    ld [wTextWindowStep], a
    ldh a, [hPlayerY]
    cp a, $48
    jr c, .done
    ld a, $82
    ld [wTextWindowState], a

.done:
    ld hl, wScriptStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in RunOneTimeTreasure
; no direct call (reached through a table, a jump or a vector)
; reads: wTextWindowState
; writes: wScriptCommandType, wScriptRunning, wModeState
RunOneTimeTreasure_ApplyMapScreenFlagEvents::
Jump_05F_7A8C:: ; address name
    ld a, [wTextWindowState]
    and a, $03
    ret nz
    farcall ApplyMapScreenFlagEvents
    farcall DrawFullScreenBufferAtScroll
    farcall ClearBit1OfPlayerAndObjectFlags
    xor a, a
    ld [wScriptCommandType], a
    xor a, a
    ld [wScriptRunning], a
    ld a, $00
    ld [wModeState], a
    ret

; implements script command type 0E; reached through ScriptCommand0E in bank $10 (E-0038)
; 1 call site from 1 routine (e.g. ScriptCommand0E)
; reads: wScriptStep, wScriptParam0
; writes: hTemp0, wScriptCommandType, wScriptStartRequest
; points at: wScriptStep
ScriptCommand0E_Run::
Func_05F_7AB2:: ; address name
    ld a, [wScriptStep]
    or a, a
    jr nz, .clear_script_command_type
    ld a, [wScriptParam0]
    ldh [hTemp0], a
    farcall StartScriptedEncounterTemp0
    ld hl, wScriptStep
    inc [hl]
    ret

.clear_script_command_type:
    xor a, a
    ld [wScriptCommandType], a
    ld a, $80
    ld [wScriptStartRequest], a
    ld a, [wScriptParam0]
    rst $00
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

; entry 30 of the `rst $00` table in ScriptCommand0E_Run
; no direct call (reached through a table, a jump or a vector)
; writes: wSpriteSlotCount
ScriptCommand0E_Run_SetSpriteSlotCount::
Jump_05F_7B3B:: ; address name
    xor a, a
    ld [wSpriteSlotCount], a
    ret

; entry 0 of the `rst $00` table in ScriptCommand0E_Run
; no direct call (reached through a table, a jump or a vector)
ScriptCommand0E_Run_Return::
Jump_05F_7B40:: ; address name
    ret
    ds $4BF, $00
