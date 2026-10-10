SECTION "Bank 1A", ROMX[$4000], BANK[$1A]
    db $1A

; wCFEC/wCFED (the first word of the record buffer) = skill number: copies the 17-byte record at SkillTable + 17 * number (bank $1A, $40D4) to wCFEE
; 17 call sites from 15 routines (e.g. Func_003_65E3, AddSkillBaseWeightAndLoadSkill, Func_031_6331, Func_031_63ED, ...)
; reads: wRecordBuffer, wCFED
; points at: wRecordBufferData
LoadSkillRecord::
Func_01A_4001:: ; address name
    ld a, [wRecordBuffer]
    ld c, a
    ld a, [wCFED]
    ld b, a
    ld a, $11
    call Multiply8By16
    ld a, l
    add a, $D4
    ld l, a
    ld a, h
    adc a, $40
    ld h, a
    ld de, wRecordBufferData
    ld b, $11

Jump_01A_401B::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_01A_401B
    ret

; like LoadSkillRecord, but copies wD869 bytes starting wD868 bytes into the record to the address in wD86A/wD86B; with wCFEC = $FF it zero-fills that destination instead
; 17 call sites from 16 routines (e.g. DebugSkillViewer_Update, AIScore_TakeMagic_Sub01_Sub01, Func_005_640A, SlotHasSkillWithFlagD, ...)
; reads: wRecordBuffer, wCFED, wD868, wD869, wD86A, wD86B
LoadSkillRecordPart::
Func_01A_4022:: ; address name
    ld a, [wRecordBuffer]
    ld c, a
    ld a, [wCFED]
    ld b, a
    ld a, c
    cp a, $FF
    jr z, Jump_01A_4057
    ld a, $11
    call Multiply8By16
    ld a, l
    add a, $D4
    ld l, a
    ld a, h
    adc a, $40
    ld h, a
    ld a, [wD868]
    add_a_to_hl
    ld a, [wD869]
    ld b, a
    ld a, [wD86A]
    ld e, a
    ld a, [wD86B]
    ld d, a

Jump_01A_4050::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_01A_4050
    ret

Jump_01A_4057::
    ld a, [wD869]
    ld b, a
    ld a, [wD86A]
    ld l, a
    ld a, [wD86B]
    ld h, a

Jump_01A_4063::
    ld a, $00
    ld [hl+], a
    dec b
    jr nz, Jump_01A_4063
    ret
    db $C5, $FA, $EC, $CF, $4F, $FA, $ED, $CF, $47, $79, $FE, $FF, $28, $13, $3E, $11
    db $CD, $AA, $16, $7D, $C6, $D4, $6F, $7C, $CE, $40, $67, $C1, $06, $00, $09, $4E
    db $C9, $C1, $0E, $00, $C9

; 1 call site from 1 routine (e.g. Func_039_6E27)
; reads: wBattleActionId, wC58A, wBattleActor
; writes: wBattleDamageLo, wD873
; points at: wDA53
Func_01A_408F::
    ld a, [wBattleActionId]
    ld c, a
    ld b, $00
    ld a, $11
    call Multiply8By16
    ld a, l
    add a, $D4
    ld l, a
    ld a, h
    adc a, $40
    ld h, a
    ld bc, $0009
    ld a, [wC58A]
    cp a, $01
    jr z, Jump_01A_40B6
    ld a, [wBattleActor]
    cp a, $04
    jr c, Jump_01A_40B6
    ld bc, $000D

Jump_01A_40B6::
    add hl, bc
    ld a, [wBattleActor]
    push hl
    ld hl, wDA53
    add_a_to_hl
    ld a, [hl]
    pop hl
    cp a, $04
    jr nz, Jump_01A_40CB
    inc hl
    inc hl

Jump_01A_40CB::
    ld a, [hl+]
    ld [wBattleDamageLo], a
    ld a, [hl]
    ld [wD873], a
    ret

