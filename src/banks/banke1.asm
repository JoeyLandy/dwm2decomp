SECTION "Bank E1", ROMX[$4000], BANK[$E1]
    db $E1

; address loaded by GameMode5_Update_LoadScreens_Screen0_DecompressToVRAM
; LZSS-compressed asset: 213 bytes expand to 304 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Tiles2Gfx_E1_4001:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0E1_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $384001, $D5

; address loaded by GameMode5_Update_LoadScreens_Screen0_DecompressToVRAM
; LZSS-compressed asset: 37 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenTileBufferGfx_E1_40D6:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0E1_40D6:: ; address name
    db $68, $01, $13, $13, $A0, $FF, $4D, $13, $41, $0F, $2E, $01, $02, $03, $04, $05
    db $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F, $10, $11, $12, $13, $41, $0F
    db $4D, $13, $12, $1F, $42

; address loaded by GameMode5_Update_LoadScreens_Screen0_DecompressToVRAM
; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenAttrBufferGfx_E1_40FB:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0E1_40FB:: ; address name
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; address loaded by GameMode5_Update_LoadScreens_Screen0_DecompressToVRAM
BGPaletteBufferData_E1_410E:: ; heuristic: argument of a bank-switching copy helper; C0
Data_0E1_410E:: ; address name
    db $B5, $56, $FF, $7F, $D7, $56, $00, $00

; address loaded by GameMode5_Update_LoadScreens_Screen1_DecompressToVRAM
; LZSS-compressed asset: 1169 bytes expand to 1600 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Tiles2Gfx_E1_4116:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0E1_4116:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $384116, $491

; address loaded by GameMode5_Update_LoadScreens_Screen1_DecompressToVRAM
; LZSS-compressed asset: 85 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenTileBufferGfx_E1_45A7:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0E1_45A7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $3845A7, $55

; address loaded by GameMode5_Update_LoadScreens_Screen1_DecompressToVRAM
; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenAttrBufferGfx_E1_45FC:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0E1_45FC:: ; address name
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; address loaded by GameMode5_Update_LoadScreens_Screen1_DecompressToVRAM
BGPaletteBufferData_E1_460F:: ; heuristic: argument of a bank-switching copy helper; C0
Data_0E1_460F:: ; address name
    db $60, $31, $B5, $56, $E8, $62, $00, $00

; address loaded by GameMode5_Update_LoadScreens_Screen2_DecompressToVRAM
; LZSS-compressed asset: 815 bytes expand to 1552 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Tiles2Gfx_E1_4617:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0E1_4617:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $384617, $32F

; address loaded by GameMode5_Update_LoadScreens_Screen2_DecompressToVRAM
; LZSS-compressed asset: 120 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenTileBufferGfx_E1_4946:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0E1_4946:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $384946, $78

; address loaded by GameMode5_Update_LoadScreens_Screen2_DecompressToVRAM
; LZSS-compressed asset: 20 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenAttrBufferGfx_E1_49BE:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0E1_49BE:: ; address name
    db $68, $01, $00, $08, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $08, $1F, $34

; address loaded by GameMode5_Update_LoadScreens_Screen2_DecompressToVRAM
BGPaletteBufferData_E1_49D2:: ; heuristic: argument of a bank-switching copy helper; C0
Data_0E1_49D2:: ; address name
    db $0F, $3E, $BF, $73, $D7, $56, $00, $00

; address loaded by RunGameMode5Case00SubStates_DecompressToVRAM_Case06, GameMode5_Update_LoadScreens_ScreenWithMusic_DecompressToVRAM
; LZSS-compressed asset: 1165 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Tiles1Gfx_E1_49DA:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0E1_49DA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $3849DA, $48D

; address loaded by RunGameMode5Case00SubStates_DecompressToVRAM_Case06, GameMode5_Update_LoadScreens_ScreenWithMusic_DecompressToVRAM
; LZSS-compressed asset: 1438 bytes expand to 2048 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Tiles2Gfx_E1_4E67:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0E1_4E67:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $384E67, $59E

