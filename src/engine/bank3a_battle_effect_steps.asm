; ROM bank $3A: battle effect steps and battle text hooks
; The annotated listing of this bank is build/listing/bank3a.asm.

SECTION "Bank 3A", ROMX[$4000], BANK[$3A]
    db $3a

; Starts the battle effect of an action from wEffectFlags. A target in a fourth slot (wBattleTarget
; & 3 = 3) returns at once unless wBattleActionId is from SKILL_TATSUCALL up to below SKILL_SUCKAIR
; and wEffectFlags has bit 0 or 6. Then the highest flag decides: bit 7 reads
; ActionEffectTable_Flag7; bit 6 (only with bit 0) ActionEffectTable_Flag6; bit 5
; ActionEffectTable_Flag5; bit 4 (only with bit 0) needs no table and gives effect routine 2 or 3 by
; the side of the target, or effect $14 when (flags >> 1) & 7 is 1; bit 3 and bit 2 first copy
; wBattleTarget to wBattleActor and read ActionEffectTable_Flag3 and ActionEffectTable_Flag2. A
; table has two bytes per action id, the second for an actor below slot 4 (the target decides for
; action $6C, when wRedirectFlags bit 0 is set and when wRecordBufferData + 4 is $80). $FF does
; nothing; a byte with bit 7 set starts effect routine (byte & $7F) (wEffectRoutine set, wEffectId
; 0, wEffectSpriteX and the three bytes after it, and wEffectFrameCounter, cleared); any other byte
; is an effect number for SelectEffectByEffectFlags_StartAnimation. (C2, E-0382)
SelectEffectByEffectFlags::
    ld a, [wBattleTarget]
    and $03
    cp $03
    jr nz, .check_effect_flags
    ld a, [wBattleActionId]
    cp SKILL_TATSUCALL
    ret c
    cp SKILL_SUCKAIR
    ret nc
    ld a, [wEffectFlags]
    and $41
    ret z

.check_effect_flags:
    ld a, [wEffectFlags]
    or a
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
    and $07
    cp $00
    jr z, .call_target_on_local_side_bank3_a
    cp $01
    jr z, .skip
    ret

.skip:
    ld a, $14
    jp SelectEffectByEffectFlags_StartAnimation

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
    cp $6c
    jr z, .call_target_on_local_side_bank3_a2
    ld a, [wRedirectFlags]
    bit 0, a
    jr nz, .call_target_on_local_side_bank3_a2
    ld a, [wRecordBufferData + $4]
    cp $80
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
    cp $ff
    ret z
    bit 7, a
    jp z, SelectEffectByEffectFlags_StartAnimation

.set_effect_routine:
    and $7f
    ld [wEffectRoutine], a
    ld a, $00
    ld [wEffectId], a
    xor a
    ld hl, wEffectSpriteX
    ld bc, $0004
    call FillBytes
    xor a
    ld [wEffectFrameCounter], a
    ret

; SelectEffectByEffectFlags uses this table for wEffectFlags bit 7, indexed by wBattleActionId: byte
; 1 when ActorOnLocalSide_Bank3A (or, for action $6C and some flags, TargetOnLocalSide_Bank3A) says
; near side, else byte 0; $FF returns, bit 7 set starts effect routine (value & $7F), other values
; go to SelectEffectByEffectFlags_StartAnimation; the debug viewer DrawSkillDebugPage shows the
; first three tables; 228 entries (E-0209, C1)
; record: effect byte for a far-side actor, for a near-side actor ($FF = none)
ActionEffectTable_Flag7::
    db $ff, $ff ; id 0
    db $ff, $00 ; id 1
    db $ff, $01 ; id 2
    db $ff, $02 ; id 3
    db $ff, $03 ; id 4
    db $ff, $04 ; id 5
    db $ff, $05 ; id 6
    db $ff, $06 ; id 7
    db $ff, $07 ; id 8
    db $ff, $08 ; id 9
    db $ff, $09 ; id 10
    db $ff, $0a ; id 11
    db $ff, $0b ; id 12
    db $ff, $0f ; id 13
    db $ff, $10 ; id 14
    db $ff, $11 ; id 15
    db $ff, $0c ; id 16
    db $ff, $0d ; id 17
    db $ff, $0e ; id 18
    db $ff, $ff ; id 19
    db $ff, $ff ; id 20
    db $ff, $ff ; id 21
    db $ff, $ff ; id 22
    db $ff, $ff ; id 23
    db $ff, $ff ; id 24
    db $ff, $ff ; id 25
    db $ff, $ff ; id 26
    db $ff, $ff ; id 27
    db $ff, $ff ; id 28
    db $ff, $ff ; id 29
    db $ff, $ff ; id 30
    db $ff, $ff ; id 31
    db $ff, $ff ; id 32
    db $ff, $ff ; id 33
    db $ff, $ff ; id 34
    db $ff, $ff ; id 35
    db $ff, $ff ; id 36
    db $ff, $ff ; id 37
    db $ff, $ff ; id 38
    db $ff, $ff ; id 39
    db $ff, $ff ; id 40
    db $ff, $ff ; id 41
    db $ff, $ff ; id 42
    db $ff, $ff ; id 43
    db $ff, $ff ; id 44
    db $ff, $ff ; id 45
    db $ff, $ff ; id 46
    db $ff, $ff ; id 47
    db $ff, $ff ; id 48
    db $ff, $ff ; id 49
    db $ff, $ff ; id 50
    db $ff, $ff ; id 51
    db $ff, $ff ; id 52
    db $ff, $ff ; id 53
    db $ff, $ff ; id 54
    db $ff, $ff ; id 55
    db $ff, $ff ; id 56
    db $ff, $ff ; id 57
    db $ff, $ff ; id 58
    db $ff, $ff ; id 59
    db $86, $86 ; id 60
    db $ff, $2a ; id 61
    db $ff, $29 ; id 62
    db $ff, $28 ; id 63
    db $ff, $03 ; id 64
    db $ff, $04 ; id 65
    db $ff, $05 ; id 66
    db $ff, $1c ; id 67
    db $ff, $0c ; id 68
    db $ff, $0d ; id 69
    db $ff, $0e ; id 70
    db $ff, $1a ; id 71
    db $ff, $09 ; id 72
    db $ff, $0b ; id 73
    db $ff, $0f ; id 74
    db $ff, $1b ; id 75
    db $ff, $2d ; id 76
    db $ff, $2e ; id 77
    db $ff, $ff ; id 78
    db $ff, $ff ; id 79
    db $ff, $1e ; id 80
    db $ff, $20 ; id 81
    db $ff, $1f ; id 82
    db $ff, $21 ; id 83
    db $ff, $22 ; id 84
    db $ff, $1d ; id 85
    db $ff, $1d ; id 86
    db $ff, $23 ; id 87
    db $ff, $22 ; id 88
    db $ff, $1d ; id 89
    db $ff, $24 ; id 90
    db $ff, $24 ; id 91
    db $ff, $25 ; id 92
    db $ff, $2f ; id 93
    db $ff, $25 ; id 94
    db $ff, $ff ; id 95
    db $ff, $ff ; id 96
    db $ff, $ff ; id 97
    db $ff, $1d ; id 98
    db $ff, $ff ; id 99
    db $ff, $ff ; id 100
    db $ff, $1d ; id 101
    db $ff, $27 ; id 102
    db $ff, $26 ; id 103
    db $ff, $ff ; id 104
    db $ff, $ff ; id 105
    db $ff, $ff ; id 106
    db $ff, $1d ; id 107
    db $ff, $1d ; id 108
    db $ff, $1d ; id 109
    db $ff, $ff ; id 110
    db $ff, $ff ; id 111
    db $ff, $ff ; id 112
    db $ff, $ff ; id 113
    db $ff, $ff ; id 114
    db $ff, $ff ; id 115
    db $ff, $ff ; id 116
    db $ff, $ff ; id 117
    db $ff, $ff ; id 118
    db $ff, $ff ; id 119
    db $ff, $ff ; id 120
    db $ff, $ff ; id 121
    db $ff, $ff ; id 122
    db $ff, $ff ; id 123
    db $ff, $ff ; id 124
    db $ff, $ff ; id 125
    db $ff, $ff ; id 126
    db $84, $84 ; id 127
    db $84, $84 ; id 128
    db $84, $84 ; id 129
    db $85, $85 ; id 130
    db $2b, $2b ; id 131
    db $85, $85 ; id 132
    db $ff, $ff ; id 133
    db $ff, $ff ; id 134
    db $ff, $ff ; id 135
    db $ff, $ff ; id 136
    db $ff, $ff ; id 137
    db $ff, $ff ; id 138
    db $ff, $ff ; id 139
    db $ff, $ff ; id 140
    db $ff, $ff ; id 141
    db $ff, $ff ; id 142
    db $ff, $ff ; id 143
    db $ff, $ff ; id 144
    db $ff, $30 ; id 145
    db $ff, $ff ; id 146
    db $ff, $ff ; id 147
    db $ff, $ff ; id 148
    db $ff, $ff ; id 149
    db $ff, $ff ; id 150
    db $ff, $ff ; id 151
    db $ff, $ff ; id 152
    db $ff, $ff ; id 153
    db $ff, $ff ; id 154
    db $31, $ff ; id 155
    db $84, $84 ; id 156
    db $ff, $ff ; id 157
    db $ff, $ff ; id 158
    db $ff, $ff ; id 159
    db $ff, $ff ; id 160
    db $ff, $ff ; id 161
    db $ff, $ff ; id 162
    db $ff, $ff ; id 163
    db $ff, $ff ; id 164
    db $ff, $ff ; id 165
    db $ff, $ff ; id 166
    db $ff, $ff ; id 167
    db $ff, $ff ; id 168
    db $ff, $ff ; id 169
    db $ff, $ff ; id 170
    db $ff, $ff ; id 171
    db $ff, $ff ; id 172
    db $ff, $ff ; id 173
    db $ff, $ff ; id 174
    db $ff, $ff ; id 175
    db $ff, $ff ; id 176
    db $ff, $ff ; id 177
    db $ff, $ff ; id 178
    db $85, $85 ; id 179
    db $ff, $ff ; id 180
    db $ff, $ff ; id 181
    db $ff, $ff ; id 182
    db $ff, $ff ; id 183
    db $ff, $ff ; id 184
    db $ff, $ff ; id 185
    db $ff, $ff ; id 186
    db $ff, $ff ; id 187
    db $ff, $ff ; id 188
    db $ff, $ff ; id 189
    db $ff, $ff ; id 190
    db $ff, $ff ; id 191
    db $ff, $ff ; id 192
    db $ff, $ff ; id 193
    db $ff, $ff ; id 194
    db $ff, $ff ; id 195
    db $ff, $ff ; id 196
    db $ff, $ff ; id 197
    db $ff, $ff ; id 198
    db $ff, $ff ; id 199
    db $ff, $ff ; id 200
    db $ff, $ff ; id 201
    db $ff, $ff ; id 202
    db $ff, $ff ; id 203
    db $ff, $ff ; id 204
    db $ff, $30 ; id 205
    db $ff, $ff ; id 206
    db $ff, $ff ; id 207
    db $ff, $33 ; id 208
    db $ff, $34 ; id 209
    db $ff, $35 ; id 210
    db $ff, $36 ; id 211
    db $ff, $37 ; id 212
    db $ff, $38 ; id 213
    db $ff, $ff ; id 214
    db $ff, $30 ; id 215
    db $ff, $1d ; id 216
    db $ff, $2a ; id 217
    db $ff, $ff ; id 218
    db $85, $85 ; id 219
    db $ff, $ff ; id 220
    db $ff, $ff ; id 221
    db $ff, $ff ; id 222
    db $ff, $ff ; id 223
    db $ff, $ff ; id 224
    db $ff, $ff ; id 225
    db $ff, $ff ; id 226
    db $3b, $ff ; id 227

; SelectEffectByEffectFlags uses this table for wEffectFlags bit 6 (with bit 0), indexed by
; wBattleActionId: byte 1 when ActorOnLocalSide_Bank3A (or, for action $6C and some flags,
; TargetOnLocalSide_Bank3A) says near side, else byte 0; $FF returns, bit 7 set starts effect
; routine (value & $7F), other values go to SelectEffectByEffectFlags_StartAnimation; the debug
; viewer DrawSkillDebugPage shows the first three tables; 228 entries (E-0209, C1)
ActionEffectTable_Flag6::
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
    db $ff, $81 ; id 19
    db $ff, $81 ; id 20
    db $ff, $81 ; id 21
    db $14, $ff ; id 22
    db $14, $ff ; id 23
    db $14, $ff ; id 24
    db $14, $ff ; id 25
    db $14, $ff ; id 26
    db $14, $ff ; id 27
    db $14, $ff ; id 28
    db $14, $ff ; id 29
    db $80, $ff ; id 30
    db $80, $ff ; id 31
    db $14, $ff ; id 32
    db $14, $ff ; id 33
    db $14, $ff ; id 34
    db $14, $ff ; id 35
    db $14, $ff ; id 36
    db $13, $ff ; id 37
    db $13, $ff ; id 38
    db $ff, $12 ; id 39
    db $ff, $12 ; id 40
    db $13, $ff ; id 41
    db $13, $ff ; id 42
    db $ff, $12 ; id 43
    db $ff, $12 ; id 44
    db $13, $ff ; id 45
    db $ff, $17 ; id 46
    db $ff, $15 ; id 47
    db $ff, $15 ; id 48
    db $13, $ff ; id 49
    db $13, $12 ; id 50
    db $ff, $12 ; id 51
    db $ff, $16 ; id 52
    db $ff, $ff ; id 53
    db $19, $ff ; id 54
    db $19, $ff ; id 55
    db $ff, $ff ; id 56
    db $ff, $ff ; id 57
    db $18, $ff ; id 58
    db $18, $ff ; id 59
    db $ff, $ff ; id 60
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
    db $ff, $ff ; id 104
    db $83, $82 ; id 105
    db $83, $82 ; id 106
    db $83, $82 ; id 107
    db $83, $82 ; id 108
    db $83, $82 ; id 109
    db $83, $82 ; id 110
    db $83, $82 ; id 111
    db $83, $82 ; id 112
    db $ff, $15 ; id 113
    db $ff, $15 ; id 114
    db $ff, $15 ; id 115
    db $ff, $15 ; id 116
    db $ff, $16 ; id 117
    db $ff, $12 ; id 118
    db $13, $12 ; id 119
    db $ff, $16 ; id 120
    db $ff, $ff ; id 121
    db $ff, $16 ; id 122
    db $14, $ff ; id 123
    db $14, $ff ; id 124
    db $ff, $ff ; id 125
    db $ff, $17 ; id 126
    db $83, $82 ; id 127
    db $ff, $ff ; id 128
    db $ff, $ff ; id 129
    db $ff, $ff ; id 130
    db $ff, $ff ; id 131
    db $ff, $ff ; id 132
    db $84, $84 ; id 133
    db $84, $84 ; id 134
    db $84, $84 ; id 135
    db $84, $84 ; id 136
    db $ff, $ff ; id 137
    db $ff, $ff ; id 138
    db $ff, $15 ; id 139
    db $ff, $15 ; id 140
    db $83, $82 ; id 141
    db $83, $82 ; id 142
    db $ff, $16 ; id 143
    db $83, $82 ; id 144
    db $8d, $83 ; id 145
    db $ff, $ff ; id 146
    db $ff, $ff ; id 147
    db $ff, $ff ; id 148
    db $ff, $ff ; id 149
    db $ff, $ff ; id 150
    db $ff, $ff ; id 151
    db $ff, $ff ; id 152
    db $ff, $ff ; id 153
    db $ff, $ff ; id 154
    db $ff, $ff ; id 155
    db $ff, $ff ; id 156
    db $ff, $ff ; id 157
    db $ff, $ff ; id 158
    db $14, $ff ; id 159
    db $ff, $ff ; id 160
    db $32, $32 ; id 161
    db $ff, $ff ; id 162
    db $ff, $ff ; id 163
    db $ff, $ff ; id 164
    db $ff, $ff ; id 165
    db $ff, $ff ; id 166
    db $ff, $ff ; id 167
    db $ff, $ff ; id 168
    db $ff, $ff ; id 169
    db $83, $82 ; id 170
    db $ff, $ff ; id 171
    db $ff, $ff ; id 172
    db $ff, $ff ; id 173
    db $ff, $ff ; id 174
    db $ff, $ff ; id 175
    db $ff, $81 ; id 176
    db $14, $ff ; id 177
    db $ff, $81 ; id 178
    db $ff, $82 ; id 179
    db $ff, $ff ; id 180
    db $ff, $15 ; id 181
    db $12, $ff ; id 182
    db $ff, $ff ; id 183
    db $18, $ff ; id 184
    db $83, $82 ; id 185
    db $ff, $82 ; id 186
    db $ff, $ff ; id 187
    db $14, $ff ; id 188
    db $83, $82 ; id 189
    db $ff, $ff ; id 190
    db $ff, $ff ; id 191
    db $82, $83 ; id 192
    db $83, $82 ; id 193
    db $82, $83 ; id 194
    db $ff, $ff ; id 195
    db $ff, $ff ; id 196
    db $ff, $ff ; id 197
    db $ff, $ff ; id 198
    db $ff, $ff ; id 199
    db $ff, $ff ; id 200
    db $82, $83 ; id 201
    db $82, $83 ; id 202
    db $82, $83 ; id 203
    db $83, $82 ; id 204
    db $8d, $83 ; id 205
    db $ff, $ff ; id 206
    db $32, $32 ; id 207
    db $83, $82 ; id 208
    db $83, $82 ; id 209
    db $83, $82 ; id 210
    db $83, $82 ; id 211
    db $83, $82 ; id 212
    db $83, $82 ; id 213
    db $ff, $81 ; id 214
    db $83, $82 ; id 215
    db $83, $82 ; id 216
    db $83, $82 ; id 217
    db $14, $ff ; id 218
    db $ff, $ff ; id 219
    db $18, $ff ; id 220
    db $13, $ff ; id 221
    db $ff, $ff ; id 222
    db $13, $12 ; id 223
    db $ff, $ff ; id 224
    db $ff, $16 ; id 225
    db $ff, $ff ; id 226
    db $ff, $ff ; id 227

; SelectEffectByEffectFlags uses this table for wEffectFlags bit 5, indexed by wBattleActionId: byte
; 1 when ActorOnLocalSide_Bank3A (or, for action $6C and some flags, TargetOnLocalSide_Bank3A) says
; near side, else byte 0; $FF returns, bit 7 set starts effect routine (value & $7F), other values
; go to SelectEffectByEffectFlags_StartAnimation; the debug viewer DrawSkillDebugPage shows the
; first three tables; 228 entries (E-0209, C1)
ActionEffectTable_Flag5::
    db $ff, $ff ; id 0
    db $ff, $ff ; id 1
    db $ff, $ff ; id 2
    db $ff, $ff ; id 3
    db $ff, $ff ; id 4
    db $ff, $ff ; id 5
    db $ff, $ff ; id 6
    db $ff, $ff ; id 7
    db $ff, $ff ; id 8
    db $ff, $ff ; id 9
    db $ff, $ff ; id 10
    db $ff, $ff ; id 11
    db $ff, $ff ; id 12
    db $ff, $ff ; id 13
    db $ff, $ff ; id 14
    db $ff, $ff ; id 15
    db $ff, $ff ; id 16
    db $ff, $ff ; id 17
    db $ff, $ff ; id 18
    db $ff, $ff ; id 19
    db $ff, $ff ; id 20
    db $ff, $ff ; id 21
    db $ff, $ff ; id 22
    db $ff, $ff ; id 23
    db $ff, $ff ; id 24
    db $ff, $ff ; id 25
    db $ff, $ff ; id 26
    db $ff, $ff ; id 27
    db $ff, $ff ; id 28
    db $ff, $ff ; id 29
    db $ff, $ff ; id 30
    db $ff, $ff ; id 31
    db $ff, $ff ; id 32
    db $ff, $ff ; id 33
    db $ff, $ff ; id 34
    db $ff, $ff ; id 35
    db $ff, $ff ; id 36
    db $ff, $ff ; id 37
    db $ff, $ff ; id 38
    db $ff, $ff ; id 39
    db $ff, $ff ; id 40
    db $ff, $ff ; id 41
    db $ff, $ff ; id 42
    db $ff, $ff ; id 43
    db $ff, $ff ; id 44
    db $ff, $ff ; id 45
    db $ff, $ff ; id 46
    db $ff, $ff ; id 47
    db $ff, $ff ; id 48
    db $ff, $ff ; id 49
    db $ff, $ff ; id 50
    db $ff, $ff ; id 51
    db $ff, $ff ; id 52
    db $ff, $ff ; id 53
    db $ff, $ff ; id 54
    db $ff, $ff ; id 55
    db $ff, $ff ; id 56
    db $ff, $ff ; id 57
    db $ff, $ff ; id 58
    db $ff, $ff ; id 59
    db $ff, $ff ; id 60
    db $ff, $ff ; id 61
    db $ff, $ff ; id 62
    db $ff, $ff ; id 63
    db $ff, $ff ; id 64
    db $ff, $ff ; id 65
    db $ff, $ff ; id 66
    db $ff, $ff ; id 67
    db $ff, $ff ; id 68
    db $ff, $ff ; id 69
    db $ff, $ff ; id 70
    db $ff, $ff ; id 71
    db $ff, $ff ; id 72
    db $ff, $ff ; id 73
    db $ff, $ff ; id 74
    db $ff, $ff ; id 75
    db $ff, $ff ; id 76
    db $ff, $ff ; id 77
    db $ff, $ff ; id 78
    db $ff, $ff ; id 79
    db $ff, $ff ; id 80
    db $ff, $ff ; id 81
    db $ff, $ff ; id 82
    db $ff, $ff ; id 83
    db $ff, $ff ; id 84
    db $ff, $ff ; id 85
    db $ff, $ff ; id 86
    db $ff, $ff ; id 87
    db $ff, $ff ; id 88
    db $ff, $ff ; id 89
    db $ff, $ff ; id 90
    db $ff, $ff ; id 91
    db $ff, $ff ; id 92
    db $ff, $ff ; id 93
    db $ff, $ff ; id 94
    db $ff, $15 ; id 95
    db $ff, $15 ; id 96
    db $ff, $15 ; id 97
    db $ff, $ff ; id 98
    db $ff, $ff ; id 99
    db $ff, $ff ; id 100
    db $ff, $ff ; id 101
    db $ff, $ff ; id 102
    db $ff, $ff ; id 103
    db $ff, $ff ; id 104
    db $ff, $ff ; id 105
    db $ff, $ff ; id 106
    db $ff, $ff ; id 107
    db $ff, $ff ; id 108
    db $8d, $83 ; id 109
    db $ff, $ff ; id 110
    db $8d, $83 ; id 111
    db $8d, $83 ; id 112
    db $ff, $ff ; id 113
    db $ff, $ff ; id 114
    db $ff, $ff ; id 115
    db $ff, $ff ; id 116
    db $ff, $ff ; id 117
    db $ff, $ff ; id 118
    db $ff, $ff ; id 119
    db $ff, $ff ; id 120
    db $ff, $ff ; id 121
    db $ff, $ff ; id 122
    db $ff, $ff ; id 123
    db $ff, $ff ; id 124
    db $ff, $ff ; id 125
    db $ff, $ff ; id 126
    db $ff, $ff ; id 127
    db $ff, $ff ; id 128
    db $ff, $ff ; id 129
    db $ff, $ff ; id 130
    db $ff, $ff ; id 131
    db $ff, $ff ; id 132
    db $ff, $ff ; id 133
    db $ff, $ff ; id 134
    db $ff, $ff ; id 135
    db $ff, $ff ; id 136
    db $ff, $ff ; id 137
    db $ff, $ff ; id 138
    db $ff, $ff ; id 139
    db $ff, $ff ; id 140
    db $ff, $ff ; id 141
    db $ff, $ff ; id 142
    db $ff, $ff ; id 143
    db $ff, $ff ; id 144
    db $ff, $ff ; id 145
    db $ff, $ff ; id 146
    db $ff, $ff ; id 147
    db $ff, $ff ; id 148
    db $ff, $ff ; id 149
    db $ff, $ff ; id 150
    db $ff, $ff ; id 151
    db $ff, $ff ; id 152
    db $ff, $ff ; id 153
    db $ff, $ff ; id 154
    db $ff, $ff ; id 155
    db $ff, $ff ; id 156
    db $ff, $ff ; id 157
    db $ff, $ff ; id 158
    db $ff, $ff ; id 159
    db $ff, $ff ; id 160
    db $ff, $ff ; id 161
    db $ff, $ff ; id 162
    db $ff, $ff ; id 163
    db $ff, $ff ; id 164
    db $ff, $ff ; id 165
    db $ff, $ff ; id 166
    db $ff, $ff ; id 167
    db $ff, $ff ; id 168
    db $ff, $ff ; id 169
    db $ff, $ff ; id 170
    db $ff, $ff ; id 171
    db $ff, $ff ; id 172
    db $ff, $ff ; id 173
    db $ff, $ff ; id 174
    db $ff, $ff ; id 175
    db $ff, $ff ; id 176
    db $ff, $ff ; id 177
    db $ff, $ff ; id 178
    db $ff, $ff ; id 179
    db $ff, $ff ; id 180
    db $ff, $ff ; id 181
    db $ff, $ff ; id 182
    db $ff, $ff ; id 183
    db $ff, $ff ; id 184
    db $ff, $ff ; id 185
    db $ff, $ff ; id 186
    db $ff, $ff ; id 187
    db $ff, $ff ; id 188
    db $ff, $ff ; id 189
    db $ff, $ff ; id 190
    db $ff, $ff ; id 191
    db $ff, $ff ; id 192
    db $ff, $ff ; id 193
    db $ff, $ff ; id 194
    db $ff, $ff ; id 195
    db $ff, $ff ; id 196
    db $ff, $ff ; id 197
    db $ff, $ff ; id 198
    db $ff, $ff ; id 199
    db $ff, $ff ; id 200
    db $ff, $ff ; id 201
    db $ff, $ff ; id 202
    db $ff, $ff ; id 203
    db $ff, $ff ; id 204
    db $ff, $ff ; id 205
    db $ff, $ff ; id 206
    db $ff, $ff ; id 207
    db $ff, $ff ; id 208
    db $ff, $ff ; id 209
    db $ff, $ff ; id 210
    db $ff, $ff ; id 211
    db $ff, $ff ; id 212
    db $ff, $ff ; id 213
    db $ff, $ff ; id 214
    db $ff, $ff ; id 215
    db $ff, $ff ; id 216
    db $ff, $ff ; id 217
    db $ff, $ff ; id 218
    db $ff, $ff ; id 219
    db $ff, $ff ; id 220
    db $ff, $ff ; id 221
    db $ff, $ff ; id 222
    db $ff, $ff ; id 223
    db $ff, $ff ; id 224
    db $ff, $ff ; id 225
    db $ff, $ff ; id 226
    db $ff, $ff ; id 227

; 228 entries of $FF $FF between ActionEffectTable_Flag5 and ActionEffectTable_Flag2, the size of
; one more table; no reader found (E-0209, C1)
ActionEffectTable_Unused::
    db $ff, $ff ; id 0
    db $ff, $ff ; id 1
    db $ff, $ff ; id 2
    db $ff, $ff ; id 3
    db $ff, $ff ; id 4
    db $ff, $ff ; id 5
    db $ff, $ff ; id 6
    db $ff, $ff ; id 7
    db $ff, $ff ; id 8
    db $ff, $ff ; id 9
    db $ff, $ff ; id 10
    db $ff, $ff ; id 11
    db $ff, $ff ; id 12
    db $ff, $ff ; id 13
    db $ff, $ff ; id 14
    db $ff, $ff ; id 15
    db $ff, $ff ; id 16
    db $ff, $ff ; id 17
    db $ff, $ff ; id 18
    db $ff, $ff ; id 19
    db $ff, $ff ; id 20
    db $ff, $ff ; id 21
    db $ff, $ff ; id 22
    db $ff, $ff ; id 23
    db $ff, $ff ; id 24
    db $ff, $ff ; id 25
    db $ff, $ff ; id 26
    db $ff, $ff ; id 27
    db $ff, $ff ; id 28
    db $ff, $ff ; id 29
    db $ff, $ff ; id 30
    db $ff, $ff ; id 31
    db $ff, $ff ; id 32
    db $ff, $ff ; id 33
    db $ff, $ff ; id 34
    db $ff, $ff ; id 35
    db $ff, $ff ; id 36
    db $ff, $ff ; id 37
    db $ff, $ff ; id 38
    db $ff, $ff ; id 39
    db $ff, $ff ; id 40
    db $ff, $ff ; id 41
    db $ff, $ff ; id 42
    db $ff, $ff ; id 43
    db $ff, $ff ; id 44
    db $ff, $ff ; id 45
    db $ff, $ff ; id 46
    db $ff, $ff ; id 47
    db $ff, $ff ; id 48
    db $ff, $ff ; id 49
    db $ff, $ff ; id 50
    db $ff, $ff ; id 51
    db $ff, $ff ; id 52
    db $ff, $ff ; id 53
    db $ff, $ff ; id 54
    db $ff, $ff ; id 55
    db $ff, $ff ; id 56
    db $ff, $ff ; id 57
    db $ff, $ff ; id 58
    db $ff, $ff ; id 59
    db $ff, $ff ; id 60
    db $ff, $ff ; id 61
    db $ff, $ff ; id 62
    db $ff, $ff ; id 63
    db $ff, $ff ; id 64
    db $ff, $ff ; id 65
    db $ff, $ff ; id 66
    db $ff, $ff ; id 67
    db $ff, $ff ; id 68
    db $ff, $ff ; id 69
    db $ff, $ff ; id 70
    db $ff, $ff ; id 71
    db $ff, $ff ; id 72
    db $ff, $ff ; id 73
    db $ff, $ff ; id 74
    db $ff, $ff ; id 75
    db $ff, $ff ; id 76
    db $ff, $ff ; id 77
    db $ff, $ff ; id 78
    db $ff, $ff ; id 79
    db $ff, $ff ; id 80
    db $ff, $ff ; id 81
    db $ff, $ff ; id 82
    db $ff, $ff ; id 83
    db $ff, $ff ; id 84
    db $ff, $ff ; id 85
    db $ff, $ff ; id 86
    db $ff, $ff ; id 87
    db $ff, $ff ; id 88
    db $ff, $ff ; id 89
    db $ff, $ff ; id 90
    db $ff, $ff ; id 91
    db $ff, $ff ; id 92
    db $ff, $ff ; id 93
    db $ff, $ff ; id 94
    db $ff, $ff ; id 95
    db $ff, $ff ; id 96
    db $ff, $ff ; id 97
    db $ff, $ff ; id 98
    db $ff, $ff ; id 99
    db $ff, $ff ; id 100
    db $ff, $ff ; id 101
    db $ff, $ff ; id 102
    db $ff, $ff ; id 103
    db $ff, $ff ; id 104
    db $ff, $ff ; id 105
    db $ff, $ff ; id 106
    db $ff, $ff ; id 107
    db $ff, $ff ; id 108
    db $ff, $ff ; id 109
    db $ff, $ff ; id 110
    db $ff, $ff ; id 111
    db $ff, $ff ; id 112
    db $ff, $ff ; id 113
    db $ff, $ff ; id 114
    db $ff, $ff ; id 115
    db $ff, $ff ; id 116
    db $ff, $ff ; id 117
    db $ff, $ff ; id 118
    db $ff, $ff ; id 119
    db $ff, $ff ; id 120
    db $ff, $ff ; id 121
    db $ff, $ff ; id 122
    db $ff, $ff ; id 123
    db $ff, $ff ; id 124
    db $ff, $ff ; id 125
    db $ff, $ff ; id 126
    db $ff, $ff ; id 127
    db $ff, $ff ; id 128
    db $ff, $ff ; id 129
    db $ff, $ff ; id 130
    db $ff, $ff ; id 131
    db $ff, $ff ; id 132
    db $ff, $ff ; id 133
    db $ff, $ff ; id 134
    db $ff, $ff ; id 135
    db $ff, $ff ; id 136
    db $ff, $ff ; id 137
    db $ff, $ff ; id 138
    db $ff, $ff ; id 139
    db $ff, $ff ; id 140
    db $ff, $ff ; id 141
    db $ff, $ff ; id 142
    db $ff, $ff ; id 143
    db $ff, $ff ; id 144
    db $ff, $ff ; id 145
    db $ff, $ff ; id 146
    db $ff, $ff ; id 147
    db $ff, $ff ; id 148
    db $ff, $ff ; id 149
    db $ff, $ff ; id 150
    db $ff, $ff ; id 151
    db $ff, $ff ; id 152
    db $ff, $ff ; id 153
    db $ff, $ff ; id 154
    db $ff, $ff ; id 155
    db $ff, $ff ; id 156
    db $ff, $ff ; id 157
    db $ff, $ff ; id 158
    db $ff, $ff ; id 159
    db $ff, $ff ; id 160
    db $ff, $ff ; id 161
    db $ff, $ff ; id 162
    db $ff, $ff ; id 163
    db $ff, $ff ; id 164
    db $ff, $ff ; id 165
    db $ff, $ff ; id 166
    db $ff, $ff ; id 167
    db $ff, $ff ; id 168
    db $ff, $ff ; id 169
    db $ff, $ff ; id 170
    db $ff, $ff ; id 171
    db $ff, $ff ; id 172
    db $ff, $ff ; id 173
    db $ff, $ff ; id 174
    db $ff, $ff ; id 175
    db $ff, $ff ; id 176
    db $ff, $ff ; id 177
    db $ff, $ff ; id 178
    db $ff, $ff ; id 179
    db $ff, $ff ; id 180
    db $ff, $ff ; id 181
    db $ff, $ff ; id 182
    db $ff, $ff ; id 183
    db $ff, $ff ; id 184
    db $ff, $ff ; id 185
    db $ff, $ff ; id 186
    db $ff, $ff ; id 187
    db $ff, $ff ; id 188
    db $ff, $ff ; id 189
    db $ff, $ff ; id 190
    db $ff, $ff ; id 191
    db $ff, $ff ; id 192
    db $ff, $ff ; id 193
    db $ff, $ff ; id 194
    db $ff, $ff ; id 195
    db $ff, $ff ; id 196
    db $ff, $ff ; id 197
    db $ff, $ff ; id 198
    db $ff, $ff ; id 199
    db $ff, $ff ; id 200
    db $ff, $ff ; id 201
    db $ff, $ff ; id 202
    db $ff, $ff ; id 203
    db $ff, $ff ; id 204
    db $ff, $ff ; id 205
    db $ff, $ff ; id 206
    db $ff, $ff ; id 207
    db $ff, $ff ; id 208
    db $ff, $ff ; id 209
    db $ff, $ff ; id 210
    db $ff, $ff ; id 211
    db $ff, $ff ; id 212
    db $ff, $ff ; id 213
    db $ff, $ff ; id 214
    db $ff, $ff ; id 215
    db $ff, $ff ; id 216
    db $ff, $ff ; id 217
    db $ff, $ff ; id 218
    db $ff, $ff ; id 219
    db $ff, $ff ; id 220
    db $ff, $ff ; id 221
    db $ff, $ff ; id 222
    db $ff, $ff ; id 223
    db $ff, $ff ; id 224
    db $ff, $ff ; id 225
    db $ff, $ff ; id 226
    db $ff, $ff ; id 227

; SelectEffectByEffectFlags uses this table for wEffectFlags bit 2 (the target acts), indexed by
; wBattleActionId: byte 1 when ActorOnLocalSide_Bank3A (or, for action $6C and some flags,
; TargetOnLocalSide_Bank3A) says near side, else byte 0; $FF returns, bit 7 set starts effect
; routine (value & $7F), other values go to SelectEffectByEffectFlags_StartAnimation; the debug
; viewer DrawSkillDebugPage shows the first three tables; 64 entries (E-0209, C1)
; record: effect byte for a far-side actor, for a near-side actor ($FF = none)
ActionEffectTable_Flag2::
    db $ff, $ff ; id 0
    db $14, $ff ; id 1
    db $14, $ff ; id 2
    db $14, $ff ; id 3
    db $14, $ff ; id 4
    db $14, $ff ; id 5
    db $14, $ff ; id 6
    db $14, $ff ; id 7
    db $14, $ff ; id 8
    db $14, $ff ; id 9
    db $14, $ff ; id 10
    db $14, $ff ; id 11
    db $ff, $ff ; id 12
    db $ff, $ff ; id 13
    db $ff, $ff ; id 14
    db $ff, $ff ; id 15
    db $ff, $ff ; id 16
    db $ff, $ff ; id 17
    db $ff, $ff ; id 18
    db $ff, $ff ; id 19
    db $ff, $ff ; id 20
    db $ff, $ff ; id 21
    db $ff, $ff ; id 22
    db $ff, $ff ; id 23
    db $ff, $ff ; id 24
    db $ff, $ff ; id 25
    db $ff, $ff ; id 26
    db $ff, $ff ; id 27
    db $ff, $ff ; id 28
    db $ff, $ff ; id 29
    db $ff, $ff ; id 30
    db $ff, $ff ; id 31
    db $ff, $ff ; id 32
    db $ff, $ff ; id 33
    db $12, $ff ; id 34
    db $ff, $ff ; id 35
    db $82, $ff ; id 36
    db $82, $ff ; id 37
    db $82, $ff ; id 38
    db $82, $ff ; id 39
    db $ff, $ff ; id 40
    db $ff, $ff ; id 41
    db $ff, $ff ; id 42
    db $ff, $ff ; id 43
    db $ff, $ff ; id 44
    db $ff, $ff ; id 45
    db $ff, $ff ; id 46
    db $ff, $ff ; id 47
    db $ff, $ff ; id 48
    db $ff, $ff ; id 49
    db $ff, $ff ; id 50
    db $ff, $ff ; id 51
    db $ff, $ff ; id 52
    db $ff, $ff ; id 53
    db $ff, $ff ; id 54
    db $ff, $ff ; id 55
    db $ff, $ff ; id 56
    db $ff, $ff ; id 57
    db $ff, $ff ; id 58
    db $ff, $ff ; id 59
    db $ff, $ff ; id 60
    db $ff, $ff ; id 61
    db $ff, $ff ; id 62
    db $ff, $ff ; id 63