; E-0032 (C1: the debug mode's skill viewer, GameMode0 state 9, loads 17-byte records with LoadSkillRecord and prints these fields; the screens were read on the emulator; 175 records because the viewer wraps its index at $AF). The meaning of the numbers is not established beyond that the first byte rises across spell families (Blaze 2, Blazemore 4, Blazemost 10).
; record: first number the debug skill viewer shows; rises across a spell family (2, 4, 10 for Blaze, Blazemore, Blazemost); skill family: string index in category $12 (1 = Blaze, 2 = Firebal, 3 = Bang, ...); skill type: string index in category $13 ('Type A' ... 'Type G'); low 2 bits: when usable, string index in category $14 (0 None, 1 Battle, 2 Field, 3 Anytime); high nibble: string index in category $10 ('Charge', 'Mixed', 'Cautious', ...); target: string index in category $11 after Func_001_5311 ('1 enemy', 'All enemies', ...); number shown by the debug skill viewer; number shown by the debug skill viewer; number shown by the debug skill viewer; number shown by the debug skill viewer; 16-bit number shown by the debug skill viewer; 16-bit value read by the viewer (wCFF9); 16-bit value; 16-bit value
SkillTable::
Data_01A_40D4:: ; heuristic: start of a structured table; C0
    db $00, $00, $00, $01, $11, $81, $FF, $3E, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 0
    db $02, $01, $04, $11, $11, $48, $83, $97, $80, $0C, $00, $03, $00, $07, $00, $05, $00 ; id 1
    db $04, $01, $04, $11, $11, $48, $83, $97, $80, $46, $00, $14, $00, $1E, $00, $0C, $00 ; id 2
    db $0A, $01, $04, $11, $11, $48, $83, $97, $80, $B4, $00, $14, $00, $64, $00, $14, $00 ; id 3
    db $04, $02, $04, $11, $12, $48, $83, $97, $80, $10, $00, $08, $00, $0A, $00, $08, $00 ; id 4
    db $06, $02, $04, $11, $12, $48, $83, $97, $80, $1E, $00, $0C, $00, $16, $00, $0C, $00 ; id 5
    db $0A, $02, $04, $11, $12, $48, $83, $97, $80, $58, $00, $18, $00, $3C, $00, $14, $00 ; id 6
    db $05, $03, $04, $11, $12, $48, $83, $97, $80, $14, $00, $0A, $00, $0F, $00, $05, $00 ; id 7
    db $08, $03, $04, $11, $12, $48, $83, $97, $80, $34, $00, $10, $00, $23, $00, $0A, $00 ; id 8
    db $0F, $03, $04, $11, $12, $48, $83, $97, $80, $82, $00, $14, $00, $5F, $00, $14, $00 ; id 9
    db $02, $04, $04, $11, $12, $48, $83, $97, $80, $08, $00, $10, $00, $06, $00, $0C, $00 ; id 10
    db $04, $04, $04, $11, $12, $48, $83, $97, $80, $19, $00, $1E, $00, $0E, $00, $14, $00 ; id 11
    db $08, $04, $04, $11, $12, $48, $83, $97, $80, $50, $00, $64, $00, $28, $00, $37, $00 ; id 12
    db $05, $05, $04, $11, $12, $48, $83, $97, $80, $23, $00, $0F, $00, $14, $00, $0A, $00 ; id 13
    db $0A, $05, $04, $11, $12, $48, $83, $97, $80, $46, $00, $14, $00, $2D, $00, $1E, $00 ; id 14
    db $0F, $05, $04, $11, $12, $48, $83, $97, $80, $AF, $00, $32, $00, $78, $00, $28, $00 ; id 15
    db $03, $06, $04, $11, $12, $48, $83, $97, $80, $19, $00, $0A, $00, $0C, $00, $08, $00 ; id 16
    db $05, $06, $04, $11, $12, $48, $83, $97, $80, $2A, $00, $10, $00, $1E, $00, $0A, $00 ; id 17
    db $0C, $06, $04, $11, $12, $48, $83, $97, $80, $50, $00, $18, $00, $3C, $00, $0A, $00 ; id 18
    db $04, $09, $03, $21, $11, $40, $03, $96, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 19
    db $07, $09, $03, $21, $12, $40, $03, $92, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 20
    db $01, $0F, $01, $21, $12, $40, $03, $92, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 21
    db $02, $00, $00, $33, $21, $40, $02, $12, $80, $1E, $00, $0A, $00, $1E, $00, $0A, $00 ; id 22
    db $05, $00, $00, $33, $21, $40, $02, $12, $80, $4B, $00, $0F, $00, $4B, $00, $0F, $00 ; id 23
    db $07, $00, $00, $33, $21, $40, $02, $12, $80, $FF, $FF, $FF, $FF, $C8, $00, $64, $00 ; id 24
    db $12, $00, $00, $33, $22, $40, $02, $12, $80, $5A, $00, $1E, $00, $46, $00, $14, $00 ; id 25
    db $24, $00, $00, $33, $22, $40, $02, $02, $80, $FF, $FF, $FF, $FF, $C8, $00, $64, $00 ; id 26
    db $14, $00, $00, $33, $21, $40, $02, $12, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 27
    db $28, $00, $00, $33, $21, $40, $02, $12, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 28
    db $64, $00, $00, $33, $21, $40, $02, $02, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 29
    db $0A, $00, $00, $33, $21, $40, $02, $12, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 30
    db $14, $00, $00, $33, $21, $40, $02, $12, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 31
    db $FF, $00, $00, $31, $22, $40, $02, $02, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 32
    db $02, $00, $00, $33, $21, $40, $02, $12, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 33
    db $02, $00, $00, $31, $22, $40, $02, $0A, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 34
    db $02, $00, $00, $31, $22, $40, $02, $0A, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 35
    db $02, $00, $00, $33, $22, $40, $02, $02, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 36
    db $02, $00, $00, $21, $21, $40, $02, $52, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 37
    db $03, $00, $00, $21, $22, $40, $02, $52, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 38
    db $03, $0D, $00, $21, $11, $40, $03, $D7, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 39
    db $04, $0D, $00, $21, $12, $40, $03, $D7, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 40
    db $02, $00, $00, $21, $21, $40, $02, $52, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 41
    db $03, $00, $00, $21, $22, $40, $02, $52, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 42
    db $03, $0E, $00, $21, $11, $40, $03, $D7, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 43
    db $04, $0E, $00, $21, $12, $40, $03, $D7, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 44
    db $06, $00, $00, $21, $21, $40, $02, $52, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 45
    db $03, $07, $00, $21, $12, $40, $03, $D7, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 46
    db $03, $08, $00, $21, $11, $40, $03, $D3, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 47
    db $05, $08, $03, $21, $12, $40, $03, $D3, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 48
    db $02, $00, $00, $21, $40, $40, $02, $42, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 49
    db $00, $0A, $00, $21, $11, $40, $03, $96, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 50
    db $03, $0B, $00, $21, $12, $40, $03, $D3, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 51
    db $05, $0C, $03, $21, $12, $40, $03, $D3, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 52
    db $02, $00, $00, $21, $21, $44, $02, $42, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 53
    db $04, $00, $00, $21, $40, $40, $02, $42, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 54
    db $04, $00, $00, $21, $40, $40, $02, $42, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 55
    db $03, $00, $00, $21, $22, $40, $02, $42, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 56
    db $03, $00, $00, $21, $22, $40, $02, $42, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 57
    db $05, $00, $00, $21, $11, $40, $00, $42, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 58
    db $09, $00, $00, $21, $40, $40, $02, $42, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 59
    db $14, $00, $00, $21, $80, $40, $02, $42, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 60
    db $FF, $10, $00, $21, $11, $08, $83, $17, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 61
    db $1E, $01, $05, $11, $12, $08, $83, $17, $80, $2C, $01, $64, $00, $F0, $00, $3C, $00 ; id 62
    db $19, $05, $05, $11, $12, $08, $83, $17, $80, $D2, $00, $50, $00, $AA, $00, $28, $00 ; id 63
    db $02, $11, $05, $11, $12, $1A, $83, $17, $80, $0E, $00, $08, $00, $0A, $00, $06, $00 ; id 64
    db $04, $11, $05, $11, $12, $1A, $83, $17, $80, $20, $00, $10, $00, $14, $00, $10, $00 ; id 65
    db $08, $11, $05, $11, $12, $1A, $83, $17, $80, $4B, $00, $19, $00, $2D, $00, $19, $00 ; id 66
    db $10, $11, $05, $11, $12, $1A, $83, $17, $80, $96, $00, $14, $00, $55, $00, $23, $00 ; id 67
    db $02, $12, $05, $11, $12, $1A, $83, $17, $80, $10, $00, $08, $00, $0E, $00, $04, $00 ; id 68
    db $04, $12, $05, $11, $12, $1A, $83, $17, $80, $2A, $00, $0C, $00, $19, $00, $0F, $00 ; id 69
    db $08, $12, $05, $11, $12, $1A, $83, $17, $80, $52, $00, $1E, $00, $32, $00, $1E, $00 ; id 70
    db $10, $12, $05, $11, $12, $1A, $83, $17, $80, $A0, $00, $14, $00, $5A, $00, $28, $00 ; id 71
    db $03, $04, $04, $11, $11, $08, $83, $17, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 72
    db $06, $04, $04, $11, $12, $08, $83, $17, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 73
    db $03, $05, $04, $11, $12, $08, $83, $17, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 74
    db $05, $19, $04, $11, $12, $08, $83, $3F, $80, $5A, $00, $28, $00, $28, $00, $1E, $00 ; id 75
    db $05, $1B, $04, $11, $11, $08, $83, $3F, $80, $1E, $00, $0F, $00, $14, $00, $0C, $00 ; id 76
    db $0F, $1B, $05, $11, $12, $08, $83, $3F, $80, $8C, $00, $28, $00, $78, $00, $28, $00 ; id 77
    db $04, $19, $04, $11, $14, $88, $87, $3A, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 78
    db $08, $19, $04, $11, $14, $88, $87, $3A, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 79
    db $03, $01, $06, $11, $11, $89, $FF, $3F, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 80
    db $03, $04, $06, $11, $11, $89, $FF, $3F, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 81
    db $03, $05, $06, $11, $11, $89, $FF, $3F, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 82
    db $03, $06, $06, $11, $11, $89, $FF, $3F, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 83
    db $03, $00, $00, $11, $11, $89, $FF, $3F, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 84
    db $03, $00, $00, $11, $11, $89, $FF, $3F, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 85
    db $03, $00, $00, $11, $11, $89, $FF, $3F, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 86
    db $03, $00, $00, $11, $11, $89, $FF, $3F, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 87
    db $03, $00, $00, $11, $11, $89, $FF, $3F, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 88
    db $03, $00, $00, $11, $11, $89, $FF, $3F, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 89
    db $03, $00, $00, $11, $11, $89, $FF, $3F, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 90
    db $03, $00, $00, $11, $11, $89, $FF, $3F, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 91
    db $03, $00, $00, $11, $11, $89, $FF, $3F, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 92
    db $03, $00, $00, $11, $11, $89, $FF, $3F, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 93
    db $03, $00, $00, $11, $11, $89, $FF, $3F, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 94
    db $02, $13, $03, $11, $11, $89, $FF, $3F, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 95
    db $03, $14, $03, $11, $11, $89, $FF, $3B, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 96
    db $02, $08, $03, $11, $11, $89, $FF, $3B, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 97
    db $02, $00, $00, $11, $11, $89, $FF, $3F, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 98
    db $03, $00, $00, $11, $11, $89, $FF, $3B, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 99
    db $06, $00, $00, $11, $14, $89, $FF, $3B, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 100
    db $05, $00, $04, $11, $12, $89, $FF, $3F, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 101
    db $14, $04, $05, $11, $12, $08, $83, $17, $80, $B4, $00, $1E, $00, $5A, $00, $32, $00 ; id 102
    db $14, $1A, $04, $11, $11, $89, $C7, $3F, $80, $5E, $01, $3C, $00, $0E, $01, $32, $00 ; id 103
    db $00, $00, $00, $21, $40, $08, $02, $03, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 104
    db $03, $00, $00, $11, $11, $00, $02, $03, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 105
    db $05, $00, $00, $11, $11, $01, $C6, $03, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 106
    db $03, $00, $00, $11, $11, $89, $C7, $3F, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 107
    db $03, $00, $00, $11, $FF, $89, $C7, $3F, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 108
    db $02, $00, $00, $11, $11, $81, $C7, $3F, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 109
    db $01, $00, $04, $11, $11, $81, $C7, $3B, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 110
    db $01, $0F, $04, $11, $11, $81, $C7, $3B, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 111
    db $01, $0F, $04, $11, $11, $81, $47, $2B, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 112
    db $03, $08, $03, $21, $12, $18, $03, $13, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 113
    db $04, $14, $03, $21, $12, $18, $03, $17, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 114
    db $03, $13, $03, $21, $12, $18, $03, $17, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 115
    db $04, $13, $03, $21, $12, $18, $03, $17, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 116
    db $03, $15, $03, $21, $12, $00, $03, $17, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 117
    db $00, $0A, $00, $21, $11, $20, $03, $36, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 118
    db $00, $0A, $00, $21, $11, $20, $03, $36, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 119
    db $04, $0C, $03, $21, $12, $20, $03, $13, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 120
    db $06, $09, $03, $21, $12, $20, $03, $33, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 121
    db $02, $16, $03, $21, $12, $20, $03, $33, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 122
    db $FF, $00, $00, $31, $22, $20, $02, $02, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 123
    db $0C, $00, $00, $31, $22, $20, $02, $12, $80, $46, $00, $0A, $00, $46, $00, $0A, $00 ; id 124
    db $01, $00, $00, $21, $40, $20, $03, $42, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 125
    db $02, $07, $02, $21, $12, $08, $03, $17, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 126
    db $02, $07, $00, $21, $12, $00, $03, $37, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 127
    db $02, $09, $00, $21, $12, $00, $03, $37, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 128
    db $07, $00, $00, $21, $22, $00, $02, $0A, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 129
    db $07, $09, $02, $21, $11, $00, $02, $57, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 130
    db $07, $00, $00, $21, $12, $00, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 131
    db $08, $00, $00, $21, $80, $00, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 132
    db $14, $00, $00, $21, $40, $00, $02, $52, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 133
    db $14, $00, $00, $21, $40, $00, $02, $52, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 134
    db $14, $00, $00, $21, $40, $00, $02, $52, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 135
    db $14, $00, $00, $21, $40, $00, $02, $52, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 136
    db $00, $00, $00, $21, $40, $10, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 137
    db $00, $00, $00, $21, $40, $00, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 138
    db $02, $16, $00, $21, $11, $00, $03, $33, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 139
    db $04, $0D, $03, $21, $11, $00, $03, $33, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 140
    db $01, $16, $00, $21, $11, $00, $03, $33, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 141
    db $03, $16, $03, $21, $12, $00, $03, $33, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 142
    db $01, $16, $00, $21, $11, $00, $03, $33, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 143
    db $03, $16, $03, $21, $12, $00, $03, $33, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 144
    db $02, $1B, $00, $21, $11, $08, $03, $23, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 145
    db $06, $17, $00, $21, $12, $20, $03, $53, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 146
    db $06, $18, $00, $21, $11, $00, $03, $57, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 147
    db $03, $00, $00, $31, $40, $04, $02, $02, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 148
    db $04, $00, $00, $21, $40, $04, $02, $02, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 149
    db $03, $00, $00, $31, $40, $04, $02, $42, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 150
    db $02, $00, $00, $21, $21, $04, $02, $02, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 151
    db $04, $00, $00, $21, $40, $04, $02, $02, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 152
    db $06, $00, $00, $31, $40, $00, $02, $42, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 153
    db $0A, $00, $00, $31, $40, $00, $02, $42, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 154
    db $05, $00, $00, $31, $40, $00, $02, $42, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 155
    db $0F, $00, $00, $21, $40, $00, $02, $42, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 156
    db $02, $00, $00, $21, $40, $14, $02, $42, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 157
    db $04, $00, $00, $21, $40, $04, $02, $42, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 158
    db $08, $00, $00, $31, $40, $00, $02, $12, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 159
    db $14, $00, $00, $31, $40, $00, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 160
    db $1C, $00, $00, $31, $40, $00, $02, $02, $80, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; id 161
    db $00, $00, $00, $02, $00, $00, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 162
    db $00, $00, $00, $02, $00, $00, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 163
    db $02, $00, $00, $02, $00, $00, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 164
    db $02, $00, $00, $02, $00, $00, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 165
    db $00, $00, $00, $02, $00, $00, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 166
    db $02, $00, $00, $02, $00, $00, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 167
    db $00, $00, $00, $02, $00, $00, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 168
    db $02, $00, $00, $02, $00, $00, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 169
    db $01, $00, $00, $11, $11, $89, $CF, $13, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 170
    db $00, $00, $00, $41, $40, $00, $02, $02, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 171
    db $00, $00, $00, $31, $40, $04, $02, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; id 172
    db $05, $0C, $03, $21, $11, $40, $03, $D3, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 173
    db $02, $00, $00, $21, $40, $44, $02, $42, $80, $00, $00, $00, $00, $00, $00, $00, $00 ; id 174
    ds $14, $00
    INCBIN "dwm2-cobi-us.gbc", $068C87, $E1
    ds $22, $00
    INCBIN "dwm2-cobi-us.gbc", $068D8A, $99
    ds $11, $00
    db $08
    ds $21, $00
    INCBIN "dwm2-cobi-us.gbc", $068E56, $1A2

Data_01A_4FF8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

Data_01A_5005:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $069005, $BE7

Data_01A_5BEC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $40, $5D
    dw Data_01A_5D41
    db $42, $5D, $40, $5D
    dw Data_01A_5D44
    db $45, $5D, $40, $5D
    dw Data_01A_5D47
    db $48, $5D, $40, $5D
    dw Data_01A_5D4A
    db $4B, $5D, $40, $5D
    dw Data_01A_5D4D
    db $4E, $5D, $40, $5D
    dw Data_01A_5D50
    db $51, $5D, $40, $5D
    dw Data_01A_5D53
    db $40, $5D, $40, $5D
    dw Data_01A_5D55
    db $56, $5D, $40, $5D
    dw Data_01A_5D58
    db $40, $5D, $5A, $5D
    dw Data_01A_5D5B
    dw Data_01A_5D40
    db $5D, $5D
    dw Data_01A_5D40
    db $40, $5D
    dw Data_01A_5D40
    db $40, $5D
    dw Data_01A_5D40
    db $40, $5D
    dw Data_01A_5D5F
    db $40, $5D
    dw Data_01A_5D61
    db $40, $5D
    dw Data_01A_5D63
    db $40, $5D
    dw Data_01A_5D65
    db $40, $5D, $40, $5D, $40, $5D, $67, $5D, $40, $5D, $40, $5D, $40, $5D, $40, $5D
    db $40, $5D, $40, $5D, $69, $5D
    dw Data_01A_5D40
    dw Data_01A_5D40
    dw Data_01A_5D40
    dw Data_01A_5D40
    dw Data_01A_5D40
    dw Data_01A_5D40
    dw Data_01A_5D40
    dw Data_01A_5D40
    dw Data_01A_5D40
    dw Data_01A_5D6B
    dw Data_01A_5D6C
    dw Data_01A_5D6D
    INCBIN "dwm2-cobi-us.gbc", $069C72, $68
    dw Data_01A_5D40
    dw Data_01A_5D40
    dw Data_01A_5D40
    dw Data_01A_5D40
    dw Data_01A_5D40
    dw Data_01A_5D40
    dw Data_01A_5D40
    dw Data_01A_5D40
    dw Data_01A_5D40
    dw Data_01A_5D40
    dw Data_01A_5D40
    dw Data_01A_5D40
    dw Data_01A_5D40
    dw Data_01A_5D40
    dw Data_01A_5D7F
    dw Data_01A_5D80
    dw Data_01A_5D81
    INCBIN "dwm2-cobi-us.gbc", $069CFC, $44

Data_01A_5D40:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_01A_5D41:: ; heuristic: target of a monotone pointer table; C0
    db $02, $03, $FF

Data_01A_5D44:: ; heuristic: target of a monotone pointer table; C0
    db $05, $06, $FF

Data_01A_5D47:: ; heuristic: target of a monotone pointer table; C0
    db $08, $09, $FF

Data_01A_5D4A:: ; heuristic: target of a monotone pointer table; C0
    db $0B, $0C, $FF

Data_01A_5D4D:: ; heuristic: target of a monotone pointer table; C0
    db $0E, $0F, $FF

Data_01A_5D50:: ; heuristic: target of a monotone pointer table; C0
    db $11, $12, $FF

Data_01A_5D53:: ; heuristic: target of a monotone pointer table; C0
    db $14, $FF

Data_01A_5D55:: ; heuristic: target of a monotone pointer table; C0
    db $17, $18, $FF

Data_01A_5D58:: ; heuristic: target of a monotone pointer table; C0
    db $1A, $FF, $1C

Data_01A_5D5B:: ; heuristic: target of a monotone pointer table; C0
    db $1D, $FF, $1F, $FF

Data_01A_5D5F:: ; heuristic: target of a monotone pointer table; C0
    db $26, $FF

Data_01A_5D61:: ; heuristic: target of a monotone pointer table; C0
    db $28, $FF

Data_01A_5D63:: ; heuristic: target of a monotone pointer table; C0
    db $2A, $FF

Data_01A_5D65:: ; heuristic: target of a monotone pointer table; C0
    db $2C, $FF, $30, $FF, $37, $FF

Data_01A_5D6B:: ; heuristic: target of a monotone pointer table; C0
    db $41

Data_01A_5D6C:: ; heuristic: target of a monotone pointer table; C0
    db $42

Data_01A_5D6D:: ; heuristic: target of a monotone pointer table; C0
    db $43, $FF, $45, $46, $47, $FF, $49, $FF, $4D, $FF, $4F, $FF, $64, $FF, $74, $FF
    db $77, $FF

Data_01A_5D7F:: ; heuristic: target of a monotone pointer table; C0
    db $86

Data_01A_5D80:: ; heuristic: target of a monotone pointer table; C0
    db $87

Data_01A_5D81:: ; heuristic: target of a monotone pointer table; C0
    db $88, $FF, $8C, $FF, $8E, $FF, $98, $FF, $9A, $FF

Data_01A_5D8B:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $DF, $5E
    dw Data_01A_5EE0
    db $5E, $5F, $5D, $5F
    dw Data_01A_5EE1
    db $61, $5F, $60, $5F
    dw Data_01A_5EE2
    db $64, $5F, $63, $5F
    dw Data_01A_5EE3
    db $67, $5F, $66, $5F
    dw Data_01A_5EE4
    db $6A, $5F, $69, $5F
    dw Data_01A_5EE5
    db $6D, $5F, $6C, $5F
    dw Data_01A_5EE6
    db $6F, $5F, $E7, $5E
    dw Data_01A_5EE8
    db $72, $5F, $71, $5F
    dw Data_01A_5EE9
    db $74, $5F, $EA, $5E
    dw Data_01A_5F77
    db $76, $5F, $EB, $5E
    dw Data_01A_5F79
    db $EC, $5E
    dw Data_01A_5EED
    db $EE, $5E
    dw Data_01A_5EEF
    db $F0, $5E
    dw Data_01A_5EF1
    db $7B, $5F
    dw Data_01A_5EF2
    db $7D, $5F
    dw Data_01A_5EF3
    db $7F, $5F
    dw Data_01A_5EF4
    db $81, $5F
    dw Data_01A_5EF5
    db $F6, $5E
    dw Data_01A_5EF7
    db $83, $5F
    dw Data_01A_5EF8
    db $F9, $5E
    dw Data_01A_5EFA
    db $FB, $5E
    dw Data_01A_5EFC
    db $FD, $5E
    dw Data_01A_5F85
    dw Data_01A_5EFE
    dw Data_01A_5EFF
    dw Data_01A_5F00
    dw Data_01A_5F01
    dw Data_01A_5F02
    dw Data_01A_5F03
    dw Data_01A_5F04
    dw Data_01A_5F05
    dw Data_01A_5F06
    dw Data_01A_5F89
    db $88, $5F, $87, $5F, $07, $5F, $8D, $5F, $8C, $5F, $8B, $5F
    dw Data_01A_5F08
    db $8F, $5F, $09, $5F
    dw Data_01A_5F0A
    db $0B, $5F, $91, $5F
    dw Data_01A_5F0C
    db $93, $5F, $0D, $5F
    dw Data_01A_5F0E
    db $0F, $5F, $10, $5F
    dw Data_01A_5F11
    db $12, $5F, $13, $5F
    dw Data_01A_5F14
    db $15, $5F, $16, $5F
    dw Data_01A_5F17
    db $18, $5F, $19, $5F
    dw Data_01A_5F1A
    db $1B, $5F, $1C, $5F
    dw Data_01A_5F1D
    db $1E, $5F, $1F, $5F
    dw Data_01A_5F20
    db $95, $5F, $21, $5F
    dw Data_01A_5F22
    db $23, $5F, $24, $5F
    dw Data_01A_5F25
    db $26, $5F, $27, $5F
    dw Data_01A_5F28
    db $29, $5F, $2A, $5F
    dw Data_01A_5F2B
    db $2C, $5F, $2D, $5F
    dw Data_01A_5F2E
    db $2F, $5F, $97, $5F
    dw Data_01A_5F30
    db $31, $5F, $99, $5F
    dw Data_01A_5F32
    db $33, $5F, $34, $5F
    dw Data_01A_5F35
    db $36, $5F, $37, $5F
    dw Data_01A_5F38
    db $39, $5F, $3A, $5F
    dw Data_01A_5F3B
    db $3C, $5F, $3D, $5F
    dw Data_01A_5F3E
    db $3F, $5F, $9D, $5F
    dw Data_01A_5F9C
    db $9B, $5F
    dw Data_01A_5F40
    db $41, $5F
    dw Data_01A_5F42
    db $9F, $5F
    dw Data_01A_5F43
    db $A1, $5F
    dw Data_01A_5F44
    db $45, $5F
    dw Data_01A_5F46
    db $47, $5F
    dw Data_01A_5F48
    db $49, $5F
    dw Data_01A_5F4A
    db $4B, $5F
    dw Data_01A_5F4C
    db $A3, $5F
    dw Data_01A_5F4D
    db $A5, $5F
    dw Data_01A_5F4E
    db $4F, $5F
    dw Data_01A_5F50
    db $51, $5F
    dw Data_01A_5F52
    db $53, $5F
    dw Data_01A_5F54
    db $55, $5F
    dw Data_01A_5F56
    db $57, $5F
    dw Data_01A_5F58
    db $59, $5F
    dw Data_01A_5F5A
    db $5B, $5F
    dw Data_01A_5F5C
    db $FF

Data_01A_5EE0:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_01A_5EE1:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_01A_5EE2:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_01A_5EE3:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_01A_5EE4:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_01A_5EE5:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_01A_5EE6:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5EE8:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_01A_5EE9:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF, $FF, $FF

Data_01A_5EED:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5EEF:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5EF1:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_01A_5EF2:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_01A_5EF3:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_01A_5EF4:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_01A_5EF5:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5EF7:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_01A_5EF8:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5EFA:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5EFC:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5EFE:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_01A_5EFF:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_01A_5F00:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_01A_5F01:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_01A_5F02:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_01A_5F03:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_01A_5F04:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_01A_5F05:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_01A_5F06:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5F08:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5F0A:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5F0C:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5F0E:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF, $FF

Data_01A_5F11:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF, $FF

Data_01A_5F14:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF, $FF

Data_01A_5F17:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF, $FF

Data_01A_5F1A:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF, $FF

Data_01A_5F1D:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF, $FF

Data_01A_5F20:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5F22:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF, $FF

Data_01A_5F25:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF, $FF

Data_01A_5F28:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF, $FF

Data_01A_5F2B:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF, $FF

Data_01A_5F2E:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5F30:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5F32:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF, $FF

Data_01A_5F35:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF, $FF

Data_01A_5F38:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF, $FF

Data_01A_5F3B:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF, $FF

Data_01A_5F3E:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5F40:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5F42:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_01A_5F43:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_01A_5F44:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5F46:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5F48:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5F4A:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5F4C:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_01A_5F4D:: ; heuristic: target of a monotone pointer table; C0
    db $FF

Data_01A_5F4E:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5F50:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5F52:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5F54:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5F56:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5F58:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5F5A:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $FF

Data_01A_5F5C:: ; heuristic: target of a monotone pointer table; C0
    db $FF, $02, $01, $FF, $05, $04, $FF, $08, $07, $FF, $0B, $0A, $FF, $0E, $0D, $FF
    db $11, $10, $FF, $13, $FF, $17, $16, $FF, $19, $FF, $1C

Data_01A_5F77:: ; heuristic: target of a monotone pointer table; C0
    db $1B, $FF

Data_01A_5F79:: ; heuristic: target of a monotone pointer table; C0
    db $1E, $FF, $25, $FF, $27, $FF, $29, $FF, $2B, $FF, $2F, $FF

Data_01A_5F85:: ; heuristic: target of a monotone pointer table; C0
    db $36, $FF, $42, $41

Data_01A_5F89:: ; heuristic: target of a monotone pointer table; C0
    db $40, $FF, $46, $45, $44, $FF, $48, $FF, $4C, $FF, $4E, $FF, $63, $FF, $73, $FF
    db $76, $FF, $87

Data_01A_5F9C:: ; heuristic: target of a monotone pointer table; C0
    db $86, $85, $FF, $8B, $FF, $8D, $FF, $97, $FF, $99, $FF

; 2 call sites from 2 routines (e.g. GameMode4_Init_Sub01_Sub07_Sub01, Func_0A0_494F)
; reads: wD86A, wD86B
; writes: wD86C
; points at: wD09D
Func_01A_5FA7::
    ld hl, wD09D
    ld bc, $0038
    ld a, $FF
    call FillBytes
    ld a, [wD86A]
    add a, $0E
    ld e, a
    ld a, [wD86B]
    adc a, $00
    ld d, a
    ld hl, wD09D
    ld b, $08

Jump_01A_5FC3::
    ld a, [de]
    ld [hl+], a
    ld a, $FF
    ld [de], a
    inc de
    dec b
    jr nz, Jump_01A_5FC3
    ld a, [wD86A]
    add a, $17
    ld e, a
    ld a, [wD86B]
    adc a, $00
    ld d, a
    ld hl, Data_01A_4FF8
    ld c, $00
    ld a, $04
    ld [wD86C], a

Jump_01A_5FE2::
    push de
    push hl
    push bc
    ld a, [de]
    cp a, [hl]
    jp c, Jump_01A_6080
    ld a, e
    add a, $06
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    inc hl
    ld a, [de]
    sub a, [hl]
    inc de
    inc hl
    ld a, [de]
    sbc a, [hl]
    jp c, Jump_01A_6080
    ld a, e
    add a, $03
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    inc hl
    ld a, [de]
    sub a, [hl]
    inc de
    inc hl
    ld a, [de]
    sbc a, [hl]
    jp c, Jump_01A_6080
    ld a, e
    add a, $01
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    inc hl
    ld a, [de]
    sub a, [hl]
    inc de
    inc hl
    ld a, [de]
    sbc a, [hl]
    jp c, Jump_01A_6080
    ld a, e
    add a, $01
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    inc hl
    ld a, [de]
    sub a, [hl]
    inc de
    inc hl
    ld a, [de]
    sbc a, [hl]
    jp c, Jump_01A_6080
    ld a, e
    add a, $01
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    inc hl
    ld a, [de]
    sub a, [hl]
    inc de
    inc hl
    ld a, [de]
    sbc a, [hl]
    jp c, Jump_01A_6080
    ld a, e
    add a, $01
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    inc hl
    ld a, [de]
    sub a, [hl]
    inc de
    inc hl
    ld a, [de]
    sbc a, [hl]
    jp c, Jump_01A_6080
    ld a, e
    add a, $E4
    ld e, a
    ld a, d
    adc a, $FF
    ld d, a
    pop bc
    push bc
    push de
    ld de, wD09D
    ld b, $08

Jump_01A_6066::
    ld a, [de]
    cp a, c
    jr z, Jump_01A_6094
    inc de
    dec b
    jr nz, Jump_01A_6066
    pop de
    inc hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_01A_6080
    call Func_01A_60DF
    jr nz, Jump_01A_6080
    ld a, [hl]
    cp a, $FF
    jp z, Jump_01A_60B9

Jump_01A_6080::
    pop bc
    pop hl
    pop de

Jump_01A_6083::
    ld a, l
    add a, $12
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    ld a, c
    cp a, $AA
    jp nz, Jump_01A_5FE2
    jr Jump_01A_60DE

Jump_01A_6094::
    pop de
    pop bc
    push bc
    ld a, [wD86A]
    add a, $0E
    ld l, a
    ld a, [wD86B]
    adc a, $00
    ld h, a
    ld b, $08

Jump_01A_60A5::
    ld a, [hl]
    cp a, $FF
    jr z, Jump_01A_60B3
    inc hl
    dec b
    jr nz, Jump_01A_60A5
    pop bc
    pop hl
    pop de
    jr Jump_01A_6083

Jump_01A_60B3::
    pop bc
    ld [hl], c
    pop hl
    pop de
    jr Jump_01A_6083

Jump_01A_60B9::
    pop bc
    push bc
    dec hl
    ld e, [hl]
    ld a, [wD86A]
    add a, $0E
    ld l, a
    ld a, [wD86B]
    adc a, $00
    ld h, a
    ld b, $08

Jump_01A_60CB::
    ld a, [hl]
    cp a, e
    jr z, Jump_01A_60D8
    inc hl
    dec b
    jr nz, Jump_01A_60CB
    pop bc
    pop hl
    pop de
    jr Jump_01A_6083

Jump_01A_60D8::
    pop bc
    ld [hl], c
    pop hl
    pop de
    jr Jump_01A_6083

Jump_01A_60DE::
    ret

; 1 call site from 1 routine (e.g. Func_01A_5FA7)
Func_01A_60DF::
    push de
    call FindByteAtHLInEightAtDE_Bank1A
    pop de
    inc hl
    ret

; searches the 8 bytes from DE for the byte at HL: Z set and DE on the match when found; otherwise B = 1, Z clear and DE 8 past the start (E-0065) (the same 11 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. Func_01A_60DF)
FindByteAtHLInEightAtDE_Bank1A::
Func_01A_60E6:: ; address name
    ld b, $08

Jump_01A_60E8::
    ld a, [de]
    cp a, [hl]
    ret z
    inc de
    dec b
    jr nz, Jump_01A_60E8
    inc b
    ret

; 1 call site from 1 routine (e.g. Func_031_6885_Table2_Case01)
; reads: wD868, hFFCC
; writes: hFFCC, hFFC9, hFFCA, hFFCB
Func_01A_60F1::
    ld a, [wD868]
    ld c, $56
    call SRAMRecordAddressMapped
    ld d, h
    ld e, l
    ld hl, Data_01A_4FF8
    ld c, $00

Jump_01A_6100::
    push de
    push hl
    push bc
    push de
    call Func_01A_623D
    pop de
    jp z, Jump_01A_61E4
    ld a, [de]
    inc a
    cp a, [hl]
    jp c, Jump_01A_61E4
    ld a, e
    add a, $07
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    inc hl
    ld a, [de]
    sub a, [hl]
    inc de
    inc hl
    ld a, [de]
    sbc a, [hl]
    jp c, Jump_01A_61E4
    ld a, e
    add a, $03
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    inc hl
    ld a, [de]
    sub a, [hl]
    inc de
    inc hl
    ld a, [de]
    sbc a, [hl]
    jp c, Jump_01A_61E4
    ld a, e
    add a, $01
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    inc hl
    ld a, [de]
    sub a, [hl]
    inc de
    inc hl
    ld a, [de]
    sbc a, [hl]
    jp c, Jump_01A_61E4
    ld a, e
    add a, $01
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    inc hl
    ld a, [de]
    sub a, [hl]
    inc de
    inc hl
    ld a, [de]
    sbc a, [hl]
    jp c, Jump_01A_61E4
    ld a, e
    add a, $01
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    inc hl
    ld a, [de]
    sub a, [hl]
    inc de
    inc hl
    ld a, [de]
    sbc a, [hl]
    jp c, Jump_01A_61E4
    ld a, e
    add a, $01
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    inc hl
    ld a, [de]
    sub a, [hl]
    inc de
    inc hl
    ld a, [de]
    sbc a, [hl]
    jr c, Jump_01A_61E4
    ld a, e
    add a, $D2
    ld e, a
    ld a, d
    adc a, $FF
    ld d, a
    pop bc
    push bc
    push de
    ld b, $19

Jump_01A_6189::
    ld a, [de]
    cp a, c
    jr z, Jump_01A_61FF
    inc de
    dec b
    jr nz, Jump_01A_6189
    pop de
    ld a, e
    add a, $F8
    ld e, a
    ld a, d
    adc a, $FF
    ld d, a
    inc hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_01A_61B6
    ldh [hFFCC], a
    ld a, c
    cp a, $3D
    jr nz, Jump_01A_61AF
    ld a, [hl]
    call Func_01A_622B
    jr nz, Jump_01A_61E4
    jr Jump_01A_61B6

Jump_01A_61AF::
    call Func_01A_622B
    jr nz, Jump_01A_61E4
    jr Jump_01A_620F

Jump_01A_61B6::
    inc hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_01A_61E4
    call Func_01A_622B
    jr nz, Jump_01A_61E4
    inc hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_01A_621F
    call Func_01A_622B
    jr nz, Jump_01A_61E4
    inc hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_01A_621F
    call Func_01A_622B
    jr nz, Jump_01A_61E4
    inc hl
    ld a, [hl]
    cp a, $FF
    jr z, Jump_01A_621F
    call Func_01A_622B
    jr nz, Jump_01A_61E4
    jr Jump_01A_621F

Jump_01A_61E4::
    pop bc
    pop hl
    pop de
    ld a, l
    add a, $12
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    inc c
    ld a, c
    cp a, $AA
    jp nz, Jump_01A_6100
    ld a, $FF
    ldh [hFFC9], a
    ld a, $FF
    ldh [hFFCA], a

Jump_01A_61FE::
    ret

Jump_01A_61FF::
    ld a, $FF
    ld [de], a
    pop de
    pop bc
    pop hl
    pop de
    ld a, c
    ldh [hFFC9], a
    ld a, $00
    ldh [hFFCA], a
    jr Jump_01A_61FE

Jump_01A_620F::
    ldh a, [hFFCC]
    ldh [hFFCB], a
    pop bc
    pop hl
    pop de
    ld a, c
    ldh [hFFC9], a
    ld a, $01
    ldh [hFFCA], a
    jr Jump_01A_61FE

Jump_01A_621F::
    pop bc
    pop hl
    pop de
    ld a, c
    ldh [hFFC9], a
    ld a, $02
    ldh [hFFCA], a
    jr Jump_01A_61FE

; 6 call sites from 1 routine (e.g. Func_01A_60F1)
Func_01A_622B::
    push de
    call FindByteAtHLInEightAtDE_Bank1A_6232
    pop de
    jr Jump_01A_61FE

; searches the 8 bytes from DE for the byte at HL: Z set and DE on the match when found; otherwise B = 1, Z clear and DE 8 past the start (E-0065) (the same 11 bytes appear in 2 banks)
; 1 call site from 1 routine (e.g. Func_01A_622B)
FindByteAtHLInEightAtDE_Bank1A_6232::
Func_01A_6232:: ; address name
    ld b, $08

Jump_01A_6234::
    ld a, [de]
    cp a, [hl]
    ret z
    inc de
    dec b
    jr nz, Jump_01A_6234
    inc b
    ret

; 1 call site from 1 routine (e.g. Func_01A_60F1)
; points at: wD09D
Func_01A_623D::
    ld de, wD09D
    ld b, $38

Jump_01A_6242::
    ld a, [de]
    cp a, c
    ret z
    inc de
    dec b
    jr nz, Jump_01A_6242
    inc b
    ret

; only called from BattleEnd_Step3 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3)
; reads: wC991, wC992
; writes: wSpeciesIdLo, wSpeciesIdHi
; points at: wD09D, wD010, wC9C2
BattleEnd_Step3_Sub02::
Func_01A_624B:: ; address name
    ld hl, wD09D
    ld bc, $0019
    ld a, $FF
    call FillBytes
    ld a, [wC991]
    ld l, a
    ld a, [wC992]
    ld h, a
    ld a, l
    ld [wSpeciesIdLo], a
    ld a, h
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    ld hl, wD09D
    ld de, wD010
    ld b, $03

