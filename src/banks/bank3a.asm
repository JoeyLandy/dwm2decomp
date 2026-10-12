SECTION "Bank 3A", ROMX[$4000], BANK[$3A]
    db $3A

; reads the effect flags in wDAD2. First, when the low two bits of wBattleTarget are 3 and wBattleActionId is $85-$88, it returns unless wDAD2 bit 0 or bit 6 is set. Then it tests bits 7, 6, 5, 4, 3, 2 in that order and selects one of six tables (Data_03A_40CC, Data_03A_4294, Data_03A_445C, Data_03A_47EC, Data_03A_486C; bit 4 has its own branch) indexed by wBattleActionId. An entry of $FF returns; other entries go on to ActionEffectTable_Flag3_ClearEffectFlags52 or the effect code, which is not read (E-0057)
; 15 call sites from 13 routines (e.g. RunBattleActions_StatusChecks_CompareActionIdWithCD, RunBattleStep4_ResolveSkill_SelectEffectByEffectFlags, ResolveStep0EEffect_WriteBattleSubStep2AndEffectSubStepEtc, ResolveStep0EEffect_Scale80Percent_SkipTurnIfActorAbsent, ...)
; reads: wBattleTarget, wBattleActionId, wEffectFlags, wDefeatByteBF, wRecordBufferData, wBattleActor, wBattleArg0, wEffectTileOffset
; writes: wBattleActor, wEffectRoutine, wEffectId, wEffectFrameCounter, wEffectFlags52, wBattleArg0, wEffectTileOffset, wEffectByteB5, ...
; points at: wEffectSpriteX, wEffectStep, wEffectByteB3, wEffectFlags
SelectEffectByEffectFlags::
Func_03A_4001:: ; address name
    ld a, [wBattleTarget]
    and a, $03
    cp a, $03
    jr nz, .check_effect_flags
    ld a, [wBattleActionId]
    cp a, $85
    ret c
    cp a, $89
    ret nc
    ld a, [wEffectFlags]
    and a, $41
    ret z

.check_effect_flags:
    ld a, [wEffectFlags]
    or a, a
    ret z
    bit 7, a
    jr nz, .skip2
    bit 6, a
    jr nz, .check_bit02
    bit 5, a
    jr nz, .read_battle_action_id
    bit 4, a
    jr nz, .check_bit0
    bit 3, a
    jr nz, .read_battle_target2
    bit 2, a
    jr nz, .read_battle_target
    ret

.read_battle_target:
    ld a, [wBattleTarget]
    ld [wBattleActor], a
    ld hl, ActionEffectTable_Flag2
    jr .read_battle_action_id2

.read_battle_target2:
    ld a, [wBattleTarget]
    ld [wBattleActor], a
    ld hl, ActionEffectTable_Flag3
    jr .read_battle_action_id2

.check_bit0:
    bit 0, a
    ret z
    srl a
    and a, $07
    cp a, $00
    jr z, .call_target_on_local_side_bank3_a
    cp a, $01
    jr z, .skip
    ret

.skip:
    ld a, $14
    jp ActionEffectTable_Flag3_ClearEffectFlags52

.call_target_on_local_side_bank3_a:
    call TargetOnLocalSide_Bank3A
    ld a, $02
    jp c, .set_effect_routine
    ld a, $03
    jr .set_effect_routine

.skip2:
    ld hl, ActionEffectTable_Flag7
    jr .read_battle_action_id2

.check_bit02:
    bit 0, a
    ret z
    ld hl, ActionEffectTable_Flag6
    jr .read_battle_action_id2

.read_battle_action_id:
    ld hl, ActionEffectTable_Flag5

.read_battle_action_id2:
    ld a, [wBattleActionId]
    push af
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    pop af
    cp a, $6C
    jr z, .call_target_on_local_side_bank3_a2
    ld a, [wDefeatByteBF]
    bit 0, a
    jr nz, .call_target_on_local_side_bank3_a2
    ld a, [wRecordBufferData + $4]
    cp a, $80
    jr z, .call_target_on_local_side_bank3_a2
    call ActorOnLocalSide_Bank3A
    jr nc, .skip3
    inc hl
    jr .skip3

.call_target_on_local_side_bank3_a2:
    call TargetOnLocalSide_Bank3A
    jr c, .skip3
    inc hl
    jr .skip3

.skip3:
    ld a, [hl]
    cp a, $FF
    ret z
    bit 7, a
    jp z, ActionEffectTable_Flag3_ClearEffectFlags52

.set_effect_routine:
    and a, $7F
    ld [wEffectRoutine], a
    ld a, $00
    ld [wEffectId], a
    xor a, a
    ld hl, wEffectSpriteX
    ld bc, $0004
    call FillBytes
    xor a, a
    ld [wEffectFrameCounter], a
    ret

; E-0209 (C1: SelectEffectByEffectFlags uses this table for wEffectFlags bit 7, indexed by wBattleActionId: byte 1 when ActorOnLocalSide (or, for action $6C and some flags, TargetOnLocalSide) says near side, else byte 0; $FF returns, bit 7 set starts effect routine (value & $7F), other values go to ActionEffectTable_Flag3_ClearEffectFlags52; the debug viewer DrawSkillByte0AndRun502BAnd53B9_Sub01 shows the first three tables; 228 entries).
; record: effect byte for a far-side actor, for a near-side actor ($FF = none)
ActionEffectTable_Flag7::
Data_03A_40CC:: ; address name
    db $FF, $FF ; id 0
    db $FF, $00 ; id 1
    db $FF, $01 ; id 2
    db $FF, $02 ; id 3
    db $FF, $03 ; id 4
    db $FF, $04 ; id 5
    db $FF, $05 ; id 6
    db $FF, $06 ; id 7
    db $FF, $07 ; id 8
    db $FF, $08 ; id 9
    db $FF, $09 ; id 10
    db $FF, $0A ; id 11
    db $FF, $0B ; id 12
    db $FF, $0F ; id 13
    db $FF, $10 ; id 14
    db $FF, $11 ; id 15
    db $FF, $0C ; id 16
    db $FF, $0D ; id 17
    db $FF, $0E ; id 18
    db $FF, $FF ; id 19
    db $FF, $FF ; id 20
    db $FF, $FF ; id 21
    db $FF, $FF ; id 22
    db $FF, $FF ; id 23
    db $FF, $FF ; id 24
    db $FF, $FF ; id 25
    db $FF, $FF ; id 26
    db $FF, $FF ; id 27
    db $FF, $FF ; id 28
    db $FF, $FF ; id 29
    db $FF, $FF ; id 30
    db $FF, $FF ; id 31
    db $FF, $FF ; id 32
    db $FF, $FF ; id 33
    db $FF, $FF ; id 34
    db $FF, $FF ; id 35
    db $FF, $FF ; id 36
    db $FF, $FF ; id 37
    db $FF, $FF ; id 38
    db $FF, $FF ; id 39
    db $FF, $FF ; id 40
    db $FF, $FF ; id 41
    db $FF, $FF ; id 42
    db $FF, $FF ; id 43
    db $FF, $FF ; id 44
    db $FF, $FF ; id 45
    db $FF, $FF ; id 46
    db $FF, $FF ; id 47
    db $FF, $FF ; id 48
    db $FF, $FF ; id 49
    db $FF, $FF ; id 50
    db $FF, $FF ; id 51
    db $FF, $FF ; id 52
    db $FF, $FF ; id 53
    db $FF, $FF ; id 54
    db $FF, $FF ; id 55
    db $FF, $FF ; id 56
    db $FF, $FF ; id 57
    db $FF, $FF ; id 58
    db $FF, $FF ; id 59
    db $86, $86 ; id 60
    db $FF, $2A ; id 61
    db $FF, $29 ; id 62
    db $FF, $28 ; id 63
    db $FF, $03 ; id 64
    db $FF, $04 ; id 65
    db $FF, $05 ; id 66
    db $FF, $1C ; id 67
    db $FF, $0C ; id 68
    db $FF, $0D ; id 69
    db $FF, $0E ; id 70
    db $FF, $1A ; id 71
    db $FF, $09 ; id 72
    db $FF, $0B ; id 73
    db $FF, $0F ; id 74
    db $FF, $1B ; id 75
    db $FF, $2D ; id 76
    db $FF, $2E ; id 77
    db $FF, $FF ; id 78
    db $FF, $FF ; id 79
    db $FF, $1E ; id 80
    db $FF, $20 ; id 81
    db $FF, $1F ; id 82
    db $FF, $21 ; id 83
    db $FF, $22 ; id 84
    db $FF, $1D ; id 85
    db $FF, $1D ; id 86
    db $FF, $23 ; id 87
    db $FF, $22 ; id 88
    db $FF, $1D ; id 89
    db $FF, $24 ; id 90
    db $FF, $24 ; id 91
    db $FF, $25 ; id 92
    db $FF, $2F ; id 93
    db $FF, $25 ; id 94
    db $FF, $FF ; id 95
    db $FF, $FF ; id 96
    db $FF, $FF ; id 97
    db $FF, $1D ; id 98
    db $FF, $FF ; id 99
    db $FF, $FF ; id 100
    db $FF, $1D ; id 101
    db $FF, $27 ; id 102
    db $FF, $26 ; id 103
    db $FF, $FF ; id 104
    db $FF, $FF ; id 105
    db $FF, $FF ; id 106
    db $FF, $1D ; id 107
    db $FF, $1D ; id 108
    db $FF, $1D ; id 109
    db $FF, $FF ; id 110
    db $FF, $FF ; id 111
    db $FF, $FF ; id 112
    db $FF, $FF ; id 113
    db $FF, $FF ; id 114
    db $FF, $FF ; id 115
    db $FF, $FF ; id 116
    db $FF, $FF ; id 117
    db $FF, $FF ; id 118
    db $FF, $FF ; id 119
    db $FF, $FF ; id 120
    db $FF, $FF ; id 121
    db $FF, $FF ; id 122
    db $FF, $FF ; id 123
    db $FF, $FF ; id 124
    db $FF, $FF ; id 125
    db $FF, $FF ; id 126
    db $84, $84 ; id 127
    db $84, $84 ; id 128
    db $84, $84 ; id 129
    db $85, $85 ; id 130
    db $2B, $2B ; id 131
    db $85, $85 ; id 132
    db $FF, $FF ; id 133
    db $FF, $FF ; id 134
    db $FF, $FF ; id 135
    db $FF, $FF ; id 136
    db $FF, $FF ; id 137
    db $FF, $FF ; id 138
    db $FF, $FF ; id 139
    db $FF, $FF ; id 140
    db $FF, $FF ; id 141
    db $FF, $FF ; id 142
    db $FF, $FF ; id 143
    db $FF, $FF ; id 144
    db $FF, $30 ; id 145
    db $FF, $FF ; id 146
    db $FF, $FF ; id 147
    db $FF, $FF ; id 148
    db $FF, $FF ; id 149
    db $FF, $FF ; id 150
    db $FF, $FF ; id 151
    db $FF, $FF ; id 152
    db $FF, $FF ; id 153
    db $FF, $FF ; id 154
    db $31, $FF ; id 155
    db $84, $84 ; id 156
    db $FF, $FF ; id 157
    db $FF, $FF ; id 158
    db $FF, $FF ; id 159
    db $FF, $FF ; id 160
    db $FF, $FF ; id 161
    db $FF, $FF ; id 162
    db $FF, $FF ; id 163
    db $FF, $FF ; id 164
    db $FF, $FF ; id 165
    db $FF, $FF ; id 166
    db $FF, $FF ; id 167
    db $FF, $FF ; id 168
    db $FF, $FF ; id 169
    db $FF, $FF ; id 170
    db $FF, $FF ; id 171
    db $FF, $FF ; id 172
    db $FF, $FF ; id 173
    db $FF, $FF ; id 174
    db $FF, $FF ; id 175
    db $FF, $FF ; id 176
    db $FF, $FF ; id 177
    db $FF, $FF ; id 178
    db $85, $85 ; id 179
    db $FF, $FF ; id 180
    db $FF, $FF ; id 181
    db $FF, $FF ; id 182
    db $FF, $FF ; id 183
    db $FF, $FF ; id 184
    db $FF, $FF ; id 185
    db $FF, $FF ; id 186
    db $FF, $FF ; id 187
    db $FF, $FF ; id 188
    db $FF, $FF ; id 189
    db $FF, $FF ; id 190
    db $FF, $FF ; id 191
    db $FF, $FF ; id 192
    db $FF, $FF ; id 193
    db $FF, $FF ; id 194
    db $FF, $FF ; id 195
    db $FF, $FF ; id 196
    db $FF, $FF ; id 197
    db $FF, $FF ; id 198
    db $FF, $FF ; id 199
    db $FF, $FF ; id 200
    db $FF, $FF ; id 201
    db $FF, $FF ; id 202
    db $FF, $FF ; id 203
    db $FF, $FF ; id 204
    db $FF, $30 ; id 205
    db $FF, $FF ; id 206
    db $FF, $FF ; id 207
    db $FF, $33 ; id 208
    db $FF, $34 ; id 209
    db $FF, $35 ; id 210
    db $FF, $36 ; id 211
    db $FF, $37 ; id 212
    db $FF, $38 ; id 213
    db $FF, $FF ; id 214
    db $FF, $30 ; id 215
    db $FF, $1D ; id 216
    db $FF, $2A ; id 217
    db $FF, $FF ; id 218
    db $85, $85 ; id 219
    db $FF, $FF ; id 220
    db $FF, $FF ; id 221
    db $FF, $FF ; id 222
    db $FF, $FF ; id 223
    db $FF, $FF ; id 224
    db $FF, $FF ; id 225
    db $FF, $FF ; id 226
    db $3B, $FF ; id 227

; E-0209 (C1: SelectEffectByEffectFlags uses this table for wEffectFlags bit 6 (with bit 0), indexed by wBattleActionId: byte 1 when ActorOnLocalSide (or, for action $6C and some flags, TargetOnLocalSide) says near side, else byte 0; $FF returns, bit 7 set starts effect routine (value & $7F), other values go to ActionEffectTable_Flag3_ClearEffectFlags52; the debug viewer DrawSkillByte0AndRun502BAnd53B9_Sub01 shows the first three tables; 228 entries).
; record: effect byte for a far-side actor, for a near-side actor ($FF = none)
ActionEffectTable_Flag6::
Data_03A_4294:: ; address name
    db $83, $82 ; id 0
    db $83, $82 ; id 1
    db $83, $82 ; id 2
    db $83, $82 ; id 3
    db $83, $82 ; id 4
    db $83, $82 ; id 5
    db $83, $82 ; id 6
    db $83, $82 ; id 7
    db $83, $82 ; id 8
    db $83, $82 ; id 9
    db $83, $82 ; id 10
    db $83, $82 ; id 11
    db $83, $82 ; id 12
    db $83, $82 ; id 13
    db $83, $82 ; id 14
    db $83, $82 ; id 15
    db $83, $82 ; id 16
    db $83, $82 ; id 17
    db $83, $82 ; id 18
    db $FF, $81 ; id 19
    db $FF, $81 ; id 20
    db $FF, $81 ; id 21
    db $14, $FF ; id 22
    db $14, $FF ; id 23
    db $14, $FF ; id 24
    db $14, $FF ; id 25
    db $14, $FF ; id 26
    db $14, $FF ; id 27
    db $14, $FF ; id 28
    db $14, $FF ; id 29
    db $80, $FF ; id 30
    db $80, $FF ; id 31
    db $14, $FF ; id 32
    db $14, $FF ; id 33
    db $14, $FF ; id 34
    db $14, $FF ; id 35
    db $14, $FF ; id 36
    db $13, $FF ; id 37
    db $13, $FF ; id 38
    db $FF, $12 ; id 39
    db $FF, $12 ; id 40
    db $13, $FF ; id 41
    db $13, $FF ; id 42
    db $FF, $12 ; id 43
    db $FF, $12 ; id 44
    db $13, $FF ; id 45
    db $FF, $17 ; id 46
    db $FF, $15 ; id 47
    db $FF, $15 ; id 48
    db $13, $FF ; id 49
    db $13, $12 ; id 50
    db $FF, $12 ; id 51
    db $FF, $16 ; id 52
    db $FF, $FF ; id 53
    db $19, $FF ; id 54
    db $19, $FF ; id 55
    db $FF, $FF ; id 56
    db $FF, $FF ; id 57
    db $18, $FF ; id 58
    db $18, $FF ; id 59
    db $FF, $FF ; id 60
    db $83, $82 ; id 61
    db $83, $82 ; id 62
    db $83, $82 ; id 63
    db $83, $82 ; id 64
    db $83, $82 ; id 65
    db $83, $82 ; id 66
    db $83, $82 ; id 67
    db $83, $82 ; id 68
    db $83, $82 ; id 69
    db $83, $82 ; id 70
    db $83, $82 ; id 71
    db $83, $82 ; id 72
    db $83, $82 ; id 73
    db $83, $82 ; id 74
    db $83, $82 ; id 75
    db $83, $82 ; id 76
    db $83, $82 ; id 77
    db $83, $82 ; id 78
    db $83, $82 ; id 79
    db $83, $82 ; id 80
    db $83, $82 ; id 81
    db $83, $82 ; id 82
    db $83, $82 ; id 83
    db $83, $82 ; id 84
    db $83, $82 ; id 85
    db $83, $82 ; id 86
    db $83, $82 ; id 87
    db $83, $82 ; id 88
    db $83, $82 ; id 89
    db $83, $82 ; id 90
    db $83, $82 ; id 91
    db $83, $82 ; id 92
    db $83, $82 ; id 93
    db $83, $82 ; id 94
    db $83, $82 ; id 95
    db $83, $82 ; id 96
    db $83, $82 ; id 97
    db $83, $82 ; id 98
    db $83, $82 ; id 99
    db $83, $82 ; id 100
    db $83, $82 ; id 101
    db $83, $82 ; id 102
    db $83, $82 ; id 103
    db $FF, $FF ; id 104
    db $83, $82 ; id 105
    db $83, $82 ; id 106
    db $83, $82 ; id 107
    db $83, $82 ; id 108
    db $83, $82 ; id 109
    db $83, $82 ; id 110
    db $83, $82 ; id 111
    db $83, $82 ; id 112
    db $FF, $15 ; id 113
    db $FF, $15 ; id 114
    db $FF, $15 ; id 115
    db $FF, $15 ; id 116
    db $FF, $16 ; id 117
    db $FF, $12 ; id 118
    db $13, $12 ; id 119
    db $FF, $16 ; id 120
    db $FF, $FF ; id 121
    db $FF, $16 ; id 122
    db $14, $FF ; id 123
    db $14, $FF ; id 124
    db $FF, $FF ; id 125
    db $FF, $17 ; id 126
    db $83, $82 ; id 127
    db $FF, $FF ; id 128
    db $FF, $FF ; id 129
    db $FF, $FF ; id 130
    db $FF, $FF ; id 131
    db $FF, $FF ; id 132
    db $84, $84 ; id 133
    db $84, $84 ; id 134
    db $84, $84 ; id 135
    db $84, $84 ; id 136
    db $FF, $FF ; id 137
    db $FF, $FF ; id 138
    db $FF, $15 ; id 139
    db $FF, $15 ; id 140
    db $83, $82 ; id 141
    db $83, $82 ; id 142
    db $FF, $16 ; id 143
    db $83, $82 ; id 144
    db $8D, $83 ; id 145
    db $FF, $FF ; id 146
    db $FF, $FF ; id 147
    db $FF, $FF ; id 148
    db $FF, $FF ; id 149
    db $FF, $FF ; id 150
    db $FF, $FF ; id 151
    db $FF, $FF ; id 152
    db $FF, $FF ; id 153
    db $FF, $FF ; id 154
    db $FF, $FF ; id 155
    db $FF, $FF ; id 156
    db $FF, $FF ; id 157
    db $FF, $FF ; id 158
    db $14, $FF ; id 159
    db $FF, $FF ; id 160
    db $32, $32 ; id 161
    db $FF, $FF ; id 162
    db $FF, $FF ; id 163
    db $FF, $FF ; id 164
    db $FF, $FF ; id 165
    db $FF, $FF ; id 166
    db $FF, $FF ; id 167
    db $FF, $FF ; id 168
    db $FF, $FF ; id 169
    db $83, $82 ; id 170
    db $FF, $FF ; id 171
    db $FF, $FF ; id 172
    db $FF, $FF ; id 173
    db $FF, $FF ; id 174
    db $FF, $FF ; id 175
    db $FF, $81 ; id 176
    db $14, $FF ; id 177
    db $FF, $81 ; id 178
    db $FF, $82 ; id 179
    db $FF, $FF ; id 180
    db $FF, $15 ; id 181
    db $12, $FF ; id 182
    db $FF, $FF ; id 183
    db $18, $FF ; id 184
    db $83, $82 ; id 185
    db $FF, $82 ; id 186
    db $FF, $FF ; id 187
    db $14, $FF ; id 188
    db $83, $82 ; id 189
    db $FF, $FF ; id 190
    db $FF, $FF ; id 191
    db $82, $83 ; id 192
    db $83, $82 ; id 193
    db $82, $83 ; id 194
    db $FF, $FF ; id 195
    db $FF, $FF ; id 196
    db $FF, $FF ; id 197
    db $FF, $FF ; id 198
    db $FF, $FF ; id 199
    db $FF, $FF ; id 200
    db $82, $83 ; id 201
    db $82, $83 ; id 202
    db $82, $83 ; id 203
    db $83, $82 ; id 204
    db $8D, $83 ; id 205
    db $FF, $FF ; id 206
    db $32, $32 ; id 207
    db $83, $82 ; id 208
    db $83, $82 ; id 209
    db $83, $82 ; id 210
    db $83, $82 ; id 211
    db $83, $82 ; id 212
    db $83, $82 ; id 213
    db $FF, $81 ; id 214
    db $83, $82 ; id 215
    db $83, $82 ; id 216
    db $83, $82 ; id 217
    db $14, $FF ; id 218
    db $FF, $FF ; id 219
    db $18, $FF ; id 220
    db $13, $FF ; id 221
    db $FF, $FF ; id 222
    db $13, $12 ; id 223
    db $FF, $FF ; id 224
    db $FF, $16 ; id 225
    db $FF, $FF ; id 226
    db $FF, $FF ; id 227

; E-0209 (C1: SelectEffectByEffectFlags uses this table for wEffectFlags bit 5, indexed by wBattleActionId: byte 1 when ActorOnLocalSide (or, for action $6C and some flags, TargetOnLocalSide) says near side, else byte 0; $FF returns, bit 7 set starts effect routine (value & $7F), other values go to ActionEffectTable_Flag3_ClearEffectFlags52; the debug viewer DrawSkillByte0AndRun502BAnd53B9_Sub01 shows the first three tables; 228 entries).
; record: effect byte for a far-side actor, for a near-side actor ($FF = none)
ActionEffectTable_Flag5::
Data_03A_445C:: ; address name
    db $FF, $FF ; id 0
    db $FF, $FF ; id 1
    db $FF, $FF ; id 2
    db $FF, $FF ; id 3
    db $FF, $FF ; id 4
    db $FF, $FF ; id 5
    db $FF, $FF ; id 6
    db $FF, $FF ; id 7
    db $FF, $FF ; id 8
    db $FF, $FF ; id 9
    db $FF, $FF ; id 10
    db $FF, $FF ; id 11
    db $FF, $FF ; id 12
    db $FF, $FF ; id 13
    db $FF, $FF ; id 14
    db $FF, $FF ; id 15
    db $FF, $FF ; id 16
    db $FF, $FF ; id 17
    db $FF, $FF ; id 18
    db $FF, $FF ; id 19
    db $FF, $FF ; id 20
    db $FF, $FF ; id 21
    db $FF, $FF ; id 22
    db $FF, $FF ; id 23
    db $FF, $FF ; id 24
    db $FF, $FF ; id 25
    db $FF, $FF ; id 26
    db $FF, $FF ; id 27
    db $FF, $FF ; id 28
    db $FF, $FF ; id 29
    db $FF, $FF ; id 30
    db $FF, $FF ; id 31
    db $FF, $FF ; id 32
    db $FF, $FF ; id 33
    db $FF, $FF ; id 34
    db $FF, $FF ; id 35
    db $FF, $FF ; id 36
    db $FF, $FF ; id 37
    db $FF, $FF ; id 38
    db $FF, $FF ; id 39
    db $FF, $FF ; id 40
    db $FF, $FF ; id 41
    db $FF, $FF ; id 42
    db $FF, $FF ; id 43
    db $FF, $FF ; id 44
    db $FF, $FF ; id 45
    db $FF, $FF ; id 46
    db $FF, $FF ; id 47
    db $FF, $FF ; id 48
    db $FF, $FF ; id 49
    db $FF, $FF ; id 50
    db $FF, $FF ; id 51
    db $FF, $FF ; id 52
    db $FF, $FF ; id 53
    db $FF, $FF ; id 54
    db $FF, $FF ; id 55
    db $FF, $FF ; id 56
    db $FF, $FF ; id 57
    db $FF, $FF ; id 58
    db $FF, $FF ; id 59
    db $FF, $FF ; id 60
    db $FF, $FF ; id 61
    db $FF, $FF ; id 62
    db $FF, $FF ; id 63
    db $FF, $FF ; id 64
    db $FF, $FF ; id 65
    db $FF, $FF ; id 66
    db $FF, $FF ; id 67
    db $FF, $FF ; id 68
    db $FF, $FF ; id 69
    db $FF, $FF ; id 70
    db $FF, $FF ; id 71
    db $FF, $FF ; id 72
    db $FF, $FF ; id 73
    db $FF, $FF ; id 74
    db $FF, $FF ; id 75
    db $FF, $FF ; id 76
    db $FF, $FF ; id 77
    db $FF, $FF ; id 78
    db $FF, $FF ; id 79
    db $FF, $FF ; id 80
    db $FF, $FF ; id 81
    db $FF, $FF ; id 82
    db $FF, $FF ; id 83
    db $FF, $FF ; id 84
    db $FF, $FF ; id 85
    db $FF, $FF ; id 86
    db $FF, $FF ; id 87
    db $FF, $FF ; id 88
    db $FF, $FF ; id 89
    db $FF, $FF ; id 90
    db $FF, $FF ; id 91
    db $FF, $FF ; id 92
    db $FF, $FF ; id 93
    db $FF, $FF ; id 94
    db $FF, $15 ; id 95
    db $FF, $15 ; id 96
    db $FF, $15 ; id 97
    db $FF, $FF ; id 98
    db $FF, $FF ; id 99
    db $FF, $FF ; id 100
    db $FF, $FF ; id 101
    db $FF, $FF ; id 102
    db $FF, $FF ; id 103
    db $FF, $FF ; id 104
    db $FF, $FF ; id 105
    db $FF, $FF ; id 106
    db $FF, $FF ; id 107
    db $FF, $FF ; id 108
    db $8D, $83 ; id 109
    db $FF, $FF ; id 110
    db $8D, $83 ; id 111
    db $8D, $83 ; id 112
    db $FF, $FF ; id 113
    db $FF, $FF ; id 114
    db $FF, $FF ; id 115
    db $FF, $FF ; id 116
    db $FF, $FF ; id 117
    db $FF, $FF ; id 118
    db $FF, $FF ; id 119
    db $FF, $FF ; id 120
    db $FF, $FF ; id 121
    db $FF, $FF ; id 122
    db $FF, $FF ; id 123
    db $FF, $FF ; id 124
    db $FF, $FF ; id 125
    db $FF, $FF ; id 126
    db $FF, $FF ; id 127
    db $FF, $FF ; id 128
    db $FF, $FF ; id 129
    db $FF, $FF ; id 130
    db $FF, $FF ; id 131
    db $FF, $FF ; id 132
    db $FF, $FF ; id 133
    db $FF, $FF ; id 134
    db $FF, $FF ; id 135
    db $FF, $FF ; id 136
    db $FF, $FF ; id 137
    db $FF, $FF ; id 138
    db $FF, $FF ; id 139
    db $FF, $FF ; id 140
    db $FF, $FF ; id 141
    db $FF, $FF ; id 142
    db $FF, $FF ; id 143
    db $FF, $FF ; id 144
    db $FF, $FF ; id 145
    db $FF, $FF ; id 146
    db $FF, $FF ; id 147
    db $FF, $FF ; id 148
    db $FF, $FF ; id 149
    db $FF, $FF ; id 150
    db $FF, $FF ; id 151
    db $FF, $FF ; id 152
    db $FF, $FF ; id 153
    db $FF, $FF ; id 154
    db $FF, $FF ; id 155
    db $FF, $FF ; id 156
    db $FF, $FF ; id 157
    db $FF, $FF ; id 158
    db $FF, $FF ; id 159
    db $FF, $FF ; id 160
    db $FF, $FF ; id 161
    db $FF, $FF ; id 162
    db $FF, $FF ; id 163
    db $FF, $FF ; id 164
    db $FF, $FF ; id 165
    db $FF, $FF ; id 166
    db $FF, $FF ; id 167
    db $FF, $FF ; id 168
    db $FF, $FF ; id 169
    db $FF, $FF ; id 170
    db $FF, $FF ; id 171
    db $FF, $FF ; id 172
    db $FF, $FF ; id 173
    db $FF, $FF ; id 174
    db $FF, $FF ; id 175
    db $FF, $FF ; id 176
    db $FF, $FF ; id 177
    db $FF, $FF ; id 178
    db $FF, $FF ; id 179
    db $FF, $FF ; id 180
    db $FF, $FF ; id 181
    db $FF, $FF ; id 182
    db $FF, $FF ; id 183
    db $FF, $FF ; id 184
    db $FF, $FF ; id 185
    db $FF, $FF ; id 186
    db $FF, $FF ; id 187
    db $FF, $FF ; id 188
    db $FF, $FF ; id 189
    db $FF, $FF ; id 190
    db $FF, $FF ; id 191
    db $FF, $FF ; id 192
    db $FF, $FF ; id 193
    db $FF, $FF ; id 194
    db $FF, $FF ; id 195
    db $FF, $FF ; id 196
    db $FF, $FF ; id 197
    db $FF, $FF ; id 198
    db $FF, $FF ; id 199
    db $FF, $FF ; id 200
    db $FF, $FF ; id 201
    db $FF, $FF ; id 202
    db $FF, $FF ; id 203
    db $FF, $FF ; id 204
    db $FF, $FF ; id 205
    db $FF, $FF ; id 206
    db $FF, $FF ; id 207
    db $FF, $FF ; id 208
    db $FF, $FF ; id 209
    db $FF, $FF ; id 210
    db $FF, $FF ; id 211
    db $FF, $FF ; id 212
    db $FF, $FF ; id 213
    db $FF, $FF ; id 214
    db $FF, $FF ; id 215
    db $FF, $FF ; id 216
    db $FF, $FF ; id 217
    db $FF, $FF ; id 218
    db $FF, $FF ; id 219
    db $FF, $FF ; id 220
    db $FF, $FF ; id 221
    db $FF, $FF ; id 222
    db $FF, $FF ; id 223
    db $FF, $FF ; id 224
    db $FF, $FF ; id 225
    db $FF, $FF ; id 226
    db $FF, $FF ; id 227

; E-0209 (C1: 228 entries of $FF $FF between ActionEffectTable_Flag5 and ActionEffectTable_Flag2, the size of one more table; no reader found).
; record: effect byte for a far-side actor, for a near-side actor ($FF = none)
ActionEffectTable_Unused::
Data_03A_4624:: ; address name
    db $FF, $FF ; id 0
    db $FF, $FF ; id 1
    db $FF, $FF ; id 2
    db $FF, $FF ; id 3
    db $FF, $FF ; id 4
    db $FF, $FF ; id 5
    db $FF, $FF ; id 6
    db $FF, $FF ; id 7
    db $FF, $FF ; id 8
    db $FF, $FF ; id 9
    db $FF, $FF ; id 10
    db $FF, $FF ; id 11
    db $FF, $FF ; id 12
    db $FF, $FF ; id 13
    db $FF, $FF ; id 14
    db $FF, $FF ; id 15
    db $FF, $FF ; id 16
    db $FF, $FF ; id 17
    db $FF, $FF ; id 18
    db $FF, $FF ; id 19
    db $FF, $FF ; id 20
    db $FF, $FF ; id 21
    db $FF, $FF ; id 22
    db $FF, $FF ; id 23
    db $FF, $FF ; id 24
    db $FF, $FF ; id 25
    db $FF, $FF ; id 26
    db $FF, $FF ; id 27
    db $FF, $FF ; id 28
    db $FF, $FF ; id 29
    db $FF, $FF ; id 30
    db $FF, $FF ; id 31
    db $FF, $FF ; id 32
    db $FF, $FF ; id 33
    db $FF, $FF ; id 34
    db $FF, $FF ; id 35
    db $FF, $FF ; id 36
    db $FF, $FF ; id 37
    db $FF, $FF ; id 38
    db $FF, $FF ; id 39
    db $FF, $FF ; id 40
    db $FF, $FF ; id 41
    db $FF, $FF ; id 42
    db $FF, $FF ; id 43
    db $FF, $FF ; id 44
    db $FF, $FF ; id 45
    db $FF, $FF ; id 46
    db $FF, $FF ; id 47
    db $FF, $FF ; id 48
    db $FF, $FF ; id 49
    db $FF, $FF ; id 50
    db $FF, $FF ; id 51
    db $FF, $FF ; id 52
    db $FF, $FF ; id 53
    db $FF, $FF ; id 54
    db $FF, $FF ; id 55
    db $FF, $FF ; id 56
    db $FF, $FF ; id 57
    db $FF, $FF ; id 58
    db $FF, $FF ; id 59
    db $FF, $FF ; id 60
    db $FF, $FF ; id 61
    db $FF, $FF ; id 62
    db $FF, $FF ; id 63
    db $FF, $FF ; id 64
    db $FF, $FF ; id 65
    db $FF, $FF ; id 66
    db $FF, $FF ; id 67
    db $FF, $FF ; id 68
    db $FF, $FF ; id 69
    db $FF, $FF ; id 70
    db $FF, $FF ; id 71
    db $FF, $FF ; id 72
    db $FF, $FF ; id 73
    db $FF, $FF ; id 74
    db $FF, $FF ; id 75
    db $FF, $FF ; id 76
    db $FF, $FF ; id 77
    db $FF, $FF ; id 78
    db $FF, $FF ; id 79
    db $FF, $FF ; id 80
    db $FF, $FF ; id 81
    db $FF, $FF ; id 82
    db $FF, $FF ; id 83
    db $FF, $FF ; id 84
    db $FF, $FF ; id 85
    db $FF, $FF ; id 86
    db $FF, $FF ; id 87
    db $FF, $FF ; id 88
    db $FF, $FF ; id 89
    db $FF, $FF ; id 90
    db $FF, $FF ; id 91
    db $FF, $FF ; id 92
    db $FF, $FF ; id 93
    db $FF, $FF ; id 94
    db $FF, $FF ; id 95
    db $FF, $FF ; id 96
    db $FF, $FF ; id 97
    db $FF, $FF ; id 98
    db $FF, $FF ; id 99
    db $FF, $FF ; id 100
    db $FF, $FF ; id 101
    db $FF, $FF ; id 102
    db $FF, $FF ; id 103
    db $FF, $FF ; id 104
    db $FF, $FF ; id 105
    db $FF, $FF ; id 106
    db $FF, $FF ; id 107
    db $FF, $FF ; id 108
    db $FF, $FF ; id 109
    db $FF, $FF ; id 110
    db $FF, $FF ; id 111
    db $FF, $FF ; id 112
    db $FF, $FF ; id 113
    db $FF, $FF ; id 114
    db $FF, $FF ; id 115
    db $FF, $FF ; id 116
    db $FF, $FF ; id 117
    db $FF, $FF ; id 118
    db $FF, $FF ; id 119
    db $FF, $FF ; id 120
    db $FF, $FF ; id 121
    db $FF, $FF ; id 122
    db $FF, $FF ; id 123
    db $FF, $FF ; id 124
    db $FF, $FF ; id 125
    db $FF, $FF ; id 126
    db $FF, $FF ; id 127
    db $FF, $FF ; id 128
    db $FF, $FF ; id 129
    db $FF, $FF ; id 130
    db $FF, $FF ; id 131
    db $FF, $FF ; id 132
    db $FF, $FF ; id 133
    db $FF, $FF ; id 134
    db $FF, $FF ; id 135
    db $FF, $FF ; id 136
    db $FF, $FF ; id 137
    db $FF, $FF ; id 138
    db $FF, $FF ; id 139
    db $FF, $FF ; id 140
    db $FF, $FF ; id 141
    db $FF, $FF ; id 142
    db $FF, $FF ; id 143
    db $FF, $FF ; id 144
    db $FF, $FF ; id 145
    db $FF, $FF ; id 146
    db $FF, $FF ; id 147
    db $FF, $FF ; id 148
    db $FF, $FF ; id 149
    db $FF, $FF ; id 150
    db $FF, $FF ; id 151
    db $FF, $FF ; id 152
    db $FF, $FF ; id 153
    db $FF, $FF ; id 154
    db $FF, $FF ; id 155
    db $FF, $FF ; id 156
    db $FF, $FF ; id 157
    db $FF, $FF ; id 158
    db $FF, $FF ; id 159
    db $FF, $FF ; id 160
    db $FF, $FF ; id 161
    db $FF, $FF ; id 162
    db $FF, $FF ; id 163
    db $FF, $FF ; id 164
    db $FF, $FF ; id 165
    db $FF, $FF ; id 166
    db $FF, $FF ; id 167
    db $FF, $FF ; id 168
    db $FF, $FF ; id 169
    db $FF, $FF ; id 170
    db $FF, $FF ; id 171
    db $FF, $FF ; id 172
    db $FF, $FF ; id 173
    db $FF, $FF ; id 174
    db $FF, $FF ; id 175
    db $FF, $FF ; id 176
    db $FF, $FF ; id 177
    db $FF, $FF ; id 178
    db $FF, $FF ; id 179
    db $FF, $FF ; id 180
    db $FF, $FF ; id 181
    db $FF, $FF ; id 182
    db $FF, $FF ; id 183
    db $FF, $FF ; id 184
    db $FF, $FF ; id 185
    db $FF, $FF ; id 186
    db $FF, $FF ; id 187
    db $FF, $FF ; id 188
    db $FF, $FF ; id 189
    db $FF, $FF ; id 190
    db $FF, $FF ; id 191
    db $FF, $FF ; id 192
    db $FF, $FF ; id 193
    db $FF, $FF ; id 194
    db $FF, $FF ; id 195
    db $FF, $FF ; id 196
    db $FF, $FF ; id 197
    db $FF, $FF ; id 198
    db $FF, $FF ; id 199
    db $FF, $FF ; id 200
    db $FF, $FF ; id 201
    db $FF, $FF ; id 202
    db $FF, $FF ; id 203
    db $FF, $FF ; id 204
    db $FF, $FF ; id 205
    db $FF, $FF ; id 206
    db $FF, $FF ; id 207
    db $FF, $FF ; id 208
    db $FF, $FF ; id 209
    db $FF, $FF ; id 210
    db $FF, $FF ; id 211
    db $FF, $FF ; id 212
    db $FF, $FF ; id 213
    db $FF, $FF ; id 214
    db $FF, $FF ; id 215
    db $FF, $FF ; id 216
    db $FF, $FF ; id 217
    db $FF, $FF ; id 218
    db $FF, $FF ; id 219
    db $FF, $FF ; id 220
    db $FF, $FF ; id 221
    db $FF, $FF ; id 222
    db $FF, $FF ; id 223
    db $FF, $FF ; id 224
    db $FF, $FF ; id 225
    db $FF, $FF ; id 226
    db $FF, $FF ; id 227

; E-0209 (C1: SelectEffectByEffectFlags uses this table for wEffectFlags bit 2 (the target acts), indexed by wBattleActionId: byte 1 when ActorOnLocalSide (or, for action $6C and some flags, TargetOnLocalSide) says near side, else byte 0; $FF returns, bit 7 set starts effect routine (value & $7F), other values go to ActionEffectTable_Flag3_ClearEffectFlags52; the debug viewer DrawSkillByte0AndRun502BAnd53B9_Sub01 shows the first three tables; 64 entries).
; record: effect byte for a far-side actor, for a near-side actor ($FF = none)
ActionEffectTable_Flag2::
Data_03A_47EC:: ; address name
    db $FF, $FF ; id 0
    db $14, $FF ; id 1
    db $14, $FF ; id 2
    db $14, $FF ; id 3
    db $14, $FF ; id 4
    db $14, $FF ; id 5
    db $14, $FF ; id 6
    db $14, $FF ; id 7
    db $14, $FF ; id 8
    db $14, $FF ; id 9
    db $14, $FF ; id 10
    db $14, $FF ; id 11
    db $FF, $FF ; id 12
    db $FF, $FF ; id 13
    db $FF, $FF ; id 14
    db $FF, $FF ; id 15
    db $FF, $FF ; id 16
    db $FF, $FF ; id 17
    db $FF, $FF ; id 18
    db $FF, $FF ; id 19
    db $FF, $FF ; id 20
    db $FF, $FF ; id 21
    db $FF, $FF ; id 22
    db $FF, $FF ; id 23
    db $FF, $FF ; id 24
    db $FF, $FF ; id 25
    db $FF, $FF ; id 26
    db $FF, $FF ; id 27
    db $FF, $FF ; id 28
    db $FF, $FF ; id 29
    db $FF, $FF ; id 30
    db $FF, $FF ; id 31
    db $FF, $FF ; id 32
    db $FF, $FF ; id 33
    db $12, $FF ; id 34
    db $FF, $FF ; id 35
    db $82, $FF ; id 36
    db $82, $FF ; id 37
    db $82, $FF ; id 38
    db $82, $FF ; id 39
    db $FF, $FF ; id 40
    db $FF, $FF ; id 41
    db $FF, $FF ; id 42
    db $FF, $FF ; id 43
    db $FF, $FF ; id 44
    db $FF, $FF ; id 45
    db $FF, $FF ; id 46
    db $FF, $FF ; id 47
    db $FF, $FF ; id 48
    db $FF, $FF ; id 49
    db $FF, $FF ; id 50
    db $FF, $FF ; id 51
    db $FF, $FF ; id 52
    db $FF, $FF ; id 53
    db $FF, $FF ; id 54
    db $FF, $FF ; id 55
    db $FF, $FF ; id 56
    db $FF, $FF ; id 57
    db $FF, $FF ; id 58
    db $FF, $FF ; id 59
    db $FF, $FF ; id 60
    db $FF, $FF ; id 61
    db $FF, $FF ; id 62
    db $FF, $FF ; id 63

; E-0209 (C1: SelectEffectByEffectFlags uses this table for wEffectFlags bit 3 (the target acts), indexed by wBattleActionId: byte 1 when ActorOnLocalSide (or, for action $6C and some flags, TargetOnLocalSide) says near side, else byte 0; $FF returns, bit 7 set starts effect routine (value & $7F), other values go to ActionEffectTable_Flag3_ClearEffectFlags52; the debug viewer DrawSkillByte0AndRun502BAnd53B9_Sub01 shows the first three tables; 64 entries).
; record: effect byte for a far-side actor, for a near-side actor ($FF = none)
ActionEffectTable_Flag3::
Data_03A_486C:: ; address name
    db $FF, $FF ; id 0
    db $FF, $FF ; id 1
    db $FF, $FF ; id 2
    db $FF, $FF ; id 3
    db $FF, $FF ; id 4
    db $FF, $FF ; id 5
    db $FF, $FF ; id 6
    db $FF, $FF ; id 7
    db $FF, $FF ; id 8
    db $FF, $FF ; id 9
    db $FF, $FF ; id 10
    db $FF, $FF ; id 11
    db $FF, $FF ; id 12
    db $FF, $FF ; id 13
    db $FF, $FF ; id 14
    db $FF, $FF ; id 15
    db $FF, $FF ; id 16
    db $FF, $FF ; id 17
    db $FF, $FF ; id 18
    db $FF, $FF ; id 19
    db $FF, $FF ; id 20
    db $FF, $FF ; id 21
    db $FF, $FF ; id 22
    db $FF, $FF ; id 23
    db $FF, $FF ; id 24
    db $2C, $FF ; id 25
    db $2C, $FF ; id 26
    db $2C, $FF ; id 27
    db $2C, $FF ; id 28
    db $15, $FF ; id 29
    db $32, $FF ; id 30
    db $FF, $FF ; id 31
    db $FF, $FF ; id 32
    db $FF, $FF ; id 33
    db $FF, $FF ; id 34
    db $FF, $FF ; id 35
    db $09, $FF ; id 36
    db $0F, $FF ; id 37
    db $0E, $FF ; id 38
    db $02, $FF ; id 39
    db $FF, $FF ; id 40
    db $FF, $FF ; id 41
    db $FF, $FF ; id 42
    db $FF, $FF ; id 43
    db $FF, $FF ; id 44
    db $FF, $FF ; id 45
    db $FF, $FF ; id 46
    db $FF, $FF ; id 47
    db $FF, $FF ; id 48
    db $FF, $FF ; id 49
    db $FF, $FF ; id 50
    db $FF, $FF ; id 51
    db $FF, $FF ; id 52
    db $FF, $FF ; id 53
    db $FF, $FF ; id 54
    db $FF, $FF ; id 55
    db $FF, $FF ; id 56
    db $FF, $FF ; id 57
    db $FF, $FF ; id 58
    db $FF, $FF ; id 59
    db $FF, $FF ; id 60
    db $FF, $FF ; id 61
    db $FF, $FF ; id 62
    db $FF, $FF ; id 63

ActionEffectTable_Flag3_ClearEffectFlags52::
Jump_03A_48EC:: ; address name
    push af
    xor a, a
    ld [wEffectFlags52], a
    ld a, [wBattleActionId]
    cp a, $D7
    jr z, .set_effect_flags52_to_01
    jr .call_select_effect_by_effect_flags_write

.set_effect_flags52_to_01:
    ld a, $01
    ld [wEffectFlags52], a

.call_select_effect_by_effect_flags_write:
    pop af
    ld b, a
    call SelectEffectByEffectFlags_WriteBattleArg0
    call SelectEffectByEffectFlags_ReadLinkModeAndLinkRoleEtc
    ld a, b
    jr nc, .set_effect_tile_offset
    cp a, $2B
    jr z, .set_effect_tile_offset
    cp a, $32
    jr z, .set_effect_tile_offset
    cp a, $13
    jr z, .check_battle_action_id
    ret

.check_battle_action_id:
    ld a, [wBattleActionId]
    cp a, $32
    jr z, .check_effect_flags
    cp a, $77
    ret nz

.check_effect_flags:
    ld a, [wEffectFlags]
    cp a, $41
    ret nz
    ld a, [wBattleActor]
    ld [wBattleArg0], a
    ld a, b

.set_effect_tile_offset:
    ld [wEffectTileOffset], a
    ld [wEffectByteB5], a
    ld b, a
    call SelectEffectByEffectFlags_WaitEffectFlags
    jr z, .set_effect_target_mode
    ld a, b
    cp a, $09
    jr nz, .cp_0D
    ld a, [wBattleActionId]
    cp a, $48
    ld a, b
    jr nz, .cp_0D
    xor a, a
    jr .set_effect_target_mode

.cp_0D:
    cp a, $0D
    jr nz, .skip
    ld hl, wEffectFlags
    bit 1, [hl]
    jr z, .skip
    ld a, $00
    jr .set_effect_target_mode

.skip:
    ld hl, SelectEffectByEffectFlags_Data
    add_a_to_hl
    ld a, [hl]

.set_effect_target_mode:
    ld [wEffectTargetMode], a
    cp a, $00
    jr nz, .clear_effect_sprite_x
    ld a, [wBattleArg0]
    call CarryUnlessBattleSlotOutSlotEmpty
    ret c

.clear_effect_sprite_x:
    xor a, a
    ld [wEffectSpriteX], a
    ld a, $FF
    ld hl, wEffectStep
    ld bc, $0003
    call FillBytes
    ld a, $01
    ld [wEffectId], a
    ld a, $01
    ld [wEffectAnimState], a
    ld a, $01
    ld [wEffectActive], a
    ld a, $00
    ld [wEffectByteB3], a
    ld hl, wEffectByteB3
    ld a, l
    ld [wSequencePtrLo], a
    ld a, h
    ld [wSequencePtrHi], a
    farcall TickSequencePtrLoSequence
    call SetEffectSpriteXForTargets
    ld a, [wEffectTileOffset]
    ld c, a
    call LoadEffectOBJPaletteC
    ret

; address loaded by SelectEffectByEffectFlags
SelectEffectByEffectFlags_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_03A_49AF:: ; address name
    db $00, $00, $00, $01, $01, $01, $02, $02, $01, $02, $01, $01, $01, $02, $01, $02
    db $02, $01, $00, $00, $00, $00, $00, $00, $00, $00, $01, $02, $01, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $01, $02, $01, $01, $01, $00, $00, $01, $00
    db $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $01, $01

; only called from SelectEffectByEffectFlags (E-0047)
; 1 call site from 1 routine (e.g. SelectEffectByEffectFlags)
; reads: wLinkMode, wLinkRole, wBattleArg0
SelectEffectByEffectFlags_ReadLinkModeAndLinkRoleEtc::
Func_03A_49EB:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr nz, .check_battle_arg0
    ld a, [wLinkRole]
    bit 1, a
    jr z, .check_battle_arg0
    ld a, [wBattleArg0]
    cp a, $04
    ccf
    ret

.check_battle_arg0:
    ld a, [wBattleArg0]
    cp a, $04
    ret

; only called from SelectEffectByEffectFlags (E-0047)
; 1 call site from 1 routine (e.g. SelectEffectByEffectFlags)
; reads: wEffectFlags, wBattleActionId
SelectEffectByEffectFlags_WaitEffectFlags::
Func_03A_4A06:: ; address name
    ld a, [wEffectFlags]
    bit 3, a
    ret nz
    ld a, b
    cp a, $1D
    ret nz
    ld a, [wBattleActionId]
    cp a, $65
    ret nz
    ld a, $02
    ret

; only called from SelectEffectByEffectFlags (E-0047)
; 1 call site from 1 routine (e.g. SelectEffectByEffectFlags)
; reads: wEffectFlags, wBattleActionId, wBattleTarget, wBattleActor
; writes: wBattleArg0
SelectEffectByEffectFlags_WriteBattleArg0::
Func_03A_4A19:: ; address name
    ld a, [wEffectFlags]
    bit 3, a
    jr nz, .read_battle_target
    ld a, [wBattleActionId]
    cp a, $3A
    jr z, .read_battle_actor
    ld a, [wBattleTarget]
    jr .set_battle_arg0

.read_battle_actor:
    ld a, [wBattleActor]

.set_battle_arg0:
    ld [wBattleArg0], a
    ret

.read_battle_target:
    ld a, [wBattleTarget]
    ld [wBattleArg0], a
    ret

; sets wD804 (and the wD805 list for all targets) to the screen X of the target from Data_03A_4AD5 by wDAB9 and the side count wD890 (E-0129)
; 9 call sites from 5 routines (e.g. SelectEffectByEffectFlags, RunBattleEffectAnimation, DrawHexByteAtBGMap8A_FillBytes, DrawEffectSpriteForEffectTileOffsetRange_CarryUnlessBattleSlotOutSlotEmpty, ...)
; reads: wEffectTargetMode, wBattleFoeCount, wLinkMode, wLinkRole, wBattleArg0, wEffectStep
; writes: wEffectSpriteX
; points at: wEffectStep
SetEffectSpriteXForTargets::
Func_03A_4A3A:: ; address name
    ld a, [wEffectTargetMode]
    cp a, $00
    jr z, .read_battle_foe_count
    cp a, $01
    jr z, .set_effect_sprite_x_to_50
    cp a, $02
    jr z, .read_battle_foe_count2
    ld a, $00
    ld [wEffectSpriteX], a
    ret

.read_battle_foe_count:
    ld a, [wBattleFoeCount]
    ld b, a
    ld a, b
    cp a, $03
    jr z, .skip
    cp a, $02
    jr z, .check_battle_arg0
    ld b, $05
    jr .check_battle_arg02

.skip:
    ld b, $00
    jr .check_battle_arg02

.check_battle_arg0:
    ld b, $03

.check_battle_arg02:
    ld a, [wBattleArg0]
    and a, $03
    add a, b
    ld hl, SetEffectSpriteXForTargets_Data
    add_a_to_hl
    ld a, [hl]
    ld [wEffectSpriteX], a
    ret

.set_effect_sprite_x_to_50:
    ld a, $50
    ld [wEffectSpriteX], a
    ret

.read_battle_foe_count2:
    ld c, $04
    ld a, [wBattleFoeCount]
    ld b, a
    ld a, [wLinkMode]
    cp a, $01
    jr nz, .skip2
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip2
    ld c, $00

.skip2:
    ld e, $00
    ld a, b
    cp a, $03
    jr z, .skip3
    cp a, $02
    jr z, .call_carry_unless_battle_slot_out_slot_empty
    ld d, $05
    jr .check_battle_arg02

.skip3:
    ld d, $00
    jr .loop

.call_carry_unless_battle_slot_out_slot_empty:
    ld d, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, e
    ld hl, wEffectStep
    add_a_to_hl
    push hl
    ld a, c
    and a, $03
    add a, d
    ld hl, SetEffectSpriteXForTargets_Data
    add_a_to_hl
    ld a, [hl]
    pop hl
    ld [hl], a
    inc e

.next:
    inc c
    dec b
    jr nz, .loop
    ld a, [wEffectStep]
    ld [wEffectSpriteX], a
    ret

; address loaded by SetEffectSpriteXForTargets
SetEffectSpriteXForTargets_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_03A_4AD5:: ; address name
    db $20, $50, $80, $38, $68, $50

; runs the battle effect animation state wD800: loads the effect graphics, steps the effect sprite and its X positions, and ends the effect (E-0130)
; 4 call sites from 4 routines (e.g. GameMode4_Update, RunBattleActions, RunBattleStep4, GameMode7_Update)
; reads: wEffectId, wEffectAnimState, wEffectTileOffset, wEffectFlags, wLinkMode, wEffectByteB3, wEffectActive, wEffectTargetMode, ...
; writes: wEffectAnimState, wEffectFlags2, wEffectSpriteX, wEffectByte06, wEffectActive, wEffectFrameCounter, wEffectCounter, wEffectId, ...
; points at: wEffectStep, wEffectByteB3, wEffectFrameCounter
RunBattleEffectAnimation::
Func_03A_4ADB:: ; address name
    ld a, [wEffectId]
    cp a, $00
    jp z, RunBattleEffectAnimation_Data_CallRunEffectRoutineEffectEvery5Frames
    ld a, [wEffectAnimState]
    cp a, $01
    jr nz, .check_effect_anim_state
    ld a, [wEffectTileOffset]
    ld c, a
    call DecompressGraphicsAToTiles0
    ld a, $02
    ld [wEffectAnimState], a
    ld a, [wEffectFlags]
    srl a
    and a, $44
    ld [wEffectFlags2], a
    call SelectEffectByEffectFlags2Flags
    ret

.check_effect_anim_state:
    ld a, [wEffectAnimState]
    cp a, $02
    jp nz, .skip
    ld a, [wLinkMode]
    or a, a
    jr nz, .call_advance_effect_sprite_x_by4_in_mode3
    farcall TickSequencePtrLoSequence

.call_advance_effect_sprite_x_by4_in_mode3:
    call AdvanceEffectSpriteXBy4InMode3
    ld a, [wEffectByteB3]
    or a, a
    jr z, .check_effect_target_mode
    ld a, [wEffectActive]
    or a, a
    jr z, .check_effect_target_mode
    call DrawEffectSpriteForEffectTileOffsetRange
    ret

.check_effect_target_mode:
    ld a, [wEffectTargetMode]
    cp a, $02
    jr nz, .check_effect_flags52
    ld a, [wEffectByte06]
    cp a, $FF
    jr z, .check_effect_counter
    ld a, [wEffectByte06]
    ld [wEffectSpriteX], a
    ld a, $FF
    ld [wEffectByte06], a
    xor a, a
    ld [wEffectActive], a
    ld a, $03
    ld [wEffectAnimState], a
    ld a, $08
    ld [wEffectFrameCounter], a
    ret

.check_effect_counter:
    ld a, [wEffectCounter]
    cp a, $FF
    jr z, .check_effect_flags52
    ld a, [wEffectCounter]
    ld [wEffectSpriteX], a
    ld a, $FF
    ld [wEffectCounter], a
    xor a, a
    ld [wEffectActive], a
    ld a, $03
    ld [wEffectAnimState], a
    ld a, $08
    ld [wEffectFrameCounter], a
    ret

.check_effect_flags52:
    ld a, [wEffectFlags52]
    or a, a
    jr nz, .clear_effect_flags52
    xor a, a
    ld [wEffectAnimState], a
    ld [wEffectActive], a
    ld a, $FF
    ld [wEffectId], a
    ret

.skip:
    ld hl, wEffectFrameCounter
    dec [hl]
    ld a, [hl]
    or a, a
    ret nz
    xor a, a
    ld [wEffectFrameCounter], a
    ld a, $02
    ld [wEffectAnimState], a
    ld a, $01
    ld [wEffectActive], a
    ld a, $00
    ld [wEffectByteB3], a
    farcall TickSequencePtrLoSequence
    ld a, [wEffectFlags]
    srl a
    and a, $44
    ld [wEffectFlags2], a
    call SelectEffectByEffectFlags2Flags
    ret

.clear_effect_flags52:
    xor a, a
    ld [wEffectFlags52], a
    ld a, [wBattleActionId]
    sub a, $D7
    sla a
    ld hl, RunBattleEffectAnimation_Data
    add_a_to_hl
    ld a, [hl+]
    ld [wEffectTileOffset], a
    ld [wEffectByteB5], a
    ld a, [hl]
    ld [wEffectTargetMode], a
    xor a, a
    ld [wEffectSpriteX], a
    ld a, $FF
    ld hl, wEffectStep
    ld bc, $0003
    call FillBytes
    ld a, $01
    ld [wEffectId], a
    ld a, $01
    ld [wEffectAnimState], a
    ld a, $01
    ld [wEffectActive], a
    ld a, $00
    ld [wEffectByteB3], a
    ld hl, wEffectByteB3
    ld a, l
    ld [wSequencePtrLo], a
    ld a, h
    ld [wSequencePtrHi], a
    farcall TickSequencePtrLoSequence
    call SetEffectSpriteXForTargets
    ld a, [wEffectTileOffset]
    ld c, a
    call LoadEffectOBJPaletteC
    ret

; address loaded by RunBattleEffectAnimation
RunBattleEffectAnimation_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_03A_4C12:: ; address name
    db $22, $00

RunBattleEffectAnimation_Data_CallRunEffectRoutineEffectEvery5Frames::
Jump_03A_4C14:: ; address name
    call RunEffectRoutineEffectEvery5Frames
    call UploadBGPalettesWithFade
    ld a, [wEffectId]
    cp a, $FF
    ret nz
    ld a, $7F
    ld [wBGPaletteUploadRequest], a
    ret

; every fifth frame (wDAF1) runs the effect routine for wD803 (jump table of fourteen) (E-0124)
; 1 call site from 1 routine (e.g. RunBattleEffectAnimation)
; reads: wEffectFrameCounter, wEffectRoutine
; writes: wEffectFrameCounter
RunEffectRoutineEffectEvery5Frames::
Func_03A_4C26:: ; address name
    ld a, [wEffectFrameCounter]
    inc a
    cp a, $05
    ld [wEffectFrameCounter], a
    ret c
    xor a, a
    ld [wEffectFrameCounter], a
    ld a, [wEffectRoutine]
    rst $00
    dw RunEffectRoutineEffectEvery5Frames_SetEffectId
    dw RunEffectRoutineEffectEvery5Frames_SetEffectId
    dw RunEffectRoutineEffectEvery5Frames_CarryUnlessBattleSlotOutSlotEmpty
    dw RunEffectRoutineEffectEvery5Frames_ScrollShake
    dw RunEffectRoutineEffectEvery5Frames_FlashAndMoveSprite
    dw RunEffectRoutineEffectEvery5Frames_FlashOnce
    dw RunEffectRoutineEffectEvery5Frames_Delay
    dw RunEffectRoutineEffectEvery5Frames_FlashTwice
    dw RunEffectRoutineEffectEvery5Frames_RunEffectStep
    dw RunEffectRoutineEffectEvery5Frames_ReadEffectCounter
    dw RunEffectRoutineEffectEvery5Frames_FlashPalette
    dw RunEffectRoutineEffectEvery5Frames_FlashAndMoveSprite2
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen
    dw RunEffectRoutineEffectEvery5Frames_CarryUnlessBattleSlotOutSlotEmpty_Case0D

; entry 0 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames
; no direct call (reached through a table, a jump or a vector)
; writes: wEffectId, wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_SetEffectId::
Jump_03A_4C54:: ; address name
    ld a, $FF
    ld [wEffectId], a
    xor a, a
    ld [wEffectSpriteX], a
    ret

; entry 2 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wLinkMode, wLinkRole, wEffectSpriteX
; writes: wEffectId, wEffectSpriteX, wEffectStep
RunEffectRoutineEffectEvery5Frames_CarryUnlessBattleSlotOutSlotEmpty::
Jump_03A_4C5E:: ; address name
    ld a, [wBattleTarget]
    and a, $03
    cp a, $03
    jp z, RunEffectRoutineEffectEvery5Frames_Table2_SetEffectId
    ld a, [wLinkMode]
    cp a, $01
    jr nz, .check_battle_target
    ld a, [wLinkRole]
    bit 1, a
    jr z, .check_battle_target
    ld a, [wBattleTarget]
    cp a, $04
    jr nc, RunEffectRoutineEffectEvery5Frames_Table2_SetEffectId
    jr .read_battle_target

.check_battle_target:
    ld a, [wBattleTarget]
    cp a, $04
    jr c, RunEffectRoutineEffectEvery5Frames_Table2_SetEffectId

.read_battle_target:
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, RunEffectRoutineEffectEvery5Frames_Table2_SetEffectId
    ld a, [wEffectSpriteX]
    rst $00
    dw RunEffectRoutineEffectEvery5Frames_Table2_EffectPositionIndexForTarget
    dw RunEffectRoutineEffectEvery5Frames_Table2_EffectPositionIndexForTarget_Case01
    dw RunEffectRoutineEffectEvery5Frames_Table2_EffectPositionIndexForTarget
    dw RunEffectRoutineEffectEvery5Frames_Table2_EffectPositionIndexForTarget_Case01
    dw RunEffectRoutineEffectEvery5Frames_Table2_SetEffectId

; entry 0 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames
; no direct call (reached through a table, a jump or a vector)
; writes: wEffectStep
; points at: wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_Table2_EffectPositionIndexForTarget::
Jump_03A_4C9C:: ; address name
    ld a, $06
    ld [wEffectStep], a
    call EffectPositionIndexForTarget
    ld hl, RunEffectRoutineEffectEvery5Frames_Table2_EffectPositionIndexForTarget_Data
    call ReadWordTableEntry_Bank3A
    ld de, vBGMap0
    add hl, de
    ld e, l
    ld d, h
    ld a, $03
    ld hl, EffectTileBlockTable
    call ReadWordTableEntry_Bank3A
    ld c, $06
    call CopyVRAMRectToBuffer
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
; writes: wEffectStep
; points at: wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_Table2_EffectPositionIndexForTarget_Case01::
Jump_03A_4CC2:: ; address name
    ld a, $06
    ld [wEffectStep], a
    call EffectPositionIndexForTarget
    ld hl, RunEffectRoutineEffectEvery5Frames_Table2_EffectPositionIndexForTarget_Data
    call ReadWordTableEntry_Bank3A
    ld de, vBGMap0
    add hl, de
    ld e, l
    ld d, h
    ld a, [wBattleTarget]
    and a, $03
    ld hl, EffectTileBlockTable
    call ReadWordTableEntry_Bank3A
    ld c, $06
    call CopyVRAMRectToBuffer
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; entry 4 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames
; no direct call (reached through a table, a jump or a vector)
; writes: wEffectId, wEffectSpriteX, wEffectStep
RunEffectRoutineEffectEvery5Frames_Table2_SetEffectId::
Jump_03A_4CEB:: ; address name
    ld a, $FF
    ld [wEffectId], a
    xor a, a
    ld [wEffectSpriteX], a
    xor a, a
    ld [wEffectStep], a
    ret

; A = a 0-4 position index from wD890 (side count) and the target's slot (E-0124)
; 2 call sites from 2 routines (e.g. RunEffectRoutineEffectEvery5Frames_Table2_EffectPositionIndexForTarget_Case01, RunEffectRoutineEffectEvery5Frames_Table2_EffectPositionIndexForTarget)
; reads: wBattleFoeCount, wBattleTarget
EffectPositionIndexForTarget::
Func_03A_4CF9:: ; address name
    ld a, [wBattleFoeCount]
    cp a, $01
    jr z, .return_00
    cp a, $02
    jr z, .check_battle_target
    ld a, [wBattleTarget]
    and a, $03
    cp a, $01
    jr z, .return_00
    jr c, .skip
    ld a, $04
    jr .return

.skip:
    ld a, $03
    jr .return

.check_battle_target:
    ld a, [wBattleTarget]
    and a, $03
    cp a, $01
    jr z, .skip2
    ld a, $01
    jr .return

.skip2:
    ld a, $02
    jr .return

.return_00:
    ld a, $00

.return:
    ret

; copies rows of wD805 bytes from VRAM at HL (WaitForVRAMAccess, interrupts off per byte) to DE, C rows, the destination rows 32 bytes apart (the source-row step is not read) (E-0113)
; 4 call sites from 4 routines (e.g. RunEffectRoutineEffectEvery5Frames_Table2_EffectPositionIndexForTarget_Case01, RunEffectRoutineEffectEvery5Frames_Table2_EffectPositionIndexForTarget, LightenDMGPaletteOneStep_EffectPositionIndexForActor_Case01, LightenDMGPaletteOneStep_EffectPositionIndexForActor)
; reads: wEffectStep
CopyVRAMRectToBuffer::
Func_03A_4D2B:: ; address name
    push de
    ld a, [wEffectStep]
    ld b, a

.loop:
    di
    call WaitForVRAMAccess
    ld a, [hl+]
    ld [de], a
    ei
    inc de
    dec b
    jr nz, .loop
    pop de
    dec c
    ret z
    ld a, $20
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    jr CopyVRAMRectToBuffer

; HL = table of words, A = index: HL = the word at HL + 2 * A (A is doubled in 8 bits, so it wraps above $7F); A = its low byte (E-0065) (the same 11 bytes appear in 2 banks)
; 8 call sites from 4 routines (e.g. RunEffectRoutineEffectEvery5Frames_Table2_EffectPositionIndexForTarget_Case01, RunEffectRoutineEffectEvery5Frames_Table2_EffectPositionIndexForTarget, LightenDMGPaletteOneStep_EffectPositionIndexForActor_Case01, LightenDMGPaletteOneStep_EffectPositionIndexForActor)
ReadWordTableEntry_Bank3A::
Func_03A_4D47:: ; address name
    add a, a
    add a, l
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
    deref_hl
    ret

; address loaded by RunEffectRoutineEffectEvery5Frames_Table2_EffectPositionIndexForTarget, RunEffectRoutineEffectEvery5Frames_Table2_EffectPositionIndexForTarget_Case01, LightenDMGPaletteOneStep_EffectPositionIndexForActor, LightenDMGPaletteOneStep_EffectPositionIndexForActor_Case01
RunEffectRoutineEffectEvery5Frames_Table2_EffectPositionIndexForTarget_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_03A_4D52:: ; address name
    db $E7, $00, $E4, $00, $EA, $00, $E1, $00, $ED, $00

; E-0234 (C1: two effect routines read the word at $4D5C + 2 * index (index 3, or wBattleTarget & 3) and pass it to CopyVRAMRectToBuffer with C = 6; four words point at the four 36-byte blocks that follow).
; record: 6 x 6 tile block
EffectTileBlockTable::
Data_03A_4D5C:: ; address name
    dw EffectTileBlock0 ; id 0
    dw EffectTileBlock1 ; id 1
    dw EffectTileBlock2 ; id 2
    dw EffectTileBlock3 ; id 3

; E-0234 (C1: block 0 of EffectTileBlockTable, 6 x 6 tile numbers).
; record: row of tile numbers
EffectTileBlock0::
Data_03A_4D64:: ; address name
    db $14, $15, $16, $17, $18, $19 ; id 0
    db $1A, $1B, $1C, $1D, $1E, $1F ; id 1
    db $20, $21, $22, $23, $24, $25 ; id 2
    db $26, $27, $28, $29, $2A, $2B ; id 3
    db $2C, $2D, $2E, $2F, $30, $31 ; id 4
    db $32, $33, $34, $35, $36, $37 ; id 5

; E-0234 (C1: block 1 of EffectTileBlockTable, 6 x 6 tile numbers).
; record: row of tile numbers
EffectTileBlock1::
Data_03A_4D88:: ; address name
    db $38, $39, $3A, $3B, $3C, $3D ; id 0
    db $3E, $3F, $40, $41, $42, $43 ; id 1
    db $44, $45, $46, $47, $48, $49 ; id 2
    db $4A, $4B, $4C, $4D, $4E, $4F ; id 3
    db $50, $51, $52, $53, $54, $55 ; id 4
    db $56, $57, $58, $59, $5A, $5B ; id 5

; E-0234 (C1: block 2 of EffectTileBlockTable, 6 x 6 tile numbers).
; record: row of tile numbers
EffectTileBlock2::
Data_03A_4DAC:: ; address name
    db $5C, $5D, $5E, $5F, $60, $61 ; id 0
    db $62, $63, $64, $65, $66, $67 ; id 1
    db $68, $69, $6A, $6B, $6C, $6D ; id 2
    db $6E, $6F, $70, $71, $72, $73 ; id 3
    db $74, $75, $76, $77, $78, $79 ; id 4
    db $7A, $7B, $7C, $7D, $7E, $7F ; id 5

; E-0234 (C1: block 3 of EffectTileBlockTable, 6 x 6 tile numbers, all $C3).
; record: row of tile numbers
EffectTileBlock3::
Data_03A_4DD0:: ; address name
    db $C3, $C3, $C3, $C3, $C3, $C3 ; id 0
    db $C3, $C3, $C3, $C3, $C3, $C3 ; id 1
    db $C3, $C3, $C3, $C3, $C3, $C3 ; id 2
    db $C3, $C3, $C3, $C3, $C3, $C3 ; id 3
    db $C3, $C3, $C3, $C3, $C3, $C3 ; id 4
    db $C3, $C3, $C3, $C3, $C3, $C3 ; id 5

; steps that write hScrollY/hScrollX, then the next effect id
; no direct call (reached through a table, a jump or a vector)
; reads: wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_ScrollShake::
Jump_03A_4DF4:: ; address name
    ld a, [wEffectSpriteX]
    rst $00
    dw RunEffectRoutineEffectEvery5Frames_ScrollShake_WriteScrollYAndScrollX
    dw RunEffectRoutineEffectEvery5Frames_ScrollShake_WriteScrollYAndScrollX_Case01
    dw RunEffectRoutineEffectEvery5Frames_ScrollShake_WriteScrollYAndScrollX
    dw RunEffectRoutineEffectEvery5Frames_ScrollShake_WriteEffectIdAndScrollYEtc

; entry 0 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_ScrollShake
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollY, hScrollX
; points at: wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_ScrollShake_WriteScrollYAndScrollX::
Jump_03A_4E00:: ; address name
    ld a, $02
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; hScrollY = 0, hScrollX = 1, then wD804 += 1 (E-0116)
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollY, hScrollX
; points at: wEffectSpriteX
SetScroll0_1AndIncEffectSpriteX:: ; heuristic: follows a terminator; C0
Func_03A_4E0D:: ; address name
    ld a, $00
    ldh [hScrollY], a
    ld a, $01
    ldh [hScrollX], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_ScrollShake
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollY, hScrollX
; points at: wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_ScrollShake_WriteScrollYAndScrollX_Case01::
Jump_03A_4E1A:: ; address name
    xor a, a
    ldh [hScrollY], a
    xor a, a
    ldh [hScrollX], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_ScrollShake
; no direct call (reached through a table, a jump or a vector)
; writes: wEffectId, hScrollY, hScrollX, wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_ScrollShake_WriteEffectIdAndScrollYEtc::
Jump_03A_4E25:: ; address name
    ld a, $FF
    ld [wEffectId], a
    xor a, a
    ldh [hScrollY], a
    xor a, a
    ldh [hScrollX], a
    xor a, a
    ld [wEffectSpriteX], a
    ret

; alternates rBGP writes with a palette pattern that moves the effect sprite right
; no direct call (reached through a table, a jump or a vector)
; reads: wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_FlashAndMoveSprite::
Jump_03A_4E35:: ; address name
    ld a, [wEffectSpriteX]
    rst $00
    dw RunEffectRoutineEffectEvery5Frames_FlashAndMoveSprite_SetDMGPaletteBGP
    dw SetDMGPaletteBGPPatternAndIncEffectSpriteX
    dw RunEffectRoutineEffectEvery5Frames_FlashAndMoveSprite_SetDMGPaletteBGP
    dw SetDMGPaletteBGPPatternAndIncEffectSpriteX
    dw RunEffectRoutineEffectEvery5Frames_FlashAndMoveSprite_SetDMGPaletteBGP
    dw SetDMGPaletteBGPPatternAndIncEffectSpriteX
    dw RunEffectRoutineEffectEvery5Frames_FlashAndMoveSprite_Case06

; entry 0 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_FlashAndMoveSprite
; no direct call (reached through a table, a jump or a vector)
; points at: wDMGPaletteBGP, wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_FlashAndMoveSprite_SetDMGPaletteBGP::
Jump_03A_4E47:: ; address name
    ld hl, wDMGPaletteBGP
    ld [hl], $00
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $00
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; wC5E9-wC5EB = $D2, $D2, $E2; wD804 += 1 (E-0074)
; 1 call site from 1 routine (e.g. RunEffectRoutineEffectEvery5Frames_FlashAndMoveSprite_Case06)
; points at: wDMGPaletteBGP, wEffectSpriteX
SetDMGPaletteBGPPatternAndIncEffectSpriteX::
Func_03A_4E57:: ; address name
    ld hl, wDMGPaletteBGP
    ld [hl], $D2
    inc hl
    ld [hl], $D2
    inc hl
    ld [hl], $E2
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_FlashAndMoveSprite
; no direct call (reached through a table, a jump or a vector)
; writes: wEffectId, wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_FlashAndMoveSprite_Case06::
Jump_03A_4E67:: ; address name
    call SetDMGPaletteBGPPatternAndIncEffectSpriteX
    ld a, $FF
    ld [wEffectId], a
    xor a, a
    ld [wEffectSpriteX], a
    ret

; sets the effect counter, writes rBGP once, then the next effect id
; no direct call (reached through a table, a jump or a vector)
; reads: wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_FlashOnce::
Jump_03A_4E74:: ; address name
    ld a, [wEffectSpriteX]
    rst $00
    dw RunEffectRoutineEffectEvery5Frames_FlashOnce_WriteEffectByte06AndEffectCounter
    dw RunEffectRoutineEffectEvery5Frames_FlashOnce_WriteEffectStep
    dw RunEffectRoutineEffectEvery5Frames_FlashOnce_SetDMGPaletteBGP
    dw RunEffectRoutineEffectEvery5Frames_FlashOnce_SetEffectId

; entry 0 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_FlashOnce
; no direct call (reached through a table, a jump or a vector)
; reads: wEffectCounter
; writes: wEffectByte06, wEffectCounter
; points at: wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_FlashOnce_WriteEffectByte06AndEffectCounter::
Jump_03A_4E80:: ; address name
    call RunEffectRoutineEffectEvery5Frames_Shared01
    ld a, [wEffectCounter]
    cp a, $04
    ret c
    xor a, a
    ld [wEffectByte06], a
    xor a, a
    ld [wEffectCounter], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_FlashOnce
; no direct call (reached through a table, a jump or a vector)
; reads: wEffectStep
; writes: wEffectStep
; points at: wEffectStep, wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_FlashOnce_WriteEffectStep::
Jump_03A_4E96:: ; address name
    ld hl, wEffectStep
    inc [hl]
    ld a, [wEffectStep]
    cp a, $0A
    ret nz
    ld hl, wEffectSpriteX
    inc [hl]
    xor a, a
    ld [wEffectStep], a
    ret

; entry 2 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_FlashOnce
; no direct call (reached through a table, a jump or a vector)
; points at: wDMGPaletteBGP, wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_FlashOnce_SetDMGPaletteBGP::
Jump_03A_4EA9:: ; address name
    ld hl, wDMGPaletteBGP
    ld [hl], $D2
    inc hl
    ld [hl], $D2
    inc hl
    ld [hl], $E2
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_FlashOnce
; no direct call (reached through a table, a jump or a vector)
; writes: wEffectId, wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_FlashOnce_SetEffectId::
Jump_03A_4EB9:: ; address name
    ld a, $FF
    ld [wEffectId], a
    xor a, a
    ld [wEffectSpriteX], a
    ret

; only called from routines of RunEffectRoutineEffectEvery5Frames (E-0098)
; 2 call sites from 2 routines (e.g. RunEffectRoutineEffectEvery5Frames_FlashOnce_WriteEffectByte06AndEffectCounter, RunEffectRoutineEffectEvery5Frames_FlashTwice_WriteEffectByte06AndEffectCounter)
; points at: wEffectCounter, wDMGPaletteBGP
RunEffectRoutineEffectEvery5Frames_Shared01::
Func_03A_4EC3:: ; address name
    ld hl, wEffectCounter
    inc [hl]
    ld b, $03
    ld c, $00
    ld hl, wDMGPaletteBGP

.loop:
    ld a, [hl]
    and a, $03
    add a, $01
    cp a, $04
    jr c, .skip
    ld a, $03

.skip:
    or a, c
    ld c, a
    ld a, [hl]
    and a, $0C
    add a, $04
    cp a, $0D
    jr c, .skip2
    ld a, $0C

.skip2:
    or a, c
    ld c, a
    ld a, [hl]
    and a, $30
    add a, $10
    cp a, $31
    jr c, .skip3
    ld a, $30

.skip3:
    or a, c
    ld c, a
    ld a, [hl]
    and a, $C0
    add a, $40
    cp a, $C1
    jr c, .skip4
    ld a, $C0

.skip4:
    or a, c
    ld [hl+], a
    dec b
    jr nz, .loop
    ret

; twelve identical waiting steps, then the next effect id
; no direct call (reached through a table, a jump or a vector)
; reads: wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_Delay::
Jump_03A_4F06:: ; address name
    ld a, [wEffectSpriteX]
    rst $00
    dw RunEffectRoutineEffectEvery5Frames_Delay_Case00
    dw RunEffectRoutineEffectEvery5Frames_Delay_Case00
    dw RunEffectRoutineEffectEvery5Frames_Delay_Case00
    dw RunEffectRoutineEffectEvery5Frames_Delay_Case00
    dw RunEffectRoutineEffectEvery5Frames_Delay_Case00
    dw RunEffectRoutineEffectEvery5Frames_Delay_Case00
    dw RunEffectRoutineEffectEvery5Frames_Delay_Case00
    dw RunEffectRoutineEffectEvery5Frames_Delay_Case00
    dw RunEffectRoutineEffectEvery5Frames_Delay_Case00
    dw RunEffectRoutineEffectEvery5Frames_Delay_Case00
    dw RunEffectRoutineEffectEvery5Frames_Delay_Case00
    dw RunEffectRoutineEffectEvery5Frames_Delay_Case00
    dw RunEffectRoutineEffectEvery5Frames_Delay_SetEffectId

; entry 0 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_Delay
; no direct call (reached through a table, a jump or a vector)
; points at: wDMGPaletteBGP, wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_Delay_Case00::
Jump_03A_4F24:: ; address name
    ld hl, wDMGPaletteBGP
    ld a, [hl]
    xor a, $FF
    ld [hl+], a
    ld a, [hl]
    xor a, $FF
    ld [hl+], a
    ld a, [hl]
    xor a, $FF
    ld [hl], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; entry 12 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_Delay
; no direct call (reached through a table, a jump or a vector)
; writes: wEffectId, wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_Delay_SetEffectId::
Jump_03A_4F38:: ; address name
    ld a, $FF
    ld [wEffectId], a
    xor a, a
    ld [wEffectSpriteX], a
    ret

; the FlashOnce steps twice, then the next effect id
; no direct call (reached through a table, a jump or a vector)
; reads: wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_FlashTwice::
Jump_03A_4F42:: ; address name
    ld a, [wEffectSpriteX]
    rst $00
    dw RunEffectRoutineEffectEvery5Frames_FlashTwice_WriteEffectByte06AndEffectCounter
    dw RunEffectRoutineEffectEvery5Frames_FlashTwice_WriteEffectStep
    dw RunEffectRoutineEffectEvery5Frames_FlashTwice_SetDMGPaletteBGP
    dw RunEffectRoutineEffectEvery5Frames_FlashTwice_WriteEffectByte06AndEffectCounter
    dw RunEffectRoutineEffectEvery5Frames_FlashTwice_WriteEffectStep
    dw RunEffectRoutineEffectEvery5Frames_FlashTwice_SetDMGPaletteBGP
    dw RunEffectRoutineEffectEvery5Frames_FlashTwice_SetEffectId

; entry 0 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_FlashTwice
; no direct call (reached through a table, a jump or a vector)
; reads: wEffectCounter
; writes: wEffectByte06, wEffectCounter
; points at: wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_FlashTwice_WriteEffectByte06AndEffectCounter::
Jump_03A_4F54:: ; address name
    call RunEffectRoutineEffectEvery5Frames_Shared01
    ld a, [wEffectCounter]
    cp a, $04
    ret c
    xor a, a
    ld [wEffectByte06], a
    xor a, a
    ld [wEffectCounter], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_FlashTwice
; no direct call (reached through a table, a jump or a vector)
; reads: wEffectStep
; writes: wEffectStep
; points at: wEffectStep, wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_FlashTwice_WriteEffectStep::
Jump_03A_4F6A:: ; address name
    ld hl, wEffectStep
    inc [hl]
    ld a, [wEffectStep]
    cp a, $05
    ret nz
    ld hl, wEffectSpriteX
    inc [hl]
    xor a, a
    ld [wEffectStep], a
    ret

; entry 2 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_FlashTwice
; no direct call (reached through a table, a jump or a vector)
; points at: wDMGPaletteBGP, wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_FlashTwice_SetDMGPaletteBGP::
Jump_03A_4F7D:: ; address name
    ld hl, wDMGPaletteBGP
    ld [hl], $D2
    inc hl
    ld [hl], $D2
    inc hl
    ld [hl], $E2
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_FlashTwice
; no direct call (reached through a table, a jump or a vector)
; writes: wEffectId, wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_FlashTwice_SetEffectId::
Jump_03A_4F8D:: ; address name
    ld a, $FF
    ld [wEffectId], a
    xor a, a
    ld [wEffectSpriteX], a
    ret

; entry 8 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames
; no direct call (reached through a table, a jump or a vector)
; reads: wEffectSpriteX
; writes: wEffectId, wEffectSpriteX, wEffectStep
RunEffectRoutineEffectEvery5Frames_RunEffectStep::
Jump_03A_4F97:: ; address name
    ld a, [wEffectSpriteX]
    or a, a
    call z, RunEffectRoutineEffectEvery5Frames_Case08_WaitEffectSpriteX
    call RunEffectStep
    ld a, [wEffectSpriteX]
    or a, a
    ret z
    ld a, $FF
    ld [wEffectId], a
    xor a, a
    ld [wEffectSpriteX], a
    xor a, a
    ld [wEffectStep], a
    ret

; only called from RunEffectRoutineEffectEvery5Frames_Case08 (E-0047)
; 1 call site from 1 routine (e.g. RunEffectRoutineEffectEvery5Frames_RunEffectStep)
; reads: wEffectSpriteX, wEffectStep
RunEffectRoutineEffectEvery5Frames_Case08_WaitEffectSpriteX::
Func_03A_4FB4:: ; address name
    ld a, [wEffectSpriteX]
    or a, a
    ret nz
    ld a, [wEffectStep]
    rst $00
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX_Case01
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX_Case02
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX_Case01
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX_Case01
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX_Case02
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX_Case01
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX_Case01
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX_Case02
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX_Case01
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX_Case02
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX_Case01
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX_Case01
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX_Case02
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX_Case01
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX_Case01
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX_Case02
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX_Case01
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX_Case01
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX_Case02
    dw RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteEffectSpriteXAndScrollYEtc

; entry 0 of the `rst $00` table in Func_03A_4FB4
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollY, hScrollX
; points at: wEffectStep
RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX::
Jump_03A_4FF3:: ; address name
    ld a, $04
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    ld hl, wEffectStep
    inc [hl]
    ret

; entry 2 of the `rst $00` table in Func_03A_4FB4
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollY, hScrollX
; points at: wEffectStep
RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX_Case02::
Jump_03A_5000:: ; address name
    ld a, $00
    ldh [hScrollY], a
    ld a, $03
    ldh [hScrollX], a
    ld hl, wEffectStep
    inc [hl]
    ret

; entry 1 of the `rst $00` table in Func_03A_4FB4
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollY, hScrollX
; points at: wEffectStep
RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteScrollYAndScrollX_Case01::
Jump_03A_500D:: ; address name
    xor a, a
    ldh [hScrollY], a
    xor a, a
    ldh [hScrollX], a
    ld hl, wEffectStep
    inc [hl]
    ret

; entry 26 of the `rst $00` table in Func_03A_4FB4
; no direct call (reached through a table, a jump or a vector)
; writes: wEffectSpriteX, hScrollY, hScrollX, wEffectStep
RunEffectRoutineEffectEvery5Frames_Case08_Sub01_WriteEffectSpriteXAndScrollYEtc::
Jump_03A_5018:: ; address name
    ld a, $01
    ld [wEffectSpriteX], a
    xor a, a
    ldh [hScrollY], a
    xor a, a
    ldh [hScrollX], a
    xor a, a
    ld [wEffectStep], a
    ret

; runs the routine for wD805 (jump table) (E-0124)
; 1 call site from 1 routine (e.g. RunEffectRoutineEffectEvery5Frames_RunEffectStep)
; reads: wEffectStep
RunEffectStep::
Func_03A_5028:: ; address name
    ld a, [wEffectStep]
    rst $00
    dw RunEffectStep_SetDMGPaletteBGP
    dw RunEffectStep_SetDMGPaletteBGP
    dw RunEffectStep_SetDMGPaletteBGP
    dw RunEffectStep_SetDMGPaletteBGP
    dw RunEffectStep_SetDMGPaletteBGP
    dw RunEffectStep_SetDMGPaletteBGP
    dw RunEffectStep_SetDMGPaletteBGP
    dw RunEffectStep_SetDMGPaletteBGP
    dw RunEffectStep_SetDMGPaletteBGP
    dw RunEffectStep_SetDMGPaletteBGP_Case09
    dw RunEffectStep_SetDMGPaletteBGP
    dw RunEffectStep_SetDMGPaletteBGP_Case09
    dw RunEffectStep_SetDMGPaletteBGP
    dw RunEffectStep_SetDMGPaletteBGP_Case09
    dw RunEffectStep_SetDMGPaletteBGP
    dw RunEffectStep_SetDMGPaletteBGP_Case09
    dw RunEffectStep_SetDMGPaletteBGP
    dw RunEffectStep_SetDMGPaletteBGP_Case09
    dw RunEffectStep_SetDMGPaletteBGP
    dw RunEffectStep_SetDMGPaletteBGP_Case09
    dw RunEffectStep_SetDMGPaletteBGP
    dw RunEffectStep_SetDMGPaletteBGP_Case09
    dw RunEffectStep_SetDMGPaletteBGP
    dw RunEffectStep_SetDMGPaletteBGP_Case09
    dw RunEffectStep_SetDMGPaletteBGP
    dw RunEffectStep_SetDMGPaletteBGP_Case09
    dw RunEffectStep_SetDMGPaletteBGP

; entry 9 of the `rst $00` table in RunEffectStep
; no direct call (reached through a table, a jump or a vector)
; points at: wDMGPaletteBGP
RunEffectStep_SetDMGPaletteBGP_Case09::
Jump_03A_5062:: ; address name
    ld hl, wDMGPaletteBGP
    ld [hl], $00
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $00
    ret

; entry 0 of the `rst $00` table in RunEffectStep
; no direct call (reached through a table, a jump or a vector)
; points at: wDMGPaletteBGP
RunEffectStep_SetDMGPaletteBGP::
Jump_03A_506E:: ; address name
    ld hl, wDMGPaletteBGP
    ld [hl], $D2
    inc hl
    ld [hl], $D2
    inc hl
    ld [hl], $E2
    ret

; entry 9 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames
; no direct call (reached through a table, a jump or a vector)
; reads: wEffectCounter
; points at: wEffectCounter
RunEffectRoutineEffectEvery5Frames_ReadEffectCounter::
Jump_03A_507A:: ; address name
    ld a, [wEffectCounter]
    or a, a
    jr nz, .done
    ld hl, wEffectCounter
    inc [hl]
    ret

.done:
    ld hl, wEffectCounter
    inc [hl]
    ret

; by wEffectStep: sets the effect counter, writes the DMG palette rBGP and picks the effect position
; no direct call (reached through a table, a jump or a vector)
; reads: wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_FlashPalette::
Jump_03A_508A:: ; address name
    ld a, [wEffectSpriteX]
    rst $00
    dw RunEffectRoutineEffectEvery5Frames_FlashPalette_LightenDMGPaletteOneStep
    dw RunEffectRoutineEffectEvery5Frames_FlashPalette_WriteEffectStep
    dw RunEffectRoutineEffectEvery5Frames_FlashPalette_SetDMGPaletteBGP
    dw RunEffectRoutineEffectEvery5Frames_FlashPalette_SetEffectId

; entry 0 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_FlashPalette
; no direct call (reached through a table, a jump or a vector)
; reads: wEffectCounter
; writes: wEffectByte06, wEffectCounter
; points at: wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_FlashPalette_LightenDMGPaletteOneStep::
Jump_03A_5096:: ; address name
    call LightenDMGPaletteOneStep
    ld a, [wEffectCounter]
    cp a, $04
    ret c
    xor a, a
    ld [wEffectByte06], a
    xor a, a
    ld [wEffectCounter], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; entry 1 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_FlashPalette
; no direct call (reached through a table, a jump or a vector)
; reads: wEffectStep
; writes: wEffectStep
; points at: wEffectStep, wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_FlashPalette_WriteEffectStep::
Jump_03A_50AC:: ; address name
    ld hl, wEffectStep
    inc [hl]
    ld a, [wEffectStep]
    cp a, $0A
    ret nz
    ld hl, wEffectSpriteX
    inc [hl]
    xor a, a
    ld [wEffectStep], a
    ret

; entry 2 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_FlashPalette
; no direct call (reached through a table, a jump or a vector)
; points at: wDMGPaletteBGP, wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_FlashPalette_SetDMGPaletteBGP::
Jump_03A_50BF:: ; address name
    ld hl, wDMGPaletteBGP
    ld [hl], $D2
    inc hl
    ld [hl], $D2
    inc hl
    ld [hl], $E2
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; entry 3 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_FlashPalette
; no direct call (reached through a table, a jump or a vector)
; writes: wEffectId, wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_FlashPalette_SetEffectId::
Jump_03A_50CF:: ; address name
    ld a, $FF
    ld [wEffectId], a
    xor a, a
    ld [wEffectSpriteX], a
    ret

; increments wEffectCounter and lowers each 2-bit shade of wDMGPaletteBGP by one (not below 0): one step of a fade toward white
; 1 call site from 1 routine (e.g. RunEffectRoutineEffectEvery5Frames_FlashPalette_LightenDMGPaletteOneStep)
; points at: wEffectCounter, wDMGPaletteBGP
LightenDMGPaletteOneStep::
Func_03A_50D9:: ; address name
    ld hl, wEffectCounter
    inc [hl]
    ld b, $03
    ld c, $00
    ld hl, wDMGPaletteBGP

.loop:
    ld a, [hl]
    and a, $03
    cp a, $00
    jr z, .skip
    sub a, $01

.skip:
    or a, c
    ld c, a
    ld a, [hl]
    and a, $0C
    cp a, $00
    jr z, .skip2
    sub a, $04

.skip2:
    or a, c
    ld c, a
    ld a, [hl]
    and a, $30
    cp a, $00
    jr z, .skip3
    sub a, $10

.skip3:
    or a, c
    ld c, a
    ld a, [hl]
    and a, $C0
    cp a, $00
    jr z, .skip4
    sub a, $40

.skip4:
    or a, c
    ld [hl+], a
    dec b
    jr nz, .loop
    ret

; as RunEffectRoutineEffectEvery5Frames_FlashAndMoveSprite
; no direct call (reached through a table, a jump or a vector)
; reads: wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_FlashAndMoveSprite2::
Jump_03A_5114:: ; address name
    ld a, [wEffectSpriteX]
    rst $00
    dw RunEffectRoutineEffectEvery5Frames_FlashAndMoveSprite_SetDMGPaletteBGP
    dw SetDMGPaletteBGPPatternAndIncEffectSpriteX
    dw RunEffectRoutineEffectEvery5Frames_FlashAndMoveSprite_SetDMGPaletteBGP
    dw SetDMGPaletteBGPPatternAndIncEffectSpriteX
    dw RunEffectRoutineEffectEvery5Frames_FlashAndMoveSprite_SetDMGPaletteBGP
    dw SetDMGPaletteBGPPatternAndIncEffectSpriteX
    dw RunEffectRoutineEffectEvery5Frames_FlashAndMoveSprite_SetDMGPaletteBGP
    dw SetDMGPaletteBGPPatternAndIncEffectSpriteX
    dw RunEffectRoutineEffectEvery5Frames_FlashAndMoveSprite_SetDMGPaletteBGP
    dw SetDMGPaletteBGPPatternAndIncEffectSpriteX
    dw RunEffectRoutineEffectEvery5Frames_FlashAndMoveSprite_SetDMGPaletteBGP
    dw SetDMGPaletteBGPPatternAndIncEffectSpriteX
    dw RunEffectRoutineEffectEvery5Frames_FlashAndMoveSprite_SetDMGPaletteBGP
    dw SetDMGPaletteBGPPatternAndIncEffectSpriteX
    dw RunEffectRoutineEffectEvery5Frames_FlashAndMoveSprite_SetDMGPaletteBGP
    dw SetDMGPaletteBGPPatternAndIncEffectSpriteX
    dw RunEffectRoutineEffectEvery5Frames_FlashAndMoveSprite_Case06

; a sequence of steps that only write hScrollX/hScrollY: a screen shake
; no direct call (reached through a table, a jump or a vector)
; reads: wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_ShakeScreen::
Jump_03A_513A:: ; address name
    ld a, [wEffectSpriteX]
    rst $00
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollX
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollXAndScrollY
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollX_Case02
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollXAndScrollY
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollX_Case04
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollXAndScrollY
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollX_Case06
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollXAndScrollY
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollX_Case08
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollXAndScrollY
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollX_Case0A
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollXAndScrollY
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollXAndScrollY_Case0C
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollXAndScrollY
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollXAndScrollY_Case0E
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollXAndScrollY
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollXAndScrollY_Case0C
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollXAndScrollY
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollXAndScrollY_Case0E
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollXAndScrollY
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollXAndScrollY_Case0C
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollXAndScrollY
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollXAndScrollY_Case0E
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollXAndScrollY
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollXAndScrollY_Case0C
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollXAndScrollY
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollXAndScrollY_Case0E
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollXAndScrollYEtc

; entry 1 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_ShakeScreen
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollX, hScrollY
; points at: wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollXAndScrollY::
Jump_03A_5176:: ; address name
    xor a, a
    ldh [hScrollX], a
    ldh [hScrollY], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; entry 0 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_ShakeScreen
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollX
; points at: wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollX::
Jump_03A_5180:: ; address name
    ld a, $FE
    ldh [hScrollX], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; entry 2 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_ShakeScreen
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollX
; points at: wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollX_Case02::
Jump_03A_5189:: ; address name
    ld a, $02
    ldh [hScrollX], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; entry 4 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_ShakeScreen
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollX
; points at: wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollX_Case04::
Jump_03A_5192:: ; address name
    ld a, $FC
    ldh [hScrollX], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; entry 6 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_ShakeScreen
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollX
; points at: wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollX_Case06::
Jump_03A_519B:: ; address name
    ld a, $04
    ldh [hScrollX], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; entry 8 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_ShakeScreen
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollX
; points at: wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollX_Case08::
Jump_03A_51A4:: ; address name
    ld a, $F8
    ldh [hScrollX], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; entry 10 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_ShakeScreen
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollX
; points at: wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollX_Case0A::
Jump_03A_51AD:: ; address name
    ld a, $08
    ldh [hScrollX], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; entry 12 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_ShakeScreen
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollX, hScrollY
; points at: wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollXAndScrollY_Case0C::
Jump_03A_51B6:: ; address name
    ld a, $F8
    ldh [hScrollX], a
    ld a, $02
    ldh [hScrollY], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; entry 14 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_ShakeScreen
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollX, hScrollY
; points at: wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollXAndScrollY_Case0E::
Jump_03A_51C3:: ; address name
    ld a, $08
    ldh [hScrollX], a
    ld a, $02
    ldh [hScrollY], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; entry 27 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames_ShakeScreen
; no direct call (reached through a table, a jump or a vector)
; writes: hScrollX, hScrollY, wEffectId, wEffectSpriteX
RunEffectRoutineEffectEvery5Frames_ShakeScreen_WriteScrollXAndScrollYEtc::
Jump_03A_51D0:: ; address name
    xor a, a
    ldh [hScrollX], a
    ldh [hScrollY], a
    ld a, $FF
    ld [wEffectId], a
    xor a, a
    ld [wEffectSpriteX], a
    ret

; entry 13 of the `rst $00` table in RunEffectRoutineEffectEvery5Frames
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkRole, wLinkMode, wBattleActor, wEffectSpriteX
; writes: wEffectId, wEffectSpriteX, wEffectStep
RunEffectRoutineEffectEvery5Frames_CarryUnlessBattleSlotOutSlotEmpty_Case0D::
Jump_03A_51DF:: ; address name
    ld a, [wLinkRole]
    ld b, a
    ld a, [wLinkMode]
    ld c, a
    ld a, [wBattleActor]
    cp a, $07
    jr nc, LightenDMGPaletteOneStep_SetEffectId
    cp a, $03
    jr z, LightenDMGPaletteOneStep_SetEffectId
    dec c
    jr nz, .cp_04
    cp a, $04
    jr nc, LightenDMGPaletteOneStep_SetEffectId
    jr .read_battle_actor

.cp_04:
    cp a, $04
    jr c, LightenDMGPaletteOneStep_SetEffectId

.read_battle_actor:
    ld a, [wBattleActor]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, LightenDMGPaletteOneStep_SetEffectId
    ld a, [wEffectSpriteX]
    rst $00
    dw LightenDMGPaletteOneStep_EffectPositionIndexForActor
    dw LightenDMGPaletteOneStep_EffectPositionIndexForActor_Case01
    dw LightenDMGPaletteOneStep_EffectPositionIndexForActor
    dw LightenDMGPaletteOneStep_EffectPositionIndexForActor_Case01
    dw LightenDMGPaletteOneStep_SetEffectId

; entry 0 of the `rst $00` table in LightenDMGPaletteOneStep
; no direct call (reached through a table, a jump or a vector)
; writes: wEffectStep
; points at: wEffectSpriteX
LightenDMGPaletteOneStep_EffectPositionIndexForActor::
Jump_03A_5215:: ; address name
    ld a, $06
    ld [wEffectStep], a
    call EffectPositionIndexForActor
    ld hl, RunEffectRoutineEffectEvery5Frames_Table2_EffectPositionIndexForTarget_Data
    call ReadWordTableEntry_Bank3A
    ld de, vBGMap0
    add hl, de
    ld e, l
    ld d, h
    ld a, $03
    ld hl, EffectTileBlockTable
    call ReadWordTableEntry_Bank3A
    ld c, $06
    call CopyVRAMRectToBuffer
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; entry 1 of the `rst $00` table in LightenDMGPaletteOneStep
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wEffectStep
; points at: wEffectSpriteX
LightenDMGPaletteOneStep_EffectPositionIndexForActor_Case01::
Jump_03A_523B:: ; address name
    ld a, $06
    ld [wEffectStep], a
    call EffectPositionIndexForActor
    ld hl, RunEffectRoutineEffectEvery5Frames_Table2_EffectPositionIndexForTarget_Data
    call ReadWordTableEntry_Bank3A
    ld de, vBGMap0
    add hl, de
    ld e, l
    ld d, h
    ld a, [wBattleActor]
    and a, $03
    ld hl, EffectTileBlockTable
    call ReadWordTableEntry_Bank3A
    ld c, $06
    call CopyVRAMRectToBuffer
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; entry 4 of the `rst $00` table in LightenDMGPaletteOneStep
; no direct call (reached through a table, a jump or a vector)
; writes: wEffectId, wEffectSpriteX, wEffectStep
LightenDMGPaletteOneStep_SetEffectId::
Jump_03A_5264:: ; address name
    ld a, $FF
    ld [wEffectId], a
    xor a, a
    ld [wEffectSpriteX], a
    xor a, a
    ld [wEffectStep], a
    ret

; A = a 0-4 position index from wD890 (side count) and the actor's slot (E-0124)
; 2 call sites from 2 routines (e.g. LightenDMGPaletteOneStep_EffectPositionIndexForActor_Case01, LightenDMGPaletteOneStep_EffectPositionIndexForActor)
; reads: wBattleFoeCount, wBattleActor
EffectPositionIndexForActor::
Func_03A_5272:: ; address name
    ld a, [wBattleFoeCount]
    cp a, $01
    jr z, .return_00
    cp a, $02
    jr z, .check_battle_actor
    ld a, [wBattleActor]
    and a, $03
    cp a, $01
    jr z, .return_00
    jr c, .skip
    ld a, $04
    jr .return

.skip:
    ld a, $03
    jr .return

.check_battle_actor:
    ld a, [wBattleActor]
    and a, $03
    cp a, $01
    jr z, .skip2
    ld a, $01
    jr .return

.skip2:
    ld a, $02
    jr .return

.return_00:
    ld a, $00

.return:
    ret

; A = entry: decompresses the stream named by the 3-byte far pointer at Data_03A_52B9 + 3 * A to vTiles0 (DecompressToVRAM) (E-0118)
; 2 call sites from 2 routines (e.g. RunBattleEffectAnimation, RunDebugState_E0_Case0A_DecompressGraphicsAToTiles0)
DecompressGraphicsAToTiles0::
Func_03A_52A4:: ; address name
    ld c, a
    ld b, $00
    ld hl, BattleEffectGraphicsTable
    add hl, bc
    add hl, bc
    add hl, bc
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a
    ld b, [hl]
    ld hl, vTiles0
    call DecompressToVRAM
    ret

; E-0145 (C1: DecompressGraphicsAToTiles0 decompresses the far pointer at $52B9 + 3 * A to vTiles0; RunBattleEffectAnimation and the debug effect viewer call it; all 60 entries decode).
; record: compressed effect graphics (vTiles0); its ROM bank
BattleEffectGraphicsTable::
Data_03A_52B9:: ; address name
    dfar BattleEffectGfx00 ; id 0
    dfar BattleEffectGfx01 ; id 1
    dfar BattleEffectGfx02 ; id 2
    dfar BattleEffectGfx03 ; id 3
    dfar BattleEffectGfx04 ; id 4
    dfar BattleEffectGfx05 ; id 5
    dfar BattleEffectGfx06 ; id 6
    dfar BattleEffectGfx07 ; id 7
    dfar BattleEffectGfx08 ; id 8
    dfar BattleEffectGfx09 ; id 9
    dfar BattleEffectGfx0A ; id 10
    dfar BattleEffectGfx0B ; id 11
    dfar BattleEffectGfx0C ; id 12
    dfar BattleEffectGfx0D ; id 13
    dfar BattleEffectGfx0E ; id 14
    dfar BattleEffectGfx0F ; id 15
    dfar BattleEffectGfx10 ; id 16
    dfar BattleEffectGfx11 ; id 17
    dfar BattleEffectGfx12 ; id 18
    dfar BattleEffectGfx13 ; id 19
    dfar BattleEffectGfx14 ; id 20
    dfar BattleEffectGfx15 ; id 21
    dfar BattleEffectGfx16 ; id 22
    dfar BattleEffectGfx17 ; id 23
    dfar BattleEffectGfx18 ; id 24
    dfar BattleEffectGfx19 ; id 25
    dfar BattleEffectGfx1A ; id 26
    dfar BattleEffectGfx1B ; id 27
    dfar BattleEffectGfx1C ; id 28
    dfar BattleEffectGfx1D ; id 29
    dfar BattleEffectGfx1E ; id 30
    dfar BattleEffectGfx1F ; id 31
    dfar BattleEffectGfx20 ; id 32
    dfar BattleEffectGfx21 ; id 33
    dfar BattleEffectGfx22 ; id 34
    dfar BattleEffectGfx23 ; id 35
    dfar BattleEffectGfx24 ; id 36
    dfar BattleEffectGfx25 ; id 37
    dfar BattleEffectGfx26 ; id 38
    dfar BattleEffectGfx27 ; id 39
    dfar BattleEffectGfx28 ; id 40
    dfar BattleEffectGfx29 ; id 41
    dfar BattleEffectGfx2A ; id 42
    dfar BattleEffectGfx2B ; id 43
    dfar BattleEffectGfx2C ; id 44
    dfar BattleEffectGfx2D ; id 45
    dfar BattleEffectGfx2E ; id 46
    dfar BattleEffectGfx2F ; id 47
    dfar BattleEffectGfx30 ; id 48
    dfar BattleEffectGfx31 ; id 49
    dfar BattleEffectGfx32 ; id 50
    dfar BattleEffectGfx33 ; id 51
    dfar BattleEffectGfx34 ; id 52
    dfar BattleEffectGfx35 ; id 53
    dfar BattleEffectGfx36 ; id 54
    dfar BattleEffectGfx37 ; id 55
    dfar BattleEffectGfx38 ; id 56
    dfar BattleEffectGfx39 ; id 57
    dfar BattleEffectGfx3A ; id 58
    dfar BattleEffectGfx3B ; id 59

; when wDAB9 is 3: wD804 += 4, and once it reaches $D0 wDAAA = 0 (E-0119)
; 2 call sites from 2 routines (e.g. RunBattleEffectAnimation, RunDebugState_E0_Case0A_DecompressGraphicsAToTiles0)
; reads: wEffectTargetMode, wEffectSpriteX
; writes: wEffectSpriteX, wEffectActive
AdvanceEffectSpriteXBy4InMode3::
Func_03A_536D:: ; address name
    ld a, [wEffectTargetMode]
    cp a, $03
    ret nz
    ld a, [wEffectSpriteX]
    add a, $04
    ld [wEffectSpriteX], a
    cp a, $D0
    ret c
    xor a, a
    ld [wEffectActive], a
    ret

; draws the effect sprite from bank $3E, $3F, $3D, $3B or $92 by wD801 (< $0E, $20, $2D, $33, or more) (E-0124)
; 2 call sites from 2 routines (e.g. RunBattleEffectAnimation, RunDebugState_E0_Case0A_DecompressGraphicsAToTiles0)
; reads: wEffectTileOffset
DrawEffectSpriteForEffectTileOffsetRange::
Func_03A_5383:: ; address name
    ld a, [wEffectTileOffset]
    cp a, $0E
    jr c, .call_draw_effect_sprite_at_effect_sprite_x
    cp a, $20
    jr c, .call_draw_effect_sprite_for_effect_tile
    cp a, $2D
    jr c, .call_draw_effect_sprite_for_effect_tile2
    cp a, $33
    jr c, .call_draw_effect_sprite_at_effect_sprite_x2
    farcall DrawEffectSpriteAtEffectSpriteX_Bank92
    ret

.call_draw_effect_sprite_at_effect_sprite_x:
    farcall DrawEffectSpriteAtEffectSpriteX_Bank3E
    ret

.call_draw_effect_sprite_for_effect_tile:
    farcall DrawEffectSpriteForEffectTileOffsetRange_CarryUnlessBattleSlotOutSlotEmpty_Sub02
    ret

.call_draw_effect_sprite_for_effect_tile2:
    farcall DrawEffectSpriteForEffectTileOffsetRange_CarryUnlessBattleSlotOutSlotEmpty
    ret

.call_draw_effect_sprite_at_effect_sprite_x2:
    farcall DrawEffectSpriteAtEffectSpriteX_Bank3B
    ret

; only called from DrawSkillByte0AndRun502BAnd53B9 (E-0047)
; 1 call site from 1 routine (e.g. DrawSkillByte0AndRun502BAnd53B9)
; reads: wDebugValue0, wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
; writes: wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
DrawSkillByte0AndRun502BAnd53B9_WriteBattleArg0AndBattleArg1Etc::
Func_03A_53B9:: ; address name
    ld hl, vBGMap0 + $1CE
    ld a, l
    ld [wBattleArg0], a
    ld a, h
    ld [wBattleArg1], a
    ld hl, vBGMap0 + $1D2
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    ld hl, ActionEffectTable_Flag7
    call DrawSkillByte0AndRun502BAnd53B9_Sub01_WriteVRAMByte
    ld hl, vBGMap0 + $1EE
    ld a, l
    ld [wBattleArg0], a
    ld a, h
    ld [wBattleArg1], a
    ld hl, vBGMap0 + $1F2
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    ld hl, ActionEffectTable_Flag6
    call DrawSkillByte0AndRun502BAnd53B9_Sub01_WriteVRAMByte
    ld hl, vBGMap0 + $20E
    ld a, l
    ld [wBattleArg0], a
    ld a, h
    ld [wBattleArg1], a
    ld hl, vBGMap0 + $212
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    ld hl, ActionEffectTable_Flag5

; only called from DrawSkillByte0AndRun502BAnd53B9_Sub01 (E-0047)
; 2 call sites from 1 routine (e.g. DrawSkillByte0AndRun502BAnd53B9_WriteBattleArg0AndBattleArg1Etc)
; reads: wDebugValue0, wBattleArg0, wBattleArg1, wBattleArg2, wBattleArg3
DrawSkillByte0AndRun502BAnd53B9_Sub01_WriteVRAMByte::
Func_03A_540A:: ; address name
    ld a, [wDebugValue0]
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    inc hl
    ld a, [hl]
    cp a, $FF
    jr z, .next
    push hl
    push af
    and a, $0F
    cp a, $0A
    jr nc, .read_battle_arg0
    add a, $E0
    jr .read_battle_arg02

.read_battle_arg0:
    sub a, $02

.read_battle_arg02:
    ld b, a
    ld a, [wBattleArg0]
    ld l, a
    ld a, [wBattleArg1]
    ld h, a
    ld a, b
    call WriteVRAMByte
    pop af
    swap a
    and a, $0F
    cp a, $0A
    jr nc, .read_battle_arg03
    add a, $E0
    jr .read_battle_arg04

.read_battle_arg03:
    sub a, $02

.read_battle_arg04:
    ld b, a
    ld a, [wBattleArg0]
    ld l, a
    ld a, [wBattleArg1]
    ld h, a
    dec hl
    ld a, b
    call WriteVRAMByte
    pop hl

.next:
    dec hl
    ld a, [hl]
    cp a, $FF
    jr z, .return
    push af
    and a, $0F
    cp a, $0A
    jr nc, .read_battle_arg2
    add a, $E0
    jr .read_battle_arg22

.read_battle_arg2:
    sub a, $02

.read_battle_arg22:
    ld b, a
    ld a, [wBattleArg2]
    ld l, a
    ld a, [wBattleArg3]
    ld h, a
    ld a, b
    call WriteVRAMByte
    pop af
    swap a
    and a, $0F
    cp a, $0A
    jr nc, .read_battle_arg23
    add a, $E0
    jr .read_battle_arg24

.read_battle_arg23:
    sub a, $02

.read_battle_arg24:
    ld b, a
    ld a, [wBattleArg2]
    ld l, a
    ld a, [wBattleArg3]
    ld h, a
    dec hl
    ld a, b
    call WriteVRAMByte

.return:
    ret

; only called from DrawHexByteAtBGMap8A (E-0047)
; 1 call site from 1 routine (e.g. DrawHexByteAtBGMap8A)
; reads: wDebugSubState, wEffectTileOffset
; writes: wEffectTileOffset, wEffectByteB5, wEffectTargetMode, wEffectSpriteX, wEffectId, wEffectAnimState, wEffectActive, wEffectByteB3, ...
; points at: wEffectStep, wEffectByteB3
DrawHexByteAtBGMap8A_FillBytes::
Func_03A_548F:: ; address name
    ld a, [wDebugSubState]
    ld [wEffectTileOffset], a
    ld [wEffectByteB5], a
    ld a, $01
    ld [wEffectTargetMode], a
    xor a, a
    ld [wEffectSpriteX], a
    ld a, $FF
    ld hl, wEffectStep
    ld bc, $0003
    call FillBytes
    ld a, $01
    ld [wEffectId], a
    ld a, $01
    ld [wEffectAnimState], a
    ld a, $01
    ld [wEffectActive], a
    ld a, $00
    ld [wEffectByteB3], a
    ld hl, wEffectByteB3
    ld a, l
    ld [wSequencePtrLo], a
    ld a, h
    ld [wSequencePtrHi], a
    farcall TickSequencePtrLoSequence
    call SetEffectSpriteXForTargets
    ld a, [wEffectTileOffset]
    ld c, a
    call LoadEffectOBJPaletteC
    ret

; only called from RunDebugState_E0_Case0A (E-0047)
; 1 call site from 1 routine (e.g. RunDebugState_E0_Case0A_DecompressGraphicsAToTiles0_Case0A)
; reads: wEffectAnimState, wEffectTileOffset, wEffectByteB3, wEffectActive
; writes: wEffectAnimState, wEffectActive, wEffectId
RunDebugState_E0_Case0A_DecompressGraphicsAToTiles0::
Func_03A_54DC:: ; address name
    ld a, [wEffectAnimState]
    cp a, $01
    jr nz, .call_tick_sequence_ptr_lo_sequence
    ld a, [wEffectTileOffset]
    ld c, a
    call DecompressGraphicsAToTiles0
    ld a, $02
    ld [wEffectAnimState], a
    ret

.call_tick_sequence_ptr_lo_sequence:
    farcall TickSequencePtrLoSequence
    call AdvanceEffectSpriteXBy4InMode3
    ld a, [wEffectByteB3]
    or a, a
    jr z, .clear_effect_anim_state
    ld a, [wEffectActive]
    or a, a
    jr z, .clear_effect_anim_state
    call DrawEffectSpriteForEffectTileOffsetRange
    ret

.clear_effect_anim_state:
    xor a, a
    ld [wEffectAnimState], a
    ld [wEffectActive], a
    ld a, $FF
    ld [wEffectId], a
    ret

; on CGB copies palette C (8 bytes) from Data_03A_7D9A to wOBJPaletteBuffer and sets wC527 = $80 (E-0124)
; 3 call sites from 3 routines (e.g. SelectEffectByEffectFlags, RunBattleEffectAnimation, DrawHexByteAtBGMap8A_FillBytes)
; reads: wIsCGB
; writes: wOBJPaletteUploadRequest
; points at: wOBJPaletteBuffer
LoadEffectOBJPaletteC::
Func_03A_5516:: ; address name
    ld a, [wIsCGB]
    or a, a
    ret z
    ld l, c
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    ld bc, EffectOBJPalettes
    add hl, bc
    ld b, $08
    ld de, wOBJPaletteBuffer

.loop:
    ld a, [hl+]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld a, $80
    ld [wOBJPaletteUploadRequest], a
    ret

; on CGB, when wC5E9 changed, writes the eight background palettes through Func_03A_55BB (rBGPI $80-$B8) (E-0128)
; 1 call site from 1 routine (e.g. RunBattleEffectAnimation)
; reads: wIsCGB, wDMGPaletteBGP, rSTAT, wDMGPaletteOBP0
; writes: rBGPI, wDMGPaletteBytes, rOBPI
; points at: wDMGPaletteBytes, wBGPaletteBuffer, wOBJPaletteBuffer
UploadBGPalettesWithFade::
Func_03A_5536:: ; address name
    ld a, [wIsCGB]
    or a, a
    ret z
    ld hl, wDMGPaletteBytes
    ld a, [wDMGPaletteBGP]
    cp a, [hl]
    jp z, UploadBGPalettesWithFade_ReadDMGPaletteBGPAndSTAT_CheckDMGPaletteOBP0
    ld c, $69

.loop:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop
    ld a, $80
    ldh [rBGPI], a
    ld hl, wBGPaletteBuffer
    call UploadBGPalettesWithFade_ReadDMGPaletteBGPAndSTAT

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, $88
    ldh [rBGPI], a
    call UploadBGPalettesWithFade_ReadDMGPaletteBGPAndSTAT

.loop3:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop3
    ld a, $90
    ldh [rBGPI], a
    call UploadBGPalettesWithFade_ReadDMGPaletteBGPAndSTAT

.loop4:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop4
    ld a, $98
    ldh [rBGPI], a
    call UploadBGPalettesWithFade_ReadDMGPaletteBGPAndSTAT

.loop5:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop5
    ld a, $A0
    ldh [rBGPI], a
    call UploadBGPalettesWithFade_ReadDMGPaletteBGPAndSTAT

.loop6:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop6
    ld a, $A8
    ldh [rBGPI], a
    call UploadBGPalettesWithFade_ReadDMGPaletteBGPAndSTAT

.loop7:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop7
    ld a, $B0
    ldh [rBGPI], a
    call UploadBGPalettesWithFade_ReadDMGPaletteBGPAndSTAT

.loop8:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop8
    ld a, $B8
    ldh [rBGPI], a
    call UploadBGPalettesWithFade_ReadDMGPaletteBGPAndSTAT
    ld a, [wDMGPaletteBGP]
    ld [wDMGPaletteBytes], a
    jp UploadBGPalettesWithFade_ReadDMGPaletteBGPAndSTAT_CheckDMGPaletteOBP0

; only called from UploadBGPalettesWithFade (E-0047)
; 8 call sites from 1 routine (e.g. UploadBGPalettesWithFade)
; reads: wDMGPaletteBGP, rSTAT
UploadBGPalettesWithFade_ReadDMGPaletteBGPAndSTAT::
Func_03A_55BB:: ; address name
    push hl
    ld a, [wDMGPaletteBGP]
    and a, $03
    ld de, UploadBGPalettesWithFade_ReadDMGPaletteBGPAndSTAT_Data
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    add a, l
    ld l, a
    jr nc, .loop
    inc h

.loop:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [wDMGPaletteBGP]
    srl a
    srl a
    and a, $03
    ld de, UploadBGPalettesWithFade_ReadDMGPaletteBGPAndSTAT_Data
    add a, e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    add a, l
    ld l, a
    jr nc, .loop2
    inc h

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [wDMGPaletteBGP]
    swap a
    and a, $03
    ld de, UploadBGPalettesWithFade_ReadDMGPaletteBGPAndSTAT_Data
    add a, e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [de]
    add a, l
    ld l, a
    jr nc, .loop3
    inc h

.loop3:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop3
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [wDMGPaletteBGP]
    swap a
    srl a
    srl a
    and a, $03
    ld de, UploadBGPalettesWithFade_ReadDMGPaletteBGPAndSTAT_Data
    add a, e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    ld a, [de]
    add a, l
    ld l, a
    jr nc, .loop4
    inc h

.loop4:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop4
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

UploadBGPalettesWithFade_ReadDMGPaletteBGPAndSTAT_CheckDMGPaletteOBP0::
Jump_03A_564C:: ; address name
    ld hl, wDMGPaletteBytes + $1
    ld a, [wDMGPaletteOBP0]
    cp a, [hl]
    jp z, UploadBGPalettesWithFade_Sub01_ReadDMGPaletteOBP0AndSTAT_Return
    ld c, $6B

.loop:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop
    ld a, $80
    ldh [rOBPI], a
    ld hl, wOBJPaletteBuffer
    call UploadBGPalettesWithFade_Sub01_ReadDMGPaletteOBP0AndSTAT

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, $88
    ldh [rOBPI], a
    call UploadBGPalettesWithFade_Sub01_ReadDMGPaletteOBP0AndSTAT

.loop3:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop3
    ld a, $90
    ldh [rOBPI], a
    call UploadBGPalettesWithFade_Sub01_ReadDMGPaletteOBP0AndSTAT

.loop4:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop4
    ld a, $98
    ldh [rOBPI], a
    call UploadBGPalettesWithFade_Sub01_ReadDMGPaletteOBP0AndSTAT

.loop5:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop5
    ld a, $A0
    ldh [rOBPI], a
    call UploadBGPalettesWithFade_Sub01_ReadDMGPaletteOBP0AndSTAT

.loop6:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop6
    ld a, $A8
    ldh [rOBPI], a
    call UploadBGPalettesWithFade_Sub01_ReadDMGPaletteOBP0AndSTAT

.loop7:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop7
    ld a, $B0
    ldh [rOBPI], a
    call UploadBGPalettesWithFade_Sub01_ReadDMGPaletteOBP0AndSTAT

.loop8:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop8
    ld a, $B8
    ldh [rOBPI], a
    call UploadBGPalettesWithFade_Sub01_ReadDMGPaletteOBP0AndSTAT
    ld a, [wDMGPaletteOBP0]
    ld [wDMGPaletteBytes + $1], a
    jp UploadBGPalettesWithFade_Sub01_ReadDMGPaletteOBP0AndSTAT_Return

; only called from UploadBGPalettesWithFade_Sub01 (E-0047)
; 8 call sites from 1 routine (e.g. UploadBGPalettesWithFade_ReadDMGPaletteBGPAndSTAT)
; reads: wDMGPaletteOBP0, rSTAT
UploadBGPalettesWithFade_Sub01_ReadDMGPaletteOBP0AndSTAT::
Func_03A_56CC:: ; address name
    push hl
    ld a, [wDMGPaletteOBP0]
    and a, $03
    ld de, UploadBGPalettesWithFade_ReadDMGPaletteBGPAndSTAT_Data
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    add a, l
    ld l, a
    jr nc, .loop
    inc h

.loop:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [wDMGPaletteOBP0]
    srl a
    srl a
    and a, $03
    ld de, UploadBGPalettesWithFade_ReadDMGPaletteBGPAndSTAT_Data
    add a, e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    add a, l
    ld l, a
    jr nc, .loop2
    inc h

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [wDMGPaletteOBP0]
    swap a
    and a, $03
    ld de, UploadBGPalettesWithFade_ReadDMGPaletteBGPAndSTAT_Data
    add a, e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [de]
    add a, l
    ld l, a
    jr nc, .loop3
    inc h

.loop3:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop3
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [wDMGPaletteOBP0]
    swap a
    srl a
    srl a
    and a, $03
    ld de, UploadBGPalettesWithFade_ReadDMGPaletteBGPAndSTAT_Data
    add a, e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    ld a, [de]
    add a, l
    ld l, a
    jr nc, .loop4
    inc h

.loop4:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop4
    ld a, [hl+]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    ld a, l
    add a, $08
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ret

UploadBGPalettesWithFade_Sub01_ReadDMGPaletteOBP0AndSTAT_Return::
Jump_03A_575D:: ; address name
    ret

; address loaded by UploadBGPalettesWithFade_ReadDMGPaletteBGPAndSTAT, UploadBGPalettesWithFade_Sub01_ReadDMGPaletteOBP0AndSTAT
UploadBGPalettesWithFade_ReadDMGPaletteBGPAndSTAT_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_03A_575E:: ; address name
    db $02, $04, $00, $06

; reads the effect flags in wDAD3 and tests bits 7, 6, 5, 3, 2, 0 in that order. Bits 0 and 2 set wBattleActor to wBattleTarget and select a table (Data_03A_60B7 or Data_03A_6107) for the display; bits 7, 6, 5 and 3 go to routines not read (E-0057)
; 15 call sites from 12 routines (e.g. RunBattleEffectAnimation, RunBattleActions_StatusChecks_ShowActionBattleTextFromActionBattleTextTable, RunBattleStep4_ResolveSkill_ShowActionBattleTextFromActionBattleTextTable, ResolveStep0EEffect_WriteBattleSubStep2AndEffectSubStepEtc, ...)
; reads: wEffectFlags2, wBattleTarget, wBattleActionId
; writes: wBattleActor
SelectEffectByEffectFlags2Flags::
Func_03A_5762:: ; address name
    ld a, [wEffectFlags2]
    or a, a
    ret z
    bit 7, a
    jr nz, .skip
    bit 6, a
    jr nz, .skip2
    bit 5, a
    jr nz, .call_select_effect_by_effect_flags2_flags
    bit 3, a
    jr nz, .read_battle_action_id
    bit 2, a
    jr nz, .read_battle_target2
    bit 0, a
    jr nz, .read_battle_target
    ret

.read_battle_target:
    ld a, [wBattleTarget]
    ld [wBattleActor], a
    ld hl, ActionSoundTable_Flag0
    jr .read_battle_action_id2

.read_battle_target2:
    ld a, [wBattleTarget]
    ld [wBattleActor], a
    ld hl, ActionSoundTable_Flag2
    jr .read_battle_action_id2

.skip:
    ld hl, ActionSoundTable_Flag7
    jr .read_battle_action_id2

.skip2:
    ld hl, ActionSoundTable_Flag6
    jr .read_battle_action_id2

.call_select_effect_by_effect_flags2_flags:
    ld b, a
    call SelectEffectByEffectFlags2Flags_ReadBattleActionIdAndResolveMsgFlags
    ret nz
    ld hl, ActionSoundTable_Flag5A
    bit 4, b
    jr nz, .read_battle_action_id2
    ld hl, ActionSoundTable_Flag5B
    jr .read_battle_action_id2

.read_battle_action_id:
    ld hl, ActionSoundTable_Flag3

.read_battle_action_id2:
    ld a, [wBattleActionId]
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    call ActorOnLocalSide_Bank3A
    jr nc, .skip3
    inc hl

.skip3:
    ld a, [hl]
    cp a, $FF
    ret z
    call QueueSoundEffect
    ret

; only called from SelectEffectByEffectFlags2Flags (E-0047)
; 1 call site from 1 routine (e.g. SelectEffectByEffectFlags2Flags)
; reads: wBattleActionId, wResolveMsgFlags
; points at: wBattleDamageLo
SelectEffectByEffectFlags2Flags_ReadBattleActionIdAndResolveMsgFlags::
Func_03A_57CA:: ; address name
    bit 4, a
    ret z
    ld a, [wBattleActionId]
    cp a, $15
    jr z, .skip
    cp a, $20
    jr z, .check_resolve_msg_flags
    cp a, $7B
    jr z, .check_resolve_msg_flags
    cp a, $D6
    jr z, .skip
    xor a, a
    ret

.skip:
    ld hl, wBattleDamageLo
    ld a, [hl+]
    sub a, $E8
    ld a, [hl]
    sbc a, $03
    ld a, $81
    call QueueSoundEffect
    ret

.check_resolve_msg_flags:
    ld a, [wResolveMsgFlags]
    bit 6, a
    ret

; E-0210 (C1: SelectEffectByEffectFlags2Flags uses this table for wEffectFlags2 bit 7, indexed by wBattleActionId: byte 1 for a near-side actor (ActorOnLocalSide), else byte 0; a value other than $FF goes to QueueSoundEffect; 228 entries, up to the next table).
; record: sound effect for a far-side actor, for a near-side actor ($FF = none)
ActionSoundTable_Flag7::
Data_03A_57F7:: ; address name
    db $80, $7C ; id 0
    db $7A, $7A ; id 1
    db $7A, $7A ; id 2
    db $7A, $7A ; id 3
    db $7A, $7A ; id 4
    db $7A, $7A ; id 5
    db $7A, $7A ; id 6
    db $7A, $7A ; id 7
    db $7A, $7A ; id 8
    db $7A, $7A ; id 9
    db $7A, $7A ; id 10
    db $7A, $7A ; id 11
    db $7A, $7A ; id 12
    db $7A, $7A ; id 13
    db $7A, $7A ; id 14
    db $7A, $7A ; id 15
    db $7A, $7A ; id 16
    db $7A, $7A ; id 17
    db $7A, $7A ; id 18
    db $7A, $7A ; id 19
    db $7A, $7A ; id 20
    db $7A, $7A ; id 21
    db $7A, $7A ; id 22
    db $7A, $7A ; id 23
    db $7A, $7A ; id 24
    db $7A, $7A ; id 25
    db $7A, $7A ; id 26
    db $7A, $7A ; id 27
    db $7A, $7A ; id 28
    db $7A, $7A ; id 29
    db $7A, $7A ; id 30
    db $7A, $7A ; id 31
    db $7A, $7A ; id 32
    db $7A, $7A ; id 33
    db $7A, $7A ; id 34
    db $7A, $7A ; id 35
    db $7A, $7A ; id 36
    db $7A, $7A ; id 37
    db $7A, $7A ; id 38
    db $7A, $7A ; id 39
    db $7A, $7A ; id 40
    db $7A, $7A ; id 41
    db $7A, $7A ; id 42
    db $7A, $7A ; id 43
    db $7A, $7A ; id 44
    db $7A, $7A ; id 45
    db $7A, $7A ; id 46
    db $7A, $7A ; id 47
    db $7A, $7A ; id 48
    db $7A, $7A ; id 49
    db $7A, $7A ; id 50
    db $7A, $7A ; id 51
    db $7A, $7A ; id 52
    db $7A, $7A ; id 53
    db $7A, $7A ; id 54
    db $7A, $7A ; id 55
    db $7A, $7A ; id 56
    db $7A, $7A ; id 57
    db $7A, $7A ; id 58
    db $7A, $7A ; id 59
    db $7A, $7A ; id 60
    db $80, $7C ; id 61
    db $80, $7C ; id 62
    db $80, $7C ; id 63
    db $80, $7C ; id 64
    db $80, $7C ; id 65
    db $80, $7C ; id 66
    db $80, $7C ; id 67
    db $80, $7C ; id 68
    db $80, $7C ; id 69
    db $80, $7C ; id 70
    db $80, $7C ; id 71
    db $80, $7C ; id 72
    db $80, $7C ; id 73
    db $80, $7C ; id 74
    db $80, $7C ; id 75
    db $80, $7C ; id 76
    db $80, $7C ; id 77
    db $80, $7C ; id 78
    db $80, $7C ; id 79
    db $80, $7C ; id 80
    db $80, $7C ; id 81
    db $80, $7C ; id 82
    db $80, $7C ; id 83
    db $80, $7C ; id 84
    db $80, $7C ; id 85
    db $80, $7C ; id 86
    db $80, $7C ; id 87
    db $80, $7C ; id 88
    db $80, $7C ; id 89
    db $80, $7C ; id 90
    db $80, $7C ; id 91
    db $80, $7C ; id 92
    db $80, $7C ; id 93
    db $80, $7C ; id 94
    db $80, $7C ; id 95
    db $80, $7C ; id 96
    db $80, $7C ; id 97
    db $80, $7C ; id 98
    db $80, $7C ; id 99
    db $80, $7C ; id 100
    db $80, $7C ; id 101
    db $80, $7C ; id 102
    db $80, $7C ; id 103
    db $FF, $FF ; id 104
    db $80, $7C ; id 105
    db $80, $7C ; id 106
    db $80, $7C ; id 107
    db $80, $7C ; id 108
    db $80, $7C ; id 109
    db $80, $7C ; id 110
    db $80, $7C ; id 111
    db $80, $7C ; id 112
    db $80, $7C ; id 113
    db $80, $7C ; id 114
    db $80, $7C ; id 115
    db $80, $7C ; id 116
    db $80, $7C ; id 117
    db $80, $7C ; id 118
    db $80, $7C ; id 119
    db $80, $7C ; id 120
    db $80, $7C ; id 121
    db $80, $7C ; id 122
    db $80, $7C ; id 123
    db $80, $7C ; id 124
    db $80, $7C ; id 125
    db $80, $7C ; id 126
    db $FF, $FF ; id 127
    db $FF, $FF ; id 128
    db $FF, $FF ; id 129
    db $FF, $FF ; id 130
    db $FF, $FF ; id 131
    db $FF, $FF ; id 132
    db $7A, $7A ; id 133
    db $7A, $7A ; id 134
    db $7A, $7A ; id 135
    db $7A, $7A ; id 136
    db $FF, $FF ; id 137
    db $FF, $FF ; id 138
    db $80, $7C ; id 139
    db $80, $7C ; id 140
    db $80, $7C ; id 141
    db $80, $7C ; id 142
    db $7C, $7C ; id 143
    db $FF, $FF ; id 144
    db $7A, $7A ; id 145
    db $80, $7C ; id 146
    db $80, $7C ; id 147
    db $FF, $FF ; id 148
    db $FF, $FF ; id 149
    db $FF, $FF ; id 150
    db $FF, $FF ; id 151
    db $FF, $FF ; id 152
    db $FF, $FF ; id 153
    db $FF, $FF ; id 154
    db $7A, $7A ; id 155
    db $FF, $FF ; id 156
    db $FF, $FF ; id 157
    db $FF, $FF ; id 158
    db $FF, $FF ; id 159
    db $FF, $FF ; id 160
    db $FF, $FF ; id 161
    db $FF, $FF ; id 162
    db $FF, $FF ; id 163
    db $FF, $FF ; id 164
    db $FF, $FF ; id 165
    db $FF, $FF ; id 166
    db $FF, $FF ; id 167
    db $FF, $FF ; id 168
    db $FF, $FF ; id 169
    db $80, $7C ; id 170
    db $FF, $FF ; id 171
    db $FF, $FF ; id 172
    db $7A, $FF ; id 173
    db $7A, $FF ; id 174
    db $FF, $FF ; id 175
    db $FF, $FF ; id 176
    db $FF, $FF ; id 177
    db $FF, $FF ; id 178
    db $FF, $FF ; id 179
    db $FF, $FF ; id 180
    db $FF, $FF ; id 181
    db $FF, $FF ; id 182
    db $FF, $FF ; id 183
    db $FF, $FF ; id 184
    db $80, $7C ; id 185
    db $FF, $FF ; id 186
    db $FF, $FF ; id 187
    db $FF, $FF ; id 188
    db $FF, $FF ; id 189
    db $FF, $FF ; id 190
    db $FF, $FF ; id 191
    db $80, $7C ; id 192
    db $80, $7C ; id 193
    db $80, $7C ; id 194
    db $FF, $FF ; id 195
    db $FF, $FF ; id 196
    db $FF, $FF ; id 197
    db $FF, $FF ; id 198
    db $FF, $FF ; id 199
    db $FF, $FF ; id 200
    db $65, $65 ; id 201
    db $65, $65 ; id 202
    db $65, $65 ; id 203
    db $65, $65 ; id 204
    db $65, $65 ; id 205
    db $FF, $FF ; id 206
    db $FF, $FF ; id 207
    db $7A, $7A ; id 208
    db $7A, $7A ; id 209
    db $80, $7C ; id 210
    db $80, $7C ; id 211
    db $80, $7C ; id 212
    db $80, $7C ; id 213
    db $7A, $7A ; id 214
    db $80, $7C ; id 215
    db $80, $7C ; id 216
    db $7A, $7A ; id 217
    db $FF, $FF ; id 218
    db $FF, $FF ; id 219
    db $7A, $7A ; id 220
    db $FF, $FF ; id 221
    db $FF, $FF ; id 222
    db $7A, $7A ; id 223
    db $FF, $FF ; id 224
    db $FF, $FF ; id 225
    db $FF, $FF ; id 226
    db $FF, $FF ; id 227

; E-0210 (C1: SelectEffectByEffectFlags2Flags uses this table for wEffectFlags2 bit 6, indexed by wBattleActionId: byte 1 for a near-side actor (ActorOnLocalSide), else byte 0; a value other than $FF goes to QueueSoundEffect; 228 entries, up to the next table).
; record: sound effect for a far-side actor, for a near-side actor ($FF = none)
ActionSoundTable_Flag6::
Data_03A_59BF:: ; address name
    db $FF, $FF ; id 0
    db $FF, $89 ; id 1
    db $FF, $8B ; id 2
    db $FF, $8B ; id 3
    db $FF, $8D ; id 4
    db $FF, $8D ; id 5
    db $FF, $8F ; id 6
    db $FF, $90 ; id 7
    db $FF, $D9 ; id 8
    db $FF, $91 ; id 9
    db $FF, $93 ; id 10
    db $FF, $93 ; id 11
    db $FF, $94 ; id 12
    db $FF, $97 ; id 13
    db $FF, $97 ; id 14
    db $FF, $98 ; id 15
    db $FF, $95 ; id 16
    db $FF, $95 ; id 17
    db $FF, $96 ; id 18
    db $FF, $FF ; id 19
    db $FF, $FF ; id 20
    db $FF, $FF ; id 21
    db $FF, $FF ; id 22
    db $FF, $FF ; id 23
    db $FF, $FF ; id 24
    db $FF, $FF ; id 25
    db $FF, $FF ; id 26
    db $FF, $FF ; id 27
    db $FF, $FF ; id 28
    db $FF, $FF ; id 29
    db $FF, $FF ; id 30
    db $FF, $FF ; id 31
    db $FF, $FF ; id 32
    db $FF, $FF ; id 33
    db $FF, $FF ; id 34
    db $FF, $FF ; id 35
    db $FF, $FF ; id 36
    db $FF, $FF ; id 37
    db $FF, $FF ; id 38
    db $FF, $FF ; id 39
    db $FF, $FF ; id 40
    db $FF, $FF ; id 41
    db $FF, $FF ; id 42
    db $FF, $FF ; id 43
    db $FF, $FF ; id 44
    db $FF, $FF ; id 45
    db $FF, $FF ; id 46
    db $FF, $FF ; id 47
    db $FF, $FF ; id 48
    db $FF, $FF ; id 49
    db $FF, $FF ; id 50
    db $FF, $FF ; id 51
    db $FF, $FF ; id 52
    db $FF, $FF ; id 53
    db $FF, $FF ; id 54
    db $FF, $FF ; id 55
    db $FF, $FF ; id 56
    db $FF, $FF ; id 57
    db $FF, $FF ; id 58
    db $FF, $FF ; id 59
    db $FF, $FF ; id 60
    db $FF, $AE ; id 61
    db $FF, $AC ; id 62
    db $FF, $AB ; id 63
    db $FF, $8D ; id 64
    db $FF, $8D ; id 65
    db $FF, $8F ; id 66
    db $FF, $9F ; id 67
    db $FF, $95 ; id 68
    db $FF, $95 ; id 69
    db $FF, $96 ; id 70
    db $FF, $9D ; id 71
    db $FF, $93 ; id 72
    db $FF, $94 ; id 73
    db $FF, $97 ; id 74
    db $FF, $9E ; id 75
    db $FF, $B2 ; id 76
    db $FF, $B4 ; id 77
    db $FF, $FF ; id 78
    db $FF, $FF ; id 79
    db $FF, $A2 ; id 80
    db $FF, $A4 ; id 81
    db $FF, $A3 ; id 82
    db $FF, $A5 ; id 83
    db $FF, $A7 ; id 84
    db $FF, $99 ; id 85
    db $FF, $99 ; id 86
    db $FF, $A8 ; id 87
    db $FF, $A7 ; id 88
    db $FF, $99 ; id 89
    db $FF, $DA ; id 90
    db $FF, $DA ; id 91
    db $FF, $99 ; id 92
    db $FF, $B8 ; id 93
    db $FF, $99 ; id 94
    db $FF, $FF ; id 95
    db $FF, $FF ; id 96
    db $FF, $FF ; id 97
    db $FF, $99 ; id 98
    db $FF, $FF ; id 99
    db $FF, $FF ; id 100
    db $FF, $99 ; id 101
    db $FF, $AA ; id 102
    db $FF, $A9 ; id 103
    db $FF, $FF ; id 104
    db $FF, $FF ; id 105
    db $FF, $FF ; id 106
    db $FF, $99 ; id 107
    db $FF, $99 ; id 108
    db $FF, $99 ; id 109
    db $FF, $FF ; id 110
    db $FF, $FF ; id 111
    db $FF, $FF ; id 112
    db $FF, $FF ; id 113
    db $FF, $FF ; id 114
    db $FF, $FF ; id 115
    db $FF, $FF ; id 116
    db $FF, $FF ; id 117
    db $FF, $FF ; id 118
    db $FF, $FF ; id 119
    db $FF, $FF ; id 120
    db $FF, $FF ; id 121
    db $FF, $FF ; id 122
    db $FF, $FF ; id 123
    db $FF, $FF ; id 124
    db $FF, $FF ; id 125
    db $FF, $FF ; id 126
    db $FF, $FF ; id 127
    db $FF, $FF ; id 128
    db $FF, $FF ; id 129
    db $FF, $FF ; id 130
    db $B0, $B0 ; id 131
    db $FF, $FF ; id 132
    db $FF, $FF ; id 133
    db $FF, $FF ; id 134
    db $FF, $FF ; id 135
    db $FF, $FF ; id 136
    db $FF, $FF ; id 137
    db $FF, $FF ; id 138
    db $FF, $FF ; id 139
    db $FF, $FF ; id 140
    db $FF, $FF ; id 141
    db $FF, $FF ; id 142
    db $FF, $FF ; id 143
    db $FF, $FF ; id 144
    db $FF, $B6 ; id 145
    db $FF, $FF ; id 146
    db $FF, $FF ; id 147
    db $FF, $FF ; id 148
    db $FF, $FF ; id 149
    db $FF, $FF ; id 150
    db $FF, $FF ; id 151
    db $FF, $FF ; id 152
    db $FF, $FF ; id 153
    db $FF, $FF ; id 154
    db $DC, $FF ; id 155
    db $FF, $FF ; id 156
    db $FF, $FF ; id 157
    db $FF, $FF ; id 158
    db $FF, $FF ; id 159
    db $FF, $FF ; id 160
    db $BA, $FF ; id 161
    db $FF, $FF ; id 162
    db $FF, $FF ; id 163
    db $FF, $FF ; id 164
    db $FF, $FF ; id 165
    db $FF, $FF ; id 166
    db $FF, $FF ; id 167
    db $FF, $FF ; id 168
    db $FF, $FF ; id 169
    db $FF, $FF ; id 170
    db $FF, $FF ; id 171
    db $FF, $FF ; id 172
    db $FF, $FF ; id 173
    db $FF, $FF ; id 174
    db $FF, $FF ; id 175
    db $FF, $FF ; id 176
    db $FF, $FF ; id 177
    db $FF, $FF ; id 178
    db $FF, $FF ; id 179
    db $FF, $FF ; id 180
    db $FF, $FF ; id 181
    db $FF, $FF ; id 182
    db $FF, $FF ; id 183
    db $FF, $FF ; id 184
    db $FF, $FF ; id 185
    db $FF, $FF ; id 186
    db $FF, $FF ; id 187
    db $FF, $FF ; id 188
    db $FF, $FF ; id 189
    db $FF, $FF ; id 190
    db $FF, $FF ; id 191
    db $FF, $FF ; id 192
    db $FF, $FF ; id 193
    db $FF, $FF ; id 194
    db $FF, $FF ; id 195
    db $FF, $FF ; id 196
    db $FF, $FF ; id 197
    db $FF, $FF ; id 198
    db $FF, $FF ; id 199
    db $FF, $FF ; id 200
    db $FF, $FF ; id 201
    db $FF, $FF ; id 202
    db $FF, $FF ; id 203
    db $FF, $FF ; id 204
    db $FF, $FF ; id 205
    db $FF, $FF ; id 206
    db $FF, $FF ; id 207
    db $FF, $BC ; id 208
    db $FF, $BD ; id 209
    db $FF, $BF ; id 210
    db $FF, $C1 ; id 211
    db $FF, $C3 ; id 212
    db $FF, $C5 ; id 213
    db $FF, $FF ; id 214
    db $FF, $99 ; id 215
    db $FF, $99 ; id 216
    db $FF, $C7 ; id 217
    db $FF, $FF ; id 218
    db $FF, $FF ; id 219
    db $FF, $FF ; id 220
    db $FF, $FF ; id 221
    db $FF, $FF ; id 222
    db $FF, $FF ; id 223
    db $FF, $FF ; id 224
    db $FF, $FF ; id 225
    db $FF, $FF ; id 226
    db $CB, $FF ; id 227

; E-0210 (C1: SelectEffectByEffectFlags2Flags uses this table for wEffectFlags2 bit 5 with bit 4 (after SelectEffectByEffectFlags2Flags_Sub01), indexed by wBattleActionId: byte 1 for a near-side actor (ActorOnLocalSide), else byte 0; a value other than $FF goes to QueueSoundEffect; 228 entries, up to the next table).
; record: sound effect for a far-side actor, for a near-side actor ($FF = none)
ActionSoundTable_Flag5A::
Data_03A_5B87:: ; address name
    db $81, $81 ; id 0
    db $81, $81 ; id 1
    db $81, $81 ; id 2
    db $81, $81 ; id 3
    db $81, $81 ; id 4
    db $81, $81 ; id 5
    db $81, $81 ; id 6
    db $81, $81 ; id 7
    db $81, $81 ; id 8
    db $81, $81 ; id 9
    db $81, $81 ; id 10
    db $81, $81 ; id 11
    db $81, $81 ; id 12
    db $81, $81 ; id 13
    db $81, $81 ; id 14
    db $81, $81 ; id 15
    db $81, $81 ; id 16
    db $81, $81 ; id 17
    db $81, $81 ; id 18
    db $B1, $B1 ; id 19
    db $B1, $B1 ; id 20
    db $B1, $B1 ; id 21
    db $85, $85 ; id 22
    db $85, $85 ; id 23
    db $85, $85 ; id 24
    db $85, $85 ; id 25
    db $85, $85 ; id 26
    db $85, $85 ; id 27
    db $85, $85 ; id 28
    db $85, $85 ; id 29
    db $FF, $FF ; id 30
    db $FF, $FF ; id 31
    db $85, $85 ; id 32
    db $85, $85 ; id 33
    db $85, $85 ; id 34
    db $85, $85 ; id 35
    db $85, $85 ; id 36
    db $86, $86 ; id 37
    db $86, $86 ; id 38
    db $87, $87 ; id 39
    db $87, $87 ; id 40
    db $86, $86 ; id 41
    db $86, $86 ; id 42
    db $87, $87 ; id 43
    db $87, $87 ; id 44
    db $86, $86 ; id 45
    db $99, $99 ; id 46
    db $88, $88 ; id 47
    db $88, $88 ; id 48
    db $86, $FF ; id 49
    db $86, $87 ; id 50
    db $87, $87 ; id 51
    db $FF, $88 ; id 52
    db $FF, $FF ; id 53
    db $9B, $9B ; id 54
    db $9B, $9B ; id 55
    db $FF, $FF ; id 56
    db $FF, $FF ; id 57
    db $9A, $9A ; id 58
    db $9A, $9A ; id 59
    db $FF, $FF ; id 60
    db $81, $81 ; id 61
    db $81, $81 ; id 62
    db $81, $81 ; id 63
    db $81, $81 ; id 64
    db $81, $81 ; id 65
    db $81, $81 ; id 66
    db $81, $81 ; id 67
    db $81, $81 ; id 68
    db $81, $81 ; id 69
    db $81, $81 ; id 70
    db $81, $81 ; id 71
    db $81, $81 ; id 72
    db $81, $81 ; id 73
    db $81, $81 ; id 74
    db $81, $81 ; id 75
    db $81, $81 ; id 76
    db $81, $81 ; id 77
    db $81, $81 ; id 78
    db $81, $81 ; id 79
    db $81, $81 ; id 80
    db $81, $81 ; id 81
    db $81, $81 ; id 82
    db $81, $81 ; id 83
    db $81, $81 ; id 84
    db $81, $81 ; id 85
    db $81, $81 ; id 86
    db $81, $81 ; id 87
    db $81, $81 ; id 88
    db $81, $81 ; id 89
    db $81, $81 ; id 90
    db $81, $81 ; id 91
    db $81, $81 ; id 92
    db $81, $81 ; id 93
    db $81, $81 ; id 94
    db $81, $81 ; id 95
    db $81, $81 ; id 96
    db $81, $81 ; id 97
    db $81, $81 ; id 98
    db $81, $81 ; id 99
    db $81, $81 ; id 100
    db $81, $81 ; id 101
    db $81, $81 ; id 102
    db $81, $81 ; id 103
    db $FF, $FF ; id 104
    db $81, $81 ; id 105
    db $81, $81 ; id 106
    db $81, $81 ; id 107
    db $81, $81 ; id 108
    db $81, $81 ; id 109
    db $81, $81 ; id 110
    db $81, $81 ; id 111
    db $81, $81 ; id 112
    db $88, $88 ; id 113
    db $88, $88 ; id 114
    db $88, $88 ; id 115
    db $88, $88 ; id 116
    db $88, $88 ; id 117
    db $87, $87 ; id 118
    db $86, $87 ; id 119
    db $88, $88 ; id 120
    db $B1, $B1 ; id 121
    db $88, $88 ; id 122
    db $85, $85 ; id 123
    db $85, $85 ; id 124
    db $FF, $FF ; id 125
    db $88, $99 ; id 126
    db $81, $81 ; id 127
    db $FF, $FF ; id 128
    db $85, $85 ; id 129
    db $87, $87 ; id 130
    db $FF, $FF ; id 131
    db $FF, $FF ; id 132
    db $FF, $FF ; id 133
    db $FF, $FF ; id 134
    db $FF, $FF ; id 135
    db $FF, $FF ; id 136
    db $FF, $FF ; id 137
    db $FF, $FF ; id 138
    db $88, $88 ; id 139
    db $88, $88 ; id 140
    db $81, $81 ; id 141
    db $81, $81 ; id 142
    db $88, $88 ; id 143
    db $81, $81 ; id 144
    db $7A, $7A ; id 145
    db $87, $87 ; id 146
    db $87, $87 ; id 147
    db $FF, $FF ; id 148
    db $FF, $FF ; id 149
    db $FF, $FF ; id 150
    db $FF, $FF ; id 151
    db $FF, $FF ; id 152
    db $FF, $FF ; id 153
    db $FF, $FF ; id 154
    db $9B, $9B ; id 155
    db $85, $85 ; id 156
    db $FF, $FF ; id 157
    db $FF, $FF ; id 158
    db $85, $85 ; id 159
    db $FF, $FF ; id 160
    db $FF, $FF ; id 161
    db $FF, $FF ; id 162
    db $FF, $FF ; id 163
    db $FF, $FF ; id 164
    db $FF, $FF ; id 165
    db $FF, $FF ; id 166
    db $FF, $FF ; id 167
    db $FF, $FF ; id 168
    db $FF, $FF ; id 169
    db $81, $81 ; id 170
    db $FF, $FF ; id 171
    db $FF, $FF ; id 172
    db $87, $87 ; id 173
    db $FF, $FF ; id 174
    db $FF, $FF ; id 175
    db $82, $82 ; id 176
    db $85, $85 ; id 177
    db $7A, $7A ; id 178
    db $FF, $FF ; id 179
    db $86, $86 ; id 180
    db $88, $88 ; id 181
    db $87, $87 ; id 182
    db $FF, $FF ; id 183
    db $9A, $9A ; id 184
    db $81, $81 ; id 185
    db $FF, $FF ; id 186
    db $FF, $FF ; id 187
    db $85, $85 ; id 188
    db $81, $81 ; id 189
    db $FF, $FF ; id 190
    db $FF, $FF ; id 191
    db $81, $81 ; id 192
    db $81, $81 ; id 193
    db $81, $81 ; id 194
    db $FF, $FF ; id 195
    db $FF, $FF ; id 196
    db $FF, $FF ; id 197
    db $FF, $FF ; id 198
    db $FF, $FF ; id 199
    db $FF, $FF ; id 200
    db $81, $81 ; id 201
    db $81, $81 ; id 202
    db $81, $81 ; id 203
    db $81, $81 ; id 204
    db $81, $81 ; id 205
    db $FF, $FF ; id 206
    db $FF, $FF ; id 207
    db $81, $81 ; id 208
    db $81, $81 ; id 209
    db $81, $81 ; id 210
    db $81, $81 ; id 211
    db $81, $81 ; id 212
    db $81, $81 ; id 213
    db $81, $81 ; id 214
    db $81, $81 ; id 215
    db $81, $81 ; id 216
    db $81, $81 ; id 217
    db $85, $85 ; id 218
    db $FF, $FF ; id 219
    db $9A, $9A ; id 220
    db $86, $86 ; id 221
    db $FF, $FF ; id 222
    db $86, $87 ; id 223
    db $FF, $FF ; id 224
    db $88, $88 ; id 225
    db $FF, $FF ; id 226
    db $FF, $FF ; id 227

; E-0210 (C1: SelectEffectByEffectFlags2Flags uses this table for wEffectFlags2 bit 5 without bit 4, indexed by wBattleActionId: byte 1 for a near-side actor (ActorOnLocalSide), else byte 0; a value other than $FF goes to QueueSoundEffect; 228 entries, up to the next table).
; record: sound effect for a far-side actor, for a near-side actor ($FF = none)
ActionSoundTable_Flag5B::
Data_03A_5D4F:: ; address name
    db $84, $84 ; id 0
    db $FF, $FF ; id 1
    db $FF, $FF ; id 2
    db $FF, $FF ; id 3
    db $FF, $FF ; id 4
    db $FF, $FF ; id 5
    db $FF, $FF ; id 6
    db $FF, $FF ; id 7
    db $FF, $FF ; id 8
    db $FF, $FF ; id 9
    db $FF, $FF ; id 10
    db $FF, $FF ; id 11
    db $FF, $FF ; id 12
    db $FF, $FF ; id 13
    db $FF, $FF ; id 14
    db $FF, $FF ; id 15
    db $FF, $FF ; id 16
    db $FF, $FF ; id 17
    db $FF, $FF ; id 18
    db $FF, $FF ; id 19
    db $FF, $FF ; id 20
    db $FF, $FF ; id 21
    db $FF, $FF ; id 22
    db $FF, $FF ; id 23
    db $FF, $FF ; id 24
    db $FF, $FF ; id 25
    db $FF, $FF ; id 26
    db $FF, $FF ; id 27
    db $FF, $FF ; id 28
    db $FF, $FF ; id 29
    db $FF, $FF ; id 30
    db $FF, $FF ; id 31
    db $FF, $FF ; id 32
    db $FF, $FF ; id 33
    db $FF, $FF ; id 34
    db $FF, $FF ; id 35
    db $FF, $FF ; id 36
    db $FF, $FF ; id 37
    db $FF, $FF ; id 38
    db $FF, $FF ; id 39
    db $FF, $FF ; id 40
    db $FF, $FF ; id 41
    db $FF, $FF ; id 42
    db $FF, $FF ; id 43
    db $FF, $FF ; id 44
    db $FF, $FF ; id 45
    db $FF, $FF ; id 46
    db $FF, $FF ; id 47
    db $FF, $FF ; id 48
    db $FF, $FF ; id 49
    db $FF, $FF ; id 50
    db $FF, $FF ; id 51
    db $FF, $FF ; id 52
    db $FF, $FF ; id 53
    db $FF, $FF ; id 54
    db $FF, $FF ; id 55
    db $FF, $FF ; id 56
    db $FF, $FF ; id 57
    db $FF, $FF ; id 58
    db $FF, $FF ; id 59
    db $FF, $FF ; id 60
    db $FF, $FF ; id 61
    db $FF, $FF ; id 62
    db $FF, $FF ; id 63
    db $FF, $FF ; id 64
    db $FF, $FF ; id 65
    db $FF, $FF ; id 66
    db $FF, $FF ; id 67
    db $FF, $FF ; id 68
    db $FF, $FF ; id 69
    db $FF, $FF ; id 70
    db $FF, $FF ; id 71
    db $FF, $FF ; id 72
    db $FF, $FF ; id 73
    db $FF, $FF ; id 74
    db $FF, $FF ; id 75
    db $FF, $FF ; id 76
    db $FF, $FF ; id 77
    db $FF, $FF ; id 78
    db $FF, $FF ; id 79
    db $84, $84 ; id 80
    db $84, $84 ; id 81
    db $84, $84 ; id 82
    db $84, $84 ; id 83
    db $84, $84 ; id 84
    db $84, $84 ; id 85
    db $84, $84 ; id 86
    db $84, $84 ; id 87
    db $84, $84 ; id 88
    db $84, $84 ; id 89
    db $84, $84 ; id 90
    db $84, $84 ; id 91
    db $84, $84 ; id 92
    db $84, $84 ; id 93
    db $84, $84 ; id 94
    db $84, $84 ; id 95
    db $84, $84 ; id 96
    db $84, $84 ; id 97
    db $84, $84 ; id 98
    db $84, $84 ; id 99
    db $84, $84 ; id 100
    db $84, $84 ; id 101
    db $84, $84 ; id 102
    db $84, $84 ; id 103
    db $FF, $FF ; id 104
    db $84, $84 ; id 105
    db $84, $84 ; id 106
    db $84, $84 ; id 107
    db $84, $84 ; id 108
    db $84, $84 ; id 109
    db $84, $84 ; id 110
    db $84, $84 ; id 111
    db $84, $84 ; id 112
    db $FF, $FF ; id 113
    db $FF, $FF ; id 114
    db $FF, $FF ; id 115
    db $FF, $FF ; id 116
    db $FF, $FF ; id 117
    db $FF, $FF ; id 118
    db $FF, $FF ; id 119
    db $FF, $FF ; id 120
    db $FF, $FF ; id 121
    db $FF, $FF ; id 122
    db $FF, $FF ; id 123
    db $FF, $FF ; id 124
    db $FF, $FF ; id 125
    db $FF, $FF ; id 126
    db $FF, $FF ; id 127
    db $FF, $FF ; id 128
    db $FF, $FF ; id 129
    db $FF, $FF ; id 130
    db $FF, $FF ; id 131
    db $FF, $FF ; id 132
    db $FF, $FF ; id 133
    db $FF, $FF ; id 134
    db $FF, $FF ; id 135
    db $FF, $FF ; id 136
    db $FF, $FF ; id 137
    db $FF, $FF ; id 138
    db $FF, $FF ; id 139
    db $FF, $FF ; id 140
    db $FF, $FF ; id 141
    db $FF, $FF ; id 142
    db $FF, $FF ; id 143
    db $FF, $FF ; id 144
    db $FF, $FF ; id 145
    db $FF, $FF ; id 146
    db $FF, $FF ; id 147
    db $FF, $FF ; id 148
    db $FF, $FF ; id 149
    db $FF, $FF ; id 150
    db $FF, $FF ; id 151
    db $FF, $FF ; id 152
    db $FF, $FF ; id 153
    db $FF, $FF ; id 154
    db $FF, $FF ; id 155
    db $FF, $FF ; id 156
    db $FF, $FF ; id 157
    db $FF, $FF ; id 158
    db $FF, $FF ; id 159
    db $FF, $FF ; id 160
    db $FF, $FF ; id 161
    db $FF, $FF ; id 162
    db $FF, $FF ; id 163
    db $FF, $FF ; id 164
    db $FF, $FF ; id 165
    db $FF, $FF ; id 166
    db $FF, $FF ; id 167
    db $FF, $FF ; id 168
    db $FF, $FF ; id 169
    db $84, $84 ; id 170
    db $FF, $FF ; id 171
    db $FF, $FF ; id 172
    db $FF, $FF ; id 173
    db $FF, $FF ; id 174
    db $FF, $FF ; id 175
    db $FF, $FF ; id 176
    db $FF, $FF ; id 177
    db $FF, $FF ; id 178
    db $FF, $FF ; id 179
    db $FF, $FF ; id 180
    db $FF, $FF ; id 181
    db $FF, $FF ; id 182
    db $FF, $FF ; id 183
    db $FF, $FF ; id 184
    db $84, $84 ; id 185
    db $FF, $FF ; id 186
    db $FF, $FF ; id 187
    db $FF, $FF ; id 188
    db $FF, $FF ; id 189
    db $FF, $FF ; id 190
    db $FF, $FF ; id 191
    db $84, $84 ; id 192
    db $84, $84 ; id 193
    db $84, $84 ; id 194
    db $FF, $FF ; id 195
    db $FF, $FF ; id 196
    db $FF, $FF ; id 197
    db $FF, $FF ; id 198
    db $FF, $FF ; id 199
    db $82, $82 ; id 200
    db $FF, $FF ; id 201
    db $FF, $FF ; id 202
    db $FF, $FF ; id 203
    db $84, $84 ; id 204
    db $FF, $FF ; id 205
    db $FF, $FF ; id 206
    db $FF, $FF ; id 207
    db $FF, $FF ; id 208
    db $FF, $FF ; id 209
    db $84, $84 ; id 210
    db $84, $84 ; id 211
    db $84, $84 ; id 212
    db $84, $84 ; id 213
    db $FF, $FF ; id 214
    db $84, $84 ; id 215
    db $84, $84 ; id 216
    db $FF, $FF ; id 217
    db $FF, $FF ; id 218
    db $FF, $FF ; id 219
    db $FF, $FF ; id 220
    db $FF, $FF ; id 221
    db $FF, $FF ; id 222
    db $FF, $FF ; id 223
    db $FF, $FF ; id 224
    db $FF, $FF ; id 225
    db $FF, $FF ; id 226
    db $FF, $FF ; id 227

; E-0210 (C1: SelectEffectByEffectFlags2Flags uses this table for wEffectFlags2 bit 3, indexed by wBattleActionId: byte 1 for a near-side actor (ActorOnLocalSide), else byte 0; a value other than $FF goes to QueueSoundEffect; 208 entries, up to the next table).
; record: sound effect for a far-side actor, for a near-side actor ($FF = none)
ActionSoundTable_Flag3::
Data_03A_5F17:: ; address name
    db $FF, $FF ; id 0
    db $FF, $FF ; id 1
    db $FF, $FF ; id 2
    db $FF, $FF ; id 3
    db $FF, $FF ; id 4
    db $FF, $FF ; id 5
    db $FF, $FF ; id 6
    db $FF, $FF ; id 7
    db $FF, $FF ; id 8
    db $FF, $FF ; id 9
    db $FF, $FF ; id 10
    db $FF, $FF ; id 11
    db $FF, $FF ; id 12
    db $FF, $FF ; id 13
    db $FF, $FF ; id 14
    db $FF, $FF ; id 15
    db $FF, $FF ; id 16
    db $FF, $FF ; id 17
    db $FF, $FF ; id 18
    db $FF, $FF ; id 19
    db $FF, $FF ; id 20
    db $FF, $FF ; id 21
    db $FF, $FF ; id 22
    db $FF, $FF ; id 23
    db $FF, $FF ; id 24
    db $FF, $FF ; id 25
    db $FF, $FF ; id 26
    db $FF, $FF ; id 27
    db $FF, $FF ; id 28
    db $FF, $FF ; id 29
    db $FF, $FF ; id 30
    db $FF, $FF ; id 31
    db $FF, $FF ; id 32
    db $FF, $FF ; id 33
    db $FF, $FF ; id 34
    db $FF, $FF ; id 35
    db $FF, $FF ; id 36
    db $FF, $FF ; id 37
    db $FF, $FF ; id 38
    db $FF, $FF ; id 39
    db $FF, $FF ; id 40
    db $FF, $FF ; id 41
    db $FF, $FF ; id 42
    db $FF, $FF ; id 43
    db $FF, $FF ; id 44
    db $FF, $FF ; id 45
    db $FF, $FF ; id 46
    db $FF, $FF ; id 47
    db $FF, $FF ; id 48
    db $FF, $FF ; id 49
    db $FF, $FF ; id 50
    db $FF, $FF ; id 51
    db $FF, $FF ; id 52
    db $FF, $FF ; id 53
    db $FF, $FF ; id 54
    db $FF, $FF ; id 55
    db $FF, $FF ; id 56
    db $FF, $FF ; id 57
    db $FF, $FF ; id 58
    db $FF, $FF ; id 59
    db $FF, $FF ; id 60
    db $FF, $FF ; id 61
    db $FF, $FF ; id 62
    db $FF, $FF ; id 63
    db $FF, $FF ; id 64
    db $FF, $FF ; id 65
    db $FF, $FF ; id 66
    db $FF, $FF ; id 67
    db $FF, $FF ; id 68
    db $FF, $FF ; id 69
    db $FF, $FF ; id 70
    db $FF, $FF ; id 71
    db $FF, $FF ; id 72
    db $FF, $FF ; id 73
    db $FF, $FF ; id 74
    db $FF, $FF ; id 75
    db $FF, $FF ; id 76
    db $FF, $FF ; id 77
    db $FF, $FF ; id 78
    db $FF, $FF ; id 79
    db $FF, $FF ; id 80
    db $FF, $FF ; id 81
    db $FF, $FF ; id 82
    db $FF, $FF ; id 83
    db $FF, $FF ; id 84
    db $FF, $FF ; id 85
    db $FF, $FF ; id 86
    db $FF, $FF ; id 87
    db $FF, $FF ; id 88
    db $FF, $FF ; id 89
    db $FF, $FF ; id 90
    db $FF, $FF ; id 91
    db $FF, $FF ; id 92
    db $FF, $FF ; id 93
    db $FF, $FF ; id 94
    db $88, $88 ; id 95
    db $88, $88 ; id 96
    db $88, $88 ; id 97
    db $FF, $FF ; id 98
    db $FF, $FF ; id 99
    db $FF, $FF ; id 100
    db $FF, $FF ; id 101
    db $FF, $FF ; id 102
    db $FF, $FF ; id 103
    db $FF, $FF ; id 104
    db $FF, $FF ; id 105
    db $FF, $FF ; id 106
    db $FF, $FF ; id 107
    db $FF, $FF ; id 108
    db $81, $81 ; id 109
    db $FF, $FF ; id 110
    db $81, $81 ; id 111
    db $81, $81 ; id 112
    db $FF, $FF ; id 113
    db $FF, $FF ; id 114
    db $FF, $FF ; id 115
    db $FF, $FF ; id 116
    db $FF, $FF ; id 117
    db $FF, $FF ; id 118
    db $FF, $FF ; id 119
    db $FF, $FF ; id 120
    db $FF, $FF ; id 121
    db $FF, $FF ; id 122
    db $FF, $FF ; id 123
    db $FF, $FF ; id 124
    db $FF, $FF ; id 125
    db $FF, $FF ; id 126
    db $FF, $FF ; id 127
    db $FF, $FF ; id 128
    db $FF, $FF ; id 129
    db $FF, $FF ; id 130
    db $FF, $FF ; id 131
    db $FF, $FF ; id 132
    db $FF, $FF ; id 133
    db $FF, $FF ; id 134
    db $FF, $FF ; id 135
    db $FF, $FF ; id 136
    db $FF, $FF ; id 137
    db $FF, $FF ; id 138
    db $FF, $FF ; id 139
    db $FF, $FF ; id 140
    db $FF, $FF ; id 141
    db $FF, $FF ; id 142
    db $FF, $FF ; id 143
    db $FF, $FF ; id 144
    db $FF, $FF ; id 145
    db $FF, $FF ; id 146
    db $FF, $FF ; id 147
    db $FF, $FF ; id 148
    db $FF, $FF ; id 149
    db $FF, $FF ; id 150
    db $FF, $FF ; id 151
    db $FF, $FF ; id 152
    db $FF, $FF ; id 153
    db $FF, $FF ; id 154
    db $FF, $FF ; id 155
    db $FF, $FF ; id 156
    db $FF, $FF ; id 157
    db $FF, $FF ; id 158
    db $FF, $FF ; id 159
    db $FF, $FF ; id 160
    db $FF, $FF ; id 161
    db $FF, $FF ; id 162
    db $FF, $FF ; id 163
    db $FF, $FF ; id 164
    db $FF, $FF ; id 165
    db $FF, $FF ; id 166
    db $FF, $FF ; id 167
    db $FF, $FF ; id 168
    db $FF, $FF ; id 169
    db $FF, $FF ; id 170
    db $FF, $FF ; id 171
    db $FF, $FF ; id 172
    db $FF, $FF ; id 173
    db $FF, $FF ; id 174
    db $FF, $FF ; id 175
    db $FF, $FF ; id 176
    db $FF, $FF ; id 177
    db $FF, $FF ; id 178
    db $FF, $FF ; id 179
    db $FF, $FF ; id 180
    db $FF, $FF ; id 181
    db $FF, $FF ; id 182
    db $FF, $FF ; id 183
    db $FF, $FF ; id 184
    db $FF, $FF ; id 185
    db $FF, $FF ; id 186
    db $FF, $FF ; id 187
    db $FF, $FF ; id 188
    db $FF, $FF ; id 189
    db $FF, $FF ; id 190
    db $FF, $FF ; id 191
    db $FF, $FF ; id 192
    db $FF, $FF ; id 193
    db $FF, $FF ; id 194
    db $FF, $FF ; id 195
    db $FF, $FF ; id 196
    db $FF, $FF ; id 197
    db $FF, $FF ; id 198
    db $FF, $FF ; id 199
    db $FF, $FF ; id 200
    db $FF, $FF ; id 201
    db $FF, $FF ; id 202
    db $FF, $FF ; id 203
    db $FF, $FF ; id 204
    db $FF, $FF ; id 205
    db $FF, $FF ; id 206
    db $FF, $FF ; id 207

; E-0210 (C1: SelectEffectByEffectFlags2Flags uses this table for wEffectFlags2 bit 0 (the target acts), indexed by wBattleActionId: byte 1 for a near-side actor (ActorOnLocalSide), else byte 0; a value other than $FF goes to QueueSoundEffect; 40 entries, up to the next table).
; record: sound effect for a far-side actor, for a near-side actor ($FF = none)
ActionSoundTable_Flag0::
Data_03A_60B7:: ; address name
    db $FF, $FF ; id 0
    db $85, $85 ; id 1
    db $85, $85 ; id 2
    db $85, $85 ; id 3
    db $85, $85 ; id 4
    db $85, $85 ; id 5
    db $85, $85 ; id 6
    db $85, $85 ; id 7
    db $85, $85 ; id 8
    db $85, $85 ; id 9
    db $85, $85 ; id 10
    db $85, $85 ; id 11
    db $85, $85 ; id 12
    db $FF, $FF ; id 13
    db $FF, $FF ; id 14
    db $FF, $FF ; id 15
    db $FF, $FF ; id 16
    db $FF, $FF ; id 17
    db $FF, $FF ; id 18
    db $FF, $FF ; id 19
    db $FF, $FF ; id 20
    db $FF, $FF ; id 21
    db $FF, $FF ; id 22
    db $FF, $FF ; id 23
    db $FF, $FF ; id 24
    db $FF, $FF ; id 25
    db $FF, $FF ; id 26
    db $FF, $FF ; id 27
    db $FF, $FF ; id 28
    db $FF, $FF ; id 29
    db $FF, $FF ; id 30
    db $FF, $FF ; id 31
    db $FF, $FF ; id 32
    db $FF, $FF ; id 33
    db $87, $FF ; id 34
    db $86, $FF ; id 35
    db $81, $FF ; id 36
    db $81, $FF ; id 37
    db $81, $FF ; id 38
    db $81, $FF ; id 39

; E-0210 (C1: SelectEffectByEffectFlags2Flags uses this table for wEffectFlags2 bit 2 (the target acts), indexed by wBattleActionId: byte 1 for a near-side actor (ActorOnLocalSide), else byte 0; a value other than $FF goes to QueueSoundEffect; 40 entries, up to the next table).
; record: sound effect for a far-side actor, for a near-side actor ($FF = none)
ActionSoundTable_Flag2::
Data_03A_6107:: ; address name
    db $FF, $FF ; id 0
    db $FF, $FF ; id 1
    db $FF, $FF ; id 2
    db $FF, $FF ; id 3
    db $FF, $FF ; id 4
    db $FF, $FF ; id 5
    db $FF, $FF ; id 6
    db $FF, $FF ; id 7
    db $FF, $FF ; id 8
    db $FF, $FF ; id 9
    db $FF, $FF ; id 10
    db $FF, $FF ; id 11
    db $FF, $FF ; id 12
    db $FF, $FF ; id 13
    db $FF, $FF ; id 14
    db $FF, $FF ; id 15
    db $FF, $FF ; id 16
    db $FF, $FF ; id 17
    db $FF, $FF ; id 18
    db $FF, $FF ; id 19
    db $FF, $FF ; id 20
    db $FF, $FF ; id 21
    db $FF, $FF ; id 22
    db $FF, $FF ; id 23
    db $FF, $FF ; id 24
    db $85, $FF ; id 25
    db $85, $FF ; id 26
    db $85, $FF ; id 27
    db $85, $FF ; id 28
    db $88, $88 ; id 29
    db $85, $FF ; id 30
    db $FF, $FF ; id 31
    db $FF, $FF ; id 32
    db $FF, $FF ; id 33
    db $FF, $FF ; id 34
    db $FF, $FF ; id 35
    db $93, $FF ; id 36
    db $97, $FF ; id 37
    db $96, $FF ; id 38
    db $96, $FF ; id 39

; battle fight step 3: returns while a message is being drawn; in link mode calls Func_03A_4ADB; otherwise one of 6 sub-steps by wBattleSubPhase, which execute the chosen actions through RunBattleResolveStep
; 2 call sites from 2 routines (e.g. BattleFight_Step3, RunBattlePhaseWhenTextIdle_A0_RunTurn_ToRunBattleActions)
; reads: wTextFlags, wEffectId, wLinkMode, wBattleSubPhase
RunBattleActions::
Func_03A_6157:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    call RedrawChangedSlotPanels
    ld a, [wEffectId]
    cp a, $FF
    jr z, .read_battle_sub_phase
    ld a, [wLinkMode]
    or a, a
    ret nz
    farcall RunBattleEffectAnimation
    ret

.read_battle_sub_phase:
    ld a, [wBattleSubPhase]
    rst $00
    dw RunBattleActions_ToRunBattleActions_StatusChecks
    dw RunBattleActions_ToRunBattleResolveStep
    dw RunBattleActions_LoadSkillRecord
    dw RunBattleActions_WriteBattleTargetAndBattleSubPhaseEtc
    dw RunActionSpecificPostStep
    dw RunBattleActions_ShowHeroBlewBackG
    dw RunBattleActions_CarryUnlessBattleSlotOutSlotEmpty
    dw RunBattleActions_CheckActionBDOrRun63B2And63D2
    dw RunBattleActions_ToRunBattleActions_UseItem
    dw RunBattleActions_WearOffAndDefeat
    dw RunBattleActions_SetBattlePhase

; entry 0 of the `rst $00` table in RunBattleActions
; no direct call (reached through a table, a jump or a vector)
RunBattleActions_ToRunBattleActions_StatusChecks::
Jump_03A_618C:: ; address name
    farcall RunBattleActions_StatusChecks
    ret

; entry 1 of the `rst $00` table in RunBattleActions
; no direct call (reached through a table, a jump or a vector)
RunBattleActions_ToRunBattleResolveStep::
Jump_03A_6193:: ; address name
    farcall RunBattleResolveStep
    ret

; entry 2 of the `rst $00` table in RunBattleActions
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActionId
; writes: wRecordBuffer
RunBattleActions_LoadSkillRecord::
Jump_03A_619A:: ; address name
    ld a, [wBattleActionId]
    ld [wRecordBuffer], a
    xor a, a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    call RunActionResolveStep
    ret

; entry 3 of the `rst $00` table in RunBattleActions
; no direct call (reached through a table, a jump or a vector)
; reads: wRecordBufferData, wBattleActionId, wBattleActor, wResolveFlagB2
; writes: wBattleTarget, wBattleSubPhase, wBattleResolveStep
; points at: wBattleSubPhase, wBattleStatus6, wBattleTargetChoice
RunBattleActions_WriteBattleTargetAndBattleSubPhaseEtc::
Jump_03A_61AE:: ; address name
    ld a, [wRecordBufferData + $4]
    cp a, $80
    jr z, .check_resolve_flag_b2
    and a, $0F
    cp a, $02
    jr z, .check_resolve_flag_b2
    cp a, $04
    jr z, .check_battle_action_id
    ld a, [wBattleActionId]
    cp a, $63
    jr z, .call_run_multi_hit_counter
    ld hl, wBattleSubPhase
    inc [hl]
    ret

.check_resolve_flag_b2:
    ld a, [wResolveFlagB2]
    or a, a
    jp z, RunBattleStep4_Case03_WriteBattleTargetAndBattleSubPhaseEtc
    ld hl, wBattleSubPhase
    inc [hl]
    ret

.check_battle_action_id:
    ld a, [wBattleActionId]
    cp a, $64
    jr z, .call_run_multi_hit_counter
    ld a, [wBattleActor]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, .call_roll_repeat_count_for_action
    ld hl, wBattleSubPhase
    inc [hl]
    ret

.call_roll_repeat_count_for_action:
    call RollRepeatCountForAction
    ret

.call_run_multi_hit_counter:
    call RunMultiHitCounter
    ret

; after an action: actions $4E/$4F with wDABA clear the actor's wD812 bit 0 (text $81); $B9 clears it (text $86); $D6 stores the actor in wC982; $15 and $D6 jump to resolve step $0E; otherwise wBattleSubPhase += 1 (E-0127)
; 1 call site from 1 routine (e.g. RunBattleStep4_ToRunActionSpecificPostStep)
; reads: wBattleActionId, wBattleActor, wDefeatFlagsBA
; writes: wSavedActorSlot, wSavedActorByte, wBattleSubPhase, wBattleResolveStep, wBattleSubStep
; points at: wBattleSubPhase, wBattleScreenFlags, wBattleStatus6
RunActionSpecificPostStep::
Func_03A_61F8:: ; address name
    ld a, [wBattleActionId]
    cp a, $4E
    jr z, .check_defeat_flags_ba
    cp a, $4F
    jr z, .check_defeat_flags_ba
    cp a, $B9
    jr z, .read_battle_actor
    cp a, $15
    jr z, .set_battle_sub_phase_to_01
    cp a, $D6
    jr z, .read_battle_actor2
    jr .done

.check_defeat_flags_ba:
    ld a, [wDefeatFlagsBA]
    or a, a
    jr z, .done
    ld a, [wBattleActor]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    bit 0, [hl]
    jr z, .done
    res 0, [hl]
    ld d, $81 ; battle text 'The help went away!'
    farcall ShowBattleText
    jr .done

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    res 0, [hl]
    ld d, $86 ; battle text 'The giant went away laughing!'
    farcall ShowBattleText
    jr .done

.read_battle_actor2:
    ld a, [wBattleActor]
    ld [wSavedActorSlot], a
    xor a, a
    ld [wSavedActorByte], a

.set_battle_sub_phase_to_01:
    ld a, $01
    ld [wBattleSubPhase], a
    ld a, $0E
    ld [wBattleResolveStep], a
    ld a, $00
    ld [wBattleSubStep], a
    ld hl, wBattleScreenFlags
    set 0, [hl]
    ret

.done:
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunBattleActions
; no direct call (reached through a table, a jump or a vector)
; reads: wResolveFlagB2, wBattleTarget, wBattleActor, wRecordBufferData, wActionQueuePos
; writes: wResolveFlagB2, wActionRepeatFlag, wBattleSubPhase, wBattleResolveStep, wFollowUpAction, wDefeatStep, wBattleScreenFlags, wBattleStep, ...
; points at: wBattleStatus6, wBattleStep, wBattleSubPhase, wBattleStatus4, wBattlePhase, wActionQueue, wSlotMarks, wBattleActionChoice
RunBattleActions_ShowHeroBlewBackG::
Jump_03A_6269:: ; address name
    ld a, [wResolveFlagB2]
    or a, a
    jr z, .skip
    xor a, a
    ld [wResolveFlagB2], a
    ld a, $01
    ld [wActionRepeatFlag], a
    ld a, [wBattleTarget]
    call CheckSlotStatusBlockWide_Bank3A
    jr c, .skip
    ld hl, wBattleStatus6
    call AddAx9ToHL
    bit 1, [hl]
    jr z, .skip
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ld d, $7E ; battle text '0 blew back G!'
    farcall ShowBattleText
    ret

.skip:
    ld hl, wBattleSubPhase
    inc [hl]

; entry 6 of the `rst $00` table in RunBattleActions
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wRecordBufferData, wActionQueuePos
; writes: wFollowUpAction, wDefeatStep, wBattleScreenFlags, wBattleStep, wBattleSubPhase, wBattleResolveStep, wActionQueuePos, wBattleSubStep, ...
; points at: wBattleStatus4, wBattleSubPhase, wBattlePhase, wActionQueue, wSlotMarks, wBattleActionChoice
RunBattleActions_CarryUnlessBattleSlotOutSlotEmpty::
Jump_03A_62A3:: ; address name
    ld a, [wBattleActor]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    ld hl, wBattleStatus4
    call AddAx9ToHL
    bit 6, [hl]
    jr z, .skip
    res 6, [hl]
    ld a, [wRecordBufferData + $7]
    bit 4, a
    jr z, .skip
    call CheckActionBDOrRun63B2And63D2
    jr nc, .clear_effect_flags
    jr .skip

.clear_effect_flags:
    xor a, a
    ld [wEffectFlags], a
    ld a, $FF
    ld [wEffectId], a
    xor a, a
    ld [wDefeatFlagsBA], a
    xor a, a
    ld [wDefeatByteBF], a
    xor a, a
    ld [wFollowUpAction], a
    ld a, $FF
    ld [wDefeatByteD1], a
    xor a, a
    ld [wBattleSubPhase], a
    ld a, $01
    ld [wBattleResolveStep], a
    ld a, $04
    ld [wBattleSubStep], a
    xor a, a
    ld [wDefeatFlagsBA], a
    farcall ChooseTargetForActor
    ld a, d
    ld [wBattleTarget], a
    ret

.skip:
    ld hl, wBattleSubPhase
    inc [hl]

; entry 7 of the `rst $00` table in RunBattleActions
; no direct call (reached through a table, a jump or a vector)
; reads: wActionQueuePos, wBattleActor
; writes: wFollowUpAction, wDefeatStep, wBattleScreenFlags, wBattleStep, wBattleSubPhase, wBattleResolveStep, wActionQueuePos, wBattleSubStep
; points at: wBattlePhase, wActionQueue, wSlotMarks, wBattleActionChoice, wBattleStatus4
RunBattleActions_CheckActionBDOrRun63B2And63D2::
Jump_03A_6300:: ; address name
    xor a, a
    ld [wFollowUpAction], a
    xor a, a
    ld [wDefeatStep], a
    xor a, a
    ld [wBattleScreenFlags], a
    call CheckActionBDOrRun63B2And63D2
    jr nc, .read_action_queue_pos
    ld hl, wBattlePhase
    inc [hl]
    xor a, a
    ld [wBattleStep], a
    xor a, a
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

.read_action_queue_pos:
    ld a, [wActionQueuePos]
    ld hl, wActionQueue
    add_a_to_hl
    ld a, [hl]
    cp a, $10
    jr z, .loop
    ld a, [wBattleActor]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $03
    push hl
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    add a, a
    add_a_to_hl
    ld a, [hl]
    cp a, $CC
    jr nz, .check_action_queue_pos
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    and a, $F3
    ld [hl], a

.check_action_queue_pos:
    pop hl

.loop:
    ld a, [wActionQueuePos]
    inc a
    ld [wActionQueuePos], a
    cp a, $09
    jr nc, .set_battle_sub_phase_to_09
    ld a, [wActionQueuePos]
    ld hl, wActionQueue
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jr z, .set_battle_sub_phase_to_09
    cp a, $10
    jr z, .clear_battle_sub_phase
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .loop

.clear_battle_sub_phase:
    xor a, a
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    ret

.set_battle_sub_phase_to_09:
    ld a, $09
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

; returns A = 0 for action $BD while wDABA & $7F is non-zero; otherwise runs Func_03A_63B2 and, without carry, Func_03A_63D2 (E-0122)
; 5 call sites from 5 routines (e.g. RunBattleActions_CheckActionBDOrRun63B2And63D2, RunBattleActions_CarryUnlessBattleSlotOutSlotEmpty, RunBattleActions_WearOffAndDefeat_ShowHeroDroppedDead, RunActionResolveStep_CheckActionBDOrRun63B2And63D2_Case08, ...)
; reads: wBattleActionId, wDefeatFlagsBA
CheckActionBDOrRun63B2And63D2::
Func_03A_639A:: ; address name
    ld a, [wBattleActionId]
    cp a, $BD
    jr nz, .call_check_action_bd_or_run63_b2_and63_d2
    ld a, [wDefeatFlagsBA]
    and a, $7F
    jr z, .call_check_action_bd_or_run63_b2_and63_d2
    xor a, a
    ret

.call_check_action_bd_or_run63_b2_and63_d2:
    call CheckActionBDOrRun63B2And63D2_SlotPresentWithStatus0Bit6
    ret c
    call CheckActionBDOrRun63B2And63D2_CarryUnlessBattleSlotOutSlotEmpty
    ret

; only called from CheckActionBDOrRun63B2And63D2 (E-0047)
; 1 call site from 1 routine (e.g. CheckActionBDOrRun63B2And63D2)
; reads: wLinkMode, wLinkRole
CheckActionBDOrRun63B2And63D2_SlotPresentWithStatus0Bit6::
Func_03A_63B2:: ; address name
    ld c, $00
    ld a, [wLinkMode]
    cp a, $01
    jr nz, CheckActionBDOrRun63B2And63D2_SlotPresentWithStatus0Bit6_CallSlotPresentWithStatus0Bit6
    ld a, [wLinkRole]
    bit 1, a
    jr z, CheckActionBDOrRun63B2And63D2_SlotPresentWithStatus0Bit6_CallSlotPresentWithStatus0Bit6
    ld c, $04

CheckActionBDOrRun63B2And63D2_SlotPresentWithStatus0Bit6_CallSlotPresentWithStatus0Bit6::
Jump_03A_63C4:: ; address name
    call SlotPresentWithStatus0Bit6
    ret nc
    inc c
    call SlotPresentWithStatus0Bit6
    ret nc
    inc c
    call SlotPresentWithStatus0Bit6
    ret

; only called from CheckActionBDOrRun63B2And63D2 (E-0047)
; 1 call site from 1 routine (e.g. CheckActionBDOrRun63B2And63D2)
; reads: wLinkMode, wLinkRole
CheckActionBDOrRun63B2And63D2_CarryUnlessBattleSlotOutSlotEmpty::
Func_03A_63D2:: ; address name
    ld c, $04
    ld a, [wLinkMode]
    cp a, $01
    jr nz, .call_carry_unless_battle_slot_out_slot_empty
    ld a, [wLinkRole]
    bit 1, a
    jr z, CheckActionBDOrRun63B2And63D2_SlotPresentWithStatus0Bit6_CallSlotPresentWithStatus0Bit6
    ld c, $00
    jr CheckActionBDOrRun63B2And63D2_SlotPresentWithStatus0Bit6_CallSlotPresentWithStatus0Bit6

.call_carry_unless_battle_slot_out_slot_empty:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    ret nc
    inc c
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    ret nc
    inc c
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    ret

; C = slot: carry set when the slot is present and its status byte 0 bit 6 is set, else carry clear (E-0118)
; 3 call sites from 1 routine (e.g. CheckActionBDOrRun63B2And63D2_SlotPresentWithStatus0Bit6)
; points at: wBattleStatus
SlotPresentWithStatus0Bit6::
Func_03A_63F7:: ; address name
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    ret c
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit 6, [hl]
    ret z
    scf
    ret

; entry 8 of the `rst $00` table in RunBattleActions
; no direct call (reached through a table, a jump or a vector)
RunBattleActions_ToRunBattleActions_UseItem::
Jump_03A_6408:: ; address name
    farcall RunBattleActions_UseItem
    ret

; by wBattleResolveStep: battle texts "0's Ironize wore off!" and '0 dropped dead!'
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleResolveStep
RunBattleActions_WearOffAndDefeat::
Jump_03A_640F:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw RunBattleActions_WearOffAndDefeat_WriteBattleActorAndBattleResolveStep
    dw RunBattleActions_WearOffAndDefeat_ShowHeroSIronizeWore
    dw RunBattleActions_WearOffAndDefeat_AddAx9ToHL
    dw RunBattleActions_WearOffAndDefeat_ShowHeroDroppedDead
    dw RunBattleActions_WearOffAndDefeat_CarryUnlessBattleSlotOutSlotEmpty
    dw RunBattleActions_WearOffAndDefeat_WaitTextFlags
    dw RunBattleActions_WearOffAndDefeat_QueueMusic

; entry 0 of the `rst $00` table in RunBattleActions_WearOffAndDefeat
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleActor, wBattleResolveStep
; points at: wBattleResolveStep, wSideFlags0, wSlotPairBytes, wBattleStatus
RunBattleActions_WearOffAndDefeat_WriteBattleActorAndBattleResolveStep::
Jump_03A_6421:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wSideFlags0
    ld a, [hl]
    and a, $AF
    ld [hl+], a
    ld a, [hl]
    and a, $AF
    ld [hl], a
    ld hl, wSlotPairBytes
    ld a, [hl]
    and a, $03
    ld [hl+], a
    ld a, [hl]
    and a, $03
    ld [hl], a
    ld b, $09
    ld hl, wBattleStatus

.loop:
    inc hl
    inc hl
    inc hl
    inc hl
    ld a, [hl]
    rrca
    and a, $55
    ld [hl+], a
    ld a, [hl]
    and a, $30
    jr z, .next
    ld a, [hl]
    and a, $CF
    ld e, a
    ld a, [hl]
    rrca
    and a, $10
    or a, e
    ld [hl], a

.next:
    inc hl
    ld a, [hl]
    and a, $C0
    ld [hl+], a
    xor a, a
    ld [hl+], a
    ld a, [hl]
    and a, $03
    jr z, .next2
    ld a, [hl]
    and a, $FC
    ld e, a
    ld a, [hl]
    rrca
    and a, $01
    or a, e
    ld [hl], a

.next2:
    inc hl
    dec b
    jr nz, .loop
    xor a, a
    ld [wBattleActor], a
    call CarryUnlessBattleSlotOutSlotEmpty
    ret nc
    ld a, $04
    ld [wBattleResolveStep], a
    ret

; entry 1 of the `rst $00` table in RunBattleActions_WearOffAndDefeat
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wBattleResolveStep
; points at: wBattleResolveStep, wBattleStatus5
RunBattleActions_WearOffAndDefeat_ShowHeroSIronizeWore::
Jump_03A_6480:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleActor]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    and a, $3F
    ld d, a
    ld a, [hl]
    and a, $C0
    jr z, .return
    push hl
    push de
    sub a, $40
    jr nz, .restore
    ld d, $84 ; battle text '0's Ironize wore off!'
    farcall ShowBattleText
    xor a, a

.restore:
    pop de
    pop hl
    or a, d
    ld [hl], a
    ld a, $04
    ld [wBattleResolveStep], a

.return:
    ret

; entry 2 of the `rst $00` table in RunBattleActions_WearOffAndDefeat
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleArg0, wLoadSlot
; writes: wBattleArg0, wBattleTarget
; points at: wBattleResolveStep, wBattleStatus
RunBattleActions_WearOffAndDefeat_AddAx9ToHL::
Jump_03A_64AF:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $03
    ret z
    bit 0, a
    jr nz, .set_battle_arg0_to_88
    ld b, $06
    ld a, $89
    ld [wBattleArg0], a
    jr .read_battle_actor

.set_battle_arg0_to_88:
    ld b, $10
    ld a, $88
    ld [wBattleArg0], a

.read_battle_actor:
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    call RunBattleActions_WearOffAndDefeat_Case02_GetBattleMaxHP_Bank3A
    call RunBattleActions_WearOffAndDefeat_Case02_AddDoubleAToHL_Bank3A
    ld a, [wBattleArg0]
    ld d, a
    farcall ShowBattleText
    ld a, [wLoadSlot]
    or a, a
    ret z
    ld hl, wBattleResolveStep
    dec [hl]
    ret

; only called from RunBattleActions_WearOffAndDefeat_Case02 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleActions_WearOffAndDefeat_AddAx9ToHL)
; reads: wBattleActor
; writes: wBattleDamageLo, wBattleDamageHi
RunBattleActions_WearOffAndDefeat_Case02_GetBattleMaxHP_Bank3A::
Func_03A_64F8:: ; address name
    push bc
    ld a, [wBattleActor]
    call GetBattleMaxHP_Bank3A
    ld a, b
    call DivideHLByA
    ld a, h
    or a, l
    jr nz, .restore
    ld hl, $0001

.restore:
    pop bc
    ld a, b
    cp a, $06
    jr z, .skip2
    ld a, h
    or a, a
    jr nz, .skip
    ld a, l
    cp a, $32
    jr c, .set_battle_damage_lo2

.skip:
    ld hl, $0032
    jr .set_battle_damage_lo2

.skip2:
    ld a, h
    or a, a
    jr nz, .set_battle_damage_lo
    ld a, l
    cp a, $96
    jr c, .set_battle_damage_lo2

.set_battle_damage_lo:
    ld hl, $0096

.set_battle_damage_lo2:
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ret

; only called from RunBattleActions_WearOffAndDefeat_Case02 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleActions_WearOffAndDefeat_AddAx9ToHL)
; reads: wBattleActor, wBattleDamageLo, wBattleDamageHi, wBattleArg0
; writes: wLoadSlot, wBattleArg0, wDefeatStep
; points at: wBattleHP
RunBattleActions_WearOffAndDefeat_Case02_AddDoubleAToHL_Bank3A::
Func_03A_6533:: ; address name
    xor a, a
    ld [wLoadSlot], a
    ld a, [wBattleActor]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank3A
    ld a, [hl+]
    ld d, [hl]
    ld e, a
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    ld a, e
    sub a, c
    ld e, a
    ld a, d
    sbc a, b
    ld d, a
    jr c, .skip
    ld a, d
    ld [hl-], a
    ld [hl], e
    or a, e
    jr nz, .read_battle_actor
    inc hl

.skip:
    ld a, [hl-]
    ld b, a
    ld c, [hl]
    xor a, a
    ld [hl+], a
    ld [hl], a
    ld a, [wBattleActor]
    call SetBit2OfLevelUpGainsIndexed_Bank3A
    ld a, [wBattleArg0]
    push af
    farcall DefeatTarget
    pop af
    ld [wBattleArg0], a
    xor a, a
    ld [wDefeatStep], a
    ld a, $01
    ld [wLoadSlot], a

.read_battle_actor:
    ld a, [wBattleActor]
    call SetBit0OfLevelUpGainsIndexed_Bank3A
    ret

; entry 3 of the `rst $00` table in RunBattleActions_WearOffAndDefeat
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleSubPhase, wBattleResolveStep
; points at: wBattleResolveStep
RunBattleActions_WearOffAndDefeat_ShowHeroDroppedDead::
Jump_03A_6584:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    farcall BlankTargetMonsterPicture
    ld d, $90 ; battle text '0 dropped dead!'
    farcall ShowBattleText
    call CheckActionBDOrRun63B2And63D2
    ret nc
    ld a, $0A
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

; entry 4 of the `rst $00` table in RunBattleActions_WearOffAndDefeat
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wLinkRules, wLinkRuleTurnLimit
; writes: wBattleResolveStep, wStringIndex, wStringCategory, wBattleStep, wBattleSubPhase
; points at: wBattleActor, wSlotMarks, wBattleTurn, wBattleResolveStep, wTextBuf0
RunBattleActions_WearOffAndDefeat_CarryUnlessBattleSlotOutSlotEmpty::
Jump_03A_65A4:: ; address name
    ld hl, wBattleActor
    inc [hl]
    ld a, [hl]
    cp a, $08
    jr z, .skip
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, RunBattleActions_WearOffAndDefeat_CarryUnlessBattleSlotOutSlotEmpty
    ld a, $01
    ld [wBattleResolveStep], a
    ret

.skip:
    ld hl, wSlotMarks
    ld bc, $0008
    ld a, $FF
    call FillBytes
    ld b, $03
    ld c, $00
    ld d, $00
    call SetSlotMarksForPresentSlots
    ld b, $01
    ld d, $01
    call SetSlotMarksForPresentSlots
    ld b, $03
    ld c, $04
    ld d, $00
    ld a, [wLinkMode]
    cp a, $01
    jr z, .call_set_slot_marks_for_present_slots
    ld d, $01

.call_set_slot_marks_for_present_slots:
    call SetSlotMarksForPresentSlots
    ld b, $01
    ld d, $01
    call SetSlotMarksForPresentSlots
    ld hl, wBattleTurn
    ld a, [hl]
    cp a, $FF
    jr z, .check_link_mode
    inc [hl]

.check_link_mode:
    ld a, [wLinkMode]
    or a, a
    jr z, .clear_battle_step
    cp a, $02
    jr z, .clear_battle_step
    ld a, [wLinkRules]
    or a, a
    jr z, .clear_battle_step
    ld a, [wLinkRuleTurnLimit]
    bit 7, a
    jr z, .clear_battle_step
    res 7, a
    sub a, [hl]
    jr nc, .skip2
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, $62
    jr .set_string_index

.skip2:
    inc a
    ld c, a
    ld b, $00
    ld hl, wTextBuf0
    call WriteBCAsDecimalString
    ld hl, wTextBuf0
    ld a, [hl]
    cp a, $01
    ld a, $61
    jr nz, .skip3
    ld a, $88

.skip3:
    jr .set_string_index

.clear_battle_step:
    xor a, a
    ld [wBattleStep], a
    xor a, a
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

.set_string_index:
    ld [wStringIndex], a
    xor a, a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; C = first slot, B = count, D = value: wDA5B[slot] = D for every present slot in the range (CarryUnlessBattleSlotOutSlotEmpty) (E-0113)
; 4 call sites from 1 routine (e.g. RunBattleActions_WearOffAndDefeat_CarryUnlessBattleSlotOutSlotEmpty)
; points at: wSlotMarks
SetSlotMarksForPresentSlots::
Func_03A_6650:: ; address name
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, c
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], d

.next:
    inc c
    dec b
    jr nz, SetSlotMarksForPresentSlots
    ret

; entry 5 of the `rst $00` table in RunBattleActions_WearOffAndDefeat
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wBattleStep, wBattleSubPhase, wBattleResolveStep
RunBattleActions_WearOffAndDefeat_WaitTextFlags::
Jump_03A_6665:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    xor a, a
    ld [wBattleStep], a
    xor a, a
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

; entry 6 of the `rst $00` table in RunBattleActions_WearOffAndDefeat
; no direct call (reached through a table, a jump or a vector)
; reads: wTextFlags
; writes: wBattlePhase, wBattleStep, wBattleSubPhase, wBattleResolveStep, wBattleScene
RunBattleActions_WearOffAndDefeat_QueueMusic::
Jump_03A_6677:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    ld a, $02
    ld [wBattlePhase], a
    ld a, $08
    ld [wBattleStep], a
    xor a, a
    ld [wBattleSubPhase], a
    ld [wBattleResolveStep], a
    ld a, $80
    ld [wBattleScene], a
    ld a, $42
    call QueueMusic
    ret

; entry 10 of the `rst $00` table in RunBattleActions
; no direct call (reached through a table, a jump or a vector)
; writes: wBattleStep, wBattleSubPhase, wBattleResolveStep
; points at: wBattlePhase
RunBattleActions_SetBattlePhase::
Jump_03A_6698:: ; address name
    ld hl, wBattlePhase
    inc [hl]
    xor a, a
    ld [wBattleStep], a
    xor a, a
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

; for each shown slot redraws the HP, MP and status parts flagged in bits 0-2 of wD095[slot] and clears the flags (E-0127)
; 2 call sites from 2 routines (e.g. RunBattleActions, RunBattleStep4)
; reads: wLinkMode, wLinkRole, wBattlePartyCount
; points at: wLevelUpGains
RedrawChangedSlotPanels::
Func_03A_66A9:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr nz, .read_battle_party_count
    ld a, [wLinkRole]
    bit 1, a
    jr nz, .read_battle_party_count2

.read_battle_party_count:
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $00
    jr .loop

.read_battle_party_count2:
    ld a, [wBattlePartyCount]
    ld b, a
    ld c, $04

.loop:
    push bc
    ld a, c
    ld hl, wLevelUpGains
    add_a_to_hl
    bit 0, [hl]
    jr z, .skip
    push hl
    farcall DrawSlotHPDigits
    farcall CopySlotPanelPart7AC8ToVRAM
    pop hl
    res 0, [hl]

.skip:
    bit 1, [hl]
    jr z, .skip2
    push hl
    farcall DrawSlotMPDigits
    farcall CopySlotPanelPart7ACEToVRAM
    pop hl
    res 1, [hl]

.skip2:
    bit 2, [hl]
    jr z, .restore
    push hl
    farcall DrawSlotStatusMarks
    farcall CopySlotPanelRowToVRAM
    pop hl
    res 2, [hl]

.restore:
    pop bc
    inc c
    dec b
    jr nz, .loop
    ret

; only called from RunBattleStep4_Case03 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleStep4_ReadRecordBufferDataAndBattleActionIdEtc)
; reads: wBattleActor
; writes: wBattleTarget, wBattleSubPhase, wBattleResolveStep
; points at: wBattleTargetChoice
RunBattleStep4_Case03_WriteBattleTargetAndBattleSubPhaseEtc::
Func_03A_6711:: ; address name
    call RunBattleStep4_Case03_Sub01_WriteDefeatFlagsBAAndSavedActorSlotEtc
    ret z
    ld a, c
    ld [wBattleTarget], a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld [hl], c
    ld a, $01
    ld [wBattleSubPhase], a
    ld a, $00
    ld [wBattleResolveStep], a
    ret

; only called from RunBattleStep4_Case03_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleStep4_Case03_WriteBattleTargetAndBattleSubPhaseEtc)
; reads: wDefeatFlagsBA, wBattleActionId, wBattleActor
; writes: wDefeatFlagsBA, wSavedActorSlot, wSavedActorByte, wBattleSubPhase, wBattleResolveStep, wBattleSubStep
; points at: wBattleSubPhase, wBattleScreenFlags
RunBattleStep4_Case03_Sub01_WriteDefeatFlagsBAAndSavedActorSlotEtc::
Func_03A_6731:: ; address name
    ld a, [wDefeatFlagsBA]
    bit 7, a
    jr nz, .call_run_battle_step4_case03_sub01_sub01
    call RunBattleStep4_Case03_Sub01_Sub01_CarryUnlessBattleSlotOutSlotEmpty
    ld a, [wDefeatFlagsBA]
    or a, $80
    ld [wDefeatFlagsBA], a

.call_run_battle_step4_case03_sub01_sub01:
    call RunBattleStep4_Case03_Sub01_Sub01_CarryUnlessBattleSlotOutSlotEmpty_Sub02
    ld a, [wDefeatFlagsBA]
    and a, $7F
    ret nz
    ld a, [wBattleActionId]
    cp a, $15
    jr z, .set_battle_sub_phase_to_01
    cp a, $20
    jr z, .set_battle_sub_phase_to_01
    cp a, $7B
    jr z, .set_battle_sub_phase_to_01
    cp a, $D6
    jr z, .read_battle_actor
    ld hl, wBattleSubPhase
    inc [hl]
    jr .return_0

.read_battle_actor:
    ld a, [wBattleActor]
    ld [wSavedActorSlot], a
    xor a, a
    ld [wSavedActorByte], a

.set_battle_sub_phase_to_01:
    ld a, $01
    ld [wBattleSubPhase], a
    ld a, $0E
    ld [wBattleResolveStep], a
    ld a, $00
    ld [wBattleSubStep], a
    ld hl, wBattleScreenFlags
    set 0, [hl]

.return_0:
    xor a, a
    ret

; only called from RunBattleStep4_Case03_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleStep4_Case03_Sub01_WriteDefeatFlagsBAAndSavedActorSlotEtc)
; reads: wRecordBufferData, wBattleTarget, wBattleActionId
; points at: wDefeatFlagsBA
RunBattleStep4_Case03_Sub01_Sub01_CarryUnlessBattleSlotOutSlotEmpty::
Func_03A_6785:: ; address name
    ld b, $04
    ld a, [wRecordBufferData + $4]
    cp a, $80
    jr nz, .check_battle_target
    ld b, $08

.check_battle_target:
    ld a, [wBattleTarget]
    and a, $04
    ld c, a

.loop:
    ld a, [wBattleTarget]
    cp a, c
    jr z, .skip
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .skip
    jr z, .check_record_buffer_data
    ld a, [wBattleActionId]
    cp a, $20
    jr z, .skip
    cp a, $7B
    jr z, .skip
    cp a, $CE
    jr z, .skip
    cp a, $BB
    jr z, .skip
    jr .check_record_buffer_data

.skip:
    ld hl, wDefeatFlagsBA
    inc [hl]

.check_record_buffer_data:
    inc c
    dec b
    ld a, [wRecordBufferData + $4]
    cp a, $80
    jr nz, .skip2
    ld a, b
    cp a, $04
    jr nz, .skip2
    ld a, [wBattleTarget]
    and a, $04
    xor a, $04
    ld c, a

.skip2:
    ld a, b
    or a, a
    jr nz, .loop
    ret

; only called from RunBattleStep4_Case03_Sub01_Sub01 (E-0047)
; 1 call site from 1 routine (e.g. RunBattleStep4_Case03_Sub01_WriteDefeatFlagsBAAndSavedActorSlotEtc)
; reads: wBattleTarget, wRecordBufferData, wBattleActionId
; points at: wDefeatFlagsBA
RunBattleStep4_Case03_Sub01_Sub01_CarryUnlessBattleSlotOutSlotEmpty_Sub02::
Func_03A_67D8:: ; address name
    ld a, [wBattleTarget]
    inc a
    ld c, a
    ld hl, wDefeatFlagsBA
    dec [hl]
    ld a, [hl]
    and a, $7F
    ret z

.check_record_buffer_data:
    ld a, [wRecordBufferData + $4]
    cp a, $80
    jr nz, .call_carry_unless_battle_slot_out_slot_empty
    ld a, c
    and a, $03
    jr nz, .call_carry_unless_battle_slot_out_slot_empty
    ld a, [wBattleTarget]
    and a, $04
    xor a, $04
    ld c, a
    jr nz, .call_carry_unless_battle_slot_out_slot_empty

.call_carry_unless_battle_slot_out_slot_empty:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    ret nc
    jr z, .next
    ld a, [wBattleActionId]
    cp a, $20
    ret z
    cp a, $7B
    ret z
    cp a, $CE
    ret z
    cp a, $BB
    ret z

.next:
    inc c
    jr .check_record_buffer_data

; unless bit 7 of wDABA is set, rolls 1-4 (1-3 for foes outside link battles; doubled for action other than $4E) into wDABA with bit 7 set (E-0126)
; 2 call sites from 2 routines (e.g. RunBattleStep4_ReadRecordBufferDataAndBattleActionIdEtc, RunBattleActions_WriteBattleTargetAndBattleSubPhaseEtc)
; reads: wDefeatFlagsBA, wLinkMode, wBattleActor, wBattleActionId, wBattleTarget
; writes: wDefeatFlagsBA, wBattleTarget, wBattleSubPhase, wBattleResolveStep
; points at: wDefeatFlagsBA, wSideControl, wBattleSubPhase
RollRepeatCountForAction::
Func_03A_6814:: ; address name
    ld a, [wDefeatFlagsBA]
    bit 7, a
    jp nz, RunMultiHitCounter_Skip
    ld hl, $0001
    ld bc, $0004
    ld a, [wLinkMode]
    cp a, $01
    jr z, .check_battle_action_id
    ld a, [wBattleActor]
    cp a, $04
    jr c, .check_battle_action_id
    ld c, $03

.check_battle_action_id:
    ld a, [wBattleActionId]
    cp a, $4E
    jr z, .call_random_in_range
    sla c

.call_random_in_range:
    call RandomInRange
    ld a, e
    or a, $80
    ld [wDefeatFlagsBA], a
    jr RunMultiHitCounter_CallChooseTargetForActor

; sets up and counts down the multi-hit counter in wDABA (1 or 3 hits for action $63), choosing a new target for $63 when the old one is gone (E-0128)
; 2 call sites from 2 routines (e.g. RunBattleStep4_ReadRecordBufferDataAndBattleActionIdEtc, RunBattleActions_WriteBattleTargetAndBattleSubPhaseEtc)
; reads: wBattleActor, wDefeatFlagsBA, wBattleActionId, wBattleTarget
; writes: wDefeatFlagsBA, wBattleSubPhase, wBattleResolveStep, wBattleTarget
; points at: wBattleSubPhase, wSideControl, wDefeatFlagsBA
RunMultiHitCounter::
Func_03A_6846:: ; address name
    ld a, [wBattleActor]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .check_defeat_flags_ba
    ld a, $80
    ld [wDefeatFlagsBA], a
    jr RunMultiHitCounter_Done

.check_defeat_flags_ba:
    ld a, [wDefeatFlagsBA]
    bit 7, a
    jp nz, RunMultiHitCounter_Skip
    ld a, [wBattleActionId]
    cp a, $63
    ld a, $81
    jr z, .set_defeat_flags_ba
    ld a, $83

.set_defeat_flags_ba:
    ld [wDefeatFlagsBA], a
    jr nz, RunMultiHitCounter_ReadBattleActor
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, RunMultiHitCounter_SetBattleSubPhaseTo01
    jr RunMultiHitCounter_Done

RunMultiHitCounter_Skip::
Jump_03A_6877:: ; address name
    ld hl, wDefeatFlagsBA
    dec [hl]
    ld a, [hl]
    and a, $7F
    jr z, RunMultiHitCounter_Done
    ld a, [wBattleActionId]
    cp a, $63
    jr nz, RunMultiHitCounter_ReadBattleActor
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, RunMultiHitCounter_SetBattleSubPhaseTo01

RunMultiHitCounter_CallChooseTargetForActor::
Jump_03A_688F:: ; address name
    farcall ChooseTargetForActor
    ld a, d
    ld [wBattleTarget], a

RunMultiHitCounter_SetBattleSubPhaseTo01::
Jump_03A_6899:: ; address name
    ld a, $01
    ld [wBattleSubPhase], a
    ld a, $01
    ld [wBattleResolveStep], a
    ret

RunMultiHitCounter_Done::
Jump_03A_68A4:: ; address name
    ld hl, wBattleSubPhase
    inc [hl]
    ret

RunMultiHitCounter_ReadBattleActor::
Jump_03A_68A9:: ; address name
    ld a, [wBattleActor]
    ld hl, wSideControl
    add_a_to_hl
    push hl
    ld a, [hl]
    push af
    or a, $80
    ld [hl], a
    farcall ChooseTargetForActor
    ld a, d
    ld [wBattleTarget], a
    pop af
    pop hl
    ld [hl], a
    jr RunMultiHitCounter_SetBattleSubPhaseTo01

; battle fight step 4: the same prologue as RunBattleActions, then its own sub-steps (not seen in the first battle)
; 2 call sites from 2 routines (e.g. BattleFight_Step4, RunBattlePhaseWhenTextIdle_A0_RunTurn_ToRunBattleStep4)
; reads: wTextFlags, wEffectId, wLinkMode, wBattleSubPhase
RunBattleStep4::
Func_03A_68C9:: ; address name
    ld a, [wTextFlags]
    or a, a
    ret nz
    call RedrawChangedSlotPanels
    ld a, [wEffectId]
    cp a, $FF
    jr z, .read_battle_sub_phase
    ld a, [wLinkMode]
    or a, a
    ret nz
    farcall RunBattleEffectAnimation
    ret

.read_battle_sub_phase:
    ld a, [wBattleSubPhase]
    rst $00
    dw RunBattleStep4_ToRunBattleStep4_ResolveSkill
    dw RunBattleStep4_ToRunBattleResolveStep
    dw RunBattleStep4_ToRunActionResolveStep
    dw RunBattleStep4_ReadRecordBufferDataAndBattleActionIdEtc
    dw RunBattleStep4_ToRunActionSpecificPostStep
    dw RunBattleStep4_WriteBattleActorAndBattleTargetEtc

; entry 0 of the `rst $00` table in RunBattleStep4
; no direct call (reached through a table, a jump or a vector)
RunBattleStep4_ToRunBattleStep4_ResolveSkill::
Jump_03A_68F4:: ; address name
    farcall RunBattleStep4_ResolveSkill
    ret

; entry 1 of the `rst $00` table in RunBattleStep4
; no direct call (reached through a table, a jump or a vector)
RunBattleStep4_ToRunBattleResolveStep::
Jump_03A_68FB:: ; address name
    farcall RunBattleResolveStep
    ret

; entry 2 of the `rst $00` table in RunBattleStep4
; no direct call (reached through a table, a jump or a vector)
RunBattleStep4_ToRunActionResolveStep::
Jump_03A_6902:: ; address name
    call RunActionResolveStep
    ret

; entry 3 of the `rst $00` table in RunBattleStep4
; no direct call (reached through a table, a jump or a vector)
; reads: wRecordBufferData, wBattleActionId, wBattleActor
; points at: wBattleSubPhase, wBattleStatus6
RunBattleStep4_ReadRecordBufferDataAndBattleActionIdEtc::
Jump_03A_6906:: ; address name
    ld a, [wRecordBufferData + $4]
    and a, $0F
    cp a, $02
    jr z, .call_run_battle_step4_case03_write_battle
    cp a, $04
    jr z, .check_battle_action_id
    ld a, [wBattleActionId]
    cp a, $63
    jr z, .call_run_multi_hit_counter
    ld hl, wBattleSubPhase
    inc [hl]
    ret

.call_run_battle_step4_case03_write_battle:
    call RunBattleStep4_Case03_WriteBattleTargetAndBattleSubPhaseEtc
    ret

.check_battle_action_id:
    ld a, [wBattleActionId]
    cp a, $64
    jr z, .call_run_multi_hit_counter
    ld a, [wBattleActor]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    bit 0, [hl]
    jr nz, .call_roll_repeat_count_for_action
    ld hl, wBattleSubPhase
    inc [hl]
    ret

.call_roll_repeat_count_for_action:
    call RollRepeatCountForAction
    ret

.call_run_multi_hit_counter:
    call RunMultiHitCounter
    ret

; entry 4 of the `rst $00` table in RunBattleStep4
; no direct call (reached through a table, a jump or a vector)
RunBattleStep4_ToRunActionSpecificPostStep::
Jump_03A_6944:: ; address name
    call RunActionSpecificPostStep
    ret

; entry 5 of the `rst $00` table in RunBattleStep4
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor, wBattleTarget, wActionRepeatFlag
; writes: wBattleActor, wBattleTarget, wDefeatFlagsBA, wFollowUpAction, wBattleSubPhase, wBattleResolveStep, wBattleSubStep, wActionRepeatFlag
; points at: wSavedActorTarget, wBattleActionChoice, wSlotMarks, wBattleStep
RunBattleStep4_WriteBattleActorAndBattleTargetEtc::
Jump_03A_6948:: ; address name
    ld hl, wSavedActorTarget
    ld a, [hl+]
    ld [wBattleActor], a
    ld a, [hl+]
    ld [wBattleTarget], a
    ld a, [hl+]
    ld [wDefeatFlagsBA], a
    ld a, [wBattleActor]
    ld de, wBattleActionChoice
    add a, a
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ld a, [wBattleTarget]
    ld de, wBattleActionChoice
    add a, a
    add a, e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ld a, [wBattleTarget]
    ld de, wSlotMarks
    add a, e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [hl]
    ld [de], a
    xor a, a
    ld [wFollowUpAction], a
    ld hl, wBattleStep
    dec [hl]
    ld a, $03
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    ld a, [wActionRepeatFlag]
    or a, a
    ret z
    xor a, a
    ld [wActionRepeatFlag], a
    ld a, $06
    ld [wBattleSubPhase], a
    ret

; runs the routine for wBattleResolveStep (jump table of ten) (E-0122)
; 2 call sites from 2 routines (e.g. RunBattleStep4_ToRunActionResolveStep, RunBattleActions_LoadSkillRecord)
; reads: wBattleResolveStep
RunActionResolveStep::
Func_03A_69AA:: ; address name
    ld a, [wBattleResolveStep]
    rst $00
    dw RunActionResolveStep_CarryUnlessBattleSlotOutSlotEmpty
    dw RunActionResolveStep_CarryUnlessBattleSlotOutSlotEmpty_Case01
    dw RunActionResolveStep_SetBit2OfLevelUpGainsIndexed_Bank3A
    dw RunActionResolveStep_CheckActionBDOrRun63B2And63D2
    dw RunActionResolveStep_CarryUnlessBattleSlotOutSlotEmpty_Case04
    dw RunActionResolveStep_ToRunBattleSubStep_6662
    dw RunActionResolveStep_AddDoubleAToHL_Bank3A
    dw RunActionResolveStep_RunDefeatStepMinus1Step
    dw RunActionResolveStep_CheckActionBDOrRun63B2And63D2_Case08
    dw RunActionResolveStep_Case09_CheckSlotStatusBlockWide_Bank3A_Case09

; entry 0 of the `rst $00` table in RunActionResolveStep
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wRecordBufferData, wFollowUpAction, wResolveMsgFlags, wBattleDamageLo, wBattleDamageHi, wBattleActor, wEffectFlags, ...
; writes: wBattleDamageLo, wBattleDamageHi, wBattleArg0, wEffectFlags, wBattleSubStep, wBattleTarget, wBattleActor
; points at: wBattleResolveStep, wBattleStatus2, wBattleMP, wBattleStatus, wSlotMarks, wBattleStatus7, wSlotFlags854, wBattleActor
RunActionResolveStep_CarryUnlessBattleSlotOutSlotEmpty::
Jump_03A_69C2:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit 0, [hl]
    jp z, RunActionResolveStep_CarryUnlessBattleSlotOutSlotEmpty_Case01
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jp c, RunActionResolveStep_CarryUnlessBattleSlotOutSlotEmpty_Case01
    ld a, [wRecordBufferData + $7]
    bit 0, a
    jr z, RunActionResolveStep_CarryUnlessBattleSlotOutSlotEmpty_Case01
    ld a, [wFollowUpAction]
    bit 2, a
    jr z, .read_battle_target
    ld a, [wResolveMsgFlags]
    bit 4, a
    jr z, RunActionResolveStep_CarryUnlessBattleSlotOutSlotEmpty_Case01

.read_battle_target:
    ld a, [wBattleTarget]
    call GetBattleMaxMP_Bank3A
    push hl
    ld a, [wBattleTarget]
    call GetBattleMP_Bank3A
    pop bc
    call CompareHLToBC
    jr z, RunActionResolveStep_CarryUnlessBattleSlotOutSlotEmpty_Case01
    ld a, [wBattleDamageLo]
    ld e, a
    ld a, [wBattleDamageHi]
    ld d, a
    push de
    ld a, [wRecordBufferData]
    ld e, a
    ld d, $00
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a
    add hl, de
    call CompareHLToBC
    jr c, .read_battle_target2
    jr z, .read_battle_target2
    ld a, l
    sub a, c
    ld l, a
    ld a, h
    sbc a, b
    ld h, a
    ld a, e
    sub a, l
    ld e, a
    ld a, d
    sbc a, h
    ld d, a
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a
    ld h, b
    ld l, c

.read_battle_target2:
    push hl
    ld a, [wBattleTarget]
    ld hl, wBattleMP
    call AddDoubleAToHL_Bank3A
    pop bc
    ld [hl], c
    inc hl
    ld [hl], b
    ld a, [wBattleTarget]
    call SetBit1OfLevelUpGainsIndexed_Bank3A
    ld d, $40 ; battle text '0 stole GMP!'
    farcall ShowBattleText
    pop de
    ld a, e
    ld [wBattleDamageLo], a
    ld a, d
    ld [wBattleDamageHi], a
    ret

; entry 1 of the `rst $00` table in RunActionResolveStep
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wRecordBufferData, wResolveMsgFlags, wFollowUpAction, wBattleActor, wBattleDamageLo, wBattleDamageHi, wEffectFlags, ...
; writes: wBattleArg0, wBattleDamageLo, wBattleDamageHi, wEffectFlags, wBattleSubStep, wBattleTarget, wBattleActor
; points at: wBattleResolveStep, wBattleStatus, wSlotMarks, wBattleStatus7, wSlotFlags854, wBattleActor
RunActionResolveStep_CarryUnlessBattleSlotOutSlotEmpty_Case01::
Jump_03A_6A60:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    ld a, [wRecordBufferData + $7]
    bit 3, a
    jr z, .skip
    ld a, [wResolveMsgFlags]
    bit 4, a
    jr z, .skip
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and a, $90
    jr z, .skip
    push hl
    call AdvanceRandom
    call RollRandomBelowTargetThreshold
    pop hl
    jr nc, .skip
    bit 7, [hl]
    jr z, RunActionResolveStep_SetBit2OfLevelUpGainsIndexed_Bank3A
    ld a, [hl]
    and a, $73
    ld [hl], a
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $03
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank3A
    ld d, $82 ; battle text '0 woke up!'
    farcall ShowBattleText
    ret

.skip:
    ld hl, wBattleResolveStep
    inc [hl]
    jr RunActionResolveStep_CheckActionBDOrRun63B2And63D2

; entry 2 of the `rst $00` table in RunActionResolveStep
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wFollowUpAction, wRecordBufferData, wBattleActor, wResolveMsgFlags, wBattleDamageLo, wBattleDamageHi, wEffectFlags, ...
; writes: wBattleArg0, wBattleDamageLo, wBattleDamageHi, wEffectFlags, wBattleSubStep, wBattleTarget, wBattleActor
; points at: wBattleResolveStep, wBattleStatus, wSlotMarks, wBattleStatus7, wSlotFlags854, wBattleActor
RunActionResolveStep_SetBit2OfLevelUpGainsIndexed_Bank3A::
Jump_03A_6ABC:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    bit 4, [hl]
    jr z, RunActionResolveStep_CheckActionBDOrRun63B2And63D2
    res 4, [hl]
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $03
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank3A
    ld d, $83 ; battle text '0 snapped out of confusion!'
    farcall ShowBattleText
    ret

; entry 3 of the `rst $00` table in RunActionResolveStep
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowUpAction, wBattleTarget, wRecordBufferData, wBattleActor, wResolveMsgFlags, wBattleDamageLo, wBattleDamageHi, wEffectFlags, ...
; writes: wBattleArg0, wBattleDamageLo, wBattleDamageHi, wEffectFlags, wBattleSubStep, wBattleTarget, wBattleActor
; points at: wBattleResolveStep, wBattleStatus7, wSlotFlags854, wBattleActor
RunActionResolveStep_CheckActionBDOrRun63B2And63D2::
Jump_03A_6AEC:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    call CheckActionBDOrRun63B2And63D2
    jr nc, RunActionResolveStep_CarryUnlessBattleSlotOutSlotEmpty_Case04
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 4 of the `rst $00` table in RunActionResolveStep
; no direct call (reached through a table, a jump or a vector)
; reads: wFollowUpAction, wBattleTarget, wRecordBufferData, wBattleActor, wResolveMsgFlags, wBattleDamageLo, wBattleDamageHi, wEffectFlags, ...
; writes: wBattleArg0, wBattleDamageLo, wBattleDamageHi, wEffectFlags, wBattleSubStep, wBattleTarget, wBattleActor
; points at: wBattleStatus7, wSlotFlags854, wBattleActor, wBattleResolveStep
RunActionResolveStep_CarryUnlessBattleSlotOutSlotEmpty_Case04::
Jump_03A_6AFE:: ; address name
    ld a, [wFollowUpAction]
    or a, a
    jp nz, .skip4
    ld a, [wBattleTarget]
    ld hl, wBattleStatus7
    call AddAx9ToHL
    bit 2, [hl]
    jp z, .skip4
    ld a, [wRecordBufferData + $5]
    bit 7, a
    jp z, .skip4
    ld a, [wBattleActor]
    call CarryUnlessBattleSlotOutSlotEmpty
    jp c, .skip4
    ld a, [wBattleTarget]
    call CheckSlotStatusBlock
    jp c, .skip4
    ld a, [wResolveMsgFlags]
    bit 4, a
    jp z, .skip4
    ld a, [wBattleTarget]
    ld hl, wSlotFlags854
    call AddDoubleAToHL_Bank3A
    ld a, [hl]
    and a, $08
    ld [wBattleArg0], a
    push hl
    ld a, [wBattleTarget]
    ld hl, wBattleStatus7
    call AddAx9ToHL
    bit 3, [hl]
    jr z, .read_battle_damage_lo
    pop hl
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    add hl, hl
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    jr .skip

.read_battle_damage_lo:
    pop hl
    ld a, [wBattleDamageLo]
    ld l, a
    ld a, [wBattleDamageHi]
    ld h, a
    srl h
    rr l
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a

.skip:
    ld a, h
    or a, l
    jr z, .set_effect_flags_to_10
    ld a, $11
    ld [wEffectFlags], a
    jr .skip2

.set_effect_flags_to_10:
    ld a, $10
    ld [wEffectFlags], a

.skip2:
    ld hl, wBattleActor
    ld a, [hl+]
    push af
    ld a, [hl-]
    ld [hl+], a
    pop af
    ld [hl], a
    ld a, [wEffectFlags]
    bit 0, a
    jr z, .call_show_battle_text
    ld a, [wBattleArg0]
    or a, a
    jr z, .call_advance_random
    ld d, $31
    farcall ShowBattleTextCategory0
    jr .skip3

.call_advance_random:
    call AdvanceRandom
    ld a, [wRandomLo]
    and a, $01
    jr nz, .call_show_battle_text
    ld d, $7C
    jr .call_show_battle_text2

.call_show_battle_text:
    ld d, $7D ; battle text '0 couldn't retaliate!'

.call_show_battle_text2:
    farcall ShowBattleText
    ld a, [wEffectFlags]
    bit 0, a
    jr z, .read_battle_actor
    ld a, [wRandomLo]
    and a, $01
    jr nz, .read_battle_actor

.skip3:
    ld hl, wBattleResolveStep
    inc [hl]
    xor a, a
    ld [wBattleSubStep], a
    ret

.read_battle_actor:
    ld a, [wBattleActor]
    ld l, a
    ld a, [wBattleTarget]
    ld h, a
    ld a, l
    ld [wBattleTarget], a
    ld a, h
    ld [wBattleActor], a

.skip4:
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 5 of the `rst $00` table in RunActionResolveStep
; no direct call (reached through a table, a jump or a vector)
RunActionResolveStep_ToRunBattleSubStep_6662::
Jump_03A_6BF1:: ; address name
    farcall RunBattleSubStep_6662
    ret

; entry 6 of the `rst $00` table in RunActionResolveStep
; no direct call (reached through a table, a jump or a vector)
; reads: wDefeatByteD1, wBattleActor, wBattleStep, wFollowUpAction, wBattleTarget, wDefeatStep
; writes: wBattleTarget, wDefeatByteD1, wFollowUpAction, wBattleActor, wDefeatFlagsBA
; points at: wBattleResolveStep, wBattleTargetChoice, wSavedActorTarget, wBattleActionChoice
RunActionResolveStep_AddDoubleAToHL_Bank3A::
Jump_03A_6BF8:: ; address name
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wDefeatByteD1]
    cp a, $FF
    jr z, .check_battle_step
    ld [wBattleTarget], a
    ld b, a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    call AddDoubleAToHL_Bank3A
    ld [hl], b
    ld a, $FF
    ld [wDefeatByteD1], a
    ret

.check_battle_step:
    ld a, [wBattleStep]
    cp a, $04
    jr z, RunActionResolveStep_RunDefeatStepMinus1Step
    ld a, [wFollowUpAction]
    or a, a
    jr z, RunActionResolveStep_RunDefeatStepMinus1Step
    xor a, a
    ld [wFollowUpAction], a
    ld hl, wSavedActorTarget
    ld a, [hl+]
    ld [wBattleActor], a
    ld a, [hl+]
    ld [wBattleTarget], a
    ld a, [hl+]
    ld [wDefeatFlagsBA], a
    ld a, [wBattleActor]
    ld de, wBattleActionChoice
    call RunActionResolveStep_Case06_Sub01
    ld a, [wBattleTarget]
    ld de, wBattleActionChoice

; only called from RunActionResolveStep_Case06 (E-0047)
; 1 call site from 1 routine (e.g. RunActionResolveStep_AddDoubleAToHL_Bank3A)
RunActionResolveStep_Case06_Sub01::
Func_03A_6C46:: ; address name
    add a, a
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [hl+]
    ld [de], a
    inc de
    ld a, [hl+]
    ld [de], a
    ret

; entry 7 of the `rst $00` table in RunActionResolveStep
; no direct call (reached through a table, a jump or a vector)
; reads: wDefeatStep
; points at: wBattleResolveStep
RunActionResolveStep_RunDefeatStepMinus1Step::
Jump_03A_6C52:: ; address name
    ld a, [wDefeatStep]
    or a, a
    call nz, RunDefeatStepMinus1Step
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; entry 8 of the `rst $00` table in RunActionResolveStep
; no direct call (reached through a table, a jump or a vector)
; writes: wDefeatFlagsBA, wBattleSubPhase, wBattleResolveStep
; points at: wBattleResolveStep
RunActionResolveStep_CheckActionBDOrRun63B2And63D2_Case08::
Jump_03A_6C5E:: ; address name
    call CheckActionBDOrRun63B2And63D2
    jr c, .clear_defeat_flags_ba
    ld hl, wBattleResolveStep
    inc [hl]
    ret

.clear_defeat_flags_ba:
    xor a, a
    ld [wDefeatFlagsBA], a
    ld a, $04
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    ret

; entry 9 of the `rst $00` table in RunActionResolveStep
; no direct call (reached through a table, a jump or a vector)
RunActionResolveStep_Case09_CheckSlotStatusBlockWide_Bank3A_Case09::
Jump_03A_6C76:: ; address name
    call RunActionResolveStep_Case09_CheckSlotStatusBlockWide_Bank3A
    ret

; carry when wC5E7 is below $40 (a foe target outside link battles) or $80 (otherwise) (E-0122)
; 1 call site from 1 routine (e.g. RunActionResolveStep_CarryUnlessBattleSlotOutSlotEmpty_Case01)
; reads: wLinkMode, wBattleTarget, wRandomLo
RollRandomBelowTargetThreshold::
Func_03A_6C7A:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr z, .check_random_lo
    ld a, [wBattleTarget]
    cp a, $04
    jr c, .check_random_lo
    ld b, $40
    jr .check_random_lo2

.check_random_lo:
    ld b, $80

.check_random_lo2:
    ld a, [wRandomLo]
    cp a, b
    ret

; runs the routine for wDABE - 1 (jump table of ten) (E-0122)
; 1 call site from 1 routine (e.g. RunActionResolveStep_RunDefeatStepMinus1Step)
; reads: wDefeatStep
RunDefeatStepMinus1Step::
Func_03A_6C93:: ; address name
    ld a, [wDefeatStep]
    dec a
    rst $00
    dw RunDefeatStepMinus1Step_TargetOnLocalSide_Bank3A
    dw RunDefeatStepMinus1Step_TargetOnLocalSide_Bank3A_Case01
    dw RunDefeatStepMinus1Step_WriteDefeatStep
    dw RunDefeatStepMinus1Step_Return
    dw RunDefeatStepMinus1Step_Return
    dw RunDefeatStepMinus1Step_Return
    dw RunDefeatStepMinus1Step_Return
    dw RunDefeatStepMinus1Step_Return
    dw RunDefeatStepMinus1Step_ShowHeroWentAway
    dw RunDefeatStepMinus1Step_Return

; entry 0 of the `rst $00` table in RunDefeatStepMinus1Step
; no direct call (reached through a table, a jump or a vector)
; writes: wDefeatStep
RunDefeatStepMinus1Step_TargetOnLocalSide_Bank3A::
Jump_03A_6CAC:: ; address name
    call TargetOnLocalSide_Bank3A
    ld d, $85
    jr c, RunDefeatStepMinus1Step_ShowHeroWentAway_CallShowBattleText
    ld d, $E8
    jr RunDefeatStepMinus1Step_ShowHeroWentAway_CallShowBattleText

; entry 1 of the `rst $00` table in RunDefeatStepMinus1Step
; no direct call (reached through a table, a jump or a vector)
; writes: wDefeatStep
RunDefeatStepMinus1Step_TargetOnLocalSide_Bank3A_Case01::
Jump_03A_6CB7:: ; address name
    call TargetOnLocalSide_Bank3A
    ld d, $80
    jr c, RunDefeatStepMinus1Step_ShowHeroWentAway_CallShowBattleText
    ld d, $E7
    jr RunDefeatStepMinus1Step_ShowHeroWentAway_CallShowBattleText

; entry 2 of the `rst $00` table in RunDefeatStepMinus1Step
; no direct call (reached through a table, a jump or a vector)
; writes: wDefeatStep
RunDefeatStepMinus1Step_WriteDefeatStep::
Jump_03A_6CC2:: ; address name
    ld d, $AC
    jr RunDefeatStepMinus1Step_ShowHeroWentAway_CallShowBattleText

; entry 3 of the `rst $00` table in RunDefeatStepMinus1Step
; no direct call (reached through a table, a jump or a vector)
RunDefeatStepMinus1Step_Return::
Jump_03A_6CC6:: ; address name
    ret

; entry 8 of the `rst $00` table in RunDefeatStepMinus1Step
; no direct call (reached through a table, a jump or a vector)
; writes: wDefeatStep
RunDefeatStepMinus1Step_ShowHeroWentAway::
Jump_03A_6CC7:: ; address name
    ld d, $7F ; battle text '0 went away!'

RunDefeatStepMinus1Step_ShowHeroWentAway_CallShowBattleText::
Jump_03A_6CC9:: ; address name
    farcall ShowBattleText
    xor a, a
    ld [wDefeatStep], a
    ret

; only called from RunActionResolveStep_Case09 (E-0047)
; 1 call site from 1 routine (e.g. RunActionResolveStep_Case09_CheckSlotStatusBlockWide_Bank3A_Case09)
; reads: wBattleStep, wFollowUpAction, wBattleTarget, wRecordBufferData, wBattleActionId, wBattleActor, wResolveByte81, wResolveMsgFlags
; writes: wBattleSubPhase, wBattleResolveStep, wBattleSubStep, wResolveByte81, wFollowUpAction
; points at: wBattleStatus6, wBattleStep, wBattleSubPhase
RunActionResolveStep_Case09_CheckSlotStatusBlockWide_Bank3A::
Func_03A_6CD4:: ; address name
    ld a, [wBattleStep]
    cp a, $04
    jr z, .clear_resolve_byte81
    ld a, [wFollowUpAction]
    or a, a
    jr nz, .clear_follow_up_action
    ld a, [wBattleTarget]
    call CheckSlotStatusBlockWide_Bank3A
    jr c, .clear_resolve_byte81
    ld hl, wBattleStatus6
    call AddAx9ToHL
    bit 3, [hl]
    jr z, .clear_resolve_byte81
    ld a, [wRecordBufferData + $7]
    bit 2, a
    jr z, .call_show_battle_text
    ld a, [wBattleActionId]
    cp a, $6C
    jr nz, .check_resolve_byte81
    ld a, [wBattleActor]
    and a, $04
    ld l, a
    ld a, [wBattleTarget]
    and a, $04
    add a, l
    and a, $04
    jr z, .clear_resolve_byte81

.check_resolve_byte81:
    ld a, [wResolveByte81]
    cp a, $01
    jr z, .clear_resolve_byte81
    ld a, [wResolveMsgFlags]
    bit 4, a
    jr z, .clear_resolve_byte81
    ld d, $7A ; battle text '0 struck back!'
    farcall ShowBattleText
    ld hl, wBattleStep
    inc [hl]
    xor a, a
    ld [wBattleSubPhase], a
    xor a, a
    ld [wBattleResolveStep], a
    xor a, a
    ld [wBattleSubStep], a
    xor a, a
    ret

.clear_follow_up_action:
    xor a, a
    ld [wFollowUpAction], a

.call_show_battle_text:
    ld d, $7B ; battle text '0 couldn't strike back!'
    farcall ShowBattleText

.clear_resolve_byte81:
    xor a, a
    ld [wResolveByte81], a
    ld hl, wBattleSubPhase
    inc [hl]
    xor a, a
    ld [wBattleResolveStep], a
    scf
    ret

; removes the first byte equal to C from the 8-byte queue at wD895, shifting later bytes down and filling with $FF (E-0124)
; no direct call (reached through a table, a jump or a vector)
; points at: wActionQueue
RemoveCFromActionQueue_3A:: ; heuristic: follows a terminator; C0
Func_03A_6D53:: ; address name
    ld hl, wActionQueue
    ld b, $08
    ld d, $00

.loop:
    bit 0, d
    jr nz, .next
    ld a, [hl]
    cp a, c
    jr nz, .next2
    ld d, $01

.next:
    inc hl
    ld a, [hl]
    ld [hl], $FF
    dec hl
    ld [hl], a
    inc hl
    dec b
    jr nz, .loop
    ld [hl], $FF
    ret

.next2:
    inc hl
    dec b
    jr nz, .loop
    ret

; D = Data_03A_6DAA[wBattleActionId]; returns at once when it is $FF; for action $CF first runs Func_03A_6D91; then ShowBattleText (E-0118)
; 2 call sites from 2 routines (e.g. RunBattleActions_StatusChecks_ShowActionBattleTextFromActionBattleTextTable, RunBattleStep4_ResolveSkill_ShowActionBattleTextFromActionBattleTextTable)
; reads: wBattleActionId
; writes: wStringIndex, wStringCategory
ShowActionBattleTextFromActionBattleTextTable::
Func_03A_6D76:: ; address name
    ld a, [wBattleActionId]
    ld hl, ActionBattleTextTable
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    ret z
    ld d, a
    ld a, [wBattleActionId]
    cp a, $CF
    call z, ShowActionBattleTextFromActionBattleTextTable_AdvanceRandom
    jp ShowBattleText

; only called from ShowActionBattleTextFromActionBattleTextTable (E-0047)
; 1 call site from 1 routine (e.g. ShowActionBattleTextFromActionBattleTextTable)
; reads: wRandomLo
; writes: wEffectByte6F
ShowActionBattleTextFromActionBattleTextTable_AdvanceRandom::
Func_03A_6D91:: ; address name
    call AdvanceRandom
    ld a, [wRandomLo]
    cp a, $80
    jr c, .set_effect_byte6_f_to_01
    xor a, a
    ld [wEffectByte6F], a
    ld d, $91
    ret

.set_effect_byte6_f_to_01:
    ld a, $01
    ld [wEffectByte6F], a
    ld d, $D6
    ret

; E-0210 (C1: ShowActionBattleTextFromActionBattleTextTable reads the byte at $6DAA + wBattleActionId and, unless it is $FF, passes it in D to ShowBattleText (action $CF first runs ShowActionBattleTextFromActionBattleTextTable_Sub01); 232 bytes end at ShowActionBattleText ($6E92)).
; record: battle text index ($FF = none)
ActionBattleTextTable::
Data_03A_6DAA:: ; address name
    db $00 ; id 0
    db $01 ; id 1
    db $01 ; id 2
    db $01 ; id 3
    db $01 ; id 4
    db $01 ; id 5
    db $01 ; id 6
    db $01 ; id 7
    db $01 ; id 8
    db $01 ; id 9
    db $01 ; id 10
    db $01 ; id 11
    db $01 ; id 12
    db $01 ; id 13
    db $01 ; id 14
    db $01 ; id 15
    db $01 ; id 16
    db $01 ; id 17
    db $01 ; id 18
    db $01 ; id 19
    db $01 ; id 20
    db $01 ; id 21
    db $01 ; id 22
    db $01 ; id 23
    db $01 ; id 24
    db $01 ; id 25
    db $01 ; id 26
    db $01 ; id 27
    db $01 ; id 28
    db $01 ; id 29
    db $01 ; id 30
    db $01 ; id 31
    db $01 ; id 32
    db $01 ; id 33
    db $01 ; id 34
    db $01 ; id 35
    db $01 ; id 36
    db $01 ; id 37
    db $01 ; id 38
    db $01 ; id 39
    db $01 ; id 40
    db $01 ; id 41
    db $01 ; id 42
    db $01 ; id 43
    db $01 ; id 44
    db $01 ; id 45
    db $01 ; id 46
    db $01 ; id 47
    db $01 ; id 48
    db $01 ; id 49
    db $01 ; id 50
    db $01 ; id 51
    db $01 ; id 52
    db $01 ; id 53
    db $01 ; id 54
    db $01 ; id 55
    db $01 ; id 56
    db $01 ; id 57
    db $01 ; id 58
    db $01 ; id 59
    db $01 ; id 60
    db $1A ; id 61
    db $19 ; id 62
    db $18 ; id 63
    db $03 ; id 64
    db $03 ; id 65
    db $03 ; id 66
    db $03 ; id 67
    db $03 ; id 68
    db $03 ; id 69
    db $03 ; id 70
    db $03 ; id 71
    db $02 ; id 72
    db $15 ; id 73
    db $16 ; id 74
    db $17 ; id 75
    db $33 ; id 76
    db $34 ; id 77
    db $11 ; id 78
    db $10 ; id 79
    db $02 ; id 80
    db $02 ; id 81
    db $02 ; id 82
    db $02 ; id 83
    db $02 ; id 84
    db $02 ; id 85
    db $02 ; id 86
    db $02 ; id 87
    db $02 ; id 88
    db $02 ; id 89
    db $02 ; id 90
    db $02 ; id 91
    db $02 ; id 92
    db $02 ; id 93
    db $02 ; id 94
    db $00 ; id 95
    db $00 ; id 96
    db $00 ; id 97
    db $13 ; id 98
    db $02 ; id 99
    db $02 ; id 100
    db $02 ; id 101
    db $0F ; id 102
    db $02 ; id 103
    db $DA ; id 104
    db $14 ; id 105
    db $0C ; id 106
    db $0B ; id 107
    db $0A ; id 108
    db $06 ; id 109
    db $08 ; id 110
    db $07 ; id 111
    db $09 ; id 112
    db $03 ; id 113
    db $03 ; id 114
    db $03 ; id 115
    db $03 ; id 116
    db $1B ; id 117
    db $04 ; id 118
    db $04 ; id 119
    db $04 ; id 120
    db $04 ; id 121
    db $04 ; id 122
    db $04 ; id 123
    db $04 ; id 124
    db $1D ; id 125
    db $1C ; id 126
    db $02 ; id 127
    db $02 ; id 128
    db $05 ; id 129
    db $05 ; id 130
    db $05 ; id 131
    db $BD ; id 132
    db $23 ; id 133
    db $23 ; id 134
    db $23 ; id 135
    db $23 ; id 136
    db $0E ; id 137
    db $12 ; id 138
    db $1F ; id 139
    db $1F ; id 140
    db $20 ; id 141
    db $21 ; id 142
    db $DC ; id 143
    db $22 ; id 144
    db $A8 ; id 145
    db $04 ; id 146
    db $25 ; id 147
    db $2E ; id 148
    db $2D ; id 149
    db $2F ; id 150
    db $2B ; id 151
    db $2C ; id 152
    db $24 ; id 153
    db $24 ; id 154
    db $29 ; id 155
    db $32 ; id 156
    db $30 ; id 157
    db $2A ; id 158
    db $26 ; id 159
    db $27 ; id 160
    db $31 ; id 161
    db $00 ; id 162
    db $00 ; id 163
    db $00 ; id 164
    db $00 ; id 165
    db $00 ; id 166
    db $00 ; id 167
    db $00 ; id 168
    db $00 ; id 169
    db $DC ; id 170
    db $00 ; id 171
    db $E1 ; id 172
    db $01 ; id 173
    db $01 ; id 174
    db $00 ; id 175
    db $BC ; id 176
    db $FF ; id 177
    db $FF ; id 178
    db $BD ; id 179
    db $BE ; id 180
    db $FF ; id 181
    db $FF ; id 182
    db $C0 ; id 183
    db $FF ; id 184
    db $C1 ; id 185
    db $C2 ; id 186
    db $FF ; id 187
    db $FF ; id 188
    db $C4 ; id 189
    db $00 ; id 190
    db $E5 ; id 191
    db $00 ; id 192
    db $00 ; id 193
    db $B6 ; id 194
    db $B7 ; id 195
    db $BB ; id 196
    db $B8 ; id 197
    db $B9 ; id 198
    db $BA ; id 199
    db $D8 ; id 200
    db $E2 ; id 201
    db $E3 ; id 202
    db $E4 ; id 203
    db $0D ; id 204
    db $A9 ; id 205
    db $28 ; id 206
    db $D6 ; id 207
    db $EB ; id 208
    db $EC ; id 209
    db $ED ; id 210
    db $EE ; id 211
    db $EF ; id 212
    db $F0 ; id 213
    db $F1 ; id 214
    db $F2 ; id 215
    db $F3 ; id 216
    db $F4 ; id 217
    db $F5 ; id 218
    db $F6 ; id 219
    db $F7 ; id 220
    db $F8 ; id 221
    db $F9 ; id 222
    db $FA ; id 223
    db $AA ; id 224
    db $AB ; id 225
    db $B2 ; id 226
    db $B4 ; id 227
    db $FF ; id 228
    db $FF ; id 229
    db $FF ; id 230
    db $FF ; id 231

; D = Data_03A_6EA5[wBattleActionId]; returns at once when it is $FF, otherwise ShowBattleText (E-0116)
; 2 call sites from 2 routines (e.g. RunBattleActions_UseItem_CarryUnlessBattleSlotOutSlotEmpty, RunBattleActions_UseItem_ShowActionBattleText)
; reads: wBattleActionId
; writes: wStringIndex, wStringCategory
ShowActionBattleText::
Func_03A_6E92:: ; address name
    ld a, [wBattleActionId]
    ld hl, ActionBattleTextTable2
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    ret z
    ld d, a
    jp ShowBattleText

; E-0210 (C1: ShowActionBattleText (from Func_03B_42F4) reads the byte at $6EA5 + wBattleActionId and, unless it is $FF, passes it to ShowBattleText; 64 bytes end at ShowBattleTextCategory0 ($6EE5)).
; record: battle text index ($FF = none)
ActionBattleTextTable2::
Data_03A_6EA5:: ; address name
    db $FF ; id 0
    db $9F ; id 1
    db $9F ; id 2
    db $A2 ; id 3
    db $9F ; id 4
    db $9F ; id 5
    db $9F ; id 6
    db $9F ; id 7
    db $9F ; id 8
    db $9F ; id 9
    db $9F ; id 10
    db $A1 ; id 11
    db $9F ; id 12
    db $FF ; id 13
    db $FF ; id 14
    db $FF ; id 15
    db $FF ; id 16
    db $FF ; id 17
    db $FF ; id 18
    db $FF ; id 19
    db $FF ; id 20
    db $FF ; id 21
    db $FF ; id 22
    db $FF ; id 23
    db $FF ; id 24
    db $94 ; id 25
    db $94 ; id 26
    db $94 ; id 27
    db $94 ; id 28
    db $94 ; id 29
    db $97 ; id 30
    db $99 ; id 31
    db $FF ; id 32
    db $FF ; id 33
    db $A5 ; id 34
    db $9B ; id 35
    db $A4 ; id 36
    db $A3 ; id 37
    db $A6 ; id 38
    db $A7 ; id 39
    db $FF ; id 40
    db $FF ; id 41
    db $FF ; id 42
    db $FF ; id 43
    db $FF ; id 44
    db $FF ; id 45
    db $FF ; id 46
    db $FF ; id 47
    db $FF ; id 48
    db $FF ; id 49
    db $FF ; id 50
    db $FF ; id 51
    db $FF ; id 52
    db $FF ; id 53
    db $FF ; id 54
    db $FF ; id 55
    db $97 ; id 56
    db $FF ; id 57
    db $FF ; id 58
    db $FF ; id 59
    db $0D ; id 60
    db $A9 ; id 61
    db $28 ; id 62
    db $D6 ; id 63

; D = message index. The same as ShowBattleText, but it stores 0 in wStringCategory: the entry at Data_03A_6F06 + 2 * D is called first when non-zero, then BeginStringDisplay_Bank2F shows category 0 (E-0056)
; 22 call sites from 14 routines (e.g. RunCommandEntryResolveStep_AddAx9ToHL, RunBattleActions_StatusChecks_StartAction_ShowBattleTextCategory0, RunBattleActions_StatusChecks_StartAction_PickRandomActionWhenUncontrolled, ShowActorStatusRecoveryMessage, ...)
; writes: wStringIndex, wStringCategory
ShowBattleTextCategory0::
Func_03A_6EE5:: ; address name
    push de
    ld hl, BattleTextCategory0HookTable
    ld c, d
    ld b, $00
    add hl, bc
    add hl, bc
    ld a, [hl+]
    or a, [hl]
    jr z, .set_string_index
    dec hl
    call JumpToWordAtHL

.set_string_index:
    pop af
    ld [wStringIndex], a
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ret

; E-0210 (C1: ShowBattleTextCategory0 calls the word at $6F06 + 2 * D through JumpToWordAtHL when it is non-zero, then shows string D of category 0 with BeginStringDisplay_Bank2F; 256 words end exactly at the first target, a bare ret at $7106; most entries are $0000 or point at bare rets).
; record: routine run before message D ($0000 = none)
BattleTextCategory0HookTable::
Data_03A_6F06:: ; address name
    dw BattleText0HookRet_7106 ; id 0
    dw BattleText0HookRet_7106 ; id 1
    dw BattleText0Hook02 ; id 2
    dw BattleText0HookRet_7108 ; id 3
    dw BattleText0HookRet_7108 ; id 4
    dw BattleText0Hook05 ; id 5
    dw BattleText0Hook06 ; id 6
    dw BattleText0Hook07 ; id 7
    dw BattleText0HookRet_710C ; id 8
    dw BattleText0HookRet_710C ; id 9
    dw $0000 ; id 10
    dw BattleText0HookListSidesTwice ; id 11
    dw BattleText0HookListSidesTwice ; id 12
    dw BattleText0Hook0D ; id 13
    dw BattleText0Hook0E ; id 14
    dw BattleText0HookActorName ; id 15
    dw BattleText0HookActorNameAndDamage ; id 16
    dw BattleText0HookActorNameAndDamage ; id 17
    dw BattleText0HookActorName ; id 18
    dw BattleText0HookActorName ; id 19
    dw BattleText0HookActorName ; id 20
    dw BattleText0HookActorName ; id 21
    dw BattleText0HookActorName ; id 22
    dw BattleText0HookActorName ; id 23
    dw BattleText0HookActorName ; id 24
    dw BattleText0HookActorName ; id 25
    dw BattleText0HookActorName ; id 26
    dw BattleText0HookActorName ; id 27
    dw BattleText0HookActorName ; id 28
    dw $0000 ; id 29
    dw $0000 ; id 30
    dw $0000 ; id 31
    dw $0000 ; id 32
    dw $0000 ; id 33
    dw BattleText0Hook22 ; id 34
    dw $0000 ; id 35
    dw $0000 ; id 36
    dw $0000 ; id 37
    dw $0000 ; id 38
    dw $0000 ; id 39
    dw BattleText0HookActorName ; id 40
    dw $0000 ; id 41
    dw BattleText0HookTargetNameAndGroupWord ; id 42
    dw BattleText0HookTargetNameAndGroupWord ; id 43
    dw $0000 ; id 44
    dw $0000 ; id 45
    dw BattleText0HookActorName ; id 46
    dw BattleText0HookActorName ; id 47
    dw BattleText0HookActorName ; id 48
    dw BattleText0HookActorName ; id 49
    dw BattleText0HookActorName ; id 50
    dw BattleText0Hook33 ; id 51
    dw BattleText0HookActorName ; id 52
    dw BattleText0HookActorName ; id 53
    dw BattleText0HookActorAndSkill_7154 ; id 54
    dw BattleText0HookActorAndSkill_7154 ; id 55
    dw BattleText0HookActorAndSkill_7154 ; id 56
    dw BattleText0HookActorName ; id 57
    dw BattleText0HookActorName ; id 58
    dw BattleText0HookActorName ; id 59
    dw BattleText0HookActorName ; id 60
    dw BattleText0HookActorName ; id 61
    dw BattleText0HookActorName ; id 62
    dw BattleText0Hook3F ; id 63
    dw BattleText0HookActorName ; id 64
    dw BattleText0HookActorName ; id 65
    dw BattleText0HookActorName ; id 66
    dw BattleText0HookActorName ; id 67
    dw BattleText0HookActorName ; id 68
    dw BattleText0HookActorAndSkill_7162 ; id 69
    dw BattleText0HookActorAndSkill_7162 ; id 70
    dw BattleText0HookActorAndSkill_7162 ; id 71
    dw BattleText0HookActorName ; id 72
    dw BattleText0HookActorAndSkill_7162 ; id 73
    dw BattleText0HookActorAndSkill_7162 ; id 74
    dw BattleText0HookActorAndSkill_7162 ; id 75
    dw BattleText0HookActorAndSkill_7162 ; id 76
    dw BattleText0HookActorAndSkill_7162 ; id 77
    dw BattleText0HookActorAndSkill_7162 ; id 78
    dw BattleText0HookActorAndSkill_7162 ; id 79
    dw BattleText0HookActorAndSkill_7162 ; id 80
    dw BattleText0HookActorName ; id 81
    dw BattleText0HookActorName ; id 82
    dw BattleText0HookActorName ; id 83
    dw BattleText0HookActorName ; id 84
    dw BattleText0HookActorName ; id 85
    dw BattleText0HookActorAndSkill_7162 ; id 86
    dw BattleText0HookActorName ; id 87
    dw BattleText0HookActorName ; id 88
    dw BattleText0HookActorName ; id 89
    dw BattleText0HookActorName ; id 90
    dw BattleText0HookActorName ; id 91
    dw BattleText0HookActorName ; id 92
    dw BattleText0HookActorName ; id 93
    dw BattleText0HookActorAndSkill_7162 ; id 94
    dw BattleText0HookActorAndSkill_7162 ; id 95
    dw $0000 ; id 96
    dw $0000 ; id 97
    dw $0000 ; id 98
    dw $0000 ; id 99
    dw $0000 ; id 100
    dw $0000 ; id 101
    dw BattleText0HookActorAndMappedSlot ; id 102
    dw BattleText0HookActorAndMappedSlot ; id 103
    dw BattleText0HookActorAndMappedSlot ; id 104
    dw BattleText0HookActorAndMappedSlot ; id 105
    dw BattleText0HookActorAndMappedSlot ; id 106
    dw BattleText0HookActorAndMappedSlot ; id 107
    dw BattleText0HookActorAndMappedSlot ; id 108
    dw BattleText0HookActorAndMappedSlot ; id 109
    dw BattleText0HookActorAndMappedSlot ; id 110
    dw BattleText0HookActorAndMappedSlot ; id 111
    dw BattleText0HookActorAndMappedSlot ; id 112
    dw BattleText0HookActorAndMappedSlot ; id 113
    dw BattleText0HookActorAndMappedSlot ; id 114
    dw BattleText0HookActorAndMappedSlot ; id 115
    dw BattleText0HookActorAndMappedSlot ; id 116
    dw BattleText0HookActorAndMappedSlot ; id 117
    dw BattleText0HookActorAndMappedSlot ; id 118
    dw BattleText0HookActorAndMappedSlot ; id 119
    dw BattleText0HookActorAndMappedSlot ; id 120
    dw BattleText0HookActorAndMappedSlot ; id 121
    dw BattleText0HookActorAndMappedSlot ; id 122
    dw $0000 ; id 123
    dw $0000 ; id 124
    dw $0000 ; id 125
    dw BattleText0Hook7E ; id 126
    dw $0000 ; id 127
    dw BattleText0HookTargetAndDefeatSlot ; id 128
    dw BattleText0HookTargetAndDefeatSlot ; id 129
    dw $0000 ; id 130
    dw $0000 ; id 131
    dw $0000 ; id 132
    dw $0000 ; id 133
    dw $0000 ; id 134
    dw $0000 ; id 135
    dw $0000 ; id 136
    dw $0000 ; id 137
    dw $0000 ; id 138
    dw $0000 ; id 139
    dw $0000 ; id 140
    dw $0000 ; id 141
    dw $0000 ; id 142
    dw $0000 ; id 143
    dw $0000 ; id 144
    dw $0000 ; id 145
    dw $0000 ; id 146
    dw $0000 ; id 147
    dw $0000 ; id 148
    dw $0000 ; id 149
    dw $0000 ; id 150
    dw $0000 ; id 151
    dw $0000 ; id 152
    dw $0000 ; id 153
    dw $0000 ; id 154
    dw $0000 ; id 155
    dw $0000 ; id 156
    dw $0000 ; id 157
    dw $0000 ; id 158
    dw $0000 ; id 159
    dw $0000 ; id 160
    dw $0000 ; id 161
    dw $0000 ; id 162
    dw $0000 ; id 163
    dw $0000 ; id 164
    dw $0000 ; id 165
    dw $0000 ; id 166
    dw $0000 ; id 167
    dw $0000 ; id 168
    dw $0000 ; id 169
    dw $0000 ; id 170
    dw $0000 ; id 171
    dw $0000 ; id 172
    dw $0000 ; id 173
    dw $0000 ; id 174
    dw $0000 ; id 175
    dw $0000 ; id 176
    dw $0000 ; id 177
    dw $0000 ; id 178
    dw $0000 ; id 179
    dw $0000 ; id 180
    dw $0000 ; id 181
    dw $0000 ; id 182
    dw $0000 ; id 183
    dw $0000 ; id 184
    dw $0000 ; id 185
    dw $0000 ; id 186
    dw $0000 ; id 187
    dw $0000 ; id 188
    dw $0000 ; id 189
    dw $0000 ; id 190
    dw $0000 ; id 191
    dw $0000 ; id 192
    dw $0000 ; id 193
    dw $0000 ; id 194
    dw $0000 ; id 195
    dw $0000 ; id 196
    dw $0000 ; id 197
    dw $0000 ; id 198
    dw $0000 ; id 199
    dw $0000 ; id 200
    dw $0000 ; id 201
    dw $0000 ; id 202
    dw $0000 ; id 203
    dw $0000 ; id 204
    dw $0000 ; id 205
    dw $0000 ; id 206
    dw $0000 ; id 207
    dw $0000 ; id 208
    dw $0000 ; id 209
    dw $0000 ; id 210
    dw $0000 ; id 211
    dw $0000 ; id 212
    dw $0000 ; id 213
    dw $0000 ; id 214
    dw $0000 ; id 215
    dw $0000 ; id 216
    dw $0000 ; id 217
    dw $0000 ; id 218
    dw $0000 ; id 219
    dw $0000 ; id 220
    dw $0000 ; id 221
    dw $0000 ; id 222
    dw $0000 ; id 223
    dw $0000 ; id 224
    dw $0000 ; id 225
    dw $0000 ; id 226
    dw $0000 ; id 227
    dw $0000 ; id 228
    dw $0000 ; id 229
    dw $0000 ; id 230
    dw $0000 ; id 231
    dw $0000 ; id 232
    dw $0000 ; id 233
    dw $0000 ; id 234
    dw $0000 ; id 235
    dw $0000 ; id 236
    dw $0000 ; id 237
    dw $0000 ; id 238
    dw $0000 ; id 239
    dw $0000 ; id 240
    dw $0000 ; id 241
    dw $0000 ; id 242
    dw $0000 ; id 243
    dw $0000 ; id 244
    dw $0000 ; id 245
    dw $0000 ; id 246
    dw $0000 ; id 247
    dw $0000 ; id 248
    dw $0000 ; id 249
    dw $0000 ; id 250
    dw $0000 ; id 251
    dw $0000 ; id 252
    dw $0000 ; id 253
    dw $0000 ; id 254
    dw $0000 ; id 255

; bare ret, the hook of messages 0 and 1 (E-0210)
; no direct call (reached through a table, a jump or a vector)
BattleText0HookRet_7106:: ; code pointer of the table BattleTextCategory0HookTable; C0
Func_03A_7106:: ; address name
    ret

; handler 02 (entry 2 of BattleTextCategory0HookTable)
; no direct call (reached through a table, a jump or a vector)
BattleText0Hook02:: ; code pointer of the table BattleTextCategory0HookTable; C0
Func_03A_7107:: ; address name
    ret

; bare ret (E-0210)
; no direct call (reached through a table, a jump or a vector)
BattleText0HookRet_7108:: ; code pointer of the table BattleTextCategory0HookTable; C0
Func_03A_7108:: ; address name
    ret

; handler 05 (entry 5 of BattleTextCategory0HookTable)
; no direct call (reached through a table, a jump or a vector)
BattleText0Hook05:: ; code pointer of the table BattleTextCategory0HookTable; C0
Func_03A_7109:: ; address name
    ret

; handler 06 (entry 6 of BattleTextCategory0HookTable)
; no direct call (reached through a table, a jump or a vector)
BattleText0Hook06:: ; code pointer of the table BattleTextCategory0HookTable; C0
Func_03A_710A:: ; address name
    ret

; handler 07 (entry 7 of BattleTextCategory0HookTable)
; no direct call (reached through a table, a jump or a vector)
BattleText0Hook07:: ; code pointer of the table BattleTextCategory0HookTable; C0
Func_03A_710B:: ; address name
    ret

; bare ret (E-0210)
; no direct call (reached through a table, a jump or a vector)
BattleText0HookRet_710C:: ; code pointer of the table BattleTextCategory0HookTable; C0
Func_03A_710C:: ; address name
    ret

; ListSideMonsterIdsToWC0A0, then falls into BattleText0Hook0D, which lists again and jumps into WriteTargetNameOrTheMonsters ($785D) (E-0210)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleStatResultLo
; writes: wBattleStatResultLo
; points at: wTemp0, wPauseMenuStep, wTextBuf0
BattleText0HookListSidesTwice:: ; code pointer of the table BattleTextCategory0HookTable; C0
Func_03A_710D:: ; address name
    call ListSideMonsterIdsToWC0A0

; handler 0D (entry 13 of BattleTextCategory0HookTable)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleStatResultLo
; writes: wBattleStatResultLo
; points at: wTemp0, wPauseMenuStep, wTextBuf0
BattleText0Hook0D:: ; code pointer of the table BattleTextCategory0HookTable; C0
Func_03A_7110:: ; address name
    call ListSideMonsterIdsToWC0A0
    jp WriteTargetNameOrTheMonsters_Skip

; handler 0E (entry 14 of BattleTextCategory0HookTable)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleStatResultLo
; writes: wBattleStatResultLo
; points at: wTemp0, wPauseMenuStep, wTextBuf0
BattleText0Hook0E:: ; code pointer of the table BattleTextCategory0HookTable; C0
Func_03A_7116:: ; address name
    call ListSideMonsterIdsToWC0A0
    jp CheckAllTargetsSame_Skip

; CopyActorNameToTextBuf0 (44 messages) (E-0210)
; no direct call (reached through a table, a jump or a vector)
BattleText0HookActorName:: ; code pointer of the table BattleTextCategory0HookTable; C0
Func_03A_711C:: ; address name
    call CopyActorNameToTextBuf0
    ret

; CopyActorNameToTextBuf0, then WriteBattleDamageToTextBuf1 (E-0210)
; no direct call (reached through a table, a jump or a vector)
BattleText0HookActorNameAndDamage:: ; code pointer of the table BattleTextCategory0HookTable; C0
Func_03A_7120:: ; address name
    call CopyActorNameToTextBuf0
    call WriteBattleDamageToTextBuf1
    ret

; handler 22 (entry 34 of BattleTextCategory0HookTable)
; no direct call (reached through a table, a jump or a vector)
BattleText0Hook22:: ; code pointer of the table BattleTextCategory0HookTable; C0
Func_03A_7127:: ; address name
    ret

; handler 33 (entry 51 of BattleTextCategory0HookTable)
; no direct call (reached through a table, a jump or a vector)
; reads: wResolveByte71
; writes: wNameSlot
; points at: wTextBuf1
BattleText0Hook33:: ; code pointer of the table BattleTextCategory0HookTable; C0
Func_03A_7128:: ; address name
    call CopyTargetNameToTextBuf0
    ld a, [wResolveByte71]
    ld hl, wTextBuf1
    ld [wNameSlot], a
    call CopySlotNameToHL
    ret

; CopyTargetNameToTextBuf0; then, when wSpeciesGroups[(wDefeatFlagsBA & $7F) - 1] has bit 7 set and is not $FF, WriteMonstersWordToTextBuf0 (E-0210)
; no direct call (reached through a table, a jump or a vector)
; reads: wDefeatFlagsBA
; points at: wSpeciesGroups
BattleText0HookTargetNameAndGroupWord:: ; code pointer of the table BattleTextCategory0HookTable; C0
Func_03A_7138:: ; address name
    call CopyTargetNameToTextBuf0
    ld a, [wDefeatFlagsBA]
    and a, $7F
    dec a
    ld hl, wSpeciesGroups
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    ret z
    bit 7, a
    ret z
    call WriteMonstersWordToTextBuf0
    ret

; CopyActorNameToTextBuf0, CopyActionSkillNameToTextBuf1 (E-0210)
; no direct call (reached through a table, a jump or a vector)
BattleText0HookActorAndSkill_7154:: ; code pointer of the table BattleTextCategory0HookTable; C0
Func_03A_7154:: ; address name
    call CopyActorNameToTextBuf0
    call CopyActionSkillNameToTextBuf1
    ret

; handler 3F (entry 63 of BattleTextCategory0HookTable)
; no direct call (reached through a table, a jump or a vector)
BattleText0Hook3F:: ; code pointer of the table BattleTextCategory0HookTable; C0
Func_03A_715B:: ; address name
    call CopyActorNameToTextBuf0
    call CopyTargetNameToTextBuf2
    ret

; CopyActorNameToTextBuf0, CopyActionSkillNameToTextBuf1 (the same as $7154) (E-0210)
; no direct call (reached through a table, a jump or a vector)
BattleText0HookActorAndSkill_7162:: ; code pointer of the table BattleTextCategory0HookTable; C0
Func_03A_7162:: ; address name
    call CopyActorNameToTextBuf0
    call CopyActionSkillNameToTextBuf1
    ret

; CopyActorNameToTextBuf0, CopyMappedSlotNameToTextBuf1 (21 messages) (E-0210)
; no direct call (reached through a table, a jump or a vector)
BattleText0HookActorAndMappedSlot:: ; code pointer of the table BattleTextCategory0HookTable; C0
Func_03A_7169:: ; address name
    call CopyActorNameToTextBuf0
    call CopyMappedSlotNameToTextBuf1
    ret

; handler 7E (entry 126 of BattleTextCategory0HookTable)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
BattleText0Hook7E:: ; code pointer of the table BattleTextCategory0HookTable; C0
Func_03A_7170:: ; address name
    ld a, [wBattleTarget]
    cp a, $03
    jr c, .return
    call ListSideMonsterIdsToWC0A0
    ld a, b
    cp a, $01
    jr nz, .return
    call CopyTargetNameToTextBuf0

.return:
    ret

; CopyTargetNameToTextBuf0, then the name of slot wDefeatByteD1 into wTextBuf1 (E-0210)
; no direct call (reached through a table, a jump or a vector)
; reads: wDefeatByteD1
; writes: wNameSlot
; points at: wTextBuf1
BattleText0HookTargetAndDefeatSlot:: ; code pointer of the table BattleTextCategory0HookTable; C0
Func_03A_7183:: ; address name
    call CopyTargetNameToTextBuf0
    ld a, [wDefeatByteD1]
    ld hl, wTextBuf1
    ld [wNameSlot], a
    call CopySlotNameToHL
    ret

; D = message index. If the 16-bit entry at Data_03A_71B4 + 2 * D is non-zero it is called first through Func_000_000B (a per-message routine, not read). Then it stores D in wStringIndex, 1 in wStringCategory and farcalls BeginStringDisplay_Bank2F: the battle text of bank $2F, category 1 (E-0056)
; 66 call sites from 56 routines (e.g. RunBattleActions_StatusChecks_CheckAction_ShowBattleText, RunBattleActions_StatusChecks_ShatterChecks_ShowGWasShattered, RunBattleActions_StatusChecks_ShatterChecks_ShowSealPrayWasBroken, RunBattleActions_StatusChecks_DroppedDead_ShowHeroDroppedDead, ...)
; writes: wStringIndex, wStringCategory
ShowBattleText::
Func_03A_7193:: ; address name
    push de
    ld hl, BattleTextPrepTable
    ld c, d
    ld b, $00
    add hl, bc
    add hl, bc
    ld a, [hl+]
    or a, [hl]
    jr z, .set_string_index
    dec hl
    call JumpToWordAtHL

.set_string_index:
    pop af
    ld [wStringIndex], a
    ld a, $01
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ret

; E-0180 (C1: ShowBattleText reads the word $71B4 + 2 * D and, when it is non-zero, calls it (JumpToWordAtHL) before showing string D of category 1 from bank $2F; 256 words up to the first routine at $73B4; 211 are non-zero).
; record: routine run before battle text D ($0000 = none)
BattleTextPrepTable::
Data_03A_71B4:: ; address name
    dw BattleTextPrep00 ; id 0
    dw BattleTextPrep01 ; id 1
    dw BattleTextPrep01 ; id 2
    dw BattleTextPrep01 ; id 3
    dw BattleTextPrep01 ; id 4
    dw BattleTextPrep01 ; id 5
    dw BattleTextPrep06 ; id 6
    dw BattleTextPrep06 ; id 7
    dw BattleTextPrep00 ; id 8
    dw BattleTextPrep06 ; id 9
    dw BattleTextPrep06 ; id 10
    dw BattleTextPrep06 ; id 11
    dw BattleTextPrep00 ; id 12
    dw BattleTextPrep00 ; id 13
    dw BattleTextPrep00 ; id 14
    dw BattleTextPrep0F ; id 15
    dw BattleTextPrep00 ; id 16
    dw BattleTextPrep00 ; id 17
    dw BattleTextPrep00 ; id 18
    dw BattleTextPrep00 ; id 19
    dw BattleTextPrep00 ; id 20
    dw BattleTextPrep00 ; id 21
    dw BattleTextPrep00 ; id 22
    dw BattleTextPrep00 ; id 23
    dw BattleTextPrep00 ; id 24
    dw BattleTextPrep00 ; id 25
    dw BattleTextPrep00 ; id 26
    dw BattleTextPrep00 ; id 27
    dw BattleTextPrep00 ; id 28
    dw BattleTextPrep00 ; id 29
    dw BattleTextPrep06 ; id 30
    dw BattleTextPrep06 ; id 31
    dw BattleTextPrep06 ; id 32
    dw BattleTextPrep21 ; id 33
    dw BattleTextPrep00 ; id 34
    dw BattleTextPrep00 ; id 35
    dw BattleTextPrep01 ; id 36
    dw BattleTextPrep06 ; id 37
    dw BattleTextPrep00 ; id 38
    dw BattleTextPrep00 ; id 39
    dw BattleTextPrep00 ; id 40
    dw BattleTextPrep00 ; id 41
    dw BattleTextPrep00 ; id 42
    dw BattleTextPrep06 ; id 43
    dw BattleTextPrep00 ; id 44
    dw BattleTextPrep00 ; id 45
    dw BattleTextPrep00 ; id 46
    dw BattleTextPrep00 ; id 47
    dw BattleTextPrep00 ; id 48
    dw BattleTextPrep00 ; id 49
    dw BattleTextPrep00 ; id 50
    dw BattleTextPrep00 ; id 51
    dw BattleTextPrep00 ; id 52
    dw BattleTextPrep35 ; id 53
    dw BattleTextPrep35 ; id 54
    dw BattleTextPrep37 ; id 55
    dw BattleTextPrep37 ; id 56
    dw BattleTextPrep35 ; id 57
    dw BattleTextPrep35 ; id 58
    dw BattleTextPrep37 ; id 59
    dw BattleTextPrep37 ; id 60
    dw BattleTextPrep35 ; id 61
    dw BattleTextPrep35 ; id 62
    dw BattleTextPrep00 ; id 63
    dw BattleTextPrep35 ; id 64
    dw BattleTextPrep37 ; id 65
    dw BattleTextPrep37 ; id 66
    dw BattleTextPrep37 ; id 67
    dw BattleTextPrep37 ; id 68
    dw BattleTextPrep35 ; id 69
    dw BattleTextPrep37 ; id 70
    dw BattleTextPrep37 ; id 71
    dw BattleTextPrep35 ; id 72
    dw BattleTextPrep35 ; id 73
    dw BattleTextPrep37 ; id 74
    dw BattleTextPrep00 ; id 75
    dw BattleTextPrep00 ; id 76
    dw BattleTextPrep4D ; id 77
    dw BattleTextPrep37 ; id 78
    dw BattleTextPrep37 ; id 79
    dw BattleTextPrep37 ; id 80
    dw BattleTextPrep37 ; id 81
    dw BattleTextPrep06 ; id 82
    dw $0000 ; id 83
    dw BattleTextPrep37 ; id 84
    dw BattleTextPrep37 ; id 85
    dw BattleTextPrep37 ; id 86
    dw BattleTextPrep35 ; id 87
    dw BattleTextPrep37 ; id 88
    dw BattleTextPrep37 ; id 89
    dw BattleTextPrep37 ; id 90
    dw BattleTextPrep37 ; id 91
    dw BattleTextPrep37 ; id 92
    dw BattleTextPrep37 ; id 93
    dw BattleTextPrep37 ; id 94
    dw BattleTextPrep37 ; id 95
    dw BattleTextPrep37 ; id 96
    dw BattleTextPrep61 ; id 97
    dw BattleTextPrep37 ; id 98
    dw BattleTextPrep37 ; id 99
    dw BattleTextPrep37 ; id 100
    dw BattleTextPrep37 ; id 101
    dw BattleTextPrep37 ; id 102
    dw BattleTextPrep37 ; id 103
    dw BattleTextPrep37 ; id 104
    dw $0000 ; id 105
    dw BattleTextPrep37 ; id 106
    dw BattleTextPrep37 ; id 107
    dw BattleTextPrep37 ; id 108
    dw BattleTextPrep37 ; id 109
    dw BattleTextPrep37 ; id 110
    dw BattleTextPrep37 ; id 111
    dw BattleTextPrep37 ; id 112
    dw BattleTextPrep37 ; id 113
    dw $0000 ; id 114
    dw BattleTextPrep37 ; id 115
    dw BattleTextPrep37 ; id 116
    dw BattleTextPrep37 ; id 117
    dw BattleTextPrep37 ; id 118
    dw BattleTextPrep37 ; id 119
    dw BattleTextPrep37 ; id 120
    dw BattleTextPrep37 ; id 121
    dw BattleTextPrep37 ; id 122
    dw BattleTextPrep37 ; id 123
    dw BattleTextPrep00 ; id 124
    dw BattleTextPrep00 ; id 125
    dw BattleTextPrep7E ; id 126
    dw BattleTextPrep61 ; id 127
    dw BattleTextPrep37 ; id 128
    dw $0000 ; id 129
    dw BattleTextPrep37 ; id 130
    dw BattleTextPrep37 ; id 131
    dw BattleTextPrep00 ; id 132
    dw BattleTextPrep37 ; id 133
    dw $0000 ; id 134
    dw BattleTextPrep87 ; id 135
    dw BattleTextPrep35 ; id 136
    dw BattleTextPrep35 ; id 137
    dw BattleTextPrep37 ; id 138
    dw BattleTextPrep37 ; id 139
    dw BattleTextPrep00 ; id 140
    dw BattleTextPrep37 ; id 141
    dw BattleTextPrep37 ; id 142
    dw BattleTextPrep37 ; id 143
    dw BattleTextPrep37 ; id 144
    dw BattleTextPrep00 ; id 145
    dw BattleTextPrep92 ; id 146
    dw BattleTextPrep37 ; id 147
    dw BattleTextPrep94 ; id 148
    dw BattleTextPrep95 ; id 149
    dw BattleTextPrep95 ; id 150
    dw BattleTextPrep97 ; id 151
    dw BattleTextPrep00 ; id 152
    dw BattleTextPrep99 ; id 153
    dw BattleTextPrep00 ; id 154
    dw BattleTextPrep97 ; id 155
    dw BattleTextPrep00 ; id 156
    dw BattleTextPrep06 ; id 157
    dw BattleTextPrep37 ; id 158
    dw BattleTextPrep97 ; id 159
    dw BattleTextPrepA0 ; id 160
    dw BattleTextPrep99 ; id 161
    dw BattleTextPrep99 ; id 162
    dw BattleTextPrep97 ; id 163
    dw BattleTextPrep97 ; id 164
    dw BattleTextPrep97 ; id 165
    dw BattleTextPrep97 ; id 166
    dw BattleTextPrep97 ; id 167
    dw BattleTextPrep00 ; id 168
    dw BattleTextPrep00 ; id 169
    dw BattleTextPrepAA ; id 170
    dw BattleTextPrepAA ; id 171
    dw $0000 ; id 172
    dw BattleTextPrep35 ; id 173
    dw BattleTextPrep35 ; id 174
    dw BattleTextPrep00 ; id 175
    dw BattleTextPrepB0 ; id 176
    dw BattleTextPrep06 ; id 177
    dw BattleTextPrepAA ; id 178
    dw BattleTextPrep35 ; id 179
    dw BattleTextPrepAA ; id 180
    dw BattleTextPrep37 ; id 181
    dw BattleTextPrep00 ; id 182
    dw BattleTextPrep00 ; id 183
    dw BattleTextPrepB8 ; id 184
    dw BattleTextPrep00 ; id 185
    dw BattleTextPrep00 ; id 186
    dw BattleTextPrep00 ; id 187
    dw $0000 ; id 188
    dw BattleTextPrep00 ; id 189
    dw BattleTextPrepBE ; id 190
    dw BattleTextPrep00 ; id 191
    dw $0000 ; id 192
    dw $0000 ; id 193
    dw BattleTextPrep37 ; id 194
    dw BattleTextPrep37 ; id 195
    dw $0000 ; id 196
    dw $0000 ; id 197
    dw $0000 ; id 198
    dw BattleTextPrep37 ; id 199
    dw BattleTextPrep37 ; id 200
    dw BattleTextPrep37 ; id 201
    dw BattleTextPrepCA ; id 202
    dw BattleTextPrep37 ; id 203
    dw $0000 ; id 204
    dw BattleTextPrep35 ; id 205
    dw BattleTextPrep37 ; id 206
    dw BattleTextPrep37 ; id 207
    dw BattleTextPrep37 ; id 208
    dw BattleTextPrep37 ; id 209
    dw BattleTextPrep37 ; id 210
    dw BattleTextPrep00 ; id 211
    dw BattleTextPrep37 ; id 212
    dw BattleTextPrep37 ; id 213
    dw $0000 ; id 214
    dw BattleTextPrep37 ; id 215
    dw BattleTextPrep37 ; id 216
    dw BattleTextPrep37 ; id 217
    dw BattleTextPrep00 ; id 218
    dw BattleTextPrep37 ; id 219
    dw BattleTextPrep06 ; id 220
    dw BattleTextPrep37 ; id 221
    dw BattleTextPrep37 ; id 222
    dw BattleTextPrep37 ; id 223
    dw BattleTextPrep00 ; id 224
    dw BattleTextPrep00 ; id 225
    dw BattleTextPrep00 ; id 226
    dw BattleTextPrep01 ; id 227
    dw BattleTextPrep01 ; id 228
    dw BattleTextPrep01 ; id 229
    dw BattleTextPrepE6 ; id 230
    dw BattleTextPrep37 ; id 231
    dw BattleTextPrep37 ; id 232
    dw BattleTextPrep37 ; id 233
    dw BattleTextPrep37 ; id 234
    dw BattleTextPrepAA ; id 235
    dw BattleTextPrepAA ; id 236
    dw BattleTextPrepAA ; id 237
    dw BattleTextPrepAA ; id 238
    dw BattleTextPrepAA ; id 239
    dw BattleTextPrepAA ; id 240
    dw BattleTextPrepAA ; id 241
    dw BattleTextPrepF2 ; id 242
    dw BattleTextPrepAA ; id 243
    dw BattleTextPrepAA ; id 244
    dw BattleTextPrepAA ; id 245
    dw BattleTextPrepAA ; id 246
    dw BattleTextPrepAA ; id 247
    dw BattleTextPrepAA ; id 248
    dw BattleTextPrepAA ; id 249
    dw BattleTextPrepAA ; id 250
    dw $0000 ; id 251
    dw $0000 ; id 252
    dw BattleTextPrep95 ; id 253
    dw BattleTextPrep95 ; id 254
    dw $0000 ; id 255

; prepares the arguments of battle text 00 (entry 0 of BattleTextPrepTable)
; no direct call (reached through a table, a jump or a vector)
BattleTextPrep00:: ; code pointer of the table BattleTextPrepTable; C0
Func_03A_73B4:: ; address name
    call CopyActorNameToTextBuf0
    ret

; prepares the arguments of battle text E6 (entry 230 of BattleTextPrepTable)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget
BattleTextPrepE6:: ; code pointer of the table BattleTextPrepTable; C0
Func_03A_73B8:: ; address name
    ld a, [wBattleTarget]
    cp a, $03
    jr c, .return
    call ListSideMonsterIdsToWC0A0
    ld a, b
    cp a, $01
    jr nz, .return
    call CopyTargetNameToTextBuf0

.return:
    ret

; prepares the arguments of battle text 01 (entry 1 of BattleTextPrepTable)
; no direct call (reached through a table, a jump or a vector)
BattleTextPrep01:: ; code pointer of the table BattleTextPrepTable; C0
Func_03A_73CB:: ; address name
    call CopyActorNameToTextBuf0
    call CopyActionSkillNameToTextBuf1
    ret

; prepares the arguments of battle text 06 (entry 6 of BattleTextPrepTable)
; no direct call (reached through a table, a jump or a vector)
BattleTextPrep06:: ; code pointer of the table BattleTextPrepTable; C0
Func_03A_73D2:: ; address name
    call CopyActorNameToTextBuf0
    call CopyTargetNameToTextBuf1
    ret

; prepares the arguments of battle text 35 (entry 53 of BattleTextPrepTable)
; no direct call (reached through a table, a jump or a vector)
BattleTextPrep35:: ; code pointer of the table BattleTextPrepTable; C0
Func_03A_73D9:: ; address name
    call CopyTargetNameToTextBuf0
    call WriteBattleDamageToTextBuf1
    ret

; prepares the arguments of battle text 37 (entry 55 of BattleTextPrepTable)
; no direct call (reached through a table, a jump or a vector)
BattleTextPrep37:: ; code pointer of the table BattleTextPrepTable; C0
Func_03A_73E0:: ; address name
    call CopyTargetNameToTextBuf0
    ret

; prepares the arguments of battle text B8 (entry 184 of BattleTextPrepTable)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wBattleTarget
BattleTextPrepB8:: ; code pointer of the table BattleTextPrepTable; C0
Func_03A_73E4:: ; address name
    call CopyActorNameToTextBuf0
    ld a, [wBattleActor]
    and a, $04
    xor a, $04
    ld c, a
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .set_battle_target
    inc c
    dec b
    jr nz, .loop

.set_battle_target:
    ld a, c
    ld [wBattleTarget], a
    call CopyTargetNameToTextBuf1
    ld a, [wBattleActor]
    ld [wBattleTarget], a
    ret

; prepares the arguments of battle text 21 (entry 33 of BattleTextPrepTable)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wBattleTarget, wBattleStatResultLo
; writes: wBattleStatResultLo
; points at: wTemp0, wPauseMenuStep, wTextBuf0
BattleTextPrep21:: ; code pointer of the table BattleTextPrepTable; C0
Func_03A_7409:: ; address name
    call CopyActorNameToTextBuf1
    call ListSideMonsterIdsToWC0A0
    call ActorOnLocalSide_Bank3A
    jr c, .check_link_mode
    jp CopyTargetOrSideNameToTextBuf0_77C3

.check_link_mode:
    ld a, [wLinkMode]
    or a, a
    jp z, Call774CWithBattleFoeCount_WriteBattleStatResultLo_Skip
    cp a, $02
    jp z, Call774CWithBattleFoeCount_WriteBattleStatResultLo_Skip
    ret

; prepares the arguments of battle text 0F (entry 15 of BattleTextPrepTable)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wBattleTarget, wBattleStatResultLo
; writes: wBattleStatResultLo
; points at: wTemp0, wPauseMenuStep, wTextBuf0
BattleTextPrep0F:: ; code pointer of the table BattleTextPrepTable; C0
Func_03A_7424:: ; address name
    call CopyActorNameToTextBuf1
    ld a, [wLinkMode]
    cp a, $01
    jp z, CopyTargetOrSideNameToTextBuf0_77C3_CallCopyTargetSideNameToTextBuf0
    call ListSideMonsterIdsToWC0A0
    call TargetOnLocalSide_Bank3A
    jp c, CopyTargetOrSideNameToTextBuf0_77C3
    jp Call774CWithBattleFoeCount_WriteBattleStatResultLo_Skip

; prepares the arguments of battle text BE (entry 190 of BattleTextPrepTable)
; no direct call (reached through a table, a jump or a vector)
; points at: wTextBuf0
BattleTextPrepBE:: ; code pointer of the table BattleTextPrepTable; C0
Func_03A_743B:: ; address name
    call CopyActorNameToTextBuf0
    call ListSideMonsterIdsToWC0A0
    call ActorOnLocalSide_Bank3A
    ld a, e
    jr c, .cp_01
    ld a, b

.cp_01:
    cp a, $01
    jr nz, .call_battle_text_prep_be_to_write_monsters
    ld hl, wTextBuf0

.loop:
    ld a, [hl+]
    cp a, $F0
    jr nz, .loop
    dec hl
    ld a, $90
    ld [hl+], a
    ld a, $3A
    ld [hl+], a
    ld a, $24
    ld [hl+], a
    ld a, $36
    ld [hl+], a
    ld a, $F0
    ld [hl], a
    ret

.call_battle_text_prep_be_to_write_monsters:
    call BattleTextPrepBE_ToWriteMonstersWordToTextBuf0
    ld a, $90
    ld [hl+], a
    ld a, $3A
    ld [hl+], a
    ld a, $28
    ld [hl+], a
    ld a, $35
    ld [hl+], a
    ld a, $28
    ld [hl+], a
    ld a, $F0
    ld [hl], a
    ret

; prepares the arguments of battle text 4D (entry 77 of BattleTextPrepTable)
; no direct call (reached through a table, a jump or a vector)
; reads: wLinkMode, wBattleTarget, wBattleStatResultLo
; writes: wBattleStatResultLo
; points at: wTemp0, wPauseMenuStep, wTextBuf0
BattleTextPrep4D:: ; code pointer of the table BattleTextPrepTable; C0
Func_03A_747B:: ; address name
    call ListSideMonsterIdsToWC0A0
    call TargetOnLocalSide_Bank3A
    jp c, CopyTargetOrSideNameToTextBuf0_77C3
    ld a, [wLinkMode]
    cp a, $01
    jp z, CopyTargetOrSideNameToTextBuf0_77C3_CallCopyTargetSideNameToTextBuf0
    jp Call774CWithBattleFoeCount_WriteBattleStatResultLo_Skip

; prepares the arguments of battle text 61 (entry 97 of BattleTextPrepTable)
; no direct call (reached through a table, a jump or a vector)
BattleTextPrep61:: ; code pointer of the table BattleTextPrepTable; C0
Func_03A_748F:: ; address name
    call CopyTargetNameToTextBuf0
    ret

; prepares the arguments of battle text 7E (entry 126 of BattleTextPrepTable)
; no direct call (reached through a table, a jump or a vector)
BattleTextPrep7E:: ; code pointer of the table BattleTextPrepTable; C0
Func_03A_7493:: ; address name
    call CopyTargetNameToTextBuf0
    call CopyActionSkillNameToTextBuf1
    ret

; prepares the arguments of battle text 87 (entry 135 of BattleTextPrepTable)
; no direct call (reached through a table, a jump or a vector)
BattleTextPrep87:: ; code pointer of the table BattleTextPrepTable; C0
Func_03A_749A:: ; address name
    call CopyActionItemNameToTextBuf2
    ret

; prepares the arguments of battle text A0 (entry 160 of BattleTextPrepTable)
; no direct call (reached through a table, a jump or a vector)
BattleTextPrepA0:: ; code pointer of the table BattleTextPrepTable; C0
Func_03A_749E:: ; address name
    call CopyPlayerNameToTextBuf0
    call CopyTargetNameToTextBuf1
    call CopyActionItemNameToTextBuf2
    ret

; prepares the arguments of battle text 94 (entry 148 of BattleTextPrepTable)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleStatResultLo
; writes: wBattleStatResultLo
; points at: wTemp0, wPauseMenuStep, wTextBuf0
BattleTextPrep94:: ; code pointer of the table BattleTextPrepTable; C0
Func_03A_74A8:: ; address name
    call CopyPlayerNameToTextBuf1
    call CopyActionItemNameToTextBuf2
    call ListSideMonsterIdsToWC0A0
    call TargetOnLocalSide_Bank3A
    jp nc, Call774CWithBattleFoeCount_WriteBattleStatResultLo_Skip
    call CopyTargetNameToTextBuf0
    ret

; prepares the arguments of battle text 95 (entry 149 of BattleTextPrepTable)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleTarget, wBattleStatResultLo
; writes: wBattleStatResultLo
; points at: wTemp0, wPauseMenuStep, wTextBuf0
BattleTextPrep95:: ; code pointer of the table BattleTextPrepTable; C0
Func_03A_74BB:: ; address name
    call CopyPlayerNameToTextBuf1
    call ListSideMonsterIdsToWC0A0
    call TargetOnLocalSide_Bank3A
    jp nc, Call774CWithBattleFoeCount_WriteBattleStatResultLo_Skip
    call CopyTargetNameToTextBuf0
    ret

; prepares the arguments of battle text 97 (entry 151 of BattleTextPrepTable)
; no direct call (reached through a table, a jump or a vector)
BattleTextPrep97:: ; code pointer of the table BattleTextPrepTable; C0
Func_03A_74CB:: ; address name
    call CopyPlayerNameToTextBuf0
    call CopyActionItemNameToTextBuf2
    ret

; prepares the arguments of battle text 99 (entry 153 of BattleTextPrepTable)
; no direct call (reached through a table, a jump or a vector)
BattleTextPrep99:: ; code pointer of the table BattleTextPrepTable; C0
Func_03A_74D2:: ; address name
    call CopyPlayerNameToTextBuf0
    ret

; prepares the arguments of battle text 92 (entry 146 of BattleTextPrepTable)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleByteAD
; points at: wTextBuf1
BattleTextPrep92:: ; code pointer of the table BattleTextPrepTable; C0
Func_03A_74D6:: ; address name
    ld a, [wBattleByteAD]
    ld l, a
    ld h, $04
    ld de, wTextBuf1
    call CopyStringHLToDE
    ret

; prepares the arguments of battle text B0 (entry 176 of BattleTextPrepTable)
; no direct call (reached through a table, a jump or a vector)
BattleTextPrepB0:: ; code pointer of the table BattleTextPrepTable; C0
Func_03A_74E3:: ; address name
    call CopyActionSkillNameToTextBuf1
    ret

; prepares the arguments of battle text CA (entry 202 of BattleTextPrepTable)
; no direct call (reached through a table, a jump or a vector)
; reads: wDefeatByteD1
; writes: wNameSlot
; points at: wTextBuf1
BattleTextPrepCA:: ; code pointer of the table BattleTextPrepTable; C0
Func_03A_74E7:: ; address name
    call CopyTargetNameToTextBuf0
    ld a, [wDefeatByteD1]
    ld hl, wTextBuf1
    ld [wNameSlot], a
    call CopySlotNameToHL
    ret

; prepares the arguments of battle text AA (entry 170 of BattleTextPrepTable)
; no direct call (reached through a table, a jump or a vector)
BattleTextPrepAA:: ; code pointer of the table BattleTextPrepTable; C0
Func_03A_74F7:: ; address name
    call CopyActorNameToTextBuf0
    call CopyMappedSlotNameToTextBuf1
    ret

; prepares the arguments of battle text F2 (entry 242 of BattleTextPrepTable)
; no direct call (reached through a table, a jump or a vector)
BattleTextPrepF2:: ; code pointer of the table BattleTextPrepTable; C0
Func_03A_74FE:: ; address name
    call CopyTargetNameToTextBuf2
    call CopyActorNameToTextBuf0
    call CopyMappedSlotNameToTextBuf1
    ret

; copies the actor, skill and target names to wC130/wC140/wC150 and picks the action message from Data_03A_7603 (or special messages $49-$4C) (E-0129)
; 4 call sites from 4 routines (e.g. ApplyActionResultAndMarkFormation, RunBattleActions_StatusChecks_CheckAction_ActorActionIsD0ToE3, RunBattleActions_StatusChecks_CheckAction_QueuedActionMatches, RunBattleStep4_ResolveSkill_CheckSkillMPCost)
; reads: wBattleActionId, wBattleActor, wSavedActorSlot
; writes: wSavedActorSlot, wNameSlot, wStringIndex, wStringCategory
; points at: wBattleTargetChoice, wTextBuf2
BuildActionMessageNames::
Func_03A_7508:: ; address name
    push de
    ld a, [wBattleActionId]
    cp a, $D0
    jr nc, .set_saved_actor_slot_to_01
    xor a, a
    ld [wSavedActorSlot], a
    call CopyActorNameToTextBuf0
    call CopyActionSkillNameToTextBuf1
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a, a
    add_a_to_hl
    ld a, [hl]
    ld hl, wTextBuf2
    ld [wNameSlot], a
    call CopySlotNameToHL
    jr .restore

.set_saved_actor_slot_to_01:
    ld a, $01
    ld [wSavedActorSlot], a
    call CopyActorNameToTextBuf0
    call CopyMappedSlotNameToTextBuf1

.restore:
    pop de
    ld a, d
    cp a, $03
    jp z, .check_saved_actor_slot
    cp a, $04
    jp z, .check_saved_actor_slot3
    cp a, $05
    jp z, .skip3
    cp a, $06
    jp z, .check_saved_actor_slot2
    ld a, [wBattleActionId]
    ld hl, BuildActionMessageNames_Data_7603
    add_a_to_hl
    ld a, [hl]
    ld hl, BuildActionMessageNames_Data_76E7
    dec d
    jr z, .skip
    ld hl, BuildActionMessageNames_Data_76FE

.skip:
    add_a_to_hl
    ld a, [hl]
    jr .loop

.check_saved_actor_slot:
    ld a, [wSavedActorSlot]
    bit 0, a
    jr nz, .skip2
    ld a, $49
    jr .loop

.skip2:
    ld hl, BuildActionMessageNames_Data_75C7
    jr .read_battle_action_id

.skip3:
    ld a, $4A
    jr .loop

.check_saved_actor_slot2:
    ld a, [wSavedActorSlot]
    bit 0, a
    jr nz, .skip4
    ld a, $4B
    jr .loop

.skip4:
    ld hl, BuildActionMessageNames_Data_75DB
    jr .read_battle_action_id

.check_saved_actor_slot3:
    ld a, [wSavedActorSlot]
    bit 0, a
    jr nz, .skip5
    ld a, $4C
    jr .loop

.skip5:
    ld hl, BuildActionMessageNames_Data_75EF
    jr .read_battle_action_id

.loop:
    cp a, $FF
    jr z, .return
    ld [wStringIndex], a
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F

.return:
    ret

.read_battle_action_id:
    ld a, [wBattleActionId]
    sub a, $D0
    add_a_to_hl
    ld a, [hl]
    cp a, $FF
    jr nz, .loop
    ret

; address loaded by BuildActionMessageNames
BuildActionMessageNames_Data_75C7:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_03A_75C7:: ; address name
    db $6C, $6E, $FF, $FF, $FF, $FF, $70, $FF, $80, $72, $FF, $FF, $76, $FF, $FF, $78
    db $FF, $81, $FF, $FF

; address loaded by BuildActionMessageNames
BuildActionMessageNames_Data_75DB:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_03A_75DB:: ; address name
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $74, $75, $FF, $FF, $82, $83
    db $FF, $7A, $FF, $FF

; address loaded by BuildActionMessageNames
BuildActionMessageNames_Data_75EF:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_03A_75EF:: ; address name
    db $6D, $6F, $FF, $FF, $FF, $FF, $71, $FF, $84, $73, $FF, $FF, $77, $FF, $FF, $79
    db $FF, $85, $FF, $FF

; address loaded by BuildActionMessageNames
BuildActionMessageNames_Data_7603:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_03A_7603:: ; address name
    ds $3D, $00
    db $04, $04, $04, $01, $01, $01, $01, $01, $01, $01, $01, $04, $04, $11, $03, $10
    db $11, $06, $07
    ds $18, $03
    db $13, $08, $05, $03, $03, $03, $03, $03, $03, $01, $01, $01, $01, $09, $02, $02
    db $02, $02, $02, $02, $02, $02, $04, $04, $04, $04, $04, $04, $04, $03, $03, $03
    db $03, $12, $03, $03, $03, $03, $03, $03, $03, $04, $03, $0B, $03, $03, $03, $03
    db $03, $04, $04, $0D, $0F, $0A, $03, $03, $0C, $0E
    ds $2E, $00
    db $14, $14, $15, $15, $15, $15, $15, $15, $15, $16, $15, $15, $14, $15, $15, $15
    db $15, $15, $15, $15

; address loaded by BuildActionMessageNames
BuildActionMessageNames_Data_76E7:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_03A_76E7:: ; address name
    db $36, $37, $38, $46, $47, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40, $41, $42, $43
    db $44, $45, $48, $FF, $69, $6A, $6B

; address loaded by BuildActionMessageNames
BuildActionMessageNames_Data_76FE:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_03A_76FE:: ; address name
    db $4D, $4F, $56, $4E, $50, $55, $51, $52, $54, $5F, $5A, $58, $5B, $59, $5C, $FF
    db $4D, $4E, $57, $53, $FF, $FF, $FF

; CopyActorNameToTextBuf0 and CopyMappedSlotNameToTextBuf1, then shows string Data_03A_7738[wBattleActionId - $D0] of category 0 (BeginStringDisplay_Bank2F); used for the $D0+ special actions (E-0118)
; 1 call site from 1 routine (e.g. ApplyActionResultAndMarkFormation)
; reads: wBattleActionId
; writes: wStringIndex, wStringCategory
ShowSpecialActionMessage::
Func_03A_7715:: ; address name
    call CopyActorNameToTextBuf0
    call CopyMappedSlotNameToTextBuf1
    ld a, [wBattleActionId]
    sub a, $D0
    ld hl, ShowSpecialActionMessage_Data
    add_a_to_hl
    ld a, [hl]
    ld [wStringIndex], a
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ret

; address loaded by ShowSpecialActionMessage
ShowSpecialActionMessage_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_03A_7738:: ; address name
    db $66, $66, $67, $67, $67, $67, $67, $67, $67, $68, $67, $67, $66, $67, $67, $67
    db $67, $67, $67, $67

; only called from Call774CWithBattleFoeCount (E-0047)
; 1 call site from 1 routine (e.g. Call774CWithBattleFoeCount)
; reads: hTemp0, wBattleTarget, wBattleStatResultLo
; writes: wBattleStatResultLo
; points at: wTemp0, wPauseMenuStep, wTextBuf0
Call774CWithBattleFoeCount_WriteBattleStatResultLo::
Func_03A_774C:: ; address name
    ldh a, [hTemp0]
    ld b, a

Call774CWithBattleFoeCount_WriteBattleStatResultLo_Skip::
Jump_03A_774F:: ; address name
    ld a, b
    cp a, $01
    jr z, BattleTextPrepBE_ToWriteMonstersWordToTextBuf0_CallCopyTargetNameToTextBuf0
    xor a, a
    ld [wBattleStatResultLo], a
    ld a, [wBattleTarget]
    bit 2, a
    ld hl, wTemp0
    jr z, .skip
    ld hl, wPauseMenuStep

.skip:
    ld a, b
    sub a, $01
    ld e, a
    ld d, $01

.loop:
    ld a, b
    sub a, d
    ld c, a
    push hl
    push de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a

.loop2:
    ld a, e
    cp a, [hl]
    inc hl
    jr nz, .next
    ld a, d
    cp a, [hl]
    jr nz, .next
    ld a, [wBattleStatResultLo]
    inc a
    ld [wBattleStatResultLo], a

.next:
    inc hl
    dec c
    jr nz, .loop2
    pop de
    pop hl
    inc d
    inc hl
    inc hl
    dec e
    jr nz, .loop
    ld a, b
    dec b
    ld c, b
    call Multiply8
    srl h
    rr l
    ld a, [wBattleStatResultLo]
    cp a, l
    jr z, .call_copy_target_name_to_text_buf0
    ld hl, wTextBuf0
    ld [hl], $16
    inc hl
    ld [hl], $32
    inc hl
    ld [hl], $31
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $37
    inc hl
    ld [hl], $28
    inc hl
    ld [hl], $35
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $F0
    ret

.call_copy_target_name_to_text_buf0:
    call CopyTargetNameToTextBuf0
    jr BattleTextPrepBE_ToWriteMonstersWordToTextBuf0

; E = 1: copies the target's name to wC130; otherwise the target side's name followed by the word 'monsters' (E-0122)
; no direct call (reached through a table, a jump or a vector)
CopyTargetOrSideNameToTextBuf0_77C3::
Jump_03A_77C3:: ; address name
    ld a, e
    cp a, $01
    jr z, BattleTextPrepBE_ToWriteMonstersWordToTextBuf0_CallCopyTargetNameToTextBuf0

CopyTargetOrSideNameToTextBuf0_77C3_CallCopyTargetSideNameToTextBuf0::
Jump_03A_77C8:: ; address name
    call CopyTargetSideNameToTextBuf0

; only called from BattleTextPrepBE (E-0047)
; 1 call site from 1 routine (e.g. BattleTextPrepBE)
BattleTextPrepBE_ToWriteMonstersWordToTextBuf0::
Func_03A_77CB:: ; address name
    call WriteMonstersWordToTextBuf0
    ret

BattleTextPrepBE_ToWriteMonstersWordToTextBuf0_CallCopyTargetNameToTextBuf0::
Jump_03A_77CF:: ; address name
    call CopyTargetNameToTextBuf0
    ret

; counts equal pairs among the hFFC6 target words at wC0A0 (or wC0A8 for the foe side); when not all are equal writes a message to wC130 (E-0128)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, wBattleTarget, wBattleStatResultLo
; writes: wBattleStatResultLo
; points at: wTemp0, wPauseMenuStep, wTextBuf0
CheckAllTargetsSame:: ; configured code entry (E-0210); C0
Func_03A_77D3:: ; address name
    ldh a, [hTemp0]
    ld b, a

CheckAllTargetsSame_Skip::
Jump_03A_77D6:: ; address name
    ld a, b
    cp a, $01
    jr z, CopyTargetOrSideNameToTextBuf0_784A_CallCopyTargetNameToTextBuf0
    xor a, a
    ld [wBattleStatResultLo], a
    ld a, [wBattleTarget]
    bit 2, a
    ld hl, wTemp0
    jr z, .skip
    ld hl, wPauseMenuStep

.skip:
    ld a, b
    sub a, $01
    ld e, a
    ld d, $01

.loop:
    ld a, b
    sub a, d
    ld c, a
    push hl
    push de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a

.loop2:
    ld a, e
    cp a, [hl]
    inc hl
    jr nz, .next
    ld a, d
    cp a, [hl]
    jr nz, .next
    ld a, [wBattleStatResultLo]
    inc a
    ld [wBattleStatResultLo], a

.next:
    inc hl
    dec c
    jr nz, .loop2
    pop de
    pop hl
    inc d
    inc hl
    inc hl
    dec e
    jr nz, .loop
    ld a, b
    dec b
    ld c, b
    call Multiply8
    srl h
    rr l
    ld a, [wBattleStatResultLo]
    cp a, l
    jr z, .call_copy_target_name_to_text_buf0
    ld hl, wTextBuf0
    ld [hl], $16
    inc hl
    ld [hl], $32
    inc hl
    ld [hl], $31
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $37
    inc hl
    ld [hl], $28
    inc hl
    ld [hl], $35
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $F0
    ret

.call_copy_target_name_to_text_buf0:
    call CopyTargetNameToTextBuf0
    jr CopyTargetOrSideNameToTextBuf0_784A_CallWriteMonstersWordToTextBuf0

; E = 1: copies the target's name to wC130; otherwise the target side's name followed by the word 'monsters' (E-0122)
; no direct call (reached through a table, a jump or a vector)
CopyTargetOrSideNameToTextBuf0_784A:: ; heuristic: follows a terminator; C0
Func_03A_784A:: ; address name
    ld a, e
    cp a, $01
    jr z, CopyTargetOrSideNameToTextBuf0_784A_CallCopyTargetNameToTextBuf0
    call CopyTargetSideNameToTextBuf0

CopyTargetOrSideNameToTextBuf0_784A_CallWriteMonstersWordToTextBuf0::
Jump_03A_7852:: ; address name
    call WriteMonstersWordToTextBuf0
    ret

CopyTargetOrSideNameToTextBuf0_784A_CallCopyTargetNameToTextBuf0::
Jump_03A_7856:: ; address name
    call CopyTargetNameToTextBuf0
    ret

; when the hFFC6 targets are all the same, copies the target name to wC130; otherwise writes "The monsters" (E-0129)
; no direct call (reached through a table, a jump or a vector)
; reads: hTemp0, wBattleTarget, wBattleStatResultLo
; writes: wBattleStatResultLo
; points at: wTemp0, wPauseMenuStep, wTextBuf0
WriteTargetNameOrTheMonsters:: ; configured code entry (E-0210); C0
Func_03A_785A:: ; address name
    ldh a, [hTemp0]
    ld b, a

WriteTargetNameOrTheMonsters_Skip::
Jump_03A_785D:: ; address name
    ld a, b
    cp a, $01
    jp z, CopyTargetOrSideNameToTextBuf0_78DE_CallCopyTargetNameToTextBuf0
    xor a, a
    ld [wBattleStatResultLo], a
    ld a, [wBattleTarget]
    bit 2, a
    ld hl, wTemp0
    jr z, .skip
    ld hl, wPauseMenuStep

.skip:
    ld a, b
    sub a, $01
    ld e, a
    ld d, $01

.loop:
    ld a, b
    sub a, d
    ld c, a
    push hl
    push de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a

.loop2:
    ld a, e
    cp a, [hl]
    inc hl
    jr nz, .next
    ld a, d
    cp a, [hl]
    jr nz, .next
    ld a, [wBattleStatResultLo]
    inc a
    ld [wBattleStatResultLo], a

.next:
    inc hl
    dec c
    jr nz, .loop2
    pop de
    pop hl
    inc d
    inc hl
    inc hl
    dec e
    jr nz, .loop
    ld a, b
    dec b
    ld c, b
    call Multiply8
    srl h
    rr l
    ld a, [wBattleStatResultLo]
    cp a, l
    jr z, .call_copy_target_name_to_text_buf0
    ld hl, wTextBuf0
    ld [hl], $1D
    inc hl
    ld [hl], $2B
    inc hl
    ld [hl], $28
    inc hl
    ld [hl], $90
    inc hl
    ld [hl], $30
    inc hl
    ld [hl], $32
    inc hl
    ld [hl], $31
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $37
    inc hl
    ld [hl], $28
    inc hl
    ld [hl], $35
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $F0
    ret

.call_copy_target_name_to_text_buf0:
    call CopyTargetNameToTextBuf0
    jr CopyTargetOrSideNameToTextBuf0_78DE_CallWriteMonstersWordToTextBuf0

; E = 1: copies the target's name to wC130; otherwise the target side's name followed by the word 'monsters' (E-0122)
; no direct call (reached through a table, a jump or a vector)
CopyTargetOrSideNameToTextBuf0_78DE:: ; heuristic: follows a terminator; C0
Func_03A_78DE:: ; address name
    ld a, e
    cp a, $01
    jr z, CopyTargetOrSideNameToTextBuf0_78DE_CallCopyTargetNameToTextBuf0
    call CopyTargetSideNameToTextBuf0

CopyTargetOrSideNameToTextBuf0_78DE_CallWriteMonstersWordToTextBuf0::
Jump_03A_78E6:: ; address name
    call WriteMonstersWordToTextBuf0
    ret

CopyTargetOrSideNameToTextBuf0_78DE_CallCopyTargetNameToTextBuf0::
Jump_03A_78EA:: ; address name
    call CopyTargetNameToTextBuf0
    ret

; wD86C = wBattleActor, then CopySlotNameToHL with HL = wC130 (E-0113)
; 16 call sites from 15 routines (e.g. BattleText0HookActorAndMappedSlot, BattleText0HookActorAndSkill_7162, BattleText0Hook3F, BattleText0HookActorAndSkill_7154, ...)
; reads: wBattleActor
; writes: wNameSlot
; points at: wTextBuf0
CopyActorNameToTextBuf0::
Func_03A_78EE:: ; address name
    ld a, [wBattleActor]
    ld hl, wTextBuf0
    ld [wNameSlot], a
    call CopySlotNameToHL
    ret

; wD86C = wBattleActor, then CopySlotNameToHL with HL = wC140 (E-0116)
; 2 call sites from 2 routines (e.g. BattleTextPrep21, BattleTextPrep0F)
; reads: wBattleActor
; writes: wNameSlot
; points at: wTextBuf1
CopyActorNameToTextBuf1::
Func_03A_78FB:: ; address name
    ld a, [wBattleActor]
    ld hl, wTextBuf1
    ld [wNameSlot], a
    call CopySlotNameToHL
    ret

; far-calls Func_0A3_414F (which maps the actor to a slot in hFFC6), then copies that slot's name to wC140 (CopySlotNameToHL) (E-0113)
; 5 call sites from 5 routines (e.g. BattleText0HookActorAndMappedSlot, BattleTextPrepF2, BattleTextPrepAA, BuildActionMessageNames, ...)
; reads: hTemp0
; writes: wNameSlot
; points at: wTextBuf1
CopyMappedSlotNameToTextBuf1::
Func_03A_7908:: ; address name
    farcall ActorFormationSlotToTemp0
    ldh a, [hTemp0]
    ld hl, wTextBuf1
    ld [wNameSlot], a
    call CopySlotNameToHL
    ret

; copies string wBattleActionId of category 4 (skill names) to wC140 (CopyStringHLToDE) (E-0116)
; 6 call sites from 6 routines (e.g. BattleText0HookActorAndSkill_7162, BattleText0HookActorAndSkill_7154, BattleTextPrepB0, BattleTextPrep7E, ...)
; reads: wBattleActionId
; points at: wTextBuf1
CopyActionSkillNameToTextBuf1::
Func_03A_791A:: ; address name
    ld a, [wBattleActionId]
    ld l, a
    ld h, $04
    ld de, wTextBuf1
    call CopyStringHLToDE
    ret

; wD86C = wBattleTarget, then CopySlotNameToHL with HL = wC130 (E-0077)
; 18 call sites from 18 routines (e.g. BattleText0HookTargetAndDefeatSlot, BattleText0Hook7E, BattleText0Hook33, BattleText0HookTargetNameAndGroupWord, ...)
; reads: wBattleTarget
; writes: wNameSlot
; points at: wTextBuf0
CopyTargetNameToTextBuf0::
Func_03A_7927:: ; address name
    ld a, [wBattleTarget]
    ld hl, wTextBuf0
    ld [wNameSlot], a
    call CopySlotNameToHL
    ret

; wD86C = wBattleTarget, then CopySlotNameToHL with HL = wC140 (E-0116)
; 3 call sites from 3 routines (e.g. BattleTextPrepB8, BattleTextPrepA0, BattleTextPrep06)
; reads: wBattleTarget
; writes: wNameSlot
; points at: wTextBuf1
CopyTargetNameToTextBuf1::
Func_03A_7934:: ; address name
    ld a, [wBattleTarget]
    ld hl, wTextBuf1
    ld [wNameSlot], a
    call CopySlotNameToHL
    ret

; wD86C = wBattleTarget, then CopySlotNameToHL with HL = wC150 (E-0116)
; 2 call sites from 2 routines (e.g. BattleText0Hook3F, BattleTextPrepF2)
; reads: wBattleTarget
; writes: wNameSlot
; points at: wTextBuf2
CopyTargetNameToTextBuf2::
Func_03A_7941:: ; address name
    ld a, [wBattleTarget]
    ld hl, wTextBuf2
    ld [wNameSlot], a
    call CopySlotNameToHL
    ret

; wTextBuf1 = wBattleDamage as a decimal string (WriteBCAsDecimalString) (E-0210)
; 2 call sites from 2 routines (e.g. BattleText0HookActorNameAndDamage, BattleTextPrep35)
; reads: wBattleDamageLo, wBattleDamageHi
; points at: wTextBuf1
WriteBattleDamageToTextBuf1::
Func_03A_794E:: ; address name
    ld hl, wTextBuf1
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    call WriteBCAsDecimalString
    ret

; wD86C = wBattleTarget & 4 (the first slot of the target's side), then CopySlotNameToHL with HL = wC130 (E-0113)
; 3 call sites from 3 routines (e.g. CopyTargetOrSideNameToTextBuf0_77C3, CopyTargetOrSideNameToTextBuf0_78DE, CopyTargetOrSideNameToTextBuf0_784A)
; reads: wBattleTarget
; writes: wNameSlot
; points at: wTextBuf0
CopyTargetSideNameToTextBuf0::
Func_03A_795D:: ; address name
    ld a, [wBattleTarget]
    and a, $04
    ld hl, wTextBuf0
    ld [wNameSlot], a
    call CopySlotNameToHL
    ret

; copies the name at wC60C (5 glyphs, CopyFiveGlyphsPlusMarks) to wC130 (E-0116)
; 3 call sites from 3 routines (e.g. BattleTextPrepA0, BattleTextPrep99, BattleTextPrep97)
; points at: wPlayerName, wTextBuf0
CopyPlayerNameToTextBuf0::
Func_03A_796C:: ; address name
    ld de, wPlayerName
    ld hl, wTextBuf0
    call CopyFiveGlyphsPlusMarks
    ret

; copies the name at wC60C (5 glyphs) to wC140 (E-0116)
; 2 call sites from 2 routines (e.g. BattleTextPrep95, BattleTextPrep94)
; points at: wPlayerName, wTextBuf1
CopyPlayerNameToTextBuf1::
Func_03A_7976:: ; address name
    ld de, wPlayerName
    ld hl, wTextBuf1
    call CopyFiveGlyphsPlusMarks
    ret

; copies string wBattleActionId of category 5 (item names) to wC150 (CopyStringHLToDE) (E-0116)
; 4 call sites from 4 routines (e.g. BattleTextPrepA0, BattleTextPrep97, BattleTextPrep94, BattleTextPrep87)
; reads: wBattleActionId
; points at: wTextBuf2
CopyActionItemNameToTextBuf2::
Func_03A_7980:: ; address name
    ld a, [wBattleActionId]
    ld l, a
    ld h, $05
    ld de, wTextBuf2
    call CopyStringHLToDE
    ret

; wD86C = wBattleActor & 4 (the first slot of the actor's side), then CopySlotNameToHL with HL = wC130 (E-0116)
; no direct call (reached through a table, a jump or a vector)
; reads: wBattleActor
; writes: wNameSlot
; points at: wTextBuf0
CopyActorSideNameToTextBuf0:: ; heuristic: follows a terminator; C0
Func_03A_798D:: ; address name
    ld a, [wBattleActor]
    and a, $04
    ld hl, wTextBuf0
    ld [wNameSlot], a
    call CopySlotNameToHL
    ret

; A = battle slot: slots 0-2 go to CopyBattlerNameToHL; other slots take paths that check slot 3/7, wC58A and wDAD4 (not fully read) (E-0077)
; 13 call sites from 13 routines (e.g. BattleText0HookTargetAndDefeatSlot, CopyTargetNameToTextBuf0, CopyMappedSlotNameToTextBuf1, CopyActorNameToTextBuf0, ...)
; reads: wLinkMode, wNameSlot
; writes: wBattleArg1
; points at: wSlotNameBytes
CopySlotNameToHL::
Func_03A_799C:: ; address name
    cp a, $03
    jr nc, CopyBattlerNameToHL_Skip

; A = battle slot (0-2 or 4-6): copies the name at offset 0 of the slot's battler record (5 glyphs, CopyFiveGlyphsPlusMarks) to HL and leaves HL on the $F0 terminator; BC kept (E-0077)
; 1 call site from 1 routine (e.g. CopyBattlerNameToHL_CopyStringHLToDE)
CopyBattlerNameToHL::
Func_03A_79A0:: ; address name
    push hl
    push bc
    ld e, BATTLER_NAME
    call BattlerRecordFieldAddress
    ld e, l
    ld d, h
    pop bc
    pop hl
    push hl
    call CopyFiveGlyphsPlusMarks
    pop hl

.skip:
    ld a, [hl]
    cp a, $F0
    ret z
    inc hl
    jr .skip

CopyBattlerNameToHL_Loop::
Jump_03A_79B7:: ; address name
    ld a, b
    pop bc
    jr CopyBattlerNameToHL

CopyBattlerNameToHL_Skip::
Jump_03A_79BB:: ; address name
    push bc
    ld b, a
    and a, $03
    cp a, $03
    ld a, b
    pop bc
    jr z, .call_copy_battler_name_to_hl_copy_string_hl
    push bc
    ld b, a
    ld a, [wLinkMode]
    cp a, $01
    jr z, CopyBattlerNameToHL_Loop
    push hl
    ld a, b
    and a, $03
    ld hl, wSlotNameBytes
    add_a_to_hl
    ld a, [hl]
    pop hl
    cp a, $FF
    jr nz, .restore
    ld a, b

.restore:
    pop bc
    jr nz, CopyBattlerNameToHL_CopyStringHLToDE_CallCopyBattlerNameToHL

.call_copy_battler_name_to_hl_copy_string_hl:
    push af
    call CopyBattlerNameToHL_CopyStringHLToDE
    pop af
    call CopyBattlerNameToHL_ListSideMonsterIdsToWC0A0
    ret

; only called from CopyBattlerNameToHL (E-0047)
; 1 call site from 1 routine (e.g. CopyBattlerNameToHL)
; writes: wBattleTemp7C, wBattleTemp7A, wBattleTemp7B
; points at: wBattleMonsterId
CopyBattlerNameToHL_CopyStringHLToDE::
Func_03A_79ED:: ; address name
    ld [wBattleTemp7C], a
    push hl
    ld hl, wBattleMonsterId
    add a, a
    add_a_to_hl
    push bc
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    add a, $02
    ld h, a
    ld l, c
    pop bc
    pop de
    ld a, e
    ld [wBattleTemp7A], a
    ld a, d
    ld [wBattleTemp7B], a
    call CopyStringHLToDE
    ret

CopyBattlerNameToHL_CopyStringHLToDE_CallCopyBattlerNameToHL::
Jump_03A_7A10:: ; address name
    call CopyBattlerNameToHL
    ld a, $47
    ld [hl+], a
    ld [hl], $F0
    push hl
    ld hl, wSlotNameBytes
    ld a, [wNameSlot]
    and a, $03
    cp a, $01
    jr z, .skip
    cp a, $02
    jr z, .skip2
    ld a, [hl+]
    cp a, [hl]
    jr z, .restore
    inc hl
    cp a, [hl]
    jr z, .restore
    jr .clear_battle_arg1

.skip:
    ld a, [hl+]
    cp a, [hl]
    jr z, .set_battle_arg1_to_0B
    ld a, [hl+]
    cp a, [hl]
    jr z, .restore
    jr .clear_battle_arg1

.skip2:
    ld d, $00
    inc hl
    inc hl
    ld a, [hl-]
    dec hl
    cp a, [hl]
    jr nz, .next
    inc d

.next:
    inc hl
    cp a, [hl]
    jr nz, .skip3
    inc d

.skip3:
    ld a, d
    or a, a
    jr z, .clear_battle_arg1
    cp a, $01
    jr z, .set_battle_arg1_to_0B
    pop hl
    ld a, $0C
    jr .set_battle_arg1

.restore:
    pop hl
    ld a, $0A
    jr .set_battle_arg1

.set_battle_arg1_to_0B:
    pop hl
    ld a, $0B

.set_battle_arg1:
    ld [wBattleArg1], a
    ld [hl+], a
    ld [hl], $F0
    ret

.clear_battle_arg1:
    pop hl
    xor a, a
    ld [wBattleArg1], a
    ret

; only called from CopyBattlerNameToHL (E-0047)
; 1 call site from 1 routine (e.g. CopyBattlerNameToHL)
; reads: wBattleTemp7C, wTemp0, wBattleTemp7A, wBattleTemp7B
; writes: wTemp0
; points at: wBattleMonsterId, wTemp0
CopyBattlerNameToHL_ListSideMonsterIdsToWC0A0::
Func_03A_7A6E:: ; address name
    call ListSideMonsterIdsToWC0A0
    inc b
    ld c, $04
    xor a, a
    ld [wTemp0], a
    ld a, [wBattleTemp7C]
    add a, a
    ld hl, wBattleMonsterId
    add_a_to_hl
    ld a, [hl+]
    ld d, [hl]
    ld e, a

.loop:
    ld a, c
    add a, a
    ld hl, wBattleMonsterId
    add_a_to_hl
    ld a, [hl+]
    cp a, e
    jr nz, .next
    ld a, [hl]
    cp a, d
    jr nz, .next
    ld a, [wBattleTemp7C]
    cp a, c
    jp z, .check_temp0
    ld hl, wTemp0
    inc [hl]

.next:
    inc c
    dec b
    jr nz, .loop
    ret

.check_temp0:
    ld a, [wTemp0]
    or a, a
    jr nz, .read_battle_temp7_a
    inc c

.loop2:
    ld a, c
    add a, a
    ld hl, wBattleMonsterId
    add_a_to_hl
    ld a, [hl+]
    cp a, e
    jr nz, .next2
    ld a, [hl]
    cp a, d
    jr z, .read_battle_temp7_a

.next2:
    inc c
    dec b
    jr nz, .loop2
    ret

.read_battle_temp7_a:
    ld a, [wBattleTemp7A]
    ld l, a
    ld a, [wBattleTemp7B]
    ld h, a
    ld a, [wTemp0]
    add a, $0A
    push af

.skip:
    ld a, [hl]
    cp a, $F0
    jr z, .restore
    inc hl
    jr .skip

.restore:
    pop af
    ld [hl+], a
    ld a, $F0
    ld [hl], a
    ret

; clears wC0A0 ($10 bytes) and lists the species ids of the occupied slots of the shown side at wC0A0 and of the other side at wC0A8 (E-0129)
; 17 call sites from 16 routines (e.g. ActionEffect_Ironize_ReadLinkModeAndBattleTarget, CopyBattlerNameToHL_ListSideMonsterIdsToWC0A0, BattleText0Hook7E, BattleText0Hook0E, ...)
; reads: wLinkMode, wLinkRole
; points at: wTemp0, wBattleMonsterId, wPauseMenuStep
ListSideMonsterIdsToWC0A0::
Func_03A_7AE3:: ; address name
    xor a, a
    ld hl, wTemp0
    ld bc, $0010
    call FillBytes
    ld de, $0000
    ld c, $00
    ld a, [wLinkMode]
    cp a, $01
    jr nz, .call_carry_unless_battle_slot_out_slot_empty
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_carry_unless_battle_slot_out_slot_empty
    ld c, $04

.call_carry_unless_battle_slot_out_slot_empty:
    ld b, $03

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next
    ld a, e
    add a, a
    ld hl, wTemp0
    add_a_to_hl
    push de
    ld a, c
    add a, a
    ld de, wBattleMonsterId
    add a, e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl+], a
    pop de
    inc e

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $04
    ld a, [wLinkMode]
    cp a, $01
    jr nz, .call_carry_unless_battle_slot_out_slot_empty2
    ld a, [wLinkRole]
    bit 1, a
    jr z, .call_carry_unless_battle_slot_out_slot_empty2
    ld c, $00

.call_carry_unless_battle_slot_out_slot_empty2:
    ld b, $03

.loop2:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .next2
    ld a, d
    add a, a
    ld hl, wPauseMenuStep
    add_a_to_hl
    push de
    ld a, c
    add a, a
    ld de, wBattleMonsterId
    add a, e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    ld [hl+], a
    inc de
    ld a, [de]
    ld [hl], a
    pop de
    inc d

.next2:
    inc c
    dec b
    jr nz, .loop2
    ld b, d
    ret

; only called from ActionEffect_Ironize (E-0047)
; 1 call site from 1 routine (e.g. ActionEffect_Ironize)
; reads: wLinkMode, wBattleTarget
ActionEffect_Ironize_ReadLinkModeAndBattleTarget::
Func_03A_7B66:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr z, .call_list_side_monster_ids_to_wc0_a0
    ld a, [wBattleTarget]
    cp a, $04
    jr c, .call_list_side_monster_ids_to_wc0_a0

.loop:
    ld d, $47
    ret

.call_list_side_monster_ids_to_wc0_a0:
    call ListSideMonsterIdsToWC0A0
    ld a, e
    cp a, $01
    jr z, .loop
    ld d, $46
    ret

; writes the glyphs of 'Monsters' (decoded with the charmap) and $F0 to wC130 (E-0113)
; 4 call sites from 4 routines (e.g. BattleText0HookTargetNameAndGroupWord, CopyTargetOrSideNameToTextBuf0_784A, CopyTargetOrSideNameToTextBuf0_78DE, BattleTextPrepBE_ToWriteMonstersWordToTextBuf0)
; points at: wTextBuf0
WriteMonstersWordToTextBuf0::
Func_03A_7B82:: ; address name
    ld hl, wTextBuf0
    ld [hl], $16
    inc hl
    ld [hl], $32
    inc hl
    ld [hl], $31
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $37
    inc hl
    ld [hl], $28
    inc hl
    ld [hl], $35
    inc hl
    ld [hl], $36
    inc hl
    ld [hl], $F0
    ret

; only called from routines of RunBattleSetup (E-0098)
; 3 call sites from 3 routines (e.g. RunBattleSetup_CommandMenu_DrawWC2B8LeftToBGMapRow9_74B4AndStep_Case0C, RunBattleSetup_CommandMenu_CopyRectRecord7750ToScreenBufferFar, RunBattleSetup_Case02_CopyRectRecord7750ToScreenBufferFar)
; reads: wLinkMode, wBattleArg1, wSlotChoices, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth, wLinkRole
; writes: wNameSlot, wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; points at: wSlotChoices, wTextBuf0
RunBattleSetup_CarryUnlessBattleSlotOutSlotEmpty_Shared03::
Func_03A_7BA0:: ; address name
    ld a, $FF
    ld hl, wSlotChoices
    ld bc, $0003
    call FillBytes
    ld a, [wLinkMode]
    cp a, $01
    jr z, .read_link_role
    ld c, $04
    jr .skip

.read_link_role:
    ld a, [wLinkRole]
    sla a
    and a, $04
    xor a, $04
    ld c, a

.skip:
    ld b, $03
    ld e, $00

.loop:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr z, .next
    jr nc, .skip2
    ld a, [wBattleArg1]
    or a, a
    jr z, .next

.skip2:
    ld a, e
    ld hl, wSlotChoices
    add_a_to_hl
    ld [hl], c

.next:
    inc e
    inc c
    dec b
    jr nz, .loop
    ld a, [wSlotChoices]
    ld hl, vTiles1 + $6D0
    call RunBattleSetup_Shared03_CopySlotNameToHL
    ld hl, vTiles1 + $770
    ld a, [wSlotChoices + $1]
    call RunBattleSetup_Shared03_CopySlotNameToHL
    ld hl, vTiles2 + $10
    ld a, [wSlotChoices + $2]

; only called from RunBattleSetup_Shared03 (E-0047)
; 2 call sites from 1 routine (e.g. RunBattleSetup_CarryUnlessBattleSlotOutSlotEmpty_Shared03)
; reads: wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; writes: wNameSlot, wStringCategory, wStringIndex, wTextWindowTileLo, wTextWindowTileHi, wTextWindowRows, wTextWindowWidth
; points at: wTextBuf0
RunBattleSetup_Shared03_CopySlotNameToHL::
Func_03A_7BF9:: ; address name
    cp a, $FF
    jr z, .set_string_category_to_02
    push hl
    ld hl, wTextBuf0
    ld [wNameSlot], a
    call CopySlotNameToHL
    ld a, $08
    ld [wStringCategory], a
    ld a, $05
    ld [wStringIndex], a
    pop hl
    jr .read_text_window_tile_lo

.set_string_category_to_02:
    ld a, $02
    ld [wStringCategory], a
    ld a, $00
    ld [wStringIndex], a

.read_text_window_tile_lo:
    ld de, $0A01
    ld a, [wTextWindowTileLo]
    ld c, a
    ld a, [wTextWindowTileHi]
    ld b, a
    push bc
    ld a, [wTextWindowRows]
    ld c, a
    ld a, [wTextWindowWidth]
    ld b, a
    push bc
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    farcall ShowString_Bank08
    pop de
    pop hl
    ld a, l
    ld [wTextWindowTileLo], a
    ld a, h
    ld [wTextWindowTileHi], a
    ld a, e
    ld [wTextWindowRows], a
    ld a, d
    ld [wTextWindowWidth], a
    ret
    db $21, $FF, $D8, $18, $28, $21, $0F, $D9, $18, $23

; A = battle slot: HL = the word for that slot at wBattleMaxHP; A = its low byte (E-0064)
; 1 call site from 1 routine (e.g. RunBattleActions_WearOffAndDefeat_Case02_GetBattleMaxHP_Bank3A)
; points at: wBattleMaxHP
GetBattleMaxHP_Bank3A::
Func_03A_7C66:: ; address name
    ld hl, wBattleMaxHP
    jr GetBattleMP_Bank3A_Skip

; A = battle slot: HL = the word for that slot at wBattleMaxMP; A = its low byte (E-0064)
; 1 call site from 1 routine (e.g. RunActionResolveStep_CarryUnlessBattleSlotOutSlotEmpty)
; points at: wBattleMaxMP
GetBattleMaxMP_Bank3A::
Func_03A_7C6B:: ; address name
    ld hl, wBattleMaxMP
    jr GetBattleMP_Bank3A_Skip
    db $21, $BF, $D8, $18, $14

; A = battle slot: HL = the word for that slot at wBattleMP; A = its low byte (E-0064)
; 1 call site from 1 routine (e.g. RunActionResolveStep_CarryUnlessBattleSlotOutSlotEmpty)
; points at: wBattleMP
GetBattleMP_Bank3A::
Func_03A_7C75:: ; address name
    ld hl, wBattleMP
    jr GetBattleMP_Bank3A_Skip
    db $21, $1F, $D9, $18, $0A, $21, $53, $DA, $85, $6F, $30, $01, $24, $7E, $C9

GetBattleMP_Bank3A_Skip::
Jump_03A_7C89:: ; address name
    add a, a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes appear in 12 banks)
; 4 call sites from 4 routines (e.g. RunBattleActions_WearOffAndDefeat_Case02_AddDoubleAToHL_Bank3A, RunActionResolveStep_AddDoubleAToHL_Bank3A, RunActionResolveStep_CarryUnlessBattleSlotOutSlotEmpty_Case04, RunActionResolveStep_CarryUnlessBattleSlotOutSlotEmpty)
AddDoubleAToHL_Bank3A::
Func_03A_7C93:: ; address name
    add a, a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
; 4 call sites from 4 routines (e.g. SelectEffectByEffectFlags2Flags, SelectEffectByEffectFlags, BattleTextPrepBE, BattleTextPrep21)
; reads: wLinkMode, wLinkRole, wBattleActor
ActorOnLocalSide_Bank3A::
Func_03A_7C9A:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr nz, .check_battle_actor
    ld a, [wLinkRole]
    bit 1, a
    jr z, .check_battle_actor
    ld a, [wBattleActor]
    cp a, $04
    ccf
    ret

.check_battle_actor:
    ld a, [wBattleActor]
    cp a, $04
    ret

; carry set when wBattleTarget < 4 (slots 0-3); when wC58A = 1 and wC57F bit 1 is set the test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 12 banks)
; 8 call sites from 7 routines (e.g. SelectEffectByEffectFlags, BattleTextPrep95, BattleTextPrep94, BattleTextPrep4D, ...)
; reads: wLinkMode, wLinkRole, wBattleTarget
TargetOnLocalSide_Bank3A::
Func_03A_7CB5:: ; address name
    ld a, [wLinkMode]
    cp a, $01
    jr nz, .check_battle_target
    ld a, [wLinkRole]
    bit 1, a
    jr z, .check_battle_target
    ld a, [wBattleTarget]
    cp a, $04
    ccf
    ret

.check_battle_target:
    ld a, [wBattleTarget]
    cp a, $04
    ret

; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStatus
ClearBattleStatusBitsWithMaskD_Bank3A:: ; heuristic: same first 16 bytes (in-bank addresses taken relative) as the routine at 05:4075; C0
Func_03A_7CD0:: ; address name
    ld a, d
    ld hl, ClearBattleStatusBitsWithMaskD_Bank3A_Data
    add_a_to_hl
    ld d, [hl]
    ld a, e
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, d
    and a, [hl]
    ld [hl], a
    ret

; address loaded by ClearBattleStatusBitsWithMaskD_Bank3A
ClearBattleStatusBitsWithMaskD_Bank3A_Data:: ; heuristic: pointer load in the same bank (bank assumed); C0
Data_03A_7CE5:: ; address name
    db $DF, $FE, $00, $FD, $73, $EF, $BF

; Sets bit 0 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; 1 call site from 1 routine (e.g. RunBattleActions_WearOffAndDefeat_Case02_AddDoubleAToHL_Bank3A)
; points at: wLevelUpGains
SetBit0OfLevelUpGainsIndexed_Bank3A::
Func_03A_7CEC:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; 1 call site from 1 routine (e.g. RunActionResolveStep_CarryUnlessBattleSlotOutSlotEmpty)
; points at: wLevelUpGains
SetBit1OfLevelUpGainsIndexed_Bank3A::
Func_03A_7CF9:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wD095 + A; keeps HL; clobbers A (the same 13 bytes appear in 12 banks)
; 3 call sites from 3 routines (e.g. RunBattleActions_WearOffAndDefeat_Case02_AddDoubleAToHL_Bank3A, RunActionResolveStep_SetBit2OfLevelUpGainsIndexed_Bank3A, RunActionResolveStep_CarryUnlessBattleSlotOutSlotEmpty_Case01)
; points at: wLevelUpGains
SetBit2OfLevelUpGainsIndexed_Bank3A::
Func_03A_7D06:: ; address name
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

; A = slot 0-7: returns A = 9 * g(wD968[A]) + 3 * g(wD970[A]) + g(wD978[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes appear in 13 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wSlotPersonalityHi, wSlotPersonalityMid, wSlotPersonalityLo
PersonalityIndexOfSlot_Bank3A:: ; heuristic: follows a terminator; C0
Func_03A_7D13:: ; address name
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, .skip
    ld l, $09
    cp a, $40
    jr nc, .skip
    ld l, $12

.skip:
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityMid
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, .skip2
    ld l, $03
    cp a, $40
    jr nc, .skip2
    ld l, $06

.skip2:
    ld a, l
    add a, b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp a, $C0
    jr nc, .skip3
    ld l, $01
    cp a, $40
    jr nc, .skip3
    ld l, $02

.skip3:
    ld a, l
    add a, b
    pop bc
    pop hl
    ret

; A = slot: carry set when CheckSlotStatusBlock sets it, or when status byte 3 & $C0 or byte 4 & $0C is set (wD80F + 9 * A); otherwise carry clear; A, BC, HL kept (E-0067) (the same 31 bytes appear in 12 banks)
; 2 call sites from 2 routines (e.g. RunBattleActions_ShowHeroBlewBackG, RunActionResolveStep_Case09_CheckSlotStatusBlockWide_Bank3A)
; points at: wBattleStatus3
CheckSlotStatusBlockWide_Bank3A::
Func_03A_7D6A:: ; address name
    call CheckSlotStatusBlock
    ret c
    push hl
    push bc
    ld c, a
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, .set_carry
    ld a, [hl]
    and a, $0C
    jr nz, .set_carry
    xor a, a
    jr .skip

.set_carry:
    scf

.skip:
    ld a, c
    pop bc
    pop hl
    ret

; A = slot: with HL = wD80F + 9 * A (status byte 3 of wBattleStatus), A = byte 3 & $C0, or byte 4 & $0C when that is zero; Z set when both are clear; HL kept (E-0067) (the same 17 bytes appear in 13 banks)
; no direct call (reached through a table, a jump or a vector)
; points at: wBattleStatus3
SlotHasStatus3Or4Bits_Bank3A:: ; heuristic: follows a terminator; C0
Func_03A_7D89:: ; address name
    push hl
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hl+]
    and a, $C0
    jr nz, .done
    ld a, [hl]
    and a, $0C

.done:
    pop hl
    ret

; E-0173 (C1: LoadEffectOBJPaletteC copies the 8 bytes at $7D9A + 8 * C to wOBJPaletteBuffer on CGB; 59 whole palettes lie before the label at $7F79).
; record: one CGB OBJ palette: 4 BGR555 colours
EffectOBJPalettes::
Data_03A_7D9A:: ; address name
    dw $0000, $02FF, $0017, $01DF ; id 0
    dw $0000, $02FF, $0017, $01DF ; id 1
    dw $0000, $02FF, $0017, $01DF ; id 2
    dw $0000, $035F, $001F, $01FF ; id 3
    dw $0000, $035F, $001F, $01FF ; id 4
    dw $0000, $035F, $001F, $01FF ; id 5
    dw $0000, $7FFF, $02FF, $3DD3 ; id 6
    dw $0000, $7FFF, $02FF, $3DD3 ; id 7
    dw $0000, $7FFF, $02FF, $4DAF ; id 8
    dw $0000, $4BFF, $55F3, $3D6D ; id 9
    dw $0000, $4BFF, $55F3, $3D6D ; id 10
    dw $0000, $4BFF, $55F3, $3D6D ; id 11
    dw $0000, $7F34, $5A0C, $7DC0 ; id 12
    dw $0000, $7F34, $5A0C, $7DC0 ; id 13
    dw $0000, $7F34, $5A0C, $7DC0 ; id 14
    dw $0000, $03FF, $55F3, $3D6D ; id 15
    dw $0000, $03FF, $55F3, $3D6D ; id 16
    dw $0000, $03FF, $55F3, $3D6D ; id 17
    dw $0000, $2DDF, $4AB8, $7DF2 ; id 18
    dw $0000, $4BE0, $02FF, $7DC8 ; id 19
    dw $0000, $02FF, $60B9, $0000 ; id 20
    dw $0000, $4B1C, $3D7B, $0000 ; id 21
    dw $0000, $4BE0, $7E3F, $64F3 ; id 22
    dw $0000, $56B2, $1E37, $64F3 ; id 23
    dw $0000, $4B1C, $119F, $20B1 ; id 24
    dw $0000, $5F72, $7D37, $20B1 ; id 25
    dw $0000, $6BF5, $5A0C, $7DC8 ; id 26
    dw $0000, $4B1C, $1DF4, $00E9 ; id 27
    dw $0000, $02FF, $00FF, $00B1 ; id 28
    dw $0000, $4BFF, $017F, $0000 ; id 29
    dw $0000, $4BFF, $017F, $0000 ; id 30
    dw $0000, $03FF, $55F3, $3D6D ; id 31
    dw $0000, $4BFF, $55F3, $3D6D ; id 32
    dw $0000, $7F34, $5A0C, $7DC0 ; id 33
    dw $0000, $4B1C, $1DF4, $00E9 ; id 34
    dw $0000, $375F, $01DD, $00E9 ; id 35
    dw $0000, $5FFF, $6BEB, $00E9 ; id 36
    dw $0000, $5FFF, $01DF, $00E9 ; id 37
    dw $0000, $7F59, $7D37, $00E9 ; id 38
    dw $0000, $5FFF, $02FF, $01DF ; id 39
    dw $0000, $339F, $50CB, $4C1A ; id 40
    dw $0000, $47FF, $0A9C, $00E9 ; id 41
    dw $0000, $63F9, $01DF, $0015 ; id 42
    dw $0000, $7FFB, $6E21, $72AB ; id 43
    dw $0000, $7FFF, $7FFF, $013B ; id 44
    dw $0000, $7FE8, $7CC0, $4520 ; id 45
    dw $0000, $7FE8, $7CC0, $48D1 ; id 46
    dw $0000, $7FE8, $7CC0, $48D1 ; id 47
    dw $0000, $7FE8, $7CC0, $0000 ; id 48
    dw $0000, $7FE8, $7CC0, $0000 ; id 49
    dw $0000, $5FF2, $7CCB, $0000 ; id 50
    dw $0000, $03FF, $55F3, $3D6D ; id 51
    dw $0000, $7FFF, $7E59, $002B ; id 52
    dw $0000, $7FE8, $7CC0, $48D1 ; id 53
    dw $0000, $7F59, $7D37, $3D6D ; id 54
    dw $0000, $4B1C, $1DF4, $00E9 ; id 55
    dw $0000, $7F59, $7D37, $3D6D ; id 56
    dw $0000, $63FF, $01DF, $0015 ; id 57
    dw $0000, $63FF, $01DF, $0015 ; id 58
    db $00, $00, $FD, $03, $DF, $01, $15
    ds $87, $00
