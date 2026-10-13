; ROM bank $A2: strings and monster loading
; The annotated listing of this bank is build/listing/banka2.asm.

SECTION "Bank A2", ROMX[$4000], BANK[$A2]
    db $a2

; HL = $4056 + 26 * (monster id - $250 + 1) + C; copies hTemp0 bytes from HL to DE (E-0121)
CopyMonsterTableBytesFrom4056::
    push de
    push bc
    ld a, [wMonsterId]
    ld c, a
    ld a, [wMonsterId + $1]
    ld b, a
    ld a, c
    sub $50
    ld c, a
    ld a, b
    sbc $02
    ld b, a
    inc bc
    ld a, $1a
    call Multiply8By16
    ld a, l
    add $56
    ld l, a
    ld a, h
    adc $40
    ld h, a
    pop bc
    ld b, $00
    add hl, bc
    ldh a, [hTemp0]
    ld b, a
    pop de
    call CopyBytesDEFromHL_BankA2
    ret

LoadMonsterRecordTo_Multiply8By16::
    push de
    ld a, [wMonsterId]
    ld c, a
    ld a, [wMonsterId + $1]
    ld b, a
    ld a, c
    sub $50
    ld c, a
    ld a, b
    sbc $02
    ld b, a
    inc bc
    ld a, $1a
    call Multiply8By16
    ld a, l
    add $56
    ld l, a
    ld a, h
    adc $40
    ld h, a
    pop de
    ld b, $1a

; the same 7 bytes as CopyBytesDEFromHL (CopyBytesDEFromHL)
CopyBytesDEFromHL_BankA2::
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, CopyBytesDEFromHL_BankA2
    ret
    db $00, $00, $ff, $ff, $ff, $ff
    ds $14, $00