; SelectEffectByEffectFlags uses this table for wEffectFlags bit 3 (the target acts), indexed by
; wBattleActionId: byte 1 when ActorOnLocalSide_Bank3A (or, for action $6C and some flags,
; TargetOnLocalSide_Bank3A) says near side, else byte 0; $FF returns, bit 7 set starts effect
; routine (value & $7F), other values go to SelectEffectByEffectFlags_StartAnimation; the debug
; viewer DrawSkillDebugPage shows the first three tables; 64 entries (E-0209, C1)
ActionEffectTable_Flag3::
    db $ff, $ff ; id 0
    db $ff, $ff ; id 1
    db $ff, $ff ; id 2
    db $ff, $ff ; id 3
    db $ff, $ff ; id 4
    db $ff, $ff ; id 5
    db $ff, $ff ; id 6
    db $ff, $ff ; id 7
    db $ff, $ff ; id 8
    db $ff, $ff ; id 9
    db $ff, $ff ; id 10
    db $ff, $ff ; id 11
    db $ff, $ff ; id 12
    db $ff, $ff ; id 13
    db $ff, $ff ; id 14
    db $ff, $ff ; id 15
    db $ff, $ff ; id 16
    db $ff, $ff ; id 17
    db $ff, $ff ; id 18
    db $ff, $ff ; id 19
    db $ff, $ff ; id 20
    db $ff, $ff ; id 21
    db $ff, $ff ; id 22
    db $ff, $ff ; id 23
    db $ff, $ff ; id 24
    db $2c, $ff ; id 25
    db $2c, $ff ; id 26
    db $2c, $ff ; id 27
    db $2c, $ff ; id 28
    db $15, $ff ; id 29
    db $32, $ff ; id 30
    db $ff, $ff ; id 31
    db $ff, $ff ; id 32
    db $ff, $ff ; id 33
    db $ff, $ff ; id 34
    db $ff, $ff ; id 35
    db $09, $ff ; id 36
    db $0f, $ff ; id 37
    db $0e, $ff ; id 38
    db $02, $ff ; id 39
    db $ff, $ff ; id 40
    db $ff, $ff ; id 41
    db $ff, $ff ; id 42
    db $ff, $ff ; id 43
    db $ff, $ff ; id 44
    db $ff, $ff ; id 45
    db $ff, $ff ; id 46
    db $ff, $ff ; id 47
    db $ff, $ff ; id 48
    db $ff, $ff ; id 49
    db $ff, $ff ; id 50
    db $ff, $ff ; id 51
    db $ff, $ff ; id 52
    db $ff, $ff ; id 53
    db $ff, $ff ; id 54
    db $ff, $ff ; id 55
    db $ff, $ff ; id 56
    db $ff, $ff ; id 57
    db $ff, $ff ; id 58
    db $ff, $ff ; id 59
    db $ff, $ff ; id 60
    db $ff, $ff ; id 61
    db $ff, $ff ; id 62
    db $ff, $ff ; id 63

; Starts battle effect A: clears wEffectAnimFlags (1 for ACTION_D7) and picks its slot
; (wBattleArg0); on the near side (slot below 4, or 4 and up for the link follower) only effects
; $2B, $32 and $13 go on ($13 only for RobMagic or RobDance with wEffectFlags $41, then on the
; actor). Then sets the effect's tile offset and target mode (0 for effect 9 with WindBeast or
; effect $0D with flag bit 1, 2 for effect $1D with RainSlash, otherwise
; SelectEffectByEffectFlags_StartAnimation_Data), stops for mode 0 when the slot is out or empty,
; and starts the animation. (C2, E-0357; probed E-0382)
SelectEffectByEffectFlags_StartAnimation::
    push af
    xor a
    ld [wEffectAnimFlags], a
    ld a, [wBattleActionId]
    cp ACTION_D7
    jr z, .set_effect_anim_flags_to_01
    jr .call_select_effect_by_effect_flags_set_effect

.set_effect_anim_flags_to_01:
    ld a, $01
    ld [wEffectAnimFlags], a

.call_select_effect_by_effect_flags_set_effect:
    pop af
    ld b, a
    call SelectEffectByEffectFlags_SetEffectSlot
    call IsEffectSlotNearSide
    ld a, b
    jr nc, .set_effect_tile_offset
    cp $2b
    jr z, .set_effect_tile_offset
    cp $32
    jr z, .set_effect_tile_offset
    cp $13
    jr z, .check_battle_action_id
    ret

.check_battle_action_id:
    ld a, [wBattleActionId]
    cp SKILL_ROBMAGIC
    jr z, .check_effect_flags
    cp SKILL_ROBDANCE
    ret nz

.check_effect_flags:
    ld a, [wEffectFlags]
    cp $41
    ret nz
    ld a, [wBattleActor]
    ld [wBattleArg0], a
    ld a, b

.set_effect_tile_offset:
    ld [wEffectTileOffset], a
    ld [wEffectAnimArg], a
    ld b, a
    call SelectEffectByEffectFlags_RainSlashMode
    jr z, .set_effect_target_mode
    ld a, b
    cp $09
    jr nz, .cp_0D
    ld a, [wBattleActionId]
    cp SKILL_WINDBEAST
    ld a, b
    jr nz, .cp_0D
    xor a
    jr .set_effect_target_mode

.cp_0D:
    cp $0d
    jr nz, .skip
    ld hl, wEffectFlags
    bit 1, [hl]
    jr z, .skip
    ld a, $00
    jr .set_effect_target_mode

.skip:
    ld hl, SelectEffectByEffectFlags_StartAnimation_Data
    add_a_to_hl
    ld a, [hl]

.set_effect_target_mode:
    ld [wEffectTargetMode], a
    cp $00
    jr nz, .clear_effect_sprite_x
    ld a, [wBattleArg0]
    call CarryUnlessBattleSlotOutSlotEmpty
    ret c

.clear_effect_sprite_x:
    xor a
    ld [wEffectSpriteX], a
    ld a, $ff
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
    ld [wEffectAnimId], a
    ld hl, wEffectAnimId
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

; Sixty bytes, one per battle effect number $00 to $3B, each a target mode for wEffectTargetMode: 0
; for $00-$02, $12-$19, $1D-$26, $2C-$2D, $2F-$31 and $34-$37 (one target slot, wBattleArg0); 1 for
; $03-$05, $08, $0A-$0C, $0E, $11, $1A, $1C, $27, $29-$2B, $2E, $32-$33 and $38-$3B (the effect
; sprite sits at X $50); 2 for $06-$07, $09, $0D, $0F-$10, $1B and $28 (every target on the side).
; SelectEffectByEffectFlags_StartAnimation indexes it by the effect number, except for the cases it
; forces itself. (C1, E-0381)
SelectEffectByEffectFlags_StartAnimation_Data::
    db $00, $00, $00, $01, $01, $01, $02, $02, $01, $02, $01, $01, $01, $02, $01, $02
    db $02, $01, $00, $00, $00, $00, $00, $00, $00, $00, $01, $02, $01, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $01, $02, $01, $01, $01, $00, $00, $01, $00
    db $00, $00, $01, $01, $00, $00, $00, $00, $01, $01, $01, $01

; Carry when the effect's slot (wBattleArg0) is below 4; for the link follower (link mode 1, role
; bit 1) the carry is inverted. (C2, E-0357; probed E-0382)
IsEffectSlotNearSide::
    ld a, [wLinkMode]
    cp $01
    jr nz, .check_battle_arg0
    ld a, [wLinkRole]
    bit 1, a
    jr z, .check_battle_arg0
    ld a, [wBattleArg0]
    cp $04
    ccf
    ret

.check_battle_arg0:
    ld a, [wBattleArg0]
    cp $04
    ret

; Returns Z with A = 2 for effect $1D of RainSlash when wEffectFlags bit 3 is clear; otherwise NZ.
; (C2, E-0357; probed E-0382)
SelectEffectByEffectFlags_RainSlashMode::
    ld a, [wEffectFlags]
    bit 3, a
    ret nz
    ld a, b
    cp $1d
    ret nz
    ld a, [wBattleActionId]
    cp SKILL_RAINSLASH
    ret nz
    ld a, $02
    ret

; The effect's slot (wBattleArg0): the target, or the actor for Transform unless wEffectFlags bit 3
; is set. (C2, E-0357; probed E-0382)
SelectEffectByEffectFlags_SetEffectSlot::
    ld a, [wEffectFlags]
    bit 3, a
    jr nz, .read_battle_target
    ld a, [wBattleActionId]
    cp SKILL_TRANSFORM
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

; Sets wEffectSpriteX, the screen X of the effect sprite, from wEffectTargetMode. Mode 0 reads
; SetEffectSpriteXForTargets_Data at (wBattleArg0 & 3) plus a base picked by wBattleFoeCount (0 for
; three foes, 3 for two, 5 otherwise). Mode 1 gives $50. Mode 2 with three or two foes fills the
; list at wEffectStep with the X of each present slot among the three scanned (slots 4-6, or 0-2 for
; the link follower: wLinkMode 1 with wLinkRole bit 1) and sets wEffectSpriteX to the first; with
; one foe it reads the data at (wBattleArg0 & 3) + wBattleFoeCount instead, because the branch jumps
; into the mode 0 code with B still holding the foe count. Any other mode gives 0. (C2, E-0382)
; sets wEffectSpriteX (and the wEffectStep list for all targets) to the screen X of the target from
; SetEffectSpriteXForTargets_Data by wEffectTargetMode and the side count wBattleFoeCount (E-0129)
SetEffectSpriteXForTargets::
    ld a, [wEffectTargetMode]
    cp $00
    jr z, .read_battle_foe_count
    cp $01
    jr z, .set_effect_sprite_x_to_50
    cp $02
    jr z, .read_battle_foe_count2
    ld a, $00
    ld [wEffectSpriteX], a
    ret

.read_battle_foe_count:
    ld a, [wBattleFoeCount]
    ld b, a
    ld a, b
    cp $03
    jr z, .skip
    cp $02
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
    and $03
    add b
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
    cp $01
    jr nz, .skip2
    ld a, [wLinkRole]
    bit 1, a
    jr z, .skip2
    ld c, $00

.skip2:
    ld e, $00
    ld a, b
    cp $03
    jr z, .skip3
    cp $02
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
    and $03
    add d
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

; Six screen X coordinates, $20, $50, $80, $38, $68 and $50: the effect sprite X for a target by foe
; count. Entries 0 to 2 are used with three foes (slot 0, 1, 2), entries 3 and 4 with two foes, and
; entry 5 with one foe. SetEffectSpriteXForTargets adds wBattleArg0 masked with 3 to the base 0, 3
; or 5 (picked by wBattleFoeCount) and stores the byte in wEffectSpriteX; for target mode 2 it fills
; the wEffectStep bytes with the X of each present slot the same way. (C1, E-0381)
SetEffectSpriteXForTargets_Data::
    db $20, $50, $80, $38, $68, $50

; Per-frame driver of the battle effect, called through farcall by RunBattleActions, RunBattleStep4,
; GameMode4_Update and GameMode7_Update only while wEffectId is not $FF. wEffectId 0 means an effect
; routine was chosen: it jumps to RunBattleEffectAnimation_RunRoutine. Otherwise it follows
; wEffectAnimState: state 1 decompresses the graphics of wEffectTileOffset to vTiles0
; (DecompressGraphicsAToTiles0), sets state 2 and plays the sound of the action (wEffectFlags2 =
; (wEffectFlags >> 1) & $44, then SelectEffectByEffectFlags2Flags). State 2 ticks the sprite
; sequence (TickSequencePtrLoSequence, not in link mode), moves the sprite 4 pixels in target mode 3
; and draws it while wEffectAnimId and wEffectActive are non-zero. When either is 0, target mode 2
; with a value other than $FF in wEffectFlashState (else wEffectCounter) copies it to
; wEffectSpriteX, resets it to $FF, stops the sprite and enters state 3 with wEffectFrameCounter 8;
; otherwise the effect ends (state 0, wEffectActive 0, wEffectId $FF), or, when wEffectAnimFlags is
; set, a second effect from RunBattleEffectAnimation_Data starts at once. State 3 counts
; wEffectFrameCounter down and then restarts the sequence and the sound in state 2. (C1, E-0382)
; runs the battle effect animation state wEffectAnimState: loads the effect graphics, steps the
; effect sprite and its X positions, and ends the effect (E-0130)
RunBattleEffectAnimation::
    ld a, [wEffectId]
    cp $00
    jp z, RunBattleEffectAnimation_RunRoutine
    ld a, [wEffectAnimState]
    cp $01
    jr nz, .check_effect_anim_state
    ld a, [wEffectTileOffset]
    ld c, a
    call DecompressGraphicsAToTiles0
    ld a, $02
    ld [wEffectAnimState], a
    ld a, [wEffectFlags]
    srl a
    and $44
    ld [wEffectFlags2], a
    call SelectEffectByEffectFlags2Flags
    ret

.check_effect_anim_state:
    ld a, [wEffectAnimState]
    cp $02
    jp nz, .skip
    ld a, [wLinkMode]
    or a
    jr nz, .call_advance_effect_sprite_x_by4_in_mode3
    farcall TickSequencePtrLoSequence

.call_advance_effect_sprite_x_by4_in_mode3:
    call AdvanceEffectSpriteXBy4InMode3
    ld a, [wEffectAnimId]
    or a
    jr z, .check_effect_target_mode
    ld a, [wEffectActive]
    or a
    jr z, .check_effect_target_mode
    call DrawEffectSpriteForEffectTileOffsetRange
    ret

.check_effect_target_mode:
    ld a, [wEffectTargetMode]
    cp $02
    jr nz, .check_effect_anim_flags
    ld a, [wEffectFlashState]
    cp $ff
    jr z, .check_effect_counter
    ld a, [wEffectFlashState]
    ld [wEffectSpriteX], a
    ld a, $ff
    ld [wEffectFlashState], a
    xor a
    ld [wEffectActive], a
    ld a, $03
    ld [wEffectAnimState], a
    ld a, $08
    ld [wEffectFrameCounter], a
    ret

.check_effect_counter:
    ld a, [wEffectCounter]
    cp $ff
    jr z, .check_effect_anim_flags
    ld a, [wEffectCounter]
    ld [wEffectSpriteX], a
    ld a, $ff
    ld [wEffectCounter], a
    xor a
    ld [wEffectActive], a
    ld a, $03
    ld [wEffectAnimState], a
    ld a, $08
    ld [wEffectFrameCounter], a
    ret

.check_effect_anim_flags:
    ld a, [wEffectAnimFlags]
    or a
    jr nz, .clear_effect_anim_flags
    xor a
    ld [wEffectAnimState], a
    ld [wEffectActive], a
    ld a, $ff
    ld [wEffectId], a
    ret

.skip:
    ld hl, wEffectFrameCounter
    dec [hl]
    ld a, [hl]
    or a
    ret nz
    xor a
    ld [wEffectFrameCounter], a
    ld a, $02
    ld [wEffectAnimState], a
    ld a, $01
    ld [wEffectActive], a
    ld a, $00
    ld [wEffectAnimId], a
    farcall TickSequencePtrLoSequence
    ld a, [wEffectFlags]
    srl a
    and $44
    ld [wEffectFlags2], a
    call SelectEffectByEffectFlags2Flags
    ret

.clear_effect_anim_flags:
    xor a
    ld [wEffectAnimFlags], a
    ld a, [wBattleActionId]
    sub $d7
    sla a
    ld hl, RunBattleEffectAnimation_Data
    add_a_to_hl
    ld a, [hli]
    ld [wEffectTileOffset], a
    ld [wEffectAnimArg], a
    ld a, [hl]
    ld [wEffectTargetMode], a
    xor a
    ld [wEffectSpriteX], a
    ld a, $ff
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
    ld [wEffectAnimId], a
    ld hl, wEffectAnimId
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

; One entry of two bytes: $22 (the effect number, stored in wEffectTileOffset and wEffectAnimArg)
; and $00 (the target mode, stored in wEffectTargetMode). RunBattleEffectAnimation indexes it by 2 *
; (wBattleActionId - $D7) when an effect ends while wEffectAnimFlags is set, which
; SelectEffectByEffectFlags_StartAnimation does only for ACTION_D7, and starts a second effect with
; these values. (C1, E-0381)
RunBattleEffectAnimation_Data::
    db $22, $00

; Runs the effect routine every fifth frame and the faded background palettes; when the effect has
; ended ($FF) requests all background palettes. (C1, E-0357)
RunBattleEffectAnimation_RunRoutine::
    call RunEffectRoutineEffectEvery5Frames
    call UploadBGPalettesWithFade
    ld a, [wEffectId]
    cp $ff
    ret nz
    ld a, $7f
    ld [wBGPaletteUploadRequest], a
    ret

; Called on every frame by RunBattleEffectAnimation_RunRoutine while wEffectId is 0. It adds 1 to
; wEffectFrameCounter and returns until the count reaches 5, then clears it and runs the effect
; routine of wEffectRoutine through a jump table of 14: entries 0 and 1
; RunEffectRoutineEffectEvery5Frames_EndAtOnce, 2 RunEffectRoutineEffectEvery5Frames_BlinkTarget, 3
; RunEffectRoutineEffectEvery5Frames_ScrollShake, 4 RunEffectRoutineEffectEvery5Frames_FlashWhite, 5
; RunEffectRoutineEffectEvery5Frames_FlashOnce, 6 RunEffectRoutineEffectEvery5Frames_InvertPalettes,
; 7 RunEffectRoutineEffectEvery5Frames_FlashTwice, 8
; RunEffectRoutineEffectEvery5Frames_ShakeAndFlash, 9 RunEffectRoutineEffectEvery5Frames_CountUp, 10
; RunEffectRoutineEffectEvery5Frames_FlashPalette, 11
; RunEffectRoutineEffectEvery5Frames_FlashWhiteLong, 12
; RunEffectRoutineEffectEvery5Frames_ShakeScreen, 13 RunEffectRoutineEffectEvery5Frames_BlinkActor.
; wEffectRoutine is not range checked. (C1, E-0382)
; every fifth frame (wEffectFrameCounter) runs the effect routine for wEffectRoutine (jump table of
; fourteen) (E-0124)
RunEffectRoutineEffectEvery5Frames::
    ld a, [wEffectFrameCounter]
    inc a
    cp $05
    ld [wEffectFrameCounter], a
    ret c
    xor a
    ld [wEffectFrameCounter], a
    ld a, [wEffectRoutine]
    jumptable
    dw RunEffectRoutineEffectEvery5Frames_EndAtOnce
    dw RunEffectRoutineEffectEvery5Frames_EndAtOnce
    dw RunEffectRoutineEffectEvery5Frames_BlinkTarget
    dw RunEffectRoutineEffectEvery5Frames_ScrollShake
    dw RunEffectRoutineEffectEvery5Frames_FlashWhite
    dw RunEffectRoutineEffectEvery5Frames_FlashOnce
    dw RunEffectRoutineEffectEvery5Frames_InvertPalettes
    dw RunEffectRoutineEffectEvery5Frames_FlashTwice
    dw RunEffectRoutineEffectEvery5Frames_ShakeAndFlash
    dw RunEffectRoutineEffectEvery5Frames_CountUp
    dw RunEffectRoutineEffectEvery5Frames_FlashPalette
    dw RunEffectRoutineEffectEvery5Frames_FlashWhiteLong
    dw RunEffectRoutineEffectEvery5Frames_ShakeScreen
    dw RunEffectRoutineEffectEvery5Frames_BlinkActor

; Effect routines 0 and 1: end the effect at once (wEffectId $FF, wEffectSpriteX 0). (C2, E-0371;
; probed E-0382)
RunEffectRoutineEffectEvery5Frames_EndAtOnce::
    ld a, $ff
    ld [wEffectId], a
    xor a
    ld [wEffectSpriteX], a
    ret

; Effect routine 2: ends unless the target is one present slot on the far side (4 and up, or below 4
; for the link follower); then blinks its picture through four steps. (C1, E-0357)
RunEffectRoutineEffectEvery5Frames_BlinkTarget::
    ld a, [wBattleTarget]
    and $03
    cp $03
    jp z, BlinkTarget_End
    ld a, [wLinkMode]
    cp $01
    jr nz, .check_battle_target
    ld a, [wLinkRole]
    bit 1, a
    jr z, .check_battle_target
    ld a, [wBattleTarget]
    cp $04
    jr nc, BlinkTarget_End
    jr .read_battle_target

.check_battle_target:
    ld a, [wBattleTarget]
    cp $04
    jr c, BlinkTarget_End

.read_battle_target:
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, BlinkTarget_End
    ld a, [wEffectSpriteX]
    jumptable
    dw RunEffectRoutineEffectEvery5Frames_CoverTarget
    dw RunEffectRoutineEffectEvery5Frames_RestoreTarget
    dw RunEffectRoutineEffectEvery5Frames_CoverTarget
    dw RunEffectRoutineEffectEvery5Frames_RestoreTarget
    dw BlinkTarget_End

; Effect routine 2, steps 0 and 2: covers the target's picture place with tile block 3 (six rows).
; (C1, E-0357)
RunEffectRoutineEffectEvery5Frames_CoverTarget::
    ld a, $06
    ld [wEffectStep], a
    call EffectPositionIndexForTarget
    ld hl, EffectPictureBGMapOffsets
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

; Effect routine 2, steps 1 and 3: restores the target's picture place from its own tile block (slot
; & 3). (C1, E-0357)
RunEffectRoutineEffectEvery5Frames_RestoreTarget::
    ld a, $06
    ld [wEffectStep], a
    call EffectPositionIndexForTarget
    ld hl, EffectPictureBGMapOffsets
    call ReadWordTableEntry_Bank3A
    ld de, vBGMap0
    add hl, de
    ld e, l
    ld d, h
    ld a, [wBattleTarget]
    and $03
    ld hl, EffectTileBlockTable
    call ReadWordTableEntry_Bank3A
    ld c, $06
    call CopyVRAMRectToBuffer
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; Effect routine 2's end (step 4, or a target that cannot blink): wEffectId $FF, wEffectSpriteX and
; wEffectStep 0. (C2, E-0371; probed E-0382)
BlinkTarget_End::
    ld a, $ff
    ld [wEffectId], a
    xor a
    ld [wEffectSpriteX], a
    xor a
    ld [wEffectStep], a
    ret

; A = the 0-4 position index of the picture place of the target (see EffectPictureBGMapOffsets,
; which the callers index with it), from wBattleFoeCount and wBattleTarget & 3. One foe: 0. Two
; foes: 2 for slot 1, else 1. Three foes (or any other count): 0 for slot 1, 3 for slot 0 and 4 for
; slot 2. Called by RunEffectRoutineEffectEvery5Frames_CoverTarget and
; RunEffectRoutineEffectEvery5Frames_RestoreTarget. (C2, E-0382)
; A = a 0-4 position index from wBattleFoeCount (side count) and the target's slot (E-0124)
EffectPositionIndexForTarget::
    ld a, [wBattleFoeCount]
    cp $01
    jr z, .return_00
    cp $02
    jr z, .check_battle_target
    ld a, [wBattleTarget]
    and $03
    cp $01
    jr z, .return_00
    jr c, .skip
    ld a, $04
    jr .return

.skip:
    ld a, $03
    jr .return

.check_battle_target:
    ld a, [wBattleTarget]
    and $03
    cp $01
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

; Copies a rectangle from VRAM at HL to DE: C rows of wEffectStep bytes, each byte read with
; interrupts off after WaitForVRAMAccess, the destination rows 32 bytes apart. (C1, E-0357)
CopyVRAMRectToBuffer::
    push de
    ld a, [wEffectStep]
    ld b, a

.loop:
    di
    call WaitForVRAMAccess
    ld a, [hli]
    ld [de], a
    ei
    inc de
    dec b
    jr nz, .loop
    pop de
    dec c
    ret z
    ld a, $20
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    jr CopyVRAMRectToBuffer

; HL = table of words, A = index: HL = the word at HL + 2 * A, low byte first, and A = its low byte.
; A is doubled in 8 bits, so an index of $80 or more wraps. Called by the Cover and Restore steps of
; the blink effects (RunEffectRoutineEffectEvery5Frames_CoverTarget,
; RunEffectRoutineEffectEvery5Frames_RestoreTarget, RunEffectRoutineEffectEvery5Frames_CoverActor
; and RunEffectRoutineEffectEvery5Frames_RestoreActor); per-bank copies exist in banks $00 and $36.
; (C2, E-0382)
; HL = table of words, A = index: HL = the word at HL + 2 * A (A is doubled in 8 bits, so it wraps
; above $7F); A = its low byte (E-0065) (the same 11 bytes appear in 2 banks)
ReadWordTableEntry_Bank3A::
    add a
    add l
    ld l, a
    ld a, $00
    adc h
    ld h, a
    deref_hl
    ret

; Five words, offsets added to vBGMap0: $00E7, $00E4, $00EA, $00E1 and $00ED (BG map row 7, columns
; 7, 4, 10, 1 and 13), indexed by the 0-4 position from EffectPositionIndexForTarget or
; EffectPositionIndexForActor (ReadWordTableEntry_Bank3A). The result is the top-left corner of a
; monster's 6 x 6 picture place, where the blink steps
; (RunEffectRoutineEffectEvery5Frames_CoverTarget, RunEffectRoutineEffectEvery5Frames_RestoreTarget,
; RunEffectRoutineEffectEvery5Frames_CoverActor, RunEffectRoutineEffectEvery5Frames_RestoreActor)
; copy a tile block from EffectTileBlockTable with CopyVRAMRectToBuffer. (C1, E-0372)
EffectPictureBGMapOffsets::
    db $e7, $00, $e4, $00, $ea, $00, $e1, $00, $ed, $00

; two effect routines read the word at $4D5C + 2 * index (index 3, or wBattleTarget & 3) and pass it
; to CopyVRAMRectToBuffer with C = 6; four words point at the four 36-byte blocks that follow
; (E-0234, C1)
; record: 6 x 6 tile block
EffectTileBlockTable::
    dw EffectTileBlock0 ; id 0
    dw EffectTileBlock1 ; id 1
    dw EffectTileBlock2 ; id 2
    dw EffectTileBlock3 ; id 3

; block 0 of EffectTileBlockTable, 6 x 6 tile numbers (E-0234, C1)
; record: row of tile numbers
EffectTileBlock0::
    db $14, $15, $16, $17, $18, $19 ; id 0
    db $1a, $1b, $1c, $1d, $1e, $1f ; id 1
    db $20, $21, $22, $23, $24, $25 ; id 2
    db $26, $27, $28, $29, $2a, $2b ; id 3
    db $2c, $2d, $2e, $2f, $30, $31 ; id 4
    db $32, $33, $34, $35, $36, $37 ; id 5

; block 1 of EffectTileBlockTable, 6 x 6 tile numbers (E-0234, C1)
EffectTileBlock1::
    db $38, $39, $3a, $3b, $3c, $3d ; id 0
    db $3e, $3f, $40, $41, $42, $43 ; id 1
    db $44, $45, $46, $47, $48, $49 ; id 2
    db $4a, $4b, $4c, $4d, $4e, $4f ; id 3
    db $50, $51, $52, $53, $54, $55 ; id 4
    db $56, $57, $58, $59, $5a, $5b ; id 5

; block 2 of EffectTileBlockTable, 6 x 6 tile numbers (E-0234, C1)
EffectTileBlock2::
    db $5c, $5d, $5e, $5f, $60, $61 ; id 0
    db $62, $63, $64, $65, $66, $67 ; id 1
    db $68, $69, $6a, $6b, $6c, $6d ; id 2
    db $6e, $6f, $70, $71, $72, $73 ; id 3
    db $74, $75, $76, $77, $78, $79 ; id 4
    db $7a, $7b, $7c, $7d, $7e, $7f ; id 5

; block 3 of EffectTileBlockTable, 6 x 6 tile numbers, all $C3 (E-0234, C1)
EffectTileBlock3::
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 0
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 1
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 2
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 3
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 4
    db $c3, $c3, $c3, $c3, $c3, $c3 ; id 5

; Effect routine 3, stepped by wEffectSpriteX: 0 and 2 ScrollShake_Start (hScrollY 2), 1
; ScrollShake_Back (scroll 0), 3 ScrollShake_End (scroll 0 and the effect ends). A short vertical
; jolt, twice. (C2, E-0382)
; steps that write hScrollY/hScrollX, then the next effect id
RunEffectRoutineEffectEvery5Frames_ScrollShake::
    ld a, [wEffectSpriteX]
    jumptable
    dw ScrollShake_Start
    dw ScrollShake_Back
    dw ScrollShake_Start
    dw ScrollShake_End

; The scroll shake, step 0: moves the screen 2 pixels (hScrollY 2). (C2, E-0357; probed E-0382)
ScrollShake_Start::
    ld a, $02
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; Sets hScrollY = 0 and hScrollX = 1 and adds 1 to wEffectSpriteX. Nothing in src/ calls it or lists
; it in a table. (C2, E-0382)
; hScrollY = 0, hScrollX = 1, then wEffectSpriteX += 1 (E-0116)
SetScroll0_1AndIncEffectSpriteX::
    ld a, $00
    ldh [hScrollY], a
    ld a, $01
    ldh [hScrollX], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; The scroll shake, step 1: back to 0. (C2, E-0357; probed E-0382)
ScrollShake_Back::
    xor a
    ldh [hScrollY], a
    xor a
    ldh [hScrollX], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; The scroll shake, step 3: resets the scroll and ends the effect. (C2, E-0357; probed E-0382)
ScrollShake_End::
    ld a, $ff
    ld [wEffectId], a
    xor a
    ldh [hScrollY], a
    xor a
    ldh [hScrollX], a
    xor a
    ld [wEffectSpriteX], a
    ret

; Effect routine 4 (wEffectRoutine), stepped by wEffectSpriteX, which here only counts the steps:
; three times sets the three DMG palette bytes (wDMGPaletteBGP and the two after it) to $00, every
; shade 0 (FlashAndMoveSprite_White), then back to $D2, $D2, $E2
; (SetDMGPaletteBGPPatternAndIncEffectSpriteX); step 6, FlashAndMoveSprite_End, restores them and
; ends the effect (wEffectId $FF, wEffectSpriteX 0). No sprite is moved. (C2, E-0372; probed E-0382)
; alternates rBGP writes with a palette pattern that moves the effect sprite right
RunEffectRoutineEffectEvery5Frames_FlashWhite::
    ld a, [wEffectSpriteX]
    jumptable
    dw FlashAndMoveSprite_White
    dw SetDMGPaletteBGPPatternAndIncEffectSpriteX
    dw FlashAndMoveSprite_White
    dw SetDMGPaletteBGPPatternAndIncEffectSpriteX
    dw FlashAndMoveSprite_White
    dw SetDMGPaletteBGPPatternAndIncEffectSpriteX
    dw FlashAndMoveSprite_End

; Flash and move, even steps (0, 2, 4; 0-14 in RunEffectRoutineEffectEvery5Frames_FlashWhiteLong):
; sets all three DMG palettes (wDMGPaletteBGP and the two after it) to 0, white, and moves to the
; next step. (C2, E-0371; probed E-0382)
FlashAndMoveSprite_White::
    ld hl, wDMGPaletteBGP
    ld [hl], $00
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $00
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; Sets the three DMG palette bytes (wDMGPaletteBGP and the two after it) to $D2, $D2, $E2, the
; values the other effect steps restore, and adds 1 to wEffectSpriteX. It is the odd step of
; RunEffectRoutineEffectEvery5Frames_FlashWhite and
; RunEffectRoutineEffectEvery5Frames_FlashWhiteLong, and FlashAndMoveSprite_End calls it. (C2,
; E-0382)
; wDMGPaletteBGP-wDMGPaletteOBP1 = $D2, $D2, $E2; wEffectSpriteX += 1 (E-0074)
SetDMGPaletteBGPPatternAndIncEffectSpriteX::
    ld hl, wDMGPaletteBGP
    ld [hl], $d2
    inc hl
    ld [hl], $d2
    inc hl
    ld [hl], $e2
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; Flash and move, last step (6, or 16 in RunEffectRoutineEffectEvery5Frames_FlashWhiteLong):
; restores the palettes ($D2, $D2, $E2; SetDMGPaletteBGPPatternAndIncEffectSpriteX) and ends the
; effect. (C2, E-0371; probed E-0382)
FlashAndMoveSprite_End::
    call SetDMGPaletteBGPPatternAndIncEffectSpriteX
    ld a, $ff
    ld [wEffectId], a
    xor a
    ld [wEffectSpriteX], a
    ret

; Effect routine 5, stepped by wEffectSpriteX: 0 FlashOnce_Darken (four darkening calls), 1
; FlashOnce_Hold (ten calls), 2 FlashOnce_Restore (palettes back to $D2, $D2, $E2), 3 FlashOnce_End
; (wEffectId $FF). (C2, E-0382)
; sets the effect counter, writes rBGP once, then the next effect id
RunEffectRoutineEffectEvery5Frames_FlashOnce::
    ld a, [wEffectSpriteX]
    jumptable
    dw FlashOnce_Darken
    dw FlashOnce_Hold
    dw FlashOnce_Restore
    dw FlashOnce_End

; Flash once, step 0: darkens the DMG palettes a shade per call, four times. (C2, E-0357; probed
; E-0382)
FlashOnce_Darken::
    call DarkenDMGPaletteOneStep
    ld a, [wEffectCounter]
    cp $04
    ret c
    xor a
    ld [wEffectFlashState], a
    xor a
    ld [wEffectCounter], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; Flash once, step 1: waits ten calls. (C2, E-0357; probed E-0382)
FlashOnce_Hold::
    ld hl, wEffectStep
    inc [hl]
    ld a, [wEffectStep]
    cp $0a
    ret nz
    ld hl, wEffectSpriteX
    inc [hl]
    xor a
    ld [wEffectStep], a
    ret

; Flash once, step 2: restores the palettes ($D2, $D2, $E2). (C2, E-0357; probed E-0382)
FlashOnce_Restore::
    ld hl, wDMGPaletteBGP
    ld [hl], $d2
    inc hl
    ld [hl], $d2
    inc hl
    ld [hl], $e2
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; Flash once, step 3: ends the effect. (C2, E-0357; probed E-0382)
FlashOnce_End::
    ld a, $ff
    ld [wEffectId], a
    xor a
    ld [wEffectSpriteX], a
    ret

; Adds 1 to wEffectCounter and darkens the three DMG palette bytes (wDMGPaletteBGP and the two after
; it) by one shade each: every 2-bit shade goes up by 1 and stops at 3, except the top shade, where
; $C0 + $40 overflows to 0 so a top shade of 3 becomes 0. Register C is never cleared between the
; bytes, so the second and third byte also get the shades of the earlier bytes ORed in (for example
; $D2, $D2, $E2 becomes $27, $27, $37, and $00 x 3 becomes $55 x 3); likely game bugs. Called by
; FlashOnce_Darken and FlashTwice_Darken. (C2, E-0382)
; increments wEffectCounter and steps the three DMG palette bytes one shade darker: shades 0-2 cap
; at 3, but the top shade wraps from 3 to 0 ($C0 + $40 overflows past the cap check), and C is never
; cleared, so the second and third bytes also get the earlier bytes' low shades ORed in (likely game
; bugs; C2: executed in tests/test_helpers_behaviour.py)
DarkenDMGPaletteOneStep::
    ld hl, wEffectCounter
    inc [hl]
    ld b, $03
    ld c, $00
    ld hl, wDMGPaletteBGP

.loop:
    ld a, [hl]
    and $03
    add $01
    cp $04
    jr c, .skip
    ld a, $03

.skip:
    or c
    ld c, a
    ld a, [hl]
    and $0c
    add $04
    cp $0d
    jr c, .skip2
    ld a, $0c

.skip2:
    or c
    ld c, a
    ld a, [hl]
    and $30
    add $10
    cp $31
    jr c, .skip3
    ld a, $30

.skip3:
    or c
    ld c, a
    ld a, [hl]
    and $c0
    add $40
    cp $c1
    jr c, .skip4
    ld a, $c0