; address loaded by RunGameMode5Case00SubStates_DecompressToVRAM_Case04
; LZSS-compressed asset: 887 bytes expand to 1152 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Tiles2Gfx_E1_5405:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0E1_5405:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $385405, $377

; address loaded by GameMode5_Update_LoadScreens_ScreenWithMusic_DecompressToVRAM
; LZSS-compressed asset: 175 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Tiles0Gfx_E1_577C:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0E1_577C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $38577C, $AF

; address loaded by GameMode5_Update_LoadScreens_ScreenWithMusic_DecompressToVRAM
; LZSS-compressed asset: 152 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenTileBufferGfx_E1_582B:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0E1_582B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $38582B, $98

; address loaded by GameMode5_Update_LoadScreens_ScreenWithMusic_DecompressToVRAM
; LZSS-compressed asset: 76 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenAttrBufferGfx_E1_58C3:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0E1_58C3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $3858C3, $4C

; address loaded by RunGameMode5Case00SubStates_DecompressToVRAM_Case04
; LZSS-compressed asset: 101 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenTileBufferGfx_E1_590F:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0E1_590F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $38590F, $65

; address loaded by RunGameMode5Case00SubStates_DecompressToVRAM_Case04
; LZSS-compressed asset: 19 bytes expand to 360 (tools/lzss_gfx.py, E-0016/E-0017; C1)
ScreenAttrBufferGfx_E1_5974:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0E1_5974:: ; address name
    db $68, $01, $01, $01, $A0, $FF, $4D, $01, $5F, $0F, $4D, $01, $BF, $0F, $4D, $01
    db $1F, $1F, $35

; address loaded by RunGameMode5Case00SubStates_DecompressToVRAM_Case06
; LZSS-compressed asset: 112 bytes expand to 1024 (tools/lzss_gfx.py, E-0016/E-0017; C1)
BGMap0Gfx_E1_5987:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0E1_5987:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $385987, $70

; address loaded by RunGameMode5Case00SubStates_DecompressToVRAM_Case06
; LZSS-compressed asset: 48 bytes expand to 1024 (tools/lzss_gfx.py, E-0016/E-0017; C1)
BGMap0Gfx_E1_59F7:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0E1_59F7:: ; address name
    db $00, $04, $00, $03, $00, $00, $0F, $4D, $00, $60, $0F, $4D, $00, $C0, $0F, $4D
    db $00, $20, $1F, $4D, $00, $80, $1F, $4D, $00, $E0, $1F, $4D, $00, $40, $2F, $4D
    db $00, $A0, $2F, $4D, $00, $00, $3F, $4D, $00, $60, $3F, $4D, $00, $A0, $3F, $2C

; address loaded by RunGameMode5Case00SubStates_DecompressToVRAM_Case06, GameMode5_Update_LoadScreens_ScreenWithMusic_DecompressToVRAM
BGPaletteBufferData_E1_5A27:: ; heuristic: argument of a bank-switching copy helper; C0
Data_0E1_5A27:: ; address name
    db $0F, $54, $FF, $7F, $1F, $13, $AA, $04, $0F, $54, $FF, $7F, $1F, $13, $D5, $09
    db $33, $05, $FF, $03, $BD, $21, $AA, $04, $33, $05, $FF, $7F, $1F, $13, $AA, $04
    db $33, $05, $FF, $7F, $BD, $21, $AA, $04, $36, $04, $FF, $7F, $1F, $13, $AA, $04
    db $36, $04, $FF, $7F, $1F, $13, $D5, $09, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F