; CopyMonsterTableBytesFrom4056 and LoadMonsterRecordTo_Sub01 read the 26-byte record at $4056 + 26
; * (monster id - $250 + 1) for ids at or above $250 (E-0033), so id $250 starts at $4070; 93
; records up to the code at $49E2, the same layout as MonsterTable (E-0240, C1)
; record: picture number: index into MonsterPictureTable, MonsterAttributeMapTable and
; MonsterPaletteTable (at most $0179; ids 1, 2, 3 = Slime, SpotSlime, CactiBall use pictures 10, 2,
; 145); skill id 1 (SkillTable index, $FF = none); skill id 2; skill id 3; skill id 4; EXP, 16 bits
; (copied to battler $18-$19, the low word of a 24-bit EXP; C1, E-0298); join-chance class 0-7
; (battler byte $4D; 7 = never joins; C1, E-0306); level 0-99 (copied to battler $17, BATTLER_LEVEL;
; C1, E-0298); base HP; base MP; base ATK; base DEF; base AGL; base INT; byte 22: personality axis
; copied to save-record offset $6F (graded with weight 9 by PersonalityIndexOfRecord); byte 23:
; personality axis copied to offset $70 (weight 1); byte 24: copied to offset $71 (not used by
; PersonalityIndexOfRecord); byte 25: personality axis copied to offset $72 (weight 3)
MonsterTableA2::
    db $18, $00 ; id 592 GoldSlime
    db SKILL_CHANCE
    db SKILL_HUSTLE
    db SKILL_DEMAGIC
    db SKILL_DODGE
    db $ee, $d9, $06, $55, $e8, $01, $9d, $00, $11, $02, $e7, $03, $f5, $01, $13, $03, $46, $be, $c8, $96
    db $40, $00 ; id 593 Divinegon
    db SKILL_HELLBLAST
    db SKILL_HIGHJUMP
    db SKILL_BAZOOCALL
    db SKILL_STORMWIND
    db $a8, $9b, $06, $57, $19, $03, $52, $00, $c6, $02, $d0, $02, $03, $02, $e3, $02, $aa, $be, $96, $96
    db $60, $00 ; id 594 KingLeo
    db SKILL_BOUNCE
    db SKILL_AQUACUT
    db SKILL_WARCRY
    db SKILL_LIFESONG
    db $e1, $86, $06, $56, $46, $03, $47, $01, $a5, $02, $ae, $01, $fe, $01, $e4, $02, $c8, $b4, $96, $96
    db $81, $00 ; id 595 RainHawk
    db SKILL_BEAT
    db SKILL_BIGBANG
    db SKILL_MULTICUT
    db SKILL_SURGE
    db $59, $7e, $06, $58, $ef, $02, $6f, $00, $87, $02, $6c, $02, $1a, $02, $cf, $02, $82, $c8, $78, $96
    db $a2, $00 ; id 596 Rosevine
    db SKILL_DEFENSE
    db SKILL_WHITEAIR
    db SKILL_GIGASLASH
    db SKILL_SLEEPAIR
    db $73, $8b, $06, $5c, $19, $03, $80, $00, $9f, $02, $41, $02, $fa, $01, $14, $03, $50, $6e, $c8, $96
    db $c6, $00 ; id 597 Armorpion
    db SKILL_TAKEMAGIC
    db SKILL_PARALYZE
    db SKILL_MASSACRE
    db SKILL_SEALPRAY
    db $f1, $85, $06, $5b, $d9, $02, $08, $02, $66, $02, $80, $02, $30, $02, $ec, $02, $8c, $8c, $aa, $96
    db $ee, $00 ; id 598 Durran
    db SKILL_IRONIZE
    db SKILL_MULTICUT
    db SKILL_EERIELITE
    db SKILL_BAZOOCALL
    db $8d, $b7, $06, $5d, $00, $03, $18, $02, $dd, $02, $17, $02, $40, $02, $fc, $02, $c8, $1e, $c8, $96
    db $56, $01 ; id 599 Aquadon
    db SKILL_TIDALWAVE
    db SKILL_ULTRADOWN
    db SKILL_GEYSER
    db SKILL_STRONGD
    db $a4, $9c, $06, $5c, $22, $03, $10, $01, $b1, $02, $10, $02, $1a, $02, $de, $02, $5a, $c8, $c8, $96
    db $a4, $00 ; id 600 Warubou
    db SKILL_MPASSMOST
    db SKILL_DEMAGIC
    db $ff
    db $ff
    db $00, $00, $00, $32, $ac, $01, $4c, $02, $8f, $01, $b0, $01, $6a, $01, $a6, $01, $96, $96, $96, $64
    db $a4, $00 ; id 601 Warubou
    db SKILL_MPASS
    db SKILL_PHEROMONE
    db $ff
    db $ff
    db $00, $00, $00, $28, $41, $01, $78, $01, $08, $01, $3f, $01, $17, $01, $5d, $01, $c8, $32, $32, $96
    db $0a, $01 ; id 602 Skeletor
    db SKILL_FIRESLASH
    db SKILL_VACUSLASH
    db SKILL_BOLTSLASH
    db $ff
    db $00, $00, $00, $2b, $55, $01, $35, $01, $5d, $01, $3d, $01, $0b, $01, $91, $01, $78, $82, $5a, $64
    db $33, $01 ; id 603 StoneMan
    db SKILL_RAMMING
    db SKILL_SURGE
    db SKILL_GEYSER
    db $ff
    db $00, $00, $00, $36, $d3, $01, $ba, $01, $ac, $01, $78, $01, $4b, $01, $e0, $01, $78, $a0, $82, $64
    db $80, $00 ; id 604 FunkyBird
    db SKILL_KODANCE
    db SKILL_LIFEDANCE
    db SKILL_DANCESHUT
    db $ff
    db $00, $00, $00, $2e, $74, $01, $5f, $01, $69, $01, $47, $01, $cb, $01, $b1, $01, $64, $96, $82, $64
    db $0d, $01 ; id 605 Copycat
    db SKILL_TRANSFORM
    db SKILL_BEDRAGON
    db SKILL_LIFESONG
    db $ff
    db $00, $00, $00, $35, $73, $01, $46, $02, $f8, $00, $a1, $01, $ca, $01, $f4, $01, $14, $c8, $b4, $64
    db $33, $00 ; id 606 Andreal
    db SKILL_HEALUS
    db SKILL_ULTRADOWN
    db SKILL_SEALPRAY
    db $ff
    db $00, $00, $00, $3b, $f6, $01, $47, $01, $ad, $01, $bf, $01, $e9, $01, $ab, $01, $b4, $8c, $8c, $64
    db $2c, $00 ; id 607 Drygon
    db SKILL_WHITEAIR
    db SKILL_METALCUT
    db SKILL_SICKLICK
    db $ff
    db $00, $00, $07, $28, $e0, $01, $d2, $00, $b0, $01, $a5, $02, $0e, $01, $f4, $01, $64, $28, $6e, $96
    db $1b, $00 ; id 608 Butch
    db SKILL_THORDAIN
    db SKILL_BEDRAGON
    db SKILL_DEMAGIC
    db $ff
    db $28, $00, $07, $00, $f3, $02, $42, $01, $23, $02, $ee, $00, $84, $02, $f4, $01, $c8, $c8, $c8, $96
    db $5a, $01 ; id 609 Pumpoise
    db SKILL_THORDAIN
    db SKILL_BOUNCE
    db SKILL_HUSTLE
    db $ff
    db $00, $00, $07, $28, $20, $03, $84, $01, $ee, $00, $ff, $00, $4a, $01, $f4, $01, $50, $96, $96, $96
    db $61, $01 ; id 610 LordDraco
    db SKILL_EVILSLASH
    db SKILL_EERIELITE
    db SKILL_SUCKALL
    db $ff
    db $00, $00, $07, $46, $e7, $03, $2c, $01, $58, $02, $fa, $00, $18, $01, $e7, $03, $fa, $c8, $c8, $c8
    db $df, $00 ; id 611 Lionex
    db SKILL_BOLT
    db SKILL_MASSACRE
    db SKILL_ULTRADOWN
    db $ff
    db $00, $00, $00, $01, $32, $00, $19, $00, $28, $00, $1e, $00, $1e, $00, $50, $00, $fa, $c8, $c8, $64
    db $7f, $00 ; id 612 WhipBird
    db SKILL_WINDBEAST
    db SKILL_DANCESHUT
    db SKILL_SEALPRAY
    db $ff
    db $00, $00, $00, $01, $1e, $00, $32, $00, $1e, $00, $23, $00, $28, $00, $64, $00, $64, $96, $c8, $64
    db $33, $01 ; id 613 StoneMan
    db SKILL_STRONGD
    db SKILL_SUCKALL
    db $ff
    db $ff
    db $b5, $1c, $05, $2a, $56, $01, $01, $01, $f8, $00, $c5, $00, $dc, $00, $fa, $00, $96, $14, $46, $64
    db $07, $01 ; id 614 DeadNoble
    db $ff
    db $ff
    db $ff
    db $ff
    db $00, $00, $00, $01, $78, $00, $5e, $00, $71, $00, $5b, $00, $52, $00, $69, $00, $1e, $14, $0f, $64
    db $17, $00 ; id 615 MetalKing
    db SKILL_HEALUSALL
    db SKILL_HELLBLAST
    db SKILL_SURGE
    db SKILL_DANCESHUT
    db $d4, $c6, $06, $54, $42, $01, $61, $00, $7a, $01, $e7, $03, $fd, $01, $86, $02, $1e, $64, $5a, $96
    db $3f, $00 ; id 616 Serpentia
    db SKILL_VACUUM
    db SKILL_NAPATTACK
    db SKILL_FOCUS
    db SKILL_SUCKALL
    db $01, $60, $06, $53, $de, $02, $d1, $00, $58, $02, $a9, $01, $f1, $01, $3d, $02, $6e, $6e, $6e, $96
    db $52, $00 ; id 617 IronTurt
    db SKILL_BLAZEMOST
    db SKILL_TAKEMAGIC
    db SKILL_METALCUT
    db SKILL_SICKLICK
    db $cf, $53, $06, $53, $88, $02, $ac, $01, $a3, $01, $6b, $02, $57, $01, $7a, $02, $64, $78, $64, $96
    db $7d, $00 ; id 618 ZapBird
    db SKILL_MPASSMOST
    db SKILL_VACUSLASH
    db SKILL_MULTICUT
    db SKILL_SICKLICK
    db $7b, $60, $06, $55, $75, $02, $93, $00, $73, $02, $d8, $01, $41, $02, $a7, $02, $5a, $14, $64, $96
    db $a7, $00 ; id 619 FooHero
    db SKILL_EXPLODET
    db SKILL_YELLHELP
    db SKILL_PALSYAIR
    db SKILL_PHEROMONE
    db $7f, $57, $06, $56, $d8, $02, $a7, $00, $59, $02, $f1, $01, $99, $01, $87, $02, $c8, $c8, $1e, $96
    db $e0, $00 ; id 620 GoatHorn
    db SKILL_INFERMOST
    db SKILL_QUADHITS
    db SKILL_GEYSER
    db SKILL_GUARDIAN
    db $ad, $5b, $06, $55, $74, $02, $5c, $01, $73, $02, $08, $02, $41, $02, $a7, $02, $5a, $14, $64, $96
    db $04, $01 ; id 621 Inverzon
    db SKILL_SHEARS
    db SKILL_CHARGEUP
    db SKILL_SLEEPAIR
    db SKILL_ROBDANCE
    db $41, $66, $06, $56, $89, $02, $9e, $00, $38, $02, $cd, $01, $be, $01, $08, $02, $1e, $1e, $1e, $96
    db $23, $01 ; id 622 Voodoll
    db SKILL_ANTIDOTE
    db SKILL_DECHAOS
    db SKILL_NUMBOFF
    db SKILL_POISONAIR
    db $ae, $68, $06, $57, $9a, $02, $4e, $01, $26, $02, $06, $02, $a1, $01, $b0, $02, $0a, $0a, $0a, $96
    db $51, $01 ; id 623 AxeShark
    db SKILL_FIREBOLT
    db SKILL_RAINSLASH
    db SKILL_MASSACRE
    db SKILL_STRONGD
    db $12, $87, $06, $56, $2b, $03, $e9, $00, $bd, $02, $f2, $01, $ab, $01, $0a, $02, $c8, $78, $c8, $96
    db $54, $01 ; id 624 Digong
    db SKILL_TWINHITS
    db SKILL_HELLBLAST
    db SKILL_BEASTCUT
    db SKILL_SANDSTORM
    db $4d, $96, $06, $58, $e7, $02, $84, $00, $60, $02, $c4, $01, $97, $01, $0a, $02, $14, $c8, $c8, $96
    db $2b, $00 ; id 625 Swordgon
    db SKILL_REVIVE
    db SKILL_CURSEOFF
    db SKILL_LIGHTNING
    db SKILL_AQUACUT
    db $e9, $85, $06, $55, $e8, $01, $48, $00, $56, $02, $08, $02, $f5, $01, $6d, $02, $fa, $3c, $1e, $96
    db $42, $00 ; id 626 GigaDraco
    db SKILL_PANICALL
    db SKILL_WHITEAIR
    db SKILL_DEVILCUT
    db SKILL_LOVERAIN
    db $3c, $a0, $06, $57, $19, $03, $55, $00, $cb, $02, $e9, $01, $47, $01, $5a, $02, $32, $28, $0a, $96
    db $51, $00 ; id 627 SuperTen
    db SKILL_LIFEDANCE
    db SKILL_HUSTLE
    db SKILL_THICKFOG
    db SKILL_DANCESHUT
    db $e1, $86, $06, $57, $7e, $02, $62, $00, $fd, $01, $93, $01, $f9, $01, $e4, $02, $c8, $78, $c8, $96
    db $75, $00 ; id 628 BigRoost
    db SKILL_HEALUS
    db SKILL_STOPSPELL
    db SKILL_ROCKTHROW
    db SKILL_BUGBLOW
    db $59, $7e, $06, $58, $6b, $02, $72, $00, $00, $02, $c0, $01, $1a, $02, $1b, $02, $28, $c8, $28, $96
    db $a1, $00 ; id 629 GhosTree
    db SKILL_DEFEAT
    db SKILL_SLEEPALL
    db SKILL_DRAKSLASH
    db SKILL_CURSE
    db $43, $7a, $06, $5c, $dd, $02, $3a, $00, $0a, $02, $a2, $01, $92, $01, $61, $02, $1e, $a0, $0a, $96
    db $c3, $00 ; id 630 WarMantis
    db SKILL_SLOWALL
    db SKILL_METALCUT
    db SKILL_GIGASLASH
    db SKILL_RADIANT
    db $f1, $85, $06, $5b, $4d, $02, $8f, $00, $4c, $02, $db, $01, $97, $01, $a1, $02, $c8, $c8, $28, $96
    db $0b, $00 ; id 631 Healer
    db SKILL_HEAL
    db $ff
    db $ff
    db $ff
    db $69, $00, $01, $08, $1f, $00, $09, $00, $15, $00, $14, $00, $12, $00, $5b, $00, $14, $46, $46, $64
    db $7e, $01 ; id 632 Kagebou
    db SKILL_BEDRAGON
    db SKILL_CHANCE
    db SKILL_TATSUCALL
    db $ff
    db $00, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $bc, $02, $64, $00, $c8, $32, $96, $c8
    db $7d, $01 ; id 633 Dimensaur
    db SKILL_MEGAMAGIC
    db SKILL_HELLBLAST
    db SKILL_WHITEFIRE
    db $ff
    db $00, $00, $00, $01, $0a, $00, $0a, $00, $bc, $02, $0a, $00, $0a, $00, $0a, $00, $c8, $c8, $96, $c8
    db $7c, $01 ; id 634 Lamia
    db SKILL_HEALUS
    db SKILL_MPASS
    db SKILL_VIVIFY
    db $ff
    db $00, $00, $00, $32, $f4, $01, $bc, $02, $f4, $01, $bc, $02, $58, $02, $58, $02, $64, $fa, $c8, $c8
    db $5f, $01 ; id 635 DracoLord
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $60, $01 ; id 636 DracoLord
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $61, $01 ; id 637 LordDraco
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $62, $01 ; id 638 Hargon
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $63, $01 ; id 639 Sidoh
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $64, $01 ; id 640 Genosidoh
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $65, $01 ; id 641 Baramos
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $66, $01 ; id 642 Zoma
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $67, $01 ; id 643 AsuraZoma
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $19, $c8
    db $68, $01 ; id 644 Pizzaro
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $69, $01 ; id 645 PsychoPiz
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $6a, $01 ; id 646 Esterk
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $6b, $01 ; id 647 Mirudraas
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $6c, $01 ; id 648 Mirudraas
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $6d, $01 ; id 649 Mudou
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $6e, $01 ; id 650 DeathMore
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $6f, $01 ; id 651 DeathMore
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $70, $01 ; id 652 DeathMore
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $71, $01 ; id 653 Darkdrium
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $72, $01 ; id 654 Orgodemir
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $73, $01 ; id 655 Orgodemir
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $74, $01 ; id 656 Darck
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $16, $00 ; id 657 HaloSlime
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $18, $00 ; id 658 GoldSlime
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $19, $00 ; id 659 GranSlime
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $1a, $00 ; id 660 WonderEgg
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $41, $00 ; id 661 Orligon
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $42, $00 ; id 662 GigaDraco
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $61, $00 ; id 663 DarkHorn
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $64, $00 ; id 664 Gorago
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $81, $00 ; id 665 RainHawk
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $82, $00 ; id 666 Azurile
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $83, $00 ; id 667 Shantak
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $a5, $00 ; id 668 Watabou
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $a4, $00 ; id 669 Warubou
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $a3, $00 ; id 670 Egdracil
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $c7, $00 ; id 671 Digster
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $c8, $00 ; id 672 Skularach
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $ef, $00 ; id 673 Titanis
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $f0, $00 ; id 674 LampGenie
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $10, $01 ; id 675 Niterich
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $08, $01 ; id 676 WhiteKing
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $0c, $01 ; id 677 Lazamanus
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $35, $01 ; id 678 GoldGolem
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $36, $01 ; id 679 DarkMate
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $52, $01 ; id 680 Octogon
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $57, $01 ; id 681 Octoraid
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $58, $01 ; id 682 Grakos
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $59, $01 ; id 683 Poseidon
    db $ff
    db $ff
    db $ff
    db $ff
    db $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8
    db $0a, $00 ; id 684 Slime
    db $ff
    db $ff
    db $ff
    db $ff
    db $ff, $ff, $07, $01, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $01, $01, $01

