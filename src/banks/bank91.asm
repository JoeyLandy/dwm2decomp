SECTION "Bank 91", ROMX[$4000], BANK[$91]
    db $91

; compressed sprite graphics of monster id $15F (DracoLord) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 240 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_DracoLord:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_091_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $244001, $F0

; compressed sprite graphics of monster id $160 (DracoLord) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 246 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_DracoLord_160:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_091_40F1:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $2440F1, $F6

; compressed sprite graphics of monster id $161 (LordDraco) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 227 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_LordDraco:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_091_41E7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $2441E7, $E3

; compressed sprite graphics of monster id $162 (Hargon) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 237 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Hargon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_091_42CA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $2442CA, $ED

; compressed sprite graphics of monster id $163 (Sidoh) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 201 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Sidoh:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_091_43B7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $2443B7, $C9

; compressed sprite graphics of monster id $164 (Genosidoh) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 229 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Genosidoh:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_091_4480:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $244480, $E5

; compressed sprite graphics of monster id $165 (Baramos) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 221 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Baramos:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_091_4565:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $244565, $DD

; compressed sprite graphics of monster id $166 (Zoma) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 211 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Zoma:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_091_4642:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $244642, $D3

; compressed sprite graphics of monster id $167 (AsuraZoma) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 199 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_AsuraZoma:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_091_4715:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $244715, $C7

; compressed sprite graphics of monster id $168 (Pizzaro) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 214 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Pizzaro:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_091_47DC:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $2447DC, $D6

; compressed sprite graphics of monster id $169 (PsychoPiz) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 226 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_PsychoPiz:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_091_48B2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $2448B2, $E2

; compressed sprite graphics of monster id $16A (Esterk) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 239 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Esterk:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_091_4994:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $244994, $EF

; compressed sprite graphics of monster id $16B (Mirudraas) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 202 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Mirudraas:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_091_4A83:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $244A83, $CA

; compressed sprite graphics of monster id $16C (Mirudraas) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 214 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Mirudraas_16C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_091_4B4D:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $244B4D, $D6

; compressed sprite graphics of monster id $16D (Mudou) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 236 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Mudou:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_091_4C23:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $244C23, $EC

; compressed sprite graphics of monster id $16E (DeathMore) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 214 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_DeathMore:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_091_4D0F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $244D0F, $D6

; compressed sprite graphics of monster id $16F (DeathMore) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 248 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_DeathMore_16F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_091_4DE5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $244DE5, $F8

; compressed sprite graphics of monster id $170 (DeathMore) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 183 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_DeathMore_170:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_091_4EDD:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $244EDD, $B7

; compressed sprite graphics of monster id $171 (Darkdrium) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 255 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Darkdrium:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_091_4F94:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $244F94, $FF

; compressed sprite graphics of monster id $172 (Orgodemir) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 222 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Orgodemir:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_091_5093:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $245093, $DE

; compressed sprite graphics of monster id $173 (Orgodemir) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 230 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Orgodemir_173:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_091_5171:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $245171, $E6

; compressed sprite graphics of monster id $174 (Darck) (MonsterSpriteTable; the debug viewer decompresses it to vTiles0 + $200)
; LZSS-compressed asset: 247 bytes expand to 256 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterSprite_Darck:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_091_5257:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $245257, $F7

; LZSS-compressed asset: 665 bytes expand to 768 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_091_534E:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $24534E, $299

; LZSS-compressed asset: 624 bytes expand to 768 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_091_55E7:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $2455E7, $270

; LZSS-compressed asset: 593 bytes expand to 768 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_091_5857:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $245857, $251

; LZSS-compressed asset: 590 bytes expand to 752 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_091_5AA8:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $245AA8, $24E

; LZSS-compressed asset: 541 bytes expand to 672 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_091_5CF6:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $245CF6, $21D

; LZSS-compressed asset: 506 bytes expand to 544 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_091_5F13:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $245F13, $1FA

; LZSS-compressed asset: 52 bytes expand to 64 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_091_610D:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    db $40, $00, $02, $02, $FF, $F7, $01, $02, $0A, $01, $02, $FF, $F0, $40, $40, $F0
    db $70, $F8, $F8, $FC, $9C, $FE, $8C, $FE, $01, $03, $01, $1F, $1F, $3F, $3F, $7F
    db $1E, $7F, $00, $3F, $02, $FF, $F0, $84, $DE, $04, $CE, $00, $8C, $00, $84, $00
    db $80, $02, $A0, $F2

; LZSS-compressed asset: 641 bytes expand to 768 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_091_6141:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $246141, $281

; LZSS-compressed asset: 593 bytes expand to 720 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_091_63C2:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $2463C2, $251

; LZSS-compressed asset: 685 bytes expand to 768 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_091_6613:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $246613, $2AD

; LZSS-compressed asset: 644 bytes expand to 720 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_091_68C0:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $2468C0, $284

; LZSS-compressed asset: 156 bytes expand to 176 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_091_6B44:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $246B44, $9C

; LZSS-compressed asset: 74 bytes expand to 96 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_091_6BE0:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $246BE0, $4A

; LZSS-compressed asset: 637 bytes expand to 720 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_091_6C2A:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $246C2A, $27D

; LZSS-compressed asset: 679 bytes expand to 768 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_091_6EA7:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $246EA7, $2A7

; LZSS-compressed asset: 630 bytes expand to 768 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_091_714E:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $24714E, $276

; LZSS-compressed asset: 397 bytes expand to 544 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_091_73C4:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $2473C4, $18D

; LZSS-compressed asset: 658 bytes expand to 768 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_091_7551:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $247551, $292

; LZSS-compressed asset: 661 bytes expand to 768 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_091_77E3:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $2477E3, $295

; LZSS-compressed asset: 277 bytes expand to 368 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_091_7A78:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $247A78, $115

; LZSS-compressed asset: 409 bytes expand to 544 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_091_7B8D:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $247B8D, $199

; LZSS-compressed asset: 554 bytes expand to 768 (tools/lzss_gfx.py, E-0016/E-0017; C1)
Data_091_7D26:: ; heuristic: stream in a run of back-to-back compressed streams; C0
    INCBIN "dwm2-cobi-us.gbc", $247D26, $229
    ds $B1, $00