; address loaded by RunGameMode5Case00SubStates_DecompressToVRAM_Case04
BGPaletteBufferData_E1_5A67:: ; heuristic: argument of a bank-switching copy helper; C0
Data_0E1_5A67:: ; address name
    db $0F, $54, $FF, $7F, $1F, $13, $AA, $04, $0F, $54, $FF, $7F, $1F, $13, $D5, $09
    db $33, $05, $FF, $03, $BD, $21, $AA, $04, $33, $05, $FF, $7F, $1F, $13, $AA, $04
    db $33, $05, $FF, $7F, $BD, $21, $AA, $04, $36, $04, $FF, $7F, $1F, $13, $AA, $04
    db $36, $04, $FF, $7F, $1F, $13, $D5, $09, $FF, $7F, $FF, $7F, $FF, $7F, $FF, $7F

; address loaded by GameMode5_Update_LoadScreens_ScreenWithMusic_DecompressToVRAM
OBJPaletteBufferData_E1_5AA7:: ; heuristic: argument of a bank-switching copy helper; C0
Data_0E1_5AA7:: ; address name
    db $20, $7C, $FF, $7F, $A8, $14, $00, $00, $20, $7C, $FF, $7F, $35, $04, $00, $00

; runs Func_0E1_5AC0 with DE = Data_0E1_5ABE (E-0122)
; 1 call site from 1 routine (e.g. DrawCGBMetaSpriteAt38_30)
RunE15AC0For5ABE::
Func_0E1_5AB7:: ; address name
    ld de, RunE15AC0For5ABE_Data
    call RunE15AC0For5ABE_WaitOamNextEntry
    ret

; address loaded by RunE15AC0For5ABE
RunE15AC0For5ABE_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_0E1_5ABE:: ; address name
    db $3C, $5D

; only called from RunE15AC0For5ABE (E-0047)
; 1 call site from 1 routine (e.g. RunE15AC0For5ABE)
; reads: hOamNextEntry, hSpriteScrollYLo, hSpriteScrollYHi, hSpriteOriginY, hSpriteOriginYHi, hSpriteScrollXLo, hSpriteScrollXHi, hSpriteOriginX, ...
; writes: hMetaSpriteYLo, hMetaSpriteYHi, hOamNextEntry
; points at: hMetaSpriteXLo
RunE15AC0For5ABE_WaitOamNextEntry::
Func_0E1_5AC0:: ; address name
    ldh a, [hOamNextEntry]
    cp a, $27
    ret nc
    ldh a, [hSpriteScrollYLo]
    ld c, a
    ldh a, [hSpriteScrollYHi]
    ld b, a
    ldh a, [hSpriteOriginY]
    add a, c
    ldh [hMetaSpriteYLo], a
    ldh a, [hSpriteOriginYHi]
    adc a, b
    ldh [hMetaSpriteYHi], a
    ldh a, [hSpriteScrollXLo]
    ld c, a
    ldh a, [hSpriteScrollXHi]
    ld b, a
    ld hl, hMetaSpriteXLo
    ldh a, [hSpriteOriginX]
    add a, c
    ld c, a
    ld [hl+], a
    ldh a, [hSpriteOriginXHi]
    adc a, b
    ld b, a
    ld [hl+], a
    ld a, c
    sub a, $08
    ld [hl+], a
    ld a, b
    sbc a, $00
    ld [hl], a
    ldh a, [hSpriteSetIndex]
    add a, a
    add a, e
    ld l, a
    ld a, $00
    adc a, d
    ld h, a
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ldh a, [hSpriteSubIndex]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, de
    deref_hl
    ldh a, [hOamNextEntry]
    add a, a
    add a, a
    ld e, a
    ld d, $C0
    ldh a, [hSpriteWindowClipMode]
    or a, a
    jp nz, .check_sprite_attr_xor
    ldh a, [hSpriteTileOffset]
    ld c, a
    ldh a, [hSpriteAttrXor]
    and a, $20
    jr nz, .loop2

.loop:
    ld a, [hl+]
    cp a, $80
    ret z
    ld b, a
    jr nc, .read_meta_sprite_y_lo
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc a, $00
    jr nz, .next
    ld a, b
    cp a, $A8
    jr c, .skip
    jr .next