BeginStringDisplay_BankE0_BeginStringDisplay::
    ld de, StringCategories_A2_49F8
    ld a, [wStringCategory]
    sub $01
    ld [wStringCategory], a
    call BeginStringDisplay
    ret
    db $cd, $e2, $49, $cd, $11, $26, $c9

; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StringCategories_A2_49F8::
    dw StringList_A2_49FC ; id 0
    dw StringList_A2_4A3E ; id 1

; category list of StringCategories_A2_49F8; one pointer per wStringIndex (E-0217)
; record: string
StringList_A2_49FC::
    dw String_A2_00_00 ; id 0
    dw String_A2_00_01 ; id 1
    dw String_A2_00_02 ; id 2
    dw String_A2_00_03 ; id 3
    dw String_A2_00_04 ; id 4
    dw String_A2_00_05 ; id 5
    dw String_A2_00_06 ; id 6
    dw String_A2_00_07 ; id 7
    dw String_A2_00_08 ; id 8
    dw String_A2_00_09 ; id 9
    dw String_A2_00_0A ; id 10
    dw String_A2_00_0B ; id 11
    dw String_A2_00_0C ; id 12
    dw String_A2_00_0D ; id 13
    dw String_A2_00_0E ; id 14
    dw String_A2_00_0F ; id 15
    dw String_A2_00_10 ; id 16
    dw String_A2_00_11 ; id 17
    dw String_A2_00_12 ; id 18
    dw String_A2_00_13 ; id 19
    dw String_A2_00_14 ; id 20
    dw String_A2_00_15 ; id 21
    dw String_A2_00_16 ; id 22
    dw String_A2_00_17 ; id 23
    dw String_A2_00_18 ; id 24
    dw String_A2_00_19 ; id 25
    dw String_A2_00_1A ; id 26
    dw String_A2_00_1B ; id 27
    dw String_A2_00_1C ; id 28
    dw String_A2_00_1D ; id 29
    dw String_A2_00_1E ; id 30
    dw String_A2_00_1F ; id 31
    dw String_A2_00_20 ; id 32

