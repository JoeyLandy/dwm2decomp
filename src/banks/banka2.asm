SECTION "Bank A2", ROMX[$4000], BANK[$A2]
    db $A2

; HL = $4056 + 26 * (monster id - $250 + 1) + C; copies hFFC6 bytes from HL to DE (E-0121)
; 1 call site from 1 routine (e.g. CopyMonsterTableBytesFromMonsterTable)
; reads: wMonsterId, hTemp0
CopyMonsterTableBytesFrom4056::
Func_0A2_4001:: ; address name
    push de
    push bc
    ld a, [wMonsterId]
    ld c, a
    ld a, [wMonsterId + $1]
    ld b, a
    ld a, c
    sub a, $50
    ld c, a
    ld a, b
    sbc a, $02
    ld b, a
    inc bc
    ld a, $1A
    call Multiply8By16
    ld a, l
    add a, $56
    ld l, a
    ld a, h
    adc a, $40
    ld h, a
    pop bc
    ld b, $00
    add hl, bc
    ldh a, [hTemp0]
    ld b, a
    pop de
    call CopyBytesDEFromHL_BankA2
    ret

; only called from LoadMonsterRecordTo (E-0047)
; 1 call site from 1 routine (e.g. LoadMonsterRecordTo)
; reads: wMonsterId
LoadMonsterRecordTo_Sub01::
Func_0A2_402D:: ; address name
    push de
    ld a, [wMonsterId]
    ld c, a
    ld a, [wMonsterId + $1]
    ld b, a
    ld a, c
    sub a, $50
    ld c, a
    ld a, b
    sbc a, $02
    ld b, a
    inc bc
    ld a, $1A
    call Multiply8By16
    ld a, l
    add a, $56
    ld l, a
    ld a, h
    adc a, $40
    ld h, a
    pop de
    ld b, $1A

; the same 7 bytes as CopyBytesDEFromHL (34:406E)
; 1 call site from 1 routine (e.g. CopyMonsterTableBytesFrom4056)
CopyBytesDEFromHL_BankA2::
Func_0A2_404F:: ; address name
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, CopyBytesDEFromHL_BankA2
    ret
    db $00, $00, $FF, $FF, $FF, $FF
    ds $14, $00

