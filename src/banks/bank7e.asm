SECTION "Bank 7E", ROMX[$4000], BANK[$7E]
    db $7E

; compressed sprite graphics number $50 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hFFC8 non-zero)
; LZSS-compressed asset: 214 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx50:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07E_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F8001, $D6

; compressed sprite graphics number $51 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hFFC8 non-zero)
; LZSS-compressed asset: 218 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx51:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07E_40D7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F80D7, $DA

; compressed sprite graphics number $52 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hFFC8 non-zero)
; LZSS-compressed asset: 203 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx52:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07E_41B1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F81B1, $CB

; compressed sprite graphics number $53 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hFFC8 non-zero)
; LZSS-compressed asset: 215 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx53:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07E_427C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F827C, $D7

; compressed sprite graphics number $54 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hFFC8 non-zero)
; LZSS-compressed asset: 371 bytes expand to 416 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx54:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07E_4353:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F8353, $173

; compressed sprite graphics number $55 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hFFC8 non-zero)
; LZSS-compressed asset: 195 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx55:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07E_44C6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F84C6, $C3

; compressed sprite graphics number $56 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hFFC8 non-zero)
; LZSS-compressed asset: 90 bytes expand to 128 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx56:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07E_4589:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F8589, $5A

; compressed sprite graphics number $57 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hFFC8 non-zero)
; LZSS-compressed asset: 182 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx57:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07E_45E3:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F85E3, $B6

; compressed sprite graphics number $58 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hFFC8 non-zero)
; LZSS-compressed asset: 63 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx58:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07E_4699:: ; address name
    db $40, $00, $01, $01, $FF, $F0, $03, $03, $0F, $0C, $17, $18, $1E, $11, $29, $3F
    db $3F, $26, $01, $FF, $F0, $C0, $C0, $B0, $70, $F8, $68, $38, $C8, $FC, $1C, $94
    db $7C, $2D, $33, $38, $3F, $17, $1F, $1A, $1F, $0F, $0F, $03, $03, $01, $FF, $F0
    db $BC, $E4, $FC, $FC, $C8, $F8, $78, $F8, $30, $F0, $C0, $C0, $01, $A0, $F0

; compressed sprite graphics number $59 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hFFC8 non-zero)
; LZSS-compressed asset: 39 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx59:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07E_46D8:: ; address name
    db $40, $00, $02, $01, $01, $1A, $1B, $24, $3F, $54, $7F, $70, $7F, $1F, $1F, $30
    db $3F, $3F, $2F, $1F, $18, $1F, $17, $1F, $1D, $26, $3F, $27, $3F, $1D, $1F, $0F
    db $0B, $1C, $1C, $02, $A0, $FF, $0D

; compressed sprite graphics number $5A of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hFFC8 non-zero)
; LZSS-compressed asset: 53 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx5A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07E_46FF:: ; address name
    db $40, $00, $00, $FF, $FF, $80, $FF, $D8, $A7, $F9, $86, $FF, $FE, $FF, $BF, $FF
    db $BF, $FF, $80, $C4, $BB, $CE, $B1, $FB, $84, $F8, $87, $CC, $B3, $C6, $B9, $FF
    db $80, $FF, $FF, $00, $00, $00, $DA, $A5, $DA, $A5, $D9, $A6, $FE, $81, $FD, $FE
    db $FA, $87, $00, $10, $0C

; compressed sprite graphics number $5B of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hFFC8 non-zero)
; LZSS-compressed asset: 63 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx5B:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07E_4734:: ; address name
    db $40, $00, $01, $01, $FF, $F0, $07, $07, $18, $1F, $2F, $3E, $5B, $7C, $B7, $EE
    db $DA, $BF, $01, $FF, $F0, $E0, $E0, $18, $F8, $F4, $7C, $DA, $3E, $ED, $77, $5B
    db $FD, $EF, $BE, $BA, $DF, $5E, $6F, $23, $3E, $1B, $1C, $07, $07, $01, $FF, $F0
    db $F7, $7D, $5D, $FB, $7A, $F6, $C4, $7C, $D8, $38, $E0, $E0, $01, $A0, $F0

; compressed sprite graphics number $5C of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hFFC8 non-zero)
; LZSS-compressed asset: 191 bytes expand to 224 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx5C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07E_4773:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F8773, $BF

; compressed sprite graphics number $5D of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hFFC8 non-zero)
; LZSS-compressed asset: 45 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx5D:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07E_4832:: ; address name
    db $40, $00, $02, $02, $FF, $FA, $01, $01, $00, $00, $1C, $1C, $6E, $72, $BE, $EA
    db $7A, $46, $5C, $6C, $B4, $FC, $48, $C8, $1A, $1B, $15, $1F, $6B, $6D, $56, $7A
    db $2C, $34, $58, $68, $70, $70, $00, $00, $80, $80, $02, $A0, $FA