StringList_A2_4A3E::
    dw String_A2_01_00 ; id 0

String_A2_00_00::
    db "    YUJI HORII@"

String_A2_00_01::
    db "    YUJI HORII<LINE>"
    db "       ENIX<LINE>"
    db "       TOSE<LINE>"
    db "FUMINORI ISHIKAWA@"

String_A2_00_02::
    db "  AKIRA TORIYAMA@"

String_A2_00_03::
    db "  KOICHI SUGIYAMA@"

String_A2_00_04::
    db "   NOB OGASAWARA<LINE>"
    db "   LYNN OGASAWARA<LINE>"
    db "   KAI OGASAWARA@"

String_A2_00_05::
    db $f0

String_A2_00_06::
    db "  MITSURU G TORII@"

String_A2_00_07::
    db "   JOHN LAURENCE@"

String_A2_00_08::
    db "  JON WEISNEWSKI@"

String_A2_00_09::
    db "  MASAKO KOMIYAMA<LINE>"
    db "   YURIKO MIZUTA<LINE>"
    db "  MASANOBU YOSHIDA@"

String_A2_00_0A::
    db "   CHRIS CHYMIY<LINE>"
    db "   SHAWN CONARD<LINE>"
    db "    TJ COWGILL<LINE>"
    db "    JOHN HOLES<LINE>"
    db "  JERRY PRITCHARD<LINE>"
    db "   AARON SCHMITT@"

