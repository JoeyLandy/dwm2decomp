; ROM bank $A2: strings and monster loading
; The annotated listing of this bank is build/listing/banka2.asm.

SECTION "Bank A2", ROMX
    db $a2

; wMonsterId (16 bits, $250 or more), C = a byte offset in the 26-byte record, hTemp0 = a count, DE
; = a destination: copies hTemp0 bytes from MonsterTableA2 at 26 * (wMonsterId - $250 + 1) + C to DE
; (CopyBytesDEFromHL_BankA2); DE ends past the bytes copied and B is 0. Called by
; CopyMonsterTableBytesFromMonsterTable for the ids it hands over. (C2, E-0385)
; HL = $4056 + 26 * (monster id - $250 + 1) + C; copies hTemp0 bytes from HL to DE (E-0121) (E-0344:
; the address in its name dropped or read as the label there; was CopyMonsterTableBytes; a trailing
; preposition left by the dropped address removed)
CopyMonsterTableBytes::
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
    add LOW(MonsterTableA2 - $1a)
    ld l, a
    ld a, h
    adc HIGH(MonsterTableA2 - $1a)
    ld h, a
    pop bc
    ld b, $00
    add hl, bc
    ldh a, [hTemp0]
    ld b, a
    pop de
    call CopyBytesDEFromHL_BankA2
    ret

SECTION "Bank A2 LoadMonsterRecordTo_HighIds", ROMX

; Monster ids from $250 on, kept in this bank: copies the 26-byte record at $4056 + 26 x (id - $24F)
; to DE (CopyBytesDEFromHL_BankA2). (C2, E-0357; probed E-0385)
LoadMonsterRecordTo_HighIds::
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
    add LOW(MonsterTableA2 - $1a)
    ld l, a
    ld a, h
    adc HIGH(MonsterTableA2 - $1a)
    ld h, a
    pop de
    ld b, $1a

; HL = source, DE = destination, B = count (not 0): copies B bytes from HL to DE; HL and DE end past
; them, B ends 0, A is clobbered. Called by CopyMonsterTableBytes; LoadMonsterRecordTo_HighIds falls
; into it with B = $1A. (C2, E-0385)
; the same 7 bytes as CopyBytesDEFromHL (CopyBytesDEFromHL) (E-0353)
CopyBytesDEFromHL_BankA2::
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, CopyBytesDEFromHL_BankA2
    ret
    db $00, $00, $ff, $ff, $ff, $ff
    ds $14, $00