; compressed sprite graphics number $5E of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hFFC8 non-zero)
; LZSS-compressed asset: 119 bytes expand to 128 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx5E:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07E_485F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F885F, $77

; compressed sprite graphics number $5F of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hFFC8 non-zero)
; address loaded by Func_0E0_5AD3_Case02_Case00
; LZSS-compressed asset: 231 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx5F:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_07E_48D6:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F88D6, $E7

; compressed sprite graphics number $60 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hFFC8 non-zero)
; LZSS-compressed asset: 282 bytes expand to 512 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx60:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07E_49BD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1F89BD, $11A

; compressed sprite graphics number $61 of FieldSpriteGraphicsTable (DecompressGraphicsTemp0ToTemp4 with hFFC8 non-zero)
; LZSS-compressed asset: 62 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
FieldSpriteGfx61:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07E_4AD7:: ; address name
    db $00, $01, $01, $43, $43, $74, $77, $49, $7F, $97, $FE, $A3, $FF, $60, $7F, $93
    db $FF, $97, $FF, $C2, $C2, $2E, $EE, $92, $FE, $E9, $7F, $C5, $FF, $16, $FE, $C9
    db $FF, $E9, $FF, $6F, $6D, $05, $06, $7A, $7F, $3B, $3F, $24, $3C, $64, $7C, $82
    db $FE, $FC, $FC, $01, $A0, $FF, $4D, $01, $8F, $0F, $4D, $01, $EF, $0C

; E-0143 (C1: the palettes FieldSpritePaletteIndex selects; DecompressGraphicsTemp0ToTemp4 copies one to wOBJPaletteBuffer + 8 * hFFC9).
; record: one CGB OBJ palette: 4 BGR555 colours
FieldSpritePalettes::
Data_07E_4B15:: ; heuristic: start of a structured table; C0
    dw $0000, $6BFF, $663F, $0800 ; id 0
Data_07E_4B1D:: ; heuristic: argument of a bank-switching copy helper; C0
    dw $0000, $6BFF, $001F, $0800 ; id 1
    dw $0000, $6BFF, $0553, $0800 ; id 2
Data_07E_4B2D:: ; heuristic: argument of a bank-switching copy helper; C0
    dw $0000, $6BFF, $7000, $0800 ; id 3
    dw $0000, $6BFF, $03E0, $0800 ; id 4
    dw $0000, $6BFF, $5AB4, $0800 ; id 5
Data_07E_4B45:: ; heuristic: argument of a bank-switching copy helper; C0
    dw $0000, $6BFF, $6017, $0800 ; id 6
Data_07E_4B4D:: ; heuristic: argument of a bank-switching copy helper; C0
    dw $0000, $6BFF, $027F, $0800 ; id 7
    dw $0000, $6BFF, $662C, $0800 ; id 8
    dw $0000, $6BFF, $031D, $0800 ; id 9
    dw $0000, $037F, $0340, $0800 ; id 10
    dw $0000, $7F1F, $027F, $0800 ; id 11
    dw $0000, $035F, $026E, $0800 ; id 12
    dw $0000, $767F, $3D58, $0800 ; id 13
    dw $0000, $3AFD, $0533, $0800 ; id 14
    dw $0000, $4F5D, $1415, $0000 ; id 15
    dw $0000, $5EFD, $39B2, $0000 ; id 16
    dw $0000, $6BFF, $6B2A, $0800 ; id 17
Data_07E_4BA5:: ; heuristic: argument of a bank-switching copy helper; C0
    dw $0000, $6BFF, $7DA0, $0000 ; id 18
Data_07E_4BAD:: ; heuristic: argument of a bank-switching copy helper; C0
    dw $0000, $6BFF, $2E0A, $0000 ; id 19
    dw $0000, $6BFF, $7EC5, $0800 ; id 20

; address loaded by LoadPlayerAndFollowerSpriteGraphics_Sub01, RunLinkScreenSubStateSubState_5B14_Case00, LoadSpriteGraphics7E5595ToTiles0, RunGameMode2State_Case04 and 1 more
Data_07E_4BBD:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $1F8BBD, $50

; address loaded by Func_0E0_5AD3_Case00_Case00
Data_07E_4C0D:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $1F8C0D, $58