String_A2_00_0B::
    db "   ANDREW STEIN@"

String_A2_00_0C::
    db "  MISUZU MCMILLAN@"

String_A2_00_0D::
    db "     YURI KATO@"

String_A2_00_0E::
    db "  PAUL HANDELMAN@"

String_A2_00_0F::
    db $f0

String_A2_00_10::
    db "    NAOKI OISHI<LINE>"
    db " TAKASHI KAMIMURA@"

String_A2_00_11::
    db "   KENJIRO KANO<LINE>"
    db "   TOMOYUKI IWAI<LINE>"
    db "  NORIKO NAKANONE<LINE>"
    db "  KAZUNORI OHWADA@"

String_A2_00_12::
    db "   HIROSHI SATO<LINE>"
    db "  HIDEKI YONEYAMA@"

String_A2_00_13::
    db " TAKATOSHI AKIYAMA<LINE>"
    db " SEIICHI MORIUCHI<LINE>"
    db "  SHINOBU NONAKA<LINE>"
    db " SATOSHI FUKUSHIMA<LINE>"
    db "     YUMI TOGO@"

String_A2_00_14::
    db "  HIDEYUKI NUKUI<LINE>"
    db "  HIROSHI KONDOU<LINE>"
    db "   BIN KANAZAWA<LINE>"
    db "  KAZUHIRO NOMURA<LINE>"
    db "   TOMOE SUZUKI@"