; E-0240 (C1: CopyMonsterTableBytesFrom4056 and LoadMonsterRecordTo_Sub01 read the 26-byte record at $4056 + 26 * (monster id - $250 + 1) for ids at or above $250 (E-0033), so id $250 starts at $4070; 93 records up to the code at $49E2, the same layout as MonsterTable).
; record: picture number: index into MonsterPictureTable, MonsterAttributeMapTable and MonsterPaletteTable (at most $0179; ids 1, 2, 3 = Slime, SpotSlime, CactiBall use pictures 10, 2, 145); skill id 1 (SkillTable index, $FF = none); skill id 2; skill id 3; skill id 4; 16-bit value, up to $E8EE (meaning not established); byte 8, values 0-7; byte 9, values 0-99; base HP; base MP; base ATK; base DEF; base AGL; base INT; byte 22: personality axis copied to save-record offset $6F (graded with weight 9 by PersonalityIndexOfRecord); byte 23: personality axis copied to offset $70 (weight 1); byte 24: copied to offset $71 (not used by PersonalityIndexOfRecord); byte 25: personality axis copied to offset $72 (weight 3)
MonsterTableA2::
Data_0A2_4070:: ; address name
    db $18, $00, $3C, $7C, $83, $95, $EE, $D9, $06, $55, $E8, $01, $9D, $00, $11, $02, $E7, $03, $F5, $01, $13, $03, $46, $BE, $C8, $96 ; id 592 GoldSlime
    db $40, $00, $3F, $6A, $88, $9A, $A8, $9B, $06, $57, $19, $03, $52, $00, $C6, $02, $D0, $02, $03, $02, $E3, $02, $AA, $BE, $96, $96 ; id 593 Divinegon
    db $60, $00, $37, $5D, $90, $A0, $E1, $86, $06, $56, $46, $03, $47, $01, $A5, $02, $AE, $01, $FE, $01, $E4, $02, $C8, $B4, $96, $96 ; id 594 KingLeo
    db $81, $00, $13, $3E, $66, $81, $59, $7E, $06, $58, $EF, $02, $6F, $00, $87, $02, $6C, $02, $1A, $02, $CF, $02, $82, $C8, $78, $96 ; id 595 RainHawk
    db $A2, $00, $28, $47, $67, $71, $73, $8B, $06, $5C, $19, $03, $80, $00, $9F, $02, $41, $02, $FA, $01, $14, $03, $50, $6E, $C8, $96 ; id 596 Rosevine
    db $C6, $00, $31, $60, $6C, $9C, $F1, $85, $06, $5B, $D9, $02, $08, $02, $66, $02, $80, $02, $30, $02, $EC, $02, $8C, $8C, $AA, $96 ; id 597 Armorpion
    db $EE, $00, $35, $66, $80, $88, $8D, $B7, $06, $5D, $00, $03, $18, $02, $DD, $02, $17, $02, $40, $02, $FC, $02, $C8, $1E, $C8, $96 ; id 598 Durran
    db $56, $01, $4D, $82, $91, $94, $A4, $9C, $06, $5C, $22, $03, $10, $01, $B1, $02, $10, $02, $1A, $02, $DE, $02, $5A, $C8, $C8, $96 ; id 599 Aquadon
    db $A4, $00, $1D, $83, $FF, $FF, $00, $00, $00, $32, $AC, $01, $4C, $02, $8F, $01, $B0, $01, $6A, $01, $A6, $01, $96, $96, $96, $64 ; id 600 Warubou
    db $A4, $00, $1B, $A3, $FF, $FF, $00, $00, $00, $28, $41, $01, $78, $01, $08, $01, $3F, $01, $17, $01, $5D, $01, $C8, $32, $32, $96 ; id 601 Warubou
    db $0A, $01, $50, $51, $52, $FF, $00, $00, $00, $2B, $55, $01, $35, $01, $5D, $01, $3D, $01, $0B, $01, $91, $01, $78, $82, $5A, $64 ; id 602 Skeletor
    db $33, $01, $6F, $81, $91, $FF, $00, $00, $00, $36, $D3, $01, $BA, $01, $AC, $01, $78, $01, $4B, $01, $E0, $01, $78, $A0, $82, $64 ; id 603 StoneMan
    db $80, $00, $79, $7B, $92, $FF, $00, $00, $00, $2E, $74, $01, $5F, $01, $69, $01, $47, $01, $CB, $01, $B1, $01, $64, $96, $82, $64 ; id 604 FunkyBird
    db $0D, $01, $3A, $3B, $A0, $FF, $00, $00, $00, $35, $73, $01, $46, $02, $F8, $00, $A1, $01, $CA, $01, $F4, $01, $14, $C8, $B4, $64 ; id 605 Copycat
    db $33, $00, $19, $82, $9C, $FF, $00, $00, $00, $3B, $F6, $01, $47, $01, $AD, $01, $BF, $01, $E9, $01, $AB, $01, $B4, $8C, $8C, $64 ; id 606 Andreal
    db $2C, $00, $47, $5E, $8C, $FF, $00, $00, $07, $28, $E0, $01, $D2, $00, $B0, $01, $A5, $02, $0E, $01, $F4, $01, $64, $28, $6E, $96 ; id 607 Drygon
    db $1B, $00, $0F, $3B, $83, $FF, $28, $00, $07, $00, $F3, $02, $42, $01, $23, $02, $EE, $00, $84, $02, $F4, $01, $C8, $C8, $C8, $96 ; id 608 Butch
    db $5A, $01, $0F, $37, $7C, $FF, $00, $00, $07, $28, $20, $03, $84, $01, $EE, $00, $FF, $00, $4A, $01, $F4, $01, $50, $96, $96, $96 ; id 609 Pumpoise
    db $61, $01, $6B, $80, $9D, $FF, $00, $00, $07, $46, $E7, $03, $2C, $01, $58, $02, $FA, $00, $18, $01, $E7, $03, $FA, $C8, $C8, $C8 ; id 610 LordDraco
    db $DF, $00, $0D, $6C, $82, $FF, $00, $00, $00, $01, $32, $00, $19, $00, $28, $00, $1E, $00, $1E, $00, $50, $00, $FA, $C8, $C8, $64 ; id 611 Lionex
    db $7F, $00, $48, $92, $9C, $FF, $00, $00, $00, $01, $1E, $00, $32, $00, $1E, $00, $23, $00, $28, $00, $64, $00, $64, $96, $C8, $64 ; id 612 WhipBird
    db $33, $01, $94, $9D, $FF, $FF, $B5, $1C, $05, $2A, $56, $01, $01, $01, $F8, $00, $C5, $00, $DC, $00, $FA, $00, $96, $14, $46, $64 ; id 613 StoneMan
    db $07, $01, $FF, $FF, $FF, $FF, $00, $00, $00, $01, $78, $00, $5E, $00, $71, $00, $5B, $00, $52, $00, $69, $00, $1E, $14, $0F, $64 ; id 614 DeadNoble
    db $17, $00, $1A, $3F, $81, $92, $D4, $C6, $06, $54, $42, $01, $61, $00, $7A, $01, $E7, $03, $FD, $01, $86, $02, $1E, $64, $5A, $96 ; id 615 MetalKing
    db $3F, $00, $49, $61, $8A, $9D, $01, $60, $06, $53, $DE, $02, $D1, $00, $58, $02, $A9, $01, $F1, $01, $3D, $02, $6E, $6E, $6E, $96 ; id 616 Serpentia
    db $52, $00, $03, $31, $5E, $8C, $CF, $53, $06, $53, $88, $02, $AC, $01, $A3, $01, $6B, $02, $57, $01, $7A, $02, $64, $78, $64, $96 ; id 617 IronTurt
    db $7D, $00, $1D, $51, $66, $8C, $7B, $60, $06, $55, $75, $02, $93, $00, $73, $02, $D8, $01, $41, $02, $A7, $02, $5A, $14, $64, $96 ; id 618 ZapBird
    db $A7, $00, $09, $4F, $72, $A3, $7F, $57, $06, $56, $D8, $02, $A7, $00, $59, $02, $F1, $01, $99, $01, $87, $02, $C8, $C8, $1E, $96 ; id 619 FooHero
    db $E0, $00, $0C, $64, $91, $98, $AD, $5B, $06, $55, $74, $02, $5C, $01, $73, $02, $08, $02, $41, $02, $A7, $02, $5A, $14, $64, $96 ; id 620 GoatHorn
    db $04, $01, $59, $68, $71, $77, $41, $66, $06, $56, $89, $02, $9E, $00, $38, $02, $CD, $01, $BE, $01, $08, $02, $1E, $1E, $1E, $96 ; id 621 Inverzon
    db $23, $01, $21, $22, $23, $74, $AE, $68, $06, $57, $9A, $02, $4E, $01, $26, $02, $06, $02, $A1, $01, $B0, $02, $0A, $0A, $0A, $96 ; id 622 Voodoll
    db $51, $01, $06, $65, $6C, $94, $12, $87, $06, $56, $2B, $03, $E9, $00, $BD, $02, $F2, $01, $AB, $01, $0A, $02, $C8, $78, $C8, $96 ; id 623 AxeShark
    db $54, $01, $2D, $3F, $56, $7E, $4D, $96, $06, $58, $E7, $02, $84, $00, $60, $02, $C4, $01, $97, $01, $0A, $02, $14, $C8, $C8, $96 ; id 624 Digong
    db $2B, $00, $1F, $24, $4A, $5D, $E9, $85, $06, $55, $E8, $01, $48, $00, $56, $02, $08, $02, $F5, $01, $6D, $02, $FA, $3C, $1E, $96 ; id 625 Swordgon
    db $42, $00, $34, $47, $5A, $A1, $3C, $A0, $06, $57, $19, $03, $55, $00, $CB, $02, $E9, $01, $47, $01, $5A, $02, $32, $28, $0A, $96 ; id 626 GigaDraco
    db $51, $00, $7B, $7C, $84, $92, $E1, $86, $06, $57, $7E, $02, $62, $00, $FD, $01, $93, $01, $F9, $01, $E4, $02, $C8, $78, $C8, $96 ; id 627 SuperTen
    db $75, $00, $19, $33, $4B, $58, $59, $7E, $06, $58, $6B, $02, $72, $00, $00, $02, $C0, $01, $1A, $02, $1B, $02, $28, $C8, $28, $96 ; id 628 BigRoost
    db $A1, $00, $14, $30, $55, $75, $43, $7A, $06, $5C, $DD, $02, $3A, $00, $0A, $02, $A2, $01, $92, $01, $61, $02, $1E, $A0, $0A, $96 ; id 629 GhosTree
    db $C3, $00, $2C, $5E, $67, $7F, $F1, $85, $06, $5B, $4D, $02, $8F, $00, $4C, $02, $DB, $01, $97, $01, $A1, $02, $C8, $C8, $28, $96 ; id 630 WarMantis
    db $0B, $00, $16, $FF, $FF, $FF, $69, $00, $01, $08, $1F, $00, $09, $00, $15, $00, $14, $00, $12, $00, $5B, $00, $14, $46, $46, $64 ; id 631 Healer
    db $7E, $01, $3B, $3C, $85, $FF, $00, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $BC, $02, $64, $00, $C8, $32, $96, $C8 ; id 632 Kagebou
    db $7D, $01, $3D, $3F, $43, $FF, $00, $00, $00, $01, $0A, $00, $0A, $00, $BC, $02, $0A, $00, $0A, $00, $0A, $00, $C8, $C8, $96, $C8 ; id 633 Dimensaur
    db $7C, $01, $19, $1B, $1E, $FF, $00, $00, $00, $32, $F4, $01, $BC, $02, $F4, $01, $BC, $02, $58, $02, $58, $02, $64, $FA, $C8, $C8 ; id 634 Lamia
    db $5F, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 635 DracoLord
    db $60, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 636 DracoLord
    db $61, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 637 LordDraco
    db $62, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 638 Hargon
    db $63, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 639 Sidoh
    db $64, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 640 Genosidoh
    db $65, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 641 Baramos
    db $66, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 642 Zoma
    db $67, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $19, $C8 ; id 643 AsuraZoma
    db $68, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 644 Pizzaro
    db $69, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 645 PsychoPiz
    db $6A, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 646 Esterk
    db $6B, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 647 Mirudraas
    db $6C, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 648 Mirudraas
    db $6D, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 649 Mudou
    db $6E, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 650 DeathMore
    db $6F, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 651 DeathMore
    db $70, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 652 DeathMore
    db $71, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 653 Darkdrium
    db $72, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 654 Orgodemir
    db $73, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 655 Orgodemir
    db $74, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 656 Darck
    db $16, $00, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 657 HaloSlime
    db $18, $00, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 658 GoldSlime
    db $19, $00, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 659 GranSlime
    db $1A, $00, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 660 WonderEgg
    db $41, $00, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 661 Orligon
    db $42, $00, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 662 GigaDraco
    db $61, $00, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 663 DarkHorn
    db $64, $00, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 664 Gorago
    db $81, $00, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 665 RainHawk
    db $82, $00, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 666 Azurile
    db $83, $00, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 667 Shantak
    db $A5, $00, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 668 Watabou
    db $A4, $00, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 669 Warubou
    db $A3, $00, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 670 Egdracil
    db $C7, $00, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 671 Digster
    db $C8, $00, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 672 Skularach
    db $EF, $00, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 673 Titanis
    db $F0, $00, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 674 LampGenie
    db $10, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 675 Niterich
    db $08, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 676 WhiteKing
    db $0C, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 677 Lazamanus
    db $35, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 678 GoldGolem
    db $36, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 679 DarkMate
    db $52, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 680 Octogon
    db $57, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 681 Octoraid
    db $58, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 682 Grakos
    db $59, $01, $FF, $FF, $FF, $FF, $64, $00, $00, $0A, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $64, $00, $FA, $FA, $FA, $C8 ; id 683 Poseidon
    db $0A, $00, $FF, $FF, $FF, $FF, $FF, $FF, $07, $01, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $00, $01, $01, $01, $01 ; id 684 Slime

