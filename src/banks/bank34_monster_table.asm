; ROM bank $34: the monster table
; The annotated listing of this bank is build/listing/bank34.asm.

SECTION "Bank 34", ROMX[$4000], BANK[$34]
    db $34

; wMonsterId/wMonsterId + $1 = monster id: copies its 26-byte MonsterTable record to wRecordBuffer
; (ids at or above $250 come from bank $A2 through LoadMonsterRecordTo_Multiply8By16)
LoadMonsterRecord::
    ld de, wRecordBuffer
    call LoadMonsterRecordTo
    ret

; copies hTemp0 bytes of the 26-byte entry of monster wMonsterId/wMonsterId + $1 plus C from $4075
; to DE; ids from $250 use CopyMonsterTableBytesFrom4056 in bank $A2 (E-0125)
CopyMonsterTableBytesFromMonsterTable::
    ld a, [wMonsterId + $1]
    cp $02
    jr c, .read_monster_id
    ld a, [wMonsterId]
    cp $50
    jr c, .read_monster_id
    farcall CopyMonsterTableBytesFrom4056
    ret

.read_monster_id:
    push de
    push bc
    ld a, [wMonsterId]
    ld c, a
    ld a, [wMonsterId + $1]
    ld b, a
    ld a, $1a
    call Multiply8By16
    ld a, l
    add $75
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
    call CopyBytesDEFromHL
    ret

; DE = destination: like LoadMonsterRecord but copies the 26-byte record to [DE]
LoadMonsterRecordTo::
    ld a, [wMonsterId + $1]
    cp $02
    jr c, .read_monster_id
    ld a, [wMonsterId]
    cp $50
    jr c, .read_monster_id
    farcall LoadMonsterRecordTo_Multiply8By16
    ret

.read_monster_id:
    push de
    ld a, [wMonsterId]
    ld c, a
    ld a, [wMonsterId + $1]
    ld b, a
    ld a, $1a
    call Multiply8By16
    ld a, l
    add $75
    ld l, a
    ld a, h
    adc $40
    ld h, a
    pop de
    ld b, $1a

; B bytes from [HL] to [DE]; HL and DE advance
CopyBytesDEFromHL::
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, CopyBytesDEFromHL
    ret