Jump_01A_6274::
    ld a, [de]
    inc de
    call BattleEnd_Step3_Sub02_Sub01
    jr z, Jump_01A_627E
    call BattleEnd_Step3_Sub02_Sub02

Jump_01A_627E::
    ld [hl+], a
    dec b
    jr nz, Jump_01A_6274
    ld hl, wC9C2
    ld b, $19
    ld a, $FF

Jump_01A_6289::
    ld [hl+], a
    dec b
    jr nz, Jump_01A_6289
    ld de, wD09D
    ld hl, wC9C2
    ld b, $19

Jump_01A_6295::
    ld a, [de]
    inc de
    cp a, $FF
    jr z, Jump_01A_629C
    ld [hl+], a

Jump_01A_629C::
    dec b
    jr nz, Jump_01A_6295
    ret

; only called from BattleEnd_Step3_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3_Sub02)
BattleEnd_Step3_Sub02_Sub01::
Func_01A_62A0:: ; address name
    push hl
    push bc
    cp a, $C8
    jr z, Jump_01A_62CA
    ld c, a
    call Func_01A_6306
    jr nz, Jump_01A_62CD
    push bc
    ld b, $00
    ld hl, Data_01A_5BEC
    add hl, bc
    add hl, bc
    pop bc
    deref_hl