.read_meta_sprite_y_lo:
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc a, $FF
    jr nz, .next
    ld a, b
    cp a, $A8
    jr c, .skip

.next:
    inc hl
    inc hl
    inc hl
    jr .loop

.skip:
    ld a, b
    ld [de], a
    inc e
    ld a, [hl+]
    ld b, a
    rlca
    jr c, .read_meta_sprite_x_lo
    ldh a, [hMetaSpriteXLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteXHi]
    adc a, $00
    jr nz, .next2
    ld a, b
    cp a, $B8
    jr c, .skip2
    jr .next2

.read_meta_sprite_x_lo:
    ldh a, [hMetaSpriteXLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteXHi]
    adc a, $FF
    jr nz, .next2
    ld a, b
    cp a, $B8
    jr c, .skip2

.next2:
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr .loop

.skip2:
    ld a, b
    ld [de], a
    inc e
    ldh a, [hSpriteTileOffset]
    ld c, a
    ld a, [hl+]
    add a, c
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp a, $28
    jr nz, .loop
    ret

.loop2:
    ld a, [hl+]
    cp a, $80
    ret z
    ld b, a
    jr nc, .read_meta_sprite_y_lo2
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc a, $00
    jr nz, .next3
    ld a, b
    cp a, $A8
    jr c, .skip3
    jr .next3

.read_meta_sprite_y_lo2:
    ldh a, [hMetaSpriteYLo]
    add a, b
    ld b, a
    ldh a, [hMetaSpriteYHi]
    adc a, $FF
    jr nz, .next3
    ld a, b
    cp a, $A8
    jr c, .skip3

.next3:
    inc hl
    inc hl
    inc hl
    jr .loop2

.skip3:
    ld a, b
    ld [de], a
    inc e
    ld a, [hl+]
    ld b, a
    rlca
    jr c, .read_meta_sprite_x_flip_lo
    ldh a, [hMetaSpriteXFlipLo]
    sub a, b
    ld b, a
    ldh a, [hMetaSpriteXFlipHi]
    sbc a, $00
    jr z, .skip4
    jr nz, .next4
    ld a, b
    cp a, $B8
    jr c, .skip4
    jr .next4

.read_meta_sprite_x_flip_lo:
    ldh a, [hMetaSpriteXFlipLo]
    sub a, b
    ld b, a
    ldh a, [hMetaSpriteXFlipHi]
    sbc a, $FF
    jr nz, .next4
    ld a, b
    cp a, $B8
    jr c, .skip4

.next4:
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr .loop2

.skip4:
    ld a, b
    ld [de], a
    inc e
    ldh a, [hSpriteTileOffset]
    ld c, a
    ld a, [hl+]
    add a, c
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp a, $28
    jr nz, .loop2
    ret

.check_sprite_attr_xor:
    ldh a, [hSpriteAttrXor]
    and a, $20
    jr nz, .loop5

.loop3:
    ld a, [hl+]
    cp a, $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, .read_meta_sprite_y_lo3
    dec b

.read_meta_sprite_y_lo3:
    ldh a, [hMetaSpriteYLo]
    add a, c
    ld c, a
    ldh a, [hMetaSpriteYHi]
    adc a, b
    jr nz, .next5
    ld a, c
    cp a, $B8
    jr nc, .next5
    ldh a, [hSpriteWindowClipMode]
    or a, a
    jr z, .skip6
    cp a, $01
    jr nz, .cp_02
    ld a, c
    cp a, $34
    jr c, .next5
    jr .skip6

.cp_02:
    cp a, $02
    jr nz, .skip5
    ld a, c
    cp a, $71
    jr c, .skip6
    jr .next5

.skip5:
    jr .skip6

.next5:
    inc hl
    inc hl
    inc hl
    jr .loop3

.skip6:
    ld a, c
    ld [de], a
    inc e
    ld a, [hl+]
    ld c, a
    ld b, $00
    rlca
    jr nc, .read_meta_sprite_x_lo2
    dec b