; address loaded by Func_0E0_5AD3_Case03_Case00
Data_07E_4C65:: ; heuristic: argument of a bank-switching copy helper; C0
    INCBIN "dwm2-cobi-us.gbc", $1F8C65, $48

; address loaded by RunLinkScreenSubStateSubState_5B14_Case00
Data_07E_4CAD:: ; heuristic: argument of a bank-switching copy helper; C0
    db $00, $00, $FF, $7F, $1C, $02, $00, $00, $00, $00, $FF, $6B, $5F, $03, $00, $08
    db $00, $00, $FF, $6B, $5F, $03, $00, $08, $00, $00, $BF, $5F, $3D, $2A, $00, $00
    db $00, $00, $FF, $6B, $52, $66, $00, $00, $00, $00, $5D, $4F, $D3, $19, $00, $00
    db $00, $00, $7F, $02, $1F, $00, $00, $00, $00, $00, $FF, $6B, $7F, $02, $00, $00

; address loaded by RunLinkScreenSubStateSubState_5B14_Case00
; LZSS-compressed asset: 45 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_4CED:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    db $40, $00, $02, $02, $FF, $FA, $01, $01, $00, $00, $1C, $1C, $6E, $72, $BE, $EA
    db $7A, $46, $5C, $6C, $B4, $FC, $48, $C8, $1A, $1B, $15, $1F, $6B, $6D, $56, $7A
    db $2C, $34, $58, $68, $70, $70, $00, $00, $80, $80, $02, $A0, $FA

; LZSS-compressed asset: 53 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_4D1A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $40, $00, $00, $FF, $FF, $80, $FF, $D8, $A7, $F9, $86, $FF, $FE, $FF, $BF, $FF
    db $BF, $FF, $80, $C4, $BB, $CE, $B1, $FB, $84, $F8, $87, $CC, $B3, $C6, $B9, $FF
    db $80, $FF, $FF, $00, $00, $00, $DA, $A5, $DA, $A5, $D9, $A6, $FE, $81, $FD, $FE
    db $FA, $87, $00, $10, $0C

; LZSS-compressed asset: 59 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_4D4F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $40, $00, $01, $01, $FF, $F0, $0E, $00, $0F, $04, $1F, $06, $19, $0F, $1A, $0D
    db $1E, $05, $01, $FF, $F0, $7C, $00, $FC, $38, $CC, $F8, $2C, $D8, $5C, $B0, $18
    db $F0, $0C, $07, $0E, $03, $1F, $05, $3F, $08, $3C, $10, $38, $01, $FF, $F1, $38
    db $E0, $DC, $30, $9C, $F8, $FC, $60, $F0, $01, $A0, $F3

; LZSS-compressed asset: 66 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_4D8A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1F8D8A, $42

; LZSS-compressed asset: 58 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_4DCC:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $40, $00, $01, $01, $FF, $F6, $07, $00, $0F, $03, $7D, $06, $00, $00, $3C, $00
    db $7E, $18, $76, $2C, $E6, $3C, $FE, $58, $FC, $A0, $70, $C0, $FB, $3C, $DF, $60
    db $DE, $71, $BF, $69, $77, $3D, $79, $1F, $37, $0E, $0F, $00, $E0, $40, $60, $C0
    db $E0, $80, $C0, $00, $80, $01, $37, $01, $00, $00

; LZSS-compressed asset: 49 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_4E06:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $40, $00, $01, $01, $FF, $F4, $07, $00, $0F, $03, $1C, $07, $3B, $0C, $01, $FF
    db $F4, $C0, $00, $E0, $80, $70, $C0, $38, $E0, $34, $1B, $3A, $0D, $1C, $07, $0F
    db $03, $07, $01, $FF, $F3, $58, $B0, $38, $E0, $70, $C0, $E0, $80, $C0, $01, $A0
    db $F3

; LZSS-compressed asset: 66 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_4E37:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1F8E37, $42

; LZSS-compressed asset: 58 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_4E79:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $40, $00, $02, $02, $FF, $F0, $01, $00, $03, $00, $03, $01, $03, $01, $03, $00
    db $07, $00, $00, $00, $FC, $00, $FE, $78, $87, $FC, $23, $FE, $F3, $DE, $F3, $1E
    db $E3, $FE, $1F, $03, $3C, $0F, $71, $1F, $67, $3E, $7F, $18, $3C, $02, $FF, $F1
    db $07, $FC, $7E, $F8, $FC, $80, $C0, $02, $A0, $F5