Jump_01A_62B8::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_01A_62C6
    push hl
    call Func_01A_6306
    pop hl
    jr nz, Jump_01A_62CD
    jr Jump_01A_62B8

Jump_01A_62C6::
    xor a, a
    ld a, c
    jr Jump_01A_62CD

Jump_01A_62CA::
    ld a, $FF
    inc b

Jump_01A_62CD::
    pop bc
    pop hl
    ret

; only called from BattleEnd_Step3_Sub02 (E-0047)
; 1 call site from 1 routine (e.g. BattleEnd_Step3_Sub02)
BattleEnd_Step3_Sub02_Sub02::
Func_01A_62D0:: ; address name
    push hl
    push de
    push bc
    ld hl, Data_01A_5005
    ld b, $AA
    ld c, $00

Jump_01A_62DA::
    push hl
    cp a, [hl]
    jr z, Jump_01A_62FB
    inc hl
    cp a, [hl]
    jr z, Jump_01A_62FB
    inc hl
    cp a, [hl]
    jr z, Jump_01A_62FB
    inc hl
    cp a, [hl]
    jr z, Jump_01A_62FB
    inc hl
    cp a, [hl]
    jr z, Jump_01A_62FB

Jump_01A_62EE::
    pop hl
    ld de, $0012
    add hl, de
    inc c
    dec b
    jr nz, Jump_01A_62DA