.skip4:
    or c
    ld [hli], a
    dec b
    jr nz, .loop
    ret

; Effect routine 6, stepped by wEffectSpriteX: steps 0-11 are InvertPalettes_Flip and step 12 is
; InvertPalettes_End. The twelve steps (five frames each) invert the three DMG palette bytes every
; time, so the palette flips twelve times and ends as it started. (C2, E-0382)
; twelve identical waiting steps, then the next effect id
RunEffectRoutineEffectEvery5Frames_InvertPalettes::
    ld a, [wEffectSpriteX]
    jumptable
    dw InvertPalettes_Flip
    dw InvertPalettes_Flip
    dw InvertPalettes_Flip
    dw InvertPalettes_Flip
    dw InvertPalettes_Flip
    dw InvertPalettes_Flip
    dw InvertPalettes_Flip
    dw InvertPalettes_Flip
    dw InvertPalettes_Flip
    dw InvertPalettes_Flip
    dw InvertPalettes_Flip
    dw InvertPalettes_Flip
    dw InvertPalettes_End

; Steps 0-11 of effect routine 6 (RunEffectRoutineEffectEvery5Frames_InvertPalettes, stepped by
; wEffectSpriteX): inverts the three DMG palette bytes (wDMGPaletteBGP and the two after it, each
; XOR $FF) and moves to the next step, so the twelve steps flash the palettes to their negative six
; times and leave them as they were; step 12 is InvertPalettes_End. (C2, E-0372; probed E-0382)
; inverts the three DMG palette bytes and moves the effect sprite right
InvertPalettes_Flip::
    ld hl, wDMGPaletteBGP
    ld a, [hl]
    xor $ff
    ld [hli], a
    ld a, [hl]
    xor $ff
    ld [hli], a
    ld a, [hl]
    xor $ff
    ld [hl], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; The delay, step 12: ends the effect. (C2, E-0357; probed E-0382)
InvertPalettes_End::
    ld a, $ff
    ld [wEffectId], a
    xor a
    ld [wEffectSpriteX], a
    ret

; Effect routine 7, stepped by wEffectSpriteX: 0 and 3 FlashTwice_Darken, 1 and 4 FlashTwice_Hold
; (five calls), 2 and 5 FlashTwice_Restore, 6 FlashTwice_End. The flash of effect routine 5 twice,
; with a shorter hold. (C2, E-0382)
; the FlashOnce steps twice, then the next effect id
RunEffectRoutineEffectEvery5Frames_FlashTwice::
    ld a, [wEffectSpriteX]
    jumptable
    dw FlashTwice_Darken
    dw FlashTwice_Hold
    dw FlashTwice_Restore
    dw FlashTwice_Darken
    dw FlashTwice_Hold
    dw FlashTwice_Restore
    dw FlashTwice_End

; Flash twice, steps 0 and 3: darkens the DMG palettes a shade per call (DarkenDMGPaletteOneStep);
; after four, clears wEffectFlashState and wEffectCounter and moves on. (C2, E-0371; probed E-0382)
FlashTwice_Darken::
    call DarkenDMGPaletteOneStep
    ld a, [wEffectCounter]
    cp $04
    ret c
    xor a
    ld [wEffectFlashState], a
    xor a
    ld [wEffectCounter], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; Flash twice, steps 1 and 4: waits five calls (wEffectStep), then moves on. (C2, E-0371; probed
; E-0382)
FlashTwice_Hold::
    ld hl, wEffectStep
    inc [hl]
    ld a, [wEffectStep]
    cp $05
    ret nz
    ld hl, wEffectSpriteX
    inc [hl]
    xor a
    ld [wEffectStep], a
    ret

; Flash twice, steps 2 and 5: restores the palettes ($D2, $D2, $E2) and moves on. (C2, E-0371;
; probed E-0382)
FlashTwice_Restore::
    ld hl, wDMGPaletteBGP
    ld [hl], $d2
    inc hl
    ld [hl], $d2
    inc hl
    ld [hl], $e2
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; Flash twice, step 6: ends the effect. (C2, E-0357; probed E-0382)
FlashTwice_End::
    ld a, $ff
    ld [wEffectId], a
    xor a
    ld [wEffectSpriteX], a
    ret

; Effect routine 8: runs the 27-step shake and the palette flash (RunEffectStep) together; when the
; shake has ended, ends the effect. (C2, E-0357; probed E-0382)
RunEffectRoutineEffectEvery5Frames_ShakeAndFlash::
    ld a, [wEffectSpriteX]
    or a
    call z, ShakeAndFlash_RunShake
    call RunEffectStep
    ld a, [wEffectSpriteX]
    or a
    ret z
    ld a, $ff
    ld [wEffectId], a
    xor a
    ld [wEffectSpriteX], a
    xor a
    ld [wEffectStep], a
    ret

; Effect routine 8's shake, while wEffectSpriteX is 0: one step of a 27-entry table by wEffectStep,
; mostly ShakeAndFlash_Down, ShakeAndFlash_Reset, ShakeAndFlash_Right, ShakeAndFlash_Reset in turn
; (steps 10-11 go Right then Down with no reset between); step 26 resets the scroll and sets
; wEffectSpriteX 1, which ends the routine. (C2, E-0371; probed E-0382)
ShakeAndFlash_RunShake::
    ld a, [wEffectSpriteX]
    or a
    ret nz
    ld a, [wEffectStep]
    jumptable
    dw ShakeAndFlash_Down
    dw ShakeAndFlash_Reset
    dw ShakeAndFlash_Right
    dw ShakeAndFlash_Reset
    dw ShakeAndFlash_Down
    dw ShakeAndFlash_Reset
    dw ShakeAndFlash_Right
    dw ShakeAndFlash_Reset
    dw ShakeAndFlash_Down
    dw ShakeAndFlash_Reset
    dw ShakeAndFlash_Right
    dw ShakeAndFlash_Down
    dw ShakeAndFlash_Reset
    dw ShakeAndFlash_Right
    dw ShakeAndFlash_Reset
    dw ShakeAndFlash_Down
    dw ShakeAndFlash_Reset
    dw ShakeAndFlash_Right
    dw ShakeAndFlash_Reset
    dw ShakeAndFlash_Down
    dw ShakeAndFlash_Reset
    dw ShakeAndFlash_Right
    dw ShakeAndFlash_Reset
    dw ShakeAndFlash_Down
    dw ShakeAndFlash_Reset
    dw ShakeAndFlash_Right
    dw ShakeAndFlash_EndShake

; Routine 8's shake: hScrollY 4, hScrollX 0. (C2, E-0357; probed E-0382)
ShakeAndFlash_Down::
    ld a, $04
    ldh [hScrollY], a
    ld a, $00
    ldh [hScrollX], a
    ld hl, wEffectStep
    inc [hl]
    ret

; Routine 8's shake: hScrollY 0, hScrollX 3. (C2, E-0357; probed E-0382)
ShakeAndFlash_Right::
    ld a, $00
    ldh [hScrollY], a
    ld a, $03
    ldh [hScrollX], a
    ld hl, wEffectStep
    inc [hl]
    ret

; Routine 8's shake: hScrollY and hScrollX 0. (C2, E-0357; probed E-0382)
ShakeAndFlash_Reset::
    xor a
    ldh [hScrollY], a
    xor a
    ldh [hScrollX], a
    ld hl, wEffectStep
    inc [hl]
    ret

; Routine 8's shake, step 26: resets the scroll and marks the shake done (wEffectSpriteX 1). (C2,
; E-0357; probed E-0382)
ShakeAndFlash_EndShake::
    ld a, $01
    ld [wEffectSpriteX], a
    xor a
    ldh [hScrollY], a
    xor a
    ldh [hScrollX], a
    xor a
    ld [wEffectStep], a
    ret

; Sets the three DMG palette bytes for the step wEffectStep (0-26): white
; (RunEffectStep_WhitePalettes) for 9 and the odd steps up to 25, otherwise the normal $D2, $D2, $E2
; (RunEffectStep_NormalPalettes). The step is not range checked. Called only by
; RunEffectRoutineEffectEvery5Frames_ShakeAndFlash after the shake step has moved wEffectStep on.
; (C2, E-0382)
; the frames of a screen-flash effect, run every fifth frame: each step sets the DMG background
; palette (rBGP) to the next shade (E-0354; was: runs the routine for wEffectStep (jump table)
; (E-0124))
RunEffectStep::
    ld a, [wEffectStep]
    jumptable
    dw RunEffectStep_NormalPalettes
    dw RunEffectStep_NormalPalettes
    dw RunEffectStep_NormalPalettes
    dw RunEffectStep_NormalPalettes
    dw RunEffectStep_NormalPalettes
    dw RunEffectStep_NormalPalettes
    dw RunEffectStep_NormalPalettes
    dw RunEffectStep_NormalPalettes
    dw RunEffectStep_NormalPalettes
    dw RunEffectStep_WhitePalettes
    dw RunEffectStep_NormalPalettes
    dw RunEffectStep_WhitePalettes
    dw RunEffectStep_NormalPalettes
    dw RunEffectStep_WhitePalettes
    dw RunEffectStep_NormalPalettes
    dw RunEffectStep_WhitePalettes
    dw RunEffectStep_NormalPalettes
    dw RunEffectStep_WhitePalettes
    dw RunEffectStep_NormalPalettes
    dw RunEffectStep_WhitePalettes
    dw RunEffectStep_NormalPalettes
    dw RunEffectStep_WhitePalettes
    dw RunEffectStep_NormalPalettes
    dw RunEffectStep_WhitePalettes
    dw RunEffectStep_NormalPalettes
    dw RunEffectStep_WhitePalettes
    dw RunEffectStep_NormalPalettes

; The palette flash, odd steps 9-25: all three DMG palettes 0 (white). (C2, E-0371; probed E-0382)
RunEffectStep_WhitePalettes::
    ld hl, wDMGPaletteBGP
    ld [hl], $00
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $00
    ret

; The palette flash, steps 0-8 and the even steps 10-26: the normal DMG palettes ($D2, $D2, $E2).
; (C2, E-0371; probed E-0382)
RunEffectStep_NormalPalettes::
    ld hl, wDMGPaletteBGP
    ld [hl], $d2
    inc hl
    ld [hl], $d2
    inc hl
    ld [hl], $e2
    ret

; Effect routine 9: increments wEffectCounter (both branches do the same); it never writes
; wEffectId, so it does not end the effect itself. (C2, E-0371; probed E-0382)
RunEffectRoutineEffectEvery5Frames_CountUp::
    ld a, [wEffectCounter]
    or a
    jr nz, .done
    ld hl, wEffectCounter
    inc [hl]
    ret

.done:
    ld hl, wEffectCounter
    inc [hl]
    ret

; Effect routine 10, stepped by wEffectSpriteX: 0 FlashPalette_Lighten (four calls of
; LightenDMGPaletteOneStep), 1 FlashPalette_Hold (ten calls), 2 FlashPalette_Restore (palettes back
; to $D2, $D2, $E2), 3 FlashPalette_End (wEffectId $FF). (C2, E-0382)
; by wEffectStep: sets the effect counter, writes the DMG palette rBGP and picks the effect position
RunEffectRoutineEffectEvery5Frames_FlashPalette::
    ld a, [wEffectSpriteX]
    jumptable
    dw FlashPalette_Lighten
    dw FlashPalette_Hold
    dw FlashPalette_Restore
    dw FlashPalette_End

; Flash light, step 0: lightens the DMG palettes a shade per call, four times. (C2, E-0357; probed
; E-0382)
FlashPalette_Lighten::
    call LightenDMGPaletteOneStep
    ld a, [wEffectCounter]
    cp $04
    ret c
    xor a
    ld [wEffectFlashState], a
    xor a
    ld [wEffectCounter], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; Flash light, step 1: waits ten calls. (C2, E-0357; probed E-0382)
FlashPalette_Hold::
    ld hl, wEffectStep
    inc [hl]
    ld a, [wEffectStep]
    cp $0a
    ret nz
    ld hl, wEffectSpriteX
    inc [hl]
    xor a
    ld [wEffectStep], a
    ret

; Flash light, step 2: restores the palettes ($D2, $D2, $E2). (C2, E-0357; probed E-0382)
FlashPalette_Restore::
    ld hl, wDMGPaletteBGP
    ld [hl], $d2
    inc hl
    ld [hl], $d2
    inc hl
    ld [hl], $e2
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; Flash light, step 3: ends the effect. (C2, E-0357; probed E-0382)
FlashPalette_End::
    ld a, $ff
    ld [wEffectId], a
    xor a
    ld [wEffectSpriteX], a
    ret

; Adds 1 to wEffectCounter and lightens the three DMG palette bytes (wDMGPaletteBGP and the two
; after it) by one shade each: every 2-bit shade goes down by 1 and stops at 0. Register C is never
; cleared between the bytes, so the second and third byte also get the shades of the earlier bytes
; ORed in (for example $D2, $D2, $E2 becomes $81, $81, $91 and $FF x 3 becomes $AA x 3). Called by
; FlashPalette_Lighten. (C2, E-0382)
; increments wEffectCounter and steps the three DMG palette bytes one shade lighter (each 2-bit
; shade minus 1, not below 0); C is never cleared, so the second and third bytes also get the
; earlier bytes' low shades ORed in (C2: executed in tests/test_helpers_behaviour.py)
LightenDMGPaletteOneStep::
    ld hl, wEffectCounter
    inc [hl]
    ld b, $03
    ld c, $00
    ld hl, wDMGPaletteBGP

.loop:
    ld a, [hl]
    and $03
    cp $00
    jr z, .skip
    sub $01

.skip:
    or c
    ld c, a
    ld a, [hl]
    and $0c
    cp $00
    jr z, .skip2
    sub $04

.skip2:
    or c
    ld c, a
    ld a, [hl]
    and $30
    cp $00
    jr z, .skip3
    sub $10

.skip3:
    or c
    ld c, a
    ld a, [hl]
    and $c0
    cp $00
    jr z, .skip4
    sub $40

.skip4:
    or c
    ld [hli], a
    dec b
    jr nz, .loop
    ret

; Effect routine 11: as RunEffectRoutineEffectEvery5Frames_FlashWhite but eight times: steps 0-15
; (by wEffectSpriteX) alternate FlashAndMoveSprite_White (DMG palettes $00) and
; SetDMGPaletteBGPPatternAndIncEffectSpriteX ($D2, $D2, $E2), then step 16, FlashAndMoveSprite_End,
; ends the effect. (C2, E-0372; probed E-0382)
; as RunEffectRoutineEffectEvery5Frames_FlashWhite
RunEffectRoutineEffectEvery5Frames_FlashWhiteLong::
    ld a, [wEffectSpriteX]
    jumptable
    dw FlashAndMoveSprite_White
    dw SetDMGPaletteBGPPatternAndIncEffectSpriteX
    dw FlashAndMoveSprite_White
    dw SetDMGPaletteBGPPatternAndIncEffectSpriteX
    dw FlashAndMoveSprite_White
    dw SetDMGPaletteBGPPatternAndIncEffectSpriteX
    dw FlashAndMoveSprite_White
    dw SetDMGPaletteBGPPatternAndIncEffectSpriteX
    dw FlashAndMoveSprite_White
    dw SetDMGPaletteBGPPatternAndIncEffectSpriteX
    dw FlashAndMoveSprite_White
    dw SetDMGPaletteBGPPatternAndIncEffectSpriteX
    dw FlashAndMoveSprite_White
    dw SetDMGPaletteBGPPatternAndIncEffectSpriteX
    dw FlashAndMoveSprite_White
    dw SetDMGPaletteBGPPatternAndIncEffectSpriteX
    dw FlashAndMoveSprite_End

; Effect routine 12, stepped by wEffectSpriteX over 28 steps: hScrollX goes -2, +2, -4, +4, -8, +8
; (ScreenShake_Left2 to ScreenShake_Right8), then four times -8 and +8 with hScrollY 2
; (ScreenShake_LeftDown, ScreenShake_RightDown), each followed by ScreenShake_Reset (scroll 0); step
; 27 is ScreenShake_End (scroll 0, wEffectId $FF). (C2, E-0382)
; a sequence of steps that only write hScrollX/hScrollY: a screen shake
RunEffectRoutineEffectEvery5Frames_ShakeScreen::
    ld a, [wEffectSpriteX]
    jumptable
    dw ScreenShake_Left2
    dw ScreenShake_Reset
    dw ScreenShake_Right2
    dw ScreenShake_Reset
    dw ScreenShake_Left4
    dw ScreenShake_Reset
    dw ScreenShake_Right4
    dw ScreenShake_Reset
    dw ScreenShake_Left8
    dw ScreenShake_Reset
    dw ScreenShake_Right8
    dw ScreenShake_Reset
    dw ScreenShake_LeftDown
    dw ScreenShake_Reset
    dw ScreenShake_RightDown
    dw ScreenShake_Reset
    dw ScreenShake_LeftDown
    dw ScreenShake_Reset
    dw ScreenShake_RightDown
    dw ScreenShake_Reset
    dw ScreenShake_LeftDown
    dw ScreenShake_Reset
    dw ScreenShake_RightDown
    dw ScreenShake_Reset
    dw ScreenShake_LeftDown
    dw ScreenShake_Reset
    dw ScreenShake_RightDown
    dw ScreenShake_End

; The screen shake, step 1: scroll back to 0. (C2, E-0357; probed E-0382)
ScreenShake_Reset::
    xor a
    ldh [hScrollX], a
    ldh [hScrollY], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; The screen shake, step 0: hScrollX -2. (C2, E-0357; probed E-0382)
ScreenShake_Left2::
    ld a, $fe
    ldh [hScrollX], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; The screen shake, step 2: hScrollX +2. (C2, E-0357; probed E-0382)
ScreenShake_Right2::
    ld a, $02
    ldh [hScrollX], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; The screen shake, step 4: hScrollX -4. (C2, E-0357; probed E-0382)
ScreenShake_Left4::
    ld a, $fc
    ldh [hScrollX], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; The screen shake, step 6: hScrollX +4. (C2, E-0357; probed E-0382)
ScreenShake_Right4::
    ld a, $04
    ldh [hScrollX], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; The screen shake, step 8: hScrollX -8. (C2, E-0357; probed E-0382)
ScreenShake_Left8::
    ld a, $f8
    ldh [hScrollX], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; The screen shake, step 10: hScrollX +8. (C2, E-0357; probed E-0382)
ScreenShake_Right8::
    ld a, $08
    ldh [hScrollX], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; The screen shake, step 12: hScrollX -8 and hScrollY 2. (C2, E-0357; probed E-0382)
ScreenShake_LeftDown::
    ld a, $f8
    ldh [hScrollX], a
    ld a, $02
    ldh [hScrollY], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; The screen shake, step 14: hScrollX +8 and hScrollY 2. (C2, E-0357; probed E-0382)
ScreenShake_RightDown::
    ld a, $08
    ldh [hScrollX], a
    ld a, $02
    ldh [hScrollY], a
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; The screen shake, step 27: resets the scroll and ends the effect. (C2, E-0357; probed E-0382)
ScreenShake_End::
    xor a
    ldh [hScrollX], a
    ldh [hScrollY], a
    ld a, $ff
    ld [wEffectId], a
    xor a
    ld [wEffectSpriteX], a
    ret

; Effect routine 13: ends unless the actor is a present slot 4-6 (0-2 in link mode 1, whatever the
; role; never slot 3 or 7 up); then blinks its picture through four steps. (C1, E-0357)
RunEffectRoutineEffectEvery5Frames_BlinkActor::
    ld a, [wLinkRole]
    ld b, a
    ld a, [wLinkMode]
    ld c, a
    ld a, [wBattleActor]
    cp $07
    jr nc, BlinkActor_End
    cp $03
    jr z, BlinkActor_End
    dec c
    jr nz, .cp_04
    cp $04
    jr nc, BlinkActor_End
    jr .read_battle_actor

.cp_04:
    cp $04
    jr c, BlinkActor_End

.read_battle_actor:
    ld a, [wBattleActor]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, BlinkActor_End
    ld a, [wEffectSpriteX]
    jumptable
    dw RunEffectRoutineEffectEvery5Frames_CoverActor
    dw RunEffectRoutineEffectEvery5Frames_RestoreActor
    dw RunEffectRoutineEffectEvery5Frames_CoverActor
    dw RunEffectRoutineEffectEvery5Frames_RestoreActor
    dw BlinkActor_End

; Effect routine 13, steps 0 and 2: covers the actor's picture place with tile block 3 (six rows).
; (C1, E-0357)
RunEffectRoutineEffectEvery5Frames_CoverActor::
    ld a, $06
    ld [wEffectStep], a
    call EffectPositionIndexForActor
    ld hl, EffectPictureBGMapOffsets
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

; Effect routine 13, steps 1 and 3: restores the actor's picture place from its own tile block (slot
; & 3). (C1, E-0357)
RunEffectRoutineEffectEvery5Frames_RestoreActor::
    ld a, $06
    ld [wEffectStep], a
    call EffectPositionIndexForActor
    ld hl, EffectPictureBGMapOffsets
    call ReadWordTableEntry_Bank3A
    ld de, vBGMap0
    add hl, de
    ld e, l
    ld d, h
    ld a, [wBattleActor]
    and $03
    ld hl, EffectTileBlockTable
    call ReadWordTableEntry_Bank3A
    ld c, $06
    call CopyVRAMRectToBuffer
    ld hl, wEffectSpriteX
    inc [hl]
    ret

; Effect routine 13's end (step 4, or an actor that cannot blink): wEffectId $FF, wEffectSpriteX and
; wEffectStep 0. (C2, E-0371; probed E-0382)
BlinkActor_End::
    ld a, $ff
    ld [wEffectId], a
    xor a
    ld [wEffectSpriteX], a
    xor a
    ld [wEffectStep], a
    ret

; A = a place index 0-4 for the picture of the actor, from the foe count wBattleFoeCount and the
; actor slot wBattleActor AND 3. One foe gives 0. Two foes give 2 for slot 1 and 1 for any other
; slot. Three foes give 0 for slot 1, 3 for slot 0 and 4 for slots 2 and 3. Only A changes.
; RunEffectRoutineEffectEvery5Frames_CoverActor and RunEffectRoutineEffectEvery5Frames_RestoreActor
; use it to pick the word of EffectPictureBGMapOffsets where the picture sits. (C2, E-0382)
; A = a 0-4 position index from wBattleFoeCount (side count) and the actor's slot (E-0124)
EffectPositionIndexForActor::
    ld a, [wBattleFoeCount]
    cp $01
    jr z, .return_00
    cp $02
    jr z, .check_battle_actor
    ld a, [wBattleActor]
    and $03
    cp $01
    jr z, .return_00
    jr c, .skip
    ld a, $04
    jr .return

.skip:
    ld a, $03
    jr .return

.check_battle_actor:
    ld a, [wBattleActor]
    and $03
    cp $01
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

; A = effect graphics number (0-59). Reads the 3-byte far pointer (address low, address high, ROM
; bank) at BattleEffectGraphicsTable + 3 * A and decompresses that stream into video RAM at vTiles0
; with DecompressToVRAM. RunBattleEffectAnimation and RunDebugState_E0_EffectViewer_PlayEffect call
; it with wEffectTileOffset as the number (it also sits in C there, which is overwritten). Clobbers
; A, BC, DE and HL. (C1, E-0382)
; A = entry: decompresses the stream named by the 3-byte far pointer at BattleEffectGraphicsTable +
; 3 * A to vTiles0 (DecompressToVRAM) (E-0118)
DecompressGraphicsAToTiles0::
    ld c, a
    ld b, $00
    ld hl, BattleEffectGraphicsTable
    add hl, bc
    add hl, bc
    add hl, bc
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    ld b, [hl]
    ld hl, vTiles0
    call DecompressToVRAM
    ret

; DecompressGraphicsAToTiles0 decompresses the far pointer at $52B9 + 3 * A to vTiles0;
; RunBattleEffectAnimation and the debug effect viewer call it; all 60 entries decode (E-0145, C1)
; record: compressed effect graphics (vTiles0); its ROM bank
BattleEffectGraphicsTable::
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

; Only when wEffectTargetMode is 3: adds 4 to wEffectSpriteX and, once it reaches $D0 or more,
; clears wEffectActive, so the caller stops drawing and ends the effect. In any other mode it
; returns at once. RunBattleEffectAnimation and RunDebugState_E0_EffectViewer_PlayEffect call it
; every step before drawing, so a mode 3 sprite slides to the right. (C2, E-0382)
; when wEffectTargetMode is 3: wEffectSpriteX += 4, and once it reaches $D0 wEffectActive = 0
; (E-0119)
AdvanceEffectSpriteXBy4InMode3::
    ld a, [wEffectTargetMode]
    cp $03
    ret nz
    ld a, [wEffectSpriteX]
    add $04
    ld [wEffectSpriteX], a
    cp $d0
    ret c
    xor a
    ld [wEffectActive], a
    ret

; Draws the effect sprite with the routine of one of five banks, picked by wEffectTileOffset: below
; $0E DrawEffectSpriteAtEffectSpriteX_Bank3E, $0E-$1F DrawEffectSpriteOverTargets_Bank3F, $20-$2C
; DrawEffectSpriteOverTargets (bank $3D), $2D-$32 DrawEffectSpriteAtEffectSpriteX_Bank3B and $33 or
; more DrawEffectSpriteAtEffectSpriteX_Bank92. Each one builds OAM entries from hOamNextEntry on and
; uses wEffectTileOffset as the metasprite set number (hSpriteSetIndex) and wEffectSpriteAttrXor as
; the frame number (hSpriteSubIndex). Called by RunBattleEffectAnimation and
; RunDebugState_E0_EffectViewer_PlayEffect after the effect sprite moved. (C2, E-0382)
; draws the effect sprite from bank $3E, $3F, $3D, $3B or $92 by wEffectTileOffset (< $0E, $20, $2D,
; $33, or more) (E-0124)
DrawEffectSpriteForEffectTileOffsetRange::
    ld a, [wEffectTileOffset]
    cp $0e
    jr c, .call_draw_effect_sprite_at_effect_sprite_x
    cp $20
    jr c, .call_draw_effect_sprite_over_targets_bank3_f
    cp $2d
    jr c, .call_draw_effect_sprite_over_targets
    cp $33
    jr c, .call_draw_effect_sprite_at_effect_sprite_x2
    farcall DrawEffectSpriteAtEffectSpriteX_Bank92
    ret

.call_draw_effect_sprite_at_effect_sprite_x:
    farcall DrawEffectSpriteAtEffectSpriteX_Bank3E
    ret

.call_draw_effect_sprite_over_targets_bank3_f:
    farcall DrawEffectSpriteOverTargets_Bank3F
    ret

.call_draw_effect_sprite_over_targets:
    farcall DrawEffectSpriteOverTargets
    ret

.call_draw_effect_sprite_at_effect_sprite_x2:
    farcall DrawEffectSpriteAtEffectSpriteX_Bank3B
    ret

; The debug skill page: draws the entries of the skill wDebugValue0 in ActionEffectTable_Flag7,
; Flag6, Flag5 and the rest as hex digits, each at two BG map places a row apart. (C1, E-0357)
DrawSkillDebugPage::
    ld hl, vBGMap0 + $1ce
    ld a, l
    ld [wBattleArg0], a
    ld a, h
    ld [wBattleArg1], a
    ld hl, vBGMap0 + $1d2
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    ld hl, ActionEffectTable_Flag7
    call DrawSkillDebugPage_DrawEntry
    ld hl, vBGMap0 + $1ee
    ld a, l
    ld [wBattleArg0], a
    ld a, h
    ld [wBattleArg1], a
    ld hl, vBGMap0 + $1f2
    ld a, l
    ld [wBattleArg2], a
    ld a, h
    ld [wBattleArg3], a
    ld hl, ActionEffectTable_Flag6
    call DrawSkillDebugPage_DrawEntry
    ld hl, vBGMap0 + $20e
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

; Draws the two bytes of entry wDebugValue0 of table HL as hex digits ($E0 + 0-9, n - 2 for A-F):
; the second at wBattleArg0/1, the first at wBattleArg2/3; a byte $FF is left out. (C1, E-0357)
DrawSkillDebugPage_DrawEntry::
    ld a, [wDebugValue0]
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    inc hl
    ld a, [hl]
    cp $ff
    jr z, .next
    push hl
    push af
    and $0f
    cp $0a
    jr nc, .read_battle_arg0
    add $e0
    jr .read_battle_arg02

.read_battle_arg0:
    sub $02

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
    and $0f
    cp $0a
    jr nc, .read_battle_arg03
    add $e0
    jr .read_battle_arg04

.read_battle_arg03:
    sub $02

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
    cp $ff
    jr z, .return
    push af
    and $0f
    cp $0a
    jr nc, .read_battle_arg2
    add $e0
    jr .read_battle_arg22

.read_battle_arg2:
    sub $02

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
    and $0f
    cp $0a
    jr nc, .read_battle_arg23
    add $e0
    jr .read_battle_arg24

.read_battle_arg23:
    sub $02

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

; Starts the debug effect wDebugSubState (target mode 1): resets its steps, starts its sequence,
; sets its X and loads its object palette. (C2, E-0357; probed E-0382)
RunDebugState_E0_EffectViewer_StartEffect::
    ld a, [wDebugSubState]
    ld [wEffectTileOffset], a
    ld [wEffectAnimArg], a
    ld a, $01
    ld [wEffectTargetMode], a
    xor a
    ld [wEffectSpriteX], a
    ld a, $ff
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
    ld [wEffectAnimId], a
    ld hl, wEffectAnimId
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

; Runs the debug effect: first decompresses its graphics; then ticks its sequence, moves it in mode
; 3 and draws it until it ends ($FF). (C1, E-0357)
RunDebugState_E0_EffectViewer_PlayEffect::
    ld a, [wEffectAnimState]
    cp $01
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
    ld a, [wEffectAnimId]
    or a
    jr z, .clear_effect_anim_state
    ld a, [wEffectActive]
    or a
    jr z, .clear_effect_anim_state
    call DrawEffectSpriteForEffectTileOffsetRange
    ret

.clear_effect_anim_state:
    xor a
    ld [wEffectAnimState], a
    ld [wEffectActive], a
    ld a, $ff
    ld [wEffectId], a
    ret

; C = effect palette number. On a Game Boy Color (wIsCGB non-zero) copies the 8 bytes (4 colours) at
; EffectOBJPalettes + 8 * C to the start of wOBJPaletteBuffer and sets wOBJPaletteUploadRequest to
; $80 so the VBlank handler uploads it; on other consoles it returns at once.
; SelectEffectByEffectFlags_StartAnimation, RunBattleEffectAnimation and
; RunDebugState_E0_EffectViewer_StartEffect call it with C = wEffectTileOffset. (C2, E-0382)
; on CGB copies palette C (8 bytes) from EffectOBJPalettes to wOBJPaletteBuffer and sets
; wOBJPaletteUploadRequest = $80 (E-0124)
LoadEffectOBJPaletteC::
    ld a, [wIsCGB]
    or a
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
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop
    ld a, $80
    ld [wOBJPaletteUploadRequest], a
    ret

; On a Game Boy Color only: when wDMGPaletteBGP differs from the saved byte wDMGPaletteBytes, writes
; the eight palettes of wBGPaletteBuffer to the background palette port (rBGPI starting $80, data
; through port $FF69) with UploadBGPaletteByDMGShades, which picks and orders the four colours of
; each palette by the four 2-bit shades of wDMGPaletteBGP and waits for rSTAT bit 1 to clear before
; each write, then stores wDMGPaletteBGP in wDMGPaletteBytes. In both cases it goes on with
; UploadBGPalettesWithFade_OBJPalettes (the same for the object palettes with wDMGPaletteOBP0 and
; wDMGPaletteBytes + 1). On a Game Boy it returns at once. RunBattleEffectAnimation_RunRoutine calls
; it every step, so a screen fade written to the DMG palette bytes reaches the colour palettes. (C1,
; E-0382)
; on CGB, when wDMGPaletteBGP changed, writes the eight background palettes through
; UploadBGPaletteByDMGShades (rBGPI $80-$B8) (E-0128)
UploadBGPalettesWithFade::
    ld a, [wIsCGB]
    or a
    ret z
    ld hl, wDMGPaletteBytes
    ld a, [wDMGPaletteBGP]
    cp [hl]
    jp z, UploadBGPalettesWithFade_OBJPalettes
    ld c, $69

.loop:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop
    ld a, $80
    ldh [rBGPI], a
    ld hl, wBGPaletteBuffer
    call UploadBGPaletteByDMGShades

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, $88
    ldh [rBGPI], a
    call UploadBGPaletteByDMGShades

.loop3:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop3
    ld a, $90
    ldh [rBGPI], a
    call UploadBGPaletteByDMGShades

.loop4:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop4
    ld a, $98
    ldh [rBGPI], a
    call UploadBGPaletteByDMGShades

.loop5:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop5
    ld a, $a0
    ldh [rBGPI], a
    call UploadBGPaletteByDMGShades

.loop6:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop6
    ld a, $a8
    ldh [rBGPI], a
    call UploadBGPaletteByDMGShades

.loop7:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop7
    ld a, $b0
    ldh [rBGPI], a
    call UploadBGPaletteByDMGShades

.loop8:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop8
    ld a, $b8
    ldh [rBGPI], a
    call UploadBGPaletteByDMGShades
    ld a, [wDMGPaletteBGP]
    ld [wDMGPaletteBytes], a
    jp UploadBGPalettesWithFade_OBJPalettes

; Writes one background palette to port C with its four colours picked by the DMG BGP shades
; (UploadBGPaletteByDMGShades_Data), waiting for VRAM access before each colour. (C1, E-0357)
UploadBGPaletteByDMGShades::
    push hl
    ld a, [wDMGPaletteBGP]
    and $03
    ld de, UploadBGPaletteByDMGShades_Data
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    add l
    ld l, a
    jr nc, .loop
    inc h

.loop:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop
    ld a, [hli]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [wDMGPaletteBGP]
    srl a
    srl a
    and $03
    ld de, UploadBGPaletteByDMGShades_Data
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    add l
    ld l, a
    jr nc, .loop2
    inc h

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [hli]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [wDMGPaletteBGP]
    swap a
    and $03
    ld de, UploadBGPaletteByDMGShades_Data
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [de]
    add l
    ld l, a
    jr nc, .loop3
    inc h

.loop3:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop3
    ld a, [hli]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [wDMGPaletteBGP]
    swap a
    srl a
    srl a
    and $03
    ld de, UploadBGPaletteByDMGShades_Data
    add e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    ld a, [de]
    add l
    ld l, a
    jr nc, .loop4
    inc h

.loop4:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop4
    ld a, [hli]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    ld a, l
    add $08
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ret

; When wDMGPaletteOBP0 has changed, writes the eight object palettes the same way by its shades and
; remembers it. (C1, E-0357)
UploadBGPalettesWithFade_OBJPalettes::
    ld hl, wDMGPaletteBytes + $1
    ld a, [wDMGPaletteOBP0]
    cp [hl]
    jp z, UploadPalettes_Return
    ld c, $6b

.loop:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop
    ld a, $80
    ldh [rOBPI], a
    ld hl, wOBJPaletteBuffer
    call UploadOBJPaletteByDMGShades

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, $88
    ldh [rOBPI], a
    call UploadOBJPaletteByDMGShades

.loop3:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop3
    ld a, $90
    ldh [rOBPI], a
    call UploadOBJPaletteByDMGShades

.loop4:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop4
    ld a, $98
    ldh [rOBPI], a
    call UploadOBJPaletteByDMGShades

.loop5:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop5
    ld a, $a0
    ldh [rOBPI], a
    call UploadOBJPaletteByDMGShades

.loop6:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop6
    ld a, $a8
    ldh [rOBPI], a
    call UploadOBJPaletteByDMGShades

.loop7:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop7
    ld a, $b0
    ldh [rOBPI], a
    call UploadOBJPaletteByDMGShades

.loop8:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop8
    ld a, $b8
    ldh [rOBPI], a
    call UploadOBJPaletteByDMGShades
    ld a, [wDMGPaletteOBP0]
    ld [wDMGPaletteBytes + $1], a
    jp UploadPalettes_Return

; Writes one object palette to port C with its four colours picked by the OBP0 shades. (C1, E-0357)
UploadOBJPaletteByDMGShades::
    push hl
    ld a, [wDMGPaletteOBP0]
    and $03
    ld de, UploadBGPaletteByDMGShades_Data
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    add l
    ld l, a
    jr nc, .loop
    inc h

.loop:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop
    ld a, [hli]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [wDMGPaletteOBP0]
    srl a
    srl a
    and $03
    ld de, UploadBGPaletteByDMGShades_Data
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    add l
    ld l, a
    jr nc, .loop2
    inc h

.loop2:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop2
    ld a, [hli]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [wDMGPaletteOBP0]
    swap a
    and $03
    ld de, UploadBGPaletteByDMGShades_Data
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [de]
    add l
    ld l, a
    jr nc, .loop3
    inc h

