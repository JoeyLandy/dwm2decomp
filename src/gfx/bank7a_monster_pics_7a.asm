; ROM bank $7A: compressed monster pictures
; The annotated listing of this bank is build/listing/bank7a.asm.

SECTION "Bank 7A", ROMX[$4000], BANK[$7A]
    db $7a

; compressed 6 x 6 picture (36 tiles) of monster id $08D (MadPlant) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 318 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MadPlant::
    INCBIN "gfx/monster_pics/mad_plant.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $150 (MerTiger) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 487 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_MerTiger::
    INCBIN "gfx/monster_pics/mer_tiger.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $151 (AxeShark) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 504 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_AxeShark::
    INCBIN "gfx/monster_pics/axe_shark.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $152 (Octogon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 490 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Octogon::
    INCBIN "gfx/monster_pics/octogon.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $153 (KingSquid) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 456 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_KingSquid::
    INCBIN "gfx/monster_pics/king_squid.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $154 (Digong) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 400 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Digong::
    INCBIN "gfx/monster_pics/digong.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $155 (WhaleMage) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 470 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_WhaleMage::
    INCBIN "gfx/monster_pics/whale_mage.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $156 (Aquadon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 517 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Aquadon::
    INCBIN "gfx/monster_pics/aquadon.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $157 (Octoraid) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 535 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Octoraid::
    INCBIN "gfx/monster_pics/octoraid.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $158 (Grakos) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 493 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Grakos::
    INCBIN "gfx/monster_pics/grakos.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $159 (Poseidon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 538 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Poseidon::
    INCBIN "gfx/monster_pics/poseidon.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $15A (Pumpoise) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 278 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Pumpoise::
    INCBIN "gfx/monster_pics/pumpoise.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $15B (Starfish) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 240 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Starfish::
    INCBIN "gfx/monster_pics/starfish.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $15F (DracoLord) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 432 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_DracoLord::
    INCBIN "gfx/monster_pics/draco_lord.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $160 (DracoLord) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 486 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_DracoLord_160::
    INCBIN "gfx/monster_pics/draco_lord_160.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $161 (LordDraco) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 526 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_LordDraco::
    INCBIN "gfx/monster_pics/lord_draco.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $162 (Hargon) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 431 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Hargon::
    INCBIN "gfx/monster_pics/hargon.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $163 (Sidoh) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 536 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Sidoh::
    INCBIN "gfx/monster_pics/sidoh.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $164 (Genosidoh) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 539 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Genosidoh::
    INCBIN "gfx/monster_pics/genosidoh.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $165 (Baramos) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 425 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Baramos::
    INCBIN "gfx/monster_pics/baramos.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $166 (Zoma) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 497 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Zoma::
    INCBIN "gfx/monster_pics/zoma.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $167 (AsuraZoma) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 470 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_AsuraZoma::
    INCBIN "gfx/monster_pics/asura_zoma.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $168 (Pizzaro) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 558 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Pizzaro::
    INCBIN "gfx/monster_pics/pizzaro.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $169 (PsychoPiz) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 519 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_PsychoPiz::
    INCBIN "gfx/monster_pics/psycho_piz.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $16A (Esterk) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 493 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Esterk::
    INCBIN "gfx/monster_pics/esterk.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $16B (Mirudraas) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 386 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Mirudraas::
    INCBIN "gfx/monster_pics/mirudraas.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $16C (Mirudraas) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 561 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Mirudraas_16C::
    INCBIN "gfx/monster_pics/mirudraas_16_c.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $16D (Mudou) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 498 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Mudou::
    INCBIN "gfx/monster_pics/mudou.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $16E (DeathMore) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 363 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_DeathMore::
    INCBIN "gfx/monster_pics/death_more.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $16F (DeathMore) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 560 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_DeathMore_16F::
    INCBIN "gfx/monster_pics/death_more_16_f.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $170 (DeathMore) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 425 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_DeathMore_170::
    INCBIN "gfx/monster_pics/death_more_170.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $171 (Darkdrium) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 431 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Darkdrium::
    INCBIN "gfx/monster_pics/darkdrium.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $172 (Orgodemir) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 309 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Orgodemir::
    INCBIN "gfx/monster_pics/orgodemir.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $173 (Orgodemir) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 564 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Orgodemir_173::
    INCBIN "gfx/monster_pics/orgodemir_173.lz"

; compressed 6 x 6 picture (36 tiles) of monster id $174 (Darck) (MonsterPictureTable /
; MonsterAttributeMapTable)
; LZSS-compressed: 480 bytes that expand to 576 (E-0016, E-0017)
MonsterPic_Darck::
    INCBIN "gfx/monster_pics/darck.lz"
    ds $a8, $00