Jump_01A_62F7::
    pop bc
    pop de
    pop hl
    ret

Jump_01A_62FB::
    ld e, a
    ld a, c
    call Func_01A_6306
    ld a, e
    jr z, Jump_01A_62EE
    pop hl
    jr Jump_01A_62F7

; 3 call sites from 2 routines (e.g. BattleEnd_Step3_Sub02_Sub02, BattleEnd_Step3_Sub02_Sub01)
; points at: wC9BA
Func_01A_6306::
    push bc
    ld hl, wC9BA
    ld b, $08

Jump_01A_630C::
    cp a, [hl]
    jr z, Jump_01A_6315
    inc hl
    dec b
    jr nz, Jump_01A_630C
    jr Jump_01A_6318

Jump_01A_6315::
    ld a, $FF
    inc b

Jump_01A_6318::
    pop bc
    ret

; 1 call site from 1 routine (e.g. Func_031_6C2F_Case01)
; writes: hFFC6
Func_01A_631A::
    xor a, a
    ldh [hFFC6], a
    xor a, a
    ret

; no direct call (reached through a table, a jump or a vector)
; reads: hFFC6
; writes: hFFC6
Func_01A_631F:: ; heuristic: follows a terminator; C0
    ldh a, [hFFC6]
    ld c, a
    ld b, $00
    ld hl, Data_01A_5BEC
    add hl, bc
    add hl, bc
    deref_hl