; LoadMonsterRecord copies a 26-byte record from here by 16-bit id (wMonsterId/wMonsterId + $1); ids
; at or above $250 use bank $A2 instead, so this table has 592 records; record 1 holds 25, 0, 10, 7,
; 8, 7 and then $C8 $C8 $64 $C8, exactly the values the opening monster's save record shows for its
; HP, MP, ATK, DEF, AGL, INT and next four bytes; the order of the six stat words is confirmed by
; the pause menu's INFO panel, E-0046). Skill ids stay below 175 (one record, id 88, has $C8 in the
; fourth slot). Bytes 22-25 equal the save record's bytes at offsets $6F-$72 for the opening monster
; (E-0034); the three used by PersonalityIndexOfRecord are the personality axes. The first word is
; the picture number (E-0041): drawing the pictures it names gave a slime for monster 1 ('Slime'),
; another slime for monster 2 ('SpotSlime') and a spiky ball for monster 3 ('CactiBall'); monster
; names are the strings of bank $88 (category = id >> 8, index = id & $FF (E-0033, C1)
; record: picture number: index into MonsterPictureTable, MonsterAttributeMapTable and
; MonsterPaletteTable (at most $0179; ids 1, 2, 3 = Slime, SpotSlime, CactiBall use pictures 10, 2,
; 145); skill id 1 (SkillTable index, $FF = none); skill id 2; skill id 3; skill id 4; EXP, 16 bits
; (copied to battler $18-$19, the low word of a 24-bit EXP; C1, E-0298); join-chance class 0-7
; (battler byte $4D; 7 = never joins; C1, E-0306); level 0-99 (copied to battler $17, BATTLER_LEVEL;
; C1, E-0298); base HP; base MP; base ATK; base DEF; base AGL; base INT; byte 22: personality axis
; copied to save-record offset $6F (graded with weight 9 by PersonalityIndexOfRecord); byte 23:
; personality axis copied to offset $70 (weight 1); byte 24: copied to offset $71 (not used by
; PersonalityIndexOfRecord); byte 25: personality axis copied to offset $72 (weight 3)
MonsterTable::
    db $00, $00 ; id 0
    db $ff
    db $ff
    db $ff
    db $ff
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $0a, $00 ; id 1 Slime
    db $ff
    db $ff
    db $ff
    db $ff
    db $00, $00, $00, $01, $19, $00, $00, $00, $0a, $00, $07, $00, $08, $00, $07, $00, $c8, $c8, $64, $c8
    db $02, $00 ; id 2 SpotSlime
    db $ff
    db $ff
    db $ff
    db $ff
    db $03, $00, $01, $01, $08, $00, $00, $00, $07, $00, $05, $00, $08, $00, $04, $00, $78, $50, $3c, $c8
    db $91, $00 ; id 3 CactiBall
    db $ff
    db $ff
    db $ff
    db $ff
    db $06, $00, $02, $05, $0a, $00, $06, $00, $0b, $00, $04, $00, $0a, $00, $0a, $00, $aa, $46, $1e, $c8
    db $bb, $00 ; id 4 TailEater
    db SKILL_ICESLASH
    db $ff
    db $ff
    db $ff
    db $07, $00, $02, $02, $0c, $00, $08, $00, $0e, $00, $06, $00, $0f, $00, $14, $00, $82, $46, $3c, $c8
    db $39, $00 ; id 5 Crestpent
    db SKILL_STOPSPELL
    db $ff
    db $ff
    db $ff
    db $0a, $00, $02, $03, $0e, $00, $06, $00, $10, $00, $09, $00, $0d, $00, $22, $00, $c8, $3c, $1e, $c8
    db $34, $00 ; id 6 KingCobra
    db SKILL_POISONHIT
    db $ff
    db $ff
    db $ff
    db $11, $00, $03, $01, $12, $00, $08, $00, $14, $00, $0b, $00, $12, $00, $28, $00, $be, $5a, $46, $c8
    db $27, $01 ; id 7 CurseLamp
    db SKILL_UPPER
    db $ff
    db $ff
    db $ff
    db $2c, $01, $00, $05, $dc, $00, $08, $00, $1b, $00, $0a, $00, $2c, $00, $41, $00, $e6, $96, $28, $c8
    db $27, $01 ; id 8 CurseLamp
    db SKILL_UPPER
    db $ff
    db $ff
    db $ff
    db $00, $00, $00, $05, $36, $00, $15, $00, $1b, $00, $1f, $00, $2c, $00, $35, $00, $82, $64, $78, $c8
    db $0a, $00 ; id 9 Slime
    db $ff
    db $ff
    db $ff
    db $ff
    db $09, $00, $02, $04, $1b, $00, $1c, $00, $0d, $00, $09, $00, $1b, $00, $46, $00, $b4, $b4, $50, $96
    db $50, $00 ; id 10 Antbear
    db $ff
    db $ff
    db $ff
    db $ff
    db $1b, $00, $02, $05, $26, $00, $10, $00, $1b, $00, $15, $00, $12, $00, $30, $00, $aa, $d2, $aa, $96
    db $73, $00 ; id 11 Dracky
    db SKILL_SLEEP
    db $ff
    db $ff
    db $ff
    db $15, $00, $02, $04, $15, $00, $23, $00, $1a, $00, $0b, $00, $2a, $00, $48, $00, $fa, $96, $28, $96
    db $a6, $00 ; id 12 Eggplaton
    db SKILL_NAPATTACK
    db SKILL_ODDDANCE
    db $ff
    db $ff
    db $1c, $00, $02, $05, $18, $00, $22, $00, $14, $00, $12, $00, $15, $00, $4f, $00, $78, $5a, $46, $96
    db $19, $01 ; id 13 JewelBag
    db SKILL_FIREBAL
    db SKILL_STOPSPELL
    db $ff
    db $ff
    db $4e, $00, $02, $09, $2e, $00, $29, $00, $24, $00, $28, $00, $5e, $00, $df, $00, $be, $50, $00, $96
    db $ff, $00 ; id 14 Hork
    db SKILL_POISONGAS
    db SKILL_LUSHLICKS
    db $ff
    db $ff
    db $b1, $00, $03, $08, $46, $00, $21, $00, $37, $00, $1b, $00, $31, $00, $64, $00, $dc, $14, $14, $96
    db $6b, $00 ; id 15 Wyvern
    db SKILL_HEAL
    db SKILL_SLEEP
    db $ff
    db $ff
    db $9b, $00, $03, $0d, $3d, $00, $3e, $00, $35, $00, $29, $00, $5f, $00, $9e, $00, $e6, $50, $32, $96
    db $b9, $00 ; id 16 ArmyAnt
    db SKILL_NAPATTACK
    db $ff
    db $ff
    db $ff
    db $1e, $00, $01, $07, $14, $00, $14, $00, $13, $00, $1f, $00, $2f, $00, $3a, $00, $fa, $96, $1e, $96
    db $5a, $00 ; id 17 MadGopher
    db SKILL_ZOMBIECUT
    db $ff
    db $ff
    db $ff
    db $2d, $00, $01, $07, $28, $00, $25, $00, $26, $00, $24, $00, $1d, $00, $56, $00, $c8, $32, $32, $96
    db $dc, $00 ; id 18 1EyeClown
    db SKILL_BLAZE
    db $ff
    db $ff
    db $ff
    db $3a, $00, $03, $07, $1b, $00, $13, $00, $1a, $00, $1d, $00, $33, $00, $9e, $00, $aa, $28, $d2, $96
    db $05, $00 ; id 19 Snaily
    db SKILL_ICEBOLT
    db $ff
    db $ff
    db $ff
    db $7f, $00, $02, $0a, $1d, $00, $29, $00, $1f, $00, $37, $00, $7c, $00, $59, $00, $aa, $78, $50, $96
    db $2a, $00 ; id 20 Poisongon
    db SKILL_POISONHIT
    db $ff
    db $ff
    db $ff
    db $37, $00, $03, $09, $37, $00, $2f, $00, $32, $00, $1f, $00, $24, $00, $4a, $00, $8c, $dc, $14, $96
    db $3d, $01 ; id 21 Moray
    db SKILL_POISONGAS
    db $ff
    db $ff
    db $ff
    db $66, $00, $02, $09, $25, $00, $1f, $00, $1a, $00, $1c, $00, $14, $00, $64, $00, $fa, $14, $28, $96
    db $bd, $00 ; id 22 Eyeder
    db SKILL_FIREBAL
    db $ff
    db $ff
    db $ff
    db $85, $00, $03, $0d, $2a, $00, $1d, $00, $1e, $00, $1f, $00, $3c, $00, $8b, $00, $8c, $3c, $5a, $96
    db $44, $01 ; id 23 PutreFish
    db SKILL_WATERSHOT
    db $ff
    db $ff
    db $ff
    db $63, $00, $03, $09, $27, $00, $19, $00, $1b, $00, $13, $00, $59, $00, $8a, $00, $8c, $14, $aa, $96
    db $49, $01 ; id 24 Gamanian
    db SKILL_NAPATTACK
    db $ff
    db $ff
    db $ff
    db $5d, $00, $03, $09, $25, $00, $20, $00, $23, $00, $1a, $00, $47, $00, $22, $01, $8c, $64, $28, $96
    db $1e, $01 ; id 25 SpikyBoy
    db SKILL_SLIMEBLOW
    db SKILL_HIGHJUMP
    db $ff
    db $ff
    db $6a, $00, $02, $09, $35, $00, $29, $00, $2f, $00, $1f, $00, $3a, $00, $81, $00, $a0, $82, $5a, $96
    db $4f, $01 ; id 26 HoodSquid
    db SKILL_BIATTACK
    db SKILL_LUREDANCE
    db $ff
    db $ff
    db $08, $02, $07, $0c, $5e, $01, $64, $00, $4e, $00, $27, $00, $55, $00, $b4, $00, $d2, $28, $be, $96
    db $4f, $01 ; id 27 HoodSquid
    db SKILL_BIATTACK
    db SKILL_LUREDANCE
    db $ff
    db $ff
    db $00, $00, $00, $0c, $59, $00, $4e, $00, $45, $00, $3c, $00, $55, $00, $b4, $00, $dc, $28, $64, $96
    db $06, $01 ; id 28 CaptDead
    db SKILL_CALLHELP
    db SKILL_AQUACUT
    db SKILL_SQUALLHIT
    db $ff
    db $20, $03, $07, $0d, $f4, $01, $69, $00, $42, $00, $30, $00, $32, $00, $90, $00, $96, $0a, $28, $96
    db $3c, $01 ; id 29 Petiteel
    db SKILL_SPEEDUP
    db SKILL_RAMMING
    db $ff
    db $ff
    db $94, $00, $02, $0c, $3a, $00, $3f, $00, $20, $00, $1c, $00, $59, $00, $85, $00, $c8, $64, $46, $96
    db $f9, $00 ; id 30 RotRaven
    db SKILL_BOLTSLASH
    db $ff
    db $ff
    db $ff
    db $82, $00, $03, $0d, $42, $00, $24, $00, $37, $00, $29, $00, $4d, $00, $77, $00, $82, $50, $46, $96
    db $42, $01 ; id 31 Merman
    db SKILL_SAP
    db $ff
    db $ff
    db $ff
    db $9b, $00, $03, $0b, $36, $00, $2a, $00, $2d, $00, $30, $00, $47, $00, $9c, $00, $96, $28, $aa, $96
    db $43, $01 ; id 32 Octokid
    db SKILL_HEAL
    db SKILL_LUREDANCE
    db $ff
    db $ff
    db $66, $00, $02, $0b, $4d, $00, $5c, $00, $3b, $00, $24, $00, $2e, $00, $c5, $00, $28, $3c, $96, $96
    db $4c, $01 ; id 33 RogueWave
    db SKILL_WATERSHOT
    db SKILL_AQUAWALL
    db $ff
    db $ff
    db $6f, $00, $02, $09, $29, $00, $23, $00, $28, $00, $22, $00, $8d, $00, $cf, $00, $aa, $96, $96, $96
    db $09, $00 ; id 34 PearlGel
    db SKILL_UPPER
    db SKILL_CHARGEUP
    db $ff
    db $ff
    db $59, $00, $02, $09, $25, $00, $20, $00, $1b, $00, $22, $00, $7c, $00, $c8, $00, $a0, $46, $96, $96
    db $25, $00 ; id 35 Tortragon
    db SKILL_MAGICBACK
    db $ff
    db $ff
    db $ff
    db $fe, $00, $03, $0c, $42, $00, $26, $00, $31, $00, $4a, $00, $42, $00, $7b, $00, $c8, $d2, $46, $96
    db $72, $00 ; id 36 AquaHawk
    db SKILL_CURSEOFF
    db SKILL_AQUAWALL
    db $ff
    db $ff
    db $d3, $00, $03, $0d, $2f, $00, $21, $00, $3c, $00, $2c, $00, $52, $00, $5e, $01, $8c, $96, $1e, $96
    db $d7, $00 ; id 37 DarkEye
    db SKILL_CLEANCUT
    db SKILL_RADIANT
    db $ff
    db $ff
    db $e4, $00, $03, $0d, $4a, $00, $45, $00, $30, $00, $29, $00, $41, $00, $97, $00, $c8, $50, $d2, $96
    db $3f, $01 ; id 38 RayGigas
    db SKILL_FIREBAL
    db SKILL_MOUTHSHUT
    db $ff
    db $ff
    db $c7, $00, $03, $0c, $48, $00, $3e, $00, $30, $00, $2a, $00, $50, $00, $89, $00, $78, $82, $8c, $96
    db $1a, $01 ; id 39 EvilWand
    db SKILL_FRIGIDAIR
    db SKILL_MAPMAGIC
    db $ff
    db $ff
    db $bc, $00, $03, $0d, $35, $00, $40, $00, $36, $00, $2a, $00, $46, $00, $cc, $00, $96, $8c, $46, $96
    db $06, $00 ; id 40 SlimeNite
    db SKILL_HEAL
    db SKILL_UPPER
    db SKILL_BEASTCUT
    db $ff
    db $15, $01, $03, $0f, $4a, $00, $2f, $00, $40, $00, $31, $00, $ae, $00, $14, $01, $8c, $78, $a0, $64
    db $29, $00 ; id 41 LizardMan
    db SKILL_AQUACUT
    db SKILL_EVILSLASH
    db $ff
    db $ff
    db $f7, $01, $03, $11, $5d, $00, $35, $00, $4e, $00, $45, $00, $5a, $00, $11, $01, $b4, $64, $1e, $64
    db $54, $00 ; id 42 HammerMan
    db SKILL_CHARGEUP
    db $ff
    db $ff
    db $ff
    db $37, $01, $02, $0f, $50, $00, $37, $00, $41, $00, $32, $00, $5b, $00, $8b, $00, $50, $8c, $64, $64
    db $56, $00 ; id 43 Yeti
    db SKILL_ICEBOLT
    db $ff
    db $ff
    db $ff
    db $2d, $01, $03, $10, $50, $00, $2d, $00, $45, $00, $2d, $00, $40, $00, $85, $00, $be, $50, $c8, $64
    db $e1, $00 ; id 44 Orc
    db SKILL_VIVIFY
    db SKILL_SAP
    db SKILL_BIRDBLOW
    db $ff
    db $4a, $01, $03, $14, $5f, $00, $2f, $00, $59, $00, $40, $00, $48, $00, $fe, $00, $c8, $c8, $50, $64
    db $2c, $01 ; id 45 Gismo
    db SKILL_FIREAIR
    db SKILL_FRIGIDAIR
    db $ff
    db $ff
    db $1f, $01, $03, $10, $3a, $00, $48, $00, $35, $00, $33, $00, $8d, $00, $9d, $00, $fa, $1e, $96, $64
    db $bf, $00 ; id 46 Droll
    db SKILL_SLOWALL
    db SKILL_SHEARS
    db SKILL_STEPGUARD
    db $ff
    db $84, $01, $03, $11, $50, $00, $2d, $00, $46, $00, $39, $00, $31, $00, $f9, $00, $fa, $8c, $1e, $64
    db $22, $01 ; id 47 Goopi
    db SKILL_LEGSWEEP
    db $ff
    db $ff
    db $ff
    db $46, $01, $02, $0d, $3b, $00, $48, $00, $41, $00, $32, $00, $3b, $00, $9b, $00, $96, $96, $28, $64
    db $fa, $00 ; id 48 Mummy
    db SKILL_PARALYZE
    db $ff
    db $ff
    db $ff
    db $79, $01, $03, $11, $41, $00, $4e, $00, $42, $00, $30, $00, $52, $00, $0b, $01, $5a, $3c, $46, $64
    db $99, $00 ; id 49 TreeBoy
    db SKILL_MPASS
    db SKILL_CURSEOFF
    db $ff
    db $ff
    db $46, $01, $03, $11, $48, $00, $5a, $00, $3a, $00, $35, $00, $55, $00, $b7, $00, $1e, $d2, $6e, $64
    db $34, $01 ; id 50 BombCrag
    db SKILL_ROCKTHROW
    db SKILL_CHARGEUP
    db $ff
    db $ff
    db $e2, $07, $07, $12, $8a, $02, $0a, $00, $50, $00, $50, $00, $14, $00, $8c, $00, $46, $46, $64, $64
    db $20, $01 ; id 51 RogueNite
    db SKILL_HEAL
    db SKILL_METALCUT
    db $ff
    db $ff
    db $11, $02, $04, $14, $5d, $00, $3a, $00, $5e, $00, $50, $00, $37, $00, $9f, $00, $c8, $1e, $32, $64
    db $55, $00 ; id 52 Grizzly
    db SKILL_SQUALLHIT
    db $ff
    db $ff
    db $ff
    db $dd, $01, $04, $10, $7c, $00, $28, $00, $40, $00, $30, $00, $39, $00, $81, $00, $c8, $d2, $14, $64
    db $d6, $00 ; id 53 Demonite
    db SKILL_BLAZE
    db SKILL_FIREAIR
    db SKILL_FRIGIDAIR
    db $ff
    db $3f, $01, $02, $13, $49, $00, $1c, $00, $3b, $00, $27, $00, $61, $00, $da, $00, $c8, $32, $6e, $64
    db $92, $00 ; id 54 Gulpple
    db SKILL_HIGHJUMP
    db SKILL_SLEEPAIR
    db $ff
    db $ff
    db $03, $01, $04, $0d, $43, $00, $47, $00, $2b, $00, $31, $00, $58, $00, $ec, $00, $c8, $dc, $0a, $64
    db $05, $01 ; id 55 FoxFire
    db SKILL_BLAZE
    db SKILL_FIREBAL
    db $ff
    db $ff
    db $fb, $00, $03, $12, $51, $00, $82, $00, $4b, $00, $3c, $00, $63, $00, $46, $01, $64, $78, $64, $64
    db $48, $00 ; id 56 Almiraj
    db SKILL_SLEEP
    db SKILL_CHARGEUP
    db SKILL_BERSERKER
    db $ff
    db $73, $01, $03, $13, $60, $00, $4d, $00, $3c, $00, $39, $00, $68, $00, $a9, $00, $fa, $78, $00, $64
    db $77, $00 ; id 57 LandOwl
    db SKILL_INFERNOS
    db SKILL_BOLTSLASH
    db $ff
    db $ff
    db $43, $01, $04, $16, $68, $00, $66, $00, $51, $00, $48, $00, $42, $00, $cc, $00, $c8, $78, $8c, $64
    db $5d, $00 ; id 58 Goategon
    db SKILL_FIREBANE
    db SKILL_SLOW
    db $ff
    db $ff
    db $8f, $01, $03, $14, $6e, $00, $43, $00, $6c, $00, $4e, $00, $55, $00, $8f, $01, $fa, $a0, $28, $64
    db $4b, $00 ; id 59 Saccer
    db SKILL_UPPER
    db SKILL_PSYCHEUP
    db $ff
    db $ff
    db $f4, $00, $03, $10, $73, $00, $43, $00, $37, $00, $28, $00, $65, $00, $b1, $00, $b4, $5a, $6e, $64
    db $03, $00 ; id 60 WingSlime
    db SKILL_SQUALLHIT
    db SKILL_TAILWIND
    db $ff
    db $ff
    db $ef, $00, $02, $10, $3f, $00, $3e, $00, $39, $00, $2a, $00, $b2, $00, $7b, $00, $c8, $c8, $14, $64
    db $6c, $00 ; id 61 BullBird
    db SKILL_SHEARS
    db SKILL_CHARGEUP
    db $ff
    db $ff
    db $9a, $01, $03, $10, $64, $00, $3f, $00, $44, $00, $47, $00, $7d, $00, $92, $00, $32, $32, $78, $64
    db $84, $00 ; id 62 CragDevil
    db SKILL_AQUACUT
    db SKILL_LUREDANCE
    db $ff
    db $ff
    db $f5, $01, $03, $11, $56, $00, $33, $00, $34, $00, $38, $00, $76, $00, $ec, $00, $fa, $d2, $28, $64
    db $5b, $01 ; id 63 Starfish
    db SKILL_POISONHIT
    db SKILL_ODDDANCE
    db $ff
    db $ff
    db $d2, $01, $04, $14, $50, $00, $4e, $00, $4f, $00, $4d, $00, $62, $00, $ec, $00, $fa, $be, $14, $64
    db $4e, $01 ; id 64 SeaHorse
    db SKILL_FRIGIDAIR
    db SKILL_GEYSER
    db $ff
    db $ff
    db $91, $01, $03, $10, $5c, $00, $2a, $00, $47, $00, $33, $00, $66, $00, $7b, $00, $f0, $00, $00, $64
    db $9f, $00 ; id 65 ManEater
    db SKILL_DRAKSLASH
    db SKILL_PSYCHEUP
    db SKILL_SLEEPAIR
    db $ff
    db $5a, $02, $04, $14, $56, $00, $4c, $00, $54, $00, $34, $00, $4a, $00, $41, $01, $c8, $78, $6e, $64
    db $76, $00 ; id 66 StubBird
    db SKILL_TWINHITS
    db SKILL_BUGBLOW
    db SKILL_RAINSLASH
    db $ff
    db $f6, $01, $03, $15, $85, $00, $52, $00, $4a, $00, $3d, $00, $ab, $00, $47, $01, $8c, $6e, $64, $64
    db $be, $00 ; id 67 GiantMoth
    db SKILL_WINDBEAST
    db SKILL_PARALYZE
    db $ff
    db $ff
    db $e0, $01, $03, $19, $62, $00, $3d, $00, $4f, $00, $50, $00, $87, $00, $3c, $01, $c8, $c8, $1e, $64
    db $e0, $00 ; id 68 GoatHorn
    db SKILL_BOOM
    db SKILL_INFERMORE
    db SKILL_SNOWSTORM
    db $ff
    db $84, $17, $07, $1b, $52, $03, $59, $00, $5f, $00, $41, $00, $5c, $00, $a5, $00, $c8, $8c, $32, $96
    db $0c, $00 ; id 69 FangSlime
    db SKILL_CALLHELP
    db SKILL_CHARGEUP
    db SKILL_WARCRY
    db $ff
    db $63, $03, $03, $14, $7f, $00, $33, $00, $50, $00, $47, $00, $95, $00, $ba, $00, $d2, $96, $64, $64
    db $0d, $00 ; id 70 RockSlime
    db SKILL_HIGHJUMP
    db SKILL_RAMMING
    db SKILL_STRONGD
    db $ff
    db $fa, $09, $04, $19, $94, $00, $81, $00, $5c, $00, $65, $00, $96, $00, $d2, $00, $a0, $64, $82, $64
    db $70, $00 ; id 71 MadRaven
    db SKILL_HIGHJUMP
    db SKILL_STORMWIND
    db $ff
    db $ff
    db $90, $04, $03, $17, $5e, $00, $7b, $00, $4e, $00, $59, $00, $b5, $00, $ce, $00, $b4, $78, $64, $64
    db $7a, $00 ; id 72 Emyu
    db SKILL_WINDBEAST
    db $ff
    db $ff
    db $ff
    db $78, $03, $04, $16, $6c, $00, $56, $00, $56, $00, $48, $00, $a5, $00, $fe, $01, $b4, $64, $8c, $64
    db $8f, $00 ; id 73 FloraMan
    db SKILL_FIREBANE
    db SKILL_ANTIDOTE
    db $ff
    db $ff
    db $51, $03, $03, $18, $5e, $00, $a0, $00, $4b, $00, $55, $00, $5f, $00, $6a, $01, $8c, $32, $be, $64
    db $95, $00 ; id 74 Slurperon
    db SKILL_SLEEPALL
    db $ff
    db $ff
    db $ff
    db $48, $04, $03, $18, $66, $00, $5c, $00, $48, $00, $4e, $00, $6e, $00, $21, $01, $a0, $46, $46, $64
    db $29, $01 ; id 75 Roboster
    db SKILL_SQUALLHIT
    db SKILL_QUADHITS
    db SKILL_RAINSLASH
    db $ff
    db $ba, $0c, $04, $1e, $a8, $00, $7b, $00, $8b, $00, $92, $00, $88, $00, $16, $01, $c8, $82, $96, $64
    db $2f, $00 ; id 76 MadDragon
    db SKILL_MASSACRE
    db $ff
    db $ff
    db $ff
    db $53, $08, $04, $19, $7c, $00, $30, $00, $88, $00, $6b, $00, $68, $00, $49, $00, $96, $0a, $14, $64
    db $2d, $00 ; id 77 Dragon
    db SKILL_BLAZEAIR
    db SKILL_FIRESLASH
    db SKILL_SUCKALL
    db $ff
    db $5f, $07, $03, $1c, $9a, $00, $54, $00, $8f, $00, $63, $00, $9b, $00, $6e, $01, $d2, $78, $78, $64
    db $52, $00 ; id 78 IronTurt
    db SKILL_STRONGD
    db $ff
    db $ff
    db $ff
    db $4d, $05, $03, $18, $6e, $00, $57, $00, $66, $00, $80, $00, $61, $00, $0d, $01, $c8, $8c, $3c, $64
    db $1f, $01 ; id 79 MadMirror
    db SKILL_BOUNCE
    db SKILL_TRANSFORM
    db $ff
    db $ff
    db $69, $04, $03, $19, $9c, $00, $59, $00, $54, $00, $95, $00, $73, $00, $6e, $01, $c8, $d2, $0a, $64
    db $26, $01 ; id 80 SabreMan
    db SKILL_ROBMAGIC
    db SKILL_DEVILCUT
    db $ff
    db $ff
    db $b0, $03, $03, $15, $67, $00, $48, $00, $67, $00, $47, $00, $73, $00, $2c, $01, $fa, $d2, $28, $64
    db $da, $00 ; id 81 EvilBeast
    db SKILL_FIREBAL
    db SKILL_FRIGIDAIR
    db $ff
    db $ff
    db $e1, $04, $03, $17, $7e, $00, $63, $00, $59, $00, $6a, $00, $77, $00, $d2, $00, $3c, $64, $96, $64
    db $c3, $00 ; id 82 WarMantis
    db SKILL_VACUSLASH
    db SKILL_SHEARS
    db $ff
    db $ff
    db $84, $03, $04, $1a, $76, $00, $60, $00, $63, $00, $5c, $00, $77, $00, $c8, $00, $5a, $50, $8c, $64
    db $7c, $00 ; id 83 Phoenix
    db SKILL_BLAZEAIR
    db SKILL_SQUALLHIT
    db $ff
    db $ff
    db $fd, $05, $05, $20, $a5, $00, $6c, $00, $92, $00, $57, $00, $9b, $00, $3c, $01, $c8, $8c, $c8, $64
    db $8e, $00 ; id 84 FireWeed
    db SKILL_BLAZEMORE
    db SKILL_DECHAOS
    db $ff
    db $ff
    db $c1, $09, $03, $1b, $a2, $00, $de, $00, $82, $00, $9f, $00, $9e, $00, $d7, $00, $aa, $28, $1e, $64
    db $5e, $00 ; id 85 WildApe
    db SKILL_TWINSLASH
    db $ff
    db $ff
    db $ff
    db $3d, $05, $04, $19, $98, $00, $40, $00, $85, $00, $55, $00, $5c, $00, $b3, $00, $8c, $3c, $96, $64
    db $66, $00 ; id 86 Dumbira
    db SKILL_METALCUT
    db SKILL_TWINSLASH
    db $ff
    db $ff
    db $c6, $05, $04, $17, $78, $00, $52, $00, $6f, $00, $5c, $00, $9c, $00, $18, $01, $c8, $78, $46, $64
    db $c2, $00 ; id 87 Belzebub
    db SKILL_FIREBAL
    db SKILL_YELLHELP
    db $ff
    db $ff
    db $e6, $08, $04, $15, $8a, $00, $54, $00, $58, $00, $54, $00, $78, $00, $9a, $01, $50, $78, $96, $64
    db $11, $00 ; id 88 Metaly
    db SKILL_BLAZE
    db SKILL_HIGHJUMP_C8
    db $ff
    db $ff
    db $db, $1e, $05, $1c, $16, $00, $4e, $01, $5d, $00, $6c, $01, $1f, $02, $fd, $00, $28, $5a, $c8, $64
    db $a1, $00 ; id 89 GhosTree
    db SKILL_ROBMAGIC
    db $ff
    db $ff
    db $ff
    db $c8, $07, $04, $22, $6e, $00, $6a, $00, $72, $00, $61, $00, $6c, $00, $c7, $00, $64, $50, $5a, $64
    db $07, $00 ; id 90 Babble
    db SKILL_SURROUND
    db SKILL_POISONHIT
    db $ff
    db $ff
    db $0c, $07, $03, $1a, $5b, $00, $a3, $00, $5c, $00, $64, $00, $a6, $00, $fc, $00, $fa, $50, $00, $64
    db $df, $00 ; id 91 Lionex
    db SKILL_INFERMORE
    db SKILL_VACUSLASH
    db $ff
    db $ff
    db $7c, $0a, $04, $1e, $ac, $00, $7c, $00, $97, $00, $64, $00, $ac, $00, $5e, $01, $c8, $a0, $50, $64
    db $78, $00 ; id 92 MadGoose
    db SKILL_HEALMORE
    db SKILL_WINDBEAST
    db SKILL_LUREDANCE
    db $ff
    db $e5, $05, $04, $1c, $88, $00, $84, $00, $6e, $00, $64, $00, $bc, $00, $f7, $00, $78, $50, $6e, $64
    db $db, $00 ; id 93 Bubblemon
    db SKILL_WATERSHOT
    db SKILL_BLADED
    db $ff
    db $ff
    db $f0, $05, $03, $20, $c1, $00, $77, $00, $6c, $00, $50, $00, $9d, $00, $89, $00, $c8, $00, $00, $64
    db $ea, $00 ; id 94 Gigantes
    db SKILL_SLIMEBLOW
    db SKILL_CHARGEUP
    db SKILL_EVILSLASH
    db $ff
    db $38, $07, $04, $1e, $21, $01, $43, $00, $a6, $00, $5a, $00, $2c, $00, $4a, $00, $c8, $14, $8c, $64
    db $30, $01 ; id 95 Exaucers
    db SKILL_TAKEMAGIC
    db SKILL_WINDBEAST
    db SKILL_PANIDANCE
    db $ff
    db $2f, $09, $04, $25, $a7, $00, $9f, $00, $94, $00, $87, $00, $6c, $00, $6e, $01, $96, $28, $64, $64
    db $fc, $00 ; id 96 DeadNite
    db SKILL_HEALMORE
    db $ff
    db $ff
    db $ff
    db $97, $08, $04, $21, $aa, $00, $91, $00, $91, $00, $5c, $00, $9c, $00, $db, $00, $be, $28, $8c, $64
    db $e3, $00 ; id 97 GateGuard
    db SKILL_BLAZEMORE
    db SKILL_CLEANCUT
    db SKILL_THICKFOG
    db $ff
    db $a9, $08, $04, $23, $b9, $00, $6e, $00, $8e, $00, $75, $00, $6d, $00, $7a, $01, $c8, $14, $64, $64
    db $0e, $01 ; id 98 MadSpirit
    db SKILL_THICKFOG
    db $ff
    db $ff
    db $ff
    db $ab, $08, $04, $20, $81, $00, $72, $00, $81, $00, $6e, $00, $ce, $00, $f3, $01, $a0, $78, $50, $64
    db $0d, $01 ; id 99 Copycat
    db SKILL_TRANSFORM
    db $ff
    db $ff
    db $ff
    db $c5, $08, $05, $21, $5c, $00, $db, $00, $77, $00, $99, $00, $e0, $00, $f9, $00, $14, $1e, $c8, $64
    db $10, $01 ; id 100 Niterich
    db SKILL_HEALMORE
    db SKILL_ICESTORM
    db SKILL_DIAGOCALL
    db $ff
    db $a4, $4c, $07, $24, $dc, $05, $6a, $00, $b1, $00, $95, $00, $6e, $00, $fe, $01, $8c, $a0, $c8, $64
    db $33, $00 ; id 101 Andreal
    db SKILL_INFERMOST
    db SKILL_SURROUND
    db SKILL_POISONAIR
    db $ff
    db $13, $0d, $05, $25, $0b, $01, $ea, $00, $ae, $00, $90, $00, $a5, $00, $22, $02, $c8, $0a, $8c, $64
    db $e8, $00 ; id 102 MadKnight
    db SKILL_BEASTCUT
    db SKILL_MASSACRE
    db $ff
    db $ff
    db $02, $04, $05, $13, $72, $00, $76, $00, $77, $00, $80, $00, $5b, $00, $d1, $00, $3c, $78, $d2, $64
    db $3e, $00 ; id 103 SkyDragon
    db SKILL_BLAZEAIR
    db SKILL_SUCKAIR
    db $ff
    db $ff
    db $ca, $0c, $05, $22, $d2, $00, $c2, $00, $a0, $00, $77, $00, $74, $00, $a9, $00, $fa, $78, $28, $64
    db $1c, $01 ; id 104 CoilBird
    db SKILL_DECHAOS
    db SKILL_NUMBOFF
    db SKILL_SUCKALL
    db $ff
    db $2c, $0b, $04, $23, $80, $00, $6c, $00, $71, $00, $63, $00, $a5, $00, $d5, $00, $5a, $50, $96, $64
    db $bc, $00 ; id 105 ArmorPede
    db SKILL_INCREASE
    db SKILL_TWINHITS
    db $ff
    db $ff
    db $a0, $0d, $04, $20, $96, $00, $89, $00, $77, $00, $c8, $00, $81, $00, $0a, $01, $8c, $5a, $5a, $64
    db $c1, $00 ; id 106 MadHornet
    db SKILL_POISONHIT
    db SKILL_TAILWIND
    db $ff
    db $ff
    db $47, $0d, $04, $22, $ca, $00, $6c, $00, $84, $00, $75, $00, $1a, $01, $20, $01, $be, $5a, $46, $64
    db $6d, $01 ; id 107 Mudou
    db SKILL_SCORCHING
    db SKILL_ICESTORM
    db SKILL_POISONHIT
    db SKILL_DEMAGIC
    db $8e, $96, $07, $26, $b8, $0b, $9d, $01, $e1, $00, $a0, $00, $9c, $00, $96, $00, $b4, $50, $dc, $64
    db $ec, $00 ; id 108 EvilArmor
    db SKILL_FIRESLASH
    db SKILL_BOLTSLASH
    db SKILL_AQUACUT
    db $ff
    db $48, $26, $07, $26, $c2, $01, $8c, $00, $b9, $00, $96, $00, $8a, $00, $18, $01, $c8, $c8, $1e, $64
    db $0a, $01 ; id 109 Skeletor
    db SKILL_DEFENSE
    db SKILL_BIATTACK
    db $ff
    db $ff
    db $dc, $1e, $07, $25, $e2, $00, $6c, $00, $a0, $00, $94, $00, $8c, $00, $8c, $00, $64, $64, $3c, $64
    db $35, $00 ; id 110 Vampirus
    db SKILL_INFERMORE
    db SKILL_CALLHELP
    db SKILL_BIATTACK
    db $ff
    db $4d, $0c, $05, $20, $95, $00, $4f, $00, $7a, $00, $6c, $00, $8c, $00, $d8, $00, $5a, $96, $64, $64
    db $6d, $00 ; id 111 Florajay
    db SKILL_SPEEDUP
    db SKILL_BEASTCUT
    db $ff
    db $ff
    db $cc, $0b, $04, $24, $86, $00, $95, $00, $7a, $00, $84, $00, $a9, $00, $ba, $00, $78, $28, $5a, $64
    db $e5, $00 ; id 112 BossTroll
    db SKILL_MASSACRE
    db SKILL_RAMMING
    db SKILL_COVER
    db $ff
    db $48, $1b, $05, $29, $3a, $01, $bb, $00, $dc, $00, $95, $00, $59, $00, $b3, $00, $c8, $00, $00, $64
    db $e4, $00 ; id 113 ChopClown
    db SKILL_TWINHITS
    db SKILL_VACUSLASH
    db SKILL_SQUALLHIT
    db $ff
    db $4d, $19, $05, $28, $cb, $00, $e6, $00, $cd, $00, $b8, $00, $3f, $01, $51, $03, $dc, $28, $78, $64
    db $71, $00 ; id 114 MistyWing
    db SKILL_BARRIER
    db SKILL_EERIELITE
    db $ff
    db $ff
    db $6e, $17, $05, $29, $e6, $00, $ab, $00, $b0, $00, $e1, $00, $fb, $00, $88, $01, $8c, $82, $46, $64
    db $eb, $00 ; id 115 Centasaur
    db SKILL_STOPSPELL
    db SKILL_FIRESLASH
    db SKILL_RAINSLASH
    db $ff
    db $38, $4a, $07, $28, $84, $03, $53, $00, $dc, $00, $96, $00, $fa, $00, $fa, $00, $c8, $50, $6e, $64
    db $42, $00 ; id 116 GigaDraco
    db SKILL_WHITEFIRE
    db $ff
    db $ff
    db $ff
    db $08, $52, $07, $2a, $e8, $03, $f5, $00, $15, $01, $b4, $00, $78, $00, $64, $00, $78, $64, $8c, $64
    db $7e, $00 ; id 117 Garudian
    db SKILL_INFERMORE
    db SKILL_WINDBEAST
    db SKILL_AQUACUT
    db $ff
    db $48, $3f, $07, $29, $20, $03, $58, $00, $ce, $00, $a0, $00, $fb, $00, $40, $01, $a0, $8c, $96, $64
    db $2f, $01 ; id 118 Mimic
    db SKILL_EAGLEEYE
    db $ff
    db $ff
    db $ff
    db $0c, $00, $04, $01, $19, $00, $0f, $00, $0f, $00, $08, $00, $0a, $00, $32, $00, $96, $28, $8c, $32
    db $2f, $01 ; id 119 Mimic
    db SKILL_BLAZE
    db SKILL_EAGLEEYE
    db $ff
    db $ff
    db $2d, $00, $04, $05, $27, $00, $18, $00, $2b, $00, $1b, $00, $16, $00, $90, $00, $96, $28, $8c, $32
    db $2f, $01 ; id 120 Mimic
    db SKILL_BLAZE
    db SKILL_BEAT
    db SKILL_EAGLEEYE
    db $ff
    db $78, $00, $04, $0a, $3e, $00, $23, $00, $4d, $00, $25, $00, $2c, $00, $22, $01, $96, $28, $8c, $32
    db $2f, $01 ; id 121 Mimic
    db SKILL_BLAZEMORE
    db SKILL_BEAT
    db SKILL_EAGLEEYE
    db $ff
    db $68, $01, $04, $0f, $51, $00, $2a, $00, $6e, $00, $2f, $00, $40, $00, $90, $01, $96, $28, $8c, $32
    db $2f, $01 ; id 122 Mimic
    db SKILL_BLAZEMORE
    db SKILL_BEAT
    db SKILL_EAGLEEYE
    db $ff
    db $94, $02, $04, $14, $81, $00, $35, $00, $84, $00, $47, $00, $56, $00, $d9, $01, $96, $28, $8c, $32
    db $2f, $01 ; id 123 Mimic
    db SKILL_BLAZEMOST
    db SKILL_BEAT
    db SKILL_EAGLEEYE
    db $ff
    db $46, $05, $04, $19, $97, $00, $3e, $00, $9a, $00, $6c, $00, $7c, $00, $2d, $02, $96, $28, $8c, $32
    db $2f, $01 ; id 124 Mimic
    db SKILL_BLAZEMOST
    db SKILL_BEAT
    db SKILL_EAGLEEYE
    db $ff
    db $2f, $0d, $04, $1e, $1c, $01, $92, $00, $af, $00, $91, $00, $92, $00, $f0, $02, $96, $28, $8c, $32
    db $2f, $01 ; id 125 Mimic
    db SKILL_BLAZEMOST
    db SKILL_BEAT
    db SKILL_EAGLEEYE
    db $ff
    db $f5, $19, $04, $23, $3e, $01, $a6, $00, $ca, $00, $b8, $00, $a8, $00, $87, $03, $96, $28, $8c, $32
    db $75, $01 ; id 126 Tatsu
    db SKILL_HEALMORE
    db SKILL_LIGHTNING
    db SKILL_COVER
    db $ff
    db $00, $00, $07, $1e, $c8, $00, $64, $00, $b4, $00, $96, $00, $73, $00, $4c, $02, $fa, $fa, $fa, $fa
    db $76, $01 ; id 127 Diago
    db SKILL_TWINHITS
    db SKILL_SCORCHING
    db SKILL_SICKLICK
    db $ff
    db $00, $00, $07, $28, $2c, $01, $c8, $00, $d2, $00, $a0, $00, $ac, $00, $88, $01, $fa, $fa, $fa, $fa
    db $77, $01 ; id 128 Samsi
    db SKILL_SQUALLHIT
    db SKILL_RAINSLASH
    db SKILL_EVILSLASH
    db $ff
    db $00, $00, $07, $32, $c2, $01, $c8, $00, $fa, $00, $be, $00, $d7, $00, $10, $03, $fa, $fa, $fa, $fa
    db $78, $01 ; id 129 Bazoo
    db SKILL_HELLBLAST
    db SKILL_ICESTORM
    db SKILL_DEMAGIC
    db $ff
    db $00, $00, $07, $3c, $bc, $02, $90, $01, $5e, $01, $2c, $01, $8f, $00, $ac, $03, $fa, $fa, $fa, $fa
    db $79, $01 ; id 130 ?
    db SKILL_SCORCHING
    db SKILL_ICESTORM
    db SKILL_DEMAGIC
    db $ff
    db $00, $00, $07, $32, $e7, $03, $2c, $01, $2c, $01, $c8, $00, $1e, $01, $10, $03, $fa, $00, $00, $fa
    db $07, $00 ; id 131 Babble
    db SKILL_BLAZE
    db $ff
    db $ff
    db $ff
    db $00, $00, $07, $06, $24, $00, $09, $00, $0e, $00, $0d, $00, $20, $00, $7b, $00, $aa, $50, $8c, $64
    db $09, $00 ; id 132 PearlGel
    db $ff
    db $ff
    db $ff
    db $ff
    db $00, $00, $07, $05, $0f, $00, $0c, $00, $11, $00, $23, $00, $33, $00, $60, $00, $b4, $64, $32, $64
    db $1e, $01 ; id 133 SpikyBoy
    db SKILL_SLIMEBLOW
    db $ff
    db $ff
    db $ff
    db $00, $00, $07, $06, $13, $00, $2a, $00, $11, $00, $1f, $00, $22, $00, $60, $00, $b4, $0a, $64, $64
    db $d3, $00 ; id 134 Pixy
    db $ff
    db $ff
    db $ff
    db $ff
    db $00, $00, $07, $07, $1d, $00, $18, $00, $14, $00, $0e, $00, $36, $00, $4f, $00, $3c, $d2, $6e, $64
    db $73, $00 ; id 135 Dracky
    db SKILL_VACUSLASH
    db $ff
    db $ff
    db $ff
    db $00, $00, $07, $07, $28, $00, $16, $00, $0e, $00, $0c, $00, $46, $00, $60, $00, $96, $8c, $a0, $64
    db $70, $00 ; id 136 MadRaven
    db SKILL_HIGHJUMP
    db $ff
    db $ff
    db $ff
    db $00, $00, $07, $09, $29, $00, $37, $00, $10, $00, $1e, $00, $54, $00, $a3, $00, $b4, $8c, $78, $64
    db $74, $00 ; id 137 KiteHawk
    db SKILL_CHARGEUP
    db $ff
    db $ff
    db $ff
    db $00, $00, $07, $09, $2e, $00, $23, $00, $1a, $00, $15, $00, $2a, $00, $92, $00, $c8, $64, $c8, $96
    db $4e, $00 ; id 138 WindBeast
    db SKILL_VACUSLASH
    db $ff
    db $ff
    db $ff
    db $00, $00, $07, $0e, $33, $00, $3e, $00, $29, $00, $34, $00, $52, $00, $b4, $00, $c8, $28, $d2, $78
    db $2c, $01 ; id 139 Gismo
    db SKILL_FRIGIDAIR
    db $ff
    db $ff
    db $ff
    db $00, $00, $07, $0b, $30, $00, $48, $00, $33, $00, $47, $00, $ab, $00, $00, $01, $c8, $00, $5a, $78
    db $0f, $01 ; id 140 PomPomBom
    db SKILL_FIREAIR
    db SKILL_TAILWIND
    db $ff
    db $ff
    db $00, $00, $07, $0d, $3e, $00, $43, $00, $48, $00, $30, $00, $a4, $00, $96, $00, $32, $1e, $c8, $78
    db $9a, $00 ; id 141 Devipine
    db SKILL_NAPATTACK
    db SKILL_POISONGAS
    db $ff
    db $ff
    db $00, $00, $07, $0d, $3c, $00, $25, $00, $40, $00, $2d, $00, $5f, $00, $6e, $01, $78, $14, $8c, $78
    db $92, $00 ; id 142 Gulpple
    db SKILL_SLOW
    db SKILL_HIGHJUMP
    db $ff
    db $ff
    db $00, $00, $07, $0e, $42, $00, $47, $00, $39, $00, $59, $00, $58, $00, $e8, $00, $96, $32, $50, $78
    db $a6, $00 ; id 143 Eggplaton
    db SKILL_SLEEPAIR
    db SKILL_RADIANT
    db $ff
    db $ff
    db $00, $00, $07, $0e, $43, $00, $4d, $00, $41, $00, $2a, $00, $5f, $00, $df, $00, $aa, $8c, $28, $78
    db $54, $00 ; id 144 HammerMan
    db SKILL_CHARGEUP
    db SKILL_EVILSLASH
    db $ff
    db $ff
    db $00, $00, $07, $10, $46, $00, $10, $00, $49, $00, $3c, $00, $40, $00, $95, $00, $8c, $78, $64, $78
    db $96, $00 ; id 145 Stubsuck
    db SKILL_SLEEPALL
    db SKILL_ZOMBIECUT
    db $ff
    db $ff
    db $00, $00, $07, $11, $64, $00, $32, $00, $3c, $00, $41, $00, $4e, $00, $05, $01, $fa, $aa, $00, $96
    db $99, $00 ; id 146 TreeBoy
    db SKILL_SNOWSTORM
    db SKILL_MAGICBACK
    db $ff
    db $ff
    db $00, $00, $07, $1b, $b9, $00, $c8, $00, $49, $00, $5f, $00, $82, $00, $3e, $01, $46, $96, $c8, $96
    db $a7, $00 ; id 147 FooHero
    db SKILL_BLAZEMORE
    db SKILL_HEALMORE
    db SKILL_WINDBEAST
    db $ff
    db $00, $00, $07, $19, $98, $00, $8a, $00, $52, $00, $64, $00, $50, $00, $36, $01, $0a, $c8, $c8, $96
    db $53, $00 ; id 148 Mommonja
    db SKILL_LUREDANCE
    db $ff
    db $ff
    db $ff
    db $00, $00, $07, $1a, $8c, $00, $3f, $00, $66, $00, $53, $00, $1b, $01, $6f, $01, $fa, $78, $50, $96
    db $2c, $00 ; id 149 Drygon
    db SKILL_WATERSHOT
    db SKILL_PSYCHEUP
    db SKILL_WARCRY
    db $ff
    db $00, $00, $07, $21, $97, $00, $63, $00, $7c, $00, $68, $00, $6a, $00, $5b, $01, $c8, $96, $5a, $96
    db $9c, $00 ; id 150 HerbMan
    db SKILL_BOOM
    db SKILL_DANCESHUT
    db $ff
    db $ff
    db $00, $00, $07, $24, $c9, $00, $95, $00, $6e, $00, $74, $00, $7b, $00, $b3, $01, $c8, $1e, $d2, $96
    db $98, $00 ; id 151 DanceVegi
    db SKILL_BERSERKER
    db SKILL_SIDESTEP
    db $ff
    db $ff
    db $00, $00, $07, $23, $91, $00, $84, $00, $69, $00, $69, $00, $bd, $00, $8d, $01, $b4, $64, $96, $96
    db $31, $01 ; id 152 MudDoll
    db SKILL_HUSTLE
    db SKILL_SANDSTORM
    db SKILL_BIGTRIP
    db $ff
    db $00, $00, $07, $23, $d2, $00, $1c, $00, $6c, $00, $52, $00, $69, $00, $da, $02, $fa, $28, $82, $96
    db $fd, $00 ; id 153 Shadow
    db SKILL_STOPSPELL
    db SKILL_ICEAIR
    db $ff
    db $ff
    db $00, $00, $07, $2a, $ee, $00, $e0, $00, $d6, $00, $c1, $00, $cf, $00, $52, $03, $28, $c8, $d2, $c8
    db $79, $00 ; id 154 MadCondor
    db SKILL_SURROUND
    db SKILL_WINDBEAST
    db SKILL_DIAGOCALL
    db $ff
    db $00, $00, $07, $1e, $b7, $00, $28, $00, $c3, $00, $b4, $00, $e9, $00, $0c, $02, $78, $5a, $46, $c8
    db $38, $01 ; id 155 CloudKing
    db SKILL_SNOWSTORM
    db SKILL_MAGICWALL
    db SKILL_EERIELITE
    db $ff
    db $00, $00, $07, $27, $e1, $00, $b2, $00, $da, $00, $be, $00, $f7, $00, $e0, $02, $b4, $c8, $c8, $c8
    db $45, $01 ; id 156 Octoreach
    db SKILL_FIREBANE
    db SKILL_PANIDANCE
    db $ff
    db $ff
    db $00, $00, $07, $25, $d2, $00, $1f, $01, $84, $00, $82, $00, $b1, $00, $12, $02, $fa, $3c, $28, $c8
    db $52, $01 ; id 157 Octogon
    db SKILL_QUADHITS
    db SKILL_MASSACRE
    db $ff
    db $ff
    db $00, $00, $07, $25, $18, $01, $cc, $00, $a9, $00, $78, $00, $7d, $00, $c2, $02, $fa, $c8, $1e, $c8
    db $53, $01 ; id 158 KingSquid
    db SKILL_VIVIFY
    db SKILL_RAINSLASH
    db SKILL_PSYCHEUP
    db $ff
    db $00, $00, $07, $2b, $04, $01, $23, $00, $d2, $00, $a0, $00, $63, $00, $d2, $03, $fa, $28, $aa, $c8
    db $71, $00 ; id 159 MistyWing
    db SKILL_SNOWSTORM
    db SKILL_SURROUND
    db SKILL_BARRIER
    db $ff
    db $00, $00, $07, $2d, $0d, $01, $c9, $00, $a6, $00, $9b, $00, $24, $01, $c5, $01, $1e, $6e, $c8, $c8
    db $0d, $01 ; id 160 Copycat
    db SKILL_TRANSFORM
    db SKILL_ODDDANCE
    db SKILL_IMITATE
    db $ff
    db $00, $00, $07, $2d, $d2, $00, $f4, $00, $90, $00, $96, $00, $85, $00, $ae, $01, $14, $8c, $1e, $c8
    db $01, $01 ; id 161 NiteWhip
    db SKILL_DEFENSE
    db SKILL_WINDBEAST
    db SKILL_LIGHTNING
    db $ff
    db $00, $00, $07, $2d, $4a, $01, $95, $00, $b6, $00, $b4, $00, $95, $00, $3e, $03, $b4, $0a, $14, $c8
    db $22, $01 ; id 162 Goopi
    db SKILL_BLAZEMORE
    db SKILL_CALLHELP
    db SKILL_MOUTHSHUT
    db SKILL_DODGE
    db $00, $00, $07, $14, $fa, $00, $19, $00, $f5, $00, $c3, $00, $87, $00, $08, $02, $1e, $6e, $d2, $fa
    db $0b, $01 ; id 163 Servant
    db SKILL_BLAZEMORE
    db SKILL_SNOWSTORM
    db SKILL_FOCUS
    db $ff
    db $00, $00, $07, $31, $28, $01, $5b, $01, $34, $01, $f8, $00, $a4, $01, $5f, $03, $c8, $8c, $6e, $fa
    db $c0, $00 ; id 164 ArmyCrab
    db SKILL_INCREASE
    db SKILL_CALLHELP
    db SKILL_METALCUT
    db $ff
    db $00, $00, $07, $1e, $d2, $00, $04, $00, $22, $01, $0e, $01, $73, $00, $51, $01, $b4, $c8, $46, $fa
    db $fb, $00 ; id 165 DarkCrab
    db SKILL_MAGICWALL
    db SKILL_RAMMING
    db $ff
    db $ff
    db $00, $00, $07, $32, $fa, $00, $0f, $00, $4a, $01, $18, $01, $8e, $00, $ab, $02, $14, $c8, $64, $fa
    db $3c, $00 ; id 166 Orochi
    db SKILL_SCORCHING
    db SKILL_FIRESLASH
    db SKILL_QUADHITS
    db $ff
    db $00, $00, $07, $32, $7d, $01, $97, $00, $0f, $01, $0b, $01, $25, $01, $3a, $02, $8c, $96, $28, $fa
    db $3f, $00 ; id 167 Serpentia
    db SKILL_SLIMEBLOW
    db SKILL_DEVILCUT
    db SKILL_RAINSLASH
    db SKILL_EVILSLASH
    db $00, $00, $07, $32, $28, $01, $79, $00, $2d, $01, $ff, $00, $d5, $01, $44, $02, $aa, $c8, $64, $fa
    db $42, $00 ; id 168 GigaDraco
    db SKILL_EXPLODET
    db SKILL_CHARGEUP
    db SKILL_WARCRY
    db $ff
    db $00, $00, $07, $32, $55, $01, $15, $01, $41, $01, $c9, $00, $ae, $01, $4c, $02, $c8, $0a, $d2, $fa
    db $60, $00 ; id 169 KingLeo
    db SKILL_FIREBOLT
    db SKILL_HEALMORE
    db SKILL_ICESTORM
    db SKILL_QUADHITS
    db $00, $00, $07, $3c, $64, $02, $1d, $01, $ce, $01, $7b, $01, $c6, $01, $b6, $03, $c8, $c8, $c8, $fa
    db $82, $00 ; id 170 Azurile
    db SKILL_MULTICUT
    db $ff
    db SKILL_MEDITATE
    db $ff
    db $00, $00, $07, $3c, $fa, $04, $ce, $01, $ce, $01, $80, $01, $94, $02, $c4, $03, $b4, $c8, $28, $fa
    db $40, $00 ; id 171 Divinegon
    db SKILL_SCORCHING
    db SKILL_PALSYAIR
    db $ff
    db $ff
    db $00, $00, $07, $3c, $0a, $04, $d3, $01, $28, $02, $ce, $01, $b5, $01, $d2, $03, $d2, $aa, $b4, $fa
    db $26, $00 ; id 172 Pteranod
    db SKILL_INFERNOS
    db SKILL_FIREAIR
    db $ff
    db $ff
    db $b4, $00, $05, $05, $20, $00, $15, $00, $22, $00, $13, $00, $3e, $00, $36, $00, $c8, $c8, $32, $32
    db $4e, $00 ; id 173 WindBeast
    db SKILL_UPPER
    db SKILL_RAMMING
    db $ff
    db $ff
    db $93, $00, $05, $05, $1b, $00, $2b, $00, $18, $00, $1b, $00, $2a, $00, $50, $00, $c8, $28, $1e, $32
    db $5b, $00 ; id 174 FairyRat
    db SKILL_BLAZE
    db SKILL_FIREBAL
    db $ff
    db $ff
    db $9a, $00, $05, $05, $1e, $00, $18, $00, $18, $00, $1d, $00, $2a, $00, $36, $00, $c8, $c8, $64, $32
    db $63, $00 ; id 175 BigEye
    db SKILL_CHARGEUP
    db SKILL_RADIANT
    db $ff
    db $ff
    db $b8, $00, $05, $05, $20, $00, $10, $00, $1d, $00, $15, $00, $17, $00, $4a, $00, $b4, $46, $28, $32
    db $6c, $00 ; id 176 BullBird
    db SKILL_TWINHITS
    db SKILL_KAMIKAZE
    db $ff
    db $ff
    db $a5, $00, $05, $05, $1f, $00, $10, $00, $1d, $00, $16, $00, $37, $00, $36, $00, $c8, $1e, $46, $32
    db $99, $00 ; id 177 TreeBoy
    db SKILL_HEAL
    db SKILL_TAKEMAGIC
    db $ff
    db $ff
    db $b6, $00, $05, $05, $20, $00, $22, $00, $10, $00, $1c, $00, $27, $00, $61, $00, $82, $82, $96, $32
    db $ba, $00 ; id 178 GoHopper
    db SKILL_FIRESLASH
    db SKILL_VACUSLASH
    db SKILL_BOLTSLASH
    db $ff
    db $8a, $00, $05, $05, $1b, $00, $10, $00, $10, $00, $1a, $00, $2a, $00, $33, $00, $a0, $28, $78, $32
    db $da, $00 ; id 179 EvilBeast
    db SKILL_BIATTACK
    db SKILL_POISONGAS
    db $ff
    db $ff
    db $b1, $00, $05, $06, $2a, $00, $1a, $00, $32, $00, $32, $00, $1a, $00, $61, $00, $aa, $82, $96, $32
    db $00, $01 ; id 180 Mudron
    db SKILL_SLOW
    db SKILL_WATERSHOT
    db SKILL_GEYSER
    db $ff
    db $9c, $00, $05, $05, $29, $00, $18, $00, $15, $00, $1d, $00, $17, $00, $56, $00, $14, $8c, $1e, $32
    db $03, $01 ; id 181 Reaper
    db SKILL_BLAZE
    db SKILL_WINDBEAST
    db $ff
    db $ff
    db $95, $00, $05, $05, $29, $00, $21, $00, $2b, $00, $1d, $00, $37, $00, $7f, $00, $8c, $c8, $dc, $32
    db $fa, $00 ; id 182 Mummy
    db SKILL_PANICALL
    db SKILL_PARALYZE
    db SKILL_WARCRY
    db $ff
    db $af, $00, $05, $05, $13, $00, $13, $00, $1d, $00, $10, $00, $17, $00, $25, $00, $a0, $32, $aa, $32
    db $19, $01 ; id 183 JewelBag
    db SKILL_ROBMAGIC
    db SKILL_FIREAIR
    db SKILL_RADIANT
    db $ff
    db $a9, $00, $05, $05, $1b, $00, $15, $00, $16, $00, $22, $00, $2a, $00, $61, $00, $8c, $28, $78, $32
    db $5b, $01 ; id 184 Starfish
    db SKILL_SAP
    db SKILL_VACUSLASH
    db SKILL_HIGHJUMP
    db $ff
    db $ae, $00, $05, $05, $1b, $00, $16, $00, $10, $00, $10, $00, $17, $00, $46, $00, $82, $8c, $6e, $32
    db $28, $01 ; id 185 Brushead
    db SKILL_BLAZE
    db SKILL_LUREDANCE
    db SKILL_SIDESTEP
    db $ff
    db $a4, $00, $05, $06, $1a, $00, $2d, $00, $22, $00, $12, $00, $1a, $00, $86, $00, $dc, $0a, $14, $32
    db $31, $01 ; id 186 MudDoll
    db SKILL_ROBMAGIC
    db SKILL_METALCUT
    db SKILL_SANDSTORM
    db $ff
    db $ab, $00, $05, $05, $1e, $00, $21, $00, $18, $00, $1d, $00, $10, $00, $61, $00, $28, $28, $c8, $32
    db $48, $01 ; id 187 RushFish
    db SKILL_WATERSHOT
    db SKILL_BUGBLOW
    db SKILL_KAMIKAZE
    db $ff
    db $b4, $00, $05, $06, $1a, $00, $2d, $00, $1d, $00, $12, $00, $37, $00, $96, $00, $c8, $8c, $6e, $32
    db $03, $00 ; id 188 WingSlime
    db SKILL_UPPER
    db SKILL_SHEARS
    db SKILL_STORMWIND
    db $ff
    db $dc, $00, $05, $0b, $31, $00, $2c, $00, $2d, $00, $23, $00, $8b, $00, $64, $00, $5a, $82, $c8, $5a
    db $2a, $00 ; id 189 Poisongon
    db SKILL_FRIGIDAIR
    db SKILL_AQUACUT
    db $ff
    db $ff
    db $f3, $00, $05, $09, $4e, $00, $2f, $00, $2f, $00, $2a, $00, $23, $00, $40, $00, $1e, $c8, $64, $5a
    db $2c, $00 ; id 190 Drygon
    db SKILL_FIREBAL
    db SKILL_MOUTHSHUT
    db $ff
    db $ff
    db $fa, $00, $05, $0a, $3a, $00, $25, $00, $3f, $00, $2a, $00, $23, $00, $8c, $00, $c8, $1e, $c8, $5a
    db $49, $00 ; id 191 CatFly
    db SKILL_FIREAIR
    db SKILL_DRAKSLASH
    db $ff
    db $ff
    db $e9, $00, $05, $09, $3c, $00, $20, $00, $2a, $00, $20, $00, $4b, $00, $a0, $00, $14, $d2, $6e, $5a
    db $53, $00 ; id 192 Mommonja
    db SKILL_HEAL
    db SKILL_MPASS
    db $ff
    db $ff
    db $e4, $00, $05, $09, $30, $00, $1d, $00, $2f, $00, $30, $00, $70, $00, $50, $00, $78, $82, $c8, $5a
    db $55, $00 ; id 193 Grizzly
    db SKILL_TWINHITS
    db SKILL_CLEANCUT
    db SKILL_AQUACUT
    db $ff
    db $19, $01, $05, $0b, $47, $00, $0a, $00, $4c, $00, $18, $00, $2a, $00, $40, $00, $c8, $0a, $0a, $5a
    db $84, $00 ; id 194 CragDevil
    db SKILL_SAP
    db SKILL_BIATTACK
    db SKILL_HIGHJUMP
    db $ff
    db $e5, $00, $05, $09, $49, $00, $30, $00, $30, $00, $22, $00, $4b, $00, $c9, $00, $0a, $d2, $28, $5a
    db $6a, $00 ; id 195 Picky
    db SKILL_SURROUND
    db SKILL_AHHH
    db SKILL_WARCRY
    db $ff
    db $ed, $00, $05, $08, $30, $00, $2a, $00, $30, $00, $22, $00, $45, $00, $50, $00, $14, $5a, $aa, $5a
    db $d3, $00 ; id 196 Pixy
    db SKILL_HEAL
    db SKILL_STOPSPELL
    db $ff
    db $ff
    db $f5, $00, $05, $08, $27, $00, $18, $00, $2f, $00, $18, $00, $44, $00, $50, $00, $8c, $0a, $c8, $5a
    db $d5, $00 ; id 197 AgDevil
    db SKILL_BEASTCUT
    db SKILL_SLEEPAIR
    db $ff
    db $ff
    db $0a, $01, $05, $09, $2f, $00, $1d, $00, $34, $00, $22, $00, $44, $00, $f4, $00, $8c, $c8, $c8, $5a
    db $ff, $00 ; id 198 Hork
    db SKILL_UPPER
    db SKILL_CALLHELP
    db $ff
    db $ff
    db $fb, $00, $05, $09, $30, $00, $2a, $00, $2f, $00, $1a, $00, $2a, $00, $6b, $00, $28, $32, $82, $5a
    db $02, $01 ; id 199 WindMerge
    db SKILL_SLOW
    db SKILL_VACUSLASH
    db SKILL_DANCESHUT
    db $ff
    db $f1, $00, $05, $09, $2f, $00, $49, $00, $49, $00, $22, $00, $3c, $00, $f4, $00, $1e, $d2, $28, $5a
    db $1e, $01 ; id 200 SpikyBoy
    db SKILL_HEAL
    db SKILL_HIGHJUMP
    db $ff
    db $ff
    db $ff, $00, $05, $0a, $34, $00, $33, $00, $34, $00, $25, $00, $2e, $00, $9a, $00, $96, $82, $14, $5a
    db $22, $01 ; id 201 Goopi
    db SKILL_WINDBEAST
    db SKILL_BIATTACK
    db SKILL_MOUTHSHUT
    db $ff
    db $f2, $00, $05, $0b, $22, $00, $31, $00, $27, $00, $37, $00, $2b, $00, $64, $00, $c8, $0a, $28, $5a
    db $43, $01 ; id 202 Octokid
    db SKILL_SPEED
    db SKILL_MAGICBACK
    db SKILL_NAPATTACK
    db $ff
    db $0b, $01, $05, $0b, $25, $00, $36, $00, $31, $00, $31, $00, $4f, $00, $33, $01, $8c, $82, $28, $5a
    db $4b, $01 ; id 203 CancerMan
    db SKILL_CHARGEUP
    db SKILL_PSYCHEUP
    db $ff
    db $ff
    db $f8, $00, $05, $09, $2b, $00, $2a, $00, $3f, $00, $4e, $00, $45, $00, $61, $00, $b4, $aa, $1e, $5a
    db $06, $00 ; id 204 SlimeNite
    db SKILL_BLAZE
    db SKILL_SURROUND
    db SKILL_SQUALLHIT
    db $ff
    db $5e, $01, $05, $0f, $47, $00, $34, $00, $48, $00, $42, $00, $ac, $00, $ed, $00, $8c, $64, $aa, $8c
    db $07, $00 ; id 205 Babble
    db SKILL_ICEBOLT
    db SKILL_SLEEPAIR
    db SKILL_WARCRY
    db $ff
    db $79, $01, $05, $0f, $3e, $00, $78, $00, $3e, $00, $3e, $00, $44, $00, $90, $01, $c8, $aa, $d2, $8c
    db $30, $00 ; id 206 Rayburn
    db SKILL_SLEEP
    db SKILL_ANTIDOTE
    db SKILL_LUSHLICKS
    db $ff
    db $80, $01, $05, $0f, $47, $00, $3e, $00, $47, $00, $43, $00, $67, $00, $e0, $00, $0a, $c8, $c8, $8c
    db $65, $00 ; id 207 CatMage
    db SKILL_BEAT
    db SKILL_ZOMBIECUT
    db SKILL_SUCKAIR
    db $ff
    db $71, $01, $05, $11, $48, $00, $59, $00, $3d, $00, $42, $00, $66, $00, $da, $00, $78, $c8, $0a, $8c
    db $56, $00 ; id 208 Yeti
    db SKILL_UPPER
    db SKILL_SLEEP
    db SKILL_WATERSHOT
    db $ff
    db $8f, $01, $05, $0f, $4d, $00, $2a, $00, $48, $00, $2a, $00, $3c, $00, $7c, $00, $96, $96, $96, $8c
    db $4f, $00 ; id 209 Beavern
    db SKILL_SPEEDUP
    db SKILL_RAINSLASH
    db SKILL_SIDESTEP
    db $ff
    db $73, $01, $05, $0f, $48, $00, $25, $00, $4d, $00, $41, $00, $66, $00, $8c, $00, $c8, $8c, $b4, $8c
    db $6d, $00 ; id 210 Florajay
    db SKILL_HEAL
    db SKILL_SLEEPAIR
    db SKILL_SUCKALL
    db $ff
    db $71, $01, $05, $11, $5f, $00, $4d, $00, $4d, $00, $50, $00, $ac, $00, $7f, $01, $8c, $6e, $c8, $8c
    db $93, $00 ; id 211 Toadstool
    db SKILL_NUMBOFF
    db SKILL_SURROUND
    db SKILL_AHHH
    db $ff
    db $3f, $01, $05, $0d, $47, $00, $4d, $00, $3a, $00, $30, $00, $60, $00, $e0, $00, $1e, $d2, $8c, $8c
    db $be, $00 ; id 212 GiantMoth
    db SKILL_BERSERKER
    db SKILL_ODDDANCE
    db SKILL_RADIANT
    db $ff
    db $6f, $01, $05, $0f, $47, $00, $2a, $00, $48, $00, $2f, $00, $ac, $00, $9d, $00, $1e, $8c, $be, $8c
    db $c0, $00 ; id 213 ArmyCrab
    db SKILL_TWINHITS
    db SKILL_FIRESLASH
    db SKILL_LEGSWEEP
    db $ff
    db $63, $01, $05, $11, $48, $00, $25, $00, $47, $00, $55, $00, $5d, $00, $6b, $00, $8c, $6e, $1e, $8c
    db $c1, $00 ; id 214 MadHornet
    db SKILL_NUMBOFF
    db SKILL_CURSEOFF
    db SKILL_BIATTACK
    db $ff
    db $6e, $01, $05, $12, $78, $00, $43, $00, $69, $00, $43, $00, $ac, $00, $7c, $00, $28, $6e, $78, $8c
    db $d6, $00 ; id 215 Demonite
    db SKILL_ICEBOLT
    db SKILL_TAKEMAGIC
    db SKILL_EERIELITE
    db $ff
    db $5d, $01, $05, $0f, $52, $00, $20, $00, $43, $00, $2f, $00, $3c, $00, $f4, $01, $c8, $0a, $aa, $8c
    db $dc, $00 ; id 216 1EyeClown
    db SKILL_HEALMORE
    db SKILL_MPASS
    db SKILL_VIVIFY
    db $ff
    db $7f, $01, $05, $0d, $3e, $00, $20, $00, $39, $00, $2a, $00, $3c, $00, $ed, $00, $aa, $14, $32, $8c
    db $fc, $00 ; id 217 DeadNite
    db SKILL_SQUALLHIT
    db SKILL_RAINSLASH
    db SKILL_EVILSLASH
    db $ff
    db $81, $01, $05, $10, $47, $00, $25, $00, $73, $00, $2a, $00, $44, $00, $7c, $00, $96, $c8, $a0, $8c
    db $2c, $01 ; id 218 Gismo
    db SKILL_LIGHTNING
    db SKILL_BIRDBLOW
    db SKILL_PARALYZE
    db $ff
    db $5c, $01, $05, $0f, $43, $00, $48, $00, $3e, $00, $47, $00, $ac, $00, $01, $01, $c8, $0a, $c8, $8c
    db $52, $01 ; id 219 Octogon
    db SKILL_KODANCE
    db SKILL_LUREDANCE
    db $ff
    db $ff
    db $7b, $01, $05, $10, $7d, $00, $2a, $00, $51, $00, $39, $00, $3c, $00, $90, $01, $c8, $a0, $32, $8c
    db $05, $00 ; id 220 Snaily
    db SKILL_MEDITATE
    db SKILL_LOVERAIN
    db $ff
    db $ff
    db $26, $02, $05, $14, $3f, $00, $70, $00, $3f, $00, $53, $00, $d1, $00, $86, $01, $32, $8c, $aa, $aa
    db $08, $00 ; id 221 BoxSlime
    db SKILL_BARRIER
    db SKILL_MAGICWALL
    db SKILL_BLAZEAIR
    db $ff
    db $1d, $02, $05, $17, $70, $00, $92, $00, $79, $00, $52, $00, $85, $00, $75, $01, $c8, $6e, $d2, $aa
    db $35, $00 ; id 222 Vampirus
    db SKILL_ZAP
    db SKILL_SLEEPALL
    db SKILL_SQUALLHIT
    db $ff
    db $38, $02, $05, $12, $5d, $00, $30, $00, $43, $00, $3a, $00, $bb, $00, $c2, $00, $8c, $0a, $a0, $aa
    db $4d, $00 ; id 223 Skullroo
    db SKILL_INCREASE
    db SKILL_HIGHJUMP
    db SKILL_BERSERKER
    db $ff
    db $fe, $01, $05, $17, $67, $00, $35, $00, $48, $00, $43, $00, $76, $00, $f4, $00, $78, $28, $8c, $aa
    db $6c, $00 ; id 224 BullBird
    db SKILL_DEFENSE
    db SKILL_DRAKSLASH
    db SKILL_DEVILCUT
    db $ff
    db $1d, $02, $05, $15, $5d, $00, $92, $00, $4b, $00, $52, $00, $76, $00, $e7, $01, $28, $0a, $be, $aa
    db $98, $00 ; id 225 DanceVegi
    db SKILL_STOPSPELL
    db SKILL_CALLHELP
    db $ff
    db $ff
    db $18, $02, $05, $16, $3f, $00, $a5, $00, $3b, $00, $83, $00, $d1, $00, $d2, $00, $c8, $6e, $d2, $aa
    db $b7, $00 ; id 226 StagBug
    db SKILL_FIREBANE
    db SKILL_VACUSLASH
    db SKILL_BOLTSLASH
    db $ff
    db $2b, $02, $05, $17, $4e, $00, $30, $00, $52, $00, $8d, $00, $76, $00, $a0, $00, $8c, $96, $1e, $aa
    db $bc, $00 ; id 227 ArmorPede
    db SKILL_BLAZEMORE
    db SKILL_CHARGEUP
    db SKILL_GUARDIAN
    db $ff
    db $39, $02, $05, $17, $70, $00, $35, $00, $5d, $00, $8d, $00, $5a, $00, $f4, $00, $be, $aa, $0a, $aa
    db $b1, $00 ; id 228 Catapila
    db SKILL_BEAT
    db SKILL_RAINSLASH
    db SKILL_CURSE
    db $ff
    db $55, $02, $05, $16, $85, $00, $50, $00, $5f, $00, $32, $00, $8c, $00, $0b, $01, $78, $c8, $c8, $aa
    db $d7, $00 ; id 229 DarkEye
    db SKILL_INFERMORE
    db SKILL_MAGICBACK
    db SKILL_WARCRY
    db $ff
    db $16, $02, $05, $15, $44, $00, $75, $00, $3f, $00, $52, $00, $76, $00, $22, $01, $a0, $14, $aa, $aa
    db $dd, $00 ; id 230 Gremlin
    db SKILL_BOOM
    db SKILL_BLAZEAIR
    db SKILL_ICEAIR
    db $ff
    db $1d, $02, $05, $16, $50, $00, $30, $00, $3a, $00, $3f, $00, $69, $00, $86, $01, $be, $14, $0a, $aa
    db $d4, $00 ; id 231 MedusaEye
    db SKILL_ROCKTHROW
    db SKILL_HUSTLE
    db SKILL_IMITATE
    db $ff
    db $00, $02, $05, $15, $3f, $00, $4e, $00, $5d, $00, $70, $00, $53, $00, $d2, $00, $6e, $14, $a0, $aa
    db $ec, $00 ; id 232 EvilArmor
    db SKILL_LIGHTNING
    db SKILL_CURSE
    db SKILL_EERIELITE
    db $ff
    db $47, $02, $05, $17, $4f, $00, $28, $00, $53, $00, $9c, $00, $6c, $00, $fa, $00, $0a, $d2, $c8, $aa
    db $1f, $01 ; id 233 MadMirror
    db SKILL_SPEEDUP
    db SKILL_RADIANT
    db SKILL_AQUAWALL
    db $ff
    db $54, $02, $05, $15, $70, $00, $3f, $00, $3a, $00, $8d, $00, $5a, $00, $b5, $01, $c8, $c8, $14, $aa
    db $20, $01 ; id 234 RogueNite
    db SKILL_HEALUS
    db SKILL_STOPSPELL
    db SKILL_BIATTACK
    db $ff
    db $3d, $02, $05, $15, $5d, $00, $3a, $00, $92, $00, $69, $00, $4c, $00, $04, $01, $32, $32, $96, $aa
    db $66, $00 ; id 235 Dumbira
    db SKILL_HEALMORE
    db SKILL_BOLTSLASH
    db SKILL_POISONAIR
    db $ff
    db $4f, $02, $05, $15, $9f, $00, $3f, $00, $97, $00, $62, $00, $99, $00, $b5, $01, $8c, $14, $28, $aa
    db $11, $00 ; id 236 Metaly
    db SKILL_SLOWALL
    db SKILL_BLAZEAIR
    db SKILL_TATSUCALL
    db $ff
    db $51, $30, $05, $1b, $12, $00, $32, $01, $77, $00, $9f, $01, $8a, $02, $3a, $02, $1e, $aa, $1e, $c8
    db $36, $00 ; id 237 SnakeBat
    db SKILL_BOOM
    db SKILL_INCREASE
    db SKILL_STORMWIND
    db $ff
    db $e8, $03, $05, $1b, $86, $00, $7e, $00, $9f, $00, $83, $00, $b4, $00, $18, $01, $78, $c8, $c8, $c8
    db $4c, $00 ; id 238 GulpBeast
    db SKILL_TWINHITS
    db SKILL_FOCUS
    db SKILL_DODGE
    db $ff
    db $75, $04, $05, $17, $bb, $00, $30, $00, $a5, $00, $53, $00, $4c, $00, $a0, $00, $c8, $96, $8c, $c8
    db $5a, $00 ; id 239 MadGopher
    db SKILL_ZAP
    db SKILL_SLEEPALL
    db SKILL_PSYCHEUP
    db $ff
    db $37, $04, $05, $1b, $89, $00, $59, $00, $97, $00, $84, $00, $f6, $00, $18, $01, $8c, $14, $aa, $c8
    db $71, $00 ; id 240 MistyWing
    db SKILL_BLAZEMORE
    db SKILL_RAMMING
    db SKILL_SUCKAIR
    db $ff
    db $9e, $04, $05, $19, $83, $00, $77, $00, $72, $00, $7e, $00, $d2, $00, $29, $01, $c8, $0a, $32, $c8
    db $77, $00 ; id 241 LandOwl
    db SKILL_HEALMORE
    db SKILL_VACUSLASH
    db SKILL_LUREDANCE
    db $ff
    db $28, $04, $05, $1b, $9c, $00, $40, $00, $b6, $00, $55, $00, $80, $00, $19, $02, $c8, $a0, $14, $c8
    db $9a, $00 ; id 242 Devipine
    db SKILL_MAGICWALL
    db SKILL_PARALYZE
    db SKILL_LOVERAIN
    db $ff
    db $0e, $05, $05, $19, $7f, $00, $3b, $00, $62, $00, $54, $00, $80, $00, $e7, $01, $0a, $c8, $6e, $c8
    db $c2, $00 ; id 243 Belzebub
    db SKILL_DECHAOS
    db SKILL_SLEEPALL
    db SKILL_SICKLICK
    db $ff
    db $0b, $04, $05, $1b, $b1, $00, $7a, $00, $68, $00, $3b, $00, $aa, $00, $c9, $01, $96, $14, $b4, $c8
    db $a7, $00 ; id 244 FooHero
    db SKILL_FIREBANE
    db SKILL_BOUNCE
    db SKILL_CALLHELP
    db $ff
    db $5f, $04, $05, $17, $ac, $00, $88, $00, $8c, $00, $7d, $00, $95, $00, $15, $01, $a0, $8c, $c8, $c8
    db $db, $00 ; id 245 Bubblemon
    db SKILL_HEALMORE
    db SKILL_WATERSHOT
    db SKILL_BIATTACK
    db $ff
    db $42, $05, $05, $1a, $77, $00, $59, $00, $9c, $00, $3b, $00, $55, $00, $18, $01, $b4, $28, $c8, $c8
    db $e0, $00 ; id 246 GoatHorn
    db SKILL_STOPSPELL
    db SKILL_YELLHELP
    db SKILL_BERSERKER
    db $ff
    db $a6, $04, $05, $19, $b0, $00, $59, $00, $7b, $00, $5c, $00, $80, $00, $3d, $02, $c8, $be, $d2, $c8
    db $f6, $00 ; id 247 Spooky
    db SKILL_PANICALL
    db SKILL_SICKLICK
    db $ff
    db $ff
    db $f5, $03, $05, $1a, $5d, $00, $83, $00, $59, $00, $54, $00, $e6, $00, $08, $02, $1e, $c8, $82, $c8
    db $f8, $00 ; id 248 PutrePup
    db SKILL_PSYCHEUP
    db SKILL_SANDSTORM
    db $ff
    db $ff
    db $2a, $05, $05, $1a, $77, $00, $59, $00, $77, $00, $54, $00, $80, $00, $18, $01, $a0, $1e, $28, $c8
    db $0d, $01 ; id 249 Copycat
    db SKILL_TRANSFORM
    db SKILL_DIAGOCALL
    db $ff
    db $ff
    db $28, $04, $05, $1b, $59, $00, $ac, $00, $36, $00, $54, $00, $2b, $01, $29, $01, $3c, $3c, $3c, $c8
    db $24, $01 ; id 250 MetalDrak
    db SKILL_ROCKTHROW
    db SKILL_RADIANT
    db $ff
    db $ff
    db $27, $05, $05, $1c, $a1, $00, $59, $00, $ac, $00, $93, $00, $b4, $00, $d6, $00, $64, $c8, $c8, $c8
    db $3f, $01 ; id 251 RayGigas
    db SKILL_BOUNCE
    db SKILL_FOCUS
    db SKILL_GEYSER
    db $ff
    db $40, $04, $05, $1c, $87, $00, $7e, $00, $cc, $00, $8e, $00, $b4, $00, $c5, $00, $c8, $d2, $1e, $c8
    db $09, $00 ; id 252 PearlGel
    db SKILL_SNOWSTORM
    db SKILL_RAMMING
    db SKILL_MOUTHSHUT
    db $ff
    db $bb, $06, $05, $21, $77, $00, $6c, $00, $74, $00, $a2, $00, $ca, $00, $37, $02, $6e, $78, $82, $d2
    db $27, $00 ; id 253 Gasgon
    db SKILL_FIREBANE
    db SKILL_AQUACUT
    db SKILL_HIGHJUMP
    db $ff
    db $6f, $06, $05, $22, $91, $00, $d2, $00, $6a, $00, $7f, $00, $6d, $00, $cc, $02, $1e, $b4, $aa, $d2
    db $2d, $00 ; id 254 Dragon
    db SKILL_BLAZEMORE
    db SKILL_ROCKTHROW
    db SKILL_SANDSTORM
    db $ff
    db $63, $07, $06, $21, $8d, $00, $45, $00, $c2, $00, $6c, $00, $6a, $00, $61, $01, $c8, $c8, $c8, $d2
    db $57, $00 ; id 255 ArrowDog
    db SKILL_HEALMORE
    db SKILL_LIGHTNING
    db SKILL_DIAGOCALL
    db $ff
    db $cc, $06, $05, $1f, $d2, $00, $4a, $00, $99, $00, $9d, $00, $95, $00, $d6, $01, $64, $c8, $50, $d2
    db $74, $00 ; id 256 KiteHawk
    db SKILL_HEALUS
    db SKILL_ICESTORM
    db SKILL_EERIELITE
    db $ff
    db $6d, $06, $05, $20, $90, $00, $6a, $00, $88, $00, $4a, $00, $f3, $00, $e6, $00, $c8, $0a, $28, $d2
    db $76, $00 ; id 257 StubBird
    db SKILL_DEFEAT
    db SKILL_YELLHELP
    db SKILL_KAMIKAZE
    db $ff
    db $03, $06, $05, $21, $6c, $00, $af, $00, $c2, $00, $c2, $00, $ca, $00, $72, $01, $78, $28, $46, $d2
    db $7d, $00 ; id 258 ZapBird
    db SKILL_VIVIFY
    db SKILL_ULTRADOWN
    db SKILL_STORMWIND
    db $ff
    db $11, $06, $06, $21, $c2, $00, $4a, $00, $9d, $00, $8d, $00, $e8, $00, $47, $02, $46, $c8, $c8, $d2
    db $b4, $00 ; id 259 WeedBug
    db SKILL_TWINHITS
    db SKILL_QUADHITS
    db SKILL_DANCESHUT
    db $ff
    db $e4, $06, $05, $20, $8d, $00, $68, $00, $63, $00, $a5, $00, $95, $00, $29, $02, $28, $78, $5a, $d2
    db $b6, $00 ; id 260 Lipsy
    db SKILL_INFERMORE
    db SKILL_PANICALL
    db SKILL_AHHH
    db $ff
    db $01, $06, $05, $1e, $9b, $00, $61, $00, $96, $00, $64, $00, $78, $00, $d2, $00, $a0, $96, $1e, $d2
    db $c9, $00 ; id 261 MultiEyes
    db SKILL_SURROUND
    db SKILL_PANICALL
    db SKILL_CURSE
    db $ff
    db $cf, $06, $05, $21, $98, $00, $4f, $00, $c8, $00, $6c, $00, $6a, $00, $d6, $01, $5a, $50, $8c, $d2
    db $fd, $00 ; id 262 Shadow
    db SKILL_ZAP
    db SKILL_TRANSFORM
    db SKILL_DODGE
    db $ff
    db $54, $06, $05, $21, $d2, $00, $bd, $00, $bd, $00, $86, $00, $84, $00, $47, $02, $1e, $d2, $28, $d2
    db $06, $01 ; id 263 CaptDead
    db SKILL_HEALMORE
    db SKILL_POISONAIR
    db SKILL_LIFEDANCE
    db $ff
    db $df, $05, $05, $1f, $aa, $00, $c2, $00, $7f, $00, $62, $00, $5c, $00, $5b, $01, $5a, $78, $28, $d2
    db $27, $01 ; id 264 CurseLamp
    db SKILL_BLAZEMORE
    db SKILL_SLIMEBLOW
    db SKILL_CURSE
    db $ff
    db $bc, $05, $05, $21, $af, $00, $cd, $00, $aa, $00, $7f, $00, $8b, $00, $9a, $02, $1e, $c8, $64, $d2
    db $46, $01 ; id 265 Angleron
    db SKILL_RAMMING
    db SKILL_PALSYAIR
    db SKILL_STORMWIND
    db $ff
    db $7a, $06, $05, $21, $8d, $00, $6c, $00, $c7, $00, $a4, $00, $b6, $00, $14, $02, $50, $c8, $0a, $d2
    db $49, $01 ; id 266 Gamanian
    db SKILL_MAGICWALL
    db SKILL_POISONAIR
    db SKILL_LIFESONG
    db $ff
    db $16, $07, $05, $21, $6f, $00, $4f, $00, $c1, $00, $8d, $00, $78, $00, $9a, $02, $6e, $1e, $d2, $d2
    db $55, $01 ; id 267 WhaleMage
    db SKILL_HEALMORE
    db SKILL_QUADHITS
    db SKILL_AQUAWALL
    db $ff
    db $6e, $07, $06, $22, $f3, $00, $fd, $00, $bd, $00, $87, $00, $9c, $00, $55, $01, $dc, $0a, $b4, $d2
    db $13, $00 ; id 268 SpotKing
    db SKILL_HEALALL
    db SKILL_CHANCE
    db SKILL_AHHH
    db $ff
    db $f1, $0d, $06, $26, $fb, $00, $89, $00, $d7, $00, $6b, $00, $8e, $00, $34, $03, $6e, $46, $c8, $dc
    db $3e, $00 ; id 269 SkyDragon
    db SKILL_FAREWELL
    db SKILL_VACUUM
    db SKILL_LOVERAIN
    db $ff
    db $6f, $0e, $06, $26, $f6, $00, $89, $00, $dc, $00, $93, $00, $bd, $00, $b8, $01, $64, $c8, $dc, $dc
    db $47, $00 ; id 270 Tonguella
    db SKILL_SCORCHING
    db SKILL_CHARGEUP
    db SKILL_WARCRY
    db $ff
    db $38, $0e, $05, $27, $a7, $00, $73, $00, $c4, $00, $79, $00, $6e, $00, $8d, $01, $1e, $3c, $aa, $dc
    db $4b, $00 ; id 271 Saccer
    db SKILL_BARRIER
    db SKILL_VACUUM
    db SKILL_HUSTLE
    db $ff
    db $23, $0e, $05, $26, $77, $00, $73, $00, $ba, $00, $78, $00, $5a, $00, $7f, $01, $1e, $3c, $be, $dc
    db $6b, $00 ; id 272 Wyvern
    db SKILL_FIREBOLT
    db SKILL_LIGHTNING
    db SKILL_FOCUS
    db $ff
    db $d4, $0e, $05, $26, $a7, $00, $73, $00, $c6, $00, $7f, $00, $93, $00, $dd, $02, $b4, $c8, $d2, $dc
    db $72, $00 ; id 273 AquaHawk
    db SKILL_INFERMOST
    db SKILL_POISONHIT
    db SKILL_PSYCHEUP
    db $ff
    db $d8, $0e, $05, $25, $8a, $00, $84, $00, $d7, $00, $69, $00, $a9, $00, $30, $02, $1e, $78, $aa, $dc
    db $7e, $00 ; id 274 Garudian
    db SKILL_VACUSLASH
    db SKILL_BOLTSLASH
    db SKILL_CURSE
    db $ff
    db $47, $0f, $06, $24, $8c, $00, $55, $00, $b6, $00, $7f, $00, $bb, $00, $d0, $02, $c8, $14, $d2, $dc
    db $bd, $00 ; id 275 Eyeder
    db SKILL_BLIZZARD
    db SKILL_HIGHJUMP
    db SKILL_DODGE
    db $ff
    db $a2, $0e, $05, $26, $d8, $00, $89, $00, $d7, $00, $85, $00, $63, $00, $ee, $02, $8c, $14, $46, $dc
    db $de, $00 ; id 276 ArcDemon
    db SKILL_HEALALL
    db SKILL_MASSACRE
    db SKILL_TWINSLASH
    db $ff
    db $71, $0e, $06, $28, $ab, $00, $76, $00, $c8, $00, $a0, $00, $74, $00, $92, $03, $c8, $64, $5a, $dc
    db $df, $00 ; id 277 Lionex
    db SKILL_SPEEDUP
    db SKILL_BARRIER
    db SKILL_SAMSICALL
    db $ff
    db $7c, $0f, $05, $27, $f6, $00, $89, $00, $bb, $00, $9c, $00, $9c, $00, $30, $02, $14, $c8, $c8, $dc
    db $e3, $00 ; id 278 GateGuard
    db SKILL_DEFENSE
    db SKILL_DRAKSLASH
    db SKILL_EVILSLASH
    db $ff
    db $ed, $0e, $05, $27, $fb, $00, $dd, $00, $dd, $00, $7f, $00, $88, $00, $2d, $02, $5a, $c8, $c8, $dc
    db $eb, $00 ; id 279 Centasaur
    db SKILL_BLIZZARD
    db SKILL_ZOMBIECUT
    db SKILL_BAZOOCALL
    db $ff
    db $70, $0e, $05, $29, $dc, $00, $50, $00, $00, $01, $a6, $00, $7e, $00, $44, $02, $78, $c8, $0a, $dc
    db $29, $01 ; id 280 Roboster
    db SKILL_HEALALL
    db SKILL_INCREASE
    db SKILL_GIGASLASH
    db $ff
    db $88, $0f, $06, $29, $e1, $00, $73, $00, $d9, $00, $b4, $00, $b1, $00, $e0, $02, $1e, $dc, $1e, $dc
    db $a6, $00 ; id 281 Eggplaton
    db SKILL_ROCKTHROW
    db SKILL_QUADHITS
    db SKILL_SUCKALL
    db $ff
    db $7b, $0d, $05, $27, $77, $00, $d7, $00, $c7, $00, $d3, $00, $bd, $00, $1c, $01, $0a, $c8, $28, $dc
    db $4a, $01 ; id 282 Clawster
    db SKILL_REVIVE
    db SKILL_BOLTSLASH
    db SKILL_DANCESHUT
    db $ff
    db $aa, $0d, $05, $29, $dd, $00, $3c, $00, $09, $01, $d2, $00, $74, $00, $2d, $02, $8c, $96, $28, $dc
    db $50, $01 ; id 283 MerTiger
    db SKILL_BEDRAGON
    db SKILL_BEASTCUT
    db SKILL_DEVILCUT
    db $ff
    db $6b, $0e, $05, $28, $e1, $00, $73, $00, $e6, $00, $90, $00, $77, $00, $7f, $01, $e6, $6e, $c8, $dc
    db $04, $00 ; id 284 TreeSlime
    db SKILL_FAREWELL
    db SKILL_STOPSPELL
    db SKILL_MEDITATE
    db $ff
    db $72, $1b, $05, $2e, $97, $00, $cd, $00, $ab, $00, $eb, $00, $50, $01, $0f, $03, $28, $28, $d2, $e6
    db $2b, $00 ; id 285 Swordgon
    db SKILL_PARALYZE
    db SKILL_SQUALLHIT
    db SKILL_RAMMING
    db $ff
    db $ea, $1b, $06, $2e, $f9, $00, $ab, $00, $08, $01, $e2, $00, $87, $00, $ae, $01, $be, $c8, $50, $e6
    db $51, $00 ; id 286 SuperTen
    db SKILL_PANICALL
    db SKILL_DIAGOCALL
    db SKILL_IMITATE
    db $ff
    db $76, $1b, $05, $2c, $26, $01, $6a, $00, $8e, $00, $0d, $01, $f5, $00, $61, $01, $96, $14, $6e, $e6
    db $54, $00 ; id 287 HammerMan
    db SKILL_NUMBOFF
    db SKILL_PSYCHEUP
    db SKILL_BLADED
    db $ff
    db $30, $1c, $06, $2d, $d2, $00, $bd, $00, $c9, $00, $be, $00, $1f, $01, $93, $01, $64, $8c, $c8, $e6
    db $5d, $00 ; id 288 Goategon
    db SKILL_TWINHITS
    db SKILL_MAGICWALL
    db SKILL_SUCKAIR
    db $ff
    db $ce, $1b, $06, $2b, $c1, $00, $4c, $01, $c9, $00, $8c, $00, $80, $01, $41, $03, $14, $8c, $b4, $e6
    db $73, $00 ; id 289 Dracky
    db SKILL_THORDAIN
    db SKILL_SLEEPAIR
    db SKILL_FOCUS
    db $ff
    db $b2, $1c, $05, $2a, $ab, $00, $95, $00, $9c, $00, $88, $00, $1f, $01, $3a, $02, $c8, $c8, $8c, $e6
    db $44, $01 ; id 290 PutreFish
    db SKILL_WATERSHOT
    db SKILL_SICKLICK
    db $ff
    db $ff
    db $f5, $1c, $05, $2d, $d1, $00, $6a, $00, $b5, $00, $ce, $00, $0e, $01, $a5, $02, $1e, $78, $b4, $e6
    db $94, $00 ; id 291 AmberWeed
    db SKILL_SACRIFICE
    db SKILL_QUADHITS
    db SKILL_GUARDIAN
    db $ff
    db $da, $1d, $06, $2d, $0d, $01, $5b, $01, $ba, $00, $cb, $00, $80, $01, $93, $01, $c8, $c8, $82, $e6
    db $c3, $00 ; id 292 WarMantis
    db SKILL_SLEEPALL
    db SKILL_RAINSLASH
    db SKILL_TWINSLASH
    db $ff
    db $49, $1d, $06, $2e, $08, $01, $96, $00, $0d, $01, $f9, $00, $f5, $00, $8f, $03, $32, $c8, $0a, $e6
    db $e1, $00 ; id 293 Orc
    db SKILL_BLAZEMOST
    db SKILL_BERSERKER
    db SKILL_SUCKALL
    db $ff
    db $ed, $1d, $06, $2c, $bd, $00, $6a, $00, $bd, $00, $88, $00, $c3, $00, $89, $03, $aa, $50, $8c, $e6
    db $e4, $00 ; id 294 ChopClown
    db SKILL_BOUNCE
    db SKILL_PANIDANCE
    db SKILL_DODGE
    db $ff
    db $59, $1d, $06, $2d, $d2, $00, $0d, $01, $f4, $00, $af, $00, $5d, $01, $98, $03, $32, $c8, $28, $e6
    db $fa, $00 ; id 295 Mummy
    db SKILL_REVIVE
    db SKILL_BAZOOCALL
    db SKILL_MEDITATE
    db $ff
    db $26, $1d, $05, $2c, $13, $01, $c9, $00, $03, $01, $f5, $00, $d5, $00, $08, $02, $14, $28, $c8, $e6
    db $0e, $01 ; id 296 MadSpirit
    db SKILL_DEFEAT
    db SKILL_YELLHELP
    db SKILL_ULTRADOWN
    db $ff
    db $a1, $1c, $06, $2d, $c9, $00, $0d, $01, $17, $01, $0d, $01, $d7, $00, $87, $03, $8c, $0a, $c8, $e6
    db $0f, $01 ; id 297 PomPomBom
    db SKILL_FIREBOLT
    db SKILL_SPEEDUP
    db SKILL_IMITATE
    db $ff
    db $d9, $1b, $05, $2b, $26, $01, $0d, $01, $e7, $00, $3d, $01, $d5, $00, $92, $03, $50, $64, $c8, $e6
    db $34, $01 ; id 298 BombCrag
    db SKILL_SACRIFICE
    db SKILL_FAREWELL
    db SKILL_STRONGD
    db $ff
    db $62, $1b, $05, $2c, $17, $01, $ab, $00, $c9, $00, $f4, $00, $38, $00, $9c, $03, $32, $c8, $c8, $e6
    db $57, $01 ; id 299 Octoraid
    db SKILL_BEDRAGON
    db SKILL_POISONHIT
    db SKILL_RAINSLASH
    db $ff
    db $31, $1c, $06, $2e, $44, $01, $f9, $00, $50, $01, $38, $01, $da, $01, $c5, $01, $c8, $8c, $64, $e6
    db $33, $00 ; id 300 Andreal
    db SKILL_STOPSPELL
    db SKILL_WHITEFIRE
    db SKILL_STORMWIND
    db $ff
    db $8d, $33, $06, $31, $65, $01, $30, $01, $d6, $00, $fb, $00, $32, $01, $a1, $03, $c8, $14, $c8, $f0
    db $38, $00 ; id 301 GreatDrak
    db SKILL_INFERMOST
    db SKILL_VACUUM
    db SKILL_MULTICUT
    db $ff
    db $d3, $33, $06, $30, $21, $01, $74, $00, $76, $01, $56, $01, $cb, $01, $b9, $03, $be, $c8, $0a, $f0
    db $5f, $00 ; id 302 Trumpeter
    db SKILL_VACUUM
    db SKILL_CHARGEUP
    db SKILL_STRONGD
    db SKILL_MEDITATE
    db $00, $37, $06, $31, $fb, $00, $b5, $00, $65, $01, $05, $01, $61, $01, $3e, $02, $c8, $d2, $5a, $f0
    db $37, $01 ; id 303 ProtoMech
    db SKILL_HEALUS
    db SKILL_MAGICWALL
    db SKILL_BIRDBLOW
    db SKILL_SUCKALL
    db $1a, $35, $06, $31, $d2, $00, $a1, $00, $f8, $00, $b9, $00, $32, $01, $a5, $02, $c8, $96, $d2, $f0
    db $c6, $00 ; id 304 Armorpion
    db SKILL_DEFENSE
    db SKILL_POISONAIR
    db SKILL_BLADED
    db $ff
    db $a9, $37, $06, $34, $00, $01, $0c, $01, $71, $01, $38, $01, $b2, $01, $86, $03, $64, $c8, $5a, $f0
    db $c7, $00 ; id 305 Digster
    db SKILL_THORDAIN
    db SKILL_POISONHIT
    db SKILL_GEYSER
    db $ff
    db $82, $37, $06, $31, $76, $01, $ad, $00, $d6, $00, $75, $01, $96, $00, $ad, $03, $b4, $28, $32, $f0
    db $e5, $00 ; id 306 BossTroll
    db SKILL_TWINHITS
    db SKILL_ROCKTHROW
    db SKILL_QUADHITS
    db $ff
    db $61, $36, $06, $31, $8f, $01, $ad, $00, $4e, $01, $00, $01, $e5, $00, $5e, $01, $28, $0a, $be, $f0
    db $e8, $00 ; id 307 MadKnight
    db SKILL_HELLBLAST
    db SKILL_CURSE
    db SKILL_THICKFOG
    db $ff
    db $5b, $35, $06, $33, $fb, $00, $12, $01, $5a, $01, $0c, $01, $f7, $00, $9a, $03, $32, $c8, $32, $f0
    db $e2, $00 ; id 308 Ogre
    db SKILL_HEALALL
    db SKILL_WHITEFIRE
    db SKILL_WHITEAIR
    db $ff
    db $a9, $33, $06, $30, $24, $01, $f7, $00, $dd, $00, $1c, $01, $47, $01, $5b, $02, $be, $50, $14, $f0
    db $07, $01 ; id 309 DeadNoble
    db SKILL_CHANCE
    db SKILL_FOCUS
    db SKILL_LIFESONG
    db $ff
    db $8b, $34, $06, $31, $65, $01, $78, $00, $79, $01, $e0, $00, $b2, $01, $ac, $03, $14, $c8, $5a, $f0
    db $0a, $01 ; id 310 Skeletor
    db SKILL_BLAZEMOST
    db SKILL_YELLHELP
    db SKILL_PALSYAIR
    db $ff
    db $c4, $36, $06, $33, $d2, $00, $df, $00, $00, $01, $d9, $00, $bd, $00, $c9, $02, $1e, $aa, $5a, $f0
    db $33, $01 ; id 311 StoneMan
    db SKILL_HEALUSALL
    db SKILL_QUADHITS
    db SKILL_IMITATE
    db $ff
    db $f0, $33, $06, $31, $7d, $01, $9b, $00, $1e, $01, $bc, $00, $5f, $00, $0f, $03, $96, $82, $6e, $f0
    db $47, $01 ; id 312 FishRider
    db SKILL_EXPLODET
    db SKILL_SLEEPALL
    db SKILL_MOUTHSHUT
    db $ff
    db $a3, $33, $06, $31, $5a, $01, $d6, $00, $dc, $00, $9c, $00, $b4, $00, $3e, $02, $96, $8c, $3c, $f0
    db $51, $01 ; id 313 AxeShark
    db SKILL_BARRIER
    db SKILL_GIGASLASH
    db SKILL_AQUAWALL
    db $ff
    db $aa, $38, $06, $31, $2a, $01, $fe, $00, $81, $01, $56, $01, $46, $01, $4e, $02, $c8, $14, $c8, $f0
    db $56, $01 ; id 314 Aquadon
    db SKILL_FAREWELL
    db SKILL_BIGBANG
    db SKILL_HUSTLE
    db SKILL_DANCESHUT
    db $50, $36, $06, $31, $8f, $01, $0c, $01, $47, $01, $ad, $00, $9f, $00, $91, $03, $aa, $14, $64, $f0
    db $54, $01 ; id 315 Digong
    db SKILL_BLIZZARD
    db SKILL_TIDALWAVE
    db SKILL_EVILSLASH
    db $ff
    db $c7, $33, $06, $34, $38, $01, $5a, $01, $5e, $01, $a6, $00, $6d, $00, $9f, $03, $96, $32, $5a, $f0
    db $17, $00 ; id 316 MetalKing
    db SKILL_REVIVE
    db SKILL_SURROUND
    db SKILL_PARALYZE
    db SKILL_DODGE
    db $49, $0b, $06, $36, $28, $00, $46, $00, $18, $01, $f5, $02, $e7, $03, $e7, $03, $14, $dc, $c8, $fa
    db $3f, $00 ; id 317 Serpentia
    db SKILL_FIREBOLT
    db SKILL_QUADHITS
    db SKILL_RADIANT
    db SKILL_WARCRY
    db $13, $48, $06, $37, $7e, $01, $96, $00, $64, $01, $15, $01, $5e, $01, $b2, $03, $c8, $c8, $c8, $fa
    db $3b, $00 ; id 318 Coatol
    db SKILL_STOPSPELL
    db SKILL_FIRESLASH
    db SKILL_VACUSLASH
    db SKILL_GUARDIAN
    db $29, $42, $06, $37, $a9, $01, $11, $01, $26, $01, $c7, $00, $e1, $00, $8e, $03, $c8, $28, $d2, $fa
    db $3c, $00 ; id 319 Orochi
    db SKILL_MEGAMAGIC
    db SKILL_ROCKTHROW
    db SKILL_RAMMING
    db SKILL_SUCKAIR
    db $75, $48, $06, $39, $ba, $01, $ba, $00, $66, $01, $b6, $00, $b4, $00, $9e, $03, $aa, $32, $b4, $fa
    db $3d, $00 ; id 320 BattleRex
    db SKILL_EXPLODET
    db SKILL_SLEEPALL
    db SKILL_LUREDANCE
    db SKILL_MEDITATE
    db $d6, $40, $06, $39, $64, $01, $22, $00, $5c, $01, $c2, $00, $de, $00, $94, $03, $64, $96, $c8, $fa
    db $7f, $00 ; id 321 WhipBird
    db SKILL_HEALALL
    db SKILL_HELLBLAST
    db SKILL_POISONAIR
    db SKILL_SANDSTORM
    db $b0, $45, $06, $39, $17, $02, $ef, $00, $69, $01, $c3, $00, $c7, $00, $b5, $03, $be, $6e, $32, $fa
    db $83, $00 ; id 322 Shantak
    db SKILL_INFERMOST
    db SKILL_POISONHIT
    db SKILL_MULTICUT
    db $ff
    db $7d, $4b, $06, $39, $ba, $01, $2b, $01, $22, $01, $be, $00, $4b, $01, $a8, $03, $c8, $78, $8c, $fa
    db $a2, $00 ; id 323 Rosevine
    db SKILL_SPEEDUP
    db SKILL_ROCKTHROW
    db SKILL_HUSTLE
    db SKILL_IMITATE
    db $ea, $47, $06, $39, $af, $01, $30, $00, $5b, $01, $ac, $00, $e2, $00, $c9, $03, $64, $c8, $c8, $fa
    db $e6, $00 ; id 324 Grendal
    db SKILL_SACRIFICE
    db SKILL_VACUUM
    db SKILL_EVILSLASH
    db SKILL_TWINSLASH
    db $37, $49, $06, $37, $6e, $01, $73, $00, $71, $01, $d4, $00, $74, $00, $9e, $03, $be, $c8, $1e, $fa
    db $e7, $00 ; id 325 Akubar
    db SKILL_BLAZEMOST
    db SKILL_TIDALWAVE
    db SKILL_PSYCHEUP
    db $ff
    db $4f, $45, $06, $38, $ba, $01, $a4, $02, $64, $01, $b6, $00, $e1, $00, $b4, $03, $c8, $0a, $28, $fa
    db $ed, $00 ; id 326 Jamirus
    db SKILL_HEALALL
    db SKILL_MULTICUT
    db SKILL_PALSYAIR
    db $ff
    db $20, $42, $06, $39, $ba, $01, $2b, $01, $60, $01, $dd, $00, $35, $01, $9e, $03, $64, $96, $32, $fa
    db $f0, $00 ; id 327 LampGenie
    db SKILL_EXPLODET
    db SKILL_MAGICWALL
    db SKILL_ROBDANCE
    db SKILL_SEALPRAY
    db $3d, $44, $06, $34, $0a, $01, $69, $01, $36, $01, $cb, $00, $aa, $00, $98, $03, $0a, $c8, $a0, $fa
    db $08, $01 ; id 328 WhiteKing
    db SKILL_TWINHITS
    db SKILL_CHANCE
    db SKILL_ULTRADOWN
    db $ff
    db $e2, $4a, $06, $35, $2a, $01, $64, $00, $1b, $01, $c2, $00, $96, $00, $b6, $03, $0a, $dc, $c8, $fa
    db $10, $01 ; id 329 Niterich
    db SKILL_WHITEFIRE
    db SKILL_QUADHITS
    db SKILL_DEMAGIC
    db $ff
    db $c2, $3b, $06, $39, $64, $01, $7e, $01, $a9, $01, $85, $01, $d6, $01, $c0, $03, $c8, $8c, $64, $fa
    db $53, $01 ; id 330 KingSquid
    db SKILL_HEALUSALL
    db SKILL_TIDALWAVE
    db SKILL_SIDESTEP
    db SKILL_SUCKALL
    db $d2, $48, $06, $36, $a0, $01, $5a, $00, $7c, $01, $91, $00, $6e, $00, $9c, $03, $c8, $32, $c8, $fa
    db $58, $01 ; id 331 Grakos
    db SKILL_BLIZZARD
    db SKILL_CHARGEUP
    db SKILL_DODGE
    db $ff
    db $5b, $44, $06, $36, $85, $01, $64, $01, $97, $01, $0a, $01, $35, $01, $98, $03, $c8, $aa, $8c, $fa
    db $0f, $00 ; id 332 Slabbit
    db SKILL_ODDDANCE
    db SKILL_SIDESTEP
    db SKILL_LEGSWEEP
    db $ff
    db $00, $00, $07, $07, $26, $00, $14, $00, $27, $00, $14, $00, $56, $00, $7f, $00, $78, $8c, $64, $5a
    db $1c, $01 ; id 333 CoilBird
    db SKILL_INFERNOS
    db SKILL_NUMBOFF
    db SKILL_SUCKALL
    db $ff
    db $00, $00, $07, $09, $2f, $00, $2a, $00, $2a, $00, $30, $00, $45, $00, $50, $00, $82, $c8, $8c, $5a
    db $28, $00 ; id 334 FairyDrak
    db SKILL_SURROUND
    db SKILL_SLEEPAIR
    db SKILL_LUSHLICKS
    db $ff
    db $00, $00, $07, $10, $3d, $00, $46, $00, $4b, $00, $4b, $00, $6c, $00, $86, $00, $c8, $d2, $14, $8c
    db $97, $00 ; id 335 Oniono
    db SKILL_ROBMAGIC
    db SKILL_CHARGEUP
    db SKILL_SLEEPAIR
    db $ff
    db $00, $00, $07, $0f, $53, $00, $78, $00, $47, $00, $2a, $00, $9d, $00, $f0, $00, $b4, $78, $28, $8c
    db $9e, $00 ; id 336 EvilSeed
    db SKILL_CLEANCUT
    db SKILL_PARALYZE
    db SKILL_RADIANT
    db $ff
    db $00, $00, $07, $11, $3c, $00, $32, $00, $2d, $00, $46, $00, $35, $00, $90, $01, $28, $d2, $3c, $8c
    db $1b, $01 ; id 337 MadCandle
    db SKILL_BLAZE
    db SKILL_PSYCHEUP
    db $ff
    db $ff
    db $00, $00, $07, $11, $3f, $00, $34, $00, $50, $00, $55, $00, $66, $00, $be, $00, $c8, $64, $c8, $8c
    db $24, $00 ; id 338 DragonKid
    db SKILL_BLAZEAIR
    db SKILL_SLEEPAIR
    db SKILL_DODGE
    db $ff
    db $00, $00, $07, $19, $3e, $00, $87, $00, $6f, $00, $63, $00, $73, $00, $22, $01, $78, $82, $d2, $c8
    db $6e, $00 ; id 339 DuckKite
    db SKILL_SLEEP
    db SKILL_PANICALL
    db SKILL_CURSE
    db $ff
    db $00, $00, $07, $19, $51, $00, $51, $00, $8f, $00, $76, $00, $b6, $00, $be, $00, $c8, $14, $aa, $c8
    db $90, $00 ; id 340 WingTree
    db SKILL_FAREWELL
    db SKILL_WINDBEAST
    db SKILL_ZOMBIECUT
    db $ff
    db $00, $00, $07, $18, $71, $00, $a0, $00, $9b, $00, $57, $00, $62, $00, $bb, $00, $6e, $78, $82, $c8
    db $b0, $00 ; id 341 GiantSlug
    db SKILL_WATERSHOT
    db SKILL_LUSHLICKS
    db SKILL_DODGE
    db $ff
    db $00, $00, $07, $1a, $54, $00, $4f, $00, $8b, $00, $62, $00, $58, $00, $c5, $00, $96, $d2, $0a, $c8
    db $b2, $00 ; id 342 Gophecada
    db SKILL_BEAT
    db SKILL_MAGICBACK
    db SKILL_CALLHELP
    db $ff
    db $00, $00, $07, $15, $8d, $00, $3f, $00, $7b, $00, $61, $00, $5d, $00, $a0, $00, $c8, $1e, $28, $aa
    db $f9, $00 ; id 343 RotRaven
    db SKILL_LIGHTNING
    db SKILL_BOLTSLASH
    db SKILL_KAMIKAZE
    db $ff
    db $00, $00, $07, $19, $6f, $00, $4c, $00, $76, $00, $5b, $00, $98, $00, $79, $01, $28, $d2, $8c, $c8
    db $31, $00 ; id 344 Chamelgon
    db SKILL_PANICALL
    db SKILL_PARALYZE
    db SKILL_PALSYAIR
    db $ff
    db $00, $00, $07, $21, $8d, $00, $cd, $00, $6f, $00, $92, $00, $7e, $00, $5b, $01, $5a, $c8, $d2, $d2
    db $6f, $00 ; id 345 MadPecker
    db SKILL_INFERMORE
    db SKILL_DEFENSE
    db SKILL_VACUSLASH
    db $ff
    db $00, $00, $07, $23, $bd, $00, $4e, $00, $ca, $00, $77, $00, $c4, $00, $68, $01, $c8, $6e, $28, $dc
    db $8d, $00 ; id 346 MadPlant
    db SKILL_DEFENSE
    db SKILL_SLOWALL
    db SKILL_POISONAIR
    db $ff
    db $00, $00, $07, $23, $db, $00, $15, $01, $77, $00, $62, $00, $b6, $00, $ea, $02, $50, $32, $c8, $dc
    db $9b, $00 ; id 347 FaceTree
    db SKILL_STOPSPELL
    db SKILL_CURSE
    db SKILL_ROBDANCE
    db $ff
    db $00, $00, $07, $23, $c2, $00, $ca, $00, $77, $00, $64, $00, $63, $00, $f1, $01, $14, $c8, $96, $dc
    db $9d, $00 ; id 348 BeanMan
    db SKILL_TWINHITS
    db SKILL_RAINSLASH
    db SKILL_TWINSLASH
    db $ff
    db $00, $00, $07, $21, $8d, $00, $c8, $00, $af, $00, $6f, $00, $91, $00, $37, $02, $1e, $b4, $82, $d2
    db $b1, $00 ; id 349 Catapila
    db SKILL_INCREASE
    db SKILL_POISONHIT
    db SKILL_THICKFOG
    db $ff
    db $00, $00, $07, $24, $6f, $00, $6f, $00, $7c, $00, $7f, $00, $b1, $00, $8d, $02, $6e, $c8, $0a, $dc
    db $1d, $01 ; id 350 Facer
    db SKILL_INFERMORE
    db SKILL_SACRIFICE
    db SKILL_LIFESONG
    db $ff
    db $00, $00, $07, $23, $72, $00, $cf, $00, $77, $00, $a4, $00, $7b, $00, $19, $02, $3c, $be, $8c, $dc
    db $23, $01 ; id 351 Voodoll
    db SKILL_DEFENSE
    db SKILL_SURROUND
    db SKILL_PANICALL
    db $ff
    db $00, $00, $07, $21, $8d, $00, $8d, $00, $84, $00, $91, $00, $84, $00, $d6, $01, $0a, $32, $8c, $dc
    db $32, $01 ; id 352 Golem
    db SKILL_CHARGEUP
    db SKILL_PSYCHEUP
    db SKILL_MEDITATE
    db $ff
    db $00, $00, $07, $23, $f9, $00, $72, $00, $c2, $00, $70, $00, $60, $00, $91, $02, $a0, $a0, $a0, $dc
    db $4c, $01 ; id 353 RogueWave
    db SKILL_WATERSHOT
    db SKILL_POISONAIR
    db SKILL_AQUAWALL
    db $ff
    db $00, $00, $07, $23, $77, $00, $4e, $00, $e0, $00, $88, $00, $c4, $00, $19, $02, $32, $c8, $a0, $dc
    db $08, $00 ; id 354 BoxSlime
    db SKILL_BLAZEMOST
    db SKILL_INCREASE
    db SKILL_RAMMING
    db $ff
    db $00, $00, $07, $2e, $af, $00, $73, $00, $e1, $00, $ba, $00, $b3, $00, $79, $02, $c8, $32, $c8, $f0
    db $0e, $00 ; id 355 SlimeBorg
    db SKILL_WHITEFIRE
    db SKILL_LIGHTNING
    db SKILL_RAINSLASH
    db SKILL_BLADED
    db $00, $00, $07, $2d, $1b, $01, $a5, $00, $e9, $00, $c7, $00, $e3, $00, $81, $02, $c8, $82, $c8, $f0
    db $61, $00 ; id 356 DarkHorn
    db SKILL_SLEEPALL
    db SKILL_STOPSPELL
    db SKILL_PSYCHEUP
    db SKILL_RAMMING
    db $00, $00, $07, $2d, $cd, $00, $8d, $00, $eb, $00, $b7, $00, $be, $00, $c0, $03, $c8, $64, $96, $f0
    db $9f, $00 ; id 357 ManEater
    db SKILL_DRAKSLASH
    db SKILL_PSYCHEUP
    db SKILL_PALSYAIR
    db SKILL_PANIDANCE
    db $00, $00, $07, $2c, $ba, $00, $f9, $00, $c7, $00, $72, $00, $b9, $00, $d0, $02, $8c, $82, $50, $f0
    db $a0, $00 ; id 358 Snapper
    db SKILL_STOPSPELL
    db SKILL_YELLHELP
    db SKILL_RAINSLASH
    db SKILL_KODANCE
    db $00, $00, $07, $2e, $cb, $00, $c3, $00, $ec, $00, $85, $00, $be, $00, $44, $02, $3c, $d2, $3c, $f0
    db $a1, $00 ; id 359 GhosTree
    db SKILL_BLIZZARD
    db SKILL_ROBMAGIC
    db SKILL_LUREDANCE
    db SKILL_EERIELITE
    db $00, $00, $07, $2d, $96, $00, $82, $00, $ee, $00, $96, $00, $c8, $00, $d7, $03, $28, $6e, $c8, $f0
    db $d9, $00 ; id 360 SkulRider
    db SKILL_FIRESLASH
    db SKILL_EVILSLASH
    db SKILL_BIGTRIP
    db $ff
    db $00, $00, $07, $2c, $bb, $00, $9c, $00, $da, $00, $7e, $00, $79, $01, $3e, $03, $8c, $78, $28, $f0
    db $ea, $00 ; id 361 Gigantes
    db SKILL_SLIMEBLOW
    db SKILL_QUADHITS
    db SKILL_CHARGEUP
    db $ff
    db $00, $00, $07, $2c, $73, $01, $18, $00, $5f, $01, $60, $00, $56, $00, $2d, $02, $c8, $14, $c8, $f0
    db $fe, $00 ; id 362 Skulpent
    db SKILL_DEFEAT
    db SKILL_POISONHIT
    db SKILL_DODGE
    db $ff
    db $00, $00, $07, $2c, $ba, $00, $b3, $00, $f4, $00, $cc, $00, $9c, $00, $95, $03, $8c, $c8, $0a, $f0
    db $41, $01 ; id 363 Aquarella
    db SKILL_BARRIER
    db SKILL_SQUALLHIT
    db SKILL_SUCKAIR
    db SKILL_GEYSER
    db $00, $00, $07, $2c, $9c, $00, $92, $00, $bd, $00, $9a, $00, $d1, $00, $fb, $02, $8c, $aa, $14, $f0
    db $18, $00 ; id 364 GoldSlime
    db SKILL_CHANCE
    db SKILL_BIGBANG
    db SKILL_SURGE
    db $ff
    db $00, $00, $07, $37, $7b, $00, $4b, $03, $e6, $00, $4b, $03, $8a, $02, $e7, $03, $b4, $c8, $28, $fa
    db $19, $00 ; id 365 GranSlime
    db SKILL_HEALUS
    db SKILL_FAREWELL
    db SKILL_FOCUS
    db SKILL_DODGE
    db $00, $00, $07, $39, $90, $01, $64, $00, $27, $01, $97, $00, $09, $01, $e7, $03, $96, $aa, $3c, $fa
    db $40, $00 ; id 366 Divinegon
    db SKILL_REVIVE
    db SKILL_HELLBLAST
    db SKILL_WHITEAIR
    db SKILL_MEDITATE
    db $00, $00, $07, $38, $c5, $01, $78, $00, $9a, $01, $cd, $00, $f0, $00, $e7, $03, $d2, $b4, $1e, $fa
    db $60, $00 ; id 367 KingLeo
    db SKILL_FIREBOLT
    db SKILL_WHITEFIRE
    db SKILL_WHITEAIR
    db SKILL_QUADHITS
    db $00, $00, $07, $37, $1d, $01, $08, $01, $5e, $01, $c3, $00, $fe, $00, $d5, $03, $c8, $c8, $c8, $fa
    db $81, $00 ; id 368 RainHawk
    db SKILL_MEGAMAGIC
    db SKILL_SURGE
    db SKILL_STRONGD
    db $ff
    db $00, $00, $07, $37, $90, $01, $29, $02, $4a, $01, $d2, $00, $58, $01, $e7, $03, $c8, $d2, $3c, $fa
    db $ee, $00 ; id 369 Durran
    db SKILL_VACUUM
    db SKILL_DRAKSLASH
    db SKILL_GIGASLASH
    db SKILL_DEMAGIC
    db $00, $00, $07, $37, $90, $01, $a9, $01, $52, $01, $dc, $00, $c6, $01, $b6, $03, $3c, $c8, $28, $fa
    db $0c, $01 ; id 370 Lazamanus
    db SKILL_HEALALL
    db SKILL_KODANCE
    db SKILL_LIFEDANCE
    db SKILL_BLADED
    db $00, $00, $07, $39, $a9, $01, $28, $00, $36, $01, $b9, $00, $0c, $01, $d4, $03, $28, $c8, $8c, $fa
    db $35, $01 ; id 371 GoldGolem
    db SKILL_BIGBANG
    db SKILL_DRAKSLASH
    db SKILL_SURGE
    db SKILL_BAZOOCALL
    db $00, $00, $07, $37, $a9, $01, $50, $00, $1d, $01, $bb, $01, $fe, $00, $e7, $03, $c8, $d2, $6e, $fa
    db $4a, $00 ; id 372 PillowRat
    db SKILL_UPPER
    db SKILL_MAGICBACK
    db SKILL_NAPATTACK
    db $ff
    db $00, $00, $07, $12, $58, $00, $5c, $00, $7f, $00, $5d, $00, $45, $00, $7f, $01, $c8, $c8, $50, $96
    db $bc, $00 ; id 373 ArmorPede
    db SKILL_BEAT
    db SKILL_STOPSPELL
    db SKILL_TWINSLASH
    db $ff
    db $00, $00, $07, $1c, $7b, $00, $ad, $00, $77, $00, $a6, $00, $b4, $00, $65, $01, $46, $64, $d2, $aa
    db $5e, $00 ; id 374 WildApe
    db SKILL_FAREWELL
    db SKILL_PANICALL
    db SKILL_BIATTACK
    db SKILL_WARCRY
    db $00, $00, $07, $20, $90, $00, $40, $00, $c6, $00, $4f, $00, $98, $00, $c5, $01, $c8, $96, $1e, $96
    db $4a, $01 ; id 375 Clawster
    db SKILL_VIVIFY
    db SKILL_IRONIZE
    db SKILL_CLEANCUT
    db SKILL_KODANCE
    db $00, $00, $07, $2a, $e6, $00, $12, $01, $e2, $00, $10, $01, $32, $01, $f1, $02, $0a, $c8, $dc, $b4
    db $92, $00 ; id 376 Gulpple
    db SKILL_HEALUS
    db SKILL_SLEEP
    db SKILL_CHANCE
    db SKILL_AQUAWALL
    db $00, $00, $07, $25, $a6, $00, $9f, $00, $d6, $00, $d4, $00, $9b, $00, $eb, $02, $d2, $28, $d2, $96
    db $74, $01 ; id 377 Darck
    db SKILL_FIREBOLT
    db SKILL_GIGASLASH
    db SKILL_DEMAGIC
    db SKILL_PANICALL_AD
    db $ee, $e8, $07, $2c, $a0, $0f, $eb, $00, $5e, $01, $dc, $00, $a0, $00, $d2, $00, $96, $64, $8c, $c8
    db $62, $00 ; id 378 MadCat
    db $ff
    db $ff
    db $ff
    db $ff
    db $00, $00, $00, $01, $19, $00, $0b, $00, $17, $00, $0e, $00, $17, $00, $0e, $00, $dc, $b4, $28, $fa
    db $c4, $00 ; id 379 HornBeet
    db $ff
    db $ff
    db $ff
    db $ff
    db $00, $00, $00, $01, $0f, $00, $1c, $00, $11, $00, $1e, $00, $0e, $00, $1d, $00, $96, $aa, $3c, $fa
    db $3e, $00 ; id 380 SkyDragon
    db $ff
    db $ff
    db $ff
    db $ff
    db $00, $00, $00, $01, $1b, $00, $18, $00, $1c, $00, $10, $00, $15, $00, $13, $00, $d2, $82, $8c, $fa
    db $52, $01 ; id 381 Octogon
    db $ff
    db $ff
    db $ff
    db $ff
    db $00, $00, $00, $01, $1e, $00, $18, $00, $1c, $00, $10, $00, $15, $00, $1a, $00, $c8, $c8, $c8, $fa
    db $0b, $01 ; id 382 Servant
    db $ff
    db $ff
    db $ff
    db $ff
    db $00, $00, $00, $01, $1e, $00, $15, $00, $1a, $00, $18, $00, $0b, $00, $1e, $00, $c8, $d2, $3c, $fa
    db $74, $01 ; id 383 Darck
    db $ff
    db $ff
    db $ff
    db $ff
    db $00, $00, $00, $01, $46, $00, $37, $00, $37, $00, $28, $00, $1e, $00, $78, $00, $64, $64, $64, $64
    db $b5, $00 ; id 384 GiantWorm
    db SKILL_BEASTCUT
    db $ff
    db $ff
    db $ff
    db $06, $00, $03, $06, $0f, $00, $0b, $00, $0f, $00, $04, $00, $0e, $00, $12, $00, $b4, $64, $64, $c8
    db $f6, $00 ; id 385 Spooky
    db $ff
    db $ff
    db $ff
    db $ff
    db $06, $00, $01, $03, $10, $00, $10, $00, $0b, $00, $05, $00, $15, $00, $0f, $00, $96, $96, $96, $c8
    db $4f, $00 ; id 386 Beavern
    db SKILL_CHARGEUP
    db $ff
    db $ff
    db $ff
    db $f0, $00, $07, $05, $62, $00, $10, $00, $14, $00, $08, $00, $24, $00, $78, $00, $c8, $32, $96, $c8
    db $4f, $00 ; id 387 Beavern
    db SKILL_CHARGEUP
    db $ff
    db $ff
    db $ff
    db $3c, $00, $00, $05, $3d, $00, $18, $00, $24, $00, $17, $00, $2a, $00, $1a, $00, $c8, $32, $96, $c8
    db $1b, $01 ; id 388 MadCandle
    db SKILL_BLAZE
    db SKILL_WHISTLE
    db $ff
    db $ff
    db $09, $00, $03, $04, $10, $00, $0b, $00, $0e, $00, $0b, $00, $06, $00, $0b, $00, $8c, $46, $5a, $96
    db $1e, $01 ; id 389 SpikyBoy
    db $ff
    db $ff
    db $ff
    db $ff
    db $08, $00, $03, $04, $13, $00, $0c, $00, $0a, $00, $06, $00, $16, $00, $45, $00, $c8, $46, $64, $96
    db $40, $01 ; id 390 Anemon
    db SKILL_FIREBAL
    db $ff
    db $ff
    db $ff
    db $12, $00, $03, $05, $21, $00, $23, $00, $17, $00, $10, $00, $1c, $00, $38, $00, $8c, $64, $32, $96
    db $57, $00 ; id 391 ArrowDog
    db SKILL_BLAZE
    db $ff
    db $ff
    db $ff
    db $78, $00, $03, $09, $23, $00, $13, $00, $26, $00, $21, $00, $36, $00, $77, $00, $64, $96, $0a, $96
    db $b8, $00 ; id 392 Pyuro
    db SKILL_SPEED
    db $ff
    db $ff
    db $ff
    db $68, $00, $03, $0b, $23, $00, $20, $00, $20, $00, $36, $00, $32, $00, $b7, $00, $b4, $96, $a0, $96
    db $98, $00 ; id 393 DanceVegi
    db SKILL_SIDESTEP
    db $ff
    db $ff
    db $ff
    db $c9, $00, $03, $0c, $2e, $00, $5b, $00, $24, $00, $3c, $00, $9e, $00, $d6, $00, $8c, $28, $96, $96
    db $28, $01 ; id 394 Brushead
    db SKILL_ODDDANCE
    db SKILL_SANDSTORM
    db $ff
    db $ff
    db $e3, $00, $03, $0d, $38, $00, $4c, $00, $42, $00, $24, $00, $33, $00, $d6, $00, $82, $78, $8c, $96
    db $2e, $00 ; id 395 MiniDrak
    db SKILL_CALLHELP
    db $ff
    db $ff
    db $ff
    db $63, $00, $03, $08, $29, $00, $20, $00, $2c, $00, $1a, $00, $3d, $00, $8c, $00, $8c, $50, $78, $96
    db $26, $00 ; id 396 Pteranod
    db SKILL_FIREBAL
    db SKILL_TAILWIND
    db $ff
    db $ff
    db $2d, $01, $03, $0d, $42, $00, $29, $00, $44, $00, $35, $00, $9e, $00, $77, $00, $c8, $32, $3c, $96
    db $24, $00 ; id 397 DragonKid
    db SKILL_FIREAIR
    db SKILL_SLEEPAIR
    db $ff
    db $ff
    db $6c, $00, $03, $0d, $34, $00, $47, $00, $37, $00, $34, $00, $46, $00, $df, $00, $d2, $50, $0a, $96
    db $49, $00 ; id 398 CatFly
    db SKILL_SLOW
    db SKILL_ODDDANCE
    db $ff
    db $ff
    db $20, $01, $03, $0f, $40, $00, $5f, $00, $42, $00, $3c, $00, $2a, $00, $c1, $00, $46, $78, $96, $96
    db $09, $01 ; id 399 BoneSlave
    db SKILL_BANG
    db SKILL_BOLTSLASH
    db $ff
    db $ff
    db $56, $01, $07, $0d, $48, $00, $3a, $00, $3a, $00, $2d, $00, $31, $00, $63, $00, $b4, $28, $64, $96
    db $53, $01 ; id 400 KingSquid
    db SKILL_TIDALWAVE
    db SKILL_RAINSLASH
    db SKILL_PANIDANCE
    db $ff
    db $a0, $0f, $00, $26, $c4, $09, $8c, $00, $e3, $00, $93, $00, $bd, $00, $49, $00, $d2, $8c, $14, $96
    db $59, $00 ; id 401 BeastNite
    db SKILL_SLEEP
    db SKILL_RAINSLASH
    db $ff
    db $ff
    db $79, $01, $04, $0f, $50, $00, $25, $00, $43, $00, $3d, $00, $34, $00, $7e, $01, $e6, $64, $50, $64
    db $2c, $00 ; id 402 Drygon
    db SKILL_RAMMING
    db SKILL_WARCRY
    db $ff
    db $ff
    db $65, $01, $03, $13, $5f, $00, $49, $00, $4f, $00, $37, $00, $44, $00, $03, $01, $8c, $1e, $b4, $64
    db $5a, $01 ; id 403 Pumpoise
    db SKILL_CALLHELP
    db SKILL_SUCKAIR
    db $ff
    db $ff
    db $b1, $01, $03, $0f, $56, $00, $71, $00, $47, $00, $58, $00, $43, $00, $a9, $00, $50, $64, $78, $64
    db $47, $01 ; id 404 FishRider
    db SKILL_BOLTSLASH
    db SKILL_RAINSLASH
    db $ff
    db $ff
    db $dc, $01, $04, $13, $6a, $00, $82, $00, $4a, $00, $43, $00, $6d, $00, $9c, $00, $5a, $64, $6e, $64
    db $3e, $01 ; id 405 WalrusMan
    db SKILL_ZOMBIECUT
    db $ff
    db $ff
    db $ff
    db $a9, $01, $03, $16, $80, $00, $57, $00, $5a, $00, $45, $00, $70, $00, $b4, $01, $96, $46, $5a, $64
    db $96, $00 ; id 406 Stubsuck
    db SKILL_SLEEP
    db SKILL_ZOMBIECUT
    db $ff
    db $ff
    db $4e, $01, $04, $12, $4c, $00, $4e, $00, $4b, $00, $4e, $00, $57, $00, $b3, $00, $e6, $64, $46, $64
    db $fd, $00 ; id 407 Shadow
    db SKILL_BEAT
    db SKILL_ICEAIR
    db $ff
    db $ff
    db $6c, $01, $04, $14, $52, $00, $89, $00, $57, $00, $44, $00, $4d, $00, $0d, $01, $fa, $d2, $28, $64
    db $90, $00 ; id 408 WingTree
    db SKILL_ZOMBIECUT
    db SKILL_STEPGUARD
    db $ff
    db $ff
    db $d4, $01, $04, $17, $5f, $00, $97, $00, $53, $00, $4e, $00, $59, $00, $a6, $00, $a0, $8c, $78, $64
    db $d5, $00 ; id 409 AgDevil
    db SKILL_FIREBANE
    db SKILL_SLEEPAIR
    db SKILL_WARCRY
    db $ff
    db $ce, $0b, $07, $12, $26, $02, $32, $00, $5a, $00, $3b, $00, $6d, $00, $d8, $00, $96, $96, $96, $96
    db $21, $01 ; id 410 Puppetor
    db SKILL_BIATTACK
    db SKILL_ODDDANCE
    db SKILL_PANIDANCE
    db SKILL_LUREDANCE
    db $ec, $09, $07, $16, $90, $01, $52, $00, $55, $00, $3c, $00, $30, $00, $78, $00, $b4, $96, $96, $96
    db $de, $00 ; id 411 ArcDemon
    db SKILL_BOOM
    db SKILL_VACUSLASH
    db SKILL_BOLTSLASH
    db $ff
    db $f6, $04, $07, $1b, $d2, $00, $59, $00, $69, $00, $47, $00, $54, $00, $d3, $00, $b4, $2d, $96, $96
    db $e0, $00 ; id 412 GoatHorn
    db SKILL_BOOM
    db SKILL_INFERMORE
    db SKILL_SNOWSTORM
    db SKILL_BIATTACK
    db $14, $1e, $07, $1b, $4a, $01, $59, $00, $5f, $00, $41, $00, $5c, $00, $e9, $00, $b4, $32, $96, $96
    db $24, $01 ; id 413 MetalDrak
    db SKILL_BLAZEAIR
    db SKILL_MASSACRE
    db $ff
    db $ff
    db $95, $05, $05, $1e, $5a, $00, $67, $00, $82, $00, $5c, $00, $60, $00, $f8, $00, $8c, $64, $6e, $64
    db $d5, $00 ; id 414 AgDevil
    db SKILL_FIREBANE
    db SKILL_SACRIFICE
    db $ff
    db $ff
    db $ea, $03, $05, $19, $66, $00, $66, $00, $a5, $00, $68, $00, $91, $00, $2e, $01, $96, $0a, $46, $64
    db $21, $01 ; id 415 Puppetor
    db SKILL_ODDDANCE
    db SKILL_LUREDANCE
    db SKILL_PHEROMONE
    db $ff
    db $98, $03, $05, $1b, $65, $00, $96, $00, $86, $00, $61, $00, $61, $00, $ef, $00, $78, $46, $64, $64
    db $32, $01 ; id 416 Golem
    db SKILL_CHARGEUP
    db SKILL_PSYCHEUP
    db $ff
    db $ff
    db $62, $05, $05, $1b, $91, $00, $66, $00, $84, $00, $80, $00, $91, $00, $7f, $00, $c8, $00, $c8, $64
    db $9e, $00 ; id 417 EvilSeed
    db SKILL_CLEANCUT
    db SKILL_PARALYZE
    db $ff
    db $ff
    db $57, $0a, $04, $18, $78, $00, $6c, $00, $70, $00, $75, $00, $83, $00, $d9, $00, $5a, $50, $78, $64
    db $d8, $00 ; id 418 EyeBall
    db SKILL_MAGICBACK
    db SKILL_WARCRY
    db $ff
    db $ff
    db $1d, $09, $04, $1d, $8d, $00, $8a, $00, $83, $00, $83, $00, $87, $00, $56, $01, $96, $50, $8c, $64
    db $31, $00 ; id 419 Chamelgon
    db SKILL_PANICALL
    db SKILL_PARALYZE
    db $ff
    db $ff
    db $96, $08, $04, $1a, $bd, $00, $48, $00, $70, $00, $7e, $00, $7a, $00, $4d, $01, $50, $50, $82, $64
    db $a7, $00 ; id 420 FooHero
    db SKILL_BOLT
    db SKILL_IRONIZE
    db $ff
    db $ff
    db $78, $05, $04, $14, $95, $00, $76, $00, $6b, $00, $65, $00, $a9, $00, $9e, $00, $e6, $c8, $50, $64
    db $08, $00 ; id 421 BoxSlime
    db SKILL_BLAZEMORE
    db SKILL_INCREASE
    db SKILL_RAMMING
    db $ff
    db $f8, $07, $04, $1e, $9c, $00, $4d, $00, $76, $00, $c3, $00, $76, $00, $11, $01, $c8, $0a, $0a, $64
    db $12, $00 ; id 422 Metabble
    db SKILL_FIREBAL
    db SKILL_BANG
    db $ff
    db $ff
    db $6b, $a2, $07, $25, $14, $00, $70, $01, $5f, $00, $e7, $03, $9e, $02, $0a, $02, $aa, $8c, $00, $64
    db $5b, $00 ; id 423 FairyRat
    db SKILL_SLOWALL
    db SKILL_SURROUND
    db SKILL_SLIMEBLOW
    db $ff
    db $15, $04, $04, $1b, $94, $00, $5f, $00, $73, $00, $7f, $00, $b5, $00, $d8, $00, $3c, $78, $8c, $64
    db $2b, $00 ; id 424 Swordgon
    db SKILL_CLEANCUT
    db SKILL_BLADED
    db $ff
    db $ff
    db $92, $05, $05, $1f, $9c, $00, $7b, $00, $80, $00, $7a, $00, $96, $00, $e6, $00, $fa, $28, $82, $64
    db $53, $00 ; id 425 Mommonja
    db SKILL_LUREDANCE
    db SKILL_MOUTHSHUT
    db SKILL_SIDESTEP
    db $ff
    db $92, $07, $04, $19, $8a, $00, $7a, $00, $74, $00, $63, $00, $aa, $00, $f7, $00, $64, $8c, $78, $64
    db $74, $00 ; id 426 KiteHawk
    db SKILL_MAGICWALL
    db SKILL_CURSE
    db $ff
    db $ff
    db $95, $07, $04, $23, $97, $00, $72, $00, $88, $00, $70, $00, $0d, $01, $ec, $00, $b4, $3c, $82, $64
    db $79, $00 ; id 427 MadCondor
    db SKILL_HEALUS
    db $ff
    db $ff
    db $ff
    db $98, $3a, $00, $1e, $58, $02, $77, $00, $83, $00, $5a, $00, $6e, $00, $9f, $00, $8c, $82, $96, $64
    db $79, $00 ; id 428 MadCondor
    db SKILL_HEALUS
    db $ff
    db $ff
    db $ff
    db $00, $00, $00, $1e, $95, $00, $77, $00, $b5, $00, $a0, $00, $c0, $00, $03, $01, $8c, $82, $96, $64
    db $3a, $00 ; id 429 WingSnake
    db SKILL_SQUALLHIT
    db SKILL_HIGHJUMP
    db SKILL_POISONAIR
    db $ff
    db $7f, $0b, $04, $20, $bd, $00, $c9, $00, $88, $00, $63, $00, $c4, $00, $dc, $00, $96, $8c, $a0, $64
    db $38, $00 ; id 430 GreatDrak
    db SKILL_ICESTORM
    db $ff
    db $ff
    db $ff
    db $5a, $1a, $05, $28, $2a, $01, $78, $00, $e6, $00, $ae, $00, $69, $00, $1c, $01, $96, $2d, $64, $64
    db $53, $01 ; id 431 KingSquid
    db SKILL_TIDALWAVE
    db SKILL_RAINSLASH
    db SKILL_PANIDANCE
    db $ff
    db $00, $00, $00, $26, $d2, $00, $8c, $00, $e3, $00, $93, $00, $bd, $00, $ad, $00, $b4, $8c, $5a, $96
    db $4e, $00 ; id 432 WindBeast
    db SKILL_INFERMOST
    db $ff
    db $ff
    db $ff
    db $08, $20, $07, $28, $84, $03, $7f, $00, $ec, $00, $a8, $00, $e9, $01, $00, $00, $8c, $50, $b4, $64
    db $78, $00 ; id 433 MadGoose
    db SKILL_VACUUM
    db $ff
    db $ff
    db $ff
    db $64, $1e, $07, $28, $44, $02, $83, $01, $c9, $00, $cb, $00, $5c, $01, $00, $00, $50, $64, $c8, $64
    db $55, $01 ; id 434 WhaleMage
    db SKILL_TIDALWAVE
    db $ff
    db $ff
    db $ff
    db $c4, $22, $07, $2a, $ee, $02, $4e, $02, $c7, $00, $e4, $00, $f7, $00, $00, $00, $be, $78, $c8, $64
    db $4e, $01 ; id 435 SeaHorse
    db SKILL_GEYSER
    db $ff
    db $ff
    db $ff
    db $e0, $15, $07, $25, $e0, $01, $b4, $00, $bf, $00, $fd, $00, $de, $00, $00, $00, $96, $32, $96, $64
    db $45, $01 ; id 436 Octoreach
    db SKILL_GEYSER
    db $ff
    db $ff
    db $ff
    db $44, $16, $07, $27, $bc, $02, $8c, $00, $ee, $00, $ae, $00, $f7, $00, $00, $00, $78, $46, $b4, $64
    db $2e, $01 ; id 437 IceMan
    db SKILL_BLIZZARD
    db SKILL_ICESTORM
    db $ff
    db $ff
    db $04, $29, $07, $2d, $b0, $04, $f4, $01, $59, $01, $17, $01, $d2, $00, $00, $00, $64, $1e, $64, $64
    db $fd, $00 ; id 438 Shadow
    db SKILL_ICEAIR
    db $ff
    db $ff
    db $ff
    db $a8, $16, $07, $28, $58, $02, $2c, $01, $eb, $00, $f0, $00, $aa, $00, $00, $00, $46, $32, $64, $64
    db $63, $00 ; id 439 BigEye
    db SKILL_ICEAIR
    db $ff
    db $ff
    db $ff
    db $70, $17, $07, $25, $ee, $02, $18, $01, $66, $01, $f2, $00, $c6, $00, $00, $00, $64, $64, $64, $64
    db $25, $01 ; id 440 Balzak
    db SKILL_THORDAIN
    db $ff
    db $ff
    db $ff
    db $44, $61, $07, $2d, $d0, $07, $8e, $01, $77, $01, $01, $01, $dc, $00, $00, $00, $c8, $00, $8c, $64
    db $f9, $00 ; id 441 RotRaven
    db SKILL_LIGHTNING
    db SKILL_BOLTSLASH
    db $ff
    db $ff
    db $a0, $0f, $07, $23, $a8, $02, $54, $01, $a0, $00, $f9, $00, $54, $01, $00, $00, $28, $50, $64, $64
    db $ed, $00 ; id 442 Jamirus
    db SKILL_BLAZEMOST
    db $ff
    db $ff
    db $ff
    db $10, $27, $07, $30, $78, $05, $ee, $02, $f7, $00, $5d, $01, $9a, $01, $00, $00, $64, $64, $8c, $64
    db $3e, $00 ; id 443 SkyDragon
    db SKILL_WHITEFIRE
    db $ff
    db $ff
    db $ff
    db $a8, $16, $07, $2e, $de, $03, $bc, $02, $5d, $01, $17, $01, $f3, $00, $00, $00, $96, $64, $82, $64
    db $dd, $00 ; id 444 Gremlin
    db SKILL_FIREBOLT
    db $ff
    db $ff
    db $ff
    db $c0, $12, $07, $28, $58, $02, $c2, $01, $c9, $00, $e8, $00, $da, $00, $00, $00, $28, $5a, $50, $64
    db $39, $00 ; id 445 Crestpent
    db SKILL_STOPSPELL
    db SKILL_POISONHIT
    db $ff
    db $ff
    db $e8, $1c, $07, $2a, $0c, $03, $bc, $02, $17, $01, $2c, $01, $2b, $01, $e0, $01, $64, $50, $64, $64
    db $13, $00 ; id 446 SpotKing
    db SKILL_NAPATTACK
    db SKILL_MOUTHSHUT
    db $ff
    db $ff
    db $10, $27, $07, $2d, $14, $05, $26, $02, $7a, $01, $d6, $00, $34, $01, $20, $03, $46, $50, $78, $64
    db $92, $00 ; id 447 Gulpple
    db SKILL_SLEEPAIR
    db $ff
    db $ff
    db $ff
    db $e0, $15, $07, $2d, $48, $03, $4e, $02, $21, $01, $2b, $01, $83, $01, $00, $00, $3c, $96, $78, $64
    db $28, $00 ; id 448 FairyDrak
    db SKILL_SURROUND
    db SKILL_SLEEPAIR
    db $ff
    db $ff
    db $44, $16, $07, $28, $bc, $02, $54, $01, $38, $01, $2a, $01, $11, $01, $00, $00, $50, $50, $50, $64
    db $6e, $00 ; id 449 DuckKite
    db SKILL_SLEEPALL
    db SKILL_PANICALL
    db $ff
    db $ff
    db $0c, $17, $07, $2a, $84, $03, $d6, $01, $28, $01, $4a, $01, $90, $01, $00, $00, $5a, $5a, $5a, $64
    db $80, $00 ; id 450 FunkyBird
    db SKILL_PANIDANCE
    db SKILL_HUSTLE
    db $ff
    db $ff
    db $38, $18, $07, $2a, $7a, $03, $f4, $01, $2d, $01, $0b, $01, $ae, $01, $00, $00, $50, $64, $82, $64
    db $98, $00 ; id 451 DanceVegi
    db SKILL_KODANCE
    db SKILL_LUREDANCE
    db SKILL_SIDESTEP
    db $ff
    db $d4, $17, $07, $25, $a8, $02, $ae, $01, $03, $01, $f9, $00, $f0, $00, $00, $00, $32, $5a, $50, $64
    db $95, $00 ; id 452 Slurperon
    db SKILL_ODDDANCE
    db $ff
    db $ff
    db $ff
    db $e0, $15, $07, $27, $16, $03, $90, $01, $15, $01, $03, $01, $2e, $01, $00, $00, $5a, $5a, $8c, $64
    db $8d, $00 ; id 453 MadPlant
    db SKILL_DEFENSE
    db SKILL_SLOWALL
    db $ff
    db $ff
    db $50, $14, $07, $27, $70, $03, $7c, $01, $f3, $00, $5e, $01, $21, $01, $fe, $01, $50, $50, $50, $64
    db $e1, $00 ; id 454 Orc
    db SKILL_VIVIFY
    db SKILL_DEFENSE
    db SKILL_SAMSICALL
    db $ff
    db $70, $17, $07, $2b, $84, $03, $5e, $01, $5a, $01, $21, $01, $be, $00, $02, $03, $8c, $64, $8c, $64
    db $f8, $00 ; id 455 PutrePup
    db SKILL_DEFENSE
    db SKILL_SLOWALL
    db SKILL_MAGICBACK
    db $ff
    db $0c, $17, $07, $29, $bc, $02, $18, $01, $4a, $01, $48, $01, $e8, $00, $c2, $01, $64, $64, $82, $64
    db $9a, $00 ; id 456 Devipine
    db SKILL_BEAT
    db SKILL_ODDDANCE
    db $ff
    db $ff
    db $00, $19, $07, $2b, $48, $03, $90, $01, $2c, $01, $66, $01, $de, $00, $94, $02, $46, $3c, $c8, $64
    db $40, $01 ; id 457 Anemon
    db SKILL_PARALYZE
    db SKILL_POISONAIR
    db $ff
    db $ff
    db $a8, $16, $07, $2c, $84, $03, $72, $01, $f8, $00, $84, $01, $21, $01, $44, $02, $64, $78, $64, $64
    db $9c, $00 ; id 458 HerbMan
    db SKILL_CURSE
    db SKILL_DANCESHUT
    db $ff
    db $ff
    db $9c, $18, $07, $2e, $14, $05, $bc, $02, $55, $01, $11, $01, $72, $01, $84, $03, $5a, $82, $c8, $64
    db $10, $00 ; id 459 KingSlime
    db SKILL_VIVIFY
    db SKILL_BARRIER
    db $ff
    db $ff
    db $50, $46, $07, $32, $a0, $0f, $18, $01, $49, $01, $21, $01, $4e, $01, $20, $03, $0a, $96, $96, $64
    db $3b, $00 ; id 460 Coatol
    db SKILL_EXPLODET
    db SKILL_BOLTSLASH
    db SKILL_EVILSLASH
    db $ff
    db $10, $27, $07, $30, $80, $02, $08, $07, $21, $01, $9a, $01, $49, $01, $20, $03, $5a, $64, $78, $64
    db $0c, $00 ; id 461 FangSlime
    db SKILL_YELLHELP
    db SKILL_CHARGEUP
    db SKILL_WARCRY
    db $ff
    db $b8, $24, $07, $2c, $bc, $02, $7a, $01, $4d, $01, $16, $01, $8d, $01, $4e, $02, $c8, $28, $96, $64
    db $55, $00 ; id 462 Grizzly
    db SKILL_SQUALLHIT
    db SKILL_QUADHITS
    db SKILL_BIGTRIP
    db $ff
    db $d8, $27, $07, $2d, $66, $03, $68, $01, $74, $01, $f5, $00, $7b, $01, $20, $01, $b4, $46, $64, $64
    db $59, $00 ; id 463 BeastNite
    db SKILL_SLEEP
    db SKILL_RAINSLASH
    db SKILL_GIGASLASH
    db $ff
    db $54, $24, $07, $2d, $b0, $04, $a4, $01, $66, $01, $57, $01, $c9, $00, $58, $02, $8c, $64, $78, $64
    db $0e, $00 ; id 464 SlimeBorg
    db SKILL_HEALMORE
    db SKILL_HEALUSALL
    db SKILL_INCREASE
    db $ff
    db $fc, $21, $07, $2c, $8a, $02, $16, $03, $d9, $00, $47, $01, $a2, $01, $e4, $02, $50, $c8, $aa, $64
    db $5c, $00 ; id 465 Unicorn
    db SKILL_HEALALL
    db SKILL_REVIVE
    db SKILL_SURGE
    db $ff
    db $f8, $2a, $07, $2d, $d0, $02, $a8, $02, $3c, $01, $42, $01, $3f, $01, $20, $03, $46, $c8, $46, $64
    db $51, $00 ; id 466 SuperTen
    db SKILL_HUSTLE
    db SKILL_IMITATE
    db $ff
    db $ff
    db $60, $22, $07, $2c, $58, $02, $7c, $01, $38, $01, $2a, $01, $a1, $01, $58, $02, $32, $aa, $64, $64
    db $0a, $00 ; id 467 Slime
    db SKILL_MEGAMAGIC
    db $ff
    db $ff
    db $ff
    db $c0, $2b, $07, $2f, $58, $02, $f4, $01, $83, $01, $2b, $01, $83, $01, $bc, $02, $78, $46, $64, $64
    db $0d, $00 ; id 468 RockSlime
    db SKILL_HIGHJUMP
    db SKILL_RAMMING
    db SKILL_STRONGD
    db $ff
    db $e0, $2e, $07, $28, $a8, $02, $e6, $00, $09, $01, $6a, $01, $09, $01, $c2, $01, $5a, $aa, $3c, $64
    db $12, $00 ; id 469 Metabble
    db SKILL_EXPLODET
    db SKILL_SACRIFICE
    db $ff
    db $ff
    db $f4, $97, $07, $28, $21, $01, $bc, $02, $92, $00, $1e, $03, $b0, $02, $02, $03, $0a, $64, $5a, $64
    db $64, $00 ; id 470 Gorago
    db SKILL_WHITEFIRE
    db SKILL_DEMAGIC
    db SKILL_WARCRY
    db SKILL_MEDITATE
    db $82, $d2, $07, $37, $de, $03, $0c, $03, $b0, $01, $7a, $01, $b0, $02, $20, $03, $c8, $82, $78, $96
    db $0f, $00 ; id 471 Slabbit
    db SKILL_SIDESTEP
    db SKILL_BIGTRIP
    db $ff
    db $ff
    db $ee, $16, $04, $25, $dc, $00, $76, $01, $bb, $00, $c6, $00, $36, $01, $59, $01, $3c, $50, $5a, $64
    db $c9, $00 ; id 472 MultiEyes
    db SKILL_SLOWALL
    db SKILL_PALSYAIR
    db $ff
    db $ff
    db $54, $17, $05, $25, $18, $01, $f8, $00, $dc, $00, $b2, $00, $03, $01, $4d, $01, $50, $46, $64, $64
    db $5b, $00 ; id 473 FairyRat
    db SKILL_SLOWALL
    db SKILL_SURROUND
    db SKILL_SLIMEBLOW
    db $ff
    db $2a, $16, $04, $23, $8c, $00, $bc, $00, $a8, $00, $54, $01, $20, $01, $5c, $01, $3c, $50, $64, $64
    db $96, $00 ; id 474 Stubsuck
    db SKILL_SLEEPALL
    db SKILL_ZOMBIECUT
    db $ff
    db $ff
    db $6a, $16, $04, $25, $2c, $01, $59, $01, $af, $00, $dc, $00, $c9, $00, $52, $01, $28, $28, $32, $64
    db $8d, $00 ; id 475 MadPlant
    db SKILL_DEFENSE
    db SKILL_SLOWALL
    db $ff
    db $ff
    db $7b, $15, $04, $22, $b4, $00, $a4, $01, $cf, $00, $2b, $01, $e6, $00, $7a, $01, $50, $1e, $64, $64
    db $a0, $00 ; id 476 Snapper
    db SKILL_STOPSPELL
    db SKILL_YELLHELP
    db $ff
    db $ff
    db $f0, $17, $05, $24, $36, $01, $68, $01, $01, $01, $ec, $00, $1f, $01, $c2, $01, $5a, $64, $64, $64
    db $e6, $00 ; id 477 Grendal
    db SKILL_FIRESLASH
    db SKILL_DRAKSLASH
    db SKILL_WARCRY
    db $ff
    db $5c, $1a, $05, $26, $7c, $01, $c5, $00, $2d, $01, $0c, $01, $bd, $00, $47, $01, $96, $64, $64, $64
    db $ba, $00 ; id 478 GoHopper
    db SKILL_ROBMAGIC
    db SKILL_YELLHELP
    db SKILL_CHARGEUP
    db $ff
    db $00, $17, $04, $23, $e6, $00, $04, $01, $ad, $00, $0e, $01, $2b, $01, $40, $01, $50, $28, $3c, $64
    db $57, $00 ; id 479 ArrowDog
    db SKILL_INCREASE
    db SKILL_CHARGEUP
    db SKILL_SICKLICK
    db $ff
    db $48, $26, $07, $28, $f4, $01, $d2, $00, $ed, $00, $20, $01, $f9, $00, $f5, $01, $50, $28, $46, $64
    db $b7, $00 ; id 480 StagBug
    db SKILL_SLEEPALL
    db SKILL_SCORCHING
    db SKILL_AHHH
    db $ff
    db $fa, $17, $05, $26, $45, $01, $c8, $00, $f8, $00, $5c, $01, $f8, $00, $68, $01, $50, $1e, $64, $64
    db $8e, $00 ; id 481 FireWeed
    db SKILL_BLAZEMORE
    db SKILL_PALSYAIR
    db $ff
    db $ff
    db $cc, $18, $05, $25, $22, $01, $d6, $01, $2d, $01, $f0, $00, $40, $01, $9a, $01, $5a, $46, $5a, $64
    db $d5, $00 ; id 482 AgDevil
    db SKILL_FIREBOLT
    db SKILL_ROBDANCE
    db SKILL_IMITATE
    db $ff
    db $0a, $69, $07, $2f, $dc, $05, $44, $02, $5a, $01, $36, $01, $0b, $01, $bc, $02, $5a, $78, $82, $64
    db $55, $00 ; id 483 Grizzly
    db SKILL_SQUALLHIT
    db SKILL_QUADHITS
    db SKILL_BIGTRIP
    db $ff
    db $1c, $18, $04, $29, $a9, $01, $9d, $00, $40, $01, $dc, $00, $c9, $00, $43, $01, $96, $46, $46, $64
    db $d9, $00 ; id 484 SkulRider
    db SKILL_FIRESLASH
    db SKILL_RAINSLASH
    db SKILL_BIGTRIP
    db $ff
    db $70, $15, $04, $2a, $37, $01, $f5, $00, $1f, $01, $0d, $01, $44, $01, $84, $01, $64, $64, $64, $64
    db $3e, $01 ; id 485 WalrusMan
    db SKILL_BUGBLOW
    db SKILL_EVILSLASH
    db SKILL_MASSACRE
    db $ff
    db $54, $17, $04, $28, $5b, $01, $e1, $00, $41, $01, $db, $00, $54, $01, $3d, $01, $82, $3c, $50, $64
    db $1b, $01 ; id 486 MadCandle
    db SKILL_BLAZEMORE
    db SKILL_PSYCHEUP
    db $ff
    db $ff
    db $7a, $17, $03, $2b, $41, $01, $f9, $00, $2b, $01, $3f, $01, $74, $01, $de, $01, $64, $46, $50, $64
    db $03, $01 ; id 487 Reaper
    db SKILL_DEVILCUT
    db SKILL_CURSE
    db SKILL_EERIELITE
    db $ff
    db $58, $19, $04, $2a, $17, $01, $e9, $01, $1f, $01, $6f, $01, $47, $01, $4d, $02, $64, $64, $64, $64
    db $37, $01 ; id 488 ProtoMech
    db SKILL_CHARGEUP
    db SKILL_RAMMING
    db $ff
    db $ff
    db $84, $1a, $05, $2b, $7a, $01, $21, $01, $7c, $01, $e8, $00, $3e, $01, $7b, $01, $6e, $28, $6e, $64
    db $29, $01 ; id 489 Roboster
    db SKILL_DEFENSE
    db SKILL_QUADHITS
    db SKILL_RAINSLASH
    db SKILL_BLADED
    db $70, $17, $07, $32, $84, $03, $3a, $02, $91, $01, $c0, $01, $ab, $01, $9e, $02, $8c, $5a, $64, $64
    db $29, $01 ; id 490 Roboster
    db SKILL_DEFENSE
    db SKILL_QUADHITS
    db $ff
    db $ff
    db $e8, $03, $07, $32, $17, $02, $cd, $00, $36, $01, $2c, $01, $40, $01, $a4, $01, $8c, $32, $3c, $64
    db $29, $01 ; id 491 Roboster
    db SKILL_DEFENSE
    db SKILL_QUADHITS
    db $ff
    db $ff
    db $2c, $01, $07, $32, $d2, $00, $46, $00, $a0, $00, $c8, $00, $d2, $00, $e6, $00, $8c, $28, $28, $64
    db $29, $01 ; id 492 Roboster
    db SKILL_DEFENSE
    db $ff
    db $ff
    db $ff
    db $64, $00, $07, $32, $4f, $00, $02, $00, $52, $00, $59, $00, $65, $00, $26, $00, $8c, $00, $00, $64
    db $65, $00 ; id 493 CatMage
    db SKILL_TRANSFORM
    db SKILL_DIAGOCALL
    db $ff
    db $ff
    db $1f, $3a, $04, $2c, $30, $01, $dd, $01, $e1, $00, $0b, $01, $16, $01, $6c, $02, $46, $5a, $6e, $64
    db $9b, $00 ; id 494 FaceTree
    db SKILL_STOPSPELL
    db SKILL_CURSE
    db SKILL_ODDDANCE
    db $ff
    db $d3, $35, $05, $2f, $71, $01, $ab, $01, $ed, $00, $44, $01, $c8, $00, $58, $02, $50, $78, $78, $64
    db $e2, $00 ; id 495 Ogre
    db SKILL_METALCUT
    db SKILL_PSYCHEUP
    db SKILL_MASSACRE
    db $ff
    db $4e, $39, $05, $2f, $9a, $01, $f6, $00, $67, $01, $38, $01, $11, $01, $26, $02, $c8, $1e, $64, $64
    db $27, $01 ; id 496 CurseLamp
    db SKILL_INCREASE
    db SKILL_SPEEDUP
    db SKILL_TWINHITS
    db $ff
    db $12, $35, $04, $2c, $4d, $01, $86, $01, $cd, $00, $18, $01, $5c, $01, $58, $02, $5a, $8c, $82, $64
    db $40, $01 ; id 497 Anemon
    db SKILL_FIREBOLT
    db SKILL_PARALYZE
    db SKILL_POISONGAS
    db $ff
    db $23, $34, $04, $2d, $36, $01, $72, $01, $17, $01, $f3, $00, $3e, $01, $08, $02, $64, $64, $64, $64
    db $b6, $00 ; id 498 Lipsy
    db SKILL_SICKLICK
    db SKILL_AHHH
    db SKILL_PHEROMONE
    db $ff
    db $38, $39, $04, $2c, $5c, $01, $68, $01, $0b, $01, $1f, $01, $1f, $01, $12, $02, $5a, $8c, $78, $64
    db $b4, $00 ; id 499 WeedBug
    db SKILL_ROBMAGIC
    db SKILL_BARRIER
    db SKILL_MAGICWALL
    db $ff
    db $a6, $33, $04, $2e, $43, $01, $df, $01, $f9, $00, $46, $01, $38, $01, $e0, $01, $50, $82, $96, $64
    db $37, $00 ; id 500 Spikerous
    db SKILL_ROCKTHROW
    db SKILL_BERSERKER
    db SKILL_KAMIKAZE
    db $ff
    db $1c, $3e, $05, $2d, $b6, $01, $40, $01, $29, $01, $7a, $01, $cf, $00, $9a, $01, $64, $50, $6e, $64
    db $f7, $00 ; id 501 Skullgon
    db SKILL_ICESTORM
    db SKILL_ICESLASH
    db SKILL_TWINSLASH
    db $ff
    db $76, $3c, $05, $2f, $aa, $01, $40, $01, $29, $01, $7a, $01, $cf, $00, $c2, $01, $82, $64, $6e, $64
    db $fe, $00 ; id 502 Skulpent
    db SKILL_DEFEAT
    db SKILL_POISONHIT
    db SKILL_DODGE
    db $ff
    db $d3, $33, $04, $2c, $70, $01, $12, $01, $15, $01, $f3, $00, $7a, $01, $90, $01, $5a, $8c, $78, $64
    db $b3, $00 ; id 503 Butterfly
    db SKILL_SURROUND
    db SKILL_YELLHELP
    db SKILL_CURSE
    db $ff
    db $75, $35, $04, $2e, $29, $01, $85, $01, $0a, $01, $44, $01, $ca, $01, $6c, $02, $50, $64, $82, $64
    db $d3, $00 ; id 504 Pixy
    db SKILL_BOOM
    db SKILL_BARRIER
    db SKILL_PANIDANCE
    db $ff
    db $d0, $25, $07, $34, $a8, $02, $90, $01, $65, $01, $76, $01, $bb, $01, $bc, $02, $64, $82, $6e, $64
    db $0d, $01 ; id 505 Copycat
    db SKILL_TRANSFORM
    db $ff
    db $ff
    db $ff
    db $98, $3a, $07, $37, $ee, $02, $2c, $01, $36, $01, $08, $02, $7c, $01, $e7, $03, $96, $96, $96, $64
    db $33, $01 ; id 506 StoneMan
    db SKILL_ROCKTHROW
    db SKILL_GUARDIAN
    db SKILL_MEDITATE
    db $ff
    db $28, $23, $07, $34, $14, $05, $68, $01, $ca, $01, $0c, $01, $f7, $00, $bc, $02, $78, $96, $78, $64
    db $7f, $00 ; id 507 WhipBird
    db SKILL_DEMAGIC
    db SKILL_IMITATE
    db SKILL_LOVERAIN
    db $ff
    db $e0, $2e, $07, $35, $b6, $03, $3e, $03, $4e, $01, $76, $01, $b6, $01, $bc, $02, $82, $96, $64, $64
    db $15, $00 ; id 508 MimeSlime
    db SKILL_BLAZEMOST
    db SKILL_BARRIER
    db SKILL_ODDDANCE
    db $ff
    db $00, $00, $07, $2b, $72, $01, $b2, $02, $02, $01, $40, $01, $5e, $01, $08, $02, $28, $78, $d2, $8c
    db $47, $00 ; id 509 Tonguella
    db SKILL_INCREASE
    db SKILL_MAGICWALL
    db SKILL_SLIMEBLOW
    db $ff
    db $00, $00, $07, $2d, $90, $01, $40, $01, $52, $01, $36, $01, $1c, $01, $ae, $01, $82, $14, $96, $8c
    db $32, $01 ; id 510 Golem
    db SKILL_PSYCHEUP
    db SKILL_HIGHJUMP
    db SKILL_MASSACRE
    db $ff
    db $00, $00, $07, $30, $08, $02, $3b, $01, $9a, $01, $2d, $01, $bd, $00, $1c, $02, $c8, $78, $46, $8c
    db $db, $00 ; id 511 Bubblemon
    db SKILL_BLIZZARD
    db SKILL_BOUNCE
    db SKILL_BOLTSLASH
    db SKILL_BERSERKER
    db $c2, $9c, $06, $5d, $97, $02, $79, $00, $6a, $02, $07, $02, $e7, $01, $75, $02, $32, $78, $78, $96
    db $20, $01 ; id 512 RogueNite
    db SKILL_DEFENSE
    db SKILL_IRONIZE
    db SKILL_POISONHIT
    db SKILL_KAMIKAZE
    db $a4, $9c, $06, $5c, $22, $03, $e4, $00, $bf, $02, $91, $01, $b2, $01, $73, $02, $5a, $28, $28, $96
    db $21, $01 ; id 513 Puppetor
    db SKILL_BLAZEMOST
    db SKILL_MEGAMAGIC
    db SKILL_EERIELITE
    db SKILL_AHHH
    db $aa, $a0, $06, $51, $37, $03, $2b, $00, $58, $02, $91, $01, $50, $01, $fd, $01, $0a, $c8, $0a, $96
    db $30, $01 ; id 514 Exaucers
    db SKILL_SACRIFICE
    db SKILL_WHITEFIRE
    db SKILL_LIFESONG
    db SKILL_OUTSIDE
    db $d5, $ab, $06, $5d, $be, $02, $7e, $00, $ff, $01, $4f, $01, $37, $02, $20, $02, $78, $1e, $c8, $96
    db $55, $01 ; id 515 WhaleMage
    db SKILL_HEALALL
    db SKILL_BOUNCE
    db SKILL_BAZOOCALL
    db SKILL_IMITATE
    db $8b, $a7, $06, $5c, $6e, $02, $54, $00, $aa, $01, $92, $01, $fa, $01, $a3, $03, $46, $82, $28, $96
    db $d4, $00 ; id 516 MedusaEye
    db SKILL_FAREWELL
    db SKILL_ULTRADOWN
    db SKILL_STORMWIND
    db SKILL_PHEROMONE
    db $58, $ac, $06, $5d, $bd, $02, $84, $00, $25, $02, $df, $01, $e1, $01, $e4, $02, $46, $82, $28, $96
    db $17, $00 ; id 517 MetalKing
    db SKILL_SAP
    db SKILL_HUSTLE
    db SKILL_HIGHJUMP
    db SKILL_DEMAGIC
    db $00, $00, $07, $32, $c8, $00, $b6, $03, $36, $01, $0c, $03, $48, $03, $bc, $02, $d2, $be, $dc, $c8
    db $60, $00 ; id 518 KingLeo
    db SKILL_POISONHIT
    db SKILL_WARCRY
    db SKILL_BLIZZARD
    db SKILL_QUADHITS
    db $00, $00, $07, $37, $b0, $04, $ea, $01, $72, $01, $e0, $01, $cc, $01, $a8, $02, $dc, $dc, $a0, $c8
    db $35, $01 ; id 519 GoldGolem
    db SKILL_LIGHTNING
    db SKILL_CHARGEUP
    db SKILL_GUARDIAN
    db $ff
    db $00, $00, $07, $32, $84, $03, $4e, $02, $ae, $01, $58, $02, $72, $01, $bc, $02, $dc, $dc, $dc, $c8
    db $38, $00 ; id 520 GreatDrak
    db SKILL_LIGHTNING
    db SKILL_ICESTORM
    db SKILL_WARCRY
    db $ff
    db $00, $00, $07, $34, $48, $03, $4a, $01, $77, $01, $90, $01, $2b, $01, $2c, $01, $dc, $be, $c8, $c8
    db $a5, $00 ; id 521 Watabou
    db SKILL_BIGBANG
    db SKILL_CALLHELP
    db SKILL_LOVERAIN
    db $ff
    db $00, $00, $07, $28, $62, $02, $d3, $01, $40, $01, $7c, $01, $b2, $00, $96, $00, $c8, $c8, $c8, $c8
    db $ee, $00 ; id 522 Durran
    db SKILL_SQUALLHIT
    db SKILL_GIGASLASH
    db SKILL_ULTRADOWN
    db SKILL_MEDITATE
    db $00, $00, $07, $35, $e8, $03, $d6, $01, $a4, $01, $ae, $01, $46, $01, $c2, $01, $c8, $8c, $be, $c8
    db $d6, $00 ; id 523 Demonite
    db SKILL_CURSE
    db SKILL_ODDDANCE
    db SKILL_EERIELITE
    db $ff
    db $5c, $12, $07, $2f, $d6, $01, $66, $01, $51, $01, $0b, $01, $66, $01, $df, $01, $8c, $32, $aa, $96
    db $e5, $00 ; id 524 BossTroll
    db SKILL_ROCKTHROW
    db SKILL_PSYCHEUP
    db SKILL_BLADED
    db $ff
    db $c4, $22, $07, $2e, $44, $02, $d2, $00, $c1, $01, $ed, $00, $81, $00, $20, $01, $c8, $0a, $1e, $96
    db $19, $01 ; id 525 JewelBag
    db SKILL_CURSE
    db SKILL_ODDDANCE
    db SKILL_EERIELITE
    db $ff
    db $f4, $1a, $07, $30, $12, $02, $1f, $03, $92, $01, $ab, $01, $5c, $01, $08, $02, $46, $50, $c8, $96
    db $09, $01 ; id 526 BoneSlave
    db SKILL_SLOWALL
    db SKILL_TWINHITS
    db SKILL_SAMSICALL
    db $ff
    db $80, $25, $07, $34, $f4, $01, $40, $01, $83, $01, $16, $01, $f8, $00, $c2, $01, $46, $8c, $28, $96
    db $07, $01 ; id 527 DeadNoble
    db SKILL_BLIZZARD
    db SKILL_YELLHELP
    db SKILL_EVILSLASH
    db $ff
    db $20, $4e, $07, $36, $20, $03, $30, $02, $a9, $01, $5d, $01, $84, $01, $4e, $02, $96, $1e, $a0, $96
    db $20, $01 ; id 528 RogueNite
    db SKILL_QUADHITS
    db SKILL_CHARGEUP
    db SKILL_MOUTHSHUT
    db $ff
    db $50, $1e, $07, $3a, $02, $03, $e0, $01, $bf, $01, $a7, $01, $16, $01, $30, $02, $c8, $14, $64, $96
    db $25, $01 ; id 529 Balzak
    db SKILL_DRAKSLASH
    db SKILL_BERSERKER
    db SKILL_SUCKALL
    db $ff
    db $bc, $34, $07, $38, $14, $05, $3a, $02, $e8, $01, $3d, $01, $5b, $01, $58, $02, $b4, $0a, $aa, $96
    db $23, $01 ; id 530 Voodoll
    db SKILL_ULTRADOWN
    db SKILL_THICKFOG
    db SKILL_IMITATE
    db $ff
    db $70, $17, $07, $3a, $9e, $02, $a8, $02, $54, $01, $38, $02, $cb, $01, $bc, $02, $46, $c8, $c8, $96
    db $e3, $00 ; id 531 GateGuard
    db SKILL_EXPLODET
    db SKILL_HEALUS
    db SKILL_RAINSLASH
    db $ff
    db $78, $1e, $07, $35, $a8, $02, $ea, $01, $7a, $01, $67, $01, $6f, $01, $4e, $02, $82, $c8, $aa, $96
    db $1f, $01 ; id 532 MadMirror
    db SKILL_INFERMOST
    db SKILL_BOUNCE
    db SKILL_RADIANT
    db $ff
    db $78, $1e, $07, $33, $44, $02, $0c, $03, $22, $01, $e9, $01, $bc, $01, $a8, $02, $1e, $c8, $c8, $96
    db $58, $01 ; id 533 Grakos
    db SKILL_TIDALWAVE
    db SKILL_REVIVE
    db SKILL_MPASSMORE
    db $ff
    db $78, $1e, $07, $36, $0c, $03, $70, $03, $65, $01, $c7, $01, $48, $01, $bc, $02, $46, $d2, $aa, $96
    db $4d, $01 ; id 534 Scallopa
    db SKILL_INCREASE
    db SKILL_MAGICWALL
    db SKILL_RADIANT
    db $ff
    db $41, $12, $04, $2c, $48, $01, $f5, $00, $20, $01, $7b, $01, $e5, $00, $9a, $01, $3c, $78, $96, $64
    db $05, $00 ; id 535 Snaily
    db SKILL_BLIZZARD
    db SKILL_NUMBOFF
    db SKILL_YELLHELP
    db $ff
    db $73, $10, $04, $2d, $f8, $00, $66, $00, $f1, $00, $8f, $01, $5c, $01, $b8, $01, $c8, $28, $50, $64
    db $4a, $01 ; id 536 Clawster
    db SKILL_DRAKSLASH
    db SKILL_METALCUT
    db SKILL_QUADHITS
    db $ff
    db $71, $12, $04, $2e, $66, $01, $4a, $01, $40, $01, $2b, $01, $41, $01, $86, $01, $96, $96, $1e, $64
    db $fd, $00 ; id 537 Shadow
    db SKILL_ICEAIR
    db SKILL_THICKFOG
    db $ff
    db $ff
    db $14, $11, $07, $2b, $22, $01, $36, $01, $3a, $01, $44, $01, $65, $01, $f4, $01, $1e, $14, $c8, $64
    db $2f, $01 ; id 538 Mimic
    db SKILL_BLAZEMORE
    db SKILL_BEAT
    db $ff
    db $ff
    db $0c, $17, $07, $2d, $90, $01, $ea, $01, $68, $01, $3a, $01, $ea, $01, $c2, $01, $6e, $28, $8c, $64
    db $17, $00 ; id 539 MetalKing
    db SKILL_INFERMOST
    db SKILL_EVILSLASH
    db SKILL_EERIELITE
    db SKILL_GEYSER
    db $b0, $9a, $07, $30, $58, $02, $c8, $00, $9a, $01, $5b, $03, $40, $01, $a0, $00, $14, $50, $8c, $96
    db $81, $00 ; id 540 RainHawk
    db SKILL_BIGBANG
    db SKILL_DEMAGIC
    db SKILL_WINDBEAST
    db $ff
    db $c8, $19, $07, $63, $ac, $0d, $08, $02, $c6, $02, $1c, $02, $fa, $00, $4a, $01, $aa, $1e, $82, $96
    db $3b, $00 ; id 541 Coatol
    db SKILL_HEALUS
    db SKILL_TIDALWAVE
    db SKILL_DIAGOCALL
    db SKILL_BIGTRIP
    db $84, $1c, $07, $2e, $dc, $05, $d2, $00, $58, $02, $58, $02, $2c, $01, $ff, $00, $5a, $8c, $64, $96
    db $7c, $00 ; id 542 Phoenix
    db SKILL_BLAZEMOST
    db SKILL_INCREASE
    db SKILL_FIRESLASH
    db SKILL_MASSACRE
    db $d4, $26, $06, $3a, $78, $01, $21, $01, $48, $01, $48, $01, $fb, $00, $6b, $01, $96, $28, $1e, $96
    db $83, $00 ; id 543 Shantak
    db SKILL_EXPLODET
    db SKILL_LIGHTNING
    db SKILL_CURSE
    db SKILL_MEDITATE
    db $7c, $29, $06, $3b, $de, $01, $b4, $00, $64, $01, $0b, $01, $5c, $01, $a6, $02, $aa, $50, $96, $96
    db $7b, $00 ; id 544 Blizzardy
    db SKILL_STOPSPELL
    db SKILL_ICESTORM
    db SKILL_ICESLASH
    db SKILL_LOVERAIN
    db $d4, $26, $06, $39, $7e, $01, $b6, $01, $27, $01, $00, $01, $d6, $01, $4e, $02, $5a, $aa, $3c, $96
    db $f7, $00 ; id 545 Skullgon
    db SKILL_PANICALL
    db SKILL_WHITEAIR
    db SKILL_BEASTCUT
    db SKILL_ROBDANCE
    db $3d, $25, $06, $3b, $dd, $01, $78, $01, $9f, $01, $e7, $00, $c4, $01, $de, $01, $82, $6e, $a0, $96
    db $e7, $00 ; id 546 Akubar
    db SKILL_FIREBOLT
    db SKILL_INCREASE
    db SKILL_BEDRAGON
    db SKILL_QUADHITS
    db $ce, $2c, $06, $37, $ff, $01, $d1, $01, $44, $01, $36, $01, $7e, $01, $88, $02, $8c, $0a, $78, $96
    db $61, $00 ; id 547 DarkHorn
    db SKILL_SLEEPALL
    db SKILL_BOUNCE
    db SKILL_SHEARS
    db SKILL_CHARGEUP
    db $e7, $2b, $06, $38, $16, $02, $64, $00, $77, $01, $0d, $01, $5f, $01, $9b, $02, $64, $8c, $1e, $96
    db $3f, $00 ; id 548 Serpentia
    db SKILL_BOLTSLASH
    db SKILL_BIRDBLOW
    db SKILL_EVILSLASH
    db SKILL_SANDSTORM
    db $0a, $27, $06, $35, $b5, $01, $b6, $01, $84, $01, $b2, $00, $52, $01, $19, $02, $be, $78, $8c, $96
    db $51, $00 ; id 549 SuperTen
    db SKILL_SPEEDUP
    db SKILL_SLEEPAIR
    db SKILL_LUREDANCE
    db SKILL_DANCESHUT
    db $68, $24, $06, $3b, $83, $01, $6b, $01, $41, $01, $10, $01, $66, $01, $41, $02, $82, $8c, $64, $96
    db $5c, $00 ; id 550 Unicorn
    db SKILL_HEALUS
    db SKILL_TWINHITS
    db SKILL_DRAKSLASH
    db SKILL_LIFEDANCE
    db $59, $25, $06, $36, $71, $01, $50, $00, $60, $01, $53, $01, $a2, $01, $a2, $02, $fa, $c8, $14, $96
    db $74, $00 ; id 551 KiteHawk
    db SKILL_MPASSMORE
    db SKILL_SPEEDUP
    db SKILL_SURROUND
    db SKILL_AQUAWALL
    db $05, $25, $06, $39, $5a, $01, $48, $01, $2a, $01, $34, $01, $5c, $01, $d1, $01, $46, $8c, $b4, $96
    db $05, $01 ; id 552 FoxFire
    db SKILL_SCORCHING
    db SKILL_CLEANCUT
    db SKILL_RADIANT
    db SKILL_IMITATE
    db $80, $24, $06, $38, $67, $01, $a1, $01, $37, $01, $14, $01, $25, $01, $de, $01, $96, $96, $28, $96
    db $24, $01 ; id 553 MetalDrak
    db SKILL_MAGICWALL
    db SKILL_SLIMEBLOW
    db SKILL_CHARGEUP
    db SKILL_STRONGD
    db $cf, $25, $06, $3b, $ca, $01, $23, $02, $8a, $01, $52, $01, $3e, $01, $1f, $02, $a0, $a0, $a0, $96
    db $51, $01 ; id 554 AxeShark
    db SKILL_PANICALL
    db SKILL_VACUSLASH
    db SKILL_POISONAIR
    db SKILL_SIDESTEP
    db $ba, $34, $06, $3d, $f3, $01, $85, $01, $91, $01, $03, $01, $1d, $01, $45, $02, $b4, $0a, $28, $96
    db $33, $01 ; id 555 StoneMan
    db SKILL_REVIVE
    db SKILL_AQUACUT
    db SKILL_MASSACRE
    db SKILL_SUCKALL
    db $9f, $30, $06, $3f, $4d, $02, $d3, $01, $ac, $01, $05, $01, $52, $01, $40, $02, $fa, $b4, $50, $96
    db $d4, $00 ; id 556 MedusaEye
    db SKILL_WATERSHOT
    db SKILL_ZOMBIECUT
    db SKILL_PANIDANCE
    db SKILL_TATSUCALL
    db $c8, $28, $06, $3e, $b5, $01, $6e, $00, $52, $01, $3d, $01, $8f, $01, $64, $02, $1e, $8c, $96, $96
    db $c1, $00 ; id 557 MadHornet
    db SKILL_TAKEMAGIC
    db SKILL_DEVILCUT
    db SKILL_PARALYZE
    db SKILL_HIGHJUMP
    db $92, $27, $06, $3f, $dc, $01, $8f, $01, $7a, $01, $0f, $01, $c5, $01, $13, $02, $a0, $46, $5a, $96
    db $97, $00 ; id 558 Oniono
    db SKILL_ANTIDOTE
    db SKILL_BUGBLOW
    db SKILL_PSYCHEUP
    db SKILL_POISONAIR
    db $51, $29, $06, $41, $d8, $01, $a6, $01, $78, $01, $40, $01, $5c, $01, $19, $02, $32, $b4, $78, $96
    db $bb, $00 ; id 559 TailEater
    db SKILL_BLIZZARD
    db SKILL_SLOWALL
    db SKILL_BOUNCE
    db SKILL_TWINSLASH
    db $88, $27, $06, $3f, $6f, $01, $e9, $01, $44, $01, $51, $01, $6d, $01, $4b, $02, $50, $6e, $b4, $96
    db $59, $00 ; id 560 BeastNite
    db SKILL_BEAT
    db SKILL_TRANSFORM
    db SKILL_YELLHELP
    db SKILL_METALCUT
    db $f9, $28, $06, $40, $19, $02, $69, $00, $9f, $01, $35, $01, $49, $01, $16, $02, $c8, $8c, $82, $96
    db $15, $00 ; id 561 MimeSlime
    db SKILL_THORDAIN
    db SKILL_CHANCE
    db SKILL_RAINSLASH
    db SKILL_FOCUS
    db $fe, $38, $06, $43, $d3, $01, $78, $02, $66, $01, $41, $01, $cc, $01, $78, $02, $78, $8c, $82, $96
    db $2f, $00 ; id 562 MadDragon
    db SKILL_SCORCHING
    db SKILL_MASSACRE
    db SKILL_DANCESHUT
    db SKILL_GUARDIAN
    db $06, $2c, $06, $40, $0f, $02, $be, $01, $b6, $01, $06, $01, $2c, $01, $5d, $01, $1e, $1e, $3c, $96
    db $3a, $00 ; id 563 WingSnake
    db SKILL_VACUUM
    db SKILL_BERSERKER
    db SKILL_HUSTLE
    db SKILL_AQUAWALL
    db $2c, $29, $06, $41, $2d, $02, $5a, $00, $83, $01, $15, $01, $ab, $01, $ca, $01, $8c, $50, $aa, $96
    db $3c, $00 ; id 564 Orochi
    db SKILL_HEALALL
    db SKILL_DEFENSE
    db SKILL_MULTICUT
    db SKILL_ULTRADOWN
    db $ad, $3d, $06, $42, $73, $02, $4b, $00, $bf, $01, $36, $01, $1e, $02, $a6, $02, $c8, $c8, $b4, $96
    db $5f, $00 ; id 565 Trumpeter
    db SKILL_CURSEOFF
    db SKILL_TAKEMAGIC
    db SKILL_ROCKTHROW
    db SKILL_DIAGOCALL
    db $67, $2c, $06, $40, $7e, $02, $62, $00, $a2, $01, $ad, $01, $37, $01, $e7, $01, $b4, $82, $b4, $96
    db $6b, $00 ; id 566 Wyvern
    db SKILL_MPASSMOST
    db SKILL_BLAZEAIR
    db SKILL_ICEAIR
    db SKILL_SUCKAIR
    db $a7, $30, $06, $43, $0b, $02, $50, $00, $97, $01, $7c, $01, $66, $01, $ff, $01, $aa, $78, $96, $96
    db $9a, $00 ; id 567 Devipine
    db SKILL_BEAT
    db SKILL_SLOWALL
    db SKILL_SQUALLHIT
    db SKILL_SIDESTEP
    db $a5, $34, $06, $44, $e9, $01, $dd, $01, $84, $01, $64, $01, $5c, $01, $19, $02, $64, $96, $aa, $96
    db $a0, $00 ; id 568 Snapper
    db SKILL_BARRIER
    db SKILL_LIGHTNING
    db SKILL_POISONHIT
    db SKILL_SANDSTORM
    db $1f, $30, $06, $41, $33, $02, $aa, $01, $67, $01, $6d, $01, $56, $01, $42, $02, $8c, $82, $a0, $96
    db $b7, $00 ; id 569 StagBug
    db SKILL_EXPLODET
    db SKILL_IRONIZE
    db SKILL_NAPATTACK
    db SKILL_TWINSLASH
    db $ba, $2c, $06, $43, $d3, $01, $0b, $02, $76, $01, $a5, $01, $75, $01, $f3, $01, $6e, $8c, $78, $96
    db $c0, $00 ; id 570 ArmyCrab
    db SKILL_INCREASE
    db SKILL_TWINHITS
    db SKILL_LIGHTNING
    db SKILL_BIGTRIP
    db $83, $35, $06, $41, $be, $01, $1e, $00, $88, $01, $bd, $01, $24, $01, $42, $02, $5a, $46, $50, $96
    db $de, $00 ; id 571 ArcDemon
    db SKILL_SACRIFICE
    db SKILL_DRAKSLASH
    db SKILL_EVILSLASH
    db SKILL_DEMAGIC
    db $54, $42, $06, $47, $a5, $02, $62, $00, $dc, $01, $7e, $01, $7d, $01, $89, $02, $aa, $82, $50, $96
    db $dc, $00 ; id 572 1EyeClown
    db SKILL_BLIZZARD
    db SKILL_ROBMAGIC
    db SKILL_MAGICWALL
    db SKILL_SHEARS
    db $ac, $3d, $06, $49, $4a, $02, $a6, $02, $7a, $01, $6c, $01, $5a, $01, $7c, $02, $28, $78, $82, $96
    db $e8, $00 ; id 573 MadKnight
    db SKILL_BOUNCE
    db SKILL_HELLBLAST
    db SKILL_FIRESLASH
    db SKILL_RAINSLASH
    db $74, $3f, $06, $49, $8a, $02, $3c, $00, $be, $01, $a0, $01, $67, $01, $17, $02, $c8, $0a, $c8, $96
    db $06, $01 ; id 574 CaptDead
    db SKILL_SLOWALL
    db SKILL_METALCUT
    db SKILL_GEYSER
    db SKILL_AQUAWALL
    db $7f, $3e, $06, $4a, $86, $02, $4d, $02, $d2, $01, $b1, $01, $2c, $01, $2b, $02, $aa, $a0, $82, $96
    db $0b, $01 ; id 575 Servant
    db SKILL_BEAT
    db SKILL_SLEEPALL
    db SKILL_QUADHITS
    db SKILL_CURSE
    db $fd, $41, $06, $49, $7e, $02, $1e, $00, $ca, $01, $9e, $01, $64, $01, $4d, $02, $be, $b4, $be, $96
    db $2d, $01 ; id 576 LavaMan
    db SKILL_DECHAOS
    db SKILL_BIGBANG
    db SKILL_SICKLICK
    db SKILL_DODGE
    db $34, $53, $06, $4d, $ea, $02, $30, $00, $f4, $01, $c3, $01, $5c, $01, $57, $02, $aa, $be, $a0, $96
    db $34, $01 ; id 577 BombCrag
    db SKILL_INCREASE
    db SKILL_TIDALWAVE
    db SKILL_SURGE
    db SKILL_BLADED
    db $84, $4e, $06, $4e, $d9, $02, $64, $00, $98, $01, $05, $02, $15, $01, $4c, $02, $14, $46, $50, $96
    db $48, $01 ; id 578 RushFish
    db SKILL_SLEEPALL
    db SKILL_TIDALWAVE
    db SKILL_PSYCHEUP
    db SKILL_KAMIKAZE
    db $a6, $4d, $06, $4c, $b9, $02, $2d, $00, $83, $01, $cc, $01, $8c, $01, $06, $02, $aa, $6e, $1e, $96
    db $55, $01 ; id 579 WhaleMage
    db SKILL_TWINHITS
    db SKILL_BEDRAGON
    db SKILL_SQUALLHIT
    db SKILL_ROBDANCE
    db $30, $52, $06, $4e, $cc, $02, $37, $00, $cc, $01, $7d, $01, $a7, $01, $9c, $02, $64, $b4, $82, $96
    db $13, $00 ; id 580 SpotKing
    db SKILL_INFERMOST
    db SKILL_PANICALL
    db SKILL_MULTICUT
    db SKILL_SEALPRAY
    db $59, $50, $06, $4f, $e2, $02, $3a, $00, $98, $01, $86, $01, $8a, $01, $a6, $02, $b4, $5a, $8c, $96
    db $0e, $00 ; id 581 SlimeBorg
    db SKILL_FIREBOLT
    db SKILL_SPEEDUP
    db SKILL_YELLHELP
    db SKILL_EERIELITE
    db $84, $4e, $06, $52, $0b, $03, $88, $00, $9f, $01, $b5, $01, $72, $01, $93, $02, $8c, $28, $78, $96
    db $29, $00 ; id 582 LizardMan
    db SKILL_BOUNCE
    db SKILL_GIGASLASH
    db SKILL_ULTRADOWN
    db SKILL_SAMSICALL
    db $8b, $53, $06, $54, $fb, $02, $61, $00, $7e, $02, $e1, $01, $d9, $01, $86, $02, $c8, $82, $78, $96
    db $38, $00 ; id 583 GreatDrak
    db SKILL_INFERMOST
    db SKILL_WHITEAIR
    db SKILL_FOCUS
    db SKILL_GUARDIAN
    db $bf, $5b, $06, $53, $09, $03, $48, $01, $a1, $02, $6d, $02, $9a, $01, $4c, $02, $c8, $aa, $b4, $96
    db $62, $00 ; id 584 MadCat
    db SKILL_SLOWALL
    db SKILL_YELLHELP
    db SKILL_DRAKSLASH
    db SKILL_SQUALLHIT
    db $03, $5c, $06, $53, $f7, $02, $ac, $01, $95, $02, $be, $01, $1a, $02, $7a, $02, $be, $78, $64, $96
    db $7a, $00 ; id 585 Emyu
    db SKILL_BLIZZARD
    db SKILL_SLEEPALL
    db SKILL_RAINSLASH
    db SKILL_LUREDANCE
    db $0d, $60, $06, $55, $e3, $02, $8f, $01, $73, $02, $d6, $01, $07, $02, $6e, $02, $96, $b4, $28, $96
    db $c4, $00 ; id 586 HornBeet
    db SKILL_SURROUND
    db SKILL_PSYCHEUP
    db SKILL_DANCESHUT
    db SKILL_MOUTHSHUT
    db $0d, $60, $06, $56, $d8, $02, $a7, $00, $4d, $02, $18, $02, $99, $01, $87, $02, $82, $96, $be, $96
    db $e2, $00 ; id 587 Ogre
    db SKILL_TWINHITS
    db SKILL_BEDRAGON
    db SKILL_ROCKTHROW
    db SKILL_BERSERKER
    db $ad, $5b, $06, $55, $f5, $02, $59, $00, $82, $02, $db, $01, $ca, $01, $7e, $02, $be, $14, $5a, $96
    db $f8, $00 ; id 588 PutrePup
    db SKILL_NUMBOFF
    db SKILL_MAGICWALL
    db SKILL_DEVILCUT
    db SKILL_POISONAIR
    db $bb, $57, $06, $56, $d9, $02, $14, $00, $64, $02, $97, $01, $be, $01, $b2, $02, $3c, $82, $8c, $96
    db $2a, $01 ; id 589 Roboster2
    db SKILL_THORDAIN
    db SKILL_REVIVE
    db SKILL_SQUALLHIT
    db SKILL_RADIANT
    db $ae, $68, $06, $57, $ff, $02, $78, $00, $88, $02, $8a, $02, $f6, $01, $b0, $02, $be, $fa, $00, $96
    db $35, $01 ; id 590 GoldGolem
    db SKILL_VACUUM
    db SKILL_CHARGEUP
    db SKILL_SURGE
    db SKILL_THICKFOG
    db $12, $87, $06, $56, $46, $03, $8a, $00, $9f, $02, $0e, $02, $03, $02, $9a, $02, $c8, $c8, $c8, $96
    db $08, $01 ; id 591 WhiteKing
    db SKILL_EXPLODET
    db SKILL_BLIZZARD
    db SKILL_HEALALL
    db SKILL_MAGICWALL
    db $42, $93, $06, $58, $2c, $03, $ad, $02, $73, $02, $49, $01, $a5, $01, $e4, $02, $64, $c8, $c8, $96
    ds $36b, $00
