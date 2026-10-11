SECTION "Bank 18", ROMX[$4000], BANK[$18]
    db $18

; Super Game Boy border set 1: border tiles $00-$7F (4096 bytes, sent with packet set $10); LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed asset: 2314 bytes expand to 4096 into a zero-filled buffer (tools/lzss_gfx.py, E-0016/E-0017; C1)
SGBBorder1TilesA:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_018_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $060001, $90A

; Super Game Boy border set 1: border tiles $80-$FF (4096 bytes, packet set $11); LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed asset: 182 bytes expand to 4096 into a zero-filled buffer (tools/lzss_gfx.py, E-0016/E-0017; C1)
SGBBorder1TilesB:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_018_490B:: ; address name
    db $00, $10, $01, $01, $FF, $FC, $FF, $01, $0F, $0B, $01, $00
    dw Data_018_4D0F
    db $01, $60
    dw Data_018_4D0F
    db $01, $C0
    dw Data_018_4D0F
    db $01, $20
    dw Data_018_4D1F
    db $01, $80
    dw Data_018_4D1F
    db $01, $E0
    dw Data_018_4D1F
    db $01, $40
    dw Data_018_4D2F
    db $01, $A0
    dw Data_018_4D2F
    db $01, $00
    dw Data_018_4D3F
    db $01, $60
    dw Data_018_4D3F
    db $01, $C0
    dw Data_018_4D3F
    db $01, $20
    dw Data_018_4D4F
    db $01, $80
    dw Data_018_4D4F
    db $01, $E0
    dw Data_018_4D4F
    db $01, $40
    dw Data_018_4D5F
    db $01, $A0
    dw Data_018_4D5F
    db $01, $00
    dw Data_018_4D6F
    db $01, $60
    dw Data_018_4D6F
    db $01, $C0
    dw Data_018_4D6F
    db $01, $20
    dw Data_018_4D7F
    db $01, $80
    dw Data_018_4D7F
    db $01, $E0
    dw Data_018_4D7F
    db $01, $40
    dw Data_018_4D8F
    db $01, $A0
    dw Data_018_4D8F
    db $01, $00
    dw Data_018_4D9F
    db $01, $60
    dw Data_018_4D9F
    db $01, $C0
    dw Data_018_4D9F
    db $01, $20
    dw Data_018_4DAF
    db $01, $80
    dw Data_018_4DAF
    db $01, $E0
    dw Data_018_4DAF
    db $01, $40
    dw Data_018_4DBF
    db $01, $A0
    dw Data_018_4DBF
    db $01, $00
    dw Data_018_4DCF
    db $01, $60
    dw Data_018_4DCF
    db $01, $C0
    dw Data_018_4DCF
    db $01, $20
    dw Data_018_4DDF
    db $01, $80
    dw Data_018_4DDF
    db $01, $E0
    dw Data_018_4DDF
    db $01, $40
    dw Data_018_4DEF
    db $01, $A0
    dw Data_018_4DEF
    db $01, $00
    dw Data_018_4DFF
    db $01, $60
    dw Data_018_4DFF
    db $01, $C0, $FF, $0D

; Super Game Boy border set 2: border tiles $00-$7F (4096 bytes, sent with packet set $10); LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed asset: 2990 bytes expand to 4096 into a zero-filled buffer (tools/lzss_gfx.py, E-0016/E-0017; C1)
SGBBorder2TilesA:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_018_49C1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0609C1, $34E

Data_018_4D0F:: ; heuristic: target of a monotone pointer table; C0
    db $F0, $23, $E3, $67, $E7, $A6, $A6, $14, $14, $E8, $07, $E9, $07, $F7, $01, $F9

Data_018_4D1F:: ; heuristic: target of a monotone pointer table; C0
    db $00, $FF, $E1, $FF, $F1, $FF, $FB, $7F, $F7, $07, $17, $07, $17, $01, $09, $00