; only called from BeginStringDisplay_BankE0 (E-0047)
; 1 call site from 1 routine (e.g. BeginStringDisplay_BankE0)
; reads: wStringCategory
; writes: wStringCategory
BeginStringDisplay_BankE0_Sub01::
Func_0A2_49E2:: ; address name
    ld de, StringCategories_A2_49F8
    ld a, [wStringCategory]
    sub a, $01
    ld [wStringCategory], a
    call BeginStringDisplay
    ret
    db $CD, $E2, $49, $CD, $11, $26, $C9

; E-0217 (derived: string table passed in DE to BeginStringDisplay or CopyStringToBuffer; LookupString reads word wStringCategory, then word wStringIndex of that list)
; record: string list
StringCategories_A2_49F8::
Data_0A2_49F8:: ; address name
    dw StringList_A2_49FC ; id 0
    dw StringList_A2_4A3E ; id 1

; E-0217 (derived: category list of StringCategories_A2_49F8; one pointer per wStringIndex)
; record: string
StringList_A2_49FC::
Data_0A2_49FC:: ; address name
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

; E-0217 (derived: category list of StringCategories_A2_49F8; one pointer per wStringIndex)
; record: string
StringList_A2_4A3E::
Data_0A2_4A3E:: ; address name
    dw String_A2_01_00 ; id 0

