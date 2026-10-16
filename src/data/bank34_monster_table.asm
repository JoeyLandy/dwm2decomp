; ROM bank $34: the monster table
; The annotated listing of this bank is build/listing/bank34.asm.

SECTION "Bank 34", ROMX[$4000], BANK[$34]
    db $34

; wMonsterId (16 bit, wMonsterId + 1 is the high byte) = monster id: copies its 26-byte MonsterTable
; record to wRecordBuffer (LoadMonsterRecordTo with DE = wRecordBuffer). Ids below $250 come from
; this bank (record at $4075 + 26 * id), ids from $250 on from bank $A2. Far-called by the battle
; code and the debug menu among others. (C2, E-0380)
; wMonsterId/wMonsterId + $1 = monster id: copies its 26-byte MonsterTable record to wRecordBuffer
; (ids at or above $250 come from bank $A2 through LoadMonsterRecordTo_HighIds)
LoadMonsterRecord::
    ld de, wRecordBuffer
    call LoadMonsterRecordTo
    ret

; Copies part of a monster record: wMonsterId (16 bit) = monster id, C = first byte inside the
; 26-byte record, hTemp0 = number of bytes, DE = destination. Ids below $250 are read from
; MonsterTable in this bank (record at $4075 + 26 * id); ids from $250 on are passed to
; CopyMonsterTableBytes in bank $A2. Callers (LoadEncounterMonsterIdsToWorkBuf,
; SetupMap0BMonsterObjects) use it to read the first two bytes of a record (the picture number) into
; hTemp0/hTemp1. (C2, E-0380)
; copies hTemp0 bytes of the 26-byte entry of monster wMonsterId/wMonsterId + $1 plus C from $4075
; to DE; ids from $250 use CopyMonsterTableBytes in bank $A2 (E-0125)
CopyMonsterTableBytesFromMonsterTable::
    ld a, [wMonsterId + $1]
    cp $02
    jr c, .read_monster_id
    ld a, [wMonsterId]
    cp $50
    jr c, .read_monster_id
    farcall CopyMonsterTableBytes
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

; DE = destination: copies the 26-byte record of monster id wMonsterId (16 bit) from MonsterTable
; (record at $4075 + 26 * id, Multiply8By16 with A = $1A) to [DE], then falls into CopyBytesDEFromHL
; with B = $1A. Ids from $250 on are handed to LoadMonsterRecordTo_HighIds in bank $A2 (record at
; $4056 + 26 * (id - $24F)). Called by LoadMonsterRecord. (C2, E-0380)
; DE = destination: like LoadMonsterRecord but copies the 26-byte record to [DE]
LoadMonsterRecordTo::
    ld a, [wMonsterId + $1]
    cp $02
    jr c, .read_monster_id
    ld a, [wMonsterId]
    cp $50
    jr c, .read_monster_id
    farcall LoadMonsterRecordTo_HighIds
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

; B = count (0 means 256): copies B bytes from [HL] to [DE], advancing both, and returns with B = 0.
; LoadMonsterRecordTo falls into it and CopyMonsterTableBytesFromMonsterTable calls it. (C2, E-0380)
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
    dw $0000 ; id 0: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $00 ; join-chance class
    db $00 ; level
    dw 0 ; base HP
    dw 0 ; base MP
    dw 0 ; base ATK
    dw 0 ; base DEF
    dw 0 ; base AGL
    dw 0 ; base INT
    db $00 ; personality axis $6F
    db $00 ; personality axis $70
    db $00 ; byte 24 ($71)
    db $00 ; personality axis $72
    dw MONSTER_SLIME ; id 1 Slime: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $00 ; join-chance class
    db $01 ; level
    dw 25 ; base HP
    dw 0 ; base MP
    dw 10 ; base ATK
    dw 7 ; base DEF
    dw 8 ; base AGL
    dw 7 ; base INT
    db $c8 ; personality axis $6F
    db $c8 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_SPOTSLIME ; id 2 SpotSlime: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 3 ; EXP
    db $01 ; join-chance class
    db $01 ; level
    dw 8 ; base HP
    dw 0 ; base MP
    dw 7 ; base ATK
    dw 5 ; base DEF
    dw 8 ; base AGL
    dw 4 ; base INT
    db $78 ; personality axis $6F
    db $50 ; personality axis $70
    db $3c ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_CACTIBALL ; id 3 CactiBall: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 6 ; EXP
    db $02 ; join-chance class
    db $05 ; level
    dw 10 ; base HP
    dw 6 ; base MP
    dw 11 ; base ATK
    dw 4 ; base DEF
    dw 10 ; base AGL
    dw 10 ; base INT
    db $aa ; personality axis $6F
    db $46 ; personality axis $70
    db $1e ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_TAILEATER ; id 4 TailEater: picture: monster id
    db SKILL_ICESLASH ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 7 ; EXP
    db $02 ; join-chance class
    db $02 ; level
    dw 12 ; base HP
    dw 8 ; base MP
    dw 14 ; base ATK
    dw 6 ; base DEF
    dw 15 ; base AGL
    dw 20 ; base INT
    db $82 ; personality axis $6F
    db $46 ; personality axis $70
    db $3c ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_CRESTPENT ; id 5 Crestpent: picture: monster id
    db SKILL_STOPSPELL ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 10 ; EXP
    db $02 ; join-chance class
    db $03 ; level
    dw 14 ; base HP
    dw 6 ; base MP
    dw 16 ; base ATK
    dw 9 ; base DEF
    dw 13 ; base AGL
    dw 34 ; base INT
    db $c8 ; personality axis $6F
    db $3c ; personality axis $70
    db $1e ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_KINGCOBRA ; id 6 KingCobra: picture: monster id
    db SKILL_POISONHIT ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 17 ; EXP
    db $03 ; join-chance class
    db $01 ; level
    dw 18 ; base HP
    dw 8 ; base MP
    dw 20 ; base ATK
    dw 11 ; base DEF
    dw 18 ; base AGL
    dw 40 ; base INT
    db $be ; personality axis $6F
    db $5a ; personality axis $70
    db $46 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_CURSELAMP ; id 7 CurseLamp: picture: monster id
    db SKILL_UPPER ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 300 ; EXP
    db $00 ; join-chance class
    db $05 ; level
    dw 220 ; base HP
    dw 8 ; base MP
    dw 27 ; base ATK
    dw 10 ; base DEF
    dw 44 ; base AGL
    dw 65 ; base INT
    db $e6 ; personality axis $6F
    db $96 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_CURSELAMP ; id 8 CurseLamp: picture: monster id
    db SKILL_UPPER ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $00 ; join-chance class
    db $05 ; level
    dw 54 ; base HP
    dw 21 ; base MP
    dw 27 ; base ATK
    dw 31 ; base DEF
    dw 44 ; base AGL
    dw 53 ; base INT
    db $82 ; personality axis $6F
    db $64 ; personality axis $70
    db $78 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_SLIME ; id 9 Slime: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 9 ; EXP
    db $02 ; join-chance class
    db $04 ; level
    dw 27 ; base HP
    dw 28 ; base MP
    dw 13 ; base ATK
    dw 9 ; base DEF
    dw 27 ; base AGL
    dw 70 ; base INT
    db $b4 ; personality axis $6F
    db $b4 ; personality axis $70
    db $50 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_ANTBEAR ; id 10 Antbear: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 27 ; EXP
    db $02 ; join-chance class
    db $05 ; level
    dw 38 ; base HP
    dw 16 ; base MP
    dw 27 ; base ATK
    dw 21 ; base DEF
    dw 18 ; base AGL
    dw 48 ; base INT
    db $aa ; personality axis $6F
    db $d2 ; personality axis $70
    db $aa ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_DRACKY ; id 11 Dracky: picture: monster id
    db SKILL_SLEEP ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 21 ; EXP
    db $02 ; join-chance class
    db $04 ; level
    dw 21 ; base HP
    dw 35 ; base MP
    dw 26 ; base ATK
    dw 11 ; base DEF
    dw 42 ; base AGL
    dw 72 ; base INT
    db $fa ; personality axis $6F
    db $96 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_EGGPLATON ; id 12 Eggplaton: picture: monster id
    db SKILL_NAPATTACK ; skill 1
    db SKILL_ODDDANCE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 28 ; EXP
    db $02 ; join-chance class
    db $05 ; level
    dw 24 ; base HP
    dw 34 ; base MP
    dw 20 ; base ATK
    dw 18 ; base DEF
    dw 21 ; base AGL
    dw 79 ; base INT
    db $78 ; personality axis $6F
    db $5a ; personality axis $70
    db $46 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_JEWELBAG ; id 13 JewelBag: picture: monster id
    db SKILL_FIREBAL ; skill 1
    db SKILL_STOPSPELL ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 78 ; EXP
    db $02 ; join-chance class
    db $09 ; level
    dw 46 ; base HP
    dw 41 ; base MP
    dw 36 ; base ATK
    dw 40 ; base DEF
    dw 94 ; base AGL
    dw 223 ; base INT
    db $be ; personality axis $6F
    db $50 ; personality axis $70
    db $00 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_HORK ; id 14 Hork: picture: monster id
    db SKILL_POISONGAS ; skill 1
    db SKILL_LUSHLICKS ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 177 ; EXP
    db $03 ; join-chance class
    db $08 ; level
    dw 70 ; base HP
    dw 33 ; base MP
    dw 55 ; base ATK
    dw 27 ; base DEF
    dw 49 ; base AGL
    dw 100 ; base INT
    db $dc ; personality axis $6F
    db $14 ; personality axis $70
    db $14 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_WYVERN ; id 15 Wyvern: picture: monster id
    db SKILL_HEAL ; skill 1
    db SKILL_SLEEP ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 155 ; EXP
    db $03 ; join-chance class
    db $0d ; level
    dw 61 ; base HP
    dw 62 ; base MP
    dw 53 ; base ATK
    dw 41 ; base DEF
    dw 95 ; base AGL
    dw 158 ; base INT
    db $e6 ; personality axis $6F
    db $50 ; personality axis $70
    db $32 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_ARMYANT ; id 16 ArmyAnt: picture: monster id
    db SKILL_NAPATTACK ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 30 ; EXP
    db $01 ; join-chance class
    db $07 ; level
    dw 20 ; base HP
    dw 20 ; base MP
    dw 19 ; base ATK
    dw 31 ; base DEF
    dw 47 ; base AGL
    dw 58 ; base INT
    db $fa ; personality axis $6F
    db $96 ; personality axis $70
    db $1e ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_MADGOPHER ; id 17 MadGopher: picture: monster id
    db SKILL_ZOMBIECUT ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 45 ; EXP
    db $01 ; join-chance class
    db $07 ; level
    dw 40 ; base HP
    dw 37 ; base MP
    dw 38 ; base ATK
    dw 36 ; base DEF
    dw 29 ; base AGL
    dw 86 ; base INT
    db $c8 ; personality axis $6F
    db $32 ; personality axis $70
    db $32 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_1EYECLOWN ; id 18 1EyeClown: picture: monster id
    db SKILL_BLAZE ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 58 ; EXP
    db $03 ; join-chance class
    db $07 ; level
    dw 27 ; base HP
    dw 19 ; base MP
    dw 26 ; base ATK
    dw 29 ; base DEF
    dw 51 ; base AGL
    dw 158 ; base INT
    db $aa ; personality axis $6F
    db $28 ; personality axis $70
    db $d2 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_SNAILY ; id 19 Snaily: picture: monster id
    db SKILL_ICEBOLT ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 127 ; EXP
    db $02 ; join-chance class
    db $0a ; level
    dw 29 ; base HP
    dw 41 ; base MP
    dw 31 ; base ATK
    dw 55 ; base DEF
    dw 124 ; base AGL
    dw 89 ; base INT
    db $aa ; personality axis $6F
    db $78 ; personality axis $70
    db $50 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_POISONGON ; id 20 Poisongon: picture: monster id
    db SKILL_POISONHIT ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 55 ; EXP
    db $03 ; join-chance class
    db $09 ; level
    dw 55 ; base HP
    dw 47 ; base MP
    dw 50 ; base ATK
    dw 31 ; base DEF
    dw 36 ; base AGL
    dw 74 ; base INT
    db $8c ; personality axis $6F
    db $dc ; personality axis $70
    db $14 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_MORAY ; id 21 Moray: picture: monster id
    db SKILL_POISONGAS ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 102 ; EXP
    db $02 ; join-chance class
    db $09 ; level
    dw 37 ; base HP
    dw 31 ; base MP
    dw 26 ; base ATK
    dw 28 ; base DEF
    dw 20 ; base AGL
    dw 100 ; base INT
    db $fa ; personality axis $6F
    db $14 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_EYEDER ; id 22 Eyeder: picture: monster id
    db SKILL_FIREBAL ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 133 ; EXP
    db $03 ; join-chance class
    db $0d ; level
    dw 42 ; base HP
    dw 29 ; base MP
    dw 30 ; base ATK
    dw 31 ; base DEF
    dw 60 ; base AGL
    dw 139 ; base INT
    db $8c ; personality axis $6F
    db $3c ; personality axis $70
    db $5a ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_PUTREFISH ; id 23 PutreFish: picture: monster id
    db SKILL_WATERSHOT ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 99 ; EXP
    db $03 ; join-chance class
    db $09 ; level
    dw 39 ; base HP
    dw 25 ; base MP
    dw 27 ; base ATK
    dw 19 ; base DEF
    dw 89 ; base AGL
    dw 138 ; base INT
    db $8c ; personality axis $6F
    db $14 ; personality axis $70
    db $aa ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_GAMANIAN ; id 24 Gamanian: picture: monster id
    db SKILL_NAPATTACK ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 93 ; EXP
    db $03 ; join-chance class
    db $09 ; level
    dw 37 ; base HP
    dw 32 ; base MP
    dw 35 ; base ATK
    dw 26 ; base DEF
    dw 71 ; base AGL
    dw 290 ; base INT
    db $8c ; personality axis $6F
    db $64 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_SPIKYBOY ; id 25 SpikyBoy: picture: monster id
    db SKILL_SLIMEBLOW ; skill 1
    db SKILL_HIGHJUMP ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 106 ; EXP
    db $02 ; join-chance class
    db $09 ; level
    dw 53 ; base HP
    dw 41 ; base MP
    dw 47 ; base ATK
    dw 31 ; base DEF
    dw 58 ; base AGL
    dw 129 ; base INT
    db $a0 ; personality axis $6F
    db $82 ; personality axis $70
    db $5a ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_HOODSQUID ; id 26 HoodSquid: picture: monster id
    db SKILL_BIATTACK ; skill 1
    db SKILL_LUREDANCE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 520 ; EXP
    db $07 ; join-chance class
    db $0c ; level
    dw 350 ; base HP
    dw 100 ; base MP
    dw 78 ; base ATK
    dw 39 ; base DEF
    dw 85 ; base AGL
    dw 180 ; base INT
    db $d2 ; personality axis $6F
    db $28 ; personality axis $70
    db $be ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_HOODSQUID ; id 27 HoodSquid: picture: monster id
    db SKILL_BIATTACK ; skill 1
    db SKILL_LUREDANCE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $00 ; join-chance class
    db $0c ; level
    dw 89 ; base HP
    dw 78 ; base MP
    dw 69 ; base ATK
    dw 60 ; base DEF
    dw 85 ; base AGL
    dw 180 ; base INT
    db $dc ; personality axis $6F
    db $28 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_CAPTDEAD ; id 28 CaptDead: picture: monster id
    db SKILL_CALLHELP ; skill 1
    db SKILL_AQUACUT ; skill 2
    db SKILL_SQUALLHIT ; skill 3
    db $ff ; skill 4
    dw 800 ; EXP
    db $07 ; join-chance class
    db $0d ; level
    dw 500 ; base HP
    dw 105 ; base MP
    dw 66 ; base ATK
    dw 48 ; base DEF
    dw 50 ; base AGL
    dw 144 ; base INT
    db $96 ; personality axis $6F
    db $0a ; personality axis $70
    db $28 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_PETITEEL ; id 29 Petiteel: picture: monster id
    db SKILL_SPEEDUP ; skill 1
    db SKILL_RAMMING ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 148 ; EXP
    db $02 ; join-chance class
    db $0c ; level
    dw 58 ; base HP
    dw 63 ; base MP
    dw 32 ; base ATK
    dw 28 ; base DEF
    dw 89 ; base AGL
    dw 133 ; base INT
    db $c8 ; personality axis $6F
    db $64 ; personality axis $70
    db $46 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_ROTRAVEN ; id 30 RotRaven: picture: monster id
    db SKILL_BOLTSLASH ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 130 ; EXP
    db $03 ; join-chance class
    db $0d ; level
    dw 66 ; base HP
    dw 36 ; base MP
    dw 55 ; base ATK
    dw 41 ; base DEF
    dw 77 ; base AGL
    dw 119 ; base INT
    db $82 ; personality axis $6F
    db $50 ; personality axis $70
    db $46 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_MERMAN ; id 31 Merman: picture: monster id
    db SKILL_SAP ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 155 ; EXP
    db $03 ; join-chance class
    db $0b ; level
    dw 54 ; base HP
    dw 42 ; base MP
    dw 45 ; base ATK
    dw 48 ; base DEF
    dw 71 ; base AGL
    dw 156 ; base INT
    db $96 ; personality axis $6F
    db $28 ; personality axis $70
    db $aa ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_OCTOKID ; id 32 Octokid: picture: monster id
    db SKILL_HEAL ; skill 1
    db SKILL_LUREDANCE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 102 ; EXP
    db $02 ; join-chance class
    db $0b ; level
    dw 77 ; base HP
    dw 92 ; base MP
    dw 59 ; base ATK
    dw 36 ; base DEF
    dw 46 ; base AGL
    dw 197 ; base INT
    db $28 ; personality axis $6F
    db $3c ; personality axis $70
    db $96 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_ROGUEWAVE ; id 33 RogueWave: picture: monster id
    db SKILL_WATERSHOT ; skill 1
    db SKILL_AQUAWALL ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 111 ; EXP
    db $02 ; join-chance class
    db $09 ; level
    dw 41 ; base HP
    dw 35 ; base MP
    dw 40 ; base ATK
    dw 34 ; base DEF
    dw 141 ; base AGL
    dw 207 ; base INT
    db $aa ; personality axis $6F
    db $96 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_PEARLGEL ; id 34 PearlGel: picture: monster id
    db SKILL_UPPER ; skill 1
    db SKILL_CHARGEUP ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 89 ; EXP
    db $02 ; join-chance class
    db $09 ; level
    dw 37 ; base HP
    dw 32 ; base MP
    dw 27 ; base ATK
    dw 34 ; base DEF
    dw 124 ; base AGL
    dw 200 ; base INT
    db $a0 ; personality axis $6F
    db $46 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_TORTRAGON ; id 35 Tortragon: picture: monster id
    db SKILL_MAGICBACK ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 254 ; EXP
    db $03 ; join-chance class
    db $0c ; level
    dw 66 ; base HP
    dw 38 ; base MP
    dw 49 ; base ATK
    dw 74 ; base DEF
    dw 66 ; base AGL
    dw 123 ; base INT
    db $c8 ; personality axis $6F
    db $d2 ; personality axis $70
    db $46 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_AQUAHAWK ; id 36 AquaHawk: picture: monster id
    db SKILL_CURSEOFF ; skill 1
    db SKILL_AQUAWALL ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 211 ; EXP
    db $03 ; join-chance class
    db $0d ; level
    dw 47 ; base HP
    dw 33 ; base MP
    dw 60 ; base ATK
    dw 44 ; base DEF
    dw 82 ; base AGL
    dw 350 ; base INT
    db $8c ; personality axis $6F
    db $96 ; personality axis $70
    db $1e ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_DARKEYE ; id 37 DarkEye: picture: monster id
    db SKILL_CLEANCUT ; skill 1
    db SKILL_RADIANT ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 228 ; EXP
    db $03 ; join-chance class
    db $0d ; level
    dw 74 ; base HP
    dw 69 ; base MP
    dw 48 ; base ATK
    dw 41 ; base DEF
    dw 65 ; base AGL
    dw 151 ; base INT
    db $c8 ; personality axis $6F
    db $50 ; personality axis $70
    db $d2 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_RAYGIGAS ; id 38 RayGigas: picture: monster id
    db SKILL_FIREBAL ; skill 1
    db SKILL_MOUTHSHUT ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 199 ; EXP
    db $03 ; join-chance class
    db $0c ; level
    dw 72 ; base HP
    dw 62 ; base MP
    dw 48 ; base ATK
    dw 42 ; base DEF
    dw 80 ; base AGL
    dw 137 ; base INT
    db $78 ; personality axis $6F
    db $82 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_EVILWAND ; id 39 EvilWand: picture: monster id
    db SKILL_FRIGIDAIR ; skill 1
    db SKILL_MAPMAGIC ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 188 ; EXP
    db $03 ; join-chance class
    db $0d ; level
    dw 53 ; base HP
    dw 64 ; base MP
    dw 54 ; base ATK
    dw 42 ; base DEF
    dw 70 ; base AGL
    dw 204 ; base INT
    db $96 ; personality axis $6F
    db $8c ; personality axis $70
    db $46 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_SLIMENITE ; id 40 SlimeNite: picture: monster id
    db SKILL_HEAL ; skill 1
    db SKILL_UPPER ; skill 2
    db SKILL_BEASTCUT ; skill 3
    db $ff ; skill 4
    dw 277 ; EXP
    db $03 ; join-chance class
    db $0f ; level
    dw 74 ; base HP
    dw 47 ; base MP
    dw 64 ; base ATK
    dw 49 ; base DEF
    dw 174 ; base AGL
    dw 276 ; base INT
    db $8c ; personality axis $6F
    db $78 ; personality axis $70
    db $a0 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_LIZARDMAN ; id 41 LizardMan: picture: monster id
    db SKILL_AQUACUT ; skill 1
    db SKILL_EVILSLASH ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 503 ; EXP
    db $03 ; join-chance class
    db $11 ; level
    dw 93 ; base HP
    dw 53 ; base MP
    dw 78 ; base ATK
    dw 69 ; base DEF
    dw 90 ; base AGL
    dw 273 ; base INT
    db $b4 ; personality axis $6F
    db $64 ; personality axis $70
    db $1e ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_HAMMERMAN ; id 42 HammerMan: picture: monster id
    db SKILL_CHARGEUP ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 311 ; EXP
    db $02 ; join-chance class
    db $0f ; level
    dw 80 ; base HP
    dw 55 ; base MP
    dw 65 ; base ATK
    dw 50 ; base DEF
    dw 91 ; base AGL
    dw 139 ; base INT
    db $50 ; personality axis $6F
    db $8c ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_YETI ; id 43 Yeti: picture: monster id
    db SKILL_ICEBOLT ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 301 ; EXP
    db $03 ; join-chance class
    db $10 ; level
    dw 80 ; base HP
    dw 45 ; base MP
    dw 69 ; base ATK
    dw 45 ; base DEF
    dw 64 ; base AGL
    dw 133 ; base INT
    db $be ; personality axis $6F
    db $50 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_ORC ; id 44 Orc: picture: monster id
    db SKILL_VIVIFY ; skill 1
    db SKILL_SAP ; skill 2
    db SKILL_BIRDBLOW ; skill 3
    db $ff ; skill 4
    dw 330 ; EXP
    db $03 ; join-chance class
    db $14 ; level
    dw 95 ; base HP
    dw 47 ; base MP
    dw 89 ; base ATK
    dw 64 ; base DEF
    dw 72 ; base AGL
    dw 254 ; base INT
    db $c8 ; personality axis $6F
    db $c8 ; personality axis $70
    db $50 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_GISMO ; id 45 Gismo: picture: monster id
    db SKILL_FIREAIR ; skill 1
    db SKILL_FRIGIDAIR ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 287 ; EXP
    db $03 ; join-chance class
    db $10 ; level
    dw 58 ; base HP
    dw 72 ; base MP
    dw 53 ; base ATK
    dw 51 ; base DEF
    dw 141 ; base AGL
    dw 157 ; base INT
    db $fa ; personality axis $6F
    db $1e ; personality axis $70
    db $96 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_DROLL ; id 46 Droll: picture: monster id
    db SKILL_SLOWALL ; skill 1
    db SKILL_SHEARS ; skill 2
    db SKILL_STEPGUARD ; skill 3
    db $ff ; skill 4
    dw 388 ; EXP
    db $03 ; join-chance class
    db $11 ; level
    dw 80 ; base HP
    dw 45 ; base MP
    dw 70 ; base ATK
    dw 57 ; base DEF
    dw 49 ; base AGL
    dw 249 ; base INT
    db $fa ; personality axis $6F
    db $8c ; personality axis $70
    db $1e ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_GOOPI ; id 47 Goopi: picture: monster id
    db SKILL_LEGSWEEP ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 326 ; EXP
    db $02 ; join-chance class
    db $0d ; level
    dw 59 ; base HP
    dw 72 ; base MP
    dw 65 ; base ATK
    dw 50 ; base DEF
    dw 59 ; base AGL
    dw 155 ; base INT
    db $96 ; personality axis $6F
    db $96 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_MUMMY ; id 48 Mummy: picture: monster id
    db SKILL_PARALYZE ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 377 ; EXP
    db $03 ; join-chance class
    db $11 ; level
    dw 65 ; base HP
    dw 78 ; base MP
    dw 66 ; base ATK
    dw 48 ; base DEF
    dw 82 ; base AGL
    dw 267 ; base INT
    db $5a ; personality axis $6F
    db $3c ; personality axis $70
    db $46 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_TREEBOY ; id 49 TreeBoy: picture: monster id
    db SKILL_MPASS ; skill 1
    db SKILL_CURSEOFF ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 326 ; EXP
    db $03 ; join-chance class
    db $11 ; level
    dw 72 ; base HP
    dw 90 ; base MP
    dw 58 ; base ATK
    dw 53 ; base DEF
    dw 85 ; base AGL
    dw 183 ; base INT
    db $1e ; personality axis $6F
    db $d2 ; personality axis $70
    db $6e ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_BOMBCRAG ; id 50 BombCrag: picture: monster id
    db SKILL_ROCKTHROW ; skill 1
    db SKILL_CHARGEUP ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 2018 ; EXP
    db $07 ; join-chance class
    db $12 ; level
    dw 650 ; base HP
    dw 10 ; base MP
    dw 80 ; base ATK
    dw 80 ; base DEF
    dw 20 ; base AGL
    dw 140 ; base INT
    db $46 ; personality axis $6F
    db $46 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_ROGUENITE ; id 51 RogueNite: picture: monster id
    db SKILL_HEAL ; skill 1
    db SKILL_METALCUT ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 529 ; EXP
    db $04 ; join-chance class
    db $14 ; level
    dw 93 ; base HP
    dw 58 ; base MP
    dw 94 ; base ATK
    dw 80 ; base DEF
    dw 55 ; base AGL
    dw 159 ; base INT
    db $c8 ; personality axis $6F
    db $1e ; personality axis $70
    db $32 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_GRIZZLY ; id 52 Grizzly: picture: monster id
    db SKILL_SQUALLHIT ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 477 ; EXP
    db $04 ; join-chance class
    db $10 ; level
    dw 124 ; base HP
    dw 40 ; base MP
    dw 64 ; base ATK
    dw 48 ; base DEF
    dw 57 ; base AGL
    dw 129 ; base INT
    db $c8 ; personality axis $6F
    db $d2 ; personality axis $70
    db $14 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_DEMONITE ; id 53 Demonite: picture: monster id
    db SKILL_BLAZE ; skill 1
    db SKILL_FIREAIR ; skill 2
    db SKILL_FRIGIDAIR ; skill 3
    db $ff ; skill 4
    dw 319 ; EXP
    db $02 ; join-chance class
    db $13 ; level
    dw 73 ; base HP
    dw 28 ; base MP
    dw 59 ; base ATK
    dw 39 ; base DEF
    dw 97 ; base AGL
    dw 218 ; base INT
    db $c8 ; personality axis $6F
    db $32 ; personality axis $70
    db $6e ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_GULPPLE ; id 54 Gulpple: picture: monster id
    db SKILL_HIGHJUMP ; skill 1
    db SKILL_SLEEPAIR ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 259 ; EXP
    db $04 ; join-chance class
    db $0d ; level
    dw 67 ; base HP
    dw 71 ; base MP
    dw 43 ; base ATK
    dw 49 ; base DEF
    dw 88 ; base AGL
    dw 236 ; base INT
    db $c8 ; personality axis $6F
    db $dc ; personality axis $70
    db $0a ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_FOXFIRE ; id 55 FoxFire: picture: monster id
    db SKILL_BLAZE ; skill 1
    db SKILL_FIREBAL ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 251 ; EXP
    db $03 ; join-chance class
    db $12 ; level
    dw 81 ; base HP
    dw 130 ; base MP
    dw 75 ; base ATK
    dw 60 ; base DEF
    dw 99 ; base AGL
    dw 326 ; base INT
    db $64 ; personality axis $6F
    db $78 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_ALMIRAJ ; id 56 Almiraj: picture: monster id
    db SKILL_SLEEP ; skill 1
    db SKILL_CHARGEUP ; skill 2
    db SKILL_BERSERKER ; skill 3
    db $ff ; skill 4
    dw 371 ; EXP
    db $03 ; join-chance class
    db $13 ; level
    dw 96 ; base HP
    dw 77 ; base MP
    dw 60 ; base ATK
    dw 57 ; base DEF
    dw 104 ; base AGL
    dw 169 ; base INT
    db $fa ; personality axis $6F
    db $78 ; personality axis $70
    db $00 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_LANDOWL ; id 57 LandOwl: picture: monster id
    db SKILL_INFERNOS ; skill 1
    db SKILL_BOLTSLASH ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 323 ; EXP
    db $04 ; join-chance class
    db $16 ; level
    dw 104 ; base HP
    dw 102 ; base MP
    dw 81 ; base ATK
    dw 72 ; base DEF
    dw 66 ; base AGL
    dw 204 ; base INT
    db $c8 ; personality axis $6F
    db $78 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_GOATEGON ; id 58 Goategon: picture: monster id
    db SKILL_FIREBANE ; skill 1
    db SKILL_SLOW ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 399 ; EXP
    db $03 ; join-chance class
    db $14 ; level
    dw 110 ; base HP
    dw 67 ; base MP
    dw 108 ; base ATK
    dw 78 ; base DEF
    dw 85 ; base AGL
    dw 399 ; base INT
    db $fa ; personality axis $6F
    db $a0 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_SACCER ; id 59 Saccer: picture: monster id
    db SKILL_UPPER ; skill 1
    db SKILL_PSYCHEUP ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 244 ; EXP
    db $03 ; join-chance class
    db $10 ; level
    dw 115 ; base HP
    dw 67 ; base MP
    dw 55 ; base ATK
    dw 40 ; base DEF
    dw 101 ; base AGL
    dw 177 ; base INT
    db $b4 ; personality axis $6F
    db $5a ; personality axis $70
    db $6e ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_WINGSLIME ; id 60 WingSlime: picture: monster id
    db SKILL_SQUALLHIT ; skill 1
    db SKILL_TAILWIND ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 239 ; EXP
    db $02 ; join-chance class
    db $10 ; level
    dw 63 ; base HP
    dw 62 ; base MP
    dw 57 ; base ATK
    dw 42 ; base DEF
    dw 178 ; base AGL
    dw 123 ; base INT
    db $c8 ; personality axis $6F
    db $c8 ; personality axis $70
    db $14 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_BULLBIRD ; id 61 BullBird: picture: monster id
    db SKILL_SHEARS ; skill 1
    db SKILL_CHARGEUP ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 410 ; EXP
    db $03 ; join-chance class
    db $10 ; level
    dw 100 ; base HP
    dw 63 ; base MP
    dw 68 ; base ATK
    dw 71 ; base DEF
    dw 125 ; base AGL
    dw 146 ; base INT
    db $32 ; personality axis $6F
    db $32 ; personality axis $70
    db $78 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_CRAGDEVIL ; id 62 CragDevil: picture: monster id
    db SKILL_AQUACUT ; skill 1
    db SKILL_LUREDANCE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 501 ; EXP
    db $03 ; join-chance class
    db $11 ; level
    dw 86 ; base HP
    dw 51 ; base MP
    dw 52 ; base ATK
    dw 56 ; base DEF
    dw 118 ; base AGL
    dw 236 ; base INT
    db $fa ; personality axis $6F
    db $d2 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_STARFISH ; id 63 Starfish: picture: monster id
    db SKILL_POISONHIT ; skill 1
    db SKILL_ODDDANCE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 466 ; EXP
    db $04 ; join-chance class
    db $14 ; level
    dw 80 ; base HP
    dw 78 ; base MP
    dw 79 ; base ATK
    dw 77 ; base DEF
    dw 98 ; base AGL
    dw 236 ; base INT
    db $fa ; personality axis $6F
    db $be ; personality axis $70
    db $14 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_SEAHORSE ; id 64 SeaHorse: picture: monster id
    db SKILL_FRIGIDAIR ; skill 1
    db SKILL_GEYSER ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 401 ; EXP
    db $03 ; join-chance class
    db $10 ; level
    dw 92 ; base HP
    dw 42 ; base MP
    dw 71 ; base ATK
    dw 51 ; base DEF
    dw 102 ; base AGL
    dw 123 ; base INT
    db $f0 ; personality axis $6F
    db $00 ; personality axis $70
    db $00 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_MANEATER ; id 65 ManEater: picture: monster id
    db SKILL_DRAKSLASH ; skill 1
    db SKILL_PSYCHEUP ; skill 2
    db SKILL_SLEEPAIR ; skill 3
    db $ff ; skill 4
    dw 602 ; EXP
    db $04 ; join-chance class
    db $14 ; level
    dw 86 ; base HP
    dw 76 ; base MP
    dw 84 ; base ATK
    dw 52 ; base DEF
    dw 74 ; base AGL
    dw 321 ; base INT
    db $c8 ; personality axis $6F
    db $78 ; personality axis $70
    db $6e ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_STUBBIRD ; id 66 StubBird: picture: monster id
    db SKILL_TWINHITS ; skill 1
    db SKILL_BUGBLOW ; skill 2
    db SKILL_RAINSLASH ; skill 3
    db $ff ; skill 4
    dw 502 ; EXP
    db $03 ; join-chance class
    db $15 ; level
    dw 133 ; base HP
    dw 82 ; base MP
    dw 74 ; base ATK
    dw 61 ; base DEF
    dw 171 ; base AGL
    dw 327 ; base INT
    db $8c ; personality axis $6F
    db $6e ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_GIANTMOTH ; id 67 GiantMoth: picture: monster id
    db SKILL_WINDBEAST ; skill 1
    db SKILL_PARALYZE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 480 ; EXP
    db $03 ; join-chance class
    db $19 ; level
    dw 98 ; base HP
    dw 61 ; base MP
    dw 79 ; base ATK
    dw 80 ; base DEF
    dw 135 ; base AGL
    dw 316 ; base INT
    db $c8 ; personality axis $6F
    db $c8 ; personality axis $70
    db $1e ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_GOATHORN ; id 68 GoatHorn: picture: monster id
    db SKILL_BOOM ; skill 1
    db SKILL_INFERMORE ; skill 2
    db SKILL_SNOWSTORM ; skill 3
    db $ff ; skill 4
    dw 6020 ; EXP
    db $07 ; join-chance class
    db $1b ; level
    dw 850 ; base HP
    dw 89 ; base MP
    dw 95 ; base ATK
    dw 65 ; base DEF
    dw 92 ; base AGL
    dw 165 ; base INT
    db $c8 ; personality axis $6F
    db $8c ; personality axis $70
    db $32 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_FANGSLIME ; id 69 FangSlime: picture: monster id
    db SKILL_CALLHELP ; skill 1
    db SKILL_CHARGEUP ; skill 2
    db SKILL_WARCRY ; skill 3
    db $ff ; skill 4
    dw 867 ; EXP
    db $03 ; join-chance class
    db $14 ; level
    dw 127 ; base HP
    dw 51 ; base MP
    dw 80 ; base ATK
    dw 71 ; base DEF
    dw 149 ; base AGL
    dw 186 ; base INT
    db $d2 ; personality axis $6F
    db $96 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_ROCKSLIME ; id 70 RockSlime: picture: monster id
    db SKILL_HIGHJUMP ; skill 1
    db SKILL_RAMMING ; skill 2
    db SKILL_STRONGD ; skill 3
    db $ff ; skill 4
    dw 2554 ; EXP
    db $04 ; join-chance class
    db $19 ; level
    dw 148 ; base HP
    dw 129 ; base MP
    dw 92 ; base ATK
    dw 101 ; base DEF
    dw 150 ; base AGL
    dw 210 ; base INT
    db $a0 ; personality axis $6F
    db $64 ; personality axis $70
    db $82 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_MADRAVEN ; id 71 MadRaven: picture: monster id
    db SKILL_HIGHJUMP ; skill 1
    db SKILL_STORMWIND ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 1168 ; EXP
    db $03 ; join-chance class
    db $17 ; level
    dw 94 ; base HP
    dw 123 ; base MP
    dw 78 ; base ATK
    dw 89 ; base DEF
    dw 181 ; base AGL
    dw 206 ; base INT
    db $b4 ; personality axis $6F
    db $78 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_EMYU ; id 72 Emyu: picture: monster id
    db SKILL_WINDBEAST ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 888 ; EXP
    db $04 ; join-chance class
    db $16 ; level
    dw 108 ; base HP
    dw 86 ; base MP
    dw 86 ; base ATK
    dw 72 ; base DEF
    dw 165 ; base AGL
    dw 510 ; base INT
    db $b4 ; personality axis $6F
    db $64 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_FLORAMAN ; id 73 FloraMan: picture: monster id
    db SKILL_FIREBANE ; skill 1
    db SKILL_ANTIDOTE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 849 ; EXP
    db $03 ; join-chance class
    db $18 ; level
    dw 94 ; base HP
    dw 160 ; base MP
    dw 75 ; base ATK
    dw 85 ; base DEF
    dw 95 ; base AGL
    dw 362 ; base INT
    db $8c ; personality axis $6F
    db $32 ; personality axis $70
    db $be ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_SLURPERON ; id 74 Slurperon: picture: monster id
    db SKILL_SLEEPALL ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 1096 ; EXP
    db $03 ; join-chance class
    db $18 ; level
    dw 102 ; base HP
    dw 92 ; base MP
    dw 72 ; base ATK
    dw 78 ; base DEF
    dw 110 ; base AGL
    dw 289 ; base INT
    db $a0 ; personality axis $6F
    db $46 ; personality axis $70
    db $46 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_ROBOSTER ; id 75 Roboster: picture: monster id
    db SKILL_SQUALLHIT ; skill 1
    db SKILL_QUADHITS ; skill 2
    db SKILL_RAINSLASH ; skill 3
    db $ff ; skill 4
    dw 3258 ; EXP
    db $04 ; join-chance class
    db $1e ; level
    dw 168 ; base HP
    dw 123 ; base MP
    dw 139 ; base ATK
    dw 146 ; base DEF
    dw 136 ; base AGL
    dw 278 ; base INT
    db $c8 ; personality axis $6F
    db $82 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_MADDRAGON ; id 76 MadDragon: picture: monster id
    db SKILL_MASSACRE ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 2131 ; EXP
    db $04 ; join-chance class
    db $19 ; level
    dw 124 ; base HP
    dw 48 ; base MP
    dw 136 ; base ATK
    dw 107 ; base DEF
    dw 104 ; base AGL
    dw 73 ; base INT
    db $96 ; personality axis $6F
    db $0a ; personality axis $70
    db $14 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_DRAGON ; id 77 Dragon: picture: monster id
    db SKILL_BLAZEAIR ; skill 1
    db SKILL_FIRESLASH ; skill 2
    db SKILL_SUCKALL ; skill 3
    db $ff ; skill 4
    dw 1887 ; EXP
    db $03 ; join-chance class
    db $1c ; level
    dw 154 ; base HP
    dw 84 ; base MP
    dw 143 ; base ATK
    dw 99 ; base DEF
    dw 155 ; base AGL
    dw 366 ; base INT
    db $d2 ; personality axis $6F
    db $78 ; personality axis $70
    db $78 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_IRONTURT ; id 78 IronTurt: picture: monster id
    db SKILL_STRONGD ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 1357 ; EXP
    db $03 ; join-chance class
    db $18 ; level
    dw 110 ; base HP
    dw 87 ; base MP
    dw 102 ; base ATK
    dw 128 ; base DEF
    dw 97 ; base AGL
    dw 269 ; base INT
    db $c8 ; personality axis $6F
    db $8c ; personality axis $70
    db $3c ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_MADMIRROR ; id 79 MadMirror: picture: monster id
    db SKILL_BOUNCE ; skill 1
    db SKILL_TRANSFORM ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 1129 ; EXP
    db $03 ; join-chance class
    db $19 ; level
    dw 156 ; base HP
    dw 89 ; base MP
    dw 84 ; base ATK
    dw 149 ; base DEF
    dw 115 ; base AGL
    dw 366 ; base INT
    db $c8 ; personality axis $6F
    db $d2 ; personality axis $70
    db $0a ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_SABREMAN ; id 80 SabreMan: picture: monster id
    db SKILL_ROBMAGIC ; skill 1
    db SKILL_DEVILCUT ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 944 ; EXP
    db $03 ; join-chance class
    db $15 ; level
    dw 103 ; base HP
    dw 72 ; base MP
    dw 103 ; base ATK
    dw 71 ; base DEF
    dw 115 ; base AGL
    dw 300 ; base INT
    db $fa ; personality axis $6F
    db $d2 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_EVILBEAST ; id 81 EvilBeast: picture: monster id
    db SKILL_FIREBAL ; skill 1
    db SKILL_FRIGIDAIR ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 1249 ; EXP
    db $03 ; join-chance class
    db $17 ; level
    dw 126 ; base HP
    dw 99 ; base MP
    dw 89 ; base ATK
    dw 106 ; base DEF
    dw 119 ; base AGL
    dw 210 ; base INT
    db $3c ; personality axis $6F
    db $64 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_WARMANTIS ; id 82 WarMantis: picture: monster id
    db SKILL_VACUSLASH ; skill 1
    db SKILL_SHEARS ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 900 ; EXP
    db $04 ; join-chance class
    db $1a ; level
    dw 118 ; base HP
    dw 96 ; base MP
    dw 99 ; base ATK
    dw 92 ; base DEF
    dw 119 ; base AGL
    dw 200 ; base INT
    db $5a ; personality axis $6F
    db $50 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_PHOENIX ; id 83 Phoenix: picture: monster id
    db SKILL_BLAZEAIR ; skill 1
    db SKILL_SQUALLHIT ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 1533 ; EXP
    db $05 ; join-chance class
    db $20 ; level
    dw 165 ; base HP
    dw 108 ; base MP
    dw 146 ; base ATK
    dw 87 ; base DEF
    dw 155 ; base AGL
    dw 316 ; base INT
    db $c8 ; personality axis $6F
    db $8c ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_FIREWEED ; id 84 FireWeed: picture: monster id
    db SKILL_BLAZEMORE ; skill 1
    db SKILL_DECHAOS ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 2497 ; EXP
    db $03 ; join-chance class
    db $1b ; level
    dw 162 ; base HP
    dw 222 ; base MP
    dw 130 ; base ATK
    dw 159 ; base DEF
    dw 158 ; base AGL
    dw 215 ; base INT
    db $aa ; personality axis $6F
    db $28 ; personality axis $70
    db $1e ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_WILDAPE ; id 85 WildApe: picture: monster id
    db SKILL_TWINSLASH ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 1341 ; EXP
    db $04 ; join-chance class
    db $19 ; level
    dw 152 ; base HP
    dw 64 ; base MP
    dw 133 ; base ATK
    dw 85 ; base DEF
    dw 92 ; base AGL
    dw 179 ; base INT
    db $8c ; personality axis $6F
    db $3c ; personality axis $70
    db $96 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_DUMBIRA ; id 86 Dumbira: picture: monster id
    db SKILL_METALCUT ; skill 1
    db SKILL_TWINSLASH ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 1478 ; EXP
    db $04 ; join-chance class
    db $17 ; level
    dw 120 ; base HP
    dw 82 ; base MP
    dw 111 ; base ATK
    dw 92 ; base DEF
    dw 156 ; base AGL
    dw 280 ; base INT
    db $c8 ; personality axis $6F
    db $78 ; personality axis $70
    db $46 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_BELZEBUB ; id 87 Belzebub: picture: monster id
    db SKILL_FIREBAL ; skill 1
    db SKILL_YELLHELP ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 2278 ; EXP
    db $04 ; join-chance class
    db $15 ; level
    dw 138 ; base HP
    dw 84 ; base MP
    dw 88 ; base ATK
    dw 84 ; base DEF
    dw 120 ; base AGL
    dw 410 ; base INT
    db $50 ; personality axis $6F
    db $78 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_METALY ; id 88 Metaly: picture: monster id
    db SKILL_BLAZE ; skill 1
    db ACTION_C8 ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 7899 ; EXP
    db $05 ; join-chance class
    db $1c ; level
    dw 22 ; base HP
    dw 334 ; base MP
    dw 93 ; base ATK
    dw 364 ; base DEF
    dw 543 ; base AGL
    dw 253 ; base INT
    db $28 ; personality axis $6F
    db $5a ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_GHOSTREE ; id 89 GhosTree: picture: monster id
    db SKILL_ROBMAGIC ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 1992 ; EXP
    db $04 ; join-chance class
    db $22 ; level
    dw 110 ; base HP
    dw 106 ; base MP
    dw 114 ; base ATK
    dw 97 ; base DEF
    dw 108 ; base AGL
    dw 199 ; base INT
    db $64 ; personality axis $6F
    db $50 ; personality axis $70
    db $5a ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_BABBLE ; id 90 Babble: picture: monster id
    db SKILL_SURROUND ; skill 1
    db SKILL_POISONHIT ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 1804 ; EXP
    db $03 ; join-chance class
    db $1a ; level
    dw 91 ; base HP
    dw 163 ; base MP
    dw 92 ; base ATK
    dw 100 ; base DEF
    dw 166 ; base AGL
    dw 252 ; base INT
    db $fa ; personality axis $6F
    db $50 ; personality axis $70
    db $00 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_LIONEX ; id 91 Lionex: picture: monster id
    db SKILL_INFERMORE ; skill 1
    db SKILL_VACUSLASH ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 2684 ; EXP
    db $04 ; join-chance class
    db $1e ; level
    dw 172 ; base HP
    dw 124 ; base MP
    dw 151 ; base ATK
    dw 100 ; base DEF
    dw 172 ; base AGL
    dw 350 ; base INT
    db $c8 ; personality axis $6F
    db $a0 ; personality axis $70
    db $50 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_MADGOOSE ; id 92 MadGoose: picture: monster id
    db SKILL_HEALMORE ; skill 1
    db SKILL_WINDBEAST ; skill 2
    db SKILL_LUREDANCE ; skill 3
    db $ff ; skill 4
    dw 1509 ; EXP
    db $04 ; join-chance class
    db $1c ; level
    dw 136 ; base HP
    dw 132 ; base MP
    dw 110 ; base ATK
    dw 100 ; base DEF
    dw 188 ; base AGL
    dw 247 ; base INT
    db $78 ; personality axis $6F
    db $50 ; personality axis $70
    db $6e ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_BUBBLEMON ; id 93 Bubblemon: picture: monster id
    db SKILL_WATERSHOT ; skill 1
    db SKILL_BLADED ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 1520 ; EXP
    db $03 ; join-chance class
    db $20 ; level
    dw 193 ; base HP
    dw 119 ; base MP
    dw 108 ; base ATK
    dw 80 ; base DEF
    dw 157 ; base AGL
    dw 137 ; base INT
    db $c8 ; personality axis $6F
    db $00 ; personality axis $70
    db $00 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_GIGANTES ; id 94 Gigantes: picture: monster id
    db SKILL_SLIMEBLOW ; skill 1
    db SKILL_CHARGEUP ; skill 2
    db SKILL_EVILSLASH ; skill 3
    db $ff ; skill 4
    dw 1848 ; EXP
    db $04 ; join-chance class
    db $1e ; level
    dw 289 ; base HP
    dw 67 ; base MP
    dw 166 ; base ATK
    dw 90 ; base DEF
    dw 44 ; base AGL
    dw 74 ; base INT
    db $c8 ; personality axis $6F
    db $14 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_EXAUCERS ; id 95 Exaucers: picture: monster id
    db SKILL_TAKEMAGIC ; skill 1
    db SKILL_WINDBEAST ; skill 2
    db SKILL_PANIDANCE ; skill 3
    db $ff ; skill 4
    dw 2351 ; EXP
    db $04 ; join-chance class
    db $25 ; level
    dw 167 ; base HP
    dw 159 ; base MP
    dw 148 ; base ATK
    dw 135 ; base DEF
    dw 108 ; base AGL
    dw 366 ; base INT
    db $96 ; personality axis $6F
    db $28 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_DEADNITE ; id 96 DeadNite: picture: monster id
    db SKILL_HEALMORE ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 2199 ; EXP
    db $04 ; join-chance class
    db $21 ; level
    dw 170 ; base HP
    dw 145 ; base MP
    dw 145 ; base ATK
    dw 92 ; base DEF
    dw 156 ; base AGL
    dw 219 ; base INT
    db $be ; personality axis $6F
    db $28 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_GATEGUARD ; id 97 GateGuard: picture: monster id
    db SKILL_BLAZEMORE ; skill 1
    db SKILL_CLEANCUT ; skill 2
    db SKILL_THICKFOG ; skill 3
    db $ff ; skill 4
    dw 2217 ; EXP
    db $04 ; join-chance class
    db $23 ; level
    dw 185 ; base HP
    dw 110 ; base MP
    dw 142 ; base ATK
    dw 117 ; base DEF
    dw 109 ; base AGL
    dw 378 ; base INT
    db $c8 ; personality axis $6F
    db $14 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_MADSPIRIT ; id 98 MadSpirit: picture: monster id
    db SKILL_THICKFOG ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 2219 ; EXP
    db $04 ; join-chance class
    db $20 ; level
    dw 129 ; base HP
    dw 114 ; base MP
    dw 129 ; base ATK
    dw 110 ; base DEF
    dw 206 ; base AGL
    dw 499 ; base INT
    db $a0 ; personality axis $6F
    db $78 ; personality axis $70
    db $50 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_COPYCAT ; id 99 Copycat: picture: monster id
    db SKILL_TRANSFORM ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 2245 ; EXP
    db $05 ; join-chance class
    db $21 ; level
    dw 92 ; base HP
    dw 219 ; base MP
    dw 119 ; base ATK
    dw 153 ; base DEF
    dw 224 ; base AGL
    dw 249 ; base INT
    db $14 ; personality axis $6F
    db $1e ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_NITERICH ; id 100 Niterich: picture: monster id
    db SKILL_HEALMORE ; skill 1
    db SKILL_ICESTORM ; skill 2
    db SKILL_DIAGOCALL ; skill 3
    db $ff ; skill 4
    dw 19620 ; EXP
    db $07 ; join-chance class
    db $24 ; level
    dw 1500 ; base HP
    dw 106 ; base MP
    dw 177 ; base ATK
    dw 149 ; base DEF
    dw 110 ; base AGL
    dw 510 ; base INT
    db $8c ; personality axis $6F
    db $a0 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_ANDREAL ; id 101 Andreal: picture: monster id
    db SKILL_INFERMOST ; skill 1
    db SKILL_SURROUND ; skill 2
    db SKILL_POISONAIR ; skill 3
    db $ff ; skill 4
    dw 3347 ; EXP
    db $05 ; join-chance class
    db $25 ; level
    dw 267 ; base HP
    dw 234 ; base MP
    dw 174 ; base ATK
    dw 144 ; base DEF
    dw 165 ; base AGL
    dw 546 ; base INT
    db $c8 ; personality axis $6F
    db $0a ; personality axis $70
    db $8c ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_MADKNIGHT ; id 102 MadKnight: picture: monster id
    db SKILL_BEASTCUT ; skill 1
    db SKILL_MASSACRE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 1026 ; EXP
    db $05 ; join-chance class
    db $13 ; level
    dw 114 ; base HP
    dw 118 ; base MP
    dw 119 ; base ATK
    dw 128 ; base DEF
    dw 91 ; base AGL
    dw 209 ; base INT
    db $3c ; personality axis $6F
    db $78 ; personality axis $70
    db $d2 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_SKYDRAGON ; id 103 SkyDragon: picture: monster id
    db SKILL_BLAZEAIR ; skill 1
    db SKILL_SUCKAIR ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 3274 ; EXP
    db $05 ; join-chance class
    db $22 ; level
    dw 210 ; base HP
    dw 194 ; base MP
    dw 160 ; base ATK
    dw 119 ; base DEF
    dw 116 ; base AGL
    dw 169 ; base INT
    db $fa ; personality axis $6F
    db $78 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_COILBIRD ; id 104 CoilBird: picture: monster id
    db SKILL_DECHAOS ; skill 1
    db SKILL_NUMBOFF ; skill 2
    db SKILL_SUCKALL ; skill 3
    db $ff ; skill 4
    dw 2860 ; EXP
    db $04 ; join-chance class
    db $23 ; level
    dw 128 ; base HP
    dw 108 ; base MP
    dw 113 ; base ATK
    dw 99 ; base DEF
    dw 165 ; base AGL
    dw 213 ; base INT
    db $5a ; personality axis $6F
    db $50 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_ARMORPEDE ; id 105 ArmorPede: picture: monster id
    db SKILL_INCREASE ; skill 1
    db SKILL_TWINHITS ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 3488 ; EXP
    db $04 ; join-chance class
    db $20 ; level
    dw 150 ; base HP
    dw 137 ; base MP
    dw 119 ; base ATK
    dw 200 ; base DEF
    dw 129 ; base AGL
    dw 266 ; base INT
    db $8c ; personality axis $6F
    db $5a ; personality axis $70
    db $5a ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_MADHORNET ; id 106 MadHornet: picture: monster id
    db SKILL_POISONHIT ; skill 1
    db SKILL_TAILWIND ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 3399 ; EXP
    db $04 ; join-chance class
    db $22 ; level
    dw 202 ; base HP
    dw 108 ; base MP
    dw 132 ; base ATK
    dw 117 ; base DEF
    dw 282 ; base AGL
    dw 288 ; base INT
    db $be ; personality axis $6F
    db $5a ; personality axis $70
    db $46 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_MUDOU ; id 107 Mudou: picture: monster id
    db SKILL_SCORCHING ; skill 1
    db SKILL_ICESTORM ; skill 2
    db SKILL_POISONHIT ; skill 3
    db SKILL_DEMAGIC ; skill 4
    dw 38542 ; EXP
    db $07 ; join-chance class
    db $26 ; level
    dw 3000 ; base HP
    dw 413 ; base MP
    dw 225 ; base ATK
    dw 160 ; base DEF
    dw 156 ; base AGL
    dw 150 ; base INT
    db $b4 ; personality axis $6F
    db $50 ; personality axis $70
    db $dc ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_EVILARMOR ; id 108 EvilArmor: picture: monster id
    db SKILL_FIRESLASH ; skill 1
    db SKILL_BOLTSLASH ; skill 2
    db SKILL_AQUACUT ; skill 3
    db $ff ; skill 4
    dw 9800 ; EXP
    db $07 ; join-chance class
    db $26 ; level
    dw 450 ; base HP
    dw 140 ; base MP
    dw 185 ; base ATK
    dw 150 ; base DEF
    dw 138 ; base AGL
    dw 280 ; base INT
    db $c8 ; personality axis $6F
    db $c8 ; personality axis $70
    db $1e ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_SKELETOR ; id 109 Skeletor: picture: monster id
    db SKILL_DEFENSE ; skill 1
    db SKILL_BIATTACK ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 7900 ; EXP
    db $07 ; join-chance class
    db $25 ; level
    dw 226 ; base HP
    dw 108 ; base MP
    dw 160 ; base ATK
    dw 148 ; base DEF
    dw 140 ; base AGL
    dw 140 ; base INT
    db $64 ; personality axis $6F
    db $64 ; personality axis $70
    db $3c ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_VAMPIRUS ; id 110 Vampirus: picture: monster id
    db SKILL_INFERMORE ; skill 1
    db SKILL_CALLHELP ; skill 2
    db SKILL_BIATTACK ; skill 3
    db $ff ; skill 4
    dw 3149 ; EXP
    db $05 ; join-chance class
    db $20 ; level
    dw 149 ; base HP
    dw 79 ; base MP
    dw 122 ; base ATK
    dw 108 ; base DEF
    dw 140 ; base AGL
    dw 216 ; base INT
    db $5a ; personality axis $6F
    db $96 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_FLORAJAY ; id 111 Florajay: picture: monster id
    db SKILL_SPEEDUP ; skill 1
    db SKILL_BEASTCUT ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 3020 ; EXP
    db $04 ; join-chance class
    db $24 ; level
    dw 134 ; base HP
    dw 149 ; base MP
    dw 122 ; base ATK
    dw 132 ; base DEF
    dw 169 ; base AGL
    dw 186 ; base INT
    db $78 ; personality axis $6F
    db $28 ; personality axis $70
    db $5a ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_BOSSTROLL ; id 112 BossTroll: picture: monster id
    db SKILL_MASSACRE ; skill 1
    db SKILL_RAMMING ; skill 2
    db SKILL_COVER ; skill 3
    db $ff ; skill 4
    dw 6984 ; EXP
    db $05 ; join-chance class
    db $29 ; level
    dw 314 ; base HP
    dw 187 ; base MP
    dw 220 ; base ATK
    dw 149 ; base DEF
    dw 89 ; base AGL
    dw 179 ; base INT
    db $c8 ; personality axis $6F
    db $00 ; personality axis $70
    db $00 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_CHOPCLOWN ; id 113 ChopClown: picture: monster id
    db SKILL_TWINHITS ; skill 1
    db SKILL_VACUSLASH ; skill 2
    db SKILL_SQUALLHIT ; skill 3
    db $ff ; skill 4
    dw 6477 ; EXP
    db $05 ; join-chance class
    db $28 ; level
    dw 203 ; base HP
    dw 230 ; base MP
    dw 205 ; base ATK
    dw 184 ; base DEF
    dw 319 ; base AGL
    dw 849 ; base INT
    db $dc ; personality axis $6F
    db $28 ; personality axis $70
    db $78 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_MISTYWING ; id 114 MistyWing: picture: monster id
    db SKILL_BARRIER ; skill 1
    db SKILL_EERIELITE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 5998 ; EXP
    db $05 ; join-chance class
    db $29 ; level
    dw 230 ; base HP
    dw 171 ; base MP
    dw 176 ; base ATK
    dw 225 ; base DEF
    dw 251 ; base AGL
    dw 392 ; base INT
    db $8c ; personality axis $6F
    db $82 ; personality axis $70
    db $46 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_CENTASAUR ; id 115 Centasaur: picture: monster id
    db SKILL_STOPSPELL ; skill 1
    db SKILL_FIRESLASH ; skill 2
    db SKILL_RAINSLASH ; skill 3
    db $ff ; skill 4
    dw 19000 ; EXP
    db $07 ; join-chance class
    db $28 ; level
    dw 900 ; base HP
    dw 83 ; base MP
    dw 220 ; base ATK
    dw 150 ; base DEF
    dw 250 ; base AGL
    dw 250 ; base INT
    db $c8 ; personality axis $6F
    db $50 ; personality axis $70
    db $6e ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_GIGADRACO ; id 116 GigaDraco: picture: monster id
    db SKILL_WHITEFIRE ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 21000 ; EXP
    db $07 ; join-chance class
    db $2a ; level
    dw 1000 ; base HP
    dw 245 ; base MP
    dw 277 ; base ATK
    dw 180 ; base DEF
    dw 120 ; base AGL
    dw 100 ; base INT
    db $78 ; personality axis $6F
    db $64 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_GARUDIAN ; id 117 Garudian: picture: monster id
    db SKILL_INFERMORE ; skill 1
    db SKILL_WINDBEAST ; skill 2
    db SKILL_AQUACUT ; skill 3
    db $ff ; skill 4
    dw 16200 ; EXP
    db $07 ; join-chance class
    db $29 ; level
    dw 800 ; base HP
    dw 88 ; base MP
    dw 206 ; base ATK
    dw 160 ; base DEF
    dw 251 ; base AGL
    dw 320 ; base INT
    db $a0 ; personality axis $6F
    db $8c ; personality axis $70
    db $96 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_MIMIC ; id 118 Mimic: picture: monster id
    db SKILL_EAGLEEYE ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 12 ; EXP
    db $04 ; join-chance class
    db $01 ; level
    dw 25 ; base HP
    dw 15 ; base MP
    dw 15 ; base ATK
    dw 8 ; base DEF
    dw 10 ; base AGL
    dw 50 ; base INT
    db $96 ; personality axis $6F
    db $28 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $32 ; personality axis $72
    dw MONSTER_MIMIC ; id 119 Mimic: picture: monster id
    db SKILL_BLAZE ; skill 1
    db SKILL_EAGLEEYE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 45 ; EXP
    db $04 ; join-chance class
    db $05 ; level
    dw 39 ; base HP
    dw 24 ; base MP
    dw 43 ; base ATK
    dw 27 ; base DEF
    dw 22 ; base AGL
    dw 144 ; base INT
    db $96 ; personality axis $6F
    db $28 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $32 ; personality axis $72
    dw MONSTER_MIMIC ; id 120 Mimic: picture: monster id
    db SKILL_BLAZE ; skill 1
    db SKILL_BEAT ; skill 2
    db SKILL_EAGLEEYE ; skill 3
    db $ff ; skill 4
    dw 120 ; EXP
    db $04 ; join-chance class
    db $0a ; level
    dw 62 ; base HP
    dw 35 ; base MP
    dw 77 ; base ATK
    dw 37 ; base DEF
    dw 44 ; base AGL
    dw 290 ; base INT
    db $96 ; personality axis $6F
    db $28 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $32 ; personality axis $72
    dw MONSTER_MIMIC ; id 121 Mimic: picture: monster id
    db SKILL_BLAZEMORE ; skill 1
    db SKILL_BEAT ; skill 2
    db SKILL_EAGLEEYE ; skill 3
    db $ff ; skill 4
    dw 360 ; EXP
    db $04 ; join-chance class
    db $0f ; level
    dw 81 ; base HP
    dw 42 ; base MP
    dw 110 ; base ATK
    dw 47 ; base DEF
    dw 64 ; base AGL
    dw 400 ; base INT
    db $96 ; personality axis $6F
    db $28 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $32 ; personality axis $72
    dw MONSTER_MIMIC ; id 122 Mimic: picture: monster id
    db SKILL_BLAZEMORE ; skill 1
    db SKILL_BEAT ; skill 2
    db SKILL_EAGLEEYE ; skill 3
    db $ff ; skill 4
    dw 660 ; EXP
    db $04 ; join-chance class
    db $14 ; level
    dw 129 ; base HP
    dw 53 ; base MP
    dw 132 ; base ATK
    dw 71 ; base DEF
    dw 86 ; base AGL
    dw 473 ; base INT
    db $96 ; personality axis $6F
    db $28 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $32 ; personality axis $72
    dw MONSTER_MIMIC ; id 123 Mimic: picture: monster id
    db SKILL_BLAZEMOST ; skill 1
    db SKILL_BEAT ; skill 2
    db SKILL_EAGLEEYE ; skill 3
    db $ff ; skill 4
    dw 1350 ; EXP
    db $04 ; join-chance class
    db $19 ; level
    dw 151 ; base HP
    dw 62 ; base MP
    dw 154 ; base ATK
    dw 108 ; base DEF
    dw 124 ; base AGL
    dw 557 ; base INT
    db $96 ; personality axis $6F
    db $28 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $32 ; personality axis $72
    dw MONSTER_MIMIC ; id 124 Mimic: picture: monster id
    db SKILL_BLAZEMOST ; skill 1
    db SKILL_BEAT ; skill 2
    db SKILL_EAGLEEYE ; skill 3
    db $ff ; skill 4
    dw 3375 ; EXP
    db $04 ; join-chance class
    db $1e ; level
    dw 284 ; base HP
    dw 146 ; base MP
    dw 175 ; base ATK
    dw 145 ; base DEF
    dw 146 ; base AGL
    dw 752 ; base INT
    db $96 ; personality axis $6F
    db $28 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $32 ; personality axis $72
    dw MONSTER_MIMIC ; id 125 Mimic: picture: monster id
    db SKILL_BLAZEMOST ; skill 1
    db SKILL_BEAT ; skill 2
    db SKILL_EAGLEEYE ; skill 3
    db $ff ; skill 4
    dw 6645 ; EXP
    db $04 ; join-chance class
    db $23 ; level
    dw 318 ; base HP
    dw 166 ; base MP
    dw 202 ; base ATK
    dw 184 ; base DEF
    dw 168 ; base AGL
    dw 903 ; base INT
    db $96 ; personality axis $6F
    db $28 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $32 ; personality axis $72
    dw MONSTER_TATSU ; id 126 Tatsu: picture: monster id
    db SKILL_HEALMORE ; skill 1
    db SKILL_LIGHTNING ; skill 2
    db SKILL_COVER ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $1e ; level
    dw 200 ; base HP
    dw 100 ; base MP
    dw 180 ; base ATK
    dw 150 ; base DEF
    dw 115 ; base AGL
    dw 588 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_DIAGO ; id 127 Diago: picture: monster id
    db SKILL_TWINHITS ; skill 1
    db SKILL_SCORCHING ; skill 2
    db SKILL_SICKLICK ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $28 ; level
    dw 300 ; base HP
    dw 200 ; base MP
    dw 210 ; base ATK
    dw 160 ; base DEF
    dw 172 ; base AGL
    dw 392 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_SAMSI ; id 128 Samsi: picture: monster id
    db SKILL_SQUALLHIT ; skill 1
    db SKILL_RAINSLASH ; skill 2
    db SKILL_EVILSLASH ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $32 ; level
    dw 450 ; base HP
    dw 200 ; base MP
    dw 250 ; base ATK
    dw 190 ; base DEF
    dw 215 ; base AGL
    dw 784 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_BAZOO ; id 129 Bazoo: picture: monster id
    db SKILL_HELLBLAST ; skill 1
    db SKILL_ICESTORM ; skill 2
    db SKILL_DEMAGIC ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $3c ; level
    dw 700 ; base HP
    dw 400 ; base MP
    dw 350 ; base ATK
    dw 300 ; base DEF
    dw 143 ; base AGL
    dw 940 ; base INT
    db $fa ; personality axis $6F
    db $fa ; personality axis $70
    db $fa ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_179 ; id 130 ?: picture: monster id
    db SKILL_SCORCHING ; skill 1
    db SKILL_ICESTORM ; skill 2
    db SKILL_DEMAGIC ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $32 ; level
    dw 999 ; base HP
    dw 300 ; base MP
    dw 300 ; base ATK
    dw 200 ; base DEF
    dw 286 ; base AGL
    dw 784 ; base INT
    db $fa ; personality axis $6F
    db $00 ; personality axis $70
    db $00 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_BABBLE ; id 131 Babble: picture: monster id
    db SKILL_BLAZE ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $06 ; level
    dw 36 ; base HP
    dw 9 ; base MP
    dw 14 ; base ATK
    dw 13 ; base DEF
    dw 32 ; base AGL
    dw 123 ; base INT
    db $aa ; personality axis $6F
    db $50 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_PEARLGEL ; id 132 PearlGel: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $05 ; level
    dw 15 ; base HP
    dw 12 ; base MP
    dw 17 ; base ATK
    dw 35 ; base DEF
    dw 51 ; base AGL
    dw 96 ; base INT
    db $b4 ; personality axis $6F
    db $64 ; personality axis $70
    db $32 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_SPIKYBOY ; id 133 SpikyBoy: picture: monster id
    db SKILL_SLIMEBLOW ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $06 ; level
    dw 19 ; base HP
    dw 42 ; base MP
    dw 17 ; base ATK
    dw 31 ; base DEF
    dw 34 ; base AGL
    dw 96 ; base INT
    db $b4 ; personality axis $6F
    db $0a ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_PIXY ; id 134 Pixy: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $07 ; level
    dw 29 ; base HP
    dw 24 ; base MP
    dw 20 ; base ATK
    dw 14 ; base DEF
    dw 54 ; base AGL
    dw 79 ; base INT
    db $3c ; personality axis $6F
    db $d2 ; personality axis $70
    db $6e ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_DRACKY ; id 135 Dracky: picture: monster id
    db SKILL_VACUSLASH ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $07 ; level
    dw 40 ; base HP
    dw 22 ; base MP
    dw 14 ; base ATK
    dw 12 ; base DEF
    dw 70 ; base AGL
    dw 96 ; base INT
    db $96 ; personality axis $6F
    db $8c ; personality axis $70
    db $a0 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_MADRAVEN ; id 136 MadRaven: picture: monster id
    db SKILL_HIGHJUMP ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $09 ; level
    dw 41 ; base HP
    dw 55 ; base MP
    dw 16 ; base ATK
    dw 30 ; base DEF
    dw 84 ; base AGL
    dw 163 ; base INT
    db $b4 ; personality axis $6F
    db $8c ; personality axis $70
    db $78 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_KITEHAWK ; id 137 KiteHawk: picture: monster id
    db SKILL_CHARGEUP ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $09 ; level
    dw 46 ; base HP
    dw 35 ; base MP
    dw 26 ; base ATK
    dw 21 ; base DEF
    dw 42 ; base AGL
    dw 146 ; base INT
    db $c8 ; personality axis $6F
    db $64 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_WINDBEAST ; id 138 WindBeast: picture: monster id
    db SKILL_VACUSLASH ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $0e ; level
    dw 51 ; base HP
    dw 62 ; base MP
    dw 41 ; base ATK
    dw 52 ; base DEF
    dw 82 ; base AGL
    dw 180 ; base INT
    db $c8 ; personality axis $6F
    db $28 ; personality axis $70
    db $d2 ; byte 24 ($71)
    db $78 ; personality axis $72
    dw MONSTER_GISMO ; id 139 Gismo: picture: monster id
    db SKILL_FRIGIDAIR ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $0b ; level
    dw 48 ; base HP
    dw 72 ; base MP
    dw 51 ; base ATK
    dw 71 ; base DEF
    dw 171 ; base AGL
    dw 256 ; base INT
    db $c8 ; personality axis $6F
    db $00 ; personality axis $70
    db $5a ; byte 24 ($71)
    db $78 ; personality axis $72
    dw MONSTER_POMPOMBOM ; id 140 PomPomBom: picture: monster id
    db SKILL_FIREAIR ; skill 1
    db SKILL_TAILWIND ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $0d ; level
    dw 62 ; base HP
    dw 67 ; base MP
    dw 72 ; base ATK
    dw 48 ; base DEF
    dw 164 ; base AGL
    dw 150 ; base INT
    db $32 ; personality axis $6F
    db $1e ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $78 ; personality axis $72
    dw MONSTER_DEVIPINE ; id 141 Devipine: picture: monster id
    db SKILL_NAPATTACK ; skill 1
    db SKILL_POISONGAS ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $0d ; level
    dw 60 ; base HP
    dw 37 ; base MP
    dw 64 ; base ATK
    dw 45 ; base DEF
    dw 95 ; base AGL
    dw 366 ; base INT
    db $78 ; personality axis $6F
    db $14 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $78 ; personality axis $72
    dw MONSTER_GULPPLE ; id 142 Gulpple: picture: monster id
    db SKILL_SLOW ; skill 1
    db SKILL_HIGHJUMP ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $0e ; level
    dw 66 ; base HP
    dw 71 ; base MP
    dw 57 ; base ATK
    dw 89 ; base DEF
    dw 88 ; base AGL
    dw 232 ; base INT
    db $96 ; personality axis $6F
    db $32 ; personality axis $70
    db $50 ; byte 24 ($71)
    db $78 ; personality axis $72
    dw MONSTER_EGGPLATON ; id 143 Eggplaton: picture: monster id
    db SKILL_SLEEPAIR ; skill 1
    db SKILL_RADIANT ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $0e ; level
    dw 67 ; base HP
    dw 77 ; base MP
    dw 65 ; base ATK
    dw 42 ; base DEF
    dw 95 ; base AGL
    dw 223 ; base INT
    db $aa ; personality axis $6F
    db $8c ; personality axis $70
    db $28 ; byte 24 ($71)
    db $78 ; personality axis $72
    dw MONSTER_HAMMERMAN ; id 144 HammerMan: picture: monster id
    db SKILL_CHARGEUP ; skill 1
    db SKILL_EVILSLASH ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $10 ; level
    dw 70 ; base HP
    dw 16 ; base MP
    dw 73 ; base ATK
    dw 60 ; base DEF
    dw 64 ; base AGL
    dw 149 ; base INT
    db $8c ; personality axis $6F
    db $78 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $78 ; personality axis $72
    dw MONSTER_STUBSUCK ; id 145 Stubsuck: picture: monster id
    db SKILL_SLEEPALL ; skill 1
    db SKILL_ZOMBIECUT ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $11 ; level
    dw 100 ; base HP
    dw 50 ; base MP
    dw 60 ; base ATK
    dw 65 ; base DEF
    dw 78 ; base AGL
    dw 261 ; base INT
    db $fa ; personality axis $6F
    db $aa ; personality axis $70
    db $00 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_TREEBOY ; id 146 TreeBoy: picture: monster id
    db SKILL_SNOWSTORM ; skill 1
    db SKILL_MAGICBACK ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $1b ; level
    dw 185 ; base HP
    dw 200 ; base MP
    dw 73 ; base ATK
    dw 95 ; base DEF
    dw 130 ; base AGL
    dw 318 ; base INT
    db $46 ; personality axis $6F
    db $96 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_FOOHERO ; id 147 FooHero: picture: monster id
    db SKILL_BLAZEMORE ; skill 1
    db SKILL_HEALMORE ; skill 2
    db SKILL_WINDBEAST ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $19 ; level
    dw 152 ; base HP
    dw 138 ; base MP
    dw 82 ; base ATK
    dw 100 ; base DEF
    dw 80 ; base AGL
    dw 310 ; base INT
    db $0a ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_MOMMONJA ; id 148 Mommonja: picture: monster id
    db SKILL_LUREDANCE ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $1a ; level
    dw 140 ; base HP
    dw 63 ; base MP
    dw 102 ; base ATK
    dw 83 ; base DEF
    dw 283 ; base AGL
    dw 367 ; base INT
    db $fa ; personality axis $6F
    db $78 ; personality axis $70
    db $50 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_DRYGON ; id 149 Drygon: picture: monster id
    db SKILL_WATERSHOT ; skill 1
    db SKILL_PSYCHEUP ; skill 2
    db SKILL_WARCRY ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $21 ; level
    dw 151 ; base HP
    dw 99 ; base MP
    dw 124 ; base ATK
    dw 104 ; base DEF
    dw 106 ; base AGL
    dw 347 ; base INT
    db $c8 ; personality axis $6F
    db $96 ; personality axis $70
    db $5a ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_HERBMAN ; id 150 HerbMan: picture: monster id
    db SKILL_BOOM ; skill 1
    db SKILL_DANCESHUT ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $24 ; level
    dw 201 ; base HP
    dw 149 ; base MP
    dw 110 ; base ATK
    dw 116 ; base DEF
    dw 123 ; base AGL
    dw 435 ; base INT
    db $c8 ; personality axis $6F
    db $1e ; personality axis $70
    db $d2 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_DANCEVEGI ; id 151 DanceVegi: picture: monster id
    db SKILL_BERSERKER ; skill 1
    db SKILL_SIDESTEP ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $23 ; level
    dw 145 ; base HP
    dw 132 ; base MP
    dw 105 ; base ATK
    dw 105 ; base DEF
    dw 189 ; base AGL
    dw 397 ; base INT
    db $b4 ; personality axis $6F
    db $64 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_MUDDOLL ; id 152 MudDoll: picture: monster id
    db SKILL_HUSTLE ; skill 1
    db SKILL_SANDSTORM ; skill 2
    db SKILL_BIGTRIP ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $23 ; level
    dw 210 ; base HP
    dw 28 ; base MP
    dw 108 ; base ATK
    dw 82 ; base DEF
    dw 105 ; base AGL
    dw 730 ; base INT
    db $fa ; personality axis $6F
    db $28 ; personality axis $70
    db $82 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_SHADOW ; id 153 Shadow: picture: monster id
    db SKILL_STOPSPELL ; skill 1
    db SKILL_ICEAIR ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $2a ; level
    dw 238 ; base HP
    dw 224 ; base MP
    dw 214 ; base ATK
    dw 193 ; base DEF
    dw 207 ; base AGL
    dw 850 ; base INT
    db $28 ; personality axis $6F
    db $c8 ; personality axis $70
    db $d2 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_MADCONDOR ; id 154 MadCondor: picture: monster id
    db SKILL_SURROUND ; skill 1
    db SKILL_WINDBEAST ; skill 2
    db SKILL_DIAGOCALL ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $1e ; level
    dw 183 ; base HP
    dw 40 ; base MP
    dw 195 ; base ATK
    dw 180 ; base DEF
    dw 233 ; base AGL
    dw 524 ; base INT
    db $78 ; personality axis $6F
    db $5a ; personality axis $70
    db $46 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_CLOUDKING ; id 155 CloudKing: picture: monster id
    db SKILL_SNOWSTORM ; skill 1
    db SKILL_MAGICWALL ; skill 2
    db SKILL_EERIELITE ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $27 ; level
    dw 225 ; base HP
    dw 178 ; base MP
    dw 218 ; base ATK
    dw 190 ; base DEF
    dw 247 ; base AGL
    dw 736 ; base INT
    db $b4 ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_OCTOREACH ; id 156 Octoreach: picture: monster id
    db SKILL_FIREBANE ; skill 1
    db SKILL_PANIDANCE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $25 ; level
    dw 210 ; base HP
    dw 287 ; base MP
    dw 132 ; base ATK
    dw 130 ; base DEF
    dw 177 ; base AGL
    dw 530 ; base INT
    db $fa ; personality axis $6F
    db $3c ; personality axis $70
    db $28 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_OCTOGON ; id 157 Octogon: picture: monster id
    db SKILL_QUADHITS ; skill 1
    db SKILL_MASSACRE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $25 ; level
    dw 280 ; base HP
    dw 204 ; base MP
    dw 169 ; base ATK
    dw 120 ; base DEF
    dw 125 ; base AGL
    dw 706 ; base INT
    db $fa ; personality axis $6F
    db $c8 ; personality axis $70
    db $1e ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_KINGSQUID ; id 158 KingSquid: picture: monster id
    db SKILL_VIVIFY ; skill 1
    db SKILL_RAINSLASH ; skill 2
    db SKILL_PSYCHEUP ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $2b ; level
    dw 260 ; base HP
    dw 35 ; base MP
    dw 210 ; base ATK
    dw 160 ; base DEF
    dw 99 ; base AGL
    dw 978 ; base INT
    db $fa ; personality axis $6F
    db $28 ; personality axis $70
    db $aa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_MISTYWING ; id 159 MistyWing: picture: monster id
    db SKILL_SNOWSTORM ; skill 1
    db SKILL_SURROUND ; skill 2
    db SKILL_BARRIER ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $2d ; level
    dw 269 ; base HP
    dw 201 ; base MP
    dw 166 ; base ATK
    dw 155 ; base DEF
    dw 292 ; base AGL
    dw 453 ; base INT
    db $1e ; personality axis $6F
    db $6e ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_COPYCAT ; id 160 Copycat: picture: monster id
    db SKILL_TRANSFORM ; skill 1
    db SKILL_ODDDANCE ; skill 2
    db SKILL_IMITATE ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $2d ; level
    dw 210 ; base HP
    dw 244 ; base MP
    dw 144 ; base ATK
    dw 150 ; base DEF
    dw 133 ; base AGL
    dw 430 ; base INT
    db $14 ; personality axis $6F
    db $8c ; personality axis $70
    db $1e ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_NITEWHIP ; id 161 NiteWhip: picture: monster id
    db SKILL_DEFENSE ; skill 1
    db SKILL_WINDBEAST ; skill 2
    db SKILL_LIGHTNING ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $2d ; level
    dw 330 ; base HP
    dw 149 ; base MP
    dw 182 ; base ATK
    dw 180 ; base DEF
    dw 149 ; base AGL
    dw 830 ; base INT
    db $b4 ; personality axis $6F
    db $0a ; personality axis $70
    db $14 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_GOOPI ; id 162 Goopi: picture: monster id
    db SKILL_BLAZEMORE ; skill 1
    db SKILL_CALLHELP ; skill 2
    db SKILL_MOUTHSHUT ; skill 3
    db SKILL_DODGE ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $14 ; level
    dw 250 ; base HP
    dw 25 ; base MP
    dw 245 ; base ATK
    dw 195 ; base DEF
    dw 135 ; base AGL
    dw 520 ; base INT
    db $1e ; personality axis $6F
    db $6e ; personality axis $70
    db $d2 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_SERVANT ; id 163 Servant: picture: monster id
    db SKILL_BLAZEMORE ; skill 1
    db SKILL_SNOWSTORM ; skill 2
    db SKILL_FOCUS ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $31 ; level
    dw 296 ; base HP
    dw 347 ; base MP
    dw 308 ; base ATK
    dw 248 ; base DEF
    dw 420 ; base AGL
    dw 863 ; base INT
    db $c8 ; personality axis $6F
    db $8c ; personality axis $70
    db $6e ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_ARMYCRAB ; id 164 ArmyCrab: picture: monster id
    db SKILL_INCREASE ; skill 1
    db SKILL_CALLHELP ; skill 2
    db SKILL_METALCUT ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $1e ; level
    dw 210 ; base HP
    dw 4 ; base MP
    dw 290 ; base ATK
    dw 270 ; base DEF
    dw 115 ; base AGL
    dw 337 ; base INT
    db $b4 ; personality axis $6F
    db $c8 ; personality axis $70
    db $46 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_DARKCRAB ; id 165 DarkCrab: picture: monster id
    db SKILL_MAGICWALL ; skill 1
    db SKILL_RAMMING ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $32 ; level
    dw 250 ; base HP
    dw 15 ; base MP
    dw 330 ; base ATK
    dw 280 ; base DEF
    dw 142 ; base AGL
    dw 683 ; base INT
    db $14 ; personality axis $6F
    db $c8 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_OROCHI ; id 166 Orochi: picture: monster id
    db SKILL_SCORCHING ; skill 1
    db SKILL_FIRESLASH ; skill 2
    db SKILL_QUADHITS ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $32 ; level
    dw 381 ; base HP
    dw 151 ; base MP
    dw 271 ; base ATK
    dw 267 ; base DEF
    dw 293 ; base AGL
    dw 570 ; base INT
    db $8c ; personality axis $6F
    db $96 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_SERPENTIA ; id 167 Serpentia: picture: monster id
    db SKILL_SLIMEBLOW ; skill 1
    db SKILL_DEVILCUT ; skill 2
    db SKILL_RAINSLASH ; skill 3
    db SKILL_EVILSLASH ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $32 ; level
    dw 296 ; base HP
    dw 121 ; base MP
    dw 301 ; base ATK
    dw 255 ; base DEF
    dw 469 ; base AGL
    dw 580 ; base INT
    db $aa ; personality axis $6F
    db $c8 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_GIGADRACO ; id 168 GigaDraco: picture: monster id
    db SKILL_EXPLODET ; skill 1
    db SKILL_CHARGEUP ; skill 2
    db SKILL_WARCRY ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $32 ; level
    dw 341 ; base HP
    dw 277 ; base MP
    dw 321 ; base ATK
    dw 201 ; base DEF
    dw 430 ; base AGL
    dw 588 ; base INT
    db $c8 ; personality axis $6F
    db $0a ; personality axis $70
    db $d2 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_KINGLEO ; id 169 KingLeo: picture: monster id
    db SKILL_FIREBOLT ; skill 1
    db SKILL_HEALMORE ; skill 2
    db SKILL_ICESTORM ; skill 3
    db SKILL_QUADHITS ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $3c ; level
    dw 612 ; base HP
    dw 285 ; base MP
    dw 462 ; base ATK
    dw 379 ; base DEF
    dw 454 ; base AGL
    dw 950 ; base INT
    db $c8 ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_AZURILE ; id 170 Azurile: picture: monster id
    db SKILL_MULTICUT ; skill 1
    db $ff ; skill 2
    db SKILL_MEDITATE ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $3c ; level
    dw 1274 ; base HP
    dw 462 ; base MP
    dw 462 ; base ATK
    dw 384 ; base DEF
    dw 660 ; base AGL
    dw 964 ; base INT
    db $b4 ; personality axis $6F
    db $c8 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_DIVINEGON ; id 171 Divinegon: picture: monster id
    db SKILL_SCORCHING ; skill 1
    db SKILL_PALSYAIR ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $3c ; level
    dw 1034 ; base HP
    dw 467 ; base MP
    dw 552 ; base ATK
    dw 462 ; base DEF
    dw 437 ; base AGL
    dw 978 ; base INT
    db $d2 ; personality axis $6F
    db $aa ; personality axis $70
    db $b4 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_PTERANOD ; id 172 Pteranod: picture: monster id
    db SKILL_INFERNOS ; skill 1
    db SKILL_FIREAIR ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 180 ; EXP
    db $05 ; join-chance class
    db $05 ; level
    dw 32 ; base HP
    dw 21 ; base MP
    dw 34 ; base ATK
    dw 19 ; base DEF
    dw 62 ; base AGL
    dw 54 ; base INT
    db $c8 ; personality axis $6F
    db $c8 ; personality axis $70
    db $32 ; byte 24 ($71)
    db $32 ; personality axis $72
    dw MONSTER_WINDBEAST ; id 173 WindBeast: picture: monster id
    db SKILL_UPPER ; skill 1
    db SKILL_RAMMING ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 147 ; EXP
    db $05 ; join-chance class
    db $05 ; level
    dw 27 ; base HP
    dw 43 ; base MP
    dw 24 ; base ATK
    dw 27 ; base DEF
    dw 42 ; base AGL
    dw 80 ; base INT
    db $c8 ; personality axis $6F
    db $28 ; personality axis $70
    db $1e ; byte 24 ($71)
    db $32 ; personality axis $72
    dw MONSTER_FAIRYRAT ; id 174 FairyRat: picture: monster id
    db SKILL_BLAZE ; skill 1
    db SKILL_FIREBAL ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 154 ; EXP
    db $05 ; join-chance class
    db $05 ; level
    dw 30 ; base HP
    dw 24 ; base MP
    dw 24 ; base ATK
    dw 29 ; base DEF
    dw 42 ; base AGL
    dw 54 ; base INT
    db $c8 ; personality axis $6F
    db $c8 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $32 ; personality axis $72
    dw MONSTER_BIGEYE ; id 175 BigEye: picture: monster id
    db SKILL_CHARGEUP ; skill 1
    db SKILL_RADIANT ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 184 ; EXP
    db $05 ; join-chance class
    db $05 ; level
    dw 32 ; base HP
    dw 16 ; base MP
    dw 29 ; base ATK
    dw 21 ; base DEF
    dw 23 ; base AGL
    dw 74 ; base INT
    db $b4 ; personality axis $6F
    db $46 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $32 ; personality axis $72
    dw MONSTER_BULLBIRD ; id 176 BullBird: picture: monster id
    db SKILL_TWINHITS ; skill 1
    db SKILL_KAMIKAZE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 165 ; EXP
    db $05 ; join-chance class
    db $05 ; level
    dw 31 ; base HP
    dw 16 ; base MP
    dw 29 ; base ATK
    dw 22 ; base DEF
    dw 55 ; base AGL
    dw 54 ; base INT
    db $c8 ; personality axis $6F
    db $1e ; personality axis $70
    db $46 ; byte 24 ($71)
    db $32 ; personality axis $72
    dw MONSTER_TREEBOY ; id 177 TreeBoy: picture: monster id
    db SKILL_HEAL ; skill 1
    db SKILL_TAKEMAGIC ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 182 ; EXP
    db $05 ; join-chance class
    db $05 ; level
    dw 32 ; base HP
    dw 34 ; base MP
    dw 16 ; base ATK
    dw 28 ; base DEF
    dw 39 ; base AGL
    dw 97 ; base INT
    db $82 ; personality axis $6F
    db $82 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $32 ; personality axis $72
    dw MONSTER_GOHOPPER ; id 178 GoHopper: picture: monster id
    db SKILL_FIRESLASH ; skill 1
    db SKILL_VACUSLASH ; skill 2
    db SKILL_BOLTSLASH ; skill 3
    db $ff ; skill 4
    dw 138 ; EXP
    db $05 ; join-chance class
    db $05 ; level
    dw 27 ; base HP
    dw 16 ; base MP
    dw 16 ; base ATK
    dw 26 ; base DEF
    dw 42 ; base AGL
    dw 51 ; base INT
    db $a0 ; personality axis $6F
    db $28 ; personality axis $70
    db $78 ; byte 24 ($71)
    db $32 ; personality axis $72
    dw MONSTER_EVILBEAST ; id 179 EvilBeast: picture: monster id
    db SKILL_BIATTACK ; skill 1
    db SKILL_POISONGAS ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 177 ; EXP
    db $05 ; join-chance class
    db $06 ; level
    dw 42 ; base HP
    dw 26 ; base MP
    dw 50 ; base ATK
    dw 50 ; base DEF
    dw 26 ; base AGL
    dw 97 ; base INT
    db $aa ; personality axis $6F
    db $82 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $32 ; personality axis $72
    dw MONSTER_MUDRON ; id 180 Mudron: picture: monster id
    db SKILL_SLOW ; skill 1
    db SKILL_WATERSHOT ; skill 2
    db SKILL_GEYSER ; skill 3
    db $ff ; skill 4
    dw 156 ; EXP
    db $05 ; join-chance class
    db $05 ; level
    dw 41 ; base HP
    dw 24 ; base MP
    dw 21 ; base ATK
    dw 29 ; base DEF
    dw 23 ; base AGL
    dw 86 ; base INT
    db $14 ; personality axis $6F
    db $8c ; personality axis $70
    db $1e ; byte 24 ($71)
    db $32 ; personality axis $72
    dw MONSTER_REAPER ; id 181 Reaper: picture: monster id
    db SKILL_BLAZE ; skill 1
    db SKILL_WINDBEAST ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 149 ; EXP
    db $05 ; join-chance class
    db $05 ; level
    dw 41 ; base HP
    dw 33 ; base MP
    dw 43 ; base ATK
    dw 29 ; base DEF
    dw 55 ; base AGL
    dw 127 ; base INT
    db $8c ; personality axis $6F
    db $c8 ; personality axis $70
    db $dc ; byte 24 ($71)
    db $32 ; personality axis $72
    dw MONSTER_MUMMY ; id 182 Mummy: picture: monster id
    db SKILL_PANICALL ; skill 1
    db SKILL_PARALYZE ; skill 2
    db SKILL_WARCRY ; skill 3
    db $ff ; skill 4
    dw 175 ; EXP
    db $05 ; join-chance class
    db $05 ; level
    dw 19 ; base HP
    dw 19 ; base MP
    dw 29 ; base ATK
    dw 16 ; base DEF
    dw 23 ; base AGL
    dw 37 ; base INT
    db $a0 ; personality axis $6F
    db $32 ; personality axis $70
    db $aa ; byte 24 ($71)
    db $32 ; personality axis $72
    dw MONSTER_JEWELBAG ; id 183 JewelBag: picture: monster id
    db SKILL_ROBMAGIC ; skill 1
    db SKILL_FIREAIR ; skill 2
    db SKILL_RADIANT ; skill 3
    db $ff ; skill 4
    dw 169 ; EXP
    db $05 ; join-chance class
    db $05 ; level
    dw 27 ; base HP
    dw 21 ; base MP
    dw 22 ; base ATK
    dw 34 ; base DEF
    dw 42 ; base AGL
    dw 97 ; base INT
    db $8c ; personality axis $6F
    db $28 ; personality axis $70
    db $78 ; byte 24 ($71)
    db $32 ; personality axis $72
    dw MONSTER_STARFISH ; id 184 Starfish: picture: monster id
    db SKILL_SAP ; skill 1
    db SKILL_VACUSLASH ; skill 2
    db SKILL_HIGHJUMP ; skill 3
    db $ff ; skill 4
    dw 174 ; EXP
    db $05 ; join-chance class
    db $05 ; level
    dw 27 ; base HP
    dw 22 ; base MP
    dw 16 ; base ATK
    dw 16 ; base DEF
    dw 23 ; base AGL
    dw 70 ; base INT
    db $82 ; personality axis $6F
    db $8c ; personality axis $70
    db $6e ; byte 24 ($71)
    db $32 ; personality axis $72
    dw MONSTER_BRUSHEAD ; id 185 Brushead: picture: monster id
    db SKILL_BLAZE ; skill 1
    db SKILL_LUREDANCE ; skill 2
    db SKILL_SIDESTEP ; skill 3
    db $ff ; skill 4
    dw 164 ; EXP
    db $05 ; join-chance class
    db $06 ; level
    dw 26 ; base HP
    dw 45 ; base MP
    dw 34 ; base ATK
    dw 18 ; base DEF
    dw 26 ; base AGL
    dw 134 ; base INT
    db $dc ; personality axis $6F
    db $0a ; personality axis $70
    db $14 ; byte 24 ($71)
    db $32 ; personality axis $72
    dw MONSTER_MUDDOLL ; id 186 MudDoll: picture: monster id
    db SKILL_ROBMAGIC ; skill 1
    db SKILL_METALCUT ; skill 2
    db SKILL_SANDSTORM ; skill 3
    db $ff ; skill 4
    dw 171 ; EXP
    db $05 ; join-chance class
    db $05 ; level
    dw 30 ; base HP
    dw 33 ; base MP
    dw 24 ; base ATK
    dw 29 ; base DEF
    dw 16 ; base AGL
    dw 97 ; base INT
    db $28 ; personality axis $6F
    db $28 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $32 ; personality axis $72
    dw MONSTER_RUSHFISH ; id 187 RushFish: picture: monster id
    db SKILL_WATERSHOT ; skill 1
    db SKILL_BUGBLOW ; skill 2
    db SKILL_KAMIKAZE ; skill 3
    db $ff ; skill 4
    dw 180 ; EXP
    db $05 ; join-chance class
    db $06 ; level
    dw 26 ; base HP
    dw 45 ; base MP
    dw 29 ; base ATK
    dw 18 ; base DEF
    dw 55 ; base AGL
    dw 150 ; base INT
    db $c8 ; personality axis $6F
    db $8c ; personality axis $70
    db $6e ; byte 24 ($71)
    db $32 ; personality axis $72
    dw MONSTER_WINGSLIME ; id 188 WingSlime: picture: monster id
    db SKILL_UPPER ; skill 1
    db SKILL_SHEARS ; skill 2
    db SKILL_STORMWIND ; skill 3
    db $ff ; skill 4
    dw 220 ; EXP
    db $05 ; join-chance class
    db $0b ; level
    dw 49 ; base HP
    dw 44 ; base MP
    dw 45 ; base ATK
    dw 35 ; base DEF
    dw 139 ; base AGL
    dw 100 ; base INT
    db $5a ; personality axis $6F
    db $82 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $5a ; personality axis $72
    dw MONSTER_POISONGON ; id 189 Poisongon: picture: monster id
    db SKILL_FRIGIDAIR ; skill 1
    db SKILL_AQUACUT ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 243 ; EXP
    db $05 ; join-chance class
    db $09 ; level
    dw 78 ; base HP
    dw 47 ; base MP
    dw 47 ; base ATK
    dw 42 ; base DEF
    dw 35 ; base AGL
    dw 64 ; base INT
    db $1e ; personality axis $6F
    db $c8 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $5a ; personality axis $72
    dw MONSTER_DRYGON ; id 190 Drygon: picture: monster id
    db SKILL_FIREBAL ; skill 1
    db SKILL_MOUTHSHUT ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 250 ; EXP
    db $05 ; join-chance class
    db $0a ; level
    dw 58 ; base HP
    dw 37 ; base MP
    dw 63 ; base ATK
    dw 42 ; base DEF
    dw 35 ; base AGL
    dw 140 ; base INT
    db $c8 ; personality axis $6F
    db $1e ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $5a ; personality axis $72
    dw MONSTER_CATFLY ; id 191 CatFly: picture: monster id
    db SKILL_FIREAIR ; skill 1
    db SKILL_DRAKSLASH ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 233 ; EXP
    db $05 ; join-chance class
    db $09 ; level
    dw 60 ; base HP
    dw 32 ; base MP
    dw 42 ; base ATK
    dw 32 ; base DEF
    dw 75 ; base AGL
    dw 160 ; base INT
    db $14 ; personality axis $6F
    db $d2 ; personality axis $70
    db $6e ; byte 24 ($71)
    db $5a ; personality axis $72
    dw MONSTER_MOMMONJA ; id 192 Mommonja: picture: monster id
    db SKILL_HEAL ; skill 1
    db SKILL_MPASS ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 228 ; EXP
    db $05 ; join-chance class
    db $09 ; level
    dw 48 ; base HP
    dw 29 ; base MP
    dw 47 ; base ATK
    dw 48 ; base DEF
    dw 112 ; base AGL
    dw 80 ; base INT
    db $78 ; personality axis $6F
    db $82 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $5a ; personality axis $72
    dw MONSTER_GRIZZLY ; id 193 Grizzly: picture: monster id
    db SKILL_TWINHITS ; skill 1
    db SKILL_CLEANCUT ; skill 2
    db SKILL_AQUACUT ; skill 3
    db $ff ; skill 4
    dw 281 ; EXP
    db $05 ; join-chance class
    db $0b ; level
    dw 71 ; base HP
    dw 10 ; base MP
    dw 76 ; base ATK
    dw 24 ; base DEF
    dw 42 ; base AGL
    dw 64 ; base INT
    db $c8 ; personality axis $6F
    db $0a ; personality axis $70
    db $0a ; byte 24 ($71)
    db $5a ; personality axis $72
    dw MONSTER_CRAGDEVIL ; id 194 CragDevil: picture: monster id
    db SKILL_SAP ; skill 1
    db SKILL_BIATTACK ; skill 2
    db SKILL_HIGHJUMP ; skill 3
    db $ff ; skill 4
    dw 229 ; EXP
    db $05 ; join-chance class
    db $09 ; level
    dw 73 ; base HP
    dw 48 ; base MP
    dw 48 ; base ATK
    dw 34 ; base DEF
    dw 75 ; base AGL
    dw 201 ; base INT
    db $0a ; personality axis $6F
    db $d2 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $5a ; personality axis $72
    dw MONSTER_PICKY ; id 195 Picky: picture: monster id
    db SKILL_SURROUND ; skill 1
    db SKILL_AHHH ; skill 2
    db SKILL_WARCRY ; skill 3
    db $ff ; skill 4
    dw 237 ; EXP
    db $05 ; join-chance class
    db $08 ; level
    dw 48 ; base HP
    dw 42 ; base MP
    dw 48 ; base ATK
    dw 34 ; base DEF
    dw 69 ; base AGL
    dw 80 ; base INT
    db $14 ; personality axis $6F
    db $5a ; personality axis $70
    db $aa ; byte 24 ($71)
    db $5a ; personality axis $72
    dw MONSTER_PIXY ; id 196 Pixy: picture: monster id
    db SKILL_HEAL ; skill 1
    db SKILL_STOPSPELL ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 245 ; EXP
    db $05 ; join-chance class
    db $08 ; level
    dw 39 ; base HP
    dw 24 ; base MP
    dw 47 ; base ATK
    dw 24 ; base DEF
    dw 68 ; base AGL
    dw 80 ; base INT
    db $8c ; personality axis $6F
    db $0a ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $5a ; personality axis $72
    dw MONSTER_AGDEVIL ; id 197 AgDevil: picture: monster id
    db SKILL_BEASTCUT ; skill 1
    db SKILL_SLEEPAIR ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 266 ; EXP
    db $05 ; join-chance class
    db $09 ; level
    dw 47 ; base HP
    dw 29 ; base MP
    dw 52 ; base ATK
    dw 34 ; base DEF
    dw 68 ; base AGL
    dw 244 ; base INT
    db $8c ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $5a ; personality axis $72
    dw MONSTER_HORK ; id 198 Hork: picture: monster id
    db SKILL_UPPER ; skill 1
    db SKILL_CALLHELP ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 251 ; EXP
    db $05 ; join-chance class
    db $09 ; level
    dw 48 ; base HP
    dw 42 ; base MP
    dw 47 ; base ATK
    dw 26 ; base DEF
    dw 42 ; base AGL
    dw 107 ; base INT
    db $28 ; personality axis $6F
    db $32 ; personality axis $70
    db $82 ; byte 24 ($71)
    db $5a ; personality axis $72
    dw MONSTER_WINDMERGE ; id 199 WindMerge: picture: monster id
    db SKILL_SLOW ; skill 1
    db SKILL_VACUSLASH ; skill 2
    db SKILL_DANCESHUT ; skill 3
    db $ff ; skill 4
    dw 241 ; EXP
    db $05 ; join-chance class
    db $09 ; level
    dw 47 ; base HP
    dw 73 ; base MP
    dw 73 ; base ATK
    dw 34 ; base DEF
    dw 60 ; base AGL
    dw 244 ; base INT
    db $1e ; personality axis $6F
    db $d2 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $5a ; personality axis $72
    dw MONSTER_SPIKYBOY ; id 200 SpikyBoy: picture: monster id
    db SKILL_HEAL ; skill 1
    db SKILL_HIGHJUMP ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 255 ; EXP
    db $05 ; join-chance class
    db $0a ; level
    dw 52 ; base HP
    dw 51 ; base MP
    dw 52 ; base ATK
    dw 37 ; base DEF
    dw 46 ; base AGL
    dw 154 ; base INT
    db $96 ; personality axis $6F
    db $82 ; personality axis $70
    db $14 ; byte 24 ($71)
    db $5a ; personality axis $72
    dw MONSTER_GOOPI ; id 201 Goopi: picture: monster id
    db SKILL_WINDBEAST ; skill 1
    db SKILL_BIATTACK ; skill 2
    db SKILL_MOUTHSHUT ; skill 3
    db $ff ; skill 4
    dw 242 ; EXP
    db $05 ; join-chance class
    db $0b ; level
    dw 34 ; base HP
    dw 49 ; base MP
    dw 39 ; base ATK
    dw 55 ; base DEF
    dw 43 ; base AGL
    dw 100 ; base INT
    db $c8 ; personality axis $6F
    db $0a ; personality axis $70
    db $28 ; byte 24 ($71)
    db $5a ; personality axis $72
    dw MONSTER_OCTOKID ; id 202 Octokid: picture: monster id
    db SKILL_SPEED ; skill 1
    db SKILL_MAGICBACK ; skill 2
    db SKILL_NAPATTACK ; skill 3
    db $ff ; skill 4
    dw 267 ; EXP
    db $05 ; join-chance class
    db $0b ; level
    dw 37 ; base HP
    dw 54 ; base MP
    dw 49 ; base ATK
    dw 49 ; base DEF
    dw 79 ; base AGL
    dw 307 ; base INT
    db $8c ; personality axis $6F
    db $82 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $5a ; personality axis $72
    dw MONSTER_CANCERMAN ; id 203 CancerMan: picture: monster id
    db SKILL_CHARGEUP ; skill 1
    db SKILL_PSYCHEUP ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 248 ; EXP
    db $05 ; join-chance class
    db $09 ; level
    dw 43 ; base HP
    dw 42 ; base MP
    dw 63 ; base ATK
    dw 78 ; base DEF
    dw 69 ; base AGL
    dw 97 ; base INT
    db $b4 ; personality axis $6F
    db $aa ; personality axis $70
    db $1e ; byte 24 ($71)
    db $5a ; personality axis $72
    dw MONSTER_SLIMENITE ; id 204 SlimeNite: picture: monster id
    db SKILL_BLAZE ; skill 1
    db SKILL_SURROUND ; skill 2
    db SKILL_SQUALLHIT ; skill 3
    db $ff ; skill 4
    dw 350 ; EXP
    db $05 ; join-chance class
    db $0f ; level
    dw 71 ; base HP
    dw 52 ; base MP
    dw 72 ; base ATK
    dw 66 ; base DEF
    dw 172 ; base AGL
    dw 237 ; base INT
    db $8c ; personality axis $6F
    db $64 ; personality axis $70
    db $aa ; byte 24 ($71)
    db $8c ; personality axis $72
    dw MONSTER_BABBLE ; id 205 Babble: picture: monster id
    db SKILL_ICEBOLT ; skill 1
    db SKILL_SLEEPAIR ; skill 2
    db SKILL_WARCRY ; skill 3
    db $ff ; skill 4
    dw 377 ; EXP
    db $05 ; join-chance class
    db $0f ; level
    dw 62 ; base HP
    dw 120 ; base MP
    dw 62 ; base ATK
    dw 62 ; base DEF
    dw 68 ; base AGL
    dw 400 ; base INT
    db $c8 ; personality axis $6F
    db $aa ; personality axis $70
    db $d2 ; byte 24 ($71)
    db $8c ; personality axis $72
    dw MONSTER_RAYBURN ; id 206 Rayburn: picture: monster id
    db SKILL_SLEEP ; skill 1
    db SKILL_ANTIDOTE ; skill 2
    db SKILL_LUSHLICKS ; skill 3
    db $ff ; skill 4
    dw 384 ; EXP
    db $05 ; join-chance class
    db $0f ; level
    dw 71 ; base HP
    dw 62 ; base MP
    dw 71 ; base ATK
    dw 67 ; base DEF
    dw 103 ; base AGL
    dw 224 ; base INT
    db $0a ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $8c ; personality axis $72
    dw MONSTER_CATMAGE ; id 207 CatMage: picture: monster id
    db SKILL_BEAT ; skill 1
    db SKILL_ZOMBIECUT ; skill 2
    db SKILL_SUCKAIR ; skill 3
    db $ff ; skill 4
    dw 369 ; EXP
    db $05 ; join-chance class
    db $11 ; level
    dw 72 ; base HP
    dw 89 ; base MP
    dw 61 ; base ATK
    dw 66 ; base DEF
    dw 102 ; base AGL
    dw 218 ; base INT
    db $78 ; personality axis $6F
    db $c8 ; personality axis $70
    db $0a ; byte 24 ($71)
    db $8c ; personality axis $72
    dw MONSTER_YETI ; id 208 Yeti: picture: monster id
    db SKILL_UPPER ; skill 1
    db SKILL_SLEEP ; skill 2
    db SKILL_WATERSHOT ; skill 3
    db $ff ; skill 4
    dw 399 ; EXP
    db $05 ; join-chance class
    db $0f ; level
    dw 77 ; base HP
    dw 42 ; base MP
    dw 72 ; base ATK
    dw 42 ; base DEF
    dw 60 ; base AGL
    dw 124 ; base INT
    db $96 ; personality axis $6F
    db $96 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $8c ; personality axis $72
    dw MONSTER_BEAVERN ; id 209 Beavern: picture: monster id
    db SKILL_SPEEDUP ; skill 1
    db SKILL_RAINSLASH ; skill 2
    db SKILL_SIDESTEP ; skill 3
    db $ff ; skill 4
    dw 371 ; EXP
    db $05 ; join-chance class
    db $0f ; level
    dw 72 ; base HP
    dw 37 ; base MP
    dw 77 ; base ATK
    dw 65 ; base DEF
    dw 102 ; base AGL
    dw 140 ; base INT
    db $c8 ; personality axis $6F
    db $8c ; personality axis $70
    db $b4 ; byte 24 ($71)
    db $8c ; personality axis $72
    dw MONSTER_FLORAJAY ; id 210 Florajay: picture: monster id
    db SKILL_HEAL ; skill 1
    db SKILL_SLEEPAIR ; skill 2
    db SKILL_SUCKALL ; skill 3
    db $ff ; skill 4
    dw 369 ; EXP
    db $05 ; join-chance class
    db $11 ; level
    dw 95 ; base HP
    dw 77 ; base MP
    dw 77 ; base ATK
    dw 80 ; base DEF
    dw 172 ; base AGL
    dw 383 ; base INT
    db $8c ; personality axis $6F
    db $6e ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $8c ; personality axis $72
    dw MONSTER_TOADSTOOL ; id 211 Toadstool: picture: monster id
    db SKILL_NUMBOFF ; skill 1
    db SKILL_SURROUND ; skill 2
    db SKILL_AHHH ; skill 3
    db $ff ; skill 4
    dw 319 ; EXP
    db $05 ; join-chance class
    db $0d ; level
    dw 71 ; base HP
    dw 77 ; base MP
    dw 58 ; base ATK
    dw 48 ; base DEF
    dw 96 ; base AGL
    dw 224 ; base INT
    db $1e ; personality axis $6F
    db $d2 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $8c ; personality axis $72
    dw MONSTER_GIANTMOTH ; id 212 GiantMoth: picture: monster id
    db SKILL_BERSERKER ; skill 1
    db SKILL_ODDDANCE ; skill 2
    db SKILL_RADIANT ; skill 3
    db $ff ; skill 4
    dw 367 ; EXP
    db $05 ; join-chance class
    db $0f ; level
    dw 71 ; base HP
    dw 42 ; base MP
    dw 72 ; base ATK
    dw 47 ; base DEF
    dw 172 ; base AGL
    dw 157 ; base INT
    db $1e ; personality axis $6F
    db $8c ; personality axis $70
    db $be ; byte 24 ($71)
    db $8c ; personality axis $72
    dw MONSTER_ARMYCRAB ; id 213 ArmyCrab: picture: monster id
    db SKILL_TWINHITS ; skill 1
    db SKILL_FIRESLASH ; skill 2
    db SKILL_LEGSWEEP ; skill 3
    db $ff ; skill 4
    dw 355 ; EXP
    db $05 ; join-chance class
    db $11 ; level
    dw 72 ; base HP
    dw 37 ; base MP
    dw 71 ; base ATK
    dw 85 ; base DEF
    dw 93 ; base AGL
    dw 107 ; base INT
    db $8c ; personality axis $6F
    db $6e ; personality axis $70
    db $1e ; byte 24 ($71)
    db $8c ; personality axis $72
    dw MONSTER_MADHORNET ; id 214 MadHornet: picture: monster id
    db SKILL_NUMBOFF ; skill 1
    db SKILL_CURSEOFF ; skill 2
    db SKILL_BIATTACK ; skill 3
    db $ff ; skill 4
    dw 366 ; EXP
    db $05 ; join-chance class
    db $12 ; level
    dw 120 ; base HP
    dw 67 ; base MP
    dw 105 ; base ATK
    dw 67 ; base DEF
    dw 172 ; base AGL
    dw 124 ; base INT
    db $28 ; personality axis $6F
    db $6e ; personality axis $70
    db $78 ; byte 24 ($71)
    db $8c ; personality axis $72
    dw MONSTER_DEMONITE ; id 215 Demonite: picture: monster id
    db SKILL_ICEBOLT ; skill 1
    db SKILL_TAKEMAGIC ; skill 2
    db SKILL_EERIELITE ; skill 3
    db $ff ; skill 4
    dw 349 ; EXP
    db $05 ; join-chance class
    db $0f ; level
    dw 82 ; base HP
    dw 32 ; base MP
    dw 67 ; base ATK
    dw 47 ; base DEF
    dw 60 ; base AGL
    dw 500 ; base INT
    db $c8 ; personality axis $6F
    db $0a ; personality axis $70
    db $aa ; byte 24 ($71)
    db $8c ; personality axis $72
    dw MONSTER_1EYECLOWN ; id 216 1EyeClown: picture: monster id
    db SKILL_HEALMORE ; skill 1
    db SKILL_MPASS ; skill 2
    db SKILL_VIVIFY ; skill 3
    db $ff ; skill 4
    dw 383 ; EXP
    db $05 ; join-chance class
    db $0d ; level
    dw 62 ; base HP
    dw 32 ; base MP
    dw 57 ; base ATK
    dw 42 ; base DEF
    dw 60 ; base AGL
    dw 237 ; base INT
    db $aa ; personality axis $6F
    db $14 ; personality axis $70
    db $32 ; byte 24 ($71)
    db $8c ; personality axis $72
    dw MONSTER_DEADNITE ; id 217 DeadNite: picture: monster id
    db SKILL_SQUALLHIT ; skill 1
    db SKILL_RAINSLASH ; skill 2
    db SKILL_EVILSLASH ; skill 3
    db $ff ; skill 4
    dw 385 ; EXP
    db $05 ; join-chance class
    db $10 ; level
    dw 71 ; base HP
    dw 37 ; base MP
    dw 115 ; base ATK
    dw 42 ; base DEF
    dw 68 ; base AGL
    dw 124 ; base INT
    db $96 ; personality axis $6F
    db $c8 ; personality axis $70
    db $a0 ; byte 24 ($71)
    db $8c ; personality axis $72
    dw MONSTER_GISMO ; id 218 Gismo: picture: monster id
    db SKILL_LIGHTNING ; skill 1
    db SKILL_BIRDBLOW ; skill 2
    db SKILL_PARALYZE ; skill 3
    db $ff ; skill 4
    dw 348 ; EXP
    db $05 ; join-chance class
    db $0f ; level
    dw 67 ; base HP
    dw 72 ; base MP
    dw 62 ; base ATK
    dw 71 ; base DEF
    dw 172 ; base AGL
    dw 257 ; base INT
    db $c8 ; personality axis $6F
    db $0a ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $8c ; personality axis $72
    dw MONSTER_OCTOGON ; id 219 Octogon: picture: monster id
    db SKILL_KODANCE ; skill 1
    db SKILL_LUREDANCE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 379 ; EXP
    db $05 ; join-chance class
    db $10 ; level
    dw 125 ; base HP
    dw 42 ; base MP
    dw 81 ; base ATK
    dw 57 ; base DEF
    dw 60 ; base AGL
    dw 400 ; base INT
    db $c8 ; personality axis $6F
    db $a0 ; personality axis $70
    db $32 ; byte 24 ($71)
    db $8c ; personality axis $72
    dw MONSTER_SNAILY ; id 220 Snaily: picture: monster id
    db SKILL_MEDITATE ; skill 1
    db SKILL_LOVERAIN ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 550 ; EXP
    db $05 ; join-chance class
    db $14 ; level
    dw 63 ; base HP
    dw 112 ; base MP
    dw 63 ; base ATK
    dw 83 ; base DEF
    dw 209 ; base AGL
    dw 390 ; base INT
    db $32 ; personality axis $6F
    db $8c ; personality axis $70
    db $aa ; byte 24 ($71)
    db $aa ; personality axis $72
    dw MONSTER_BOXSLIME ; id 221 BoxSlime: picture: monster id
    db SKILL_BARRIER ; skill 1
    db SKILL_MAGICWALL ; skill 2
    db SKILL_BLAZEAIR ; skill 3
    db $ff ; skill 4
    dw 541 ; EXP
    db $05 ; join-chance class
    db $17 ; level
    dw 112 ; base HP
    dw 146 ; base MP
    dw 121 ; base ATK
    dw 82 ; base DEF
    dw 133 ; base AGL
    dw 373 ; base INT
    db $c8 ; personality axis $6F
    db $6e ; personality axis $70
    db $d2 ; byte 24 ($71)
    db $aa ; personality axis $72
    dw MONSTER_VAMPIRUS ; id 222 Vampirus: picture: monster id
    db SKILL_ZAP ; skill 1
    db SKILL_SLEEPALL ; skill 2
    db SKILL_SQUALLHIT ; skill 3
    db $ff ; skill 4
    dw 568 ; EXP
    db $05 ; join-chance class
    db $12 ; level
    dw 93 ; base HP
    dw 48 ; base MP
    dw 67 ; base ATK
    dw 58 ; base DEF
    dw 187 ; base AGL
    dw 194 ; base INT
    db $8c ; personality axis $6F
    db $0a ; personality axis $70
    db $a0 ; byte 24 ($71)
    db $aa ; personality axis $72
    dw MONSTER_SKULLROO ; id 223 Skullroo: picture: monster id
    db SKILL_INCREASE ; skill 1
    db SKILL_HIGHJUMP ; skill 2
    db SKILL_BERSERKER ; skill 3
    db $ff ; skill 4
    dw 510 ; EXP
    db $05 ; join-chance class
    db $17 ; level
    dw 103 ; base HP
    dw 53 ; base MP
    dw 72 ; base ATK
    dw 67 ; base DEF
    dw 118 ; base AGL
    dw 244 ; base INT
    db $78 ; personality axis $6F
    db $28 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $aa ; personality axis $72
    dw MONSTER_BULLBIRD ; id 224 BullBird: picture: monster id
    db SKILL_DEFENSE ; skill 1
    db SKILL_DRAKSLASH ; skill 2
    db SKILL_DEVILCUT ; skill 3
    db $ff ; skill 4
    dw 541 ; EXP
    db $05 ; join-chance class
    db $15 ; level
    dw 93 ; base HP
    dw 146 ; base MP
    dw 75 ; base ATK
    dw 82 ; base DEF
    dw 118 ; base AGL
    dw 487 ; base INT
    db $28 ; personality axis $6F
    db $0a ; personality axis $70
    db $be ; byte 24 ($71)
    db $aa ; personality axis $72
    dw MONSTER_DANCEVEGI ; id 225 DanceVegi: picture: monster id
    db SKILL_STOPSPELL ; skill 1
    db SKILL_CALLHELP ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 536 ; EXP
    db $05 ; join-chance class
    db $16 ; level
    dw 63 ; base HP
    dw 165 ; base MP
    dw 59 ; base ATK
    dw 131 ; base DEF
    dw 209 ; base AGL
    dw 210 ; base INT
    db $c8 ; personality axis $6F
    db $6e ; personality axis $70
    db $d2 ; byte 24 ($71)
    db $aa ; personality axis $72
    dw MONSTER_STAGBUG ; id 226 StagBug: picture: monster id
    db SKILL_FIREBANE ; skill 1
    db SKILL_VACUSLASH ; skill 2
    db SKILL_BOLTSLASH ; skill 3
    db $ff ; skill 4
    dw 555 ; EXP
    db $05 ; join-chance class
    db $17 ; level
    dw 78 ; base HP
    dw 48 ; base MP
    dw 82 ; base ATK
    dw 141 ; base DEF
    dw 118 ; base AGL
    dw 160 ; base INT
    db $8c ; personality axis $6F
    db $96 ; personality axis $70
    db $1e ; byte 24 ($71)
    db $aa ; personality axis $72
    dw MONSTER_ARMORPEDE ; id 227 ArmorPede: picture: monster id
    db SKILL_BLAZEMORE ; skill 1
    db SKILL_CHARGEUP ; skill 2
    db SKILL_GUARDIAN ; skill 3
    db $ff ; skill 4
    dw 569 ; EXP
    db $05 ; join-chance class
    db $17 ; level
    dw 112 ; base HP
    dw 53 ; base MP
    dw 93 ; base ATK
    dw 141 ; base DEF
    dw 90 ; base AGL
    dw 244 ; base INT
    db $be ; personality axis $6F
    db $aa ; personality axis $70
    db $0a ; byte 24 ($71)
    db $aa ; personality axis $72
    dw MONSTER_CATAPILA ; id 228 Catapila: picture: monster id
    db SKILL_BEAT ; skill 1
    db SKILL_RAINSLASH ; skill 2
    db SKILL_CURSE ; skill 3
    db $ff ; skill 4
    dw 597 ; EXP
    db $05 ; join-chance class
    db $16 ; level
    dw 133 ; base HP
    dw 80 ; base MP
    dw 95 ; base ATK
    dw 50 ; base DEF
    dw 140 ; base AGL
    dw 267 ; base INT
    db $78 ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $aa ; personality axis $72
    dw MONSTER_DARKEYE ; id 229 DarkEye: picture: monster id
    db SKILL_INFERMORE ; skill 1
    db SKILL_MAGICBACK ; skill 2
    db SKILL_WARCRY ; skill 3
    db $ff ; skill 4
    dw 534 ; EXP
    db $05 ; join-chance class
    db $15 ; level
    dw 68 ; base HP
    dw 117 ; base MP
    dw 63 ; base ATK
    dw 82 ; base DEF
    dw 118 ; base AGL
    dw 290 ; base INT
    db $a0 ; personality axis $6F
    db $14 ; personality axis $70
    db $aa ; byte 24 ($71)
    db $aa ; personality axis $72
    dw MONSTER_GREMLIN ; id 230 Gremlin: picture: monster id
    db SKILL_BOOM ; skill 1
    db SKILL_BLAZEAIR ; skill 2
    db SKILL_ICEAIR ; skill 3
    db $ff ; skill 4
    dw 541 ; EXP
    db $05 ; join-chance class
    db $16 ; level
    dw 80 ; base HP
    dw 48 ; base MP
    dw 58 ; base ATK
    dw 63 ; base DEF
    dw 105 ; base AGL
    dw 390 ; base INT
    db $be ; personality axis $6F
    db $14 ; personality axis $70
    db $0a ; byte 24 ($71)
    db $aa ; personality axis $72
    dw MONSTER_MEDUSAEYE ; id 231 MedusaEye: picture: monster id
    db SKILL_ROCKTHROW ; skill 1
    db SKILL_HUSTLE ; skill 2
    db SKILL_IMITATE ; skill 3
    db $ff ; skill 4
    dw 512 ; EXP
    db $05 ; join-chance class
    db $15 ; level
    dw 63 ; base HP
    dw 78 ; base MP
    dw 93 ; base ATK
    dw 112 ; base DEF
    dw 83 ; base AGL
    dw 210 ; base INT
    db $6e ; personality axis $6F
    db $14 ; personality axis $70
    db $a0 ; byte 24 ($71)
    db $aa ; personality axis $72
    dw MONSTER_EVILARMOR ; id 232 EvilArmor: picture: monster id
    db SKILL_LIGHTNING ; skill 1
    db SKILL_CURSE ; skill 2
    db SKILL_EERIELITE ; skill 3
    db $ff ; skill 4
    dw 583 ; EXP
    db $05 ; join-chance class
    db $17 ; level
    dw 79 ; base HP
    dw 40 ; base MP
    dw 83 ; base ATK
    dw 156 ; base DEF
    dw 108 ; base AGL
    dw 250 ; base INT
    db $0a ; personality axis $6F
    db $d2 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $aa ; personality axis $72
    dw MONSTER_MADMIRROR ; id 233 MadMirror: picture: monster id
    db SKILL_SPEEDUP ; skill 1
    db SKILL_RADIANT ; skill 2
    db SKILL_AQUAWALL ; skill 3
    db $ff ; skill 4
    dw 596 ; EXP
    db $05 ; join-chance class
    db $15 ; level
    dw 112 ; base HP
    dw 63 ; base MP
    dw 58 ; base ATK
    dw 141 ; base DEF
    dw 90 ; base AGL
    dw 437 ; base INT
    db $c8 ; personality axis $6F
    db $c8 ; personality axis $70
    db $14 ; byte 24 ($71)
    db $aa ; personality axis $72
    dw MONSTER_ROGUENITE ; id 234 RogueNite: picture: monster id
    db SKILL_HEALUS ; skill 1
    db SKILL_STOPSPELL ; skill 2
    db SKILL_BIATTACK ; skill 3
    db $ff ; skill 4
    dw 573 ; EXP
    db $05 ; join-chance class
    db $15 ; level
    dw 93 ; base HP
    dw 58 ; base MP
    dw 146 ; base ATK
    dw 105 ; base DEF
    dw 76 ; base AGL
    dw 260 ; base INT
    db $32 ; personality axis $6F
    db $32 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $aa ; personality axis $72
    dw MONSTER_DUMBIRA ; id 235 Dumbira: picture: monster id
    db SKILL_HEALMORE ; skill 1
    db SKILL_BOLTSLASH ; skill 2
    db SKILL_POISONAIR ; skill 3
    db $ff ; skill 4
    dw 591 ; EXP
    db $05 ; join-chance class
    db $15 ; level
    dw 159 ; base HP
    dw 63 ; base MP
    dw 151 ; base ATK
    dw 98 ; base DEF
    dw 153 ; base AGL
    dw 437 ; base INT
    db $8c ; personality axis $6F
    db $14 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $aa ; personality axis $72
    dw MONSTER_METALY ; id 236 Metaly: picture: monster id
    db SKILL_SLOWALL ; skill 1
    db SKILL_BLAZEAIR ; skill 2
    db SKILL_TATSUCALL ; skill 3
    db $ff ; skill 4
    dw 12369 ; EXP
    db $05 ; join-chance class
    db $1b ; level
    dw 18 ; base HP
    dw 306 ; base MP
    dw 119 ; base ATK
    dw 415 ; base DEF
    dw 650 ; base AGL
    dw 570 ; base INT
    db $1e ; personality axis $6F
    db $aa ; personality axis $70
    db $1e ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_SNAKEBAT ; id 237 SnakeBat: picture: monster id
    db SKILL_BOOM ; skill 1
    db SKILL_INCREASE ; skill 2
    db SKILL_STORMWIND ; skill 3
    db $ff ; skill 4
    dw 1000 ; EXP
    db $05 ; join-chance class
    db $1b ; level
    dw 134 ; base HP
    dw 126 ; base MP
    dw 159 ; base ATK
    dw 131 ; base DEF
    dw 180 ; base AGL
    dw 280 ; base INT
    db $78 ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_GULPBEAST ; id 238 GulpBeast: picture: monster id
    db SKILL_TWINHITS ; skill 1
    db SKILL_FOCUS ; skill 2
    db SKILL_DODGE ; skill 3
    db $ff ; skill 4
    dw 1141 ; EXP
    db $05 ; join-chance class
    db $17 ; level
    dw 187 ; base HP
    dw 48 ; base MP
    dw 165 ; base ATK
    dw 83 ; base DEF
    dw 76 ; base AGL
    dw 160 ; base INT
    db $c8 ; personality axis $6F
    db $96 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_MADGOPHER ; id 239 MadGopher: picture: monster id
    db SKILL_ZAP ; skill 1
    db SKILL_SLEEPALL ; skill 2
    db SKILL_PSYCHEUP ; skill 3
    db $ff ; skill 4
    dw 1079 ; EXP
    db $05 ; join-chance class
    db $1b ; level
    dw 137 ; base HP
    dw 89 ; base MP
    dw 151 ; base ATK
    dw 132 ; base DEF
    dw 246 ; base AGL
    dw 280 ; base INT
    db $8c ; personality axis $6F
    db $14 ; personality axis $70
    db $aa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_MISTYWING ; id 240 MistyWing: picture: monster id
    db SKILL_BLAZEMORE ; skill 1
    db SKILL_RAMMING ; skill 2
    db SKILL_SUCKAIR ; skill 3
    db $ff ; skill 4
    dw 1182 ; EXP
    db $05 ; join-chance class
    db $19 ; level
    dw 131 ; base HP
    dw 119 ; base MP
    dw 114 ; base ATK
    dw 126 ; base DEF
    dw 210 ; base AGL
    dw 297 ; base INT
    db $c8 ; personality axis $6F
    db $0a ; personality axis $70
    db $32 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_LANDOWL ; id 241 LandOwl: picture: monster id
    db SKILL_HEALMORE ; skill 1
    db SKILL_VACUSLASH ; skill 2
    db SKILL_LUREDANCE ; skill 3
    db $ff ; skill 4
    dw 1064 ; EXP
    db $05 ; join-chance class
    db $1b ; level
    dw 156 ; base HP
    dw 64 ; base MP
    dw 182 ; base ATK
    dw 85 ; base DEF
    dw 128 ; base AGL
    dw 537 ; base INT
    db $c8 ; personality axis $6F
    db $a0 ; personality axis $70
    db $14 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_DEVIPINE ; id 242 Devipine: picture: monster id
    db SKILL_MAGICWALL ; skill 1
    db SKILL_PARALYZE ; skill 2
    db SKILL_LOVERAIN ; skill 3
    db $ff ; skill 4
    dw 1294 ; EXP
    db $05 ; join-chance class
    db $19 ; level
    dw 127 ; base HP
    dw 59 ; base MP
    dw 98 ; base ATK
    dw 84 ; base DEF
    dw 128 ; base AGL
    dw 487 ; base INT
    db $0a ; personality axis $6F
    db $c8 ; personality axis $70
    db $6e ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_BELZEBUB ; id 243 Belzebub: picture: monster id
    db SKILL_DECHAOS ; skill 1
    db SKILL_SLEEPALL ; skill 2
    db SKILL_SICKLICK ; skill 3
    db $ff ; skill 4
    dw 1035 ; EXP
    db $05 ; join-chance class
    db $1b ; level
    dw 177 ; base HP
    dw 122 ; base MP
    dw 104 ; base ATK
    dw 59 ; base DEF
    dw 170 ; base AGL
    dw 457 ; base INT
    db $96 ; personality axis $6F
    db $14 ; personality axis $70
    db $b4 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_FOOHERO ; id 244 FooHero: picture: monster id
    db SKILL_FIREBANE ; skill 1
    db SKILL_BOUNCE ; skill 2
    db SKILL_CALLHELP ; skill 3
    db $ff ; skill 4
    dw 1119 ; EXP
    db $05 ; join-chance class
    db $17 ; level
    dw 172 ; base HP
    dw 136 ; base MP
    dw 140 ; base ATK
    dw 125 ; base DEF
    dw 149 ; base AGL
    dw 277 ; base INT
    db $a0 ; personality axis $6F
    db $8c ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_BUBBLEMON ; id 245 Bubblemon: picture: monster id
    db SKILL_HEALMORE ; skill 1
    db SKILL_WATERSHOT ; skill 2
    db SKILL_BIATTACK ; skill 3
    db $ff ; skill 4
    dw 1346 ; EXP
    db $05 ; join-chance class
    db $1a ; level
    dw 119 ; base HP
    dw 89 ; base MP
    dw 156 ; base ATK
    dw 59 ; base DEF
    dw 85 ; base AGL
    dw 280 ; base INT
    db $b4 ; personality axis $6F
    db $28 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_GOATHORN ; id 246 GoatHorn: picture: monster id
    db SKILL_STOPSPELL ; skill 1
    db SKILL_YELLHELP ; skill 2
    db SKILL_BERSERKER ; skill 3
    db $ff ; skill 4
    dw 1190 ; EXP
    db $05 ; join-chance class
    db $19 ; level
    dw 176 ; base HP
    dw 89 ; base MP
    dw 123 ; base ATK
    dw 92 ; base DEF
    dw 128 ; base AGL
    dw 573 ; base INT
    db $c8 ; personality axis $6F
    db $be ; personality axis $70
    db $d2 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_SPOOKY ; id 247 Spooky: picture: monster id
    db SKILL_PANICALL ; skill 1
    db SKILL_SICKLICK ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 1013 ; EXP
    db $05 ; join-chance class
    db $1a ; level
    dw 93 ; base HP
    dw 131 ; base MP
    dw 89 ; base ATK
    dw 84 ; base DEF
    dw 230 ; base AGL
    dw 520 ; base INT
    db $1e ; personality axis $6F
    db $c8 ; personality axis $70
    db $82 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_PUTREPUP ; id 248 PutrePup: picture: monster id
    db SKILL_PSYCHEUP ; skill 1
    db SKILL_SANDSTORM ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 1322 ; EXP
    db $05 ; join-chance class
    db $1a ; level
    dw 119 ; base HP
    dw 89 ; base MP
    dw 119 ; base ATK
    dw 84 ; base DEF
    dw 128 ; base AGL
    dw 280 ; base INT
    db $a0 ; personality axis $6F
    db $1e ; personality axis $70
    db $28 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_COPYCAT ; id 249 Copycat: picture: monster id
    db SKILL_TRANSFORM ; skill 1
    db SKILL_DIAGOCALL ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 1064 ; EXP
    db $05 ; join-chance class
    db $1b ; level
    dw 89 ; base HP
    dw 172 ; base MP
    dw 54 ; base ATK
    dw 84 ; base DEF
    dw 299 ; base AGL
    dw 297 ; base INT
    db $3c ; personality axis $6F
    db $3c ; personality axis $70
    db $3c ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_METALDRAK ; id 250 MetalDrak: picture: monster id
    db SKILL_ROCKTHROW ; skill 1
    db SKILL_RADIANT ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 1319 ; EXP
    db $05 ; join-chance class
    db $1c ; level
    dw 161 ; base HP
    dw 89 ; base MP
    dw 172 ; base ATK
    dw 147 ; base DEF
    dw 180 ; base AGL
    dw 214 ; base INT
    db $64 ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_RAYGIGAS ; id 251 RayGigas: picture: monster id
    db SKILL_BOUNCE ; skill 1
    db SKILL_FOCUS ; skill 2
    db SKILL_GEYSER ; skill 3
    db $ff ; skill 4
    dw 1088 ; EXP
    db $05 ; join-chance class
    db $1c ; level
    dw 135 ; base HP
    dw 126 ; base MP
    dw 204 ; base ATK
    dw 142 ; base DEF
    dw 180 ; base AGL
    dw 197 ; base INT
    db $c8 ; personality axis $6F
    db $d2 ; personality axis $70
    db $1e ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_PEARLGEL ; id 252 PearlGel: picture: monster id
    db SKILL_SNOWSTORM ; skill 1
    db SKILL_RAMMING ; skill 2
    db SKILL_MOUTHSHUT ; skill 3
    db $ff ; skill 4
    dw 1723 ; EXP
    db $05 ; join-chance class
    db $21 ; level
    dw 119 ; base HP
    dw 108 ; base MP
    dw 116 ; base ATK
    dw 162 ; base DEF
    dw 202 ; base AGL
    dw 567 ; base INT
    db $6e ; personality axis $6F
    db $78 ; personality axis $70
    db $82 ; byte 24 ($71)
    db $d2 ; personality axis $72
    dw MONSTER_GASGON ; id 253 Gasgon: picture: monster id
    db SKILL_FIREBANE ; skill 1
    db SKILL_AQUACUT ; skill 2
    db SKILL_HIGHJUMP ; skill 3
    db $ff ; skill 4
    dw 1647 ; EXP
    db $05 ; join-chance class
    db $22 ; level
    dw 145 ; base HP
    dw 210 ; base MP
    dw 106 ; base ATK
    dw 127 ; base DEF
    dw 109 ; base AGL
    dw 716 ; base INT
    db $1e ; personality axis $6F
    db $b4 ; personality axis $70
    db $aa ; byte 24 ($71)
    db $d2 ; personality axis $72
    dw MONSTER_DRAGON ; id 254 Dragon: picture: monster id
    db SKILL_BLAZEMORE ; skill 1
    db SKILL_ROCKTHROW ; skill 2
    db SKILL_SANDSTORM ; skill 3
    db $ff ; skill 4
    dw 1891 ; EXP
    db $06 ; join-chance class
    db $21 ; level
    dw 141 ; base HP
    dw 69 ; base MP
    dw 194 ; base ATK
    dw 108 ; base DEF
    dw 106 ; base AGL
    dw 353 ; base INT
    db $c8 ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $d2 ; personality axis $72
    dw MONSTER_ARROWDOG ; id 255 ArrowDog: picture: monster id
    db SKILL_HEALMORE ; skill 1
    db SKILL_LIGHTNING ; skill 2
    db SKILL_DIAGOCALL ; skill 3
    db $ff ; skill 4
    dw 1740 ; EXP
    db $05 ; join-chance class
    db $1f ; level
    dw 210 ; base HP
    dw 74 ; base MP
    dw 153 ; base ATK
    dw 157 ; base DEF
    dw 149 ; base AGL
    dw 470 ; base INT
    db $64 ; personality axis $6F
    db $c8 ; personality axis $70
    db $50 ; byte 24 ($71)
    db $d2 ; personality axis $72
    dw MONSTER_KITEHAWK ; id 256 KiteHawk: picture: monster id
    db SKILL_HEALUS ; skill 1
    db SKILL_ICESTORM ; skill 2
    db SKILL_EERIELITE ; skill 3
    db $ff ; skill 4
    dw 1645 ; EXP
    db $05 ; join-chance class
    db $20 ; level
    dw 144 ; base HP
    dw 106 ; base MP
    dw 136 ; base ATK
    dw 74 ; base DEF
    dw 243 ; base AGL
    dw 230 ; base INT
    db $c8 ; personality axis $6F
    db $0a ; personality axis $70
    db $28 ; byte 24 ($71)
    db $d2 ; personality axis $72
    dw MONSTER_STUBBIRD ; id 257 StubBird: picture: monster id
    db SKILL_DEFEAT ; skill 1
    db SKILL_YELLHELP ; skill 2
    db SKILL_KAMIKAZE ; skill 3
    db $ff ; skill 4
    dw 1539 ; EXP
    db $05 ; join-chance class
    db $21 ; level
    dw 108 ; base HP
    dw 175 ; base MP
    dw 194 ; base ATK
    dw 194 ; base DEF
    dw 202 ; base AGL
    dw 370 ; base INT
    db $78 ; personality axis $6F
    db $28 ; personality axis $70
    db $46 ; byte 24 ($71)
    db $d2 ; personality axis $72
    dw MONSTER_ZAPBIRD ; id 258 ZapBird: picture: monster id
    db SKILL_VIVIFY ; skill 1
    db SKILL_ULTRADOWN ; skill 2
    db SKILL_STORMWIND ; skill 3
    db $ff ; skill 4
    dw 1553 ; EXP
    db $06 ; join-chance class
    db $21 ; level
    dw 194 ; base HP
    dw 74 ; base MP
    dw 157 ; base ATK
    dw 141 ; base DEF
    dw 232 ; base AGL
    dw 583 ; base INT
    db $46 ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $d2 ; personality axis $72
    dw MONSTER_WEEDBUG ; id 259 WeedBug: picture: monster id
    db SKILL_TWINHITS ; skill 1
    db SKILL_QUADHITS ; skill 2
    db SKILL_DANCESHUT ; skill 3
    db $ff ; skill 4
    dw 1764 ; EXP
    db $05 ; join-chance class
    db $20 ; level
    dw 141 ; base HP
    dw 104 ; base MP
    dw 99 ; base ATK
    dw 165 ; base DEF
    dw 149 ; base AGL
    dw 553 ; base INT
    db $28 ; personality axis $6F
    db $78 ; personality axis $70
    db $5a ; byte 24 ($71)
    db $d2 ; personality axis $72
    dw MONSTER_LIPSY ; id 260 Lipsy: picture: monster id
    db SKILL_INFERMORE ; skill 1
    db SKILL_PANICALL ; skill 2
    db SKILL_AHHH ; skill 3
    db $ff ; skill 4
    dw 1537 ; EXP
    db $05 ; join-chance class
    db $1e ; level
    dw 155 ; base HP
    dw 97 ; base MP
    dw 150 ; base ATK
    dw 100 ; base DEF
    dw 120 ; base AGL
    dw 210 ; base INT
    db $a0 ; personality axis $6F
    db $96 ; personality axis $70
    db $1e ; byte 24 ($71)
    db $d2 ; personality axis $72
    dw MONSTER_MULTIEYES ; id 261 MultiEyes: picture: monster id
    db SKILL_SURROUND ; skill 1
    db SKILL_PANICALL ; skill 2
    db SKILL_CURSE ; skill 3
    db $ff ; skill 4
    dw 1743 ; EXP
    db $05 ; join-chance class
    db $21 ; level
    dw 152 ; base HP
    dw 79 ; base MP
    dw 200 ; base ATK
    dw 108 ; base DEF
    dw 106 ; base AGL
    dw 470 ; base INT
    db $5a ; personality axis $6F
    db $50 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $d2 ; personality axis $72
    dw MONSTER_SHADOW ; id 262 Shadow: picture: monster id
    db SKILL_ZAP ; skill 1
    db SKILL_TRANSFORM ; skill 2
    db SKILL_DODGE ; skill 3
    db $ff ; skill 4
    dw 1620 ; EXP
    db $05 ; join-chance class
    db $21 ; level
    dw 210 ; base HP
    dw 189 ; base MP
    dw 189 ; base ATK
    dw 134 ; base DEF
    dw 132 ; base AGL
    dw 583 ; base INT
    db $1e ; personality axis $6F
    db $d2 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $d2 ; personality axis $72
    dw MONSTER_CAPTDEAD ; id 263 CaptDead: picture: monster id
    db SKILL_HEALMORE ; skill 1
    db SKILL_POISONAIR ; skill 2
    db SKILL_LIFEDANCE ; skill 3
    db $ff ; skill 4
    dw 1503 ; EXP
    db $05 ; join-chance class
    db $1f ; level
    dw 170 ; base HP
    dw 194 ; base MP
    dw 127 ; base ATK
    dw 98 ; base DEF
    dw 92 ; base AGL
    dw 347 ; base INT
    db $5a ; personality axis $6F
    db $78 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $d2 ; personality axis $72
    dw MONSTER_CURSELAMP ; id 264 CurseLamp: picture: monster id
    db SKILL_BLAZEMORE ; skill 1
    db SKILL_SLIMEBLOW ; skill 2
    db SKILL_CURSE ; skill 3
    db $ff ; skill 4
    dw 1468 ; EXP
    db $05 ; join-chance class
    db $21 ; level
    dw 175 ; base HP
    dw 205 ; base MP
    dw 170 ; base ATK
    dw 127 ; base DEF
    dw 139 ; base AGL
    dw 666 ; base INT
    db $1e ; personality axis $6F
    db $c8 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $d2 ; personality axis $72
    dw MONSTER_ANGLERON ; id 265 Angleron: picture: monster id
    db SKILL_RAMMING ; skill 1
    db SKILL_PALSYAIR ; skill 2
    db SKILL_STORMWIND ; skill 3
    db $ff ; skill 4
    dw 1658 ; EXP
    db $05 ; join-chance class
    db $21 ; level
    dw 141 ; base HP
    dw 108 ; base MP
    dw 199 ; base ATK
    dw 164 ; base DEF
    dw 182 ; base AGL
    dw 532 ; base INT
    db $50 ; personality axis $6F
    db $c8 ; personality axis $70
    db $0a ; byte 24 ($71)
    db $d2 ; personality axis $72
    dw MONSTER_GAMANIAN ; id 266 Gamanian: picture: monster id
    db SKILL_MAGICWALL ; skill 1
    db SKILL_POISONAIR ; skill 2
    db SKILL_LIFESONG ; skill 3
    db $ff ; skill 4
    dw 1814 ; EXP
    db $05 ; join-chance class
    db $21 ; level
    dw 111 ; base HP
    dw 79 ; base MP
    dw 193 ; base ATK
    dw 141 ; base DEF
    dw 120 ; base AGL
    dw 666 ; base INT
    db $6e ; personality axis $6F
    db $1e ; personality axis $70
    db $d2 ; byte 24 ($71)
    db $d2 ; personality axis $72
    dw MONSTER_WHALEMAGE ; id 267 WhaleMage: picture: monster id
    db SKILL_HEALMORE ; skill 1
    db SKILL_QUADHITS ; skill 2
    db SKILL_AQUAWALL ; skill 3
    db $ff ; skill 4
    dw 1902 ; EXP
    db $06 ; join-chance class
    db $22 ; level
    dw 243 ; base HP
    dw 253 ; base MP
    dw 189 ; base ATK
    dw 135 ; base DEF
    dw 156 ; base AGL
    dw 341 ; base INT
    db $dc ; personality axis $6F
    db $0a ; personality axis $70
    db $b4 ; byte 24 ($71)
    db $d2 ; personality axis $72
    dw MONSTER_SPOTKING ; id 268 SpotKing: picture: monster id
    db SKILL_HEALALL ; skill 1
    db SKILL_CHANCE ; skill 2
    db SKILL_AHHH ; skill 3
    db $ff ; skill 4
    dw 3569 ; EXP
    db $06 ; join-chance class
    db $26 ; level
    dw 251 ; base HP
    dw 137 ; base MP
    dw 215 ; base ATK
    dw 107 ; base DEF
    dw 142 ; base AGL
    dw 820 ; base INT
    db $6e ; personality axis $6F
    db $46 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $dc ; personality axis $72
    dw MONSTER_SKYDRAGON ; id 269 SkyDragon: picture: monster id
    db SKILL_FAREWELL ; skill 1
    db SKILL_VACUUM ; skill 2
    db SKILL_LOVERAIN ; skill 3
    db $ff ; skill 4
    dw 3695 ; EXP
    db $06 ; join-chance class
    db $26 ; level
    dw 246 ; base HP
    dw 137 ; base MP
    dw 220 ; base ATK
    dw 147 ; base DEF
    dw 189 ; base AGL
    dw 440 ; base INT
    db $64 ; personality axis $6F
    db $c8 ; personality axis $70
    db $dc ; byte 24 ($71)
    db $dc ; personality axis $72
    dw MONSTER_TONGUELLA ; id 270 Tonguella: picture: monster id
    db SKILL_SCORCHING ; skill 1
    db SKILL_CHARGEUP ; skill 2
    db SKILL_WARCRY ; skill 3
    db $ff ; skill 4
    dw 3640 ; EXP
    db $05 ; join-chance class
    db $27 ; level
    dw 167 ; base HP
    dw 115 ; base MP
    dw 196 ; base ATK
    dw 121 ; base DEF
    dw 110 ; base AGL
    dw 397 ; base INT
    db $1e ; personality axis $6F
    db $3c ; personality axis $70
    db $aa ; byte 24 ($71)
    db $dc ; personality axis $72
    dw MONSTER_SACCER ; id 271 Saccer: picture: monster id
    db SKILL_BARRIER ; skill 1
    db SKILL_VACUUM ; skill 2
    db SKILL_HUSTLE ; skill 3
    db $ff ; skill 4
    dw 3619 ; EXP
    db $05 ; join-chance class
    db $26 ; level
    dw 119 ; base HP
    dw 115 ; base MP
    dw 186 ; base ATK
    dw 120 ; base DEF
    dw 90 ; base AGL
    dw 383 ; base INT
    db $1e ; personality axis $6F
    db $3c ; personality axis $70
    db $be ; byte 24 ($71)
    db $dc ; personality axis $72
    dw MONSTER_WYVERN ; id 272 Wyvern: picture: monster id
    db SKILL_FIREBOLT ; skill 1
    db SKILL_LIGHTNING ; skill 2
    db SKILL_FOCUS ; skill 3
    db $ff ; skill 4
    dw 3796 ; EXP
    db $05 ; join-chance class
    db $26 ; level
    dw 167 ; base HP
    dw 115 ; base MP
    dw 198 ; base ATK
    dw 127 ; base DEF
    dw 147 ; base AGL
    dw 733 ; base INT
    db $b4 ; personality axis $6F
    db $c8 ; personality axis $70
    db $d2 ; byte 24 ($71)
    db $dc ; personality axis $72
    dw MONSTER_AQUAHAWK ; id 273 AquaHawk: picture: monster id
    db SKILL_INFERMOST ; skill 1
    db SKILL_POISONHIT ; skill 2
    db SKILL_PSYCHEUP ; skill 3
    db $ff ; skill 4
    dw 3800 ; EXP
    db $05 ; join-chance class
    db $25 ; level
    dw 138 ; base HP
    dw 132 ; base MP
    dw 215 ; base ATK
    dw 105 ; base DEF
    dw 169 ; base AGL
    dw 560 ; base INT
    db $1e ; personality axis $6F
    db $78 ; personality axis $70
    db $aa ; byte 24 ($71)
    db $dc ; personality axis $72
    dw MONSTER_GARUDIAN ; id 274 Garudian: picture: monster id
    db SKILL_VACUSLASH ; skill 1
    db SKILL_BOLTSLASH ; skill 2
    db SKILL_CURSE ; skill 3
    db $ff ; skill 4
    dw 3911 ; EXP
    db $06 ; join-chance class
    db $24 ; level
    dw 140 ; base HP
    dw 85 ; base MP
    dw 182 ; base ATK
    dw 127 ; base DEF
    dw 187 ; base AGL
    dw 720 ; base INT
    db $c8 ; personality axis $6F
    db $14 ; personality axis $70
    db $d2 ; byte 24 ($71)
    db $dc ; personality axis $72
    dw MONSTER_EYEDER ; id 275 Eyeder: picture: monster id
    db SKILL_BLIZZARD ; skill 1
    db SKILL_HIGHJUMP ; skill 2
    db SKILL_DODGE ; skill 3
    db $ff ; skill 4
    dw 3746 ; EXP
    db $05 ; join-chance class
    db $26 ; level
    dw 216 ; base HP
    dw 137 ; base MP
    dw 215 ; base ATK
    dw 133 ; base DEF
    dw 99 ; base AGL
    dw 750 ; base INT
    db $8c ; personality axis $6F
    db $14 ; personality axis $70
    db $46 ; byte 24 ($71)
    db $dc ; personality axis $72
    dw MONSTER_ARCDEMON ; id 276 ArcDemon: picture: monster id
    db SKILL_HEALALL ; skill 1
    db SKILL_MASSACRE ; skill 2
    db SKILL_TWINSLASH ; skill 3
    db $ff ; skill 4
    dw 3697 ; EXP
    db $06 ; join-chance class
    db $28 ; level
    dw 171 ; base HP
    dw 118 ; base MP
    dw 200 ; base ATK
    dw 160 ; base DEF
    dw 116 ; base AGL
    dw 914 ; base INT
    db $c8 ; personality axis $6F
    db $64 ; personality axis $70
    db $5a ; byte 24 ($71)
    db $dc ; personality axis $72
    dw MONSTER_LIONEX ; id 277 Lionex: picture: monster id
    db SKILL_SPEEDUP ; skill 1
    db SKILL_BARRIER ; skill 2
    db SKILL_SAMSICALL ; skill 3
    db $ff ; skill 4
    dw 3964 ; EXP
    db $05 ; join-chance class
    db $27 ; level
    dw 246 ; base HP
    dw 137 ; base MP
    dw 187 ; base ATK
    dw 156 ; base DEF
    dw 156 ; base AGL
    dw 560 ; base INT
    db $14 ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $dc ; personality axis $72
    dw MONSTER_GATEGUARD ; id 278 GateGuard: picture: monster id
    db SKILL_DEFENSE ; skill 1
    db SKILL_DRAKSLASH ; skill 2
    db SKILL_EVILSLASH ; skill 3
    db $ff ; skill 4
    dw 3821 ; EXP
    db $05 ; join-chance class
    db $27 ; level
    dw 251 ; base HP
    dw 221 ; base MP
    dw 221 ; base ATK
    dw 127 ; base DEF
    dw 136 ; base AGL
    dw 557 ; base INT
    db $5a ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $dc ; personality axis $72
    dw MONSTER_CENTASAUR ; id 279 Centasaur: picture: monster id
    db SKILL_BLIZZARD ; skill 1
    db SKILL_ZOMBIECUT ; skill 2
    db SKILL_BAZOOCALL ; skill 3
    db $ff ; skill 4
    dw 3696 ; EXP
    db $05 ; join-chance class
    db $29 ; level
    dw 220 ; base HP
    dw 80 ; base MP
    dw 256 ; base ATK
    dw 166 ; base DEF
    dw 126 ; base AGL
    dw 580 ; base INT
    db $78 ; personality axis $6F
    db $c8 ; personality axis $70
    db $0a ; byte 24 ($71)
    db $dc ; personality axis $72
    dw MONSTER_ROBOSTER ; id 280 Roboster: picture: monster id
    db SKILL_HEALALL ; skill 1
    db SKILL_INCREASE ; skill 2
    db SKILL_GIGASLASH ; skill 3
    db $ff ; skill 4
    dw 3976 ; EXP
    db $06 ; join-chance class
    db $29 ; level
    dw 225 ; base HP
    dw 115 ; base MP
    dw 217 ; base ATK
    dw 180 ; base DEF
    dw 177 ; base AGL
    dw 736 ; base INT
    db $1e ; personality axis $6F
    db $dc ; personality axis $70
    db $1e ; byte 24 ($71)
    db $dc ; personality axis $72
    dw MONSTER_EGGPLATON ; id 281 Eggplaton: picture: monster id
    db SKILL_ROCKTHROW ; skill 1
    db SKILL_QUADHITS ; skill 2
    db SKILL_SUCKALL ; skill 3
    db $ff ; skill 4
    dw 3451 ; EXP
    db $05 ; join-chance class
    db $27 ; level
    dw 119 ; base HP
    dw 215 ; base MP
    dw 199 ; base ATK
    dw 211 ; base DEF
    dw 189 ; base AGL
    dw 284 ; base INT
    db $0a ; personality axis $6F
    db $c8 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $dc ; personality axis $72
    dw MONSTER_CLAWSTER ; id 282 Clawster: picture: monster id
    db SKILL_REVIVE ; skill 1
    db SKILL_BOLTSLASH ; skill 2
    db SKILL_DANCESHUT ; skill 3
    db $ff ; skill 4
    dw 3498 ; EXP
    db $05 ; join-chance class
    db $29 ; level
    dw 221 ; base HP
    dw 60 ; base MP
    dw 265 ; base ATK
    dw 210 ; base DEF
    dw 116 ; base AGL
    dw 557 ; base INT
    db $8c ; personality axis $6F
    db $96 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $dc ; personality axis $72
    dw MONSTER_MERTIGER ; id 283 MerTiger: picture: monster id
    db SKILL_BEDRAGON ; skill 1
    db SKILL_BEASTCUT ; skill 2
    db SKILL_DEVILCUT ; skill 3
    db $ff ; skill 4
    dw 3691 ; EXP
    db $05 ; join-chance class
    db $28 ; level
    dw 225 ; base HP
    dw 115 ; base MP
    dw 230 ; base ATK
    dw 144 ; base DEF
    dw 119 ; base AGL
    dw 383 ; base INT
    db $e6 ; personality axis $6F
    db $6e ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $dc ; personality axis $72
    dw MONSTER_TREESLIME ; id 284 TreeSlime: picture: monster id
    db SKILL_FAREWELL ; skill 1
    db SKILL_STOPSPELL ; skill 2
    db SKILL_MEDITATE ; skill 3
    db $ff ; skill 4
    dw 7026 ; EXP
    db $05 ; join-chance class
    db $2e ; level
    dw 151 ; base HP
    dw 205 ; base MP
    dw 171 ; base ATK
    dw 235 ; base DEF
    dw 336 ; base AGL
    dw 783 ; base INT
    db $28 ; personality axis $6F
    db $28 ; personality axis $70
    db $d2 ; byte 24 ($71)
    db $e6 ; personality axis $72
    dw MONSTER_SWORDGON ; id 285 Swordgon: picture: monster id
    db SKILL_PARALYZE ; skill 1
    db SKILL_SQUALLHIT ; skill 2
    db SKILL_RAMMING ; skill 3
    db $ff ; skill 4
    dw 7146 ; EXP
    db $06 ; join-chance class
    db $2e ; level
    dw 249 ; base HP
    dw 171 ; base MP
    dw 264 ; base ATK
    dw 226 ; base DEF
    dw 135 ; base AGL
    dw 430 ; base INT
    db $be ; personality axis $6F
    db $c8 ; personality axis $70
    db $50 ; byte 24 ($71)
    db $e6 ; personality axis $72
    dw MONSTER_SUPERTEN ; id 286 SuperTen: picture: monster id
    db SKILL_PANICALL ; skill 1
    db SKILL_DIAGOCALL ; skill 2
    db SKILL_IMITATE ; skill 3
    db $ff ; skill 4
    dw 7030 ; EXP
    db $05 ; join-chance class
    db $2c ; level
    dw 294 ; base HP
    dw 106 ; base MP
    dw 142 ; base ATK
    dw 269 ; base DEF
    dw 245 ; base AGL
    dw 353 ; base INT
    db $96 ; personality axis $6F
    db $14 ; personality axis $70
    db $6e ; byte 24 ($71)
    db $e6 ; personality axis $72
    dw MONSTER_HAMMERMAN ; id 287 HammerMan: picture: monster id
    db SKILL_NUMBOFF ; skill 1
    db SKILL_PSYCHEUP ; skill 2
    db SKILL_BLADED ; skill 3
    db $ff ; skill 4
    dw 7216 ; EXP
    db $06 ; join-chance class
    db $2d ; level
    dw 210 ; base HP
    dw 189 ; base MP
    dw 201 ; base ATK
    dw 190 ; base DEF
    dw 287 ; base AGL
    dw 403 ; base INT
    db $64 ; personality axis $6F
    db $8c ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $e6 ; personality axis $72
    dw MONSTER_GOATEGON ; id 288 Goategon: picture: monster id
    db SKILL_TWINHITS ; skill 1
    db SKILL_MAGICWALL ; skill 2
    db SKILL_SUCKAIR ; skill 3
    db $ff ; skill 4
    dw 7118 ; EXP
    db $06 ; join-chance class
    db $2b ; level
    dw 193 ; base HP
    dw 332 ; base MP
    dw 201 ; base ATK
    dw 140 ; base DEF
    dw 384 ; base AGL
    dw 833 ; base INT
    db $14 ; personality axis $6F
    db $8c ; personality axis $70
    db $b4 ; byte 24 ($71)
    db $e6 ; personality axis $72
    dw MONSTER_DRACKY ; id 289 Dracky: picture: monster id
    db SKILL_THORDAIN ; skill 1
    db SKILL_SLEEPAIR ; skill 2
    db SKILL_FOCUS ; skill 3
    db $ff ; skill 4
    dw 7346 ; EXP
    db $05 ; join-chance class
    db $2a ; level
    dw 171 ; base HP
    dw 149 ; base MP
    dw 156 ; base ATK
    dw 136 ; base DEF
    dw 287 ; base AGL
    dw 570 ; base INT
    db $c8 ; personality axis $6F
    db $c8 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $e6 ; personality axis $72
    dw MONSTER_PUTREFISH ; id 290 PutreFish: picture: monster id
    db SKILL_WATERSHOT ; skill 1
    db SKILL_SICKLICK ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 7413 ; EXP
    db $05 ; join-chance class
    db $2d ; level
    dw 209 ; base HP
    dw 106 ; base MP
    dw 181 ; base ATK
    dw 206 ; base DEF
    dw 270 ; base AGL
    dw 677 ; base INT
    db $1e ; personality axis $6F
    db $78 ; personality axis $70
    db $b4 ; byte 24 ($71)
    db $e6 ; personality axis $72
    dw MONSTER_AMBERWEED ; id 291 AmberWeed: picture: monster id
    db SKILL_SACRIFICE ; skill 1
    db SKILL_QUADHITS ; skill 2
    db SKILL_GUARDIAN ; skill 3
    db $ff ; skill 4
    dw 7642 ; EXP
    db $06 ; join-chance class
    db $2d ; level
    dw 269 ; base HP
    dw 347 ; base MP
    dw 186 ; base ATK
    dw 203 ; base DEF
    dw 384 ; base AGL
    dw 403 ; base INT
    db $c8 ; personality axis $6F
    db $c8 ; personality axis $70
    db $82 ; byte 24 ($71)
    db $e6 ; personality axis $72
    dw MONSTER_WARMANTIS ; id 292 WarMantis: picture: monster id
    db SKILL_SLEEPALL ; skill 1
    db SKILL_RAINSLASH ; skill 2
    db SKILL_TWINSLASH ; skill 3
    db $ff ; skill 4
    dw 7497 ; EXP
    db $06 ; join-chance class
    db $2e ; level
    dw 264 ; base HP
    dw 150 ; base MP
    dw 269 ; base ATK
    dw 249 ; base DEF
    dw 245 ; base AGL
    dw 911 ; base INT
    db $32 ; personality axis $6F
    db $c8 ; personality axis $70
    db $0a ; byte 24 ($71)
    db $e6 ; personality axis $72
    dw MONSTER_ORC ; id 293 Orc: picture: monster id
    db SKILL_BLAZEMOST ; skill 1
    db SKILL_BERSERKER ; skill 2
    db SKILL_SUCKALL ; skill 3
    db $ff ; skill 4
    dw 7661 ; EXP
    db $06 ; join-chance class
    db $2c ; level
    dw 189 ; base HP
    dw 106 ; base MP
    dw 189 ; base ATK
    dw 136 ; base DEF
    dw 195 ; base AGL
    dw 905 ; base INT
    db $aa ; personality axis $6F
    db $50 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $e6 ; personality axis $72
    dw MONSTER_CHOPCLOWN ; id 294 ChopClown: picture: monster id
    db SKILL_BOUNCE ; skill 1
    db SKILL_PANIDANCE ; skill 2
    db SKILL_DODGE ; skill 3
    db $ff ; skill 4
    dw 7513 ; EXP
    db $06 ; join-chance class
    db $2d ; level
    dw 210 ; base HP
    dw 269 ; base MP
    dw 244 ; base ATK
    dw 175 ; base DEF
    dw 349 ; base AGL
    dw 920 ; base INT
    db $32 ; personality axis $6F
    db $c8 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $e6 ; personality axis $72
    dw MONSTER_MUMMY ; id 295 Mummy: picture: monster id
    db SKILL_REVIVE ; skill 1
    db SKILL_BAZOOCALL ; skill 2
    db SKILL_MEDITATE ; skill 3
    db $ff ; skill 4
    dw 7462 ; EXP
    db $05 ; join-chance class
    db $2c ; level
    dw 275 ; base HP
    dw 201 ; base MP
    dw 259 ; base ATK
    dw 245 ; base DEF
    dw 213 ; base AGL
    dw 520 ; base INT
    db $14 ; personality axis $6F
    db $28 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $e6 ; personality axis $72
    dw MONSTER_MADSPIRIT ; id 296 MadSpirit: picture: monster id
    db SKILL_DEFEAT ; skill 1
    db SKILL_YELLHELP ; skill 2
    db SKILL_ULTRADOWN ; skill 3
    db $ff ; skill 4
    dw 7329 ; EXP
    db $06 ; join-chance class
    db $2d ; level
    dw 201 ; base HP
    dw 269 ; base MP
    dw 279 ; base ATK
    dw 269 ; base DEF
    dw 215 ; base AGL
    dw 903 ; base INT
    db $8c ; personality axis $6F
    db $0a ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $e6 ; personality axis $72
    dw MONSTER_POMPOMBOM ; id 297 PomPomBom: picture: monster id
    db SKILL_FIREBOLT ; skill 1
    db SKILL_SPEEDUP ; skill 2
    db SKILL_IMITATE ; skill 3
    db $ff ; skill 4
    dw 7129 ; EXP
    db $05 ; join-chance class
    db $2b ; level
    dw 294 ; base HP
    dw 269 ; base MP
    dw 231 ; base ATK
    dw 317 ; base DEF
    dw 213 ; base AGL
    dw 914 ; base INT
    db $50 ; personality axis $6F
    db $64 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $e6 ; personality axis $72
    dw MONSTER_BOMBCRAG ; id 298 BombCrag: picture: monster id
    db SKILL_SACRIFICE ; skill 1
    db SKILL_FAREWELL ; skill 2
    db SKILL_STRONGD ; skill 3
    db $ff ; skill 4
    dw 7010 ; EXP
    db $05 ; join-chance class
    db $2c ; level
    dw 279 ; base HP
    dw 171 ; base MP
    dw 201 ; base ATK
    dw 244 ; base DEF
    dw 56 ; base AGL
    dw 924 ; base INT
    db $32 ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $e6 ; personality axis $72
    dw MONSTER_OCTORAID ; id 299 Octoraid: picture: monster id
    db SKILL_BEDRAGON ; skill 1
    db SKILL_POISONHIT ; skill 2
    db SKILL_RAINSLASH ; skill 3
    db $ff ; skill 4
    dw 7217 ; EXP
    db $06 ; join-chance class
    db $2e ; level
    dw 324 ; base HP
    dw 249 ; base MP
    dw 336 ; base ATK
    dw 312 ; base DEF
    dw 474 ; base AGL
    dw 453 ; base INT
    db $c8 ; personality axis $6F
    db $8c ; personality axis $70
    db $64 ; byte 24 ($71)
    db $e6 ; personality axis $72
    dw MONSTER_ANDREAL ; id 300 Andreal: picture: monster id
    db SKILL_STOPSPELL ; skill 1
    db SKILL_WHITEFIRE ; skill 2
    db SKILL_STORMWIND ; skill 3
    db $ff ; skill 4
    dw 13197 ; EXP
    db $06 ; join-chance class
    db $31 ; level
    dw 357 ; base HP
    dw 304 ; base MP
    dw 214 ; base ATK
    dw 251 ; base DEF
    dw 306 ; base AGL
    dw 929 ; base INT
    db $c8 ; personality axis $6F
    db $14 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $f0 ; personality axis $72
    dw MONSTER_GREATDRAK ; id 301 GreatDrak: picture: monster id
    db SKILL_INFERMOST ; skill 1
    db SKILL_VACUUM ; skill 2
    db SKILL_MULTICUT ; skill 3
    db $ff ; skill 4
    dw 13267 ; EXP
    db $06 ; join-chance class
    db $30 ; level
    dw 289 ; base HP
    dw 116 ; base MP
    dw 374 ; base ATK
    dw 342 ; base DEF
    dw 459 ; base AGL
    dw 953 ; base INT
    db $be ; personality axis $6F
    db $c8 ; personality axis $70
    db $0a ; byte 24 ($71)
    db $f0 ; personality axis $72
    dw MONSTER_TRUMPETER ; id 302 Trumpeter: picture: monster id
    db SKILL_VACUUM ; skill 1
    db SKILL_CHARGEUP ; skill 2
    db SKILL_STRONGD ; skill 3
    db SKILL_MEDITATE ; skill 4
    dw 14080 ; EXP
    db $06 ; join-chance class
    db $31 ; level
    dw 251 ; base HP
    dw 181 ; base MP
    dw 357 ; base ATK
    dw 261 ; base DEF
    dw 353 ; base AGL
    dw 574 ; base INT
    db $c8 ; personality axis $6F
    db $d2 ; personality axis $70
    db $5a ; byte 24 ($71)
    db $f0 ; personality axis $72
    dw MONSTER_PROTOMECH ; id 303 ProtoMech: picture: monster id
    db SKILL_HEALUS ; skill 1
    db SKILL_MAGICWALL ; skill 2
    db SKILL_BIRDBLOW ; skill 3
    db SKILL_SUCKALL ; skill 4
    dw 13594 ; EXP
    db $06 ; join-chance class
    db $31 ; level
    dw 210 ; base HP
    dw 161 ; base MP
    dw 248 ; base ATK
    dw 185 ; base DEF
    dw 306 ; base AGL
    dw 677 ; base INT
    db $c8 ; personality axis $6F
    db $96 ; personality axis $70
    db $d2 ; byte 24 ($71)
    db $f0 ; personality axis $72
    dw MONSTER_ARMORPION ; id 304 Armorpion: picture: monster id
    db SKILL_DEFENSE ; skill 1
    db SKILL_POISONAIR ; skill 2
    db SKILL_BLADED ; skill 3
    db $ff ; skill 4
    dw 14249 ; EXP
    db $06 ; join-chance class
    db $34 ; level
    dw 256 ; base HP
    dw 268 ; base MP
    dw 369 ; base ATK
    dw 312 ; base DEF
    dw 434 ; base AGL
    dw 902 ; base INT
    db $64 ; personality axis $6F
    db $c8 ; personality axis $70
    db $5a ; byte 24 ($71)
    db $f0 ; personality axis $72
    dw MONSTER_DIGSTER ; id 305 Digster: picture: monster id
    db SKILL_THORDAIN ; skill 1
    db SKILL_POISONHIT ; skill 2
    db SKILL_GEYSER ; skill 3
    db $ff ; skill 4
    dw 14210 ; EXP
    db $06 ; join-chance class
    db $31 ; level
    dw 374 ; base HP
    dw 173 ; base MP
    dw 214 ; base ATK
    dw 373 ; base DEF
    dw 150 ; base AGL
    dw 941 ; base INT
    db $b4 ; personality axis $6F
    db $28 ; personality axis $70
    db $32 ; byte 24 ($71)
    db $f0 ; personality axis $72
    dw MONSTER_BOSSTROLL ; id 306 BossTroll: picture: monster id
    db SKILL_TWINHITS ; skill 1
    db SKILL_ROCKTHROW ; skill 2
    db SKILL_QUADHITS ; skill 3
    db $ff ; skill 4
    dw 13921 ; EXP
    db $06 ; join-chance class
    db $31 ; level
    dw 399 ; base HP
    dw 173 ; base MP
    dw 334 ; base ATK
    dw 256 ; base DEF
    dw 229 ; base AGL
    dw 350 ; base INT
    db $28 ; personality axis $6F
    db $0a ; personality axis $70
    db $be ; byte 24 ($71)
    db $f0 ; personality axis $72
    dw MONSTER_MADKNIGHT ; id 307 MadKnight: picture: monster id
    db SKILL_HELLBLAST ; skill 1
    db SKILL_CURSE ; skill 2
    db SKILL_THICKFOG ; skill 3
    db $ff ; skill 4
    dw 13659 ; EXP
    db $06 ; join-chance class
    db $33 ; level
    dw 251 ; base HP
    dw 274 ; base MP
    dw 346 ; base ATK
    dw 268 ; base DEF
    dw 247 ; base AGL
    dw 922 ; base INT
    db $32 ; personality axis $6F
    db $c8 ; personality axis $70
    db $32 ; byte 24 ($71)
    db $f0 ; personality axis $72
    dw MONSTER_OGRE ; id 308 Ogre: picture: monster id
    db SKILL_HEALALL ; skill 1
    db SKILL_WHITEFIRE ; skill 2
    db SKILL_WHITEAIR ; skill 3
    db $ff ; skill 4
    dw 13225 ; EXP
    db $06 ; join-chance class
    db $30 ; level
    dw 292 ; base HP
    dw 247 ; base MP
    dw 221 ; base ATK
    dw 284 ; base DEF
    dw 327 ; base AGL
    dw 603 ; base INT
    db $be ; personality axis $6F
    db $50 ; personality axis $70
    db $14 ; byte 24 ($71)
    db $f0 ; personality axis $72
    dw MONSTER_DEADNOBLE ; id 309 DeadNoble: picture: monster id
    db SKILL_CHANCE ; skill 1
    db SKILL_FOCUS ; skill 2
    db SKILL_LIFESONG ; skill 3
    db $ff ; skill 4
    dw 13451 ; EXP
    db $06 ; join-chance class
    db $31 ; level
    dw 357 ; base HP
    dw 120 ; base MP
    dw 377 ; base ATK
    dw 224 ; base DEF
    dw 434 ; base AGL
    dw 940 ; base INT
    db $14 ; personality axis $6F
    db $c8 ; personality axis $70
    db $5a ; byte 24 ($71)
    db $f0 ; personality axis $72
    dw MONSTER_SKELETOR ; id 310 Skeletor: picture: monster id
    db SKILL_BLAZEMOST ; skill 1
    db SKILL_YELLHELP ; skill 2
    db SKILL_PALSYAIR ; skill 3
    db $ff ; skill 4
    dw 14020 ; EXP
    db $06 ; join-chance class
    db $33 ; level
    dw 210 ; base HP
    dw 223 ; base MP
    dw 256 ; base ATK
    dw 217 ; base DEF
    dw 189 ; base AGL
    dw 713 ; base INT
    db $1e ; personality axis $6F
    db $aa ; personality axis $70
    db $5a ; byte 24 ($71)
    db $f0 ; personality axis $72
    dw MONSTER_STONEMAN ; id 311 StoneMan: picture: monster id
    db SKILL_HEALUSALL ; skill 1
    db SKILL_QUADHITS ; skill 2
    db SKILL_IMITATE ; skill 3
    db $ff ; skill 4
    dw 13296 ; EXP
    db $06 ; join-chance class
    db $31 ; level
    dw 381 ; base HP
    dw 155 ; base MP
    dw 286 ; base ATK
    dw 188 ; base DEF
    dw 95 ; base AGL
    dw 783 ; base INT
    db $96 ; personality axis $6F
    db $82 ; personality axis $70
    db $6e ; byte 24 ($71)
    db $f0 ; personality axis $72
    dw MONSTER_FISHRIDER ; id 312 FishRider: picture: monster id
    db SKILL_EXPLODET ; skill 1
    db SKILL_SLEEPALL ; skill 2
    db SKILL_MOUTHSHUT ; skill 3
    db $ff ; skill 4
    dw 13219 ; EXP
    db $06 ; join-chance class
    db $31 ; level
    dw 346 ; base HP
    dw 214 ; base MP
    dw 220 ; base ATK
    dw 156 ; base DEF
    dw 180 ; base AGL
    dw 574 ; base INT
    db $96 ; personality axis $6F
    db $8c ; personality axis $70
    db $3c ; byte 24 ($71)
    db $f0 ; personality axis $72
    dw MONSTER_AXESHARK ; id 313 AxeShark: picture: monster id
    db SKILL_BARRIER ; skill 1
    db SKILL_GIGASLASH ; skill 2
    db SKILL_AQUAWALL ; skill 3
    db $ff ; skill 4
    dw 14506 ; EXP
    db $06 ; join-chance class
    db $31 ; level
    dw 298 ; base HP
    dw 254 ; base MP
    dw 385 ; base ATK
    dw 342 ; base DEF
    dw 326 ; base AGL
    dw 590 ; base INT
    db $c8 ; personality axis $6F
    db $14 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $f0 ; personality axis $72
    dw MONSTER_AQUADON ; id 314 Aquadon: picture: monster id
    db SKILL_FAREWELL ; skill 1
    db SKILL_BIGBANG ; skill 2
    db SKILL_HUSTLE ; skill 3
    db SKILL_DANCESHUT ; skill 4
    dw 13904 ; EXP
    db $06 ; join-chance class
    db $31 ; level
    dw 399 ; base HP
    dw 268 ; base MP
    dw 327 ; base ATK
    dw 173 ; base DEF
    dw 159 ; base AGL
    dw 913 ; base INT
    db $aa ; personality axis $6F
    db $14 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $f0 ; personality axis $72
    dw MONSTER_DIGONG ; id 315 Digong: picture: monster id
    db SKILL_BLIZZARD ; skill 1
    db SKILL_TIDALWAVE ; skill 2
    db SKILL_EVILSLASH ; skill 3
    db $ff ; skill 4
    dw 13255 ; EXP
    db $06 ; join-chance class
    db $34 ; level
    dw 312 ; base HP
    dw 346 ; base MP
    dw 350 ; base ATK
    dw 166 ; base DEF
    dw 109 ; base AGL
    dw 927 ; base INT
    db $96 ; personality axis $6F
    db $32 ; personality axis $70
    db $5a ; byte 24 ($71)
    db $f0 ; personality axis $72
    dw MONSTER_METALKING ; id 316 MetalKing: picture: monster id
    db SKILL_REVIVE ; skill 1
    db SKILL_SURROUND ; skill 2
    db SKILL_PARALYZE ; skill 3
    db SKILL_DODGE ; skill 4
    dw 2889 ; EXP
    db $06 ; join-chance class
    db $36 ; level
    dw 40 ; base HP
    dw 70 ; base MP
    dw 280 ; base ATK
    dw 757 ; base DEF
    dw 999 ; base AGL
    dw 999 ; base INT
    db $14 ; personality axis $6F
    db $dc ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_SERPENTIA ; id 317 Serpentia: picture: monster id
    db SKILL_FIREBOLT ; skill 1
    db SKILL_QUADHITS ; skill 2
    db SKILL_RADIANT ; skill 3
    db SKILL_WARCRY ; skill 4
    dw 18451 ; EXP
    db $06 ; join-chance class
    db $37 ; level
    dw 382 ; base HP
    dw 150 ; base MP
    dw 356 ; base ATK
    dw 277 ; base DEF
    dw 350 ; base AGL
    dw 946 ; base INT
    db $c8 ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_COATOL ; id 318 Coatol: picture: monster id
    db SKILL_STOPSPELL ; skill 1
    db SKILL_FIRESLASH ; skill 2
    db SKILL_VACUSLASH ; skill 3
    db SKILL_GUARDIAN ; skill 4
    dw 16937 ; EXP
    db $06 ; join-chance class
    db $37 ; level
    dw 425 ; base HP
    dw 273 ; base MP
    dw 294 ; base ATK
    dw 199 ; base DEF
    dw 225 ; base AGL
    dw 910 ; base INT
    db $c8 ; personality axis $6F
    db $28 ; personality axis $70
    db $d2 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_OROCHI ; id 319 Orochi: picture: monster id
    db SKILL_MEGAMAGIC ; skill 1
    db SKILL_ROCKTHROW ; skill 2
    db SKILL_RAMMING ; skill 3
    db SKILL_SUCKAIR ; skill 4
    dw 18549 ; EXP
    db $06 ; join-chance class
    db $39 ; level
    dw 442 ; base HP
    dw 186 ; base MP
    dw 358 ; base ATK
    dw 182 ; base DEF
    dw 180 ; base AGL
    dw 926 ; base INT
    db $aa ; personality axis $6F
    db $32 ; personality axis $70
    db $b4 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_BATTLEREX ; id 320 BattleRex: picture: monster id
    db SKILL_EXPLODET ; skill 1
    db SKILL_SLEEPALL ; skill 2
    db SKILL_LUREDANCE ; skill 3
    db SKILL_MEDITATE ; skill 4
    dw 16598 ; EXP
    db $06 ; join-chance class
    db $39 ; level
    dw 356 ; base HP
    dw 34 ; base MP
    dw 348 ; base ATK
    dw 194 ; base DEF
    dw 222 ; base AGL
    dw 916 ; base INT
    db $64 ; personality axis $6F
    db $96 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_WHIPBIRD ; id 321 WhipBird: picture: monster id
    db SKILL_HEALALL ; skill 1
    db SKILL_HELLBLAST ; skill 2
    db SKILL_POISONAIR ; skill 3
    db SKILL_SANDSTORM ; skill 4
    dw 17840 ; EXP
    db $06 ; join-chance class
    db $39 ; level
    dw 535 ; base HP
    dw 239 ; base MP
    dw 361 ; base ATK
    dw 195 ; base DEF
    dw 199 ; base AGL
    dw 949 ; base INT
    db $be ; personality axis $6F
    db $6e ; personality axis $70
    db $32 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_SHANTAK ; id 322 Shantak: picture: monster id
    db SKILL_INFERMOST ; skill 1
    db SKILL_POISONHIT ; skill 2
    db SKILL_MULTICUT ; skill 3
    db $ff ; skill 4
    dw 19325 ; EXP
    db $06 ; join-chance class
    db $39 ; level
    dw 442 ; base HP
    dw 299 ; base MP
    dw 290 ; base ATK
    dw 190 ; base DEF
    dw 331 ; base AGL
    dw 936 ; base INT
    db $c8 ; personality axis $6F
    db $78 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_ROSEVINE ; id 323 Rosevine: picture: monster id
    db SKILL_SPEEDUP ; skill 1
    db SKILL_ROCKTHROW ; skill 2
    db SKILL_HUSTLE ; skill 3
    db SKILL_IMITATE ; skill 4
    dw 18410 ; EXP
    db $06 ; join-chance class
    db $39 ; level
    dw 431 ; base HP
    dw 48 ; base MP
    dw 347 ; base ATK
    dw 172 ; base DEF
    dw 226 ; base AGL
    dw 969 ; base INT
    db $64 ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_GRENDAL ; id 324 Grendal: picture: monster id
    db SKILL_SACRIFICE ; skill 1
    db SKILL_VACUUM ; skill 2
    db SKILL_EVILSLASH ; skill 3
    db SKILL_TWINSLASH ; skill 4
    dw 18743 ; EXP
    db $06 ; join-chance class
    db $37 ; level
    dw 366 ; base HP
    dw 115 ; base MP
    dw 369 ; base ATK
    dw 212 ; base DEF
    dw 116 ; base AGL
    dw 926 ; base INT
    db $be ; personality axis $6F
    db $c8 ; personality axis $70
    db $1e ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_AKUBAR ; id 325 Akubar: picture: monster id
    db SKILL_BLAZEMOST ; skill 1
    db SKILL_TIDALWAVE ; skill 2
    db SKILL_PSYCHEUP ; skill 3
    db $ff ; skill 4
    dw 17743 ; EXP
    db $06 ; join-chance class
    db $38 ; level
    dw 442 ; base HP
    dw 676 ; base MP
    dw 356 ; base ATK
    dw 182 ; base DEF
    dw 225 ; base AGL
    dw 948 ; base INT
    db $c8 ; personality axis $6F
    db $0a ; personality axis $70
    db $28 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_JAMIRUS ; id 326 Jamirus: picture: monster id
    db SKILL_HEALALL ; skill 1
    db SKILL_MULTICUT ; skill 2
    db SKILL_PALSYAIR ; skill 3
    db $ff ; skill 4
    dw 16928 ; EXP
    db $06 ; join-chance class
    db $39 ; level
    dw 442 ; base HP
    dw 299 ; base MP
    dw 352 ; base ATK
    dw 221 ; base DEF
    dw 309 ; base AGL
    dw 926 ; base INT
    db $64 ; personality axis $6F
    db $96 ; personality axis $70
    db $32 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_LAMPGENIE ; id 327 LampGenie: picture: monster id
    db SKILL_EXPLODET ; skill 1
    db SKILL_MAGICWALL ; skill 2
    db SKILL_ROBDANCE ; skill 3
    db SKILL_SEALPRAY ; skill 4
    dw 17469 ; EXP
    db $06 ; join-chance class
    db $34 ; level
    dw 266 ; base HP
    dw 361 ; base MP
    dw 310 ; base ATK
    dw 203 ; base DEF
    dw 170 ; base AGL
    dw 920 ; base INT
    db $0a ; personality axis $6F
    db $c8 ; personality axis $70
    db $a0 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_WHITEKING ; id 328 WhiteKing: picture: monster id
    db SKILL_TWINHITS ; skill 1
    db SKILL_CHANCE ; skill 2
    db SKILL_ULTRADOWN ; skill 3
    db $ff ; skill 4
    dw 19170 ; EXP
    db $06 ; join-chance class
    db $35 ; level
    dw 298 ; base HP
    dw 100 ; base MP
    dw 283 ; base ATK
    dw 194 ; base DEF
    dw 150 ; base AGL
    dw 950 ; base INT
    db $0a ; personality axis $6F
    db $dc ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_NITERICH ; id 329 Niterich: picture: monster id
    db SKILL_WHITEFIRE ; skill 1
    db SKILL_QUADHITS ; skill 2
    db SKILL_DEMAGIC ; skill 3
    db $ff ; skill 4
    dw 15298 ; EXP
    db $06 ; join-chance class
    db $39 ; level
    dw 356 ; base HP
    dw 382 ; base MP
    dw 425 ; base ATK
    dw 389 ; base DEF
    dw 470 ; base AGL
    dw 960 ; base INT
    db $c8 ; personality axis $6F
    db $8c ; personality axis $70
    db $64 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_KINGSQUID ; id 330 KingSquid: picture: monster id
    db SKILL_HEALUSALL ; skill 1
    db SKILL_TIDALWAVE ; skill 2
    db SKILL_SIDESTEP ; skill 3
    db SKILL_SUCKALL ; skill 4
    dw 18642 ; EXP
    db $06 ; join-chance class
    db $36 ; level
    dw 416 ; base HP
    dw 90 ; base MP
    dw 380 ; base ATK
    dw 145 ; base DEF
    dw 110 ; base AGL
    dw 924 ; base INT
    db $c8 ; personality axis $6F
    db $32 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_GRAKOS ; id 331 Grakos: picture: monster id
    db SKILL_BLIZZARD ; skill 1
    db SKILL_CHARGEUP ; skill 2
    db SKILL_DODGE ; skill 3
    db $ff ; skill 4
    dw 17499 ; EXP
    db $06 ; join-chance class
    db $36 ; level
    dw 389 ; base HP
    dw 356 ; base MP
    dw 407 ; base ATK
    dw 266 ; base DEF
    dw 309 ; base AGL
    dw 920 ; base INT
    db $c8 ; personality axis $6F
    db $aa ; personality axis $70
    db $8c ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_SLABBIT ; id 332 Slabbit: picture: monster id
    db SKILL_ODDDANCE ; skill 1
    db SKILL_SIDESTEP ; skill 2
    db SKILL_LEGSWEEP ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $07 ; level
    dw 38 ; base HP
    dw 20 ; base MP
    dw 39 ; base ATK
    dw 20 ; base DEF
    dw 86 ; base AGL
    dw 127 ; base INT
    db $78 ; personality axis $6F
    db $8c ; personality axis $70
    db $64 ; byte 24 ($71)
    db $5a ; personality axis $72
    dw MONSTER_COILBIRD ; id 333 CoilBird: picture: monster id
    db SKILL_INFERNOS ; skill 1
    db SKILL_NUMBOFF ; skill 2
    db SKILL_SUCKALL ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $09 ; level
    dw 47 ; base HP
    dw 42 ; base MP
    dw 42 ; base ATK
    dw 48 ; base DEF
    dw 69 ; base AGL
    dw 80 ; base INT
    db $82 ; personality axis $6F
    db $c8 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $5a ; personality axis $72
    dw MONSTER_FAIRYDRAK ; id 334 FairyDrak: picture: monster id
    db SKILL_SURROUND ; skill 1
    db SKILL_SLEEPAIR ; skill 2
    db SKILL_LUSHLICKS ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $10 ; level
    dw 61 ; base HP
    dw 70 ; base MP
    dw 75 ; base ATK
    dw 75 ; base DEF
    dw 108 ; base AGL
    dw 134 ; base INT
    db $c8 ; personality axis $6F
    db $d2 ; personality axis $70
    db $14 ; byte 24 ($71)
    db $8c ; personality axis $72
    dw MONSTER_ONIONO ; id 335 Oniono: picture: monster id
    db SKILL_ROBMAGIC ; skill 1
    db SKILL_CHARGEUP ; skill 2
    db SKILL_SLEEPAIR ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $0f ; level
    dw 83 ; base HP
    dw 120 ; base MP
    dw 71 ; base ATK
    dw 42 ; base DEF
    dw 157 ; base AGL
    dw 240 ; base INT
    db $b4 ; personality axis $6F
    db $78 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $8c ; personality axis $72
    dw MONSTER_EVILSEED ; id 336 EvilSeed: picture: monster id
    db SKILL_CLEANCUT ; skill 1
    db SKILL_PARALYZE ; skill 2
    db SKILL_RADIANT ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $11 ; level
    dw 60 ; base HP
    dw 50 ; base MP
    dw 45 ; base ATK
    dw 70 ; base DEF
    dw 53 ; base AGL
    dw 400 ; base INT
    db $28 ; personality axis $6F
    db $d2 ; personality axis $70
    db $3c ; byte 24 ($71)
    db $8c ; personality axis $72
    dw MONSTER_MADCANDLE ; id 337 MadCandle: picture: monster id
    db SKILL_BLAZE ; skill 1
    db SKILL_PSYCHEUP ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $11 ; level
    dw 63 ; base HP
    dw 52 ; base MP
    dw 80 ; base ATK
    dw 85 ; base DEF
    dw 102 ; base AGL
    dw 190 ; base INT
    db $c8 ; personality axis $6F
    db $64 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $8c ; personality axis $72
    dw MONSTER_DRAGONKID ; id 338 DragonKid: picture: monster id
    db SKILL_BLAZEAIR ; skill 1
    db SKILL_SLEEPAIR ; skill 2
    db SKILL_DODGE ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $19 ; level
    dw 62 ; base HP
    dw 135 ; base MP
    dw 111 ; base ATK
    dw 99 ; base DEF
    dw 115 ; base AGL
    dw 290 ; base INT
    db $78 ; personality axis $6F
    db $82 ; personality axis $70
    db $d2 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_DUCKKITE ; id 339 DuckKite: picture: monster id
    db SKILL_SLEEP ; skill 1
    db SKILL_PANICALL ; skill 2
    db SKILL_CURSE ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $19 ; level
    dw 81 ; base HP
    dw 81 ; base MP
    dw 143 ; base ATK
    dw 118 ; base DEF
    dw 182 ; base AGL
    dw 190 ; base INT
    db $c8 ; personality axis $6F
    db $14 ; personality axis $70
    db $aa ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_WINGTREE ; id 340 WingTree: picture: monster id
    db SKILL_FAREWELL ; skill 1
    db SKILL_WINDBEAST ; skill 2
    db SKILL_ZOMBIECUT ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $18 ; level
    dw 113 ; base HP
    dw 160 ; base MP
    dw 155 ; base ATK
    dw 87 ; base DEF
    dw 98 ; base AGL
    dw 187 ; base INT
    db $6e ; personality axis $6F
    db $78 ; personality axis $70
    db $82 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_GIANTSLUG ; id 341 GiantSlug: picture: monster id
    db SKILL_WATERSHOT ; skill 1
    db SKILL_LUSHLICKS ; skill 2
    db SKILL_DODGE ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $1a ; level
    dw 84 ; base HP
    dw 79 ; base MP
    dw 139 ; base ATK
    dw 98 ; base DEF
    dw 88 ; base AGL
    dw 197 ; base INT
    db $96 ; personality axis $6F
    db $d2 ; personality axis $70
    db $0a ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_GOPHECADA ; id 342 Gophecada: picture: monster id
    db SKILL_BEAT ; skill 1
    db SKILL_MAGICBACK ; skill 2
    db SKILL_CALLHELP ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $15 ; level
    dw 141 ; base HP
    dw 63 ; base MP
    dw 123 ; base ATK
    dw 97 ; base DEF
    dw 93 ; base AGL
    dw 160 ; base INT
    db $c8 ; personality axis $6F
    db $1e ; personality axis $70
    db $28 ; byte 24 ($71)
    db $aa ; personality axis $72
    dw MONSTER_ROTRAVEN ; id 343 RotRaven: picture: monster id
    db SKILL_LIGHTNING ; skill 1
    db SKILL_BOLTSLASH ; skill 2
    db SKILL_KAMIKAZE ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $19 ; level
    dw 111 ; base HP
    dw 76 ; base MP
    dw 118 ; base ATK
    dw 91 ; base DEF
    dw 152 ; base AGL
    dw 377 ; base INT
    db $28 ; personality axis $6F
    db $d2 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_CHAMELGON ; id 344 Chamelgon: picture: monster id
    db SKILL_PANICALL ; skill 1
    db SKILL_PARALYZE ; skill 2
    db SKILL_PALSYAIR ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $21 ; level
    dw 141 ; base HP
    dw 205 ; base MP
    dw 111 ; base ATK
    dw 146 ; base DEF
    dw 126 ; base AGL
    dw 347 ; base INT
    db $5a ; personality axis $6F
    db $c8 ; personality axis $70
    db $d2 ; byte 24 ($71)
    db $d2 ; personality axis $72
    dw MONSTER_MADPECKER ; id 345 MadPecker: picture: monster id
    db SKILL_INFERMORE ; skill 1
    db SKILL_DEFENSE ; skill 2
    db SKILL_VACUSLASH ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $23 ; level
    dw 189 ; base HP
    dw 78 ; base MP
    dw 202 ; base ATK
    dw 119 ; base DEF
    dw 196 ; base AGL
    dw 360 ; base INT
    db $c8 ; personality axis $6F
    db $6e ; personality axis $70
    db $28 ; byte 24 ($71)
    db $dc ; personality axis $72
    dw MONSTER_MADPLANT ; id 346 MadPlant: picture: monster id
    db SKILL_DEFENSE ; skill 1
    db SKILL_SLOWALL ; skill 2
    db SKILL_POISONAIR ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $23 ; level
    dw 219 ; base HP
    dw 277 ; base MP
    dw 119 ; base ATK
    dw 98 ; base DEF
    dw 182 ; base AGL
    dw 746 ; base INT
    db $50 ; personality axis $6F
    db $32 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $dc ; personality axis $72
    dw MONSTER_FACETREE ; id 347 FaceTree: picture: monster id
    db SKILL_STOPSPELL ; skill 1
    db SKILL_CURSE ; skill 2
    db SKILL_ROBDANCE ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $23 ; level
    dw 194 ; base HP
    dw 202 ; base MP
    dw 119 ; base ATK
    dw 100 ; base DEF
    dw 99 ; base AGL
    dw 497 ; base INT
    db $14 ; personality axis $6F
    db $c8 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $dc ; personality axis $72
    dw MONSTER_BEANMAN ; id 348 BeanMan: picture: monster id
    db SKILL_TWINHITS ; skill 1
    db SKILL_RAINSLASH ; skill 2
    db SKILL_TWINSLASH ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $21 ; level
    dw 141 ; base HP
    dw 200 ; base MP
    dw 175 ; base ATK
    dw 111 ; base DEF
    dw 145 ; base AGL
    dw 567 ; base INT
    db $1e ; personality axis $6F
    db $b4 ; personality axis $70
    db $82 ; byte 24 ($71)
    db $d2 ; personality axis $72
    dw MONSTER_CATAPILA ; id 349 Catapila: picture: monster id
    db SKILL_INCREASE ; skill 1
    db SKILL_POISONHIT ; skill 2
    db SKILL_THICKFOG ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $24 ; level
    dw 111 ; base HP
    dw 111 ; base MP
    dw 124 ; base ATK
    dw 127 ; base DEF
    dw 177 ; base AGL
    dw 653 ; base INT
    db $6e ; personality axis $6F
    db $c8 ; personality axis $70
    db $0a ; byte 24 ($71)
    db $dc ; personality axis $72
    dw MONSTER_FACER ; id 350 Facer: picture: monster id
    db SKILL_INFERMORE ; skill 1
    db SKILL_SACRIFICE ; skill 2
    db SKILL_LIFESONG ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $23 ; level
    dw 114 ; base HP
    dw 207 ; base MP
    dw 119 ; base ATK
    dw 164 ; base DEF
    dw 123 ; base AGL
    dw 537 ; base INT
    db $3c ; personality axis $6F
    db $be ; personality axis $70
    db $8c ; byte 24 ($71)
    db $dc ; personality axis $72
    dw MONSTER_VOODOLL ; id 351 Voodoll: picture: monster id
    db SKILL_DEFENSE ; skill 1
    db SKILL_SURROUND ; skill 2
    db SKILL_PANICALL ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $21 ; level
    dw 141 ; base HP
    dw 141 ; base MP
    dw 132 ; base ATK
    dw 145 ; base DEF
    dw 132 ; base AGL
    dw 470 ; base INT
    db $0a ; personality axis $6F
    db $32 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $dc ; personality axis $72
    dw MONSTER_GOLEM ; id 352 Golem: picture: monster id
    db SKILL_CHARGEUP ; skill 1
    db SKILL_PSYCHEUP ; skill 2
    db SKILL_MEDITATE ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $23 ; level
    dw 249 ; base HP
    dw 114 ; base MP
    dw 194 ; base ATK
    dw 112 ; base DEF
    dw 96 ; base AGL
    dw 657 ; base INT
    db $a0 ; personality axis $6F
    db $a0 ; personality axis $70
    db $a0 ; byte 24 ($71)
    db $dc ; personality axis $72
    dw MONSTER_ROGUEWAVE ; id 353 RogueWave: picture: monster id
    db SKILL_WATERSHOT ; skill 1
    db SKILL_POISONAIR ; skill 2
    db SKILL_AQUAWALL ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $23 ; level
    dw 119 ; base HP
    dw 78 ; base MP
    dw 224 ; base ATK
    dw 136 ; base DEF
    dw 196 ; base AGL
    dw 537 ; base INT
    db $32 ; personality axis $6F
    db $c8 ; personality axis $70
    db $a0 ; byte 24 ($71)
    db $dc ; personality axis $72
    dw MONSTER_BOXSLIME ; id 354 BoxSlime: picture: monster id
    db SKILL_BLAZEMOST ; skill 1
    db SKILL_INCREASE ; skill 2
    db SKILL_RAMMING ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $2e ; level
    dw 175 ; base HP
    dw 115 ; base MP
    dw 225 ; base ATK
    dw 186 ; base DEF
    dw 179 ; base AGL
    dw 633 ; base INT
    db $c8 ; personality axis $6F
    db $32 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $f0 ; personality axis $72
    dw MONSTER_SLIMEBORG ; id 355 SlimeBorg: picture: monster id
    db SKILL_WHITEFIRE ; skill 1
    db SKILL_LIGHTNING ; skill 2
    db SKILL_RAINSLASH ; skill 3
    db SKILL_BLADED ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $2d ; level
    dw 283 ; base HP
    dw 165 ; base MP
    dw 233 ; base ATK
    dw 199 ; base DEF
    dw 227 ; base AGL
    dw 641 ; base INT
    db $c8 ; personality axis $6F
    db $82 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $f0 ; personality axis $72
    dw MONSTER_DARKHORN ; id 356 DarkHorn: picture: monster id
    db SKILL_SLEEPALL ; skill 1
    db SKILL_STOPSPELL ; skill 2
    db SKILL_PSYCHEUP ; skill 3
    db SKILL_RAMMING ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $2d ; level
    dw 205 ; base HP
    dw 141 ; base MP
    dw 235 ; base ATK
    dw 183 ; base DEF
    dw 190 ; base AGL
    dw 960 ; base INT
    db $c8 ; personality axis $6F
    db $64 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $f0 ; personality axis $72
    dw MONSTER_MANEATER ; id 357 ManEater: picture: monster id
    db SKILL_DRAKSLASH ; skill 1
    db SKILL_PSYCHEUP ; skill 2
    db SKILL_PALSYAIR ; skill 3
    db SKILL_PANIDANCE ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $2c ; level
    dw 186 ; base HP
    dw 249 ; base MP
    dw 199 ; base ATK
    dw 114 ; base DEF
    dw 185 ; base AGL
    dw 720 ; base INT
    db $8c ; personality axis $6F
    db $82 ; personality axis $70
    db $50 ; byte 24 ($71)
    db $f0 ; personality axis $72
    dw MONSTER_SNAPPER ; id 358 Snapper: picture: monster id
    db SKILL_STOPSPELL ; skill 1
    db SKILL_YELLHELP ; skill 2
    db SKILL_RAINSLASH ; skill 3
    db SKILL_KODANCE ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $2e ; level
    dw 203 ; base HP
    dw 195 ; base MP
    dw 236 ; base ATK
    dw 133 ; base DEF
    dw 190 ; base AGL
    dw 580 ; base INT
    db $3c ; personality axis $6F
    db $d2 ; personality axis $70
    db $3c ; byte 24 ($71)
    db $f0 ; personality axis $72
    dw MONSTER_GHOSTREE ; id 359 GhosTree: picture: monster id
    db SKILL_BLIZZARD ; skill 1
    db SKILL_ROBMAGIC ; skill 2
    db SKILL_LUREDANCE ; skill 3
    db SKILL_EERIELITE ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $2d ; level
    dw 150 ; base HP
    dw 130 ; base MP
    dw 238 ; base ATK
    dw 150 ; base DEF
    dw 200 ; base AGL
    dw 983 ; base INT
    db $28 ; personality axis $6F
    db $6e ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $f0 ; personality axis $72
    dw MONSTER_SKULRIDER ; id 360 SkulRider: picture: monster id
    db SKILL_FIRESLASH ; skill 1
    db SKILL_EVILSLASH ; skill 2
    db SKILL_BIGTRIP ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $2c ; level
    dw 187 ; base HP
    dw 156 ; base MP
    dw 218 ; base ATK
    dw 126 ; base DEF
    dw 377 ; base AGL
    dw 830 ; base INT
    db $8c ; personality axis $6F
    db $78 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $f0 ; personality axis $72
    dw MONSTER_GIGANTES ; id 361 Gigantes: picture: monster id
    db SKILL_SLIMEBLOW ; skill 1
    db SKILL_QUADHITS ; skill 2
    db SKILL_CHARGEUP ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $2c ; level
    dw 371 ; base HP
    dw 24 ; base MP
    dw 351 ; base ATK
    dw 96 ; base DEF
    dw 86 ; base AGL
    dw 557 ; base INT
    db $c8 ; personality axis $6F
    db $14 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $f0 ; personality axis $72
    dw MONSTER_SKULPENT ; id 362 Skulpent: picture: monster id
    db SKILL_DEFEAT ; skill 1
    db SKILL_POISONHIT ; skill 2
    db SKILL_DODGE ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $2c ; level
    dw 186 ; base HP
    dw 179 ; base MP
    dw 244 ; base ATK
    dw 204 ; base DEF
    dw 156 ; base AGL
    dw 917 ; base INT
    db $8c ; personality axis $6F
    db $c8 ; personality axis $70
    db $0a ; byte 24 ($71)
    db $f0 ; personality axis $72
    dw MONSTER_AQUARELLA ; id 363 Aquarella: picture: monster id
    db SKILL_BARRIER ; skill 1
    db SKILL_SQUALLHIT ; skill 2
    db SKILL_SUCKAIR ; skill 3
    db SKILL_GEYSER ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $2c ; level
    dw 156 ; base HP
    dw 146 ; base MP
    dw 189 ; base ATK
    dw 154 ; base DEF
    dw 209 ; base AGL
    dw 763 ; base INT
    db $8c ; personality axis $6F
    db $aa ; personality axis $70
    db $14 ; byte 24 ($71)
    db $f0 ; personality axis $72
    dw MONSTER_GOLDSLIME ; id 364 GoldSlime: picture: monster id
    db SKILL_CHANCE ; skill 1
    db SKILL_BIGBANG ; skill 2
    db SKILL_SURGE ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $37 ; level
    dw 123 ; base HP
    dw 843 ; base MP
    dw 230 ; base ATK
    dw 843 ; base DEF
    dw 650 ; base AGL
    dw 999 ; base INT
    db $b4 ; personality axis $6F
    db $c8 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_GRANSLIME ; id 365 GranSlime: picture: monster id
    db SKILL_HEALUS ; skill 1
    db SKILL_FAREWELL ; skill 2
    db SKILL_FOCUS ; skill 3
    db SKILL_DODGE ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $39 ; level
    dw 400 ; base HP
    dw 100 ; base MP
    dw 295 ; base ATK
    dw 151 ; base DEF
    dw 265 ; base AGL
    dw 999 ; base INT
    db $96 ; personality axis $6F
    db $aa ; personality axis $70
    db $3c ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_DIVINEGON ; id 366 Divinegon: picture: monster id
    db SKILL_REVIVE ; skill 1
    db SKILL_HELLBLAST ; skill 2
    db SKILL_WHITEAIR ; skill 3
    db SKILL_MEDITATE ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $38 ; level
    dw 453 ; base HP
    dw 120 ; base MP
    dw 410 ; base ATK
    dw 205 ; base DEF
    dw 240 ; base AGL
    dw 999 ; base INT
    db $d2 ; personality axis $6F
    db $b4 ; personality axis $70
    db $1e ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_KINGLEO ; id 367 KingLeo: picture: monster id
    db SKILL_FIREBOLT ; skill 1
    db SKILL_WHITEFIRE ; skill 2
    db SKILL_WHITEAIR ; skill 3
    db SKILL_QUADHITS ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $37 ; level
    dw 285 ; base HP
    dw 264 ; base MP
    dw 350 ; base ATK
    dw 195 ; base DEF
    dw 254 ; base AGL
    dw 981 ; base INT
    db $c8 ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_RAINHAWK ; id 368 RainHawk: picture: monster id
    db SKILL_MEGAMAGIC ; skill 1
    db SKILL_SURGE ; skill 2
    db SKILL_STRONGD ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $37 ; level
    dw 400 ; base HP
    dw 553 ; base MP
    dw 330 ; base ATK
    dw 210 ; base DEF
    dw 344 ; base AGL
    dw 999 ; base INT
    db $c8 ; personality axis $6F
    db $d2 ; personality axis $70
    db $3c ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_DURRAN ; id 369 Durran: picture: monster id
    db SKILL_VACUUM ; skill 1
    db SKILL_DRAKSLASH ; skill 2
    db SKILL_GIGASLASH ; skill 3
    db SKILL_DEMAGIC ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $37 ; level
    dw 400 ; base HP
    dw 425 ; base MP
    dw 338 ; base ATK
    dw 220 ; base DEF
    dw 454 ; base AGL
    dw 950 ; base INT
    db $3c ; personality axis $6F
    db $c8 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_LAZAMANUS ; id 370 Lazamanus: picture: monster id
    db SKILL_HEALALL ; skill 1
    db SKILL_KODANCE ; skill 2
    db SKILL_LIFEDANCE ; skill 3
    db SKILL_BLADED ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $39 ; level
    dw 425 ; base HP
    dw 40 ; base MP
    dw 310 ; base ATK
    dw 185 ; base DEF
    dw 268 ; base AGL
    dw 980 ; base INT
    db $28 ; personality axis $6F
    db $c8 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_GOLDGOLEM ; id 371 GoldGolem: picture: monster id
    db SKILL_BIGBANG ; skill 1
    db SKILL_DRAKSLASH ; skill 2
    db SKILL_SURGE ; skill 3
    db SKILL_BAZOOCALL ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $37 ; level
    dw 425 ; base HP
    dw 80 ; base MP
    dw 285 ; base ATK
    dw 443 ; base DEF
    dw 254 ; base AGL
    dw 999 ; base INT
    db $c8 ; personality axis $6F
    db $d2 ; personality axis $70
    db $6e ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_PILLOWRAT ; id 372 PillowRat: picture: monster id
    db SKILL_UPPER ; skill 1
    db SKILL_MAGICBACK ; skill 2
    db SKILL_NAPATTACK ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $12 ; level
    dw 88 ; base HP
    dw 92 ; base MP
    dw 127 ; base ATK
    dw 93 ; base DEF
    dw 69 ; base AGL
    dw 383 ; base INT
    db $c8 ; personality axis $6F
    db $c8 ; personality axis $70
    db $50 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_ARMORPEDE ; id 373 ArmorPede: picture: monster id
    db SKILL_BEAT ; skill 1
    db SKILL_STOPSPELL ; skill 2
    db SKILL_TWINSLASH ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $1c ; level
    dw 123 ; base HP
    dw 173 ; base MP
    dw 119 ; base ATK
    dw 166 ; base DEF
    dw 180 ; base AGL
    dw 357 ; base INT
    db $46 ; personality axis $6F
    db $64 ; personality axis $70
    db $d2 ; byte 24 ($71)
    db $aa ; personality axis $72
    dw MONSTER_WILDAPE ; id 374 WildApe: picture: monster id
    db SKILL_FAREWELL ; skill 1
    db SKILL_PANICALL ; skill 2
    db SKILL_BIATTACK ; skill 3
    db SKILL_WARCRY ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $20 ; level
    dw 144 ; base HP
    dw 64 ; base MP
    dw 198 ; base ATK
    dw 79 ; base DEF
    dw 152 ; base AGL
    dw 453 ; base INT
    db $c8 ; personality axis $6F
    db $96 ; personality axis $70
    db $1e ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_CLAWSTER ; id 375 Clawster: picture: monster id
    db SKILL_VIVIFY ; skill 1
    db SKILL_IRONIZE ; skill 2
    db SKILL_CLEANCUT ; skill 3
    db SKILL_KODANCE ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $2a ; level
    dw 230 ; base HP
    dw 274 ; base MP
    dw 226 ; base ATK
    dw 272 ; base DEF
    dw 306 ; base AGL
    dw 753 ; base INT
    db $0a ; personality axis $6F
    db $c8 ; personality axis $70
    db $dc ; byte 24 ($71)
    db $b4 ; personality axis $72
    dw MONSTER_GULPPLE ; id 376 Gulpple: picture: monster id
    db SKILL_HEALUS ; skill 1
    db SKILL_SLEEP ; skill 2
    db SKILL_CHANCE ; skill 3
    db SKILL_AQUAWALL ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $25 ; level
    dw 166 ; base HP
    dw 159 ; base MP
    dw 214 ; base ATK
    dw 212 ; base DEF
    dw 155 ; base AGL
    dw 747 ; base INT
    db $d2 ; personality axis $6F
    db $28 ; personality axis $70
    db $d2 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_DARCK ; id 377 Darck: picture: monster id
    db SKILL_FIREBOLT ; skill 1
    db SKILL_GIGASLASH ; skill 2
    db SKILL_DEMAGIC ; skill 3
    db SKILL_PANICALL_AD ; skill 4
    dw 59630 ; EXP
    db $07 ; join-chance class
    db $2c ; level
    dw 4000 ; base HP
    dw 235 ; base MP
    dw 350 ; base ATK
    dw 220 ; base DEF
    dw 160 ; base AGL
    dw 210 ; base INT
    db $96 ; personality axis $6F
    db $64 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_MADCAT ; id 378 MadCat: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $00 ; join-chance class
    db $01 ; level
    dw 25 ; base HP
    dw 11 ; base MP
    dw 23 ; base ATK
    dw 14 ; base DEF
    dw 23 ; base AGL
    dw 14 ; base INT
    db $dc ; personality axis $6F
    db $b4 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_HORNBEET ; id 379 HornBeet: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $00 ; join-chance class
    db $01 ; level
    dw 15 ; base HP
    dw 28 ; base MP
    dw 17 ; base ATK
    dw 30 ; base DEF
    dw 14 ; base AGL
    dw 29 ; base INT
    db $96 ; personality axis $6F
    db $aa ; personality axis $70
    db $3c ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_SKYDRAGON ; id 380 SkyDragon: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $00 ; join-chance class
    db $01 ; level
    dw 27 ; base HP
    dw 24 ; base MP
    dw 28 ; base ATK
    dw 16 ; base DEF
    dw 21 ; base AGL
    dw 19 ; base INT
    db $d2 ; personality axis $6F
    db $82 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_OCTOGON ; id 381 Octogon: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $00 ; join-chance class
    db $01 ; level
    dw 30 ; base HP
    dw 24 ; base MP
    dw 28 ; base ATK
    dw 16 ; base DEF
    dw 21 ; base AGL
    dw 26 ; base INT
    db $c8 ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_SERVANT ; id 382 Servant: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $00 ; join-chance class
    db $01 ; level
    dw 30 ; base HP
    dw 21 ; base MP
    dw 26 ; base ATK
    dw 24 ; base DEF
    dw 11 ; base AGL
    dw 30 ; base INT
    db $c8 ; personality axis $6F
    db $d2 ; personality axis $70
    db $3c ; byte 24 ($71)
    db $fa ; personality axis $72
    dw MONSTER_DARCK ; id 383 Darck: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $00 ; join-chance class
    db $01 ; level
    dw 70 ; base HP
    dw 55 ; base MP
    dw 55 ; base ATK
    dw 40 ; base DEF
    dw 30 ; base AGL
    dw 120 ; base INT
    db $64 ; personality axis $6F
    db $64 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_GIANTWORM ; id 384 GiantWorm: picture: monster id
    db SKILL_BEASTCUT ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 6 ; EXP
    db $03 ; join-chance class
    db $06 ; level
    dw 15 ; base HP
    dw 11 ; base MP
    dw 15 ; base ATK
    dw 4 ; base DEF
    dw 14 ; base AGL
    dw 18 ; base INT
    db $b4 ; personality axis $6F
    db $64 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_SPOOKY ; id 385 Spooky: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 6 ; EXP
    db $01 ; join-chance class
    db $03 ; level
    dw 16 ; base HP
    dw 16 ; base MP
    dw 11 ; base ATK
    dw 5 ; base DEF
    dw 21 ; base AGL
    dw 15 ; base INT
    db $96 ; personality axis $6F
    db $96 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_BEAVERN ; id 386 Beavern: picture: monster id
    db SKILL_CHARGEUP ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 240 ; EXP
    db $07 ; join-chance class
    db $05 ; level
    dw 98 ; base HP
    dw 16 ; base MP
    dw 20 ; base ATK
    dw 8 ; base DEF
    dw 36 ; base AGL
    dw 120 ; base INT
    db $c8 ; personality axis $6F
    db $32 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_BEAVERN ; id 387 Beavern: picture: monster id
    db SKILL_CHARGEUP ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 60 ; EXP
    db $00 ; join-chance class
    db $05 ; level
    dw 61 ; base HP
    dw 24 ; base MP
    dw 36 ; base ATK
    dw 23 ; base DEF
    dw 42 ; base AGL
    dw 26 ; base INT
    db $c8 ; personality axis $6F
    db $32 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_MADCANDLE ; id 388 MadCandle: picture: monster id
    db SKILL_BLAZE ; skill 1
    db SKILL_WHISTLE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 9 ; EXP
    db $03 ; join-chance class
    db $04 ; level
    dw 16 ; base HP
    dw 11 ; base MP
    dw 14 ; base ATK
    dw 11 ; base DEF
    dw 6 ; base AGL
    dw 11 ; base INT
    db $8c ; personality axis $6F
    db $46 ; personality axis $70
    db $5a ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_SPIKYBOY ; id 389 SpikyBoy: picture: monster id
    db $ff ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 8 ; EXP
    db $03 ; join-chance class
    db $04 ; level
    dw 19 ; base HP
    dw 12 ; base MP
    dw 10 ; base ATK
    dw 6 ; base DEF
    dw 22 ; base AGL
    dw 69 ; base INT
    db $c8 ; personality axis $6F
    db $46 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_ANEMON ; id 390 Anemon: picture: monster id
    db SKILL_FIREBAL ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 18 ; EXP
    db $03 ; join-chance class
    db $05 ; level
    dw 33 ; base HP
    dw 35 ; base MP
    dw 23 ; base ATK
    dw 16 ; base DEF
    dw 28 ; base AGL
    dw 56 ; base INT
    db $8c ; personality axis $6F
    db $64 ; personality axis $70
    db $32 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_ARROWDOG ; id 391 ArrowDog: picture: monster id
    db SKILL_BLAZE ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 120 ; EXP
    db $03 ; join-chance class
    db $09 ; level
    dw 35 ; base HP
    dw 19 ; base MP
    dw 38 ; base ATK
    dw 33 ; base DEF
    dw 54 ; base AGL
    dw 119 ; base INT
    db $64 ; personality axis $6F
    db $96 ; personality axis $70
    db $0a ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_PYURO ; id 392 Pyuro: picture: monster id
    db SKILL_SPEED ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 104 ; EXP
    db $03 ; join-chance class
    db $0b ; level
    dw 35 ; base HP
    dw 32 ; base MP
    dw 32 ; base ATK
    dw 54 ; base DEF
    dw 50 ; base AGL
    dw 183 ; base INT
    db $b4 ; personality axis $6F
    db $96 ; personality axis $70
    db $a0 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_DANCEVEGI ; id 393 DanceVegi: picture: monster id
    db SKILL_SIDESTEP ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 201 ; EXP
    db $03 ; join-chance class
    db $0c ; level
    dw 46 ; base HP
    dw 91 ; base MP
    dw 36 ; base ATK
    dw 60 ; base DEF
    dw 158 ; base AGL
    dw 214 ; base INT
    db $8c ; personality axis $6F
    db $28 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_BRUSHEAD ; id 394 Brushead: picture: monster id
    db SKILL_ODDDANCE ; skill 1
    db SKILL_SANDSTORM ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 227 ; EXP
    db $03 ; join-chance class
    db $0d ; level
    dw 56 ; base HP
    dw 76 ; base MP
    dw 66 ; base ATK
    dw 36 ; base DEF
    dw 51 ; base AGL
    dw 214 ; base INT
    db $82 ; personality axis $6F
    db $78 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_MINIDRAK ; id 395 MiniDrak: picture: monster id
    db SKILL_CALLHELP ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 99 ; EXP
    db $03 ; join-chance class
    db $08 ; level
    dw 41 ; base HP
    dw 32 ; base MP
    dw 44 ; base ATK
    dw 26 ; base DEF
    dw 61 ; base AGL
    dw 140 ; base INT
    db $8c ; personality axis $6F
    db $50 ; personality axis $70
    db $78 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_PTERANOD ; id 396 Pteranod: picture: monster id
    db SKILL_FIREBAL ; skill 1
    db SKILL_TAILWIND ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 301 ; EXP
    db $03 ; join-chance class
    db $0d ; level
    dw 66 ; base HP
    dw 41 ; base MP
    dw 68 ; base ATK
    dw 53 ; base DEF
    dw 158 ; base AGL
    dw 119 ; base INT
    db $c8 ; personality axis $6F
    db $32 ; personality axis $70
    db $3c ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_DRAGONKID ; id 397 DragonKid: picture: monster id
    db SKILL_FIREAIR ; skill 1
    db SKILL_SLEEPAIR ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 108 ; EXP
    db $03 ; join-chance class
    db $0d ; level
    dw 52 ; base HP
    dw 71 ; base MP
    dw 55 ; base ATK
    dw 52 ; base DEF
    dw 70 ; base AGL
    dw 223 ; base INT
    db $d2 ; personality axis $6F
    db $50 ; personality axis $70
    db $0a ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_CATFLY ; id 398 CatFly: picture: monster id
    db SKILL_SLOW ; skill 1
    db SKILL_ODDDANCE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 288 ; EXP
    db $03 ; join-chance class
    db $0f ; level
    dw 64 ; base HP
    dw 95 ; base MP
    dw 66 ; base ATK
    dw 60 ; base DEF
    dw 42 ; base AGL
    dw 193 ; base INT
    db $46 ; personality axis $6F
    db $78 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_BONESLAVE ; id 399 BoneSlave: picture: monster id
    db SKILL_BANG ; skill 1
    db SKILL_BOLTSLASH ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 342 ; EXP
    db $07 ; join-chance class
    db $0d ; level
    dw 72 ; base HP
    dw 58 ; base MP
    dw 58 ; base ATK
    dw 45 ; base DEF
    dw 49 ; base AGL
    dw 99 ; base INT
    db $b4 ; personality axis $6F
    db $28 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_KINGSQUID ; id 400 KingSquid: picture: monster id
    db SKILL_TIDALWAVE ; skill 1
    db SKILL_RAINSLASH ; skill 2
    db SKILL_PANIDANCE ; skill 3
    db $ff ; skill 4
    dw 4000 ; EXP
    db $00 ; join-chance class
    db $26 ; level
    dw 2500 ; base HP
    dw 140 ; base MP
    dw 227 ; base ATK
    dw 147 ; base DEF
    dw 189 ; base AGL
    dw 73 ; base INT
    db $d2 ; personality axis $6F
    db $8c ; personality axis $70
    db $14 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_BEASTNITE ; id 401 BeastNite: picture: monster id
    db SKILL_SLEEP ; skill 1
    db SKILL_RAINSLASH ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 377 ; EXP
    db $04 ; join-chance class
    db $0f ; level
    dw 80 ; base HP
    dw 37 ; base MP
    dw 67 ; base ATK
    dw 61 ; base DEF
    dw 52 ; base AGL
    dw 382 ; base INT
    db $e6 ; personality axis $6F
    db $64 ; personality axis $70
    db $50 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_DRYGON ; id 402 Drygon: picture: monster id
    db SKILL_RAMMING ; skill 1
    db SKILL_WARCRY ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 357 ; EXP
    db $03 ; join-chance class
    db $13 ; level
    dw 95 ; base HP
    dw 73 ; base MP
    dw 79 ; base ATK
    dw 55 ; base DEF
    dw 68 ; base AGL
    dw 259 ; base INT
    db $8c ; personality axis $6F
    db $1e ; personality axis $70
    db $b4 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_PUMPOISE ; id 403 Pumpoise: picture: monster id
    db SKILL_CALLHELP ; skill 1
    db SKILL_SUCKAIR ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 433 ; EXP
    db $03 ; join-chance class
    db $0f ; level
    dw 86 ; base HP
    dw 113 ; base MP
    dw 71 ; base ATK
    dw 88 ; base DEF
    dw 67 ; base AGL
    dw 169 ; base INT
    db $50 ; personality axis $6F
    db $64 ; personality axis $70
    db $78 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_FISHRIDER ; id 404 FishRider: picture: monster id
    db SKILL_BOLTSLASH ; skill 1
    db SKILL_RAINSLASH ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 476 ; EXP
    db $04 ; join-chance class
    db $13 ; level
    dw 106 ; base HP
    dw 130 ; base MP
    dw 74 ; base ATK
    dw 67 ; base DEF
    dw 109 ; base AGL
    dw 156 ; base INT
    db $5a ; personality axis $6F
    db $64 ; personality axis $70
    db $6e ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_WALRUSMAN ; id 405 WalrusMan: picture: monster id
    db SKILL_ZOMBIECUT ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 425 ; EXP
    db $03 ; join-chance class
    db $16 ; level
    dw 128 ; base HP
    dw 87 ; base MP
    dw 90 ; base ATK
    dw 69 ; base DEF
    dw 112 ; base AGL
    dw 436 ; base INT
    db $96 ; personality axis $6F
    db $46 ; personality axis $70
    db $5a ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_STUBSUCK ; id 406 Stubsuck: picture: monster id
    db SKILL_SLEEP ; skill 1
    db SKILL_ZOMBIECUT ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 334 ; EXP
    db $04 ; join-chance class
    db $12 ; level
    dw 76 ; base HP
    dw 78 ; base MP
    dw 75 ; base ATK
    dw 78 ; base DEF
    dw 87 ; base AGL
    dw 179 ; base INT
    db $e6 ; personality axis $6F
    db $64 ; personality axis $70
    db $46 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_SHADOW ; id 407 Shadow: picture: monster id
    db SKILL_BEAT ; skill 1
    db SKILL_ICEAIR ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 364 ; EXP
    db $04 ; join-chance class
    db $14 ; level
    dw 82 ; base HP
    dw 137 ; base MP
    dw 87 ; base ATK
    dw 68 ; base DEF
    dw 77 ; base AGL
    dw 269 ; base INT
    db $fa ; personality axis $6F
    db $d2 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_WINGTREE ; id 408 WingTree: picture: monster id
    db SKILL_ZOMBIECUT ; skill 1
    db SKILL_STEPGUARD ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 468 ; EXP
    db $04 ; join-chance class
    db $17 ; level
    dw 95 ; base HP
    dw 151 ; base MP
    dw 83 ; base ATK
    dw 78 ; base DEF
    dw 89 ; base AGL
    dw 166 ; base INT
    db $a0 ; personality axis $6F
    db $8c ; personality axis $70
    db $78 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_AGDEVIL ; id 409 AgDevil: picture: monster id
    db SKILL_FIREBANE ; skill 1
    db SKILL_SLEEPAIR ; skill 2
    db SKILL_WARCRY ; skill 3
    db $ff ; skill 4
    dw 3022 ; EXP
    db $07 ; join-chance class
    db $12 ; level
    dw 550 ; base HP
    dw 50 ; base MP
    dw 90 ; base ATK
    dw 59 ; base DEF
    dw 109 ; base AGL
    dw 216 ; base INT
    db $96 ; personality axis $6F
    db $96 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_PUPPETOR ; id 410 Puppetor: picture: monster id
    db SKILL_BIATTACK ; skill 1
    db SKILL_ODDDANCE ; skill 2
    db SKILL_PANIDANCE ; skill 3
    db SKILL_LUREDANCE ; skill 4
    dw 2540 ; EXP
    db $07 ; join-chance class
    db $16 ; level
    dw 400 ; base HP
    dw 82 ; base MP
    dw 85 ; base ATK
    dw 60 ; base DEF
    dw 48 ; base AGL
    dw 120 ; base INT
    db $b4 ; personality axis $6F
    db $96 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_ARCDEMON ; id 411 ArcDemon: picture: monster id
    db SKILL_BOOM ; skill 1
    db SKILL_VACUSLASH ; skill 2
    db SKILL_BOLTSLASH ; skill 3
    db $ff ; skill 4
    dw 1270 ; EXP
    db $07 ; join-chance class
    db $1b ; level
    dw 210 ; base HP
    dw 89 ; base MP
    dw 105 ; base ATK
    dw 71 ; base DEF
    dw 84 ; base AGL
    dw 211 ; base INT
    db $b4 ; personality axis $6F
    db $2d ; personality axis $70
    db $96 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_GOATHORN ; id 412 GoatHorn: picture: monster id
    db SKILL_BOOM ; skill 1
    db SKILL_INFERMORE ; skill 2
    db SKILL_SNOWSTORM ; skill 3
    db SKILL_BIATTACK ; skill 4
    dw 7700 ; EXP
    db $07 ; join-chance class
    db $1b ; level
    dw 330 ; base HP
    dw 89 ; base MP
    dw 95 ; base ATK
    dw 65 ; base DEF
    dw 92 ; base AGL
    dw 233 ; base INT
    db $b4 ; personality axis $6F
    db $32 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_METALDRAK ; id 413 MetalDrak: picture: monster id
    db SKILL_BLAZEAIR ; skill 1
    db SKILL_MASSACRE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 1429 ; EXP
    db $05 ; join-chance class
    db $1e ; level
    dw 90 ; base HP
    dw 103 ; base MP
    dw 130 ; base ATK
    dw 92 ; base DEF
    dw 96 ; base AGL
    dw 248 ; base INT
    db $8c ; personality axis $6F
    db $64 ; personality axis $70
    db $6e ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_AGDEVIL ; id 414 AgDevil: picture: monster id
    db SKILL_FIREBANE ; skill 1
    db SKILL_SACRIFICE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 1002 ; EXP
    db $05 ; join-chance class
    db $19 ; level
    dw 102 ; base HP
    dw 102 ; base MP
    dw 165 ; base ATK
    dw 104 ; base DEF
    dw 145 ; base AGL
    dw 302 ; base INT
    db $96 ; personality axis $6F
    db $0a ; personality axis $70
    db $46 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_PUPPETOR ; id 415 Puppetor: picture: monster id
    db SKILL_ODDDANCE ; skill 1
    db SKILL_LUREDANCE ; skill 2
    db SKILL_PHEROMONE ; skill 3
    db $ff ; skill 4
    dw 920 ; EXP
    db $05 ; join-chance class
    db $1b ; level
    dw 101 ; base HP
    dw 150 ; base MP
    dw 134 ; base ATK
    dw 97 ; base DEF
    dw 97 ; base AGL
    dw 239 ; base INT
    db $78 ; personality axis $6F
    db $46 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_GOLEM ; id 416 Golem: picture: monster id
    db SKILL_CHARGEUP ; skill 1
    db SKILL_PSYCHEUP ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 1378 ; EXP
    db $05 ; join-chance class
    db $1b ; level
    dw 145 ; base HP
    dw 102 ; base MP
    dw 132 ; base ATK
    dw 128 ; base DEF
    dw 145 ; base AGL
    dw 127 ; base INT
    db $c8 ; personality axis $6F
    db $00 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_EVILSEED ; id 417 EvilSeed: picture: monster id
    db SKILL_CLEANCUT ; skill 1
    db SKILL_PARALYZE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 2647 ; EXP
    db $04 ; join-chance class
    db $18 ; level
    dw 120 ; base HP
    dw 108 ; base MP
    dw 112 ; base ATK
    dw 117 ; base DEF
    dw 131 ; base AGL
    dw 217 ; base INT
    db $5a ; personality axis $6F
    db $50 ; personality axis $70
    db $78 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_EYEBALL ; id 418 EyeBall: picture: monster id
    db SKILL_MAGICBACK ; skill 1
    db SKILL_WARCRY ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 2333 ; EXP
    db $04 ; join-chance class
    db $1d ; level
    dw 141 ; base HP
    dw 138 ; base MP
    dw 131 ; base ATK
    dw 131 ; base DEF
    dw 135 ; base AGL
    dw 342 ; base INT
    db $96 ; personality axis $6F
    db $50 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_CHAMELGON ; id 419 Chamelgon: picture: monster id
    db SKILL_PANICALL ; skill 1
    db SKILL_PARALYZE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 2198 ; EXP
    db $04 ; join-chance class
    db $1a ; level
    dw 189 ; base HP
    dw 72 ; base MP
    dw 112 ; base ATK
    dw 126 ; base DEF
    dw 122 ; base AGL
    dw 333 ; base INT
    db $50 ; personality axis $6F
    db $50 ; personality axis $70
    db $82 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_FOOHERO ; id 420 FooHero: picture: monster id
    db SKILL_BOLT ; skill 1
    db SKILL_IRONIZE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 1400 ; EXP
    db $04 ; join-chance class
    db $14 ; level
    dw 149 ; base HP
    dw 118 ; base MP
    dw 107 ; base ATK
    dw 101 ; base DEF
    dw 169 ; base AGL
    dw 158 ; base INT
    db $e6 ; personality axis $6F
    db $c8 ; personality axis $70
    db $50 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_BOXSLIME ; id 421 BoxSlime: picture: monster id
    db SKILL_BLAZEMORE ; skill 1
    db SKILL_INCREASE ; skill 2
    db SKILL_RAMMING ; skill 3
    db $ff ; skill 4
    dw 2040 ; EXP
    db $04 ; join-chance class
    db $1e ; level
    dw 156 ; base HP
    dw 77 ; base MP
    dw 118 ; base ATK
    dw 195 ; base DEF
    dw 118 ; base AGL
    dw 273 ; base INT
    db $c8 ; personality axis $6F
    db $0a ; personality axis $70
    db $0a ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_METABBLE ; id 422 Metabble: picture: monster id
    db SKILL_FIREBAL ; skill 1
    db SKILL_BANG ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 41579 ; EXP
    db $07 ; join-chance class
    db $25 ; level
    dw 20 ; base HP
    dw 368 ; base MP
    dw 95 ; base ATK
    dw 999 ; base DEF
    dw 670 ; base AGL
    dw 522 ; base INT
    db $aa ; personality axis $6F
    db $8c ; personality axis $70
    db $00 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_FAIRYRAT ; id 423 FairyRat: picture: monster id
    db SKILL_SLOWALL ; skill 1
    db SKILL_SURROUND ; skill 2
    db SKILL_SLIMEBLOW ; skill 3
    db $ff ; skill 4
    dw 1045 ; EXP
    db $04 ; join-chance class
    db $1b ; level
    dw 148 ; base HP
    dw 95 ; base MP
    dw 115 ; base ATK
    dw 127 ; base DEF
    dw 181 ; base AGL
    dw 216 ; base INT
    db $3c ; personality axis $6F
    db $78 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_SWORDGON ; id 424 Swordgon: picture: monster id
    db SKILL_CLEANCUT ; skill 1
    db SKILL_BLADED ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 1426 ; EXP
    db $05 ; join-chance class
    db $1f ; level
    dw 156 ; base HP
    dw 123 ; base MP
    dw 128 ; base ATK
    dw 122 ; base DEF
    dw 150 ; base AGL
    dw 230 ; base INT
    db $fa ; personality axis $6F
    db $28 ; personality axis $70
    db $82 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_MOMMONJA ; id 425 Mommonja: picture: monster id
    db SKILL_LUREDANCE ; skill 1
    db SKILL_MOUTHSHUT ; skill 2
    db SKILL_SIDESTEP ; skill 3
    db $ff ; skill 4
    dw 1938 ; EXP
    db $04 ; join-chance class
    db $19 ; level
    dw 138 ; base HP
    dw 122 ; base MP
    dw 116 ; base ATK
    dw 99 ; base DEF
    dw 170 ; base AGL
    dw 247 ; base INT
    db $64 ; personality axis $6F
    db $8c ; personality axis $70
    db $78 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_KITEHAWK ; id 426 KiteHawk: picture: monster id
    db SKILL_MAGICWALL ; skill 1
    db SKILL_CURSE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 1941 ; EXP
    db $04 ; join-chance class
    db $23 ; level
    dw 151 ; base HP
    dw 114 ; base MP
    dw 136 ; base ATK
    dw 112 ; base DEF
    dw 269 ; base AGL
    dw 236 ; base INT
    db $b4 ; personality axis $6F
    db $3c ; personality axis $70
    db $82 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_MADCONDOR ; id 427 MadCondor: picture: monster id
    db SKILL_HEALUS ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 15000 ; EXP
    db $00 ; join-chance class
    db $1e ; level
    dw 600 ; base HP
    dw 119 ; base MP
    dw 131 ; base ATK
    dw 90 ; base DEF
    dw 110 ; base AGL
    dw 159 ; base INT
    db $8c ; personality axis $6F
    db $82 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_MADCONDOR ; id 428 MadCondor: picture: monster id
    db SKILL_HEALUS ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $00 ; join-chance class
    db $1e ; level
    dw 149 ; base HP
    dw 119 ; base MP
    dw 181 ; base ATK
    dw 160 ; base DEF
    dw 192 ; base AGL
    dw 259 ; base INT
    db $8c ; personality axis $6F
    db $82 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_WINGSNAKE ; id 429 WingSnake: picture: monster id
    db SKILL_SQUALLHIT ; skill 1
    db SKILL_HIGHJUMP ; skill 2
    db SKILL_POISONAIR ; skill 3
    db $ff ; skill 4
    dw 2943 ; EXP
    db $04 ; join-chance class
    db $20 ; level
    dw 189 ; base HP
    dw 201 ; base MP
    dw 136 ; base ATK
    dw 99 ; base DEF
    dw 196 ; base AGL
    dw 220 ; base INT
    db $96 ; personality axis $6F
    db $8c ; personality axis $70
    db $a0 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_GREATDRAK ; id 430 GreatDrak: picture: monster id
    db SKILL_ICESTORM ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 6746 ; EXP
    db $05 ; join-chance class
    db $28 ; level
    dw 298 ; base HP
    dw 120 ; base MP
    dw 230 ; base ATK
    dw 174 ; base DEF
    dw 105 ; base AGL
    dw 284 ; base INT
    db $96 ; personality axis $6F
    db $2d ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_KINGSQUID ; id 431 KingSquid: picture: monster id
    db SKILL_TIDALWAVE ; skill 1
    db SKILL_RAINSLASH ; skill 2
    db SKILL_PANIDANCE ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $00 ; join-chance class
    db $26 ; level
    dw 210 ; base HP
    dw 140 ; base MP
    dw 227 ; base ATK
    dw 147 ; base DEF
    dw 189 ; base AGL
    dw 173 ; base INT
    db $b4 ; personality axis $6F
    db $8c ; personality axis $70
    db $5a ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_WINDBEAST ; id 432 WindBeast: picture: monster id
    db SKILL_INFERMOST ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 8200 ; EXP
    db $07 ; join-chance class
    db $28 ; level
    dw 900 ; base HP
    dw 127 ; base MP
    dw 236 ; base ATK
    dw 168 ; base DEF
    dw 489 ; base AGL
    dw 0 ; base INT
    db $8c ; personality axis $6F
    db $50 ; personality axis $70
    db $b4 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_MADGOOSE ; id 433 MadGoose: picture: monster id
    db SKILL_VACUUM ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 7780 ; EXP
    db $07 ; join-chance class
    db $28 ; level
    dw 580 ; base HP
    dw 387 ; base MP
    dw 201 ; base ATK
    dw 203 ; base DEF
    dw 348 ; base AGL
    dw 0 ; base INT
    db $50 ; personality axis $6F
    db $64 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_WHALEMAGE ; id 434 WhaleMage: picture: monster id
    db SKILL_TIDALWAVE ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 8900 ; EXP
    db $07 ; join-chance class
    db $2a ; level
    dw 750 ; base HP
    dw 590 ; base MP
    dw 199 ; base ATK
    dw 228 ; base DEF
    dw 247 ; base AGL
    dw 0 ; base INT
    db $be ; personality axis $6F
    db $78 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_SEAHORSE ; id 435 SeaHorse: picture: monster id
    db SKILL_GEYSER ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 5600 ; EXP
    db $07 ; join-chance class
    db $25 ; level
    dw 480 ; base HP
    dw 180 ; base MP
    dw 191 ; base ATK
    dw 253 ; base DEF
    dw 222 ; base AGL
    dw 0 ; base INT
    db $96 ; personality axis $6F
    db $32 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_OCTOREACH ; id 436 Octoreach: picture: monster id
    db SKILL_GEYSER ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 5700 ; EXP
    db $07 ; join-chance class
    db $27 ; level
    dw 700 ; base HP
    dw 140 ; base MP
    dw 238 ; base ATK
    dw 174 ; base DEF
    dw 247 ; base AGL
    dw 0 ; base INT
    db $78 ; personality axis $6F
    db $46 ; personality axis $70
    db $b4 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_ICEMAN ; id 437 IceMan: picture: monster id
    db SKILL_BLIZZARD ; skill 1
    db SKILL_ICESTORM ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 10500 ; EXP
    db $07 ; join-chance class
    db $2d ; level
    dw 1200 ; base HP
    dw 500 ; base MP
    dw 345 ; base ATK
    dw 279 ; base DEF
    dw 210 ; base AGL
    dw 0 ; base INT
    db $64 ; personality axis $6F
    db $1e ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_SHADOW ; id 438 Shadow: picture: monster id
    db SKILL_ICEAIR ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 5800 ; EXP
    db $07 ; join-chance class
    db $28 ; level
    dw 600 ; base HP
    dw 300 ; base MP
    dw 235 ; base ATK
    dw 240 ; base DEF
    dw 170 ; base AGL
    dw 0 ; base INT
    db $46 ; personality axis $6F
    db $32 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_BIGEYE ; id 439 BigEye: picture: monster id
    db SKILL_ICEAIR ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 6000 ; EXP
    db $07 ; join-chance class
    db $25 ; level
    dw 750 ; base HP
    dw 280 ; base MP
    dw 358 ; base ATK
    dw 242 ; base DEF
    dw 198 ; base AGL
    dw 0 ; base INT
    db $64 ; personality axis $6F
    db $64 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_BALZAK ; id 440 Balzak: picture: monster id
    db SKILL_THORDAIN ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 24900 ; EXP
    db $07 ; join-chance class
    db $2d ; level
    dw 2000 ; base HP
    dw 398 ; base MP
    dw 375 ; base ATK
    dw 257 ; base DEF
    dw 220 ; base AGL
    dw 0 ; base INT
    db $c8 ; personality axis $6F
    db $00 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_ROTRAVEN ; id 441 RotRaven: picture: monster id
    db SKILL_LIGHTNING ; skill 1
    db SKILL_BOLTSLASH ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 4000 ; EXP
    db $07 ; join-chance class
    db $23 ; level
    dw 680 ; base HP
    dw 340 ; base MP
    dw 160 ; base ATK
    dw 249 ; base DEF
    dw 340 ; base AGL
    dw 0 ; base INT
    db $28 ; personality axis $6F
    db $50 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_JAMIRUS ; id 442 Jamirus: picture: monster id
    db SKILL_BLAZEMOST ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 10000 ; EXP
    db $07 ; join-chance class
    db $30 ; level
    dw 1400 ; base HP
    dw 750 ; base MP
    dw 247 ; base ATK
    dw 349 ; base DEF
    dw 410 ; base AGL
    dw 0 ; base INT
    db $64 ; personality axis $6F
    db $64 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_SKYDRAGON ; id 443 SkyDragon: picture: monster id
    db SKILL_WHITEFIRE ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 5800 ; EXP
    db $07 ; join-chance class
    db $2e ; level
    dw 990 ; base HP
    dw 700 ; base MP
    dw 349 ; base ATK
    dw 279 ; base DEF
    dw 243 ; base AGL
    dw 0 ; base INT
    db $96 ; personality axis $6F
    db $64 ; personality axis $70
    db $82 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_GREMLIN ; id 444 Gremlin: picture: monster id
    db SKILL_FIREBOLT ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 4800 ; EXP
    db $07 ; join-chance class
    db $28 ; level
    dw 600 ; base HP
    dw 450 ; base MP
    dw 201 ; base ATK
    dw 232 ; base DEF
    dw 218 ; base AGL
    dw 0 ; base INT
    db $28 ; personality axis $6F
    db $5a ; personality axis $70
    db $50 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_CRESTPENT ; id 445 Crestpent: picture: monster id
    db SKILL_STOPSPELL ; skill 1
    db SKILL_POISONHIT ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 7400 ; EXP
    db $07 ; join-chance class
    db $2a ; level
    dw 780 ; base HP
    dw 700 ; base MP
    dw 279 ; base ATK
    dw 300 ; base DEF
    dw 299 ; base AGL
    dw 480 ; base INT
    db $64 ; personality axis $6F
    db $50 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_SPOTKING ; id 446 SpotKing: picture: monster id
    db SKILL_NAPATTACK ; skill 1
    db SKILL_MOUTHSHUT ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 10000 ; EXP
    db $07 ; join-chance class
    db $2d ; level
    dw 1300 ; base HP
    dw 550 ; base MP
    dw 378 ; base ATK
    dw 214 ; base DEF
    dw 308 ; base AGL
    dw 800 ; base INT
    db $46 ; personality axis $6F
    db $50 ; personality axis $70
    db $78 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_GULPPLE ; id 447 Gulpple: picture: monster id
    db SKILL_SLEEPAIR ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 5600 ; EXP
    db $07 ; join-chance class
    db $2d ; level
    dw 840 ; base HP
    dw 590 ; base MP
    dw 289 ; base ATK
    dw 299 ; base DEF
    dw 387 ; base AGL
    dw 0 ; base INT
    db $3c ; personality axis $6F
    db $96 ; personality axis $70
    db $78 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_FAIRYDRAK ; id 448 FairyDrak: picture: monster id
    db SKILL_SURROUND ; skill 1
    db SKILL_SLEEPAIR ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 5700 ; EXP
    db $07 ; join-chance class
    db $28 ; level
    dw 700 ; base HP
    dw 340 ; base MP
    dw 312 ; base ATK
    dw 298 ; base DEF
    dw 273 ; base AGL
    dw 0 ; base INT
    db $50 ; personality axis $6F
    db $50 ; personality axis $70
    db $50 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_DUCKKITE ; id 449 DuckKite: picture: monster id
    db SKILL_SLEEPALL ; skill 1
    db SKILL_PANICALL ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 5900 ; EXP
    db $07 ; join-chance class
    db $2a ; level
    dw 900 ; base HP
    dw 470 ; base MP
    dw 296 ; base ATK
    dw 330 ; base DEF
    dw 400 ; base AGL
    dw 0 ; base INT
    db $5a ; personality axis $6F
    db $5a ; personality axis $70
    db $5a ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_FUNKYBIRD ; id 450 FunkyBird: picture: monster id
    db SKILL_PANIDANCE ; skill 1
    db SKILL_HUSTLE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 6200 ; EXP
    db $07 ; join-chance class
    db $2a ; level
    dw 890 ; base HP
    dw 500 ; base MP
    dw 301 ; base ATK
    dw 267 ; base DEF
    dw 430 ; base AGL
    dw 0 ; base INT
    db $50 ; personality axis $6F
    db $64 ; personality axis $70
    db $82 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_DANCEVEGI ; id 451 DanceVegi: picture: monster id
    db SKILL_KODANCE ; skill 1
    db SKILL_LUREDANCE ; skill 2
    db SKILL_SIDESTEP ; skill 3
    db $ff ; skill 4
    dw 6100 ; EXP
    db $07 ; join-chance class
    db $25 ; level
    dw 680 ; base HP
    dw 430 ; base MP
    dw 259 ; base ATK
    dw 249 ; base DEF
    dw 240 ; base AGL
    dw 0 ; base INT
    db $32 ; personality axis $6F
    db $5a ; personality axis $70
    db $50 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_SLURPERON ; id 452 Slurperon: picture: monster id
    db SKILL_ODDDANCE ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 5600 ; EXP
    db $07 ; join-chance class
    db $27 ; level
    dw 790 ; base HP
    dw 400 ; base MP
    dw 277 ; base ATK
    dw 259 ; base DEF
    dw 302 ; base AGL
    dw 0 ; base INT
    db $5a ; personality axis $6F
    db $5a ; personality axis $70
    db $8c ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_MADPLANT ; id 453 MadPlant: picture: monster id
    db SKILL_DEFENSE ; skill 1
    db SKILL_SLOWALL ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 5200 ; EXP
    db $07 ; join-chance class
    db $27 ; level
    dw 880 ; base HP
    dw 380 ; base MP
    dw 243 ; base ATK
    dw 350 ; base DEF
    dw 289 ; base AGL
    dw 510 ; base INT
    db $50 ; personality axis $6F
    db $50 ; personality axis $70
    db $50 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_ORC ; id 454 Orc: picture: monster id
    db SKILL_VIVIFY ; skill 1
    db SKILL_DEFENSE ; skill 2
    db SKILL_SAMSICALL ; skill 3
    db $ff ; skill 4
    dw 6000 ; EXP
    db $07 ; join-chance class
    db $2b ; level
    dw 900 ; base HP
    dw 350 ; base MP
    dw 346 ; base ATK
    dw 289 ; base DEF
    dw 190 ; base AGL
    dw 770 ; base INT
    db $8c ; personality axis $6F
    db $64 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_PUTREPUP ; id 455 PutrePup: picture: monster id
    db SKILL_DEFENSE ; skill 1
    db SKILL_SLOWALL ; skill 2
    db SKILL_MAGICBACK ; skill 3
    db $ff ; skill 4
    dw 5900 ; EXP
    db $07 ; join-chance class
    db $29 ; level
    dw 700 ; base HP
    dw 280 ; base MP
    dw 330 ; base ATK
    dw 328 ; base DEF
    dw 232 ; base AGL
    dw 450 ; base INT
    db $64 ; personality axis $6F
    db $64 ; personality axis $70
    db $82 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_DEVIPINE ; id 456 Devipine: picture: monster id
    db SKILL_BEAT ; skill 1
    db SKILL_ODDDANCE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 6400 ; EXP
    db $07 ; join-chance class
    db $2b ; level
    dw 840 ; base HP
    dw 400 ; base MP
    dw 300 ; base ATK
    dw 358 ; base DEF
    dw 222 ; base AGL
    dw 660 ; base INT
    db $46 ; personality axis $6F
    db $3c ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_ANEMON ; id 457 Anemon: picture: monster id
    db SKILL_PARALYZE ; skill 1
    db SKILL_POISONAIR ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 5800 ; EXP
    db $07 ; join-chance class
    db $2c ; level
    dw 900 ; base HP
    dw 370 ; base MP
    dw 248 ; base ATK
    dw 388 ; base DEF
    dw 289 ; base AGL
    dw 580 ; base INT
    db $64 ; personality axis $6F
    db $78 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_HERBMAN ; id 458 HerbMan: picture: monster id
    db SKILL_CURSE ; skill 1
    db SKILL_DANCESHUT ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 6300 ; EXP
    db $07 ; join-chance class
    db $2e ; level
    dw 1300 ; base HP
    dw 700 ; base MP
    dw 341 ; base ATK
    dw 273 ; base DEF
    dw 370 ; base AGL
    dw 900 ; base INT
    db $5a ; personality axis $6F
    db $82 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_KINGSLIME ; id 459 KingSlime: picture: monster id
    db SKILL_VIVIFY ; skill 1
    db SKILL_BARRIER ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 18000 ; EXP
    db $07 ; join-chance class
    db $32 ; level
    dw 4000 ; base HP
    dw 280 ; base MP
    dw 329 ; base ATK
    dw 289 ; base DEF
    dw 334 ; base AGL
    dw 800 ; base INT
    db $0a ; personality axis $6F
    db $96 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_COATOL ; id 460 Coatol: picture: monster id
    db SKILL_EXPLODET ; skill 1
    db SKILL_BOLTSLASH ; skill 2
    db SKILL_EVILSLASH ; skill 3
    db $ff ; skill 4
    dw 10000 ; EXP
    db $07 ; join-chance class
    db $30 ; level
    dw 640 ; base HP
    dw 1800 ; base MP
    dw 289 ; base ATK
    dw 410 ; base DEF
    dw 329 ; base AGL
    dw 800 ; base INT
    db $5a ; personality axis $6F
    db $64 ; personality axis $70
    db $78 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_FANGSLIME ; id 461 FangSlime: picture: monster id
    db SKILL_YELLHELP ; skill 1
    db SKILL_CHARGEUP ; skill 2
    db SKILL_WARCRY ; skill 3
    db $ff ; skill 4
    dw 9400 ; EXP
    db $07 ; join-chance class
    db $2c ; level
    dw 700 ; base HP
    dw 378 ; base MP
    dw 333 ; base ATK
    dw 278 ; base DEF
    dw 397 ; base AGL
    dw 590 ; base INT
    db $c8 ; personality axis $6F
    db $28 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_GRIZZLY ; id 462 Grizzly: picture: monster id
    db SKILL_SQUALLHIT ; skill 1
    db SKILL_QUADHITS ; skill 2
    db SKILL_BIGTRIP ; skill 3
    db $ff ; skill 4
    dw 10200 ; EXP
    db $07 ; join-chance class
    db $2d ; level
    dw 870 ; base HP
    dw 360 ; base MP
    dw 372 ; base ATK
    dw 245 ; base DEF
    dw 379 ; base AGL
    dw 288 ; base INT
    db $b4 ; personality axis $6F
    db $46 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_BEASTNITE ; id 463 BeastNite: picture: monster id
    db SKILL_SLEEP ; skill 1
    db SKILL_RAINSLASH ; skill 2
    db SKILL_GIGASLASH ; skill 3
    db $ff ; skill 4
    dw 9300 ; EXP
    db $07 ; join-chance class
    db $2d ; level
    dw 1200 ; base HP
    dw 420 ; base MP
    dw 358 ; base ATK
    dw 343 ; base DEF
    dw 201 ; base AGL
    dw 600 ; base INT
    db $8c ; personality axis $6F
    db $64 ; personality axis $70
    db $78 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_SLIMEBORG ; id 464 SlimeBorg: picture: monster id
    db SKILL_HEALMORE ; skill 1
    db SKILL_HEALUSALL ; skill 2
    db SKILL_INCREASE ; skill 3
    db $ff ; skill 4
    dw 8700 ; EXP
    db $07 ; join-chance class
    db $2c ; level
    dw 650 ; base HP
    dw 790 ; base MP
    dw 217 ; base ATK
    dw 327 ; base DEF
    dw 418 ; base AGL
    dw 740 ; base INT
    db $50 ; personality axis $6F
    db $c8 ; personality axis $70
    db $aa ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_UNICORN ; id 465 Unicorn: picture: monster id
    db SKILL_HEALALL ; skill 1
    db SKILL_REVIVE ; skill 2
    db SKILL_SURGE ; skill 3
    db $ff ; skill 4
    dw 11000 ; EXP
    db $07 ; join-chance class
    db $2d ; level
    dw 720 ; base HP
    dw 680 ; base MP
    dw 316 ; base ATK
    dw 322 ; base DEF
    dw 319 ; base AGL
    dw 800 ; base INT
    db $46 ; personality axis $6F
    db $c8 ; personality axis $70
    db $46 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_SUPERTEN ; id 466 SuperTen: picture: monster id
    db SKILL_HUSTLE ; skill 1
    db SKILL_IMITATE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 8800 ; EXP
    db $07 ; join-chance class
    db $2c ; level
    dw 600 ; base HP
    dw 380 ; base MP
    dw 312 ; base ATK
    dw 298 ; base DEF
    dw 417 ; base AGL
    dw 600 ; base INT
    db $32 ; personality axis $6F
    db $aa ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_SLIME ; id 467 Slime: picture: monster id
    db SKILL_MEGAMAGIC ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 11200 ; EXP
    db $07 ; join-chance class
    db $2f ; level
    dw 600 ; base HP
    dw 500 ; base MP
    dw 387 ; base ATK
    dw 299 ; base DEF
    dw 387 ; base AGL
    dw 700 ; base INT
    db $78 ; personality axis $6F
    db $46 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_ROCKSLIME ; id 468 RockSlime: picture: monster id
    db SKILL_HIGHJUMP ; skill 1
    db SKILL_RAMMING ; skill 2
    db SKILL_STRONGD ; skill 3
    db $ff ; skill 4
    dw 12000 ; EXP
    db $07 ; join-chance class
    db $28 ; level
    dw 680 ; base HP
    dw 230 ; base MP
    dw 265 ; base ATK
    dw 362 ; base DEF
    dw 265 ; base AGL
    dw 450 ; base INT
    db $5a ; personality axis $6F
    db $aa ; personality axis $70
    db $3c ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_METABBLE ; id 469 Metabble: picture: monster id
    db SKILL_EXPLODET ; skill 1
    db SKILL_SACRIFICE ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 38900 ; EXP
    db $07 ; join-chance class
    db $28 ; level
    dw 289 ; base HP
    dw 700 ; base MP
    dw 146 ; base ATK
    dw 798 ; base DEF
    dw 688 ; base AGL
    dw 770 ; base INT
    db $0a ; personality axis $6F
    db $64 ; personality axis $70
    db $5a ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_GORAGO ; id 470 Gorago: picture: monster id
    db SKILL_WHITEFIRE ; skill 1
    db SKILL_DEMAGIC ; skill 2
    db SKILL_WARCRY ; skill 3
    db SKILL_MEDITATE ; skill 4
    dw 53890 ; EXP
    db $07 ; join-chance class
    db $37 ; level
    dw 990 ; base HP
    dw 780 ; base MP
    dw 432 ; base ATK
    dw 378 ; base DEF
    dw 688 ; base AGL
    dw 800 ; base INT
    db $c8 ; personality axis $6F
    db $82 ; personality axis $70
    db $78 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_SLABBIT ; id 471 Slabbit: picture: monster id
    db SKILL_SIDESTEP ; skill 1
    db SKILL_BIGTRIP ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 5870 ; EXP
    db $04 ; join-chance class
    db $25 ; level
    dw 220 ; base HP
    dw 374 ; base MP
    dw 187 ; base ATK
    dw 198 ; base DEF
    dw 310 ; base AGL
    dw 345 ; base INT
    db $3c ; personality axis $6F
    db $50 ; personality axis $70
    db $5a ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_MULTIEYES ; id 472 MultiEyes: picture: monster id
    db SKILL_SLOWALL ; skill 1
    db SKILL_PALSYAIR ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 5972 ; EXP
    db $05 ; join-chance class
    db $25 ; level
    dw 280 ; base HP
    dw 248 ; base MP
    dw 220 ; base ATK
    dw 178 ; base DEF
    dw 259 ; base AGL
    dw 333 ; base INT
    db $50 ; personality axis $6F
    db $46 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_FAIRYRAT ; id 473 FairyRat: picture: monster id
    db SKILL_SLOWALL ; skill 1
    db SKILL_SURROUND ; skill 2
    db SKILL_SLIMEBLOW ; skill 3
    db $ff ; skill 4
    dw 5674 ; EXP
    db $04 ; join-chance class
    db $23 ; level
    dw 140 ; base HP
    dw 188 ; base MP
    dw 168 ; base ATK
    dw 340 ; base DEF
    dw 288 ; base AGL
    dw 348 ; base INT
    db $3c ; personality axis $6F
    db $50 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_STUBSUCK ; id 474 Stubsuck: picture: monster id
    db SKILL_SLEEPALL ; skill 1
    db SKILL_ZOMBIECUT ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 5738 ; EXP
    db $04 ; join-chance class
    db $25 ; level
    dw 300 ; base HP
    dw 345 ; base MP
    dw 175 ; base ATK
    dw 220 ; base DEF
    dw 201 ; base AGL
    dw 338 ; base INT
    db $28 ; personality axis $6F
    db $28 ; personality axis $70
    db $32 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_MADPLANT ; id 475 MadPlant: picture: monster id
    db SKILL_DEFENSE ; skill 1
    db SKILL_SLOWALL ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 5499 ; EXP
    db $04 ; join-chance class
    db $22 ; level
    dw 180 ; base HP
    dw 420 ; base MP
    dw 207 ; base ATK
    dw 299 ; base DEF
    dw 230 ; base AGL
    dw 378 ; base INT
    db $50 ; personality axis $6F
    db $1e ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_SNAPPER ; id 476 Snapper: picture: monster id
    db SKILL_STOPSPELL ; skill 1
    db SKILL_YELLHELP ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 6128 ; EXP
    db $05 ; join-chance class
    db $24 ; level
    dw 310 ; base HP
    dw 360 ; base MP
    dw 257 ; base ATK
    dw 236 ; base DEF
    dw 287 ; base AGL
    dw 450 ; base INT
    db $5a ; personality axis $6F
    db $64 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_GRENDAL ; id 477 Grendal: picture: monster id
    db SKILL_FIRESLASH ; skill 1
    db SKILL_DRAKSLASH ; skill 2
    db SKILL_WARCRY ; skill 3
    db $ff ; skill 4
    dw 6748 ; EXP
    db $05 ; join-chance class
    db $26 ; level
    dw 380 ; base HP
    dw 197 ; base MP
    dw 301 ; base ATK
    dw 268 ; base DEF
    dw 189 ; base AGL
    dw 327 ; base INT
    db $96 ; personality axis $6F
    db $64 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_GOHOPPER ; id 478 GoHopper: picture: monster id
    db SKILL_ROBMAGIC ; skill 1
    db SKILL_YELLHELP ; skill 2
    db SKILL_CHARGEUP ; skill 3
    db $ff ; skill 4
    dw 5888 ; EXP
    db $04 ; join-chance class
    db $23 ; level
    dw 230 ; base HP
    dw 260 ; base MP
    dw 173 ; base ATK
    dw 270 ; base DEF
    dw 299 ; base AGL
    dw 320 ; base INT
    db $50 ; personality axis $6F
    db $28 ; personality axis $70
    db $3c ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_ARROWDOG ; id 479 ArrowDog: picture: monster id
    db SKILL_INCREASE ; skill 1
    db SKILL_CHARGEUP ; skill 2
    db SKILL_SICKLICK ; skill 3
    db $ff ; skill 4
    dw 9800 ; EXP
    db $07 ; join-chance class
    db $28 ; level
    dw 500 ; base HP
    dw 210 ; base MP
    dw 237 ; base ATK
    dw 288 ; base DEF
    dw 249 ; base AGL
    dw 501 ; base INT
    db $50 ; personality axis $6F
    db $28 ; personality axis $70
    db $46 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_STAGBUG ; id 480 StagBug: picture: monster id
    db SKILL_SLEEPALL ; skill 1
    db SKILL_SCORCHING ; skill 2
    db SKILL_AHHH ; skill 3
    db $ff ; skill 4
    dw 6138 ; EXP
    db $05 ; join-chance class
    db $26 ; level
    dw 325 ; base HP
    dw 200 ; base MP
    dw 248 ; base ATK
    dw 348 ; base DEF
    dw 248 ; base AGL
    dw 360 ; base INT
    db $50 ; personality axis $6F
    db $1e ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_FIREWEED ; id 481 FireWeed: picture: monster id
    db SKILL_BLAZEMORE ; skill 1
    db SKILL_PALSYAIR ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 6348 ; EXP
    db $05 ; join-chance class
    db $25 ; level
    dw 290 ; base HP
    dw 470 ; base MP
    dw 301 ; base ATK
    dw 240 ; base DEF
    dw 320 ; base AGL
    dw 410 ; base INT
    db $5a ; personality axis $6F
    db $46 ; personality axis $70
    db $5a ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_AGDEVIL ; id 482 AgDevil: picture: monster id
    db SKILL_FIREBOLT ; skill 1
    db SKILL_ROBDANCE ; skill 2
    db SKILL_IMITATE ; skill 3
    db $ff ; skill 4
    dw 26890 ; EXP
    db $07 ; join-chance class
    db $2f ; level
    dw 1500 ; base HP
    dw 580 ; base MP
    dw 346 ; base ATK
    dw 310 ; base DEF
    dw 267 ; base AGL
    dw 700 ; base INT
    db $5a ; personality axis $6F
    db $78 ; personality axis $70
    db $82 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_GRIZZLY ; id 483 Grizzly: picture: monster id
    db SKILL_SQUALLHIT ; skill 1
    db SKILL_QUADHITS ; skill 2
    db SKILL_BIGTRIP ; skill 3
    db $ff ; skill 4
    dw 6172 ; EXP
    db $04 ; join-chance class
    db $29 ; level
    dw 425 ; base HP
    dw 157 ; base MP
    dw 320 ; base ATK
    dw 220 ; base DEF
    dw 201 ; base AGL
    dw 323 ; base INT
    db $96 ; personality axis $6F
    db $46 ; personality axis $70
    db $46 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_SKULRIDER ; id 484 SkulRider: picture: monster id
    db SKILL_FIRESLASH ; skill 1
    db SKILL_RAINSLASH ; skill 2
    db SKILL_BIGTRIP ; skill 3
    db $ff ; skill 4
    dw 5488 ; EXP
    db $04 ; join-chance class
    db $2a ; level
    dw 311 ; base HP
    dw 245 ; base MP
    dw 287 ; base ATK
    dw 269 ; base DEF
    dw 324 ; base AGL
    dw 388 ; base INT
    db $64 ; personality axis $6F
    db $64 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_WALRUSMAN ; id 485 WalrusMan: picture: monster id
    db SKILL_BUGBLOW ; skill 1
    db SKILL_EVILSLASH ; skill 2
    db SKILL_MASSACRE ; skill 3
    db $ff ; skill 4
    dw 5972 ; EXP
    db $04 ; join-chance class
    db $28 ; level
    dw 347 ; base HP
    dw 225 ; base MP
    dw 321 ; base ATK
    dw 219 ; base DEF
    dw 340 ; base AGL
    dw 317 ; base INT
    db $82 ; personality axis $6F
    db $3c ; personality axis $70
    db $50 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_MADCANDLE ; id 486 MadCandle: picture: monster id
    db SKILL_BLAZEMORE ; skill 1
    db SKILL_PSYCHEUP ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 6010 ; EXP
    db $03 ; join-chance class
    db $2b ; level
    dw 321 ; base HP
    dw 249 ; base MP
    dw 299 ; base ATK
    dw 319 ; base DEF
    dw 372 ; base AGL
    dw 478 ; base INT
    db $64 ; personality axis $6F
    db $46 ; personality axis $70
    db $50 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_REAPER ; id 487 Reaper: picture: monster id
    db SKILL_DEVILCUT ; skill 1
    db SKILL_CURSE ; skill 2
    db SKILL_EERIELITE ; skill 3
    db $ff ; skill 4
    dw 6488 ; EXP
    db $04 ; join-chance class
    db $2a ; level
    dw 279 ; base HP
    dw 489 ; base MP
    dw 287 ; base ATK
    dw 367 ; base DEF
    dw 327 ; base AGL
    dw 589 ; base INT
    db $64 ; personality axis $6F
    db $64 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_PROTOMECH ; id 488 ProtoMech: picture: monster id
    db SKILL_CHARGEUP ; skill 1
    db SKILL_RAMMING ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 6788 ; EXP
    db $05 ; join-chance class
    db $2b ; level
    dw 378 ; base HP
    dw 289 ; base MP
    dw 380 ; base ATK
    dw 232 ; base DEF
    dw 318 ; base AGL
    dw 379 ; base INT
    db $6e ; personality axis $6F
    db $28 ; personality axis $70
    db $6e ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_ROBOSTER ; id 489 Roboster: picture: monster id
    db SKILL_DEFENSE ; skill 1
    db SKILL_QUADHITS ; skill 2
    db SKILL_RAINSLASH ; skill 3
    db SKILL_BLADED ; skill 4
    dw 6000 ; EXP
    db $07 ; join-chance class
    db $32 ; level
    dw 900 ; base HP
    dw 570 ; base MP
    dw 401 ; base ATK
    dw 448 ; base DEF
    dw 427 ; base AGL
    dw 670 ; base INT
    db $8c ; personality axis $6F
    db $5a ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_ROBOSTER ; id 490 Roboster: picture: monster id
    db SKILL_DEFENSE ; skill 1
    db SKILL_QUADHITS ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 1000 ; EXP
    db $07 ; join-chance class
    db $32 ; level
    dw 535 ; base HP
    dw 205 ; base MP
    dw 310 ; base ATK
    dw 300 ; base DEF
    dw 320 ; base AGL
    dw 420 ; base INT
    db $8c ; personality axis $6F
    db $32 ; personality axis $70
    db $3c ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_ROBOSTER ; id 491 Roboster: picture: monster id
    db SKILL_DEFENSE ; skill 1
    db SKILL_QUADHITS ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 300 ; EXP
    db $07 ; join-chance class
    db $32 ; level
    dw 210 ; base HP
    dw 70 ; base MP
    dw 160 ; base ATK
    dw 200 ; base DEF
    dw 210 ; base AGL
    dw 230 ; base INT
    db $8c ; personality axis $6F
    db $28 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_ROBOSTER ; id 492 Roboster: picture: monster id
    db SKILL_DEFENSE ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 100 ; EXP
    db $07 ; join-chance class
    db $32 ; level
    dw 79 ; base HP
    dw 2 ; base MP
    dw 82 ; base ATK
    dw 89 ; base DEF
    dw 101 ; base AGL
    dw 38 ; base INT
    db $8c ; personality axis $6F
    db $00 ; personality axis $70
    db $00 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_CATMAGE ; id 493 CatMage: picture: monster id
    db SKILL_TRANSFORM ; skill 1
    db SKILL_DIAGOCALL ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 14879 ; EXP
    db $04 ; join-chance class
    db $2c ; level
    dw 304 ; base HP
    dw 477 ; base MP
    dw 225 ; base ATK
    dw 267 ; base DEF
    dw 278 ; base AGL
    dw 620 ; base INT
    db $46 ; personality axis $6F
    db $5a ; personality axis $70
    db $6e ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_FACETREE ; id 494 FaceTree: picture: monster id
    db SKILL_STOPSPELL ; skill 1
    db SKILL_CURSE ; skill 2
    db SKILL_ODDDANCE ; skill 3
    db $ff ; skill 4
    dw 13779 ; EXP
    db $05 ; join-chance class
    db $2f ; level
    dw 369 ; base HP
    dw 427 ; base MP
    dw 237 ; base ATK
    dw 324 ; base DEF
    dw 200 ; base AGL
    dw 600 ; base INT
    db $50 ; personality axis $6F
    db $78 ; personality axis $70
    db $78 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_OGRE ; id 495 Ogre: picture: monster id
    db SKILL_METALCUT ; skill 1
    db SKILL_PSYCHEUP ; skill 2
    db SKILL_MASSACRE ; skill 3
    db $ff ; skill 4
    dw 14670 ; EXP
    db $05 ; join-chance class
    db $2f ; level
    dw 410 ; base HP
    dw 246 ; base MP
    dw 359 ; base ATK
    dw 312 ; base DEF
    dw 273 ; base AGL
    dw 550 ; base INT
    db $c8 ; personality axis $6F
    db $1e ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_CURSELAMP ; id 496 CurseLamp: picture: monster id
    db SKILL_INCREASE ; skill 1
    db SKILL_SPEEDUP ; skill 2
    db SKILL_TWINHITS ; skill 3
    db $ff ; skill 4
    dw 13586 ; EXP
    db $04 ; join-chance class
    db $2c ; level
    dw 333 ; base HP
    dw 390 ; base MP
    dw 205 ; base ATK
    dw 280 ; base DEF
    dw 348 ; base AGL
    dw 600 ; base INT
    db $5a ; personality axis $6F
    db $8c ; personality axis $70
    db $82 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_ANEMON ; id 497 Anemon: picture: monster id
    db SKILL_FIREBOLT ; skill 1
    db SKILL_PARALYZE ; skill 2
    db SKILL_POISONGAS ; skill 3
    db $ff ; skill 4
    dw 13347 ; EXP
    db $04 ; join-chance class
    db $2d ; level
    dw 310 ; base HP
    dw 370 ; base MP
    dw 279 ; base ATK
    dw 243 ; base DEF
    dw 318 ; base AGL
    dw 520 ; base INT
    db $64 ; personality axis $6F
    db $64 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_LIPSY ; id 498 Lipsy: picture: monster id
    db SKILL_SICKLICK ; skill 1
    db SKILL_AHHH ; skill 2
    db SKILL_PHEROMONE ; skill 3
    db $ff ; skill 4
    dw 14648 ; EXP
    db $04 ; join-chance class
    db $2c ; level
    dw 348 ; base HP
    dw 360 ; base MP
    dw 267 ; base ATK
    dw 287 ; base DEF
    dw 287 ; base AGL
    dw 530 ; base INT
    db $5a ; personality axis $6F
    db $8c ; personality axis $70
    db $78 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_WEEDBUG ; id 499 WeedBug: picture: monster id
    db SKILL_ROBMAGIC ; skill 1
    db SKILL_BARRIER ; skill 2
    db SKILL_MAGICWALL ; skill 3
    db $ff ; skill 4
    dw 13222 ; EXP
    db $04 ; join-chance class
    db $2e ; level
    dw 323 ; base HP
    dw 479 ; base MP
    dw 249 ; base ATK
    dw 326 ; base DEF
    dw 312 ; base AGL
    dw 480 ; base INT
    db $50 ; personality axis $6F
    db $82 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_SPIKEROUS ; id 500 Spikerous: picture: monster id
    db SKILL_ROCKTHROW ; skill 1
    db SKILL_BERSERKER ; skill 2
    db SKILL_KAMIKAZE ; skill 3
    db $ff ; skill 4
    dw 15900 ; EXP
    db $05 ; join-chance class
    db $2d ; level
    dw 438 ; base HP
    dw 320 ; base MP
    dw 297 ; base ATK
    dw 378 ; base DEF
    dw 207 ; base AGL
    dw 410 ; base INT
    db $64 ; personality axis $6F
    db $50 ; personality axis $70
    db $6e ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_SKULLGON ; id 501 Skullgon: picture: monster id
    db SKILL_ICESTORM ; skill 1
    db SKILL_ICESLASH ; skill 2
    db SKILL_TWINSLASH ; skill 3
    db $ff ; skill 4
    dw 15478 ; EXP
    db $05 ; join-chance class
    db $2f ; level
    dw 426 ; base HP
    dw 320 ; base MP
    dw 297 ; base ATK
    dw 378 ; base DEF
    dw 207 ; base AGL
    dw 450 ; base INT
    db $82 ; personality axis $6F
    db $64 ; personality axis $70
    db $6e ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_SKULPENT ; id 502 Skulpent: picture: monster id
    db SKILL_DEFEAT ; skill 1
    db SKILL_POISONHIT ; skill 2
    db SKILL_DODGE ; skill 3
    db $ff ; skill 4
    dw 13267 ; EXP
    db $04 ; join-chance class
    db $2c ; level
    dw 368 ; base HP
    dw 274 ; base MP
    dw 277 ; base ATK
    dw 243 ; base DEF
    dw 378 ; base AGL
    dw 400 ; base INT
    db $5a ; personality axis $6F
    db $8c ; personality axis $70
    db $78 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_BUTTERFLY ; id 503 Butterfly: picture: monster id
    db SKILL_SURROUND ; skill 1
    db SKILL_YELLHELP ; skill 2
    db SKILL_CURSE ; skill 3
    db $ff ; skill 4
    dw 13685 ; EXP
    db $04 ; join-chance class
    db $2e ; level
    dw 297 ; base HP
    dw 389 ; base MP
    dw 266 ; base ATK
    dw 324 ; base DEF
    dw 458 ; base AGL
    dw 620 ; base INT
    db $50 ; personality axis $6F
    db $64 ; personality axis $70
    db $82 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_PIXY ; id 504 Pixy: picture: monster id
    db SKILL_BOOM ; skill 1
    db SKILL_BARRIER ; skill 2
    db SKILL_PANIDANCE ; skill 3
    db $ff ; skill 4
    dw 9680 ; EXP
    db $07 ; join-chance class
    db $34 ; level
    dw 680 ; base HP
    dw 400 ; base MP
    dw 357 ; base ATK
    dw 374 ; base DEF
    dw 443 ; base AGL
    dw 700 ; base INT
    db $64 ; personality axis $6F
    db $82 ; personality axis $70
    db $6e ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_COPYCAT ; id 505 Copycat: picture: monster id
    db SKILL_TRANSFORM ; skill 1
    db $ff ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 15000 ; EXP
    db $07 ; join-chance class
    db $37 ; level
    dw 750 ; base HP
    dw 300 ; base MP
    dw 310 ; base ATK
    dw 520 ; base DEF
    dw 380 ; base AGL
    dw 999 ; base INT
    db $96 ; personality axis $6F
    db $96 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_STONEMAN ; id 506 StoneMan: picture: monster id
    db SKILL_ROCKTHROW ; skill 1
    db SKILL_GUARDIAN ; skill 2
    db SKILL_MEDITATE ; skill 3
    db $ff ; skill 4
    dw 9000 ; EXP
    db $07 ; join-chance class
    db $34 ; level
    dw 1300 ; base HP
    dw 360 ; base MP
    dw 458 ; base ATK
    dw 268 ; base DEF
    dw 247 ; base AGL
    dw 700 ; base INT
    db $78 ; personality axis $6F
    db $96 ; personality axis $70
    db $78 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_WHIPBIRD ; id 507 WhipBird: picture: monster id
    db SKILL_DEMAGIC ; skill 1
    db SKILL_IMITATE ; skill 2
    db SKILL_LOVERAIN ; skill 3
    db $ff ; skill 4
    dw 12000 ; EXP
    db $07 ; join-chance class
    db $35 ; level
    dw 950 ; base HP
    dw 830 ; base MP
    dw 334 ; base ATK
    dw 374 ; base DEF
    dw 438 ; base AGL
    dw 700 ; base INT
    db $82 ; personality axis $6F
    db $96 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_MIMESLIME ; id 508 MimeSlime: picture: monster id
    db SKILL_BLAZEMOST ; skill 1
    db SKILL_BARRIER ; skill 2
    db SKILL_ODDDANCE ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $2b ; level
    dw 370 ; base HP
    dw 690 ; base MP
    dw 258 ; base ATK
    dw 320 ; base DEF
    dw 350 ; base AGL
    dw 520 ; base INT
    db $28 ; personality axis $6F
    db $78 ; personality axis $70
    db $d2 ; byte 24 ($71)
    db $8c ; personality axis $72
    dw MONSTER_TONGUELLA ; id 509 Tonguella: picture: monster id
    db SKILL_INCREASE ; skill 1
    db SKILL_MAGICWALL ; skill 2
    db SKILL_SLIMEBLOW ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $2d ; level
    dw 400 ; base HP
    dw 320 ; base MP
    dw 338 ; base ATK
    dw 310 ; base DEF
    dw 284 ; base AGL
    dw 430 ; base INT
    db $82 ; personality axis $6F
    db $14 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $8c ; personality axis $72
    dw MONSTER_GOLEM ; id 510 Golem: picture: monster id
    db SKILL_PSYCHEUP ; skill 1
    db SKILL_HIGHJUMP ; skill 2
    db SKILL_MASSACRE ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $30 ; level
    dw 520 ; base HP
    dw 315 ; base MP
    dw 410 ; base ATK
    dw 301 ; base DEF
    dw 189 ; base AGL
    dw 540 ; base INT
    db $c8 ; personality axis $6F
    db $78 ; personality axis $70
    db $46 ; byte 24 ($71)
    db $8c ; personality axis $72
    dw MONSTER_BUBBLEMON ; id 511 Bubblemon: picture: monster id
    db SKILL_BLIZZARD ; skill 1
    db SKILL_BOUNCE ; skill 2
    db SKILL_BOLTSLASH ; skill 3
    db SKILL_BERSERKER ; skill 4
    dw 40130 ; EXP
    db $06 ; join-chance class
    db $5d ; level
    dw 663 ; base HP
    dw 121 ; base MP
    dw 618 ; base ATK
    dw 519 ; base DEF
    dw 487 ; base AGL
    dw 629 ; base INT
    db $32 ; personality axis $6F
    db $78 ; personality axis $70
    db $78 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_ROGUENITE ; id 512 RogueNite: picture: monster id
    db SKILL_DEFENSE ; skill 1
    db SKILL_IRONIZE ; skill 2
    db SKILL_POISONHIT ; skill 3
    db SKILL_KAMIKAZE ; skill 4
    dw 40100 ; EXP
    db $06 ; join-chance class
    db $5c ; level
    dw 802 ; base HP
    dw 228 ; base MP
    dw 703 ; base ATK
    dw 401 ; base DEF
    dw 434 ; base AGL
    dw 627 ; base INT
    db $5a ; personality axis $6F
    db $28 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_PUPPETOR ; id 513 Puppetor: picture: monster id
    db SKILL_BLAZEMOST ; skill 1
    db SKILL_MEGAMAGIC ; skill 2
    db SKILL_EERIELITE ; skill 3
    db SKILL_AHHH ; skill 4
    dw 41130 ; EXP
    db $06 ; join-chance class
    db $51 ; level
    dw 823 ; base HP
    dw 43 ; base MP
    dw 600 ; base ATK
    dw 401 ; base DEF
    dw 336 ; base AGL
    dw 509 ; base INT
    db $0a ; personality axis $6F
    db $c8 ; personality axis $70
    db $0a ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_EXAUCERS ; id 514 Exaucers: picture: monster id
    db SKILL_SACRIFICE ; skill 1
    db SKILL_WHITEFIRE ; skill 2
    db SKILL_LIFESONG ; skill 3
    db SKILL_OUTSIDE ; skill 4
    dw 43989 ; EXP
    db $06 ; join-chance class
    db $5d ; level
    dw 702 ; base HP
    dw 126 ; base MP
    dw 511 ; base ATK
    dw 335 ; base DEF
    dw 567 ; base AGL
    dw 544 ; base INT
    db $78 ; personality axis $6F
    db $1e ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_WHALEMAGE ; id 515 WhaleMage: picture: monster id
    db SKILL_HEALALL ; skill 1
    db SKILL_BOUNCE ; skill 2
    db SKILL_BAZOOCALL ; skill 3
    db SKILL_IMITATE ; skill 4
    dw 42891 ; EXP
    db $06 ; join-chance class
    db $5c ; level
    dw 622 ; base HP
    dw 84 ; base MP
    dw 426 ; base ATK
    dw 402 ; base DEF
    dw 506 ; base AGL
    dw 931 ; base INT
    db $46 ; personality axis $6F
    db $82 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_MEDUSAEYE ; id 516 MedusaEye: picture: monster id
    db SKILL_FAREWELL ; skill 1
    db SKILL_ULTRADOWN ; skill 2
    db SKILL_STORMWIND ; skill 3
    db SKILL_PHEROMONE ; skill 4
    dw 44120 ; EXP
    db $06 ; join-chance class
    db $5d ; level
    dw 701 ; base HP
    dw 132 ; base MP
    dw 549 ; base ATK
    dw 479 ; base DEF
    dw 481 ; base AGL
    dw 740 ; base INT
    db $46 ; personality axis $6F
    db $82 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_METALKING ; id 517 MetalKing: picture: monster id
    db SKILL_SAP ; skill 1
    db SKILL_HUSTLE ; skill 2
    db SKILL_HIGHJUMP ; skill 3
    db SKILL_DEMAGIC ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $32 ; level
    dw 200 ; base HP
    dw 950 ; base MP
    dw 310 ; base ATK
    dw 780 ; base DEF
    dw 840 ; base AGL
    dw 700 ; base INT
    db $d2 ; personality axis $6F
    db $be ; personality axis $70
    db $dc ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_KINGLEO ; id 518 KingLeo: picture: monster id
    db SKILL_POISONHIT ; skill 1
    db SKILL_WARCRY ; skill 2
    db SKILL_BLIZZARD ; skill 3
    db SKILL_QUADHITS ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $37 ; level
    dw 1200 ; base HP
    dw 490 ; base MP
    dw 370 ; base ATK
    dw 480 ; base DEF
    dw 460 ; base AGL
    dw 680 ; base INT
    db $dc ; personality axis $6F
    db $dc ; personality axis $70
    db $a0 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_GOLDGOLEM ; id 519 GoldGolem: picture: monster id
    db SKILL_LIGHTNING ; skill 1
    db SKILL_CHARGEUP ; skill 2
    db SKILL_GUARDIAN ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $32 ; level
    dw 900 ; base HP
    dw 590 ; base MP
    dw 430 ; base ATK
    dw 600 ; base DEF
    dw 370 ; base AGL
    dw 700 ; base INT
    db $dc ; personality axis $6F
    db $dc ; personality axis $70
    db $dc ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_GREATDRAK ; id 520 GreatDrak: picture: monster id
    db SKILL_LIGHTNING ; skill 1
    db SKILL_ICESTORM ; skill 2
    db SKILL_WARCRY ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $34 ; level
    dw 840 ; base HP
    dw 330 ; base MP
    dw 375 ; base ATK
    dw 400 ; base DEF
    dw 299 ; base AGL
    dw 300 ; base INT
    db $dc ; personality axis $6F
    db $be ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_WATABOU ; id 521 Watabou: picture: monster id
    db SKILL_BIGBANG ; skill 1
    db SKILL_CALLHELP ; skill 2
    db SKILL_LOVERAIN ; skill 3
    db $ff ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $28 ; level
    dw 610 ; base HP
    dw 467 ; base MP
    dw 320 ; base ATK
    dw 380 ; base DEF
    dw 178 ; base AGL
    dw 150 ; base INT
    db $c8 ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_DURRAN ; id 522 Durran: picture: monster id
    db SKILL_SQUALLHIT ; skill 1
    db SKILL_GIGASLASH ; skill 2
    db SKILL_ULTRADOWN ; skill 3
    db SKILL_MEDITATE ; skill 4
    dw 0 ; EXP
    db $07 ; join-chance class
    db $35 ; level
    dw 1000 ; base HP
    dw 470 ; base MP
    dw 420 ; base ATK
    dw 430 ; base DEF
    dw 326 ; base AGL
    dw 450 ; base INT
    db $c8 ; personality axis $6F
    db $8c ; personality axis $70
    db $be ; byte 24 ($71)
    db $c8 ; personality axis $72
    dw MONSTER_DEMONITE ; id 523 Demonite: picture: monster id
    db SKILL_CURSE ; skill 1
    db SKILL_ODDDANCE ; skill 2
    db SKILL_EERIELITE ; skill 3
    db $ff ; skill 4
    dw 4700 ; EXP
    db $07 ; join-chance class
    db $2f ; level
    dw 470 ; base HP
    dw 358 ; base MP
    dw 337 ; base ATK
    dw 267 ; base DEF
    dw 358 ; base AGL
    dw 479 ; base INT
    db $8c ; personality axis $6F
    db $32 ; personality axis $70
    db $aa ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_BOSSTROLL ; id 524 BossTroll: picture: monster id
    db SKILL_ROCKTHROW ; skill 1
    db SKILL_PSYCHEUP ; skill 2
    db SKILL_BLADED ; skill 3
    db $ff ; skill 4
    dw 8900 ; EXP
    db $07 ; join-chance class
    db $2e ; level
    dw 580 ; base HP
    dw 210 ; base MP
    dw 449 ; base ATK
    dw 237 ; base DEF
    dw 129 ; base AGL
    dw 288 ; base INT
    db $c8 ; personality axis $6F
    db $0a ; personality axis $70
    db $1e ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_JEWELBAG ; id 525 JewelBag: picture: monster id
    db SKILL_CURSE ; skill 1
    db SKILL_ODDDANCE ; skill 2
    db SKILL_EERIELITE ; skill 3
    db $ff ; skill 4
    dw 6900 ; EXP
    db $07 ; join-chance class
    db $30 ; level
    dw 530 ; base HP
    dw 799 ; base MP
    dw 402 ; base ATK
    dw 427 ; base DEF
    dw 348 ; base AGL
    dw 520 ; base INT
    db $46 ; personality axis $6F
    db $50 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_BONESLAVE ; id 526 BoneSlave: picture: monster id
    db SKILL_SLOWALL ; skill 1
    db SKILL_TWINHITS ; skill 2
    db SKILL_SAMSICALL ; skill 3
    db $ff ; skill 4
    dw 9600 ; EXP
    db $07 ; join-chance class
    db $34 ; level
    dw 500 ; base HP
    dw 320 ; base MP
    dw 387 ; base ATK
    dw 278 ; base DEF
    dw 248 ; base AGL
    dw 450 ; base INT
    db $46 ; personality axis $6F
    db $8c ; personality axis $70
    db $28 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_DEADNOBLE ; id 527 DeadNoble: picture: monster id
    db SKILL_BLIZZARD ; skill 1
    db SKILL_YELLHELP ; skill 2
    db SKILL_EVILSLASH ; skill 3
    db $ff ; skill 4
    dw 20000 ; EXP
    db $07 ; join-chance class
    db $36 ; level
    dw 800 ; base HP
    dw 560 ; base MP
    dw 425 ; base ATK
    dw 349 ; base DEF
    dw 388 ; base AGL
    dw 590 ; base INT
    db $96 ; personality axis $6F
    db $1e ; personality axis $70
    db $a0 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_ROGUENITE ; id 528 RogueNite: picture: monster id
    db SKILL_QUADHITS ; skill 1
    db SKILL_CHARGEUP ; skill 2
    db SKILL_MOUTHSHUT ; skill 3
    db $ff ; skill 4
    dw 7760 ; EXP
    db $07 ; join-chance class
    db $3a ; level
    dw 770 ; base HP
    dw 480 ; base MP
    dw 447 ; base ATK
    dw 423 ; base DEF
    dw 278 ; base AGL
    dw 560 ; base INT
    db $c8 ; personality axis $6F
    db $14 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_BALZAK ; id 529 Balzak: picture: monster id
    db SKILL_DRAKSLASH ; skill 1
    db SKILL_BERSERKER ; skill 2
    db SKILL_SUCKALL ; skill 3
    db $ff ; skill 4
    dw 13500 ; EXP
    db $07 ; join-chance class
    db $38 ; level
    dw 1300 ; base HP
    dw 570 ; base MP
    dw 488 ; base ATK
    dw 317 ; base DEF
    dw 347 ; base AGL
    dw 600 ; base INT
    db $b4 ; personality axis $6F
    db $0a ; personality axis $70
    db $aa ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_VOODOLL ; id 530 Voodoll: picture: monster id
    db SKILL_ULTRADOWN ; skill 1
    db SKILL_THICKFOG ; skill 2
    db SKILL_IMITATE ; skill 3
    db $ff ; skill 4
    dw 6000 ; EXP
    db $07 ; join-chance class
    db $3a ; level
    dw 670 ; base HP
    dw 680 ; base MP
    dw 340 ; base ATK
    dw 568 ; base DEF
    dw 459 ; base AGL
    dw 700 ; base INT
    db $46 ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_GATEGUARD ; id 531 GateGuard: picture: monster id
    db SKILL_EXPLODET ; skill 1
    db SKILL_HEALUS ; skill 2
    db SKILL_RAINSLASH ; skill 3
    db $ff ; skill 4
    dw 7800 ; EXP
    db $07 ; join-chance class
    db $35 ; level
    dw 680 ; base HP
    dw 490 ; base MP
    dw 378 ; base ATK
    dw 359 ; base DEF
    dw 367 ; base AGL
    dw 590 ; base INT
    db $82 ; personality axis $6F
    db $c8 ; personality axis $70
    db $aa ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_MADMIRROR ; id 532 MadMirror: picture: monster id
    db SKILL_INFERMOST ; skill 1
    db SKILL_BOUNCE ; skill 2
    db SKILL_RADIANT ; skill 3
    db $ff ; skill 4
    dw 7800 ; EXP
    db $07 ; join-chance class
    db $33 ; level
    dw 580 ; base HP
    dw 780 ; base MP
    dw 290 ; base ATK
    dw 489 ; base DEF
    dw 444 ; base AGL
    dw 680 ; base INT
    db $1e ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_GRAKOS ; id 533 Grakos: picture: monster id
    db SKILL_TIDALWAVE ; skill 1
    db SKILL_REVIVE ; skill 2
    db SKILL_MPASSMORE ; skill 3
    db $ff ; skill 4
    dw 7800 ; EXP
    db $07 ; join-chance class
    db $36 ; level
    dw 780 ; base HP
    dw 880 ; base MP
    dw 357 ; base ATK
    dw 455 ; base DEF
    dw 328 ; base AGL
    dw 700 ; base INT
    db $46 ; personality axis $6F
    db $d2 ; personality axis $70
    db $aa ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_SCALLOPA ; id 534 Scallopa: picture: monster id
    db SKILL_INCREASE ; skill 1
    db SKILL_MAGICWALL ; skill 2
    db SKILL_RADIANT ; skill 3
    db $ff ; skill 4
    dw 4673 ; EXP
    db $04 ; join-chance class
    db $2c ; level
    dw 328 ; base HP
    dw 245 ; base MP
    dw 288 ; base ATK
    dw 379 ; base DEF
    dw 229 ; base AGL
    dw 410 ; base INT
    db $3c ; personality axis $6F
    db $78 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_SNAILY ; id 535 Snaily: picture: monster id
    db SKILL_BLIZZARD ; skill 1
    db SKILL_NUMBOFF ; skill 2
    db SKILL_YELLHELP ; skill 3
    db $ff ; skill 4
    dw 4211 ; EXP
    db $04 ; join-chance class
    db $2d ; level
    dw 248 ; base HP
    dw 102 ; base MP
    dw 241 ; base ATK
    dw 399 ; base DEF
    dw 348 ; base AGL
    dw 440 ; base INT
    db $c8 ; personality axis $6F
    db $28 ; personality axis $70
    db $50 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_CLAWSTER ; id 536 Clawster: picture: monster id
    db SKILL_DRAKSLASH ; skill 1
    db SKILL_METALCUT ; skill 2
    db SKILL_QUADHITS ; skill 3
    db $ff ; skill 4
    dw 4721 ; EXP
    db $04 ; join-chance class
    db $2e ; level
    dw 358 ; base HP
    dw 330 ; base MP
    dw 320 ; base ATK
    dw 299 ; base DEF
    dw 321 ; base AGL
    dw 390 ; base INT
    db $96 ; personality axis $6F
    db $96 ; personality axis $70
    db $1e ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_SHADOW ; id 537 Shadow: picture: monster id
    db SKILL_ICEAIR ; skill 1
    db SKILL_THICKFOG ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 4372 ; EXP
    db $07 ; join-chance class
    db $2b ; level
    dw 290 ; base HP
    dw 310 ; base MP
    dw 314 ; base ATK
    dw 324 ; base DEF
    dw 357 ; base AGL
    dw 500 ; base INT
    db $1e ; personality axis $6F
    db $14 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_MIMIC ; id 538 Mimic: picture: monster id
    db SKILL_BLAZEMORE ; skill 1
    db SKILL_BEAT ; skill 2
    db $ff ; skill 3
    db $ff ; skill 4
    dw 5900 ; EXP
    db $07 ; join-chance class
    db $2d ; level
    dw 400 ; base HP
    dw 490 ; base MP
    dw 360 ; base ATK
    dw 314 ; base DEF
    dw 490 ; base AGL
    dw 450 ; base INT
    db $6e ; personality axis $6F
    db $28 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $64 ; personality axis $72
    dw MONSTER_METALKING ; id 539 MetalKing: picture: monster id
    db SKILL_INFERMOST ; skill 1
    db SKILL_EVILSLASH ; skill 2
    db SKILL_EERIELITE ; skill 3
    db SKILL_GEYSER ; skill 4
    dw 39600 ; EXP
    db $07 ; join-chance class
    db $30 ; level
    dw 600 ; base HP
    dw 200 ; base MP
    dw 410 ; base ATK
    dw 859 ; base DEF
    dw 320 ; base AGL
    dw 160 ; base INT
    db $14 ; personality axis $6F
    db $50 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_RAINHAWK ; id 540 RainHawk: picture: monster id
    db SKILL_BIGBANG ; skill 1
    db SKILL_DEMAGIC ; skill 2
    db SKILL_WINDBEAST ; skill 3
    db $ff ; skill 4
    dw 6600 ; EXP
    db $07 ; join-chance class
    db $63 ; level
    dw 3500 ; base HP
    dw 520 ; base MP
    dw 710 ; base ATK
    dw 540 ; base DEF
    dw 250 ; base AGL
    dw 330 ; base INT
    db $aa ; personality axis $6F
    db $1e ; personality axis $70
    db $82 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_COATOL ; id 541 Coatol: picture: monster id
    db SKILL_HEALUS ; skill 1
    db SKILL_TIDALWAVE ; skill 2
    db SKILL_DIAGOCALL ; skill 3
    db SKILL_BIGTRIP ; skill 4
    dw 7300 ; EXP
    db $07 ; join-chance class
    db $2e ; level
    dw 1500 ; base HP
    dw 210 ; base MP
    dw 600 ; base ATK
    dw 600 ; base DEF
    dw 300 ; base AGL
    dw 255 ; base INT
    db $5a ; personality axis $6F
    db $8c ; personality axis $70
    db $64 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_PHOENIX ; id 542 Phoenix: picture: monster id
    db SKILL_BLAZEMOST ; skill 1
    db SKILL_INCREASE ; skill 2
    db SKILL_FIRESLASH ; skill 3
    db SKILL_MASSACRE ; skill 4
    dw 9940 ; EXP
    db $06 ; join-chance class
    db $3a ; level
    dw 376 ; base HP
    dw 289 ; base MP
    dw 328 ; base ATK
    dw 328 ; base DEF
    dw 251 ; base AGL
    dw 363 ; base INT
    db $96 ; personality axis $6F
    db $28 ; personality axis $70
    db $1e ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_SHANTAK ; id 543 Shantak: picture: monster id
    db SKILL_EXPLODET ; skill 1
    db SKILL_LIGHTNING ; skill 2
    db SKILL_CURSE ; skill 3
    db SKILL_MEDITATE ; skill 4
    dw 10620 ; EXP
    db $06 ; join-chance class
    db $3b ; level
    dw 478 ; base HP
    dw 180 ; base MP
    dw 356 ; base ATK
    dw 267 ; base DEF
    dw 348 ; base AGL
    dw 678 ; base INT
    db $aa ; personality axis $6F
    db $50 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_BLIZZARDY ; id 544 Blizzardy: picture: monster id
    db SKILL_STOPSPELL ; skill 1
    db SKILL_ICESTORM ; skill 2
    db SKILL_ICESLASH ; skill 3
    db SKILL_LOVERAIN ; skill 4
    dw 9940 ; EXP
    db $06 ; join-chance class
    db $39 ; level
    dw 382 ; base HP
    dw 438 ; base MP
    dw 295 ; base ATK
    dw 256 ; base DEF
    dw 470 ; base AGL
    dw 590 ; base INT
    db $5a ; personality axis $6F
    db $aa ; personality axis $70
    db $3c ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_SKULLGON ; id 545 Skullgon: picture: monster id
    db SKILL_PANICALL ; skill 1
    db SKILL_WHITEAIR ; skill 2
    db SKILL_BEASTCUT ; skill 3
    db SKILL_ROBDANCE ; skill 4
    dw 9533 ; EXP
    db $06 ; join-chance class
    db $3b ; level
    dw 477 ; base HP
    dw 376 ; base MP
    dw 415 ; base ATK
    dw 231 ; base DEF
    dw 452 ; base AGL
    dw 478 ; base INT
    db $82 ; personality axis $6F
    db $6e ; personality axis $70
    db $a0 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_AKUBAR ; id 546 Akubar: picture: monster id
    db SKILL_FIREBOLT ; skill 1
    db SKILL_INCREASE ; skill 2
    db SKILL_BEDRAGON ; skill 3
    db SKILL_QUADHITS ; skill 4
    dw 11470 ; EXP
    db $06 ; join-chance class
    db $37 ; level
    dw 511 ; base HP
    dw 465 ; base MP
    dw 324 ; base ATK
    dw 310 ; base DEF
    dw 382 ; base AGL
    dw 648 ; base INT
    db $8c ; personality axis $6F
    db $0a ; personality axis $70
    db $78 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_DARKHORN ; id 547 DarkHorn: picture: monster id
    db SKILL_SLEEPALL ; skill 1
    db SKILL_BOUNCE ; skill 2
    db SKILL_SHEARS ; skill 3
    db SKILL_CHARGEUP ; skill 4
    dw 11239 ; EXP
    db $06 ; join-chance class
    db $38 ; level
    dw 534 ; base HP
    dw 100 ; base MP
    dw 375 ; base ATK
    dw 269 ; base DEF
    dw 351 ; base AGL
    dw 667 ; base INT
    db $64 ; personality axis $6F
    db $8c ; personality axis $70
    db $1e ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_SERPENTIA ; id 548 Serpentia: picture: monster id
    db SKILL_BOLTSLASH ; skill 1
    db SKILL_BIRDBLOW ; skill 2
    db SKILL_EVILSLASH ; skill 3
    db SKILL_SANDSTORM ; skill 4
    dw 9994 ; EXP
    db $06 ; join-chance class
    db $35 ; level
    dw 437 ; base HP
    dw 438 ; base MP
    dw 388 ; base ATK
    dw 178 ; base DEF
    dw 338 ; base AGL
    dw 537 ; base INT
    db $be ; personality axis $6F
    db $78 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_SUPERTEN ; id 549 SuperTen: picture: monster id
    db SKILL_SPEEDUP ; skill 1
    db SKILL_SLEEPAIR ; skill 2
    db SKILL_LUREDANCE ; skill 3
    db SKILL_DANCESHUT ; skill 4
    dw 9320 ; EXP
    db $06 ; join-chance class
    db $3b ; level
    dw 387 ; base HP
    dw 363 ; base MP
    dw 321 ; base ATK
    dw 272 ; base DEF
    dw 358 ; base AGL
    dw 577 ; base INT
    db $82 ; personality axis $6F
    db $8c ; personality axis $70
    db $64 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_UNICORN ; id 550 Unicorn: picture: monster id
    db SKILL_HEALUS ; skill 1
    db SKILL_TWINHITS ; skill 2
    db SKILL_DRAKSLASH ; skill 3
    db SKILL_LIFEDANCE ; skill 4
    dw 9561 ; EXP
    db $06 ; join-chance class
    db $36 ; level
    dw 369 ; base HP
    dw 80 ; base MP
    dw 352 ; base ATK
    dw 339 ; base DEF
    dw 418 ; base AGL
    dw 674 ; base INT
    db $fa ; personality axis $6F
    db $c8 ; personality axis $70
    db $14 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_KITEHAWK ; id 551 KiteHawk: picture: monster id
    db SKILL_MPASSMORE ; skill 1
    db SKILL_SPEEDUP ; skill 2
    db SKILL_SURROUND ; skill 3
    db SKILL_AQUAWALL ; skill 4
    dw 9477 ; EXP
    db $06 ; join-chance class
    db $39 ; level
    dw 346 ; base HP
    dw 328 ; base MP
    dw 298 ; base ATK
    dw 308 ; base DEF
    dw 348 ; base AGL
    dw 465 ; base INT
    db $46 ; personality axis $6F
    db $8c ; personality axis $70
    db $b4 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_FOXFIRE ; id 552 FoxFire: picture: monster id
    db SKILL_SCORCHING ; skill 1
    db SKILL_CLEANCUT ; skill 2
    db SKILL_RADIANT ; skill 3
    db SKILL_IMITATE ; skill 4
    dw 9344 ; EXP
    db $06 ; join-chance class
    db $38 ; level
    dw 359 ; base HP
    dw 417 ; base MP
    dw 311 ; base ATK
    dw 276 ; base DEF
    dw 293 ; base AGL
    dw 478 ; base INT
    db $96 ; personality axis $6F
    db $96 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_METALDRAK ; id 553 MetalDrak: picture: monster id
    db SKILL_MAGICWALL ; skill 1
    db SKILL_SLIMEBLOW ; skill 2
    db SKILL_CHARGEUP ; skill 3
    db SKILL_STRONGD ; skill 4
    dw 9679 ; EXP
    db $06 ; join-chance class
    db $3b ; level
    dw 458 ; base HP
    dw 547 ; base MP
    dw 394 ; base ATK
    dw 338 ; base DEF
    dw 318 ; base AGL
    dw 543 ; base INT
    db $a0 ; personality axis $6F
    db $a0 ; personality axis $70
    db $a0 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_AXESHARK ; id 554 AxeShark: picture: monster id
    db SKILL_PANICALL ; skill 1
    db SKILL_VACUSLASH ; skill 2
    db SKILL_POISONAIR ; skill 3
    db SKILL_SIDESTEP ; skill 4
    dw 13498 ; EXP
    db $06 ; join-chance class
    db $3d ; level
    dw 499 ; base HP
    dw 389 ; base MP
    dw 401 ; base ATK
    dw 259 ; base DEF
    dw 285 ; base AGL
    dw 581 ; base INT
    db $b4 ; personality axis $6F
    db $0a ; personality axis $70
    db $28 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_STONEMAN ; id 555 StoneMan: picture: monster id
    db SKILL_REVIVE ; skill 1
    db SKILL_AQUACUT ; skill 2
    db SKILL_MASSACRE ; skill 3
    db SKILL_SUCKALL ; skill 4
    dw 12447 ; EXP
    db $06 ; join-chance class
    db $3f ; level
    dw 589 ; base HP
    dw 467 ; base MP
    dw 428 ; base ATK
    dw 261 ; base DEF
    dw 338 ; base AGL
    dw 576 ; base INT
    db $fa ; personality axis $6F
    db $b4 ; personality axis $70
    db $50 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_MEDUSAEYE ; id 556 MedusaEye: picture: monster id
    db SKILL_WATERSHOT ; skill 1
    db SKILL_ZOMBIECUT ; skill 2
    db SKILL_PANIDANCE ; skill 3
    db SKILL_TATSUCALL ; skill 4
    dw 10440 ; EXP
    db $06 ; join-chance class
    db $3e ; level
    dw 437 ; base HP
    dw 110 ; base MP
    dw 338 ; base ATK
    dw 317 ; base DEF
    dw 399 ; base AGL
    dw 612 ; base INT
    db $1e ; personality axis $6F
    db $8c ; personality axis $70
    db $96 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_MADHORNET ; id 557 MadHornet: picture: monster id
    db SKILL_TAKEMAGIC ; skill 1
    db SKILL_DEVILCUT ; skill 2
    db SKILL_PARALYZE ; skill 3
    db SKILL_HIGHJUMP ; skill 4
    dw 10130 ; EXP
    db $06 ; join-chance class
    db $3f ; level
    dw 476 ; base HP
    dw 399 ; base MP
    dw 378 ; base ATK
    dw 271 ; base DEF
    dw 453 ; base AGL
    dw 531 ; base INT
    db $a0 ; personality axis $6F
    db $46 ; personality axis $70
    db $5a ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_ONIONO ; id 558 Oniono: picture: monster id
    db SKILL_ANTIDOTE ; skill 1
    db SKILL_BUGBLOW ; skill 2
    db SKILL_PSYCHEUP ; skill 3
    db SKILL_POISONAIR ; skill 4
    dw 10577 ; EXP
    db $06 ; join-chance class
    db $41 ; level
    dw 472 ; base HP
    dw 422 ; base MP
    dw 376 ; base ATK
    dw 320 ; base DEF
    dw 348 ; base AGL
    dw 537 ; base INT
    db $32 ; personality axis $6F
    db $b4 ; personality axis $70
    db $78 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_TAILEATER ; id 559 TailEater: picture: monster id
    db SKILL_BLIZZARD ; skill 1
    db SKILL_SLOWALL ; skill 2
    db SKILL_BOUNCE ; skill 3
    db SKILL_TWINSLASH ; skill 4
    dw 10120 ; EXP
    db $06 ; join-chance class
    db $3f ; level
    dw 367 ; base HP
    dw 489 ; base MP
    dw 324 ; base ATK
    dw 337 ; base DEF
    dw 365 ; base AGL
    dw 587 ; base INT
    db $50 ; personality axis $6F
    db $6e ; personality axis $70
    db $b4 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_BEASTNITE ; id 560 BeastNite: picture: monster id
    db SKILL_BEAT ; skill 1
    db SKILL_TRANSFORM ; skill 2
    db SKILL_YELLHELP ; skill 3
    db SKILL_METALCUT ; skill 4
    dw 10489 ; EXP
    db $06 ; join-chance class
    db $40 ; level
    dw 537 ; base HP
    dw 105 ; base MP
    dw 415 ; base ATK
    dw 309 ; base DEF
    dw 329 ; base AGL
    dw 534 ; base INT
    db $c8 ; personality axis $6F
    db $8c ; personality axis $70
    db $82 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_MIMESLIME ; id 561 MimeSlime: picture: monster id
    db SKILL_THORDAIN ; skill 1
    db SKILL_CHANCE ; skill 2
    db SKILL_RAINSLASH ; skill 3
    db SKILL_FOCUS ; skill 4
    dw 14590 ; EXP
    db $06 ; join-chance class
    db $43 ; level
    dw 467 ; base HP
    dw 632 ; base MP
    dw 358 ; base ATK
    dw 321 ; base DEF
    dw 460 ; base AGL
    dw 632 ; base INT
    db $78 ; personality axis $6F
    db $8c ; personality axis $70
    db $82 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_MADDRAGON ; id 562 MadDragon: picture: monster id
    db SKILL_SCORCHING ; skill 1
    db SKILL_MASSACRE ; skill 2
    db SKILL_DANCESHUT ; skill 3
    db SKILL_GUARDIAN ; skill 4
    dw 11270 ; EXP
    db $06 ; join-chance class
    db $40 ; level
    dw 527 ; base HP
    dw 446 ; base MP
    dw 438 ; base ATK
    dw 262 ; base DEF
    dw 300 ; base AGL
    dw 349 ; base INT
    db $1e ; personality axis $6F
    db $1e ; personality axis $70
    db $3c ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_WINGSNAKE ; id 563 WingSnake: picture: monster id
    db SKILL_VACUUM ; skill 1
    db SKILL_BERSERKER ; skill 2
    db SKILL_HUSTLE ; skill 3
    db SKILL_AQUAWALL ; skill 4
    dw 10540 ; EXP
    db $06 ; join-chance class
    db $41 ; level
    dw 557 ; base HP
    dw 90 ; base MP
    dw 387 ; base ATK
    dw 277 ; base DEF
    dw 427 ; base AGL
    dw 458 ; base INT
    db $8c ; personality axis $6F
    db $50 ; personality axis $70
    db $aa ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_OROCHI ; id 564 Orochi: picture: monster id
    db SKILL_HEALALL ; skill 1
    db SKILL_DEFENSE ; skill 2
    db SKILL_MULTICUT ; skill 3
    db SKILL_ULTRADOWN ; skill 4
    dw 15789 ; EXP
    db $06 ; join-chance class
    db $42 ; level
    dw 627 ; base HP
    dw 75 ; base MP
    dw 447 ; base ATK
    dw 310 ; base DEF
    dw 542 ; base AGL
    dw 678 ; base INT
    db $c8 ; personality axis $6F
    db $c8 ; personality axis $70
    db $b4 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_TRUMPETER ; id 565 Trumpeter: picture: monster id
    db SKILL_CURSEOFF ; skill 1
    db SKILL_TAKEMAGIC ; skill 2
    db SKILL_ROCKTHROW ; skill 3
    db SKILL_DIAGOCALL ; skill 4
    dw 11367 ; EXP
    db $06 ; join-chance class
    db $40 ; level
    dw 638 ; base HP
    dw 98 ; base MP
    dw 418 ; base ATK
    dw 429 ; base DEF
    dw 311 ; base AGL
    dw 487 ; base INT
    db $b4 ; personality axis $6F
    db $82 ; personality axis $70
    db $b4 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_WYVERN ; id 566 Wyvern: picture: monster id
    db SKILL_MPASSMOST ; skill 1
    db SKILL_BLAZEAIR ; skill 2
    db SKILL_ICEAIR ; skill 3
    db SKILL_SUCKAIR ; skill 4
    dw 12455 ; EXP
    db $06 ; join-chance class
    db $43 ; level
    dw 523 ; base HP
    dw 80 ; base MP
    dw 407 ; base ATK
    dw 380 ; base DEF
    dw 358 ; base AGL
    dw 511 ; base INT
    db $aa ; personality axis $6F
    db $78 ; personality axis $70
    db $96 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_DEVIPINE ; id 567 Devipine: picture: monster id
    db SKILL_BEAT ; skill 1
    db SKILL_SLOWALL ; skill 2
    db SKILL_SQUALLHIT ; skill 3
    db SKILL_SIDESTEP ; skill 4
    dw 13477 ; EXP
    db $06 ; join-chance class
    db $44 ; level
    dw 489 ; base HP
    dw 477 ; base MP
    dw 388 ; base ATK
    dw 356 ; base DEF
    dw 348 ; base AGL
    dw 537 ; base INT
    db $64 ; personality axis $6F
    db $96 ; personality axis $70
    db $aa ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_SNAPPER ; id 568 Snapper: picture: monster id
    db SKILL_BARRIER ; skill 1
    db SKILL_LIGHTNING ; skill 2
    db SKILL_POISONHIT ; skill 3
    db SKILL_SANDSTORM ; skill 4
    dw 12319 ; EXP
    db $06 ; join-chance class
    db $41 ; level
    dw 563 ; base HP
    dw 426 ; base MP
    dw 359 ; base ATK
    dw 365 ; base DEF
    dw 342 ; base AGL
    dw 578 ; base INT
    db $8c ; personality axis $6F
    db $82 ; personality axis $70
    db $a0 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_STAGBUG ; id 569 StagBug: picture: monster id
    db SKILL_EXPLODET ; skill 1
    db SKILL_IRONIZE ; skill 2
    db SKILL_NAPATTACK ; skill 3
    db SKILL_TWINSLASH ; skill 4
    dw 11450 ; EXP
    db $06 ; join-chance class
    db $43 ; level
    dw 467 ; base HP
    dw 523 ; base MP
    dw 374 ; base ATK
    dw 421 ; base DEF
    dw 373 ; base AGL
    dw 499 ; base INT
    db $6e ; personality axis $6F
    db $8c ; personality axis $70
    db $78 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_ARMYCRAB ; id 570 ArmyCrab: picture: monster id
    db SKILL_INCREASE ; skill 1
    db SKILL_TWINHITS ; skill 2
    db SKILL_LIGHTNING ; skill 3
    db SKILL_BIGTRIP ; skill 4
    dw 13699 ; EXP
    db $06 ; join-chance class
    db $41 ; level
    dw 446 ; base HP
    dw 30 ; base MP
    dw 392 ; base ATK
    dw 445 ; base DEF
    dw 292 ; base AGL
    dw 578 ; base INT
    db $5a ; personality axis $6F
    db $46 ; personality axis $70
    db $50 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_ARCDEMON ; id 571 ArcDemon: picture: monster id
    db SKILL_SACRIFICE ; skill 1
    db SKILL_DRAKSLASH ; skill 2
    db SKILL_EVILSLASH ; skill 3
    db SKILL_DEMAGIC ; skill 4
    dw 16980 ; EXP
    db $06 ; join-chance class
    db $47 ; level
    dw 677 ; base HP
    dw 98 ; base MP
    dw 476 ; base ATK
    dw 382 ; base DEF
    dw 381 ; base AGL
    dw 649 ; base INT
    db $aa ; personality axis $6F
    db $82 ; personality axis $70
    db $50 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_1EYECLOWN ; id 572 1EyeClown: picture: monster id
    db SKILL_BLIZZARD ; skill 1
    db SKILL_ROBMAGIC ; skill 2
    db SKILL_MAGICWALL ; skill 3
    db SKILL_SHEARS ; skill 4
    dw 15788 ; EXP
    db $06 ; join-chance class
    db $49 ; level
    dw 586 ; base HP
    dw 678 ; base MP
    dw 378 ; base ATK
    dw 364 ; base DEF
    dw 346 ; base AGL
    dw 636 ; base INT
    db $28 ; personality axis $6F
    db $78 ; personality axis $70
    db $82 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_MADKNIGHT ; id 573 MadKnight: picture: monster id
    db SKILL_BOUNCE ; skill 1
    db SKILL_HELLBLAST ; skill 2
    db SKILL_FIRESLASH ; skill 3
    db SKILL_RAINSLASH ; skill 4
    dw 16244 ; EXP
    db $06 ; join-chance class
    db $49 ; level
    dw 650 ; base HP
    dw 60 ; base MP
    dw 446 ; base ATK
    dw 416 ; base DEF
    dw 359 ; base AGL
    dw 535 ; base INT
    db $c8 ; personality axis $6F
    db $0a ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_CAPTDEAD ; id 574 CaptDead: picture: monster id
    db SKILL_SLOWALL ; skill 1
    db SKILL_METALCUT ; skill 2
    db SKILL_GEYSER ; skill 3
    db SKILL_AQUAWALL ; skill 4
    dw 15999 ; EXP
    db $06 ; join-chance class
    db $4a ; level
    dw 646 ; base HP
    dw 589 ; base MP
    dw 466 ; base ATK
    dw 433 ; base DEF
    dw 300 ; base AGL
    dw 555 ; base INT
    db $aa ; personality axis $6F
    db $a0 ; personality axis $70
    db $82 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_SERVANT ; id 575 Servant: picture: monster id
    db SKILL_BEAT ; skill 1
    db SKILL_SLEEPALL ; skill 2
    db SKILL_QUADHITS ; skill 3
    db SKILL_CURSE ; skill 4
    dw 16893 ; EXP
    db $06 ; join-chance class
    db $49 ; level
    dw 638 ; base HP
    dw 30 ; base MP
    dw 458 ; base ATK
    dw 414 ; base DEF
    dw 356 ; base AGL
    dw 589 ; base INT
    db $be ; personality axis $6F
    db $b4 ; personality axis $70
    db $be ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_LAVAMAN ; id 576 LavaMan: picture: monster id
    db SKILL_DECHAOS ; skill 1
    db SKILL_BIGBANG ; skill 2
    db SKILL_SICKLICK ; skill 3
    db SKILL_DODGE ; skill 4
    dw 21300 ; EXP
    db $06 ; join-chance class
    db $4d ; level
    dw 746 ; base HP
    dw 48 ; base MP
    dw 500 ; base ATK
    dw 451 ; base DEF
    dw 348 ; base AGL
    dw 599 ; base INT
    db $aa ; personality axis $6F
    db $be ; personality axis $70
    db $a0 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_BOMBCRAG ; id 577 BombCrag: picture: monster id
    db SKILL_INCREASE ; skill 1
    db SKILL_TIDALWAVE ; skill 2
    db SKILL_SURGE ; skill 3
    db SKILL_BLADED ; skill 4
    dw 20100 ; EXP
    db $06 ; join-chance class
    db $4e ; level
    dw 729 ; base HP
    dw 100 ; base MP
    dw 408 ; base ATK
    dw 517 ; base DEF
    dw 277 ; base AGL
    dw 588 ; base INT
    db $14 ; personality axis $6F
    db $46 ; personality axis $70
    db $50 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_RUSHFISH ; id 578 RushFish: picture: monster id
    db SKILL_SLEEPALL ; skill 1
    db SKILL_TIDALWAVE ; skill 2
    db SKILL_PSYCHEUP ; skill 3
    db SKILL_KAMIKAZE ; skill 4
    dw 19878 ; EXP
    db $06 ; join-chance class
    db $4c ; level
    dw 697 ; base HP
    dw 45 ; base MP
    dw 387 ; base ATK
    dw 460 ; base DEF
    dw 396 ; base AGL
    dw 518 ; base INT
    db $aa ; personality axis $6F
    db $6e ; personality axis $70
    db $1e ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_WHALEMAGE ; id 579 WhaleMage: picture: monster id
    db SKILL_TWINHITS ; skill 1
    db SKILL_BEDRAGON ; skill 2
    db SKILL_SQUALLHIT ; skill 3
    db SKILL_ROBDANCE ; skill 4
    dw 21040 ; EXP
    db $06 ; join-chance class
    db $4e ; level
    dw 716 ; base HP
    dw 55 ; base MP
    dw 460 ; base ATK
    dw 381 ; base DEF
    dw 423 ; base AGL
    dw 668 ; base INT
    db $64 ; personality axis $6F
    db $b4 ; personality axis $70
    db $82 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_SPOTKING ; id 580 SpotKing: picture: monster id
    db SKILL_INFERMOST ; skill 1
    db SKILL_PANICALL ; skill 2
    db SKILL_MULTICUT ; skill 3
    db SKILL_SEALPRAY ; skill 4
    dw 20569 ; EXP
    db $06 ; join-chance class
    db $4f ; level
    dw 738 ; base HP
    dw 58 ; base MP
    dw 408 ; base ATK
    dw 390 ; base DEF
    dw 394 ; base AGL
    dw 678 ; base INT
    db $b4 ; personality axis $6F
    db $5a ; personality axis $70
    db $8c ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_SLIMEBORG ; id 581 SlimeBorg: picture: monster id
    db SKILL_FIREBOLT ; skill 1
    db SKILL_SPEEDUP ; skill 2
    db SKILL_YELLHELP ; skill 3
    db SKILL_EERIELITE ; skill 4
    dw 20100 ; EXP
    db $06 ; join-chance class
    db $52 ; level
    dw 779 ; base HP
    dw 136 ; base MP
    dw 415 ; base ATK
    dw 437 ; base DEF
    dw 370 ; base AGL
    dw 659 ; base INT
    db $8c ; personality axis $6F
    db $28 ; personality axis $70
    db $78 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_LIZARDMAN ; id 582 LizardMan: picture: monster id
    db SKILL_BOUNCE ; skill 1
    db SKILL_GIGASLASH ; skill 2
    db SKILL_ULTRADOWN ; skill 3
    db SKILL_SAMSICALL ; skill 4
    dw 21387 ; EXP
    db $06 ; join-chance class
    db $54 ; level
    dw 763 ; base HP
    dw 97 ; base MP
    dw 638 ; base ATK
    dw 481 ; base DEF
    dw 473 ; base AGL
    dw 646 ; base INT
    db $c8 ; personality axis $6F
    db $82 ; personality axis $70
    db $78 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_GREATDRAK ; id 583 GreatDrak: picture: monster id
    db SKILL_INFERMOST ; skill 1
    db SKILL_WHITEAIR ; skill 2
    db SKILL_FOCUS ; skill 3
    db SKILL_GUARDIAN ; skill 4
    dw 23487 ; EXP
    db $06 ; join-chance class
    db $53 ; level
    dw 777 ; base HP
    dw 328 ; base MP
    dw 673 ; base ATK
    dw 621 ; base DEF
    dw 410 ; base AGL
    dw 588 ; base INT
    db $c8 ; personality axis $6F
    db $aa ; personality axis $70
    db $b4 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_MADCAT ; id 584 MadCat: picture: monster id
    db SKILL_SLOWALL ; skill 1
    db SKILL_YELLHELP ; skill 2
    db SKILL_DRAKSLASH ; skill 3
    db SKILL_SQUALLHIT ; skill 4
    dw 23555 ; EXP
    db $06 ; join-chance class
    db $53 ; level
    dw 759 ; base HP
    dw 428 ; base MP
    dw 661 ; base ATK
    dw 446 ; base DEF
    dw 538 ; base AGL
    dw 634 ; base INT
    db $be ; personality axis $6F
    db $78 ; personality axis $70
    db $64 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_EMYU ; id 585 Emyu: picture: monster id
    db SKILL_BLIZZARD ; skill 1
    db SKILL_SLEEPALL ; skill 2
    db SKILL_RAINSLASH ; skill 3
    db SKILL_LUREDANCE ; skill 4
    dw 24589 ; EXP
    db $06 ; join-chance class
    db $55 ; level
    dw 739 ; base HP
    dw 399 ; base MP
    dw 627 ; base ATK
    dw 470 ; base DEF
    dw 519 ; base AGL
    dw 622 ; base INT
    db $96 ; personality axis $6F
    db $b4 ; personality axis $70
    db $28 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_HORNBEET ; id 586 HornBeet: picture: monster id
    db SKILL_SURROUND ; skill 1
    db SKILL_PSYCHEUP ; skill 2
    db SKILL_DANCESHUT ; skill 3
    db SKILL_MOUTHSHUT ; skill 4
    dw 24589 ; EXP
    db $06 ; join-chance class
    db $56 ; level
    dw 728 ; base HP
    dw 167 ; base MP
    dw 589 ; base ATK
    dw 536 ; base DEF
    dw 409 ; base AGL
    dw 647 ; base INT
    db $82 ; personality axis $6F
    db $96 ; personality axis $70
    db $be ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_OGRE ; id 587 Ogre: picture: monster id
    db SKILL_TWINHITS ; skill 1
    db SKILL_BEDRAGON ; skill 2
    db SKILL_ROCKTHROW ; skill 3
    db SKILL_BERSERKER ; skill 4
    dw 23469 ; EXP
    db $06 ; join-chance class
    db $55 ; level
    dw 757 ; base HP
    dw 89 ; base MP
    dw 642 ; base ATK
    dw 475 ; base DEF
    dw 458 ; base AGL
    dw 638 ; base INT
    db $be ; personality axis $6F
    db $14 ; personality axis $70
    db $5a ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_PUTREPUP ; id 588 PutrePup: picture: monster id
    db SKILL_NUMBOFF ; skill 1
    db SKILL_MAGICWALL ; skill 2
    db SKILL_DEVILCUT ; skill 3
    db SKILL_POISONAIR ; skill 4
    dw 22459 ; EXP
    db $06 ; join-chance class
    db $56 ; level
    dw 729 ; base HP
    dw 20 ; base MP
    dw 612 ; base ATK
    dw 407 ; base DEF
    dw 446 ; base AGL
    dw 690 ; base INT
    db $3c ; personality axis $6F
    db $82 ; personality axis $70
    db $8c ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_ROBOSTER2 ; id 589 Roboster2: picture: monster id
    db SKILL_THORDAIN ; skill 1
    db SKILL_REVIVE ; skill 2
    db SKILL_SQUALLHIT ; skill 3
    db SKILL_RADIANT ; skill 4
    dw 26798 ; EXP
    db $06 ; join-chance class
    db $57 ; level
    dw 767 ; base HP
    dw 120 ; base MP
    dw 648 ; base ATK
    dw 650 ; base DEF
    dw 502 ; base AGL
    dw 688 ; base INT
    db $be ; personality axis $6F
    db $fa ; personality axis $70
    db $00 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_GOLDGOLEM ; id 590 GoldGolem: picture: monster id
    db SKILL_VACUUM ; skill 1
    db SKILL_CHARGEUP ; skill 2
    db SKILL_SURGE ; skill 3
    db SKILL_THICKFOG ; skill 4
    dw 34578 ; EXP
    db $06 ; join-chance class
    db $56 ; level
    dw 838 ; base HP
    dw 138 ; base MP
    dw 671 ; base ATK
    dw 526 ; base DEF
    dw 515 ; base AGL
    dw 666 ; base INT
    db $c8 ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $96 ; personality axis $72
    dw MONSTER_WHITEKING ; id 591 WhiteKing: picture: monster id
    db SKILL_EXPLODET ; skill 1
    db SKILL_BLIZZARD ; skill 2
    db SKILL_HEALALL ; skill 3
    db SKILL_MAGICWALL ; skill 4
    dw 37698 ; EXP
    db $06 ; join-chance class
    db $58 ; level
    dw 812 ; base HP
    dw 685 ; base MP
    dw 627 ; base ATK
    dw 329 ; base DEF
    dw 421 ; base AGL
    dw 740 ; base INT
    db $64 ; personality axis $6F
    db $c8 ; personality axis $70
    db $c8 ; byte 24 ($71)
    db $96 ; personality axis $72
    ds $36b, $00