.read_meta_sprite_x_lo2:
    ldh a, [hMetaSpriteXLo]
    add a, c
    ld c, a
    ldh a, [hMetaSpriteXHi]
    adc a, b
    jr nz, .loop4
    ld a, c
    cp a, $B8
    jr c, .call_bg_tile_under_point_is_sprite_hide_tile

.loop4:
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr .loop3

.call_bg_tile_under_point_is_sprite_hide_tile:
    ld a, c
    ld [de], a
    call BGTileUnderPointIsSpriteHideTile_BankE1
    jr nc, .loop4
    inc e
    ldh a, [hSpriteTileOffset]
    ld b, a
    ld a, [hl+]
    add a, b
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp a, $28
    jr nz, .loop3
    ret

.loop5:
    ld a, [hl+]
    cp a, $80
    ret z
    ld c, a
    ld b, $00
    rlca
    jr nc, .read_meta_sprite_y_lo4
    dec b

.read_meta_sprite_y_lo4:
    ldh a, [hMetaSpriteYLo]
    add a, c
    ld c, a
    ldh a, [hMetaSpriteYHi]
    adc a, b
    jr nz, .next6
    ld a, c
    cp a, $B8
    jr nc, .next6
    ldh a, [hSpriteWindowClipMode]
    or a, a
    jr z, .skip8
    cp a, $01
    jr nz, .cp_022
    ld a, c
    cp a, $34
    jr c, .next6
    jr .skip8

.cp_022:
    cp a, $02
    jr nz, .skip7
    ld a, c
    cp a, $71
    jr c, .skip8
    jr .next6

.skip7:
    jr .skip8

.next6:
    inc hl
    inc hl
    inc hl
    jr .loop5

.skip8:
    ld a, c
    ld [de], a
    inc e
    ld a, [hl+]
    ld c, a
    ld b, $00
    rlca
    jr nc, .read_meta_sprite_x_flip_lo2
    dec b

.read_meta_sprite_x_flip_lo2:
    ldh a, [hMetaSpriteXFlipLo]
    sub a, c
    ld c, a
    ldh a, [hMetaSpriteXFlipHi]
    sbc a, b
    jr nz, .loop6
    ld a, c
    cp a, $B8
    jr c, .call_bg_tile_under_point_is_sprite_hide_tile2

.loop6:
    inc hl
    inc hl
    dec e
    xor a, a
    ld [de], a
    jr .loop5

.call_bg_tile_under_point_is_sprite_hide_tile2:
    ld a, c
    ld [de], a
    call BGTileUnderPointIsSpriteHideTile_BankE1
    jr nc, .loop6
    inc e
    ldh a, [hSpriteTileOffset]
    ld b, a
    ld a, [hl+]
    add a, b
    ld [de], a
    inc e
    ldh a, [hSpriteAttrXor]
    ld c, a
    ld a, [hl+]
    xor a, c
    ld [de], a
    inc e
    ldh a, [hOamNextEntry]
    inc a
    ldh [hOamNextEntry], a
    cp a, $28
    jr nz, .loop5
    ret

; DE = address of an X byte with its Y byte at DE - 1 (screen coordinates): HL = the $9800 BG map entry under (X + hScrollX - 4, Y + hScrollY - 12), rows wrapping inside the map; reads it after rSTAT bit 1 clears (interrupts off) and compares with hSpriteHideTile: Z set when equal, A = the tile; BC, HL kept (E-0065) (the same 54 bytes appear in 6 banks)
; 2 call sites from 1 routine (e.g. RunE15AC0For5ABE_WaitOamNextEntry)
; reads: hScrollY, hScrollX, hSpriteHideTile, rSTAT
BGTileUnderPointIsSpriteHideTile_BankE1::
Func_0E1_5D06:: ; address name
    push hl
    push bc
    ldh a, [hScrollY]
    ld b, a
    dec e
    ld a, [de]
    inc e
    add a, b
    sub a, $0C
    and a, $F8
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ldh a, [hScrollX]
    ld b, a
    ld a, [de]
    add a, b
    sub a, $04
    and a, $F8
    rrca
    rrca
    rrca
    add a, l
    ld l, a
    ld a, h
    and a, $03
    adc a, $98
    ld h, a
    ldh a, [hSpriteHideTile]
    ld b, a
    di