String_A2_00_00:: ; heuristic: string; C0
Data_0A2_4A40:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "    YUJI HORII", $F0

String_A2_00_01:: ; heuristic: string; C0
Data_0A2_4A4F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "    YUJI HORII", $F1
    db "       ENIX", $F1
    db "       TOSE", $F1
    db "FUMINORI ISHIKAWA", $F0

String_A2_00_02:: ; heuristic: string; C0
Data_0A2_4A88:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  AKIRA TORIYAMA", $F0

String_A2_00_03:: ; heuristic: string; C0
Data_0A2_4A99:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  KOICHI SUGIYAMA", $F0

String_A2_00_04:: ; heuristic: string; C0
Data_0A2_4AAB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "   NOB OGASAWARA", $F1
    db "   LYNN OGASAWARA", $F1
    db "   KAI OGASAWARA", $F0

String_A2_00_05:: ; heuristic: string; C0
Data_0A2_4ADF:: ; address name
    db $F0

String_A2_00_06:: ; heuristic: string; C0
Data_0A2_4AE0:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  MITSURU G TORII", $F0

String_A2_00_07:: ; heuristic: string; C0
Data_0A2_4AF2:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "   JOHN LAURENCE", $F0

String_A2_00_08:: ; heuristic: string; C0
Data_0A2_4B03:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  JON WEISNEWSKI", $F0