.loop3:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop3
    ld a, [hli]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    push hl
    ld a, [wDMGPaletteOBP0]
    swap a
    srl a
    srl a
    and $03
    ld de, UploadBGPaletteByDMGShades_Data
    add e
    ld e, a
    jr nc, .skip4
    inc d

.skip4:
    ld a, [de]
    add l
    ld l, a
    jr nc, .loop4
    inc h

.loop4:
    ldh a, [rSTAT]
    bit 1, a
    jr nz, .loop4
    ld a, [hli]
    ldh [c], a
    ld a, [hl]
    ldh [c], a
    pop hl
    ld a, l
    add $08
    ld l, a
    ld a, h
    adc $00
    ld h, a
    ret

; A bare ret, the shared exit. (C2, E-0357; probed E-0382)
UploadPalettes_Return::
    ret

; Four byte offsets, $02, $04, $00 and $06: for a DMG shade 0 to 3 the offset of the matching colour
; (2 bytes each) inside a 4-colour CGB palette. UploadBGPaletteByDMGShades and
; UploadOBJPaletteByDMGShades read the four 2-bit shades of wDMGPaletteBGP or wDMGPaletteOBP0 in
; turn, add the offset for each shade to the palette address in HL and write those 2 bytes to the
; palette data port in C. (C1, E-0381)
UploadBGPaletteByDMGShades_Data::
    db $02, $04, $00, $06

; Plays the action's sound from wEffectFlags2: the first set bit of 7, 6, 5, 3, 2 or 0 picks
; ActionSoundTable_Flag7/6/5A-5B/3/2/0 (bits 2 and 0 make the target the actor; bit 5 only when
; SelectEffectByEffectFlags2Flags_SacrificeSound gives Z, 5A with bit 4); the entry for
; wBattleActionId by the actor's side; $FF plays nothing, otherwise QueueSoundEffect. (C2, E-0357;
; probed E-0382)
SelectEffectByEffectFlags2Flags::
    ld a, [wEffectFlags2]
    or a
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
    call SelectEffectByEffectFlags2Flags_SacrificeSound
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
    cp $ff
    ret z
    call QueueSoundEffect
    ret

; A = wEffectFlags2. Without bit 4 returns at once with Z set. With bit 4 it is the Sacrifice check
; of SelectEffectByEffectFlags2Flags: for SKILL_SACRIFICE or ACTION_D6 it queues sound $81 and
; returns the flags of the last subtraction of 1000 from the damage word (wBattleDamageLo,
; wBattleDamageHi): carry set below 1000, and Z set only for damage 1000-1255, because only the high
; byte is tested. The caller returns when Z is clear, so after the $81 sound only damage of
; 1000-1255 goes on to ActionSoundTable_Flag5A. For SKILL_FAREWELL and SKILL_LIFEDANCE it returns A
; = wResolveMsgFlags with Z set when bit 6 is clear. For any other action it returns A = 0 with Z
; set. (C2, E-0382)
SelectEffectByEffectFlags2Flags_SacrificeSound::
    bit 4, a
    ret z
    ld a, [wBattleActionId]
    cp SKILL_SACRIFICE
    jr z, .skip
    cp SKILL_FAREWELL
    jr z, .check_resolve_msg_flags
    cp SKILL_LIFEDANCE
    jr z, .check_resolve_msg_flags
    cp ACTION_D6
    jr z, .skip
    xor a
    ret

.skip:
    ld hl, wBattleDamageLo
    ld a, [hli]
    sub $e8
    ld a, [hl]
    sbc $03
    ld a, $81
    call QueueSoundEffect
    ret

.check_resolve_msg_flags:
    ld a, [wResolveMsgFlags]
    bit 6, a
    ret

; SelectEffectByEffectFlags2Flags uses this table for wEffectFlags2 bit 7, indexed by
; wBattleActionId: byte 1 for a near-side actor (ActorOnLocalSide_Bank3A), else byte 0; a value
; other than $FF goes to QueueSoundEffect; 228 entries, up to the next table (E-0210, C1)
; record: sound effect for a far-side actor, for a near-side actor ($FF = none)
ActionSoundTable_Flag7::
    db $80, $7c ; id 0
    db $7a, $7a ; id 1
    db $7a, $7a ; id 2
    db $7a, $7a ; id 3
    db $7a, $7a ; id 4
    db $7a, $7a ; id 5
    db $7a, $7a ; id 6
    db $7a, $7a ; id 7
    db $7a, $7a ; id 8
    db $7a, $7a ; id 9
    db $7a, $7a ; id 10
    db $7a, $7a ; id 11
    db $7a, $7a ; id 12
    db $7a, $7a ; id 13
    db $7a, $7a ; id 14
    db $7a, $7a ; id 15
    db $7a, $7a ; id 16
    db $7a, $7a ; id 17
    db $7a, $7a ; id 18
    db $7a, $7a ; id 19
    db $7a, $7a ; id 20
    db $7a, $7a ; id 21
    db $7a, $7a ; id 22
    db $7a, $7a ; id 23
    db $7a, $7a ; id 24
    db $7a, $7a ; id 25
    db $7a, $7a ; id 26
    db $7a, $7a ; id 27
    db $7a, $7a ; id 28
    db $7a, $7a ; id 29
    db $7a, $7a ; id 30
    db $7a, $7a ; id 31
    db $7a, $7a ; id 32
    db $7a, $7a ; id 33
    db $7a, $7a ; id 34
    db $7a, $7a ; id 35
    db $7a, $7a ; id 36
    db $7a, $7a ; id 37
    db $7a, $7a ; id 38
    db $7a, $7a ; id 39
    db $7a, $7a ; id 40
    db $7a, $7a ; id 41
    db $7a, $7a ; id 42
    db $7a, $7a ; id 43
    db $7a, $7a ; id 44
    db $7a, $7a ; id 45
    db $7a, $7a ; id 46
    db $7a, $7a ; id 47
    db $7a, $7a ; id 48
    db $7a, $7a ; id 49
    db $7a, $7a ; id 50
    db $7a, $7a ; id 51
    db $7a, $7a ; id 52
    db $7a, $7a ; id 53
    db $7a, $7a ; id 54
    db $7a, $7a ; id 55
    db $7a, $7a ; id 56
    db $7a, $7a ; id 57
    db $7a, $7a ; id 58
    db $7a, $7a ; id 59
    db $7a, $7a ; id 60
    db $80, $7c ; id 61
    db $80, $7c ; id 62
    db $80, $7c ; id 63
    db $80, $7c ; id 64
    db $80, $7c ; id 65
    db $80, $7c ; id 66
    db $80, $7c ; id 67
    db $80, $7c ; id 68
    db $80, $7c ; id 69
    db $80, $7c ; id 70
    db $80, $7c ; id 71
    db $80, $7c ; id 72
    db $80, $7c ; id 73
    db $80, $7c ; id 74
    db $80, $7c ; id 75
    db $80, $7c ; id 76
    db $80, $7c ; id 77
    db $80, $7c ; id 78
    db $80, $7c ; id 79
    db $80, $7c ; id 80
    db $80, $7c ; id 81
    db $80, $7c ; id 82
    db $80, $7c ; id 83
    db $80, $7c ; id 84
    db $80, $7c ; id 85
    db $80, $7c ; id 86
    db $80, $7c ; id 87
    db $80, $7c ; id 88
    db $80, $7c ; id 89
    db $80, $7c ; id 90
    db $80, $7c ; id 91
    db $80, $7c ; id 92
    db $80, $7c ; id 93
    db $80, $7c ; id 94
    db $80, $7c ; id 95
    db $80, $7c ; id 96
    db $80, $7c ; id 97
    db $80, $7c ; id 98
    db $80, $7c ; id 99
    db $80, $7c ; id 100
    db $80, $7c ; id 101
    db $80, $7c ; id 102
    db $80, $7c ; id 103
    db $ff, $ff ; id 104
    db $80, $7c ; id 105
    db $80, $7c ; id 106
    db $80, $7c ; id 107
    db $80, $7c ; id 108
    db $80, $7c ; id 109
    db $80, $7c ; id 110
    db $80, $7c ; id 111
    db $80, $7c ; id 112
    db $80, $7c ; id 113
    db $80, $7c ; id 114
    db $80, $7c ; id 115
    db $80, $7c ; id 116
    db $80, $7c ; id 117
    db $80, $7c ; id 118
    db $80, $7c ; id 119
    db $80, $7c ; id 120
    db $80, $7c ; id 121
    db $80, $7c ; id 122
    db $80, $7c ; id 123
    db $80, $7c ; id 124
    db $80, $7c ; id 125
    db $80, $7c ; id 126
    db $ff, $ff ; id 127
    db $ff, $ff ; id 128
    db $ff, $ff ; id 129
    db $ff, $ff ; id 130
    db $ff, $ff ; id 131
    db $ff, $ff ; id 132
    db $7a, $7a ; id 133
    db $7a, $7a ; id 134
    db $7a, $7a ; id 135
    db $7a, $7a ; id 136
    db $ff, $ff ; id 137
    db $ff, $ff ; id 138
    db $80, $7c ; id 139
    db $80, $7c ; id 140
    db $80, $7c ; id 141
    db $80, $7c ; id 142
    db $7c, $7c ; id 143
    db $ff, $ff ; id 144
    db $7a, $7a ; id 145
    db $80, $7c ; id 146
    db $80, $7c ; id 147
    db $ff, $ff ; id 148
    db $ff, $ff ; id 149
    db $ff, $ff ; id 150
    db $ff, $ff ; id 151
    db $ff, $ff ; id 152
    db $ff, $ff ; id 153
    db $ff, $ff ; id 154
    db $7a, $7a ; id 155
    db $ff, $ff ; id 156
    db $ff, $ff ; id 157
    db $ff, $ff ; id 158
    db $ff, $ff ; id 159
    db $ff, $ff ; id 160
    db $ff, $ff ; id 161
    db $ff, $ff ; id 162
    db $ff, $ff ; id 163
    db $ff, $ff ; id 164
    db $ff, $ff ; id 165
    db $ff, $ff ; id 166
    db $ff, $ff ; id 167
    db $ff, $ff ; id 168
    db $ff, $ff ; id 169
    db $80, $7c ; id 170
    db $ff, $ff ; id 171
    db $ff, $ff ; id 172
    db $7a, $ff ; id 173
    db $7a, $ff ; id 174
    db $ff, $ff ; id 175
    db $ff, $ff ; id 176
    db $ff, $ff ; id 177
    db $ff, $ff ; id 178
    db $ff, $ff ; id 179
    db $ff, $ff ; id 180
    db $ff, $ff ; id 181
    db $ff, $ff ; id 182
    db $ff, $ff ; id 183
    db $ff, $ff ; id 184
    db $80, $7c ; id 185
    db $ff, $ff ; id 186
    db $ff, $ff ; id 187
    db $ff, $ff ; id 188
    db $ff, $ff ; id 189
    db $ff, $ff ; id 190
    db $ff, $ff ; id 191
    db $80, $7c ; id 192
    db $80, $7c ; id 193
    db $80, $7c ; id 194
    db $ff, $ff ; id 195
    db $ff, $ff ; id 196
    db $ff, $ff ; id 197
    db $ff, $ff ; id 198
    db $ff, $ff ; id 199
    db $ff, $ff ; id 200
    db $65, $65 ; id 201
    db $65, $65 ; id 202
    db $65, $65 ; id 203
    db $65, $65 ; id 204
    db $65, $65 ; id 205
    db $ff, $ff ; id 206
    db $ff, $ff ; id 207
    db $7a, $7a ; id 208
    db $7a, $7a ; id 209
    db $80, $7c ; id 210
    db $80, $7c ; id 211
    db $80, $7c ; id 212
    db $80, $7c ; id 213
    db $7a, $7a ; id 214
    db $80, $7c ; id 215
    db $80, $7c ; id 216
    db $7a, $7a ; id 217
    db $ff, $ff ; id 218
    db $ff, $ff ; id 219
    db $7a, $7a ; id 220
    db $ff, $ff ; id 221
    db $ff, $ff ; id 222
    db $7a, $7a ; id 223
    db $ff, $ff ; id 224
    db $ff, $ff ; id 225
    db $ff, $ff ; id 226
    db $ff, $ff ; id 227

; SelectEffectByEffectFlags2Flags uses this table for wEffectFlags2 bit 6, indexed by
; wBattleActionId: byte 1 for a near-side actor (ActorOnLocalSide_Bank3A), else byte 0; a value
; other than $FF goes to QueueSoundEffect; 228 entries, up to the next table (E-0210, C1)
ActionSoundTable_Flag6::
    db $ff, $ff ; id 0
    db $ff, $89 ; id 1
    db $ff, $8b ; id 2
    db $ff, $8b ; id 3
    db $ff, $8d ; id 4
    db $ff, $8d ; id 5
    db $ff, $8f ; id 6
    db $ff, $90 ; id 7
    db $ff, $d9 ; id 8
    db $ff, $91 ; id 9
    db $ff, $93 ; id 10
    db $ff, $93 ; id 11
    db $ff, $94 ; id 12
    db $ff, $97 ; id 13
    db $ff, $97 ; id 14
    db $ff, $98 ; id 15
    db $ff, $95 ; id 16
    db $ff, $95 ; id 17
    db $ff, $96 ; id 18
    db $ff, $ff ; id 19
    db $ff, $ff ; id 20
    db $ff, $ff ; id 21
    db $ff, $ff ; id 22
    db $ff, $ff ; id 23
    db $ff, $ff ; id 24
    db $ff, $ff ; id 25
    db $ff, $ff ; id 26
    db $ff, $ff ; id 27
    db $ff, $ff ; id 28
    db $ff, $ff ; id 29
    db $ff, $ff ; id 30
    db $ff, $ff ; id 31
    db $ff, $ff ; id 32
    db $ff, $ff ; id 33
    db $ff, $ff ; id 34
    db $ff, $ff ; id 35
    db $ff, $ff ; id 36
    db $ff, $ff ; id 37
    db $ff, $ff ; id 38
    db $ff, $ff ; id 39
    db $ff, $ff ; id 40
    db $ff, $ff ; id 41
    db $ff, $ff ; id 42
    db $ff, $ff ; id 43
    db $ff, $ff ; id 44
    db $ff, $ff ; id 45
    db $ff, $ff ; id 46
    db $ff, $ff ; id 47
    db $ff, $ff ; id 48
    db $ff, $ff ; id 49
    db $ff, $ff ; id 50
    db $ff, $ff ; id 51
    db $ff, $ff ; id 52
    db $ff, $ff ; id 53
    db $ff, $ff ; id 54
    db $ff, $ff ; id 55
    db $ff, $ff ; id 56
    db $ff, $ff ; id 57
    db $ff, $ff ; id 58
    db $ff, $ff ; id 59
    db $ff, $ff ; id 60
    db $ff, $ae ; id 61
    db $ff, $ac ; id 62
    db $ff, $ab ; id 63
    db $ff, $8d ; id 64
    db $ff, $8d ; id 65
    db $ff, $8f ; id 66
    db $ff, $9f ; id 67
    db $ff, $95 ; id 68
    db $ff, $95 ; id 69
    db $ff, $96 ; id 70
    db $ff, $9d ; id 71
    db $ff, $93 ; id 72
    db $ff, $94 ; id 73
    db $ff, $97 ; id 74
    db $ff, $9e ; id 75
    db $ff, $b2 ; id 76
    db $ff, $b4 ; id 77
    db $ff, $ff ; id 78
    db $ff, $ff ; id 79
    db $ff, $a2 ; id 80
    db $ff, $a4 ; id 81
    db $ff, $a3 ; id 82
    db $ff, $a5 ; id 83
    db $ff, $a7 ; id 84
    db $ff, $99 ; id 85
    db $ff, $99 ; id 86
    db $ff, $a8 ; id 87
    db $ff, $a7 ; id 88
    db $ff, $99 ; id 89
    db $ff, $da ; id 90
    db $ff, $da ; id 91
    db $ff, $99 ; id 92
    db $ff, $b8 ; id 93
    db $ff, $99 ; id 94
    db $ff, $ff ; id 95
    db $ff, $ff ; id 96
    db $ff, $ff ; id 97
    db $ff, $99 ; id 98
    db $ff, $ff ; id 99
    db $ff, $ff ; id 100
    db $ff, $99 ; id 101
    db $ff, $aa ; id 102
    db $ff, $a9 ; id 103
    db $ff, $ff ; id 104
    db $ff, $ff ; id 105
    db $ff, $ff ; id 106
    db $ff, $99 ; id 107
    db $ff, $99 ; id 108
    db $ff, $99 ; id 109
    db $ff, $ff ; id 110
    db $ff, $ff ; id 111
    db $ff, $ff ; id 112
    db $ff, $ff ; id 113
    db $ff, $ff ; id 114
    db $ff, $ff ; id 115
    db $ff, $ff ; id 116
    db $ff, $ff ; id 117
    db $ff, $ff ; id 118
    db $ff, $ff ; id 119
    db $ff, $ff ; id 120
    db $ff, $ff ; id 121
    db $ff, $ff ; id 122
    db $ff, $ff ; id 123
    db $ff, $ff ; id 124
    db $ff, $ff ; id 125
    db $ff, $ff ; id 126
    db $ff, $ff ; id 127
    db $ff, $ff ; id 128
    db $ff, $ff ; id 129
    db $ff, $ff ; id 130
    db $b0, $b0 ; id 131
    db $ff, $ff ; id 132
    db $ff, $ff ; id 133
    db $ff, $ff ; id 134
    db $ff, $ff ; id 135
    db $ff, $ff ; id 136
    db $ff, $ff ; id 137
    db $ff, $ff ; id 138
    db $ff, $ff ; id 139
    db $ff, $ff ; id 140
    db $ff, $ff ; id 141
    db $ff, $ff ; id 142
    db $ff, $ff ; id 143
    db $ff, $ff ; id 144
    db $ff, $b6 ; id 145
    db $ff, $ff ; id 146
    db $ff, $ff ; id 147
    db $ff, $ff ; id 148
    db $ff, $ff ; id 149
    db $ff, $ff ; id 150
    db $ff, $ff ; id 151
    db $ff, $ff ; id 152
    db $ff, $ff ; id 153
    db $ff, $ff ; id 154
    db $dc, $ff ; id 155
    db $ff, $ff ; id 156
    db $ff, $ff ; id 157
    db $ff, $ff ; id 158
    db $ff, $ff ; id 159
    db $ff, $ff ; id 160
    db $ba, $ff ; id 161
    db $ff, $ff ; id 162
    db $ff, $ff ; id 163
    db $ff, $ff ; id 164
    db $ff, $ff ; id 165
    db $ff, $ff ; id 166
    db $ff, $ff ; id 167
    db $ff, $ff ; id 168
    db $ff, $ff ; id 169
    db $ff, $ff ; id 170
    db $ff, $ff ; id 171
    db $ff, $ff ; id 172
    db $ff, $ff ; id 173
    db $ff, $ff ; id 174
    db $ff, $ff ; id 175
    db $ff, $ff ; id 176
    db $ff, $ff ; id 177
    db $ff, $ff ; id 178
    db $ff, $ff ; id 179
    db $ff, $ff ; id 180
    db $ff, $ff ; id 181
    db $ff, $ff ; id 182
    db $ff, $ff ; id 183
    db $ff, $ff ; id 184
    db $ff, $ff ; id 185
    db $ff, $ff ; id 186
    db $ff, $ff ; id 187
    db $ff, $ff ; id 188
    db $ff, $ff ; id 189
    db $ff, $ff ; id 190
    db $ff, $ff ; id 191
    db $ff, $ff ; id 192
    db $ff, $ff ; id 193
    db $ff, $ff ; id 194
    db $ff, $ff ; id 195
    db $ff, $ff ; id 196
    db $ff, $ff ; id 197
    db $ff, $ff ; id 198
    db $ff, $ff ; id 199
    db $ff, $ff ; id 200
    db $ff, $ff ; id 201
    db $ff, $ff ; id 202
    db $ff, $ff ; id 203
    db $ff, $ff ; id 204
    db $ff, $ff ; id 205
    db $ff, $ff ; id 206
    db $ff, $ff ; id 207
    db $ff, $bc ; id 208
    db $ff, $bd ; id 209
    db $ff, $bf ; id 210
    db $ff, $c1 ; id 211
    db $ff, $c3 ; id 212
    db $ff, $c5 ; id 213
    db $ff, $ff ; id 214
    db $ff, $99 ; id 215
    db $ff, $99 ; id 216
    db $ff, $c7 ; id 217
    db $ff, $ff ; id 218
    db $ff, $ff ; id 219
    db $ff, $ff ; id 220
    db $ff, $ff ; id 221
    db $ff, $ff ; id 222
    db $ff, $ff ; id 223
    db $ff, $ff ; id 224
    db $ff, $ff ; id 225
    db $ff, $ff ; id 226
    db $cb, $ff ; id 227

; SelectEffectByEffectFlags2Flags uses this table for wEffectFlags2 bit 5 with bit 4 (after
; SelectEffectByEffectFlags2Flags_SacrificeSound), indexed by wBattleActionId: byte 1 for a
; near-side actor (ActorOnLocalSide_Bank3A), else byte 0; a value other than $FF goes to
; QueueSoundEffect; 228 entries, up to the next table (E-0210, C1)
ActionSoundTable_Flag5A::
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
    db $b1, $b1 ; id 19
    db $b1, $b1 ; id 20
    db $b1, $b1 ; id 21
    db $85, $85 ; id 22
    db $85, $85 ; id 23
    db $85, $85 ; id 24
    db $85, $85 ; id 25
    db $85, $85 ; id 26
    db $85, $85 ; id 27
    db $85, $85 ; id 28
    db $85, $85 ; id 29
    db $ff, $ff ; id 30
    db $ff, $ff ; id 31
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
    db $86, $ff ; id 49
    db $86, $87 ; id 50
    db $87, $87 ; id 51
    db $ff, $88 ; id 52
    db $ff, $ff ; id 53
    db $9b, $9b ; id 54
    db $9b, $9b ; id 55
    db $ff, $ff ; id 56
    db $ff, $ff ; id 57
    db $9a, $9a ; id 58
    db $9a, $9a ; id 59
    db $ff, $ff ; id 60
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
    db $ff, $ff ; id 104
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
    db $b1, $b1 ; id 121
    db $88, $88 ; id 122
    db $85, $85 ; id 123
    db $85, $85 ; id 124
    db $ff, $ff ; id 125
    db $88, $99 ; id 126
    db $81, $81 ; id 127
    db $ff, $ff ; id 128
    db $85, $85 ; id 129
    db $87, $87 ; id 130
    db $ff, $ff ; id 131
    db $ff, $ff ; id 132
    db $ff, $ff ; id 133
    db $ff, $ff ; id 134
    db $ff, $ff ; id 135
    db $ff, $ff ; id 136
    db $ff, $ff ; id 137
    db $ff, $ff ; id 138
    db $88, $88 ; id 139
    db $88, $88 ; id 140
    db $81, $81 ; id 141
    db $81, $81 ; id 142
    db $88, $88 ; id 143
    db $81, $81 ; id 144
    db $7a, $7a ; id 145
    db $87, $87 ; id 146
    db $87, $87 ; id 147
    db $ff, $ff ; id 148
    db $ff, $ff ; id 149
    db $ff, $ff ; id 150
    db $ff, $ff ; id 151
    db $ff, $ff ; id 152
    db $ff, $ff ; id 153
    db $ff, $ff ; id 154
    db $9b, $9b ; id 155
    db $85, $85 ; id 156
    db $ff, $ff ; id 157
    db $ff, $ff ; id 158
    db $85, $85 ; id 159
    db $ff, $ff ; id 160
    db $ff, $ff ; id 161
    db $ff, $ff ; id 162
    db $ff, $ff ; id 163
    db $ff, $ff ; id 164
    db $ff, $ff ; id 165
    db $ff, $ff ; id 166
    db $ff, $ff ; id 167
    db $ff, $ff ; id 168
    db $ff, $ff ; id 169
    db $81, $81 ; id 170
    db $ff, $ff ; id 171
    db $ff, $ff ; id 172
    db $87, $87 ; id 173
    db $ff, $ff ; id 174
    db $ff, $ff ; id 175
    db $82, $82 ; id 176
    db $85, $85 ; id 177
    db $7a, $7a ; id 178
    db $ff, $ff ; id 179
    db $86, $86 ; id 180
    db $88, $88 ; id 181
    db $87, $87 ; id 182
    db $ff, $ff ; id 183
    db $9a, $9a ; id 184
    db $81, $81 ; id 185
    db $ff, $ff ; id 186
    db $ff, $ff ; id 187
    db $85, $85 ; id 188
    db $81, $81 ; id 189
    db $ff, $ff ; id 190
    db $ff, $ff ; id 191
    db $81, $81 ; id 192
    db $81, $81 ; id 193
    db $81, $81 ; id 194
    db $ff, $ff ; id 195
    db $ff, $ff ; id 196
    db $ff, $ff ; id 197
    db $ff, $ff ; id 198
    db $ff, $ff ; id 199
    db $ff, $ff ; id 200
    db $81, $81 ; id 201
    db $81, $81 ; id 202
    db $81, $81 ; id 203
    db $81, $81 ; id 204
    db $81, $81 ; id 205
    db $ff, $ff ; id 206
    db $ff, $ff ; id 207
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
    db $ff, $ff ; id 219
    db $9a, $9a ; id 220
    db $86, $86 ; id 221
    db $ff, $ff ; id 222
    db $86, $87 ; id 223
    db $ff, $ff ; id 224
    db $88, $88 ; id 225
    db $ff, $ff ; id 226
    db $ff, $ff ; id 227

; SelectEffectByEffectFlags2Flags uses this table for wEffectFlags2 bit 5 without bit 4, indexed by
; wBattleActionId: byte 1 for a near-side actor (ActorOnLocalSide_Bank3A), else byte 0; a value
; other than $FF goes to QueueSoundEffect; 228 entries, up to the next table (E-0210, C1)
ActionSoundTable_Flag5B::
    db $84, $84 ; id 0
    db $ff, $ff ; id 1
    db $ff, $ff ; id 2
    db $ff, $ff ; id 3
    db $ff, $ff ; id 4
    db $ff, $ff ; id 5
    db $ff, $ff ; id 6
    db $ff, $ff ; id 7
    db $ff, $ff ; id 8
    db $ff, $ff ; id 9
    db $ff, $ff ; id 10
    db $ff, $ff ; id 11
    db $ff, $ff ; id 12
    db $ff, $ff ; id 13
    db $ff, $ff ; id 14
    db $ff, $ff ; id 15
    db $ff, $ff ; id 16
    db $ff, $ff ; id 17
    db $ff, $ff ; id 18
    db $ff, $ff ; id 19
    db $ff, $ff ; id 20
    db $ff, $ff ; id 21
    db $ff, $ff ; id 22
    db $ff, $ff ; id 23
    db $ff, $ff ; id 24
    db $ff, $ff ; id 25
    db $ff, $ff ; id 26
    db $ff, $ff ; id 27
    db $ff, $ff ; id 28
    db $ff, $ff ; id 29
    db $ff, $ff ; id 30
    db $ff, $ff ; id 31
    db $ff, $ff ; id 32
    db $ff, $ff ; id 33
    db $ff, $ff ; id 34
    db $ff, $ff ; id 35
    db $ff, $ff ; id 36
    db $ff, $ff ; id 37
    db $ff, $ff ; id 38
    db $ff, $ff ; id 39
    db $ff, $ff ; id 40
    db $ff, $ff ; id 41
    db $ff, $ff ; id 42
    db $ff, $ff ; id 43
    db $ff, $ff ; id 44
    db $ff, $ff ; id 45
    db $ff, $ff ; id 46
    db $ff, $ff ; id 47
    db $ff, $ff ; id 48
    db $ff, $ff ; id 49
    db $ff, $ff ; id 50
    db $ff, $ff ; id 51
    db $ff, $ff ; id 52
    db $ff, $ff ; id 53
    db $ff, $ff ; id 54
    db $ff, $ff ; id 55
    db $ff, $ff ; id 56
    db $ff, $ff ; id 57
    db $ff, $ff ; id 58
    db $ff, $ff ; id 59
    db $ff, $ff ; id 60
    db $ff, $ff ; id 61
    db $ff, $ff ; id 62
    db $ff, $ff ; id 63
    db $ff, $ff ; id 64
    db $ff, $ff ; id 65
    db $ff, $ff ; id 66
    db $ff, $ff ; id 67
    db $ff, $ff ; id 68
    db $ff, $ff ; id 69
    db $ff, $ff ; id 70
    db $ff, $ff ; id 71
    db $ff, $ff ; id 72
    db $ff, $ff ; id 73
    db $ff, $ff ; id 74
    db $ff, $ff ; id 75
    db $ff, $ff ; id 76
    db $ff, $ff ; id 77
    db $ff, $ff ; id 78
    db $ff, $ff ; id 79
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
    db $ff, $ff ; id 104
    db $84, $84 ; id 105
    db $84, $84 ; id 106
    db $84, $84 ; id 107
    db $84, $84 ; id 108
    db $84, $84 ; id 109
    db $84, $84 ; id 110
    db $84, $84 ; id 111
    db $84, $84 ; id 112
    db $ff, $ff ; id 113
    db $ff, $ff ; id 114
    db $ff, $ff ; id 115
    db $ff, $ff ; id 116
    db $ff, $ff ; id 117
    db $ff, $ff ; id 118
    db $ff, $ff ; id 119
    db $ff, $ff ; id 120
    db $ff, $ff ; id 121
    db $ff, $ff ; id 122
    db $ff, $ff ; id 123
    db $ff, $ff ; id 124
    db $ff, $ff ; id 125
    db $ff, $ff ; id 126
    db $ff, $ff ; id 127
    db $ff, $ff ; id 128
    db $ff, $ff ; id 129
    db $ff, $ff ; id 130
    db $ff, $ff ; id 131
    db $ff, $ff ; id 132
    db $ff, $ff ; id 133
    db $ff, $ff ; id 134
    db $ff, $ff ; id 135
    db $ff, $ff ; id 136
    db $ff, $ff ; id 137
    db $ff, $ff ; id 138
    db $ff, $ff ; id 139
    db $ff, $ff ; id 140
    db $ff, $ff ; id 141
    db $ff, $ff ; id 142
    db $ff, $ff ; id 143
    db $ff, $ff ; id 144
    db $ff, $ff ; id 145
    db $ff, $ff ; id 146
    db $ff, $ff ; id 147
    db $ff, $ff ; id 148
    db $ff, $ff ; id 149
    db $ff, $ff ; id 150
    db $ff, $ff ; id 151
    db $ff, $ff ; id 152
    db $ff, $ff ; id 153
    db $ff, $ff ; id 154
    db $ff, $ff ; id 155
    db $ff, $ff ; id 156
    db $ff, $ff ; id 157
    db $ff, $ff ; id 158
    db $ff, $ff ; id 159
    db $ff, $ff ; id 160
    db $ff, $ff ; id 161
    db $ff, $ff ; id 162
    db $ff, $ff ; id 163
    db $ff, $ff ; id 164
    db $ff, $ff ; id 165
    db $ff, $ff ; id 166
    db $ff, $ff ; id 167
    db $ff, $ff ; id 168
    db $ff, $ff ; id 169
    db $84, $84 ; id 170
    db $ff, $ff ; id 171
    db $ff, $ff ; id 172
    db $ff, $ff ; id 173
    db $ff, $ff ; id 174
    db $ff, $ff ; id 175
    db $ff, $ff ; id 176
    db $ff, $ff ; id 177
    db $ff, $ff ; id 178
    db $ff, $ff ; id 179
    db $ff, $ff ; id 180
    db $ff, $ff ; id 181
    db $ff, $ff ; id 182
    db $ff, $ff ; id 183
    db $ff, $ff ; id 184
    db $84, $84 ; id 185
    db $ff, $ff ; id 186
    db $ff, $ff ; id 187
    db $ff, $ff ; id 188
    db $ff, $ff ; id 189
    db $ff, $ff ; id 190
    db $ff, $ff ; id 191
    db $84, $84 ; id 192
    db $84, $84 ; id 193
    db $84, $84 ; id 194
    db $ff, $ff ; id 195
    db $ff, $ff ; id 196
    db $ff, $ff ; id 197
    db $ff, $ff ; id 198
    db $ff, $ff ; id 199
    db $82, $82 ; id 200
    db $ff, $ff ; id 201
    db $ff, $ff ; id 202
    db $ff, $ff ; id 203
    db $84, $84 ; id 204
    db $ff, $ff ; id 205
    db $ff, $ff ; id 206
    db $ff, $ff ; id 207
    db $ff, $ff ; id 208
    db $ff, $ff ; id 209
    db $84, $84 ; id 210
    db $84, $84 ; id 211
    db $84, $84 ; id 212
    db $84, $84 ; id 213
    db $ff, $ff ; id 214
    db $84, $84 ; id 215
    db $84, $84 ; id 216
    db $ff, $ff ; id 217
    db $ff, $ff ; id 218
    db $ff, $ff ; id 219
    db $ff, $ff ; id 220
    db $ff, $ff ; id 221
    db $ff, $ff ; id 222
    db $ff, $ff ; id 223
    db $ff, $ff ; id 224
    db $ff, $ff ; id 225
    db $ff, $ff ; id 226
    db $ff, $ff ; id 227