String_A2_00_15::
    db "     KAN IKEDA<LINE>"
    db "   YOUKO KAGAYA<LINE>"
    db "   EMI NARIKIYO<LINE>"
    db "     MIKA ENDO<LINE>"
    db "   SAKIKO IKEDA@"

String_A2_00_16::
    db "  TETUYA FUJIMOTO<LINE>"
    db "  MINORU KAKIZAWA<LINE>"
    db "  YASUHITO SUZUKI<LINE>"
    db "    NAOMI OZAWA<LINE>"
    db "    KOJI NUMATA@"

String_A2_00_17::
    db "  ATUSHI TAKEUCHI<LINE>"
    db "   TOMOHIRO ASO<LINE>"
    db " KENSUKE YOKOYAMA<LINE>"
    db " KENICHI YAMAMOTO<LINE>"
    db " TEPPEI KOBAYASHI@"

String_A2_00_18::
    db "    JIRO KIMURA<LINE>"
    db "  YASUNORI HOSONO<LINE>"
    db " KENTAKA NAKASHIMA<LINE>"
    db "    RYO YONAGA<LINE>"
    db "   SHINGO NOGUKI@"

String_A2_00_19::
    db "  YUJIRO KUMAKURA<LINE>"
    db "    NAOKI SIRAI<LINE>"
    db "     RIE IWAO<LINE>"
    db " KATUHIKO YOKOYAMA<LINE>"
    db " RYUICHI NAKASHIMA@"

String_A2_00_1A::
    db "   MASASHI KONNO<LINE>"
    db " MIKIHIRO HAYASHI<LINE>"
    db "  MIHO SHIBASAKI<LINE>"
    db "   MASAYUKI TADA<LINE>"
    db "    KAYO NAKATA@"

String_A2_00_1B::
    db "   NAOYA MATSUDA<LINE>"
    db " YOSHITO TANIUCHI@"

String_A2_00_1C::
    db "  TAICHI INUZUKA@"

String_A2_00_1D::
    db "  YUKINOBU CHIDA<LINE>"
    db "   KOUJI TAGUCHI@"

String_A2_00_1E::
    db "    KEIJI HONDA@"

String_A2_00_1F::
    db " ©2001<LINE>"
    db "  ARMOR PROJECT<LINE>"
    db " ©2001<LINE>"
    db "  BIRD STUDIO<LINE>"
    db " ©2001<LINE>"
    db "  KOICHI SUGIYAMA<LINE>"

String_A2_00_20::
    db $f0

String_A2_01_00::
    db "DRAGON WARRIOR<LINE>"
    db "  MONSTERS 2@"
    ds $3019, $00