Jump_01A_632C::
    ld a, [hl+]
    cp a, $FF
    jr z, Jump_01A_633A
    push hl
    call Func_01A_6348
    pop hl
    jr c, Jump_01A_632C
    jr Jump_01A_633F

Jump_01A_633A::
    call Func_01A_635B
    jr c, Jump_01A_6344

Jump_01A_633F::
    xor a, a
    ldh [hFFC6], a
    jr Jump_01A_6347

Jump_01A_6344::
    call Func_01A_636C

Jump_01A_6347::
    ret

; 1 call site from 1 routine (e.g. Func_01A_631F)
; points at: wD09D
Func_01A_6348::
    cp a, c
    jr z, Jump_01A_6359
    ld b, $08
    ld hl, wD09D

Jump_01A_6350::
    cp a, [hl]
    jr z, Jump_01A_6359
    inc hl
    dec b
    jr nz, Jump_01A_6350
    scf
    ret

Jump_01A_6359::
    xor a, a
    ret

; 1 call site from 1 routine (e.g. Func_01A_631F)
; points at: wD09D
Func_01A_635B::
    ld a, c
    ld b, $08
    ld hl, wD09D

Jump_01A_6361::
    cp a, [hl]
    jr z, Jump_01A_636A
    inc hl
    dec b
    jr nz, Jump_01A_6361
    scf
    ret

Jump_01A_636A::
    xor a, a
    ret

; 1 call site from 1 routine (e.g. Func_01A_631F)
; writes: hFFC7, hFFC6
; points at: wD09D
Func_01A_636C::
    ld b, $00
    ld hl, Data_01A_5D8B
    add hl, bc
    add hl, bc
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld b, $08
    ld hl, wD09D
    xor a, a
    ldh [hFFC7], a

Jump_01A_637E::
    ld a, [hl]
    or a, a
    jr z, Jump_01A_6393
    cp a, $FF
    jr z, Jump_01A_6393
    call Func_01A_6395
    jr nc, Jump_01A_6393
    inc hl
    dec b
    jr nz, Jump_01A_637E
    xor a, a
    ldh [hFFC6], a
    ret

Jump_01A_6393::
    ld [hl], c
    ret

; 1 call site from 1 routine (e.g. Func_01A_636C)
Func_01A_6395::
    push de

Jump_01A_6396::
    ld a, [de]
    cp a, $FF
    jr z, Jump_01A_63A1
    cp a, [hl]
    jr z, Jump_01A_63A4
    inc de
    jr Jump_01A_6396

Jump_01A_63A1::
    pop de
    scf
    ret

Jump_01A_63A4::
    pop de
    xor a, a
    ret

; 12 call sites from 2 routines (e.g. GameMode4_Init_Sub01_Sub07_Sub01, Func_0A0_494F)
; reads: hFFC6, hFFC7
; writes: hFFC8, hFFC9
Func_01A_63A7::
    ldh a, [hFFC6]
    ld c, $63
    call Multiply8
    ld a, l
    add a, $16
    ld l, a
    ld a, h
    adc a, $66
    ld h, a
    ldh a, [hFFC7]
    ld b, a
    ldh a, [hFFC6]
    ld de, Data_01A_63F8
    add a, e
    ld e, a
    jr nc, Jump_01A_63C3
    inc d

Jump_01A_63C3::
    ld a, [de]
    ld e, a
    ld d, $00

Jump_01A_63C7::
    ld a, [hl+]
    add a, e
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, Jump_01A_63C7
    ld a, e
    ldh [hFFC8], a
    ld a, d
    ldh [hFFC9], a
    ret
    db $F0, $C6, $0E, $63, $CD, $82, $16, $7D, $C6, $16, $6F, $7C, $CE, $66, $67, $F0
    db $C7, $85, $6F, $30, $01, $24, $5E, $16, $00, $7B, $E0, $C8, $7A, $E0, $C9, $C9