String_A2_00_09:: ; heuristic: string; C0
Data_0A2_4B14:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  MASAKO KOMIYAMA", $F1
    db "   YURIKO MIZUTA", $F1
    db "  MASANOBU YOSHIDA", $F0

String_A2_00_0A:: ; heuristic: string; C0
Data_0A2_4B4A:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "   CHRIS CHYMIY", $F1
    db "   SHAWN CONARD", $F1
    db "    TJ COWGILL", $F1
    db "    JOHN HOLES", $F1
    db "  JERRY PRITCHARD", $F1
    db "   AARON SCHMITT", $F0

String_A2_00_0B:: ; heuristic: string; C0
Data_0A2_4BAB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "   ANDREW STEIN", $F0

String_A2_00_0C:: ; heuristic: string; C0
Data_0A2_4BBB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  MISUZU MCMILLAN", $F0

String_A2_00_0D:: ; heuristic: string; C0
Data_0A2_4BCD:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "     YURI KATO", $F0

String_A2_00_0E:: ; heuristic: string; C0
Data_0A2_4BDC:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  PAUL HANDELMAN", $F0

String_A2_00_0F:: ; heuristic: string; C0
Data_0A2_4BED:: ; address name
    db $F0

String_A2_00_10:: ; heuristic: string; C0
Data_0A2_4BEE:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "    NAOKI OISHI", $F1
    db " TAKASHI KAMIMURA", $F0

String_A2_00_11:: ; heuristic: string; C0
Data_0A2_4C10:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "   KENJIRO KANO", $F1
    db "   TOMOYUKI IWAI", $F1
    db "  NORIKO NAKANONE", $F1
    db "  KAZUNORI OHWADA", $F0