.loop:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop
    ld a, [hl]
    ei
    cp a, b
    pop bc
    pop hl
    ret

; E-0236 (C1: shape only; no reference found and the bytes occur nowhere else in the ROM; two words point at the two frames that follow, each laid out as the E-0147 meta-sprite frames: 4-byte sprites (Y offset, X offset, tile, attribute) ending with $80).
; record: frame
UnreferencedMetaSpriteSet_E1::
Data_0E1_5D3C:: ; address name
    dw UnreferencedMetaSpriteSet_E1_Frame0 ; id 0
    dw UnreferencedMetaSpriteSet_E1_Frame1 ; id 1

; E-0236 (C1: shape only; frame 0 of UnreferencedMetaSpriteSet_E1; ends with $80).
; record: sprite: Y offset, X offset, tile, attribute
UnreferencedMetaSpriteSet_E1_Frame0::
Data_0E1_5D40:: ; address name
    db $F0, $25, $0B, $01 ; entry 0
    db $08, $15, $05, $00 ; entry 1
    db $08, $08, $07, $00 ; entry 2
    db $10, $08, $09, $00 ; entry 3
    db $10, $10, $0A, $00 ; entry 4
    db $10, $01, $07, $00 ; entry 5
    db $18, $03, $07, $00 ; entry 6
    db $18, $FF, $08, $00 ; entry 7
    db $F8, $18, $0C, $00 ; entry 8
    db $F8, $28, $0D, $00 ; entry 9
    db $00, $1B, $0E, $00 ; entry 10
    db $00, $28, $0F, $00 ; entry 11
    db $80 ; end

; E-0236 (C1: shape only; frame 1 of UnreferencedMetaSpriteSet_E1; ends with $80).
; record: sprite: Y offset, X offset, tile, attribute
UnreferencedMetaSpriteSet_E1_Frame1::
Data_0E1_5D71:: ; address name
    db $F7, $1F, $0B, $01 ; entry 0
    db $F0, $20, $00, $00 ; entry 1
    db $F8, $18, $01, $00 ; entry 2
    db $F8, $20, $02, $00 ; entry 3
    db $F8, $28, $03, $00 ; entry 4
    db $00, $1B, $04, $00 ; entry 5
    db $08, $15, $05, $00 ; entry 6
    db $02, $28, $06, $00 ; entry 7
    db $08, $08, $07, $00 ; entry 8
    db $10, $08, $09, $00 ; entry 9
    db $10, $10, $0A, $00 ; entry 10
    db $10, $01, $07, $00 ; entry 11
    db $18, $03, $07, $00 ; entry 12
    db $18, $FF, $08, $00 ; entry 13
    db $80 ; end

; Super Game Boy border set 4: border tiles $00-$7F (4096 bytes, sent with packet set $10); LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed asset: 3046 bytes expand to 4096 into a zero-filled buffer (tools/lzss_gfx.py, E-0016/E-0017; C1)
SGBBorder4TilesA:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0E1_5DAA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $385DAA, $BE6

; Super Game Boy border set 4: border tiles $80-$FF (4096 bytes, packet set $11); LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed asset: 3410 bytes expand to 4096 into a zero-filled buffer (tools/lzss_gfx.py, E-0016/E-0017; C1)
SGBBorder4TilesB:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0E1_6990:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $386990, $D52

; Super Game Boy border set 4: border map and palettes ($880 bytes, packet set $0F); LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed asset: 1133 bytes expand to 2176 (tools/lzss_gfx.py, E-0016/E-0017; C1)
SGBBorder4MapAndPalettes:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_0E1_76E2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $3876E2, $475
    ds $4A9, $00