; SelectEffectByEffectFlags2Flags uses this table for wEffectFlags2 bit 3, indexed by
; wBattleActionId: byte 1 for a near-side actor (ActorOnLocalSide_Bank3A), else byte 0; a value
; other than $FF goes to QueueSoundEffect; 208 entries, up to the next table (E-0210, C1)
; record: sound effect for a far-side actor, for a near-side actor ($FF = none)
ActionSoundTable_Flag3::
    db $ff, $ff ; id 0
    db $ff, $ff ; id 1
    db $ff, $ff ; id 2
    db $ff, $ff ; id 3
    db $ff, $ff ; id 4
    db $ff, $ff ; id 5
    db $ff, $ff ; id 6
    db $ff, $ff ; id 7
    db $ff, $ff ; id 8
    db $ff, $ff ; id 9
    db $ff, $ff ; id 10
    db $ff, $ff ; id 11
    db $ff, $ff ; id 12
    db $ff, $ff ; id 13
    db $ff, $ff ; id 14
    db $ff, $ff ; id 15
    db $ff, $ff ; id 16
    db $ff, $ff ; id 17
    db $ff, $ff ; id 18
    db $ff, $ff ; id 19
    db $ff, $ff ; id 20
    db $ff, $ff ; id 21
    db $ff, $ff ; id 22
    db $ff, $ff ; id 23
    db $ff, $ff ; id 24
    db $ff, $ff ; id 25
    db $ff, $ff ; id 26
    db $ff, $ff ; id 27
    db $ff, $ff ; id 28
    db $ff, $ff ; id 29
    db $ff, $ff ; id 30
    db $ff, $ff ; id 31
    db $ff, $ff ; id 32
    db $ff, $ff ; id 33
    db $ff, $ff ; id 34
    db $ff, $ff ; id 35
    db $ff, $ff ; id 36
    db $ff, $ff ; id 37
    db $ff, $ff ; id 38
    db $ff, $ff ; id 39
    db $ff, $ff ; id 40
    db $ff, $ff ; id 41
    db $ff, $ff ; id 42
    db $ff, $ff ; id 43
    db $ff, $ff ; id 44
    db $ff, $ff ; id 45
    db $ff, $ff ; id 46
    db $ff, $ff ; id 47
    db $ff, $ff ; id 48
    db $ff, $ff ; id 49
    db $ff, $ff ; id 50
    db $ff, $ff ; id 51
    db $ff, $ff ; id 52
    db $ff, $ff ; id 53
    db $ff, $ff ; id 54
    db $ff, $ff ; id 55
    db $ff, $ff ; id 56
    db $ff, $ff ; id 57
    db $ff, $ff ; id 58
    db $ff, $ff ; id 59
    db $ff, $ff ; id 60
    db $ff, $ff ; id 61
    db $ff, $ff ; id 62
    db $ff, $ff ; id 63
    db $ff, $ff ; id 64
    db $ff, $ff ; id 65
    db $ff, $ff ; id 66
    db $ff, $ff ; id 67
    db $ff, $ff ; id 68
    db $ff, $ff ; id 69
    db $ff, $ff ; id 70
    db $ff, $ff ; id 71
    db $ff, $ff ; id 72
    db $ff, $ff ; id 73
    db $ff, $ff ; id 74
    db $ff, $ff ; id 75
    db $ff, $ff ; id 76
    db $ff, $ff ; id 77
    db $ff, $ff ; id 78
    db $ff, $ff ; id 79
    db $ff, $ff ; id 80
    db $ff, $ff ; id 81
    db $ff, $ff ; id 82
    db $ff, $ff ; id 83
    db $ff, $ff ; id 84
    db $ff, $ff ; id 85
    db $ff, $ff ; id 86
    db $ff, $ff ; id 87
    db $ff, $ff ; id 88
    db $ff, $ff ; id 89
    db $ff, $ff ; id 90
    db $ff, $ff ; id 91
    db $ff, $ff ; id 92
    db $ff, $ff ; id 93
    db $ff, $ff ; id 94
    db $88, $88 ; id 95
    db $88, $88 ; id 96
    db $88, $88 ; id 97
    db $ff, $ff ; id 98
    db $ff, $ff ; id 99
    db $ff, $ff ; id 100
    db $ff, $ff ; id 101
    db $ff, $ff ; id 102
    db $ff, $ff ; id 103
    db $ff, $ff ; id 104
    db $ff, $ff ; id 105
    db $ff, $ff ; id 106
    db $ff, $ff ; id 107
    db $ff, $ff ; id 108
    db $81, $81 ; id 109
    db $ff, $ff ; id 110
    db $81, $81 ; id 111
    db $81, $81 ; id 112
    db $ff, $ff ; id 113
    db $ff, $ff ; id 114
    db $ff, $ff ; id 115
    db $ff, $ff ; id 116
    db $ff, $ff ; id 117
    db $ff, $ff ; id 118
    db $ff, $ff ; id 119
    db $ff, $ff ; id 120
    db $ff, $ff ; id 121
    db $ff, $ff ; id 122
    db $ff, $ff ; id 123
    db $ff, $ff ; id 124
    db $ff, $ff ; id 125
    db $ff, $ff ; id 126
    db $ff, $ff ; id 127
    db $ff, $ff ; id 128
    db $ff, $ff ; id 129
    db $ff, $ff ; id 130
    db $ff, $ff ; id 131
    db $ff, $ff ; id 132
    db $ff, $ff ; id 133
    db $ff, $ff ; id 134
    db $ff, $ff ; id 135
    db $ff, $ff ; id 136
    db $ff, $ff ; id 137
    db $ff, $ff ; id 138
    db $ff, $ff ; id 139
    db $ff, $ff ; id 140
    db $ff, $ff ; id 141
    db $ff, $ff ; id 142
    db $ff, $ff ; id 143
    db $ff, $ff ; id 144
    db $ff, $ff ; id 145
    db $ff, $ff ; id 146
    db $ff, $ff ; id 147
    db $ff, $ff ; id 148
    db $ff, $ff ; id 149
    db $ff, $ff ; id 150
    db $ff, $ff ; id 151
    db $ff, $ff ; id 152
    db $ff, $ff ; id 153
    db $ff, $ff ; id 154
    db $ff, $ff ; id 155
    db $ff, $ff ; id 156
    db $ff, $ff ; id 157
    db $ff, $ff ; id 158
    db $ff, $ff ; id 159
    db $ff, $ff ; id 160
    db $ff, $ff ; id 161
    db $ff, $ff ; id 162
    db $ff, $ff ; id 163
    db $ff, $ff ; id 164
    db $ff, $ff ; id 165
    db $ff, $ff ; id 166
    db $ff, $ff ; id 167
    db $ff, $ff ; id 168
    db $ff, $ff ; id 169
    db $ff, $ff ; id 170
    db $ff, $ff ; id 171
    db $ff, $ff ; id 172
    db $ff, $ff ; id 173
    db $ff, $ff ; id 174
    db $ff, $ff ; id 175
    db $ff, $ff ; id 176
    db $ff, $ff ; id 177
    db $ff, $ff ; id 178
    db $ff, $ff ; id 179
    db $ff, $ff ; id 180
    db $ff, $ff ; id 181
    db $ff, $ff ; id 182
    db $ff, $ff ; id 183
    db $ff, $ff ; id 184
    db $ff, $ff ; id 185
    db $ff, $ff ; id 186
    db $ff, $ff ; id 187
    db $ff, $ff ; id 188
    db $ff, $ff ; id 189
    db $ff, $ff ; id 190
    db $ff, $ff ; id 191
    db $ff, $ff ; id 192
    db $ff, $ff ; id 193
    db $ff, $ff ; id 194
    db $ff, $ff ; id 195
    db $ff, $ff ; id 196
    db $ff, $ff ; id 197
    db $ff, $ff ; id 198
    db $ff, $ff ; id 199
    db $ff, $ff ; id 200
    db $ff, $ff ; id 201
    db $ff, $ff ; id 202
    db $ff, $ff ; id 203
    db $ff, $ff ; id 204
    db $ff, $ff ; id 205
    db $ff, $ff ; id 206
    db $ff, $ff ; id 207

; SelectEffectByEffectFlags2Flags uses this table for wEffectFlags2 bit 0 (the target acts), indexed
; by wBattleActionId: byte 1 for a near-side actor (ActorOnLocalSide_Bank3A), else byte 0; a value
; other than $FF goes to QueueSoundEffect; 40 entries, up to the next table (E-0210, C1)
ActionSoundTable_Flag0::
    db $ff, $ff ; id 0
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
    db $ff, $ff ; id 13
    db $ff, $ff ; id 14
    db $ff, $ff ; id 15
    db $ff, $ff ; id 16
    db $ff, $ff ; id 17
    db $ff, $ff ; id 18
    db $ff, $ff ; id 19
    db $ff, $ff ; id 20
    db $ff, $ff ; id 21
    db $ff, $ff ; id 22
    db $ff, $ff ; id 23
    db $ff, $ff ; id 24
    db $ff, $ff ; id 25
    db $ff, $ff ; id 26
    db $ff, $ff ; id 27
    db $ff, $ff ; id 28
    db $ff, $ff ; id 29
    db $ff, $ff ; id 30
    db $ff, $ff ; id 31
    db $ff, $ff ; id 32
    db $ff, $ff ; id 33
    db $87, $ff ; id 34
    db $86, $ff ; id 35
    db $81, $ff ; id 36
    db $81, $ff ; id 37
    db $81, $ff ; id 38
    db $81, $ff ; id 39

; SelectEffectByEffectFlags2Flags uses this table for wEffectFlags2 bit 2 (the target acts), indexed
; by wBattleActionId: byte 1 for a near-side actor (ActorOnLocalSide_Bank3A), else byte 0; a value
; other than $FF goes to QueueSoundEffect; 40 entries, up to the next table (E-0210, C1)
ActionSoundTable_Flag2::
    db $ff, $ff ; id 0
    db $ff, $ff ; id 1
    db $ff, $ff ; id 2
    db $ff, $ff ; id 3
    db $ff, $ff ; id 4
    db $ff, $ff ; id 5
    db $ff, $ff ; id 6
    db $ff, $ff ; id 7
    db $ff, $ff ; id 8
    db $ff, $ff ; id 9
    db $ff, $ff ; id 10
    db $ff, $ff ; id 11
    db $ff, $ff ; id 12
    db $ff, $ff ; id 13
    db $ff, $ff ; id 14
    db $ff, $ff ; id 15
    db $ff, $ff ; id 16
    db $ff, $ff ; id 17
    db $ff, $ff ; id 18
    db $ff, $ff ; id 19
    db $ff, $ff ; id 20
    db $ff, $ff ; id 21
    db $ff, $ff ; id 22
    db $ff, $ff ; id 23
    db $ff, $ff ; id 24
    db $85, $ff ; id 25
    db $85, $ff ; id 26
    db $85, $ff ; id 27
    db $85, $ff ; id 28
    db $88, $88 ; id 29
    db $85, $ff ; id 30
    db $ff, $ff ; id 31
    db $ff, $ff ; id 32
    db $ff, $ff ; id 33
    db $ff, $ff ; id 34
    db $ff, $ff ; id 35
    db $93, $ff ; id 36
    db $97, $ff ; id 37
    db $96, $ff ; id 38
    db $96, $ff ; id 39

; Step 3 of the fight phase, run every frame by BattleFight_RunActions and
; RunBattlePhaseWhenTextIdle_A0_RunTurn_Actions. It returns at once while wTextFlags is non-zero (a
; message is being drawn), then redraws changed slot panels (RedrawChangedSlotPanels). While an
; effect runs (wEffectId not $FF) it runs RunBattleEffectAnimation one step and returns; in a link
; battle (wLinkMode non-zero) it only returns. With no effect running it jumps on wBattleSubPhase
; (0-10) to RunBattleActions_StatusCheckStep, RunBattleActions_ResolveStep,
; RunBattleActions_ResolveAction, RunBattleActions_AfterAction, RunActionSpecificPostStep,
; RunBattleActions_ShowHeroBlewBackG, RunBattleActions_FocusFollowUp,
; RunBattleActions_MarkActorDone, RunBattleActions_ItemStep, RunBattleActions_WearOffAndDefeat (the
; end of the turn) and RunBattleActions_NextPhase. (C1, E-0382)
; battle fight step 3: returns while a message is being drawn; in link mode calls
; RunBattleEffectAnimation; otherwise one of 6 sub-steps by wBattleSubPhase, which execute the
; chosen actions through RunBattleResolveStep
RunBattleActions::
    ld a, [wTextFlags]
    or a
    ret nz
    call RedrawChangedSlotPanels
    ld a, [wEffectId]
    cp $ff
    jr z, .read_battle_sub_phase
    ld a, [wLinkMode]
    or a
    ret nz
    farcall RunBattleEffectAnimation
    ret

.read_battle_sub_phase:
    ld a, [wBattleSubPhase]
    jumptable
    dw RunBattleActions_StatusCheckStep
    dw RunBattleActions_ResolveStep
    dw RunBattleActions_ResolveAction
    dw RunBattleActions_AfterAction
    dw RunActionSpecificPostStep
    dw RunBattleActions_ShowHeroBlewBackG
    dw RunBattleActions_FocusFollowUp
    dw RunBattleActions_MarkActorDone
    dw RunBattleActions_ItemStep
    dw RunBattleActions_WearOffAndDefeat
    dw RunBattleActions_NextPhase

; Battle fight step 3, sub-phase 0: the per-action status checks (RunBattleActions_StatusChecks).
; (C1, E-0357)
RunBattleActions_StatusCheckStep::
    farcall RunBattleActions_StatusChecks
    ret

; Battle fight step 3, sub-phase 1: one resolve step (RunBattleResolveStep). (C1, E-0357)
RunBattleActions_ResolveStep::
    farcall RunBattleResolveStep
    ret

; Battle fight step 3, sub-phase 2: loads the action's skill record and resolves the action
; (RunActionResolveStep). (C1, E-0357)
RunBattleActions_ResolveAction::
    ld a, [wBattleActionId]
    ld [wRecordBuffer], a
    xor a
    ld [wRecordBuffer + $1], a
    farcall LoadSkillRecord
    call RunActionResolveStep
    ret

; Battle fight step 3, sub-phase 3: after the action, by its record's byte 4: for a group action
; ($80 or kind 2) moves to the next target unless an attack was inhaled; kind 4 runs QuadHits' hits
; or, when the actor called help, rolls the repeat count; BiAttack runs its hits; otherwise goes on.
; (C1, E-0357)
RunBattleActions_AfterAction::
    ld a, [wRecordBufferData + $4]
    cp $80
    jr z, .check_attack_inhaled
    and $0f
    cp $02
    jr z, .check_attack_inhaled
    cp $04
    jr z, .check_battle_action_id
    ld a, [wBattleActionId]
    cp SKILL_BIATTACK
    jr z, .call_run_multi_hit_counter
    ld hl, wBattleSubPhase
    inc [hl]
    ret

.check_attack_inhaled:
    ld a, [wAttackInhaled]
    or a
    jp z, RunBattleStep4_NextTarget
    ld hl, wBattleSubPhase
    inc [hl]
    ret

.check_battle_action_id:
    ld a, [wBattleActionId]
    cp SKILL_QUADHITS
    jr z, .call_run_multi_hit_counter
    ld a, [wBattleActor]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    bit BSTAT6_CALLED_HELP, [hl]
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

; Sub-phase 4 of RunBattleActions and RunBattleStep4: the after-step that depends on
; wBattleActionId. SKILL_CALLHELP and SKILL_YELLHELP, when wMultiHitCount is non-zero and the actor
; has BSTAT6_CALLED_HELP, clear that bit and show battle text $81 'The help went away!'. ACTION_B9
; clears BSTAT6_CALLED_HELP of the actor and shows $86 'The giant went away laughing!'. These and
; every other action then add 1 to wBattleSubPhase. SKILL_SACRIFICE and ACTION_D6 instead set
; wBattleSubPhase to 1, wBattleResolveStep to $0E, wBattleSubStep to 0 and bit 0 of
; wBattleScreenFlags (ACTION_D6 first stores the actor in wSavedActorSlot and 0 in wSavedActorByte),
; so the action resolves again from resolve step $0E. (C1, E-0382)
; after an action: actions $4E/$4F with wMultiHitCount clear the actor's wBattleStatus6 bit 0 (text
; $81); $B9 clears it (text $86); $D6 stores the actor in wSavedActorSlot; $15 and $D6 jump to
; resolve step $0E; otherwise wBattleSubPhase += 1 (E-0127)
RunActionSpecificPostStep::
    ld a, [wBattleActionId]
    cp SKILL_CALLHELP
    jr z, .check_multi_hit_count
    cp SKILL_YELLHELP
    jr z, .check_multi_hit_count
    cp ACTION_B9
    jr z, .read_battle_actor
    cp SKILL_SACRIFICE
    jr z, .set_battle_sub_phase_to_01
    cp ACTION_D6
    jr z, .read_battle_actor2
    jr .done

.check_multi_hit_count:
    ld a, [wMultiHitCount]
    or a
    jr z, .done
    ld a, [wBattleActor]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    bit BSTAT6_CALLED_HELP, [hl]
    jr z, .done
    res BSTAT6_CALLED_HELP, [hl]
    ld d, $81 ; battle text 'The help went away!'
    farcall ShowBattleText
    jr .done

.read_battle_actor:
    ld a, [wBattleActor]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    res BSTAT6_CALLED_HELP, [hl]
    ld d, $86 ; battle text 'The giant went away laughing!'
    farcall ShowBattleText
    jr .done

.read_battle_actor2:
    ld a, [wBattleActor]
    ld [wSavedActorSlot], a
    xor a
    ld [wSavedActorByte], a

.set_battle_sub_phase_to_01:
    ld a, $01
    ld [wBattleSubPhase], a
    ld a, $0e
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

; Battle fight step 3, sub-phase 5: after an inhaled attack clears it and sets the repeat flag; when
; the target can act and has SuckAll, shows battle text $7E and goes to the next battle step;
; otherwise goes on. (C1, E-0357)
RunBattleActions_ShowHeroBlewBackG::
    ld a, [wAttackInhaled]
    or a
    jr z, .skip
    xor a
    ld [wAttackInhaled], a
    ld a, $01
    ld [wActionRepeatFlag], a
    ld a, [wBattleTarget]
    call CheckSlotStatusBlockWide_Bank3A
    jr c, .skip
    ld hl, wBattleStatus6
    call AddAx9ToHL
    bit BSTAT6_SUCK_ALL, [hl]
    jr z, .skip
    ld hl, wBattleStep
    inc [hl]
    xor a
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    ld d, $7e ; battle text '0 blew back G!'
    farcall ShowBattleText
    ret

.skip:
    ld hl, wBattleSubPhase
    inc [hl]

; Battle fight step 3, sub-phase 6: when the present actor had Focus, clears it and, for a skill
; with record byte 7 bit 4 while the battle goes on, acts again: resets the effect and hits, picks a
; new target and resolves again. (C1, E-0357)
RunBattleActions_FocusFollowUp::
    ld a, [wBattleActor]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .skip
    ld hl, wBattleStatus4
    call AddAx9ToHL
    bit BSTAT4_FOCUS_LO, [hl]
    jr z, .skip
    res BSTAT4_FOCUS_LO, [hl]
    ld a, [wRecordBufferData + $7]
    bit 4, a
    jr z, .skip
    call CheckBattleDecided
    jr nc, .clear_effect_flags
    jr .skip

.clear_effect_flags:
    xor a
    ld [wEffectFlags], a
    ld a, $ff
    ld [wEffectId], a
    xor a
    ld [wMultiHitCount], a
    xor a
    ld [wRedirectFlags], a
    xor a
    ld [wFollowUpAction], a
    ld a, $ff
    ld [wOriginalTarget], a
    xor a
    ld [wBattleSubPhase], a
    ld a, $01
    ld [wBattleResolveStep], a
    ld a, $04
    ld [wBattleSubStep], a
    xor a
    ld [wMultiHitCount], a
    farcall ChooseTargetForActor
    ld a, d
    ld [wBattleTarget], a
    ret

.skip:
    ld hl, wBattleSubPhase
    inc [hl]

; Battle fight step 3, sub-phase 7: when the battle is decided goes to the next phase; otherwise
; marks the actor done (wSlotMarks 3; choice $CC clears status 4 bits 2-3) and moves to the next
; queued action of a present slot, or with none left (or nine done) to sub-phase 9. (C2, E-0357;
; probed E-0382)
RunBattleActions_MarkActorDone::
    xor a
    ld [wFollowUpAction], a
    xor a
    ld [wDefeatStep], a
    xor a
    ld [wBattleScreenFlags], a
    call CheckBattleDecided
    jr nc, .read_action_queue_pos
    ld hl, wBattlePhase
    inc [hl]
    xor a
    ld [wBattleStep], a
    xor a
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    ret

.read_action_queue_pos:
    ld a, [wActionQueuePos]
    ld hl, wActionQueue
    add_a_to_hl
    ld a, [hl]
    cp $10
    jr z, .loop
    ld a, [wBattleActor]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $03
    push hl
    ld a, [wBattleActor]
    ld hl, wBattleActionChoice
    add a
    add_a_to_hl
    ld a, [hl]
    cp $cc
    jr nz, .check_action_queue_pos
    ld a, [wBattleActor]
    ld hl, wBattleStatus4
    call AddAx9ToHL
    ld a, [hl]
    and $f3
    ld [hl], a

.check_action_queue_pos:
    pop hl

.loop:
    ld a, [wActionQueuePos]
    inc a
    ld [wActionQueuePos], a
    cp $09
    jr nc, .set_battle_sub_phase_to_09
    ld a, [wActionQueuePos]
    ld hl, wActionQueue
    add_a_to_hl
    ld a, [hl]
    cp $ff
    jr z, .set_battle_sub_phase_to_09
    cp $10
    jr z, .clear_battle_sub_phase
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, .loop

.clear_battle_sub_phase:
    xor a
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleSubStep], a
    ret

.set_battle_sub_phase_to_09:
    ld a, $09
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    ret

; Carry set = one side has no battler left that can fight, which the callers treat as the battle
; being decided; carry clear otherwise. For ACTION_BD while wMultiHitCount bits 0-6 are non-zero it
; returns A = 0 with carry clear at once. Otherwise carry is set when
; CheckActionBDOrRun_LocalSideOutOrParalyzed finds slots 0-2 all out, empty or paralyzed; if not,
; CheckOtherSideOut decides from slots 4-6. Callers: RunBattleActions_FocusFollowUp,
; RunBattleActions_MarkActorDone, RunBattleActions_WearOffAndDefeat_DroppedDead,
; RunActionResolveStep_CheckDecided and RunActionResolveStep_CheckDecidedAfterDefeat, which on carry
; skip ahead or go to the next battle phase. (C2, E-0382)
; returns A = 0 for action $BD while wMultiHitCount & $7F is non-zero; otherwise runs
; CheckActionBDOrRun_LocalSideOutOrParalyzed and, without carry, CheckOtherSideOut (E-0122) (E-0344:
; the address in its name dropped or read as the label there; was CheckBattleDecided)
CheckBattleDecided::
    ld a, [wBattleActionId]
    cp ACTION_BD
    jr nz, .call_check_action_bd_or_run_local_side_out_or
    ld a, [wMultiHitCount]
    and $7f
    jr z, .call_check_action_bd_or_run_local_side_out_or
    xor a
    ret

.call_check_action_bd_or_run_local_side_out_or:
    call CheckActionBDOrRun_LocalSideOutOrParalyzed
    ret c
    call CheckOtherSideOut
    ret

; Carry only when slots 0-2 (4-6 for the link follower: link mode 1, wLinkRole bit 1) are each out,
; empty or paralyzed (AllThreeSlotsOutOrParalyzed with C = the first slot). (C2, E-0371; probed
; E-0382)
CheckActionBDOrRun_LocalSideOutOrParalyzed::
    ld c, $00
    ld a, [wLinkMode]
    cp $01
    jr nz, AllThreeSlotsOutOrParalyzed
    ld a, [wLinkRole]
    bit 1, a
    jr z, AllThreeSlotsOutOrParalyzed
    ld c, $04

; C = first slot: carry set only when slots C, C + 1 and C + 2 are each out, empty or paralyzed (the
; test of the routine it calls for each slot); it stops at the first slot that is present and not
; paralyzed and returns carry clear. C ends on the last slot tested.
; CheckActionBDOrRun_LocalSideOutOrParalyzed and, in a link battle, CheckOtherSideOut jump into it.
; (C2, E-0382)
AllThreeSlotsOutOrParalyzed::
    call SlotOutOrParalyzed
    ret nc
    inc c
    call SlotOutOrParalyzed
    ret nc
    inc c
    call SlotOutOrParalyzed
    ret

; The other side's check: outside a link carry only when slots 4-6 are all out or empty; in a link
; the status test on slots 4-6 (0-2 for the follower). (C2, E-0357; probed E-0382)
CheckOtherSideOut::
    ld c, $04
    ld a, [wLinkMode]
    cp $01
    jr nz, .call_carry_unless_battle_slot_out_slot_empty
    ld a, [wLinkRole]
    bit 1, a
    jr z, AllThreeSlotsOutOrParalyzed
    ld c, $00
    jr AllThreeSlotsOutOrParalyzed

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

; C = battle slot. Carry set when the slot is out or empty (CarryUnlessBattleSlotOutSlotEmpty gives
; carry; slot numbers of 8 or more count as out) or, for a present slot, when its status byte 0 has
; bit 6 set (BSTAT0_PARALYZED); carry clear for a present slot that is not paralyzed. A and HL are
; clobbered, C is kept. AllThreeSlotsOutOrParalyzed calls it for three slots in a row. (C2, E-0382)
; C = slot: carry set when the slot is present and its status byte 0 bit 6 is set, else carry clear
; (E-0118)
SlotOutOrParalyzed::
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    ret c
    ld a, c
    ld hl, wBattleStatus
    call AddAx9ToHL
    bit BSTAT0_PARALYZED, [hl]
    ret z
    scf
    ret

; Battle fight step 3, sub-phase 8: an item action (RunBattleActions_UseItem). (C1, E-0357)
RunBattleActions_ItemStep::
    farcall RunBattleActions_UseItem
    ret

; Sub-phase 9 of RunBattleActions, the end of the turn, run on wBattleResolveStep (0-6):
; RunBattleActions_EndOfTurn, RunBattleActions_WearOffAndDefeat_Ironize (countdown with the text
; 'Ironize wore off!'), RunBattleActions_WearOffAndDefeat_Poison (poison damage),
; RunBattleActions_WearOffAndDefeat_DroppedDead (the text 'dropped dead!'),
; RunBattleActions_WearOffAndDefeat_NextSlot (next slot, then the turn counter),
; RunBattleActions_WearOffAndDefeat_NextTurn and RunBattleActions_WearOffAndDefeat_TurnLimitDraw.
; RunBattleActions_MarkActorDone enters it when the queue of actions is used up. (C1, E-0382)
; by wBattleResolveStep: battle texts "0's Ironize wore off!" and '0 dropped dead!'
RunBattleActions_WearOffAndDefeat::
    ld a, [wBattleResolveStep]
    jumptable
    dw RunBattleActions_EndOfTurn
    dw RunBattleActions_WearOffAndDefeat_Ironize
    dw RunBattleActions_WearOffAndDefeat_Poison
    dw RunBattleActions_WearOffAndDefeat_DroppedDead
    dw RunBattleActions_WearOffAndDefeat_NextSlot
    dw RunBattleActions_WearOffAndDefeat_NextTurn
    dw RunBattleActions_WearOffAndDefeat_TurnLimitDraw

; End of turn, step 0: clears side flag bits 4 and 6 and the slot pair bytes' bits 2-7; for nine
; 9-byte status rows counts down the two-bit timers (byte 4 all four, byte 5 bits 4-5, byte 8 bits
; 0-1: the high bit moves down, the low one drops), keeps byte 6 bits 6-7 and clears byte 7; then
; starts with slot 0 (step 4 when it is absent). (C2, E-0357; probed E-0382)
RunBattleActions_EndOfTurn::
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wSideFlags0
    ld a, [hl]
    and $af
    ld [hli], a
    ld a, [hl]
    and $af
    ld [hl], a
    ld hl, wSlotPairBytes
    ld a, [hl]
    and $03
    ld [hli], a
    ld a, [hl]
    and $03
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
    and $55
    ld [hli], a
    ld a, [hl]
    and $30
    jr z, .next
    ld a, [hl]
    and $cf
    ld e, a
    ld a, [hl]
    rrca
    and $10
    or e
    ld [hl], a

.next:
    inc hl
    ld a, [hl]
    and $c0
    ld [hli], a
    xor a
    ld [hli], a
    ld a, [hl]
    and $03
    jr z, .next2
    ld a, [hl]
    and $fc
    ld e, a
    ld a, [hl]
    rrca
    and $01
    or e
    ld [hl], a

.next2:
    inc hl
    dec b
    jr nz, .loop
    xor a
    ld [wBattleActor], a
    call CarryUnlessBattleSlotOutSlotEmpty
    ret nc
    ld a, $04
    ld [wBattleResolveStep], a
    ret

; End of turn, step 1: counts down the slot's Ironize ($40 a turn), showing "<name>'s Ironize wore
; off!" (text $84) at zero; an Ironized slot skips the poison step. (C1, E-0357)
RunBattleActions_WearOffAndDefeat_Ironize::
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleActor]
    ld hl, wBattleStatus5
    call AddAx9ToHL
    ld a, [hl]
    and $3f
    ld d, a
    ld a, [hl]
    and $c0
    jr z, .return
    push hl
    push de
    sub $40
    jr nz, .restore
    ld d, $84 ; battle text '0's Ironize wore off!'
    farcall ShowBattleText
    xor a

.restore:
    pop de
    pop hl
    or d
    ld [hl], a
    ld a, $04
    ld [wBattleResolveStep], a

.return:
    ret

; End of turn, step 2: poison: BSTAT0_POISONED takes max HP / 16 (at least 1, at most 50) with text
; $88, BSTAT0_BADLY_POISONED max HP / 6 (at most 150) with text $89; when that defeats the slot goes
; back to step 3, otherwise on to step 4. (C1, E-0357)
RunBattleActions_WearOffAndDefeat_Poison::
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleActor]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    and $03
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
    call RunBattleActions_WearOffAndDefeat_Poison_Damage
    call ApplyPoisonDamage
    ld a, [wBattleArg0]
    ld d, a
    farcall ShowBattleText
    ld a, [wLoadSlot]
    or a
    ret z
    ld hl, wBattleResolveStep
    dec [hl]
    ret

; The poison damage: wBattleDamage = max HP / B (B = 16 or 6), at least 1, at most 50 (B = 16) or
; 150 (B = 6). (C2, E-0357; probed E-0382)
RunBattleActions_WearOffAndDefeat_Poison_Damage::
    push bc
    ld a, [wBattleActor]
    call GetBattleMaxHP_Bank3A
    ld a, b
    call DivideHLByA
    ld a, h
    or l
    jr nz, .restore
    ld hl, $0001

.restore:
    pop bc
    ld a, b
    cp $06
    jr z, .skip2
    ld a, h
    or a
    jr nz, .skip
    ld a, l
    cp $32
    jr c, .set_battle_damage_lo2

.skip:
    ld hl, $0032
    jr .set_battle_damage_lo2

.skip2:
    ld a, h
    or a
    jr nz, .set_battle_damage_lo
    ld a, l
    cp $96
    jr c, .set_battle_damage_lo2

.set_battle_damage_lo:
    ld hl, $0096

.set_battle_damage_lo2:
    ld a, l
    ld [wBattleDamageLo], a
    ld a, h
    ld [wBattleDamageHi], a
    ret

; Takes the poison damage from the slot's HP; at zero clears it, marks the slot's level-up gains
; (bit 2) and defeats it (DefeatTarget, wLoadSlot 1); marks bit 0 either way. (C2, E-0357; probed
; E-0382)
ApplyPoisonDamage::
    xor a
    ld [wLoadSlot], a
    ld a, [wBattleActor]
    ld hl, wBattleHP
    call AddDoubleAToHL_Bank3A
    ld a, [hli]
    ld d, [hl]
    ld e, a
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    ld a, e
    sub c
    ld e, a
    ld a, d
    sbc b
    ld d, a
    jr c, .skip
    ld a, d
    ld [hld], a
    ld [hl], e
    or e
    jr nz, .read_battle_actor
    inc hl

.skip:
    ld a, [hld]
    ld b, a
    ld c, [hl]
    xor a
    ld [hli], a
    ld [hl], a
    ld a, [wBattleActor]
    call SetBit2OfLevelUpGainsIndexed_Bank3A
    ld a, [wBattleArg0]
    push af
    farcall DefeatTarget
    pop af
    ld [wBattleArg0], a
    xor a
    ld [wDefeatStep], a
    ld a, $01
    ld [wLoadSlot], a

.read_battle_actor:
    ld a, [wBattleActor]
    call SetBit0OfLevelUpGainsIndexed_Bank3A
    ret

; End of turn, step 3: blanks the slot's picture and shows '<name> dropped dead!' (text $90); when
; the battle is decided goes to sub-phase $0A. (C1, E-0357)
RunBattleActions_WearOffAndDefeat_DroppedDead::
    ld hl, wBattleResolveStep
    inc [hl]
    farcall BlankTargetMonsterPicture
    ld d, $90 ; battle text '0 dropped dead!'
    farcall ShowBattleText
    call CheckBattleDecided
    ret nc
    ld a, $0a
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    ret

; End of turn, step 4: moves to the next present slot (back to step 1); after slot 7 resets the slot
; marks, counts the turn (up to $FF) and, in a link battle with a turn limit (wLinkRuleTurnLimit bit
; 7), shows the turns left (string $61, or $88 when the number starts with 1) or past the limit
; string $62 and goes to the draw (step 6); otherwise starts the next turn. (C1, E-0357)
RunBattleActions_WearOffAndDefeat_NextSlot::
    ld hl, wBattleActor
    inc [hl]
    ld a, [hl]
    cp $08
    jr z, .skip
    call CarryUnlessBattleSlotOutSlotEmpty
    jr c, RunBattleActions_WearOffAndDefeat_NextSlot
    ld a, $01
    ld [wBattleResolveStep], a
    ret

.skip:
    ld hl, wSlotMarks
    ld bc, $0008
    ld a, $ff
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
    cp $01
    jr z, .call_set_slot_marks_for_present_slots
    ld d, $01

.call_set_slot_marks_for_present_slots:
    call SetSlotMarksForPresentSlots
    ld b, $01
    ld d, $01
    call SetSlotMarksForPresentSlots
    ld hl, wBattleTurn
    ld a, [hl]
    cp $ff
    jr z, .check_link_mode
    inc [hl]

.check_link_mode:
    ld a, [wLinkMode]
    or a
    jr z, .clear_battle_step
    cp $02
    jr z, .clear_battle_step
    ld a, [wLinkRules]
    or a
    jr z, .clear_battle_step
    ld a, [wLinkRuleTurnLimit]
    bit 7, a
    jr z, .clear_battle_step
    res 7, a
    sub [hl]
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
    cp $01
    ld a, $61
    jr nz, .skip3
    ld a, $88

.skip3:
    jr .set_string_index

.clear_battle_step:
    xor a
    ld [wBattleStep], a
    xor a
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    ret

.set_string_index:
    ld [wStringIndex], a
    xor a
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; C = first slot, B = number of slots, D = mark: sets wSlotMarks[slot] = D for each slot in the
; range that is present (not out or empty); a slot that is out keeps its mark. It ends with C = C +
; B and B = 0. RunBattleActions_WearOffAndDefeat_NextSlot calls it four times at the end of a turn
; after filling wSlotMarks with $FF: slots 0-2 get 0, slot 3 gets 1, slots 4-6 get 0 in a link
; battle (wLinkMode 1) and 1 otherwise, slot 7 gets 1. (C2, E-0382)
; C = first slot, B = count, D = value: wSlotMarks[slot] = D for every present slot in the range
; (CarryUnlessBattleSlotOutSlotEmpty) (E-0113)
SetSlotMarksForPresentSlots::
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

; End of turn, step 5: after the text starts the next turn. (C2, E-0357; probed E-0382)
RunBattleActions_WearOffAndDefeat_NextTurn::
    ld a, [wTextFlags]
    or a
    ret nz
    xor a
    ld [wBattleStep], a
    xor a
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    ret

; End of turn, step 6 (the turn limit): after the text ends the battle as a draw: phase 2, step 8,
; wBattleScene $80, music $42. (C2, E-0357; probed E-0382)
RunBattleActions_WearOffAndDefeat_TurnLimitDraw::
    ld a, [wTextFlags]
    or a
    ret nz
    ld a, $02
    ld [wBattlePhase], a
    ld a, $08
    ld [wBattleStep], a
    xor a
    ld [wBattleSubPhase], a
    ld [wBattleResolveStep], a
    ld a, $80
    ld [wBattleScene], a
    ld a, $42
    call QueueMusic
    ret

; Battle fight step 3, sub-phase 10: the next battle phase. (C2, E-0357; probed E-0382)
RunBattleActions_NextPhase::
    ld hl, wBattlePhase
    inc [hl]
    xor a
    ld [wBattleStep], a
    xor a
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    ret

; Redraws the parts of the slot panels that were flagged. For each of wBattlePartyCount slots,
; starting at slot 0 (at slot 4 in a link battle, wLinkMode 1, when wLinkRole bit 1 is set), it
; tests bits 0-2 of wLevelUpGains[slot]: bit 0 redraws the HP digits (DrawSlotHPDigits, then
; CopySlotHPDigitsPanelToVRAM), bit 1 the MP digits (DrawSlotMPDigits, CopySlotMPDigitsPanelToVRAM),
; bit 2 the status marks (DrawSlotStatusMarks, CopySlotPanelRowToVRAM), and clears each bit it
; handled. RunBattleActions and RunBattleStep4 call it every frame, and routines such as
; ApplyPoisonDamage, RunActionResolveStep_TakeMagic and RunActionResolveStep_WakeOrSnapOut set the
; bits. (C1, E-0382)
; for each shown slot redraws the HP, MP and status parts flagged in bits 0-2 of wLevelUpGains[slot]
; and clears the flags (E-0127)
RedrawChangedSlotPanels::
    ld a, [wLinkMode]
    cp $01
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
    farcall CopySlotHPDigitsPanelToVRAM
    pop hl
    res 0, [hl]

.skip:
    bit 1, [hl]
    jr z, .skip2
    push hl
    farcall DrawSlotMPDigits
    farcall CopySlotMPDigitsPanelToVRAM
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

; When the group action has another target, makes it the target (and the actor's target choice) and
; resolves again (sub-phase 1). (C2, E-0357; probed E-0382)
RunBattleStep4_NextTarget::
    call RunBattleStep4_NextGroupTarget
    ret z
    ld a, c
    ld [wBattleTarget], a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
    add_a_to_hl
    ld [hl], c
    ld a, $01
    ld [wBattleSubPhase], a
    ld a, $00
    ld [wBattleResolveStep], a
    ret

; A group action's next target: counts the targets on the first call (wMultiHitCount bit 7 marks
; it), then steps on; with none left, Sacrifice, Farewell and LifeDance (and ACTION_D6, saving the
; actor) go to resolve step $0E with screen flag bit 0, other actions to the next sub-phase; returns
; Z then. (C2, E-0357; probed E-0382)
RunBattleStep4_NextGroupTarget::
    ld a, [wMultiHitCount]
    bit 7, a
    jr nz, .call_next_group_target
    call RunBattleStep4_CountTargets
    ld a, [wMultiHitCount]
    or $80
    ld [wMultiHitCount], a

.call_next_group_target:
    call NextGroupTarget
    ld a, [wMultiHitCount]
    and $7f
    ret nz
    ld a, [wBattleActionId]
    cp SKILL_SACRIFICE
    jr z, .set_battle_sub_phase_to_01
    cp SKILL_FAREWELL
    jr z, .set_battle_sub_phase_to_01
    cp SKILL_LIFEDANCE
    jr z, .set_battle_sub_phase_to_01
    cp ACTION_D6
    jr z, .read_battle_actor
    ld hl, wBattleSubPhase
    inc [hl]
    jr .return_0

.read_battle_actor:
    ld a, [wBattleActor]
    ld [wSavedActorSlot], a
    xor a
    ld [wSavedActorByte], a

.set_battle_sub_phase_to_01:
    ld a, $01
    ld [wBattleSubPhase], a
    ld a, $0e
    ld [wBattleResolveStep], a
    ld a, $00
    ld [wBattleSubStep], a
    ld hl, wBattleScreenFlags
    set 0, [hl]

.return_0:
    xor a
    ret

; Adds the number of targets of a group action to wMultiHitCount (it is not cleared first): the
; target slot itself, always, plus every present slot of the target side (slots 0-3 or 4-7), or of
; both sides starting with the target side when record byte 4 (wRecordBufferData + 4) is $80.
; Another slot whose wBattleSlotOut byte is $FF never counts; a fallen slot (wBattleSlotOut non-zero
; but not $FF) counts only for SKILL_FAREWELL, SKILL_LIFEDANCE, ACTION_CE and ACTION_BB. (C2,
; E-0382)
RunBattleStep4_CountTargets::
    ld b, $04
    ld a, [wRecordBufferData + $4]
    cp $80
    jr nz, .check_battle_target
    ld b, $08