; CopyMonsterTableBytes and LoadMonsterRecordTo_HighIds read the 26-byte record at $4056 + 26 *
; (monster id - $250 + 1) for ids at or above $250 (E-0033), so id $250 starts at $4070; 93 records
; up to the code at $49E2, the same layout as MonsterTable (E-0240, C1)
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
    dw MONSTER_GOLDSLIME ; id 592 GoldSlime: picture: monster id
    db SKILL_CHANCE ; skill 1
    db SKILL_HUSTLE ; skill 2
    db SKILL_DEMAGIC ; skill 3
    db SKILL_DODGE ; skill 4
    dw 55790 ; EXP
    db $06 ; join-chance class
    db $55 ; level
    dw 488 ; base HP
    dw 157 ; base MP
    dw 529 ; base ATK
    dw 999 ; base DEF
    dw 501 ; base AGL
    dw 787 ; base INT
    db $46 ; personality axis $6F
    db $be ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_DIVINEGON ; id 593 Divinegon: picture: monster id
    db SKILL_HELLBLAST ; skill 1
    db SKILL_HIGHJUMP ; skill 2
    db SKILL_BAZOOCALL ; skill 3
    db SKILL_STORMWIND ; skill 4
    dw 39848 ; EXP
    db $06 ; join-chance class
    db $57 ; level
    dw 793 ; base HP
    dw 82 ; base MP
    dw 710 ; base ATK
    dw 720 ; base DEF
    dw 515 ; base AGL
    dw 739 ; base INT
    db $aa ; personality axis $6F
    db $be ; personality axis $70
    db $96 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_KINGLEO ; id 594 KingLeo: picture: monster id
    db SKILL_BOUNCE ; skill 1
    db SKILL_AQUACUT ; skill 2
    db SKILL_WARCRY ; skill 3
    db SKILL_LIFESONG ; skill 4
    dw 34529 ; EXP
    db $06 ; join-chance class
    db $56 ; level
    dw 838 ; base HP
    dw 327 ; base MP
    dw 677 ; base ATK
    dw 430 ; base DEF
    dw 510 ; base AGL
    dw 740 ; base INT
    db $c8 ; personality axis $6F
    db $b4 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_RAINHAWK ; id 595 RainHawk: picture: monster id
    db SKILL_BEAT ; skill 1
    db SKILL_BIGBANG ; skill 2
    db SKILL_MULTICUT ; skill 3
    db SKILL_SURGE ; skill 4
    dw 32345 ; EXP
    db $06 ; join-chance class
    db $58 ; level
    dw 751 ; base HP
    dw 111 ; base MP
    dw 647 ; base ATK
    dw 620 ; base DEF
    dw 538 ; base AGL
    dw 719 ; base INT
    db $82 ; personality axis $6F
    db $c8 ; personality axis $70
    db $78 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_ROSEVINE ; id 596 Rosevine: picture: monster id
    db SKILL_DEFENSE ; skill 1
    db SKILL_WHITEAIR ; skill 2
    db SKILL_GIGASLASH ; skill 3
    db SKILL_SLEEPAIR ; skill 4
    dw 35699 ; EXP
    db $06 ; join-chance class
    db $5c ; level
    dw 793 ; base HP
    dw 128 ; base MP
    dw 671 ; base ATK
    dw 577 ; base DEF
    dw 506 ; base AGL
    dw 788 ; base INT
    db $50 ; personality axis $6F
    db $6e ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_ARMORPION ; id 597 Armorpion: picture: monster id
    db SKILL_TAKEMAGIC ; skill 1
    db SKILL_PARALYZE ; skill 2
    db SKILL_MASSACRE ; skill 3
    db SKILL_SEALPRAY ; skill 4
    dw 34289 ; EXP
    db $06 ; join-chance class
    db $5b ; level
    dw 729 ; base HP
    dw 520 ; base MP
    dw 614 ; base ATK
    dw 640 ; base DEF
    dw 560 ; base AGL
    dw 748 ; base INT
    db $8c ; personality axis $6F
    db $8c ; personality axis $70
    db $aa ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_DURRAN ; id 598 Durran: picture: monster id
    db SKILL_IRONIZE ; skill 1
    db SKILL_MULTICUT ; skill 2
    db SKILL_EERIELITE ; skill 3
    db SKILL_BAZOOCALL ; skill 4
    dw 46989 ; EXP
    db $06 ; join-chance class
    db $5d ; level
    dw 768 ; base HP
    dw 536 ; base MP
    dw 733 ; base ATK
    dw 535 ; base DEF
    dw 576 ; base AGL
    dw 764 ; base INT
    db $c8 ; personality axis $6F
    db $1e ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_AQUADON ; id 599 Aquadon: picture: monster id
    db SKILL_TIDALWAVE ; skill 1
    db SKILL_ULTRADOWN ; skill 2
    db SKILL_GEYSER ; skill 3
    db SKILL_STRONGD ; skill 4
    dw 40100 ; EXP
    db $06 ; join-chance class
    db $5c ; level
    dw 802 ; base HP
    dw 272 ; base MP
    dw 689 ; base ATK
    dw 528 ; base DEF
    dw 538 ; base AGL
    dw 734 ; base INT
    db $5a ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_WARUBOU ; id 600 Warubou: picture: monster id
    db SKILL_MPASSMOST ; skill 1
    db SKILL_DEMAGIC ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $00 ; join-chance class
    db $32 ; level
    dw 428 ; base HP
    dw 588 ; base MP
    dw 399 ; base ATK
    dw 432 ; base DEF
    dw 362 ; base AGL
    dw 422 ; base INT
    db $96 ; personality axis $6F
    db $96 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_WARUBOU ; id 601 Warubou: picture: monster id
    db SKILL_MPASS ; skill 1
    db SKILL_PHEROMONE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $00 ; join-chance class
    db $28 ; level
    dw 321 ; base HP
    dw 376 ; base MP
    dw 264 ; base ATK
    dw 319 ; base DEF
    dw 279 ; base AGL
    dw 349 ; base INT
    db $c8 ; personality axis $6F
    db $32 ; personality axis $70
    db $32 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_SKELETOR ; id 602 Skeletor: picture: monster id
    db SKILL_FIRESLASH ; skill 1
    db SKILL_VACUSLASH ; skill 2
    db SKILL_BOLTSLASH ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $00 ; join-chance class
    db $2b ; level
    dw 341 ; base HP
    dw 309 ; base MP
    dw 349 ; base ATK
    dw 317 ; base DEF
    dw 267 ; base AGL
    dw 401 ; base INT
    db $78 ; personality axis $6F
    db $82 ; personality axis $70
    db $5a ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_STONEMAN ; id 603 StoneMan: picture: monster id
    db SKILL_RAMMING ; skill 1
    db SKILL_SURGE ; skill 2
    db SKILL_GEYSER ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $00 ; join-chance class
    db $36 ; level
    dw 467 ; base HP
    dw 442 ; base MP
    dw 428 ; base ATK
    dw 376 ; base DEF
    dw 331 ; base AGL
    dw 480 ; base INT
    db $78 ; personality axis $6F
    db $a0 ; personality axis $70
    db $82 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_FUNKYBIRD ; id 604 FunkyBird: picture: monster id
    db SKILL_KODANCE ; skill 1
    db SKILL_LIFEDANCE ; skill 2
    db SKILL_DANCESHUT ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $00 ; join-chance class
    db $2e ; level
    dw 372 ; base HP
    dw 351 ; base MP
    dw 361 ; base ATK
    dw 327 ; base DEF
    dw 459 ; base AGL
    dw 433 ; base INT
    db $64 ; personality axis $6F
    db $96 ; personality axis $70
    db $82 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_COPYCAT ; id 605 Copycat: picture: monster id
    db SKILL_TRANSFORM ; skill 1
    db SKILL_BEDRAGON ; skill 2
    db SKILL_LIFESONG ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $00 ; join-chance class
    db $35 ; level
    dw 371 ; base HP
    dw 582 ; base MP
    dw 248 ; base ATK
    dw 417 ; base DEF
    dw 458 ; base AGL
    dw 500 ; base INT
    db $14 ; personality axis $6F
    db $c8 ; personality axis $70
    db $b4 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_ANDREAL ; id 606 Andreal: picture: monster id
    db SKILL_HEALUS ; skill 1
    db SKILL_ULTRADOWN ; skill 2
    db SKILL_SEALPRAY ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $00 ; join-chance class
    db $3b ; level
    dw 502 ; base HP
    dw 327 ; base MP
    dw 429 ; base ATK
    dw 447 ; base DEF
    dw 489 ; base AGL
    dw 427 ; base INT
    db $b4 ; personality axis $6F
    db $8c ; personality axis $70
    db $8c ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_DRYGON ; id 607 Drygon: picture: monster id
    db SKILL_WHITEAIR ; skill 1
    db SKILL_METALCUT ; skill 2
    db SKILL_SICKLICK ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $28 ; level
    dw 480 ; base HP
    dw 210 ; base MP
    dw 432 ; base ATK
    dw 677 ; base DEF
    dw 270 ; base AGL
    dw 500 ; base INT
    db $64 ; personality axis $6F
    db $28 ; personality axis $70
    db $6e ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_BUTCH ; id 608 Butch: picture: monster id
    db SKILL_THORDAIN ; skill 1
    db SKILL_BEDRAGON ; skill 2
    db SKILL_DEMAGIC ; skill 3
    db $ff ; skill 4
    dw 40 ; EXP
    db $07 ; join-chance class
    db $00 ; level
    dw 755 ; base HP
    dw 322 ; base MP
    dw 547 ; base ATK
    dw 238 ; base DEF
    dw 644 ; base AGL
    dw 500 ; base INT
    db $c8 ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_PUMPOISE ; id 609 Pumpoise: picture: monster id
    db SKILL_THORDAIN ; skill 1
    db SKILL_BOUNCE ; skill 2
    db SKILL_HUSTLE ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $28 ; level
    dw 800 ; base HP
    dw 388 ; base MP
    dw 238 ; base ATK
    dw 255 ; base DEF
    dw 330 ; base AGL
    dw 500 ; base INT
    db $50 ; personality axis $6F
    db $96 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_LORDDRACO ; id 610 LordDraco: picture: monster id
    db SKILL_EVILSLASH ; skill 1
    db SKILL_EERIELITE ; skill 2
    db SKILL_SUCKALL ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $46 ; level
    dw 999 ; base HP
    dw 300 ; base MP
    dw 600 ; base ATK
    dw 250 ; base DEF
    dw 280 ; base AGL
    dw 999 ; base INT
    db $fa ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_LIONEX ; id 611 Lionex: picture: monster id
    db SKILL_BOLT ; skill 1
    db SKILL_MASSACRE ; skill 2
    db SKILL_ULTRADOWN ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $00 ; join-chance class
    db $01 ; level
    dw 50 ; base HP
    dw 25 ; base MP
    dw 40 ; base ATK
    dw 30 ; base DEF
    dw 30 ; base AGL
    dw 80 ; base INT
    db $fa ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_WHIPBIRD ; id 612 WhipBird: picture: monster id
    db SKILL_WINDBEAST ; skill 1
    db SKILL_DANCESHUT ; skill 2
    db SKILL_SEALPRAY ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $00 ; join-chance class
    db $01 ; level
    dw 30 ; base HP
    dw 50 ; base MP
    dw 30 ; base ATK
    dw 35 ; base DEF
    dw 40 ; base AGL
    dw 100 ; base INT
    db $64 ; personality axis $6F
    db $96 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_STONEMAN ; id 613 StoneMan: picture: monster id
    db SKILL_STRONGD ; skill 1
    db SKILL_SUCKALL ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 7349 ; EXP
    db $05 ; join-chance class
    db $2a ; level
    dw 342 ; base HP
    dw 257 ; base MP
    dw 248 ; base ATK
    dw 197 ; base DEF
    dw 220 ; base AGL
    dw 250 ; base INT
    db $96 ; personality axis $6F
    db $14 ; personality axis $70
    db $46 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_DEADNOBLE ; id 614 DeadNoble: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $00 ; join-chance class
    db $01 ; level
    dw 120 ; base HP
    dw 94 ; base MP
    dw 113 ; base ATK
    dw 91 ; base DEF
    dw 82 ; base AGL
    dw 105 ; base INT
    db $1e ; personality axis $6F
    db $14 ; personality axis $70
    db $0f ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_METALKING ; id 615 MetalKing: picture: monster id
    db SKILL_HEALUSALL ; skill 1
    db SKILL_HELLBLAST ; skill 2
    db SKILL_SURGE ; skill 3
    db SKILL_DANCESHUT ; skill 4
    dw 50900 ; EXP
    db $06 ; join-chance class
    db $54 ; level
    dw 322 ; base HP
    dw 97 ; base MP
    dw 378 ; base ATK
    dw 999 ; base DEF
    dw 509 ; base AGL
    dw 646 ; base INT
    db $1e ; personality axis $6F
    db $64 ; personality axis $70
    db $5a ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_SERPENTIA ; id 616 Serpentia: picture: monster id
    db SKILL_VACUUM ; skill 1
    db SKILL_NAPATTACK ; skill 2
    db SKILL_FOCUS ; skill 3
    db SKILL_SUCKALL ; skill 4
    dw 24577 ; EXP
    db $06 ; join-chance class
    db $53 ; level
    dw 734 ; base HP
    dw 209 ; base MP
    dw 600 ; base ATK
    dw 425 ; base DEF
    dw 497 ; base AGL
    dw 573 ; base INT
    db $6e ; personality axis $6F
    db $6e ; personality axis $70
    db $6e ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_IRONTURT ; id 617 IronTurt: picture: monster id
    db SKILL_BLAZEMOST ; skill 1
    db SKILL_TAKEMAGIC ; skill 2
    db SKILL_METALCUT ; skill 3
    db SKILL_SICKLICK ; skill 4
    dw 21455 ; EXP
    db $06 ; join-chance class
    db $53 ; level
    dw 648 ; base HP
    dw 428 ; base MP
    dw 419 ; base ATK
    dw 619 ; base DEF
    dw 343 ; base AGL
    dw 634 ; base INT
    db $64 ; personality axis $6F
    db $78 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_ZAPBIRD ; id 618 ZapBird: picture: monster id
    db SKILL_MPASSMOST ; skill 1
    db SKILL_VACUSLASH ; skill 2
    db SKILL_MULTICUT ; skill 3
    db SKILL_SICKLICK ; skill 4
    dw 24699 ; EXP
    db $06 ; join-chance class
    db $55 ; level
    dw 629 ; base HP
    dw 147 ; base MP
    dw 627 ; base ATK
    dw 472 ; base DEF
    dw 577 ; base AGL
    dw 679 ; base INT
    db $5a ; personality axis $6F
    db $14 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_FOOHERO ; id 619 FooHero: picture: monster id
    db SKILL_EXPLODET ; skill 1
    db SKILL_YELLHELP ; skill 2
    db SKILL_PALSYAIR ; skill 3
    db SKILL_PHEROMONE ; skill 4
    dw 22399 ; EXP
    db $06 ; join-chance class
    db $56 ; level
    dw 728 ; base HP
    dw 167 ; base MP
    dw 601 ; base ATK
    dw 497 ; base DEF
    dw 409 ; base AGL
    dw 647 ; base INT
    db $c8 ; personality axis $6F
    db $c8 ; personality axis $70
    db $1e ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_GOATHORN ; id 620 GoatHorn: picture: monster id
    db SKILL_INFERMOST ; skill 1
    db SKILL_QUADHITS ; skill 2
    db SKILL_GEYSER ; skill 3
    db SKILL_GUARDIAN ; skill 4
    dw 23469 ; EXP
    db $06 ; join-chance class
    db $55 ; level
    dw 628 ; base HP
    dw 348 ; base MP
    dw 627 ; base ATK
    dw 520 ; base DEF
    dw 577 ; base AGL
    dw 679 ; base INT
    db $5a ; personality axis $6F
    db $14 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_INVERZON ; id 621 Inverzon: picture: monster id
    db SKILL_SHEARS ; skill 1
    db SKILL_CHARGEUP ; skill 2
    db SKILL_SLEEPAIR ; skill 3
    db SKILL_ROBDANCE ; skill 4
    dw 26177 ; EXP
    db $06 ; join-chance class
    db $56 ; level
    dw 649 ; base HP
    dw 158 ; base MP
    dw 568 ; base ATK
    dw 461 ; base DEF
    dw 446 ; base AGL
    dw 520 ; base INT
    db $1e ; personality axis $6F
    db $1e ; personality axis $70
    db $1e ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_VOODOLL ; id 622 Voodoll: picture: monster id
    db SKILL_ANTIDOTE ; skill 1
    db SKILL_DECHAOS ; skill 2
    db SKILL_NUMBOFF ; skill 3
    db SKILL_POISONAIR ; skill 4
    dw 26798 ; EXP
    db $06 ; join-chance class
    db $57 ; level
    dw 666 ; base HP
    dw 334 ; base MP
    dw 550 ; base ATK
    dw 518 ; base DEF
    dw 417 ; base AGL
    dw 688 ; base INT
    db $0a ; personality axis $6F
    db $0a ; personality axis $70
    db $0a ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_AXESHARK ; id 623 AxeShark: picture: monster id
    db SKILL_FIREBOLT ; skill 1
    db SKILL_RAINSLASH ; skill 2
    db SKILL_MASSACRE ; skill 3
    db SKILL_STRONGD ; skill 4
    dw 34578 ; EXP
    db $06 ; join-chance class
    db $56 ; level
    dw 811 ; base HP
    dw 233 ; base MP
    dw 701 ; base ATK
    dw 498 ; base DEF
    dw 427 ; base AGL
    dw 522 ; base INT
    db $c8 ; personality axis $6F
    db $78 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_DIGONG ; id 624 Digong: picture: monster id
    db SKILL_TWINHITS ; skill 1
    db SKILL_HELLBLAST ; skill 2
    db SKILL_BEASTCUT ; skill 3
    db SKILL_SANDSTORM ; skill 4
    dw 38477 ; EXP
    db $06 ; join-chance class
    db $58 ; level
    dw 743 ; base HP
    dw 132 ; base MP
    dw 608 ; base ATK
    dw 452 ; base DEF
    dw 407 ; base AGL
    dw 522 ; base INT
    db $14 ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_SWORDGON ; id 625 Swordgon: picture: monster id
    db SKILL_REVIVE ; skill 1
    db SKILL_CURSEOFF ; skill 2
    db SKILL_LIGHTNING ; skill 3
    db SKILL_AQUACUT ; skill 4
    dw 34281 ; EXP
    db $06 ; join-chance class
    db $55 ; level
    dw 488 ; base HP
    dw 72 ; base MP
    dw 598 ; base ATK
    dw 520 ; base DEF
    dw 501 ; base AGL
    dw 621 ; base INT
    db $fa ; personality axis $6F
    db $3c ; personality axis $70
    db $1e ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_GIGADRACO ; id 626 GigaDraco: picture: monster id
    db SKILL_PANICALL ; skill 1
    db SKILL_WHITEAIR ; skill 2
    db SKILL_DEVILCUT ; skill 3
    db SKILL_LOVERAIN ; skill 4
    dw 41020 ; EXP
    db $06 ; join-chance class
    db $57 ; level
    dw 793 ; base HP
    dw 85 ; base MP
    dw 715 ; base ATK
    dw 489 ; base DEF
    dw 327 ; base AGL
    dw 602 ; base INT
    db $32 ; personality axis $6F
    db $28 ; personality axis $70
    db $0a ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_SUPERTEN ; id 627 SuperTen: picture: monster id
    db SKILL_LIFEDANCE ; skill 1
    db SKILL_HUSTLE ; skill 2
    db SKILL_THICKFOG ; skill 3
    db SKILL_DANCESHUT ; skill 4
    dw 34529 ; EXP
    db $06 ; join-chance class
    db $57 ; level
    dw 638 ; base HP
    dw 98 ; base MP
    dw 509 ; base ATK
    dw 403 ; base DEF
    dw 505 ; base AGL
    dw 740 ; base INT
    db $c8 ; personality axis $6F
    db $78 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_BIGROOST ; id 628 BigRoost: picture: monster id
    db SKILL_HEALUS ; skill 1
    db SKILL_STOPSPELL ; skill 2
    db SKILL_ROCKTHROW ; skill 3
    db SKILL_BUGBLOW ; skill 4
    dw 32345 ; EXP
    db $06 ; join-chance class
    db $58 ; level
    dw 619 ; base HP
    dw 114 ; base MP
    dw 512 ; base ATK
    dw 448 ; base DEF
    dw 538 ; base AGL
    dw 539 ; base INT
    db $28 ; personality axis $6F
    db $c8 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_GHOSTREE ; id 629 GhosTree: picture: monster id
    db SKILL_DEFEAT ; skill 1
    db SKILL_SLEEPALL ; skill 2
    db SKILL_DRAKSLASH ; skill 3
    db SKILL_CURSE ; skill 4
    dw 31299 ; EXP
    db $06 ; join-chance class
    db $5c ; level
    dw 733 ; base HP
    dw 58 ; base MP
    dw 522 ; base ATK
    dw 418 ; base DEF
    dw 402 ; base AGL
    dw 609 ; base INT
    db $1e ; personality axis $6F
    db $a0 ; personality axis $70
    db $0a ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_WARMANTIS ; id 630 WarMantis: picture: monster id
    db SKILL_SLOWALL ; skill 1
    db SKILL_METALCUT ; skill 2
    db SKILL_GIGASLASH ; skill 3
    db SKILL_RADIANT ; skill 4
    dw 34289 ; EXP
    db $06 ; join-chance class
    db $5b ; level
    dw 589 ; base HP
    dw 143 ; base MP
    dw 588 ; base ATK
    dw 475 ; base DEF
    dw 407 ; base AGL
    dw 673 ; base INT
    db $c8 ; personality axis $6F
    db $c8 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_HEALER ; id 631 Healer: picture: monster id
    db SKILL_HEAL ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 105 ; EXP
    db $01 ; join-chance class
    db $08 ; level
    dw 31 ; base HP
    dw 9 ; base MP
    dw 21 ; base ATK
    dw 20 ; base DEF
    dw 18 ; base AGL
    dw 91 ; base INT
    db $14 ; personality axis $6F
    db $46 ; personality axis $70
    db $46 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_KAGEBOU ; id 632 Kagebou: picture: monster id
    db SKILL_BEDRAGON ; skill 1
    db SKILL_CHANCE ; skill 2
    db SKILL_TATSUCALL ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 700 ; base AGL
    dw 100 ; base INT
    db $c8 ; personality axis $6F
    db $32 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_DIMENSAUR ; id 633 Dimensaur: picture: monster id
    db SKILL_MEGAMAGIC ; skill 1
    db SKILL_HELLBLAST ; skill 2
    db SKILL_WHITEFIRE ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $00 ; join-chance class
    db $01 ; level
    dw 10 ; base HP
    dw 10 ; base MP
    dw 700 ; base ATK
    dw 10 ; base DEF
    dw 10 ; base AGL
    dw 10 ; base INT
    db $c8 ; personality axis $6F
    db $c8 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_LAMIA ; id 634 Lamia: picture: monster id
    db SKILL_HEALUS ; skill 1
    db SKILL_MPASS ; skill 2
    db SKILL_VIVIFY ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $00 ; join-chance class
    db $32 ; level
    dw 500 ; base HP
    dw 700 ; base MP
    dw 500 ; base ATK
    dw 700 ; base DEF
    dw 600 ; base AGL
    dw 600 ; base INT
    db $64 ; personality axis $6F
    db $fa ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_DRACOLORD ; id 635 DracoLord: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_DRACOLORD_160 ; id 636 DracoLord: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_LORDDRACO ; id 637 LordDraco: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_HARGON ; id 638 Hargon: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_SIDOH ; id 639 Sidoh: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_GENOSIDOH ; id 640 Genosidoh: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_BARAMOS ; id 641 Baramos: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_ZOMA ; id 642 Zoma: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_ASURAZOMA ; id 643 AsuraZoma: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $19 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_PIZZARO ; id 644 Pizzaro: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_PSYCHOPIZ ; id 645 PsychoPiz: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_ESTERK ; id 646 Esterk: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_MIRUDRAAS ; id 647 Mirudraas: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_MIRUDRAAS_16C ; id 648 Mirudraas: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_MUDOU ; id 649 Mudou: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_DEATHMORE ; id 650 DeathMore: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_DEATHMORE_16F ; id 651 DeathMore: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_DEATHMORE_170 ; id 652 DeathMore: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_DARKDRIUM ; id 653 Darkdrium: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_ORGODEMIR ; id 654 Orgodemir: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_ORGODEMIR_173 ; id 655 Orgodemir: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_DARCK ; id 656 Darck: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_HALOSLIME ; id 657 HaloSlime: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_GOLDSLIME ; id 658 GoldSlime: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_GRANSLIME ; id 659 GranSlime: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_WONDEREGG ; id 660 WonderEgg: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_ORLIGON ; id 661 Orligon: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_GIGADRACO ; id 662 GigaDraco: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_DARKHORN ; id 663 DarkHorn: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_GORAGO ; id 664 Gorago: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_RAINHAWK ; id 665 RainHawk: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_AZURILE ; id 666 Azurile: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_SHANTAK ; id 667 Shantak: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_WATABOU ; id 668 Watabou: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_WARUBOU ; id 669 Warubou: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_EGDRACIL ; id 670 Egdracil: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_DIGSTER ; id 671 Digster: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_SKULARACH ; id 672 Skularach: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_TITANIS ; id 673 Titanis: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_LAMPGENIE ; id 674 LampGenie: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_NITERICH ; id 675 Niterich: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_WHITEKING ; id 676 WhiteKing: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_LAZAMANUS ; id 677 Lazamanus: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_GOLDGOLEM ; id 678 GoldGolem: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_DARKMATE ; id 679 DarkMate: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_OCTOGON ; id 680 Octogon: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_OCTORAID ; id 681 Octoraid: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_GRAKOS ; id 682 Grakos: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_POSEIDON ; id 683 Poseidon: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $00 ; join-chance class
    db $0a ; level
    dw 100 ; base HP
    dw 100 ; base MP
    dw 100 ; base ATK
    dw 100 ; base DEF
    dw 100 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_SLIME ; id 684 Slime: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 65535 ; EXP
    db $07 ; join-chance class
    db $01 ; level
    dw 1 ; base HP
    dw 1 ; base MP
    dw 1 ; base ATK
    dw 1 ; base DEF
    dw 1 ; base AGL
    dw 1 ; base INT
    db $01 ; personality axis $6F
    db $01 ; personality axis $70
    db $01 ; byte 24 ($71)
    db $01 ; personality axis $72