; address loaded by RunGameMode2State_Case04, RunGameMode2State_Case01
; LZSS-compressed asset: 62 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_4EB3:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    db $40, $00, $02, $02, $FF, $F0, $03, $00, $07, $01, $0E, $03, $1F, $04, $1E, $09
    db $1E, $09, $78, $00, $D4, $38, $7C, $E8, $EA, $9C, $EE, $34, $BA, $CC, $74, $B8
    db $DC, $68, $1E, $09, $1C, $0B, $1C, $0B, $3D, $0B, $3A, $17, $3B, $16, $3F, $0C
    db $1E, $00, $DC, $B0, $F8, $60, $B0, $C0, $C0, $00, $80, $02, $A0, $F3

; LZSS-compressed asset: 49 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_4EF1:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $40, $00, $01, $01, $FF, $F4, $07, $00, $0F, $03, $1F, $04, $1C, $0B, $01, $FF
    db $F4, $E0, $00, $F0, $C0, $B8, $60, $58, $B0, $1D, $0A, $1C, $0B, $1F, $04, $0F
    db $03, $07, $01, $FF, $F3, $D8, $30, $D8, $30, $B8, $60, $F0, $C0, $E0, $01, $A0
    db $F3

; address loaded by Func_0E0_5AD3_Case00_Case00
; LZSS-compressed asset: 65 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_4F22:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F8F22, $41

; LZSS-compressed asset: 67 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_4F63:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1F8F63, $43

; LZSS-compressed asset: 66 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_4FA6:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1F8FA6, $42

; LZSS-compressed asset: 63 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_4FE8:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $40, $00, $01, $01, $FF, $F0, $07, $07, $1D, $1A, $37, $2F, $73, $5C, $E6, $B9
    db $AD, $F2, $01, $FF, $F0, $E0, $E0, $B8, $58, $EC, $F4, $7E, $8A, $EF, $15, $D5
    db $2F, $BB, $E4, $F7, $A8, $7E, $51, $37, $2F, $1D, $1A, $07, $07, $01, $FF, $F0
    db $A5, $5F, $47, $BD, $8E, $7A, $EC, $F4, $B8, $58, $E0, $E0, $01, $A0, $F0

; LZSS-compressed asset: 63 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_5027:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $40, $00, $01, $01, $FF, $F0, $07, $07, $18, $1F, $2F, $3E, $5B, $7C, $B7, $EE
    db $DA, $BF, $01, $FF, $F0, $E0, $E0, $18, $F8, $F4, $7C, $DA, $3E, $ED, $77, $5B
    db $FD, $EF, $BE, $BA, $DF, $5E, $6F, $23, $3E, $1B, $1C, $07, $07, $01, $FF, $F0
    db $F7, $7D, $5D, $FB, $7A, $F6, $C4, $7C, $D8, $38, $E0, $E0, $01, $A0, $F0

; LZSS-compressed asset: 67 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_5066:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1F9066, $43

; LZSS-compressed asset: 66 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_50A9:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1F90A9, $42

; LZSS-compressed asset: 61 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_50EB:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $40, $00, $02, $02, $FF, $F2, $1F, $1F, $17, $18, $0D, $0E, $0B, $0F, $05, $07
    db $02, $FF, $F2, $80, $80, $60, $E0, $B0, $50, $68, $98, $B8, $C8, $03, $03, $01
    db $01, $1C, $1C, $3E, $22, $7A, $4E, $47, $7F, $3B, $3A, $01, $01, $44, $FC, $E4
    db $FC, $E8, $F8, $9B, $FB, $55, $77, $33, $33, $80, $80, $80, $80

; LZSS-compressed asset: 128 bytes expand to 128 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_5128:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1F9128, $80

; LZSS-compressed asset: 221 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_51A8:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1F91A8, $DD

; LZSS-compressed asset: 55 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_5285:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $40, $00, $01, $00, $00, $1F, $1F, $3F, $20, $7F, $40, $01, $06, $01, $49, $7F
    db $40, $00, $00, $F0, $F0, $F8, $08, $FC, $04, $01, $16, $01, $24, $FC, $04, $01
    db $06, $00, $3F, $20, $1F, $13, $1C, $14, $18, $18, $01, $FE, $F0, $01, $16, $00
    db $F8, $08, $F0, $F0, $01, $A0, $F4

; address loaded by Func_0E0_5AD3_Case03_Case00
; LZSS-compressed asset: 61 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_52BC:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    db $40, $00, $01, $00, $00, $1F, $1F, $3F, $20, $7D, $43, $7F, $43, $7D, $43, $7F
    db $41, $7F, $40, $00, $00, $F0, $F0, $F8, $08, $7C, $84, $FC, $84, $7C, $84, $FC
    db $04, $FC, $04, $7D, $43, $7D, $43, $3F, $20, $1F, $13, $1C, $14, $18, $18, $01
    db $FE, $F0, $7C, $84, $7C, $84, $F8, $08, $F0, $F0, $01, $A0, $F4

