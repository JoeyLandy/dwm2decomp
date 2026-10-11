SECTION "Bank 7A", ROMX[$4000], BANK[$7A]
    db $7A

; compressed 6 x 6 picture (36 tiles) of monster id $08D (MadPlant) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 318 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_MadPlant:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_4001:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E8001, $13E

; compressed 6 x 6 picture (36 tiles) of monster id $150 (MerTiger) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 487 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_MerTiger:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_413F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E813F, $1E7

; compressed 6 x 6 picture (36 tiles) of monster id $151 (AxeShark) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 504 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_AxeShark:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_4326:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E8326, $1F8

; compressed 6 x 6 picture (36 tiles) of monster id $152 (Octogon) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 490 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Octogon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_451E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E851E, $1EA

; compressed 6 x 6 picture (36 tiles) of monster id $153 (KingSquid) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 456 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_KingSquid:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_4708:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E8708, $1C8

; compressed 6 x 6 picture (36 tiles) of monster id $154 (Digong) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 400 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Digong:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_48D0:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E88D0, $190

; compressed 6 x 6 picture (36 tiles) of monster id $155 (WhaleMage) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 470 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_WhaleMage:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_4A60:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E8A60, $1D6

; compressed 6 x 6 picture (36 tiles) of monster id $156 (Aquadon) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 517 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Aquadon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_4C36:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E8C36, $205

; compressed 6 x 6 picture (36 tiles) of monster id $157 (Octoraid) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 535 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Octoraid:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_4E3B:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E8E3B, $217

; compressed 6 x 6 picture (36 tiles) of monster id $158 (Grakos) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 493 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Grakos:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_5052:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E9052, $1ED

; compressed 6 x 6 picture (36 tiles) of monster id $159 (Poseidon) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 538 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Poseidon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_523F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E923F, $21A

; compressed 6 x 6 picture (36 tiles) of monster id $15A (Pumpoise) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 278 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Pumpoise:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_5459:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E9459, $116

; compressed 6 x 6 picture (36 tiles) of monster id $15B (Starfish) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 240 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Starfish:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_556F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E956F, $F0

; compressed 6 x 6 picture (36 tiles) of monster id $15F (DracoLord) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 432 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_DracoLord:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_565F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E965F, $1B0

; compressed 6 x 6 picture (36 tiles) of monster id $160 (DracoLord) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 486 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_DracoLord_160:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_580F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E980F, $1E6

; compressed 6 x 6 picture (36 tiles) of monster id $161 (LordDraco) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 526 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_LordDraco:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_59F5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E99F5, $20E

; compressed 6 x 6 picture (36 tiles) of monster id $162 (Hargon) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 431 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Hargon:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_5C03:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E9C03, $1AF

; compressed 6 x 6 picture (36 tiles) of monster id $163 (Sidoh) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 536 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Sidoh:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_5DB2:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E9DB2, $218

; compressed 6 x 6 picture (36 tiles) of monster id $164 (Genosidoh) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 539 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Genosidoh:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_5FCA:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1E9FCA, $21B

; compressed 6 x 6 picture (36 tiles) of monster id $165 (Baramos) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 425 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Baramos:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_61E5:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1EA1E5, $1A9

; compressed 6 x 6 picture (36 tiles) of monster id $166 (Zoma) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 497 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Zoma:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_638E:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1EA38E, $1F1

; compressed 6 x 6 picture (36 tiles) of monster id $167 (AsuraZoma) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 470 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_AsuraZoma:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_657F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1EA57F, $1D6

; compressed 6 x 6 picture (36 tiles) of monster id $168 (Pizzaro) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 558 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Pizzaro:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_6755:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1EA755, $22E

; compressed 6 x 6 picture (36 tiles) of monster id $169 (PsychoPiz) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 519 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_PsychoPiz:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_6983:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1EA983, $207

; compressed 6 x 6 picture (36 tiles) of monster id $16A (Esterk) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 493 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Esterk:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_6B8A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1EAB8A, $1ED

; compressed 6 x 6 picture (36 tiles) of monster id $16B (Mirudraas) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 386 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Mirudraas:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_6D77:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1EAD77, $182

; compressed 6 x 6 picture (36 tiles) of monster id $16C (Mirudraas) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 561 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Mirudraas_16C:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_6EF9:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1EAEF9, $231

; compressed 6 x 6 picture (36 tiles) of monster id $16D (Mudou) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 498 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Mudou:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_712A:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1EB12A, $1F2

; compressed 6 x 6 picture (36 tiles) of monster id $16E (DeathMore) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 363 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_DeathMore:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_731C:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1EB31C, $16B

; compressed 6 x 6 picture (36 tiles) of monster id $16F (DeathMore) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 560 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_DeathMore_16F:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_7487:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1EB487, $230

; compressed 6 x 6 picture (36 tiles) of monster id $170 (DeathMore) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 425 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_DeathMore_170:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_76B7:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1EB6B7, $1A9

; compressed 6 x 6 picture (36 tiles) of monster id $171 (Darkdrium) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 431 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Darkdrium:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_7860:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1EB860, $1AF

; compressed 6 x 6 picture (36 tiles) of monster id $172 (Orgodemir) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 309 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Orgodemir:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_7A0F:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1EBA0F, $135

; compressed 6 x 6 picture (36 tiles) of monster id $173 (Orgodemir) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 564 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Orgodemir_173:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_7B44:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1EBB44, $234

; compressed 6 x 6 picture (36 tiles) of monster id $174 (Darck) (MonsterPictureTable / MonsterAttributeMapTable)
; LZSS-compressed asset: 480 bytes expand to 576 (tools/lzss_gfx.py, E-0016/E-0017; C1)
MonsterPic_Darck:: ; heuristic: stream in a run of back-to-back compressed streams; C0
Data_07A_7D78:: ; address name
    INCBIN "dwm2-cobi-us.gbc", $1EBD78, $1E0
    ds $A8, $00