; Far-called by BeginStringDisplay_BankE0 when wStringCategory is 1 or more: decrements
; wStringCategory and starts string wStringIndex of that category from the category table in this
; bank (DE) with BeginStringDisplay. The 7 bytes after its ret (call to itself, call $2611, ret)
; have no read caller. (C1, E-0371)
BeginStringDisplay_BankE0_FromBankA2Table::
    ld de, StaffRollStringCategories
    ld a, [wStringCategory]
    sub $01
    ld [wStringCategory], a
    call BeginStringDisplay
    ret
    db $cd, $e2, $49, $cd, $11, $26, $c9

; Two words, StaffRollNameStrings and StaffRollTitleStrings: the string table that
; BeginStringDisplay_BankE0_FromBankA2Table passes in DE. wStringCategory is lowered by 1 before the
; call, so categories 1 and 2 select the first and second list, and wStringIndex then selects a
; string inside the list. (C1, E-0381)
; string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word
; wStringCategory, then word wStringIndex of that list (E-0217)
; record: string list
StaffRollStringCategories::
    dw StaffRollNameStrings ; id 0
    dw StaffRollTitleStrings ; id 1

; Category 0 of StaffRollStringCategories (bank-$E0 string category 1): 33 string pointers,
; String_A2_00_00 to String_A2_00_20, the staff credit names (one to six centred lines each, joined
; by <LINE>), with ids 5, $0F and $20 an empty string (a lone end byte) and id $1F the copyright
; lines. DebugStaffRoll_Credits_ShowLines takes the category and id from its WorkBufSequenceTable
; list and shows the string with ShowString_BankE0. (C1, E-0373)
; category list of StaffRollStringCategories; one pointer per wStringIndex (E-0217)
; record: string
StaffRollNameStrings::
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

; Category 1 of StaffRollStringCategories (bank-$E0 string category 2): one pointer,
; String_A2_01_00, 'DRAGON WARRIOR' and 'MONSTERS 2' on two lines, shown by
; DebugStaffRoll_Credits_TitleCard (wStringCategory = 2). (C1, E-0373)
StaffRollTitleStrings::
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
