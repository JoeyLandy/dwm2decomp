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
    db $18, $00, $3c, $7c, $83, $95, $ee, $d9, $06, $55, $e8, $01, $9d, $00, $11, $02, $e7, $03, $f5, $01, $13, $03, $46, $be, $c8, $96 ; id 592 GoldSlime
    db $40, $00, $3f, $6a, $88, $9a, $a8, $9b, $06, $57, $19, $03, $52, $00, $c6, $02, $d0, $02, $03, $02, $e3, $02, $aa, $be, $96, $96 ; id 593 Divinegon
    db $60, $00, $37, $5d, $90, $a0, $e1, $86, $06, $56, $46, $03, $47, $01, $a5, $02, $ae, $01, $fe, $01, $e4, $02, $c8, $b4, $96, $96 ; id 594 KingLeo
    db $81, $00, $13, $3e, $66, $81, $59, $7e, $06, $58, $ef, $02, $6f, $00, $87, $02, $6c, $02, $1a, $02, $cf, $02, $82, $c8, $78, $96 ; id 595 RainHawk
    db $a2, $00, $28, $47, $67, $71, $73, $8b, $06, $5c, $19, $03, $80, $00, $9f, $02, $41, $02, $fa, $01, $14, $03, $50, $6e, $c8, $96 ; id 596 Rosevine
    db $c6, $00, $31, $60, $6c, $9c, $f1, $85, $06, $5b, $d9, $02, $08, $02, $66, $02, $80, $02, $30, $02, $ec, $02, $8c, $8c, $aa, $96 ; id 597 Armorpion
    db $ee, $00, $35, $66, $80, $88, $8d, $b7, $06, $5d, $00, $03, $18, $02, $dd, $02, $17, $02, $40, $02, $fc, $02, $c8, $1e, $c8, $96 ; id 598 Durran
    db $56, $01, $4d, $82, $91, $94, $a4, $9c, $06, $5c, $22, $03, $10, $01, $b1, $02, $10, $02, $1a, $02, $de, $02, $5a, $c8, $c8, $96 ; id 599 Aquadon
    db $a4, $00, $1d, $83, $ff, $ff, $00, $00, $00, $32, $ac, $01, $4c, $02, $8f, $01, $b0, $01, $6a, $01, $a6, $01, $96, $96, $96, $64 ; id 600 Warubou
    db $a4, $00, $1b, $a3, $ff, $ff, $00, $00, $00, $28, $41, $01, $78, $01, $08, $01, $3f, $01, $17, $01, $5d, $01, $c8, $32, $32, $96 ; id 601 Warubou
    db $0a, $01, $50, $51, $52, $ff, $00, $00, $00, $2b, $55, $01, $35, $01, $5d, $01, $3d, $01, $0b, $01, $91, $01, $78, $82, $5a, $64 ; id 602 Skeletor
    db $33, $01, $6f, $81, $91, $ff, $00, $00, $00, $36, $d3, $01, $ba, $01, $ac, $01, $78, $01, $4b, $01, $e0, $01, $78, $a0, $82, $64 ; id 603 StoneMan
    db $80, $00, $79, $7b, $92, $ff, $00, $00, $00, $2e, $74, $01, $5f, $01, $69, $01, $47, $01, $cb, $01, $b1, $01, $64, $96, $82, $64 ; id 604 FunkyBird
    db $0d, $01, $3a, $3b, $a0, $ff, $00, $00, $00, $35, $73, $01, $46, $02, $f8, $00, $a1, $01, $ca, $01, $f4, $01, $14, $c8, $b4, $64 ; id 605 Copycat
    db $33, $00, $19, $82, $9c, $ff, $00, $00, $00, $3b, $f6, $01, $47, $01, $ad, $01, $bf, $01, $e9, $01, $ab, $01, $b4, $8c, $8c, $64 ; id 606 Andreal
    db $2c, $00, $47, $5e, $8c, $ff, $00, $00, $07, $28, $e0, $01, $d2, $00, $b0, $01, $a5, $02, $0e, $01, $f4, $01, $64, $28, $6e, $96 ; id 607 Drygon
    db $1b, $00, $0f, $3b, $83, $ff, $28, $00, $07, $00, $f3, $02, $42, $01, $23, $02, $ee, $00, $84, $02, $f4, $01, $c8, $c8, $c8, $96 ; id 608 Butch
    db $5a, $01, $0f, $37, $7c, $ff, $00, $00, $07, $28, $20, $03, $84, $01, $ee, $00, $ff, $00, $4a, $01, $f4, $01, $50, $96, $96, $96 ; id 609 Pumpoise
    db $61, $01, $6b, $80, $9d, $ff, $00, $00, $07, $46, $e7, $03, $2c, $01, $58, $02, $fa, $00, $18, $01, $e7, $03, $fa, $c8, $c8, $c8 ; id 610 LordDraco
    db $df, $00, $0d, $6c, $82, $ff, $00, $00, $00, $01, $32, $00, $19, $00, $28, $00, $1e, $00, $1e, $00, $50, $00, $fa, $c8, $c8, $64 ; id 611 Lionex
    db $7f, $00, $48, $92, $9c, $ff, $00, $00, $00, $01, $1e, $00, $32, $00, $1e, $00, $23, $00, $28, $00, $64, $00, $64, $96, $c8, $64 ; id 612 WhipBird
    db $33, $01, $94, $9d, $ff, $ff, $b5, $1c, $05, $2a, $56, $01, $01, $01, $f8, $00, $c5, $00, $dc, $00, $fa, $00, $96, $14, $46, $64 ; id 613 StoneMan
    db $07, $01, $ff, $ff, $ff, $ff, $00, $00, $00, $01, $78, $00, $5e, $00, $71, $00, $5b, $00, $52, $00, $69, $00, $1e, $14, $0f, $64 ; id 614 DeadNoble
    db $17, $00, $1a, $3f, $81, $92, $d4, $c6, $06, $54, $42, $01, $61, $00, $7a, $01, $e7, $03, $fd, $01, $86, $02, $1e, $64, $5a, $96 ; id 615 MetalKing
    db $3f, $00, $49, $61, $8a, $9d, $01, $60, $06, $53, $de, $02, $d1, $00, $58, $02, $a9, $01, $f1, $01, $3d, $02, $6e, $6e, $6e, $96 ; id 616 Serpentia
    db $52, $00, $03, $31, $5e, $8c, $cf, $53, $06, $53, $88, $02, $ac, $01, $a3, $01, $6b, $02, $57, $01, $7a, $02, $64, $78, $64, $96 ; id 617 IronTurt
    db $7d, $00, $1d, $51, $66, $8c, $7b, $60, $06, $55, $75, $02, $93, $00, $73, $02, $d8, $01, $41, $02, $a7, $02, $5a, $14, $64, $96 ; id 618 ZapBird
    db $a7, $00, $09, $4f, $72, $a3, $7f, $57, $06, $56, $d8, $02, $a7, $00, $59, $02, $f1, $01, $99, $01, $87, $02, $c8, $c8, $1e, $96 ; id 619 FooHero
    db $e0, $00, $0c, $64, $91, $98, $ad, $5b, $06, $55, $74, $02, $5c, $01, $73, $02, $08, $02, $41, $02, $a7, $02, $5a, $14, $64, $96 ; id 620 GoatHorn
    db $04, $01, $59, $68, $71, $77, $41, $66, $06, $56, $89, $02, $9e, $00, $38, $02, $cd, $01, $be, $01, $08, $02, $1e, $1e, $1e, $96 ; id 621 Inverzon
    db $23, $01, $21, $22, $23, $74, $ae, $68, $06, $57, $9a, $02, $4e, $01, $26, $02, $06, $02, $a1, $01, $b0, $02, $0a, $0a, $0a, $96 ; id 622 Voodoll
    db $51, $01, $06, $65, $6c, $94, $12, $87, $06, $56, $2b, $03, $e9, $00, $bd, $02, $f2, $01, $ab, $01, $0a, $02, $c8, $78, $c8, $96 ; id 623 AxeShark
    db $54, $01, $2d, $3f, $56, $7e, $4d, $96, $06, $58, $e7, $02, $84, $00, $60, $02, $c4, $01, $97, $01, $0a, $02, $14, $c8, $c8, $96 ; id 624 Digong
    db $2b, $00, $1f, $24, $4a, $5d, $e9, $85, $06, $55, $e8, $01, $48, $00, $56, $02, $08, $02, $f5, $01, $6d, $02, $fa, $3c, $1e, $96 ; id 625 Swordgon
    db $42, $00, $34, $47, $5a, $a1, $3c, $a0, $06, $57, $19, $03, $55, $00, $cb, $02, $e9, $01, $47, $01, $5a, $02, $32, $28, $0a, $96 ; id 626 GigaDraco
    db $51, $00, $7b, $7c, $84, $92, $e1, $86, $06, $57, $7e, $02, $62, $00, $fd, $01, $93, $01, $f9, $01, $e4, $02, $c8, $78, $c8, $96 ; id 627 SuperTen
    db $75, $00, $19, $33, $4b, $58, $59, $7e, $06, $58, $6b, $02, $72, $00, $00, $02, $c0, $01, $1a, $02, $1b, $02, $28, $c8, $28, $96 ; id 628 BigRoost
    db $a1, $00, $14, $30, $55, $75, $43, $7a, $06, $5c, $dd, $02, $3a, $00, $0a, $02, $a2, $01, $92, $01, $61, $02, $1e, $a0, $0a, $96 ; id 629 GhosTree
    db $c3, $00, $2c, $5e, $67, $7f, $f1, $85, $06, $5b, $4d, $02, $8f, $00, $4c, $02, $db, $01, $97, $01, $a1, $02, $c8, $c8, $28, $96 ; id 630 WarMantis
    db $0b, $00, $16, $ff, $ff, $ff, $69, $00, $01, $08, $1f, $00, $09, $00, $15, $00, $14, $00, $12, $00, $5b, $00, $14, $46, $46, $64 ; id 631 Healer
    db $7e, $01, $3b, $3c, $85, $ff, $00, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $bc, $02, $64, $00, $c8, $32, $96, $c8 ; id 632 Kagebou
    db $7d, $01, $3d, $3f, $43, $ff, $00, $00, $00, $01, $0a, $00, $0a, $00, $bc, $02, $0a, $00, $0a, $00, $0a, $00, $c8, $c8, $96, $c8 ; id 633 Dimensaur
    db $7c, $01, $19, $1b, $1e, $ff, $00, $00, $00, $32, $f4, $01, $bc, $02, $f4, $01, $bc, $02, $58, $02, $58, $02, $64, $fa, $c8, $c8 ; id 634 Lamia
    db $5f, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 635 DracoLord
    db $60, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 636 DracoLord
    db $61, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 637 LordDraco
    db $62, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 638 Hargon
    db $63, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 639 Sidoh
    db $64, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 640 Genosidoh
    db $65, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 641 Baramos
    db $66, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 642 Zoma
    db $67, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $19, $c8 ; id 643 AsuraZoma
    db $68, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 644 Pizzaro
    db $69, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 645 PsychoPiz
    db $6a, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 646 Esterk
    db $6b, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 647 Mirudraas
    db $6c, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 648 Mirudraas
    db $6d, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 649 Mudou
    db $6e, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 650 DeathMore
    db $6f, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 651 DeathMore
    db $70, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 652 DeathMore
    db $71, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 653 Darkdrium
    db $72, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 654 Orgodemir
    db $73, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 655 Orgodemir
    db $74, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 656 Darck
    db $16, $00, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 657 HaloSlime
    db $18, $00, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 658 GoldSlime
    db $19, $00, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 659 GranSlime
    db $1a, $00, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 660 WonderEgg
    db $41, $00, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 661 Orligon
    db $42, $00, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 662 GigaDraco
    db $61, $00, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 663 DarkHorn
    db $64, $00, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 664 Gorago
    db $81, $00, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 665 RainHawk
    db $82, $00, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 666 Azurile
    db $83, $00, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 667 Shantak
    db $a5, $00, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 668 Watabou
    db $a4, $00, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 669 Warubou
    db $a3, $00, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 670 Egdracil
    db $c7, $00, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 671 Digster
    db $c8, $00, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 672 Skularach
    db $ef, $00, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 673 Titanis
    db $f0, $00, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 674 LampGenie
    db $10, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 675 Niterich
    db $08, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 676 WhiteKing
    db $0c, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 677 Lazamanus
    db $35, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 678 GoldGolem
    db $36, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 679 DarkMate
    db $52, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 680 Octogon
    db $57, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 681 Octoraid
    db $58, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 682 Grakos
    db $59, $01, $ff, $ff, $ff, $ff, $64, $00, $00, $0a, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $fa, $fa, $fa, $c8 ; id 683 Poseidon
    db $0a, $00, $ff, $ff, $ff, $ff, $ff, $ff, $07, $01, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $01, $01, $01 ; id 684 Slime

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
