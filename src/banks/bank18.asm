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
    INCBIN "dwm2-cobi-us.gbc", $06090B, $B6

; Super Game Boy border set 2: border tiles $00-$7F (4096 bytes, sent with packet set $10); LoadSGBBorderForSetA decompresses it into the cleared vTiles1 and sends it (SGBTransferCompressed)
; LZSS-compressed asset: 2990 bytes expand to 4096 into a zero-filled buffer (tools/lzss_gfx.py, E-0016/E-0017; C1)
SGBBorder2TilesA:: ; heuristic: stream decompressed by a call to DecompressTo*; C0
Data_018_49C1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $0609C1, $BAE

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