.check_battle_target:
    ld a, [wBattleTarget]
    and $04
    ld c, a

.loop:
    ld a, [wBattleTarget]
    cp c
    jr z, .skip
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .skip
    jr z, .check_record_buffer_data
    ld a, [wBattleActionId]
    cp SKILL_FAREWELL
    jr z, .skip
    cp SKILL_LIFEDANCE
    jr z, .skip
    cp ACTION_CE
    jr z, .skip
    cp ACTION_BB
    jr z, .skip
    jr .check_record_buffer_data

.skip:
    ld hl, wMultiHitCount
    inc [hl]

.check_record_buffer_data:
    inc c
    dec b
    ld a, [wRecordBufferData + $4]
    cp $80
    jr nz, .skip2
    ld a, b
    cp $04
    jr nz, .skip2
    ld a, [wBattleTarget]
    and $04
    xor $04
    ld c, a

.skip2:
    ld a, b
    or a
    jr nz, .loop
    ret

; Moves C to the group action's next target after the current one (present, or fallen for those four
; skills), crossing to the other side for record byte 4 $80; counts one down. (C2, E-0357; probed
; E-0382)
NextGroupTarget::
    ld a, [wBattleTarget]
    inc a
    ld c, a
    ld hl, wMultiHitCount
    dec [hl]
    ld a, [hl]
    and $7f
    ret z

.check_record_buffer_data:
    ld a, [wRecordBufferData + $4]
    cp $80
    jr nz, .call_carry_unless_battle_slot_out_slot_empty
    ld a, c
    and $03
    jr nz, .call_carry_unless_battle_slot_out_slot_empty
    ld a, [wBattleTarget]
    and $04
    xor $04
    ld c, a
    jr nz, .call_carry_unless_battle_slot_out_slot_empty

.call_carry_unless_battle_slot_out_slot_empty:
    ld a, c
    call CarryUnlessBattleSlotOutSlotEmpty
    ret nc
    jr z, .next
    ld a, [wBattleActionId]
    cp SKILL_FAREWELL
    ret z
    cp SKILL_LIFEDANCE
    ret z
    cp ACTION_CE
    ret z
    cp ACTION_BB
    ret z

.next:
    inc c
    jr .check_record_buffer_data

; Used for a skill with record kind 4 when the actor has BSTAT6_CALLED_HELP
; (RunBattleActions_AfterAction and RunBattleStep4_AfterAction). When bit 7 of wMultiHitCount is
; already set it goes on to RunMultiHitCounter_NextHit. Otherwise it rolls a number from 1 up to a
; limit with RandomInRange (the limit is 4, or 3 for a foe actor of slot 4 or more outside a link
; battle, and is doubled unless the action is SKILL_CALLHELP), stores the roll with bit 7 set in
; wMultiHitCount, picks a new target (RunMultiHitCounter_NewTarget) and resolves again. (C1, E-0382)
; unless bit 7 of wMultiHitCount is set, rolls 1-4 (1-3 for foes outside link battles; doubled for
; action other than $4E) into wMultiHitCount with bit 7 set (E-0126)
RollRepeatCountForAction::
    ld a, [wMultiHitCount]
    bit 7, a
    jp nz, RunMultiHitCounter_NextHit
    ld hl, $0001
    ld bc, $0004
    ld a, [wLinkMode]
    cp $01
    jr z, .check_battle_action_id
    ld a, [wBattleActor]
    cp $04
    jr c, .check_battle_action_id
    ld c, $03

.check_battle_action_id:
    ld a, [wBattleActionId]
    cp SKILL_CALLHELP
    jr z, .call_random_in_range
    sla c

.call_random_in_range:
    call RandomInRange
    ld a, e
    or $80
    ld [wMultiHitCount], a
    jr RunMultiHitCounter_NewTarget

; Multi-hit bookkeeping for SKILL_BIATTACK and SKILL_QUADHITS (called from
; RunBattleActions_AfterAction and RunBattleStep4_AfterAction after each hit). If the actor is out
; or empty it sets wMultiHitCount to $80 and ends the hits (RunMultiHitCounter_HitsDone). With bit 7
; of wMultiHitCount set it goes on to RunMultiHitCounter_NextHit. Otherwise it starts the count: $81
; (one more hit) for SKILL_BIATTACK, which resolves again at the same target if it is still present
; and otherwise ends the hits, and $83 (three more hits) for other actions, which pick a new target
; through RunMultiHitCounter_AutoTarget. RunMultiHitCounter_NextHit counts one down and ends the
; hits at zero; SKILL_BIATTACK keeps a present target and otherwise picks another, other actions
; pick a new one. (C1, E-0382)
; sets up and counts down the multi-hit counter in wMultiHitCount (1 or 3 hits for action $63),
; choosing a new target for $63 when the old one is gone (E-0128)
RunMultiHitCounter::
    ld a, [wBattleActor]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, .check_multi_hit_count
    ld a, $80
    ld [wMultiHitCount], a
    jr RunMultiHitCounter_HitsDone

.check_multi_hit_count:
    ld a, [wMultiHitCount]
    bit 7, a
    jp nz, RunMultiHitCounter_NextHit
    ld a, [wBattleActionId]
    cp SKILL_BIATTACK
    ld a, $81
    jr z, .set_multi_hit_count
    ld a, $83

.set_multi_hit_count:
    ld [wMultiHitCount], a
    jr nz, RunMultiHitCounter_AutoTarget
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, RunMultiHitCounter_NewTarget_ResolveAgain
    jr RunMultiHitCounter_HitsDone

; The next hit of a multi-hit action: when hits remain, BiAttack keeps a present target or picks
; another; other actions pick a new target. (C1, E-0357)
RunMultiHitCounter_NextHit::
    ld hl, wMultiHitCount
    dec [hl]
    ld a, [hl]
    and $7f
    jr z, RunMultiHitCounter_HitsDone
    ld a, [wBattleActionId]
    cp SKILL_BIATTACK
    jr nz, RunMultiHitCounter_AutoTarget
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jr nc, RunMultiHitCounter_NewTarget_ResolveAgain

; Picks a new target (ChooseTargetForActor). (C1, E-0357)
RunMultiHitCounter_NewTarget::
    farcall ChooseTargetForActor
    ld a, d
    ld [wBattleTarget], a

; Resolves the action again (sub-phase 1, resolve step 1). (C2, E-0357; probed E-0382)
RunMultiHitCounter_NewTarget_ResolveAgain::
    ld a, $01
    ld [wBattleSubPhase], a
    ld a, $01
    ld [wBattleResolveStep], a
    ret

; The hits are done: the next sub-phase. (C2, E-0357; probed E-0382)
RunMultiHitCounter_HitsDone::
    ld hl, wBattleSubPhase
    inc [hl]
    ret

; Picks a new target with the actor's side control bit 7 set for the choice (the automatic choice),
; then resolves again. (C1, E-0357)
RunMultiHitCounter_AutoTarget::
    ld a, [wBattleActor]
    ld hl, wSideControl
    add_a_to_hl
    push hl
    ld a, [hl]
    push af
    or $80
    ld [hl], a
    farcall ChooseTargetForActor
    ld a, d
    ld [wBattleTarget], a
    pop af
    pop hl
    ld [hl], a
    jr RunMultiHitCounter_NewTarget_ResolveAgain

; Fight step 4, run every frame by BattleFight_Step4 and
; RunBattlePhaseWhenTextIdle_A0_RunTurn_FightStep: a follow-up round in which the target of the
; action just resolved acts in turn with the same action (RunBattleStep4_SaveAndStart sets it up).
; It starts like RunBattleActions: returns while wTextFlags is non-zero, redraws changed slot
; panels, and while an effect runs (wEffectId not $FF) runs RunBattleEffectAnimation one step (a
; link battle only returns). With no effect it jumps on wBattleSubPhase (0-5) to
; RunBattleStep4_SkillChecks, RunBattleStep4_ResolveStep, RunBattleStep4_ResolveAction,
; RunBattleStep4_AfterAction, RunBattleStep4_ActionPostStep and RunBattleStep4_RestoreSaved, which
; puts the saved state back and returns to fight step 3. (C1, E-0382)
; battle fight step 4: the same prologue as RunBattleActions, then its own sub-steps (not seen in
; the first battle)
RunBattleStep4::
    ld a, [wTextFlags]
    or a
    ret nz
    call RedrawChangedSlotPanels
    ld a, [wEffectId]
    cp $ff
    jr z, .read_battle_sub_phase
    ld a, [wLinkMode]
    or a
    ret nz
    farcall RunBattleEffectAnimation
    ret

.read_battle_sub_phase:
    ld a, [wBattleSubPhase]
    jumptable
    dw RunBattleStep4_SkillChecks
    dw RunBattleStep4_ResolveStep
    dw RunBattleStep4_ResolveAction
    dw RunBattleStep4_AfterAction
    dw RunBattleStep4_ActionPostStep
    dw RunBattleStep4_RestoreSaved

; Battle fight step 4, sub-phase 0: resolves the skill (RunBattleStep4_ResolveSkill). (C1, E-0357)
RunBattleStep4_SkillChecks::
    farcall RunBattleStep4_ResolveSkill
    ret

; Battle fight step 4, sub-phase 1: one resolve step. (C1, E-0357)
RunBattleStep4_ResolveStep::
    farcall RunBattleResolveStep
    ret

; Battle fight step 4, sub-phase 2: resolves the action. (C1, E-0357)
RunBattleStep4_ResolveAction::
    call RunActionResolveStep
    ret

; Battle fight step 4, sub-phase 3: after the action, by record byte 4: kind 2 moves to the next
; target; kind 4 runs QuadHits' hits or rolls the called-help repeats; BiAttack runs its hits;
; otherwise goes on. (C1, E-0357)
RunBattleStep4_AfterAction::
    ld a, [wRecordBufferData + $4]
    and $0f
    cp $02
    jr z, .call_run_battle_step4_next_target
    cp $04
    jr z, .check_battle_action_id
    ld a, [wBattleActionId]
    cp SKILL_BIATTACK
    jr z, .call_run_multi_hit_counter
    ld hl, wBattleSubPhase
    inc [hl]
    ret

.call_run_battle_step4_next_target:
    call RunBattleStep4_NextTarget
    ret

.check_battle_action_id:
    ld a, [wBattleActionId]
    cp SKILL_QUADHITS
    jr z, .call_run_multi_hit_counter
    ld a, [wBattleActor]
    ld hl, wBattleStatus6
    call AddAx9ToHL
    bit BSTAT6_CALLED_HELP, [hl]
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

; Battle fight step 4, sub-phase 4: the action's own after-step (RunActionSpecificPostStep). (C1,
; E-0357)
RunBattleStep4_ActionPostStep::
    call RunActionSpecificPostStep
    ret

; Battle fight step 4, sub-phase 5: restores the saved actor, target, hit count, both action choices
; and the target's slot mark, steps the battle back one step and resumes at sub-phase 3 (6 when the
; repeat flag was set, clearing it). (C2, E-0357; probed E-0382)
RunBattleStep4_RestoreSaved::
    ld hl, wSavedActorTarget
    ld a, [hli]
    ld [wBattleActor], a
    ld a, [hli]
    ld [wBattleTarget], a
    ld a, [hli]
    ld [wMultiHitCount], a
    ld a, [wBattleActor]
    ld de, wBattleActionChoice
    add a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    ld a, [wBattleTarget]
    ld de, wBattleActionChoice
    add a
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    ld a, [wBattleTarget]
    ld de, wSlotMarks
    add e
    ld e, a
    jr nc, .skip3
    inc d

.skip3:
    ld a, [hl]
    ld [de], a
    xor a
    ld [wFollowUpAction], a
    ld hl, wBattleStep
    dec [hl]
    ld a, $03
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleSubStep], a
    ld a, [wActionRepeatFlag]
    or a
    ret z
    xor a
    ld [wActionRepeatFlag], a
    ld a, $06
    ld [wBattleSubPhase], a
    ret

; Sub-phase 2 of RunBattleActions and of RunBattleStep4: one step of resolving the action, run on
; wBattleResolveStep (0-9): RunActionResolveStep_TakeMagic, RunActionResolveStep_WakeOrSnapOut,
; RunActionResolveStep_SnapOutOfConfusion, RunActionResolveStep_CheckDecided,
; RunActionResolveStep_Counter, RunActionResolveStep_EffectSubSteps (RunBattleSubStep),
; RunActionResolveStep_RestoreTarget, RunActionResolveStep_RunDefeat (RunDefeatStepMinus1Step),
; RunActionResolveStep_CheckDecidedAfterDefeat and RunActionResolveStep_Imitate. Most steps add 1 to
; wBattleResolveStep themselves and some add more to skip steps (for example
; RunActionResolveStep_CheckDecided when the battle is decided). (C1, E-0382)
; resolves one battle action of the current actor (battle step 4): by wBattleResolveStep it checks
; that the actor can act (out of the battle, asleep: 'woke up'), runs the action's sub-steps
; (RunBattleSubStep) and the defeat steps (RunDefeatStepMinus1Step) (E-0354; was: runs the routine
; for wBattleResolveStep (jump table of ten) (E-0122))
RunActionResolveStep::
    ld a, [wBattleResolveStep]
    jumptable
    dw RunActionResolveStep_TakeMagic
    dw RunActionResolveStep_WakeOrSnapOut
    dw RunActionResolveStep_SnapOutOfConfusion
    dw RunActionResolveStep_CheckDecided
    dw RunActionResolveStep_Counter
    dw RunActionResolveStep_EffectSubSteps
    dw RunActionResolveStep_RestoreTarget
    dw RunActionResolveStep_RunDefeat
    dw RunActionResolveStep_CheckDecidedAfterDefeat
    dw RunActionResolveStep_Imitate

; Resolve step 0 (TakeMagic): when the present target has BSTAT2_TAKE_MAGIC, the skill's record byte
; 7 bit 0 (and, for a follow-up, message flag bit 4) and less than full MP, it gains MP equal to
; record byte 0, at most up to its max (wBattleDamage holds the gain while text $40 shows); then
; step 1. (C1, E-0357)
RunActionResolveStep_TakeMagic::
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wBattleStatus2
    call AddAx9ToHL
    bit BSTAT2_TAKE_MAGIC, [hl]
    jp z, RunActionResolveStep_WakeOrSnapOut
    ld a, [wBattleTarget]
    call CarryUnlessBattleSlotOutSlotEmpty
    jp c, RunActionResolveStep_WakeOrSnapOut
    ld a, [wRecordBufferData + $7]
    bit 0, a
    jr z, RunActionResolveStep_WakeOrSnapOut
    ld a, [wFollowUpAction]
    bit 2, a
    jr z, .read_battle_target
    ld a, [wResolveMsgFlags]
    bit 4, a
    jr z, RunActionResolveStep_WakeOrSnapOut

.read_battle_target:
    ld a, [wBattleTarget]
    call GetBattleMaxMP_Bank3A
    push hl
    ld a, [wBattleTarget]
    call GetBattleMP_Bank3A
    pop bc
    call CompareHLToBC
    jr z, RunActionResolveStep_WakeOrSnapOut
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
    sub c
    ld l, a
    ld a, h
    sbc b
    ld h, a
    ld a, e
    sub l
    ld e, a
    ld a, d
    sbc h
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

; Resolve step 1: when the present target is asleep or confused (status bits 7 or 4), the skill's
; record byte 7 bit 3 and message flag bit 4, a roll below $40 (a foe outside a link) or $80 wakes a
; sleeper (clearing bits 7, 3 and 2, mark 3, text $82 '<name> woke up!'); a confused target goes to
; step 2; otherwise on to step 3. (C1, E-0357)
RunActionResolveStep_WakeOrSnapOut::
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
    and $90
    jr z, .skip
    push hl
    call AdvanceRandom
    call RollRandomBelowTargetThreshold
    pop hl
    jr nc, .skip
    bit 7, [hl]
    jr z, RunActionResolveStep_SnapOutOfConfusion
    ld a, [hl]
    and $73
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
    jr RunActionResolveStep_CheckDecided

; Resolve step 2: a confused target that passed step 1's roll snaps out of it (clears
; BSTAT0_CONFUSED, mark 3, text $83). (C1, E-0357)
RunActionResolveStep_SnapOutOfConfusion::
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wBattleTarget]
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, [hl]
    bit BSTAT0_CONFUSED, [hl]
    jr z, RunActionResolveStep_CheckDecided
    res BSTAT0_CONFUSED, [hl]
    ld a, [wBattleTarget]
    ld hl, wSlotMarks
    add_a_to_hl
    ld [hl], $03
    ld a, [wBattleTarget]
    call SetBit2OfLevelUpGainsIndexed_Bank3A
    ld d, $83 ; battle text '0 snapped out of confusion!'
    farcall ShowBattleText
    ret

; Resolve step 3: when the battle is decided skips to step 6; otherwise step 4. (C1, E-0357)
RunActionResolveStep_CheckDecided::
    ld hl, wBattleResolveStep
    inc [hl]
    call CheckBattleDecided
    jr nc, RunActionResolveStep_Counter
    ld hl, wBattleResolveStep
    inc [hl]
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; Resolve step 4 (Counter): when there is no follow-up and the target has BSTAT7_COUNTER, the
; skill's record byte 5 bit 7, the actor is present, the target can act and message flag bit 4 is
; set: halves the damage (doubles it with BSTAT7_DAMAGE_DOUBLED), swaps actor and target, sets
; effect flags $11 ($10 for no damage) and shows the counter's text by the target's personality act
; bit 3 or a random pick. (C1, E-0357)
RunActionResolveStep_Counter::
    ld a, [wFollowUpAction]
    or a
    jp nz, .skip4
    ld a, [wBattleTarget]
    ld hl, wBattleStatus7
    call AddAx9ToHL
    bit BSTAT7_COUNTER, [hl]
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
    ld hl, wPersonalityActs
    call AddDoubleAToHL_Bank3A
    ld a, [hl]
    and $08
    ld [wBattleArg0], a
    push hl
    ld a, [wBattleTarget]
    ld hl, wBattleStatus7
    call AddAx9ToHL
    bit BSTAT7_DAMAGE_DOUBLED, [hl]
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
    or l
    jr z, .set_effect_flags_to_10
    ld a, $11
    ld [wEffectFlags], a
    jr .skip2

.set_effect_flags_to_10:
    ld a, $10
    ld [wEffectFlags], a

.skip2:
    ld hl, wBattleActor
    ld a, [hli]
    push af
    ld a, [hld]
    ld [hli], a
    pop af
    ld [hl], a
    ld a, [wEffectFlags]
    bit 0, a
    jr z, .call_show_battle_text
    ld a, [wBattleArg0]
    or a
    jr z, .call_advance_random
    ld d, $31
    farcall ShowBattleTextCategory0
    jr .skip3

.call_advance_random:
    call AdvanceRandom
    ld a, [wRandomLo]
    and $01
    jr nz, .call_show_battle_text
    ld d, $7c
    jr .call_show_battle_text2

.call_show_battle_text:
    ld d, $7d ; battle text '0 couldn't retaliate!'

.call_show_battle_text2:
    farcall ShowBattleText
    ld a, [wEffectFlags]
    bit 0, a
    jr z, .read_battle_actor
    ld a, [wRandomLo]
    and $01
    jr nz, .read_battle_actor

.skip3:
    ld hl, wBattleResolveStep
    inc [hl]
    xor a
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

; Resolve step 5: the effect's sub-steps (RunBattleSubStep). (C1, E-0357)
RunActionResolveStep_EffectSubSteps::
    farcall RunBattleSubStep
    ret

; Resolve step 6: puts back a redirected target (wOriginalTarget) as the target and choice;
; otherwise outside fight step 4 after a follow-up restores the saved actor, target, hits and
; choices. (C1, E-0357)
RunActionResolveStep_RestoreTarget::
    ld hl, wBattleResolveStep
    inc [hl]
    ld a, [wOriginalTarget]
    cp $ff
    jr z, .check_battle_step
    ld [wBattleTarget], a
    ld b, a
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    call AddDoubleAToHL_Bank3A
    ld [hl], b
    ld a, $ff
    ld [wOriginalTarget], a
    ret

.check_battle_step:
    ld a, [wBattleStep]
    cp $04
    jr z, RunActionResolveStep_RunDefeat
    ld a, [wFollowUpAction]
    or a
    jr z, RunActionResolveStep_RunDefeat
    xor a
    ld [wFollowUpAction], a
    ld hl, wSavedActorTarget
    ld a, [hli]
    ld [wBattleActor], a
    ld a, [hli]
    ld [wBattleTarget], a
    ld a, [hli]
    ld [wMultiHitCount], a
    ld a, [wBattleActor]
    ld de, wBattleActionChoice
    call RunActionResolveStep_StoreWordAtIndex
    ld a, [wBattleTarget]
    ld de, wBattleActionChoice

; HL = source word, DE = table of words, A = index: copies the two bytes at HL to DE + 2 * A (A is
; doubled in 8 bits, so it wraps above $7F, and a carry out of E reaches D). On return HL is 2
; further and DE is on the second byte written. RunActionResolveStep_RestoreTarget uses it twice (a
; call, then a fall-through) to put the saved choice words back into wBattleActionChoice for the
; actor and for the target. (C2, E-0382)
; copies the word at HL to DE + 2 * A
RunActionResolveStep_StoreWordAtIndex::
    add a
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    ret

; Resolve step 7: runs the pending defeat step (RunDefeatStepMinus1Step). (C1, E-0357)
RunActionResolveStep_RunDefeat::
    ld a, [wDefeatStep]
    or a
    call nz, RunDefeatStepMinus1Step
    ld hl, wBattleResolveStep
    inc [hl]
    ret

; Resolve step 8: when the battle is decided clears the hits and goes to sub-phase 4; otherwise step
; 9. (C2, E-0357; probed E-0382)
RunActionResolveStep_CheckDecidedAfterDefeat::
    call CheckBattleDecided
    jr c, .clear_multi_hit_count
    ld hl, wBattleResolveStep
    inc [hl]
    ret

.clear_multi_hit_count:
    xor a
    ld [wMultiHitCount], a
    ld a, $04
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    ret

; Resolve step 9: the Imitate check. (C1, E-0357)
RunActionResolveStep_Imitate::
    call RunActionResolveStep_Imitate_TryStrikeBack
    ret

; Carry set when wRandomLo is below a limit, which is $80 in link mode 1 and for a target in slot
; 0-3, and $40 for a target in slot 4-7 outside a link battle (link mode 2 counts as no link). B
; ends as the limit and A as wRandomLo. It does not advance the random state;
; RunActionResolveStep_WakeOrSnapOut calls AdvanceRandom first, so a foe target wakes or snaps out
; of confusion half as often. (C2, E-0382)
; carry when wRandomLo is below $40 (a foe target outside link battles) or $80 (otherwise) (E-0122)
RollRandomBelowTargetThreshold::
    ld a, [wLinkMode]
    cp $01
    jr z, .check_random_lo
    ld a, [wBattleTarget]
    cp $04
    jr c, .check_random_lo
    ld b, $40
    jr .check_random_lo2

.check_random_lo:
    ld b, $80

.check_random_lo2:
    ld a, [wRandomLo]
    cp b
    ret

; Runs the pending defeat message of an action: RunActionResolveStep_RunDefeat calls it when
; wDefeatStep is non-zero, and it jumps on wDefeatStep - 1 (0-9). Entry 0
; (RunDefeatStepMinus1Step_ShowText) shows battle text $85 for a target on the near side and $E8
; otherwise, entry 1 (RunDefeatStepMinus1Step_ShowText2) $80 for the near side and $E7 otherwise,
; entry 2 shows $AC 'The barrier popped and disappeared!', entry 8 shows $7F 'went away!' and
; entries 3-7 and 9 do nothing. Every entry that shows text clears wDefeatStep afterwards. (C1,
; E-0382)
; the defeat steps of a resolved action (wDefeatStep - 1): handles a defeated target on either side
; and shows '0 went away' (E-0354; was: runs the routine for wDefeatStep - 1 (jump table of ten)
; (E-0122))
RunDefeatStepMinus1Step::
    ld a, [wDefeatStep]
    dec a
    jumptable
    dw RunDefeatStepMinus1Step_ShowText
    dw RunDefeatStepMinus1Step_ShowText2
    dw RunDefeatStepMinus1Step_ShowBarrierPopped
    dw RunDefeatStepMinus1Step_DoNothing
    dw RunDefeatStepMinus1Step_DoNothing
    dw RunDefeatStepMinus1Step_DoNothing
    dw RunDefeatStepMinus1Step_DoNothing
    dw RunDefeatStepMinus1Step_DoNothing
    dw RunDefeatStepMinus1Step_ShowHeroWentAway
    dw RunDefeatStepMinus1Step_DoNothing

; Defeat step 0: battle text $85 for a target on the near side, $E8 otherwise. (C1, E-0357)
RunDefeatStepMinus1Step_ShowText::
    call TargetOnLocalSide_Bank3A
    ld d, $85
    jr c, RunDefeatStepMinus1Step_ShowTextAndEnd
    ld d, $e8
    jr RunDefeatStepMinus1Step_ShowTextAndEnd

; Defeat step 1: battle text $80 for a target on the near side, $E7 otherwise. (C1, E-0357)
RunDefeatStepMinus1Step_ShowText2::
    call TargetOnLocalSide_Bank3A
    ld d, $80
    jr c, RunDefeatStepMinus1Step_ShowTextAndEnd
    ld d, $e7
    jr RunDefeatStepMinus1Step_ShowTextAndEnd

; Defeat step 2 (wDefeatStep = 3): D = battle text $AC 'The barrier popped and disappeared!', shown
; by RunDefeatStepMinus1Step_ShowTextAndEnd, which also clears wDefeatStep. (C1, E-0371)
RunDefeatStepMinus1Step_ShowBarrierPopped::
    ld d, $ac
    jr RunDefeatStepMinus1Step_ShowTextAndEnd

; Entries 3-7 and 9 of RunDefeatStepMinus1Step (wDefeatStep = 4-8 and 10): a bare ret; unlike the
; other entries it leaves wDefeatStep unchanged. (C2, E-0371; probed E-0382)
RunDefeatStepMinus1Step_DoNothing::
    ret

; Defeat step 8: battle text $7F ('<name> went away'). (C1, E-0357)
RunDefeatStepMinus1Step_ShowHeroWentAway::
    ld d, $7f ; battle text '0 went away!'

; Shows battle text D and clears the defeat step. (C1, E-0357)
RunDefeatStepMinus1Step_ShowTextAndEnd::
    farcall ShowBattleText
    xor a
    ld [wDefeatStep], a
    ret

; The Imitate check (outside fight step 4): after a follow-up shows text $7B; when the target can
; act and has BSTAT6_IMITATE, a skill without record byte 7 bit 2 shows text $7B, otherwise
; (Massacre only across sides, not deflected, with message flag bit 4) text $7A and the next battle
; step, returning NC; every other case goes to the next sub-phase with carry. (C1, E-0357)
RunActionResolveStep_Imitate_TryStrikeBack::
    ld a, [wBattleStep]
    cp $04
    jr z, .clear_attack_deflected
    ld a, [wFollowUpAction]
    or a
    jr nz, .clear_follow_up_action
    ld a, [wBattleTarget]
    call CheckSlotStatusBlockWide_Bank3A
    jr c, .clear_attack_deflected
    ld hl, wBattleStatus6
    call AddAx9ToHL
    bit BSTAT6_IMITATE, [hl]
    jr z, .clear_attack_deflected
    ld a, [wRecordBufferData + $7]
    bit 2, a
    jr z, .call_show_battle_text
    ld a, [wBattleActionId]
    cp SKILL_MASSACRE
    jr nz, .check_attack_deflected
    ld a, [wBattleActor]
    and $04
    ld l, a
    ld a, [wBattleTarget]
    and $04
    add l
    and $04
    jr z, .clear_attack_deflected

.check_attack_deflected:
    ld a, [wAttackDeflected]
    cp $01
    jr z, .clear_attack_deflected
    ld a, [wResolveMsgFlags]
    bit 4, a
    jr z, .clear_attack_deflected
    ld d, $7a ; battle text '0 struck back!'
    farcall ShowBattleText
    ld hl, wBattleStep
    inc [hl]
    xor a
    ld [wBattleSubPhase], a
    xor a
    ld [wBattleResolveStep], a
    xor a
    ld [wBattleSubStep], a
    xor a
    ret

.clear_follow_up_action:
    xor a
    ld [wFollowUpAction], a

.call_show_battle_text:
    ld d, $7b ; battle text '0 couldn't strike back!'
    farcall ShowBattleText

.clear_attack_deflected:
    xor a
    ld [wAttackDeflected], a
    ld hl, wBattleSubPhase
    inc [hl]
    xor a
    ld [wBattleResolveStep], a
    scf
    ret

; C = slot number: removes the first of the 8 bytes of wActionQueue that equals C by shifting the
; later bytes down one place; the byte after the queue (wActionQueue + 8) is shifted into the eighth
; place and set to $FF. A value that is not in the queue changes nothing. No call to this copy was
; found in src/ (its 35 bytes equal RemoveCFromActionQueue in bank $36). (C2, E-0382)
; removes the first byte equal to C from the 8-byte queue at wActionQueue, shifting later bytes down
; and filling with $FF (E-0124)
RemoveCFromActionQueue_3A::
    ld hl, wActionQueue
    ld b, $08
    ld d, $00

.loop:
    bit 0, d
    jr nz, .next
    ld a, [hl]
    cp c
    jr nz, .next2
    ld d, $01

.next:
    inc hl
    ld a, [hl]
    ld [hl], $ff
    dec hl
    ld [hl], a
    inc hl
    dec b
    jr nz, .loop
    ld [hl], $ff
    ret

.next2:
    inc hl
    dec b
    jr nz, .loop
    ret

; Shows the battle text of the action wBattleActionId: D = the byte at ActionBattleTextTable +
; wBattleActionId (232 entries); $FF shows nothing. For ACTION_CF it first runs RollLoveRainOutcome,
; which replaces D by $D6 or $91. Then it jumps to ShowBattleText (category 1 of bank $2F, with the
; prep routine of BattleTextPrepTable). Called through farcall by
; RunBattleActions_StatusChecks_ShowActionText and RunBattleStep4_ResolveSkill_ShowActionText. (C1,
; E-0382)
; D = ActionBattleTextTable[wBattleActionId]; returns at once when it is $FF; for action $CF first
; runs RollLoveRainOutcome; then ShowBattleText (E-0118)
ShowActionBattleTextFromActionBattleTextTable::
    ld a, [wBattleActionId]
    ld hl, ActionBattleTextTable
    add_a_to_hl
    ld a, [hl]
    cp $ff
    ret z
    ld d, a
    ld a, [wBattleActionId]
    cp ACTION_CF
    call z, RollLoveRainOutcome
    jp ShowBattleText

; For action ACTION_CF only (called by ShowActionBattleTextFromActionBattleTextTable): rolls
; AdvanceRandom; when wRandomLo is below $80 sets wLoveRainFlag to 1 and returns D = battle text $D6
; ('A gentle rain fell!'), otherwise clears wLoveRainFlag and returns D = $91 ('... prayer went
; unanswered!'). ActionEffect_ActionCF tests wLoveRainFlag to decide whether it heals. (C2, E-0372;
; probed E-0382)
RollLoveRainOutcome::
    call AdvanceRandom
    ld a, [wRandomLo]
    cp $80
    jr c, .set_love_rain_flag_to_01
    xor a
    ld [wLoveRainFlag], a
    ld d, $91
    ret

.set_love_rain_flag_to_01:
    ld a, $01
    ld [wLoveRainFlag], a
    ld d, $d6
    ret

; ShowActionBattleTextFromActionBattleTextTable reads the byte at $6DAA + wBattleActionId and,
; unless it is $FF, passes it in D to ShowBattleText (action $CF first runs RollLoveRainOutcome);
; 232 bytes end at ShowActionBattleText ($6E92) (E-0210, C1)
; record: battle text index ($FF = none)
ActionBattleTextTable::
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
    db $1a ; id 61
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
    db $0f ; id 102
    db $02 ; id 103
    db $da ; id 104
    db $14 ; id 105
    db $0c ; id 106
    db $0b ; id 107
    db $0a ; id 108
    db $06 ; id 109
    db $08 ; id 110
    db $07 ; id 111
    db $09 ; id 112
    db $03 ; id 113
    db $03 ; id 114
    db $03 ; id 115
    db $03 ; id 116
    db $1b ; id 117
    db $04 ; id 118
    db $04 ; id 119
    db $04 ; id 120
    db $04 ; id 121
    db $04 ; id 122
    db $04 ; id 123
    db $04 ; id 124
    db $1d ; id 125
    db $1c ; id 126
    db $02 ; id 127
    db $02 ; id 128
    db $05 ; id 129
    db $05 ; id 130
    db $05 ; id 131
    db $bd ; id 132
    db $23 ; id 133
    db $23 ; id 134
    db $23 ; id 135
    db $23 ; id 136
    db $0e ; id 137
    db $12 ; id 138
    db $1f ; id 139
    db $1f ; id 140
    db $20 ; id 141
    db $21 ; id 142
    db $dc ; id 143
    db $22 ; id 144
    db $a8 ; id 145
    db $04 ; id 146
    db $25 ; id 147
    db $2e ; id 148
    db $2d ; id 149
    db $2f ; id 150
    db $2b ; id 151
    db $2c ; id 152
    db $24 ; id 153
    db $24 ; id 154
    db $29 ; id 155
    db $32 ; id 156
    db $30 ; id 157
    db $2a ; id 158
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
    db $dc ; id 170
    db $00 ; id 171
    db $e1 ; id 172
    db $01 ; id 173
    db $01 ; id 174
    db $00 ; id 175
    db $bc ; id 176
    db $ff ; id 177
    db $ff ; id 178
    db $bd ; id 179
    db $be ; id 180
    db $ff ; id 181
    db $ff ; id 182
    db $c0 ; id 183
    db $ff ; id 184
    db $c1 ; id 185
    db $c2 ; id 186
    db $ff ; id 187
    db $ff ; id 188
    db $c4 ; id 189
    db $00 ; id 190
    db $e5 ; id 191
    db $00 ; id 192
    db $00 ; id 193
    db $b6 ; id 194
    db $b7 ; id 195
    db $bb ; id 196
    db $b8 ; id 197
    db $b9 ; id 198
    db $ba ; id 199
    db $d8 ; id 200
    db $e2 ; id 201
    db $e3 ; id 202
    db $e4 ; id 203
    db $0d ; id 204
    db $a9 ; id 205
    db $28 ; id 206
    db $d6 ; id 207
    db $eb ; id 208
    db $ec ; id 209
    db $ed ; id 210
    db $ee ; id 211
    db $ef ; id 212
    db $f0 ; id 213
    db $f1 ; id 214
    db $f2 ; id 215
    db $f3 ; id 216
    db $f4 ; id 217
    db $f5 ; id 218
    db $f6 ; id 219
    db $f7 ; id 220
    db $f8 ; id 221
    db $f9 ; id 222
    db $fa ; id 223
    db $aa ; id 224
    db $ab ; id 225
    db $b2 ; id 226
    db $b4 ; id 227
    db $ff ; id 228
    db $ff ; id 229
    db $ff ; id 230
    db $ff ; id 231

; Item use (RunBattleActions_UseItem_PickTarget and RunBattleActions_UseItem_ShowItemText): D = the
; byte at ActionBattleTextTable2 + wBattleActionId, which holds the item id during item use
; (RunBattleActions_UseItem_PickTarget copies it from wBattleItemId; the table has 64 entries); $FF
; shows nothing, otherwise it jumps to ShowBattleText. (C1, E-0382)
; D = ActionBattleTextTable2[wBattleActionId]; returns at once when it is $FF, otherwise
; ShowBattleText (E-0116)
ShowActionBattleText::
    ld a, [wBattleActionId]
    ld hl, ActionBattleTextTable2
    add_a_to_hl
    ld a, [hl]
    cp $ff
    ret z
    ld d, a
    jp ShowBattleText