; LZSS-compressed asset: 119 bytes expand to 128 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_52F9:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1F92F9, $77

; LZSS-compressed asset: 170 bytes expand to 192 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_5370:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1F9370, $AA

; LZSS-compressed asset: 68 bytes expand to 80 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_541A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1F941A, $44

; address loaded by LoadPlayerAndFollowerSpriteGraphics_Sub01
; LZSS-compressed asset: 181 bytes expand to 192 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_545E:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F945E, $B5

; LZSS-compressed asset: 130 bytes expand to 128 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_5513:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1F9513, $82

; address loaded by LoadSpriteGraphics7E5595ToTiles0
; LZSS-compressed asset: 171 bytes expand to 192 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_5595:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F9595, $AB

; LZSS-compressed asset: 131 bytes expand to 128 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_5640:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1F9640, $83

; LZSS-compressed asset: 67 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_56C3:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1F96C3, $43

; address loaded by RunLinkScreenSubStateSubState_5B14_Case00
; LZSS-compressed asset: 80 bytes expand to 96 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_5706:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F9706, $50

; LZSS-compressed asset: 282 bytes expand to 512 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_5756:: ; heuristic: stream decompressed while the game ran on the emulator; C0
    INCBIN "dwm2-cobi-us.gbc", $1F9756, $11A

; LZSS-compressed asset: 143 bytes expand to 512 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_5870:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1F9870, $8F

; address loaded by LoadAltObjectGraphicsIfPlayerStateFlagsBit3, Func_012_5DB6_Case03
; LZSS-compressed asset: 75 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_58FF:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F98FF, $4B

; address loaded by Func_012_5EE7_Case03
; LZSS-compressed asset: 74 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_594A:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F994A, $4A

; LZSS-compressed asset: 129 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_5994:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1F9994, $81

; LZSS-compressed asset: 133 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_5A15:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $1F9A15, $85

; address loaded by SpawnScriptSpriteInFrontOfPlayer
; LZSS-compressed asset: 92 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_5A9A:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F9A9A, $5C

; E-0164 (derived: 16 bytes copied into a palette buffer by CopyFromBank, CopyBytesDEToHL_Bank00 or LoadBGPaletteBufferFromBank)
; record: one CGB palette: 4 BGR555 colours
Palettes_7E_5AF6::
Data_07E_5AF6:: ; heuristic: argument of a bank-switching copy helper; C0
    dw $0000, $6BFF, $0279, $0000 ; id 0
    dw $7C00, $7C00, $7C00, $7C00 ; id 1
    db $00, $7C, $00, $7C, $00, $7C, $00, $7C

; address loaded by RunGameMode2State_Case01
; LZSS-compressed asset: 25 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_5B0E:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    db $00, $01, $01, $50, $50, $F8, $A8, $F8, $88, $F8, $A8, $D8, $D8, $01, $A0, $FF
    db $4D, $01, $69, $0F, $4D, $01, $C9, $0F, $23

; address loaded by RunGameMode2State_Case04
; LZSS-compressed asset: 31 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_5B27:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    db $00, $01, $01, $10, $10, $38, $28, $7C, $44, $FE, $82, $FE, $82, $7C, $44, $38
    db $28, $10, $10, $01, $A0, $FF, $4D, $01, $6F, $0F, $4D, $01, $CF, $0F, $1D

; address loaded by RunGameMode2State_Case04
; LZSS-compressed asset: 29 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_5B46:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    db $00, $01, $01, $D6, $D6, $FE, $AA, $FE, $82, $01, $04, $01, $BA, $EE, $AA, $EE
    db $EE, $01, $A0, $FF, $4D, $01, $6F, $0F, $4D, $01, $CF, $0F, $1D

; address loaded by DrawTitleSaveSummaryScreen
; LZSS-compressed asset: 85 bytes expand to 512 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_07E_5B63:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
    INCBIN "dwm2-cobi-us.gbc", $1F9B63, $55

; E-0164 (derived: 8 bytes copied into a palette buffer by CopyFromBank, CopyBytesDEToHL_Bank00 or LoadBGPaletteBufferFromBank)
; record: one CGB palette: 4 BGR555 colours
Palettes_7E_5BB8::
Data_07E_5BB8:: ; heuristic: argument of a bank-switching copy helper; C0
    dw $0000, $3D7D, $2011, $0000 ; id 0
    ds $2440, $00