Data_01A_63F8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $01, $02, $02, $02, $03, $03, $03, $03, $04, $05, $05, $06, $07, $03, $04, $05
    db $06, $07, $08, $04, $05, $06, $07, $07, $08, $0B, $0C, $0D, $0C, $0C, $0E, $10

; 2 call sites from 2 routines (e.g. Func_031_6885_Case01, Func_031_67AA_Case07)
; reads: wD869, wD014, wD015, wD016, wD017, wD018, wD019
; writes: wSpeciesIdLo, wSpeciesIdHi, wD095, wD096, wD097, wD098, wD099, wD09A
; points at: wD095
Func_01A_6418::
    ld hl, wD095
    ld bc, $0008
    xor a, a
    call FillBytes
    ld a, [wD869]
    ld c, $0B
    call SRAMRecordAddress
    push hl
    ld a, [hl+]
    ld [wSpeciesIdLo], a
    ld a, [hl]
    ld [wSpeciesIdHi], a
    farcall LoadSpeciesRecord
    pop hl
    ld a, l
    add a, $4B
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [hl+]
    cp a, [hl]
    jr nc, Jump_01A_64A1
    ld d, a
    call Func_01A_64A2
    ld a, [wD014]
    call Func_01A_6562
    ld b, $00
    call AddWD09CIfWD09BMatchesB
    ld [wD095], a
    ld a, [wD015]
    call Func_01A_6562
    ld b, $01
    call AddWD09CIfWD09BMatchesB
    ld [wD096], a
    ld a, [wD016]
    call Func_01A_6562
    ld b, $02
    call AddWD09CIfWD09BMatchesB
    ld [wD097], a
    ld a, [wD017]
    call Func_01A_6562
    ld b, $03
    call AddWD09CIfWD09BMatchesB
    ld [wD098], a
    ld a, [wD018]
    call Func_01A_6562
    ld b, $04
    call AddWD09CIfWD09BMatchesB
    ld [wD099], a
    ld a, [wD019]
    call Func_01A_6562
    ld b, $05
    call AddWD09CIfWD09BMatchesB
    ld [wD09A], a
    call Func_01A_6587

Jump_01A_64A1::
    ret

; 1 call site from 1 routine (e.g. Func_01A_6418)
; reads: wD869, wD09B
; writes: wD09B, wD09C
; points at: wD095
Func_01A_64A2::
    push de
    ld a, [wD869]
    ld c, $A4
    call SRAMRecordAddress
    ld bc, $0000
    ld a, [hl]
    cp a, $1D
    jr c, Jump_01A_64B7
    cp a, $23
    jr c, Jump_01A_64C0

Jump_01A_64B7::
    ld a, $FF
    ld [wD09B], a
    xor a, a
    jp Jump_01A_654C

Jump_01A_64C0::
    sub a, $1D
    ld [wD09B], a
    ld a, l
    add a, $C9
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    ld e, [hl]
    ld a, l
    add a, $E9
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    call Func_01A_6551
    ld a, l
    add a, $07
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    call Func_01A_6551
    inc hl
    inc hl
    inc hl
    inc hl
    call Func_01A_6551
    inc hl
    inc hl
    call Func_01A_6551
    inc hl
    inc hl
    call Func_01A_6551
    inc hl
    inc hl
    call Func_01A_6551
    inc hl
    inc hl
    call Func_01A_6551
    inc hl
    inc hl
    call Func_01A_6551
    ld a, l
    add a, $96
    ld l, a
    ld a, h
    adc a, $FF
    ld h, a
    push bc
    ld b, $0A
    ld d, $00

Jump_01A_6511::
    ld a, [hl+]
    cp a, $F0
    jr z, Jump_01A_6522
    cp a, $8D
    jr z, Jump_01A_651F
    cp a, $8E
    jr z, Jump_01A_651F
    inc d

Jump_01A_651F::
    dec b
    jr nz, Jump_01A_6511

Jump_01A_6522::
    pop bc
    bit 0, e
    jr z, Jump_01A_652E
    bit 0, d
    jr z, Jump_01A_6533
    inc c
    jr Jump_01A_6533

Jump_01A_652E::
    bit 0, d
    jr nz, Jump_01A_6533
    inc b

Jump_01A_6533::
    ld a, b
    bit 0, e
    jr z, Jump_01A_6539
    ld a, c

Jump_01A_6539::
    ld b, a
    srl a
    ld b, a
    push hl
    ld a, [wD09B]
    ld hl, wD095
    add_a_to_hl
    ld a, [hl]
    pop hl
    add a, b

Jump_01A_654C::
    ld [wD09C], a
    pop de
    ret

; 8 call sites from 1 routine (e.g. Func_01A_64A2)
Func_01A_6551::
    bit 0, e
    jr z, Jump_01A_655C
    bit 0, [hl]
    jr z, Jump_01A_6561
    inc c
    jr Jump_01A_6561

Jump_01A_655C::
    bit 0, [hl]
    jr nz, Jump_01A_6561
    inc b

Jump_01A_6561::
    ret

; 6 call sites from 1 routine (e.g. Func_01A_6418)
Func_01A_6562::
    push de
    ld c, $63
    call Multiply8
    ld a, l
    add a, $16
    ld l, a
    ld a, h
    adc a, $66
    ld h, a
    pop de
    ld a, d
    add_a_to_hl
    ld c, [hl]
    ret

; A = C + (wD09C when wD09B = B, else 0) (E-0078)
; 6 call sites from 1 routine (e.g. Func_01A_6418)
; reads: wD09B, wD09C
AddWD09CIfWD09BMatchesB::
Func_01A_6579:: ; address name
    ld a, [wD09B]
    cp a, b
    jr z, Jump_01A_6582
    xor a, a
    jr Jump_01A_6585

Jump_01A_6582::
    ld a, [wD09C]

Jump_01A_6585::
    add a, c
    ret

; 1 call site from 1 routine (e.g. Func_01A_6418)
; reads: wD869, wD095, wD096, wD097, wD098, wD099, wD09A
; writes: wD095, wD096, wD097, wD098, wD099, wD09A
Func_01A_6587::
    ld a, [wD869]
    ld c, $5D
    call SRAMRecordAddress
    ld a, [wD095]
    ld c, a
    call Func_01A_65F4
    ld [wD095], a
    ld a, l
    add a, $04
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD096]
    ld c, a
    call Func_01A_65F4
    ld [wD096], a
    ld a, l
    add a, $02
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD097]
    ld c, a
    call Func_01A_65F4
    ld [wD097], a
    ld a, l
    add a, $02
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD098]
    ld c, a
    call Func_01A_65F4
    ld [wD098], a
    ld a, l
    add a, $02
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD099]
    ld c, a
    call Func_01A_65F4
    ld [wD099], a
    ld a, l
    add a, $02
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, [wD09A]
    ld c, a
    call Func_01A_65F4
    ld [wD09A], a
    ret

; 6 call sites from 1 routine (e.g. Func_01A_6587)
Func_01A_65F4::
    push hl
    ld b, $00
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld hl, $FC19
    add hl, de
    ld a, h
    or a, l
    jr z, Jump_01A_6611
    ld e, l
    add hl, bc
    ld a, h
    or a, l
    jr z, Jump_01A_6613
    bit 7, h
    jr nz, Jump_01A_6613
    xor a, a
    sub a, e
    ld c, a
    jr Jump_01A_6613

Jump_01A_6611::
    ld c, $00

Jump_01A_6613::
    ld a, c
    pop hl
    ret
    INCBIN "dwm2-cobi-us.gbc", $06A616, $C60

; CopyRecordRectToScreenBuffer_Bank1A with HL = Data_01A_7345 (E-0079)
; 9 call sites from 9 routines (e.g. Func_016_733F, Func_031_6E67_Case00, Func_031_6E67_Case03, Func_031_746F, ...)
CopyRectRecord7345ToScreenBuffer::
Func_01A_7276:: ; address name
    ld hl, Data_01A_7345
    call CopyRecordRectToScreenBuffer_Bank1A
    ret

; 3 call sites from 3 routines (e.g. Func_031_7486, Func_0A0_5E07_Table2_Case00, Func_0A0_5E07_Table2_Case07)
Func_01A_727D::
    ld hl, Data_01A_73AD
    call CopyRecordRectToScreenBuffer_Bank1A
    ret

; 1 call site from 1 routine (e.g. Func_031_7499)
Func_01A_7284::
    ld hl, Data_01A_73F7
    call CopyRecordRectToScreenBuffer_Bank1A
    ret

; 1 call site from 1 routine (e.g. Func_0A0_5F2E_Case00)
Func_01A_728B::
    ld hl, Data_01A_747F
    call CopyRecordRectToScreenBuffer_Bank1A
    ret