; ShowActionBattleText (from RunBattleActions_UseItem) reads the byte at $6EA5 + wBattleActionId
; and, unless it is $FF, passes it to ShowBattleText; 64 bytes end at ShowBattleTextCategory0
; ($6EE5) (E-0210, C1)
; record: battle text index ($FF = none)
ActionBattleTextTable2::
    db $ff ; id 0
    db $9f ; id 1
    db $9f ; id 2
    db $a2 ; id 3
    db $9f ; id 4
    db $9f ; id 5
    db $9f ; id 6
    db $9f ; id 7
    db $9f ; id 8
    db $9f ; id 9
    db $9f ; id 10
    db $a1 ; id 11
    db $9f ; id 12
    db $ff ; id 13
    db $ff ; id 14
    db $ff ; id 15
    db $ff ; id 16
    db $ff ; id 17
    db $ff ; id 18
    db $ff ; id 19
    db $ff ; id 20
    db $ff ; id 21
    db $ff ; id 22
    db $ff ; id 23
    db $ff ; id 24
    db $94 ; id 25
    db $94 ; id 26
    db $94 ; id 27
    db $94 ; id 28
    db $94 ; id 29
    db $97 ; id 30
    db $99 ; id 31
    db $ff ; id 32
    db $ff ; id 33
    db $a5 ; id 34
    db $9b ; id 35
    db $a4 ; id 36
    db $a3 ; id 37
    db $a6 ; id 38
    db $a7 ; id 39
    db $ff ; id 40
    db $ff ; id 41
    db $ff ; id 42
    db $ff ; id 43
    db $ff ; id 44
    db $ff ; id 45
    db $ff ; id 46
    db $ff ; id 47
    db $ff ; id 48
    db $ff ; id 49
    db $ff ; id 50
    db $ff ; id 51
    db $ff ; id 52
    db $ff ; id 53
    db $ff ; id 54
    db $ff ; id 55
    db $97 ; id 56
    db $ff ; id 57
    db $ff ; id 58
    db $ff ; id 59
    db $0d ; id 60
    db $a9 ; id 61
    db $28 ; id 62
    db $d6 ; id 63

; D = battle text number of category 0. Reads the word at BattleTextCategory0HookTable + 2 * D and,
; when it is not $0000, calls the hook it points to (JumpToWordAtHL) so it can fill the name buffers
; wTextBuf0 to wTextBuf2. Then it sets wStringIndex to D and wStringCategory to 0 and starts the
; string with BeginStringDisplay_Bank2F. ShowBattleText does the same for category 1 with
; BattleTextPrepTable. Farcalled from 22 places, among them RunBattleActions_UseItem_ThrowMeat,
; RunBattleActions_UseItem_BeastTail, ApplyTargetBattleWordArray3FReduction and
; InflictStatus0Bit0WithBattleWordArray3FReduction. (C1, E-0382)
; D = message index. The same as ShowBattleText, but it stores 0 in wStringCategory: the entry at
; BattleTextCategory0HookTable + 2 * D is called first when non-zero, then BeginStringDisplay_Bank2F
; shows category 0 (E-0056)
ShowBattleTextCategory0::
    push de
    ld hl, BattleTextCategory0HookTable
    ld c, d
    ld b, $00
    add hl, bc
    add hl, bc
    ld a, [hli]
    or [hl]
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

; ShowBattleTextCategory0 calls the word at $6F06 + 2 * D through JumpToWordAtHL when it is
; non-zero, then shows string D of category 0 with BeginStringDisplay_Bank2F; 256 words end exactly
; at the first target, a bare ret at $7106; most entries are $0000 or point at bare rets (E-0210,
; C1)
; record: routine run before message D ($0000 = none)
BattleTextCategory0HookTable::
    dw BattleText0HookRet ; id 0
    dw BattleText0HookRet ; id 1
    dw BattleText0Hook02 ; id 2
    dw BattleText0HookNoneForTexts3To4 ; id 3
    dw BattleText0HookNoneForTexts3To4 ; id 4
    dw BattleText0Hook05 ; id 5
    dw BattleText0Hook06 ; id 6
    dw BattleText0Hook07 ; id 7
    dw BattleText0HookNoneForTexts8To9 ; id 8
    dw BattleText0HookNoneForTexts8To9 ; id 9
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
    dw BattleText0HookActorAndSkill ; id 54
    dw BattleText0HookActorAndSkill ; id 55
    dw BattleText0HookActorAndSkill ; id 56
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
    dw BattleText0HookActorAndSkillForLaterTexts ; id 69
    dw BattleText0HookActorAndSkillForLaterTexts ; id 70
    dw BattleText0HookActorAndSkillForLaterTexts ; id 71
    dw BattleText0HookActorName ; id 72
    dw BattleText0HookActorAndSkillForLaterTexts ; id 73
    dw BattleText0HookActorAndSkillForLaterTexts ; id 74
    dw BattleText0HookActorAndSkillForLaterTexts ; id 75
    dw BattleText0HookActorAndSkillForLaterTexts ; id 76
    dw BattleText0HookActorAndSkillForLaterTexts ; id 77
    dw BattleText0HookActorAndSkillForLaterTexts ; id 78
    dw BattleText0HookActorAndSkillForLaterTexts ; id 79
    dw BattleText0HookActorAndSkillForLaterTexts ; id 80
    dw BattleText0HookActorName ; id 81
    dw BattleText0HookActorName ; id 82
    dw BattleText0HookActorName ; id 83
    dw BattleText0HookActorName ; id 84
    dw BattleText0HookActorName ; id 85
    dw BattleText0HookActorAndSkillForLaterTexts ; id 86
    dw BattleText0HookActorName ; id 87
    dw BattleText0HookActorName ; id 88
    dw BattleText0HookActorName ; id 89
    dw BattleText0HookActorName ; id 90
    dw BattleText0HookActorName ; id 91
    dw BattleText0HookActorName ; id 92
    dw BattleText0HookActorName ; id 93
    dw BattleText0HookActorAndSkillForLaterTexts ; id 94
    dw BattleText0HookActorAndSkillForLaterTexts ; id 95
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

; A bare ret: the hook of battle texts $00-$01 (category 0, entry of BattleTextCategory0HookTable),
; so ShowBattleTextCategory0 prepares nothing for it and the text uses whatever the caller left in
; the name buffers wTextBuf0 to wTextBuf2. (C2, E-0382)
; bare ret, the hook of messages 0 and 1 (E-0210) (E-0344: the address in its name dropped or read
; as the label there; was BattleText0HookRet)
BattleText0HookRet::
    ret

; A bare ret: the hook of battle text $02 (category 0, entry of BattleTextCategory0HookTable), so
; ShowBattleTextCategory0 prepares nothing for it and the text uses whatever the caller left in the
; name buffers wTextBuf0 to wTextBuf2. (C2, E-0382)
; handler 02 (entry 2 of BattleTextCategory0HookTable) (E-0210)
BattleText0Hook02::
    ret

; A bare ret: the hook of battle texts $03-$04 (category 0, entry of BattleTextCategory0HookTable),
; so ShowBattleTextCategory0 prepares nothing for it and the text uses whatever the caller left in
; the name buffers wTextBuf0 to wTextBuf2. (C2, E-0382)
; bare ret (E-0210) (E-0344: the address in its name dropped or read as the label there; was
; BattleText0HookNoneForTexts3To4)
BattleText0HookNoneForTexts3To4::
    ret

; A bare ret: the hook of battle text $05 (category 0, entry of BattleTextCategory0HookTable), so
; ShowBattleTextCategory0 prepares nothing for it and the text uses whatever the caller left in the
; name buffers wTextBuf0 to wTextBuf2. (C2, E-0382)
; handler 05 (entry 5 of BattleTextCategory0HookTable) (E-0210)
BattleText0Hook05::
    ret

; A bare ret: the hook of battle text $06 (category 0, entry of BattleTextCategory0HookTable), so
; ShowBattleTextCategory0 prepares nothing for it and the text uses whatever the caller left in the
; name buffers wTextBuf0 to wTextBuf2. (C2, E-0382)
; handler 06 (entry 6 of BattleTextCategory0HookTable) (E-0210)
BattleText0Hook06::
    ret

; A bare ret: the hook of battle text $07 (category 0, entry of BattleTextCategory0HookTable), so
; ShowBattleTextCategory0 prepares nothing for it and the text uses whatever the caller left in the
; name buffers wTextBuf0 to wTextBuf2. (C2, E-0382)
; handler 07 (entry 7 of BattleTextCategory0HookTable) (E-0210)
BattleText0Hook07::
    ret

; A bare ret: the hook of battle texts $08-$09 (category 0, entry of BattleTextCategory0HookTable),
; so ShowBattleTextCategory0 prepares nothing for it and the text uses whatever the caller left in
; the name buffers wTextBuf0 to wTextBuf2. (C2, E-0382)
; bare ret (E-0210) (E-0344: the address in its name dropped or read as the label there; was
; BattleText0HookNoneForTexts8To9)
BattleText0HookNoneForTexts8To9::
    ret

; Hook of battle texts $0B-$0C (category 0): calls ListSideMonsterIdsToTemp0 and falls into
; BattleText0Hook0D, which lists the sides again (the second result is the same) and ends with
; WriteTargetNameOrTheMonsters_CountInB. With B = 1 wTextBuf0 gets the name of the target slot;
; otherwise the ids in the list of the target side (wTemp0 for target slots 0-3, wPauseMenuStep for
; 4-7) are compared and wTextBuf0 gets 'Monsters' when all are equal and 'The monsters' when they
; differ. (C2, E-0382)
; ListSideMonsterIdsToTemp0, then falls into BattleText0Hook0D, which lists again and jumps into
; WriteTargetNameOrTheMonsters ($785D) (E-0210)
BattleText0HookListSidesTwice::
    call ListSideMonsterIdsToTemp0

; Hook of battle text $0D (category 0): ListSideMonsterIdsToTemp0 lists the monster ids of the near
; side at wTemp0 and of the far side at wPauseMenuStep and leaves B = the number of present far
; monsters, then jumps to WriteTargetNameOrTheMonsters_CountInB. With B = 1 wTextBuf0 gets the name
; of the target slot; otherwise the ids in the list of the target side (wTemp0 for target slots 0-3,
; wPauseMenuStep for 4-7) are compared and wTextBuf0 gets 'Monsters' when all are equal and 'The
; monsters' when they differ. (C2, E-0382)
; handler 0D (entry 13 of BattleTextCategory0HookTable) (E-0210)
BattleText0Hook0D::
    call ListSideMonsterIdsToTemp0
    jp WriteTargetNameOrTheMonsters_CountInB

; Hook of battle text $0E (category 0): ListSideMonsterIdsToTemp0 lists the monster ids of the near
; side at wTemp0 and of the far side at wPauseMenuStep and leaves B = the number of present far
; monsters, then jumps to CheckAllTargetsSame_CountInB. With B = 1 wTextBuf0 gets the name of the
; target slot; otherwise it gets 'Monsters' whether the ids are equal or not. (C2, E-0382)
; handler 0E (entry 14 of BattleTextCategory0HookTable) (E-0210)
BattleText0Hook0E::
    call ListSideMonsterIdsToTemp0
    jp CheckAllTargetsSame_CountInB

; Hook of 44 battle texts (from $0F) (category 0): copies the name of the actor slot (wBattleActor)
; to wTextBuf0 (CopyActorNameToTextBuf0). (C2, E-0382)
; CopyActorNameToTextBuf0 (44 messages) (E-0210)
BattleText0HookActorName::
    call CopyActorNameToTextBuf0
    ret

; Hook of battle texts $10-$11 (category 0): the name of the actor slot goes to wTextBuf0 and the
; damage word (wBattleDamageLo, wBattleDamageHi) to wTextBuf1 as a decimal number without leading
; zeros (WriteBattleDamageToTextBuf1). (C2, E-0382)
; CopyActorNameToTextBuf0, then WriteBattleDamageToTextBuf1 (E-0210)
BattleText0HookActorNameAndDamage::
    call CopyActorNameToTextBuf0
    call WriteBattleDamageToTextBuf1
    ret

; A bare ret: the hook of battle text $22 (category 0, entry of BattleTextCategory0HookTable), so
; ShowBattleTextCategory0 prepares nothing for it and the text uses whatever the caller left in the
; name buffers wTextBuf0 to wTextBuf2. (C2, E-0382)
; handler 22 (entry 34 of BattleTextCategory0HookTable) (E-0210)
BattleText0Hook22::
    ret

; Hook of battle text $33 (category 0): the name of the target slot goes to wTextBuf0 and the name
; of the slot wDuckBehindSlot to wTextBuf1 (the text says 'ducked behind'; wDuckBehindSlot is the
; ally the target ducked behind). (C2, E-0382)
; handler 33 (entry 51 of BattleTextCategory0HookTable) (E-0210)
BattleText0Hook33::
    call CopyTargetNameToTextBuf0
    ld a, [wDuckBehindSlot]
    ld hl, wTextBuf1
    ld [wNameSlot], a
    call CopySlotNameToHL
    ret

; Hook of battle texts $2A-$2B (category 0): the name of the target slot goes to wTextBuf0; then,
; when entry (wMultiHitCount AND $7F) - 1 of wSpeciesGroups is not $FF and has bit 7 set (a group of
; targets), wTextBuf0 is overwritten with 'Monsters'. (C2, E-0382)
; CopyTargetNameToTextBuf0; then, when wSpeciesGroups[(wMultiHitCount & $7F) - 1] has bit 7 set and
; is not $FF, WriteMonstersWordToTextBuf0 (E-0210)
BattleText0HookTargetNameAndGroupWord::
    call CopyTargetNameToTextBuf0
    ld a, [wMultiHitCount]
    and $7f
    dec a
    ld hl, wSpeciesGroups
    add_a_to_hl
    ld a, [hl]
    cp $ff
    ret z
    bit 7, a
    ret z
    call WriteMonstersWordToTextBuf0
    ret

; Hook of battle texts $36-$38 (category 0): the name of the actor slot goes to wTextBuf0 and the
; name of skill wBattleActionId (string category 4 of bank $08) to wTextBuf1. The texts say 'cast'
; and a skill name, followed by a failure line. (C2, E-0382)
; CopyActorNameToTextBuf0, CopyActionSkillNameToTextBuf1 (E-0210) (E-0344: the address in its name
; dropped or read as the label there; was BattleText0HookActorAndSkill)
BattleText0HookActorAndSkill::
    call CopyActorNameToTextBuf0
    call CopyActionSkillNameToTextBuf1
    ret

; Hook of battle text $3F (category 0): the name of the actor slot goes to wTextBuf0 and the name of
; the target slot to wTextBuf2. (C2, E-0382)
; handler 3F (entry 63 of BattleTextCategory0HookTable) (E-0210)
BattleText0Hook3F::
    call CopyActorNameToTextBuf0
    call CopyTargetNameToTextBuf2
    ret

; Hook of 14 battle texts (from $45) (category 0): the same two calls as
; BattleText0HookActorAndSkill (actor name to wTextBuf0, name of skill wBattleActionId to
; wTextBuf1); a second copy of that code for other texts. (C2, E-0382)
; CopyActorNameToTextBuf0, CopyActionSkillNameToTextBuf1 (the same as $7154) (E-0210) (E-0344: the
; address in its name dropped or read as the label there; was
; BattleText0HookActorAndSkillForLaterTexts)
BattleText0HookActorAndSkillForLaterTexts::
    call CopyActorNameToTextBuf0
    call CopyActionSkillNameToTextBuf1
    ret

; Hook of battle texts $66-$7A (category 0): the name of the actor slot goes to wTextBuf0 and the
; name of the slot ActorFormationSlotToTemp0 maps the actor to (its formation partner) to wTextBuf1.
; The texts name two monsters and say that they tried something. (C2, E-0382)
; CopyActorNameToTextBuf0, CopyMappedSlotNameToTextBuf1 (21 messages) (E-0210)
BattleText0HookActorAndMappedSlot::
    call CopyActorNameToTextBuf0
    call CopyMappedSlotNameToTextBuf1
    ret

; Hook of battle text $7E (category 0): when the target slot is 3 or more and exactly one monster is
; present on the far side (ListSideMonsterIdsToTemp0 gives B = 1), the name of the target slot goes
; to wTextBuf0; for a target slot below 3 or more far monsters nothing is changed. The same code is
; BattleTextPrepE6. (C2, E-0382)
; handler 7E (entry 126 of BattleTextCategory0HookTable) (E-0210)
BattleText0Hook7E::
    ld a, [wBattleTarget]
    cp $03
    jr c, .return
    call ListSideMonsterIdsToTemp0
    ld a, b
    cp $01
    jr nz, .return
    call CopyTargetNameToTextBuf0

.return:
    ret

; Hook of battle texts $80-$81 (category 0): the name of the target slot goes to wTextBuf0 and the
; name of the slot wOriginalTarget (the slot first targeted before the attack was moved) to
; wTextBuf1. (C2, E-0382)
; CopyTargetNameToTextBuf0, then the name of slot wOriginalTarget into wTextBuf1 (E-0210, E-0337)
BattleText0HookTargetAndDefeatSlot::
    call CopyTargetNameToTextBuf0
    ld a, [wOriginalTarget]
    ld hl, wTextBuf1
    ld [wNameSlot], a
    call CopySlotNameToHL
    ret

; D = battle text index: calls the text's prep routine from BattleTextPrepTable when its entry is
; not zero, then shows string D of category 1 (bank $2F, BeginStringDisplay_Bank2F). (C1, E-0357)
ShowBattleText::
    push de
    ld hl, BattleTextPrepTable
    ld c, d
    ld b, $00
    add hl, bc
    add hl, bc
    ld a, [hli]
    or [hl]
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

; ShowBattleText reads the word $71B4 + 2 * D and, when it is non-zero, calls it (JumpToWordAtHL)
; before showing string D of category 1 from bank $2F; 256 words up to the first routine at $73B4;
; 211 are non-zero (E-0180, C1)
; record: routine run before battle text D ($0000 = none)
BattleTextPrepTable::
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

; Prep of 61 battle texts (from $00) (category 1): copies the name of the actor slot to wTextBuf0
; (CopyActorNameToTextBuf0). Used by the plain 'attacked!' kind of texts. (C2, E-0382)
; prepares the arguments of battle text 00 (entry 0 of BattleTextPrepTable) (E-0180)
BattleTextPrep00::
    call CopyActorNameToTextBuf0
    ret

; Prep of battle text $E6 (category 1): when the target slot is 3 or more and exactly one monster is
; present on the far side (ListSideMonsterIdsToTemp0 gives B = 1), the name of the target slot goes
; to wTextBuf0; otherwise nothing changes (the item code has already named the targets with
; NameTargetsInTextBuf0). The same code as BattleText0Hook7E. (C2, E-0382)
; prepares the arguments of battle text E6 (entry 230 of BattleTextPrepTable) (E-0180)
BattleTextPrepE6::
    ld a, [wBattleTarget]
    cp $03
    jr c, .return
    call ListSideMonsterIdsToTemp0
    ld a, b
    cp $01
    jr nz, .return
    call CopyTargetNameToTextBuf0

.return:
    ret

; Prep of battle texts $01-$05, $24, $E3-$E5 (category 1): the name of the actor slot goes to
; wTextBuf0 and the name of skill wBattleActionId to wTextBuf1 (text $01 says 'cast' after the actor
; name). (C2, E-0382)
; prepares the arguments of battle text 01 (entry 1 of BattleTextPrepTable) (E-0180)
BattleTextPrep01::
    call CopyActorNameToTextBuf0
    call CopyActionSkillNameToTextBuf1
    ret

; Prep of 14 battle texts (from $06) (category 1): the name of the actor slot goes to wTextBuf0 and
; the name of the target slot to wTextBuf1 (text $06 says 'closed in on'). (C2, E-0382)
; prepares the arguments of battle text 06 (entry 6 of BattleTextPrepTable) (E-0180)
BattleTextPrep06::
    call CopyActorNameToTextBuf0
    call CopyTargetNameToTextBuf1
    ret

; Prep of 17 battle texts (from $35) (category 1): the name of the target slot goes to wTextBuf0 and
; the damage word (wBattleDamageLo, wBattleDamageHi) to wTextBuf1 as a decimal number (text $35 says
; 'took' and 'damage!'). (C2, E-0382)
; prepares the arguments of battle text 35 (entry 53 of BattleTextPrepTable) (E-0180)
BattleTextPrep35::
    call CopyTargetNameToTextBuf0
    call WriteBattleDamageToTextBuf1
    ret

; Prep of 88 battle texts (from $37) (category 1): copies the name of the target slot to wTextBuf0
; (CopyTargetNameToTextBuf0). (C2, E-0382)
; prepares the arguments of battle text 37 (entry 55 of BattleTextPrepTable) (E-0180)
BattleTextPrep37::
    call CopyTargetNameToTextBuf0
    ret

; Prep of battle text $B8 (category 1): the name of the actor slot goes to wTextBuf0. Then it takes
; the first present slot among the three slots of the other side (starting at slot 4 for a near
; actor, at slot 0 for a far one) and puts its name in wTextBuf1. Finally it sets wBattleTarget to
; wBattleActor, so the target is the actor afterwards. The text says 'charged at' and 'But tripped
; and wiped out!'. (C2, E-0382)
; prepares the arguments of battle text B8 (entry 184 of BattleTextPrepTable) (E-0180)
BattleTextPrepB8::
    call CopyActorNameToTextBuf0
    ld a, [wBattleActor]
    and $04
    xor $04
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

; Prep of battle text $21 (category 1): the name of the actor slot goes to wTextBuf1. For an actor
; on the near side (slot below 4; reversed in a link battle for the follower) outside link mode 1 it
; names the targets in wTextBuf0 with NameTargetsInTextBuf0_CountInB (B = the far monster count); in
; link mode 1 it leaves wTextBuf0 alone. For a far actor wTextBuf0 gets the target name when exactly
; one monster is present on the near side and 'Monsters' otherwise (CopyTargetOrSideNameToTextBuf0).
; (C2, E-0382)
; prepares the arguments of battle text 21 (entry 33 of BattleTextPrepTable) (E-0180)
BattleTextPrep21::
    call CopyActorNameToTextBuf1
    call ListSideMonsterIdsToTemp0
    call ActorOnLocalSide_Bank3A
    jr c, .check_link_mode
    jp CopyTargetOrSideNameToTextBuf0

.check_link_mode:
    ld a, [wLinkMode]
    or a
    jp z, NameTargetsInTextBuf0_CountInB
    cp $02
    jp z, NameTargetsInTextBuf0_CountInB
    ret

; Prep of battle text $0F (category 1): the name of the actor slot goes to wTextBuf1. In link mode 1
; wTextBuf0 becomes 'Monsters' (CopyTargetOrSideNameToTextBuf0_Side). Otherwise, for a target on the
; near side wTextBuf0 gets the target name when exactly one monster is present on the near side and
; 'Monsters' otherwise (CopyTargetOrSideNameToTextBuf0); for a far target
; NameTargetsInTextBuf0_CountInB names the far targets. (C2, E-0382)
; prepares the arguments of battle text 0F (entry 15 of BattleTextPrepTable) (E-0180)
BattleTextPrep0F::
    call CopyActorNameToTextBuf1
    ld a, [wLinkMode]
    cp $01
    jp z, CopyTargetOrSideNameToTextBuf0_Side
    call ListSideMonsterIdsToTemp0
    call TargetOnLocalSide_Bank3A
    jp c, CopyTargetOrSideNameToTextBuf0
    jp NameTargetsInTextBuf0_CountInB

; Prep of battle text $BE (category 1): the name of the actor slot goes to wTextBuf0. Then the
; number of monsters on the actor side (near side count for a near actor, far side count for a far
; actor) decides: exactly one makes wTextBuf0 read the actor name followed by ' was', otherwise it
; reads 'Monsters were'. The text continues 'filled with power!'. (C2, E-0382)
; prepares the arguments of battle text BE (entry 190 of BattleTextPrepTable) (E-0180)
BattleTextPrepBE::
    call CopyActorNameToTextBuf0
    call ListSideMonsterIdsToTemp0
    call ActorOnLocalSide_Bank3A
    ld a, e
    jr c, .cp_01
    ld a, b

.cp_01:
    cp $01
    jr nz, .call_copy_target_or_side_name_to_text_buf0
    ld hl, wTextBuf0

.loop:
    ld a, [hli]
    cp $f0
    jr nz, .loop
    dec hl
    ld a, $90
    ld [hli], a
    ld a, $3a
    ld [hli], a
    ld a, $24
    ld [hli], a
    ld a, $36
    ld [hli], a
    ld a, $f0
    ld [hl], a
    ret

.call_copy_target_or_side_name_to_text_buf0:
    call CopyTargetOrSideNameToTextBuf0_Monsters
    ld a, $90
    ld [hli], a
    ld a, $3a
    ld [hli], a
    ld a, $28
    ld [hli], a
    ld a, $35
    ld [hli], a
    ld a, $28
    ld [hli], a
    ld a, $f0
    ld [hl], a
    ret

; Prep of battle text $4D (category 1): for a target on the near side wTextBuf0 gets the target name
; when exactly one monster is present on the near side and 'Monsters' otherwise; for a far target in
; link mode 1 it gets 'Monsters'; for a far target outside a link battle
; NameTargetsInTextBuf0_CountInB names the far targets. (C2, E-0382)
; prepares the arguments of battle text 4D (entry 77 of BattleTextPrepTable) (E-0180)
BattleTextPrep4D::
    call ListSideMonsterIdsToTemp0
    call TargetOnLocalSide_Bank3A
    jp c, CopyTargetOrSideNameToTextBuf0
    ld a, [wLinkMode]
    cp $01
    jp z, CopyTargetOrSideNameToTextBuf0_Side
    jp NameTargetsInTextBuf0_CountInB

; Prep of battle texts $61, $7F (category 1): copies the name of the target slot to wTextBuf0 (text
; $61 says 'joined the battle!'). (C2, E-0382)
; prepares the arguments of battle text 61 (entry 97 of BattleTextPrepTable) (E-0180)
BattleTextPrep61::
    call CopyTargetNameToTextBuf0
    ret

; Prep of battle text $7E (category 1): the name of the target slot goes to wTextBuf0 and the name
; of skill wBattleActionId to wTextBuf1 (text $7E says 'blew back'). (C2, E-0382)
; prepares the arguments of battle text 7E (entry 126 of BattleTextPrepTable) (E-0180)
BattleTextPrep7E::
    call CopyTargetNameToTextBuf0
    call CopyActionSkillNameToTextBuf1
    ret

; Prep of battle text $87 (category 1): the name of item wBattleActionId (string category 5 of bank
; $08) goes to wTextBuf2 (the text says 'shattered!'). (C2, E-0382)
; prepares the arguments of battle text 87 (entry 135 of BattleTextPrepTable) (E-0180)
BattleTextPrep87::
    call CopyActionItemNameToTextBuf2
    ret

; Prep of battle text $A0 (category 1): the name of the player (wPlayerName) goes to wTextBuf0, the
; name of the target slot to wTextBuf1 and the name of item wBattleActionId to wTextBuf2 (the text
; says 'tossed' and 'at'). (C2, E-0382)
; prepares the arguments of battle text A0 (entry 160 of BattleTextPrepTable) (E-0180)
BattleTextPrepA0::
    call CopyPlayerNameToTextBuf0
    call CopyTargetNameToTextBuf1
    call CopyActionItemNameToTextBuf2
    ret

; Prep of battle text $94 (category 1): the player name goes to wTextBuf1 and the name of item
; wBattleActionId to wTextBuf2. For a target on the near side wTextBuf0 gets the target name; for a
; far target NameTargetsInTextBuf0_CountInB names the far targets in wTextBuf0
; (ListSideMonsterIdsToTemp0 supplies the count). (C2, E-0382)
; prepares the arguments of battle text 94 (entry 148 of BattleTextPrepTable) (E-0180)
BattleTextPrep94::
    call CopyPlayerNameToTextBuf1
    call CopyActionItemNameToTextBuf2
    call ListSideMonsterIdsToTemp0
    call TargetOnLocalSide_Bank3A
    jp nc, NameTargetsInTextBuf0_CountInB
    call CopyTargetNameToTextBuf0
    ret

; Prep of battle texts $95-$96, $FD-$FE (category 1): the player name goes to wTextBuf1. For a
; target on the near side wTextBuf0 gets the target name; for a far target
; NameTargetsInTextBuf0_CountInB names the far targets in wTextBuf0. (C2, E-0382)
; prepares the arguments of battle text 95 (entry 149 of BattleTextPrepTable) (E-0180)
BattleTextPrep95::
    call CopyPlayerNameToTextBuf1
    call ListSideMonsterIdsToTemp0
    call TargetOnLocalSide_Bank3A
    jp nc, NameTargetsInTextBuf0_CountInB
    call CopyTargetNameToTextBuf0
    ret

; Prep of 8 battle texts (from $97) (category 1): the player name goes to wTextBuf0 and the name of
; item wBattleActionId to wTextBuf2. (C2, E-0382)
; prepares the arguments of battle text 97 (entry 151 of BattleTextPrepTable) (E-0180)
BattleTextPrep97::
    call CopyPlayerNameToTextBuf0
    call CopyActionItemNameToTextBuf2
    ret

; Prep of battle texts $99, $A1-$A2 (category 1): the player name (wPlayerName, five glyphs) goes to
; wTextBuf0. (C2, E-0382)
; prepares the arguments of battle text 99 (entry 153 of BattleTextPrepTable) (E-0180)
BattleTextPrep99::
    call CopyPlayerNameToTextBuf0
    ret

; Prep of battle text $92 (category 1): the name of skill number wSealPrayState (string category 4
; of bank $08) goes to wTextBuf1 (the text says 'was broken!'). (C2, E-0382)
; prepares the arguments of battle text 92 (entry 146 of BattleTextPrepTable) (E-0180)
BattleTextPrep92::
    ld a, [wSealPrayState]
    ld l, a
    ld h, $04
    ld de, wTextBuf1
    call CopyStringHLToDE
    ret

; Prep of battle text $B0 (category 1): the name of skill wBattleActionId goes to wTextBuf1. (C2,
; E-0382)
; prepares the arguments of battle text B0 (entry 176 of BattleTextPrepTable) (E-0180)
BattleTextPrepB0::
    call CopyActionSkillNameToTextBuf1
    ret

; Prep of battle text $CA (category 1): the name of the target slot goes to wTextBuf0 and the name
; of the slot wOriginalTarget to wTextBuf1 (the text says 'guarded'). (C2, E-0382)
; prepares the arguments of battle text CA (entry 202 of BattleTextPrepTable) (E-0180)
BattleTextPrepCA::
    call CopyTargetNameToTextBuf0
    ld a, [wOriginalTarget]
    ld hl, wTextBuf1
    ld [wNameSlot], a
    call CopySlotNameToHL
    ret

; Prep of 19 battle texts (from $AA) (category 1): the name of the actor slot goes to wTextBuf0 and
; the name of the formation-mapped slot (CopyMappedSlotNameToTextBuf1) to wTextBuf1. (C2, E-0382)
; prepares the arguments of battle text AA (entry 170 of BattleTextPrepTable) (E-0180)
BattleTextPrepAA::
    call CopyActorNameToTextBuf0
    call CopyMappedSlotNameToTextBuf1
    ret

; Prep of battle text $F2 (category 1): the name of the target slot goes to wTextBuf2, the name of
; the actor slot to wTextBuf0 and the name of the formation-mapped slot to wTextBuf1 (the text says
; 'hurled' and 'high and dropped it!'). (C2, E-0382)
; prepares the arguments of battle text F2 (entry 242 of BattleTextPrepTable) (E-0180)
BattleTextPrepF2::
    call CopyTargetNameToTextBuf2
    call CopyActorNameToTextBuf0
    call CopyMappedSlotNameToTextBuf1
    ret

; D = reason 1-6 why the action could not be used (the callers pass the D that CheckSkillMPCost
; returns: 1 not enough MP, 2 the action matches wQueuedActionId, 3-6 the seal checks; the seal-pray
; check passes 2). It first fills the name buffers: for an action below ACTION_D0 it clears
; wSavedActorSlot, puts the actor name in wTextBuf0, the skill name in wTextBuf1 and the name of the
; slot in wBattleTargetChoice of the actor in wTextBuf2; for ACTION_D0 and above it sets
; wSavedActorSlot to 1 and puts the actor name in wTextBuf0 and the name of the formation partner in
; wTextBuf1. Then it picks a string of category 0 of bank $2F and shows it with
; BeginStringDisplay_Bank2F, unless the string number is $FF. D = 3, 4 and 6 give $49, $4C and $4B
; when wSavedActorSlot bit 0 is clear, otherwise the entry of BuildActionMessageNames_Data1,
; BuildActionMessageNames_Data3 or BuildActionMessageNames_Data2 for action - $D0; D = 5 gives $4A;
; other D index BuildActionMessageNames_Data5 (D = 1) or BuildActionMessageNames_Data6 by the kind
; in BuildActionMessageNames_Data4[action]. (C1, E-0382)
; copies the actor, skill and target names to wTextBuf0/wTextBuf1/wTextBuf2 and picks the action
; message from BuildActionMessageNames_Data4 (or special messages $49-$4C) (E-0129)
ShowActionRefusedMessage::
    push de
    ld a, [wBattleActionId]
    cp ACTION_D0
    jr nc, .set_saved_actor_slot_to_01
    xor a
    ld [wSavedActorSlot], a
    call CopyActorNameToTextBuf0
    call CopyActionSkillNameToTextBuf1
    ld a, [wBattleActor]
    ld hl, wBattleTargetChoice
    add a
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
    cp $03
    jp z, .check_saved_actor_slot
    cp $04
    jp z, .check_saved_actor_slot3
    cp $05
    jp z, .skip3
    cp $06
    jp z, .check_saved_actor_slot2
    ld a, [wBattleActionId]
    ld hl, BuildActionMessageNames_Data4
    add_a_to_hl
    ld a, [hl]
    ld hl, BuildActionMessageNames_Data5
    dec d
    jr z, .skip
    ld hl, BuildActionMessageNames_Data6

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
    ld hl, BuildActionMessageNames_Data1
    jr .read_battle_action_id

.skip3:
    ld a, $4a
    jr .loop

.check_saved_actor_slot2:
    ld a, [wSavedActorSlot]
    bit 0, a
    jr nz, .skip4
    ld a, $4b
    jr .loop

.skip4:
    ld hl, BuildActionMessageNames_Data2
    jr .read_battle_action_id

.check_saved_actor_slot3:
    ld a, [wSavedActorSlot]
    bit 0, a
    jr nz, .skip5
    ld a, $4c
    jr .loop

.skip5:
    ld hl, BuildActionMessageNames_Data3
    jr .read_battle_action_id

.loop:
    cp $ff
    jr z, .return
    ld [wStringIndex], a
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F

.return:
    ret

.read_battle_action_id:
    ld a, [wBattleActionId]
    sub $d0
    add_a_to_hl
    ld a, [hl]
    cp $ff
    jr nz, .loop
    ret

; Twenty string ids for battle text ids (category 0 of BeginStringDisplay_Bank2F), one per action id
; $D0 to $E3 (index wBattleActionId - $D0); $FF means no message. For example $6C, $6E, $FF, $FF,
; $FF, $FF, $70, $FF, $80, $72, ..., $81. ShowActionRefusedMessage uses it when D is 3 and
; wBattleActionId is $D0 or more (wSavedActorSlot bit 0 set); Data3 is the parallel list for D = 4
; and Data2 for D = 6. (C1, E-0381)
BuildActionMessageNames_Data1::
    db $6c, $6e, $ff, $ff, $ff, $ff, $70, $ff, $80, $72, $ff, $ff, $76, $ff, $ff, $78
    db $ff, $81, $ff, $ff

; Twenty string ids for battle text ids (category 0 of BeginStringDisplay_Bank2F), one per action id
; $D0 to $E3 (index wBattleActionId - $D0): $FF everywhere except $74, $75 (ids $DA and $DB), $82,
; $83 (ids $DE and $DF) and $7A (id $E1). ShowActionRefusedMessage uses it when D is 6 and
; wSavedActorSlot bit 0 is set; $FF means no message. (C1, E-0381)
BuildActionMessageNames_Data2::
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $74, $75, $ff, $ff, $82, $83
    db $ff, $7a, $ff, $ff

; Twenty string ids for battle text ids (category 0 of BeginStringDisplay_Bank2F), one per action id
; $D0 to $E3 (index wBattleActionId - $D0): $6D, $6F, $FF, $FF, $FF, $FF, $71, $FF, $84, $73, $FF,
; $FF, $77, $FF, $FF, $79, $FF, $85, $FF, $FF. It pairs entry by entry with
; BuildActionMessageNames_Data1, which is used when D is 3; ShowActionRefusedMessage uses this one
; when D is 4 and wSavedActorSlot bit 0 is set. $FF means no message. (C1, E-0381)
BuildActionMessageNames_Data3::
    db $6d, $6f, $ff, $ff, $ff, $ff, $71, $ff, $84, $73, $ff, $ff, $77, $ff, $ff, $79
    db $ff, $85, $ff, $ff

; 228 bytes, one per action id $00 to $E3, each a message kind $00 to $16 used as the index into
; BuildActionMessageNames_Data5 or BuildActionMessageNames_Data6. Kind 0 for ids $00-$3C and
; $A2-$CF; kind 4 for $3D-$3F, $48-$49, $7E-$84, $91, $99-$9A; kind 1 for $40-$47 and $71-$74; kind
; 2 for $76-$7D; kind 3 for most of $50-$98; single ids with their own kinds ($4A, $4C, $4D, $4E,
; $4F, $68, $69, $6A, $75, $89, $93, $9B, $9C, $9D, $A0, $A1); $14 for $D0, $D1 and $DC; $15 for
; most of $D2-$E3; $16 for $D9. (C1, E-0381)
BuildActionMessageNames_Data4::
    ds $3d, $00
    db $04, $04, $04, $01, $01, $01, $01, $01, $01, $01, $01, $04, $04, $11, $03, $10
    db $11, $06, $07
    ds $18, $03
    db $13, $08, $05, $03, $03, $03, $03, $03, $03, $01, $01, $01, $01, $09, $02, $02
    db $02, $02, $02, $02, $02, $02, $04, $04, $04, $04, $04, $04, $04, $03, $03, $03
    db $03, $12, $03, $03, $03, $03, $03, $03, $03, $04, $03, $0b, $03, $03, $03, $03
    db $03, $04, $04, $0d, $0f, $0a, $03, $03, $0c, $0e
    ds $2e, $00
    db $14, $14, $15, $15, $15, $15, $15, $15, $15, $16, $15, $15, $14, $15, $15, $15
    db $15, $15, $15, $15

