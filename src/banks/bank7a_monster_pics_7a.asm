; ROM bank $7A: compressed monster pictures
; The annotated listing of this bank is build/listing/bank7a.asm.

SECTION "Bank 7A", ROMX[$4000], BANK[$7A]
    db $7a

; compressed 6 x 6 picture (36 tiles) of monster id $08D (MadPlant) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 318 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MadPlant::
    INCBIN "dwm2-cobi-us.gbc", $1E8001, $13E

; compressed 6 x 6 picture (36 tiles) of monster id $150 (MerTiger) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 487 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MerTiger::
    INCBIN "dwm2-cobi-us.gbc", $1E813F, $1E7

; compressed 6 x 6 picture (36 tiles) of monster id $151 (AxeShark) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 504 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_AxeShark::
    INCBIN "dwm2-cobi-us.gbc", $1E8326, $1F8

; compressed 6 x 6 picture (36 tiles) of monster id $152 (Octogon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 490 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Octogon::
    INCBIN "dwm2-cobi-us.gbc", $1E851E, $1EA

; compressed 6 x 6 picture (36 tiles) of monster id $153 (KingSquid) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 456 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_KingSquid::
    INCBIN "dwm2-cobi-us.gbc", $1E8708, $1C8

; compressed 6 x 6 picture (36 tiles) of monster id $154 (Digong) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 400 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Digong::
    INCBIN "dwm2-cobi-us.gbc", $1E88D0, $190

; compressed 6 x 6 picture (36 tiles) of monster id $155 (WhaleMage) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 470 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_WhaleMage::
    INCBIN "dwm2-cobi-us.gbc", $1E8A60, $1D6

; compressed 6 x 6 picture (36 tiles) of monster id $156 (Aquadon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 517 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Aquadon::
    INCBIN "dwm2-cobi-us.gbc", $1E8C36, $205

; compressed 6 x 6 picture (36 tiles) of monster id $157 (Octoraid) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 535 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Octoraid::
    INCBIN "dwm2-cobi-us.gbc", $1E8E3B, $217

; compressed 6 x 6 picture (36 tiles) of monster id $158 (Grakos) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 493 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Grakos::
    INCBIN "dwm2-cobi-us.gbc", $1E9052, $1ED

; compressed 6 x 6 picture (36 tiles) of monster id $159 (Poseidon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 538 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Poseidon::
    INCBIN "dwm2-cobi-us.gbc", $1E923F, $21A

; compressed 6 x 6 picture (36 tiles) of monster id $15A (Pumpoise) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 278 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Pumpoise::
    INCBIN "dwm2-cobi-us.gbc", $1E9459, $116

; compressed 6 x 6 picture (36 tiles) of monster id $15B (Starfish) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 240 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Starfish::
    INCBIN "dwm2-cobi-us.gbc", $1E956F, $F0

; compressed 6 x 6 picture (36 tiles) of monster id $15F (DracoLord) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 432 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_DracoLord::
    INCBIN "dwm2-cobi-us.gbc", $1E965F, $1B0

; compressed 6 x 6 picture (36 tiles) of monster id $160 (DracoLord) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 486 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_DracoLord_160::
    INCBIN "dwm2-cobi-us.gbc", $1E980F, $1E6

; compressed 6 x 6 picture (36 tiles) of monster id $161 (LordDraco) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 526 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_LordDraco::
    INCBIN "dwm2-cobi-us.gbc", $1E99F5, $20E

; compressed 6 x 6 picture (36 tiles) of monster id $162 (Hargon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 431 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Hargon::
    INCBIN "dwm2-cobi-us.gbc", $1E9C03, $1AF

; compressed 6 x 6 picture (36 tiles) of monster id $163 (Sidoh) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 536 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Sidoh::
    INCBIN "dwm2-cobi-us.gbc", $1E9DB2, $218

; compressed 6 x 6 picture (36 tiles) of monster id $164 (Genosidoh) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 539 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Genosidoh::
    INCBIN "dwm2-cobi-us.gbc", $1E9FCA, $21B

; compressed 6 x 6 picture (36 tiles) of monster id $165 (Baramos) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 425 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Baramos::
    INCBIN "dwm2-cobi-us.gbc", $1EA1E5, $1A9

; compressed 6 x 6 picture (36 tiles) of monster id $166 (Zoma) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 497 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Zoma::
    INCBIN "dwm2-cobi-us.gbc", $1EA38E, $1F1

; compressed 6 x 6 picture (36 tiles) of monster id $167 (AsuraZoma) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 470 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_AsuraZoma::
    INCBIN "dwm2-cobi-us.gbc", $1EA57F, $1D6

; compressed 6 x 6 picture (36 tiles) of monster id $168 (Pizzaro) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 558 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Pizzaro::
    INCBIN "dwm2-cobi-us.gbc", $1EA755, $22E

; compressed 6 x 6 picture (36 tiles) of monster id $169 (PsychoPiz) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 519 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_PsychoPiz::
    INCBIN "dwm2-cobi-us.gbc", $1EA983, $207

; compressed 6 x 6 picture (36 tiles) of monster id $16A (Esterk) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 493 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Esterk::
    INCBIN "dwm2-cobi-us.gbc", $1EAB8A, $1ED

; compressed 6 x 6 picture (36 tiles) of monster id $16B (Mirudraas) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 386 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Mirudraas::
    INCBIN "dwm2-cobi-us.gbc", $1EAD77, $182

; compressed 6 x 6 picture (36 tiles) of monster id $16C (Mirudraas) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 561 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Mirudraas_16C::
    INCBIN "dwm2-cobi-us.gbc", $1EAEF9, $231

; compressed 6 x 6 picture (36 tiles) of monster id $16D (Mudou) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 498 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Mudou::
    INCBIN "dwm2-cobi-us.gbc", $1EB12A, $1F2

; compressed 6 x 6 picture (36 tiles) of monster id $16E (DeathMore) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 363 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_DeathMore::
    INCBIN "dwm2-cobi-us.gbc", $1EB31C, $16B

; compressed 6 x 6 picture (36 tiles) of monster id $16F (DeathMore) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 560 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_DeathMore_16F::
    INCBIN "dwm2-cobi-us.gbc", $1EB487, $230

; compressed 6 x 6 picture (36 tiles) of monster id $170 (DeathMore) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 425 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_DeathMore_170::
    INCBIN "dwm2-cobi-us.gbc", $1EB6B7, $1A9

; compressed 6 x 6 picture (36 tiles) of monster id $171 (Darkdrium) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 431 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Darkdrium::
    INCBIN "dwm2-cobi-us.gbc", $1EB860, $1AF

; compressed 6 x 6 picture (36 tiles) of monster id $172 (Orgodemir) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 309 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Orgodemir::
    INCBIN "dwm2-cobi-us.gbc", $1EBA0F, $135

; compressed 6 x 6 picture (36 tiles) of monster id $173 (Orgodemir) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 564 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Orgodemir_173::
    INCBIN "dwm2-cobi-us.gbc", $1EBB44, $234

; compressed 6 x 6 picture (36 tiles) of monster id $174 (Darck) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 480 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Darck::
    INCBIN "dwm2-cobi-us.gbc", $1EBD78, $1E0
    ds $a8, $00