String_A2_00_12:: ; heuristic: string; C0
Data_0A2_4C55:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "   HIROSHI SATO", $F1
    db "  HIDEKI YONEYAMA", $F0

String_A2_00_13:: ; heuristic: string; C0
Data_0A2_4C77:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " TAKATOSHI AKIYAMA", $F1
    db " SEIICHI MORIUCHI", $F1
    db "  SHINOBU NONAKA", $F1
    db " SATOSHI FUKUSHIMA", $F1
    db "     YUMI TOGO", $F0

String_A2_00_14:: ; heuristic: string; C0
Data_0A2_4CCF:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  HIDEYUKI NUKUI", $F1
    db "  HIROSHI KONDOU", $F1
    db "   BIN KANAZAWA", $F1
    db "  KAZUHIRO NOMURA", $F1
    db "   TOMOE SUZUKI", $F0

String_A2_00_15:: ; heuristic: string; C0
Data_0A2_4D23:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "     KAN IKEDA", $F1
    db "   YOUKO KAGAYA", $F1
    db "   EMI NARIKIYO", $F1
    db "     MIKA ENDO", $F1
    db "   SAKIKO IKEDA", $F0

String_A2_00_16:: ; heuristic: string; C0
Data_0A2_4D71:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  TETUYA FUJIMOTO", $F1
    db "  MINORU KAKIZAWA", $F1
    db "  YASUHITO SUZUKI", $F1
    db "    NAOMI OZAWA", $F1
    db "    KOJI NUMATA", $F0

String_A2_00_17:: ; heuristic: string; C0
Data_0A2_4DC7:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  ATUSHI TAKEUCHI", $F1
    db "   TOMOHIRO ASO", $F1
    db " KENSUKE YOKOYAMA", $F1
    db " KENICHI YAMAMOTO", $F1
    db " TEPPEI KOBAYASHI", $F0

String_A2_00_18:: ; heuristic: string; C0
Data_0A2_4E1F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "    JIRO KIMURA", $F1
    db "  YASUNORI HOSONO", $F1
    db " KENTAKA NAKASHIMA", $F1
    db "    RYO YONAGA", $F1
    db "   SHINGO NOGUKI", $F0

String_A2_00_19:: ; heuristic: string; C0
Data_0A2_4E74:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  YUJIRO KUMAKURA", $F1
    db "    NAOKI SIRAI", $F1
    db "     RIE IWAO", $F1
    db " KATUHIKO YOKOYAMA", $F1
    db " RYUICHI NAKASHIMA", $F0

String_A2_00_1A:: ; heuristic: string; C0
Data_0A2_4ECA:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "   MASASHI KONNO", $F1
    db " MIKIHIRO HAYASHI", $F1
    db "  MIHO SHIBASAKI", $F1
    db "   MASAYUKI TADA", $F1
    db "    KAYO NAKATA", $F0

String_A2_00_1B:: ; heuristic: string; C0
Data_0A2_4F1F:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "   NAOYA MATSUDA", $F1
    db " YOSHITO TANIUCHI", $F0

String_A2_00_1C:: ; heuristic: string; C0
Data_0A2_4F42:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  TAICHI INUZUKA", $F0

String_A2_00_1D:: ; heuristic: string; C0
Data_0A2_4F53:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "  YUKINOBU CHIDA", $F1
    db "   KOUJI TAGUCHI", $F0

String_A2_00_1E:: ; heuristic: string; C0
Data_0A2_4F75:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "    KEIJI HONDA", $F0

String_A2_00_1F:: ; heuristic: string; C0
Data_0A2_4F85:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db " ", $B8, "2001", $F1
    db "  ARMOR PROJECT", $F1
    db " ", $B8, "2001", $F1
    db "  BIRD STUDIO", $F1
    db " ", $B8, "2001", $F1
    db "  KOICHI SUGIYAMA", $F1

String_A2_00_20:: ; heuristic: string; C0
Data_0A2_4FCA:: ; address name
    db $F0

String_A2_01_00:: ; heuristic: string; C0
Data_0A2_4FCB:: ; address name
; text (E-0024): characters via charmap.inc; $XX bytes are control or glyph codes of unknown meaning
    db "DRAGON WARRIOR", $F1
    db "  MONSTERS 2", $F0
    ds $3019, $00