; Twenty-three string ids for battle text ids (category 0 of BeginStringDisplay_Bank2F), indexed by
; the message kind from BuildActionMessageNames_Data4: $36 $37 $38 $46 $47 $39 $3A $3B $3C $3D $3E
; $3F $40 $41 $42 $43 $44 $45 $48 $FF $69 $6A $6B ($FF means no message). ShowActionRefusedMessage
; uses this list when D is 1. (C1, E-0381)
BuildActionMessageNames_Data5::
    db $36, $37, $38, $46, $47, $39, $3a, $3b, $3c, $3d, $3e, $3f, $40, $41, $42, $43
    db $44, $45, $48, $ff, $69, $6a, $6b

; Twenty-three string ids for battle text ids (category 0 of BeginStringDisplay_Bank2F), indexed by
; the message kind from BuildActionMessageNames_Data4: $4D $4F $56 $4E $50 $55 $51 $52 $54 $5F $5A
; $58 $5B $59 $5C $FF $4D $4E $57 $53 $FF $FF $FF ($FF means no message). ShowActionRefusedMessage
; uses this list when D is not 1 and not 3 to 6. (C1, E-0381)
BuildActionMessageNames_Data6::
    db $4d, $4f, $56, $4e, $50, $55, $51, $52, $54, $5f, $5a, $58, $5b, $59, $5c, $ff
    db $4d, $4e, $57, $53, $ff, $ff, $ff

; For the special actions $D0-$E3: puts the actor name in wTextBuf0 and the name of the
; formation-mapped slot in wTextBuf1, then shows string
; ShowSpecialActionMessage_Data[wBattleActionId - $D0] of category 0 of bank $2F ($66, $67 or $68:
; 'tried casting a spell!', 'tried using a skill!' or 'tried to use magic!') with
; BeginStringDisplay_Bank2F. (C1, E-0382)
; CopyActorNameToTextBuf0 and CopyMappedSlotNameToTextBuf1, then shows string
; ShowSpecialActionMessage_Data[wBattleActionId - $D0] of category 0 (BeginStringDisplay_Bank2F);
; used for the $D0+ special actions (E-0118)
ShowSpecialActionMessage::
    call CopyActorNameToTextBuf0
    call CopyMappedSlotNameToTextBuf1
    ld a, [wBattleActionId]
    sub $d0
    ld hl, ShowSpecialActionMessage_Data
    add_a_to_hl
    ld a, [hl]
    ld [wStringIndex], a
    ld a, $00
    ld [wStringCategory], a
    farcall BeginStringDisplay_Bank2F
    ret

; Twenty one-byte string indexes, one per special battle action $D0-$E3 (index wBattleActionId -
; $D0), in string category 0 of bank $2F: $66 (entries 0, 1 and 12) is "<BUF0> and <BUF1> tried
; casting a spell! But it failed!", $67 (most entries) says "using a skill" instead and $68 (entry
; 9) "to use magic". ShowSpecialActionMessage copies the actor and mapped-slot names into wTextBuf0
; and wTextBuf1, loads the byte into wStringIndex and shows it. (C1, E-0381)
ShowSpecialActionMessage_Data::
    db $66, $66, $67, $67, $67, $67, $67, $67, $67, $68, $67, $67, $66, $67, $67, $67
    db $67, $67, $67, $67

; B = hTemp0 (CallWithBattleFoeCount sets hTemp0 to wBattleFoeCount), then
; NameTargetsInTextBuf0_CountInB names the targets in wTextBuf0: the target name for one, 'Monsters'
; for more. Far-called by CallWithBattleFoeCount. (C2, E-0382)
NameTargetsInTextBuf0::
    ldh a, [hTemp0]
    ld b, a

; B = the number of targets: for one, wTextBuf0 = the target's name (CopyTargetNameToTextBuf0). For
; more it counts the equal pairs among the B monster-id words of the target's side (wTemp0 for
; wBattleTarget slots 0-3, wPauseMenuStep for 4-7, as ListSideMonsterIdsToTemp0 lists them;
; wBattleStatResultLo is the counter) and writes 'Monsters' either way: when all are equal the name
; is copied first and then overwritten (CopyTargetOrSideNameToTextBuf0_Monsters). Reached by jumps
; from BattleTextPrep21, BattleTextPrep0F, BattleTextPrep4D, BattleTextPrep94 and BattleTextPrep95.
; (C2, E-0371; probed E-0382)
NameTargetsInTextBuf0_CountInB::
    ld a, b
    cp $01
    jr z, CopyTargetOrSideNameToTextBuf0_Target
    xor a
    ld [wBattleStatResultLo], a
    ld a, [wBattleTarget]
    bit 2, a
    ld hl, wTemp0
    jr z, .skip
    ld hl, wPauseMenuStep

.skip:
    ld a, b
    sub $01
    ld e, a
    ld d, $01

.loop:
    ld a, b
    sub d
    ld c, a
    push hl
    push de
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a

.loop2:
    ld a, e
    cp [hl]
    inc hl
    jr nz, .next
    ld a, d
    cp [hl]
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
    cp l
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
    ld [hl], $f0
    ret

.call_copy_target_name_to_text_buf0:
    call CopyTargetNameToTextBuf0
    jr CopyTargetOrSideNameToTextBuf0_Monsters

; E = 1: copies the name of the target slot to wTextBuf0 (CopyTargetOrSideNameToTextBuf0_Target).
; Any other E: copies the name of the first slot of the target side and then writes 'Monsters' over
; it, so wTextBuf0 reads 'Monsters' (CopyTargetOrSideNameToTextBuf0_Side). E is the count of present
; monsters on the near side left by ListSideMonsterIdsToTemp0; BattleTextPrep21, BattleTextPrep0F
; and BattleTextPrep4D jump here. (C2, E-0382)
; E = 1: copies the target's name to wTextBuf0; otherwise the target side's name followed by the
; word 'monsters' (E-0122) (E-0344: the address in its name dropped or read as the label there; was
; CopyTargetOrSideNameToTextBuf0)
CopyTargetOrSideNameToTextBuf0::
    ld a, e
    cp $01
    jr z, CopyTargetOrSideNameToTextBuf0_Target

; Copies the target side's name, then 'Monsters' over it in wTextBuf0. (C2, E-0357; probed E-0382)
CopyTargetOrSideNameToTextBuf0_Side::
    call CopyTargetSideNameToTextBuf0

; Writes 'Monsters' into wTextBuf0. (C2, E-0357; probed E-0382)
CopyTargetOrSideNameToTextBuf0_Monsters::
    call WriteMonstersWordToTextBuf0
    ret

; Copies the target's name into wTextBuf0. (C2, E-0357; probed E-0382)
CopyTargetOrSideNameToTextBuf0_Target::
    call CopyTargetNameToTextBuf0
    ret

; B = hTemp0, then CheckAllTargetsSame_CountInB. The same code as NameTargetsInTextBuf0; no call to
; this entry was found in src/ (BattleText0Hook0E jumps to CheckAllTargetsSame_CountInB). (C2,
; E-0382)
; counts equal pairs among the hTemp0 target words at wTemp0 (or wPauseMenuStep for the foe side);
; when not all are equal writes a message to wTextBuf0 (E-0128)
CheckAllTargetsSame:: ; configured code entry (E-0210); C0
    ldh a, [hTemp0]
    ld b, a

; Names the targets in wTextBuf0: one gives its name; two or more give 'Monsters' (the all-same case
; copies the name and then overwrites it). (C2, E-0357; probed E-0382)
CheckAllTargetsSame_CountInB::
    ld a, b
    cp $01
    jr z, CheckAllTargetsSame_Target
    xor a
    ld [wBattleStatResultLo], a
    ld a, [wBattleTarget]
    bit 2, a
    ld hl, wTemp0
    jr z, .skip
    ld hl, wPauseMenuStep

.skip:
    ld a, b
    sub $01
    ld e, a
    ld d, $01

.loop:
    ld a, b
    sub d
    ld c, a
    push hl
    push de
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a

.loop2:
    ld a, e
    cp [hl]
    inc hl
    jr nz, .next
    ld a, d
    cp [hl]
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
    cp l
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
    ld [hl], $f0
    ret

.call_copy_target_name_to_text_buf0:
    call CopyTargetNameToTextBuf0
    jr CheckAllTargetsSame_Monsters

; E = 1: copies the name of the target slot to wTextBuf0; any other E: copies the first slot name of
; the target side and then writes 'Monsters' over it. It is the copy of
; CopyTargetOrSideNameToTextBuf0 inside the block of CheckAllTargetsSame; nothing jumps to it (the
; block is reached through CheckAllTargetsSame_CountInB). (C2, E-0382)
; E = 1: copies the target's name to wTextBuf0; otherwise the target side's name followed by the
; word 'monsters' (E-0122) (E-0344: the address in its name dropped or read as the label there; was
; CheckAllTargetsSame_SideOrTarget)
CheckAllTargetsSame_SideOrTarget::
    ld a, e
    cp $01
    jr z, CheckAllTargetsSame_Target
    call CopyTargetSideNameToTextBuf0

; Writes 'Monsters' into wTextBuf0. (C2, E-0357; probed E-0382)
CheckAllTargetsSame_Monsters::
    call WriteMonstersWordToTextBuf0
    ret

; Copies the target's name into wTextBuf0. (C2, E-0357; probed E-0382)
CheckAllTargetsSame_Target::
    call CopyTargetNameToTextBuf0
    ret

; B = hTemp0, then WriteTargetNameOrTheMonsters_CountInB. No call to this entry was found in src/
; (BattleText0Hook0D and BattleText0HookListSidesTwice jump to
; WriteTargetNameOrTheMonsters_CountInB). (C2, E-0382)
; when the hTemp0 targets are all the same, copies the target name to wTextBuf0; otherwise writes
; "The monsters" (E-0129)
WriteTargetNameOrTheMonsters:: ; configured code entry (E-0210); C0
    ldh a, [hTemp0]
    ld b, a

; Names the targets in wTextBuf0: one gives its name; mixed species give 'The monsters'; all the
; same give 'Monsters' (the name copy is overwritten). (C2, E-0357; probed E-0382)
WriteTargetNameOrTheMonsters_CountInB::
    ld a, b
    cp $01
    jp z, WriteTargetNameOrTheMonsters_Target
    xor a
    ld [wBattleStatResultLo], a
    ld a, [wBattleTarget]
    bit 2, a
    ld hl, wTemp0
    jr z, .skip
    ld hl, wPauseMenuStep

.skip:
    ld a, b
    sub $01
    ld e, a
    ld d, $01

.loop:
    ld a, b
    sub d
    ld c, a
    push hl
    push de
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a

.loop2:
    ld a, e
    cp [hl]
    inc hl
    jr nz, .next
    ld a, d
    cp [hl]
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
    cp l
    jr z, .call_copy_target_name_to_text_buf0
    ld hl, wTextBuf0
    ld [hl], $1d
    inc hl
    ld [hl], $2b
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
    ld [hl], $f0
    ret

.call_copy_target_name_to_text_buf0:
    call CopyTargetNameToTextBuf0
    jr WriteTargetNameOrTheMonsters_Monsters

; E = 1: copies the name of the target slot to wTextBuf0; any other E: copies the first slot name of
; the target side and then writes 'Monsters' over it. It is the copy of
; CopyTargetOrSideNameToTextBuf0 inside the block of WriteTargetNameOrTheMonsters; nothing jumps to
; it. (C2, E-0382)
; E = 1: copies the target's name to wTextBuf0; otherwise the target side's name followed by the
; word 'monsters' (E-0122) (E-0344: the address in its name dropped or read as the label there; was
; WriteTargetNameOrTheMonsters_SideOrTarget)
WriteTargetNameOrTheMonsters_SideOrTarget::
    ld a, e
    cp $01
    jr z, WriteTargetNameOrTheMonsters_Target
    call CopyTargetSideNameToTextBuf0

; Writes 'Monsters' into wTextBuf0. (C2, E-0357; probed E-0382)
WriteTargetNameOrTheMonsters_Monsters::
    call WriteMonstersWordToTextBuf0
    ret

; Copies the target's name into wTextBuf0. (C2, E-0357; probed E-0382)
WriteTargetNameOrTheMonsters_Target::
    call CopyTargetNameToTextBuf0
    ret

; wNameSlot = wBattleActor, then CopySlotNameToHL with HL = wTextBuf0 (E-0113)
CopyActorNameToTextBuf0::
    ld a, [wBattleActor]
    ld hl, wTextBuf0
    ld [wNameSlot], a
    call CopySlotNameToHL
    ret

; wNameSlot = wBattleActor, then CopySlotNameToHL with HL = wTextBuf1 (E-0116)
CopyActorNameToTextBuf1::
    ld a, [wBattleActor]
    ld hl, wTextBuf1
    ld [wNameSlot], a
    call CopySlotNameToHL
    ret

; far-calls ActorFormationSlotToTemp0 (which maps the actor to a slot in hTemp0), then copies that
; slot's name to wTextBuf1 (CopySlotNameToHL) (E-0113)
CopyMappedSlotNameToTextBuf1::
    farcall ActorFormationSlotToTemp0
    ldh a, [hTemp0]
    ld hl, wTextBuf1
    ld [wNameSlot], a
    call CopySlotNameToHL
    ret

; copies string wBattleActionId of category 4 (skill names) to wTextBuf1 (CopyStringHLToDE) (E-0116)
CopyActionSkillNameToTextBuf1::
    ld a, [wBattleActionId]
    ld l, a
    ld h, $04
    ld de, wTextBuf1
    call CopyStringHLToDE
    ret

; wNameSlot = wBattleTarget, then CopySlotNameToHL with HL = wTextBuf0 (E-0077)
CopyTargetNameToTextBuf0::
    ld a, [wBattleTarget]
    ld hl, wTextBuf0
    ld [wNameSlot], a
    call CopySlotNameToHL
    ret

; wNameSlot = wBattleTarget, then CopySlotNameToHL with HL = wTextBuf1 (E-0116)
CopyTargetNameToTextBuf1::
    ld a, [wBattleTarget]
    ld hl, wTextBuf1
    ld [wNameSlot], a
    call CopySlotNameToHL
    ret

; wNameSlot = wBattleTarget, then CopySlotNameToHL with HL = wTextBuf2 (E-0116)
CopyTargetNameToTextBuf2::
    ld a, [wBattleTarget]
    ld hl, wTextBuf2
    ld [wNameSlot], a
    call CopySlotNameToHL
    ret

; wTextBuf1 = wBattleDamage as a decimal string (WriteBCAsDecimalString) (E-0210)
WriteBattleDamageToTextBuf1::
    ld hl, wTextBuf1
    ld a, [wBattleDamageLo]
    ld c, a
    ld a, [wBattleDamageHi]
    ld b, a
    call WriteBCAsDecimalString
    ret

; wNameSlot = wBattleTarget & 4 (the first slot of the target's side), then CopySlotNameToHL with HL
; = wTextBuf0 (E-0113)
CopyTargetSideNameToTextBuf0::
    ld a, [wBattleTarget]
    and $04
    ld hl, wTextBuf0
    ld [wNameSlot], a
    call CopySlotNameToHL
    ret

; copies the name at wPlayerName (5 glyphs, CopyFiveGlyphsPlusMarks) to wTextBuf0 (E-0116)
CopyPlayerNameToTextBuf0::
    ld de, wPlayerName
    ld hl, wTextBuf0
    call CopyFiveGlyphsPlusMarks
    ret

; copies the name at wPlayerName (5 glyphs) to wTextBuf1 (E-0116)
CopyPlayerNameToTextBuf1::
    ld de, wPlayerName
    ld hl, wTextBuf1
    call CopyFiveGlyphsPlusMarks
    ret

; copies string wBattleActionId of category 5 (item names) to wTextBuf2 (CopyStringHLToDE) (E-0116)
CopyActionItemNameToTextBuf2::
    ld a, [wBattleActionId]
    ld l, a
    ld h, $05
    ld de, wTextBuf2
    call CopyStringHLToDE
    ret

; wNameSlot = wBattleActor & 4 (the first slot of the actor's side), then CopySlotNameToHL with HL =
; wTextBuf0 (E-0116)
CopyActorSideNameToTextBuf0::
    ld a, [wBattleActor]
    and $04
    ld hl, wTextBuf0
    ld [wNameSlot], a
    call CopySlotNameToHL
    ret

; A = battle slot: slots 0-2 go to CopyBattlerNameToHL; other slots take paths that check slot 3/7,
; wLinkMode and wSlotNameBytes (not fully read) (E-0077)
CopySlotNameToHL::
    cp $03
    jr nc, CopySlotNameToHL_HighSlot

; A = battle slot (0-2 or 4-6): copies the name at offset 0 of the slot's battler record (5 glyphs,
; CopyFiveGlyphsPlusMarks) to HL and leaves HL on the $F0 terminator; BC kept (E-0077)
CopyBattlerNameToHL::
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
    cp $f0
    ret z
    inc hl
    jr .skip

; In link mode 1 copies the battler record's name (CopyBattlerNameToHL). (C1, E-0357)
CopySlotNameToHL_LinkBattlerName::
    ld a, b
    pop bc
    jr CopyBattlerNameToHL

; A foe slot's name: slot 3 or 7, or one whose name byte is $FF, gets its species name with a letter
; when others share it; in link mode 1 the battler record's name; otherwise the battler name with a
; letter suffix. (C1, E-0357)
CopySlotNameToHL_HighSlot::
    push bc
    ld b, a
    and $03
    cp $03
    ld a, b
    pop bc
    jr z, .call_copy_slot_species_name_to_hl
    push bc
    ld b, a
    ld a, [wLinkMode]
    cp $01
    jr z, CopySlotNameToHL_LinkBattlerName
    push hl
    ld a, b
    and $03
    ld hl, wSlotNameBytes
    add_a_to_hl
    ld a, [hl]
    pop hl
    cp $ff
    jr nz, .restore
    ld a, b

.restore:
    pop bc
    jr nz, CopySlotNameToHL_BattlerNameWithLetter

.call_copy_slot_species_name_to_hl:
    push af
    call CopySlotSpeciesNameToHL
    pop af
    call CopySlotNameToHL_SpeciesLetter
    ret

; Copies slot A's species name (category = the high byte of wBattleMonsterId + 2, index = the low
; byte) to HL, keeping the slot and destination. (C1, E-0357)
CopySlotSpeciesNameToHL::
    ld [wBattleTempSlot], a
    push hl
    ld hl, wBattleMonsterId
    add a
    add_a_to_hl
    push bc
    ld a, [hli]
    ld c, a
    ld a, [hl]
    add $02
    ld h, a
    ld l, c
    pop bc
    pop de
    ld a, e
    ld [wBattleTempPtrLo], a
    ld a, d
    ld [wBattleTempPtrHi], a
    call CopyStringHLToDE
    ret

; Copies the battler's name and appends glyph $47 and, when another slot of the side has the same
; name byte, its letter by order (A $0A, B $0B, C $0C, also in wBattleArg1); otherwise wBattleArg1 =
; 0. (C1, E-0357)
CopySlotNameToHL_BattlerNameWithLetter::
    call CopyBattlerNameToHL
    ld a, $47
    ld [hli], a
    ld [hl], $f0
    push hl
    ld hl, wSlotNameBytes
    ld a, [wNameSlot]
    and $03
    cp $01
    jr z, .skip
    cp $02
    jr z, .skip2
    ld a, [hli]
    cp [hl]
    jr z, .restore
    inc hl
    cp [hl]
    jr z, .restore
    jr .clear_battle_arg1

.skip:
    ld a, [hli]
    cp [hl]
    jr z, .set_battle_arg1_to_0B
    ld a, [hli]
    cp [hl]
    jr z, .restore
    jr .clear_battle_arg1

.skip2:
    ld d, $00
    inc hl
    inc hl
    ld a, [hld]
    dec hl
    cp [hl]
    jr nz, .next
    inc d

.next:
    inc hl
    cp [hl]
    jr nz, .skip3
    inc d

.skip3:
    ld a, d
    or a
    jr z, .clear_battle_arg1
    cp $01
    jr z, .set_battle_arg1_to_0B
    pop hl
    ld a, $0c
    jr .set_battle_arg1

.restore:
    pop hl
    ld a, $0a
    jr .set_battle_arg1

.set_battle_arg1_to_0B:
    pop hl
    ld a, $0b

.set_battle_arg1:
    ld [wBattleArg1], a
    ld [hli], a
    ld [hl], $f0
    ret

.clear_battle_arg1:
    pop hl
    xor a
    ld [wBattleArg1], a
    ret

; When another foe slot has the same species, appends the letter $0A + the number of earlier ones to
; the species name. (C1, E-0357)
CopySlotNameToHL_SpeciesLetter::
    call ListSideMonsterIdsToTemp0
    inc b
    ld c, $04
    xor a
    ld [wTemp0], a
    ld a, [wBattleTempSlot]
    add a
    ld hl, wBattleMonsterId
    add_a_to_hl
    ld a, [hli]
    ld d, [hl]
    ld e, a

.loop:
    ld a, c
    add a
    ld hl, wBattleMonsterId
    add_a_to_hl
    ld a, [hli]
    cp e
    jr nz, .next
    ld a, [hl]
    cp d
    jr nz, .next
    ld a, [wBattleTempSlot]
    cp c
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
    or a
    jr nz, .read_battle_temp_ptr_lo
    inc c

.loop2:
    ld a, c
    add a
    ld hl, wBattleMonsterId
    add_a_to_hl
    ld a, [hli]
    cp e
    jr nz, .next2
    ld a, [hl]
    cp d
    jr z, .read_battle_temp_ptr_lo

.next2:
    inc c
    dec b
    jr nz, .loop2
    ret

.read_battle_temp_ptr_lo:
    ld a, [wBattleTempPtrLo]
    ld l, a
    ld a, [wBattleTempPtrHi]
    ld h, a
    ld a, [wTemp0]
    add $0a
    push af

.skip:
    ld a, [hl]
    cp $f0
    jr z, .restore
    inc hl
    jr .skip

.restore:
    pop af
    ld [hli], a
    ld a, $f0
    ld [hl], a
    ret

; clears wTemp0 ($10 bytes) and lists the species ids of the occupied slots of the shown side at
; wTemp0 and of the other side at wPauseMenuStep (E-0129) (E-0340: the address in its name read as
; its RAM name; was ListSideMonsterIdsToTemp0)
ListSideMonsterIdsToTemp0::
    xor a
    ld hl, wTemp0
    ld bc, $0010
    call FillBytes
    ld de, $0000
    ld c, $00
    ld a, [wLinkMode]
    cp $01
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
    add a
    ld hl, wTemp0
    add_a_to_hl
    push de
    ld a, c
    add a
    ld de, wBattleMonsterId
    add e
    ld e, a
    jr nc, .skip
    inc d

.skip:
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    pop de
    inc e

.next:
    inc c
    dec b
    jr nz, .loop
    ld c, $04
    ld a, [wLinkMode]
    cp $01
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
    add a
    ld hl, wPauseMenuStep
    add_a_to_hl
    push de
    ld a, c
    add a
    ld de, wBattleMonsterId
    add e
    ld e, a
    jr nc, .skip2
    inc d

.skip2:
    ld a, [de]
    ld [hli], a
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

; Ironize's text: D = $47 for a foe outside link mode 1 or a side of one species, otherwise $46.
; (C1, E-0357)
ActionEffect_Ironize_Text::
    ld a, [wLinkMode]
    cp $01
    jr z, .call_list_side_monster_ids_to_temp0
    ld a, [wBattleTarget]
    cp $04
    jr c, .call_list_side_monster_ids_to_temp0

.loop:
    ld d, $47
    ret

.call_list_side_monster_ids_to_temp0:
    call ListSideMonsterIdsToTemp0
    ld a, e
    cp $01
    jr z, .loop
    ld d, $46
    ret

; writes the glyphs of 'Monsters' (decoded with the charmap) and $F0 to wTextBuf0 (E-0113)
WriteMonstersWordToTextBuf0::
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
    ld [hl], $f0
    ret

; Lists the far side's three slots (4-6, or 0-2 for the link follower) that are present (or fallen,
; with wBattleArg1 set) in wSlotChoices and shows their names in three windows at VRAM $96D0, $9770
; and $8810. (C1, E-0357)
ListFarSideSlots::
    ld a, $ff
    ld hl, wSlotChoices
    ld bc, $0003
    call FillBytes
    ld a, [wLinkMode]
    cp $01
    jr z, .read_link_role
    ld c, $04
    jr .skip

.read_link_role:
    ld a, [wLinkRole]
    sla a
    and $04
    xor $04
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
    or a
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
    ld hl, vTiles1 + $6d0
    call ListFarSideSlots_ShowSlotName
    ld hl, vTiles1 + $770
    ld a, [wSlotChoices + $1]
    call ListFarSideSlots_ShowSlotName
    ld hl, vTiles2 + $10
    ld a, [wSlotChoices + $2]

; Shows slot A's name (string 5 of category 8 through wTextBuf0) or, for $FF, string 0 of category
; 2, in a 10 x 1 window at HL, keeping the text window. (C1, E-0357)
ListFarSideSlots_ShowSlotName::
    cp $ff
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
    ld de, $0a01
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
    db $21, $ff, $d8, $18, $28, $21, $0f, $d9, $18, $23

; A = battle slot: HL = the word for that slot at wBattleMaxHP; A = its low byte (E-0064)
GetBattleMaxHP_Bank3A::
    ld hl, wBattleMaxHP
    jr GetBattleStatWord_Bank3A

; A = battle slot: HL = the word for that slot at wBattleMaxMP; A = its low byte (E-0064)
GetBattleMaxMP_Bank3A::
    ld hl, wBattleMaxMP
    jr GetBattleStatWord_Bank3A
    db $21, $bf, $d8, $18, $14

; A = battle slot: HL = the word for that slot at wBattleMP; A = its low byte (E-0064)
GetBattleMP_Bank3A::
    ld hl, wBattleMP
    jr GetBattleStatWord_Bank3A
    db $21, $1f, $d9, $18, $0a, $21, $53, $da, $85, $6f, $30, $01, $24, $7e, $c9

; HL = word A of the array at HL. (C1, E-0357)
GetBattleStatWord_Bank3A::
    add a
    add_a_to_hl
    deref_hl
    ret

; HL += 2 * A (A is doubled in 8 bits first, so it wraps above $7F); clobbers A (the same 7 bytes
; appear in 12 banks) (E-0353)
AddDoubleAToHL_Bank3A::
    add a
    add_a_to_hl
    ret

; carry set when wBattleActor < 4 (slots 0-3); when wLinkMode = 1 and wLinkRole bit 1 is set the
; test is reversed (carry set when wBattleActor >= 4). Which side is local is inferred from the
; reversal, not checked (E-0064) (the same 27 bytes appear in 12 banks)
ActorOnLocalSide_Bank3A::
    ld a, [wLinkMode]
    cp $01
    jr nz, .check_battle_actor
    ld a, [wLinkRole]
    bit 1, a
    jr z, .check_battle_actor
    ld a, [wBattleActor]
    cp $04
    ccf
    ret

.check_battle_actor:
    ld a, [wBattleActor]
    cp $04
    ret

; carry set when wBattleTarget < 4 (slots 0-3); when wLinkMode = 1 and wLinkRole bit 1 is set the
; test is reversed (carry set when wBattleTarget >= 4) (E-0064) (the same 27 bytes appear in 12
; banks)
TargetOnLocalSide_Bank3A::
    ld a, [wLinkMode]
    cp $01
    jr nz, .check_battle_target
    ld a, [wLinkRole]
    bit 1, a
    jr z, .check_battle_target
    ld a, [wBattleTarget]
    cp $04
    ccf
    ret

.check_battle_target:
    ld a, [wBattleTarget]
    cp $04
    ret

; ANDs status byte 0 of slot E with entry D of ClearBattleStatusBitsWithMaskD_Bank3A_Data. (C1,
; E-0357)
ClearBattleStatusBitsWithMaskD_Bank3A::
    ld a, d
    ld hl, ClearBattleStatusBitsWithMaskD_Bank3A_Data
    add_a_to_hl
    ld d, [hl]
    ld a, e
    ld hl, wBattleStatus
    call AddAx9ToHL
    ld a, d
    and [hl]
    ld [hl], a
    ret

; Seven AND masks for status byte 0 of a battle slot, selected by register D (0-6).
; ClearBattleStatusBitsWithMaskD_Bank3A ANDs the byte of slot E with entry D: $DF clears
; BSTAT0_CURSED, $FE BSTAT0_POISONED, $00 the whole byte, $FD BSTAT0_BADLY_POISONED, $73 the two
; sleep-counter bits and BSTAT0_ASLEEP (bits 2, 3 and 7), $EF BSTAT0_CONFUSED and $BF
; BSTAT0_PARALYZED. This bank copy has no direct caller; identical tables exist in several other
; battle banks. (C1, E-0381)
ClearBattleStatusBitsWithMaskD_Bank3A_Data::
    db $df, $fe, $00, $fd, $73, $ef, $bf

; Sets bit 0 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks) (E-0353)
SetBit0OfLevelUpGainsIndexed_Bank3A::
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 0, [hl]
    pop hl
    ret

; Sets bit 1 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks) (E-0353)
SetBit1OfLevelUpGainsIndexed_Bank3A::
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 1, [hl]
    pop hl
    ret

; Sets bit 2 of the byte at wLevelUpGains + A; keeps HL; clobbers A (the same 13 bytes appear in 12
; banks) (E-0353)
SetBit2OfLevelUpGainsIndexed_Bank3A::
    push hl
    ld hl, wLevelUpGains
    add_a_to_hl
    set 2, [hl]
    pop hl
    ret

; A = slot 0-7: returns A = 9 * g(wSlotPersonalityHi[A]) + 3 * g(wSlotPersonalityMid[A]) +
; g(wSlotPersonalityLo[A]) with g(v) = 0 for v >= $C0, 1 for v >= $40, else 2 (the same index
; PersonalityIndexOfRecord builds from a save record; E-0031); HL and BC are kept (the same 87 bytes
; appear in 13 banks)
PersonalityIndexOfSlot_Bank3A::
    push hl
    push bc
    ld c, a
    ld b, $00
    ld hl, wSlotPersonalityHi
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp $c0
    jr nc, .skip
    ld l, $09
    cp $40
    jr nc, .skip
    ld l, $12

.skip:
    ld a, l
    add b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityMid
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp $c0
    jr nc, .skip2
    ld l, $03
    cp $40
    jr nc, .skip2
    ld l, $06

.skip2:
    ld a, l
    add b
    ld b, a
    ld a, c
    ld hl, wSlotPersonalityLo
    add_a_to_hl
    ld a, [hl]
    ld l, $00
    cp $c0
    jr nc, .skip3
    ld l, $01
    cp $40
    jr nc, .skip3
    ld l, $02

.skip3:
    ld a, l
    add b
    pop bc
    pop hl
    ret

; A = slot: carry set when CheckSlotStatusBlock sets it, or when status byte 3 & $C0 or byte 4 & $0C
; is set (wBattleStatus3 + 9 * A); otherwise carry clear; A, BC, HL kept (E-0067) (the same 31 bytes
; appear in 12 banks)
CheckSlotStatusBlockWide_Bank3A::
    call CheckSlotStatusBlock
    ret c
    push hl
    push bc
    ld c, a
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hli]
    and $c0
    jr nz, .set_carry
    ld a, [hl]
    and $0c
    jr nz, .set_carry
    xor a
    jr .skip

.set_carry:
    scf

.skip:
    ld a, c
    pop bc
    pop hl
    ret

; A = slot: with HL = wBattleStatus3 + 9 * A (status byte 3 of wBattleStatus), A = byte 3 & $C0, or
; byte 4 & $0C when that is zero; Z set when both are clear; HL kept (E-0067) (the same 17 bytes
; appear in 13 banks)
SlotHasStatus3Or4Bits_Bank3A::
    push hl
    ld hl, wBattleStatus3
    call AddAx9ToHL
    ld a, [hli]
    and $c0
    jr nz, .done
    ld a, [hl]
    and $0c

.done:
    pop hl
    ret

; LoadEffectOBJPaletteC copies the 8 bytes at $7D9A + 8 * C to wOBJPaletteBuffer on CGB; 59 whole
; palettes lie before the label at $7F79 (E-0173, C1)
; record: one CGB OBJ palette: 4 BGR555 colours
EffectOBJPalettes::
    dw $0000, $02ff, $0017, $01df ; id 0
    dw $0000, $02ff, $0017, $01df ; id 1
    dw $0000, $02ff, $0017, $01df ; id 2
    dw $0000, $035f, $001f, $01ff ; id 3
    dw $0000, $035f, $001f, $01ff ; id 4
    dw $0000, $035f, $001f, $01ff ; id 5
    dw $0000, $7fff, $02ff, $3dd3 ; id 6
    dw $0000, $7fff, $02ff, $3dd3 ; id 7
    dw $0000, $7fff, $02ff, $4daf ; id 8
    dw $0000, $4bff, $55f3, $3d6d ; id 9
    dw $0000, $4bff, $55f3, $3d6d ; id 10
    dw $0000, $4bff, $55f3, $3d6d ; id 11
    dw $0000, $7f34, $5a0c, $7dc0 ; id 12
    dw $0000, $7f34, $5a0c, $7dc0 ; id 13
    dw $0000, $7f34, $5a0c, $7dc0 ; id 14
    dw $0000, $03ff, $55f3, $3d6d ; id 15
    dw $0000, $03ff, $55f3, $3d6d ; id 16
    dw $0000, $03ff, $55f3, $3d6d ; id 17
    dw $0000, $2ddf, $4ab8, $7df2 ; id 18
    dw $0000, $4be0, $02ff, $7dc8 ; id 19
    dw $0000, $02ff, $60b9, $0000 ; id 20
    dw $0000, $4b1c, $3d7b, $0000 ; id 21
    dw $0000, $4be0, $7e3f, $64f3 ; id 22
    dw $0000, $56b2, $1e37, $64f3 ; id 23
    dw $0000, $4b1c, $119f, $20b1 ; id 24
    dw $0000, $5f72, $7d37, $20b1 ; id 25
    dw $0000, $6bf5, $5a0c, $7dc8 ; id 26
    dw $0000, $4b1c, $1df4, $00e9 ; id 27
    dw $0000, $02ff, $00ff, $00b1 ; id 28
    dw $0000, $4bff, $017f, $0000 ; id 29
    dw $0000, $4bff, $017f, $0000 ; id 30
    dw $0000, $03ff, $55f3, $3d6d ; id 31
    dw $0000, $4bff, $55f3, $3d6d ; id 32
    dw $0000, $7f34, $5a0c, $7dc0 ; id 33
    dw $0000, $4b1c, $1df4, $00e9 ; id 34
    dw $0000, $375f, $01dd, $00e9 ; id 35
    dw $0000, $5fff, $6beb, $00e9 ; id 36
    dw $0000, $5fff, $01df, $00e9 ; id 37
    dw $0000, $7f59, $7d37, $00e9 ; id 38
    dw $0000, $5fff, $02ff, $01df ; id 39
    dw $0000, $339f, $50cb, $4c1a ; id 40
    dw $0000, $47ff, $0a9c, $00e9 ; id 41
    dw $0000, $63f9, $01df, $0015 ; id 42
    dw $0000, $7ffb, $6e21, $72ab ; id 43
    dw $0000, $7fff, $7fff, $013b ; id 44
    dw $0000, $7fe8, $7cc0, $4520 ; id 45
    dw $0000, $7fe8, $7cc0, $48d1 ; id 46
    dw $0000, $7fe8, $7cc0, $48d1 ; id 47
    dw $0000, $7fe8, $7cc0, $0000 ; id 48
    dw $0000, $7fe8, $7cc0, $0000 ; id 49
    dw $0000, $5ff2, $7ccb, $0000 ; id 50
    dw $0000, $03ff, $55f3, $3d6d ; id 51
    dw $0000, $7fff, $7e59, $002b ; id 52
    dw $0000, $7fe8, $7cc0, $48d1 ; id 53
    dw $0000, $7f59, $7d37, $3d6d ; id 54
    dw $0000, $4b1c, $1df4, $00e9 ; id 55
    dw $0000, $7f59, $7d37, $3d6d ; id 56
    dw $0000, $63ff, $01df, $0015 ; id 57
    dw $0000, $63ff, $01df, $0015 ; id 58
    db $00, $00, $fd, $03, $df, $01, $15
    ds $87, $00