; 1 call site from 1 routine (e.g. Func_031_74AD)
Func_01A_7292::
    ld hl, Data_01A_755F
    call CopyRecordRectToScreenBuffer_Bank1A
    ret

; 1 call site from 1 routine (e.g. Func_0A0_5F2E_Case04)
Func_01A_7299::
    ld hl, Data_01A_75AB
    call CopyRecordRectToScreenBuffer_Bank1A
    ret

; 1 call site from 1 routine (e.g. Func_031_74C1)
Func_01A_72A0::
    ld hl, Data_01A_7600
    call CopyRecordRectToScreenBuffer_Bank1A
    ret

; 1 call site from 1 routine (e.g. Func_031_74DA)
Func_01A_72A7::
    ld hl, Data_01A_76AC
    call CopyRecordRectToScreenBuffer_Bank1A
    ret

; 1 call site from 1 routine (e.g. Func_031_74EE)
Func_01A_72AE::
    ld hl, Data_01A_76F8
    call CopyRecordRectToScreenBuffer_Bank1A
    ret

; 2 call sites from 2 routines (e.g. Func_031_7502, Func_0A0_5F2E_Case0C)
Func_01A_72B5::
    ld hl, Data_01A_7600
    call CopyRecordRectToScreenBuffer_Bank1A
    ld hl, Data_01A_7734
    call CopyRecordRectToScreenBuffer_Bank1A
    ret

; 1 call site from 1 routine (e.g. Func_031_7522)
Func_01A_72C2::
    ld hl, Data_01A_7750
    call CopyRecordRectToScreenBuffer_Bank1A
    ret

; 1 call site from 1 routine (e.g. Func_031_6E67_Case01)
Func_01A_72C9::
    ld hl, Data_01A_77B6
    call CopyRecordRectToScreenBuffer_Bank1A
    ld hl, Data_01A_79CB
    call CopyRecordRectToScreenBuffer_Bank1A
    ld a, $6C
    call QueueSoundEffect
    ret

; 7 call sites from 7 routines (e.g. Func_016_5D13_Case03, Func_016_6C16_Case00, Func_016_6C16_Case0C, Func_016_6C16_Case10, ...)
Func_01A_72DB::
    ld de, Data_01F_4330
    ld hl, vTiles1 + $6D0
    ld b, $1F
    ld c, $10
    call CopyFromBankWaitVRAM
    ld hl, Data_01A_7826
    call CopyRecordRectToScreenBuffer_Bank1A
    ld a, $6C
    call QueueSoundEffect
    ret

; 3 call sites from 3 routines (e.g. Func_016_5D13_Case0A, Func_016_5D13_Case0F, Func_016_5D13_Case16)
Func_01A_72F4::
    ld hl, Data_01A_7848
    call CopyRecordRectToScreenBuffer_Bank1A
    ret

; CopyRecordRectToScreenBuffer_Bank1A with HL = Data_01A_787E, then QueueSoundEffect $6C (E-0079)
; 6 call sites from 6 routines (e.g. Func_016_5D13_Case0E, Func_016_5D13_Case11, Func_016_5D13_Case18, Func_016_5D13_Case1B, ...)
CopyRectRecord787EAndPlaySound6C::
Func_01A_72FB:: ; address name
    ld hl, Data_01A_787E
    call CopyRecordRectToScreenBuffer_Bank1A
    ld a, $6C
    call QueueSoundEffect
    ret

; 3 call sites from 3 routines (e.g. Func_016_5D13_Case16, Func_016_5D13_Case18, Func_016_5D13_Case1B)
Func_01A_7307::
    ld hl, Data_01A_78AA
    call CopyRecordRectToScreenBuffer_Bank1A
    ret

; 1 call site from 1 routine (e.g. Func_016_7078)
Func_01A_730E::
    ld hl, Data_01A_7923
    call CopyRecordRectToScreenBuffer_Bank1A
    ret

; 2 call sites from 2 routines (e.g. Func_016_5D13_Case0C, Func_016_5D13_Case11)
Func_01A_7315::
    ld hl, Data_01A_796F
    call CopyRecordRectToScreenBuffer_Bank1A
    ld a, $6C
    call QueueSoundEffect
    ret

; HL = header (word offset, width, rows) followed by tile bytes: copies the rectangle to wScreenTileBuffer ($C198) + offset with rows 32 bytes apart (the same effect as CopyRecordRectToScreenBuffer) (E-0079)
; 20 call sites from 18 routines (e.g. CopyRectRecord7345ToScreenBuffer, CopyRectRecord787EAndPlaySound6C, Func_01A_730E, Func_01A_72A0, ...)
CopyRecordRectToScreenBuffer_Bank1A::
Func_01A_7321:: ; address name
    ld a, $98
    add a, [hl]
    ld e, a
    inc hl
    ld a, $C1
    adc a, [hl]
    ld d, a
    inc hl
    ld b, [hl]
    inc hl
    ld c, [hl]
    inc hl

Jump_01A_732F::
    push bc
    push de

Jump_01A_7331::
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, Jump_01A_7331
    pop de
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop bc
    dec c
    jr nz, Jump_01A_732F
    ret

Data_01A_7345:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $A0, $01, $14, $05, $B0
    ds $12, $B1
    db $B2, $B6, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A, $8B, $8C, $8D
    db $8E, $8F, $90, $91, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F
    db $A0, $A1, $A2, $A3, $B7, $B3
    ds $12, $B4
    db $B5

Data_01A_73AD:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $06B3AD, $4A

Data_01A_73F7:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $06B3F7, $88

Data_01A_747F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $E0, $00, $14, $0B, $B0
    ds $12, $B1
    db $B2, $B6, $C3, $C3, $D0, $D1, $D2, $D3, $D4, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B8
    ds $12, $B9
    db $BA, $B6, $C3, $C3, $ED, $EE, $EF, $F0, $F1, $F2, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $F3, $F4, $F5, $F6, $F7, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $F8, $F9, $FA, $FB, $FC, $FD, $FE, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $C3, $C3, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F, $10
    db $11, $12, $13, $C3, $B7, $B3
    ds $12, $B4
    db $B5

Data_01A_755F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $06B55F, $4C

Data_01A_75AB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $06B5AB, $55

Data_01A_7600:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $06B600, $AC

Data_01A_76AC:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $06B6AC, $4C

Data_01A_76F8:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $60, $01, $08, $07, $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $EF, $F0
    db $EE, $C3, $C3, $B7, $B8, $B9, $B9, $B9, $B9, $B9, $B9, $BA, $B6, $C3, $F1, $F2
    db $F2, $F3, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $F4, $F5
    db $F6, $F7, $F3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_01A_7734:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $CC, $01, $08, $03, $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $EC, $AD, $AF
    db $C3, $C3, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_01A_7750:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $06B750, $66

Data_01A_77B6:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $06B7B6, $70

Data_01A_7826:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0E, $01, $06, $05, $B0, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $CE, $CF, $DF, $B7
    db $B6, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $A5, $ED, $C3, $B7, $B3, $B4, $B4, $B4
    db $B4, $B5

Data_01A_7848:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0A, $01, $0A, $05, $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3
    db $F3, $F4, $F5, $F6, $F7, $F8, $F9, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3
    db $C3, $B7, $B6, $C3, $FA, $FB, $FC, $C3, $C3, $C3, $C3, $B7, $B3, $B4, $B4, $B4
    db $B4, $B4, $B4, $B4, $B4, $B5

Data_01A_787E:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $0C, $01, $08, $05, $B0, $B1, $B1, $B1, $B1, $B1, $B1, $B2, $B6, $C3, $A4, $EE
    db $EF, $F0, $C3, $B7, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $B7, $B6, $C3, $F1, $F2
    db $C3, $C3, $C3, $B7, $B3, $B4, $B4, $B4, $B4, $B4, $B4, $B5

Data_01A_78AA:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $06B8AA, $79

Data_01A_7923:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $06B923, $4C

Data_01A_796F:: ; heuristic: pointer load in the same bank (bank assumed); C0
    INCBIN "dwm2-cobi-us.gbc", $06B96F, $5C

Data_01A_79CB:: ; heuristic: pointer load in the same bank (bank assumed); C0
    db $20, $01, $14, $09, $B0
    ds $12, $B1
    db $B2, $B6, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F, $30, $31, $32, $33
    db $34, $35, $36, $37, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40, $41, $42, $43, $44, $45
    db $46, $47, $48, $49, $B7, $B6
    ds $12, $C3
    db $B7, $B6, $4A, $4B, $4C, $4D, $4E, $4F, $50, $51, $52, $53, $54, $55, $56, $57
    db $58, $59, $5A, $5B, $B7, $B8
    ds $12, $B9
    db $BA, $B6, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $C3, $BE, $C3, $C3, $C3, $C3, $C3
    db $C3, $C3, $C3, $C3, $B7, $B3
    ds $12, $B4
    db $B5
    ds $57D, $00