Data_018_4D2F:: ; heuristic: target of a monotone pointer table; C0
    db $06, $E1, $E1, $F1, $F1, $BA, $BA, $34, $34, $C5, $F8, $25, $F8, $B1, $EC, $F0

Data_018_4D3F:: ; heuristic: target of a monotone pointer table; C0
    db $CE, $F0, $EE, $E8, $E6, $F1, $E0, $E4, $F2, $F8, $FB, $38, $3B, $2C, $2F, $CE

Data_018_4D4F:: ; heuristic: target of a monotone pointer table; C0
    db $CF, $6E, $2F, $66, $37, $60, $2F, $F2, $3B, $E3, $E2, $FF, $1F, $3F, $07, $9F

Data_018_4D5F:: ; heuristic: target of a monotone pointer table; C0
    db $85, $E7, $E7, $DF, $FF, $CF, $FB, $19, $09, $30, $FC, $FF, $FC, $FF, $FE, $FF

Data_018_4D6F:: ; heuristic: target of a monotone pointer table; C0
    db $FC, $7F, $F8, $5F, $FC, $CF, $F9, $6F, $19, $E6, $15, $ED, $FF, $FF, $87, $87

Data_018_4D7F:: ; heuristic: target of a monotone pointer table; C0
    db $01, $01, $20, $FF, $10, $19, $20, $01, $13, $FF, $79, $19, $9C, $11, $F0, $F0

Data_018_4D8F:: ; heuristic: target of a monotone pointer table; C0
    db $C0, $C0, $83, $83, $84, $87, $09, $0F, $09, $0F, $08, $0F, $09, $0F, $3F, $19

Data_018_4D9F:: ; heuristic: target of a monotone pointer table; C0
    db $4C, $36, $19, $9C, $11, $1F, $1F, $07, $07, $03, $03, $81, $81, $91, $81, $A0

Data_018_4DAF:: ; heuristic: target of a monotone pointer table; C0
    db $80, $8C, $80, $00, $00, $F8, $19, $D3, $41, $19, $35, $5F, $04, $BF, $19, $5F

Data_018_4DBF:: ; heuristic: target of a monotone pointer table; C0
    db $08, $80, $19, $07, $41, $EF, $FF, $EE, $FE, $19, $63, $54, $EE, $EE, $0F, $0F

Data_018_4DCF:: ; heuristic: target of a monotone pointer table; C0
    db $F9, $AF, $7B, $EF, $3B, $FF, $0B, $19, $75, $51, $1B, $FF, $F9, $FF, $00, $00

Data_018_4DDF:: ; heuristic: target of a monotone pointer table; C0
    db $7C, $7C, $8E, $FE, $82, $FE, $7C, $7C, $00, $00, $C0, $00, $0F, $19, $9E, $30

Data_018_4DEF:: ; heuristic: target of a monotone pointer table; C0
    db $19, $13, $59, $06, $06, $00, $00, $10, $10, $40, $40, $19, $96, $00, $1F, $1C

Data_018_4DFF:: ; heuristic: target of a monotone pointer table; C0
    INCBIN "dwm2-cobi-us.gbc", $060DFF, $770

; Super Game Boy border set 2: border tiles $80-$FF (4096 bytes, packet set $11); LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed asset: 2750 bytes expand to 4096 into a zero-filled buffer (tools/lzss_gfx.py, E-0016/E-0017; C1)
SGBBorder2TilesB:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_018_556F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $06156F, $ABE

; Super Game Boy border set 3: border tiles $00-$7F (4096 bytes, sent with packet set $10); LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed asset: 3015 bytes expand to 4096 into a zero-filled buffer (tools/lzss_gfx.py, E-0016/E-0017; C1)
SGBBorder3TilesA:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_018_602D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $06202D, $BC7

; Super Game Boy border set 3: border tiles $80-$FF (4096 bytes, packet set $11); LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed asset: 2729 bytes expand to 4096 into a zero-filled buffer (tools/lzss_gfx.py, E-0016/E-0017; C1)
SGBBorder3TilesB:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_018_6BF4:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $062BF4, $AA9
    ds $963, $00
